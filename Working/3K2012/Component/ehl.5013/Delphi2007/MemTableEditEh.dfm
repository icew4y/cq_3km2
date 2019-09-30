object MemTableDataForm: TMemTableDataForm
  Left = 261
  Top = 157
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Client DataSet Data'
  ClientHeight = 191
  ClientWidth = 254
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 9
    Top = 3
    Width = 235
    Height = 143
    Caption = ' Assign Data From '
    TabOrder = 0
    object DataSetList: TListBox
      Left = 8
      Top = 19
      Width = 218
      Height = 115
      Enabled = False
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnDblClick = DataSetListDblClick
      OnKeyPress = DataSetListKeyPress
    end
  end
  object OkBtn: TButton
    Left = 11
    Top = 153
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 1
    OnClick = OkBtnClick
  end
  object CancelBtn: TButton
    Left = 90
    Top = 153
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object HelpBtn: TButton
    Left = 169
    Top = 153
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
    OnClick = HelpBtnClick
  end
end
