object fSelectFromListDialog: TfSelectFromListDialog
  Left = 419
  Top = 238
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 199
  ClientWidth = 350
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 334
    Height = 146
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object OKBtn: TButton
    Left = 186
    Top = 167
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 266
    Top = 167
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 18
    Top = 18
    Width = 312
    Height = 126
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 2
  end
end
