unit ItemSet;

interface

uses
  Classes, Controls, Forms, ComCtrls, StdCtrls, Spin;

type
  TfrmItemSet = class(TForm)
    PageControl: TPageControl;
    TabSheet8: TTabSheet;
    ItemSetPageControl: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox141: TGroupBox;
    Label108: TLabel;
    Label109: TLabel;
    EditItemExpRate: TSpinEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    TabSheet2: TTabSheet;
    GroupBox142: TGroupBox;
    Label110: TLabel;
    Label3: TLabel;
    EditItemPowerRate: TSpinEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    ButtonItemSetSave: TButton;
    TabSheet9: TTabSheet;
    AddValuePageControl: TPageControl;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    ButtonAddValueSave: TButton;
    TabSheet17: TTabSheet;
    TabSheet18: TTabSheet;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    EditMonRandomAddValue: TSpinEdit;
    Label7: TLabel;
    EditMakeRandomAddValue: TSpinEdit;
    GroupBox4: TGroupBox;
    Label8: TLabel;
    EditWeaponDCAddValueMaxLimit: TSpinEdit;
    EditWeaponDCAddValueRate: TSpinEdit;
    Label9: TLabel;
    GroupBox5: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    EditWeaponMCAddValueMaxLimit: TSpinEdit;
    EditWeaponMCAddValueRate: TSpinEdit;
    GroupBox6: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    EditWeaponSCAddValueMaxLimit: TSpinEdit;
    EditWeaponSCAddValueRate: TSpinEdit;
    GroupBox7: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    EditDressDCAddValueMaxLimit: TSpinEdit;
    EditDressDCAddValueRate: TSpinEdit;
    GroupBox8: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    EditDressMCAddValueMaxLimit: TSpinEdit;
    EditDressMCAddValueRate: TSpinEdit;
    GroupBox9: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    EditDressSCAddValueMaxLimit: TSpinEdit;
    EditDressSCAddValueRate: TSpinEdit;
    EditDressDCAddRate: TSpinEdit;
    Label20: TLabel;
    EditDressMCAddRate: TSpinEdit;
    Label21: TLabel;
    Label22: TLabel;
    EditDressSCAddRate: TSpinEdit;
    GroupBox10: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    EditNeckLace19DCAddValueMaxLimit: TSpinEdit;
    EditNeckLace19DCAddValueRate: TSpinEdit;
    EditNeckLace19DCAddRate: TSpinEdit;
    GroupBox11: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    EditNeckLace19MCAddValueMaxLimit: TSpinEdit;
    EditNeckLace19MCAddValueRate: TSpinEdit;
    EditNeckLace19MCAddRate: TSpinEdit;
    GroupBox12: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    EditNeckLace19SCAddValueMaxLimit: TSpinEdit;
    EditNeckLace19SCAddValueRate: TSpinEdit;
    EditNeckLace19SCAddRate: TSpinEdit;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    GroupBox13: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    EditNeckLace202124DCAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124DCAddValueRate: TSpinEdit;
    EditNeckLace202124DCAddRate: TSpinEdit;
    GroupBox14: TGroupBox;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    EditNeckLace202124MCAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124MCAddValueRate: TSpinEdit;
    EditNeckLace202124MCAddRate: TSpinEdit;
    GroupBox15: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    EditNeckLace202124SCAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124SCAddValueRate: TSpinEdit;
    EditNeckLace202124SCAddRate: TSpinEdit;
    GroupBox16: TGroupBox;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    EditArmRing26MCAddValueMaxLimit: TSpinEdit;
    EditArmRing26MCAddValueRate: TSpinEdit;
    EditArmRing26MCAddRate: TSpinEdit;
    GroupBox17: TGroupBox;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    EditArmRing26DCAddValueMaxLimit: TSpinEdit;
    EditArmRing26DCAddValueRate: TSpinEdit;
    EditArmRing26DCAddRate: TSpinEdit;
    GroupBox18: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    EditArmRing26SCAddValueMaxLimit: TSpinEdit;
    EditArmRing26SCAddValueRate: TSpinEdit;
    EditArmRing26SCAddRate: TSpinEdit;
    Label54: TLabel;
    GroupBox19: TGroupBox;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    EditRing22DCAddValueMaxLimit: TSpinEdit;
    EditRing22DCAddValueRate: TSpinEdit;
    EditRing22DCAddRate: TSpinEdit;
    GroupBox20: TGroupBox;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    EditRing22SCAddValueMaxLimit: TSpinEdit;
    EditRing22SCAddValueRate: TSpinEdit;
    EditRing22SCAddRate: TSpinEdit;
    GroupBox21: TGroupBox;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    EditRing22MCAddValueMaxLimit: TSpinEdit;
    EditRing22MCAddValueRate: TSpinEdit;
    EditRing22MCAddRate: TSpinEdit;
    Label64: TLabel;
    GroupBox22: TGroupBox;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    EditRing23DCAddValueMaxLimit: TSpinEdit;
    EditRing23DCAddValueRate: TSpinEdit;
    EditRing23DCAddRate: TSpinEdit;
    GroupBox23: TGroupBox;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    EditRing23MCAddValueMaxLimit: TSpinEdit;
    EditRing23MCAddValueRate: TSpinEdit;
    EditRing23MCAddRate: TSpinEdit;
    GroupBox24: TGroupBox;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    EditRing23SCAddValueMaxLimit: TSpinEdit;
    EditRing23SCAddValueRate: TSpinEdit;
    EditRing23SCAddRate: TSpinEdit;
    Label74: TLabel;
    GroupBox25: TGroupBox;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    EditHelMetDCAddValueMaxLimit: TSpinEdit;
    EditHelMetDCAddValueRate: TSpinEdit;
    EditHelMetDCAddRate: TSpinEdit;
    GroupBox26: TGroupBox;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    EditHelMetMCAddValueMaxLimit: TSpinEdit;
    EditHelMetMCAddValueRate: TSpinEdit;
    EditHelMetMCAddRate: TSpinEdit;
    GroupBox27: TGroupBox;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    EditHelMetSCAddValueMaxLimit: TSpinEdit;
    EditHelMetSCAddValueRate: TSpinEdit;
    EditHelMetSCAddRate: TSpinEdit;
    Label84: TLabel;
    GroupBox28: TGroupBox;
    Label85: TLabel;
    Label86: TLabel;
    EditGuildRecallTime: TSpinEdit;
    GroupBox29: TGroupBox;
    Label87: TLabel;
    Label88: TLabel;
    TabSheet19: TTabSheet;
    PageControl1: TPageControl;
    TabSheet25: TTabSheet;
    TabSheet27: TTabSheet;
    GroupBox49: TGroupBox;
    Label152: TLabel;
    Label153: TLabel;
    EditUnknowRingDCAddRate: TSpinEdit;
    EditUnknowRingDCAddValueMaxLimit: TSpinEdit;
    GroupBox50: TGroupBox;
    Label155: TLabel;
    Label156: TLabel;
    EditUnknowRingMCAddRate: TSpinEdit;
    EditUnknowRingMCAddValueMaxLimit: TSpinEdit;
    GroupBox51: TGroupBox;
    Label158: TLabel;
    Label159: TLabel;
    EditUnknowRingSCAddRate: TSpinEdit;
    EditUnknowRingSCAddValueMaxLimit: TSpinEdit;
    GroupBox30: TGroupBox;
    Label89: TLabel;
    Label90: TLabel;
    EditUnknowRingACAddRate: TSpinEdit;
    EditUnknowRingACAddValueMaxLimit: TSpinEdit;
    GroupBox31: TGroupBox;
    Label91: TLabel;
    Label92: TLabel;
    EditUnknowRingMACAddRate: TSpinEdit;
    EditUnknowRingMACAddValueMaxLimit: TSpinEdit;
    ButtonUnKnowItemSave: TButton;
    GroupBox32: TGroupBox;
    Label93: TLabel;
    Label94: TLabel;
    EditUnknowNecklaceSCAddRate: TSpinEdit;
    EditUnknowNecklaceSCAddValueMaxLimit: TSpinEdit;
    GroupBox33: TGroupBox;
    Label95: TLabel;
    Label96: TLabel;
    EditUnknowNecklaceMACAddRate: TSpinEdit;
    EditUnknowNecklaceMACAddValueMaxLimit: TSpinEdit;
    GroupBox34: TGroupBox;
    Label97: TLabel;
    Label98: TLabel;
    EditUnknowNecklaceACAddRate: TSpinEdit;
    EditUnknowNecklaceACAddValueMaxLimit: TSpinEdit;
    GroupBox35: TGroupBox;
    Label99: TLabel;
    Label100: TLabel;
    EditUnknowNecklaceDCAddRate: TSpinEdit;
    EditUnknowNecklaceDCAddValueMaxLimit: TSpinEdit;
    GroupBox36: TGroupBox;
    Label101: TLabel;
    Label102: TLabel;
    EditUnknowNecklaceMCAddRate: TSpinEdit;
    EditUnknowNecklaceMCAddValueMaxLimit: TSpinEdit;
    TabSheet20: TTabSheet;
    GroupBox37: TGroupBox;
    Label103: TLabel;
    Label104: TLabel;
    EditUnknowHelMetSCAddRate: TSpinEdit;
    EditUnknowHelMetSCAddValueMaxLimit: TSpinEdit;
    GroupBox38: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    EditUnknowHelMetMCAddRate: TSpinEdit;
    EditUnknowHelMetMCAddValueMaxLimit: TSpinEdit;
    GroupBox39: TGroupBox;
    Label107: TLabel;
    Label111: TLabel;
    EditUnknowHelMetDCAddRate: TSpinEdit;
    EditUnknowHelMetDCAddValueMaxLimit: TSpinEdit;
    GroupBox40: TGroupBox;
    Label112: TLabel;
    Label113: TLabel;
    EditUnknowHelMetACAddRate: TSpinEdit;
    EditUnknowHelMetACAddValueMaxLimit: TSpinEdit;
    GroupBox41: TGroupBox;
    Label114: TLabel;
    Label115: TLabel;
    EditUnknowHelMetMACAddRate: TSpinEdit;
    EditUnknowHelMetMACAddValueMaxLimit: TSpinEdit;
    GroupBox44: TGroupBox;
    GroupBox45: TGroupBox;
    Label122: TLabel;
    Label123: TLabel;
    GroupBox43: TGroupBox;
    GroupBox46: TGroupBox;
    Label117: TLabel;
    Label118: TLabel;
    GroupBox47: TGroupBox;
    CheckBoxUserMoveCanDupObj: TCheckBox;
    CheckBoxUserMoveCanOnItem: TCheckBox;
    Label119: TLabel;
    EditUserMoveTime: TSpinEdit;
    Label121: TLabel;
    GroupBox48: TGroupBox;
    CheckBoxUnKnowHum: TCheckBox;
    Label125: TLabel;
    TabSheet21: TTabSheet;
    GroupBox52: TGroupBox;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    EditBootsSCAddValueMaxLimit: TSpinEdit;
    EditBootsSCAddValueRate: TSpinEdit;
    EditBootsSCAddRate: TSpinEdit;
    GroupBox53: TGroupBox;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    EditBootsDCAddValueMaxLimit: TSpinEdit;
    EditBootsDCAddValueRate: TSpinEdit;
    EditBootsDCAddRate: TSpinEdit;
    GroupBox54: TGroupBox;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    EditBootsMCAddValueMaxLimit: TSpinEdit;
    EditBootsMCAddValueRate: TSpinEdit;
    EditBootsMCAddRate: TSpinEdit;
    Label135: TLabel;
    Label136: TLabel;
    GroupBox55: TGroupBox;
    Label137: TLabel;
    Label138: TLabel;
    Label139: TLabel;
    EditBootsACAddValueMaxLimit: TSpinEdit;
    EditBootsACAddValueRate: TSpinEdit;
    EditBootsACAddRate: TSpinEdit;
    GroupBox56: TGroupBox;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    EditBootsMACAddValueMaxLimit: TSpinEdit;
    EditBootsMACAddValueRate: TSpinEdit;
    EditBootsMACAddRate: TSpinEdit;
    GroupBox57: TGroupBox;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    EditHelMetACAddValueMaxLimit: TSpinEdit;
    EditHelMetACAddValueRate: TSpinEdit;
    EditHelMetACAddRate: TSpinEdit;
    GroupBox58: TGroupBox;
    Label146: TLabel;
    Label147: TLabel;
    Label148: TLabel;
    EditHelMetMACAddValueMaxLimit: TSpinEdit;
    EditHelMetMACAddValueRate: TSpinEdit;
    EditHelMetMACAddRate: TSpinEdit;
    GroupBox59: TGroupBox;
    Label149: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    EditRing23ACAddValueMaxLimit: TSpinEdit;
    EditRing23ACAddValueRate: TSpinEdit;
    EditRing23ACAddRate: TSpinEdit;
    GroupBox60: TGroupBox;
    Label154: TLabel;
    Label157: TLabel;
    Label160: TLabel;
    EditRing23MACAddValueMaxLimit: TSpinEdit;
    EditRing23MACAddValueRate: TSpinEdit;
    EditRing23MACAddRate: TSpinEdit;
    GroupBox61: TGroupBox;
    Label161: TLabel;
    Label162: TLabel;
    Label163: TLabel;
    EditNeckLace19ACAddValueMaxLimit: TSpinEdit;
    EditNeckLace19ACAddValueRate: TSpinEdit;
    EditNeckLace19ACAddRate: TSpinEdit;
    GroupBox62: TGroupBox;
    Label164: TLabel;
    Label165: TLabel;
    Label166: TLabel;
    EditNeckLace19MACAddValueMaxLimit: TSpinEdit;
    EditNeckLace19MACAddValueRate: TSpinEdit;
    EditNeckLace19MACAddRate: TSpinEdit;
    GroupBox63: TGroupBox;
    Label167: TLabel;
    Label168: TLabel;
    Label169: TLabel;
    EditArmRing26ACAddValueMaxLimit: TSpinEdit;
    EditArmRing26ACAddValueRate: TSpinEdit;
    EditArmRing26ACAddRate: TSpinEdit;
    GroupBox64: TGroupBox;
    Label170: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    EditArmRing26MACAddValueMaxLimit: TSpinEdit;
    EditArmRing26MACAddValueRate: TSpinEdit;
    EditArmRing26MACAddRate: TSpinEdit;
    GroupBox65: TGroupBox;
    Label173: TLabel;
    Label174: TLabel;
    Label175: TLabel;
    EditNeckLace202124ACAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124ACAddValueRate: TSpinEdit;
    EditNeckLace202124ACAddRate: TSpinEdit;
    GroupBox66: TGroupBox;
    Label176: TLabel;
    Label177: TLabel;
    Label178: TLabel;
    EditNeckLace202124MACAddValueMaxLimit: TSpinEdit;
    EditNeckLace202124MACAddValueRate: TSpinEdit;
    EditNeckLace202124MACAddRate: TSpinEdit;
    GroupBox67: TGroupBox;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    EditDressACAddValueMaxLimit: TSpinEdit;
    EditDressACAddValueRate: TSpinEdit;
    EditDressACAddRate: TSpinEdit;
    GroupBox68: TGroupBox;
    Label182: TLabel;
    Label183: TLabel;
    Label184: TLabel;
    EditDressMACAddValueMaxLimit: TSpinEdit;
    EditDressMACAddValueRate: TSpinEdit;
    EditDressMACAddRate: TSpinEdit;
    Label185: TLabel;
    EditWeaponMCAddRate: TSpinEdit;
    Label186: TLabel;
    EditWeaponDCAddRate: TSpinEdit;
    Label187: TLabel;
    EditWeaponSCAddRate: TSpinEdit;
    Label188: TLabel;
    Label189: TLabel;
    EditPlayMonRandomAddValue: TSpinEdit;
    GroupBox69: TGroupBox;
    Label190: TLabel;
    Label191: TLabel;
    GroupBox70: TGroupBox;
    Label120: TLabel;
    EditAttackPosionRate: TSpinEdit;
    Label116: TLabel;
    EditAttackPosionTime: TSpinEdit;
    Label124: TLabel;
    GroupBox71: TGroupBox;
    Label194: TLabel;
    EditAttackPosionRate1: TSpinEdit;
    GroupBox72: TGroupBox;
    Label195: TLabel;
    EditAttackPosionRate2: TSpinEdit;
    Label192: TLabel;
    EditAttackPosionTime1: TSpinEdit;
    Label193: TLabel;
    EditAttackPosionTime2: TSpinEdit;
    TabSheet22: TTabSheet;
    Button1: TButton;
    GroupBox120: TGroupBox;
    Label241: TLabel;
    Label243: TLabel;
    Label244: TLabel;
    Label245: TLabel;
    SpinEditFirstOpen9Years: TSpinEdit;
    SpinEditSecondOpen9Years: TSpinEdit;
    SpinEditThreeOpen9Years: TSpinEdit;
    SpinEditFourOpen9Years: TSpinEdit;
    GroupBox42: TGroupBox;
    Label196: TLabel;
    Label197: TLabel;
    SpinEditFree9YearsBoxID: TSpinEdit;
    TabSheet23: TTabSheet;
    GroupBox73: TGroupBox;
    Label199: TLabel;
    EditRevivalTime: TSpinEdit;
    GroupBox74: TGroupBox;
    Label198: TLabel;
    EditRebirthTime: TSpinEdit;
    GroupBox75: TGroupBox;
    Label201: TLabel;
    CheckBoxRevivalTick: TCheckBox;
    CheckBoxRebirthTick: TCheckBox;
    GroupBox76: TGroupBox;
    Label200: TLabel;
    Label202: TLabel;
    EditAttackPosionRate3: TSpinEdit;
    EditAttackPosionTime3: TSpinEdit;
    GroupBox77: TGroupBox;
    CheckBoxUnderWarMove: TCheckBox;
    TabSheet24: TTabSheet;
    GroupBox78: TGroupBox;
    CheckBox1: TCheckBox;
    Label203: TLabel;
    procedure EditItemExpRateChange(Sender: TObject);
    procedure EditItemPowerRateChange(Sender: TObject);
    procedure ButtonItemSetSaveClick(Sender: TObject);
    procedure ButtonAddValueSaveClick(Sender: TObject);
    procedure EditMonRandomAddValueChange(Sender: TObject);
    procedure EditMakeRandomAddValueChange(Sender: TObject);
    procedure EditWeaponDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditWeaponDCAddValueRateChange(Sender: TObject);
    procedure EditWeaponMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditWeaponMCAddValueRateChange(Sender: TObject);
    procedure EditWeaponSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditWeaponSCAddValueRateChange(Sender: TObject);
    procedure EditDressDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressDCAddValueRateChange(Sender: TObject);
    procedure EditDressMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressMCAddValueRateChange(Sender: TObject);
    procedure EditDressSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressSCAddValueRateChange(Sender: TObject);
    procedure EditDressDCAddRateChange(Sender: TObject);
    procedure EditDressMCAddRateChange(Sender: TObject);
    procedure EditDressSCAddRateChange(Sender: TObject);
    procedure EditNeckLace19DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19DCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19DCAddRateChange(Sender: TObject);
    procedure EditNeckLace19SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19SCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19SCAddRateChange(Sender: TObject);
    procedure EditNeckLace19MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19MCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19MCAddRateChange(Sender: TObject);
    procedure EditNeckLace202124DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124DCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124DCAddRateChange(Sender: TObject);
    procedure EditNeckLace202124SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124SCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124SCAddRateChange(Sender: TObject);
    procedure EditNeckLace202124MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124MCAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124MCAddRateChange(Sender: TObject);
    procedure EditArmRing26DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26DCAddValueRateChange(Sender: TObject);
    procedure EditArmRing26DCAddRateChange(Sender: TObject);
    procedure EditArmRing26SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26SCAddValueRateChange(Sender: TObject);
    procedure EditArmRing26SCAddRateChange(Sender: TObject);
    procedure EditArmRing26MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26MCAddValueRateChange(Sender: TObject);
    procedure EditArmRing26MCAddRateChange(Sender: TObject);
    procedure EditRing22DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing22DCAddValueRateChange(Sender: TObject);
    procedure EditRing22DCAddRateChange(Sender: TObject);
    procedure EditRing22SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing22SCAddValueRateChange(Sender: TObject);
    procedure EditRing22SCAddRateChange(Sender: TObject);
    procedure EditRing22MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing22MCAddValueRateChange(Sender: TObject);
    procedure EditRing22MCAddRateChange(Sender: TObject);
    procedure EditRing23DCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23DCAddValueRateChange(Sender: TObject);
    procedure EditRing23DCAddRateChange(Sender: TObject);
    procedure EditRing23SCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23SCAddValueRateChange(Sender: TObject);
    procedure EditRing23SCAddRateChange(Sender: TObject);
    procedure EditRing23MCAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23MCAddValueRateChange(Sender: TObject);
    procedure EditRing23MCAddRateChange(Sender: TObject);
    procedure EditHelMetDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetDCAddValueRateChange(Sender: TObject);
    procedure EditHelMetDCAddRateChange(Sender: TObject);
    procedure EditHelMetSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetSCAddValueRateChange(Sender: TObject);
    procedure EditHelMetSCAddRateChange(Sender: TObject);
    procedure EditHelMetMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetMCAddValueRateChange(Sender: TObject);
    procedure EditHelMetMCAddRateChange(Sender: TObject);
    procedure EditGuildRecallTimeChange(Sender: TObject);
    procedure ButtonUnKnowItemSaveClick(Sender: TObject);
    procedure EditUnknowRingDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingDCAddRateChange(Sender: TObject);
    procedure EditUnknowRingMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingMCAddRateChange(Sender: TObject);
    procedure EditUnknowRingSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingSCAddRateChange(Sender: TObject);
    procedure EditUnknowRingACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingACAddRateChange(Sender: TObject);
    procedure EditUnknowRingMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowRingMACAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceDCAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceMCAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceSCAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceACAddRateChange(Sender: TObject);
    procedure EditUnknowNecklaceMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowNecklaceMACAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetDCAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetMCAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetSCAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetACAddRateChange(Sender: TObject);
    procedure EditUnknowHelMetMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditUnknowHelMetMACAddRateChange(Sender: TObject);
    procedure EditAttackPosionRateChange(Sender: TObject);
    procedure EditAttackPosionTimeChange(Sender: TObject);
    procedure CheckBoxUserMoveCanDupObjClick(Sender: TObject);
    procedure CheckBoxUserMoveCanOnItemClick(Sender: TObject);
    procedure EditUserMoveTimeChange(Sender: TObject);
    procedure CheckBoxUnKnowHumClick(Sender: TObject);
    procedure EditBootsDCAddValueMaxLimitChange(Sender: TObject);
    procedure EditBootsDCAddValueRateChange(Sender: TObject);
    procedure EditBootsDCAddRateChange(Sender: TObject);
    procedure EditBootsSCAddValueMaxLimitChange(Sender: TObject);
    procedure EditBootsSCAddValueRateChange(Sender: TObject);
    procedure EditBootsSCAddRateChange(Sender: TObject);
    procedure EditBootsMCAddValueMaxLimitChange(Sender: TObject);
    procedure EditBootsMCAddValueRateChange(Sender: TObject);
    procedure EditBootsMCAddRateChange(Sender: TObject);
    procedure EditBootsACAddValueMaxLimitChange(Sender: TObject);
    procedure EditBootsACAddValueRateChange(Sender: TObject);
    procedure EditBootsACAddRateChange(Sender: TObject);
    procedure EditBootsMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditBootsMACAddValueRateChange(Sender: TObject);
    procedure EditBootsMACAddRateChange(Sender: TObject);
    procedure EditHelMetACAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetACAddValueRateChange(Sender: TObject);
    procedure EditHelMetACAddRateChange(Sender: TObject);
    procedure EditHelMetMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditHelMetMACAddValueRateChange(Sender: TObject);
    procedure EditHelMetMACAddRateChange(Sender: TObject);
    procedure EditRing23ACAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23ACAddValueRateChange(Sender: TObject);
    procedure EditRing23ACAddRateChange(Sender: TObject);
    procedure EditRing23MACAddValueMaxLimitChange(Sender: TObject);
    procedure EditRing23MACAddValueRateChange(Sender: TObject);
    procedure EditRing23MACAddRateChange(Sender: TObject);
    procedure EditNeckLace19ACAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19ACAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19ACAddRateChange(Sender: TObject);
    procedure EditNeckLace19MACAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace19MACAddValueRateChange(Sender: TObject);
    procedure EditNeckLace19MACAddRateChange(Sender: TObject);
    procedure EditArmRing26ACAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26ACAddValueRateChange(Sender: TObject);
    procedure EditArmRing26ACAddRateChange(Sender: TObject);
    procedure EditArmRing26MACAddValueMaxLimitChange(Sender: TObject);
    procedure EditArmRing26MACAddValueRateChange(Sender: TObject);
    procedure EditArmRing26MACAddRateChange(Sender: TObject);
    procedure EditNeckLace202124ACAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124ACAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124ACAddRateChange(Sender: TObject);
    procedure EditNeckLace202124MACAddValueMaxLimitChange(Sender: TObject);
    procedure EditNeckLace202124MACAddValueRateChange(Sender: TObject);
    procedure EditNeckLace202124MACAddRateChange(Sender: TObject);
    procedure EditDressACAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressACAddValueRateChange(Sender: TObject);
    procedure EditDressACAddRateChange(Sender: TObject);
    procedure EditDressMACAddValueMaxLimitChange(Sender: TObject);
    procedure EditDressMACAddValueRateChange(Sender: TObject);
    procedure EditDressMACAddRateChange(Sender: TObject);
    procedure EditWeaponDCAddRateChange(Sender: TObject);
    procedure EditWeaponSCAddRateChange(Sender: TObject);
    procedure EditWeaponMCAddRateChange(Sender: TObject);
    procedure EditPlayMonRandomAddValueChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditAttackPosionTime1Change(Sender: TObject);
    procedure EditAttackPosionTime2Change(Sender: TObject);
    procedure EditAttackPosionRate1Change(Sender: TObject);
    procedure EditAttackPosionRate2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpinEditFirstOpen9YearsChange(Sender: TObject);
    procedure SpinEditSecondOpen9YearsChange(Sender: TObject);
    procedure SpinEditThreeOpen9YearsChange(Sender: TObject);
    procedure SpinEditFourOpen9YearsChange(Sender: TObject);
    procedure SpinEditFree9YearsBoxIDChange(Sender: TObject);
    procedure EditRevivalTimeChange(Sender: TObject);
    procedure EditRebirthTimeChange(Sender: TObject);
    procedure CheckBoxRevivalTickClick(Sender: TObject);
    procedure CheckBoxRebirthTickClick(Sender: TObject);
    procedure EditAttackPosionRate3Change(Sender: TObject);
    procedure EditAttackPosionTime3Change(Sender: TObject);
    procedure CheckBoxUnderWarMoveClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    boOpened: Boolean;
    boModValued: Boolean;
    procedure ModValue();
    procedure uModValue();
    procedure RefUnknowItem();
    procedure RefShapeItem();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmItemSet: TfrmItemSet;

implementation

uses M2Share;

{$R *.dfm}

{ TfrmItemSet }

procedure TfrmItemSet.ModValue;
begin
  boModValued := True;
  ButtonItemSetSave.Enabled := True;
  ButtonAddValueSave.Enabled := True;
  ButtonUnKnowItemSave.Enabled := True;
  Button1.Enabled := True;
end;

procedure TfrmItemSet.uModValue;
begin
  boModValued := False;
  ButtonItemSetSave.Enabled := False;
  ButtonAddValueSave.Enabled := False;
  ButtonUnKnowItemSave.Enabled := False;
  Button1.Enabled := False;
end;

procedure TfrmItemSet.Open;
begin
  boOpened := False;
  uModValue();

  EditItemExpRate.Value := g_Config.nItemExpRate;
  EditItemPowerRate.Value := g_Config.nItemPowerRate;

  EditMonRandomAddValue.Value := g_Config.nMonRandomAddValue;
  EditMakeRandomAddValue.Value := g_Config.nMakeRandomAddValue;
  EditPlayMonRandomAddValue.Value := g_Config.nPlayMonRandomAddValue;//人形身上装备极品机率 20080716

  EditWeaponDCAddValueMaxLimit.Value := g_Config.nWeaponDCAddValueMaxLimit;
  EditWeaponDCAddValueRate.Value := g_Config.nWeaponDCAddValueRate;
  EditWeaponMCAddValueMaxLimit.Value := g_Config.nWeaponMCAddValueMaxLimit;
  EditWeaponMCAddValueRate.Value := g_Config.nWeaponMCAddValueRate;
  EditWeaponSCAddValueMaxLimit.Value := g_Config.nWeaponSCAddValueMaxLimit;
  EditWeaponSCAddValueRate.Value := g_Config.nWeaponSCAddValueRate;
  EditWeaponDCAddRate.Value := g_Config.nWeaponDCAddRate;
  EditWeaponSCAddRate.Value := g_Config.nWeaponSCAddRate;
  EditWeaponMCAddRate.Value := g_Config.nWeaponMCAddRate;

  EditDressDCAddRate.Value := g_Config.nDressDCAddRate;
  EditDressDCAddValueMaxLimit.Value := g_Config.nDressDCAddValueMaxLimit;
  EditDressDCAddValueRate.Value := g_Config.nDressDCAddValueRate;
  EditDressMCAddRate.Value := g_Config.nDressMCAddRate;
  EditDressMCAddValueMaxLimit.Value := g_Config.nDressMCAddValueMaxLimit;
  EditDressMCAddValueRate.Value := g_Config.nDressMCAddValueRate;
  EditDressSCAddRate.Value := g_Config.nDressSCAddRate;
  EditDressSCAddValueMaxLimit.Value := g_Config.nDressSCAddValueMaxLimit;
  EditDressSCAddValueRate.Value := g_Config.nDressSCAddValueRate;
  EditDressACAddValueMaxLimit.Value := g_Config.nDressACAddValueMaxLimit;
  EditDressACAddValueRate.Value := g_Config.nDressACAddValueRate;
  EditDressACAddRate.Value := g_Config.nDressACAddRate;
  EditDressMACAddValueMaxLimit.Value := g_Config.nDressMACAddValueMaxLimit;
  EditDressMACAddValueRate.Value := g_Config.nDressMACAddValueRate;
  EditDressMACAddRate.Value := g_Config.nDressMACAddRate;

  EditNeckLace19DCAddRate.Value := g_Config.nNeckLace19DCAddRate;
  EditNeckLace19DCAddValueMaxLimit.Value := g_Config.nNeckLace19DCAddValueMaxLimit;
  EditNeckLace19DCAddValueRate.Value := g_Config.nNeckLace19DCAddValueRate;
  EditNeckLace19MCAddRate.Value := g_Config.nNeckLace19MCAddRate;
  EditNeckLace19MCAddValueMaxLimit.Value := g_Config.nNeckLace19MCAddValueMaxLimit;
  EditNeckLace19MCAddValueRate.Value := g_Config.nNeckLace19MCAddValueRate;
  EditNeckLace19SCAddRate.Value := g_Config.nNeckLace19SCAddRate;
  EditNeckLace19SCAddValueMaxLimit.Value := g_Config.nNeckLace19SCAddValueMaxLimit;
  EditNeckLace19SCAddValueRate.Value := g_Config.nNeckLace19SCAddValueRate;
  EditNeckLace19ACAddValueMaxLimit.Value := g_Config.nNeckLace19ACAddValueMaxLimit;
  EditNeckLace19ACAddValueRate.Value := g_Config.nNeckLace19ACAddValueRate;
  EditNeckLace19ACAddRate.Value := g_Config.nNeckLace19ACAddRate;
  EditNeckLace19MACAddValueMaxLimit.Value := g_Config.nNeckLace19MACAddValueMaxLimit;
  EditNeckLace19MACAddValueRate.Value := g_Config.nNeckLace19MACAddValueRate;
  EditNeckLace19MACAddRate.Value := g_Config.nNeckLace19MACAddRate;
  EditNeckLace202124DCAddRate.Value := g_Config.nNeckLace202124DCAddRate;
  EditNeckLace202124DCAddValueMaxLimit.Value := g_Config.nNeckLace202124DCAddValueMaxLimit;
  EditNeckLace202124DCAddValueRate.Value := g_Config.nNeckLace202124DCAddValueRate;
  EditNeckLace202124MCAddRate.Value := g_Config.nNeckLace202124MCAddRate;
  EditNeckLace202124MCAddValueMaxLimit.Value := g_Config.nNeckLace202124MCAddValueMaxLimit;
  EditNeckLace202124MCAddValueRate.Value := g_Config.nNeckLace202124MCAddValueRate;
  EditNeckLace202124SCAddRate.Value := g_Config.nNeckLace202124SCAddRate;
  EditNeckLace202124SCAddValueMaxLimit.Value := g_Config.nNeckLace202124SCAddValueMaxLimit;
  EditNeckLace202124SCAddValueRate.Value := g_Config.nNeckLace202124SCAddValueRate;
  EditNeckLace202124ACAddValueMaxLimit.Value := g_Config.nNeckLace202124ACAddValueMaxLimit;
  EditNeckLace202124ACAddValueRate.Value := g_Config.nNeckLace202124ACAddValueRate;
  EditNeckLace202124ACAddRate.Value := g_Config.nNeckLace202124ACAddRate;
  EditNeckLace202124MACAddValueMaxLimit.Value := g_Config.nNeckLace202124MACAddValueMaxLimit;
  EditNeckLace202124MACAddValueRate.Value := g_Config.nNeckLace202124MACAddValueRate;
  EditNeckLace202124MACAddRate.Value := g_Config.nNeckLace202124MACAddRate;
  EditArmRing26DCAddRate.Value := g_Config.nArmRing26DCAddRate;
  EditArmRing26DCAddValueMaxLimit.Value := g_Config.nArmRing26DCAddValueMaxLimit;
  EditArmRing26DCAddValueRate.Value := g_Config.nArmRing26DCAddValueRate;
  EditArmRing26MCAddRate.Value := g_Config.nArmRing26MCAddRate;
  EditArmRing26MCAddValueMaxLimit.Value := g_Config.nArmRing26MCAddValueMaxLimit;
  EditArmRing26MCAddValueRate.Value := g_Config.nArmRing26MCAddValueRate;
  EditArmRing26SCAddRate.Value := g_Config.nArmRing26SCAddRate;
  EditArmRing26SCAddValueMaxLimit.Value := g_Config.nArmRing26SCAddValueMaxLimit;
  EditArmRing26SCAddValueRate.Value := g_Config.nArmRing26SCAddValueRate;
  EditArmRing26ACAddValueMaxLimit.Value := g_Config.nArmRing26ACAddValueMaxLimit;
  EditArmRing26ACAddValueRate.Value := g_Config.nArmRing26ACAddValueRate;
  EditArmRing26ACAddRate.Value := g_Config.nArmRing26ACAddRate;
  EditArmRing26MACAddValueMaxLimit.Value := g_Config.nArmRing26MACAddValueMaxLimit;
  EditArmRing26MACAddValueRate.Value := g_Config.nArmRing26MACAddValueRate;
  EditArmRing26MACAddRate.Value := g_Config.nArmRing26MACAddRate;
  EditRing22DCAddRate.Value := g_Config.nRing22DCAddRate;
  EditRing22DCAddValueMaxLimit.Value := g_Config.nRing22DCAddValueMaxLimit;
  EditRing22DCAddValueRate.Value := g_Config.nRing22DCAddValueRate;
  EditRing22MCAddRate.Value := g_Config.nRing22MCAddRate;
  EditRing22MCAddValueMaxLimit.Value := g_Config.nRing22MCAddValueMaxLimit;
  EditRing22MCAddValueRate.Value := g_Config.nRing22MCAddValueRate;
  EditRing22SCAddRate.Value := g_Config.nRing22SCAddRate;
  EditRing22SCAddValueMaxLimit.Value := g_Config.nRing22SCAddValueMaxLimit;
  EditRing22SCAddValueRate.Value := g_Config.nRing22SCAddValueRate;

  EditRing23DCAddRate.Value := g_Config.nRing23DCAddRate;
  EditRing23DCAddValueMaxLimit.Value := g_Config.nRing23DCAddValueMaxLimit;
  EditRing23DCAddValueRate.Value := g_Config.nRing23DCAddValueRate;
  EditRing23MCAddRate.Value := g_Config.nRing23MCAddRate;
  EditRing23MCAddValueMaxLimit.Value := g_Config.nRing23MCAddValueMaxLimit;
  EditRing23MCAddValueRate.Value := g_Config.nRing23MCAddValueRate;
  EditRing23SCAddRate.Value := g_Config.nRing23SCAddRate;
  EditRing23SCAddValueMaxLimit.Value := g_Config.nRing23SCAddValueMaxLimit;
  EditRing23SCAddValueRate.Value := g_Config.nRing23SCAddValueRate;
  EditRing23ACAddValueMaxLimit.Value := g_Config.nRing23ACAddValueMaxLimit;
  EditRing23ACAddValueRate.Value := g_Config.nRing23ACAddValueRate;
  EditRing23ACAddRate.Value := g_Config.nRing23ACAddRate;
  EditRing23MACAddValueMaxLimit.Value := g_Config.nRing23MACAddValueMaxLimit;
  EditRing23MACAddValueRate.Value := g_Config.nRing23MACAddValueRate;
  EditRing23MACAddRate.Value := g_Config.nRing23MACAddRate;

  EditBootsDCAddValueMaxLimit.Value := g_Config.nBootsDCAddValueMaxLimit;//20080503 极品鞋子加攻最高点
  EditBootsDCAddValueRate.Value := g_Config.nBootsDCAddValueRate;
  EditBootsDCAddRate.Value := g_Config.nBootsDCAddRate;
  //道术
  EditBootsSCAddValueMaxLimit.Value := g_Config.nBootsSCAddValueMaxLimit;
  EditBootsSCAddValueRate.Value := g_Config.nBootsSCAddValueRate;
  EditBootsSCAddRate.Value := g_Config.nBootsSCAddRate;
  //魔法
  EditBootsMCAddValueMaxLimit.Value := g_Config.nBootsMCAddValueMaxLimit;
  EditBootsMCAddValueRate.Value := g_Config.nBootsMCAddValueRate;
  EditBootsMCAddRate.Value := g_Config.nBootsMCAddRate;
  //防御
  EditBootsACAddValueMaxLimit.Value := g_Config.nBootsACAddValueMaxLimit;
  EditBootsACAddValueRate.Value := g_Config.nBootsACAddValueRate;
  EditBootsACAddRate.Value := g_Config.nBootsACAddRate;
  //魔御
  EditBootsMACAddValueMaxLimit.Value := g_Config.nBootsMACAddValueMaxLimit;
  EditBootsMACAddValueRate.Value := g_Config.nBootsMACAddValueRate;
  EditBootsMACAddRate.Value := g_Config.nBootsMACAddRate;

  EditHelMetDCAddRate.Value := g_Config.nHelMetDCAddRate;
  EditHelMetDCAddValueMaxLimit.Value := g_Config.nHelMetDCAddValueMaxLimit;
  EditHelMetDCAddValueRate.Value := g_Config.nHelMetDCAddValueRate;
  EditHelMetMCAddRate.Value := g_Config.nHelMetMCAddRate;
  EditHelMetMCAddValueMaxLimit.Value := g_Config.nHelMetMCAddValueMaxLimit;
  EditHelMetMCAddValueRate.Value := g_Config.nHelMetMCAddValueRate;
  EditHelMetSCAddRate.Value := g_Config.nHelMetSCAddRate;
  EditHelMetSCAddValueMaxLimit.Value := g_Config.nHelMetSCAddValueMaxLimit;
  EditHelMetSCAddValueRate.Value := g_Config.nHelMetSCAddValueRate;
  EditHelMetACAddValueMaxLimit.Value := g_Config.nHelMetACAddValueMaxLimit;
  EditHelMetACAddValueRate.Value := g_Config.nHelMetACAddValueRate;
  EditHelMetACAddRate.Value := g_Config.nHelMetACAddRate;
  EditHelMetMACAddValueMaxLimit.Value := g_Config.nHelMetMACAddValueMaxLimit;
  EditHelMetMACAddValueRate.Value := g_Config.nHelMetMACAddValueRate;
  EditHelMetMACAddRate.Value := g_Config.nHelMetMACAddRate;
  CheckBoxUnKnowHum.Checked := g_Config.boUnKnowHum;//带上斗笠是否显示神秘人 20080424
  CheckBox1.Checked := g_Config.boOneRingXiXue;//
  EditGuildRecallTime.Value := g_Config.nGuildRecallTime;
  EditRevivalTime.value := g_Config.dwRevivalTime div 1000;//复活间隔时间 20100720
  EditRebirthTime.value := g_Config.dwRebirthTime div 1000;//重生间隔时间 20100720
  CheckBoxRevivalTick.Checked := g_Config.boStartRevivalTick;//是否登陆时初始复活计数 20100704
  CheckBoxRebirthTick.Checked := g_Config.boStartRebirthTick;//是否登陆时初始重生戒指计数 20100720
  CheckBoxUnderWarMove.Checked := g_Config.boUnderWarMove;

  RefUnknowItem();
  RefShapeItem();

  boOpened := True;
  PageControl.ActivePageIndex := 0;
  AddValuePageControl.ActivePageIndex := 0;
  ItemSetPageControl.ActivePageIndex := 0;

  //TabSheet22.TabVisible := False;//九周年宝箱页面
  ShowModal;
end;

procedure TfrmItemSet.ButtonItemSetSaveClick(Sender: TObject);
begin
{$IF SoftVersion <> VERDEMO}
  Config.WriteInteger('Setup', 'ItemPowerRate', g_Config.nItemPowerRate);
  Config.WriteInteger('Setup', 'ItemExpRate', g_Config.nItemExpRate);
  Config.WriteInteger('Setup', 'GuildRecallTime', g_Config.nGuildRecallTime);
  Config.WriteInteger('Setup', 'GroupRecallTime', g_Config.nGroupRecallTime);
  Config.WriteInteger('Setup', 'AttackPosionRate', g_Config.nAttackPosionRate);
  Config.WriteInteger('Setup', 'AttackPosionTime', g_Config.nAttackPosionTime);
  Config.WriteInteger('Setup', 'AttackPosionRate1', g_Config.nAttackPosionRate1);
  Config.WriteInteger('Setup', 'AttackPosionTime1', g_Config.nAttackPosionTime1);
  Config.WriteInteger('Setup', 'AttackPosionRate2', g_Config.nAttackPosionRate2);
  Config.WriteInteger('Setup', 'AttackPosionTime2', g_Config.nAttackPosionTime2);
  Config.WriteInteger('Setup', 'AttackPosionRate3', g_Config.nAttackPosionRate3);
  Config.WriteInteger('Setup', 'AttackPosionTime3', g_Config.nAttackPosionTime3);
  Config.WriteBool('Setup', 'UserMoveCanDupObj', g_Config.boUserMoveCanDupObj);
  Config.WriteBool('Setup', 'UserMoveCanOnItem', g_Config.boUserMoveCanOnItem);
  Config.WriteInteger('Setup', 'UserMoveTime', g_Config.dwUserMoveTime);
  Config.WriteBool('Setup', 'UnKnowHum', g_Config.boUnKnowHum);//带上斗笠是否显示神秘人 20080424
  Config.WriteBool('Setup', 'OneRingXiXue', g_Config.boOneRingXiXue);//带上斗笠是否显示神秘人 20080424
  Config.WriteInteger('Setup', 'RevivalTime', g_Config.dwRevivalTime);
  Config.WriteInteger('Setup', 'RebirthTime', g_Config.dwRebirthTime);//重生间隔时间 20100720
  Config.WriteBool('Setup', 'StartRevivalTick', g_Config.boStartRevivalTick);
  Config.WriteBool('Setup', 'StartRebirthTick', g_Config.boStartRebirthTick);
  Config.WriteBool('Setup', 'UnderWarMove', g_Config.boUnderWarMove);
{$IFEND}
  uModValue();
end;

procedure TfrmItemSet.EditItemExpRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nItemExpRate := EditItemExpRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditItemPowerRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nItemPowerRate := EditItemPowerRate.Value;
  ModValue();
end;

procedure TfrmItemSet.ButtonAddValueSaveClick(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'MonRandomAddValue', g_Config.nMonRandomAddValue);
  Config.WriteInteger('Setup', 'MakeRandomAddValue', g_Config.nMakeRandomAddValue);
  Config.WriteInteger('Setup', 'PlayMonRandomAddValue', g_Config.nPlayMonRandomAddValue);//人形身上装备极品机率 20080716
  Config.WriteInteger('Setup', 'WeaponDCAddValueMaxLimit', g_Config.nWeaponDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'WeaponDCAddValueRate', g_Config.nWeaponDCAddValueRate);
  Config.WriteInteger('Setup', 'WeaponMCAddValueMaxLimit', g_Config.nWeaponMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'WeaponMCAddValueRate', g_Config.nWeaponMCAddValueRate);
  Config.WriteInteger('Setup', 'WeaponSCAddValueMaxLimit', g_Config.nWeaponSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'WeaponSCAddValueRate', g_Config.nWeaponSCAddValueRate);
  Config.WriteInteger('Setup', 'WeaponDCAddRate', g_Config.nWeaponDCAddRate);
  Config.WriteInteger('Setup', 'WeaponSCAddRate', g_Config.nWeaponSCAddRate);
  Config.WriteInteger('Setup', 'WeaponMCAddRate', g_Config.nWeaponMCAddRate);

  Config.WriteInteger('Setup', 'DressDCAddRate', g_Config.nDressDCAddRate);
  Config.WriteInteger('Setup', 'DressDCAddValueMaxLimit', g_Config.nDressDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressDCAddValueRate', g_Config.nDressDCAddValueRate);
  Config.WriteInteger('Setup', 'DressMCAddRate', g_Config.nDressMCAddRate);
  Config.WriteInteger('Setup', 'DressMCAddValueMaxLimit', g_Config.nDressMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressMCAddValueRate', g_Config.nDressMCAddValueRate);
  Config.WriteInteger('Setup', 'DressSCAddRate', g_Config.nDressSCAddRate);
  Config.WriteInteger('Setup', 'DressSCAddValueMaxLimit', g_Config.nDressSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressSCAddValueRate', g_Config.nDressSCAddValueRate);
  Config.WriteInteger('Setup', 'DressACAddValueMaxLimit', g_Config.nDressACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressACAddValueRate', g_Config.nDressACAddValueRate);
  Config.WriteInteger('Setup', 'DressACAddRate', g_Config.nDressACAddRate);
  Config.WriteInteger('Setup', 'DressMACAddValueMaxLimit', g_Config.nDressMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'DressMACAddValueRate', g_Config.nDressMACAddValueRate);
  Config.WriteInteger('Setup', 'DressMACAddRate', g_Config.nDressMACAddRate);

  Config.WriteInteger('Setup', 'NeckLace19DCAddRate', g_Config.nNeckLace19DCAddRate);
  Config.WriteInteger('Setup', 'NeckLace19DCAddValueMaxLimit', g_Config.nNeckLace19DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19DCAddValueRate', g_Config.nNeckLace19DCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace19MCAddRate', g_Config.nNeckLace19MCAddRate);
  Config.WriteInteger('Setup', 'NeckLace19MCAddValueMaxLimit', g_Config.nNeckLace19MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19MCAddValueRate', g_Config.nNeckLace19MCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace19SCAddRate', g_Config.nNeckLace19SCAddRate);
  Config.WriteInteger('Setup', 'NeckLace19SCAddValueMaxLimit', g_Config.nNeckLace19SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19SCAddValueRate', g_Config.nNeckLace19SCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace19ACAddValueMaxLimit', g_Config.nNeckLace19ACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19ACAddValueRate', g_Config.nNeckLace19ACAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace19ACAddRate', g_Config.nNeckLace19ACAddRate);
  Config.WriteInteger('Setup', 'NeckLace19MACAddValueMaxLimit', g_Config.nNeckLace19MACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace19MACAddValueRate', g_Config.nNeckLace19MACAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace19MACAddRate', g_Config.nNeckLace19MACAddRate);

  Config.WriteInteger('Setup', 'NeckLace202124DCAddRate', g_Config.nNeckLace202124DCAddRate);
  Config.WriteInteger('Setup', 'NeckLace202124DCAddValueMaxLimit', g_Config.nNeckLace202124DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124DCAddValueRate', g_Config.nNeckLace202124DCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace202124MCAddRate', g_Config.nNeckLace202124MCAddRate);
  Config.WriteInteger('Setup', 'NeckLace202124MCAddValueMaxLimit', g_Config.nNeckLace202124MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124MCAddValueRate', g_Config.nNeckLace202124MCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace202124SCAddRate', g_Config.nNeckLace202124SCAddRate);
  Config.WriteInteger('Setup', 'NeckLace202124SCAddValueMaxLimit', g_Config.nNeckLace202124SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124SCAddValueRate', g_Config.nNeckLace202124SCAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace202124ACAddValueMaxLimit', g_Config.nNeckLace202124ACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124ACAddValueRate', g_Config.nNeckLace202124ACAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace202124ACAddRate', g_Config.nNeckLace202124ACAddRate);
  Config.WriteInteger('Setup', 'NeckLace202124MACAddValueMaxLimit', g_Config.nNeckLace202124MACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'NeckLace202124MACAddValueRate', g_Config.nNeckLace202124MACAddValueRate);
  Config.WriteInteger('Setup', 'NeckLace202124MACAddRate', g_Config.nNeckLace202124MACAddRate);

  Config.WriteInteger('Setup', 'Ring22DCAddValueMaxLimit', g_Config.nRing22DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring22DCAddValueRate', g_Config.nRing22DCAddValueRate);
  Config.WriteInteger('Setup', 'Ring22DCAddRate', g_Config.nRing22DCAddRate);
  Config.WriteInteger('Setup', 'Ring22MCAddValueMaxLimit', g_Config.nRing22MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring22MCAddValueRate', g_Config.nRing22MCAddValueRate);
  Config.WriteInteger('Setup', 'Ring22MCAddRate', g_Config.nRing22MCAddRate);
  Config.WriteInteger('Setup', 'Ring22SCAddValueMaxLimit', g_Config.nRing22SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring22SCAddValueRate', g_Config.nRing22SCAddValueRate);
  Config.WriteInteger('Setup', 'Ring22SCAddRate', g_Config.nRing22SCAddRate);

  Config.WriteInteger('Setup', 'ArmRing26DCAddRate', g_Config.nArmRing26DCAddRate);
  Config.WriteInteger('Setup', 'ArmRing26DCAddValueMaxLimit', g_Config.nArmRing26DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26DCAddValueRate', g_Config.nArmRing26DCAddValueRate);
  Config.WriteInteger('Setup', 'ArmRing26MCAddRate', g_Config.nArmRing26MCAddRate);
  Config.WriteInteger('Setup', 'ArmRing26MCAddValueMaxLimit', g_Config.nArmRing26MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26MCAddValueRate', g_Config.nArmRing26MCAddValueRate);
  Config.WriteInteger('Setup', 'ArmRing26SCAddRate', g_Config.nArmRing26SCAddRate);
  Config.WriteInteger('Setup', 'ArmRing26SCAddValueMaxLimit', g_Config.nArmRing26SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26SCAddValueRate', g_Config.nArmRing26SCAddValueRate);
  Config.WriteInteger('Setup', 'ArmRing26ACAddValueMaxLimit', g_Config.nArmRing26ACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26ACAddValueRate', g_Config.nArmRing26ACAddValueRate);
  Config.WriteInteger('Setup', 'ArmRing26ACAddRate', g_Config.nArmRing26ACAddRate);
  Config.WriteInteger('Setup', 'ArmRing26MACAddValueMaxLimit', g_Config.nArmRing26MACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'ArmRing26MACAddValueRate', g_Config.nArmRing26MACAddValueRate);
  Config.WriteInteger('Setup', 'ArmRing26MACAddRate', g_Config.nArmRing26MACAddRate);

  Config.WriteInteger('Setup', 'Ring23DCAddRate', g_Config.nRing23DCAddRate);
  Config.WriteInteger('Setup', 'Ring23DCAddValueMaxLimit', g_Config.nRing23DCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23DCAddValueRate', g_Config.nRing23DCAddValueRate);
  Config.WriteInteger('Setup', 'Ring23MCAddRate', g_Config.nRing23MCAddRate);
  Config.WriteInteger('Setup', 'Ring23MCAddValueMaxLimit', g_Config.nRing23MCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23MCAddValueRate', g_Config.nRing23MCAddValueRate);
  Config.WriteInteger('Setup', 'Ring23SCAddRate', g_Config.nRing23SCAddRate);
  Config.WriteInteger('Setup', 'Ring23SCAddValueMaxLimit', g_Config.nRing23SCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23SCAddValueRate', g_Config.nRing23SCAddValueRate);
  Config.WriteInteger('Setup', 'Ring23ACAddValueMaxLimit', g_Config.nRing23ACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23ACAddValueRate', g_Config.nRing23ACAddValueRate);
  Config.WriteInteger('Setup', 'Ring23ACAddRate', g_Config.nRing23ACAddRate);
  Config.WriteInteger('Setup', 'Ring23MACAddValueMaxLimit', g_Config.nRing23MACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'Ring23MACAddValueRate', g_Config.nRing23MACAddValueRate);
  Config.WriteInteger('Setup', 'Ring23MACAddRate', g_Config.nRing23MACAddRate);

  Config.WriteInteger('Setup', 'BootsDCAddValueMaxLimit', g_Config.nBootsDCAddValueMaxLimit);//20080503 极品鞋子加攻最高点
  Config.WriteInteger('Setup', 'BootsDCAddValueRate', g_Config.nBootsDCAddValueRate);
  Config.WriteInteger('Setup', 'BootsDCAddRate', g_Config.nBootsDCAddRate);
  //极品鞋子加道术
  Config.WriteInteger('Setup', 'BootsSCAddValueMaxLimit', g_Config.nBootsSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BootsSCAddValueRate', g_Config.nBootsSCAddValueRate);
  Config.WriteInteger('Setup', 'BootsSCAddRate', g_Config.nBootsSCAddRate);
  //极品鞋子加魔法
  Config.WriteInteger('Setup', 'BootsMCAddValueMaxLimit', g_Config.nBootsMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BootsMCAddValueRate', g_Config.nBootsMCAddValueRate);
  Config.WriteInteger('Setup', 'BootsMCAddRate', g_Config.nBootsMCAddRate);
  //极品鞋子加防御
  Config.WriteInteger('Setup', 'BootsACAddValueMaxLimit', g_Config.nBootsACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BootsACAddValueRate', g_Config.nBootsACAddValueRate);
  Config.WriteInteger('Setup', 'BootsACAddRate', g_Config.nBootsACAddRate);
  //极品鞋子加魔御
  Config.WriteInteger('Setup', 'BootsMACAddValueMaxLimit', g_Config.nBootsMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'BootsMACAddValueRate', g_Config.nBootsMACAddValueRate);
  Config.WriteInteger('Setup', 'BootsMACAddRate', g_Config.nBootsMACAddRate);

  Config.WriteInteger('Setup', 'HelMetDCAddRate', g_Config.nHelMetDCAddRate);
  Config.WriteInteger('Setup', 'HelMetDCAddValueMaxLimit', g_Config.nHelMetDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetDCAddValueRate', g_Config.nHelMetDCAddValueRate);
  Config.WriteInteger('Setup', 'HelMetMCAddRate', g_Config.nHelMetMCAddRate);
  Config.WriteInteger('Setup', 'HelMetMCAddValueMaxLimit', g_Config.nHelMetMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetMCAddValueRate', g_Config.nHelMetMCAddValueRate);
  Config.WriteInteger('Setup', 'HelMetSCAddRate', g_Config.nHelMetSCAddRate);
  Config.WriteInteger('Setup', 'HelMetSCAddValueMaxLimit', g_Config.nHelMetSCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetSCAddValueRate', g_Config.nHelMetSCAddValueRate);
  Config.WriteInteger('Setup', 'HelMetACAddValueMaxLimit', g_Config.nHelMetACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetACAddValueRate', g_Config.nHelMetACAddValueRate);
  Config.WriteInteger('Setup', 'HelMetACAddRate', g_Config.nHelMetACAddRate);
  Config.WriteInteger('Setup', 'HelMetMACAddValueMaxLimit', g_Config.nHelMetMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'HelMetMACAddValueRate', g_Config.nHelMetMACAddValueRate);
  Config.WriteInteger('Setup', 'HelMetMACAddRate', g_Config.nHelMetMACAddRate);
  uModValue();
end;

procedure TfrmItemSet.EditMonRandomAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMonRandomAddValue := EditMonRandomAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.EditMakeRandomAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nMakeRandomAddValue := EditMakeRandomAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponDCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponDCAddValueMaxLimit := EditWeaponDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponDCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponDCAddValueRate := EditWeaponDCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponMCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponMCAddValueMaxLimit := EditWeaponMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponMCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponMCAddValueRate := EditWeaponMCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponSCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponSCAddValueMaxLimit := EditWeaponSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponSCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponSCAddValueRate := EditWeaponSCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressDCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressDCAddValueMaxLimit := EditDressDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressDCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressDCAddValueRate := EditDressDCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMCAddValueMaxLimit := EditDressMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMCAddValueRate := EditDressMCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressSCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressSCAddValueMaxLimit := EditDressSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressSCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressSCAddValueRate := EditDressSCAddValueRate.Value;
  ModValue();
end;
procedure TfrmItemSet.EditDressDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressDCAddRate := EditDressDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMCAddRate := EditDressMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressSCAddRate := EditDressSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19DCAddValueMaxLimit := EditNeckLace19DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19DCAddValueRate := EditNeckLace19DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MCAddValueMaxLimit := EditNeckLace19MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MCAddValueRate := EditNeckLace19MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19SCAddValueMaxLimit := EditNeckLace19SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19SCAddValueRate := EditNeckLace19SCAddValueRate.Value;
  ModValue();
end;
procedure TfrmItemSet.EditNeckLace19DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19DCAddRate := EditNeckLace19DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MCAddRate := EditNeckLace19MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19SCAddRate := EditNeckLace19SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124DCAddValueMaxLimit := EditNeckLace202124DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124DCAddValueRate := EditNeckLace202124DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MCAddValueMaxLimit := EditNeckLace202124MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MCAddValueRate := EditNeckLace202124MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124SCAddValueMaxLimit := EditNeckLace202124SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124SCAddValueRate := EditNeckLace202124SCAddValueRate.Value;
  ModValue();
end;
procedure TfrmItemSet.EditNeckLace202124DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124DCAddRate := EditNeckLace202124DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MCAddRate := EditNeckLace202124MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124SCAddRate := EditNeckLace202124SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26DCAddValueMaxLimit := EditArmRing26DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26DCAddValueRate := EditArmRing26DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MCAddValueMaxLimit := EditArmRing26MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MCAddValueRate := EditArmRing26MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26SCAddValueMaxLimit := EditArmRing26SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26SCAddValueRate := EditArmRing26SCAddValueRate.Value;
  ModValue();
end;
procedure TfrmItemSet.EditArmRing26DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26DCAddRate := EditArmRing26DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MCAddRate := EditArmRing26MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26SCAddRate := EditArmRing26SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22DCAddValueMaxLimit := EditRing22DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22DCAddValueRate := EditRing22DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22MCAddValueMaxLimit := EditRing22MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22MCAddValueRate := EditRing22MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22SCAddValueMaxLimit := EditRing22SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22SCAddValueRate := EditRing22SCAddValueRate.Value;
  ModValue();
end;
procedure TfrmItemSet.EditRing22DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22DCAddRate := EditRing22DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22MCAddRate := EditRing22MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing22SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing22SCAddRate := EditRing22SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23DCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23DCAddValueMaxLimit := EditRing23DCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23DCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23DCAddValueRate := EditRing23DCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MCAddValueMaxLimit := EditRing23MCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MCAddValueRate := EditRing23MCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23SCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23SCAddValueMaxLimit := EditRing23SCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23SCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23SCAddValueRate := EditRing23SCAddValueRate.Value;
  ModValue();
end;
procedure TfrmItemSet.EditRing23DCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23DCAddRate := EditRing23DCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MCAddRate := EditRing23MCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23SCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23SCAddRate := EditRing23SCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetDCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetDCAddValueMaxLimit := EditHelMetDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetDCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetDCAddValueRate := EditHelMetDCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMCAddValueMaxLimit := EditHelMetMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMCAddValueRate := EditHelMetMCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetSCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetSCAddValueMaxLimit := EditHelMetSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetSCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetSCAddValueRate := EditHelMetSCAddValueRate.Value;
  ModValue();
end;
procedure TfrmItemSet.EditHelMetDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetDCAddRate := EditHelMetDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMCAddRate := EditHelMetMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetSCAddRate := EditHelMetSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditGuildRecallTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nGuildRecallTime := EditGuildRecallTime.Value;
  ModValue();
end;

procedure TfrmItemSet.ButtonUnKnowItemSaveClick(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'UnknowRingACAddRate', g_Config.nUnknowRingACAddRate);
  Config.WriteInteger('Setup', 'UnknowRingACAddValueMaxLimit', g_Config.nUnknowRingACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowRingMACAddRate', g_Config.nUnknowRingMACAddRate);
  Config.WriteInteger('Setup', 'UnknowRingMACAddValueMaxLimit', g_Config.nUnknowRingMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowRingDCAddRate', g_Config.nUnknowRingDCAddRate);
  Config.WriteInteger('Setup', 'UnknowRingDCAddValueMaxLimit', g_Config.nUnknowRingDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowRingMCAddRate', g_Config.nUnknowRingMCAddRate);
  Config.WriteInteger('Setup', 'UnknowRingMCAddValueMaxLimit', g_Config.nUnknowRingMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowRingSCAddRate', g_Config.nUnknowRingSCAddRate);
  Config.WriteInteger('Setup', 'UnknowRingSCAddValueMaxLimit', g_Config.nUnknowRingSCAddValueMaxLimit);

  Config.WriteInteger('Setup', 'UnknowNecklaceACAddRate', g_Config.nUnknowNecklaceACAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceACAddValueMaxLimit', g_Config.nUnknowNecklaceACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowNecklaceMACAddRate', g_Config.nUnknowNecklaceMACAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceMACAddValueMaxLimit', g_Config.nUnknowNecklaceMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowNecklaceDCAddRate', g_Config.nUnknowNecklaceDCAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceDCAddValueMaxLimit', g_Config.nUnknowNecklaceDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowNecklaceMCAddRate', g_Config.nUnknowNecklaceMCAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceMCAddValueMaxLimit', g_Config.nUnknowNecklaceMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowNecklaceSCAddRate', g_Config.nUnknowNecklaceSCAddRate);
  Config.WriteInteger('Setup', 'UnknowNecklaceSCAddValueMaxLimit', g_Config.nUnknowNecklaceSCAddValueMaxLimit);

  Config.WriteInteger('Setup', 'UnknowHelMetACAddRate', g_Config.nUnknowHelMetACAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetACAddValueMaxLimit', g_Config.nUnknowHelMetACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowHelMetMACAddRate', g_Config.nUnknowHelMetMACAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetMACAddValueMaxLimit', g_Config.nUnknowHelMetMACAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowHelMetDCAddRate', g_Config.nUnknowHelMetDCAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetDCAddValueMaxLimit', g_Config.nUnknowHelMetDCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowHelMetMCAddRate', g_Config.nUnknowHelMetMCAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetMCAddValueMaxLimit', g_Config.nUnknowHelMetMCAddValueMaxLimit);
  Config.WriteInteger('Setup', 'UnknowHelMetSCAddRate', g_Config.nUnknowHelMetSCAddRate);
  Config.WriteInteger('Setup', 'UnknowHelMetSCAddValueMaxLimit', g_Config.nUnknowHelMetSCAddValueMaxLimit);
  uModValue();
end;

procedure TfrmItemSet.RefUnknowItem;
begin
  EditUnknowRingDCAddValueMaxLimit.Value := g_Config.nUnknowRingDCAddValueMaxLimit;
  EditUnknowRingDCAddRate.Value := g_Config.nUnknowRingDCAddRate;
  EditUnknowRingMCAddValueMaxLimit.Value := g_Config.nUnknowRingMCAddValueMaxLimit;
  EditUnknowRingMCAddRate.Value := g_Config.nUnknowRingMCAddRate;
  EditUnknowRingSCAddValueMaxLimit.Value := g_Config.nUnknowRingSCAddValueMaxLimit;
  EditUnknowRingSCAddRate.Value := g_Config.nUnknowRingSCAddRate;
  EditUnknowRingACAddValueMaxLimit.Value := g_Config.nUnknowRingACAddValueMaxLimit;
  EditUnknowRingACAddRate.Value := g_Config.nUnknowRingACAddRate;
  EditUnknowRingMACAddValueMaxLimit.Value := g_Config.nUnknowRingMACAddValueMaxLimit;
  EditUnknowRingMACAddRate.Value := g_Config.nUnknowRingMACAddRate;

  EditUnknowNecklaceDCAddValueMaxLimit.Value := g_Config.nUnknowNecklaceDCAddValueMaxLimit;
  EditUnknowNecklaceDCAddRate.Value := g_Config.nUnknowNecklaceDCAddRate;
  EditUnknowNecklaceMCAddValueMaxLimit.Value := g_Config.nUnknowNecklaceMCAddValueMaxLimit;
  EditUnknowNecklaceMCAddRate.Value := g_Config.nUnknowNecklaceMCAddRate;
  EditUnknowNecklaceSCAddValueMaxLimit.Value := g_Config.nUnknowNecklaceSCAddValueMaxLimit;
  EditUnknowNecklaceSCAddRate.Value := g_Config.nUnknowNecklaceSCAddRate;
  EditUnknowNecklaceACAddValueMaxLimit.Value := g_Config.nUnknowNecklaceACAddValueMaxLimit;
  EditUnknowNecklaceACAddRate.Value := g_Config.nUnknowNecklaceACAddRate;
  EditUnknowNecklaceMACAddValueMaxLimit.Value := g_Config.nUnknowNecklaceMACAddValueMaxLimit;
  EditUnknowNecklaceMACAddRate.Value := g_Config.nUnknowNecklaceMACAddRate;

  EditUnknowHelMetDCAddValueMaxLimit.Value := g_Config.nUnknowHelMetDCAddValueMaxLimit;
  EditUnknowHelMetDCAddRate.Value := g_Config.nUnknowHelMetDCAddRate;
  EditUnknowHelMetMCAddValueMaxLimit.Value := g_Config.nUnknowHelMetMCAddValueMaxLimit;
  EditUnknowHelMetMCAddRate.Value := g_Config.nUnknowHelMetMCAddRate;
  EditUnknowHelMetSCAddValueMaxLimit.Value := g_Config.nUnknowHelMetSCAddValueMaxLimit;
  EditUnknowHelMetSCAddRate.Value := g_Config.nUnknowHelMetSCAddRate;
  EditUnknowHelMetACAddValueMaxLimit.Value := g_Config.nUnknowHelMetACAddValueMaxLimit;
  EditUnknowHelMetACAddRate.Value := g_Config.nUnknowHelMetACAddRate;
  EditUnknowHelMetMACAddValueMaxLimit.Value := g_Config.nUnknowHelMetMACAddValueMaxLimit;
  EditUnknowHelMetMACAddRate.Value := g_Config.nUnknowHelMetMACAddRate;
end;


procedure TfrmItemSet.EditUnknowRingDCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingDCAddValueMaxLimit := EditUnknowRingDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingDCAddRate := EditUnknowRingDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingMCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingMCAddValueMaxLimit := EditUnknowRingMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingMCAddRate := EditUnknowRingMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingSCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingSCAddValueMaxLimit := EditUnknowRingSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingSCAddRate := EditUnknowRingSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingACAddValueMaxLimit := EditUnknowRingACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingACAddRate := EditUnknowRingACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingMACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingMACAddValueMaxLimit := EditUnknowRingMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowRingMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowRingMACAddRate := EditUnknowRingMACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceDCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceDCAddValueMaxLimit := EditUnknowNecklaceDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceDCAddRate := EditUnknowNecklaceDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceMCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceMCAddValueMaxLimit := EditUnknowNecklaceMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceMCAddRate := EditUnknowNecklaceMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceSCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceSCAddValueMaxLimit := EditUnknowNecklaceSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceSCAddRate := EditUnknowNecklaceSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceACAddValueMaxLimit := EditUnknowNecklaceACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceACAddRate := EditUnknowNecklaceACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceMACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceMACAddValueMaxLimit := EditUnknowNecklaceMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowNecklaceMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowNecklaceMACAddRate := EditUnknowNecklaceMACAddRate.Value;
  ModValue();
end;


procedure TfrmItemSet.EditUnknowHelMetDCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetDCAddValueMaxLimit := EditUnknowHelMetDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetDCAddRate := EditUnknowHelMetDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetMCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetMCAddValueMaxLimit := EditUnknowHelMetMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetMCAddRate := EditUnknowHelMetMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetSCAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetSCAddValueMaxLimit := EditUnknowHelMetSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetSCAddRate := EditUnknowHelMetSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetACAddValueMaxLimit := EditUnknowHelMetACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetACAddRate := EditUnknowHelMetACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetMACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetMACAddValueMaxLimit := EditUnknowHelMetMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditUnknowHelMetMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nUnknowHelMetMACAddRate := EditUnknowHelMetMACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.RefShapeItem;
begin
  EditAttackPosionRate.Value := g_Config.nAttackPosionRate;
  EditAttackPosionTime.Value := g_Config.nAttackPosionTime;
  EditAttackPosionRate1.Value := g_Config.nAttackPosionRate1;
  EditAttackPosionTime1.Value := g_Config.nAttackPosionTime1;
  EditAttackPosionRate2.Value := g_Config.nAttackPosionRate2;
  EditAttackPosionTime2.Value := g_Config.nAttackPosionTime2;
  EditAttackPosionRate3.Value := g_Config.nAttackPosionRate3;
  EditAttackPosionTime3.Value := g_Config.nAttackPosionTime3;
  CheckBoxUserMoveCanDupObj.Checked := g_Config.boUserMoveCanDupObj;
  CheckBoxUserMoveCanOnItem.Checked := g_Config.boUserMoveCanOnItem;
  EditUserMoveTime.Value := g_Config.dwUserMoveTime;

  SpinEditFree9YearsBoxID.Value := g_Config.nFree9YearsBoxID;
  SpinEditFirstOpen9Years.Value := g_Config.nFirstOpen9Years;
  SpinEditSecondOpen9Years.Value := g_Config.nSecondOpen9Years;
  SpinEditThreeOpen9Years.Value := g_Config.nThreeOpen9Years;
  SpinEditFourOpen9Years.Value := g_Config.nFourOpen9Years;
end;

procedure TfrmItemSet.EditAttackPosionRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionRate := EditAttackPosionRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditAttackPosionTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionTime := EditAttackPosionTime.Value;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxUserMoveCanDupObjClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boUserMoveCanDupObj := CheckBoxUserMoveCanDupObj.Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxUserMoveCanOnItemClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boUserMoveCanOnItem := CheckBoxUserMoveCanOnItem.Checked;
  ModValue();
end;

procedure TfrmItemSet.EditUserMoveTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwUserMoveTime := EditUserMoveTime.Value;
  ModValue();
end;

//带上斗笠是否显示神秘人 20080424
procedure TfrmItemSet.CheckBoxUnderWarMoveClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boUnderWarMove := CheckBoxUnderWarMove.Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxUnKnowHumClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boUnKnowHum := CheckBoxUnKnowHum.Checked;
  ModValue();
end;
//20080503 极品鞋子加攻最高点
procedure TfrmItemSet.EditBootsDCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsDCAddValueMaxLimit := EditBootsDCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsDCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsDCAddValueRate := EditBootsDCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsDCAddRate := EditBootsDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsSCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsSCAddValueMaxLimit := EditBootsSCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsSCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsSCAddValueRate := EditBootsSCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsSCAddRate := EditBootsSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsMCAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsMCAddValueMaxLimit := EditBootsMCAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsMCAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsMCAddValueRate := EditBootsMCAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsMCAddRate := EditBootsMCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsACAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsACAddValueMaxLimit := EditBootsACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsACAddValueRate := EditBootsACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsACAddRate := EditBootsACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsMACAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsMACAddValueMaxLimit := EditBootsMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsMACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsMACAddValueRate := EditBootsMACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditBootsMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nBootsMACAddRate := EditBootsMACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetACAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetACAddValueMaxLimit := EditHelMetACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetACAddValueRate := EditHelMetACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetACAddRate := EditHelMetACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMACAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMACAddValueMaxLimit := EditHelMetMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMACAddValueRate := EditHelMetMACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditHelMetMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nHelMetMACAddRate := EditHelMetMACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23ACAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23ACAddValueMaxLimit := EditRing23ACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23ACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23ACAddValueRate := EditRing23ACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23ACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23ACAddRate := EditRing23ACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MACAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MACAddValueMaxLimit := EditRing23MACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MACAddValueRate := EditRing23MACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRing23MACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nRing23MACAddRate := EditRing23MACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19ACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19ACAddValueMaxLimit := EditNeckLace19ACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19ACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19ACAddValueRate := EditNeckLace19ACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19ACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19ACAddRate := EditNeckLace19ACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MACAddValueMaxLimit := EditNeckLace19MACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MACAddValueRate := EditNeckLace19MACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace19MACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace19MACAddRate := EditNeckLace19MACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26ACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26ACAddValueMaxLimit := EditArmRing26ACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26ACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26ACAddValueRate := EditArmRing26ACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26ACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26ACAddRate := EditArmRing26ACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MACAddValueMaxLimit := EditArmRing26MACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MACAddValueRate := EditArmRing26MACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditArmRing26MACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nArmRing26MACAddRate := EditArmRing26MACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124ACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124ACAddValueMaxLimit := EditNeckLace202124ACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124ACAddValueRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124ACAddValueRate := EditNeckLace202124ACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124ACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124ACAddRate := EditNeckLace202124ACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MACAddValueMaxLimitChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MACAddValueMaxLimit := EditNeckLace202124MACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MACAddValueRateChange(
  Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MACAddValueRate := EditNeckLace202124MACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditNeckLace202124MACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nNeckLace202124MACAddRate := EditNeckLace202124MACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressACAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressACAddValueMaxLimit := EditDressACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressACAddValueRate := EditDressACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressACAddRate := EditDressACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMACAddValueMaxLimitChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMACAddValueMaxLimit := EditDressMACAddValueMaxLimit.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMACAddValueRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMACAddValueRate := EditDressMACAddValueRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditDressMACAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nDressMACAddRate := EditDressMACAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponDCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponDCAddRate := EditWeaponDCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponSCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponSCAddRate := EditWeaponSCAddRate.Value;
  ModValue();
end;

procedure TfrmItemSet.EditWeaponMCAddRateChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nWeaponMCAddRate := EditWeaponMCAddRate.Value;
  ModValue();
end;
//人形身上装备极品机率 20080716
procedure TfrmItemSet.EditPlayMonRandomAddValueChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nPlayMonRandomAddValue := EditPlayMonRandomAddValue.Value;
  ModValue();
end;

procedure TfrmItemSet.FormDestroy(Sender: TObject);
begin
  frmItemSet:= nil;
end;

procedure TfrmItemSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmItemSet.EditAttackPosionTime1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionTime1 := EditAttackPosionTime1.Value;
  ModValue();
end;

procedure TfrmItemSet.EditAttackPosionTime2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionTime2 := EditAttackPosionTime2.Value;
  ModValue();
end;

procedure TfrmItemSet.EditAttackPosionTime3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionTime3 := EditAttackPosionTime3.Value;
  ModValue();
end;

procedure TfrmItemSet.EditAttackPosionRate1Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionRate1 := EditAttackPosionRate1.Value;
  ModValue();
end;

procedure TfrmItemSet.EditAttackPosionRate2Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionRate2 := EditAttackPosionRate2.Value;
  ModValue();
end;

procedure TfrmItemSet.EditAttackPosionRate3Change(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nAttackPosionRate3 := EditAttackPosionRate3.Value;
  ModValue();
end;

procedure TfrmItemSet.Button1Click(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'Free9YearsBoxID', g_Config.nFree9YearsBoxID);
  Config.WriteInteger('Setup', 'FirstOpen9Years', g_Config.nFirstOpen9Years);
  Config.WriteInteger('Setup', 'SecondOpen9Years', g_Config.nSecondOpen9Years);
  Config.WriteInteger('Setup', 'ThreeOpen9Years', g_Config.nThreeOpen9Years);
  Config.WriteInteger('Setup', 'FourOpen9Years', g_Config.nFourOpen9Years);
  uModValue();
end;

procedure TfrmItemSet.SpinEditFirstOpen9YearsChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFirstOpen9Years := SpinEditFirstOpen9Years.Value;
  ModValue();
end;

procedure TfrmItemSet.SpinEditSecondOpen9YearsChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nSecondOpen9Years := SpinEditSecondOpen9Years.Value;
  ModValue();
end;

procedure TfrmItemSet.SpinEditThreeOpen9YearsChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nThreeOpen9Years := SpinEditThreeOpen9Years.Value;
  ModValue();
end;

procedure TfrmItemSet.SpinEditFourOpen9YearsChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFourOpen9Years := SpinEditFourOpen9Years.Value;
  ModValue();
end;

procedure TfrmItemSet.SpinEditFree9YearsBoxIDChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.nFree9YearsBoxID := SpinEditFree9YearsBoxID.Value;
  ModValue();
end;

procedure TfrmItemSet.EditRevivalTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwRevivalTime := EditRevivalTime.Value * 1000;
  ModValue();
end;
//重生间隔时间 20100720
procedure TfrmItemSet.EditRebirthTimeChange(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.dwRebirthTime := EditRebirthTime.Value * 1000;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxRevivalTickClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boStartRevivalTick := CheckBoxRevivalTick.Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBox1Click(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boOneRingXiXue := CheckBox1.Checked;
  ModValue();
end;

procedure TfrmItemSet.CheckBoxRebirthTickClick(Sender: TObject);
begin
  if not boOpened then Exit;
  g_Config.boStartRebirthTick := CheckBoxRebirthTick.Checked;
  ModValue();
end;

end.
