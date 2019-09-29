object FrmMakeLogin: TFrmMakeLogin
  Left = 479
  Top = 223
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #29983#25104#30331#38470#22120#21644#32593#20851
  ClientHeight = 333
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 528
    Height = 333
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #29983#25104#30331#38470#22120
      object GroupBox1: TGroupBox
        Left = 8
        Top = 3
        Width = 505
        Height = 302
        Caption = #30331#38470#22120#37197#32622
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 19
          Width = 72
          Height = 12
          Caption = #30331#38470#22120#21517#31216#65306
        end
        object Label2: TLabel
          Left = 11
          Top = 39
          Width = 72
          Height = 12
          Caption = #23458#25143#31471#25991#20214#65306
        end
        object Label16: TLabel
          Left = 11
          Top = 283
          Width = 60
          Height = 12
          Caption = #29983#25104#36827#24230#65306
        end
        object EdtLoginName: TEdit
          Left = 95
          Top = 16
          Width = 402
          Height = 18
          Ctl3D = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          TabOrder = 0
        end
        object EdtClientFileName: TEdit
          Left = 95
          Top = 36
          Width = 330
          Height = 18
          Ctl3D = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          TabOrder = 1
        end
        object GroupBox3: TGroupBox
          Left = 11
          Top = 103
          Width = 486
          Height = 104
          Caption = #30331#38470#22120#30456#20851#25991#20214
          TabOrder = 2
          object Label4: TLabel
            Left = 10
            Top = 18
            Width = 84
            Height = 12
            Caption = #20869#25346#36807#28388#25991#20214#65306
          end
          object Label5: TLabel
            Left = 10
            Top = 41
            Width = 72
            Height = 12
            Caption = #30331#38470#22120#30382#32932#65306
          end
          object Label35: TLabel
            Left = 10
            Top = 62
            Width = 84
            Height = 12
            Caption = #22871#35013#25552#31034#25991#20214#65306
          end
          object Label37: TLabel
            Left = 10
            Top = 84
            Width = 84
            Height = 12
            Caption = #32463#32476#25552#31034#25991#20214#65306
          end
          object EdtAssistantFilter: TEdit
            Left = 106
            Top = 14
            Width = 288
            Height = 18
            Ctl3D = False
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 0
          end
          object BtnAssistantFilter: TButton
            Left = 394
            Top = 14
            Width = 18
            Height = 18
            Caption = #8230
            Enabled = False
            TabOrder = 1
            OnClick = BtnAssistantFilterClick
          end
          object EdtLoginMainImages: TEdit
            Left = 106
            Top = 37
            Width = 288
            Height = 18
            Ctl3D = False
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 2
          end
          object BtnLoginMainImages: TButton
            Left = 394
            Top = 37
            Width = 18
            Height = 18
            Caption = #8230
            Enabled = False
            TabOrder = 3
            OnClick = BtnLoginMainImagesClick
          end
          object CheckBox1: TCheckBox
            Left = 92
            Top = 15
            Width = 14
            Height = 17
            Hint = #22914#26524#38598#25104#20869#25346#36807#28388#25991#20214#65292#35831#21246#36873#12290
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = CheckBox1Click
          end
          object CheckBox2: TCheckBox
            Left = 92
            Top = 37
            Width = 14
            Height = 17
            Hint = #22914#19981#21246#36873#21017#29983#25104#40664#35748#30331#38470#22120#30382#32932#12290
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = CheckBox2Click
          end
          object Button1: TButton
            Left = 414
            Top = 13
            Width = 69
            Height = 20
            Caption = #37197#32622#27492#25991#20214
            TabOrder = 6
            OnClick = Button1Click
          end
          object CheckBox3: TCheckBox
            Left = 92
            Top = 59
            Width = 14
            Height = 17
            Hint = #22914#19981#21246#36873#21017#26080#22871#35013#25552#31034#12290
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            OnClick = CheckBox3Click
          end
          object EdtTzHintFile: TEdit
            Left = 106
            Top = 59
            Width = 288
            Height = 18
            Ctl3D = False
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 8
          end
          object BtnTzHintFile: TButton
            Left = 394
            Top = 59
            Width = 18
            Height = 18
            Caption = #8230
            Enabled = False
            TabOrder = 9
            OnClick = BtnTzHintFileClick
          end
          object Button6: TButton
            Left = 414
            Top = 58
            Width = 69
            Height = 20
            Caption = #37197#32622#27492#25991#20214
            TabOrder = 10
            OnClick = Button6Click
          end
          object CheckBox4: TCheckBox
            Left = 92
            Top = 81
            Width = 14
            Height = 17
            Hint = #22914#19981#21246#36873#21017#26080#22871#35013#25552#31034#12290
            ParentShowHint = False
            ShowHint = True
            TabOrder = 11
            OnClick = CheckBox4Click
          end
          object EdtPulsDescFile: TEdit
            Left = 106
            Top = 82
            Width = 288
            Height = 18
            Ctl3D = False
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 12
          end
          object BtnPulsDescFile: TButton
            Left = 394
            Top = 81
            Width = 18
            Height = 18
            Caption = #8230
            Enabled = False
            TabOrder = 13
            OnClick = BtnPulsDescFileClick
          end
          object Button4: TButton
            Left = 414
            Top = 80
            Width = 69
            Height = 20
            Caption = #37197#32622#27492#25991#20214
            TabOrder = 14
            OnClick = Button4Click
          end
          object Button2: TButton
            Left = 414
            Top = 36
            Width = 69
            Height = 20
            Caption = #35774#35745#30331#38470#22120
            TabOrder = 15
            OnClick = Button2Click
          end
        end
        object GroupBox4: TGroupBox
          Left = 11
          Top = 210
          Width = 486
          Height = 66
          Caption = #29983#25104#30331#38470#22120#25110#37197#22871#32593#20851
          TabOrder = 3
          object Label6: TLabel
            Left = 16
            Top = 20
            Width = 36
            Height = 12
            Caption = #23494#38053#65306
          end
          object EdtMakeKey: TEdit
            Left = 51
            Top = 17
            Width = 430
            Height = 18
            Ctl3D = False
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ParentCtl3D = False
            TabOrder = 0
          end
          object BtnMakeLogin: TButton
            Left = 157
            Top = 38
            Width = 110
            Height = 24
            Caption = #29983#25104#30331#38470#22120'(&M)'
            TabOrder = 1
            OnClick = BtnMakeLoginClick
          end
          object BtnMakeGate: TButton
            Left = 335
            Top = 38
            Width = 110
            Height = 25
            Caption = #29983#25104#37197#22871#32593#20851'(&M)'
            TabOrder = 2
            OnClick = BtnMakeGateClick
          end
        end
        object Button17: TButton
          Left = 428
          Top = 35
          Width = 69
          Height = 20
          Caption = #38543#26426#21462#21517
          TabOrder = 4
          OnClick = Button17Click
        end
        object ProgressBar1: TProgressBar
          Left = 70
          Top = 283
          Width = 427
          Height = 12
          TabOrder = 5
        end
        object LoginVerNo: TRzRadioGroup
          Left = 11
          Top = 57
          Width = 134
          Height = 41
          Caption = #29256#26412#36873#25321
          Columns = 10
          ItemFrameColor = 8409372
          ItemHotTrack = True
          ItemHighlightColor = 2203937
          ItemHeight = 15
          LightTextStyle = True
          StartXPos = 24
          StartYPos = 5
          TabOrder = 6
          Transparent = True
          object cboLoginVerNo: TRzComboBox
            Left = 10
            Top = 15
            Width = 119
            Height = 20
            Style = csDropDownList
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ItemHeight = 12
            TabOrder = 0
            OnChange = cboLoginVerNoChange
          end
        end
        object CheckBox5: TCheckBox
          Left = 151
          Top = 80
          Width = 307
          Height = 17
          Caption = #38598#25104'3K'#38450#28779#22681#25554#20214'['#24050#36141#20080#29992#25143#25165#21246#36873#65292#21542#21017#28216#25103#24322#24120']'
          TabOrder = 7
        end
        object CheckBox6: TCheckBox
          Left = 151
          Top = 65
          Width = 87
          Height = 17
          Caption = #20351#29992#20113#26356#26032
          TabOrder = 8
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #28216#25103#21015#34920#37197#32622
      ImageIndex = 1
      object GroupBox5: TGroupBox
        Left = 8
        Top = 3
        Width = 505
        Height = 302
        Caption = #26381#21153#22120#21015#34920#35774#32622
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object GroupBox6: TGroupBox
          Left = 8
          Top = 17
          Width = 489
          Height = 46
          Caption = #20998#32452#35774#32622
          TabOrder = 0
          object Label7: TLabel
            Left = 8
            Top = 21
            Width = 60
            Height = 12
            Caption = #20998#32452#21015#34920#65306
          end
          object ComboBox1: TComboBox
            Left = 68
            Top = 17
            Width = 213
            Height = 20
            Style = csDropDownList
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ItemHeight = 12
            TabOrder = 0
          end
          object BtnAddArray: TButton
            Left = 289
            Top = 14
            Width = 92
            Height = 25
            Caption = #22686#21152#20998#32452'(&A)'
            TabOrder = 1
            OnClick = BtnAddArrayClick
          end
          object BtnDelArray: TButton
            Left = 389
            Top = 14
            Width = 89
            Height = 25
            Caption = #21024#38500#20998#32452'(&D)'
            TabOrder = 2
            OnClick = BtnDelArrayClick
          end
        end
        object GroupBox7: TGroupBox
          Left = 8
          Top = 65
          Width = 489
          Height = 201
          Caption = #26381#21153#22120#21015#34920
          TabOrder = 1
          object BtnGameListAdd: TSpeedButton
            Left = 112
            Top = 170
            Width = 70
            Height = 24
            Caption = #28155#21152'(&A)'
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E000E0E0E000E0E0E000E0E0E000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E004A4A4A00CECECE009E9E9E009E9E9E000E0E0E00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E00FFFFFF00E6E6E600C2C2C2000092DC000092DC000E0E0E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E00E6E6E600C2C2C2000092DC000062960025AAFF000092DC000E0E0E00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E00B6B6B6006BC6FF00007AB90025AAFF000062960025AAFF000092DC000E0E
              0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000E0E0E0000AAFF008ED4FF00007AB90025AAFF000062960025AAFF000092
              DC000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF000E0E0E0000AAFF00B1E2FF00007AB90025AAFF000062960025AA
              FF000092DC000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF000E0E0E0000AAFF008ED4FF00007AB90025AAFF000062
              960025AAFF004A7300000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF000E0E0E0000AAFF00B1E2FF00007AB90025AA
              FF00629600004A7300004A7300000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E0E0000AAFF008ED4FF003DB9
              000062960000007AB900003DB900003DB9000E0E0E00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E0E000092DC0049DC
              00000049DC00003DB9006B8FFF006B8FFF000049DC000E0E0E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E0E006296
              0000003DB9006B8FFF000000B9000055FF000049DC000E0E0E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E004873FF008EABFF000055FF000055FF00003DB9000E0E0E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000E0E0E000049DC000055FF00003DB9000E0E0E00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF000E0E0E000E0E0E000E0E0E00FFFFFF00FFFFFF00}
            OnClick = BtnGameListAddClick
          end
          object BtnGameListRea: TSpeedButton
            Left = 205
            Top = 170
            Width = 70
            Height = 24
            Caption = #20462#25913'(&R)'
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF00004A
              7300004A7300004A7300004A7300004A7300004A7300004A7300004A7300004A
              7300004A7300004A7300004A7300004A7300FFFFFF00FFFFFF00006296003232
              3200007AB900CECECE00CECECE00CECECE00CECECE00CECECE00DADADA00DADA
              DA00DADADA00F2F2F200B1E2FF003232320000325000FFFFFF000062960048B8
              FF00007AB900C2C2C200CECECE00CECECE00CECECE00CECECE00CECECE00DADA
              DA00DADADA00DADADA00B1E2FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB900B6B6B600C2C2C200C2C2C200C2C2C200CECECE00CECECE00CECE
              CE00CECECE00DADADA00B1E2FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB900B6B6B600B6B6B600B6B6B600C2C2C200CECECE00CECECE00CECE
              CE00CECECE00C2C2C200B1E2FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB90092929200A4A0A000B6B6B600B6B6B600C2C2C200CECECE00C2C2
              C200C2C2C200B6B6B600B1E2FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB9009292920092929200A4A0A000A4A0A000B6B6B600C2C2C200C2C2
              C200B6B6B600B6B6B600B1E2FF0048B8FF0000325000FFFFFF00006296008ED4
              FF00007AB900007AB900007AB900007AB900007AB900007AB900007AB900007A
              B900007AB900007AB9008ED4FF0048B8FF0000325000FFFFFF00006296008ED4
              FF008ED4FF008ED4FF008ED4FF008ED4FF008ED4FF008ED4FF008ED4FF008ED4
              FF008ED4FF008ED4FF00B1E2FF0048B8FF0000325000FFFFFF00006296008ED4
              FF00007AB90000AAFF00007AB900007AB900007AB900007AB900007AB900007A
              B900007AB90048B8FF008ED4FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB900FFFFFF0000629600FFFFFF00F2F2F200F2F2F200B6B6B600B6B6
              B600F2F2F200007AB9008ED4FF006BC6FF0000325000FFFFFF00006296008ED4
              FF00007AB900FFFFFF0000629600FFFFFF00DADADA00DADADA00808080008080
              8000F2F2F200006296008ED4FF006BC6FF0000325000FFFFFF000062960048B8
              FF00007AB900FFFFFF0000629600FFFFFF00DADADA00DADADA006E6E6E009292
              9200DADADA00006296008ED4FF006BC6FF0000325000FFFFFF00006296008ED4
              FF00007AB900FFFFFF0000629600FFFFFF00E6E6E600DADADA00323232003232
              3200F2F2F200006296008ED4FF006BC6FF0000325000FFFFFF0000629600B1E2
              FF00007AB900DADADA00007AB900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF0000629600B1E2FF00004A7300FFFFFF00FFFFFF00FFFFFF008686
              8600868686008686860086868600868686008686860086868600868686008686
              8600868686008686860086868600FFFFFF00FFFFFF00FFFFFF00}
            OnClick = BtnGameListReaClick
          end
          object BtnGameListDel: TSpeedButton
            Left = 298
            Top = 170
            Width = 70
            Height = 24
            Caption = #21024#38500'(&D)'
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
              00005B5BF5005555F100504FED004B4CEA00393ADF0000000000000000001313
              C5002827D300201FCD001B1BCB001313C50000000000FFFFFF00FFFFFF00FFFF
              FF00000000005B5BF500504FED005555F1004B4CEA001B1BCB0005059D00504F
              ED006B6BFF006B6BFF00201FCD0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00000000005B5BF500504FED005555F1004B4CEA001B1BCB00504F
              ED006B6BFF002D2DD60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00000000005B5BF500504FED005555F1004343E5006464
              FA00393ADF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000005B5BF500504FED005555F1004343
              E50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000005F5FF8004B4CEA00504FED004B4C
              EA0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00000000006B6BFF003D3DE1005F5FF8004B4CEA005352
              EF004B4CEA0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00000000006B6BFF003434DB006B6BFF001B1BCB005F5FF8004B4C
              EA005352EF004B4CEA0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000000006B6BFF002827D3002D2DD6006B6BFF0005059D003D3DE1005F5F
              F8004B4CEA005352EF004B4CEA0000000000FFFFFF00FFFFFF00FFFFFF000000
              00006B6BFF006B6BFF006B6BFF006B6BFF006B6BFF0000000000000000006B6B
              FF005F5FF8005B5BF500504FED004B4CEA0000000000FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            OnClick = BtnGameListDelClick
          end
          object ListView1: TListView
            Left = 8
            Top = 16
            Width = 473
            Height = 150
            Columns = <
              item
                Caption = #26381#21153#22120#32452
                Width = 60
              end
              item
                Caption = #28216#25103#21517#31216
                Width = 60
              end
              item
                Caption = 'IP'#22320#22336
              end
              item
                Caption = #31471#21475
              end
              item
                Caption = #20844#21578#22320#22336
                Width = 60
              end
              item
                Caption = #32593#31449#20027#39029
                Width = 60
              end
              item
                Caption = #35013#22791#23637#31034
                Width = 60
              end
              item
                Caption = #32593#20851#23494#30721
                Width = 60
              end>
            Ctl3D = True
            GridLines = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object Button5: TButton
          Left = 112
          Top = 272
          Width = 114
          Height = 25
          Caption = #29983#25104#28216#25103#21015#34920#25991#20214
          TabOrder = 2
          OnClick = Button5Click
        end
        object BtnSaveGameListConfig: TButton
          Left = 295
          Top = 272
          Width = 87
          Height = 25
          Caption = #20445#23384#37197#32622#20449#24687
          TabOrder = 3
          OnClick = BtnSaveGameListConfigClick
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #28216#25103#26356#26032#37197#32622
      ImageIndex = 2
      object Label15: TLabel
        Left = 379
        Top = 257
        Width = 138
        Height = 12
        Caption = #8251#28857'['#25171#24320#25991#20214']'#33719#21462'MD5'#20540
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 110
        Top = 257
        Width = 66
        Height = 12
        Caption = #25991#20214'MD5'#20540#65306
      end
      object Label13: TLabel
        Left = 110
        Top = 234
        Width = 60
        Height = 12
        Caption = #19979#36733#22320#22336#65306
      end
      object Label12: TLabel
        Left = 315
        Top = 213
        Width = 60
        Height = 12
        Caption = #25991#20214#21517#31216#65306
      end
      object Label11: TLabel
        Left = 110
        Top = 213
        Width = 96
        Height = 12
        Caption = #23458#25143#31471#23384#25918#30446#24405#65306
      end
      object Memo1: TMemo
        Left = 4
        Top = 0
        Width = 509
        Height = 125
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        Lines.Strings = (
          ';'#25991#20214#31867#22411'(0='#26222#36890#25991#20214' 1='#30331#38470#22120' 2=ZIP'#21387#32553#25991#20214')'#9#30446#24405#9#25991#20214#21517#31216#9
          'MD5'#20540#9#19979#36733#22320#22336)
        ParentCtl3D = False
        TabOrder = 0
      end
      object FileTypeRadioGroup: TRzRadioGroup
        Left = 0
        Top = 206
        Width = 105
        Height = 71
        Caption = #25991#20214#31867#22411
        ItemHotTrack = True
        ItemHeight = 15
        ItemIndex = 0
        Items.Strings = (
          #26222#36890#25991#20214
          #30331#38470#22120#25991#20214
          'ZIP'#21387#32553#25991#20214)
        TabOrder = 1
        Transparent = True
      end
      object Button11: TButton
        Left = 0
        Top = 280
        Width = 57
        Height = 25
        Caption = #28155#21152'(&A)'
        TabOrder = 2
        OnClick = Button11Click
      end
      object ComBoxDir: TComboBox
        Left = 205
        Top = 209
        Width = 100
        Height = 18
        Style = csOwnerDrawFixed
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ItemHeight = 12
        ItemIndex = 0
        TabOrder = 3
        Text = 'Data'
        Items.Strings = (
          'Data'
          'Map'
          'Wav'
          #30331#38470#22120#30446#24405)
      end
      object EdtFileName: TEdit
        Left = 384
        Top = 209
        Width = 127
        Height = 18
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ParentCtl3D = False
        TabOrder = 4
      end
      object EdtDownUrl: TEdit
        Left = 176
        Top = 231
        Width = 337
        Height = 18
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ParentCtl3D = False
        TabOrder = 5
      end
      object EdtMd5: TEdit
        Left = 176
        Top = 254
        Width = 201
        Height = 18
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ParentCtl3D = False
        TabOrder = 6
      end
      object BtnOpenFile: TButton
        Left = 63
        Top = 280
        Width = 78
        Height = 25
        Caption = #25171#24320#25991#20214'(&O)'
        TabOrder = 7
        OnClick = BtnOpenFileClick
      end
      object Button13: TButton
        Left = 147
        Top = 280
        Width = 128
        Height = 25
        Caption = #29983#25104#28216#25103#26356#26032#21015#34920'(&S)'
        TabOrder = 8
        OnClick = Button13Click
      end
      object Button14: TButton
        Left = 281
        Top = 280
        Width = 127
        Height = 25
        Caption = #35835#21462#28216#25103#26356#26032#25991#20214'(&R)'
        TabOrder = 9
        OnClick = Button14Click
      end
      object Button15: TButton
        Left = 414
        Top = 280
        Width = 101
        Height = 25
        Caption = #20445#23384#32534#36753#25991#20214'(&S)'
        TabOrder = 10
        OnClick = Button15Click
      end
      object Memo2: TMemo
        Left = 3
        Top = 126
        Width = 508
        Height = 78
        Lines.Strings = (
          #20462#25913#21830#19994#30331#38470#22120#33258#21160#26356#26032'('#20197#19979#35828#26126#20165#20026#33539#20363#65292#20855#20307#25805#20316#35831#21442#30475'Video.3km2.com'#30340#25945#31243')'#65306
          #21482#35201#21387#32553#21253#20869#20219#24847'1'#20010#25991#20214#30340'MD5'#20540#21457#29983#25913#21464#30331#38470#22120#37117#20250#33258#21160#26816#27979#24182#23436#25104#26356#26032#12290
          '1'#12289#27604#22914#65306#25105#20204#38656#35201#26356#26032#34917#19969#36739#23567#65292#25991#20214#21517#23383#20026':data.zip,'#35813#25991#20214#37324#38754#21253#21547#65306'Prguse.wil'#65292
          'Prguse.WIX'
          
            '2 Data/ Prguse.wil 003daa18ca10ea996595e362fca42dbf  http://127.' +
            '0.0.1/data.Zip'
          
            '2 Data/ Prguse.WIX 1fc99b345a4bece10fbd96d7a9b32ec6  http://127.' +
            '0.0.1/data.Zip'
          #25171#24320#30331#38470#22120#26102#33258#21160#26816#27979#23458#25143#31471#30340'Prguse.wil'#12289'Prguse.WIX'#26159#21542#20026#24744#35774#32622#30340'MD5'#20540#65292#22914#19981#26159#21017
          #33258
          #21160#19979#36733'data.zip'#24182#35299#21387#12290
          ''
          '2'#12289#27604#22914#65306#25105#20204#38656#35201#26356#26032#30340#34917#19969#36739#22823#65292#25991#20214#21517#23383#20026':m2th.zip,'#35813#25991#20214#37324#38754#21253#21547#65306#34917#19969#25991#20214'+'#20219
          #24847#21517#23383#30340'.txt'#25991#20214'['#27604#22914#65306'3km2.txt]'
          #21153#24517#27880#24847#65306#35813'txt'#25991#20214#20026#34917#19969#26159#21542#24050#32463#26356#26032#30340#26631#35782#65292'txt'#25991#20214#20013#38656#35201#38543#20415#36755#20837#20960#20010#27721#23383#12289#20999#35760
          #19981#33021#20026#31354#30333#12290
          
            '2 Data/ 3k.txt 103daa18ca10ea9963953362fca42dbf  http://127.0.0.' +
            '1/m2th.Zip'
          #25171#24320#30331#38470#22120#26102#33258#21160#26816#27979#23458#25143#31471#30340'3Km2.txt'#26159#21542#20026#24744#35774#32622#30340'MD5'#20540#65292#22914#19981#26159#21017#33258#21160#19979#36733
          'm2th.zip'
          #24182#35299#21387#12290)
        ScrollBars = ssVertical
        TabOrder = 11
      end
    end
    object TabSheet4: TTabSheet
      Caption = #21453#22806#25346#37197#32622
      ImageIndex = 3
      object GroupBox8: TGroupBox
        Left = 8
        Top = 3
        Width = 505
        Height = 302
        Caption = #21453#22806#25346#37197#32622
        TabOrder = 0
        object Label8: TLabel
          Left = 258
          Top = 10
          Width = 234
          Height = 126
          AutoSize = False
          Caption = 
            #35828#26126#65306#26412#21151#33021#29992#20110#31105#27490#21508#31181#38750#27861#31243#24207#36816#34892#13#22806#25346#29305#24449#21517#31216#65306#38750#27861#31243#24207#30340#21517#23383#13#20363#65306#8220#21450#26102#38632#8221#22806#25346' '#21487#22635#8220#21450#26102#38632#8221#25110#20840#31216' '#13#8220#26080#25932#21152#36895#22120#8221#22806 +
            #25346' '#21487#22635#8220#21152#36895#22120#8221#25110#20840#31216'   '#13#27492#36873#39033#22635#37096#20998#37325#35201#30340#23383#31526#21517#25110#20840#37096#21517#31216#21363#21487#12290#13#22806#25346#29305#24449#36827#31243#65306#38750#27861#31243#24207#30340#36827#31243#21517#23383#13#20363#65306#8220'JSY.exe' +
            #8221' '#8220#26080#25932#21152#36895#22120'.exe'#8221' '#13#27492#36873#39033#24517#39035#22635#23436#25972#36827#31243#21517#65292#21542#21017#26080#27861#26597#21040#12290#13#22806#25346#29305#24449#27169#22359#65306#38750#27861#31243#24207#30340#27169#22359#21517#23383#13#20363#65306#8220'JSY.dll'#8221#27492 +
            #36873#39033#24517#39035#22635#23436#25972#27169#22359#21517#12290#13#13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object ListViewGameMon: TListView
          Left = 8
          Top = 16
          Width = 233
          Height = 281
          Columns = <
            item
              Caption = #29305#24449#20998#31867
              Width = 80
            end
            item
              Caption = #22806#25346#29305#24449
              Width = 80
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          GridLines = True
          ReadOnly = True
          RowSelect = True
          ParentFont = False
          TabOrder = 0
          ViewStyle = vsReport
        end
        object GroupBox9: TGroupBox
          Left = 257
          Top = 138
          Width = 233
          Height = 129
          Caption = #25805#20316#36873#39033
          TabOrder = 1
          object Label9: TLabel
            Left = 8
            Top = 17
            Width = 84
            Height = 12
            Caption = #22806#25346#29305#24449#21517#31216#65306
          end
          object BtnGameMonAdd: TSpeedButton
            Left = 13
            Top = 33
            Width = 70
            Height = 24
            Caption = #28155#21152'(&A)'
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E000E0E0E000E0E0E000E0E0E000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E004A4A4A00CECECE009E9E9E009E9E9E000E0E0E00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E00FFFFFF00E6E6E600C2C2C2000092DC000092DC000E0E0E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E00E6E6E600C2C2C2000092DC000062960025AAFF000092DC000E0E0E00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E00B6B6B6006BC6FF00007AB90025AAFF000062960025AAFF000092DC000E0E
              0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000E0E0E0000AAFF008ED4FF00007AB90025AAFF000062960025AAFF000092
              DC000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF000E0E0E0000AAFF00B1E2FF00007AB90025AAFF000062960025AA
              FF000092DC000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF000E0E0E0000AAFF008ED4FF00007AB90025AAFF000062
              960025AAFF004A7300000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF000E0E0E0000AAFF00B1E2FF00007AB90025AA
              FF00629600004A7300004A7300000E0E0E00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E0E0000AAFF008ED4FF003DB9
              000062960000007AB900003DB900003DB9000E0E0E00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E0E000092DC0049DC
              00000049DC00003DB9006B8FFF006B8FFF000049DC000E0E0E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E0E006296
              0000003DB9006B8FFF000000B9000055FF000049DC000E0E0E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000E0E
              0E004873FF008EABFF000055FF000055FF00003DB9000E0E0E00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF000E0E0E000049DC000055FF00003DB9000E0E0E00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF000E0E0E000E0E0E000E0E0E00FFFFFF00FFFFFF00}
            OnClick = BtnGameMonAddClick
          end
          object BtnChangeGameMon: TSpeedButton
            Left = 13
            Top = 57
            Width = 70
            Height = 24
            Caption = #20462#25913'(&R)'
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF00004A
              7300004A7300004A7300004A7300004A7300004A7300004A7300004A7300004A
              7300004A7300004A7300004A7300004A7300FFFFFF00FFFFFF00006296003232
              3200007AB900CECECE00CECECE00CECECE00CECECE00CECECE00DADADA00DADA
              DA00DADADA00F2F2F200B1E2FF003232320000325000FFFFFF000062960048B8
              FF00007AB900C2C2C200CECECE00CECECE00CECECE00CECECE00CECECE00DADA
              DA00DADADA00DADADA00B1E2FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB900B6B6B600C2C2C200C2C2C200C2C2C200CECECE00CECECE00CECE
              CE00CECECE00DADADA00B1E2FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB900B6B6B600B6B6B600B6B6B600C2C2C200CECECE00CECECE00CECE
              CE00CECECE00C2C2C200B1E2FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB90092929200A4A0A000B6B6B600B6B6B600C2C2C200CECECE00C2C2
              C200C2C2C200B6B6B600B1E2FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB9009292920092929200A4A0A000A4A0A000B6B6B600C2C2C200C2C2
              C200B6B6B600B6B6B600B1E2FF0048B8FF0000325000FFFFFF00006296008ED4
              FF00007AB900007AB900007AB900007AB900007AB900007AB900007AB900007A
              B900007AB900007AB9008ED4FF0048B8FF0000325000FFFFFF00006296008ED4
              FF008ED4FF008ED4FF008ED4FF008ED4FF008ED4FF008ED4FF008ED4FF008ED4
              FF008ED4FF008ED4FF00B1E2FF0048B8FF0000325000FFFFFF00006296008ED4
              FF00007AB90000AAFF00007AB900007AB900007AB900007AB900007AB900007A
              B900007AB90048B8FF008ED4FF0048B8FF0000325000FFFFFF00006296006BC6
              FF00007AB900FFFFFF0000629600FFFFFF00F2F2F200F2F2F200B6B6B600B6B6
              B600F2F2F200007AB9008ED4FF006BC6FF0000325000FFFFFF00006296008ED4
              FF00007AB900FFFFFF0000629600FFFFFF00DADADA00DADADA00808080008080
              8000F2F2F200006296008ED4FF006BC6FF0000325000FFFFFF000062960048B8
              FF00007AB900FFFFFF0000629600FFFFFF00DADADA00DADADA006E6E6E009292
              9200DADADA00006296008ED4FF006BC6FF0000325000FFFFFF00006296008ED4
              FF00007AB900FFFFFF0000629600FFFFFF00E6E6E600DADADA00323232003232
              3200F2F2F200006296008ED4FF006BC6FF0000325000FFFFFF0000629600B1E2
              FF00007AB900DADADA00007AB900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF0000629600B1E2FF00004A7300FFFFFF00FFFFFF00FFFFFF008686
              8600868686008686860086868600868686008686860086868600868686008686
              8600868686008686860086868600FFFFFF00FFFFFF00FFFFFF00}
            OnClick = BtnChangeGameMonClick
          end
          object BtnGameMonDel: TSpeedButton
            Left = 13
            Top = 81
            Width = 70
            Height = 24
            Caption = #21024#38500'(&D)'
            Flat = True
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
              00005B5BF5005555F100504FED004B4CEA00393ADF0000000000000000001313
              C5002827D300201FCD001B1BCB001313C50000000000FFFFFF00FFFFFF00FFFF
              FF00000000005B5BF500504FED005555F1004B4CEA001B1BCB0005059D00504F
              ED006B6BFF006B6BFF00201FCD0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00000000005B5BF500504FED005555F1004B4CEA001B1BCB00504F
              ED006B6BFF002D2DD60000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00000000005B5BF500504FED005555F1004343E5006464
              FA00393ADF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000005B5BF500504FED005555F1004343
              E50000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00000000005F5FF8004B4CEA00504FED004B4C
              EA0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00000000006B6BFF003D3DE1005F5FF8004B4CEA005352
              EF004B4CEA0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00000000006B6BFF003434DB006B6BFF001B1BCB005F5FF8004B4C
              EA005352EF004B4CEA0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00000000006B6BFF002827D3002D2DD6006B6BFF0005059D003D3DE1005F5F
              F8004B4CEA005352EF004B4CEA0000000000FFFFFF00FFFFFF00FFFFFF000000
              00006B6BFF006B6BFF006B6BFF006B6BFF006B6BFF0000000000000000006B6B
              FF005F5FF8005B5BF500504FED004B4CEA0000000000FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
              00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
            OnClick = BtnGameMonDelClick
          end
          object RzLabel12: TRzLabel
            Left = 10
            Top = 111
            Width = 182
            Height = 12
            Caption = #35831#27880#24847#22806#25346#29305#24449#20998#31867#27491#30830#22635#20889#12290
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object EdtGameMon: TEdit
            Left = 89
            Top = 13
            Width = 135
            Height = 18
            Ctl3D = False
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ParentCtl3D = False
            TabOrder = 0
          end
          object GameMonTypeRadioGroup: TRzRadioGroup
            Left = 88
            Top = 32
            Width = 139
            Height = 70
            Caption = #22806#25346#29305#24449#20998#31867
            ItemHotTrack = True
            ItemHeight = 15
            ItemIndex = 0
            Items.Strings = (
              #22806#25346#29305#24449#21517#31216
              #22806#25346#29305#24449#36827#31243
              #22806#25346#29305#24449#27169#22359)
            LightTextStyle = True
            TabOrder = 1
            Transparent = True
          end
        end
        object BtnSaveGameMon: TButton
          Left = 364
          Top = 271
          Width = 123
          Height = 25
          Caption = #29983#25104#21453#22806#25346#21015#34920
          TabOrder = 2
          OnClick = BtnSaveGameMonClick
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #20869#25346#36807#28388#37197#32622
      ImageIndex = 4
      object GroupBox13: TGroupBox
        Left = 8
        Top = 3
        Width = 505
        Height = 302
        Caption = #20869#25346#36807#28388#37197#32622
        TabOrder = 0
        object LabelItemName: TLabel
          Left = 8
          Top = 227
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object LabelItemType: TLabel
          Left = 8
          Top = 250
          Width = 54
          Height = 12
          Caption = #29289#21697#31867#22411':'
        end
        object LabelTips: TRzLabel
          Left = 430
          Top = 226
          Width = 60
          Height = 36
          Caption = #25552#31034#65306#13#10#19978#38754#28857#21491#38190#13#10#21487#30452#25509#25805#20316
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          ShadowColor = clYellow
          ShadowDepth = 1
          TextStyle = tsRecessed
        end
        object ListViewFilterItem: TListView
          Left = 8
          Top = 16
          Width = 489
          Height = 201
          Columns = <
            item
              Caption = #29289#21697#31867#22411
              Width = 90
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 110
            end
            item
              Caption = #26497#21697#26174#31034
              Width = 80
            end
            item
              Caption = #33258#21160#25441#21462
              Width = 80
            end
            item
              Caption = #26174#31034#21517#31216
              Width = 80
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          ParentShowHint = False
          PopupMenu = PopupMenu1
          ShowHint = False
          SortType = stBoth
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewFilterItemClick
        end
        object BtnFilterOpen: TButton
          Left = 5
          Top = 272
          Width = 75
          Height = 25
          Caption = #25171#24320'(&O)'
          TabOrder = 1
          OnClick = BtnFilterOpenClick
        end
        object BtnFilterAdd: TButton
          Left = 82
          Top = 272
          Width = 75
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 2
          OnClick = BtnFilterAddClick
        end
        object BtnFilterSave: TButton
          Left = 314
          Top = 272
          Width = 75
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = BtnFilterSaveClick
        end
        object EditFilterItemName: TEdit
          Left = 64
          Top = 222
          Width = 137
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 4
        end
        object ComboBoxItemFilter: TComboBox
          Left = 64
          Top = 245
          Width = 137
          Height = 20
          Style = csDropDownList
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          ItemIndex = 0
          TabOrder = 5
          Text = '('#20840#37096#20998#31867')'
          OnChange = ComboBoxItemFilterChange
          Items.Strings = (
            '('#20840#37096#20998#31867')'
            #20854#20182#31867
            #33647#21697#31867
            #26381#35013#31867
            #27494#22120#31867
            #39318#39280#31867
            #39280#21697#31867
            #35013#39280#31867)
        end
        object GroupBox14: TGroupBox
          Left = 208
          Top = 217
          Width = 217
          Height = 49
          TabOrder = 6
          object CheckBoxHintItem: TCheckBox
            Left = 6
            Top = 18
            Width = 73
            Height = 17
            Caption = #26497#21697#25552#31034
            TabOrder = 0
          end
          object CheckBoxPickUpItem: TCheckBox
            Left = 74
            Top = 18
            Width = 73
            Height = 17
            Caption = #33258#21160#25441#21462
            TabOrder = 1
          end
          object CheckBoxShowItemName: TCheckBox
            Left = 142
            Top = 18
            Width = 73
            Height = 17
            Caption = #26174#31034#21517#31216
            TabOrder = 2
          end
        end
        object BtnFilterChg: TButton
          Left = 159
          Top = 272
          Width = 75
          Height = 25
          Caption = #20462#25913'(&E)'
          TabOrder = 7
          OnClick = BtnFilterChgClick
        end
        object BtnFilterDel: TButton
          Left = 237
          Top = 272
          Width = 75
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 8
          OnClick = BtnFilterDelClick
        end
        object BtnFromDB: TButton
          Left = 391
          Top = 272
          Width = 108
          Height = 25
          Hint = #22312#23548#20837#20043#21069#65292#38057#36873#36873#39033#65292#23548#20837#21518#25968#25454#20250#20840#37096#25353#36873#39033#37197#32622#65281
          Caption = #20174#25968#25454#24211#20013#23548#20837
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = BtnFromDBClick
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #22871#35013#25552#31034#37197#32622
      ImageIndex = 5
      object GroupBox2: TGroupBox
        Left = 0
        Top = 2
        Width = 210
        Height = 305
        Caption = #22871#35013#26174#31034#21015#34920
        TabOrder = 0
        object ListViewTzItemList: TListView
          Left = 2
          Top = 14
          Width = 206
          Height = 289
          Align = alClient
          Columns = <
            item
              Caption = #22871#35013#26631#39064
              Width = 65
            end
            item
              Caption = #25968#37327
              Width = 40
            end
            item
              Caption = #22871#35013#29289#21697
              Width = 120
            end
            item
              Caption = #23646#24615
              Width = 120
            end
            item
              Caption = #21151#33021#35814#35299
              Width = 120
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewTzItemListClick
        end
      end
      object BtnTzAdd: TButton
        Left = 265
        Top = 285
        Width = 50
        Height = 22
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = BtnTzAddClick
      end
      object BtnTzDel: TButton
        Left = 316
        Top = 285
        Width = 50
        Height = 22
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = BtnTzDelClick
      end
      object BtnTzChg: TButton
        Left = 366
        Top = 285
        Width = 50
        Height = 22
        Caption = #20462#25913'(&E)'
        TabOrder = 3
        OnClick = BtnTzChgClick
      end
      object BtnTzSave: TButton
        Left = 417
        Top = 285
        Width = 50
        Height = 22
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = BtnTzSaveClick
      end
      object GroupBox12: TGroupBox
        Left = 215
        Top = 2
        Width = 305
        Height = 279
        Caption = #22871#35013#26174#31034#38468#21152#23646#24615#35774#32622
        TabOrder = 5
        object Label3: TLabel
          Left = 113
          Top = 143
          Width = 60
          Height = 12
          Caption = #22871#35013#26631#39064#65306
        end
        object Label17: TLabel
          Left = 6
          Top = 184
          Width = 84
          Height = 12
          Caption = #22871#35013#21151#33021#35814#35299#65306
        end
        object Label18: TLabel
          Left = 5
          Top = 143
          Width = 60
          Height = 12
          Caption = #22871#35013#25968#37327#65306
        end
        object Label19: TLabel
          Left = 5
          Top = 166
          Width = 60
          Height = 12
          Caption = #22871#35013#29289#21697#65306
        end
        object Label20: TLabel
          Left = 5
          Top = 24
          Width = 54
          Height = 12
          Caption = #20869#21151#24674#22797':'
        end
        object Label21: TLabel
          Left = 104
          Top = 24
          Width = 54
          Height = 12
          Caption = #38450#26292#23646#24615':'
        end
        object Label22: TLabel
          Left = 203
          Top = 24
          Width = 54
          Height = 12
          Caption = #21560#34880#23646#24615':'
        end
        object Label23: TLabel
          Left = 5
          Top = 48
          Width = 54
          Height = 12
          Caption = #20869#20260#31561#32423':'
        end
        object Label24: TLabel
          Left = 104
          Top = 48
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label25: TLabel
          Left = 5
          Top = 72
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label26: TLabel
          Left = 104
          Top = 72
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label27: TLabel
          Left = 5
          Top = 96
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label28: TLabel
          Left = 104
          Top = 96
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label29: TLabel
          Left = 5
          Top = 120
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label30: TLabel
          Left = 104
          Top = 120
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label31: TLabel
          Left = 203
          Top = 48
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label32: TLabel
          Left = 203
          Top = 72
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label33: TLabel
          Left = 203
          Top = 96
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label34: TLabel
          Left = 203
          Top = 120
          Width = 60
          Height = 12
          Caption = #35282#33394#32844#19994'::'
        end
        object Memo: TMemo
          Left = 6
          Top = 198
          Width = 294
          Height = 70
          Hint = #22914#26524#27492#22320#26041#19981#26126#30333#65292#35831#30475#24110#21161#65281
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object EdtTzCaption: TEdit
          Left = 171
          Top = 139
          Width = 128
          Height = 20
          Hint = #19981#20801#35768#20026#31354#65281
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object SpinEdit30: TSpinEdit
          Left = 63
          Top = 138
          Width = 42
          Height = 21
          MaxValue = 12
          MinValue = 1
          TabOrder = 2
          Value = 1
        end
        object EdtTzItems: TEdit
          Left = 64
          Top = 162
          Width = 236
          Height = 20
          Hint = #26684#24335#20026#8220#29289#21697#21517#65073#29289#21697#21517#65073#8221
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object SpinEdit1: TSpinEdit
          Left = 59
          Top = 19
          Width = 42
          Height = 21
          Hint = #35831#19982#24341#25806#35774#32622#20540#19968#33268
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Value = 0
        end
        object SpinEdit2: TSpinEdit
          Left = 158
          Top = 19
          Width = 42
          Height = 21
          Hint = #35831#19982#24341#25806#35774#32622#20540#19968#33268
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 0
        end
        object SpinEdit3: TSpinEdit
          Left = 257
          Top = 19
          Width = 42
          Height = 21
          Hint = #35831#19982#24341#25806#35774#32622#20540#19968#33268
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Value = 0
        end
        object SpinEdit4: TSpinEdit
          Left = 59
          Top = 43
          Width = 42
          Height = 21
          Hint = #35831#19982#24341#25806#35774#32622#20540#19968#33268
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Value = 0
        end
        object SpinEdit5: TSpinEdit
          Left = 158
          Top = 43
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object SpinEdit6: TSpinEdit
          Left = 59
          Top = 67
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object SpinEdit7: TSpinEdit
          Left = 158
          Top = 67
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 10
          Value = 0
        end
        object SpinEdit8: TSpinEdit
          Left = 59
          Top = 91
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 11
          Value = 0
        end
        object SpinEdit9: TSpinEdit
          Left = 158
          Top = 91
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 12
          Value = 0
        end
        object SpinEdit10: TSpinEdit
          Left = 59
          Top = 115
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 13
          Value = 0
        end
        object SpinEdit11: TSpinEdit
          Left = 158
          Top = 115
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 14
          Value = 0
        end
        object SpinEdit12: TSpinEdit
          Left = 257
          Top = 43
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 15
          Value = 0
        end
        object SpinEdit13: TSpinEdit
          Left = 257
          Top = 67
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 16
          Value = 0
        end
        object SpinEdit14: TSpinEdit
          Left = 257
          Top = 91
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 17
          Value = 0
        end
        object SpinEdit15: TSpinEdit
          Left = 257
          Top = 115
          Width = 42
          Height = 21
          Hint = '0-'#25112#22763#12289'1-'#27861#24072#12289'2-'#36947#22763#12289'3-'#36890#29992
          MaxValue = 3
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 18
          Value = 3
        end
      end
      object BtnTzHelp: TButton
        Left = 468
        Top = 285
        Width = 50
        Height = 22
        Caption = #24110#21161'(&H)'
        TabOrder = 6
        OnClick = BtnTzHelpClick
      end
      object BtnTzOpen: TButton
        Left = 214
        Top = 285
        Width = 50
        Height = 22
        Caption = #25171#24320'(&O)'
        TabOrder = 7
        OnClick = BtnTzOpenClick
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Title = #25171#24320
    Left = 108
    Top = 335
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 196
    Top = 338
    object N1: TMenuItem
      Caption = #26497#21697#26174#31034
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #33258#21160#25441#21462
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #26174#31034#21517#31216
      OnClick = N3Click
    end
  end
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    RecvBufferSize = 8192
    SendBufferSize = 1024
    OnWork = IdFTP1Work
    OnWorkBegin = IdFTP1WorkBegin
    Port = 22
    Passive = True
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 41
    Top = 330
  end
  object IdAntiFreeze1: TIdAntiFreeze
    OnlyWhenIdle = False
    Left = 73
    Top = 330
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Title = #25171#24320
    Left = 143
    Top = 338
  end
  object RzBalloonHints1: TRzBalloonHints
    Bitmaps.TransparentColor = clOlive
    CaptionWidth = 200
    CenterThreshold = 0
    Color = clAqua
    FrameColor = cl3DDkShadow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    HintPause = 10
    ShowBalloon = False
    Left = 12
    Top = 329
  end
  object SaveDialog1: TSaveDialog
    Left = 236
    Top = 338
  end
end
