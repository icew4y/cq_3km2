object frmHeroConfig: TfrmHeroConfig
  Left = 443
  Top = 148
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #33521#38596#35774#32622
  ClientHeight = 396
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Label3: TLabel
    Left = 10
    Top = 256
    Width = 168
    Height = 12
    Caption = #21507#26222#36890#33647#38388#38548'          ('#27627#31186')'
  end
  object Label50: TLabel
    Left = 180
    Top = 256
    Width = 66
    Height = 12
    Caption = 'HP        %'
  end
  object Label51: TLabel
    Left = 249
    Top = 256
    Width = 66
    Height = 12
    Caption = 'MP        %'
  end
  object Label55: TLabel
    Left = 16
    Top = 22
    Width = 114
    Height = 12
    Caption = '0'#32423' HP'#65306'          %'
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 465
    Height = 396
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#35774#32622
      ParentShowHint = False
      ShowHint = True
      object GroupBoxLevelExp: TGroupBox
        Left = 4
        Top = 0
        Width = 176
        Height = 171
        Caption = #21319#32423#32463#39564
        TabOrder = 0
        object Label37: TLabel
          Left = 11
          Top = 153
          Width = 30
          Height = 12
          Caption = #35745#21010':'
        end
        object ComboBoxLevelExp: TComboBox
          Left = 48
          Top = 148
          Width = 121
          Height = 20
          Style = csDropDownList
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ComboBoxLevelExpClick
        end
        object GridLevelExp: TStringGrid
          Left = 8
          Top = 11
          Width = 161
          Height = 137
          Hint = #20462#25913#30340#32463#39564#22312#28857#20987#20445#23384#25353#38062#21518#29983#25928#12290#32463#39564#20540#26368#39640'4294967295'
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 1001
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnSetEditText = GridLevelExpSetEditText
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
      end
      object GroupBox8: TGroupBox
        Left = 184
        Top = 118
        Width = 129
        Height = 53
        Caption = #32463#39564#20998#37197
        TabOrder = 1
        object Label23: TLabel
          Left = 11
          Top = 14
          Width = 54
          Height = 12
          Caption = #26432#24618#27604#20363':'
        end
        object Label45: TLabel
          Left = 5
          Top = 34
          Width = 66
          Height = 12
          Caption = #38750#26432#24618#27604#20363':'
        end
        object EditKillMonExpRate: TSpinEdit
          Left = 68
          Top = 10
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
          OnChange = EditKillMonExpRateChange
        end
        object EditNoEditKillMonExpRate: TSpinEdit
          Left = 68
          Top = 30
          Width = 53
          Height = 21
          EditorEnabled = False
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 40
          OnChange = EditNoEditKillMonExpRateChange
        end
      end
      object GroupBox29: TGroupBox
        Left = 184
        Top = 0
        Width = 129
        Height = 54
        Caption = #20986#36523#31561#32423
        TabOrder = 2
        object Label61: TLabel
          Left = 6
          Top = 14
          Width = 66
          Height = 12
          Caption = #30333#26085#38376#33521#38596':'
        end
        object Label38: TLabel
          Left = 19
          Top = 34
          Width = 54
          Height = 12
          Caption = #21351#40857#33521#38596':'
        end
        object EditStartLevel: TSpinEdit
          Left = 68
          Top = 10
          Width = 52
          Height = 21
          Hint = #20154#29289#36215#22987#31561#32423#12290#30333#26085#38376#33521#38596
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditStartLevelChange
        end
        object EditDrinkHeroStartLevel: TSpinEdit
          Left = 68
          Top = 30
          Width = 52
          Height = 21
          Hint = #20154#29289#36215#22987#31561#32423#12290#37202#39302#39046#21462#30340#33521#38596
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditDrinkHeroStartLevelChange
        end
      end
      object GroupBox59: TGroupBox
        Left = 320
        Top = 3
        Width = 137
        Height = 76
        Caption = #25915#20987#36895#24230
        TabOrder = 3
        object Label131: TLabel
          Left = 8
          Top = 14
          Width = 60
          Height = 12
          Caption = #25112#22763#36895#24230#65306
        end
        object Label132: TLabel
          Left = 8
          Top = 34
          Width = 60
          Height = 12
          Caption = #27861#24072#36895#24230#65306
        end
        object Label133: TLabel
          Left = 10
          Top = 54
          Width = 60
          Height = 12
          Caption = #36947#22763#36895#24230#65306
        end
        object SpinEditWarrorAttackTime: TSpinEdit
          Left = 72
          Top = 10
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 100000
          MinValue = 100
          TabOrder = 0
          Value = 500
          OnChange = SpinEditWarrorAttackTimeChange
        end
        object SpinEditWizardAttackTime: TSpinEdit
          Left = 72
          Top = 30
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 10000
          MinValue = 100
          TabOrder = 1
          Value = 500
          OnChange = SpinEditWizardAttackTimeChange
        end
        object SpinEditTaoistAttackTime: TSpinEdit
          Left = 72
          Top = 51
          Width = 57
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 10000
          MinValue = 100
          TabOrder = 2
          Value = 500
          OnChange = SpinEditTaoistAttackTimeChange
        end
      end
      object ButtonHeroExpSave: TButton
        Left = 356
        Top = 342
        Width = 79
        Height = 28
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonHeroExpSaveClick
      end
      object GroupBox1: TGroupBox
        Left = 320
        Top = 79
        Width = 137
        Height = 56
        Caption = #21253#35065#35774#32622
        TabOrder = 5
        object Label1: TLabel
          Left = 8
          Top = 36
          Width = 54
          Height = 12
          Caption = #38656#35201#31561#32423':'
        end
        object SpinEditNeedLevel: TSpinEdit
          Left = 68
          Top = 32
          Width = 53
          Height = 21
          Hint = #25351#23450#21253#35065#25968#38656#35201#30340#31561#32423#12290
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = SpinEditNeedLevelChange
        end
        object ComboBoxBagItemCount: TComboBox
          Left = 8
          Top = 12
          Width = 113
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 1
          Text = #36873#25321#21253#35065#25968
          OnChange = ComboBoxBagItemCountChange
          Items.Strings = (
            '10'#26684
            '20'#26684
            '30'#26684
            '35'#26684
            '40'#26684)
        end
      end
      object GroupBox5: TGroupBox
        Left = 5
        Top = 173
        Width = 310
        Height = 82
        Caption = #24544#35802#24230#35774#32622
        TabOrder = 6
        object Label10: TLabel
          Left = 10
          Top = 36
          Width = 54
          Height = 12
          Caption = #33719#24471#32463#39564':'
        end
        object Label11: TLabel
          Left = 134
          Top = 35
          Width = 42
          Height = 12
          Caption = #28857'/'#22686#21152
        end
        object Label12: TLabel
          Left = 12
          Top = 58
          Width = 54
          Height = 12
          Caption = #27515#20129#20943#23569':'
        end
        object Label28: TLabel
          Left = 10
          Top = 14
          Width = 78
          Height = 12
          Caption = #24694#24847#26432#20154#20943#23569':'
        end
        object Label30: TLabel
          Left = 169
          Top = 13
          Width = 78
          Height = 12
          Caption = #21512#27861#26432#20154#22686#21152':'
        end
        object Label31: TLabel
          Left = 8
          Top = 14
          Width = 114
          Height = 12
          Caption = #20027#20154#31561#32423#25490#21517#19978#21319#21152':'
          Visible = False
        end
        object Label32: TLabel
          Left = 183
          Top = 14
          Width = 36
          Height = 12
          Caption = #19979#38477#20943
          Visible = False
        end
        object Label33: TLabel
          Left = 140
          Top = 58
          Width = 78
          Height = 12
          Caption = #33635#35465#25552#21319#22686#21152':'
        end
        object EditWinExp: TSpinEdit
          Left = 68
          Top = 32
          Width = 61
          Height = 21
          Hint = #33719#24471#32463#39564#36798#21040#25351#23450#20540','#21363#21487#22686#21152#30456#24212#30340#24544#35802#24230'.100'#20026'1%'
          MaxValue = 2000000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 10000
          OnChange = EditWinExpChange
        end
        object EditExpAddLoyal: TSpinEdit
          Left = 182
          Top = 31
          Width = 61
          Height = 21
          Hint = #33719#24471#32463#39564#36798#21040#25351#23450#20540','#21363#21487#22686#21152#30456#24212#30340#24544#35802#24230'.100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 1
          OnChange = EditExpAddLoyalChange
        end
        object EditDeathDecLoyal: TSpinEdit
          Left = 68
          Top = 54
          Width = 61
          Height = 21
          Hint = #33521#38596#27515#20129#20943#23569#24544#35802#24230',100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 5
          OnChange = EditDeathDecLoyalChange
        end
        object EditPKDecLoyal: TSpinEdit
          Left = 92
          Top = 10
          Width = 61
          Height = 21
          Hint = #24694#24847#26432#20154#25351#26432#20154#22686#21152'PK'#20540','#24544#35802#24230'100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 1
          OnChange = EditPKDecLoyalChange
        end
        object EditGuildIncLoyal: TSpinEdit
          Left = 252
          Top = 9
          Width = 52
          Height = 21
          Hint = #21512#27861#26432#20154#25351#34892#20250#25112#21644#25915#22478#25112','#24544#35802#24230'100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Value = 1
          OnChange = EditGuildIncLoyalChange
        end
        object EditLevelOrderIncLoyal: TSpinEdit
          Left = 121
          Top = 10
          Width = 57
          Height = 21
          Hint = #20027#20154#31561#32423#25490#21517#19978#21319#21152#24544#35802#24230',100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 1
          Visible = False
          OnChange = EditLevelOrderIncLoyalChange
        end
        object EditLevelOrderDecLoyal: TSpinEdit
          Left = 222
          Top = 9
          Width = 61
          Height = 21
          Hint = #20027#20154#31561#32423#25490#21517#19979#38477#20943#24544#35802#24230',100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Value = 1
          Visible = False
          OnChange = EditLevelOrderDecLoyalChange
        end
        object SpinEdit1: TSpinEdit
          Left = 220
          Top = 54
          Width = 61
          Height = 21
          Hint = #33635#35465#20540#26242#26102#26080#25928#26524','#24544#35802#24230'100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 7
          Value = 0
        end
      end
      object GroupBox6: TGroupBox
        Left = 184
        Top = 59
        Width = 130
        Height = 54
        Caption = #22235#32423#25216#33021
        TabOrder = 7
        object Label14: TLabel
          Left = 8
          Top = 14
          Width = 54
          Height = 12
          Caption = #22235#32423#35302#21457':'
        end
        object Label15: TLabel
          Left = 5
          Top = 33
          Width = 60
          Height = 12
          Caption = #26432#20260#21147#22686#21152
        end
        object EditGotoLV4: TSpinEdit
          Left = 68
          Top = 10
          Width = 53
          Height = 21
          Hint = #24544#35802#24230#36798#21040#25351#23450#25968#20540#26102','#35302#21457#22235#32423#25216#33021',100'#20026'1%'
          MaxValue = 10000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 3000
          OnChange = EditGotoLV4Change
        end
        object EditPowerLv4: TSpinEdit
          Left = 68
          Top = 30
          Width = 53
          Height = 21
          Hint = #22312#21407#26469#25216#33021#30340#22522#30784#19978#22686#21152#30340#26432#20260#21147'.'#13#10#38500'4'#32423#28872#28779#22806','#21482#23545'4'#32423#28781#22825#28779#21644#28779#31526#26377#25928
          MaxValue = 50
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 10
          OnChange = EditPowerLv4Change
        end
      end
      object GroupBox14: TGroupBox
        Left = 321
        Top = 133
        Width = 137
        Height = 114
        Caption = #38388#38548#25511#21046'('#27627#31186')'
        TabOrder = 8
        object Label27: TLabel
          Left = 19
          Top = 36
          Width = 30
          Height = 12
          Caption = #36208#36335':'
        end
        object Label29: TLabel
          Left = 19
          Top = 56
          Width = 30
          Height = 12
          Caption = #36716#21521':'
        end
        object Label39: TLabel
          Left = 20
          Top = 75
          Width = 30
          Height = 12
          Caption = #39764#27861':'
        end
        object Label26: TLabel
          Left = 19
          Top = 15
          Width = 30
          Height = 12
          Caption = #36305#27493':'
        end
        object Label73: TLabel
          Left = 3
          Top = 97
          Width = 66
          Height = 12
          Caption = #36947#27861#31227#21160'2::'
        end
        object EditHeroWalkIntervalTime: TSpinEdit
          Left = 52
          Top = 32
          Width = 55
          Height = 21
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 0
          Value = 600
          OnChange = EditHeroWalkIntervalTimeChange
        end
        object EditHeroTurnIntervalTime: TSpinEdit
          Left = 52
          Top = 52
          Width = 55
          Height = 21
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 1
          Value = 600
          OnChange = EditHeroTurnIntervalTimeChange
        end
        object EditHeroMagicHitIntervalTime: TSpinEdit
          Left = 53
          Top = 71
          Width = 55
          Height = 21
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 2
          Value = 800
          OnChange = EditHeroMagicHitIntervalTimeChange
        end
        object EditHeroRunIntervalTime: TSpinEdit
          Left = 52
          Top = 11
          Width = 55
          Height = 21
          EditorEnabled = False
          Increment = 10
          MaxValue = 2000
          MinValue = 10
          TabOrder = 3
          Value = 600
          OnChange = EditHeroRunIntervalTimeChange
        end
        object EditHeroRunIntervalTime1: TSpinEdit
          Left = 64
          Top = 91
          Width = 55
          Height = 21
          Increment = 10
          MaxValue = 8000
          MinValue = 400
          TabOrder = 4
          Value = 800
          OnChange = EditHeroRunIntervalTime1Change
        end
      end
      object GroupBox17: TGroupBox
        Left = 320
        Top = 250
        Width = 136
        Height = 89
        Caption = #33521#38596#21517#23383#35774#32622
        TabOrder = 9
        object LabelHeroNameColor: TLabel
          Left = 91
          Top = 28
          Width = 9
          Height = 17
          AutoSize = False
          Color = clBackground
          ParentColor = False
        end
        object Label65: TLabel
          Left = 12
          Top = 31
          Width = 30
          Height = 12
          Caption = #39068#33394':'
        end
        object Label24: TLabel
          Left = 12
          Top = 51
          Width = 30
          Height = 12
          Caption = #21517#23383':'
        end
        object Label35: TLabel
          Left = 12
          Top = 72
          Width = 30
          Height = 12
          Caption = #21518#32512':'
        end
        object EditHeroNameColor: TSpinEdit
          Left = 47
          Top = 26
          Width = 43
          Height = 21
          EditorEnabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 0
          Value = 100
          OnChange = EditHeroNameColorChange
        end
        object CheckNameSuffix: TCheckBox
          Left = 16
          Top = 13
          Width = 97
          Height = 14
          Caption = #26174#31034#20027#20154#21517#23383
          TabOrder = 1
          OnClick = CheckNameSuffixClick
        end
        object EdtHeroName: TEdit
          Left = 47
          Top = 47
          Width = 77
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 2
          OnChange = EdtHeroNameChange
        end
        object EditHeroNameSuffix: TEdit
          Left = 47
          Top = 67
          Width = 77
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 3
          OnChange = EditHeroNameSuffixChange
        end
      end
      object CheckBoxHeroProtect: TCheckBox
        Left = 175
        Top = 257
        Width = 114
        Height = 16
        Caption = #31105#27490#23433#20840#21306#23432#25252
        TabOrder = 10
        OnClick = CheckBoxHeroProtectClick
      end
      object CheckBoxHeroRestNoFollow: TCheckBox
        Left = 175
        Top = 273
        Width = 113
        Height = 16
        Hint = #33521#38596#22312#20241#24687#29366#24577#26102#65292#19981#20250#19982#20027#20154#19968#36215#20999#25442#22320#22270
        Caption = #20241#24687#19981#19982#20027#20154#31227#21160
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        OnClick = CheckBoxHeroRestNoFollowClick
      end
      object CheckBoxHeroAttackTarget: TCheckBox
        Left = 175
        Top = 289
        Width = 135
        Height = 16
        Caption = #36947#27861'22'#32423#21069#29289#29702#25915#20987
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnClick = CheckBoxHeroAttackTargetClick
      end
      object CheckBoxHeroAttackTao: TCheckBox
        Left = 175
        Top = 339
        Width = 167
        Height = 16
        Hint = #36947#22763','#24403#30446#26631'HP'#23569#20110'700'#26102','#21487#20197#20351#29992#29289#29702#25915#20987
        Caption = '700'#20197#19979#30446#26631#36947#22763#29289#29702#25915#20987
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
        OnClick = CheckBoxHeroAttackTaoClick
      end
      object GroupBox32: TGroupBox
        Left = 6
        Top = 259
        Width = 162
        Height = 72
        Caption = #33521#38596#34880#37327#35774#32622
        TabOrder = 14
        object Label57: TLabel
          Left = 6
          Top = 16
          Width = 150
          Height = 12
          Caption = #25112#22763'HP'#20493#25968#65306'        /1000'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label58: TLabel
          Left = 6
          Top = 34
          Width = 150
          Height = 12
          Caption = #27861#24072'HP'#20493#25968#65306'        /1000'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label59: TLabel
          Left = 5
          Top = 53
          Width = 150
          Height = 12
          Caption = #36947#22763'HP'#20493#25968#65306'        /1000'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object SpinEditHeroHPRate: TSpinEdit
          Left = 78
          Top = 12
          Width = 49
          Height = 21
          Hint = #33521#38596'HP='#20154#29289'HP*'#35774#32622#20540'/1000'#13#10#22914#38656#20154#29289#19982#33521#38596'HP'#19968#33268#65292#21017#35774#32622#20026'1000'
          MaxValue = 60000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 2000
          OnChange = SpinEditHeroHPRateChange
        end
        object SpinEditHeroHPRate1: TSpinEdit
          Left = 78
          Top = 30
          Width = 49
          Height = 21
          Hint = #33521#38596'HP='#20154#29289'HP*'#35774#32622#20540'/1000'#13#10#22914#38656#20154#29289#19982#33521#38596'HP'#19968#33268#65292#21017#35774#32622#20026'1000'
          MaxValue = 60000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 2000
          OnChange = SpinEditHeroHPRate1Change
        end
        object SpinEditHeroHPRate2: TSpinEdit
          Left = 77
          Top = 49
          Width = 49
          Height = 21
          Hint = #33521#38596'HP='#20154#29289'HP*'#35774#32622#20540'/1000'#13#10#22914#38656#20154#29289#19982#33521#38596'HP'#19968#33268#65292#21017#35774#32622#20026'1000'
          MaxValue = 60000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 2000
          OnChange = SpinEditHeroHPRate2Change
        end
      end
      object CheckBoxProtectPickUpItem: TCheckBox
        Left = 175
        Top = 304
        Width = 90
        Height = 16
        Hint = #33521#38596#23432#25252#26102#65292#21487#33258#21160#25441#29289#21697#12290#25441#21462#30340#29289#21697#65292#38656#35201#22312#21015#34920#19968#20013#8220#20801#35768#20998#36523'('#33521#38596')'#25441#21462#29289#21697#8221#35774#32622#12290
        Caption = #23432#25252#26102#25441#29289#21697
        ParentShowHint = False
        ShowHint = True
        TabOrder = 15
        OnClick = CheckBoxProtectPickUpItemClick
      end
      object CheckBoxHeroAttackNoFollow: TCheckBox
        Left = 175
        Top = 321
        Width = 133
        Height = 16
        Hint = #33521#38596#25915#20987#29366#24577#19979','#26377#25915#20987#30446#26631#26102','#20027#20154#22320#22270#31227#21160','#33521#38596#25171#23436#30446#26631#21518#20877#31227#21160#21040#20027#20154#36523#26049
        Caption = #25915#20987#26102#19981#19982#20027#20154#31227#21160
        TabOrder = 16
        OnClick = CheckBoxHeroAttackNoFollowClick
      end
      object CheckBoxStopProtectOnChangMap: TCheckBox
        Left = 5
        Top = 338
        Width = 108
        Height = 16
        Hint = #20027#20154#21644#33521#38596#25152#22312#22320#22270#19981#21516#26102#20572#27490#23432#25252
        Caption = #25442#22320#22270#20572#27490#23432#25252
        ParentShowHint = False
        ShowHint = True
        TabOrder = 17
        OnClick = CheckBoxStopProtectOnChangMapClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33521#38596#27515#20129
      ImageIndex = 1
      object GroupBox67: TGroupBox
        Left = 8
        Top = 8
        Width = 177
        Height = 106
        Caption = #27515#20129#25481#29289#21697#35268#21017
        TabOrder = 0
        object Label41: TLabel
          Left = 136
          Top = 83
          Width = 36
          Height = 12
          Caption = '/10000'
        end
        object CheckBoxKillByMonstDropUseItem: TCheckBox
          Left = 8
          Top = 16
          Width = 121
          Height = 17
          Hint = #24403#20154#29289#34987#24618#29289#26432#27515#26102#20250#25353#25481#33853#26426#29575#25481#33853#36523#19978#25140#30340#29289#21697#12290
          Caption = #34987#24618#29289#26432#27515#25481#35013#22791
          TabOrder = 0
          OnClick = CheckBoxKillByMonstDropUseItemClick
        end
        object CheckBoxKillByHumanDropUseItem: TCheckBox
          Left = 8
          Top = 32
          Width = 121
          Height = 17
          Hint = #24403#20154#29289#34987#21035#20154#26432#27515#26102#20250#25353#25481#33853#26426#29575#25481#33853#36523#19978#25140#30340#29289#21697#12290
          Caption = #34987#20154#29289#26432#27515#25481#35013#22791
          TabOrder = 1
          OnClick = CheckBoxKillByHumanDropUseItemClick
        end
        object CheckBoxDieScatterBag: TCheckBox
          Left = 8
          Top = 48
          Width = 113
          Height = 17
          Hint = #24403#20154#29289#27515#20129#26102#20250#25353#25481#33853#26426#29575#25481#33853#32972#21253#37324#30340#29289#21697#12290
          Caption = #27515#20129#25481#32972#21253#29289#21697
          TabOrder = 2
          OnClick = CheckBoxDieScatterBagClick
        end
        object CheckBoxDieRedScatterBagAll: TCheckBox
          Left = 8
          Top = 64
          Width = 145
          Height = 17
          Hint = #32418#21517#20154#29289#27515#20129#26102#25481#33853#32972#21253#20013#20840#37096#29289#21697#12290
          Caption = #32418#21517#25481#20840#37096#32972#21253#29289#21697
          TabOrder = 3
          OnClick = CheckBoxDieRedScatterBagAllClick
        end
        object CheckBoxHeroDieExp: TCheckBox
          Left = 8
          Top = 82
          Width = 89
          Height = 17
          Hint = #32418#21517#20154#29289#27515#20129#26102#25481#33853#32972#21253#20013#20840#37096#29289#21697#12290
          Caption = #27515#20129#25481#32463#39564
          TabOrder = 4
          OnClick = CheckBoxHeroDieExpClick
        end
        object SpinEditHeroDieExpRate: TSpinEdit
          Left = 85
          Top = 80
          Width = 49
          Height = 21
          Hint = #27515#20129#25481#32463#39564#27604#29575','#21363#24403#21069#21319#32423#31561#32423#25152#38656#24635#32463#39564#30340#30334#20998#20043#20960
          MaxValue = 10000
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 100
          OnChange = SpinEditHeroDieExpRateChange
        end
      end
      object GroupBox69: TGroupBox
        Left = 192
        Top = 8
        Width = 265
        Height = 89
        Caption = #25481#29289#21697#26426#29575
        TabOrder = 1
        object Label130: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25481#33853#35013#22791':'
        end
        object Label2: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #32418#21517#35013#22791':'
        end
        object Label134: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #32972#21253#29289#21697':'
        end
        object ScrollBarDieDropUseItemRate: TScrollBar
          Left = 64
          Top = 16
          Width = 145
          Height = 17
          Hint = #20154#29289#27515#20129#25481#33853#36523#19978#25140#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 0
          OnChange = ScrollBarDieDropUseItemRateChange
        end
        object EditDieDropUseItemRate: TEdit
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
        object ScrollBarDieRedDropUseItemRate: TScrollBar
          Left = 64
          Top = 40
          Width = 145
          Height = 17
          Hint = #32418#21517#20154#29289#27515#20129#25481#33853#36523#19978#25140#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          PageSize = 0
          TabOrder = 2
          OnChange = ScrollBarDieRedDropUseItemRateChange
        end
        object EditDieRedDropUseItemRate: TEdit
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
        object ScrollBarDieScatterBagRate: TScrollBar
          Left = 64
          Top = 64
          Width = 145
          Height = 17
          Hint = #20154#29289#27515#20129#25481#33853#32972#21253#20013#30340#29289#21697#26426#29575#65292#35774#32622#30340#25968#23383#36234#23567#65292#26426#29575#36234#22823#12290
          Max = 500
          PageSize = 0
          TabOrder = 4
          OnChange = ScrollBarDieScatterBagRateChange
        end
        object EditDieScatterBagRate: TEdit
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
      object ButtonHeroDieSave: TButton
        Left = 352
        Top = 325
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonHeroDieSaveClick
      end
      object GroupBox46: TGroupBox
        Left = 8
        Top = 123
        Width = 129
        Height = 49
        Caption = #28165#29702#26102#38388
        TabOrder = 3
        object Label89: TLabel
          Left = 18
          Top = 21
          Width = 30
          Height = 12
          Caption = #27515#23608':'
        end
        object Label90: TLabel
          Left = 106
          Top = 21
          Width = 12
          Height = 12
          Caption = #31186
        end
        object EditMakeGhostHeroTime: TSpinEdit
          Left = 51
          Top = 17
          Width = 53
          Height = 21
          Hint = #28165#38500#22320#19978#27515#23608#26102#38388#12290
          MaxValue = 6000000
          MinValue = 1
          TabOrder = 0
          Value = 180
          OnChange = EditMakeGhostHeroTimeChange
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #33521#38596#21512#20987
      ImageIndex = 2
      object ButtonHeroAttackSave: TButton
        Left = 352
        Top = 325
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = ButtonHeroAttackSaveClick
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 457
        Height = 305
        ActivePage = TabSheet4
        Align = alTop
        TabOrder = 1
        object TabSheet4: TTabSheet
          Caption = #22522#26412#35774#32622
          object GroupBox3: TGroupBox
            Left = 4
            Top = 2
            Width = 177
            Height = 119
            Caption = #24594#27668#27133
            TabOrder = 0
            object Label4: TLabel
              Left = 8
              Top = 24
              Width = 66
              Height = 12
              Caption = #24594#27133#26368#22823#20540':'
            end
            object Label5: TLabel
              Left = 8
              Top = 48
              Width = 78
              Height = 12
              Caption = #24594#27133#27599#27425#22686#21152':'
            end
            object Label6: TLabel
              Left = 8
              Top = 72
              Width = 102
              Height = 12
              Caption = #28779#40857#20043#24515#27599#27425#20943#23569':'
            end
            object Label42: TLabel
              Left = 8
              Top = 96
              Width = 66
              Height = 12
              Caption = #21152#24594#27668#38388#38548':'
            end
            object EditMaxFirDragonPoint: TSpinEdit
              Left = 116
              Top = 20
              Width = 53
              Height = 21
              EditorEnabled = False
              MaxValue = 300
              MinValue = 1
              TabOrder = 0
              Value = 40
              OnChange = EditMaxFirDragonPointChange
            end
            object EditAddFirDragonPoint: TSpinEdit
              Left = 116
              Top = 44
              Width = 53
              Height = 21
              EditorEnabled = False
              MaxValue = 300
              MinValue = 1
              TabOrder = 1
              Value = 40
              OnChange = EditAddFirDragonPointChange
            end
            object EditDecFirDragonPoint: TSpinEdit
              Left = 116
              Top = 68
              Width = 53
              Height = 21
              EditorEnabled = False
              MaxValue = 300
              MinValue = 1
              TabOrder = 2
              Value = 40
              OnChange = EditDecFirDragonPointChange
            end
            object SpinEditIncDragonPointTick: TSpinEdit
              Left = 116
              Top = 92
              Width = 53
              Height = 21
              Hint = #21363#27599#38548#22810#23569#27627#31186#21152#24594#27668
              MaxValue = 10000000
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              Value = 3000
              OnChange = SpinEditIncDragonPointTickChange
            end
          end
          object GroupBox21: TGroupBox
            Left = 3
            Top = 125
            Width = 179
            Height = 50
            Caption = #39278#37202#20943#23569#21512#20987#20260#23475
            TabOrder = 1
            object Label43: TLabel
              Left = 20
              Top = 22
              Width = 72
              Height = 12
              Caption = #20943#20260#23475#27604#29575#65306
            end
            object Label44: TLabel
              Left = 140
              Top = 21
              Width = 6
              Height = 12
              Caption = '%'
            end
            object SpinEditDecDragonHitPoint: TSpinEdit
              Left = 89
              Top = 18
              Width = 47
              Height = 21
              Hint = #37257#20540#24230#19981#20026'0'#26102','#21487#20197#20943#23569#21512#20987#20260#23475#30340#30334#20998#29575
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = SpinEditDecDragonHitPointChange
            end
          end
          object GroupBox24: TGroupBox
            Left = 3
            Top = 181
            Width = 198
            Height = 89
            Caption = #25915#20987#25511#21046
            TabOrder = 2
            object Label46: TLabel
              Left = 3
              Top = 22
              Width = 132
              Height = 12
              Caption = #21512#20987#23545#20154#29289#30340#20260#23475#27604#20363#65306
            end
            object Label47: TLabel
              Left = 172
              Top = 22
              Width = 6
              Height = 12
              Caption = '%'
            end
            object Label71: TLabel
              Left = 3
              Top = 46
              Width = 192
              Height = 12
              Caption = #22235#32423#21512#20987#20943#30446#26631#20869#21147#20540#27604#20363#65306'     %'
            end
            object Label72: TLabel
              Left = 3
              Top = 67
              Width = 180
              Height = 12
              Caption = #22235#32423#21512#20987#20943#30446#26631'MP'#20540#27604#20363#65306'     %'
            end
            object EditDecDragonRate: TSpinEdit
              Left = 130
              Top = 18
              Width = 42
              Height = 21
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditDecDragonRateChange
            end
            object Edit4SKillDecNH: TSpinEdit
              Left = 146
              Top = 42
              Width = 42
              Height = 21
              Hint = #25353#21512#20987#23041#21147#25353#27604#20363#35745#31639#30446#26631'('#20154','#33521#38596')'#25481#22810#23569#20869#21147#20540
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Value = 1
              OnChange = Edit4SKillDecNHChange
            end
            object Edit4SKillDecMP: TSpinEdit
              Left = 135
              Top = 63
              Width = 42
              Height = 21
              Hint = #25353#21512#20987#23041#21147#25353#27604#20363#35745#31639#30446#26631'('#20154','#33521#38596')'#25481#22810#23569'MP'#20540'('#23545#22235#32423#30772#39746#26025#12289#22235#32423#38647#38662#19968#20987#12289#22235#32423#21128#26143#26025#26377#25928')'
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Value = 1
              OnChange = Edit4SKillDecMPChange
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = #30772#39746#26025
          ImageIndex = 1
          object GroupBox52: TGroupBox
            Left = 8
            Top = 4
            Width = 161
            Height = 50
            Caption = #21512#20987#21442#25968
            TabOrder = 0
            object Label135: TLabel
              Left = 8
              Top = 20
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_60: TSpinEdit
              Left = 72
              Top = 16
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_60Change
            end
          end
          object GroupBox18: TGroupBox
            Left = 8
            Top = 72
            Width = 162
            Height = 46
            Caption = #25915#20987#33539#22260
            TabOrder = 1
            object Label36: TLabel
              Left = 10
              Top = 20
              Width = 60
              Height = 12
              Caption = #33539'    '#22260#65306
            end
            object EditHeroAttackRange_60: TSpinEdit
              Left = 75
              Top = 13
              Width = 77
              Height = 21
              Hint = #39764#27861#25915#20987#33539#22260#24452#12290
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditHeroAttackRange_60Change
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = #21128#26143#26025
          ImageIndex = 2
          object GroupBox9: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label17: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_61: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_61Change
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = #38647#38662#19968#20987
          ImageIndex = 3
          object GroupBox10: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label18: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_62: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_62Change
            end
          end
        end
        object TabSheet8: TTabSheet
          Caption = #22124#39746#27836#27901
          ImageIndex = 4
          object GroupBox11: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label19: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_63: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_63Change
            end
          end
          object GroupBox7: TGroupBox
            Left = 8
            Top = 72
            Width = 177
            Height = 46
            Caption = #25915#20987#33539#22260
            TabOrder = 1
            object Label22: TLabel
              Left = 10
              Top = 20
              Width = 60
              Height = 12
              Caption = #33539'    '#22260#65306
            end
            object EditHeroAttackRange_63: TSpinEdit
              Left = 84
              Top = 13
              Width = 77
              Height = 21
              Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditHeroAttackRange_63Change
            end
          end
          object GroupBox28: TGroupBox
            Left = 8
            Top = 125
            Width = 178
            Height = 65
            Caption = #20013#27602#35774#32622
            TabOrder = 2
            object RadioHeroSkillMode_63ALL: TRadioButton
              Left = 16
              Top = 16
              Width = 137
              Height = 17
              Caption = #30446#26631#21516#26102#20013#32511#27602
              TabOrder = 0
              OnClick = RadioHeroSkillMode_63ALLClick
            end
            object RadioHeroSkillMode_63: TRadioButton
              Left = 16
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#20351#29992#32511#27602#25915#20987
              Caption = #19981#20013#32511#27602
              TabOrder = 1
              OnClick = RadioHeroSkillMode_63Click
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = #26411#26085#23457#21028
          ImageIndex = 5
          object GroupBox12: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label20: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_64: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_64Change
            end
          end
          object GroupBox30: TGroupBox
            Left = 8
            Top = 72
            Width = 177
            Height = 46
            Caption = #25915#20987#33539#22260
            TabOrder = 1
            object Label9: TLabel
              Left = 10
              Top = 20
              Width = 60
              Height = 12
              Caption = #33539'    '#22260#65306
            end
            object EditHeroAttackRange_64: TSpinEdit
              Left = 84
              Top = 13
              Width = 77
              Height = 21
              Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditHeroAttackRange_64Change
            end
          end
        end
        object TabSheet10: TTabSheet
          Caption = #28779#40857#27668#28976
          ImageIndex = 6
          object GroupBox13: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 57
            Caption = #25915#20987#21147#20493#25968
            TabOrder = 0
            object Label21: TLabel
              Left = 11
              Top = 23
              Width = 60
              Height = 12
              Caption = #23041#21147#20493#25968#65306
            end
            object EditHeroAttackRate_65: TSpinEdit
              Left = 83
              Top = 19
              Width = 81
              Height = 21
              Hint = #23454#38469#20493#25968#31561#20110#24403#21069#25968#23383#38500#20197'100'
              MaxValue = 10000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHeroAttackRate_65Change
            end
          end
          object GroupBox15: TGroupBox
            Left = 8
            Top = 72
            Width = 177
            Height = 46
            Caption = #25915#20987#33539#22260
            TabOrder = 1
            object Label16: TLabel
              Left = 10
              Top = 20
              Width = 60
              Height = 12
              Caption = #33539'    '#22260#65306
            end
            object EditHeroAttackRange_65: TSpinEdit
              Left = 84
              Top = 13
              Width = 77
              Height = 21
              Hint = #39764#27861#25915#20987#33539#22260#21322#24452#12290
              EditorEnabled = False
              MaxValue = 12
              MinValue = 1
              TabOrder = 0
              Value = 1
              OnChange = EditHeroAttackRange_65Change
            end
          end
        end
      end
    end
    object TabSheet11: TTabSheet
      Caption = #33521#38596#25216#33021
      ImageIndex = 3
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 473
        Height = 321
        ActivePage = TabSheet12
        MultiLine = True
        TabOrder = 0
        object TabSheet12: TTabSheet
          Caption = #26045#27602#26415
          object GroupBox19: TGroupBox
            Left = 16
            Top = 8
            Width = 161
            Height = 65
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object RadioHeroSkillMode: TRadioButton
              Left = 16
              Top = 16
              Width = 137
              Height = 17
              Caption = #30446#26631#34880#20540#36798'700'#26102#20351#29992
              TabOrder = 0
              OnClick = RadioHeroSkillModeClick
            end
            object RadioHeroSkillModeAll: TRadioButton
              Left = 16
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#31649#30446#26631#34880#20540','#20840#37096#21487#20197#20351#29992#26045#27602#26415
              Caption = #20840#37096#21487#20351#29992
              TabOrder = 1
              OnClick = RadioHeroSkillModeAllClick
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = #21484#21796#23453#23453
          ImageIndex = 1
          object GroupBox20: TGroupBox
            Left = 8
            Top = 8
            Width = 177
            Height = 54
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object CheckBoxHeroNoTargetCall: TCheckBox
              Left = 7
              Top = 22
              Width = 167
              Height = 18
              Hint = #21363#33521#38596#21484#21796#20986#26469#21518','#21363#21487#21484#21796#23453#23453
              Caption = #26080#25915#20987#30446#26631#26102#21487#20197#21484#21796#23453#23453
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = CheckBoxHeroNoTargetCallClick
            end
          end
        end
        object TabSheet15: TTabSheet
          Caption = #26080#26497#30495#27668
          ImageIndex = 3
          object GroupBox25: TGroupBox
            Left = 16
            Top = 8
            Width = 161
            Height = 65
            Caption = #22522#26412#35774#32622
            TabOrder = 0
            object RadioHeroSkillMode50: TRadioButton
              Left = 16
              Top = 16
              Width = 137
              Height = 17
              Caption = #30446#26631'HP > 700'#26102#20351#29992
              TabOrder = 0
              OnClick = RadioHeroSkillMode50Click
            end
            object RadioHeroSkillMode50All: TRadioButton
              Left = 16
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#31649#30446#26631#34880#20540','#20840#37096#21487#20197#20351#29992
              Caption = #20840#37096#21487#20351#29992
              TabOrder = 1
              OnClick = RadioHeroSkillMode50AllClick
            end
          end
        end
        object TabSheet16: TTabSheet
          Caption = #20998#36523#26415
          ImageIndex = 4
          object GroupBox26: TGroupBox
            Left = 3
            Top = 77
            Width = 150
            Height = 120
            Caption = #27861#33521#38596'HP'#20302#20110#26102#21484#21796#20998#36523
            TabOrder = 0
            object Label48: TLabel
              Left = 16
              Top = 22
              Width = 114
              Height = 12
              Caption = '0'#32423' HP'#65306'          %'
            end
            object Label13: TLabel
              Left = 16
              Top = 46
              Width = 114
              Height = 12
              Caption = '1'#32423' HP'#65306'          %'
            end
            object Label49: TLabel
              Left = 16
              Top = 70
              Width = 114
              Height = 12
              Caption = '2'#32423' HP'#65306'          %'
            end
            object Label56: TLabel
              Left = 16
              Top = 94
              Width = 114
              Height = 12
              Caption = '3'#32423' HP'#65306'          %'
            end
            object SpinEditHeroSkill46MaxHP_0: TSpinEdit
              Left = 69
              Top = 18
              Width = 47
              Height = 21
              Hint = #22914#35774#32622#20026'80%,'#21017#33521#38596#22312#26377#30446#26631#26102','#20998#36523#25216#33021#31561#32423#20026'0'#32423#26102',HP'#20302#20110'80%'#26102#25165#20351#29992#20998#36523#25216#33021
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Value = 1
              OnChange = SpinEditHeroSkill46MaxHP_0Change
            end
            object SpinEditHeroSkill46MaxHP_1: TSpinEdit
              Left = 69
              Top = 42
              Width = 47
              Height = 21
              Hint = #22914#35774#32622#20026'80%,'#21017#33521#38596#22312#26377#30446#26631#26102','#20998#36523#25216#33021#31561#32423#20026'1'#32423#26102',HP'#20302#20110'80%'#26102#25165#20351#29992#20998#36523#25216#33021
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Value = 1
              OnChange = SpinEditHeroSkill46MaxHP_1Change
            end
            object SpinEditHeroSkill46MaxHP_2: TSpinEdit
              Left = 69
              Top = 66
              Width = 47
              Height = 21
              Hint = #22914#35774#32622#20026'80%,'#21017#33521#38596#22312#26377#30446#26631#26102','#20998#36523#25216#33021#31561#32423#20026'2'#32423#26102',HP'#20302#20110'80%'#26102#25165#20351#29992#20998#36523#25216#33021
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Value = 1
              OnChange = SpinEditHeroSkill46MaxHP_2Change
            end
            object SpinEditHeroSkill46MaxHP_3: TSpinEdit
              Left = 69
              Top = 90
              Width = 47
              Height = 21
              Hint = #22914#35774#32622#20026'80%,'#21017#33521#38596#22312#26377#30446#26631#26102','#20998#36523#25216#33021#31561#32423#20026'3'#32423#26102',HP'#20302#20110'80%'#26102#25165#20351#29992#20998#36523#25216#33021
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              Value = 1
              OnChange = SpinEditHeroSkill46MaxHP_3Change
            end
          end
          object GroupBox27: TGroupBox
            Left = 4
            Top = 6
            Width = 149
            Height = 65
            Caption = #22522#26412#35774#32622
            TabOrder = 1
            object RadioHeroSkillMode46: TRadioButton
              Left = 9
              Top = 16
              Width = 135
              Height = 17
              Caption = #26377#30446#26631#26102#21487#20351#29992
              TabOrder = 0
              OnClick = RadioHeroSkillMode46Click
            end
            object RadioHeroSkillMode46All: TRadioButton
              Left = 10
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#31649#26159#21542#26377#30446#26631',HP'#36798#21040#35774#32622#26102#21363#21487#20351#29992
              Caption = #20840#37096#21487#20351#29992
              TabOrder = 1
              OnClick = RadioHeroSkillMode46AllClick
            end
          end
          object GroupBox79: TGroupBox
            Left = 164
            Top = 77
            Width = 151
            Height = 119
            Caption = #25216#33021#20351#29992#26102#38388
            TabOrder = 2
            object Label159: TLabel
              Left = 17
              Top = 20
              Width = 120
              Height = 12
              Caption = '0'#32423#20351#29992'           '#31186
            end
            object Label60: TLabel
              Left = 17
              Top = 45
              Width = 120
              Height = 12
              Caption = '1'#32423#20351#29992'           '#31186
            end
            object Label62: TLabel
              Left = 17
              Top = 69
              Width = 120
              Height = 12
              Caption = '2'#32423#20351#29992'           '#31186
            end
            object Label63: TLabel
              Left = 17
              Top = 95
              Width = 120
              Height = 12
              Caption = '3'#32423#20351#29992'           '#31186
            end
            object SpinEditHeroMakeSelfTick: TSpinEdit
              Left = 61
              Top = 16
              Width = 57
              Height = 21
              Hint = '0'#31561#32423#20998#36523#30340#20351#29992#26102#38388
              MaxValue = 65535
              MinValue = 0
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Value = 10
              OnChange = SpinEditHeroMakeSelfTickChange
            end
            object SpinEditHeroMakeSelfTick1: TSpinEdit
              Left = 61
              Top = 41
              Width = 57
              Height = 21
              Hint = '1'#31561#32423#20998#36523#30340#20351#29992#26102#38388
              MaxValue = 65535
              MinValue = 0
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Value = 10
              OnChange = SpinEditHeroMakeSelfTick1Change
            end
            object SpinEditHeroMakeSelfTick2: TSpinEdit
              Left = 61
              Top = 65
              Width = 57
              Height = 21
              Hint = '2'#31561#32423#20998#36523#30340#20351#29992#26102#38388
              MaxValue = 65535
              MinValue = 0
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Value = 10
              OnChange = SpinEditHeroMakeSelfTick2Change
            end
            object SpinEditHeroMakeSelfTick3: TSpinEdit
              Left = 61
              Top = 91
              Width = 57
              Height = 21
              Hint = '3'#31561#32423#20998#36523#30340#20351#29992#26102#38388
              MaxValue = 65535
              MinValue = 0
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              Value = 10
              OnChange = SpinEditHeroMakeSelfTick3Change
            end
          end
        end
        object TabSheet17: TTabSheet
          Caption = #24320#22825#26025
          ImageIndex = 5
          object GroupBox31: TGroupBox
            Left = 4
            Top = 6
            Width = 157
            Height = 64
            Caption = #37325#20987#35774#32622
            TabOrder = 0
            object RadioHeroSkillMode43: TRadioButton
              Left = 9
              Top = 16
              Width = 144
              Height = 17
              Caption = #31561#32423#22823#20110#30446#26631#26102#21487#20351#29992
              TabOrder = 0
              OnClick = RadioHeroSkillMode43Click
            end
            object RadioHeroSkillMode43All: TRadioButton
              Left = 10
              Top = 40
              Width = 97
              Height = 17
              Hint = #19981#31649#30446#26631#31561#32423#26159#21542#39640#20110#33521#38596','#37325#20987#37117#21487#20351#29992','#26426#29575#19982#20027#20307#19968#33268
              Caption = #20840#37096#21487#20351#29992
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = RadioHeroSkillMode43AllClick
            end
          end
          object GroupBox16: TGroupBox
            Left = 5
            Top = 76
            Width = 219
            Height = 48
            Caption = #24320#22825#26025#35302#21457#35774#32622
            TabOrder = 1
            object Label25: TLabel
              Left = 8
              Top = 19
              Width = 204
              Height = 12
              Hint = #22312#20351#29992#38388#38548#26102#38388#21040#26102#65292#33521#38596'HP'#36798#21040#35774#32622#30340#27604#29575#26102#65292#25165#33021#20351#29992#24320#22825#26025
              Caption = #24403'HP'#20302#20110#24635'HP        % '#26102#20351#29992#24320#22825#26025
              ParentShowHint = False
              ShowHint = True
            end
            object SpinEditHeroSkill43HPRate: TSpinEdit
              Left = 83
              Top = 15
              Width = 42
              Height = 21
              Hint = #22914#21482#38656#35201#26102#38388#25511#21046#65292#21482#38656#35774#32622#20026'100'#21363#21487
              MaxValue = 100
              MinValue = 1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              Value = 100
              OnChange = SpinEditHeroSkill43HPRateChange
            end
          end
        end
      end
      object ButtonHeroSkillSave: TButton
        Left = 360
        Top = 333
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonHeroSkillSaveClick
      end
    end
    object TabSheet19: TTabSheet
      Caption = #33521#38596#36830#20987
      ImageIndex = 5
      object GroupBox23: TGroupBox
        Left = 4
        Top = 2
        Width = 381
        Height = 139
        Caption = #32463#32476#32463#39564
        TabOrder = 0
        object GridHeroPulsLevelExp: TStringGrid
          Left = 8
          Top = 14
          Width = 369
          Height = 119
          DefaultRowHeight = 18
          RowCount = 6
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
          TabOrder = 0
          OnEnter = GridHeroPulsLevelExpEnter
          ColWidths = (
            64
            75
            75
            73
            70)
        end
      end
      object Button2: TButton
        Left = 324
        Top = 327
        Width = 79
        Height = 28
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = Button2Click
      end
      object GroupBox111: TGroupBox
        Left = 4
        Top = 148
        Width = 163
        Height = 37
        Caption = #26432#24618#32463#32476#32463#39564
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
        object EditKillMonHeroPulsExpMultiple: TSpinEdit
          Left = 60
          Top = 12
          Width = 53
          Height = 21
          Hint = #26432#24618#25152#24471#30340#32463#39564'*'#27492#21442#25968'/100='#24471#21040#30340#33521#38596#32463#32476#20462#28860#32463#39564
          EditorEnabled = False
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 40
          OnChange = EditKillMonHeroPulsExpMultipleChange
        end
      end
      object GroupBox126: TGroupBox
        Left = 4
        Top = 192
        Width = 164
        Height = 45
        Caption = #26102#38388#25511#21046
        TabOrder = 3
        object Label267: TLabel
          Left = 18
          Top = 21
          Width = 126
          Height = 12
          Caption = #20351#29992#38388#38548#65306'         '#31186
        end
        object EditHeroUseBatterTick: TSpinEdit
          Left = 82
          Top = 17
          Width = 48
          Height = 21
          Hint = #36830#20987#25216#33021#20351#29992#38388#38548
          MaxValue = 65535
          MinValue = 5
          TabOrder = 0
          Value = 5
          OnChange = EditHeroUseBatterTickChange
        end
      end
    end
    object TabSheet18: TTabSheet
      Caption = #20854#23427#35774#32622
      ImageIndex = 4
      object Label34: TLabel
        Left = 158
        Top = 16
        Width = 138
        Height = 12
        Caption = #33521#38596#23432#25252#38656'           '#32423
      end
      object Label68: TLabel
        Left = 158
        Top = 40
        Width = 180
        Height = 12
        Caption = #21103#23558#33521#38596#32463#39564#20493#25968#65306'        /100'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object SpinEditHeroProtectLevel: TSpinEdit
        Left = 220
        Top = 12
        Width = 57
        Height = 21
        Hint = #33521#38596#23432#25252#25152#38656#30340#31561#32423
        MaxValue = 65535
        MinValue = 1
        TabOrder = 0
        Value = 400
        OnChange = SpinEditHeroProtectLevelChange
      end
      object Button1: TButton
        Left = 356
        Top = 327
        Width = 79
        Height = 28
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = Button1Click
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 1
        Width = 145
        Height = 62
        Caption = #21484#21796#33521#38596#38388#38548
        TabOrder = 2
        object Label7: TLabel
          Left = 4
          Top = 17
          Width = 138
          Height = 12
          Caption = #30333#26085#38376#33521#38596':          '#31186
        end
        object Label8: TLabel
          Left = 15
          Top = 41
          Width = 126
          Height = 12
          Caption = #21103#23558#33521#38596':          '#31186
        end
        object EditHeroRecallTick: TSpinEdit
          Left = 68
          Top = 13
          Width = 61
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 0
          Value = 10
          OnChange = EditHeroRecallTickChange
        end
        object EditDeputyHeroRecallTick: TSpinEdit
          Left = 68
          Top = 37
          Width = 61
          Height = 21
          MaxValue = 65535
          MinValue = 5
          TabOrder = 1
          Value = 10
          OnChange = EditDeputyHeroRecallTickChange
        end
      end
      object GroupBox22: TGroupBox
        Left = 8
        Top = 65
        Width = 377
        Height = 89
        Caption = #33258#21160#20462#28860#30456#20851
        TabOrder = 3
        object Label64: TLabel
          Left = 10
          Top = 19
          Width = 306
          Height = 12
          Caption = #20302#24378#24230#27599'10'#31186#20943#37329#24065'         '#20943#28789#31526'          '#27599#31186#32463#39564
        end
        object Label66: TLabel
          Left = 10
          Top = 43
          Width = 306
          Height = 12
          Caption = #20013#24378#24230#27599'10'#31186#20943#37329#24065'         '#20943#28789#31526'          '#27599#31186#32463#39564
        end
        object Label67: TLabel
          Left = 10
          Top = 67
          Width = 306
          Height = 12
          Caption = #39640#24378#24230#27599'10'#31186#20943#37329#24065'         '#20943#28789#31526'          '#27599#31186#32463#39564
        end
        object EditStrength1DecGold: TSpinEdit
          Left = 118
          Top = 14
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 1
          TabOrder = 0
          Value = 10
          OnChange = EditStrength1DecGoldChange
        end
        object EditStrength1DecGameGird: TSpinEdit
          Left = 208
          Top = 14
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditStrength1DecGameGirdChange
        end
        object EditStrength1Exp: TSpinEdit
          Left = 317
          Top = 14
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 1
          TabOrder = 2
          Value = 10
          OnChange = EditStrength1ExpChange
        end
        object EditStrength2DecGold: TSpinEdit
          Left = 118
          Top = 38
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 1
          TabOrder = 3
          Value = 10
          OnChange = EditStrength2DecGoldChange
        end
        object EditStrength2DecGameGird: TSpinEdit
          Left = 208
          Top = 38
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 10
          OnChange = EditStrength2DecGameGirdChange
        end
        object EditStrength2Exp: TSpinEdit
          Left = 317
          Top = 38
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 1
          TabOrder = 5
          Value = 10
          OnChange = EditStrength2ExpChange
        end
        object EditStrength3DecGold: TSpinEdit
          Left = 118
          Top = 62
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 1
          TabOrder = 6
          Value = 10
          OnChange = EditStrength3DecGoldChange
        end
        object EditStrength3DecGameGird: TSpinEdit
          Left = 208
          Top = 62
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 7
          Value = 10
          OnChange = EditStrength3DecGameGirdChange
        end
        object EditStrength3Exp: TSpinEdit
          Left = 317
          Top = 62
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 1
          TabOrder = 8
          Value = 10
          OnChange = EditStrength3ExpChange
        end
      end
      object EditDeputyHeroExpRate: TSpinEdit
        Left = 262
        Top = 36
        Width = 49
        Height = 21
        Hint = #24403#20027#21495#24102#39046#21103#23558#33521#38596#26102#65292#21103#23558#33521#38596#33719#24471#30340#32463#39564#12289#20869#21151#32463#39564#30340#20493#29575
        MaxValue = 65535
        MinValue = 100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Value = 200
        OnChange = EditDeputyHeroExpRateChange
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 155
        Width = 329
        Height = 104
        TabOrder = 5
        object Label124: TLabel
          Left = 191
          Top = 24
          Width = 66
          Height = 12
          Caption = 'HP        %'
        end
        object Label125: TLabel
          Left = 262
          Top = 24
          Width = 60
          Height = 12
          Caption = 'MP       %'
        end
        object Label40: TLabel
          Left = 14
          Top = 17
          Width = 168
          Height = 12
          Caption = '('#25112')'#26222#36890#33647#38388#38548'          '#27627#31186
        end
        object Label52: TLabel
          Left = 15
          Top = 65
          Width = 168
          Height = 12
          Caption = '('#25112')'#29305#27530#33647#38388#38548'          '#27627#31186
        end
        object Label53: TLabel
          Left = 192
          Top = 72
          Width = 66
          Height = 12
          Caption = 'HP        %'
        end
        object Label54: TLabel
          Left = 263
          Top = 72
          Width = 60
          Height = 12
          Caption = 'MP       %'
        end
        object Label69: TLabel
          Left = 3
          Top = 37
          Width = 180
          Height = 12
          Caption = '('#36947#27861')'#26222#36890#33647#38388#38548'          '#27627#31186
        end
        object Label70: TLabel
          Left = 5
          Top = 85
          Width = 180
          Height = 12
          Caption = '('#36947#27861')'#29305#27530#33647#38388#38548'          '#27627#31186
        end
        object SpinEditEatHPItemRate: TSpinEdit
          Left = 207
          Top = 20
          Width = 42
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 60
          OnChange = SpinEditEatHPItemRateChange
        end
        object SpinEditEatMPItemRate: TSpinEdit
          Left = 274
          Top = 20
          Width = 42
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 60
          OnChange = SpinEditEatMPItemRateChange
        end
        object SpinEditEatItemTick: TSpinEdit
          Left = 99
          Top = 13
          Width = 59
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = SpinEditEatItemTickChange
        end
        object SpinEditEatItemTick1: TSpinEdit
          Left = 100
          Top = 61
          Width = 59
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 0
          MinValue = 0
          TabOrder = 3
          Value = 0
          OnChange = SpinEditEatItemTick1Change
        end
        object SpinEditEatHPItemRate1: TSpinEdit
          Left = 208
          Top = 68
          Width = 42
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Value = 60
          OnChange = SpinEditEatHPItemRate1Change
        end
        object SpinEditEatMPItemRate1: TSpinEdit
          Left = 275
          Top = 68
          Width = 42
          Height = 21
          MaxValue = 100
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 60
          OnChange = SpinEditEatMPItemRate1Change
        end
        object SpinEditEatItemTickA: TSpinEdit
          Left = 99
          Top = 33
          Width = 59
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 0
          MinValue = 0
          TabOrder = 6
          Value = 0
          OnChange = SpinEditEatItemTickAChange
        end
        object SpinEditEatItemTickB: TSpinEdit
          Left = 100
          Top = 81
          Width = 59
          Height = 21
          Hint = #21333#20301#27627#31186
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
          Value = 0
          OnChange = SpinEditEatItemTickBChange
        end
        object CheckBoxAutoHeroUseEat: TCheckBox
          Left = 4
          Top = -2
          Width = 89
          Height = 17
          Caption = #33521#38596#33258#21160#21507#33647
          TabOrder = 8
          OnClick = CheckBoxAutoHeroUseEatClick
        end
      end
    end
  end
end
