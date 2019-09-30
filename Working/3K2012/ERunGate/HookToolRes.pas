unit HookToolRes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin;

type
  TFrmHookCheck = class(TForm)
    GroupBox1: TGroupBox;
    CheckBoxWalk: TCheckBox;
    CheckBoxRun: TCheckBox;
    CheckBoxHit: TCheckBox;
    CheckBoxSpell: TCheckBox;
    EditErrMsg: TEdit;
    CheckBoxWarning: TCheckBox;
    BitBtnVSetup: TBitBtn;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    ComBoxSpeedHackWarningType: TComboBox;
    Label4: TLabel;
    SpinEditWalk: TSpinEdit;
    SpinEditHit: TSpinEdit;
    SpinEditRun: TSpinEdit;
    Label10: TLabel;
    Label9: TLabel;
    SpinEditIncErrorCount: TSpinEdit;
    SpinEditDecErrorCount: TSpinEdit;
    CheckBoxButch: TCheckBox;
    SpinEditButch: TSpinEdit;
    CheckBoxTurn: TCheckBox;
    SpinEditTurn: TSpinEdit;
    Label21: TLabel;
    speItemSpeed: TSpinEdit;
    CombPunishType: TComboBox;
    Label19: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    speCOMPENSATE_MAGIC_VALUE: TSpinEdit;
    speCOMPENSATE_ATTACK_VALUE: TSpinEdit;
    speCOMPENSATE_MOVE_VALUE: TSpinEdit;
    speMagicInv: TSpinEdit;
    speAttackInv: TSpinEdit;
    speActionCompensate: TSpinEdit;
    spePunishOverSpeed: TSpinEdit;
    ComBoxMagic: TComboBox;
    speCLTMagic: TSpinEdit;
    CheckBoxEat: TCheckBox;
    CheckBoxPickUp: TCheckBox;
    spePickUpItemInvTime: TSpinEdit;
    speEatItemInvTime: TSpinEdit;
    Label13: TLabel;
    CheckBoxCheck: TCheckBox;
    EditWarningMsgFColor: TSpinEdit;
    LabeltWarningMsgFColor: TLabel;
    Label109: TLabel;
    EditWarningMsgBColor: TSpinEdit;
    LabelWarningMsgBColor: TLabel;
    Label108: TLabel;
    CheckBoxOther: TCheckBox;
    procedure CheckBoxWarningClick(Sender: TObject);
    procedure CheckBoxWalkClick(Sender: TObject);
    procedure CheckBoxHitClick(Sender: TObject);
    procedure CheckBoxRunClick(Sender: TObject);
    procedure BitBtnVSetupClick(Sender: TObject);
    procedure SpinEditWalkChange(Sender: TObject);
    procedure SpinEditHitChange(Sender: TObject);
    procedure SpinEditRunChange(Sender: TObject);
    procedure SpinEditSpellChange(Sender: TObject);
    procedure SpinEditIncErrorCountChange(Sender: TObject);
    procedure SpinEditDecErrorCountChange(Sender: TObject);
    procedure EditErrMsgChange(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure CheckBoxCheckClick(Sender: TObject);
    procedure EditWarningMsgFColorChange(Sender: TObject);
    procedure EditWarningMsgBColorChange(Sender: TObject);
    procedure ComBoxSpeedHackWarningTypeChange(Sender: TObject);
    procedure CombPunishTypeChange(Sender: TObject);
    procedure CheckBoxButchClick(Sender: TObject);
    procedure CheckBoxTurnClick(Sender: TObject);
    procedure CheckBoxEatClick(Sender: TObject);
    procedure CheckBoxPickUpClick(Sender: TObject);
    procedure CheckBoxSpellClick(Sender: TObject);
    procedure speEatItemInvTimeChange(Sender: TObject);
    procedure spePickUpItemInvTimeChange(Sender: TObject);
    procedure speItemSpeedChange(Sender: TObject);
    procedure SpinEditButchChange(Sender: TObject);
    procedure SpinEditTurnChange(Sender: TObject);
    procedure ComBoxMagicChange(Sender: TObject);
    procedure speCLTMagicChange(Sender: TObject);
  private
    procedure FCheckBoxCheck(BoolStatrt: Boolean);
    procedure ClearModValue();
  public
  end;

var
  FrmHookCheck: TFrmHookCheck;

implementation
uses GateShare;
{$R *.dfm}

{ TFrmHookCheck }

procedure TFrmHookCheck.FCheckBoxCheck(BoolStatrt: Boolean);
begin
  CheckBoxWalk.Enabled := BoolStatrt;
  CheckBoxHit.Enabled := BoolStatrt;
  CheckBoxRun.Enabled := BoolStatrt;
  CheckBoxSpell.Enabled := BoolStatrt;
  CheckBoxButch.Enabled := BoolStatrt;
  CheckBoxTurn.Enabled := BoolStatrt;
  CheckBoxEat.Enabled := BoolStatrt;
  CheckBoxPickUp.Enabled := BoolStatrt;
  SpinEditIncErrorCount.Enabled := BoolStatrt;
  SpinEditDecErrorCount.Enabled := BoolStatrt;
  Label9.Enabled := BoolStatrt;
  Label10.Enabled := BoolStatrt;
  CheckBoxWarning.Enabled := BoolStatrt;
  ComBoxSpeedHackWarningType.Enabled := BoolStatrt;
  Label108.Enabled := BoolStatrt;
  EditWarningMsgFColor.Enabled := BoolStatrt;
  Label109.Enabled := BoolStatrt;
  EditWarningMsgBColor.Enabled := BoolStatrt;
  EditErrMsg.Enabled := BoolStatrt;
  Label21.Enabled := BoolStatrt;
  speItemSpeed.Enabled := BoolStatrt;
  Label19.Enabled := BoolStatrt;
  CombPunishType.Enabled := BoolStatrt;
  CheckBoxOther.Enabled := BoolStatrt;
  {Label2.Enabled := BoolStatrt;
  Label5.Enabled := BoolStatrt;
  Label6.Enabled := BoolStatrt;
  Label12.Enabled := BoolStatrt;
  speActionCompensate.Enabled := BoolStatrt;
  speAttackInv.Enabled := BoolStatrt;
  speMagicInv.Enabled := BoolStatrt;
  spePunishOverSpeed.Enabled := BoolStatrt;  }
end;
{ //20090808 注释
procedure TFrmHookCheck.CheckBoxCheckClick(Sender: TObject);
begin
  FCheckBoxCheck(CheckBoxCheck.Checked);
  ClearModValue();
end; }

procedure TFrmHookCheck.CheckBoxWarningClick(Sender: TObject);
begin
  EditErrMsg.Enabled:= CheckBoxWarning.Checked;
  Label108.Enabled := CheckBoxWarning.Checked;
  EditWarningMsgFColor.Enabled := CheckBoxWarning.Checked;
  LabeltWarningMsgFColor.Enabled := CheckBoxWarning.Checked;
  Label109.Enabled := CheckBoxWarning.Checked;
  EditWarningMsgBColor.Enabled := CheckBoxWarning.Checked;
  LabelWarningMsgBColor.Enabled := CheckBoxWarning.Checked;
  ComBoxSpeedHackWarningType.Enabled := CheckBoxWarning.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxWalkClick(Sender: TObject);
begin
  SpinEditWalk.Enabled := CheckBoxWalk.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxHitClick(Sender: TObject);
begin
  SpinEditHit.Enabled := CheckBoxHit.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxRunClick(Sender: TObject);
begin
  SpinEditRun.Enabled := CheckBoxRun.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.BitBtnVSetupClick(Sender: TObject);
begin
  if boStartHookCheck then begin
    CheckBoxWalk.Checked := True;
    SpinEditWalk.Enabled := True;
    CheckBoxHit.Checked := True;
    SpinEditHit.Enabled := True;
    CheckBoxRun.Checked := True;
    SpinEditRun.Enabled := True;
    CheckBoxSpell.Checked := True;
    CheckBoxWarning.Checked := True;
    EditErrMsg.Enabled := True;
    CheckBoxEat.Checked := True;
    CheckBoxPickUp.Checked := True;
    CheckBoxButch.Checked := True;
    CheckBoxTurn.Checked := True;
  end;
  SpinEditHit.Value := 600;
  SpinEditWalk.Value := 550;
  SpinEditRun.Value := 580;
  SpinEditButch.Value := 300;
  SpinEditTurn.Value := 100;
  speItemSpeed.Value := 60;
  speEatItemInvTime.Value := 300;
  spePickUpItemInvTime.Value := 200;
  SpinEditIncErrorCount.Value := 5;
  SpinEditDecErrorCount.Value := 1;

  //技能变量相关
  dwSKILL_1:= 1000;//火球术
  dwSKILL_2:= 1000;//治愈术
  dwSKILL_5:= 1000;//大火球
  dwSKILL_6:= 1000;//施毒术
  dwSKILL_8:= 1000;//抗拒火环
  dwSKILL_9:= 1000;//地狱火
  dwSKILL_10:= 1000;//疾光电影
  dwSKILL_11:= 1000;//雷电术
  dwSKILL_13:= 1000;//灵魂火符
  dwSKILL_14:= 1000;//幽灵盾
  dwSKILL_15:= 1000;//神圣战甲术
  dwSKILL_16:= 1000;//困魔咒
  dwSKILL_17:= 1000;//召唤骷髅
  dwSKILL_18:= 1000;//隐身术
  dwSKILL_19:= 1000;//集体隐身术
  dwSKILL_20:= 1000;//诱惑之光
  dwSKILL_21:= 1000;//瞬息移动
  dwSKILL_22:= 1000;//火墙
  dwSKILL_23:= 1000;//爆裂火焰
  dwSKILL_24:= 1000;//地狱雷光
  dwSKILL_27:= 1000;//野蛮冲撞
  dwSKILL_28:= 1000;//心灵启示
  dwSKILL_29:= 1000;//群体治疗术
  dwSKILL_30:= 1000;//召唤神兽
  dwSKILL_32:= 1000;//圣言术
  dwSKILL_33:= 1000;//冰咆哮
  dwSKILL_34:= 1000;//解毒术
  dwSKILL_35:= 1000;//狮吼功
  dwSKILL_36:= 1000;//火焰冰
  dwSKILL_37:= 1000;//群体雷电术
  dwSKILL_38:= 1000;//群体施毒术
  dwSKILL_39:= 1000;//彻地钉
  dwSKILL_41:= 1000;//狮子吼
  dwSKILL_44:= 1000;//寒冰掌
  dwSKILL_45:= 1000;//灭天火
  dwSKILL_46:= 1000;//分身术
  dwSKILL_47:= 1000;//火龙焰
  dwSKILL_48:= 1000;//气功波
  dwSKILL_49:= 1000;//净化术
  dwSKILL_50:= 1000;//无极真气
  dwSKILL_51:= 1000;//飓风破
  dwSKILL_52:= 1000;//诅咒术
  dwSKILL_53:= 1000;//血咒
  dwSKILL_54:= 1000;//骷髅咒
  dwSKILL_55:= 1000;//擒龙手
  dwSKILL_56:= 1000;//乾坤大挪移
  dwSKILL_57:= 1000;//复活术
  dwSKILL_58:= 1000;//流星火雨
  dwSKILL_59:= 1000;//噬血术
  dwSKILL_71:= 1000;//召唤圣兽
  dwSKILL_72:= 1000;//召唤月灵
  ComBoxMagic.ItemIndex:= 0;
  speCLTMagic.Value:= 1000;

  EditErrMsg.Text := '[提示]: 请爱护游戏环境，关闭加速外挂重新登陆';
  ClearModValue();
end;

procedure TFrmHookCheck.ClearModValue;
begin
  BitBtnOK.Enabled := True;
end;

procedure TFrmHookCheck.SpinEditWalkChange(Sender: TObject);
begin
  if CheckBoxWalk.Checked then ClearModValue();
end;

procedure TFrmHookCheck.SpinEditHitChange(Sender: TObject);
begin
  if CheckBoxHit.Checked then ClearModValue();
end;

procedure TFrmHookCheck.SpinEditRunChange(Sender: TObject);
begin
  if CheckBoxRun.Checked then ClearModValue();
end;

procedure TFrmHookCheck.SpinEditSpellChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.SpinEditIncErrorCountChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.SpinEditDecErrorCountChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.EditErrMsgChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.BitBtnCancelClick(Sender: TObject);
begin
  Close();
end;

procedure TFrmHookCheck.BitBtnOKClick(Sender: TObject);
begin
  boStartWalkCheck := CheckBoxWalk.Checked;
  boStartHitCheck := CheckBoxHit.Checked;
  boStartRunCheck := CheckBoxRun.Checked;
  boStartSpellCheck := CheckBoxSpell.Checked;
  boStartWarning := CheckBoxWarning.Checked;
  boStartEatCheck := CheckBoxEat.Checked;
  boStartOtherCheck := CheckBoxOther.Checked;
  boStartPickUpCheck := CheckBoxPickUp.Checked;
  boStartButchCheck := CheckBoxButch.Checked;//是否开启挖肉控制
  boStartTurnCheck := CheckBoxTurn.Checked;//是否开启转身控制

  nIncErrorCount := SpinEditIncErrorCount.Value;
  dwRunTime := SpinEditRun.Value;
  boStartHookCheck := CheckBoxCheck.Checked;
  //dwSpellTime := SpinEditSpell.Value;
  nDecErrorCount := SpinEditDecErrorCount.Value;
  dwWalkTime := SpinEditWalk.Value;
  dwHitTime := SpinEditHit.Value;
  dwEatTime := speEatItemInvTime.Value;
  dwPickUpTime := spePickUpItemInvTime.Value;
  dwButchTime := SpinEditButch.Value;//是否开启挖肉控制
  dwTurnTime := SpinEditTurn.Value;//是否开启转身控制
  dwItemSpeed := speItemSpeed.Value; //装备加速因数
  btPunishType := CombPunishType.ItemIndex; //处理类型
  btWarningMsgType := ComBoxSpeedHackWarningType.ItemIndex;
  btWarningMsgFColor := EditWarningMsgFColor.Value;
  btWarningMsgBColor := EditWarningMsgBColor.Value;
  sErrMsg := EditErrMsg.Text;
  if Conf <> nil then begin
    Conf.WriteBool(SpeedCheckClass,'CheckSpeed', boStartHookCheck);
    Conf.WriteBool(SpeedCheckClass,'CtrlWalkSpeed', boStartWalkCheck);
    Conf.WriteBool(SpeedCheckClass,'CtrlHitSpeed', boStartHitCheck);
    Conf.WriteBool(SpeedCheckClass,'CtrlRunSpeed', boStartRunCheck);
    Conf.WriteBool(SpeedCheckClass,'CtrlSpellSpeed', boStartSpellCheck);
    Conf.WriteBool(SpeedCheckClass,'SpeedHackWarning', boStartWarning);
    Conf.WriteBool(SpeedCheckClass,'CheckEat', boStartEatCheck);
    Conf.WriteBool(SpeedCheckClass,'CheckOther', boStartOtherCheck);
    Conf.WriteBool(SpeedCheckClass,'CheckPickUp', boStartPickUpCheck);
    Conf.WriteBool(SpeedCheckClass, 'CheckButch', boStartButchCheck);//是否开启挖肉控制
    Conf.WriteBool(SpeedCheckClass, 'CheckTurn', boStartTurnCheck);//是否开启转身控制

    Conf.WriteInteger(SpeedCheckClass,'IncErrorCount', nIncErrorCount);
    Conf.WriteInteger(SpeedCheckClass,'DecErrorCount', nDecErrorCount);
    Conf.WriteString(SpeedCheckClass,'WarningMsg', sErrMsg);
    Conf.WriteInteger(SpeedCheckClass,'HitTime', dwHitTime);
    Conf.WriteInteger(SpeedCheckClass,'WalkTime', dwWalkTime);
    Conf.WriteInteger(SpeedCheckClass,'RunTime', dwRunTime);
    Conf.WriteInteger(SpeedCheckClass,'EatTime', dwEatTime);
    Conf.WriteInteger(SpeedCheckClass,'PickUpTime', dwPickUpTime);
    Conf.WriteInteger(SpeedCheckClass, 'ButchTime', dwButchTime);//是否开启挖肉控制
    Conf.WriteInteger(SpeedCheckClass, 'TurnTime', dwTurnTime);//是否开启转身控制
    Conf.WriteInteger(SpeedCheckClass, 'ItemSpeed', dwItemSpeed); //装备加速因数
    Conf.WriteInteger(SpeedCheckClass, 'SpeedHackPunishTpye', btPunishType); //处理类型
    Conf.WriteInteger(SpeedCheckClass, 'SpeedHackPunishWarningTpye', btWarningMsgType); //处理警告类型
    Conf.WriteInteger(SpeedCheckClass, 'WarnMsgFColor', btWarningMsgFColor); //警告前景色
    Conf.WriteInteger(SpeedCheckClass, 'WarnMsgBColor', btWarningMsgBColor); //警告背景色
    //技能保存
    Conf.WriteInteger(SpeedCheckClass, '火球术', dwSKILL_1); //火球术
    Conf.WriteInteger(SpeedCheckClass, '治愈术', dwSKILL_2); //治愈术
    Conf.WriteInteger(SpeedCheckClass, '大火球', dwSKILL_5); //大火球
    Conf.WriteInteger(SpeedCheckClass, '施毒术', dwSKILL_6); //施毒术
    Conf.WriteInteger(SpeedCheckClass, '抗拒火环', dwSKILL_8); //抗拒火环
    Conf.WriteInteger(SpeedCheckClass, '地狱火', dwSKILL_9); //地狱火
    Conf.WriteInteger(SpeedCheckClass, '疾光电影', dwSKILL_10); //疾光电影
    Conf.WriteInteger(SpeedCheckClass, '雷电术', dwSKILL_11); //雷电术
    Conf.WriteInteger(SpeedCheckClass, '灵魂火符', dwSKILL_13); //灵魂火符
    Conf.WriteInteger(SpeedCheckClass, '幽灵盾', dwSKILL_14); //幽灵盾
    Conf.WriteInteger(SpeedCheckClass, '神圣战甲术', dwSKILL_15); //神圣战甲术
    Conf.WriteInteger(SpeedCheckClass, '困魔咒', dwSKILL_16); //困魔咒
    Conf.WriteInteger(SpeedCheckClass, '召唤骷髅', dwSKILL_17); //召唤骷髅
    Conf.WriteInteger(SpeedCheckClass, '隐身术', dwSKILL_18); //隐身术
    Conf.WriteInteger(SpeedCheckClass, '集体隐身术', dwSKILL_19); //集体隐身术
    Conf.WriteInteger(SpeedCheckClass, '诱惑之光', dwSKILL_20); //诱惑之光
    Conf.WriteInteger(SpeedCheckClass, '瞬息移动', dwSKILL_21); //瞬息移动
    Conf.WriteInteger(SpeedCheckClass, '火墙', dwSKILL_22); //火墙
    Conf.WriteInteger(SpeedCheckClass, '爆裂火焰', dwSKILL_23); //爆裂火焰
    Conf.WriteInteger(SpeedCheckClass, '地狱雷光', dwSKILL_24); //地狱雷光
    Conf.WriteInteger(SpeedCheckClass, '野蛮冲撞', dwSKILL_27); //野蛮冲撞
    Conf.WriteInteger(SpeedCheckClass, '心灵启示', dwSKILL_28); //心灵启示
    Conf.WriteInteger(SpeedCheckClass, '群体治疗术', dwSKILL_29); //群体治疗术
    Conf.WriteInteger(SpeedCheckClass, '召唤神兽', dwSKILL_30); //召唤神兽
    Conf.WriteInteger(SpeedCheckClass, '圣言术', dwSKILL_32); //圣言术
    Conf.WriteInteger(SpeedCheckClass, '冰咆哮', dwSKILL_33); //冰咆哮
    Conf.WriteInteger(SpeedCheckClass, '解毒术', dwSKILL_34); //解毒术
    Conf.WriteInteger(SpeedCheckClass, '狮吼功', dwSKILL_35); //狮吼功
    Conf.WriteInteger(SpeedCheckClass, '火焰冰', dwSKILL_36); //火焰冰
    Conf.WriteInteger(SpeedCheckClass, '群体雷电术', dwSKILL_37); //群体雷电术
    Conf.WriteInteger(SpeedCheckClass, '群体施毒术', dwSKILL_38); //群体施毒术
    Conf.WriteInteger(SpeedCheckClass, '彻地钉', dwSKILL_39); //彻地钉
    Conf.WriteInteger(SpeedCheckClass, '狮子吼', dwSKILL_41); //狮子吼
    Conf.WriteInteger(SpeedCheckClass, '寒冰掌', dwSKILL_44); //寒冰掌
    Conf.WriteInteger(SpeedCheckClass, '灭天火', dwSKILL_45); //灭天火
    Conf.WriteInteger(SpeedCheckClass, '分身术', dwSKILL_46); //分身术
    Conf.WriteInteger(SpeedCheckClass, '火龙焰', dwSKILL_47); //火龙焰
    Conf.WriteInteger(SpeedCheckClass, '气功波', dwSKILL_48); //气功波
    Conf.WriteInteger(SpeedCheckClass, '净化术', dwSKILL_49); //净化术
    Conf.WriteInteger(SpeedCheckClass, '无极真气', dwSKILL_50); //无极真气
    Conf.WriteInteger(SpeedCheckClass, '飓风破', dwSKILL_51); //飓风破
    Conf.WriteInteger(SpeedCheckClass, '诅咒术', dwSKILL_52); //诅咒术
    Conf.WriteInteger(SpeedCheckClass, '血咒', dwSKILL_53); //血咒
    Conf.WriteInteger(SpeedCheckClass, '骷髅咒', dwSKILL_54); //骷髅咒
    Conf.WriteInteger(SpeedCheckClass, '擒龙手', dwSKILL_55); //擒龙手
    Conf.WriteInteger(SpeedCheckClass, '乾坤大挪移', dwSKILL_56); //乾坤大挪移
    Conf.WriteInteger(SpeedCheckClass, '复活术', dwSKILL_57); //复活术
    Conf.WriteInteger(SpeedCheckClass, '流星火雨', dwSKILL_58); //流星火雨
    Conf.WriteInteger(SpeedCheckClass, '噬血术', dwSKILL_59); //噬血术
    Conf.WriteInteger(SpeedCheckClass, '召唤圣兽', dwSKILL_71); //召唤圣兽
    Conf.WriteInteger(SpeedCheckClass, '召唤月灵', dwSKILL_72); //召唤月灵
  end;
  BitBtnOK.Enabled := False;
end;

procedure TFrmHookCheck.CheckBoxCheckClick(Sender: TObject);
begin
  FCheckBoxCheck(CheckBoxCheck.Checked);
  ClearModValue();
end;

procedure TFrmHookCheck.EditWarningMsgFColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditWarningMsgFColor.Value;
  LabeltWarningMsgFColor.Color := GetRGB(btColor);
  btWarningMsgFColor := btColor;
  EditErrMsg.Font.Color := GetRGB(btColor);
  ClearModValue();
end;

procedure TFrmHookCheck.EditWarningMsgBColorChange(Sender: TObject);
var
  btColor: Byte;
begin
  btColor := EditWarningMsgBColor.Value;
  LabelWarningMsgBColor.Color := GetRGB(btColor);
  btWarningMsgBColor := btColor;
  EditErrMsg.Color := GetRGB(btColor);
  ClearModValue();
end;

procedure TFrmHookCheck.ComBoxSpeedHackWarningTypeChange(Sender: TObject);
var
  boFalg: Boolean;
begin
  boFalg := ComBoxSpeedHackWarningType.ItemIndex = 0;
  Label108.Enabled := boFalg;
  EditWarningMsgFColor.Enabled := boFalg;
  LabeltWarningMsgFColor.Enabled := boFalg;
  Label109.Enabled := boFalg;
  EditWarningMsgBColor.Enabled := boFalg;
  LabelWarningMsgBColor.Enabled := boFalg;
  //btWarningMsgType := ComBoxSpeedHackWarningType.ItemIndex;
  ClearModValue();
end;

procedure TFrmHookCheck.CombPunishTypeChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxButchClick(Sender: TObject);
begin
  SpinEditButch.Enabled := CheckBoxButch.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxTurnClick(Sender: TObject);
begin
  SpinEditTurn.Enabled := CheckBoxTurn.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxEatClick(Sender: TObject);
begin
  speEatItemInvTime.Enabled := CheckBoxEat.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxPickUpClick(Sender: TObject);
begin
  spePickUpItemInvTime.Enabled := CheckBoxPickUp.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.CheckBoxSpellClick(Sender: TObject);
begin
  ComBoxMagic.Enabled := CheckBoxSpell.Checked;
  speCLTMagic.Enabled := CheckBoxSpell.Checked;
  ClearModValue();
end;

procedure TFrmHookCheck.speEatItemInvTimeChange(Sender: TObject);
begin
  if CheckBoxEat.Checked then ClearModValue();
end;

procedure TFrmHookCheck.spePickUpItemInvTimeChange(Sender: TObject);
begin
  if CheckBoxPickUp.Checked then ClearModValue();
end;

procedure TFrmHookCheck.speItemSpeedChange(Sender: TObject);
begin
  ClearModValue();
end;

procedure TFrmHookCheck.SpinEditButchChange(Sender: TObject);
begin
  if CheckBoxButch.Checked then ClearModValue();
end;

procedure TFrmHookCheck.SpinEditTurnChange(Sender: TObject);
begin
  if CheckBoxTurn.Checked then ClearModValue();
end;

procedure TFrmHookCheck.ComBoxMagicChange(Sender: TObject);
begin
  if CheckBoxSpell.Checked  then begin
    case ComBoxMagic.ItemIndex of
       0: speCLTMagic.Value := dwSKILL_1;
       1: speCLTMagic.Value := dwSKILL_2;
       2: speCLTMagic.Value := dwSKILL_5;
       3: speCLTMagic.Value := dwSKILL_6;
       4: speCLTMagic.Value := dwSKILL_8;
       5: speCLTMagic.Value := dwSKILL_9;
       6: speCLTMagic.Value := dwSKILL_10;
       7: speCLTMagic.Value := dwSKILL_11;
       8: speCLTMagic.Value := dwSKILL_13;
       9: speCLTMagic.Value := dwSKILL_14;
      10: speCLTMagic.Value := dwSKILL_15;
      11: speCLTMagic.Value := dwSKILL_16;
      12: speCLTMagic.Value := dwSKILL_17;
      13: speCLTMagic.Value := dwSKILL_18;
      14: speCLTMagic.Value := dwSKILL_19;
      15: speCLTMagic.Value := dwSKILL_20;
      16: speCLTMagic.Value := dwSKILL_21;
      17: speCLTMagic.Value := dwSKILL_22;
      18: speCLTMagic.Value := dwSKILL_23;
      19: speCLTMagic.Value := dwSKILL_24;
      20: speCLTMagic.Value := dwSKILL_27;
      21: speCLTMagic.Value := dwSKILL_28;
      22: speCLTMagic.Value := dwSKILL_29;
      23: speCLTMagic.Value := dwSKILL_30;
      24: speCLTMagic.Value := dwSKILL_32;
      25: speCLTMagic.Value := dwSKILL_33;
      26: speCLTMagic.Value := dwSKILL_34;
      27: speCLTMagic.Value := dwSKILL_35;
      28: speCLTMagic.Value := dwSKILL_36;
      29: speCLTMagic.Value := dwSKILL_37;
      30: speCLTMagic.Value := dwSKILL_38;
      31: speCLTMagic.Value := dwSKILL_39;
      32: speCLTMagic.Value := dwSKILL_41;
      33: speCLTMagic.Value := dwSKILL_44;
      34: speCLTMagic.Value := dwSKILL_45;
      35: speCLTMagic.Value := dwSKILL_46;
      36: speCLTMagic.Value := dwSKILL_47;
      37: speCLTMagic.Value := dwSKILL_48;
      38: speCLTMagic.Value := dwSKILL_49;
      39: speCLTMagic.Value := dwSKILL_50;
      40: speCLTMagic.Value := dwSKILL_51;
      41: speCLTMagic.Value := dwSKILL_52;
      42: speCLTMagic.Value := dwSKILL_53;
      43: speCLTMagic.Value := dwSKILL_54;
      44: speCLTMagic.Value := dwSKILL_55;
      45: speCLTMagic.Value := dwSKILL_56;
      46: speCLTMagic.Value := dwSKILL_57;
      47: speCLTMagic.Value := dwSKILL_58;
      48: speCLTMagic.Value := dwSKILL_59;
      49: speCLTMagic.Value := dwSKILL_71;
      50: speCLTMagic.Value := dwSKILL_72;
    end;
  end;
end;

procedure TFrmHookCheck.speCLTMagicChange(Sender: TObject);
begin
  if CheckBoxSpell.Checked  then begin
    case ComBoxMagic.ItemIndex of
       0: dwSKILL_1 := speCLTMagic.Value;
       1: dwSKILL_2 := speCLTMagic.Value;
       2: dwSKILL_5 := speCLTMagic.Value;
       3: dwSKILL_6 := speCLTMagic.Value;
       4: dwSKILL_8 := speCLTMagic.Value;
       5: dwSKILL_9 := speCLTMagic.Value;
       6: dwSKILL_10 := speCLTMagic.Value;
       7: dwSKILL_11 := speCLTMagic.Value;
       8: dwSKILL_13 := speCLTMagic.Value;
       9: dwSKILL_14 := speCLTMagic.Value;
      10: dwSKILL_15 := speCLTMagic.Value;
      11: dwSKILL_16 := speCLTMagic.Value;
      12: dwSKILL_17 := speCLTMagic.Value;
      13: dwSKILL_18 := speCLTMagic.Value;
      14: dwSKILL_19 := speCLTMagic.Value;
      15: dwSKILL_20 := speCLTMagic.Value;
      16: dwSKILL_21 := speCLTMagic.Value;
      17: dwSKILL_22 := speCLTMagic.Value;
      18: dwSKILL_23 := speCLTMagic.Value;
      19: dwSKILL_24 := speCLTMagic.Value;
      20: dwSKILL_27 := speCLTMagic.Value;
      21: dwSKILL_28 := speCLTMagic.Value;
      22: dwSKILL_29 := speCLTMagic.Value;
      23: dwSKILL_30 := speCLTMagic.Value;
      24: dwSKILL_32 := speCLTMagic.Value;
      25: dwSKILL_33 := speCLTMagic.Value;
      26: dwSKILL_34 := speCLTMagic.Value;
      27: dwSKILL_35 := speCLTMagic.Value;
      28: dwSKILL_36 := speCLTMagic.Value;
      29: dwSKILL_37 := speCLTMagic.Value;
      30: dwSKILL_38 := speCLTMagic.Value;
      31: dwSKILL_39 := speCLTMagic.Value;
      32: dwSKILL_41 := speCLTMagic.Value;
      33: dwSKILL_44 := speCLTMagic.Value;
      34: dwSKILL_45 := speCLTMagic.Value;
      35: dwSKILL_46 := speCLTMagic.Value;
      36: dwSKILL_47 := speCLTMagic.Value;
      37: dwSKILL_48 := speCLTMagic.Value;
      38: dwSKILL_49 := speCLTMagic.Value;
      39: dwSKILL_50 := speCLTMagic.Value;
      40: dwSKILL_51 := speCLTMagic.Value;
      41: dwSKILL_52 := speCLTMagic.Value;
      42: dwSKILL_53 := speCLTMagic.Value;
      43: dwSKILL_54 := speCLTMagic.Value;
      44: dwSKILL_55 := speCLTMagic.Value;
      45: dwSKILL_56 := speCLTMagic.Value;
      46: dwSKILL_57 := speCLTMagic.Value;
      47: dwSKILL_58 := speCLTMagic.Value;
      48: dwSKILL_59 := speCLTMagic.Value;
      49: dwSKILL_71 := speCLTMagic.Value;
      50: dwSKILL_72 := speCLTMagic.Value;
    end;
    ClearModValue();
  end;
end;

end.
