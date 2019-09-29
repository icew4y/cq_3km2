object frmMonsterConfig: TfrmMonsterConfig
  Left = 228
  Top = 282
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #24618#29289#35774#32622
  ClientHeight = 320
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 616
    Height = 320
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#21442#25968
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 577
        Height = 257
        TabOrder = 0
        object GroupBox8: TGroupBox
          Left = 8
          Top = 16
          Width = 153
          Height = 73
          Caption = #29190#29289#21697#35774#32622
          TabOrder = 0
          object Label23: TLabel
            Left = 11
            Top = 24
            Width = 42
            Height = 12
            Caption = #37329#24065#22534':'
          end
          object EditMonOneDropGoldCount: TSpinEdit
            Left = 60
            Top = 20
            Width = 77
            Height = 21
            MaxValue = 99999999
            MinValue = 1
            TabOrder = 0
            Value = 10
            OnChange = EditMonOneDropGoldCountChange
          end
          object CheckBoxDropGoldToPlayBag: TCheckBox
            Left = 8
            Top = 48
            Width = 137
            Height = 17
            Caption = #37329#24065#30452#25509#20837#32972#21253
            TabOrder = 1
            OnClick = CheckBoxDropGoldToPlayBagClick
          end
        end
        object ButtonGeneralSave: TButton
          Left = 504
          Top = 221
          Width = 65
          Height = 25
          Caption = #20445#23384'(&S)'
          TabOrder = 1
          OnClick = ButtonGeneralSaveClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #24618#29289#31867#22411
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 608
        Height = 256
        ActivePage = TabSheet3
        MultiLine = True
        TabOrder = 0
        object TabSheet3: TTabSheet
          Caption = #36816#38230#24618'(109)'
          object Label236: TLabel
            Left = 9
            Top = 36
            Width = 150
            Height = 12
            Caption = #36335#32447#25552#31034#38388#38548':          '#31186
          end
          object SpinEditShowHintMon109Tick: TSpinEdit
            Left = 89
            Top = 32
            Width = 56
            Height = 21
            MaxValue = 65535
            MinValue = 120
            TabOrder = 0
            Value = 120
            OnChange = SpinEditShowHintMon109TickChange
          end
          object CheckBoxMon109ShowHint: TCheckBox
            Left = 8
            Top = 10
            Width = 97
            Height = 17
            Caption = #36335#32447#25552#31034#24320#21551
            TabOrder = 1
            OnClick = CheckBoxMon109ShowHintClick
          end
          object CheckBoxMon109AutoTrun: TCheckBox
            Left = 9
            Top = 59
            Width = 112
            Height = 17
            Hint = #21551#29992#21518#65292#26080#27861#21069#36827#26102#65292#33258#21160#36716#21521#31227#21160#12290#31105#27490#21017#26080#27861#21069#36827#26102#65292#24618#21407#22320#19981#21160#12290
            Caption = #26080#27861#21069#36827#26102#36716#21521
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = CheckBoxMon109AutoTrunClick
          end
        end
      end
      object Button1: TButton
        Left = 504
        Top = 261
        Width = 65
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
  end
end
