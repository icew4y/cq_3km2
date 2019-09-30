object FrmDBTools: TFrmDBTools
  Left = 211
  Top = 163
  Width = 491
  Height = 308
  BorderIcons = [biSystemMenu]
  Caption = #25968#25454#31649#29702#24037#20855
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 483
    Height = 274
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #25968#25454#24211#20449#24687
      object GroupBox1: TGroupBox
        Left = 8
        Top = 4
        Width = 273
        Height = 233
        Caption = #36134#21495#25968#25454#24211'(ID.DB)'
        TabOrder = 0
        object GridIDDBInfo: TStringGrid
          Left = 8
          Top = 16
          Width = 257
          Height = 201
          ColCount = 2
          DefaultRowHeight = 18
          RowCount = 10
          TabOrder = 0
          ColWidths = (
            64
            181)
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25968#25454#24211#37325#24314
      ImageIndex = 1
      object LabelProcess: TLabel
        Left = 8
        Top = 224
        Width = 62
        Height = 13
        Caption = 'LabelProcess'
      end
      object ButtonStartRebuild: TButton
        Left = 16
        Top = 64
        Width = 75
        Height = 25
        Caption = #24320#22987'(&S)'
        TabOrder = 0
        OnClick = ButtonStartRebuildClick
      end
    end
  end
  object TimerShowInfo: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerShowInfoTimer
    Left = 104
    Top = 248
  end
end
