object frmHumanInfo: TfrmHumanInfo
  Left = 349
  Top = 215
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20154#29289#23646#24615
  ClientHeight = 335
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 633
    Height = 241
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #20154#29289#20449#24687
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label40: TLabel
        Left = 216
        Top = 74
        Width = 42
        Height = 12
        Caption = #26426#22120#30721':'
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 13
        Width = 201
        Height = 193
        Caption = #26597#30475#20449#24687
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 19
          Width = 54
          Height = 12
          Caption = #20154#29289#21517#31216':'
        end
        object Label2: TLabel
          Left = 8
          Top = 43
          Width = 54
          Height = 12
          Caption = #25152#22312#22320#22270':'
        end
        object Label3: TLabel
          Left = 8
          Top = 67
          Width = 54
          Height = 12
          Caption = #25152#22312#24231#26631':'
        end
        object Label4: TLabel
          Left = 8
          Top = 91
          Width = 54
          Height = 12
          Caption = #30331#24405#24080#21495':'
        end
        object Label5: TLabel
          Left = 8
          Top = 115
          Width = 42
          Height = 12
          Caption = #30331#24405'IP:'
        end
        object Label6: TLabel
          Left = 8
          Top = 139
          Width = 54
          Height = 12
          Caption = #30331#24405#26102#38388':'
        end
        object Label7: TLabel
          Left = 8
          Top = 163
          Width = 54
          Height = 12
          Caption = #22312#32447#26102#38271':'
        end
        object EditName: TEdit
          Left = 64
          Top = 16
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 0
          Text = 'EditName'
        end
        object EditMap: TEdit
          Left = 64
          Top = 40
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 1
          Text = 'Edit1'
        end
        object EditXY: TEdit
          Left = 64
          Top = 64
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 2
          Text = 'Edit1'
        end
        object EditAccount: TEdit
          Left = 64
          Top = 88
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 3
          Text = 'Edit1'
        end
        object EditIPaddr: TEdit
          Left = 64
          Top = 112
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 4
          Text = 'Edit1'
        end
        object EditLogonTime: TEdit
          Left = 64
          Top = 136
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 5
          Text = 'Edit1'
        end
        object EditLogonLong: TEdit
          Left = 64
          Top = 160
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 6
          Text = 'Edit1'
        end
      end
      object GroupBox11: TGroupBox
        Left = 216
        Top = 16
        Width = 401
        Height = 46
        Caption = #31163#32447#25346#26426
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 20
          Width = 60
          Height = 12
          Caption = #33258#21160#21457#35328#65306
        end
        object EditSayMsg: TEdit
          Left = 72
          Top = 16
          Width = 321
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
          Text = 'EditSayMsg'
        end
      end
      object EditHCode: TEdit
        Left = 272
        Top = 71
        Width = 129
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ReadOnly = True
        TabOrder = 2
        Text = 'EditHCode'
      end
    end
    object TabSheet2: TTabSheet
      Caption = #26222#36890#25968#25454
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 201
        Caption = #21487#35843#23646#24615
        TabOrder = 0
        object Label12: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = #31561#32423':'
        end
        object Label8: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #37329#24065#25968':'
        end
        object Label9: TLabel
          Left = 8
          Top = 65
          Width = 42
          Height = 12
          Caption = 'PK'#28857#25968':'
        end
        object Label10: TLabel
          Left = 8
          Top = 89
          Width = 54
          Height = 12
          Caption = #24403#21069#32463#39564':'
        end
        object Label21: TLabel
          Left = 8
          Top = 113
          Width = 54
          Height = 12
          Caption = #21319#32423#32463#39564':'
        end
        object Label32: TLabel
          Left = 8
          Top = 136
          Width = 54
          Height = 12
          Caption = #20869#21151#31561#32423':'
        end
        object Label34: TLabel
          Left = 8
          Top = 159
          Width = 54
          Height = 12
          Caption = #20869#21151#32463#39564':'
        end
        object EditLevel: TSpinEdit
          Left = 68
          Top = 15
          Width = 101
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object EditGold: TSpinEdit
          Left = 68
          Top = 39
          Width = 101
          Height = 21
          Increment = 1000
          MaxValue = 200000000
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
        object EditPKPoint: TSpinEdit
          Left = 68
          Top = 62
          Width = 101
          Height = 21
          Increment = 50
          MaxValue = 20000
          MinValue = 0
          TabOrder = 2
          Value = 10
        end
        object EditExp: TSpinEdit
          Left = 68
          Top = 86
          Width = 101
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 3
          Value = 10
        end
        object EditMaxExp: TSpinEdit
          Left = 68
          Top = 110
          Width = 101
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 4
          Value = 10
        end
        object EditNGLevel: TSpinEdit
          Left = 68
          Top = 133
          Width = 101
          Height = 21
          Enabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 5
          Value = 1
        end
        object EditExpSkill69: TSpinEdit
          Left = 68
          Top = 156
          Width = 101
          Height = 21
          Hint = #24403#21069#20869#21151#32463#39564
          Enabled = False
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
      end
      object GroupBox6: TGroupBox
        Left = 352
        Top = 8
        Width = 153
        Height = 201
        Caption = #20154#29289#29366#24577
        TabOrder = 1
        object CheckBoxGameMaster: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = 'GM'#27169#24335
          TabOrder = 0
        end
        object CheckBoxSuperMan: TCheckBox
          Left = 8
          Top = 32
          Width = 113
          Height = 17
          Caption = #26080#25932#27169#24335
          TabOrder = 1
        end
        object CheckBoxObserver: TCheckBox
          Left = 8
          Top = 48
          Width = 113
          Height = 17
          Caption = #38544#36523#27169#24335
          TabOrder = 2
        end
      end
      object GroupBox9: TGroupBox
        Left = 192
        Top = 8
        Width = 153
        Height = 201
        Caption = #21487#35843#23646#24615
        TabOrder = 2
        object Label26: TLabel
          Left = 8
          Top = 18
          Width = 42
          Height = 12
          Caption = #20803#23453#25968':'
        end
        object Label27: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #33635#32768#28857':'
        end
        object Label28: TLabel
          Left = 8
          Top = 66
          Width = 42
          Height = 12
          Caption = #22768#26395#28857':'
        end
        object Label29: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #23646#24615#28857#19968':'
        end
        object Label19: TLabel
          Left = 8
          Top = 114
          Width = 54
          Height = 12
          Hint = #24050#20998#37197#23646#24615#28857#25968#12290
          Caption = #23646#24615#28857#20108':'
        end
        object Label25: TLabel
          Left = 8
          Top = 138
          Width = 42
          Height = 12
          Caption = #37329#21018#30707':'
        end
        object Label30: TLabel
          Left = 8
          Top = 162
          Width = 42
          Height = 12
          Caption = #28789'  '#31526':'
        end
        object EditGameGold: TSpinEdit
          Left = 68
          Top = 15
          Width = 69
          Height = 21
          Hint = #26368#39640#20540#20026'21'#20159','#35831#21247#36229#36807'21'#20159
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object EditGamePoint: TSpinEdit
          Left = 68
          Top = 39
          Width = 69
          Height = 21
          MaxValue = 200000000
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
        object EditCreditPoint: TSpinEdit
          Left = 68
          Top = 63
          Width = 69
          Height = 21
          MaxValue = 2147483647
          MinValue = 0
          TabOrder = 2
          Value = 10
        end
        object EditBonusPoint: TSpinEdit
          Left = 68
          Top = 87
          Width = 69
          Height = 21
          Hint = #26410#20998#37197#23646#24615#28857
          MaxValue = 2000000
          MinValue = 0
          TabOrder = 3
          Value = 10
        end
        object EditEditBonusPointUsed: TSpinEdit
          Left = 68
          Top = 111
          Width = 69
          Height = 21
          Hint = #26410#20998#37197#23646#24615#28857
          EditorEnabled = False
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 4
          Value = 10
        end
        object EditGameGird: TSpinEdit
          Left = 68
          Top = 159
          Width = 69
          Height = 21
          MaxValue = 20000000
          MinValue = 0
          TabOrder = 5
          Value = 10
        end
        object EditGameDiaMond: TSpinEdit
          Left = 68
          Top = 135
          Width = 69
          Height = 21
          MaxValue = 200000000
          MinValue = 0
          TabOrder = 6
          Value = 10
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #23646#24615#28857
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 153
        Height = 193
        Caption = #20154#29289#23646#24615
        TabOrder = 0
        object Label11: TLabel
          Left = 8
          Top = 19
          Width = 30
          Height = 12
          Caption = #38450#24481':'
        end
        object Label13: TLabel
          Left = 8
          Top = 43
          Width = 30
          Height = 12
          Caption = #39764#38450':'
        end
        object Label14: TLabel
          Left = 8
          Top = 67
          Width = 42
          Height = 12
          Caption = #25915#20987#21147':'
        end
        object Label15: TLabel
          Left = 8
          Top = 91
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object Label16: TLabel
          Left = 8
          Top = 115
          Width = 30
          Height = 12
          Caption = #36947#26415':'
        end
        object Label17: TLabel
          Left = 8
          Top = 139
          Width = 42
          Height = 12
          Caption = #29983#21629#20540':'
        end
        object Label18: TLabel
          Left = 8
          Top = 163
          Width = 42
          Height = 12
          Caption = #39764#27861#20540':'
        end
        object EditAC: TEdit
          Left = 56
          Top = 16
          Width = 81
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 0
          Text = 'EditName'
        end
        object EditMAC: TEdit
          Left = 56
          Top = 40
          Width = 81
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 1
          Text = 'EditName'
        end
        object EditDC: TEdit
          Left = 56
          Top = 64
          Width = 81
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 2
          Text = 'EditName'
        end
        object EditMC: TEdit
          Left = 56
          Top = 88
          Width = 81
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 3
          Text = 'EditName'
        end
        object EditSC: TEdit
          Left = 56
          Top = 112
          Width = 81
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 4
          Text = 'EditName'
        end
        object EditHP: TEdit
          Left = 56
          Top = 136
          Width = 81
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 5
          Text = 'EditName'
        end
        object EditMP: TEdit
          Left = 56
          Top = 160
          Width = 81
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 6
          Text = 'EditName'
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #36523#19978#35013#22791
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox7: TGroupBox
        Left = 4
        Top = 8
        Width = 616
        Height = 201
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridUserItem: TStringGrid
          Left = 4
          Top = 16
          Width = 607
          Height = 177
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            68
            45
            45
            44
            43
            46
            97)
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #32972#21253#29289#21697
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox8: TGroupBox
        Left = 3
        Top = 3
        Width = 616
        Height = 201
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridBagItem: TStringGrid
          Left = 5
          Top = 16
          Width = 604
          Height = 177
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            68
            45
            45
            44
            43
            46
            95)
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #20179#24211#29289#21697
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox10: TGroupBox
        Left = 8
        Top = 8
        Width = 609
        Height = 201
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridStorageItem: TStringGrid
          Left = 8
          Top = 16
          Width = 593
          Height = 177
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          FixedCols = 0
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            67
            45
            45
            44
            43
            46
            89)
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #33521#38596#20449#24687
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox12: TGroupBox
        Left = 8
        Top = 5
        Width = 201
        Height = 193
        Caption = #22522#26412#20449#24687
        TabOrder = 0
        object Label22: TLabel
          Left = 8
          Top = 19
          Width = 54
          Height = 12
          Caption = #33521#38596#21517#31216':'
        end
        object Label23: TLabel
          Left = 8
          Top = 43
          Width = 54
          Height = 12
          Caption = #25152#22312#22320#22270':'
        end
        object Label24: TLabel
          Left = 8
          Top = 67
          Width = 54
          Height = 12
          Caption = #25152#22312#24231#26631':'
        end
        object EditHeroName: TEdit
          Left = 64
          Top = 16
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 0
        end
        object EditHeroMap: TEdit
          Left = 64
          Top = 40
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 1
        end
        object EditHeroXY: TEdit
          Left = 64
          Top = 64
          Width = 129
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 2
        end
      end
      object GroupBox13: TGroupBox
        Left = 224
        Top = 5
        Width = 177
        Height = 192
        Caption = #21487#35843#23646#24615
        TabOrder = 1
        object Label33: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = #31561#32423':'
        end
        object Label35: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = 'PK'#28857#25968':'
        end
        object Label36: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #24403#21069#32463#39564':'
        end
        object Label37: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #21319#32423#32463#39564':'
        end
        object Label31: TLabel
          Left = 8
          Top = 114
          Width = 42
          Height = 12
          Caption = #24544#35802#24230':'
        end
        object Label38: TLabel
          Left = 8
          Top = 137
          Width = 54
          Height = 12
          Caption = #20869#21151#31561#32423':'
        end
        object Label39: TLabel
          Left = 8
          Top = 160
          Width = 54
          Height = 12
          Caption = #20869#21151#32463#39564':'
        end
        object EditHeroLevel: TSpinEdit
          Left = 68
          Top = 15
          Width = 101
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
        end
        object EditHeroPKPoint: TSpinEdit
          Left = 68
          Top = 39
          Width = 101
          Height = 21
          Increment = 50
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 10
        end
        object EditHeroExp: TSpinEdit
          Left = 68
          Top = 63
          Width = 101
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 2
          Value = 10
        end
        object EditHeroMaxExp: TSpinEdit
          Left = 68
          Top = 87
          Width = 101
          Height = 21
          EditorEnabled = False
          Enabled = False
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 3
          Value = 10
        end
        object EditHeroLoyal: TSpinEdit
          Left = 68
          Top = 111
          Width = 101
          Height = 21
          Hint = '100'#20026#24544#35802#24230'1%'
          MaxValue = 10000
          MinValue = 0
          TabOrder = 4
          Value = 10
        end
        object EditHeroNGLevel: TSpinEdit
          Left = 68
          Top = 134
          Width = 101
          Height = 21
          Enabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 5
          Value = 1
        end
        object EditHeroExpSkill69: TSpinEdit
          Left = 68
          Top = 157
          Width = 101
          Height = 21
          Hint = #24403#21069#20869#21151#32463#39564
          Enabled = False
          MaxValue = 2100000000
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = #33521#38596#35013#22791
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox14: TGroupBox
        Left = 3
        Top = 8
        Width = 617
        Height = 201
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridHeroUserItem: TStringGrid
          Left = 5
          Top = 16
          Width = 606
          Height = 177
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            68
            45
            45
            44
            43
            46
            97)
        end
      end
    end
    object TabSheet9: TTabSheet
      Caption = #33521#38596#32972#21253
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox15: TGroupBox
        Left = 2
        Top = 8
        Width = 619
        Height = 201
        Caption = #35013#22791#21015#34920
        TabOrder = 0
        object GridHeroBagItem: TStringGrid
          Left = 5
          Top = 16
          Width = 609
          Height = 177
          ColCount = 10
          DefaultColWidth = 55
          DefaultRowHeight = 18
          RowCount = 14
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          TabOrder = 0
          ColWidths = (
            55
            67
            63
            68
            45
            45
            44
            43
            46
            102)
        end
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 256
    Width = 145
    Height = 73
    Caption = #25511#21046
    TabOrder = 1
    object CheckBoxMonitor: TCheckBox
      Left = 8
      Top = 16
      Width = 89
      Height = 17
      Caption = #23454#26102#30417#25511
      TabOrder = 0
      OnClick = CheckBoxMonitorClick
    end
    object ButtonKick: TButton
      Left = 8
      Top = 40
      Width = 65
      Height = 25
      Caption = #36386#19979#32447
      TabOrder = 1
      OnClick = ButtonKickClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 160
    Top = 256
    Width = 121
    Height = 73
    Caption = #20027#20307#24403#21069#29366#24577
    TabOrder = 2
    object EditHumanStatus: TEdit
      Left = 8
      Top = 24
      Width = 105
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ReadOnly = True
      TabOrder = 0
    end
  end
  object ButtonSave: TButton
    Left = 336
    Top = 296
    Width = 65
    Height = 25
    Caption = #20462#25913#25968#25454
    TabOrder = 3
    OnClick = ButtonSaveClick
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 144
    Top = 265
  end
end
