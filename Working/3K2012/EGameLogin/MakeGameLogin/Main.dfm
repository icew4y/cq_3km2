object MainFrm: TMainFrm
  Left = 236
  Top = 202
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = '3K'#24341#25806#30331#38470#22120#37197#32622#22120'('#21453#22806#25346#29256')'
  ClientHeight = 399
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object RzPageControl1: TRzPageControl
    Left = 8
    Top = 8
    Width = 593
    Height = 381
    ActivePage = TabSheet1
    BackgroundColor = clWindow
    Color = clWindow
    ParentBackgroundColor = False
    ParentColor = False
    TabIndex = 0
    TabOrder = 0
    TabStyle = tsRoundCorners
    Transparent = True
    FixedDimension = 18
    object TabSheet1: TRzTabSheet
      Color = clWindow
      Caption = #29983#25104#30331#38470#22120
      object RzGroupBox1: TRzGroupBox
        Left = 12
        Top = 8
        Width = 567
        Height = 338
        Caption = #30331#38470#22120#37197#32622
        ParentColor = True
        TabOrder = 0
        object RzLabel1: TRzLabel
          Left = 16
          Top = 33
          Width = 72
          Height = 12
          Caption = #30331#38470#22120#21517#31216#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Rotation = roFlat
          ShadowDepth = 0
        end
        object RzLabel2: TRzLabel
          Left = 16
          Top = 106
          Width = 84
          Height = 12
          Caption = #28216#25103#21015#34920#22320#22336#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object RzLabel3: TRzLabel
          Left = 16
          Top = 130
          Width = 84
          Height = 12
          Caption = #26356#26032#21015#34920#22320#22336#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object RzLabel10: TRzLabel
          Left = 16
          Top = 57
          Width = 72
          Height = 12
          Caption = #23458#25143#31471#25991#20214#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object RzLabel11: TRzLabel
          Left = 16
          Top = 81
          Width = 84
          Height = 12
          Caption = #26412#22320#28216#25103#21015#34920#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object RzLabel15: TRzLabel
          Left = 16
          Top = 155
          Width = 96
          Height = 12
          Caption = #21453#22806#25346#21015#34920#22320#22336#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object RzLabel16: TRzLabel
          Left = 16
          Top = 180
          Width = 90
          Height = 12
          Caption = 'E'#31995#32479#28909#28857#22320#22336#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object bsSkinButton1: TbsSkinButton
          Left = 356
          Top = 305
          Width = 89
          Height = 25
          TabOrder = 0
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #29983#25104#30331#38470#22120
          NumGlyphs = 1
          Spacing = 1
          OnClick = bsSkinButton1Click
        end
        object bsSkinButton2: TbsSkinButton
          Left = 464
          Top = 305
          Width = 89
          Height = 25
          TabOrder = 1
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #20445#23384#37197#32622#25991#20214
          NumGlyphs = 1
          Spacing = 1
          OnClick = bsSkinButton2Click
        end
        object LnkEdt: TRzEdit
          Left = 112
          Top = 29
          Width = 441
          Height = 20
          FrameStyle = fsButtonDown
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 2
        end
        object GameListURLEdt: TRzEdit
          Left = 112
          Top = 102
          Width = 441
          Height = 20
          FrameStyle = fsButtonDown
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 4
        end
        object PatchListURLEdt: TRzEdit
          Left = 112
          Top = 126
          Width = 441
          Height = 20
          FrameStyle = fsButtonDown
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 5
        end
        object ClientFileEdt: TRzEdit
          Left = 112
          Top = 53
          Width = 377
          Height = 20
          FrameStyle = fsButtonDown
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 3
        end
        object bsSkinButton4: TbsSkinButton
          Left = 496
          Top = 52
          Width = 57
          Height = 20
          TabOrder = 6
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #38543#26426#21462#21517
          NumGlyphs = 1
          Spacing = 1
          OnClick = bsSkinButton4Click
        end
        object ClientLocalFileEdt: TRzEdit
          Left = 112
          Top = 77
          Width = 377
          Height = 20
          FrameStyle = fsButtonDown
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 7
        end
        object bsSkinButton6: TbsSkinButton
          Left = 496
          Top = 76
          Width = 57
          Height = 20
          TabOrder = 8
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #38543#26426#21462#21517
          NumGlyphs = 1
          Spacing = 1
          OnClick = bsSkinButton6Click
        end
        object GameMonListURLEdt: TRzEdit
          Left = 112
          Top = 151
          Width = 441
          Height = 20
          FrameStyle = fsButtonDown
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 9
        end
        object RzGroupBox7: TRzGroupBox
          Left = 16
          Top = 204
          Width = 537
          Height = 45
          Caption = #20854#20182#35774#32622#36873#39033
          ParentColor = True
          TabOrder = 10
          object bsSkinCheckRadioBoxSdoFilter: TbsSkinCheckRadioBox
            Left = 16
            Top = 16
            Width = 119
            Height = 25
            Hint = #22914#26524#20320#30340'M2'#19978#36873#30340#26159#30427#22823#20869#25346#65292#37027#20040#38656#35201#37197#32622#27492#25991#20214
            TabOrder = 0
            SkinData = bsSkinData1
            SkinDataName = 'checkbox'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            WordWrap = False
            AllowGrayed = False
            State = cbUnchecked
            ImageIndex = 0
            Flat = True
            ShowHint = True
            TabStop = True
            CanFocused = True
            Radio = False
            Checked = False
            GroupIndex = 0
            Caption = #38598#25104#30427#22823#36807#28388#25991#20214
          end
          object bsSkinCheckRadioBoxGameMon: TbsSkinCheckRadioBox
            Left = 143
            Top = 16
            Width = 119
            Height = 25
            TabOrder = 1
            SkinData = bsSkinData1
            SkinDataName = 'checkbox'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            WordWrap = False
            AllowGrayed = False
            State = cbUnchecked
            ImageIndex = 0
            Flat = True
            ShowHint = True
            TabStop = True
            CanFocused = True
            Radio = False
            Checked = False
            GroupIndex = 0
            Caption = #21551#21160#21453#22806#25346#31995#32479
          end
          object bsSkinCheckRadioBoxTzHintFile: TbsSkinCheckRadioBox
            Left = 269
            Top = 16
            Width = 123
            Height = 25
            TabOrder = 2
            SkinData = bsSkinData1
            SkinDataName = 'checkbox'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            WordWrap = False
            AllowGrayed = False
            State = cbUnchecked
            ImageIndex = 0
            Flat = True
            ShowHint = True
            TabStop = True
            CanFocused = True
            Radio = False
            Checked = False
            GroupIndex = 0
            Caption = #38598#25104#22871#35013#25552#31034#25991#20214
          end
          object bsSkinCheckRadioBoxPulsDesc: TbsSkinCheckRadioBox
            Left = 400
            Top = 16
            Width = 123
            Height = 25
            TabOrder = 3
            SkinData = bsSkinData1
            SkinDataName = 'checkbox'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            WordWrap = False
            AllowGrayed = False
            State = cbUnchecked
            ImageIndex = 0
            Flat = True
            ShowHint = True
            TabStop = True
            CanFocused = True
            Radio = False
            Checked = False
            GroupIndex = 0
            Caption = #32463#32476#25552#31034#25991#20214
          end
        end
        object GameESystemEdt: TRzEdit
          Left = 112
          Top = 176
          Width = 441
          Height = 20
          Hint = #22914#19981#38656#35201#27492#31995#32479#35831#30041#31354
          FrameStyle = fsButtonDown
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
        end
        object RzRadioGroupMainImages: TRzRadioGroup
          Left = 16
          Top = 251
          Width = 538
          Height = 43
          Caption = #30028#38754#36873#25321
          Columns = 10
          ItemFrameColor = 8409372
          ItemHotTrack = True
          ItemHighlightColor = 2203937
          ItemHeight = 15
          ItemIndex = 0
          Items.Strings = (
            #20223#24449#36884#30028#38754
            #36855#20320#29256#30028#38754)
          LightTextStyle = True
          StartXPos = 24
          StartYPos = 5
          TabOrder = 12
          Transparent = True
        end
      end
    end
    object TabSheet2: TRzTabSheet
      Color = clWindow
      Caption = #28216#25103#21015#34920#37197#32622
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RzGroupBox2: TRzGroupBox
        Left = 10
        Top = 8
        Width = 575
        Height = 338
        Caption = #26381#21153#22120#21015#34920#35774#32622
        ParentColor = True
        TabOrder = 0
        object RzGroupBox3: TRzGroupBox
          Left = 16
          Top = 32
          Width = 545
          Height = 41
          Caption = #20998#32452#35774#32622
          ParentColor = True
          TabOrder = 0
          object RzLabel4: TRzLabel
            Left = 16
            Top = 17
            Width = 60
            Height = 12
            Caption = #20998#32452#21015#34920#65306
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TextStyle = tsRaised
          end
          object ComboBox1: TbsSkinComboBox
            Left = 87
            Top = 15
            Width = 210
            Height = 20
            TabOrder = 0
            SkinData = bsSkinData1
            SkinDataName = 'combobox'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            UseSkinSize = True
            AlphaBlend = False
            AlphaBlendValue = 0
            AlphaBlendAnimation = False
            ListBoxCaptionMode = False
            ListBoxDefaultFont.Charset = GB2312_CHARSET
            ListBoxDefaultFont.Color = clWindowText
            ListBoxDefaultFont.Height = -12
            ListBoxDefaultFont.Name = #23435#20307
            ListBoxDefaultFont.Style = []
            ListBoxDefaultCaptionFont.Charset = GB2312_CHARSET
            ListBoxDefaultCaptionFont.Color = clWindowText
            ListBoxDefaultCaptionFont.Height = -12
            ListBoxDefaultCaptionFont.Name = #23435#20307
            ListBoxDefaultCaptionFont.Style = []
            ListBoxDefaultItemHeight = 20
            ListBoxCaptionAlignment = taLeftJustify
            ListBoxUseSkinFont = False
            ListBoxUseSkinItemHeight = True
            ListBoxWidth = 0
            HideSelection = True
            AutoComplete = True
            ImageIndex = -1
            CharCase = ecNormal
            DefaultColor = clWindow
            ItemIndex = -1
            DropDownCount = 8
            HorizontalExtent = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            Sorted = False
            Style = bscbFixedStyle
          end
          object AddArrayBtn: TbsSkinButton
            Left = 312
            Top = 14
            Width = 89
            Height = 26
            TabOrder = 1
            SkinData = bsSkinData1
            SkinDataName = 'button'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            ImageIndex = -1
            UseSkinSize = True
            UseSkinFontColor = True
            RepeatMode = False
            RepeatInterval = 100
            AllowAllUp = False
            TabStop = True
            CanFocused = True
            Down = False
            GroupIndex = 0
            Caption = #22686#21152#20998#32452'(&A)'
            NumGlyphs = 1
            Spacing = 1
            OnClick = AddArrayBtnClick
          end
          object DelArrayBtn: TbsSkinButton
            Left = 432
            Top = 14
            Width = 89
            Height = 25
            TabOrder = 2
            SkinData = bsSkinData1
            SkinDataName = 'button'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            ImageIndex = -1
            UseSkinSize = True
            UseSkinFontColor = True
            RepeatMode = False
            RepeatInterval = 100
            AllowAllUp = False
            TabStop = True
            CanFocused = True
            Down = False
            GroupIndex = 0
            Caption = #21024#38500#20998#32452'(&D)'
            NumGlyphs = 1
            Spacing = 1
            OnClick = DelArrayBtnClick
          end
        end
        object RzGroupBox4: TRzGroupBox
          Left = 16
          Top = 96
          Width = 545
          Height = 201
          Caption = #26381#21153#22120#21015#34920
          ParentColor = True
          TabOrder = 1
          object RzPanel1: TRzPanel
            Left = 9
            Top = 15
            Width = 528
            Height = 146
            BorderOuter = fsLowered
            TabOrder = 0
            Transparent = True
            object ListView1: TbsSkinListView
              Left = 2
              Top = 2
              Width = 524
              Height = 142
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              DefaultColor = clWindow
              UseSkinFont = False
              SkinData = bsSkinData1
              SkinDataName = 'listview'
              Align = alClient
              Columns = <
                item
                  Caption = #26381#21153#22120#32452
                  Width = 60
                end
                item
                  Caption = #28216#25103#21517#31216
                  Width = 80
                end
                item
                  Caption = #28216#25103'IP'#22320#22336
                  Width = 100
                end
                item
                  Caption = #31471#21475
                  Width = 45
                end
                item
                  Caption = #20844#21578#22320#22336
                  Width = 100
                end
                item
                  Caption = #32593#31449#20027#39029
                  Width = 100
                end>
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              GridLines = True
              ReadOnly = True
              RowSelect = True
              ParentFont = False
              TabOrder = 0
              ViewStyle = vsReport
              HeaderSkinDataName = 'resizebutton'
            end
          end
          object AddGameList: TbsSkinButton
            Left = 88
            Top = 167
            Width = 75
            Height = 25
            TabOrder = 1
            SkinData = bsSkinData1
            SkinDataName = 'button'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            ImageIndex = -1
            UseSkinSize = True
            UseSkinFontColor = True
            RepeatMode = False
            RepeatInterval = 100
            AllowAllUp = False
            TabStop = True
            CanFocused = True
            Down = False
            GroupIndex = 0
            Caption = #22686#21152'(&A)'
            NumGlyphs = 1
            Spacing = 1
            OnClick = AddGameListClick
          end
          object ChangeGameList: TbsSkinButton
            Left = 232
            Top = 167
            Width = 75
            Height = 25
            TabOrder = 2
            SkinData = bsSkinData1
            SkinDataName = 'button'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            ImageIndex = -1
            UseSkinSize = True
            UseSkinFontColor = True
            RepeatMode = False
            RepeatInterval = 100
            AllowAllUp = False
            TabStop = True
            CanFocused = True
            Down = False
            GroupIndex = 0
            Caption = #20462#25913'(&R)'
            NumGlyphs = 1
            Spacing = 1
            OnClick = ChangeGameListClick
          end
          object DelGameList: TbsSkinButton
            Left = 360
            Top = 167
            Width = 75
            Height = 25
            TabOrder = 3
            SkinData = bsSkinData1
            SkinDataName = 'button'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            ImageIndex = -1
            UseSkinSize = True
            UseSkinFontColor = True
            RepeatMode = False
            RepeatInterval = 100
            AllowAllUp = False
            TabStop = True
            CanFocused = True
            Down = False
            GroupIndex = 0
            Caption = #21024#38500'(&D)'
            NumGlyphs = 1
            Spacing = 1
            OnClick = DelGameListClick
          end
        end
        object bsSkinButton8: TbsSkinButton
          Left = 152
          Top = 303
          Width = 115
          Height = 25
          TabOrder = 2
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #29983#25104#28216#25103#21015#34920#25991#20214
          NumGlyphs = 1
          Spacing = 1
          OnClick = bsSkinButton8Click
        end
        object bsSkinButton9: TbsSkinButton
          Left = 344
          Top = 303
          Width = 121
          Height = 25
          TabOrder = 3
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #20445#23384#37197#32622#20449#24687
          NumGlyphs = 1
          Spacing = 1
          OnClick = bsSkinButton9Click
        end
      end
    end
    object TabSheet3: TRzTabSheet
      Color = clWindow
      Caption = #28216#25103#26356#26032#37197#32622
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RzLabel5: TRzLabel
        Left = 112
        Top = 262
        Width = 96
        Height = 12
        Caption = #23458#25143#31471#23384#25918#30446#24405#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RzLabel6: TRzLabel
        Left = 352
        Top = 262
        Width = 60
        Height = 12
        Caption = #25991#20214#21517#31216#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RzLabel7: TRzLabel
        Left = 112
        Top = 284
        Width = 60
        Height = 12
        Caption = #19979#36733#22320#22336#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RzLabel8: TRzLabel
        Left = 112
        Top = 308
        Width = 66
        Height = 12
        Caption = #25991#20214'MD5'#20540#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object RzLabel9: TRzLabel
        Left = 447
        Top = 308
        Width = 138
        Height = 12
        Caption = #8251#28857'['#25171#24320#25991#20214']'#33719#21462'MD5'#20540
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Memo1: TbsSkinMemo
        Left = 8
        Top = 8
        Width = 577
        Height = 244
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        Lines.Strings = (
          ';'#25991#20214#31867#22411'(0='#26222#36890#25991#20214' 1='#30331#38470#22120' 2=ZIP'#21387#32553#25991#20214')'#9#30446#24405#9#25991#20214#21517#31216#9'MD5'#20540#9#19979#36733#22320#22336)
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clBlack
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        UseSkinFont = False
        UseSkinFontColor = True
        BitMapBG = True
        SkinData = AddGameListFrm.bsSkinData1
        SkinDataName = 'memo'
      end
      object FileTypeRadioGroup: TRzRadioGroup
        Left = 8
        Top = 254
        Width = 97
        Height = 71
        Caption = #25991#20214#31867#22411
        ItemHotTrack = True
        ItemHeight = 15
        ItemIndex = 0
        Items.Strings = (
          #26222#36890#25991#20214
          #30331#38470#22120#25991#20214
          'ZIP'#21387#32553#25991#20214)
        TabOrder = 1
        Transparent = True
      end
      object DirComBox: TbsSkinComboBox
        Left = 207
        Top = 259
        Width = 90
        Height = 20
        TabOrder = 2
        SkinData = bsSkinData1
        SkinDataName = 'combobox'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        UseSkinSize = True
        AlphaBlend = False
        AlphaBlendValue = 0
        AlphaBlendAnimation = False
        ListBoxCaptionMode = False
        ListBoxDefaultFont.Charset = GB2312_CHARSET
        ListBoxDefaultFont.Color = clWindowText
        ListBoxDefaultFont.Height = -12
        ListBoxDefaultFont.Name = #23435#20307
        ListBoxDefaultFont.Style = []
        ListBoxDefaultCaptionFont.Charset = GB2312_CHARSET
        ListBoxDefaultCaptionFont.Color = clWindowText
        ListBoxDefaultCaptionFont.Height = -12
        ListBoxDefaultCaptionFont.Name = #23435#20307
        ListBoxDefaultCaptionFont.Style = []
        ListBoxDefaultItemHeight = 20
        ListBoxCaptionAlignment = taLeftJustify
        ListBoxUseSkinFont = False
        ListBoxUseSkinItemHeight = True
        ListBoxWidth = 0
        HideSelection = True
        AutoComplete = True
        ImageIndex = -1
        CharCase = ecNormal
        DefaultColor = clWindow
        Text = 'Data'
        Items.Strings = (
          'Data'
          'Map'
          'Wav'
          #30331#38470#22120#30446#24405)
        ItemIndex = 0
        DropDownCount = 8
        HorizontalExtent = False
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        Sorted = False
        Style = bscbFixedStyle
      end
      object FileNameEdt: TRzEdit
        Left = 416
        Top = 258
        Width = 169
        Height = 20
        FrameStyle = fsButtonDown
        FrameVisible = True
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 3
      end
      object DownAddressEdt: TRzEdit
        Left = 182
        Top = 281
        Width = 403
        Height = 20
        FrameStyle = fsButtonDown
        FrameVisible = True
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 4
      end
      object Md5Edt: TRzEdit
        Left = 181
        Top = 304
        Width = 260
        Height = 20
        FrameStyle = fsButtonDown
        FrameVisible = True
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ReadOnly = True
        ReadOnlyColor = clWindow
        TabOrder = 5
      end
      object OpenFileBtn: TbsSkinButton
        Left = 83
        Top = 328
        Width = 81
        Height = 25
        TabOrder = 6
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #25171#24320#25991#20214'(&O)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = OpenFileBtnClick
      end
      object SavePatchListBtn: TbsSkinButton
        Left = 189
        Top = 328
        Width = 121
        Height = 25
        TabOrder = 7
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #29983#25104#28216#25103#26356#26032#21015#34920'(&S)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = SavePatchListBtnClick
      end
      object bsSkinButton5: TbsSkinButton
        Left = 8
        Top = 328
        Width = 50
        Height = 25
        TabOrder = 8
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #28155#21152'(&A)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = bsSkinButton5Click
      end
      object LoadPatchListBtn: TbsSkinButton
        Left = 334
        Top = 328
        Width = 121
        Height = 25
        TabOrder = 9
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #35835#21462#28216#25103#26356#26032#25991#20214'(&R)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = LoadPatchListBtnClick
      end
      object SaveTxtBtn: TbsSkinButton
        Left = 480
        Top = 328
        Width = 100
        Height = 25
        TabOrder = 10
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #20445#23384#32534#36753#25991#20214'(&S)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = SaveTxtBtnClick
      end
    end
    object TabSheet6: TRzTabSheet
      Color = clWindow
      Caption = #21453#22806#25346#37197#32622
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object RzGroupBox5: TRzGroupBox
        Left = 8
        Top = 5
        Width = 577
        Height = 346
        Caption = #21453#22806#25346#37197#32622
        ParentColor = True
        TabOrder = 0
        object RzLabel14: TRzLabel
          Left = 330
          Top = 11
          Width = 239
          Height = 156
          AutoSize = False
          Caption = 
            #35828#26126#65306#26412#21151#33021#29992#20110#31105#27490#21508#31181#38750#27861#31243#24207#36816#34892#13#22806#25346#29305#24449#21517#31216#65306#38750#27861#31243#24207#30340#21517#23383#13#20363#65306#8220#21450#26102#38632#8221#22806#25346' '#21487#22635#8220#21450#26102#38632#8221#25110#20840#31216' '#13#8220#26080#25932#21152#36895#22120#8221#22806 +
            #25346' '#21487#22635#8220#21152#36895#22120#8221#25110#20840#31216'   '#13#27492#36873#39033#22635#37096#20998#37325#35201#30340#23383#31526#21517#25110#20840#37096#21517#31216#21363#21487#12290#13#22806#25346#29305#24449#36827#31243#65306#38750#27861#31243#24207#30340#36827#31243#21517#23383#13#20363#65306#8220'JSY.exe' +
            #8221' '#8220#26080#25932#21152#36895#22120'.exe'#8221' '#13#27492#36873#39033#24517#39035#22635#23436#25972#36827#31243#21517#65292#21542#21017#26080#27861#26597#21040#12290#13#22806#25346#29305#24449#27169#22359#65306#38750#27861#31243#24207#30340#27169#22359#21517#23383#13#20363#65306#8220'JSY.dll'#8221#27492 +
            #36873#39033#24517#39035#22635#23436#25972#27169#22359#21517#12290#13#13#35831#20102#35299#22806#25346#65292#19981#35201#20081#28155#65292#26377#21738#39033#28155#21738#39033#65292#13#26368#31616#21333#30340#23601#26159#22806#25346#29305#24449#21517#31216
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object RzGroupBox6: TRzGroupBox
          Left = 329
          Top = 171
          Width = 237
          Height = 169
          Caption = #25805#20316#36873#39033
          ParentColor = True
          TabOrder = 0
          Transparent = True
          object RzLabel13: TRzLabel
            Left = 5
            Top = 23
            Width = 84
            Height = 12
            Caption = #22806#25346#29305#24449#21517#31216#65306
          end
          object RzLabel12: TRzLabel
            Left = 8
            Top = 153
            Width = 182
            Height = 12
            Caption = #35831#27880#24847#22806#25346#29305#24449#20998#31867#27491#30830#22635#20889#12290
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = [fsBold]
            ParentFont = False
          end
          object BtnGameMonAdd: TRzButton
            Left = 5
            Top = 48
            Height = 23
            Caption = #28155#21152
            HotTrack = True
            TabOrder = 0
            OnClick = BtnGameMonAddClick
          end
          object EditGameMon: TRzEdit
            Left = 87
            Top = 19
            Width = 145
            Height = 20
            FrameVisible = True
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 1
          end
          object BtnGameMonDel: TRzButton
            Left = 5
            Top = 119
            Caption = #21024#38500
            HotTrack = True
            TabOrder = 2
            OnClick = BtnGameMonDelClick
          end
          object BtnChangeGameMon: TRzButton
            Left = 5
            Top = 83
            Caption = #20462#25913
            HotTrack = True
            TabOrder = 3
            OnClick = BtnChangeGameMonClick
          end
          object BtnSaveGameMon: TRzButton
            Left = 87
            Top = 113
            Width = 147
            Height = 31
            Caption = #29983#25104#21453#22806#25346#21015#34920
            HotTrack = True
            TabOrder = 4
            OnClick = BtnSaveGameMonClick
          end
          object GameMonTypeRadioGroup: TRzRadioGroup
            Left = 88
            Top = 41
            Width = 145
            Height = 70
            Caption = #22806#25346#29305#24449#20998#31867
            ItemHotTrack = True
            ItemHeight = 15
            ItemIndex = 0
            Items.Strings = (
              #22806#25346#29305#24449#21517#31216
              #22806#25346#29305#24449#36827#31243
              #22806#25346#29305#24449#27169#22359)
            LightTextStyle = True
            TabOrder = 5
            Transparent = True
          end
        end
        object ListViewGameMon: TRzListView
          Left = 8
          Top = 19
          Width = 289
          Height = 321
          Columns = <
            item
              Caption = #29305#24449#20998#31867
              Width = 80
            end
            item
              Caption = #22806#25346#29305#24449
              Width = 188
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          GridLines = True
          HotTrackStyles = [htHandPoint]
          ParentFont = False
          RowSelect = True
          TabOrder = 1
          ViewStyle = vsReport
          OnClick = ListViewGameMonClick
        end
      end
    end
    object TabSheet5: TRzTabSheet
      Color = clWindow
      Caption = #30427#22823#25346#36807#28388
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 8
        Top = 5
        Width = 573
        Height = 346
        Caption = #20869#25346#36807#28388#37197#32622
        TabOrder = 0
        object LabelItemName: TLabel
          Left = 8
          Top = 270
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object LabelItemType: TLabel
          Left = 8
          Top = 293
          Width = 54
          Height = 12
          Caption = #29289#21697#31867#22411':'
        end
        object LabelTips: TRzLabel
          Left = 502
          Top = 269
          Width = 60
          Height = 36
          Caption = #25552#31034#65306#13#10#19978#38754#28857#21491#38190#13#10#21487#30452#25509#25805#20316
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          Transparent = True
          ShadowColor = clYellow
          ShadowDepth = 1
          TextStyle = tsRecessed
        end
        object BtnFilterOpen: TbsSkinButton
          Left = 5
          Top = 315
          Width = 75
          Height = 25
          TabOrder = 0
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #25171#24320'(&O)'
          NumGlyphs = 1
          Spacing = 1
          OnClick = BtnFilterOpenClick
        end
        object BtnFilterAdd: TbsSkinButton
          Left = 95
          Top = 315
          Width = 75
          Height = 25
          TabOrder = 1
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #22686#21152'(&A)'
          NumGlyphs = 1
          Spacing = 1
          OnClick = BtnFilterAddClick
        end
        object BtnFilterSave: TbsSkinButton
          Left = 365
          Top = 315
          Width = 75
          Height = 25
          TabOrder = 2
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #20445#23384'(&S)'
          NumGlyphs = 1
          Spacing = 1
          OnClick = BtnFilterSaveClick
        end
        object EditFilterItemName: TRzEdit
          Left = 64
          Top = 265
          Width = 161
          Height = 20
          FrameStyle = fsButtonDown
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 3
        end
        object GroupBox2: TGroupBox
          Left = 240
          Top = 260
          Width = 249
          Height = 49
          TabOrder = 4
          object CheckBoxHintItem: TbsSkinCheckRadioBox
            Left = 6
            Top = 15
            Width = 73
            Height = 25
            TabOrder = 0
            SkinData = bsSkinData1
            SkinDataName = 'checkbox'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            WordWrap = False
            AllowGrayed = False
            State = cbUnchecked
            ImageIndex = 0
            Flat = True
            TabStop = True
            CanFocused = True
            Radio = False
            Checked = False
            GroupIndex = 0
            Caption = #26497#21697#25552#31034
          end
          object CheckBoxPickUpItem: TbsSkinCheckRadioBox
            Left = 86
            Top = 15
            Width = 73
            Height = 25
            TabOrder = 1
            SkinData = bsSkinData1
            SkinDataName = 'checkbox'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            WordWrap = False
            AllowGrayed = False
            State = cbUnchecked
            ImageIndex = 0
            Flat = True
            TabStop = True
            CanFocused = True
            Radio = False
            Checked = False
            GroupIndex = 0
            Caption = #33258#21160#25441#21462
          end
          object CheckBoxShowItemName: TbsSkinCheckRadioBox
            Left = 166
            Top = 15
            Width = 73
            Height = 25
            TabOrder = 2
            SkinData = bsSkinData1
            SkinDataName = 'checkbox'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            WordWrap = False
            AllowGrayed = False
            State = cbUnchecked
            ImageIndex = 0
            Flat = True
            TabStop = True
            CanFocused = True
            Radio = False
            Checked = False
            GroupIndex = 0
            Caption = #26174#31034#21517#31216
          end
        end
        object BtnFilterChg: TbsSkinButton
          Left = 185
          Top = 315
          Width = 75
          Height = 25
          TabOrder = 5
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #20462#25913'(&E)'
          NumGlyphs = 1
          Spacing = 1
          OnClick = BtnFilterChgClick
        end
        object BtnFilterDel: TbsSkinButton
          Left = 275
          Top = 315
          Width = 75
          Height = 25
          TabOrder = 6
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          TabStop = True
          CanFocused = True
          Down = False
          GroupIndex = 0
          Caption = #21024#38500'(&D)'
          NumGlyphs = 1
          Spacing = 1
          OnClick = BtnFilterDelClick
        end
        object BtnFromDB: TbsSkinButton
          Left = 455
          Top = 315
          Width = 108
          Height = 25
          Hint = #22312#23548#20837#20043#21069#65292#38057#36873#36873#39033#65292#23548#20837#21518#25968#25454#20250#20840#37096#25353#36873#39033#37197#32622#65281
          TabOrder = 8
          SkinData = bsSkinData1
          SkinDataName = 'button'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          ImageIndex = -1
          UseSkinSize = True
          UseSkinFontColor = True
          RepeatMode = False
          RepeatInterval = 100
          AllowAllUp = False
          ShowHint = True
          TabStop = True
          CanFocused = True
          ParentShowHint = False
          Down = False
          GroupIndex = 0
          Caption = #20174#25968#25454#24211#20013#23548#20837
          NumGlyphs = 1
          Spacing = 1
          OnClick = BtnFromDBClick
        end
        object ListViewFilterItem: TRzListView
          Left = 10
          Top = 16
          Width = 553
          Height = 241
          AlphaSortAll = True
          Columns = <
            item
              Caption = #29289#21697#31867#22411
              Width = 90
            end
            item
              Caption = #29289#21697#21517#31216
              Width = 110
            end
            item
              Caption = #26497#21697#26174#31034
              Width = 80
            end
            item
              Caption = #33258#21160#25441#21462
              Width = 80
            end
            item
              Caption = #26174#31034#21517#31216
              Width = 174
            end>
          Ctl3D = False
          FrameColor = clMedGray
          FrameVisible = True
          GridLines = True
          HotTrackStyles = [htHandPoint]
          ParentShowHint = False
          PopupMenu = bsSkinPopupMenu1
          ReadOnly = True
          RowSelect = True
          ShowHint = False
          SortType = stBoth
          TabOrder = 7
          ViewStyle = vsReport
          OnClick = ListViewFilterItemClick
        end
        object ComboBoxItemFilter: TbsSkinComboBox
          Left = 63
          Top = 291
          Width = 162
          Height = 20
          TabOrder = 9
          SkinData = bsSkinData1
          SkinDataName = 'combobox'
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          UseSkinFont = False
          UseSkinSize = True
          AlphaBlend = False
          AlphaBlendValue = 0
          AlphaBlendAnimation = False
          ListBoxCaptionMode = False
          ListBoxDefaultFont.Charset = GB2312_CHARSET
          ListBoxDefaultFont.Color = clWindowText
          ListBoxDefaultFont.Height = -12
          ListBoxDefaultFont.Name = #23435#20307
          ListBoxDefaultFont.Style = []
          ListBoxDefaultCaptionFont.Charset = GB2312_CHARSET
          ListBoxDefaultCaptionFont.Color = clWindowText
          ListBoxDefaultCaptionFont.Height = -12
          ListBoxDefaultCaptionFont.Name = #23435#20307
          ListBoxDefaultCaptionFont.Style = []
          ListBoxDefaultItemHeight = 20
          ListBoxCaptionAlignment = taLeftJustify
          ListBoxUseSkinFont = False
          ListBoxUseSkinItemHeight = True
          ListBoxWidth = 0
          HideSelection = True
          AutoComplete = True
          ImageIndex = -1
          CharCase = ecNormal
          DefaultColor = clWindow
          Text = '('#20840#37096#20998#31867')'
          Items.Strings = (
            '('#20840#37096#20998#31867')'
            #20854#20182#31867
            #33647#21697#31867
            #26381#35013#31867
            #27494#22120#31867
            #39318#39280#31867
            #39280#21697#31867
            #35013#39280#31867)
          ItemIndex = 0
          DropDownCount = 8
          HorizontalExtent = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          Sorted = False
          Style = bscbFixedStyle
          OnChange = ComboBoxItemFilterChange
        end
      end
    end
    object TabSheet7: TRzTabSheet
      Color = clWindow
      Caption = #22871#35013#25552#31034#20449#24687
      object GroupBox12: TGroupBox
        Left = 275
        Top = 5
        Width = 305
        Height = 320
        Caption = #22871#35013#26174#31034#38468#21152#23646#24615#35774#32622
        TabOrder = 0
        object Label9: TLabel
          Left = 113
          Top = 146
          Width = 60
          Height = 12
          Caption = #22871#35013#26631#39064#65306
        end
        object Label17: TLabel
          Left = 6
          Top = 193
          Width = 84
          Height = 12
          Caption = #22871#35013#21151#33021#35814#35299#65306
        end
        object Label18: TLabel
          Left = 5
          Top = 146
          Width = 60
          Height = 12
          Caption = #22871#35013#25968#37327#65306
        end
        object Label19: TLabel
          Left = 5
          Top = 172
          Width = 60
          Height = 12
          Caption = #22871#35013#29289#21697#65306
        end
        object Label20: TLabel
          Left = 5
          Top = 24
          Width = 54
          Height = 12
          Caption = #20869#21151#24674#22797':'
        end
        object Label21: TLabel
          Left = 104
          Top = 24
          Width = 54
          Height = 12
          Caption = #38450#29190#23646#24615':'
        end
        object Label22: TLabel
          Left = 203
          Top = 24
          Width = 54
          Height = 12
          Caption = #21560#34880#23646#24615':'
        end
        object Label23: TLabel
          Left = 5
          Top = 48
          Width = 54
          Height = 12
          Caption = #20869#20260#31561#32423':'
        end
        object Label24: TLabel
          Left = 104
          Top = 48
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label25: TLabel
          Left = 5
          Top = 72
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label26: TLabel
          Left = 104
          Top = 72
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label27: TLabel
          Left = 5
          Top = 96
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label28: TLabel
          Left = 104
          Top = 96
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label29: TLabel
          Left = 5
          Top = 120
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label30: TLabel
          Left = 104
          Top = 120
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label31: TLabel
          Left = 203
          Top = 48
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label32: TLabel
          Left = 203
          Top = 72
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label33: TLabel
          Left = 203
          Top = 96
          Width = 54
          Height = 12
          Caption = #39044#30041#23646#24615':'
          Enabled = False
        end
        object Label34: TLabel
          Left = 203
          Top = 120
          Width = 60
          Height = 12
          Caption = #35282#33394#32844#19994'::'
          ParentShowHint = False
          ShowHint = False
        end
        object Memo: TMemo
          Left = 6
          Top = 207
          Width = 294
          Height = 107
          Hint = #22914#26524#27492#22320#26041#19981#26126#30333#65292#35831#30475#24110#21161#65281
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object EdtTzCaption: TEdit
          Left = 171
          Top = 142
          Width = 128
          Height = 20
          Hint = #19981#20801#35768#20026#31354#65281
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object SpinEdit30: TSpinEdit
          Left = 63
          Top = 141
          Width = 42
          Height = 21
          MaxValue = 12
          MinValue = 1
          TabOrder = 2
          Value = 1
        end
        object EdtTzItems: TEdit
          Left = 64
          Top = 168
          Width = 236
          Height = 20
          Hint = #26684#24335#20026#8220#29289#21697#21517#65073#29289#21697#21517#65073#8221
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object SpinEdit1: TSpinEdit
          Left = 59
          Top = 19
          Width = 42
          Height = 21
          Hint = #35831#19982#24341#25806#35774#32622#20540#19968#33268
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Value = 0
        end
        object SpinEdit2: TSpinEdit
          Left = 158
          Top = 19
          Width = 42
          Height = 21
          Hint = #35831#19982#24341#25806#35774#32622#20540#19968#33268
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 0
        end
        object SpinEdit3: TSpinEdit
          Left = 257
          Top = 19
          Width = 42
          Height = 21
          Hint = #35831#19982#24341#25806#35774#32622#20540#19968#33268
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Value = 0
        end
        object SpinEdit4: TSpinEdit
          Left = 59
          Top = 43
          Width = 42
          Height = 21
          Hint = #35831#19982#24341#25806#35774#32622#20540#19968#33268
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Value = 0
        end
        object SpinEdit5: TSpinEdit
          Left = 158
          Top = 43
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 8
          Value = 0
        end
        object SpinEdit6: TSpinEdit
          Left = 59
          Top = 67
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object SpinEdit7: TSpinEdit
          Left = 158
          Top = 67
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 10
          Value = 0
        end
        object SpinEdit8: TSpinEdit
          Left = 59
          Top = 91
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 11
          Value = 0
        end
        object SpinEdit9: TSpinEdit
          Left = 158
          Top = 91
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 12
          Value = 0
        end
        object SpinEdit10: TSpinEdit
          Left = 59
          Top = 115
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 13
          Value = 0
        end
        object SpinEdit11: TSpinEdit
          Left = 158
          Top = 115
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 14
          Value = 0
        end
        object SpinEdit12: TSpinEdit
          Left = 257
          Top = 43
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 15
          Value = 0
        end
        object SpinEdit13: TSpinEdit
          Left = 257
          Top = 67
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 16
          Value = 0
        end
        object SpinEdit14: TSpinEdit
          Left = 257
          Top = 91
          Width = 42
          Height = 21
          Enabled = False
          MaxValue = 255
          MinValue = 0
          TabOrder = 17
          Value = 0
        end
        object SpinEdit15: TSpinEdit
          Left = 257
          Top = 115
          Width = 42
          Height = 21
          Hint = '0-'#25112#22763#12289'1-'#27861#24072#12289'2-'#36947#22763#12289'3-'#36890#29992
          MaxValue = 3
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 18
          Value = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 5
        Width = 260
        Height = 346
        Caption = #22871#35013#26174#31034#21015#34920
        TabOrder = 1
        object ListViewTzItemList: TRzListView
          Left = 7
          Top = 15
          Width = 247
          Height = 325
          AlphaSortAll = True
          Columns = <
            item
              Caption = #22871#35013#26631#39064
              Width = 65
            end
            item
              Caption = #25968#37327
              Width = 40
            end
            item
              Caption = #22871#35013#29289#21697
              Width = 120
            end
            item
              Caption = #23646#24615
              Width = 120
            end
            item
              Caption = #21151#33021#35814#35299
              Width = 120
            end>
          Ctl3D = False
          FrameColor = clMedGray
          FrameVisible = True
          GridLines = True
          HotTrackStyles = [htHandPoint]
          MultiSelect = True
          ParentShowHint = False
          ReadOnly = True
          RowSelect = True
          ShowHint = False
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewTzItemListClick
        end
      end
      object BtnTzOpen: TbsSkinButton
        Left = 274
        Top = 328
        Width = 50
        Height = 25
        TabOrder = 2
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #25171#24320'(&O)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = BtnTzOpenClick
      end
      object BtnTzAdd: TbsSkinButton
        Left = 325
        Top = 328
        Width = 50
        Height = 25
        TabOrder = 3
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #22686#21152'(&A)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = BtnTzAddClick
      end
      object BtnTzDel: TbsSkinButton
        Left = 376
        Top = 328
        Width = 50
        Height = 25
        TabOrder = 4
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #21024#38500'(&D)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = BtnTzDelClick
      end
      object BtnTzChg: TbsSkinButton
        Left = 426
        Top = 328
        Width = 50
        Height = 25
        TabOrder = 5
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #20462#25913'(&E)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = BtnTzChgClick
      end
      object BtnTzSave: TbsSkinButton
        Left = 477
        Top = 328
        Width = 50
        Height = 25
        TabOrder = 6
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #20445#23384'(&S)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = BtnTzSaveClick
      end
      object BtnTzHelp: TbsSkinButton
        Left = 528
        Top = 328
        Width = 50
        Height = 25
        TabOrder = 7
        SkinData = bsSkinData1
        SkinDataName = 'button'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        ImageIndex = -1
        UseSkinSize = True
        UseSkinFontColor = True
        RepeatMode = False
        RepeatInterval = 100
        AllowAllUp = False
        TabStop = True
        CanFocused = True
        Down = False
        GroupIndex = 0
        Caption = #24110#21161'(&H)'
        NumGlyphs = 1
        Spacing = 1
        OnClick = BtnTzHelpClick
      end
    end
    object TabSheet4: TRzTabSheet
      Color = clWindow
      Caption = #30456#20851#20449#24687
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label2: TLabel
        Left = 144
        Top = 288
        Width = 288
        Height = 36
        Caption = #26412#31243#24207#21482#36866#29992#20110#20013#21326#20154#27665#20849#21644#22269#27861#24459#20801#35768#33539#22260#20869#30340#20010#20154#13#23089#20048#65292#19981#24471#29992#20110#21830#19994#30408#21033#24615#32463#33829#65292#22914#22240#27492#36896#25104#30340#21518#26524#33258#13#36127#19982#26412#36719#20214#26080#20851#12290
        Color = clBtnHighlight
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object bsSkinGroupBox1: TbsSkinGroupBox
        Left = 112
        Top = 24
        Width = 393
        Height = 161
        TabOrder = 0
        SkinDataName = 'groupbox'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        CaptionImageIndex = -1
        RealHeight = -1
        AutoEnabledControls = True
        CheckedMode = False
        Checked = False
        DefaultAlignment = taLeftJustify
        DefaultCaptionHeight = 22
        BorderStyle = bvFrame
        CaptionMode = True
        RollUpMode = False
        RollUpState = False
        NumGlyphs = 1
        Spacing = 2
        Caption = #29256#26412#20449#24687
        object Label3: TLabel
          Left = 8
          Top = 32
          Width = 54
          Height = 12
          Caption = #36719#20214#21517#31216':'
          Color = clMenuBar
          ParentColor = False
        end
        object Label4: TLabel
          Left = 8
          Top = 52
          Width = 54
          Height = 12
          Caption = #36719#20214#29256#26412':'
          Color = clMenuBar
          ParentColor = False
        end
        object Label5: TLabel
          Left = 8
          Top = 72
          Width = 54
          Height = 12
          Caption = #26356#26032#26085#26399':'
          Color = clMenuBar
          ParentColor = False
        end
        object Label6: TLabel
          Left = 8
          Top = 92
          Width = 54
          Height = 12
          Caption = #31243#24207#21046#20316':'
          Color = clMenuBar
          ParentColor = False
        end
        object Label7: TLabel
          Left = 8
          Top = 112
          Width = 54
          Height = 12
          Caption = #23448' '#26041' '#31449':'
          Color = clMenuBar
          ParentColor = False
        end
        object Label8: TLabel
          Left = 8
          Top = 132
          Width = 54
          Height = 12
          Caption = #31243' '#24207' '#31449':'
          Color = clMenuBar
          ParentColor = False
        end
        object EditProductName: TEdit
          Left = 64
          Top = 32
          Width = 313
          Height = 20
          BorderStyle = bsNone
          Color = clMenuBar
          Ctl3D = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
          Text = 'EditProductName'
        end
        object EditVersion: TEdit
          Left = 64
          Top = 52
          Width = 313
          Height = 20
          BorderStyle = bsNone
          Color = clMenuBar
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 1
          Text = 'EditVersion'
        end
        object EditUpDateTime: TEdit
          Left = 64
          Top = 72
          Width = 313
          Height = 20
          BorderStyle = bsNone
          Color = clMenuBar
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 2
          Text = 'EditUpDateTime'
        end
        object EditProgram: TEdit
          Left = 64
          Top = 92
          Width = 313
          Height = 20
          BorderStyle = bsNone
          Color = clMenuBar
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 3
          Text = 'EditProgram'
        end
        object EditWebSite: TEdit
          Left = 64
          Top = 112
          Width = 313
          Height = 20
          BorderStyle = bsNone
          Color = clMenuBar
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 4
          Text = 'EditWebSite'
        end
        object EditBbsSite: TEdit
          Left = 64
          Top = 132
          Width = 313
          Height = 20
          BorderStyle = bsNone
          Color = clMenuBar
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 5
          Text = 'EditBbsSite'
        end
      end
      object bsSkinGroupBox2: TbsSkinGroupBox
        Left = 112
        Top = 184
        Width = 393
        Height = 89
        TabOrder = 1
        SkinDataName = 'groupbox'
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        CaptionImageIndex = -1
        RealHeight = -1
        AutoEnabledControls = True
        CheckedMode = False
        Checked = False
        DefaultAlignment = taLeftJustify
        DefaultCaptionHeight = 22
        BorderStyle = bvFrame
        CaptionMode = True
        RollUpMode = False
        RollUpState = False
        NumGlyphs = 1
        Spacing = 2
        Caption = #29256#26435#22768#26126
        object bsSkinStdLabel6: TbsSkinStdLabel
          Left = 23
          Top = 36
          Width = 348
          Height = 36
          EllipsType = bsetNone
          UseSkinFont = False
          UseSkinColor = True
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'MS Sans Serif'
          DefaultFont.Style = []
          SkinDataName = 'stdlabel'
          Caption = 
            #26412#35745#31639#26426#31243#24207#21463#20013#21326#20154#27665#20849#21644#22269#30693#35782#20135#26435#19982#29256#26435#20445#25252#65292#22914#26410#32463#25480#26435#13#32780#25797#33258#22797#21046#25110#20256#25773#26412#31243#24207#65288#25110#20854#20013#20219#20309#37096#20998#65289#65292#23558#21463#21040#20005#21385#30340#27665#20107#13#21450#21009#20107#21046 +
            #35009#65292#24182#22312#27861#24459#35768#21487#30340#33539#22260#20869#21463#21040#26368#22823#21487#33021#30340#36215#35785#12290
        end
      end
    end
  end
  object bsBusinessSkinForm1: TbsBusinessSkinForm
    PositionInMonitor = bspDefault
    UseFormCursorInNCArea = False
    MaxMenuItemsInWindow = 0
    ClientWidth = 0
    ClientHeight = 0
    HideCaptionButtons = False
    AlwaysShowInTray = False
    LogoBitMapTransparent = False
    AlwaysMinimizeToTray = False
    UseSkinFontInMenu = True
    ShowIcon = False
    MaximizeOnFullScreen = False
    AlphaBlend = False
    AlphaBlendAnimation = False
    AlphaBlendValue = 200
    ShowObjectHint = False
    UseDefaultObjectHint = True
    MenusAlphaBlend = False
    MenusAlphaBlendAnimation = False
    MenusAlphaBlendValue = 200
    DefCaptionFont.Charset = GB2312_CHARSET
    DefCaptionFont.Color = clBtnText
    DefCaptionFont.Height = -12
    DefCaptionFont.Name = #23435#20307
    DefCaptionFont.Style = []
    DefInActiveCaptionFont.Charset = GB2312_CHARSET
    DefInActiveCaptionFont.Color = clBtnShadow
    DefInActiveCaptionFont.Height = -12
    DefInActiveCaptionFont.Name = #23435#20307
    DefInActiveCaptionFont.Style = []
    DefMenuItemHeight = 20
    DefMenuItemFont.Charset = GB2312_CHARSET
    DefMenuItemFont.Color = clWindowText
    DefMenuItemFont.Height = -12
    DefMenuItemFont.Name = #23435#20307
    DefMenuItemFont.Style = []
    UseDefaultSysMenu = True
    SkinData = bsSkinData1
    MinHeight = 0
    MinWidth = 0
    MaxHeight = 0
    MaxWidth = 0
    Magnetic = False
    MagneticSize = 5
    BorderIcons = [biSystemMenu, biMinimize, biRollUp]
    Left = 328
    Top = 8
  end
  object bsSkinData1: TbsSkinData
    EnableSkinEffects = True
    CompressedStoredSkin = bsCompressedStoredSkin1
    Left = 360
    Top = 8
  end
  object bsCompressedStoredSkin1: TbsCompressedStoredSkin
    FileName = 'skin.ini'
    Left = 480
    CompressedData = {
      78DAECBD075C5557D63E7C88F99CF7FB675E67DECC7CFFA8C99B19D3461353CC
      245101A32296D8A36241885D6CA07444AA14A9F64A95A2F4DE3B48EFBD8374A5
      77D02413F9D6B91B0E87DBB82A9028EB71C9EF9EB3D75EA72CEE7AF6BEE7B29F
      1914406AD36023C5C177F07F3EFC7786FF5AF05F8C9ACDD91F0FED6FBF45FE8F
      608883B7DE7A6BCEECD96FD3F81FB4D7C3FEFEF7BF435A497E397986ADE5CB97
      8B8B2F95949458B64C12EDF53009C8E8D2A524D59CB7F42A29A91D3BB6A3BD96
      0609875453D47BEFBD272BBB87DDF2E3D6AD787B5EBB3C2F5AB4E8F0E143649F
      BC9C1CDA6B6363F3FCDD77DF291C3DCAE4F9CF7FFEB338E21587087906BAEE47
      BCE220A9C63C639E31CF986704E619817946609E11986704E619817946609E31
      CF9867CC3302F38CC03C2330CF08CC3302F38CC03C2330CF9867CC33E6198179
      46609E11986704E619817946609E119867CC33E619F38CC03C2330CF08CC3302
      F38CC03C2330CF08CC33E619F38C79C6FB847946609E11986704E61981794660
      9E119867CC33E619F38C79C63C2330CF08CC3302F38CC03C2330CF08CC3302F3
      8C79C63C639E11986704E619817946609E11986704E6198179C63C639E31CF08
      CC3302F38CC03C2330CF08CC3302F38CC03C639E31CF986704E619817946609E
      11986704E619817946609E31CF98E7E9996705CCF3F4C8B302E6F975CFB384A4
      F8C91327D87946BCEA20A964F2FC97BFFC05F22C21AEA4A8C8E4F9E08103FB7E
      FA095E80215E2D40CA207707F6EF27E9E3C9F3A99327C93EB04D9B364E926DDE
      BCE995B32D5B36BF8AB675EB961F7FDC2A03E9DCB66D34CF4B154F9DDAB56BE7
      141C1C6DCA0CF20C3692E75914252EB1F4D4A9933232321B376E98549BBC4A31
      99F6AA82D42348F8D83CC35B7CFDFA1F26D5366C58FFCAD964FFEE4FB641AA99
      3C8B2F057EDEB6EDC775EBD64EAAFDF0C33AB42933F2DE82923436CFF0065FB3
      66F5A4DADAB56BD0A6CCC87B0B4A122BCF307F86C44B49AD9C545BB54A0A6DCA
      4C5A7A15D8BAB56B47F2BC9493E70DEBD7AF58BE7C526DE58A15685366522B57
      82AD59BD9AC9F3D22590E7F53FACFBFEFB65936ACB977F8F3665B662C5F2952B
      57C05B9A55B7154F9D8442BE125A26D3A456AE407B315B05ACF7BCC6A9DE302C
      1AF99C447299E46925251887AD5BB7E6871FD64E9EAD5FBF0E6D0AED07B8E71B
      36FC00797EFBEDB7290AA853435D1DE65A933DDE467BF1A9CA0B1867D40D132C
      C8F3DFFFFE778A929292D2D4D484BABD7AB5F4A41AA66BEA8DE4F9FFFEDFFF8F
      A256AD5A353579469B5AA3B16E1D9DE777DE7987C9F3FA1F564BAF9A5CC37B3F
      B546BF9FC7E4F99CB6368CC326FBF36DB4A9B40DEBD7836DDE447FBE3D7B36C9
      B39E9EDEAE5D3BB76DFB71920D31D59091D9C1C9F36C8A925E2D6D626CBC7FFF
      BEBD7B6527D5E4E4F6A24DB1FDF4933CE479CEDC391475E4C8116B2B2B2525C5
      63C71414148EA2BD4E0639853CBFFFFEFB9C3CDBD9D9EAEBEBA9ABABA9AAAAA0
      BD4EA6A6A60A79FEFAEBAF296A6868C8D2D2E2FAB56BC6464606FA906FBDC932
      7DB417B6E786818181A1A121BC803C438A397986B7B4B7B7F79D3BB72F5FBE64
      6D6D05699F1C434C11ACACAC2E8DE0C0C1032379266FE9B8B818777777575757
      4747477BC4AB8CBB77EFBAB8B8409215154F91FC8EE499BCAB39D98E8B8C8C0C
      0D0D0D9968044F1AC25E77843F0F222222A2A3A32195905026B9AC3C33D946BC
      06E04A2B4551529B061BC99F6B7C07FFE7C37F67F8AF05FFC5A8D99CFDF1D0FE
      F65BE4FF08FA3858B76EDDB61F7FE47C917423DAEB619B376F86B492FC72F20C
      5BA74E9D3A7EFCD88913C74F9E3C81F67AD871C8E8B16324D514B562C58AD34A
      4AE7CE69A3BD9606098754D37F92B7032667EC96B35A5A787B5EBB3C1F3C78D0
      D4D494EC3344BC46189BE7A3478F9A99993179FEE1871F8E235E71889067A0EB
      36C42B0E0D0D0DCC33E619F38C7946609E11986704E619817946609E11986704
      E619F38C79C63C2330CF08CC3302F38CC03C2330CF08CC3302F38C79C63C639E
      11986704E619817946609E11986704E6198179C63C639E31CF08CC3302F38CC0
      3C2330CF08CC3302F38CC03C639E31CF9867CC33E619817946609E11986704E6
      19817946609E31CF9867CC33E619F38CC03C2330CF08CC3302F38CC03C2330CF
      08CC33E619F38C7946609E11986704E619817946609E11986704E619F38C79C6
      3C2330CF08CC3302F38CC03C2330CF08CC3302F38C79C63C639E11986704E619
      817946609E11986704E6198179C63C639E31CF9867CC33E295CEF3F113C72D2D
      2CD87946BCEA20A964F2BC61C306C8F3F1E3D6D6D64C9E4D8C8D8DCE9F3744BC
      9A80DC191B1991D73C79B6B2B424FBC03434D45FD8343535D05EC0B4B43427DA
      B4CE9ED5D281746AB3F27CCCDACA4A575767128E26F02C10930DC833D8489ED7
      73F26C6565A9A3A3A33E55789992F19ADAC463A452688DCD33BCC5D5D454A7C6
      D4D5D5D0C6DA640152CDCEB3A5A5B6F659555595A932C4A483BCA5A0588CCD33
      BCC195A70A2A2A68936EE42D05C5829567983F43E295A60AA74FA34DBA9D3973
      1A4C55456524CFC73879565753533C756A6A4C4951116DD28D03A89E4C9E8F29
      409ED554554F9D3A3955869874282A9E52525284B734AB6E5B5B594221578296
      29B1D350BAD126DB38D57BE4FDBC81A24E9C3C71D1DA1AC661AAAACA5333DE9E
      B209DC3437CE384C15F2BC69D3268A02C6BC76F52ACCB5A66EBC8D3605363CEA
      A6F3BC79F3668A02B6BE7EFD3AD46D65E5335365882902C9F3D6AD5B28EAF4E9
      D3539E67B4297A338DE4792B93673555E533A7A7C830095395EAB179BE79F326
      8CC370E0F23A99BA9A1A98A606FDF9F68F3F923CDFB973475757475BFBEC5419
      628AA0A3738E93E71F29EA8CF2197B7B7B2323230303FDA931434303B4A9B1F3
      E70D21CFDBB66DA3A80B172EB8383B5B5B5B9B9B9B215E33404E21CF3232329C
      3CFBFAFA40E9BE7AF5EA952B97D15E278394429E0F1D3A44517D7D7DCECE4EEE
      6E6EF67676367710AF096C6C6C6C6D6DE105E41952CCC933BCA5232222BCBCBC
      EEDD73758122EEECF4A286F8A3C07504C626C62379266FE99494E4D0D0D0A0A0
      207F7F7F5FC4AB0CC86060602024D9DADA8AE47724CFE45DCDC9764A6262627C
      7C7CDCF3235634242026130F1E3C484A4A8254424299E4B2F2CC641BF11A802B
      AD1445496DD27B8BE2E07BF83F1FFE3BC37F2DF82F06FF68AC80F6B787FFBF41
      8D626868888AA77841EF33E0B37F05854020100804028140FC312068BC2A68BF
      A0716F2DEF6E317AFF53DEFD7FA2F7CFE48CC0955C6670767D373C029F01C36C
      1BCE087C3667FF12681F1981B346DF0804028198CE402E402010080472010281
      4020900B10080402815C8040201008E4020402814020172010080402B9008140
      2010C80508040281402E4020100804720102814020900B10080402815C804020
      1008E4020402814020172010080402B90081402010C80508040281402E402010
      0804720102814020900B10080402815C8040201008E402040281402017201008
      0402B90081402010C80508040281402E4020100804720102814020900B100804
      02815C8040201008E4020402814020172010080402B90081402010C805080402
      81402E4020100804720102814020900B10080402815C8040201088E9C9055D31
      CA7F7C1374F2F3E6BDFFD147F33EFD74FE975F2EFCEAABCFBFF8E2B34F3FFD17
      EC81FDA234C1FE6FBE59B464C9B7E2E28B2525C5D7AF5FBB6F9F9C8ACA196D6D
      ADD3A71577EEDC2129B9147A7DF8E13F3FF8E01FF0936D9F7CF2E1BFFFBD68D3
      A60DAAAACA363677BCBC3C6D6C6E6B6A6A40AFE5CB25172DFA821C8E1C11BA83
      C9CBEFD5D2D2387FDE404F4F077A81319B7272B2D0EB9FFFFC5F2E638722713E
      FB6CFE8A15CBD8A11E1850605CA1C08D2B140459B64C7CD72E993367948A3C8E
      16B8CA66DFFE3ED5EA9F49C66F2518BC4182D066F84692C95BE997E6E5DA2D2F
      76DF5BE27534DF5996DC8A850B17803141C0CE9ED5CC73924DBFF67DA2C93FE3
      75DF8AD77923418F4AD0A746A319D09BB0335EF7CD07867F4BBDB8A8C055FE61
      8C25DCAEDBB76F9E3973DAE1DCBA2BC716862ABE1972920A55A4C2CF5091AA54
      8C2615778E12140A9AC001DCC019BA404773B9F72EC8BD4F7E25EE694BBA698B
      5706CE06AB0A9A5D153CFB61E8EC9A88D9B591B3EBA23916C332CE1E68020770
      0367E8021D2102C4C192885C805CF0AA7001D4E4132714C04E9E3C468C6C1E3F
      7E144C94A653A78E8329299D5CBCF89B0B174CEEDE75888A8A4C4D4D8E8C0C77
      74B43731315253530637D28B31E8ABA878424B4BDDCACAC2CBCB233B3BCBC7C7
      3B2B2BD3D3D3C3DADA525C7C8992D229F611C909383939464747A6A7A7C6C7C7
      0604F8070606309BE4585C470163872271E07C4C4D8DD8A15A03E78171850237
      AE50405EA42FE71A23FACBBDFA0A6F77A528B7476E680B5ED41AF81189435BD0
      47ED615F77C46EEC4E57E92FB519A8F4EACDBB4DC26A68A8820103922070A37A
      726EB7C72AB7046C68F65ED4ECF5518BEFBCD68079A3A102E9CD16DF0F5ABC3F
      69F65BDC1A2AD395623450153272BBDC5DCE6F8B3C33BBF6E62735D73FA8BD39
      AFDE665EA3E3BC47F7E7357BCE13108A6E0207700367E852737D5ED0018ACD05
      F9FA7FA9B946EF7FE1801001B900B9607A72C18BD1474B5988E8F632BD847081
      AEEEB9850BE7BF8C7DFEF9020303BDA54BBFB3B3B33137378D8808834A151616
      0AD4202F2FBB62058CCC3F071FAE2E5F7FFDC5FEFDF2609696E6B1B13150D662
      63A32D2CCCECEC6C21140464BAC00B88004682FBF9F982BF8B8BB3ABAB33B349
      8EC575627069EC5024CECA95CB7EFA692F3B548FBB588F3BC5150A4E9B2BD4FC
      F91FC3E9317DE11A9F14B9F7C729F50648F478CDEE719F49E2D03F3D67F6FACD
      E90F971C4839F3B4C2133C07F3DC212CF495965E696565B97BB74C6868080932
      90EDDE1DA0D4E120D16133BBD36E66B7B358CF7D8A1367C4EE53B0B3D3FE4F1D
      36733BEF2EEF09561D2C0820B70B6E7298E1F22CA3B9F5C766D61F136B50A49A
      34A86643AAED12D56903BD287EA1E82670003770862EF50A54AABA98D39E19E4
      57224E735ED3B57FFC1636EBB7F059BF45CDFA2D6ED66FC9B39E65CE7A9637EB
      59D1AC6725B39E95B2AC84B3338F760037DA398AEE0811200E9644E402E402D1
      B960A82BFBB78E4CE1063E5C5CF0BCBD9E8B0B36AF5E7974E7765E83FD82B8C0
      D0507FE9D2C5F6F6765C855D7828C205E006CE30508F898986326B6B6BC3CB05
      401C60FE3EDE4E0E76A14101F636B7491C66F3E245CB1B572F8DCB0510444AEA
      7BB30B26E38682D13B57A8050B3E81536593D7936C5F2117D87D7F3931F07C5A
      EC0F7DF7ED935BB3460A263EB2B2BBC3C3C38683E4FBF706AB74DF5B264A2830
      70862EE47601A1A49D9728B7FA57FDFE99F507C51A4F508FB5A836734A9450E0
      06CED0A5FE0055ACFFD730F9E1376FF1B9BFF4D97F31E4F1C690D71B43FE6F0C
      85BF3194F0862801C18D76F6A73B420488832511B900B9E039B8A03DEED7E628
      E1063E5C5CF0A4EBA128F6625C00EFF1527E80FDE372015761171E8ACD05F6F6
      B6D1D1513078B6B5BDB364C9B77CB9E0C183786F6FAFD4D4145F5F6F1287D984
      6339DCBEC9CB05EC500C175898998E1B4A5D5D45101730D7085C20E402992209
      9E4F8BFD202CCC0B182E8021FD70905CBFBEE033BD9E12A284EAF5FEBE2F44E5
      499E3FB95D2121C1A9C6E2F5D7BFAADF33B35E4EAC49816AD1A63AAF50A28402
      3770862EF57BA91AF37743F70FBF798BF4FEE737B7A543B6D4900335749F1A0A
      A08662450A086EB4F37DBA234480385812910B900B9E830B3A127F6D89136EE0
      33C55CF09FFFFC876B677D7DBDA009C2C86744C005B65C855D94501616178038
      ECEC6CA08B99193D2FE0E502F219515A5A8AB535FD7CE1CA95E12900B369765E
      DFE1D6F85C00410817B0439133E10AA5A6A6C2F7332218DB33D748B8002E906B
      B4CC7581E0F9B4C8977CF4242DBD12B860CF9E5D840B4890BE20A53E1F715142
      F5FB2EEB0B567E92E3476E576868708AA944FDB5AFEAB7CE6CD821F6E820D57A
      96EABE4189120ADCC019BA346CA76ACCE6861C187EF316EABFFDDBFD254397A8
      A1EBD4903D35E4450DC5881410DC68677BBA234480385812910B900B9E830B3A
      D37E6D4D126EE0C3CD05DD0F45B109E4829696166670C83541603D2FB0E52AEC
      A28402B7888870A88A515191D05DC8F30218B75B5999B3B980D98411325F2EE0
      FBBCC0C2CC841D0AC6B4701A5CA10471018CED996B647301333C86D75C17089E
      3F17F9C265B29E17EC0C0B0B190E92E9DB1F78BADF57429450C005E0FC24DD8B
      DC2E08927461593570C1DA990D1BC51EC9516D9A540F8B0B8484023770862E0D
      1BA8F20B730246B82057FFED27F7160F195143661C3AB8470D45881410DC68E7
      EB744788908B5C805C805C30055CD0D3288ABD0C17700D02C91B9F19D5F39D17
      4019E72AECA2843236360C0C0C7074B40F0D0D31353586F228880B9292126F5E
      BB1214E06777E71609C56C464646D8DFBA210A17D0CF0B4C8DC70DC5FB1911C3
      05CC350A9A17705D20ED59E0037703E614AB57D39F110117C0909E041948F7E9
      0954EEF55D264AA85E5FC96EDF137D0F9CC9ED0A09094A3491ACBCF265F9CA99
      156BC46A76538FD4A84E01F302AE50E006CED0A56235556A32DB7FDFF09B3747
      F7ED0197EF8674A8A1F3143D3B70A286C2450A086EB4F325BA23448038581291
      0B900B8C74B5191B870BBAB37E6D4F23C6EEC5EC04031F1E2E68628CDD8BBD1F
      EC65B880EB9361520A9851BDA0EF1171157651421918E87A7B7B3939390604F8
      9F3F6F606B7B4710179087AD0909F15E5E9E2414B3094D36D7AF8A382F303132
      183794AAAAB2202E60AE91E102E117089E83396E7037081790EF110505059220
      7DC96EDDBE8A3D7E92A284EAF115EFF23CD213634B6E1744883712AFB8FC55C9
      F299A5D262553BA94615AAE326254A28700367E852BA8A2A319EE3FBD3F09B37
      4BE7ED7EE7C5437A33868C670C5D9E31E432632872862801C18D76BE4C778408
      10074B22720172C17370414FFEAF1DD9C4C670C1C84E30F0E1E682DEC78C8DE1
      02D67EB097E1025E708D0679B900CA385761172594BEBE8E9797070CD4FDFD7D
      0D0DF56D6CEE087A5E000369080B9E3E3EDE240EB31917177BFBCA65519E1700
      1718EAEB8E1BEACC1925BE5C2027B787B946860B845F20780E643AC1DD909797
      255CB073E7767F7F3F12A437DEA9D3EB588FB7B828A17ABC96747A1CEE89BA43
      6E5760A07F9CC1D28A4B235C20433528531DD7285142811B3843179A0B8CE6FA
      C80DBF7933B5FFA7DF69C9D0857786ACDE19BAF5CE90FB3B4331EF881210DC68
      E75B7447880071B024221720173CC76744BD85FFE9CA136EE0C3CD057DCDA298
      285C00E361757555B69D3DA3C8F70B84B09F190DB2FD3534D4BCBD3DA1EAC6C4
      44C1B83A2D2D152A55666606D455514241DFB4B4B4DCDCECF4F474E802412014
      EC84B04C7C2D2D0DB0F0D0E0D0A0C0B8E8A8005F1F1287D9ACACACB8EF68CF75
      217069EC50240ED4E47B2ECEE3867272BACB150AB8006AEFB56B57996B042E10
      E502C1B3AF84FEEBB0EBD7AF9A9818050707EED8B10DEE0F09D29317D21167D1
      19AB204AA8CE98A3EDB1E6DDD901E47665676746692FAD70FAB1506545918664
      B9A144ED3589162F095142811B384397227589925BCBDD760CBF799355FEDA1F
      223F64BB6EC871DD90FBBAA1E0754349EB4409086EB4B33BDD1122401C2C89C8
      05C805CFC105FD15BF76970837F0E1E18216516C5C2EF8E8A379212141A6A646
      BC76E3C63521A3412EE7B0B0109817242727858606E7E6E640A5CACBCBA5FF12
      6AC48484822E3939D92525C5D9D959102725250942C10B767C73735330A89F59
      59190FE2E32038E9CE6CD6D7D7BA3BDFE53A2BB834AE5010E4CA954B7E3E5EE3
      86F2F1F1E20AB560C127D1D1914E4E0ECC350217B4466B10137281E0D9531205
      370166014007B1B1D13232DB0B0AF24990CEBCA8D6F85B4C1CE1A1A0B525EE46
      674E38B95D858505C16AE265AEF239E7B6E7EA6D2D32DD5279634BA3C7165142
      811B3843975CDD2D45B61B1D360CBF79A38FCFEA8D3831745F71C84371C84F71
      2842712845519480E0463BFBD11D2102C4C192885C805CF01C5CD057F66B5791
      70031F1E2E6813C5C6E5824F3EF930363606CA3E5F13321AE4F28C8F8F13175F
      9295951917175B54540895AAB0B01076325C2024544C4C745E5E5E555525D446
      780D41A080431C76FC5BB76E82810394D0B4949498A808D29DD9F4747186213D
      D759C1A5718582208E8EF6E161A1E3868273E60AF5D967F36118EFEDEDC55C23
      9B0B845C2078769705C0DD80A901D0414A4AF2CE9D3BCACA4A4990CEE28096D4
      8BCDF18AA2847A1C77A239C9BCA3C09BDCAE9292122F856F4BDC0EE65F5E5370
      6555F16DA90A27A93A5F295142811B384397822B52058EDB6F2C1F7EF306C9FF
      77778CF2CF613B7F8ED8F94BCCCE5F9276FE9AB5539480E006CED0053A420488
      832511B900B9E079B8A0FCD7AE62E1063E93C405F3E77F949A9AE2EAEAF29296
      96962A21B10486A9292929A5A5A550A9A04CC16BA8A8503CEFDFBFC7DBE5DE3D
      574F4F8FA0A0A0F8F87832C4CDCACA8A8BA347E6DF7EFB3504643B4304B0A2A2
      22885C515101444382B33693939292B80E0197C6150A82C0F9404967876A4F5F
      DD9E2ECD150A4A3757A8CF3F5F003C050765AEB1ABC2BB3DDFAA2DEB545B9A4C
      5BDA0F240EFD33635D47D6CECEBC535D2556BD35BEE0D951E2454ED8D7D7072E
      76E7CEEDB09304692FF47A9462D11073B2316AC7A3D8752D89ABDB52A5397186
      0D365B12A51FC5AE6D88DC5A1F79B8215EEF71C66D72BB8050EC641694789D2C
      B0595B60235DE4205DEA2A5DE52D5D1722FD2886EEC53F540CED006EE00C5DA0
      63E1BD03E6DF0CBF79DDB6FD9F9E44FDC1E86D8331DB9EC46F7B92B4ED69FAB6
      9F73B7FD52B4EDD7B26DBF566EFBB58A6595F44E680207700367E8021D2102C4
      C192885C805CF0AA70C182051F43ED0D0A0A7C49CBCFCF5BBCF81B284D999999
      30D6ADACAC282E2ECECCCC8021747878587070106F17D8191A1A121515099539
      23231D2A1BFC4C4C7C505C5CB468D1175C6705CE6050A8A15CC351A012427028
      D7ACCDCCF4F434AE434010AE501004CE073CD9A16A23646B23F670850246E00A
      B570E17C688583C2A181E9DA8A035B0B3C1E675E6F48D4A98B3E5117B98FC4A1
      2D52BE2156A131E95C73F68DF612CF8ED2A0E6DCFB1016EE464444384C07B66C
      D9505353436E5453A64B6D9C5575A85A65D0A1EA20B987217B6AC3F70CC72116
      BE07765605C95604ECAF0C3C5515AE531363496E574545B9F5CAF70ABDB5721D
      64F31CF6E4DFDD53E8BAA7C47D4FB9EF9EAAC03D024305D20EE006CED085EEE8
      A1A2B760F8CD6BB7F6BFBA522F0FC42B0C24280C3C50184C52184C557892A9F0
      3447E1699EC2D37C859F0B460D36E99D39B403B8813374818E1001E260499CE6
      5C30DDD6BC7D592E18ACFFADBF56B881CF2471010281404C1E174CAB356F5FE9
      754A1108046292B880EF9AB7F44F11ED555BF3F695D62FE0157F116E9F7DB660
      C58AEFE5E5F76A68A8E9EA9ED3D45487D7CB974B2E5CF8E9E79F7F2ABCE9A79F
      E460FFE5CB17EDEC6C6D6D6D2E5DB286CD7DFBE4C0E7D34FE77FF0C13F20FE47
      1FCDFBFAEBAFB66EDD7CEEDC591717E7A0A0C08654C7AA880B609E9E1E818181
      B0F3EC59CDCD9B374A4A2E5DB56A25FB70E9D7D7C4E97F18AEF2E730C5372354
      FF3BDEE063D893EF7A907D32D6871758C8BF1F72921AD72E1E78CF7CDFFBEC49
      AE70F3D41377D3C115FB1188512E78DE356FE9E50D89BD9A6BDEBEEA5A36BCFA
      2F820C9CBFFDF66B73F30BF7EFBB2624C4676666C0CF7BF75CCCCC4C3435D5C0
      B89AA09E6FDDBA89697277BF9F92925C52525C41A3BCB8B80836C11FBA13BD1B
      2082050B3E81527FE5CAA5A0A000F084384F1A53FB4A3CC1A04B46463AF40A08
      F0BB72E5A29191C1CE9D3B74757598C3B5C76A3FF2D85C67FB75DDADF9F576FF
      7EE4F9637B9C4E6FA12B739E7032978F7D197CE84D7AD23A9E459EA2AC0EBC3F
      3AC91DCF8ACDFEE2A1875C80408C72C1F3AE793BCA05B8E6ED9443742D1B7003
      6709892577EF3A5CBB76253939893CEA85BA7DF0E0BE356BA4D6AD933E72E420
      D304E5DECACA72EFDE3DD6D696D074F4E8A19B37AF43592E2B2BADADADADABAB
      059FF4F4B4EBD7AF40F7952B971918E87DFCF107C0055656160A0A876FDFBE99
      9D9D151D1DF5B42AB93FD505ACA0203F323202BADCB871EDD8B123E070F0E0FE
      4B972E5656569233E9F2D56EB15CD1A836B7E1D47F376AFC6F8BB574B7BFEE93
      A208D21A1515292BBBDBF3F87B695A7FAA3B22567798126EB92662EE07678C4E
      72C7B316C77F24E9A37A0B0231CA05B8E6ED6BCC0592924B9D9CEE9242CD5466
      A080B56BA57FF8618D82C211A6E9E1C36AA0897DFBE42E5EB482A663C78EDADA
      DE292C2C80D6A6A6C6478F9AC027373707FCA1BB94D47243437D860B80386EDD
      BA019E8181FE4F2B92FB939CFA93682EF0F7F7E5D0C755C205D0115ED7D6D690
      33E9F6D16FB920DDA8F45EC3E1598DA7DF6F315FDBED77FE69D903D21A1B1BF3
      D34F7BE394DE2D317AA74E5EAC4E8E126E0F6FFC35EE24353AC91DCF067DBF28
      3745F5160462940BA6DB9AB7AFFA6744CFCF058EA45043654E4B4B856ACCE282
      C34C537575F5E5CB17595C70C4C6E636E70F10921A1B1B9A9A9AC02727271BFC
      8570818F8FD7D3E284BE58C7FE0467E0022F2F0F987400C59089C3A14307601A
      025C40CEA4DB43AFE5BC74E3B1F71AF6CD6A3CFE7E8BF19A6E2FC3A7250F486B
      4C4C347041ACF2BBB556F3EA768AD5C950C2EDB1D3BB7167A8D149EE78F62C62
      69B925CE641188512E986E6BDEBE365C20FDBDC4816D5B1476ED60E768CFA6F5
      82B8002A737E4EB6BBB393B18EF6E9C3074E1F3978415FC7C7ED3E69AAACACB4
      B2B29497DF0B5CB06EDD6AE0023F0FF7AAF2F2070F129A1F3F6A6D69019F92C2
      422F57974387F60317B03F23221F28951416804F595161624C744A7C5C4569A9
      87875B6E56A6B5B525D0C7AD5BA35C4038C2DEE68E85BEAED60905A57D72F0F3
      B2F1F9202FCFD2A222D21A15152927271BA3F26EADE53FEA3689D56DA4045D2F
      3481353BCF8D53A14627B99704FA93D667114BCAAD71268B408C72C1745BF3F6
      95FE4E299B0B7E92D91E131E5AFDF02193A0B2B232A73BB779B9807CF20F95B9
      BDB5B5A3A3A3AEAEAE8A83868606EFFBF748537979B99999E9C8F3029A0B7CDD
      DD7ABABA1212E27EFEF9E75F7EF9057C060606DC9C1C0F1EDC2725F53D9B0BC8
      873FC505F9302F181C1CECEAEAEAEEEE861750D5B9B8E0EAD5CB35350F211450
      8CBB8B734E465A6D5D1D1C1A4E060618EDEDED4028A43522225C56767784F2DC
      0A8BF7EBA4C5EA56517CAF97E68255145883E39C28656A74926B24D09FB4FE1C
      B6B8D80AB9008118E582E9B6E6EDCBFEADD973AAD8BF582F51B8E090ECAE8AE2
      222E87503F1F2E2EB87B975E602D3D3D0D2A737F5F1F97BFD73D17D2C4C5050A
      0A8761CAF06460E0C183F8614F2F0FF829880B60C05F9897EBE3E33D26B89767
      4E463AE102F2ECF8F2E54B0F1F564328A8F65EF75D1B6A6BB8CEA798F3C912C3
      05E1A7E79699FD6FD932B132498AEFF5426D8726B05A9BD9E18AD4E8245747A0
      3F697D12F45DA11972010231CA05D36DCDDB97E582F638E1C2F760E033057AC7
      227E46045C00853A35358554E67B8EF646E7B4863F23D2D3F1E42CDD034D3066
      265C403E23022EF0BE7FBFACB808CAF2A3C686C74D4DE003D57E840B96F3CE0B
      F2B3B3FDFC7C8BF2721F444726C7C5961414003564D2DA9416645E40BE470453
      0008151F1F6773EB86B9EE39E633A24BC6E7033CDCE010A4957041D8E9774B2F
      BC5F2C21562C2EF0331F6802ABBA3A2758811A9DE4EACD10F81911A775D07B71
      9E1172010231CA057CD7BC7D9A4E2F5D35C56BDEEED9B36BD7AE1D1362104A74
      2E608BCBF095B319C3051D8944E09EB717D90F063E82B880B7D70B738188CF8E
      C9BC80C8BE44474741658662BE76ED2A28F8478F1E629A4A4A8A2F5C3061CF0B
      6EDDBA9199999198F8A0BABABAA6E621F8C0EB4B97AC057D46949898909D9DD5
      971ADA1960D315EC00D38DACACCCA8A84870387CF800E1029817545656903369
      BEAE567B7245F996774BA5FFBBE2C7F76B4FAF6EB5D5EB4B0B27ADE1E161C005
      218A734B4DFF41B840B85558CDF53F408D4E72C7B301B725D9F82D680482C505
      7CD7BC255C00F6026BDE6EDEBCF1B98CCD05161666136293C805237AC77CB840
      88DEF188BA3D1F2E1869027B312D1BBE066E840B1212E2618C0DB339A8CCF4FA
      F9C14150964D4D8D2F5C30B5B5B5619A1A1B1B800BE8F21B12449AA08CC318BE
      A2A2BCA5A5B9B5B5057C4A4B4B4242826FDFBE696464E8EDED49B8203838D0C6
      E60E890384D25B9CD291ECDF99165C5555595C5C5450501014443B444747122E
      78FCF81139934701D7ABAF9D2CD5DF5AA4B1BAD460DBC39B679A43ED7A4B5249
      6B7E7E1E24D1FFC8DCD23BD20567240B4E4B08B7329BE51EBBA8D149EE78D61F
      269FA286EA2D08C428174CF89AB73FFEB8F9FC7903110D9CD95C007566DF3EB9
      973408F25C5CF07C9F118D708110E3C3052208DF83BD8C960DAF2E0C382F5B26
      0EE373A003A8EA5099CBCA4A6362A25C5D9D6FDCB876F3E67537B77B4C139468
      322F888B8B214D300BA8E5A0ADADADBDBD1D7CA0BCC7C6C640F7AB572F878585
      7CF2C9879F7EFAAF989868CE1F2FC7416B7D7D5D4F59565B7A785B66544D4D4D
      5D5D2D39E2FDFBF79293130F1D3A70F9F245A01572268D210EE577B40B4C0FE6
      EAEF2E343B5C69AFFF28F25E4F593669055A016272979F5B6CBF35FBECD66CAD
      2DC2ADD86EA3C3466A74923B9EF546A27A0B0231860B267CCD5B28EFF09617E5
      931C701B970B349595CC74B4790DF6FF3E5CD09DC596B9E76BE0C3C3054DA2D8
      4B6AD97089B980F3F2E592B9B9B94007E46F87A1EC272727F9F9F9BAB838B9B8
      380704F8334DADADAD6666A6F2F2B2A9A929A4292323A3B1B11126051D1D1D9D
      9D9DE0535B5B9392920CDDEFDE75888F8F9B3FFFE3850B1740407F7F5FD85F5D
      5DDDD2D2D25395D49EE7DF9E1F08FECDCDCD30AD484AA2FF64203333E3F0619A
      0B8056C8993425DCAAF2542EB6D959707D43B1EDEE6A6FB5C7C90E3D0FD3486B
      6565A59CDC9EBBDBE7163AEDCABBB82AEFA2947023F22EA393DCF10CD55B1008
      2E2E98704C2C1740D9E7BB1A06ECFF7DB8A0279F2D73CFD7C0879B0BC66ADC0B
      B209D4B20137705EBE5C0286D9393939F5F5F5509961AC9E959519111101F5DC
      CFCF2F2A2A926982C1BFA9A93194DFECEC2CD20424D2D4D4D4C941575727F880
      6776763674F7F1F14E4B4B5DB0E0E3CF3EFB1714F9D0D010385C69690994F0B6
      42DFE6CCBBCD59CEC00250CF8B8A8A929393C3C3C30B0AF20F1EDC676D6D09CC
      42CEA429F96695FF9962E75D85F69B4A5CF65407AA3E4AB3ED7E98445A8177F6
      EEDD7D7DEDEC22B723F9B757E7DF96166E44DE854C7279CC80B624C361239BA8
      DE8240BC825CC0B5136A859009C2E472416FA170E17B30F0E1D12F6816C5C6E5
      82E3C78F420516D1C0595D5D65C78E1FCF9D3B0B23790F0F771B9BDB9A9AEADB
      B66D91945CB26CD952AE2678616A6AC434E9EA9E7373BB1F19199190109F9848
      2F0DE1EC7C575B5B139AC0E78B2F3E3B7142E1E4C963FFFEF7976BD648EDDF2F
      AFAEAE7AEE9C969FF67E2FD53DDEEAB2105947E7AC8686EA91230765647EDCBA
      75E3A54BD66E6EF72008399C8FA6FCAD6D8BCC96FEEDFC97FF6526FEF7DB32DF
      04E81C4A75BAE4E9E9616B7B474B4B034E065A0D16BEA9B78012D160724ADBBA
      FFD77EDDFFB1FFE12D87F57FB65FFF67C78D7FB9BBF5EF2E3BE6B8C8CC75DEFE
      CEDD2D7F73D8F0DFE083EA2D08C49471C1B1C30774544E1BA8AB1AA8A930A6A9
      74EA25B9A0B1B191992FF04E1026970BFA2B840BDF83810F0F17B48862A85F80
      40207E2F2E98705D33361768ABA9C44484171615E58E202F2FCFC3C5E579B980
      EB6101E102668230A55CD057265CF81E0C7C50D70C8140BC725C30B1BA666C2E
      D0D354CFCFC96E1B8BF0A080897A5EC090C21472C1EFA9773C6FDEFB1F7D34EF
      D34FE77FF9E5C2AFBEFAFC8B2F3EFBF4D37FC11ED82F4A13ECFFE69B454B967C
      2B2EBE5852527CFDFAB570BB5454CE686B6B9D3EADB873E70E49C9A5D0EBC30F
      FFF9C107FF809F6CFBE4930FFFFDEF459B366D505555B6B1B9E3E5E5C9F9C449
      037A2D5F2EB968D117CCE1A0EF679FCD5FB1E2FB7DFBE4CF9ED5343232D4D2D2
      F8E92739F6A6885A3C100AC22E5B26BE6B97CC99334A9541C72A838E56041CAA
      0E576E4ABBDC9C4B2FC17AE6CCE9F5EBD7C1A57DF8E13C217D8B3C8E16B8CA66
      DFFE3ED5EA9F49C66F2518BCF1C0801A36C337924CDE4ABF342FD76E79B1FBDE
      12AFA3F9CEB2E46E2C5CB8008C0902E79FE7249B7EEDFB44937FC6EBBE15AFF3
      46821E95A04F8D8632A0376167BCEE9B0F0CFF967A715181ABFCC3184BB85DE4
      541DCEADBB726C61A8E29B2127A950452AFC0C15A94AC5685271E72841A1A009
      1CC00D9CA10B7434977BEF82DCFBE45762BA69D422268F0BF8EA9A3DCB9CF52C
      6FD6B3A259CF4A663D2B65590967671EED302C7FC6A36B36199F11F1E502F604
      619A7001D4E4132714C807F5C4C82611AF11A5E9D4A9E3604A4A27172FFEE6C2
      0593BB771DA2A2225353932323C31D1DED4D4C8C884E0D972C0EF455543CA1A5
      A56E6565E1E5E5C15992D43B2B2BD3D3D3C3DADA525C7C8992D2297244708617
      10E4C20563081E1D0DC153A2A222E0357B5388FE0E7B9384323535E29C67C493
      069FC11AE7818AAB0355364F1F478E9C83BB9595B9A6A61A9C2173BD60405EEC
      BEFDE55E7D85B7BB5294DB2337B4052F6A0DFC68748413F4517BD8D71DB11BBB
      D355FA4B6D062ABD7AF36E93BBA1A1A10A060C4882C08DEAC9B9DD1EABDC12B0
      A1D97B51B3D74702C64B1FB4787FD2ECB7B83554A62BC568A02A84395597F3DB
      22CFCCAEBDF949CDF50F5E78E81574806273C1B4D2A8454C1E173C97AED918FD
      0201BA662FF3EC382C2CF4EAD52B6CBB71C99AEF774A613F430A5C5D20C82472
      C160BD70E17B30F0993C2E10F1EF8E85D8E79F2F3030D05BBAF43B3B3B1B7373
      D3888830A85470D3801AE4E56557AC8041FEE7E0C3D5E5EBAFBF9092FA7EFF7E
      794B4BF3D8D818286BB1B1D11616667676B6100A02922EF013BAAF5CB9ECA79F
      F67205676F0AF95B69E6027943F9F9F9FEDA18F073C5D59F2BAEFDFA389C730E
      31700EE0006EECD3D6D3D3993FFF63D2C41CF749917B7F9C526F80448FD7EC1E
      F7993DEE623DEE14FDD37366AFDF9CFE70C98194334F2B3CC17330CF1D4E18FA
      4A4BAFB4B2B2DCBD5B263434840419C876EF0E50EA7090E8B099DD6937B3DB59
      ACE73EC5893362F729D8D969FFA70E9BB99D7797F704AB0E160490DB05171E66
      B83CCB686EFDB199F5C7C41A14A9260DAAD9906ABB4475DA402F8A5F28BA091C
      C00D9CA14BBD0295AA2EE6B46706F99598F0B11C62DA72C173E99A710B9CF1D3
      3583F20EEF590B0BF3710DDCB8B8202E2ED6C1C18E6D1E1E6EC4844C10B8BA40
      90C9E3823FCE3AA58C8942DC5C85DDD0507FE9D2C5F6F6765C855D4B59495DE1
      F009D95D5CCBF8C0E689BDBB35148E68AB9E0137707672728C898986326B6B6B
      C3C5058435C0D3CBD9292F330382D33F9DEFB23779CF8A2F177085F2F6F62CCE
      CB8D8B088B0B0F2BCACB8573C8CD48F7B8EBA8794691970B162CF8044E954D5E
      3F57F8DBDFBE69A9A7C3BE46E6D2AC0C74E128E929C9E0F9B4D81FFAC21C73CD
      1A2998F8D0ABE4858791204FF2FD7B8355BAEF2DDB071D796E14FB76EDDFBDA3
      FBFE7270862EE47601A1A49D9728B7FA57FDFE99F507C51A4F508FB5A836734A
      940C821B384397FA0354B1FE5FC3E487BFF831E16339C4B4E50241BA66555555
      827E914893205DB31F7FDC02E39F9B37AF8F6BE006CE6C2E484E4E668A3F9709
      99207079429071B9E075D2B21185B8057101576137D73D273C94A5BE2EE9626F
      6F1B1D1D0583675BDB3B4B967CCBCB05505A5B5A5AFAFAFA20786F6F6F0B07CC
      26EF5909E10226948B8B13FC247FF2D0DFDF0FE700A19A9B9BCD75B4B9A6336C
      2E60AEF1972A3F208EDADADACACACAB2B232F65AD6B0A7AEAE0E8E028C039E4F
      8BFDE06EC0BC80E102F85D25419EE4FAF5059FE9F5940042117EAF805F7ABDBF
      EF0B517992E74F6E57484870AAB178FDF5AFEAF7CCAC97136B52A05AB4A9CE2B
      220DBDC00D9CA14BFD5EAAC6FCDDD0FDC35C30E16339C4B4E50241BA66C38235
      D914978D3609D035DBBEFDC798981878D78C6BE006CE6C2EC8CACA0C0A0A7C49
      8320D38D0BC6256E7E9F110117D872157673CEE48BFFBC407617CD057A3A1616
      178038ECEC6CA08B99193D2FE0E202A8C950C08135DADBDBA1B442F09CF43477
      477BF626EF5909FA8C881DCAD1D1BE30273B2634382634A4303707CE01E6056D
      6D6D4061BC5C403E2382B13D738DBF54FBC269343636AA1D3D34665E20BB0BEA
      36FB849F16F9924FCCA4A5570217904F2F499027D9BE7D414A7D3EE210046E88
      A07901340159F4FB2EEB0B567E92E3476E576868708AA944FDB5AFEAB7CE6CD8
      21F6E820D57A96EABE315CBA05659034811B38439786ED548DD9DC9003C35C20
      682C376E40D4A845707181205DB36191824C8ACB469B04E89AEDD8F1635252A2
      9797E7B8066EE0CCE68282827C9889BFA44110215CF04A4310171076E6FD049E
      6F13EB79812D576127F302A88DBCCF0B182E00B7888870A88A515191D05DD0F3
      02F0ECEAEA825ACD04676FF23D6141CF0B98500E0E76FF6909FDF5E195FF3CBC
      FC5B7310A11568020721CF0B986BFCB5DAD7E3AE03FCF642197F1232F34990D8
      93208AFE1932F369E41CF609FF5CE40B27CC7A5EB0332C2C84047992E9DB1F78
      BADF5782E1024E903146B800F805B8009C9FA47B91DB0541922E2CAB062E583B
      B361A3D82339AA4D93EA6171016F28A609DCC019BA346CA0CA2FCC0918E10241
      63B9E182CF6F2CF74A6BD422268F0B04E99A9182CFD784EB9A9D3F6F2023B34D
      44036736175C98204C372E60E447456962E60550C6B90A3BD443E15C60A177CE
      D8D83030300086E8A1A121A6A6C6501E79B9801ECCEBE9F4F5F565A7A630C1D9
      9B7C4F58E0BC6024141CF43FCD21BF3CBCFA4BF5C5FF3479C1666672526F6F2F
      9C95102E60AEF1976A1F4F27C7CECE4E18B10F04CD1C08101B08A0E89F413307
      23E6B24FF849810F9C30CC2956AFA63F23022E80213D093290EED313A8DCEBBB
      8C7C4604659F13648C31F3825E5FC96EDF137D0F9CC9ED0A09094A3491ACBCF2
      65F9CA99156BC46A76538FD4A84E1617F086629AC00D9CA14BC56AAAD464B6FF
      BE612E1034961B2EF8FCC672C34DAFA6462D62F2B8E0B974CDC6E817BCCABA66
      AFD96744E312B7A0EF1171157628AAC23F2332D7D13630D0F5F6F67272720C08
      F0072AB7B5BDC3775E00A1A04AA726C443F08CE42437077BF6A6E85CC00E453F
      2CCECC880A0E0A0FF04B4F7C009BB0139AE0AC847001738D3F57BAC169102EE0
      FA8C08F6B04F7830C70DEE06E102F23DA2A0A04012A42FD9ADDB57B1C74F92E1
      02219F11F5F88A77791EE989B125B70B22C41B89575CFEAA64F9CC5269B1AA9D
      54A30AD57153A48F74C00D9CA14BE92AAAC4788EEF4FC35C20682C37FE6744AF
      A6462D62F2B880AFAE99485CF02AEB9A4D9F67C78C4A352F174019E72AECE602
      BEAC35FAADAD7367F5F575BCBC3C929212FDFD7D0D0DF56D6CEEF03E2F80CA0C
      A17EFBEDB767CF9E4170F8F91B07CC26EF5909E10226948B8B1309F58C033807
      B269A67356D0F30239B93DCC353E2D7572B5BD03FE7C7FA5C91926C6D00F8807
      329DE06EC8CBCB122ED8B973BBBFBF1F09D21BEFD4E975ACC75B7CDC67C76A47
      0FF5782DE9F438DC137587DCAEC040FF3883A5159746B840866A50A63AAE89F4
      A817DCC019BAD05C6034D7476E980B048DE5C67F76FC6A8EE51093C7057C75CD
      44E20201BA6613A54DF662262217BC187DFC11BE53CAAB65234AB2D8FE1A1A6A
      DEDE9E50C06362A2BCBC3CD3D252A152656666F8F8784351151E0AB800FAA6A5
      A5E5E666A7A7A743170802A160278425C1B5B434A090822729DA4CC5666FF29E
      15A3BFC35C206FA8E4E4243617C039305C006EE04CCE8184022E80DA7BEDDA55
      E61A9FD484B8DADC16CE050FA222C1B3AF84FEEBB0EBD7AF9A9818050707EED8
      B10DEE0F09D29317D21167D119AB00A55EF8BD0287CE98A3EDB1E6DDD901E476
      65676746692FAD70FAB1506545918664B9A144ED3589162F095132086EE00C5D
      8AD4254A6E2D77DB31CC05D36D2C87983C2EE0AB6B2648CE4C145D3328C81325
      4F268A999B5F605E4F01173CAF8AFD8BF51274267CB56C4479E37375090B0B81
      790194D6D0D0E0DCDC1CA8547979B96161A1A2700174C9C9C92E2929CECECE82
      38292949100A5E30C1CDCD4DAF5CB9C41470A662B337F99E15D1DF615F2057A8
      BCBC1C3617C039904D9838801B38B3432D58F0497474A4939303738D030FA3C6
      9D173C888E02CF9E9228B81B300B003A888D8D9691D95E50904F8274E645B5C6
      DF6A8DD610850BC0AD25EE46674E38B95DB4AE9C9A7899AB7CCEB9EDB97A5B8B
      4CB754DED8D2E8B145940C821B3843975CDD2D45B61B1D360C73C1848FE510D3
      960B265CD70C0AF284C893BD809CD95470417B9C70E17B30F011A4772CDC5E4C
      CB4614E2E6EA121F1F272EBE242B2B332E2EB6A8A8102A55616121ECBC75E522
      FBFB965CCF0BD48E1CBA71D12A26263A2F2FAFAAAA126A23BC8620C005108709
      7EEBD64D4747FB9B97AC5DEEDC4A888A84E0F111E13020676FF23D2BA2BFC3BE
      40AE50A5A5252971B1617EBE213EDE0FA223E11C228302EFDEBC7EE3A2A58383
      DDAD5B37D8A13EFB6C3E0CE3BDBDBD986BEC7B18E0E7E90EC4C1FB9D52D8038C
      0347494F4E02CFEEB200B81B3035003A484949DEB9734759592909D2591CD092
      7AB1395ED154F79CB0BF3593DD65A2ABFD38EE44739279478137B95D2525255E
      0ADF96B81DCCBFBCA6E0CAAAE2DB52154E5275BE52A26410DCC019BA145C1916
      EE21BF12133E96434C5B2E98705DB3E7E202B66C195122E0DD33D95CF07C7AC7
      1D8944E09E8FDE31673F18F808E2023E7AC7CFC305A26BD908B7B4B454098925
      304C4D4949292D2D854A05650A5EC360188AE7FDFBF778BBDCBBE7EAE9E91114
      14141F1F4F86B859595971717130A1F8F6DBAF2120E309DD210884E20ACEDE14
      A2BFC3BE40AE50D5D5554F5A02061A1C06EAEE0C363A0D34DE27E710141408E7
      0667C80EF5F9E70B80A7D8A7D155E1DD9E6FD59675AA2D4DA62DED87F6F4D5ED
      E9D2F4CF8C751D593B3BF34E759558F5D6F88267478917B91BBEBE3E70B13BE9
      3FD3A82441DA0BBD1EA55834C49C6C8CDAF128765D4BE2EAB654694E9C6183CD
      9644E947B16B1B22B7D6471E6E88D77B9C719BDC2E20143B9905255E270B6CD6
      16D84817394897BA4A57794BD785483F8AA17BF10F15433B801B384317E84884
      7BC8AFC4848FE510D3960B261CCFC505EC952548F1E7DA33355C2064734880DE
      315BEC9E6B938FDEF188BA3D97D83DD7E6B85CB060C1C7507B5FFECFF1F2F3F3
      162FFE064A536666268C752B2B2B8A8B8B33333360081D1E1E161C1CC4DB0576
      86868644713E4ECFC84887CA063F13131F1417172D5AF405FBACC01382C0B89A
      2B387B93EF212008D7057285EAAE0EE8AA706F2BB269CDBFDA967FB535EF1A39
      07382B3837764C08B270E17CA8C09CBE19C03E6DC581AD051E8F33AF3724EAD4
      459FA88BDC571B215B1BB187B648F9865885C6A473CDD937DA4B3C3B4A839A73
      EFC311E16E444484C37460CB960D353535E4E49B325D6AE3ACAA43D52A830E55
      07C93D0CD9531BBE67380EB1F03DB0B32A48B622607F65E0A9AA709D9A184B72
      BB2A2ACAAD57BE57E8AD95EB209BE7B027FFEE9E42D73D25EE7BCA7DF75405EE
      11182A9076003770862E74470F15BD05C36FDE091FCB21900B7E172E20C5BF72
      045CAFA76C5E30E95C30A26E4F177F96D83DD726EA17201088DF8B0BD8EB9F8F
      B304BA80C5CFB9D63F7FDEE705840E6AC6E2798960C2B980BD730C1774671181
      7BBAF8B3F4EEC926F9093E3C5C30AC6ECF29FE4D5C9BCC4EE4020402F13B72C1
      F0FAE7E32E812E60F173E8C85EFFFC059E1D133A681CC10B10C1843F2F10C805
      3DF944E09ECFF302CE4EF8093EDC5C30A26ECFE779016727691D970B44948011
      4523862337B34C5E7EAF969686A1A181A6A6BA9C9CECF2E592B01F5A85C8CAEC
      DEBD5345E5CCB97367CF9C51DAB54B06F6C07E7617AEE0E7CF1BE8EA9E53563E
      ADA4740A8EA2AD7D96AD9BC3F758824255852B57069F28F3952FF3D95B1E78A4
      22E8B8A07320366FDEFB9F7CF2D19225DFCAC86CD3D6D6BA7BD7E15196736D82
      6589977CF6CDAF92CDDE4E3CFF26588AF9DFB26F7D5DEABDBF3EF1D2A36C5707
      077B2D2DCDAD5B377FFBEDD79F7FBEF0FBEF25646577ABABAB1A18E8C139ECDB
      279F603C3F5AEB2F51EA3378356818F59958AD3762CEBE9560342FEDEACA3C27
      79E676DD5496B878E893D0536F102D1B21723682846C8468D94CC8580E316DB9
      6074FD73AE25D0B3663DCB9FF5AC78D6B3B259CF2A3856C6D9CCA79BD88B9F43
      47F6FAE7AF3917F41612817BDE5E6427FC041F1EFD8261757B3E5CC0D9495A45
      F9FB02412A30CF651CCDFA45A6A6464E4E8ED1D1916969B4BE8C102D1B5E5919
      B6FCCDBFFFFD15BB0BE34982A7A7A7C6C7C70604F883C18BD4D41421BA3982B4
      6C48A827753E830F9DFA4BADFA4BADE1056C0A0F452478CE9ED5B0B6B6F4F6F6
      24123C837541BDB9869D093BDAC3BF6B0DFE17587BC4E2CE0499DE5CA32775C3
      0F8BBDBC3CACACCCB5B535B5B4D42F5C3056555566EE124D289E1B1B9DBE6E74
      FA48D878C90D5ABF6EF6D9D816ADD29D63C3DC2E8773EBC24FBD5D7BE32332EE
      7AEEA11767CCC65FCB6682C6728869CB05A3EB9FB397407FF086F0EFA48103B3
      F8397464AF7FFE629F11758FC5547E4634EE5383315CD05FC196B9A727023C9B
      E0C3C3056334EE39C59FCFE61F59CB4690420DDF754AB904686263635C5C9C5D
      5D9DE3E262851C4B242D9BA6805FAA2EFF5275E5D74781E386D2D3D3E195E0F9
      B9DA7F304DA53F6A595FD09C3EFF3FF5F9FF575FF0DCFEA8E583E9AA3F570730
      520E64010A303B3B5B63E3F3454585CCE15A2E493C369ADD6232B3FDB258971D
      D5738FEAF5A2FA7C698317B0D96527D67E6D66EBC5396D3725BB7CCE0C647992
      BE2121C161FACBB2CECF61B46C86E56CCE53ED972901A1E82670204236758769
      E3AF6533416339C4B4E582D1F5CFC912E8F7A821BFD1656F05FF013BC7ED1EA7
      8BED98F5CFA120F3CA9309324B132328FBBD23E07A0DAD22C62172662FC90582
      BE593A56E3B28C2D73CFE793A2AE22F011AE6BC66F76F052BA66C2899B970B04
      69D940D515AE65238AAE19537E7905688AF3F318691B5E313241FA052F1C8ACD
      058C8A0191BF31D73D07577A72EFEE93727B88900DC421E20544CA8188178039
      38D8999A9AC0AF3D73C9AD1797B598CC69B79EC9F78F0B98DBD579736EC79DE5
      DD3EAA83B9A3BA6669C6CBD85A3644CEA6DD82129E41702042367572B4F1D7B2
      99A0B11C62DA72C1E8FAE760D7388CE036BCD46195000C2F72E8C671BE467764
      AF7F0E0599579E4C9041C1EF1B01BCBE6C61C6B547C43844CE6C4AB8608CDE31
      3F2E185FEF7832B84044211BE15A3630C0860AC9D679610BBE102E1051D70C3C
      A1BA4212613AC016A0215A36508DE158A273C18B85022E202B9DB2550C72D2D3
      9A9B9B19451B2E211B46CA81B318D14AC2052626C6A5A525CC25B7994BB499CC
      E9BC3A93AC41C717C005DD36733BEF2CEFF15419CC1AD5354B3591A8BFB188D6
      B2D92BD67494026BD1A23A2F8D33F402077003E73A19DAF86BD94CD0580E316D
      B96074FD73B00B1C46B0A3867CE8DF25411DE9261F8EDB254E17A331EB9F4341
      16224F2644AD8C2894F1EE11D1E0A053F177C763B980AF8DCB0513AE772C9CB8
      057C46C447CB464E6E8FDAD143D5D5D5BC7160277001BBA80AD23563CA2F1470
      A8D88E8EF6030303E4A33F78011D61A7BBA33D1C4B94CF885E2614E102F22913
      A362005CD0D6D6D6D8D858535353CD01BC80CDF6F676B6DA02112F002E00C624
      5CC05C729B91789BC1ECAE4B341708BAED30B7EAB93DB7F3C6F73D6E2A83E9A3
      BA662926E244CBA67EBB58D33E0AAC4595EAB21A67E8050EE006CE751B69E3AF
      6533416339C4B4E582D1F5CFC10C38B5FD1ABDB0F938734C278EDB054E179D31
      EB9F43419E1079B21790339B0A2E18AC172E7C0F063E53CF0542885BF0F3026E
      2D1B180C0317080A055306765115A26B46CAAFA79323F48271353B0874849F1E
      771D9EEB79C18B8562E6056C1503E0024117C8565B609E17C01E6363A3929212
      E692DB7425DA3467779AD25C2028147041F7A5399DD6CB7A9C9407534675CD12
      4D25AAAF7E59BF7666FD7AB1A69D1458CB71AAD3689CA11738801B38D7ADA28D
      BF96CD048DE510D3960B46D73F07339831643263C87AC6D02DCEDAE6DE338682
      670C45CC188AE2580467D39BD3748BE366C2E9A23766FD7328C813224FF60272
      66D3619DD209795E2048CB46D8F3028E1024BBA80AD13523E517AA3411A029CC
      CD890D0B8D090D29C8CE22D5186ABB28CF0B5E32147B5EC0A8181031050BBD91
      E7057B7713F182FB763644BC804839102EE0CC0B6C8D8C0C8B8A8A984B6ED45A
      D6A034E7B1A6D0E705B2BB5ACECF7D6CB2ACCDE6746FC2A8AE59A2C932A26553
      BE4AAC6A130556FB132D52233C83E0006EE05C26491B7F2D9B091ACB21A62D17
      8CAE7F0E66F6CE90E53B4397DE19BAF1CE90DD3B434EEF0CDDE32C72EEC13177
      CEA613A7E906C7CD92D3E5C298F5CF2FFCAE10BDB0BF36FA052FF33D222E2D1B
      DEA2CA3B441745D78CED493E2A7776768217E47B959C454D8D45E402AE50BF3C
      F47F5270E949BEF5CF555EE38662B880AD623090E9D4137CACFBBE7897C39C4E
      9B3F81C10BD8EC093AD29F66CB483910F102F23D223D3DDDBCBC5CE692EB9425
      6B0ECCA93D3CB35155ACD9906AB3A23AAE539DB7698317B0D96C28D6A43EB3FE
      CC9C86B392CD574F74478CEA9A25184B122D9B92E56265AB29B0CAAD54CD7E5A
      A7464028BA091CC00D9C8BC569E3AF6533416339C4B4E582D1F5CF89D9AF1B72
      5837E4B46EC865DDD07DCEF2E6601E1C23AFEF739A9C386EF6C3BD50CBE655E4
      025E2D1BA899C2B9805D5485EB9A319E2E2E4E308F7070B087B171707010740C
      0CE47F2C415CC00E3598E7D91767D11B6336907D6FDC50840B56AC909495DDC5
      48F0F43D70EC705168B65EFA486F7693C69FC0E045B3D59276A7C3BDB177188D
      1E88292DBD12B8C0D6D6465B5B2B2B2B93B9E4DA93E2D5B273AA76CC7C282F56
      7B84AA3F45ABCC40C5068317B0597B54AC66FF4CE08B7A15F1C75647BA8258BA
      6686E244CBA6789958E90A0AAC7C1D5DE71FCA51FC431DA19BC001DCC079980B
      F86AD94CD0580E316DB96074FD73C6DC1487DC39CBA18379F218D9EFCE711BE9
      82EB9F4F0DF86AD93CAF09D1B2B97EFD2A97280C97AC0C5B1A867411A465C378
      262727C1A03A2E2E363636263B3B8BD33193EFB10469D9B043F516457726BB76
      24BBF414848B128A89C048F0746505350759D6D92B545FDC5469BA120C5ED4D9
      1F7D1C60DE9519C068F410211B30B8C0B36735ABABAB984BAEBEA25066B8A944
      7B45A98E64991EAD2F53715EA2C28863E7E9CD327DD8BFA2DC7853F5B5A38D1E
      661DC901A42F100AA365537046B2505902AC484DA25853A2F49C04FF507A7413
      38801B38179CA68DBF96CDF418CB21268F0B46D73F7F09C3F5CFA7067CB56C5E
      C00469D9C0F0954B14864B56862D0D43BA08D2B2613CF3F2728A8A8A52535352
      52920B0B0B851C4B90960D3B545741424B926F4BA277677EBC28A1D81188044F
      5B7A587DE0CD4A5BCD228BFDF9863BF2CFEF801715361AF5FE37DA33C2198D1E
      67675AC8E6FAF52B7097CE9D3B5B5F5FC71CAEECA646A1E9FE5CBDEDB9BA5B73
      75B7E4E9715BAEDED63CFDED8517F697DFD4A8F3B9D1961141FAD25A36AA4B89
      964DF6D9ADD95A5BC072CE6EC939B72557670BFF50BA741338801BF107E3AF65
      836339C4CB71C1E8FAE72F61ECF5CFF7ECD93551829513188A79ACFC4A7F46C4
      57CBE6054C90960D0C7A1D1DED6FDDBAC9DB85C8CAB0A5614817A89C100A5E08
      F22C2D2D292D2D853A0C282B2B15722C415A36EC509D45E12D996E2D196E9D25
      91A2842211605AC148F0B46679D6479857DC3B5E747B5BFEE5B5F957D616DDDE
      5E71FF04EC6CCDF666347ABCBC3CEEDE75009681BBA4A3A3DDD4D4C81CAED25D
      B1E8CE8EFC2B6BF22EAECABB28C5CF56412BF854B89D6A88B26ECF0F227DCBCA
      CA7C4E8A97B81F12DA777CE3AF65836339C4CB71C1E8FAE72F61ECF5CFA1804F
      947EE5C4867A0DB8E077D4B211A45003412424160BD1B2A9AEAEAAA8A828A091
      5F595921E458A268D9B417073567BBB464B97494048B128A4B82A725DBB529E5
      564D984E99C7C12287AD1C4D99B5458E5BCB3D0ED784EB3D4AB90D0E8C3E0EC4
      0496810B3C7B56E3D1A347CCE12A7D4E163BED28B059977F7B75FE6D697EB61A
      5A8B9D642A7D4FD5C759B615F892BEF0D379DF77A53EA785F61DDFF86BD94CD0
      580E316DB960C201557742342E21C8C4866273C18B3D6EFEDDBF53FAFB6AD9F0
      55A88120DF7DF76F0828C8130A208C8761540F565E4EFF91AFA0638DAB65D39C
      1FF038DBB321C5B121E5EEA36CCF96FC00120A1C048522123CD1D1514482A726
      F67275A44579804E91DBC97CA7FDB90EB260F0A2C8FD24ECAC8EB20407A28F03
      5D80622222C2E1024F9D3ADED4D4C45C72A9AF7A81CBE13C47B95CFB3D820C5A
      0B5C8F94F969D6C45E81530516032EABADADB9B1E5F3225F1DE17DC735FE5A36
      133496432017FC5E5C60A0A6C265E372016F17DEEE93C405CFAB62FF62BDF097
      1381404C311770AD7F2EC8B8D645AF8DE2D8C85AE89E7AE26E3A922FCC05ECC5
      5244E402416BAD4C3A17B4C70917BE07031F417AC7C20DB9008140FC8E5C30BA
      FEB920E35D17DD8736662DF462B3BF78E8BD3817B0174B11910B04ADB532E95C
      D091C868DC0B32F099242EF87DB56C44ECC2AB65A3A7A7A3AAAA0CA6A7A77BFE
      BCE1B8C71214AAC4FB4CC1BD2359365B336EAECD75D856E27DB43C50494D4D05
      92CB57CE86D1DFD9B54B4659F9F4B97367F3EECAA55E5E11AB3F2F5CE5CF8CA0
      4C8432AD3B9362F1619EFDCA126F796D6D2DA23B2329B9F4F3CF3FFDF2CB85D2
      D22BF7EFFFE9EC594D0303BD7CE7FD695756D21194DF221118630BD3C4EBBE99
      7CE1EFD9B7BF29F53DD49074C5DFDFCFC1C14E5D5DEDAEEE862BC73F0F557C93
      DD91D7B8346EE2756963746D2E1E78CF7C1F7F2D9B971FCB21A62D178C59FF5C
      90F1AE8B5EC4B191B5D05B1CFF91A43FEF85B9A08F0511B9A047005E800BB856
      25E5DA1C12AC77CCD638666FF2D13B6689DDB3F5EEB9365F092D1BDE2E226AD9
      0406062424C4A5A5A50A3996702D9BBE12EFEE1CDBF678DDB6A8339D497A7DC5
      7683D5DE82E46C2014AFFE4E77F6EDB648E526B70D75B68B1841997A3B5A77A6
      2D6C6377BACA40850D5BA6474343156CF3E68DE4044622A88C46E03F5EFAA0C5
      FB93B690C59DF132BDB9C64422272B2BD3D3D3DDE5FCF6C833B36B6F7E5273ED
      83171E7A459EA2AC0EF0D3B29988B11C62DA72C198F5CF0599D075D161E7A0EF
      17E5A67F79459F1770C9993D171790FACF7ECD9F0B5862F7C3F57FEC6B62A865
      235CCB06FA0E647AF604E8747A1CEF8DD07D5AE22D281A04F9E8A3797056DCDD
      33DC3BDD949ACD241A55670F0BCA28893D3A4BEBCE747B4A0EA69EF9A5D69389
      49962AB5B2B2DCBD5B263434846F84BA2362445FA65E812D4C23D6E5F8A75EAF
      B9FD11632472206C98E1F22CA3B9EC8EBC3636142D67D3ED4C1BA36B936B22E6
      7E909F96CD448CE510D3960BC6AC7F2EC804AF8B4ED6427F16B1B4DCF27F5E8C
      0BFE08DF2312A45CC0870BBAB3D87AF763940B46F6830F0F178CD1BB1FA35CC0
      6A9A702EE0BB4E9D702D1B416B50102D1B2B035D222B238A960D09EEEDED999C
      9CE8E6760F2C39398911A0B1D4D361D6C11B57BF8039CFC19CC09E00832E4FC5
      BE68C39FAB8278A3B1B9002E93BB7BB67FE73D9566A3658DA7E60C0BCA9C146B
      D6F953E7CDB9EC4B2331E13767CD1A296B6B4B59D9DDE1E1617C23D4C98B117D
      99FA03A3C2348CF40F97440E104ADA7909A265C374E4357628BEBA360F6FFC35
      EE243F2D9B8918CB21A62D178C59FF5C90095E179DAC85FE2C6249B9F5DBAF2E
      17089A11F0E1829EFC5F3BB219630BDF33063EDC5CC091B6678C2D7CCFB6C9E0
      025E5D1BE15A3642B880D17CE9EBEB1345CB860487E9405252E2FDFBAEF7EEB9
      C20BA22C064118351951B88039CFC1CC801E2FFDEEFB27FBA30D7EA90E247236
      4C34415C30DA3DC3AFF3EE99661D89C6A37386056514C45A75FED46D43730173
      69442287489B112E80213DDF08753BC588BE4CBDECA8300D5C115F899C9090E0
      5463F1FAEB5FB13BF21A3B146F0661E763A777E3CEF0D3B29988B11C62DA72C1
      98F5CF0599E075D1C95AE83F872D2EB61AE502D1352E856B564E6CA8899917F4
      16FEA72B8F18572F663FF8F0E8173433C6A36836DA34195CC0AB6B235CCB46D0
      67445066A1DE363535B5B7B7F7F7F78BA26543823B3ADA27263E707575B977CF
      05B8003A0217B0D564847001AF2AD940AA7F8F9B6EB7D389FE08FD5FAA02899C
      0D138D8B0BE0ACB8BBA7F876DE516A56176F949F3D2C28B35FAC556366CFEDB9
      96FABACCA511891C604669E995C005E4F7906F84BA4D62445FA67EDBA8300D5C
      115F899CD0D0E0145309A265C374E4357628DE0CC2CE66E7B9712AFCB46C2662
      2C8798B65C3066FD734126745D74D8F924E8BB42B3512E105DE352B866E5C486
      9A98E705FD158CCCFDF08C60EC6B30F0E1E1825199FB110A18F39AD864700117
      718FAB6523840BD8A144D1B221C1E1FE335C002FA023D4467628E15CC0A54A36
      90E4DFE3ACDB6D77A23F48EF97F2002267C380970BB8BB27FA76DE38DDAC24D1
      28337B5850669758ABE2CCEE4B732CF574984B1BE248E4B09E17EC0C0B0BE11B
      A14E5A8CE8CBD4FF302A4CC3A571C348E44090A40BCBAA810B581D798D1D8A37
      83B0B3C1714E94323F2D9B8918CB21A62D178C59FF5C90F1AE8B1EC0B191B5D0
      07BD17E7198D7281E81A97C2352B2730D4DEBD7B26E67B447D656CD57BF29A6B
      137C04E99AB1D58D7937A7EC7981102D1B819F1171B46CA06012591951B46C48
      7098173C789070FFBEABABAB737C7C1C234023CAF3025E55B2DE04BF7627FDD6
      DB27BB7C749F14F8F046E39D178CE91EEFD37255B9EEE4B2AA2D73860565368B
      D51D9CD9727E2EFBD2484C226703F302E00218D2F38D50B64C8CE8CB944B8D0A
      D3102D1B5E899C9090A0441349A265C374E4357628FEBA3636B3C315F969D94C
      C4580E316DB960CCFAE7828C775D74578E8DAC853EE0B6245B6FF4D9F184685C
      4290090C2527B747F8F30221F8E3EB1D4F132D1BE8DB13E3D16A7BAEF9EA8976
      97B3FD29AE82CE9C6B5E30DA3DCAEDF145C59A6392E59BE60C0BCAAC11ABDA41
      EBCEB45E93EC0D39F1A4C8994BDA8C7C8F087E8BF8462896101BD614F89E254C
      A32AD6623CB3FDC69C2ED7311239B47E819138D1B2613AF2DA98501C8D9B5673
      DA185D9BAAAB738215F869D94CC4580E316DB9807BFD7341C6B52EBA1BC746D6
      42EF0F934F51FB2BC30513A2710941263094BCBC2C72C1ABAE65037DBBC35D9A
      6F693EB65668B555EB89B61774E66C2E18D33DD4E991C5B11A05F1E14ABE4CAC
      74A558C5465A77E691A178BBF391FE246E6933E0829D3BB7FBFBFBF18FC09474
      4996308DBC58DDF1994D9AB39B2DC648E4C085C7192C1DD6B211CC056342118D
      9BE3B431BA36155673FD0FF0D3B29988B11C62DA72019FF5CF0519EFBAE8236B
      A1F7468EAE7F0E057CA2042B273014237FF9B25C30582F5CF81E0C7C268F0BA6
      B3960DF4EDCC087B1C70A3D1C3EC71E0B5AE8C2041670E41800BE0ACB8BBA787
      347A58545D5228D1DD342C28A32259AC49EBCED4DE3EFA38C0AC3B2B801DD3C4
      C428383870C78E6DB0475004A22F03362A4CA323596EB8A2DA6A539DDD18899C
      ECEC315A364C475EE3D6B831A08DD1B529B359EEB14B8096CD4B8FE510D3960B
      A6DBFAE7AFF43AA5D35CCB06FAB667C5348639D5F95C6F0C756CCF8A12140D82
      7CFCF1077056DCDD33A3EAFC6E95DDD42830D93F2C2873766BAE0EAD3B537187
      23679315C18E0974101B1B2D23B31DA6960223688DAACC0C0BD3E86ECD33D8CE
      2B91436BD9A8897369D908325E8D1B46D7A6D86EA3C346C15A362F3796434C5B
      2E986EEB9FA396CDABAB65037DDBF3831E3DB8D31065DD9470BBBD3058503408
      F2AF7F7D04FBB9BBE70534445F1C2B46C35F7786C4043A000ADBB973079CB9E0
      0802B46C7824724A4A4ABC14BE2D713B987F19B56C107F382E986EEB9FA396CD
      ABAB6543AB9215F83425DF6888B5684ABADE56E827281A0459B0E063382BEEEE
      F95EF5711663C568D8BA33166D053EEC98BEBE3E40763BE9EFE4570A8EC0476E
      864B2207EE52565616108A9DCC8212AF93D0FAC24236A8658398242E9870FC31
      352E99BF2F78A531095A3619C5C5C550AB8B8B8B3232D245D3B219D345A8960D
      EDC9F9E3E252288660F082A308C3FF5842B56CE850CDB9BE8DE9AE35F1D71E46
      59D6C65F6BCAB80F7BF84623A1E0ACB8CEB931CDA53ACAB2D447ADC0E5102328
      C3D19D395CEAABFE30CAAA29DD957D372222C2613AB069D3FA9A9A874222F031
      B6444EA4054CC1D2D3D32A2ACAAD56BC5BE8AD456BE8A0960D621A70C11F59E3
      1281402010BC5CC07FFD73B2DA7918BDBC795DF4ECFA58DAE005BDDA7918DD04
      0E6C7F880071182E18771121410B8A4EC17A4408040281E0CB05DCEB9F33AB9D
      DF9DF7D86D5E8BEFBCD640DAE0056CC24E6802077063BA4004D1B90058E03F1C
      08A703415CA0A9AC64A6A32DC4C0E175E58289D2B2F9F0C3798B167DB165CB46
      6D6D2D4747FBFBF75DEDEC6CB5B434366FDE00FBA15588ACCC4F3FC9A9ABAB9E
      3DABA9A6A6222FBF975792862BB89BDB7D6767A7EBD7AFDDB871FDDE3D57D81C
      F7584C9CAFBEFA7CD3A6F59A9AEAF6F6B68DA9B7EB932E55069D2C725D57E4BA
      A622E87843F2E5C6B43B42A2719D73C1FD23052EFBB36EAD49BEF06182C19F13
      F4DF483C4F813D307833F1FCDFD2AF7C5BECA1501B7FB92E6934E637DF7CFDCD
      378BD837EA61CCC5C27B4792CCBF89D2FC5B84F29B516A54EC592A418F22A1E0
      056CC24EBA49E3ED24B3AFF35D0F56475B3A3939DEBA7513EE9883CEFA2BC716
      7269D9849EA2C24F538242411338B0FDCDE5DEBB202754CBE625C6728869CB05
      7CD63F8FE0AC761E3FEB59EAAC6739B39E15CF227FAB0E2FE8CD54BA89768818
      ED0211208E285C2048C54C742E806A5F2A14E0F0BA72C14469D99C3A757CE9D2
      EF2E5EB4F2F3F3CDC9C9CECCCCC8CAA2BFF36F6D6DA9A9A906AD82B56C8C5D5C
      9CA2A222E3E3E32222C2A1C4999A726BD940772D2D75263844CECFCF4B484878
      F020A1B0B040F8B1D817C8C4210F70A1E393BAE0BE22F39ECC633D19C7FB8A2D
      9FD4870A89C6D2B2193EE79E02A7EE9CDB1DF1EA2D819B5A7C16B5F87D343CC8
      F1FFB8C57F715BD8EEAE74F381AA3131B5B535CF9DD3825F1EE646F557047726
      993EF6DDDD70F7BB06BB8F058D97A0A9E1EE6270EB4C36EBAF0CC9C84827315D
      8D65682D9B1B1FBFCCD02BE800C5E682891DCB21A62D1770AF7FEEF9C690F71B
      43019CD5CE13DF18CAA1173C27C3787AE9921CCECE708E8337C799D30B22409C
      71B980AF36A5203A10C205959595822605A4E935E68271FFEE985977488891F5
      8860A07BF5EAE5B8B8D8C4C484D8D8982B572E1D3AB45F4AEAFB458B3EE70DF5
      D5570B57AE5CB67FBFFCC58B9611116150DCC2C242ADAC2C60C44ED6A6638293
      45842014099E94F42039392929363A393626252559D0B178FFEE982B0E74FCB9
      26E0499EAECD25EB3B17AD9FE4E9FD521328281A0945FEEE987DCE03D9EE3D21
      6A9D2EDF7739CEEEBEF7FF900BECBE37B3EBEEDCAE7B52BD11E79E148E8949D6
      AC9693938D8E8E22E7309817D0E5ABDD7A51EA91CEDCC7DA335B4CA98E1B54B7
      CBF03A3FF002366127348103B875F99D1BCC1B8E097C14612C9D6DF42EAD6533
      56B9E69126252814348103B8315D52D5C59CF608D6B279B9B11C62DA7201F7FA
      E776D4D05D6AC89D1A0AA2861EF05BE1F601A7C99DE36637DC0B2214E9FD8F28
      5C20A21299702EA8A9A9E12DF8429AA60F17B0895B3817888B2F717474B876ED
      0A8CF0434343A0D041F53B78701F5351B942F1566652308150805678B8603978
      92E0E1E16125F9F9CF382829C8E77B2CC15C301A073AFEDA1018E0E1F61B0781
      9E1EBF3604098AC67001D7393FC90FE88BD0EEF194EAF59A7B427617B94078D1
      EBF56E8FE7AABE489D278563620217C0C4445E7E2F70013987C19CC02E2FED16
      8B958FCFCE6DD199D96E45F570167C63EE156CC24E687AACFD6EABE5AA6E6F9D
      C19CE198C005E9A62BCBADE6D35A3644B9E627AAFE20AD5CD37C9612140A9AC0
      01DCC099F42AD6FF6B98BC002D9B971ECB21A62D1770AF7F7E851ABA45AF6738
      E4CF4D04A374E0CF71B8C571E6F482081047C4E7052FA96503A5BEB1B1511017
      F06D9A265CC057AD605C2E484888F7F7F78542C71E5DF386E2ADCCA4603A3808
      E302081E18E83F3838D8CB01BCE03D96285C404E323F3BABA3A3A39983CECECE
      82EC2C41D1585C30E69C9F1404F6476BF705AED45038525D5D4DAE0E5E681C3B
      D217B8AA3F46E76961303B269B0BC8390C660575B969B79A49B59C9DDB6A38B3
      EB163F89815B1434B5001798ADEAF6D019CC1E8E497381B954FD8DAF692D1BA2
      5CB38B6AF8897A74826AD5A30486D2A31DC00D9C49AF1AF37743F70BD0B279E9
      B11C62DA7201F7FAE7A6D4D0456AC8861AF2E2B3BCEDF022B75E1C878B1C674E
      2F88902B02174CD4BC80147CBE366DB94010718BC205DEDE5E50A960F04C2A2A
      8C937943C14EAECA4C0AA6F07901946B5F5F1F3617C0B1A0A433C7129D0BA0E3
      C0C0009B0B6093EBCC85700139E7A705410331DA17CF1BD4D6D6B2B9003661E7
      402CCD05EC985C5C004D831941DDAEE7DA8CA55AB4E6B61BCF1474DBA1A9F5EC
      BB6D26ABBAEFE90C660CC78420691652F5D717D15A3644B6662BD5B8877A7C9C
      6A371438F482267000377026BD6ACCE6861C10A065F3D26339C4B4E502EEF5CF
      F5A921336AE83A35749F56C41BCAE4B1184ED3758E9BFE702F880071A6EC79C1
      747E762C840BF8DAB85C9098F8C0CBCBF3C1830466740D659F370E1717300553
      381714E5E6F8F87897151624C5C624C7C5961515C1B10A73B29F775E404E123A
      0678B8D95CB2060BF4F480E05C672E9C0BE09C9FE6070DC69C83B20FF302E632
      696986634760E760ACCECF4561EC986C2E20E7309816D27D57BBCD40AA55636E
      87D14C41B71D9A5A35DE6D3358D5EDA4F324633826CC0B922DA486B56C886CCD
      3AAA713BD57C94EA301038F482267000377026BDCA2FCC09382040CBE6A5C772
      8869CB05DCEB9F1BCE18329F317473C690FB0C81BF4BEE1C07738E33A7174480
      380C170811A6E4FD1ED1F36A5C42A9EF110A7010A271F9DA3F3B16C5D85C909A
      9A02952A2929916F7DE65BE1D9F4F1FFB3F71EE06D1C67FE3FCE67D335728D2D
      45BEDCFDFD7372B9DC254EEE123B89633BB29CD8718F8B2CC992E226C9B6E46E
      4BB22C7759CD6A96D57BB7BA448914298AA4448ABDF70E92000880E82048002C
      20F17F17432E97C02EB0C02E2ADFF7F992CF6277E67D677676E783D9C5EE7867
      013807161414E49F3871ECE449EAE7405E6279610129A44393DC5BFB694FE1A4
      EEC249BD759F3BB4E7B9BC79B260B0272F4FEC4C59D875F641DBB99F58CFC459
      E32594CEC4D9CE8DEF4A9AD8797E91BD7A844F260B4819BAF29375DB172A3F79
      B0EDDD9F683E8B33EF900C3A610856C2A6B6F7C62B174DD4ED58642D1CF4092C
      C85AF660E377BFA1E6B221D3D64CA0A6AD91BD2469FF44C2E50A364102480689
      49AEDA6FC69EFA27C75C3682BFCBA18D5A16B8BFFF7CC56DCEB5B739B7DDE63C
      721BE718F3882BC15A5762572EF0007E6816789F9892F97C4100735CF2191778
      99E312C705CCDF11914E12BE30C3D7E6B56B57933BB03EC7054C7C70B0E07E7A
      5C70E2C4F1DA8AF2ACB454181AC0B80062551417D1B1F8FC8E882E24648C3FF4
      C396D52BB7AC1E1C17B895DC0B0B48996D15C99694852CE382D9D4B8C0727E91
      AD2289E993F93B225286CEEC04CDD68F151F4F90BFF313F5A79CE302D80409DA
      163EA8DDBEA83377D027B0E0D2D2090DDFB9E62F20D3D63C2069784CD2F24F89
      6A21E7D778D804092019241ECCB578DC89191C73D908FE2E87366A59E0FEFEF3
      ED8F38773FE23CF488F3CC23CECC47D8EE3DB9361D7225DB3E980B3C801F9A05
      DE27A63C73E634B94D000B01CC71B961CD2AEFCF9A4102565778BF809505F0F5
      3E3F3F3F3D3D6DCD9A55340B38EE178CE8994987C971EF783065654971414181
      D56A85F11AB95F00B1CA0A0BE8583C59400AD9D5D5A5D7EB99F70BDC4ACEF53B
      22BACCD692848EB31FAFFAF273D6FB051DC98BACA5894C9F4C169032582EC56B
      B62C50CC9F209BF313E57CCEFB05B009122816B8589033E83325E55CE692090D
      6B7F3BCC82FB25F57F97344F95B47DC879791F36410248068907737DFD93E3D3
      38E6B211FC5D0E6DD4B2C0FDFDE73FB85E697EE22DE7D9B79C17DF7216BD35E2
      376945AE95675D090EBB12BB728107E65C361138C765CCB0C0CB5C369EE0E64A
      79ECD811F2A2E9E4E42418495554945755552526266CDEBCF1EBAFBF5CB0609E
      A72B58099BB66CD9E4CA52039D5B7575D5D9B389172FA6030BC021ED1C522E5E
      FCD5504AEAAD744C1678C6A233BACD65E3E607320244982CA82C2DE1F2465C41
      A9DCCADC5977C998BDC998F696E7EF888C696F9B72B67635E6327D2E59B23831
      F10CB0006A41CAD05191D97E6663EB96B9D2D54FB5AEFF4BFBC17B3DF715AC84
      4DD2D54FB76E7DBBFDEC564BCDA04FF89FF6F95F1AF63E4BCD653334674DF5FC
      7BEBBFBCB7E5BB7BB95CC1264800C92031C955B3E9811F9EE398CB46F07739B4
      51CB0296F79F9F9BD4737E52EFC5497DB993FA4A2639AA2791A1252CC0475809
      9B2001958CEDFDE79139C7656CB0C0E75C364C707B9FCBE6DE7BFF9897970B38
      802EA2B1B1A1A1A13E3D3D75FFFEBDEBD60DCE08E3E60A567EFFFDDA0307F665
      6450596097BAB2A4E5E5E50056DCE6B221298973705F5D5E469E2F0030B0C662
      9DCBC6CD0F64EC56E79D3C7860E8F98243DD9A622E6FC41594CAADCC1DF579DA
      AC3DEDC99F68535E663E5FA04D79A5FDDCA7BA9CFD96A6113E376C5877E142DA
      F4E953EBEBEB4819CCD579CAA4DD8D3B16D6AC7DA9FEFB675B773FD57EFA29E6
      BE828FB01236D57EF74AE3AE4F5529FB3BEA067D028FCECE7FA0EEC00C6A2E9B
      A1096B4A3F7DAA62F153756B9FE272059B20012483C42457D5B6C7773EC63197
      8DE0EF7268A396052CEF3F4F7BC696FE8CFDE233F6AC67BAF39FE9297EA6A7D4
      A562EA23AC844D90804AC6F6FEF3C89CE3323658C0672E1B026E9F73D9DC77DF
      9F4A4B4B7273735A5A9A552A6573B3342727FBE4C913BB76EDA4678461BA8295
      BB77EF3C75EA241044266B85CEADB9B919B29494140356DCE6B221298973B55A
      2593C93252532EA59E97CBE55CB13CE7B271F303196DEAACCEA66D9B577DBB65
      F5CA4EE94E7B7B0E9737E20A4AE556664B7396B6608B32F53D55CAF39AF4BF91
      0AC2822A65922AED036DE1764BCB089F7BF6EC86851933A6C1188294C1DC94A5
      CADCD274F4BDBA5DCFD7EDFC9BF4E0838AD30FB6A73E485CC1027C8495B0A97E
      F724E9F10F5459DB3BA4833E012627DF7EA0E6D06BAE49700627A6295FFB60D5
      86076BB73FC8E50A36410248C6772E1B61DFE5D0462D0BD8DF7F9E31DB9A39DB
      9635DB9633DB9E37DB5EE0521EF51156C2262A01BEFF3CE426E25C36F7DDF7C7
      EAEAAAE2E2A2969616BD5E0FFF8B8A8ACE9D3BE7652E9B13278EA7A69E2F2D2D
      6D6B5340E7061D3B80009C802BB7B96C8E1F3F9692728E760E29EB5C060B5E62
      B9CD65E3E9A7539E6EA8DEA22DFA4C57F499B17A2B7CE4F2465C41A9DCCADCD1
      9AD55EB8557EFEFD9633935ACF3C224B7C08040BF05176FEBDF682CDE6A6113E
      5DAF422A9E366D4A6B6B0B2983A9315D99B3491AFF6EEDFEE76BF63C5277E0A1
      A6A30FB5C43F445CC1027C8495B0A9F6C024E9E9F754399B210BF1094E0EBCF6
      E7DAE3EFB826C1199AF566CB4395DB1EAADEF510972BD804092019DFB96C847D
      97431BB52C408B2213712E9B3FFCE177F5F5753034686C6C846E0AFEC37246C6
      45EEB96C12525252B2B3B3A1F36F6B6B83CE0DFEC3327CD9FEF39FFFE839970D
      B822CE5B5B5B61045157570B82EFC6D01F72C5729BCBC6CD8FA1EE9CAE3A5E55
      B05996F195FCE257AA824DF01156B27AA3E7B2712BB3499AAD2CD8273DF745FD
      89D7EB8E4DAB3B3685D2515898D998B0407E69A3A63C5E5733EC93CC65F38F7F
      3C09431BB2A3DACBE365191BEB4E2EA83C30B362CF8B95FBA6541F9C527B640A
      71050BF0115656EC990609201924862C640F83938DFFF84DD5C945653B5F64CE
      4D53B6734AF9EE295CAE601324F06F2E1BFC2E87862C40431B05065CF3B9060D
      0D598086868686C69F0562CD8D12985C65784D22992591BC2991BC23917C2891
      7C2C917C21912C9148564B241B24921D4CFDEBBFEEB8F2CA1DD75EBBE347D7EF
      B8E1861D37DD440916E023AC844D90C02D8BCBC96A97C32F5CCE21C4BB3FBEF9
      1157D0D7A00057C47D7945DCD771714BAFBC6AE5D5577F77CD351BC1D575D7ED
      BBFEFAA3D7DF78FAA69B526EB925E5B6DB527EF29394DB6F4FF98FFF48B9F3CE
      945FFC22E597FF93F2AB5FA5DC75172558808FB012364102480689210B6484EC
      E0045C8143700BCE2104110485D06E2D12AE86F87FFFEF3F7EF39B5F3DF6D823
      F3E7CFDBBF7FDF9933A70F1D3AB868D1C2279EF031DD4C900289521EB12AE5D3
      CF9D77FE7FBFFFFDFF3EFFFCB34B967C939696565F5F9F9393BD6AD5CAC99327
      DD7DF7FFFDEC677788B2EBEEB8E3DF7FF9CBFFBCEFBE3F4D9B36154AF2E9A79F
      7CFCF18299335F9D3CF9F9D75E7BF9E38FE7C39A050BE6CF9831ED8107FE0C29
      99B30B05AFC97EFEF33B453C72DC621D3AD4B86D5BFD1B6F64FFEE77F137DFBC
      FFF2CB77F1E901FEF55F77DE74D3FEDFFEF6D46BAF5DDAB4A9368063ECE69BD7
      5C7EF95A51FA9F2BAED83476EC16AE63232EEEF5F0F67E4C168835370A4FBDFE
      FA4C7A99B0E0CE3BBFF9DFFF3DF67FFF77EA77BF4BF8FDEFCFDD7D4FFA1FFE70
      E90F7F28F8D39FCAFEFCE7DAFBEF973DF080FCC107E50FFD55FEF023F2BF3F26
      7FF249F9D34FCB9F7D56FEFCF3C3828FB012364102480689210B6484ECE0045C
      8143700BCE694150A83B14202E6ED5534FE53FFD74F13FFE51FECC3335CF3ED7
      F8FCF3ADCF3FAF7EE105C394295D2FBE38306D9AF39FFF74BEFC8AF3B599CE59
      AF3BE7CC71BEF596F3DD779DEFBF3F2CF8082B61132480649018B24046C80E4E
      C0153804B7E0FC1FFFA82682A010DA8D05E16A8EB973DF80DE0C7A9513278E55
      5656D4535677E64CFC9A352B172CF8E8ADB7DE142B22049A3FFFC355ABBE750B
      04A7C61FFF78371D882B995FE5F1EE8439EB0DE91902F30385010DCDDD73BCBA
      BA2A2D2D552A6D4A4838B376EDEA8F3F9EC75A5AB713814FBB0FCDCBF3F5FEFD
      7B3333338A8A0AB3B3B38E1F3FBA6BD7F6A3470F5FBA44ADC9CABAF4C30F0796
      2DFB065232671712129DABFA9F7DA699354B396D5ADBCC994A58E6DF525EA27B
      C62A29B1EFD8617EEF3DCDA417948F3DAEE0D30340B2C953949065CB16536EAE
      8DABDDBD1CF38F3F5EFAC003E5A2F43F1326D43DF14435EBB1F1873FFCFEBFFE
      6B59787B3F371688F27E1B7F054187C605EF3DFAE8198964AB44B25B22F94122
      392E91244A24A91249B64452269134482472D06597C9AFB8427EF5D5F26B7F24
      BFFE7AF94D37C96FB9457EEBAD9460013EC24AD8040920192426B95CD9CB5CAE
      525D6EC1F90FFFF22F076EBBED802BE87B2E16AC9E3DBBECAAAB92AEB926EDDA
      6BB3AEBBAE60CC988A1B6EA8BFF146F06CB8ED36FBB871CEDB6F77FEFBBF3BEF
      B8C3F9F39F3B7FF14BE7FFFC8FF3AEBB9CBFFDADF3FFFE8F122CC04758099B20
      012483C490053242767002AEC021B805E7D75D9745044121B4270BC2D21C5F7C
      F1197C4B9932E585949473D09FC0115B5A5AB271E37AD74B7E1E607D3D516002
      574393CBACA403A5A7A7BDF8E2E43FFDE90FF4C3CBACC9FC2D0F4F27E450F4B2
      E77DFA6124F81612C4C79F2A2E2E5ABF7E1D9FD2FA8C4EEB37BFF99FBFFCE5CF
      3366BC085D6546C645E8B90A0AF277ECD8B674E9379B376F043AC09AFCFCBCEF
      BFFFEEE597674079F8EC253ED1B9AAFFF4D3DA5FFD4AF91FFFD106FF9F7C5213
      404B7946F78C959D6DFFE28B8E8913B5FFF66FCA6BAF55F0E90120D94F7FAA9C
      3041337FBE3939D9CE55242FC7FCF8F197E2E27244E97FE2E2CAC78D2BF43C36
      76EDDA092C888BFB30BCBD5FC02C78F2AF13E8579AC032EB1AFF59F0EEA38F9E
      9648364B243B2592FD12C91189245E224996483224920289A4522269A177C884
      3FAE7BEB9FD388FE7AFF3AD8037FBB7F78CDC47BD78DDC152DAEEC052E57C92E
      B7475C2120D04E57D077C9B860F6ECD2ABAE4ABCEA9AF3D75E9B71DD75B963C6
      945C7F7DF58D3736DF7CB3FAC73F368F1DEBF8C94F9CFFF66F540F3F63D2C915
      8B3E267AE5C593D0FFBFFAE2F09A97269F242080C490053242767002AEC021B8
      05E710820882B28E0BC2D21CF47971EE5C32CFDE2CB0E8ACDD269C86DC2C60EF
      5DF944E7D945FBC382413FD59515A78F1CA25E6AF4FACC67FEFE5748F0CF179E
      FBF6F34F8FEFDF5755567AECD851D2278BCB02BA187BB66F8528D437CC86FA53
      470FAF58B1F4E8C1FD35E565B0A6A9BEEE87BDBBF913D34F160C56BFA1B606AA
      FFFDF2A5539ED9397E7CDBE47FECF86EE9625277811CF48C9599D9F5D9672660
      C1F8F1CAABAE52F0E9012019247EE001CDBC792660015791BC1CF3E3C75F8C8B
      CB14A5FF898B2B1C372EF79FFF9C466A441F1B432CF820BCBD5FC02C80B38C7E
      FF1B39E3DCD604C482771E7D14CAB94922D92E91EC91480E49242786E0982591
      144B24B512898C5410AA9C3B64A4FA6E6B18BB42E6CA58EC7242B078C2E57C8F
      2BD02657D0775C2C58397B76C99557265C75D5B96BAE49BFF6DAECEBAE2B1C73
      3D191AC86EB945FBE31F778D1D3B4070001D7EDB9091CEDF6D0D0304039011B2
      83136A50703D0C0A0AC139842082A0105A080B446C0E725E4C9E3C899C177C7A
      B3C0A29393DDEDD4E06281E7194497874F749F4EFC6201D34F5D55A54EA793CB
      E58D8D8D6F4E7D0170F0E1AC5765329946A3E9EAEA3A7AF4705E5E6EF05800BD
      2E4481BECB6AB5A69C8EDFB17963E28963F41AE8A583C10266F5210A54BFA6A6
      66D1BB6F3DF6D0A64FDE995B5D5DADD56AA10C0239E8192B3DDDF2E9A7BA8913
      35D0BDC7C529F8F400906CDC38E5FDF70FB280AB485E8EF9F1E3D3E2E2D245E9
      7FE2E2B2C78ECD841AC168CEF5A6DCC163638805EF87B7F713382E60BEDB84B9
      1CE8B8E0AD471F3DE5BAC70103A55D0C382649241724925CD7306770873C700F
      55FD8221735BFECB1FD68DDC1565AEEC175CAE682CEE7205DAE00AFA1675EFF8
      8A15B367175F79E569D765A254C6D0A0EA861B9A6EBEB9ED965B0C3FBE6D1007
      D39EA33A7FF590B92D4F7FFEE4EDB70F81E036008101B2831370450F0A200411
      0485D0C2C705A234079C17AE6BA7D479C13C627D8E0BFC8D0EAEFEF2973FBB9D
      1AA9A9E73D59E0998C591E3ED17D3AE1CF02373FE5A525A70EFDA0542AC90BEE
      00072D2D2DF051AFD75752532A049105508CDDDBB690D187CD6633994C8777EF
      321A8D64922080D481DD3B4567815BF56B2B2B0C06435D5D5D5959D907B35F2B
      2D2D05FE42DDAB04D7DD33565A5AC7A245EA8913E53000814E9E4F0F00C9C68E
      0516B47FF49126298913CD5E8EF9F1E3CFC5C59D13A5FF898BCB183B361D6AB4
      72E58A4B97323C58F06E787B3F21F70BC839281F69FEF63C235930F7D1474F4A
      24EB187024D7CD60149322915C9448F2867608355CBAFF6E6A87948C3458033B
      8A313822BB22CF953DC5E5EAB8CBED2016219C2BE85C170B96CF9E5D74E59527
      19430372D7A0F4FAEB6B6FB8517AF3CD4A0A07D4E8C0316E9CF3C567291CE846
      1AAC014C00052081EBD210018112B2831370050EC12D388710441014420BBC5F
      205673D0E745727212F388F57E4607109D3ED999A7861716B89D41CCF2F88CCE
      C7895F2C60FAD9BF6BC7EAAFBE80FE5FE132588041C1B17D7B8A0AF2214190AE
      11D1FD64B12B8ADD6EEFE8E8001CC07F582690E219370016D0D5272884315165
      6525E000FE373434D07517850574ACB434D3A2458A89139BC68F6F8C8B6BE5D3
      0340B2B163A93BA71F7EA83C7BD6E293059EC7FCF8F167E3E21244E97FE2E252
      C78D4B61D668E435A277C2DBFB09BC774CCE41CD9005D0F38C64C19CBFFF1DC6
      2FDF49241B25922D43703C2C919C1C1A2B654A24F9AEDAD548244D403DB2432A
      870C9661CD10109B5CC9CA5C593287C647275D0E0916B7B8027DE70A3AC7C582
      65B36615C6C59DB8F2CA33575D75F66AF8D24E5DCFCFF9D18F8AC68CA9B8FE86
      FA1B6F6AB9F96615F4EDB7DEDA39766CCFB871030407E621836558E302C10024
      80642E10A820E3F5AE5BC6E00A1C825B700E2188202884167EEF5894E6A0C7CB
      F479C1B337F3373AFDE596796A78B946E47606B995C77B749E4EF85F2372F3F3
      E9BC0FE6BD3E53EB32F83EF0EDE79FEEDABA897CC32C2C2C081E0BE862C028C0
      6AB5767676767575C148C1AF7E38806B44CCEAC3E8E3FBE54B6168505D5D0D83
      82B54B16BBEA9E2190839EB1D2D38D9F7EDA3A7162EDF8F1D57171B57C7A0048
      366E5CC3FDF7377EF8A1FCEC59335791BC1CF3E3C79F8E8B8B17A5FF898B4B1A
      3B3669A846C3C7C6100BDE0E6FEF17612C7873686F6C18BA87B26FE8BAD99921
      38E6BAAE7D55BAEE8CB772EF8D5657824A57E2DC212C9E19BA56B6CFE57CB32B
      10D91B6FBA58B0748805A7C91DE46BAEBD3878D7604CD9D0D0A0CD75E3C07CDB
      6DF6B163FB5959E01A11F44302480689A9AB43838382B2C13B05D75E04E75408
      975C2C581A392C607C47F2A3370B80058C0E6D30102B0B3C9305C0023E4EFC1C
      170CFB6163C1E6ACAC4B478E1C2A2A2A5CBF7EDD6BAFBD1C8C6B44743F595F5D
      E5C602FEFD70A0E382C1EA73B04028073D635DBC082C689938B166FCF88AB8B8
      2A3E3D00241B3BB6F6FEFBEB3FFCB03529C9C455242FC7FCF8F1F17171A744E9
      7FE2E212C78D3B4B4673CC6363F76E371684A7F7137E8DA877A409BB46E41F0B
      EEFBFD7750FD969136B44342C182A9CF9C80CEDF31D2080E42CF02B19AC3ED3E
      1ACFDE2C80E87487C63C355C2C98C23A2E703B8398E5F1199D8F13BFC6054C3F
      07F6EC5AF3F5977D7D7D7468583EBE7F5F6971516E6E4E7171D1860DDFD3817E
      F5ABFF12775C40AE110D0C0C90C3AFBFBF1F96614D657959F0C60574F5AB2ACA
      4F1F39D4DEDE2E97CB653219FC57ABD5C7F6EF2D292C10C841CF581919C6CF3E
      6B79E8A16116F8EC0120D9B871140B3EFA48969C6CE22A929763DE0B0BFCED7F
      6816AC5EFD6D4E4E367D6CD02C78F4D170F67E6E2CF032378A9BE6BCF2129C6B
      FD43E6B60C5B79FA21538D0CB1E0F5CF3EBBF097BF1CFDCB84131326C44F9870
      66E2C4B31327A64C7C28EDA1872EFEF5AF97FEF6B7BCBFFDADF0E1874B1E79A4
      62FAF3ABA0E2B221735B9E3169F5DFFF5E03C9203164818C901D9C802BCAE1C4
      B3E01C424020080741213414E05FAFF866DBB6A6E9D3F3A6CF289C31A364C68C
      B2975EAA7CE9A5DA975E6E78F965E92BAFB4BEFAAAF2D557DB5F7B4D3773A669
      E1FB47A0DB1F1832B7E54F3E383A6B56272483C490053242767002AE28872F55
      827357084A1014427BB2202CCD71ECD811725E9497973534D4C311DBDCDC9C92
      726EEBD6CD8B177FB560C1BC79F33E14253A991067D3A60D89890974A0AAAA4A
      C202280609C49A8C599EB9AFBEEC33BA4F2724163914BDEC794F3F4DF5F5A78F
      505D318938E7C5C96401D6D45494979696F8DC7B6E27029F76A78B71F2C86118
      05407A386020E2913DBBC911086B1A6AAA134E9DA4E3F23C0DBD47F7AC7E436D
      0D848381585B5BDB07B35F83FFC005AAEEE5657C8E1C2FD13D63555676ECDDAB
      983FBF7EEAD4CAC71FAF9C31C9770F00C9A64EADF9F0C386EDDB15C5C51D5C45
      F272CCBFF042C6C38F5CF8EB5F45E87F1E7924E3F94997366DDAE8AA51037D6C
      64645C70B160EEE79F87B3F763B2C0E7DC286EF3A4D07961F9FD3766B9ADE1E9
      874C3542DF2FF8F6DB4BCF3E1BFFECB3A79F7B2EF1B9E7929E7FFEDCA449A993
      265D98F442C60B2F644D9E9C3B654AFE94294553A7964295E9BB84B03C73FA6A
      B73553A7964332480C59202364072794AB49A9E0169C43080804E12028B96276
      F9E5CB0E1D6A7DF7DD9277DF2D7DEFBD8AF7DEAB7AFFFD9A0F3EA8FFE083A60F
      3E6CFEF043D9471FB5CD9BA79A374F337FBE1E3A7CBABEB0FCD5C2A36E6BE6CF
      374232480C59202364072794AB0FEAC12D387785A0044121B41B0BC2D51C4949
      89705E4C9D3AB9AEAEA6A5A5198E58F8C697999971F0E0FEEFBF5FCB9C6E4660
      7470B56EDD9AFDFBF7A6A7A7D181E04C0416DC7BEF1FE90971589331CB33FB85
      E77C46F7E98479287AD9F39E7EA033A463517325BF3DE7A3D9C34FF4D7D5D5FA
      DC7B6E27029F7627C5D8B76F0F8C3E200AF45DF03FE5747CFCB12389278ED16B
      00527CE2F28FEE597D524DAD56BBE8DDB7DE9AB91EFE0317C84A3E478E97E89E
      B16A6B3B8E1E557CF34DED9C39E5F055EAED97A6FBEC0120D99B6F567DF555FD
      C1837240095791BC1CF3AFBF7E69EAD48C17268BD0FF4C7D3173F6EC6C6835A8
      5173B3943E36F2F373C9B820BCBD1F93057CE646A1F5F1BB6FD18FF3C032EB1A
      9E82A0F4B3661B36E4CC9C7976E6ACE459B3CECD9A757ED6ECB4D9B32FBCFE7A
      06B4C8EBAF67BFF146DE9B6F16BCF966D19B6F16CF797505FD6CC59CD756CE9D
      5B3DF7B555C36B5EFD76CE9C5248E64A5C001921BBCB49063804B794F359E720
      108483A0E4698BCB2F5F75FAB4E2ABAF2ABFFABAFAEBAF6BBEFEBAEEEBC50D8B
      17377DF34DF337DFB47EF38D7CC912E5D2A5EAA54B354B976A977DF103FD64D9
      B22F0F2F5F6E59FEE591E1355F1C5AB64C0FC95C89D59011B2BB9C348343704B
      39A7425082A010DA8D05E16A8E8B172FC079F1E28B939B9A9A5C730DD42A95CA
      8282FCF8F8533098654E3723303AB8DAB56BE7C993C761BC4C07826F4AC082FB
      EEFB133D210E6B32667916BEF7B6CFE83E9D300F452F7BDED34F73531374B96B
      BEFE72DEEB33177DF02E2458F2D9272BBFF8F4F8817DD5E56564BE1E0874FA34
      E7DE733B11F8B4FB50314E249F8927A38FC6BADA4BE96959595917CE9FABADAC
      20904A4D3AEBA5D50288EE597D187D40F5D7AF58FAC9879BDF7FBF16FEAF5DB2
      18EA0EE3023E478E97E82CB11A3A121214EBD6D52D5C58FEF6DB25735FF3DD03
      40B28F3FAE58BDBAEED42905A084AB485E8EF9F9F373E6CECD7CE30D11FA9FB9
      73B3E6CFCF855673D548461F1B6565A5E459B3F0F67E4C168835378ABF82A043
      2C787FD7EEFC79F3CFCF9F9FBAE0E3F4050B2E2C587071C182CCF90BB2167C9C
      BD6061EEC70BF33F5E58F0F1C2A2859F142FFCA474E127659F2C2A5FF429A862
      D1A7952EC14239ACFC64116C2AFD645131247665C987ECE0045CCDA71C5E9CBF
      E0C2FC05E9F3E6A77E34FF3C0485D05080CB2E5F939AA6FA7E7DDDFAF5F51B36
      366ED8D0B4618374C38696F51B641B36CA376C6ADBB849B571937AE326CDA6CD
      DA4D9BF59B361B366F316ED90A326DD96A7609168CB072F316D8A4DFBC450B89
      5D5954901D9C80ABF59443E9FA0D4DEB373412415008EDC6827035475E5E2E9C
      17D3A74F85F1A64AA5822316BEE95193F3A6A59E38719C756A9BC034343D4D4A
      4949091D48A1504C9B36F58107EEA527C4614DE66F79783A2187A2973DEFD30F
      E8D8B1A3E7CE5173EE2814D4643D900C4EF6F3E75320A3F7D2FA8CEE39431029
      06F45DF0CDBCA6A6A6A8A8A8AAAA52AD56C31A28587979796A2ADFBDC4273A57
      F577ED96AEF8B616BE41C1FFED3BA401B4946774CF582D2D96D4B4B61D3BEB96
      2E2BFFF4B31238C17DF6009F7D5EB26C79C5D66DF5C9C98A8606335791BC1CF3
      4B96E42DFC24FBE38522F43F9F2CCAF97A71BEE7B1515D5D7DCF3DBF8B8BFB28
      BCBD1F930562CD8DE2AF20E8100B161E385CF2CD8A4B4B57667DF36DCE37DFE6
      2EF9366FC9B7F9DF7C5BB0E4DB82A5AB8A96AD2A5EB6AA64D9AAD265ABCA96AD
      2A5FB6BA62F92A5A952E0D7EA4B6AE0495B912439662C8BE7425F8C95FB232CF
      E5169CE72CF9366BC98A4B10144253CF1D5FBD293347B7F787D6FD87657B0F29
      F61E6ADB7748B9EF906AEF21F5BE43EAFD4734078E680F1CD11D38A23F70C470
      E088F1C051D3C123B4CC2E0D7EA4B61E06195C89218B16B2EF3F0C7E54FB0E2B
      5D6EC1B982088242E8204D5513C0D436BFFBDD6FE13B9252D906BD0A1CB1D0CF
      40DF929393031D5A62628258815C13E29CCBCECEAAAEAEA203A9D5AA29535E00
      16D013E2B026F3B73C3C9D9043D1CB9EF7E98739E78E542A25CFA0415D323333
      CF9D4B669D18C8ED44E0D3EE10083A49F87A09FD3F1400FA2E83C100E16A6AAA
      1B1B1B74BAC135F5F5F5D0CBF1DC4B7CA27355FF8723D20D5B6A57AFAB5EBFA9
      F6C02169002DE519DD33564B6B474696F2E09186F55BAABE5D5BCEA70758B1BA
      FCFB8D55FB0F35A45D6C6B68327315C9CB31BF6E53E9B2D585A2F43FCB5615AE
      F9BED8F3D86868A8FFED6F7F7DF9E58BC2DBFB3159F0E01315BF91B8EC6E6A94
      007F13E1EF3EF8FB17C958D7FAEDB03D6B0CF91BB2D9B367C586485D9E7EFAA9
      6817B32ED3A2D93CEB12A52F84C7BA605DB02E5817AC0BD605EB8275C1BA605D
      B02E5817AC0BD605EB8275C1BA605DB02E5817AC0BD605EB8275C1BA605DB02E
      5817AC0BD605EB8275C1BA605DB02E5817AC0BD605EB8275C1BA605D62A62E31
      F3FBE498F9DD78CCFC9EFFC127E2CE8F7CA26102FC75319E68284B91486EBA96
      FC0D9933FA0DEB103975D0D42546A3DCEBE03415F71B0A4591DB4E12CBED8810
      A662963AD84DCD62C9AD0E227A662A56EB606E164BEE7510CF3353AC7568154B
      1E75680D8658EBD022963CEAD0120CB1D64126963CEA200B86DCEB809CC63A60
      1D469ED316B558723FA7C5F3CC145BBFD4D92E96DCEB209E67A658EBA0114B1E
      75D00443AC75D089258F3AE88221AC03D621887508781C28DC441B8BC6421DFC
      1D4F8B5887B08DA745AC43D8C6D3115907618366417508D7785AD43A88319EC6
      F103D601EB8075C03A601DB8AE6B081B340B625CB8C6D3A2D6214CE338AC03D6
      61348EA7C3DB698A339E0E6F1DC4194F87B70E7E8C45F1BB06D601EB8075C03A
      601DB00E5807AC03D6216AAECD047DCC29EE30D58FF17434D521EAC7A2784E63
      1DB00EC375E8D36689A1EC3E5D4E9F2EB74F97D7A7CFEFD317380C450E43B1C3
      58E23096394C150E53A5C35CEDE8A87174D4392C0DFD96A6FE4E697F574B7F97
      ACDFAAE8B729FB6DAA7E7BFB40B776A05B3FD06318E8310DF4760CF45A06FABA
      061CD60187DDD9DFEDECEF71F6F73A071CCE817EE7C080D33920621D862AA027
      15281CAA40E96005CC55AE0AD43A3AEAFBA1029D5081E6FEAED67EAB7CA802EA
      7EBB66A802C6C10AF475BA2A601BAA40AFB3BF6FB002AED28BD50E507ABA02D4
      EE1FAA4009550153F950056A862AD048EDFEE10AB4B976BF7A80AA806EA0DB40
      55A0D73C5401EB5005C8EE67A980F03AB81F3F7D8642C6F153EE3A7E4805E0F8
      19AAC0E0F14357A07DC0AEA52A3078FC985DC7CF60059C8E6EEF15105887B09D
      0062D5219C2780F03A84FF0440C6611DB00EA3F8FB52A41020E03A44100102A8
      43C411C0DF3A44C457202175888E13C04B1DA2E60460AD43949D006C7588B613
      00C7D3389EC6F174CC8FA7F1BB37D601EB8075C03A601DB00ED1726D06C7D338
      9EC6F1348EA7713C2DC6781A198775C03A601DB00E5807AC03D601EB8075C03A
      601D703C1D5DE3693C1F22A30EA64E7BF46AB80E513D7DC2701D449C3E210462
      BE9E825107757C9FE278B4084A1BAB75D026F7A912A245505AB63A68121CAAF8
      68119496B51DCEF7A992A245505AB63AE82FF4B59F8F164169D9EA60B8D4A7B9
      102D82D2B2D5C19827D28D8850084A1BAB753017B9EE804487A0B46C75E828EF
      3314478BA0B46C75B0543A4C65D122282D5B1DBA1AFACC35D122282D5B1D3AEB
      FA4C55D122282D6B1DEAFB4CD5D122286DACD6C126A7AEB54489A0B423EAE08C
      F2A9FC62E89A005ED7C0EB1A225ED708D2C487C153ACD621389337064FAC7568
      8D2EB1D6A125BAC45A07597489AD0E1DF2E8126B1DDAA24B315B07657489AD0E
      C199BC317862AB4370266F0C9E58EBA0892EB1D641175DC23A601D825807BCAE
      81D73544A94394FE6206EB8075C03A601DB00E5807AC03D601EB8075C03A601D
      B00E5887B0D621EAAF09C4C2B3345807AC838875F8223A0D8F25AC03D601EB80
      75C03A601DB00E5807AC03D601EB8075C03A601DB00E588748A803BECF18E707
      C2F98184D701E7DBC5F97685D421126787F0AB0E113A3B04FF3A44EEEC107CEA
      10E96FB3F4598728981E05E7DBC5F97671BE5DCE3AE0FC40383F90B03AE0FB8C
      C37F4DE0C127C65C2371D9DDF0F78BC1BF1FC3DFBF48C6BAD6D75D2DF1B0828C
      E47069FAA4C7422C3A6E281B06E3625C8C8B71312EC6C5B8E18D1B96EF1B61D1
      834F9C9D75D5886F83575F2691BCF42FC3DF06BF80ED97C6485C7F43D68526B6
      C111883B010D0D2DAA0DD9806C40434343F3CA06B1064F6B572E0EA028875EF8
      775154BA675178E3221BD0D0D0628A0D2597921D8E3E9DAE51A002C343CBA9C9
      FDD24D2DE96B05CA5F3CE80BB75BE459B6BEA40064ED4EB0DA4E53B29E84B895
      47D7201BD0D0D062930D1A55AB4059CC06C043806CB8F85DA05A47D8A0C85801
      DD74E8D9D06D9192B8C8063434B41864835AD1EC453EC1A0D7AA85B0C1A93AC9
      5BF1AC0A8C0D1DAA74814236A0A1A1211B900DC8063434346403B201D9808686
      369AD9D02AADF12259739D77B5295A4C066DE06C90EDE32BC54156C9D33E0F80
      0DA6964481B21BEB910D686868C886986283BEEEB840D97435C8063434B49865
      437D4D991735D4967B576343AD5EAB0A9C0D4DBC25DDCCAA96A479C806343434
      3491D950599AE755053E545ED2AE9205CC86FEBA653C3550B79C55D2336F04C0
      066DE54181B26A2A910D686868C886986283A664B74075A9CB3CD9B076E5E250
      BECECBED91C3D23D8BC47AEADBDF27D2C3181A0D0D2D286C28C9CFF0A2E23C1F
      2ACCCB52B7B506CC067BC97C9EEA295BC0AABAC35323840D040CC29F330FEC89
      74D23B0B7FCE3C8027D22B8FAE8165ABF5E4E08381DD0976473228B0070CFD7A
      281D0D0D0DD910E96C809DD0DB63D769EA853F6A1EC013E9501845C60A964E3C
      F027CFF93E910EFFBB2DD250B281FE01311A1A1AB2414C36688B7608945555EA
      C906E8AC95F226EF8F8CF094BF4F961036F8F3BC88684F961036087F64248087
      4BD0D0D082C586C2EC142F2AC83AEF5D3999A92AB934603698B266F15467D66C
      5655EE7D12D9806C40434313990D0599495E949FE14359E9494A5963C06C684F
      99CE53BAB419AC2AD9F670006CD0156E1528ABB218D9806C40434336C4141BE0
      BF40D954259E6C3019B42D4DD5DE1F27E4297F9F3A84C2C8D33EF7E35942F19E
      3A84FF7663BDF047CD0378281D0D0D2D68D794321285283B354125800DB2F8C9
      3C254F6457FE8609C886B0B3C1A6AB11FE3861000F1EA2A1A1058B0DF0DF8B8A
      3293BC2BEF4272BBBC29F0F91B4E4DE629D9E9175995B77E62E4B041AF55D557
      97787FD49CA7FC7D229DFA016BD23C3F9E3317EF897464031A1AB201D9E08D0D
      ED2A596569AEAFC70979CABFA70EA130D2336FF07F9650C4A70EA9FFEDE5C21F
      350FE0A1743434346403B22182D9A02E13FEC848000F97A0A1A1058B0DADD206
      2F923537FA90ACD56CD407FECE0CDE72B66C61953C3D90F7B00A57B759EEC906
      755B6B49FE45EF8F8CF094BF4F964061EA0E4FE5FFBC88884F96201BD0D0900D
      B1C20645AE40F57428900DC80634B4986583422EF5A23679B377A9542A8BD918
      F83BBAE5FBF8AAED20ABDA3297231BC2CE06ABAA54F8E384013C78888686162C
      36A895322F6A57CABD4BABD5747698026743FB19BED226B24A99FB7D006CE854
      1608548FA5CD930D2AB9D4FB73E6FCE5EF13E9D4EBE7F63EC9FF3973119F4847
      36A0A1211B62840D5DEA1281EAB1A83CD9A09435167A7D9690BFFC7DEA100A53
      B2ED61FECF128AF8D421C50665B1F047CD0378281D0D0D2D586CD0B6B779914E
      A3F22E93D1D0D5690E9C0D868B7C65CA6495BA7027B221EC6CB0A94A84FFF42B
      801F89A1A1A1211BA2800D6B572E0EBD683604E175DC3E343C6EE84E08B1900D
      6868C806F1D960D55408546F573BCBF30DF2A6108B396EC85B3F31C4A2D91016
      E1F98C8616443618F56A2F321B34DE0560B0592D81B3A1AB88AFAC25ACD2551C
      8E1036A0A1A1A1C50E1B3A3B745ED4D5A1F7AE9EEECE6E5B67E06CE86DE4AB3E
      29AB0C350901B0C1A6AF13A85EAB16D9808686866C882936D88D5281EAB31990
      0D68686831CB065B97D18BBAAD66EF0207BDDDD6C0D9E054F3968655E6C67464
      031A1A9A889678E2C09C37E6448BA0B4416143B7DDE245BD3D56EF1A18E8EBED
      B10B6043076F59586569C90D800D3D66B94039EC2664031A5A14D93155E242ED
      AAD76B17BAE9BDF22F8F549E60A6840ED7190D663799BAAC56282DB201D98086
      5F4E23F15B6754188021DD1A0F276CB7B3EB8ED3925BD748EE59299923BF7391
      76D587E95F44231B283CD8EDC80664035A4C199CD2BD7D7D6197283D4B54D83B
      CD5F92FEF49873EF98DD141B408FB4FE74996DCBCC53EF47291BC082C506EFEA
      EF777897DD6A16C2864E7DBD10995B0B3BF53501B06160C011881CDDFDBD3690
      A3A713846C4013C8869E08B0D1C9863B8EDD70CB468A0DFFDD76E3F2EEADC806
      F1D9E0E8EB25CF03878B0DD43BE68EAEF19F0DFD0245C745368C5A13723E930E
      C8DEDD1D768D5A36FC6AF5ADC086BBDAAF59D1B30DD930820DD0A78BA200C0D0
      25DEC3B4A57B1685372EB261745EA0F7AB309098950D36AB2DEC223DCB91CA13
      1FA67F015D6484080AE3767F587436DCB56EDCB8AD92DBB597ADE8D98E6C9060
      FF128C2F8FB81342761126728A01FFB51A2D914EA7D3EBF54683D1683299CDE6
      4E4B2724806E17BE95F7F4F4906BFAAC6C889CEABC57FEE522EDAA65B62DCBBB
      B7C2F768E82E57F6EE58D9B7739563D7EAFEDDAB0776AF19D8332CE7DEC0C5F0
      036EC139848040100E824268280014030A03450A2A1BEE5E7DE74FF74AAE3648
      2034B201D9806C403644101B2065D845AAF37AEDC239F23B1F69FDE97FB7DD78
      57FB35F06D1A3A4D89F13289F96A49E7159759AFBCDD7AC338FBD5E3BAAF1CD3
      73C5D53D975DD12BB9A28F92C471E5E5FD1249FF0D92812B24CE1B24CE5BC738
      C7DFE8FCC9B503375ED17F33B5C971254909592023640727E00A1C825B704E85
      3052E120288486024031A03050A4E0B1E1B13DBFBB77D32FEE381007A1814CC8
      066403B201D910416C304780D16CB867E5E04F7740E3B64AE03B35749D3F3F78
      F57F1EB9E9AE13B7DF73E6670F9CFDF5DFCEFFFEA9F4FB9ECB9C3029EB91E979
      7F9F5AF0D80B858FCF2879FCC5D2C767543CF152D5D32FD53CFD6ADD3333EB9F
      79A5E6E919954FC2264800C9203164818C901D9C802B70086EC139848040100E
      82D20580C204970DFBEEBE77EB2F21349009062EC8066403B201D910416C80F4
      6117CD06D229DFB251F2ABD5B7DEB56EDCDDABEF846FD6D0813EBCFD9E67B6FF
      75DACE2767ED9B32F7E0CBEF1C9FB5E0CC5B9F26BDFF65EA47CBD23F5D99F3F9
      8682AF37142FDE54BA647BD5B21D354B77D5AED853BB6247D5F22D654B601324
      80649018B24046C80E4EC0153804B7E01C4240200807412134F9F91028A86C78
      6EE743101AC8040397D5FDBB910DC80634644324B101B2845B341BEE382D19B3
      5B72C7B11B683DB6E777F0FD1ABAD197773FFBE6DE69EFED9BB9F087B7BF38F6
      D18A84452BCF7DB9F1C2F26DD96B76E56CDC57B8F540C5D61FAA769EACDF7BB2
      697F42F3C1C4961F4E36EE3B52B313364102480689210B6484ECE0045C814370
      0BCE21040462C6A58A713AB86C80D0402618B85C66BD72F500B201D980866C88
      2436E823C06836743BBBA0D38C10416182CA0620130C5CEE39F3B3DBAD37AC19
      D8836C4036A0211B22880DBA08309A0D62755503CE814EA7B9C76974380D42FC
      04950D307099B56FCA03677F3DCE7E35B261980DA69682885204960A8BC4BF48
      C88680D9407B08A34875E8770D45884161A048C163C3C21FDE9E7BF0E5BF9DFF
      FDB8EE2B910DC8062C12B201D9C0CE06F28E52E83D234450182852F0D8F0C5B1
      8FDE393EEBA9F4FBC6F45C816C706743D8CF31D65E2F424A15D422E5E7E7EFF7
      659026944512B297900D31C086D1604C36AC4858B4E0CC5BCF654EB8BAE7B235
      CEBDC806644344B001BA7E99CB5A5CD6EC32B22C1B3248132DB802D316ED104B
      A3870DF88EEE30B261E5B92F3F4D7A7F52D62357F44A900DC8860862434E4E4E
      414141A9CB6A6A6AA075C932AC842E18B686980D104E3A644D238D5ECF552464
      43606CE812F6B63EA61F347FD9B0F1C2F22F533F9A9EF7F72BFA900D1E6C888F
      8F0FD7B14542B3B241C452F9FB5D9859AAA0EE28884BBADDFAFAFA868606FA1B
      1C7CA47B64D21187B248F490851ECDB00E653C8B846C4036441D1BB665AF5996
      FEE9D482C7900D2C6C387BF66CB88E2D129A950D2296CADFEFC2CC5205754791
      8E582E9743CFEB36C097BB8CEE884359247AE7B4B6B64201140A05FC8765375C
      791609D910181B9C1227D17DF7FCEF3BAF4C01C102BD92D613FF7BFDD27FFE37
      081686D78FF4B361E57222584606F061C3AE9C8D2B733E7FA1F07189E34A6483
      3B1B525252C2C506129A950D22968AFF7761CF52057547415093AB133118A03B
      1936F8082B4D2E23050B65917272726014C5BCD2C57A99CBB348C806216CF8F3
      DDBF052A645D4801C1027C6482E1B1DFFC08A8909DB807040BF0918B0D72831A
      D9C09F0DFB0AB76E28F87A46C9E397F7E3B8C1830DA9A9A9E1620309CDCA0611
      4B057DD9A591969D9D4D16725C969797C76403B35441DD5110D4677B938285B2
      48B037C86EF1BEAF3C8B846C08980D64C4909A38F860012C30470F8FFF760CF0
      A0E2D271B21516E023AC4436086183C36900361CA9D9B9A56CC98CCA27AFE8BF
      19D9301AD9405F0F2157F689795ED60F311BF8DF0809251BDCF6151C70ACFB0A
      D920161BFEF2A7DF0309CE9F3DC55C0F1F61256CFAC7EF6F0212945F3CC2DC0A
      1F61256C423604CC861EA711D870B271DF8EAAE5AFD43C7DEDC08DC886D1C806
      8542412EDF7B5E5382F5B0352C6CE07F9B31946C60EE2BFAFE87E7BE423688C5
      0660C0D95354D7DFCF30F8082B61130586CC63545247AFB3AF87122C001E328F
      C1266443C06CE8749A810D892D3FECA95D31B3FE991B9D3F4136B8B3212D2D2D
      5C6C20A159D92062A9E85BBEE4AE6F6B6BAB542A85FFB0EC76CBD7B35441DD51
      FCC70D212B12735F79BF3DEE59246443C06C200B1D164B07318B857C75206CA0
      D2D9DB9C9D0AA7454E0916E0A3D3896C10C28601E700B021A1F9E0AEDA15AFD6
      3D33C6391ED9E0CE86F4F4F470B1818466658388A582BE4C35646D2E832FBF64
      815ECF6403B35441DD51FC9F7D0B659178EE2BCF22211B84B041A91A61F07104
      1B74454E7DC5B0E023B241181BC8BDE8934DFB77D42C7DA9E66989F35664833B
      1B2E5CB8102E3690D0AC6C10B154FC6FF97A962AA83B8AFE5110D3C8CF8188D1
      3F0A0A6591C8EFA3DC7E3DE5F9D329CF22211B84B081FC62981E9CC1C7116C68
      CB70B6173ADB0B5C2AA43E221B446143FDDEED55CB5EAA0236DC806C7067C3C5
      8B17C3C506129A950D2296CA5F36304B15D41DC57CF6CDED028EDB8DDF5016C9
      E170F4F5F5F5B219AC87AD5C45423604CC8601A7930C195B5D460691034C3628
      529CEA1CA73ADBA51CEA23B2410C36FC50B57353E99219154F4806AE40368C3A
      36F8FB5C74283B62FAD937E68D5FF990D1D7944259249E1C453688C8867EA753
      DA246D66187CEC67B24195E2A242964BD9D4476483186C3850B17543F1E2174B
      1F97F4E3B8C1830D1DE13656364448A9825A24CF67DFA8E9213D2EE084B8487C
      D8C05A246443C06CE8EEEBABAEAEAE63187C8495436C18E8AC3EDED598D2D578
      CEA514F8082BC3C20699000B7B764F36E0B36FDED86008B7B1B221424A15D422
      F1EC884359249E632CD62285B8538E2536E88CC6B4B4B46C86C1475839C40653
      43DA4679C12179FE0F940A0EC14758192E3658CC069DAED153067D1397200BDD
      B9B7A4AF1DA18BDF716B1D2D3A7BB7456AB59EB4DA4E53EA4EB03B9241B6BE24
      4ABD6789603D2592C67A12B270B101DF99E18D0DCA701B2B1B22A454412D12CF
      8E38944512B297900D81B3416F484A4ECE60187C8495836C18E868CED8D25674
      A4ADF030A5A223F01156B2B221D8EF53226CD0A85AD924E712930D8A8C154ED5
      496EC57B0AB230D9D0A14AF74B5ED880EFDAF3C686E6701B2B1B22A4545824FE
      45423604CC067B6F5F6959595565D5A05556C1475849DF6FB0D79EB049536DD2
      149752E1A3E7FD86D01874B2268356D65CE729796B0397A82C439DBB3CED73A7
      6C1FA714073D0559E8EC7663BDA925D12F41162E36E03BBABDB1A136DCC6CA86
      08291516897F91900D427EA7246D6E6E6D19345890BAFD4E4995ECD464393597
      5CCAA23EB2DD8BE623E16CD06B550DB5E56CAAE4126419BEA69434CFD9B48953
      D2CD9E822C74769BAE465F77DC2F41162E36E0DC3EDED88033216391A271BE68
      E86AC3A82EB19F6FA0F21A4D06132558808F239E6FE8933B1D4A67BF9A122CC0
      470F36D01794BC4B381BDA55B2CAD20216951572A95D357C33597AE68DFEBA65
      5C1AA85BEE29C84267EF6A2FD7561EF44B564D25171B704E5064031629A6D8A0
      8B00138B0D339E7D3C372315926BCDD6768305040BF01156C2A60FFEF1B3F4A3
      EB6B2A0AF372CE675D4806C1027C8495B0C98D0D7283DABB446183BAADB5382F
      834D995C822C74E75E7778AABD643E977ACA16780AB20CB3415DA629D9ED9720
      0B171BBE38F6D13BC7673D957EDF989E2BD60CEC413648F037CE68D16B700E84
      77D04024E27B58810164561FA660256C7AE27FC70003C8AC3E4CC14AD8149671
      834A2E2DC83AEFA9FC4B9C822C74E75EB9F74953D62C2E7566CDF61464A1B35B
      55A5FEFE1E1AB270B161E10F6FCF3DF8F2DFCEFF7E5CF795C80664035AD4B3A1
      27022CD2E6040DD9FD06A5AC313F23C953791967B90459E8CEBD64DBC3ED29D3
      B9A44B9BE129C832CC0665B1AE70AB5F822C5C6C786FDFCC59FBA63C70F6D7E3
      EC57231B46B081E7F01913873231EE10CF1DE276C6426F1B7689C2868832BEE3
      0659636146A2A7F22F724AC56043FE8609B2F8C95C9227B288CA42DF8B5695E8
      0BB7FB25C8C2C58637F74E9BB6F3C97BCEFCEC76EB0DC8067736D87D19F37CB6
      57E67857E089B11823D910293B240276B5271BA0C30DBB462D1BDAE54D459949
      9E2ACC4CE61264A13BF7BCF5135B4E4DE692ECF48B9E822C4162C3CBBB9F7D66
      FB5FEF3A71FB65D62B570FEC463608638317F3EC29F8270E7E31E0C8A3930C2F
      87BC189E85714B1C59ED12012D1EC3BF618D4636988D7A5973A3A75A5B9AB844
      65A19F6F48FFBC5FBA894BCE962D9E822CC3CFBE99E51679965F822C5C6C786E
      E7430F6FBFE73F8FDC24E9BC62753FB2818D0DE42D6FF469C9FCE879F27326F6
      E8294C9D76F275001688E88F5C3D859B67EF5D217B626E36901E995EF0D96131
      FDFBEC91DD1373F79BF4B7A4B0B381598CC165B6C42CC9C2CA06E876C32E71D8
      2071DE74D34D9E37A25975E38D3732EF1C8C19F323CF7BD4ACBAF5C7B70C6714
      CC068BD9D8266FF69452D1CA25C84277EE6D99CB9DF27D9C6A3BE829C84267EF
      E9505814B97E09B270B1E1B17D77DFBBF5973F3F78B5C47CF52AC72E6403271B
      48EFC65CF6C20696C4DCDD0A4861308EE813B9D9006A6E6C762310171B581207
      DA29BB75586EFBC17B8FCC92385044B1EE103ECCE64CECAB2423968525E62A2D
      EBAEF696D82B1BCC116062B1013A7D8BD9E0A4662273DA7BFB747A83CE68ECEE
      EBEB77ADA1ADBEA602525E7BEDB5742F0F9D7E5D59EE708A810EA7D334321365
      B64E3DA4BCEEBA6BC562436787A95D296791AA8D4B9085EEDC95B9DF3BDBCF70
      4A9BE829C832CC064B5BA7B2C02F41164E36ECF9DDBD9B7E71C7813889F1B295
      7D3B910D122F7D90671FE7A50F724FECB55B71EF9743DE29FBBC98C3DA238B8E
      289F97B6B8C6733E4BC29958A4A100CF4106DF62F0AEA0271BA0F30DBB446403
      A485BCD2E6E6D2B2B2A4E4E4B4B4B4EAEA6AF2D6EED6D656A54A457ECBD4DAD2
      48E1E19A6B6836D4541452CFC1A992EDB5279A33B634A46DA45ED1AA4AA12678
      68CBA0A68773CD1E6A356B20F135D75C2D0A1BBA3ACD3A8DCA537AAD9A4B9085
      EEDCD5853B9D868B9C32657A0AB230D8A0EA5297F825C8C2C5863B8EDD70F7EA
      3B7FBA5772B541B2B27707B281F37E43F03A65BFBEB007E9628E5FF71B827769
      8BFFFD069E5FABFDFEC21ECC71831FC317DE0323163640FF1B6E89C806ADD9AA
      379A5A5B5AAA2AAB323232B2B3B3EBEAEAC86C3FD4EF8254AA0E8BA5BF1F0612
      4E7973133D7A80EE3E2FE73CF598B426CB264D6D2B3A222F38D4D5983238FF4F
      7B21357B68A7C2E9E8A5DEC8D46580F4D78FF9917036D8ACD4DBF65864D27209
      B2D09DBBAEE2B0B3AB8853D6124F41163A7B6F57BB5553E197208B1736DCB56E
      DCB8AD92DBB597ADE8D98E6CE0356E50B6B78765DC80F71B42336E08DEFD8610
      8C1BF4116022B2A1DD6031984C4082AAAA116C8041835C2EA7D8D0D141D80066
      D46BA9D76CB8D8907521997A8B86E6924D9AD25678589EFF4357E3B9C1F97FDA
      0B283658E4CEBE1E92B1ADB589F99A8D80D9D06DEBECEAD07BCADA69E41264A1
      3B77434D82B3B791537D524F4196613658B5367D9D5F822C5ED8F0ABD5B7DEBA
      467257FB352B7AB6211BBCDD6F50B8BE10F1BCDFE09ED8EBFD06F73ED1EBB748
      2013FF8B39EE8963FD7E03C136CF2FEC54E210FE4E2934F71B62E69D19D1C886
      DE6E6BB7D5ECA95E7B07A7BAAD74E76E6E4C773AD5DCD2780AB2D0D9FB6C06BB
      51EA97208B1736DCB251026CF8EFB61B97776F4536F0FD9D12F56B228F3E0856
      D25B89F8B081E58B6ACCDD6FA04929E2FD06FC0D2B2B1BE8EE388C1AB5D7947A
      7BECBD3D564FF5F5DAB90459E8CEDDD292EB747670CBE229C8426777D84D3D66
      B95F822C5C6C18B39B0203E891D69F2EB36D413644C1F30D41BA98C3BF1814FC
      0C3A223E6C60491C6831900DA38D0DD1752FDAE1E873F4F552FF5DEAEF77D01A
      E8EF1FD49011CF908CEEDC3BF5352355EF4B54B26136F47482FA7B6DA00147F7
      C040BF4B0E4AFDBD8382F58E6E9286A467B261A17655BA351E4AD5EDECBAE334
      05867B564AE6C8EF5CA45DF561FA1751CA06FBD08F23F0B9687C2E7A543F171D
      636C88AEDFB046FB7CD1C754898087D76B17BAE9BDF22F8F549EC07103BEB707
      DFA714ADEF534A3C71C0EDA710611114C3DFC240E2687FF66D5459841C697E1D
      90F81E563434343434910DD98086868686866C4043434343F38B0D9136336858
      26B35CBB72F1F4498F854C108ED904A57B161D7AE1DF4326081709A143BFE7E9
      DDEE3D28B37542B97FE89DE33DA8DB3E0C4B093D77205709F1CC0AD799856C10
      810DE4F0D5E91A4326E6414C8EA196F4B521137D24551E5D03CB56EB49ABED34
      A5EE04BB231964EB4B1251E076D0BFF5248483A06E1D478877BBCFA074EB84B8
      6948BBF80CCAEC0842D0829ECDC71A94B595F1CC0AD79925261B626958E42F1B
      E078EAEDB1EB34F51A556B6864311B2028890E8DAAC858C172A85DFC4E6CAD23
      9E211C0425A1BB2DD2501EC1108E840ECB9E27BBDD6750BA7542D53423DA8525
      2847F385A6053D9B8F35286B2BE39915AE330BD9201A1BE09052CA9BD48A66E1
      F279F8EAB56ACF23D8A93A1904C5B3CAED08EE50A5874C9E6C10BEE779F61AF4
      6EF70C0A5BB5ED6D20F2D250373684B85DD882B2375FE85B90C9063EAD2CEE99
      E5537866211B900DC8066403B201D9806C4036201B900DC8066403B221F46C30
      19B42D4DD5ADD21AE19235D779579BA205C2318F6079DAE74ED93EF1A538C82A
      08471FC17663BDA925316482706E6C10BEE77DEE70B7DDEE1914B6CA654D2048
      C36C9D60358DD7766109CAD17CA16F41D27C3E83D2AD2CEE99E5537866211B90
      0DA21DC1365D8DBEEE78C804E1900DE2B221942D489ACF6750BA9547331BC27B
      66211B4463835EABAAAF2EA9AF2913AE86DA72EF6A6CA88570CC23B825699EB3
      6993F8926E6615848B1C3608DFF33E77B8DB6EF70C4A6DADABA2D450CB6C9D60
      358DD7766109CAD17C51C10611CF2C9FC2330BD9203E1BDA55B2CAD2DCCAD23C
      3154E043E525108E79044BCFBCD15FB74C740DD42D671584A38FE0AEF6726DE5
      C190C9AAA9746383187BBE809786763B5BD0828AB24210A461B64E909AC67BBB
      7806E56ABED0B720693E9F41E95616FBCCF2253CB3900DC806D18E607599A664
      77C804E1900D22B321842D489ACF6750BA9547351BC27A66211B446383BAADB5
      24FF62497E867015E7F950615E1684631EC17587A7DA4BE68BAE9EB205AC8270
      91C306E17BDEE70E77DBED9E41616B515E2608D2305B27484DE3BD5D3C837235
      5F54B041C433CBA7F0CC4236201B900DC8066403B201D9806C08DA116C55956A
      8B76844C100ED9202E1B42D982A4F97C06A55B7934B321BC6716B2413436A8E4
      D2C2EC1451549075DEBB723253211CF308AEDCFBA4296B96E8EACC9ACD2A0817
      396C10BEE77DEE70B7DDEE1914B6E65FA2046998AD13A4A6F1DE2E9E41B99A2F
      2AD820E299E5537866211BC4678352D6589899542086F2337C282B3D09C2318F
      E0926D0FB7A74C175DBAB419AC8270C347B0B25857B8356482706E6C10BEE77D
      EE70B7DDEE1914B6E65EA494736144EB04A969BCB78B6750AEE60B7D0B92E6F3
      19946E6571CF2C9FC2332B286CE888214336F03F826DAA127DE1F69009C2211B
      C46543285B90349FCFA0742B8F663684F7CC12930D8618B240AE29C91A8B3213
      0B3342A1ECD404D5C823387FC30459FC64D1254F6417848B1C36846CCFD3BB9D
      3568DE8504506EFA88D60952D3786F17CFA05CCD17156CC0332BEAD9A08C210B
      E4F9067953495672C92511549499E45D791792211CF308CE5B3FB1E5D464D125
      3BFD22AB205CE4B041F89EF7B9C3DD76BB6750585390914CC46C9D20358DF776
      F10C0A85616DBEC86103F5FC33071B443CB3580521E8E5D09F5974D30018427C
      6671ED73F1D9D01C43866C4036F067033D9D6464B2812E5EC4B2812E61E8D940
      870E0B1BBC344DB0DBC5CB3E179F0DB53164C80664034F36B8CD361C696C702B
      5E04B2C1AD84A164835BE810B3C17BD304B55DBCEF73F1D9309AE78B86FD6B36
      EA5BA5F5ADD206E1923537FA90AC15C28D785B64FAE7FDD24DA2CBD9B2855510
      6EF82DF366B9459E15324138373608DFF3BE77F8C8DDEE1994DADA2A05C95B9B
      99AD13A4A6F1DE2E9E41B99A2FF42D489ACF6750BA95C53DB37C1F097866211B
      900D621DC13D1D0A8B2237648270C80671D910CA1624CDE73328DDCAA3990DE1
      3DB3C461039A6B762AA342D6A4904B85AB4DDEEC5D2A950AC2318FE0B6CCE54E
      F93EF1D5769055102E72D8207CCFFBDCE16EBBDD33286C55B6C95C52305B2758
      4DE3B55D588272345F54B041C433CBA7F0CC4236703CF2D669F757740FD5D961
      52295AD44A9970B52BE5DEA5D56A201CF30856E67EEF6C3F23BEB489AC8270C3
      47B0A5AD535910324138373608DFF33E77B8DB6EF70C0A5B356A2548AB51335B
      27584DE3B55D588272345FE85B90349FCFA0742B8B7B66F9149E59C806D15882
      6CE8B1A8BAD425211384433688CD0655889BCF6750BA9547371BC27966211B44
      634357A759A3969309E5054AA7517997C9688070CC23585DB8D369B828BE4C99
      AC827091C306E17BDEE70E77DBED9E4161AB41A7A164D0325B27584DE3B55D58
      8272345F54B041C433CBA7F0CC4236201B900DC8066403B201D9806C08DA11DC
      DBD56ED554844C100ED9202E1B42D982A4F97C06A55B7934B321BC6796186CB0
      5A455334B3C166B518B44AA35E2D5C6683C6BBE0F08570CC23585771D8D95524
      BEAC25AC827091C306E17BDEE70E77DBED9E4161ABC5AC0775761898AD13ACA6
      F1DA2E2C41399A2F2AD820E299E5537866211BC46743B7ADD3626AEFECD00957
      5787DEBB7ABA3B211CF30836D424387B1BC5579F9455106EF808B66A6DFABA90
      09C2B9B141F89EF7B9C3DD76BB6750D86AB39A40766B07B37582D5345EDB8525
      2847F385BE0549F3F90C4AB7B2B867964FE199253E1B1406A3C36574471FC81A
      644314B2A1CF66B01BA5211384433688CB8650B620693E9F41E9561ECD6C08EF
      99251A1B12CF26CE79630EB3DF0F644D34B3A1B7DB6AB5E86C5D46E1EAB69ABD
      CBD1678370CC23D8DC98EE74AA83200DAB205CE4B041F89EF7B9C3DD76BB6750
      D8DADBDD09EAEBE962B64ED09AC65BBBB005656FBEA860838867964FE199253E
      1BB24B6BA0A397299574BF1FC89AA866438FDD0E3D88DD225CBD3D56EF1A18E8
      8370CC23D8D292EB7476044116564138FA0876D84D3D6679C804E1DCD92078CF
      FBDCE16EBBDD33286C7538EC2048C36C9DA0358DB776610BCADE7CA16F41D27C
      3E83D2AD2CEE99E5537866E1FD066403B201D9806C4036201B900DC8066403B2
      01D9105236E0F30D8C23D8E1E813AEFE7E87774120B723B8535FC3A6FA60C8DC
      5A08CE9947B0A3A7B3BFD7061A70740F0CF4BBE410538E6EE21F028158D910D4
      1DEEB6DB3D83C2D60197399D4E66EB84B269E876610BCADE7C216A418FE6630F
      CAD6CAE29E593E856716B2416436AC5DB9188E27475F6F68D80081201C0425D1
      2B8FAEE138888375044338084A871E3A6A43213AB4887B9E271BE8DDEE1994C9
      0666EB84B269E876610BCADE7CA16F416609F9B4B2B867966FE199856C10970D
      F4411C32D1872FB1D23D8BC8D7B1D008C24542E8D0EF797AB77B0FCA6C9D50EE
      1F7AE7780FEAB60F23BC84786685EBCC423688C306343447C80DF7395AA419B2
      01D980866C40434336A0A1451E8A7027A0211BD0D0D0900D68C8063434346403
      5AF4B22127B20D9B0A0DD98086161E36305F9F17514236A0211BD0D0900DC886
      683545C60ADC09C806346403B2010D0DD980369AD820532ADD26F04136A0A1A1
      A18D7636784EE0836C08C064230D0F3834B4683451DE7BE1F3452362BDEE22B8
      6C20D3F5280C4664834036389D4E7A19CF31B4D16C89270EC037CE6811949614
      9BBC2FCF6A3D69B59DA6D49D60772473C9D697C414241ECC653DC97C4121D39B
      5B8248674324DF6F9045B0211BD0D0B80C3ADCA828A7DD64826E872E2D74D9DD
      1669872A5DA0C009191F70792309900D82D8E08C484336A0A1C5001B283CD8ED
      C8066403B2010D0DD9C0595AE8AFEDC67A534BA2408113C2062E6F2441A4B321
      927FA7846C4043433684920D365D8DBEEEB8408113C2062E6F2441A4B321927F
      A7846C4043433684920D5DEDE5DACA830265D554123670792309229D0D91FC3B
      2564031A1AB221A46C5097694A760B143819640387379220D2D980F71B900D68
      68C8066403B201D98086866C6067835555AA2DDA2150E084B081CB1B49806C40
      3684D9540D05FB173CB0FDAD5F6F79FD3FB9045B210DA40C203D9DC54B7AA27D
      F3EF6FA9BC845D27B22172D9A02CD6156E15287032C8060E6F2441A4B3017FA7
      14F36C48DDF6B6B325C1D9D7ED432D09D0BFF7F6F5F9959E8480059E5952B684
      BFD7C077DE211BB8D8605395E80BB70B143819FC9D12C3DBF4498FB925887436
      E0EF9442CF86203D9BCD6567963E3AD835F75A9D3683D322731A1B9C865AA7A6
      D8A9CA712AD29CED054E630D2480AFF63D3D3D7EA52721601841A58795941ADC
      65A871A91AD21CFA6C22B2010E956EF99995936EF42E48836C880D36001888A2
      890DF83BA5B0B041788BF27792B0EC31FE7DBDBDBBDBAFF424042C50E9613D48
      53E42EB2BE3D1FD21C5C781FB2010E15D2F53BAC6D5C22F080C4A64EBB56A38D
      16211B3CD9408381C64374B001EF37201BA8EE1BD6B8FA7A9BD5E657FA116C80
      4DDE948E6C403644381BBACD728B3C4BA0C0C9E03B3338BC9104C8066443176B
      62D1CBE0EF3525382558FB7AD6F454629F6C80AD0C0DFA670AD9806C886C36F4
      74282C8A5C810227840D5CDE48026403B22112EF3790B7137BF6F59D964EBFD2
      8F6003C06348F40B90992B910D81B1215A5E790DE584D246371B2C6D9DCA0281
      0227836CE0F04612443A1BF0774A31FF3B25CFBE7EB8E3F6E8EBCD66B3173650
      59BCB0C1504BE4D665D0EB910D81B101F6A14A2907A9550A50BBBAAD5DADD4B4
      83545A8D5AA705B5EB751A835E6B30E88C069DC9A8379B0C1D66634787C96231
      775A3ABA3A2D5D5D9D7092D96C56BBDDD60DEAB6F7F474F7F6F6F4F6F6F6F5F5
      3A1C7DB05BFAFB41FD032E0BE0BC8072463F1B545DEA12810227436C50794910
      E96CC0DF298D4236781907184DA6C0C70D9EBF507213B201D9806C881636E0EF
      94629E0D5CF796D9D96030B2A6E775BF01527A17B201D910D96CE8ED6AB76A2A
      040A9C103670792309F07E03B22142D930E237A9861AEF6CE04A3F820D90D8BB
      900DD1C686FCFCFCFDBE0CD2C40E1BAC5A9BBE4EA0C0C9201B38BC9104C80664
      4334B141AFD707CE0648EF5D91C186B05B14B101BA7EE990358D347A3DA48919
      36F4D90C76A354A0C009610397379200D9806C88C4FB0D8CBE3E9D7A2ACDF5D0
      3274F13A9DCEAFF424C4E073D13C1409CF4547021BA41756F87C2E1AD244021B
      E8DFC5B5B8ACB9B9992CD0EB63890D0EBBA9C72C17287042D8C0E58D24885036
      44A679B22162CD930D01FCBA343496B2650ECF971DED9B7FBF56A3F52B3D0911
      5DEF530A5E8F1F0CB76167C3A591969D9D4D16725C969797876C881D3644B2E1
      974AD1ADA5F212F4C8F085FDE0C2FBB8045B210DA4D468347EA52721540D05A9
      DBDE860147C2B2C740B0408BAC212B995962920DFCDF92949F9F7FC997419A48
      60037D11A9BEBEBE61C860995E1F336CA83CBA86EAD07B3AFB7B6DA00147F7C0
      403FB71C23E4E826B9203B3801579EDEDC12441C1BD0469BF93B7A53188C7086
      F34C4C47810EA6A7A7C7DEDD6DB3DAE063A7A5D36C361B4D26A3C108D2EBF53A
      9D0E0625C09E98BF8BD067ACA064281B21D74AFA2E0274FD3EAFE3439A486083
      42A190CBE5ACD794603D6C8D19368095EE5944BEF20B1138F1EE8D4E806C408B
      71C3F91B6836986B0FF4EA4B402E1E94F7192BA9FF8632B212B6D26CF0791D3F
      42D840180006656B6D6D0568C17F58262B63E97EC3E8B4116CD0EC7ED066B544
      8BA0B4D8F946B8E1FD069A0DFA8A5DE6FA63E6FAE3E6C6131D8D273B9A4EC37F
      58A6D6D41FD3966EA7D990979747AEA3725DC78F1036A886ACCD653050200BF4
      7A64434CB1A1DF668816211B426C5457E1559E59A26BFE86605F532243845E7D
      61AFBEA8579B4BFDA796A995CC6B4ACCEBF8C4DCAEE347081B7CFE6C2F96D8B0
      76E562B7576A072070E2DD1B9D2012AE62B9B3C16133448B900D21B61E5FE699
      25BAE66F08FEFD864A8EFB0D954C36F8BC8E8F6C08311B4857AED5D4E934F542
      447A7FA63783410A321A5B88683C90FBD52DE96BDD75F13B7E5A07AA495CC2BC
      FB3DD2C388043CD9608C16211B426C76E836BC8A930D51327F43F0D9307C2FBA
      D750CA752FDAE775FC4860C3A87A2E1ABA6C8BD9A09437A915CD42044EC8F880
      F6A66D6F03E9B56A2292A0CBF5AB5945C60AA7EA64408AA7054EC8F880E12DDE
      3301B2014D90D9AC36EFE26483DB6C0D9E1A1D6C70589A1C16A9A3A3C161691C
      14B52C85F54C36F8BC8E1F096C1855EF53423644371BA2E55DF6F41BED47034E
      DCE66F707F47B7A8F3373497A6751B8D11CD061E6FC2807EDF67578B6C083D1B
      4C066D4B5375ABB44688C0096103ED4D2E6B02B5295A884802C20679DAE74ED9
      BE40A438480B9C10360C7B636CA513C4381BA2E5B0B39B4C5D566B34FE04A2D3
      D2E95D9C6CA0E769604CE1C05C394AC60DFDB6762E211B229C0D7AADAABEBAA4
      BEA64C88C0C9E0D4D043DE1AEBAA2835D4129104840D2D49F39C4D9B02917433
      2D7042D830EC8DB1954E806C88183CD8EDD1C806B32FE364C3C89F27516088C8
      F91B82C706FE6F49F2EBB9689CF72D646C6857C92A4B732B4BF384089C1036D0
      DE2ACA0A4195E5254424016183F4CC1BFD75CB02D040DD725AE084B081F6C6DC
      4A27403644E2611745463DCCEC559C6C8892F91BA2CBA0B78D2E45351BD46DAD
      25F9174BF23384089C1036D0DE8AF232418579594424016143DDE1A9F692F901
      A8A76C012D7042D8407B636EA513201B900DC2D8E07ACB851771B241C0FC0D51
      D703D2FD205AB41FF6C80664039E2441668380F91BA09FD56AB4D12272052964
      866C08191B54726961768A408113C206DA5BFEA5F3A09CCC54229280B0A172EF
      93A6AC5901A8336B362D7042D8407B636EA513201BF02409B5099FBF21EAD840
      CA4CDF6918E53088DEC3DE6E3231D9A0943516662615081338216CA0BDE55EA4
      9473815256FA6002C286926D0FB7A74C0F40BAB419B4C0096103ED8DB9954E80
      6CC09324D426FC7D4AD1C506420564430C8E1B648D459989851982A41A6203ED
      2DEF42027CCC4D4F0465A726A8186CC8DF3041163F3900C91387054E081B686F
      B01242B8254036E049126A133E7F4374FD1A8774DF50E6D1761189E72D96287D
      0889FA6591BCA9242BB9E492208193C1DF290D79A3DFA45490919C7761300161
      43DEFA892DA7260720D9E917698113C206DA1B1D919900D9806C883EE3F8157F
      DBD0AFF8C90FF9DBF5BAC11FF21B0D3AA3516F321AB87FC8DF6527BFE577FD90
      BFA7A7A7B7B7C7F5AAC0BEA1DFF2F707F67E08EAB7B9FEFC5C95E7843FB1C486
      28B520B1C1ED457B2160835B44FFD8D06FEF8816211B900DA161033D3732FDF2
      3BD6B991091B4887AEAFDA47A972EF08B956D28FB9793E2C0D1E3C1F968E0436
      883B516E34B2C16CD4B74AEB5BA50D42044E48A74C7B93B54A41F2D666904CD6
      4A121036C8D33FEF976E0A40CE962DB4C0C9E073D143DE985BE904FCD8D0D315
      2D4236201B42C6869C9C9C8282825297D5D4D44091C832AC8411036C756303F3
      75DCB0DEF5466EF7D771BBB181BE9411996CE809D462830D16B351216B52C8A5
      42044E86DEA734E84DD92673490152A954240161435BE672A77C5F206A3B480B
      9C10360C7B636CA513F06283B3DF112D4236201B42C606E6C4C87427EE363732
      930DF42B57E9C49EAF5C65B2C1ED4A7704B2C1E75B78B9141B6CE8EC30A9142D
      6AA54C88C0096103ED4DA35682E018A6A4D59004840DCADCEF9DED6702913691
      1638216C18F6C6D84A27E0C586B6BD4FC0FF6811B201D910B26B4AE4A5D96E9D
      3873FECB116C3055F7996BDC12C31A58EFE59A12EB0BF822840D3EDFC2CBA5D8
      604357A759A39693D7A6062C7042D8407B33C0410B32684170D09204840DEAC2
      9D4EC3C54064CAA4054E081B86BD31B6D2097CB321AA0DD9806C081E1B4C2693
      D96C36180C4686C147586972991B1BF8BC7235BAD81096BCC8066403B2012DA2
      D9C0678E33261BF8BC7235BAD8E0F32DBC5C8A0D36D8AC16835669D4AB85089C
      1036D0DE2C663DA8B3C30002309004840DBA8AC3CEAEA240642DA1054E081B86
      BD31B6D209785D5382C2458BF09A12B221AA7FC3CA336584B0C11CA8C5061BBA
      6D9D16537B67874E88C0096103EDCD663581ECD60E504F77274940D860A84970
      F63606A23E292D7042D830EC8DB1954EC08B0DFD3643B408D9806C080D1BFC9D
      A520F69E7D83FEDDE75B78B9141B6CE8EDB65A2D3A5B975188C0096103EDADB7
      BB13D4D7D30572F4D94802C2067363BAD3A90E481A5AE084B081E14DE3998017
      1B1C3643B408D9806CC067DF42C7065F6F5AE4528CB0A1C76EB79ABBED162102
      27836C18F2E670D84103037D4424016183A525D7E9EC0848165AE084B081E1CD
      E29980271BF0B9E86865835951511DFF65C1CE97BD0BD240CAD054537891A2F1
      D93773ED01F22883EB77ABE57DC64A4A8632B212B646E3FD067DA0866C403620
      1B446003CFCE94B53F8535F6A664A7A3977A7B5D7787B3ABDDD9D1EA34D63B35
      45C3B2C8210DA40C4D47E3579122990D393939F9238D3CF546CCF3D9377F9F8B
      8EFCE71B74815A0CB061EDCAC5D0653B0667480D50D07CE0045C31BDB95DBA24
      092062E5D135D06577EA6B3C54CF5FE6D642EAEDDC47D78CF4C69200D910056C
      18EE4C7DC9B33FAD3EF2F6E0D6E18E5846CDB8A9291E16AC71F416EE7E2D446C
      F0A74891CC06FAD937B74E9CEBD9373244704B1CD5CF4507FC6EDA1860038D07
      8122FDBE176F7402B0D23D8BC8577E210227DEBDD109900D91CE061810C0F768
      EACB352DF8C814BDDED10B894774C487E77A74C41E5FD2873286880DFE1429C2
      AF299167DF988FBFC9878CE5D9373F9F8B8EFCF7298D72368C424336441E1B0C
      D54E632D43F52335B4DEA33FAD3A34C777470C7409211BFC2A5224B3C1EDD937
      2892F767DFC873D17DA62A1005066325B51CCDCF458FE677ED211B900D91C106
      66BFE945BCD940F55991C48611E5891236F8FBEC5B8C3D178D866C403644311B
      582FE0900B1AE162835F458A583684F7D9B7AEA1F9E3B0B7424336201BC46103
      7DB13B02D9305C2A5F6C88AE79DFA0C0B13DD14D749928F790596F178B72AFD8
      DF5BC7A2384736442D1BDC6F307068D48C1BA24BD81D471A18B49A3A37E934F5
      7C64304899321A5B40040FE457A12DE96BDD75F1BB80B40E5493B884F99353AB
      F5A4D5769A527782DD914CCBED232D5B5F92A720F1A013EB492F3F5745364409
      1B983F52F222DEBF538A4036F0BFDF808616B0B966D13128E54D6E522B9AF9C8
      ED2DAA7AAD1A040EC12DF4B38A8C154ED549C18A670A7C92EFF8DD1669872A5D
      5C814FAEC7DC900D51C206E840F928B0DFB046001BFCFA9D121A1AB201D9806C
      70B101FA503E1A1DCF37449D39836FD8E9F36783C9A06D69AA7653ABB4868FE4
      B226A6DA142D207048D8204FFBDC29DB27548A834C814FC206BBB1DED49228AE
      C0A72036F4DB3BA24531CB06E846F988E537AC73C9FAA18E5833F810B2B66458
      B0A6AFBB60D72BA1FA0DAB1F45C2BE0C4D7436E8B5AAFAEA1277D594F151635D
      D50835D482C02161434BD23C67D326A1926E660A7C1236D87435FABAE3E20A7C
      0A63434F57B42866D9C0E3851944EEE386F82FEDAD193C5FB611BAF729F12E12
      F66568A2B3A15D25AB2CCDF5501E1F5594153255595E020287840DD2336FF4D7
      2D13A881BAE54C814FC286AEF6726DE5417165D5540A6283B3DF112D1AEDEF53
      6ACD70EB4FFD7AE96968D81081AF86451B556C50B7B596E45FF450061F15E565
      32559897050287840D7587A7DA4BE60B544FD902A6C0E7201BD4659A92DDE20A
      7C0A6243DBDE27E07FB428F6D8403AD3AA4373AA0FCFF5222A81477F8A97ADD1
      D0900D416143545B6CB0A1AD2A3D79C36B0717DEE753900C1233F3AA1A0AF62F
      7860FB5BBFDEF2FA7F7209B6421A48199A6AFA552487C3114B1D13DE708E0436
      A8E4D2C2EC94C0947FE93C533999A9207048D850B9F74953D62C81EACC9ACD14
      F8246CB0AA4AB5453BC415F8443644716993D7BFE66C49A05EB7A7AFA4040BA6
      C64119EBA98F6413FC6F49003C30F3A66E7B9BCAEBF326764B02F4C5BDAED744
      045B7E1509D9806C109D0D4A59636166929B0AF829F7E208E55C48CA4A4F0287
      840D25DB1E6E4F992E50BAB4194C81CF4136288B75855BC515F80C9C0D6D7B9F
      E8A839D1517D8C122CB864AE3E194A99BCABEAB8A9EA84A9FA9453571A93D794
      604040F595EA9C21E58D54CEB0FABA213133EF99A58F0E76B5BD56A7CDE0B4B8
      7E1164A8A5E64850E5381569CEF602A7B10612C0B7F59E90985F454236201BC4
      1F37C81A8B3213DD5498C14B79171288C00FFCCF4D4FCC4E4D500DB1217FC304
      59FC648192274E066FF09F087C0EFE4E4955A22FDC2E5CD42FB58696C1A72036
      7436A5B8C9D2105275F8D67990D35013CB6C909FF72D0F36242C7B8C7F476CEF
      EE0E81FC2A12B201D9203A1BDAE54D2559C9EEBAC44B051994E83729C172DE85
      647048D890B77E62CBA9C902453B979D7E11043E456403ED5C243648CF336569
      3ADFD1981A80CC812BCDBB4C2E394DC806FFD9A029A2D6B83A629BD51602F955
      246403B221D2D8E0F6A23D71D9E0E65C5C36B83917810DA68A1F4C1587CC9587
      CD554741A6AAA386AA9381A83A3E4071FBD4579ED0559ED2559DD6559D716A4B
      910D3CAF2951EF2FF2E88843534DD622B9DEA714CB6C10E5E1E76E63B95D5F6C
      D7E6DBDAB3ADAA8CAEB6B44E59B2A525A1437AD2DC78D45477D058B3D750B5C3
      50BE455FBA4157BC565BB85293B7AC3DE76B75D6E7AACC4F54171728D33F6C4B
      7D5771FE2DC5B937E449B364675F9525BCDC7A6646EBE9692DF153DDFAA95865
      83D9A86F95D67BA8818F64AD52A6E4ADCD32592B381C7C2E3AFDF37EE9268172
      B66C610A7C0EBE33C32CB7C8B3C415F814C4067DFE06906E509BF4055BDA0B76
      04A49D5EA4E696AA6017A7F27729F376B5B9E45466C4321BDA327C8B1F1B065F
      7AEAD111775A3A4320BF8A846C605A8FB9AADB5866D717D9B479D6F62CABF262
      9722B55396646939D3D174D2DC7084C243F51E43E50E7DF9665DE97A5DD11A6D
      C1B79ABCA5341E9417E72BD33F684B7D479132573E8C87975ACF4C6F3DFD624B
      FC94D1C0068BD9A89035B94B2EE523659B6CA4142A950A1C1236B4652E77CAF7
      0955DB41A6C02761434F87C2A2C81557E053101B0C25BB5DDA43A42FD9A329DE
      1F900E78513BB754459C52161E682B1894539515CB6C682FF02D1E6C189E29C1
      A3233687C4BCB0812A15B2C10B1B3A6A7B4C95DD8632BBAEC8A6C9B3AA2F7529
      2F7429CE5378683EDDD174C2DC70D8547BC058BDDB50B95D5FB64957F2BDB668
      8DA66085266F497BCE57EA4B9FA932162A2FCC6B4B7FDF858739F2E4D7E54933
      6589AF0CE221FEC5965353629E0D9D1D2695A2C54D6AA58C8F346A25535A8D5A
      ABD58043C20665EEF7CEF63342A54D640A7C0EB2C1D2D6A92C1057E053101B2C
      0DE728D52777B864AE3FA7AF4D0E40BADA73A24B5B734E537DAEBD3A05E4D497
      C5321BC86F55BD4BD8B8C168328540386E08D87A3B1B7A3A6A5C7828B5EB0A6D
      9A5C171ED23BE52996D6B396E6F88EA6E3E6FA43A6DAFDC6EA5D868A6DFAB28D
      BA9275DAA2D59AFCE5EDB9DFB4677FA9BEF4A92AE363E5858FDAD2DE6F3BFFF6
      201ECE5278684DF867EBE9E9CC2B4BB1CA86AE4EB3462D7793DB0B56B964D069
      46C8A035190DE090B0415DB8D369B82854A64CA6C0E7101B545DEA1271053E05
      B2C1F57BA1FA731D2E99EB5302ECC76B530254CD792E696A52DB6BD2D435E920
      A7BE2296D9D0D1EC5BBCEF45B3B3C1600C81588B84F71BF8585F97B4D7520F78
      E83655741B4AECBA025B7B8E5595D9D506783867694DEC909E32371E33D7FF60
      AAD967AC023C6CA5F050FC9DB670950B0F8BD5D95FA82FFDFFEDBD09741CC779
      EF3B8EE373F3E4A31BE79EF39C778E6FF25EDE7DD7BE3941746707A01338B115
      3B9617C9961D6BA125192441121237932029C992152BDA454A14255A22299194
      48820B448AFBBE1324B11100B1EFC00C80D9F71D3303CCFBAAAAA7A7A7BB0798
      0518600655FC031C545755D75457D7AFBBBE5A5ED45D7B0EE3E177D8F0F08CF6
      EC52CDE9C59A53A543279EE61A1E281B281BD260C3853464EABC989E8C9D9712
      0981A19D519EB3C16B9C5AE98D61B576CC3A1B126589B2218E0DBEA1A0A70FE1
      C1D19ED82E7D14DBA5F763BBF4CE38BB74ED9B865BAFEAABFF4377FDC578BBF4
      33A276E97C6583CFEBB29A4679B259F4C9C8E5B070E57622304082840DE69683
      114F43A6F2367205691236043D06AFB1657A05696636F70DCF1E70769F070118
      ECDD17CCDD97D3D29549649A4C5713C9D875D5D079558715B1E5351B829EA995
      191B2C5971940D69BBB05F1BF20E623C7461BB34C2830FE181B54B9F8DB34B77
      70ECD2800771BBF4EAE1F3CB87E3ECD24F11BB74BEB221E073BBEC069EDC4E73
      32F279ED5CF9BDCEB1801B12246CB0769C8C047B3355A89F2B48936183D7E4B3
      744DAF20CD8CD8E019AC06B9076EB8FAAF3BB1ACBD37D290A5B73A3D9913CBD4
      7BD3D87BCBD8731B14B176E5331B92538AF3A22F470CB5C450010DB1392B2EA5
      2C5136C4B121308AF1301074F762BB741BC72E5D3D995D1AF090C02E1D1BB624
      B04BE72B1B8201AFD765E6C9E7B125A360C0CD5568CC130EF92041C20647EFE5
      48449FB18C5C419A840D219FD56FEB9F5E419A99B161E836D62D37D26DD7508D
      7DB02E0DD906EBD39375B021912C830DE6C13BE601A488BD2F2FD9707ACBC2A4
      1620C26B1041606EDCF3DB9E4D72F1A23D1BBE6B329AB2A094B244D9C075E363
      FA706024E4D3603CF444872D71EDD257DCDAF3EE985DFA20B64BEFC676E98FA2
      76E9B793B44BE72D1BC6FC7EAF83A780DF958CC2613F57131321102448D8E01A
      BC1D893833968B2B4893B021ECB78F39B4D32B4833233678754D200F68B4D933
      7217E41C6E49438EE1D6F4641F6E9B44B6E176DB08123C81E62E1BFC767BA2DC
      F6DF3973EABD27E071FBE49B3F01C107AE8827F1073040606EDCC1D61BD0161F
      F8C30393ACDE0A47210C843466C5A59425CA863836848CE3633A8C87216C97EE
      89B34B1B7976E963D82E7DC0DE296A977E4D8FF0F062140FBF1B063C60BBB436
      6A97A66CA06C98820D63360D51C0A6F163F92CE9C83B63F258B4A088CF9497EF
      0DD45136103711368F078D61C0837F18E3816B976E8CB34B031EE2EDD2B6B69D
      D61662977E5FDC2E7D896B975EAC39599A971762F3C657A11D0F87827C8543C9
      6822DE91EB020942B2AD55EF413BEBB67408D49DB61C43F568E9EFAAF748E2E1
      31F778D0079A08072626C663E2FD19535844E1004904522389A7CF8671BF0B14
      F63B437E0751D09796BCCE19D2185624E8E5B1E1D4917DECA4AAB92FC82D6D43
      291B2663C3B8752204783084C746E3EDD2ED1CBB34E0816397EEE7D9A5B7256F
      97CED76B41F0308D820449CA4D9FBD489EF1A751906616124F930D22381A0FCF
      414522FC3D41A9A32EAFD830619F085BC7432684079E5D9A5D4E03DBA5F1B025
      AE5D1AF0B00F2FA711B34B633C60BB74F51F74D75F18BDCAB74BD3AB46DD146C
      88E48ECB093668A84BDD513660383827C6010F16848714ECD2C7E3ECD2AD1CBB
      74DDDB86DBAF73ECD2EBB97669DA145237251B26D8BA392715CBDBDC67033473
      76EA5277B98E87697AF87145261C13E3368C0763140FD82EED4E64973E8FECD2
      03C79C42BB34E021CE2ECD0E5BFADD08B64BD3A690BA29D89005419B9E48A9A6
      43D940D990CF6C88E101D9A5C76376E9FEA85DBA05DBA5C9721A02BB74F77E1B
      5A4E6327C203D72E7D9B679746CB6924FA2ED48C47D990F36E0EF67550365036
      64CA06060F49DAA5AF45EDD2789B879EE8360FD82E6D61ECD21B057669B49C46
      A2EF4287FF513620B775E35B8D8D8D0D0D0D8D73D891ECE974BA5028C46B8867
      D4BC41D940D9303B6C8838C5ECD28341776FD0D995D02E8D96D398C42EFD06C7
      2E8D862DE5416BEBF7FB291B66900DCD33E0EEA6E2928C62301820B7940D940D
      F3800DAEA85DDACADAA5C38C5DBA57DC2E0D7860EDD23D3CBBF407C42E6D4476
      E9D8721AF4BD81BA29D8D09623CE683452365036CC173688DBA535F17669160F
      3CBB74749B8736CE360F02BB3465037553B3A1B5B5B56526DDE42F04898271DF
      27E0835EAFA76CA06C98476CE0E241C42EDD116F97BE1EB54B33DB3CD8996D1E
      B876E94D8C5DFA26B24BCF1F36D8DD7EDAEEA7C3865BD8DDBC79B37AC6DC8D49
      5D92C1A0F9C83936D0890B9338CA069EA34FE2D392DB699917CDCE85F64CD38C
      65EE14E5694F70A6D870E5CA95CBD85DC1EEF20CB84B93BA44C1D82C5DC56E70
      703017D9401F46522D2878CACBCE92B1D322F24C4AD93047724BC060327659AD
      FD69CB661B64F140563A1ABCBC99AFABEF27A72DA08E53AFB34B1B9104BDDE2F
      BDBEE3488193FEF059A17CA1334241602696F7CB54D74A4A870D4DD8B18382EE
      CC806B98D44D1E8C3DAAD3E9E87BC37C786F98B76CB05B7436D388D5A835EB35
      26DDA071A45F3FDCABD3F48C0C760D0F7468FADA867A5A06BB9BFB3B9BFADAEF
      F4B4D577B7D476DEADE968BAD5DE58DDD670BDA5FEDADDDA2BCD35979B6E5F6C
      BC79E14EF5F9861BE7EAAF9FA9BB76BAF6EAA91AD095935CE5251BA04D7739AC
      A3DABE2437011595C5A48744D0F6A21E0F34C1C3D7DE8EE8BE4C5DC7B88244C8
      92A8F03BE0EA77EA2E67284824A53556D361433B766D6D6D531A0666C5B1639F
      A8BD619ED81BE62D1B1C56BDDD321AC5C310E0C10078D0021EBA47063B87FB19
      3C0C74011E1A7BDB1B183C34DFEE68BAD97EA7BA15F05017C5C3AD8B776E5E68
      A83E5F7FE36C0C0F940D940D698C536A6D6DE536C473D05136CC1F36E4CAD45C
      C8E734B2C16933203C98010FC31603C6C3E88061A40FF0303A84F0A0ED6FD7F4
      B60E123C74603CB4D67545F1D076E706C6C355C043D3ED4B8D0C1ECE011EEAC4
      F090AF6CB05B4D837DED5A4D5FDA1A191E84445836682FBD1CD1EC4959C3955C
      41222C1BFCB66EFBE0A90C0589CC381B5AB1E38E149AE98149A2E3942619BF44
      1C9DDF307FD80037FCE8884637AA8D6A58AF4332E847B0468D0690CE6404E9CD
      2603C8623682AC1693D56AB6816C163BC86E75D86D4E87CDE9B4BB9C0E97CBE1
      7639DD6E97C7E3F27ADC5EAFC707F279FD20BF2F10F083C6C602A060702C180C
      864220B2B23F72E3D8E1B58A1907F99C4636B8EC4684078B0EF0604578D09875
      4346C0C3709F4EDB83F03010C543F7DD81AEA63E8C876EC0C3DD1AC0437B23C6
      433DC243730C0FE7593CD4C6E3215FD96031E9BADB1B7BBBDAD2574F2724C2B2
      61F0CCFA48DF4729ABFF63AE2011960D3E7387A5EB70868244B2D1A7445E1DD8
      CEA5CC5D7B2A2EC928269389B281B2218FD9E07698301EF480079B79C46A4478
      40860782070DE001191EB47DED43180FC8F0D071A7B7AD9EE0011B1E6EB63500
      1EAEDD053C20C303E0E102C203323C9CADBB1687877C658341A7696DBADDD25C
      9FB65AEF3642222C1BFA4F948F77BD99AA26BADEE20A1261D9E031DC35B55666
      28AFB175C6D9D08D5D575757676727FCEE9E01D733A94B3298C562A16CA06CC8
      6336789C66060FC8F030995D5ACBD8A5EF72EDD25D31BBF40D8E5DFA12C72E7D
      16F72C3178C85736E847861A6BAF36D45C4F5BF535D59008CB86AE834FF81B37
      A4AAB1E6E7B88244626CD0371B1B7767284864C6D9301075FDFDFDF07B70AE3A
      6841281B281BF2980D5E9795C103313CA46097BEC3B14BDF4A64976E88B74B53
      3650364CC106C3CCBBC9779F4F3218C92D65036543BEB2C1E7B6795D168407BB
      29815DBA9F67978E1BB6146797AE9ED22E9DAF6CD069FBEB6F9EAFBD71216DDD
      BA7E111261D9D0FAF943F6EA25A9CA5DBD942B4884658357D7646AF834434122
      33CE06778EB8B1B1B1B9CF060FDDF72DE3B5D0E72F1B3C76AFDBEA7159DC0EB3
      885D5A3FB55DBA2769BB34E0215FD930AAE985D7A3DB57D357F5E5339008CB86
      C61DFF6638FF64AA325F7A8A2B4824C686D13BE6FAED190A129971368473C4C1
      6D99136CA02E43376FD9E0F7DA7D1E1BC283D312B54B1B92B44B633C70ECD2CD
      53DBA5F3F6BD41D3DB709D3F992325DDBC7852C76143EDD6EF698E3D96AAB4A7
      E20489C4C629E91A2DF59F64284864C6D99043FB45CF4D36D4D4D41CCFCC410A
      1409940D019F83C1838B830762974678D05A6276E9BE38BB746F0B3B6C690ABB
      F4AD985D3A6FC72969FB1AAB017EE9ABE6CA5948846543CD870F0C1E7D2C5569
      8E2FE00A12A16CC82A1B667DDF37028660668EE281B201B3C119F03AFC1E3B36
      3C2469978E2DA7318096D368EC13B54B8B2CA741D940D930151B724B73AD6A12
      30D83273040F79D3B8537B437A6ECCEF8AC78385E02129BB346F398D4476E99A
      985D3A5FD9E0B05986FABB3543FDE94B330489C4E6455F7E79BCFFA3541519DC
      C61524125B33C3A17569AB33142432B36CA08EB261DAC140C729A5E7820137C1
      83DFEBF0213C58010F6E67D42E6D15B14BEB895D3AB69CC65DC0439276E97C65
      83CB611BD6F441FD495B3A9D0E1261D93072FDAD88764FCA1AA9E40A1261D930
      E61C760DDFCE5090086503650365C33C62C398DF89F110B54BBBA6B24B6BA376
      E97E9E5D9A5D4EE356140F5CBBF4C57C6583DB69D70D0F1AA192A42B93C90889
      B06C18BDFD41C4702265994E710589C4D8E01A718FD665284884B281B281B261
      BEB081C183CF39B55DDA1067978E0E5B4AC62ECDE0215FD9E0713B8C7AAD152A
      43BAB2DBAC9008CB067DFDCE88F56ACAB25FE70A12E1B041E7D13766284884B2
      81B281B2611EB1218687E4ECD2C664ECD27745ECD2940D940D940D940DB3CF06
      D12D7D281B44D9C01A1E26B54B8FF0EDD2CC721A42BB74BDA85D3A5FD9E00396
      9A465D0E4BDA023040222C1BCC2D07239E8694E56DE40A1261D910F418BCC696
      0C05895036CC89B1AA940D99B361CAA3940D423CF8193C24B24B6B3976E9DE94
      ECD2F9CA8680CFEDB21B7C5E7BDA1A0BB82111960DD68E9391606FCA0AF57305
      89C4D8E035F92C5D190A12A16CF0CCF4FCE4B9CF86CD1B5F5DFB8BFFF9C6D3FF
      C015F8803FE8A95FFE74D5C2C7B9021FEE66E8940DB9C88620B24BB3C3966CC2
      E5346C800723D9E6816797E62DA7216E97CE573604035EAFCBCC2FCC54140EF9
      2011960D8EDECB91883E7519B982445836847C56BFAD3F434122940D940D1EC0
      C0E5AA0F0D237D5C810FF803066E5FBBE870B84D0EAFC1EA82DFF0197CC03F77
      D9303FF77D1336527CBBB43BCE2ECD1FB62462976E8DB74BD771EDD279CB8631
      3FD0341CF6A7AD89891024C2B2C135783B1271A62E17579008CB86B0DF3EE6D0
      66284884B281B2C1036F09A8F1086923E37AA4F028FA1C89803FBC25C007DE7A
      E6E003FEB9CB86DCD274B1616EB6B6940D940D940D739E0DBAB311E30DAC6AF4
      39CA8609011B2672990DB9E8281BE6486E376F7C15DAF47028389181836B0189
      905ED9D6AAF7A009765B3A04EA4E5E8EA17AB4D677D57B6C82E131F778D0079A
      0807702FA550611185032416446713A46CA06C0036DC8A53940DFE6088B2210F
      D8302B2ECFD8C0E2214371CD754D9FBD080D71868244662E41CA8679CE06BB80
      0D76960D7DF18EB2218F5B73CA86DCCDED1C77940DB9CA0657F719AEB86C6889
      77940D940DF4BD218DB7845C8C4BD940D9601F6D38C415970D37E31D650365C3
      FC64036964CDE65E22ABA56F3259FB8948539B8B71291B281B281B281BB2CA06
      32B963EE4B6C1D56AB51A725321946921144210FE3D98F5BF6D4232F3D57E6F3
      3A9D761323A73919F97DAEF737ADA76C98A76C606F5DCA06CA866CB2C19C3B4E
      C806BBD5A41DEA61A4E94B461085B4EFD98F0B60A8A9D91B0C7AFD7E5B54F664
      04515A5ABE9866364424911C12654332F686EE7897EB6C48692371CA86696743
      AEBC3488BE37584CBA9ECE56A2DEAEB664045148FB9EFDB8EFBCF13B68E2C7C2
      0D914868223246148904935388B281F6294D31867520DEE53A1B065B6FECD9F0
      DD6DCBBE33B9F63EF7CFBA9E3A08EF186E693FF6C7BA5D0BEB76962652FDEEC5
      1006429253C023677B7BFBAD241C0483C0F38A0D63B9E344F604D5695A9BEB89
      5A92134421ED7BF6E3C27B83B66693CF7C7EC2539348114FAD501045DFFAF10C
      B2A1ABBDF5DCE9E3A7BEDC7F74FFCE9387F79F3B7D027C44DBE82307771DDDF5
      DABE4D657BDE7874DFA6255FEE7AF5C4E1BDA221AF9E3F7AF6C0A64A08F9FAAF
      F76D5A7CA6F29DEB174F8886EC6A6FB97EE9D4FE9D1F6C7BEF95BD3BDEBF7AE1
      4477471B65431A6CE0CD6F009F9C66C3F96DCF46064F46428129347812F000E1
      A1D1F7F79D453EE1E024823010929C025A7CF83DE534281272BEBD37F8C9DA52
      B920211BF42343776AAE133524278842DAF7ECC72D7BEA9173CFFFCBE8CD3F06
      873E49A4904644BADAD7ABDFFDF7996243E39DFA73C70E9E3F71E8EE9D9ABE9E
      F6B6E6BA4BA78F9C3D7AA0ADA589D740D75C397AE84FEBCFEEFD8FF6CBEF6B6E
      BFD77E69F3B97D7F3CB4755DDDF5E3BC90E003FE17F6FFB1BFF66347E78EA1DA
      8F2E1E8090158DD5A778217BDAEF9EF9B2B2A7AB95ADA603FDDD678FED6F6FAE
      A76C48C086F9322FFAC01F1E400DBDB53D62ED40B2F508D481140A7CB2E23E08
      0FAF05A8F5776A22CEA1884B2B22F087A32E2D8424A780170268FA43A1103C7B
      7ABC5EC883C56C36198DA3C3C3434343901F2376100642CE3736F8BCBE5C9190
      0D3A6D7FED8D0B2909A290F67D56E2A219CE9F3F64AF5E9248EEEAA5424194E9
      5F3383B4B9D7AF5FBD70FCD0404F07AFAE6835FD008C86FA5AB675BE79E5EC17
      1FAFEFBCB6D5DFBBDDD7F799BFEF335FFFEE40EFF6AE1B5B0F7FBCAEFEE61536
      647DF5E5C31FADEBBBF5D1F8C83EDBDDEDA337379BEF6C0D69F70CD67E04211B
      6BAEB321FB7B3ACF1D3F348ECFD87DA3FAF2F6EDCDA74E920C5C3C7DA4B7B385
      B241840DF3633D2570952F942036186A23863A2463035FC43F14D8B6EC3B3136
      981A4542C674077E5336E4F71856686A4735BD35D74E13DDBE7A26194114D2BE
      A7115737DCF7D27365EF6F5A6FB38CF675D512F576D62523AB7904E27EF1F477
      1A77FC9BE1FC938964BEF494501065A6D870E3D2E9BB776EA3DA311119F3FA3C
      168B53A70D3A74A8B16E6FBE7CF628DB3A9FDCB7E9C29EE7C303BBC63D1A529F
      C6C7434157EFD8C0A7972B5F38FEF9DB6CC8137B375EDAF74244B7BFEBF2B153
      EF7D78E495374E6DDADC7C726F48B3E7EA81DF1FFBFC2D36E4859355A3234390
      D4A74BCA7EFBE77FF6DB3F9394DFFBF5F71FF94924E036DBCC678EEDCF1536D4
      D4D4103C64E22005486792B3CCAB7558636C18BE1C19BE349966920D26ECE627
      1BDC2E77AE48E4BD41D35B7BF51451CD9593C9481765431A71CDFAA19A9ABDFA
      D68F1DC3FBFDE6E30965111144D1D66C3AF7FCBFD46EFD9EE6D86389A43D2522
      8832536C387E7097CFEB85CA111E0B057C3E8FCDE6300E7BF49D119F31149E38
      51F539DB3A1F7CFF99816BAF8D3B5A278023417728600B429831DB98B976F0DA
      6B07B73CC30D3952BB515B7BE4E86B6F9EDBF8D6AD4F3FAADBBDFDFCFB9B3ACF
      7D325AB7F1D0FBB1905F1EF8144E7D65DBF6A7FFEC2B2FFFC3DFFFE9C17FDBF3
      F8A3AFDCF70F8736AC02FF9387F7E40A1B583C64E2260783679EEDDF106343BC
      7D055A01BEC5655236A0F0940D69B1C1913B4EC416ADEDABBF7E96A8EE5A5282
      288C3D59DBD770E31C51FDF5A464330FB7B41E4E7BA01140E5DA9B0FD57CF8C0
      E0D1C71249737C81501065A6D87070F756D44BE1F7FB5C6E9FD3E9B6989C46AD
      57D711B47681FFD103BBD8D679CF1B8F053ADF0D7B86D0AD14B084BCA631CF68
      C0A31BB3B506BAB6EC7DF3F1B890864FAB776E3CF7EE7B0D95BB5BBFDCDF7FE1
      78C7D14367376D088C7EB2F7CDC7D890873EFF139CE59D9FFCF8F9FFF1779F3D
      FAEFC7963F5BFDC66BE7D6FC6EDDDF7F1BFC8F73C8E499DBFBBE5137836C40AD
      392376CB04AEE7246CE084A76C48990D36BB3D57246483C366191AEC23D20CF5
      27238802115B5ABE08867C3E9F9D28C97906A1B0DFE1680FB89BFCB6EA095F53
      22457CCD424114F2DEA0BDFCF278FF47891419DC2614449929361CD8F921D48C
      80D3EE3219DC6683135E1A0C837E7D8BCFD02CC6864D21F7C078D81FF21B839E
      91807B28E0D6F8AD4D81AEF7B92D3E66C3EECB1FBD7A73E7CEEE5347466AAE38
      7BEFEA6E5F3EF1C69AC0E82E2E45AAF67C0C6779EB473F7AFF5FFEF9F20B2F74
      ECAF743437757CFAC9F3FFF8F7423650374FD960ED24E2EDA8C3FAF3D9806CD4
      DD207E78EC498E523624C506AB2D5724362FDA363A3CC46844938C20CAD38FFF
      2C83790661BBE698ADFB60C47A31A16C9785B276EC03307CF1F47746AEBF15D1
      EE49A8914AA120CA4CB1E148E58E09F84E1E9B73B4DF6518F41806FCE62EE760
      B569A01EB5CE873E635BE7039B970D5D7F2D646F0E877D419F31E0D504DCFD80
      07BFE9A6E6C6EB07DF2F8FEB53AADFD47576C7D977DF1DBD7179CC301871183A
      CE1C6D39BE65A476D3214EEFD389C39FC3596EEDD9F5EC37FE6BFD3B1B435DDD
      11BD61EFB225E73E781BF5291DD94BD930659F522291BEA67C6083C8F0A478F1
      D840C62925143A4AD9900C1B2CB9E3786C8026DEEDB41B74234446FD68328228
      68106AEBC701C79DC8585F4205FB8582281011347AFB8388E14442994E090551
      C882DB69C79D11365C38F9C5400FEA3EF219BB3C234DDED13A7BDFB581A67313
      219F6E447B96630D3EB1F79D8BFB9E0F6B3E0BBABA83415B30600E78477D963B
      C1C19D572A5F38F6F99B5CABF5C5CADF87FA77DDFC7CE3F9F7375DF86073C391
      834D2777F87BB65F39F0FBE31C5BF4AD6B175A9AEBE0EC55CFAF59F3DFFFAF67
      BEF15FDF7FF8272736BD8A2CE19DADD72E9CA06C10DAA2E36F6ABB408C2336EA
      7C60834B3385786CF018231EC3E4A26CC8EF3533E0D93F1C0E8C053D44C1A037
      19411488084DADBE6157C47A2DA1EC37848228079FF87F51DCFA9D11EBD584B2
      5F170AA21036A41D7746D8D0D3DD7EF6E8018FC78D0747BA2263F631B70959A6
      83A10B27AAFA7B3AD8D6B9A1BEF68B8FD6F5567F38D6F7A9B77F8FB77F9FB76F
      CF58EF8EFE9B5B8F7C5CC11DED7AFBFAC5C31FAFEFB9B53DD0FF89EEE6DB4397
      5E31DC7AC7DFBBBDFFF6B6C31FAFE386BC7CE9C2A5538707077B7835757864F0
      E2C92F6A6E555336F0C6B01A46FAD0B855DD59628675759F61175642EB6730E6
      D9B310064242F87C6083CF3A85786C0838A7146543326C30194DB9221E1BD2B6
      09031BA08937B71C8C781A12CADB28144421EDFBACC49D113680FABADB4E7EB1
      A7B9FEB6CB859697F10782ED77EF9C3EB2B7AB8D3FF70D9AF5835BD75DD8F772
      5FF58796E60FFBAB3FB8B41FCD68E336F7CC14876BC70FFD69FDF9CA577A6E7D
      6C6CD9DE7BF3A30BFBFFF3D0D675C290E073E9D4910BA7BE686EB8DDD5D972F7
      4ECDC5D347CE1FAFE285A46088B1615C8F26BE4DC206383AAECF1F3604BD5388
      C78629E7518702747E437EB341DFFA71D0D31799B025965D28880211A1A9B576
      9C8C047B132AD42F144421EDFBACC49D293680DA5A9A6F5FBF7070D7D6EDEFBE
      52F9E9969B57CE265A33039AEC139FBFB16FD362B412C6C6C5C73E7B5DD8DC33
      A3630FEF39FAD9EBFB362D41AB6B6C2C3BB6EBB5442193393B05C33C6403332F
      3A09C5CD8B4E42940DF9CD0678F677F45D8944F48965140AA29036DAD17B39E5
      B8BD976731EE0CB22127D6DAA38E61437814AF9631091BAA214C1EB0219DF594
      86AEA5B49ED2946CD063370FD970EAC83EDE40AFB92CC86DDC53C5A3FFB76BF0
      7624E24C2C97501085B4D1391797B281B2617ED91B065B6F001E4EBCF1E3936F
      FE84083EB3627D2EEE58C95D87B5EDC0F2F6837CB51D7816843E1F5AC95D8795
      AEB597880D39ED5AABDE8316D36DE9E0A87B723986EAD18A4655EFE562DC1961
      C317BB372723346BE1F57FE76AEF1BBFDEF7E6A3956F3DB6FF9D270E6C5C7070
      D36FE0F7FEB71F272199A36F3F0E9E87DE7D128402BCF304F8803F49819CFDF0
      67EF1FF97CCBD1BD1F1CDBF7E1C9035B4F1FFAF84C15681B7C3875F0A313FBFF
      04FE940DF3739C92D16834194D66B3D962B13023D9ED7687C3E176B9E1A8CFEB
      F30702F0BC1F0CA5BF7E7D926B74E7F702DDF9C706704D9FBD481EC6931744C9
      DDB833C286DEDE5EB8F7E04D1A84BAEE50FFAA016430E8E1F7B056CBB2213836
      20D02057FBDE7A2C1A12FD190A0E81BCCE6E5D4F7528A8C17F9290032C1BFAFA
      FAF0006593CD66368C68BBEA6A2C66A3D50A77A201323332ACFD72CF16CA06E2
      E6DBFC862CB061761D65037573D0C5D86045CE6836E94C8661FDC8E0C8509FA6
      AF63A0BBA5AFA3A9A3B9C6ED7272D93036F265BC8E228D2241A30FAF0B10127E
      2300E88E07F5278386332D87DF38B4F6515DDDAEA0E174507732387A0C8E1236
      C04B035E81D464B5186C16DDD53D3BB7FCE6B1966BE747063B34BDADDDADF570
      F6239FBF4FD9C0B241B8685222CDE2624A940DD451970F6CD01BF416B33EE0F1
      04BC1E9FD3E9B1DB5C56B3CBAC731B477A5A6A2D66138F0DE3E3E3B80F766C62
      DC3B1E768D876DA1A00DFCD9B781281B4E4C4CA090C7DF78F5F0CB2F5CDDF9D1
      C4B8231C7220664429026C309A0C36AB61CCE70DFABDBB9E29DF56FAF497AFBE
      E2B59BBC165D7F7B3D9C1DC250361047165BC56BE646FCC150224DE027C1595C
      8495B2813AEAF2820D7ABDD138E27339000C5E87DD63B3B8CC069769D46DD28A
      B2019AA689F1E044C83B117447C66C9131F378C812C786371F456CD09F849043
      4D0D87FFF0C2F1D7FE78F8A50D5ED3C044D806CC406C78F351860D4683D9AC0B
      785C1D572E6F2BFDEDCEF2A51F3FFDA4A9BFD36B1B1DE8B863B55036C41CBC0D
      40C3C86ECF303030D0DDDD7D33EA5A5A5AFAFAFAD8A31072B6366FC845364C84
      ADE321D378D0100E8C86FDDA907720E8EE1D73768ED9DB02B666BFA5C167ACF1
      EAABBDA3573DC317DC9A33AEC113CEBE238E9E43F6AE4A5BFB67D6D64F2D773F
      36377D686ED86CAA7BC758F386E1D67FEAAB5FD65DFFFDE8D50DA397D78E5C5C
      3D7C7EF9F0B972ED99259AD38B34277F3B74E2A9A1E3BF193CF6F8244B6F7295
      37D578CA49CE69844C29FC1C493627D8A0D3E9063D76ABD76EF558CD6EB3D165
      D4B98CC36EE350F7DD1A211B2626421321CFC4986362CC361E308EC3BD14D071
      D9B0EFCD47915D417F7262227C6EF3C6C32F3D67EA6D39BDF13FEBAA768E8F19
      C11F8E12CBC491CFB7188D7AA341E373DAF7AFAFD8F6DBA7061BEAF6AC5E71E1
      C3CD5EEBC8404783D5628630940D2C1B4C0E6F926C8090940D29B061DC3611B6
      203C8CE9C38191904F83F1D083F1D01AB036F9CDF53EE36DAFFE8667F48A7BF8
      BC7BE8B46BE0B8B3EFB0A3E7A0BD73AFAD7DB7B5F5134BF347E6C60F4C0DEF19
      EBDE36D6BC6EB8F58AFEC61F74D75E18BDBA1EE36115E0417B7699F64C99E6D4
      428C8727878E2F48120FF9C486492C1F3C36F85B6F259268239E4CCA7324D9DC
      60C388A6D76536BA2D469705DE18000C232EA3C66D1CECBA7B4B840DE3814810
      816122601EF7EBC60323E1C0B0281BAC238347FFF3A58B1F6E8A04EDEDE78F1C
      7BF579BF7320A83F150A0E91114D840DFA917EEDDDA64FCA161DFCFD069FC37C
      BBF2F34F972EB48FF4F677D6DBACE6A37B3FA06C60D960B0BA92640384A46C48
      DE45261C0C1E82C6F1315DD83F1CF20D853CFD4157F798B323606F09581BFDE6
      3A9FF1965777DD3372D9AD3DEF1A3AE51C38E6ECFDC2D17DC0DEB9C7D6B6CBDA
      B2C3D2FC2773E31653FDBBC6DAB70CB75F33DCFCA3FEC64BBA6BCF8F5E593772
      69CDC88595C3E79F65F13074F2E9A1E34F0E1D5B3078F471CA86446C1086F183
      CBB811170D93CD6473800D3ADDA866A0C361184554308DC21B83CBA071EB07BC
      86BEAEA69B66211BC29EC8987522601A0F18C6FDC3E3FEA1B07F88C706626FD0
      34D59E78FDE5C1BA2B13414BC03178ECD50D6DE70F060DA7810D07362E206C30
      18804C5D2DE74EEF2A5FD272EEA4CF66708CF4EF5C525AB3EF93C18E7AABD54C
      C7B0D2F7866CB021E2C278B04E84CCA86789E0C13B18F4F4213C38DA03B6BB7E
      CB1DBFA9D667B8E9D55DF38C5C726BCFB9064F3AFB8F3A7AABECDDFB6D1D8087
      9DD696ED96A6ADE63BEF9BEA37196BDF34DC7E557FF33FF4375ED45D7B0EE3E1
      77C3808773CF68CF2ED59E5EAC39553A74E269DCB3F4C4FC64035A3B3D3936F0
      42523664850DA3A383BD6D0EBD9650C165187219063CFA5E9FA1BBB3B1DA6C12
      D8A2C3B671BF7EDC3F3AEED78E7B07C6FDBD617F9F88BD41777C7CDC3E1E304E
      040C1381D109BFB6EED0C7A7DF79316838036C38B8E937C4DEA0D7E934FD1D4E
      E388C73CEAB18046BCD6E18B5BDED9B76AE94007BC37584EECDF4AD940ED0DD9
      6043C439316117181E0683EEDEA0AB6BCC11353C986A7C066278B8E8D69C4586
      87FE2F19C343C7E7D8F0B0CDD2F4A1F9CE6653FD46AEE141870C0F15C8F07061
      05C7F0501A353C3C31DFD810DB5A632A36084326D388274A99D788279F2C7F47
      9004C90A83E52A1B464747FA3A9B1CBA01B761105E17DCFA3EB7BEC7ABEFF41B
      3A3AEE5C359B8C3C3684433678E91E1F1B190F68C7FD83E3637D21ECCF1BA734
      367A2C1CB28F07F5E341DDC4D8C84440EB36DDAD7A6955DF852DA1A0E6D0BB4F
      1236C05B4B7F57B3533FE831693CC621AF69D06B1E3077376C7FEAD757F66EB3
      59CD27F6FF89B28138DE38A509FC4154749C525A6C805707E7C4B89D6B780833
      8687DEA8E1A1D96F267669647860ECD2C8F07004191EBAF661BBF427C82E8D0D
      0F51BBF42BFAEA3FE8AEBF10B54B63C303DF2E3D85E121CFD8C0B69BBC465FC8
      06D19053B24188135136F0826533D91C6083D96CEA6E6FE86EA9E96EA9EDBE5B
      DBDD7CABABF96647E38D8E3BD79B6B2EB99CF649E737C414CF860132E9010881
      06ADEA4E04F5A78286D39737AF022136BCC7B001CEDED371A7A7B5B6B7ADAEB7
      B5BEBFADAEBF1D54FB59C5F29DAB9FF1B81D270F7C44D9401C9DDF30E36C607A
      96885DDA18B34B7BFAB15DBA23C0B34B338687D3AE8163C82E8D0C0FD82E8D0C
      0F1F21C343C3BBC6BAB70DB75F37DC8CDAA5AFAC478607848767F976E9490D0F
      796C6F107D0C17EDA599FC497C861EF067E8752407D8D0DBDB6BC2B3A091F48C
      88331AF4DA29E645C789B0411072301464E6486B5A2EC1AB83595B47DE1B8467
      87CF6693017E375FB9B4F5A9DF74D4D7D1F7865C7439CC86181ECCE341633866
      97660D0F2D7E4BA3DF54E73310BB34363C0C9DC286872F1CDDFBED1DC42EBD1D
      D9A519C303B24BEBE3ECD2BF8BDAA589E181B14B4FD2B394C76CE036FA53DAA2
      49486A6FC8061BD25B4F299144575EAA7CEBB103EF3C013CA8DAFCF4D667FE75
      D78B3F27B668DE59E035E2CB3D5B8EEDFBF0C4FEADA70E7EB46DDDB2CA775F3E
      B68FDA1B281BB2CB06627860EDD2ACE101E1A18BB54BFB627669627838890C0F
      BD55F6AEFDC8F0D0B6D38A0C0F5B19C343ED9B865BAFEAABFF4377FD45DDD5E7
      90E101D9A55710BBB486B14B4F6678C86F36D0714A738E0D741D56EA281B046C
      600D0F736842DCDCB9B801ED898DBFFEABC90561A68B0D747E036503650365C3
      9C610383873934216EEE5C5CD2F44FA2FE2B6F439849D840E745CF6936D0F68B
      3ACA86C9D8C0B54BCF810971738D0D61EF482291170B7A17E4A88BB161D86AD3
      CC928353D32B41D93077D9309726C4513650976D36C00D395BBBBCF2DA0251B7
      79E3AB4FFEFA2799881DCA99C6D619D3B80B471636E5A06C987E36CC99097194
      0DD45136F0C1D0DA549789081EC8967BFEC60D9988BB7B9FDFD69F8992DCCC2F
      47B7EDCD2336CC95097173990D70E9291B281BB2CA0668D6BD6E9BD9A8CB4404
      0FD016470C2722DA3D9988E001646CDCED1ABE9D89081EA6BC4E70D7E5447DF2
      DBED1EAF97CD6D5EB1616E4C889BB36C609F0C9264438E3EEE503650365036A4
      8B07BF3F6FD9300726C4CD4D36F05AD264D8205C5F6F2EBB1CBA01291B281BE6
      AECB6736CCF684B8BCB1375036503650365036E4131B6679421C650365036503
      650365C39C64C3AC4E88A36CA06CA06CA06CA06C98AB6C98BD0971940D940D94
      0D940D940DD9660375940D940D940D940D940DD465C486EB9F2CACDEF74222C1
      51CA06CA06CA06CA867C6043C0E7F47B1D7E8FDDE7B6795D168FD3ECB69B9C36
      83C3AAB79B476DA6618B416BD60F9946070C23FD7A6DEFA8A67B64B073B8BF43
      D3D736D4D332D0D5DCDFD9D8DBDED0D356DFDD52DBD97CBBA3E956FB9DEAD686
      EB2DF5D7EED65E69AEB9DC74FB62E3CD0B77AACF37DC38577FFD4CDDB5D3B557
      4FD580AE9C4C4673E72A93A5F4261784A16CC8073698E1069C0D51365036CC11
      368CF95D040F3E8FCDEBB67A5C16B7C3ECB21B111E2C3AC08315E14103783002
      1E86FB101E86101EB4FDED9ADED6C19EBB080F1D180FAD755D0C1E6EB6113CD4
      5D053C34D55C6ABC75F1CECD0B0DD5E7EA6F9C8DE121D7D8907925C94536CCE2
      BA73595E7D2E8E0D16B8FB6643940D940D73870D637E67C0E7F07BED0C1E9C80
      0713C6831EF060338F588D080F26DD20C1834EDB333AD4353C10C54337E0A1A9
      AFE34E6F5B4337E0E16E4D67F3ADF646C0C38DD67A848766C0C36D8287F3040F
      75A9E081B26176D9009513AADF2C2A99D5E7281B281B281BA6990DC1801BE1C1
      E70CC47A96ACA86789E0C1AAB7031E4C8007AD598FF130D2AF073C68081E3AB4
      7D6D43BD2D8087FE4E8407DCB384F0807A961AABDB1A6EA09E25C003EA59023C
      5C4078403D4B67EBAE9DA94D0E0F6C56F1DC6C433880578475F7A06977D626BF
      A9CEABAF46C3A2D0524EC71C3D5568BC6CDB4E3497E2CEFBA6BA77D01CECEA97
      D13059B4B4DF2A34BDEECC123402EAC45378598EC7261765C33C6583D5629D15
      51365036CC1D36103C04E2F06061F0400C0F96D1281E86000FC4F0A043860784
      07C6F0D08D0C0F7DED7718C3C3DDDB040F890D0F180F57A7C6438C0D68FE1DE0
      41CF2C181EC3432D5ECDE912E0C189F07008F060053C347F148F87E739782863
      A65E27DEA75AC8860CF77DA36CC8253630375ED645D940D930A7D8100CB858C3
      03C68395E081313C587502BB74BCE18167976EAD17181E183C440D0FE7E30D0F
      A79261035ABD63DC8696EE18237818C06B3AB5011E7C5C3CF41F8DE2E1538207
      BCC0DFAB313C904D23183C3C3938291E78E394FAAFBC9DF6BE6F940D39C58659
      72940D940DD3C586946EF8C46C708B181E8476696C7830EB86388687EE11BEE1
      216A97468687DB090C0F1792373C70D8E04A8C87C6181E864E47F1B0072DD481
      D6F8DB1CC5C31F301ED6623C942783071E1B0000215B4BC8DACC1778DA5AF272
      7EC33C65837D961C650365C324F561B0F5C69E0DDFDDB6EC3B936BEF73FFACEB
      A983DBD831DCD27EEC8F75BB16D6ED2C4DA4FADD8B210C844CC48698E181C583
      8B6397B60AEDD2FD8638C343FB10C603313CF4B6D50BECD25CC3439C5D7A72C3
      433C1B98D53BC6193C68193CA0453B000F35684AF6F0C5281E0EDA3BF6E0853A
      301E6ADF460BFCA1253A9E8BE1E17419DE5028211E786C7074EE0B5A1A310CEE
      866CAD5877E14FF004C151CA863C618363961C650365C3246C38BFEDD9C8E0C9
      48283085064F021EE0368646DFDF7716F984839308C240C849D8206678B02630
      3CB076E95EC003D7F030880C0F4DACE1816F97AEE5D8A593333CF0D910C38309
      2FDDA1C5EB7674011EFC9646B4DE1FC6035E27FC4B47F741BCFD1CC643C37B68
      958E5BFF8996E8408BBFAE1DBEB002ED29747A315AB8E9B8381E786CB0B4EC72
      747FE1E83DE2ECFDD2D9771CA9F74BF8D3D17D18FC4D4D9F5036E4091B9C0EE7
      AC88B281B26112361CF8C303A8A1B7B647AC1D48B61E813A9042814F56DC07B7
      31BC16A0D6DFA9893887222EAD88C01F8EBAB410727236B078983B13E244D830
      191EEEA0F5FE74D73CC317A27838C0E0A169AB291E0F2397D6203C9C5D36091E
      847D4A96B63D96D6CFF902CFB63DB44F297FD8E072BA6645940D940D93B0A1F2
      8512C406436DC45087646CE08BF88702DB967D27C60653A348C898EEC0EF64D8
      10F4BBE6D484387136306BFFA165C3C31C3C04EC2D7C3CF41D61F0D0B2838787
      D1AB1B583C68183CFC86DD8B34111B70F7517DD0D21034DD86EB8E3EA03F519F
      126543FEB0C1ED72CF8A281B281BA666C3F0E5C8F0A5C934436C10B54BCFDE84
      B8846CE0E1016F563AE6ECE4E2C10D78183C19C5C367513CBC8B37177A457FE3
      C529F120668B6E25F66776D3B7A82DBA95B2217FD8E0717B6645940D940D53B3
      41776B0ACD181BE6D484B8C9D840F080361D3286C746433E4DD0D387F080762A
      6DC0AB855F454B85633CD8BBF7A32D865AB69B9B3E64F070F315DD758287DF91
      7D23F09E424F73F190689C126F4F503A4E29DFD8E09D25971D36E8CD76CA861C
      66036ACD9178CD10EB9F880D82F0E9B061EE4C889B820D2C1E82C670808B87BB
      7E7303DAC57A94C5C361B44169FB6E060FF59BD0DE7337FF88F070657D140F4B
      010F43040F471F176783BD3D646F4322E394C8674707F85336E40F1B7CB3E4A6
      FCB69B37BE4AF09089200548A7B5EA3D060F190852807448528087B4451803E9
      50364CCD066B27AB5843CFF1E4B301D9A8BB8962E1A33EE4684A6C982313E2A6
      66031F0F43180F1D180FF5513C9C437B94F61EC61B94623C347EC0C1C3EF13E1
      41C886B0AB2FECEC09BB7A63427FF6833F6543FEB0C13F4B2E996F4BF0908920
      059254D3672F92A7FEB405294C7B52940D53B0217E6C126EE8E3472BF1D840C6
      294585C273FE24475364C39C981097141B22AE0984074B0C0F682F6B160F37D1
      36A50C1EBE60F070771B8B073D83877578CFEA67111E4E2D1A3A01785820C286
      79B6B7CF3C654360965CD6BE6DEE3ACA86884B3385786CF018231EC3E44A950D
      7361425C926CC078B0633C18F076D62C1E9AE3F03070DCC1E0619785C1C34663
      CDEBFA9BFF118787334BF17A7C4F0BD930EE33241265439EB06116D725CFDA8A
      E4940D39CC069F750AF1D810704EA934D830EB13E2926783381E1CED180F7518
      0F97DD9AB3513CECB3B5ED42CBB5A2CDAB593CBCC0C1035AAE95C706BA9ED2BC
      60C3BC752F3A166522CA862CB121E89D423C364C398F3A14488F0DB33B216EEE
      5CE5F9B9EF1B65C33C72DF8CFC8D507F19F9965092C83785A26C98693630F3A2
      9350DCBCE82494361B6671425C3EBD0A53365036CC69B7C8F44B11191E16EAB7
      BA9F0945D930D36C48673DA5A16BD3B29E526A76E9AC4C88A36CA06CA06CC892
      5BD2FB88508B3A45F4DB8E9F0B45D930D36C186CBD017838F1C68F4FBEF91322
      F8CC8AF5B9B86325771DD6B603CBDB0FF2D576E05910FA7C68A5E83AACB9E2EC
      6E3F28A7339CBB6CB03B1CB328CA86ECB97B0724427DBD5F4C3D22A26C986936
      64D3E54A5305EDACC968CA15B178A06CA06CC825B7A7EB1DA17675BE2DD4A71D
      6F0845D940D940D9900C1BF2A64F89B261BEB8CABBDB85DADDF4B1509F356C15
      0A52686F6F2F4DC24130086C89F47D11F9FCD4C8C12FFBF64274A00BBC7CA0EE
      29DDCF24916F261AF844D940D940D93047D8304B5B1930A26CC89E3BA33920D4
      C9814AA1A035170A5278E9A5976237ADDD3E3A3A0A18B873E7CEA50BE76E575F
      6B6F69D60E0D84C6FC8007CA8634D890B5FB3FB7D870EAC83EDE52517353904F
      CA865C65431ACB51B0EB4F78D25A3782BB504486D16B6A6A8EA7E8200AB7082E
      1A0E0B755E57251434E84251365036CC0A1BA09047473420DDA816A4D70DEB75
      23063D68D468D0998C20BDD964B0988D168BC96A35D9AC66BBCDE2B05B1D0E9B
      D36977B91C6E97D3E376793C6EAFD7E3F379FD3E5FC0EF0B04FC63638160702C
      180C8642C17038140E87C7C741E313D8A5DDAAE60D1B9CB3EAB2C7060206B3B9
      97C86AE99B4CD67E22160F64BDB9C1CB9B63BAFA7E626D01759C7A9D5D608E44
      F77ABFF4FA8E23054EFAC36741BED019A4E06922F0472261BC5FB2D109188229
      3A1E1EA0A5CE44940D940DF3900DB5B5B57BA77210667236C06F748E5C501C1B
      5CAE5954F6D800ADBCCB6135EAB44426C3483282281011E243333D7CEDED88EE
      CBC43A261444210B53C3EF80ABDFA9BB9C92200A894EC0604BD1113CB045008D
      7526A26CA06C98876C80A6BF3FEAFAE21DEB0F612667833977DC3C6583DD6AD2
      0EF530D2F4252388C2B2417BE9E588664F420D570A05515836F86DDDF6C15329
      09A24C231B326F50281BF2C3169D435D1C73810DEC7A6883D80D0C0C900FACFF
      946CC8959706DE7BC32C6D8FC928AB6CB098743D9DAD44BD5D6DC908A2B06C18
      3CB33ED2F75142F57F2C144461D9E0337758BA0EA72488328D6CC8DC5136CC28
      1BFAEF9C39BD6561E50B2593EBEC878B47DA2EB373DFEA76964E2EE1DC37CA86
      94D8C0BE280C0D0DA115338787E1377C66FDA764C358EEB879CA06834ED3DA5C
      4FD4929C200ACB86FE13E5E35D6F26D244D75B424114960D1EC35D536B654AF2
      1A5BA78B0D688985E446A04E322C350D369CD7559D1CA8DCDDF4F1AECEB7BFDE
      2F41F3AE0D0FFF65E45B940D42369C7AEF8924D7CC38BB7531B36646DF5966B9
      BD80132DC7ED1C42FBF9B01B825ADB232EAD70CD0CCA8694D870EBD6ADDADADA
      BABABA26EC3A3A3AC807F0017F383A251BFC70B20C346547D03486E15669F7AC
      BAACB2413F3274A7E63A51437282282C1BBA0E3EE16FDC904863CDCF09055162
      6CD037A7BA5D1A4499463640930D0D7732F27BDD3C91E69EB26146D970E28D1F
      33AD7FD013F11A23CE01D4B81BEA2223D722DA0B8CF4B7C013ADD81A89B41D78
      96593429111B6C9DC847B0D61E65434A6CA8A9A9B985DD0DEC6EDEBC493E104F
      383A251B7C5E5F2682567B922282A3D318268E0DE2DBDE67495965834EDB5F7B
      E3424A82282C1B5A3F7FC85EBD2491DCD54B8582282C1BBCBA2653C3A72909A2
      4C2F1BA0ED4E4F940D5960C3C9377F92141B2CAD840DED0797533664B34FA9BB
      BBBBA707EDC407BFE173F27D4A1956B329DBF4690CC3ADD2B37B7365950DA39A
      DE9A6BA7896E5F3D938C200ACB86C61DFF6638FF6422992F3D25144489B161F4
      8EB97E7B4A8228D3CB0668BED313650365C3BC65C3F0F0B056AB25B66876A61B
      B145833F1C9D920D1976BD73DB74E16C0938CA0B23DAEE2719268E0D505EB3A7
      ECBE37687A6BAF9E22227BD24E291D870DB55BBFA739F65822694F8908A2C46C
      D1BA464BFD272909A24C2F1BA0054F4F940D73A64FA986ED53A26CC8DA38252D
      76BC89D0C43399714A8ECC1CDBA6B3A7E6B5E9DC30A208E185E17D116E186E95
      F6CEAACBAE2D5ADB577FFD2C51DDB5A404515836D47CF8C0E0D1C71249737C81
      5010654EB1011AF1F444D93087D860EF4D9A0DDD119796B2214336E8A26E043B
      7851201F58FF29D990E14E06A44D67DB711E1EE0281B261142920F13C7069F6F
      16955536386C96A1C13E22CD507F328228B1F90D975F1EEFFF28912283DB8482
      28B1B96F0EAD4B5B9D9220CAF4B2E14EBA8EB281B261DEB2815C2C78A6B65AAD
      ECCD059FC1871C9A9A0D102F0309FB8278CFFBDC3089DE0984E908DF2D200CB7
      4AFB66D565795EB46D74788811AE6D530AA2B06C18B9FE5644BB27A1462A8582
      282C1BC69CC3AEE1DB2909A24CB3BD215D97361B2E1A0E9FD11CA8BCBB7D4FD7
      3BF70E48D06E42A65F7E33F237940D940DB9C206F00F41083107FE70744A3658
      3273A27602B6E987A389C270DBFD24C3C4B1C1EF9F4565950D6EA7DD00B50ACB
      08152B094114960DA3B73F88184E2494E994501025C606D7887BB42E254194E9
      65C368BA8EB2216D3610379D6CB075533664930D5366320B6B664CDEA64F6318
      6E95F6CFAACB2A1B3C6E87C5A427B29A8DC908A2B06CD0D7EF8C58AF2694FDBA
      501085C3069D47DF989220CAF4B2C19EAEA36C103A7F7CE76C1AA59AE638A514
      6CD1940D73820D196E0B31659B3E8D61E2D890D994BD0C955536F8BC2E87DD44
      E4725892114461D9606E3918F1342494B7512888C2B221E831788D2D2909A24C
      2F1BD2BE45291BD27B6F986D36D0714A73621DD6CCD930B99BC630DC2A1D9855
      975536047C6EAFDB46E4F3DA93114461D960ED381909F62654A85F2888126383
      D7E4B374A5248832DFD8902B1BB9F0B673C92A1BE8FC865CDBBF2187B6AE8B63
      0314D0EC29AB6C0806BC41BF9351C09D9CBC2C1B1CBD9723117D62198582282C
      1B423EABDFD69F9220CA7C63438EBA6961035D3343940DB9BEEF5B8E3EEE0C5B
      6D9A597590812CB261CC1F0A320A8793124461D9E01ABC1D893813CB25144461
      D910F6DBC71CDA940451A677ADBD97D27564ADBD34F68B9E276C207848D5F152
      38BD6561CA6BED0D5D63F09058B9BED65E0EC9435D0E3A66DFB730F3F28884DF
      1F194DC08B2451D491AAC9DBF7CD6DE9E0A87B723986EA79FBBE85C7DCE3411F
      68221C989818C70A238D0719817F3840C240E0E9DDF78DBA39EE925DA37B2B5A
      A3DB31DC024A72816EB2FD462EB281D60AEA669C0D9E79BF5F3475D445A2CFB6
      940DD451C7B0E1FB3F73C925D899BE2A91FC2FF8FF6DF8F935FC7C45F217D8FF
      2FFEB74472E3BF921FAB84FC2057555525790DFC5EBE572279E9DEAF4A9EFFCB
      3F9794C2FFCFFD9F7F21F9DD5F7D4552F9C166C996BF86F4BE2591ACFCEBAF4A
      DEF87FFE8B64F3DF4AE0FFAF4A3EFDDE7724553F2A901CFA4591A4EA373F90EC
      5DF00349D5D30F4AAAD62E92546D28977CF26D8964EBFF9048B6FCCFAF487EFF
      B75F916CFEFFBE2AA95AB74852B975B3642B3A0619ADFCDEB724953F2D9054FE
      422EA97CF2FB92AA853F921C58F290A4EA994724556B9E9254BD502ED9F5DE5B
      92AA1D5B253B0A200EFCBC8CE22ABF2EA9FCA76F4876FCD3372595FFFA2DC98E
      EFC20FA4B515FEAFFCE1DF495E2B86BFFFF5EF24950F7E1BD2FFB6E4B5EFC2E7
      87E03C8FFC6F49E5AFE05C8F164A2A9FF827C8EFF72595F05355F62349259CBB
      6AE9CF2455CBE1DC2BE067D5E39087DF409E211F1BE03B3D5726F9442691EC80
      9FB7211FAF41FE5F869FEDD2AF4ADEBAEFAB92DDEAAF499EFF5F5F937C5EFC7F
      482A8BBF2E79F93EC8E377BF21D90DF97C597AAF646B31FC2FFB067C6794E76F
      429EBF29D9FECF7F0DF9853CFF08E515E511F2FB0BC8E7138592BD4F14419940
      1E17421EE167CF62C8DF3390BF1716490E6CDB2239B46F0F9C13F2A3944836DF
      073F285FF0FF6B90B777EEFB8AE4B5FBBE0679801FD9D725BB211F3BE0E76525
      9CFF87706E948707BF25D9F7E3BF8573C2797F05E77C14CAE5E97F8272954876
      17C14F31A40DE96F859F4FEE87EF57F23528EFAF415A5F87B4E0BBFD10D2FC1E
      A4F720A4F553F80EBF40E97C5B52F53DB8AE25F0F35D4803A505FFEF4069FD13
      BADE5F83EFFE3549D583283EFC3CF80DC996EF7F43F2C1F7FE4AF2E1F7D1CF7F
      83B420BD87507AF0F3ABBF93543D00F5F407282EFCC0E7DDF0FF0E487F07A4BB
      E57E89E4C00FBF0A69419A3FFA1AF9FFA7285DF8F9F1BD9016E4EFA16F4A767F
      F0369C13E2FF10E2FD2BA4F7D0D72555BF42C7BE21A97AF49B92AA27E13C4F7F
      5B72E025B8D63F81703F85F340D8430FFDB9E4C0CF20CD5F40F84721EC1328EC
      B7E09AC0F77C14FC1EFF4BF003FF27C1FF377F2DA97A0A1D83B4CAD0718877A0
      52B26DF74EC95B7FDA2679FFD3DD92B22DFB259BFFB443F2E7F2AD926FFFCB1F
      247FF6ED3724F7CA3F95FC74D14EB8717748FE7BD12792BF2DFC50F25FFE66AD
      44F9A34F248B7FB747F2CF3FDF2DA9ACACC2F76ACF9C71129A179A179A179A17
      9A179A179A179A179A179A179A179A179A179A179A179A179A179A179A179A17
      9A179A179A179A179A179A179A179A179A179A179A179A179A179A179A179A17
      9A179A179A179A179A179A179A179A179A179A9729F3B2E0D73F78E4970F3EFC
      D093F7DEB3BE6C4D89ECDE7BD63E5BBE7265E98AB2925F97AFAD2895138FD275
      15CB56AD29F9DEF215658BCB4B1797ADBFF71EE255B6A2B47C79C9DA75AB57AF
      5A53F12FA5CB57C0B1FB16AD5A113DBE6ECDF2920D1B36DCC73D8212840F2BCA
      5656AC2DB9F79E053F7FF0815FFDFB233FF825E46175F9A28A756BCA4A20D595
      F72D5CB1FADE7BE0DC8B2ACAD797458F44FF26475794AE7DB604FD227FC6055D
      BB68D5BA951525EA7BEF91963071BEFFB39FDF7B8FAC64F506125C5E02795857
      5E51B6622DF150942C630E294B16AD5A59B166D572E688AA64C5E2F2854BC91F
      0B7EF8F0233F7BF0A11F3E0C395E5EB6A4A262157CFD7238974C5A202FBAF79E
      35E54B97713C55B202858C845CB80AFC5710FFA202994CC604E6FACB544A7264
      D1F27228A235658BE04B14C80B0B642A351C50DE7BCFC2A5CC572C5FB9B8ECB9
      927F84B0387771BE2A72C6B59040C5A2652552E64C9CBF21879CBF4816381EA8
      58D1C94BD7949596280A1470FE62387FE1BDF72C2BAFA8285B5B11F7D5D505B1
      03FCEFAF2C888FC4FDB62A4852111F33BE30D424C0C275E0B9722D2E0D6901FE
      072554BABAA27CD54AEC09E5033984E4D46CE0554B96AC2DABC05F8E7894AF44
      A7275FAE7C25BAF8AB57AD5E07FF4801AC595CB66643F9E28A65250A5C7FA17A
      4351AE295FB9345AEBCA57942E2D4381A31E654B96A09397972DC4595F59B676
      EDBDF72C59B566C58AF295242929AAE10FFFFCDF7FFEE8830FFDEBC38F4295D9
      001768D586B88B2523C52DB8AC7145AC2C50F2EB965A86FCF865AA2C50A9452A
      965A5AA0825A81EB3B2E3248B040AD2850C1D559BB08EAFAF215A56B9E2D5BB3
      68D572B8D78B9472994AAA8C3F44BE340920CDB4822DF8D1830FFD6AB2525124
      532A6A61A928E03B094B05AA8652A454144AECCFB9D9505D5740752A42577265
      056E0CBFB7A6BC7439F97B59194AA20445427FAEAD787E795909F93C5D05F3CB
      9F3CF8D0030FFFF4E147509BB86861C5CA25A58BCA4A646AA94AA12C9613AF8A
      B2E7704D5E440A8E7B94F8B00196C1D99733792E94AB0AE54AAE271B0CD2E484
      5415CB658AA222E2BF7659293E85425A2C2D2E2E6672F8F0F77FFC83077E85B3
      885B5A749B4AD926F5FEE807D4E23237EAFDCCFFB8E965EEC085A56B48F0F8BF
      5163CCFCB9F6F9B5F813BE87B9E1880F6AAC198F45CB57AD2D4B1C4E150DB7A2
      F4B9C4A1D46CA8F29589431596E09395AE8426A1A2EC7EE6FF7BEF29822FF69C
      C0B7B8041213F8CAA425156B4A9F17FACB4AD02DB76EB5F088BC84290DC1A105
      D1F27E12B5A67039783824B70FC37354CF214351A84A63BE25B202B9BC400D4D
      833C9A00E7900C1D91CB62ED1F7B8C6D9357AC5AB31ACEBFB424FA19422C2E59
      F1ECE2B225A5EB965790F607DD1F4CEBCCB448F81689792D2E5F5F0E4D2F735A
      253EAFB288F5E7C457C4027392005F54B1717C79017C2129BE9F71FB1D9FDF74
      6F71F2FDE3BCD6AD2C5B59BA7079D9E2986FAC1525B737C30B6E09C61D90B2DF
      46E0CF5C69EED59015A27291154203BE640D7C07721F2AD8B0500DCAD6AC2F5D
      5E22E7208B1C83BB10E562DD5AC234F63BC4FFC5A11EEBB780B98927AD67FF28
      9BB2A2A9F02345113CD9082A1A7B7132A866ECE557E207033857F1E4175BCDBD
      D84BD62E5CB57C31F792CBE46A855C8EC0CABFF232756161215C6638028D276A
      282A4A2A4A51157D66DDDA8AF225CF030FF029A4CC075EF1C6FB45DBDAE8275E
      609E27BEECF125C3644F78007BB1C512EFCDB9A1D85439B793945F8145EA637C
      82A42A4A93AD8A28DABAE5CB71545CC97838C8B0519317A8A4E851A7502AA86B
      F28242393A84C839E3ADDAAA0DD19316E3472FFC38CF5E127447A0E7DDC2696D
      95D0491337530F4CD14C89B43A45D01A439BAA94A5DDEA2C1023FBA497583AE5
      252E82D2944A0B8AD16B954A882EA90C1F96C9D4E47806979ABD8A3259314914
      3D43CA30B5D6A282C569AE8D7F5381F7DD524866D10AE63BC3432134FDF08611
      7F72C693E44DF4107B76FE81E8378A3FB840F868947941C3D33194B34A2E5ACC
      E8D1194A59259FBE4246494219A324932962FC5DB35DC0EC3365E6C50B5084E2
      2D548816AFAA08172F3A3A5DC58B9284E22D542457BCF04DCB5794BF90FD128E
      3E8F675EC285C5A8848B95A2255C588C4B181D9DAE1246494209A324932AE1F2
      95D92D61EEBB4C1AA5CB79D8C3892AE505626D30BC974B0B5432598168032C2F
      4215B1508AEBE194C58BA183F1B3B6041EEC163DBF687919A7A707B311B25551
      8E1E645820A9449A095456B1BAA1862CCA202B288BD9AADEEC0B6386452F53C2
      4305645D5D5C5024D27890A30A19392A287F7844964B514D55A8522CFFC2F4CA
      3FD68EC45D0278BA282E90AB0B8A94F15700E55F2695E3AF87BB218557221A04
      7D476E90D8BD58505488D28640E25745595850A8464F84C5F831857D699FF12B
      833B898B0BD46AF12BA3803604EE0F6596AE0CDBFEF0AE8C4A8E4A4F5D387B57
      4641AE0CA7DF641A2E0D7A7E83BC2B8B452F0D1C45D94647C51A2DB8347081B2
      7D692A56A122105C20850A15A24A9AB5C62BAEA36A1A2E85AC105F0A855CF452
      C05174291472F14B01ED17BA57B2D47E91AF2EB804B2227409148AAC5D82F81E
      C169B806004119EA30934A452F021C962B99C36257016E5308552C4DF12AA8D3
      BB0AECFB54DC65401944F944AFD3D2ECDD0DA4E3FEA15F3DF2F04F63FDE26ADC
      2FCE742547FB8F652515AB562D871BA76CF9FDF837EA13475EBC708A12781B5F
      F4ECC255CFDD8F3FAC295D5CBE0A75792F2D5DB7B4EC7EFC1BF56CAF8FFB5B5D
      82C3F1631596C49DB0A86479E942F813FF469DD4D0A4C0A94AD7DC1FFD80FBA8
      978979CB4A96AE295F7C3FFA85BBA52B4A17DE0F3FF0595152B6B8BCE27EF40B
      FE427DF32B56DD8F7EC15FAA9265C49C8452633FC10175C97AF1038525CBCBD7
      56A02FC2FC0F7E452570F917926FC77C00DF625252D1E0DC3FA06CA5256B5797
      AFC4398B7E005FF42D56AD5B8DC2472F82BC646DC562522ED10FE0AB00DFD28A
      756B49F9457D958C2FCA7434BE8AB9D29C4290C3B75BB71AD5A5FBC97FE05558
      B28CEF5514359308BEB1BC387A6892AFA890B28184A5A390450DDA28AFB18F70
      24CE14C33575C031055C96D5CB916D16AE0AF301BC95701945BC55257077009B
      F855585DB27055C532F12BAF282C5958BE54702F288AA2DEFCC48AF15DC23508
      B11FE1B690B247495D1509228BA69C280D393740C264A046906F01E5CC7E027F
      25DC456565EBCBCB36DC1FFD00BE2A5C8DB16FF403F8AA99FA1377EF2A0B4BD6
      94C3A545F527FA017C8B4ACA9E2345C4FC0F7EC5256B97235BC1FDE43F6807A0
      9D295B0F61F06FF85BC69C81531B55F268ADE5D75355B4968BDC2AAA685D17A9
      5C2A152E75B1586A7C442C4E213EC23D7B11A7FDE3FA1733D54AA436A8A59C63
      7115482D2B598FAF9D582C39D3A6891C5BC07631C4815399C0141DF7DA0B8F1F
      72A1D19E1DE4C119110150121AA8095FF8F669D23510B34E236B163C62206B06
      CFCA1C6F55E6DB9C0556664187FE4CF63933BD1E8B13DB5362E896A11E04192E
      CA38A62BE57000F53CCB62E9B107D5A86FA148810F4EF9D8C1EFD456C2158137
      0B65B10A77D1707AB595C25E6D0536D2ACDAB064D5A2756BF129A05920C32396
      2C2FE5195762C712F98B3D47C48E0A1F4062C7A00AAF0420AD29E394F302F646
      48B90643D9C14B8EAA4055C4ABC2F2D8C089D8108B62DC43927E1586E73364F8
      9BE62A2C32328A3B46286623E318EA1695ADC4F89AACFACB27A9FE98C22286E5
      752B131D41972F917D6E3A4D76F070B67A35BFE6319E9CCA5322EA1B5FA5D26C
      15D18D053795126E6799A0695489348D72D4FB966EBD420377E420658E378DC2
      D72E25B47DA81C511F92B05D84F76574107E64A26D63F29DD6E9DA745573B949
      8CBE40A55C7B55C50837C5F2822261D5150CF394171614A55B710176050A1936
      FCCE918A8BAF7726E35DF85D98C50545B828655219B7C9C4834BD1B822F44853
      486CE1C40F0053A090E3513BBC7654A940C37990AD4025D2CACAF0581F353EC8
      0C578C0F009483104A2527843011150AA39032A760BE66E2969E093049933FD5
      9DB7003FFDA75C45511F079469211EF6CA7BF02C1479EE54A75F4565E8F9168D
      F19BE62ABA7ACDAAA5F010BF96AD0ACC69A2FEA46957A1CB811E1BE07F448885
      654BCB57C6465694AD5C1CFB03DA8E8AF245D02E65700344CFCEE3A488B7204A
      F4CBA27EEAF5E95D5699B4085D57393C2929044D8F827F5DF1B5E25F56353161
      25735D65C8F233F3D795394DDC7555CAA102AB0B0B940A355CD7C224AFAB6CD6
      AF6BB47B6D1A99A210DEB0C01435654A5A4CC1AFC96ADC2CC698826E2A85147B
      0A9952A84283AF8A8A45995288468FE38389980221E0212D16428C2910465EC4
      9C221B4C49EF4550064FEB4AB855A5781A01AFF111BC09AA146275540D6F9222
      9514022BD58277415521B658D177C1B9FF2E887BBE53AE51D0C0E3671434564E
      2E7C50113E4BAB0B8A33E95C40F7F8DC69F71644CD2629979B5C8ABE8D5C8EC6
      2E16F28AAD08155112CF01C5B84B2B896253E0F6523AFD0F78F8EB334F01726C
      E095B213BA9806478507C3AAD158DC68FBC93B5E28C7C71135B98F012414AF02
      0B3C63976259DAD7828C1C9592AB212FE65D8D62E1D5285665F64288475414CD
      E0D590A367327492C2F8ABA152A28E54995AC1B500F32E070A80E629A200DCC7
      ED54AF07B21FA6D5D74EDABEF2E780A065CB97937704B50C3F4B2A8AE07F3475
      692DB48B8B2A62C78BE4E45913DD55457876D7A2756BD9C34AA9821C465D48F8
      7034F5F871DDB193C60FEE66FDE3269EA0EA8EC6A709921149212EB222167979
      F94A349B15F79A4B15C52A79319E04CA9F7D906EFB448A29FE510D954CBC0FFA
      768233443DB9A789FAF1265244BD63AC846F2B6C63A385283812D7BFB4A0A274
      615A14526002C17D05ED0CA4119D202255E30648CE3E64728EC9C931A58A2916
      CE21652169B7D4E8010C4DA559C939A82EC2078B123EEF883CA04C35DF53A514
      9FEFA92C147BD822FE15E831923B5D0AE5913755AA74E1DA854BC9345AF4F28D
      5E3DE11BA84821092E45662DD234F6A50AAB297319E25F29B0813D6A6FE7D524
      FC8194C473BCBF9FC7350D19215307B75C850618CBA1C591C90A852641A9E0C2
      CA706778FA8F3C68E6F3343FF2C812CFCB4AF71A0AFBBA792F7771A139CCE1CD
      6E123B822EAE983FFB26257670011A9892BA590359AFD4F08E535C0CEFD84582
      19C92AC1E5958BBD2429F1CB90E84B922A4B2F49D37A81D96B39894923DB1738
      8649B94A5A54C8D669213E17C406A8A4FE7088E6172A9069BA105181BF2C4491
      B0462871FF6C9A4F8700B002651136CBCEDCB3BA0A99E1899977DD6A4ED1829F
      144F3B8D759F730FA3771619640E17051AFA862E5B5C88C92E281A1AC1A6CB3B
      8E0B197D6D3C929A493951A5A858B66EC54276DA01461AFA324A76B2292F80B2
      900450CB49BAB1C3F1491234C85095E0FC2D67FFE63DFAF2FDD8AABF74F9F3AB
      9789D57C9103283F22DE0BD6A75F6111A090D03049FEBB0C79E84CE2D5B248BC
      93875F5D99AB8A0750CF5875E59E8457DB7025861A2B5E5D95B28242251E288A
      0A62DA2A2B4A17973150429A6C554557454606D78AD45394A48C0C692DCC9D4A
      CA8C4F9C66C62A84561078DC558832B628F1B3F1CC3356C64C04C6A7801754C8
      B84C55107BD1883B88C68DCB48CEF07368DC4165318E8AA630F3261B4B85938D
      19AFB857517808996A0E7CC6CFDFA23DAC8C27FFC41C6FCEF939BED16C70BC38
      0FF5891F1E12DFC049DFDA9CD4121D9DEC9626430E122699F0304A2FE1C15873
      8F4B713D6714EDB2F843CB3887E287DEE2C3F15EFC57EBE818CDD40790C1730E
      9A1B0CD55B9EC4501F34A937A351904A59365F79D87B51816699142854C5D89A
      C9BB8B390FD0DCFB17158D1CCDAC2B2C502AD3BB7FA1E95017446FD0B4CC6F82
      9B75F2277225E7B552F0508EFBDAE072033A950AC11D848E2AD5F8A85A36C503
      3AC307FC8DD8B1EC788D2AFE95618B547084578139C3E229769071128D632950
      A049396A21778AF1A209E8A88CE0210E3CC5A8C34C460EA32581785557AE4AA2
      EE4A297C287C92820FAA3764C212FB8CADC643BA271DE635D9F8B005D1C90869
      BD22A1050571275EA152D012083BF1D0B21819014D9E0B7D7862635A1377EBC5
      771D40A9A14116C5E2AF62D8A804D7BB188DDB508ADC34F262B20AA642268D85
      E0A52FC54BE814257A2DC3962D153947A1781F023E0B84C167416116442789A5
      FE485488BB2A809185508D1582176DB94CA4A750562CB678A152CC8AAB9261FF
      B87A847A9B0A317EB23BA042C93C2EA8531F52A14C7E4845F2833FE34756E02B
      A142C6C1627251398790215355849F5C65C8001D3FD2024D2C41A35365C2B116
      7291B116F2691B6B119D7EC8AF75FF284BDE403A4DF7B84C5DA804578473C5CE
      834CFDE1AA00DD7FCA423494536814918BB4A74599CC054093548AE6CE301076
      AE68EA96CB0239B0017553A985A30605A367D4CAF48B0D4FB152CDC4EC323A1C
      6B068663C5264BA6F1B68E1A42B4B61690B0B848703B0ABA8015AA0C076515E7
      B585120F9A5471CD22718F145252D852B40EA5F0A95F218588C5680918782640
      6DA3D82B330E8412C1C342B0018098B4D31A570610C4361AB994FF681BBBA493
      77FF2777E9632FFAD3DB9E08DEA6E27AE3057DFCBCBEF824DFC590A54D85576F
      4FD8C9CF331E247A295BB02CCD6B8517D5292AC6E371F3E25AC9D0125B0AD91C
      B71F2E885F8B21F5E6B5088DA844131F552AC1F800B9E051071A63B93CA36E24
      282E6ABE98CE1E243CF49654D319EF4352AA4937A04C217A4F28E182AB8A0B94
      6A527E49DF110AF44E0669C792E5BF3043B3881256A8D98493ED559263A62B38
      69F34328E01D1B252E2D64139F75DB86701595E9BCB3C55EE851CFBF2CB33BBB
      88F610CFD4FD2DCD83FB5B45EFEF99EB3EE62DA9448DA273C8288A86C3288AF2
      DD281AFF209AA96D945DF96B3AA7058A8F5417DD83477CC4AB327BD30263D50F
      BF56217B03C28E48F7D432D4F312EDB7941716E0D9D8705DD7B3FEA8E7048D95
      872464A4A3263AF24ACAFD53CEDFD120F50E40297AE347DB82C1A9E4DC3D9CD0
      3DA022EB4E71B64B2811ECA6C359FF5D64B71C881C5D5C5BB0FB0DCADB73BC63
      510FC82277097FD11D7B98517AA8678DD7A1C2FAF3B6955AC02E3A97C62CAD42
      5252E862C99482958C9449BD2DCB712B366BAFCBD3D439B82CFD5244C365195B
      9B5CD0552F3208025A7FC55CEB7498A652E42E6998724116A3F9824A3CED48AE
      16AEE4A012D9B94C2DD66A2A14623B97C971CF14BF9B150128BE3065718529E3
      15A68C5F9832910780EC2E809468C63F1E628FCAB3504ECA337EE95DD4A32947
      FB532998A37421A4786B41DCB373FA931CF0607AC1248742E1FA154AD18DF892
      9CE4C0997F9087931CD474924372E3C7B9ABC3A6319A0FD981954585F8F992F7
      CC2AECAB4163FF94198EE051CAA8E934274CA7DCE585A717EC4A3CEC80477625
      BBC6523A554B81B9AECEBB850D29D1335EED356E07B5D497E744555889FA1045
      DEEA65620FFA99CD5396CBF2737D4EA620D1600A5490F10B74225F38AA921632
      476935E65663CE1AEB3CF88BACC29E7A2547034FD4CCB529522731EE4C9EE964
      FC3C5D84B6B01017A44AA62405195FC9F168BB225CCCB8E78556F2492BB91C0F
      83407B1EC51E463268CAD1302E844A25B278883D910817172C161D699CC2802E
      99A0A7211F6A39B24AA082445B130B9E4894C8C2818E1617D32792949A72F13D
      35521FBA2623F55CAE2E12AFE7C5224FDE19D673753E3E79CBD5A4262BD01399
      A09E2BE4E4C91B1B2E693D9FB29E2B507F910A0D724503BDA3DBC164BC44557C
      0F5B8170B6486181C8838A8C6C0027B0B2117B1A6FF15F68E65459E9B25810DD
      0E6716E63388ACF612DD86676EE486B30FD0F4CEAA106B0E8B339A545134136B
      6BC62D160D5F263A5A3C6EB168B42F5D115E4914ADBFC85D295ACA5D295A3A67
      5600C7F623660BA7B951CF98BDA352C72EEABF52037A8B98F5D7F993218BC576
      8829161DF72656D39452ECCF1FF7A654E2A121D35CD950EBBC8CB363A18C7CB5
      E242F2D5D0E1F531124AA1CEA355E7F1005635391CBFA01EF2E1ADA887BC209B
      F11E2467F17EEBF943D2F0303A268FFC63322533DD8F35DC47978A54ABF150A7
      C2E2B8A3DC0D588B70207866E70762D1A720E928997496E12C732C138A62721E
      B4092C2F00F7442A25939D4241B0D86EAF6A26AD22362DB2AF22F70549C65439
      79A15818EE298B496A7299686AB1B31631592B66525CCFFB8A4A52486A99E030
      E76C6A524C856A4120F64485249D62361DC1972B66AE99542D1684FBDDA4242D
      34C4522464ECBBC9991415D16A2052AF5499CC5EC35BCCA5BF566BAC3192AAE0
      5E92A3ABB46E39F3BCA620D7186E3229343190E8B298690ADD80B8D941DF104D
      545ACF8B5784ECE372E618379E9C5479BCD514DCB8658B97625B3E9AA2895B9D
      B51C6B00DA2F2F83267A392A417E6BBB981DF212DBEC6C416C3FBE699E3E299C
      8EAECE641EE04C4D9FCCFF2525F9BB2BA6BE4704B9D0C562175A2572A165C599
      3DD2C915797DA1D11868FCD8AACEDECCBCF87D34D3D8FF4581AB800C0D1815D4
      01B5481D003C645607D4B9500732587B0291A2006F5B3D438B4FC00964327C86
      E2695D7C227EDBD53446EDC849552A5627C90D680E72A82AB1E379C95A2DA864
      8BE08BCA921D852E97A241DB6874AF8A44E3CF5F118E43970BC6A14B711B9AC5
      71E850D914B8AE15CD85C5B9A40907A00B176EE76C149CE6923C7266499E4201
      1A455F42E5E93F03E12D7DE4D23C5F92478957CC91CFE09A3C0A32CC7E5A9B45
      EEBED269CDCA9192CE6DD5CCCFCA51E1ED8CA5B3362B472DCDEE528552FCB4A5
      CAEAAC1C159A952397E6D85285D12DD0D3DB6080599B2C5AB366728301B678E9
      060329BE0DC6EF699FE6322D6ABC4C8B5C2A4BE6B53FA3755A54E8B53F9F2F34
      5AB203AFD35294BDB741328764A6869BAA8503EF15A2BB0B90954C84F348E0A1
      5D4EE791CCA551A7D2B93CE834569B676050BE52E4115E747D5D85D8F20968A8
      4691D89C68FEA8FC69A8CA7454FE348FCA97A90B65B262053253AEC7E32B3268
      30A17EC864681F48854A2A30562A4546358B6EABA5105B7313808CA6E3F1877C
      2AB3DD5CCAB331184E8DCB119A495C8E71CD6411392693450FD25652B8D36406
      55186D38A9C00B10611B96A0A55488D87B445A4AD22F256C2955D85F087D59FE
      D562BCB82B2A49BC8A0DBF1E23EB311E04A728668ED28ACC29CBFF1F4D3E0021}
  end
  object bsSkinOpenDialog1: TbsSkinOpenDialog
    OverwritePromt = False
    DialogWidth = 0
    DialogHeight = 0
    DialogMinWidth = 0
    DialogMinHeight = 0
    CheckFileExists = True
    MultiSelection = False
    AlphaBlend = False
    AlphaBlendValue = 225
    AlphaBlendAnimation = False
    CtrlAlphaBlend = False
    CtrlAlphaBlendValue = 225
    CtrlAlphaBlendAnimation = False
    LVHeaderSkinDataName = 'resizebutton'
    SkinData = bsSkinData1
    CtrlSkinData = bsSkinData1
    DefaultFont.Charset = GB2312_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -12
    DefaultFont.Name = #23435#20307
    DefaultFont.Style = []
    Title = #25171#24320
    Filter = #28216#25103#34917#19969#25991#20214'|*.*'
    FilterIndex = 1
    Left = 361
    Top = 195
  end
  object LoadPatchFileOpenDialog: TbsSkinOpenDialog
    OverwritePromt = False
    DialogWidth = 0
    DialogHeight = 0
    DialogMinWidth = 0
    DialogMinHeight = 0
    CheckFileExists = True
    MultiSelection = False
    AlphaBlend = False
    AlphaBlendValue = 225
    AlphaBlendAnimation = False
    CtrlAlphaBlend = False
    CtrlAlphaBlendValue = 225
    CtrlAlphaBlendAnimation = False
    LVHeaderSkinDataName = 'resizebutton'
    SkinData = bsSkinData1
    CtrlSkinData = bsSkinData1
    DefaultFont.Charset = GB2312_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -12
    DefaultFont.Name = #23435#20307
    DefaultFont.Style = []
    Title = #25171#24320
    Filter = #28216#25103#26356#26032#25991#20214'(*.TxT)|*.Txt'
    FilterIndex = 1
    Left = 297
    Top = 11
  end
  object Mes: TbsSkinMessage
    ShowAgainFlag = False
    ShowAgainFlagValue = False
    AlphaBlend = False
    AlphaBlendAnimation = False
    AlphaBlendValue = 200
    SkinData = bsSkinData1
    CtrlSkinData = bsSkinData1
    ButtonSkinDataName = 'button'
    MessageLabelSkinDataName = 'stdlabel'
    DefaultFont.Charset = GB2312_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -12
    DefaultFont.Name = #23435#20307
    DefaultFont.Style = []
    DefaultButtonFont.Charset = GB2312_CHARSET
    DefaultButtonFont.Color = clWindowText
    DefaultButtonFont.Height = -12
    DefaultButtonFont.Name = #23435#20307
    DefaultButtonFont.Style = []
    UseSkinFont = False
    Left = 27
    Top = 347
  end
  object bsSkinInputDialog1: TbsSkinInputDialog
    AlphaBlend = False
    AlphaBlendValue = 200
    AlphaBlendAnimation = False
    SkinData = bsSkinData1
    CtrlSkinData = bsSkinData1
    ButtonSkinDataName = 'button'
    LabelSkinDataName = 'sdflabel'
    EditSkinDataName = 'edit'
    DefaultLabelFont.Charset = GB2312_CHARSET
    DefaultLabelFont.Color = clWindowText
    DefaultLabelFont.Height = -12
    DefaultLabelFont.Name = #23435#20307
    DefaultLabelFont.Style = []
    DefaultButtonFont.Charset = GB2312_CHARSET
    DefaultButtonFont.Color = clWindowText
    DefaultButtonFont.Height = -11
    DefaultButtonFont.Name = 'Arial'
    DefaultButtonFont.Style = []
    DefaultEditFont.Charset = GB2312_CHARSET
    DefaultEditFont.Color = clWindowText
    DefaultEditFont.Height = -12
    DefaultEditFont.Name = #23435#20307
    DefaultEditFont.Style = []
    UseSkinFont = True
    Left = 59
    Top = 347
  end
  object bsSkinPopupMenu1: TbsSkinPopupMenu
    OnPopup = bsSkinPopupMenu1Popup
    SkinData = AddGameListFrm.bsSkinData1
    Left = 193
    Top = 123
    object N1: TMenuItem
      AutoHotkeys = maManual
      Caption = #26497#21697#26174#31034
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #33258#21160#25441#21462
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #26174#31034#21517#31216
      OnClick = N3Click
    end
  end
  object RzBalloonHints1: TRzBalloonHints
    Bitmaps.TransparentColor = clOlive
    CaptionWidth = 200
    CenterThreshold = 0
    Color = clWhite
    FrameColor = cl3DDkShadow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HintPause = 100
    ShowBalloon = False
    Left = 249
    Top = 6
  end
  object bsSkinSaveDialog1: TbsSkinSaveDialog
    OverwritePromt = False
    DialogWidth = 0
    DialogHeight = 0
    DialogMinWidth = 0
    DialogMinHeight = 0
    CheckFileExists = True
    MultiSelection = False
    AlphaBlend = False
    AlphaBlendValue = 225
    AlphaBlendAnimation = False
    CtrlAlphaBlend = False
    CtrlAlphaBlendValue = 225
    CtrlAlphaBlendAnimation = False
    LVHeaderSkinDataName = 'resizebutton'
    SkinData = bsSkinData1
    CtrlSkinData = bsSkinData1
    DefaultFont.Charset = GB2312_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -12
    DefaultFont.Name = #23435#20307
    DefaultFont.Style = []
    Title = #20445#23384#25991#20214
    Filter = 'All files|*.*'
    FilterIndex = 1
    Left = 97
    Top = 139
  end
end
