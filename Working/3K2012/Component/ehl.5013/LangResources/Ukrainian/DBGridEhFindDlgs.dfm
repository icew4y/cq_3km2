object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 273
  Top = 305
  BorderStyle = bsDialog
  Caption = 'Знайти текст'
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
    Caption = '&Зразок:'
  end
  object Label2: TLabel
    Left = 10
    Top = 35
    Width = 34
    Height = 13
    Caption = '&Пошук в:'
  end
  object cbMatchType: TLabel
    Left = 10
    Top = 58
    Width = 33
    Height = 13
    Caption = '&Співпадання:'
  end
  object Label3: TLabel
    Left = 10
    Top = 82
    Width = 37
    Height = 13
    Caption = 'По&шук:'
  end
  object Label4: TLabel
    Left = 10
    Top = 128
    Width = 59
    Height = 13
    Caption = 'Знайти в де&реві:'
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
    Caption = 'Знайти &далі'
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 413
    Top = 37
    Width = 82
    Height = 22
    Cancel = True
    Caption = 'Закрити'
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
      'З будь-якої частини поля'
      'Всього поля'
      'З початку поля')
    KeyItems.Strings = (
      'З будь-якої частини поля'
      'Всього поля'
      'З початку поля')
    TabOrder = 2
    Text = 'З будь-якої частини поля'
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 88
    Top = 79
    Width = 144
    Height = 21
    EditButtons = <>
    Items.Strings = (
      'Вверх'
      'Вниз'
      'Усі')
    KeyItems.Strings = (
      'Вверх'
      'Вниз'
      'Усі')
    TabOrder = 3
    Text = 'Усі'
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 88
    Top = 105
    Width = 144
    Height = 14
    Caption = 'Враховуючи &регістр'
    TabOrder = 4
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 260
    Top = 105
    Width = 144
    Height = 14
    Caption = 'Враховуючи &формат'
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
      'В усіх вузлах'
      'В розкритих вузлах'
      'В поточному рівні'
      'В поточному вузлі')
    KeyItems.Strings = (
      'В усіх вузлах'
      'В розкритих вузлах'
      'В поточному рівні'
      'В поточному вузлі')
    TabOrder = 8
    Text = 'В усіх вузлах'
    Visible = True
    OnChange = cbTextChange
  end
end

