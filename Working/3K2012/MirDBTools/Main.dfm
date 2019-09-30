object FrmMain: TFrmMain
  Left = 534
  Top = 168
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '3K'#31185#25216#25968#25454#36890' V2.6 '#27979#35797#29256
  ClientHeight = 473
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
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
  object StatusBar: TRzStatusBar
    Left = 0
    Top = 454
    Width = 540
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 0
    VisualStyle = vsGradient
    object FieldStatus: TRzFieldStatus
      Left = 0
      Top = 0
      Width = 68
      Height = 19
      Align = alLeft
      AutoSize = True
      Caption = '324234234'
    end
    object RzStatusPane1: TRzStatusPane
      Left = 68
      Top = 0
      Height = 19
      Align = alLeft
      Caption = 'ID'#25968#65306
    end
  end
  object RzPageControl2: TRzPageControl
    Left = 0
    Top = 0
    Width = 540
    Height = 454
    ActivePage = TabSheet6
    Align = alClient
    Color = 16119543
    FlatColor = 10263441
    ParentColor = False
    TabColors.HighlightBar = 1350640
    TabIndex = 0
    TabOrder = 1
    TabStyle = tsRoundCorners
    FixedDimension = 18
    object TabSheet6: TRzTabSheet
      Color = 16119543
      ImageIndex = 10
      Caption = #35282#33394#36164#26009
      object RzPageControl3: TRzPageControl
        Left = 0
        Top = 82
        Width = 536
        Height = 347
        ActivePage = TabSheet9
        FlatColor = 10263441
        TabColors.HighlightBar = 1350640
        TabIndex = 1
        TabOrder = 0
        TabStyle = tsRoundCorners
        FixedDimension = 18
        object TabSheet8: TRzTabSheet
          Color = 16119543
          Caption = #22522#26412#20449#24687
          object RzMemo1: TRzMemo
            Left = 0
            Top = 221
            Width = 532
            Height = 101
            Align = alClient
            Ctl3D = True
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            Lines.Strings = (
              #20351#29992#35828#26126#65288#35831#26126#30830#33258#24049#22312#20570#20160#20040#65292#35831#21153#38543#24847#20462#25913#25968#25454#65281#65289
              '1'#12289#24615#21035#65306'0'#65293#30007#65307'1'#65293#22899
              '2'#12289#32844#19994#65306'0'#65293#25112#22763#65307'1'#65293#27861#24072#65307'2'#65293#36947#22763
              '3'#12289#29702#35770#19978#65292#31561#32423#33539#22260'1'#65293'255'#65307#37329#38065#12289'PK'#20540#12289#32463#39564#20540#65306'1'#65293'4294967295'#12290#23454#38469#21463#26381#21153#31471#38480#21046
              '4'#12289#21024#38500#29289#21697#25110#25216#33021#65306#23558'"'#29289#21697#20195#30721'"'#25110'"'#25216#33021#20195#30721'"'#22635'0'#65292#25353'"'#20445#23384#20462#25913'"'
              '5'#12289#21024#38500#26631#35760#12289#26159#21542#24072#20613#12289#38145#20179#24211#12289#30331#24405#38145#23450#22343#20026#36923#36753#20540#65292'0='#21542#65292#38750'0='#26159#65288#22914#65306'-1'#65289
              '6'#12289#24403#35282#33394#26159#33521#38596#26102#65292#24072#20613#21517#21363#20026#20027#20154#21517)
            ParentCtl3D = False
            ReadOnly = True
            TabOrder = 0
            FrameHotStyle = fsButtonDown
            FrameHotTrack = True
            FrameStyle = fsFlatBold
            FrameVisible = True
            ReadOnlyColor = clWindow
          end
          object GridBase: TRzStringGrid
            Left = 0
            Top = 0
            Width = 532
            Height = 221
            Align = alTop
            ColCount = 8
            DefaultColWidth = 65
            DefaultRowHeight = 20
            FixedColor = clInactiveCaptionText
            FixedCols = 0
            RowCount = 10
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goAlwaysShowEditor]
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            OnSelectCell = GridBaseSelectCell
            FrameColor = 12164479
            FrameVisible = True
            FixedLineColor = 12164479
            LineColor = clInactiveCaption
          end
        end
        object TabSheet9: TRzTabSheet
          Color = 16119543
          Caption = #35013#22791#20449#24687
          object GridState: TRzStringGrid
            Left = 0
            Top = 0
            Width = 532
            Height = 322
            Align = alClient
            ColCount = 6
            DefaultColWidth = 80
            RowCount = 17
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
            PopupMenu = PopupMenu2
            ScrollBars = ssVertical
            TabOrder = 0
            FrameColor = 12164479
            FrameHotTrack = True
            FrameVisible = True
            FixedLineColor = 12164479
            LineColor = clInactiveCaption
            RowHeights = (
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18)
          end
        end
        object TabSheet10: TRzTabSheet
          Color = 16119543
          Caption = #20179#24211#29289#21697
          object GridStore: TRzStringGrid
            Left = 0
            Top = 0
            Width = 532
            Height = 322
            Hint = #29289#21697'ID'#20026#29289#21697#25968#25454#24211#20013#27492#29289#21697#23545#24212#30340#13#10'ID+1'#65292#22686#21152#29289#21697#26102#65292#29289#21697#21517#31216#19981#38656#35201#13#10#20889#65292#21482#38656#29289#21697'ID'#35774#32622#27491#30830#21363#21487
            Align = alClient
            ColCount = 6
            DefaultColWidth = 80
            RowCount = 47
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
            ParentShowHint = False
            PopupMenu = pm1
            ScrollBars = ssVertical
            ShowHint = True
            TabOrder = 0
            FrameColor = 12164479
            FrameHotTrack = True
            FrameVisible = True
            FixedLineColor = 12164479
            LineColor = clInactiveCaption
          end
        end
        object TabSheet11: TRzTabSheet
          Color = 16119543
          Caption = #20462#28860#25216#33021
          object GridSkill: TRzStringGrid
            Left = 0
            Top = 40
            Width = 532
            Height = 282
            Align = alClient
            ColCount = 6
            DefaultColWidth = 80
            RowCount = 31
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
            ScrollBars = ssVertical
            TabOrder = 0
            FrameColor = 12164479
            FrameHotTrack = True
            FrameVisible = True
            FixedLineColor = 12164479
            LineColor = clInactiveCaption
          end
          object RzPanel4: TRzPanel
            Left = 0
            Top = 0
            Width = 532
            Height = 40
            Align = alTop
            BorderOuter = fsBump
            TabOrder = 1
            VisualStyle = vsGradient
            object RzToolButton5: TRzToolButton
              Left = 12
              Top = 10
              Width = 81
              Height = 22
              GradientColorStyle = gcsSystem
              ImageIndex = 2
              Images = ImageList1
              ShowCaption = True
              UseToolbarButtonLayout = False
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #28155#21152#25216#33021
              OnClick = RzToolButton5Click
            end
            object RzToolButton6: TRzToolButton
              Left = 100
              Top = 10
              Width = 81
              Height = 22
              Hint = #25805#20316#21518#38656#20445#23384#25165#33021#29983#25928'!'
              GradientColorStyle = gcsSystem
              ImageIndex = 4
              Images = ImageList1
              ShowCaption = True
              UseToolbarButtonLayout = False
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #21024#38500#25216#33021
              ParentShowHint = False
              ShowHint = True
              OnClick = RzToolButton6Click
            end
          end
        end
        object TabSheet2: TRzTabSheet
          Color = 16119543
          Caption = #32972#21253#29289#21697
          object BagItemGrid: TRzStringGrid
            Left = 0
            Top = 0
            Width = 532
            Height = 322
            Hint = #29289#21697'ID'#20026#29289#21697#25968#25454#24211#20013#27492#29289#21697#23545#24212#30340#13#10'ID+1'#65292#22686#21152#29289#21697#26102#65292#29289#21697#21517#31216#19981#38656#35201#13#10#20889#65292#21482#38656#29289#21697'ID'#35774#32622#27491#30830#21363#21487
            Align = alClient
            ColCount = 6
            DefaultColWidth = 80
            RowCount = 47
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
            ParentShowHint = False
            PopupMenu = PopupMenu1
            ScrollBars = ssVertical
            ShowHint = True
            TabOrder = 0
            FrameColor = 12164479
            FrameHotTrack = True
            FrameVisible = True
            FixedLineColor = 12164479
            LineColor = clInactiveCaption
          end
        end
        object TabSheet3: TRzTabSheet
          Color = 16119543
          Caption = #20869#21151#25216#33021
          object RzPanel6: TRzPanel
            Left = 0
            Top = 0
            Width = 532
            Height = 40
            Align = alTop
            BorderOuter = fsBump
            TabOrder = 0
            VisualStyle = vsGradient
            object RzToolButton7: TRzToolButton
              Left = 12
              Top = 10
              Width = 81
              Height = 22
              GradientColorStyle = gcsSystem
              ImageIndex = 2
              Images = ImageList1
              ShowCaption = True
              UseToolbarButtonLayout = False
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #28155#21152#25216#33021
              OnClick = RzToolButton7Click
            end
            object RzToolButton9: TRzToolButton
              Left = 100
              Top = 10
              Width = 81
              Height = 22
              Hint = #25805#20316#21518#38656#20445#23384#25165#33021#29983#25928'!'
              GradientColorStyle = gcsSystem
              ImageIndex = 4
              Images = ImageList1
              ShowCaption = True
              UseToolbarButtonLayout = False
              UseToolbarButtonSize = False
              UseToolbarShowCaption = False
              UseToolbarVisualStyle = False
              VisualStyle = vsGradient
              Caption = #21024#38500#25216#33021
              ParentShowHint = False
              ShowHint = True
              OnClick = RzToolButton9Click
            end
          end
          object GridNGSkill: TRzStringGrid
            Left = 0
            Top = 40
            Width = 532
            Height = 282
            Align = alClient
            ColCount = 6
            DefaultColWidth = 80
            RowCount = 31
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goAlwaysShowEditor]
            ScrollBars = ssVertical
            TabOrder = 1
            FrameColor = 12164479
            FrameHotTrack = True
            FrameVisible = True
            FixedLineColor = 12164479
            LineColor = clInactiveCaption
          end
        end
      end
      object RzPanel1: TRzPanel
        Left = 0
        Top = 0
        Width = 536
        Height = 82
        Align = alTop
        BorderOuter = fsBump
        TabOrder = 1
        VisualStyle = vsGradient
        object RzLabel26: TRzLabel
          Left = 8
          Top = 11
          Width = 48
          Height = 12
          Caption = #27880#20876'ID'#65306
          Transparent = True
        end
        object RzLabel34: TRzLabel
          Left = 8
          Top = 36
          Width = 48
          Height = 12
          Caption = #26597#25214'ID'#65306
          Transparent = True
        end
        object RzLabel35: TRzLabel
          Left = 184
          Top = 11
          Width = 48
          Height = 12
          Caption = #35282#33394#21517#65306
          Transparent = True
        end
        object RzLabel37: TRzLabel
          Left = 360
          Top = 11
          Width = 48
          Height = 12
          Caption = #33521#38596#21517#65306
          Transparent = True
        end
        object RzLabel36: TRzLabel
          Left = 8
          Top = 60
          Width = 48
          Height = 12
          Caption = #25214#35282#33394#65306
          Transparent = True
        end
        object RzLabel38: TRzLabel
          Left = 359
          Top = 34
          Width = 169
          Height = 12
          Caption = #35831#22312#26381#21153#31471#20851#38381#29366#24577#19979#20351#29992#65281
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object RzToolButton1: TRzToolButton
          Left = 180
          Top = 31
          Width = 81
          Height = 22
          GradientColorStyle = gcsSystem
          ImageIndex = 0
          Images = ImageList1
          ShowCaption = True
          UseToolbarButtonLayout = False
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #31934#30830#26597#25214
          OnClick = RzToolButton1Click
        end
        object RzToolButton2: TRzToolButton
          Left = 263
          Top = 31
          Width = 81
          Height = 22
          GradientColorStyle = gcsSystem
          ImageIndex = 0
          Images = ImageList1
          ShowCaption = True
          UseToolbarButtonLayout = False
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #27169#31946#26597#25214
          OnClick = RzToolButton2Click
        end
        object RzToolButton3: TRzToolButton
          Left = 180
          Top = 55
          Width = 81
          Height = 22
          GradientColorStyle = gcsSystem
          ImageIndex = 0
          Images = ImageList1
          ShowCaption = True
          UseToolbarButtonLayout = False
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #31934#30830#26597#25214
          OnClick = RzToolButton3Click
        end
        object RzToolButton4: TRzToolButton
          Left = 263
          Top = 55
          Width = 81
          Height = 22
          GradientColorStyle = gcsSystem
          ImageIndex = 0
          Images = ImageList1
          ShowCaption = True
          UseToolbarButtonLayout = False
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #27169#31946#26597#25214
          OnClick = RzToolButton4Click
        end
        object ComboBoxAccount: TRzComboBox
          Left = 54
          Top = 7
          Width = 124
          Height = 20
          Style = csDropDownList
          Ctl3D = False
          FlatButtons = True
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 0
          OnChange = ComboBoxAccountChange
        end
        object RzEdit1: TRzEdit
          Left = 54
          Top = 32
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 1
          OnChange = RzEdit1Change
        end
        object ComboBoxHum: TRzComboBox
          Left = 230
          Top = 7
          Width = 124
          Height = 20
          Style = csDropDownList
          Ctl3D = False
          FlatButtons = True
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 2
          OnChange = ComboBoxHumChange
        end
        object ComboBoxHero: TRzComboBox
          Left = 406
          Top = 7
          Width = 124
          Height = 20
          Style = csDropDownList
          Ctl3D = False
          FlatButtons = True
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 3
          OnChange = ComboBoxHeroChange
        end
        object RzEdit2: TRzEdit
          Left = 54
          Top = 56
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 4
          OnChange = RzEdit2Change
        end
        object RzBitBtn1: TRzBitBtn
          Left = 360
          Top = 52
          Width = 80
          Caption = #20445#23384#20462#25913
          HotTrack = True
          TabOrder = 5
          OnClick = RzBitBtn1Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000730E0000730E00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909
            090909090909090909E8E8E881818181818181818181818181E8E809101009E3
            1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
            1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
            1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
            E3E3E3E3E309101009E8E881ACAC81E3E3E3E3E3E381ACAC81E8E80910101009
            090909090910101009E8E881ACACAC818181818181ACACAC81E8E80910101010
            101010101010101009E8E881ACACACACACACACACACACACAC81E8E80910100909
            090909090909101009E8E881ACAC8181818181818181ACAC81E8E8091009D7D7
            D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8091009D709
            0909090909D7091009E8E881AC81D7818181818181D781AC81E8E8091009D7D7
            D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E809E309D709
            0909090909D7090909E8E881E381D7818181818181D7818181E8E8091009D7D7
            D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E80909090909
            090909090909090909E8E88181818181818181818181818181E8E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
          NumGlyphs = 2
        end
        object RzBitBtn2: TRzBitBtn
          Left = 442
          Top = 52
          Width = 80
          Caption = #21024#38500#20154#29289
          HotTrack = True
          TabOrder = 6
          OnClick = RzBitBtn2Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000630E0000630E00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E86CE8E8
            E8E8E8E8E8E8E8E8B4E8E8E8E881E8E8E8E8E8E8E8E8E8E8ACE8E8E897B46CE8
            E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8E897C7B46C
            E8E8E8E8E8E8E8B4E8E8E8E881E3AC81E8E8E8E8E8E8E8ACE8E8E8E8E897C090
            E8E8E8E8E8E8B4E8E8E8E8E8E881E381E8E8E8E8E8E8ACE8E8E8E8E8E8E890B4
            6CE8E8E8E8B46CE8E8E8E8E8E8E881AC81E8E8E8E8AC81E8E8E8E8E8E8E8E890
            B46CE8E8B46CE8E8E8E8E8E8E8E8E881AC81E8E8AC81E8E8E8E8E8E8E8E8E8E8
            90B46CB46CE8E8E8E8E8E8E8E8E8E8E881AC81AC81E8E8E8E8E8E8E8E8E8E8E8
            E890B46CE8E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8
            90B46C906CE8E8E8E8E8E8E8E8E8E8E881AC818181E8E8E8E8E8E8E8E8E8E890
            B46CE8E8906CE8E8E8E8E8E8E8E8E881AC81E8E88181E8E8E8E8E8E8E890B4B4
            6CE8E8E8E8906CE8E8E8E8E8E881ACAC81E8E8E8E88181E8E8E8E8E890C7B46C
            E8E8E8E8E8E8906CE8E8E8E881E3AC81E8E8E8E8E8E88181E8E8E8E87A907AE8
            E8E8E8E8E8E8E8E890E8E8E8AC81ACE8E8E8E8E8E8E8E8E881E8E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
          NumGlyphs = 2
        end
      end
    end
    object TabSheet7: TRzTabSheet
      Color = 16119543
      Caption = #24080#21495#31649#29702
      object RzPanel2: TRzPanel
        Left = 0
        Top = 39
        Width = 536
        Height = 390
        Align = alClient
        BorderOuter = fsBump
        TabOrder = 0
        VisualStyle = vsGradient
        object RzLabel3: TRzLabel
          Left = 69
          Top = 45
          Width = 24
          Height = 12
          Caption = #24080#21495
          Transparent = True
        end
        object RzLabel4: TRzLabel
          Left = 197
          Top = 45
          Width = 24
          Height = 12
          Caption = #23494#30721
          Transparent = True
        end
        object RzLabel5: TRzLabel
          Left = 325
          Top = 45
          Width = 24
          Height = 12
          Caption = #22995#21517
          Transparent = True
        end
        object RzLabel6: TRzLabel
          Left = 69
          Top = 89
          Width = 60
          Height = 12
          Caption = #23494#30721#25552#31034#19968
          Transparent = True
        end
        object RzLabel7: TRzLabel
          Left = 197
          Top = 89
          Width = 36
          Height = 12
          Caption = #31572#26696#19968
          Transparent = True
        end
        object RzLabel8: TRzLabel
          Left = 325
          Top = 89
          Width = 60
          Height = 12
          Caption = #23494#30721#25552#31034#20108
          Transparent = True
        end
        object RzLabel9: TRzLabel
          Left = 69
          Top = 133
          Width = 36
          Height = 12
          Caption = #31572#26696#20108
          Transparent = True
        end
        object RzLabel10: TRzLabel
          Left = 197
          Top = 133
          Width = 24
          Height = 12
          Caption = #30005#35805
          Transparent = True
        end
        object RzLabel11: TRzLabel
          Left = 325
          Top = 133
          Width = 24
          Height = 12
          Caption = #25163#26426
          Transparent = True
        end
        object RzLabel12: TRzLabel
          Left = 69
          Top = 178
          Width = 48
          Height = 12
          Caption = #32852#31995#22320#22336
          Transparent = True
        end
        object RzLabel13: TRzLabel
          Left = 197
          Top = 178
          Width = 60
          Height = 12
          Caption = #32852#31995#22320#22336#20108
          Transparent = True
        end
        object RzLabel14: TRzLabel
          Left = 325
          Top = 178
          Width = 48
          Height = 12
          Caption = #32852#31995#37038#31665
          Transparent = True
        end
        object RzLabel15: TRzLabel
          Left = 69
          Top = 222
          Width = 72
          Height = 12
          Caption = #24080#21495#21019#24314#26085#26399
          Transparent = True
        end
        object RzLabel16: TRzLabel
          Left = 197
          Top = 222
          Width = 72
          Height = 12
          Caption = #26368#21518#30331#38470#26085#26399
          Transparent = True
        end
        object RzLabel17: TRzLabel
          Left = 325
          Top = 222
          Width = 24
          Height = 12
          Caption = #29983#26085
          Transparent = True
        end
        object EdtAccount: TRzEdit
          Left = 69
          Top = 58
          Width = 121
          Height = 20
          Color = clInfoBk
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 0
        end
        object EdtPassWord: TRzEdit
          Left = 197
          Top = 58
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 1
        end
        object EdtUserName: TRzEdit
          Left = 325
          Top = 58
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 2
        end
        object EdtQuiz: TRzEdit
          Left = 69
          Top = 102
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 3
        end
        object EdtAnswer: TRzEdit
          Left = 197
          Top = 102
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 4
        end
        object EdtQuiz2: TRzEdit
          Left = 325
          Top = 102
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 5
        end
        object EdtAnswer2: TRzEdit
          Left = 69
          Top = 146
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 6
        end
        object EdtPhone: TRzEdit
          Left = 197
          Top = 146
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 7
        end
        object EdtMobilePhone: TRzEdit
          Left = 325
          Top = 146
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 8
        end
        object EdtMemo: TRzEdit
          Left = 69
          Top = 191
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 9
        end
        object EdtMemo2: TRzEdit
          Left = 197
          Top = 191
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 10
        end
        object EdtEMail: TRzEdit
          Left = 325
          Top = 191
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 11
        end
        object EdtBirthDay: TRzEdit
          Left = 325
          Top = 235
          Width = 121
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 12
        end
        object DateTimeCreateDate: TRzDateTimePicker
          Left = 69
          Top = 235
          Width = 121
          Height = 20
          Date = 39668.920058773150000000
          Time = 39668.920058773150000000
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 13
          FlatButtons = True
          FrameHotTrack = True
          FrameVisible = True
        end
        object DateTimeUpdateDate: TRzDateTimePicker
          Left = 197
          Top = 235
          Width = 121
          Height = 20
          Date = 39668.920058773150000000
          Time = 39668.920058773150000000
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 14
          FlatButtons = True
          FrameHotTrack = True
          FrameVisible = True
        end
        object RzBitBtn3: TRzBitBtn
          Left = 276
          Top = 272
          Width = 82
          Caption = #20445#23384#20462#25913
          HotTrack = True
          TabOrder = 15
          OnClick = RzBitBtn3Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000730E0000730E00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E809090909
            090909090909090909E8E8E881818181818181818181818181E8E809101009E3
            1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
            1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
            1009E3E3E309101009E8E881ACAC81E3AC81E3E3E381ACAC81E8E809101009E3
            E3E3E3E3E309101009E8E881ACAC81E3E3E3E3E3E381ACAC81E8E80910101009
            090909090910101009E8E881ACACAC818181818181ACACAC81E8E80910101010
            101010101010101009E8E881ACACACACACACACACACACACAC81E8E80910100909
            090909090909101009E8E881ACAC8181818181818181ACAC81E8E8091009D7D7
            D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E8091009D709
            0909090909D7091009E8E881AC81D7818181818181D781AC81E8E8091009D7D7
            D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E809E309D709
            0909090909D7090909E8E881E381D7818181818181D7818181E8E8091009D7D7
            D7D7D7D7D7D7091009E8E881AC81D7D7D7D7D7D7D7D781AC81E8E80909090909
            090909090909090909E8E88181818181818181818181818181E8E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
          NumGlyphs = 2
        end
        object RzBitBtn4: TRzBitBtn
          Left = 164
          Top = 272
          Width = 82
          Caption = #21024#38500#24080#21495
          HotTrack = True
          TabOrder = 16
          OnClick = RzBitBtn4Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000630E0000630E00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E86CE8E8
            E8E8E8E8E8E8E8E8B4E8E8E8E881E8E8E8E8E8E8E8E8E8E8ACE8E8E897B46CE8
            E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8E897C7B46C
            E8E8E8E8E8E8E8B4E8E8E8E881E3AC81E8E8E8E8E8E8E8ACE8E8E8E8E897C090
            E8E8E8E8E8E8B4E8E8E8E8E8E881E381E8E8E8E8E8E8ACE8E8E8E8E8E8E890B4
            6CE8E8E8E8B46CE8E8E8E8E8E8E881AC81E8E8E8E8AC81E8E8E8E8E8E8E8E890
            B46CE8E8B46CE8E8E8E8E8E8E8E8E881AC81E8E8AC81E8E8E8E8E8E8E8E8E8E8
            90B46CB46CE8E8E8E8E8E8E8E8E8E8E881AC81AC81E8E8E8E8E8E8E8E8E8E8E8
            E890B46CE8E8E8E8E8E8E8E8E8E8E8E8E881AC81E8E8E8E8E8E8E8E8E8E8E8E8
            90B46C906CE8E8E8E8E8E8E8E8E8E8E881AC818181E8E8E8E8E8E8E8E8E8E890
            B46CE8E8906CE8E8E8E8E8E8E8E8E881AC81E8E88181E8E8E8E8E8E8E890B4B4
            6CE8E8E8E8906CE8E8E8E8E8E881ACAC81E8E8E8E88181E8E8E8E8E890C7B46C
            E8E8E8E8E8E8906CE8E8E8E881E3AC81E8E8E8E8E8E88181E8E8E8E87A907AE8
            E8E8E8E8E8E8E8E890E8E8E8AC81ACE8E8E8E8E8E8E8E8E881E8E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
            E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
          NumGlyphs = 2
        end
      end
      object RzPanel3: TRzPanel
        Left = 0
        Top = 0
        Width = 536
        Height = 39
        Align = alTop
        BorderOuter = fsBump
        TabOrder = 1
        VisualStyle = vsGradient
        object RzLabel1: TRzLabel
          Left = 8
          Top = 15
          Width = 48
          Height = 12
          Caption = #27880#20876'ID'#65306
          Transparent = True
        end
        object RzLabel2: TRzLabel
          Left = 192
          Top = 15
          Width = 48
          Height = 12
          Caption = #26597#25214'ID'#65306
          Transparent = True
        end
        object ToolBtnFind: TRzToolButton
          Left = 364
          Top = 10
          Width = 81
          Height = 22
          GradientColorStyle = gcsSystem
          ImageIndex = 0
          Images = ImageList1
          ShowCaption = True
          UseToolbarButtonLayout = False
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #31934#30830#26597#25214
          OnClick = ToolBtnFindClick
        end
        object RzToolButton8: TRzToolButton
          Left = 447
          Top = 10
          Width = 81
          Height = 22
          GradientColorStyle = gcsSystem
          ImageIndex = 0
          Images = ImageList1
          ShowCaption = True
          UseToolbarButtonLayout = False
          UseToolbarButtonSize = False
          UseToolbarShowCaption = False
          UseToolbarVisualStyle = False
          VisualStyle = vsGradient
          Caption = #27169#31946#26597#25214
          OnClick = RzToolButton8Click
        end
        object ComboBoxAccount1: TRzComboBox
          Left = 54
          Top = 11
          Width = 124
          Height = 20
          Style = csDropDownList
          Ctl3D = False
          FlatButtons = True
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 0
          OnChange = ComboBoxAccount1Change
        end
        object EdtFindAccount: TRzEdit
          Left = 238
          Top = 11
          Width = 119
          Height = 20
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 1
        end
      end
    end
    object TabSheet1: TRzTabSheet
      Color = 16119543
      Caption = #25968#25454#24211#25972#29702
      object RzPanel5: TRzPanel
        Left = 0
        Top = 0
        Width = 536
        Height = 429
        Align = alClient
        BorderOuter = fsBump
        TabOrder = 0
        VisualStyle = vsGradient
        object RzGroupBox1: TRzGroupBox
          Left = 2
          Top = 2
          Width = 532
          Height = 179
          Align = alTop
          Alignment = taCenter
          Caption = #35831#22312'DBSERVER'#20851#38381#19979#20351#29992
          GroupStyle = gsStandard
          TabOrder = 0
          Transparent = True
          VisualStyle = vsGradient
          object RzLabel19: TRzLabel
            Left = 164
            Top = 20
            Width = 216
            Height = 12
            Caption = #36215#27809#26377#30331#38470#36807#24182#19988#31561#32423#26410#21040'          '#32423
            Transparent = True
          end
          object RzLabel21: TRzLabel
            Left = 164
            Top = 43
            Width = 108
            Height = 12
            Caption = #36215#27809#26377#30331#38470#36807#30340#35282#33394
            Transparent = True
          end
          object RzSpinEdit2: TRzSpinEdit
            Left = 312
            Top = 16
            Width = 54
            Height = 20
            AllowKeyEdit = True
            Max = 65535.000000000000000000
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 0
          end
          object RzBitBtn6: TRzBitBtn
            Left = 364
            Top = 88
            Width = 63
            Caption = #28165#29702
            HotTrack = True
            TabOrder = 1
            OnClick = RzBitBtn6Click
            Glyph.Data = {
              36060000424D3606000000000000360400002800000020000000100000000100
              08000000000000020000530D0000530D00000001000000000000000000003300
              00006600000099000000CC000000FF0000000033000033330000663300009933
              0000CC330000FF33000000660000336600006666000099660000CC660000FF66
              000000990000339900006699000099990000CC990000FF99000000CC000033CC
              000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
              0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
              330000333300333333006633330099333300CC333300FF333300006633003366
              33006666330099663300CC663300FF6633000099330033993300669933009999
              3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
              330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
              66006600660099006600CC006600FF0066000033660033336600663366009933
              6600CC336600FF33660000666600336666006666660099666600CC666600FF66
              660000996600339966006699660099996600CC996600FF99660000CC660033CC
              660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
              6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
              990000339900333399006633990099339900CC339900FF339900006699003366
              99006666990099669900CC669900FF6699000099990033999900669999009999
              9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
              990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
              CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
              CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
              CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
              CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
              CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
              FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
              FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
              FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
              FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
              000000808000800000008000800080800000C0C0C00080808000191919004C4C
              4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
              6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000E8D7E8D7D7E8
              E8E8E8E8E8E8E8E8E8E8E8D7E8D7D7E8E8E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7
              D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7DF
              6C6C6CE8E8E8E8E8E8E8D7D7D7D7D7DF565656E8E8E8E8E8E8E8D7D7D7D7DF90
              6C6C6C6CE8E8E8E8E8E8D7D7D7D7DF8156565656E8E8E8E8E8E8D7D7D7D79090
              906C6C6C6CE8E8E8E8E8D7D7D7D781818156565656E8E8E8E8E8D7E8D7E8B490
              90906C6C6C7EE8E8E8E8D7E8D7E8AC81818156565656E8E8E8E8E8E8E8E8B4B4
              9090906C7EA87EE8E8E8E8E8E8E8ACAC81818156568156E8E8E8E8E8E8E8E8B4
              B490907EA8A8A87EE8E8E8E8E8E8E8ACAC81815681818156E8E8E8E8E8E8E8E8
              B4D8A8D2D2A8A8A87EE8E8E8E8E8E8E8AC5681ACAC81818156E8E8E8E8E8E8E8
              E8A8D2D7DED2A8A8A87EE8E8E8E8E8E8E881ACD7DEAC81818156E8E8E8E8E8E8
              E8E8A8D2D7DED2A87E09E8E8E8E8E8E8E8E881ACD7DEAC815656E8E8E8E8E8E8
              E8E8E8A8D2D7D27E1009E8E8E8E8E8E8E8E8E881ACD7AC568156E8E8E8E8E8E8
              E8E8E8E8A8D2A8101010E8E8E8E8E8E8E8E8E8E881AC81818181E8E8E8E8E8E8
              E8E8E8E8E8A817171010E8E8E8E8E8E8E8E8E8E8E881ACAC8181E8E8E8E8E8E8
              E8E8E8E8E8E809171710E8E8E8E8E8E8E8E8E8E8E8E856ACAC81E8E8E8E8E8E8
              E8E8E8E8E8E8E8091717E8E8E8E8E8E8E8E8E8E8E8E8E856ACAC}
            NumGlyphs = 2
          end
          object RzDateTimeEdit1: TRzDateTimeEdit
            Left = 40
            Top = 16
            Width = 119
            Height = 20
            Date = 39935.000000000000000000
            EditType = etDate
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 2
          end
          object RzDateTimeEdit2: TRzDateTimeEdit
            Left = 39
            Top = 41
            Width = 121
            Height = 20
            Date = 39935.000000000000000000
            EditType = etDate
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 3
          end
          object RzRadioButton1: TRzRadioButton
            Left = 24
            Top = 17
            Width = 15
            Height = 17
            HotTrack = True
            TabOrder = 4
            Transparent = True
          end
          object RzRadioButton2: TRzRadioButton
            Left = 24
            Top = 43
            Width = 15
            Height = 17
            HotTrack = True
            TabOrder = 5
            Transparent = True
          end
          object RzCheckBox2: TRzCheckBox
            Left = 24
            Top = 67
            Width = 139
            Height = 17
            Caption = #28165#29702#35282#33394'('#24050#21024#38500#30340')'
            HotTrack = True
            State = cbUnchecked
            TabOrder = 6
            Transparent = True
          end
          object RzCheckBox1: TRzCheckBox
            Left = 25
            Top = 124
            Width = 208
            Height = 17
            Hint = #21482#28165#29702#20154#29289','#19981#28165#29702#33521#38596#25968#25454
            Caption = #28165#29702#31561#32423#23567#20110'          '#30340#35282#33394
            HotTrack = True
            ParentShowHint = False
            ShowHint = True
            State = cbUnchecked
            TabOrder = 7
            Transparent = True
          end
          object RzSpinEdit4: TRzSpinEdit
            Left = 120
            Top = 121
            Width = 54
            Height = 20
            AllowKeyEdit = True
            Max = 65535.000000000000000000
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 8
          end
          object RzCheckBox4: TRzCheckBox
            Left = 25
            Top = 143
            Width = 112
            Height = 17
            Caption = #28165#29702#26080#36134#21495#35282#33394
            HotTrack = True
            State = cbUnchecked
            TabOrder = 9
            Transparent = True
          end
          object RzCheckBox6: TRzCheckBox
            Left = 25
            Top = 160
            Width = 151
            Height = 17
            Caption = #28165#29702#26080#20027#20154#33521#38596#35282#33394
            HotTrack = True
            State = cbUnchecked
            TabOrder = 10
            Transparent = True
          end
        end
        object RzCheckBox3: TRzCheckBox
          Left = 26
          Top = 88
          Width = 163
          Height = 17
          Caption = #28165#29702#20154#29289'('#26080#25968#25454#30340#35282#33394')'
          HotTrack = True
          State = cbUnchecked
          TabOrder = 1
          Transparent = True
        end
        object RzCheckBox5: TRzCheckBox
          Left = 27
          Top = 107
          Width = 151
          Height = 17
          Caption = #28165#29702#24080#21495'('#26080#35282#33394#24080#21495')'
          HotTrack = True
          State = cbUnchecked
          TabOrder = 2
          Transparent = True
        end
        object RzGroupBox2: TRzGroupBox
          Left = 5
          Top = 184
          Width = 525
          Height = 43
          Caption = #25209#37327#26367#25442
          TabOrder = 3
          Transparent = True
          VisualStyle = vsGradient
          object RzLabel18: TRzLabel
            Left = 12
            Top = 19
            Width = 270
            Height = 12
            Caption = #31561#32423'                                       '#32423
            Transparent = True
          end
          object RzBitBtn5: TRzBitBtn
            Left = 287
            Top = 11
            Width = 82
            Caption = #20154#29289#31561#32423
            HotTrack = True
            TabOrder = 0
            OnClick = RzBitBtn5Click
            Glyph.Data = {
              36060000424D3606000000000000360400002800000020000000100000000100
              08000000000000020000530D0000530D00000001000000000000000000003300
              00006600000099000000CC000000FF0000000033000033330000663300009933
              0000CC330000FF33000000660000336600006666000099660000CC660000FF66
              000000990000339900006699000099990000CC990000FF99000000CC000033CC
              000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
              0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
              330000333300333333006633330099333300CC333300FF333300006633003366
              33006666330099663300CC663300FF6633000099330033993300669933009999
              3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
              330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
              66006600660099006600CC006600FF0066000033660033336600663366009933
              6600CC336600FF33660000666600336666006666660099666600CC666600FF66
              660000996600339966006699660099996600CC996600FF99660000CC660033CC
              660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
              6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
              990000339900333399006633990099339900CC339900FF339900006699003366
              99006666990099669900CC669900FF6699000099990033999900669999009999
              9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
              990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
              CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
              CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
              CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
              CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
              CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
              FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
              FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
              FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
              FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
              000000808000800000008000800080800000C0C0C00080808000191919004C4C
              4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
              6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000E8D7E8D7D7E8
              E8E8E8E8E8E8E8E8E8E8E8D7E8D7D7E8E8E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7
              D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7DF
              6C6C6CE8E8E8E8E8E8E8D7D7D7D7D7DF565656E8E8E8E8E8E8E8D7D7D7D7DF90
              6C6C6C6CE8E8E8E8E8E8D7D7D7D7DF8156565656E8E8E8E8E8E8D7D7D7D79090
              906C6C6C6CE8E8E8E8E8D7D7D7D781818156565656E8E8E8E8E8D7E8D7E8B490
              90906C6C6C7EE8E8E8E8D7E8D7E8AC81818156565656E8E8E8E8E8E8E8E8B4B4
              9090906C7EA87EE8E8E8E8E8E8E8ACAC81818156568156E8E8E8E8E8E8E8E8B4
              B490907EA8A8A87EE8E8E8E8E8E8E8ACAC81815681818156E8E8E8E8E8E8E8E8
              B4D8A8D2D2A8A8A87EE8E8E8E8E8E8E8AC5681ACAC81818156E8E8E8E8E8E8E8
              E8A8D2D7DED2A8A8A87EE8E8E8E8E8E8E881ACD7DEAC81818156E8E8E8E8E8E8
              E8E8A8D2D7DED2A87E09E8E8E8E8E8E8E8E881ACD7DEAC815656E8E8E8E8E8E8
              E8E8E8A8D2D7D27E1009E8E8E8E8E8E8E8E8E881ACD7AC568156E8E8E8E8E8E8
              E8E8E8E8A8D2A8101010E8E8E8E8E8E8E8E8E8E881AC81818181E8E8E8E8E8E8
              E8E8E8E8E8A817171010E8E8E8E8E8E8E8E8E8E8E881ACAC8181E8E8E8E8E8E8
              E8E8E8E8E8E809171710E8E8E8E8E8E8E8E8E8E8E8E856ACAC81E8E8E8E8E8E8
              E8E8E8E8E8E8E8091717E8E8E8E8E8E8E8E8E8E8E8E8E856ACAC}
            NumGlyphs = 2
          end
          object RzComboBox1: TRzComboBox
            Left = 39
            Top = 15
            Width = 55
            Height = 20
            Style = csDropDownList
            Ctl3D = False
            FlatButtons = True
            FrameHotTrack = True
            FrameVisible = True
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ItemHeight = 12
            ParentCtl3D = False
            TabOrder = 1
            Text = #22823#20110
            Items.Strings = (
              #22823#20110
              #31561#20110
              #23567#20110)
            ItemIndex = 0
          end
          object RzComboBox2: TRzComboBox
            Left = 153
            Top = 15
            Width = 56
            Height = 20
            Style = csDropDownList
            Ctl3D = False
            FlatButtons = True
            FrameHotTrack = True
            FrameVisible = True
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ItemHeight = 12
            ParentCtl3D = False
            TabOrder = 2
            Text = #26367#25442
            Items.Strings = (
              #26367#25442
              #22686#21152
              #20943#23569)
            ItemIndex = 0
          end
          object RzSpinEdit1: TSpinEdit
            Left = 98
            Top = 14
            Width = 53
            Height = 21
            MaxValue = 65535
            MinValue = 0
            TabOrder = 3
            Value = 0
          end
        end
        object RzSpinEdit3: TSpinEdit
          Left = 220
          Top = 198
          Width = 53
          Height = 21
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
        object RzBitBtn7: TRzBitBtn
          Left = 12
          Top = 250
          Width = 93
          Caption = 'ID.DB'#20462#22797
          HotTrack = True
          TabOrder = 5
          OnClick = RzBitBtn7Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000530D0000530D00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8D7E8D7D7E8
            E8E8E8E8E8E8E8E8E8E8E8D7E8D7D7E8E8E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7
            D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7DF
            6C6C6CE8E8E8E8E8E8E8D7D7D7D7D7DF565656E8E8E8E8E8E8E8D7D7D7D7DF90
            6C6C6C6CE8E8E8E8E8E8D7D7D7D7DF8156565656E8E8E8E8E8E8D7D7D7D79090
            906C6C6C6CE8E8E8E8E8D7D7D7D781818156565656E8E8E8E8E8D7E8D7E8B490
            90906C6C6C7EE8E8E8E8D7E8D7E8AC81818156565656E8E8E8E8E8E8E8E8B4B4
            9090906C7EA87EE8E8E8E8E8E8E8ACAC81818156568156E8E8E8E8E8E8E8E8B4
            B490907EA8A8A87EE8E8E8E8E8E8E8ACAC81815681818156E8E8E8E8E8E8E8E8
            B4D8A8D2D2A8A8A87EE8E8E8E8E8E8E8AC5681ACAC81818156E8E8E8E8E8E8E8
            E8A8D2D7DED2A8A8A87EE8E8E8E8E8E8E881ACD7DEAC81818156E8E8E8E8E8E8
            E8E8A8D2D7DED2A87E09E8E8E8E8E8E8E8E881ACD7DEAC815656E8E8E8E8E8E8
            E8E8E8A8D2D7D27E1009E8E8E8E8E8E8E8E8E881ACD7AC568156E8E8E8E8E8E8
            E8E8E8E8A8D2A8101010E8E8E8E8E8E8E8E8E8E881AC81818181E8E8E8E8E8E8
            E8E8E8E8E8A817171010E8E8E8E8E8E8E8E8E8E8E881ACAC8181E8E8E8E8E8E8
            E8E8E8E8E8E809171710E8E8E8E8E8E8E8E8E8E8E8E856ACAC81E8E8E8E8E8E8
            E8E8E8E8E8E8E8091717E8E8E8E8E8E8E8E8E8E8E8E8E856ACAC}
          NumGlyphs = 2
        end
        object RzBitBtn8: TRzBitBtn
          Left = 12
          Top = 282
          Width = 93
          Hint = #27880#24847#65306#31105#27490#25110#21024#38500#30340#20154#29289#23558#20250#34987#28165#29702#25481
          Caption = 'Hum.DB'#20462#22797
          HotTrack = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = RzBitBtn8Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000530D0000530D00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8D7E8D7D7E8
            E8E8E8E8E8E8E8E8E8E8E8D7E8D7D7E8E8E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7
            D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7DF
            6C6C6CE8E8E8E8E8E8E8D7D7D7D7D7DF565656E8E8E8E8E8E8E8D7D7D7D7DF90
            6C6C6C6CE8E8E8E8E8E8D7D7D7D7DF8156565656E8E8E8E8E8E8D7D7D7D79090
            906C6C6C6CE8E8E8E8E8D7D7D7D781818156565656E8E8E8E8E8D7E8D7E8B490
            90906C6C6C7EE8E8E8E8D7E8D7E8AC81818156565656E8E8E8E8E8E8E8E8B4B4
            9090906C7EA87EE8E8E8E8E8E8E8ACAC81818156568156E8E8E8E8E8E8E8E8B4
            B490907EA8A8A87EE8E8E8E8E8E8E8ACAC81815681818156E8E8E8E8E8E8E8E8
            B4D8A8D2D2A8A8A87EE8E8E8E8E8E8E8AC5681ACAC81818156E8E8E8E8E8E8E8
            E8A8D2D7DED2A8A8A87EE8E8E8E8E8E8E881ACD7DEAC81818156E8E8E8E8E8E8
            E8E8A8D2D7DED2A87E09E8E8E8E8E8E8E8E881ACD7DEAC815656E8E8E8E8E8E8
            E8E8E8A8D2D7D27E1009E8E8E8E8E8E8E8E8E881ACD7AC568156E8E8E8E8E8E8
            E8E8E8E8A8D2A8101010E8E8E8E8E8E8E8E8E8E881AC81818181E8E8E8E8E8E8
            E8E8E8E8E8A817171010E8E8E8E8E8E8E8E8E8E8E881ACAC8181E8E8E8E8E8E8
            E8E8E8E8E8E809171710E8E8E8E8E8E8E8E8E8E8E8E856ACAC81E8E8E8E8E8E8
            E8E8E8E8E8E8E8091717E8E8E8E8E8E8E8E8E8E8E8E8E856ACAC}
          NumGlyphs = 2
        end
        object ProgressBar: TProgressBar
          Left = 2
          Top = 423
          Width = 531
          Height = 11
          TabOrder = 7
        end
        object RzBitBtn9: TRzBitBtn
          Left = 12
          Top = 316
          Width = 94
          Hint = #27880#24847#65306#31105#27490#25110#21024#38500#30340#20154#29289#23558#20250#34987#28165#29702#25481
          Caption = #28165#29702#20840#26381#22797#21046#21697
          HotTrack = True
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = RzBitBtn9Click
          NumGlyphs = 2
        end
        object Memo1: TMemo
          Left = 110
          Top = 232
          Width = 420
          Height = 185
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ScrollBars = ssVertical
          TabOrder = 9
        end
      end
    end
    object TabSheet4: TRzTabSheet
      Color = 16119543
      Caption = #25968#25454#26597#35810
      object RzGroupBox3: TRzGroupBox
        Left = 5
        Top = 3
        Width = 525
        Height = 201
        Caption = #20803#23453#26597#35810
        TabOrder = 0
        Transparent = True
        VisualStyle = vsGradient
        object RzLabel20: TRzLabel
          Left = 12
          Top = 19
          Width = 162
          Height = 12
          Caption = #20803#23453'                       '
          Transparent = True
        end
        object RzBitBtn10: TRzBitBtn
          Left = 215
          Top = 11
          Width = 82
          Caption = #26597' '#35810
          HotTrack = True
          TabOrder = 0
          OnClick = RzBitBtn10Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000530D0000530D00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8D7E8D7D7E8
            E8E8E8E8E8E8E8E8E8E8E8D7E8D7D7E8E8E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7
            D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7DF
            6C6C6CE8E8E8E8E8E8E8D7D7D7D7D7DF565656E8E8E8E8E8E8E8D7D7D7D7DF90
            6C6C6C6CE8E8E8E8E8E8D7D7D7D7DF8156565656E8E8E8E8E8E8D7D7D7D79090
            906C6C6C6CE8E8E8E8E8D7D7D7D781818156565656E8E8E8E8E8D7E8D7E8B490
            90906C6C6C7EE8E8E8E8D7E8D7E8AC81818156565656E8E8E8E8E8E8E8E8B4B4
            9090906C7EA87EE8E8E8E8E8E8E8ACAC81818156568156E8E8E8E8E8E8E8E8B4
            B490907EA8A8A87EE8E8E8E8E8E8E8ACAC81815681818156E8E8E8E8E8E8E8E8
            B4D8A8D2D2A8A8A87EE8E8E8E8E8E8E8AC5681ACAC81818156E8E8E8E8E8E8E8
            E8A8D2D7DED2A8A8A87EE8E8E8E8E8E8E881ACD7DEAC81818156E8E8E8E8E8E8
            E8E8A8D2D7DED2A87E09E8E8E8E8E8E8E8E881ACD7DEAC815656E8E8E8E8E8E8
            E8E8E8A8D2D7D27E1009E8E8E8E8E8E8E8E8E881ACD7AC568156E8E8E8E8E8E8
            E8E8E8E8A8D2A8101010E8E8E8E8E8E8E8E8E8E881AC81818181E8E8E8E8E8E8
            E8E8E8E8E8A817171010E8E8E8E8E8E8E8E8E8E8E881ACAC8181E8E8E8E8E8E8
            E8E8E8E8E8E809171710E8E8E8E8E8E8E8E8E8E8E8E856ACAC81E8E8E8E8E8E8
            E8E8E8E8E8E8E8091717E8E8E8E8E8E8E8E8E8E8E8E8E856ACAC}
          NumGlyphs = 2
        end
        object RzComboBox3: TRzComboBox
          Left = 39
          Top = 15
          Width = 55
          Height = 20
          Style = csDropDownList
          Ctl3D = False
          FlatButtons = True
          FrameHotTrack = True
          FrameVisible = True
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          ParentCtl3D = False
          TabOrder = 1
          Text = #22823#20110
          Items.Strings = (
            #22823#20110
            #31561#20110
            #23567#20110)
          ItemIndex = 0
        end
        object GameGoldEdit: TSpinEdit
          Left = 98
          Top = 15
          Width = 87
          Height = 21
          MaxValue = 2147483647
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
        object ListView1: TListView
          Left = 1
          Top = 45
          Width = 523
          Height = 148
          Columns = <
            item
              Caption = #32534#21495
              Width = 100
            end
            item
              Caption = #36134#21495
              Width = 130
            end
            item
              Caption = #29992#33394#21517#31216
              Width = 150
            end
            item
              Caption = #20803#23453#25968
              Width = 100
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          GridLines = True
          MultiSelect = True
          RowSelect = True
          ParentFont = False
          TabOrder = 3
          ViewStyle = vsReport
          OnColumnClick = ListView1ColumnClick
        end
      end
      object RzGroupBox4: TRzGroupBox
        Left = 6
        Top = 208
        Width = 525
        Height = 210
        Caption = #29289#21697#26597#35810
        TabOrder = 1
        Transparent = True
        VisualStyle = vsGradient
        object Label4: TLabel
          Left = 9
          Top = 20
          Width = 48
          Height = 12
          Caption = #29289#21697#21517#31216
        end
        object Label6: TLabel
          Left = 271
          Top = 16
          Width = 60
          Height = 12
          Caption = #29289#21697#24207#21015#21495
        end
        object RzBitBtn11: TRzBitBtn
          Left = 166
          Top = 11
          Width = 76
          Caption = #26597' '#35810
          HotTrack = True
          TabOrder = 0
          OnClick = RzBitBtn11Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000530D0000530D00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8D7E8D7D7E8
            E8E8E8E8E8E8E8E8E8E8E8D7E8D7D7E8E8E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7
            D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7DF
            6C6C6CE8E8E8E8E8E8E8D7D7D7D7D7DF565656E8E8E8E8E8E8E8D7D7D7D7DF90
            6C6C6C6CE8E8E8E8E8E8D7D7D7D7DF8156565656E8E8E8E8E8E8D7D7D7D79090
            906C6C6C6CE8E8E8E8E8D7D7D7D781818156565656E8E8E8E8E8D7E8D7E8B490
            90906C6C6C7EE8E8E8E8D7E8D7E8AC81818156565656E8E8E8E8E8E8E8E8B4B4
            9090906C7EA87EE8E8E8E8E8E8E8ACAC81818156568156E8E8E8E8E8E8E8E8B4
            B490907EA8A8A87EE8E8E8E8E8E8E8ACAC81815681818156E8E8E8E8E8E8E8E8
            B4D8A8D2D2A8A8A87EE8E8E8E8E8E8E8AC5681ACAC81818156E8E8E8E8E8E8E8
            E8A8D2D7DED2A8A8A87EE8E8E8E8E8E8E881ACD7DEAC81818156E8E8E8E8E8E8
            E8E8A8D2D7DED2A87E09E8E8E8E8E8E8E8E881ACD7DEAC815656E8E8E8E8E8E8
            E8E8E8A8D2D7D27E1009E8E8E8E8E8E8E8E8E881ACD7AC568156E8E8E8E8E8E8
            E8E8E8E8A8D2A8101010E8E8E8E8E8E8E8E8E8E881AC81818181E8E8E8E8E8E8
            E8E8E8E8E8A817171010E8E8E8E8E8E8E8E8E8E8E881ACAC8181E8E8E8E8E8E8
            E8E8E8E8E8E809171710E8E8E8E8E8E8E8E8E8E8E8E856ACAC81E8E8E8E8E8E8
            E8E8E8E8E8E8E8091717E8E8E8E8E8E8E8E8E8E8E8E8E856ACAC}
          NumGlyphs = 2
        end
        object EditItemName: TEdit
          Left = 60
          Top = 15
          Width = 101
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 1
        end
        object EditItemMakeIndex: TEdit
          Left = 334
          Top = 13
          Width = 100
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 2
        end
        object RzBitBtn12: TRzBitBtn
          Left = 438
          Top = 10
          Width = 73
          Caption = #26597' '#35810
          HotTrack = True
          TabOrder = 3
          OnClick = RzBitBtn12Click
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000530D0000530D00000001000000000000000000003300
            00006600000099000000CC000000FF0000000033000033330000663300009933
            0000CC330000FF33000000660000336600006666000099660000CC660000FF66
            000000990000339900006699000099990000CC990000FF99000000CC000033CC
            000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
            0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
            330000333300333333006633330099333300CC333300FF333300006633003366
            33006666330099663300CC663300FF6633000099330033993300669933009999
            3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
            330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
            66006600660099006600CC006600FF0066000033660033336600663366009933
            6600CC336600FF33660000666600336666006666660099666600CC666600FF66
            660000996600339966006699660099996600CC996600FF99660000CC660033CC
            660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
            6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
            990000339900333399006633990099339900CC339900FF339900006699003366
            99006666990099669900CC669900FF6699000099990033999900669999009999
            9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
            990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
            CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
            CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
            CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
            CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
            CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
            FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
            FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
            FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
            FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
            000000808000800000008000800080800000C0C0C00080808000191919004C4C
            4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
            6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000E8D7E8D7D7E8
            E8E8E8E8E8E8E8E8E8E8E8D7E8D7D7E8E8E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7
            D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7D7D7E8E8E8E8E8E8E8E8E8D7D7D7D7D7DF
            6C6C6CE8E8E8E8E8E8E8D7D7D7D7D7DF565656E8E8E8E8E8E8E8D7D7D7D7DF90
            6C6C6C6CE8E8E8E8E8E8D7D7D7D7DF8156565656E8E8E8E8E8E8D7D7D7D79090
            906C6C6C6CE8E8E8E8E8D7D7D7D781818156565656E8E8E8E8E8D7E8D7E8B490
            90906C6C6C7EE8E8E8E8D7E8D7E8AC81818156565656E8E8E8E8E8E8E8E8B4B4
            9090906C7EA87EE8E8E8E8E8E8E8ACAC81818156568156E8E8E8E8E8E8E8E8B4
            B490907EA8A8A87EE8E8E8E8E8E8E8ACAC81815681818156E8E8E8E8E8E8E8E8
            B4D8A8D2D2A8A8A87EE8E8E8E8E8E8E8AC5681ACAC81818156E8E8E8E8E8E8E8
            E8A8D2D7DED2A8A8A87EE8E8E8E8E8E8E881ACD7DEAC81818156E8E8E8E8E8E8
            E8E8A8D2D7DED2A87E09E8E8E8E8E8E8E8E881ACD7DEAC815656E8E8E8E8E8E8
            E8E8E8A8D2D7D27E1009E8E8E8E8E8E8E8E8E881ACD7AC568156E8E8E8E8E8E8
            E8E8E8E8A8D2A8101010E8E8E8E8E8E8E8E8E8E881AC81818181E8E8E8E8E8E8
            E8E8E8E8E8A817171010E8E8E8E8E8E8E8E8E8E8E881ACAC8181E8E8E8E8E8E8
            E8E8E8E8E8E809171710E8E8E8E8E8E8E8E8E8E8E8E856ACAC81E8E8E8E8E8E8
            E8E8E8E8E8E8E8091717E8E8E8E8E8E8E8E8E8E8E8E8E856ACAC}
          NumGlyphs = 2
        end
        object ItemsGrid: TRzStringGrid
          Left = 10
          Top = 41
          Width = 507
          Height = 167
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
          ScrollBars = ssVertical
          TabOrder = 4
          ColWidths = (
            60
            98
            108
            93
            118)
          RowHeights = (
            18
            18)
        end
      end
      object ProgressBar1: TProgressBar
        Left = 2
        Top = 418
        Width = 531
        Height = 11
        TabOrder = 2
      end
    end
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = StartTimerTimer
    Left = 451
    Top = 2
  end
  object Query: TQuery
    DatabaseName = 'HeroDB'
    Left = 400
  end
  object ImageList1: TImageList
    Left = 425
    Top = 1
    Bitmap = {
      494C010106000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001001000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D300D300D300D300D300
      D300D300D300D300D300D300D3000000000000000000734E734E734E734E734E
      734E734E734E734E734E734E734E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D3009901990199019901
      990199019901990199019901D3000000000000000000734E3967396739673967
      396739673967396739673967734E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D3009901990199019901
      990199019901990199019901D3000000000000000000734E3967396739673967
      396739673967396739673967734E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D300D300D300D300D300
      D300D300D300D300D300D300D3000000000000000000734E734E734E734E734E
      734E734E734E734E734E734E734E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000396718639C73000000000000
      0000000000000000000000000000000000000000396718639C73000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000039676C4E8C4D734E9C7300000000
      0000000000000000000000000000000000003967D65A734E734E9C7300000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000002C7F66668C4D734E9C730000
      00000000000000000000000000000000000000003967D65A734E734E9C730000
      000000000000000000000000000000000000000000000000000000000000D300
      D300D300D300000000000000000000000000000000000000000000000000734E
      734E734E734E0000000000000000000000000000397F2C7F66668C4D734E9C73
      00000000000000000000000000000000000000009C733967D65A734E734E9C73
      000000000000000000000000000000000000000000000000000000000000D300
      99019901D300000000000000000000000000000000000000000000000000734E
      39673967734E00000000000000000000000000000000397F2C7F66668C4D734E
      9C7300000000000000000000000000000000000000009C733967D65A734E734E
      9C7300000000000000000000000000000000000000000000000000000000D300
      99019901D300000000000000000000000000000000000000000000000000734E
      39673967734E000000000000000000000000000000000000397F2C7F66668C4D
      39673F67794E794E794E394F9C73000000000000000000009C733967D65A734E
      39679C73734E734E734ED65A9C7300000000000000000000000000000000D300
      99019901D300000000000000000000000000000000000000000000000000734E
      39673967734E0000000000000000000000000000000000000000397F2C7FD65A
      794E394FBE5FFF67BE5FBE5F794E1D6F000000000000000000009C733967D65A
      734ED65A3967396739673967734E9C73000000000000D300D300D300D300D300
      99019901D300D300D300D300D3000000000000000000734E734E734E734E734E
      39673967734E734E734E734E734E00000000000000000000000000009C73794E
      3F4FFF67FF67FF67FF7FFF7FFF7F794E9C73000000000000000000009C73734E
      9C733967396739679C739C739C73734E9C7300000000D3009901990199019901
      990199019901990199019901D3000000000000000000734E3967396739673967
      396739673967396739673967734E00000000000000000000000000003F67394F
      FF67BE5FFF67FF67FF7FFF7FFF7FBE5F394F000000000000000000009C73D65A
      39673967396739679C739C739C733967D65A00000000D3009901990199019901
      990199019901990199019901D3000000000000000000734E3967396739673967
      396739673967396739673967734E0000000000000000000000000000394F3F4F
      BE5FBE5FFF67FF67FF67FF7FFF7FBE5F794E00000000000000000000D65A9C73
      396739673967396739679C739C733967734E00000000D300D300D300D300D300
      99019901D300D300D300D300D3000000000000000000734E734E734E734E734E
      39673967734E734E734E734E734E0000000000000000000000000000794EBE5F
      BE5FBE5FBE5FFF67FF67FF67FF67FF67794E00000000000000000000734E3967
      39673967396739673967396739673967734E000000000000000000000000D300
      99019901D300000000000000000000000000000000000000000000000000734E
      39673967734E00000000000000000000000000000000000000000000394FBE5F
      FF67BE5FBE5FBE5FFF67FF67FF67BE5F794E00000000000000000000D65A3967
      39673967396739673967396739673967734E000000000000000000000000D300
      99019901D300000000000000000000000000000000000000000000000000734E
      39673967734E000000000000000000000000000000000000000000003F67394F
      FF7FFF7FBE5FBE5FBE5FBE5FFF67394F394F000000000000000000009C73D65A
      9C739C7339673967396739673967D65AD65A000000000000000000000000D300
      99019901D300000000000000000000000000000000000000000000000000734E
      39673967734E000000000000000000000000000000000000000000009C73794E
      1D6FFF7FFF67BE5FBE5FBE5F3F4F794E9C73000000000000000000009C73734E
      9C739C7339673967396739679C73734E9C73000000000000000000000000D300
      D300D300D300000000000000000000000000000000000000000000000000734E
      734E734E734E0000000000000000000000000000000000000000000000003F67
      794E3F67BE5FBE5FBE5F394F794E3F6700000000000000000000000000009C73
      734E9C73396739673967D65A734E9C7300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      9C73394F794E794E794E794E9C73000000000000000000000000000000000000
      9C73D65A734E734E734E734E9C73000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
      C003C00300000000C003C00300000000C003C00300000000C003C00300000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF000000008FFF8FFFFFFFFFFF07FF07FFFFFFFFFF
      83FF83FFFC3FFC3F81FF81FFFC3FFC3FC0FFC0FFFC3FFC3FE003E003FC3FFC3F
      F001F001C003C003F800F800C003C003F800F800C003C003F800F800C003C003
      F800F800FC3FFC3FF800F800FC3FFC3FF800F800FC3FFC3FF800F800FC3FFC3F
      FC01FC01FFFFFFFFFE03FE03FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object RzBalloonHints1: TRzBalloonHints
    Bitmaps.TransparentColor = clOlive
    CaptionWidth = 200
    CenterThreshold = 0
    Color = clAqua
    FrameColor = cl3DDkShadow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clInfoText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    HintPause = 10
    ShowBalloon = False
    Left = 480
    Top = 1
  end
  object pm1: TPopupMenu
    Left = 509
    object N1: TMenuItem
      Caption = #21024#38500
      OnClick = N1Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 343
    Top = 65534
    object N2: TMenuItem
      Caption = #21024#38500
      OnClick = N2Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 314
    Top = 65534
    object N3: TMenuItem
      Caption = #21024#38500
      OnClick = N3Click
    end
  end
  object TimerShowInfo: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerShowInfoTimer
    Left = 371
  end
end
