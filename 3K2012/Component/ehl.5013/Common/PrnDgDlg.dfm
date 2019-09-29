object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 331
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Printer setup'
  ClientHeight = 185
  ClientWidth = 368
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
    Caption = ' &Margins '
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 19
      Height = 13
      Caption = '&Top'
    end
    object Label6: TLabel
      Left = 14
      Top = 51
      Width = 33
      Height = 13
      Caption = '&Bottom'
    end
    object Label7: TLabel
      Left = 14
      Top = 77
      Width = 18
      Height = 13
      Caption = '&Left'
    end
    object Label8: TLabel
      Left = 14
      Top = 102
      Width = 25
      Height = 13
      Caption = '&Right'
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
    Left = 174
    Top = 115
    Width = 161
    Height = 21
    TabOrder = 6
    Text = 'ePrintFont'
  end
  object cbAutoStretch: TCheckBox
    Left = 174
    Top = 92
    Width = 101
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Stretch long lines'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 9
    Top = 151
    Width = 80
    Height = 25
    Caption = '&Printer setup'
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
    Caption = '&Ok'
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
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 300
    Top = 92
    Width = 57
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Colored'
    TabOrder = 5
  end
  object rgFitingType: TRadioGroup
    Left = 172
    Top = 6
    Width = 185
    Height = 55
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      'Scale whole &grid'
      'C&hange column widths')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 184
    Top = 4
    Width = 145
    Height = 17
    Alignment = taLeftJustify
    Caption = '&Fits the width on one page'
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 234
    Top = 68
    Width = 123
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Optimal column &widths'
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 121
    Top = 65527
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 322
    Top = 144
  end
end
