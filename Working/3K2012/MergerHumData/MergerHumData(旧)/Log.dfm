object FrmLog: TFrmLog
  Left = 190
  Top = 214
  Width = 580
  Height = 326
  BorderIcons = [biSystemMenu]
  Caption = #37325#21517#21464#26356#35760#24405'('#20174#24211')'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object RzPanel1: TRzPanel
    Left = 0
    Top = 0
    Width = 290
    Height = 292
    Align = alClient
    TabOrder = 0
    object RzGroupBox1: TRzGroupBox
      Left = 2
      Top = 2
      Width = 286
      Height = 288
      Align = alClient
      Caption = 'ID'#26356#25913#26085#24535
      TabOrder = 0
      Transparent = True
      object Memo1: TRzMemo
        Left = 1
        Top = 13
        Width = 284
        Height = 274
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object RzPanel2: TRzPanel
    Left = 290
    Top = 0
    Width = 282
    Height = 292
    Align = alRight
    TabOrder = 1
    object RzGroupBox2: TRzGroupBox
      Left = 2
      Top = 2
      Width = 278
      Height = 288
      Align = alClient
      Caption = #21517#23383#26356#25913#26085#24535
      TabOrder = 0
      Transparent = True
      object Memo2: TRzMemo
        Left = 1
        Top = 13
        Width = 276
        Height = 274
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
