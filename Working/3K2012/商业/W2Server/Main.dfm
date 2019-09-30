object FrmMain: TFrmMain
  Left = 462
  Top = 319
  Caption = #25968#25454#26381#21153#22120'0718'
  ClientHeight = 267
  ClientWidth = 374
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object RzSplitter: TRzSplitter
    Left = 0
    Top = 0
    Width = 374
    Height = 267
    Orientation = orVertical
    Position = 125
    Percent = 47
    HotSpotSizePercent = 100
    SplitterWidth = 2
    Align = alClient
    BorderShadow = clBtnFace
    Color = clMoneyGreen
    TabOrder = 0
    BarSize = (
      0
      125
      374
      127)
    UpperLeftControls = (
      MemoLog)
    LowerRightControls = (
      RzSplitter1)
    object MemoLog: TRzMemo
      Left = 0
      Top = 0
      Width = 374
      Height = 125
      Align = alClient
      Color = clBlack
      Font.Charset = GB2312_CHARSET
      Font.Color = clLime
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDblClick = MemoLogDblClick
      FrameVisible = True
    end
    object RzSplitter1: TRzSplitter
      Left = 0
      Top = 0
      Width = 374
      Height = 140
      Orientation = orVertical
      Position = 34
      Percent = 25
      SplitterWidth = 7
      Align = alClient
      TabOrder = 0
      BarSize = (
        0
        34
        374
        41)
      UpperLeftControls = (
        Panel)
      LowerRightControls = (
        GridGate)
      object Panel: TRzPanel
        Left = 0
        Top = 0
        Width = 374
        Height = 34
        Align = alClient
        BorderOuter = fsNone
        TabOrder = 0
        object Label1: TLabel
          Left = 320
          Top = 22
          Width = 6
          Height = 12
        end
        object LbRunTime: TLabel
          Left = 200
          Top = 22
          Width = 6
          Height = 12
        end
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 36
          Height = 12
          Caption = 'Label2'
        end
      end
      object GridGate: TRzStringGrid
        Left = 0
        Top = 0
        Width = 374
        Height = 99
        Align = alClient
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        ColWidths = (
          45
          107
          70
          74
          70)
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 176
    Top = 16
    object T1: TMenuItem
      Caption = #25511#21046'(&C)'
      object MENU_CONTROL_START: TMenuItem
        Caption = #21551#21160#26381#21153'(&S)'
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = #20572#27490#26381#21153'(&T)'
        OnClick = MENU_CONTROL_STOPClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N4: TMenuItem
        Caption = #36864#20986
        OnClick = N4Click
      end
    end
    object MENU_OPTION: TMenuItem
      Caption = #36873#39033'(&O)'
      object N8: TMenuItem
        Caption = #22522#26412#35774#32622
        OnClick = N8Click
      end
      object N7: TMenuItem
        Caption = #20844#21578#35774#32622
      end
    end
    object N1: TMenuItem
      Caption = #24037#20855
      object IP1: TMenuItem
        Caption = #33719#21462'IP'#20540
      end
      object N2: TMenuItem
        Caption = #27979#35797
        OnClick = N2Click
      end
    end
    object N6: TMenuItem
      Caption = #24110#21161'(&H)'
      object A1: TMenuItem
        Caption = #20851#20110'(&A)'
      end
    end
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = StartTimerTimer
    Left = 32
    Top = 16
  end
  object ServerSocket: TServerSocket
    Active = False
    Address = '0.0.0.0'
    Port = 123
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 96
    Top = 16
  end
  object DecodeTime: TTimer
    Enabled = False
    Interval = 1
    OnTimer = DecodeTimeTimer
    Top = 16
  end
  object Timer: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = TimerTimer
    Left = 64
    Top = 16
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 128
    Top = 16
  end
end
