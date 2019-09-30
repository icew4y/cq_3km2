object FrmAddGameList: TFrmAddGameList
  Left = 363
  Top = 317
  Width = 343
  Height = 275
  Caption = 'FrmAddGameList'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object grp1: TGroupBox
    Left = 8
    Top = 8
    Width = 320
    Height = 227
    TabOrder = 0
    object Label1: TLabel
      Left = 12
      Top = 22
      Width = 72
      Height = 12
      Caption = #26381#21153#22120#21517#31216#65306
    end
    object Label2: TLabel
      Left = 12
      Top = 44
      Width = 84
      Height = 12
      Caption = #26381#21153#22120'IP'#22320#22336#65306
    end
    object Label3: TLabel
      Left = 12
      Top = 66
      Width = 72
      Height = 12
      Caption = #26381#21153#22120#31471#21475#65306
    end
    object Label4: TLabel
      Left = 12
      Top = 89
      Width = 78
      Height = 12
      Caption = #20844' '#21578' '#22320' '#22336#65306
    end
    object Label5: TLabel
      Left = 12
      Top = 111
      Width = 78
      Height = 12
      Caption = #32593' '#31449' '#20027' '#39029#65306
    end
    object Label6: TLabel
      Left = 12
      Top = 151
      Width = 78
      Height = 12
      Caption = #25152' '#23646' '#20998' '#32452#65306
    end
    object Label7: TLabel
      Left = 12
      Top = 172
      Width = 78
      Height = 12
      Caption = #32593' '#20851' '#23494' '#30721#65306
    end
    object Label8: TLabel
      Left = 12
      Top = 130
      Width = 78
      Height = 12
      Caption = #35013' '#22791' '#23637' '#31034#65306
    end
    object EdtServerName: TEdit
      Left = 94
      Top = 18
      Width = 147
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object EdtServerIP: TEdit
      Left = 94
      Top = 39
      Width = 146
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
    end
    object EdtServerNoticeURL: TEdit
      Left = 94
      Top = 85
      Width = 211
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
    object EdtServerHomeURL: TEdit
      Left = 94
      Top = 106
      Width = 211
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 4
    end
    object ComBoBoxServerArray: TComboBox
      Left = 94
      Top = 148
      Width = 145
      Height = 18
      Style = csOwnerDrawFixed
      ItemHeight = 12
      TabOrder = 6
    end
    object EdtGatePass: TEdit
      Left = 94
      Top = 169
      Width = 146
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 7
    end
    object BtnOK: TButton
      Left = 56
      Top = 194
      Width = 75
      Height = 25
      Caption = #30830#23450'(&O)'
      TabOrder = 8
      OnClick = BtnOKClick
    end
    object BtnCancel: TButton
      Left = 176
      Top = 194
      Width = 75
      Height = 25
      Caption = #21462#28040'(&C)'
      TabOrder = 9
      OnClick = BtnCancelClick
    end
    object EdtServerPort: TEdit
      Left = 94
      Top = 62
      Width = 53
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      OnKeyPress = EdtServerPortKeyPress
    end
    object EdtGameItemsURL: TEdit
      Left = 94
      Top = 127
      Width = 211
      Height = 18
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 5
    end
  end
end
