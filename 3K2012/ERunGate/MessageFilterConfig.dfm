object frmMessageFilterConfig: TfrmMessageFilterConfig
  Left = 343
  Top = 277
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25991#23383#36807#28388#35774#32622
  ClientHeight = 244
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 0
    Top = 3
    Width = 489
    Height = 238
    Caption = #36807#28388#35774#32622
    TabOrder = 0
    object Label1: TLabel
      Left = 232
      Top = 171
      Width = 54
      Height = 12
      Caption = #35686#21578#20869#23481':'
    end
    object ListBoxFilterText: TListBox
      Left = 8
      Top = 16
      Width = 209
      Height = 217
      ItemHeight = 12
      TabOrder = 0
      OnClick = ListBoxFilterTextClick
      OnDblClick = ListBoxFilterTextDblClick
    end
    object ButtonAdd: TButton
      Left = 226
      Top = 200
      Width = 57
      Height = 25
      Caption = #22686#21152'(&A)'
      TabOrder = 1
      OnClick = ButtonAddClick
    end
    object ButtonDel: TButton
      Left = 290
      Top = 200
      Width = 57
      Height = 25
      Caption = #21024#38500'(&D)'
      TabOrder = 2
      OnClick = ButtonDelClick
    end
    object ButtonMod: TButton
      Left = 354
      Top = 200
      Width = 57
      Height = 25
      Caption = #20462#25913'(&M)'
      TabOrder = 3
      OnClick = ButtonModClick
    end
    object ButtonOK: TButton
      Left = 418
      Top = 200
      Width = 57
      Height = 25
      Caption = #30830#23450'(&O)'
      TabOrder = 4
      OnClick = ButtonOKClick
    end
    object GroupBox2: TGroupBox
      Left = 224
      Top = 10
      Width = 257
      Height = 151
      Caption = #36807#28388#36873#39033
      TabOrder = 5
      object StartMsgFilterCheck: TCheckBox
        Left = 16
        Top = 16
        Width = 97
        Height = 17
        Caption = #24320#21551#25991#23383#36807#28388
        TabOrder = 0
        OnClick = StartMsgFilterCheckClick
      end
      object rbMsgFilterType0: TRadioButton
        Left = 16
        Top = 40
        Width = 145
        Height = 17
        Caption = #25972#21477#20351#29992#35686#21578#25991#26412#26367#25442
        TabOrder = 1
        OnClick = rbMsgFilterType0Click
      end
      object rbMsgFilterType1: TRadioButton
        Left = 16
        Top = 67
        Width = 145
        Height = 17
        Caption = #29305#24449#23383#29992#35686#21578#25991#26412#26367#25442
        TabOrder = 2
        OnClick = rbMsgFilterType1Click
      end
      object rbMsgFilterType2: TRadioButton
        Left = 16
        Top = 95
        Width = 145
        Height = 17
        Caption = #21457#29616#36807#28388#25991#23383#25481#32447#22788#29702
        TabOrder = 3
        OnClick = rbMsgFilterType2Click
      end
      object rbMsgFilterType3: TRadioButton
        Left = 16
        Top = 122
        Width = 145
        Height = 17
        Caption = #21457#29616#36807#28388#25991#23383#20002#21253#22788#29702
        TabOrder = 4
        OnClick = rbMsgFilterType3Click
      end
    end
    object MsgFilterWarningMsgEdt: TEdit
      Left = 288
      Top = 168
      Width = 193
      Height = 20
      TabOrder = 6
      Text = #24744#21457#36865#30340#20449#24687#37324#21253#21547#20102#38750#27861#23383#31526'.'
      OnChange = MsgFilterWarningMsgEdtChange
    end
  end
end
