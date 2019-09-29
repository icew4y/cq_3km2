object frmBrowser: TfrmBrowser
  Left = 697
  Top = 445
  BorderStyle = bsNone
  ClientHeight = 259
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  PixelsPerInch = 96
  TextHeight = 12
  object NavPanel: TPanel
    Left = 0
    Top = 236
    Width = 319
    Height = 23
    Align = alBottom
    BevelOuter = bvNone
    Color = clBlack
    TabOrder = 0
    DesignSize = (
      319
      23)
    object SpeedButton1: TSpeedButton
      Left = 250
      Top = 0
      Width = 69
      Height = 23
      Anchors = [akTop, akRight]
      Caption = #36820#22238
      Flat = True
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object lblProgress: TLabel
      Left = 8
      Top = 8
      Width = 48
      Height = 12
      Caption = #28909#34880#20256#22855
      Font.Charset = GB2312_CHARSET
      Font.Color = clSilver
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 319
    Height = 236
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 383
    ExplicitHeight = 265
    ControlData = {
      4C000000F8200000641800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
