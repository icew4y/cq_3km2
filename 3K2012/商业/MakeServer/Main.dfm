object FrmMain: TFrmMain
  Left = 493
  Top = 226
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MakeServer1114+'
  ClientHeight = 162
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 81
    Width = 351
    Height = 31
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 26
      Top = 1
      Width = 54
      Height = 12
      Alignment = taCenter
      Caption = #26410#36830#25509'!!!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 7
      Top = 1
      Width = 6
      Height = 12
      Caption = '\'
    end
    object LbTransCount: TLabel
      Left = 140
      Top = 17
      Width = 42
      Height = 12
      Caption = #29983#25104'G:0'
    end
    object Label2: TLabel
      Left = 43
      Top = 17
      Width = 42
      Height = 12
      Alignment = taRightJustify
      Caption = #29983#25104'L:0'
    end
    object Label4: TLabel
      Left = 103
      Top = 1
      Width = 84
      Height = 12
      Caption = #27491#22312#21516#26102#29983#25104':0'
    end
    object Label5: TLabel
      Left = 236
      Top = 16
      Width = 42
      Height = 12
      Caption = #29983#25104'M:0'
    end
  end
  object MemoLog: TMemo
    Left = 0
    Top = 0
    Width = 351
    Height = 81
    Align = alTop
    Color = clBlack
    Font.Charset = GB2312_CHARSET
    Font.Color = clLime
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
    ParentFont = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 112
    Width = 351
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    Color = clGreen
    ParentBackground = False
    TabOrder = 2
    object ListView: TListView
      Left = 0
      Top = -1
      Width = 366
      Height = 50
      Columns = <
        item
          Caption = #27169#22359#21517#31216
          Width = 80
        end
        item
          Caption = #36830#25509#22320#22336
          Width = 230
        end
        item
          Caption = #29366#24577
          Width = 40
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      SortType = stBoth
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object DecodeTimer: TTimer
    Interval = 1
    OnTimer = DecodeTimerTimer
    Left = 144
    Top = 16
  end
  object ServerSocket: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientConnect = ServerSocketClientConnect
    OnClientDisconnect = ServerSocketClientDisconnect
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 80
    Top = 16
  end
  object MainMenu: TMainMenu
    Left = 16
    Top = 16
    object T2: TMenuItem
      Caption = #25511#21046'(&C)'
      object MENU_CONTROL_START: TMenuItem
        Caption = #21551#21160#26381#21153'(&S)'
        OnClick = MENU_CONTROL_STARTClick
      end
      object MENU_CONTROL_STOP: TMenuItem
        Caption = #20572#27490#26381#21153'(&T)'
        OnClick = MENU_CONTROL_STOPClick
      end
      object N10: TMenuItem
        Caption = #28165#38500#26085#24535
        OnClick = N10Click
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
        Caption = #22522#26412#35774#32622'(&G)'
        OnClick = N8Click
      end
      object Shell1: TMenuItem
        Caption = #30331#38470#22120#20351#29992'Shell'
        OnClick = Shell1Click
      end
      object Sign: TMenuItem
        Caption = #30331#38470#22120#21152#35777#20070
        OnClick = SignClick
      end
    end
    object N1: TMenuItem
      Caption = #27979#35797
      object N2: TMenuItem
        Caption = #29983#25104'L'
        OnClick = N2Click
      end
      object N5: TMenuItem
        Caption = #29983#25104'G'
        OnClick = N5Click
      end
      object M1: TMenuItem
        Caption = #29983#25104'M'
        OnClick = M1Click
      end
      object M11: TMenuItem
        Caption = #29983#25104'M1'
        Visible = False
        OnClick = M11Click
      end
    end
    object N6: TMenuItem
      Caption = #24110#21161'(&H)'
      object A1: TMenuItem
        Caption = #20851#20110'(&A)'
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 16
    Top = 48
  end
  object Timer2: TTimer
    Interval = 300
    OnTimer = Timer2Timer
    Left = 112
    Top = 16
  end
  object RSA1: TRSA
    CommonalityKey = '45127'
    CommonalityMode = '697585576183253336471979032351'
    PrivateKey = '404713097398326019320821216863'
    Server = True
    Left = 48
    Top = 16
  end
end
