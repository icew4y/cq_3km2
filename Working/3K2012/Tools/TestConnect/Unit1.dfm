object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 171
  ClientWidth = 295
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 14
    Height = 13
    Caption = 'IP:'
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 28
    Height = 13
    Caption = #31471#21475':'
  end
  object Label3: TLabel
    Left = 8
    Top = 65
    Width = 28
    Height = 13
    Caption = #25968#37327':'
  end
  object Label4: TLabel
    Left = 8
    Top = 89
    Width = 34
    Height = 13
    Caption = #25968#37327'1:'
  end
  object Label5: TLabel
    Left = 8
    Top = 116
    Width = 34
    Height = 13
    Caption = #25968#37327'2:'
  end
  object Edit1: TEdit
    Left = 48
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 192
    Top = 26
    Width = 75
    Height = 25
    Caption = #36830#25509
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 48
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 48
    Top = 62
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '256'
  end
  object Edit4: TEdit
    Left = 48
    Top = 86
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '256'
  end
  object Edit5: TEdit
    Left = 48
    Top = 113
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '256'
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 216
    Top = 80
  end
end
