object FrmMain: TFrmMain
  Left = 403
  Top = 151
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #30331#38470#22120#21644#32593#20851#27979#35797
  ClientHeight = 415
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 393
    Height = 281
    Caption = #30331#38470#22120#37197#32622
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 72
      Height = 12
      Caption = #30331#38470#22120#21517#31216#65306
    end
    object Label2: TLabel
      Left = 8
      Top = 45
      Width = 72
      Height = 12
      Caption = #23458#25143#31471#25991#20214#65306
    end
    object Label3: TLabel
      Left = 8
      Top = 173
      Width = 84
      Height = 12
      Caption = #20869#25346#36807#28388#25991#20214#65306
    end
    object Label4: TLabel
      Left = 8
      Top = 195
      Width = 72
      Height = 12
      Caption = #30331#38470#22120#30382#32932#65306
    end
    object Label5: TLabel
      Left = 8
      Top = 216
      Width = 72
      Height = 12
      Caption = #30331#38470#22120#25991#20214#65306
    end
    object Label6: TLabel
      Left = 8
      Top = 67
      Width = 84
      Height = 12
      Caption = #28216#25103#21015#34920#22320#22336#65306
    end
    object Label7: TLabel
      Left = 8
      Top = 88
      Width = 84
      Height = 12
      Caption = #28216#25103#22791#29992#22320#22336#65306
    end
    object Label8: TLabel
      Left = 8
      Top = 109
      Width = 84
      Height = 12
      Caption = #26356#26032#21015#34920#22320#22336#65306
    end
    object Label9: TLabel
      Left = 8
      Top = 131
      Width = 96
      Height = 12
      Caption = #21453#22806#25346#21015#34920#22320#22336#65306
    end
    object Label10: TLabel
      Left = 8
      Top = 152
      Width = 90
      Height = 12
      Caption = 'E'#31995#32479#28909#28857#22320#22336#65306
    end
    object Label13: TLabel
      Left = 8
      Top = 238
      Width = 84
      Height = 12
      Caption = #22871#35013#25552#31034#25991#20214#65306
    end
    object Label14: TLabel
      Left = 8
      Top = 260
      Width = 84
      Height = 12
      Caption = #32463#32476#25552#31034#25991#20214#65306
    end
    object EdtLoginName: TEdit
      Left = 96
      Top = 19
      Width = 289
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 0
      Text = #26412#22320#27979#35797
    end
    object EdtClientFileName: TEdit
      Left = 96
      Top = 40
      Width = 229
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 1
    end
    object Button1: TButton
      Left = 325
      Top = 40
      Width = 60
      Height = 22
      Caption = #38543#26426#21462#21517
      TabOrder = 2
      OnClick = Button1Click
    end
    object EdtGameListURL: TEdit
      Left = 96
      Top = 62
      Width = 289
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 3
      Text = 'http://127.0.0.1/QKServerList.txt'
    end
    object BtnAssistantFilter: TButton
      Left = 360
      Top = 167
      Width = 25
      Height = 22
      Caption = '...'
      TabOrder = 4
      OnClick = BtnAssistantFilterClick
    end
    object EdtBakGameListURL: TEdit
      Left = 96
      Top = 83
      Width = 289
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 5
      Text = 'http://127.0.0.1/BakQKServerList.txt'
    end
    object BtnLoginMainImages: TButton
      Left = 360
      Top = 189
      Width = 25
      Height = 22
      Caption = '...'
      TabOrder = 6
      OnClick = BtnLoginMainImagesClick
    end
    object EdtPatchListURL: TEdit
      Left = 96
      Top = 105
      Width = 289
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 7
      Text = 'http://127.0.0.1/QKPatchList.txt'
    end
    object BtnLoginFile: TButton
      Left = 360
      Top = 211
      Width = 25
      Height = 22
      Caption = '...'
      TabOrder = 8
      OnClick = BtnLoginFileClick
    end
    object EdtGameMonListURL: TEdit
      Left = 96
      Top = 126
      Width = 289
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 9
      Text = 'http://127.0.0.1/QKGameMonList.txt'
    end
    object EdtGameESystem: TEdit
      Left = 96
      Top = 148
      Width = 289
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 10
      Text = 'http://127.0.0.1/rdxt.htm'
    end
    object EdtAssistantFilter: TEdit
      Left = 96
      Top = 169
      Width = 265
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 11
    end
    object EdtLoginMainImages: TEdit
      Left = 96
      Top = 191
      Width = 265
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 12
      Text = 'D:\'#30382#32932#25991#20214'\1.3kskin'
    end
    object EdtLoginFile: TEdit
      Left = 96
      Top = 212
      Width = 265
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 13
      Text = 'E:\GameLogin.exe'
    end
    object EdtTzHintFile: TEdit
      Left = 96
      Top = 234
      Width = 265
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 14
    end
    object BtnTzHintFile: TButton
      Left = 360
      Top = 233
      Width = 25
      Height = 22
      Caption = '...'
      TabOrder = 15
      OnClick = BtnTzHintFileClick
    end
    object EdtPulsDescFile: TEdit
      Left = 96
      Top = 256
      Width = 265
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 16
    end
    object BtnPulsDescFile: TButton
      Left = 360
      Top = 255
      Width = 25
      Height = 22
      Caption = '...'
      TabOrder = 17
      OnClick = BtnPulsDescFileClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 335
    Width = 393
    Height = 43
    Caption = #20844#20849#20449#24687
    TabOrder = 1
    object Label11: TLabel
      Left = 8
      Top = 19
      Width = 48
      Height = 12
      Caption = #23553#21253#30721#65306
    end
    object EdtGatePass: TEdit
      Left = 56
      Top = 15
      Width = 255
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 0
      Text = 'DNRA9NA817RM12VRD3WB'
    end
    object Button5: TButton
      Left = 311
      Top = 14
      Width = 75
      Height = 22
      Caption = #38543#26426#23553#21253#30721
      TabOrder = 1
      OnClick = Button5Click
    end
  end
  object BtnMakeLogin: TButton
    Left = 145
    Top = 382
    Width = 120
    Height = 25
    Caption = #29983#25104#30331#38470#22120'(&L)'
    TabOrder = 2
    OnClick = BtnMakeLoginClick
  end
  object BtnMakeGate: TButton
    Left = 280
    Top = 382
    Width = 121
    Height = 25
    Caption = #29983#25104#32593#20851'(&G)'
    TabOrder = 3
    OnClick = BtnMakeGateClick
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 291
    Width = 393
    Height = 41
    Caption = #32593#20851#37197#32622
    TabOrder = 4
    object Label12: TLabel
      Left = 9
      Top = 19
      Width = 60
      Height = 12
      Caption = #32593#20851#25991#20214#65306
    end
    object EdtGateFile: TEdit
      Left = 67
      Top = 15
      Width = 293
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 0
      Text = 'D:\'#36830#20987'-MirServer\LoginGate\LoginGate.exe'
    end
    object BtnGateFile: TButton
      Left = 360
      Top = 14
      Width = 25
      Height = 22
      Caption = '...'
      TabOrder = 1
      OnClick = BtnGateFileClick
    end
  end
  object CheckBoxFD: TCheckBox
    Left = 32
    Top = 384
    Width = 74
    Height = 17
    Caption = #38598#25104#39118#30462
    TabOrder = 5
  end
  object OpenDialog1: TOpenDialog
    Title = #25171#24320
    Left = 4
    Top = 65535
  end
  object RSA1: TRSA
    CommonalityKey = '45127'
    CommonalityMode = '697585576183253336471979032351'
    PrivateKey = '404713097398326019320821216863'
    Server = True
    Left = 16
    Top = 224
  end
end
