object FrmMakeLogin: TFrmMakeLogin
  Left = 323
  Top = 256
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #29983#25104#30331#38470#22120#21644#32593#20851
  ClientHeight = 336
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 468
    Height = 336
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
        Width = 441
        Height = 302
        Caption = #30331#38470#22120#37197#32622
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 26
          Width = 72
          Height = 12
          Caption = #30331#38470#22120#21517#31216#65306
        end
        object Label2: TLabel
          Left = 11
          Top = 46
          Width = 72
          Height = 12
          Caption = #23458#25143#31471#25991#20214#65306
        end
        object Label16: TLabel
          Left = 11
          Top = 278
          Width = 60
          Height = 12
          Caption = #29983#25104#36827#24230#65306
        end
        object EdtLoginName: TEdit
          Left = 95
          Top = 23
          Width = 331
          Height = 18
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object EdtClientFileName: TEdit
          Left = 95
          Top = 43
          Width = 261
          Height = 18
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
        end
        object GroupBox3: TGroupBox
          Left = 11
          Top = 115
          Width = 419
          Height = 67
          Caption = #30331#38470#22120#30456#20851#25991#20214
          TabOrder = 2
          object Label4: TLabel
            Left = 10
            Top = 20
            Width = 84
            Height = 12
            Caption = #20869#25346#36807#28388#25991#20214#65306
          end
          object Label5: TLabel
            Left = 10
            Top = 42
            Width = 84
            Height = 12
            Caption = #30331#38470#22120#32972#26223#22270#65306
          end
          object EdtAssistantFilter: TEdit
            Left = 108
            Top = 16
            Width = 285
            Height = 18
            Ctl3D = False
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 0
          end
          object BtnAssistantFilter: TButton
            Left = 393
            Top = 16
            Width = 18
            Height = 18
            Caption = #8230
            Enabled = False
            TabOrder = 1
            OnClick = BtnAssistantFilterClick
          end
          object EdtLoginMainImages: TEdit
            Left = 108
            Top = 39
            Width = 285
            Height = 18
            Ctl3D = False
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 2
          end
          object BtnLoginMainImages: TButton
            Left = 393
            Top = 39
            Width = 18
            Height = 18
            Caption = #8230
            Enabled = False
            TabOrder = 3
            OnClick = BtnLoginMainImagesClick
          end
          object CheckBox1: TCheckBox
            Left = 92
            Top = 17
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
            Top = 39
            Width = 14
            Height = 17
            Hint = #22914#19981#21246#36873#21017#29983#25104#40664#35748#30331#38470#22120#22270#12290
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = CheckBox2Click
          end
        end
        object GroupBox4: TGroupBox
          Left = 11
          Top = 188
          Width = 419
          Height = 77
          Caption = #29983#25104#30331#38470#22120#25110#37197#22871#32593#20851
          TabOrder = 3
          object Label6: TLabel
            Left = 16
            Top = 23
            Width = 36
            Height = 12
            Caption = #23494#38053#65306
          end
          object EdtMakeKey: TEdit
            Left = 51
            Top = 20
            Width = 361
            Height = 18
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 0
          end
          object BtnMakeLogin: TButton
            Left = 56
            Top = 45
            Width = 110
            Height = 24
            Caption = #29983#25104#30331#38470#22120'(&M)'
            TabOrder = 1
            OnClick = BtnMakeLoginClick
          end
          object BtnMakeGate: TButton
            Left = 240
            Top = 45
            Width = 110
            Height = 25
            Caption = #29983#25104#37197#22871#32593#20851'(&M)'
            TabOrder = 2
            OnClick = BtnMakeGateClick
          end
        end
        object Button17: TButton
          Left = 358
          Top = 42
          Width = 69
          Height = 20
          Caption = #38543#26426#21462#21517
          TabOrder = 4
          OnClick = Button17Click
        end
        object ProgressBar1: TProgressBar
          Left = 70
          Top = 278
          Width = 360
          Height = 12
          TabOrder = 5
        end
        object RzRadioGroupMainImages: TRzRadioGroup
          Left = 11
          Top = 64
          Width = 419
          Height = 43
          Caption = #39118#26684#36873#25321
          Columns = 10
          ItemFrameColor = 8409372
          ItemHotTrack = True
          ItemHighlightColor = 2203937
          ItemHeight = 15
          ItemIndex = 0
          Items.Strings = (
            #30028#38754#19968
            #30028#38754#20108
            #30028#38754#19977)
          LightTextStyle = True
          StartXPos = 24
          StartYPos = 5
          TabOrder = 6
          Transparent = True
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #28216#25103#21015#34920#37197#32622
      ImageIndex = 1
      object GroupBox5: TGroupBox
        Left = 8
        Top = 3
        Width = 441
        Height = 302
        Caption = #26381#21153#22120#21015#34920#35774#32622
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 0
        object GroupBox6: TGroupBox
          Left = 8
          Top = 17
          Width = 421
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
            Width = 145
            Height = 20
            Style = csDropDownList
            ItemHeight = 12
            TabOrder = 0
          end
          object BtnAddArray: TButton
            Left = 225
            Top = 14
            Width = 92
            Height = 25
            Caption = #22686#21152#20998#32452'(&A)'
            TabOrder = 1
            OnClick = BtnAddArrayClick
          end
          object BtnDelArray: TButton
            Left = 325
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
          Width = 425
          Height = 201
          Caption = #26381#21153#22120#21015#34920
          TabOrder = 1
          object BtnGameListAdd: TSpeedButton
            Left = 72
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
            Left = 165
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
            Left = 258
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
            Width = 408
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
          Left = 80
          Top = 272
          Width = 114
          Height = 25
          Caption = #29983#25104#28216#25103#21015#34920#25991#20214
          TabOrder = 2
          OnClick = Button5Click
        end
        object BtnSaveGameListConfig: TButton
          Left = 263
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
        Left = 318
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
        Left = 102
        Top = 257
        Width = 66
        Height = 12
        Caption = #25991#20214'MD5'#20540#65306
      end
      object Label13: TLabel
        Left = 102
        Top = 234
        Width = 60
        Height = 12
        Caption = #19979#36733#22320#22336#65306
      end
      object Label12: TLabel
        Left = 289
        Top = 213
        Width = 60
        Height = 12
        Caption = #25991#20214#21517#31216#65306
      end
      object Label11: TLabel
        Left = 102
        Top = 213
        Width = 96
        Height = 12
        Caption = #23458#25143#31471#23384#25918#30446#24405#65306
      end
      object Memo1: TMemo
        Left = 4
        Top = 0
        Width = 452
        Height = 201
        Ctl3D = False
        Lines.Strings = (
          ';'#25991#20214#31867#22411'(0='#26222#36890#25991#20214' 1='#30331#38470#22120' 2=ZIP'#21387#32553#25991#20214')'#9#30446#24405#9#25991#20214#21517#31216#9
          'MD5'#20540#9#19979#36733#22320#22336)
        ParentCtl3D = False
        TabOrder = 0
      end
      object FileTypeRadioGroup: TRzRadioGroup
        Left = 0
        Top = 206
        Width = 97
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
        Width = 51
        Height = 25
        Caption = #28155#21152'(&A)'
        TabOrder = 2
        OnClick = Button11Click
      end
      object ComBoxDir: TComboBox
        Left = 197
        Top = 209
        Width = 90
        Height = 18
        Style = csOwnerDrawFixed
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
        Left = 347
        Top = 209
        Width = 108
        Height = 18
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
      end
      object EdtDownUrl: TEdit
        Left = 168
        Top = 232
        Width = 288
        Height = 18
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 5
      end
      object EdtMd5: TEdit
        Left = 168
        Top = 254
        Width = 147
        Height = 18
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 6
      end
      object BtnOpenFile: TButton
        Left = 52
        Top = 280
        Width = 71
        Height = 25
        Caption = #25171#24320#25991#20214'(&O)'
        TabOrder = 7
        OnClick = BtnOpenFileClick
      end
      object Button13: TButton
        Left = 124
        Top = 280
        Width = 119
        Height = 25
        Caption = #29983#25104#28216#25103#26356#26032#21015#34920'(&S)'
        TabOrder = 8
        OnClick = Button13Click
      end
      object Button14: TButton
        Left = 245
        Top = 280
        Width = 120
        Height = 25
        Caption = #35835#21462#28216#25103#26356#26032#25991#20214'(&R)'
        TabOrder = 9
        OnClick = Button14Click
      end
      object Button15: TButton
        Left = 366
        Top = 280
        Width = 94
        Height = 25
        Caption = #20445#23384#32534#36753#25991#20214'(&S)'
        TabOrder = 10
        OnClick = Button15Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = #21453#22806#25346#37197#32622
      ImageIndex = 3
      object GroupBox8: TGroupBox
        Left = 8
        Top = 3
        Width = 441
        Height = 302
        Caption = #21453#22806#25346#37197#32622
        TabOrder = 0
        object Label8: TLabel
          Left = 202
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
          Width = 185
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
          Left = 201
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
          Left = 308
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
      object Label10: TLabel
        Left = 0
        Top = 269
        Width = 372
        Height = 36
        Caption = 
          #21482#26377#30427#22823#20869#25346#25165#37197#32622#27492#20449#24687#65292#27809#28155#21152#30340#29289#21697#25110#36807#28388#29289#21697#37324#20801#35768#30340#37117#26159#27809#13#36807#28388#30340#12290'  '#24847#20041#65306#20869#25346#20013#36873#20013#36807#28388#26174#31034#25110#36807#28388#25342#21462#32780#21152#36733#27492#21015#34920#12290#13#29983 +
          #25104#23436#36807#28388#25991#20214#38656#35201#22312'['#29983#25104#30331#38470#22120']'#39029#37324#38057#36873'['#38598#25104#30427#22823#36807#28388#25991#20214']'#12290
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBox10: TGroupBox
        Left = 8
        Top = 3
        Width = 225
        Height = 262
        Caption = #36807#28388#29289#21697#21015#34920
        TabOrder = 0
        object ListViewDisallow: TListView
          Left = 8
          Top = 15
          Width = 209
          Height = 240
          Hint = '1'#20026#20801#35768#65292'0'#20026#31105#27490
          Columns = <
            item
              Caption = #29289#21697#21015#34920
              Width = 100
            end
            item
              Caption = #25342#21462
              Width = 52
            end
            item
              Caption = #26174#31034
              Width = 39
            end>
          GridLines = True
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          ParentShowHint = False
          PopupMenu = PopupMenu1
          ShowHint = True
          TabOrder = 0
          ViewStyle = vsReport
          OnMouseUp = ListViewDisallowMouseUp
        end
      end
      object GroupBox11: TGroupBox
        Left = 302
        Top = 3
        Width = 155
        Height = 262
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList: TListBox
          Left = 8
          Top = 16
          Width = 140
          Height = 238
          ItemHeight = 12
          MultiSelect = True
          TabOrder = 0
        end
      end
      object Button7: TButton
        Left = 240
        Top = 32
        Width = 58
        Height = 25
        Caption = '<--'#22686#21152
        TabOrder = 2
        OnClick = Button7Click
      end
      object BtnSdoDel: TButton
        Left = 240
        Top = 69
        Width = 58
        Height = 25
        Caption = #21024#38500
        TabOrder = 3
        OnClick = BtnSdoDelClick
      end
      object BtnAllAdd: TButton
        Left = 240
        Top = 107
        Width = 58
        Height = 25
        Caption = #20840#37096#22686#21152
        TabOrder = 4
        OnClick = BtnAllAddClick
      end
      object BtnSdoAllDel: TButton
        Left = 240
        Top = 144
        Width = 58
        Height = 25
        Caption = #20840#37096#21024#38500
        TabOrder = 5
        OnClick = BtnSdoAllDelClick
      end
      object Button3: TButton
        Left = 369
        Top = 282
        Width = 89
        Height = 25
        Caption = #29983#25104#36807#28388#25991#20214
        TabOrder = 6
        OnClick = Button3Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Title = #25171#24320
    Left = 100
    Top = 247
  end
  object PopupMenu1: TPopupMenu
    Left = 156
    Top = 186
    object N1: TMenuItem
      Caption = #20801#35768#25342#21462
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #20801#35768#26174#31034
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #31105#27490#25342#21462
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #31105#27490#26174#31034
      OnClick = N4Click
    end
  end
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    RecvBufferSize = 8192
    SendBufferSize = 1024
    OnWork = IdFTP1Work
    OnWorkBegin = IdFTP1WorkBegin
    Port = 22
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 17
    Top = 250
  end
  object IdAntiFreeze1: TIdAntiFreeze
    OnlyWhenIdle = False
    Left = 49
    Top = 250
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Title = #25171#24320
    Left = 135
    Top = 242
  end
  object RzBalloonHints1: TRzBalloonHints
    Bitmaps.TransparentColor = clOlive
    CaptionWidth = 200
    Color = clAqua
    FrameColor = cl3DDkShadow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    HintPause = 10
    ShowBalloon = False
    Left = 20
    Top = 281
  end
end
