object RzCheckListEditDlg: TRzCheckListEditDlg
  Left = 191
  Top = 117
  BorderStyle = bsDialog
  Caption = ' - Check List Editor'
  ClientHeight = 352
  ClientWidth = 438
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
  TextHeight = 13
  object GrpPreview: TRzGroupBox
    Left = 8
    Top = 8
    Width = 421
    Height = 297
    Caption = 'Preview'
    TabOrder = 0
    object LstPreview: TRzCheckList
      Left = 8
      Top = 16
      Width = 313
      Height = 249
      FrameVisible = True
      ItemHeight = 15
      TabOrder = 0
      OnClick = LstPreviewClick
    end
    object ChkItemEnabled: TRzCheckBox
      Left = 8
      Top = 272
      Width = 101
      Height = 17
      Caption = 'Item Enabled'
      Checked = True
      Enabled = False
      HotTrack = True
      State = cbChecked
      TabOrder = 9
      OnClick = ChkItemEnabledClick
    end
    object BtnAdd: TRzButton
      Left = 328
      Top = 16
      Width = 85
      Caption = '&Add...'
      HotTrack = True
      TabOrder = 1
      OnClick = BtnAddClick
    end
    object BtnEdit: TRzButton
      Left = 328
      Top = 45
      Width = 85
      Caption = '&Edit...'
      HotTrack = True
      TabOrder = 2
      OnClick = BtnEditClick
    end
    object BtnDelete: TRzButton
      Left = 328
      Top = 78
      Width = 85
      Caption = '&Delete'
      HotTrack = True
      TabOrder = 3
      OnClick = BtnDeleteClick
    end
    object BtnMoveUp: TRzButton
      Left = 328
      Top = 144
      Width = 85
      Caption = 'Move &Up'
      HotTrack = True
      TabOrder = 5
      OnClick = BtnMoveUpClick
    end
    object BtnMoveDown: TRzButton
      Left = 328
      Top = 173
      Width = 85
      Caption = 'Move &Down'
      HotTrack = True
      TabOrder = 6
      OnClick = BtnMoveDownClick
    end
    object BtnLoad: TRzButton
      Left = 328
      Top = 210
      Width = 85
      Caption = '&Load'
      HotTrack = True
      TabOrder = 7
      OnClick = BtnLoadClick
    end
    object ChkConvertToGroup: TRzCheckBox
      Left = 136
      Top = 272
      Width = 129
      Height = 17
      Caption = 'Convert to &Group'
      Enabled = False
      HotTrack = True
      State = cbUnchecked
      TabOrder = 10
      OnClick = ChkConvertToGroupClick
    end
    object BtnSave: TRzButton
      Left = 328
      Top = 239
      Width = 85
      Caption = '&Save'
      HotTrack = True
      TabOrder = 8
      OnClick = BtnSaveClick
    end
    object BtnClear: TRzButton
      Left = 328
      Top = 107
      Width = 85
      Caption = '&Clear'
      HotTrack = True
      TabOrder = 4
      OnClick = BtnClearClick
    end
  end
  object BtnClose: TRzButton
    Left = 354
    Top = 316
    ModalResult = 1
    Caption = 'Close'
    HotTrack = True
    TabOrder = 2
  end
  object ChkAllowGrayed: TRzCheckBox
    Left = 8
    Top = 316
    Width = 145
    Height = 17
    Caption = 'Allow Grayed States'
    HotTrack = True
    State = cbUnchecked
    TabOrder = 1
    OnClick = ChkAllowGrayedClick
  end
  object DlgOpen: TRzOpenDialog
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 228
    Top = 308
  end
  object DlgSave: TRzSaveDialog
    Filter = 'Text Files|*.txt|All Files|*.*'
    Left = 264
    Top = 308
  end
end
