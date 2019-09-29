object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 254
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 17
    Width = 480
    Height = 237
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 0
    Top = 0
    Width = 480
    Height = 17
    Align = alTop
    Caption = #21253#21547#25991#20214#21517
    TabOrder = 1
  end
  object CheckBox2: TCheckBox
    Left = 88
    Top = 0
    Width = 97
    Height = 17
    Caption = #19981#35201#36335#24452
    TabOrder = 2
  end
  object CheckBox3: TCheckBox
    Left = 164
    Top = 0
    Width = 97
    Height = 17
    Caption = #33258#21160#25442#34892
    TabOrder = 3
    Visible = False
    OnClick = CheckBox3Click
  end
end
