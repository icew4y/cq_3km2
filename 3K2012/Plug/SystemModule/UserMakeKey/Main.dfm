object FrmMakeKey: TFrmMakeKey
  Left = 390
  Top = 251
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'M2'#20195#29702#19987#29992#27880#20876#26426
  ClientHeight = 187
  ClientWidth = 543
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label4: TLabel
    Left = 8
    Top = 116
    Width = 48
    Height = 12
    Caption = #29992#25143#21517#65306
  end
  object Label9: TLabel
    Left = 8
    Top = 116
    Width = 48
    Height = 12
    Caption = #27880#20876#30721#65306
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 313
    Height = 97
    Caption = #27880#20876#20449#24687
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 48
      Height = 12
      Caption = #26426#22120#30721#65306
    end
    object Label3: TLabel
      Left = 8
      Top = 72
      Width = 60
      Height = 12
      Caption = #21040#26399#26102#38388#65306
    end
    object Label5: TLabel
      Left = 8
      Top = 48
      Width = 60
      Height = 12
      Caption = #27880#20876#26085#26399#65306
    end
    object UserKeyEdit: TEdit
      Left = 72
      Top = 20
      Width = 233
      Height = 20
      TabOrder = 0
    end
    object UserDateTimeEdit: TRzDateTimeEdit
      Left = 72
      Top = 68
      Width = 233
      Height = 20
      EditType = etDate
      TabOrder = 1
    end
    object RzDateTimeEditRegister: TRzDateTimeEdit
      Left = 72
      Top = 44
      Width = 233
      Height = 20
      EditType = etDate
      TabOrder = 2
    end
  end
  object EditUserName: TEdit
    Left = 56
    Top = 112
    Width = 361
    Height = 20
    TabOrder = 1
    Text = 'www.51ggame.com'
  end
  object EditEnterKey: TEdit
    Left = 56
    Top = 112
    Width = 361
    Height = 20
    TabOrder = 2
  end
  object MakeKeyButton: TButton
    Left = 192
    Top = 152
    Width = 97
    Height = 25
    Caption = #35745#31639#27880#20876#30721'(&M)'
    TabOrder = 3
    OnClick = MakeKeyButtonClick
  end
  object ButtonExit: TButton
    Left = 304
    Top = 152
    Width = 99
    Height = 25
    Caption = #20851#38381'(&E)'
    TabOrder = 4
    OnClick = ButtonExitClick
  end
  object RadioGroupLicDay: TRadioGroup
    Left = 328
    Top = 8
    Width = 89
    Height = 97
    Caption = #25480#26435#22825#25968
    ItemIndex = 2
    Items.Strings = (
      #19968#20010#26376
      #21322#24180
      #19968#24180)
    TabOrder = 5
    OnClick = RadioGroupLicDayClick
  end
  object UserModeRadioGroup: TRadioGroup
    Left = 424
    Top = 8
    Width = 105
    Height = 145
    Caption = #27880#20876#31867#22411
    ItemIndex = 1
    Items.Strings = (
      #27425#25968#38480#21046
      #26085#26399#38480#21046
      #26080#38480#21046
      #20854#20182
      #20854#20182)
    TabOrder = 6
  end
end
