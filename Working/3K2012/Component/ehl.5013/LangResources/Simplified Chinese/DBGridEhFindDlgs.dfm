object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 273
  Top = 305
  BorderStyle = bsDialog
  Caption = #26597#25214#23383#31526
  ClientHeight = 138
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 9
    Top = 11
    Width = 54
    Height = 12
    Caption = #26597#25214#20869#23481'&n'
  end
  object Label2: TLabel
    Left = 9
    Top = 32
    Width = 54
    Height = 12
    Caption = #26597#25214#33539#22260'&i'
  end
  object cbMatchType: TLabel
    Left = 9
    Top = 54
    Width = 42
    Height = 12
    Caption = #22823#23567#20889'&h'
  end
  object Label3: TLabel
    Left = 9
    Top = 76
    Width = 30
    Height = 12
    Caption = #26597#25214'&r'
  end
  object Label4: TLabel
    Left = 9
    Top = 118
    Width = 30
    Height = 12
    Caption = #26597#30475':'
  end
  object cbText: TDBComboBoxEh
    Left = 81
    Top = 8
    Width = 292
    Height = 20
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 0
    Text = 'cbText'
    Visible = True
    OnChange = cbTextChange
  end
  object bFind: TButton
    Left = 381
    Top = 8
    Width = 76
    Height = 22
    Caption = #19979#19968#20010'&F'
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 381
    Top = 34
    Width = 76
    Height = 20
    Cancel = True
    Caption = #20851#38381
    ModalResult = 2
    TabOrder = 7
    OnClick = bCancelClick
  end
  object cbFindIn: TDBComboBoxEh
    Left = 81
    Top = 30
    Width = 177
    Height = 20
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 1
    Text = 'cbFindIn'
    Visible = True
    OnChange = cbFindInChange
  end
  object cbMatchinType: TDBComboBoxEh
    Left = 81
    Top = 51
    Width = 133
    Height = 20
    EditButtons = <>
    Items.Strings = (
      #23383#31526#20018#30340#20219#24847#20301#32622
      #25972#20010#23383#31526#20018
      #23383#31526#20018#30340#22836#20301#32622)
    KeyItems.Strings = (
      'From any part of field'
      'Whole field'
      'From beging of field')
    TabOrder = 2
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 81
    Top = 73
    Width = 133
    Height = 20
    EditButtons = <>
    Items.Strings = (
      #21521#19978
      #21521#19979
      #20840#37096)
    KeyItems.Strings = (
      'Up'
      'Down'
      'All')
    TabOrder = 3
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 81
    Top = 97
    Width = 133
    Height = 13
    Caption = #24573#30053#22823#23567#20889'&C'
    TabOrder = 4
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 240
    Top = 97
    Width = 133
    Height = 13
    Caption = #24573#30053#26684#24335'&o'
    Checked = True
    State = cbChecked
    TabOrder = 5
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbcTreeFindRange: TDBComboBoxEh
    Left = 81
    Top = 114
    Width = 134
    Height = 20
    EditButtons = <>
    Items.Strings = (
      #25152#26377#33410#28857
      #23637#24320#30340#33410#28857
      #21516#31561#32423#33410#28857
      #24403#21069#33410#28857)
    KeyItems.Strings = (
      'In all nodes'
      'In expanded nodes'
      'In current level'
      'In current node')
    TabOrder = 8
    Visible = True
    OnChange = cbTextChange
  end
end
