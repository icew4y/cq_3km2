object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'BuildBMP'
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
  object CheckBox1: TCheckBox
    Left = 0
    Top = 0
    Width = 480
    Height = 17
    Align = alTop
    Caption = #20998#22359#22823#23567'                              KB'
    TabOrder = 0
  end
  object CheckBox2: TCheckBox
    Left = 179
    Top = 0
    Width = 62
    Height = 17
    Caption = 'Zlib'#21387#32553'?'
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 0
    Top = 17
    Width = 480
    Height = 237
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object SpinEdit1: TSpinEdit
    Left = 70
    Top = -2
    Width = 83
    Height = 22
    MaxValue = 1048576
    MinValue = 1
    TabOrder = 3
    Value = 100
  end
  object CheckBox3: TCheckBox
    Left = 247
    Top = 0
    Width = 62
    Height = 17
    Caption = 'Jpg?'
    Enabled = False
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
    Left = 168
    Top = 56
  end
end
