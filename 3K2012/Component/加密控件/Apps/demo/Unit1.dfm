object Form1: TForm1
  Left = 192
  Top = 107
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = #21152#23494#28436#31034
  ClientHeight = 286
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox3: TGroupBox
    Left = 32
    Top = 208
    Width = 353
    Height = 57
    Caption = #35299#23494#26126#25991
    TabOrder = 6
  end
  object GroupBox2: TGroupBox
    Left = 32
    Top = 144
    Width = 353
    Height = 57
    Caption = #21152#23494#23494#25991
    TabOrder = 5
  end
  object GroupBox1: TGroupBox
    Left = 32
    Top = 16
    Width = 353
    Height = 121
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 60
      Height = 13
      Caption = #36816#31639#35268#21017'    '
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 60
      Height = 13
      Caption = #21152#23494#23494#38053'    '
    end
    object Label3: TLabel
      Left = 8
      Top = 80
      Width = 60
      Height = 13
      Caption = #26126#25991#23383#20018'    '
    end
    object ComboBox1: TComboBox
      Left = 72
      Top = 16
      Width = 97
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'blowfish'
    end
    object Edit3: TEdit
      Left = 72
      Top = 40
      Width = 265
      Height = 21
      TabOrder = 1
      Text = '12d3fg4g3h32j4k4j32'
    end
    object Edit4: TEdit
      Left = 72
      Top = 72
      Width = 265
      Height = 21
      TabOrder = 2
      Text = '3cxv42f5f4f5g4g3g5g3g4g54g'
    end
    object ComboBox2: TComboBox
      Left = 224
      Top = 16
      Width = 105
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Text = 'HAVAL'
    end
  end
  object Edit1: TEdit
    Left = 40
    Top = 160
    Width = 337
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 40
    Top = 224
    Width = 337
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 408
    Top = 32
    Width = 73
    Height = 25
    Caption = #21152#23494
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 408
    Top = 208
    Width = 73
    Height = 25
    Caption = #32467#26463
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 408
    Top = 80
    Width = 73
    Height = 25
    Caption = 'HASH'#21152#23494
    TabOrder = 7
    OnClick = Button3Click
  end
  object DCP_blowfish1: TDCP_blowfish
    Id = 5
    Algorithm = 'Blowfish'
    MaxKeySize = 448
    BlockSize = 64
    Left = 16
    Top = 312
  end
  object DCP_cast1281: TDCP_cast128
    Id = 7
    Algorithm = 'Cast128'
    MaxKeySize = 128
    BlockSize = 64
    Left = 48
    Top = 312
  end
  object DCP_cast2561: TDCP_cast256
    Id = 15
    Algorithm = 'Cast256'
    MaxKeySize = 256
    BlockSize = 128
    Left = 80
    Top = 312
  end
  object DCP_des1: TDCP_des
    Id = 23
    Algorithm = 'DES'
    MaxKeySize = 64
    BlockSize = 64
    Left = 112
    Top = 312
  end
  object DCP_3des1: TDCP_3des
    Id = 24
    Algorithm = '3DES'
    MaxKeySize = 192
    BlockSize = 64
    Left = 144
    Top = 312
  end
  object DCP_gost1: TDCP_gost
    Id = 8
    Algorithm = 'Gost'
    MaxKeySize = 256
    BlockSize = 64
    Left = 176
    Top = 312
  end
  object DCP_ice1: TDCP_ice
    Id = 20
    Algorithm = 'Ice'
    MaxKeySize = 64
    BlockSize = 64
    Left = 208
    Top = 312
  end
  object DCP_ice21: TDCP_ice2
    Id = 22
    Algorithm = 'Ice2'
    MaxKeySize = 128
    BlockSize = 64
    Left = 240
    Top = 312
  end
  object DCP_thinice1: TDCP_thinice
    Id = 21
    Algorithm = 'Thin Ice'
    MaxKeySize = 64
    BlockSize = 64
    Left = 272
    Top = 312
  end
  object DCP_idea1: TDCP_idea
    Id = 12
    Algorithm = 'IDEA'
    MaxKeySize = 128
    BlockSize = 64
    Left = 304
    Top = 312
  end
  object DCP_mars1: TDCP_mars
    Id = 13
    Algorithm = 'Mars'
    MaxKeySize = 1248
    BlockSize = 128
    Left = 336
    Top = 312
  end
  object DCP_misty11: TDCP_misty1
    Id = 11
    Algorithm = 'Misty1'
    MaxKeySize = 128
    BlockSize = 64
    Left = 368
    Top = 312
  end
  object DCP_rc21: TDCP_rc2
    Id = 1
    Algorithm = 'RC2'
    MaxKeySize = 1024
    BlockSize = 64
    Left = 400
    Top = 312
  end
  object DCP_rc41: TDCP_rc4
    Id = 19
    Algorithm = 'RC4'
    MaxKeySize = 2048
    Left = 432
    Top = 312
  end
  object DCP_rc61: TDCP_rc6
    Id = 4
    Algorithm = 'RC6'
    MaxKeySize = 2048
    BlockSize = 128
    Left = 432
    Top = 224
  end
  object DCP_rc51: TDCP_rc5
    Id = 3
    Algorithm = 'RC5'
    MaxKeySize = 2048
    BlockSize = 64
    Left = 464
    Top = 312
  end
  object DCP_rijndael1: TDCP_rijndael
    Id = 9
    Algorithm = 'Rijndael'
    MaxKeySize = 256
    BlockSize = 128
    Left = 400
    Top = 224
  end
  object DCP_twofish1: TDCP_twofish
    Id = 6
    Algorithm = 'Twofish'
    MaxKeySize = 256
    BlockSize = 128
    Left = 400
    Top = 192
  end
  object DCP_sha11: TDCP_sha1
    Id = 2
    Algorithm = 'SHA1'
    HashSize = 160
    Left = 400
    Top = 128
  end
  object DCP_ripemd1601: TDCP_ripemd160
    Id = 10
    Algorithm = 'RipeMD-160'
    HashSize = 160
    Left = 432
    Top = 128
  end
  object DCP_md51: TDCP_md5
    Id = 16
    Algorithm = 'MD5'
    HashSize = 128
    Left = 400
    Top = 160
  end
  object DCP_md41: TDCP_md4
    Id = 17
    Algorithm = 'MD4'
    HashSize = 128
    Left = 432
    Top = 160
  end
  object DCP_haval1: TDCP_haval
    Id = 14
    Algorithm = 'Haval'
    HashSize = 256
    Left = 432
    Top = 192
  end
end
