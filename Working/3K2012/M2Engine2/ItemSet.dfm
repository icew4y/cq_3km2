object frmItemSet: TfrmItemSet
  Left = 275
  Top = 312
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #29305#27530#23646#24615#29289#21697#35774#32622
  ClientHeight = 329
  ClientWidth = 431
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 417
    Height = 313
    ActivePage = TabSheet8
    TabOrder = 0
    object TabSheet8: TTabSheet
      Caption = #29305#27530#23646#24615
      object ItemSetPageControl: TPageControl
        Left = 8
        Top = 4
        Width = 393
        Height = 225
        ActivePage = TabSheet5
        MultiLine = True
        TabOrder = 0
        TabPosition = tpBottom
        object TabSheet1: TTabSheet
          Caption = #32463#39564#32763#20493
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox141: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 161
            Caption = #32463#39564#32763#20493
            TabOrder = 0
            object Label108: TLabel
              Left = 11
              Top = 24
              Width = 30
              Height = 12
              Caption = #20493#29575':'
            end
            object Label109: TLabel
              Left = 8
              Top = 104
              Width = 353
              Height = 49
              AutoSize = False
              Caption = 
                #20493#29575#20197#25345#20037#20026#26631#20934#65292#38500#20197#35774#23450#20540#65292#20026#27491#30495#30340#20493#29575#65292#29289#21697#26368#39640#25345#20037#20026'65'#65292#20063#23601#26159'65000'#28857#65292#20197#27492#25345#20037#26469#31639#38500#20197#35774#32622#30340#25968#23383#23601#26159#20493#25968#20102#65292#22914#26524#35774 +
                #32622#20026'10000'#65292#21017#20026' 6.5'#20493#32463#39564#12290#22914#26524#36523#19978#24102#20102#22810#20010#27492#23646#24615#35013#22791#65292#20493#29575#26159#32047#21152#30340#12290
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditItemExpRate: TSpinEdit
              Left = 56
              Top = 20
              Width = 57
              Height = 21
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditItemExpRateChange
            end
            object GroupBox1: TGroupBox
              Left = 176
              Top = 16
              Width = 185
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [141]'
              TabOrder = 1
              object Label1: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label2: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #25915#20987#32763#20493
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox142: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 161
            Caption = #25915#20987#32763#20493
            TabOrder = 0
            object Label110: TLabel
              Left = 11
              Top = 24
              Width = 30
              Height = 12
              Caption = #20493#29575':'
            end
            object Label3: TLabel
              Left = 8
              Top = 104
              Width = 353
              Height = 49
              AutoSize = False
              Caption = 
                #20493#29575#20197#25345#20037#20026#26631#20934#65292#38500#20197#35774#23450#20540#65292#20026#27491#30495#30340#20493#29575#65292#29289#21697#26368#39640#25345#20037#20026'65'#65292#20063#23601#26159'65000'#28857#65292#20197#27492#25345#20037#26469#31639#38500#20197#35774#32622#30340#25968#23383#23601#26159#20493#25968#20102#65292#22914#26524#35774 +
                #32622#20026'10000'#65292#21017#20026' 6.5'#20493#32463#39564#12290#22914#26524#36523#19978#24102#20102#22810#20010#27492#23646#24615#35013#22791#65292#20493#29575#26159#32047#21152#30340#12290
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditItemPowerRate: TSpinEdit
              Left = 56
              Top = 20
              Width = 57
              Height = 21
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditItemPowerRateChange
            end
            object GroupBox2: TGroupBox
              Left = 176
              Top = 16
              Width = 185
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [142]'
              TabOrder = 1
              object Label4: TLabel
                Left = 3
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label5: TLabel
                Left = 4
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
          end
        end
        object TabSheet3: TTabSheet
          Caption = #32452#38431#20256#36865
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object TabSheet4: TTabSheet
          Caption = #34892#20250#20256#36865
          ImageIndex = 3
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox28: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 161
            Caption = #34892#20250#20256#36865
            TabOrder = 0
            object Label85: TLabel
              Left = 11
              Top = 24
              Width = 54
              Height = 12
              Caption = #20351#29992#38388#38548':'
            end
            object Label86: TLabel
              Left = 8
              Top = 104
              Width = 353
              Height = 49
              AutoSize = False
              Caption = #34892#20250#20256#36865#29289#21697#65292#34892#20250#25484#38376#20154#25165#33021#20351#29992#65292#23558#25972#20010#34892#20250#25104#21592#20840#37096#38598#20013#20110#20256#36865#25484#38376#20154#36523#36793#12290#34987#20256#36865#25104#21592#65292#24517#39035#20351#29992#21629#20196#20801#35768#34892#20250#20256#36865#12290
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              WordWrap = True
            end
            object EditGuildRecallTime: TSpinEdit
              Left = 72
              Top = 20
              Width = 57
              Height = 21
              Hint = #37325#22797#20351#29992#27492#21151#33021#65292#25152#38656#38388#38548#26102#38388#12290#27492#35774#32622#20462#25913#21518#19981#33021#31435#21363#29983#25928#65292#38656#22312#19979#27425#20351#29992#26102#29983#25928#12290
              EditorEnabled = False
              MaxValue = 60000
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditGuildRecallTimeChange
            end
            object GroupBox29: TGroupBox
              Left = 176
              Top = 16
              Width = 185
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [145]'
              TabOrder = 1
              object Label87: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label88: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = #40635#30201#25915#20987
          ImageIndex = 4
          object GroupBox44: TGroupBox
            Left = 8
            Top = 0
            Width = 374
            Height = 180
            Caption = #40635#30201#25915#20987
            TabOrder = 0
            object GroupBox45: TGroupBox
              Left = 166
              Top = 12
              Width = 204
              Height = 55
              Caption = #25968#25454#24211#35774#32622#32534#21495' [113,190,191,201]'
              TabOrder = 0
              object Label122: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label123: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
            object GroupBox70: TGroupBox
              Left = 11
              Top = 12
              Width = 150
              Height = 55
              Caption = '113'#25106#25351#21442#25968
              TabOrder = 1
              object Label120: TLabel
                Left = 11
                Top = 15
                Width = 54
                Height = 12
                Caption = #40635#30201#26426#29575':'
              end
              object Label116: TLabel
                Left = 11
                Top = 35
                Width = 54
                Height = 12
                Caption = #40635#30201#26102#38388':'
              end
              object Label124: TLabel
                Left = 126
                Top = 35
                Width = 12
                Height = 12
                Caption = #31186
              end
              object EditAttackPosionRate: TSpinEdit
                Left = 72
                Top = 11
                Width = 49
                Height = 21
                Hint = #40635#30201#25104#21151#26426#29575#65292#25968#23383#36234#23567#26426#29575#36234#22823#65292#27492#35774#32622#40664#35748#20026'5'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 0
                Value = 100
                OnChange = EditAttackPosionRateChange
              end
              object EditAttackPosionTime: TSpinEdit
                Left = 72
                Top = 31
                Width = 49
                Height = 21
                Hint = '113-'#40635#30201#26102#38388#38271#24230#65292#21333#20301#31186#65292#40664#35748#35774#32622#20026'6'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 1
                Value = 100
                OnChange = EditAttackPosionTimeChange
              end
            end
            object GroupBox71: TGroupBox
              Left = 11
              Top = 67
              Width = 150
              Height = 57
              Caption = '190'#25106#25351#21442#25968
              TabOrder = 2
              object Label194: TLabel
                Left = 11
                Top = 17
                Width = 54
                Height = 12
                Caption = #40635#30201#26426#29575':'
              end
              object Label192: TLabel
                Left = 11
                Top = 37
                Width = 126
                Height = 12
                Caption = #40635#30201#26102#38388':          '#31186
              end
              object EditAttackPosionRate1: TSpinEdit
                Left = 72
                Top = 13
                Width = 49
                Height = 21
                Hint = #40635#30201#25104#21151#26426#29575#65292#25968#23383#36234#23567#26426#29575#36234#22823#65292#27492#35774#32622#40664#35748#20026'3'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 0
                Value = 100
                OnChange = EditAttackPosionRate1Change
              end
              object EditAttackPosionTime1: TSpinEdit
                Left = 72
                Top = 33
                Width = 49
                Height = 21
                Hint = '190-'#40635#30201#26102#38388#38271#24230#65292#21333#20301#31186#65292#40664#35748#35774#32622#20026'2'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 1
                Value = 100
                OnChange = EditAttackPosionTime1Change
              end
            end
            object GroupBox72: TGroupBox
              Left = 11
              Top = 124
              Width = 150
              Height = 53
              Caption = '191'#25106#25351#21442#25968
              TabOrder = 3
              object Label195: TLabel
                Left = 11
                Top = 14
                Width = 54
                Height = 12
                Caption = #40635#30201#26426#29575':'
              end
              object Label193: TLabel
                Left = 11
                Top = 33
                Width = 126
                Height = 12
                Caption = #40635#30201#26102#38388':          '#31186
              end
              object EditAttackPosionRate2: TSpinEdit
                Left = 72
                Top = 10
                Width = 49
                Height = 21
                Hint = #40635#30201#25104#21151#26426#29575#65292#25968#23383#36234#23567#26426#29575#36234#22823#65292#27492#35774#32622#40664#35748#20026'5'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 0
                Value = 100
                OnChange = EditAttackPosionRate2Change
              end
              object EditAttackPosionTime2: TSpinEdit
                Left = 72
                Top = 30
                Width = 49
                Height = 21
                Hint = '191-'#40635#30201#26102#38388#38271#24230#65292#21333#20301#31186#65292#40664#35748#35774#32622#20026'2('#39764#36947#40635#30201#25106#25351')'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 1
                Value = 100
                OnChange = EditAttackPosionTime2Change
              end
            end
            object GroupBox76: TGroupBox
              Left = 167
              Top = 68
              Width = 150
              Height = 53
              Caption = '201'#25106#25351#21442#25968
              TabOrder = 4
              object Label200: TLabel
                Left = 11
                Top = 14
                Width = 54
                Height = 12
                Caption = #40635#30201#26426#29575':'
              end
              object Label202: TLabel
                Left = 11
                Top = 33
                Width = 126
                Height = 12
                Caption = #40635#30201#26102#38388':          '#31186
              end
              object EditAttackPosionRate3: TSpinEdit
                Left = 72
                Top = 10
                Width = 49
                Height = 21
                Hint = #40635#30201#25104#21151#26426#29575#65292#25968#23383#36234#23567#26426#29575#36234#22823#65292#27492#35774#32622#40664#35748#20026'5'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 0
                Value = 100
                OnChange = EditAttackPosionRate3Change
              end
              object EditAttackPosionTime3: TSpinEdit
                Left = 72
                Top = 30
                Width = 49
                Height = 21
                Hint = '201-'#40635#30201#26102#38388#38271#24230#65292#21333#20301#31186#65292#40664#35748#35774#32622#20026'3('#39764#24847#40635#30201#25106#25351')'
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 1
                Value = 100
                OnChange = EditAttackPosionTime3Change
              end
            end
          end
        end
        object TabSheet6: TTabSheet
          Caption = #20256#36865
          ImageIndex = 5
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox43: TGroupBox
            Left = 8
            Top = 8
            Width = 369
            Height = 161
            Caption = #20256#36865
            TabOrder = 0
            object GroupBox46: TGroupBox
              Left = 176
              Top = 16
              Width = 185
              Height = 81
              Caption = #25968#25454#24211#35774#32622#32534#21495' [112]'
              TabOrder = 0
              object Label117: TLabel
                Left = 8
                Top = 16
                Width = 180
                Height = 12
                Caption = #27494#22120#12289#34593#28891#31867#20351#29992#23383#27573': AniCount'
              end
              object Label118: TLabel
                Left = 8
                Top = 32
                Width = 126
                Height = 12
                Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
              end
            end
            object GroupBox47: TGroupBox
              Left = 8
              Top = 16
              Width = 161
              Height = 81
              Caption = #21442#25968
              TabOrder = 1
              object Label119: TLabel
                Left = 11
                Top = 56
                Width = 54
                Height = 12
                Caption = #20351#29992#38388#38548':'
              end
              object Label121: TLabel
                Left = 123
                Top = 56
                Width = 12
                Height = 12
                Caption = #31186
              end
              object CheckBoxUserMoveCanDupObj: TCheckBox
                Left = 8
                Top = 16
                Width = 137
                Height = 17
                Hint = #20851#38381#27492#36873#39033#21518#65292#20256#36865#24231#26631#19978#26377#35282#33394#26102#23558#19981#20801#35768#20256#36865
                Caption = #20801#35768#20256#36865#35282#33394#37325#21472
                TabOrder = 0
                OnClick = CheckBoxUserMoveCanDupObjClick
              end
              object CheckBoxUserMoveCanOnItem: TCheckBox
                Left = 8
                Top = 32
                Width = 137
                Height = 17
                Hint = #20851#38381#27492#36873#39033#21518#65292#20256#36865#24231#26631#19978#26377#29289#21697#26102#23558#19981#20801#35768#20256#36865
                Caption = #20801#35768#20256#36865#29289#21697#37325#21472
                TabOrder = 1
                OnClick = CheckBoxUserMoveCanOnItemClick
              end
              object EditUserMoveTime: TSpinEdit
                Left = 72
                Top = 52
                Width = 49
                Height = 21
                Hint = #20256#36865#21629#20196#20351#29992#38388#38548#26102#38388
                EditorEnabled = False
                MaxValue = 100
                MinValue = 1
                TabOrder = 2
                Value = 100
                OnChange = EditUserMoveTimeChange
              end
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = #26007#31520
          ImageIndex = 6
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox48: TGroupBox
            Left = 12
            Top = 9
            Width = 132
            Height = 48
            Caption = #31070#31192#20154#36873#39033
            TabOrder = 0
            object CheckBoxUnKnowHum: TCheckBox
              Left = 15
              Top = 19
              Width = 113
              Height = 17
              Hint = #24102#19978#26007#31520','#21363#26174#31034#31070#31192#20154
              Caption = #24102#19978#26174#31034#31070#31192#20154
              TabOrder = 0
              OnClick = CheckBoxUnKnowHumClick
            end
          end
          object GroupBox69: TGroupBox
            Left = 176
            Top = 16
            Width = 185
            Height = 89
            Caption = #25968#25454#24211#35774#32622#32534#21495' [112]'
            TabOrder = 1
            object Label190: TLabel
              Left = 8
              Top = 16
              Width = 126
              Height = 24
              Caption = #26007#31520': Shape=0,1,3,4,5'#13#10#40657#24062': Shape=2'
            end
            object Label191: TLabel
              Left = 8
              Top = 48
              Width = 156
              Height = 36
              Caption = 'Anicount 0-'#20027#20307#33521#38596#20840#21487#24102' '#13#10'         1-'#20027#20307#21487#24102#13#10'         2-'#33521#38596#21487#24102
            end
          end
        end
        object TabSheet23: TTabSheet
          Caption = #22797#27963#37325#29983
          ImageIndex = 7
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox73: TGroupBox
            Left = 3
            Top = 4
            Width = 190
            Height = 55
            Caption = '114'#25106#25351'('#22797#27963#25106#25351')'
            TabOrder = 0
            object Label199: TLabel
              Left = 10
              Top = 19
              Width = 126
              Height = 12
              Caption = #20351#29992#38388#38548':          '#31186
            end
            object EditRevivalTime: TSpinEdit
              Left = 64
              Top = 15
              Width = 57
              Height = 21
              Hint = #40664#35748#35774#32622#20026'60'
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRevivalTimeChange
            end
            object CheckBoxRevivalTick: TCheckBox
              Left = 8
              Top = 36
              Width = 180
              Height = 15
              Hint = #20154#29289#30331#24405#26102','#24320#22987#35745#26102#22797#27963#38388#38548','#21363#20154#29289#23567#36864','#38656#36798#21040#19968#23450#38388#38548#25165#21487#20351#29992#22797#27963#12290
              Caption = #20154#29289#30331#38470#21518#21021#22987#22797#27963#25106#25351#26102#38388
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = CheckBoxRevivalTickClick
            end
          end
          object GroupBox74: TGroupBox
            Left = 2
            Top = 63
            Width = 190
            Height = 55
            Caption = '197'#25106#25351'('#37325#29983#25106#25351')'
            TabOrder = 1
            object Label198: TLabel
              Left = 11
              Top = 19
              Width = 126
              Height = 12
              Caption = #20351#29992#38388#38548':          '#31186
            end
            object EditRebirthTime: TSpinEdit
              Left = 64
              Top = 15
              Width = 57
              Height = 21
              Hint = #40664#35748#35774#32622#20026'300'
              EditorEnabled = False
              MaxValue = 65535
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRebirthTimeChange
            end
            object CheckBoxRebirthTick: TCheckBox
              Left = 8
              Top = 36
              Width = 180
              Height = 15
              Hint = #20154#29289#30331#24405#26102','#24320#22987#35745#26102#37325#29983#25106#25351#20351#29992#38388#38548','#21363#20154#29289#23567#36864','#38656#36798#21040#19968#23450#38388#38548#25165#21487#20351#29992#37325#29983#12290
              Caption = #20154#29289#30331#38470#21518#21021#22987#37325#29983#25106#25351#26102#38388
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = CheckBoxRebirthTickClick
            end
          end
          object GroupBox75: TGroupBox
            Left = 198
            Top = 4
            Width = 176
            Height = 53
            Caption = #25968#25454#24211#35774#32622#32534#21495' [114'#12289'197]'
            TabOrder = 2
            object Label201: TLabel
              Left = 8
              Top = 19
              Width = 126
              Height = 12
              Caption = #39318#39280#31867#20351#29992#23383#27573': Shape'
            end
          end
          object GroupBox77: TGroupBox
            Left = 3
            Top = 122
            Width = 189
            Height = 53
            Caption = #20854#23427#35774#32622
            TabOrder = 3
            object CheckBoxUnderWarMove: TCheckBox
              Left = 3
              Top = 16
              Width = 183
              Height = 15
              Hint = 
                #22312#30343#23467#20869#22797#27963#25110#37325#29983#29983#25928#26102','#20154#29289#20256#36865#22238#25915#26041#22238#22478#28857'(SabukW.txt )'#13#10'CastleWarAreaHomeMap=3'#13#10'Ca' +
                'stleWarAreaHomeX=330'#13#10'CastleWarAreaHomeY=330'#13#10#33521#38596#19981#21463#24433#21709
              Caption = #25915#22478#26399#30343#23467#22797#27963#37325#29983#26102#22320#22270#20256#36865
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = CheckBoxUnderWarMoveClick
            end
          end
        end
        object TabSheet24: TTabSheet
          Caption = #20260#23475#21560#25910
          ImageIndex = 8
          object Label203: TLabel
            Left = 17
            Top = 80
            Width = 126
            Height = 12
            Caption = 'Shape '#23383#27573#20026' 188, 203'
          end
          object GroupBox78: TGroupBox
            Left = 12
            Top = 12
            Width = 144
            Height = 44
            Caption = 'FSD'
            TabOrder = 0
            object CheckBox1: TCheckBox
              Left = 7
              Top = 17
              Width = 129
              Height = 17
              Hint = #21246#19978'='#25106#25351#25163#38255#21482#35745#31639#19968#20214'.'
              Caption = #25106#25351#25163#38255#21482#35745#31639#19968#20214
              TabOrder = 0
              OnClick = CheckBox1Click
            end
          end
        end
      end
      object ButtonItemSetSave: TButton
        Left = 334
        Top = 237
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonItemSetSaveClick
      end
    end
    object TabSheet19: TTabSheet
      Caption = #31070#31192#22871#35013
      ImageIndex = 2
      object PageControl1: TPageControl
        Left = 8
        Top = 4
        Width = 393
        Height = 253
        ActivePage = TabSheet27
        MultiLine = True
        TabOrder = 0
        TabPosition = tpBottom
        object TabSheet27: TTabSheet
          Caption = #25106#25351#31867
          ImageIndex = 7
          object GroupBox49: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 65
            Caption = #25915#20987
            TabOrder = 0
            object Label152: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label153: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowRingDCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowRingDCAddRateChange
            end
            object EditUnknowRingDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowRingDCAddValueMaxLimitChange
            end
          end
          object GroupBox50: TGroupBox
            Left = 8
            Top = 80
            Width = 113
            Height = 65
            Caption = #39764#27861
            TabOrder = 1
            object Label155: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label156: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowRingMCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowRingMCAddRateChange
            end
            object EditUnknowRingMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowRingMCAddValueMaxLimitChange
            end
          end
          object GroupBox51: TGroupBox
            Left = 8
            Top = 152
            Width = 113
            Height = 65
            Caption = #36947#26415
            TabOrder = 2
            object Label158: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label159: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowRingSCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowRingSCAddRateChange
            end
            object EditUnknowRingSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowRingSCAddValueMaxLimitChange
            end
          end
          object GroupBox30: TGroupBox
            Left = 128
            Top = 8
            Width = 113
            Height = 65
            Caption = #38450#24481
            TabOrder = 3
            object Label89: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label90: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowRingACAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowRingACAddRateChange
            end
            object EditUnknowRingACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowRingACAddValueMaxLimitChange
            end
          end
          object GroupBox31: TGroupBox
            Left = 128
            Top = 80
            Width = 113
            Height = 65
            Caption = #39764#27861#38450#24481
            TabOrder = 4
            object Label91: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label92: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowRingMACAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowRingMACAddRateChange
            end
            object EditUnknowRingMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowRingMACAddValueMaxLimitChange
            end
          end
        end
        object TabSheet25: TTabSheet
          Caption = #25163#38255#31867
          ImageIndex = 5
          object GroupBox32: TGroupBox
            Left = 8
            Top = 152
            Width = 113
            Height = 65
            Caption = #36947#26415
            TabOrder = 0
            object Label93: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label94: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowNecklaceSCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowNecklaceSCAddRateChange
            end
            object EditUnknowNecklaceSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowNecklaceSCAddValueMaxLimitChange
            end
          end
          object GroupBox33: TGroupBox
            Left = 128
            Top = 80
            Width = 113
            Height = 65
            Caption = #39764#27861#38450#24481
            TabOrder = 1
            object Label95: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label96: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowNecklaceMACAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowNecklaceMACAddRateChange
            end
            object EditUnknowNecklaceMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowNecklaceMACAddValueMaxLimitChange
            end
          end
          object GroupBox34: TGroupBox
            Left = 128
            Top = 8
            Width = 113
            Height = 65
            Caption = #38450#24481
            TabOrder = 2
            object Label97: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label98: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowNecklaceACAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowNecklaceACAddRateChange
            end
            object EditUnknowNecklaceACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowNecklaceACAddValueMaxLimitChange
            end
          end
          object GroupBox35: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 65
            Caption = #25915#20987
            TabOrder = 3
            object Label99: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label100: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowNecklaceDCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowNecklaceDCAddRateChange
            end
            object EditUnknowNecklaceDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowNecklaceDCAddValueMaxLimitChange
            end
          end
          object GroupBox36: TGroupBox
            Left = 8
            Top = 80
            Width = 113
            Height = 65
            Caption = #39764#27861
            TabOrder = 4
            object Label101: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label102: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowNecklaceMCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowNecklaceMCAddRateChange
            end
            object EditUnknowNecklaceMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowNecklaceMCAddValueMaxLimitChange
            end
          end
        end
        object TabSheet20: TTabSheet
          Caption = #22836#30420#31867
          ImageIndex = 2
          object GroupBox37: TGroupBox
            Left = 8
            Top = 152
            Width = 113
            Height = 65
            Caption = #36947#26415
            TabOrder = 0
            object Label103: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label104: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowHelMetSCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowHelMetSCAddRateChange
            end
            object EditUnknowHelMetSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowHelMetSCAddValueMaxLimitChange
            end
          end
          object GroupBox38: TGroupBox
            Left = 8
            Top = 80
            Width = 113
            Height = 65
            Caption = #39764#27861
            TabOrder = 1
            object Label105: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label106: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowHelMetMCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowHelMetMCAddRateChange
            end
            object EditUnknowHelMetMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowHelMetMCAddValueMaxLimitChange
            end
          end
          object GroupBox39: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 65
            Caption = #25915#20987
            TabOrder = 2
            object Label107: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label111: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowHelMetDCAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowHelMetDCAddRateChange
            end
            object EditUnknowHelMetDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowHelMetDCAddValueMaxLimitChange
            end
          end
          object GroupBox40: TGroupBox
            Left = 128
            Top = 8
            Width = 113
            Height = 65
            Caption = #38450#24481
            TabOrder = 3
            object Label112: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label113: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowHelMetACAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowHelMetACAddRateChange
            end
            object EditUnknowHelMetACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowHelMetACAddValueMaxLimitChange
            end
          end
          object GroupBox41: TGroupBox
            Left = 128
            Top = 80
            Width = 113
            Height = 65
            Caption = #39764#27861#38450#24481
            TabOrder = 4
            object Label114: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label115: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object EditUnknowHelMetMACAddRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditUnknowHelMetMACAddRateChange
            end
            object EditUnknowHelMetMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditUnknowHelMetMACAddValueMaxLimitChange
            end
          end
        end
      end
      object ButtonUnKnowItemSave: TButton
        Left = 334
        Top = 253
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonUnKnowItemSaveClick
      end
    end
    object TabSheet9: TTabSheet
      Caption = #26497#21697#26426#29575
      ImageIndex = 1
      object AddValuePageControl: TPageControl
        Left = 8
        Top = 4
        Width = 393
        Height = 245
        ActivePage = TabSheet14
        MultiLine = True
        TabOrder = 0
        TabPosition = tpBottom
        object TabSheet10: TTabSheet
          Caption = #26426#29575#25511#21046
          object Label188: TLabel
            Left = 152
            Top = 11
            Width = 228
            Height = 72
            Caption = 
              #35828#26126':'#22914#35774#32622'"'#24618#29289#25481#33853'"'#26426#29575#20026'1'#65292#24182#19981#26159#13'     '#30334#20998#30334#20986#26497#21697#23646#24615#65307#22914#26524#35201#35774#32622#27494#22120#13'     '#25171#24618#30334#20998#30334#20986#26497#21697#65292#38500#20102#35774#32622'"'#24618#29289 +
              #13'     '#25481#33853'"'#26426#29575#20026'1'#22806#65292#27494#22120#31867#19979#30340#21508#23646#24615#13'     '#35774#32622#37324#30340'"'#23646#24615#26426#29575'"'#20063#35201#35774#32622#20026'1'#65292#36825#13'     '#26679#25171#24618#25165#33021#30334#20998#30334#20986#26497#21697 +
              #12290'      '
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox3: TGroupBox
            Left = 8
            Top = 8
            Width = 137
            Height = 94
            Caption = #26497#21697#20986#29616#26426#29575
            TabOrder = 0
            object Label6: TLabel
              Left = 11
              Top = 22
              Width = 54
              Height = 12
              Caption = #24618#29289#25481#33853':'
            end
            object Label7: TLabel
              Left = 11
              Top = 47
              Width = 54
              Height = 12
              Caption = #21629#20196#21046#36896':'
            end
            object Label189: TLabel
              Left = 11
              Top = 72
              Width = 54
              Height = 12
              Caption = #20154' '#24418' '#24618':'
            end
            object EditMonRandomAddValue: TSpinEdit
              Left = 72
              Top = 18
              Width = 57
              Height = 21
              Hint = #24618#29289#27515#20129#25481#33853#29289#21697#26497#21697#20986#29616#26426#29575#65292#25968#25454#36234#22823#65292#26426#29575#36234#23567#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditMonRandomAddValueChange
            end
            object EditMakeRandomAddValue: TSpinEdit
              Left = 72
              Top = 43
              Width = 57
              Height = 21
              Hint = 'GM'#21629#20196#21046#36896#29289#21697#26497#21697#20986#29616#26426#29575#65292#25968#25454#36234#22823#65292#26426#29575#36234#23567#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditMakeRandomAddValueChange
            end
            object EditPlayMonRandomAddValue: TSpinEdit
              Left = 72
              Top = 68
              Width = 57
              Height = 21
              Hint = #25366#20154#24418#24618','#21462#24471#35013#22791#20986#29616#26497#21697#30340#26426#29575','#25968#20540#36234#23567','#26426#29575#36234#39640
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditPlayMonRandomAddValueChange
            end
          end
        end
        object TabSheet11: TTabSheet
          Caption = #27494#22120#31867
          ImageIndex = 1
          object Label32: TLabel
            Left = 8
            Top = 185
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
          object GroupBox4: TGroupBox
            Left = 8
            Top = 0
            Width = 113
            Height = 90
            Caption = #25915#20987
            TabOrder = 0
            object Label8: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label9: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label186: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponDCAddValueMaxLimitChange
            end
            object EditWeaponDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponDCAddValueRateChange
            end
            object EditWeaponDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponDCAddRateChange
            end
          end
          object GroupBox5: TGroupBox
            Left = 8
            Top = 93
            Width = 113
            Height = 86
            Caption = #39764#27861
            TabOrder = 1
            object Label10: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label11: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label185: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponMCAddValueMaxLimitChange
            end
            object EditWeaponMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponMCAddValueRateChange
            end
            object EditWeaponMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponMCAddRateChange
            end
          end
          object GroupBox6: TGroupBox
            Left = 128
            Top = 0
            Width = 113
            Height = 90
            Caption = #36947#26415
            TabOrder = 2
            object Label12: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label13: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label187: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditWeaponSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditWeaponSCAddValueMaxLimitChange
            end
            object EditWeaponSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditWeaponSCAddValueRateChange
            end
            object EditWeaponSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditWeaponSCAddRateChange
            end
          end
        end
        object TabSheet12: TTabSheet
          Caption = #34915#26381#31867
          ImageIndex = 2
          object Label33: TLabel
            Left = 136
            Top = 184
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
          object GroupBox7: TGroupBox
            Left = 8
            Top = 2
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 0
            object Label14: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label15: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label20: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressDCAddValueMaxLimitChange
            end
            object EditDressDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressDCAddValueRateChange
            end
            object EditDressDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressDCAddRateChange
            end
          end
          object GroupBox8: TGroupBox
            Left = 248
            Top = 2
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 1
            object Label16: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label17: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label21: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressMCAddValueMaxLimitChange
            end
            object EditDressMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressMCAddValueRateChange
            end
            object EditDressMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressMCAddRateChange
            end
          end
          object GroupBox9: TGroupBox
            Left = 128
            Top = 2
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 2
            object Label18: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label19: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label22: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressSCAddValueMaxLimitChange
            end
            object EditDressSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressSCAddValueRateChange
            end
            object EditDressSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressSCAddRateChange
            end
          end
          object GroupBox67: TGroupBox
            Left = 8
            Top = 94
            Width = 113
            Height = 86
            Caption = #38450#24481
            TabOrder = 3
            object Label179: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label180: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label181: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressACAddValueMaxLimitChange
            end
            object EditDressACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressACAddValueRateChange
            end
            object EditDressACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressACAddRateChange
            end
          end
          object GroupBox68: TGroupBox
            Left = 129
            Top = 94
            Width = 113
            Height = 86
            Caption = #39764#24481
            TabOrder = 4
            object Label182: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label183: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label184: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditDressMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditDressMACAddValueMaxLimitChange
            end
            object EditDressMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditDressMACAddValueRateChange
            end
            object EditDressMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditDressMACAddRateChange
            end
          end
        end
        object TabSheet13: TTabSheet
          Caption = #39033#38142#31867
          ImageIndex = 3
          object Label34: TLabel
            Left = 130
            Top = 187
            Width = 246
            Height = 12
            Caption = #39033#38142#31867'('#24184#36816#31867')'#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 19'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox10: TGroupBox
            Left = 8
            Top = 1
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 0
            object Label23: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label24: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label25: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace19DCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace19DCAddValueMaxLimitChange
            end
            object EditNeckLace19DCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace19DCAddValueRateChange
            end
            object EditNeckLace19DCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace19DCAddRateChange
            end
          end
          object GroupBox11: TGroupBox
            Left = 248
            Top = 1
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 1
            object Label26: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label27: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label28: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace19MCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace19MCAddValueMaxLimitChange
            end
            object EditNeckLace19MCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace19MCAddValueRateChange
            end
            object EditNeckLace19MCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace19MCAddRateChange
            end
          end
          object GroupBox12: TGroupBox
            Left = 128
            Top = 1
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 2
            object Label29: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label30: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label31: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace19SCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace19SCAddValueMaxLimitChange
            end
            object EditNeckLace19SCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace19SCAddValueRateChange
            end
            object EditNeckLace19SCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace19SCAddRateChange
            end
          end
          object GroupBox61: TGroupBox
            Left = 8
            Top = 90
            Width = 113
            Height = 86
            Caption = #38450#24481
            TabOrder = 3
            object Label161: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label162: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label163: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace19ACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace19ACAddValueMaxLimitChange
            end
            object EditNeckLace19ACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace19ACAddValueRateChange
            end
            object EditNeckLace19ACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace19ACAddRateChange
            end
          end
          object GroupBox62: TGroupBox
            Left = 129
            Top = 90
            Width = 113
            Height = 86
            Caption = #24184#36816'(MAC2)'
            TabOrder = 4
            object Label164: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label165: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label166: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace19MACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace19MACAddValueMaxLimitChange
            end
            object EditNeckLace19MACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace19MACAddValueRateChange
            end
            object EditNeckLace19MACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace19MACAddRateChange
            end
          end
        end
        object TabSheet14: TTabSheet
          Caption = #39033#38142#12289#25163#38255#12289#25106#25351
          ImageIndex = 4
          object Label35: TLabel
            Left = 104
            Top = 183
            Width = 276
            Height = 12
            Caption = #39033#38142#25163#38255#25106#25351#31867#65292#25968#25454#24211#23383#27573' StdMode 20,21,24,27'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox13: TGroupBox
            Left = 8
            Top = 1
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 0
            object Label36: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label37: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label38: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace202124DCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace202124DCAddValueMaxLimitChange
            end
            object EditNeckLace202124DCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace202124DCAddValueRateChange
            end
            object EditNeckLace202124DCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace202124DCAddRateChange
            end
          end
          object GroupBox14: TGroupBox
            Left = 248
            Top = 1
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 1
            object Label39: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label40: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label41: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace202124MCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace202124MCAddValueMaxLimitChange
            end
            object EditNeckLace202124MCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace202124MCAddValueRateChange
            end
            object EditNeckLace202124MCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace202124MCAddRateChange
            end
          end
          object GroupBox15: TGroupBox
            Left = 128
            Top = 1
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 2
            object Label42: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label43: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label44: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace202124SCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace202124SCAddValueMaxLimitChange
            end
            object EditNeckLace202124SCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace202124SCAddValueRateChange
            end
            object EditNeckLace202124SCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace202124SCAddRateChange
            end
          end
          object GroupBox65: TGroupBox
            Left = 8
            Top = 92
            Width = 113
            Height = 86
            Caption = #38450#24481
            TabOrder = 3
            object Label173: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label174: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label175: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace202124ACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace202124ACAddValueMaxLimitChange
            end
            object EditNeckLace202124ACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace202124ACAddValueRateChange
            end
            object EditNeckLace202124ACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace202124ACAddRateChange
            end
          end
          object GroupBox66: TGroupBox
            Left = 129
            Top = 92
            Width = 113
            Height = 86
            Caption = #39764#24481
            TabOrder = 4
            object Label176: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label177: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label178: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditNeckLace202124MACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditNeckLace202124MACAddValueMaxLimitChange
            end
            object EditNeckLace202124MACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditNeckLace202124MACAddValueRateChange
            end
            object EditNeckLace202124MACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditNeckLace202124MACAddRateChange
            end
          end
        end
        object TabSheet15: TTabSheet
          Caption = #25163#38255#31867
          ImageIndex = 5
          object Label54: TLabel
            Left = 179
            Top = 186
            Width = 198
            Height = 12
            Caption = #25163#38255#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 26'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox16: TGroupBox
            Left = 248
            Top = 0
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 0
            object Label45: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label46: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label47: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRing26MCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRing26MCAddValueMaxLimitChange
            end
            object EditArmRing26MCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRing26MCAddValueRateChange
            end
            object EditArmRing26MCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRing26MCAddRateChange
            end
          end
          object GroupBox17: TGroupBox
            Left = 8
            Top = 0
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 1
            object Label48: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label49: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label50: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRing26DCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRing26DCAddValueMaxLimitChange
            end
            object EditArmRing26DCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRing26DCAddValueRateChange
            end
            object EditArmRing26DCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRing26DCAddRateChange
            end
          end
          object GroupBox18: TGroupBox
            Left = 128
            Top = 0
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 2
            object Label51: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label52: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label53: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRing26SCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRing26SCAddValueMaxLimitChange
            end
            object EditArmRing26SCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRing26SCAddValueRateChange
            end
            object EditArmRing26SCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRing26SCAddRateChange
            end
          end
          object GroupBox63: TGroupBox
            Left = 8
            Top = 92
            Width = 113
            Height = 86
            Caption = #38450#24481
            TabOrder = 3
            object Label167: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label168: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label169: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRing26ACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRing26ACAddValueMaxLimitChange
            end
            object EditArmRing26ACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRing26ACAddValueRateChange
            end
            object EditArmRing26ACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRing26ACAddRateChange
            end
          end
          object GroupBox64: TGroupBox
            Left = 129
            Top = 92
            Width = 113
            Height = 86
            Caption = #39764#24481
            TabOrder = 4
            object Label170: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label171: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label172: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditArmRing26MACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditArmRing26MACAddValueMaxLimitChange
            end
            object EditArmRing26MACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditArmRing26MACAddValueRateChange
            end
            object EditArmRing26MACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditArmRing26MACAddRateChange
            end
          end
        end
        object TabSheet16: TTabSheet
          Caption = #25106#25351#31867
          ImageIndex = 6
          object Label64: TLabel
            Left = 136
            Top = 176
            Width = 198
            Height = 12
            Caption = #25106#25351#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 22'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox19: TGroupBox
            Left = 8
            Top = 8
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 0
            object Label55: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label56: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label57: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRing22DCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRing22DCAddValueMaxLimitChange
            end
            object EditRing22DCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRing22DCAddValueRateChange
            end
            object EditRing22DCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRing22DCAddRateChange
            end
          end
          object GroupBox20: TGroupBox
            Left = 128
            Top = 8
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 1
            object Label58: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label59: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label60: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRing22SCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRing22SCAddValueMaxLimitChange
            end
            object EditRing22SCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRing22SCAddValueRateChange
            end
            object EditRing22SCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRing22SCAddRateChange
            end
          end
          object GroupBox21: TGroupBox
            Left = 8
            Top = 104
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 2
            object Label61: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label62: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label63: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRing22MCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRing22MCAddValueMaxLimitChange
            end
            object EditRing22MCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRing22MCAddValueRateChange
            end
            object EditRing22MCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRing22MCAddRateChange
            end
          end
        end
        object TabSheet17: TTabSheet
          Caption = #25106#25351#31867
          ImageIndex = 7
          object Label74: TLabel
            Left = 173
            Top = 187
            Width = 198
            Height = 12
            Caption = #25106#25351#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 23'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox22: TGroupBox
            Left = 9
            Top = 0
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 0
            object Label65: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label66: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label67: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRing23DCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRing23DCAddValueMaxLimitChange
            end
            object EditRing23DCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRing23DCAddValueRateChange
            end
            object EditRing23DCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRing23DCAddRateChange
            end
          end
          object GroupBox23: TGroupBox
            Left = 258
            Top = 0
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 1
            object Label68: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label69: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label70: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRing23MCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRing23MCAddValueMaxLimitChange
            end
            object EditRing23MCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRing23MCAddValueRateChange
            end
            object EditRing23MCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRing23MCAddRateChange
            end
          end
          object GroupBox24: TGroupBox
            Left = 134
            Top = 0
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 2
            object Label71: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label72: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label73: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRing23SCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRing23SCAddValueMaxLimitChange
            end
            object EditRing23SCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRing23SCAddValueRateChange
            end
            object EditRing23SCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRing23SCAddRateChange
            end
          end
          object GroupBox59: TGroupBox
            Left = 8
            Top = 89
            Width = 113
            Height = 86
            Caption = #38450#24481
            TabOrder = 3
            object Label149: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label150: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label151: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRing23ACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRing23ACAddValueMaxLimitChange
            end
            object EditRing23ACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRing23ACAddValueRateChange
            end
            object EditRing23ACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRing23ACAddRateChange
            end
          end
          object GroupBox60: TGroupBox
            Left = 134
            Top = 89
            Width = 113
            Height = 86
            Caption = #39764#24481
            TabOrder = 4
            object Label154: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label157: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label160: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditRing23MACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditRing23MACAddValueMaxLimitChange
            end
            object EditRing23MACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditRing23MACAddValueRateChange
            end
            object EditRing23MACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditRing23MACAddRateChange
            end
          end
        end
        object TabSheet18: TTabSheet
          Caption = #22836#30420#12289#26007#31520#31867
          ImageIndex = 8
          object Label84: TLabel
            Left = 176
            Top = 175
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
          object Label125: TLabel
            Left = 176
            Top = 189
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
          object GroupBox25: TGroupBox
            Left = 8
            Top = 0
            Width = 113
            Height = 89
            Caption = #25915#20987
            TabOrder = 0
            object Label75: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label76: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label77: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelMetDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelMetDCAddValueMaxLimitChange
            end
            object EditHelMetDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelMetDCAddValueRateChange
            end
            object EditHelMetDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelMetDCAddRateChange
            end
          end
          object GroupBox26: TGroupBox
            Left = 248
            Top = 0
            Width = 113
            Height = 89
            Caption = #39764#27861
            TabOrder = 1
            object Label78: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label79: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label80: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelMetMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelMetMCAddValueMaxLimitChange
            end
            object EditHelMetMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelMetMCAddValueRateChange
            end
            object EditHelMetMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelMetMCAddRateChange
            end
          end
          object GroupBox27: TGroupBox
            Left = 128
            Top = 0
            Width = 113
            Height = 89
            Caption = #36947#26415
            TabOrder = 2
            object Label81: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label82: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label83: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelMetSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelMetSCAddValueMaxLimitChange
            end
            object EditHelMetSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelMetSCAddValueRateChange
            end
            object EditHelMetSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelMetSCAddRateChange
            end
          end
          object GroupBox57: TGroupBox
            Left = 8
            Top = 89
            Width = 113
            Height = 86
            Caption = #38450#24481
            TabOrder = 3
            object Label143: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label144: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label145: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelMetACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelMetACAddValueMaxLimitChange
            end
            object EditHelMetACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelMetACAddValueRateChange
            end
            object EditHelMetACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelMetACAddRateChange
            end
          end
          object GroupBox58: TGroupBox
            Left = 128
            Top = 89
            Width = 113
            Height = 86
            Caption = #39764#24481
            TabOrder = 4
            object Label146: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label147: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label148: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditHelMetMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditHelMetMACAddValueMaxLimitChange
            end
            object EditHelMetMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditHelMetMACAddValueRateChange
            end
            object EditHelMetMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditHelMetMACAddRateChange
            end
          end
        end
        object TabSheet21: TTabSheet
          Caption = #38795#23376#12289#33136#24102#31867
          ImageIndex = 9
          object Label135: TLabel
            Left = 164
            Top = 176
            Width = 216
            Height = 12
            Caption = #38795#23376#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 52 62'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label136: TLabel
            Left = 164
            Top = 189
            Width = 216
            Height = 12
            Caption = #33136#24102#31867#65292#29289#21697#25968#25454#24211#23383#27573' StdMode 54 64'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox52: TGroupBox
            Left = 128
            Top = 1
            Width = 113
            Height = 86
            Caption = #36947#26415
            TabOrder = 0
            object Label126: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label127: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label128: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootsSCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootsSCAddValueMaxLimitChange
            end
            object EditBootsSCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootsSCAddValueRateChange
            end
            object EditBootsSCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootsSCAddRateChange
            end
          end
          object GroupBox53: TGroupBox
            Left = 8
            Top = 1
            Width = 113
            Height = 86
            Caption = #25915#20987
            TabOrder = 1
            object Label129: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label130: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label131: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootsDCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootsDCAddValueMaxLimitChange
            end
            object EditBootsDCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootsDCAddValueRateChange
            end
            object EditBootsDCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootsDCAddRateChange
            end
          end
          object GroupBox54: TGroupBox
            Left = 248
            Top = 1
            Width = 113
            Height = 86
            Caption = #39764#27861
            TabOrder = 2
            object Label132: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label133: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label134: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootsMCAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootsMCAddValueMaxLimitChange
            end
            object EditBootsMCAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootsMCAddValueRateChange
            end
            object EditBootsMCAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootsMCAddRateChange
            end
          end
          object GroupBox55: TGroupBox
            Left = 8
            Top = 88
            Width = 113
            Height = 86
            Caption = #38450#24481
            TabOrder = 3
            object Label137: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label138: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label139: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootsACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootsACAddValueMaxLimitChange
            end
            object EditBootsACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootsACAddValueRateChange
            end
            object EditBootsACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootsACAddRateChange
            end
          end
          object GroupBox56: TGroupBox
            Left = 128
            Top = 88
            Width = 113
            Height = 86
            Caption = #39764#24481
            TabOrder = 4
            object Label140: TLabel
              Left = 11
              Top = 16
              Width = 54
              Height = 12
              Caption = #26368#39640#28857#25968':'
            end
            object Label141: TLabel
              Left = 11
              Top = 40
              Width = 54
              Height = 12
              Caption = #28857#25968#26426#29575':'
            end
            object Label142: TLabel
              Left = 11
              Top = 64
              Width = 54
              Height = 12
              Caption = #23646#24615#26426#29575':'
            end
            object EditBootsMACAddValueMaxLimit: TSpinEdit
              Left = 64
              Top = 12
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26368#39640#38480#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 0
              Value = 100
              OnChange = EditBootsMACAddValueMaxLimitChange
            end
            object EditBootsMACAddValueRate: TSpinEdit
              Left = 64
              Top = 36
              Width = 41
              Height = 21
              Hint = #26497#21697#23646#24615#28857#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#26368#39640#19981#36229#36807#26368#39640#28857#25968#25511#21046#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 1
              Value = 100
              OnChange = EditBootsMACAddValueRateChange
            end
            object EditBootsMACAddRate: TSpinEdit
              Left = 64
              Top = 60
              Width = 41
              Height = 21
              Hint = #21152#23646#26497#21697#23646#24615#26426#29575#65292#25968#25454#36234#22823#26426#29575#36234#23567#65292#27492#26426#29575#20915#23450#26159#21542#21152#19978#23646#24615#12290
              EditorEnabled = False
              MaxValue = 100
              MinValue = 1
              TabOrder = 2
              Value = 100
              OnChange = EditBootsMACAddRateChange
            end
          end
        end
      end
      object ButtonAddValueSave: TButton
        Left = 334
        Top = 257
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = ButtonAddValueSaveClick
      end
    end
    object TabSheet22: TTabSheet
      Caption = #20061#21608#24180#23453#31665
      ImageIndex = 3
      object Label197: TLabel
        Left = 11
        Top = 127
        Width = 90
        Height = 12
        Caption = #20813#36153#22870#21169#31665#23376'ID:'
      end
      object Button1: TButton
        Left = 326
        Top = 237
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 0
        OnClick = Button1Click
      end
      object GroupBox120: TGroupBox
        Left = 7
        Top = 3
        Width = 140
        Height = 110
        Caption = #24320#31665#25152#38656#38053#21273#35774#32622
        TabOrder = 1
        object Label241: TLabel
          Left = 11
          Top = 23
          Width = 66
          Height = 12
          Caption = #31532#19968#27425#24320#21551':'
        end
        object Label243: TLabel
          Left = 11
          Top = 45
          Width = 66
          Height = 12
          Caption = #31532#20108#27425#24320#21551':'
        end
        object Label244: TLabel
          Left = 11
          Top = 67
          Width = 66
          Height = 12
          Caption = #31532#19977#27425#24320#21551':'
        end
        object Label245: TLabel
          Left = 11
          Top = 89
          Width = 66
          Height = 12
          Caption = #31532#22235#27425#24320#21551':'
        end
        object SpinEditFirstOpen9Years: TSpinEdit
          Left = 82
          Top = 19
          Width = 47
          Height = 21
          Hint = #24320#21551#25152#38656#30340#38053#21273#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 1
          OnChange = SpinEditFirstOpen9YearsChange
        end
        object SpinEditSecondOpen9Years: TSpinEdit
          Left = 82
          Top = 41
          Width = 47
          Height = 21
          Hint = #24320#21551#25152#38656#30340#38053#21273#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 1
          OnChange = SpinEditSecondOpen9YearsChange
        end
        object SpinEditThreeOpen9Years: TSpinEdit
          Left = 82
          Top = 63
          Width = 47
          Height = 21
          Hint = #24320#21551#25152#38656#30340#38053#21273#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 1
          OnChange = SpinEditThreeOpen9YearsChange
        end
        object SpinEditFourOpen9Years: TSpinEdit
          Left = 82
          Top = 85
          Width = 47
          Height = 21
          Hint = #24320#21551#25152#38656#30340#38053#21273#25968#37327
          EditorEnabled = False
          MaxValue = 255
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Value = 1
          OnChange = SpinEditFourOpen9YearsChange
        end
      end
      object GroupBox42: TGroupBox
        Left = 166
        Top = 4
        Width = 193
        Height = 45
        Caption = #25968#25454#24211#35774#32622#32534#21495' [48]'
        TabOrder = 2
        object Label196: TLabel
          Left = 8
          Top = 16
          Width = 72
          Height = 12
          Caption = 'Reserved = 2'
        end
      end
      object SpinEditFree9YearsBoxID: TSpinEdit
        Left = 101
        Top = 123
        Width = 47
        Height = 21
        Hint = 
          #24320#21551#22235#27425#31665#23376#21518#65292#33719#24471#20813#36153#22870#21169#65292#33258#21160#25171#24320#31665#23376#30340#32534#21495#65292'..Mir200\Envir\Boxs\'#19979#30340#31665#23376#37197#32622#25991#20214#13#10#22914#26377'1.txt,2' +
          '.txt'#20004#20010#31665#23376#65292#21482#38656#35774#32622'1,'#21363#20026#25171#24320'1.txt'#30340#37197#32622'('#38656#35201#26377#26222#36890#29289#21697'20'#31181')'
        EditorEnabled = False
        MaxValue = 255
        MinValue = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Value = 1
        OnChange = SpinEditFree9YearsBoxIDChange
      end
    end
  end
end
