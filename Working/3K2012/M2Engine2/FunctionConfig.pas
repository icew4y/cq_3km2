unit FunctionConfig;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ComCtrls, StdCtrls, Spin, Grids, Grobal2, MyListBox;

type
  TfrmFunctionConfig = class(TForm)
    FunctionConfigControl: TPageControl;
    Label14: TLabel;
    MonSaySheet: TTabSheet;
    TabSheet1: TTabSheet;
    PasswordSheet: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBoxEnablePasswordLock: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBoxLockGetBackItem: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    EditErrorPasswordCount: TSpinEdit;
    CheckBoxErrorCountKick: TCheckBox;
    ButtonPasswordLockSave: TButton;
    GroupBox4: TGroupBox;
    CheckBoxLockWalk: TCheckBox;
    CheckBoxLockRun: TCheckBox;
    CheckBoxLockHit: TCheckBox;
    CheckBoxLockSpell: TCheckBox;
    CheckBoxLockSendMsg: TCheckBox;
    CheckBoxLockInObMode: TCheckBox;
    CheckBoxLockLogin: TCheckBox;
    CheckBoxLockUseItem: TCheckBox;
    CheckBoxLockDropItem: TCheckBox;
    CheckBoxLockDealItem: TCheckBox;
    MagicPageControl: TPageControl;
    TabSheetGeneral: TTabSheet;
    GroupBox7: TGroupBox;
    CheckBoxHungerSystem: TCheckBox;
    ButtonGeneralSave: TButton;
    GroupBoxHunger: TGroupBox;
    CheckBoxHungerDecPower: TCheckBox;
    CheckBoxHungerDecHP: TCheckBox;
    ButtonSkillSave: TButton;
    TabSheet33: TTabSheet;
    TabSheet34: TTabSheet;
    TabSheet35: TTabSheet;
    TabSheet36: TTabSheet;
    GroupBox17: TGroupBox;
    Label12: TLabel;
    EditMagicAttackRage: TSpinEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    EditUpgradeWeaponMaxPoint: TSpinEdit;
    Label15: TLabel;
    EditUpgradeWeaponPrice: TSpinEdit;
    Label16: TLabel;
    EditUPgradeWeaponGetBackTime: TSpinEdit;
    Label17: TLabel;
    EditClearExpireUpgradeWeaponDays: TSpinEdit;
    Label18: TLabel;
    Label19: TLabel;
    GroupBox18: TGroupBox;
    ScrollBarUpgradeWeaponDCRate: TScrollBar;
    Label20: TLabel;
    EditUpgradeWeaponDCRate: TEdit;
    Label21: TLabel;
    ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar;
    EditUpgradeWeaponDCTwoPointRate: TEdit;
    Label22: TLabel;
    ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar;
    EditUpgradeWeaponDCThreePointRate: TEdit;
    GroupBox19: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    ScrollBarUpgradeWeaponSCRate: TScrollBar;
    EditUpgradeWeaponSCRate: TEdit;
    ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar;
    EditUpgradeWeaponSCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar;
    EditUpgradeWeaponSCThreePointRate: TEdit;
    GroupBox20: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    ScrollBarUpgradeWeaponMCRate: TScrollBar;
    EditUpgradeWeaponMCRate: TEdit;
    ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar;
    EditUpgradeWeaponMCTwoPointRate: TEdit;
    ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar;
    EditUpgradeWeaponMCThreePointRate: TEdit;
    ButtonUpgradeWeaponSave: TButton;
    GroupBox21: TGroupBox;
    ButtonMasterSave: TButton;
    GroupBox22: TGroupBox;
    EditMasterOKLevel: TSpinEdit;
    Label29: TLabel;
    GroupBox23: TGroupBox;
    EditMasterOKCreditPoint: TSpinEdit;
    Label30: TLabel;
    EditMasterOKBonusPoint: TSpinEdit;
    Label31: TLabel;
    GroupBox24: TGroupBox;
    ScrollBarMakeMineHitRate: TScrollBar;
    EditMakeMineHitRate: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    ScrollBarMakeMineRate: TScrollBar;
    EditMakeMineRate: TEdit;
    GroupBox25: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    ScrollBarStoneTypeRate: TScrollBar;
    EditStoneTypeRate: TEdit;
    ScrollBarGoldStoneMax: TScrollBar;
    EditGoldStoneMax: TEdit;
    Label36: TLabel;
    ScrollBarSilverStoneMax: TScrollBar;
    EditSilverStoneMax: TEdit;
    Label37: TLabel;
    ScrollBarSteelStoneMax: TScrollBar;
    EditSteelStoneMax: TEdit;
    Label38: TLabel;
    EditBlackStoneMax: TEdit;
    ScrollBarBlackStoneMax: TScrollBar;
    ButtonMakeMineSave: TButton;
    GroupBox26: TGroupBox;
    Label39: TLabel;
    EditStoneMinDura: TSpinEdit;
    Label40: TLabel;
    EditStoneGeneralDuraRate: TSpinEdit;
    Label41: TLabel;
    EditStoneAddDuraRate: TSpinEdit;
    Label42: TLabel;
    EditStoneAddDuraMax: TSpinEdit;
    TabSheet37: TTabSheet;
    GroupBox27: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    ScrollBarWinLottery1Max: TScrollBar;
    EditWinLottery1Max: TEdit;
    ScrollBarWinLottery2Max: TScrollBar;
    EditWinLottery2Max: TEdit;
    ScrollBarWinLottery3Max: TScrollBar;
    EditWinLottery3Max: TEdit;
    ScrollBarWinLottery4Max: TScrollBar;
    EditWinLottery4Max: TEdit;
    EditWinLottery5Max: TEdit;
    ScrollBarWinLottery5Max: TScrollBar;
    Label48: TLabel;
    ScrollBarWinLottery6Max: TScrollBar;
    EditWinLottery6Max: TEdit;
    EditWinLotteryRate: TEdit;
    ScrollBarWinLotteryRate: TScrollBar;
    Label49: TLabel;
    GroupBox28: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    EditWinLottery1Gold: TSpinEdit;
    EditWinLottery2Gold: TSpinEdit;
    EditWinLottery3Gold: TSpinEdit;
    EditWinLottery4Gold: TSpinEdit;
    Label54: TLabel;
    EditWinLottery5Gold: TSpinEdit;
    Label55: TLabel;
    EditWinLottery6Gold: TSpinEdit;
    ButtonWinLotterySave: TButton;
    TabSheet38: TTabSheet;
    GroupBox29: TGroupBox;
    Label56: TLabel;
    EditReNewNameColor1: TSpinEdit;
    LabelReNewNameColor1: TLabel;
    Label58: TLabel;
    EditReNewNameColor2: TSpinEdit;
    LabelReNewNameColor2: TLabel;
    Label60: TLabel;
    EditReNewNameColor3: TSpinEdit;
    LabelReNewNameColor3: TLabel;
    Label62: TLabel;
    EditReNewNameColor4: TSpinEdit;
    LabelReNewNameColor4: TLabel;
    Label64: TLabel;
    EditReNewNameColor5: TSpinEdit;
    LabelReNewNameColor5: TLabel;
    Label66: TLabel;
    EditReNewNameColor6: TSpinEdit;
    LabelReNewNameColor6: TLabel;
    Label68: TLabel;
    EditReNewNameColor7: TSpinEdit;
    LabelReNewNameColor7: TLabel;
    Label70: TLabel;
    EditReNewNameColor8: TSpinEdit;
    LabelReNewNameColor8: TLabel;
    Label72: TLabel;
    EditReNewNameColor9: TSpinEdit;
    LabelReNewNameColor9: TLabel;
    Label74: TLabel;
    EditReNewNameColor10: TSpinEdit;
    LabelReNewNameColor10: TLabel;
    ButtonReNewLevelSave: TButton;
    GroupBox30: TGroupBox;
    Label57: TLabel;
    EditReNewNameColorTime: TSpinEdit;
    Label59: TLabel;
    TabSheet39: TTabSheet;
    ButtonMonUpgradeSave: TButton;
    GroupBox32: TGroupBox;
    Label65: TLabel;
    LabelMonUpgradeColor1: TLabel;
    Label67: TLabel;
    LabelMonUpgradeColor2: TLabel;
    Label69: TLabel;
    LabelMonUpgradeColor3: TLabel;
    Label71: TLabel;
    LabelMonUpgradeColor4: TLabel;
    Label73: TLabel;
    LabelMonUpgradeColor5: TLabel;
    Label75: TLabel;
    LabelMonUpgradeColor6: TLabel;
    Label76: TLabel;
    LabelMonUpgradeColor7: TLabel;
    Label77: TLabel;
    LabelMonUpgradeColor8: TLabel;
    EditMonUpgradeColor1: TSpinEdit;
    EditMonUpgradeColor2: TSpinEdit;
    EditMonUpgradeColor3: TSpinEdit;
    EditMonUpgradeColor4: TSpinEdit;
    EditMonUpgradeColor5: TSpinEdit;
    EditMonUpgradeColor6: TSpinEdit;
    EditMonUpgradeColor7: TSpinEdit;
    EditMonUpgradeColor8: TSpinEdit;
    GroupBox31: TGroupBox;
    Label61: TLabel;
    Label63: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    EditMonUpgradeKillCount1: TSpinEdit;
    EditMonUpgradeKillCount2: TSpinEdit;
    EditMonUpgradeKillCount3: TSpinEdit;
    EditMonUpgradeKillCount4: TSpinEdit;
    EditMonUpgradeKillCount5: TSpinEdit;
    EditMonUpgradeKillCount6: TSpinEdit;
    EditMonUpgradeKillCount7: TSpinEdit;
    EditMonUpLvNeedKillBase: TSpinEdit;
    EditMonUpLvRate: TSpinEdit;
    Label84: TLabel;
    CheckBoxReNewChangeColor: TCheckBox;
    GroupBox33: TGroupBox;
    CheckBoxReNewLevelClearExp: TCheckBox;
    GroupBox34: TGroupBox;
    Label85: TLabel;
    EditPKFlagNameColor: TSpinEdit;
    LabelPKFlagNameColor: TLabel;
    Label87: TLabel;
    EditPKLevel1NameColor: TSpinEdit;
    LabelPKLevel1NameColor: TLabel;
    Label89: TLabel;
    EditPKLevel2NameColor: TSpinEdit;
    LabelPKLevel2NameColor: TLabel;
    Label91: TLabel;
    EditAllyAndGuildNameColor: TSpinEdit;
    LabelAllyAndGuildNameColor: TLabel;
    Label93: TLabel;
    EditWarGuildNameColor: TSpinEdit;
    LabelWarGuildNameColor: TLabel;
    Label95: TLabel;
    EditInFreePKAreaNameColor: TSpinEdit;
    LabelInFreePKAreaNameColor: TLabel;
    TabSheet40: TTabSheet;
    Label86: TLabel;
    EditMonUpgradeColor9: TSpinEdit;
    LabelMonUpgradeColor9: TLabel;
    GroupBox35: TGroupBox;
    CheckBoxMasterDieMutiny: TCheckBox;
    Label88: TLabel;
    EditMasterDieMutinyRate: TSpinEdit;
    Label90: TLabel;
    EditMasterDieMutinyPower: TSpinEdit;
    Label92: TLabel;
    EditMasterDieMutinySpeed: TSpinEdit;
    GroupBox36: TGroupBox;
    Label94: TLabel;
    CheckBoxSpiritMutiny: TCheckBox;
    EditSpiritMutinyTime: TSpinEdit;
    ButtonSpiritMutinySave: TButton;
    GroupBox40: TGroupBox;
    CheckBoxMonSayMsg: TCheckBox;
    ButtonMonSayMsgSave: TButton;
    ButtonUpgradeWeaponDefaulf: TButton;
    ButtonMakeMineDefault: TButton;
    ButtonWinLotteryDefault: TButton;
    TabSheet42: TTabSheet;
    GroupBox44: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    ScrollBarWeaponMakeUnLuckRate: TScrollBar;
    EditWeaponMakeUnLuckRate: TEdit;
    ScrollBarWeaponMakeLuckPoint1: TScrollBar;
    EditWeaponMakeLuckPoint1: TEdit;
    ScrollBarWeaponMakeLuckPoint2: TScrollBar;
    EditWeaponMakeLuckPoint2: TEdit;
    ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar;
    EditWeaponMakeLuckPoint2Rate: TEdit;
    EditWeaponMakeLuckPoint3: TEdit;
    ScrollBarWeaponMakeLuckPoint3: TScrollBar;
    Label110: TLabel;
    ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar;
    EditWeaponMakeLuckPoint3Rate: TEdit;
    ButtonWeaponMakeLuckDefault: TButton;
    ButtonWeaponMakeLuckSave: TButton;
    GroupBox47: TGroupBox;
    Label112: TLabel;
    CheckBoxBBMonAutoChangeColor: TCheckBox;
    EditBBMonAutoChangeColorTime: TSpinEdit;
    TabSheet44: TTabSheet;
    GroupBox49: TGroupBox;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    SpinEditSellOffCount: TSpinEdit;
    SpinEditSellOffTax: TSpinEdit;
    ButtonSellOffSave: TButton;
    TabSheet50: TTabSheet;
    GroupBox55: TGroupBox;
    CheckBoxItemName: TCheckBox;
    Label118: TLabel;
    EditItemName: TEdit;
    ButtonChangeUseItemName: TButton;
    GroupBox62: TGroupBox;
    CheckBoxStartMapEvent: TCheckBox;
    GroupBox68: TGroupBox;
    Label158: TLabel;
    EdtDecUserGameGold: TSpinEdit;
    TabSheet8: TTabSheet;
    PageControl1: TPageControl;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    GroupBox9: TGroupBox;
    CheckBoxLimitSwordLong: TCheckBox;
    GroupBox10: TGroupBox;
    Label4: TLabel;
    Label10: TLabel;
    EditSwordLongPowerRate: TSpinEdit;
    GroupBox56: TGroupBox;
    Label119: TLabel;
    Label120: TLabel;
    SpinEditSkill39Sec: TSpinEdit;
    GroupBox57: TGroupBox;
    CheckBoxDedingAllowPK: TCheckBox;
    GroupBox52: TGroupBox;
    Label135: TLabel;
    SpinEditDidingPowerRate: TSpinEdit;
    TabSheet11: TTabSheet;
    PageControl2: TPageControl;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    GroupBox14: TGroupBox;
    Label8: TLabel;
    EditSnowWindRange: TSpinEdit;
    GroupBox13: TGroupBox;
    Label7: TLabel;
    EditFireBoomRage: TSpinEdit;
    TabSheet14: TTabSheet;
    GroupBox53: TGroupBox;
    Label117: TLabel;
    Label116: TLabel;
    SpinEditFireDelayTime: TSpinEdit;
    SpinEditFirePower: TSpinEdit;
    GroupBox46: TGroupBox;
    CheckBoxFireCrossInSafeZone: TCheckBox;
    TabSheet15: TTabSheet;
    GroupBox37: TGroupBox;
    Label97: TLabel;
    EditMagTurnUndeadLevel: TSpinEdit;
    TabSheet16: TTabSheet;
    GroupBox15: TGroupBox;
    Label9: TLabel;
    EditElecBlizzardRange: TSpinEdit;
    TabSheet17: TTabSheet;
    GroupBox38: TGroupBox;
    Label98: TLabel;
    EditMagTammingLevel: TSpinEdit;
    GroupBox45: TGroupBox;
    Label111: TLabel;
    EditTammingCount: TSpinEdit;
    GroupBox39: TGroupBox;
    Label99: TLabel;
    Label100: TLabel;
    EditMagTammingTargetLevel: TSpinEdit;
    EditMagTammingHPRate: TSpinEdit;
    TabSheet18: TTabSheet;
    GroupBox41: TGroupBox;
    Label101: TLabel;
    Label102: TLabel;
    EditMabMabeHitRandRate: TSpinEdit;
    EditMabMabeHitMinLvLimit: TSpinEdit;
    GroupBox43: TGroupBox;
    Label104: TLabel;
    EditMabMabeHitMabeTimeRate: TSpinEdit;
    GroupBox42: TGroupBox;
    Label103: TLabel;
    EditMabMabeHitSucessRate: TSpinEdit;
    TabSheet19: TTabSheet;
    GroupBox51: TGroupBox;
    CheckBoxPlayObjectReduceMP: TCheckBox;
    TabSheet20: TTabSheet;
    GroupBox59: TGroupBox;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    SpinEditWarrorAttackTime: TSpinEdit;
    SpinEditWizardAttackTime: TSpinEdit;
    SpinEditTaoistAttackTime: TSpinEdit;
    GroupBox61: TGroupBox;
    CheckBoxNeedLevelHighTarget: TCheckBox;
    CheckBoxAllowReCallMobOtherHum: TCheckBox;
    GroupBox73: TGroupBox;
    Label146: TLabel;
    Label147: TLabel;
    SpinEditnCopyHumanTick: TSpinEdit;
    GroupBox79: TGroupBox;
    Label159: TLabel;
    Label160: TLabel;
    SpinEditMakeSelfTick: TSpinEdit;
    TabSheet21: TTabSheet;
    GroupBox60: TGroupBox;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    EditBagItems1: TEdit;
    EditBagItems2: TEdit;
    EditBagItems3: TEdit;
    TabSheet22: TTabSheet;
    GroupBox58: TGroupBox;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label161: TLabel;
    LabelCopyHumNameColor: TLabel;
    SpinEditAllowCopyCount: TSpinEdit;
    EditCopyHumName: TEdit;
    CheckBoxMasterName: TCheckBox;
    SpinEditPickUpItemCount: TSpinEdit;
    SpinEditEatHPItemRate: TSpinEdit;
    SpinEditEatMPItemRate: TSpinEdit;
    CheckBoxAllowGuardAttack: TCheckBox;
    EditCopyHumNameColor: TSpinEdit;
    TabSheet23: TTabSheet;
    GroupBox48: TGroupBox;
    CheckBoxGroupMbAttackPlayObject: TCheckBox;
    GroupBox54: TGroupBox;
    CheckBoxGroupMbAttackSlave: TCheckBox;
    TabSheet24: TTabSheet;
    GroupBox50: TGroupBox;
    CheckBoxPullPlayObject: TCheckBox;
    CheckBoxPullCrossInSafeZone: TCheckBox;
    TabSheet25: TTabSheet;
    PageControl3: TPageControl;
    TabSheet26: TTabSheet;
    GroupBox5: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EditBoneFammName: TEdit;
    EditBoneFammCount: TSpinEdit;
    GroupBox6: TGroupBox;
    GridBoneFamm: TStringGrid;
    TabSheet3: TTabSheet;
    GroupBox11: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EditDogzName: TEdit;
    EditDogzCount: TSpinEdit;
    GroupBox12: TGroupBox;
    GridDogz: TStringGrid;
    TabSheet4: TTabSheet;
    GroupBox16: TGroupBox;
    Label11: TLabel;
    EditAmyOunsulPoint: TSpinEdit;
    TabSheet6: TTabSheet;
    GroupBox80: TGroupBox;
    AutoCanHit: TCheckBox;
    TabSheet7: TTabSheet;
    GroupBox64: TGroupBox;
    Label134: TLabel;
    Label136: TLabel;
    FairyNameEdt: TEdit;
    SpinFairyEdt: TSpinEdit;
    GroupBox65: TGroupBox;
    GridFairy: TStringGrid;
    TabSheet27: TTabSheet;
    GroupBox71: TGroupBox;
    Label144: TLabel;
    Label145: TLabel;
    SpinEditKill43Sec: TSpinEdit;
    GroupBox74: TGroupBox;
    Label151: TLabel;
    Label152: TLabel;
    Spin43KillHitRateEdt: TSpinEdit;
    Spin43KillAttackRateEdt: TSpinEdit;
    GroupBox75: TGroupBox;
    Label153: TLabel;
    SpinEditAttackRate_43: TSpinEdit;
    TabSheet5: TTabSheet;
    GroupBox76: TGroupBox;
    Label154: TLabel;
    SpinEditAttackRate_42: TSpinEdit;
    GroupBox77: TGroupBox;
    Label155: TLabel;
    EditMagicAttackRage_42: TSpinEdit;
    TabSheet2: TTabSheet;
    PageControl4: TPageControl;
    TabSheet28: TTabSheet;
    GroupBox67: TGroupBox;
    Label141: TLabel;
    Label142: TLabel;
    EditProtectionRate: TSpinEdit;
    TabSheet29: TTabSheet;
    GroupBox81: TGroupBox;
    Label162: TLabel;
    EditMeteorFireRainRage: TSpinEdit;
    TabSheet30: TTabSheet;
    GroupBox82: TGroupBox;
    Label163: TLabel;
    Label164: TLabel;
    EditMagFireCharmTreatment: TSpinEdit;
    TabSheet31: TTabSheet;
    GroupBox83: TGroupBox;
    Label165: TLabel;
    SpinEditAttackRate_74: TSpinEdit;
    CheckBoxLockCallHero: TCheckBox;
    GroupBox84: TGroupBox;
    Label166: TLabel;
    EditMasterCount: TSpinEdit;
    TabSheet41: TTabSheet;
    GroupBox85: TGroupBox;
    Label167: TLabel;
    Label168: TLabel;
    EditAbilityUpTick: TSpinEdit;
    GroupBox86: TGroupBox;
    Label169: TLabel;
    Label170: TLabel;
    SpinEditAbilityUpUseTime: TSpinEdit;
    TabSheet43: TTabSheet;
    GroupBox87: TGroupBox;
    Label172: TLabel;
    Label174: TLabel;
    SpinEditMagChangXY: TSpinEdit;
    GroupBox88: TGroupBox;
    Label171: TLabel;
    Label173: TLabel;
    SpinEditKill42Sec: TSpinEdit;
    TabSheet45: TTabSheet;
    GroupBox89: TGroupBox;
    Label175: TLabel;
    Label176: TLabel;
    SpinEditMakeWineTime: TSpinEdit;
    GroupBox90: TGroupBox;
    Label177: TLabel;
    SpinEditMakeWineRate: TSpinEdit;
    ButtonSaveMakeWine: TButton;
    Label178: TLabel;
    SpinEditMakeWineTime1: TSpinEdit;
    Label179: TLabel;
    GroupBox91: TGroupBox;
    Label180: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    SpinEditIncAlcoholTick: TSpinEdit;
    SpinEditDesDrinkTick: TSpinEdit;
    Label184: TLabel;
    SpinEditMaxAlcoholValue: TSpinEdit;
    Label185: TLabel;
    SpinEditIncAlcoholValue: TSpinEdit;
    GroupBox92: TGroupBox;
    GridMedicineExp: TStringGrid;
    Label186: TLabel;
    SpinEditDesMedicineValue: TSpinEdit;
    Label187: TLabel;
    SpinEditDesMedicineTick: TSpinEdit;
    Label188: TLabel;
    GroupBox93: TGroupBox;
    Label189: TLabel;
    SpinEditInFountainTime: TSpinEdit;
    Label190: TLabel;
    TabSheet46: TTabSheet;
    TabSheet47: TTabSheet;
    GroupBox94: TGroupBox;
    Label191: TLabel;
    Label192: TLabel;
    SpinEditHPUpTick: TSpinEdit;
    GroupBox95: TGroupBox;
    Label193: TLabel;
    Label194: TLabel;
    SpinEditHPUpUseTime: TSpinEdit;
    GroupBox96: TGroupBox;
    GridSkill68: TStringGrid;
    GroupBox97: TGroupBox;
    Label195: TLabel;
    SpinEditMinDrinkValue67: TSpinEdit;
    Label196: TLabel;
    GroupBox98: TGroupBox;
    Label197: TLabel;
    Label198: TLabel;
    SpinEditMinDrinkValue68: TSpinEdit;
    Label199: TLabel;
    SpinEditMinGuildFountain: TSpinEdit;
    Label200: TLabel;
    Label201: TLabel;
    SpinEditDecGuildFountain: TSpinEdit;
    GroupBox99: TGroupBox;
    Label202: TLabel;
    Label203: TLabel;
    SpinEditChallengeTime: TSpinEdit;
    GroupBox100: TGroupBox;
    CheckSlaveMoveMaster: TCheckBox;
    CheckBoxShowGuildName: TCheckBox;
    GroupBox101: TGroupBox;
    Label204: TLabel;
    Label205: TLabel;
    Label206: TLabel;
    Label207: TLabel;
    Label208: TLabel;
    Label209: TLabel;
    SpinEditStartHPRock: TSpinEdit;
    SpinEditRockAddHP: TSpinEdit;
    SpinEditHPRockDecDura: TSpinEdit;
    SpinEditHPRockSpell: TSpinEdit;
    GroupBox102: TGroupBox;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label213: TLabel;
    Label214: TLabel;
    Label215: TLabel;
    SpinEditStartMPRock: TSpinEdit;
    SpinEditRockAddMP: TSpinEdit;
    SpinEditMPRockDecDura: TSpinEdit;
    SpinEditMPRockSpell: TSpinEdit;
    GroupBox103: TGroupBox;
    Label216: TLabel;
    Label217: TLabel;
    Label218: TLabel;
    Label219: TLabel;
    Label220: TLabel;
    Label221: TLabel;
    SpinEditStartHPMPRock: TSpinEdit;
    SpinEditRockAddHPMP: TSpinEdit;
    SpinEditHPMPRockDecDura: TSpinEdit;
    SpinEditHPMPRockSpell: TSpinEdit;
    TabSheet48: TTabSheet;
    GroupBox104: TGroupBox;
    RadioboSkill31EffectFalse: TRadioButton;
    RadioboSkill31EffectTrue: TRadioButton;
    GroupBox105: TGroupBox;
    Label222: TLabel;
    SpinEditSkill66Rate: TSpinEdit;
    GroupBox106: TGroupBox;
    Label223: TLabel;
    Label224: TLabel;
    EditProtectionOKRate: TSpinEdit;
    TabSheet49: TTabSheet;
    PageControl5: TPageControl;
    TabSheet51: TTabSheet;
    GroupBox107: TGroupBox;
    Label225: TLabel;
    SpinEditSkill69NG: TSpinEdit;
    Label226: TLabel;
    SpinEditSkill69NGExp: TSpinEdit;
    Label227: TLabel;
    SpinEditHeroSkill69NGExp: TSpinEdit;
    GroupBox109: TGroupBox;
    Label229: TLabel;
    SpinEditDrinkIncNHExp: TSpinEdit;
    Label230: TLabel;
    SpinEditHitStruckDecNH: TSpinEdit;
    CheckBoxAbilityUpFixMode: TCheckBox;
    SpinEditAbilityUpFixUseTime: TSpinEdit;
    Label231: TLabel;
    TabSheet52: TTabSheet;
    GroupBox110: TGroupBox;
    Label232: TLabel;
    SpinEditAttackRate_26: TSpinEdit;
    GroupBox111: TGroupBox;
    Label233: TLabel;
    EditKillMonNGExpMultiple: TSpinEdit;
    Label234: TLabel;
    SpinEditNPCNameColor: TSpinEdit;
    LabelNPCNameColor: TLabel;
    GroupBox114: TGroupBox;
    Label237: TLabel;
    SpinEditOrdinarySkill66Rate: TSpinEdit;
    GroupBox115: TGroupBox;
    Label137: TLabel;
    SpinFairyDuntRateEdt: TSpinEdit;
    Label138: TLabel;
    SpinFairyAttackRateEdt: TSpinEdit;
    Label238: TLabel;
    SpinEditFairyDuntRateBelow: TSpinEdit;
    TabSheet53: TTabSheet;
    GroupBoxLevelExp: TGroupBox;
    GridExpCrystalLevelExp: TStringGrid;
    ButtonExpCrystalSave: TButton;
    GroupBox72: TGroupBox;
    Label148: TLabel;
    EditHeroCrystalExpRate: TSpinEdit;
    CheckBoxGroupMbAttackPlayMon: TCheckBox;
    TabSheet54: TTabSheet;
    GroupBox116: TGroupBox;
    Label149: TLabel;
    SpinEditUseItmeToMonRate: TSpinEdit;
    ButtonWealthAnimalMonSave: TButton;
    GroupBox117: TGroupBox;
    GroupBox118: TGroupBox;
    Label150: TLabel;
    SpinEditMonGameGird: TSpinEdit;
    GroupBox119: TGroupBox;
    Label239: TLabel;
    EditGetCattleGasvalue: TSpinEdit;
    Label240: TLabel;
    SpinEditIncMonGameGird: TSpinEdit;
    GroupBox120: TGroupBox;
    Label241: TLabel;
    SpinEditAutoOpenBoxID1: TSpinEdit;
    GroupBox121: TGroupBox;
    AutoCanHit59: TCheckBox;
    SpinEditCattleGasvalueLevelExp: TSpinEdit;
    Label242: TLabel;
    Label243: TLabel;
    SpinEditAutoOpenBoxID2: TSpinEdit;
    Label244: TLabel;
    SpinEditAutoOpenBoxID3: TSpinEdit;
    Label245: TLabel;
    SpinEditAutoOpenBoxID4: TSpinEdit;
    CheckBoxShowSysHint: TCheckBox;
    TabSheet55: TTabSheet;
    PageControl6: TPageControl;
    TabSheet56: TTabSheet;
    GroupBox122: TGroupBox;
    Label246: TLabel;
    Label247: TLabel;
    Label248: TLabel;
    PulsePointNGLevel0: TSpinEdit;
    PulsePointNGLevel1: TSpinEdit;
    PulsePointNGLevel2: TSpinEdit;
    Label249: TLabel;
    PulsePointNGLevel4: TSpinEdit;
    Label250: TLabel;
    PulsePointNGLevel3: TSpinEdit;
    GroupBox123: TGroupBox;
    Label251: TLabel;
    Label252: TLabel;
    Label253: TLabel;
    Label254: TLabel;
    Label255: TLabel;
    PulsePointNGLevel5: TSpinEdit;
    PulsePointNGLevel6: TSpinEdit;
    PulsePointNGLevel7: TSpinEdit;
    PulsePointNGLevel9: TSpinEdit;
    PulsePointNGLevel8: TSpinEdit;
    GroupBox124: TGroupBox;
    Label256: TLabel;
    Label257: TLabel;
    Label258: TLabel;
    Label259: TLabel;
    Label260: TLabel;
    PulsePointNGLevel10: TSpinEdit;
    PulsePointNGLevel11: TSpinEdit;
    PulsePointNGLevel12: TSpinEdit;
    PulsePointNGLevel14: TSpinEdit;
    PulsePointNGLevel13: TSpinEdit;
    GroupBox125: TGroupBox;
    Label261: TLabel;
    Label262: TLabel;
    Label263: TLabel;
    Label264: TLabel;
    Label265: TLabel;
    PulsePointNGLevel15: TSpinEdit;
    PulsePointNGLevel16: TSpinEdit;
    PulsePointNGLevel17: TSpinEdit;
    PulsePointNGLevel19: TSpinEdit;
    PulsePointNGLevel18: TSpinEdit;
    Button1: TButton;
    TabSheet57: TTabSheet;
    GroupBox126: TGroupBox;
    Label267: TLabel;
    Label269: TLabel;
    EditUseBatterTick: TSpinEdit;
    GroupBox127: TGroupBox;
    Label266: TLabel;
    EditStormsHitRate1: TSpinEdit;
    TabSheet58: TTabSheet;
    TabSheet59: TTabSheet;
    TabSheet60: TTabSheet;
    PageControl7: TPageControl;
    TabSheet63: TTabSheet;
    TabSheet64: TTabSheet;
    GroupBox128: TGroupBox;
    EditStormsHitAppearRate1: TSpinEdit;
    Label291: TLabel;
    Label289: TLabel;
    EditStormsHitAppearRate2: TSpinEdit;
    Label290: TLabel;
    EditStormsHitAppearRate3: TSpinEdit;
    Label292: TLabel;
    EditStormsHitAppearRate4: TSpinEdit;
    Label293: TLabel;
    EditStormsHitAppearRate5: TSpinEdit;
    PageControl8: TPageControl;
    TabSheet68: TTabSheet;
    PageControl9: TPageControl;
    TabSheet72: TTabSheet;
    GroupBox129: TGroupBox;
    Label268: TLabel;
    EditSkillFireRange_87: TSpinEdit;
    GroupBox130: TGroupBox;
    Label270: TLabel;
    EditSkillFireRange_86: TSpinEdit;
    Label271: TLabel;
    EditStormsHitRate2: TSpinEdit;
    Label272: TLabel;
    EditStormsHitRate3: TSpinEdit;
    Label273: TLabel;
    EditStormsHitRate4: TSpinEdit;
    Label274: TLabel;
    EditStormsHitRate5: TSpinEdit;
    GroupBox131: TGroupBox;
    Label275: TLabel;
    EditSkillFireRange_85: TSpinEdit;
    GroupBox133: TGroupBox;
    Label281: TLabel;
    EditSkillFireRange_82: TSpinEdit;
    Label282: TLabel;
    SpinEditMon79CrazyRate: TSpinEdit;
    GroupBox132: TGroupBox;
    Label276: TLabel;
    EditBatterSkillPoinson_86: TSpinEdit;
    GroupBox134: TGroupBox;
    Label277: TLabel;
    EditBatterSkillPoinson_87: TSpinEdit;
    Label278: TLabel;
    SpinEditSkill69NGExp1: TSpinEdit;
    Label279: TLabel;
    SpinEditHeroSkill69NGExp1: TSpinEdit;
    CheckBoxUseNGItemIncExp: TCheckBox;
    GroupBox112: TGroupBox;
    Label235: TLabel;
    SpinEditNGSkillRate: TSpinEdit;
    GroupBox135: TGroupBox;
    Label280: TLabel;
    SpinEditBatterDecDamageRate: TSpinEdit;
    Label283: TLabel;
    SpinEditBatterRandDecDamageRate: TSpinEdit;
    Label228: TLabel;
    SpinEditdwIncNHTime: TSpinEdit;
    GroupBox108: TGroupBox;
    Label287: TLabel;
    Label288: TLabel;
    SpinEditWarrNGLevelIncDC: TSpinEdit;
    SpinEditWarrNGLevelIncAC: TSpinEdit;
    SpinEditWizardNGLevelIncDC: TSpinEdit;
    SpinEditWizardNGLevelIncAC: TSpinEdit;
    Label236: TLabel;
    SpinEditMon79CrazyTime: TSpinEdit;
    TabSheet61: TTabSheet;
    GroupBox113: TGroupBox;
    Label284: TLabel;
    Label285: TLabel;
    SpinEditKill69Sec: TSpinEdit;
    Label286: TLabel;
    SpinEditMakeWineLevelRate: TSpinEdit;
    TabSheet62: TTabSheet;
    GroupBox66: TGroupBox;
    Label139: TLabel;
    Label140: TLabel;
    EditSacredName: TEdit;
    EditSacredCount: TSpinEdit;
    GroupBox69: TGroupBox;
    GridSacred: TStringGrid;
    TabSheet65: TTabSheet;
    GroupBox70: TGroupBox;
    GroupBox136: TGroupBox;
    GridSkill95: TStringGrid;
    CheckBoxHeroMutinyDie: TCheckBox;
    CheckBoxAbilityAddMode: TCheckBox;
    Label156: TLabel;
    SpinEdit3: TSpinEdit;
    Label296: TLabel;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    GroupBox137: TGroupBox;
    Label295: TLabel;
    Label297: TLabel;
    Label298: TLabel;
    Label299: TLabel;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    SpinEdit8: TSpinEdit;
    SpinEdit9: TSpinEdit;
    CheckBoxAssignmentCryst: TCheckBox;
    CheckBoxFairyShareMasterMP: TCheckBox;
    AutoCanHit45: TCheckBox;
    TabSheet66: TTabSheet;
    GroupBox138: TGroupBox;
    Label300: TLabel;
    EditBloodSoulRate: TSpinEdit;
    GroupBox139: TGroupBox;
    Label301: TLabel;
    Label302: TLabel;
    EditUseBloodSoul: TSpinEdit;
    Label303: TLabel;
    EditBloodSoulHitRate: TSpinEdit;
    GroupBox140: TGroupBox;
    Label304: TLabel;
    EditNotGNDecHPRate: TSpinEdit;
    CheckBoxAttackMasterTarget: TCheckBox;
    GroupBox141: TGroupBox;
    Label96: TLabel;
    SpinEditExplosion_97Range: TSpinEdit;
    Label305: TLabel;
    SpinEditExplosion_98Range: TSpinEdit;
    GroupBox142: TGroupBox;
    CheckBoxOpenSelfShop: TCheckBox;
    CheckBoxSafeZoneShop: TCheckBox;
    CheckBoxMapShop: TCheckBox;
    CheckBoxOffLineShop: TCheckBox;
    CheckBoxAttackFFT_96: TCheckBox;
    Label306: TLabel;
    SpinEditTaosNGLevelIncDC: TSpinEdit;
    SpinEditTaosNGLevelIncAC: TSpinEdit;
    GroupBox143: TGroupBox;
    Label308: TLabel;
    Label309: TLabel;
    EditArmsTearPriceRate: TSpinEdit;
    EditArmsCritRate: TSpinEdit;
    TabSheet67: TTabSheet;
    Label307: TLabel;
    SpinEditShopLevel: TSpinEdit;
    AddValuePageControl: TPageControl;
    TabSheet69: TTabSheet;
    TabSheet70: TTabSheet;
    GroupBox145: TGroupBox;
    Label315: TLabel;
    Label316: TLabel;
    Label317: TLabel;
    EditArmsDCAddValueMaxLimit: TSpinEdit;
    EditArmsDCAddValueRate: TSpinEdit;
    EditArmsDCAddRate: TSpinEdit;
    TabSheet71: TTabSheet;
    Label324: TLabel;
    TabSheet73: TTabSheet;
    TabSheet75: TTabSheet;
    TabSheet76: TTabSheet;
    TabSheet78: TTabSheet;
    Label414: TLabel;
    Label415: TLabel;
    TabSheet79: TTabSheet;
    ButtonSaveKamPo: TButton;
    GroupBox146: TGroupBox;
    Label314: TLabel;
    Label318: TLabel;
    Label319: TLabel;
    EditArmsMCAddValueMaxLimit: TSpinEdit;
    EditArmsMCAddValueRate: TSpinEdit;
    EditArmsMCAddRate: TSpinEdit;
    GroupBox147: TGroupBox;
    Label320: TLabel;
    Label321: TLabel;
    Label322: TLabel;
    EditArmsSCAddValueMaxLimit: TSpinEdit;
    EditArmsSCAddValueRate: TSpinEdit;
    EditArmsSCAddRate: TSpinEdit;
    GroupBox186: TGroupBox;
    Label323: TLabel;
    Label448: TLabel;
    Label449: TLabel;
    EditArmsMainAddValueMaxLimit: TSpinEdit;
    EditArmsMainAddValueRate: TSpinEdit;
    EditArmsMainAddRate: TSpinEdit;
    TabSheet80: TTabSheet;
    GroupBox187: TGroupBox;
    Label450: TLabel;
    Label451: TLabel;
    Label452: TLabel;
    EditArmsQSAddValueMaxLimit: TSpinEdit;
    EditArmsQSAddValueRate: TSpinEdit;
    EditArmsQSAddRate: TSpinEdit;
    GroupBox188: TGroupBox;
    Label453: TLabel;
    Label454: TLabel;
    Label455: TLabel;
    EditArmsJMAddValueMaxLimit: TSpinEdit;
    EditArmsJMAddValueRate: TSpinEdit;
    EditArmsJMAddRate: TSpinEdit;
    GroupBox189: TGroupBox;
    Label456: TLabel;
    Label457: TLabel;
    Label458: TLabel;
    EditArmsNSAddValueMaxLimit: TSpinEdit;
    EditArmsNSAddValueRate: TSpinEdit;
    EditArmsNSAddRate: TSpinEdit;
    GroupBox190: TGroupBox;
    Label459: TLabel;
    Label460: TLabel;
    Label461: TLabel;
    EditArmsBJAddValueMaxLimit: TSpinEdit;
    EditArmsBJAddValueRate: TSpinEdit;
    EditArmsBJAddRate: TSpinEdit;
    GroupBox191: TGroupBox;
    Label462: TLabel;
    Label463: TLabel;
    Label464: TLabel;
    EditArmsHJAddValueMaxLimit: TSpinEdit;
    EditArmsHJAddValueRate: TSpinEdit;
    EditArmsHJAddRate: TSpinEdit;
    GroupBox192: TGroupBox;
    Label465: TLabel;
    Label466: TLabel;
    Label467: TLabel;
    EditArmsMBAddValueMaxLimit: TSpinEdit;
    EditArmsMBAddValueRate: TSpinEdit;
    EditArmsMBAddRate: TSpinEdit;
    GroupBox193: TGroupBox;
    Label468: TLabel;
    Label469: TLabel;
    Label470: TLabel;
    EditArmsFBAddValueMaxLimit: TSpinEdit;
    EditArmsFBAddValueRate: TSpinEdit;
    EditArmsFBAddRate: TSpinEdit;
    GroupBox194: TGroupBox;
    Label471: TLabel;
    Label472: TLabel;
    Label473: TLabel;
    EditArmsZQAddValueMaxLimit: TSpinEdit;
    EditArmsZQAddValueRate: TSpinEdit;
    EditArmsZQAddRate: TSpinEdit;
    Label474: TLabel;
    GroupBox148: TGroupBox;
    Label325: TLabel;
    Label326: TLabel;
    Label327: TLabel;
    EditDressDCAddValueMaxLimit: TSpinEdit;
    EditDressDCAddValueRate: TSpinEdit;
    EditDressDCAddRate: TSpinEdit;
    GroupBox149: TGroupBox;
    Label328: TLabel;
    Label329: TLabel;
    Label330: TLabel;
    EditDressMCAddValueMaxLimit: TSpinEdit;
    EditDressMCAddValueRate: TSpinEdit;
    EditDressMCAddRate: TSpinEdit;
    GroupBox150: TGroupBox;
    Label331: TLabel;
    Label332: TLabel;
    Label333: TLabel;
    EditDressSCAddValueMaxLimit: TSpinEdit;
    EditDressSCAddValueRate: TSpinEdit;
    EditDressSCAddRate: TSpinEdit;
    GroupBox151: TGroupBox;
    Label334: TLabel;
    Label335: TLabel;
    Label336: TLabel;
    EditDressMainAddValueMaxLimit: TSpinEdit;
    EditDressMainAddValueRate: TSpinEdit;
    EditDressMainAddRate: TSpinEdit;
    GroupBox152: TGroupBox;
    Label337: TLabel;
    Label338: TLabel;
    Label339: TLabel;
    EditDressQSAddValueMaxLimit: TSpinEdit;
    EditDressQSAddValueRate: TSpinEdit;
    EditDressQSAddRate: TSpinEdit;
    GroupBox153: TGroupBox;
    Label341: TLabel;
    Label342: TLabel;
    Label343: TLabel;
    EditDressJMAddValueMaxLimit: TSpinEdit;
    EditDressJMAddValueRate: TSpinEdit;
    EditDressJMAddRate: TSpinEdit;
    GroupBox154: TGroupBox;
    Label344: TLabel;
    Label345: TLabel;
    Label346: TLabel;
    EditDressXXAddValueMaxLimit: TSpinEdit;
    EditDressXXAddValueRate: TSpinEdit;
    EditDressXXAddRate: TSpinEdit;
    GroupBox155: TGroupBox;
    Label347: TLabel;
    Label348: TLabel;
    Label349: TLabel;
    EditDressBJAddValueMaxLimit: TSpinEdit;
    EditDressBJAddValueRate: TSpinEdit;
    EditDressBJAddRate: TSpinEdit;
    GroupBox156: TGroupBox;
    Label350: TLabel;
    Label351: TLabel;
    Label352: TLabel;
    EditDressHJAddValueMaxLimit: TSpinEdit;
    EditDressHJAddValueRate: TSpinEdit;
    EditDressHJAddRate: TSpinEdit;
    GroupBox157: TGroupBox;
    Label353: TLabel;
    Label354: TLabel;
    Label355: TLabel;
    EditDressMBAddValueRate: TSpinEdit;
    EditDressMBAddRate: TSpinEdit;
    GroupBox158: TGroupBox;
    Label356: TLabel;
    Label357: TLabel;
    Label358: TLabel;
    EditDressNLAddValueMaxLimit: TSpinEdit;
    EditDressNLAddValueRate: TSpinEdit;
    EditDressNLAddRate: TSpinEdit;
    GroupBox159: TGroupBox;
    Label359: TLabel;
    Label360: TLabel;
    Label361: TLabel;
    EditDressWFAddValueMaxLimit: TSpinEdit;
    EditDressWFAddValueRate: TSpinEdit;
    EditDressWFAddRate: TSpinEdit;
    EditDressMBAddValueMaxLimit: TSpinEdit;
    GroupBox160: TGroupBox;
    Label362: TLabel;
    Label363: TLabel;
    Label364: TLabel;
    EditNecklaceDCAddValueMaxLimit: TSpinEdit;
    EditNecklaceDCAddValueRate: TSpinEdit;
    EditNecklaceDCAddRate: TSpinEdit;
    GroupBox161: TGroupBox;
    Label365: TLabel;
    Label366: TLabel;
    Label367: TLabel;
    EditNecklaceMCAddValueMaxLimit: TSpinEdit;
    EditNecklaceMCAddValueRate: TSpinEdit;
    EditNecklaceMCAddRate: TSpinEdit;
    GroupBox162: TGroupBox;
    Label368: TLabel;
    Label369: TLabel;
    Label370: TLabel;
    EditNecklaceSCAddValueMaxLimit: TSpinEdit;
    EditNecklaceSCAddValueRate: TSpinEdit;
    EditNecklaceSCAddRate: TSpinEdit;
    GroupBox163: TGroupBox;
    Label371: TLabel;
    Label373: TLabel;
    Label374: TLabel;
    EditNecklaceMainAddValueMaxLimit: TSpinEdit;
    EditNecklaceMainAddValueRate: TSpinEdit;
    EditNecklaceMainAddRate: TSpinEdit;
    GroupBox165: TGroupBox;
    Label378: TLabel;
    Label379: TLabel;
    Label380: TLabel;
    EditNecklaceXXAddValueMaxLimit: TSpinEdit;
    EditNecklaceXXAddValueRate: TSpinEdit;
    EditNecklaceXXAddRate: TSpinEdit;
    GroupBox167: TGroupBox;
    Label384: TLabel;
    Label385: TLabel;
    Label386: TLabel;
    EditNecklaceQSAddValueMaxLimit: TSpinEdit;
    EditNecklaceQSAddValueRate: TSpinEdit;
    EditNecklaceQSAddRate: TSpinEdit;
    GroupBox168: TGroupBox;
    Label387: TLabel;
    Label389: TLabel;
    Label390: TLabel;
    EditNecklaceHJAddValueMaxLimit: TSpinEdit;
    EditNecklaceHJAddValueRate: TSpinEdit;
    EditNecklaceHJAddRate: TSpinEdit;
    GroupBox170: TGroupBox;
    Label394: TLabel;
    Label395: TLabel;
    Label396: TLabel;
    EditNecklaceNLAddValueMaxLimit: TSpinEdit;
    EditNecklaceNLAddValueRate: TSpinEdit;
    EditNecklaceNLAddRate: TSpinEdit;
    GroupBox171: TGroupBox;
    Label397: TLabel;
    Label398: TLabel;
    Label399: TLabel;
    EditNecklaceMFAddValueMaxLimit: TSpinEdit;
    EditNecklaceMFAddValueRate: TSpinEdit;
    EditNecklaceMFAddRate: TSpinEdit;
    GroupBox172: TGroupBox;
    Label400: TLabel;
    Label401: TLabel;
    Label402: TLabel;
    EditBraceletDCAddValueMaxLimit: TSpinEdit;
    EditBraceletDCAddValueRate: TSpinEdit;
    EditBraceletDCAddRate: TSpinEdit;
    GroupBox173: TGroupBox;
    Label403: TLabel;
    Label404: TLabel;
    Label405: TLabel;
    EditBraceletMCAddValueMaxLimit: TSpinEdit;
    EditBraceletMCAddValueRate: TSpinEdit;
    EditBraceletMCAddRate: TSpinEdit;
    GroupBox174: TGroupBox;
    Label406: TLabel;
    Label407: TLabel;
    Label408: TLabel;
    EditBraceletSCAddValueMaxLimit: TSpinEdit;
    EditBraceletSCAddValueRate: TSpinEdit;
    EditBraceletSCAddRate: TSpinEdit;
    GroupBox175: TGroupBox;
    Label409: TLabel;
    Label410: TLabel;
    Label411: TLabel;
    EditBraceletMainAddValueMaxLimit: TSpinEdit;
    EditBraceletMainAddValueRate: TSpinEdit;
    EditBraceletMainAddRate: TSpinEdit;
    GroupBox176: TGroupBox;
    Label412: TLabel;
    Label413: TLabel;
    Label416: TLabel;
    EditBraceletQSAddValueMaxLimit: TSpinEdit;
    EditBraceletQSAddValueRate: TSpinEdit;
    EditBraceletQSAddRate: TSpinEdit;
    GroupBox177: TGroupBox;
    Label417: TLabel;
    Label418: TLabel;
    Label419: TLabel;
    EditBraceletXXAddValueMaxLimit: TSpinEdit;
    EditBraceletXXAddValueRate: TSpinEdit;
    EditBraceletXXAddRate: TSpinEdit;
    GroupBox179: TGroupBox;
    Label423: TLabel;
    Label424: TLabel;
    Label425: TLabel;
    EditBraceletMFAddValueMaxLimit: TSpinEdit;
    EditBraceletMFAddValueRate: TSpinEdit;
    EditBraceletMFAddRate: TSpinEdit;
    GroupBox180: TGroupBox;
    Label426: TLabel;
    Label427: TLabel;
    Label428: TLabel;
    EditBraceletNLAddValueMaxLimit: TSpinEdit;
    EditBraceletNLAddValueRate: TSpinEdit;
    EditBraceletNLAddRate: TSpinEdit;
    GroupBox183: TGroupBox;
    Label437: TLabel;
    Label438: TLabel;
    Label439: TLabel;
    EditBraceletHJAddValueMaxLimit: TSpinEdit;
    EditBraceletHJAddValueRate: TSpinEdit;
    EditBraceletHJAddRate: TSpinEdit;
    GroupBox184: TGroupBox;
    Label440: TLabel;
    Label441: TLabel;
    Label442: TLabel;
    EditRingDCAddValueMaxLimit: TSpinEdit;
    EditRingDCAddValueRate: TSpinEdit;
    EditRingDCAddRate: TSpinEdit;
    GroupBox185: TGroupBox;
    Label443: TLabel;
    Label444: TLabel;
    Label445: TLabel;
    EditRingMCAddValueMaxLimit: TSpinEdit;
    EditRingMCAddValueRate: TSpinEdit;
    EditRingMCAddRate: TSpinEdit;
    GroupBox195: TGroupBox;
    Label446: TLabel;
    Label447: TLabel;
    Label475: TLabel;
    EditRingSCAddValueMaxLimit: TSpinEdit;
    EditRingSCAddValueRate: TSpinEdit;
    EditRingSCAddRate: TSpinEdit;
    GroupBox196: TGroupBox;
    Label476: TLabel;
    Label477: TLabel;
    Label478: TLabel;
    EditRingMainAddValueMaxLimit: TSpinEdit;
    EditRingMainAddValueRate: TSpinEdit;
    EditRingMainAddRate: TSpinEdit;
    GroupBox197: TGroupBox;
    Label479: TLabel;
    Label480: TLabel;
    Label481: TLabel;
    EditRingQSAddValueMaxLimit: TSpinEdit;
    EditRingQSAddValueRate: TSpinEdit;
    EditRingQSAddRate: TSpinEdit;
    GroupBox198: TGroupBox;
    Label482: TLabel;
    Label483: TLabel;
    Label484: TLabel;
    EditRingXXAddValueMaxLimit: TSpinEdit;
    EditRingXXAddValueRate: TSpinEdit;
    EditRingXXAddRate: TSpinEdit;
    GroupBox199: TGroupBox;
    Label485: TLabel;
    Label486: TLabel;
    Label487: TLabel;
    EditRingFBAddValueMaxLimit: TSpinEdit;
    EditRingFBAddValueRate: TSpinEdit;
    EditRingFBAddRate: TSpinEdit;
    GroupBox200: TGroupBox;
    Label488: TLabel;
    Label489: TLabel;
    Label490: TLabel;
    EditRingWFAddValueMaxLimit: TSpinEdit;
    EditRingWFAddValueRate: TSpinEdit;
    EditRingWFAddRate: TSpinEdit;
    GroupBox201: TGroupBox;
    Label491: TLabel;
    Label492: TLabel;
    Label493: TLabel;
    EditRingNLAddValueMaxLimit: TSpinEdit;
    EditRingNLAddValueRate: TSpinEdit;
    EditRingNLAddRate: TSpinEdit;
    GroupBox202: TGroupBox;
    Label494: TLabel;
    Label495: TLabel;
    Label496: TLabel;
    EditRingMBAddValueMaxLimit: TSpinEdit;
    EditRingMBAddValueRate: TSpinEdit;
    EditRingMBAddRate: TSpinEdit;
    GroupBox203: TGroupBox;
    Label497: TLabel;
    Label498: TLabel;
    Label499: TLabel;
    EditRingJMAddValueMaxLimit: TSpinEdit;
    EditRingJMAddValueRate: TSpinEdit;
    EditRingJMAddRate: TSpinEdit;
    GroupBox204: TGroupBox;
    Label500: TLabel;
    Label501: TLabel;
    Label502: TLabel;
    EditRingHJAddValueMaxLimit: TSpinEdit;
    EditRingHJAddValueRate: TSpinEdit;
    EditRingHJAddRate: TSpinEdit;
    GroupBox205: TGroupBox;
    Label503: TLabel;
    Label504: TLabel;
    Label505: TLabel;
    EditHelmetDCAddValueMaxLimit: TSpinEdit;
    EditHelmetDCAddValueRate: TSpinEdit;
    EditHelmetDCAddRate: TSpinEdit;
    GroupBox206: TGroupBox;
    Label506: TLabel;
    Label507: TLabel;
    Label508: TLabel;
    EditHelmetMCAddValueMaxLimit: TSpinEdit;
    EditHelmetMCAddValueRate: TSpinEdit;
    EditHelmetMCAddRate: TSpinEdit;
    GroupBox207: TGroupBox;
    Label509: TLabel;
    Label510: TLabel;
    Label511: TLabel;
    EditHelmetSCAddValueMaxLimit: TSpinEdit;
    EditHelmetSCAddValueRate: TSpinEdit;
    EditHelmetSCAddRate: TSpinEdit;
    GroupBox208: TGroupBox;
    Label512: TLabel;
    Label513: TLabel;
    Label514: TLabel;
    EditHelmetMainAddValueMaxLimit: TSpinEdit;
    EditHelmetMainAddValueRate: TSpinEdit;
    EditHelmetMainAddRate: TSpinEdit;
    GroupBox209: TGroupBox;
    Label515: TLabel;
    Label516: TLabel;
    Label517: TLabel;
    EditHelmetQSAddValueMaxLimit: TSpinEdit;
    EditHelmetQSAddValueRate: TSpinEdit;
    EditHelmetQSAddRate: TSpinEdit;
    GroupBox210: TGroupBox;
    Label518: TLabel;
    Label519: TLabel;
    Label520: TLabel;
    EditHelmetXXAddValueMaxLimit: TSpinEdit;
    EditHelmetXXAddValueRate: TSpinEdit;
    EditHelmetXXAddRate: TSpinEdit;
    GroupBox216: TGroupBox;
    Label536: TLabel;
    Label537: TLabel;
    Label538: TLabel;
    EditHelmetHJAddValueMaxLimit: TSpinEdit;
    EditHelmetHJAddValueRate: TSpinEdit;
    EditHelmetHJAddRate: TSpinEdit;
    GroupBox217: TGroupBox;
    Label539: TLabel;
    Label540: TLabel;
    Label541: TLabel;
    EditShoesDCAddValueMaxLimit: TSpinEdit;
    EditShoesDCAddValueRate: TSpinEdit;
    EditShoesDCAddRate: TSpinEdit;
    GroupBox218: TGroupBox;
    Label542: TLabel;
    Label543: TLabel;
    Label544: TLabel;
    EditShoesMCAddValueMaxLimit: TSpinEdit;
    EditShoesMCAddValueRate: TSpinEdit;
    EditShoesMCAddRate: TSpinEdit;
    GroupBox219: TGroupBox;
    Label545: TLabel;
    Label546: TLabel;
    Label547: TLabel;
    EditShoesSCAddValueMaxLimit: TSpinEdit;
    EditShoesSCAddValueRate: TSpinEdit;
    EditShoesSCAddRate: TSpinEdit;
    GroupBox220: TGroupBox;
    Label548: TLabel;
    Label549: TLabel;
    Label550: TLabel;
    EditShoesMainAddValueMaxLimit: TSpinEdit;
    EditShoesMainAddValueRate: TSpinEdit;
    EditShoesMainAddRate: TSpinEdit;
    GroupBox221: TGroupBox;
    Label551: TLabel;
    Label552: TLabel;
    Label553: TLabel;
    EditShoesQSAddValueMaxLimit: TSpinEdit;
    EditShoesQSAddValueRate: TSpinEdit;
    EditShoesQSAddRate: TSpinEdit;
    GroupBox227: TGroupBox;
    Label569: TLabel;
    Label570: TLabel;
    Label571: TLabel;
    EditShoesJMAddValueMaxLimit: TSpinEdit;
    EditShoesJMAddValueRate: TSpinEdit;
    EditShoesJMAddRate: TSpinEdit;
    GroupBox228: TGroupBox;
    Label572: TLabel;
    Label573: TLabel;
    Label574: TLabel;
    EditShoesHJAddValueMaxLimit: TSpinEdit;
    EditShoesHJAddValueRate: TSpinEdit;
    EditShoesHJAddRate: TSpinEdit;
    GroupBox229: TGroupBox;
    Label575: TLabel;
    Label576: TLabel;
    Label577: TLabel;
    EditMedalDCAddValueMaxLimit: TSpinEdit;
    EditMedalDCAddValueRate: TSpinEdit;
    EditMedalDCAddRate: TSpinEdit;
    GroupBox230: TGroupBox;
    Label578: TLabel;
    Label579: TLabel;
    Label580: TLabel;
    EditMedalMCAddValueMaxLimit: TSpinEdit;
    EditMedalMCAddValueRate: TSpinEdit;
    EditMedalMCAddRate: TSpinEdit;
    GroupBox231: TGroupBox;
    Label581: TLabel;
    Label582: TLabel;
    Label583: TLabel;
    EditMedalSCAddValueMaxLimit: TSpinEdit;
    EditMedalSCAddValueRate: TSpinEdit;
    EditMedalSCAddRate: TSpinEdit;
    GroupBox232: TGroupBox;
    Label584: TLabel;
    Label585: TLabel;
    Label586: TLabel;
    EditMedalMainAddValueMaxLimit: TSpinEdit;
    EditMedalMainAddValueRate: TSpinEdit;
    EditMedalMainAddRate: TSpinEdit;
    GroupBox233: TGroupBox;
    Label587: TLabel;
    Label588: TLabel;
    Label589: TLabel;
    EditMedalQSAddValueMaxLimit: TSpinEdit;
    EditMedalQSAddValueRate: TSpinEdit;
    EditMedalQSAddRate: TSpinEdit;
    GroupBox234: TGroupBox;
    Label590: TLabel;
    Label591: TLabel;
    Label592: TLabel;
    EditMedalFBAddValueMaxLimit: TSpinEdit;
    EditMedalFBAddValueRate: TSpinEdit;
    EditMedalFBAddRate: TSpinEdit;
    GroupBox235: TGroupBox;
    Label593: TLabel;
    Label594: TLabel;
    Label595: TLabel;
    EditMedalBJAddValueMaxLimit: TSpinEdit;
    EditMedalBJAddValueRate: TSpinEdit;
    EditMedalBJAddRate: TSpinEdit;
    GroupBox236: TGroupBox;
    Label596: TLabel;
    Label597: TLabel;
    Label598: TLabel;
    EditMedalNSAddValueMaxLimit: TSpinEdit;
    EditMedalNSAddValueRate: TSpinEdit;
    EditMedalNSAddRate: TSpinEdit;
    GroupBox237: TGroupBox;
    Label599: TLabel;
    Label600: TLabel;
    Label601: TLabel;
    EditMedalNLAddValueMaxLimit: TSpinEdit;
    EditMedalNLAddValueRate: TSpinEdit;
    EditMedalNLAddRate: TSpinEdit;
    GroupBox238: TGroupBox;
    Label602: TLabel;
    Label603: TLabel;
    Label604: TLabel;
    EditMedalMBAddValueMaxLimit: TSpinEdit;
    EditMedalMBAddValueRate: TSpinEdit;
    EditMedalMBAddRate: TSpinEdit;
    GroupBox239: TGroupBox;
    Label605: TLabel;
    Label606: TLabel;
    Label607: TLabel;
    EditMedalJMAddValueMaxLimit: TSpinEdit;
    EditMedalJMAddValueRate: TSpinEdit;
    EditMedalJMAddRate: TSpinEdit;
    GroupBox240: TGroupBox;
    Label608: TLabel;
    Label609: TLabel;
    Label610: TLabel;
    EditMedalHJAddValueMaxLimit: TSpinEdit;
    EditMedalHJAddValueRate: TSpinEdit;
    EditMedalHJAddRate: TSpinEdit;
    GroupBox164: TGroupBox;
    Label340: TLabel;
    Label372: TLabel;
    Label375: TLabel;
    EditMysteryAddValueMaxLimit: TSpinEdit;
    EditMysteryAddValueRate: TSpinEdit;
    EditMysteryAddRate: TSpinEdit;
    TabSheet74: TTabSheet;
    Label376: TLabel;
    EditAdvancedKamPo: TSpinEdit;
    GroupBox166: TGroupBox;
    Label377: TLabel;
    Label381: TLabel;
    Label382: TLabel;
    Label383: TLabel;
    Label388: TLabel;
    Label391: TLabel;
    Label392: TLabel;
    EditRebirthRate: TSpinEdit;
    EditMagicShieldRate: TSpinEdit;
    EditParalysisRate: TSpinEdit;
    EditParalysis2Rate: TSpinEdit;
    EditParalysis1Rate: TSpinEdit;
    EditProbeNecklaceRate: TSpinEdit;
    EditTeleportRate: TSpinEdit;
    GroupBox169: TGroupBox;
    Label421: TLabel;
    EditReadRate1: TSpinEdit;
    GroupBox178: TGroupBox;
    Label393: TLabel;
    EditMakeScroll1Rate: TSpinEdit;
    Label420: TLabel;
    EditMakeScroll2Rate: TSpinEdit;
    Label422: TLabel;
    EditMakeScroll3Rate: TSpinEdit;
    Label429: TLabel;
    EditMakeScroll4Rate: TSpinEdit;
    Label430: TLabel;
    EditReadRate2: TSpinEdit;
    Label431: TLabel;
    EditReadRate3: TSpinEdit;
    Label432: TLabel;
    EditReadRate4: TSpinEdit;
    GroupBox181: TGroupBox;
    Label434: TLabel;
    Label435: TLabel;
    EditSpiritMediaAddValueRate: TSpinEdit;
    EditSpiritMediaAddRate: TSpinEdit;
    GroupBox182: TGroupBox;
    Label433: TLabel;
    EditJudgePrice: TSpinEdit;
    Label436: TLabel;
    EditMaxHeapStruckDamage: TSpinEdit;
    RadioButtonJudgeGameGold: TRadioButton;
    RadioButtonJudgeUseGold: TRadioButton;
    TabSheet32: TTabSheet;
    ButtonJewelSave: TButton;
    Label521: TLabel;
    EditFindJewelRave: TSpinEdit;
    GroupBox211: TGroupBox;
    Label522: TLabel;
    EditDigJewelHitRate: TSpinEdit;
    EditGetDigJewelRave: TSpinEdit;
    Label523: TLabel;
    GroupBox212: TGroupBox;
    Label524: TLabel;
    EditPoisonLength_87: TSpinEdit;
    Label525: TLabel;
    EditEnergyValueTime: TSpinEdit;
    CheckBoxOffLineEnergy: TCheckBox;
    TabSheet77: TTabSheet;
    CheckBoxUseCanKamPo: TCheckBox;
    GroupBox214: TGroupBox;
    Label528: TLabel;
    EditSkill101Point: TSpinEdit;
    TabSheet81: TTabSheet;
    GroupBox213: TGroupBox;
    Label526: TLabel;
    Label527: TLabel;
    SpinEditKill102Sec: TSpinEdit;
    GroupBox215: TGroupBox;
    Label529: TLabel;
    Label530: TLabel;
    EditSill102TargetDecACTime: TSpinEdit;
    CheckBoxDecSuitItemMode: TCheckBox;
    Label531: TLabel;
    EditJingYuanValue: TSpinEdit;
    GroupBox78: TGroupBox;
    EditSkill95EffectPowerWarror: TSpinEdit;
    Label143: TLabel;
    Label294: TLabel;
    EditSkill95EffectRateWarror: TSpinEdit;
    Label157: TLabel;
    EditSkill95DecInjuryWarror: TSpinEdit;
    GroupBox222: TGroupBox;
    Label532: TLabel;
    Label533: TLabel;
    Label534: TLabel;
    Skill95EffectPowerWizard: TSpinEdit;
    Skill95EffectRateWizard: TSpinEdit;
    Skill95DecInjuryWizard: TSpinEdit;
    GroupBox223: TGroupBox;
    Label535: TLabel;
    Label554: TLabel;
    Label555: TLabel;
    Skill95EffectPowerTaoist: TSpinEdit;
    Skill95EffectRateTaoist: TSpinEdit;
    Skill95DecInjuryTaoist: TSpinEdit;
    Label556: TLabel;
    LianqiGold: TSpinEdit;
    Label557: TLabel;
    LianqiGameGird: TSpinEdit;
    Label558: TLabel;
    SpinEditLimitExpNGLevel: TSpinEdit;
    GroupBox224: TGroupBox;
    Label559: TLabel;
    Label560: TLabel;
    Label561: TLabel;
    Label562: TLabel;
    Label563: TLabel;
    Label564: TLabel;
    SpinEditStartHPMPRock1: TSpinEdit;
    SpinEditRockAddHPMP1: TSpinEdit;
    SpinEditHPMPRockDecDura1: TSpinEdit;
    SpinEditHPMPRockSpell1: TSpinEdit;
    Label310: TLabel;
    SpinEditAutoExpSkill95: TSpinEdit;
    Label311: TLabel;
    SpinEditIncJingYuanValueTime: TSpinEdit;
    Label312: TLabel;
    EditIncTransferValue: TSpinEdit;
    Label313: TLabel;
    Skill95LevelDecInjury: TSpinEdit;
    Label565: TLabel;
    EditDecDuraRate: TSpinEdit;
    TabSheet82: TTabSheet;
    PageControlAI: TPageControl;
    TabSheet83: TTabSheet;
    GroupBox144: TGroupBox;
    ListBoxAIList: TMyListBox;
    GroupBox225: TGroupBox;
    Label566: TLabel;
    EditAIName: TEdit;
    ButtonAIListAdd: TButton;
    ButtonAIDel: TButton;
    GroupBox226: TGroupBox;
    Label567: TLabel;
    Label568: TLabel;
    Label611: TLabel;
    EditHomeX: TSpinEdit;
    EditHomeY: TSpinEdit;
    EditHomeMap: TEdit;
    ButtonAILogon: TButton;
    GroupBox241: TGroupBox;
    EditConfigListFileName: TEdit;
    TabSheet84: TTabSheet;
    GroupBox242: TGroupBox;
    CheckBoxAutoRepairItem: TCheckBox;
    GroupBox243: TGroupBox;
    CheckBoxRenewHealth: TCheckBox;
    GroupBox244: TGroupBox;
    Label612: TLabel;
    Label613: TLabel;
    EditRenewPercent: TSpinEdit;
    ButtonSaveAI: TButton;
    GroupBox245: TGroupBox;
    CheckBoxAutoPickUpItem: TCheckBox;
    Label614: TLabel;
    Label615: TLabel;
    EditsHeroConfigListFileName: TEdit;
    CheckBoxUseFengHaoAbil: TCheckBox;
    GroupBox246: TGroupBox;
    Label616: TLabel;
    Label617: TLabel;
    SpinEditKill55UseTime: TSpinEdit;
    TabSheet85: TTabSheet;
    GroupBox247: TGroupBox;
    Label618: TLabel;
    Label619: TLabel;
    FireFairyNameEdt: TEdit;
    SpinFireFairyEdt: TSpinEdit;
    CheckBoxFireFairyShareMasterMP: TCheckBox;
    GroupBox249: TGroupBox;
    Label620: TLabel;
    Label621: TLabel;
    Label622: TLabel;
    SpinFireFairyDuntRateEdt: TSpinEdit;
    SpinFireFairyAttackRateEdt: TSpinEdit;
    SpinEditFireFairyDuntRateBelow: TSpinEdit;
    CheckBoxFireFairyNeglectACMAC: TCheckBox;
    GroupBox248: TGroupBox;
    RadioArmsTearPriceGameGold: TRadioButton;
    RadioArmsTearPriceGold: TRadioButton;
    RadioArmsTearPriceGameGird: TRadioButton;
    RadioArmsTearPriceGameDiamond: TRadioButton;
    GroupBox250: TGroupBox;
    Label623: TLabel;
    Label624: TLabel;
    SpinEditKill101UseTime: TSpinEdit;
    GroupBox251: TGroupBox;
    Label625: TLabel;
    Label626: TLabel;
    Label627: TLabel;
    SpinAIWarrorAttackTime: TSpinEdit;
    SpinAIWizardAttackTime: TSpinEdit;
    SpinAITaoistAttackTime: TSpinEdit;
    Label628: TLabel;
    EditAIRunIntervalTime: TSpinEdit;
    Label629: TLabel;
    EditAIWalkIntervalTime: TSpinEdit;
    CheckBoxLimitSwordLongNG: TCheckBox;
    GroupBox252: TGroupBox;
    CheckBoxHPAutoMoveMap: TCheckBox;
    TabSheet86: TTabSheet;
    GroupBox253: TGroupBox;
    Label630: TLabel;
    Label631: TLabel;
    EditDoCallTroll: TSpinEdit;
    Label632: TLabel;
    EditDoCallTrollTime: TSpinEdit;
    TabSheet87: TTabSheet;
    PageControl10: TPageControl;
    TabSheet89: TTabSheet;
    TabSheet88: TTabSheet;
    TabSheet90: TTabSheet;
    EditNGStrongItem: TEdit;
    Label633: TLabel;
    Label634: TLabel;
    SpinEditSKILL_200NGStrong1: TSpinEdit;
    SpinEditSKILL_200NGStrong2: TSpinEdit;
    SpinEditSKILL_200NGStrong3: TSpinEdit;
    SpinEditSKILL_200NGStrong4: TSpinEdit;
    Label635: TLabel;
    Skill_202NGStrong1: TSpinEdit;
    Skill_202NGStrong2: TSpinEdit;
    Skill_202NGStrong3: TSpinEdit;
    Skill_202NGStrong4: TSpinEdit;
    Label636: TLabel;
    Skill_236NGStrong1: TSpinEdit;
    Skill_236NGStrong2: TSpinEdit;
    Skill_236NGStrong3: TSpinEdit;
    Skill_236NGStrong4: TSpinEdit;
    Label637: TLabel;
    Skill_204NGStrong1: TSpinEdit;
    Skill_204NGStrong2: TSpinEdit;
    Skill_204NGStrong3: TSpinEdit;
    Skill_204NGStrong4: TSpinEdit;
    Label638: TLabel;
    Skill_206NGStrong1: TSpinEdit;
    Skill_206NGStrong2: TSpinEdit;
    Skill_206NGStrong3: TSpinEdit;
    Skill_206NGStrong4: TSpinEdit;
    Label643: TLabel;
    Skill_208NGStrong0: TSpinEdit;
    Skill_208NGStrong1: TSpinEdit;
    Skill_208NGStrong2: TSpinEdit;
    Skill_208NGStrong3: TSpinEdit;
    Skill_214NGStrong3: TSpinEdit;
    Label644: TLabel;
    Label645: TLabel;
    Label646: TLabel;
    nSkill_222NGStrong3: TSpinEdit;
    nSkill_218NGStrong3: TSpinEdit;
    Skill_214NGStrong2: TSpinEdit;
    nSkill_218NGStrong2: TSpinEdit;
    nSkill_222NGStrong2: TSpinEdit;
    Skill_214NGStrong1: TSpinEdit;
    nSkill_218NGStrong1: TSpinEdit;
    nSkill_222NGStrong1: TSpinEdit;
    nSkill_222NGStrong0: TSpinEdit;
    nSkill_218NGStrong0: TSpinEdit;
    Skill_214NGStrong0: TSpinEdit;
    Label647: TLabel;
    Label648: TLabel;
    nSkill_210NGStrong0: TSpinEdit;
    nSkill_212NGStrong0: TSpinEdit;
    nSkill_210NGStrong1: TSpinEdit;
    nSkill_212NGStrong1: TSpinEdit;
    nSkill_210NGStrong2: TSpinEdit;
    nSkill_212NGStrong2: TSpinEdit;
    nSkill_210NGStrong3: TSpinEdit;
    nSkill_212NGStrong3: TSpinEdit;
    Skill_239NGStrong1: TSpinEdit;
    Label639: TLabel;
    Skill_239NGStrong2: TSpinEdit;
    Skill_239NGStrong3: TSpinEdit;
    Skill_239NGStrong4: TSpinEdit;
    Skill_230NGStrong4: TSpinEdit;
    Skill_230NGStrong3: TSpinEdit;
    Label640: TLabel;
    Skill_230NGStrong2: TSpinEdit;
    Skill_230NGStrong1: TSpinEdit;
    Label641: TLabel;
    Skill_232NGStrong1: TSpinEdit;
    Skill_232NGStrong2: TSpinEdit;
    Skill_232NGStrong3: TSpinEdit;
    Skill_232NGStrong4: TSpinEdit;
    Skill_241NGStrong4: TSpinEdit;
    Skill_241NGStrong3: TSpinEdit;
    Skill_241NGStrong2: TSpinEdit;
    Skill_241NGStrong1: TSpinEdit;
    Label642: TLabel;
    Label649: TLabel;
    Skill_228NGStrong1: TSpinEdit;
    Skill_228NGStrong2: TSpinEdit;
    Skill_228NGStrong3: TSpinEdit;
    Skill_228NGStrong4: TSpinEdit;
    Skill_234NGStrong4: TSpinEdit;
    Skill_234NGStrong3: TSpinEdit;
    Skill_234NGStrong2: TSpinEdit;
    Skill_234NGStrong1: TSpinEdit;
    Label650: TLabel;
    Label651: TLabel;
    Label652: TLabel;
    Label653: TLabel;
    Label654: TLabel;
    nSkill_216NGStrong0: TSpinEdit;
    nSkill_224NGStrong0: TSpinEdit;
    nSkill_226NGStrong0: TSpinEdit;
    nSkill_220NGStrong0: TSpinEdit;
    nSkill_216NGStrong1: TSpinEdit;
    nSkill_224NGStrong1: TSpinEdit;
    nSkill_226NGStrong1: TSpinEdit;
    nSkill_220NGStrong1: TSpinEdit;
    nSkill_216NGStrong2: TSpinEdit;
    nSkill_224NGStrong2: TSpinEdit;
    nSkill_226NGStrong2: TSpinEdit;
    nSkill_220NGStrong2: TSpinEdit;
    nSkill_216NGStrong3: TSpinEdit;
    nSkill_224NGStrong3: TSpinEdit;
    nSkill_226NGStrong3: TSpinEdit;
    nSkill_220NGStrong3: TSpinEdit;
    nNGSkillMaxLevel: TSpinEdit;
    Label655: TLabel;
    GroupBox254: TGroupBox;
    Label656: TLabel;
    PetsMonDecMaxHapp: TSpinEdit;
    PetsMonIncMaxHapp: TSpinEdit;
    Label657: TLabel;
    Label658: TLabel;
    SpinEditKill101UseLogTime: TSpinEdit;
    GroupBox255: TGroupBox;
    CheckBoxMagTammingHitNew: TCheckBox;
    CheckBoxFairyUseDBHitTime: TCheckBox;
    TabSheet91: TTabSheet;
    GroupBox256: TGroupBox;
    Label659: TLabel;
    SpinEditActivHeartNH: TSpinEdit;
    Label662: TLabel;
    SpinEditActivMemberHeartRate: TSpinEdit;
    Label664: TLabel;
    SpinEditSavvyHeartNeedLevel: TSpinEdit;
    Label665: TLabel;
    SpinEditHeartArrValueRate: TSpinEdit;
    Label666: TLabel;
    SpinEditHeartIncDamageRate: TSpinEdit;
    TabSheet93: TTabSheet;
    GroupBox258: TGroupBox;
    Label660: TLabel;
    SpinEditPublicHeartLevel: TSpinEdit;
    SpinEditDivisionSavvyRate: TSpinEdit;
    Label661: TLabel;
    Label663: TLabel;
    SpinEditMemberUseHeartTime: TSpinEdit;
    PageControl11: TPageControl;
    TabSheet92: TTabSheet;
    StringGridSKILLStrong: TStringGrid;
    TabSheet94: TTabSheet;
    StringGridSKILLStrongRate: TStringGrid;
    GroupBox257: TGroupBox;
    StringGridUpHeartNeedLevel: TStringGrid;
    Label667: TLabel;
    SpinEditIncHeartPointNeedExp: TSpinEdit;
    TabSheet95: TTabSheet;
    GroupBox259: TGroupBox;
    Label668: TLabel;
    Label669: TLabel;
    SpinEditHeartSkilltime: TSpinEdit;
    CheckBoxClearGamePoint: TCheckBox;
    CheckBoxNeedHeart: TCheckBox;
    GroupBox260: TGroupBox;
    Label670: TLabel;
    SpinEditMagicAttackRage_107: TSpinEdit;
    CheckBoxDecMag105SC: TCheckBox;
    PageControl12: TPageControl;
    TabSheet96: TTabSheet;
    TabSheet97: TTabSheet;
    CheckBoxMag113LockCanFly: TCheckBox;
    Label671: TLabel;
    SpinEditFireMaxTime: TSpinEdit;
    CheckBoxFireChgMapExtinguish: TCheckBox;
    CheckBoxMagFirNoneSSMagic: TCheckBox;
    EditMaxMakePosionTime: TSpinEdit;
    Label672: TLabel;
    TabSheet98: TTabSheet;
    GroupBox63: TGroupBox;
    Label673: TLabel;
    Label674: TLabel;
    EditNewKamPoLockNeed1: TSpinEdit;
    EditNewKamPoLockNeed2: TSpinEdit;
    GroupBox261: TGroupBox;
    Label676: TLabel;
    Label678: TLabel;
    EditNewKamPoNeed1: TSpinEdit;
    EditNewKamPoNeed2: TSpinEdit;
    CheckBoxMagicLockTag: TCheckBox;
    EditMagicAttackPassRage: TSpinEdit;
    Label679: TLabel;
    Label677: TLabel;
    Label675: TLabel;
    CheckBoxNeedHeart2: TCheckBox;
    GroupBox262: TGroupBox;
    Label680: TLabel;
    cbMasterTimeRoyalty: TCheckBox;
    seMasterTimeRoyaltyTime: TSpinEdit;
    Label681: TLabel;
    procedure CheckBoxEnablePasswordLockClick(Sender: TObject);
    procedure CheckBoxLockGetBackItemClick(Sender: TObject);
    procedure CheckBoxLockDealItemClick(Sender: TObject);
    procedure CheckBoxLockDropItemClick(Sender: TObject);
    procedure CheckBoxLockWalkClick(Sender: TObject);
    procedure CheckBoxLockRunClick(Sender: TObject);
    procedure CheckBoxLockHitClick(Sender: TObject);
    procedure CheckBoxLockSpellClick(Sender: TObject);
    procedure CheckBoxLockSendMsgClick(Sender: TObject);
    procedure CheckBoxLockInObModeClick(Sender: TObject);
    procedure EditErrorPasswordCountChange(Sender: TObject);
    procedure ButtonPasswordLockSaveClick(Sender: TObject);
    procedure CheckBoxErrorCountKickClick(Sender: TObject);
    procedure CheckBoxLockLoginClick(Sender: TObject);
    procedure CheckBoxLockUseItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxHungerSystemClick(Sender: TObject);
    procedure CheckBoxHungerDecHPClick(Sender: TObject);
    procedure CheckBoxHungerDecPowerClick(Sender: TObject);
    procedure ButtonGeneralSaveClick(Sender: TObject);
    procedure CheckBoxLimitSwordLongClick(Sender: TObject);
    procedure ButtonSkillSaveClick(Sender: TObject);
    procedure EditBoneFammNameChange(Sender: TObject);
    procedure EditBoneFammCountChange(Sender: TObject);
    procedure EditSwordLongPowerRateChange(Sender: TObject);
    procedure EditFireBoomRageChange(Sender: TObject);
    procedure EditSnowWindRangeChange(Sender: TObject);
    procedure EditElecBlizzardRangeChange(Sender: TObject);
    procedure EditDogzCountChange(Sender: TObject);
    procedure EditDogzNameChange(Sender: TObject);
    procedure GridBoneFammSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure EditAmyOunsulPointChange(Sender: TObject);
    procedure EditMagicAttackRageChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponDCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponSCThreePointRateChange(
      Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCTwoPointRateChange(Sender: TObject);
    procedure ScrollBarUpgradeWeaponMCThreePointRateChange(
      Sender: TObject);
    procedure EditUpgradeWeaponMaxPointChange(Sender: TObject);
    procedure EditUpgradeWeaponPriceChange(Sender: TObject);
    procedure EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
    procedure EditClearExpireUpgradeWeaponDaysChange(Sender: TObject);
    procedure ButtonUpgradeWeaponSaveClick(Sender: TObject);
    procedure EditMasterOKLevelChange(Sender: TObject);
    procedure ButtonMasterSaveClick(Sender: TObject);
    procedure EditMasterOKCreditPointChange(Sender: TObject);
    procedure EditMasterOKBonusPointChange(Sender: TObject);
    procedure ScrollBarMakeMineHitRateChange(Sender: TObject);
    procedure ScrollBarMakeMineRateChange(Sender: TObject);
    procedure ScrollBarStoneTypeRateChange(Sender: TObject);
    procedure ScrollBarGoldStoneMaxChange(Sender: TObject);
    procedure ScrollBarSilverStoneMaxChange(Sender: TObject);
    procedure ScrollBarSteelStoneMaxChange(Sender: TObject);
    procedure ScrollBarBlackStoneMaxChange(Sender: TObject);
    procedure ButtonMakeMineSaveClick(Sender: TObject);
    procedure EditStoneMinDuraChange(Sender: TObject);
    procedure EditStoneGeneralDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraRateChange(Sender: TObject);
    procedure EditStoneAddDuraMaxChange(Sender: TObject);
    procedure ButtonWinLotterySaveClick(Sender: TObject);
    procedure EditWinLottery1GoldChange(Sender: TObject);
    procedure EditWinLottery2GoldChange(Sender: TObject);
    procedure EditWinLottery3GoldChange(Sender: TObject);
    procedure EditWinLottery4GoldChange(Sender: TObject);
    procedure EditWinLottery5GoldChange(Sender: TObject);
    procedure EditWinLottery6GoldChange(Sender: TObject);
    procedure ScrollBarWinLottery1MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery2MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery3MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery4MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery5MaxChange(Sender: TObject);
    procedure ScrollBarWinLottery6MaxChange(Sender: TObject);
    procedure ScrollBarWinLotteryRateChange(Sender: TObject);
    procedure ButtonReNewLevelSaveClick(Sender: TObject);
    procedure EditReNewNameColor1Change(Sender: TObject);
    procedure EditReNewNameColor2Change(Sender: TObject);
    procedure EditReNewNameColor3Change(Sender: TObject);
    procedure EditReNewNameColor4Change(Sender: TObject);
    procedure EditReNewNameColor5Change(Sender: TObject);
    procedure EditReNewNameColor6Change(Sender: TObject);
    procedure EditReNewNameColor7Change(Sender: TObject);
    procedure EditReNewNameColor8Change(Sender: TObject);
    procedure EditReNewNameColor9Change(Sender: TObject);
    procedure EditReNewNameColor10Change(Sender: TObject);
    procedure EditReNewNameColorTimeChange(Sender: TObject);
    procedure FunctionConfigControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ButtonMonUpgradeSaveClick(Sender: TObject);
    procedure EditMonUpgradeColor1Change(Sender: TObject);
    procedure EditMonUpgradeColor2Change(Sender: TObject);
    procedure EditMonUpgradeColor3Change(Sender: TObject);
    procedure EditMonUpgradeColor4Change(Sender: TObject);
    procedure EditMonUpgradeColor5Change(Sender: TObject);
    procedure EditMonUpgradeColor6Change(Sender: TObject);
    procedure EditMonUpgradeColor7Change(Sender: TObject);
    procedure EditMonUpgradeColor8Change(Sender: TObject);
    procedure EditMonUpgradeColor9Change(Sender: TObject);
    procedure CheckBoxReNewChangeColorClick(Sender: TObject);
    procedure CheckBoxReNewLevelClearExpClick(Sender: TObject);
    procedure EditPKFlagNameColorChange(Sender: TObject);
    procedure EditPKLevel1NameColorChange(Sender: TObject);
    procedure EditPKLevel2NameColorChange(Sender: TObject);
    procedure EditAllyAndGuildNameColorChange(Sender: TObject);
    procedure EditWarGuildNameColorChange(Sender: TObject);
    procedure EditInFreePKAreaNameColorChange(Sender: TObject);
    procedure EditMonUpgradeKillCount1Change(Sender: TObject);
    procedure EditMonUpgradeKillCount2Change(Sender: TObject);
    procedure EditMonUpgradeKillCount3Change(Sender: TObject);
    procedure EditMonUpgradeKillCount4Change(Sender: TObject);
    procedure EditMonUpgradeKillCount5Change(Sender: TObject);
    procedure EditMonUpgradeKillCount6Change(Sender: TObject);
    procedure EditMonUpgradeKillCount7Change(Sender: TObject);
    procedure EditMonUpLvNeedKillBaseChange(Sender: TObject);
    procedure EditMonUpLvRateChange(Sender: TObject);
    procedure CheckBoxMasterDieMutinyClick(Sender: TObject);
    procedure EditMasterDieMutinyRateChange(Sender: TObject);
    procedure EditMasterDieMutinyPowerChange(Sender: TObject);
    procedure EditMasterDieMutinySpeedChange(Sender: TObject);
    procedure ButtonSpiritMutinySaveClick(Sender: TObject);
    procedure CheckBoxSpiritMutinyClick(Sender: TObject);
    procedure EditSpiritMutinyTimeChange(Sender: TObject);
    procedure EditMagTurnUndeadLevelChange(Sender: TObject);
    procedure EditMagTammingLevelChange(Sender: TObject);
    procedure EditMagTammingTargetLevelChange(Sender: TObject);
    procedure EditMagTammingHPRateChange(Sender: TObject);
    procedure ButtonMonSayMsgSaveClick(Sender: TObject);
    procedure CheckBoxMonSayMsgClick(Sender: TObject);
    procedure ButtonUpgradeWeaponDefaulfClick(Sender: TObject);
    procedure ButtonMakeMineDefaultClick(Sender: TObject);
    procedure ButtonWinLotteryDefaultClick(Sender: TObject);
    procedure EditMabMabeHitRandRateChange(Sender: TObject);
    procedure EditMabMabeHitMinLvLimitChange(Sender: TObject);
    procedure EditMabMabeHitSucessRateChange(Sender: TObject);
    procedure EditMabMabeHitMabeTimeRateChange(Sender: TObject);
    procedure ButtonWeaponMakeLuckDefaultClick(Sender: TObject);
    procedure ButtonWeaponMakeLuckSaveClick(Sender: TObject);
    procedure ScrollBarWeaponMakeUnLuckRateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint1Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint2RateChange(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3Change(Sender: TObject);
    procedure ScrollBarWeaponMakeLuckPoint3RateChange(Sender: TObject);
    procedure EditTammingCountChange(Sender: TObject);
    procedure CheckBoxFireCrossInSafeZoneClick(Sender: TObject);
    procedure CheckBoxBBMonAutoChangeColorClick(Sender: TObject);
    procedure EditBBMonAutoChangeColorTimeChange(Sender: TObject);
    procedure CheckBoxGroupMbAttackPlayObjectClick(Sender: TObject);
    procedure SpinEditSellOffCountChange(Sender: TObject);
    procedure SpinEditSellOffTaxChange(Sender: TObject);
    procedure ButtonSellOffSaveClick(Sender: TObject);
    procedure CheckBoxPullPlayObjectClick(Sender: TObject);
    procedure CheckBoxPlayObjectReduceMPClick(Sender: TObject);
    procedure CheckBoxGroupMbAttackSlaveClick(Sender: TObject);
    procedure CheckBoxItemNameClick(Sender: TObject);
    procedure EditItemNameChange(Sender: TObject);
    procedure ButtonChangeUseItemNameClick(Sender: TObject);
    procedure SpinEditSkill39SecChange(Sender: TObject);
    procedure CheckBoxDedingAllowPKClick(Sender: TObject);
    procedure SpinEditAllowCopyCountChange(Sender: TObject);
    procedure EditCopyHumNameChange(Sender: TObject);
    procedure CheckBoxMasterNameClick(Sender: TObject);
    procedure SpinEditPickUpItemCountChange(Sender: TObject);
    procedure SpinEditEatHPItemRateChange(Sender: TObject);
    procedure SpinEditEatMPItemRateChange(Sender: TObject);
    procedure EditBagItems1Change(Sender: TObject);
    procedure EditBagItems2Change(Sender: TObject);
    procedure EditBagItems3Change(Sender: TObject);
    procedure CheckBoxAllowGuardAttackClick(Sender: TObject);
    procedure SpinEditWarrorAttackTimeChange(Sender: TObject);
    procedure SpinEditWizardAttackTimeChange(Sender: TObject);
    procedure SpinEditTaoistAttackTimeChange(Sender: TObject);
    procedure CheckBoxAllowReCallMobOtherHumClick(Sender: TObject);
    procedure CheckBoxNeedLevelHighTargetClick(Sender: TObject);
    procedure CheckBoxPullCrossInSafeZoneClick(Sender: TObject);
    procedure CheckBoxStartMapEventClick(Sender: TObject);
    procedure CheckBoxFireChgMapExtinguishClick(Sender: TObject);
    procedure SpinEditFireDelayTimeClick(Sender: TObject);
    procedure SpinEditFirePowerClick(Sender: TObject);
    procedure SpinEditDidingPowerRateClick(Sender: TObject);
    procedure FairyNameEdtChange(Sender: TObject);
    procedure SpinFairyEdtChange(Sender: TObject);
    procedure GridFairySetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure SpinFairyDuntRateEdtChange(Sender: TObject);
    procedure SpinFairyAttackRateEdtChange(Sender: TObject);
    procedure EditProtectionRateChange(Sender: TObject);
    procedure SpinEditKill43SecChange(Sender: TObject);
    procedure SpinEditnCopyHumanTickChange(Sender: TObject);
    procedure Spin43KillHitRateEdtChange(Sender: TObject);
    procedure Spin43KillAttackRateEdtChange(Sender: TObject);
    procedure SpinEditAttackRate_43Change(Sender: TObject);
    procedure SpinEditAttackRate_2Change(Sender: TObject);
    procedure EditMagicAttackRage_42Change(Sender: TObject);
    procedure EdtDecUserGameGoldChange(Sender: TObject);
    procedure SpinEditMakeSelfTickChange(Sender: TObject);
    procedure EditCopyHumNameColorChange(Sender: TObject);
    procedure AutoCanHitClick(Sender: TObject);
    procedure EditMeteorFireRainRageChange(Sender: TObject);
    procedure EditMagFireCharmTreatmentChange(Sender: TObject);
    procedure SpinEditAttackRate_74Change(Sender: TObject);
    procedure CheckBoxLockCallHeroClick(Sender: TObject);
    procedure EditMasterCountChange(Sender: TObject);
    procedure EditAbilityUpTickChange(Sender: TObject);
    procedure SpinEditAbilityUpUseTimeChange(Sender: TObject);
    procedure SpinEditMagChangXYChange(Sender: TObject);
    procedure SpinEditKill42SecChange(Sender: TObject);
    procedure SpinEditMakeWineTimeChange(Sender: TObject);
    procedure SpinEditMakeWineRateChange(Sender: TObject);
    procedure ButtonSaveMakeWineClick(Sender: TObject);
    procedure SpinEditMakeWineTime1Change(Sender: TObject);
    procedure SpinEditIncAlcoholTickChange(Sender: TObject);
    procedure SpinEditDesDrinkTickChange(Sender: TObject);
    procedure SpinEditMaxAlcoholValueChange(Sender: TObject);
    procedure SpinEditIncAlcoholValueChange(Sender: TObject);
    procedure GridMedicineExpEnter(Sender: TObject);
    procedure SpinEditDesMedicineValueChange(Sender: TObject);
    procedure SpinEditDesMedicineTickChange(Sender: TObject);
    procedure SpinEditInFountainTimeChange(Sender: TObject);
    procedure SpinEditHPUpTickChange(Sender: TObject);
    procedure SpinEditHPUpUseTimeChange(Sender: TObject);
    procedure GridSkill68Enter(Sender: TObject);
    procedure SpinEditMinDrinkValue67Change(Sender: TObject);
    procedure SpinEditMinDrinkValue68Change(Sender: TObject);
    procedure SpinEditMinGuildFountainChange(Sender: TObject);
    procedure SpinEditDecGuildFountainChange(Sender: TObject);
    procedure SpinEditChallengeTimeChange(Sender: TObject);
    procedure CheckSlaveMoveMasterClick(Sender: TObject);
    procedure CheckBoxShowGuildNameClick(Sender: TObject);
    procedure SpinEditStartHPRockChange(Sender: TObject);
    procedure SpinEditHPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPChange(Sender: TObject);
    procedure SpinEditHPRockDecDuraChange(Sender: TObject);
    procedure SpinEditStartMPRockChange(Sender: TObject);
    procedure SpinEditMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddMPChange(Sender: TObject);
    procedure SpinEditMPRockDecDuraChange(Sender: TObject);
    procedure SpinEditStartHPMPRockChange(Sender: TObject);
    procedure SpinEditHPMPRockSpellChange(Sender: TObject);
    procedure SpinEditRockAddHPMPChange(Sender: TObject);
    procedure SpinEditHPMPRockDecDuraChange(Sender: TObject);
    procedure RadioboSkill31EffectFalseClick(Sender: TObject);
    procedure RadioboSkill31EffectTrueClick(Sender: TObject);
    procedure SpinEditSkill66RateChange(Sender: TObject);
    procedure EditProtectionOKRateChange(Sender: TObject);
    procedure SpinEditSkill69NGChange(Sender: TObject);
    procedure SpinEditSkill69NGExpChange(Sender: TObject);
    procedure SpinEditHeroSkill69NGExpChange(Sender: TObject);
    procedure SpinEditdwIncNHTimeChange(Sender: TObject);
    procedure SpinEditDrinkIncNHExpChange(Sender: TObject);
    procedure SpinEditHitStruckDecNHChange(Sender: TObject);
    procedure SpinEditAbilityUpFixUseTimeChange(Sender: TObject);
    procedure CheckBoxAbilityUpFixModeClick(Sender: TObject);
    procedure SpinEditAttackRate_26Change(Sender: TObject);
    procedure EditKillMonNGExpMultipleChange(Sender: TObject);
    procedure SpinEditNPCNameColorChange(Sender: TObject);
    procedure SpinEditOrdinarySkill66RateChange(Sender: TObject);
    procedure SpinEditFairyDuntRateBelowChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonExpCrystalSaveClick(Sender: TObject);
    procedure GridExpCrystalLevelExpEnter(Sender: TObject);
    procedure EditHeroCrystalExpRateChange(Sender: TObject);
    procedure CheckBoxGroupMbAttackPlayMonClick(Sender: TObject);
    procedure ButtonWealthAnimalMonSaveClick(Sender: TObject);
    procedure SpinEditUseItmeToMonRateChange(Sender: TObject);
    procedure GridCattleGasvalueLevelExpEnter(Sender: TObject);
    procedure SpinEditMonGameGirdChange(Sender: TObject);
    procedure EditGetCattleGasvalueChange(Sender: TObject);
    procedure SpinEditIncMonGameGirdChange(Sender: TObject);
    procedure SpinEditAutoOpenBoxID1Change(Sender: TObject);
    procedure AutoCanHit59Click(Sender: TObject);
    procedure SpinEditCattleGasvalueLevelExpChange(Sender: TObject);
    procedure SpinEditAutoOpenBoxID2Change(Sender: TObject);
    procedure SpinEditAutoOpenBoxID3Change(Sender: TObject);
    procedure SpinEditAutoOpenBoxID4Change(Sender: TObject);
    procedure CheckBoxShowSysHintClick(Sender: TObject);
    procedure PulsePointNGLevel0Change(Sender: TObject);
    procedure PulsePointNGLevel1Change(Sender: TObject);
    procedure PulsePointNGLevel2Change(Sender: TObject);
    procedure PulsePointNGLevel3Change(Sender: TObject);
    procedure PulsePointNGLevel4Change(Sender: TObject);
    procedure PulsePointNGLevel5Change(Sender: TObject);
    procedure PulsePointNGLevel6Change(Sender: TObject);
    procedure PulsePointNGLevel7Change(Sender: TObject);
    procedure PulsePointNGLevel8Change(Sender: TObject);
    procedure PulsePointNGLevel9Change(Sender: TObject);
    procedure PulsePointNGLevel10Change(Sender: TObject);
    procedure PulsePointNGLevel11Change(Sender: TObject);
    procedure PulsePointNGLevel12Change(Sender: TObject);
    procedure PulsePointNGLevel13Change(Sender: TObject);
    procedure PulsePointNGLevel14Change(Sender: TObject);
    procedure PulsePointNGLevel15Change(Sender: TObject);
    procedure PulsePointNGLevel16Change(Sender: TObject);
    procedure PulsePointNGLevel17Change(Sender: TObject);
    procedure PulsePointNGLevel18Change(Sender: TObject);
    procedure PulsePointNGLevel19Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EditUseBatterTickChange(Sender: TObject);
    procedure EditStormsHitRate1Change(Sender: TObject);
    procedure EditStormsHitAppearRate1Change(Sender: TObject);
    procedure EditStormsHitAppearRate2Change(Sender: TObject);
    procedure EditStormsHitAppearRate3Change(Sender: TObject);
    procedure EditStormsHitAppearRate4Change(Sender: TObject);
    procedure EditStormsHitAppearRate5Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditSkillFireRange_87Change(Sender: TObject);
    procedure EditSkillFireRange_86Change(Sender: TObject);
    procedure EditStormsHitRate2Change(Sender: TObject);
    procedure EditStormsHitRate3Change(Sender: TObject);
    procedure EditStormsHitRate4Change(Sender: TObject);
    procedure EditStormsHitRate5Change(Sender: TObject);
    procedure EditSkillFireRange_85Change(Sender: TObject);
    procedure EditSkillFireRange_82Change(Sender: TObject);
    procedure SpinEditMon79CrazyRateChange(Sender: TObject);
    procedure EditBatterSkillPoinson_86Change(Sender: TObject);
    procedure EditBatterSkillPoinson_87Change(Sender: TObject);
    procedure SpinEditSkill69NGExp1Change(Sender: TObject);
    procedure SpinEditHeroSkill69NGExp1Change(Sender: TObject);
    procedure CheckBoxUseNGItemIncExpClick(Sender: TObject);
    procedure SpinEditNGSkillRateChange(Sender: TObject);
    procedure SpinEditBatterDecDamageRateChange(Sender: TObject);
    procedure SpinEditBatterRandDecDamageRateChange(Sender: TObject);
    procedure SpinEditWarrNGLevelIncDCChange(Sender: TObject);
    procedure SpinEditWarrNGLevelIncACChange(Sender: TObject);
    procedure SpinEditWizardNGLevelIncDCChange(Sender: TObject);
    procedure SpinEditWizardNGLevelIncACChange(Sender: TObject);
    procedure SpinEditMon79CrazyTimeChange(Sender: TObject);
    procedure SpinEditKill69SecChange(Sender: TObject);
    procedure SpinEditMakeWineLevelRateChange(Sender: TObject);
    procedure EditSacredCountChange(Sender: TObject);
    procedure EditSacredNameChange(Sender: TObject);
    procedure GridSkill95Enter(Sender: TObject);
    procedure CheckBoxHeroMutinyDieClick(Sender: TObject);
    procedure CheckBoxAbilityAddModeClick(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure SpinEdit6Change(Sender: TObject);
    procedure SpinEdit7Change(Sender: TObject);
    procedure SpinEdit8Change(Sender: TObject);
    procedure SpinEdit9Change(Sender: TObject);
    procedure CheckBoxAssignmentCrystClick(Sender: TObject);
    procedure CheckBoxFairyShareMasterMPClick(Sender: TObject);
    procedure AutoCanHit45Click(Sender: TObject);
    procedure EditUseBloodSoulChange(Sender: TObject);
    procedure EditBloodSoulRateChange(Sender: TObject);
    procedure EditBloodSoulHitRateChange(Sender: TObject);
    procedure EditNotGNDecHPRateChange(Sender: TObject);
    procedure CheckBoxAttackMasterTargetClick(Sender: TObject);
    procedure SpinEditExplosion_97RangeChange(Sender: TObject);
    procedure SpinEditExplosion_98RangeChange(Sender: TObject);
    procedure CheckBoxOpenSelfShopClick(Sender: TObject);
    procedure CheckBoxSafeZoneShopClick(Sender: TObject);
    procedure CheckBoxMapShopClick(Sender: TObject);
    procedure CheckBoxOffLineShopClick(Sender: TObject);
    procedure CheckBoxAttackFFT_96Click(Sender: TObject);
    procedure SpinEditTaosNGLevelIncDCChange(Sender: TObject);
    procedure SpinEditTaosNGLevelIncACChange(Sender: TObject);
    procedure EditArmsTearPriceRateChange(Sender: TObject);
    procedure EditArmsCritRateChange(Sender: TObject);
    procedure SpinEditShopLevelChange(Sender: TObject);
    procedure ButtonSaveKamPoClick(Sender: TObject);
    procedure EditArmsDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsDCAddValueRateChange(Sender: TObject);
    procedure EditArmsDCAddRateChange(Sender: TObject);
    procedure EditArmsMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsMainAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsMCAddValueRateChange(Sender: TObject);
    procedure EditArmsSCAddValueRateChange(Sender: TObject);
    procedure EditArmsMainAddValueRateChange(Sender: TObject);
    procedure EditArmsMCAddRateChange(Sender: TObject);
    procedure EditArmsSCAddRateChange(Sender: TObject);
    procedure EditArmsMainAddRateChange(Sender: TObject);
    procedure EditArmsQSAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsJMAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsNSAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsBJAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsQSAddValueRateChange(Sender: TObject);
    procedure EditArmsJMAddValueRateChange(Sender: TObject);
    procedure EditArmsNSAddValueRateChange(Sender: TObject);
    procedure EditArmsBJAddValueRateChange(Sender: TObject);
    procedure EditArmsQSAddRateChange(Sender: TObject);
    procedure EditArmsJMAddRateChange(Sender: TObject);
    procedure EditArmsNSAddRateChange(Sender: TObject);
    procedure EditArmsBJAddRateChange(Sender: TObject);
    procedure EditArmsHJAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsMBAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsFBAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsZQAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmsHJAddValueRateChange(Sender: TObject);
    procedure EditArmsMBAddValueRateChange(Sender: TObject);
    procedure EditArmsFBAddValueRateChange(Sender: TObject);
    procedure EditArmsZQAddValueRateChange(Sender: TObject);
    procedure EditArmsHJAddRateChange(Sender: TObject);
    procedure EditArmsMBAddRateChange(Sender: TObject);
    procedure EditArmsFBAddRateChange(Sender: TObject);
    procedure EditArmsZQAddRateChange(Sender: TObject);
    procedure EditDressDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressMainAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressQSAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressJMAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressXXAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressBJAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressHJAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressMBAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressNLAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressWFAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressDCAddValueRateChange(Sender: TObject);
    procedure EditDressMCAddValueRateChange(Sender: TObject);
    procedure EditDressSCAddValueRateChange(Sender: TObject);
    procedure EditDressMainAddValueRateChange(Sender: TObject);
    procedure EditDressQSAddValueRateChange(Sender: TObject);
    procedure EditDressJMAddValueRateChange(Sender: TObject);
    procedure EditDressXXAddValueRateChange(Sender: TObject);
    procedure EditDressBJAddValueRateChange(Sender: TObject);
    procedure EditDressHJAddValueRateChange(Sender: TObject);
    procedure EditDressMBAddValueRateChange(Sender: TObject);
    procedure EditDressNLAddValueRateChange(Sender: TObject);
    procedure EditDressWFAddValueRateChange(Sender: TObject);
    procedure EditDressDCAddRateChange(Sender: TObject);
    procedure EditDressMCAddRateChange(Sender: TObject);
    procedure EditDressSCAddRateChange(Sender: TObject);
    procedure EditDressMainAddRateChange(Sender: TObject);
    procedure EditDressQSAddRateChange(Sender: TObject);
    procedure EditDressJMAddRateChange(Sender: TObject);
    procedure EditDressXXAddRateChange(Sender: TObject);
    procedure EditDressBJAddRateChange(Sender: TObject);
    procedure EditDressHJAddRateChange(Sender: TObject);
    procedure EditDressMBAddRateChange(Sender: TObject);
    procedure EditDressNLAddRateChange(Sender: TObject);
    procedure EditDressWFAddRateChange(Sender: TObject);
    procedure EditNecklaceDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceMainAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceQSAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceXXAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceNLAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceMFAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceHJAddValueMaxLimitChange(Sender: TObject);
    procedure EditNecklaceDCAddValueRateChange(Sender: TObject);
    procedure EditNecklaceMCAddValueRateChange(Sender: TObject);
    procedure EditNecklaceSCAddValueRateChange(Sender: TObject);
    procedure EditNecklaceMainAddValueRateChange(Sender: TObject);
    procedure EditNecklaceQSAddValueRateChange(Sender: TObject);
    procedure EditNecklaceXXAddValueRateChange(Sender: TObject);
    procedure EditNecklaceNLAddValueRateChange(Sender: TObject);
    procedure EditNecklaceMFAddValueRateChange(Sender: TObject);
    procedure EditNecklaceHJAddValueRateChange(Sender: TObject);
    procedure EditNecklaceDCAddRateChange(Sender: TObject);
    procedure EditNecklaceMCAddRateChange(Sender: TObject);
    procedure EditNecklaceSCAddRateChange(Sender: TObject);
    procedure EditNecklaceMainAddRateChange(Sender: TObject);
    procedure EditNecklaceQSAddRateChange(Sender: TObject);
    procedure EditNecklaceXXAddRateChange(Sender: TObject);
    procedure EditNecklaceNLAddRateChange(Sender: TObject);
    procedure EditNecklaceMFAddRateChange(Sender: TObject);
    procedure EditNecklaceHJAddRateChange(Sender: TObject);
    procedure EditBraceletDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletMainAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletQSAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletXXAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletNLAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletMFAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletHJAddValueMaxLimitChange(Sender: TObject);
    procedure EditBraceletDCAddValueRateChange(Sender: TObject);
    procedure EditBraceletMCAddValueRateChange(Sender: TObject);
    procedure EditBraceletSCAddValueRateChange(Sender: TObject);
    procedure EditBraceletMainAddValueRateChange(Sender: TObject);
    procedure EditBraceletQSAddValueRateChange(Sender: TObject);
    procedure EditBraceletXXAddValueRateChange(Sender: TObject);
    procedure EditBraceletNLAddValueRateChange(Sender: TObject);
    procedure EditBraceletMFAddValueRateChange(Sender: TObject);
    procedure EditBraceletHJAddValueRateChange(Sender: TObject);
    procedure EditBraceletDCAddRateChange(Sender: TObject);
    procedure EditBraceletMCAddRateChange(Sender: TObject);
    procedure EditBraceletSCAddRateChange(Sender: TObject);
    procedure EditBraceletMainAddRateChange(Sender: TObject);
    procedure EditBraceletQSAddRateChange(Sender: TObject);
    procedure EditBraceletXXAddRateChange(Sender: TObject);
    procedure EditBraceletNLAddRateChange(Sender: TObject);
    procedure EditBraceletMFAddRateChange(Sender: TObject);
    procedure EditBraceletHJAddRateChange(Sender: TObject);
    procedure EditRingDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingMainAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingQSAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingJMAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingXXAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingFBAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingHJAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingMBAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingNLAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingWFAddValueMaxLimitChange(Sender: TObject);
    procedure EditRingDCAddValueRateChange(Sender: TObject);
    procedure EditRingMCAddValueRateChange(Sender: TObject);
    procedure EditRingSCAddValueRateChange(Sender: TObject);
    procedure EditRingMainAddValueRateChange(Sender: TObject);
    procedure EditRingQSAddValueRateChange(Sender: TObject);
    procedure EditRingJMAddValueRateChange(Sender: TObject);
    procedure EditRingXXAddValueRateChange(Sender: TObject);
    procedure EditRingFBAddValueRateChange(Sender: TObject);
    procedure EditRingHJAddValueRateChange(Sender: TObject);
    procedure EditRingMBAddValueRateChange(Sender: TObject);
    procedure EditRingNLAddValueRateChange(Sender: TObject);
    procedure EditRingWFAddValueRateChange(Sender: TObject);
    procedure EditRingDCAddRateChange(Sender: TObject);
    procedure EditRingMCAddRateChange(Sender: TObject);
    procedure EditRingSCAddRateChange(Sender: TObject);
    procedure EditRingMainAddRateChange(Sender: TObject);
    procedure EditRingQSAddRateChange(Sender: TObject);
    procedure EditRingJMAddRateChange(Sender: TObject);
    procedure EditRingXXAddRateChange(Sender: TObject);
    procedure EditRingFBAddRateChange(Sender: TObject);
    procedure EditRingHJAddRateChange(Sender: TObject);
    procedure EditRingMBAddRateChange(Sender: TObject);
    procedure EditRingNLAddRateChange(Sender: TObject);
    procedure EditRingWFAddRateChange(Sender: TObject);
    procedure EditHelmetDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelmetMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelmetSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelmetMainAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelmetQSAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelmetXXAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelmetHJAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelmetDCAddValueRateChange(Sender: TObject);
    procedure EditHelmetMCAddValueRateChange(Sender: TObject);
    procedure EditHelmetSCAddValueRateChange(Sender: TObject);
    procedure EditHelmetMainAddValueRateChange(Sender: TObject);
    procedure EditHelmetQSAddValueRateChange(Sender: TObject);
    procedure EditHelmetXXAddValueRateChange(Sender: TObject);
    procedure EditHelmetHJAddValueRateChange(Sender: TObject);
    procedure EditHelmetDCAddRateChange(Sender: TObject);
    procedure EditHelmetMCAddRateChange(Sender: TObject);
    procedure EditHelmetSCAddRateChange(Sender: TObject);
    procedure EditHelmetMainAddRateChange(Sender: TObject);
    procedure EditHelmetQSAddRateChange(Sender: TObject);
    procedure EditHelmetXXAddRateChange(Sender: TObject);
    procedure EditHelmetHJAddRateChange(Sender: TObject);
    procedure EditShoesDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditShoesMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditShoesSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditShoesMainAddValueMaxLimitChange(Sender: TObject);
    procedure EditShoesQSAddValueMaxLimitChange(Sender: TObject);
    procedure EditShoesJMAddValueMaxLimitChange(Sender: TObject);
    procedure EditShoesHJAddValueMaxLimitChange(Sender: TObject);
    procedure EditShoesDCAddValueRateChange(Sender: TObject);
    procedure EditShoesMCAddValueRateChange(Sender: TObject);
    procedure EditShoesSCAddValueRateChange(Sender: TObject);
    procedure EditShoesMainAddValueRateChange(Sender: TObject);
    procedure EditShoesQSAddValueRateChange(Sender: TObject);
    procedure EditShoesJMAddValueRateChange(Sender: TObject);
    procedure EditShoesHJAddValueRateChange(Sender: TObject);
    procedure EditShoesDCAddRateChange(Sender: TObject);
    procedure EditShoesMCAddRateChange(Sender: TObject);
    procedure EditShoesSCAddRateChange(Sender: TObject);
    procedure EditShoesMainAddRateChange(Sender: TObject);
    procedure EditShoesQSAddRateChange(Sender: TObject);
    procedure EditShoesJMAddRateChange(Sender: TObject);
    procedure EditShoesHJAddRateChange(Sender: TObject);
    procedure EditMedalDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalMainAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalQSAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalJMAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalFBAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalBJAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalHJAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalMBAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalNLAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalNSAddValueMaxLimitChange(Sender: TObject);
    procedure EditMedalDCAddValueRateChange(Sender: TObject);
    procedure EditMedalMCAddValueRateChange(Sender: TObject);
    procedure EditMedalSCAddValueRateChange(Sender: TObject);
    procedure EditMedalMainAddValueRateChange(Sender: TObject);
    procedure EditMedalQSAddValueRateChange(Sender: TObject);
    procedure EditMedalJMAddValueRateChange(Sender: TObject);
    procedure EditMedalFBAddValueRateChange(Sender: TObject);
    procedure EditMedalBJAddValueRateChange(Sender: TObject);
    procedure EditMedalHJAddValueRateChange(Sender: TObject);
    procedure EditMedalMBAddValueRateChange(Sender: TObject);
    procedure EditMedalNLAddValueRateChange(Sender: TObject);
    procedure EditMedalNSAddValueRateChange(Sender: TObject);
    procedure EditMedalDCAddRateChange(Sender: TObject);
    procedure EditMedalMCAddRateChange(Sender: TObject);
    procedure EditMedalSCAddRateChange(Sender: TObject);
    procedure EditMedalMainAddRateChange(Sender: TObject);
    procedure EditMedalQSAddRateChange(Sender: TObject);
    procedure EditMedalJMAddRateChange(Sender: TObject);
    procedure EditMedalFBAddRateChange(Sender: TObject);
    procedure EditMedalBJAddRateChange(Sender: TObject);
    procedure EditMedalHJAddRateChange(Sender: TObject);
    procedure EditMedalMBAddRateChange(Sender: TObject);
    procedure EditMedalNLAddRateChange(Sender: TObject);
    procedure EditMedalNSAddRateChange(Sender: TObject);
    procedure EditMysteryAddValueMaxLimitChange(Sender: TObject);
    procedure EditMysteryAddValueRateChange(Sender: TObject);
    procedure EditMysteryAddRateChange(Sender: TObject);
    procedure EditAdvancedKamPoChange(Sender: TObject);
    procedure EditRebirthRateChange(Sender: TObject);
    procedure EditMagicShieldRateChange(Sender: TObject);
    procedure EditParalysisRateChange(Sender: TObject);
    procedure EditParalysis2RateChange(Sender: TObject);
    procedure EditParalysis1RateChange(Sender: TObject);
    procedure EditProbeNecklaceRateChange(Sender: TObject);
    procedure EditTeleportRateChange(Sender: TObject);
    procedure EditReadRate1Change(Sender: TObject);
    procedure EditMakeScroll1RateChange(Sender: TObject);
    procedure EditMakeScroll2RateChange(Sender: TObject);
    procedure EditMakeScroll3RateChange(Sender: TObject);
    procedure EditMakeScroll4RateChange(Sender: TObject);
    procedure EditReadRate2Change(Sender: TObject);
    procedure EditReadRate3Change(Sender: TObject);
    procedure EditReadRate4Change(Sender: TObject);
    procedure EditSpiritMediaAddValueRateChange(Sender: TObject);
    procedure EditSpiritMediaAddRateChange(Sender: TObject);
    procedure EditJudgePriceChange(Sender: TObject);
    procedure EditMaxHeapStruckDamageChange(Sender: TObject);
    procedure RadioButtonJudgeGameGoldClick(Sender: TObject);
    procedure RadioButtonJudgeUseGoldClick(Sender: TObject);
    procedure ButtonJewelSaveClick(Sender: TObject);
    procedure EditFindJewelRaveChange(Sender: TObject);
    procedure EditDigJewelHitRateChange(Sender: TObject);
    procedure EditGetDigJewelRaveChange(Sender: TObject);
    procedure EditPoisonLength_87Change(Sender: TObject);
    procedure EditEnergyValueTimeChange(Sender: TObject);
    procedure CheckBoxOffLineEnergyClick(Sender: TObject);
    procedure CheckBoxUseCanKamPoClick(Sender: TObject);
    procedure EditSkill101PointChange(Sender: TObject);
    procedure SpinEditKill102SecChange(Sender: TObject);
    procedure EditSill102TargetDecACTimeChange(Sender: TObject);
    procedure CheckBoxDecSuitItemModeClick(Sender: TObject);
    procedure EditSkill95EffectPowerWarrorChange(Sender: TObject);
    procedure EditSkill95EffectRateWarrorChange(Sender: TObject);
    procedure EditSkill95DecInjuryWarrorChange(Sender: TObject);
    procedure EditJingYuanValueChange(Sender: TObject);
    procedure Skill95EffectPowerWizardChange(Sender: TObject);
    procedure Skill95EffectRateWizardChange(Sender: TObject);
    procedure Skill95DecInjuryWizardChange(Sender: TObject);
    procedure Skill95EffectPowerTaoistChange(Sender: TObject);
    procedure Skill95EffectRateTaoistChange(Sender: TObject);
    procedure Skill95DecInjuryTaoistChange(Sender: TObject);
    procedure LianqiGoldChange(Sender: TObject);
    procedure LianqiGameGirdChange(Sender: TObject);
    procedure SpinEditLimitExpNGLevelChange(Sender: TObject);
    procedure SpinEditStartHPMPRock1Change(Sender: TObject);
    procedure SpinEditHPMPRockSpell1Change(Sender: TObject);
    procedure SpinEditRockAddHPMP1Change(Sender: TObject);
    procedure SpinEditHPMPRockDecDura1Change(Sender: TObject);
    procedure SpinEditAutoExpSkill95Change(Sender: TObject);
    procedure SpinEditIncJingYuanValueTimeChange(Sender: TObject);
    procedure EditIncTransferValueChange(Sender: TObject);
    procedure Skill95LevelDecInjuryChange(Sender: TObject);
    procedure EditDecDuraRateChange(Sender: TObject);
    procedure ListBoxAIListClick(Sender: TObject);
    procedure ButtonAIListAddClick(Sender: TObject);
    procedure ButtonAIDelClick(Sender: TObject);
    procedure EditHomeMapChange(Sender: TObject);
    procedure EditHomeXChange(Sender: TObject);
    procedure EditHomeYChange(Sender: TObject);
    procedure ButtonAILogonClick(Sender: TObject);
    procedure EditConfigListFileNameChange(Sender: TObject);
    procedure ButtonSaveAIClick(Sender: TObject);
    procedure CheckBoxAutoRepairItemClick(Sender: TObject);
    procedure CheckBoxRenewHealthClick(Sender: TObject);
    procedure EditRenewPercentChange(Sender: TObject);
    procedure CheckBoxAutoPickUpItemClick(Sender: TObject);
    procedure CheckBoxUseFengHaoAbilClick(Sender: TObject);
    procedure SpinEditKill55UseTimeChange(Sender: TObject);
    procedure SpinFireFairyEdtChange(Sender: TObject);
    procedure SpinEditFireFairyDuntRateBelowChange(Sender: TObject);
    procedure SpinFireFairyDuntRateEdtChange(Sender: TObject);
    procedure SpinFireFairyAttackRateEdtChange(Sender: TObject);
    procedure FireFairyNameEdtChange(Sender: TObject);
    procedure CheckBoxFireFairyShareMasterMPClick(Sender: TObject);
    procedure CheckBoxFireFairyNeglectACMACClick(Sender: TObject);
    procedure RadioArmsTearPriceGameGoldClick(Sender: TObject);
    procedure RadioArmsTearPriceGoldClick(Sender: TObject);
    procedure RadioArmsTearPriceGameGirdClick(Sender: TObject);
    procedure RadioArmsTearPriceGameDiamondClick(Sender: TObject);
    procedure SpinEditKill101UseTimeChange(Sender: TObject);
    procedure SpinAIWarrorAttackTimeChange(Sender: TObject);
    procedure SpinAIWizardAttackTimeChange(Sender: TObject);
    procedure SpinAITaoistAttackTimeChange(Sender: TObject);
    procedure EditAIRunIntervalTimeChange(Sender: TObject);
    procedure EditAIWalkIntervalTimeChange(Sender: TObject);
    procedure CheckBoxLimitSwordLongNGClick(Sender: TObject);
    procedure CheckBoxHPAutoMoveMapClick(Sender: TObject);
    procedure EditDoCallTrollChange(Sender: TObject);
    procedure EditDoCallTrollTimeChange(Sender: TObject);
    procedure EditNGStrongItemChange(Sender: TObject);
    procedure SpinEditSKILL_200NGStrong1Change(Sender: TObject);
    procedure SpinEditSKILL_200NGStrong2Change(Sender: TObject);
    procedure SpinEditSKILL_200NGStrong3Change(Sender: TObject);
    procedure SpinEditSKILL_200NGStrong4Change(Sender: TObject);
    procedure Skill_202NGStrong1Change(Sender: TObject);
    procedure Skill_202NGStrong2Change(Sender: TObject);
    procedure Skill_202NGStrong3Change(Sender: TObject);
    procedure Skill_202NGStrong4Change(Sender: TObject);
    procedure Skill_236NGStrong1Change(Sender: TObject);
    procedure Skill_236NGStrong2Change(Sender: TObject);
    procedure Skill_236NGStrong3Change(Sender: TObject);
    procedure Skill_236NGStrong4Change(Sender: TObject);
    procedure Skill_204NGStrong1Change(Sender: TObject);
    procedure Skill_204NGStrong2Change(Sender: TObject);
    procedure Skill_204NGStrong3Change(Sender: TObject);
    procedure Skill_204NGStrong4Change(Sender: TObject);
    procedure Skill_206NGStrong1Change(Sender: TObject);
    procedure Skill_206NGStrong2Change(Sender: TObject);
    procedure Skill_206NGStrong3Change(Sender: TObject);
    procedure Skill_206NGStrong4Change(Sender: TObject);
    procedure Skill_239NGStrong1Change(Sender: TObject);
    procedure Skill_239NGStrong2Change(Sender: TObject);
    procedure Skill_239NGStrong3Change(Sender: TObject);
    procedure Skill_239NGStrong4Change(Sender: TObject);
    procedure Skill_230NGStrong1Change(Sender: TObject);
    procedure Skill_230NGStrong2Change(Sender: TObject);
    procedure Skill_230NGStrong3Change(Sender: TObject);
    procedure Skill_230NGStrong4Change(Sender: TObject);
    procedure Skill_232NGStrong1Change(Sender: TObject);
    procedure Skill_232NGStrong2Change(Sender: TObject);
    procedure Skill_232NGStrong3Change(Sender: TObject);
    procedure Skill_232NGStrong4Change(Sender: TObject);
    procedure Skill_241NGStrong1Change(Sender: TObject);
    procedure Skill_241NGStrong2Change(Sender: TObject);
    procedure Skill_241NGStrong3Change(Sender: TObject);
    procedure Skill_241NGStrong4Change(Sender: TObject);
    procedure Skill_228NGStrong1Change(Sender: TObject);
    procedure Skill_228NGStrong2Change(Sender: TObject);
    procedure Skill_228NGStrong3Change(Sender: TObject);
    procedure Skill_228NGStrong4Change(Sender: TObject);
    procedure Skill_234NGStrong1Change(Sender: TObject);
    procedure Skill_234NGStrong2Change(Sender: TObject);
    procedure Skill_234NGStrong3Change(Sender: TObject);
    procedure Skill_234NGStrong4Change(Sender: TObject);
    procedure Skill_208NGStrong0Change(Sender: TObject);
    procedure Skill_214NGStrong0Change(Sender: TObject);
    procedure nSkill_218NGStrong0Change(Sender: TObject);
    procedure nSkill_222NGStrong0Change(Sender: TObject);
    procedure nSkill_210NGStrong0Change(Sender: TObject);
    procedure nSkill_212NGStrong0Change(Sender: TObject);
    procedure nSkill_216NGStrong0Change(Sender: TObject);
    procedure nSkill_224NGStrong0Change(Sender: TObject);
    procedure nSkill_226NGStrong0Change(Sender: TObject);
    procedure nSkill_220NGStrong0Change(Sender: TObject);
    procedure Skill_208NGStrong1Change(Sender: TObject);
    procedure Skill_214NGStrong1Change(Sender: TObject);
    procedure nSkill_218NGStrong1Change(Sender: TObject);
    procedure nSkill_222NGStrong1Change(Sender: TObject);
    procedure nSkill_210NGStrong1Change(Sender: TObject);
    procedure nSkill_212NGStrong1Change(Sender: TObject);
    procedure nSkill_216NGStrong1Change(Sender: TObject);
    procedure nSkill_224NGStrong1Change(Sender: TObject);
    procedure nSkill_226NGStrong1Change(Sender: TObject);
    procedure nSkill_220NGStrong1Change(Sender: TObject);
    procedure Skill_208NGStrong2Change(Sender: TObject);
    procedure Skill_214NGStrong2Change(Sender: TObject);
    procedure nSkill_218NGStrong2Change(Sender: TObject);
    procedure nSkill_222NGStrong2Change(Sender: TObject);
    procedure nSkill_210NGStrong2Change(Sender: TObject);
    procedure nSkill_212NGStrong2Change(Sender: TObject);
    procedure nSkill_216NGStrong2Change(Sender: TObject);
    procedure nSkill_224NGStrong2Change(Sender: TObject);
    procedure nSkill_226NGStrong2Change(Sender: TObject);
    procedure nSkill_220NGStrong2Change(Sender: TObject);
    procedure Skill_208NGStrong3Change(Sender: TObject);
    procedure Skill_214NGStrong3Change(Sender: TObject);
    procedure nSkill_218NGStrong3Change(Sender: TObject);
    procedure nSkill_222NGStrong3Change(Sender: TObject);
    procedure nSkill_210NGStrong3Change(Sender: TObject);
    procedure nSkill_212NGStrong3Change(Sender: TObject);
    procedure nSkill_216NGStrong3Change(Sender: TObject);
    procedure nSkill_224NGStrong3Change(Sender: TObject);
    procedure nSkill_226NGStrong3Change(Sender: TObject);
    procedure nSkill_220NGStrong3Change(Sender: TObject);
    procedure nNGSkillMaxLevelChange(Sender: TObject);
    procedure PetsMonDecMaxHappChange(Sender: TObject);
    procedure PetsMonIncMaxHappChange(Sender: TObject);
    procedure SpinEditKill101UseLogTimeChange(Sender: TObject);
    procedure CheckBoxMagTammingHitNewClick(Sender: TObject);
    procedure CheckBoxFairyUseDBHitTimeClick(Sender: TObject);
    procedure SpinEditActivHeartNHChange(Sender: TObject);
    procedure SpinEditPublicHeartLevelChange(Sender: TObject);
    procedure SpinEditDivisionSavvyRateChange(Sender: TObject);
    procedure SpinEditActivMemberHeartRateChange(Sender: TObject);
    procedure SpinEditMemberUseHeartTimeChange(Sender: TObject);
    procedure SpinEditSavvyHeartNeedLevelChange(Sender: TObject);
    procedure SpinEditHeartArrValueRateChange(Sender: TObject);
    procedure SpinEditHeartIncDamageRateChange(Sender: TObject);
    procedure StringGridSKILLStrongEnter(Sender: TObject);
    procedure StringGridSKILLStrongRateEnter(Sender: TObject);
    procedure SpinEditIncHeartPointNeedExpChange(Sender: TObject);
    procedure SpinEditHeartSkilltimeChange(Sender: TObject);
    procedure CheckBoxClearGamePointClick(Sender: TObject);
    procedure CheckBoxNeedHeartClick(Sender: TObject);
    procedure SpinEditMagicAttackRage_107Change(Sender: TObject);
    procedure CheckBoxDecMag105SCClick(Sender: TObject);
    procedure CheckBoxMag113LockCanFlyClick(Sender: TObject);
    procedure SpinEditFireMaxTimeChange(Sender: TObject);
    procedure CheckBoxMagFirNoneSSMagicClick(Sender: TObject);
    procedure EditMaxMakePosionTimeChange(Sender: TObject);
    procedure EditNewKamPoLockNeed1Change(Sender: TObject);
    procedure EditNewKamPoLockNeed2Change(Sender: TObject);
    procedure EditNewKamPoNeed1Change(Sender: TObject);
    procedure EditNewKamPoNeed2Change(Sender: TObject);
    procedure CheckBoxMagicLockTagClick(Sender: TObject);
    procedure EditMagicAttackPassRageChange(Sender: TObject);
    procedure CheckBoxNeedHeart2Click(Sender: TObject);
    procedure cbMasterTimeRoyaltyClick(Sender: TObject);
    procedure seMasterTimeRoyaltyTimeChange(Sender: TObject);

  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefReNewLevelConf;
    procedure RefUpgradeWeapon;
    procedure RefMakeMine;
    procedure RefWinLottery;
    procedure RefMonUpgrade;
    procedure RefGeneral;
    procedure RefSpiritMutiny;
    procedure RefMagicSkill;
    procedure RefMonSayMsg;
    procedure RefWeaponMakeLuck();
    procedure RefCopyHumConf;
    procedure RefPulsePointNGLevelConf();//刷新脉穴打通所需内功等级
    { Private declarations }
  public
    procedure Open;
    { Public declarations }
  end;

var
  frmFunctionConfig: TfrmFunctionConfig;

implementation

uses M2Share, HUtil32, UsrEngn;

{$R *.dfm}

{ TfrmFunctionConfig }

procedure TfrmFunctionConfig.ModValue;
begin
  boModValued := True;
  ButtonPasswordLockSave.Enabled := True;
  ButtonGeneralSave.Enabled := True;
  ButtonSkillSave.Enabled := True;
  ButtonUpgradeWeaponSave.Enabled := True;
  ButtonMasterSave.Enabled := True;
  ButtonMakeMineSave.Enabled := True;
  ButtonWinLotterySave.Enabled := True;
  ButtonReNewLevelSave.Enabled := True;
  ButtonMonUpgradeSave.Enabled := True;
  ButtonSpiritMutinySave.Enabled := True;
  ButtonMonSayMsgSave.Enabled := True;
  ButtonSellOffSave.Enabled := True;
  ButtonChangeUseItemName.Enabled := True;
  ButtonSaveMakeWine.Enabled := True;
  ButtonWeaponMakeLuckSave.Enabled := True;
  ButtonExpCrystalSave.Enabled := True;
  ButtonWealthAnimalMonSave.Enabled := True;
  ButtonSaveKamPo.Enabled := True;
  ButtonJewelSave.Enabled := True;
  ButtonSaveAI.Enabled := True;
end;

procedure TfrmFunctionConfig.nNGSkillMaxLevelChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNGSkillMaxLevel := nNGSkillMaxLevel.Value;;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_210NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_210NGStrong[0] := nSkill_210NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_210NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_210NGStrong[1] := nSkill_210NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_210NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_210NGStrong[2] := nSkill_210NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_210NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_210NGStrong[3] := nSkill_210NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_212NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_212NGStrong[0] := nSkill_212NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_212NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_212NGStrong[1] := nSkill_212NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_212NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_212NGStrong[2] := nSkill_212NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_212NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_212NGStrong[3] := nSkill_212NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_216NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_216NGStrong[0] := nSkill_216NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_216NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_216NGStrong[1] := nSkill_216NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_216NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_216NGStrong[2] := nSkill_216NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_216NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_216NGStrong[3] := nSkill_216NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_218NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_218NGStrong[0] := nSkill_218NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_218NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_218NGStrong[1] := nSkill_218NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_218NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_218NGStrong[2] := nSkill_218NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_218NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_218NGStrong[3] := nSkill_218NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_220NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_220NGStrong[0] := nSkill_220NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_220NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_220NGStrong[1] := nSkill_220NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_220NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_220NGStrong[2] := nSkill_220NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_220NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_220NGStrong[3] := nSkill_220NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_222NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_222NGStrong[0] := nSkill_222NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_222NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_222NGStrong[1] := nSkill_222NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_222NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_222NGStrong[2] := nSkill_222NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_222NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_222NGStrong[3] := nSkill_222NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_224NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_224NGStrong[0] := nSkill_224NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_224NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_224NGStrong[1] := nSkill_224NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_224NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_224NGStrong[2] := nSkill_224NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_224NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_224NGStrong[3] := nSkill_224NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_226NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_226NGStrong[0] := nSkill_226NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_226NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_226NGStrong[1] := nSkill_226NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_226NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_226NGStrong[2] := nSkill_226NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.nSkill_226NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_226NGStrong[3] := nSkill_226NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.uModValue;
begin
  boModValued := False;
  ButtonPasswordLockSave.Enabled := False;
  ButtonGeneralSave.Enabled := False;
  ButtonSkillSave.Enabled := False;
  ButtonUpgradeWeaponSave.Enabled := False;
  ButtonMasterSave.Enabled := False;
  ButtonMakeMineSave.Enabled := False;
  ButtonWinLotterySave.Enabled := False;
  ButtonReNewLevelSave.Enabled := False;
  ButtonMonUpgradeSave.Enabled := False;
  ButtonSpiritMutinySave.Enabled := False;
  ButtonMonSayMsgSave.Enabled := False;
  ButtonSellOffSave.Enabled := False;
  ButtonChangeUseItemName.Enabled := False;
  ButtonSaveMakeWine.Enabled := False;
  ButtonWeaponMakeLuckSave.Enabled := False;
  ButtonExpCrystalSave.Enabled := False;
  ButtonWealthAnimalMonSave.Enabled := False;
  ButtonSaveKamPo.Enabled := False;
  ButtonJewelSave.Enabled := False;
  ButtonSaveAI.Enabled := False;
end;
procedure TfrmFunctionConfig.FunctionConfigControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if boModValued then begin
    if Application.MessageBox('参数设置已经被修改，是否确认不保存修改的设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
      uModValue
    end else AllowChange := False;
  end;
end;
procedure TfrmFunctionConfig.Open;
var
  I: Integer;
  P : TWinControl;
begin
  try
    boOpened := False;
    {p := SpinEditIncJingYuanValueTime.Parent;
    while p <> nil do begin
      Application.MessageBox('',PChar(p.Name),0);
      p := p.Parent;
    end;  }

    uModValue();
    //TabSheet85.TabVisible := False;//隐藏召唤火灵页面
    RefGeneral();
    CheckBoxHungerSystem.Checked := g_Config.boHungerSystem;
    CheckBoxHungerDecHP.Checked := g_Config.boHungerDecHP;
    CheckBoxHungerDecPower.Checked := g_Config.boHungerDecPower;
    CheckBoxHungerSystemClick(CheckBoxHungerSystem);
  {$IF HEROVERSION <> 1}
    Label227.Enabled:= False;
    Label227.Caption:='预留参数1';
    SpinEditHeroSkill69NGExp.Enabled:= False;
    Label279.Enabled:= False;
    Label279.Caption:='预留参数2';
    SpinEditHeroSkill69NGExp1.Enabled:= False;
  {$IFEND}
    CheckBoxClearGamePoint.Checked := g_Config.boClearGamePoint;
  {$IF M2Version = 1}
    CheckBoxAssignmentCryst.Checked := g_Config.boAssignmentCryst;
    CheckBoxAssignmentCrystClick(CheckBoxAssignmentCryst);
    SpinEdit4.Value:= g_Config.nDesAlcoholValue;//长时间使用酒，减酒量
    SpinEdit3.Value:= g_Config.nDesAlcoholTick;//减酒量时间间隔
    SpinEdit5.Value:= g_Config.nDesMaxAlcoholValue;//超过指定酒量时才减酒量
    SpinEdit6.Value:= g_Config.nCRYSTALLEVEL1;
    SpinEdit7.Value:= g_Config.nCRYSTALLEVEL2;
    SpinEdit8.Value:= g_Config.nCRYSTALLEVEL3;
    SpinEdit9.Value:= g_Config.nCRYSTALLEVEL4;
    GroupBox143.Visible:= True;

    TabSheet65.TabVisible:= True;
    CheckBoxUseFengHaoAbil.Checked := g_Config.boUseFengHaoAbil;
    CheckBoxUseFengHaoAbil.Visible:= True;
  {$ELSEIF M2Version = 0}
    GroupBox137.Visible:= False;
    Label156.Visible:= False;
    Label296.Visible:= False;
    SpinEdit5.Visible:= False;
    SpinEdit4.Visible:= False;
    SpinEdit3.Visible:= False;
    GroupBox91.Height:= 112;
    GroupBox93.Top:= 115;
    GroupBox143.Visible:= True;
    TabSheet65.TabVisible:= False;
    CheckBoxUseFengHaoAbil.Checked := g_Config.boUseFengHaoAbil;
    CheckBoxUseFengHaoAbil.Visible:= True;
  {$ELSEIF M2Version = 2}
    CheckBoxUseFengHaoAbil.Visible:= False;
    GroupBox101.Visible:= False;
    GroupBox102.Visible:= False;
    GroupBox103.Visible:= False;
    GroupBox224.Visible:= False;
    TabSheet53.TabVisible := False;//隐藏天地结晶
    TabSheet55.TabVisible := False;//隐藏连击设置页
    TabSheet49.TabVisible := False;//隐藏内功设置页
    TabSheet66.TabVisible := False;//隐藏血魄一击设置页
    TabSheet67.TabVisible := False;//隐藏鉴宝页
    TabSheet32.TabVisible := False;//隐藏挖宝控制页
    CheckBoxLockCallHero.Visible:= False;
    GroupBox137.Visible:= False;
    Label156.Visible:= False;
    Label296.Visible:= False;
    SpinEdit5.Visible:= False;
    SpinEdit4.Visible:= False;
    SpinEdit3.Visible:= False;
    GroupBox91.Height:= 112;
    GroupBox93.Top:= 115;
    TabSheet65.TabVisible:= False;
    CheckBoxLimitSwordLongNG.Visible:= False;
  {$IFEND}
    CheckBoxFairyShareMasterMP.Checked := g_Config.boFairyShareMasterMP;
    CheckBoxFairyUseDBHitTime.Checked := g_Config.boFairyUseDBHitTime;

    CheckBoxEnablePasswordLock.Checked := g_Config.boPasswordLockSystem;
    CheckBoxLockGetBackItem.Checked := g_Config.boLockGetBackItemAction;
    CheckBoxLockDealItem.Checked := g_Config.boLockDealAction;
    CheckBoxLockDropItem.Checked := g_Config.boLockDropAction;
    CheckBoxLockWalk.Checked := g_Config.boLockWalkAction;
    CheckBoxLockRun.Checked := g_Config.boLockRunAction;
    CheckBoxLockHit.Checked := g_Config.boLockHitAction;
    CheckBoxLockSpell.Checked := g_Config.boLockSpellAction;
    CheckBoxLockCallHero.Checked := g_Config.boLockCallHeroAction;//是否锁定召唤英雄操作  20080529
    CheckBoxLockSendMsg.Checked := g_Config.boLockSendMsgAction;
    CheckBoxLockInObMode.Checked := g_Config.boLockInObModeAction;

    CheckBoxLockLogin.Checked := g_Config.boLockHumanLogin;
    CheckBoxLockUseItem.Checked := g_Config.boLockUserItemAction;

    CheckBoxEnablePasswordLockClick(CheckBoxEnablePasswordLock);
    CheckBoxLockLoginClick(CheckBoxLockLogin);

    EditErrorPasswordCount.Value := g_Config.nPasswordErrorCountLock;

    EditBoneFammName.Text := g_Config.sBoneFamm;
    EditBoneFammCount.Value := g_Config.nBoneFammCount;

    EdtDecUserGameGold.Value := g_Config.nDecUserGameGold;//每次扣多少元宝(元宝寄售) 20080319
    CheckBoxOpenSelfShop.Checked := g_Config.boOpenSelfShop;
    CheckBoxSafeZoneShop.Checked := g_Config.boSafeZoneShop;
    CheckBoxMapShop.Checked := g_Config.boMapShop;
    CheckBoxOffLineShop.Checked := g_Config.boSafeOffShop;//禁止挂机摆摊
    SpinEditShopLevel.Value:= g_Config.nCanShopLevel;//可摆摊所需的等级
    SpinEditMakeWineTime.Value:= g_Config.nMakeWineTime;//酿普通酒等待时间 20080621
    SpinEditMakeWineTime1.Value:= g_Config.nMakeWineTime1;//酿药酒等待时间 20080621
    SpinEditMakeWineRate.Value:= g_Config.nMakeWineRate;//酿酒获得酒曲机率 20080621
    SpinEditMakeWineLevelRate.Value:= g_Config.nMakeWineLevelRate;//酿酒获得酒等级机率 20091117
    SpinEditIncAlcoholTick.Value:= g_Config.nIncAlcoholTick;//增加酒量进度的间隔时间 20080623
    SpinEditDesDrinkTick.Value:= g_Config.nDesDrinkTick;//减少醉酒度的间隔时间 20080623
    SpinEditMaxAlcoholValue.Value:= g_Config.nMaxAlcoholValue;//酒量上限初始值 20080623
    SpinEditIncAlcoholValue.Value:= g_Config.nIncAlcoholValue;//升级后增加酒量上限值 20080623
    SpinEditDesMedicineValue.Value:= g_Config.nDesMedicineValue;//长时间不使用酒,减药力值 20080623
    SpinEditDesMedicineTick.Value:= g_Config.nDesMedicineTick;//减药力值时间间隔 20080624
    SpinEditInFountainTime.Value:= g_Config.nInFountainTime;//站在泉眼上的累积时间(秒) 20080624
    SpinEditMinGuildFountain.Value:= g_Config.nMinGuildFountain;//行会酒泉蓄量少于时,不能领取 20080627
    SpinEditDecGuildFountain.Value:= g_Config.nDecGuildFountain;//行会成员领取酒泉,蓄量减少 20080627
    for I := 1 to GridMedicineExp.RowCount - 1 do begin//药力值
      GridMedicineExp.Cells[1, I] := IntToStr(g_Config.dwMedicineNeedExps[I]);
    end;
    for I := 1 to GridExpCrystalLevelExp.RowCount - 1 do begin//天地结晶 20090131
      GridExpCrystalLevelExp.Cells[1, I] := IntToStr(g_Config.dwExpCrystalNeedExps[I]);
      GridExpCrystalLevelExp.Cells[2, I] := IntToStr(g_Config.dwNGExpCrystalNeedExps[I]);
    end;
    SpinEditCattleGasvalueLevelExp.Value := g_Config.dwCattleGasvalueNeedExps;//牛气管升级经验 20090521
    EditHeroCrystalExpRate.Value := g_Config.nHeroCrystalExpRate;//天地结晶英雄分配比例 20090202
    SpinEditUseItmeToMonRate.Value := g_Config.nUseItmeToMonRate;//攻击富贵兽触发脚本段的机率 20090518
    SpinEditMonGameGird.Value := g_Config.nMonGameGird;//富贵兽初始灵符数 20090518
    CheckBoxShowSysHint.Checked:= g_Config.boShowMonSysHint;//富贵兽累积灵符是否提示 20090603
    SpinEditIncMonGameGird.Value := g_Config.nIncMonGameGird;//攻击狂暴状态富贵兽累计灵符数 20090519
    SpinEditMon79CrazyRate.Value := g_Config.nMon79CrazyRate;//富贵兽狂暴机率
    SpinEditMon79CrazyTime.Value := g_Config.nMon79CrazyTime;//富贵兽狂暴时长
    EditGetCattleGasvalue.Value := g_Config.nGetCattleGasvalue;//攻击富贵兽所取得牛气值 20090519
    SpinEditAutoOpenBoxID1.Value := g_Config.nAutoOpenBoxID1;//牛气管升1级后自动打开箱子的编号 20090520
    SpinEditAutoOpenBoxID2.Value := g_Config.nAutoOpenBoxID2;//牛气管升级2级后自动打开箱子的编号 20090524
    SpinEditAutoOpenBoxID3.Value := g_Config.nAutoOpenBoxID3;//牛气管升级3级后自动打开箱子的编号 20090524
    SpinEditAutoOpenBoxID4.Value := g_Config.nAutoOpenBoxID4;//牛气管升级4级后自动打开箱子的编号 20090524
    //SpinEditSellOffCount.Value := g_Config.nUserSellOffCount; //20080504 去掉拍卖功能
    //SpinEditSellOffTax.Value := g_Config.nUserSellOffTax;  //20080504 去掉拍卖功能
  {$IF M2Version <> 2}
    for I := 0 to StringGridSKILLStrong.RowCount - 1 do begin//强化技能
      StringGridSKILLStrong.Cells[I+1, 1] := IntToStr(g_Config.nSKILL_7Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 2] := IntToStr(g_Config.nSKILL_90Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 3] := IntToStr(g_Config.nSKILL_89Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 4] := IntToStr(g_Config.nSKILL_26Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 5] := IntToStr(g_Config.nSKILL_74Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 6] := IntToStr(g_Config.nSKILL_91Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 7] := IntToStr(g_Config.nSKILL_10Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 8] := IntToStr(g_Config.nSKILL_22Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 9] := IntToStr(g_Config.nSKILL_45Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 10] := IntToStr(g_Config.nSKILL_92Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 11] := IntToStr(g_Config.nSKILL_93Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 12] := IntToStr(g_Config.nSKILL_13Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 13] := IntToStr(g_Config.nSKILL_17Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 14] := IntToStr(g_Config.nSKILL_71Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 15] := IntToStr(g_Config.nSKILL_94Strong[I]);
      StringGridSKILLStrong.Cells[I+1, 16] := IntToStr(g_Config.nSKILL_FIREBOOMStrong[I]);
      StringGridSKILLStrong.Cells[I+1, 17] := IntToStr(g_Config.nSKILL_SNOWWINDStrong[I]);
      StringGridSKILLStrong.Cells[I+1, 18] := IntToStr(g_Config.nSKILL_HANGMAJINBUBStrong[I]);
      StringGridSKILLStrong.Cells[I+1, 19] := IntToStr(g_Config.nSKILL_DEJIWONHOStrong[I]);
      StringGridSKILLStrong.Cells[I+1, 20] := IntToStr(g_Config.nSKILL_107NeedHeart[I]);
      StringGridSKILLStrong.Cells[I+1, 21] := IntToStr(g_Config.nSKILL_108NeedHeart[I]);
      StringGridSKILLStrong.Cells[I+1, 22] := IntToStr(g_Config.nSKILL_109NeedHeart[I]);
    end;
    for I := 0 to StringGridSKILLStrongRate.RowCount - 1 do begin
      StringGridSKILLStrongRate.Cells[1,I+1] := IntToStr(g_Config.nSKILLStrongRate[I]);
    end;
    for I := 0 to StringGridUpHeartNeedLevel.RowCount - 1 do begin
      StringGridUpHeartNeedLevel.Cells[1,I+1] := IntToStr(g_Config.nUpHeartNeedLevel[I]);
    end;
    EditArmsDCAddValueMaxLimit.Value := g_Config.nArmsDCAddValueMaxLimit;
    EditArmsDCAddValueRate.Value := g_Config.nArmsDCAddValueRate;
    EditArmsDCAddRate.Value := g_Config.nArmsDCAddRate;
    EditArmsMCAddValueMaxLimit.Value := g_Config.nArmsMCAddValueMaxLimit;
    EditArmsMCAddValueRate.Value := g_Config.nArmsMCAddValueRate;
    EditArmsMCAddRate.Value := g_Config.nArmsMCAddRate;
    EditArmsSCAddValueMaxLimit.Value := g_Config.nArmsSCAddValueMaxLimit;
    EditArmsSCAddValueRate.Value := g_Config.nArmsSCAddValueRate;
    EditArmsSCAddRate.Value := g_Config.nArmsSCAddRate;
    EditArmsMainAddValueMaxLimit.Value := g_Config.nArmsMainAddValueMaxLimit;
    EditArmsMainAddValueRate.Value := g_Config.nArmsMainAddValueRate;
    EditArmsMainAddRate.Value := g_Config.nArmsMainAddRate;
    EditArmsQSAddValueMaxLimit.Value := g_Config.nArmsQSAddValueMaxLimit;
    EditArmsQSAddValueRate.Value := g_Config.nArmsQSAddValueRate;
    EditArmsQSAddRate.Value := g_Config.nArmsQSAddRate;
    EditArmsJMAddValueMaxLimit.Value := g_Config.nArmsJMAddValueMaxLimit;
    EditArmsJMAddValueRate.Value := g_Config.nArmsJMAddValueRate;
    EditArmsJMAddRate.Value := g_Config.nArmsJMAddRate;
    EditArmsNSAddValueMaxLimit.Value := g_Config.nArmsNSAddValueMaxLimit;
    EditArmsNSAddValueRate.Value := g_Config.nArmsNSAddValueRate;
    EditArmsNSAddRate.Value := g_Config.nArmsNSAddRate;
    EditArmsBJAddValueMaxLimit.Value := g_Config.nArmsBJAddValueMaxLimit;
    EditArmsBJAddValueRate.Value := g_Config.nArmsBJAddValueRate;
    EditArmsBJAddRate.Value := g_Config.nArmsBJAddRate;
    EditArmsHJAddValueMaxLimit.Value := g_Config.nArmsHJAddValueMaxLimit;
    EditArmsHJAddValueRate.Value := g_Config.nArmsHJAddValueRate;
    EditArmsHJAddRate.Value := g_Config.nArmsHJAddRate;
    EditArmsMBAddValueMaxLimit.Value := g_Config.nArmsMBAddValueMaxLimit;
    EditArmsMBAddValueRate.Value := g_Config.nArmsMBAddValueRate;
    EditArmsMBAddRate.Value := g_Config.nArmsMBAddRate;
    EditArmsFBAddValueMaxLimit.Value := g_Config.nArmsFBAddValueMaxLimit;
    EditArmsFBAddValueRate.Value := g_Config.nArmsFBAddValueRate;
    EditArmsFBAddRate.Value := g_Config.nArmsFBAddRate;
    EditArmsZQAddValueMaxLimit.Value := g_Config.nArmsZQAddValueMaxLimit;
    EditArmsZQAddValueRate.Value := g_Config.nArmsZQAddValueRate;
    EditArmsZQAddRate.Value := g_Config.nArmsZQAddRate;
    EditDressDCAddValueMaxLimit.Value := g_Config.nDreDCAddValueMaxLimit;
    EditDressDCAddValueRate.Value := g_Config.nDreDCAddValueRate;
    EditDressDCAddRate.Value := g_Config.nDreDCAddRate;
    EditDressMCAddValueMaxLimit.Value := g_Config.nDreMCAddValueMaxLimit;
    EditDressMCAddValueRate.Value := g_Config.nDreMCAddValueRate;
    EditDressMCAddRate.Value := g_Config.nDreMCAddRate;
    EditDressSCAddValueMaxLimit.Value := g_Config.nDreSCAddValueMaxLimit;
    EditDressSCAddValueRate.Value := g_Config.nDreSCAddValueRate;
    EditDressSCAddRate.Value := g_Config.nDreSCAddRate;
    EditDressMainAddValueMaxLimit.Value := g_Config.nDreMainAddValueMaxLimit;
    EditDressMainAddValueRate.Value := g_Config.nDreMainAddValueRate;
    EditDressMainAddRate.Value := g_Config.nDreMainAddRate;
    EditDressQSAddValueMaxLimit.Value := g_Config.nDreQSAddValueMaxLimit;
    EditDressQSAddValueRate.Value := g_Config.nDreQSAddValueRate;
    EditDressQSAddRate.Value := g_Config.nDreQSAddRate;
    EditDressJMAddValueMaxLimit.Value := g_Config.nDreJMAddValueMaxLimit;
    EditDressJMAddValueRate.Value := g_Config.nDreJMAddValueRate;
    EditDressJMAddRate.Value := g_Config.nDreJMAddRate;
    EditDressXXAddValueMaxLimit.Value := g_Config.nDreXXAddValueMaxLimit;
    EditDressXXAddValueRate.Value := g_Config.nDreXXAddValueRate;
    EditDressXXAddRate.Value := g_Config.nDreXXAddRate;
    EditDressBJAddValueMaxLimit.Value := g_Config.nDreBJAddValueMaxLimit;
    EditDressBJAddValueRate.Value := g_Config.nDreBJAddValueRate;
    EditDressBJAddRate.Value := g_Config.nDreBJAddRate;
    EditDressHJAddValueMaxLimit.Value := g_Config.nDreHJAddValueMaxLimit;
    EditDressHJAddValueRate.Value := g_Config.nDreHJAddValueRate;
    EditDressHJAddRate.Value := g_Config.nDreHJAddRate;
    EditDressMBAddValueMaxLimit.Value := g_Config.nDreMBAddValueMaxLimit;
    EditDressMBAddValueRate.Value := g_Config.nDreMBAddValueRate;
    EditDressMBAddRate.Value := g_Config.nDreMBAddRate;
    EditDressNLAddValueMaxLimit.Value := g_Config.nDreNLAddValueMaxLimit;
    EditDressNLAddValueRate.Value := g_Config.nDreNLAddValueRate;
    EditDressNLAddRate.Value := g_Config.nDreNLAddRate;
    EditDressWFAddValueMaxLimit.Value := g_Config.nDreWFAddValueMaxLimit;
    EditDressWFAddValueRate.Value := g_Config.nDreWFAddValueRate;
    EditDressWFAddRate.Value := g_Config.nDreWFAddRate;
    EditNecklaceDCAddValueMaxLimit.Value := g_Config.nNecklaceDCAddValueMaxLimit;
    EditNecklaceDCAddValueRate.Value := g_Config.nNecklaceDCAddValueRate;
    EditNecklaceDCAddRate.Value := g_Config.nNecklaceDCAddRate;
    EditNecklaceMCAddValueMaxLimit.Value := g_Config.nNecklaceMCAddValueMaxLimit;
    EditNecklaceMCAddValueRate.Value := g_Config.nNecklaceMCAddValueRate;
    EditNecklaceMCAddRate.Value := g_Config.nNecklaceMCAddRate;
    EditNecklaceSCAddValueMaxLimit.Value := g_Config.nNecklaceSCAddValueMaxLimit;
    EditNecklaceSCAddValueRate.Value := g_Config.nNecklaceSCAddValueRate;
    EditNecklaceSCAddRate.Value := g_Config.nNecklaceSCAddRate;
    EditNecklaceMainAddValueMaxLimit.Value := g_Config.nNecklaceMainAddValueMaxLimit;
    EditNecklaceMainAddValueRate.Value := g_Config.nNecklaceMainAddValueRate;
    EditNecklaceMainAddRate.Value := g_Config.nNecklaceMainAddRate;
    EditNecklaceQSAddValueMaxLimit.Value := g_Config.nNecklaceQSAddValueMaxLimit;
    EditNecklaceQSAddValueRate.Value := g_Config.nNecklaceQSAddValueRate;
    EditNecklaceQSAddRate.Value := g_Config.nNecklaceQSAddRate;
    EditNecklaceXXAddValueMaxLimit.Value := g_Config.nNecklaceXXAddValueMaxLimit;
    EditNecklaceXXAddValueRate.Value := g_Config.nNecklaceXXAddValueRate;
    EditNecklaceXXAddRate.Value := g_Config.nNecklaceXXAddRate;
    EditNecklaceNLAddValueMaxLimit.Value := g_Config.nNecklaceNLAddValueMaxLimit;
    EditNecklaceNLAddValueRate.Value := g_Config.nNecklaceNLAddValueRate;
    EditNecklaceNLAddRate.Value := g_Config.nNecklaceNLAddRate;
    EditNecklaceMFAddValueMaxLimit.Value := g_Config.nNecklaceMFAddValueMaxLimit;
    EditNecklaceMFAddValueRate.Value := g_Config.nNecklaceMFAddValueRate;
    EditNecklaceMFAddRate.Value := g_Config.nNecklaceMFAddRate;
    EditNecklaceHJAddValueMaxLimit.Value := g_Config.nNecklaceHJAddValueMaxLimit;
    EditNecklaceHJAddValueRate.Value := g_Config.nNecklaceHJAddValueRate;
    EditNecklaceHJAddRate.Value := g_Config.nNecklaceHJAddRate;
    EditBraceletDCAddValueMaxLimit.Value := g_Config.nBraceletDCAddValueMaxLimit;
    EditBraceletDCAddValueRate.Value := g_Config.nBraceletDCAddValueRate;
    EditBraceletDCAddRate.Value := g_Config.nBraceletDCAddRate;
    EditBraceletMCAddValueMaxLimit.Value := g_Config.nBraceletMCAddValueMaxLimit;
    EditBraceletMCAddValueRate.Value := g_Config.nBraceletMCAddValueRate;
    EditBraceletMCAddRate.Value := g_Config.nBraceletMCAddRate;
    EditBraceletSCAddValueMaxLimit.Value := g_Config.nBraceletSCAddValueMaxLimit;
    EditBraceletSCAddValueRate.Value := g_Config.nBraceletSCAddValueRate;
    EditBraceletSCAddRate.Value := g_Config.nBraceletSCAddRate;
    EditBraceletMainAddValueMaxLimit.Value := g_Config.nBraceletMainAddValueMaxLimit;
    EditBraceletMainAddValueRate.Value := g_Config.nBraceletMainAddValueRate;
    EditBraceletMainAddRate.Value := g_Config.nBraceletMainAddRate;
    EditBraceletQSAddValueMaxLimit.Value := g_Config.nBraceletQSAddValueMaxLimit;
    EditBraceletQSAddValueRate.Value := g_Config.nBraceletQSAddValueRate;
    EditBraceletQSAddRate.Value := g_Config.nBraceletQSAddRate;
    EditBraceletXXAddValueMaxLimit.Value := g_Config.nBraceletXXAddValueMaxLimit;
    EditBraceletXXAddValueRate.Value := g_Config.nBraceletXXAddValueRate;
    EditBraceletXXAddRate.Value := g_Config.nBraceletXXAddRate;
    EditBraceletNLAddValueMaxLimit.Value := g_Config.nBraceletNLAddValueMaxLimit;
    EditBraceletNLAddValueRate.Value := g_Config.nBraceletNLAddValueRate;
    EditBraceletNLAddRate.Value := g_Config.nBraceletNLAddRate;
    EditBraceletMFAddValueMaxLimit.Value := g_Config.nBraceletMFAddValueMaxLimit;
    EditBraceletMFAddValueRate.Value := g_Config.nBraceletMFAddValueRate;
    EditBraceletMFAddRate.Value := g_Config.nBraceletMFAddRate;
    EditBraceletHJAddValueMaxLimit.Value := g_Config.nBraceletHJAddValueMaxLimit;
    EditBraceletHJAddValueRate.Value := g_Config.nBraceletHJAddValueRate;
    EditBraceletHJAddRate.Value := g_Config.nBraceletHJAddRate;
    EditRingDCAddValueMaxLimit.Value := g_Config.nRingDCAddValueMaxLimit;
    EditRingDCAddValueRate.Value := g_Config.nRingDCAddValueRate;
    EditRingDCAddRate.Value := g_Config.nRingDCAddRate;
    EditRingMCAddValueMaxLimit.Value := g_Config.nRingMCAddValueMaxLimit;
    EditRingMCAddValueRate.Value := g_Config.nRingMCAddValueRate;
    EditRingMCAddRate.Value := g_Config.nRingMCAddRate;
    EditRingSCAddValueMaxLimit.Value := g_Config.nRingSCAddValueMaxLimit;
    EditRingSCAddValueRate.Value := g_Config.nRingSCAddValueRate;
    EditRingSCAddRate.Value := g_Config.nRingSCAddRate;
    EditRingMainAddValueMaxLimit.Value := g_Config.nRingMainAddValueMaxLimit;
    EditRingMainAddValueRate.Value := g_Config.nRingMainAddValueRate;
    EditRingMainAddRate.Value := g_Config.nRingMainAddRate;
    EditRingQSAddValueMaxLimit.Value := g_Config.nRingQSAddValueMaxLimit;
    EditRingQSAddValueRate.Value := g_Config.nRingQSAddValueRate;
    EditRingQSAddRate.Value := g_Config.nRingQSAddRate;
    EditRingJMAddValueMaxLimit.Value := g_Config.nRingJMAddValueMaxLimit;
    EditRingJMAddValueRate.Value := g_Config.nRingJMAddValueRate;
    EditRingJMAddRate.Value := g_Config.nRingJMAddRate;
    EditRingXXAddValueMaxLimit.Value := g_Config.nRingXXAddValueMaxLimit;
    EditRingXXAddValueRate.Value := g_Config.nRingXXAddValueRate;
    EditRingXXAddRate.Value := g_Config.nRingXXAddRate;
    EditRingFBAddValueMaxLimit.Value := g_Config.nRingFBAddValueMaxLimit;
    EditRingFBAddValueRate.Value := g_Config.nRingFBAddValueRate;
    EditRingFBAddRate.Value := g_Config.nRingFBAddRate;
    EditRingHJAddValueMaxLimit.Value := g_Config.nRingHJAddValueMaxLimit;
    EditRingHJAddValueRate.Value := g_Config.nRingHJAddValueRate;
    EditRingHJAddRate.Value := g_Config.nRingHJAddRate;
    EditRingMBAddValueMaxLimit.Value := g_Config.nRingMBAddValueMaxLimit;
    EditRingMBAddValueRate.Value := g_Config.nRingMBAddValueRate;
    EditRingMBAddRate.Value := g_Config.nRingMBAddRate;
    EditRingNLAddValueMaxLimit.Value := g_Config.nRingNLAddValueMaxLimit;
    EditRingNLAddValueRate.Value := g_Config.nRingNLAddValueRate;
    EditRingNLAddRate.Value := g_Config.nRingNLAddRate;
    EditRingWFAddValueMaxLimit.Value := g_Config.nRingWFAddValueMaxLimit;
    EditRingWFAddValueRate.Value := g_Config.nRingWFAddValueRate;
    EditRingWFAddRate.Value := g_Config.nRingWFAddRate;
    EditHelmetDCAddValueMaxLimit.Value := g_Config.nHelmeDCAddValueMaxLimit;
    EditHelmetDCAddValueRate.Value := g_Config.nHelmeDCAddValueRate;
    EditHelmetDCAddRate.Value := g_Config.nHelmeDCAddRate;
    EditHelmetMCAddValueMaxLimit.Value := g_Config.nHelmeMCAddValueMaxLimit;
    EditHelmetMCAddValueRate.Value := g_Config.nHelmeMCAddValueRate;
    EditHelmetMCAddRate.Value := g_Config.nHelmeMCAddRate;
    EditHelmetSCAddValueMaxLimit.Value := g_Config.nHelmeSCAddValueMaxLimit;
    EditHelmetSCAddValueRate.Value := g_Config.nHelmeSCAddValueRate;
    EditHelmetSCAddRate.Value := g_Config.nHelmeSCAddRate;
    EditHelmetMainAddValueMaxLimit.Value := g_Config.nHelmeMainAddValueMaxLimit;
    EditHelmetMainAddValueRate.Value := g_Config.nHelmeMainAddValueRate;
    EditHelmetMainAddRate.Value := g_Config.nHelmeMainAddRate;
    EditHelmetQSAddValueMaxLimit.Value := g_Config.nHelmeQSAddValueMaxLimit;
    EditHelmetQSAddValueRate.Value := g_Config.nHelmeQSAddValueRate;
    EditHelmetQSAddRate.Value := g_Config.nHelmeQSAddRate;
    EditHelmetXXAddValueMaxLimit.Value := g_Config.nHelmeXXAddValueMaxLimit;
    EditHelmetXXAddValueRate.Value := g_Config.nHelmeXXAddValueRate;
    EditHelmetXXAddRate.Value := g_Config.nHelmeXXAddRate;
    EditHelmetHJAddValueMaxLimit.Value := g_Config.nHelmeHJAddValueMaxLimit;
    EditHelmetHJAddValueRate.Value := g_Config.nHelmeHJAddValueRate;
    EditHelmetHJAddRate.Value := g_Config.nHelmeHJAddRate;
    EditShoesDCAddValueMaxLimit.Value := g_Config.nShoesDCAddValueMaxLimit;
    EditShoesDCAddValueRate.Value := g_Config.nShoesDCAddValueRate;
    EditShoesDCAddRate.Value := g_Config.nShoesDCAddRate;
    EditShoesMCAddValueMaxLimit.Value := g_Config.nShoesMCAddValueMaxLimit;
    EditShoesMCAddValueRate.Value := g_Config.nShoesMCAddValueRate;
    EditShoesMCAddRate.Value := g_Config.nShoesMCAddRate;
    EditShoesSCAddValueMaxLimit.Value := g_Config.nShoesSCAddValueMaxLimit;
    EditShoesSCAddValueRate.Value := g_Config.nShoesSCAddValueRate;
    EditShoesSCAddRate.Value := g_Config.nShoesSCAddRate;
    EditShoesMainAddValueMaxLimit.Value := g_Config.nShoesMainAddValueMaxLimit;
    EditShoesMainAddValueRate.Value := g_Config.nShoesMainAddValueRate;
    EditShoesMainAddRate.Value := g_Config.nShoesMainAddRate;
    EditShoesQSAddValueMaxLimit.Value := g_Config.nShoesQSAddValueMaxLimit;
    EditShoesQSAddValueRate.Value := g_Config.nShoesQSAddValueRate;
    EditShoesQSAddRate.Value := g_Config.nShoesQSAddRate;
    EditShoesJMAddValueMaxLimit.Value := g_Config.nShoesJMAddValueMaxLimit;
    EditShoesJMAddValueRate.Value := g_Config.nShoesJMAddValueRate;
    EditShoesJMAddRate.Value := g_Config.nShoesJMAddRate;
    EditShoesHJAddValueMaxLimit.Value := g_Config.nShoesHJAddValueMaxLimit;
    EditShoesHJAddValueRate.Value := g_Config.nShoesHJAddValueRate;
    EditShoesHJAddRate.Value := g_Config.nShoesHJAddRate;
    EditMedalDCAddValueMaxLimit.Value := g_Config.nMedalDCAddValueMaxLimit;
    EditMedalDCAddValueRate.Value := g_Config.nMedalDCAddValueRate;
    EditMedalDCAddRate.Value := g_Config.nMedalDCAddRate;
    EditMedalMCAddValueMaxLimit.Value := g_Config.nMedalMCAddValueMaxLimit;
    EditMedalMCAddValueRate.Value := g_Config.nMedalMCAddValueRate;
    EditMedalMCAddRate.Value := g_Config.nMedalMCAddRate;
    EditMedalSCAddValueMaxLimit.Value := g_Config.nMedalSCAddValueMaxLimit;
    EditMedalSCAddValueRate.Value := g_Config.nMedalSCAddValueRate;
    EditMedalSCAddRate.Value := g_Config.nMedalSCAddRate;
    EditMedalMainAddValueMaxLimit.Value := g_Config.nMedalMainAddValueMaxLimit;
    EditMedalMainAddValueRate.Value := g_Config.nMedalMainAddValueRate;
    EditMedalMainAddRate.Value := g_Config.nMedalMainAddRate;
    EditMedalQSAddValueMaxLimit.Value := g_Config.nMedalQSAddValueMaxLimit;
    EditMedalQSAddValueRate.Value := g_Config.nMedalQSAddValueRate;
    EditMedalQSAddRate.Value := g_Config.nMedalQSAddRate;
    EditMedalJMAddValueMaxLimit.Value := g_Config.nMedalJMAddValueMaxLimit;
    EditMedalJMAddValueRate.Value := g_Config.nMedalJMAddValueRate;
    EditMedalJMAddRate.Value := g_Config.nMedalJMAddRate;
    EditMedalFBAddValueMaxLimit.Value := g_Config.nMedalFBAddValueMaxLimit;
    EditMedalFBAddValueRate.Value := g_Config.nMedalFBAddValueRate;
    EditMedalFBAddRate.Value := g_Config.nMedalFBAddRate;
    EditMedalBJAddValueMaxLimit.Value := g_Config.nMedalBJAddValueMaxLimit;
    EditMedalBJAddValueRate.Value := g_Config.nMedalBJAddValueRate;
    EditMedalBJAddRate.Value := g_Config.nMedalBJAddRate;
    EditMedalHJAddValueMaxLimit.Value := g_Config.nMedalHJAddValueMaxLimit;
    EditMedalHJAddValueRate.Value := g_Config.nMedalHJAddValueRate;
    EditMedalHJAddRate.Value := g_Config.nMedalHJAddRate;
    EditMedalMBAddValueMaxLimit.Value := g_Config.nMedalMBAddValueMaxLimit;
    EditMedalMBAddValueRate.Value := g_Config.nMedalMBAddValueRate;
    EditMedalMBAddRate.Value := g_Config.nMedalMBAddRate;
    EditMedalNLAddValueMaxLimit.Value := g_Config.nMedalNLAddValueMaxLimit;
    EditMedalNLAddValueRate.Value := g_Config.nMedalNLAddValueRate;
    EditMedalNLAddRate.Value := g_Config.nMedalNLAddRate;
    EditMedalNSAddValueMaxLimit.Value := g_Config.nMedalNSAddValueMaxLimit;
    EditMedalNSAddValueRate.Value := g_Config.nMedalNSAddValueRate;
    EditMedalNSAddRate.Value := g_Config.nMedalNSAddRate;
    EditMysteryAddValueMaxLimit.Value := g_Config.nMysteryAddValueMaxLimit;
    EditMysteryAddValueRate.Value := g_Config.nMysteryAddValueRate;
    EditMysteryAddRate.Value := g_Config.nMysteryAddRate;
    EditReadRate1.Value := g_Config.nReadRate[1];
    EditReadRate2.Value := g_Config.nReadRate[2];
    EditReadRate3.Value := g_Config.nReadRate[3];
    EditReadRate4.Value := g_Config.nReadRate[4];
    EditAdvancedKamPo.Value := g_Config.nAdvancedKamPo;
    EditRebirthRate.Value := g_Config.nRebirthRate;
    EditMagicShieldRate.Value := g_Config.nMagicShieldRate;
    EditParalysisRate.Value := g_Config.nParalysisRate;
    EditParalysis2Rate.Value := g_Config.nParalysis2Rate;
    EditParalysis1Rate.Value := g_Config.nParalysis1Rate;
    EditProbeNecklaceRate.Value := g_Config.nProbeNecklaceRate;
    EditTeleportRate.Value := g_Config.nTeleportRate;
    EditSpiritMediaAddValueRate.Value := g_Config.nSpiritMediaAddValueRate;
    EditSpiritMediaAddRate.Value := g_Config.nSpiritMediaAddRate;
    EditFindJewelRave.Value := g_Config.nFindJewelRave;
    EditDigJewelHitRate.Value := g_Config.nDigJewelHitRate;
    EditGetDigJewelRave.Value := g_Config.nGetDigJewelRave;
    EditDecDuraRate.Value := g_Config.nDecDigJewelDuraRate;
    CheckBoxUseCanKamPo.Checked := g_Config.boUseCanKamPo;
    CheckBoxOffLineEnergy.Checked := g_Config.boOffLineEnergy;
    EditEnergyValueTime.Value := g_Config.nEnergyValueTime;
    EditJudgePrice.Value := g_Config.nJudgePrice;
    RadioButtonJudgeGameGold.Checked := not g_Config.boJudgeUseGold;
    RadioButtonJudgeUseGold.Checked := g_Config.boJudgeUseGold;
    EditNewKamPoLockNeed1.Value := g_Config.dwNewKamPoLockNeed1;
    EditNewKamPoLockNeed2.Value := g_Config.dwNewKamPoLockNeed2;
    EditNewKamPoNeed1.Value := g_Config.dwNewKamPoNeed1;
    EditNewKamPoNeed2.Value := g_Config.dwNewKamPoNeed2;
    EditJudgePrice.Value := g_Config.nJudgePrice;
    EditMakeScroll1Rate.Value := g_Config.nMakeScrollRate[1];
    EditMakeScroll2Rate.Value := g_Config.nMakeScrollRate[2];
    EditMakeScroll3Rate.Value := g_Config.nMakeScrollRate[3];
    EditMakeScroll4Rate.Value := g_Config.nMakeScrollRate[3];

    EditNGStrongItem.Text := g_Config.sNGStrongItem;
    nNGSkillMaxLevel.Value := g_Config.nNGSkillMaxLevel;
    SpinEditSKILL_200NGStrong1.Value := g_Config.nSKILL_200NGStrong[0];
    SpinEditSKILL_200NGStrong2.Value := g_Config.nSKILL_200NGStrong[1];
    SpinEditSKILL_200NGStrong3.Value := g_Config.nSKILL_200NGStrong[2];
    SpinEditSKILL_200NGStrong4.Value := g_Config.nSKILL_200NGStrong[3];
    Skill_202NGStrong1.Value := g_Config.nSkill_202NGStrong[0];
    Skill_202NGStrong2.Value := g_Config.nSkill_202NGStrong[1];
    Skill_202NGStrong3.Value := g_Config.nSkill_202NGStrong[2];
    Skill_202NGStrong4.Value := g_Config.nSkill_202NGStrong[3];
    Skill_236NGStrong1.Value := g_Config.nSkill_236NGStrong[0];
    Skill_236NGStrong2.Value := g_Config.nSkill_236NGStrong[1];
    Skill_236NGStrong3.Value := g_Config.nSkill_236NGStrong[2];
    Skill_236NGStrong4.Value := g_Config.nSkill_236NGStrong[3];
    Skill_204NGStrong1.Value := g_Config.nSkill_204NGStrong[0];
    Skill_204NGStrong2.Value := g_Config.nSkill_204NGStrong[1];
    Skill_204NGStrong3.Value := g_Config.nSkill_204NGStrong[2];
    Skill_204NGStrong4.Value := g_Config.nSkill_204NGStrong[3];
    Skill_206NGStrong1.Value := g_Config.nSkill_206NGStrong[0];
    Skill_206NGStrong2.Value := g_Config.nSkill_206NGStrong[1];
    Skill_206NGStrong3.Value := g_Config.nSkill_206NGStrong[2];
    Skill_206NGStrong4.Value := g_Config.nSkill_206NGStrong[3];
    Skill_239NGStrong1.Value := g_Config.nSkill_239NGStrong[0];
    Skill_239NGStrong2.Value := g_Config.nSkill_239NGStrong[1];
    Skill_239NGStrong3.Value := g_Config.nSkill_239NGStrong[2];
    Skill_239NGStrong4.Value := g_Config.nSkill_239NGStrong[3];
    Skill_230NGStrong1.Value := g_Config.nSkill_230NGStrong[0];
    Skill_230NGStrong2.Value := g_Config.nSkill_230NGStrong[1];
    Skill_230NGStrong3.Value := g_Config.nSkill_230NGStrong[2];
    Skill_230NGStrong4.Value := g_Config.nSkill_230NGStrong[3];
    Skill_232NGStrong1.Value := g_Config.nSkill_232NGStrong[0];
    Skill_232NGStrong2.Value := g_Config.nSkill_232NGStrong[1];
    Skill_232NGStrong3.Value := g_Config.nSkill_232NGStrong[2];
    Skill_232NGStrong4.Value := g_Config.nSkill_232NGStrong[3];
    Skill_241NGStrong1.Value := g_Config.nSkill_241NGStrong[0];
    Skill_241NGStrong2.Value := g_Config.nSkill_241NGStrong[1];
    Skill_241NGStrong3.Value := g_Config.nSkill_241NGStrong[2];
    Skill_241NGStrong4.Value := g_Config.nSkill_241NGStrong[3];
    Skill_228NGStrong1.Value := g_Config.nSkill_228NGStrong[0];
    Skill_228NGStrong2.Value := g_Config.nSkill_228NGStrong[1];
    Skill_228NGStrong3.Value := g_Config.nSkill_228NGStrong[2];
    Skill_228NGStrong4.Value := g_Config.nSkill_228NGStrong[3];
    Skill_234NGStrong1.Value := g_Config.nSkill_234NGStrong[0];
    Skill_234NGStrong2.Value := g_Config.nSkill_234NGStrong[1];
    Skill_234NGStrong3.Value := g_Config.nSkill_234NGStrong[2];
    Skill_234NGStrong4.Value := g_Config.nSkill_234NGStrong[3];

    Skill_208NGStrong0.Value := g_Config.nSkill_208NGStrong[0];
    Skill_208NGStrong1.Value := g_Config.nSkill_208NGStrong[1];
    Skill_208NGStrong2.Value := g_Config.nSkill_208NGStrong[2];
    Skill_208NGStrong3.Value := g_Config.nSkill_208NGStrong[3];

    Skill_214NGStrong0.Value := g_Config.nSkill_214NGStrong[0];
    Skill_214NGStrong1.Value := g_Config.nSkill_214NGStrong[1];
    Skill_214NGStrong2.Value := g_Config.nSkill_214NGStrong[2];
    Skill_214NGStrong3.Value := g_Config.nSkill_214NGStrong[3];

    nSkill_218NGStrong0.Value := g_Config.nSkill_218NGStrong[0];
    nSkill_218NGStrong1.Value := g_Config.nSkill_218NGStrong[1];
    nSkill_218NGStrong2.Value := g_Config.nSkill_218NGStrong[2];
    nSkill_218NGStrong3.Value := g_Config.nSkill_218NGStrong[3];

    nSkill_222NGStrong0.Value := g_Config.nSkill_222NGStrong[0];
    nSkill_222NGStrong1.Value := g_Config.nSkill_222NGStrong[1];
    nSkill_222NGStrong2.Value := g_Config.nSkill_222NGStrong[2];
    nSkill_222NGStrong3.Value := g_Config.nSkill_222NGStrong[3];

    nSkill_210NGStrong0.Value := g_Config.nSkill_210NGStrong[0];
    nSkill_210NGStrong1.Value := g_Config.nSkill_210NGStrong[1];
    nSkill_210NGStrong2.Value := g_Config.nSkill_210NGStrong[2];
    nSkill_210NGStrong3.Value := g_Config.nSkill_210NGStrong[3];

    nSkill_212NGStrong0.Value := g_Config.nSkill_212NGStrong[0];
    nSkill_212NGStrong1.Value := g_Config.nSkill_212NGStrong[1];
    nSkill_212NGStrong2.Value := g_Config.nSkill_212NGStrong[2];
    nSkill_212NGStrong3.Value := g_Config.nSkill_212NGStrong[3];

    nSkill_216NGStrong0.Value := g_Config.nSkill_216NGStrong[0];
    nSkill_216NGStrong1.Value := g_Config.nSkill_216NGStrong[1];
    nSkill_216NGStrong2.Value := g_Config.nSkill_216NGStrong[2];
    nSkill_216NGStrong3.Value := g_Config.nSkill_216NGStrong[3];

    nSkill_224NGStrong0.Value := g_Config.nSkill_224NGStrong[0];
    nSkill_224NGStrong1.Value := g_Config.nSkill_224NGStrong[1];
    nSkill_224NGStrong2.Value := g_Config.nSkill_224NGStrong[2];
    nSkill_224NGStrong3.Value := g_Config.nSkill_224NGStrong[3];

    nSkill_226NGStrong0.Value := g_Config.nSkill_226NGStrong[0];
    nSkill_226NGStrong1.Value := g_Config.nSkill_226NGStrong[1];
    nSkill_226NGStrong2.Value := g_Config.nSkill_226NGStrong[2];
    nSkill_226NGStrong3.Value := g_Config.nSkill_226NGStrong[3];

    nSkill_220NGStrong0.Value := g_Config.nSkill_220NGStrong[0];
    nSkill_220NGStrong1.Value := g_Config.nSkill_220NGStrong[1];
    nSkill_220NGStrong2.Value := g_Config.nSkill_220NGStrong[2];
    nSkill_220NGStrong3.Value := g_Config.nSkill_220NGStrong[3];
  {$IFEND}
    SpinEditFireDelayTime.Value := g_Config.nFireDelayTimeRate;
    SpinEditFirePower.Value := g_Config.nFirePowerRate;
    SpinEditFireMaxTime.Value := g_Config.nFireMaxTime;
    CheckBoxFireChgMapExtinguish.Checked := g_Config.boChangeMapFireExtinguish;
    SpinEditDidingPowerRate.Value := g_Config.nDidingPowerRate;
    for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
      if g_Config.BoneFammArray[I].nHumLevel <= 0 then Break;

      GridBoneFamm.Cells[0, I + 1] := IntToStr(g_Config.BoneFammArray[I].nHumLevel);
      GridBoneFamm.Cells[1, I + 1] := g_Config.BoneFammArray[I].sMonName;
      GridBoneFamm.Cells[2, I + 1] := IntToStr(g_Config.BoneFammArray[I].nCount);
      GridBoneFamm.Cells[3, I + 1] := IntToStr(g_Config.BoneFammArray[I].nLevel);
    end;

    EditDogzName.Text := g_Config.sDogz;
    EditDogzCount.Value := g_Config.nDogzCount;
    for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
      if g_Config.DogzArray[I].nHumLevel <= 0 then Break;
      GridDogz.Cells[0, I + 1] := IntToStr(g_Config.DogzArray[I].nHumLevel);
      GridDogz.Cells[1, I + 1] := g_Config.DogzArray[I].sMonName;
      GridDogz.Cells[2, I + 1] := IntToStr(g_Config.DogzArray[I].nCount);
      GridDogz.Cells[3, I + 1] := IntToStr(g_Config.DogzArray[I].nLevel);
    end;
  //圣兽
    EditSacredName.Text := g_Config.sSacredName;
    EditSacredCount.Value := g_Config.nSacredCount;
    for I := Low(g_Config.SacredArray) to High(g_Config.SacredArray) do begin
      if g_Config.SacredArray[I].nHumLevel <= 0 then Break;
      GridSacred.Cells[0, I + 1] := IntToStr(g_Config.SacredArray[I].nHumLevel);
      GridSacred.Cells[1, I + 1] := g_Config.SacredArray[I].sMonName;
      GridSacred.Cells[2, I + 1] := IntToStr(g_Config.SacredArray[I].nCount);
      GridSacred.Cells[3, I + 1] := IntToStr(g_Config.SacredArray[I].nLevel);
    end;
  //火灵
    FireFairyNameEdt.Text := g_Config.sFireFairy;
    SpinFireFairyEdt.Value := g_Config.nFireFairyCount;
    SpinEditFireFairyDuntRateBelow.Value := g_Config.nFireFairyDuntRateBelow;
    SpinFireFairyDuntRateEdt.Value := g_Config.nFireFairyDuntRate;
    SpinFireFairyAttackRateEdt.Value := g_Config.nFireFairyAttackRate;
    CheckBoxFireFairyShareMasterMP.Checked := g_Config.boFireFairyShareMasterMP;
    CheckBoxFireFairyNeglectACMAC.Checked := g_Config.boFireFairyNeglectACMAC;
   //月灵
    FairyNameEdt.Text := g_Config.sFairy;
    SpinFairyEdt.Value := g_Config.nFairyCount;
    SpinFairyDuntRateEdt.Value :=g_Config.nFairyDuntRate;
    SpinEditFairyDuntRateBelow.Value :=g_Config.nFairyDuntRateBelow;//月灵重击次数,达到次数时按等级出重击 20090105
    SpinFairyAttackRateEdt.Value :=g_Config.nFairyAttackRate;
    Spin43KillHitRateEdt.Value :=g_Config.n43KillHitRate;//开天斩重击几率 20080213
    Spin43KillAttackRateEdt.Value :=g_Config.n43KillAttackRate;//开天斩重击倍数  20080213
    SpinEditAttackRate_43.Value :=g_Config.nAttackRate_43;//开天斩威力  20080213
    SpinEditAttackRate_26.Value :=g_Config.nAttackRate_26;//烈火剑法威力倍数 20081208
    SpinEditAttackRate_74.Value :=g_Config.nAttackRate_74;//逐日剑法威力倍数 20080511
    for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do begin
      if g_Config.FairyArray[I].nHumLevel <= 0 then Break;
      GridFairy.Cells[0, I + 1] := IntToStr(g_Config.FairyArray[I].nHumLevel);
      GridFairy.Cells[1, I + 1] := g_Config.FairyArray[I].sMonName;
      GridFairy.Cells[2, I + 1] := IntToStr(g_Config.FairyArray[I].nCount);
      GridFairy.Cells[3, I + 1] := IntToStr(g_Config.FairyArray[I].nLevel);
    end;

    RefMagicSkill();

    RefUpgradeWeapon();
    RefMakeMine();
    RefWinLottery();
    EditMasterCount.Value := g_Config.nMasterCount;//可收徒弟数 20080530
    EditMasterOKLevel.Value := g_Config.nMasterOKLevel;
    EditMasterOKCreditPoint.Value := g_Config.nMasterOKCreditPoint;
    EditMasterOKBonusPoint.Value := g_Config.nMasterOKBonusPoint;

    CheckBoxPullPlayObject.Checked := g_Config.boPullPlayObject;
    CheckBoxPullCrossInSafeZone.Checked := g_Config.boPullCrossInSafeZone;
    CheckBoxPullCrossInSafeZone.Enabled := g_Config.boPullPlayObject;

    CheckBoxPlayObjectReduceMP.Checked := g_Config.boPlayObjectReduceMP;
    CheckBoxGroupMbAttackSlave.Checked := g_Config.boGroupMbAttackSlave;
    CheckBoxItemName.Checked := g_Config.boChangeUseItemNameByPlayName;
    EditItemName.Text := g_Config.sChangeUseItemName;
    CheckBoxDedingAllowPK.Checked := g_Config.boDedingAllowPK;

    SpinEditMakeSelfTick.Value := g_Config.nMakeSelfTick;//分身使用时长 20080404
    SpinEditnCopyHumanTick.Value := g_Config.nCopyHumanTick;//召唤分身间隔 20080204
    SpinEditKill55UseTime.Value := g_Config.nKill55UseTime;
    SpinEditKill43Sec.Value := g_Config.nKill43UseTime;//开天斩使用间隔 20080204
    SpinEditSkill39Sec.Value := g_Config.nDedingUseTime;
    CheckBoxStartMapEvent.Checked := g_Config.boStartMapEvent;//开启地图事件触发

    EditAbilityUpTick.Value := g_Config.nAbilityUpTick;//无极真气使用间隔 20080603

    CheckBoxAbilityUpFixMode.Checked := g_Config.boAbilityUpFixMode;//无极真气使用时长模式 20081109
    if g_Config.boAbilityUpFixMode then begin
      SpinEditAbilityUpFixUseTime.Enabled:= True;
      SpinEditAbilityUpUseTime.Enabled:= False;
    end else begin
      SpinEditAbilityUpFixUseTime.Enabled:= False;
      SpinEditAbilityUpUseTime.Enabled:= True;
    end;
    CheckBoxAbilityAddMode.Checked := g_Config.boAbilityAddMode;
    CheckBoxMagFirNoneSSMagic.Checked := g_Config.boMagFirNoneSSMagic;
    CheckBoxDecSuitItemMode.Checked := g_Config.boDecSuitItemMode;
    CheckBoxDecMag105SC.Checked := g_Config.boDecMag105SC;
    SpinEditAbilityUpFixUseTime.Value := g_Config.nAbilityUpFixUseTime;//无极真气使用固定时长 20081109
    SpinEditAbilityUpUseTime.Value := g_Config.nAbilityUpUseTime;//无极真气使用时长 20080603

    SpinEditMinDrinkValue67.Value := g_Config.nMinDrinkValue67;//先天元力失效酒量下限比例 20080626
    SpinEditMinDrinkValue68.Value := g_Config.nMinDrinkValue68;//酒气护体失效酒量下限比例 20080626
    SpinEditHPUpTick.Value := g_Config.nHPUpTick;//酒气护体使用间隔 20080625
    SpinEditHPUpUseTime.Value := g_Config.nHPUpUseTime;//酒气护体增加使用时长 20080625
    for I := 1 to GridSkill68.RowCount - 1 do begin//酒气护体升级经验 20080625
      GridSkill68.Cells[1, I] := IntToStr(g_Config.dwSkill68NeedExps[I]);
    end;
    {$IF M2Version = 1}
    for I := 1 to GridSkill95.RowCount - 1 do begin//斗转星移升级经验(100)
      GridSkill95.Cells[1, I] := IntToStr(g_Config.dwSkill95NeedExps[I]);
    end;
    {$IFEND}
    SpinEditChallengeTime.Value := g_Config.nChallengeTime;//挑战时间 20080706
    CheckBoxShowGuildName.Checked := g_Config.boShowGuildName;//人物名是否显示行会信息 20080726

    if g_Config.boSkill31Effect then begin//魔法盾效果 T-特色效果 F-盛大效果 20080808
      RadioboSkill31EffectTrue.Checked := True;
      RadioboSkill31EffectFalse.Checked := False;
    end else begin
      RadioboSkill31EffectTrue.Checked := False;
      RadioboSkill31EffectFalse.Checked := True;
    end;
    SpinEditSkill66Rate.Value := g_Config.nSkill66Rate;//四级魔法盾抵御伤害百分率 20080829
    SpinEditOrdinarySkill66Rate.Value := g_Config.nOrdinarySkill66Rate;//普通魔法盾抵御伤害百分率 20081226
    SpinEditNGSkillRate.Value := g_Config.nNGSkillRate;//内功技能增强的攻防比率
    SpinEditWarrNGLevelIncDC.Value := g_Config.nWarrNGLevelIncDC;//战内功等级+攻 200990812
    SpinEditWarrNGLevelIncAC.Value := g_Config.nWarrNGLevelIncAC;//战内功等级+防 200990812
    SpinEditWizardNGLevelIncDC.Value := g_Config.nWizardNGLevelIncDC;//法内功等级+攻 200990812
    SpinEditWizardNGLevelIncAC.Value := g_Config.nWizardNGLevelIncAC;//法内功等级+防 200990812

    SpinEditTaosNGLevelIncDC.Value := g_Config.nTaosNGLevelIncDC;//道内功等级+攻
    SpinEditTaosNGLevelIncAC.Value := g_Config.nTaosNGLevelIncAC;//道内功等级+防

    SpinEditSkill69NG.Value := g_Config.nSkill69NG;//内力值参数 20081001
    SpinEditSkill69NGExp.Value := g_Config.nSkill69NGExp;//主体内功经验参数 20081001
    SpinEditSkill69NGExp1.Value := g_Config.nSkill69NGExp1;//主体内功经验参数2 20090727
    SpinEditHeroSkill69NGExp.Value := g_Config.nHeroSkill69NGExp;//英雄内功经验参数 20081001
    SpinEditHeroSkill69NGExp1.Value := g_Config.nHeroSkill69NGExp1;//英雄内功经验参数2 20090727
    SpinEditLimitExpNGLevel.Value := g_Config.nLimitExpNGLevel;//内功等级限制
    SpinEditdwIncNHTime.Value := g_Config.dwIncNHTime div 1000;//增加内力值间隔 20081002
    SpinEditDrinkIncNHExp.Value := g_Config.nDrinkIncNHExp;//饮酒增加内功经验 20081003
    SpinEditHitStruckDecNH.Value := g_Config.nHitStruckDecNH;//内功抵御普通攻击消耗内力值 20081003
    EditKillMonNGExpMultiple.Value := g_Config.dwKillMonNGExpMultiple;//杀怪内功经验倍数 20081215

    RefPulsePointNGLevelConf();//刷新脉穴打通所需内功等级
    RefReNewLevelConf();
    RefMonUpgrade();
    RefSpiritMutiny();
    RefMonSayMsg();
    RefWeaponMakeLuck();

    RefCopyHumConf;

    EditHomeMap.Text := g_Config.sAIHomeMap;
    EditHomeX.Value := g_Config.nAIHomeX;
    EditHomeY.Value := g_Config.nAIHomeY;

    CheckBoxHPAutoMoveMap.Checked := g_Config.boHPAutoMoveMap;
    CheckBoxAutoRepairItem.Checked := g_Config.boAutoRepairItem;
    CheckBoxAutoPickUpItem.Checked := g_Config.boAutoPickUpItem;

    CheckBoxRenewHealth.Checked := g_Config.boRenewHealth;
    EditRenewPercent.Value := g_Config.nRenewPercent;

    EditAIRunIntervalTime.Value := g_Config.nAIRunIntervalTime;
    EditAIWalkIntervalTime.Value := g_Config.nAIWalkIntervalTime;
    SpinAIWarrorAttackTime.Value := g_Config.nAIWarrorAttackTime;
    SpinAIWizardAttackTime.Value := g_Config.nAIWizardAttackTime;
    SpinAITaoistAttackTime.Value := g_Config.nAITaoistAttackTime;
    EditConfigListFileName.Text := g_Config.sAIConfigListFileName;
   {$IF HEROVERSION = 1}
    Label615.Visible:= True;
    EditsHeroConfigListFileName.Visible:= True;
    EditsHeroConfigListFileName.Text := g_Config.sHeroAIConfigListFileName;
  {$IFEND}
    g_AICharNameList.Lock;
    try
      ListBoxAIList.Clear;
      ListBoxAIList.Items.AddStrings(g_AICharNameList);
    finally
      g_AICharNameList.UnLock;
    end;
    ButtonAIDel.Enabled := False;
    ButtonAILogon.Enabled := False;

    boOpened := True;
    FunctionConfigControl.ActivePageIndex := 0;
    {$IF M2Version = 0}
    TabSheet55.TabVisible := False;
    {$IFEND}
  except
    on E: Exception do MainOutMessage(Format('{%s} TfrmFunctionConfig.Open %s',[g_sExceptionVer, E.Message]));
  end;
    ShowModal;
end;

procedure TfrmFunctionConfig.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  GridExpCrystalLevelExp.Cells[0, 0] := '等级';
  GridExpCrystalLevelExp.Cells[1, 0] := '经验值';
  GridExpCrystalLevelExp.Cells[2, 0] := '内功经验值';
  for I := 1 to GridExpCrystalLevelExp.RowCount - 1 do begin
    GridExpCrystalLevelExp.Cells[0, I] := IntToStr(I);
  end;
  {$IF M2Version <> 2}
  StringGridSKILLStrong.ColWidths[0]:= 52;
  StringGridSKILLStrong.Cells[0, 0] := '技能';
  StringGridSKILLStrong.Cells[0, 1] := '攻杀剑术';
  StringGridSKILLStrong.Cells[0, 2] := '圆月弯刀';
  StringGridSKILLStrong.Cells[0, 3] := '刺杀剑术';
  StringGridSKILLStrong.Cells[0, 4] := '烈火剑法';
  StringGridSKILLStrong.Cells[0, 5] := '逐日剑法';
  StringGridSKILLStrong.Cells[0, 6] := '雷 电 术';
  StringGridSKILLStrong.Cells[0, 7] := '疾光电影';
  StringGridSKILLStrong.Cells[0, 8] := '火    墙';
  StringGridSKILLStrong.Cells[0, 9] := '灭 天 火';
  StringGridSKILLStrong.Cells[0,10] := '流星火雨';
  StringGridSKILLStrong.Cells[0,11] := '施 毒 术';
  StringGridSKILLStrong.Cells[0,12] := '灵魂火符';
  StringGridSKILLStrong.Cells[0,13] := '召唤骷髅';
  StringGridSKILLStrong.Cells[0,14] := '召唤圣兽';
  StringGridSKILLStrong.Cells[0,15] := '噬 血 术';

  StringGridSKILLStrong.Cells[0,16] := '爆裂火焰';
  StringGridSKILLStrong.Cells[0,17] := '冰 咆 哮';
  StringGridSKILLStrong.Cells[0,18] := '幽 灵 盾';
  StringGridSKILLStrong.Cells[0,19] := '战 甲 术';
  StringGridSKILLStrong.Cells[0,20] := '纵横剑术';
  StringGridSKILLStrong.Cells[0,21] := '冰霜雪雨';
  StringGridSKILLStrong.Cells[0,22] := '裂 神 符';

  StringGridSKILLStrong.Cells[1, 0] := '1重';
  StringGridSKILLStrong.Cells[2, 0] := '2重';
  StringGridSKILLStrong.Cells[3, 0] := '3重';
  StringGridSKILLStrong.Cells[4, 0] := '4重';
  StringGridSKILLStrong.Cells[5, 0] := '5重';
  StringGridSKILLStrong.Cells[6, 0] := '6重';
  StringGridSKILLStrong.Cells[7, 0] := '7重';
  StringGridSKILLStrong.Cells[8, 0] := '8重';
  StringGridSKILLStrong.Cells[9, 0] := '9重';

  StringGridSKILLStrongRate.ColWidths[0]:= 56;
  StringGridSKILLStrongRate.Cells[0, 0] := '强化技能';
  StringGridSKILLStrongRate.Cells[0, 1] := '攻杀剑术';
  StringGridSKILLStrongRate.Cells[0, 2] := '圆月弯刀';
  StringGridSKILLStrongRate.Cells[0, 3] := '刺杀剑术';
  StringGridSKILLStrongRate.Cells[0, 4] := '烈火剑法';
  StringGridSKILLStrongRate.Cells[0, 5] := '逐日剑法';
  StringGridSKILLStrongRate.Cells[0, 6] := '雷 电 术';
  StringGridSKILLStrongRate.Cells[0, 7] := '疾光电影';
  StringGridSKILLStrongRate.Cells[0, 8] := '火    墙';
  StringGridSKILLStrongRate.Cells[0, 9] := '灭 天 火';
  StringGridSKILLStrongRate.Cells[0,10] := '流星火雨';
  StringGridSKILLStrongRate.Cells[0,11] := '施 毒 术';
  StringGridSKILLStrongRate.Cells[0,12] := '灵魂火符';
  StringGridSKILLStrongRate.Cells[0,13] := '噬 血 术';
  StringGridSKILLStrongRate.Cells[0,14] := '爆裂火焰';
  StringGridSKILLStrongRate.Cells[0,15] := '冰 咆 哮';
  StringGridSKILLStrongRate.Cells[0,16] := '幽 灵 盾';
  StringGridSKILLStrongRate.Cells[0,17] := '战 甲 术';

  StringGridSKILLStrongRate.Cells[1, 0] := '威力倍率(n/100)';

  StringGridUpHeartNeedLevel.Cells[0, 0] := '心法等级';
  StringGridUpHeartNeedLevel.Cells[1, 0] := '需人物等级';
  StringGridUpHeartNeedLevel.Cells[0, 1] := '1级';
  StringGridUpHeartNeedLevel.Cells[0, 2] := '2级';
  StringGridUpHeartNeedLevel.Cells[0, 3] := '3级';
  StringGridUpHeartNeedLevel.Cells[0, 4] := '4级';
  StringGridUpHeartNeedLevel.Cells[0, 5] := '5级';
  StringGridUpHeartNeedLevel.Cells[0, 6] := '6级';
  StringGridUpHeartNeedLevel.Cells[0, 7] := '7级';
  StringGridUpHeartNeedLevel.Cells[0, 8] := '8级';
  StringGridUpHeartNeedLevel.Cells[0, 9] := '9级';
  {$IFEND}
  GridMedicineExp.Cells[0, 0] := '等级';
  GridMedicineExp.Cells[1, 0] := '药力值';
  for I := 1 to GridMedicineExp.RowCount - 1 do begin
    GridMedicineExp.Cells[0, I] := IntToStr(I);
  end;

  GridSkill68.Cells[0, 0] := '等级';
  GridSkill68.Cells[1, 0] := '经验值';
  for I := 1 to GridSkill68.RowCount - 1 do begin
    GridSkill68.Cells[0, I] := IntToStr(I);
  end;

  GridSkill95.Cells[0, 0] := '等级';
  GridSkill95.Cells[1, 0] := '修炼值';
  for I := 1 to GridSkill95.RowCount - 1 do begin
    GridSkill95.Cells[0, I] := IntToStr(I);
  end;

  GridBoneFamm.Cells[0, 0] := '人物等级';
  GridBoneFamm.Cells[1, 0] := '怪物名称';
  GridBoneFamm.Cells[2, 0] := '数量';
  GridBoneFamm.Cells[3, 0] := '等级';

  GridDogz.Cells[0, 0] := '人物等级';
  GridDogz.Cells[1, 0] := '怪物名称';
  GridDogz.Cells[2, 0] := '数量';
  GridDogz.Cells[3, 0] := '等级';
  //圣兽
  GridSacred.Cells[0, 0] := '人物等级';
  GridSacred.Cells[1, 0] := '怪物名称';
  GridSacred.Cells[2, 0] := '数量';
  GridSacred.Cells[3, 0] := '等级';
  //月灵
  GridFairy.Cells[0, 0] := '人物等级';
  GridFairy.Cells[1, 0] := '怪物名称';
  GridFairy.Cells[2, 0] := '数量';
  GridFairy.Cells[3, 0] := '等级';

  FunctionConfigControl.ActivePageIndex := 0;
  MagicPageControl.ActivePageIndex := 0;
{$IF (SoftVersion = VERPRO) or (SoftVersion = VERENT)}
  CheckBoxHungerDecPower.Visible := True;
{$ELSE}
  CheckBoxHungerDecPower.Visible := False;
{$IFEND}

{$IF SoftVersion = VERDEMO}
  Caption := '功能设置[演示版本，所有设置调整有效，但不能保存]'
{$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxEnablePasswordLockClick(
  Sender: TObject);
begin
  case CheckBoxEnablePasswordLock.Checked of
    True: begin
        CheckBoxLockGetBackItem.Enabled := True;
        CheckBoxLockLogin.Enabled := True;
      end;
    False: begin
        CheckBoxLockGetBackItem.Checked := False;
        CheckBoxLockLogin.Checked := False;

        CheckBoxLockGetBackItem.Enabled := False;
        CheckBoxLockLogin.Enabled := False;
      end;
  end;
  if not boOpened then Exit;
  g_Config.boPasswordLockSystem := CheckBoxEnablePasswordLock.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockGetBackItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockGetBackItemAction := CheckBoxLockGetBackItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockDealItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockDealAction := CheckBoxLockDealItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockDropItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockDropAction := CheckBoxLockDropItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockUseItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockUserItemAction := CheckBoxLockUseItem.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxLockLoginClick(Sender: TObject);
begin
  case CheckBoxLockLogin.Checked of //
    True: begin
        CheckBoxLockWalk.Enabled := True;
        CheckBoxLockRun.Enabled := True;
        CheckBoxLockHit.Enabled := True;
        CheckBoxLockSpell.Enabled := True;
        CheckBoxLockInObMode.Enabled := True;
        CheckBoxLockSendMsg.Enabled := True;
        CheckBoxLockDealItem.Enabled := True;
        CheckBoxLockDropItem.Enabled := True;
        CheckBoxLockUseItem.Enabled := True;
        CheckBoxLockCallHero.Enabled := True;
      end;
    False: begin
        CheckBoxLockWalk.Checked := False;
        CheckBoxLockRun.Checked := False;
        CheckBoxLockHit.Checked := False;
        CheckBoxLockSpell.Checked := False;
        CheckBoxLockInObMode.Checked := False;
        CheckBoxLockSendMsg.Checked := False;
        CheckBoxLockDealItem.Checked := False;
        CheckBoxLockDropItem.Checked := False;
        CheckBoxLockUseItem.Checked := False;
        CheckBoxLockCallHero.Checked := False;

        CheckBoxLockWalk.Enabled := False;
        CheckBoxLockRun.Enabled := False;
        CheckBoxLockHit.Enabled := False;
        CheckBoxLockSpell.Enabled := False;
        CheckBoxLockInObMode.Enabled := False;
        CheckBoxLockSendMsg.Enabled := False;
        CheckBoxLockDealItem.Enabled := False;
        CheckBoxLockDropItem.Enabled := False;
        CheckBoxLockUseItem.Enabled := False;
        CheckBoxLockCallHero.Enabled := False;
      end;
  end;
  if not boOpened then Exit;
  g_Config.boLockHumanLogin := CheckBoxLockLogin.Checked;
  ModValue();

end;

procedure TfrmFunctionConfig.CheckBoxLockWalkClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockWalkAction := CheckBoxLockWalk.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockRunClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockRunAction := CheckBoxLockRun.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockHitClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockHitAction := CheckBoxLockHit.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockSpellClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockSpellAction := CheckBoxLockSpell.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockSendMsgClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockSendMsgAction := CheckBoxLockSendMsg.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockInObModeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockInObModeAction := CheckBoxLockInObMode.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditErrorPasswordCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxErrorCountKickClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPasswordErrorCountLock := EditErrorPasswordCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonPasswordLockSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'PasswordLockSystem', g_Config.boPasswordLockSystem);
  Config.WriteBool('Setup', 'PasswordLockDealAction', g_Config.boLockDealAction);
  Config.WriteBool('Setup', 'PasswordLockDropAction', g_Config.boLockDropAction);
  Config.WriteBool('Setup', 'PasswordLockGetBackItemAction', g_Config.boLockGetBackItemAction);
  Config.WriteBool('Setup', 'PasswordLockWalkAction', g_Config.boLockWalkAction);
  Config.WriteBool('Setup', 'PasswordLockRunAction', g_Config.boLockRunAction);
  Config.WriteBool('Setup', 'PasswordLockHitAction', g_Config.boLockHitAction);
  Config.WriteBool('Setup', 'PasswordLockSpellAction', g_Config.boLockSpellAction);
  Config.WriteBool('Setup', 'PasswordLockCallHeroAction', g_Config.boLockCallHeroAction);//是否锁定召唤英雄操作  20080529
  Config.WriteBool('Setup', 'PasswordLockSendMsgAction', g_Config.boLockSendMsgAction);
  Config.WriteBool('Setup', 'PasswordLockInObModeAction', g_Config.boLockInObModeAction);
  Config.WriteBool('Setup', 'PasswordLockUserItemAction', g_Config.boLockUserItemAction);

  Config.WriteBool('Setup', 'PasswordLockHumanLogin', g_Config.boLockHumanLogin);
  Config.WriteInteger('Setup', 'PasswordErrorCountLock', g_Config.nPasswordErrorCountLock);
{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.RefGeneral();
begin
  SpinEditNPCNameColor.Value := g_Config.btNPCNameColor;//NPC名字颜色 20081218
  EditPKFlagNameColor.Value := g_Config.btPKFlagNameColor;
  EditPKLevel1NameColor.Value := g_Config.btPKLevel1NameColor;
  EditPKLevel2NameColor.Value := g_Config.btPKLevel2NameColor;
  EditAllyAndGuildNameColor.Value := g_Config.btAllyAndGuildNameColor;
  EditWarGuildNameColor.Value := g_Config.btWarGuildNameColor;
  EditInFreePKAreaNameColor.Value := g_Config.btInFreePKAreaNameColor;
  {$IF M2Version <> 2}
  SpinEditStartHPRock.Value := g_Config.nStartHPRock;
  SpinEditStartMPRock.Value := g_Config.nStartMPRock;
  SpinEditStartHPMPRock.Value := g_Config.nStartHPMPRock;
  SpinEditStartHPMPRock1.Value := g_Config.nStartHPMPRock1;
  SpinEditHPRockSpell.Value := g_Config.nHPRockSpell;
  SpinEditMPRockSpell.Value := g_Config.nMPRockSpell;
  SpinEditHPMPRockSpell.Value := g_Config.nHPMPRockSpell;
  SpinEditHPMPRockSpell1.Value := g_Config.nHPMPRockSpell1;
  SpinEditRockAddHP.Value := g_Config.nRockAddHP;
  SpinEditRockAddMP.Value := g_Config.nRockAddMP;
  SpinEditRockAddHPMP.Value := g_Config.nRockAddHPMP;
  SpinEditRockAddHPMP1.Value := g_Config.nRockAddHPMP1;
  SpinEditHPRockDecDura.Value := g_Config.nHPRockDecDura;
  SpinEditMPRockDecDura.Value := g_Config.nMPRockDecDura;
  SpinEditHPMPRockDecDura.Value := g_Config.nHPMPRockDecDura;
  SpinEditHPMPRockDecDura1.Value := g_Config.nHPMPRockDecDura1;
  {$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxHungerSystemClick(Sender: TObject);
begin
  if CheckBoxHungerSystem.Checked then begin
    CheckBoxHungerDecHP.Enabled := True;
    CheckBoxHungerDecPower.Enabled := True;
  end else begin
    CheckBoxHungerDecHP.Checked := False;
    CheckBoxHungerDecPower.Checked := False;
    CheckBoxHungerDecHP.Enabled := False;
    CheckBoxHungerDecPower.Enabled := False;
  end;

  if not boOpened then Exit;
  g_Config.boHungerSystem := CheckBoxHungerSystem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxHungerDecHPClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHungerDecHP := CheckBoxHungerDecHP.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxHungerDecPowerClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHungerDecPower := CheckBoxHungerDecPower.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonGeneralSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'HungerSystem', g_Config.boHungerSystem);
  Config.WriteBool('Setup', 'HungerDecHP', g_Config.boHungerDecHP);
  Config.WriteBool('Setup', 'HungerDecPower', g_Config.boHungerDecPower);
  Config.WriteInteger('Setup', 'ChallengeTime', g_Config.nChallengeTime);//挑战时间 20080706

  Config.WriteInteger('Setup', 'NPCNameColor', g_Config.btNPCNameColor);//NPC名字颜色 20081218
  Config.WriteInteger('Setup', 'PKFlagNameColor', g_Config.btPKFlagNameColor);
  Config.WriteInteger('Setup', 'AllyAndGuildNameColor', g_Config.btAllyAndGuildNameColor);
  Config.WriteInteger('Setup', 'WarGuildNameColor', g_Config.btWarGuildNameColor);
  Config.WriteInteger('Setup', 'InFreePKAreaNameColor', g_Config.btInFreePKAreaNameColor);
  Config.WriteInteger('Setup', 'PKLevel1NameColor', g_Config.btPKLevel1NameColor);
  Config.WriteInteger('Setup', 'PKLevel2NameColor', g_Config.btPKLevel2NameColor);
  Config.WriteBool('Setup', 'StartMapEvent', g_Config.boStartMapEvent);
  Config.WriteBool('Setup', 'ShowGuildName', g_Config.boShowGuildName);//人物名是否显示行会信息 20080726
  {$IF M2Version <> 2}
  Config.WriteInteger('Setup', 'StartHPRock', g_Config.nStartHPRock);
  Config.WriteInteger('Setup', 'StartMPRock', g_Config.nStartMPRock);
  Config.WriteInteger('Setup', 'StartHPMPRock', g_Config.nStartHPMPRock);
  Config.WriteInteger('Setup', 'StartHPMPRock1', g_Config.nStartHPMPRock1);
  Config.WriteInteger('Setup', 'HPRockSpell', g_Config.nHPRockSpell);
  Config.WriteInteger('Setup', 'MPRockSpell', g_Config.nMPRockSpell);
  Config.WriteInteger('Setup', 'HPMPRockSpell', g_Config.nHPMPRockSpell);
  Config.WriteInteger('Setup', 'HPMPRockSpell1', g_Config.nHPMPRockSpell1);
  Config.WriteInteger('Setup', 'RockAddHP', g_Config.nRockAddHP);
  Config.WriteInteger('Setup', 'RockAddMP', g_Config.nRockAddMP);
  Config.WriteInteger('Setup', 'RockAddHPMP', g_Config.nRockAddHPMP);
  Config.WriteInteger('Setup', 'RockAddHPMP1', g_Config.nRockAddHPMP1);
  Config.WriteInteger('Setup', 'HPRockDecDura', g_Config.nHPRockDecDura);
  Config.WriteInteger('Setup', 'MPRockDecDura', g_Config.nMPRockDecDura);
  Config.WriteInteger('Setup', 'HPMPRockDecDura', g_Config.nHPMPRockDecDura);
  Config.WriteInteger('Setup', 'HPMPRockDecDura1', g_Config.nHPMPRockDecDura1);
  Config.WriteBool('Setup', 'UseFengHaoAbil', g_Config.boUseFengHaoAbil);
  {$IFEND}
  Config.WriteBool('Setup', 'ClearGamePoint', g_Config.boClearGamePoint);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonJewelSaveClick(Sender: TObject);
begin
{$IF M2Version <> 2}
  Config.WriteInteger('Setup', 'FindJewelRave', g_Config.nFindJewelRave);//使用灵媒探索宝物成功率
  Config.WriteInteger('Setup', 'DigJewelHitRate', g_Config.nDigJewelHitRate);//挖宝命中机率
  Config.WriteInteger('Setup', 'GetDigJewelRave', g_Config.nGetDigJewelRave);//得宝机率
  Config.WriteInteger('Setup', 'DecDigJewelDuraRate', g_Config.nDecDigJewelDuraRate);
  uModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMagicAttackPassRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagicAttackPassRage := EditMagicAttackPassRage.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagicAttackRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagicAttackRage := EditMagicAttackRage.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.RefMagicSkill;
begin
  EditSwordLongPowerRate.Value := g_Config.nSwordLongPowerRate;
  CheckBoxLimitSwordLong.Checked := g_Config.boLimitSwordLong;
  {$IF M2Version <> 2}
  CheckBoxLimitSwordLongNG.Checked := g_Config.boLimitSwordLongNG;
  {$IFEND}
  EditFireBoomRage.Value := g_Config.nFireBoomRage;
  EditSnowWindRange.Value := g_Config.nSnowWindRange;
  EditMeteorFireRainRage.Value := g_Config.nMeteorFireRainRage;//流星火雨攻击范围 20080510
  EditMagFireCharmTreatment.Value := g_Config.nMagFireCharmTreatment;//噬血术加血百分率 20080511
  EditElecBlizzardRange.Value := g_Config.nElecBlizzardRange;
  EditMagicAttackRage.Value := g_Config.nMagicAttackRage;
  EditMagicAttackPassRage.Value := g_Config.nMagicAttackPassRage;
  CheckBoxMagicLockTag.Checked := g_Config.boMagLock;
  EditAmyOunsulPoint.Value := g_Config.nAmyOunsulPoint;
  EditMaxMakePosionTime.Value := g_Config.nMaxMakePosionTime;
  EditMagTurnUndeadLevel.Value := g_Config.nMagTurnUndeadLevel;
  EditMagTammingLevel.Value := g_Config.nMagTammingLevel;
  EditMagTammingTargetLevel.Value := g_Config.nMagTammingTargetLevel;
  EditMagTammingHPRate.Value := g_Config.nMagTammingHPRate;
  EditTammingCount.Value := g_Config.nMagTammingCount;
  CheckBoxMagTammingHitNew.Checked := g_Config.boMagTammingHitNew;
  EditMabMabeHitRandRate.Value := g_Config.nMabMabeHitRandRate;
  EditMabMabeHitMinLvLimit.Value := g_Config.nMabMabeHitMinLvLimit;
  EditMabMabeHitSucessRate.Value := g_Config.nMabMabeHitSucessRate;
  EditMabMabeHitMabeTimeRate.Value := g_Config.nMabMabeHitMabeTimeRate;
  CheckBoxFireCrossInSafeZone.Checked := g_Config.boDisableInSafeZoneFireCross;
  CheckBoxGroupMbAttackPlayObject.Checked := g_Config.boGroupMbAttackPlayObject;
  CheckBoxGroupMbAttackPlayMon.Checked := g_Config.boGroupMbAttackPlayMon;//狮子吼是否对人形有效 20090413
{$IF M2Version = 1}
  EditSkill95EffectPowerWarror.Value := g_Config.nSkill95EffectPowerWarror;
  EditSkill95EffectRateWarror.Value := g_Config.nSkill95EffectRateWarror;
  EditSkill95DecInjuryWarror.Value := g_Config.nSkill95DecInjuryWarror;

  Skill95EffectPowerWizard.Value := g_Config.nSkill95EffectPowerWizard;
  Skill95EffectRateWizard.Value := g_Config.nSkill95EffectRateWizard;
  Skill95DecInjuryWizard.Value := g_Config.nSkill95DecInjuryWizard;

  Skill95EffectPowerTaoist.Value := g_Config.nSkill95EffectPowerTaoist;
  Skill95EffectRateTaoist.Value := g_Config.nSkill95EffectRateTaoist;
  Skill95DecInjuryTaoist.Value := g_Config.nSkill95DecInjuryTaoist;
  Skill95LevelDecInjury.Value := g_Config.nSkill95LevelDecInjury;

  EditJingYuanValue.Value := g_Config.nJingYuanValue;
  SpinEditIncJingYuanValueTime.Value := g_Config.nIncJingYuanValueTime;
  EditIncTransferValue.Value := g_Config.nIncTransferValueTime;
  LianqiGold.Value := g_Config.nLianqiGold;
  LianqiGameGird.Value := g_Config.nLianqiGameGird;
  SpinEditAutoExpSkill95.Value := g_Config.nAutoExpSkill95;
{$IFEND}
  EditDoCallTroll.Value:= g_Config.dwDoCallTrollTick;
  EditDoCallTrollTime.Value:= g_Config.dwDoCallTrollTime;
  SpinEditExplosion_97Range.Value := g_Config.nExplosion_97Range;//血魄一击(法)范围
  SpinEditExplosion_98Range.Value := g_Config.nExplosion_98Range;//血魄一击(道)范围
  EditUseBloodSoul.Value := g_Config.dwUseBloodSoulTick div 1000;//使用血魄一击间隔
  EditBloodSoulRate.Value := g_Config.dwBloodSoulRate;//血魄一击暴击机率
  EditBloodSoulHitRate.Value := g_Config.nBloodSoulHitRate;//血魄一击暴击倍数
  EditNotGNDecHPRate.Value := g_Config.dwNotGNDecHPRate;//无内力值减血比例
  CheckBoxAttackFFT_96.Checked := g_Config.boUseNewAttackFFT_96;//是否使用新算法计算血魄技能威力 20100704
//------------------------------------------------------------------------------
  SpinEditBatterDecDamageRate.Value := g_Config.dwBatterDecDamageRate;//道法固定的吸伤比例 20090808
  SpinEditBatterRandDecDamageRate.Value := g_Config.dwBatterRandDecDamageRate;//道法随机的吸伤比例 20090808
  EditUseBatterTick.Value := g_Config.dwUseBatterTick div 1000;//使用连击间隔 20090618
  EditStormsHitRate1.Value := g_Config.nStormsHitRate[1];//暴击伤害倍数  20090618
  EditStormsHitRate2.Value := g_Config.nStormsHitRate[2];//暴击伤害倍数  20090618
  EditStormsHitRate3.Value := g_Config.nStormsHitRate[3];//暴击伤害倍数  20090618
  EditStormsHitRate4.Value := g_Config.nStormsHitRate[4];//暴击伤害倍数  20090618
  EditStormsHitRate5.Value := g_Config.nStormsHitRate[5];//暴击伤害倍数  20090618
//暴击率 20090619
  EditStormsHitAppearRate1.Value := g_Config.nStormsHitAppearRate[0];
  EditStormsHitAppearRate2.Value := g_Config.nStormsHitAppearRate[1];
  EditStormsHitAppearRate3.Value := g_Config.nStormsHitAppearRate[2];
  EditStormsHitAppearRate4.Value := g_Config.nStormsHitAppearRate[3];
  EditStormsHitAppearRate5.Value := g_Config.nStormsHitAppearRate[4];

  EditSkillFireRange_82.Value := g_Config.nBatterSkillFireRange_82;//断岳斩攻击范围 20090706
  EditSkillFireRange_85.Value := g_Config.nBatterSkillFireRange_85;//横扫千军攻击范围 20090704
  EditSkillFireRange_86.Value := g_Config.nBatterSkillFireRange_86;//冰天雪地攻击范围 20090626
  EditBatterSkillPoinson_86.Value := g_Config.nBatterSkillPoinson_86;//冰天雪地持续掉血点数 20090727
  EditSkillFireRange_87.Value := g_Config.nBatterSkillFireRange_87;//万剑归宗攻击范围 20090626
  EditBatterSkillPoinson_87.Value := g_Config.nBatterSkillPoinson_87;//万剑归宗持续掉血点数 20090727
  EditPoisonLength_87.Value := g_Config.nPoisonLength_87;

  SpinEditMagChangXY.Value := g_Config.dwMagChangXYTick div 1000;//移行换位使用间隔 20080616
//护体神盾 20080108
  EditProtectionRate.Value := g_Config.nProtectionRate;
  EditProtectionOKRate.Value := g_Config.nProtectionOKRate;//护体神盾生效机率 20080929
  CheckBoxUseNGItemIncExp.Checked:=g_Config.boUseNGItemIncExp;

  AutoCanHit.Checked := g_Config.boAutoCanHit;//智能锁定 20080418
  AutoCanHit59.Checked := g_Config.boAutoCanHit59;//噬血术智能锁定 20090521
  AutoCanHit45.Checked := g_Config.boAutoCanHit45;
  CheckSlaveMoveMaster.Checked := g_Config.boSlaveMoveMaster;//宝宝是否飞到主人身边 20080713
//------------------------------------------------------------------------------
  {$IF M2Version <> 2}
  SpinEditMemberUseHeartTime.Value := g_Config.nMemberUseHeartTime;
  SpinEditActivMemberHeartRate.Value := g_Config.nActivMemberHeartRate;
  SpinEditHeartArrValueRate.Value := g_Config.nHeartArrValueRate;
  SpinEditHeartIncDamageRate.Value := g_Config.nHeartIncDamageRate;
  SpinEditDivisionSavvyRate.Value := g_Config.nDivisionSavvyRate;
  SpinEditPublicHeartLevel.Value := g_Config.nPublicHeartLevel;
  SpinEditSavvyHeartNeedLevel.Value := g_Config.nSavvyHeartNeedLevel;
  SpinEditActivHeartNH.Value := g_Config.nActivHeartNH;
  SpinEditIncHeartPointNeedExp.Value := g_Config.nIncHeartPointNeedExp;
  CheckBoxNeedHeart.Checked := g_Config.boHeratPowerNeed;
  CheckBoxNeedHeart2.Checked := g_Config.boHeratPowerNeed2;
  SpinEditKill69Sec.Value := g_Config.nKill69UseTime;//倚天辟地使用间隔
  SpinEditKill102Sec.Value := g_Config.nKill102UseTime;//唯我独尊使用间隔
  EditSill102TargetDecACTime.Value := g_Config.nSill102TargetDecACTime;
  EditSkill101Point.Value := g_Config.nSkill101Point;
  SpinEditKill101UseTime.Value := g_Config.nKill101UseTime;
  SpinEditKill101UseLogTime.Value := g_Config.nKill101UseLogTime;
  SpinEditHeartSkilltime.Value := g_Config.nHeartSkilltime;
  SpinEditMagicAttackRage_107.Value := g_Config.nMagicAttackRage_107;
  CheckBoxMag113LockCanFly.Checked := g_Config.boMag113LockCanFly;
  {$IFEND}
  SpinEditKill42Sec.Value := g_Config.nKill42UseTime;//龙影剑法使用间隔 20080619
  SpinEditAttackRate_42.Value := g_Config.nAttackRate_42;//龙影剑法威力 20080213
  EditMagicAttackRage_42.Value := g_Config.nMagicAttackRage_42;//龙影剑法范围 20080218
//------------------------------------------------------------------------------
end;

procedure TfrmFunctionConfig.EditBoneFammCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBoneFammCount := EditBoneFammCount.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.EditDoCallTrollChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwDoCallTrollTick := EditDoCallTroll.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDoCallTrollTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwDoCallTrollTime := EditDoCallTrollTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDogzCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDogzCount := EditDogzCount.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.CheckBoxLimitSwordLongClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLimitSwordLong := CheckBoxLimitSwordLong.Checked;
  ModValue();
end;
procedure TfrmFunctionConfig.CheckBoxLimitSwordLongNGClick(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.boLimitSwordLongNG := CheckBoxLimitSwordLongNG.Checked;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditSwordLongPowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSwordLongPowerRate := EditSwordLongPowerRate.Value;
  ModValue()
end;
procedure TfrmFunctionConfig.EditBoneFammNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;
procedure TfrmFunctionConfig.EditBraceletDCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletDCAddRate := EditBraceletDCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletDCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletDCAddValueMaxLimit := EditBraceletDCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletDCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletDCAddValueRate := EditBraceletDCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletHJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletHJAddRate := EditBraceletHJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletHJAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletHJAddValueMaxLimit := EditBraceletHJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletHJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletHJAddValueRate := EditBraceletHJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMainAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMainAddRate := EditBraceletMainAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMainAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMainAddValueMaxLimit := EditBraceletMainAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMainAddValueRateChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMainAddValueRate := EditBraceletMainAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMCAddRate := EditBraceletMCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMCAddValueMaxLimit := EditBraceletMCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMCAddValueRate := EditBraceletMCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMFAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMFAddRate := EditBraceletMFAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMFAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMFAddValueMaxLimit := EditBraceletMFAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletMFAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletMFAddValueRate := EditBraceletMFAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletNLAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletNLAddRate := EditBraceletNLAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletNLAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletNLAddValueMaxLimit := EditBraceletNLAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletNLAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletNLAddValueRate := EditBraceletNLAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletQSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletQSAddRate := EditBraceletQSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletQSAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletQSAddValueMaxLimit := EditBraceletQSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletQSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletQSAddValueRate := EditBraceletQSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletSCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletSCAddRate := EditBraceletSCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletSCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletSCAddValueMaxLimit := EditBraceletSCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletSCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletSCAddValueRate := EditBraceletSCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletXXAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletXXAddRate := EditBraceletXXAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletXXAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletXXAddValueMaxLimit := EditBraceletXXAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditBraceletXXAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nBraceletXXAddValueRate := EditBraceletXXAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDogzNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;
procedure TfrmFunctionConfig.EditDressBJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreBJAddRate := EditDressBJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressBJAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreBJAddValueMaxLimit := EditDressBJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressBJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreBJAddValueRate := EditDressBJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressDCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreDCAddRate := EditDressDCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressDCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreDCAddValueMaxLimit := EditDressDCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressDCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreDCAddValueRate := EditDressDCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressHJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreHJAddRate := EditDressHJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressHJAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreHJAddValueMaxLimit := EditDressHJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressHJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreHJAddValueRate := EditDressHJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressJMAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreJMAddRate := EditDressJMAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressJMAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreJMAddValueMaxLimit := EditDressJMAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressJMAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreJMAddValueRate := EditDressJMAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMainAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMainAddRate := EditDressMainAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMainAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMainAddValueMaxLimit := EditDressMainAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMainAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMainAddValueRate := EditDressMainAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMBAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMBAddRate := EditDressMBAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMBAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMBAddValueMaxLimit := EditDressMBAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMBAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMBAddValueRate := EditDressMBAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMCAddRate := EditDressMCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMCAddValueMaxLimit := EditDressMCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressMCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreMCAddValueRate := EditDressMCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressNLAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreNLAddRate := EditDressNLAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressNLAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreNLAddValueMaxLimit := EditDressNLAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressNLAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreNLAddValueRate := EditDressNLAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressQSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreQSAddRate := EditDressQSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressQSAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreQSAddValueMaxLimit := EditDressQSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressQSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreQSAddValueRate := EditDressQSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressSCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreSCAddRate := EditDressSCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressSCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreSCAddValueMaxLimit := EditDressSCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressSCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreSCAddValueRate := EditDressSCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressWFAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreWFAddRate := EditDressWFAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressWFAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreWFAddValueMaxLimit := EditDressWFAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressWFAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreWFAddValueRate := EditDressWFAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressXXAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreXXAddRate := EditDressXXAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressXXAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreXXAddValueMaxLimit := EditDressXXAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDressXXAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDreXXAddValueRate := EditDressXXAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditFindJewelRaveChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nFindJewelRave := EditFindJewelRave.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditFireBoomRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireBoomRage := EditFireBoomRage.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.EditSnowWindRangeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSnowWindRange := EditSnowWindRange.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditElecBlizzardRangeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nElecBlizzardRange := EditElecBlizzardRange.Value;//地狱雷光攻击范围
  ModValue();
end;

procedure TfrmFunctionConfig.EditEnergyValueTimeChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nEnergyValueTime := EditEnergyValueTime.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMagTurnUndeadLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTurnUndeadLevel := EditMagTurnUndeadLevel.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.EditMakeScroll1RateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMakeScrollRate[1] := EditMakeScroll1Rate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMakeScroll2RateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMakeScrollRate[2] := EditMakeScroll2Rate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMakeScroll3RateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMakeScrollRate[3] := EditMakeScroll3Rate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMakeScroll4RateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMakeScrollRate[4] := EditMakeScroll4Rate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.GridBoneFammSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  if not boOpened then Exit;
  ModValue();
end;
procedure TfrmFunctionConfig.EditAmyOunsulPointChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAmyOunsulPoint := EditAmyOunsulPoint.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxFireChgMapExtinguishClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boChangeMapFireExtinguish := CheckBoxFireChgMapExtinguish.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxFireCrossInSafeZoneClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDisableInSafeZoneFireCross := CheckBoxFireCrossInSafeZone.Checked;
  ModValue();
end;


procedure TfrmFunctionConfig.CheckBoxFireFairyNeglectACMACClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boFireFairyNeglectACMAC := CheckBoxFireFairyNeglectACMAC.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxFireFairyShareMasterMPClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boFireFairyShareMasterMP := CheckBoxFireFairyShareMasterMP.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxGroupMbAttackPlayObjectClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boGroupMbAttackPlayObject := CheckBoxGroupMbAttackPlayObject.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSkillSaveClick(Sender: TObject);
var
  I: Integer;
  RecallArray: array[0..9] of TRecallMigic;
  Rect: TGridRect;
  dwExp: LongWord;
  NeedExps: TLevelNeedExp2;
  NeedExps1: TLevelNeedExp4;
  nCode: byte;
begin
  try
    FillChar(RecallArray, SizeOf(RecallArray), #0);
    nCode:= 1;
    g_Config.sBoneFamm := Trim(EditBoneFammName.Text);

    for I := Low(RecallArray) to High(RecallArray) do begin
      RecallArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
      RecallArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
      RecallArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
      RecallArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);
      if GridBoneFamm.Cells[0, I + 1] = '' then Break;
      if (RecallArray[I].nHumLevel <= 0) then begin
        Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 0;
        Rect.Top := I + 1;
        Rect.Right := 0;
        Rect.Bottom := I + 1;
        GridBoneFamm.Selection := Rect;
        Exit;
      end;
      if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
        Application.MessageBox('骷髅怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 1;
        Rect.Top := I + 1;
        Rect.Right := 1;
        Rect.Bottom := I + 1;
        GridBoneFamm.Selection := Rect;
        Exit;
      end;
      if RecallArray[I].nCount <= 0 then begin
        Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 2;
        Rect.Top := I + 1;
        Rect.Right := 2;
        Rect.Bottom := I + 1;
        GridBoneFamm.Selection := Rect;
        Exit;
      end;
      if RecallArray[I].nLevel < 0 then begin
        Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 3;
        Rect.Top := I + 1;
        Rect.Right := 3;
        Rect.Bottom := I + 1;
        GridBoneFamm.Selection := Rect;
        Exit;
      end;
    end;
    nCode:= 2;
    for I := Low(RecallArray) to High(RecallArray) do begin
      RecallArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
      RecallArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
      RecallArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
      RecallArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);
      if GridDogz.Cells[0, I + 1] = '' then Break;
      if (RecallArray[I].nHumLevel <= 0) then begin
        Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 0;
        Rect.Top := I + 1;
        Rect.Right := 0;
        Rect.Bottom := I + 1;
        GridDogz.Selection := Rect;
        Exit;
      end;
      if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
        Application.MessageBox('神兽怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 1;
        Rect.Top := I + 1;
        Rect.Right := 1;
        Rect.Bottom := I + 1;
        GridDogz.Selection := Rect;
        Exit;
      end;
      if RecallArray[I].nCount <= 0 then begin
        Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 2;
        Rect.Top := I + 1;
        Rect.Right := 2;
        Rect.Bottom := I + 1;
        GridDogz.Selection := Rect;
        Exit;
      end;
      if RecallArray[I].nLevel < 0 then begin
        Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 3;
        Rect.Top := I + 1;
        Rect.Right := 3;
        Rect.Bottom := I + 1;
        GridDogz.Selection := Rect;
        Exit;
      end;
    end;
    nCode:= 3;
    //圣兽
    for I := Low(RecallArray) to High(RecallArray) do begin
      RecallArray[I].nHumLevel := Str_ToInt(GridSacred.Cells[0, I + 1], -1);
      RecallArray[I].sMonName := Trim(GridSacred.Cells[1, I + 1]);
      RecallArray[I].nCount := Str_ToInt(GridSacred.Cells[2, I + 1], -1);
      RecallArray[I].nLevel := Str_ToInt(GridSacred.Cells[3, I + 1], -1);
      if GridSacred.Cells[0, I + 1] = '' then Break;
      if (RecallArray[I].nHumLevel <= 0) then begin
        Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 0;
        Rect.Top := I + 1;
        Rect.Right := 0;
        Rect.Bottom := I + 1;
        GridSacred.Selection := Rect;
        Exit;
      end;
      if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
        Application.MessageBox('神兽怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 1;
        Rect.Top := I + 1;
        Rect.Right := 1;
        Rect.Bottom := I + 1;
        GridSacred.Selection := Rect;
        Exit;
      end;
      if RecallArray[I].nCount <= 0 then begin
        Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 2;
        Rect.Top := I + 1;
        Rect.Right := 2;
        Rect.Bottom := I + 1;
        GridSacred.Selection := Rect;
        Exit;
      end;
      if RecallArray[I].nLevel < 0 then begin
        Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 3;
        Rect.Top := I + 1;
        Rect.Right := 3;
        Rect.Bottom := I + 1;
        GridSacred.Selection := Rect;
        Exit;
      end;
    end;
    nCode:= 4;
    //月灵
    for I := Low(RecallArray) to High(RecallArray) do begin
      RecallArray[I].nHumLevel := Str_ToInt(GridFairy.Cells[0, I + 1], -1);
      RecallArray[I].sMonName := Trim(GridFairy.Cells[1, I + 1]);
      RecallArray[I].nCount := Str_ToInt(GridFairy.Cells[2, I + 1], -1);
      RecallArray[I].nLevel := Str_ToInt(GridFairy.Cells[3, I + 1], -1);
      if GridFairy.Cells[0, I + 1] = '' then Break;
      if (RecallArray[I].nHumLevel <= 0) then begin
        Application.MessageBox('人物等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 0;
        Rect.Top := I + 1;
        Rect.Right := 0;
        Rect.Bottom := I + 1;
        GridFairy.Selection := Rect;
        Exit;
      end;
      if UserEngine.GetMonRace(RecallArray[I].sMonName) <= 0 then begin
        Application.MessageBox('月灵怪物名称设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 1;
        Rect.Top := I + 1;
        Rect.Right := 1;
        Rect.Bottom := I + 1;
        GridFairy.Selection := Rect;
        Exit;
      end;
      if RecallArray[I].nCount <= 0 then begin
        Application.MessageBox('召唤数量设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 2;
        Rect.Top := I + 1;
        Rect.Right := 2;
        Rect.Bottom := I + 1;
        GridFairy.Selection := Rect;
        Exit;
      end;
      if RecallArray[I].nLevel < 0 then begin
        Application.MessageBox('召唤等级设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
        Rect.Left := 3;
        Rect.Top := I + 1;
        Rect.Right := 3;
        Rect.Bottom := I + 1;
        GridFairy.Selection := Rect;
        Exit;
      end;
    end;
    nCode:= 5;
    FillChar(g_Config.BoneFammArray, SizeOf(g_Config.BoneFammArray), #0);
    for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
      Config.WriteInteger('Setup', 'BoneFammHumLevel' + IntToStr(I), 0);
      Config.WriteString('Names', 'BoneFamm' + IntToStr(I), '');
      Config.WriteInteger('Setup', 'BoneFammCount' + IntToStr(I), 0);
      Config.WriteInteger('Setup', 'BoneFammLevel' + IntToStr(I), 0);
    end;
    nCode:= 6;
    for I := Low(g_Config.BoneFammArray) to High(g_Config.BoneFammArray) do begin
      if GridBoneFamm.Cells[0, I + 1] = '' then Break;
      g_Config.BoneFammArray[I].nHumLevel := Str_ToInt(GridBoneFamm.Cells[0, I + 1], -1);
      g_Config.BoneFammArray[I].sMonName := Trim(GridBoneFamm.Cells[1, I + 1]);
      g_Config.BoneFammArray[I].nCount := Str_ToInt(GridBoneFamm.Cells[2, I + 1], -1);
      g_Config.BoneFammArray[I].nLevel := Str_ToInt(GridBoneFamm.Cells[3, I + 1], -1);

      Config.WriteInteger('Setup', 'BoneFammHumLevel' + IntToStr(I), g_Config.BoneFammArray[I].nHumLevel);
      Config.WriteString('Names', 'BoneFamm' + IntToStr(I), g_Config.BoneFammArray[I].sMonName);
      Config.WriteInteger('Setup', 'BoneFammCount' + IntToStr(I), g_Config.BoneFammArray[I].nCount);
      Config.WriteInteger('Setup', 'BoneFammLevel' + IntToStr(I), g_Config.BoneFammArray[I].nLevel);
    end;
    nCode:= 7;
    FillChar(g_Config.DogzArray, SizeOf(g_Config.DogzArray), #0);
    for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
      Config.WriteInteger('Setup', 'DogzHumLevel' + IntToStr(I), 0);
      Config.WriteString('Names', 'Dogz' + IntToStr(I), '');
      Config.WriteInteger('Setup', 'DogzCount' + IntToStr(I), 0);
      Config.WriteInteger('Setup', 'DogzLevel' + IntToStr(I), 0);
    end;
    nCode:= 8;
    for I := Low(g_Config.DogzArray) to High(g_Config.DogzArray) do begin
      if GridDogz.Cells[0, I + 1] = '' then Break;

      g_Config.DogzArray[I].nHumLevel := Str_ToInt(GridDogz.Cells[0, I + 1], -1);
      g_Config.DogzArray[I].sMonName := Trim(GridDogz.Cells[1, I + 1]);
      g_Config.DogzArray[I].nCount := Str_ToInt(GridDogz.Cells[2, I + 1], -1);
      g_Config.DogzArray[I].nLevel := Str_ToInt(GridDogz.Cells[3, I + 1], -1);

      Config.WriteInteger('Setup', 'DogzHumLevel' + IntToStr(I), g_Config.DogzArray[I].nHumLevel);
      Config.WriteString('Names', 'Dogz' + IntToStr(I), g_Config.DogzArray[I].sMonName);
      Config.WriteInteger('Setup', 'DogzCount' + IntToStr(I), g_Config.DogzArray[I].nCount);
      Config.WriteInteger('Setup', 'DogzLevel' + IntToStr(I), g_Config.DogzArray[I].nLevel);
    end;
    nCode:= 9;
    //圣兽
    for I := Low(g_Config.SacredArray) to High(g_Config.SacredArray) do begin
      if GridSacred.Cells[0, I + 1] = '' then Break;
      g_Config.SacredArray[I].nHumLevel := Str_ToInt(GridSacred.Cells[0, I + 1], -1);
      g_Config.SacredArray[I].sMonName := Trim(GridSacred.Cells[1, I + 1]);
      g_Config.SacredArray[I].nCount := Str_ToInt(GridSacred.Cells[2, I + 1], -1);
      g_Config.SacredArray[I].nLevel := Str_ToInt(GridSacred.Cells[3, I + 1], -1);
      Config.WriteInteger('Setup', 'SacredHumLevel' + IntToStr(I), g_Config.SacredArray[I].nHumLevel);
      Config.WriteString('Names', 'Sacred' + IntToStr(I), g_Config.SacredArray[I].sMonName);
      Config.WriteInteger('Setup', 'SacredCount' + IntToStr(I), g_Config.SacredArray[I].nCount);
      Config.WriteInteger('Setup', 'SacredLevel' + IntToStr(I), g_Config.SacredArray[I].nLevel);
    end;
    nCode:= 10;
    //月灵
    FillChar(g_Config.FairyArray, SizeOf(g_Config.FairyArray), #0);
    for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do begin
      Config.WriteInteger('Setup', 'FairyHumLevel' + IntToStr(I), 0);
      Config.WriteString('Names', 'Fairy' + IntToStr(I), '');
      Config.WriteInteger('Setup', 'FairyCount' + IntToStr(I), 0);
      Config.WriteInteger('Setup', 'Fairyevel' + IntToStr(I), 0);
    end;
    nCode:= 11;
    for I := Low(g_Config.FairyArray) to High(g_Config.FairyArray) do begin
      if GridFairy.Cells[0, I + 1] = '' then Break;

      g_Config.FairyArray[I].nHumLevel := Str_ToInt(GridFairy.Cells[0, I + 1], -1);
      g_Config.FairyArray[I].sMonName := Trim(GridFairy.Cells[1, I + 1]);
      g_Config.FairyArray[I].nCount := Str_ToInt(GridFairy.Cells[2, I + 1], -1);
      g_Config.FairyArray[I].nLevel := Str_ToInt(GridFairy.Cells[3, I + 1], -1);

      Config.WriteInteger('Setup', 'FairyHumLevel' + IntToStr(I), g_Config.FairyArray[I].nHumLevel);
      Config.WriteString('Names', 'Fairy' + IntToStr(I), g_Config.FairyArray[I].sMonName);
      Config.WriteInteger('Setup', 'FairyCount' + IntToStr(I), g_Config.FairyArray[I].nCount);
      Config.WriteInteger('Setup', 'FairyLevel' + IntToStr(I), g_Config.FairyArray[I].nLevel);
    end;
    nCode:= 12;
  {$IF SoftVersion <> VERDEMO}
    Config.WriteBool('Setup', 'LimitSwordLong', g_Config.boLimitSwordLong);
    {$IF M2Version <> 2}
    Config.WriteBool('Setup', 'LimitSwordLongNG', g_Config.boLimitSwordLongNG);
    {$IFEND}
    Config.WriteInteger('Setup', 'SwordLongPowerRate', g_Config.nSwordLongPowerRate);
    Config.WriteInteger('Setup', 'BoneFammCount', g_Config.nBoneFammCount);
    Config.WriteString('Names', 'BoneFamm', g_Config.sBoneFamm);
    Config.WriteInteger('Setup', 'DogzCount', g_Config.nDogzCount);
    Config.WriteString('Names', 'Dogz', g_Config.sDogz);
    //圣兽
    Config.WriteInteger('Setup', 'SacredCount', g_Config.nSacredCount);
    Config.WriteString('Names', 'Sacred', g_Config.sSacredName);
    //火灵
    Config.WriteString('Names', 'FireFairy', g_Config.sFireFairy);
    Config.WriteInteger('Setup', 'FireFairyCount', g_Config.nFireFairyCount);
    Config.WriteInteger('Setup', 'FireFairyDuntRate', g_Config.nFireFairyDuntRate);
    Config.WriteInteger('Setup', 'FireFairyDuntRateBelow', g_Config.nFireFairyDuntRateBelow);
    Config.WriteInteger('Setup', 'FireFairyAttackRate', g_Config.nFireFairyAttackRate);
    Config.WriteBool('Setup', 'FireFairyShareMasterMP', g_Config.boFireFairyShareMasterMP);
    Config.WriteBool('Setup', 'FireFairyNeglectACMAC', g_Config.boFireFairyNeglectACMAC);
    //月灵
    Config.WriteInteger('Setup', 'FairyAttackRate', g_Config.nFairyAttackRate);//20080520
    Config.WriteInteger('Setup', 'FairyCount', g_Config.nFairyCount);
    Config.WriteString('Names', 'Fairy', g_Config.sFairy);
    Config.WriteInteger('Setup', 'FairyDuntRate', g_Config.nFairyDuntRate);
    Config.WriteInteger('Setup', 'FairyDuntRateBelow', g_Config.nFairyDuntRateBelow);//月灵重击次数,达到次数时按等级出重击 20090105
    Config.WriteInteger('Setup', '43KillHitRate', g_Config.n43KillHitRate);//开天斩重击几率 20080213
    Config.WriteInteger('Setup', '43KillAttackRate', g_Config.n43KillAttackRate);//开天斩重击倍数  20080213
    Config.WriteInteger('Setup', 'AttackRate_43', g_Config.nAttackRate_43);//开天斩威力  20080213
    Config.WriteInteger('Setup', 'AttackRate_26', g_Config.nAttackRate_26);//烈火剑法威力倍数 20081208
    Config.WriteInteger('Setup', 'AttackRate_74', g_Config.nAttackRate_74);//逐日剑法威力倍数 20080511
    Config.WriteInteger('Setup', 'FireBoomRage', g_Config.nFireBoomRage);
    Config.WriteInteger('Setup', 'SnowWindRange', g_Config.nSnowWindRange);
    Config.WriteInteger('Setup', 'MeteorFireRainRage', g_Config.nMeteorFireRainRage);//流星火雨攻击范围 20080510
    Config.WriteInteger('Setup', 'MagFireCharmTreatment', g_Config.nMagFireCharmTreatment);//噬血术加血百分率 20080511
    Config.WriteInteger('Setup', 'ElecBlizzardRange', g_Config.nElecBlizzardRange);
    Config.WriteInteger('Setup', 'AmyOunsulPoint', g_Config.nAmyOunsulPoint);
    Config.WriteInteger('Setup', 'MaxMakePosionTime', g_Config.nMaxMakePosionTime);
    Config.WriteInteger('Setup', 'MagicAttackRage', g_Config.nMagicAttackRage);
    Config.WriteInteger('Setup', 'MagicAttackPassRage', g_Config.nMagicAttackPassRage);
    Config.WriteInteger('Setup', 'MagTurnUndeadLevel', g_Config.nMagTurnUndeadLevel);
    Config.WriteInteger('Setup', 'MagTammingLevel', g_Config.nMagTammingLevel);
    Config.WriteInteger('Setup', 'MagTammingTargetLevel', g_Config.nMagTammingTargetLevel);
    Config.WriteInteger('Setup', 'MagTammingTargetHPRate', g_Config.nMagTammingHPRate);
    Config.WriteInteger('Setup', 'MagTammingCount', g_Config.nMagTammingCount);
    Config.WriteBool('Setup', 'MagTammingHitNew', g_Config.boMagTammingHitNew);
    nCode:= 13;
    Config.WriteInteger('Setup', 'MabMabeHitRandRate', g_Config.nMabMabeHitRandRate);
    Config.WriteInteger('Setup', 'MabMabeHitMinLvLimit', g_Config.nMabMabeHitMinLvLimit);
    Config.WriteInteger('Setup', 'MabMabeHitSucessRate', g_Config.nMabMabeHitSucessRate);
    Config.WriteInteger('Setup', 'MabMabeHitMabeTimeRate', g_Config.nMabMabeHitMabeTimeRate);

    Config.WriteBool('Setup', 'DisableInSafeZoneFireCross', g_Config.boDisableInSafeZoneFireCross);
    Config.WriteBool('Setup', 'GroupMbAttackPlayObject', g_Config.boGroupMbAttackPlayObject);
    Config.WriteBool('Setup', 'GroupMbAttackPlayMon', g_Config.boGroupMbAttackPlayMon);

    Config.WriteBool('Setup', 'PullPlayObject', g_Config.boPullPlayObject);
    Config.WriteBool('Setup', 'PullCrossInSafeZone', g_Config.boPullCrossInSafeZone);

    Config.WriteBool('Setup', 'GroupMbAttackSlave', g_Config.boGroupMbAttackSlave);
    Config.WriteBool('Setup', 'DamageMP', g_Config.boPlayObjectReduceMP);
    Config.WriteInteger('Setup', 'Magic55UseTime', g_Config.nKill55UseTime);
    Config.WriteInteger('Setup', 'Magic43UseTime', g_Config.nKill43UseTime);//开天斩使用间隔 20080204
    Config.WriteInteger('Setup', 'MagicDedingUseTime', g_Config.nDedingUseTime);
    Config.WriteInteger('Setup', 'AbilityUpTick', g_Config.nAbilityUpTick);//无极真气使用间隔 20080603

    Config.WriteBool('Setup', 'AbilityUpFixMode', g_Config.boAbilityUpFixMode);//无极真气使用时长模式 20081109
    Config.WriteBool('Setup', 'AbilityAddMode', g_Config.boAbilityAddMode);
    Config.WriteBool('Setup', 'DecSuitItemMode', g_Config.boDecSuitItemMode);
    Config.WriteBool('Setup', 'DecMag105SC', g_Config.boDecMag105SC);
    Config.WriteInteger('Setup', 'AbilityUpFixUseTime', g_Config.nAbilityUpFixUseTime);//无极真气使用固定时长 20081109
    Config.WriteInteger('Setup', 'AbilityUpUseTime', g_Config.nAbilityUpUseTime);//无极真气使用时长 20080603
    Config.WriteInteger('Setup', 'MinDrinkValue67', g_Config.nMinDrinkValue67);//先天元力失效酒量下限比例 20080626
    Config.WriteInteger('Setup', 'MinDrinkValue68', g_Config.nMinDrinkValue68);//酒气护体失效酒量下限比例 20080626
    Config.WriteInteger('Setup', 'HPUpTick', g_Config.nHPUpTick);//酒气护体使用间隔 20080625
    Config.WriteInteger('Setup', 'HPUpUseTime', g_Config.nHPUpUseTime);//酒气护体增加使用时长 20080625
    nCode:= 14;
    for I := 1 to GridSkill68.RowCount - 1 do begin
      dwExp := Str_ToInt(GridSkill68.Cells[1, I], 0);
      if (dwExp <= 0) then begin
        Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
        GridSkill68.Row := I;
        GridSkill68.SetFocus;
        Exit;
      end;
      NeedExps[I] := dwExp;
    end;
    g_Config.dwSkill68NeedExps := NeedExps;
    nCode:= 15;
    for I := 1 to 100 do begin
      Config.WriteString('Skill68', 'Level' + IntToStr(I), IntToStr(g_Config.dwSkill68NeedExps[I]));
    end;
    {$IF M2Version = 1}
    nCode:= 16;
    for I := 1 to GridSkill95.RowCount - 1 do begin
      dwExp := Str_ToInt(GridSkill95.Cells[1, I], 0);
      if (dwExp <= 0) then begin
        Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 修炼值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
        GridSkill95.Row := I;
        GridSkill95.SetFocus;
        Exit;
      end;
      NeedExps1[I] := dwExp;
    end;
    g_Config.dwSkill95NeedExps := NeedExps1;
    nCode:= 17;
    for I := 1 to 99 do begin
      Config.WriteString('Skill95', 'Level' + IntToStr(I), IntToStr(g_Config.dwSkill95NeedExps[I]));
    end;
    {$IFEND}
    nCode:= 18;
    Config.WriteBool('Setup', 'DedingAllowPK', g_Config.boDedingAllowPK);
    Config.WriteBool('Setup', 'MagLock', g_Config.boMagLock);
    Config.WriteInteger('Setup', 'FireDelayTimeRate', g_Config.nFireDelayTimeRate);
    Config.WriteInteger('Setup', 'FirePowerRate', g_Config.nFirePowerRate);
    Config.WriteInteger('Setup', 'FireMaxTime', g_Config.nFireMaxTime);
    Config.WriteBool('Setup', 'ChangeMapFireExtinguish', g_Config.boChangeMapFireExtinguish);
    Config.WriteBool('Setup', 'MagFirNoneSSMagic', g_Config.boMagFirNoneSSMagic);
    Config.WriteInteger('Setup', 'DidingPowerRate', g_Config.nDidingPowerRate);
    {分身术}
    if not g_Config.boAddMasterName then begin
      if g_Config.sCopyHumName = '' then begin
        Application.MessageBox('分身人物名称不能为空！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    nCode:= 19;
    Config.WriteInteger('Setup', 'MakeSelfTick', g_Config.nMakeSelfTick);//分身使用时长 20080404
    Config.WriteInteger('Setup', 'CopyHumanTick', g_Config.nCopyHumanTick);//召唤分身间隔 20080204
    Config.WriteInteger('Setup', 'CopyHumanBagCount', g_Config.nCopyHumanBagCount);
    Config.WriteInteger('Setup', 'CopyHumNameColor', g_Config.nCopyHumNameColor);//分身名字颜色 20080404
    Config.WriteInteger('Setup', 'AllowCopyHumanCount', g_Config.nAllowCopyHumanCount);
    Config.WriteBool('Setup', 'AttackMasterTarget', g_Config.boAttackMasterTarget);//分身与主体攻击同一目标 20100408
    Config.WriteBool('Setup', 'AddMasterName', g_Config.boAddMasterName);
    Config.WriteString('Setup', 'CopyHumName', g_Config.sCopyHumName);
    Config.WriteInteger('Setup', 'CopyHumAddHPRate', g_Config.nCopyHumAddHPRate);
    Config.WriteInteger('Setup', 'CopyHumAddMPRate', g_Config.nCopyHumAddMPRate);
    Config.WriteString('Setup', 'CopyHumBagItems1', g_Config.sCopyHumBagItems1);
    Config.WriteString('Setup', 'CopyHumBagItems2', g_Config.sCopyHumBagItems2);
    Config.WriteString('Setup', 'CopyHumBagItems3', g_Config.sCopyHumBagItems3);
    Config.WriteBool('Setup', 'AllowGuardAttack', g_Config.boAllowGuardAttack);

    Config.WriteInteger('Setup', 'WarrorAttackTime', g_Config.dwWarrorAttackTime);
    Config.WriteInteger('Setup', 'WizardAttackTime', g_Config.dwWizardAttackTime);
    Config.WriteInteger('Setup', 'TaoistAttackTime', g_Config.dwTaoistAttackTime);
    nCode:= 20;
    Config.WriteBool('Setup', 'AllowReCallMobOtherHum', g_Config.boAllowReCallMobOtherHum);
    Config.WriteBool('Setup', 'NeedLevelHighTarget', g_Config.boNeedLevelHighTarget);
  //------------------------------------------------------------------------------
    Config.WriteInteger('Setup', 'MagChangXYTick', g_Config.dwMagChangXYTick);//移行换位使用间隔 20080616
  //护体神盾 20080108
    Config.WriteInteger('Setup', 'ProtectionRate', g_Config.nProtectionRate);
    Config.WriteInteger('Setup', 'ProtectionOKRate', g_Config.nProtectionOKRate);//护体神盾生效机率 20080929
    Config.WriteBool('Setup', 'UseNGItemIncExp', g_Config.boUseNGItemIncExp);

    Config.WriteBool('Setup', 'AutoCanHit', g_Config.boAutoCanHit);//智能锁定 20080418
    Config.WriteBool('Setup', 'AutoCanHit59', g_Config.boAutoCanHit59);//噬血术智能锁定 20090521
    Config.WriteBool('Setup', 'AutoCanHit45', g_Config.boAutoCanHit45);
    Config.WriteBool('Setup', 'SlaveMoveMaster', g_Config.boSlaveMoveMaster);//宝宝是否飞到主人身边 20080713
  //------------------------------------------------------------------------------
    {$IF M2Version <> 2}
    nCode:= 21;
    Config.WriteInteger('Setup', 'MemberUseHeartTime', g_Config.nMemberUseHeartTime);
    Config.WriteInteger('Setup', 'ActivMemberHeartRate', g_Config.nActivMemberHeartRate);
    Config.WriteInteger('Setup', 'HeartArrValueRate', g_Config.nHeartArrValueRate);
    Config.WriteInteger('Setup', 'HeartIncDamageRate', g_Config.nHeartIncDamageRate);
    Config.WriteInteger('Setup', 'DivisionSavvyRate', g_Config.nDivisionSavvyRate);
    Config.WriteInteger('Setup', 'PublicHeartLevel', g_Config.nPublicHeartLevel);
    Config.WriteInteger('Setup', 'SavvyHeartNeedLevel', g_Config.nSavvyHeartNeedLevel);
    Config.WriteInteger('Setup', 'ActivHeartNH', g_Config.nActivHeartNH);
    Config.WriteInteger('Setup', 'IncHeartPointNeedExp', g_Config.nIncHeartPointNeedExp);//吸收心法经验所需经验
    Config.WriteBool('Setup', 'HeratPowerNeed', g_Config.boHeratPowerNeed);
    Config.WriteBool('Setup', 'HeratPowerNeed2', g_Config.boHeratPowerNeed2);
    Config.WriteInteger('Setup', 'Magic69UseTime', g_Config.nKill69UseTime);//倚天辟地使用间隔
    Config.WriteInteger('Setup', 'Magic102UseTime', g_Config.nKill102UseTime);//唯我独尊使用间隔
    Config.WriteInteger('Setup', 'Sill102TargetDecACTime', g_Config.nSill102TargetDecACTime);//3级唯我独尊目标减防时长
    Config.WriteInteger('Setup', 'Skill101Point', g_Config.nSkill101Point);
    Config.WriteInteger('Setup', 'Kill101UseTime', g_Config.nKill101UseTime);
    Config.WriteInteger('Setup', 'Kill101UseLogTime', g_Config.nKill101UseLogTime);
    Config.WriteInteger('Setup', 'HeartSkilltime', g_Config.nHeartSkilltime);
    Config.WriteInteger('Setup', 'MagicAttackRage_107', g_Config.nMagicAttackRage_107);
    Config.WriteBool('Setup', 'Mag113LockCanFly', g_Config.boMag113LockCanFly);
    for I := Low(g_Config.dwPulsePointNGLevel) to High(g_Config.dwPulsePointNGLevel) do begin//脉穴打通所需内功等级 20090618
      Config.WriteInteger('Setup', 'PulsePointNGLevel' + IntToStr(I), g_Config.dwPulsePointNGLevel[I]);
    end;
    nCode:= 22;
    Config.WriteString('Setup', 'NGStrongItem', g_Config.sNGStrongItem);//内功技能强化所需物品
    Config.WriteInteger('Setup', 'NGSkillMaxLevel', g_Config.nNGSkillMaxLevel);//强化内功技能最高等级
    for I := 0 to 3 do begin
      Config.WriteInteger('Setup', 'SKILL_200NGStrong' + IntToStr(I), g_Config.nSKILL_200NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_202NGStrong' + IntToStr(I), g_Config.nSKILL_202NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_236NGStrong' + IntToStr(I), g_Config.nSKILL_236NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_204NGStrong' + IntToStr(I), g_Config.nSKILL_204NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_206NGStrong' + IntToStr(I), g_Config.nSKILL_206NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_239NGStrong' + IntToStr(I), g_Config.nSKILL_239NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_230NGStrong' + IntToStr(I), g_Config.nSKILL_230NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_232NGStrong' + IntToStr(I), g_Config.nSKILL_232NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_241NGStrong' + IntToStr(I), g_Config.nSKILL_241NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_228NGStrong' + IntToStr(I), g_Config.nSKILL_228NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_234NGStrong' + IntToStr(I), g_Config.nSKILL_234NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_208NGStrong' + IntToStr(I), g_Config.nSKILL_208NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_214NGStrong' + IntToStr(I), g_Config.nSKILL_214NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_218NGStrong' + IntToStr(I), g_Config.nSKILL_218NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_222NGStrong' + IntToStr(I), g_Config.nSKILL_222NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_210NGStrong' + IntToStr(I), g_Config.nSKILL_210NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_212NGStrong' + IntToStr(I), g_Config.nSKILL_212NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_216NGStrong' + IntToStr(I), g_Config.nSKILL_216NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_224NGStrong' + IntToStr(I), g_Config.nSKILL_224NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_226NGStrong' + IntToStr(I), g_Config.nSKILL_226NGStrong[I]);
      Config.WriteInteger('Setup', 'SKILL_220NGStrong' + IntToStr(I), g_Config.nSKILL_220NGStrong[I]);
    end;
    for I := 0 to 16 do begin
      dwExp := Str_ToInt(StringGridSKILLStrongRate.Cells[1, I+1], 0);
      if (dwExp <= 0) or (dwExp > 255) then begin
        Application.MessageBox(PChar('威力倍率设置错误！(1-255)'), '错误信息', MB_OK + MB_ICONERROR);
        StringGridSKILLStrongRate.Row := I;
        StringGridSKILLStrongRate.Col:= 1;
        StringGridSKILLStrongRate.SetFocus;
        Exit;
      end;
      g_Config.nSKILLStrongRate[I] := dwExp;
      Config.WriteInteger('Setup', 'SKILLStrongRate' + IntToStr(I), g_Config.nSKILLStrongRate[I]);

      if I < 9 then begin
        dwExp := Str_ToInt(StringGridUpHeartNeedLevel.Cells[1, I+1], 0);
        if (dwExp <= 0) or (dwExp > 65535) then begin
          Application.MessageBox(PChar('等级设置错误！(1-65535)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridUpHeartNeedLevel.Row := I;
          StringGridUpHeartNeedLevel.Col:= 1;
          StringGridUpHeartNeedLevel.SetFocus;
          Exit;
        end;
        g_Config.nUpHeartNeedLevel[I] := dwExp;
        Config.WriteInteger('Setup', 'UpHeartNeedLevel' + IntToStr(I), g_Config.nUpHeartNeedLevel[I]);

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1, 1], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 1;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_7Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,2], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 2;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_90Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,3], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 3;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_89Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,4], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 4;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_26Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,5], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 5;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_74Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,6], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 6;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_91Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,7], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 7;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_10Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,8], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 8;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_22Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,9], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 9;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_45Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,10], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 10;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_92Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,11], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 11;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_93Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,12], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 12;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_13Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,13], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 13;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_17Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,14], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 14;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_71Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,15], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 15;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_94Strong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,16], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 16;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_FIREBOOMStrong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,17], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 17;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_SNOWWINDStrong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,18], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 18;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_HANGMAJINBUBStrong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,19], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 19;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_DEJIWONHOStrong[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,20], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 20;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_107NeedHeart[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,21], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 21;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_108NeedHeart[I] := dwExp;

        dwExp := Str_ToInt(StringGridSKILLStrong.Cells[I+1,22], 0);
        if (dwExp <= 0) or (dwExp > 100) then begin
          Application.MessageBox(PChar('等级设置错误！(1-100)'), '错误信息', MB_OK + MB_ICONERROR);
          StringGridSKILLStrong.Row := 22;
          StringGridSKILLStrong.Col:= I+1;
          StringGridSKILLStrong.SetFocus;
          Exit;
        end;
        g_Config.nSKILL_109NeedHeart[I] := dwExp;

        Config.WriteInteger('Setup', 'SKILL_7Strong' + IntToStr(I), g_Config.nSKILL_7Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_90Strong' + IntToStr(I), g_Config.nSKILL_90Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_89Strong' + IntToStr(I), g_Config.nSKILL_89Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_26Strong' + IntToStr(I), g_Config.nSKILL_26Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_74Strong' + IntToStr(I), g_Config.nSKILL_74Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_91Strong' + IntToStr(I), g_Config.nSKILL_91Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_10Strong' + IntToStr(I), g_Config.nSKILL_10Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_22Strong' + IntToStr(I), g_Config.nSKILL_22Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_45Strong' + IntToStr(I), g_Config.nSKILL_45Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_92Strong' + IntToStr(I), g_Config.nSKILL_92Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_93Strong' + IntToStr(I), g_Config.nSKILL_93Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_13Strong' + IntToStr(I), g_Config.nSKILL_13Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_17Strong' + IntToStr(I), g_Config.nSKILL_17Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_71Strong' + IntToStr(I), g_Config.nSKILL_71Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_94Strong' + IntToStr(I), g_Config.nSKILL_94Strong[I]);
        Config.WriteInteger('Setup', 'SKILL_FIREBOOMStrong' + IntToStr(I), g_Config.nSKILL_FIREBOOMStrong[I]);
        Config.WriteInteger('Setup', 'SKILL_SNOWWINDStrong' + IntToStr(I), g_Config.nSKILL_SNOWWINDStrong[I]);
        Config.WriteInteger('Setup', 'SKILL_HANGMAJINBUBStrong' + IntToStr(I), g_Config.nSKILL_HANGMAJINBUBStrong[I]);
        Config.WriteInteger('Setup', 'SKILL_DEJIWONHOStrong' + IntToStr(I), g_Config.nSKILL_DEJIWONHOStrong[I]);
        Config.WriteInteger('Setup', 'SKILL_107NeedHeart' + IntToStr(I), g_Config.nSKILL_107NeedHeart[I]);
        Config.WriteInteger('Setup', 'SKILL_108NeedHeart' + IntToStr(I), g_Config.nSKILL_108NeedHeart[I]);
        Config.WriteInteger('Setup', 'SKILL_109NeedHeart' + IntToStr(I), g_Config.nSKILL_109NeedHeart[I]);
      end;
    end;
    {$IFEND}
    {$IF M2Version = 1}
    Config.WriteInteger('Setup', 'Skill95EffectPowerWarror', g_Config.nSkill95EffectPowerWarror);
    Config.WriteInteger('Setup', 'Skill95EffectRateWarror', g_Config.nSkill95EffectRateWarror);
    Config.WriteInteger('Setup', 'Skill95DecInjuryWarror', g_Config.nSkill95DecInjuryWarror);
    Config.WriteInteger('Setup', 'Skill95EffectPowerWizard', g_Config.nSkill95EffectPowerWizard);
    Config.WriteInteger('Setup', 'Skill95EffectRateWizard', g_Config.nSkill95EffectRateWizard);
    Config.WriteInteger('Setup', 'Skill95DecInjuryWizard', g_Config.nSkill95DecInjuryWizard);
    Config.WriteInteger('Setup', 'Skill95EffectPowerTaoist', g_Config.nSkill95EffectPowerTaoist);
    Config.WriteInteger('Setup', 'Skill95EffectRateTaoist', g_Config.nSkill95EffectRateTaoist);
    Config.WriteInteger('Setup', 'Skill95DecInjuryTaoist', g_Config.nSkill95DecInjuryTaoist);
    Config.WriteInteger('Setup', 'Skill95LevelDecInjury', g_Config.nSkill95LevelDecInjury);

    Config.WriteInteger('Setup', 'JingYuanValue', g_Config.nJingYuanValue);
    Config.WriteInteger('Setup', 'IncJingYuanValueTime', g_Config.nIncJingYuanValueTime);
    Config.WriteInteger('Setup', 'IncTransferValueTime', g_Config.nIncTransferValueTime);
    Config.WriteInteger('Setup', 'LianqiGold', g_Config.nLianqiGold);
    Config.WriteInteger('Setup', 'LianqiGameGird', g_Config.nLianqiGameGird);
    Config.WriteInteger('Setup', 'AutoExpSkill95', g_Config.nAutoExpSkill95);
    {$IFEND}
    Config.WriteInteger('Setup', 'Magic42UseTime', g_Config.nKill42UseTime);//龙影剑法使用间隔 20080204
    Config.WriteInteger('Setup', 'AttackRate_42', g_Config.nAttackRate_42); //龙影剑法威力 20080213
    Config.WriteInteger('Setup', 'MagicAttackRage_42', g_Config.nMagicAttackRage_42); //龙影剑法范围 20080218
  //------------------------------------------------------------------------------
    Config.WriteBool('Setup', 'Skill31Effect', g_Config.boSkill31Effect);//魔法盾效果 T-特色效果 F-盛大效果 20080808
    Config.WriteInteger('Setup', 'Skill66Rate', g_Config.nSkill66Rate);//四级魔法盾抵御伤害百分率 20080829
    Config.WriteInteger('Setup', 'OrdinarySkill66Rate', g_Config.nOrdinarySkill66Rate);//普通魔法盾抵御伤害百分率 20081226
    Config.WriteInteger('Setup', 'NGSkillRate', g_Config.nNGSkillRate);//内功技能增强的攻防比率
    Config.WriteInteger('Setup', 'WarrNGLevelIncDC', g_Config.nWarrNGLevelIncDC);//战内功等级+攻 200990812
    Config.WriteInteger('Setup', 'WarrNGLevelIncAC', g_Config.nWarrNGLevelIncAC);//战内功等级+防 200990812
    Config.WriteInteger('Setup', 'WizardNGLevelIncDC', g_Config.nWizardNGLevelIncDC);//法内功等级+攻 200990812
    Config.WriteInteger('Setup', 'WizardNGLevelIncAC', g_Config.nWizardNGLevelIncAC);//法内功等级+防 200990812
    nCode:= 23;
    Config.WriteInteger('Setup', 'TaosNGLevelIncDC', g_Config.nTaosNGLevelIncDC);//道内功等级+攻
    Config.WriteInteger('Setup', 'TaosNGLevelIncAC', g_Config.nTaosNGLevelIncAC);//道内功等级+防

    Config.WriteInteger('Setup', 'Skill69NG', g_Config.nSkill69NG);//内力值参数 20081001
    Config.WriteInteger('Setup', 'Skill69NGExp', g_Config.nSkill69NGExp);//主体内功经验参数 20081001
    Config.WriteInteger('Setup', 'Skill69NGExp1', g_Config.nSkill69NGExp1);//主体内功经验参数2 20090727
    Config.WriteInteger('Setup', 'HeroSkill69NGExp', g_Config.nHeroSkill69NGExp);//英雄内功经验参数 20081001
    Config.WriteInteger('Setup', 'HeroSkill69NGExp1', g_Config.nHeroSkill69NGExp1);//英雄内功经验参数2  20090727
    Config.WriteInteger('Setup', 'LimitExpNGLevel', g_Config.nLimitExpNGLevel);//内功等级限制
    Config.WriteInteger('Setup', 'dwIncNHTime', g_Config.dwIncNHTime);//增加内力值间隔 20081002
    Config.WriteInteger('Setup', 'DrinkIncNHExp', g_Config.nDrinkIncNHExp);//饮酒增加内功经验 20081003
    Config.WriteInteger('Setup', 'HitStruckDecNH', g_Config.nHitStruckDecNH);//内功抵御普通攻击消耗内力值 20081003
    Config.WriteInteger('Exp', 'KillMonNGExpMultiple', g_Config.dwKillMonNGExpMultiple);//杀怪内功经验倍数 20081215

    Config.WriteInteger('Setup', 'DoCallTrollTick', g_Config.dwDoCallTrollTick);
    Config.WriteInteger('Setup', 'DoCallTrollTime', g_Config.dwDoCallTrollTime);

    Config.WriteInteger('Setup', 'Explosion_97Range', g_Config.nExplosion_97Range);//血魄一击(法)范围
    Config.WriteInteger('Setup', 'Explosion_98Range', g_Config.nExplosion_98Range);//血魄一击(道)范围
    Config.WriteInteger('Setup', 'UseBloodSoulTick', g_Config.dwUseBloodSoulTick);//使用血魄一击间隔
    Config.WriteInteger('Setup', 'BloodSoulHitRate', g_Config.nBloodSoulHitRate);//血魄一击暴击倍数
    Config.WriteInteger('Setup', 'BloodSoulRate', g_Config.dwBloodSoulRate);//血魄一击暴击机率
    Config.WriteInteger('Setup', 'NotGNDecHPRate', g_Config.dwNotGNDecHPRate);//无内力值减血比例
    Config.WriteBool('Setup', 'UseNewAttackFFT_96', g_Config.boUseNewAttackFFT_96);//是否使用新算法计算血魄技能威力 20100704
    nCode:= 24;
    Config.WriteInteger('Setup', 'BatterDecDamageRate', g_Config.dwBatterDecDamageRate);
    Config.WriteInteger('Setup', 'BatterRandDecDamageRate', g_Config.dwBatterRandDecDamageRate);
    Config.WriteInteger('Setup', 'UseBatterTick', g_Config.dwUseBatterTick);//使用连击间隔 20090618
    for I := Low(g_Config.nStormsHitRate) to High(g_Config.nStormsHitRate) do begin//暴击伤害倍数  20090618
      Config.WriteInteger('Setup', 'StormsHitRate' + IntToStr(I), g_Config.nStormsHitRate[I]);
    end;
    for I := Low(g_Config.nStormsHitAppearRate) to High(g_Config.nStormsHitAppearRate) do begin//暴击率 20090619
      Config.WriteInteger('Setup', 'StormsHitAppearRate' + IntToStr(I), g_Config.nStormsHitAppearRate[I]);
    end;
    nCode:= 25;
    Config.WriteInteger('Setup', 'BatterSkillFireRange_82', g_Config.nBatterSkillFireRange_82);//断岳斩攻击范围 20090706
    Config.WriteInteger('Setup', 'BatterSkillFireRange_85', g_Config.nBatterSkillFireRange_85);//横扫千军攻击范围 20090704
    Config.WriteInteger('Setup', 'BatterSkillFireRange_86', g_Config.nBatterSkillFireRange_86);//冰天雪地攻击范围 20090626
    Config.WriteInteger('Setup', 'BatterSkillPoinson_86', g_Config.nBatterSkillPoinson_86);//冰天雪地持续掉血点数 20090727
    Config.WriteInteger('Setup', 'BatterSkillFireRange_87', g_Config.nBatterSkillFireRange_87);//万剑归宗攻击范围 20090626
    Config.WriteInteger('Setup', 'BatterSkillPoinson_87', g_Config.nBatterSkillPoinson_87);//万剑归宗持续掉血点数 20090822 修改
    Config.WriteInteger('Setup', 'PoisonLength_87', g_Config.nPoisonLength_87);
  {$IFEND}
    Config.WriteBool('Setup', 'FairyShareMasterMP', g_Config.boFairyShareMasterMP);
    Config.WriteBool('Setup', 'FairyUseDBHitTime', g_Config.boFairyUseDBHitTime);
    uModValue();
  except
    MainOutMessage(Format('{%s} TfrmFunctionConfig.ButtonSkillSaveClick Code:%d',[g_sExceptionVer, nCode]));
  end;
end;

procedure TfrmFunctionConfig.RefUpgradeWeapon();
begin
  ScrollBarUpgradeWeaponDCRate.Position := g_Config.nUpgradeWeaponDCRate;
  ScrollBarUpgradeWeaponDCTwoPointRate.Position := g_Config.nUpgradeWeaponDCTwoPointRate;
  ScrollBarUpgradeWeaponDCThreePointRate.Position := g_Config.nUpgradeWeaponDCThreePointRate;

  ScrollBarUpgradeWeaponMCRate.Position := g_Config.nUpgradeWeaponMCRate;
  ScrollBarUpgradeWeaponMCTwoPointRate.Position := g_Config.nUpgradeWeaponMCTwoPointRate;
  ScrollBarUpgradeWeaponMCThreePointRate.Position := g_Config.nUpgradeWeaponMCThreePointRate;

  ScrollBarUpgradeWeaponSCRate.Position := g_Config.nUpgradeWeaponSCRate;
  ScrollBarUpgradeWeaponSCTwoPointRate.Position := g_Config.nUpgradeWeaponSCTwoPointRate;
  ScrollBarUpgradeWeaponSCThreePointRate.Position := g_Config.nUpgradeWeaponSCThreePointRate;

  EditUpgradeWeaponMaxPoint.Value := g_Config.nUpgradeWeaponMaxPoint;
  EditUpgradeWeaponPrice.Value := g_Config.nUpgradeWeaponPrice;
  EditUPgradeWeaponGetBackTime.Value := g_Config.dwUPgradeWeaponGetBackTime div 1000;
  EditClearExpireUpgradeWeaponDays.Value := g_Config.nClearExpireUpgradeWeaponDays;
  {$IF M2Version <> 2}
  RadioArmsTearPriceGameGold.Caption:= g_Config.sGameGoldName;
  RadioArmsTearPriceGold.Caption:= sSTRING_GOLDNAME;
  RadioArmsTearPriceGameGird.Caption:= g_Config.sGameGird;
  RadioArmsTearPriceGameDiamond.Caption:= g_Config.sGameDiaMond;
  case g_Config.nArmsTearPriceType of
    0: RadioArmsTearPriceGameGold.Checked:= True;
    1: RadioArmsTearPriceGold.Checked:= True;
    2: RadioArmsTearPriceGameGird.Checked:= True;
    3: RadioArmsTearPriceGameDiamond.Checked:= True;
    else RadioArmsTearPriceGameGold.Checked:= True;
  end;
  EditArmsTearPriceRate.Value := g_Config.nArmsTearPriceRate;
  EditArmsCritRate.Value := g_Config.nArmsCritRate;
  EditMaxHeapStruckDamage.Value := g_Config.nMaxHeapStruckDamage;
  {$IFEND}
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCRate.Position;
  EditUpgradeWeaponDCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCTwoPointRate.Position;
  EditUpgradeWeaponDCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponDCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponDCThreePointRate.Position;
  EditUpgradeWeaponDCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponDCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCRate.Position;
  EditUpgradeWeaponSCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCTwoPointRate.Position;
  EditUpgradeWeaponSCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponSCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponSCThreePointRate.Position;
  EditUpgradeWeaponSCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponSCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCRate.Position;
  EditUpgradeWeaponMCRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCTwoPointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCTwoPointRate.Position;
  EditUpgradeWeaponMCTwoPointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCTwoPointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarUpgradeWeaponMCThreePointRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarUpgradeWeaponMCThreePointRate.Position;
  EditUpgradeWeaponMCThreePointRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMCThreePointRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponMaxPointChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponMaxPoint := EditUpgradeWeaponMaxPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUpgradeWeaponPriceChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUpgradeWeaponPrice := EditUpgradeWeaponPrice.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUPgradeWeaponGetBackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwUPgradeWeaponGetBackTime := EditUPgradeWeaponGetBackTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditClearExpireUpgradeWeaponDaysChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nClearExpireUpgradeWeaponDays := EditClearExpireUpgradeWeaponDays.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'UpgradeWeaponMaxPoint', g_Config.nUpgradeWeaponMaxPoint);
  Config.WriteInteger('Setup', 'UpgradeWeaponPrice', g_Config.nUpgradeWeaponPrice);
  Config.WriteInteger('Setup', 'ClearExpireUpgradeWeaponDays', g_Config.nClearExpireUpgradeWeaponDays);
  Config.WriteInteger('Setup', 'UPgradeWeaponGetBackTime', g_Config.dwUPgradeWeaponGetBackTime);

  Config.WriteInteger('Setup', 'UpgradeWeaponDCRate', g_Config.nUpgradeWeaponDCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponDCTwoPointRate', g_Config.nUpgradeWeaponDCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponDCThreePointRate', g_Config.nUpgradeWeaponDCThreePointRate);

  Config.WriteInteger('Setup', 'UpgradeWeaponMCRate', g_Config.nUpgradeWeaponMCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponMCTwoPointRate', g_Config.nUpgradeWeaponMCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponMCThreePointRate', g_Config.nUpgradeWeaponMCThreePointRate);

  Config.WriteInteger('Setup', 'UpgradeWeaponSCRate', g_Config.nUpgradeWeaponSCRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponSCTwoPointRate', g_Config.nUpgradeWeaponSCTwoPointRate);
  Config.WriteInteger('Setup', 'UpgradeWeaponSCThreePointRate', g_Config.nUpgradeWeaponSCThreePointRate);

  {$IF M2Version <> 2}
  Config.WriteInteger('Setup', 'ArmsTearPriceType', g_Config.nArmsTearPriceType);
  Config.WriteInteger('Setup', 'ArmsTearPriceRate', g_Config.nArmsTearPriceRate);//拆分武器赤炎石费用倍数 20100709
  Config.WriteInteger('Setup', 'ArmsCritRate', g_Config.nArmsCritRate);//武器暴击等级出现暴击机率参数 20100709
  Config.WriteInteger('Setup', 'MaxHeapStruckDamage', g_Config.nMaxHeapStruckDamage);//武器暴击累积上限
  {$IFEND}
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonUpgradeWeaponDefaulfClick(
  Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  {$IF M2Version <> 2}
  g_Config.nArmsTearPriceType := 0;
  g_Config.nArmsTearPriceRate:= 1;
  g_Config.nArmsCritRate:= 20;
  g_Config.nMaxHeapStruckDamage := 10000;
  {$IFEND}
  g_Config.nUpgradeWeaponMaxPoint := 20;
  g_Config.nUpgradeWeaponPrice := 10000;
  g_Config.nClearExpireUpgradeWeaponDays := 8;
  g_Config.dwUPgradeWeaponGetBackTime := 3600000{60 * 60 * 1000};

  g_Config.nUpgradeWeaponDCRate := 100;
  g_Config.nUpgradeWeaponDCTwoPointRate := 30;
  g_Config.nUpgradeWeaponDCThreePointRate := 200;

  g_Config.nUpgradeWeaponMCRate := 100;
  g_Config.nUpgradeWeaponMCTwoPointRate := 30;
  g_Config.nUpgradeWeaponMCThreePointRate := 200;

  g_Config.nUpgradeWeaponSCRate := 100;
  g_Config.nUpgradeWeaponSCTwoPointRate := 30;
  g_Config.nUpgradeWeaponSCThreePointRate := 200;
  RefUpgradeWeapon();
end;

procedure TfrmFunctionConfig.EditMasterOKLevelChange(Sender: TObject);
begin
  if EditMasterOKLevel.Text = '' then begin
    EditMasterOKLevel.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKLevel := EditMasterOKLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMaxHeapStruckDamageChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMaxHeapStruckDamage := EditMaxHeapStruckDamage.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.EditMaxMakePosionTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMaxMakePosionTime := EditMaxMakePosionTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterOKCreditPointChange(
  Sender: TObject);
begin
  if EditMasterOKCreditPoint.Text = '' then begin
    EditMasterOKCreditPoint.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKCreditPoint := EditMasterOKCreditPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterOKBonusPointChange(Sender: TObject);
begin
  if EditMasterOKBonusPoint.Text = '' then begin
    EditMasterOKBonusPoint.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterOKBonusPoint := EditMasterOKBonusPoint.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonMasterSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MasterCount', g_Config.nMasterCount);//可收徒弟数 20080530
  Config.WriteInteger('Setup', 'MasterOKLevel', g_Config.nMasterOKLevel);
  Config.WriteInteger('Setup', 'MasterOKCreditPoint', g_Config.nMasterOKCreditPoint);
  Config.WriteInteger('Setup', 'MasterOKBonusPoint', g_Config.nMasterOKBonusPoint);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonMakeMineSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MakeMineHitRate', g_Config.nMakeMineHitRate);
  Config.WriteInteger('Setup', 'MakeMineRate', g_Config.nMakeMineRate);
  Config.WriteInteger('Setup', 'StoneTypeRate', g_Config.nStoneTypeRate);
  Config.WriteInteger('Setup', 'StoneTypeRateMin', g_Config.nStoneTypeRateMin);
  Config.WriteInteger('Setup', 'GoldStoneMin', g_Config.nGoldStoneMin);
  Config.WriteInteger('Setup', 'GoldStoneMax', g_Config.nGoldStoneMax);
  Config.WriteInteger('Setup', 'SilverStoneMin', g_Config.nSilverStoneMin);
  Config.WriteInteger('Setup', 'SilverStoneMax', g_Config.nSilverStoneMax);
  Config.WriteInteger('Setup', 'SteelStoneMin', g_Config.nSteelStoneMin);
  Config.WriteInteger('Setup', 'SteelStoneMax', g_Config.nSteelStoneMax);
  Config.WriteInteger('Setup', 'BlackStoneMin', g_Config.nBlackStoneMin);
  Config.WriteInteger('Setup', 'BlackStoneMax', g_Config.nBlackStoneMax);
  Config.WriteInteger('Setup', 'StoneMinDura', g_Config.nStoneMinDura);
  Config.WriteInteger('Setup', 'StoneGeneralDuraRate', g_Config.nStoneGeneralDuraRate);
  Config.WriteInteger('Setup', 'StoneAddDuraRate', g_Config.nStoneAddDuraRate);
  Config.WriteInteger('Setup', 'StoneAddDuraMax', g_Config.nStoneAddDuraMax);
{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.ButtonMakeMineDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.nMakeMineHitRate := 4;
  g_Config.nMakeMineRate := 12;
  g_Config.nStoneTypeRate := 120;
  g_Config.nStoneTypeRateMin := 56;
  g_Config.nGoldStoneMin := 1;
  g_Config.nGoldStoneMax := 2;
  g_Config.nSilverStoneMin := 3;
  g_Config.nSilverStoneMax := 20;
  g_Config.nSteelStoneMin := 21;
  g_Config.nSteelStoneMax := 45;
  g_Config.nBlackStoneMin := 46;
  g_Config.nBlackStoneMax := 56;
  g_Config.nStoneMinDura := 3000;
  g_Config.nStoneGeneralDuraRate := 13000;
  g_Config.nStoneAddDuraRate := 20;
  g_Config.nStoneAddDuraMax := 10000;
  RefMakeMine();
end;

procedure TfrmFunctionConfig.RefMakeMine();
begin
  ScrollBarMakeMineHitRate.Position := g_Config.nMakeMineHitRate;
  ScrollBarMakeMineHitRate.Min := 0;
  ScrollBarMakeMineHitRate.Max := 10;

  ScrollBarMakeMineRate.Position := g_Config.nMakeMineRate;
  ScrollBarMakeMineRate.Min := 0;
  ScrollBarMakeMineRate.Max := 50;

  ScrollBarStoneTypeRate.Position := g_Config.nStoneTypeRate;
  ScrollBarStoneTypeRate.Min := g_Config.nStoneTypeRateMin;
  ScrollBarStoneTypeRate.Max := 500;

  ScrollBarGoldStoneMax.Min := 1;
  ScrollBarGoldStoneMax.Max := g_Config.nSilverStoneMax;

  ScrollBarSilverStoneMax.Min := g_Config.nGoldStoneMax;
  ScrollBarSilverStoneMax.Max := g_Config.nSteelStoneMax;

  ScrollBarSteelStoneMax.Min := g_Config.nSilverStoneMax;
  ScrollBarSteelStoneMax.Max := g_Config.nBlackStoneMax;

  ScrollBarBlackStoneMax.Min := g_Config.nSteelStoneMax;
  ScrollBarBlackStoneMax.Max := g_Config.nStoneTypeRate;

  ScrollBarGoldStoneMax.Position := g_Config.nGoldStoneMax;
  ScrollBarSilverStoneMax.Position := g_Config.nSilverStoneMax;
  ScrollBarSteelStoneMax.Position := g_Config.nSteelStoneMax;
  ScrollBarBlackStoneMax.Position := g_Config.nBlackStoneMax;

  EditStoneMinDura.Value := g_Config.nStoneMinDura div 1000;
  EditStoneGeneralDuraRate.Value := g_Config.nStoneGeneralDuraRate div 1000;
  EditStoneAddDuraRate.Value := g_Config.nStoneAddDuraRate;
  EditStoneAddDuraMax.Value := g_Config.nStoneAddDuraMax div 1000;
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineHitRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarMakeMineHitRate.Position;
  EditMakeMineHitRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nMakeMineHitRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarMakeMineRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarMakeMineRate.Position;
  EditMakeMineRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  g_Config.nMakeMineRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarStoneTypeRateChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarStoneTypeRate.Position;
  EditStoneTypeRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  ScrollBarBlackStoneMax.Max := nPostion;
  g_Config.nStoneTypeRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarGoldStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarGoldStoneMax.Position;
  EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' + IntToStr(g_Config.nGoldStoneMax);
  if not boOpened then Exit;
  g_Config.nSilverStoneMin := nPostion + 1;
  ScrollBarSilverStoneMax.Min := nPostion + 1;
  g_Config.nGoldStoneMax := nPostion;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarSilverStoneMaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarSilverStoneMax.Position;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  if not boOpened then Exit;
  ScrollBarGoldStoneMax.Max := nPostion - 1;
  g_Config.nSteelStoneMin := nPostion + 1;
  ScrollBarSteelStoneMax.Min := nPostion + 1;
  g_Config.nSilverStoneMax := nPostion;
  EditGoldStoneMax.Text := IntToStr(g_Config.nGoldStoneMin) + '-' + IntToStr(g_Config.nGoldStoneMax);
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarSteelStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarSteelStoneMax.Position;
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  if not boOpened then Exit;
  ScrollBarSilverStoneMax.Max := nPostion - 1;
  g_Config.nBlackStoneMin := nPostion + 1;
  ScrollBarBlackStoneMax.Min := nPostion + 1;
  g_Config.nSteelStoneMax := nPostion;
  EditSilverStoneMax.Text := IntToStr(g_Config.nSilverStoneMin) + '-' + IntToStr(g_Config.nSilverStoneMax);
  EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' + IntToStr(g_Config.nBlackStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarBlackStoneMaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarBlackStoneMax.Position;
  EditBlackStoneMax.Text := IntToStr(g_Config.nBlackStoneMin) + '-' + IntToStr(g_Config.nBlackStoneMax);
  if not boOpened then Exit;
  ScrollBarSteelStoneMax.Max := nPostion - 1;
  ScrollBarStoneTypeRate.Min := nPostion;
  g_Config.nBlackStoneMax := nPostion;
  EditSteelStoneMax.Text := IntToStr(g_Config.nSteelStoneMin) + '-' + IntToStr(g_Config.nSteelStoneMax);
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneMinDuraChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneMinDura := EditStoneMinDura.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneGeneralDuraRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneGeneralDuraRate := EditStoneGeneralDuraRate.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneAddDuraRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneAddDuraRate := EditStoneAddDuraRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStoneAddDuraMaxChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStoneAddDuraMax := EditStoneAddDuraMax.Value * 1000;
  ModValue();
end;
procedure TfrmFunctionConfig.RefWinLottery;
begin
  ScrollBarWinLotteryRate.Max := 100000;
  ScrollBarWinLotteryRate.Position := g_Config.nWinLotteryRate;
  ScrollBarWinLottery1Max.Max := g_Config.nWinLotteryRate;
  ScrollBarWinLottery1Max.Min := g_Config.nWinLottery1Min;
  ScrollBarWinLottery2Max.Max := g_Config.nWinLottery1Max;
  ScrollBarWinLottery2Max.Min := g_Config.nWinLottery2Min;
  ScrollBarWinLottery3Max.Max := g_Config.nWinLottery2Max;
  ScrollBarWinLottery3Max.Min := g_Config.nWinLottery3Min;
  ScrollBarWinLottery4Max.Max := g_Config.nWinLottery3Max;
  ScrollBarWinLottery4Max.Min := g_Config.nWinLottery4Min;
  ScrollBarWinLottery5Max.Max := g_Config.nWinLottery4Max;
  ScrollBarWinLottery5Max.Min := g_Config.nWinLottery5Min;
  ScrollBarWinLottery6Max.Max := g_Config.nWinLottery5Max;
  ScrollBarWinLottery6Max.Min := g_Config.nWinLottery6Min;
  ScrollBarWinLotteryRate.Min := g_Config.nWinLottery1Max;

  ScrollBarWinLottery1Max.Position := g_Config.nWinLottery1Max;
  ScrollBarWinLottery2Max.Position := g_Config.nWinLottery2Max;
  ScrollBarWinLottery3Max.Position := g_Config.nWinLottery3Max;
  ScrollBarWinLottery4Max.Position := g_Config.nWinLottery4Max;
  ScrollBarWinLottery5Max.Position := g_Config.nWinLottery5Max;
  ScrollBarWinLottery6Max.Position := g_Config.nWinLottery6Max;

  EditWinLottery1Gold.Value := g_Config.nWinLottery1Gold;
  EditWinLottery2Gold.Value := g_Config.nWinLottery2Gold;
  EditWinLottery3Gold.Value := g_Config.nWinLottery3Gold;
  EditWinLottery4Gold.Value := g_Config.nWinLottery4Gold;
  EditWinLottery5Gold.Value := g_Config.nWinLottery5Gold;
  EditWinLottery6Gold.Value := g_Config.nWinLottery6Gold;
end;
procedure TfrmFunctionConfig.ButtonWinLotterySaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'WinLottery1Gold', g_Config.nWinLottery1Gold);
  Config.WriteInteger('Setup', 'WinLottery2Gold', g_Config.nWinLottery2Gold);
  Config.WriteInteger('Setup', 'WinLottery3Gold', g_Config.nWinLottery3Gold);
  Config.WriteInteger('Setup', 'WinLottery4Gold', g_Config.nWinLottery4Gold);
  Config.WriteInteger('Setup', 'WinLottery5Gold', g_Config.nWinLottery5Gold);
  Config.WriteInteger('Setup', 'WinLottery6Gold', g_Config.nWinLottery6Gold);
  Config.WriteInteger('Setup', 'WinLottery1Min', g_Config.nWinLottery1Min);
  Config.WriteInteger('Setup', 'WinLottery1Max', g_Config.nWinLottery1Max);
  Config.WriteInteger('Setup', 'WinLottery2Min', g_Config.nWinLottery2Min);
  Config.WriteInteger('Setup', 'WinLottery2Max', g_Config.nWinLottery2Max);
  Config.WriteInteger('Setup', 'WinLottery3Min', g_Config.nWinLottery3Min);
  Config.WriteInteger('Setup', 'WinLottery3Max', g_Config.nWinLottery3Max);
  Config.WriteInteger('Setup', 'WinLottery4Min', g_Config.nWinLottery4Min);
  Config.WriteInteger('Setup', 'WinLottery4Max', g_Config.nWinLottery4Max);
  Config.WriteInteger('Setup', 'WinLottery5Min', g_Config.nWinLottery5Min);
  Config.WriteInteger('Setup', 'WinLottery5Max', g_Config.nWinLottery5Max);
  Config.WriteInteger('Setup', 'WinLottery6Min', g_Config.nWinLottery6Min);
  Config.WriteInteger('Setup', 'WinLottery6Max', g_Config.nWinLottery6Max);
  Config.WriteInteger('Setup', 'WinLotteryRate', g_Config.nWinLotteryRate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.cbMasterTimeRoyaltyClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMasterTimeRoyalty := cbMasterTimeRoyalty.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonWinLotteryDefaultClick(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;


  g_Config.nWinLottery1Gold := 1000000;
  g_Config.nWinLottery2Gold := 200000;
  g_Config.nWinLottery3Gold := 100000;
  g_Config.nWinLottery4Gold := 10000;
  g_Config.nWinLottery5Gold := 1000;
  g_Config.nWinLottery6Gold := 500;
  g_Config.nWinLottery6Min := 1;
  g_Config.nWinLottery6Max := 4999;
  g_Config.nWinLottery5Min := 14000;
  g_Config.nWinLottery5Max := 15999;
  g_Config.nWinLottery4Min := 16000;
  g_Config.nWinLottery4Max := 16149;
  g_Config.nWinLottery3Min := 16150;
  g_Config.nWinLottery3Max := 16169;
  g_Config.nWinLottery2Min := 16170;
  g_Config.nWinLottery2Max := 16179;
  g_Config.nWinLottery1Min := 16180;
  g_Config.nWinLottery1Max := 16185;
  g_Config.nWinLotteryRate := 30000;
  RefWinLottery();
end;

procedure TfrmFunctionConfig.EditWinLottery1GoldChange(Sender: TObject);
begin
  if EditWinLottery1Gold.Text = '' then begin
    EditWinLottery1Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery1Gold := EditWinLottery1Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWinLottery2GoldChange(Sender: TObject);
begin
  if EditWinLottery2Gold.Text = '' then begin
    EditWinLottery2Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery2Gold := EditWinLottery2Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWinLottery3GoldChange(Sender: TObject);
begin
  if EditWinLottery3Gold.Text = '' then begin
    EditWinLottery3Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery3Gold := EditWinLottery3Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery4GoldChange(Sender: TObject);
begin
  if EditWinLottery4Gold.Text = '' then begin
    EditWinLottery4Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery4Gold := EditWinLottery4Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery5GoldChange(Sender: TObject);
begin
  if EditWinLottery5Gold.Text = '' then begin
    EditWinLottery5Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery5Gold := EditWinLottery5Gold.Value;
  ModValue();

end;

procedure TfrmFunctionConfig.EditWinLottery6GoldChange(Sender: TObject);
begin
  if EditWinLottery6Gold.Text = '' then begin
    EditWinLottery6Gold.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nWinLottery6Gold := EditWinLottery6Gold.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery1MaxChange(Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery1Max.Position;
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  if not boOpened then Exit;
  g_Config.nWinLottery1Max := nPostion;
  ScrollBarWinLottery2Max.Max := nPostion - 1;
  ScrollBarWinLotteryRate.Min := nPostion;
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery2MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery2Max.Position;
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  if not boOpened then Exit;
  g_Config.nWinLottery1Min := nPostion + 1;
  ScrollBarWinLottery1Max.Min := nPostion + 1;
  g_Config.nWinLottery2Max := nPostion;
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  EditWinLottery1Max.Text := IntToStr(g_Config.nWinLottery1Min) + '-' + IntToStr(g_Config.nWinLottery1Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery3MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery3Max.Position;
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  if not boOpened then Exit;
  g_Config.nWinLottery2Min := nPostion + 1;
  ScrollBarWinLottery2Max.Min := nPostion + 1;
  g_Config.nWinLottery3Max := nPostion;
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  EditWinLottery2Max.Text := IntToStr(g_Config.nWinLottery2Min) + '-' + IntToStr(g_Config.nWinLottery2Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery4MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery4Max.Position;
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  if not boOpened then Exit;
  g_Config.nWinLottery3Min := nPostion + 1;
  ScrollBarWinLottery3Max.Min := nPostion + 1;
  g_Config.nWinLottery4Max := nPostion;
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  EditWinLottery3Max.Text := IntToStr(g_Config.nWinLottery3Min) + '-' + IntToStr(g_Config.nWinLottery3Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery5MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery5Max.Position;
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  if not boOpened then Exit;
  g_Config.nWinLottery4Min := nPostion + 1;
  ScrollBarWinLottery4Max.Min := nPostion + 1;
  g_Config.nWinLottery5Max := nPostion;
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  EditWinLottery4Max.Text := IntToStr(g_Config.nWinLottery4Min) + '-' + IntToStr(g_Config.nWinLottery4Max);
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWinLottery6MaxChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLottery6Max.Position;
  EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' + IntToStr(g_Config.nWinLottery6Max);
  if not boOpened then Exit;
  g_Config.nWinLottery5Min := nPostion + 1;
  ScrollBarWinLottery5Max.Min := nPostion + 1;
  g_Config.nWinLottery6Max := nPostion;
  EditWinLottery6Max.Text := IntToStr(g_Config.nWinLottery6Min) + '-' + IntToStr(g_Config.nWinLottery6Max);
  EditWinLottery5Max.Text := IntToStr(g_Config.nWinLottery5Min) + '-' + IntToStr(g_Config.nWinLottery5Max);
  ModValue();

end;

procedure TfrmFunctionConfig.ScrollBarWinLotteryRateChange(
  Sender: TObject);
var
  nPostion: Integer;
begin
  nPostion := ScrollBarWinLotteryRate.Position;
  EditWinLotteryRate.Text := IntToStr(nPostion);
  if not boOpened then Exit;
  ScrollBarWinLottery1Max.Max := nPostion;
  g_Config.nWinLotteryRate := nPostion;
  ModValue();
end;

procedure TfrmFunctionConfig.seMasterTimeRoyaltyTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwMasterTimeRoyaltyTime := seMasterTimeRoyaltyTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Skill95DecInjuryTaoistChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95DecInjuryTaoist := Skill95DecInjuryTaoist.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill95DecInjuryWizardChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95DecInjuryWizard := Skill95DecInjuryWizard.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill95EffectPowerTaoistChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95EffectPowerTaoist := Skill95EffectPowerTaoist.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill95EffectPowerWizardChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95EffectPowerWizard := Skill95EffectPowerWizard.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill95EffectRateTaoistChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95EffectRateTaoist := Skill95EffectRateTaoist.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill95EffectRateWizardChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95EffectRateWizard := Skill95EffectRateWizard.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill95LevelDecInjuryChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95LevelDecInjury := Skill95LevelDecInjury.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_202NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_202NGStrong[0] := Skill_202NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_202NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_202NGStrong[1] := Skill_202NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_202NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_202NGStrong[2] := Skill_202NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_202NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_202NGStrong[3] := Skill_202NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_204NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_204NGStrong[0] := Skill_204NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_204NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_204NGStrong[1] := Skill_204NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_204NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_204NGStrong[2] := Skill_204NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_204NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_204NGStrong[3] := Skill_204NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_206NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_206NGStrong[0] := Skill_206NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_206NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_206NGStrong[1] := Skill_206NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_206NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_206NGStrong[2] := Skill_206NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_206NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_206NGStrong[3] := Skill_206NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_208NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_208NGStrong[0] := Skill_208NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_208NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_208NGStrong[1] := Skill_208NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_208NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_208NGStrong[2] := Skill_208NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_208NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_208NGStrong[3] := Skill_208NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_214NGStrong0Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_214NGStrong[0] := Skill_214NGStrong0.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_214NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_214NGStrong[1] := Skill_214NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_214NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_214NGStrong[2] := Skill_214NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_214NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_214NGStrong[3] := Skill_214NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_228NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_228NGStrong[0] := Skill_228NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_228NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_228NGStrong[1] := Skill_228NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_228NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_228NGStrong[2] := Skill_228NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_228NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_228NGStrong[3] := Skill_228NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_230NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_230NGStrong[0] := Skill_230NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_230NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_230NGStrong[1] := Skill_230NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_230NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_230NGStrong[2] := Skill_230NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_230NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_230NGStrong[3] := Skill_230NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_232NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_232NGStrong[0] := Skill_232NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_232NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_232NGStrong[1] := Skill_232NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_232NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_232NGStrong[2] := Skill_232NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_232NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_232NGStrong[3] := Skill_232NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_234NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_234NGStrong[0] := Skill_234NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_234NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_234NGStrong[1] := Skill_234NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_234NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_234NGStrong[2] := Skill_234NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_234NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_234NGStrong[3] := Skill_234NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_236NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_236NGStrong[0] := Skill_236NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_236NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_236NGStrong[1] := Skill_236NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_236NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_236NGStrong[2] := Skill_236NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_236NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_236NGStrong[3] := Skill_236NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_239NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_239NGStrong[0] := Skill_239NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_239NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_239NGStrong[1] := Skill_239NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_239NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_239NGStrong[2] := Skill_239NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_239NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_239NGStrong[3] := Skill_239NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_241NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_241NGStrong[0] := Skill_241NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_241NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_241NGStrong[1] := Skill_241NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_241NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_241NGStrong[2] := Skill_241NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.Skill_241NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill_241NGStrong[3] := Skill_241NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.RefReNewLevelConf();
begin
  EditReNewNameColor1.Value := g_Config.ReNewNameColor[0];
  EditReNewNameColor2.Value := g_Config.ReNewNameColor[1];
  EditReNewNameColor3.Value := g_Config.ReNewNameColor[2];
  EditReNewNameColor4.Value := g_Config.ReNewNameColor[3];
  EditReNewNameColor5.Value := g_Config.ReNewNameColor[4];
  EditReNewNameColor6.Value := g_Config.ReNewNameColor[5];
  EditReNewNameColor7.Value := g_Config.ReNewNameColor[6];
  EditReNewNameColor8.Value := g_Config.ReNewNameColor[7];
  EditReNewNameColor9.Value := g_Config.ReNewNameColor[8];
  EditReNewNameColor10.Value := g_Config.ReNewNameColor[9];
  EditReNewNameColorTime.Value := g_Config.dwReNewNameColorTime div 1000;
  CheckBoxReNewChangeColor.Checked := g_Config.boReNewChangeColor;
  CheckBoxReNewLevelClearExp.Checked := g_Config.boReNewLevelClearExp;
end;
//刷新脉穴打通所需内功等级
procedure TfrmFunctionConfig.RefPulsePointNGLevelConf();
begin
  PulsePointNGLevel0.Value := g_Config.dwPulsePointNGLevel[0];
  PulsePointNGLevel1.Value := g_Config.dwPulsePointNGLevel[1];
  PulsePointNGLevel2.Value := g_Config.dwPulsePointNGLevel[2];
  PulsePointNGLevel3.Value := g_Config.dwPulsePointNGLevel[3];
  PulsePointNGLevel4.Value := g_Config.dwPulsePointNGLevel[4];

  PulsePointNGLevel5.Value := g_Config.dwPulsePointNGLevel[5];
  PulsePointNGLevel6.Value := g_Config.dwPulsePointNGLevel[6];
  PulsePointNGLevel7.Value := g_Config.dwPulsePointNGLevel[7];
  PulsePointNGLevel8.Value := g_Config.dwPulsePointNGLevel[8];
  PulsePointNGLevel9.Value := g_Config.dwPulsePointNGLevel[9];

  PulsePointNGLevel10.Value := g_Config.dwPulsePointNGLevel[10];
  PulsePointNGLevel11.Value := g_Config.dwPulsePointNGLevel[11];
  PulsePointNGLevel12.Value := g_Config.dwPulsePointNGLevel[12];
  PulsePointNGLevel13.Value := g_Config.dwPulsePointNGLevel[13];
  PulsePointNGLevel14.Value := g_Config.dwPulsePointNGLevel[14];
  
  PulsePointNGLevel15.Value := g_Config.dwPulsePointNGLevel[15];
  PulsePointNGLevel16.Value := g_Config.dwPulsePointNGLevel[16];
  PulsePointNGLevel17.Value := g_Config.dwPulsePointNGLevel[17];
  PulsePointNGLevel18.Value := g_Config.dwPulsePointNGLevel[18];
  PulsePointNGLevel19.Value := g_Config.dwPulsePointNGLevel[19];
end;

procedure TfrmFunctionConfig.ButtonReNewLevelSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
{$IF SoftVersion <> VERDEMO}
  for I := Low(g_Config.ReNewNameColor) to High(g_Config.ReNewNameColor) do begin
    Config.WriteInteger('Setup', 'ReNewNameColor' + IntToStr(I), g_Config.ReNewNameColor[I]);
  end;
  Config.WriteInteger('Setup', 'ReNewNameColorTime', g_Config.dwReNewNameColorTime);
  Config.WriteBool('Setup', 'ReNewChangeColor', g_Config.boReNewChangeColor);
  Config.WriteBool('Setup', 'ReNewLevelClearExp', g_Config.boReNewLevelClearExp);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor1.Value;
  LabelReNewNameColor1.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[0] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor2.Value;
  LabelReNewNameColor2.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[1] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor3.Value;
  LabelReNewNameColor3.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[2] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor4.Value;
  LabelReNewNameColor4.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[3] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor5.Value;
  LabelReNewNameColor5.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[4] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor6.Value;
  LabelReNewNameColor6.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[5] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor7.Value;
  LabelReNewNameColor7.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[6] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor8.Value;
  LabelReNewNameColor8.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[7] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor9.Value;
  LabelReNewNameColor9.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[8] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReadRate1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nReadRate[1] := EditReadRate1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditReadRate2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nReadRate[2] := EditReadRate2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditReadRate3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nReadRate[3] := EditReadRate3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditReadRate4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nReadRate[4] := EditReadRate4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRebirthRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRebirthRate := EditRebirthRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditReNewNameColor10Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditReNewNameColor10.Value;
  LabelReNewNameColor10.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.ReNewNameColor[9] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditReNewNameColorTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwReNewNameColorTime := EditReNewNameColorTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditRenewPercentChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRenewPercent := EditRenewPercent.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditRingDCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingDCAddRate := EditRingDCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingDCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingDCAddValueMaxLimit := EditRingDCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingDCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingDCAddValueRate := EditRingDCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingFBAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingFBAddRate := EditRingFBAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingFBAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingFBAddValueMaxLimit := EditRingFBAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingFBAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingFBAddValueRate := EditRingFBAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingHJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingHJAddRate := EditRingHJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingHJAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingHJAddValueMaxLimit := EditRingHJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingHJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingHJAddValueRate := EditRingHJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingJMAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingJMAddRate := EditRingJMAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingJMAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingJMAddValueMaxLimit := EditRingJMAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingJMAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingJMAddValueRate := EditRingJMAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMainAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMainAddRate := EditRingMainAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMainAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMainAddValueMaxLimit := EditRingMainAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMainAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMainAddValueRate := EditRingMainAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMBAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMBAddRate := EditRingMBAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMBAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMBAddValueMaxLimit := EditRingMBAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMBAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMBAddValueRate := EditRingMBAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMCAddRate := EditRingMCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMCAddValueMaxLimit := EditRingMCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingMCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingMCAddValueRate := EditRingMCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingNLAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingNLAddRate := EditRingNLAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingNLAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingNLAddValueMaxLimit := EditRingNLAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingNLAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingNLAddValueRate := EditRingNLAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingQSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingQSAddRate := EditRingQSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingQSAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingQSAddValueMaxLimit := EditRingQSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingQSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingQSAddValueRate := EditRingQSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingSCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingSCAddRate := EditRingSCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingSCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingSCAddValueMaxLimit := EditRingSCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingSCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingSCAddValueRate := EditRingSCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingWFAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingWFAddRate := EditRingWFAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingWFAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingWFAddValueMaxLimit := EditRingWFAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingWFAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingWFAddValueRate := EditRingWFAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingXXAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingXXAddRate := EditRingXXAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingXXAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingXXAddValueMaxLimit := EditRingXXAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditRingXXAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRingXXAddValueRate := EditRingXXAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.RefMonUpgrade();
begin
  EditMonUpgradeColor1.Value := g_Config.SlaveColor[0];
  EditMonUpgradeColor2.Value := g_Config.SlaveColor[1];
  EditMonUpgradeColor3.Value := g_Config.SlaveColor[2];
  EditMonUpgradeColor4.Value := g_Config.SlaveColor[3];
  EditMonUpgradeColor5.Value := g_Config.SlaveColor[4];
  EditMonUpgradeColor6.Value := g_Config.SlaveColor[5];
  EditMonUpgradeColor7.Value := g_Config.SlaveColor[6];
  EditMonUpgradeColor8.Value := g_Config.SlaveColor[7];
  EditMonUpgradeColor9.Value := g_Config.SlaveColor[8];
  EditMonUpgradeKillCount1.Value := g_Config.MonUpLvNeedKillCount[0];
  EditMonUpgradeKillCount2.Value := g_Config.MonUpLvNeedKillCount[1];
  EditMonUpgradeKillCount3.Value := g_Config.MonUpLvNeedKillCount[2];
  EditMonUpgradeKillCount4.Value := g_Config.MonUpLvNeedKillCount[3];
  EditMonUpgradeKillCount5.Value := g_Config.MonUpLvNeedKillCount[4];
  EditMonUpgradeKillCount6.Value := g_Config.MonUpLvNeedKillCount[5];
  EditMonUpgradeKillCount7.Value := g_Config.MonUpLvNeedKillCount[6];
  EditMonUpLvNeedKillBase.Value := g_Config.nMonUpLvNeedKillBase;
  EditMonUpLvRate.Value := g_Config.nMonUpLvRate;

  CheckBoxHeroMutinyDie.Checked := g_Config.boHeroMutinyDie;
  cbMasterTimeRoyalty.Checked := g_Config.boMasterTimeRoyalty;
  seMasterTimeRoyaltyTime.Value := g_Config.dwMasterTimeRoyaltyTime;
  CheckBoxMasterDieMutiny.Checked := g_Config.boMasterDieMutiny;
  EditMasterDieMutinyRate.Value := g_Config.nMasterDieMutinyRate;
  EditMasterDieMutinyPower.Value := g_Config.nMasterDieMutinyPower;
  EditMasterDieMutinySpeed.Value := g_Config.nMasterDieMutinySpeed;

  CheckBoxMasterDieMutinyClick(CheckBoxMasterDieMutiny);

  CheckBoxBBMonAutoChangeColor.Checked := g_Config.boBBMonAutoChangeColor;
  EditBBMonAutoChangeColorTime.Value := g_Config.dwBBMonAutoChangeColorTime div 1000;
  PetsMonDecMaxHapp.Value := g_Config.dwPetsMonDecMaxHapp;
  PetsMonIncMaxHapp.Value := g_Config.dwPetsMonIncMaxHapp;
end;

procedure TfrmFunctionConfig.ButtonMonUpgradeSaveClick(Sender: TObject);
{$IF SoftVersion <> VERDEMO}
var
  I: Integer;
{$IFEND}
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'MonUpLvNeedKillBase', g_Config.nMonUpLvNeedKillBase);
  Config.WriteInteger('Setup', 'MonUpLvRate', g_Config.nMonUpLvRate);
  for I := Low(g_Config.MonUpLvNeedKillCount) to High(g_Config.MonUpLvNeedKillCount) do begin
    Config.WriteInteger('Setup', 'MonUpLvNeedKillCount' + IntToStr(I), g_Config.MonUpLvNeedKillCount[I]);
  end;

  for I := Low(g_Config.SlaveColor) to High(g_Config.SlaveColor) do begin
    Config.WriteInteger('Setup', 'SlaveColor' + IntToStr(I), g_Config.SlaveColor[I]);
  end;
  Config.WriteBool('Setup', 'HeroMutinyDie', g_Config.boHeroMutinyDie);
  Config.WriteBool('Setup', 'MasterTimeRoyalty', g_Config.boMasterTimeRoyalty);
  Config.WriteInteger('Setup', 'MasterTimeRoyaltyTime', g_Config.dwMasterTimeRoyaltyTime);


  Config.WriteBool('Setup', 'MasterDieMutiny', g_Config.boMasterDieMutiny);
  Config.WriteInteger('Setup', 'MasterDieMutinyRate', g_Config.nMasterDieMutinyRate);
  Config.WriteInteger('Setup', 'MasterDieMutinyPower', g_Config.nMasterDieMutinyPower);
  Config.WriteInteger('Setup', 'MasterDieMutinyPower', g_Config.nMasterDieMutinySpeed);

  Config.WriteBool('Setup', 'BBMonAutoChangeColor', g_Config.boBBMonAutoChangeColor);
  Config.WriteInteger('Setup', 'BBMonAutoChangeColorTime', g_Config.dwBBMonAutoChangeColorTime);
  Config.WriteInteger('Setup', 'PetsMonDecMaxHapp', g_Config.dwPetsMonDecMaxHapp);
  Config.WriteInteger('Setup', 'PetsMonIncMaxHapp', g_Config.dwPetsMonIncMaxHapp);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor1Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor1.Value;
  LabelMonUpgradeColor1.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[0] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor2Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor2.Value;
  LabelMonUpgradeColor2.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[1] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor3Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor3.Value;
  LabelMonUpgradeColor3.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[2] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor4Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor4.Value;
  LabelMonUpgradeColor4.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[3] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor5Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor5.Value;
  LabelMonUpgradeColor5.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[4] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor6Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor6.Value;
  LabelMonUpgradeColor6.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[5] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor7Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor7.Value;
  LabelMonUpgradeColor7.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[6] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeColor8Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor8.Value;
  LabelMonUpgradeColor8.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[7] := btColor;
  ModValue();
end;
procedure TfrmFunctionConfig.EditMonUpgradeColor9Change(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditMonUpgradeColor9.Value;
  LabelMonUpgradeColor9.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.SlaveColor[8] := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxReNewChangeColorClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boReNewChangeColor := CheckBoxReNewChangeColor.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxRenewHealthClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boRenewHealth := CheckBoxRenewHealth.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxReNewLevelClearExpClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boReNewLevelClearExp := CheckBoxReNewLevelClearExp.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditParalysis1RateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nParalysis1Rate := EditParalysis1Rate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditParalysis2RateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nParalysis2Rate := EditParalysis2Rate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditParalysisRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nParalysisRate := EditParalysisRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditPKFlagNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKFlagNameColor.Value;
  LabelPKFlagNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKFlagNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKLevel1NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKLevel1NameColor.Value;
  LabelPKLevel1NameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKLevel1NameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPKLevel2NameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditPKLevel2NameColor.Value;
  LabelPKLevel2NameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btPKLevel2NameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditPoisonLength_87Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPoisonLength_87 := EditPoisonLength_87.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAllyAndGuildNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditAllyAndGuildNameColor.Value;
  LabelAllyAndGuildNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btAllyAndGuildNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditWarGuildNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditWarGuildNameColor.Value;
  LabelWarGuildNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btWarGuildNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditIncTransferValueChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nIncTransferValueTime := EditIncTransferValue.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditInFreePKAreaNameColorChange(
  Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditInFreePKAreaNameColor.Value;
  LabelInFreePKAreaNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btInFreePKAreaNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount1Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[0] := EditMonUpgradeKillCount1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount2Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[1] := EditMonUpgradeKillCount2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount3Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[2] := EditMonUpgradeKillCount3.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount4Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[3] := EditMonUpgradeKillCount4.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount5Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[4] := EditMonUpgradeKillCount5.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount6Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[5] := EditMonUpgradeKillCount6.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpgradeKillCount7Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.MonUpLvNeedKillCount[6] := EditMonUpgradeKillCount7.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpLvNeedKillBaseChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonUpLvNeedKillBase := EditMonUpLvNeedKillBase.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMonUpLvRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonUpLvRate := EditMonUpLvRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMysteryAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMysteryAddRate := EditMysteryAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMysteryAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMysteryAddValueMaxLimit := EditMysteryAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMysteryAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMysteryAddValueRate := EditMysteryAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxMasterDieMutinyClick(Sender: TObject);
begin
  if CheckBoxMasterDieMutiny.Checked then begin
    EditMasterDieMutinyRate.Enabled := True;
    EditMasterDieMutinyPower.Enabled := True;
    EditMasterDieMutinySpeed.Enabled := True;
    CheckBoxHeroMutinyDie.Enabled := True;
  end else begin
    EditMasterDieMutinyRate.Enabled := False;
    EditMasterDieMutinyPower.Enabled := False;
    EditMasterDieMutinySpeed.Enabled := False;
    CheckBoxHeroMutinyDie.Enabled := False;
  end;
  if not boOpened then Exit;
  g_Config.boMasterDieMutiny := CheckBoxMasterDieMutiny.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinyRate := EditMasterDieMutinyRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinyPowerChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinyPower := EditMasterDieMutinyPower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMasterDieMutinySpeedChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMasterDieMutinySpeed := EditMasterDieMutinySpeed.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxBBMonAutoChangeColorClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boBBMonAutoChangeColor := CheckBoxBBMonAutoChangeColor.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxClearGamePointClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boClearGamePoint := CheckBoxClearGamePoint.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBBMonAutoChangeColorTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwBBMonAutoChangeColorTime := EditBBMonAutoChangeColorTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.RefSpiritMutiny();
begin
  CheckBoxSpiritMutiny.Checked := g_Config.boSpiritMutiny;
  EditSpiritMutinyTime.Value := g_Config.dwSpiritMutinyTime div 60000{(60 * 1000)};
  CheckBoxSpiritMutinyClick(CheckBoxSpiritMutiny);
end;
procedure TfrmFunctionConfig.ButtonSpiritMutinySaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'SpiritMutiny', g_Config.boSpiritMutiny);
  Config.WriteInteger('Setup', 'SpiritMutinyTime', g_Config.dwSpiritMutinyTime);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxSpiritMutinyClick(Sender: TObject);
begin
  if CheckBoxSpiritMutiny.Checked then begin
    EditSpiritMutinyTime.Enabled := True;
  end else begin
    EditSpiritMutinyTime.Enabled := False;
  end;
  if not boOpened then Exit;
  g_Config.boSpiritMutiny := CheckBoxSpiritMutiny.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSpiritMediaAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSpiritMediaAddRate := EditSpiritMediaAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditSpiritMediaAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSpiritMediaAddValueRate := EditSpiritMediaAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditSpiritMutinyTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwSpiritMutinyTime := EditSpiritMutinyTime.Value * 60000{60 * 1000};
  ModValue();
end;
//祈祷能量倍数,未使用
procedure TfrmFunctionConfig.EditMagTammingLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingLevel := EditMagTammingLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTammingTargetLevelChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingTargetLevel := EditMagTammingTargetLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMagTammingHPRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingHPRate := EditMagTammingHPRate.Value;
  ModValue();
end;


procedure TfrmFunctionConfig.EditTammingCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagTammingCount := EditTammingCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditTeleportRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nTeleportRate := EditTeleportRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMabMabeHitRandRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitRandRate := EditMabMabeHitRandRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitMinLvLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitMinLvLimit := EditMabMabeHitMinLvLimit.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitSucessRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitSucessRate := EditMabMabeHitSucessRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMabMabeHitMabeTimeRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMabMabeHitMabeTimeRate := EditMabMabeHitMabeTimeRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.RefMonSayMsg;
begin
  CheckBoxMonSayMsg.Checked := g_Config.boMonSayMsg;
end;

procedure TfrmFunctionConfig.ButtonMonSayMsgSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteBool('Setup', 'MonSayMsg', g_Config.boMonSayMsg);
{$IFEND}
  uModValue();
end;


procedure TfrmFunctionConfig.CheckBoxMonSayMsgClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMonSayMsg := CheckBoxMonSayMsg.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RefWeaponMakeLuck;
begin
  ScrollBarWeaponMakeUnLuckRate.Min := 1;
  ScrollBarWeaponMakeUnLuckRate.Max := 50;
  ScrollBarWeaponMakeUnLuckRate.Position := g_Config.nWeaponMakeUnLuckRate;

  ScrollBarWeaponMakeLuckPoint1.Min := 1;
  ScrollBarWeaponMakeLuckPoint1.Max := 10;
  ScrollBarWeaponMakeLuckPoint1.Position := g_Config.nWeaponMakeLuckPoint1;

  ScrollBarWeaponMakeLuckPoint2.Min := 1;
  ScrollBarWeaponMakeLuckPoint2.Max := 10;
  ScrollBarWeaponMakeLuckPoint2.Position := g_Config.nWeaponMakeLuckPoint2;

  ScrollBarWeaponMakeLuckPoint3.Min := 1;
  ScrollBarWeaponMakeLuckPoint3.Max := 10;
  ScrollBarWeaponMakeLuckPoint3.Position := g_Config.nWeaponMakeLuckPoint3;

  ScrollBarWeaponMakeLuckPoint2Rate.Min := 1;
  ScrollBarWeaponMakeLuckPoint2Rate.Max := 50;
  ScrollBarWeaponMakeLuckPoint2Rate.Position := g_Config.nWeaponMakeLuckPoint2Rate;

  ScrollBarWeaponMakeLuckPoint3Rate.Min := 1;
  ScrollBarWeaponMakeLuckPoint3Rate.Max := 50;
  ScrollBarWeaponMakeLuckPoint3Rate.Position := g_Config.nWeaponMakeLuckPoint3Rate;
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckDefaultClick(
  Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.nWeaponMakeUnLuckRate := 20;
  g_Config.nWeaponMakeLuckPoint1 := 1;
  g_Config.nWeaponMakeLuckPoint2 := 3;
  g_Config.nWeaponMakeLuckPoint3 := 7;
  g_Config.nWeaponMakeLuckPoint2Rate := 6;
  g_Config.nWeaponMakeLuckPoint3Rate := 40;
  RefWeaponMakeLuck();
end;

procedure TfrmFunctionConfig.ButtonWeaponMakeLuckSaveClick(
  Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'WeaponMakeUnLuckRate', g_Config.nWeaponMakeUnLuckRate);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint1', g_Config.nWeaponMakeLuckPoint1);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2', g_Config.nWeaponMakeLuckPoint2);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3', g_Config.nWeaponMakeLuckPoint3);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint2Rate', g_Config.nWeaponMakeLuckPoint2Rate);
  Config.WriteInteger('Setup', 'WeaponMakeLuckPoint3Rate', g_Config.nWeaponMakeLuckPoint3Rate);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeUnLuckRateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeUnLuckRate.Position;
  EditWeaponMakeUnLuckRate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeUnLuckRate := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint1Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint1.Position;
  EditWeaponMakeLuckPoint1.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint1 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint2.Position;
  EditWeaponMakeLuckPoint2.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint2 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint2RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint2Rate.Position;
  EditWeaponMakeLuckPoint2Rate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint2Rate := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3Change(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint3.Position;
  EditWeaponMakeLuckPoint3.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint3 := nInteger;
  ModValue();
end;

procedure TfrmFunctionConfig.ScrollBarWeaponMakeLuckPoint3RateChange(
  Sender: TObject);
var
  nInteger: Integer;
begin
  nInteger := ScrollBarWeaponMakeLuckPoint3Rate.Position;
  EditWeaponMakeLuckPoint3Rate.Text := IntToStr(nInteger);
  if not boOpened then Exit;
  g_Config.nWeaponMakeLuckPoint3Rate := nInteger;
  ModValue();
end;

//每次扣多少元宝(元宝寄售) 20080319
procedure TfrmFunctionConfig.EdtDecUserGameGoldChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecUserGameGold := EdtDecUserGameGold.Value;
  ModValue();
end;
 //20080504 去掉拍卖功能
procedure TfrmFunctionConfig.SpinEditSavvyHeartNeedLevelChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSavvyHeartNeedLevel := SpinEditSavvyHeartNeedLevel.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditSellOffCountChange(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.nUserSellOffCount := SpinEditSellOffCount.Value;
  ModValue(); }
end;
 //20080504 去掉拍卖功能
procedure TfrmFunctionConfig.SpinEditSellOffTaxChange(Sender: TObject);
begin
{  if not boOpened then Exit;
  g_Config.nUserSellOffTax := SpinEditSellOffTax.Value;
  ModValue();}
end;

procedure TfrmFunctionConfig.SpinEditShopLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCanShopLevel := SpinEditShopLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSellOffSaveClick(Sender: TObject);
begin
 // Config.WriteInteger('Setup', 'SellOffCountLimit', g_Config.nUserSellOffCount); //20080504 去掉拍卖功能
 // Config.WriteInteger('Setup', 'SellOffRate', g_Config.nUserSellOffTax); //20080504 去掉拍卖功能
  Config.WriteInteger('Setup', 'DecUserGameGold', g_Config.nDecUserGameGold);//每次扣多少元宝(元宝寄售) 20080319
  Config.WriteBool('Setup', 'OpenSelfShop', g_Config.boOpenSelfShop);
  Config.WriteBool('Setup', 'SafeZoneShop', g_Config.boSafeZoneShop);
  Config.WriteBool('Setup', 'MapShop', g_Config.boMapShop);
  Config.WriteBool('Setup', 'SafeOffShop', g_Config.boSafeOffShop);//禁止挂机摆摊
  Config.WriteInteger('Setup', 'CanShopLevel', g_Config.nCanShopLevel);
  uModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPullPlayObjectClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPullPlayObject := CheckBoxPullPlayObject.Checked;
  CheckBoxPullCrossInSafeZone.Enabled := CheckBoxPullPlayObject.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPlayObjectReduceMPClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPlayObjectReduceMP := CheckBoxPlayObjectReduceMP.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxGroupMbAttackSlaveClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boGroupMbAttackSlave := CheckBoxGroupMbAttackSlave.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxItemNameClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boChangeUseItemNameByPlayName := CheckBoxItemName.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditItemNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sChangeUseItemName := Trim(EditItemName.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.EditJingYuanValueChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nJingYuanValue := EditJingYuanValue.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditJudgePriceChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nJudgePrice := EditJudgePrice.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.ButtonChangeUseItemNameClick(Sender: TObject);
begin
  {if (not CheckBoxItemName.Checked) and (g_Config.sChangeUseItemName = '') then begin
    Application.MessageBox('请输入自定义前缀', '提示信息', MB_ICONQUESTION);
    Exit;
  end;}
  Config.WriteBool('Setup', 'ChangeUseItemNameByPlayName', g_Config.boChangeUseItemNameByPlayName);
  Config.WriteString('Setup', 'ChangeUseItemName', g_Config.sChangeUseItemName);
  uModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill39SecChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDedingUseTime := SpinEditSkill39Sec.Value;
  ModValue();
end;



procedure TfrmFunctionConfig.CheckBoxDecSuitItemModeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDecSuitItemMode := CheckBoxDecSuitItemMode.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxDecMag105SCClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDecMag105SC := CheckBoxDecMag105SC.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxDedingAllowPKClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boDedingAllowPK := CheckBoxDedingAllowPK.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAllowCopyCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAllowCopyHumanCount := SpinEditAllowCopyCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditConfigListFileNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditCopyHumNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumName := EditCopyHumName.Text;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMasterNameClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAddMasterName := CheckBoxMasterName.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditPickUpItemCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumanBagCount := SpinEditPickUpItemCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditPublicHeartLevelChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nPublicHeartLevel := SpinEditPublicHeartLevel.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditEatHPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumAddHPRate := SpinEditEatHPItemRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditEatMPItemRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumAddMPRate := SpinEditEatMPItemRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFireDelayTimeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireDelayTimeRate := SpinEditFireDelayTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFireFairyDuntRateBelowChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireFairyDuntRateBelow := SpinEditFireFairyDuntRateBelow.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFireMaxTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireMaxTime := SpinEditFireMaxTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFirePowerClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFirePowerRate := SpinEditFirePower.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems1 := Trim(EditBagItems1.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems2 := Trim(EditBagItems2.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.EditBagItems3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sCopyHumBagItems3 := Trim(EditBagItems3.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAllowGuardAttackClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowGuardAttack := CheckBoxAllowGuardAttack.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RefCopyHumConf;
begin
  EditCopyHumNameColor.Value := g_Config.nCopyHumNameColor;//分身名字颜色 20080404
  SpinEditAllowCopyCount.Value := g_Config.nAllowCopyHumanCount;
  EditCopyHumName.Text := g_Config.sCopyHumName;
  CheckBoxAttackMasterTarget.Checked := g_Config.boAttackMasterTarget;
  CheckBoxMasterName.Checked := g_Config.boAddMasterName;
  SpinEditPickUpItemCount.Value := g_Config.nCopyHumanBagCount;
  SpinEditEatHPItemRate.Value := g_Config.nCopyHumAddHPRate;
  SpinEditEatMPItemRate.Value := g_Config.nCopyHumAddMPRate;
  EditBagItems1.Text := g_Config.sCopyHumBagItems1;
  EditBagItems2.Text := g_Config.sCopyHumBagItems2;
  EditBagItems3.Text := g_Config.sCopyHumBagItems3;
  CheckBoxAllowGuardAttack.Checked := g_Config.boAllowGuardAttack;
  SpinEditWarrorAttackTime.Value := g_Config.dwWarrorAttackTime;
  SpinEditWizardAttackTime.Value := g_Config.dwWizardAttackTime;
  SpinEditTaoistAttackTime.Value := g_Config.dwTaoistAttackTime;

  CheckBoxAllowReCallMobOtherHum.Checked := g_Config.boAllowReCallMobOtherHum;
  CheckBoxNeedLevelHighTarget.Checked := g_Config.boNeedLevelHighTarget;
  CheckBoxNeedLevelHighTarget.Enabled := g_Config.boAllowReCallMobOtherHum;
end;

procedure TfrmFunctionConfig.SpinEditWarrorAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwWarrorAttackTime := SpinEditWarrorAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditWizardAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwWizardAttackTime := SpinEditWizardAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditTaoistAttackTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwTaoistAttackTime := SpinEditTaoistAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAllowReCallMobOtherHumClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAllowReCallMobOtherHum := CheckBoxAllowReCallMobOtherHum.Checked;
  CheckBoxNeedLevelHighTarget.Enabled := g_Config.boAllowReCallMobOtherHum;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxNeedHeart2Click(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.boHeratPowerNeed2 :=CheckBoxNeedHeart2.Checked;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxNeedHeartClick(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.boHeratPowerNeed :=CheckBoxNeedHeart.Checked;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxNeedLevelHighTargetClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boNeedLevelHighTarget := CheckBoxNeedLevelHighTarget.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxPullCrossInSafeZoneClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boPullCrossInSafeZone := CheckBoxPullCrossInSafeZone.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxStartMapEventClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boStartMapEvent := CheckBoxStartMapEvent.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDidingPowerRateClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDidingPowerRate := SpinEditDidingPowerRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDivisionSavvyRateChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDivisionSavvyRate := SpinEditDivisionSavvyRate.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.FairyNameEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.FireFairyNameEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sFireFairy := Trim(FireFairyNameEdt.Text);
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFairyEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFairyCount := SpinFairyEdt.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFireFairyAttackRateEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireFairyAttackRate := SpinFireFairyAttackRateEdt.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFireFairyDuntRateEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireFairyDuntRate := SpinFireFairyDuntRateEdt.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFireFairyEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFireFairyCount := SpinFireFairyEdt.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.StringGridSKILLStrongEnter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.StringGridSKILLStrongRateEnter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.GridFairySetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFairyDuntRateEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFairyDuntRate := SpinFairyDuntRateEdt.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinFairyAttackRateEdtChange( Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFairyAttackRate := SpinFairyAttackRateEdt.Value;
  ModValue();
end;

//------------------------------------------------------------------------------
//护体神盾 20080108
procedure TfrmFunctionConfig.EditProtectionRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nProtectionRate := EditProtectionRate.Value;
  ModValue();
end;
//-----------------------------------------------------------------------------
procedure TfrmFunctionConfig.SpinEditKill101UseLogTimeChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nKill101UseLogTime := SpinEditKill101UseLogTime.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditKill101UseTimeChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nKill101UseTime := SpinEditKill101UseTime.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditKill102SecChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nKill102UseTime := SpinEditKill102Sec.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditKill42SecChange(Sender: TObject);
begin
  if not boOpened then Exit; //20080619 注释
  g_Config.nKill42UseTime := SpinEditKill42Sec.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditDecDuraRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDecDigJewelDuraRate := EditDecDuraRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditDigJewelHitRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nDigJewelHitRate := EditDigJewelHitRate.Value;
  ModValue();
{$IFEND}
end;

//龙影剑法威力 20080213
procedure TfrmFunctionConfig.SpinEditAttackRate_2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackRate_42 := SpinEditAttackRate_42.Value;
  ModValue();
end;
//龙影剑法范围 20080218
procedure TfrmFunctionConfig.EditMagicAttackRage_42Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagicAttackRage_42 := EditMagicAttackRage_42.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.EditMagicShieldRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMagicShieldRate := EditMagicShieldRate.Value;
  ModValue();
{$IFEND}
end;

//-----------------------------------------------------------------------------
//开天斩使用间隔 20080204
procedure TfrmFunctionConfig.SpinEditKill43SecChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nKill43UseTime := SpinEditKill43Sec.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.SpinEditKill55UseTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nKill55UseTime := SpinEditKill55UseTime.Value;
  ModValue();
end;

//分身使用时长 20080404
procedure TfrmFunctionConfig.SpinEditMakeSelfTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeSelfTick := SpinEditMakeSelfTick.Value;
  ModValue();
end;
//召唤分身间隔 20080204
procedure TfrmFunctionConfig.SpinEditnCopyHumanTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nCopyHumanTick := SpinEditnCopyHumanTick.Value;
  ModValue();
end;
//开天斩重击几率 20080213
procedure TfrmFunctionConfig.Spin43KillHitRateEdtChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.n43KillHitRate := Spin43KillHitRateEdt.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.SpinAITaoistAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAITaoistAttackTime := SpinAITaoistAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinAIWarrorAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAIWarrorAttackTime := SpinAIWarrorAttackTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinAIWizardAttackTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAIWizardAttackTime := SpinAIWizardAttackTime.Value;
  ModValue();
end;

//开天斩重击倍数  20080213
procedure TfrmFunctionConfig.Spin43KillAttackRateEdtChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.n43KillAttackRate := Spin43KillAttackRateEdt.Value;
  ModValue();
end;
//开天斩威力 20080213
procedure TfrmFunctionConfig.SpinEditAttackRate_43Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackRate_43 := SpinEditAttackRate_43.Value;
  ModValue();
end;

//分身名字颜色 20080404
procedure TfrmFunctionConfig.EditCopyHumNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditCopyHumNameColor.Value;
  LabelCopyHumNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.nCopyHumNameColor := btColor;
  ModValue();
end;

//智能锁定 20080418
procedure TfrmFunctionConfig.AutoCanHitClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAutoCanHit := AutoCanHit.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditMedalBJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalBJAddRate := EditMedalBJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalBJAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalBJAddValueMaxLimit := EditMedalBJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalBJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalBJAddValueRate := EditMedalBJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalDCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalDCAddRate := EditMedalDCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalDCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalDCAddValueMaxLimit := EditMedalDCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalDCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalDCAddValueRate := EditMedalDCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalFBAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalFBAddRate := EditMedalFBAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalFBAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalFBAddValueMaxLimit := EditMedalFBAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalFBAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalFBAddValueRate := EditMedalFBAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalHJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalHJAddRate := EditMedalHJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalHJAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalHJAddValueMaxLimit := EditMedalHJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalHJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalHJAddValueRate := EditMedalHJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalJMAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalJMAddRate := EditMedalJMAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalJMAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalJMAddValueMaxLimit := EditMedalJMAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalJMAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalJMAddValueRate := EditMedalJMAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMainAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMainAddRate := EditMedalMainAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMainAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMainAddValueMaxLimit := EditMedalMainAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMainAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMainAddValueRate := EditMedalMainAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMBAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMBAddRate := EditMedalMBAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMBAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMBAddValueMaxLimit := EditMedalMBAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMBAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMBAddValueRate := EditMedalMBAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMCAddRate := EditMedalMCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMCAddValueMaxLimit := EditMedalMCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalMCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalMCAddValueRate := EditMedalMCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalNLAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalNLAddRate := EditMedalNLAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalNLAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalNLAddValueMaxLimit := EditMedalNLAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalNLAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalNLAddValueRate := EditMedalNLAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalNSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalNSAddRate := EditMedalNSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalNSAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalNSAddValueMaxLimit := EditMedalNSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalNSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalNSAddValueRate := EditMedalNSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalQSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalQSAddRate := EditMedalQSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalQSAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalQSAddValueMaxLimit := EditMedalQSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalQSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalQSAddValueRate := EditMedalQSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalSCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalSCAddRate := EditMedalSCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalSCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalSCAddValueMaxLimit := EditMedalSCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMedalSCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMedalSCAddValueRate := EditMedalSCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditMeteorFireRainRageChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMeteorFireRainRage := EditMeteorFireRainRage.Value;
  ModValue();
end;
//噬血术加血百分率 20080511
procedure TfrmFunctionConfig.EditMagFireCharmTreatmentChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMagFireCharmTreatment := EditMagFireCharmTreatment.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAttackRate_74Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackRate_74 := SpinEditAttackRate_74.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxLockCallHeroClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boLockCallHeroAction := CheckBoxLockCallHero.Checked;
  ModValue();
end;
//可收徒弟数 20080530
procedure TfrmFunctionConfig.EditMasterCountChange(Sender: TObject);
begin
  if EditMasterCount.Text = '' then begin
    EditMasterCount.Text := '1';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.nMasterCount := EditMasterCount.Value;
  ModValue();
end;
//无极真气使用间隔 20080603
procedure TfrmFunctionConfig.EditAbilityUpTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAbilityUpTick := EditAbilityUpTick.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.EditAdvancedKamPoChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nAdvancedKamPo := EditAdvancedKamPo.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditAIRunIntervalTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAIRunIntervalTime := EditAIRunIntervalTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditAIWalkIntervalTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAIWalkIntervalTime := EditAIWalkIntervalTime.Value;
  ModValue();
end;

//无极真气使用时长 20080603
procedure TfrmFunctionConfig.SpinEditAbilityUpUseTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAbilityUpUseTime := SpinEditAbilityUpUseTime.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.SpinEditActivHeartNHChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nActivHeartNH := SpinEditActivHeartNH.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditActivMemberHeartRateChange(
  Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nActivMemberHeartRate := SpinEditActivMemberHeartRate.Value;
  ModValue();
  {$IFEND}
end;

//移行换位使用间隔 20080616
procedure TfrmFunctionConfig.SpinEditMagChangXYChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwMagChangXYTick := SpinEditMagChangXY.Value * 1000;
  ModValue();
end;
procedure TfrmFunctionConfig.SpinEditMagicAttackRage_107Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMagicAttackRage_107 := SpinEditMagicAttackRage_107.Value;
  ModValue();
{$IFEND}
end;

//酿酒等待时间 20080621
procedure TfrmFunctionConfig.SpinEditMakeWineTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeWineTime := SpinEditMakeWineTime.Value;
  ModValue();
end;
//酿药酒等待时间 20080621
procedure TfrmFunctionConfig.SpinEditMakeWineTime1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeWineTime1 := SpinEditMakeWineTime1.Value;
  ModValue();
end;
//酿酒获得酒曲机率 20080621
procedure TfrmFunctionConfig.SpinEditMakeWineRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeWineRate := SpinEditMakeWineRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonSaveAIClick(Sender: TObject);
begin
  if EditHomeMap.Text = '' then begin
    Application.MessageBox('出生地图设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditHomeMap.SetFocus;
    Exit;
  end;
  g_Config.sAIHomeMap := Trim(EditHomeMap.Text);

  if g_MapManager.FindMap(g_Config.sAIHomeMap) = nil then begin
    Application.MessageBox('出生地图设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditHomeMap.SetFocus;
    Exit;
  end;

  g_Config.sAIConfigListFileName := Trim(EditConfigListFileName.Text);
  {$IF HEROVERSION = 1}
  g_Config.sHeroAIConfigListFileName := Trim(EditsHeroConfigListFileName.Text);
  Config.WriteString('Setup', 'AIHeroConfigListFileName', g_Config.sHeroAIConfigListFileName);
  {$IFEND}
  Config.WriteString('Setup', 'AIHomeMap', g_Config.sAIHomeMap);
  Config.WriteInteger('Setup', 'AIHomeX', g_Config.nAIHomeX);
  Config.WriteInteger('Setup', 'AIHomeY', g_Config.nAIHomeY);
  Config.WriteBool('Setup', 'HPAutoMoveMap', g_Config.boHPAutoMoveMap);
  Config.WriteBool('Setup', 'AutoRepairItem', g_Config.boAutoRepairItem);
  Config.WriteBool('Setup', 'AutoPickUpItem', g_Config.boAutoPickUpItem);
  Config.WriteBool('Setup', 'RenewHealth', g_Config.boRenewHealth);
  Config.WriteInteger('Setup', 'RenewPercent', g_Config.nRenewPercent);

  Config.WriteInteger('Setup', 'AIRunIntervalTime', g_Config.nAIRunIntervalTime);
  Config.WriteInteger('Setup', 'AIWalkIntervalTime', g_Config.nAIWalkIntervalTime);
  Config.WriteInteger('Setup', 'AIWarrorAttackTime', g_Config.nAIWarrorAttackTime);
  Config.WriteInteger('Setup', 'AIWizardAttackTime', g_Config.nAIWizardAttackTime);
  Config.WriteInteger('Setup', 'AITaoistAttackTime', g_Config.nAITaoistAttackTime);

  Config.WriteString('Setup', 'AIConfigListFileName', g_Config.sAIConfigListFileName);
  SaveAICharNameList;
  uModValue();
end;

procedure TfrmFunctionConfig.ButtonSaveKamPoClick(Sender: TObject);
begin
{$IF M2Version <> 2}
  Config.WriteInteger('Setup', 'ArmsDCAddValueMaxLimit', g_Config.nArmsDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsDCAddValueRate', g_Config.nArmsDCAddValueRate);
  Config.WriteInteger('Setup', 'ArmsDCAddRate', g_Config.nArmsDCAddRate);
  Config.WriteInteger('Setup', 'ArmsMCAddValueMaxLimit', g_Config.nArmsMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsMCAddValueRate', g_Config.nArmsMCAddValueRate);
  Config.WriteInteger('Setup', 'ArmsMCAddRate', g_Config.nArmsMCAddRate);
  Config.WriteInteger('Setup', 'ArmsSCAddValueMaxLimit', g_Config.nArmsSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsSCAddValueRate', g_Config.nArmsSCAddValueRate);
  Config.WriteInteger('Setup', 'ArmsSCAddRate', g_Config.nArmsSCAddRate);
  Config.WriteInteger('Setup', 'ArmsMainAddValueMaxLimit', g_Config.nArmsMainAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsMainAddValueRate', g_Config.nArmsMainAddValueRate);
  Config.WriteInteger('Setup', 'ArmsMainAddRate', g_Config.nArmsMainAddRate);
  Config.WriteInteger('Setup', 'ArmsQSAddValueMaxLimit', g_Config.nArmsQSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsQSAddValueRate', g_Config.nArmsQSAddValueRate);
  Config.WriteInteger('Setup', 'ArmsQSAddRate', g_Config.nArmsQSAddRate);
  Config.WriteInteger('Setup', 'ArmsJMAddValueMaxLimit', g_Config.nArmsJMAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsJMAddValueRate', g_Config.nArmsJMAddValueRate);
  Config.WriteInteger('Setup', 'ArmsJMAddRate', g_Config.nArmsJMAddRate);
  Config.WriteInteger('Setup', 'ArmsNSAddValueMaxLimit', g_Config.nArmsNSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsNSAddValueRate', g_Config.nArmsNSAddValueRate);
  Config.WriteInteger('Setup', 'ArmsNSAddRate', g_Config.nArmsNSAddRate);
  Config.WriteInteger('Setup', 'ArmsBJAddValueMaxLimit', g_Config.nArmsBJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsBJAddValueRate', g_Config.nArmsBJAddValueRate);
  Config.WriteInteger('Setup', 'ArmsBJAddRate', g_Config.nArmsBJAddRate);
  Config.WriteInteger('Setup', 'ArmsHJAddValueMaxLimit', g_Config.nArmsHJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsHJAddValueRate', g_Config.nArmsHJAddValueRate);
  Config.WriteInteger('Setup', 'ArmsHJAddRate', g_Config.nArmsHJAddRate);
  Config.WriteInteger('Setup', 'ArmsMBAddValueMaxLimit', g_Config.nArmsMBAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsMBAddValueRate', g_Config.nArmsMBAddValueRate);
  Config.WriteInteger('Setup', 'ArmsMBAddRate', g_Config.nArmsMBAddRate);
  Config.WriteInteger('Setup', 'ArmsFBAddValueMaxLimit', g_Config.nArmsFBAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsFBAddValueRate', g_Config.nArmsFBAddValueRate);
  Config.WriteInteger('Setup', 'ArmsFBAddRate', g_Config.nArmsFBAddRate);
  Config.WriteInteger('Setup', 'ArmsZQAddValueMaxLimit', g_Config.nArmsZQAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmsZQAddValueRate', g_Config.nArmsZQAddValueRate);
  Config.WriteInteger('Setup', 'ArmsZQAddRate', g_Config.nArmsZQAddRate);
  Config.WriteInteger('Setup', 'DreDCAddValueMaxLimit', g_Config.nDreDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreDCAddValueRate', g_Config.nDreDCAddValueRate);
  Config.WriteInteger('Setup', 'DreDCAddRate', g_Config.nDreDCAddRate);
  Config.WriteInteger('Setup', 'DreMCAddValueMaxLimit', g_Config.nDreMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreMCAddValueRate', g_Config.nDreMCAddValueRate);
  Config.WriteInteger('Setup', 'DreMCAddRate', g_Config.nDreMCAddRate);
  Config.WriteInteger('Setup', 'DreSCAddValueMaxLimit', g_Config.nDreSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreSCAddValueRate', g_Config.nDreSCAddValueRate);
  Config.WriteInteger('Setup', 'DreSCAddRate', g_Config.nDreSCAddRate);
  Config.WriteInteger('Setup', 'DreMainAddValueMaxLimit', g_Config.nDreMainAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreMainAddValueRate', g_Config.nDreMainAddValueRate);
  Config.WriteInteger('Setup', 'DreMainAddRate', g_Config.nDreMainAddRate);
  Config.WriteInteger('Setup', 'DreQSAddValueMaxLimit', g_Config.nDreQSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreQSAddValueRate', g_Config.nDreQSAddValueRate);
  Config.WriteInteger('Setup', 'DreQSAddRate', g_Config.nDreQSAddRate);
  Config.WriteInteger('Setup', 'DreJMAddValueMaxLimit', g_Config.nDreJMAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreJMAddValueRate', g_Config.nDreJMAddValueRate);
  Config.WriteInteger('Setup', 'DreJMAddRate', g_Config.nDreJMAddRate);
  Config.WriteInteger('Setup', 'DreXXAddValueMaxLimit', g_Config.nDreXXAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreXXAddValueRate', g_Config.nDreXXAddValueRate);
  Config.WriteInteger('Setup', 'DreXXAddRate', g_Config.nDreXXAddRate);
  Config.WriteInteger('Setup', 'DreBJAddValueMaxLimit', g_Config.nDreBJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreBJAddValueRate', g_Config.nDreBJAddValueRate);
  Config.WriteInteger('Setup', 'DreBJAddRate', g_Config.nDreBJAddRate);
  Config.WriteInteger('Setup', 'DreHJAddValueMaxLimit', g_Config.nDreHJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreHJAddValueRate', g_Config.nDreHJAddValueRate);
  Config.WriteInteger('Setup', 'DreHJAddRate', g_Config.nDreHJAddRate);
  Config.WriteInteger('Setup', 'DreMBAddValueMaxLimit', g_Config.nDreMBAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreMBAddValueRate', g_Config.nDreMBAddValueRate);
  Config.WriteInteger('Setup', 'DreMBAddRate', g_Config.nDreMBAddRate);
  Config.WriteInteger('Setup', 'DreNLAddValueMaxLimit', g_Config.nDreNLAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreNLAddValueRate', g_Config.nDreNLAddValueRate);
  Config.WriteInteger('Setup', 'DreNLAddRate', g_Config.nDreNLAddRate);
  Config.WriteInteger('Setup', 'DreWFAddValueMaxLimit', g_Config.nDreWFAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DreWFAddValueRate', g_Config.nDreWFAddValueRate);
  Config.WriteInteger('Setup', 'DreWFAddRate', g_Config.nDreWFAddRate);
  Config.WriteInteger('Setup', 'NecklaceDCAddValueMaxLimit', g_Config.nNecklaceDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceDCAddValueRate', g_Config.nNecklaceDCAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceDCAddRate', g_Config.nNecklaceDCAddRate);
  Config.WriteInteger('Setup', 'NecklaceMCAddValueMaxLimit', g_Config.nNecklaceMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceMCAddValueRate', g_Config.nNecklaceMCAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceMCAddRate', g_Config.nNecklaceMCAddRate);
  Config.WriteInteger('Setup', 'NecklaceSCAddValueMaxLimit', g_Config.nNecklaceSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceSCAddValueRate', g_Config.nNecklaceSCAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceSCAddRate', g_Config.nNecklaceSCAddRate);
  Config.WriteInteger('Setup', 'NecklaceMainAddValueMaxLimit', g_Config.nNecklaceMainAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceMainAddValueRate', g_Config.nNecklaceMainAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceMainAddRate', g_Config.nNecklaceMainAddRate);
  Config.WriteInteger('Setup', 'NecklaceQSAddValueMaxLimit', g_Config.nNecklaceQSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceQSAddValueRate', g_Config.nNecklaceQSAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceQSAddRate', g_Config.nNecklaceQSAddRate);
  Config.WriteInteger('Setup', 'NecklaceXXAddValueMaxLimit', g_Config.nNecklaceXXAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceXXAddValueRate', g_Config.nNecklaceXXAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceXXAddRate', g_Config.nNecklaceXXAddRate);
  Config.WriteInteger('Setup', 'NecklaceNLAddValueMaxLimit', g_Config.nNecklaceNLAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceNLAddValueRate', g_Config.nNecklaceNLAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceNLAddRate', g_Config.nNecklaceNLAddRate);
  Config.WriteInteger('Setup', 'NecklaceMFAddValueMaxLimit', g_Config.nNecklaceMFAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceMFAddValueRate', g_Config.nNecklaceMFAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceMFAddRate', g_Config.nNecklaceMFAddRate);
  Config.WriteInteger('Setup', 'NecklaceHJAddValueMaxLimit', g_Config.nNecklaceHJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NecklaceHJAddValueRate', g_Config.nNecklaceHJAddValueRate);
  Config.WriteInteger('Setup', 'NecklaceHJAddRate', g_Config.nNecklaceHJAddRate);
  Config.WriteInteger('Setup', 'BraceletDCAddValueMaxLimit', g_Config.nBraceletDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletDCAddValueRate', g_Config.nBraceletDCAddValueRate);
  Config.WriteInteger('Setup', 'BraceletDCAddRate', g_Config.nBraceletDCAddRate);
  Config.WriteInteger('Setup', 'BraceletMCAddValueMaxLimit', g_Config.nBraceletMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletMCAddValueRate', g_Config.nBraceletMCAddValueRate);
  Config.WriteInteger('Setup', 'BraceletMCAddRate', g_Config.nBraceletMCAddRate);
  Config.WriteInteger('Setup', 'BraceletSCAddValueMaxLimit', g_Config.nBraceletSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletSCAddValueRate', g_Config.nBraceletSCAddValueRate);
  Config.WriteInteger('Setup', 'BraceletSCAddRate', g_Config.nBraceletSCAddRate);
  Config.WriteInteger('Setup', 'BraceletMainAddValueMaxLimit', g_Config.nBraceletMainAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletMainAddValueRate', g_Config.nBraceletMainAddValueRate);
  Config.WriteInteger('Setup', 'BraceletMainAddRate', g_Config.nBraceletMainAddRate);
  Config.WriteInteger('Setup', 'BraceletQSAddValueMaxLimit', g_Config.nBraceletQSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletQSAddValueRate', g_Config.nBraceletQSAddValueRate);
  Config.WriteInteger('Setup', 'BraceletQSAddRate', g_Config.nBraceletQSAddRate);
  Config.WriteInteger('Setup', 'BraceletXXAddValueMaxLimit', g_Config.nBraceletXXAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletXXAddValueRate', g_Config.nBraceletXXAddValueRate);
  Config.WriteInteger('Setup', 'BraceletXXAddRate', g_Config.nBraceletXXAddRate);
  Config.WriteInteger('Setup', 'BraceletNLAddValueMaxLimit', g_Config.nBraceletNLAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletNLAddValueRate', g_Config.nBraceletNLAddValueRate);
  Config.WriteInteger('Setup', 'BraceletNLAddRate', g_Config.nBraceletNLAddRate);
  Config.WriteInteger('Setup', 'BraceletMFAddValueMaxLimit', g_Config.nBraceletMFAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletMFAddValueRate', g_Config.nBraceletMFAddValueRate);
  Config.WriteInteger('Setup', 'BraceletMFAddRate', g_Config.nBraceletMFAddRate);
  Config.WriteInteger('Setup', 'BraceletHJAddValueMaxLimit', g_Config.nBraceletHJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BraceletHJAddValueRate', g_Config.nBraceletHJAddValueRate);
  Config.WriteInteger('Setup', 'BraceletHJAddRate', g_Config.nBraceletHJAddRate);
  Config.WriteInteger('Setup', 'RingDCAddValueMaxLimit', g_Config.nRingDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingDCAddValueRate', g_Config.nRingDCAddValueRate);
  Config.WriteInteger('Setup', 'RingDCAddRate', g_Config.nRingDCAddRate);
  Config.WriteInteger('Setup', 'RingMCAddValueMaxLimit', g_Config.nRingMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingMCAddValueRate', g_Config.nRingMCAddValueRate);
  Config.WriteInteger('Setup', 'RingMCAddRate', g_Config.nRingMCAddRate);
  Config.WriteInteger('Setup', 'RingSCAddValueMaxLimit', g_Config.nRingSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingSCAddValueRate', g_Config.nRingSCAddValueRate);
  Config.WriteInteger('Setup', 'RingSCAddRate', g_Config.nRingSCAddRate);
  Config.WriteInteger('Setup', 'RingMainAddValueMaxLimit', g_Config.nRingMainAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingMainAddValueRate', g_Config.nRingMainAddValueRate);
  Config.WriteInteger('Setup', 'RingMainAddRate', g_Config.nRingMainAddRate);
  Config.WriteInteger('Setup', 'RingQSAddValueMaxLimit', g_Config.nRingQSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingQSAddValueRate', g_Config.nRingQSAddValueRate);
  Config.WriteInteger('Setup', 'RingQSAddRate', g_Config.nRingQSAddRate);
  Config.WriteInteger('Setup', 'RingJMAddValueMaxLimit', g_Config.nRingJMAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingJMAddValueRate', g_Config.nRingJMAddValueRate);
  Config.WriteInteger('Setup', 'RingJMAddRate', g_Config.nRingJMAddRate);
  Config.WriteInteger('Setup', 'RingXXAddValueMaxLimit', g_Config.nRingXXAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingXXAddValueRate', g_Config.nRingXXAddValueRate);
  Config.WriteInteger('Setup', 'RingXXAddRate', g_Config.nRingXXAddRate);
  Config.WriteInteger('Setup', 'RingFBAddValueMaxLimit', g_Config.nRingFBAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingFBAddValueRate', g_Config.nRingFBAddValueRate);
  Config.WriteInteger('Setup', 'RingFBAddRate', g_Config.nRingFBAddRate);
  Config.WriteInteger('Setup', 'RingHJAddValueMaxLimit', g_Config.nRingHJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingHJAddValueRate', g_Config.nRingHJAddValueRate);
  Config.WriteInteger('Setup', 'RingHJAddRate', g_Config.nRingHJAddRate);
  Config.WriteInteger('Setup', 'RingMBAddValueMaxLimit', g_Config.nRingMBAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingMBAddValueRate', g_Config.nRingMBAddValueRate);
  Config.WriteInteger('Setup', 'RingMBAddRate', g_Config.nRingMBAddRate);
  Config.WriteInteger('Setup', 'RingNLAddValueMaxLimit', g_Config.nRingNLAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingNLAddValueRate', g_Config.nRingNLAddValueRate);
  Config.WriteInteger('Setup', 'RingNLAddRate', g_Config.nRingNLAddRate);
  Config.WriteInteger('Setup', 'RingWFAddValueMaxLimit', g_Config.nRingWFAddValueMaxLimit);
  Config.WriteInteger('Setup', 'RingWFAddValueRate', g_Config.nRingWFAddValueRate);
  Config.WriteInteger('Setup', 'RingWFAddRate', g_Config.nRingWFAddRate);
  Config.WriteInteger('Setup', 'HelmeDCAddValueMaxLimit', g_Config.nHelmeDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelmeDCAddValueRate', g_Config.nHelmeDCAddValueRate);
  Config.WriteInteger('Setup', 'HelmeDCAddRate', g_Config.nHelmeDCAddRate);
  Config.WriteInteger('Setup', 'HelmeMCAddValueMaxLimit', g_Config.nHelmeMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelmeMCAddValueRate', g_Config.nHelmeMCAddValueRate);
  Config.WriteInteger('Setup', 'HelmeMCAddRate', g_Config.nHelmeMCAddRate);
  Config.WriteInteger('Setup', 'HelmeSCAddValueMaxLimit', g_Config.nHelmeSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelmeSCAddValueRate', g_Config.nHelmeSCAddValueRate);
  Config.WriteInteger('Setup', 'HelmeSCAddRate', g_Config.nHelmeSCAddRate);
  Config.WriteInteger('Setup', 'HelmeMainAddValueMaxLimit', g_Config.nHelmeMainAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelmeMainAddValueRate', g_Config.nHelmeMainAddValueRate);
  Config.WriteInteger('Setup', 'HelmeMainAddRate', g_Config.nHelmeMainAddRate);
  Config.WriteInteger('Setup', 'HelmeQSAddValueMaxLimit', g_Config.nHelmeQSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelmeQSAddValueRate', g_Config.nHelmeQSAddValueRate);
  Config.WriteInteger('Setup', 'HelmeQSAddRate', g_Config.nHelmeQSAddRate);
  Config.WriteInteger('Setup', 'HelmeXXAddValueMaxLimit', g_Config.nHelmeXXAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelmeXXAddValueRate', g_Config.nHelmeXXAddValueRate);
  Config.WriteInteger('Setup', 'HelmeXXAddRate', g_Config.nHelmeXXAddRate);
  Config.WriteInteger('Setup', 'HelmeHJAddValueMaxLimit', g_Config.nHelmeHJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelmeHJAddValueRate', g_Config.nHelmeHJAddValueRate);
  Config.WriteInteger('Setup', 'HelmeHJAddRate', g_Config.nHelmeHJAddRate);
  Config.WriteInteger('Setup', 'ShoesDCAddValueMaxLimit', g_Config.nShoesDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ShoesDCAddValueRate', g_Config.nShoesDCAddValueRate);
  Config.WriteInteger('Setup', 'ShoesDCAddRate', g_Config.nShoesDCAddRate);
  Config.WriteInteger('Setup', 'ShoesMCAddValueMaxLimit', g_Config.nShoesMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ShoesMCAddValueRate', g_Config.nShoesMCAddValueRate);
  Config.WriteInteger('Setup', 'ShoesMCAddRate', g_Config.nShoesMCAddRate);
  Config.WriteInteger('Setup', 'ShoesSCAddValueMaxLimit', g_Config.nShoesSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ShoesSCAddValueRate', g_Config.nShoesSCAddValueRate);
  Config.WriteInteger('Setup', 'ShoesSCAddRate', g_Config.nShoesSCAddRate);
  Config.WriteInteger('Setup', 'ShoesMainAddValueMaxLimit', g_Config.nShoesMainAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ShoesMainAddValueRate', g_Config.nShoesMainAddValueRate);
  Config.WriteInteger('Setup', 'ShoesMainAddRate', g_Config.nShoesMainAddRate);
  Config.WriteInteger('Setup', 'ShoesQSAddValueMaxLimit', g_Config.nShoesQSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ShoesQSAddValueRate', g_Config.nShoesQSAddValueRate);
  Config.WriteInteger('Setup', 'ShoesQSAddRate', g_Config.nShoesQSAddRate);
  Config.WriteInteger('Setup', 'ShoesJMAddValueMaxLimit', g_Config.nShoesJMAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ShoesJMAddValueRate', g_Config.nShoesJMAddValueRate);
  Config.WriteInteger('Setup', 'ShoesJMAddRate', g_Config.nShoesJMAddRate);
  Config.WriteInteger('Setup', 'ShoesHJAddValueMaxLimit', g_Config.nShoesHJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ShoesHJAddValueRate', g_Config.nShoesHJAddValueRate);
  Config.WriteInteger('Setup', 'ShoesHJAddRate', g_Config.nShoesHJAddRate);
  Config.WriteInteger('Setup', 'MedalDCAddValueMaxLimit', g_Config.nMedalDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalDCAddValueRate', g_Config.nMedalDCAddValueRate);
  Config.WriteInteger('Setup', 'MedalDCAddRate', g_Config.nMedalDCAddRate);
  Config.WriteInteger('Setup', 'MedalMCAddValueMaxLimit', g_Config.nMedalMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalMCAddValueRate', g_Config.nMedalMCAddValueRate);
  Config.WriteInteger('Setup', 'MedalMCAddRate', g_Config.nMedalMCAddRate);
  Config.WriteInteger('Setup', 'MedalSCAddValueMaxLimit', g_Config.nMedalSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalSCAddValueRate', g_Config.nMedalSCAddValueRate);
  Config.WriteInteger('Setup', 'MedalSCAddRate', g_Config.nMedalSCAddRate);
  Config.WriteInteger('Setup', 'MedalMainAddValueMaxLimit', g_Config.nMedalMainAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalMainAddValueRate', g_Config.nMedalMainAddValueRate);
  Config.WriteInteger('Setup', 'MedalMainAddRate', g_Config.nMedalMainAddRate);
  Config.WriteInteger('Setup', 'MedalQSAddValueMaxLimit', g_Config.nMedalQSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalQSAddValueRate', g_Config.nMedalQSAddValueRate);
  Config.WriteInteger('Setup', 'MedalQSAddRate', g_Config.nMedalQSAddRate);
  Config.WriteInteger('Setup', 'MedalJMAddValueMaxLimit', g_Config.nMedalJMAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalJMAddValueRate', g_Config.nMedalJMAddValueRate);
  Config.WriteInteger('Setup', 'MedalJMAddRate', g_Config.nMedalJMAddRate);
  Config.WriteInteger('Setup', 'MedalFBAddValueMaxLimit', g_Config.nMedalFBAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalFBAddValueRate', g_Config.nMedalFBAddValueRate);
  Config.WriteInteger('Setup', 'MedalFBAddRate', g_Config.nMedalFBAddRate);
  Config.WriteInteger('Setup', 'MedalBJAddValueMaxLimit', g_Config.nMedalBJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalBJAddValueRate', g_Config.nMedalBJAddValueRate);
  Config.WriteInteger('Setup', 'MedalBJAddRate', g_Config.nMedalBJAddRate);
  Config.WriteInteger('Setup', 'MedalHJAddValueMaxLimit', g_Config.nMedalHJAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalHJAddValueRate', g_Config.nMedalHJAddValueRate);
  Config.WriteInteger('Setup', 'MedalHJAddRate', g_Config.nMedalHJAddRate);
  Config.WriteInteger('Setup', 'MedalMBAddValueMaxLimit', g_Config.nMedalMBAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalMBAddValueRate', g_Config.nMedalMBAddValueRate);
  Config.WriteInteger('Setup', 'MedalMBAddRate', g_Config.nMedalMBAddRate);
  Config.WriteInteger('Setup', 'MedalNLAddValueMaxLimit', g_Config.nMedalNLAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalNLAddValueRate', g_Config.nMedalNLAddValueRate);
  Config.WriteInteger('Setup', 'MedalNLAddRate', g_Config.nMedalNLAddRate);
  Config.WriteInteger('Setup', 'MedalNSAddValueMaxLimit', g_Config.nMedalNSAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MedalNSAddValueRate', g_Config.nMedalNSAddValueRate);
  Config.WriteInteger('Setup', 'MedalNSAddRate', g_Config.nMedalNSAddRate);
  Config.WriteInteger('Setup', 'MysteryAddValueMaxLimit', g_Config.nMysteryAddValueMaxLimit);
  Config.WriteInteger('Setup', 'MysteryAddValueRate', g_Config.nMysteryAddValueRate);
  Config.WriteInteger('Setup', 'MysteryAddRate', g_Config.nMysteryAddRate);
  Config.WriteInteger('Setup', 'ReadRate1', g_Config.nReadRate[1]);
  Config.WriteInteger('Setup', 'ReadRate2', g_Config.nReadRate[2]);
  Config.WriteInteger('Setup', 'ReadRate3', g_Config.nReadRate[3]);
  Config.WriteInteger('Setup', 'ReadRate4', g_Config.nReadRate[4]);
  Config.WriteInteger('Setup', 'AdvancedKamPo', g_Config.nAdvancedKamPo);
  Config.WriteInteger('Setup', 'RebirthRate', g_Config.nRebirthRate);
  Config.WriteInteger('Setup', 'MagicShieldRate', g_Config.nMagicShieldRate);
  Config.WriteInteger('Setup', 'ParalysisRate', g_Config.nParalysisRate);
  Config.WriteInteger('Setup', 'Paralysis2Rate', g_Config.nParalysis2Rate);
  Config.WriteInteger('Setup', 'Paralysis1Rate', g_Config.nParalysis1Rate);
  Config.WriteInteger('Setup', 'ProbeNecklaceRate', g_Config.nProbeNecklaceRate);
  Config.WriteInteger('Setup', 'TeleportRate', g_Config.nTeleportRate);
  Config.WriteInteger('Setup', 'SpiritMediaAddValueRate', g_Config.nSpiritMediaAddValueRate);
  Config.WriteInteger('Setup', 'SpiritMediaAddRate', g_Config.nSpiritMediaAddRate);
  Config.WriteBool('Setup', 'UseCanKamPo', g_Config.boUseCanKamPo);
  Config.WriteBool('Setup', 'OffLineEnergy', g_Config.boOffLineEnergy);
  Config.WriteInteger('Setup', 'EnergyValueTime', g_Config.nEnergyValueTime);
  Config.WriteInteger('Setup', 'JudgePrice', g_Config.nJudgePrice);
  Config.WriteBool('Setup','JudgeUseGold', g_Config.boJudgeUseGold);
  Config.WriteInteger('Setup', 'NewKamPoLockNeed1', g_Config.dwNewKamPoLockNeed1);
  Config.WriteInteger('Setup','NewKamPoLockNeed2', g_Config.dwNewKamPoLockNeed2);
  Config.WriteInteger('Setup','NewKamPoNeed1', g_Config.dwNewKamPoNeed1);
  Config.WriteInteger('Setup','NewKamPoNeed2', g_Config.dwNewKamPoNeed2);
  Config.WriteInteger('Setup', 'MakeScrollRate1', g_Config.nMakeScrollRate[1]);
  Config.WriteInteger('Setup', 'MakeScrollRate2', g_Config.nMakeScrollRate[2]);
  Config.WriteInteger('Setup', 'MakeScrollRate3', g_Config.nMakeScrollRate[3]);
  Config.WriteInteger('Setup', 'MakeScrollRate4', g_Config.nMakeScrollRate[4]);
  uModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.ButtonSaveMakeWineClick(Sender: TObject);
var
  I: Integer;
  dwExp: LongWord;
  NeedExps: TLevelNeedExp1;
begin
  for I := 1 to GridMedicineExp.RowCount - 1 do begin
    dwExp := Str_ToInt(GridMedicineExp.Cells[1, I], 0);
    if (dwExp <= 0) then begin//20080522
      Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 药力值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridMedicineExp.Row := I;
      GridMedicineExp.SetFocus;
      Exit;
    end;
    NeedExps[I] := dwExp;
  end;
  g_Config.dwMedicineNeedExps := NeedExps;
  for I := 1 to 1000 do begin
    Config.WriteString('MedicineExp', 'Level' + IntToStr(I), IntToStr(g_Config.dwMedicineNeedExps[I]));
  end;
  Config.WriteInteger('Setup', 'MinGuildFountain', g_Config.nMinGuildFountain);//行会酒泉蓄量少于时,不能领取 20080627
  Config.WriteInteger('Setup', 'DecGuildFountain', g_Config.nDecGuildFountain);//行会成员领取酒泉,蓄量减少 20080627
  Config.WriteInteger('Setup', 'InFountainTime', g_Config.nInFountainTime);//站在泉眼上的累积时间(秒) 20080624
  Config.WriteInteger('Setup', 'DesMedicineTick', g_Config.nDesMedicineTick);////减药力值时间间隔 20080624
  Config.WriteInteger('Setup', 'DesMedicineValue', g_Config.nDesMedicineValue);//长时间不使用酒,减药力值 20080623
{$IF M2Version = 1}
  Config.WriteInteger('Setup', 'DesAlcoholValue', g_Config.nDesAlcoholValue);//长时间使用酒，减酒量
  Config.WriteInteger('Setup', 'DesAlcoholTick', g_Config.nDesAlcoholTick);//减酒量时间间隔
  Config.WriteInteger('Setup', 'DesMaxAlcoholValue', g_Config.nDesMaxAlcoholValue);//超过指定酒量时才减酒量
{$IFEND}
  Config.WriteInteger('Setup', 'MakeWineTime', g_Config.nMakeWineTime);//酿普通酒等待时间 20080621
  Config.WriteInteger('Setup', 'MakeWineTime1', g_Config.nMakeWineTime1);//酿药酒等待时间 20080621
  Config.WriteInteger('Setup', 'MakeWineRate', g_Config.nMakeWineRate);//酿酒获得酒曲机率 20080621
  Config.WriteInteger('Setup', 'MakeWineLevelRate', g_Config.nMakeWineLevelRate);//酿酒获得酒等级机率 20091117
  Config.WriteInteger('Setup', 'IncAlcoholTick', g_Config.nIncAlcoholTick);//增加酒量进度的间隔时间 20080623
  Config.WriteInteger('Setup', 'DesDrinkTick', g_Config.nDesDrinkTick);//减少醉酒度的间隔时间 20080623
  Config.WriteInteger('Setup', 'MaxAlcoholValue', g_Config.nMaxAlcoholValue);//酒量上限初始值 20080623
  Config.WriteInteger('Setup', 'IncAlcoholValue', g_Config.nIncAlcoholValue);//升级后增加酒量上限值 20080623
  uModValue();
end;

//增加酒量进度的间隔时间 20080623
procedure TfrmFunctionConfig.SpinEditIncAlcoholTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nIncAlcoholTick := SpinEditIncAlcoholTick.Value;
  ModValue();
end;
//减少醉酒度的间隔时间 20080623
procedure TfrmFunctionConfig.SpinEditDesDrinkTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDesDrinkTick := SpinEditDesDrinkTick.Value;
  ModValue();
end;
//酒量上限初始值 20080623
procedure TfrmFunctionConfig.SpinEditMaxAlcoholValueChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMaxAlcoholValue := SpinEditMaxAlcoholValue.Value;
  ModValue();
end;
procedure TfrmFunctionConfig.SpinEditMemberUseHeartTimeChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMemberUseHeartTime := SpinEditMemberUseHeartTime.Value;
  ModValue();
  {$IFEND}
end;

//升级后增加酒量上限值 20080623
procedure TfrmFunctionConfig.SpinEditIncAlcoholValueChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nIncAlcoholValue := SpinEditIncAlcoholValue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditIncHeartPointNeedExpChange(
  Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nIncHeartPointNeedExp := SpinEditIncHeartPointNeedExp.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditIncJingYuanValueTimeChange(
  Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nIncJingYuanValueTime := SpinEditIncJingYuanValueTime.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.GridMedicineExpEnter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;
//长时间不使用酒,减药力值 20080623
procedure TfrmFunctionConfig.SpinEditDesMedicineValueChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDesMedicineValue := SpinEditDesMedicineValue.Value;
  ModValue();
end;
//减药力值时间间隔 20080624
procedure TfrmFunctionConfig.SpinEditDesMedicineTickChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDesMedicineTick := SpinEditDesMedicineTick.Value;
  ModValue();
end;
//站在泉眼上的累积时间(秒) 20080624
procedure TfrmFunctionConfig.SpinEditInFountainTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nInFountainTime := SpinEditInFountainTime.Value;
  ModValue();
end;
//酒气护体使用间隔 20080625
procedure TfrmFunctionConfig.SpinEditHPUpTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHPUpTick := SpinEditHPUpTick.Value;
  ModValue();
end;

//酒气护体增加使用时长 20080625
procedure TfrmFunctionConfig.SpinEditHPUpUseTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHPUpUseTime := SpinEditHPUpUseTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.GridSkill68Enter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

//先天元力失效酒量下限比例 20080626
procedure TfrmFunctionConfig.SpinEditMinDrinkValue67Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMinDrinkValue67 := SpinEditMinDrinkValue67.Value;
  ModValue();
end;

//酒气护体失效酒量下限比例 20080626
procedure TfrmFunctionConfig.SpinEditMinDrinkValue68Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMinDrinkValue68 := SpinEditMinDrinkValue68.Value;
  ModValue();
end;
//行会酒泉蓄量少于时,不能领取 20080627
procedure TfrmFunctionConfig.SpinEditMinGuildFountainChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMinGuildFountain := SpinEditMinGuildFountain.Value;
  ModValue();
end;
//行会成员领取酒泉,蓄量减少 20080627
procedure TfrmFunctionConfig.SpinEditDecGuildFountainChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDecGuildFountain := SpinEditDecGuildFountain.Value;
  ModValue();
end;
//挑战时间 20080706
procedure TfrmFunctionConfig.SpinEditChallengeTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nChallengeTime := SpinEditChallengeTime.Value ;
  ModValue();
end;

//宝宝是否飞到主人身边 20080713
procedure TfrmFunctionConfig.CheckSlaveMoveMasterClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSlaveMoveMaster := CheckSlaveMoveMaster.Checked;
  ModValue();
end;

//人物名是否显示行会信息  20080726
procedure TfrmFunctionConfig.CheckBoxShowGuildNameClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boShowGuildName := CheckBoxShowGuildName.Checked;
  ModValue();
end;

//--------------------------气血石配置------------------------------
procedure TfrmFunctionConfig.SpinEditStartHPRockChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nStartHPRock := SpinEditStartHPRock.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHPRockSpellChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHPRockSpell := SpinEditHPRockSpell.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditRockAddHPChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRockAddHP := SpinEditRockAddHP.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHPRockDecDuraChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHPRockDecDura := SpinEditHPRockDecDura.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditStartMPRockChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nStartMPRock := SpinEditStartMPRock.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditMPRockSpellChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMPRockSpell := SpinEditMPRockSpell.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditRockAddMPChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRockAddMP := SpinEditRockAddMP.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditMPRockDecDuraChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nMPRockDecDura := SpinEditMPRockDecDura.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditStartHPMPRock1Change(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nStartHPMPRock1 := SpinEditStartHPMPRock1.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditStartHPMPRockChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nStartHPMPRock := SpinEditStartHPMPRock.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHPMPRockSpell1Change(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHPMPRockSpell1 := SpinEditHPMPRockSpell1.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHPMPRockSpellChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHPMPRockSpell := SpinEditHPMPRockSpell.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditRockAddHPMP1Change(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRockAddHPMP1 := SpinEditRockAddHPMP1.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditRockAddHPMPChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nRockAddHPMP := SpinEditRockAddHPMP.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHPMPRockDecDura1Change(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHPMPRockDecDura1 := SpinEditHPMPRockDecDura1.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHPMPRockDecDuraChange(
  Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHPMPRockDecDura := SpinEditHPMPRockDecDura.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.RadioArmsTearPriceGameDiamondClick(
  Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  if RadioArmsTearPriceGameDiamond.Checked then g_Config.nArmsTearPriceType := 3;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.RadioArmsTearPriceGameGirdClick(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  if RadioArmsTearPriceGameGird.Checked then g_Config.nArmsTearPriceType := 2;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.RadioArmsTearPriceGameGoldClick(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  if RadioArmsTearPriceGameGold.Checked then g_Config.nArmsTearPriceType := 0;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.RadioArmsTearPriceGoldClick(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  if RadioArmsTearPriceGold.Checked then g_Config.nArmsTearPriceType := 1;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.RadioboSkill31EffectFalseClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSkill31Effect :=not RadioboSkill31EffectFalse.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RadioboSkill31EffectTrueClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSkill31Effect := RadioboSkill31EffectTrue.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.RadioButtonJudgeGameGoldClick(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.boJudgeUseGold := not RadioButtonJudgeGameGold.Checked;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.RadioButtonJudgeUseGoldClick(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.boJudgeUseGold := RadioButtonJudgeUseGold.Checked;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditSkill66RateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill66Rate := SpinEditSkill66Rate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditProbeNecklaceRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nProbeNecklaceRate := EditProbeNecklaceRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditProtectionOKRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nProtectionOKRate := EditProtectionOKRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill69NGChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill69NG := SpinEditSkill69NG.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill69NGExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill69NGExp := SpinEditSkill69NGExp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSKILL_200NGStrong1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSKILL_200NGStrong[0] := SpinEditSKILL_200NGStrong1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditSKILL_200NGStrong2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSKILL_200NGStrong[1] := SpinEditSKILL_200NGStrong2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditSKILL_200NGStrong3Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSKILL_200NGStrong[2] := SpinEditSKILL_200NGStrong3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditSKILL_200NGStrong4Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSKILL_200NGStrong[3] := SpinEditSKILL_200NGStrong4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHeroSkill69NGExpChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill69NGExp := SpinEditHeroSkill69NGExp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditdwIncNHTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwIncNHTime := SpinEditdwIncNHTime.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditDrinkIncNHExpChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDrinkIncNHExp := SpinEditDrinkIncNHExp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditHitStruckDecNHChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHitStruckDecNH := SpinEditHitStruckDecNH.Value;
  ModValue();
end;

//无极真气使用固定时长 20081109
procedure TfrmFunctionConfig.SpinEditAbilityUpFixUseTimeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAbilityUpFixUseTime := SpinEditAbilityUpFixUseTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAbilityUpFixModeClick(
  Sender: TObject);
var
  boStatus: Boolean;
begin
  boStatus := CheckBoxAbilityUpFixMode.Checked;
  SpinEditAbilityUpFixUseTime.Enabled := boStatus;
  SpinEditAbilityUpUseTime.Enabled := not boStatus;
  if not boOpened then Exit;
  g_Config.boAbilityUpFixMode := boStatus;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAttackRate_26Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackRate_26 := SpinEditAttackRate_26.Value;
  ModValue();
end;
//杀怪内功经验倍数 20081215
procedure TfrmFunctionConfig.EditKillMonNGExpMultipleChange(
  Sender: TObject);
begin
  if EditKillMonNGExpMultiple.Text = '' then begin
    EditKillMonNGExpMultiple.Text := '0';
    Exit;
  end;
  if not boOpened then Exit;
  g_Config.dwKillMonNGExpMultiple := EditKillMonNGExpMultiple.Value;
  ModValue();
end;
//NPC名字颜色 20081218
procedure TfrmFunctionConfig.SpinEditNPCNameColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := SpinEditNPCNameColor.Value;
  LabelNPCNameColor.Color := GetRGB(btColor);
  if not boOpened then Exit;
  g_Config.btNPCNameColor := btColor;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditOrdinarySkill66RateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nOrdinarySkill66Rate := SpinEditOrdinarySkill66Rate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditFairyDuntRateBelowChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFairyDuntRateBelow := SpinEditFairyDuntRateBelow.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFunctionConfig.FormDestroy(Sender: TObject);
begin
  frmFunctionConfig:= nil;
end;

procedure TfrmFunctionConfig.ButtonExpCrystalSaveClick(Sender: TObject);
var
  I: Byte;
  dwExp, dwExp1: LongWord;
  NeedExps, NeedExps1: TExpCrystalLevelNeedExp;
begin
  for I := 1 to GridExpCrystalLevelExp.RowCount - 1 do begin
    dwExp := Str_ToInt(GridExpCrystalLevelExp.Cells[1, I], 0);
    if (dwExp <= 0) then begin
      Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridExpCrystalLevelExp.Row := I;
      GridExpCrystalLevelExp.SetFocus;
      Exit;
    end;
    dwExp1 := Str_ToInt(GridExpCrystalLevelExp.Cells[2, I], 0);
    if (dwExp1 <= 0) then begin
      Application.MessageBox(PChar('等级 ' + IntToStr(I) + ' 内功经验值设置错误！！！'), '错误信息', MB_OK + MB_ICONERROR);
      GridExpCrystalLevelExp.Row := I;
      GridExpCrystalLevelExp.SetFocus;
      Exit;
    end;
    NeedExps[I] := dwExp;
    NeedExps1[I] := dwExp1;
  end;
  g_Config.dwExpCrystalNeedExps := NeedExps;
  g_Config.dwNGExpCrystalNeedExps := NeedExps1;
  for I := 1 to 4 do begin
    Config.WriteString('ExpCrystal', 'Level' + IntToStr(I), IntToStr(g_Config.dwExpCrystalNeedExps[I]));
    Config.WriteString('NGExpCrystal', 'Level' + IntToStr(I), IntToStr(g_Config.dwNGExpCrystalNeedExps[I]));
  end;
  Config.WriteInteger('Setup', 'HeroCrystalExpRate', g_Config.nHeroCrystalExpRate);
{$IF M2Version = 1}
  Config.WriteBool('Setup', 'ASSIGNMENTCRYST', g_Config.boAssignmentCryst);
  Config.WriteInteger('Setup', 'CRYSTALLEVEL1', g_Config.nCRYSTALLEVEL1);
  Config.WriteInteger('Setup', 'CRYSTALLEVEL2', g_Config.nCRYSTALLEVEL2);
  Config.WriteInteger('Setup', 'CRYSTALLEVEL3', g_Config.nCRYSTALLEVEL3);
  Config.WriteInteger('Setup', 'CRYSTALLEVEL4', g_Config.nCRYSTALLEVEL4);
{$IFEND}
  uModValue();
end;

procedure TfrmFunctionConfig.GridExpCrystalLevelExpEnter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHelmetDCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeDCAddRate := EditHelmetDCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetDCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeDCAddValueMaxLimit := EditHelmetDCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetDCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeDCAddValueRate := EditHelmetDCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetHJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeHJAddRate := EditHelmetHJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetHJAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeHJAddValueMaxLimit := EditHelmetHJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetHJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeHJAddValueRate := EditHelmetHJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetMainAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeMainAddRate := EditHelmetMainAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetMainAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeMainAddValueMaxLimit := EditHelmetMainAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetMainAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeMainAddValueRate := EditHelmetMainAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetMCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeMCAddRate := EditHelmetMCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetMCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeMCAddValueMaxLimit := EditHelmetMCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetMCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeMCAddValueRate := EditHelmetMCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetQSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeQSAddRate := EditHelmetQSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetQSAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeQSAddValueMaxLimit := EditHelmetQSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetQSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeQSAddValueRate := EditHelmetQSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetSCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeSCAddRate := EditHelmetSCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetSCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeSCAddValueMaxLimit := EditHelmetSCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetSCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeSCAddValueRate := EditHelmetSCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetXXAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeXXAddRate := EditHelmetXXAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetXXAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeXXAddValueMaxLimit := EditHelmetXXAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHelmetXXAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHelmeXXAddValueRate := EditHelmetXXAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditHeroCrystalExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroCrystalExpRate := EditHeroCrystalExpRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHomeMapChange(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHomeXChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAIHomeX := EditHomeX.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditHomeYChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAIHomeY := EditHomeY.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxGroupMbAttackPlayMonClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boGroupMbAttackPlayMon := CheckBoxGroupMbAttackPlayMon.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonWealthAnimalMonSaveClick(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'ExpCattle', g_Config.dwCattleGasvalueNeedExps);//牛气管升级经验 20090521
  Config.WriteInteger('Setup', 'UseItmeToMonRate', g_Config.nUseItmeToMonRate);//攻击富贵兽触发脚本段的机率 20090518
  Config.WriteInteger('Setup', 'MonGameGird', g_Config.nMonGameGird);//富贵兽初始灵符数 20090518
  Config.WriteInteger('Setup', 'IncMonGameGird', g_Config.nIncMonGameGird);//攻击狂暴状态富贵兽累计灵符数 20090519
  Config.WriteInteger('Setup', 'Mon79CrazyRate', g_Config.nMon79CrazyRate);//富贵兽狂暴机率
  Config.WriteInteger('Setup', 'Mon79CrazyTime', g_Config.nMon79CrazyTime);//富贵兽狂暴时长
  Config.WriteInteger('Setup', 'GetCattleGasvalue', g_Config.nGetCattleGasvalue);//攻击富贵兽所取得牛气值 20090519
  Config.WriteInteger('Setup', 'AutoOpenBoxID1', g_Config.nAutoOpenBoxID1);//牛气管升1级后自动打开箱子的编号 20090520
  Config.WriteInteger('Setup', 'AutoOpenBoxID2', g_Config.nAutoOpenBoxID2);//牛气管升级2级后自动打开箱子的编号 20090524
  Config.WriteInteger('Setup', 'AutoOpenBoxID3', g_Config.nAutoOpenBoxID3);//牛气管升级3级后自动打开箱子的编号 20090524
  Config.WriteInteger('Setup', 'AutoOpenBoxID4', g_Config.nAutoOpenBoxID4);//牛气管升级4级后自动打开箱子的编号 20090524
  Config.WriteBool('Setup', 'ShowMonSysHint', g_Config.boShowMonSysHint);//富贵兽累积灵符是否提示 20090603
  uModValue();
end;

procedure TfrmFunctionConfig.SpinEditUseItmeToMonRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUseItmeToMonRate := SpinEditUseItmeToMonRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.GridCattleGasvalueLevelExpEnter(
  Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditMonGameGirdChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonGameGird := SpinEditMonGameGird.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditGetCattleGasvalueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nGetCattleGasvalue := EditGetCattleGasvalue.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditGetDigJewelRaveChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nGetDigJewelRave := EditGetDigJewelRave.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditIncMonGameGirdChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nIncMonGameGird := SpinEditIncMonGameGird.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAutoExpSkill95Change(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nAutoExpSkill95 := SpinEditAutoExpSkill95.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditAutoOpenBoxID1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAutoOpenBoxID1 := SpinEditAutoOpenBoxID1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.AutoCanHit59Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAutoCanHit59 := AutoCanHit59.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditCattleGasvalueLevelExpChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwCattleGasvalueNeedExps:= SpinEditCattleGasvalueLevelExp.Value;
  ModValue();  
end;

procedure TfrmFunctionConfig.SpinEditAutoOpenBoxID2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAutoOpenBoxID2 := SpinEditAutoOpenBoxID2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAutoOpenBoxID3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAutoOpenBoxID3 := SpinEditAutoOpenBoxID3.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditAutoOpenBoxID4Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAutoOpenBoxID4 := SpinEditAutoOpenBoxID4.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxShowSysHintClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boShowMonSysHint := CheckBoxShowSysHint.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.PetsMonDecMaxHappChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPetsMonDecMaxHapp := PetsMonDecMaxHapp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PetsMonIncMaxHappChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPetsMonIncMaxHapp := PetsMonIncMaxHapp.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel0Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[0] := PulsePointNGLevel0.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[1] := PulsePointNGLevel1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[2] := PulsePointNGLevel2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[3] := PulsePointNGLevel3.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel4Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[4] := PulsePointNGLevel4.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel5Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[5] := PulsePointNGLevel5.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel6Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[6] := PulsePointNGLevel6.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel7Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[7] := PulsePointNGLevel7.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel8Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[8] := PulsePointNGLevel8.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel9Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[9] := PulsePointNGLevel9.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel10Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[10] := PulsePointNGLevel10.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel11Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[11] := PulsePointNGLevel11.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel12Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[12] := PulsePointNGLevel12.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel13Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[13] := PulsePointNGLevel13.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel14Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[14] := PulsePointNGLevel14.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel15Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[15] := PulsePointNGLevel15.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel16Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[16] := PulsePointNGLevel16.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel17Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[17] := PulsePointNGLevel17.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel18Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[18] := PulsePointNGLevel18.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.PulsePointNGLevel19Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwPulsePointNGLevel[19] := PulsePointNGLevel19.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.Button1Click(Sender: TObject);
begin
  if Application.MessageBox('是否确认恢复默认设置？', '确认信息', MB_YESNO + MB_ICONQUESTION) <> IDYES then begin
    Exit;
  end;
  g_Config.dwPulsePointNGLevel[0] := 5;
  g_Config.dwPulsePointNGLevel[1] := 7;
  g_Config.dwPulsePointNGLevel[2] := 10;
  g_Config.dwPulsePointNGLevel[3] := 13;
  g_Config.dwPulsePointNGLevel[4] := 15;
  g_Config.dwPulsePointNGLevel[5] := 19;
  g_Config.dwPulsePointNGLevel[6] := 23;
  g_Config.dwPulsePointNGLevel[7] := 25;
  g_Config.dwPulsePointNGLevel[8] := 27;
  g_Config.dwPulsePointNGLevel[9] := 33;
  g_Config.dwPulsePointNGLevel[10] := 36;
  g_Config.dwPulsePointNGLevel[11] := 39;
  g_Config.dwPulsePointNGLevel[12] := 45;
  g_Config.dwPulsePointNGLevel[13] := 48;
  g_Config.dwPulsePointNGLevel[14] := 52;
  g_Config.dwPulsePointNGLevel[15] := 56;
  g_Config.dwPulsePointNGLevel[16] := 62;
  g_Config.dwPulsePointNGLevel[17] := 72;
  g_Config.dwPulsePointNGLevel[18] := 81;
  g_Config.dwPulsePointNGLevel[19] := 95;
  RefPulsePointNGLevelConf();
end;

procedure TfrmFunctionConfig.ButtonAIDelClick(Sender: TObject);
begin
  ListBoxAIList.DeleteSelected;
  g_AICharNameList.Lock;
  try
    g_AICharNameList.Clear;
    g_AICharNameList.AddStrings(ListBoxAIList.Items);
  finally
    g_AICharNameList.UnLock;
  end;
  ModValue();
end;

procedure TfrmFunctionConfig.ButtonAIListAddClick(Sender: TObject);
var
  sName: string;
begin
  sName := Trim(EditAIName.Text);
  if (sName <> '') and (not GetAICharNameList(sName)) then begin
    g_AICharNameList.Lock;
    try
      g_AICharNameList.Add(sName);
      ListBoxAIList.Clear;
      ListBoxAIList.Items.AddStrings(g_AICharNameList);
    finally
      g_AICharNameList.UnLock;
    end;
    ModValue();
  end;
end;

procedure TfrmFunctionConfig.ButtonAILogonClick(Sender: TObject);
var
  Index, nC: Integer;
  AI: TAILogon;
begin
  if g_MapManager.FindMap(g_Config.sAIHomeMap) = nil then begin
    Application.MessageBox('出生地图设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditHomeMap.SetFocus;
    Exit;
  end;
  nC := 0;
  AI.sMapName := g_Config.sAIHomeMap;
  AI.sConfigFileName := '';
  AI.sHeroConfigFileName := '';
  AI.sFilePath := g_Config.sEnvirDir;
  AI.sConfigListFileName := g_Config.sAIConfigListFileName;
  AI.sHeroConfigListFileName := g_Config.sHeroAIConfigListFileName;
  AI.nX := g_Config.nAIHomeX;
  AI.nY := g_Config.nAIHomeY;

  for Index := 0 to ListBoxAIList.Count - 1 do begin
    if ListBoxAIList.Selected[Index] then begin
      if (UserEngine.GetPlayObject(ListBoxAIList.Items.Strings[Index]) = nil) and (not UserEngine.FindAILogon(ListBoxAIList.Items.Strings[Index])) then begin
        AI.sCharName := ListBoxAIList.Items.Strings[Index];
        UserEngine.AddAILogon(@AI);
        nC := nC + 1;
      end;
    end;
  end;
  ButtonAILogon.Enabled := False;
end;

procedure TfrmFunctionConfig.EditUseBatterTickChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwUseBatterTick := EditUseBatterTick.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitRate1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitRate[1] := EditStormsHitRate1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitAppearRate1Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitAppearRate[0] := EditStormsHitAppearRate1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitAppearRate2Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitAppearRate[1] := EditStormsHitAppearRate2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitAppearRate3Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitAppearRate[2] := EditStormsHitAppearRate3.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitAppearRate4Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitAppearRate[3] := EditStormsHitAppearRate4.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitAppearRate5Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitAppearRate[4] := EditStormsHitAppearRate5.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.FormShow(Sender: TObject);
begin
  //TabSheet55.TabVisible:= False;//隐藏连击页面 20090619
end;

procedure TfrmFunctionConfig.EditSkillFireRange_87Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBatterSkillFireRange_87 := EditSkillFireRange_87.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkillFireRange_86Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBatterSkillFireRange_86 := EditSkillFireRange_86.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitRate2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitRate[2] := EditStormsHitRate2.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitRate3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitRate[3] := EditStormsHitRate3.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitRate4Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitRate[4] := EditStormsHitRate4.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditStormsHitRate5Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nStormsHitRate[5] := EditStormsHitRate5.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkillFireRange_85Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBatterSkillFireRange_85 := EditSkillFireRange_85.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSkill101PointChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSkill101Point := EditSkill101Point.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditSkill95DecInjuryWarrorChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95DecInjuryWarror := EditSkill95DecInjuryWarror.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditSkill95EffectPowerWarrorChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95EffectPowerWarror := EditSkill95EffectPowerWarror.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditSkill95EffectRateWarrorChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nSkill95EffectRateWarror := EditSkill95EffectRateWarror.Value;
  ModValue();
{$IFEND}  
end;

procedure TfrmFunctionConfig.EditSkillFireRange_82Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBatterSkillFireRange_82 := EditSkillFireRange_82.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditMon79CrazyRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMon79CrazyRate := SpinEditMon79CrazyRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBatterSkillPoinson_86Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBatterSkillPoinson_86 := EditBatterSkillPoinson_86.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBatterSkillPoinson_87Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBatterSkillPoinson_87 := EditBatterSkillPoinson_87.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditSkill69NGExp1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSkill69NGExp1 := SpinEditSkill69NGExp1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditHeartArrValueRateChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHeartArrValueRate := SpinEditHeartArrValueRate.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHeartIncDamageRateChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHeartIncDamageRate := SpinEditHeartIncDamageRate.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHeartSkilltimeChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nHeartSkilltime := SpinEditHeartSkilltime.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditHeroSkill69NGExp1Change(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHeroSkill69NGExp1 := SpinEditHeroSkill69NGExp1.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxUseCanKamPoClick(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.boUseCanKamPo := CheckBoxUseCanKamPo.Checked;
  ModValue();
 {$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxUseFengHaoAbilClick(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.boUseFengHaoAbil := CheckBoxUseFengHaoAbil.Checked;
  ModValue();
 {$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxUseNGItemIncExpClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boUseNGItemIncExp :=CheckBoxUseNGItemIncExp.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditNGSkillRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNGSkillRate := SpinEditNGSkillRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditBatterDecDamageRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwBatterDecDamageRate := SpinEditBatterDecDamageRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditBatterRandDecDamageRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwBatterRandDecDamageRate := SpinEditBatterRandDecDamageRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditWarrNGLevelIncDCChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWarrNGLevelIncDC := SpinEditWarrNGLevelIncDC.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditWarrNGLevelIncACChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWarrNGLevelIncAC := SpinEditWarrNGLevelIncAC.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditWizardNGLevelIncDCChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWizardNGLevelIncDC := SpinEditWizardNGLevelIncDC.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditWizardNGLevelIncACChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWizardNGLevelIncAC := SpinEditWizardNGLevelIncAC.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditMon79CrazyTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMon79CrazyTime := SpinEditMon79CrazyTime.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditKill69SecChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nKill69UseTime := SpinEditKill69Sec.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.SpinEditLimitExpNGLevelChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nLimitExpNGLevel := SpinEditLimitExpNGLevel.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditMakeWineLevelRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeWineLevelRate := SpinEditMakeWineLevelRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSacredCountChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSacredCount := EditSacredCount.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditSacredNameChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.sSacredName := EditSacredName.Text;
  ModValue();
end;

procedure TfrmFunctionConfig.EditShoesDCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesDCAddRate := EditShoesDCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesDCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesDCAddValueMaxLimit := EditShoesDCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesDCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesDCAddValueRate := EditShoesDCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesHJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesHJAddRate := EditShoesHJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesHJAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesHJAddValueMaxLimit := EditShoesHJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesHJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesHJAddValueRate := EditShoesHJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesJMAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesJMAddRate := EditShoesJMAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesJMAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesJMAddValueMaxLimit := EditShoesJMAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesJMAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesJMAddValueRate := EditShoesJMAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesMainAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesMainAddRate := EditShoesMainAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesMainAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesMainAddValueMaxLimit := EditShoesMainAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesMainAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesMainAddValueRate := EditShoesMainAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesMCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesMCAddRate := EditShoesMCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesMCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesMCAddValueMaxLimit := EditShoesMCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesMCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesMCAddValueRate := EditShoesMCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesQSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesQSAddRate := EditShoesQSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesQSAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesQSAddValueMaxLimit := EditShoesQSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesQSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesQSAddValueRate := EditShoesQSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesSCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesSCAddRate := EditShoesSCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesSCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesSCAddValueMaxLimit := EditShoesSCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditShoesSCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nShoesSCAddValueRate := EditShoesSCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditSill102TargetDecACTimeChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nSill102TargetDecACTime := EditSill102TargetDecACTime.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.GridSkill95Enter(Sender: TObject);
begin
  if not boOpened then Exit;
  ModValue();
end;

procedure TfrmFunctionConfig.LianqiGameGirdChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nLianqiGameGird := LianqiGameGird.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.LianqiGoldChange(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nLianqiGold := LianqiGold.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.ListBoxAIListClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := ListBoxAIList.ItemIndex;
  if Index >= 0 then begin
    EditAIName.Text := ListBoxAIList.Items.Strings[Index];
    ButtonAIDel.Enabled := True;
    ButtonAILogon.Enabled := True;
    Exit;
  end;
  ButtonAIDel.Enabled := False;
  ButtonAILogon.Enabled := False;
end;

procedure TfrmFunctionConfig.CheckBoxHeroMutinyDieClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHeroMutinyDie := CheckBoxHeroMutinyDie.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxHPAutoMoveMapClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boHPAutoMoveMap := CheckBoxHPAutoMoveMap.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMag113LockCanFlyClick(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.boMag113LockCanFly := CheckBoxMag113LockCanFly.Checked;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxMagFirNoneSSMagicClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMagFirNoneSSMagic := CheckBoxMagFirNoneSSMagic.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMagicLockTagClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMagLock := CheckBoxMagicLockTag.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAbilityAddModeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAbilityAddMode := CheckBoxAbilityAddMode.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEdit4Change(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nDesAlcoholValue := SpinEdit4.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEdit3Change(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nDesAlcoholTick := SpinEdit3.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEdit5Change(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nDesMaxAlcoholValue := SpinEdit5.Value;
  ModValue();
{$IFEND}  
end;

procedure TfrmFunctionConfig.SpinEdit6Change(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nCRYSTALLEVEL1 := SpinEdit6.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEdit7Change(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nCRYSTALLEVEL2 := SpinEdit7.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEdit8Change(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nCRYSTALLEVEL3 := SpinEdit8.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.SpinEdit9Change(Sender: TObject);
begin
{$IF M2Version = 1}
  if not boOpened then Exit;
  g_Config.nCRYSTALLEVEL4 := SpinEdit9.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxAssignmentCrystClick(Sender: TObject);
begin
{$IF M2Version = 1}
  if CheckBoxAssignmentCryst.Checked then begin
    Label295.Enabled := True;
    Label297.Enabled := True;
    Label298.Enabled := True;
    Label299.Enabled := True;
    SpinEdit6.Enabled := True;
    SpinEdit7.Enabled := True;
    SpinEdit8.Enabled := True;
    SpinEdit9.Enabled := True;
  end else begin
    Label295.Enabled := False;
    Label297.Enabled := False;
    Label298.Enabled := False;
    Label299.Enabled := False;
    SpinEdit6.Enabled := False;
    SpinEdit7.Enabled := False;
    SpinEdit8.Enabled := False;
    SpinEdit9.Enabled := False;
  end;
  if not boOpened then Exit;
  g_Config.boAssignmentCryst := CheckBoxAssignmentCryst.Checked;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.CheckBoxFairyShareMasterMPClick(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boFairyShareMasterMP := CheckBoxFairyShareMasterMP.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxFairyUseDBHitTimeClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boFairyUseDBHitTime := CheckBoxFairyUseDBHitTime.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.AutoCanHit45Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAutoCanHit45 := AutoCanHit45.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.EditUseBloodSoulChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwUseBloodSoulTick := EditUseBloodSoul.Value * 1000;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBloodSoulRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwBloodSoulRate := EditBloodSoulRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditBloodSoulHitRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBloodSoulHitRate := EditBloodSoulHitRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditNecklaceDCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceDCAddRate := EditNecklaceDCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceDCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceDCAddValueMaxLimit := EditNecklaceDCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceDCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceDCAddValueRate := EditNecklaceDCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceHJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceHJAddRate := EditNecklaceHJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceHJAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceHJAddValueMaxLimit := EditNecklaceHJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceHJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceHJAddValueRate := EditNecklaceHJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMainAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMainAddRate := EditNecklaceMainAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMainAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMainAddValueMaxLimit := EditNecklaceMainAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMainAddValueRateChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMainAddValueRate := EditNecklaceMainAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMCAddRate := EditNecklaceMCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMCAddValueMaxLimit := EditNecklaceMCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMCAddValueRate := EditNecklaceMCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMFAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMFAddRate := EditNecklaceMFAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMFAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMFAddValueMaxLimit := EditNecklaceMFAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceMFAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceMFAddValueRate := EditNecklaceMFAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceNLAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceNLAddRate := EditNecklaceNLAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceNLAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceNLAddValueMaxLimit := EditNecklaceNLAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceNLAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceNLAddValueRate := EditNecklaceNLAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceQSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceQSAddRate := EditNecklaceQSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceQSAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceQSAddValueMaxLimit := EditNecklaceQSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceQSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceQSAddValueRate := EditNecklaceQSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceSCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceSCAddRate := EditNecklaceSCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceSCAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceSCAddValueMaxLimit := EditNecklaceSCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceSCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceSCAddValueRate := EditNecklaceSCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceXXAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceXXAddRate := EditNecklaceXXAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceXXAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceXXAddValueMaxLimit := EditNecklaceXXAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNecklaceXXAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nNecklaceXXAddValueRate := EditNecklaceXXAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNewKamPoLockNeed1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.dwNewKamPoLockNeed1 := EditNewKamPoLockNeed1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNewKamPoLockNeed2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.dwNewKamPoLockNeed2 := EditNewKamPoLockNeed2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNewKamPoNeed1Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.dwNewKamPoNeed1 := EditNewKamPoNeed1.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNewKamPoNeed2Change(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.dwNewKamPoNeed2 := EditNewKamPoNeed2.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNGStrongItemChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.sNGStrongItem := Trim(EditNGStrongItem.Text);
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditNotGNDecHPRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwNotGNDecHPRate := EditNotGNDecHPRate.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAttackMasterTargetClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAttackMasterTarget := CheckBoxAttackMasterTarget.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAutoPickUpItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAutoPickUpItem := CheckBoxAutoPickUpItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAutoRepairItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boAutoRepairItem := CheckBoxAutoRepairItem.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditExplosion_97RangeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nExplosion_97Range := SpinEditExplosion_97Range.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditExplosion_98RangeChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nExplosion_98Range := SpinEditExplosion_98Range.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxOpenSelfShopClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boOpenSelfShop := CheckBoxOpenSelfShop.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxSafeZoneShopClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSafeZoneShop := CheckBoxSafeZoneShop.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMagTammingHitNewClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMagTammingHitNew := CheckBoxMagTammingHitNew.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxMapShopClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boMapShop := CheckBoxMapShop.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxOffLineEnergyClick(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.boOffLineEnergy := CheckBoxOffLineEnergy.Checked;
  ModValue();
 {$IFEND}  
end;

procedure TfrmFunctionConfig.CheckBoxOffLineShopClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boSafeOffShop := CheckBoxOffLineShop.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.CheckBoxAttackFFT_96Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boUseNewAttackFFT_96 := CheckBoxAttackFFT_96.Checked;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditTaosNGLevelIncDCChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nTaosNGLevelIncDC := SpinEditTaosNGLevelIncDC.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.SpinEditTaosNGLevelIncACChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nTaosNGLevelIncAC := SpinEditTaosNGLevelIncAC.Value;
  ModValue();
end;

procedure TfrmFunctionConfig.EditArmsTearPriceRateChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsTearPriceRate := EditArmsTearPriceRate.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsZQAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsZQAddRate := EditArmsZQAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsZQAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsZQAddValueMaxLimit := EditArmsZQAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsZQAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsZQAddValueRate := EditArmsZQAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsBJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsBJAddRate := EditArmsBJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsBJAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsBJAddValueMaxLimit := EditArmsBJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsBJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsBJAddValueRate := EditArmsBJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsCritRateChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsCritRate := EditArmsCritRate.Value;
  ModValue();
  {$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsDCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsDCAddRate := EditArmsDCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsDCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsDCAddValueMaxLimit := EditArmsDCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsDCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsDCAddValueRate := EditArmsDCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsFBAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsFBAddRate := EditArmsFBAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsFBAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsFBAddValueMaxLimit := EditArmsFBAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsFBAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsFBAddValueRate := EditArmsFBAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsHJAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsHJAddRate := EditArmsHJAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsHJAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsHJAddValueMaxLimit := EditArmsHJAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsHJAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsHJAddValueRate := EditArmsHJAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsJMAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsJMAddRate := EditArmsJMAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsJMAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsJMAddValueMaxLimit := EditArmsJMAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsJMAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsJMAddValueRate := EditArmsJMAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMainAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMainAddRate := EditArmsMainAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMainAddValueMaxLimitChange(
  Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMainAddValueMaxLimit := EditArmsMainAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMainAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMainAddValueRate := EditArmsMainAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMBAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMBAddRate := EditArmsMBAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMBAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMBAddValueMaxLimit := EditArmsMBAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMBAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMBAddValueRate := EditArmsMBAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMCAddRate := EditArmsMCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMCAddValueMaxLimit := EditArmsMCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsMCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsMCAddValueRate := EditArmsMCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsNSAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsNSAddRate := EditArmsNSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsNSAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsNSAddValueMaxLimit := EditArmsNSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsNSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsNSAddValueRate := EditArmsNSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsQSAddRateChange(Sender: TObject);
begin{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsQSAddRate := EditArmsQSAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsQSAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsQSAddValueMaxLimit := EditArmsQSAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsQSAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsQSAddValueRate := EditArmsQSAddValueRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsSCAddRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsSCAddRate := EditArmsSCAddRate.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsSCAddValueMaxLimitChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsSCAddValueMaxLimit := EditArmsSCAddValueMaxLimit.Value;
  ModValue();
{$IFEND}
end;

procedure TfrmFunctionConfig.EditArmsSCAddValueRateChange(Sender: TObject);
begin
{$IF M2Version <> 2}
  if not boOpened then Exit;
  g_Config.nArmsSCAddValueRate := EditArmsSCAddValueRate.Value;
  ModValue();
{$IFEND}
end;

end.
