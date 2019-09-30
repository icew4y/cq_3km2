object FrmLogin: TFrmLogin
  Left = 372
  Top = 160
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '3KM2D3D'#30331#38470#22120
  ClientHeight = 412
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 385
    Height = 273
    Caption = #28216#25103#21015#34920
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 160
      Width = 66
      Height = 12
      Caption = #26381#21153#22120#21517#31216':'
      Transparent = True
    end
    object Label2: TLabel
      Left = 8
      Top = 186
      Width = 66
      Height = 12
      Caption = #26381#21153#22120#22320#22336':'
      Transparent = True
    end
    object Label3: TLabel
      Left = 8
      Top = 212
      Width = 66
      Height = 12
      Caption = #26381#21153#22120#31471#21475':'
      Transparent = True
    end
    object ListView: TListView
      Left = 8
      Top = 16
      Width = 369
      Height = 129
      Columns = <
        item
          Caption = #21517#31216
          Width = 150
        end
        item
          Caption = #22320#22336
          Width = 150
        end
        item
          Caption = #31471#21475
          Width = 60
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewClick
    end
    object ButtonAdd: TButton
      Left = 8
      Top = 232
      Width = 73
      Height = 25
      Caption = #22686#21152
      TabOrder = 1
      OnClick = ButtonAddClick
    end
    object ButtonDel: TButton
      Left = 159
      Top = 232
      Width = 74
      Height = 25
      Caption = #21024#38500
      TabOrder = 2
      OnClick = ButtonDelClick
    end
    object ButtonSave: TButton
      Left = 302
      Top = 232
      Width = 75
      Height = 25
      Caption = #20445#23384
      TabOrder = 3
      OnClick = ButtonSaveClick
    end
    object EditServerAddr: TEdit
      Left = 80
      Top = 182
      Width = 297
      Height = 20
      Hint = #28216#25103#26381#21153#22120'IP'#22320#22336
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ParentFont = False
      TabOrder = 4
      Text = '127.0.0.1'
    end
    object EditServerPort: TEdit
      Left = 80
      Top = 208
      Width = 297
      Height = 20
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ParentFont = False
      TabOrder = 5
      Text = '7000'
    end
    object EditServerName: TEdit
      Left = 80
      Top = 156
      Width = 297
      Height = 20
      Hint = #28216#25103#26381#21153#22120#21517#31216
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ParentFont = False
      TabOrder = 6
      Text = '3K'#24341#25806
    end
  end
  object ButtonStart: TButton
    Left = 325
    Top = 376
    Width = 67
    Height = 25
    Caption = #30331#38470'(&L)'
    TabOrder = 1
    OnClick = ButtonStartClick
  end
  object ButtonClose: TButton
    Left = 8
    Top = 376
    Width = 65
    Height = 25
    Caption = #20851#38381
    TabOrder = 2
    OnClick = ButtonCloseClick
  end
  object CheckBoxWindowMode: TCheckBox
    Left = 96
    Top = 350
    Width = 73
    Height = 17
    Caption = #31383#21475#27169#24335
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object ComboBoxScreenMode: TComboBox
    Left = 184
    Top = 372
    Width = 89
    Height = 20
    Style = csDropDownList
    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 4
    Text = '800 * 600'
    Items.Strings = (
      '800 * 600'
      '1024 * 768'
      '900 * 600')
  end
  object RadioGroupVer: TRadioGroup
    Left = 8
    Top = 288
    Width = 385
    Height = 49
    Caption = #29256#26412
    Columns = 4
    ItemIndex = 2
    Items.Strings = (
      '1.76'#29256
      #21512#20987#29256
      #36830#20987#29256)
    TabOrder = 5
  end
  object ComboBoxBitCount: TComboBox
    Left = 184
    Top = 346
    Width = 89
    Height = 20
    Style = csDropDownList
    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 6
    Text = '32'#20301
    Items.Strings = (
      '32'#20301
      '16'#20301)
  end
  object CheckBoxVSync: TCheckBox
    Left = 96
    Top = 368
    Width = 65
    Height = 17
    Caption = #22402#30452#21516#27493
    TabOrder = 7
  end
  object CheckBoxD3DFormat: TCheckBox
    Left = 96
    Top = 384
    Width = 73
    Height = 17
    Caption = #32441#29702#21387#32553
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
end
