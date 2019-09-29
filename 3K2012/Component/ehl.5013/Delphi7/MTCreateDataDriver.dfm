object fMTCreateDataDriver: TfMTCreateDataDriver
  Left = 536
  Top = 249
  BorderStyle = bsDialog
  Caption = 'Create new TDataDriver component on the Form'
  ClientHeight = 288
  ClientWidth = 409
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 18
    Top = 55
    Width = 143
    Height = 16
    Caption = 'List of available dataset'#39's'
  end
  object Label2: TLabel
    Left = 222
    Top = 55
    Width = 166
    Height = 16
    Caption = 'List of availbale TDataDrivers'
  end
  object Bevel1: TBevel
    Left = 10
    Top = 240
    Width = 395
    Height = 2
  end
  object Label3: TLabel
    Left = 18
    Top = 3
    Width = 352
    Height = 36
    AutoSize = False
    Caption = 
      'Select DataSet from left list and TDataDriver from right list to create DataDriver:'
    WordWrap = True
  end
  object DataSetList: TListBox
    Left = 18
    Top = 76
    Width = 164
    Height = 153
    ItemHeight = 16
    TabOrder = 0
  end
  object DataDriversList: TListBox
    Left = 222
    Top = 76
    Width = 148
    Height = 154
    ItemHeight = 16
    TabOrder = 1
  end
  object OkBtn: TButton
    Left = 209
    Top = 250
    Width = 93
    Height = 31
    Caption = 'Create'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = OkBtnClick
  end
  object CancelBtn: TButton
    Left = 308
    Top = 250
    Width = 92
    Height = 31
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
