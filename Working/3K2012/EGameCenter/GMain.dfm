object frmMain: TfrmMain
  Left = 286
  Top = 129
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '3K'#31185#25216#28216#25103#25511#21046#21488
  ClientHeight = 376
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 520
    Height = 361
    ActivePage = TabSheet2
    HotTrack = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #26381#21153#31471#25511#21046
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 497
        Height = 320
        Caption = #26381#21153#22120#25511#21046
        TabOrder = 0
        object Label77: TLabel
          Left = 8
          Top = 292
          Width = 474
          Height = 24
          Caption = 
            #23567#25552#31034#65306#26412#31243#24207#21487#20197#22312'DOS'#21629#20196#19979' '#21152#21442#25968'Start'#26469#23454#29616' '#24320#26426#33258#21160#21551#21160#31243#24207#65292#21487#20197#29992'BAT'#25991#20214#13#10'        '#26469#25918#21040#31995#32479#21551#21160#37324 +
            #65292#35814#24773#30475#35828#26126#20070#12290
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object ButtonStartGame: TButton
          Left = 168
          Top = 260
          Width = 160
          Height = 28
          Caption = #21551#21160#28216#25103#25511#21046#22120'(&S)'
          TabOrder = 0
          OnClick = ButtonStartGameClick
        end
        object CheckBoxM2Server: TCheckBox
          Left = 16
          Top = 29
          Width = 153
          Height = 17
          Caption = #28216#25103#20027#35201#31243#24207'(M2Server)'
          TabOrder = 1
          OnClick = CheckBoxM2ServerClick
        end
        object CheckBoxDBServer: TCheckBox
          Left = 16
          Top = 13
          Width = 153
          Height = 17
          Caption = #25968#25454#24211#26381#21153#22120'(DBServer)'
          TabOrder = 2
          OnClick = CheckBoxDBServerClick
        end
        object CheckBoxLoginServer: TCheckBox
          Left = 192
          Top = 13
          Width = 141
          Height = 17
          Caption = #24080#21495#26381#21153#22120'(LoginSrv)'
          TabOrder = 3
          OnClick = CheckBoxLoginServerClick
        end
        object CheckBoxLogServer: TCheckBox
          Left = 192
          Top = 28
          Width = 147
          Height = 17
          Caption = #26085#35760#26381#21153#22120'(LogServer)'
          TabOrder = 4
          OnClick = CheckBoxLogServerClick
        end
        object CheckBoxLoginGate: TCheckBox
          Left = 16
          Top = 44
          Width = 159
          Height = 17
          Caption = #28216#25103#30331#38470#32593#20851'(LoginGate)'
          TabOrder = 5
          OnClick = CheckBoxLoginGateClick
        end
        object CheckBoxSelGate: TCheckBox
          Left = 192
          Top = 44
          Width = 146
          Height = 17
          Caption = #28216#25103#35282#33394#32593#20851'(SelGate)'
          TabOrder = 6
          OnClick = CheckBoxSelGateClick
        end
        object CheckBoxRunGate: TCheckBox
          Left = 16
          Top = 59
          Width = 134
          Height = 17
          Caption = #28216#25103#32593#20851#19968'(Rungate)'
          TabOrder = 7
          OnClick = CheckBoxRunGateClick
        end
        object CheckBoxRunGate1: TCheckBox
          Left = 192
          Top = 59
          Width = 134
          Height = 17
          Caption = #28216#25103#32593#20851#20108'(Rungate)'
          Enabled = False
          TabOrder = 8
          OnClick = CheckBoxRunGate1Click
        end
        object CheckBoxRunGate2: TCheckBox
          Left = 16
          Top = 75
          Width = 133
          Height = 17
          Caption = #28216#25103#32593#20851#19977'(Rungate)'
          Enabled = False
          TabOrder = 9
          OnClick = CheckBoxRunGate2Click
        end
        object MemoLog: TMemo
          Left = 8
          Top = 126
          Width = 473
          Height = 130
          Color = clBlack
          Font.Charset = ANSI_CHARSET
          Font.Color = clLime
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentFont = False
          TabOrder = 10
          OnChange = MemoLogChange
        end
        object CheckBoxRunGate3: TCheckBox
          Left = 192
          Top = 75
          Width = 133
          Height = 17
          Caption = #28216#25103#32593#20851#22235'(Rungate)'
          Enabled = False
          TabOrder = 11
          OnClick = CheckBoxRunGate3Click
        end
        object CheckBoxRunGate4: TCheckBox
          Left = 16
          Top = 91
          Width = 133
          Height = 17
          Caption = #28216#25103#32593#20851#20116'(Rungate)'
          Enabled = False
          TabOrder = 12
          OnClick = CheckBoxRunGate4Click
        end
        object CheckBoxRunGate5: TCheckBox
          Left = 192
          Top = 91
          Width = 133
          Height = 17
          Caption = #28216#25103#32593#20851#20845'(Rungate)'
          Enabled = False
          TabOrder = 13
          OnClick = CheckBoxRunGate5Click
        end
        object CheckBoxRunGate6: TCheckBox
          Left = 16
          Top = 107
          Width = 133
          Height = 17
          Caption = #28216#25103#32593#20851#19971'(Rungate)'
          Enabled = False
          TabOrder = 14
          OnClick = CheckBoxRunGate6Click
        end
        object CheckBoxRunGate7: TCheckBox
          Left = 192
          Top = 107
          Width = 133
          Height = 17
          Caption = #28216#25103#32593#20851#20843'(Rungate)'
          Enabled = False
          TabOrder = 15
          OnClick = CheckBoxRunGate7Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #37197#32622#21521#23548
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 480
        Top = 144
        Width = 289
        Height = 193
        TabOrder = 0
      end
      object PageControl3: TPageControl
        Left = 0
        Top = 0
        Width = 512
        Height = 334
        ActivePage = TabSheet12
        Align = alClient
        TabOrder = 1
        TabPosition = tpBottom
        object TabSheet4: TTabSheet
          Caption = #31532#19968#27493'('#22522#26412#35774#32622')'
          object GroupBox1: TGroupBox
            Left = 12
            Top = 8
            Width = 489
            Height = 220
            Caption = #31243#24207#30446#24405#21450#29289#21697#25968#25454#24211#35774#32622
            TabOrder = 0
            object Label1: TLabel
              Left = 8
              Top = 28
              Width = 114
              Height = 12
              Caption = #28216#25103#26381#21153#31471#25152#22312#30446#24405':'
            end
            object Label2: TLabel
              Left = 8
              Top = 52
              Width = 90
              Height = 12
              Caption = #28216#25103#25968#25454#24211#21517#31216':'
            end
            object Label3: TLabel
              Left = 8
              Top = 76
              Width = 126
              Height = 12
              Caption = #28216#25103#26381#21153#22120#26381#21153#22120#21517#31216':'
            end
            object Label4: TLabel
              Left = 8
              Top = 102
              Width = 126
              Height = 12
              Caption = #28216#25103#26381#21153#22120#22806#32593'IP'#22320#22336':'
            end
            object Label84: TLabel
              Left = 8
              Top = 178
              Width = 90
              Height = 12
              Caption = #28216#25103#25968#25454#24211#21517#31216':'
              Visible = False
            end
            object Label85: TLabel
              Left = 8
              Top = 202
              Width = 78
              Height = 12
              Caption = #28216#25103#25968#25454#24211'IP:'
              Visible = False
            end
            object Label86: TLabel
              Left = 8
              Top = 237
              Width = 120
              Height = 12
              Caption = #28216#25103#25968#25454#24211#29992#25143'/'#23494#30721':'
              Visible = False
            end
            object GroupBox47: TGroupBox
              Left = 5
              Top = 114
              Width = 481
              Height = 53
              Caption = #19968#26426#22810#26381#37197#32622
              TabOrder = 12
              Visible = False
              object Label94: TLabel
                Left = 7
                Top = 33
                Width = 462
                Height = 12
                Caption = #28857#20445#23384#37197#32622#23558#29983#25104#22810#20010#37197#32622#25991#20214','#27599#21306#19968#20010'.'#25163#21160#22797#21046#26381#21153#31471#30446#24405'.'#23558#37197#32622#25991#20214#35206#30422#21518#36816#34892
                Font.Charset = ANSI_CHARSET
                Font.Color = clRed
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label95: TLabel
                Left = 240
                Top = 16
                Width = 30
                Height = 12
                Caption = #25968#37327':'
              end
              object CheckBoxMultiServerDbNameAdd: TCheckBox
                Left = 7
                Top = 14
                Width = 111
                Height = 17
                Hint = #25968#25454#24211#21517#23383#36882#22686','#21516#29256#26412#21487#19981#36873
                Caption = #25968#25454#24211#21517#23383#36882#22686
                TabOrder = 0
              end
              object CheckBoxInputNames: TCheckBox
                Left = 129
                Top = 14
                Width = 97
                Height = 17
                Hint = #20445#23384#37197#32622#26102#23558#25552#31034#36755#20837#27599#20010#21306#30340#21517#23383#13#10#19981#21246#33258#21160#35774#32622#20026'***'#19968#21306'***'#20108#21306'...'
                Caption = #36755#20837#26381#21153#22120#21517
                TabOrder = 1
              end
              object ButtonSaveMultiServerConfig: TButton
                Left = 386
                Top = 9
                Width = 75
                Height = 22
                Hint = #20197#24403#21069#30340#37197#32622#20570#22522#30784','#29983#25104#22810#20010#20998#21306#37197#32622#25991#20214'.'#33258#21160#35774#32622'IP'
                Caption = #20445#23384#37197#32622
                TabOrder = 2
                OnClick = ButtonSaveMultiServerConfigClick
              end
              object SpinEditMultiServerCount: TSpinEdit
                Left = 276
                Top = 10
                Width = 52
                Height = 21
                Hint = 'Max 5'
                MaxValue = 5
                MinValue = 3
                TabOrder = 3
                Value = 3
              end
            end
            object GroupBox6: TGroupBox
              Left = 5
              Top = 114
              Width = 481
              Height = 53
              Caption = #19968#26426#21452#26381#37197#32622
              TabOrder = 4
              Visible = False
              object Label8: TLabel
                Left = 7
                Top = 33
                Width = 354
                Height = 12
                Caption = #36873#25321#23436#26381#21153#22120#25353#19979#19968#27493#30452#33267#23436#25104#21363#21487','#19981#21516#26381#21153#22120#38656#19981#21516#21551#21160#22120#37197#32622
                Font.Charset = ANSI_CHARSET
                Font.Color = clRed
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Label24: TLabel
                Left = 8
                Top = 15
                Width = 84
                Height = 12
                Caption = #35831#36873#25321#26381#21153#22120#65306
              end
              object RadioButtonMainServer: TRadioButton
                Left = 104
                Top = 12
                Width = 113
                Height = 17
                Hint = #22914#26524#24744#29616#22312#30340#25511#21046#22120#20026#20027#26381#21153#22120#37027#20040#23601#36873#25321#27492#39033
                Caption = #20027#26381#21153#22120
                Checked = True
                TabOrder = 0
                TabStop = True
                OnClick = RadioButtonMainServerClick
              end
              object RadioButtonSinceServer: TRadioButton
                Left = 232
                Top = 12
                Width = 113
                Height = 17
                Caption = #20998#26381#21153#22120
                TabOrder = 1
                OnClick = RadioButtonSinceServerClick
              end
            end
            object EditGameDir: TEdit
              Left = 136
              Top = 24
              Width = 225
              Height = 20
              Hint = #36755#20837#26381#21153#22120#25152#22312#30446#24405#12290#19968#33324#40664#35748#20026#8220'D:\Mirserver\'#8221#12290
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              TabOrder = 0
              Text = 'D:\Mirserver\'
            end
            object EditHeroDB: TEdit
              Left = 136
              Top = 48
              Width = 225
              Height = 20
              Hint = #26381#21153#22120#31471'BDE '#25968#25454#24211#21517#31216#65292#40664#35748#20026' '#8220'HeroDB'#8221#12290
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              TabOrder = 1
              Text = 'HeroDB'
            end
            object EditGameName: TEdit
              Left = 136
              Top = 72
              Width = 161
              Height = 20
              Hint = #36755#20837#28216#25103#30340#21517#31216#12290
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              TabOrder = 2
              Text = '3K'#31185#25216
            end
            object EditGameExtIPaddr: TEdit
              Left = 136
              Top = 98
              Width = 161
              Height = 20
              Hint = #36755#20837#26381#21153#22120#30340#22806#32593'IP'#22320#22336#12290
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              TabOrder = 3
              Text = '127.0.0.1'
            end
            object CheckBoxDynamicIPMode: TCheckBox
              Left = 304
              Top = 101
              Width = 81
              Height = 17
              Hint = #21160#24577'IP'#22320#22336#27169#24335#65292#25903#25345#25300#21495#21160#24577'IP'#32593#32476#26465#20214#65292#25171#24320#27492#27169#24335#21518#65292#26381#21153#22120#31471#19981#38656#35201#25913#20219#20309'IP'#65292#33258#21160#35782#21035#30331#24405'IP'#22320#22336#12290
              Caption = #21160#24577'IP'#22320#22336
              TabOrder = 5
              OnClick = CheckBoxDynamicIPModeClick
            end
            object ButtonGeneralDefalult: TButton
              Left = 395
              Top = 20
              Width = 81
              Height = 25
              Caption = #40664#35748#35774#32622'(&D)'
              TabOrder = 6
              OnClick = ButtonGeneralDefalultClick
            end
            object Edit2: TEdit
              Left = 99
              Top = 175
              Width = 223
              Height = 20
              TabOrder = 7
              Text = 'MIR2'
              Visible = False
            end
            object Edit3: TEdit
              Left = 99
              Top = 196
              Width = 145
              Height = 20
              TabOrder = 8
              Text = '127.0.0.1'
              Visible = False
            end
            object Edit4: TEdit
              Left = 257
              Top = 196
              Width = 65
              Height = 20
              TabOrder = 9
              Text = 'sa'
              Visible = False
            end
            object Edit5: TEdit
              Left = 326
              Top = 196
              Width = 153
              Height = 20
              PasswordChar = '*'
              TabOrder = 10
              Visible = False
            end
            object RadioGroupMultiServer: TRadioGroup
              Left = 304
              Top = 66
              Width = 178
              Height = 31
              Caption = #19968#26426#22810#26381
              Columns = 3
              ItemIndex = 0
              Items.Strings = (
                #21333#26381
                #21452#26381
                #22810#26381)
              TabOrder = 11
              OnClick = RadioGroupMultiServerClick
            end
          end
          object ButtonNext1: TButton
            Left = 407
            Top = 271
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 1
            OnClick = ButtonNext1Click
          end
          object ButtonReLoadConfig: TButton
            Left = 407
            Top = 234
            Width = 81
            Height = 33
            Caption = #37325#21152#36733'(&R)'
            TabOrder = 2
            OnClick = ButtonReLoadConfigClick
          end
        end
        object TabSheet5: TTabSheet
          Caption = #31532#20108#27493'('#30331#24405#32593#20851')'
          ImageIndex = 1
          object ButtonNext2: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 0
            OnClick = ButtonNext2Click
          end
          object GroupBox2: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #30331#38470#32593#20851#35774#32622
            TabOrder = 1
            object GroupBox7: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label9: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label10: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditLoginGate_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginGate_MainFormXChange
              end
              object EditLoginGate_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginGate_MainFormYChange
              end
            end
            object GroupBox23: TGroupBox
              Left = 144
              Top = 16
              Width = 129
              Height = 49
              Caption = #32593#20851#31471#21475
              TabOrder = 1
              object Label28: TLabel
                Left = 8
                Top = 20
                Width = 30
                Height = 12
                Caption = #31471#21475':'
              end
              object EditLoginGate_GatePort: TEdit
                Left = 56
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 0
                Text = '7000'
              end
            end
            object GroupBox27: TGroupBox
              Left = 8
              Top = 96
              Width = 145
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 2
              object CheckBoxboLoginGate_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 129
                Height = 17
                Caption = #21551#21160#30331#24405#32593#20851
                TabOrder = 0
                OnClick = CheckBoxboLoginGate_GetStartClick
              end
            end
          end
          object ButtonPrv2: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 2
            OnClick = ButtonPrv2Click
          end
          object ButtonLoginGateDefault: TButton
            Left = 408
            Top = 192
            Width = 81
            Height = 25
            Caption = #40664#35748#35774#32622'(&D)'
            TabOrder = 3
            OnClick = ButtonLoginGateDefaultClick
          end
        end
        object TabSheet6: TTabSheet
          Caption = #31532#19977#27493'('#35282#33394#32593#20851')'
          ImageIndex = 2
          object GroupBox3: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #35282#33394#32593#20851#35774#32622
            TabOrder = 0
            object GroupBox8: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label11: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label12: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditSelGate_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditSelGate_MainFormXChange
              end
              object EditSelGate_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditSelGate_MainFormYChange
              end
            end
            object GroupBox24: TGroupBox
              Left = 144
              Top = 16
              Width = 129
              Height = 73
              Caption = #26381#21153#22120#31471#21475
              TabOrder = 1
              object Label29: TLabel
                Left = 8
                Top = 20
                Width = 30
                Height = 12
                Caption = #31471#21475':'
              end
              object Label49: TLabel
                Left = 8
                Top = 44
                Width = 30
                Height = 12
                Caption = #31471#21475':'
              end
              object EditSelGate_GatePort: TEdit
                Left = 56
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 0
                Text = '7100'
              end
              object EditSelGate_GatePort1: TEdit
                Left = 56
                Top = 40
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 1
                Text = '7101'
              end
            end
            object GroupBox28: TGroupBox
              Left = 8
              Top = 96
              Width = 153
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 2
              object CheckBoxboSelGate_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 129
                Height = 17
                Caption = #21551#21160#35282#33394#32593#20851
                TabOrder = 0
                OnClick = CheckBoxboSelGate_GetStartClick
              end
            end
            object GroupBox46: TGroupBox
              Left = 280
              Top = 16
              Width = 177
              Height = 118
              Caption = #20854#23427#35774#32622
              TabOrder = 3
              object Label79: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #26029#24320#26102#38388':'
              end
              object Label80: TLabel
                Left = 8
                Top = 44
                Width = 54
                Height = 12
                Caption = #36830#25509#38480#21046':'
              end
              object Label81: TLabel
                Left = 131
                Top = 44
                Width = 42
                Height = 12
                Caption = #36830#25509'/IP'
              end
              object Label82: TLabel
                Left = 8
                Top = 68
                Width = 54
                Height = 12
                Caption = #26085#24535#31561#32423':'
              end
              object Label83: TLabel
                Left = 8
                Top = 93
                Width = 54
                Height = 12
                Caption = #38450#24481#31561#32423':'
              end
              object SelGate_KeepConnectTimeOutEdit: TSpinEdit
                Left = 64
                Top = 16
                Width = 65
                Height = 21
                Hint = #35282#33394#32593#20851#26029#24320#26080#25805#20316'IP'#30340#26102#38388
                MaxValue = 20000000
                MinValue = 10000
                TabOrder = 0
                Value = 10000
                OnChange = SelGate_KeepConnectTimeOutEditChange
              end
              object EditMaxConnect: TSpinEdit
                Left = 64
                Top = 40
                Width = 65
                Height = 21
                Hint = #21333#20010'IP'#22320#22336#65292#26368#22810#21487#20197#24314#31435#36830#25509#25968#65292#36229#36807#25351#23450#36830#25509#25968#23558#25353#19979#38754#30340#25805#20316#22788#29702
                EditorEnabled = False
                MaxValue = 1000
                MinValue = 1
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
                Value = 50
                OnChange = EditMaxConnectChange
              end
              object SpinEditShowLogLevel: TSpinEdit
                Left = 64
                Top = 64
                Width = 65
                Height = 21
                MaxValue = 5
                MinValue = 0
                TabOrder = 2
                Value = 3
                OnChange = SpinEditShowLogLevelChange
              end
              object SpinEditBlockMethod: TSpinEdit
                Left = 64
                Top = 89
                Width = 65
                Height = 21
                MaxValue = 10
                MinValue = 0
                TabOrder = 3
                Value = 3
                OnChange = SpinEditBlockMethodChange
              end
            end
          end
          object ButtonPrv3: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv3Click
          end
          object ButtonNext3: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext3Click
          end
          object ButtonSelGateDefault: TButton
            Left = 408
            Top = 192
            Width = 81
            Height = 25
            Caption = #40664#35748#35774#32622'(&D)'
            TabOrder = 3
            OnClick = ButtonSelGateDefaultClick
          end
        end
        object TabSheet12: TTabSheet
          Caption = #31532#22235#27493'('#28216#25103#32593#20851')'
          ImageIndex = 8
          object ButtonPrv4: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 0
            OnClick = ButtonPrv4Click
          end
          object ButtonNext4: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 1
            OnClick = ButtonNext4Click
          end
          object GroupBox17: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #28216#25103#32593#20851#35774#32622
            TabOrder = 2
            object GroupBox18: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              Enabled = False
              TabOrder = 0
              object Label21: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
                Enabled = False
              end
              object Label22: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
                Enabled = False
              end
              object EditRunGate_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                Enabled = False
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
              end
              object EditRunGate_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                Enabled = False
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
              end
            end
            object GroupBox19: TGroupBox
              Left = 8
              Top = 96
              Width = 129
              Height = 57
              Caption = #24320#21551#32593#20851#25968#37327
              TabOrder = 1
              object Label23: TLabel
                Left = 8
                Top = 20
                Width = 30
                Height = 12
                Caption = #25968#37327':'
              end
              object EditRunGate_Connt: TSpinEdit
                Left = 44
                Top = 17
                Width = 65
                Height = 21
                Hint = #35774#32622#24320#21551#28216#25103#32593#20851#25968#37327#65292#19968#33324'200'#20154#20197#19979#30340#24320#19968#20010#32593#20851#65292'400'#20154#20197#19979#30340#24320#20108#20010#32593#20851#65292'400'#20154#20197#19978#30340#24320#19977#20010#32593#20851#12290
                MaxValue = 8
                MinValue = 1
                TabOrder = 0
                Value = 1
                OnChange = EditRunGate_ConntChange
              end
            end
            object GroupBox22: TGroupBox
              Left = 144
              Top = 16
              Width = 209
              Height = 137
              Caption = #26381#21153#22120#31471#21475
              TabOrder = 2
              object LabelRunGate_GatePort1: TLabel
                Left = 8
                Top = 20
                Width = 18
                Height = 12
                Caption = #19968':'
              end
              object LabelLabelRunGate_GatePort2: TLabel
                Left = 8
                Top = 44
                Width = 18
                Height = 12
                Caption = #20108':'
              end
              object LabelRunGate_GatePort3: TLabel
                Left = 8
                Top = 68
                Width = 18
                Height = 12
                Caption = #19977':'
              end
              object LabelRunGate_GatePort4: TLabel
                Left = 8
                Top = 92
                Width = 18
                Height = 12
                Caption = #22235':'
              end
              object LabelRunGate_GatePort5: TLabel
                Left = 8
                Top = 116
                Width = 18
                Height = 12
                Caption = #20116':'
              end
              object LabelRunGate_GatePort6: TLabel
                Left = 104
                Top = 20
                Width = 18
                Height = 12
                Caption = #20845':'
              end
              object LabelRunGate_GatePort7: TLabel
                Left = 104
                Top = 44
                Width = 18
                Height = 12
                Caption = #19971':'
              end
              object LabelRunGate_GatePort78: TLabel
                Left = 104
                Top = 68
                Width = 18
                Height = 12
                Caption = #20843':'
              end
              object EditRunGate_GatePort1: TEdit
                Left = 56
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 0
                Text = '7200'
              end
              object EditRunGate_GatePort2: TEdit
                Left = 56
                Top = 40
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 1
                Text = '7200'
              end
              object EditRunGate_GatePort3: TEdit
                Left = 56
                Top = 64
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 2
                Text = '7200'
              end
              object EditRunGate_GatePort4: TEdit
                Left = 56
                Top = 88
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 3
                Text = '7200'
              end
              object EditRunGate_GatePort5: TEdit
                Left = 56
                Top = 112
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 4
                Text = '7200'
              end
              object EditRunGate_GatePort6: TEdit
                Left = 152
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 5
                Text = '7200'
              end
              object EditRunGate_GatePort7: TEdit
                Left = 152
                Top = 40
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 6
                Text = '7200'
              end
              object EditRunGate_GatePort8: TEdit
                Left = 152
                Top = 64
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 7
                Text = '7200'
              end
            end
            object CheckBoxThreadRun: TCheckBox
              Left = 8
              Top = 155
              Width = 112
              Height = 17
              Caption = #20351#29992#22810#32447#31243#32593#20851
              TabOrder = 3
              Visible = False
              OnClick = CheckBoxThreadRunClick
            end
          end
          object ButtonRunGateDefault: TButton
            Left = 408
            Top = 192
            Width = 81
            Height = 25
            Caption = #40664#35748#35774#32622'(&D)'
            TabOrder = 3
            OnClick = ButtonRunGateDefaultClick
          end
        end
        object TabSheet7: TTabSheet
          Caption = #31532#20116#27493'('#24080#21495#26381#21153#22120')'
          ImageIndex = 3
          object GroupBox9: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #30331#24405#26381#21153#22120#35774#32622
            TabOrder = 0
            object GroupBox10: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label13: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label14: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditLoginServer_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLoginServer_MainFormXChange
              end
              object EditLoginServer_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLoginServer_MainFormYChange
              end
            end
            object GroupBox33: TGroupBox
              Left = 144
              Top = 16
              Width = 217
              Height = 73
              Caption = #21069#32622#26381#21153#22120#31471#21475
              TabOrder = 1
              object Label50: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #36830#25509#31471#21475':'
              end
              object Label51: TLabel
                Left = 8
                Top = 44
                Width = 54
                Height = 12
                Caption = #36890#35759#31471#21475':'
              end
              object Label25: TLabel
                Left = 112
                Top = 20
                Width = 54
                Height = 12
                Caption = #30417#25511#31471#21475':'
              end
              object EditLoginServerGatePort: TEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 0
                Text = '5500'
              end
              object EditLoginServerServerPort: TEdit
                Left = 64
                Top = 40
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 1
                Text = '5600'
              end
              object EditLoginServerMonPort: TEdit
                Left = 168
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 2
                Text = '3000'
              end
            end
            object GroupBox34: TGroupBox
              Left = 8
              Top = 96
              Width = 161
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 2
              object CheckBoxboLoginServer_GetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 137
                Height = 17
                Caption = #21551#21160#30331#24405#26381#21153#22120
                TabOrder = 0
                OnClick = CheckBoxboLoginServer_GetStartClick
              end
            end
          end
          object ButtonPrv5: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv5Click
          end
          object ButtonNext5: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext5Click
          end
          object ButtonLoginSrvDefault: TButton
            Left = 408
            Top = 192
            Width = 81
            Height = 25
            Caption = #40664#35748#35774#32622'(&D)'
            TabOrder = 3
            OnClick = ButtonLoginSrvDefaultClick
          end
        end
        object TabSheet8: TTabSheet
          Caption = #31532#20845#27493'('#25968#25454#24211#26381#21153#22120')'
          ImageIndex = 4
          object GroupBox11: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #25968#25454#24211#26381#21153#22120#35774#32622
            TabOrder = 0
            object GroupBox12: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label15: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label16: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditDBServer_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditDBServer_MainFormXChange
              end
              object EditDBServer_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditDBServer_MainFormYChange
              end
            end
            object GroupBox20: TGroupBox
              Left = 144
              Top = 96
              Width = 129
              Height = 41
              Caption = #25346#26426#22806#25346#25511#21046
              TabOrder = 1
              Visible = False
              object CheckBoxDisableAutoGame: TCheckBox
                Left = 8
                Top = 16
                Width = 105
                Height = 17
                Caption = #31105#27490#20256#31070#25346#26426
                TabOrder = 0
                OnClick = CheckBoxDisableAutoGameClick
              end
            end
            object GroupBox35: TGroupBox
              Left = 8
              Top = 96
              Width = 129
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 2
              object CheckBoxDBServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 113
                Height = 17
                Caption = #21551#21160#25968#25454#24211#26381#21153#22120
                TabOrder = 0
                OnClick = CheckBoxDBServerGetStartClick
              end
            end
            object GroupBox36: TGroupBox
              Left = 144
              Top = 16
              Width = 209
              Height = 73
              Caption = #21069#32622#26381#21153#22120#31471#21475
              TabOrder = 3
              object Label52: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #36830#25509#31471#21475':'
              end
              object Label53: TLabel
                Left = 8
                Top = 44
                Width = 54
                Height = 12
                Caption = #36890#35759#31471#21475':'
              end
              object EditDBServerGatePort: TEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 0
                Text = '5100'
              end
              object EditDBServerServerPort: TEdit
                Left = 64
                Top = 40
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 1
                Text = '6000'
              end
            end
          end
          object ButtonPrv6: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv6Click
          end
          object ButtonNext6: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext6Click
          end
          object ButtonDBServerDefault: TButton
            Left = 408
            Top = 192
            Width = 81
            Height = 25
            Caption = #40664#35748#35774#32622'(&D)'
            TabOrder = 3
            OnClick = ButtonDBServerDefaultClick
          end
        end
        object TabSheet9: TTabSheet
          Caption = #31532#19971#27493'('#28216#25103#26085#24535#26381#21153#22120')'
          ImageIndex = 5
          object GroupBox13: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #28216#25103#26085#24535#26381#21153#22120#35774#32622
            TabOrder = 0
            object GroupBox14: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label17: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label18: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditLogServer_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditLogServer_MainFormXChange
              end
              object EditLogServer_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditLogServer_MainFormYChange
              end
            end
            object GroupBox37: TGroupBox
              Left = 8
              Top = 96
              Width = 129
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 1
              object CheckBoxLogServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 113
                Height = 17
                Caption = #21551#21160#26085#24535#26381#21153#22120
                TabOrder = 0
                OnClick = CheckBoxLogServerGetStartClick
              end
            end
            object GroupBox38: TGroupBox
              Left = 144
              Top = 16
              Width = 209
              Height = 73
              Caption = #32593#32476#31471#21475
              TabOrder = 2
              object Label54: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #32593#32476#31471#21475':'
              end
              object EditLogServerPort: TEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 0
                Text = '10000'
              end
            end
          end
          object ButtonPrv7: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv7Click
          end
          object ButtonNext7: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext7Click
          end
          object ButtonLogServerDefault: TButton
            Left = 408
            Top = 192
            Width = 81
            Height = 25
            Caption = #40664#35748#35774#32622'(&D)'
            TabOrder = 3
            OnClick = ButtonLogServerDefaultClick
          end
        end
        object TabSheet10: TTabSheet
          Caption = #31532#20843#27493'('#28216#25103#24341#25806#20027#26381#21153#22120')'
          ImageIndex = 6
          object GroupBox15: TGroupBox
            Left = 8
            Top = 8
            Width = 489
            Height = 177
            Caption = #28216#25103#24341#25806#26381#21153#22120#35774#32622
            TabOrder = 0
            object GroupBox16: TGroupBox
              Left = 8
              Top = 16
              Width = 129
              Height = 73
              Caption = #31383#21475#20301#32622
              TabOrder = 0
              object Label19: TLabel
                Left = 8
                Top = 20
                Width = 36
                Height = 12
                Caption = #24231#26631'X:'
              end
              object Label20: TLabel
                Left = 8
                Top = 44
                Width = 36
                Height = 12
                Caption = #24231#26631'Y:'
              end
              object EditM2Server_MainFormX: TSpinEdit
                Left = 48
                Top = 16
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'X'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = EditM2Server_MainFormXChange
              end
              object EditM2Server_MainFormY: TSpinEdit
                Left = 48
                Top = 40
                Width = 65
                Height = 21
                Hint = #21551#21160#31243#24207#31383#21475#22312#23631#24149#19978#30340#20301#32622#65292#24231#26631'Y'#12290
                MaxValue = 10000
                MinValue = 0
                TabOrder = 1
                Value = 0
                OnChange = EditM2Server_MainFormYChange
              end
            end
            object GroupBox32: TGroupBox
              Left = 336
              Top = 16
              Width = 145
              Height = 73
              Caption = #26032#20154#35774#32622
              TabOrder = 1
              object Label61: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #24320#22987#31561#32423':'
              end
              object Label62: TLabel
                Left = 8
                Top = 44
                Width = 54
                Height = 12
                Caption = #24320#22987#37329#24065':'
              end
              object EditM2Server_TestLevel: TSpinEdit
                Left = 68
                Top = 16
                Width = 69
                Height = 21
                Hint = #20154#29289#36215#22987#31561#32423#12290
                MaxValue = 20000
                MinValue = 0
                TabOrder = 0
                Value = 10
                OnChange = EditM2Server_TestLevelChange
              end
              object EditM2Server_TestGold: TSpinEdit
                Left = 68
                Top = 40
                Width = 69
                Height = 21
                Hint = #27979#35797#27169#24335#20154#29289#36215#22987#37329#24065#25968#12290
                Increment = 1000
                MaxValue = 20000000
                MinValue = 0
                TabOrder = 1
                Value = 10
                OnChange = EditM2Server_TestGoldChange
              end
            end
            object GroupBox39: TGroupBox
              Left = 144
              Top = 16
              Width = 185
              Height = 73
              Caption = #21069#32622#26381#21153#22120#31471#21475
              TabOrder = 2
              object Label55: TLabel
                Left = 8
                Top = 20
                Width = 54
                Height = 12
                Caption = #36830#25509#31471#21475':'
              end
              object Label56: TLabel
                Left = 8
                Top = 44
                Width = 54
                Height = 12
                Caption = #36890#35759#31471#21475':'
              end
              object EditM2ServerGatePort: TEdit
                Left = 64
                Top = 16
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 0
                Text = '5000'
              end
              object EditM2ServerMsgSrvPort: TEdit
                Left = 64
                Top = 40
                Width = 41
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                TabOrder = 1
                Text = '4900'
              end
            end
            object GroupBox40: TGroupBox
              Left = 8
              Top = 96
              Width = 193
              Height = 41
              Caption = #26159#21542#21551#21160
              TabOrder = 3
              object CheckBoxM2ServerGetStart: TCheckBox
                Left = 8
                Top = 16
                Width = 169
                Height = 17
                Caption = #21551#21160#28216#25103#26381#21153#22120
                TabOrder = 0
                OnClick = CheckBoxM2ServerGetStartClick
              end
            end
          end
          object ButtonPrv8: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 1
            OnClick = ButtonPrv8Click
          end
          object ButtonNext8: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #19979#19968#27493'(&N)'
            TabOrder = 2
            OnClick = ButtonNext8Click
          end
          object ButtonM2ServerDefault: TButton
            Left = 408
            Top = 192
            Width = 81
            Height = 25
            Caption = #40664#35748#35774#32622'(&D)'
            TabOrder = 3
            OnClick = ButtonM2ServerDefaultClick
          end
        end
        object TabSheet11: TTabSheet
          Caption = #31532#20061#27493'('#20445#23384#37197#32622')'
          ImageIndex = 7
          object ButtonSave: TButton
            Left = 408
            Top = 263
            Width = 81
            Height = 33
            Caption = #20445#23384'(&S)'
            TabOrder = 0
            OnClick = ButtonSaveClick
          end
          object ButtonGenGameConfig: TButton
            Left = 232
            Top = 263
            Width = 81
            Height = 33
            Caption = #29983#25104#37197#32622'(&G)'
            TabOrder = 1
            OnClick = ButtonGenGameConfigClick
          end
          object ButtonPrv9: TButton
            Left = 320
            Top = 263
            Width = 81
            Height = 33
            Caption = #19978#19968#27493'(&P)'
            TabOrder = 2
            OnClick = ButtonPrv9Click
          end
        end
      end
    end
    object TabSheet16: TTabSheet
      Caption = #25968#25454#22791#20221
      Font.Charset = ARABIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImageIndex = 7
      ParentFont = False
      object Label7: TLabel
        Left = 367
        Top = 304
        Width = 102
        Height = 12
        Caption = #22791#20221#31243#24207#20572#27490#20013'...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBox4: TGroupBox
        Left = 4
        Top = 16
        Width = 492
        Height = 151
        Caption = #22791#20221#21015#34920
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object ListViewBak: TListView
          Left = 8
          Top = 16
          Width = 475
          Height = 127
          Columns = <
            item
              Caption = #25968#25454#30446#24405
              Width = 220
            end
            item
              Caption = #22791#20221#30446#24405
              Width = 220
            end>
          Font.Charset = ANSI_CHARSET
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
          OnClick = ListViewBakClick
          OnDeletion = ListViewBakDeletion
        end
      end
      object GroupBox42: TGroupBox
        Left = 3
        Top = 173
        Width = 493
        Height = 117
        Caption = #32534#36753#21015#34920
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label5: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #25968#25454#30446#24405':'
        end
        object Label6: TLabel
          Left = 8
          Top = 42
          Width = 54
          Height = 12
          Caption = #22791#20221#30446#24405':'
        end
        object Label64: TLabel
          Left = 108
          Top = 67
          Width = 12
          Height = 12
          Caption = #28857
        end
        object Label65: TLabel
          Left = 108
          Top = 91
          Width = 24
          Height = 12
          Caption = #23567#26102
        end
        object Label66: TLabel
          Left = 182
          Top = 67
          Width = 12
          Height = 12
          Caption = #20998
        end
        object Label67: TLabel
          Left = 182
          Top = 91
          Width = 12
          Height = 12
          Caption = #20998
        end
        object EditData: TEdit
          Left = 64
          Top = 16
          Width = 417
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
          OnChange = EditDataChange
        end
        object EditBak: TEdit
          Left = 64
          Top = 40
          Width = 417
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 1
          OnChange = EditDataChange
        end
        object RadioBak1: TRadioButton
          Left = 8
          Top = 66
          Width = 49
          Height = 17
          Caption = #27599#22825
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = RadioBak1Click
        end
        object RadioBak2: TRadioButton
          Left = 8
          Top = 90
          Width = 49
          Height = 17
          Caption = #27599#38548
          TabOrder = 3
          OnClick = RadioBak2Click
        end
        object CheckBoxBakReduce: TCheckBox
          Left = 256
          Top = 78
          Width = 49
          Height = 17
          Caption = #21387#32553
          TabOrder = 4
          OnClick = EditDataChange
        end
        object CheckBoxBakAuto: TCheckBox
          Left = 320
          Top = 78
          Width = 121
          Height = 17
          Caption = #31243#24207#21551#21160#33258#21160#36816#34892
          TabOrder = 5
          OnClick = EditDataChange
        end
        object SpinEdit1: TSpinEdit
          Left = 64
          Top = 64
          Width = 41
          Height = 21
          MaxValue = 23
          MinValue = 0
          TabOrder = 6
          Value = 6
          OnChange = EditDataChange
        end
        object SpinEdit2: TSpinEdit
          Left = 64
          Top = 88
          Width = 41
          Height = 21
          Enabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 7
          Value = 1
          OnChange = EditDataChange
        end
        object SpinEdit3: TSpinEdit
          Left = 139
          Top = 64
          Width = 41
          Height = 21
          MaxValue = 59
          MinValue = 0
          TabOrder = 8
          Value = 0
          OnChange = EditDataChange
        end
        object SpinEdit4: TSpinEdit
          Left = 139
          Top = 88
          Width = 41
          Height = 21
          Enabled = False
          MaxValue = 100
          MinValue = 0
          TabOrder = 9
          Value = 0
          OnChange = EditDataChange
        end
        object Button4: TButton
          Left = 459
          Top = 18
          Width = 20
          Height = 16
          Caption = #8230
          TabOrder = 10
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 459
          Top = 42
          Width = 20
          Height = 16
          Caption = #8230
          TabOrder = 11
          OnClick = Button5Click
        end
      end
      object ButBakAdd: TButton
        Left = 2
        Top = 298
        Width = 65
        Height = 25
        Caption = #22686#21152'(&A)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ButBakAddClick
      end
      object ButBakDel: TButton
        Left = 74
        Top = 298
        Width = 65
        Height = 25
        Caption = #21024#38500'(&D)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = ButBakDelClick
      end
      object ButBakChg: TButton
        Left = 146
        Top = 298
        Width = 65
        Height = 25
        Caption = #20462#25913'(&E)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = ButBakChgClick
      end
      object ButBakSave: TButton
        Left = 218
        Top = 298
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = ButBakSaveClick
      end
      object ButBakStart: TButton
        Left = 290
        Top = 298
        Width = 65
        Height = 25
        Caption = #21551#21160'(&R)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 6
        OnClick = ButBakStartClick
      end
    end
    object TabSheet17: TTabSheet
      Caption = #25968#25454#24211#22791#20221
      ImageIndex = 6
      object Label87: TLabel
        Left = 24
        Top = 30
        Width = 108
        Height = 12
        Caption = #22791#20221#25991#20214#23384#25918#30446#24405#65306
      end
      object Label88: TLabel
        Left = 26
        Top = 56
        Width = 84
        Height = 12
        Caption = #25968#25454#22791#20221#38388#38548#65306
      end
      object Label89: TLabel
        Left = 24
        Top = 80
        Width = 102
        Height = 12
        Caption = #33258#23450#20041#30446#24405#22791#20221'1'#65306
      end
      object Label90: TLabel
        Left = 24
        Top = 104
        Width = 102
        Height = 12
        Caption = #33258#23450#20041#30446#24405#22791#20221'2'#65306
      end
      object Label91: TLabel
        Left = 24
        Top = 128
        Width = 102
        Height = 12
        Caption = #33258#23450#20041#30446#24405#22791#20221'3'#65306
      end
      object SpeedButton4: TSpeedButton
        Left = 344
        Top = 124
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton4Click
      end
      object SpeedButton3: TSpeedButton
        Left = 344
        Top = 100
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton3Click
      end
      object SpeedButton2: TSpeedButton
        Left = 344
        Top = 75
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton2Click
      end
      object SpeedButton1: TSpeedButton
        Left = 344
        Top = 28
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object Label92: TLabel
        Left = 344
        Top = 56
        Width = 24
        Height = 12
        Caption = #23567#26102
      end
      object Edit6: TEdit
        Left = 129
        Top = 28
        Width = 209
        Height = 20
        TabOrder = 0
      end
      object Edit7: TEdit
        Left = 129
        Top = 76
        Width = 209
        Height = 20
        TabOrder = 1
      end
      object Edit8: TEdit
        Left = 129
        Top = 100
        Width = 209
        Height = 20
        TabOrder = 2
      end
      object Edit9: TEdit
        Left = 129
        Top = 124
        Width = 209
        Height = 20
        TabOrder = 3
      end
      object Button6: TButton
        Left = 408
        Top = 128
        Width = 75
        Height = 25
        Caption = #25163#21160#22791#20221
        TabOrder = 4
        OnClick = Button6Click
      end
      object Button8: TButton
        Left = 408
        Top = 160
        Width = 75
        Height = 25
        Caption = #20445#23384#35774#32622
        TabOrder = 5
        OnClick = Button8Click
      end
      object CheckBox1: TCheckBox
        Left = 24
        Top = 160
        Width = 145
        Height = 17
        Caption = #21551#29992#25968#25454#22791#20221#21151#33021
        TabOrder = 6
        OnClick = CheckBox1Click
      end
      object ListBox1: TListBox
        Left = 24
        Top = 192
        Width = 457
        Height = 137
        ItemHeight = 12
        TabOrder = 7
      end
      object Edit10: TEdit
        Left = 129
        Top = 52
        Width = 209
        Height = 20
        TabOrder = 8
        OnChange = Edit10Change
      end
      object BitBtn1: TBitBtn
        Left = 328
        Top = 160
        Width = 75
        Height = 25
        Caption = 'BitBtn1'
        TabOrder = 9
        Visible = False
        OnClick = BitBtn1Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #28165#31354#25968#25454
      ImageIndex = 5
      object Label27: TLabel
        Left = 16
        Top = 24
        Width = 42
        Height = 12
        Caption = #20154#29289'ID:'
      end
      object Label30: TLabel
        Left = 8
        Top = 192
        Width = 54
        Height = 12
        Caption = #30331#38470#25968#25454':'
      end
      object PageControl4: TPageControl
        Left = 2
        Top = -5
        Width = 513
        Height = 311
        ActivePage = TabSheet14
        TabOrder = 0
        object TabSheet14: TTabSheet
          Caption = #22522#26412#25968#25454
          object Label43: TLabel
            Left = 2
            Top = 260
            Width = 84
            Height = 12
            Caption = #28165#29702#35814#32454#26085#24535#65306
          end
          object Label44: TLabel
            Left = 88
            Top = 260
            Width = 78
            Height = 12
            Caption = #28165#29702#20572#27490#20013'...'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object GroupBox21: TGroupBox
            Left = 2
            Top = 0
            Width = 502
            Height = 177
            Caption = #28216#25103#22522#26412#25968#25454
            TabOrder = 0
            object Label31: TLabel
              Left = 8
              Top = 33
              Width = 54
              Height = 12
              Caption = #24080#21495#25968#25454':'
            end
            object Label32: TLabel
              Left = 250
              Top = 33
              Width = 54
              Height = 12
              Caption = #35282#33394#25968#25454':'
            end
            object Label33: TLabel
              Left = 8
              Top = 53
              Width = 54
              Height = 12
              Caption = #28216#25103#26085#24535':'
            end
            object Label34: TLabel
              Left = 250
              Top = 53
              Width = 54
              Height = 12
              Caption = #27801#22478#25968#25454':'
            end
            object Label35: TLabel
              Left = 8
              Top = 73
              Width = 54
              Height = 12
              Caption = #34892#20250#25968#25454':'
            end
            object Label36: TLabel
              Left = 250
              Top = 73
              Width = 54
              Height = 12
              Caption = #30331#38470#25968#25454':'
            end
            object Label37: TLabel
              Left = 8
              Top = 93
              Width = 54
              Height = 12
              Caption = #27494#22120#21319#32423':'
            end
            object Label38: TLabel
              Left = 250
              Top = 93
              Width = 54
              Height = 12
              Caption = #25293#21334#25968#25454':'
            end
            object Label39: TLabel
              Left = 250
              Top = 134
              Width = 60
              Height = 12
              Caption = #21830#20154#25968#25454'1:'
            end
            object Label40: TLabel
              Left = 8
              Top = 153
              Width = 60
              Height = 12
              Caption = #21830#20154#25968#25454'2:'
            end
            object Label68: TLabel
              Left = 8
              Top = 114
              Width = 54
              Height = 12
              Caption = #27880#20876#26085#24535':'
            end
            object Label69: TLabel
              Left = 250
              Top = 113
              Width = 54
              Height = 12
              Caption = #32479#35745#26085#24535':'
            end
            object Label70: TLabel
              Left = 8
              Top = 133
              Width = 54
              Height = 12
              Caption = #24341#25806#26085#24535':'
            end
            object Label76: TLabel
              Left = 250
              Top = 153
              Width = 66
              Height = 12
              Caption = #25490#34892#27036#25968#25454':'
            end
            object Label78: TLabel
              Left = 8
              Top = 15
              Width = 54
              Height = 12
              Caption = #28165#29702#36335#24452':'
            end
            object Label93: TLabel
              Left = 250
              Top = 14
              Width = 54
              Height = 12
              Caption = #38376#27966#25968#25454':'
            end
            object IDEd: TEdit
              Left = 72
              Top = 31
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 0
              Text = 'LoginSrv\IDDB'
            end
            object DBed: TEdit
              Left = 319
              Top = 31
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 1
              Text = 'DBServer\FDB'
            end
            object CsEd: TEdit
              Left = 319
              Top = 51
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 2
              Text = 'Mir200\Castle'
            end
            object CBed: TEdit
              Left = 72
              Top = 71
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 3
              Text = 'Mir200\GuildBase'
            end
            object CLed: TEdit
              Left = 319
              Top = 71
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 4
              Text = 'Mir200\ConLog'
            end
            object upged: TEdit
              Left = 72
              Top = 91
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 5
              Text = 'Mir200\Envir\market_upg'
            end
            object Soed: TEdit
              Left = 319
              Top = 91
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 6
              Text = 'Mir200\Envir\Market_SellOff'
            end
            object LogEd: TEdit
              Left = 72
              Top = 51
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 7
              Text = 'LogServer\BaseDir'
            end
            object sred1: TEdit
              Left = 319
              Top = 131
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 8
              Text = 'Mir200\Envir\Market_prices'
            end
            object sred2: TEdit
              Left = 72
              Top = 151
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 9
              Text = 'Mir200\Envir\Market_saved'
            end
            object ChrLog: TEdit
              Left = 72
              Top = 111
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 10
              Text = 'LoginSrv\ChrLog'
            end
            object CountLog: TEdit
              Left = 319
              Top = 111
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 11
              Text = 'LoginSrv\CountLog'
            end
            object M2Log: TEdit
              Left = 72
              Top = 131
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 12
              Text = 'Mir200\Log'
            end
            object EdtSort: TEdit
              Left = 319
              Top = 151
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 13
              Text = 'Mir200\Sort'
            end
            object Edit1: TEdit
              Left = 72
              Top = 11
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 14
              Text = 'D:\Mirserver\'
            end
            object DivisionDirEdt: TEdit
              Left = 319
              Top = 11
              Width = 161
              Height = 20
              Enabled = False
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ReadOnly = True
              TabOrder = 15
              Text = 'Mir200\DivisionDir'
            end
          end
          object GroupBox25: TGroupBox
            Left = 2
            Top = 177
            Width = 502
            Height = 29
            Caption = #20854#20182#25968#25454
            TabOrder = 1
            object CheckBoxGlobal: TCheckBox
              Left = 13
              Top = 10
              Width = 118
              Height = 17
              Hint = #36825#37324#36873#25321#26159#21542#35201#28165#38500#20840#23616'G'#12289'S'#21464#37327'('#22825#19979#31532#19968#25968#25454#20063#20445#23384#20877#36825'2'#20010#21464#37327#20013')'#24314#35758#28165#38500#36825'2'#20010#21464#37327
              Caption = #28165#31354#20840#23616'G'#12289'S'#21464#37327
              Checked = True
              ParentShowHint = False
              ShowHint = True
              State = cbChecked
              TabOrder = 0
              OnClick = CheckBoxGlobalClick
            end
            object CheckBoxUserData: TCheckBox
              Left = 145
              Top = 10
              Width = 94
              Height = 17
              Caption = #28165#31354#23492#21806#25968#25454
              Checked = True
              ParentShowHint = False
              ShowHint = False
              State = cbChecked
              TabOrder = 1
              OnClick = CheckBoxGlobalClick
            end
            object CheckBoxMasterNo: TCheckBox
              Left = 253
              Top = 10
              Width = 104
              Height = 17
              Caption = #28165#31354#22810#24466#24351#25968#25454
              Checked = True
              ParentShowHint = False
              ShowHint = False
              State = cbChecked
              TabOrder = 2
              OnClick = CheckBoxGlobalClick
            end
          end
          object Memo1: TMemo
            Left = 2
            Top = 205
            Width = 501
            Height = 54
            Color = cl3DLight
            DragKind = dkDock
            Font.Charset = ANSI_CHARSET
            Font.Color = clNone
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            Lines.Strings = (
              #20351#29992#25805#20316#35828#26126#65306#30830#35748#20572#27490#26381#21153#31471#25152#26377#31243#24207#21518#20877#20351#29992','#22522#26412#25968#25454#24050#20869#37096#35774#32622#22909#20102#25152#20197#26080#38656#35774#32622#20102
              #31532#19968#27493' '#35774#32622#33258#23450#20041#25968#25454' '#21487#29992#20110#20250#21592#20449#24687#12289#22825#19979#31532#19968#12289#38599#20323#20853#12289#33258#23450#20041#21464#37327#31561
              #31532#20108#27493' '#35774#32622#22909#20840#37096#36873#39033#21518#28857' ['#28165#38500#25968#25454'] '#36827#34892#28165#38500
              #31532#19977#27493' '#28165#29702#23436#21518#28857' ['#20445#23384'] '#36827#34892#20445#23384#35774#32622)
            ParentFont = False
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 2
          end
          object ClearProgressBar: TProgressBar
            Left = 2
            Top = 273
            Width = 503
            Height = 11
            TabOrder = 3
          end
        end
        object TabSheet15: TTabSheet
          Caption = #33258#23450#20041#25968#25454
          ImageIndex = 2
          object RzSplitter1: TRzSplitter
            Left = 0
            Top = 0
            Width = 505
            Height = 284
            BorderWidth = 1
            Orientation = orVertical
            Position = 93
            Percent = 33
            RealTimeDrag = True
            LowerRight.BorderWidth = 1
            SplitterWidth = 2
            Align = alClient
            Color = clActiveCaption
            TabOrder = 0
            OnCanResize = RzSplitter1CanResize
            BarSize = (
              1
              94
              504
              96)
            UpperLeftControls = (
              GroupBox26)
            LowerRightControls = (
              RzSplitter2)
            object GroupBox26: TGroupBox
              Left = 0
              Top = 0
              Width = 503
              Height = 93
              Align = alClient
              Caption = #28165#31354#33258#23450#20041#25991#26412#25968#25454'('#22914#20250#21592')'
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              object Label26: TLabel
                Left = 8
                Top = 18
                Width = 120
                Height = 12
                Caption = #28165#31354#33258#23450#20041#25991#20214#36335#24452#65306
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object BtnMyGetTxtDel: TRzRapidFireButton
                Left = 472
                Top = 10
                Width = 23
                Height = 22
                Glyph.Data = {
                  36060000424D3606000000000000360400002800000020000000100000000100
                  08000000000000020000830B0000830B00000001000000010000000000003300
                  00006600000099000000CC000000FF0000000033000033330000663300009933
                  0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                  000000990000339900006699000099990000CC990000FF99000000CC000033CC
                  000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                  0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                  330000333300333333006633330099333300CC333300FF333300006633003366
                  33006666330099663300CC663300FF6633000099330033993300669933009999
                  3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                  330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                  66006600660099006600CC006600FF0066000033660033336600663366009933
                  6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                  660000996600339966006699660099996600CC996600FF99660000CC660033CC
                  660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                  6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                  990000339900333399006633990099339900CC339900FF339900006699003366
                  99006666990099669900CC669900FF6699000099990033999900669999009999
                  9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                  990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                  CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                  CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                  CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                  CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                  CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                  FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                  FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                  FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                  FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                  000000808000800000008000800080800000C0C0C00080808000191919004C4C
                  4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                  6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909
                  0909090909090909E8E8E8E8818181818181818181818181E8E8E8E809101010
                  1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809101010
                  1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809090909
                  0909090909090909E8E8E8E8818181818181818181818181E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
                NumGlyphs = 2
                OnClick = BtnMyGetFileDelClick
              end
              object BtnMyGetTxtAdd: TRzRapidFireButton
                Left = 447
                Top = 10
                Width = 23
                Height = 22
                Glyph.Data = {
                  36060000424D3606000000000000360400002800000020000000100000000100
                  08000000000000020000830B0000830B00000001000000010000000000003300
                  00006600000099000000CC000000FF0000000033000033330000663300009933
                  0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                  000000990000339900006699000099990000CC990000FF99000000CC000033CC
                  000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                  0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                  330000333300333333006633330099333300CC333300FF333300006633003366
                  33006666330099663300CC663300FF6633000099330033993300669933009999
                  3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                  330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                  66006600660099006600CC006600FF0066000033660033336600663366009933
                  6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                  660000996600339966006699660099996600CC996600FF99660000CC660033CC
                  660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                  6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                  990000339900333399006633990099339900CC339900FF339900006699003366
                  99006666990099669900CC669900FF6699000099990033999900669999009999
                  9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                  990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                  CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                  CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                  CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                  CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                  CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                  FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                  FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                  FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                  FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                  000000808000800000008000800080800000C0C0C00080808000191919004C4C
                  4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                  6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  09090909E8E8E8E8E8E8E8E8E8E8E8E881818181E8E8E8E8E8E8E8E8E8E8E8E8
                  09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                  09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                  09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E809090909
                  0910100909090909E8E8E8E88181818181ACAC8181818181E8E8E8E809101010
                  1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809101010
                  1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809090909
                  0910100909090909E8E8E8E88181818181ACAC8181818181E8E8E8E8E8E8E8E8
                  09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                  09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                  09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                  09090909E8E8E8E8E8E8E8E8E8E8E8E881818181E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
                NumGlyphs = 2
                OnClick = BtnMyGetFileAddClick
              end
              object BtnMyGetTxtOpen: TRzRapidFireButton
                Left = 422
                Top = 10
                Width = 23
                Height = 22
                Glyph.Data = {
                  36060000424D3606000000000000360400002800000020000000100000000100
                  08000000000000020000430B0000430B00000001000000010000000000003300
                  00006600000099000000CC000000FF0000000033000033330000663300009933
                  0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                  000000990000339900006699000099990000CC990000FF99000000CC000033CC
                  000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                  0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                  330000333300333333006633330099333300CC333300FF333300006633003366
                  33006666330099663300CC663300FF6633000099330033993300669933009999
                  3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                  330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                  66006600660099006600CC006600FF0066000033660033336600663366009933
                  6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                  660000996600339966006699660099996600CC996600FF99660000CC660033CC
                  660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                  6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                  990000339900333399006633990099339900CC339900FF339900006699003366
                  99006666990099669900CC669900FF6699000099990033999900669999009999
                  9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                  990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                  CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                  CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                  CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                  CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                  CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                  FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                  FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                  FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                  FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                  000000808000800000008000800080800000C0C0C00080808000191919004C4C
                  4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                  6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                  0000000000000000000000000000000000000000000000000000000000000000
                  0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8A378787878
                  787878787878AAE8E8E8E88181818181818181818181ACE8E8E8A3A3D5CECECE
                  CECECECECEA378E8E8E88181E3ACACACACACACACAC8181E8E8E8A3A3CED5D5D5
                  D5D5D5D5D5CE78A3E8E88181ACE3E3E3E3E3E3E3E3AC8181E8E8A3A3CED5D5D5
                  D5D5D5D5D5CEAA78E8E88181ACE3E3E3E3E3E3E3E3ACAC81E8E8A3CEA3D5D5D5
                  D5D5D5D5D5CED578A3E881AC81E3E3E3E3E3E3E3E3ACE38181E8A3CEAAAAD5D5
                  D5D5D5D5D5CED5AA78E881ACACACE3E3E3E3E3E3E3ACE3AC81E8A3D5CEA3D6D6
                  D6D6D6D6D6D5D6D678E881E3AC81E3E3E3E3E3E3E3E3E3E381E8A3D5D5CEA3A3
                  A3A3A3A3A3A3A3A3CEE881E3E3AC81818181818181818181ACE8A3D6D5D5D5D5
                  D6D6D6D6D678E8E8E8E881E3E3E3E3E3E3E3E3E3E381E8E8E8E8E8A3D6D6D6D6
                  A3A3A3A3A3E8E8E8E8E8E881E3E3E3E38181818181E8E8E8E8E8E8E8A3A3A3A3
                  E8E8E8E8E8E8E8090909E8E881818181E8E8E8E8E8E8E8818181E8E8E8E8E8E8
                  E8E8E8E8E8E8E8E80909E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8
                  E8E8E809E8E8E809E809E8E8E8E8E8E8E8E8E881E8E8E881E881E8E8E8E8E8E8
                  E8E8E8E8090909E8E8E8E8E8E8E8E8E8E8E8E8E8818181E8E8E8}
                NumGlyphs = 2
                OnClick = BtnMyGetDirOpenClick
              end
              object EditMyGetTXT: TEdit
                Left = 128
                Top = 14
                Width = 289
                Height = 20
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                ParentFont = False
                TabOrder = 0
                Text = #36825#37324#36873#25321#20320#35201#28165#31354#30340#25991#20214#36335#24452#28155#21152#36827#21015#34920
              end
              object ListBoxMyGetTXT: TListBox
                Left = 8
                Top = 36
                Width = 488
                Height = 52
                Hint = #25152#26377#24453#28165#31354#25968#25454#30340#21015#34920
                ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                ItemHeight = 12
                MultiSelect = True
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
              end
              object Button1: TButton
                Left = 528
                Top = 16
                Width = 51
                Height = 25
                Hint = #28165#31354#25152#26377#24453#28165#31354#25968#25454#30340#25991#20214#21015#34920
                Caption = #28165#31354
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
                OnClick = Button4Click
              end
            end
            object RzSplitter2: TRzSplitter
              Left = 1
              Top = 1
              Width = 501
              Height = 185
              Orientation = orVertical
              Position = 91
              Percent = 49
              RealTimeDrag = True
              LowerRight.BorderWidth = 1
              SplitterWidth = 2
              Align = alClient
              Color = clActiveCaption
              TabOrder = 0
              OnCanResize = RzSplitter2CanResize
              BarSize = (
                0
                91
                501
                93)
              UpperLeftControls = (
                GroupBox43)
              LowerRightControls = (
                GroupBox44)
              object GroupBox43: TGroupBox
                Left = 0
                Top = 0
                Width = 501
                Height = 91
                Align = alClient
                Caption = #21024#38500#33258#23450#20041#25991#20214#25968#25454
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                object Label41: TLabel
                  Left = 8
                  Top = 15
                  Width = 120
                  Height = 12
                  Caption = #21024#38500#33258#23450#20041#25991#20214#36335#24452#65306
                end
                object BtnMyGetFileOpen: TRzRapidFireButton
                  Left = 422
                  Top = 12
                  Width = 23
                  Height = 22
                  Glyph.Data = {
                    36060000424D3606000000000000360400002800000020000000100000000100
                    08000000000000020000430B0000430B00000001000000010000000000003300
                    00006600000099000000CC000000FF0000000033000033330000663300009933
                    0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                    000000990000339900006699000099990000CC990000FF99000000CC000033CC
                    000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                    0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                    330000333300333333006633330099333300CC333300FF333300006633003366
                    33006666330099663300CC663300FF6633000099330033993300669933009999
                    3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                    330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                    66006600660099006600CC006600FF0066000033660033336600663366009933
                    6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                    660000996600339966006699660099996600CC996600FF99660000CC660033CC
                    660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                    6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                    990000339900333399006633990099339900CC339900FF339900006699003366
                    99006666990099669900CC669900FF6699000099990033999900669999009999
                    9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                    990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                    CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                    CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                    CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                    CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                    CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                    FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                    FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                    FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                    FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                    000000808000800000008000800080800000C0C0C00080808000191919004C4C
                    4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                    6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8A378787878
                    787878787878AAE8E8E8E88181818181818181818181ACE8E8E8A3A3D5CECECE
                    CECECECECEA378E8E8E88181E3ACACACACACACACAC8181E8E8E8A3A3CED5D5D5
                    D5D5D5D5D5CE78A3E8E88181ACE3E3E3E3E3E3E3E3AC8181E8E8A3A3CED5D5D5
                    D5D5D5D5D5CEAA78E8E88181ACE3E3E3E3E3E3E3E3ACAC81E8E8A3CEA3D5D5D5
                    D5D5D5D5D5CED578A3E881AC81E3E3E3E3E3E3E3E3ACE38181E8A3CEAAAAD5D5
                    D5D5D5D5D5CED5AA78E881ACACACE3E3E3E3E3E3E3ACE3AC81E8A3D5CEA3D6D6
                    D6D6D6D6D6D5D6D678E881E3AC81E3E3E3E3E3E3E3E3E3E381E8A3D5D5CEA3A3
                    A3A3A3A3A3A3A3A3CEE881E3E3AC81818181818181818181ACE8A3D6D5D5D5D5
                    D6D6D6D6D678E8E8E8E881E3E3E3E3E3E3E3E3E3E381E8E8E8E8E8A3D6D6D6D6
                    A3A3A3A3A3E8E8E8E8E8E881E3E3E3E38181818181E8E8E8E8E8E8E8A3A3A3A3
                    E8E8E8E8E8E8E8090909E8E881818181E8E8E8E8E8E8E8818181E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E80909E8E8E8E8E8E8E8E8E8E8E8E8E8E88181E8E8E8E8E8E8
                    E8E8E809E8E8E809E809E8E8E8E8E8E8E8E8E881E8E8E881E881E8E8E8E8E8E8
                    E8E8E8E8090909E8E8E8E8E8E8E8E8E8E8E8E8E8818181E8E8E8}
                  NumGlyphs = 2
                  OnClick = BtnMyGetDirOpenClick
                end
                object BtnMyGetFileAdd: TRzRapidFireButton
                  Left = 447
                  Top = 12
                  Width = 23
                  Height = 22
                  Glyph.Data = {
                    36060000424D3606000000000000360400002800000020000000100000000100
                    08000000000000020000830B0000830B00000001000000010000000000003300
                    00006600000099000000CC000000FF0000000033000033330000663300009933
                    0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                    000000990000339900006699000099990000CC990000FF99000000CC000033CC
                    000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                    0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                    330000333300333333006633330099333300CC333300FF333300006633003366
                    33006666330099663300CC663300FF6633000099330033993300669933009999
                    3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                    330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                    66006600660099006600CC006600FF0066000033660033336600663366009933
                    6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                    660000996600339966006699660099996600CC996600FF99660000CC660033CC
                    660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                    6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                    990000339900333399006633990099339900CC339900FF339900006699003366
                    99006666990099669900CC669900FF6699000099990033999900669999009999
                    9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                    990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                    CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                    CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                    CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                    CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                    CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                    FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                    FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                    FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                    FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                    000000808000800000008000800080800000C0C0C00080808000191919004C4C
                    4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                    6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    09090909E8E8E8E8E8E8E8E8E8E8E8E881818181E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E809090909
                    0910100909090909E8E8E8E88181818181ACAC8181818181E8E8E8E809101010
                    1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809101010
                    1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809090909
                    0910100909090909E8E8E8E88181818181ACAC8181818181E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09090909E8E8E8E8E8E8E8E8E8E8E8E881818181E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
                  NumGlyphs = 2
                  OnClick = BtnMyGetFileAddClick
                end
                object BtnMyGetFileDel: TRzRapidFireButton
                  Left = 472
                  Top = 12
                  Width = 23
                  Height = 22
                  Glyph.Data = {
                    36060000424D3606000000000000360400002800000020000000100000000100
                    08000000000000020000830B0000830B00000001000000010000000000003300
                    00006600000099000000CC000000FF0000000033000033330000663300009933
                    0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                    000000990000339900006699000099990000CC990000FF99000000CC000033CC
                    000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                    0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                    330000333300333333006633330099333300CC333300FF333300006633003366
                    33006666330099663300CC663300FF6633000099330033993300669933009999
                    3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                    330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                    66006600660099006600CC006600FF0066000033660033336600663366009933
                    6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                    660000996600339966006699660099996600CC996600FF99660000CC660033CC
                    660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                    6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                    990000339900333399006633990099339900CC339900FF339900006699003366
                    99006666990099669900CC669900FF6699000099990033999900669999009999
                    9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                    990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                    CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                    CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                    CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                    CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                    CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                    FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                    FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                    FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                    FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                    000000808000800000008000800080800000C0C0C00080808000191919004C4C
                    4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                    6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909
                    0909090909090909E8E8E8E8818181818181818181818181E8E8E8E809101010
                    1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809101010
                    1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809090909
                    0909090909090909E8E8E8E8818181818181818181818181E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
                  NumGlyphs = 2
                  OnClick = BtnMyGetFileDelClick
                end
                object EditMyGetFile: TEdit
                  Left = 128
                  Top = 12
                  Width = 289
                  Height = 20
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 0
                  Text = #36825#37324#36873#25321#20320#35201#21024#38500#30340#25991#20214#36335#24452#28155#21152#36827#21015#34920
                end
                object ListBoxMyGetFile: TListBox
                  Left = 4
                  Top = 34
                  Width = 491
                  Height = 52
                  Hint = #25152#26377#24453#21024#38500#30340#25991#20214#25968#25454#30340#21015#34920
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  ItemHeight = 12
                  MultiSelect = True
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 1
                end
                object Button7: TButton
                  Left = 528
                  Top = 16
                  Width = 49
                  Height = 25
                  Hint = #28165#31354#25152#26377#24453#21024#38500#25968#25454#30340#25991#20214#21015#34920
                  Caption = #28165#31354
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 2
                  OnClick = Button5Click
                end
              end
              object GroupBox44: TGroupBox
                Left = 1
                Top = 1
                Width = 499
                Height = 90
                Align = alClient
                Caption = #21024#38500#33258#23450#20041#30446#24405#25968#25454
                Font.Charset = GB2312_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                object Label42: TLabel
                  Left = 8
                  Top = 15
                  Width = 120
                  Height = 12
                  Caption = #21024#38500#33258#23450#20041#30446#24405#36335#24452#65306
                end
                object BtnMyGetDirOpen: TRzRapidFireButton
                  Left = 422
                  Top = 10
                  Width = 23
                  Height = 22
                  Glyph.Data = {
                    36060000424D3606000000000000360400002800000020000000100000000100
                    08000000000000020000420B0000420B00000001000000010000000000003300
                    00006600000099000000CC000000FF0000000033000033330000663300009933
                    0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                    000000990000339900006699000099990000CC990000FF99000000CC000033CC
                    000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                    0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                    330000333300333333006633330099333300CC333300FF333300006633003366
                    33006666330099663300CC663300FF6633000099330033993300669933009999
                    3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                    330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                    66006600660099006600CC006600FF0066000033660033336600663366009933
                    6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                    660000996600339966006699660099996600CC996600FF99660000CC660033CC
                    660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                    6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                    990000339900333399006633990099339900CC339900FF339900006699003366
                    99006666990099669900CC669900FF6699000099990033999900669999009999
                    9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                    990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                    CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                    CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                    CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                    CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                    CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                    FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                    FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                    FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                    FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                    000000808000800000008000800080800000C0C0C00080808000191919004C4C
                    4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                    6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                    E8E8A3CEA3D5D5D5D5D5E8E8E8E8E8E8E8E881AC81E3E3E3E3E3E8E8E8E8E8E8
                    E8E8A3CEA3D6D6D6D6D6E8E8E8E8E8E8E8E881AC81E3E3E3E3E3E8E8E8E8E8E8
                    E8E8A3D5D5A3A3A3A3A3E8E8E8E8E8E8E8E881E3E38181818181E8E8E8E8DFE8
                    DFE8A3D6D5D5D5D6D6D6E8E8E8E8DFE8DFE881E3E3E3E3E3E3E3E8E8E8E8E8E8
                    E8E8E8A3D6D6D6A3A3A3E8E8E8E8E8E8E8E8E881E3E3E3818181E8E8E8E8DFE8
                    E8E8E8E8A3A3A3E8E8E8E8E8E8E8DFE8E8E8E8E8818181E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8A378787878
                    78787878E8E8E8E8E8E8E8818181818181818181E8E8E8E8E8E8A3CEA3D5CECE
                    CECEA3D578E8E8E8E8E881AC81E3ACACACAC81E381E8E8E8E8E8A3CEA3D5D5D5
                    D5D5CED578E8E8E8E8E881AC81E3E3E3E3E3ACE381E8E8E8E8E8A3CEA3D5D5D5
                    D5D5CED578E8E8E8E8E881AC81E3E3E3E3E3ACE381E8E8E8E8E8A3CEA3D6D6D6
                    D6D6D5D8D8D8D8D8E8E881AC81E3E3E3E3E3E38181818181E8E8A3D5D5A3A3A3
                    A3A3A3A3D8D8D8D8E8E881E3E38181818181818181818181E8E8A3D6D5D5D5D6
                    D6D678E8E8D8D8D8D8E881E3E3E3E3E3E3E381E8E881818181E8E8A3D6D6D6A3
                    A3A3E8E8E8E8D8E8D8D8E881E3E3E3818181E8E8E8E881E88181E8E8A3A3A3E8
                    E8E8E8E8E8E8E8E8E8D8E8E8818181E8E8E8E8E8E8E8E8E8E881}
                  NumGlyphs = 2
                  OnClick = BtnMyGetDirOpenClick
                end
                object BtnMyGetDirAdd: TRzRapidFireButton
                  Left = 447
                  Top = 10
                  Width = 23
                  Height = 22
                  Glyph.Data = {
                    36060000424D3606000000000000360400002800000020000000100000000100
                    08000000000000020000830B0000830B00000001000000010000000000003300
                    00006600000099000000CC000000FF0000000033000033330000663300009933
                    0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                    000000990000339900006699000099990000CC990000FF99000000CC000033CC
                    000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                    0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                    330000333300333333006633330099333300CC333300FF333300006633003366
                    33006666330099663300CC663300FF6633000099330033993300669933009999
                    3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                    330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                    66006600660099006600CC006600FF0066000033660033336600663366009933
                    6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                    660000996600339966006699660099996600CC996600FF99660000CC660033CC
                    660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                    6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                    990000339900333399006633990099339900CC339900FF339900006699003366
                    99006666990099669900CC669900FF6699000099990033999900669999009999
                    9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                    990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                    CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                    CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                    CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                    CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                    CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                    FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                    FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                    FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                    FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                    000000808000800000008000800080800000C0C0C00080808000191919004C4C
                    4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                    6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    09090909E8E8E8E8E8E8E8E8E8E8E8E881818181E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E809090909
                    0910100909090909E8E8E8E88181818181ACAC8181818181E8E8E8E809101010
                    1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809101010
                    1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809090909
                    0910100909090909E8E8E8E88181818181ACAC8181818181E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09101009E8E8E8E8E8E8E8E8E8E8E8E881ACAC81E8E8E8E8E8E8E8E8E8E8E8E8
                    09090909E8E8E8E8E8E8E8E8E8E8E8E881818181E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
                  NumGlyphs = 2
                  OnClick = BtnMyGetFileAddClick
                end
                object BtnMyGetDirDel: TRzRapidFireButton
                  Left = 472
                  Top = 10
                  Width = 23
                  Height = 22
                  Glyph.Data = {
                    36060000424D3606000000000000360400002800000020000000100000000100
                    08000000000000020000830B0000830B00000001000000010000000000003300
                    00006600000099000000CC000000FF0000000033000033330000663300009933
                    0000CC330000FF33000000660000336600006666000099660000CC660000FF66
                    000000990000339900006699000099990000CC990000FF99000000CC000033CC
                    000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
                    0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
                    330000333300333333006633330099333300CC333300FF333300006633003366
                    33006666330099663300CC663300FF6633000099330033993300669933009999
                    3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
                    330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
                    66006600660099006600CC006600FF0066000033660033336600663366009933
                    6600CC336600FF33660000666600336666006666660099666600CC666600FF66
                    660000996600339966006699660099996600CC996600FF99660000CC660033CC
                    660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
                    6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
                    990000339900333399006633990099339900CC339900FF339900006699003366
                    99006666990099669900CC669900FF6699000099990033999900669999009999
                    9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
                    990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
                    CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
                    CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
                    CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
                    CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
                    CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
                    FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
                    FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
                    FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
                    FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
                    000000808000800000008000800080800000C0C0C00080808000191919004C4C
                    4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
                    6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
                    0000000000000000000000000000000000000000000000000000000000000000
                    0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909
                    0909090909090909E8E8E8E8818181818181818181818181E8E8E8E809101010
                    1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809101010
                    1010101010101009E8E8E8E881ACACACACACACACACACAC81E8E8E8E809090909
                    0909090909090909E8E8E8E8818181818181818181818181E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
                    E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
                  NumGlyphs = 2
                  OnClick = BtnMyGetFileDelClick
                end
                object EditMyGetDir: TEdit
                  Left = 128
                  Top = 12
                  Width = 289
                  Height = 20
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  TabOrder = 0
                  Text = #36825#37324#36873#25321#20320#35201#21024#38500#30340#30446#24405#36335#24452#28155#21152#36827#21015#34920
                end
                object ListBoxMyGetDir: TListBox
                  Left = 4
                  Top = 34
                  Width = 489
                  Height = 52
                  Hint = #25152#26377#24453#28165#31354#30340#30446#24405#25968#25454#30340#21015#34920
                  ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
                  ItemHeight = 12
                  MultiSelect = True
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 1
                end
                object Button2: TButton
                  Left = 528
                  Top = 16
                  Width = 49
                  Height = 25
                  Hint = #28165#31354#25152#26377#24453#21024#38500#25968#25454#30340#25991#20214#21015#34920
                  Caption = #28165#31354
                  ParentShowHint = False
                  ShowHint = True
                  TabOrder = 2
                  OnClick = Button5Click
                end
              end
            end
          end
        end
      end
      object ClearSaveBtn: TRzBitBtn
        Left = 367
        Top = 312
        Width = 57
        Height = 22
        Caption = #20445#23384
        Enabled = False
        TabOrder = 1
        OnClick = ClearSaveBtnClick
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000730E0000730E00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909
          090909090909090909E8E8E881818181818181818181818181E8E809101009E3
          1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
          1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
          1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
          E3E3E3E3E309101009E8E881ACAC81E3E3E3E3E3E381ACAC81E8E80910101009
          090909090910101009E8E881ACACAC818181818181ACACAC81E8E80910101010
          101010101010101009E8E881ACACACACACACACACACACACAC81E8E80910100909
          090909090909101009E8E881ACAC8181818181818181ACAC81E8E8091009D7D7
          D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8091009D709
          0909090909D7091009E8E881AC81D7818181818181D781AC81E8E8091009D7D7
          D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E809E309D709
          0909090909D7090909E8E881E381D7818181818181D7818181E8E8091009D7D7
          D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E80909090909
          090909090909090909E8E88181818181818181818181818181E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
        NumGlyphs = 2
      end
      object RzBitBtn2: TRzBitBtn
        Left = 431
        Top = 312
        Width = 81
        Height = 22
        Caption = #24320#22987#28165#31354
        TabOrder = 2
        OnClick = RzBitBtn2Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000E30E0000E30E00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
          6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8121212
          12121212121212E8E8E8E8E8E881818181818181818181E8E8E8E8E812181818
          1818121812121212E8E8E8E881E2E2E2E2E281E281818181E8E8E8E8121E1818
          1818181218121212E8E8E8E881ACE2E2E2E2E281E2818181E8E8E8E812181E18
          1818181812181212E8E8E8E881E2ACE2E2E2E2E281E28181E8E8E8E8121E181E
          1818181818121812E8E8E8E881ACE2ACE2E2E2E2E281E281E8E8E8E8121E1E18
          1E18181818181212E8E8E8E881ACACE2ACE2E2E2E2E28181E8E8E8E8128D1E1E
          181E181818181812E8E8E8E881E3ACACE2ACE2E2E2E2E281E8E8E8E8128D8D1E
          1E181E1818181812E8E8E8E881E3E3ACACE2ACE2E2E2E281E8E8E8E8E8121212
          12121212121212E8E8E8E8E8E881818181818181818181E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
          E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
        NumGlyphs = 2
      end
    end
    object TabSheet13: TTabSheet
      Caption = #30456#20851#20449#24687
      ImageIndex = 3
      object Label59: TLabel
        Left = 8
        Top = 308
        Width = 480
        Height = 24
        Caption = #26412#31243#24207#21482#36866#29992#20110#20013#21326#20154#27665#20849#21644#22269#27861#24459#20801#35768#33539#22260#20869#30340#20010#20154#23089#20048#65292#19981#24471#29992#20110#21830#19994#30408#21033#24615#32463#33829#65292#22914#13#22240#27492#36896#25104#30340#21518#26524#33258#36127#19982#26412#36719#20214#26080#20851#12290
        Color = clBtnFace
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Image1: TImage
        Left = 9
        Top = 2
        Width = 493
        Height = 91
        Picture.Data = {
          0A544A504547496D616765272E0000FFD8FFE000104A46494600010200006400
          640000FFEC00114475636B79000100040000003C0000FFEE000E41646F626500
          64C000000001FFDB0084000604040405040605050609060506090B080606080B
          0C0A0A0B0A0A0C100C0C0C0C0C0C100C0E0F100F0E0C1313141413131C1B1B1B
          1C1F1F1F1F1F1F1F1F1F1F010707070D0C0D181010181A1511151A1F1F1F1F1F
          1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F1F
          1F1F1F1F1F1F1F1F1F1F1F1FFFC0001108005B01ED03011100021101031101FF
          C400AF0000020301010100000000000000000000000102040503060701000301
          010101000000000000000000000001020304050610000201030203030A030507
          02040701000102030011041205213191411306516171D122325253141581A142
          B1C1233307E162728292A2B2D243C2932454F0F1E27325352617110002020102
          05020404040602030000000001110203211231415113046114F07122328191A1
          42B1E15233C1D162E2231572A2436305FFDA000C03010002110311003F00FB40
          15EA9F3E5A836F9668C386450796A26FF903516C891A57136A49FDA67F991F53
          EAA5DD457B77D507DA67F991F53EAA3BA87EDDF543FB44FF00323EA7D5477507
          B77D507DA66F991F56F551DD41D87D507DA26F991F56F551DD41EDDF541F699F
          E647D4FAA8EEA0F6EFAA0FB44DF323EA7D54BBA83DBBEA83ED337CC8FA9F551D
          D41EDDF541F699BE647D5BD547750761F541F689BE647D4FAA8EEA0EC3EA83ED
          337CC8FAB7AA8EEA0EC3EA83ED137CC8FA9F553EEA0F6EFAA0FB4CDF323EADEA
          A3BA85D87D50BED33FCC8FAB7AA8EEA0F6EFAA0FB4CDF323EA7D547750761F54
          3FB4CDF323EA7D54BBA87D87D507DA67F991F56F551DD42EC3EA85F699BE647D
          5BD54FBA83B0FAA0FB44FF00323EA7D547750761F541F689BE647D4FAA8EEA0F
          6EFAA0FB4CFF00323EA7D547750BDBBEA83ED137CC8FAB7AA8EEA0F6EFAA0FB4
          CDF323EA7D547750FDBBEA83ED13FCC8FA9F551DD41EDDF541F689BE647D5BD5
          477507B77D507DA27EC923EA7D5477507B77D507DA26F991F56F551DD42F6EFA
          A0FB44FF00323EADEAA3BA83DBBEA83ED13FCC8FAB7AA8EEA0F6EFAA17DA26F9
          91F56F551DD41EDDF541F689FE647D5BD5477507B77D50FED137CC8FA9F551DD
          41EDDF541F689FE647D5BD5477507B77D507DA26F991F56F551DD41EDDF54036
          99C7FDC8FAB7AA8EEA1FB77D507DA27F991F56F551DD42F6EFAA0FB3CFF323EA
          7D5477507B77D500D9E7F991F53EAA3BA83DBBEA898DA26B7F323EA7D54BBA8A
          F6EFAA25F699BE647D4FAA97750FDBBEA83ED535FF00991F53EAA3BA83B0FAA1
          8DB27F991F53EAA3B886B03EA83ED93FCC8FA9F551DC41D87D507DAE6F8E3EA7
          D547710BB0FAA0FB5CDF323EA7D547710761F542FB5CDF323EA7D547710761F5
          41F6B9BE647D4FAA8EE20EC3EA83ED737CC8FA9F551DC41D87D50BED73FCC8FA
          9F553EE21761F5444ED531FF00B91F53EAA3BA83B0FAA17DAA6F991F56F553EE
          A1761F541F699FE647D4FAA8EEA0EC3EA847689BE647D5BD547750BDBBEA85F6
          89FE647D5BD547750BDBBEA85F679BE647D5BD54FBA83DBBEA85F679FE647D5B
          D5477507B77D508ECF3FCC8FAB7AA8EEA17B77D507D9E7F991F56F553EF20F6E
          FAA3864E0CB8EA19995949B7B249FDA05556E9917C4EA56AB332CD6668359245
          165620790134421A6C7DF4DF1B7534421EE64BBD9BE36EA69421EE60259BE36E
          A68841B992124B6F7DBA9A50872C9A0CA7F70BB7F86E68D06B7319873C0B9494
          0F386A5352B6DBD4E65E6078BB5FD26AA1112C3BC9BE36EA69421CB02F35BDF6
          EA68842961DE4DF1B7534420962EF25F8DBA9A2106E63EF26B7BEDD4D1083731
          77937C6DD4D3842DCC5DE4BF1B75344214B0EF26F8DBA9A2104B0EF25EC76EA6
          88412FA877937C6DD4D1083730EF26F8DBA9A2104BEA1DE4DF1B7534420DCFA8
          77937C6DD4D10825877937C6DD4D1082586B9BE36EA688412C5DE4DF1B753442
          0963EF26F8DBA9A2104BEA1DE4DF1B753442097D45DE4DF1B7534420963EF26F
          8DBA9A2106E61DE4DF1B7534420DCC3BC9BE36EA688412FA8BBC9BE36EA68841
          2C3BC9BE36EA68842961DE4DF1B753442096483CA7F5B7534421CBEA4819B9EB
          6EA696839630D37C6DD4D1A0E592066F8DBA9A5A0F5240CB6F7DBA9A210F50D5
          281EF9EA68841A81793E36EA69420962EF25F8CF5344209622F2F63B7534E109
          B602497E36EA688412C7AE5F8DBA9A50872C35CBF1B75344214B119251FADBA9
          A70852C42497E36EA688412C0CB37C6DD4D3841B991324C4FBEDD4D1085B98B5
          CDF1B7534F409622F2FC6DD4D108258BBC97E36EA6884297D43BC9BE36EA6884
          12C5DECDF1B7534E10B7322659BE36EA68842DCC5DECC3F5B75344216E7D48F7
          D37CC6EA69ED41B9F50334DF31BA9A7085B9F5177D3FCC6B7A4D1B506E7D48BC
          8EDEF316B794DE88136C8D311DAF510683001A0630280241785228B387833E53
          E98C580F79CF21536BA4698F1BB3D0D144DB715CC50C4D9F949C1C0B6843FDE6
          3EC2FA389F3564DD9EBF6A3AAB4A5744B7326DB9EE89FF00B7857E5AABC96FF3
          6A887FB6A7B757D5FC7E269DCB2E8BE3F02B64788B7341EC3417F3C6FF00BA4A
          BAE0ABEBF1F8116F22CBA7C7E2561E2BC673A374C3565F9F0FB56F3953661F81
          357EDDAFB599BF22AFEF45A6C0C6C980656DB289E03FA41B91E6FEC3C6A77B4E
          2DA315B0A6A68E51474761AB939E0895A720D0B4D0280D344840683E4A020416
          8914068A61049A175F7948BF945290DB0474D3081AC4EC6CAA49F30A52090346
          CA6CC083E42284C1A1B4122805948079122890DAC8E8A6101A68080097E0389F
          25290824D0BAFBCA47A45098DD4895A620D14484068A242034D0101A68080D34
          0A034D010492091CD914B1F2017A4D8D55B3B0C1CA038C2FC3FBA6A77A34EDDB
          A11EED87022C7C86891412D34484120B7A24A3A0C59C8B88DBFD26A7722B63E8
          45E32A6CCA41F21E14D313443453914069A24203BA60BAAC74F96948B691D34C
          501A689080D344840DA371CC11E9A241A08B19E52429516F89957F69143B40EB
          46CB9F6CD389AD8A77CED68FF8881748E66F7E359F73535ECFD33CFE68E1F6E9
          7E28FF00F313D757DC23B4FD3F34738F1A4935E817D00B37A07334DDA09546F8
          127C48D70A39EE75BB94B76580BD256FAA06F1ADA9FA8E7C1448F18A5CBCCA49
          1E706D42BF1F40B6384A399CCE3C70C8C990ADECF354B137A7BA5682DA93D4E9
          045B7CF3C70849D4C8C14315B017A56764A741D6B4B34B52BBE322E59878940E
          52FDB606D56ADA499BA25683B4B818E3736C51AF406D2B6B1373D2A15DED934B
          625BF697CECFB76BD0033911DBD92BC64FF573ACFBB637F6F498F4FD48C9E1FC
          631C51A8916573767D20DB85ECD63614D677A89F88A12D64C3CD8F161C978609
          BBEEEF83B01601BC95D146DA968E1C95AA709C9C0F3AA3315E803B549A921401
          251498CB38F019A5083813CCF90769A96E0D295DCE0D35BCD7C4C6262C488E99
          E5536776ED443FF26FC071E58BD357C4EDAA9D17DA19B20C1486048BBA472163
          005905CD2A2DDA9577B6141DD7331601EC805BB588B9353B1B295D2394DBE41A
          487D257B430047E74D616279D1E13C6FBA6DF850C59B8C142BC8229A0522DC54
          B065F27BBCABD2F131DACE19E6F956AAD519BB278A25C595737024D51B1B4D09
          E4C3E161D87C86B7CBE3AB28B1CD8BC874728FA0AE4E26E7869B8E2FBAE3F88B
          DA0F6DFCE3B6BCC75757B59E959ABADC8E063B1BD34CCA0453CB448A0D45CAD9
          3020899C77B3C82E100D6F7F476563B6F67E874ABE2C694EAC9C3BEE14CE125C
          368D1BF532A91F88149E1B2E0CAAF9556E1D4E7BC6DD143A67845A37362A3903
          CC5A9E2C8DE8C9F230AAEAB8198ABED0F4D6E729B3E23175C7F4B7EEAE6F1F99
          DBE6723220C692790471ADD9ABA2D68D4E3AD1D9C236269B1765C4B0FE265CBC
          1107366F50AE749E47E8765AD5C15EB66626AC895CC990FDE4AE6EC7B0798798
          574E8B81C52DEAF89EA72F144F82D0DBDA0A34FA40E15C35B45A4F57263DD483
          CB1437B1AEE3CA168A020D2D8F13BCCBEF587B3171FC4F2AC735A141D1E3639B
          4F43BF8896ED037610C3F654F8EF89A798B546760E2C73E42C723E853DBFBAB6
          BD9A527363A2B5A197E4DD363C37304311C891783685D76F4B1AC963BDB56E0E
          879B151C252CED8D99B56E27B9680C521F7432E927D0C2A6D4BD3592A9931E4D
          221997B8609C5C831F353C50F9AB6A5F7239B2E2D8E0ADA6AE4C834D0383536E
          DA6368FEA72CE9840B804DAE0769F3563932B985C4E9C38135BADC072788E042
          63DBB17BD55E064E089C3C9E5A4BC76F5B31BF312D28A482F88376278E3C16FF
          001BDFFE34FB14EAC9F7793A20CCDDCE4E3AC471B44ECC06A36650A38B10C395
          14C50E6740C9E46E511A9C20C679A411A0BB37FF0017AA76852675A3B38468CD
          91B7ED2153499F3185D5145D8FFD22B255B5FD11D36B53169C6C70FBE6EADC57
          1A151D81DDAFFED0455766BD591EE72744598B748A7B439B004BF00E0EA4BFA7
          98A8789AD6ACD2B9D5B4BA2B6E3B79C760E86F0B1E07B41F255D32499E6C5B78
          7029E9AD0C4F42B8EB2EDC909FD51A8FC6DCFAD723B45A4F4152691E879D68CA
          9B11623811E7AEB93CE685A689082DED78A25CB5B8BAA7B4DF872FCEA325A11A
          E0A6EB1777F178A13D9A88EA3FB2B3C1C59BF97C1190B1C6FA626C749F5B0003
          93C3B390ADE639C1C713A4496F71C76795605DB44F040A1222C1ADE7B0B1A8C7
          6D2774366B9A92E364A4543800024ECF180389366F555EFF00F518F6BFFACEDB
          6B04C94050468F78CC6A6E02B7002A726A8D30B8B23A64C6530A38CF359DC1FC
          16955EBF80ED58AA5EACEF1460C982CDEE451BC8C7FC2D7A96F89A556B5F44CA
          BB6386C879DD943481DC16200BB7BBCFD357916906585EB2FD44B1EEE48032C6
          A3C8078B9F9B8D36E9D3F882593FABF545648A44980958BC81FDB636BDEFC795
          5CA6B4325569EA59C9965877995E22039702ED6B58817E2795455274D4D6F66B
          2B6BA9763CD25FF8BDD0BB0650B2DF883C072AC9D3A7F0365935D63F339CB23E
          3CDDDC72C112962D94B2167672472361C071E15494AE7E84D9ED709A5D7D4C0C
          FF00A2FAA9171174C4BCEDC5351E2749F2574D26353832EDDCF6F02B1156662A
          622C01506A302F4319351E5A4C68B50C8F1C07BAFE7CCC2288F90936BFE1C49F
          454B5D781BE3D169C597B19730B9C7DBCA24786CA84C8A5D9DACAEC7DE8FE31C
          6FCEB2B6D4A6DCCE9AEEE15FDBF1E82DFF006CDFF3F19218E68859C3DFBAB5AC
          08B719FCF461C98EAE61FE7FED0CD8F25944AFCBFDC79CCCF0FF008F08EEE131
          BF0E3368407F0067AEBA67C1CFE3FF005392F833F2FF000FF33CE0F0EF8BF2B7
          49B6F12AC99702077042F6DAE3F9BA786A1C9ABAFBD86B556E4FE3A1CBD9CB6B
          3AFEE5F1D4F11E285DD62DC5F6FCF915CC1ED288F82F12CA7B5B8DD4F69AEFC1
          B5D775799C59B7270C9F8236BDCF73DE0E26DAEB7B0EF54D9AF70C7916417010
          9E747957AD29361E0C76BDA2A7D3B624CED877AFB4E6489247988CCA54580923
          B5C11A9C710D6E75E4E6DB969BEBC8F470A78AFB2DCCF4AA1581038E93A4FEEF
          CAB89E87408C62891410EE50317B7B4458B76D853916D5C4E90E34B33848D4B1
          3D07A693B25C475A36E11A5BD4A90E2E3E25EF23103F045E26B1C4A5B674F92E
          2AABCCC9D22F5B9C8D1B5BDC4F2BE34682ECC5801D2B9F0B893B7C952D24739A
          5C6D9B14136932E5E08839B1F20F30A693C8FD09B3AE1AF5B3316D2CB3364643
          6BC87E67B147C2BE6AE9D1285C0E2D5B9B713AC49AA451E52054B292D4F433E4
          F75B8E3C67DD95181F4DC5AB92B59AB67A37BC5D2EA646E98BDD663587B327B6
          BF8F3FCEB7C76947267A458A9A7B2B432835C91B7ECC5B94B3582F9753F01D05
          61F75CEBFEDE2F561BD8BE363379FF006ADFF751878B0F278231CA83715D071C
          0450C68815174A8EC149B9055496876C656FAA8747BDAD6DD6A6DC19745F522F
          788197EA214FD5A189F45C5678168CDFCB7F524655AB73920EF858E27CA8E33C
          89F6BD0389A9BDA149A63AEEB245AF104A659930578408A1E60385FE15F45678
          142DDCCD7CBB4B54E45108A14002C072AD4C209AA529192B0A4334F6B54871A6
          CA6EC06DE8517FCEB1C9AB48EAC0956AEC64C48EECF912719A63A9C9EC1D8BF8
          56EDF25C0E4AA6F57C59D872A92C2C3B6819A9827EA7064C77E257D953E63EEF
          4358DF4B49D38BEAA3A99257813CB856E7241B59139C7970D792B5D1BD1603F6
          D73554A676DEDB5D4A3BAE3E8C9D407B327B43D3DB5AE3B4A30CF48B7CCA6578
          5EACC60D181860ED72E530F6DC5D4769EC515935BAD07451ECC6EC3CF1AF6CC6
          63C48D173E95228A7DCC32EB8EA65851DBCAB539A0E5DC6D77E33CF1FF00F73B
          D03FD41AAE6DD17E846CA756BF3FF33BE4B44D1262E0E429C622F2BA3132BDAD
          CC9E2071A9AA73365A97688DB47F4FEA0883E3096E458DBF3A4348ECEC8D8D1C
          6F928F28919D8B30B9045A973E0536B6C4EB22C9D12411451E52A111B249A5C0
          362D7B72E545747302BC34927C8AE6289C18D8A327224D8A70AA968884F4258B
          89850E4C5283026860752E9040078F2145AD66A351D295564F4225E379DA4560
          50C8C430E446A34E2109B4DCAEA3CB9A16CF9E617950312046C012401C89E1CE
          8AA7B521E4B2776F89631B704946A73243636D32CC809E8A6A2D48F5FC0BA659
          E32BE6FF0091CB377D8172A41124F3203EFC524613F0D5C6AA985C6B04E4F256
          E712FE4D19597951E4CA6448A488FEA32B2B127FCB5B56B08E4C9756730D7CCA
          E6ACCC85022C0A93524290C9814868E1B1EE4997971A5886C746737E57B04BFF
          00B8D6B9F1ED5F32FC7C8ACFE45FC37CD9B70CF8F18DA30CBAB4B687D7DDA6AE
          371C34E8ACAE92AD5BF8E3FCCDE8DBB592F8E01B86378A740186D2EA278B77E3
          80FF0033D18ED8B9C7E5FC8592B97F6CFE7FCC36483C5B16E70BE7C921C41ABB
          D0D2A30F74E9E0189F7AD466B62757B78FC8302CCAEB770F98F686B78D3727F2
          C4C3FDD1D1997FC35F8EA185FF00CF6F8E8789F137F4C7C41BAEEB3E5C256247
          0507F2DAE35BB0604C896F7FB457A383FF00D0C74AA4FE3F43872F8392D66E3F
          81A6991B36CDB3A8C74FA6DE7175ABE4293A2350CCAD6F6B47F2F85C0FCEB1DB
          7C97D75A3E452BD294D34C8B9FC7A199B76E19FBB458BBBE4AF772C6ACCA3517
          6B9705999ACBF2C7656F9295A4D11956EED167C8F4BE1B9647FAB8EE5B438249
          E3C4DC7FE1AE2F297067478EDEA6C90C07115CA741D31B363C52CCD099AE00D2
          2D7FCE95A9BB9C154CAABAC497B1FC418ACC12485F1C1E448057F1D3CAB2B607
          C9C9BD3CBAF35070DCB6D5590E746C650E002CC6F61D96F355E3C9FB48CD861E
          F5A942C2B439CDFDD3708B062590A77933DD2141CC93CF8D72E3A3B3F43D0CF9
          9514F3E470CBC683718172A251DFA023CFE75ABAD9D1C3E067928B22DCB898C4
          71B768AE838CEB86BAB2A11E575BF5A9B706563FB97CCBBBD13F5D158D8A477B
          F9096FECACF0FDA6FE4FDEBE458CE032B023C95F79389FC7837E7514FA6D0699
          7EAA2B1430F1C4F9289FA6F77F40AD6F68473E3A6EB413DE26EFF39605E31E30
          D4DFE36E5D052C4A2B3D4AF22DBAF1FD25ADC543EDB8CDFE03D50D453EE66B9B
          5C75F8E465E817ADA4E580D3634E40D3DBF1520439B90422A8BADFC9E5F55617
          B4FD28E9C34DAB758CA9A77CBC8932DB82BFB312F910723F8D6EABB541CB6B3B
          B76216A6497B672067279C35BA56797ED37F1FEF23BAA91B84CC799D36F40514
          F17DA2CEBEB656001E554664D6F48687480D2417D8E5038FB2FC3F1AC9FDE8EA
          5FDA6678AD4E741D94008D0234F651C663D9651FB6B1CBC8EAF1B9998BEDB799
          9881E82D5B1CAB52FEF6DFC6813C8AE7F302B2C3C19D1E4BD523ACA7EAF6D127
          3922E27D2BC1BA8E3497D3682ADF5D279A33E089A699221FA8F13E6EDAD5B852
          73D56E7077DEA60F3C3869EE4404920FC907EFA9C4B46CD3C9B4B555CBE11DA7
          F6B668CFC257F26B54D7EF2EDFDA467AA3B9B28BDAB5939F89DBE8E41077841D
          45B4A2DC72ED353BB582F6389398C692FAB47B5E5E17A7B89DAFA10EEC4808D3
          A801A88B5EC076D3981448362C0215974AFB4C500D23B05E8DCE604E8A245262
          428911D0A4CA0B5B48E1636A15983A251EA35C76B988466E383285E5E914F706
          DE5039B6E5499E3110B29B0660AB7F45ED49649416C50E209BE032C1132DAEDA
          AEB750058F0B71A4AFA94F1424CA32446262B600F3B2D88E3E8AD539306A0E6B
          0896544916EA580371E5A730895597A9DDF03023C89B1DA468B4B5A36D375FF3
          5B954ABD9A4CB78E8ACD4C1432611148C81D640393A1B835AD5CA30BD61C1C0D
          510478DE988EE2A0D090A432608A43479FF0A4DA770981366EECAFE60FFE1AEE
          F294D51978AE2CCD8C493346E19EB8CAC55D95FBC401886EED032E920F20AA6F
          E7AC2C96DACFC713A2ADEE7029327C4C246091CC501B03DCFF00F4D34B1472FC
          C876CB3CFF0022CED93EFCF9A8B949208086D65A2D2059491C6C3B454E458E34
          89F99789E476D663E42DB07FFD0669FEE37FCD68C9F62162FEE33C6EFF00E30D
          D76ECF9208FBC982A77A4F7EC9C0B30B0015BE0AF470F8B5BD6787E070E5F22D
          5712FF00336E0876ADCB6E8E08F1CE4E5CE0B4928D4CACA589E5AAC7D9B7E9AE
          5B3B52CDB708DEAAB6AA494D85B5ECF95B6ED29839A8166581CABA924371B1E6
          14820B8ECA5972ABDB75784974C4EB587D0BFE0962F2EE4FFA4BA01F8173FBEB
          0F3745534F0FF71EA0853C2B80ED3998623C6D55B993B508E3C746E0D88BB1FF
          000F6694C9EE057D3E8ECFCEB37ADD1B2D3139325D1D4DAD71DA6BA13392C9A3
          4F7E17EE3FCFFBAB0C1CCEAF2B914B072E4C59B5738DB83AF9BCB5ADEBB91862
          BBA32DEE7849227D663F15617703B7FBDEBACF1DE3466B9B1A6B7229EDAB7CE8
          479EFD05EB4C8FE9665857D48E9BBB5F7171D8A883F69A9C5F6959DFD6CB5B3C
          CAEB2E33FBAC0903CC783546551A9A78F699AB278918C1C7C9C89B868B807FBA
          BEB34ACF7349158D76EAECCC788B153249FCC949792FE56ECFC39574338AB3C5
          F166B64FB5B3447C9A3F6DAB0AFDE765FF00B4BF0337F656C729A18B851C71FD
          5659091AF10ADFB5BD5595AFC91D18F124B75B819F9B9B26E6E3868C0437553C
          E43E53E6AD29454FFC8C3264795FFA3F89120721CA988811548964B1A7EE3223
          979E93C479BB69594A81D2DB5A66AEEB8BDFA2E541EDD97DAB76AF306B0C568D
          19D79F1EE5B918F723972AE838C903DB4864C370A503934F68991964C67E4F72
          A3CA08B1158E55CCE9F1EC9CD594B220782531BF67BA7CA3CB5A55CA31BD5D5C
          3395C5E99321C490071278002811A72B8DB76B666E33C9C154732EDC001E8AC9
          2DF6F43AACFB58FD599D84844B0464DECC809F4115ADDE8CE6C6B548B7BC9FFD
          620F863FDADFD959E2FB4DBC97F5FE04F6898095A16E520B81E71FD9465AE925
          78F6D63A9DB0F197164C89A4E091DC293F0FBD7E96A9BDA61178E9B5B6F918E9
          2199A4C87F7A762FE85FD23A56ED469D0E34E5CBE66A83AB646EDD37FC9EF58F
          EF3ABFF8BE3A999646211A2694B1006960B6BD6BF89CBC7949DB3D63EF560189
          2CA98EBA1195B48B9E2DCFF6D2A7099E25E54A636B7056EEE3FF00D8CDFF0098
          2AE7D519C2FE97F996701D44E80A9447BC650906CADC00B8FC2A2EB435C4F55F
          90E652B8912373599C1F485B50B8FE00D4557CD9DA340D2E116F7511DDBD0AD7
          A96F46525AD7F129E3ACD92E6417BBB778C6F600137173E8ABB348C689DB5FC4
          E99CB84772912693BC663768C31FE18E1C48A546F6E85E555DED373FE075931F
          1FBAEEB2A111E16302C26D60821B8FB3C38D2567329EACA745116515AF332127
          4566930D5B1D189D04DB55B95EB76B93D4E456E75D0D38B2B231F1A0134A64C8
          CB9008F501ECC60DC9E1E5AC5D536E3823A6B775AA972ECFF43AE5E4644CB990
          C1218F231DCBA9162593B471F254D6A9437C19792F6B6E49EA99E7A5972256D5
          3CA646E40900587E15D6925C0F3ECDBE2E4E44551046D401D2F5251206819206
          90E4F2734A76BF121278452B6A07B34BFF006F0AF42AB7E3396765CDD7DCA7C0
          4C99618A497BD612ABC5DD96034AAB0B48547FDB06B158D5E133A5E57598318F
          F51328311DDE4F03F063FF00D75D7FF5EBD3F539FDF5BD7F41FF00FE8995F2F2
          7FD18FFF00552FFAF5E9FA8BDF5BD7F43843E38962C99675C79834AB62F684BD
          C9B9BA96D2390AA7E14A895FA92BCB69B660EE13C9B9EE272122652C8B1A2358
          B1D259AE74DC737F2D75D2BB2B0735EDB99EA3C19B64FB664CAF142CED92AA24
          68740642BAB880E554F07AE0F3322BA52F8753BFC4A3ABE1C4D9F13E61C5C48C
          B2BC65524D2252864632B86B911DD47B4BC2B93C7AEE6FF0E1E9F33A3C9B6D4B
          FC7D7E45CF05E23636CA8F20B49924CC6FCEC782FE42F587996DD7F91A7895DB
          4F99BC4823CA3B472E15CA74B2C1CAD9E53676FA793C86E87D46A76DD7A97BF1
          3E3A322F26C90FB52E50603F49607FE205095DF040ED8ABC6C56C9CF6CF2B1C4
          863C242092C2C5C8E400F86AEB4DBC7EE32BE579345A57F8839BA30F31A10DF0
          3AEEB9B8B90F12412ABBA07D4A398E2A2963A35C479F256CD24CCF2D635A239C
          BBB6EE2B0131CC7F80DDA7F49F55464C73C389BE1CDB747C050E4ED516E4258B
          250C20331B1F7785BA71A1D6CEB0D6A15BE35794F42BE665C1939B34B130912E
          1432F11C1455D6AD2526792EAD66D0B1320C390927C278FA3B68B5650A97DAD3
          2CEF3B9E36508F171E4591756B9EDD817903E93518B1BAEACD7C9CD5BC56AFE6
          51D5C6B4309345F70C25DA7E9DE6559EDC2326C4FB771592C6F7CC68743CD5ED
          ED6F5FE672C0970A394C996E11578A16E57AABA6F44462B5539B16F333360CB0
          04F94ACABC935597F11DB59D2992BC11B64C986FC6C72EF3C3BCBEA97FD55519
          3A13387A95F325DA74A0C4984923358A86BF0B1355556E68CB23C7FB5EA59DA2
          6C48C4BDF32AB9B58BD87003CF519537C0D7C7B554C9993CD8F2E44AF01062D6
          4211C8DBC95BD534B539AD64DB6B81630B749B10E9B77911E263BDADE753517C
          6AC698F33A7C8B8D97E1FCA3791C4329E61AE8DD39567B722F5357930DB8E8C4
          D16C29C5B285B9DB58FDC29CE47C81D70AFDC55CBDCB64EEBB8C30659491678C
          1603CB763574C77996659336288AEACE092B2B0652430E2A47306AA0CD58D24D
          DF0E68C479EBA6DFF76DECFA6E38AD62F135AD4EA5E455A8B92FA5D9DC6B5CA0
          17FC6BFBC51BAFD036627AEE20DB9EC7807F84DDFE4762A7B6DFD94FB77B71D1
          09E6C58F86ACCC9723233320646500A52FDCC238E807B4F9EB55555508E5B5DD
          DEEB1DB0A68932E392560A8A6ECC790B52BA95A178EC959363DC3371F2735DE0
          904881146A5E22FC4D2A51AAEA3CD915AF29CA230CE63916453C548229B44D6D
          0E4B9BC6E98D9102E263C819E53FC5039AA0E2D7F4F2ACF16369CB37F233D6CB
          6D5F12896AD0C1B2F267E147B54B0CD32A4843E956EDEDACF6376948DD65AAC6
          D37A9483F11C6DE715A184881C6BE91B9329BD8094B21FD8D4F5FE90D3FAFF00
          33BE5C92AC498F8B3830BF19B2030676B0E4071D238D4D529968D2EDC6DABD39
          B2118663EC900AF1BB305FF9114DB123BC892BE2A079637984ACEFEDC6381161
          C8DAA134994D375E2A67AA164C73363C490CC88DDDB47211225C6A6BDB89F251
          56A754174DA493E5D515961BC8B1F0BA9045985B879C1B55C996DD60B32470CB
          9F92EF22A408DAA47B8E561CAA536AABA9A349DDB9D0E0BB8E3E72B63CF108F0
          491F4CDCCADB933798D576DD755F773256557D1A8AF23888238F30479122A44A
          6ED25F8691C6F715532A519ED4AD167A1CBEAC666E8B95CA2D4A900EC11A9E7F
          8D3DBB6B02EE6FBEEE5CBE4779F2FB8DE65990DC0938DB910471A9559A4156C9
          B7236BA95370FA5FAA7FA7904919371A4FBB7EC35A5263532CBB773DAF42A355
          9911A62263CF52344ADC38503017A0664789B677DC30C4902DF2A0B94039B2F6
          AFAABA3C7CBB1EBC19965C7B969C4CAD877B13C631276B6447C16FC3501FBC57
          564C50E57032C7927421B9EC225769F16CAE78B4478027CD5B62CF1A332C98A7
          5463498B3C4DA648D91BC845ABA9593E060D3476836E96560390EA6A2D9122AB
          46CF53B27865EE0AC76BF391ABCFCFE49DD83C667ADB6DFB2E119A62070BF1E0
          CC47EEAF31BB64B423D34AB8AB2CF0D1B64F8B77E24DFEDF03069DC70040E4A3
          D3C875AF45C60C7FEA679A9BCD7F43DEAD9542A8B2A8B0039002BCA3D124AF6E
          14A0699262AC2C45C790D00C8AC70A9BAC6AA79DC0028962490CB50390D54049
          02545CD85CF3A68965567BB1AB336C5AA8148AC9E414E443040E42D40C7AA940
          0AE01E039F3A007AA8003A49B9173E5A00090471E34031593E11D281683BA8FD
          23A50505D7B00140367397BB75D2EA1876822E2A968438644155165160380028
          01EAA02444822C78DFB0D0047BA841E11A827B6C29CB16D4765B5BC96A9650C3
          71F35003D4290E4E6D063B1BB4484F94A8355B992EABA12511A0B22851E402DF
          B296AC6A1113271A7002D7FF00CA8148D40E605BD14303A6AE152390045EF6E3
          DA681A0D540362254F317F4D021EAA0A925AA81C89122562CA8AAE781600036A
          72C4920758E45D322865F230B8FCE84E01A4F89CBE970FE447FE95F5556E7D49
          D95E8847170FE447FE95F552DCFA86CAF4448244A851502A76A8000A52109687
          268A1D1A340D17BE9ECBD526C8755C065A81C9CB4AADEC2C09B9AA2602F48088
          555165161CEC3CF4C94A046D401062298856E17A0474038D22912148704D6326
          891AA9DD221C3CD52D9A2A9E73C4DE0C19AE73B6D221CEF79E3BE9573E507F4B
          575F8FE5EDFA6DF69CF9FC6DDAD789E720F11E76DF2FD26F18EEB2270D76B3DB
          CE0F06F48AEEEDAB29AB3937BAB8B23770F7DD8B2071C84FF0BF03D1AD585B1D
          D7236ADEACD58375F0EC03519E216F86D585A9919D15C98D15F3FF00A8FB4E22
          15C41DEC9D879FECE1F9D14F06D6E23BF9D5AFDA61C58BE25F166409B24B62ED
          C4F191F9B2F91070BFECADED7C78142D6C732AE4CCE5F03DD6DBB761EDB8898B
          889A224E67B58F6B31ED26BCCC991DDCB3D0A5155422C126A0A916AA0524C3F0
          A505263D54048B55029116A61240B538149C24E7548CD90D5E5A6216AA2007AA
          8090D5440486AA20521AA881C86AA02477A0035503916AA05222D440A4893E4A
          62923ABC94C243550290BD03240F6D201A93431C920D48721AA8148B55101244
          B5F87E74C5222DD838D01264E77881F1F757DAF1767CFDD3262C6833321F10E0
          2471C7932CF144A5B332F10962D8921B28361DB59DB243848DEB853ACB70676E
          1FD46DBB6E87232B2B69DD136C826DCF197720B82D14B2ECF1E5CB90B1A0CCFA
          81A86DD308CBC4A0902F6BD43CDE868BC6F52F63F8BE16DD4ED79FB56E1B4E58
          7C546398309A2519DF54B8CCF2E2E564A22C9360B40351D46578D40F6E8EEEBC
          04FC7D253930F7EFEB2F847652DF531653C6315F3E39449B6C226C5191918F1C
          B8CB959B8F264ACDF46D2C5DC2BEA8DA33CDC0A4F322978AFA9A9B9F8F70F6E9
          B3E1C8DAB710DB7EE276B772DB7471C922E049B9BCAB24D9B1A24298718959A5
          287DA02DAB5057DDF405E3FA94E5FEAE78171B6E9F37373E3C3316DFF748B1A4
          C9DBE493262EF72A1EEB11A0CB9A1C89B5E0B0D0921B6A404EA2429DE42F6CCD
          DC7F10492F89B2FC3EDB3EE10C9871ACD367CA703E97B995A748241A32DE7226
          7C491557BAD43F5AA8A6AF2E204F0C2993878B3C69B4785D311F711ABEB4CA22
          1F55B6E25BB9085BFF00D8E660EBFE60FE5EAB7EAB5C5DDEFB431E2DC73DAFC7
          BB36E50E165636366FDB333E8125DC99205871B23748E097171A74EFFEA0C8E3
          371C168A278D4C82EFC1F4CF74A783D4EB078C21CAC4C37C4DAB70C9DC731F39
          17674184B9518DAF2BE8B2DE47972A3C5D31CEC8A34CECCDAC15046AD2777D03
          B1EA5BC9F11ED50F8666F13248F93B3C5B7BEEC92C28449262AE39C905125EE8
          EA68F92BE9E3CED57BB4933547BB69E7F78FEA7ED7B248D06F5B4EE1B664AC98
          D18872A5DA625233132DE37EFCEE1F4C8BFF00E36653AE556D5A40075543CDE8
          6ABC79E0CF47B06EF89BE6D987B9619B63E6EAEEFF008B8D916D12B447F89873
          6540DC50FB92B790D9AE05D6D2A4C2F8F6DA0F218BFD65F05CF3BC52BBE3C71A
          472CD93F55B465411472666360EB99F0B3F2BBA559335198C9A7D80E45CADAA3
          BC8D5F8AFA9B5378D3C3D0E46124CF92B8FB9264CBB767263BCD8F911E2B63A1
          78BB9324A566932D63C62631DFB5847ABBC87BCAEF227DB3EA6447FD57F0ACB9
          BB4E22A4DAF79FB6FD28391B577ABF76585B1FBCC4FAFF00AD1A7EA575DA0361
          761A97DA2BBFE83F68FA9BD0EF6F91BDE46D58BB4E7E4AE1E4C38797B8A1C04C
          68E59F1E1C9E5365C590EB1C59485B4424F30A18D53CBAF033581426DF13162F
          EA56D3F47819D97B4EEF8787BA62C39DB74AF0E26434F06464E1E2A14870F2B2
          A7D5AB7385B418F515BE905BD933DFF42FDA7A9B7B46FBB56F51E64BB648F343
          8593F46F394291CADF4F0E48920627F890B47949A24B59FDE5BA1566D6993718
          65C4E913CCB854D68603B1B5033A017A9291345A0A4764A96523A29A92898348
          7271CCC0C1CD8BBACB81278FB03A836F4792AE97B55CA702B555B8A30323FA75
          E1B998B209A0BFE98E4E1FEF0F5D55F3B22E8CE77E1D19C57FA65E1F06E67CA6
          F3178FF7462ABFEC327442F654F53576EF08787B0183C388AF20E524B790FE1A
          B80FC056193CAC96E2CD69E3D2BC11B37AE7360BD100226880205A881486AB1B
          D380241EE2940E47AA809116A00816A702939B1BD51273E24DA9923EE9AD7BD2
          90DA7326DC3B69C121AA88090D5400F55031EAA063D5440488B0A0245AA82645
          7A0248DEDC6980C1E94005001400EF48077140486AA02445A8090068003C45A8
          010B0E54C0CDCFF0EED19D9FF709865C59A608F15E6C3DC370C02F0C4F2491A3
          AE1E463ABE879E420B0BFB46B3B634DC9B533DAAA115327C09E13CA79DB27127
          9A3C97CC965C57DC3716C6126E4934796E98C723B88DA55CB985D105B59D3635
          3D9457BAB1661F0AEC31636E98ED0E464C7BD630C1DCCE66767E63CB8CAB3288
          7BDC99E69235032A5FE5B2F16BF3A6B1207E45B4F42D6E9B36D5BB1CB6CEC732
          499CB889912C736441211B7E4BE5E26892092378CC33CACEAC84379490050F12
          62AE7B229CFE0CF0E4F91939324396B91979A3739668F72DCA27196B03E30962
          68F254C3FC095A2D31E95D1A56D6550176916BC8B7A1D717C21E1BC5DBB3F6E8
          B0CFD26EB8CF85B92C9919533CF04B2E4CD22C92CB2BCA4B4B9F3B97D5AAEDCF
          82D858909E7B1A9F4F8BF5F91B888C0CDCA8E28279AED768B1DE69225D24E91A
          5B2A53702E6FC6F616A5453243C8DA8296EBE1FDAB759F17232C642E4E1ACD1E
          3E46266E6E0C8B1E418CCA85F0E6C7665630466CD7F7695A89954CAEAA108787
          76519B066982479A0EE5B4C99596F14B2632AAC33E4C2F31872678C469A679D1
          E40510EABA2D976915DFB1520F06F8731F0930E08B2E248E69F25274DCB725CA
          57CB60F900658C9FA911CD2289248FBCD0CE35952DC68ECA0F716F4347276DDB
          727699B67971631B54F8AF82F831030C4315E23098504450A2F76748D045BB2A
          F628832591EEDDCCA383E15D8707705DCA187225DC6378E48F2F2F3B3F365568
          A2C8823D2D953CC4058F3E701797B64DAE0112B12347E459A35CE4486459198B
          BA90416E3CBD357060ECE64C28FC21E1D4CB8F3248B2B2F261D1DCC99BB96E59
          BDDF75930662E819593305FF00D461C2E6C3DAD201BADC547651AFBAB7A1A38B
          81B7E2EE2371C6C711660FA8B48AF2691F5AF0CB95A62D7DD2F7D262C723E951
          77D4DEF3B967DA44FB8B4419BB77843C3BB64F14DB7439587DCFD3E8820DCB72
          8F1DBE8E08B1A0EF31D724412E9871E346D687585F6B571A5D9453F2ACFA1D60
          F0DED18FB8FDC6039B1E59786594AEE9BA08E5931A28E08DE787EABBA99BBA81
          15CC8ADAEDEDEAE3476507BAB7A15303C0FE14C038A60C49DD701228B063C8CF
          DC7263823C7C8832A24863C8C99523559B0A16B2817D014FB3714766A0FCABFA
          1B29063473654D1C6166CD9864E649766324CB0458C1CEA240FE163C6BECD870
          BF324D695AA5C0C6F91D929E44EDC6A8CE0281935A4523A8A0A1D2025D691474
          5E5523262818E800A002800A00280150040F3A620A00050C09D2188D02206A90
          881A0447F51FDD4C4744FC6932915E4F7EA919D88D003A000D00C7D940C072A0
          423400A810E801500028010A604872A401D940C28100E7400A801D0341408280
          1792802428290C72A003B68024290C9520034C02818A810BB680153011E54088
          9A0444D3244290053185021500028100A061401FFFD9}
        Stretch = True
      end
      object GroupBox41: TGroupBox
        Left = 8
        Top = 247
        Width = 497
        Height = 57
        Caption = #29256#26435#22768#26126
        TabOrder = 0
        object Label60: TLabel
          Left = 16
          Top = 15
          Width = 468
          Height = 36
          Caption = 
            #26412#35745#31639#26426#31243#24207#21463#20013#21326#20154#27665#20849#21644#22269#30693#35782#20135#26435#19982#29256#26435#20445#25252#65292#22914#26410#32463#25480#26435#32780#25797#33258#22797#21046#25110#20256#25773#26412#31243#13#24207#65288#25110#20854#20013#20219#20309#37096#20998#65289#65292#23558#21463#21040#20005#21385#30340#27665#20107#21450#21009#20107#21046#35009 +
            #65292#24182#22312#27861#24459#35768#21487#30340#33539#22260#20869#21463#21040#26368#22823#13#21487#33021#30340#36215#35785#12290
        end
      end
      object GroupBox45: TGroupBox
        Left = 8
        Top = 98
        Width = 497
        Height = 145
        Caption = #29256#26412#20449#24687
        TabOrder = 1
        object Label63: TLabel
          Left = 8
          Top = 16
          Width = 54
          Height = 12
          Caption = #36719#20214#21517#31216':'
        end
        object Label71: TLabel
          Left = 8
          Top = 36
          Width = 54
          Height = 12
          Caption = #36719#20214#29256#26412':'
        end
        object Label72: TLabel
          Left = 8
          Top = 56
          Width = 54
          Height = 12
          Caption = #26356#26032#26085#26399':'
        end
        object Label73: TLabel
          Left = 8
          Top = 76
          Width = 54
          Height = 12
          Caption = #31243#24207#21046#20316':'
        end
        object Label74: TLabel
          Left = 8
          Top = 96
          Width = 54
          Height = 12
          Caption = #23448' '#26041' '#31449':'
        end
        object Label75: TLabel
          Left = 8
          Top = 116
          Width = 54
          Height = 12
          Caption = #31243' '#24207' '#31449':'
        end
        object EditProductName: TEdit
          Left = 64
          Top = 16
          Width = 241
          Height = 20
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
          Text = 'EditProductName'
        end
        object EditVersion: TEdit
          Left = 64
          Top = 36
          Width = 201
          Height = 20
          BorderStyle = bsNone
          Color = clBtnFace
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 1
          Text = 'EditVersion'
        end
        object EditUpDateTime: TEdit
          Left = 64
          Top = 56
          Width = 217
          Height = 20
          BorderStyle = bsNone
          Color = clBtnFace
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 2
          Text = 'EditUpDateTime'
        end
        object EditProgram: TEdit
          Left = 64
          Top = 76
          Width = 217
          Height = 20
          BorderStyle = bsNone
          Color = clBtnFace
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 3
          Text = 'EditProgram'
        end
        object EditWebSite: TEdit
          Left = 64
          Top = 96
          Width = 233
          Height = 20
          BorderStyle = bsNone
          Color = clBtnFace
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 4
          Text = 'EditWebSite'
        end
        object EditBbsSite: TEdit
          Left = 64
          Top = 116
          Width = 313
          Height = 20
          BorderStyle = bsNone
          Color = clBtnFace
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 5
          Text = 'EditBbsSite'
        end
      end
    end
    object TabSheetDebug: TTabSheet
      Caption = #27979#35797
      ImageIndex = 6
      object GroupBox29: TGroupBox
        Left = 8
        Top = 0
        Width = 497
        Height = 329
        Caption = #36827#31243#20449#24687
        TabOrder = 0
        object GroupBox30: TGroupBox
          Left = 8
          Top = 16
          Width = 265
          Height = 113
          Caption = #28216#25103#24341#25806
          TabOrder = 0
          object Label45: TLabel
            Left = 8
            Top = 20
            Width = 30
            Height = 12
            Caption = #22320#22336':'
          end
          object Label46: TLabel
            Left = 8
            Top = 44
            Width = 42
            Height = 12
            Caption = #26816#26597#30721':'
          end
          object Label58: TLabel
            Left = 8
            Top = 68
            Width = 42
            Height = 12
            Caption = #26816#26597#20018':'
          end
          object EditM2CheckCodeAddr: TEdit
            Left = 56
            Top = 16
            Width = 97
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 0
          end
          object EditM2CheckCode: TEdit
            Left = 56
            Top = 40
            Width = 97
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 1
          end
          object ButtonM2Suspend: TButton
            Left = 200
            Top = 32
            Width = 57
            Height = 25
            Caption = #26242#20572#31243#24207
            TabOrder = 2
            Visible = False
            OnClick = ButtonM2SuspendClick
          end
          object EditM2CheckStr: TEdit
            Left = 56
            Top = 64
            Width = 201
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 3
          end
        end
        object GroupBox31: TGroupBox
          Left = 8
          Top = 136
          Width = 265
          Height = 105
          Caption = #25968#25454#24211
          TabOrder = 1
          object Label47: TLabel
            Left = 8
            Top = 20
            Width = 30
            Height = 12
            Caption = #22320#22336':'
          end
          object Label48: TLabel
            Left = 8
            Top = 44
            Width = 42
            Height = 12
            Caption = #26816#26597#30721':'
          end
          object Label57: TLabel
            Left = 8
            Top = 68
            Width = 36
            Height = 12
            Caption = #26816#26597#20018
          end
          object EditDBCheckCodeAddr: TEdit
            Left = 56
            Top = 16
            Width = 97
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 0
          end
          object EditDBCheckCode: TEdit
            Left = 56
            Top = 40
            Width = 97
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 1
          end
          object Button3: TButton
            Left = 200
            Top = 32
            Width = 57
            Height = 25
            Caption = #26242#20572#31243#24207
            TabOrder = 2
            Visible = False
            OnClick = ButtonM2SuspendClick
          end
          object EditDBCheckStr: TEdit
            Left = 56
            Top = 64
            Width = 201
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 3
          end
        end
      end
    end
  end
  object TimerStartGame: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerStartGameTimer
    Left = 439
    Top = 24
  end
  object TimerStopGame: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerStopGameTimer
    Left = 471
    Top = 24
  end
  object TimerCheckRun: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerCheckRunTimer
    Left = 503
    Top = 24
  end
  object TimerCheckDebug: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerCheckDebugTimer
    Left = 408
    Top = 24
  end
  object TimerBak: TTimer
    Enabled = False
    OnTimer = TimerBakTimer
    Left = 448
  end
  object VCLZip1: TVCLZip
    ThisReleaseLevel = 'Release'
    MultiZipInfo.BlockSize = 1457600
    AddDirEntriesOnRecurse = True
    Left = 416
  end
  object ClearServerOpenDialog: TOpenDialog
    Left = 377
    Top = 23
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
    Left = 380
    Top = 1
  end
  object ADOConnection1: TADOConnection
    ConnectionTimeout = 4
    LoginPrompt = False
    Left = 56
    Top = 267
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 24
    Top = 267
  end
end
