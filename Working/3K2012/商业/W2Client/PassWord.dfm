object FrmPassWord: TFrmPassWord
  Left = 356
  Top = 337
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #23494#30721#20462#25913
  ClientHeight = 185
  ClientWidth = 253
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 32
    Top = 19
    Width = 48
    Height = 12
    Caption = #29992#25143#21517#65306
  end
  object Label2: TLabel
    Left = 32
    Top = 48
    Width = 48
    Height = 12
    Caption = #21407#23494#30721#65306
  end
  object Label3: TLabel
    Left = 32
    Top = 78
    Width = 48
    Height = 12
    Caption = #26032#23494#30721#65306
  end
  object Label4: TLabel
    Left = 32
    Top = 107
    Width = 60
    Height = 12
    Caption = #30830#35748#23494#30721#65306
  end
  object EdtUserName: TEdit
    Left = 91
    Top = 16
    Width = 121
    Height = 20
    Ctl3D = True
    Enabled = False
    ParentCtl3D = False
    TabOrder = 0
  end
  object EdtUserPass: TEdit
    Left = 91
    Top = 47
    Width = 121
    Height = 18
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 1
  end
  object EdtNewPass: TEdit
    Left = 91
    Top = 75
    Width = 121
    Height = 18
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 2
  end
  object EdtNewPass1: TEdit
    Left = 91
    Top = 104
    Width = 121
    Height = 18
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    TabOrder = 3
  end
  object BtnChange: TButton
    Left = 32
    Top = 131
    Width = 75
    Height = 25
    Caption = #20462#25913
    TabOrder = 4
    OnClick = BtnChangeClick
  end
  object BtnCancel: TButton
    Left = 137
    Top = 131
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 5
    OnClick = BtnCancelClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 166
    Width = 253
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
end
