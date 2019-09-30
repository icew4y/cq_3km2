object FrmMain: TFrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #21512#21306#24037#20855'(3K'#24341#25806#19987#29992' '#24515#27861#31995#32479') V20120120503'
  ClientHeight = 465
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object StatusBar1: TStatusBar
    Left = 0
    Top = 446
    Width = 640
    Height = 19
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 61
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 10
      Width = 58
      Height = 13
      AutoSize = False
      Caption = #20445#23384#36335#24452#65306
    end
    object CheckBoxRefId: TCheckBox
      Left = 14
      Top = 34
      Width = 113
      Height = 17
      Hint = #22914#26524#26377#22797#21046#21697#30340#35831#25552#21069#22788#29702#65292#19981#28982#21512#21306#21518#20877#21435#26597#22797#21046#21697#23601#26597#19981#21040#20102
      Caption = #33258#21160#37325#25490#21697#32534#21495
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 2
    end
    object CheckBox2: TCheckBox
      Left = 483
      Top = 43
      Width = 117
      Height = 17
      Caption = #28165#31354#20174#24211#32463#39564#20540
      TabOrder = 5
      Visible = False
    end
    object CheckBox3: TCheckBox
      Left = 483
      Top = 28
      Width = 158
      Height = 17
      Caption = #28165#31354#20174#24211#35282#33394#38468#21152#23646#24615#28857
      TabOrder = 6
      Visible = False
    end
    object Button1: TButton
      Left = 500
      Top = 4
      Width = 90
      Height = 25
      Caption = #25968#25454#35843#25972
      TabOrder = 1
      Visible = False
      OnClick = Button1Click
    end
    object EdtSavePath: TRzButtonEdit
      Left = 80
      Top = 7
      Width = 328
      Height = 20
      TabOrder = 0
      AltBtnWidth = 15
      ButtonWidth = 15
      OnButtonClick = EdtSavePathButtonClick
    end
    object CheckBoxStr: TCheckBox
      Left = 123
      Top = 34
      Width = 116
      Height = 17
      Caption = #21512#24182#26080#38480#20179#24211#25968#25454
      TabOrder = 3
    end
    object CheckBoxSelloff: TCheckBox
      Left = 244
      Top = 34
      Width = 90
      Height = 17
      Caption = #21512#24182#23492#21806#25968#25454
      TabOrder = 4
    end
    object ListBox1: TListBox
      Left = 596
      Top = -8
      Width = 121
      Height = 36
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 12
      TabOrder = 7
      Visible = False
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 61
    Width = 640
    Height = 294
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #25968#25454#21512#24182#35774#32622
      object RzLabel16: TRzLabel
        Left = 7
        Top = 7
        Width = 54
        Height = 12
        Caption = #20027#24211#36335#24452':'
        Transparent = True
      end
      object RzLabel17: TRzLabel
        Left = 327
        Top = 5
        Width = 54
        Height = 12
        Caption = #20174#24211#36335#24452':'
        Transparent = True
      end
      object Label2: TLabel
        Left = 3
        Top = 214
        Width = 624
        Height = 48
        Caption = 
          #35828#26126':'#36873#25321'"'#20027#24211#36335#24452'"'#21518','#22914#26377#23545#24212#30340#25991#20214#25110#30446#24405','#21017#33258#21160#28155#21152#21040#23545#24212#30340#36755#20837#26694#20013','#36335#24452#20013#38656#26377'"GuildBase"'#21450'"Envir"'#30446#24405 +
          #13#10'     '#36873#25321'"'#20174#24211#36335#24452'"'#21518','#22914#26377#23545#24212#30340#25991#20214#25110#30446#24405','#21017#33258#21160#28155#21152#21040#23545#24212#30340#36755#20837#26694#20013','#36335#24452#20013#38656#26377'"GuildBase"'#21450'"Envi' +
          'r"'#30446#24405#13#10#13#10'    '#22914#36873#25321'"'#21512#24182#23492#21806#25968#25454'","'#21512#24182#26080#38480#20179#24211#25968#25454'",'#30446#24405'"Envir"'#19979#38656#35201#26377'"MasterNo","User' +
          'Data","Market_Storage"'
      end
      object GroupBox1: TGroupBox
        Left = 2
        Top = 23
        Width = 315
        Height = 181
        Caption = #20027#24211#35774#23450
        TabOrder = 0
        object RzLabel1: TRzLabel
          Left = 36
          Top = 14
          Width = 36
          Height = 12
          Caption = 'ID.DB:'
          Transparent = True
        end
        object RzLabel2: TRzLabel
          Left = 31
          Top = 35
          Width = 42
          Height = 12
          Caption = 'Hum.DB:'
          Transparent = True
        end
        object RzLabel3: TRzLabel
          Left = 30
          Top = 59
          Width = 42
          Height = 12
          Caption = 'Mir.DB:'
          Transparent = True
        end
        object RzLabel4: TRzLabel
          Left = 12
          Top = 98
          Width = 60
          Height = 12
          Caption = 'GuildBase:'
          Transparent = True
        end
        object RzLabel13: TRzLabel
          Left = 33
          Top = 140
          Width = 36
          Height = 12
          Caption = 'Envir:'
          Transparent = True
        end
        object RzLabel18: TRzLabel
          Left = 7
          Top = 79
          Width = 66
          Height = 12
          Caption = 'HeroMir.DB:'
          Transparent = True
        end
        object RzLabel20: TRzLabel
          Left = 6
          Top = 162
          Width = 66
          Height = 12
          Caption = 'HumHero.DB:'
          Transparent = True
          Visible = False
        end
        object RzLabel10: TRzLabel
          Left = 3
          Top = 120
          Width = 72
          Height = 12
          Caption = 'DivisionDir:'
          Transparent = True
        end
        object EdtMainGuildBase: TRzButtonEdit
          Left = 73
          Top = 95
          Width = 237
          Height = 20
          TabOrder = 3
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtSavePathButtonClick
        end
        object EdtMainID: TRzButtonEdit
          Left = 73
          Top = 11
          Width = 237
          Height = 20
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object EdtMainHum: TRzButtonEdit
          Left = 73
          Top = 32
          Width = 237
          Height = 20
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object EdtMainMir: TRzButtonEdit
          Left = 73
          Top = 53
          Width = 237
          Height = 20
          TabOrder = 2
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object Envir1: TRzButtonEdit
          Left = 73
          Top = 137
          Width = 237
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 4
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtSavePathButtonClick
        end
        object HeroMir1: TRzButtonEdit
          Left = 73
          Top = 74
          Width = 237
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 5
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object HumHero1: TRzButtonEdit
          Left = 73
          Top = 157
          Width = 237
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 6
          Visible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object EditMainDivisionDir: TRzButtonEdit
          Left = 73
          Top = 116
          Width = 237
          Height = 20
          TabOrder = 7
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtSavePathButtonClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 326
        Top = 22
        Width = 303
        Height = 182
        Caption = #20174#24211#35774#23450
        TabOrder = 1
        object RzLabel5: TRzLabel
          Left = 32
          Top = 16
          Width = 36
          Height = 12
          Caption = 'ID.DB:'
          Transparent = True
        end
        object RzLabel6: TRzLabel
          Left = 27
          Top = 37
          Width = 42
          Height = 12
          Caption = 'Hum.DB:'
          Transparent = True
        end
        object RzLabel7: TRzLabel
          Left = 27
          Top = 59
          Width = 42
          Height = 12
          Caption = 'Mir.DB:'
          Transparent = True
        end
        object RzLabel8: TRzLabel
          Left = 9
          Top = 101
          Width = 60
          Height = 12
          Caption = 'GuildBase:'
          Transparent = True
        end
        object RzLabel14: TRzLabel
          Left = 32
          Top = 139
          Width = 36
          Height = 12
          Caption = 'Envir:'
          Transparent = True
        end
        object RzLabel19: TRzLabel
          Left = 2
          Top = 82
          Width = 66
          Height = 12
          Caption = 'HeroMir.DB:'
          Transparent = True
        end
        object RzLabel21: TRzLabel
          Left = 5
          Top = 162
          Width = 66
          Height = 12
          Caption = 'HumHero.DB:'
          Transparent = True
          Visible = False
        end
        object RzLabel12: TRzLabel
          Left = 3
          Top = 120
          Width = 72
          Height = 12
          Caption = 'DivisionDir:'
          Transparent = True
        end
        object EdtSlaveGuildBase: TRzButtonEdit
          Left = 70
          Top = 97
          Width = 227
          Height = 20
          TabOrder = 3
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtSavePathButtonClick
        end
        object EdtSlaveID: TRzButtonEdit
          Left = 70
          Top = 13
          Width = 227
          Height = 20
          TabOrder = 0
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object EdtSlaveHum: TRzButtonEdit
          Left = 70
          Top = 34
          Width = 227
          Height = 20
          TabOrder = 1
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object EdtSlaveMir: TRzButtonEdit
          Left = 70
          Top = 55
          Width = 227
          Height = 20
          TabOrder = 2
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object Envir2: TRzButtonEdit
          Left = 70
          Top = 136
          Width = 228
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 4
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtSavePathButtonClick
        end
        object HumHero2: TRzButtonEdit
          Left = 71
          Top = 157
          Width = 226
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 5
          Visible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object HeroMir2: TRzButtonEdit
          Left = 70
          Top = 76
          Width = 227
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 6
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtMainIDButtonClick
        end
        object EditSlaveDivisionDir: TRzButtonEdit
          Left = 70
          Top = 116
          Width = 227
          Height = 20
          TabOrder = 7
          AltBtnWidth = 15
          ButtonWidth = 15
          OnButtonClick = EdtSavePathButtonClick
        end
      end
      object Data1Edit1: TRzButtonEdit
        Left = 68
        Top = 3
        Width = 249
        Height = 20
        Hint = 
          #36335#24452#24212#24403#21253#21547#26377#20197#19979#25991#20214':ID.DB Hum.DB Mir.DB'#13#10#21253#21547#26377#20197#19979#30446#24405':GuildBase Envir Divisio' +
          'nDir'#13#10
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        AltBtnWidth = 15
        ButtonWidth = 15
        OnButtonClick = Data1Edit1ButtonClick
      end
      object Data2Edit1: TRzButtonEdit
        Left = 382
        Top = 1
        Width = 243
        Height = 20
        Hint = 
          #36335#24452#24212#24403#21253#21547#26377#20197#19979#25991#20214':ID.DB Hum.DB Mir.DB'#13#10#21253#21547#26377#20197#19979#30446#24405':GuildBase Envir Divisio' +
          'nDir'
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        AltBtnWidth = 15
        ButtonWidth = 15
        OnButtonClick = Data2Edit1ButtonClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25991#26412#21512#24182#35774#32622
      ImageIndex = 1
      object RzGroupBox1: TRzGroupBox
        Left = 3
        Top = 3
        Width = 311
        Height = 262
        Caption = #20027#24211#35774#23450
        TabOrder = 0
        object RzLabel9: TRzLabel
          Left = 19
          Top = 24
          Width = 48
          Height = 12
          Caption = #25991#20214#25968#65306
          Transparent = True
        end
        object LMainFileCount: TRzLabel
          Left = 89
          Top = 24
          Width = 93
          Height = 12
          Alignment = taCenter
          AutoSize = False
          Transparent = True
        end
        object CmdMainFilst: TRzButton
          Left = 180
          Top = 18
          Caption = #35835#21462#25991#20214
          TabOrder = 0
          OnClick = CmdMainFilstClick
        end
        object ListViewMain: TRzListView
          Left = 3
          Top = 56
          Width = 302
          Height = 201
          Columns = <
            item
              Caption = 'index'
              Width = 0
            end
            item
              Caption = #25991#20214#21517
              Width = 282
            end>
          GridLines = True
          OwnerData = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          OnData = ListViewMainData
        end
        object RzButton1: TRzButton
          Left = 258
          Top = 18
          Width = 50
          Caption = #28165#31354
          TabOrder = 2
          OnClick = RzButton1Click
        end
      end
      object RzGroupBox2: TRzGroupBox
        Left = 319
        Top = 3
        Width = 310
        Height = 262
        Caption = #20174#24211#35774#23450
        TabOrder = 1
        object RzLabel11: TRzLabel
          Left = 19
          Top = 24
          Width = 48
          Height = 12
          Caption = #25991#20214#25968#65306
          Transparent = True
        end
        object LSlaveFileCount: TRzLabel
          Left = 89
          Top = 24
          Width = 93
          Height = 12
          Alignment = taCenter
          AutoSize = False
          Transparent = True
        end
        object CmdSlaveFile: TRzButton
          Left = 179
          Top = 18
          Caption = #35835#21462#25991#20214
          TabOrder = 0
          OnClick = CmdSlaveFileClick
        end
        object ListViewSlave: TRzListView
          Left = 3
          Top = 56
          Width = 302
          Height = 201
          Columns = <
            item
              Caption = 'index'
              Width = 0
            end
            item
              Caption = #25991#20214#21517
              Width = 282
            end>
          GridLines = True
          OwnerData = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          OnData = ListViewSlaveData
        end
        object RzButton2: TRzButton
          Left = 256
          Top = 18
          Width = 50
          Caption = #28165#31354
          TabOrder = 2
          OnClick = RzButton2Click
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 352
    Width = 640
    Height = 94
    Align = alBottom
    TabOrder = 2
    object LabelCopyright: TRzLabel
      Left = 2
      Top = 76
      Width = 84
      Height = 12
      Caption = 'LabelCopyright'
      Transparent = True
    end
    object URLLabel1: TRzURLLabel
      Left = 204
      Top = 76
      Width = 54
      Height = 12
      Caption = 'URLLabel1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Cmd_Start: TButton
      Left = 401
      Top = 67
      Width = 79
      Height = 25
      Caption = #24320#22987#21512#24182
      TabOrder = 0
      OnClick = Cmd_StartClick
    end
    object Cmd_Log: TButton
      Left = 483
      Top = 67
      Width = 75
      Height = 25
      Caption = #26085'  '#24535
      TabOrder = 1
      OnClick = Cmd_LogClick
    end
    object Cmd_Exit: TButton
      Left = 560
      Top = 67
      Width = 75
      Height = 25
      Caption = #36864'   '#20986
      TabOrder = 2
      OnClick = Cmd_ExitClick
    end
    object Memo1: TRzMemo
      Left = 0
      Top = 1
      Width = 638
      Height = 64
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ScrollBars = ssVertical
      TabOrder = 3
    end
  end
  object OPDlg1: TOpenDialog
    Filter = #20256#22855'2'#25968#25454#24211'(*.DB)|*.DB'
    Left = 424
  end
  object RzSelectFolderDialog1: TRzSelectFolderDialog
    Left = 448
  end
end
