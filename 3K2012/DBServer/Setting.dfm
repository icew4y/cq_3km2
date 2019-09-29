object FrmSetting: TFrmSetting
  Left = 372
  Top = 229
  BorderStyle = bsDialog
  Caption = #22522#26412#35774#32622
  ClientHeight = 153
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 107
    Caption = #22522#26412#35774#32622
    TabOrder = 0
    object CheckBoxAttack: TCheckBox
      Left = 16
      Top = 16
      Width = 89
      Height = 17
      Caption = #38450#25915#20987#20445#25252
      TabOrder = 0
      OnClick = CheckBoxAttackClick
    end
    object CheckBoxDenyChrName: TCheckBox
      Left = 16
      Top = 38
      Width = 145
      Height = 17
      Caption = #20801#35768#29305#27530#23383#31526#21019#24314#20154#29289
      TabOrder = 1
      OnClick = CheckBoxDenyChrNameClick
    end
    object CheckBoxMinimize: TCheckBox
      Left = 16
      Top = 60
      Width = 137
      Height = 17
      Caption = #21551#21160#25104#21151#21518#26368#23567#21270
      TabOrder = 2
      OnClick = CheckBoxMinimizeClick
    end
    object CheckBoxRandomCode: TCheckBox
      Left = 172
      Top = 16
      Width = 121
      Height = 17
      Hint = #38656#35201#36755#20837#27491#30830#30340#39564#35777#30721#65292#25165#33021#36827#20837#28216#25103#65281#24320#21551#21518#38656#35201#26377#39564#35777#30721#21151#33021#30340#30331#38470#22120#37197#21512#20351#29992#65292#21542#21017#29992#25143#26080#27861#27491#24120#28216#25103#12290
      Caption = #24320#21551#39564#35777#30721#31995#32479
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = CheckBoxRandomCodeClick
    end
    object CheckBoxNoCanResDelChr: TCheckBox
      Left = 172
      Top = 39
      Width = 129
      Height = 17
      Hint = #24320#21551#21518','#23458#25143#31471#19981#33021#24674#22797#21024#38500#30340#35282#33394
      Caption = #31105#27490#24674#22797#21024#38500#30340#35282#33394
      TabOrder = 4
      OnClick = CheckBoxNoCanResDelChrClick
    end
    object CheckBox1: TCheckBox
      Left = 17
      Top = 84
      Width = 200
      Height = 17
      Caption = #31105#27490#21024#38500#31561#32423#23567#20110'        '#30340#35282#33394
      TabOrder = 5
      OnClick = CheckBox1Click
    end
    object EdituserLevel: TSpinEdit
      Left = 130
      Top = 82
      Width = 44
      Height = 21
      Enabled = False
      MaxValue = 65535
      MinValue = 0
      TabOrder = 6
      Value = 30
      OnChange = EdituserLevelChange
    end
  end
  object ButtonOK: TButton
    Left = 240
    Top = 120
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    TabOrder = 1
    OnClick = ButtonOKClick
  end
end
