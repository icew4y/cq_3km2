object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 331
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #25171#21360#35774#32622
  ClientHeight = 185
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = fPrnDBGridEHSetupDialogShow
  PixelsPerInch = 96
  TextHeight = 12
  object gbPrintFields: TGroupBox
    Left = 8
    Top = 6
    Width = 149
    Height = 130
    Caption = #36793#30028' &M'
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 42
      Height = 12
      Caption = #19978#36793#30028'&T'
    end
    object Label6: TLabel
      Left = 14
      Top = 51
      Width = 42
      Height = 12
      Caption = #19979#36793#30028'&B'
    end
    object Label7: TLabel
      Left = 14
      Top = 77
      Width = 42
      Height = 12
      Caption = #24038#36793#30028'&L'
    end
    object Label8: TLabel
      Left = 14
      Top = 102
      Width = 42
      Height = 12
      Caption = #21491#36793#30028'&R'
    end
    object seUpMargin: TEdit
      Left = 62
      Top = 24
      Width = 70
      Height = 20
      TabOrder = 0
      Text = '0'
      OnExit = seMarginExit
    end
    object seLowMargin: TEdit
      Left = 62
      Top = 49
      Width = 70
      Height = 20
      TabOrder = 1
      Text = '0'
      OnExit = seMarginExit
    end
    object seLeftMargin: TEdit
      Left = 62
      Top = 73
      Width = 70
      Height = 20
      TabOrder = 2
      Text = '0'
      OnExit = seMarginExit
    end
    object seRightMargin: TEdit
      Left = 62
      Top = 98
      Width = 70
      Height = 20
      TabOrder = 3
      Text = '0'
      OnExit = seMarginExit
    end
  end
  object ePrintFont: TEdit
    Left = 174
    Top = 115
    Width = 161
    Height = 20
    TabOrder = 6
    Text = 'ePrintFont'
  end
  object cbAutoStretch: TCheckBox
    Left = 204
    Top = 92
    Width = 71
    Height = 17
    Alignment = taLeftJustify
    Caption = #32553#25918#38271#34892'&S'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 9
    Top = 151
    Width = 80
    Height = 25
    Caption = #25171#21360#26426#35774#32622'&P'
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
    Font.Name = 'Tahoma'
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
    Caption = #30830#23450'&O'
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
    Caption = #21462#28040'&C'
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 284
    Top = 92
    Width = 73
    Height = 17
    Alignment = taLeftJustify
    Caption = #25171#21360#39068#33394'&C'
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
      #32553#25918#25972#20010#34920#26684'&G'
      #32553#25918#21015#23485'&H')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 184
    Top = 4
    Width = 145
    Height = 17
    Alignment = taLeftJustify
    Caption = #32553#25918#21040#39029#38754#23485#24230'&F'
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 284
    Top = 68
    Width = 73
    Height = 17
    Alignment = taLeftJustify
    Caption = #20248#21270#21015#23485'&W'
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 121
    Top = 65527
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 322
    Top = 144
  end
end
