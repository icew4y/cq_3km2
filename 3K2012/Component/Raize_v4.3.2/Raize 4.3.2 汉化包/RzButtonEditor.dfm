object RzButtonEditDlg: TRzButtonEditDlg
  Left = 184
  Top = 116
  BorderStyle = bsDialog
  Caption = ' - Button Editor'
  ClientHeight = 314
  ClientWidth = 567
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GrpPreview: TRzGroupBox
    Left = 8
    Top = 200
    Width = 277
    Caption = 'Preview'
    TabOrder = 7
    object BtnPreview: TRzButton
      Left = 8
      Top = 16
      TabOrder = 0
    end
  end
  object BtnOK: TRzButton
    Left = 392
    Top = 280
    ModalResult = 1
    Caption = 'OK'
    HotTrack = True
    TabOrder = 8
  end
  object BtnCancel: TRzButton
    Left = 480
    Top = 280
    Cancel = True
    ModalResult = 2
    Caption = 'Cancel'
    HotTrack = True
    TabOrder = 9
  end
  object GrpModalResult: TRzRadioGroup
    Left = 296
    Top = 116
    Width = 261
    Height = 149
    Caption = 'Modal Result'
    Columns = 2
    ItemHotTrack = True
    ItemIndex = 0
    Items.Strings = (
      'mrNone'
      'mrOk'
      'mrCancel'
      'mrAbort'
      'mrRetry'
      'mrIgnore'
      'mrYes'
      'mrNo'
      'mrAll'
      'mrNoToAll'
      'mrYesToAll'
      'Custom')
    TabOrder = 4
    OnClick = GrpModalResultClick
  end
  object GrpSize: TRzGroupBox
    Left = 8
    Top = 116
    Width = 277
    Height = 77
    Caption = 'Size'
    TabOrder = 3
    object LblWidth: TRzLabel
      Left = 76
      Top = 50
      Width = 30
      Height = 12
      Caption = 'Width'
      Enabled = False
      ParentColor = False
    end
    object LblHeight: TRzLabel
      Left = 176
      Top = 50
      Width = 36
      Height = 12
      Caption = 'Height'
      Enabled = False
      ParentColor = False
    end
    object OptStandardSize: TRzRadioButton
      Left = 8
      Top = 20
      Width = 133
      Height = 17
      Caption = 'Standard (75 x 25)'
      Checked = True
      HotTrack = True
      TabOrder = 0
      TabStop = True
      OnClick = ButtonSizeClick
    end
    object OptLargeSize: TRzRadioButton
      Left = 148
      Top = 20
      Width = 117
      Height = 17
      Caption = 'Large (100 x 35)'
      HotTrack = True
      TabOrder = 1
      OnClick = ButtonSizeClick
    end
    object OptCustomSize: TRzRadioButton
      Left = 8
      Top = 48
      Width = 65
      Height = 17
      Caption = 'Custom'
      HotTrack = True
      TabOrder = 2
      OnClick = ButtonSizeClick
    end
    object SpnWidth: TRzSpinEdit
      Left = 112
      Top = 48
      Width = 47
      Height = 20
      AllowKeyEdit = True
      ButtonDownGlyph.Data = {
        BE000000424DBE00000000000000760000002800000012000000060000000100
        0400000000004800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555550000005555055555555855550000005550005555558885550000005500
        0005555888885500000050000000558888888500000055555555555555555500
        0000}
      ButtonDownNumGlyphs = 2
      ButtonUpGlyph.Data = {
        BE000000424DBE00000000000000760000002800000012000000060000000100
        0400000000004800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555550000005000000055888888850000005500000555588888550000005550
        0055555588855500000055550555555558555500000055555555555555555500
        0000}
      ButtonUpNumGlyphs = 2
      Max = 250.000000000000000000
      Value = 4.000000000000000000
      Enabled = False
      FlatButtons = True
      FrameVisible = True
      TabOrder = 3
      OnChange = SpnWidthChange
    end
    object SpnHeight: TRzSpinEdit
      Left = 220
      Top = 48
      Width = 47
      Height = 20
      AllowKeyEdit = True
      ButtonDownGlyph.Data = {
        BE000000424DBE00000000000000760000002800000012000000060000000100
        0400000000004800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555550000005555055555555855550000005550005555558885550000005500
        0005555888885500000050000000558888888500000055555555555555555500
        0000}
      ButtonDownNumGlyphs = 2
      ButtonUpGlyph.Data = {
        BE000000424DBE00000000000000760000002800000012000000060000000100
        0400000000004800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555550000005000000055888888850000005500000555588888550000005550
        0055555588855500000055550555555558555500000055555555555555555500
        0000}
      ButtonUpNumGlyphs = 2
      Value = 4.000000000000000000
      Enabled = False
      FlatButtons = True
      FrameVisible = True
      TabOrder = 4
      OnChange = SpnHeightChange
    end
  end
  object GrpSpecial: TRzGroupBox
    Left = 296
    Top = 8
    Width = 261
    Height = 101
    Caption = 'Special Buttons'
    TabOrder = 2
    object BtnOKTemplate: TRzButton
      Left = 8
      Top = 20
      Caption = 'OK'
      HotTrack = True
      TabOrder = 0
      OnClick = BtnOKTemplateClick
    end
    object BtnCancelTemplate: TRzButton
      Left = 92
      Top = 20
      Caption = 'Cancel'
      HotTrack = True
      TabOrder = 1
      OnClick = BtnCancelTemplateClick
    end
    object BtnHelpTemplate: TRzButton
      Left = 176
      Top = 20
      Caption = '&Help'
      HotTrack = True
      TabOrder = 2
      OnClick = BtnHelpTemplateClick
    end
    object BtnYesTemplate: TRzButton
      Left = 8
      Top = 56
      Caption = '&Yes'
      HotTrack = True
      TabOrder = 3
      OnClick = BtnYesTemplateClick
    end
    object BtnNoTemplate: TRzButton
      Left = 92
      Top = 56
      Caption = '&No'
      HotTrack = True
      TabOrder = 4
      OnClick = BtnNoTemplateClick
    end
  end
  object GrpKeyboard: TRzGroupBox
    Left = 8
    Top = 64
    Width = 277
    Height = 45
    Caption = 'Keyboard Interaction'
    TabOrder = 1
    object Label1: TRzLabel
      Left = 8
      Top = 20
      Width = 108
      Height = 12
      Caption = 'Button clicked if '
      ParentColor = False
    end
    object Label4: TRzLabel
      Left = 140
      Top = 20
      Width = 6
      Height = 12
      Caption = '/'
      ParentColor = False
    end
    object Label5: TRzLabel
      Left = 212
      Top = 20
      Width = 48
      Height = 12
      Caption = 'pressed.'
      ParentColor = False
    end
    object ChkDefault: TRzCheckBox
      Left = 91
      Top = 19
      Width = 49
      Height = 17
      Caption = 'Enter'
      HotTrack = True
      State = cbUnchecked
      TabOrder = 0
      OnClick = ChkDefaultClick
    end
    object ChkCancel: TRzCheckBox
      Left = 151
      Top = 19
      Width = 61
      Height = 17
      Caption = 'Escape'
      HotTrack = True
      State = cbUnchecked
      TabOrder = 1
      OnClick = ChkCancelClick
    end
  end
  object GrpCaption: TRzGroupBox
    Left = 8
    Top = 8
    Width = 277
    Height = 49
    Caption = 'Caption'
    TabOrder = 0
    object EdtCaption: TRzEdit
      Left = 8
      Top = 20
      Width = 261
      Height = 20
      FrameVisible = True
      TabOrder = 0
      OnChange = EdtCaptionChange
    end
  end
  object ChkEnabled: TRzCheckBox
    Left = 296
    Top = 280
    Width = 69
    Height = 17
    Caption = 'Enabled'
    HotTrack = True
    State = cbUnchecked
    TabOrder = 6
    OnClick = ChkEnabledClick
  end
  object SpnModalResult: TRzSpinEdit
    Left = 500
    Top = 236
    Width = 47
    Height = 20
    AllowKeyEdit = True
    ButtonDownGlyph.Data = {
      BE000000424DBE00000000000000760000002800000012000000060000000100
      0400000000004800000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555550000005555055555555855550000005550005555558885550000005500
      0005555888885500000050000000558888888500000055555555555555555500
      0000}
    ButtonDownNumGlyphs = 2
    ButtonUpGlyph.Data = {
      BE000000424DBE00000000000000760000002800000012000000060000000100
      0400000000004800000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555550000005000000055888888850000005500000555588888550000005550
      0055555588855500000055550555555558555500000055555555555555555500
      0000}
    ButtonUpNumGlyphs = 2
    Enabled = False
    FlatButtons = True
    FrameVisible = True
    TabOrder = 5
  end
end
