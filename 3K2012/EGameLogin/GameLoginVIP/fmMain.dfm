object FrmMain2: TFrmMain2
  Left = 381
  Top = 200
  BorderStyle = bsNone
  Caption = 'day2011'
  ClientHeight = 504
  ClientWidth = 704
  Color = clBtnFace
  TransparentColorValue = clFuchsia
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object MainImage: TImage
    Left = 0
    Top = 0
    Width = 704
    Height = 504
    Align = alClient
    OnMouseDown = MainImageMouseDown
    ExplicitLeft = -72
    ExplicitTop = 40
  end
  object RzLabelStatus: TRzLabel
    Left = 92
    Top = 423
    Width = 157
    Height = 12
    AutoSize = False
    Caption = #35831#36873#25321#26381#21153#22120#30331#38470'...'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = 104958
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    BorderHighlight = clBtnFace
    ShadowColor = clBlack
  end
  object RzProgressBarCurDownload: TRzProgressBar
    Left = 62
    Top = 409
    Width = 163
    Height = 8
    BackColor = clNavy
    BarColor = 4227072
    BarStyle = bsLED
    BorderColor = clNavy
    BorderOuter = fsFlat
    BorderWidth = 0
    FlatColor = 955311
    FlatColorAdjustment = 10
    Font.Charset = ANSI_CHARSET
    Font.Color = 4227072
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    InteriorOffset = 0
    ParentFont = False
    ParentShowHint = False
    PartsComplete = 0
    Percent = 45
    ShowHint = True
    ShowPercent = False
    TotalParts = 0
    Visible = False
  end
  object RzProgressBarAll: TRzProgressBar
    Left = 62
    Top = 428
    Width = 163
    Height = 8
    BackColor = clNavy
    BarColor = 8388863
    BarStyle = bsLED
    BorderColor = clNavy
    BorderOuter = fsFlat
    BorderWidth = 0
    FlatColor = 955311
    FlatColorAdjustment = 10
    Font.Charset = ANSI_CHARSET
    Font.Color = 8388863
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    InteriorOffset = 0
    ParentFont = False
    ParentShowHint = False
    PartsComplete = 0
    Percent = 45
    ShowHint = True
    ShowPercent = False
    TotalParts = 0
    Visible = False
  end
  object RzComboBox1: TRzComboBox
    Left = 187
    Top = 383
    Width = 67
    Height = 20
    Style = csDropDownList
    Color = clBlack
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = 104958
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    FrameColor = 9799283
    FrameVisible = True
    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
    ItemHeight = 12
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    Text = #33521#38596#29256
    Items.Strings = (
      #33521#38596#29256)
    ItemIndex = 0
  end
  object RzCheckBox1: TRzCheckBox
    Left = 36
    Top = 384
    Width = 115
    Height = 17
    FrameColor = 8409372
    HighlightColor = 2203937
    HotTrack = True
    HotTrackColor = clSkyBlue
    State = cbUnchecked
    TabOrder = 2
    Transparent = True
  end
  object MinimizeBtn: TRzBmpButton
    Left = 652
    Top = 11
    Width = 16
    Height = 16
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 3
    OnClick = MinimizeBtnClick
  end
  object CloseBtn: TRzBmpButton
    Left = 670
    Top = 11
    Width = 16
    Height = 16
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 4
    OnClick = CloseBtnClick
  end
  object StartButton: TRzBmpButton
    Left = 269
    Top = 412
    Width = 95
    Height = 29
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 5
    OnClick = StartButtonClick
  end
  object ButtonHomePage: TRzBmpButton
    Left = 370
    Top = 412
    Width = 95
    Height = 29
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 6
    OnClick = ButtonHomePageClick
  end
  object RzBmpButton2: TRzBmpButton
    Left = 471
    Top = 412
    Width = 95
    Height = 29
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 7
    OnClick = RzBmpButton2Click
  end
  object RzBmpButtonCancelPatch: TRzBmpButton
    Left = 572
    Top = 412
    Width = 95
    Height = 29
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 8
    OnClick = RzBmpButtonCancelPatchClick
  end
  object ImageButtonClose: TRzBmpButton
    Left = 574
    Top = 447
    Width = 95
    Height = 29
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 9
    OnClick = ImageButtonCloseClick
  end
  object ButtonGetBackPassword: TRzBmpButton
    Left = 471
    Top = 447
    Width = 95
    Height = 29
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 10
    OnClick = ButtonGetBackPasswordClick
  end
  object ButtonChgPassword: TRzBmpButton
    Left = 369
    Top = 447
    Width = 95
    Height = 29
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 11
    OnClick = ButtonChgPasswordClick
  end
  object ButtonNewAccount: TRzBmpButton
    Left = 268
    Top = 447
    Width = 95
    Height = 29
    Cursor = crHandPoint
    Bitmaps.TransparentColor = clBlack
    Color = clBtnFace
    TabOrder = 12
    OnClick = ButtonNewAccountClick
  end
  object ProgressBarCurDownload: TImageProgressbar
    Left = 94
    Top = 442
    Width = 0
    Height = 0
    Max = 100
    Min = 0
    position = 40
    Step = 0
  end
  object ProgressBarAll: TImageProgressbar
    Left = 94
    Top = 458
    Width = 0
    Height = 0
    Max = 100
    Min = 0
    position = 40
    Step = 0
  end
  object TreeView1: TTreeView
    Left = 44
    Top = 98
    Width = 198
    Height = 267
    AutoExpand = True
    BiDiMode = bdLeftToRight
    Color = clBlack
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = 4242417
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    Indent = 19
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    OnAdvancedCustomDraw = TreeView1AdvancedCustomDraw
    OnExpanding = TreeView1Expanding
    OnMouseUp = TreeView1MouseUp
  end
  object RzCheckBoxFullScreen: TRzCheckBox
    Left = 36
    Top = 479
    Width = 115
    Height = 17
    AlignmentVertical = avBottom
    Caption = #31383#21475#27169#24335#21551#21160#28216#25103
    FrameColor = 8409372
    Font.Charset = ANSI_CHARSET
    Font.Color = 10851451
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    HighlightColor = 2203937
    HotTrack = True
    HotTrackColor = clSkyBlue
    ParentFont = False
    State = cbUnchecked
    TabOrder = 15
    Transparent = True
  end
  object ComboBox1: TComboBox
    Left = 45
    Top = 174
    Width = 195
    Height = 22
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -14
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
    ItemHeight = 14
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    Visible = False
    OnChange = ComboBox1Change
  end
  object RzPanel1: TRzPanel
    Left = 278
    Top = 99
    Width = 383
    Height = 265
    BorderOuter = fsNone
    TabOrder = 17
    Visible = False
    object WebBrowser1: TWebBrowser
      Left = 0
      Top = 0
      Width = 383
      Height = 265
      Align = alClient
      TabOrder = 0
      ExplicitTop = -1
      ControlData = {
        4C00000096270000631B00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object ClientSocket: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnecting = ClientSocketConnecting
    OnConnect = ClientSocketConnect
    OnDisconnect = ClientSocketDisconnect
    OnRead = ClientSocketRead
    OnError = ClientSocketError
    Left = 400
    Top = 120
  end
  object ClientTimer: TTimer
    Interval = 10
    OnTimer = ClientTimerTimer
    Left = 432
    Top = 120
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    OnWork = IdHTTP1Work
    OnWorkBegin = IdHTTP1WorkBegin
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 144
    Top = 232
  end
  object Timer3: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer3Timer
    Left = 496
    Top = 153
  end
  object IdAntiFreeze: TIdAntiFreeze
    Left = 176
    Top = 232
  end
  object ServerSocket: TServerSocket
    Active = False
    Address = '127.0.0.1'
    Port = 5772
    ServerType = stNonBlocking
    Left = 400
    Top = 153
  end
  object WinHTTP: TWinHTTP
    Agent = 'acHTTP component (AppControls.com)'
    OnDone = WinHTTPDone
    OnHTTPError = WinHTTPHTTPError
    OnHostUnreachable = WinHTTPHostUnreachable
    Left = 1
    Top = 570
  end
  object RSA1: TRSA
    CommonalityKey = '45127'
    CommonalityMode = '697585576183253336471979032351'
    Left = 24
    Top = 24
  end
  object TimerPatchSelf: TTimer
    Enabled = False
    OnTimer = TimerPatchSelfTimer
    Left = 400
    Top = 184
  end
  object TimerReGet: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerReGetTimer
    Left = 432
    Top = 184
  end
end
