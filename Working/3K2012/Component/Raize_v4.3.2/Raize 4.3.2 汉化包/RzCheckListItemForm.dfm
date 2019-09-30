object RzCheckItemEditDlg: TRzCheckItemEditDlg
  Left = 226
  Top = 118
  BorderStyle = bsDialog
  Caption = 'Item'
  ClientHeight = 74
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TRzLabel
    Left = 8
    Top = 12
    Width = 27
    Height = 13
    Caption = '&Item'
    FocusControl = EdtItem
  end
  object BtnOK: TRzButton
    Left = 184
    Top = 40
    Default = True
    ModalResult = 1
    Caption = 'OK'
    HotTrack = True
    TabOrder = 2
  end
  object BtnCancel: TRzButton
    Left = 266
    Top = 40
    Cancel = True
    ModalResult = 2
    Caption = 'Cancel'
    HotTrack = True
    TabOrder = 3
  end
  object EdtItem: TRzMemo
    Left = 40
    Top = 8
    Width = 301
    Height = 21
    TabOrder = 0
    WantReturns = False
    WantTabs = True
    WordWrap = False
    FrameVisible = True
  end
  object ChkAsGroup: TRzCheckBox
    Left = 40
    Top = 44
    Width = 81
    Height = 17
    Caption = 'As &Group'
    HotTrack = True
    State = cbUnchecked
    TabOrder = 1
  end
end
