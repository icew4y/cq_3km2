object frmViewOnlineHuman: TfrmViewOnlineHuman
  Left = 205
  Top = 245
  Caption = #22312#32447#20154#29289
  ClientHeight = 418
  ClientWidth = 972
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object PanelStatus: TPanel
    Left = 0
    Top = 0
    Width = 972
    Height = 329
    Align = alClient
    Caption = #27491#22312#35835#21462#25968#25454'...'
    ParentBackground = False
    TabOrder = 0
    object GridHuman: TStringGrid
      Left = 1
      Top = 1
      Width = 970
      Height = 327
      Align = alClient
      ColCount = 21
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 25
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
      PopupMenu = PopupMenu
      TabOrder = 0
      OnDblClick = GridHumanDblClick
      ColWidths = (
        33
        78
        29
        31
        39
        53
        37
        56
        89
        98
        168
        53
        66
        57
        64
        51
        158
        61
        39
        42
        64)
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 329
    Width = 972
    Height = 89
    Align = alBottom
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 92
      Top = 40
      Width = 30
      Height = 12
      Caption = #25490#24207':'
    end
    object ButtonRefGrid: TButton
      Left = 8
      Top = 32
      Width = 73
      Height = 25
      Caption = #21047#26032'(&R)'
      TabOrder = 0
      OnClick = ButtonRefGridClick
    end
    object ComboBoxSort: TComboBox
      Left = 126
      Top = 37
      Width = 116
      Height = 20
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 12
      TabOrder = 1
      OnClick = ComboBoxSortClick
      Items.Strings = (
        #21517#31216
        #24615#21035
        #32844#19994
        #31561#32423
        #22320#22270
        #65321#65328
        #26435#38480
        #25152#22312#22320#21306
        #38750#25346#26426
        #20803#23453
        #38750#20551#20154)
    end
    object EditSearchName: TEdit
      Left = 251
      Top = 37
      Width = 129
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      TabOrder = 2
    end
    object ButtonSearch: TButton
      Left = 387
      Top = 34
      Width = 73
      Height = 25
      Caption = #25628#32034'(&S)'
      TabOrder = 3
      OnClick = ButtonSearchClick
    end
    object ButtonView: TButton
      Left = 463
      Top = 34
      Width = 74
      Height = 25
      Caption = #20154#29289#20449#24687'(&H)'
      TabOrder = 4
      OnClick = ButtonViewClick
    end
    object GroupBox1: TGroupBox
      Left = 576
      Top = 6
      Width = 393
      Height = 80
      Caption = #36386#20154#36873#39033
      TabOrder = 5
      object Label2: TLabel
        Left = 120
        Top = 24
        Width = 126
        Height = 12
        Caption = #31561#32423'>=           <=  '
      end
      object EditMinLevel: TSpinEdit
        Left = 162
        Top = 20
        Width = 56
        Height = 21
        Increment = 10
        MaxValue = 2000
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object EditMaxLevel: TSpinEdit
        Left = 243
        Top = 19
        Width = 61
        Height = 21
        Increment = 10
        MaxValue = 65535
        MinValue = 0
        TabOrder = 1
        Value = 65535
      end
      object CheckBoxSendOnlineCount: TCheckBox
        Left = 120
        Top = 51
        Width = 44
        Height = 17
        Hint = #22914#27492#36873#39033#34987#36873#20013','#21017#21482#35201#20154#29289#21517#31216#24102#26377#25351#23450#25991#23383#37117#23558#34987#36386#38500#19979#32447#12290#21542#21017#21482#36386#38500#25351#23450#25991#23383#30340#20154#29289
        Caption = #21253#21547
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object Edit1: TEdit
        Left = 164
        Top = 49
        Width = 141
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 3
      end
      object Button1: TButton
        Left = 27
        Top = 18
        Width = 85
        Height = 25
        Caption = #36386#38500#33073#26426#20154#29289
        TabOrder = 4
        OnClick = Button1Click
      end
      object ButtonKick: TButton
        Left = 28
        Top = 47
        Width = 85
        Height = 25
        Caption = #36386#38500#25351#23450#20154#29289
        TabOrder = 5
        OnClick = ButtonKickClick
      end
    end
    object CheckBoxShowHero: TCheckBox
      Left = 126
      Top = 9
      Width = 97
      Height = 17
      Caption = #26174#31034#33521#38596
      TabOrder = 6
      OnClick = CheckBoxShowHeroClick
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 280
    Top = 392
  end
  object PopupMenu: TPopupMenu
    Left = 376
    Top = 152
    object T3: TMenuItem
      Caption = #36386#38500#26426#22120#20154
      OnClick = T3Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #21551#21160#26426#22120#20154
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #20572#27490#26426#22120#20154
      OnClick = N3Click
    end
  end
end
