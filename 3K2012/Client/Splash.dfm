object SplashForm: TSplashForm
  Left = 622
  Top = 543
  BorderStyle = bsNone
  ClientHeight = 100
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 550
    Height = 100
    Align = alClient
  end
  object StateLabel: TRzLabel
    Left = 10
    Top = 73
    Width = 84
    Height = 12
    Caption = #35831' '#31245' '#31561'......'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object LabelTips: TRzLabel
    Left = 263
    Top = 30
    Width = 29
    Height = 14
    Caption = 'Tips'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    Transparent = True
    Visible = False
    ShadowColor = clBlack
    ShadowDepth = 1
    TextStyle = tsShadow
  end
  object ProgressBar1: TProgressBar
    Left = 11
    Top = 52
    Width = 530
    Height = 14
    Enabled = False
    TabOrder = 0
  end
  object Timer2: TTimer
    Interval = 1
    OnTimer = Timer2Timer
    Top = 2
  end
  object Timer3: TTimer
    Enabled = False
    OnTimer = Timer3Timer
    Left = 30
    Top = 2
  end
  object SendMailTimer: TTimer
    Enabled = False
    OnTimer = SendMailTimerTimer
    Left = 61
    Top = 1
  end
end
