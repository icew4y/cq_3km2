object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 331
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Настройка принтера'
  ClientHeight = 185
  ClientWidth = 368
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnShow = fPrnDBGridEHSetupDialogShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbPrintFields: TGroupBox
    Left = 8
    Top = 6
    Width = 149
    Height = 130
    Caption = ' &Отступы '
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 42
      Height = 13
      Caption = '&Верхний'
    end
    object Label6: TLabel
      Left = 14
      Top = 51
      Width = 40
      Height = 13
      Caption = '&Нижний'
    end
    object Label7: TLabel
      Left = 14
      Top = 77
      Width = 34
      Height = 13
      Caption = '&Левый'
    end
    object Label8: TLabel
      Left = 14
      Top = 102
      Width = 40
      Height = 13
      Caption = '&Правый'
    end
    object seUpMargin: TEdit
      Left = 62
      Top = 24
      Width = 70
      Height = 21
      TabOrder = 0
      Text = '0'
      OnExit = seMarginExit
    end
    object seLowMargin: TEdit
      Left = 62
      Top = 49
      Width = 70
      Height = 21
      TabOrder = 1
      Text = '0'
      OnExit = seMarginExit
    end
    object seLeftMargin: TEdit
      Left = 62
      Top = 73
      Width = 70
      Height = 21
      TabOrder = 2
      Text = '0'
      OnExit = seMarginExit
    end
    object seRightMargin: TEdit
      Left = 62
      Top = 98
      Width = 70
      Height = 21
      TabOrder = 3
      Text = '0'
      OnExit = seMarginExit
    end
  end
  object ePrintFont: TEdit
    Left = 166
    Top = 115
    Width = 169
    Height = 21
    TabOrder = 6
    Text = 'ePrintFont'
  end
  object cbAutoStretch: TCheckBox
    Left = 164
    Top = 92
    Width = 139
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Перенос &длинных строк'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 9
    Top = 151
    Width = 120
    Height = 25
    Caption = 'Н&астройка принтера'
    TabOrder = 8
    OnClick = bPrinterSetupDialogClick
  end
  object bPrintFont: TButton
    Left = 336
    Top = 115
    Width = 23
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = bPrintFontClick
  end
  object bOk: TButton
    Left = 191
    Top = 151
    Width = 80
    Height = 26
    Caption = 'О&к'
    Default = True
    ModalResult = 1
    TabOrder = 9
  end
  object bCancel: TButton
    Left = 279
    Top = 151
    Width = 80
    Height = 26
    Cancel = True
    Caption = 'О&тмена'
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 314
    Top = 92
    Width = 43
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Цвет'
    TabOrder = 5
  end
  object rgFitingType: TRadioGroup
    Left = 166
    Top = 6
    Width = 193
    Height = 55
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Масштабировать всю таблицу'
      'Изменять ширину столбцов')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 178
    Top = 4
    Width = 163
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Умещать в ширину на листе'
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 180
    Top = 68
    Width = 177
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Оптимальная ширина столбцов'
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 113
    Top = 65533
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 130
    Top = 148
  end
end
