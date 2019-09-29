object frmFunctionConfig: TfrmFunctionConfig
  Left = 587
  Top = 229
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21151#33021#35774#32622
  ClientHeight = 403
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Label14: TLabel
    Left = 8
    Top = 383
    Width = 432
    Height = 12
    Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object FunctionConfigControl: TPageControl
    Left = 1
    Top = -1
    Width = 466
    Height = 378
    ActivePage = TabSheet39
    MultiLine = True
    TabOrder = 0
    OnChanging = FunctionConfigControlChanging
    object TabSheetGeneral: TTabSheet
      Caption = #22522#26412#21151#33021
      ImageIndex = 3
      object GroupBox7: TGroupBox
        Left = 8
        Top = 201
        Width = 138
        Height = 102
        Caption = #33021#37327#25511#21046
        TabOrder = 0
        object CheckBoxHungerSystem: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Hint = #21551#29992#27492#21151#33021#21518#65292#20154#29289#24517#39035#23450#26102#21507#39135#29289#20197#20445#25345#33021#37327#65292#22914#26524#38271#26102#38388#26410#21507#39135#29289#65292#20154#29289#23558#34987#39295#27515#12290
          Caption = #21551#29992#33021#37327#25511#21046#31995#32479
          TabOrder = 0
          OnClick = CheckBoxHungerSystemClick
        end
        object GroupBoxHunger: TGroupBox
          Left = 8
          Top = 40
          Width = 117
          Height = 57
          Caption = #33021#37327#19981#22815#26102
          TabOrder = 1
          object CheckBoxHungerDecPower: TCheckBox
            Left = 8
            Top = 32
            Width = 97
            Height = 17
            Hint = #20154#29289#30340#25915#20987#21147#65292#19982#20154#29289#30340#33021#37327#30456#20851#65292#33021#37327#19981#22815#26102#20154#29289#30340#25915#20987#21147#23558#38543#20043#19979#38477#12290
            Caption = #33258#21160#20943#25915#20987#21147
            TabOrder = 0
            OnClick = CheckBoxHungerDecPowerClick
          end
          object CheckBoxHungerDecHP: TCheckBox
            Left = 8
            Top = 16
            Width = 89
            Height = 17
            Hint = #24403#20154#29289#38271#26102#38388#27809#21507#39135#29289#21518#33021#37327#38477#21040'0'#21518#65292#23558#24320#22987#33258#21160#20943#23569'HP'#20540#65292#38477#21040'0'#21518#65292#20154#29289#27515#20129#12290
            Caption = #33258#21160#20943'HP'
            TabOrder = 1
            OnClick = CheckBoxHungerDecHPClick
          end
        end
      end
      object ButtonGeneralSave: TButton
        Left = 365
        Top = 287
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonGeneralSaveClick
      end
      object GroupBox34: TGroupBox
        Left = 8
        Top = 3
        Width = 137
        Height = 197
        Caption = #21517#23383#26174#31034#39068#33394
        TabOrder = 2
        object Label85: TLabel
          Left = 11
          Top = 16
          Width = 54
          Height = 12
          Caption = #25915#20987#29366#24577':'
        end
        object LabelPKFlagNameColor: TLabel
          Left = 112
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label87: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #40644#21517#29366#24577':'
        end
        object LabelPKLevel1NameColor: TLabel
          Left = 112
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label89: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #32418#21517#29366#24577':'
        end
        object LabelPKLevel2NameColor: TLabel
          Left = 112
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label91: TLabel
          Left = 11
          Top = 88
          Width = 54
          Height = 12
          Caption = #32852#30431#25112#20105':'
        end
        object LabelAllyAndGuildNameColor: TLabel
          Left = 112
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label93: TLabel
          Left = 11
          Top = 112
          Width = 54
          Height = 12
          Caption = #25932#23545#25112#20105':'
        end
        object LabelWarGuildNameColor: TLabel
          Left = 112
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label95: TLabel
          Left = 11
          Top = 136
          Width = 54
          Height = 12
          Caption = #25112#20105#21306#22495':'
        end
        object LabelInFreePKAreaNameColor: TLabel
          Left = 112
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label234: TLabel
          Left = 11
          Top = 160
          Width = 48
          Height = 12
          Caption = 'NPC'#21517#23383':'
        end
        object LabelNPCNameColor: TLabel
          Left = 112
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditPKFlagNameColor: TSpinEdit
          Left = 64
          Top = 12
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#25915#20987#20854#20182#20154#29289#26102#21517#23383#39068#33394#65292#40664#35748#20026'47'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditPKFlagNameColorChange
        end
        object EditPKLevel1NameColor: TSpinEdit
          Left = 64
          Top = 36
          Width = 41
          Height = 21
          Hint = #24403#20154#29289'PK'#28857#36229#36807'100'#28857#26102#21517#23383#39068#33394#65292#40664#35748#20026'251'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditPKLevel1NameColorChange
        end
        object EditPKLevel2NameColor: TSpinEdit
          Left = 64
          Top = 60
          Width = 41
          Height = 21
          Hint = #24403#20154#29289'PK'#28857#36229#36807'200'#28857#26102#21517#23383#39068#33394#65292#40664#35748#20026'249'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditPKLevel2NameColorChange
        end
        object EditAllyAndGuildNameColor: TSpinEdit
          Left = 64
          Top = 84
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#26412#34892#20250#21450#32852#30431#34892#20250#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'180'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditAllyAndGuildNameColorChange
        end
        object EditWarGuildNameColor: TSpinEdit
          Left = 64
          Top = 108
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#26102#65292#25932#23545#34892#20250#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'69'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditWarGuildNameColorChange
        end
        object EditInFreePKAreaNameColor: TSpinEdit
          Left = 64
          Top = 132
          Width = 41
          Height = 21
          Hint = #24403#20154#29289#22312#34892#20250#25112#20105#21306#22495#26102#20154#29289#21517#23383#39068#33394#65292#40664#35748#20026'221'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditInFreePKAreaNameColorChange
        end
        object CheckBoxShowGuildName: TCheckBox
          Left = 8
          Top = 178
          Width = 121
          Height = 17
          Hint = #20154#29289#21517#31216#26174#31034#34892#20250#20449#24687','#22914#19981#35774#32622','#21017#21482#13#26377#27801#24052#20811#34892#20250#22312#20154#29289#21517#31216#26174#31034','#20854#23427#34892#13#20250'('#38500#25915#22478#21306#22495#22806')'#19981#22312#20154#29289#21517#31216#26174#31034#20449#24687
          Caption = #21517#23383#26174#31034#34892#20250#20449#24687
          TabOrder = 6
          OnClick = CheckBoxShowGuildNameClick
        end
        object SpinEditNPCNameColor: TSpinEdit
          Left = 64
          Top = 156
          Width = 41
          Height = 21
          Hint = 'NPC'#21517#23383#39068#33394#65292#40664#35748#20026'255'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = SpinEditNPCNameColorChange
        end
      end
      object GroupBox62: TGroupBox
        Left = 152
        Top = 3
        Width = 137
        Height = 43
        Caption = #22320#22270#20107#20214#35302#21457
        TabOrder = 3
        object CheckBoxStartMapEvent: TCheckBox
          Left = 8
          Top = 17
          Width = 121
          Height = 15
          Caption = #24320#21551#22320#22270#20107#20214#35302#21457
          TabOrder = 0
          OnClick = CheckBoxStartMapEventClick
        end
      end
      object GroupBox99: TGroupBox
        Left = 295
        Top = 3
        Width = 139
        Height = 43
        Caption = #25361#25112#26102#38271
        TabOrder = 4
        object Label202: TLabel
          Left = 7
          Top = 19
          Width = 60
          Height = 12
          Caption = #25361#25112#26102#38388#65306
        end
        object Label203: TLabel
          Left = 120
          Top = 20
          Width = 12
          Height = 12
          Caption = #31186
        end
        object SpinEditChallengeTime: TSpinEdit
          Left = 71
          Top = 15
          Width = 48
          Height = 21
          Hint = #36827#34892#25361#25112#30340#26377#25928#26102#38388
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 300
          OnChange = SpinEditChallengeTimeChange
        end
      end
      object GroupBox101: TGroupBox
        Left = 152
        Top = 46
        Width = 295
        Height = 56
        Caption = #27668#34880#30707
        TabOrder = 5
        object Label204: TLabel
          Left = 5
          Top = 14
          Width = 36
          Height = 12
          Caption = #24403'HP'#25481
        end
        object Label205: TLabel
          Left = 81
          Top = 14
          Width = 108
          Height = 12
          Caption = #26102#24320#21551#27668#34880#30707','#38388#38548':'
        end
        object Label206: TLabel
          Left = 4
          Top = 35
          Width = 48
          Height = 12
          Caption = #27599#27425#21152'HP'
        end
        object Label207: TLabel
          Left = 117
          Top = 35
          Width = 84
          Height = 12
          Caption = #27668#34880#30707#25345#20037#20943#23569
        end
        object Label208: TLabel
          Left = 269
          Top = 35
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label209: TLabel
          Left = 254
          Top = 14
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object SpinEditStartHPRock: TSpinEdit
          Left = 40
          Top = 10
          Width = 41
          Height = 21
          Hint = #24635#34880#20540#20026'600,'#35774#32622#20540'90,'#21363#24403#21069#34880#20540#20302#20110'510'#26102','#20351#29992#29289#21697
          MaxValue = 10000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartHPRockChange
        end
        object SpinEditRockAddHP: TSpinEdit
          Left = 53
          Top = 31
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddHPChange
        end
        object SpinEditHPRockDecDura: TSpinEdit
          Left = 200
          Top = 31
          Width = 65
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 6
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPRockDecDuraChange
        end
        object SpinEditHPRockSpell: TSpinEdit
          Left = 188
          Top = 10
          Width = 60
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 10000000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 700
          OnChange = SpinEditHPRockSpellChange
        end
      end
      object GroupBox102: TGroupBox
        Left = 152
        Top = 103
        Width = 296
        Height = 56
        Caption = #24187#39764#30707
        TabOrder = 6
        object Label210: TLabel
          Left = 8
          Top = 13
          Width = 36
          Height = 12
          Caption = #24403'MP'#25481
        end
        object Label211: TLabel
          Left = 8
          Top = 35
          Width = 48
          Height = 12
          Caption = #27599#27425#21152'MP'
        end
        object Label212: TLabel
          Left = 119
          Top = 35
          Width = 84
          Height = 12
          Caption = #24187#39764#30707#25345#20037#20943#23569
        end
        object Label213: TLabel
          Left = 270
          Top = 35
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label214: TLabel
          Left = 86
          Top = 13
          Width = 108
          Height = 12
          Caption = #26102#24320#21551#24187#39764#30707','#38388#38548':'
        end
        object Label215: TLabel
          Left = 251
          Top = 12
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object SpinEditStartMPRock: TSpinEdit
          Left = 45
          Top = 9
          Width = 41
          Height = 21
          Hint = #24635#39764#27861#20540#20026'600,'#35774#32622#20540'90,'#21363#24403#21069#39764#27861#20540#20302#20110'510'#26102','#20351#29992#29289#21697
          MaxValue = 10000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartMPRockChange
        end
        object SpinEditRockAddMP: TSpinEdit
          Left = 60
          Top = 31
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddMPChange
        end
        object SpinEditMPRockDecDura: TSpinEdit
          Left = 202
          Top = 31
          Width = 65
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 6
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditMPRockDecDuraChange
        end
        object SpinEditMPRockSpell: TSpinEdit
          Left = 193
          Top = 9
          Width = 57
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 10000000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 700
          OnChange = SpinEditMPRockSpellChange
        end
      end
      object GroupBox103: TGroupBox
        Left = 152
        Top = 160
        Width = 296
        Height = 58
        Caption = #39764#34880#30707
        TabOrder = 7
        object Label216: TLabel
          Left = 3
          Top = 15
          Width = 60
          Height = 12
          Caption = #24403'HP'#25110'MP'#25481
        end
        object Label217: TLabel
          Left = 3
          Top = 37
          Width = 72
          Height = 12
          Caption = #27599#27425#21152'HP'#25110'MP'
        end
        object Label218: TLabel
          Left = 130
          Top = 36
          Width = 84
          Height = 12
          Caption = #39764#34880#30707#25345#20037#20943#23569
        end
        object Label219: TLabel
          Left = 277
          Top = 37
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label220: TLabel
          Left = 107
          Top = 15
          Width = 96
          Height = 12
          Caption = #26102#24320#21551#20351#29992','#38388#38548':'
        end
        object Label221: TLabel
          Left = 258
          Top = 16
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object SpinEditStartHPMPRock: TSpinEdit
          Left = 63
          Top = 11
          Width = 42
          Height = 21
          Hint = #24635'HP'#25110'MP'#20026'600,'#35774#32622#20540'90,'#21363#24403#21069'HP'#25110'MP'#20302#20110'510'#26102','#20351#29992#29289#21697
          MaxValue = 10000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartHPMPRockChange
        end
        object SpinEditRockAddHPMP: TSpinEdit
          Left = 80
          Top = 33
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddHPMPChange
        end
        object SpinEditHPMPRockDecDura: TSpinEdit
          Left = 211
          Top = 34
          Width = 60
          Height = 21
          Hint = '1000=1'#25345#20037
          MaxValue = 1000000
          MinValue = 6
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPMPRockDecDuraChange
        end
        object SpinEditHPMPRockSpell: TSpinEdit
          Left = 207
          Top = 10
          Width = 53
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 10000000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 700
          OnChange = SpinEditHPMPRockSpellChange
        end
      end
      object GroupBox224: TGroupBox
        Left = 151
        Top = 219
        Width = 296
        Height = 58
        Caption = #22825#40857#21360
        TabOrder = 8
        object Label559: TLabel
          Left = 3
          Top = 15
          Width = 60
          Height = 12
          Caption = #24403'HP'#25110'MP'#25481
        end
        object Label560: TLabel
          Left = 3
          Top = 38
          Width = 72
          Height = 12
          Caption = #27599#27425#21152'HP'#25110'MP'
        end
        object Label561: TLabel
          Left = 130
          Top = 37
          Width = 84
          Height = 12
          Caption = #22825#40857#21360#25345#20037#20943#23569
        end
        object Label562: TLabel
          Left = 277
          Top = 38
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label563: TLabel
          Left = 107
          Top = 15
          Width = 96
          Height = 12
          Caption = #26102#24320#21551#20351#29992','#38388#38548':'
        end
        object Label564: TLabel
          Left = 258
          Top = 16
          Width = 24
          Height = 12
          Caption = #27627#31186
        end
        object SpinEditStartHPMPRock1: TSpinEdit
          Left = 63
          Top = 11
          Width = 42
          Height = 21
          Hint = #24635'HP'#25110'MP'#20026'600,'#35774#32622#20540'90,'#21363#24403#21069'HP'#25110'MP'#20302#20110'510'#26102','#20351#29992#29289#21697
          MaxValue = 10000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 90
          OnChange = SpinEditStartHPMPRock1Change
        end
        object SpinEditRockAddHPMP1: TSpinEdit
          Left = 80
          Top = 34
          Width = 49
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = SpinEditRockAddHPMP1Change
        end
        object SpinEditHPMPRockDecDura1: TSpinEdit
          Left = 211
          Top = 33
          Width = 60
          Height = 21
          MaxValue = 1000000
          MinValue = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 100
          OnChange = SpinEditHPMPRockDecDura1Change
        end
        object SpinEditHPMPRockSpell1: TSpinEdit
          Left = 207
          Top = 10
          Width = 53
          Height = 21
          Hint = #27599#27425#20351#29992#30340#38388#38548#26102#38388
          MaxValue = 10000000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 700
          OnChange = SpinEditHPMPRockSpell1Change
        end
      end
      object CheckBoxUseFengHaoAbil: TCheckBox
        Left = 152
        Top = 279
        Width = 138
        Height = 17
        Hint = #21551#29992#27492#21151#33021#21518#65292#21482#33021#33719#24471#21551#29992#30340#31216#21495#23646#24615#65292#20854#23427#31216#21495#23646#24615#26080#25928
        Caption = #31216#21495#21551#29992#21518#23646#24615#29983#25928
        TabOrder = 9
        OnClick = CheckBoxUseFengHaoAbilClick
      end
      object CheckBoxClearGamePoint: TCheckBox
        Left = 152
        Top = 297
        Width = 107
        Height = 17
        Hint = #21551#29992#27492#21151#33021#21518#65292#27599#26376'15'#21495#25110#26376#24213#28165#31354#28216#25103#28857#23646#24615
        Caption = #23450#26399#28165#31354#28216#25103#28857
        TabOrder = 10
        OnClick = CheckBoxClearGamePointClick
      end
    end
    object PasswordSheet: TTabSheet
      Caption = #23494#30721#20445#25252
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 8
        Top = 0
        Width = 433
        Height = 193
        TabOrder = 0
        object CheckBoxEnablePasswordLock: TCheckBox
          Left = 8
          Top = -5
          Width = 121
          Height = 25
          Caption = #21551#29992#23494#30721#20445#25252#31995#32479
          TabOrder = 0
          OnClick = CheckBoxEnablePasswordLockClick
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 16
          Width = 265
          Height = 169
          Caption = #38145#23450#25511#21046
          TabOrder = 1
          object CheckBoxLockGetBackItem: TCheckBox
            Left = 8
            Top = 16
            Width = 121
            Height = 17
            Caption = #31105#27490#21462#20179#24211
            TabOrder = 0
            OnClick = CheckBoxLockGetBackItemClick
          end
          object GroupBox4: TGroupBox
            Left = 8
            Top = 40
            Width = 249
            Height = 116
            Caption = #30331#24405#38145#23450
            TabOrder = 1
            object CheckBoxLockWalk: TCheckBox
              Left = 8
              Top = 32
              Width = 105
              Height = 17
              Caption = #31105#27490#36208#36335
              TabOrder = 0
              OnClick = CheckBoxLockWalkClick
            end
            object CheckBoxLockRun: TCheckBox
              Left = 8
              Top = 48
              Width = 105
              Height = 17
              Caption = #31105#27490#36305#27493
              TabOrder = 1
              OnClick = CheckBoxLockRunClick
            end
            object CheckBoxLockHit: TCheckBox
              Left = 8
              Top = 64
              Width = 105
              Height = 17
              Caption = #31105#27490#25915#20987
              TabOrder = 2
              OnClick = CheckBoxLockHitClick
            end
            object CheckBoxLockSpell: TCheckBox
              Left = 8
              Top = 80
              Width = 105
              Height = 17
              Caption = #31105#27490#39764#27861
              TabOrder = 3
              OnClick = CheckBoxLockSpellClick
            end
            object CheckBoxLockSendMsg: TCheckBox
              Left = 120
              Top = 32
              Width = 105
              Height = 17
              Caption = #31105#27490#32842#22825
              TabOrder = 4
              OnClick = CheckBoxLockSendMsgClick
            end
            object CheckBoxLockInObMode: TCheckBox
              Left = 120
              Top = 16
              Width = 121
              Height = 17
              Hint = #22914#26524#26377#23494#30721#20445#25252#26102#65292#20154#29289#30331#24405#26102#20026#38544#36523#29366#24577#65292#24618#29289#19981#20250#25915#20987#20154#29289#65292#22312#36755#20837#23494#30721#24320#38145#21518#24674#22797#27491#24120#12290
              Caption = #38145#23450#26102#20026#38544#36523#27169#24335
              TabOrder = 5
              OnClick = CheckBoxLockInObModeClick
            end
            object CheckBoxLockLogin: TCheckBox
              Left = 8
              Top = 16
              Width = 105
              Height = 17
              Caption = #38145#23450#20154#29289#30331#24405
              TabOrder = 6
              OnClick = CheckBoxLockLoginClick
            end
            object CheckBoxLockUseItem: TCheckBox
              Left = 120
              Top = 80
              Width = 105
              Height = 17
              Caption = #31105#27490#20351#29992#21697
              TabOrder = 7
              OnClick = CheckBoxLockUseItemClick
            end
            object CheckBoxLockDropItem: TCheckBox
              Left = 120
              Top = 64
              Width = 105
              Height = 17
              Caption = #31105#27490#25172#29289#21697
              TabOrder = 8
              OnClick = CheckBoxLockDropItemClick
            end
            object CheckBoxLockDealItem: TCheckBox
              Left = 120
              Top = 48
              Width = 121
              Height = 17
              Caption = #31105#27490#20132#26131#29289#21697
              TabOrder = 9
              OnClick = CheckBoxLockDealItemClick
            end
            object CheckBoxLockCallHero: TCheckBox
              Left = 8
              Top = 96
              Width = 105
              Height = 17
              Caption = #31105#27490#21484#21796#33521#38596
              TabOrder = 10
              OnClick = CheckBoxLockCallHeroClick
            end
          end
        end
        object GroupBox3: TGroupBox
          Left = 280
          Top = 16
          Width = 145
          Height = 65
          Caption = #23494#30721#36755#20837#38169#35823#25511#21046
          TabOrder = 2
          object Label1: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #38169#35823#27425#25968':'
          end
          object EditErrorPasswordCount: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #22312#24320#38145#26102#36755#20837#23494#30721#65292#22914#26524#36755#20837#38169#35823#36229#36807#25351#23450#27425#25968#65292#21017#38145#23450#23494#30721#65292#24517#39035#37325#26032#30331#24405#19968#27425#25165#21487#20197#20877#27425#36755#20837#23494#30721#12290
            EditorEnabled = False
            MaxValue = 10
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditErrorPasswordCountChange
          end
          object CheckBoxErrorCountKick: TCheckBox
            Left = 8
            Top = 40
            Width = 129
            Height = 17
            Caption = #36229#36807#25351#23450#27425#25968#36386#19979#32447
            Enabled = False
            TabOrder = 1
            OnClick = CheckBoxErrorCountKickClick
          end
        end
        object ButtonPasswordLockSave: TButton
          Left = 360
          Top = 157
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 3
          OnClick = ButtonPasswordLockSaveClick
        end
      end
    end
    object TabSheet33: TTabSheet
      Caption = #24072#24466#31995#32479
      ImageIndex = 5
      object GroupBox21: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 153
        Caption = #24466#24351#20986#24072
        TabOrder = 0
        object GroupBox22: TGroupBox
          Left = 8
          Top = 16
          Width = 145
          Height = 49
          Caption = #20986#24072#31561#32423
          TabOrder = 0
          object Label29: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #20986#24072#31561#32423':'
          end
          object EditMasterOKLevel: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #20986#24072#31561#32423#35774#32622#65292#20154#29289#22312#25308#24072#21518#65292#21040#25351#23450#31561#32423#21518#23558#33258#21160#20986#24072#12290
            MaxValue = 65535
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKLevelChange
          end
        end
        object GroupBox23: TGroupBox
          Left = 8
          Top = 72
          Width = 145
          Height = 73
          Caption = #24072#29238#25152#24471
          TabOrder = 1
          object Label30: TLabel
            Left = 8
            Top = 18
            Width = 54
            Height = 12
            Caption = #22768#26395#28857#25968':'
          end
          object Label31: TLabel
            Left = 8
            Top = 42
            Width = 54
            Height = 12
            Caption = #20998#37197#28857#25968':'
          end
          object EditMasterOKCreditPoint: TSpinEdit
            Left = 68
            Top = 15
            Width = 53
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#22768#26395#28857#25968#12290
            MaxValue = 100
            MinValue = 0
            TabOrder = 0
            Value = 10
            OnChange = EditMasterOKCreditPointChange
          end
          object EditMasterOKBonusPoint: TSpinEdit
            Left = 68
            Top = 39
            Width = 53
            Height = 21
            Hint = #24466#24351#20986#24072#21518#65292#24072#29238#24471#21040#30340#20998#37197#28857#25968#12290
            MaxValue = 1000
            MinValue = 0
            TabOrder = 1
            Value = 10
            OnChange = EditMasterOKBonusPointChange
          end
        end
      end
      object ButtonMasterSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonMasterSaveClick
      end
      object GroupBox84: TGroupBox
        Left = 176
        Top = 8
        Width = 131
        Height = 49
        Caption = #24466#24351#25968#37327
        TabOrder = 2
        object Label166: TLabel
          Left = 14
          Top = 22
          Width = 42
          Height = 12
          Caption = #25910#24466#25968':'
        end
        object EditMasterCount: TSpinEdit
          Left = 61
          Top = 17
          Width = 53
          Height = 21
          Hint = #26368#22810#21487#25910#20960#20301#24466#24351'.'
          MaxValue = 100
          MinValue = 1
          TabOrder = 0
          Value = 5
          OnChange = EditMasterCountChange
        end
      end
    end
    object TabSheet38: TTabSheet
      Caption = #36716#29983#31995#32479
      ImageIndex = 9
      object GroupBox29: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 257
        Caption = #33258#21160#21464#33394
        TabOrder = 0
        object Label56: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelReNewNameColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label58: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelReNewNameColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label60: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelReNewNameColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label62: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelReNewNameColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label64: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelReNewNameColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label66: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelReNewNameColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label68: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelReNewNameColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label70: TLabel
          Left = 11
          Top = 184
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelReNewNameColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label72: TLabel
          Left = 11
          Top = 208
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelReNewNameColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label74: TLabel
          Left = 11
          Top = 232
          Width = 18
          Height = 12
          Caption = #21313':'
        end
        object LabelReNewNameColor10: TLabel
          Left = 88
          Top = 230
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditReNewNameColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditReNewNameColor1Change
        end
        object EditReNewNameColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditReNewNameColor2Change
        end
        object EditReNewNameColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditReNewNameColor3Change
        end
        object EditReNewNameColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditReNewNameColor4Change
        end
        object EditReNewNameColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditReNewNameColor5Change
        end
        object EditReNewNameColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditReNewNameColor6Change
        end
        object EditReNewNameColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditReNewNameColor7Change
        end
        object EditReNewNameColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditReNewNameColor8Change
        end
        object EditReNewNameColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditReNewNameColor9Change
        end
        object EditReNewNameColor10: TSpinEdit
          Left = 40
          Top = 228
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 100
          OnChange = EditReNewNameColor10Change
        end
      end
      object ButtonReNewLevelSave: TButton
        Left = 360
        Top = 157
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonReNewLevelSaveClick
      end
      object GroupBox30: TGroupBox
        Left = 128
        Top = 8
        Width = 105
        Height = 65
        Caption = #21517#23383#21464#33394
        TabOrder = 2
        object Label57: TLabel
          Left = 8
          Top = 42
          Width = 30
          Height = 12
          Caption = #38388#38548':'
        end
        object Label59: TLabel
          Left = 83
          Top = 44
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditReNewNameColorTime: TSpinEdit
          Left = 44
          Top = 39
          Width = 37
          Height = 21
          Hint = #21517#23383#21464#33394#30340#38388#38548#12290
          EditorEnabled = False
          MaxValue = 10
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditReNewNameColorTimeChange
        end
        object CheckBoxReNewChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = #25171#24320#27492#21151#33021#21518#65292#36716#29983#30340#20154#29289#30340#21517#23383#39068#33394#20250#33258#21160#21464#21270#12290
          Caption = #33258#21160#21464#33394
          TabOrder = 1
          OnClick = CheckBoxReNewChangeColorClick
        end
      end
      object GroupBox33: TGroupBox
        Left = 128
        Top = 80
        Width = 105
        Height = 41
        Caption = #36716#29983#25511#21046
        TabOrder = 3
        object CheckBoxReNewLevelClearExp: TCheckBox
          Left = 8
          Top = 16
          Width = 89
          Height = 17
          Hint = #36716#29983#26102#26159#21542#28165#38500#24050#32463#26377#30340#32463#39564#20540#12290
          Caption = #28165#38500#24050#26377#32463#39564
          TabOrder = 0
          OnClick = CheckBoxReNewLevelClearExpClick
        end
      end
    end
    object TabSheet39: TTabSheet
      Caption = #23453#23453#21319#32423
      ImageIndex = 10
      object ButtonMonUpgradeSave: TButton
        Left = 357
        Top = 269
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonMonUpgradeSaveClick
      end
      object GroupBox32: TGroupBox
        Left = 8
        Top = 8
        Width = 113
        Height = 233
        Caption = #31561#32423#39068#33394
        TabOrder = 1
        object Label65: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object LabelMonUpgradeColor1: TLabel
          Left = 88
          Top = 14
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label67: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object LabelMonUpgradeColor2: TLabel
          Left = 88
          Top = 38
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label69: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object LabelMonUpgradeColor3: TLabel
          Left = 88
          Top = 62
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label71: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object LabelMonUpgradeColor4: TLabel
          Left = 88
          Top = 86
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label73: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object LabelMonUpgradeColor5: TLabel
          Left = 88
          Top = 110
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label75: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object LabelMonUpgradeColor6: TLabel
          Left = 88
          Top = 134
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label76: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object LabelMonUpgradeColor7: TLabel
          Left = 88
          Top = 158
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label77: TLabel
          Left = 11
          Top = 184
          Width = 18
          Height = 12
          Caption = #20843':'
        end
        object LabelMonUpgradeColor8: TLabel
          Left = 88
          Top = 182
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label86: TLabel
          Left = 11
          Top = 208
          Width = 18
          Height = 12
          Caption = #20061':'
        end
        object LabelMonUpgradeColor9: TLabel
          Left = 88
          Top = 206
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object EditMonUpgradeColor1: TSpinEdit
          Left = 40
          Top = 12
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeColor1Change
        end
        object EditMonUpgradeColor2: TSpinEdit
          Left = 40
          Top = 36
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeColor2Change
        end
        object EditMonUpgradeColor3: TSpinEdit
          Left = 40
          Top = 60
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeColor3Change
        end
        object EditMonUpgradeColor4: TSpinEdit
          Left = 40
          Top = 84
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeColor4Change
        end
        object EditMonUpgradeColor5: TSpinEdit
          Left = 40
          Top = 108
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeColor5Change
        end
        object EditMonUpgradeColor6: TSpinEdit
          Left = 40
          Top = 132
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeColor6Change
        end
        object EditMonUpgradeColor7: TSpinEdit
          Left = 40
          Top = 156
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeColor7Change
        end
        object EditMonUpgradeColor8: TSpinEdit
          Left = 40
          Top = 180
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpgradeColor8Change
        end
        object EditMonUpgradeColor9: TSpinEdit
          Left = 40
          Top = 204
          Width = 41
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpgradeColor9Change
        end
      end
      object GroupBox31: TGroupBox
        Left = 128
        Top = 8
        Width = 97
        Height = 233
        Caption = #21319#32423#26432#24618#25968
        TabOrder = 2
        object Label61: TLabel
          Left = 11
          Top = 16
          Width = 18
          Height = 12
          Caption = #19968':'
        end
        object Label63: TLabel
          Left = 11
          Top = 40
          Width = 18
          Height = 12
          Caption = #20108':'
        end
        object Label78: TLabel
          Left = 11
          Top = 64
          Width = 18
          Height = 12
          Caption = #19977':'
        end
        object Label79: TLabel
          Left = 11
          Top = 88
          Width = 18
          Height = 12
          Caption = #22235':'
        end
        object Label80: TLabel
          Left = 11
          Top = 112
          Width = 18
          Height = 12
          Caption = #20116':'
        end
        object Label81: TLabel
          Left = 11
          Top = 136
          Width = 18
          Height = 12
          Caption = #20845':'
        end
        object Label82: TLabel
          Left = 11
          Top = 160
          Width = 18
          Height = 12
          Caption = #19971':'
        end
        object Label83: TLabel
          Left = 11
          Top = 184
          Width = 30
          Height = 12
          Caption = #22522#25968':'
        end
        object Label84: TLabel
          Left = 11
          Top = 208
          Width = 30
          Height = 12
          Caption = #20493#29575':'
        end
        object EditMonUpgradeKillCount1: TSpinEdit
          Left = 40
          Top = 12
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditMonUpgradeKillCount1Change
        end
        object EditMonUpgradeKillCount2: TSpinEdit
          Left = 40
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMonUpgradeKillCount2Change
        end
        object EditMonUpgradeKillCount3: TSpinEdit
          Left = 40
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMonUpgradeKillCount3Change
        end
        object EditMonUpgradeKillCount4: TSpinEdit
          Left = 40
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMonUpgradeKillCount4Change
        end
        object EditMonUpgradeKillCount5: TSpinEdit
          Left = 40
          Top = 108
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 4
          Value = 100
          OnChange = EditMonUpgradeKillCount5Change
        end
        object EditMonUpgradeKillCount6: TSpinEdit
          Left = 40
          Top = 132
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 5
          Value = 100
          OnChange = EditMonUpgradeKillCount6Change
        end
        object EditMonUpgradeKillCount7: TSpinEdit
          Left = 40
          Top = 156
          Width = 49
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 6
          Value = 100
          OnChange = EditMonUpgradeKillCount7Change
        end
        object EditMonUpLvNeedKillBase: TSpinEdit
          Left = 40
          Top = 180
          Width = 49
          Height = 21
          Hint = #26432#24618#25968#37327'='#31561#32423' * '#20493#29575' + '#31561#32423' + '#22522#25968' + '#27599#32423#25968#37327
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 7
          Value = 100
          OnChange = EditMonUpLvNeedKillBaseChange
        end
        object EditMonUpLvRate: TSpinEdit
          Left = 40
          Top = 204
          Width = 49
          Height = 21
          Hint = #26432#24618#25968#37327'='#24618#29289#31561#32423' * '#20493#29575' + '#31561#32423' + '#22522#25968' + '#27599#32423#25968#37327
          EditorEnabled = False
          Increment = 10
          MaxValue = 9999
          MinValue = 0
          TabOrder = 8
          Value = 100
          OnChange = EditMonUpLvRateChange
        end
      end
      object GroupBox35: TGroupBox
        Left = 232
        Top = 8
        Width = 137
        Height = 126
        Caption = #20027#20154#27515#20129#25511#21046
        TabOrder = 3
        object Label88: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #21464#24322#26426#29575':'
        end
        object Label90: TLabel
          Left = 11
          Top = 64
          Width = 54
          Height = 12
          Caption = #22686#21152#25915#20987':'
        end
        object Label92: TLabel
          Left = 11
          Top = 88
          Width = 54
          Height = 12
          Caption = #22686#21152#36895#24230':'
        end
        object CheckBoxMasterDieMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #20027#20154#27515#20129#21518#21464#24322
          TabOrder = 0
          OnClick = CheckBoxMasterDieMutinyClick
        end
        object EditMasterDieMutinyRate: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#24322#26426#29575#36234#22823#12290
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditMasterDieMutinyRateChange
        end
        object EditMasterDieMutinyPower: TSpinEdit
          Left = 72
          Top = 60
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 2
          Value = 100
          OnChange = EditMasterDieMutinyPowerChange
        end
        object EditMasterDieMutinySpeed: TSpinEdit
          Left = 72
          Top = 84
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 3
          Value = 100
          OnChange = EditMasterDieMutinySpeedChange
        end
        object CheckBoxHeroMutinyDie: TCheckBox
          Left = 7
          Top = 106
          Width = 113
          Height = 17
          Caption = #23453#23453#21464#24322#27515#20129
          TabOrder = 4
          OnClick = CheckBoxHeroMutinyDieClick
        end
      end
      object GroupBox47: TGroupBox
        Left = 8
        Top = 245
        Width = 137
        Height = 62
        Caption = #19971#24425#23453#23453
        TabOrder = 4
        object Label112: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #26102#38388#38388#38548':'
        end
        object CheckBoxBBMonAutoChangeColor: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #23453#23453#33258#21160#21464#33394
          TabOrder = 0
          OnClick = CheckBoxBBMonAutoChangeColorClick
        end
        object EditBBMonAutoChangeColorTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          Hint = #25968#23383#36234#23567#65292#21464#33394#36895#24230#36234#24555#65292#21333#20301'('#31186')'#12290
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = EditBBMonAutoChangeColorTimeChange
        end
      end
      object GroupBox254: TGroupBox
        Left = 232
        Top = 201
        Width = 137
        Height = 62
        Caption = #23456#29289#24555#20048#24230#25511#21046
        TabOrder = 5
        object Label656: TLabel
          Left = 11
          Top = 17
          Width = 54
          Height = 12
          Caption = #27599#26085#33021#20943':'
        end
        object Label657: TLabel
          Left = 10
          Top = 39
          Width = 54
          Height = 12
          Caption = #27599#26085#33021#21152':'
        end
        object PetsMonDecMaxHapp: TSpinEdit
          Left = 71
          Top = 13
          Width = 49
          Height = 21
          Hint = #27599#21482#23456#29289#27599#22825#33021#20943#23569#30340#24555#20048#24230#20540
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 100
          OnChange = PetsMonDecMaxHappChange
        end
        object PetsMonIncMaxHapp: TSpinEdit
          Left = 73
          Top = 38
          Width = 49
          Height = 21
          Hint = #27599#21482#23456#29289#27599#22825#33021#22686#21152#30340#24555#20048#24230#20540
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = PetsMonIncMaxHappChange
        end
      end
      object GroupBox262: TGroupBox
        Left = 232
        Top = 141
        Width = 137
        Height = 50
        TabOrder = 6
        object Label680: TLabel
          Left = 12
          Top = 24
          Width = 30
          Height = 12
          Caption = #26102#38388':'
        end
        object Label681: TLabel
          Left = 104
          Top = 23
          Width = 12
          Height = 12
          Caption = #20998
        end
        object cbMasterTimeRoyalty: TCheckBox
          Left = 7
          Top = -1
          Width = 66
          Height = 17
          Caption = #23453#23453#21467#21464
          TabOrder = 0
          OnClick = cbMasterTimeRoyaltyClick
        end
        object seMasterTimeRoyaltyTime: TSpinEdit
          Left = 49
          Top = 20
          Width = 49
          Height = 21
          Hint = #25307#20986#21518#25351#23450#26102#38388#21467#21464','#19981#21463#20960#29575#25511#21046
          MaxValue = 99999999
          MinValue = 1
          TabOrder = 1
          Value = 100
          OnChange = seMasterTimeRoyaltyTimeChange
        end
      end
    end
    object MonSaySheet: TTabSheet
      Caption = #24618#29289#35828#35805
      object GroupBox40: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 49
        Caption = #24618#29289#35828#35805
        TabOrder = 0
        object CheckBoxMonSayMsg: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #24320#21551#24618#29289#35828#35805
          TabOrder = 0
          OnClick = CheckBoxMonSayMsgClick
        end
      end
      object ButtonMonSayMsgSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonMonSayMsgSaveClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = #25216#33021#39764#27861
      ImageIndex = 1
      object MagicPageControl: TPageControl
        Left = 0
        Top = -2
        Width = 449
        Height = 292
        ActivePage = TabSheet49
        MultiLine = True
        TabOrder = 0
        object TabSheet36: TTabSheet
          Caption = #22522#26412#21442#25968
          ImageIndex = 31
          object GroupBox17: TGroupBox
            Left = 7
            Top = 8
            Width = 145
            Height = 113
            Caption = #39764#27861#25915#20987#33539#22260#38480#21046
            TabOrder = 0
            object Label12: TLabel
              Left = 8
              Top = 18
              Width = 54
              Height = 12
              Caption = #33539#22260#22823#23567':'
            end
            object Label679: TLabel
              Left = 7
              Top = 40
              Width = 54
              Height = 12
              Caption = #35823#24046#33539#22260':'
            end
            object EditMagicAttackRage: TSpinEdit
              Left = 68
              Top = 15
              Width = 53
              Height = 21
              Hint = #39764#27861#25915#20987#26377#25928#36317#31163#65292#36229#36807#25351#23450#36317#31163#25915#20987#26080#25928#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMagicAttackRageChange
            end
            object CheckBoxMagicLockTag: TCheckBox
              Left = 7
              Top = 66
              Width = 93
              Height = 17
              Hint = #39764#27861#24517#20013#30446#26631','#24320#21551#21518#39764#36947#25110#35768#20250#24456#21464#24577'.'#24910#29992#13#10#20197#21069#30340#20934#30830#36530#36991#20381#28982#26377#25928
              Caption = #39764#27861#24517#20013#30446#26631
              TabOrder = 1
              OnClick = CheckBoxMagicLockTagClick
            end
            object EditMagicAttackPassRage: TSpinEdit
              Left = 67
              Top = 37
              Width = 53
              Height = 21
              Hint = #23458#25143#31471#21457#26469#30340#30446#26631#22352#26631#21644#23454#38469#22352#26631#20043#38388#30340#35823#24046#33539#22260#13#10#22312#33539#22260#20869#21017#39764#27861#25915#20987#26377#25928#21542#21017#26080#25928#13#10#40664#35748'1'
              EditorEnabled = False
              MaxValue = 20
              MinValue = 0
              TabOrder = 2
              Value = 10
              OnChange = EditMagicAttackPassRageChange
            end
          end
          object GroupBox100: TGroupBox
            Left = 163
            Top = 8
            Width = 145
            Height = 49
            Caption = #23453#23453#35774#32622
            TabOrder = 1
            object CheckSlaveMoveMaster: TCheckBox
              Left = 8
              Top = 18
              Width = 129
              Height = 17
              Hint = #24050#25307#21484#20986#26469#30340#23453#23453','#20877#25353#24555#25463#38190','#21017#23453#23453#39134#21040#20027#20154#36523#36793
              Caption = #25307#20986#26469#30340#39134#21040#20027#20154#26049
              TabOrder = 0
              OnClick = CheckSlaveMoveMasterClick
            end
          end
        end
        object TabSheet8: TTabSheet
          Caption = #27494#22763#25216#33021
          ImageIndex = 24
          object PageControl1: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 265
            ActivePage = TabSheet9
            Align = alClient
            TabOrder = 0
            object TabSheet9: TTabSheet
              Caption = #21050#26432#21073#26415
              object GroupBox9: TGroupBox
                Left = 9
                Top = 9
                Width = 113
                Height = 41
                Caption = #26080#38480#21050#26432
                TabOrder = 0
                object CheckBoxLimitSwordLong: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23558#26816#26597#26816#26597#38548#20301#26159#21542#26377#35282#33394#23384#22312#65292#20197#31105#27490#20992#20992#21050#26432#12290
                  Caption = #31105#27490#26080#38480#21050#26432
                  TabOrder = 0
                  OnClick = CheckBoxLimitSwordLongClick
                end
              end
              object GroupBox10: TGroupBox
                Left = 8
                Top = 56
                Width = 129
                Height = 41
                Caption = #25915#20987#21147#20493#25968
                TabOrder = 1
                object Label4: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #20493#25968':'
                end
                object Label10: TLabel
                  Left = 96
                  Top = 20
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditSwordLongPowerRate: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 45
                  Height = 21
                  Hint = #25915#20987#21147#20493#25968#65292#25968#23383#22823#23567' '#38500#20197' 100'#20026#23454#38469#20493#25968#12290
                  EditorEnabled = False
                  MaxValue = 1000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSwordLongPowerRateChange
                end
              end
              object CheckBoxLimitSwordLongNG: TCheckBox
                Left = 16
                Top = 102
                Width = 109
                Height = 17
                Hint = #25171#24320#27492#21151#33021#21518#65292#23558#19981#20250#32771#34385#20869#21151#31561#32423#25152#22686#21152#30340#25915#38450#12290
                Caption = #26080#35270#20869#21151#22240#32032
                TabOrder = 2
                OnClick = CheckBoxLimitSwordLongNGClick
              end
            end
            object TabSheet10: TTabSheet
              Caption = #24443#22320#38025
              ImageIndex = 1
              object GroupBox56: TGroupBox
                Left = 8
                Top = 8
                Width = 185
                Height = 57
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label119: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label120: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditSkill39Sec: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkill39SecChange
                end
              end
              object GroupBox57: TGroupBox
                Left = 200
                Top = 8
                Width = 185
                Height = 57
                Caption = #20801#35768'PK'
                TabOrder = 1
                object CheckBoxDedingAllowPK: TCheckBox
                  Left = 16
                  Top = 24
                  Width = 97
                  Height = 17
                  Caption = #20801#35768'PK'
                  TabOrder = 0
                  OnClick = CheckBoxDedingAllowPKClick
                end
              end
              object GroupBox52: TGroupBox
                Left = 8
                Top = 71
                Width = 185
                Height = 56
                Caption = #25216#33021#21442#25968
                TabOrder = 2
                object Label135: TLabel
                  Left = 8
                  Top = 26
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditDidingPowerRate: TSpinEdit
                  Left = 96
                  Top = 22
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnClick = SpinEditDidingPowerRateClick
                end
              end
            end
            object TabSheet23: TTabSheet
              Caption = #29422#23376#21564
              ImageIndex = 2
              object GroupBox48: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 65
                Caption = #23545#20154#29289#26377#25928
                TabOrder = 0
                object CheckBoxGroupMbAttackPlayObject: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23601#21487#20197#40635#30201#20154#29289
                  Caption = #20801#35768#40635#30201#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxGroupMbAttackPlayObjectClick
                end
                object CheckBoxGroupMbAttackPlayMon: TCheckBox
                  Left = 8
                  Top = 40
                  Width = 100
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#23601#21487#20197#40635#30201#20154#24418#24618
                  Caption = #20801#35768#40635#30201#20154#24418#24618
                  TabOrder = 1
                  OnClick = CheckBoxGroupMbAttackPlayMonClick
                end
              end
              object GroupBox54: TGroupBox
                Left = 128
                Top = 8
                Width = 121
                Height = 41
                Caption = #23545#23453#23453#26377#25928
                TabOrder = 1
                object CheckBoxGroupMbAttackSlave: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 97
                  Height = 17
                  Caption = #20801#35768#40635#30201#23453#23453
                  TabOrder = 0
                  OnClick = CheckBoxGroupMbAttackSlaveClick
                end
              end
            end
            object TabSheet24: TTabSheet
              Caption = #25810#40857#25163
              ImageIndex = 3
              object GroupBox50: TGroupBox
                Left = 8
                Top = 8
                Width = 154
                Height = 65
                Caption = #26159#21542#21487#20197#25235#20154#29289
                TabOrder = 0
                object CheckBoxPullPlayObject: TCheckBox
                  Left = 16
                  Top = 16
                  Width = 89
                  Height = 17
                  Caption = #20801#35768#25235#20154#29289
                  TabOrder = 0
                  OnClick = CheckBoxPullPlayObjectClick
                end
                object CheckBoxPullCrossInSafeZone: TCheckBox
                  Left = 16
                  Top = 40
                  Width = 121
                  Height = 17
                  Caption = #31105#27490#25235#23433#20840#21306#20154#29289
                  TabOrder = 1
                  OnClick = CheckBoxPullCrossInSafeZoneClick
                end
              end
              object GroupBox246: TGroupBox
                Left = 6
                Top = 81
                Width = 156
                Height = 48
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 1
                object Label616: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label617: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditKill55UseTime: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditKill55UseTimeChange
                end
              end
            end
            object TabSheet27: TTabSheet
              Caption = #24320#22825#26025
              ImageIndex = 4
              object GroupBox71: TGroupBox
                Left = 8
                Top = 8
                Width = 153
                Height = 57
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label144: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label145: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditKill43Sec: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditKill43SecChange
                end
              end
              object GroupBox74: TGroupBox
                Left = 8
                Top = 72
                Width = 153
                Height = 67
                Caption = #37325#20987#35774#32622
                TabOrder = 1
                object Label151: TLabel
                  Left = 8
                  Top = 21
                  Width = 60
                  Height = 12
                  Caption = #37325#20987#20960#29575#65306
                end
                object Label152: TLabel
                  Left = 8
                  Top = 45
                  Width = 60
                  Height = 12
                  Caption = #25915#20987#20493#25968#65306
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clRed
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Spin43KillHitRateEdt: TSpinEdit
                  Left = 68
                  Top = 16
                  Width = 53
                  Height = 21
                  Hint = #25968#23383#36234#23567#65292#37325#20987#27425#25968#36234#22810#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 6
                  OnChange = Spin43KillHitRateEdtChange
                end
                object Spin43KillAttackRateEdt: TSpinEdit
                  Left = 68
                  Top = 41
                  Width = 53
                  Height = 21
                  Hint = #22914#26222#36890#25915#20987#21147#20026'10,'#35774#32622#20540#20026'200'#65292#21017#23454#38469#30340#25915#20987#21147'=10*200/100=20'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 2
                  OnChange = Spin43KillAttackRateEdtChange
                end
              end
              object GroupBox75: TGroupBox
                Left = 176
                Top = 8
                Width = 161
                Height = 56
                Caption = #25915#20987#21147
                TabOrder = 2
                object Label153: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditAttackRate_43: TSpinEdit
                  Left = 74
                  Top = 20
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditAttackRate_43Change
                end
              end
            end
            object TabSheet5: TTabSheet
              Caption = #40857#24433#21073#27861
              ImageIndex = 5
              object GroupBox76: TGroupBox
                Left = 8
                Top = 4
                Width = 161
                Height = 47
                Caption = #25915#20987#21147
                TabOrder = 0
                object Label154: TLabel
                  Left = 10
                  Top = 21
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditAttackRate_42: TSpinEdit
                  Left = 74
                  Top = 17
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditAttackRate_2Change
                end
              end
              object GroupBox77: TGroupBox
                Left = 8
                Top = 55
                Width = 161
                Height = 46
                Caption = #25915#20987#33539#22260
                TabOrder = 1
                object Label155: TLabel
                  Left = 10
                  Top = 20
                  Width = 60
                  Height = 12
                  Caption = #33539#22260#22823#23567#65306
                end
                object EditMagicAttackRage_42: TSpinEdit
                  Left = 74
                  Top = 16
                  Width = 81
                  Height = 21
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 3
                  OnChange = EditMagicAttackRage_42Change
                end
              end
              object GroupBox88: TGroupBox
                Left = 8
                Top = 104
                Width = 161
                Height = 49
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 2
                object Label171: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label173: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditKill42Sec: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditKill42SecChange
                end
              end
            end
            object TabSheet31: TTabSheet
              Caption = #36880#26085#21073#27861
              ImageIndex = 6
              object GroupBox83: TGroupBox
                Left = 8
                Top = 8
                Width = 161
                Height = 56
                Caption = #25915#20987#21147
                TabOrder = 0
                object Label165: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditAttackRate_74: TSpinEdit
                  Left = 74
                  Top = 20
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'#13#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'200'#13#23454#38469#23041#21147'=100*(200/100)=200'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = SpinEditAttackRate_74Change
                end
              end
            end
            object TabSheet52: TTabSheet
              Caption = #28872#28779#21073#27861
              ImageIndex = 7
              object GroupBox110: TGroupBox
                Left = 8
                Top = 8
                Width = 161
                Height = 56
                Caption = #25915#20987#21147
                TabOrder = 0
                object Label232: TLabel
                  Left = 10
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object SpinEditAttackRate_26: TSpinEdit
                  Left = 74
                  Top = 20
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'#13#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'200'#13#23454#38469#23041#21147'=100*(200/100)=200'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = SpinEditAttackRate_26Change
                end
              end
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = #27861#24072#25216#33021
          ImageIndex = 23
          object PageControl2: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 265
            ActivePage = TabSheet17
            Align = alClient
            TabOrder = 0
            object TabSheet12: TTabSheet
              Caption = #20912#21638#21742
              object GroupBox14: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label8: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditSnowWindRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditSnowWindRangeChange
                end
              end
            end
            object TabSheet13: TTabSheet
              Caption = #29190#35010#28779#28976
              ImageIndex = 1
              object GroupBox13: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label7: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditFireBoomRage: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditFireBoomRageChange
                end
              end
            end
            object TabSheet14: TTabSheet
              Caption = #28779#22681
              ImageIndex = 2
              object GroupBox53: TGroupBox
                Left = 167
                Top = 9
                Width = 185
                Height = 94
                Caption = #25216#33021#21442#25968
                TabOrder = 0
                object Label117: TLabel
                  Left = 8
                  Top = 20
                  Width = 84
                  Height = 12
                  Caption = #26377#25928#26102#38388#20493#25968#65306
                end
                object Label116: TLabel
                  Left = 8
                  Top = 44
                  Width = 60
                  Height = 12
                  Caption = #23041#21147#20493#25968#65306
                end
                object Label671: TLabel
                  Left = 7
                  Top = 68
                  Width = 96
                  Height = 12
                  Caption = #26377#25928#26102#38388#26368#22823#25968#65306
                end
                object SpinEditFireDelayTime: TSpinEdit
                  Left = 96
                  Top = 16
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 0
                  Value = 100
                  OnChange = SpinEditFireDelayTimeClick
                end
                object SpinEditFirePower: TSpinEdit
                  Left = 96
                  Top = 40
                  Width = 81
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#20197'100'
                  MaxValue = 10000
                  MinValue = 1
                  TabOrder = 1
                  Value = 100
                  OnChange = SpinEditFirePowerClick
                end
                object SpinEditFireMaxTime: TSpinEdit
                  Left = 95
                  Top = 64
                  Width = 81
                  Height = 21
                  Hint = #38450#27490#20986#29616#21464#24577#28779#22681#28903#19981#20572#13#10#21333#20301#31186
                  MaxValue = 100000000
                  MinValue = 1
                  TabOrder = 2
                  Value = 100
                  OnChange = SpinEditFireMaxTimeChange
                end
              end
              object GroupBox46: TGroupBox
                Left = 9
                Top = 8
                Width = 153
                Height = 93
                Caption = #24320#20851
                TabOrder = 1
                object CheckBoxFireCrossInSafeZone: TCheckBox
                  Left = 8
                  Top = 16
                  Width = 108
                  Height = 17
                  Hint = #25171#24320#27492#21151#33021#21518#65292#22312#23433#20840#21306#19981#20801#35768#25918#28779#22681#12290
                  Caption = #23433#20840#21306#31105#27490#28779#22681
                  TabOrder = 0
                  OnClick = CheckBoxFireCrossInSafeZoneClick
                end
                object CheckBoxFireChgMapExtinguish: TCheckBox
                  Left = 8
                  Top = 35
                  Width = 108
                  Height = 17
                  Hint = #20154#29289#26080#25932#27169#24335#26102#19981#28165#29702
                  Caption = #25442#22320#22270#33258#21160#28040#22833
                  TabOrder = 1
                  OnClick = CheckBoxFireChgMapExtinguishClick
                end
                object CheckBoxMagFirNoneSSMagic: TCheckBox
                  Left = 8
                  Top = 52
                  Width = 108
                  Height = 17
                  Hint = #24573#30053#24515#27861#22686#21152#30340#39764#27861
                  Caption = #24573#30053#31070#22307#39764#27861
                  TabOrder = 2
                  OnClick = CheckBoxMagFirNoneSSMagicClick
                end
              end
            end
            object TabSheet15: TTabSheet
              Caption = #22307#35328#26415
              ImageIndex = 3
              object GroupBox37: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label97: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTurnUndeadLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#22307#35328#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#22307#35328#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTurnUndeadLevelChange
                end
              end
            end
            object TabSheet16: TTabSheet
              Caption = #22320#29425#38647#20809
              ImageIndex = 4
              object GroupBox15: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label9: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditElecBlizzardRange: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditElecBlizzardRangeChange
                end
              end
            end
            object TabSheet17: TTabSheet
              Caption = #35825#24785#20043#20809
              ImageIndex = 5
              object GroupBox38: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #24618#29289#31561#32423#38480#21046
                TabOrder = 0
                object Label98: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #31561#32423':'
                end
                object EditMagTammingLevel: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #25351#23450#31561#32423#20197#19979#30340#24618#29289#25165#20250#34987#35825#24785#65292#25351#23450#31561#32423#20197#19978#30340#24618#29289#35825#24785#26080#25928#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingLevelChange
                end
              end
              object GroupBox45: TGroupBox
                Left = 128
                Top = 8
                Width = 113
                Height = 41
                Caption = #35825#24785#25968#37327
                TabOrder = 1
                object Label111: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #25968#37327':'
                end
                object EditTammingCount: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #21487#35825#24785#24618#29289#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditTammingCountChange
                end
              end
              object GroupBox39: TGroupBox
                Left = 8
                Top = 56
                Width = 113
                Height = 73
                Caption = #35825#24785#26426#29575
                TabOrder = 2
                object Label99: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#31561#32423':'
                end
                object Label100: TLabel
                  Left = 8
                  Top = 44
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#34880#37327':'
                end
                object EditMagTammingTargetLevel: TSpinEdit
                  Left = 64
                  Top = 15
                  Width = 41
                  Height = 21
                  Hint = #24618#29289#31561#32423#27604#29575#65292#27492#25968#23383#36234#23567#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMagTammingTargetLevelChange
                end
                object EditMagTammingHPRate: TSpinEdit
                  Left = 64
                  Top = 39
                  Width = 41
                  Height = 21
                  Hint = #24618#29289#34880#37327#27604#29575#65292#27492#25968#23383#36234#22823#65292#26426#29575#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 1
                  OnChange = EditMagTammingHPRateChange
                end
              end
              object GroupBox255: TGroupBox
                Left = 9
                Top = 134
                Width = 111
                Height = 40
                Caption = #24618#29289#25915#20987#31639#27861
                TabOrder = 3
                object CheckBoxMagTammingHitNew: TCheckBox
                  Left = 4
                  Top = 16
                  Width = 104
                  Height = 17
                  Caption = #25353#25216#33021#31561#32423#35745#31639
                  TabOrder = 0
                  OnClick = CheckBoxMagTammingHitNewClick
                end
              end
            end
            object TabSheet18: TTabSheet
              Caption = #28779#28976#20912
              ImageIndex = 6
              object GroupBox41: TGroupBox
                Left = 8
                Top = 8
                Width = 145
                Height = 73
                Caption = #35282#33394#31561#32423#26426#29575#35774#32622
                TabOrder = 0
                object Label101: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#26426#29575':'
                end
                object Label102: TLabel
                  Left = 8
                  Top = 42
                  Width = 54
                  Height = 12
                  Caption = #30456#24046#38480#21046':'
                end
                object EditMabMabeHitRandRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitRandRateChange
                end
                object EditMabMabeHitMinLvLimit: TSpinEdit
                  Left = 68
                  Top = 39
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#34987#25915#20987#21452#26041#30456#24046#31561#32423#21629#20013#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMabMabeHitMinLvLimitChange
                end
              end
              object GroupBox43: TGroupBox
                Left = 160
                Top = 8
                Width = 145
                Height = 49
                Caption = #40635#30201#26102#38388#21442#25968#20493#29575
                TabOrder = 1
                object Label104: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitMabeTimeRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #40635#30201#26102#38388#38271#24230#20493#29575#65292#22522#25968#19982#35282#33394#30340#39764#27861#26377#20851#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitMabeTimeRateChange
                end
              end
              object GroupBox42: TGroupBox
                Left = 8
                Top = 88
                Width = 145
                Height = 49
                Caption = #40635#30201#21629#20013#26426#29575
                TabOrder = 2
                object Label103: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #21629#20013#26426#29575':'
                end
                object EditMabMabeHitSucessRate: TSpinEdit
                  Left = 68
                  Top = 15
                  Width = 53
                  Height = 21
                  Hint = #25915#20987#40635#30201#26426#29575#65292#26368#23567#38480#21046#65292#25968#23383#36234#23567#26426#29575#36234#20302#12290
                  EditorEnabled = False
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditMabMabeHitSucessRateChange
                end
              end
            end
            object TabSheet19: TTabSheet
              Caption = #28781#22825#28779
              ImageIndex = 7
              object GroupBox51: TGroupBox
                Left = 8
                Top = 8
                Width = 121
                Height = 49
                Caption = #20943'MP'#20540
                TabOrder = 0
                object CheckBoxPlayObjectReduceMP: TCheckBox
                  Left = 16
                  Top = 16
                  Width = 97
                  Height = 17
                  Caption = #20987#20013#20943'MP'#20540
                  TabOrder = 0
                  OnClick = CheckBoxPlayObjectReduceMPClick
                end
              end
              object AutoCanHit45: TCheckBox
                Left = 24
                Top = 64
                Width = 81
                Height = 17
                Caption = #26234#33021#38145#23450' '
                TabOrder = 1
                OnClick = AutoCanHit45Click
              end
            end
            object TabSheet20: TTabSheet
              Caption = #20998#36523#26415
              ImageIndex = 8
              object GroupBox59: TGroupBox
                Left = 8
                Top = 8
                Width = 425
                Height = 145
                Caption = #21442#25968#37197#21046'(2)'
                TabOrder = 0
                object Label131: TLabel
                  Left = 16
                  Top = 24
                  Width = 84
                  Height = 12
                  Caption = #25112#22763#25915#20987#36895#24230#65306
                end
                object Label132: TLabel
                  Left = 16
                  Top = 48
                  Width = 84
                  Height = 12
                  Caption = #27861#24072#25915#20987#36895#24230#65306
                end
                object Label133: TLabel
                  Left = 16
                  Top = 72
                  Width = 84
                  Height = 12
                  Caption = #36947#22763#25915#20987#36895#24230#65306
                end
                object SpinEditWarrorAttackTime: TSpinEdit
                  Left = 104
                  Top = 20
                  Width = 121
                  Height = 21
                  Hint = #21333#20301#27627#31186
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = SpinEditWarrorAttackTimeChange
                end
                object SpinEditWizardAttackTime: TSpinEdit
                  Left = 104
                  Top = 44
                  Width = 121
                  Height = 21
                  Hint = #21333#20301#27627#31186
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = SpinEditWizardAttackTimeChange
                end
                object SpinEditTaoistAttackTime: TSpinEdit
                  Left = 104
                  Top = 68
                  Width = 121
                  Height = 21
                  Hint = #21333#20301#27627#31186
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 2
                  Value = 0
                  OnChange = SpinEditTaoistAttackTimeChange
                end
                object GroupBox61: TGroupBox
                  Left = 232
                  Top = 16
                  Width = 185
                  Height = 73
                  Caption = #21484#21796#20854#20182#32844#19994#30340#20998#36523
                  TabOrder = 3
                  object CheckBoxNeedLevelHighTarget: TCheckBox
                    Left = 8
                    Top = 48
                    Width = 145
                    Height = 17
                    Hint = #22914#26524#19981#36873#25321#65292#23601#20250#20986#29616#19968#20010#31561#32423#19981#39640#30340#29609#23478#21484#21796#19968#20010#31561#32423#24456#39640#30340#20998#36523#12290
                    Caption = #31561#32423#24517#39035#22823#20110#30446#26631#31561#32423
                    TabOrder = 0
                    OnClick = CheckBoxNeedLevelHighTargetClick
                  end
                  object CheckBoxAllowReCallMobOtherHum: TCheckBox
                    Left = 8
                    Top = 24
                    Width = 169
                    Height = 17
                    Hint = 
                      #36873#25321#36825#20010#21151#33021#21518#65292#20351#29992#20998#36523#26415#26102#65292#23601#20250#20197#40736#26631#36873#25321#30340#20154#29289#20026#23545#35937#65292#23436#20840#22797#21046#19968#20010#31561#32423#12289#32844#19994#12289#24615#21035#12289#36523#19978#35013#22791#23436#20840#21644#20320#36873#25321#30340#20154#29289#19968#27169#19968#26679#30340#20998#36523 +
                      #12290
                    Caption = #20801#35768#20197#30446#26631#20026#23545#35937#21484#21796#20998#36523
                    TabOrder = 1
                    OnClick = CheckBoxAllowReCallMobOtherHumClick
                  end
                end
                object GroupBox73: TGroupBox
                  Left = 16
                  Top = 94
                  Width = 185
                  Height = 47
                  Caption = #21484#21796#20998#36523#38388#38548
                  TabOrder = 4
                  object Label146: TLabel
                    Left = 16
                    Top = 24
                    Width = 36
                    Height = 12
                    Caption = #26102#38388#65306
                  end
                  object Label147: TLabel
                    Left = 120
                    Top = 24
                    Width = 12
                    Height = 12
                    Caption = #31186
                  end
                  object SpinEditnCopyHumanTick: TSpinEdit
                    Left = 56
                    Top = 20
                    Width = 57
                    Height = 21
                    MaxValue = 100
                    MinValue = 0
                    TabOrder = 0
                    Value = 10
                    OnChange = SpinEditnCopyHumanTickChange
                  end
                end
                object GroupBox79: TGroupBox
                  Left = 232
                  Top = 93
                  Width = 160
                  Height = 47
                  Caption = #20998#36523#20351#29992#26102#38388
                  TabOrder = 5
                  object Label159: TLabel
                    Left = 16
                    Top = 24
                    Width = 36
                    Height = 12
                    Caption = #26102#38388#65306
                  end
                  object Label160: TLabel
                    Left = 120
                    Top = 24
                    Width = 12
                    Height = 12
                    Caption = #31186
                  end
                  object SpinEditMakeSelfTick: TSpinEdit
                    Left = 56
                    Top = 20
                    Width = 57
                    Height = 21
                    Hint = #21484#21796#20998#36523#21518','#22810#23569#26102#38388#21518#33258#21160#28040#22833
                    MaxValue = 65535
                    MinValue = 0
                    TabOrder = 0
                    Value = 10
                    OnChange = SpinEditMakeSelfTickChange
                  end
                end
              end
            end
            object TabSheet21: TTabSheet
              Caption = #20998#36523#26415
              ImageIndex = 9
              object GroupBox60: TGroupBox
                Left = 8
                Top = 8
                Width = 425
                Height = 97
                Caption = #20986#29983#21518#21253#35065#20013#25918#20837#29289#21697
                TabOrder = 0
                object Label128: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #25112#22763#65306
                end
                object Label129: TLabel
                  Left = 16
                  Top = 48
                  Width = 36
                  Height = 12
                  Caption = #27861#24072#65306
                end
                object Label130: TLabel
                  Left = 16
                  Top = 72
                  Width = 36
                  Height = 12
                  Caption = #36947#22763#65306
                end
                object EditBagItems1: TEdit
                  Left = 56
                  Top = 20
                  Width = 361
                  Height = 20
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 0
                  OnChange = EditBagItems1Change
                end
                object EditBagItems2: TEdit
                  Left = 56
                  Top = 44
                  Width = 361
                  Height = 20
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 1
                  OnChange = EditBagItems2Change
                end
                object EditBagItems3: TEdit
                  Left = 56
                  Top = 68
                  Width = 361
                  Height = 20
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 2
                  OnChange = EditBagItems3Change
                end
              end
            end
            object TabSheet22: TTabSheet
              Caption = #20998#36523#26415
              ImageIndex = 10
              object GroupBox58: TGroupBox
                Left = 8
                Top = 8
                Width = 425
                Height = 161
                Caption = #21442#25968#37197#21046'(1)'
                TabOrder = 0
                object Label121: TLabel
                  Left = 16
                  Top = 24
                  Width = 84
                  Height = 12
                  Caption = #20801#35768#20998#36523#25968#37327#65306
                end
                object Label122: TLabel
                  Left = 16
                  Top = 48
                  Width = 60
                  Height = 12
                  Caption = #20998#36523#21517#31216#65306
                end
                object Label123: TLabel
                  Left = 16
                  Top = 72
                  Width = 132
                  Height = 12
                  Caption = #20801#35768#21253#34993#20013#25441#33647#21697#25968#37327#65306
                end
                object Label124: TLabel
                  Left = 16
                  Top = 96
                  Width = 108
                  Height = 12
                  Caption = #34880#20540#20302#20110#24635#34880#20540#30340#65306
                end
                object Label125: TLabel
                  Left = 16
                  Top = 120
                  Width = 132
                  Height = 12
                  Caption = #39764#27861#20540#20302#20110#24635#39764#27861#20540#30340#65306
                end
                object Label126: TLabel
                  Left = 248
                  Top = 96
                  Width = 72
                  Height = 12
                  Caption = '% '#26102#24320#22987#21507#33647
                end
                object Label127: TLabel
                  Left = 248
                  Top = 120
                  Width = 72
                  Height = 12
                  Caption = '% '#26102#24320#22987#21507#33647
                end
                object Label161: TLabel
                  Left = 289
                  Top = 24
                  Width = 54
                  Height = 12
                  Caption = #21517#23383#39068#33394':'
                end
                object LabelCopyHumNameColor: TLabel
                  Left = 387
                  Top = 21
                  Width = 9
                  Height = 17
                  AutoSize = False
                  Color = clBackground
                  ParentColor = False
                end
                object SpinEditAllowCopyCount: TSpinEdit
                  Left = 144
                  Top = 20
                  Width = 121
                  Height = 21
                  Hint = #20801#35768#20998#36523#30340#25968#37327
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = SpinEditAllowCopyCountChange
                end
                object EditCopyHumName: TEdit
                  Left = 144
                  Top = 44
                  Width = 121
                  Height = 20
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 1
                  OnChange = EditCopyHumNameChange
                end
                object CheckBoxMasterName: TCheckBox
                  Left = 272
                  Top = 44
                  Width = 137
                  Height = 17
                  Caption = #20351#29992#20027#20154#21517#31216#20570#21069#32512
                  TabOrder = 2
                  OnClick = CheckBoxMasterNameClick
                end
                object SpinEditPickUpItemCount: TSpinEdit
                  Left = 144
                  Top = 68
                  Width = 121
                  Height = 21
                  Hint = 
                    #20998#36523#21487#20197#25441#21462#33647#29289#30340#25968#37327#65292#20998#36523#25441#21040#33647#29289#65292#21253#35065#20013#27809#26377#36229#36807#35774#23450#30340#25968#20540#26102#65292#25165#20250#25918#21040#33258#24049#21253#35065#20013#12290#25441#21040#20854#20182#29289#21697#65292#25110#32773#21253#35065#24050#32463#36229#36807#35774#23450#30340#25968#20540#26102 +
                    #65292#30452#25509#25918#21040#20027#20154#30340#21253#35065#20013#12290
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 3
                  Value = 0
                  OnChange = SpinEditPickUpItemCountChange
                end
                object SpinEditEatHPItemRate: TSpinEdit
                  Left = 144
                  Top = 92
                  Width = 97
                  Height = 21
                  MaxValue = 100
                  MinValue = 1
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 4
                  Value = 60
                  OnChange = SpinEditEatHPItemRateChange
                end
                object SpinEditEatMPItemRate: TSpinEdit
                  Left = 144
                  Top = 116
                  Width = 97
                  Height = 21
                  MaxValue = 100
                  MinValue = 1
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 5
                  Value = 60
                  OnChange = SpinEditEatMPItemRateChange
                end
                object CheckBoxAllowGuardAttack: TCheckBox
                  Left = 272
                  Top = 72
                  Width = 121
                  Height = 17
                  Caption = #20801#35768#22823#20992#25915#20987#20998#36523
                  TabOrder = 6
                  OnClick = CheckBoxAllowGuardAttackClick
                end
                object EditCopyHumNameColor: TSpinEdit
                  Left = 343
                  Top = 19
                  Width = 43
                  Height = 21
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 0
                  TabOrder = 7
                  Value = 100
                  OnChange = EditCopyHumNameColorChange
                end
                object CheckBoxAttackMasterTarget: TCheckBox
                  Left = 16
                  Top = 140
                  Width = 137
                  Height = 17
                  Caption = #19982#20027#20154#25915#20987#21516#19968#30446#26631
                  TabOrder = 8
                  OnClick = CheckBoxAttackMasterTargetClick
                end
              end
            end
            object TabSheet29: TTabSheet
              Caption = #27969#26143#28779#38632
              ImageIndex = 11
              object GroupBox81: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 41
                Caption = #25915#20987#33539#22260
                TabOrder = 0
                object Label162: TLabel
                  Left = 8
                  Top = 20
                  Width = 30
                  Height = 12
                  Caption = #33539#22260':'
                end
                object EditMeteorFireRainRage: TSpinEdit
                  Left = 44
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditMeteorFireRainRageChange
                end
              end
            end
            object TabSheet48: TTabSheet
              Caption = #39764#27861#30462
              ImageIndex = 12
              object GroupBox104: TGroupBox
                Left = 8
                Top = 6
                Width = 120
                Height = 67
                Caption = #39764#27861#30462#25928#26524
                TabOrder = 0
                object RadioboSkill31EffectFalse: TRadioButton
                  Left = 24
                  Top = 17
                  Width = 76
                  Height = 17
                  Caption = #30427#22823#25928#26524
                  TabOrder = 0
                  OnClick = RadioboSkill31EffectFalseClick
                end
                object RadioboSkill31EffectTrue: TRadioButton
                  Left = 24
                  Top = 40
                  Width = 78
                  Height = 17
                  Caption = #29305#33394#25928#26524
                  Enabled = False
                  TabOrder = 1
                  OnClick = RadioboSkill31EffectTrueClick
                end
              end
              object GroupBox105: TGroupBox
                Left = 8
                Top = 80
                Width = 121
                Height = 53
                Caption = #22235#32423#30462#25269#24481#20260#23475
                TabOrder = 1
                object Label222: TLabel
                  Left = 10
                  Top = 24
                  Width = 96
                  Height = 12
                  Caption = #20260#23475#65306'         %'
                end
                object SpinEditSkill66Rate: TSpinEdit
                  Left = 50
                  Top = 20
                  Width = 43
                  Height = 21
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 75
                  OnChange = SpinEditSkill66RateChange
                end
              end
              object GroupBox114: TGroupBox
                Left = 8
                Top = 140
                Width = 121
                Height = 53
                Caption = #26222#36890#30462#25269#24481#20260#23475
                TabOrder = 2
                object Label237: TLabel
                  Left = 10
                  Top = 24
                  Width = 96
                  Height = 12
                  Caption = #20260#23475#65306'         %'
                end
                object SpinEditOrdinarySkill66Rate: TSpinEdit
                  Left = 50
                  Top = 20
                  Width = 43
                  Height = 21
                  Hint = #22914#35774#32622#20026'15%,'#21017'0'#32423#39764#27861#30462#25269#24481'15%,1'#32423'-30%,2'#32423'-45%,3'#32423'-60%'
                  MaxValue = 20
                  MinValue = 1
                  TabOrder = 0
                  Value = 15
                  OnChange = SpinEditOrdinarySkill66RateChange
                end
              end
            end
          end
        end
        object TabSheet25: TTabSheet
          Caption = #36947#22763#25216#33021
          ImageIndex = 11
          object PageControl3: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 265
            ActivePage = TabSheet26
            Align = alClient
            TabOrder = 0
            object TabSheet26: TTabSheet
              Caption = #21484#21796#39607#39621
              object GroupBox5: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label2: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label3: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditBoneFammName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 0
                  OnChange = EditBoneFammNameChange
                end
                object EditBoneFammCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditBoneFammCountChange
                end
              end
              object GroupBox6: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridBoneFamm: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet3: TTabSheet
              Caption = #21484#21796#31070#20861
              ImageIndex = 1
              object GroupBox11: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label5: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label6: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditDogzName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 0
                  OnChange = EditDogzNameChange
                end
                object EditDogzCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditDogzCountChange
                end
              end
              object GroupBox12: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridDogz: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = #26045#27602#26415
              ImageIndex = 2
              object GroupBox16: TGroupBox
                Left = 8
                Top = 8
                Width = 137
                Height = 81
                Caption = #27602#33647#38477#28857
                TabOrder = 0
                object Label11: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #28857#25968#25511#21046':'
                end
                object Label672: TLabel
                  Left = 8
                  Top = 43
                  Width = 54
                  Height = 12
                  Caption = #26368#22823#26102#38271':'
                end
                object EditAmyOunsulPoint: TSpinEdit
                  Left = 68
                  Top = 17
                  Width = 53
                  Height = 21
                  Hint = #20013#27602#21518#25351#23450#26102#38388#20869#38477#28857#25968#65292#23454#38469#28857#25968#36319#25216#33021#31561#32423#21450#26412#36523#36947#26415#39640#20302#26377#20851#65292#27492#21442#25968#21482#26159#35843#20854#20013#31639#27861#21442#25968#65292#27492#25968#23383#36234#23567#65292#28857#25968#36234#22823#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditAmyOunsulPointChange
                end
                object EditMaxMakePosionTime: TSpinEdit
                  Left = 68
                  Top = 40
                  Width = 66
                  Height = 21
                  Hint = #20013#27602#25928#26524#26368#22823#26102#38271','#21333#20301#31186
                  EditorEnabled = False
                  MaxValue = 36000
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditMaxMakePosionTimeChange
                end
              end
            end
            object TabSheet6: TTabSheet
              Caption = #28789#39746#28779#31526
              ImageIndex = 3
              object GroupBox80: TGroupBox
                Left = 8
                Top = 8
                Width = 113
                Height = 57
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object AutoCanHit: TCheckBox
                  Left = 16
                  Top = 24
                  Width = 81
                  Height = 17
                  Hint = #28779#31526#12289#28779#29699#26234#33021#38145#23450#24320#20851#65288#30446#26631#31227#21160#36895#24230#36739#24555#65292#24320#21551#21151#33021#21518'100%'#25171#20013#30446#26631')'
                  Caption = #26234#33021#38145#23450' '
                  TabOrder = 0
                  OnClick = AutoCanHitClick
                end
              end
            end
            object TabSheet7: TTabSheet
              Caption = #21484#21796#26376#28789
              ImageIndex = 4
              object GroupBox64: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label134: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label136: TLabel
                  Left = 8
                  Top = 62
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object FairyNameEdt: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 0
                  OnChange = FairyNameEdtChange
                end
                object SpinFairyEdt: TSpinEdit
                  Left = 60
                  Top = 59
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinFairyEdtChange
                end
                object CheckBoxFairyShareMasterMP: TCheckBox
                  Left = 5
                  Top = 86
                  Width = 92
                  Height = 17
                  Caption = #19982#20027#20307#20849#29992#34013
                  TabOrder = 2
                  OnClick = CheckBoxFairyShareMasterMPClick
                end
                object CheckBoxFairyUseDBHitTime: TCheckBox
                  Left = 6
                  Top = 107
                  Width = 114
                  Height = 17
                  Hint = #26376#28789#28779#28789#21516#19968#21442#25968','#21551#29992#21518#65292#30452#25509#25353'DB'#37324#30340#25915#20987#36895#24230#65292#19981#20351#29992#31561#32423#36827#34892#35745#31639#25915#20987#36895#24230
                  Caption = #25353'DB'#35774#23450#25915#20987#36895#24230
                  TabOrder = 3
                  OnClick = CheckBoxFairyUseDBHitTimeClick
                end
              end
              object GroupBox65: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridFairy: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridFairySetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
              object GroupBox115: TGroupBox
                Left = 0
                Top = 138
                Width = 212
                Height = 81
                Caption = #37325#20987#35774#32622
                TabOrder = 2
                object Label137: TLabel
                  Left = 5
                  Top = 39
                  Width = 150
                  Height = 12
                  Caption = '('#31561#32423#39640#20110#30446#26631#26102')'#37325#20987#20960#29575':'
                end
                object Label138: TLabel
                  Left = 8
                  Top = 60
                  Width = 132
                  Height = 12
                  Caption = #25915#20987#20493#25968':         /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clRed
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label238: TLabel
                  Left = 9
                  Top = 15
                  Width = 90
                  Height = 12
                  Caption = #36731#20987#27425#25968#21518#37325#20987':'
                end
                object SpinFairyDuntRateEdt: TSpinEdit
                  Left = 155
                  Top = 36
                  Width = 53
                  Height = 21
                  Hint = #25968#23383#36234#23567#65292#37325#20987#27425#25968#36234#22810#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 6
                  OnChange = SpinFairyDuntRateEdtChange
                end
                object SpinFairyAttackRateEdt: TSpinEdit
                  Left = 62
                  Top = 56
                  Width = 53
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'#13#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'200'#13#23454#38469#23041#21147'=100*(200/100)=200'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 2
                  OnChange = SpinFairyAttackRateEdtChange
                end
                object SpinEditFairyDuntRateBelow: TSpinEdit
                  Left = 99
                  Top = 12
                  Width = 53
                  Height = 21
                  Hint = #22914#35774#32622#20540#20026'4,'#21017'0'#32423#26102',4'#27425#36731#20987#21518#20986#37325#20987';1'#32423#26102',5'#27425#36731#20987#21518#20986#37325#20987';2'#32423#26102',6'#27425#36731#20987#21518#20986#37325#20987';3-9'#32423#26102#20026'7'#27425#36731#20987#21518#20986#37325#20987
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 2
                  Value = 4
                  OnChange = SpinEditFairyDuntRateBelowChange
                end
              end
            end
            object TabSheet30: TTabSheet
              Caption = #22124#34880#26415
              ImageIndex = 5
              object GroupBox82: TGroupBox
                Left = 7
                Top = 8
                Width = 148
                Height = 56
                Caption = #21152#34880#30334#20998#27604
                TabOrder = 0
                object Label163: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #27604#20363#65306
                end
                object Label164: TLabel
                  Left = 112
                  Top = 24
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditMagFireCharmTreatment: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 49
                  Height = 21
                  Hint = #24618#29289#25481#34880','#33021#33258#24049#21152#34880#30340#30334#20998#29575','#13#21363#20540#20026'50%,'#25216#33021#20351#24618#25481'100'#34880','#20154#29289#21152'50'#34880
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditMagFireCharmTreatmentChange
                end
              end
              object GroupBox121: TGroupBox
                Left = 8
                Top = 72
                Width = 147
                Height = 41
                Caption = #22522#26412#35774#32622
                TabOrder = 1
                object AutoCanHit59: TCheckBox
                  Left = 34
                  Top = 15
                  Width = 81
                  Height = 17
                  Hint = #26234#33021#38145#23450#24320#20851#65288#30446#26631#31227#21160#36895#24230#36739#24555#65292#24320#21551#21151#33021#21518'100%'#25171#20013#30446#26631')'
                  Caption = #26234#33021#38145#23450' '
                  TabOrder = 0
                  OnClick = AutoCanHit59Click
                end
              end
            end
            object TabSheet41: TTabSheet
              Caption = #26080#26497#30495#27668
              ImageIndex = 6
              object GroupBox85: TGroupBox
                Left = 6
                Top = 5
                Width = 145
                Height = 52
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label167: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label168: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditAbilityUpTick: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 255
                  MinValue = 3
                  TabOrder = 0
                  Value = 10
                  OnChange = EditAbilityUpTickChange
                end
              end
              object GroupBox86: TGroupBox
                Left = 6
                Top = 61
                Width = 145
                Height = 76
                Caption = #25345#32493#26102#38271#35774#32622
                TabOrder = 1
                object Label169: TLabel
                  Left = 16
                  Top = 48
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label170: TLabel
                  Left = 120
                  Top = 48
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label231: TLabel
                  Left = 127
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditAbilityUpUseTime: TSpinEdit
                  Left = 56
                  Top = 44
                  Width = 57
                  Height = 21
                  Hint = #22312#21407#22522#30784#19978#22686#21152#20351#29992#26102#38388
                  Enabled = False
                  MaxValue = 255
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditAbilityUpUseTimeChange
                end
                object CheckBoxAbilityUpFixMode: TCheckBox
                  Left = 13
                  Top = 18
                  Width = 73
                  Height = 17
                  Hint = #25216#33021#26102#38271#19982#25216#33021#31561#32423#26080#20851','
                  Caption = #22266#23450#26102#38271
                  TabOrder = 1
                  OnClick = CheckBoxAbilityUpFixModeClick
                end
                object SpinEditAbilityUpFixUseTime: TSpinEdit
                  Left = 81
                  Top = 15
                  Width = 44
                  Height = 21
                  Hint = #22266#23450#20351#29992#26102#38388
                  Enabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = SpinEditAbilityUpFixUseTimeChange
                end
              end
              object CheckBoxAbilityAddMode: TCheckBox
                Left = 6
                Top = 142
                Width = 148
                Height = 17
                Caption = #21516#26102#22686#21152#19978#19979#38480#36947#26415
                TabOrder = 2
                OnClick = CheckBoxAbilityAddModeClick
              end
              object CheckBoxDecSuitItemMode: TCheckBox
                Left = 6
                Top = 160
                Width = 148
                Height = 17
                Caption = #19981#32771#34385#22871#35013#22686#21152#30340#36947#26415
                TabOrder = 3
                OnClick = CheckBoxDecSuitItemModeClick
              end
              object CheckBoxDecMag105SC: TCheckBox
                Left = 6
                Top = 179
                Width = 148
                Height = 17
                Caption = #19981#32771#34385#24515#27861#22686#21152#30340#36947#26415
                TabOrder = 4
                OnClick = CheckBoxDecMag105SCClick
              end
            end
            object TabSheet62: TTabSheet
              Caption = #21484#21796#22307#20861
              ImageIndex = 7
              object GroupBox66: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label139: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label140: TLabel
                  Left = 8
                  Top = 58
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object EditSacredName: TEdit
                  Left = 8
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 0
                  OnChange = EditSacredNameChange
                end
                object EditSacredCount: TSpinEdit
                  Left = 60
                  Top = 55
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditSacredCountChange
                end
              end
              object GroupBox69: TGroupBox
                Left = 144
                Top = 2
                Width = 289
                Height = 135
                Caption = #39640#32423#35774#32622
                TabOrder = 1
                object GridSacred: TStringGrid
                  Left = 8
                  Top = 16
                  Width = 265
                  Height = 113
                  ColCount = 4
                  DefaultRowHeight = 18
                  FixedCols = 0
                  RowCount = 11
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
                  TabOrder = 0
                  OnSetEditText = GridBoneFammSetEditText
                  ColWidths = (
                    55
                    76
                    57
                    52)
                end
              end
            end
            object TabSheet85: TTabSheet
              Caption = #21484#21796#28779#28789
              ImageIndex = 8
              object GroupBox247: TGroupBox
                Left = 5
                Top = 2
                Width = 132
                Height = 135
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label618: TLabel
                  Left = 8
                  Top = 18
                  Width = 54
                  Height = 12
                  Caption = #24618#29289#21517#31216':'
                end
                object Label619: TLabel
                  Left = 8
                  Top = 62
                  Width = 54
                  Height = 12
                  Caption = #21484#21796#25968#37327':'
                end
                object FireFairyNameEdt: TEdit
                  Left = 10
                  Top = 32
                  Width = 105
                  Height = 20
                  Hint = #35774#32622#40664#35748#21484#21796#30340#24618#29289#21517#31216#12290
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 0
                  OnChange = FireFairyNameEdtChange
                end
                object SpinFireFairyEdt: TSpinEdit
                  Left = 59
                  Top = 59
                  Width = 53
                  Height = 21
                  Hint = #35774#32622#21487#21484#21796#26368#22823#25968#37327#12290
                  EditorEnabled = False
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinFireFairyEdtChange
                end
                object CheckBoxFireFairyShareMasterMP: TCheckBox
                  Left = 5
                  Top = 86
                  Width = 92
                  Height = 17
                  Caption = #19982#20027#20307#20849#29992#34013
                  TabOrder = 2
                  OnClick = CheckBoxFireFairyShareMasterMPClick
                end
                object CheckBoxFireFairyNeglectACMAC: TCheckBox
                  Left = 5
                  Top = 103
                  Width = 120
                  Height = 17
                  Caption = #26080#35270#30446#26631#38450#24481#39764#24481
                  TabOrder = 3
                  OnClick = CheckBoxFireFairyNeglectACMACClick
                end
              end
              object GroupBox249: TGroupBox
                Left = 0
                Top = 138
                Width = 212
                Height = 81
                Caption = #37325#20987#35774#32622
                TabOrder = 1
                object Label620: TLabel
                  Left = 5
                  Top = 39
                  Width = 150
                  Height = 12
                  Caption = '('#31561#32423#39640#20110#30446#26631#26102')'#37325#20987#20960#29575':'
                end
                object Label621: TLabel
                  Left = 8
                  Top = 60
                  Width = 132
                  Height = 12
                  Caption = #25915#20987#20493#25968':         /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clRed
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label622: TLabel
                  Left = 9
                  Top = 15
                  Width = 90
                  Height = 12
                  Caption = #36731#20987#27425#25968#21518#37325#20987':'
                end
                object SpinFireFairyDuntRateEdt: TSpinEdit
                  Left = 155
                  Top = 36
                  Width = 53
                  Height = 21
                  Hint = #25968#23383#36234#23567#65292#37325#20987#27425#25968#36234#22810#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 6
                  OnChange = SpinFireFairyDuntRateEdtChange
                end
                object SpinFireFairyAttackRateEdt: TSpinEdit
                  Left = 62
                  Top = 56
                  Width = 53
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'#13#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'200'#13#23454#38469#23041#21147'=100*(200/100)=200'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 2
                  OnChange = SpinFireFairyAttackRateEdtChange
                end
                object SpinEditFireFairyDuntRateBelow: TSpinEdit
                  Left = 99
                  Top = 12
                  Width = 53
                  Height = 21
                  Hint = #22914#35774#32622#20540#20026'4,'#21017'0'#32423#26102',4'#27425#36731#20987#21518#20986#37325#20987';1'#32423#26102',5'#27425#36731#20987#21518#20986#37325#20987';2'#32423#26102',6'#27425#36731#20987#21518#20986#37325#20987';3-9'#32423#26102#20026'7'#27425#36731#20987#21518#20986#37325#20987
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 2
                  Value = 4
                  OnChange = SpinEditFireFairyDuntRateBelowChange
                end
              end
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #36890#29992#25216#33021
          ImageIndex = 5
          object PageControl4: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 265
            ActivePage = TabSheet86
            Align = alClient
            TabOrder = 0
            object TabSheet28: TTabSheet
              Caption = #25252#20307#31070#30462
              object GroupBox67: TGroupBox
                Left = 6
                Top = 68
                Width = 148
                Height = 55
                Caption = #25252#20307#20943#25915#20987#30334#20998#27604
                TabOrder = 0
                object Label141: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #27604#20363#65306
                end
                object Label142: TLabel
                  Left = 112
                  Top = 24
                  Width = 24
                  Height = 12
                  Caption = '/100'
                end
                object EditProtectionRate: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 49
                  Height = 21
                  Hint = #25252#20307#31070#30462#20943#25915#20987#30334#20998#27604
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditProtectionRateChange
                end
              end
              object GroupBox106: TGroupBox
                Left = 5
                Top = 8
                Width = 148
                Height = 55
                Caption = #29983#25928#26426#29575
                TabOrder = 1
                object Label223: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #27604#20363#65306
                end
                object Label224: TLabel
                  Left = 108
                  Top = 24
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object EditProtectionOKRate: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 49
                  Height = 21
                  Hint = #25252#20307#31070#30462#29983#25928#30340#26426#29575','#22914#35774#32622'10%,'#13#10#21017#26377'10%'#30340#26426#29575#21487#20197#25269#24481#20260#23475#13#10#25216#33021#27599#21319#19968#32423#22686#21152'3%'#30340#29983#25928#26426#29575
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = EditProtectionOKRateChange
                end
              end
            end
            object TabSheet43: TTabSheet
              Caption = #31227#34892#25442#20301
              ImageIndex = 1
              object GroupBox87: TGroupBox
                Left = 7
                Top = 8
                Width = 148
                Height = 46
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label172: TLabel
                  Left = 16
                  Top = 19
                  Width = 60
                  Height = 12
                  Caption = #20351#29992#38388#38548#65306
                end
                object Label174: TLabel
                  Left = 129
                  Top = 20
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditMagChangXY: TSpinEdit
                  Left = 80
                  Top = 15
                  Width = 48
                  Height = 21
                  Hint = #31227#34892#25442#20301#20351#29992#38388#38548
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = SpinEditMagChangXYChange
                end
              end
            end
            object TabSheet46: TTabSheet
              Caption = #37202#27668#25252#20307
              ImageIndex = 2
              object GroupBox94: TGroupBox
                Left = 182
                Top = 6
                Width = 145
                Height = 52
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label191: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label192: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditHPUpTick: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditHPUpTickChange
                end
              end
              object GroupBox95: TGroupBox
                Left = 182
                Top = 61
                Width = 145
                Height = 52
                Caption = #25345#32493#26102#38388#22686#21152
                TabOrder = 1
                object Label193: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label194: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditHPUpUseTime: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  Hint = #22312#21407#22522#30784#19978#22686#21152#20351#29992#26102#38388
                  MaxValue = 255
                  MinValue = 0
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditHPUpUseTimeChange
                end
              end
              object GroupBox96: TGroupBox
                Left = 6
                Top = 5
                Width = 166
                Height = 193
                Caption = #21319#32423#32463#39564
                TabOrder = 2
                object GridSkill68: TStringGrid
                  Left = 6
                  Top = 15
                  Width = 153
                  Height = 171
                  ColCount = 2
                  DefaultRowHeight = 18
                  RowCount = 101
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
                  TabOrder = 0
                  OnEnter = GridSkill68Enter
                  ColWidths = (
                    64
                    67)
                  RowHeights = (
                    18
                    18
                    19
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18)
                end
              end
              object GroupBox98: TGroupBox
                Left = 182
                Top = 118
                Width = 146
                Height = 52
                Caption = #25216#33021#22833#25928#35774#32622
                TabOrder = 3
                object Label197: TLabel
                  Left = 8
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #37202#37327#20302#20110#65306
                end
                object Label198: TLabel
                  Left = 117
                  Top = 24
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object SpinEditMinDrinkValue68: TSpinEdit
                  Left = 64
                  Top = 20
                  Width = 50
                  Height = 21
                  Hint = #24403#37202#37327#20302#20110' '#24635#37202#37327'* '#35774#32622#20540'/100 '#26102','#25216#33021#26080#27861#20351#29992
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 5
                  OnChange = SpinEditMinDrinkValue68Change
                end
              end
            end
            object TabSheet47: TTabSheet
              Caption = #20808#22825#20803#21147
              ImageIndex = 3
              object GroupBox97: TGroupBox
                Left = 14
                Top = 6
                Width = 163
                Height = 52
                Caption = #25216#33021#22833#25928#35774#32622
                TabOrder = 0
                object Label195: TLabel
                  Left = 8
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #37202#37327#20302#20110#65306
                end
                object Label196: TLabel
                  Left = 128
                  Top = 24
                  Width = 6
                  Height = 12
                  Caption = '%'
                end
                object SpinEditMinDrinkValue67: TSpinEdit
                  Left = 64
                  Top = 20
                  Width = 57
                  Height = 21
                  Hint = #24403#37202#37327#20302#20110' '#24635#37202#37327'* '#35774#32622#20540'/100 '#26102','#25216#33021#22833#25928
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 5
                  OnChange = SpinEditMinDrinkValue67Change
                end
              end
            end
            object TabSheet65: TTabSheet
              Caption = #26007#36716#26143#31227
              ImageIndex = 4
              object GroupBox70: TGroupBox
                Left = 162
                Top = 6
                Width = 271
                Height = 218
                Caption = #22522#26412#35774#32622
                TabOrder = 0
                object Label531: TLabel
                  Left = 151
                  Top = 19
                  Width = 60
                  Height = 12
                  Caption = #31934#20803#20540#19978#38480
                end
                object Label556: TLabel
                  Left = 156
                  Top = 66
                  Width = 48
                  Height = 12
                  Caption = #28860#27668#37329#24065
                end
                object Label557: TLabel
                  Left = 156
                  Top = 84
                  Width = 48
                  Height = 12
                  Caption = #28860#27668#28789#31526
                end
                object Label310: TLabel
                  Left = 152
                  Top = 115
                  Width = 72
                  Height = 12
                  Caption = #33258#21160#20462#28860#32463#39564
                end
                object Label311: TLabel
                  Left = 151
                  Top = 39
                  Width = 72
                  Height = 12
                  Caption = #22686#21152#31934#20803#38388#38548
                end
                object Label312: TLabel
                  Left = 156
                  Top = 142
                  Width = 60
                  Height = 12
                  Caption = #24674#22797#26007#36716#20540
                end
                object Label313: TLabel
                  Left = 151
                  Top = 197
                  Width = 114
                  Height = 12
                  Caption = #27599'       '#32423#20943#25915#20987'1%'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clRed
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object EditJingYuanValue: TSpinEdit
                  Left = 210
                  Top = 13
                  Width = 57
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1000
                  TabOrder = 0
                  Value = 1000
                  OnChange = EditJingYuanValueChange
                end
                object GroupBox78: TGroupBox
                  Left = 3
                  Top = 9
                  Width = 147
                  Height = 71
                  Caption = #25112#22763
                  TabOrder = 1
                  object Label143: TLabel
                    Left = 4
                    Top = 12
                    Width = 72
                    Height = 12
                    Caption = #29983#25928#20260#23475#20540#65306
                  end
                  object Label294: TLabel
                    Left = 10
                    Top = 32
                    Width = 60
                    Height = 12
                    Caption = #29983#25928#26426#29575#65306
                  end
                  object Label157: TLabel
                    Left = 5
                    Top = 51
                    Width = 138
                    Height = 12
                    Caption = #29983#25928#20943#25915#20987'         /100'
                  end
                  object EditSkill95EffectPowerWarror: TSpinEdit
                    Left = 74
                    Top = 8
                    Width = 60
                    Height = 21
                    Hint = #26007#36716#26143#31227#29983#25928#30340#20260#23475#20540','#22914#35774#32622'100,'#13#10#21017#24403#21463#21040#30340#20260#23475#20540#36798#21040'100'#26102','#25216#33021#29983#25928
                    MaxValue = 65535
                    MinValue = 0
                    TabOrder = 0
                    Value = 0
                    OnChange = EditSkill95EffectPowerWarrorChange
                  end
                  object EditSkill95EffectRateWarror: TSpinEdit
                    Left = 74
                    Top = 27
                    Width = 60
                    Height = 21
                    Hint = #24403#21463#21040#30340#20260#23475#20540#36798#21040#29983#25928#20260#23475#20540#26102','#25216#33021#19968#23450#26426#29575#29983#25928#13#10#20540#36234#23567#26426#29575#36234#39640
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 1
                    Value = 1
                    OnChange = EditSkill95EffectRateWarrorChange
                  end
                  object EditSkill95DecInjuryWarror: TSpinEdit
                    Left = 67
                    Top = 47
                    Width = 49
                    Height = 21
                    Hint = #26007#36716#26143#31227#20943#25915#20987#30334#20998#27604
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 2
                    Value = 1
                    OnChange = EditSkill95DecInjuryWarrorChange
                  end
                end
                object GroupBox222: TGroupBox
                  Left = 3
                  Top = 79
                  Width = 147
                  Height = 70
                  Caption = #27861#24072
                  TabOrder = 2
                  object Label532: TLabel
                    Left = 4
                    Top = 12
                    Width = 72
                    Height = 12
                    Caption = #29983#25928#20260#23475#20540#65306
                  end
                  object Label533: TLabel
                    Left = 10
                    Top = 33
                    Width = 60
                    Height = 12
                    Caption = #29983#25928#26426#29575#65306
                  end
                  object Label534: TLabel
                    Left = 5
                    Top = 50
                    Width = 138
                    Height = 12
                    Caption = #29983#25928#20943#25915#20987'         /100'
                  end
                  object Skill95EffectPowerWizard: TSpinEdit
                    Left = 74
                    Top = 8
                    Width = 60
                    Height = 21
                    Hint = #26007#36716#26143#31227#29983#25928#30340#20260#23475#20540','#22914#35774#32622'100,'#13#10#21017#24403#21463#21040#30340#20260#23475#20540#36798#21040'100'#26102','#25216#33021#29983#25928
                    MaxValue = 65535
                    MinValue = 0
                    TabOrder = 0
                    Value = 0
                    OnChange = Skill95EffectPowerWizardChange
                  end
                  object Skill95EffectRateWizard: TSpinEdit
                    Left = 74
                    Top = 27
                    Width = 60
                    Height = 21
                    Hint = #24403#21463#21040#30340#20260#23475#20540#36798#21040#29983#25928#20260#23475#20540#26102','#25216#33021#19968#23450#26426#29575#29983#25928#13#10#20540#36234#23567#26426#29575#36234#39640
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 1
                    Value = 1
                    OnChange = Skill95EffectRateWizardChange
                  end
                  object Skill95DecInjuryWizard: TSpinEdit
                    Left = 67
                    Top = 47
                    Width = 49
                    Height = 21
                    Hint = #26007#36716#26143#31227#20943#25915#20987#30334#20998#27604
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 2
                    Value = 1
                    OnChange = Skill95DecInjuryWizardChange
                  end
                end
                object GroupBox223: TGroupBox
                  Left = 2
                  Top = 149
                  Width = 147
                  Height = 68
                  Caption = #36947#22763
                  TabOrder = 3
                  object Label535: TLabel
                    Left = 4
                    Top = 11
                    Width = 72
                    Height = 12
                    Caption = #29983#25928#20260#23475#20540#65306
                  end
                  object Label554: TLabel
                    Left = 10
                    Top = 31
                    Width = 60
                    Height = 12
                    Caption = #29983#25928#26426#29575#65306
                  end
                  object Label555: TLabel
                    Left = 6
                    Top = 50
                    Width = 138
                    Height = 12
                    Caption = #29983#25928#20943#25915#20987'         /100'
                  end
                  object Skill95EffectPowerTaoist: TSpinEdit
                    Left = 74
                    Top = 7
                    Width = 60
                    Height = 21
                    Hint = #26007#36716#26143#31227#29983#25928#30340#20260#23475#20540','#22914#35774#32622'100,'#13#10#21017#24403#21463#21040#30340#20260#23475#20540#36798#21040'100'#26102','#25216#33021#29983#25928
                    MaxValue = 65535
                    MinValue = 0
                    TabOrder = 0
                    Value = 0
                    OnChange = Skill95EffectPowerTaoistChange
                  end
                  object Skill95EffectRateTaoist: TSpinEdit
                    Left = 74
                    Top = 25
                    Width = 60
                    Height = 21
                    Hint = #24403#21463#21040#30340#20260#23475#20540#36798#21040#29983#25928#20260#23475#20540#26102','#25216#33021#19968#23450#26426#29575#29983#25928#13#10#20540#36234#23567#26426#29575#36234#39640
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 1
                    Value = 1
                    OnChange = Skill95EffectRateTaoistChange
                  end
                  object Skill95DecInjuryTaoist: TSpinEdit
                    Left = 70
                    Top = 44
                    Width = 49
                    Height = 21
                    Hint = #26007#36716#26143#31227#20943#25915#20987#30334#20998#27604
                    MaxValue = 100
                    MinValue = 1
                    TabOrder = 2
                    Value = 1
                    OnChange = Skill95DecInjuryTaoistChange
                  end
                end
                object LianqiGold: TSpinEdit
                  Left = 208
                  Top = 61
                  Width = 57
                  Height = 21
                  Hint = #27599#27425#32451#27668#25152#38656#30340#37329#24065#25968
                  MaxValue = 200000000
                  MinValue = 1
                  TabOrder = 4
                  Value = 1000
                  OnChange = LianqiGoldChange
                end
                object LianqiGameGird: TSpinEdit
                  Left = 208
                  Top = 81
                  Width = 57
                  Height = 21
                  Hint = #24378#21270#32451#27668#25152#38656#30340#28789#31526#25968
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 5
                  Value = 1
                  OnChange = LianqiGameGirdChange
                end
                object SpinEditAutoExpSkill95: TSpinEdit
                  Left = 223
                  Top = 111
                  Width = 42
                  Height = 21
                  Hint = #20351#29992#28789#31526#33258#21160#20462#28860#26102','#27599#27425#21487#22686#21152#30340#32463#39564','#21333#20301#20026#19975','#13#10#21363#35774#32622'1'#26102','#28216#25103#20013#27599#27425#20462#28860#24471'10000'#26007#36716#26143#31227#20462#28860#28857
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 6
                  Value = 1
                  OnChange = SpinEditAutoExpSkill95Change
                end
                object SpinEditIncJingYuanValueTime: TSpinEdit
                  Left = 223
                  Top = 34
                  Width = 46
                  Height = 21
                  Hint = #22686#21152#31934#20803#20540#30340#38388#38548','#21333#20301#31186','#27599#27425#22686#21152'100'#28857';'#13#10#25346#26426#19981#22686#21152#31934#20803#20540','#20026'0'#21017#19981#22686#21152
                  MaxValue = 65535
                  MinValue = 0
                  TabOrder = 7
                  Value = 1000
                  OnChange = SpinEditIncJingYuanValueTimeChange
                end
                object EditIncTransferValue: TSpinEdit
                  Left = 215
                  Top = 137
                  Width = 54
                  Height = 21
                  Hint = #24674#22797#26007#36716#20540#30340#38388#38548','#21333#20301#27627#31186
                  MaxValue = 2000000000
                  MinValue = 1
                  TabOrder = 8
                  Value = 1000
                  OnChange = EditIncTransferValueChange
                end
                object Skill95LevelDecInjury: TSpinEdit
                  Left = 164
                  Top = 193
                  Width = 42
                  Height = 21
                  Hint = #25216#33021#31561#32423#27599#22686#21152'X'#32423#26102','#20943#21560#25915#20987#27604#20363#22686#21152'1%,'#13#10#19981#20351#29992#21017#35774#32622'0'#32423#21363#21487
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clRed
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  MaxValue = 64
                  MinValue = 0
                  ParentFont = False
                  TabOrder = 9
                  Value = 10
                  OnChange = Skill95LevelDecInjuryChange
                end
              end
              object GroupBox136: TGroupBox
                Left = 0
                Top = 1
                Width = 161
                Height = 223
                Caption = #21319#32423#20462#28860#28857
                TabOrder = 1
                object GridSkill95: TStringGrid
                  Left = 6
                  Top = 17
                  Width = 153
                  Height = 197
                  ColCount = 2
                  DefaultRowHeight = 18
                  RowCount = 100
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
                  TabOrder = 0
                  OnEnter = GridSkill95Enter
                  ColWidths = (
                    64
                    67)
                  RowHeights = (
                    18
                    18
                    19
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18)
                end
              end
            end
            object TabSheet66: TTabSheet
              Caption = #34880#39748#19968#20987
              ImageIndex = 5
              object GroupBox138: TGroupBox
                Left = 5
                Top = 59
                Width = 148
                Height = 73
                Caption = #26292#20987#35774#32622
                TabOrder = 0
                object Label300: TLabel
                  Left = 9
                  Top = 24
                  Width = 54
                  Height = 12
                  Caption = #26426'    '#29575':'
                end
                object Label303: TLabel
                  Left = 9
                  Top = 48
                  Width = 132
                  Height = 12
                  Caption = #26292#20987#20493#25968':         /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object EditBloodSoulRate: TSpinEdit
                  Left = 62
                  Top = 18
                  Width = 53
                  Height = 21
                  Hint = #25968#23383#36234#23567#65292#26292#20987#27425#25968#36234#22810#12290
                  EditorEnabled = False
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 6
                  OnChange = EditBloodSoulRateChange
                end
                object EditBloodSoulHitRate: TSpinEdit
                  Left = 61
                  Top = 44
                  Width = 53
                  Height = 21
                  Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'#13#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'200'#13#23454#38469#23041#21147'=100*(200/100)=200'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 2
                  OnChange = EditBloodSoulHitRateChange
                end
              end
              object GroupBox139: TGroupBox
                Left = 5
                Top = 8
                Width = 148
                Height = 49
                Caption = #26102#38388#25511#21046
                TabOrder = 1
                object Label301: TLabel
                  Left = 8
                  Top = 21
                  Width = 60
                  Height = 12
                  Caption = #20351#29992#38388#38548#65306
                end
                object Label302: TLabel
                  Left = 121
                  Top = 22
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditUseBloodSoul: TSpinEdit
                  Left = 72
                  Top = 17
                  Width = 48
                  Height = 21
                  Hint = #25216#33021#20351#29992#38388#38548
                  MaxValue = 65535
                  MinValue = 5
                  TabOrder = 0
                  Value = 5
                  OnChange = EditUseBloodSoulChange
                end
              end
              object GroupBox140: TGroupBox
                Left = 5
                Top = 136
                Width = 148
                Height = 49
                Caption = #33258#36523#20943#34880#35774#32622
                TabOrder = 2
                object Label304: TLabel
                  Left = 4
                  Top = 21
                  Width = 138
                  Height = 12
                  Caption = #26080#20869#21147#26102#20943#34880':         %'
                end
                object EditNotGNDecHPRate: TSpinEdit
                  Left = 85
                  Top = 17
                  Width = 48
                  Height = 21
                  Hint = #24403#26080#20869#21147#20540#26102','#20943#23569#33258#36523'HP,'#37322#25918#25216#33021
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 5
                  OnChange = EditNotGNDecHPRateChange
                end
              end
              object GroupBox141: TGroupBox
                Left = 168
                Top = 8
                Width = 129
                Height = 69
                Caption = #25915#20987#33539#22260
                TabOrder = 3
                object Label96: TLabel
                  Left = 8
                  Top = 20
                  Width = 54
                  Height = 12
                  Caption = #33539#22260'('#27861'):'
                end
                object Label305: TLabel
                  Left = 8
                  Top = 44
                  Width = 54
                  Height = 12
                  Caption = #33539#22260'('#36947'):'
                end
                object SpinEditExplosion_97Range: TSpinEdit
                  Left = 60
                  Top = 15
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290'0-'#34920#31034#21333#20307#21463#25915#20987
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 0
                  TabOrder = 0
                  Value = 1
                  OnChange = SpinEditExplosion_97RangeChange
                end
                object SpinEditExplosion_98Range: TSpinEdit
                  Left = 60
                  Top = 39
                  Width = 61
                  Height = 21
                  Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290'0-'#34920#31034#21333#20307#21463#25915#20987
                  EditorEnabled = False
                  MaxValue = 12
                  MinValue = 0
                  TabOrder = 1
                  Value = 1
                  OnChange = SpinEditExplosion_98RangeChange
                end
              end
              object CheckBoxAttackFFT_96: TCheckBox
                Left = 6
                Top = 190
                Width = 131
                Height = 15
                Hint = 
                  #21363'100'#32423#25171'200'#32423#30446#26631#26102','#23041#21147#31639#27861'('#22522#26412#23041#21147'+'#22522#26412#23041#21147'*'#31561#32423#24046'*0.05),'#31561#32423#24046#26368#39640#38480'50,'#21363'2.5'#20493#23041#21147#13#10#33509#19981#36873#25321','#21017#23041 +
                  #21147#31639#27861#20026'('#22522#26412#23041#21147'+'#22522#26412#23041#21147'*0.05)'
                Caption = #20351#29992#31561#32423#24046#35745#31639#23041#21147
                ParentShowHint = False
                ShowHint = True
                TabOrder = 4
                OnClick = CheckBoxAttackFFT_96Click
              end
            end
            object TabSheet86: TTabSheet
              Caption = #21484#21796#24040#39764
              ImageIndex = 6
              object GroupBox253: TGroupBox
                Left = 10
                Top = 3
                Width = 143
                Height = 69
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label630: TLabel
                  Left = 4
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #20351#29992#38388#38548#65306
                end
                object Label631: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label632: TLabel
                  Left = 4
                  Top = 46
                  Width = 126
                  Height = 12
                  Caption = #23384#27963#26102#38271#65306'         '#31186
                end
                object EditDoCallTroll: TSpinEdit
                  Left = 62
                  Top = 19
                  Width = 57
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditDoCallTrollChange
                end
                object EditDoCallTrollTime: TSpinEdit
                  Left = 62
                  Top = 41
                  Width = 57
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = EditDoCallTrollTimeChange
                end
              end
            end
          end
        end
        object TabSheet49: TTabSheet
          Caption = #20869#21151#25216#33021
          ImageIndex = 5
          object PageControl5: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 265
            ActivePage = TabSheet91
            Align = alClient
            TabOrder = 0
            object TabSheet51: TTabSheet
              Caption = #22522#26412#21442#25968
              object GroupBox107: TGroupBox
                Left = 10
                Top = 1
                Width = 180
                Height = 126
                Caption = #30456#20851#21442#25968
                TabOrder = 0
                object Label225: TLabel
                  Left = 24
                  Top = 12
                  Width = 72
                  Height = 12
                  Caption = #20869#21147#20540#21442#25968#65306
                end
                object Label226: TLabel
                  Left = 12
                  Top = 31
                  Width = 90
                  Height = 12
                  Caption = #20027#20307#32463#39564#21442#25968'1'#65306
                end
                object Label227: TLabel
                  Left = 11
                  Top = 51
                  Width = 90
                  Height = 12
                  Caption = #33521#38596#32463#39564#21442#25968'1'#65306
                end
                object Label278: TLabel
                  Left = 12
                  Top = 70
                  Width = 90
                  Height = 12
                  Caption = #20027#20307#32463#39564#21442#25968'2'#65306
                end
                object Label279: TLabel
                  Left = 12
                  Top = 89
                  Width = 90
                  Height = 12
                  Caption = #33521#38596#32463#39564#21442#25968'2'#65306
                end
                object Label558: TLabel
                  Left = 12
                  Top = 107
                  Width = 84
                  Height = 12
                  Caption = #20869#21151#31561#32423#38480#21046#65306
                end
                object SpinEditSkill69NG: TSpinEdit
                  Left = 100
                  Top = 8
                  Width = 65
                  Height = 21
                  Hint = #20869#32622#20844#24335#35745#31639#20986#30340#20540'+'#35774#32622#20540','#21363#20026#27599#20010#31561#32423#30340#20869#21147#20540#19978#38480#13#10#27880':'#26368#22823#20869#21147#20540#19978#38480#20026'65535.'#40664#35748#20540'10'
                  MaxValue = 50
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditSkill69NGChange
                end
                object SpinEditSkill69NGExp: TSpinEdit
                  Left = 100
                  Top = 27
                  Width = 65
                  Height = 21
                  Hint = #20869#32622#20844#24335#35745#31639#20986#30340#20540'+'#35774#32622#20540','#13#10#21363#20026#27599#20010#31561#32423#30340#21319#32423#25152#38656#30340#32463#39564#13#10#40664#35748#20540':55330'
                  MaxValue = 10000000
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinEditSkill69NGExpChange
                end
                object SpinEditHeroSkill69NGExp: TSpinEdit
                  Left = 100
                  Top = 47
                  Width = 65
                  Height = 21
                  Hint = #20869#32622#20844#24335#35745#31639#20986#30340#20540'+'#35774#32622#20540','#13#10#21363#20026#27599#20010#31561#32423#30340#21319#32423#25152#38656#30340#32463#39564#13#10#40664#35748#20540':62400'
                  MaxValue = 10000000
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = SpinEditHeroSkill69NGExpChange
                end
                object SpinEditSkill69NGExp1: TSpinEdit
                  Left = 100
                  Top = 66
                  Width = 65
                  Height = 21
                  Hint = #20869#32622#20844#24335#21442#25968' '#40664#35748#20540':13940'
                  MaxValue = 10000000
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = SpinEditSkill69NGExp1Change
                end
                object SpinEditHeroSkill69NGExp1: TSpinEdit
                  Left = 100
                  Top = 85
                  Width = 65
                  Height = 21
                  Hint = #20869#32622#20844#24335#21442#25968' '#40664#35748#20540':14240'
                  MaxValue = 10000000
                  MinValue = 1
                  TabOrder = 4
                  Value = 10
                  OnChange = SpinEditHeroSkill69NGExp1Change
                end
                object SpinEditLimitExpNGLevel: TSpinEdit
                  Left = 100
                  Top = 103
                  Width = 65
                  Height = 21
                  MaxValue = 999
                  MinValue = 1
                  TabOrder = 5
                  Value = 10
                  OnChange = SpinEditLimitExpNGLevelChange
                end
              end
              object GroupBox109: TGroupBox
                Left = 10
                Top = 127
                Width = 181
                Height = 96
                Caption = #20869#21151#30456#20851
                TabOrder = 1
                object Label229: TLabel
                  Left = 5
                  Top = 16
                  Width = 72
                  Height = 12
                  Caption = #39278#37202#22686#21152#32463#39564
                end
                object Label230: TLabel
                  Left = 2
                  Top = 38
                  Width = 132
                  Height = 12
                  Caption = #22686#21152#25915#20987'('#38450#24481')'#20943#20869#21147#20540
                end
                object Label228: TLabel
                  Left = 3
                  Top = 77
                  Width = 120
                  Height = 12
                  Caption = #38548'        '#31186#21152#20869#21147#20540
                end
                object SpinEditDrinkIncNHExp: TSpinEdit
                  Left = 83
                  Top = 11
                  Width = 74
                  Height = 21
                  Hint = #39278#37202#21487#20197#33719#24471#20869#21151#32463#39564#65292#37202#37327#36234#22823#65292#39278#29992#37202#30340#21697#36136#36234#39640#65292#13#10#33719#24471#20869#21151#32463#39564#36234#22810','#26377#37257#37202#24230#26102#27599#27425#22686#21152#30340#20869#21151#32463#39564
                  MaxValue = 100000000
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditDrinkIncNHExpChange
                end
                object SpinEditHitStruckDecNH: TSpinEdit
                  Left = 135
                  Top = 33
                  Width = 42
                  Height = 21
                  Hint = #20869#21151#23545#20110#26222#36890#25915#20987#38450#25269#24481','#38656#35201#28040#32791#30340#20869#21147#20540#13#10#20869#21151#23545#20110#22686#21152#25915#20987#21147','#38656#35201#28040#32791#30340#20869#21147#20540
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinEditHitStruckDecNHChange
                end
                object CheckBoxUseNGItemIncExp: TCheckBox
                  Left = 3
                  Top = 55
                  Width = 174
                  Height = 17
                  Hint = #38543#31561#32423#30340#22686#21152#65292#19981#21516#30340#31561#32423#21487#33719#24471#39069#22806#30340#20869#21151#32463#39564
                  Caption = #29992#20869#21151#29289#21697#25353#31561#32423#21152#19968#23450#32463#39564
                  TabOrder = 2
                  OnClick = CheckBoxUseNGItemIncExpClick
                end
                object SpinEditdwIncNHTime: TSpinEdit
                  Left = 18
                  Top = 73
                  Width = 45
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 3
                  Value = 8
                  OnChange = SpinEditdwIncNHTimeChange
                end
              end
              object GroupBox111: TGroupBox
                Left = 196
                Top = 89
                Width = 163
                Height = 37
                Caption = #26432#24618#20869#21151#32463#39564
                TabOrder = 2
                object Label233: TLabel
                  Left = 27
                  Top = 16
                  Width = 114
                  Height = 12
                  Caption = #20493#29575':          /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clRed
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object EditKillMonNGExpMultiple: TSpinEdit
                  Left = 60
                  Top = 13
                  Width = 53
                  Height = 21
                  Hint = #26432#24618#25152#24471#30340#32463#39564'*'#27492#21442#25968'/100='#24471#21040#30340#20869#21151#32463#39564
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 40
                  OnChange = EditKillMonNGExpMultipleChange
                end
              end
              object GroupBox112: TGroupBox
                Left = 196
                Top = 133
                Width = 165
                Height = 40
                Hint = 
                  #27880':'#22914#27492#21442#25968#20026'0,'#21017#25353#25216#33021'DB'#26469#35745#31639#25915#38450#13#10#13#10#20869#21151#25216#33021#27599#32423#21487#22686#21152#30340#23041#21147#27604#29575','#22914#28872#28779#23041#21147#20026'100,'#13#10#23398#20064'0'#32423#24594#20043#28872#28779','#35774#32622#20540#20026 +
                  '25,'#21017#26368#21518#23041#21147#20026':100+100*25/100=125'#13#10#23398#20064'1'#32423#24594#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':100+100*50/' +
                  '100=150'#13#10#13#10#22914#23398#38745#20043#28872#28779'0'#32423','#30446#26631#23398#26377#24594#20043#28872#28779'0'#32423','#35774#32622#20540#20026'25 '#13#10#23398#20064'0'#32423#38745#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':1' +
                  '25-100*25/100=100'
                Caption = #20869#21151#25216#33021'('#20026'0'#25353'DB'#35745#31639')'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 3
                object Label235: TLabel
                  Left = 7
                  Top = 19
                  Width = 156
                  Height = 12
                  Hint = 
                    #27880':'#22914#27492#21442#25968#20026'0,'#21017#25353#25216#33021'DB'#26469#35745#31639#25915#38450#13#10#13#10#20869#21151#25216#33021#27599#32423#21487#22686#21152#30340#23041#21147#27604#29575','#22914#28872#28779#23041#21147#20026'100,'#13#10#23398#20064'0'#32423#24594#20043#28872#28779','#35774#32622#20540#20026 +
                    '25,'#21017#26368#21518#23041#21147#20026':100+100*25/100=125'#13#10#23398#20064'1'#32423#24594#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':100+100*50/' +
                    '100=150'#13#10#13#10#22914#23398#38745#20043#28872#28779'0'#32423','#30446#26631#23398#26377#24594#20043#28872#28779'0'#32423','#35774#32622#20540#20026'25 '#13#10#23398#20064'0'#32423#38745#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':1' +
                    '25-100*25/100=100'
                  Caption = #22686#24378#25915'('#38450')'#65306'          /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clRed
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = True
                end
                object SpinEditNGSkillRate: TSpinEdit
                  Left = 79
                  Top = 15
                  Width = 55
                  Height = 21
                  Hint = 
                    #27880':'#22914#27492#21442#25968#20026'0,'#21017#25353#25216#33021'DB'#26469#35745#31639#25915#38450#13#10#13#10#20869#21151#25216#33021#27599#32423#21487#22686#21152#30340#23041#21147#27604#29575','#22914#28872#28779#23041#21147#20026'100,'#13#10#23398#20064'0'#32423#24594#20043#28872#28779','#35774#32622#20540#20026 +
                    '25,'#21017#26368#21518#23041#21147#20026':100+100*25/100=125'#13#10#23398#20064'1'#32423#24594#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':100+100*50/' +
                    '100=150'#13#10#13#10#22914#23398#38745#20043#28872#28779'0'#32423','#30446#26631#23398#26377#24594#20043#28872#28779'0'#32423','#35774#32622#20540#20026'25 '#13#10#23398#20064'0'#32423#38745#20043#28872#28779','#35774#32622#20540#20026'25,'#21017#26368#21518#23041#21147#20026':1' +
                    '25-100*25/100=100'
                  MaxValue = 10000
                  MinValue = 0
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 0
                  Value = 25
                  OnChange = SpinEditNGSkillRateChange
                end
              end
              object GroupBox108: TGroupBox
                Left = 196
                Top = 2
                Width = 221
                Height = 84
                Caption = #20869#21151#31561#32423'+'#25915#38450
                TabOrder = 4
                object Label287: TLabel
                  Left = 7
                  Top = 20
                  Width = 210
                  Height = 12
                  Caption = #25112#22763#27599'       '#32423'+1'#25915' '#27599'       '#32423'+1'#38450
                end
                object Label288: TLabel
                  Left = 7
                  Top = 42
                  Width = 210
                  Height = 12
                  Caption = #27861#24072#27599'       '#32423'+1'#25915' '#27599'       '#32423'+1'#38450
                end
                object Label306: TLabel
                  Left = 7
                  Top = 64
                  Width = 210
                  Height = 12
                  Caption = #36947#22763#27599'       '#32423'+1'#25915' '#27599'       '#32423'+1'#38450
                end
                object SpinEditWarrNGLevelIncDC: TSpinEdit
                  Left = 42
                  Top = 16
                  Width = 42
                  Height = 21
                  Hint = #25112#22763#20869#21151#40664#35748#27599'7'#32423#22686#21152#19968#28857#20260#23475
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditWarrNGLevelIncDCChange
                end
                object SpinEditWarrNGLevelIncAC: TSpinEdit
                  Left = 138
                  Top = 16
                  Width = 42
                  Height = 21
                  Hint = #25112#22763#20869#21151#40664#35748#27599'11'#32423#20943#20813#19968#28857#20260#23475
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinEditWarrNGLevelIncACChange
                end
                object SpinEditWizardNGLevelIncDC: TSpinEdit
                  Left = 42
                  Top = 38
                  Width = 42
                  Height = 21
                  Hint = #27861#24072#20869#21151#40664#35748#27599'8'#32423#22686#21152#19968#28857#20260#23475
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = SpinEditWizardNGLevelIncDCChange
                end
                object SpinEditWizardNGLevelIncAC: TSpinEdit
                  Left = 138
                  Top = 38
                  Width = 42
                  Height = 21
                  Hint = #27861#24072#20869#21151#40664#35748#27599'14'#32423#20943#20813#19968#28857#20260#23475
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = SpinEditWizardNGLevelIncACChange
                end
                object SpinEditTaosNGLevelIncDC: TSpinEdit
                  Left = 42
                  Top = 60
                  Width = 42
                  Height = 21
                  Hint = #36947#22763#20869#21151#40664#35748#27599'8'#32423#22686#21152#19968#28857#20260#23475
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 4
                  Value = 10
                  OnChange = SpinEditTaosNGLevelIncDCChange
                end
                object SpinEditTaosNGLevelIncAC: TSpinEdit
                  Left = 138
                  Top = 60
                  Width = 42
                  Height = 21
                  Hint = #36947#22763#20869#21151#40664#35748#27599'14'#32423#20943#20813#19968#28857#20260#23475
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 5
                  Value = 10
                  OnChange = SpinEditTaosNGLevelIncACChange
                end
              end
            end
            object TabSheet61: TTabSheet
              Caption = #20506#22825#36767#22320
              ImageIndex = 1
              object GroupBox113: TGroupBox
                Left = 8
                Top = 8
                Width = 161
                Height = 49
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label284: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label285: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditKill69Sec: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditKill69SecChange
                end
              end
            end
            object TabSheet77: TTabSheet
              Caption = #31070#40857#38468#20307
              ImageIndex = 2
              object GroupBox214: TGroupBox
                Left = 10
                Top = 4
                Width = 148
                Height = 48
                Caption = #25915#20987#21147
                TabOrder = 0
                object Label528: TLabel
                  Left = 5
                  Top = 24
                  Width = 132
                  Height = 12
                  Caption = #23041#21147#20493#25968':         /100'
                end
                object EditSkill101Point: TSpinEdit
                  Left = 57
                  Top = 19
                  Width = 55
                  Height = 21
                  Hint = #25216#33021#22686#21152#30340#26432#20260#21147#30340#20493#29575
                  MaxValue = 65535
                  MinValue = 100
                  TabOrder = 0
                  Value = 100
                  OnChange = EditSkill101PointChange
                end
              end
              object GroupBox250: TGroupBox
                Left = 9
                Top = 64
                Width = 149
                Height = 74
                Caption = #26102#38388#25511#21046
                TabOrder = 1
                object Label623: TLabel
                  Left = 7
                  Top = 24
                  Width = 60
                  Height = 12
                  Caption = #20351#29992#38388#38548#65306
                end
                object Label624: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object Label658: TLabel
                  Left = 6
                  Top = 47
                  Width = 126
                  Height = 12
                  Caption = #25345#32493#26102#38271#65306'         '#31186
                end
                object SpinEditKill101UseTime: TSpinEdit
                  Left = 62
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditKill101UseTimeChange
                end
                object SpinEditKill101UseLogTime: TSpinEdit
                  Left = 62
                  Top = 43
                  Width = 57
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinEditKill101UseLogTimeChange
                end
              end
            end
            object TabSheet81: TTabSheet
              Caption = #21807#25105#29420#23562
              ImageIndex = 3
              object GroupBox213: TGroupBox
                Left = 8
                Top = 8
                Width = 143
                Height = 49
                Caption = #20351#29992#38388#38548#26102#38388
                TabOrder = 0
                object Label526: TLabel
                  Left = 16
                  Top = 24
                  Width = 36
                  Height = 12
                  Caption = #26102#38388#65306
                end
                object Label527: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object SpinEditKill102Sec: TSpinEdit
                  Left = 56
                  Top = 20
                  Width = 57
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditKill102SecChange
                end
              end
              object GroupBox215: TGroupBox
                Left = 8
                Top = 64
                Width = 143
                Height = 49
                Caption = '3'#32423#25216#33021#25928#26524
                TabOrder = 1
                object Label529: TLabel
                  Left = 8
                  Top = 25
                  Width = 60
                  Height = 12
                  Caption = #30446#26631#20943#38450#65306
                end
                object Label530: TLabel
                  Left = 120
                  Top = 24
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditSill102TargetDecACTime: TSpinEdit
                  Left = 67
                  Top = 20
                  Width = 51
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = EditSill102TargetDecACTimeChange
                end
              end
            end
            object TabSheet87: TTabSheet
              Caption = #20869#21151#24378#21270
              ImageIndex = 4
              object PageControl10: TPageControl
                Left = 0
                Top = 0
                Width = 433
                Height = 238
                ActivePage = TabSheet89
                Align = alClient
                TabOrder = 0
                object TabSheet89: TTabSheet
                  Caption = #22522#26412#21442#25968
                  ImageIndex = 1
                  object Label633: TLabel
                    Left = 8
                    Top = 18
                    Width = 78
                    Height = 12
                    Caption = #21319#32423#25152#38656#29289#21697':'
                  end
                  object Label655: TLabel
                    Left = 4
                    Top = 46
                    Width = 102
                    Height = 12
                    Caption = #26368#39640#24378#21270#25216#33021#31561#32423':'
                  end
                  object EditNGStrongItem: TEdit
                    Left = 85
                    Top = 12
                    Width = 105
                    Height = 20
                    Hint = #24594#20043#20869#21151#25216#33021#24378#21270#25152#38656#35201#30340#29289#21697
                    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                    TabOrder = 0
                    OnChange = EditNGStrongItemChange
                  end
                  object nNGSkillMaxLevel: TSpinEdit
                    Left = 105
                    Top = 40
                    Width = 42
                    Height = 21
                    MaxValue = 30
                    MinValue = 3
                    TabOrder = 1
                    Value = 10
                    OnChange = nNGSkillMaxLevelChange
                  end
                end
                object TabSheet88: TTabSheet
                  Caption = #24594#20043#25216#33021'(1)'
                  ImageIndex = 1
                  object Label634: TLabel
                    Left = 26
                    Top = 3
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#25915#26432#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label635: TLabel
                    Left = 26
                    Top = 23
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#21322#26376#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label636: TLabel
                    Left = 2
                    Top = 42
                    Width = 366
                    Height = 12
                    Caption = #24594#20043#20869#21151#21073#27861#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label637: TLabel
                    Left = 25
                    Top = 61
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#28872#28779#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label638: TLabel
                    Left = 25
                    Top = 80
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#36880#26085#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label639: TLabel
                    Left = 26
                    Top = 99
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#26045#27602#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label640: TLabel
                    Left = 26
                    Top = 119
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#28779#31526#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label641: TLabel
                    Left = 25
                    Top = 138
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#22124#34880#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label642: TLabel
                    Left = 26
                    Top = 158
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#26376#28789#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label649: TLabel
                    Left = 14
                    Top = 178
                    Width = 354
                    Height = 12
                    Caption = #24594#20043#28781#22825#28779#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label650: TLabel
                    Left = 3
                    Top = 197
                    Width = 366
                    Height = 12
                    Caption = #24594#20043#27969#26143#28779#38632#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object SpinEditSKILL_200NGStrong1: TSpinEdit
                    Left = 122
                    Top = -1
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = SpinEditSKILL_200NGStrong1Change
                  end
                  object SpinEditSKILL_200NGStrong2: TSpinEdit
                    Left = 203
                    Top = -1
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = SpinEditSKILL_200NGStrong2Change
                  end
                  object SpinEditSKILL_200NGStrong3: TSpinEdit
                    Left = 290
                    Top = -1
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 2
                    Value = 10
                    OnChange = SpinEditSKILL_200NGStrong3Change
                  end
                  object SpinEditSKILL_200NGStrong4: TSpinEdit
                    Left = 370
                    Top = -1
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 3
                    Value = 10
                    OnChange = SpinEditSKILL_200NGStrong4Change
                  end
                  object Skill_202NGStrong1: TSpinEdit
                    Left = 122
                    Top = 19
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 4
                    Value = 10
                    OnChange = Skill_202NGStrong1Change
                  end
                  object Skill_202NGStrong2: TSpinEdit
                    Left = 203
                    Top = 20
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 5
                    Value = 10
                    OnChange = Skill_202NGStrong2Change
                  end
                  object Skill_202NGStrong3: TSpinEdit
                    Left = 290
                    Top = 18
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 6
                    Value = 10
                    OnChange = Skill_202NGStrong3Change
                  end
                  object Skill_202NGStrong4: TSpinEdit
                    Left = 370
                    Top = 18
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 7
                    Value = 10
                    OnChange = Skill_202NGStrong4Change
                  end
                  object Skill_236NGStrong1: TSpinEdit
                    Left = 122
                    Top = 38
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 8
                    Value = 10
                    OnChange = Skill_236NGStrong1Change
                  end
                  object Skill_236NGStrong2: TSpinEdit
                    Left = 203
                    Top = 38
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 9
                    Value = 10
                    OnChange = Skill_236NGStrong2Change
                  end
                  object Skill_236NGStrong3: TSpinEdit
                    Left = 290
                    Top = 37
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 10
                    Value = 10
                    OnChange = Skill_236NGStrong3Change
                  end
                  object Skill_236NGStrong4: TSpinEdit
                    Left = 370
                    Top = 37
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 11
                    Value = 10
                    OnChange = Skill_236NGStrong4Change
                  end
                  object Skill_204NGStrong1: TSpinEdit
                    Left = 122
                    Top = 57
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 12
                    Value = 10
                    OnChange = Skill_204NGStrong1Change
                  end
                  object Skill_204NGStrong2: TSpinEdit
                    Left = 203
                    Top = 57
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 13
                    Value = 10
                    OnChange = Skill_204NGStrong2Change
                  end
                  object Skill_204NGStrong3: TSpinEdit
                    Left = 290
                    Top = 56
                    Width = 43
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 14
                    Value = 10
                    OnChange = Skill_204NGStrong3Change
                  end
                  object Skill_204NGStrong4: TSpinEdit
                    Left = 370
                    Top = 56
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 15
                    Value = 10
                    OnChange = Skill_204NGStrong4Change
                  end
                  object Skill_206NGStrong1: TSpinEdit
                    Left = 122
                    Top = 76
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 16
                    Value = 10
                    OnChange = Skill_206NGStrong1Change
                  end
                  object Skill_206NGStrong2: TSpinEdit
                    Left = 203
                    Top = 76
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 17
                    Value = 10
                    OnChange = Skill_206NGStrong2Change
                  end
                  object Skill_206NGStrong3: TSpinEdit
                    Left = 290
                    Top = 75
                    Width = 43
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 18
                    Value = 10
                    OnChange = Skill_206NGStrong3Change
                  end
                  object Skill_206NGStrong4: TSpinEdit
                    Left = 370
                    Top = 75
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 19
                    Value = 10
                    OnChange = Skill_206NGStrong4Change
                  end
                  object Skill_239NGStrong1: TSpinEdit
                    Left = 122
                    Top = 95
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 20
                    Value = 10
                    OnChange = Skill_239NGStrong1Change
                  end
                  object Skill_239NGStrong2: TSpinEdit
                    Left = 203
                    Top = 95
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 21
                    Value = 10
                    OnChange = Skill_239NGStrong2Change
                  end
                  object Skill_239NGStrong3: TSpinEdit
                    Left = 290
                    Top = 94
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 22
                    Value = 10
                    OnChange = Skill_239NGStrong3Change
                  end
                  object Skill_239NGStrong4: TSpinEdit
                    Left = 370
                    Top = 94
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 23
                    Value = 10
                    OnChange = Skill_239NGStrong4Change
                  end
                  object Skill_230NGStrong4: TSpinEdit
                    Left = 370
                    Top = 114
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 24
                    Value = 10
                    OnChange = Skill_230NGStrong4Change
                  end
                  object Skill_230NGStrong3: TSpinEdit
                    Left = 290
                    Top = 114
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 25
                    Value = 10
                    OnChange = Skill_230NGStrong3Change
                  end
                  object Skill_230NGStrong2: TSpinEdit
                    Left = 203
                    Top = 115
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 26
                    Value = 10
                    OnChange = Skill_230NGStrong2Change
                  end
                  object Skill_230NGStrong1: TSpinEdit
                    Left = 122
                    Top = 115
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 27
                    Value = 10
                    OnChange = Skill_230NGStrong1Change
                  end
                  object Skill_232NGStrong1: TSpinEdit
                    Left = 122
                    Top = 134
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 28
                    Value = 10
                    OnChange = Skill_232NGStrong1Change
                  end
                  object Skill_232NGStrong2: TSpinEdit
                    Left = 203
                    Top = 134
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 29
                    Value = 10
                    OnChange = Skill_232NGStrong2Change
                  end
                  object Skill_232NGStrong3: TSpinEdit
                    Left = 290
                    Top = 133
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 30
                    Value = 10
                    OnChange = Skill_232NGStrong3Change
                  end
                  object Skill_232NGStrong4: TSpinEdit
                    Left = 370
                    Top = 133
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 31
                    Value = 10
                    OnChange = Skill_232NGStrong4Change
                  end
                  object Skill_241NGStrong4: TSpinEdit
                    Left = 370
                    Top = 153
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 32
                    Value = 10
                    OnChange = Skill_241NGStrong4Change
                  end
                  object Skill_241NGStrong3: TSpinEdit
                    Left = 291
                    Top = 153
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 33
                    Value = 10
                    OnChange = Skill_241NGStrong3Change
                  end
                  object Skill_241NGStrong2: TSpinEdit
                    Left = 204
                    Top = 154
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 34
                    Value = 10
                    OnChange = Skill_241NGStrong2Change
                  end
                  object Skill_241NGStrong1: TSpinEdit
                    Left = 122
                    Top = 154
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 35
                    Value = 10
                    OnChange = Skill_241NGStrong1Change
                  end
                  object Skill_228NGStrong1: TSpinEdit
                    Left = 122
                    Top = 174
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 36
                    Value = 10
                    OnChange = Skill_228NGStrong1Change
                  end
                  object Skill_228NGStrong2: TSpinEdit
                    Left = 204
                    Top = 174
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 37
                    Value = 10
                    OnChange = Skill_228NGStrong2Change
                  end
                  object Skill_228NGStrong3: TSpinEdit
                    Left = 291
                    Top = 173
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 38
                    Value = 10
                    OnChange = Skill_228NGStrong3Change
                  end
                  object Skill_228NGStrong4: TSpinEdit
                    Left = 370
                    Top = 173
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 39
                    Value = 10
                    OnChange = Skill_228NGStrong4Change
                  end
                  object Skill_234NGStrong4: TSpinEdit
                    Left = 371
                    Top = 193
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 40
                    Value = 10
                    OnChange = Skill_234NGStrong4Change
                  end
                  object Skill_234NGStrong3: TSpinEdit
                    Left = 291
                    Top = 193
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 41
                    Value = 10
                    OnChange = Skill_234NGStrong3Change
                  end
                  object Skill_234NGStrong2: TSpinEdit
                    Left = 204
                    Top = 194
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 42
                    Value = 10
                    OnChange = Skill_234NGStrong2Change
                  end
                  object Skill_234NGStrong1: TSpinEdit
                    Left = 122
                    Top = 194
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 43
                    Value = 10
                    OnChange = Skill_234NGStrong1Change
                  end
                end
                object TabSheet90: TTabSheet
                  Caption = #24594#20043#25216#33021'(2)'
                  ImageIndex = 2
                  object Label643: TLabel
                    Left = 26
                    Top = 4
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#28779#29699#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label644: TLabel
                    Left = 15
                    Top = 22
                    Width = 354
                    Height = 12
                    Caption = #24594#20043#22320#29425#28779#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label645: TLabel
                    Left = 3
                    Top = 41
                    Width = 366
                    Height = 12
                    Caption = #24594#20043#29190#35010#28779#28976#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label646: TLabel
                    Left = 26
                    Top = 61
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#38647#30005#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label647: TLabel
                    Left = 14
                    Top = 80
                    Width = 354
                    Height = 12
                    Caption = #24594#20043#22823#28779#29699#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label648: TLabel
                    Left = 26
                    Top = 101
                    Width = 342
                    Height = 12
                    Caption = #24594#20043#28779#22681#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label651: TLabel
                    Left = 3
                    Top = 122
                    Width = 366
                    Height = 12
                    Caption = #24594#20043#30142#20809#30005#24433#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label652: TLabel
                    Left = 3
                    Top = 141
                    Width = 366
                    Height = 12
                    Caption = #24594#20043#22320#29425#38647#20809#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label653: TLabel
                    Left = 14
                    Top = 161
                    Width = 354
                    Height = 12
                    Caption = #24594#20043#23506#20912#25484#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Label654: TLabel
                    Left = 14
                    Top = 182
                    Width = 354
                    Height = 12
                    Caption = #24594#20043#20912#21638#21742#65306#38656#20869#21151#12288#12288#12288' ,'#27599#32423'+'#12288#12288#12288'  ;'#38656#29289#21697#12288#12288'   ,'#27599#32423'+'
                  end
                  object Skill_208NGStrong0: TSpinEdit
                    Left = 122
                    Top = 0
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 0
                    Value = 10
                    OnChange = Skill_208NGStrong0Change
                  end
                  object Skill_208NGStrong1: TSpinEdit
                    Left = 203
                    Top = 0
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 1
                    Value = 10
                    OnChange = Skill_208NGStrong1Change
                  end
                  object Skill_208NGStrong2: TSpinEdit
                    Left = 290
                    Top = -1
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 2
                    Value = 10
                    OnChange = Skill_208NGStrong2Change
                  end
                  object Skill_208NGStrong3: TSpinEdit
                    Left = 369
                    Top = -1
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 3
                    Value = 10
                    OnChange = Skill_208NGStrong3Change
                  end
                  object Skill_214NGStrong3: TSpinEdit
                    Left = 369
                    Top = 17
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 4
                    Value = 10
                    OnChange = Skill_214NGStrong3Change
                  end
                  object nSkill_222NGStrong3: TSpinEdit
                    Left = 369
                    Top = 56
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 5
                    Value = 10
                    OnChange = nSkill_222NGStrong3Change
                  end
                  object nSkill_218NGStrong3: TSpinEdit
                    Left = 369
                    Top = 36
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 6
                    Value = 10
                    OnChange = nSkill_218NGStrong3Change
                  end
                  object Skill_214NGStrong2: TSpinEdit
                    Left = 290
                    Top = 17
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 7
                    Value = 10
                    OnChange = Skill_214NGStrong2Change
                  end
                  object nSkill_218NGStrong2: TSpinEdit
                    Left = 290
                    Top = 36
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 8
                    Value = 10
                    OnChange = nSkill_218NGStrong2Change
                  end
                  object nSkill_222NGStrong2: TSpinEdit
                    Left = 290
                    Top = 56
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 9
                    Value = 10
                    OnChange = nSkill_222NGStrong2Change
                  end
                  object Skill_214NGStrong1: TSpinEdit
                    Left = 203
                    Top = 18
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 10
                    Value = 10
                    OnChange = Skill_214NGStrong1Change
                  end
                  object nSkill_218NGStrong1: TSpinEdit
                    Left = 203
                    Top = 37
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 11
                    Value = 10
                    OnChange = nSkill_218NGStrong1Change
                  end
                  object nSkill_222NGStrong1: TSpinEdit
                    Left = 203
                    Top = 57
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 12
                    Value = 10
                    OnChange = nSkill_222NGStrong1Change
                  end
                  object nSkill_222NGStrong0: TSpinEdit
                    Left = 122
                    Top = 59
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 13
                    Value = 10
                    OnChange = nSkill_222NGStrong0Change
                  end
                  object nSkill_218NGStrong0: TSpinEdit
                    Left = 122
                    Top = 39
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 14
                    Value = 10
                    OnChange = nSkill_218NGStrong0Change
                  end
                  object Skill_214NGStrong0: TSpinEdit
                    Left = 122
                    Top = 18
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 15
                    Value = 10
                    OnChange = Skill_214NGStrong0Change
                  end
                  object nSkill_210NGStrong0: TSpinEdit
                    Left = 122
                    Top = 78
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 16
                    Value = 10
                    OnChange = nSkill_210NGStrong0Change
                  end
                  object nSkill_212NGStrong0: TSpinEdit
                    Left = 122
                    Top = 97
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 17
                    Value = 10
                    OnChange = nSkill_212NGStrong0Change
                  end
                  object nSkill_210NGStrong1: TSpinEdit
                    Left = 203
                    Top = 77
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 18
                    Value = 10
                    OnChange = nSkill_210NGStrong1Change
                  end
                  object nSkill_212NGStrong1: TSpinEdit
                    Left = 203
                    Top = 97
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 19
                    Value = 10
                    OnChange = nSkill_212NGStrong1Change
                  end
                  object nSkill_210NGStrong2: TSpinEdit
                    Left = 290
                    Top = 76
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 20
                    Value = 10
                    OnChange = nSkill_210NGStrong2Change
                  end
                  object nSkill_212NGStrong2: TSpinEdit
                    Left = 290
                    Top = 96
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 21
                    Value = 10
                    OnChange = nSkill_212NGStrong2Change
                  end
                  object nSkill_210NGStrong3: TSpinEdit
                    Left = 369
                    Top = 76
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 22
                    Value = 10
                    OnChange = nSkill_210NGStrong3Change
                  end
                  object nSkill_212NGStrong3: TSpinEdit
                    Left = 369
                    Top = 96
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 23
                    Value = 10
                    OnChange = nSkill_212NGStrong3Change
                  end
                  object nSkill_216NGStrong0: TSpinEdit
                    Left = 122
                    Top = 118
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 24
                    Value = 10
                    OnChange = nSkill_216NGStrong0Change
                  end
                  object nSkill_224NGStrong0: TSpinEdit
                    Left = 122
                    Top = 138
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 25
                    Value = 10
                    OnChange = nSkill_224NGStrong0Change
                  end
                  object nSkill_226NGStrong0: TSpinEdit
                    Left = 122
                    Top = 158
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 26
                    Value = 10
                    OnChange = nSkill_226NGStrong0Change
                  end
                  object nSkill_220NGStrong0: TSpinEdit
                    Left = 122
                    Top = 178
                    Width = 42
                    Height = 21
                    Hint = #24378#21270#20869#21151#25216#33021#25152#38656#30340#22522#30784#20869#21151#31561#32423#26465#20214
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 27
                    Value = 10
                    OnChange = nSkill_220NGStrong0Change
                  end
                  object nSkill_216NGStrong1: TSpinEdit
                    Left = 203
                    Top = 118
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 28
                    Value = 10
                    OnChange = nSkill_216NGStrong1Change
                  end
                  object nSkill_224NGStrong1: TSpinEdit
                    Left = 203
                    Top = 138
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 29
                    Value = 10
                    OnChange = nSkill_224NGStrong1Change
                  end
                  object nSkill_226NGStrong1: TSpinEdit
                    Left = 203
                    Top = 158
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 30
                    Value = 10
                    OnChange = nSkill_226NGStrong1Change
                  end
                  object nSkill_220NGStrong1: TSpinEdit
                    Left = 203
                    Top = 178
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 31
                    Value = 10
                    OnChange = nSkill_220NGStrong1Change
                  end
                  object nSkill_216NGStrong2: TSpinEdit
                    Left = 290
                    Top = 117
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 32
                    Value = 10
                    OnChange = nSkill_216NGStrong2Change
                  end
                  object nSkill_224NGStrong2: TSpinEdit
                    Left = 290
                    Top = 137
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 33
                    Value = 10
                    OnChange = nSkill_224NGStrong2Change
                  end
                  object nSkill_226NGStrong2: TSpinEdit
                    Left = 290
                    Top = 157
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 34
                    Value = 10
                    OnChange = nSkill_226NGStrong2Change
                  end
                  object nSkill_220NGStrong2: TSpinEdit
                    Left = 290
                    Top = 177
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 35
                    Value = 10
                    OnChange = nSkill_220NGStrong2Change
                  end
                  object nSkill_216NGStrong3: TSpinEdit
                    Left = 369
                    Top = 117
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 36
                    Value = 10
                    OnChange = nSkill_216NGStrong3Change
                  end
                  object nSkill_224NGStrong3: TSpinEdit
                    Left = 369
                    Top = 137
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 37
                    Value = 10
                    OnChange = nSkill_224NGStrong3Change
                  end
                  object nSkill_226NGStrong3: TSpinEdit
                    Left = 369
                    Top = 157
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 38
                    Value = 10
                    OnChange = nSkill_226NGStrong3Change
                  end
                  object nSkill_220NGStrong3: TSpinEdit
                    Left = 369
                    Top = 177
                    Width = 42
                    Height = 21
                    MaxValue = 255
                    MinValue = 1
                    TabOrder = 39
                    Value = 10
                    OnChange = nSkill_220NGStrong3Change
                  end
                end
              end
            end
            object TabSheet91: TTabSheet
              Caption = #40857#21355#24515#27861
              ImageIndex = 5
              object GroupBox256: TGroupBox
                Left = 1
                Top = -1
                Width = 184
                Height = 160
                Caption = #30456#20851#21442#25968
                TabOrder = 0
                object Label659: TLabel
                  Left = 8
                  Top = 37
                  Width = 84
                  Height = 12
                  Caption = #28608#27963#25152#38656#20869#21147#20540
                end
                object Label662: TLabel
                  Left = 7
                  Top = 60
                  Width = 108
                  Height = 12
                  Caption = #28608#27963#24351#23376#24515#27861#26426#29575#65306
                end
                object Label664: TLabel
                  Left = 8
                  Top = 15
                  Width = 108
                  Height = 12
                  Caption = #39046#24735#24515#27861#25152#38656#31561#32423#65306
                end
                object Label665: TLabel
                  Left = 4
                  Top = 81
                  Width = 168
                  Height = 12
                  Caption = #24515#27861#28608#27963#23646#24615#22686#21152'         /10'
                end
                object Label666: TLabel
                  Left = 3
                  Top = 102
                  Width = 174
                  Height = 12
                  Caption = #24515#27861#21387#21046#22686#21152#20260#23475'         /100'
                end
                object Label667: TLabel
                  Left = 3
                  Top = 125
                  Width = 180
                  Height = 12
                  Caption = #24515#27861#32463#39564#21560#25910#38656'          '#19975#32463#39564
                end
                object SpinEditActivHeartNH: TSpinEdit
                  Left = 96
                  Top = 33
                  Width = 65
                  Height = 21
                  Hint = #28608#27963#24515#27861#25152#38656#35201#30340#20869#21147#20540','#19981#36275#26102#21017#19981#21487#28608#27963#24515#27861
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = SpinEditActivHeartNHChange
                end
                object SpinEditActivMemberHeartRate: TSpinEdit
                  Left = 113
                  Top = 55
                  Width = 47
                  Height = 21
                  Hint = #28608#27963#22312#32447#24351#23376#24515#27861#26426#29575','#20540#36234#23567#26426#29575#36234#39640'(255'#26102#34920#31034#19981#28608#27963#24351#23376#24515#27861')'
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = SpinEditActivMemberHeartRateChange
                end
                object SpinEditSavvyHeartNeedLevel: TSpinEdit
                  Left = 106
                  Top = 10
                  Width = 65
                  Height = 21
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = SpinEditSavvyHeartNeedLevelChange
                end
                object SpinEditHeartArrValueRate: TSpinEdit
                  Left = 103
                  Top = 76
                  Width = 47
                  Height = 21
                  Hint = #35774#32622#23567#20110'10'#26102#65292#21017#23646#24615#20250#21464#23567
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = SpinEditHeartArrValueRateChange
                end
                object SpinEditHeartIncDamageRate: TSpinEdit
                  Left = 103
                  Top = 97
                  Width = 47
                  Height = 21
                  Hint = #24515#27861#31561#32423#39640#30340#20250#23545#24515#27861#31561#32423#20302#25110#32773#27809#26377#24515#27861#31561#32423#30340#36896#25104#19968#23450#30340#39069#22806#20260#23475#13#10#21482#23545#20154#29289#36215#20316#29992','#33521#38596#25110#24618#26080#25928
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 4
                  Value = 10
                  OnChange = SpinEditHeartIncDamageRateChange
                end
                object SpinEditIncHeartPointNeedExp: TSpinEdit
                  Left = 89
                  Top = 119
                  Width = 59
                  Height = 21
                  Hint = #20351#29992#28779#40857#26524#21560#24515#27861#32463#39564#26102','#38656#35201#32047#31215#32463#39564#36798#21040#35774#32622#26102','#25165#21487#20351#29992#13#10'(10000'#28857#32463#39564#21487#20197#36716#25442#25104'1'#28857#24515#27861#32463#39564')'
                  MaxValue = 500000
                  MinValue = 1
                  TabOrder = 5
                  Value = 1
                  OnChange = SpinEditIncHeartPointNeedExpChange
                end
                object CheckBoxNeedHeart: TCheckBox
                  Left = 3
                  Top = 140
                  Width = 174
                  Height = 17
                  Caption = #31070#22307#23646#24615#38656#40857#21355#29366#24577#25165#29983#25928
                  TabOrder = 6
                  OnClick = CheckBoxNeedHeartClick
                end
              end
              object GroupBox258: TGroupBox
                Left = 1
                Top = 162
                Width = 181
                Height = 74
                Caption = #20256#25215#30456#20851
                TabOrder = 1
                object Label660: TLabel
                  Left = 9
                  Top = 13
                  Width = 156
                  Height = 12
                  Caption = #20844#20849#38376#27966#26368#39640#24515#27861'        '#32423
                end
                object Label661: TLabel
                  Left = 5
                  Top = 35
                  Width = 108
                  Height = 12
                  Caption = #35302#21457#39046#24735#33050#26412#27573#26426#29575
                end
                object Label663: TLabel
                  Left = 6
                  Top = 57
                  Width = 162
                  Height = 12
                  Caption = #24515#27861#28608#27963#20351#29992#26102#38271'         '#31186
                end
                object SpinEditPublicHeartLevel: TSpinEdit
                  Left = 107
                  Top = 9
                  Width = 47
                  Height = 21
                  Hint = #20844#20849#38376#27966#26368#39640#20256#25215#24515#27861#31561#32423'('#26381#21153#22120#37325#21551#21518#26377#25928')'
                  MaxValue = 9
                  MinValue = 1
                  TabOrder = 0
                  Value = 3
                  OnChange = SpinEditPublicHeartLevelChange
                end
                object SpinEditDivisionSavvyRate: TSpinEdit
                  Left = 115
                  Top = 30
                  Width = 47
                  Height = 21
                  Hint = #25191#34892'QF'#25991#20214'@Savvy'#26426#29575#65292#20540#36234#23567#26426#29575#36234#39640
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 3
                  OnChange = SpinEditDivisionSavvyRateChange
                end
                object SpinEditMemberUseHeartTime: TSpinEdit
                  Left = 106
                  Top = 51
                  Width = 47
                  Height = 21
                  Hint = #20256#25215#24515#27861#34987#28608#27963#21518#21487#20351#29992#26102#38271'('#24072#20613#24515#27861#20572#27490#26102#24351#23376#24515#27861#20063#21516#26102#20572#27490')'
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 3
                  OnChange = SpinEditMemberUseHeartTimeChange
                end
              end
              object GroupBox257: TGroupBox
                Left = 188
                Top = 0
                Width = 171
                Height = 235
                Caption = #20256#25215#24515#27861#21319#32423#25152#38656#31561#32423
                TabOrder = 2
                object StringGridUpHeartNeedLevel: TStringGrid
                  Left = 2
                  Top = 13
                  Width = 167
                  Height = 194
                  Hint = '('#24351#23376')'#20256#25215#24515#27861#21319#32423#25152#38656#20154#29289#31561#32423#26465#20214
                  Align = alCustom
                  ColCount = 2
                  DefaultColWidth = 70
                  DefaultRowHeight = 18
                  RowCount = 10
                  Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
                  TabOrder = 0
                  OnEnter = StringGridSKILLStrongRateEnter
                  RowHeights = (
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18
                    18)
                end
                object CheckBoxNeedHeart2: TCheckBox
                  Left = 6
                  Top = 212
                  Width = 156
                  Height = 17
                  Caption = #24515#27861#25216#33021#40857#21355#29366#24577#25165#29983#25928
                  TabOrder = 1
                  OnClick = CheckBoxNeedHeart2Click
                end
              end
            end
            object TabSheet93: TTabSheet
              Caption = #24378#21270#25216#33021
              ImageIndex = 7
              object PageControl11: TPageControl
                Left = 0
                Top = 0
                Width = 433
                Height = 238
                ActivePage = TabSheet92
                Align = alClient
                TabOrder = 0
                object TabSheet92: TTabSheet
                  Caption = #24378#21270#25152#38656#24515#27861#31561#32423#35774#32622
                  ImageIndex = 1
                  object StringGridSKILLStrong: TStringGrid
                    Left = 0
                    Top = 0
                    Width = 425
                    Height = 211
                    Align = alClient
                    ColCount = 10
                    DefaultColWidth = 38
                    DefaultRowHeight = 18
                    RowCount = 23
                    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
                    TabOrder = 0
                    OnEnter = StringGridSKILLStrongEnter
                  end
                end
                object TabSheet94: TTabSheet
                  Caption = #24378#21270#25216#33021#23041#21147#35774#32622
                  ImageIndex = 1
                  object StringGridSKILLStrongRate: TStringGrid
                    Left = 0
                    Top = 0
                    Width = 194
                    Height = 211
                    Hint = #20363#22914#35774#32622#20540#20026'10%,'#21017#28216#25103#20013#65292#19968#37325#23041#21147#21017#22686#21152'10%'#13#10#20108#37325#21017#22686#21152'20%...'#20061#37325#21017#22686#21152'90%'#13#10#35774#32622#33539#22260'(1..255)'
                    ColCount = 2
                    DefaultColWidth = 92
                    DefaultRowHeight = 18
                    RowCount = 18
                    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
                    TabOrder = 0
                    OnEnter = StringGridSKILLStrongRateEnter
                    RowHeights = (
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18
                      18)
                  end
                end
              end
            end
            object TabSheet95: TTabSheet
              Caption = #40857#21355#31070#25216
              ImageIndex = 7
              object PageControl12: TPageControl
                Left = 0
                Top = 0
                Width = 433
                Height = 238
                ActivePage = TabSheet96
                Align = alClient
                TabOrder = 0
                object TabSheet96: TTabSheet
                  Caption = #20840#23616#25511#21046
                  ImageIndex = 1
                  object GroupBox259: TGroupBox
                    Left = 7
                    Top = 6
                    Width = 149
                    Height = 50
                    Caption = #26102#38388#25511#21046'('#20027#21160#25216#33021')'
                    TabOrder = 0
                    object Label668: TLabel
                      Left = 7
                      Top = 24
                      Width = 60
                      Height = 12
                      Caption = #20351#29992#38388#38548#65306
                    end
                    object Label669: TLabel
                      Left = 120
                      Top = 24
                      Width = 12
                      Height = 12
                      Caption = #31186
                    end
                    object SpinEditHeartSkilltime: TSpinEdit
                      Left = 62
                      Top = 20
                      Width = 57
                      Height = 21
                      MaxValue = 65535
                      MinValue = 1
                      TabOrder = 0
                      Value = 10
                      OnChange = SpinEditHeartSkilltimeChange
                    end
                  end
                  object GroupBox260: TGroupBox
                    Left = 5
                    Top = 67
                    Width = 149
                    Height = 46
                    Caption = #32437#27178#21073#26415#25915#20987#33539#22260
                    TabOrder = 1
                    object Label670: TLabel
                      Left = 10
                      Top = 20
                      Width = 60
                      Height = 12
                      Caption = #33539#22260#22823#23567#65306
                    end
                    object SpinEditMagicAttackRage_107: TSpinEdit
                      Left = 75
                      Top = 16
                      Width = 51
                      Height = 21
                      MaxValue = 10
                      MinValue = 1
                      TabOrder = 0
                      Value = 3
                      OnChange = SpinEditMagicAttackRage_107Change
                    end
                  end
                end
                object TabSheet97: TTabSheet
                  Caption = #22825#38647#20081#33310
                  ImageIndex = 1
                  object CheckBoxMag113LockCanFly: TCheckBox
                    Left = 7
                    Top = 14
                    Width = 103
                    Height = 17
                    Hint = #26159#21542#20801#35768#34987#31105#38178#32773#39134#31163#31105#38178#21306#22495'.'#13#10#21253#25324#13#10#36716#36724#39134#36208#13#10#30636#24687#31227#21160#13#10#22827#22971#20256#36865#31561#20256#36865'.'
                    Caption = #34987#31105#38178#20801#35768#39134#36208
                    TabOrder = 0
                    OnClick = CheckBoxMag113LockCanFlyClick
                  end
                end
              end
            end
          end
        end
        object TabSheet55: TTabSheet
          Caption = #36830#20987#25216#33021
          ImageIndex = 6
          object PageControl6: TPageControl
            Left = 0
            Top = 0
            Width = 441
            Height = 265
            ActivePage = TabSheet56
            Align = alClient
            TabOrder = 0
            object TabSheet56: TTabSheet
              Caption = #32463#32476#30456#20851
              object GroupBox122: TGroupBox
                Left = 2
                Top = 11
                Width = 100
                Height = 143
                Caption = #20914#33033'- '#20869#21151#31561#32423
                TabOrder = 0
                object Label246: TLabel
                  Left = 5
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = #24189#38376#65306
                end
                object Label247: TLabel
                  Left = 5
                  Top = 44
                  Width = 36
                  Height = 12
                  Caption = #36890#35895#65306
                end
                object Label248: TLabel
                  Left = 5
                  Top = 68
                  Width = 36
                  Height = 12
                  Caption = #21830#26354#65306
                end
                object Label249: TLabel
                  Left = 5
                  Top = 116
                  Width = 36
                  Height = 12
                  Caption = #27178#39592#65306
                end
                object Label250: TLabel
                  Left = 5
                  Top = 92
                  Width = 36
                  Height = 12
                  Caption = #22235#28385#65306
                end
                object PulsePointNGLevel0: TSpinEdit
                  Left = 45
                  Top = 16
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = PulsePointNGLevel0Change
                end
                object PulsePointNGLevel1: TSpinEdit
                  Left = 45
                  Top = 40
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = PulsePointNGLevel1Change
                end
                object PulsePointNGLevel2: TSpinEdit
                  Left = 45
                  Top = 64
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = PulsePointNGLevel2Change
                end
                object PulsePointNGLevel4: TSpinEdit
                  Left = 45
                  Top = 112
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = PulsePointNGLevel4Change
                end
                object PulsePointNGLevel3: TSpinEdit
                  Left = 45
                  Top = 88
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 4
                  Value = 10
                  OnChange = PulsePointNGLevel3Change
                end
              end
              object GroupBox123: TGroupBox
                Left = 109
                Top = 11
                Width = 100
                Height = 143
                Caption = #38452#36343'- '#20869#21151#31561#32423
                TabOrder = 1
                object Label251: TLabel
                  Left = 5
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = #26228#26126#65306
                end
                object Label252: TLabel
                  Left = 5
                  Top = 44
                  Width = 36
                  Height = 12
                  Caption = #30424#32570#65306
                end
                object Label253: TLabel
                  Left = 5
                  Top = 68
                  Width = 36
                  Height = 12
                  Caption = #20132#20449#65306
                end
                object Label254: TLabel
                  Left = 5
                  Top = 116
                  Width = 36
                  Height = 12
                  Caption = #28982#35895#65306
                end
                object Label255: TLabel
                  Left = 5
                  Top = 92
                  Width = 36
                  Height = 12
                  Caption = #29031#28023#65306
                end
                object PulsePointNGLevel5: TSpinEdit
                  Left = 45
                  Top = 16
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = PulsePointNGLevel5Change
                end
                object PulsePointNGLevel6: TSpinEdit
                  Left = 45
                  Top = 40
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = PulsePointNGLevel6Change
                end
                object PulsePointNGLevel7: TSpinEdit
                  Left = 45
                  Top = 64
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = PulsePointNGLevel7Change
                end
                object PulsePointNGLevel9: TSpinEdit
                  Left = 45
                  Top = 112
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = PulsePointNGLevel9Change
                end
                object PulsePointNGLevel8: TSpinEdit
                  Left = 45
                  Top = 88
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 4
                  Value = 10
                  OnChange = PulsePointNGLevel8Change
                end
              end
              object GroupBox124: TGroupBox
                Left = 218
                Top = 11
                Width = 101
                Height = 143
                Caption = #38452#32500'- '#20869#21151#31561#32423
                TabOrder = 2
                object Label256: TLabel
                  Left = 7
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = #24265#27849#65306
                end
                object Label257: TLabel
                  Left = 7
                  Top = 44
                  Width = 36
                  Height = 12
                  Caption = #26399#38376#65306
                end
                object Label258: TLabel
                  Left = 7
                  Top = 68
                  Width = 36
                  Height = 12
                  Caption = #24220#33293#65306
                end
                object Label259: TLabel
                  Left = 7
                  Top = 116
                  Width = 36
                  Height = 12
                  Caption = #31569#23486#65306
                end
                object Label260: TLabel
                  Left = 7
                  Top = 92
                  Width = 36
                  Height = 12
                  Caption = #20914#38376#65306
                end
                object PulsePointNGLevel10: TSpinEdit
                  Left = 47
                  Top = 16
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = PulsePointNGLevel10Change
                end
                object PulsePointNGLevel11: TSpinEdit
                  Left = 47
                  Top = 40
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = PulsePointNGLevel11Change
                end
                object PulsePointNGLevel12: TSpinEdit
                  Left = 47
                  Top = 64
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = PulsePointNGLevel12Change
                end
                object PulsePointNGLevel14: TSpinEdit
                  Left = 47
                  Top = 112
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = PulsePointNGLevel14Change
                end
                object PulsePointNGLevel13: TSpinEdit
                  Left = 47
                  Top = 88
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 4
                  Value = 10
                  OnChange = PulsePointNGLevel13Change
                end
              end
              object GroupBox125: TGroupBox
                Left = 327
                Top = 11
                Width = 101
                Height = 143
                Caption = #20219#33033'- '#20869#21151#31561#32423
                TabOrder = 3
                object Label261: TLabel
                  Left = 7
                  Top = 20
                  Width = 36
                  Height = 12
                  Caption = #25215#27974#65306
                end
                object Label262: TLabel
                  Left = 7
                  Top = 44
                  Width = 36
                  Height = 12
                  Caption = #22825#31361#65306
                end
                object Label263: TLabel
                  Left = 7
                  Top = 68
                  Width = 36
                  Height = 12
                  Caption = #40480#23614#65306
                end
                object Label264: TLabel
                  Left = 7
                  Top = 116
                  Width = 36
                  Height = 12
                  Caption = #26354#39592#65306
                end
                object Label265: TLabel
                  Left = 7
                  Top = 92
                  Width = 36
                  Height = 12
                  Caption = #27668#28023#65306
                end
                object PulsePointNGLevel15: TSpinEdit
                  Left = 47
                  Top = 16
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 0
                  Value = 10
                  OnChange = PulsePointNGLevel15Change
                end
                object PulsePointNGLevel16: TSpinEdit
                  Left = 47
                  Top = 40
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 1
                  Value = 10
                  OnChange = PulsePointNGLevel16Change
                end
                object PulsePointNGLevel17: TSpinEdit
                  Left = 47
                  Top = 64
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 2
                  Value = 10
                  OnChange = PulsePointNGLevel17Change
                end
                object PulsePointNGLevel19: TSpinEdit
                  Left = 47
                  Top = 112
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 3
                  Value = 10
                  OnChange = PulsePointNGLevel19Change
                end
                object PulsePointNGLevel18: TSpinEdit
                  Left = 47
                  Top = 88
                  Width = 49
                  Height = 21
                  MaxValue = 255
                  MinValue = 1
                  TabOrder = 4
                  Value = 10
                  OnChange = PulsePointNGLevel18Change
                end
              end
              object Button1: TButton
                Left = 344
                Top = 184
                Width = 75
                Height = 25
                Caption = #40664#35748#35774#32622
                TabOrder = 4
                OnClick = Button1Click
              end
            end
            object TabSheet57: TTabSheet
              Caption = #36830#20987#22522#26412#21442#25968
              ImageIndex = 1
              object GroupBox126: TGroupBox
                Left = 7
                Top = 8
                Width = 154
                Height = 49
                Caption = #26102#38388#25511#21046
                TabOrder = 0
                object Label267: TLabel
                  Left = 8
                  Top = 21
                  Width = 60
                  Height = 12
                  Caption = #20351#29992#38388#38548#65306
                end
                object Label269: TLabel
                  Left = 121
                  Top = 22
                  Width = 12
                  Height = 12
                  Caption = #31186
                end
                object EditUseBatterTick: TSpinEdit
                  Left = 72
                  Top = 17
                  Width = 48
                  Height = 21
                  Hint = #36830#20987#25216#33021#20351#29992#38388#38548
                  MaxValue = 65535
                  MinValue = 5
                  TabOrder = 0
                  Value = 5
                  OnChange = EditUseBatterTickChange
                end
              end
              object GroupBox127: TGroupBox
                Left = 170
                Top = 71
                Width = 170
                Height = 139
                Caption = #26292#20987#20260#23475#20493#29575
                TabOrder = 1
                object Label266: TLabel
                  Left = 8
                  Top = 20
                  Width = 150
                  Height = 12
                  Caption = 'Lv.1'#26292#20987#20260#23475':        /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label271: TLabel
                  Left = 9
                  Top = 44
                  Width = 150
                  Height = 12
                  Caption = 'Lv.2'#26292#20987#20260#23475':        /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label272: TLabel
                  Left = 8
                  Top = 68
                  Width = 150
                  Height = 12
                  Caption = 'Lv.3'#26292#20987#20260#23475':        /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label273: TLabel
                  Left = 7
                  Top = 92
                  Width = 150
                  Height = 12
                  Caption = 'Lv.4'#26292#20987#20260#23475':        /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label274: TLabel
                  Left = 7
                  Top = 116
                  Width = 150
                  Height = 12
                  Caption = 'Lv.5'#26292#20987#20260#23475':        /100'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object EditStormsHitRate1: TSpinEdit
                  Left = 87
                  Top = 16
                  Width = 46
                  Height = 21
                  Hint = 
                    #25552#39640#20260#23475','#23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100,'#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'50,'#23454#38469#23041#21147'=100 + 100*(50/100)=1' +
                    '50'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 0
                  Value = 2
                  OnChange = EditStormsHitRate1Change
                end
                object EditStormsHitRate2: TSpinEdit
                  Left = 86
                  Top = 40
                  Width = 46
                  Height = 21
                  Hint = 
                    #25552#39640#20260#23475','#23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100,'#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'50,'#23454#38469#23041#21147'=100 + 100*(50/100)=1' +
                    '50'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 1
                  Value = 2
                  OnChange = EditStormsHitRate2Change
                end
                object EditStormsHitRate3: TSpinEdit
                  Left = 86
                  Top = 64
                  Width = 46
                  Height = 21
                  Hint = 
                    #25552#39640#20260#23475','#23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100,'#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'50,'#23454#38469#23041#21147'=100 + 100*(50/100)=1' +
                    '50'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 2
                  Value = 2
                  OnChange = EditStormsHitRate3Change
                end
                object EditStormsHitRate4: TSpinEdit
                  Left = 86
                  Top = 88
                  Width = 46
                  Height = 21
                  Hint = 
                    #25552#39640#20260#23475','#23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100,'#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'50,'#23454#38469#23041#21147'=100 + 100*(50/100)=1' +
                    '50'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 3
                  Value = 2
                  OnChange = EditStormsHitRate4Change
                end
                object EditStormsHitRate5: TSpinEdit
                  Left = 86
                  Top = 112
                  Width = 46
                  Height = 21
                  Hint = 
                    #25552#39640#20260#23475','#23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100,'#21407#25915#20987#21147#20026'100,'#35774#32622#30340#20493#25968#20026'50,'#23454#38469#23041#21147'=100 + 100*(50/100)=1' +
                    '50'
                  EditorEnabled = False
                  MaxValue = 65535
                  MinValue = 1
                  TabOrder = 4
                  Value = 2
                  OnChange = EditStormsHitRate5Change
                end
              end
              object GroupBox128: TGroupBox
                Left = 8
                Top = 71
                Width = 153
                Height = 139
                Caption = #26292#20987#29575#35774#32622
                TabOrder = 2
                object Label291: TLabel
                  Left = 16
                  Top = 20
                  Width = 126
                  Height = 12
                  Caption = 'Lv.1 '#26292#20987#29575'         %'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label289: TLabel
                  Left = 16
                  Top = 44
                  Width = 126
                  Height = 12
                  Caption = 'Lv.2 '#26292#20987#29575'         %'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label290: TLabel
                  Left = 16
                  Top = 68
                  Width = 126
                  Height = 12
                  Caption = 'Lv.3 '#26292#20987#29575'         %'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label292: TLabel
                  Left = 16
                  Top = 92
                  Width = 126
                  Height = 12
                  Caption = 'Lv.4 '#26292#20987#29575'         %'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object Label293: TLabel
                  Left = 16
                  Top = 116
                  Width = 126
                  Height = 12
                  Caption = 'Lv.5 '#26292#20987#29575'         %'
                  Font.Charset = GB2312_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = #23435#20307
                  Font.Style = []
                  ParentFont = False
                end
                object EditStormsHitAppearRate1: TSpinEdit
                  Left = 84
                  Top = 16
                  Width = 48
                  Height = 21
                  Hint = #36830#20987#25216#33021','#20986#29616#26292#20987#30340#26426#29575
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 0
                  Value = 1
                  OnChange = EditStormsHitAppearRate1Change
                end
                object EditStormsHitAppearRate2: TSpinEdit
                  Left = 84
                  Top = 40
                  Width = 48
                  Height = 21
                  Hint = #36830#20987#25216#33021','#20986#29616#26292#20987#30340#26426#29575
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 1
                  Value = 1
                  OnChange = EditStormsHitAppearRate2Change
                end
                object EditStormsHitAppearRate3: TSpinEdit
                  Left = 84
                  Top = 64
                  Width = 48
                  Height = 21
                  Hint = #36830#20987#25216#33021','#20986#29616#26292#20987#30340#26426#29575
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 2
                  Value = 1
                  OnChange = EditStormsHitAppearRate3Change
                end
                object EditStormsHitAppearRate4: TSpinEdit
                  Left = 84
                  Top = 88
                  Width = 48
                  Height = 21
                  Hint = #36830#20987#25216#33021','#20986#29616#26292#20987#30340#26426#29575
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 3
                  Value = 1
                  OnChange = EditStormsHitAppearRate4Change
                end
                object EditStormsHitAppearRate5: TSpinEdit
                  Left = 84
                  Top = 112
                  Width = 48
                  Height = 21
                  Hint = #36830#20987#25216#33021','#20986#29616#26292#20987#30340#26426#29575
                  MaxValue = 100
                  MinValue = 1
                  TabOrder = 4
                  Value = 1
                  OnChange = EditStormsHitAppearRate5Change
                end
              end
              object GroupBox135: TGroupBox
                Left = 169
                Top = 8
                Width = 154
                Height = 60
                Caption = #36947#27861#20445#25252#30462
                TabOrder = 3
                object Label280: TLabel
                  Left = 22
                  Top = 16
                  Width = 108
                  Height = 12
                  Caption = #22266#23450#20445#25252'         %'
                end
                object Label283: TLabel
                  Left = 21
                  Top = 38
                  Width = 108
                  Height = 12
                  Hint = #25918#36830#20987#26102#38543#26426#24471#21040#30340#21560#20260#27604#29575
                  Caption = #38543#26426#20445#25252'         %'
                end
                object SpinEditBatterDecDamageRate: TSpinEdit
                  Left = 72
                  Top = 12
                  Width = 48
                  Height = 21
                  Hint = #25918#36830#20987#25216#33021#26102#22266#23450#21560#20260#30340#27604#20363
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 0
                  Value = 5
                  OnChange = SpinEditBatterDecDamageRateChange
                end
                object SpinEditBatterRandDecDamageRate: TSpinEdit
                  Left = 72
                  Top = 34
                  Width = 48
                  Height = 21
                  Hint = #25918#36830#20987#25216#33021#26102#38543#26426#21462#30340#21560#20260#30340#27604#20363#22240#23376
                  MaxValue = 100
                  MinValue = 0
                  TabOrder = 1
                  Value = 5
                  OnChange = SpinEditBatterRandDecDamageRateChange
                end
              end
            end
            object TabSheet58: TTabSheet
              Caption = #27494#22763#36830#20987
              ImageIndex = 2
              object PageControl7: TPageControl
                Left = 0
                Top = 21
                Width = 433
                Height = 217
                ActivePage = TabSheet63
                Align = alBottom
                TabOrder = 0
                object TabSheet63: TTabSheet
                  Caption = #26029#23731#26025
                  ImageIndex = 2
                  object GroupBox133: TGroupBox
                    Left = 6
                    Top = 8
                    Width = 123
                    Height = 46
                    Caption = #25915#20987#33539#22260
                    TabOrder = 0
                    object Label281: TLabel
                      Left = 10
                      Top = 20
                      Width = 48
                      Height = 12
                      Caption = #33539'  '#22260#65306
                    end
                    object EditSkillFireRange_82: TSpinEdit
                      Left = 60
                      Top = 15
                      Width = 53
                      Height = 21
                      Hint = #25216#33021#25915#20987#33539#22260
                      EditorEnabled = False
                      MaxValue = 10
                      MinValue = 1
                      TabOrder = 0
                      Value = 1
                      OnChange = EditSkillFireRange_82Change
                    end
                  end
                end
                object TabSheet64: TTabSheet
                  Caption = #27178#25195#21315#20891
                  ImageIndex = 3
                  object GroupBox131: TGroupBox
                    Left = 6
                    Top = 8
                    Width = 123
                    Height = 46
                    Caption = #25915#20987#33539#22260
                    TabOrder = 0
                    object Label275: TLabel
                      Left = 10
                      Top = 20
                      Width = 48
                      Height = 12
                      Caption = #33539'  '#22260#65306
                    end
                    object EditSkillFireRange_85: TSpinEdit
                      Left = 60
                      Top = 15
                      Width = 53
                      Height = 21
                      Hint = #25216#33021#25915#20987#33539#22260#21322#24452#12290
                      EditorEnabled = False
                      MaxValue = 10
                      MinValue = 1
                      TabOrder = 0
                      Value = 1
                      OnChange = EditSkillFireRange_85Change
                    end
                  end
                end
              end
            end
            object TabSheet59: TTabSheet
              Caption = #27861#24072#36830#20987
              ImageIndex = 3
              object PageControl8: TPageControl
                Left = 0
                Top = 21
                Width = 433
                Height = 217
                ActivePage = TabSheet68
                Align = alBottom
                TabOrder = 0
                object TabSheet68: TTabSheet
                  Caption = #20912#22825#38634#22320
                  ImageIndex = 3
                  object GroupBox130: TGroupBox
                    Left = 6
                    Top = 8
                    Width = 123
                    Height = 46
                    Caption = #25915#20987#33539#22260
                    TabOrder = 0
                    object Label270: TLabel
                      Left = 10
                      Top = 20
                      Width = 48
                      Height = 12
                      Caption = #33539'  '#22260#65306
                    end
                    object EditSkillFireRange_86: TSpinEdit
                      Left = 60
                      Top = 15
                      Width = 53
                      Height = 21
                      Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                      EditorEnabled = False
                      MaxValue = 10
                      MinValue = 1
                      TabOrder = 0
                      Value = 1
                      OnChange = EditSkillFireRange_86Change
                    end
                  end
                  object GroupBox132: TGroupBox
                    Left = 6
                    Top = 64
                    Width = 123
                    Height = 46
                    Caption = #25345#32493#25481#34880
                    TabOrder = 1
                    object Label276: TLabel
                      Left = 10
                      Top = 20
                      Width = 48
                      Height = 12
                      Caption = #28857'  '#25968#65306
                    end
                    object EditBatterSkillPoinson_86: TSpinEdit
                      Left = 60
                      Top = 16
                      Width = 53
                      Height = 21
                      Hint = #20013#27492#25216#33021#21518#65292#19968#23450#26102#38388#20869#27599#27425#25481#34880#30340#28857#25968
                      EditorEnabled = False
                      MaxValue = 65535
                      MinValue = 0
                      TabOrder = 0
                      Value = 1
                      OnChange = EditBatterSkillPoinson_86Change
                    end
                  end
                end
              end
            end
            object TabSheet60: TTabSheet
              Caption = #36947#22763#36830#20987
              ImageIndex = 4
              object PageControl9: TPageControl
                Left = 0
                Top = 21
                Width = 433
                Height = 217
                ActivePage = TabSheet72
                Align = alBottom
                TabOrder = 0
                object TabSheet72: TTabSheet
                  Caption = #19975#21073#24402#23447
                  ImageIndex = 3
                  object GroupBox129: TGroupBox
                    Left = 6
                    Top = 8
                    Width = 123
                    Height = 46
                    Caption = #25915#20987#33539#22260
                    TabOrder = 0
                    object Label268: TLabel
                      Left = 10
                      Top = 20
                      Width = 48
                      Height = 12
                      Caption = #33539'  '#22260#65306
                    end
                    object EditSkillFireRange_87: TSpinEdit
                      Left = 60
                      Top = 15
                      Width = 53
                      Height = 21
                      Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
                      EditorEnabled = False
                      MaxValue = 10
                      MinValue = 1
                      TabOrder = 0
                      Value = 1
                      OnChange = EditSkillFireRange_87Change
                    end
                  end
                  object GroupBox134: TGroupBox
                    Left = 6
                    Top = 64
                    Width = 123
                    Height = 46
                    Caption = #25345#32493#25481#34880
                    TabOrder = 1
                    object Label277: TLabel
                      Left = 10
                      Top = 20
                      Width = 48
                      Height = 12
                      Caption = #28857'  '#25968#65306
                    end
                    object EditBatterSkillPoinson_87: TSpinEdit
                      Left = 60
                      Top = 16
                      Width = 53
                      Height = 21
                      Hint = #20013#27492#25216#33021#21518#65292#19968#23450#26102#38388#20869#27599#27425#25481#34880#30340#28857#25968
                      EditorEnabled = False
                      MaxValue = 65535
                      MinValue = 1
                      TabOrder = 0
                      Value = 1
                      OnChange = EditBatterSkillPoinson_87Change
                    end
                  end
                  object GroupBox212: TGroupBox
                    Left = 5
                    Top = 117
                    Width = 123
                    Height = 46
                    Caption = #20013#27602#26102#38388
                    TabOrder = 2
                    object Label524: TLabel
                      Left = 10
                      Top = 20
                      Width = 102
                      Height = 12
                      Caption = #26102#38271#65306'         '#31186
                    end
                    object EditPoisonLength_87: TSpinEdit
                      Left = 46
                      Top = 15
                      Width = 53
                      Height = 21
                      Hint = #20013#27492#25216#33021#21518#65292#20013#27602#30340#26102#38271#65292#35774#32622'0'#26102#20351#29992#24341#25806#31639#27861#35745#31639
                      EditorEnabled = False
                      MaxValue = 255
                      MinValue = 0
                      TabOrder = 0
                      Value = 1
                      OnChange = EditPoisonLength_87Change
                    end
                  end
                end
              end
            end
          end
        end
      end
      object ButtonSkillSave: TButton
        Left = 367
        Top = 292
        Width = 66
        Height = 24
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSkillSaveClick
      end
    end
    object TabSheet34: TTabSheet
      Caption = #21319#32423#27494#22120
      ImageIndex = 6
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 161
        Height = 113
        Caption = #22522#26412#35774#32622
        TabOrder = 0
        object Label13: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #26368#39640#28857#25968':'
        end
        object Label15: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #25152#38656#36153#29992':'
        end
        object Label16: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #25152#38656#26102#38388':'
        end
        object Label17: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #36807#26399#26102#38388':'
        end
        object Label18: TLabel
          Left = 136
          Top = 65
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label19: TLabel
          Left = 136
          Top = 89
          Width = 12
          Height = 12
          Caption = #22825
        end
        object EditUpgradeWeaponMaxPoint: TSpinEdit
          Left = 68
          Top = 15
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 765
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditUpgradeWeaponMaxPointChange
        end
        object EditUpgradeWeaponPrice: TSpinEdit
          Left = 68
          Top = 39
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 1000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditUpgradeWeaponPriceChange
        end
        object EditUPgradeWeaponGetBackTime: TSpinEdit
          Left = 68
          Top = 63
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 36000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditUPgradeWeaponGetBackTimeChange
        end
        object EditClearExpireUpgradeWeaponDays: TSpinEdit
          Left = 68
          Top = 87
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditClearExpireUpgradeWeaponDaysChange
        end
      end
      object GroupBox18: TGroupBox
        Left = 176
        Top = 8
        Width = 265
        Height = 89
        Caption = #25915#20987#21147#21319#32423
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label21: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label22: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponDCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#25915#20987#21147#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponDCRateChange
        end
        object EditUpgradeWeaponDCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponDCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponDCTwoPointRateChange
        end
        object EditUpgradeWeaponDCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponDCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponDCThreePointRateChange
        end
        object EditUpgradeWeaponDCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox19: TGroupBox
        Left = 176
        Top = 104
        Width = 265
        Height = 97
        Caption = #36947#26415#21319#32423
        TabOrder = 2
        object Label23: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label24: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label25: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponSCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#36947#26415#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponSCRateChange
        end
        object EditUpgradeWeaponSCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponSCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponSCTwoPointRateChange
        end
        object EditUpgradeWeaponSCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponSCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponSCThreePointRateChange
        end
        object EditUpgradeWeaponSCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object GroupBox20: TGroupBox
        Left = 176
        Top = 208
        Width = 265
        Height = 89
        Caption = #39764#27861#21319#32423
        TabOrder = 3
        object Label26: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25104#21151#26426#29575':'
        end
        object Label27: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #20108#28857#26426#29575':'
        end
        object Label28: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #19977#28857#26426#29575':'
        end
        object ScrollBarUpgradeWeaponMCRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #21319#32423#39764#27861#28857#25968#25104#21151#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarUpgradeWeaponMCRateChange
        end
        object EditUpgradeWeaponMCRate: TEdit
          Left = 216
          Top = 16
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarUpgradeWeaponMCTwoPointRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #24471#21040#20108#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarUpgradeWeaponMCTwoPointRateChange
        end
        object EditUpgradeWeaponMCTwoPointRate: TEdit
          Left = 216
          Top = 40
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarUpgradeWeaponMCThreePointRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #24471#21040#19977#28857#23646#24615#26426#29575#65292#26426#29575#20026#24038#22823#21491#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarUpgradeWeaponMCThreePointRateChange
        end
        object EditUpgradeWeaponMCThreePointRate: TEdit
          Left = 216
          Top = 64
          Width = 41
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object ButtonUpgradeWeaponSave: TButton
        Left = 8
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonUpgradeWeaponSaveClick
      end
      object ButtonUpgradeWeaponDefaulf: TButton
        Left = 80
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 5
        OnClick = ButtonUpgradeWeaponDefaulfClick
      end
      object GroupBox143: TGroupBox
        Left = 9
        Top = 123
        Width = 161
        Height = 151
        Caption = #26292#20987#31561#32423#30456#20851
        TabOrder = 6
        Visible = False
        object Label308: TLabel
          Left = 8
          Top = 21
          Width = 78
          Height = 12
          Hint = #40664#35748#25286#21368#31561#32423'1'#27494#22120#36196#28814#30707','#38656'1'#20803#23453';'#22914#38656#25552#39640#20026'2'#20803#23453','#21017#35843#21442#25968#20026'2,'#21363'2'#20493
          Caption = #25286#21368#36153#29992#20493#29575':'
        end
        object Label309: TLabel
          Left = 8
          Top = 44
          Width = 78
          Height = 12
          Caption = #26292#20987#29983#25928#26426#29575':'
        end
        object Label436: TLabel
          Left = 8
          Top = 67
          Width = 78
          Height = 12
          Caption = #26292#20987#32047#31215#19978#38480':'
        end
        object EditArmsTearPriceRate: TSpinEdit
          Left = 84
          Top = 17
          Width = 61
          Height = 21
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditArmsTearPriceRateChange
        end
        object EditArmsCritRate: TSpinEdit
          Left = 84
          Top = 39
          Width = 61
          Height = 21
          Hint = #25968#20540#36234#23567#26292#20987#20986#29616#36234#39057#32321','#19982#27494#22120#26292#20987#31561#32423#26377#20851','#13#10#27880#24847':('#27492#25968#20540#65293#27494#22120#26292#20987#31561#32423')'#21518#38543#26426
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 11
          TabOrder = 1
          Value = 11
          OnChange = EditArmsCritRateChange
        end
        object EditMaxHeapStruckDamage: TSpinEdit
          Left = 84
          Top = 62
          Width = 61
          Height = 21
          Hint = #26292#20987#32047#31215#20540#19978#38480#20540','#38480#21046#32047#31215#20540#22823#23567
          MaxValue = 20000000
          MinValue = 1
          TabOrder = 2
          Value = 11
          OnChange = EditMaxHeapStruckDamageChange
        end
        object GroupBox248: TGroupBox
          Left = 6
          Top = 84
          Width = 150
          Height = 61
          Caption = #36153#29992#31867#22411
          TabOrder = 3
          object RadioArmsTearPriceGameGold: TRadioButton
            Left = 3
            Top = 17
            Width = 68
            Height = 17
            Caption = #20803#23453
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = RadioArmsTearPriceGameGoldClick
          end
          object RadioArmsTearPriceGold: TRadioButton
            Left = 3
            Top = 36
            Width = 68
            Height = 17
            Caption = #37329#24065
            TabOrder = 1
            OnClick = RadioArmsTearPriceGoldClick
          end
          object RadioArmsTearPriceGameGird: TRadioButton
            Left = 78
            Top = 15
            Width = 68
            Height = 17
            Caption = #28789#31526
            TabOrder = 2
            OnClick = RadioArmsTearPriceGameGirdClick
          end
          object RadioArmsTearPriceGameDiamond: TRadioButton
            Left = 78
            Top = 34
            Width = 68
            Height = 17
            Caption = #37329#21018#30707
            TabOrder = 3
            OnClick = RadioArmsTearPriceGameDiamondClick
          end
        end
      end
    end
    object TabSheet35: TTabSheet
      Caption = #25366#30719#25511#21046
      ImageIndex = 7
      object GroupBox24: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 60
        Caption = #24471#21040#30719#30707#26426#29575
        TabOrder = 0
        object Label32: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #21629#20013#26426#29575':'
        end
        object Label33: TLabel
          Left = 8
          Top = 36
          Width = 54
          Height = 12
          Caption = #25366#30719#26426#29575':'
        end
        object ScrollBarMakeMineHitRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Hint = #35774#32622#30340#25968#23383#36234#23567#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarMakeMineHitRateChange
        end
        object EditMakeMineHitRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarMakeMineRate: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = #35774#32622#30340#25968#23383#36234#23567#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarMakeMineRateChange
        end
        object EditMakeMineRate: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object GroupBox25: TGroupBox
        Left = 8
        Top = 72
        Width = 273
        Height = 217
        Caption = #30719#30707#31867#22411#26426#29575
        TabOrder = 1
        object Label34: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #30719#30707#22240#23376':'
        end
        object Label35: TLabel
          Left = 8
          Top = 38
          Width = 42
          Height = 12
          Caption = #37329#30719#29575':'
        end
        object Label36: TLabel
          Left = 8
          Top = 56
          Width = 42
          Height = 12
          Caption = #38134#30719#29575':'
        end
        object Label37: TLabel
          Left = 8
          Top = 76
          Width = 42
          Height = 12
          Caption = #38081#30719#29575':'
        end
        object Label38: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #40657#38081#30719#29575':'
        end
        object ScrollBarStoneTypeRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarStoneTypeRateChange
        end
        object EditStoneTypeRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarGoldStoneMax: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarGoldStoneMaxChange
        end
        object EditGoldStoneMax: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarSilverStoneMax: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarSilverStoneMaxChange
        end
        object EditSilverStoneMax: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarSteelStoneMax: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarSteelStoneMaxChange
        end
        object EditSteelStoneMax: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditBlackStoneMax: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarBlackStoneMax: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarBlackStoneMaxChange
        end
      end
      object ButtonMakeMineSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonMakeMineSaveClick
      end
      object GroupBox26: TGroupBox
        Left = 288
        Top = 8
        Width = 153
        Height = 121
        Caption = #30719#30707#21697#36136
        TabOrder = 3
        object Label39: TLabel
          Left = 8
          Top = 18
          Width = 78
          Height = 12
          Caption = #30719#30707#26368#23567#21697#36136':'
        end
        object Label40: TLabel
          Left = 8
          Top = 42
          Width = 78
          Height = 12
          Caption = #26222#36890#21697#36136#33539#22260':'
        end
        object Label41: TLabel
          Left = 8
          Top = 66
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#26426#29575':'
        end
        object Label42: TLabel
          Left = 8
          Top = 90
          Width = 66
          Height = 12
          Caption = #39640#21697#36136#33539#22260':'
        end
        object EditStoneMinDura: TSpinEdit
          Left = 92
          Top = 15
          Width = 45
          Height = 21
          Hint = #30719#30707#20986#29616#26368#20302#21697#36136#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStoneMinDuraChange
        end
        object EditStoneGeneralDuraRate: TSpinEdit
          Left = 92
          Top = 39
          Width = 45
          Height = 21
          Hint = #30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditStoneGeneralDuraRateChange
        end
        object EditStoneAddDuraRate: TSpinEdit
          Left = 92
          Top = 63
          Width = 45
          Height = 21
          Hint = #30719#30707#20986#29616#39640#21697#36136#28857#25968#26426#29575#65292#39640#21697#36136#37327#25351#21487#36798#21040'20'#25110#20197#19978#30340#28857#25968#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditStoneAddDuraRateChange
        end
        object EditStoneAddDuraMax: TSpinEdit
          Left = 92
          Top = 87
          Width = 45
          Height = 21
          Hint = #39640#21697#36136#30719#30707#38543#26426#20986#29616#21697#36136#28857#25968#33539#22260#12290
          EditorEnabled = False
          MaxValue = 1000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditStoneAddDuraMaxChange
        end
      end
      object ButtonMakeMineDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 4
        OnClick = ButtonMakeMineDefaultClick
      end
    end
    object TabSheet42: TTabSheet
      Caption = #31069#31119#27833#25511#21046
      ImageIndex = 12
      object GroupBox44: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 217
        Caption = #26426#29575#35774#32622
        TabOrder = 0
        object Label105: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #35781#21650#26426#29575':'
        end
        object Label106: TLabel
          Left = 8
          Top = 38
          Width = 54
          Height = 12
          Caption = #19968#32423#28857#25968':'
        end
        object Label107: TLabel
          Left = 8
          Top = 56
          Width = 54
          Height = 12
          Caption = #20108#32423#28857#25968':'
        end
        object Label108: TLabel
          Left = 8
          Top = 76
          Width = 54
          Height = 12
          Caption = #20108#32423#26426#29575':'
        end
        object Label109: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #19977#32423#28857#25968':'
        end
        object Label110: TLabel
          Left = 8
          Top = 116
          Width = 54
          Height = 12
          Caption = #19977#32423#26426#29575':'
        end
        object ScrollBarWeaponMakeUnLuckRate: TScrollBar
          Left = 72
          Top = 16
          Width = 129
          Height = 15
          Hint = #20351#29992#31069#31119#27833#35781#21650#26426#29575#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWeaponMakeUnLuckRateChange
        end
        object EditWeaponMakeUnLuckRate: TEdit
          Left = 208
          Top = 16
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWeaponMakeLuckPoint1: TScrollBar
          Left = 72
          Top = 36
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017'100% '#25104#21151#12290
          Max = 500
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWeaponMakeLuckPoint1Change
        end
        object EditWeaponMakeLuckPoint1: TEdit
          Left = 208
          Top = 36
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWeaponMakeLuckPoint2: TScrollBar
          Left = 72
          Top = 56
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWeaponMakeLuckPoint2Change
        end
        object EditWeaponMakeLuckPoint2: TEdit
          Left = 208
          Top = 56
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWeaponMakeLuckPoint2Rate: TScrollBar
          Left = 72
          Top = 76
          Width = 129
          Height = 15
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWeaponMakeLuckPoint2RateChange
        end
        object EditWeaponMakeLuckPoint2Rate: TEdit
          Left = 208
          Top = 76
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWeaponMakeLuckPoint3: TEdit
          Left = 208
          Top = 96
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWeaponMakeLuckPoint3: TScrollBar
          Left = 72
          Top = 96
          Width = 129
          Height = 15
          Hint = #24403#27494#22120#30340#24184#36816#28857#23567#20110#27492#28857#25968#26102#20351#29992#31069#31119#27833#21017#25353#25351#23450#26426#29575#20915#23450#26159#21542#21152#24184#36816#12290
          Max = 500
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWeaponMakeLuckPoint3Change
        end
        object ScrollBarWeaponMakeLuckPoint3Rate: TScrollBar
          Left = 72
          Top = 116
          Width = 129
          Height = 15
          Hint = #26426#29575#28857#25968#65292#25968#23383#36234#22823#26426#29575#36234#23567#12290
          Max = 500
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWeaponMakeLuckPoint3RateChange
        end
        object EditWeaponMakeLuckPoint3Rate: TEdit
          Left = 208
          Top = 116
          Width = 57
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
      end
      object ButtonWeaponMakeLuckDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 1
        OnClick = ButtonWeaponMakeLuckDefaultClick
      end
      object ButtonWeaponMakeLuckSave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonWeaponMakeLuckSaveClick
      end
    end
    object TabSheet37: TTabSheet
      Caption = #24425#31080#25511#21046
      ImageIndex = 8
      object GroupBox27: TGroupBox
        Left = 8
        Top = 8
        Width = 273
        Height = 169
        Caption = #20013#22870#26426#29575
        TabOrder = 0
        object Label43: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label44: TLabel
          Left = 8
          Top = 62
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label45: TLabel
          Left = 8
          Top = 80
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label46: TLabel
          Left = 8
          Top = 100
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label47: TLabel
          Left = 8
          Top = 120
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label48: TLabel
          Left = 8
          Top = 140
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object Label49: TLabel
          Left = 8
          Top = 18
          Width = 30
          Height = 12
          Caption = #22240#23376':'
        end
        object ScrollBarWinLottery1Max: TScrollBar
          Left = 56
          Top = 40
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarWinLottery1MaxChange
        end
        object EditWinLottery1Max: TEdit
          Left = 192
          Top = 40
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 1
        end
        object ScrollBarWinLottery2Max: TScrollBar
          Left = 56
          Top = 60
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarWinLottery2MaxChange
        end
        object EditWinLottery2Max: TEdit
          Left = 192
          Top = 60
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 3
        end
        object ScrollBarWinLottery3Max: TScrollBar
          Left = 56
          Top = 80
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarWinLottery3MaxChange
        end
        object EditWinLottery3Max: TEdit
          Left = 192
          Top = 80
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 5
        end
        object ScrollBarWinLottery4Max: TScrollBar
          Left = 56
          Top = 100
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 6
          OnChange = ScrollBarWinLottery4MaxChange
        end
        object EditWinLottery4Max: TEdit
          Left = 192
          Top = 100
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 7
        end
        object EditWinLottery5Max: TEdit
          Left = 192
          Top = 120
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 8
        end
        object ScrollBarWinLottery5Max: TScrollBar
          Left = 56
          Top = 120
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 9
          OnChange = ScrollBarWinLottery5MaxChange
        end
        object ScrollBarWinLottery6Max: TScrollBar
          Left = 56
          Top = 140
          Width = 129
          Height = 15
          Max = 1000000
          PageSize = 0
          TabOrder = 10
          OnChange = ScrollBarWinLottery6MaxChange
        end
        object EditWinLottery6Max: TEdit
          Left = 192
          Top = 140
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 11
        end
        object EditWinLotteryRate: TEdit
          Left = 192
          Top = 16
          Width = 73
          Height = 18
          Ctl3D = False
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 12
        end
        object ScrollBarWinLotteryRate: TScrollBar
          Left = 56
          Top = 16
          Width = 129
          Height = 15
          Max = 100000
          PageSize = 0
          TabOrder = 13
          OnChange = ScrollBarWinLotteryRateChange
        end
      end
      object GroupBox28: TGroupBox
        Left = 288
        Top = 8
        Width = 145
        Height = 169
        Caption = #22870#37329
        TabOrder = 1
        object Label50: TLabel
          Left = 8
          Top = 18
          Width = 42
          Height = 12
          Caption = #19968#31561#22870':'
        end
        object Label51: TLabel
          Left = 8
          Top = 42
          Width = 42
          Height = 12
          Caption = #20108#31561#22870':'
        end
        object Label52: TLabel
          Left = 8
          Top = 66
          Width = 42
          Height = 12
          Caption = #19977#31561#22870':'
        end
        object Label53: TLabel
          Left = 8
          Top = 90
          Width = 42
          Height = 12
          Caption = #22235#31561#22870':'
        end
        object Label54: TLabel
          Left = 8
          Top = 114
          Width = 42
          Height = 12
          Caption = #20116#31561#22870':'
        end
        object Label55: TLabel
          Left = 8
          Top = 138
          Width = 42
          Height = 12
          Caption = #20845#31561#22870':'
        end
        object EditWinLottery1Gold: TSpinEdit
          Left = 56
          Top = 15
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 100000000
          OnChange = EditWinLottery1GoldChange
        end
        object EditWinLottery2Gold: TSpinEdit
          Left = 56
          Top = 39
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditWinLottery2GoldChange
        end
        object EditWinLottery3Gold: TSpinEdit
          Left = 56
          Top = 63
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditWinLottery3GoldChange
        end
        object EditWinLottery4Gold: TSpinEdit
          Left = 56
          Top = 87
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditWinLottery4GoldChange
        end
        object EditWinLottery5Gold: TSpinEdit
          Left = 56
          Top = 111
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 4
          Value = 10
          OnChange = EditWinLottery5GoldChange
        end
        object EditWinLottery6Gold: TSpinEdit
          Left = 56
          Top = 135
          Width = 81
          Height = 21
          Increment = 500
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditWinLottery6GoldChange
        end
      end
      object ButtonWinLotterySave: TButton
        Left = 376
        Top = 277
        Width = 65
        Height = 20
        Caption = #20445#23384'(&S)'
        ModalResult = 1
        TabOrder = 2
        OnClick = ButtonWinLotterySaveClick
      end
      object ButtonWinLotteryDefault: TButton
        Left = 296
        Top = 277
        Width = 65
        Height = 20
        Caption = #40664#35748'(&D)'
        TabOrder = 3
        OnClick = ButtonWinLotteryDefaultClick
      end
    end
    object TabSheet40: TTabSheet
      Caption = #31048#31095#29983#25928
      ImageIndex = 11
      object GroupBox36: TGroupBox
        Left = 8
        Top = 8
        Width = 137
        Height = 65
        Caption = #31048#31095#29983#25928
        TabOrder = 0
        object Label94: TLabel
          Left = 11
          Top = 40
          Width = 54
          Height = 12
          Caption = #29983#25928#26102#38271':'
        end
        object CheckBoxSpiritMutiny: TCheckBox
          Left = 8
          Top = 16
          Width = 113
          Height = 17
          Caption = #21551#29992#31048#31095#29305#27530#21151#33021
          TabOrder = 0
          OnClick = CheckBoxSpiritMutinyClick
        end
        object EditSpiritMutinyTime: TSpinEdit
          Left = 72
          Top = 36
          Width = 49
          Height = 21
          EditorEnabled = False
          MaxValue = 9999
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditSpiritMutinyTimeChange
        end
      end
      object ButtonSpiritMutinySave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSpiritMutinySaveClick
      end
    end
    object TabSheet44: TTabSheet
      Caption = #20132#26131#31995#32479
      ImageIndex = 13
      object GroupBox49: TGroupBox
        Left = 8
        Top = 8
        Width = 171
        Height = 73
        Caption = #23492#21806#31995#32479
        TabOrder = 0
        object Label113: TLabel
          Left = 16
          Top = 24
          Width = 60
          Height = 12
          Caption = #25968#37327#38480#21046#65306
        end
        object Label114: TLabel
          Left = 16
          Top = 48
          Width = 48
          Height = 12
          Caption = #31246#25910#29575#65306
        end
        object Label115: TLabel
          Left = 144
          Top = 48
          Width = 6
          Height = 12
          Caption = '%'
        end
        object SpinEditSellOffCount: TSpinEdit
          Left = 80
          Top = 20
          Width = 57
          Height = 21
          Hint = #27599#20010#20154#23492#21806#29289#21697#30340#25968#37327
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinEditSellOffCountChange
        end
        object SpinEditSellOffTax: TSpinEdit
          Left = 80
          Top = 44
          Width = 57
          Height = 21
          Hint = #36890#36807#20132#26131#25152#25910#21462#30340#31246#29575
          Enabled = False
          MaxValue = 0
          MinValue = 0
          TabOrder = 1
          Value = 0
          OnChange = SpinEditSellOffTaxChange
        end
      end
      object ButtonSellOffSave: TButton
        Left = 360
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSellOffSaveClick
      end
      object GroupBox68: TGroupBox
        Left = 8
        Top = 86
        Width = 172
        Height = 48
        Caption = #20803#23453#23492#21806#31995#32479
        TabOrder = 2
        object Label158: TLabel
          Left = 10
          Top = 20
          Width = 72
          Height = 12
          Caption = #27599#27425#25187#20803#23453#65306
        end
        object EdtDecUserGameGold: TSpinEdit
          Left = 82
          Top = 16
          Width = 57
          Height = 21
          Hint = #27599#27425#36141#20080#25110#20986#21806#25152#25187#30340#20803#23453#20540
          MaxValue = 1000
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = EdtDecUserGameGoldChange
        end
      end
      object GroupBox142: TGroupBox
        Left = 10
        Top = 139
        Width = 171
        Height = 117
        Caption = #25670#25674#36873#39033
        TabOrder = 3
        object Label307: TLabel
          Left = 10
          Top = 96
          Width = 84
          Height = 12
          Caption = #25670#25674#25152#38656#31561#32423#65306
        end
        object CheckBoxOpenSelfShop: TCheckBox
          Left = 9
          Top = 17
          Width = 104
          Height = 21
          Hint = #26159#21542#24320#21551#26381#21153#22120#25670#25674#21151#33021#12290
          Caption = #24320#21551#25670#25674#21151#33021
          TabOrder = 0
          OnClick = CheckBoxOpenSelfShopClick
        end
        object CheckBoxSafeZoneShop: TCheckBox
          Left = 9
          Top = 35
          Width = 144
          Height = 21
          Hint = #36873#20013#35813#39033#65292#21482#26377#22312#23433#20840#21306#25165#20801#35768#25670#25674#12290
          Caption = #21482#20801#35768#22312#23433#20840#21306#20869#25670#25674
          TabOrder = 1
          OnClick = CheckBoxSafeZoneShopClick
        end
        object CheckBoxMapShop: TCheckBox
          Left = 9
          Top = 54
          Width = 160
          Height = 21
          Hint = #36873#20013#35813#39033#65292#21482#26377#24403#22320#22270#26631#24535' SHOP '#25171#24320#26102#25165#20801#35768#22312#35813#22320#22270#25670#25674#12290
          Caption = #21482#20801#35768#22312#25351#23450#22320#22270#20869#25670#25674
          TabOrder = 2
          OnClick = CheckBoxMapShopClick
        end
        object CheckBoxOffLineShop: TCheckBox
          Left = 10
          Top = 75
          Width = 94
          Height = 16
          Hint = #36873#20013#35813#39033#21518#65292#20154#29289#25346#26426#26102#22914#26524#22788#20110#25670#25674#29366#24577#65292#23558#33258#21160#25910#25674#12290
          Caption = #31105#27490#25346#26426#25670#25674
          TabOrder = 3
          OnClick = CheckBoxOffLineShopClick
        end
        object SpinEditShopLevel: TSpinEdit
          Left = 89
          Top = 91
          Width = 57
          Height = 21
          Hint = #36798#21040#25351#23450#31561#32423#25165#21487#20197#25670#25674
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 0
          OnChange = SpinEditShopLevelChange
        end
      end
    end
    object TabSheet50: TTabSheet
      Caption = #35013#22791#21051#21517
      ImageIndex = 14
      object GroupBox55: TGroupBox
        Left = 8
        Top = 8
        Width = 257
        Height = 81
        Caption = #35013#22791#21051#21517
        TabOrder = 0
        object Label118: TLabel
          Left = 16
          Top = 48
          Width = 72
          Height = 12
          Caption = #33258#23450#20041#21069#32512#65306
        end
        object CheckBoxItemName: TCheckBox
          Left = 16
          Top = 24
          Width = 153
          Height = 17
          Caption = #20351#29992#29609#23478#30340#21517#31216#20570#21069#32512
          TabOrder = 0
          OnClick = CheckBoxItemNameClick
        end
        object EditItemName: TEdit
          Left = 88
          Top = 44
          Width = 161
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 1
          Text = #12310#25913#12311
          OnChange = EditItemNameChange
        end
      end
      object ButtonChangeUseItemName: TButton
        Left = 360
        Top = 259
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonChangeUseItemNameClick
      end
    end
    object TabSheet45: TTabSheet
      Caption = #37202#39302#31995#32479
      ImageIndex = 15
      object GroupBox89: TGroupBox
        Left = 8
        Top = 1
        Width = 164
        Height = 59
        Caption = #37247#37202#31561#24453#26102#38388
        TabOrder = 0
        object Label175: TLabel
          Left = 17
          Top = 17
          Width = 48
          Height = 12
          Caption = #26222#36890#37202#65306
        end
        object Label176: TLabel
          Left = 129
          Top = 17
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label178: TLabel
          Left = 17
          Top = 38
          Width = 48
          Height = 12
          Caption = #33647'  '#37202#65306
        end
        object Label179: TLabel
          Left = 129
          Top = 38
          Width = 12
          Height = 12
          Caption = #31186
        end
        object SpinEditMakeWineTime: TSpinEdit
          Left = 65
          Top = 13
          Width = 57
          Height = 21
          Hint = #37247#26222#36890#37202#38656#35201#31561#24453#30340#26102#38388
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = SpinEditMakeWineTimeChange
        end
        object SpinEditMakeWineTime1: TSpinEdit
          Left = 65
          Top = 34
          Width = 57
          Height = 21
          Hint = #37247#33647#37202#38656#35201#31561#24453#30340#26102#38388
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = SpinEditMakeWineTime1Change
        end
      end
      object GroupBox90: TGroupBox
        Left = 8
        Top = 60
        Width = 165
        Height = 54
        Caption = #33719#24471#26426#29575
        TabOrder = 1
        object Label177: TLabel
          Left = 11
          Top = 16
          Width = 54
          Height = 12
          Caption = #37202#26354#20960#29575':'
        end
        object Label286: TLabel
          Left = 11
          Top = 36
          Width = 54
          Height = 12
          Caption = #31561#32423#20960#29575':'
        end
        object SpinEditMakeWineRate: TSpinEdit
          Left = 76
          Top = 10
          Width = 53
          Height = 21
          Hint = #25968#23383#36234#23567#65292#37247#36896#26222#36890#37202#33719#24471#37202#26354#26426#29575#36234#22823#12290
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 6
          OnChange = SpinEditMakeWineRateChange
        end
        object SpinEditMakeWineLevelRate: TSpinEdit
          Left = 76
          Top = 30
          Width = 53
          Height = 21
          Hint = #25968#23383#36234#23567#65292#37247#36896#37202#26102#33719#24471#37202#31561#32423#26426#29575#36234#22823#12290
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 1
          Value = 6
          OnChange = SpinEditMakeWineLevelRateChange
        end
      end
      object ButtonSaveMakeWine: TButton
        Left = 352
        Top = 269
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonSaveMakeWineClick
      end
      object GroupBox91: TGroupBox
        Left = 180
        Top = 1
        Width = 261
        Height = 160
        Caption = #39278#37202#30456#20851
        TabOrder = 3
        object Label180: TLabel
          Left = 17
          Top = 20
          Width = 108
          Height = 12
          Caption = #37202#37327#36827#24230#22686#21152#38388#38548#65306
        end
        object Label181: TLabel
          Left = 193
          Top = 20
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label182: TLabel
          Left = 28
          Top = 44
          Width = 96
          Height = 12
          Caption = #37257#37202#24230#20943#23569#38388#38548#65306
        end
        object Label183: TLabel
          Left = 193
          Top = 44
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label184: TLabel
          Left = 28
          Top = 68
          Width = 96
          Height = 12
          Caption = #37202#37327#19978#38480#21021#22987#20540#65306
        end
        object Label185: TLabel
          Left = 17
          Top = 92
          Width = 108
          Height = 12
          Caption = #37202#37327#21319#32423#19978#38480#22686#21152#65306
        end
        object Label156: TLabel
          Left = 4
          Top = 116
          Width = 246
          Height = 12
          Caption = #37202#37327'>         '#23450#26102#20943#37202#37327','#38388#38548#65306'        '#20998
        end
        object Label296: TLabel
          Left = 18
          Top = 138
          Width = 84
          Height = 12
          Caption = #27599#27425#20943#37202#37327#20540#65306
        end
        object SpinEditIncAlcoholTick: TSpinEdit
          Left = 129
          Top = 16
          Width = 57
          Height = 21
          Hint = #37202#37327#36827#24230#22686#21152#26102#38388#38388#38548
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = SpinEditIncAlcoholTickChange
        end
        object SpinEditDesDrinkTick: TSpinEdit
          Left = 129
          Top = 40
          Width = 57
          Height = 21
          Hint = #37257#37202#24230#20943#23569#38388#38548#26102#38388
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = SpinEditDesDrinkTickChange
        end
        object SpinEditMaxAlcoholValue: TSpinEdit
          Left = 129
          Top = 64
          Width = 57
          Height = 21
          Hint = #37202#37327#21021#22987#19978#38480#20540
          MaxValue = 65535
          MinValue = 1
          TabOrder = 2
          Value = 2000
          OnChange = SpinEditMaxAlcoholValueChange
        end
        object SpinEditIncAlcoholValue: TSpinEdit
          Left = 129
          Top = 88
          Width = 57
          Height = 21
          Hint = #24403#21069#37202#37327#20540#36798#21040#19978#38480#21518','#37202#37327#19978#38480#22686#21152#25351#23450#30340#20540
          MaxValue = 65535
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = SpinEditIncAlcoholValueChange
        end
        object SpinEdit3: TSpinEdit
          Left = 188
          Top = 111
          Width = 51
          Height = 21
          Hint = #38271#26399#27809#26377#39278#37202','#38388#38548#22810#38271#26102#38388#20943#37202#37327#20540
          MaxValue = 65535
          MinValue = 1
          TabOrder = 4
          Value = 1440
          OnChange = SpinEdit3Change
        end
        object SpinEdit4: TSpinEdit
          Left = 100
          Top = 133
          Width = 65
          Height = 21
          Hint = #22312#32447#25351#23450#26102#38388#20869#27809#26377#39278#29992#33647#37202','#21017#20943#37202#37327#20540
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 5
          Value = 1
          OnChange = SpinEdit4Change
        end
        object SpinEdit5: TSpinEdit
          Left = 36
          Top = 111
          Width = 51
          Height = 21
          Hint = #38271#26399#27809#26377#39278#37202','#37202#37327#36229#36807#25351#23450#26102#65292#36827#34892#20943#37202#37327#65292#20302#20110#25351#23450#20540#26102#21017#19981#20943#37202#37327
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 6
          Value = 3500
          OnChange = SpinEdit5Change
        end
      end
      object GroupBox92: TGroupBox
        Left = 8
        Top = 115
        Width = 166
        Height = 193
        Caption = #33647#21147#20540#30456#20851
        TabOrder = 4
        object Label186: TLabel
          Left = 26
          Top = 173
          Width = 60
          Height = 12
          Caption = #20943#33647#21147#20540#65306
        end
        object Label187: TLabel
          Left = 4
          Top = 152
          Width = 84
          Height = 12
          Caption = #20943#33647#21147#20540#38388#38548#65306
        end
        object Label188: TLabel
          Left = 150
          Top = 152
          Width = 12
          Height = 12
          Caption = #31186
        end
        object GridMedicineExp: TStringGrid
          Left = 6
          Top = 11
          Width = 153
          Height = 137
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 1001
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          TabOrder = 0
          OnEnter = GridMedicineExpEnter
          ColWidths = (
            64
            67)
          RowHeights = (
            18
            18
            19
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18
            18)
        end
        object SpinEditDesMedicineValue: TSpinEdit
          Left = 85
          Top = 169
          Width = 65
          Height = 21
          Hint = #22312#32447#25351#23450#26102#38388#20869#27809#26377#39278#29992#33647#37202','#21017#20943#33647#21147#20540
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = SpinEditDesMedicineValueChange
        end
        object SpinEditDesMedicineTick: TSpinEdit
          Left = 85
          Top = 148
          Width = 65
          Height = 21
          Hint = #38271#26399#27809#26377#39278#37202','#38388#38548#22810#38271#26102#38388#20943#33647#21147#20540
          MaxValue = 100000000
          MinValue = 1
          TabOrder = 2
          Value = 43200
          OnChange = SpinEditDesMedicineTickChange
        end
      end
      object GroupBox93: TGroupBox
        Left = 181
        Top = 164
        Width = 219
        Height = 89
        Caption = #27849#27700
        TabOrder = 5
        object Label189: TLabel
          Left = 18
          Top = 19
          Width = 60
          Height = 12
          Caption = #37319#38598#26102#38388#65306
        end
        object Label190: TLabel
          Left = 142
          Top = 19
          Width = 12
          Height = 12
          Caption = #31186
        end
        object Label199: TLabel
          Left = 4
          Top = 43
          Width = 108
          Height = 12
          Caption = #34892#20250#37202#27849#33988#37327#23569#20110#65306
        end
        object Label200: TLabel
          Left = 156
          Top = 42
          Width = 60
          Height = 12
          Caption = #26102#19981#33021#39046#21462
        end
        object Label201: TLabel
          Left = 4
          Top = 67
          Width = 150
          Height = 12
          Caption = #34892#20250#25104#21592#39046#21462#27849#27700','#20943#33988#37327#65306
        end
        object SpinEditInFountainTime: TSpinEdit
          Left = 78
          Top = 15
          Width = 57
          Height = 21
          Hint = #37319#38598#27849#27700#38656#31449#22312#27849#30524#19978#30340#26102#38388','#36798#21040#13#25351#23450#26102#38388#21518','#27849#27700#32592#25165#33021#22686#21152#25345#20037'.'
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = SpinEditInFountainTimeChange
        end
        object SpinEditMinGuildFountain: TSpinEdit
          Left = 107
          Top = 39
          Width = 49
          Height = 21
          Hint = #34892#20250#37202#27849#33988#37327#23569#20110#35774#32622#20540#26102','#34892#20250#25104#21592#21017#26080#27861#39046#21462#27849#27700
          MaxValue = 65535
          MinValue = 1
          TabOrder = 1
          Value = 50
          OnChange = SpinEditMinGuildFountainChange
        end
        object SpinEditDecGuildFountain: TSpinEdit
          Left = 151
          Top = 63
          Width = 49
          Height = 21
          Hint = #34892#20250#25104#21592#39046#21462#37202#27849#26102','#34892#20250#33988#37327#20943#23569#25351#23450#30340#20540
          MaxValue = 65535
          MinValue = 1
          TabOrder = 2
          Value = 50
          OnChange = SpinEditDecGuildFountainChange
        end
      end
    end
    object TabSheet53: TTabSheet
      Caption = #22825#22320#32467#26230
      ImageIndex = 16
      object GroupBoxLevelExp: TGroupBox
        Left = 4
        Top = 0
        Width = 249
        Height = 129
        Caption = #21319#32423#32463#39564
        TabOrder = 0
        object GridExpCrystalLevelExp: TStringGrid
          Left = 8
          Top = 16
          Width = 233
          Height = 105
          ColCount = 3
          DefaultRowHeight = 18
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          TabOrder = 0
          OnEnter = GridExpCrystalLevelExpEnter
          ColWidths = (
            64
            67
            64)
        end
      end
      object ButtonExpCrystalSave: TButton
        Left = 344
        Top = 253
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonExpCrystalSaveClick
      end
      object GroupBox72: TGroupBox
        Left = 261
        Top = 5
        Width = 140
        Height = 41
        Caption = #33521#38596#32463#39564#20998#37197
        TabOrder = 2
        object Label148: TLabel
          Left = 11
          Top = 18
          Width = 54
          Height = 12
          Caption = #20998#37197#27604#20363':'
        end
        object EditHeroCrystalExpRate: TSpinEdit
          Left = 68
          Top = 14
          Width = 53
          Height = 21
          Hint = #33509#33521#38596#20998#37197'40'#21363'40%,'#20154#29289#23601#21482#33021#20998#21040'60%'#32463#39564
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 40
          OnChange = EditHeroCrystalExpRateChange
        end
      end
      object GroupBox137: TGroupBox
        Left = 5
        Top = 136
        Width = 188
        Height = 137
        Caption = #25552#21462#32463#39564#25152#38656#20540'<$CRYSTALLEVEL>'
        TabOrder = 3
        object Label295: TLabel
          Left = 11
          Top = 38
          Width = 78
          Height = 12
          Caption = #31532#19968#26723#23545#24212#20540':'
        end
        object Label297: TLabel
          Left = 11
          Top = 63
          Width = 78
          Height = 12
          Caption = #31532#20108#26723#23545#24212#20540':'
        end
        object Label298: TLabel
          Left = 11
          Top = 89
          Width = 78
          Height = 12
          Caption = #31532#19977#26723#23545#24212#20540':'
        end
        object Label299: TLabel
          Left = 11
          Top = 115
          Width = 78
          Height = 12
          Caption = #31532#22235#26723#23545#24212#20540':'
        end
        object SpinEdit6: TSpinEdit
          Left = 89
          Top = 34
          Width = 47
          Height = 21
          Hint = 
            #24403#22825#22320#32467#26230#31561#32423#20026'1'#32423#26102',<$CRYSTALLEVEL>'#21464#37327#25152#23545#24212#30340#20540','#13#10#22914#24403#31561#32423#20026'1'#32423#26102','#25552#21462#32463#39564#25152#38656'8'#20803#23453','#21017#35774#32622#23545#24212#21442#25968#20026 +
            '8'#13#10#25191#34892#33050#26412#26102','#33258#21160#25226'<$CRYSTALLEVEL>'#36171#20540#20026'8'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 1
          OnChange = SpinEdit6Change
        end
        object SpinEdit7: TSpinEdit
          Left = 89
          Top = 59
          Width = 47
          Height = 21
          Hint = 
            #24403#22825#22320#32467#26230#31561#32423#20026'2'#32423#26102',<$CRYSTALLEVEL>'#21464#37327#25152#23545#24212#30340#20540','#13#10#22914#24403#31561#32423#20026'2'#32423#26102','#25552#21462#32463#39564#25152#38656'8'#20803#23453','#21017#35774#32622#23545#24212#21442#25968#20026 +
            '8'#13#10#25191#34892#33050#26412#26102','#33258#21160#25226'<$CRYSTALLEVEL>'#36171#20540#20026'8'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 1
          OnChange = SpinEdit7Change
        end
        object SpinEdit8: TSpinEdit
          Left = 89
          Top = 85
          Width = 47
          Height = 21
          Hint = 
            #24403#22825#22320#32467#26230#31561#32423#20026'3'#32423#26102',<$CRYSTALLEVEL>'#21464#37327#25152#23545#24212#30340#20540','#13#10#22914#24403#31561#32423#20026'3'#32423#26102','#25552#21462#32463#39564#25152#38656'8'#20803#23453','#21017#35774#32622#23545#24212#21442#25968#20026 +
            '8'#13#10#25191#34892#33050#26412#26102','#33258#21160#25226'<$CRYSTALLEVEL>'#36171#20540#20026'8'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 1
          OnChange = SpinEdit8Change
        end
        object SpinEdit9: TSpinEdit
          Left = 89
          Top = 111
          Width = 47
          Height = 21
          Hint = 
            #24403#22825#22320#32467#26230#31561#32423#20026'4'#32423#26102',<$CRYSTALLEVEL>'#21464#37327#25152#23545#24212#30340#20540','#13#10#22914#24403#31561#32423#20026'4'#32423#26102','#25552#21462#32463#39564#25152#38656'8'#20803#23453','#21017#35774#32622#23545#24212#21442#25968#20026 +
            '8'#13#10#25191#34892#33050#26412#26102','#33258#21160#25226'<$CRYSTALLEVEL>'#36171#20540#20026'8'
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 1
          OnChange = SpinEdit9Change
        end
        object CheckBoxAssignmentCryst: TCheckBox
          Left = 13
          Top = 16
          Width = 92
          Height = 17
          Caption = #21551#29992#31561#32423#36171#20540
          TabOrder = 4
          OnClick = CheckBoxAssignmentCrystClick
        end
      end
    end
    object TabSheet54: TTabSheet
      Caption = #23500#36149#20861
      ImageIndex = 17
      object GroupBox116: TGroupBox
        Left = 5
        Top = 57
        Width = 140
        Height = 41
        Caption = #25915#20987#24618#35302#21457#33050#26412#27573#26426#29575
        TabOrder = 0
        object Label149: TLabel
          Left = 11
          Top = 20
          Width = 54
          Height = 12
          Caption = #35302#21457#26426#29575':'
        end
        object SpinEditUseItmeToMonRate: TSpinEdit
          Left = 68
          Top = 16
          Width = 53
          Height = 21
          Hint = #21363#25915#20987#24618#21518#65292#19968#23450#26426#29575#35302#21457'QF'#33050#26412#27573'(@UseItmeToMon),'#20540#36234#23567#65292#26426#29575#36234#39640
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 4
          OnChange = SpinEditUseItmeToMonRateChange
        end
      end
      object ButtonWealthAnimalMonSave: TButton
        Left = 367
        Top = 271
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonWealthAnimalMonSaveClick
      end
      object GroupBox117: TGroupBox
        Left = 4
        Top = 3
        Width = 152
        Height = 46
        Caption = #29275#27668#27744#21319#32423#32463#39564#35774#32622
        TabOrder = 2
        object Label242: TLabel
          Left = 3
          Top = 21
          Width = 78
          Height = 12
          Caption = #21021#22987#21319#32423#32463#39564':'
        end
        object SpinEditCattleGasvalueLevelExp: TSpinEdit
          Left = 83
          Top = 17
          Width = 65
          Height = 21
          Hint = #21021#22987#21319#32423#25152#38656#32463#39564',1'#32423#21319#32423#32463#39564#20026#35774#32622#20540#65292'2'#32423#65292'3'#32423#65292'4'#32423#25353#31995#32479#31639#27861#24471#20986
          MaxValue = 20000000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 5000
          OnChange = SpinEditCattleGasvalueLevelExpChange
        end
      end
      object GroupBox118: TGroupBox
        Left = 5
        Top = 102
        Width = 140
        Height = 140
        Caption = #23500#36149#20861#28789#31526#30456#20851
        TabOrder = 3
        object Label150: TLabel
          Left = 11
          Top = 41
          Width = 54
          Height = 12
          Caption = #21021#22987#28789#31526':'
        end
        object Label240: TLabel
          Left = 7
          Top = 67
          Width = 66
          Height = 12
          Caption = #21463#25915#20987#22686#21152':'
        end
        object Label282: TLabel
          Left = 11
          Top = 92
          Width = 54
          Height = 12
          Caption = #29378#21270#26426#29575':'
        end
        object Label236: TLabel
          Left = 9
          Top = 116
          Width = 126
          Height = 12
          Caption = #29378#21270#26102#38271':          '#31186
        end
        object SpinEditMonGameGird: TSpinEdit
          Left = 73
          Top = 37
          Width = 60
          Height = 21
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 10
          OnChange = SpinEditMonGameGirdChange
        end
        object SpinEditIncMonGameGird: TSpinEdit
          Left = 73
          Top = 63
          Width = 61
          Height = 21
          Hint = #29378#26292#29366#24577#19979#65292#21463#25915#20987#65292#27599#27425#38543#26426#22686#21152#28789#31526#36175#37329#30340#19978#38480#25968#20540
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 1
          OnChange = SpinEditIncMonGameGirdChange
        end
        object CheckBoxShowSysHint: TCheckBox
          Left = 16
          Top = 18
          Width = 97
          Height = 17
          Caption = #32047#31215#28789#31526#25552#31034
          TabOrder = 2
          OnClick = CheckBoxShowSysHintClick
        end
        object SpinEditMon79CrazyRate: TSpinEdit
          Left = 73
          Top = 88
          Width = 61
          Height = 21
          Hint = #20540#36234#23567#65292#26426#29575#36234#39640
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 4
          OnChange = SpinEditMon79CrazyRateChange
        end
        object SpinEditMon79CrazyTime: TSpinEdit
          Left = 73
          Top = 112
          Width = 49
          Height = 21
          MaxValue = 4294967
          MinValue = 10
          TabOrder = 4
          Value = 10
          OnChange = SpinEditMon79CrazyTimeChange
        end
      end
      object GroupBox119: TGroupBox
        Left = 5
        Top = 248
        Width = 140
        Height = 43
        Caption = #25915#20987#24618#25152#24471#29275#27668#20540
        TabOrder = 4
        object Label239: TLabel
          Left = 11
          Top = 18
          Width = 42
          Height = 12
          Caption = #29275#27668#20540':'
        end
        object EditGetCattleGasvalue: TSpinEdit
          Left = 54
          Top = 14
          Width = 73
          Height = 21
          Hint = #27599#27425#25915#20987#23500#36149#20861#25152#24471#30340#29275#27668#20540
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 10
          OnChange = EditGetCattleGasvalueChange
        end
      end
      object GroupBox120: TGroupBox
        Left = 165
        Top = 3
        Width = 140
        Height = 101
        Caption = #33258#21160#24320#31665
        TabOrder = 5
        object Label241: TLabel
          Left = 11
          Top = 15
          Width = 60
          Height = 12
          Caption = '1'#32423#31665#23376'ID:'
        end
        object Label243: TLabel
          Left = 11
          Top = 37
          Width = 60
          Height = 12
          Caption = '2'#32423#31665#23376'ID:'
        end
        object Label244: TLabel
          Left = 11
          Top = 59
          Width = 60
          Height = 12
          Caption = '3'#32423#31665#23376'ID:'
        end
        object Label245: TLabel
          Left = 11
          Top = 81
          Width = 60
          Height = 12
          Caption = '4'#32423#31665#23376'ID:'
        end
        object SpinEditAutoOpenBoxID1: TSpinEdit
          Left = 82
          Top = 11
          Width = 47
          Height = 21
          Hint = 
            #29275#27668#27744#21319#33267'1'#32423#26102#65292#33258#21160#25171#24320#31665#23376#30340#32534#21495#65292'..Mir200\Envir\Boxs\'#19979#30340#31665#23376#37197#32622#25991#20214#13#10#22914#26377'1.txt,2.txt'#20004#20010 +
            #31665#23376#65292#21482#38656#35774#32622'1,'#21363#20026#25171#24320'1.txt'#30340#37197#32622
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 1
          OnChange = SpinEditAutoOpenBoxID1Change
        end
        object SpinEditAutoOpenBoxID2: TSpinEdit
          Left = 82
          Top = 33
          Width = 47
          Height = 21
          Hint = 
            #29275#27668#27744#21319#33267'2'#32423#26102#65292#33258#21160#25171#24320#31665#23376#30340#32534#21495#65292'..Mir200\Envir\Boxs\'#19979#30340#31665#23376#37197#32622#25991#20214#13#10#22914#26377'1.txt,2.txt'#20004#20010 +
            #31665#23376#65292#21482#38656#35774#32622'1,'#21363#20026#25171#24320'1.txt'#30340#37197#32622
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 1
          OnChange = SpinEditAutoOpenBoxID2Change
        end
        object SpinEditAutoOpenBoxID3: TSpinEdit
          Left = 82
          Top = 55
          Width = 47
          Height = 21
          Hint = 
            #29275#27668#27744#21319#33267'3'#32423#26102#65292#33258#21160#25171#24320#31665#23376#30340#32534#21495#65292'..Mir200\Envir\Boxs\'#19979#30340#31665#23376#37197#32622#25991#20214#13#10#22914#26377'1.txt,2.txt'#20004#20010 +
            #31665#23376#65292#21482#38656#35774#32622'1,'#21363#20026#25171#24320'1.txt'#30340#37197#32622
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 1
          OnChange = SpinEditAutoOpenBoxID3Change
        end
        object SpinEditAutoOpenBoxID4: TSpinEdit
          Left = 82
          Top = 77
          Width = 47
          Height = 21
          Hint = 
            #29275#27668#27744#21319#33267'4'#32423#26102#65292#33258#21160#25171#24320#31665#23376#30340#32534#21495#65292'..Mir200\Envir\Boxs\'#19979#30340#31665#23376#37197#32622#25991#20214#13#10#22914#26377'1.txt,2.txt'#20004#20010 +
            #31665#23376#65292#21482#38656#35774#32622'1,'#21363#20026#25171#24320'1.txt'#30340#37197#32622
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 1
          OnChange = SpinEditAutoOpenBoxID4Change
        end
      end
    end
    object TabSheet67: TTabSheet
      Caption = #37492#23453#31995#32479
      ImageIndex = 18
      object AddValuePageControl: TPageControl
        Left = 0
        Top = -1
        Width = 455
        Height = 283
        ActivePage = TabSheet98
        MultiLine = True
        TabOrder = 0
        TabPosition = tpBottom
        object TabSheet69: TTabSheet
          Caption = #26426#29575#25511#21046
          object Label525: TLabel
            Left = 2
            Top = 43
            Width = 156
            Height = 12
            Caption = #31934#21147#20540#22686#21152#38388#38548':         '#31186
          end
          object GroupBox164: TGroupBox
            Left = 9
            Top = 64
            Width = 122
            Height = 74
            Caption = #31070#31192#23646#24615
            TabOrder = 0
            object Label340: TLabel
              Left = 15
              Top = 15
              Width = 54
              Height = 12
              Hint = #26368#39640#21487#20197#22686#21152#30340#31070#31192#23646#24615#20010#25968
              Caption = #26368#39640#28857#25968':'
            end
            object Label372: TLabel
              Left = 15
              Top = 34
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label375: TLabel
              Left = 15
              Top = 54
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMysteryAddValueMaxLimit: TSpinEdit
              Left = 68
              Top = 11
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 4
              MinValue = 1
              TabOrder = 0
              Value = 4
              OnChange = EditMysteryAddValueMaxLimitChange
            end
            object EditMysteryAddValueRate: TSpinEdit
              Left = 68
              Top = 30
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMysteryAddValueRateChange
            end
            object EditMysteryAddRate: TSpinEdit
              Left = 69
              Top = 50
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMysteryAddRateChange
            end
          end
          object GroupBox166: TGroupBox
            Left = 283
            Top = 0
            Width = 116
            Height = 156
            Caption = #35299#35835#31070#31192#25216#33021#26426#29575
            TabOrder = 1
            object Label377: TLabel
              Left = 6
              Top = 17
              Width = 54
              Height = 12
              Caption = #37325#29983#25216#33021':'
            end
            object Label381: TLabel
              Left = 6
              Top = 37
              Width = 54
              Height = 12
              Caption = #20843#21350#25252#36523':'
            end
            object Label382: TLabel
              Left = 6
              Top = 57
              Width = 54
              Height = 12
              Caption = #40635#30201#25216#33021':'
            end
            object Label383: TLabel
              Left = 6
              Top = 77
              Width = 54
              Height = 12
              Caption = #39764#36947#40635#30201':'
            end
            object Label388: TLabel
              Left = 6
              Top = 97
              Width = 54
              Height = 12
              Caption = #25112#24847#40635#30201':'
            end
            object Label391: TLabel
              Left = 6
              Top = 117
              Width = 54
              Height = 12
              Caption = #25506#27979#25216#33021':'
            end
            object Label392: TLabel
              Left = 6
              Top = 138
              Width = 54
              Height = 12
              Caption = #20256#36865#25216#33021':'
            end
            object EditRebirthRate: TSpinEdit
              Left = 62
              Top = 14
              Width = 51
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290#13#10#35774#32622'65535'#34920#31034#20851#38381#27492#23646#24615
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRebirthRateChange
            end
            object EditMagicShieldRate: TSpinEdit
              Left = 62
              Top = 34
              Width = 51
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290#13#10#35774#32622'65535'#34920#31034#20851#38381#27492#23646#24615
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMagicShieldRateChange
            end
            object EditParalysisRate: TSpinEdit
              Left = 62
              Top = 54
              Width = 51
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290#13#10#35774#32622'65535'#34920#31034#20851#38381#27492#23646#24615
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditParalysisRateChange
            end
            object EditParalysis2Rate: TSpinEdit
              Left = 62
              Top = 74
              Width = 51
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290#13#10#35774#32622'65535'#34920#31034#20851#38381#27492#23646#24615
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 3
              Value = 100
              OnChange = EditParalysis2RateChange
            end
            object EditParalysis1Rate: TSpinEdit
              Left = 62
              Top = 95
              Width = 51
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290#13#10#35774#32622'65535'#34920#31034#20851#38381#27492#23646#24615
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 4
              Value = 100
              OnChange = EditParalysis1RateChange
            end
            object EditProbeNecklaceRate: TSpinEdit
              Left = 61
              Top = 114
              Width = 51
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290#13#10#35774#32622'65535'#34920#31034#20851#38381#27492#23646#24615
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 5
              Value = 100
              OnChange = EditProbeNecklaceRateChange
            end
            object EditTeleportRate: TSpinEdit
              Left = 62
              Top = 133
              Width = 51
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290#13#10#35774#32622'65535'#34920#31034#20851#38381#27492#23646#24615
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 6
              Value = 100
              OnChange = EditTeleportRateChange
            end
          end
          object GroupBox169: TGroupBox
            Left = 158
            Top = 0
            Width = 115
            Height = 100
            Caption = #31070#31192#23646#24615#35299#35835
            TabOrder = 2
            object Label421: TLabel
              Left = 4
              Top = 17
              Width = 66
              Height = 12
              Caption = #23646#24615#19968#26426#29575':'
            end
            object Label430: TLabel
              Left = 4
              Top = 38
              Width = 66
              Height = 12
              Caption = #23646#24615#20108#26426#29575':'
            end
            object Label431: TLabel
              Left = 4
              Top = 58
              Width = 66
              Height = 12
              Caption = #23646#24615#19977#26426#29575':'
            end
            object Label432: TLabel
              Left = 5
              Top = 79
              Width = 66
              Height = 12
              Caption = #23646#24615#22235#26426#29575':'
            end
            object EditReadRate1: TSpinEdit
              Left = 65
              Top = 12
              Width = 47
              Height = 21
              Hint = #25104#21151#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21487#20197#25191#34892#13#10#21508#23646#24615#30340#26426#29575#21028#26029','#13#10'('#27492#25968#20540#65293#31070#31192#21367#36724#29087#32451#24230')'#20877#36827#34892#26426#29575#21028#26029
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditReadRate1Change
            end
            object EditReadRate2: TSpinEdit
              Left = 65
              Top = 33
              Width = 47
              Height = 21
              Hint = #25104#21151#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21487#20197#25191#34892#13#10#21508#23646#24615#30340#26426#29575#21028#26029','#13#10'('#27492#25968#20540#65293#31070#31192#21367#36724#29087#32451#24230')'#20877#36827#34892#26426#29575#21028#26029
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditReadRate2Change
            end
            object EditReadRate3: TSpinEdit
              Left = 65
              Top = 54
              Width = 47
              Height = 21
              Hint = #25104#21151#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21487#20197#25191#34892#13#10#21508#23646#24615#30340#26426#29575#21028#26029','#13#10'('#27492#25968#20540#65293#31070#31192#21367#36724#29087#32451#24230')'#20877#36827#34892#26426#29575#21028#26029
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditReadRate3Change
            end
            object EditReadRate4: TSpinEdit
              Left = 65
              Top = 74
              Width = 47
              Height = 21
              Hint = #25104#21151#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21487#20197#25191#34892#13#10#21508#23646#24615#30340#26426#29575#21028#26029','#13#10'('#27492#25968#20540#65293#31070#31192#21367#36724#29087#32451#24230')'#20877#36827#34892#26426#29575#21028#26029
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 3
              Value = 100
              OnChange = EditReadRate4Change
            end
          end
          object GroupBox178: TGroupBox
            Left = 157
            Top = 105
            Width = 115
            Height = 97
            Caption = #21046#20316#31070#31192#21367#36724#26426#29575
            TabOrder = 3
            object Label393: TLabel
              Left = 9
              Top = 19
              Width = 54
              Height = 12
              Caption = #19968#32423#21367#36724':'
            end
            object Label420: TLabel
              Left = 11
              Top = 39
              Width = 54
              Height = 12
              Caption = #20108#32423#21367#36724':'
            end
            object Label422: TLabel
              Left = 11
              Top = 56
              Width = 54
              Height = 12
              Caption = #19977#32423#21367#36724':'
            end
            object Label429: TLabel
              Left = 12
              Top = 77
              Width = 54
              Height = 12
              Caption = #22235#32423#21367#36724':'
            end
            object EditMakeScroll1Rate: TSpinEdit
              Left = 63
              Top = 15
              Width = 47
              Height = 21
              Hint = #25104#21151#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#13#10#21516#26102#21463#24184#36816#20540#21644#31070#31192#35299#35835#25216#33021#31561#32423#24433#21709
              EditorEnabled = False
              MaxValue = 255
              MinValue = 9
              TabOrder = 0
              Value = 100
              OnChange = EditMakeScroll1RateChange
            end
            object EditMakeScroll2Rate: TSpinEdit
              Left = 62
              Top = 35
              Width = 47
              Height = 21
              Hint = #25104#21151#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#13#10#21516#26102#21463#24184#36816#20540#21644#31070#31192#35299#35835#25216#33021#31561#32423#24433#21709
              EditorEnabled = False
              MaxValue = 255
              MinValue = 13
              TabOrder = 1
              Value = 100
              OnChange = EditMakeScroll2RateChange
            end
            object EditMakeScroll3Rate: TSpinEdit
              Left = 62
              Top = 52
              Width = 47
              Height = 21
              Hint = #25104#21151#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#13#10#21516#26102#21463#24184#36816#20540#21644#31070#31192#35299#35835#25216#33021#31561#32423#24433#21709
              EditorEnabled = False
              MaxValue = 255
              MinValue = 17
              TabOrder = 2
              Value = 100
              OnChange = EditMakeScroll3RateChange
            end
            object EditMakeScroll4Rate: TSpinEdit
              Left = 62
              Top = 72
              Width = 47
              Height = 21
              Hint = #25104#21151#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#13#10#21516#26102#21463#24184#36816#20540#21644#31070#31192#35299#35835#25216#33021#31561#32423#24433#21709
              EditorEnabled = False
              MaxValue = 255
              MinValue = 22
              TabOrder = 3
              Value = 100
              OnChange = EditMakeScroll4RateChange
            end
          end
          object GroupBox181: TGroupBox
            Left = 283
            Top = 157
            Width = 119
            Height = 55
            Caption = #23453#29289#28789#23186#23646#24615
            TabOrder = 4
            object Label434: TLabel
              Left = 10
              Top = 18
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label435: TLabel
              Left = 10
              Top = 36
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditSpiritMediaAddValueRate: TSpinEdit
              Left = 65
              Top = 12
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditSpiritMediaAddValueRateChange
            end
            object EditSpiritMediaAddRate: TSpinEdit
              Left = 65
              Top = 32
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditSpiritMediaAddRateChange
            end
          end
          object GroupBox182: TGroupBox
            Left = 8
            Top = 141
            Width = 120
            Height = 56
            Caption = #21697#35780
            TabOrder = 5
            object Label433: TLabel
              Left = 6
              Top = 36
              Width = 30
              Height = 12
              Caption = #20215#26684':'
            end
            object EditJudgePrice: TSpinEdit
              Left = 36
              Top = 31
              Width = 81
              Height = 21
              Hint = #21697#35780#29289#21697#25152#38656#30340#20215#26684
              MaxValue = 2147483647
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditJudgePriceChange
            end
            object RadioButtonJudgeGameGold: TRadioButton
              Left = 12
              Top = 14
              Width = 42
              Height = 17
              Caption = #20803#23453
              TabOrder = 1
              OnClick = RadioButtonJudgeGameGoldClick
            end
            object RadioButtonJudgeUseGold: TRadioButton
              Left = 71
              Top = 14
              Width = 43
              Height = 17
              Caption = #37329#24065
              Checked = True
              TabOrder = 2
              TabStop = True
              OnClick = RadioButtonJudgeUseGoldClick
            end
          end
          object EditEnergyValueTime: TSpinEdit
            Left = 87
            Top = 39
            Width = 57
            Height = 21
            MaxValue = 65535
            MinValue = 10
            TabOrder = 6
            Value = 100
            OnChange = EditEnergyValueTimeChange
          end
          object CheckBoxOffLineEnergy: TCheckBox
            Left = 8
            Top = 23
            Width = 128
            Height = 16
            Hint = #36873#20013#35813#39033#21518#65292#20154#29289#25346#26426#26102#21017#19981#22686#21152#31934#21147#20540
            Caption = #31105#27490#25346#26426#22686#21152#31934#21147#20540
            TabOrder = 7
            OnClick = CheckBoxOffLineEnergyClick
          end
          object CheckBoxUseCanKamPo: TCheckBox
            Left = 9
            Top = 2
            Width = 117
            Height = 17
            Hint = #21435#25481#27492#36873#39033#65292#21017#26080#27861#20351#29992#37492#23450#25366#23453#31995#32479
            Caption = #24320#25918#37492#23450#25366#23453#31995#32479
            TabOrder = 8
            OnClick = CheckBoxUseCanKamPoClick
          end
        end
        object TabSheet70: TTabSheet
          Caption = #27494#22120#31867
          ImageIndex = 1
          object Label474: TLabel
            Left = 5
            Top = 224
            Width = 222
            Height = 12
            Caption = #27494#22120#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 5 '#25110' 6'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox145: TGroupBox
            Left = 3
            Top = 0
            Width = 102
            Height = 71
            Caption = #25915#20987#19978#38480
            TabOrder = 0
            object Label315: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label316: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label317: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsDCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsDCAddValueMaxLimitChange
            end
            object EditArmsDCAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsDCAddValueRateChange
            end
            object EditArmsDCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsDCAddRateChange
            end
          end
          object GroupBox146: TGroupBox
            Left = 116
            Top = 0
            Width = 102
            Height = 71
            Caption = #39764#27861#19978#38480
            TabOrder = 1
            object Label314: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label318: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label319: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsMCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsMCAddValueMaxLimitChange
            end
            object EditArmsMCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsMCAddValueRateChange
            end
            object EditArmsMCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsMCAddRateChange
            end
          end
          object GroupBox147: TGroupBox
            Left = 228
            Top = 0
            Width = 102
            Height = 71
            Caption = #36947#26415#19978#38480
            TabOrder = 2
            object Label320: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label321: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label322: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsSCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsSCAddValueMaxLimitChange
            end
            object EditArmsSCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsSCAddValueRateChange
            end
            object EditArmsSCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsSCAddRateChange
            end
          end
          object GroupBox186: TGroupBox
            Left = 342
            Top = 0
            Width = 102
            Height = 71
            Caption = #20027#23646#24615
            TabOrder = 3
            object Label323: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label448: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label449: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsMainAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 5
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsMainAddValueMaxLimitChange
            end
            object EditArmsMainAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsMainAddValueRateChange
            end
            object EditArmsMainAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsMainAddRateChange
            end
          end
          object GroupBox187: TGroupBox
            Left = 4
            Top = 75
            Width = 102
            Height = 71
            Caption = #24378#36523#31561#32423
            TabOrder = 4
            object Label450: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label451: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label452: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsQSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsQSAddValueMaxLimitChange
            end
            object EditArmsQSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsQSAddValueRateChange
            end
            object EditArmsQSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsQSAddRateChange
            end
          end
          object GroupBox188: TGroupBox
            Left = 119
            Top = 76
            Width = 102
            Height = 71
            Caption = #32858#39764#31561#32423
            TabOrder = 5
            object Label453: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label454: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label455: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsJMAddValueMaxLimit: TSpinEdit
              Left = 56
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsJMAddValueMaxLimitChange
            end
            object EditArmsJMAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsJMAddValueRateChange
            end
            object EditArmsJMAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsJMAddRateChange
            end
          end
          object GroupBox189: TGroupBox
            Left = 229
            Top = 75
            Width = 102
            Height = 71
            Caption = #20869#20260#31561#32423
            TabOrder = 6
            object Label456: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label457: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label458: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsNSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsNSAddValueMaxLimitChange
            end
            object EditArmsNSAddValueRate: TSpinEdit
              Left = 58
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsNSAddValueRateChange
            end
            object EditArmsNSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsNSAddRateChange
            end
          end
          object GroupBox190: TGroupBox
            Left = 341
            Top = 75
            Width = 102
            Height = 71
            Caption = #26292#20987#31561#32423
            TabOrder = 7
            object Label459: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label460: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label461: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsBJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsBJAddValueMaxLimitChange
            end
            object EditArmsBJAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsBJAddValueRateChange
            end
            object EditArmsBJAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsBJAddRateChange
            end
          end
          object GroupBox191: TGroupBox
            Left = 3
            Top = 149
            Width = 102
            Height = 71
            Caption = #21512#20987#23041#21147
            TabOrder = 8
            object Label462: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label463: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label464: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsHJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 50
              MinValue = 1
              TabOrder = 0
              Value = 50
              OnChange = EditArmsHJAddValueMaxLimitChange
            end
            object EditArmsHJAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsHJAddValueRateChange
            end
            object EditArmsHJAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsHJAddRateChange
            end
          end
          object GroupBox192: TGroupBox
            Left = 118
            Top = 149
            Width = 102
            Height = 71
            Caption = #40635#30201#25239#24615
            TabOrder = 9
            object Label465: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label466: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label467: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsMBAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 20
              OnChange = EditArmsMBAddValueMaxLimitChange
            end
            object EditArmsMBAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsMBAddValueRateChange
            end
            object EditArmsMBAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsMBAddRateChange
            end
          end
          object GroupBox193: TGroupBox
            Left = 229
            Top = 149
            Width = 102
            Height = 71
            Caption = #38450#29190
            TabOrder = 10
            object Label468: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label469: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label470: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsFBAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsFBAddValueMaxLimitChange
            end
            object EditArmsFBAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsFBAddValueRateChange
            end
            object EditArmsFBAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsFBAddRateChange
            end
          end
          object GroupBox194: TGroupBox
            Left = 342
            Top = 149
            Width = 102
            Height = 71
            Caption = #20934#30830
            TabOrder = 11
            object Label471: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label472: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label473: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmsZQAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditArmsZQAddValueMaxLimitChange
            end
            object EditArmsZQAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmsZQAddValueRateChange
            end
            object EditArmsZQAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmsZQAddRateChange
            end
          end
        end
        object TabSheet71: TTabSheet
          Caption = #34915#26381#31867
          ImageIndex = 2
          object Label324: TLabel
            Left = 5
            Top = 224
            Width = 234
            Height = 12
            Caption = #34915#26381#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 10 '#25110' 11'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox148: TGroupBox
            Left = 3
            Top = 0
            Width = 102
            Height = 71
            Caption = #25915#20987#19978#38480
            TabOrder = 0
            object Label325: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label326: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label327: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressDCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressDCAddValueMaxLimitChange
            end
            object EditDressDCAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressDCAddValueRateChange
            end
            object EditDressDCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressDCAddRateChange
            end
          end
          object GroupBox149: TGroupBox
            Left = 116
            Top = 0
            Width = 102
            Height = 71
            Caption = #39764#27861#19978#38480
            TabOrder = 1
            object Label328: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label329: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label330: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressMCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressMCAddValueMaxLimitChange
            end
            object EditDressMCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressMCAddValueRateChange
            end
            object EditDressMCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressMCAddRateChange
            end
          end
          object GroupBox150: TGroupBox
            Left = 228
            Top = 0
            Width = 102
            Height = 71
            Caption = #36947#26415#19978#38480
            TabOrder = 2
            object Label331: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label332: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label333: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressSCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressSCAddValueMaxLimitChange
            end
            object EditDressSCAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressSCAddValueRateChange
            end
            object EditDressSCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressSCAddRateChange
            end
          end
          object GroupBox151: TGroupBox
            Left = 342
            Top = 0
            Width = 102
            Height = 71
            Caption = #20027#23646#24615
            TabOrder = 3
            object Label334: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label335: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label336: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressMainAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 5
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressMainAddValueMaxLimitChange
            end
            object EditDressMainAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressMainAddValueRateChange
            end
            object EditDressMainAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressMainAddRateChange
            end
          end
          object GroupBox152: TGroupBox
            Left = 4
            Top = 75
            Width = 102
            Height = 71
            Caption = #24378#36523#31561#32423
            TabOrder = 4
            object Label337: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label338: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label339: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressQSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressQSAddValueMaxLimitChange
            end
            object EditDressQSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressQSAddValueRateChange
            end
            object EditDressQSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressQSAddRateChange
            end
          end
          object GroupBox153: TGroupBox
            Left = 119
            Top = 76
            Width = 102
            Height = 71
            Caption = #32858#39764#31561#32423
            TabOrder = 5
            object Label341: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label342: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label343: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressJMAddValueMaxLimit: TSpinEdit
              Left = 56
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressJMAddValueMaxLimitChange
            end
            object EditDressJMAddValueRate: TSpinEdit
              Left = 57
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressJMAddValueRateChange
            end
            object EditDressJMAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressJMAddRateChange
            end
          end
          object GroupBox154: TGroupBox
            Left = 229
            Top = 75
            Width = 102
            Height = 71
            Caption = #21560#34880#19978#38480
            TabOrder = 6
            object Label344: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label345: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label346: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressXXAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressXXAddValueMaxLimitChange
            end
            object EditDressXXAddValueRate: TSpinEdit
              Left = 58
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressXXAddValueRateChange
            end
            object EditDressXXAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressXXAddRateChange
            end
          end
          object GroupBox155: TGroupBox
            Left = 341
            Top = 75
            Width = 102
            Height = 71
            Caption = #26292#20987#31561#32423
            TabOrder = 7
            object Label347: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label348: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label349: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressBJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressBJAddValueMaxLimitChange
            end
            object EditDressBJAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressBJAddValueRateChange
            end
            object EditDressBJAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressBJAddRateChange
            end
          end
          object GroupBox156: TGroupBox
            Left = 3
            Top = 149
            Width = 102
            Height = 71
            Caption = #21512#20987#23041#21147
            TabOrder = 8
            object Label350: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label351: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label352: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressHJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 50
              MinValue = 1
              TabOrder = 0
              Value = 50
              OnChange = EditDressHJAddValueMaxLimitChange
            end
            object EditDressHJAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressHJAddValueRateChange
            end
            object EditDressHJAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressHJAddRateChange
            end
          end
          object GroupBox157: TGroupBox
            Left = 118
            Top = 149
            Width = 102
            Height = 71
            Caption = #40635#30201#25239#24615
            TabOrder = 9
            object Label353: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label354: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label355: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressMBAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 20
              OnChange = EditDressMBAddValueMaxLimitChange
            end
            object EditDressMBAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressMBAddValueRateChange
            end
            object EditDressMBAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressMBAddRateChange
            end
          end
          object GroupBox158: TGroupBox
            Left = 229
            Top = 149
            Width = 102
            Height = 71
            Caption = #20869#21147#24674#22797
            TabOrder = 10
            object Label356: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label357: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label358: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressNLAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 6
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressNLAddValueMaxLimitChange
            end
            object EditDressNLAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressNLAddValueRateChange
            end
            object EditDressNLAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressNLAddRateChange
            end
          end
          object GroupBox159: TGroupBox
            Left = 342
            Top = 149
            Width = 102
            Height = 71
            Caption = #29289#38450#19978#38480
            TabOrder = 11
            object Label359: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label360: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label361: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressWFAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditDressWFAddValueMaxLimitChange
            end
            object EditDressWFAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressWFAddValueRateChange
            end
            object EditDressWFAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressWFAddRateChange
            end
          end
        end
        object TabSheet73: TTabSheet
          Caption = #39033#38142#31867
          ImageIndex = 3
          object GroupBox160: TGroupBox
            Left = 3
            Top = 0
            Width = 102
            Height = 71
            Caption = #25915#20987#19978#38480
            TabOrder = 0
            object Label362: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label363: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label364: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceDCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditNecklaceDCAddValueMaxLimitChange
            end
            object EditNecklaceDCAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceDCAddValueRateChange
            end
            object EditNecklaceDCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceDCAddRateChange
            end
          end
          object GroupBox161: TGroupBox
            Left = 116
            Top = 0
            Width = 102
            Height = 71
            Caption = #39764#27861#19978#38480
            TabOrder = 1
            object Label365: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label366: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label367: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceMCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditNecklaceMCAddValueMaxLimitChange
            end
            object EditNecklaceMCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceMCAddValueRateChange
            end
            object EditNecklaceMCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceMCAddRateChange
            end
          end
          object GroupBox162: TGroupBox
            Left = 228
            Top = 0
            Width = 102
            Height = 71
            Caption = #36947#26415#19978#38480
            TabOrder = 2
            object Label368: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label369: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label370: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceSCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditNecklaceSCAddValueMaxLimitChange
            end
            object EditNecklaceSCAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceSCAddValueRateChange
            end
            object EditNecklaceSCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceSCAddRateChange
            end
          end
          object GroupBox163: TGroupBox
            Left = 342
            Top = 0
            Width = 102
            Height = 71
            Caption = #20027#23646#24615
            TabOrder = 3
            object Label371: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label373: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label374: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceMainAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 5
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditNecklaceMainAddValueMaxLimitChange
            end
            object EditNecklaceMainAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceMainAddValueRateChange
            end
            object EditNecklaceMainAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceMainAddRateChange
            end
          end
          object GroupBox165: TGroupBox
            Left = 117
            Top = 75
            Width = 102
            Height = 71
            Caption = #21560#34880#19978#38480
            TabOrder = 4
            object Label378: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label379: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label380: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceXXAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditNecklaceXXAddValueMaxLimitChange
            end
            object EditNecklaceXXAddValueRate: TSpinEdit
              Left = 58
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceXXAddValueRateChange
            end
            object EditNecklaceXXAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceXXAddRateChange
            end
          end
          object GroupBox167: TGroupBox
            Left = 4
            Top = 75
            Width = 102
            Height = 71
            Caption = #24378#36523#31561#32423
            TabOrder = 5
            object Label384: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label385: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label386: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceQSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditNecklaceQSAddValueMaxLimitChange
            end
            object EditNecklaceQSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceQSAddValueRateChange
            end
            object EditNecklaceQSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceQSAddRateChange
            end
          end
          object GroupBox168: TGroupBox
            Left = 3
            Top = 149
            Width = 102
            Height = 71
            Caption = #21512#20987#23041#21147
            TabOrder = 6
            object Label387: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label389: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label390: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceHJAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 50
              MinValue = 1
              TabOrder = 0
              Value = 50
              OnChange = EditNecklaceHJAddValueMaxLimitChange
            end
            object EditNecklaceHJAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceHJAddValueRateChange
            end
            object EditNecklaceHJAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceHJAddRateChange
            end
          end
          object GroupBox170: TGroupBox
            Left = 228
            Top = 76
            Width = 102
            Height = 71
            Caption = #20869#21147#24674#22797
            TabOrder = 7
            object Label394: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label395: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label396: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceNLAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 6
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditNecklaceNLAddValueMaxLimitChange
            end
            object EditNecklaceNLAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceNLAddValueRateChange
            end
            object EditNecklaceNLAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceNLAddRateChange
            end
          end
          object GroupBox171: TGroupBox
            Left = 341
            Top = 76
            Width = 102
            Height = 71
            Caption = #39764#38450#19978#38480
            TabOrder = 8
            object Label397: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label398: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label399: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNecklaceMFAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditNecklaceMFAddValueMaxLimitChange
            end
            object EditNecklaceMFAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNecklaceMFAddValueRateChange
            end
            object EditNecklaceMFAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNecklaceMFAddRateChange
            end
          end
        end
        object TabSheet75: TTabSheet
          Caption = #25163#38255#31867
          ImageIndex = 5
          object GroupBox172: TGroupBox
            Left = 3
            Top = 0
            Width = 102
            Height = 71
            Caption = #25915#20987#19978#38480
            TabOrder = 0
            object Label400: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label401: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label402: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletDCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditBraceletDCAddValueMaxLimitChange
            end
            object EditBraceletDCAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletDCAddValueRateChange
            end
            object EditBraceletDCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletDCAddRateChange
            end
          end
          object GroupBox173: TGroupBox
            Left = 116
            Top = 0
            Width = 102
            Height = 71
            Caption = #39764#27861#19978#38480
            TabOrder = 1
            object Label403: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label404: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label405: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletMCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditBraceletMCAddValueMaxLimitChange
            end
            object EditBraceletMCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletMCAddValueRateChange
            end
            object EditBraceletMCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletMCAddRateChange
            end
          end
          object GroupBox174: TGroupBox
            Left = 228
            Top = 0
            Width = 102
            Height = 71
            Caption = #36947#26415#19978#38480
            TabOrder = 2
            object Label406: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label407: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label408: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletSCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditBraceletSCAddValueMaxLimitChange
            end
            object EditBraceletSCAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletSCAddValueRateChange
            end
            object EditBraceletSCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletSCAddRateChange
            end
          end
          object GroupBox175: TGroupBox
            Left = 342
            Top = 0
            Width = 102
            Height = 71
            Caption = #20027#23646#24615
            TabOrder = 3
            object Label409: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label410: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label411: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletMainAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 8
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditBraceletMainAddValueMaxLimitChange
            end
            object EditBraceletMainAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletMainAddValueRateChange
            end
            object EditBraceletMainAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletMainAddRateChange
            end
          end
          object GroupBox176: TGroupBox
            Left = 4
            Top = 75
            Width = 102
            Height = 71
            Caption = #24378#36523#31561#32423
            TabOrder = 4
            object Label412: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label413: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label416: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletQSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditBraceletQSAddValueMaxLimitChange
            end
            object EditBraceletQSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletQSAddValueRateChange
            end
            object EditBraceletQSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletQSAddRateChange
            end
          end
          object GroupBox177: TGroupBox
            Left = 116
            Top = 75
            Width = 102
            Height = 71
            Caption = #21560#34880#19978#38480
            TabOrder = 5
            object Label417: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label418: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label419: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletXXAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditBraceletXXAddValueMaxLimitChange
            end
            object EditBraceletXXAddValueRate: TSpinEdit
              Left = 58
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletXXAddValueRateChange
            end
            object EditBraceletXXAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletXXAddRateChange
            end
          end
          object GroupBox179: TGroupBox
            Left = 341
            Top = 75
            Width = 102
            Height = 71
            Caption = #39764#38450#19978#38480
            TabOrder = 6
            object Label423: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label424: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label425: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletMFAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditBraceletMFAddValueMaxLimitChange
            end
            object EditBraceletMFAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletMFAddValueRateChange
            end
            object EditBraceletMFAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletMFAddRateChange
            end
          end
          object GroupBox180: TGroupBox
            Left = 228
            Top = 75
            Width = 102
            Height = 71
            Caption = #20869#21147#24674#22797
            TabOrder = 7
            object Label426: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label427: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label428: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletNLAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 6
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditBraceletNLAddValueMaxLimitChange
            end
            object EditBraceletNLAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletNLAddValueRateChange
            end
            object EditBraceletNLAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletNLAddRateChange
            end
          end
          object GroupBox183: TGroupBox
            Left = 3
            Top = 149
            Width = 102
            Height = 71
            Caption = #21512#20987#23041#21147
            TabOrder = 8
            object Label437: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label438: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label439: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBraceletHJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 50
              MinValue = 1
              TabOrder = 0
              Value = 50
              OnChange = EditBraceletHJAddValueMaxLimitChange
            end
            object EditBraceletHJAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBraceletHJAddValueRateChange
            end
            object EditBraceletHJAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBraceletHJAddRateChange
            end
          end
        end
        object TabSheet76: TTabSheet
          Caption = #25106#25351#31867
          ImageIndex = 6
          object GroupBox184: TGroupBox
            Left = 3
            Top = 0
            Width = 102
            Height = 71
            Caption = #25915#20987#19978#38480
            TabOrder = 0
            object Label440: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label441: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label442: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingDCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingDCAddValueMaxLimitChange
            end
            object EditRingDCAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingDCAddValueRateChange
            end
            object EditRingDCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingDCAddRateChange
            end
          end
          object GroupBox185: TGroupBox
            Left = 116
            Top = 0
            Width = 102
            Height = 71
            Caption = #39764#27861#19978#38480
            TabOrder = 1
            object Label443: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label444: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label445: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingMCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 5
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingMCAddValueMaxLimitChange
            end
            object EditRingMCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingMCAddValueRateChange
            end
            object EditRingMCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingMCAddRateChange
            end
          end
          object GroupBox195: TGroupBox
            Left = 228
            Top = 0
            Width = 102
            Height = 71
            Caption = #36947#26415#19978#38480
            TabOrder = 2
            object Label446: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label447: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label475: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingSCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingSCAddValueMaxLimitChange
            end
            object EditRingSCAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingSCAddValueRateChange
            end
            object EditRingSCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingSCAddRateChange
            end
          end
          object GroupBox196: TGroupBox
            Left = 342
            Top = 0
            Width = 102
            Height = 71
            Caption = #20027#23646#24615
            TabOrder = 3
            object Label476: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label477: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label478: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingMainAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 5
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingMainAddValueMaxLimitChange
            end
            object EditRingMainAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingMainAddValueRateChange
            end
            object EditRingMainAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingMainAddRateChange
            end
          end
          object GroupBox197: TGroupBox
            Left = 4
            Top = 75
            Width = 102
            Height = 71
            Caption = #24378#36523#31561#32423
            TabOrder = 4
            object Label479: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label480: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label481: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingQSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingQSAddValueMaxLimitChange
            end
            object EditRingQSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingQSAddValueRateChange
            end
            object EditRingQSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingQSAddRateChange
            end
          end
          object GroupBox198: TGroupBox
            Left = 229
            Top = 75
            Width = 102
            Height = 71
            Caption = #21560#34880#19978#38480
            TabOrder = 5
            object Label482: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label483: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label484: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingXXAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingXXAddValueMaxLimitChange
            end
            object EditRingXXAddValueRate: TSpinEdit
              Left = 58
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingXXAddValueRateChange
            end
            object EditRingXXAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingXXAddRateChange
            end
          end
          object GroupBox199: TGroupBox
            Left = 341
            Top = 75
            Width = 102
            Height = 71
            Caption = #38450#29190
            TabOrder = 6
            object Label485: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label486: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label487: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingFBAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingFBAddValueMaxLimitChange
            end
            object EditRingFBAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingFBAddValueRateChange
            end
            object EditRingFBAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingFBAddRateChange
            end
          end
          object GroupBox200: TGroupBox
            Left = 342
            Top = 149
            Width = 102
            Height = 71
            Caption = #29289#38450#19978#38480
            TabOrder = 7
            object Label488: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label489: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label490: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingWFAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingWFAddValueMaxLimitChange
            end
            object EditRingWFAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingWFAddValueRateChange
            end
            object EditRingWFAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingWFAddRateChange
            end
          end
          object GroupBox201: TGroupBox
            Left = 229
            Top = 149
            Width = 102
            Height = 71
            Caption = #20869#21147#24674#22797
            TabOrder = 8
            object Label491: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label492: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label493: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingNLAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 6
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingNLAddValueMaxLimitChange
            end
            object EditRingNLAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingNLAddValueRateChange
            end
            object EditRingNLAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingNLAddRateChange
            end
          end
          object GroupBox202: TGroupBox
            Left = 118
            Top = 149
            Width = 102
            Height = 71
            Caption = #40635#30201#25239#24615
            TabOrder = 9
            object Label494: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label495: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label496: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingMBAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 20
              OnChange = EditRingMBAddValueMaxLimitChange
            end
            object EditRingMBAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingMBAddValueRateChange
            end
            object EditRingMBAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingMBAddRateChange
            end
          end
          object GroupBox203: TGroupBox
            Left = 119
            Top = 76
            Width = 102
            Height = 71
            Caption = #32858#39764#31561#32423
            TabOrder = 10
            object Label497: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label498: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label499: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingJMAddValueMaxLimit: TSpinEdit
              Left = 56
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditRingJMAddValueMaxLimitChange
            end
            object EditRingJMAddValueRate: TSpinEdit
              Left = 57
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingJMAddValueRateChange
            end
            object EditRingJMAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingJMAddRateChange
            end
          end
          object GroupBox204: TGroupBox
            Left = 3
            Top = 149
            Width = 102
            Height = 71
            Caption = #21512#20987#23041#21147
            TabOrder = 11
            object Label500: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label501: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label502: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRingHJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 50
              MinValue = 1
              TabOrder = 0
              Value = 50
              OnChange = EditRingHJAddValueMaxLimitChange
            end
            object EditRingHJAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRingHJAddValueRateChange
            end
            object EditRingHJAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRingHJAddRateChange
            end
          end
        end
        object TabSheet78: TTabSheet
          Caption = #22836#30420#12289#26007#31520#31867
          ImageIndex = 8
          object Label414: TLabel
            Left = 12
            Top = 226
            Width = 198
            Height = 12
            Caption = #22836#30420#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 15'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label415: TLabel
            Left = 233
            Top = 227
            Width = 198
            Height = 12
            Caption = #26007#31520#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 16'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox205: TGroupBox
            Left = 3
            Top = 0
            Width = 102
            Height = 71
            Caption = #25915#20987#19978#38480
            TabOrder = 0
            object Label503: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label504: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label505: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetDCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditHelmetDCAddValueMaxLimitChange
            end
            object EditHelmetDCAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetDCAddValueRateChange
            end
            object EditHelmetDCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetDCAddRateChange
            end
          end
          object GroupBox206: TGroupBox
            Left = 116
            Top = 0
            Width = 102
            Height = 71
            Caption = #39764#27861#19978#38480
            TabOrder = 1
            object Label506: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label507: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label508: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetMCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditHelmetMCAddValueMaxLimitChange
            end
            object EditHelmetMCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetMCAddValueRateChange
            end
            object EditHelmetMCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetMCAddRateChange
            end
          end
          object GroupBox207: TGroupBox
            Left = 228
            Top = 0
            Width = 102
            Height = 71
            Caption = #36947#26415#19978#38480
            TabOrder = 2
            object Label509: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label510: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label511: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetSCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditHelmetSCAddValueMaxLimitChange
            end
            object EditHelmetSCAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetSCAddValueRateChange
            end
            object EditHelmetSCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetSCAddRateChange
            end
          end
          object GroupBox208: TGroupBox
            Left = 342
            Top = 0
            Width = 102
            Height = 71
            Caption = #20027#23646#24615
            TabOrder = 3
            object Label512: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label513: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label514: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetMainAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 5
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditHelmetMainAddValueMaxLimitChange
            end
            object EditHelmetMainAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetMainAddValueRateChange
            end
            object EditHelmetMainAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetMainAddRateChange
            end
          end
          object GroupBox209: TGroupBox
            Left = 4
            Top = 75
            Width = 102
            Height = 71
            Caption = #24378#36523#31561#32423
            TabOrder = 4
            object Label515: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label516: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label517: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetQSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditHelmetQSAddValueMaxLimitChange
            end
            object EditHelmetQSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetQSAddValueRateChange
            end
            object EditHelmetQSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetQSAddRateChange
            end
          end
          object GroupBox210: TGroupBox
            Left = 117
            Top = 75
            Width = 102
            Height = 71
            Caption = #21560#34880#19978#38480
            TabOrder = 5
            object Label518: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label519: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label520: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetXXAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditHelmetXXAddValueMaxLimitChange
            end
            object EditHelmetXXAddValueRate: TSpinEdit
              Left = 58
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetXXAddValueRateChange
            end
            object EditHelmetXXAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetXXAddRateChange
            end
          end
          object GroupBox216: TGroupBox
            Left = 228
            Top = 76
            Width = 102
            Height = 71
            Caption = #21512#20987#23041#21147
            TabOrder = 6
            object Label536: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label537: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label538: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelmetHJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 50
              MinValue = 1
              TabOrder = 0
              Value = 50
              OnChange = EditHelmetHJAddValueMaxLimitChange
            end
            object EditHelmetHJAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelmetHJAddValueRateChange
            end
            object EditHelmetHJAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelmetHJAddRateChange
            end
          end
        end
        object TabSheet79: TTabSheet
          Caption = #38795#23376'.'#33136#24102'.'#20891#40723
          ImageIndex = 9
          object GroupBox217: TGroupBox
            Left = 3
            Top = 0
            Width = 102
            Height = 71
            Caption = #25915#20987#19978#38480
            TabOrder = 0
            object Label539: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label540: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label541: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditShoesDCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditShoesDCAddValueMaxLimitChange
            end
            object EditShoesDCAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditShoesDCAddValueRateChange
            end
            object EditShoesDCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditShoesDCAddRateChange
            end
          end
          object GroupBox218: TGroupBox
            Left = 116
            Top = 0
            Width = 102
            Height = 71
            Caption = #39764#27861#19978#38480
            TabOrder = 1
            object Label542: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label543: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label544: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditShoesMCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditShoesMCAddValueMaxLimitChange
            end
            object EditShoesMCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditShoesMCAddValueRateChange
            end
            object EditShoesMCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditShoesMCAddRateChange
            end
          end
          object GroupBox219: TGroupBox
            Left = 228
            Top = 0
            Width = 102
            Height = 71
            Caption = #36947#26415#19978#38480
            TabOrder = 2
            object Label545: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label546: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label547: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditShoesSCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditShoesSCAddValueMaxLimitChange
            end
            object EditShoesSCAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditShoesSCAddValueRateChange
            end
            object EditShoesSCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditShoesSCAddRateChange
            end
          end
          object GroupBox220: TGroupBox
            Left = 342
            Top = 0
            Width = 102
            Height = 71
            Caption = #20027#23646#24615
            TabOrder = 3
            object Label548: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label549: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label550: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditShoesMainAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 7
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditShoesMainAddValueMaxLimitChange
            end
            object EditShoesMainAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditShoesMainAddValueRateChange
            end
            object EditShoesMainAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditShoesMainAddRateChange
            end
          end
          object GroupBox221: TGroupBox
            Left = 4
            Top = 75
            Width = 102
            Height = 71
            Caption = #24378#36523#31561#32423
            TabOrder = 4
            object Label551: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label552: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label553: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditShoesQSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditShoesQSAddValueMaxLimitChange
            end
            object EditShoesQSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditShoesQSAddValueRateChange
            end
            object EditShoesQSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditShoesQSAddRateChange
            end
          end
          object GroupBox227: TGroupBox
            Left = 119
            Top = 76
            Width = 102
            Height = 71
            Caption = #32858#39764#31561#32423
            TabOrder = 5
            object Label569: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label570: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label571: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditShoesJMAddValueMaxLimit: TSpinEdit
              Left = 56
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditShoesJMAddValueMaxLimitChange
            end
            object EditShoesJMAddValueRate: TSpinEdit
              Left = 57
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditShoesJMAddValueRateChange
            end
            object EditShoesJMAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditShoesJMAddRateChange
            end
          end
          object GroupBox228: TGroupBox
            Left = 228
            Top = 76
            Width = 102
            Height = 71
            Caption = #21512#20987#23041#21147
            TabOrder = 6
            object Label572: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label573: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label574: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditShoesHJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 50
              MinValue = 1
              TabOrder = 0
              Value = 50
              OnChange = EditShoesHJAddValueMaxLimitChange
            end
            object EditShoesHJAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditShoesHJAddValueRateChange
            end
            object EditShoesHJAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditShoesHJAddRateChange
            end
          end
        end
        object TabSheet80: TTabSheet
          Caption = #21195#31456#31867
          ImageIndex = 10
          object GroupBox229: TGroupBox
            Left = 3
            Top = 0
            Width = 102
            Height = 71
            Caption = #25915#20987#19978#38480
            TabOrder = 0
            object Label575: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label576: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label577: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalDCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalDCAddValueMaxLimitChange
            end
            object EditMedalDCAddValueRate: TSpinEdit
              Left = 58
              Top = 27
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalDCAddValueRateChange
            end
            object EditMedalDCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalDCAddRateChange
            end
          end
          object GroupBox230: TGroupBox
            Left = 116
            Top = 0
            Width = 102
            Height = 71
            Caption = #39764#27861#19978#38480
            TabOrder = 1
            object Label578: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label579: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label580: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalMCAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalMCAddValueMaxLimitChange
            end
            object EditMedalMCAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalMCAddValueRateChange
            end
            object EditMedalMCAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalMCAddRateChange
            end
          end
          object GroupBox231: TGroupBox
            Left = 228
            Top = 0
            Width = 102
            Height = 71
            Caption = #36947#26415#19978#38480
            TabOrder = 2
            object Label581: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label582: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label583: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalSCAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalSCAddValueMaxLimitChange
            end
            object EditMedalSCAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalSCAddValueRateChange
            end
            object EditMedalSCAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalSCAddRateChange
            end
          end
          object GroupBox232: TGroupBox
            Left = 342
            Top = 0
            Width = 102
            Height = 71
            Caption = #20027#23646#24615
            TabOrder = 3
            object Label584: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label585: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label586: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalMainAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 5
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalMainAddValueMaxLimitChange
            end
            object EditMedalMainAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalMainAddValueRateChange
            end
            object EditMedalMainAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalMainAddRateChange
            end
          end
          object GroupBox233: TGroupBox
            Left = 4
            Top = 75
            Width = 102
            Height = 71
            Caption = #24378#36523#31561#32423
            TabOrder = 4
            object Label587: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label588: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label589: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalQSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalQSAddValueMaxLimitChange
            end
            object EditMedalQSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalQSAddValueRateChange
            end
            object EditMedalQSAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalQSAddRateChange
            end
          end
          object GroupBox234: TGroupBox
            Left = 229
            Top = 75
            Width = 102
            Height = 71
            Caption = #38450#29190
            TabOrder = 5
            object Label590: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label591: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label592: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalFBAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalFBAddValueMaxLimitChange
            end
            object EditMedalFBAddValueRate: TSpinEdit
              Left = 58
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalFBAddValueRateChange
            end
            object EditMedalFBAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalFBAddRateChange
            end
          end
          object GroupBox235: TGroupBox
            Left = 341
            Top = 75
            Width = 102
            Height = 71
            Caption = #26292#20987#31561#32423
            TabOrder = 6
            object Label593: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label594: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label595: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalBJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalBJAddValueMaxLimitChange
            end
            object EditMedalBJAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalBJAddValueRateChange
            end
            object EditMedalBJAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalBJAddRateChange
            end
          end
          object GroupBox236: TGroupBox
            Left = 342
            Top = 149
            Width = 102
            Height = 71
            Caption = #20869#20260#31561#32423
            TabOrder = 7
            object Label596: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label597: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label598: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalNSAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalNSAddValueMaxLimitChange
            end
            object EditMedalNSAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalNSAddValueRateChange
            end
            object EditMedalNSAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalNSAddRateChange
            end
          end
          object GroupBox237: TGroupBox
            Left = 229
            Top = 149
            Width = 102
            Height = 71
            Caption = #20869#21147#24674#22797
            TabOrder = 8
            object Label599: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label600: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label601: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalNLAddValueMaxLimit: TSpinEdit
              Left = 58
              Top = 6
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalNLAddValueMaxLimitChange
            end
            object EditMedalNLAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalNLAddValueRateChange
            end
            object EditMedalNLAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalNLAddRateChange
            end
          end
          object GroupBox238: TGroupBox
            Left = 118
            Top = 149
            Width = 102
            Height = 71
            Caption = #40635#30201#25239#24615
            TabOrder = 9
            object Label602: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label603: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label604: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalMBAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 20
              MinValue = 1
              TabOrder = 0
              Value = 20
              OnChange = EditMedalMBAddValueMaxLimitChange
            end
            object EditMedalMBAddValueRate: TSpinEdit
              Left = 57
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalMBAddValueRateChange
            end
            object EditMedalMBAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalMBAddRateChange
            end
          end
          object GroupBox239: TGroupBox
            Left = 119
            Top = 76
            Width = 102
            Height = 71
            Caption = #32858#39764#31561#32423
            TabOrder = 10
            object Label605: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label606: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label607: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalJMAddValueMaxLimit: TSpinEdit
              Left = 56
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 10
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditMedalJMAddValueMaxLimitChange
            end
            object EditMedalJMAddValueRate: TSpinEdit
              Left = 57
              Top = 29
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalJMAddValueRateChange
            end
            object EditMedalJMAddRate: TSpinEdit
              Left = 57
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalJMAddRateChange
            end
          end
          object GroupBox240: TGroupBox
            Left = 3
            Top = 149
            Width = 102
            Height = 71
            Caption = #21512#20987#23041#21147
            TabOrder = 11
            object Label608: TLabel
              Left = 4
              Top = 13
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label609: TLabel
              Left = 4
              Top = 32
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label610: TLabel
              Left = 4
              Top = 52
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditMedalHJAddValueMaxLimit: TSpinEdit
              Left = 57
              Top = 9
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 50
              MinValue = 1
              TabOrder = 0
              Value = 50
              OnChange = EditMedalHJAddValueMaxLimitChange
            end
            object EditMedalHJAddValueRate: TSpinEdit
              Left = 58
              Top = 28
              Width = 41
              Height = 21
              Hint = #23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMedalHJAddValueRateChange
            end
            object EditMedalHJAddRate: TSpinEdit
              Left = 58
              Top = 48
              Width = 41
              Height = 21
              Hint = #21152#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditMedalHJAddRateChange
            end
          end
        end
        object TabSheet74: TTabSheet
          Caption = #39640#32423#37492#23450
          ImageIndex = 9
          object Label376: TLabel
            Left = 8
            Top = 11
            Width = 54
            Height = 12
            Caption = #25104#21151#26426#29575':'
          end
          object EditAdvancedKamPo: TSpinEdit
            Left = 63
            Top = 5
            Width = 57
            Height = 21
            Hint = #37492#23450#35013#22791#29289#21697#26102','#21487#20197#23558#27491#22312#37492#23450#30340#35013#22791#26367#25442#20026#23545#24212#30340#21476#33891#35013#22791#30340#26426#29575','#25968#20540#36234#23567','#26426#29575#36234#22823#12290
            EditorEnabled = False
            MaxValue = 65535
            MinValue = 0
            TabOrder = 0
            Value = 100
            OnChange = EditAdvancedKamPoChange
          end
        end
        object TabSheet98: TTabSheet
          Caption = #26032#37492#23450
          ImageIndex = 10
          object GroupBox63: TGroupBox
            Left = 8
            Top = 9
            Width = 126
            Height = 86
            Caption = #38145#23450#23646#24615#28040#32791
            TabOrder = 0
            object Label673: TLabel
              Left = 4
              Top = 13
              Width = 114
              Height = 12
              Caption = #27599#38145#23450#19968#20010#23646#24615#38656#35201':'
            end
            object Label674: TLabel
              Left = 3
              Top = 51
              Width = 30
              Height = 12
              Caption = #27531#21367':'
            end
            object Label675: TLabel
              Left = 3
              Top = 31
              Width = 54
              Height = 12
              Caption = #21367#36724#30862#29255':'
            end
            object EditNewKamPoLockNeed1: TSpinEdit
              Left = 66
              Top = 29
              Width = 52
              Height = 21
              EditorEnabled = False
              MaxValue = 100000
              MinValue = 0
              TabOrder = 0
              Value = 100
              OnChange = EditNewKamPoLockNeed1Change
            end
            object EditNewKamPoLockNeed2: TSpinEdit
              Left = 67
              Top = 47
              Width = 52
              Height = 21
              EditorEnabled = False
              MaxValue = 1000000
              MinValue = 0
              TabOrder = 1
              Value = 100
              OnChange = EditNewKamPoLockNeed2Change
            end
          end
          object GroupBox261: TGroupBox
            Left = 142
            Top = 10
            Width = 126
            Height = 86
            Caption = #37492#23450#28040#32791
            TabOrder = 1
            object Label676: TLabel
              Left = 4
              Top = 13
              Width = 78
              Height = 12
              Caption = #27599#27425#37492#23450#28040#32791':'
            end
            object Label678: TLabel
              Left = 5
              Top = 31
              Width = 54
              Height = 12
              Caption = #21367#36724#30862#29255':'
            end
            object Label677: TLabel
              Left = 7
              Top = 50
              Width = 30
              Height = 12
              Caption = #27531#21367':'
            end
            object EditNewKamPoNeed1: TSpinEdit
              Left = 66
              Top = 29
              Width = 52
              Height = 21
              EditorEnabled = False
              MaxValue = 100000
              MinValue = 0
              TabOrder = 0
              Value = 100
              OnChange = EditNewKamPoNeed1Change
            end
            object EditNewKamPoNeed2: TSpinEdit
              Left = 67
              Top = 47
              Width = 52
              Height = 21
              EditorEnabled = False
              MaxValue = 1000000
              MinValue = 0
              TabOrder = 1
              Value = 100
              OnChange = EditNewKamPoNeed2Change
            end
          end
        end
      end
      object ButtonSaveKamPo: TButton
        Left = 367
        Top = 284
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSaveKamPoClick
      end
    end
    object TabSheet32: TTabSheet
      Caption = #25366#23453#25511#21046
      ImageIndex = 18
      object Label521: TLabel
        Left = 4
        Top = 17
        Width = 102
        Height = 12
        Caption = #28789#23186#25506#32034#23453#29289#26426#29575':'
      end
      object ButtonJewelSave: TButton
        Left = 367
        Top = 284
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonJewelSaveClick
      end
      object EditFindJewelRave: TSpinEdit
        Left = 105
        Top = 12
        Width = 57
        Height = 21
        Hint = #25366#23453#22320#22270#20013','#20351#29992#28789#23186'(Ctrl+X)'#25214#21040#23453#29289#20301#32622#30340#25104#21151#29575#13#10#25968#20540#36234#23567' ,'#25506#32034#25104#21151#29575#36234#39640
        EditorEnabled = False
        MaxValue = 100
        MinValue = 0
        TabOrder = 1
        Value = 100
        OnChange = EditFindJewelRaveChange
      end
      object GroupBox211: TGroupBox
        Left = 3
        Top = 35
        Width = 163
        Height = 81
        Caption = #25366#23453#26426#29575
        TabOrder = 2
        object Label522: TLabel
          Left = 7
          Top = 14
          Width = 78
          Height = 12
          Caption = #25366#23453#21629#20013#26426#29575':'
        end
        object Label523: TLabel
          Left = 7
          Top = 38
          Width = 54
          Height = 12
          Caption = #25366#23453#26426#29575':'
        end
        object Label565: TLabel
          Left = 3
          Top = 60
          Width = 114
          Height = 12
          Caption = #24471#23453#20943#35013#22791#21697#36136#26426#29575':'
        end
        object EditDigJewelHitRate: TSpinEdit
          Left = 87
          Top = 9
          Width = 57
          Height = 21
          Hint = #25366#23453#22320#22270#20013','#25366#23453'(Alt+'#40736#26631#21491#38190'),'#36827#20837#25552#31034#21450#24471#23453#21028#26029#36807#31243#30340#26426#29575#13#10#25968#20540#36234#23567' ,'#26426#29575#36234#39640
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditDigJewelHitRateChange
        end
        object EditGetDigJewelRave: TSpinEdit
          Left = 67
          Top = 33
          Width = 57
          Height = 21
          Hint = #25366#23453'(Alt+'#40736#26631#21491#38190'),'#24471#23453#26426#29575#13#10#25968#20540#36234#23567' ,'#26426#29575#36234#39640
          EditorEnabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 1
          Value = 100
          OnChange = EditGetDigJewelRaveChange
        end
        object EditDecDuraRate: TSpinEdit
          Left = 110
          Top = 55
          Width = 50
          Height = 21
          Hint = #25366#21040#29289#21697#20943#35013#22791#28789#23186#21697#36136#30340#26426#29575',65535'#21017#19981#20943#21697#36136'('#38500#39764#28789#23186#38500#22806')'#13#10#24403#21697#36136'46'#20197#19979#26102#19981#20943#35013#22791#21697#36136#13#10#19968#27425#20943'11'#28857#21697#36136#20540
          MaxValue = 65535
          MinValue = 1
          TabOrder = 2
          Value = 100
          OnChange = EditDecDuraRateChange
        end
      end
    end
    object TabSheet82: TTabSheet
      Caption = #26426#22120#20154
      ImageIndex = 19
      object PageControlAI: TPageControl
        Left = 0
        Top = 0
        Width = 458
        Height = 282
        ActivePage = TabSheet83
        Align = alTop
        TabOrder = 0
        object TabSheet83: TTabSheet
          Caption = #30331#24405#35774#32622
          object GroupBox144: TGroupBox
            Left = 16
            Top = 0
            Width = 169
            Height = 196
            Caption = #26426#22120#20154#21015#34920
            TabOrder = 0
            object ListBoxAIList: TMyListBox
              Left = 8
              Top = 16
              Width = 153
              Height = 177
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ItemHeight = 12
              MultiSelect = True
              TabOrder = 0
              OnClick = ListBoxAIListClick
            end
          end
          object GroupBox225: TGroupBox
            Left = 192
            Top = 0
            Width = 240
            Height = 85
            TabOrder = 1
            object Label566: TLabel
              Left = 8
              Top = 20
              Width = 54
              Height = 12
              Caption = #35282#33394#21517#31216':'
            end
            object EditAIName: TEdit
              Left = 64
              Top = 16
              Width = 137
              Height = 20
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              TabOrder = 0
            end
            object ButtonAIListAdd: TButton
              Left = 80
              Top = 48
              Width = 57
              Height = 25
              Caption = #22686#21152'(&A)'
              TabOrder = 1
              OnClick = ButtonAIListAddClick
            end
            object ButtonAIDel: TButton
              Left = 140
              Top = 48
              Width = 57
              Height = 25
              Caption = #21024#38500'(&D)'
              TabOrder = 2
              OnClick = ButtonAIDelClick
            end
          end
          object GroupBox226: TGroupBox
            Left = 191
            Top = 97
            Width = 145
            Height = 89
            Caption = #20986#29983#22320#22270
            TabOrder = 2
            object Label567: TLabel
              Left = 8
              Top = 44
              Width = 36
              Height = 12
              Caption = #24231#26631'X:'
            end
            object Label568: TLabel
              Left = 8
              Top = 68
              Width = 36
              Height = 12
              Caption = #24231#26631'Y:'
            end
            object Label611: TLabel
              Left = 8
              Top = 20
              Width = 30
              Height = 12
              Caption = #22320#22270':'
            end
            object EditHomeX: TSpinEdit
              Left = 52
              Top = 40
              Width = 53
              Height = 21
              MaxValue = 2000
              MinValue = 1
              TabOrder = 0
              Value = 10
              OnChange = EditHomeXChange
            end
            object EditHomeY: TSpinEdit
              Left = 52
              Top = 64
              Width = 53
              Height = 21
              MaxValue = 2000
              MinValue = 1
              TabOrder = 1
              Value = 10
              OnChange = EditHomeYChange
            end
            object EditHomeMap: TEdit
              Left = 52
              Top = 16
              Width = 73
              Height = 20
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              TabOrder = 2
              Text = '3'
              OnChange = EditHomeMapChange
            end
          end
          object ButtonAILogon: TButton
            Left = 352
            Top = 160
            Width = 81
            Height = 25
            Caption = #30331#24405'(&L)'
            TabOrder = 3
            OnClick = ButtonAILogonClick
          end
          object GroupBox241: TGroupBox
            Left = 16
            Top = 198
            Width = 425
            Height = 57
            Caption = #37197#32622#25991#20214#21015#34920
            TabOrder = 4
            object Label614: TLabel
              Left = 3
              Top = 18
              Width = 30
              Height = 12
              Caption = #20154#29289':'
            end
            object Label615: TLabel
              Left = 3
              Top = 37
              Width = 30
              Height = 12
              Caption = #33521#38596':'
              Visible = False
            end
            object EditConfigListFileName: TEdit
              Left = 39
              Top = 12
              Width = 378
              Height = 20
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              TabOrder = 0
              Text = 'D:\MirServer\Mir200\Envir\QuestDiary\'#26426#22120#20154#37197#32622#25991#20214#21015#34920'.txt'
              OnChange = EditConfigListFileNameChange
            end
            object EditsHeroConfigListFileName: TEdit
              Left = 39
              Top = 34
              Width = 378
              Height = 20
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              TabOrder = 1
              Text = 'D:\MirServer\Mir200\Envir\QuestDiary\'#26426#22120#20154#37197#32622#25991#20214#21015#34920'.txt'
              Visible = False
              OnChange = EditConfigListFileNameChange
            end
          end
        end
        object TabSheet84: TTabSheet
          Caption = #22522#26412#35774#32622
          ImageIndex = 1
          object GroupBox242: TGroupBox
            Left = 8
            Top = 8
            Width = 121
            Height = 49
            Caption = #35013#22791#20462#29702
            TabOrder = 0
            object CheckBoxAutoRepairItem: TCheckBox
              Left = 16
              Top = 16
              Width = 89
              Height = 17
              Caption = #33258#21160#20462#29702#35013#22791
              TabOrder = 0
              OnClick = CheckBoxAutoRepairItemClick
            end
          end
          object GroupBox243: TGroupBox
            Left = 8
            Top = 64
            Width = 121
            Height = 49
            Caption = #33258#21160#22686#21152'HPMP'
            TabOrder = 1
            object CheckBoxRenewHealth: TCheckBox
              Left = 16
              Top = 16
              Width = 89
              Height = 17
              Caption = #33258#21160#22686#21152'HPMP'
              TabOrder = 0
              OnClick = CheckBoxRenewHealthClick
            end
          end
          object GroupBox244: TGroupBox
            Left = 8
            Top = 120
            Width = 249
            Height = 49
            Caption = #30334#20998#27604
            TabOrder = 2
            object Label612: TLabel
              Left = 8
              Top = 21
              Width = 102
              Height = 12
              Caption = 'HP'#25110'MP'#30334#20998#27604#20302#20110':'
            end
            object Label613: TLabel
              Left = 168
              Top = 21
              Width = 72
              Height = 12
              Caption = '% '#26102#24320#22987#22686#21152
            end
            object EditRenewPercent: TSpinEdit
              Left = 112
              Top = 19
              Width = 49
              Height = 21
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Value = 60
              OnChange = EditRenewPercentChange
            end
          end
          object GroupBox245: TGroupBox
            Left = 136
            Top = 8
            Width = 121
            Height = 49
            Caption = #25441#29289#21697
            TabOrder = 3
            object CheckBoxAutoPickUpItem: TCheckBox
              Left = 15
              Top = 16
              Width = 89
              Height = 17
              Hint = #29289#21697#20026#20998#36523'('#33521#38596')'#21487#25441#36215#29289#21697#21015#34920#20013#26102'.'#25165#21487#20197#25441#36215
              Caption = #33258#21160#25441#29289#21697
              TabOrder = 0
              OnClick = CheckBoxAutoPickUpItemClick
            end
          end
          object GroupBox251: TGroupBox
            Left = 266
            Top = 8
            Width = 137
            Height = 131
            Caption = #36895#24230#25511#21046
            TabOrder = 4
            object Label625: TLabel
              Left = 8
              Top = 16
              Width = 60
              Height = 12
              Caption = #25112#22763#25915#20987#65306
            end
            object Label626: TLabel
              Left = 8
              Top = 40
              Width = 60
              Height = 12
              Caption = #27861#24072#25915#20987#65306
            end
            object Label627: TLabel
              Left = 8
              Top = 64
              Width = 60
              Height = 12
              Caption = #36947#22763#25915#20987#65306
            end
            object Label628: TLabel
              Left = 32
              Top = 86
              Width = 36
              Height = 12
              Caption = #36305#27493#65306
            end
            object Label629: TLabel
              Left = 33
              Top = 108
              Width = 36
              Height = 12
              Caption = #36208#36335#65306
            end
            object SpinAIWarrorAttackTime: TSpinEdit
              Left = 73
              Top = 12
              Width = 57
              Height = 21
              Hint = #21333#20301#27627#31186
              MaxValue = 20000
              MinValue = 500
              TabOrder = 0
              Value = 500
              OnChange = SpinAIWarrorAttackTimeChange
            end
            object SpinAIWizardAttackTime: TSpinEdit
              Left = 72
              Top = 36
              Width = 57
              Height = 21
              Hint = #21333#20301#27627#31186
              MaxValue = 2000
              MinValue = 500
              TabOrder = 1
              Value = 500
              OnChange = SpinAIWizardAttackTimeChange
            end
            object SpinAITaoistAttackTime: TSpinEdit
              Left = 71
              Top = 60
              Width = 57
              Height = 21
              Hint = #21333#20301#27627#31186
              MaxValue = 2000
              MinValue = 500
              TabOrder = 2
              Value = 500
              OnChange = SpinAITaoistAttackTimeChange
            end
            object EditAIRunIntervalTime: TSpinEdit
              Left = 72
              Top = 82
              Width = 57
              Height = 21
              EditorEnabled = False
              MaxValue = 2000
              MinValue = 10
              TabOrder = 3
              Value = 600
              OnChange = EditAIRunIntervalTimeChange
            end
            object EditAIWalkIntervalTime: TSpinEdit
              Left = 71
              Top = 104
              Width = 57
              Height = 21
              MaxValue = 2000
              MinValue = 10
              TabOrder = 4
              Value = 600
              OnChange = EditAIWalkIntervalTimeChange
            end
          end
          object GroupBox252: TGroupBox
            Left = 135
            Top = 65
            Width = 121
            Height = 49
            Caption = #33258#21160#22238#22478
            TabOrder = 5
            object CheckBoxHPAutoMoveMap: TCheckBox
              Left = 15
              Top = 16
              Width = 89
              Height = 17
              Hint = '30%'#26102#23432#25252#29366#24577#21017#39134#22238#23432#25252#28857#25110#22238#22478
              Caption = #20302#34880#33258#21160#22238#22478
              TabOrder = 0
              OnClick = CheckBoxHPAutoMoveMapClick
            end
          end
        end
      end
      object ButtonSaveAI: TButton
        Left = 358
        Top = 288
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonSaveAIClick
      end
    end
  end
end
