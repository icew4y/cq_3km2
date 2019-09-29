object fSelectFromList: TfSelectFromList
  Left = 456
  Top = 331
  AutoScroll = False
  Caption = 'Select Engine and DB Service'
  ClientHeight = 132
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 9
    Top = 97
    Width = 296
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object Label1: TLabel
    Left = 7
    Top = 16
    Width = 36
    Height = 13
    Caption = 'Engine:'
  end
  object Label2: TLabel
    Left = 7
    Top = 44
    Width = 57
    Height = 13
    Caption = 'DB Service:'
  end
  object Label3: TLabel
    Left = 7
    Top = 73
    Width = 75
    Height = 13
    Caption = 'Database name:'
  end
  object bbOk: TBitBtn
    Left = 176
    Top = 105
    Width = 56
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object bbCancel: TBitBtn
    Left = 239
    Top = 105
    Width = 57
    Height = 22
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 7
    TabOrder = 1
    NumGlyphs = 2
  end
  object cbEngine: TDBComboBoxEh
    Left = 89
    Top = 15
    Width = 221
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    EditButtons = <>
    TabOrder = 2
    Text = 'BDE'
    Visible = True
    OnChange = cbEngineChange
  end
  object cbDBService: TDBComboBoxEh
    Left = 89
    Top = 42
    Width = 221
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    EditButtons = <>
    Items.Strings = (
      '(Auto)')
    TabOrder = 3
    Text = '(Auto)'
    Visible = True
  end
  object eDataBaseName: TDBEditEh
    Left = 89
    Top = 69
    Width = 221
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    EditButtons = <>
    TabOrder = 4
    Text = 'eDataBaseName'
    Visible = True
  end
end
