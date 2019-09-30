object LogFrm: TLogFrm
  Left = 275
  Top = 147
  Caption = #26085#24535#20998#26512#31383#21475
  ClientHeight = 446
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 2
      Top = 24
      Width = 59
      Height = 13
      Caption = #24320#22987#26085#26399':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 160
      Top = 24
      Width = 59
      Height = 13
      Caption = #32467#26463#26085#26399':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 324
      Top = 24
      Width = 59
      Height = 13
      Caption = #26597#35810#26465#20214':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object DateTimePicker1: TDateTimePicker
      Left = 61
      Top = 20
      Width = 97
      Height = 21
      Date = 39430.970668217590000000
      Time = 39430.970668217590000000
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ParentFont = False
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 220
      Top = 20
      Width = 101
      Height = 21
      Date = 39430.970668217590000000
      Time = 39430.970668217590000000
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ParentFont = False
      TabOrder = 1
    end
    object ComboBox1: TComboBox
      Left = 376
      Top = 21
      Width = 89
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 13
      ParentFont = False
      TabOrder = 2
      OnClick = ComboBox1Click
      Items.Strings = (
        #20154#29289#21517#31216
        #29289#21697#21517#31216
        #29289#21697'ID'
        #20132#26131#23545#20687
        #25152#26377#35760#24405)
    end
    object ComboBox2: TComboBox
      Left = 472
      Top = 21
      Width = 89
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 13
      ParentFont = False
      TabOrder = 3
      Items.Strings = (
        #20840#37096#21160#20316
        #21462#22238#29289#21697
        #23384#25918#29289#21697
        #28860#21046#33647#21697
        #25345#20037#28040#22833
        #25441#36215#29289#21697
        #21046#36896#29289#21697
        #27585#25481#29289#21697
        #25172#25481#29289#21697
        #20132#26131#29289#21697
        #36141#20080#29289#21697
        #20986#21806#29289#21697
        #20351#29992#29289#21697
        #20154#29289#21319#32423
        #20943#23569#37329#24065
        #22686#21152#37329#24065
        #27515#20129#25481#33853
        #25481#33853#29289#21697
        #31561#32423#35843#25972
        #20154#29289#27515#20129
        #21319#32423#25104#21151
        #21319#32423#22833#36133
        #22478#22561#21462#38065
        #22478#22561#23384#38065
        #21319#32423#21462#22238
        #27494#22120#21319#32423
        #32972#21253#20943#23569
        #25913#21464#22478#20027
        #20803#23453#25913#21464
        #33021#37327#25913#21464
        #21830#38138#36141#20080
        #35013#22791#21319#32423
        #23492#21806#29289#21697
        #23492#21806#36141#20080
        #20010#20154#21830#24215
        #34892#20250#37202#27849
        #25361#25112#29289#21697
        #25366#20154#24418#24618
        'NPC '#37247#37202
        #28216#25103#28857#25913#21464
        #33719#24471#30719#30707
        #24320#21551#23453#31665
        #31929#32451#29289#21697
        #25286#20998#29289#21697
        #21512#24182#29289#21697
        #38203#28860#29289#21697
        #37329#21018#30707#25913#21464
        #28789#31526#25913#21464
        #33635#35465#25913#21464
        #39640#32423#37492#23450
        #25366#21462#23453#29289)
    end
    object Edit1: TEdit
      Left = 565
      Top = 21
      Width = 100
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ParentFont = False
      TabOrder = 4
    end
    object Button1: TButton
      Left = 672
      Top = 20
      Width = 75
      Height = 25
      Caption = #21047'   '#26032
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 65
    Width = 764
    Height = 381
    Align = alClient
    Columns = <
      item
        Caption = #32534#21495
      end
      item
        Caption = #21160#20316
        Width = 60
      end
      item
        Caption = #22320#22270
      end
      item
        Caption = 'X'#22352#26631
        Width = 43
      end
      item
        Caption = 'Y'#22352#26631
        Width = 43
      end
      item
        Caption = #20154#29289#21517#31216
        Width = 85
      end
      item
        Caption = #29289#21697#21517#31216
        Width = 85
      end
      item
        Caption = #29289#21697'ID'
        Width = 70
      end
      item
        Caption = #35760#24405
        Width = 60
      end
      item
        Caption = #20132#26131#23545#20687
        Width = 80
      end
      item
        Caption = #26102#38388
        Width = 114
      end>
    GridLines = True
    MultiSelect = True
    RowSelect = True
    PopupMenu = PopupMenu
    TabOrder = 1
    ViewStyle = vsReport
    OnColumnClick = ListView1ColumnClick
    OnCompare = ListView1Compare
  end
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 280
    Top = 272
  end
  object ADOA: TADOQuery
    CacheSize = 1000
    Connection = ADOConn
    LockType = ltReadOnly
    Parameters = <>
    Left = 320
    Top = 272
  end
  object PopupMenu: TPopupMenu
    Left = 240
    Top = 272
    object POPUPMENU_COPY: TMenuItem
      Caption = #22797#21046'('#20154#29289#21517#31216')(&M)'
      OnClick = POPUPMENU_COPYClick
    end
    object POPUPMENU_SELALL: TMenuItem
      Caption = #22797#21046'('#29289#21697#21517#31216')(&I)'
      OnClick = POPUPMENU_SELALLClick
    end
    object N7: TMenuItem
      Caption = #22797#21046'('#29289#21697'ID)(&N)'
      OnClick = N7Click
    end
    object POPUPMENU_SAVE: TMenuItem
      Caption = #22797#21046'('#20132#26131#23545#35937')(&S)'
      OnClick = POPUPMENU_SAVEClick
    end
    object N1: TMenuItem
      Caption = #22797#21046'('#25972#34892')(&A)'
      OnClick = N1Click
    end
  end
end
