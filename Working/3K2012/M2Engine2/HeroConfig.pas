unit HeroConfig;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ComCtrls, StdCtrls, Spin, Grids;

type
  TLevelExpScheme = (s_OldLevelExp, s_StdLevelExp, s_2Mult, s_5Mult, s_8Mult, s_10Mult, s_20Mult, s_30Mult, s_40Mult, s_50Mult, s_60Mult, s_70Mult, s_80Mult, s_90Mult, s_100Mult, s_150Mult, s_200Mult, s_250Mult, s_300Mult);
  TfrmHeroConfig = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    GroupBoxLevelExp: TGroupBox;
    Label37: TLabel;
    ComboBoxLevelExp: TComboBox;
    GridLevelExp: TStringGrid;
    GroupBox8: TGroupBox;
    Label23: TLabel;
    EditKillMonExpRate: TSpinEdit;
    GroupBox29: TGroupBox;
    Label61: TLabel;
    EditStartLevel: TSpinEdit;
    GroupBox59: TGroupBox;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    SpinEditWarrorAttackTime: TSpinEdit;
    SpinEditWizardAttackTime: TSpinEdit;
    SpinEditTaoistAttackTime: TSpinEdit;
    ButtonHeroExpSave: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    SpinEditNeedLevel: TSpinEdit;
    ComboBoxBagItemCount: TComboBox;
    TabSheet2: TTabSheet;
    GroupBox67: TGroupBox;
    CheckBoxKillByMonstDropUseItem: TCheckBox;
    CheckBoxKillByHumanDropUseItem: TCheckBox;
    CheckBoxDieScatterBag: TCheckBox;
    CheckBoxDieRedScatterBagAll: TCheckBox;
    GroupBox69: TGroupBox;
    Label130: TLabel;
    Label2: TLabel;
    Label134: TLabel;
    ScrollBarDieDropUseItemRate: TScrollBar;
    EditDieDropUseItemRate: TEdit;
    ScrollBarDieRedDropUseItemRate: TScrollBar;
    EditDieRedDropUseItemRate: TEdit;
    ScrollBarDieScatterBagRate: TScrollBar;
    EditDieScatterBagRate: TEdit;
    ButtonHeroDieSave: TButton;
    TabSheet3: TTabSheet;
    ButtonHeroAttackSave: TButton;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    EditWinExp: TSpinEdit;
    Label11: TLabel;
    EditExpAddLoyal: TSpinEdit;
    Label12: TLabel;
    EditDeathDecLoyal: TSpinEdit;
    GroupBox6: TGroupBox;
    Label14: TLabel;
    EditGotoLV4: TSpinEdit;
    Label15: TLabel;
    EditPowerLv4: TSpinEdit;
    PageControl1: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditMaxFirDragonPoint: TSpinEdit;
    EditAddFirDragonPoint: TSpinEdit;
    EditDecFirDragonPoint: TSpinEdit;
    GroupBox9: TGroupBox;
    Label17: TLabel;
    EditHeroAttackRate_61: TSpinEdit;
    GroupBox10: TGroupBox;
    Label18: TLabel;
    EditHeroAttackRate_62: TSpinEdit;
    GroupBox11: TGroupBox;
    Label19: TLabel;
    EditHeroAttackRate_63: TSpinEdit;
    GroupBox12: TGroupBox;
    Label20: TLabel;
    EditHeroAttackRate_64: TSpinEdit;
    GroupBox13: TGroupBox;
    Label21: TLabel;
    EditHeroAttackRate_65: TSpinEdit;
    GroupBox52: TGroupBox;
    Label135: TLabel;
    EditHeroAttackRate_60: TSpinEdit;
    GroupBox15: TGroupBox;
    Label16: TLabel;
    EditHeroAttackRange_65: TSpinEdit;
    GroupBox7: TGroupBox;
    Label22: TLabel;
    EditHeroAttackRange_63: TSpinEdit;
    GroupBox14: TGroupBox;
    Label27: TLabel;
    Label29: TLabel;
    EditHeroWalkIntervalTime: TSpinEdit;
    EditHeroTurnIntervalTime: TSpinEdit;
    Label28: TLabel;
    EditPKDecLoyal: TSpinEdit;
    Label30: TLabel;
    EditGuildIncLoyal: TSpinEdit;
    Label31: TLabel;
    EditLevelOrderIncLoyal: TSpinEdit;
    Label32: TLabel;
    EditLevelOrderDecLoyal: TSpinEdit;
    Label33: TLabel;
    SpinEdit1: TSpinEdit;
    GroupBox17: TGroupBox;
    LabelHeroNameColor: TLabel;
    EditHeroNameColor: TSpinEdit;
    Label65: TLabel;
    Label24: TLabel;
    Label35: TLabel;
    CheckNameSuffix: TCheckBox;
    EdtHeroName: TEdit;
    EditHeroNameSuffix: TEdit;
    GroupBox18: TGroupBox;
    Label36: TLabel;
    EditHeroAttackRange_60: TSpinEdit;
    GroupBox46: TGroupBox;
    Label89: TLabel;
    Label90: TLabel;
    EditMakeGhostHeroTime: TSpinEdit;
    Label38: TLabel;
    EditDrinkHeroStartLevel: TSpinEdit;
    EditHeroMagicHitIntervalTime: TSpinEdit;
    Label39: TLabel;
    CheckBoxHeroProtect: TCheckBox;
    TabSheet11: TTabSheet;
    PageControl2: TPageControl;
    TabSheet12: TTabSheet;
    GroupBox19: TGroupBox;
    ButtonHeroSkillSave: TButton;
    RadioHeroSkillMode: TRadioButton;
    RadioHeroSkillModeAll: TRadioButton;
    CheckBoxHeroDieExp: TCheckBox;
    SpinEditHeroDieExpRate: TSpinEdit;
    Label41: TLabel;
    Label42: TLabel;
    SpinEditIncDragonPointTick: TSpinEdit;
    TabSheet13: TTabSheet;
    GroupBox20: TGroupBox;
    CheckBoxHeroNoTargetCall: TCheckBox;
    GroupBox21: TGroupBox;
    Label43: TLabel;
    SpinEditDecDragonHitPoint: TSpinEdit;
    Label44: TLabel;
    GroupBox24: TGroupBox;
    Label46: TLabel;
    Label47: TLabel;
    EditDecDragonRate: TSpinEdit;
    TabSheet15: TTabSheet;
    GroupBox25: TGroupBox;
    RadioHeroSkillMode50: TRadioButton;
    RadioHeroSkillMode50All: TRadioButton;
    TabSheet16: TTabSheet;
    GroupBox26: TGroupBox;
    Label48: TLabel;
    SpinEditHeroSkill46MaxHP_0: TSpinEdit;
    Label3: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    GroupBox28: TGroupBox;
    RadioHeroSkillMode_63ALL: TRadioButton;
    RadioHeroSkillMode_63: TRadioButton;
    GroupBox27: TGroupBox;
    RadioHeroSkillMode46: TRadioButton;
    RadioHeroSkillMode46All: TRadioButton;
    CheckBoxHeroRestNoFollow: TCheckBox;
    GroupBox30: TGroupBox;
    Label9: TLabel;
    EditHeroAttackRange_64: TSpinEdit;
    GroupBox79: TGroupBox;
    Label159: TLabel;
    SpinEditHeroMakeSelfTick: TSpinEdit;
    Label13: TLabel;
    SpinEditHeroSkill46MaxHP_1: TSpinEdit;
    Label49: TLabel;
    SpinEditHeroSkill46MaxHP_2: TSpinEdit;
    Label55: TLabel;
    Label56: TLabel;
    SpinEditHeroSkill46MaxHP_3: TSpinEdit;
    CheckBoxHeroAttackTarget: TCheckBox;
    TabSheet17: TTabSheet;
    GroupBox31: TGroupBox;
    RadioHeroSkillMode43: TRadioButton;
    RadioHeroSkillMode43All: TRadioButton;
    CheckBoxHeroAttackTao: TCheckBox;
    GroupBox32: TGroupBox;
    SpinEditHeroHPRate: TSpinEdit;
    Label57: TLabel;
    Label58: TLabel;
    SpinEditHeroHPRate1: TSpinEdit;
    Label59: TLabel;
    SpinEditHeroHPRate2: TSpinEdit;
    EditHeroRunIntervalTime: TSpinEdit;
    Label26: TLabel;
    GroupBox16: TGroupBox;
    Label25: TLabel;
    SpinEditHeroSkill43HPRate: TSpinEdit;
    CheckBoxProtectPickUpItem: TCheckBox;
    Label45: TLabel;
    EditNoEditKillMonExpRate: TSpinEdit;
    CheckBoxHeroAttackNoFollow: TCheckBox;
    TabSheet18: TTabSheet;
    Label34: TLabel;
    SpinEditHeroProtectLevel: TSpinEdit;
    Button1: TButton;
    Label60: TLabel;
    SpinEditHeroMakeSelfTick1: TSpinEdit;
    Label62: TLabel;
    SpinEditHeroMakeSelfTick2: TSpinEdit;
    Label63: TLabel;
    SpinEditHeroMakeSelfTick3: TSpinEdit;
    TabSheet19: TTabSheet;
    GroupBox23: TGroupBox;
    GridHeroPulsLevelExp: TStringGrid;
    Button2: TButton;
    GroupBox111: TGroupBox;
    Label233: TLabel;
    EditKillMonHeroPulsExpMultiple: TSpinEdit;
    GroupBox126: TGroupBox;
    Label267: TLabel;
    EditHeroUseBatterTick: TSpinEdit;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    EditHeroRecallTick: TSpinEdit;
    Label8: TLabel;
    EditDeputyHeroRecallTick: TSpinEdit;
    GroupBox22: TGroupBox;
    Label64: TLabel;
    EditStrength1DecGold: TSpinEdit;
    EditStrength1DecGameGird: TSpinEdit;
    EditStrength1Exp: TSpinEdit;
    Label66: TLabel;
    EditStrength2DecGold: TSpinEdit;
    EditStrength2DecGameGird: TSpinEdit;
    EditStrength2Exp: TSpinEdit;
    Label67: TLabel;
    EditStrength3DecGold: TSpinEdit;
    EditStrength3DecGameGird: TSpinEdit;
    EditStrength3Exp: TSpinEdit;
    Label68: TLabel;
    EditDeputyHeroExpRate: TSpinEdit;
    GroupBox2: TGroupBox;
    Label124: TLabel;
    Label125: TLabel;
    Label40: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    SpinEditEatHPItemRate: TSpinEdit;
    SpinEditEatMPItemRate: TSpinEdit;
    SpinEditEatItemTick: TSpinEdit;
    SpinEditEatItemTick1: TSpinEdit;
    SpinEditEatHPItemRate1: TSpinEdit;
    SpinEditEatMPItemRate1: TSpinEdit;
    Label69: TLabel;
    SpinEditEatItemTickA: TSpinEdit;
    Label70: TLabel;
    SpinEditEatItemTickB: TSpinEdit;
    Label71: TLabel;
    Edit4SKillDecNH: TSpinEdit;
    Label72: TLabel;
    Edit4SKillDecMP: TSpinEdit;
    CheckBoxAutoHeroUseEat: TCheckBox;
    Label73: TLabel;
    EditHeroRunIntervalTime1: TSpinEdit;
    CheckBoxStopProtectOnChangMap: TCheckBox;
    procedure ComboBoxLevelExpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonHeroExpSaveClick(Sender: TObject);
    procedure EditStartLevelChange(Sender: TObject);
    procedure EditKillMonExpRateChange(Sender: TObject);
    procedure ComboBoxBagItemCountChange(Sender: TObject);
    procedure SpinEditNeedLevelChange(Sender: TObject);
    procedure SpinEditWarrorAttackTimeChange(Sender: TObject);
    procedure SpinEditWizardAttackTimeChange(Sender: TObject);
    procedure SpinEditTaoistAttackTimeChange(Sender: TObject);
    procedure ButtonHeroDieSaveClick(Sender: TObject);
    procedure CheckBoxKillByMonstDropUseItemClick(Sender: TObject);
    procedure CheckBoxKillByHumanDropUseItemClick(Sender: TObject);
    procedure CheckBoxDieScatterBagClick(Sender: TObject);
    procedure CheckBoxDieRedScatterBagAllClick(Sender: TObject);
    procedure ScrollBarDieDropUseItemRateChange(Sender: TObject);
    procedure ScrollBarDieRedDropUseItemRateChange(Sender: TObject);
    procedure ScrollBarDieScatterBagRateChange(Sender: TObject);
    procedure SpinEditEatHPItemRateChange(Sender: TObject);
    procedure SpinEditEatMPItemRateChange(Sender: TObject);
    procedure ButtonHeroAttackSaveClick(Sender: TObject);
    procedure EditMaxFirDragonPointChange(Sender: TObject);
    procedure EditAddFirDragonPointChange(Sender: TObject);
    procedure EditDecFirDragonPointChange(Sender: TObject);
    procedure EditHeroAttackRate_60Change(Sender: TObject);
    procedure EditHeroRecallTickChange(Sender: TObject);
    procedure EditDeathDecLoyalChange(Sender: TObject);
    procedure EditWinExpChange(Sender: TObject);
    procedure EditExpAddLoyalChange(Sender: TObject);
    procedure EditGotoLV4Change(Sender: TObject);
    procedure EditPowerLv4Change(Sender: TObject);
    procedure EditHeroAttackRate_61Change(Sender: TObject);
    procedure EditHeroAttackRate_62Change(Sender: TObject);
    procedure EditHeroAttackRate_63Change(Sender: TObject);
    procedure EditHeroAttackRate_64Change(Sender: TObject);
    procedure EditHeroAttackRate_65Change(Sender: TObject);
    procedure EditHeroAttackRange_65Change(Sender: TObject);
    procedure EditHeroAttackRange_63Change(Sender: TObject);
    procedure EditHeroRunIntervalTimeChange(Sender: TObject);
    procedure EditHeroWalkIntervalTimeChange(Sender: TObject);
    procedure EditHeroTurnIntervalTimeChange(Sender: TObject);
    procedure EditPKDecLoyalChange(Sender: TObject);
    procedure EditGuildIncLoyalChange(Sender: TObject);
    procedure EditLevelOrderIncLoyalChange(Sender: TObject);
    procedure EditLevelOrderDecLoyalChange(Sender: TObject);
    procedure EditHeroNameColorChange(Sender: TObject);
    procedure CheckNameSuffixClick(Sender: TObject);
    procedure EdtHeroNameChange(Sender: TObject);
    procedure EditHeroNameSuffixChange(Sender: TObject);
    procedure EditHeroAttackRange_60Change(Sender: TObject);
    procedure EditMakeGhostHeroTimeChange(Sender: TObject);
    procedure EditDrinkHeroStartLevelChange(Sender: TObject);
    procedure EditHeroMagicHitIntervalTimeChange(Sender: TObject);
    procedure SpinEditEatItemTickChange(Sender: TObject);
    procedure CheckBoxHeroProtectClick(Sender: TObject);
    procedure ButtonHeroSkillSaveClick(Sender: TObject);
    procedure RadioHeroSkillModeClick(Sender: TObject);
    procedure RadioHeroSkillModeAllClick(Sender: TObject);
    procedure CheckBoxHeroDieExpClick(Sender: TObject);
    procedure SpinEditHeroDieExpRateChange(Sender: TObject);
    procedure SpinEditIncDragonPointTickChange(Sender: TObject);
    procedure CheckBoxHeroNoTargetCallClick(Sender: TObject);
    procedure SpinEditDecDragonHitPointChange(Sender: TObject);
    procedure GridLevelExpSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure EditNoEditKillMonExpRateChange(Sender: TObject);
    procedure EditDecDragonRateChange(Sender: TObject);
    procedure RadioHeroSkillMode50Click(Sender: TObject);
    procedure RadioHeroSkillMode50AllClick(Sender: TObject);
    procedure SpinEditHeroSkill46MaxHP_0Change(Sender: TObject);
    procedure SpinEditEatItemTick1Change(Sender: TObject);
    procedure SpinEditEatHPItemRate1Change(Sender: TObject);
    procedure SpinEditEatMPItemRate1Change(Sender: TObject);
    procedure RadioHeroSkillMode_63Click(Sender: TObject);
    procedure RadioHeroSkillMode_63ALLClick(Sender: TObject);
    procedure RadioHeroSkillMode46Click(Sender: TObject);
    procedure RadioHeroSkillMode46AllClick(Sender: TObject);
    procedure CheckBoxHeroRestNoFollowClick(Sender: TObject);
    procedure EditHeroAttackRange_64Change(Sender: TObject);
    procedure SpinEditHeroMakeSelfTickChange(Sender: TObject);
    procedure SpinEditHeroSkill46MaxHP_1Change(Sender: TObject);
    procedure SpinEditHeroSkill46MaxHP_2Change(Sender: TObject);
    procedure SpinEditHeroSkill46MaxHP_3Change(Sender: TObject);
    procedure CheckBoxHeroAttackTargetClick(Sender: TObject);
    procedure SpinEditHeroHPRateChange(Sender: TObject);
    procedure RadioHeroSkillMode43Click(Sender: TObject);
    procedure RadioHeroSkillMode43AllClick(Sender: TObject);
    procedure CheckBoxHeroAttackTaoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinEditHeroHPRate1Change(Sender: TObject);
    procedure SpinEditHeroHPRate2Change(Sender: TObject);
    procedure SpinEditHeroSkill43HPRateChange(Sender: TObject);
    procedure CheckBoxProtectPickUpItemClick(Sender: TObject);
    procedure CheckBoxHeroAttackNoFollowClick(Sender: TObject);
    procedure SpinEditHeroProtectLevelChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpinEditHeroMakeSelfTick1Change(Sender: TObject);
    procedure SpinEditHeroMakeSelfTick2Change(Sender: TObject);
    procedure SpinEditHeroMakeSelfTick3Change(Sender: TObject);
    procedure GridHeroPulsLevelExpEnter(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EditKillMonHeroPulsExpMultipleChange(Sender: TObject);
    procedure EditHeroUseBatterTickChange(Sender: TObject);
    procedure EditDeputyHeroRecallTickChange(Sender: TObject);
    procedure EditStrength1DecGoldChange(Sender: TObject);
    procedure EditStrength2DecGoldChange(Sender: TObject);
    procedure EditStrength3DecGoldChange(Sender: TObject);
    procedure EditStrength1DecGameGirdChange(Sender: TObject);
    procedure EditStrength2DecGameGirdChange(Sender: TObject);
    procedure EditStrength3DecGameGirdChange(Sender: TObject);
    procedure EditStrength1ExpChange(Sender: TObject);
    procedure EditStrength2ExpChange(Sender: TObject);
    procedure EditStrength3ExpChange(Sender: TObject);
    procedure EditDeputyHeroExpRateChange(Sender: TObject);
    procedure SpinEditEatItemTickAChange(Sender: TObject);
    procedure SpinEditEatItemTickBChange(Sender: TObject);
    procedure Edit4SKillDecNHChange(Sender: TObject);
    procedure Edit4SKillDecMPChange(Sender: TObject);
    procedure CheckBoxAutoHeroUseEatClick(Sender: TObject);
    procedure EditHeroRunIntervalTime1Change(Sender: TObject);
    procedure CheckBoxStopProtectOnChangMapClick(Sender: TObject);
  private
    { Private declarations }
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
  public
    { Public declarations }
    procedure Open();
  end;

var
  frmHeroConfig: TfrmHeroConfig;

implementation
uses M2Share, HUtil32, Grobal2;
{$R *.dfm}

procedure TfrmHeroConfig.ModValue();
begin
  boModValued := True;
  ButtonHeroExpSave.Enabled := True;
  ButtonHeroDieSave.Enabled := True;
  ButtonHeroAttackSave.Enabled := True;
  ButtonHeroSkillSave.Enabled := True;
  Button1.Enabled := True;
  Button2.Enabled := True;
end;

procedure TfrmHeroConfig.uModValue();
begin
  boModValued := False;
  ButtonHeroExpSave.Enabled := False;
  ButtonHeroDieSave.Enabled := False;
  ButtonHeroAttackSave.Enabled := False;
  ButtonHeroSkillSave.Enabled := False;
  Button1.Enabled := False;
  Button2.Enabled := False;
end;

procedure TfrmHeroConfig.ComboBoxLevelExpClick(Sender: TObject);
var
  I: Integer;
  LevelExpScheme: TLevelExpScheme;
  dwOneLevelExp: LongWord;
  dwExp: LongWord;
begin
  if not boOpened then Exit;
  if Application.MessageBox('升级经验计划设置的经验将立即生效，是否确认使用此经验计划？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDNO then begin
    Exit;
  end;

  LevelExpScheme := TLevelExpScheme(ComboBoxLevelExp.Items.Objects[ComboBoxLevelExp.ItemIndex]);
  case LevelExpScheme of
    s_OldLevelExp: g_Config.dwHeroNeedExps := g_dwOldNeedExps;
    s_StdLevelExp: begin
        g_Config.dwHeroNeedExps := g_dwOldNeedExps;
        dwOneLevelExp := 4000000000 div High(g_Config.dwHeroNeedExps);
        for I := 1 to MAXCHANGELEVEL do begin
          if (26 + I) > MAXCHANGELEVEL then Break;
          dwExp := dwOneLevelExp * LongWord(I);
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[26 + I] := dwExp;
        end;
      end;
    s_2Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 2;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_5Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 5;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_8Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 8;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_10Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 10;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_20Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 20;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_30Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 30;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_40Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 40;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_50Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 50;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_60Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 60;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_70Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 70;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_80Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 80;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_90Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 90;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_100Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 100;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_150Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 150;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_200Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 200;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_250Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 250;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
    s_300Mult: begin
        for I := 1 to MAXCHANGELEVEL do begin
          dwExp := g_Config.dwHeroNeedExps[I] div 300;
          if dwExp = 0 then dwExp := 1;
          g_Config.dwHeroNeedExps[I] := dwExp;
        end;
      end;
  end;
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[1, I] := IntToStr(g_Config.dwHeroNeedExps[I]);
  end;
  ModValue();
end;

procedure TfrmHeroConfig.Open();
var
  I: Integer;
  s01: string;
begin
  boOpened := False;
  PageControl.ActivePageIndex := 0;
  uModValue();

  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[1, I] := IntToStr(g_Config.dwHeroNeedExps[I]);
  end;
  GroupBoxLevelExp.Caption := Format('升级经验(最高有效等级%d)', [MAXUPLEVEL]);
{$IF HEROVERSION = 1}
  for I := Low(TExpHeroPulsLevelNeedExp) to High(TExpHeroPulsLevelNeedExp) do begin
    GridHeroPulsLevelExp.Cells[1, I+1] := IntToStr(g_Config.dwExpHeroPulsNeedExps0[I]);
    GridHeroPulsLevelExp.Cells[2, I+1] := IntToStr(g_Config.dwExpHeroPulsNeedExps1[I]);
    GridHeroPulsLevelExp.Cells[3, I+1] := IntToStr(g_Config.dwExpHeroPulsNeedExps2[I]);
    GridHeroPulsLevelExp.Cells[4, I+1] := IntToStr(g_Config.dwExpHeroPulsNeedExps3[I]);
  end;
{$IFEND}
  EditStrength1DecGold.Value := g_Config.nStrength1DecGold;
  EditStrength1DecGameGird.Value := g_Config.nStrength1DecGameGird;
  EditStrength1Exp.Value := g_Config.nStrength1Exp;
  EditStrength2DecGold.Value := g_Config.nStrength2DecGold;
  EditStrength2DecGameGird.Value := g_Config.nStrength2DecGameGird;
  EditStrength2Exp.Value := g_Config.nStrength2Exp;
  EditStrength3DecGold.Value := g_Config.nStrength3DecGold;
  EditStrength3DecGameGird.Value := g_Config.nStrength3DecGameGird;
  EditStrength3Exp.Value := g_Config.nStrength3Exp;
  EditDeputyHeroExpRate.Value := g_Config.nDeputyHeroExpRate;

  SpinEditHeroProtectLevel.Value := g_Config.nHeroProtectLevel;
  EditStartLevel.Value := g_Config.nHeroStartLevel;
  EditDrinkHeroStartLevel.Value := g_Config.nDrinkHeroStartLevel;//卧龙英雄开始等级 20080514
  EditKillMonExpRate.Value := g_Config.nHeroKillMonExpRate;
  EditNoEditKillMonExpRate.Value := g_Config.nHeroNoKillMonExpRate;//20080803 非杀怪分配经验比例
  ComboBoxBagItemCount.Items.Clear;
  EditHeroRecallTick.Value:=g_Config.nRecallHeroTime div 1000;//召唤英雄间隔 20071201
  EditDeputyHeroRecallTick.Value:=g_Config.nRecallDeputyHeroTime div 1000;;//召唤副将英雄间隔
  EditMakeGhostHeroTime.Value := g_Config.nMakeGhostHeroTime div 1000;//英雄尸体清理时间 20080418
  SpinEditHeroHPRate.Value := g_Config.nHeroHPRate;//战英雄HP为人物的倍数 20081219
  SpinEditHeroHPRate1.Value := g_Config.nHeroHPRate1;//法英雄HP为人物的倍数 20090207
  SpinEditHeroHPRate2.Value := g_Config.nHeroHPRate2;//道英雄HP为人物的倍数 20090207
  EditDeathDecLoyal.Value:=g_Config.nDeathDecLoyal;//死亡减少忠城度 20080110
  EditPKDecLoyal.Value:= g_Config.nPKDecLoyal;//PK值减少忠诚度 20080214
  EditGuildIncLoyal.Value:= g_Config.nGuildIncLoyal;//行会战增加忠诚度 20080214
  //EditLevelOrderIncLoyal.Value:= g_Config.nLevelOrderIncLoyal;//人物等级排名上升增加忠诚度 20080214
  //EditLevelOrderDecLoyal.Value:= g_Config.nLevelOrderDecLoyal;//人物等级排名下降减少忠诚度 20080214
  EditWinExp.Value:=g_Config.nWinExp;//获得经验 20080110
  EditExpAddLoyal.Value:=g_Config.nExpAddLoyal;//经验加忠诚 20080110
  EditGotoLV4.Value:=g_Config.nGotoLV4;//四级触发 20080110
  EditPowerLv4.Value:=g_Config.nPowerLV4;//四级技能杀伤力增加值 20080112
  EditHeroRunIntervalTime1.Value := g_Config.dwHeroRunIntervalTime1;
  EditHeroRunIntervalTime.Value := g_Config.dwHeroRunIntervalTime;//英雄跑步间隔 20090207
  EditHeroWalkIntervalTime.Value := g_Config.dwHeroWalkIntervalTime;//英雄走路间隔 20080213
  EditHeroTurnIntervalTime.Value := g_Config.dwHeroTurnIntervalTime;//英雄转向间隔 20080213
  EditHeroMagicHitIntervalTime.Value := g_Config.dwHeroMagicHitIntervalTime;//英雄魔法间隔 20080524

  if not g_Config.btHeroSkillMode then begin //英雄施毒术使用模式 20080604
    RadioHeroSkillMode.Checked := True;
    RadioHeroSkillModeAll.Checked := False;
  end else begin
    RadioHeroSkillMode.Checked := False;
    RadioHeroSkillModeAll.Checked := True;
  end;

  if not g_Config.btHeroSkillMode50 then begin //英雄无极真气使用模式 20080604
    RadioHeroSkillMode50.Checked := True;
    RadioHeroSkillMode50All.Checked := False;
  end else begin
    RadioHeroSkillMode50.Checked := False;
    RadioHeroSkillMode50All.Checked := True;
  end;

  if not g_Config.btHeroSkillMode46 then begin //英雄分身术使用模式 20081029
    RadioHeroSkillMode46.Checked := True;
    RadioHeroSkillMode46All.Checked := False;
  end else begin
    RadioHeroSkillMode46.Checked := False;
    RadioHeroSkillMode46All.Checked := True;
  end;

  if not g_Config.btHeroSkillMode43 then begin //英雄开天斩重击模式 20081221
    RadioHeroSkillMode43.Checked := True;
    RadioHeroSkillMode43All.Checked := False;
  end else begin
    RadioHeroSkillMode43.Checked := False;
    RadioHeroSkillMode43All.Checked := True;
  end;

  if not g_Config.btHeroSkillMode_63 then begin //噬魂沼泽使用绿毒模式 20080911
    RadioHeroSkillMode_63.Checked := True;
    RadioHeroSkillMode_63All.Checked := False;
  end else begin
    RadioHeroSkillMode_63.Checked := False;
    RadioHeroSkillMode_63All.Checked := True;
  end;

  for I := Low(g_Config.nHeroBagItemCount) to High(g_Config.nHeroBagItemCount) do begin
    case I of
      0: s01 := '10格';
      1: s01 := '20格';
      2: s01 := '30格';
      3: s01 := '35格';
      4: s01 := '40格';
    end;
    ComboBoxBagItemCount.Items.AddObject(s01, TObject(g_Config.nHeroBagItemCount[I]));
  end;

  SpinEditWarrorAttackTime.Value := g_Config.dwHeroWarrorAttackTime;
  SpinEditWizardAttackTime.Value := g_Config.dwHeroWizardAttackTime;
  SpinEditTaoistAttackTime.Value := g_Config.dwHeroTaoistAttackTime;

  CheckBoxKillByMonstDropUseItem.Checked := g_Config.boHeroKillByMonstDropUseItem;
  CheckBoxKillByHumanDropUseItem.Checked := g_Config.boHeroKillByHumanDropUseItem;
  CheckBoxDieScatterBag.Checked := g_Config.boHeroDieScatterBag;
  CheckBoxDieRedScatterBagAll.Checked := g_Config.boHeroDieRedScatterBagAll;
  CheckBoxHeroDieExp.Checked := g_Config.boHeroDieExp;//英雄死亡掉经验 20080605
  CheckBoxHeroNoTargetCall.Checked := g_Config.boHeroNoTargetCall;//英雄无目标下可召唤宝宝 20080615
  if g_Config.boHeroDieExp then
     SpinEditHeroDieExpRate.Enabled:= True
  else  SpinEditHeroDieExpRate.Enabled:= False;
  SpinEditHeroDieExpRate.Value := g_Config.nHeroDieExpRate;//英雄死亡掉经验比率 20080605

  ScrollBarDieDropUseItemRate.Min := 1;
  ScrollBarDieDropUseItemRate.Max := 200;
  ScrollBarDieDropUseItemRate.Position := g_Config.nHeroDieDropUseItemRate;
  ScrollBarDieRedDropUseItemRate.Min := 1;
  ScrollBarDieRedDropUseItemRate.Max := 200;
  ScrollBarDieRedDropUseItemRate.Position := g_Config.nHeroDieRedDropUseItemRate;
  ScrollBarDieScatterBagRate.Min := 1;
  ScrollBarDieScatterBagRate.Max := 200;
  ScrollBarDieScatterBagRate.Position := g_Config.nHeroDieScatterBagRate;

  CheckBoxAutoHeroUseEat.Checked := g_Config.boAutoHeroUseEat;
  SpinEditEatHPItemRate.Value := g_Config.nHeroAddHPRate;
  SpinEditEatMPItemRate.Value := g_Config.nHeroAddMPRate;
  SpinEditEatItemTick.Value := g_Config.nHeroAddHPMPTick;//英雄吃普通药速度 20080601
  SpinEditEatHPItemRate1.Value := g_Config.nHeroAddHPRate1;
  SpinEditEatMPItemRate1.Value := g_Config.nHeroAddMPRate1;
  SpinEditEatItemTick1.Value := g_Config.nHeroAddHPMPTick1;//吃特殊药速度 20080910
  SpinEditEatItemTickA.Value := g_Config.nHeroAddHPMPTickA;
  SpinEditEatItemTickB.Value := g_Config.nHeroAddHPMPTickB;
  if not g_Config.boAutoHeroUseEat then begin
    SpinEditEatHPItemRate.Enabled:= False;
    SpinEditEatMPItemRate.Enabled:= False;
    SpinEditEatItemTick.Enabled:= False;
    SpinEditEatHPItemRate1.Enabled:= False;
    SpinEditEatMPItemRate1.Enabled:= False;
    SpinEditEatItemTick1.Enabled:= False;
    SpinEditEatItemTickA.Enabled:= False;
    SpinEditEatItemTickB.Enabled:= False;
  end;

  ComboBoxBagItemCount.ItemIndex := -1;
  ComboBoxBagItemCount.Text := '选择包裹数';
  SpinEditNeedLevel.Value := 1;
  SpinEditNeedLevel.Enabled := False;
  EditMaxFirDragonPoint.Value := g_Config.nMaxFirDragonPoint;
  EditAddFirDragonPoint.Value := g_Config.nAddFirDragonPoint;
  EditDecFirDragonPoint.Value := g_Config.nDecFirDragonPoint;
  SpinEditIncDragonPointTick.Value := g_Config.nIncDragonPointTick;//加怒气时间间隔 20080606
  SpinEditHeroSkill46MaxHP_0.Value := g_Config.nHeroSkill46MaxHP_0;//英雄召唤分身HP的比率 20080907
  SpinEditHeroSkill46MaxHP_1.Value := g_Config.nHeroSkill46MaxHP_1;//1级 英雄召唤分身HP的比率 20081217
  SpinEditHeroSkill46MaxHP_2.Value := g_Config.nHeroSkill46MaxHP_2;//2级 英雄召唤分身HP的比率 20081217
  SpinEditHeroSkill46MaxHP_3.Value := g_Config.nHeroSkill46MaxHP_3;//3级 英雄召唤分身HP的比率 20081217
  SpinEditHeroMakeSelfTick.Value := g_Config.nHeroMakeSelfTick;//英雄分身0级使用时间 20081217
  SpinEditHeroMakeSelfTick1.Value := g_Config.nHeroMakeSelfTick1;//英雄分身1级使用时间 20090817
  SpinEditHeroMakeSelfTick2.Value := g_Config.nHeroMakeSelfTick2;//英雄分身2级使用时间 20090817
  SpinEditHeroMakeSelfTick3.Value := g_Config.nHeroMakeSelfTick3;//英雄分身3级使用时间 20090817
  SpinEditDecDragonHitPoint.Value := g_Config.nDecDragonHitPoint;//饮酒减少合击伤害 20080626
  EditDecDragonRate.Value := g_Config.nDecDragonRate;//合击对人物的伤害比例 20080803
  Edit4SKillDecNH.Value := g_Config.n4SKillDecNHRate;//四级合击减目标内力值比例 20100719
  Edit4SKillDecMP.Value := g_Config.n4SKillDecMPRate;//四级合击减目标MP比例 20100719
  EditHeroAttackRate_60.Value := g_Config.nHeroAttackRate_60;//破魂斩威力 20080131
  EditHeroAttackRange_60.Value:= g_Config.nHeroAttackRange_60;//破魂斩 攻击范围 20080406
  EditHeroAttackRate_61.Value := g_Config.nHeroAttackRate_61;//劈星斩威力 20080131
  EditHeroAttackRate_62.Value := g_Config.nHeroAttackRate_62;//雷霆一击威力 20080131
  EditHeroAttackRate_63.Value := g_Config.nHeroAttackRate_63;//噬魂沼泽威力 20080131
  EditHeroAttackRange_63.Value:= g_Config.nHeroAttackRange_63;//噬魂沼泽 攻击范围 20080131
  EditHeroAttackRate_64.Value := g_Config.nHeroAttackRate_64;//末日审判威力 20080131
  EditHeroAttackRate_65.Value := g_Config.nHeroAttackRate_65;//火龙气焰威力 20080131
  EditHeroAttackRange_64.Value:= g_Config.nHeroAttackRange_64;//末日审判  攻击范围 20081216
  EditHeroAttackRange_65.Value:= g_Config.nHeroAttackRange_65;//火龙气焰 攻击范围 20080131
  EditHeroNameColor.Value := g_Config.nHeroNameColor;//英雄名字颜色 20080315
  EdtHeroName.Text:= g_Config.sHeroName ;//英雄名字 20080315
  EditHeroNameSuffix.Text := g_Config.sHeroNameSuffix ;//英雄名后缀  20080315
  CheckNameSuffix.Checked := g_Config.boNameSuffix; //是否显示后缀  20080315
  CheckBoxProtectPickUpItem.Checked := g_Config.boProtectPickUpItem;//守护时可捡物品 20090723
  CheckBoxStopProtectOnChangMap.Checked := g_Config.boStopProtectOnChangMap;//主人换地图停止守护By TasNat at: 2012-06-24 15:49:17
  CheckBoxHeroProtect.Checked := g_Config.boNoSafeProtect;//禁止安全区守护 20080603
  CheckBoxHeroAttackNoFollow.Checked := g_Config.boHeroAttackNoFollow;//英雄攻击时不与主人切换地图 20090723
  CheckBoxHeroRestNoFollow.Checked := g_Config.boRestNoFollow;//英雄休息不跟随主人切换地图 20081209
  CheckBoxHeroAttackTarget.Checked := g_Config.boHeroAttackTarget;//道法22前是否物理攻击 20081218
  CheckBoxHeroAttackTao.Checked := g_Config.boHeroAttackTao;//道22后是否物理攻击 20090108
  SpinEditHeroSkill43HPRate.Value:= g_Config.nHeroSkill43HPRate;//英雄开天斩HP触发条件 20090213
  EditHeroUseBatterTick.Value:= g_Config.dwHeroUseBatterTick div 1000;//英雄连击间隔 20091027
  EditKillMonHeroPulsExpMultiple.Value:= g_Config.dwKillMonHeroPulsExpMultiple;//杀怪英雄经络修炼经验倍数
  boOpened := True;
  {$IF M2Version = 0}
  TabSheet19.TabVisible := False;
  {$IFEND}
  ShowModal;
end;

procedure TfrmHeroConfig.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  GridLevelExp.ColWidths[0] := 30;
  GridLevelExp.ColWidths[1] := 100;
  GridLevelExp.Cells[0, 0] := '等级';
  GridLevelExp.Cells[1, 0] := '经验值';
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    GridLevelExp.Cells[0, I] := IntToStr(I);
  end;

  ComboBoxLevelExp.AddItem('原始经验值', TObject(s_OldLevelExp));
  ComboBoxLevelExp.AddItem('标准经验值', TObject(s_StdLevelExp));
  ComboBoxLevelExp.AddItem('当前1/2倍经验', TObject(s_2Mult));
  ComboBoxLevelExp.AddItem('当前1/5倍经验', TObject(s_5Mult));
  ComboBoxLevelExp.AddItem('当前1/8倍经验', TObject(s_8Mult));
  ComboBoxLevelExp.AddItem('当前1/10倍经验', TObject(s_10Mult));
  ComboBoxLevelExp.AddItem('当前1/20倍经验', TObject(s_20Mult));
  ComboBoxLevelExp.AddItem('当前1/30倍经验', TObject(s_30Mult));
  ComboBoxLevelExp.AddItem('当前1/40倍经验', TObject(s_40Mult));
  ComboBoxLevelExp.AddItem('当前1/50倍经验', TObject(s_50Mult));
  ComboBoxLevelExp.AddItem('当前1/60倍经验', TObject(s_60Mult));
  ComboBoxLevelExp.AddItem('当前1/70倍经验', TObject(s_70Mult));
  ComboBoxLevelExp.AddItem('当前1/80倍经验', TObject(s_80Mult));
  ComboBoxLevelExp.AddItem('当前1/90倍经验', TObject(s_90Mult));
  ComboBoxLevelExp.AddItem('当前1/100倍经验', TObject(s_100Mult));
  ComboBoxLevelExp.AddItem('当前1/150倍经验', TObject(s_150Mult));
  ComboBoxLevelExp.AddItem('当前1/200倍经验', TObject(s_200Mult));
  ComboBoxLevelExp.AddItem('当前1/250倍经验', TObject(s_250Mult));
  ComboBoxLevelExp.AddItem('当前1/300倍经验', TObject(s_300Mult));

  GridHeroPulsLevelExp.Cells[0, 0] := '经络等级';
  GridHeroPulsLevelExp.Cells[1, 0] := '冲脉';
  GridHeroPulsLevelExp.Cells[2, 0] := '阴跷';
  GridHeroPulsLevelExp.Cells[3, 0] := '阴维';
  GridHeroPulsLevelExp.Cells[4, 0] := '任脉';
  for I := 1 to GridHeroPulsLevelExp.RowCount - 1 do begin
    GridHeroPulsLevelExp.Cells[0, I] := IntToStr(I);
  end;
end;

procedure TfrmHeroConfig.ButtonHeroExpSaveClick(Sender: TObject);
var
  I: Integer;
  dwExp: LongWord;
  NeedExps: TLevelNeedExp;
begin
  for I := 1 to GridLevelExp.RowCount - 1 do begin
    dwExp := Str_ToInt(GridLevelExp.Cells[1, I], 0);
    if (dwExp <= 0) or (dwExp > High(LongWord)) then begin
      Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 升级经验设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridLevelExp.Row := I;
      GridLevelExp.SetFocus;
      Exit;
    end;
    NeedExps[I] := dwExp;
  end;
  g_Config.dwHeroNeedExps := NeedExps;
  for I := 1 to 1000 do begin
    Config.WriteString('HeroExp', 'Level' + IntToStr(I), IntToStr(g_Config.dwHeroNeedExps[I]));
  end;

  Config.WriteInteger('HeroSetup', 'StartLevel', g_Config.nHeroStartLevel);
  Config.WriteInteger('HeroSetup', 'DrinkHeroStartLevel', g_Config.nDrinkHeroStartLevel);//卧龙英雄开始等级 20080514
  Config.WriteInteger('HeroSetup', 'KillMonExpRate', g_Config.nHeroKillMonExpRate);
  Config.WriteInteger('HeroSetup', 'NoKillMonExpRate', g_Config.nHeroNoKillMonExpRate);//20080803 非杀怪分配经验比例

  for I := Low(g_Config.nHeroBagItemCount) to High(g_Config.nHeroBagItemCount) do begin
    Config.WriteInteger('HeroSetup', 'BagItemCount' + IntToStr(I), g_Config.nHeroBagItemCount[I]);
  end;

  Config.WriteInteger('HeroSetup', 'WarrorAttackTime', g_Config.dwHeroWarrorAttackTime);
  Config.WriteInteger('HeroSetup', 'WizardAttackTime', g_Config.dwHeroWizardAttackTime);
  Config.WriteInteger('HeroSetup', 'TaoistAttackTime', g_Config.dwHeroTaoistAttackTime);
  Config.WriteInteger('HeroSetup', 'HeroHPRate', g_Config.nHeroHPRate);//战英雄HP为人物的倍数 20081219
  Config.WriteInteger('HeroSetup', 'HeroHPRate1', g_Config.nHeroHPRate1);//法英雄HP为人物的倍数 20090207
  Config.WriteInteger('HeroSetup', 'HeroHPRate2', g_Config.nHeroHPRate2);//道英雄HP为人物的倍数 20090207
  Config.WriteInteger('HeroSetup', 'DeathDecLoyal', g_Config.nDeathDecLoyal); //死亡减少忠城度 20080110
  Config.WriteInteger('HeroSetup', 'PKDecLoyal', g_Config.nPKDecLoyal); //PK值减少忠诚度 20080214
  Config.WriteInteger('HeroSetup', 'GuildIncLoyal', g_Config.nGuildIncLoyal);//行会战增加忠诚度 20080214
  //Config.WriteInteger('HeroSetup', 'LevelOrderIncLoyal', g_Config.nLevelOrderIncLoyal);//人物等级排名上升增加忠诚度 20080214
  //Config.WriteInteger('HeroSetup', 'LevelOrderDecLoyal', g_Config.nLevelOrderDecLoyal);//人物等级排名下降减少忠诚度 20080214
  Config.WriteInteger('HeroSetup', 'WinExp', g_Config.nWinExp); //获得经验 20080110
  Config.WriteInteger('HeroSetup', 'ExpAddLoyal', g_Config.nExpAddLoyal); //经验加忠诚 20080110
  Config.WriteInteger('HeroSetup', 'GotoLV4', g_Config.nGotoLV4); //四级触发 20080110
  Config.WriteInteger('HeroSetup', 'PowerLV4', g_Config.nPowerLV4); //四级技能杀伤力增加值 20080112
  Config.WriteInteger('HeroSetup', 'HeroRunIntervalTime1', g_Config.dwHeroRunIntervalTime1);
  Config.WriteInteger('HeroSetup', 'HeroRunIntervalTime', g_Config.dwHeroRunIntervalTime); //英雄跑步间隔 20090207
  Config.WriteInteger('HeroSetup', 'HeroWalkIntervalTime', g_Config.dwHeroWalkIntervalTime);//英雄走路间隔 20080213
  Config.WriteInteger('HeroSetup', 'HeroTurnIntervalTime', g_Config.dwHeroTurnIntervalTime); //英雄转向间隔 20080213
  Config.WriteInteger('HeroSetup', 'HeroMagicHitIntervalTime', g_Config.dwHeroMagicHitIntervalTime);//英雄魔法间隔 20080524
  Config.WriteInteger('HeroSetup', 'nHeroNameColor', g_Config.nHeroNameColor);//英雄名字颜色 20080315
  Config.WriteString('HeroSetup', 'sHeroName', g_Config.sHeroName);//英雄名字 20080315
  Config.WriteString('HeroSetup', 'sHeroNameSuffix', g_Config.sHeroNameSuffix);//英雄名后缀  20080315
  Config.WriteBool('HeroSetup', 'boNameSuffix', g_Config.boNameSuffix);//是否显示后缀  20080315
  Config.WriteBool('HeroSetup', 'boProtectPickUpItem', g_Config.boProtectPickUpItem);//守护时可捡物品 20090723
  Config.WriteBool('HeroSetup', 'boStopProtectOnChangMap', g_Config.boStopProtectOnChangMap);//主人换地图停止守护By TasNat at: 2012-06-24 15:49:17
  Config.WriteBool('HeroSetup', 'boNoSafeProtect', g_Config.boNoSafeProtect);//禁止安全区守护 20080603
  Config.WriteBool('HeroSetup', 'boHeroAttackNoFollow', g_Config.boHeroAttackNoFollow);//英雄攻击时不与主人切换地图 20090723
  Config.WriteBool('HeroSetup', 'boRestNoFollow', g_Config.boRestNoFollow);//英雄休息不跟随主人切换地图 20081209
  Config.WriteBool('HeroSetup', 'boHeroAttackTarget', g_Config.boHeroAttackTarget);//道法22前是否物理攻击 20081218
  Config.WriteBool('HeroSetup', 'boHeroAttackTao', g_Config.boHeroAttackTao);//道22后是否物理攻击 20090108
  uModValue();
end;

procedure TfrmHeroConfig.EditStartLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroStartLevel := EditStartLevel.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditKillMonExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroKillMonExpRate := EditKillMonExpRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ComboBoxBagItemCountChange(Sender: TObject);
begin
  SpinEditNeedLevel.Value := Integer(ComboBoxBagItemCount.Items.Objects[ComboBoxBagItemCount.ItemIndex]);
  SpinEditNeedLevel.Enabled := True;
end;

procedure TfrmHeroConfig.SpinEditNeedLevelChange(Sender: TObject);
  procedure RefBagcount;
  var
    I: Integer;
  begin
    for I := 0 to ComboBoxBagItemCount.Items.Count - 1 do begin
      g_Config.nHeroBagItemCount[I] := Integer(ComboBoxBagItemCount.Items.Objects[I]);
    end;
  end;
begin
  if not boOpened then Exit;
  ComboBoxBagItemCount.Items.Objects[ComboBoxBagItemCount.ItemIndex] := TObject(SpinEditNeedLevel.Value);
  RefBagcount;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditWarrorAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWarrorAttackTime := SpinEditWarrorAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditWizardAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWizardAttackTime := SpinEditWizardAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditTaoistAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroTaoistAttackTime := SpinEditTaoistAttackTime.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ButtonHeroDieSaveClick(Sender: TObject);
begin
  Config.WriteBool('HeroSetup', 'KillByMonstDropUseItem', g_Config.boHeroKillByMonstDropUseItem);
  Config.WriteBool('HeroSetup', 'KillByHumanDropUseItem', g_Config.boHeroKillByHumanDropUseItem);
  Config.WriteBool('HeroSetup', 'DieScatterBag', g_Config.boHeroDieScatterBag);
  Config.WriteBool('HeroSetup', 'DieRedScatterBagAll', g_Config.boHeroDieRedScatterBagAll);
  Config.WriteInteger('HeroSetup', 'DieDropUseItemRate', g_Config.nHeroDieDropUseItemRate);
  Config.WriteInteger('HeroSetup', 'DieRedDropUseItemRate', g_Config.nHeroDieRedDropUseItemRate);
  Config.WriteInteger('HeroSetup', 'DieScatterBagRate', g_Config.nHeroDieScatterBagRate);
  Config.WriteInteger('HeroSetup', 'MakeGhostHeroTime', g_Config.nMakeGhostHeroTime);//英雄尸体清理时间 20080418
  Config.WriteBool('HeroSetup', 'HeroDieExp', g_Config.boHeroDieExp);//英雄死亡掉经验 20080605
  Config.WriteInteger('HeroSetup', 'HeroDieExpRate', g_Config.nHeroDieExpRate);//英雄死亡掉经验比率 20080605
  uModValue();
end;

procedure TfrmHeroConfig.CheckBoxKillByMonstDropUseItemClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroKillByMonstDropUseItem := CheckBoxKillByMonstDropUseItem.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxKillByHumanDropUseItemClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroKillByHumanDropUseItem := CheckBoxKillByHumanDropUseItem.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxDieScatterBagClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroDieScatterBag := CheckBoxDieScatterBag.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxAutoHeroUseEatClick(Sender: TObject);
var
  boStatus: Boolean;
begin
  boStatus := CheckBoxAutoHeroUseEat.Checked;
  SpinEditEatHPItemRate.Enabled:= boStatus;
  SpinEditEatMPItemRate.Enabled:= boStatus;
  SpinEditEatItemTick.Enabled:= boStatus;
  SpinEditEatHPItemRate1.Enabled:= boStatus;
  SpinEditEatMPItemRate1.Enabled:= boStatus;
  SpinEditEatItemTick1.Enabled:= boStatus;
  SpinEditEatItemTickA.Enabled:= boStatus;
  SpinEditEatItemTickB.Enabled:= boStatus;
  if not boOpened then Exit;
  g_Config.boAutoHeroUseEat := boStatus;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxDieRedScatterBagAllClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroDieRedScatterBagAll := CheckBoxDieRedScatterBagAll.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieDropUseItemRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieDropUseItemRate.Position;
  EditDieDropUseItemRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieDropUseItemRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieRedDropUseItemRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieRedDropUseItemRate.Position;
  EditDieRedDropUseItemRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieRedDropUseItemRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.ScrollBarDieScatterBagRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarDieScatterBagRate.Position;
  EditDieScatterBagRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nHeroDieScatterBagRate := nPostion;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatHPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPRate := SpinEditEatHPItemRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatMPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddMPRate := SpinEditEatMPItemRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.ButtonHeroAttackSaveClick(Sender: TObject);
begin
  Config.WriteInteger('HeroSetup', 'MaxFirDragonPoint', g_Config.nMaxFirDragonPoint);
  Config.WriteInteger('HeroSetup', 'AddFirDragonPoint', g_Config.nAddFirDragonPoint);
  Config.WriteInteger('HeroSetup', 'DecFirDragonPoint', g_Config.nDecFirDragonPoint);
  Config.WriteInteger('HeroSetup', 'IncDragonPointTick', g_Config.nIncDragonPointTick);//加怒气时间间隔 20080606
  Config.WriteInteger('HeroSetup', 'DecDragonHitPoint', g_Config.nDecDragonHitPoint);//饮酒减少合击伤害 20080626
  Config.WriteInteger('HeroSetup', 'DecDragonRate', g_Config.nDecDragonRate);//合击对人物的伤害比例 20080803
  Config.WriteInteger('HeroSetup', '4SKillDecNHRate', g_Config.n4SKillDecNHRate);//四级合击减目标内力值比例 20100719
  Config.WriteInteger('HeroSetup', '4SKillDecMPRate', g_Config.n4SKillDecMPRate);//四级合击减目标MP比例 20100719
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_60', g_Config.nHeroAttackRate_60);//破魂斩威力 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRange_60', g_Config.nHeroAttackRange_60);//破魂斩攻击范围 20080406
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_61', g_Config.nHeroAttackRate_61);//劈星斩威力 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_62', g_Config.nHeroAttackRate_62);//雷霆一击威力 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_63', g_Config.nHeroAttackRate_63);//噬魂沼泽威力 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRange_63', g_Config.nHeroAttackRange_63);//噬魂沼泽 攻击范围 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_64', g_Config.nHeroAttackRate_64);//末日审判威力 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRange_64', g_Config.nHeroAttackRange_64);//末日审判  攻击范围 20081216
  Config.WriteInteger('HeroSetup', 'HeroAttackRate_65', g_Config.nHeroAttackRate_65);//火龙气焰威力 20080131
  Config.WriteInteger('HeroSetup', 'HeroAttackRange_65', g_Config.nHeroAttackRange_65);//火龙气焰 攻击范围 20080131
  Config.WriteBool('HeroSetup', 'HeroSkillMode_63', g_Config.btHeroSkillMode_63);//噬魂沼泽使用绿毒模式 20080911
  uModValue();
end;

procedure TfrmHeroConfig.EditMaxFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMaxFirDragonPoint := EditMaxFirDragonPoint.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditAddFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAddFirDragonPoint := EditAddFirDragonPoint.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditDecFirDragonPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecFirDragonPoint := EditDecFirDragonPoint.Value;
  ModValue();
end;

//破魂斩合击攻击威力 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_60Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_60 := EditHeroAttackRate_60.Value;
  ModValue();
end;

//召唤英雄间隔 20071201
procedure TfrmHeroConfig.EditHeroRecallTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRecallHeroTime := EditHeroRecallTick.Value* 1000;
  ModValue();
end;

//死亡减少忠城度 20080110
procedure TfrmHeroConfig.EditDeathDecLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDeathDecLoyal := EditDeathDecLoyal.Value;
  ModValue();
end;
//PK值减少忠诚度 20080214
procedure TfrmHeroConfig.EditPKDecLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPKDecLoyal := EditPKDecLoyal.Value;
  ModValue();
end;
//行会战增加忠诚度 20080214
procedure TfrmHeroConfig.EditGuildIncLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nGuildIncLoyal := EditGuildIncLoyal.Value;
  ModValue();
end;
//人物等级排名上升增加忠诚度 20080214
procedure TfrmHeroConfig.EditLevelOrderIncLoyalChange(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.nLevelOrderIncLoyal := EditLevelOrderIncLoyal.Value;
  ModValue();  }
end;
//人物等级排名下降减少忠诚度 20080214
procedure TfrmHeroConfig.EditLevelOrderDecLoyalChange(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.nLevelOrderDecLoyal := EditLevelOrderDecLoyal.Value;
  ModValue(); }
end;
//获得经验  20080110
procedure TfrmHeroConfig.EditWinExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWinExp := EditWinExp.Value;
  ModValue();
end;
//经验加忠诚  20080110
procedure TfrmHeroConfig.EditExpAddLoyalChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nExpAddLoyal := EditExpAddLoyal.Value;
  ModValue();
end;
//四级触发   20080110
procedure TfrmHeroConfig.EditGotoLV4Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nGotoLV4 := EditGotoLV4.Value;
  ModValue();
end;
//四级技能杀伤力增加值 20080112
procedure TfrmHeroConfig.EditPowerLv4Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPowerLV4 := EditPowerLv4.Value;
  ModValue();
end;

//英雄跑步间隔 20090207
procedure TfrmHeroConfig.EditHeroRunIntervalTime1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroRunIntervalTime1 := EditHeroRunIntervalTime1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditHeroRunIntervalTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroRunIntervalTime := EditHeroRunIntervalTime.Value;
  ModValue();
end;

//英雄走路间隔 20080213
procedure TfrmHeroConfig.EditHeroWalkIntervalTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroWalkIntervalTime := EditHeroWalkIntervalTime.Value;
  ModValue();
end;
//英雄转向间隔 20080213
procedure TfrmHeroConfig.EditHeroTurnIntervalTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroTurnIntervalTime := EditHeroTurnIntervalTime.Value;
  ModValue();
end;
//劈星斩威力 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_61Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_61 := EditHeroAttackRate_61.Value;
  ModValue();
end;
//雷霆一击威力 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_62Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_62 := EditHeroAttackRate_62.Value;
  ModValue();
end;
//噬魂沼泽威力 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_63Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_63 := EditHeroAttackRate_63.Value;
  ModValue();
end;
//末日审判威力 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_64Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_64 := EditHeroAttackRate_64.Value;
  ModValue();
end;
//火龙气焰威力 20080131
procedure TfrmHeroConfig.EditHeroAttackRate_65Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRate_65 := EditHeroAttackRate_65.Value;
  ModValue();
end;
//火龙气焰 攻击范围 20080131
procedure TfrmHeroConfig.EditHeroAttackRange_65Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRange_65 := EditHeroAttackRange_65.Value;
  ModValue();
end;
//噬魂沼泽 攻击范围 20080131
procedure TfrmHeroConfig.EditHeroAttackRange_63Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRange_63 := EditHeroAttackRange_63.Value;
  ModValue();
end;
//英雄名字颜色 20080315
procedure TfrmHeroConfig.EditHeroNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditHeroNameColor.Value;
  LabelHeroNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.nHeroNameColor := btColor;
  ModValue();
end;

//是否显示后缀  20080315
procedure TfrmHeroConfig.CheckNameSuffixClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNameSuffix := CheckNameSuffix.Checked;
  ModValue();
end;

//英雄名字 20080315
procedure TfrmHeroConfig.EdtHeroNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sHeroName := EdtHeroName.Text;
  ModValue();
end;

//英雄名后缀  20080315
procedure TfrmHeroConfig.EditHeroNameSuffixChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sHeroNameSuffix := EditHeroNameSuffix.Text;
  ModValue();
end;
//破魂斩 攻击范围 20080406
procedure TfrmHeroConfig.EditHeroAttackRange_60Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRange_60 := EditHeroAttackRange_60.Value;
  ModValue();
end;
//英雄尸体清理时间 20080418
procedure TfrmHeroConfig.EditMakeGhostHeroTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeGhostHeroTime := EditMakeGhostHeroTime.Value * 1000;
  ModValue();
end;

procedure TfrmHeroConfig.EditDrinkHeroStartLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDrinkHeroStartLevel := EditDrinkHeroStartLevel.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditHeroMagicHitIntervalTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroMagicHitIntervalTime := EditHeroMagicHitIntervalTime.Value;
  ModValue();
end;
//英雄吃普通药速度 20080601
procedure TfrmHeroConfig.SpinEditEatItemTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPMPTick := SpinEditEatItemTick.Value;
  ModValue();
end;
//禁止安全区守护 20080603
procedure TfrmHeroConfig.CheckBoxHeroProtectClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNoSafeProtect := CheckBoxHeroProtect.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.ButtonHeroSkillSaveClick(Sender: TObject);
begin
  Config.WriteInteger('HeroSetup', 'HeroSkill46MaxHP_0', g_Config.nHeroSkill46MaxHP_0);//英雄召唤分身HP的比率 20080907
  Config.WriteInteger('HeroSetup', 'HeroSkill46MaxHP_1', g_Config.nHeroSkill46MaxHP_1);//1级 英雄召唤分身HP的比率 20081217
  Config.WriteInteger('HeroSetup', 'HeroSkill46MaxHP_2', g_Config.nHeroSkill46MaxHP_2);//2级 英雄召唤分身HP的比率 20081217
  Config.WriteInteger('HeroSetup', 'HeroSkill46MaxHP_3', g_Config.nHeroSkill46MaxHP_3);//3级 英雄召唤分身HP的比率 20081217
  Config.WriteInteger('HeroSetup', 'HeroMakeSelfTick', g_Config.nHeroMakeSelfTick);//英雄分身0级使用时间 20081217
  Config.WriteInteger('HeroSetup', 'HeroMakeSelfTick1', g_Config.nHeroMakeSelfTick1);//英雄分身1级使用时间 20090817
  Config.WriteInteger('HeroSetup', 'HeroMakeSelfTick2', g_Config.nHeroMakeSelfTick2);//英雄分身2级使用时间 20090817
  Config.WriteInteger('HeroSetup', 'HeroMakeSelfTick3', g_Config.nHeroMakeSelfTick3);//英雄分身3级使用时间 20090817
  Config.WriteBool('HeroSetup', 'HeroSkillMode', g_Config.btHeroSkillMode); //英雄施毒术使用模式 20080604
  Config.WriteBool('HeroSetup', 'HeroNoTargetCall', g_Config.boHeroNoTargetCall);//英雄无目标下可召唤宝宝 20080615
  Config.WriteBool('HeroSetup', 'HeroSkillMode50', g_Config.btHeroSkillMode50);//英雄无极真气使用模式 20080827
  Config.WriteBool('HeroSetup', 'HeroSkillMode46', g_Config.btHeroSkillMode46);//英雄分身术模式 20081029
  Config.WriteBool('HeroSetup', 'HeroSkillMode43', g_Config.btHeroSkillMode43);//英雄开天斩重击模式 20081221
  Config.WriteInteger('HeroSetup', 'HeroSkill43HPRate', g_Config.nHeroSkill43HPRate);//英雄开天斩HP触发条件 20090213
  uModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillModeClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode := False;
  end else begin
    g_Config.btHeroSkillMode := True;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillModeAllClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillModeAll.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode := True;
  end else begin
    g_Config.btHeroSkillMode := False;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxHeroDieExpClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroDieExp := CheckBoxHeroDieExp.Checked;
  if g_Config.boHeroDieExp then SpinEditHeroDieExpRate.Enabled:= True
  else  SpinEditHeroDieExpRate.Enabled:= False;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroDieExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroDieExpRate := SpinEditHeroDieExpRate.Value ;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditIncDragonPointTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nIncDragonPointTick := SpinEditIncDragonPointTick.Value;
  ModValue();
end;
//英雄无目标下可召唤宝宝 20080615
procedure TfrmHeroConfig.CheckBoxHeroNoTargetCallClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroNoTargetCall := CheckBoxHeroNoTargetCall.Checked;
  ModValue();
end;
//饮酒减少合击伤害 20080626
procedure TfrmHeroConfig.SpinEditDecDragonHitPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecDragonHitPoint := SpinEditDecDragonHitPoint.Value;
  ModValue();
end;
//20080708
procedure TfrmHeroConfig.GridLevelExpSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmHeroConfig.EditNoEditKillMonExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroNoKillMonExpRate := EditNoEditKillMonExpRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditDecDragonRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecDragonRate := EditDecDragonRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode50Click(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode50.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode50 := False;
  end else begin
    g_Config.btHeroSkillMode50 := True;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode50AllClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode50All.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode50 := True;
  end else begin
    g_Config.btHeroSkillMode50 := False;
  end;
  ModValue();
end;
//英雄召唤分身HP的比率 20080907
procedure TfrmHeroConfig.SpinEditHeroSkill46MaxHP_0Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill46MaxHP_0 := SpinEditHeroSkill46MaxHP_0.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatItemTick1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPMPTick1 := SpinEditEatItemTick1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatHPItemRate1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPRate1 := SpinEditEatHPItemRate1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatMPItemRate1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddMPRate1 := SpinEditEatMPItemRate1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode_63Click(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode_63.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode_63 := False;
  end else begin
    g_Config.btHeroSkillMode_63 := True;
  end;
  ModValue();

end;

procedure TfrmHeroConfig.RadioHeroSkillMode_63ALLClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode_63ALL.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode_63 := True;
  end else begin
    g_Config.btHeroSkillMode_63 := False;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode46Click(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode46.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode46 := False;
  end else begin
    g_Config.btHeroSkillMode46 := True;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode46AllClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode46All.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode46 := True;
  end else begin
    g_Config.btHeroSkillMode46 := False;
  end;
  ModValue();
end;

//英雄休息不跟随主人切换地图 20081209
procedure TfrmHeroConfig.CheckBoxHeroRestNoFollowClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boRestNoFollow := CheckBoxHeroRestNoFollow.Checked;
  ModValue();
end;

//末日审判  攻击范围 20081216
procedure TfrmHeroConfig.EditHeroAttackRange_64Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAttackRange_64 := EditHeroAttackRange_64.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroMakeSelfTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroMakeSelfTick := SpinEditHeroMakeSelfTick.Value;
  ModValue();
end;
//1级 英雄召唤分身HP的比率 20081217
procedure TfrmHeroConfig.SpinEditHeroSkill46MaxHP_1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill46MaxHP_1 := SpinEditHeroSkill46MaxHP_1.Value;
  ModValue();
end;
//2级 英雄召唤分身HP的比率 20081217
procedure TfrmHeroConfig.SpinEditHeroSkill46MaxHP_2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill46MaxHP_2 := SpinEditHeroSkill46MaxHP_2.Value;
  ModValue();
end;
//3级 英雄召唤分身HP的比率 20081217
procedure TfrmHeroConfig.SpinEditHeroSkill46MaxHP_3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill46MaxHP_3 := SpinEditHeroSkill46MaxHP_3.Value;
  ModValue();
end;

//道法22前是否物理攻击 20081218
procedure TfrmHeroConfig.CheckBoxHeroAttackTargetClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroAttackTarget := CheckBoxHeroAttackTarget.Checked;
  ModValue();
end;
//战英雄HP为人物的倍数 20081219
procedure TfrmHeroConfig.SpinEditHeroHPRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroHPRate := SpinEditHeroHPRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode43Click(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode43.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode43 := False;
  end else begin
    g_Config.btHeroSkillMode43 := True;
  end;
  ModValue();
end;

procedure TfrmHeroConfig.RadioHeroSkillMode43AllClick(Sender: TObject);
var
  boFalg: Boolean;
begin
  if not boOpened then Exit;
  boFalg := RadioHeroSkillMode43All.Checked;
  if boFalg then begin
    g_Config.btHeroSkillMode43 := True;
  end else begin
    g_Config.btHeroSkillMode43 := False;
  end;
  ModValue();
end;
//道22后是否物理攻击 20090108
procedure TfrmHeroConfig.CheckBoxHeroAttackTaoClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroAttackTao := CheckBoxHeroAttackTao.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.FormDestroy(Sender: TObject);
begin
  frmHeroConfig:= nil;
end;

procedure TfrmHeroConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmHeroConfig.SpinEditHeroHPRate1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroHPRate1 := SpinEditHeroHPRate1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroHPRate2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroHPRate2 := SpinEditHeroHPRate2.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroSkill43HPRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill43HPRate := SpinEditHeroSkill43HPRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxProtectPickUpItemClick(Sender: TObject);
begin
  if not boOpened then Exit; 
  g_Config.boProtectPickUpItem := CheckBoxProtectPickUpItem.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxStopProtectOnChangMapClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boStopProtectOnChangMap := CheckBoxStopProtectOnChangMap.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.CheckBoxHeroAttackNoFollowClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroAttackNoFollow := CheckBoxHeroAttackNoFollow.Checked;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroProtectLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroProtectLevel := SpinEditHeroProtectLevel.Value;
  ModValue();
end;

procedure TfrmHeroConfig.Button1Click(Sender: TObject);
begin
  Config.WriteInteger('HeroSetup', 'HeroProtectLevel', g_Config.nHeroProtectLevel);
  Config.WriteInteger('HeroSetup', 'RecallHeroTime', g_Config.nRecallHeroTime); //召唤英雄间隔 20071201
  Config.WriteInteger('HeroSetup', 'RecallDeputyHeroTime', g_Config.nRecallDeputyHeroTime);//召唤副将英雄间隔

  Config.WriteInteger('HeroSetup', 'Strength1DecGold', g_Config.nStrength1DecGold);
  Config.WriteInteger('HeroSetup', 'Strength2DecGold', g_Config.nStrength2DecGold);
  Config.WriteInteger('HeroSetup', 'Strength3DecGold', g_Config.nStrength3DecGold);
  Config.WriteInteger('HeroSetup', 'Strength1DecGameGird', g_Config.nStrength1DecGameGird);
  Config.WriteInteger('HeroSetup', 'Strength2DecGameGird', g_Config.nStrength2DecGameGird);
  Config.WriteInteger('HeroSetup', 'Strength3DecGameGird', g_Config.nStrength3DecGameGird);
  Config.WriteInteger('HeroSetup', 'Strength1Exp', g_Config.nStrength1Exp);
  Config.WriteInteger('HeroSetup', 'Strength2Exp', g_Config.nStrength2Exp);
  Config.WriteInteger('HeroSetup', 'Strength3Exp', g_Config.nStrength3Exp);
  Config.WriteInteger('HeroSetup', 'DeputyHeroExpRate', g_Config.nDeputyHeroExpRate);//副将英雄经验倍数

  Config.WriteBool('HeroSetup', 'boAutoHeroUseEat', g_Config.boAutoHeroUseEat);
  Config.WriteInteger('HeroSetup', 'HeroAddHPRate', g_Config.nHeroAddHPRate);
  Config.WriteInteger('HeroSetup', 'HeroAddMPRate', g_Config.nHeroAddMPRate);
  Config.WriteInteger('HeroSetup', 'HeroAddHPMPTick', g_Config.nHeroAddHPMPTick);//战吃普通药速度 20080601
  Config.WriteInteger('HeroSetup', 'HeroAddHPRate1', g_Config.nHeroAddHPRate1);
  Config.WriteInteger('HeroSetup', 'HeroAddMPRate1', g_Config.nHeroAddMPRate1);
  Config.WriteInteger('HeroSetup', 'HeroAddHPMPTick1', g_Config.nHeroAddHPMPTick1);//战特殊药速度 20080910
  Config.WriteInteger('HeroSetup', 'HeroAddHPMPTickA', g_Config.nHeroAddHPMPTickA);
  Config.WriteInteger('HeroSetup', 'HeroAddHPMPTickB', g_Config.nHeroAddHPMPTickB);
  uModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroMakeSelfTick1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroMakeSelfTick1 := SpinEditHeroMakeSelfTick1.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroMakeSelfTick2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroMakeSelfTick2 := SpinEditHeroMakeSelfTick2.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditHeroMakeSelfTick3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroMakeSelfTick3 := SpinEditHeroMakeSelfTick3.Value;
  ModValue();
end;

procedure TfrmHeroConfig.GridHeroPulsLevelExpEnter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmHeroConfig.Button2Click(Sender: TObject);
var
  I: Byte;
  dwExp: LongWord;
  NeedExps0, NeedExps1, NeedExps2, NeedExps3: TExpHeroPulsLevelNeedExp;
begin
  {$IF HEROVERSION = 1}
  for I := 1 to GridHeroPulsLevelExp.RowCount - 1 do begin
    dwExp := Str_ToInt(GridHeroPulsLevelExp.Cells[1, I], 0);
    if (dwExp <= 0) then begin
      Application.MessageBox(PChar('冲脉等级 ' + IntToStr(I) + ' 经络值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridHeroPulsLevelExp.Row := I;
      GridHeroPulsLevelExp.SetFocus;
      Exit;
    end;
    NeedExps0[I - 1] := dwExp;

    dwExp := Str_ToInt(GridHeroPulsLevelExp.Cells[2, I], 0);
    if (dwExp <= 0) then begin
      Application.MessageBox(PChar('阴跷等级 ' + IntToStr(I) + ' 经络经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridHeroPulsLevelExp.Row := I;
      GridHeroPulsLevelExp.SetFocus;
      Exit;
    end;
    NeedExps1[I - 1] := dwExp;

    dwExp := Str_ToInt(GridHeroPulsLevelExp.Cells[3, I], 0);
    if (dwExp <= 0) then begin
      Application.MessageBox(PChar('阴维等级 ' + IntToStr(I) + ' 经络经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridHeroPulsLevelExp.Row := I;
      GridHeroPulsLevelExp.SetFocus;
      Exit;
    end;
    NeedExps2[I - 1] := dwExp;

    dwExp := Str_ToInt(GridHeroPulsLevelExp.Cells[4, I], 0);
    if (dwExp <= 0) then begin
      Application.MessageBox(PChar('任脉等级 ' + IntToStr(I) + ' 经络经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridHeroPulsLevelExp.Row := I;
      GridHeroPulsLevelExp.SetFocus;
      Exit;
    end;
    NeedExps3[I - 1] := dwExp;
  end;
  g_Config.dwExpHeroPulsNeedExps0 := NeedExps0;
  g_Config.dwExpHeroPulsNeedExps1 := NeedExps1;
  g_Config.dwExpHeroPulsNeedExps2 := NeedExps2;
  g_Config.dwExpHeroPulsNeedExps3 := NeedExps3;
  for I := Low(TExpHeroPulsLevelNeedExp) to High(TExpHeroPulsLevelNeedExp) do begin
    Config.WriteString('HeroPulsNeedExps0', 'Level' + IntToStr(I), IntToStr(g_Config.dwExpHeroPulsNeedExps0[I]));
    Config.WriteString('HeroPulsNeedExps1', 'Level' + IntToStr(I), IntToStr(g_Config.dwExpHeroPulsNeedExps1[I]));
    Config.WriteString('HeroPulsNeedExps2', 'Level' + IntToStr(I), IntToStr(g_Config.dwExpHeroPulsNeedExps2[I]));
    Config.WriteString('HeroPulsNeedExps3', 'Level' + IntToStr(I), IntToStr(g_Config.dwExpHeroPulsNeedExps3[I]));
  end;
  {$IFEND}
  Config.WriteInteger('HeroSetup', 'HeroUseBatterTick', g_Config.dwHeroUseBatterTick);//英雄连击间隔 20091027
  Config.WriteInteger('HeroSetup', 'KillMonHeroPulsExpMultiple', g_Config.dwKillMonHeroPulsExpMultiple);//杀怪英雄经络修炼经验倍数
  uModValue();
end;

procedure TfrmHeroConfig.EditKillMonHeroPulsExpMultipleChange(
  Sender: TObject);
begin
  if EditKillMonHeroPulsExpMultiple.Text = '' then begin
    EditKillMonHeroPulsExpMultiple.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.dwKillMonHeroPulsExpMultiple := EditKillMonHeroPulsExpMultiple.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditHeroUseBatterTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwHeroUseBatterTick := EditHeroUseBatterTick.Value * 1000;
  ModValue();
end;

procedure TfrmHeroConfig.EditDeputyHeroRecallTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRecallDeputyHeroTime := EditDeputyHeroRecallTick.Value* 1000;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength1DecGoldChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength1DecGold := EditStrength1DecGold.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength2DecGoldChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength2DecGold := EditStrength2DecGold.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength3DecGoldChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength3DecGold := EditStrength3DecGold.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength1DecGameGirdChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength1DecGameGird := EditStrength1DecGameGird.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength2DecGameGirdChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength2DecGameGird := EditStrength2DecGameGird.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength3DecGameGirdChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength3DecGameGird := EditStrength3DecGameGird.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength1ExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength1Exp := EditStrength1Exp.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength2ExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength2Exp := EditStrength2Exp.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditStrength3ExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStrength3Exp := EditStrength3Exp.Value;
  ModValue();
end;

procedure TfrmHeroConfig.EditDeputyHeroExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDeputyHeroExpRate := EditDeputyHeroExpRate.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatItemTickAChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPMPTickA := SpinEditEatItemTickA.Value;
  ModValue();
end;

procedure TfrmHeroConfig.SpinEditEatItemTickBChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroAddHPMPTickB := SpinEditEatItemTickB.Value;
  ModValue();
end;
//四级合击减目标内力值比例 20100719
procedure TfrmHeroConfig.Edit4SKillDecNHChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.n4SKillDecNHRate := Edit4SKillDecNH.Value;
  ModValue();
end;
//四级合击减目标MP比例 20100719
procedure TfrmHeroConfig.Edit4SKillDecMPChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.n4SKillDecMPRate := Edit4SKillDecMP.Value;
  ModValue();
end;

end.
