object frmConfigMonGen: TfrmConfigMonGen
  Left = 350
  Top = 201
  Caption = #24618#29289#37197#21046
  ClientHeight = 412
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 392
    Width = 306
    Height = 12
    Caption = #35828#26126':'#20808#28857#20987#21152#36733#65292#20877#28857#29190#29575#25991#20214#26368#21491#36793#20250#20986#29616#29190#29575#20869#23481#12290
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 464
    Top = 8
    Width = 281
    Height = 401
    Caption = #29190#29575#32534#36753
    TabOrder = 0
    object Memo1: TMemo
      Left = 8
      Top = 16
      Width = 265
      Height = 345
      Hint = #20462#25913#24618#29289#29190#29575'.'
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object Button1: TButton
      Left = 40
      Top = 368
      Width = 75
      Height = 25
      Caption = #21152#36733'(&S)'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button3: TButton
      Left = 160
      Top = 368
      Width = 75
      Height = 25
      Caption = #20445#23384'(&B)'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 232
    Top = 8
    Width = 225
    Height = 369
    Caption = #29190#29575#25991#20214#21015#34920
    TabOrder = 1
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 209
      Height = 345
      ItemHeight = 12
      TabOrder = 0
      OnClick = ListBox1Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 8
    Width = 217
    Height = 369
    Caption = #21047#24618#21015#34920
    TabOrder = 2
    object ListBoxMonGen: TListBox
      Left = 8
      Top = 16
      Width = 201
      Height = 345
      Hint = #24618#29289#21015#34920'!'
      ItemHeight = 12
      TabOrder = 0
    end
  end
end
