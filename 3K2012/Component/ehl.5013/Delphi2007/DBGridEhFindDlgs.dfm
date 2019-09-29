object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 273
  Top = 305
  BorderStyle = bsDialog
  Caption = 'Find text'
  ClientHeight = 150
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 12
    Width = 52
    Height = 13
    Caption = 'Fi&nd What:'
  end
  object Label2: TLabel
    Left = 10
    Top = 35
    Width = 34
    Height = 13
    Caption = 'Find &in:'
  end
  object cbMatchType: TLabel
    Left = 10
    Top = 58
    Width = 33
    Height = 13
    Caption = 'Matc&h:'
  end
  object Label3: TLabel
    Left = 10
    Top = 82
    Width = 37
    Height = 13
    Caption = 'Sea&rch:'
  end
  object Label4: TLabel
    Left = 10
    Top = 128
    Width = 59
    Height = 13
    Caption = 'Find in Tree:'
  end
  object cbText: TDBComboBoxEh
    Left = 88
    Top = 9
    Width = 316
    Height = 21
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 0
    Text = 'cbText'
    Visible = True
    OnChange = cbTextChange
  end
  object bFind: TButton
    Left = 413
    Top = 9
    Width = 82
    Height = 23
    Caption = '&Find next'
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 413
    Top = 37
    Width = 82
    Height = 22
    Cancel = True
    Caption = 'Close'
    ModalResult = 2
    TabOrder = 7
    OnClick = bCancelClick
  end
  object cbFindIn: TDBComboBoxEh
    Left = 88
    Top = 32
    Width = 192
    Height = 21
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 1
    Text = 'cbFindIn'
    Visible = True
    OnChange = cbFindInChange
  end
  object cbMatchinType: TDBComboBoxEh
    Left = 88
    Top = 55
    Width = 144
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'From any part of field'
      'Whole field'
      'From beging of field')
    KeyItems.Strings = (
      'From any part of field'
      'Whole field'
      'From beging of field')
    TabOrder = 2
    Text = 'From any part of field'
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 88
    Top = 79
    Width = 144
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'Up'
      'Down'
      'All')
    KeyItems.Strings = (
      'Up'
      'Down'
      'All')
    TabOrder = 3
    Text = 'All'
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 88
    Top = 105
    Width = 144
    Height = 14
    Caption = 'Match &Case'
    TabOrder = 4
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 260
    Top = 105
    Width = 144
    Height = 14
    Caption = 'Match F&ormat'
    Checked = True
    State = cbChecked
    TabOrder = 5
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbcTreeFindRange: TDBComboBoxEh
    Left = 88
    Top = 124
    Width = 145
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'In all nodes'
      'In expanded nodes'
      'In current level'
      'In current node')
    KeyItems.Strings = (
      'In all nodes'
      'In expanded nodes'
      'In current level'
      'In current node')
    TabOrder = 8
    Text = 'In all nodes'
    Visible = True
    OnChange = cbTextChange
  end
end
