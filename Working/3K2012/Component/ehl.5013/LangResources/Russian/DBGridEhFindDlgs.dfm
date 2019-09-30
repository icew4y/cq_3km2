object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 236
  Top = 110
  BorderStyle = bsDialog
  Caption = 'Поиск'
  ClientHeight = 141
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 9
    Top = 11
    Width = 54
    Height = 12
    Caption = '&Образец:'
  end
  object Label2: TLabel
    Left = 9
    Top = 32
    Width = 49
    Height = 12
    Caption = '&Поиск в:'
  end
  object cbMatchType: TLabel
    Left = 9
    Top = 53
    Width = 74
    Height = 12
    Caption = '&Совпадение:'
  end
  object Label3: TLabel
    Left = 9
    Top = 76
    Width = 58
    Height = 12
    Caption = 'Прос&мотр:'
  end
  object Label4: TLabel
    Left = 8
    Top = 119
    Width = 97
    Height = 12
    Caption = 'Искать в дереве:'
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
    Left = 380
    Top = 8
    Width = 80
    Height = 22
    Caption = 'На&йти далее'
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 380
    Top = 35
    Width = 80
    Height = 22
    Cancel = True
    Caption = 'Закрыть'
    ModalResult = 2
    TabOrder = 7
    OnClick = bCancelClick
  end
  object cbFindIn: TDBComboBoxEh
    Left = 81
    Top = 29
    Width = 178
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
    Width = 134
    Height = 20
    EditButtons = <>
    Items.Strings = (
      'С любой части поля'
      'Поля целиком'
      'С начала поля')
    KeyItems.Strings = (
      'С любой части поля'
      'Поля целиком'
      'С начала поля')
    TabOrder = 2
    Text = 'С любой части поля'
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 81
    Top = 73
    Width = 134
    Height = 20
    EditButtons = <>
    Items.Strings = (
      'Вверх'
      'Вниз'
      'Все')
    KeyItems.Strings = (
      'Вверх'
      'Вниз'
      'Все')
    TabOrder = 3
    Text = 'Все'
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 81
    Top = 97
    Width = 134
    Height = 13
    Caption = 'С учетом ре&гистра'
    TabOrder = 4
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 240
    Top = 97
    Width = 133
    Height = 13
    Caption = 'С у&четом формата'
    Checked = True
    State = cbChecked
    TabOrder = 5
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbcTreeFindRange: TDBComboBoxEh
    Left = 112
    Top = 115
    Width = 140
    Height = 20
    EditButtons = <>
    Items.Strings = (
      'Во всех ветвях'
      'В раскрытых ветвях'
      'В текущем уровне'
      'В текущей ветке')
    KeyItems.Strings = (
      'Во всех ветвях'
      'В раскрытых ветвях'
      'В текущем уровне'
      'В текущей ветке')
    TabOrder = 8
    Text = 'Во всех ветвях'
    Visible = True
    OnChange = cbTextChange
  end
end
