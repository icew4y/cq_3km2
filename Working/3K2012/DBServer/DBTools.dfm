object frmDBTool: TfrmDBTool
  Left = 392
  Top = 251
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25968#25454#31649#29702#24037#20855
  ClientHeight = 296
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 577
    Height = 273
    ActivePage = TabSheet3
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #25968#25454#24211#20449#24687
      object GroupBox1: TGroupBox
        Left = 8
        Top = 4
        Width = 273
        Height = 233
        Caption = #20154#29289#20449#24687#25968#25454#24211'(Mir.DB)'
        TabOrder = 0
        object GridMirDBInfo: TStringGrid
          Left = 8
          Top = 16
          Width = 257
          Height = 201
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 10
          TabOrder = 0
          ColWidths = (
            64
            181)
        end
      end
      object GroupBox2: TGroupBox
        Left = 288
        Top = 4
        Width = 273
        Height = 233
        Caption = #20154#29289#25968#25454#24211'(Hum.DB)'
        TabOrder = 1
        object GridHumDBInfo: TStringGrid
          Left = 8
          Top = 16
          Width = 257
          Height = 201
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 10
          TabOrder = 0
          ColWidths = (
            64
            181)
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25968#25454#24211#37325#24314
      ImageIndex = 1
      object LabelProcess: TLabel
        Left = 8
        Top = 224
        Width = 84
        Height = 13
        Caption = 'LabelProcess'
      end
      object ButtonStartRebuild: TButton
        Left = 8
        Top = 8
        Width = 75
        Height = 25
        Caption = #24320#22987'(&S)'
        TabOrder = 0
        OnClick = ButtonStartRebuildClick
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 48
        Width = 201
        Height = 145
        Caption = #37325#24314#36873#39033
        TabOrder = 1
        object CheckBoxDelDenyChr: TCheckBox
          Left = 9
          Top = 16
          Width = 145
          Height = 17
          Caption = #21024#38500#24050#31105#29992#30340#35282#33394
          TabOrder = 0
          OnClick = CheckBoxDelDenyChrClick
        end
        object CheckBoxDelAllItem: TCheckBox
          Left = 9
          Top = 48
          Width = 113
          Height = 17
          Caption = #21024#38500#20154#29289#29289#21697
          TabOrder = 1
          OnClick = CheckBoxDelAllItemClick
        end
        object CheckBoxDelAllSkill: TCheckBox
          Left = 9
          Top = 64
          Width = 113
          Height = 17
          Caption = #21024#38500#20154#29289#25216#33021
          TabOrder = 2
          OnClick = CheckBoxDelAllSkillClick
        end
        object CheckBoxDelBonusAbil: TCheckBox
          Left = 9
          Top = 80
          Width = 113
          Height = 17
          Caption = #21024#38500#20154#29289#23646#24615#28857
          TabOrder = 3
          OnClick = CheckBoxDelBonusAbilClick
        end
        object CheckBoxDelLevel: TCheckBox
          Left = 9
          Top = 32
          Width = 184
          Height = 17
          Caption = #21024#38500#20154#29289#31561#32423#21450#30456#20851#20449#24687
          TabOrder = 4
          OnClick = CheckBoxDelLevelClick
        end
        object CheckBoxDelMinLevel: TCheckBox
          Left = 10
          Top = 99
          Width = 183
          Height = 17
          Caption = #21024#38500#31561#32423#23567#20110'        '#35282#33394
          TabOrder = 5
          OnClick = CheckBoxDelMinLevelClick
        end
        object EditLevel: TSpinEdit
          Left = 111
          Top = 96
          Width = 50
          Height = 22
          MaxLength = 1
          MaxValue = 65535
          MinValue = 10
          TabOrder = 6
          Value = 10
          OnChange = EditLevelChange
        end
        object CheckBox1: TCheckBox
          Left = 9
          Top = 120
          Width = 168
          Height = 17
          Caption = #21024#38500#20081#30721#25968#25454#35282#33394
          TabOrder = 7
          OnClick = CheckBox1Click
        end
      end
      object Button1: TButton
        Left = 424
        Top = 8
        Width = 129
        Height = 25
        Hint = #26816#26597'Hum.DB'#19982'Mir.DB'#36134#21495#26159#21542#27491#30830','#38656#35201#26381#21153#20572#27490#21518#25165#33021#36827#34892','
        Caption = #20462#22797'Mir.DB'#30331#38470#36134#21495
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button1Click
      end
      object Memo1: TMemo
        Left = 216
        Top = 48
        Width = 337
        Height = 193
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ScrollBars = ssVertical
        TabOrder = 3
      end
    end
    object TabSheet3: TTabSheet
      Caption = #25968#25454#23548#20986'  '
      ImageIndex = 2
      object Label1: TLabel
        Left = 25
        Top = 43
        Width = 437
        Height = 52
        Caption = 
          #23548#20986#26684#24335#65306#35282#33394#21517' '#30331#38470#36134#21495#13#10#27880#65306#21516#20010#36134#21495#21482#23548#20986#19968#20010#35282#33394#65292#33521#38596#20449#24687#19981#23548#20986' '#27492#21151#33021#36741#21161'M2'#33258#21160#25346#26426#20351#29992#13#10#13#10#23548#20986#25991#20214#38656#25918#21040'\Mi' +
          'r200\Envir\'#30446#24405#19979
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 24
        Top = 128
        Width = 47
        Height = 13
        Caption = 'M2'#30446#24405':'
      end
      object SpeedButton1: TSpeedButton
        Left = 288
        Top = 124
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object Label4: TLabel
        Left = 23
        Top = 163
        Width = 59
        Height = 13
        Caption = #23548#20986#25968#37327':'
      end
      object Label2: TLabel
        Left = 22
        Top = 196
        Width = 246
        Height = 13
        Caption = #23548#20986#31561#32423'>=         <=         '#35282#33394'  '
      end
      object Button2: TButton
        Left = 353
        Top = 156
        Width = 75
        Height = 25
        Caption = #23548#20986
        TabOrder = 0
        OnClick = Button2Click
      end
      object Edit2: TEdit
        Left = 74
        Top = 125
        Width = 215
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ReadOnly = True
        TabOrder = 1
        Text = 'D:\mirserver\Mir200\Envir\'
      end
      object EditUserCount: TSpinEdit
        Left = 85
        Top = 158
        Width = 61
        Height = 22
        Increment = 10
        MaxValue = 1000
        MinValue = 1
        TabOrder = 2
        Value = 100
      end
      object EditMinLevel: TSpinEdit
        Left = 90
        Top = 192
        Width = 56
        Height = 22
        Increment = 10
        MaxValue = 2000
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object EditMaxLevel: TSpinEdit
        Left = 169
        Top = 191
        Width = 61
        Height = 22
        Increment = 10
        MaxValue = 65535
        MinValue = 1
        TabOrder = 4
        Value = 65535
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Hum'#25968#25454
      ImageIndex = 3
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 569
        Height = 245
        ActivePage = TabSheet7
        Align = alClient
        TabOrder = 0
        object TabSheet6: TTabSheet
          Caption = #25968#25454#26597#35810
          object GroupBox4: TGroupBox
            Left = 8
            Top = 0
            Width = 547
            Height = 190
            Caption = 'SQL'
            TabOrder = 0
            object MemoHumQuery: TMemo
              Left = 8
              Top = 14
              Width = 532
              Height = 170
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              Lines.Strings = (
                'SELECT * FROM TBL_CHARACTER')
              TabOrder = 0
            end
          end
          object ButtonHumQuery: TButton
            Left = 446
            Top = 191
            Width = 74
            Height = 24
            Caption = #25191#34892'SQL'
            TabOrder = 1
            OnClick = ButtonHumQueryClick
          end
        end
        object TabSheet7: TTabSheet
          Caption = #25968#25454#20462#25913
          ImageIndex = 1
          object GroupBox5: TGroupBox
            Left = 8
            Top = 0
            Width = 546
            Height = 191
            Caption = 'SQL'
            TabOrder = 0
            object MemoHumEdit: TMemo
              Left = 8
              Top = 16
              Width = 530
              Height = 167
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              Lines.Strings = (
                'SELECT * FROM TBL_CHARACTER')
              TabOrder = 0
            end
          end
          object ButtonHumEdit: TButton
            Left = 446
            Top = 191
            Width = 75
            Height = 25
            Caption = #25191#34892'SQL'
            TabOrder = 1
            OnClick = ButtonHumEditClick
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Mir'#25968#25454
      ImageIndex = 4
    end
  end
  object TimerShowInfo: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerShowInfoTimer
    Left = 544
  end
end
