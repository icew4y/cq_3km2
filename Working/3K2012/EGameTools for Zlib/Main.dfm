object FrmMain: TFrmMain
  Left = 227
  Top = 123
  BorderIcons = []
  Caption = '3K'#31185#25216#24037#20855#21253
  ClientHeight = 607
  ClientWidth = 813
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bsSkinPanel17: TbsSkinPanel
    Left = 0
    Top = 588
    Width = 813
    Height = 19
    TabOrder = 0
    SkinData = bsSkinData1
    SkinDataName = 'panel'
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
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    NumGlyphs = 1
    Spacing = 2
    Caption = 'bsSkinPanel17'
    Align = alBottom
    object bsSkinStdLabel7: TbsSkinStdLabel
      Left = 3
      Top = 3
      Width = 51
      Height = 13
      EllipsType = bsetNone
      UseSkinFont = True
      UseSkinColor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = bsSkinData1
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Caption = #36719#20214#21517#31216':'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
    end
    object LabelProductName: TbsSkinStdLabel
      Left = 58
      Top = 3
      Width = 91
      Height = 13
      EllipsType = bsetNone
      UseSkinFont = True
      UseSkinColor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = bsSkinData1
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Caption = 'LabelProductName'
      ParentFont = False
    end
    object bsSkinLinkLabel1: TbsSkinLinkLabel
      Left = 364
      Top = 3
      Width = 96
      Height = 12
      Cursor = crHandPoint
      UseUnderLine = True
      UseSkinFont = True
      DefaultActiveFontColor = clFuchsia
      DefaultFont.Charset = GB2312_CHARSET
      DefaultFont.Color = clFuchsia
      DefaultFont.Height = -12
      DefaultFont.Name = #23435#20307
      DefaultFont.Style = [fsUnderline]
      SkinData = bsSkinData1
      SkinDataName = 'stdlabel'
      Font.Charset = GB2312_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = [fsUnderline]
      Caption = 'bsSkinLinkLabel1'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
    end
    object bsSkinButtonLabel1: TbsSkinButtonLabel
      Left = 584
      Top = 2
      Width = 36
      Height = 16
      ImageIndex = -1
      WebStyle = False
      NumGlyphs = 1
      Spacing = 1
      UseSkinFont = False
      DefaultActiveFontColor = clBlue
      DefaultFont.Charset = GB2312_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -12
      DefaultFont.Name = #23435#20307
      DefaultFont.Style = []
      SkinData = bsSkinData1
      SkinDataName = 'stdlabel'
      Caption = #20851#20110
      OnClick = bsSkinButtonLabel1Click
    end
    object bsSkinStdLabel17: TbsSkinStdLabel
      Left = 198
      Top = 3
      Width = 51
      Height = 13
      EllipsType = bsetNone
      UseSkinFont = True
      UseSkinColor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = bsSkinData1
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Caption = #36719#20214#29256#26412':'
      Color = clBtnFace
      ParentColor = False
      ParentFont = False
    end
    object LabelVersion: TbsSkinStdLabel
      Left = 253
      Top = 3
      Width = 61
      Height = 13
      EllipsType = bsetNone
      UseSkinFont = True
      UseSkinColor = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = bsSkinData1
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Caption = 'LabelVersion'
      ParentFont = False
    end
  end
  object bsSkinPageControl1: TbsSkinPageControl
    Left = 0
    Top = 0
    Width = 813
    Height = 588
    ActivePage = bsSkinTabSheet3
    Align = alClient
    Font.Charset = GB2312_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = bsSkinPageControl1Change
    TabsBGTransparent = False
    DefaultFont.Charset = GB2312_CHARSET
    DefaultFont.Color = clBtnText
    DefaultFont.Height = -12
    DefaultFont.Name = #23435#20307
    DefaultFont.Style = []
    UseSkinFont = False
    DefaultItemHeight = 20
    SkinData = bsSkinData1
    SkinDataName = 'tab'
    object bsSkinTabSheet1: TbsSkinTabSheet
      Caption = #25968#25454#24211#31649#29702
      object bsSkinPageControl2: TbsSkinPageControl
        Left = 0
        Top = 0
        Width = 811
        Height = 569
        ActivePage = bsSkinTabSheet6
        Align = alClient
        Font.Charset = GB2312_CHARSET
        Font.Color = clBtnText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabsBGTransparent = False
        DefaultFont.Charset = GB2312_CHARSET
        DefaultFont.Color = clBtnText
        DefaultFont.Height = -12
        DefaultFont.Name = #23435#20307
        DefaultFont.Style = []
        UseSkinFont = False
        DefaultItemHeight = 20
        SkinData = bsSkinData1
        SkinDataName = 'tab'
        object bsSkinTabSheet4: TbsSkinTabSheet
          Caption = #25216#33021
          object bsSkinSplitter1: TbsSkinSplitter
            Left = 193
            Top = 82
            Width = 10
            Height = 468
            Transparent = False
            DefaultSize = 10
            SkinDataName = 'vsplitter'
            SkinData = bsSkinData1
            ExplicitHeight = 364
          end
          object bsSkinPanel1: TbsSkinPanel
            Left = 0
            Top = 0
            Width = 809
            Height = 57
            TabOrder = 0
            SkinData = bsSkinData1
            SkinDataName = 'panel'
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
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Caption = 'bsSkinPanel1'
            Align = alTop
            object bsSkinStdLabel1: TbsSkinStdLabel
              Left = 400
              Top = 12
              Width = 60
              Height = 12
              EllipsType = bsetNone
              UseSkinFont = False
              UseSkinColor = True
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -11
              DefaultFont.Name = 'MS Sans Serif'
              DefaultFont.Style = []
              SkinData = bsSkinData1
              SkinDataName = 'stdlabel'
              Caption = #26597#25214#21517#31216#65306
            end
            object bsSkinStdLabel2: TbsSkinStdLabel
              Left = 400
              Top = 35
              Width = 60
              Height = 12
              EllipsType = bsetNone
              UseSkinFont = False
              UseSkinColor = True
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -11
              DefaultFont.Name = 'MS Sans Serif'
              DefaultFont.Style = []
              SkinData = bsSkinData1
              SkinDataName = 'stdlabel'
              Caption = #20462#28860#32463#39564#65306
            end
            object BtnMagicBaseBak: TbsSkinButton
              Left = 8
              Top = 8
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
              Caption = #22791#20221#24211
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnMagicBaseBakClick
            end
            object BtnMagicBaseRestore: TbsSkinButton
              Left = 88
              Top = 8
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
              Caption = #24674#22797#24211
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnMagicBaseRestoreClick
            end
            object bsSkinCheckRadioBox1: TbsSkinCheckRadioBox
              Left = 9
              Top = 37
              Width = 96
              Height = 15
              TabOrder = 2
              SkinData = bsSkinData1
              SkinDataName = 'radiobox'
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
              State = cbChecked
              ImageIndex = 0
              Flat = True
              TabStop = True
              CanFocused = True
              Radio = True
              Checked = True
              GroupIndex = 1
              Caption = '1'#32423#25216#33021
            end
            object bsSkinCheckRadioBox2: TbsSkinCheckRadioBox
              Left = 129
              Top = 37
              Width = 96
              Height = 15
              TabOrder = 3
              SkinData = bsSkinData1
              SkinDataName = 'radiobox'
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
              Radio = True
              Checked = False
              GroupIndex = 1
              Caption = '2'#32423#25216#33021
            end
            object bsSkinCheckRadioBox3: TbsSkinCheckRadioBox
              Left = 249
              Top = 37
              Width = 96
              Height = 15
              TabOrder = 4
              SkinData = bsSkinData1
              SkinDataName = 'radiobox'
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
              Radio = True
              Checked = False
              GroupIndex = 1
              Caption = '3'#32423#25216#33021
            end
            object EditMagName: TbsSkinEdit
              Left = 459
              Top = 8
              Width = 78
              Height = 16
              DefaultColor = clWindow
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clBlack
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              UseSkinFont = False
              DefaultWidth = 0
              DefaultHeight = 0
              ButtonMode = False
              SkinData = bsSkinData1
              SkinDataName = 'edit'
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ParentFont = False
              TabOrder = 5
            end
            object bsSkinSpinEdit1: TbsSkinSpinEdit
              Left = 459
              Top = 31
              Width = 78
              Height = 20
              TabOrder = 6
              SkinData = bsSkinData1
              SkinDataName = 'spinedit'
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              DefaultWidth = 0
              DefaultHeight = 0
              UseSkinFont = False
              DefaultColor = clWindow
              UseSkinSize = True
              ValueType = vtInteger
              Value = 10.000000000000000000
              Increment = 1.000000000000000000
              EditorEnabled = True
              MaxLength = 0
            end
            object BtnFindMagName: TbsSkinButton
              Left = 542
              Top = 6
              Width = 66
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
              Caption = #26597#25214
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnFindMagNameClick
            end
            object BtnAlterMagicExp: TbsSkinButton
              Left = 542
              Top = 30
              Width = 66
              Height = 25
              Hint = #27880#24847':'#20462#25913#20026#36873#23450#31561#32423#25216#33021#25152#22364#30340#32463#39564','#21363#27492#31561#32423#25216#33021#30340#25152#26377#25216#33021#20462#28860#32463#39564'.'
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
              Caption = #20462#25913#32463#39564
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnAlterMagicExpClick
            end
            object bsSkinButton12: TbsSkinButton
              Left = 169
              Top = 8
              Width = 72
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
              Caption = #20840#37096#23548#20986
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton12Click
            end
            object bsSkinButton15: TbsSkinButton
              Left = 323
              Top = 8
              Width = 70
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
              Caption = #25171#21360
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton15Click
            end
            object bsSkinButton5: TbsSkinButton
              Left = 245
              Top = 8
              Width = 72
              Height = 25
              TabOrder = 11
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
              Caption = #23548#20837#25968#25454
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton5Click
            end
          end
          object bsSkinDBNavigator1: TbsSkinDBNavigator
            Left = 0
            Top = 57
            Width = 809
            Height = 25
            TabOrder = 1
            SkinData = bsSkinData1
            SkinDataName = 'panel'
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
            BorderStyle = bvNone
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Align = alTop
            AdditionalGlyphs = False
            SkinMessage = bsSkinMessage1
            DataSource = FrmDM.DataSourceMagic
            BtnSkinDataName = 'button'
          end
          object bsSkinExPanel1: TbsSkinExPanel
            Left = 0
            Top = 82
            Width = 193
            Height = 468
            TabOrder = 2
            SkinData = bsSkinData1
            SkinDataName = 'expanel'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            CaptionImageIndex = -1
            NumGlyphs = 1
            Spacing = 2
            RealWidth = 0
            RealHeight = 0
            ShowRollButton = True
            ShowCloseButton = False
            DefaultCaptionHeight = 21
            RollState = False
            RollKind = rkRollHorizontal
            Align = alLeft
            Caption = #21442#32771#24110#21161
            ParentShowHint = False
            ShowHint = False
            object bsSkinMemo1: TbsSkinMemo
              Left = 1
              Top = 21
              Width = 191
              Height = 446
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              Lines.Strings = (
                #35828#26126#65306
                #32844#19994'(Job)'#65306'0-'#25112#22763
                #12288#12288#12288#12288#12288' 1-'#27861#24072
                #12288#12288#12288#12288#12288' 2-'#36947#22763
                ''
                #28155#21152#12289#20462#25913#25968#25454#26102#35831#23613#37327#21442#29031#24050
                #26377#25968#25454#65292#20197#20813#20986#38169#65292#24433#21709#26381#21153#22120
                #36816#34892#65281)
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clBlack
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = [fsBold]
              UseSkinFont = False
              UseSkinFontColor = False
              BitMapBG = True
              SkinData = bsSkinData1
              SkinDataName = 'memo'
            end
          end
          object bsSkinPanel2: TbsSkinPanel
            Left = 203
            Top = 82
            Width = 606
            Height = 468
            TabOrder = 3
            SkinDataName = 'panel'
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
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Caption = 'bsSkinPanel2'
            Align = alClient
            object MagicDBGrid: TDBGridEh
              Left = 1
              Top = 1
              Width = 604
              Height = 466
              Align = alClient
              DataSource = FrmDM.DataSourceMagic
              Flat = False
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clBtnText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 2
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              PopupMenu = bsSkinPopupMenu3
              RowDetailPanel.Color = clBtnFace
              SumList.Active = True
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clBtnText
              TitleFont.Height = -12
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'MagID'
                  Footers = <
                    item
                      Alignment = taCenter
                      Value = #21512#35745':'
                      ValueType = fvtStaticText
                    end>
                  Width = 43
                end
                item
                  EditButtons = <>
                  FieldName = 'MagName'
                  Footers = <
                    item
                      Alignment = taCenter
                      FieldName = 'MagName'
                      ValueType = fvtCount
                    end>
                end
                item
                  EditButtons = <>
                  FieldName = 'EffectType'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Effect'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Spell'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Power'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'MaxPower'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'DefSpell'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'DefPower'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'DefMaxPower'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Job'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'NeedL1'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'L1Train'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'NeedL2'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'L2Train'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'NeedL3'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'L3Train'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Delay'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Descr'
                  Footers = <>
                end>
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
        end
        object bsSkinTabSheet5: TbsSkinTabSheet
          Caption = #24618#29289
          object bsSkinSplitter2: TbsSkinSplitter
            Left = 169
            Top = 82
            Width = 10
            Height = 468
            Transparent = False
            DefaultSize = 10
            SkinDataName = 'vsplitter'
            SkinData = bsSkinData1
            ExplicitHeight = 364
          end
          object bsSkinPanel3: TbsSkinPanel
            Left = 0
            Top = 0
            Width = 809
            Height = 57
            TabOrder = 0
            SkinData = bsSkinData1
            SkinDataName = 'panel'
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
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Caption = 'bsSkinPanel1'
            Align = alTop
            object bsSkinStdLabel3: TbsSkinStdLabel
              Left = 400
              Top = 20
              Width = 60
              Height = 12
              EllipsType = bsetNone
              UseSkinFont = False
              UseSkinColor = True
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -11
              DefaultFont.Name = 'MS Sans Serif'
              DefaultFont.Style = []
              SkinData = bsSkinData1
              SkinDataName = 'stdlabel'
              Caption = #26597#25214#21517#31216#65306
            end
            object BtnMobBaseBak: TbsSkinButton
              Left = 8
              Top = 16
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
              Caption = #22791#20221#24211
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnMagicBaseBakClick
            end
            object BtnMobBaseRestore: TbsSkinButton
              Left = 88
              Top = 16
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
              Caption = #24674#22797#24211
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnMagicBaseRestoreClick
            end
            object EditMobName: TbsSkinEdit
              Left = 459
              Top = 16
              Width = 78
              Height = 16
              DefaultColor = clWindow
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clBlack
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              UseSkinFont = False
              DefaultWidth = 0
              DefaultHeight = 0
              ButtonMode = False
              SkinData = bsSkinData1
              SkinDataName = 'edit'
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ParentFont = False
              TabOrder = 2
            end
            object BtnFindMonName: TbsSkinButton
              Left = 542
              Top = 14
              Width = 66
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
              Caption = #26597#25214
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnFindMonNameClick
            end
            object bsSkinButton11: TbsSkinButton
              Left = 169
              Top = 16
              Width = 72
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
              Caption = #20840#37096#23548#20986
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton11Click
            end
            object bsSkinButton14: TbsSkinButton
              Left = 322
              Top = 16
              Width = 70
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
              Caption = #25171#21360
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton14Click
            end
            object bsSkinButton4: TbsSkinButton
              Left = 246
              Top = 16
              Width = 72
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
              Caption = #23548#20837#25968#25454
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton4Click
            end
          end
          object bsSkinDBNavigator2: TbsSkinDBNavigator
            Left = 0
            Top = 57
            Width = 809
            Height = 25
            TabOrder = 1
            SkinData = bsSkinData1
            SkinDataName = 'panel'
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
            BorderStyle = bvNone
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Align = alTop
            AdditionalGlyphs = False
            SkinMessage = bsSkinMessage1
            DataSource = FrmDM.DataSourceMonster
            BtnSkinDataName = 'button'
          end
          object bsSkinExPanel2: TbsSkinExPanel
            Left = 0
            Top = 82
            Width = 169
            Height = 468
            TabOrder = 2
            SkinData = bsSkinData1
            SkinDataName = 'expanel'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            CaptionImageIndex = -1
            NumGlyphs = 1
            Spacing = 2
            RealWidth = 0
            RealHeight = 0
            ShowRollButton = True
            ShowCloseButton = False
            DefaultCaptionHeight = 21
            RollState = False
            RollKind = rkRollHorizontal
            Align = alLeft
            Caption = #21442#32771#24110#21161
            ParentShowHint = False
            ShowHint = False
            object bsSkinMemo2: TbsSkinMemo
              Left = 1
              Top = 21
              Width = 167
              Height = 446
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = [fsBold]
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              Lines.Strings = (
                #35828#26126#65306
                #19981#27515#31995'(Undead)'#65306'0-'#21542#65292'1-'
                #26159
                ''
                #35270#35273#33539#22260'(CoolEye)'#65306#24618#29289
                #23545#29609#23478#30340#8220#35270#35273#8221#33539#22260#65292#21644
                #31561#32423#26377#20851
                ''
                #32463#39564#20540'(Exp)'#65306#24618#29289#34987#26432#27515
                #21518#25152#24471#32463#39564#20540
                ''
                #34892#36208#27493#20240'(WalkStep)'#65306#21363#19968
                #27493#36328#20960#26684
                ''
                #25915#20987#36895#24230'(ATTACK_SPD)'#65306#20004
                #27425#25915#20987#30340#26102#38388#38388#38548#65292#20540#36234#23567
                #25915#20987#36234#24555#65292#27627#31186#21333#20301
                ''
                #28155#21152#12289#20462#25913#25968#25454#26102#35831#23613#37327#21442
                #29031#24050#26377#25968#25454#65292#20197#20813#20986#38169#65292#24433
                #21709#26381#21153#22120#36816#34892#65281)
              ParentFont = False
              ReadOnly = True
              ScrollBars = ssVertical
              TabOrder = 0
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clBlack
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = [fsBold]
              UseSkinFont = False
              UseSkinFontColor = False
              BitMapBG = True
              SkinData = bsSkinData1
              SkinDataName = 'memo'
            end
          end
          object bsSkinPanel4: TbsSkinPanel
            Left = 179
            Top = 82
            Width = 630
            Height = 468
            TabOrder = 3
            SkinDataName = 'panel'
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
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Caption = 'bsSkinPanel2'
            Align = alClient
            object MobDBGrid: TDBGridEh
              Left = 1
              Top = 1
              Width = 628
              Height = 466
              Align = alClient
              DataSource = FrmDM.DataSourceMonster
              Flat = False
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clBtnText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 2
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              PopupMenu = bsSkinPopupMenu3
              RowDetailPanel.Color = clBtnFace
              SumList.Active = True
              TabOrder = 0
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clBtnText
              TitleFont.Height = -12
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'Name'
                  Footers = <
                    item
                      Alignment = taCenter
                      Value = #21512#35745':'
                      ValueType = fvtStaticText
                    end>
                  Width = 75
                end
                item
                  EditButtons = <>
                  FieldName = 'Race'
                  Footers = <
                    item
                      Alignment = taCenter
                      FieldName = 'Race'
                      ValueType = fvtCount
                    end>
                end
                item
                  EditButtons = <>
                  FieldName = 'RaceImg'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Appr'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Lvl'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Undead'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'CoolEye'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Exp'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'HP'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'MP'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'AC'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'MAC'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'DC'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'DCMAX'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'MC'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'SC'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'SPEED'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'HIT'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'WALK_SPD'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'WalkStep'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'WaLkWait'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'ATTACK_SPD'
                  Footers = <>
                end>
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
        end
        object bsSkinTabSheet6: TbsSkinTabSheet
          Caption = #29289#21697
          object bsSkinSplitter3: TbsSkinSplitter
            Left = 217
            Top = 82
            Width = 10
            Height = 468
            Transparent = False
            DefaultSize = 10
            SkinDataName = 'vsplitter'
            SkinData = bsSkinData1
            ExplicitHeight = 364
          end
          object bsSkinPanel5: TbsSkinPanel
            Left = 0
            Top = 0
            Width = 809
            Height = 57
            TabOrder = 0
            SkinData = bsSkinData1
            SkinDataName = 'panel'
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
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Caption = 'bsSkinPanel1'
            Align = alTop
            object bsSkinStdLabel5: TbsSkinStdLabel
              Left = 85
              Top = 9
              Width = 60
              Height = 12
              EllipsType = bsetNone
              UseSkinFont = False
              UseSkinColor = True
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -11
              DefaultFont.Name = 'MS Sans Serif'
              DefaultFont.Style = []
              SkinData = bsSkinData1
              SkinDataName = 'stdlabel'
              Caption = #26597#25214#21517#31216#65306
            end
            object BtnItemsBaseBak: TbsSkinButton
              Left = 8
              Top = 6
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
              Caption = #22791#20221#24211
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnMagicBaseBakClick
            end
            object BtnItemsBaseRestore: TbsSkinButton
              Left = 8
              Top = 30
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
              Caption = #24674#22797#24211
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnMagicBaseRestoreClick
            end
            object BtnFindItemName: TbsSkinButton
              Left = 224
              Top = 4
              Width = 66
              Height = 24
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
              Caption = #26597#25214
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnFindItemNameClick
            end
            object EditItemsName: TbsSkinEdit
              Left = 144
              Top = 7
              Width = 78
              Height = 16
              DefaultColor = clWindow
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clBlack
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              UseSkinFont = False
              DefaultWidth = 0
              DefaultHeight = 0
              ButtonMode = False
              SkinData = bsSkinData1
              SkinDataName = 'edit'
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ParentFont = False
              TabOrder = 3
            end
            object bsSkinGroupBox1: TbsSkinGroupBox
              Left = 542
              Top = 1
              Width = 266
              Height = 55
              TabOrder = 4
              SkinData = bsSkinData1
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
              Caption = #35760#24405#36807#28388
              Align = alRight
              object bsSkinStdLabel4: TbsSkinStdLabel
                Left = 7
                Top = 30
                Width = 48
                Height = 12
                EllipsType = bsetNone
                UseSkinFont = False
                UseSkinColor = True
                DefaultFont.Charset = DEFAULT_CHARSET
                DefaultFont.Color = clWindowText
                DefaultFont.Height = -11
                DefaultFont.Name = 'MS Sans Serif'
                DefaultFont.Style = []
                SkinData = bsSkinData1
                SkinDataName = 'stdlabel'
                Caption = #36807#28388#21495#65306
              end
              object ComboBoxFilterItemsMode: TbsSkinComboBox
                Left = 57
                Top = 27
                Width = 199
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
                Text = #26080
                Items.Strings = (
                  #26080
                  '0-'#33647#21697
                  '1-'#24178#32905
                  '2-'#33647
                  '3-'#21367#20070#12289#27833#12289#27700
                  '4-'#20070#31821
                  '5-'#27494#22120'1'
                  '6-'#27494#22120'2'
                  '7-'#27668#34880#30707#12289#21315#37324#20256#38899
                  '8-'#37247#37202#26448#26009
                  '9-'#37247#37202#27700#26448#26009
                  '10-'#30007#34915
                  '11-'#22899#34915
                  '12-'#37202#22120
                  '13-'#37202#26354
                  '14-'#37247#37202#33647#26448
                  '15-'#22836#30420
                  '16-'#26007#31520
                  '17-'#21472#21152#29289#21697
                  '18-'#24184#36816#31526#29289#21697
                  '19-'#39033#38142'('#24184#36816#22411')'
                  '20-'#39033#38142'('#20934#30830#25935#25463#22411')'
                  '21-'#39033#38142'('#20307#21147#39764#27861#24674#22797#22411')'
                  '22-'#25106#25351
                  '23-'#25106#25351'('#29305#21035#22411')'
                  '24-'#25163#38255'('#29305#21035#22411')'
                  '25-'#27602#31526
                  '26-'#25163#22871#25163#38255
                  '27-'#25106#25351'('#20934#30830#25935#25463#22411')'
                  '28-'#39033#38142'('#20934#30830#24184#36816#22411')'
                  '29-'#39033#38142'('#25935#25463#24184#36816#22411')'
                  '30-'#34593#28891#12289#28779#25226#12289#21195#31456
                  '31-'#35299#21253#29289#21697
                  '36-'#20070#20449#12289#28784#26408#12289#32418#26408#12289#34013#26408
                  '40-'#32905
                  '41-'#29305#27530#35777#20070
                  '42-'#37197#33647#26448#26009#21644#28779#40857#31070#21697
                  '43-'#30719#30707
                  '44-'#29305#31181#29289#21697
                  '45-'#39600#23376#20315#29260
                  '46-'#20973#35777#31609#30721
                  '47-'#37329#26465#12289#30742#12289#30418
                  '48-'#23453#31665
                  '49-'#38053#21273
                  '50-'#20171#32461#20449
                  '51-'#32858#38598#29289#21697
                  '52-'#38772#23376'('#29305#21035#22411')'
                  '53-'#23453#30707'('#29305#21035#22411')'
                  '54-'#33136#24102'('#29305#21035#22411')'
                  '55-'#20891#40723
                  '60-'#37202#31867
                  '62-'#38772#23376
                  '63-'#23453#30707
                  '64-'#33136#24102)
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
                OnChange = ComboBoxFilterItemsModeChange
              end
            end
            object bsSkinButton7: TbsSkinButton
              Left = 85
              Top = 30
              Width = 62
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
              Caption = #20840#37096#23548#20986
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton7Click
            end
            object bsSkinButton13: TbsSkinButton
              Left = 214
              Top = 30
              Width = 62
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
              Caption = #25171#21360
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton13Click
            end
            object bsSkinButton3: TbsSkinButton
              Left = 149
              Top = 30
              Width = 62
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
              Caption = #23548#20837#25968#25454
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton3Click
            end
          end
          object bsSkinDBNavigator3: TbsSkinDBNavigator
            Left = 0
            Top = 57
            Width = 809
            Height = 25
            TabOrder = 1
            SkinData = bsSkinData1
            SkinDataName = 'panel'
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
            BorderStyle = bvNone
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Align = alTop
            AdditionalGlyphs = False
            SkinMessage = bsSkinMessage1
            DataSource = FrmDM.DataSourceStdItems
            BtnSkinDataName = 'button'
          end
          object bsSkinExPanel3: TbsSkinExPanel
            Left = 0
            Top = 82
            Width = 217
            Height = 468
            TabOrder = 2
            SkinData = bsSkinData1
            SkinDataName = 'expanel'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            CaptionImageIndex = -1
            NumGlyphs = 1
            Spacing = 2
            RealWidth = 0
            RealHeight = 0
            ShowRollButton = True
            ShowCloseButton = False
            DefaultCaptionHeight = 21
            RollState = False
            RollKind = rkRollHorizontal
            Align = alLeft
            Caption = #21442#32771#24110#21161
            ParentShowHint = False
            ShowHint = False
            object bsSkinSplitter4: TbsSkinSplitter
              Left = 1
              Top = 146
              Width = 215
              Height = 10
              Cursor = crVSplit
              Align = alTop
              Transparent = False
              DefaultSize = 10
              SkinDataName = 'hsplitter'
              SkinData = bsSkinData1
            end
            object MemoItemsHint: TbsSkinMemo
              Left = 1
              Top = 156
              Width = 196
              Height = 311
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clBlack
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              UseSkinFont = False
              UseSkinFontColor = True
              BitMapBG = True
              VScrollBar = bsSkinScrollBar4
              SkinData = bsSkinData1
              SkinDataName = 'memo'
            end
            object ListBoxItemsHint: TbsSkinListBox
              Left = 1
              Top = 21
              Width = 215
              Height = 125
              TabOrder = 1
              SkinData = bsSkinData1
              SkinDataName = 'listbox'
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              DefaultWidth = 0
              DefaultHeight = 0
              UseSkinFont = False
              AutoComplete = True
              UseSkinItemHeight = True
              HorizontalExtent = False
              Columns = 0
              RowCount = 0
              ImageIndex = -1
              NumGlyphs = 1
              Spacing = 2
              CaptionMode = False
              DefaultCaptionHeight = 20
              DefaultCaptionFont.Charset = GB2312_CHARSET
              DefaultCaptionFont.Color = clWindowText
              DefaultCaptionFont.Height = -12
              DefaultCaptionFont.Name = #23435#20307
              DefaultCaptionFont.Style = []
              DefaultItemHeight = 20
              ItemIndex = -1
              MultiSelect = False
              ListBoxFont.Charset = GB2312_CHARSET
              ListBoxFont.Color = clWindowText
              ListBoxFont.Height = -12
              ListBoxFont.Name = #23435#20307
              ListBoxFont.Style = []
              ListBoxTabOrder = 0
              ListBoxTabStop = True
              ListBoxDragMode = dmManual
              ListBoxDragKind = dkDrag
              ListBoxDragCursor = crDrag
              ExtandedSelect = True
              Sorted = False
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              Align = alTop
            end
            object bsSkinScrollBar4: TbsSkinScrollBar
              Left = 197
              Top = 156
              Width = 19
              Height = 311
              TabOrder = 2
              SkinData = bsSkinData1
              SkinDataName = 'vscrollbar'
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              DefaultWidth = 19
              DefaultHeight = 0
              UseSkinFont = False
              Enabled = False
              Both = False
              BothMarkerWidth = 19
              BothSkinDataName = 'bothhscrollbar'
              CanFocused = False
              Align = alRight
              Kind = sbVertical
              PageSize = 0
              Min = 0
              Max = 0
              Position = 0
              SmallChange = 1
              LargeChange = 1
            end
          end
          object bsSkinPanel6: TbsSkinPanel
            Left = 227
            Top = 82
            Width = 582
            Height = 468
            TabOrder = 3
            SkinDataName = 'panel'
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
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Caption = 'bsSkinPanel2'
            Align = alClient
            object bsSkinScrollBar5: TbsSkinScrollBar
              Left = 562
              Top = 1
              Width = 19
              Height = 466
              TabOrder = 0
              Visible = False
              SkinData = bsSkinData1
              SkinDataName = 'vscrollbar'
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              DefaultWidth = 19
              DefaultHeight = 0
              UseSkinFont = False
              Enabled = False
              Both = False
              BothMarkerWidth = 19
              BothSkinDataName = 'bothhscrollbar'
              CanFocused = False
              Align = alRight
              Kind = sbVertical
              PageSize = 0
              Min = 0
              Max = 0
              Position = 0
              SmallChange = 1
              LargeChange = 1
            end
            object ItemsDBGrid: TDBGridEh
              Left = 1
              Top = 1
              Width = 561
              Height = 466
              Align = alClient
              DataSource = FrmDM.DataSourceStdItems
              Flat = False
              FooterColor = clWindow
              FooterFont.Charset = GB2312_CHARSET
              FooterFont.Color = clBtnText
              FooterFont.Height = -12
              FooterFont.Name = #23435#20307
              FooterFont.Style = []
              FooterRowCount = 1
              FrozenCols = 2
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              PopupMenu = bsSkinPopupMenu3
              RowDetailPanel.Color = clBtnFace
              SumList.Active = True
              TabOrder = 1
              TitleFont.Charset = GB2312_CHARSET
              TitleFont.Color = clBtnText
              TitleFont.Height = -12
              TitleFont.Name = #23435#20307
              TitleFont.Style = []
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'Idx'
                  Footers = <
                    item
                      Alignment = taCenter
                      Value = #21512#35745':'
                      ValueType = fvtStaticText
                    end>
                  Width = 75
                end
                item
                  EditButtons = <>
                  FieldName = 'Name'
                  Footers = <
                    item
                      Alignment = taCenter
                      FieldName = 'Name'
                      ValueType = fvtCount
                    end>
                end
                item
                  EditButtons = <>
                  FieldName = 'Stdmode'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Shape'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Weight'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Anicount'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Source'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Reserved'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Looks'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'DuraMax'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'AC'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Ac2'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Mac'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Mac2'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Dc'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Dc2'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Mc'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Mc2'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Sc'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Sc2'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Need'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'NeedLevel'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Price'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Stock'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'Hp'
                  Footers = <>
                end
                item
                  EditButtons = <>
                  FieldName = 'MP'
                  Footers = <>
                end>
              object RowDetailData: TRowDetailPanelControlEh
              end
            end
          end
        end
        object bsSkinTabSheet7: TbsSkinTabSheet
          Caption = #31216#21495
          OnShow = bsSkinTabSheet7Show
          object bsSkinSplitter8: TbsSkinSplitter
            Left = 217
            Top = 82
            Width = 10
            Height = 468
            Transparent = False
            DefaultSize = 10
            SkinDataName = 'vsplitter'
            SkinData = bsSkinData1
            ExplicitHeight = 364
          end
          object bsSkinPanel13: TbsSkinPanel
            Left = 0
            Top = 0
            Width = 809
            Height = 57
            TabOrder = 0
            SkinData = bsSkinData1
            SkinDataName = 'panel'
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
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Caption = 'bsSkinPanel1'
            Align = alTop
            object bsSkinStdLabel11: TbsSkinStdLabel
              Left = 85
              Top = 9
              Width = 60
              Height = 12
              EllipsType = bsetNone
              UseSkinFont = False
              UseSkinColor = True
              DefaultFont.Charset = DEFAULT_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -11
              DefaultFont.Name = 'MS Sans Serif'
              DefaultFont.Style = []
              SkinData = bsSkinData1
              SkinDataName = 'stdlabel'
              Caption = #26597#25214#21517#31216#65306
            end
            object BtnFongHaoBaseBak: TbsSkinButton
              Left = 8
              Top = 6
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
              Caption = #22791#20221#24211
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnMagicBaseBakClick
            end
            object BtnFongHaoRestore: TbsSkinButton
              Left = 8
              Top = 30
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
              Caption = #24674#22797#24211
              NumGlyphs = 1
              Spacing = 1
              OnClick = BtnMagicBaseRestoreClick
            end
            object bsSkinButton10: TbsSkinButton
              Left = 224
              Top = 4
              Width = 66
              Height = 24
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
              Caption = #26597#25214
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton10Click
            end
            object bsSkinEdit1: TbsSkinEdit
              Left = 144
              Top = 7
              Width = 78
              Height = 16
              DefaultColor = clWindow
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clBlack
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              UseSkinFont = False
              DefaultWidth = 0
              DefaultHeight = 0
              ButtonMode = False
              SkinData = bsSkinData1
              SkinDataName = 'edit'
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ParentFont = False
              TabOrder = 3
            end
            object bsSkinGroupBox8: TbsSkinGroupBox
              Left = 542
              Top = 1
              Width = 266
              Height = 55
              TabOrder = 4
              SkinData = bsSkinData1
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
              Caption = #35760#24405#36807#28388
              Align = alRight
              object bsSkinStdLabel12: TbsSkinStdLabel
                Left = 7
                Top = 30
                Width = 48
                Height = 12
                EllipsType = bsetNone
                UseSkinFont = False
                UseSkinColor = True
                DefaultFont.Charset = DEFAULT_CHARSET
                DefaultFont.Color = clWindowText
                DefaultFont.Height = -11
                DefaultFont.Name = 'MS Sans Serif'
                DefaultFont.Style = []
                SkinData = bsSkinData1
                SkinDataName = 'stdlabel'
                Caption = #36807#28388#21495#65306
              end
              object ComboBoxFilterFongHaoMode: TbsSkinComboBox
                Left = 57
                Top = 27
                Width = 199
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
                Text = #26080
                Items.Strings = (
                  #26080
                  '0-'#38480#26102#31216#21495
                  '1-'#27704#20037#31216#21495)
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
                OnChange = ComboBoxFilterFongHaoModeChange
              end
            end
            object bsSkinButton16: TbsSkinButton
              Left = 85
              Top = 30
              Width = 62
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
              Caption = #20840#37096#23548#20986
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton16Click
            end
            object bsSkinButton17: TbsSkinButton
              Left = 214
              Top = 30
              Width = 62
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
              Caption = #25171#21360
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton17Click
            end
            object bsSkinButton18: TbsSkinButton
              Left = 149
              Top = 30
              Width = 62
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
              Caption = #23548#20837#25968#25454
              NumGlyphs = 1
              Spacing = 1
              OnClick = bsSkinButton18Click
            end
          end
          object bsSkinDBNavigator4: TbsSkinDBNavigator
            Left = 0
            Top = 57
            Width = 809
            Height = 25
            TabOrder = 1
            SkinData = bsSkinData1
            SkinDataName = 'panel'
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
            BorderStyle = bvNone
            CaptionMode = False
            RollUpMode = False
            RollUpState = False
            NumGlyphs = 1
            Spacing = 2
            Align = alTop
            AdditionalGlyphs = False
            SkinMessage = bsSkinMessage1
            DataSource = FrmDM.DataSourceFongHao
            BtnSkinDataName = 'button'
          end
          object bsSkinExPanel4: TbsSkinExPanel
            Left = 0
            Top = 82
            Width = 217
            Height = 468
            TabOrder = 2
            SkinData = bsSkinData1
            SkinDataName = 'expanel'
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            DefaultWidth = 0
            DefaultHeight = 0
            UseSkinFont = False
            CaptionImageIndex = -1
            NumGlyphs = 1
            Spacing = 2
            RealWidth = 0
            RealHeight = 0
            ShowRollButton = True
            ShowCloseButton = False
            DefaultCaptionHeight = 21
            RollState = False
            RollKind = rkRollHorizontal
            Align = alLeft
            Caption = #21442#32771#24110#21161
            ParentShowHint = False
            ShowHint = False
            object bsSkinSplitter7: TbsSkinSplitter
              Left = 1
              Top = 146
              Width = 215
              Height = 10
              Cursor = crVSplit
              Align = alTop
              Transparent = False
              DefaultSize = 10
              SkinDataName = 'hsplitter'
              SkinData = bsSkinData1
            end
            object MemoFongHaoHint: TbsSkinMemo
              Left = 1
              Top = 156
              Width = 196
              Height = 311
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ParentFont = False
              ScrollBars = ssVertical
              TabOrder = 0
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clBlack
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              UseSkinFont = False
              UseSkinFontColor = True
              BitMapBG = True
              VScrollBar = bsSkinScrollBar1
              SkinData = bsSkinData1
              SkinDataName = 'memo'
            end
            object ListBoxFongHaoHint: TbsSkinListBox
              Left = 1
              Top = 21
              Width = 215
              Height = 125
              TabOrder = 1
              SkinData = bsSkinData1
              SkinDataName = 'listbox'
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              DefaultWidth = 0
              DefaultHeight = 0
              UseSkinFont = False
              AutoComplete = True
              UseSkinItemHeight = True
              HorizontalExtent = False
              Columns = 0
              RowCount = 0
              ImageIndex = -1
              NumGlyphs = 1
              Spacing = 2
              CaptionMode = False
              DefaultCaptionHeight = 20
              DefaultCaptionFont.Charset = GB2312_CHARSET
              DefaultCaptionFont.Color = clWindowText
              DefaultCaptionFont.Height = -12
              DefaultCaptionFont.Name = #23435#20307
              DefaultCaptionFont.Style = []
              DefaultItemHeight = 20
              ItemIndex = -1
              MultiSelect = False
              ListBoxFont.Charset = GB2312_CHARSET
              ListBoxFont.Color = clWindowText
              ListBoxFont.Height = -12
              ListBoxFont.Name = #23435#20307
              ListBoxFont.Style = []
              ListBoxTabOrder = 0
              ListBoxTabStop = True
              ListBoxDragMode = dmManual
              ListBoxDragKind = dkDrag
              ListBoxDragCursor = crDrag
              ExtandedSelect = True
              Sorted = False
              Font.Charset = GB2312_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              Align = alTop
            end
            object bsSkinScrollBar1: TbsSkinScrollBar
              Left = 197
              Top = 156
              Width = 19
              Height = 311
              TabOrder = 2
              SkinData = bsSkinData1
              SkinDataName = 'vscrollbar'
              DefaultFont.Charset = GB2312_CHARSET
              DefaultFont.Color = clWindowText
              DefaultFont.Height = -12
              DefaultFont.Name = #23435#20307
              DefaultFont.Style = []
              DefaultWidth = 19
              DefaultHeight = 0
              UseSkinFont = False
              Enabled = False
              Both = False
              BothMarkerWidth = 19
              BothSkinDataName = 'bothhscrollbar'
              CanFocused = False
              Align = alRight
              Kind = sbVertical
              PageSize = 0
              Min = 0
              Max = 0
              Position = 0
              SmallChange = 1
              LargeChange = 1
            end
          end
          object FongHaoDBGrid: TDBGridEh
            Left = 227
            Top = 82
            Width = 582
            Height = 468
            Align = alClient
            DataSource = FrmDM.DataSourceFongHao
            Flat = False
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clBtnText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            FooterRowCount = 1
            FrozenCols = 2
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            PopupMenu = bsSkinPopupMenu3
            RowDetailPanel.Color = clBtnFace
            SumList.Active = True
            TabOrder = 3
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clBtnText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            Columns = <
              item
                EditButtons = <>
                FieldName = 'Idx'
                Footers = <
                  item
                    Alignment = taCenter
                    Value = #21512#35745':'
                    ValueType = fvtStaticText
                  end>
                Title.Caption = #24207#21495
                Width = 75
              end
              item
                EditButtons = <>
                FieldName = 'Name'
                Footers = <
                  item
                    Alignment = taCenter
                    FieldName = 'Name'
                    ValueType = fvtCount
                  end>
                Title.Caption = #31216#21495
              end
              item
                EditButtons = <>
                FieldName = 'Stdmode'
                Footers = <>
                Title.Caption = #20998#31867
              end
              item
                EditButtons = <>
                FieldName = 'Shape'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Anicount'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Hours'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Looks'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'DuraMax'
                Footers = <>
                Title.Caption = #25345#20037#21147
              end
              item
                EditButtons = <>
                FieldName = 'AC'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Ac2'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Mac'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Mac2'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Dc'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Dc2'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Mc'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Mc2'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Sc'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Sc2'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Need'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'NeedLevel'
                Footers = <>
              end
              item
                EditButtons = <>
                FieldName = 'Stock'
                Footers = <>
              end>
            object RowDetailData: TRowDetailPanelControlEh
            end
          end
        end
      end
    end
    object bsSkinTabSheet3: TbsSkinTabSheet
      Caption = 'Wil'#32534#36753#22120
      object bsSkinSplitter5: TbsSkinSplitter
        Left = 233
        Top = 0
        Width = 10
        Height = 569
        Transparent = False
        DefaultSize = 10
        SkinDataName = 'vsplitter'
        SkinData = bsSkinData1
        ExplicitHeight = 468
      end
      object bsSkinPanel8: TbsSkinPanel
        Left = 0
        Top = 0
        Width = 233
        Height = 569
        TabOrder = 0
        SkinData = bsSkinData1
        SkinDataName = 'panel'
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
        CaptionMode = False
        RollUpMode = False
        RollUpState = False
        NumGlyphs = 1
        Spacing = 2
        Caption = 'bsSkinPanel8'
        Align = alLeft
        object bsSkinGroupBox3: TbsSkinGroupBox
          Left = 1
          Top = 319
          Width = 231
          Height = 121
          TabOrder = 0
          SkinData = bsSkinData1
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
          BorderStyle = bvRaised
          CaptionMode = True
          RollUpMode = False
          RollUpState = False
          NumGlyphs = 1
          Spacing = 2
          Caption = #22270#29255#20449#24687
          Align = alBottom
          object Label3: TbsSkinStdLabel
            Left = 12
            Top = 23
            Width = 36
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
            Caption = #31867#22411#65306
          end
          object Label2: TbsSkinStdLabel
            Left = 12
            Top = 39
            Width = 36
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
            Caption = #23610#23544#65306
          end
          object Label7: TbsSkinStdLabel
            Left = 12
            Top = 105
            Width = 36
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
            Caption = #32534#21495#65306
          end
          object Labeltype: TbsSkinStdLabel
            Left = 46
            Top = 24
            Width = 6
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
          end
          object LabelSize: TbsSkinStdLabel
            Left = 52
            Top = 40
            Width = 6
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
          end
          object LabelIndex: TbsSkinStdLabel
            Left = 52
            Top = 103
            Width = 6
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
          end
          object LabelX: TbsSkinStdLabel
            Left = 60
            Top = 60
            Width = 6
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
          end
          object LabelY: TbsSkinStdLabel
            Left = 60
            Top = 81
            Width = 6
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
          end
          object LabelColorCount: TbsSkinStdLabel
            Left = 132
            Top = 24
            Width = 6
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
          end
          object btnx: TbsSkinButton
            Left = 8
            Top = 56
            Width = 44
            Height = 19
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
            Caption = #21464#26356
            NumGlyphs = 1
            Spacing = 1
            OnClick = btnxClick
          end
          object btny: TbsSkinButton
            Left = 8
            Top = 79
            Width = 44
            Height = 19
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
            Caption = #21464#26356
            NumGlyphs = 1
            Spacing = 1
            OnClick = btnyClick
          end
        end
        object bsSkinGroupBox4: TbsSkinGroupBox
          Left = 1
          Top = 440
          Width = 231
          Height = 128
          TabOrder = 1
          SkinData = bsSkinData1
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
          Caption = #26174#31034#25511#21046
          Align = alBottom
          object checkboxTransparent: TbsSkinCheckRadioBox
            Left = 9
            Top = 81
            Width = 73
            Height = 21
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
            Caption = #36879#26126#26174#31034
            OnClick = Rb50Click
          end
          object CheckBoxjump: TbsSkinCheckRadioBox
            Left = 118
            Top = 80
            Width = 97
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
            Caption = #36339#36807#31354#30333#29031#29255
            OnClick = Rb50Click
          end
          object CheckBoxzuobiao: TbsSkinCheckRadioBox
            Left = 118
            Top = 101
            Width = 105
            Height = 22
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
            Caption = #26174#31034#22352#26631#32447
            OnClick = Rb50Click
          end
          object checkboxXY: TbsSkinCheckRadioBox
            Left = 9
            Top = 103
            Width = 109
            Height = 21
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
            TabStop = True
            CanFocused = True
            Radio = False
            Checked = False
            GroupIndex = 0
            Caption = #25353#23454#38469#22352#26631#26174#31034
            OnClick = Rb50Click
          end
          object Rb50: TbsSkinCheckRadioBox
            Left = 9
            Top = 25
            Width = 64
            Height = 21
            TabOrder = 4
            SkinData = bsSkinData1
            SkinDataName = 'radiobox'
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
            Radio = True
            Checked = False
            GroupIndex = 1
            Caption = '50%'
            OnClick = Rb50Click
          end
          object rb100: TbsSkinCheckRadioBox
            Left = 76
            Top = 25
            Width = 64
            Height = 21
            TabOrder = 5
            SkinData = bsSkinData1
            SkinDataName = 'radiobox'
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
            State = cbChecked
            ImageIndex = 0
            Flat = True
            TabStop = True
            CanFocused = True
            Radio = True
            Checked = True
            GroupIndex = 1
            Caption = '100%'
            OnClick = Rb50Click
          end
          object rb200: TbsSkinCheckRadioBox
            Left = 150
            Top = 25
            Width = 64
            Height = 21
            TabOrder = 6
            SkinData = bsSkinData1
            SkinDataName = 'radiobox'
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
            Radio = True
            Checked = False
            GroupIndex = 1
            Caption = '200%'
            OnClick = Rb50Click
          end
          object rb400: TbsSkinCheckRadioBox
            Left = 9
            Top = 46
            Width = 64
            Height = 21
            TabOrder = 7
            SkinData = bsSkinData1
            SkinDataName = 'radiobox'
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
            Radio = True
            Checked = False
            GroupIndex = 1
            Caption = '400%'
            OnClick = Rb50Click
          end
          object rb800: TbsSkinCheckRadioBox
            Left = 76
            Top = 46
            Width = 64
            Height = 21
            TabOrder = 8
            SkinData = bsSkinData1
            SkinDataName = 'radiobox'
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
            Radio = True
            Checked = False
            GroupIndex = 1
            Caption = '800%'
            OnClick = Rb50Click
          end
          object rbauto: TbsSkinCheckRadioBox
            Left = 150
            Top = 46
            Width = 75
            Height = 21
            TabOrder = 9
            SkinData = bsSkinData1
            SkinDataName = 'radiobox'
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
            Radio = True
            Checked = False
            GroupIndex = 1
            Caption = #33258#21160#32553#25918
            OnClick = Rb50Click
          end
        end
        object bsSkinPanel10: TbsSkinPanel
          Left = 1
          Top = 1
          Width = 231
          Height = 318
          TabOrder = 2
          SkinData = bsSkinData1
          SkinDataName = 'panel'
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
          CaptionMode = False
          RollUpMode = False
          RollUpState = False
          NumGlyphs = 1
          Spacing = 2
          Caption = 'bsSkinPanel10'
          Align = alClient
          object bsSkinStdLabel6: TbsSkinStdLabel
            Left = 4
            Top = 7
            Width = 48
            Height = 12
            EllipsType = bsetNone
            UseSkinFont = False
            UseSkinColor = True
            DefaultFont.Charset = DEFAULT_CHARSET
            DefaultFont.Color = clWindowText
            DefaultFont.Height = -11
            DefaultFont.Name = 'MS Sans Serif'
            DefaultFont.Style = []
            SkinData = bsSkinData1
            SkinDataName = 'stdlabel'
            Caption = #25991#20214#21517#65306
          end
          object btnup: TbsSkinButton
            Left = 17
            Top = 29
            Width = 81
            Height = 22
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
            Caption = #19978#19968#24352
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btnupClick
          end
          object btndelete: TbsSkinButton
            Left = 17
            Top = 56
            Width = 81
            Height = 22
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
            Caption = #21024'  '#38500
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btndeleteClick
          end
          object BtnAutoPlay: TbsSkinButton
            Left = 17
            Top = 82
            Width = 81
            Height = 22
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
            Caption = #33258#21160#25773#25918
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = BtnAutoPlayClick
          end
          object btninput: TbsSkinButton
            Left = 17
            Top = 108
            Width = 81
            Height = 22
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
            Caption = #23548'  '#20837
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btninputClick
          end
          object btnAdd: TbsSkinButton
            Left = 17
            Top = 134
            Width = 81
            Height = 22
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
            Caption = #28155#21152#22270#29255
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btnAddClick
          end
          object btnallinput: TbsSkinButton
            Left = 17
            Top = 160
            Width = 81
            Height = 22
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
            Caption = #25209#37327#23548#20837
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btnallinputClick
          end
          object btndown: TbsSkinButton
            Left = 131
            Top = 29
            Width = 83
            Height = 22
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
            Caption = #19979#19968#24352
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btndownClick
          end
          object BtnJump: TbsSkinButton
            Left = 131
            Top = 56
            Width = 83
            Height = 22
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
            Caption = #36339'  '#36716
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = BtnJumpClick
          end
          object btnstop: TbsSkinButton
            Left = 131
            Top = 82
            Width = 83
            Height = 22
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
            Caption = #20572'  '#27490
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btnstopClick
          end
          object BtnOut: TbsSkinButton
            Left = 131
            Top = 108
            Width = 83
            Height = 22
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
            Caption = #23548'  '#20986
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = BtnOutClick
          end
          object btnCreate: TbsSkinButton
            Left = 131
            Top = 134
            Width = 83
            Height = 22
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
            Caption = #21019#24314#26032#25991#20214
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btnCreateClick
          end
          object btnallOut: TbsSkinButton
            Left = 131
            Top = 160
            Width = 83
            Height = 22
            TabOrder = 11
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
            Caption = #25209#37327#23548#20986
            NumGlyphs = 1
            Spacing = 1
            Enabled = False
            OnClick = btnallOutClick
          end
          object EditFileName: TbsSkinFileEdit
            Left = 52
            Top = 4
            Width = 166
            Height = 16
            DefaultColor = clWindow
            DefaultFont.Charset = GB2312_CHARSET
            DefaultFont.Color = clBlack
            DefaultFont.Height = -12
            DefaultFont.Name = #23435#20307
            DefaultFont.Style = []
            UseSkinFont = False
            DefaultWidth = 0
            DefaultHeight = 0
            ButtonMode = True
            SkinData = bsSkinData1
            SkinDataName = 'buttonedit'
            Font.Charset = GB2312_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ParentFont = False
            TabOrder = 12
            OnButtonClick = EditFileNameButtonClick
            Filter = 'Wil'#25991#20214'(*.Wil)|*.Wil'
            DlgSkinData = bsSkinData1
            DlgCtrlSkinData = bsSkinData1
            LVHeaderSkinDataName = 'resizebutton'
          end
        end
      end
      object bsSkinPanel9: TbsSkinPanel
        Left = 243
        Top = 0
        Width = 568
        Height = 569
        TabOrder = 1
        SkinData = bsSkinData1
        SkinDataName = 'panel'
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
        CaptionMode = False
        RollUpMode = False
        RollUpState = False
        NumGlyphs = 1
        Spacing = 2
        Caption = 'bsSkinPanel9'
        Align = alClient
        object bsSkinSplitter6: TbsSkinSplitter
          Left = 1
          Top = 282
          Width = 566
          Height = 10
          Cursor = crVSplit
          Align = alTop
          Transparent = False
          DefaultSize = 10
          SkinDataName = 'hsplitter'
          SkinData = bsSkinData1
          ExplicitWidth = 421
        end
        object bsSkinPanel11: TbsSkinPanel
          Left = 1
          Top = 292
          Width = 566
          Height = 276
          TabOrder = 0
          SkinData = bsSkinData1
          SkinDataName = 'panel'
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
          CaptionMode = False
          RollUpMode = False
          RollUpState = False
          NumGlyphs = 1
          Spacing = 2
          Caption = 'bsSkinPanel11'
          Align = alClient
          object DrawGrid1: TDrawGrid
            Left = 1
            Top = 1
            Width = 564
            Height = 274
            Align = alClient
            ColCount = 6
            DefaultRowHeight = 64
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
            TabOrder = 0
            OnDrawCell = DrawGrid1DrawCell
          end
        end
        object bsSkinPanel12: TbsSkinPanel
          Left = 1
          Top = 1
          Width = 566
          Height = 281
          TabOrder = 1
          SkinData = bsSkinData1
          SkinDataName = 'panel'
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
          CaptionMode = False
          RollUpMode = False
          RollUpState = False
          NumGlyphs = 1
          Spacing = 2
          Caption = 'bsSkinPanel12'
          Align = alTop
          object Image1: TImage
            Left = 8
            Top = 8
            Width = 105
            Height = 105
          end
          object ScrollBox1: TScrollBox
            Left = 1
            Top = 1
            Width = 564
            Height = 279
            Align = alClient
            TabOrder = 0
            object PaintBox1: TFlickerFreePaintBox
              Left = 0
              Top = 0
              Width = 560
              Height = 275
              OnPaint = PaintBox1Paint
              Align = alClient
            end
          end
        end
      end
    end
    object bsSkinTabSheet2: TbsSkinTabSheet
      Caption = #20854#20182#24037#20855
      OnShow = bsSkinTabSheet2Show
      object bsSkinGroupBox2: TbsSkinGroupBox
        Left = 0
        Top = 0
        Width = 811
        Height = 97
        TabOrder = 0
        SkinData = bsSkinData1
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
        Caption = #39068#33394#37197#32622
        Align = alTop
        object RzLabel1: TRzLabel
          Left = 1
          Top = 27
          Width = 809
          Height = 48
          Align = alTop
          Caption = ' 3KM2'#24341#25806' WWW.3KM2.COM'
          Color = clSkyBlue
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindow
          Font.Height = -48
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 548
        end
        object bsSkinPanel7: TbsSkinPanel
          Left = 1
          Top = 23
          Width = 809
          Height = 4
          TabOrder = 0
          SkinData = bsSkinData1
          SkinDataName = 'panel'
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
          CaptionMode = False
          RollUpMode = False
          RollUpState = False
          NumGlyphs = 1
          Spacing = 2
          Caption = 'bsSkinPanel7'
          Align = alTop
        end
        object TrackEditColor1: TbsSkinTrackEdit
          Left = 32
          Top = 72
          Width = 257
          Height = 16
          Text = '0'
          Increment = 1
          SupportUpDownKeys = True
          UseSkinFont = False
          PopupKind = tbpRight
          JumpWhenClick = True
          TrackBarWidth = 0
          TrackBarSkinDataName = 'htrackbar'
          AlphaBlend = False
          AlphaBlendAnimation = False
          AlphaBlendValue = 0
          MinValue = 0
          MaxValue = 255
          Value = 0
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clBlack
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          ButtonMode = True
          SkinData = bsSkinData1
          SkinDataName = 'buttonedit'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentFont = False
          TabOrder = 1
          OnChange = TrackEditColor1Change
        end
        object TrackEditColor2: TbsSkinTrackEdit
          Left = 344
          Top = 72
          Width = 257
          Height = 16
          Text = '0'
          Increment = 1
          SupportUpDownKeys = True
          UseSkinFont = False
          PopupKind = tbpRight
          JumpWhenClick = True
          TrackBarWidth = 0
          TrackBarSkinDataName = 'htrackbar'
          AlphaBlend = False
          AlphaBlendAnimation = False
          AlphaBlendValue = 0
          MinValue = 0
          MaxValue = 255
          Value = 0
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clBlack
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          DefaultWidth = 0
          DefaultHeight = 0
          ButtonMode = True
          SkinData = bsSkinData1
          SkinDataName = 'buttonedit'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentFont = False
          TabOrder = 2
          OnChange = TrackEditColor2Change
        end
      end
      object bsSkinGroupBox6: TbsSkinGroupBox
        Left = -2
        Top = 171
        Width = 668
        Height = 73
        TabOrder = 1
        SkinData = bsSkinData1
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
        Caption = #24618#29289#25968#25454#24211#25193#23637'(HP'#25903#25345'21'#20159')'
        object bsSkinStdLabel9: TbsSkinStdLabel
          Left = 29
          Top = 39
          Width = 60
          Height = 12
          EllipsType = bsetNone
          UseSkinFont = False
          UseSkinColor = True
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'MS Sans Serif'
          DefaultFont.Style = []
          SkinData = bsSkinData1
          SkinDataName = 'stdlabel'
          Caption = #20445#23384#36335#24452#65306
        end
        object bsSkinFileEdit2: TbsSkinFileEdit
          Left = 96
          Top = 37
          Width = 353
          Height = 16
          DefaultColor = clWindow
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clBlack
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          UseSkinFont = False
          DefaultWidth = 0
          DefaultHeight = 0
          ButtonMode = True
          SkinData = bsSkinData1
          SkinDataName = 'buttonedit'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentFont = False
          TabOrder = 0
          OnButtonClick = bsSkinFileEdit2ButtonClick
          Filter = 'Wil'#25991#20214'(*.Wil)|*.Wil'
          DlgSkinData = bsSkinData1
          DlgCtrlSkinData = bsSkinData1
          LVHeaderSkinDataName = 'resizebutton'
        end
        object bsSkinButton2: TbsSkinButton
          Left = 473
          Top = 32
          Width = 83
          Height = 27
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
          Caption = #25968#25454#24211#36716#25442
          NumGlyphs = 1
          Spacing = 1
          Enabled = False
          OnClick = bsSkinButton2Click
        end
      end
      object bsSkinGroupBox7: TbsSkinGroupBox
        Left = -2
        Top = 243
        Width = 668
        Height = 73
        TabOrder = 2
        SkinData = bsSkinData1
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
        Caption = #25216#33021#25968#25454#24211#25193#23637'('#25216#33021#21517#25903#25345'9'#27721#23383')'
        object bsSkinStdLabel10: TbsSkinStdLabel
          Left = 29
          Top = 39
          Width = 60
          Height = 12
          EllipsType = bsetNone
          UseSkinFont = False
          UseSkinColor = True
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'MS Sans Serif'
          DefaultFont.Style = []
          SkinData = bsSkinData1
          SkinDataName = 'stdlabel'
          Caption = #20445#23384#36335#24452#65306
        end
        object bsSkinFileEdit3: TbsSkinFileEdit
          Left = 96
          Top = 37
          Width = 353
          Height = 16
          DefaultColor = clWindow
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clBlack
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          UseSkinFont = False
          DefaultWidth = 0
          DefaultHeight = 0
          ButtonMode = True
          SkinData = bsSkinData1
          SkinDataName = 'buttonedit'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentFont = False
          TabOrder = 0
          OnButtonClick = bsSkinFileEdit3ButtonClick
          Filter = 'Wil'#25991#20214'(*.Wil)|*.Wil'
          DlgSkinData = bsSkinData1
          DlgCtrlSkinData = bsSkinData1
          LVHeaderSkinDataName = 'resizebutton'
        end
        object bsSkinButton6: TbsSkinButton
          Left = 473
          Top = 32
          Width = 83
          Height = 27
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
          Caption = #25968#25454#24211#36716#25442
          NumGlyphs = 1
          Spacing = 1
          Enabled = False
          OnClick = bsSkinButton6Click
        end
      end
      object bsSkinGroupBox9: TbsSkinGroupBox
        Left = 0
        Top = 96
        Width = 666
        Height = 76
        TabOrder = 3
        SkinData = bsSkinData1
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
        Caption = #29289#21697#25968#25454#24211#23383#27573#25193#23637'(Desc,HP, MP)'
        object bsSkinStdLabel13: TbsSkinStdLabel
          Left = 29
          Top = 47
          Width = 90
          Height = 12
          EllipsType = bsetNone
          UseSkinFont = False
          UseSkinColor = True
          DefaultFont.Charset = DEFAULT_CHARSET
          DefaultFont.Color = clWindowText
          DefaultFont.Height = -11
          DefaultFont.Name = 'MS Sans Serif'
          DefaultFont.Style = []
          SkinData = bsSkinData1
          SkinDataName = 'stdlabel'
          Caption = #36873#25321#25968#25454#24211#25991#20214':'
        end
        object bsSkinFileEdit4: TbsSkinFileEdit
          Left = 120
          Top = 45
          Width = 329
          Height = 16
          DefaultColor = clWindow
          DefaultFont.Charset = GB2312_CHARSET
          DefaultFont.Color = clBlack
          DefaultFont.Height = -12
          DefaultFont.Name = #23435#20307
          DefaultFont.Style = []
          UseSkinFont = False
          DefaultWidth = 0
          DefaultHeight = 0
          ButtonMode = True
          SkinData = bsSkinData1
          SkinDataName = 'buttonedit'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentFont = False
          TabOrder = 0
          OnButtonClick = bsSkinFileEdit4ButtonClick
          Filter = 'Wil'#25991#20214'(*.Wil)|*.Wil'
          DlgSkinData = bsSkinData1
          DlgCtrlSkinData = bsSkinData1
          LVHeaderSkinDataName = 'resizebutton'
        end
        object bsSkinButton8: TbsSkinButton
          Left = 473
          Top = 40
          Width = 83
          Height = 27
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
          Caption = #25968#25454#24211#36716#25442
          NumGlyphs = 1
          Spacing = 1
          Enabled = False
          OnClick = bsSkinButton8Click
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
    UseSkinFontInMenu = False
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
    DefCaptionFont.Style = [fsBold]
    DefInActiveCaptionFont.Charset = GB2312_CHARSET
    DefInActiveCaptionFont.Color = clBtnShadow
    DefInActiveCaptionFont.Height = -12
    DefInActiveCaptionFont.Name = #23435#20307
    DefInActiveCaptionFont.Style = [fsBold]
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
    BorderIcons = [biSystemMenu, biMinimize, biMaximize, biRollUp]
    Left = 609
    Top = 2
  end
  object bsSkinData1: TbsSkinData
    EnableSkinEffects = True
    CompressedStoredSkin = bsCompressedStoredSkin1
    Left = 641
    Top = 2
  end
  object bsCompressedStoredSkin1: TbsCompressedStoredSkin
    FileName = 'skin.ini'
    Left = 673
    Top = 2
    CompressedData = {
      78DAECBD79941BC79DE7599EDDB7336FF7BDFD63DFDBF7FAED9BD9E73FFDC7EE
      4CCFF4F4B5EDEEAE765BED6E7B6CF5B48FB1EC6E5B9EB66C59B22C5BD698B62C
      D9A5C3A69B32254AB4444ABC259194488AE2211EE25964F1A8FBBE0FD47D0005
      5415AA0A575DB1DF44A0925909209140662512C037F4A912888CFCFD7E115111
      5F642032E37F2A43FAD4E7BF73ED5F292FCAFE083F9FC0CFBFFB5859592BFEFF
      B1B2DF8BBFFFFB89E3DA2434E9B9AFFD19212437B45DA94CED51BFF9D6A722ED
      9742CD670921D982BE831EA4F6AE32D9A9DED8F28F91A10610EDBF4B08C916D9
      7DD08F64D752FAD56FBEF5D791F1AE0463ED8490AC59EF41E84D4ABF42F7EABE
      FAEEEACC2821C42291B10EF426F429A55FB13A08B111F62B42D8AF0861BF2284
      FD8A10C27E4508FB1521EC578410F62B42D8AF0861BF2284B05F11C27E4508FB
      152184FD8A10F62B42D8AF0821EC5784B05F11C27E450861BF2284FD8A10F62B
      42D8AFD8AF0861BF2284FD8A10F62B4208FB1521EC5784B05F1142D8AF0861BF
      2284FD8A10C27E4508FB1521EC578410F62B42D8AF0861BF2284B05F11C27E45
      08FB152184FD8A10F62B42D8AF0861BF62BF2284FD8A10F62B42D8AF0821EC57
      84B05F11C27E450861BF2284FD8A10F62B4208FB1521EC5784B05F1142D8AF08
      61BF2284FD8A10C27E4508FB1521EC578410F62B42D8AF0861BF2284FD8AFD8A
      10F62B42D8AF0861BF2284B05F11C27E4508FB152184FD8A10F62B42D8AF0821
      EC5784B05F11C27E450861BF2284FD8A10F62B4208FB1521EC5784B05F1142D8
      AF0861BF2284FD8A10F62BD60521EC5784B05F11C27E450861BF2284FD8A10F6
      2B4208FB1521EC5784B05F1142D8AF0861BF2284FD8A10C27E4508FB1521EC57
      8410F62B42D8AF0861BF2284B05F11C27E4508FB1521EC578410F62B42D8AF08
      61BF2284B05F11C27E4508FB152184FD8A10F62B42D8AF0821EC5784B05F11C2
      7E450861BF2284FD8A10F62B4208FB1521EC5784B05F1142D8AF0861BF2284FD
      8A10F62B4208FB1521EC5784B05F1142D8AF0861BF2284FD8A10C27E4508FB15
      21EC578410F62B42D8AF0861BF2284B05F11C27E4508FB152184FD8A10F62B42
      D8AF0861BF62BF2284FD8A10F62B42D8AF0821EC5784B05F11C27E450861BF22
      84FD8A10F62B4208FB1521EC5784B05F1142D8AF0861BF2284FD8A10C27E4508
      FB1521EC578410F62B42D8AF0861BF2284FD8AFD8A10F62B420AA45FADCD4D00
      560721B6EAD5EC1821C42ED8AF08D9BC7E45ED26C4F6CF812B816142885DACF7
      2BFF2021C42ED6FB956F80106217EC57846C5ABF5AF6F61142EC62BD5F4DF510
      42EC22D1AF9626BA082176C17E45C8E6F5ABF10E42885D24FA556CAC8D106217
      EBFD6AA485106217897E151D6E2284D805FB15219BD7AF861A082176B1DEAF06
      EB09217691E857114F2D21C42EEE7D7F159BEC218458E7DEF757EC57846C4EBF
      9AE82284586743BF2284D8BC8EA9EDF2BBABDE5E428875D09B947E2584D8FBC4
      7F8D793DCBBE01428815D08FD09BD0A7947E85EEF5CEF30F87BD43D1E9614248
      6EA007A11FA13725FA95EC5AE8679D772E85A7470921D982BE831E243BD5BD7E
      A5F62E42486E68BB52D9C7CA3EF5F99FCC95C5D31FFDCF65659FC0FFFFDDC7CA
      CA5AF1FF8F95FD9BF8FBE5FEB27BE9639AD7651571CA2A2AE4FF94FFF0A2B2B2
      B2ACB2BFB26CAEF64859D9C7CBF1F3207E70E0E307F153899F2118550C7F1C3F
      78518EE3E5385E8EE3E5385E8EE378ABEC411C7F10C71FC43F1EC4F10771FC41
      1C7F7028E117C72B70BCE2C1780C6515385E81E315388E97650771FC208E1FC4
      F183387E106F1EC4F183388EFF9555E278258E57E278A512F8412578FCE03828
      1BC2F1211C1FC2F1211C1FC2F1211C1F1A92E1977D1C3FCA7F0FE2A7023F07F1
      53899F2159B48FE338CA5F8EF297A3FCE5287F39CA5F8EF2C78B8D4CE578518E
      F297A3FCE5287F39CA5F8EF2C7AB04E52F47F9CB51FE7294BF1CE52F47F9CB51
      FE7875A1FCE5287F39CA5F8EF297A3FCE5287F39CA1FAF4A94BF1CE52F47F9CB
      51FE7294BF1CE52F47F9E3D58CF297A3FCE5287F39CA5F8EF297A3FCE528BFD2
      04E5287F39CA5F8EF297A3FCE5287F39CA5F8EF2CBF6FE78BCD415287FBCED51
      FE0A94BF02E58F370DCA5F81F257A0FC15287F05CA5F81F257A0FCF16643F92B
      50FE0A14B60205AA40D01508AC02CEE34D8AF257A0FC15287F05CA5F81F257A0
      FC15287FBCB9E1A402862A90B942F91B44F92B50FE0A943FFEA780F257A0FC15
      287F05CA5F81F257A0FC15287FFCCF04E5AF40F92B50FE0A94BF02E5AF40F92B
      507EE54FA802E5AF40F92B50FE0A94BF02E5AF40F92B50FEF89F0FCA5F196FF1
      07E3A5AE44F92BE3FF0DC93F2D94BF12E5AF44F92B51FE4A94BF12E5AF44F9E3
      7F76287F25CA5F89F257A2FC95287F25CA5F89F2C7FF2451FE4A94BF12E5AF44
      F92B51FE4A94BF12E58FFFB9A2FC95287F25CA5F89F257A2D095285825828FFF
      29A3FC95287F25CA5F89F257A2FC95287F25CA1FFF3347909508A412CE2A61B0
      1227CD2D8BB277947A522AB84CC42953F437FE2F4587957F4A3D2E634A4E898A
      61ED18D490FCCB624A5741AC9F8CF5C3C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
      C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
      C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
      C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
      C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
      C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
      C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4
      C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C494DF2458058675C3FAC9503FACA0B4D5
      23EB873594A676E215F36FF0F3A9CF3FE1936FFE117E3E819FCFE1E75F7FACAC
      EC6365BF177FFF93BE6403AB33A3C50DCBC832B28C2C23CBC832B28C66CB383B
      3A52736EACFED2546BA5AFE3B6BFA766A6BF71CED30C7C5D77BD1DB727DBAEAC
      064664CE60CFDDC9DA3360AAEEAC16F96670E086CCB9169A318363651CBD733A
      3CD5BF169B595B9A13CB0B62252C5663626D4501AF97179682BEF19A0F9133D8
      7D67B2FAF4B2B73F1D933567823D7764193306E36419E76F1E585B9C589EE85A
      9E1E5498195B9E19577E074697FDC3CB933D6239B250F516724EDCF92034DC1A
      6A3B16E9FB10C4862FC546AFC5C6AEC546AE463D17018E4EDC3DE5C2322E54ED
      5F0B4DA72BE3AA17658C2DDE52CA3876EDE044C3A5B99A43F3ED275382A3C8E3
      C232866E1D580BF95726BA5602C30F6D4C4A065F9F58892DDE91653CE06BB9E6
      BDF4CA54D5415DCEC9BBEF001C451E5DFC296CE6A78C0159C68FDE7C4E8B1289
      AF5F29E3ED7819AF2A659C3CBF7DECDA1E5DCED1CA834029E3557D19936D3A5F
      C6C5AA8362292C160322165A5B0AAFADC4D69697D796636B4B51110B8B5040AC
      2C2DDE7E4729E395FD739D55FEDB87FDF56703F5A7FDCD17FD4D1F4D375FF637
      5E9C6E38EF6F3C87A3C8E3C6FE587D442C47D7943286757F5722B6B8169A152B
      CB0B35C79411F8DAA1707FCDCC9DA328A32EE774E3055FFD47388A3C2EFC5B5D
      A83F8551652D3C8746D4FD5DADC5C2787F35321F8C9771FCC6E1A5A19AB9BAF7
      E75A3ED2E59C6BBB026283356357DCF8B7AA947165792DB2B0BA1455585E5A27
      B61A8BAC451751C6F98653B28CA1BE8658D7B5E5FE3B4B9EEAE5A1FA95E1DAD5
      A1FAE5A19A654FCD92A72632D03072F3B00BFF5667DAAE2D87C2AB91D05A2C22
      CB88CE8802AE2DC78B1C0B073D4DC8839C81C6731852C4445B3A7014795C58C6
      D844D74CFB0D639047E69C6DBE387EFD609C431B51DEC45199D36D9FE578DDC1
      32F2DA8AD756BCB6DAA46B2BEDA711E36B2B6D4EE36BAB949F70F2786DB5E153
      65D0BB3A3791EEDA4A9B13D75920DDB555CA4FAAF9BDB602ABC1A9D579AF5AC6
      74D7563A0CAEADDCF0B75A6AD75649654C7B6DE5AB3DEF6DBC32D97279BAE9D2
      54F325836B2B579451736D152FE3721CE593B9C1B59542C7F5B9CECAB98E4AE5
      45FA6B2BB79491D756BCB6E2B515AF3B78DDC1EB0E5E77A4B9EEA83FB24D8BC1
      75872EA7C175872E67DEAF3B6EBFB555FD4C7E74FB539294D71DC8292F37809A
      33E5750772AA8EEED9CCDF75C7C9579FD19611D71DD7F6BD90F2BA0339D52B0E
      E4C46FE44C79DD819CDA32E23772E6F1BA43AD67C95234726E5745CAEB0E5D4E
      940E39535E77E872E21DE4CCE37587EECB1734014879DD913267CAEB8E9439F3
      7EDDA18BCAE0BA4397D3E0BA23E55757BCEEE07507AF3B78DDC1EB0E5E77F0BA
      836BC99C5C4B567FF44580CFE48917E9D792C90CEA0B83B564AAA97B36F3FD7D
      47E5815F49327EDFA1E6CCF87DC73D9BAEF9BE43597D64EEFB0EE434F97D477E
      BF9BD37DDF71E295A7F1B119BF337EDFA1E6CCF87D879AD30DDF7724AE355696
      132FD27FDF91B8D6E8AC542F3AD25D77A8D71A795E2FC7EB0E5E77F0BAC3AD9F
      C973FB589EFCC97C79AAC72479F84C6EE163B9F693F9D24497499CFC4CBE148D
      E830F8589E9C59F7C97C434192323B5946ED6772DDBA68653152FA8FE5C99975
      9FCC97C63B5492336B8FE6F1FE8EAC6EF148BECB2336D6A6929C597BD4F13548
      93B92D434AFE641E1B693189939FC9937B8DC1C7F2E4CCBA4FE6D1E12695149D
      5773D4C9CFE4C9BDC6E063797266DD27736D2992333B5AC6A4CFE41BBE0BC8F4
      B15CF77580F6937974A8412539B3F668FE3E939BF9586EF4C93C3A586F12873F
      93AF59FB58AEFD641EF1D49AC40D9FC9CD7D2CD77F328F4DF698849FC95946A3
      321A5E6ECC0DB624F0B4CC0E3482406FBDFE1A64DD8EC195484A7497279B57C6
      0C971B624D24D25AE21D1CDA780D22317325627C7902E447AC9C4957C6C9CAB7
      94CB8D9116E5D3B8B72F31491E1851A6C74162B67C7DC25C7E2FE01BC035C85A
      68D27BEB986A475E89443A3F88E14AC4736179E42385B12B2B939560D57767D5
      5FADE0BDBD3C711D2C8D5C8A792E20B37A79A294D13F68857465F45EDBBFB6E8
      5D1969CEAA8CAB53DDB848F1DD7C47B5337EFBC46CF79DC5867770C115EEFA40
      7E15121DBCA07C1BA27E21A2F94E0447912DD47A0C678DDF399128A36FC00AE9
      CAE8BF8E8FE2D32BA3D9B523AEB3D6C28140D5BD324EDC3E36D57879EED69BB8
      E00A36BD2B2FAF16BACF2EF67CA8D07B4EB2D0F3E142E71930DF7612D9901967
      4DDC39BEA9659CBEBE3FF7326ADA71E2568A321AA12DE3EDC4DFBC128005D295
      31508932FA57C75A94AB2A9F27D17967C7E3D756EB9757EA1596BC9FC5EFC1B5
      E45A7866B6EAED7B7FAB5547876F9FF25FDEE1BFB1DB7FE760A0EE8801FEC6E3
      81DA23C8E6AFDC8DB3706EA28CA6677E324E0769CB387703650CAC8DB5665546
      E55A32323B77EB5E3B8EDD383270FD5DDFB9DF2817CED777ABEBE8929157D0CA
      EBEBBB9119678DDF3C228D989FF9C9381D645B1935ED68A58C387753CB1854CA
      38937519BDBD2232377F4BF3B75AF976DF9577BC675E983CBF7DFCD26B29E707
      B4B30478317EE977C88CB3706EA28C9AB99D1C4857C67979F93FEF53660022C1
      C41773CB115C772837B0C8BB75E49D2C4B515C442B13029179654E6039B2A029
      E3D8F5B746EB2E066EEEF7DF3E3C5D7D1CD7CEFEFA33D30DE77DCA6D4A1F4DC7
      6F56525E24BEBF3BEFAD3D856CD3B7DFC1593837715DA099DBC981B465BC7920
      F73256BD75AF8CD70EE9CAA87C3559AF9451BD216B1A2FD6BFA3DC50C6F87441
      56333F19A783B4655CA8DAAF4C71CCFB94590E042F6FB64A5BC698882D229B32
      EFB13E0FB95E466536724629E391E9EA13F1763CED4FB4638A32FAEA4E4FDF3D
      8E0A51A72875B3223990AE8CA15B0794298EC58032CB115D948B1EE3F300B1F8
      05F2D2EA8A7267D9EAD2927C4799F4882E20B33A0FB95E4665A66EA6EAD0CC9D
      A381DA93F2EBD7C9A68BF8E3546F3AC30BF57B58A5A16B4F22B33A45E9701995
      B2288DB8B47E67D97A53EACA785B53C6ABFA322AA0D5502885CBEB5CF2375E50
      D096F1EA7A1935733B3990AE8CCA9423E20FCDAE85836B4A678C2828C5595258
      5967595BC6C535FC55AFCF4326CA189F8D9CBB7B5499C86A3C9BB8A5AEED8A72
      33DDBD1BEBEEDD5BA71C4536645E9FA2CC6AE627E374D086FE587D243E5535BF
      165940FCEB1356B18D7356EB335772F22A5E4C751E32718D169F8D5C6C38156A
      B910EAB812EABA01C23DB7C2BD7714FAEE26C06BBCD9732BD455A9646B39AF4E
      516635F393713A68431995E9B8D05A34A4B44E34AC0C35CA80134BB4DAD2923A
      E0C47FA38011255B2CA4CE4326F4313E1BB9D4F651ACEB5AACEFA63A5FB7E2A9
      D54CD9DD9BB55B1AB8B5D47D33DA755D9DA2CC6AE627E37490AE8CCB21B40B62
      0EC5DB2892187094065D4A4CCD25069CE86A4C6965250F5A7C7D1E522D63A8AF
      61A1F34AACFB7AA4F74EC4733736703732501F1EAA5B1AAC8B791A23230D7811
      F53444F0CE4075B4AF3ADC772BD65DA94E516E5E1967DAAE053D4D626D2D5BD4
      79C8C4677B13B391C6539472BACF0AE9CA6872CAD1601E52B563381B7928E314
      E5E67D96E3DC23E71E39F7C8B947CE3D72EE91738F9C7B4C2EA35C7A617DEE11
      4337B03AF798B42ECB96B9C7C4D3992CCF3D4A3B16E71E13EBB26C9D7BDCF010
      2A0B738F5A3B39CF3DA65B7E6665EE3179214D6E738F2956EF643FF7986CC4FA
      DCE3436952B6738FE9EC6435F798CE08E71E39F7C8B947CE3D72EE91738F9C7B
      E4DC23E71E39F7C8B947CE3D72EE91738F9C7BE4DCA3C979B9147762CA49C82C
      E71ED3D9C96EEE318D118B738F0F3DF450F2349172176496738FE9EC6435F798
      CE88F5B9479DE54401B39F7B4CB693C3DC63B211BBD63DAA9695FBE62CAC7BD4
      DAC979DDA3D688BDEB1ED71FDC6175DD6362F72B6BEB1ED34D3972EE91738F9C
      7BE4DC23E71E39F7C8B947CE3D72EE91738F9C7BE4DC23E71EF33FF7984C9673
      8FE970C9DC63CA99A21CE61E53DAC976EE31753096E71E751B8BDCDB5E24CBB9
      C79476B29D7B4C69C4FABAC7DB6F6DD5CD8625B61AC972DD634A3BD9AE7B4C69
      C4FABAC773BB2A7466139B6E64B9EE31A59D6CD73DA634627DDDA3DC6543470E
      EB1E53DAC976DD634A23D6E71E759BA74872987B4C6927DBB9C79446ACCF3DA6
      5EFA98FDDC634A3BD9CE3D9A59FAC8B947CE3D72EE91738F9C7BE4DC23E71E39
      F7C8B947CE3D72EE91738F9C7BE4BA471BE71E534FF165BFEE31F57C6396EB1E
      CDCC37E630F798BC322DE5BDBA19E71E53DAC976DD634A23D6D73DA69C52C8E1
      9EEB9476B2BDE73AA5113EEF91CF7BE4F31EF9BC47CE3D72EE91738F9C7BE4DC
      23E71E39F7C8B947CE3D72EE317F738FEB70EE91738F9C7B74C1DC6362D2CFF2
      DCE38619C85CE71E0D66204DCE3DA65C5E9858F198CDDCA3811DF3738F0646AC
      CC3DDE7E6B6BCA392B65C56336738F89958D49E07DF3738FC92B1B8DDF3759C6
      6BFB5E485946BCAF5DBF9A71EE11F9539651B56366EE11995396453592DBDCA3
      B26032D5DFBFB2AA736EE2DEFAD54C738F0676462B95D63433F76860044795D6
      CC69EE31E5124A09AEB6508126E71E0DEC4C379C871D33738F0646701446729B
      7B4CB98452222BD0E4DC63463B66E61E331AC96DEEF1A1F44956A0C9B9C78C76
      CCCC3D663492715E4E7E059E725ECEA002B39A7B34B0637EEED1C08895321A54
      6056738F0676CCCF3D1A18C938F728CB58DC738FB28CC53DF798286351CF3DAA
      652CE2B94759C6E29E7B94652CEEB947E18EB4A9F372A553C6E29E7B94652CEE
      758F32F4E29E7B94652CEEB94759C6E29E7B94652CEEE73DCA3226DF736D30AB
      99D5F31E0DEC987FDEA3D114AB89B94759C6E4358119A6584DDF736D60C7FCF3
      1E0D8C98997B4C574665F22DD59AC0C414ABE9758FC653AC26D73D6635C59AAE
      8CC9EB1EAFED7B21651995F7B359F788FC29D73DE27DF3EB1E9529D6541F4D53
      BE9FAE8CC9EB1E0D6635B35AF76860C7FCBA47032356D63D1ACC6A66B5EED1C0
      8EF9758F4653AC16D63D1ACC8365B5EED16852CEF4BA47F3937259AD09349A94
      CB66DDA3811DF3EB1E8D26E5B8EE91EB1EB9EE91EB1EDD30F7383B068A7CDD63
      5219B9EEB11091733B455EC6F8DC4E71AF7B94F31EC57DCF7572198B6FEE51CE
      ED14F7BA4739B753DCEB1EE5BC87F1F31E372C748C9771C33BA6E71E936FB5DE
      F08EB9B9C7E4858E064B1FD3953179EEB1FEE88B1265B2313885DFEA3B59CD3D
      6AEDC8A948F51DF3738F5A23722A527D27DDDCA3FC3C90F17EE4BB6FFF46029B
      EAEB1CF6B94E6927DB7DAE531A3158F728E776CCDC735D79E0575A72BEE75A67
      27B77BAE75468CEFB996733BD9EE736DF19E6BED26D7D6F7B9CEF87955CE7B98
      BCE7FAEC6BBF9458BCE75AB563E59E6BD548C67BAE539431CD3DD7275E791A3C
      F4D043F245CEF75CEBECE476CFB5CE88F13DD7726E27E33DD747B7FF0CC8DD79
      F05BFE33877BAE53DAC9F69EEB94460CEE4796733B26E71ED57BAE2DCE3DAAF7
      5C5B997B347847574639B753DC738F72DEA3B8E71E93CB587C738F726EA7B8E7
      1E933FCB15E1DCA3B71714F7DCA37209BF711EA0F8E61EA3D3C3A0B8E7E5C2D3
      0AC55DC6E7BEF6670065FCD4E7FFAF7F5D164F7F849F4FE0E7DFE2E7FFC4CFC7
      CA7E2FFEFED8FF5256F67FFC6FF2673D09210EBEB1F32736A5577EFB2F30F8C1
      F1A3A78E1E44EFB6859BE7DF7FE3772F3FF5B39F0506947FC682D3D6090EB5CA
      80E787DB613334E5B1086CC294B4B930DA69974D98923617C77BECB20953099B
      93FDB6D99CEC9736F14FBB6CE2B7B419F60DDB6513A6A4CD887FD42E9B3095B0
      3933619BCD990969333A3B65974D98923695BF7F9B6C026973693E60974D984A
      D85C9CB3CDE6E29CB4B91C5EB0CB264C499B2BD1905D36614ADAC46745BB6CC2
      140C3EFFFCF37333015B0664C56C24FCD4534FDDBC7973DFDEBD01BF1FD56B11
      1839F6DE7B674E9F867CD4D5D56DDDBAD5BA18C1C8B56BD760F0539FFFC62737
      2AE33FE1E78F35CAF8894FA654C6F7DF7FFFD74CEBE9C0810393939365172E5C
      B874E95288693DE1EFF5F0E1C365DBB66D0B06834B4CEB095583BF9A32FCE015
      AB83F5C27A61BDB05E582FAC17D60BEB85F5C27A61BDB05E582FAC17D60BEB85
      F5C27A61BDB05E582FAC17D60BEB85F5C27A61BDB05E582FAC17D60BEB85F5C2
      7A61BDB05E582F4CAC17D60BEB85F5C27A61BDB05E582FAC17D60BEB85F5C27A
      61BD98AD971D3B764C4F4FB33AD4140C06B76DDB5676EBD6ADC3870F4F4E4EF2
      CE4624D4C3A953A72E5CB85026EFCCFDDDEF7EC73B6191500F376EDCC09F4CD9
      A73EFF7F576DBCBBF805FCFC427377F1D4CD94771733313131B93C1D6E1DD9F2
      EE0DB781A84AB02D9E3A716BFBC46ACDA21888BA02448278105529B6C5F15B4D
      21F1EC988B403C88AA04DBE2E9F76F7786C593432E02F120AA126C8B8A33D5F5
      8BE28BDD2E02F120AA126C8BE73EAC45D9FFA1DB45201E4455826DF1C2F93A94
      FDEFBB5D04E2415425D816BFBE585FB728EEEF761188075195605B6CFDA8A16E
      417CBECB45201E4455826DF19BCB8DED61F1D8A08B403C88AA04DB62DBD5E6A1
      9878DDEB22100FA22AC1B6D87EBD756C49BC1D701188075195605BBC7CA36D62
      491C9B711188075195605BECA86A9F5A16A7E65C04E2415425D816AFDEEEF42D
      8B0BF32E02F120AA126C8B9D77BBFC2BE2EAA28B403C88AA04DBE2B5EAEEC08A
      A80ABB08C483A84AB02D76D7F78DAF8896988B403C88AA04DBE2EDB6C1FEC548
      6C6DCD25F12012C483A84AB02D4666E78FB60FED691A700F8807510926262626
      21E6061A862FEF731B88AA04DBA2E66045CC3FEC36105509B6C59D7DCFC4A687
      429E7AF78078105509B645E56B4F46BC9EF9BE6AF78078105509B645D5EE2D61
      EF40B0F7AE7B403C88AA14C7A8BD4F8727FBE7BA6FBB07C483A84AB02D6A0F3D
      1B9AE89BEDAC720F88075195605B341EFE5568BC77A6E3A67B403C88AA04DBA2
      F5D8B6C5F19E40FB0DF78078105509B645E7C99716C6BAFD6DD7DD03E2415425
      D8163D67762E8C75F95BAFB907C483A84AB02D06CEEF0EFB4782834DEE01F120
      AA126C8BBE0B6FC47C9ED0408D7B403C88AA14C7A80F5F8FFA3C8B0335EE01F1
      20AA52D4EED33B51F685FE1AF78078105509B645FBC91D119F67BEBFC63D201E
      44558AD71727B6877D9E607FB57B403C88AA04DBA2F9BD6D28FB5C7FB57B403C
      88AA04DBA2E1C8D690D7B338D1E31E100FA22AC1B698F334B9F13B564F936062
      626212627566D49DB02DD8166C0BB605DB826DC1B6605BB02DD8166C0BB605DB
      826DC1B6605BB02DD8166C0BB605DB826DC1B6605BB02DD8166C0BB605DB826D
      C1C4C4C4C4C46431B9767FC3926D0BEB4FB62982DD2D5DD216D65723DF2EE4E4
      AAB6589CE8995BBF15653E7EA3D6E2FA9D8CC1C126E556DFB6EB81F61BF2B904
      B39D5573DDB783BD77E5636D94A70CB15F14B55E50A1989898985C95DCB91F6B
      69EE00EBB6FD584B79075817EEC75AB23BC0BA703FD692DD01F6171FDC690D89
      EF7A4A1AD400EA21EF6DF1CB53771B17C5D77A4B1AD400EA21EF6DE1C27D8A4B
      76676417EE535CB23B23BB709FE292DD19D985FB1497ECCEC82EDCA7B8647746
      76E13EC525BB33B20BF7292ED99D915DB84F71C9EE8CECC27D8A4B76676417EE
      535CB23B23BB709FE292DD19D985FB1497ECCEC82EDCA7B864774676E13EC525
      BB33B2DBF629763EB967676417EE53CC9D9199F29EB892D63D6B38D9166C0BB6
      05DB826DC1B6605BB02DD8166C0BB605DB826DC1B6605BB02DD8166C0BB605DB
      826DC1B6605BB02DD8166C0BB605DB826DC1B6605BB02D989898EC4A9FFAFCFE
      C7FFD73225FD117E3E819FFFE75F9595BDF9B1B2B28F95FD5EFCFD8771BCEA7F
      2F8BFFACA7A5D949420821841042082184104208218410420821841042082184
      1042082184104208218410420821841042082184104208218410420821841042
      08218410420821841042082184104208218410428A9EE1CBFB5C82FBA3727360
      127FEB35EB9617465A37A3D4E1E9C1CDB046082968013A3530F578503CBC287E
      BC289E0989DF84C5CE88D81F11EF46C5D998B8B6246A9645FB8AF0AC0AEF9A98
      5F135121D64486840CC886CC38657055391D46600A06DF8B2AC6E1028EE00E4E
      E11A019C189E51C755BCF87F9B844BD08EF6EEAC2E9D06857D9E987FD80A7D17
      DED0997DFA7C63DF9AF00B4BA86661AD6551BCDF38F170ADC8999E0F5F67FF25
      A40834E8910571D02F0EC5792B20DE0E887702E270401C0988A36046BC3B23DE
      9B11C7E21C9F112766C5FBB3E2E4ACF860569C8A737A4E9C99537ECB7F7E103F
      8A3CC8797CFDC4F7E27660ED68DCF2E1B817F88247E9FA9145A1D5A0EF5C8F1E
      9F59CD3B0843A7412EACAE640D5AE8AFC999D8F450F2F02E3568BF3F77AA23F7
      54831A44085107D5EF2E8ABDD3625F9C031857D373283D070D39608874FDDD8D
      1AF41F9AC4BB81D5BCF31F92AE835C585DC91A34DF579D33D4204288931AF458
      48ECF68937E2EC9916FB73629F217B0C91AE118656837EBF71ED887F35EF200C
      9D06B9B0BA1CD0A067A041C2360D82B59690550DEA3CBD93FD979022D0A02742
      E2775EF19A57BCEE13BB7C46A3DF9BBEB4BC61C8EEF4C023FCC2FB131B35E83F
      35AEBD33BD9A77FE539206B9B0BA923528D87B3767A2BEC1E4E15D6AD0EF7CB9
      73337C4F35A84184107550DD12123BA6C42B53E255AFD8E95546B974BCEE4DCB
      6B86FC2E3DF008BFF0BE65A306FD41E3DA5BDED5BCF307491AE4C2EA4AD6A0B9
      EEDB3913F579DA4FEE48D6A07E5B35A835AE41FFFD8EC899E420092185A841CF
      84C56F27C5F649F1D29478794A19E5D2F16A7A5E993262477AE0117EE11D6168
      35E83F37AE1D985ACD3BFF3949835C585D8E69D0BF4CE5CEE5D03DD5A0061142
      D441F5B9B0F8CD84F89709B16D52BC38A98C7239F0D2A411BF4D0F3CC22FBC3F
      B75183FEA86175DF44FE41183A0D726175D9AB4111AFA7F5C4769DD95F9C6F1C
      10E217E3B9736E41A86661ADCDB2062507490829440DDA1A162F8C895F8D895F
      8F8BADE3E2B7136979313DDBC68DF84D7AE0117EE17DEB460DFAE386D537C7F3
      CF1F2769900BAB2B5983663BAB7226EC1D687E6F9BFB352839484248216AD06F
      23A262543C3B2A9E1B534657E301301DBF36E45763698147F8857784A1D5A03F
      6958DD3D9A7FFE2449835C585D8E69D093A3B97372FE9E6A50830821EAA0FA6A
      443C3D229E1911BF185546D717C6D2F27C7A9E33E4D9D1B4C023FCC2FBAB1B35
      E8FFAB5F7D6D24FF200C9D06B9B0BA6CD6A0C9FE86235B9335C863AB06B5C735
      E89F6E8A9C490E921052881AB42B2AB60C8B9F0E8B9F8D889F8F28A35C3A7E99
      9E5F1882413B1DF008BFF08E30B41AF467F52BAF0EAFE61D84A1D32017569763
      1AF4C870EEBC1BBCA71AB66850DDDBCFB3FF1252041AB4372A7E3C249E1C12FF
      6358195D8D07C0743C65C84F87D3028FF00BEF7B376AD09FD7ADEC18CC3F0843
      A7412EACAE640D9AE9B89933A189BEE4E1FD97E71B0785F8A62777DE9ABDA71A
      B0D611A60611429441F550543C3E287E38247E34A48CAEC603603A7E62C89343
      69F971DC2FBC1FDAA8417F51B7B2DD937FFE2249835C585DC91A1468BF9133D4
      204288931A7424261EF588EF0F8A1F0C2AA3EBFF184ACB8FD3F384213F1C4CCB
      E371BFF08E30B41A545EB7F2E240FE294FD220175697331A3464AB0675528308
      21F141F5784C7C77403CEC118F7894D1F547836931181B7F60C8639EB43C1AF7
      0BEFC7376AD05FD5AEFC4B7FFE41183A0D726175256B90BFED7ACE84C67B6B0E
      56A4D4A02FF7E7CEDE19A19AB545839283248414A2069D8E897FEE17DF1E10DF
      C1D03A6034007E3F3D8F1AF2BDF43C1CF70BEFA7376AD0A76A57B6F6E69F4F25
      69900BAB2B8506B55ECB99C5F19E3BFB9E71BF062507490829440D3ABF24BED9
      27BED52FFE3B86D6FE0C03603ABE6BC843E9F976DC2FBC230CAD067DBA76E585
      9EFCF3E9240D72617539A34183427CB627775EF3DF530D5BBE0FA20611521C1A
      7479497CBD57FC539FF8469F78B04FF9989D8E6FF7A7E59F0DF9567A1E8CFB85
      F7CB1B35E8BEDA95E7BAF2CF7D491AE4C2EAB2578316C6BA6FED79CA190D7AE0
      9AC899E420092185A84195CBE2BFF588077AC5D77AC53FF62A1FB3D3F1ADBEB4
      7CD3907F4ACF3FC6FDC23BC2D06AD0676A967FD9B9927710864E835C585D0E68
      90BC3FE82FBB72E7A5E97BAAA1DE1F440D22841A747B597CB95B1957BFDA23BE
      D6A37CD24EC7377BD3F24F867C3D3D5F8BFB85F7DB1B35E86F6B969F695FC93B
      7F9BA4412EACAE640D0A0E36E5CCC258D7CD5D3F49A9415B4673E7D4BC50CDAA
      1AF4F85D9133C94112420A5183EA96C597BAC557E223DB033D469FCFBFD19B96
      7F34E46BE97920EE17DEEB366AD0E76A967FD2BC92773E97A4412EAC2E7B3528
      EC1FA97CEDC994CF8BB35183E4F3E25EE91439931C2421A41035A879C515832A
      C2D06AD07FA95EFA71C34ADE41183A0D72617539A64157E673A777F99E6A5083
      0821EAA0DAE98E41B573A3067DA17AE9F1DA95BCF385240D72617515AE06BDD1
      2372861A4448716850DF8AF862B7F8727C64FB6A8FB2EC2A1DB97D85F1F5F877
      E8E9F86ADC2FBCF76DD4A0FBAB97BE7F7725EFDC9FA4412EACAE640D0A0DD4E4
      4CCCE7A9DABD456756EEA36A9706A9FBA8528308A1060DAD8A9301D1B0A8D018
      A7294E739C161052688DD3B64E7B9C8EB042E73AF29FF2909A539E288DB4AC9B
      952EA43BF8FD202010865683F0CFFAC53C4705B451B9B6BA92356871A026670C
      34A832943B03AB42356B8B062507490829440D7AA7AEF7A9738D3F5739DFF8F4
      469ED1F08B8DFC3215BA3CDAD37596E14BF58B30B41AE4C2A8DC1C988D1A14F5
      79EEEC7D3A5983FA84B81DCE1D88A66A16D65A2C6B507290841042F28BD4A085
      FE9A9C8106D51E7A961A44082124370D9AEFAFC999941A84ABB0BE355113CD9D
      112154B3B0D6B2685583928324841052E81A14F1791A0FFF2A59837A6DD5A0E6
      B8061DEA1339931C24218410376850B0BF3A670C34A8712977C6C53DD5A00611
      4224337DD5631FEE2814102D9B6CB33508A7B71EDB96AC413D6BA2753977A684
      50CDC25A535C83DEF5889C490E9210527060605F9D192D14102D9BCC010DEA3C
      F912358810420DA206E5A64173FDD5399352837E7EBEB17B4D745AC027846A16
      D61AE31A746A48E44C729084106A1035A83835E89CAD1A742EA14117BAE77286
      1A440835881A547C1A14F27A7ACEEC4CD6A02E5B35A8811A4408A10615A9062D
      4EF4E48C8106C544EE2C0BA19A5535E8C0E96B39931C2421841A440DCA2FC397
      F7596776A07E33CC2E4CF66D8635420835881A440821841A440821841A440D22
      8410420D228410420DA206114208A106114208A1065183082145C64C5FF5C597
      1FCF0B85F854676A102184D8C8B96D8F7EE962E0AFDF8EFCEDBB91BF7B2F6CC0
      678FDB00ECC011DCC1295C5383A841849052E6F4AF1FFAE2F9C09FEF8F7CEAED
      E85FBF1331E0D347C286444C10861D38823B38856B6A1035881052CAEC7DEC73
      FFF5AC3F2F1A04D7D4206A1021A49479E391CF7CE1B4FF4FDF8CFCF9FEE85F1C
      30E22F0FD900ECC011DC41F8E09A1A440D22849432BB1EBEEFB327FD7FB82BF2
      C77BA27FB23762C09FEE0B1B1231411876E008EE207C704D0DA20691C2E570D5
      C896D76EE4004E64ED11C9EBDFFD3434E8DFEF0CFFFEEB91FFB82B6CC01FBC61
      03B003477007A7704D0DA20615D92AD38F76FCD03CDAA5A1F93AD70A4FBD716B
      7BED6ACD841898350B32E3149C282D886C12FFC08AF33AE8BB9FBEFF547E3468
      1735881A5464AB4C5FFCFEAD59010E8C674066437EEDB97FBE3FDD97B0FAEF55
      915377AEA7EAF47260D40CC8A93DD79206EDBED5E415CFDECA0E9C8213A94164
      7D2EEED30F7C18C88F063D4C0DA20615156F3EFA997726C5A35DE2914C200F72
      22BFF6DC3F7D3362F24B58E4D49D1B991E9EEDAC3203726ACFB5C2D37B6E77FA
      C59357B303A7E0446A1049FCF53EF2375FFF30F0C937C37FB92F52BEDF88BF3A
      6003B0034770878B2FB8A60651838AECDBD59DA3E2FE16F1854C200F726ABF12
      C56B7C3633F9C10F3975E7466726FC6D37CC809C767D15FB8B7D775A7DE2BB17
      B303A7E0446A105135E81F3F0C7CF568E4EBC7A25F3F6EC4D74E440CF8FA8968
      46946C30752C0A77B8F8A2065183A84105AD41CFBD555B3F29FEE1FDECC02938
      911A4424FB1EFBEC373E0C3C7E36FAA373D11F9E0D19F0835341031E3F3D9F11
      64831D38823B38856B6A1035A898D8FDBDFB768C88CF368BBFCB04F22027F26B
      CFFDE49B6193930FC8A93B77D13BE86DBE6206E4D49E6B8517DEA983A0FCFD89
      ECC02938D1408396E626A941A5C3A127BEF0E039FF960BD1A73E8AFDEC62D880
      2DE7170CF8E985C58C201BECC011DCC1295C5383A841C5C49E473FF3F2882231
      7F9B09E441CE3D9AEF65F05A998E4835F9903C9F809CBA7323FEB1407BA51990
      738F4DDF07FDFA487DDDA4B8FF7876E0149C984E8320401FBCF49D9432C43FB0
      E25CE1BFE58BDF3EEF7FF66AEC856B4BCF5F8B1AF0DC95B001CF5F8D6444C976
      2D0A477007A7704D0DA2065183D4731F3F1B4D39F9903C9F809C6ED0A0AD471B
      EA26C4E78F65074EC1892935480A90245986F80756AC1AF4F085C08B37633B6E
      2DBF7C6BC98097AA6206189FAB5AC06F38823B38A50651838A8CB77E7C7F7370
      E5ECD4D2994C200F7222BFF6DC2D17A229271F92E713905377EEF2BC2FECA933
      03726ACFB5C26FDE6B6C9F168F5DCA0E9C82139335482B402965887F6059DDAA
      86EEEF4E74B7A71D7BFAABF9D220B8A60651838AEB13DD973A1656AFF8972F67
      02799013F9B5E7A25FA4EC74C96F22A7EE5C0CD78B9E3A3320A7F65C2B6C3BDE
      3C1414AF3765074EC189C91AA413200935A8F8462ADDB874F2D96F7CFFD2CC6B
      77636FD4ACECAE59366057B511C6E7AA16F01B8EE00E4EE19A2D4B0DA20615AE
      066D3FD93AB620DEEECC0E9C8213B92E8E1AA46AD00F2ECFECAD5B3AD8B072C0
      90FD861C3081CC06477007A7D4206A509171EC99077A43AB55B32B66404EE4D7
      9E8BCF66293FF825BF899CBA736333630B9E3A3320A7F65C2BBC7CAA6D62511C
      EBCE0E9C8213A941D420C9995F7FFB4757660E352D1D6E5939DCB26CC03BCD4B
      06189FAB5A88BF58813B38856BB62C35A898F8E0B96F0E46D66AE757CD809CC8
      AF3D179FCD527EF04B7E133975E746FC23C1815A3320A7F65C2BEC38D33E1512
      A7FAB303A7E0446A10354872F1C5EFFDE023DFBEFAF05B8DD1438D11030ED487
      0C38D810CE08B2C10E1CC11D9CC2355B961A54641A34125B6B0E990239753A82
      7E91B2D325F723E4748306BD76A13B10115593D98153702235881A24B9B2E307
      8FBDDBF4C207ED5BCF746E3DDD61C4A976238CCF552DE0F7994EB88353B866CB
      52838C890C36189355E6E453ECE5EA2B8F8F2FAD818E48066436E4D79EAB74C3
      949D2EE94DE4D49DDB7BFDDDE068871990537BAEA57B722FF78D87444B203B70
      0A4EA4065183D4257CD777FE282FD8F50079B62C35C8251A14EF4D4F9847B7FF
      425ECECDBA0B8C8DA9AFDFBE35D81F88C456D7CCEB0832E3149C480DA2069152
      D3A048D7F5E1CBFBCC83FC164FB478AE72BAA7D698AC32279F42726660606064
      7AFEE89DA13DD706B202A7E0446A103588949A066184CF6A9719E4574FCC6A5B
      1CF544796E56DBE268CF5564A5BF1A84FB6E03F5292EF29FF25072E68CF0CFD8
      3D5083A841A4A43428AB5D66B41A94D5B6383A0DCA6A5B1C9D0649B909F7DCD4
      3DC505EF248429397326F8674C0DE248450D62CBE64583B27AC2BF5683B2DA92
      40A741596D49A0D72068CD4601DA20433894943923FC33A60671A472D59A848B
      2F3F9E17B826811A945983BA2B41CAA7B8C843C99933C2018A5083DC332E9DDB
      F6A8A7EA747D4C388CB2A9FDB647D9B20E6B5056BBCC683528AB6D71741A94D5
      B6382935C8A4A0DC7BBFF32AB8F7FD51FC9F0E68D0CAEC0871988268298E5406
      E3D2E95F3F64F2EB661B911EE19A1AE4F4F741D93CE15FAB41596D49A0D3A0AC
      B6C5D16B90948FF4A4CEDC7159FFFD51C7E594A7D848747A80384F41B414472A
      837169EF639F33F975B38DC86FAEE19A1A540A1A94D5B6387A0D827618923273
      EAEF8F529D62EFCD410E3F005F8E6FA5E6D7FAF0EE7CE41CA90CC6A5371EF9CC
      FE71F1AD0EF1A083C01D9CC23535C8610DCA6A9719AD0665B52D8E4E83B2DA16
      47A741A1B68B000A924CE250526690F2FB23F5E8E6FD6D080793FAA7583A7E0B
      B7A53852198C4BBB1EBE6FF798F86F6DE22B0E0277700AD7D420873528AB27FC
      6B3528AB2D09741A94D596047A0D6A3D0F526B4AFC5072E68C5083A841F98ADC
      B1B57F05A441AF7FF7D326973CD9885C3D05D7D4206A90B10645BAAE4B7402A4
      BE9F32B331D4209966FAAA3FDAF143F3203F35C85E0DDABCFDCA0BE93A287F1A
      B48B1AE4B80665B5CB8C5683B2DA1647A741596D8B934E83B43284D7B89CA106
      59D482732F7E3FABE766203F3528F3854C92ACA4D32075DD66A96BD0C39F36B9
      ECD646E40A5EB8A60639BE26218B27FC6B3528AB6D71741A94D5B6383A0D8A0E
      D62B0C35002943F82DFF290FA5C89C096A904C6F3EFA99AC9E9B81FCD4A08C02
      942C2B293548B76EB39435E8CD47FEC6E492271B91ABA7E09A1A54281A94D5B6
      383A0DCA6A5B1CBD06C5E52636DC248100A9AFE5A1E4CC19A106C9B4EBE1FBB2
      BA6719F9A9411905285956923528E5BA4D6A1035A8143428AB5D66B41A94D5B6
      383A0DCA6A5B1C9D06A98A938EAC32279F420DA206D92E403A5949D6A0946B6C
      4A5683F63DF6D9DAD995F7C697DE7510B88353B82E380D72F8CE027B6F4C28C4
      BD1B62232DC6649539F99452D6A0DDDFBB2FABE76620BF031A94FC7D4A416890
      81AC705D9CB1061D7AE20B266FFDB0117917095CF3B14EC498D868AB3159654E
      3EA5943568CFA39FC9EA9EE53D9BFF7D50CAEF53B836BBB835E8F0962F9A5C76
      6B2372052F5C738C25D4206A90F1F729D4206A10358890E2D3A0B77E7C7F56CF
      CD40FECDD32083EF53A841C5AD41C79EFEAAF95B3F6C044EE19A0317A106E54B
      830E6FF95256F72C23FFE66990C1F729D4A0E2D6A093CF7EC3FCAD1F3602A770
      CD818B5083A841A5F69C04AE8BA30611420D3AF6CC03593D3703F9DDA341A24C
      18E0F27571BC3F481BEA995F7FDBFCED873602A7705D70E34C64B0C155302493
      215183520C9BCF7D33AB7B96919F1A64CBFD417C4E8236D48B2F7ECFE4ED8736
      223DC275216A90A7EAB4084DB96AC06748D4A052D6A0D8BC2FEF1A94D573120C
      16A297A0065DD9F183DEEBEF4E2D0B878153B82E3C0DF2D42646574FADCD647F
      2F27CEDADC9072C29D21294B40AB46B6BC76C35E60B37035E8EA2B8F67F5DC0C
      E477A10641804E3FF3159D0CB9FF7971E96EC82D410D9AE9ABBEBEF34779212F
      DB0B5AD5A0FEEAC4E8DA5F6D2F9095AC1E62ACC8507FF5A686941BEE0C093CF5
      C6ADEDB5AB35136260D6066007D660B3A0F76EB8BEF309F3B86AEF06AD0049B4
      325410CFCDE6BA389203E1BEDB7274C50B7B5134259B8718233FCEDAD4900C50
      3FEFA53894A7908CA2951AB4FB5693573C7BCB36600D36B9875D1E3548152089
      1B34886BB3A9419BAB413D3713A36BCF4D7B81A664F5004945837A6E6E6A48E9
      D0CD7BEB8FE623A40C01C7DBEEB9B76AEB27C53FBC6F1BB0069BD420AE49706C
      5539358884BB2B13A36B77A5BDE4A241DD959B1A524A52AEFFD990C1F19032C7
      1C6FBB17DEA9836AFCFD09DB8035D8CCD7F36CE12ED05B0B4AC7AF5D1A94DFC8
      A941D420D76A50560F31CE9706A5BC0FA22034E8D747EAEB26C5FDC76D03D660
      53FDDB08F4D4904DC5AE5E5CB89117EB9A84ACF694B711EDC703BCEEBF71222F
      64F52925DC793531BA765EB597F80673593C4052D1A0CEAB9B1A526EE431A47B
      DF52258504B61E6DA89B109F3F661BB0069BEADFC69CA7856C2A768DCF851B79
      516A50567BCADB88DC9E5E0DA3EFFAB1999EBA959951878153B8CE42833A2E27
      46D78ECBF6928B06755CDED49072235F21E9BFA5DA1812F8CD7B8DEDD3E2B14B
      B6016BB0C9C901C2DD362D3D2761EB7796A68722C3CD0E03A78AEBF5307AAE1E
      5D098C2C4DF53A0C9CC2B5F9960DB55D94A32B5ED80B3425AB8718233FCEDAD4
      9072232F21A5FC964A1B12D876BC7928285E6FB20D58834D0E77841A644583F6
      FEE0BF447CC3735DB71D064EE15A0DA3E9F49E25FF4864B4C361E054716D5E83
      5ACF2746D7D6F3F6A2EC619DCD0324150D6A3DBFA921A504AE93D990C1F19040
      CA6FA9B42181ED275BC716C4DB9DB6016BB0C9E18E5083AC68D09B8F7EC6FC6D
      293602A770AD86D1F8C1EEA5C04878B4DD61E054716DFE1ED5AEEB89BB2FBBAE
      DB4B0E1A24B7BDDEBC90529272B4D766703EA48CC8B67BF954DBC4A238D66D1B
      B0069BC53D946D586C363799D5F2B3CD88212F015083365583767FEF6FC2BEE1
      40C74D878153B856C36838B91B9724A19136878153C5B53B3428AB8718E74B83
      92652879C077A706ED38D33E1512A7FA6D03D660B38044C4F3FEB3E906F393CF
      3E90726CD70A50E2293479D220ED826AE5890DD4A062D1A05D0FDF67FEB6141B
      8153B856C3A83FB96B79662C34DCE630700AD7E65B363A582F4757BCB097F89A
      842C1E20A9DC4F3458BFA921A5432B4378AD3B9A97908C916DF7DA85EE404454
      4DDA06ACC166A16810042834DE9D5286204038A49521DDE9FAA771E643833070
      057B6F4A949B4CA941D4A0D2D4A0A1C413A1F1C25E72D1A0A1864D0DC9002943
      8A00251DCA574806242EF92FF78D87444BC036600D360B4283203DB1A0174293
      2C43901E1C12426865487B7AEA5D090A53837C5E9FF57860C46D760A7C2EEE3E
      F3B746DA089CC2B5662E6E57CC3FBC30D4EC3070DA908D06C5869BE4E88A17F6
      024DC9EA21C6CADCDD70D3A686640C0428E5FB790C291DB2EDDEBE35D81F88C4
      56D76C79000BECC01A6CBA5F83A400A91AA495215580A406A932A43D3DF5EE6C
      85A6416DE70E143785AB417B1EFD8CF9DB526C044EF7E8D7248C86465A1D064E
      B35A93101B69498CAE232DF692C3DE0D386B5343CA0D77860446A6E78FDE19DA
      736DC02E600D365DAE418A00CD4D253468425199C5B18ED9CE2ABCAFC88D8809
      B12A1F962916C6C4FCA88806F0BE2D8FC4719B06E1C3DB7C5FB5456067FBC46A
      CDA21888E60E4E8711A91D169FE52E9FDF9EAC410E3F8FC8CAC38BA841D969D0
      686B62741D6D75030CC96448254B4A0DF2B7DDA006E5AC414D21F1EC98556044
      6A90F567B9C342B2061510FB7EF0B9E5A02F3C50E330700AD79AFB83DE5C999D
      589AE872183885EBAC34C85530246A50660D0A7A9716674068A20702B430DC62
      5E83DCF395962D1A34D77DDB22B0D319164F0E590546A40675FAC593572D010B
      05AD416FFDF87EF3B7E7DB089CC2B51A46CBD9BD2B73D0A06E878153B8E62A1A
      420DA20699D4A0D690F8AEC72AADEBD741AD3EF1DD8B96808582D6A0C35BBE64
      FED6481B8153C5B5E62F6465763C36D1ED30705AD0CD47C8A66A90BAAC2E2329
      977C67C4CCCC9E8D1A64FDE67AD8A95F145FECB60A8C480DAA9F145F3C610958
      A00651830801B303F5EAA211BC2E0E0D42CE8CB75AC8450EFA9B5EA3818CA4BC
      29C9FD1AF40FDD56D16A90F5BD140B7A103BF6CC03E66FCFB71138856B358C8E
      8B87966746A313DD0E03A770CDC193D802A467BEAF4A2E75561EBE542C1A24CF
      4A078E02DD9D478A7158CB44CA9B92364F83663A6E5A446AD0DF775B45AB41D6
      F7522C680DFAE0B96F9ABF35D246E014AED530BA2FBDB314188D4C74390C9C2A
      AE397E12FB34283EB6179506C9D574E9506F3BD2DD79A418CC44CA9B92364F83
      FC6DD72D023B758BE2FE6EABD4AD6B90F57D15EBA841D42042341A24292A0D9A
      E8C6B9E9E996ABBEB5321437BE6402A13EA261539F1797D0A0D66B1651546341
      7CBECB2A3092D0A0091BF6522C680D3AFBEB6F877D4373FDB50E03A770AD86D1
      7BE588B277C37897C3C0A9E29AE327E15C5C7A0D522DA444DE7C24D9701D64F2
      891341AF99EB208B3728D9A841ED61F1D8A055DAD7D7665BDF5711160A5A832E
      FEF691456F3F3E57380C9CC2B51A46FFF5F762FEA1F078A7C3C0295C73F0249B
      3417A75DA5908C03EB169CD420FDF7418AE50CA802B4D977BC4A0D0A0E365904
      768662E275AF5560446A90F57D1561A1A035E8EA2B8F9B7F4C998DC0295CDFEB
      29374FF8BBEF46BCFD0E03A770CDC1936CD25C9CF6CA28F98503D74AD69F93A0
      B5901A1C9D9B4AB12E4E319E01F3EBE24CE280068D2D89B703568111A941D6F7
      551C5B286C0DC225C9F59D4FE405ED5383F07AF0E6FB7941F7F022426C9C8BD3
      5E1925BF704083D2DDDD63700B4FF2DE0D6EB83FC8160D5A1CA8B108EC4C2C89
      6333569958D720EBFB2A4E2C0ADE604208493917A7BD324AC625DF19B91CDD82
      0483276166D4A085FE1A8BC0CED4B23835671518911A647D5FC5A91035881092
      7A2E2EEFDF07158706691766A7432ED836D6A0F9FE1A8BC08E7F455C5DB40A8C
      480DF247C4D5514BC002358810E2CEE7245083367C1FD45F6D11D809AC88AAB0
      5502EB1A647D6FDF00358810424A4683C657444BCC2AE3EB1A647D6FDF71CEC5
      114248217C1F641DD8E95F8CC4D62CEDC68BD361446A90C5BD7DE57EBED42042
      08D93C0DB2655D5C49EDE54D4A61C2DF0AF2CB02375B23A498348890E2A0E7CC
      4EEB8FFB00B023ADDD9A5BFDC3066111D5DA81D3D71EBA2A2C22AD11420871A1
      0685BC9EB9FE6A2BE834E8B11E4B38AF410B23ADB65C7065059C4AEFE1E941E7
      BDC3697E5DE7ABE6E1D18C53D93ACED70F3C9A71AAD6A1CB2364CFCA57CF2A14
      FC7E7FE7C997C23E1B3408766010BF6DD120D59A2D1A24AD19D077E18D987FD8
      61E054F53E12110E23BDF77CF8FA372A85C3C0691E6B1E1ECD3895F5E37CD3C8
      F04C365F5E5A101ECD3895ADCC9E95AF9E55405083E41F4C6C7AC8FA2DE7E681
      3BF50F062FAE05C4EF469C03EEA4F7BCF714876B5E567B46A76AEB38DC34B25D
      323A559BCFFD1AC49E450D32A941166F31280E0D9AEFAB760CF694BCD4BC5683
      CCB40E35C8160D62CFA20619D07A6C9B2D1A043BD29A2D1AA45AB34583A4356A
      50724FE93CBDD3F99E02A7D420BB34C8F9168447334E652BB367E5AB6715108D
      877F15F1792C3E720A1A043BD29A2D1AA45AB34583A435A38BC1D33BA3BEC160
      EF5DC7803BF50F062F2EFAC5B621E7803BE93DEF3DC5E19A97D59ED1A9DA3A0E
      378D6C978C4ED5E673BF06B1675183A8416634A8FDE48EA8CF33D77DDB31E00E
      4EF3DE5310C357AF0887510BEE7CCDCB6ACFE8546D1DF76B90F32D282BD0642B
      B367E5AB675183A841E67B0A5E9C9E16BFF43807DCA9430435C8A0751C6E1AD9
      2E199DAACD470D62CF2A1A0DB2FE7D50416B50EB89ED11AFA33D05EEE054F57E
      DC2B9EEC730EB893DEF1DBF99EA216DCF99A97D59ED1A9DA3A0E378D6C978C4E
      D5E6CB4B0BCA084DB6327B56BE7A1635A8B034A8F9BD6D61EFC06C679563C01D
      9CE6BDA72006E77B8A5A70E76B5E567B46A76AEBB85F839C6F415981265B993D
      2B5F3D8B1A440D32DF53F0E29D29F1488F73C09D3A4450830C5AC7E1A691ED92
      D1A9DA7CD420F62C6A50716850C391ADE1C97E477BCA643F9CE6BDA720862F5E
      140EA316DCF99A97D59ED1A9DA3AEED720E75B5056A0C95666CFCA57CFE2FD41
      85757F507E7B0A5EEC9F140F763907DC49EF756F3FEF7C4F81D342D120879B46
      B64B46A76AF3E5A505E1D18C53D9CAEC59F9EA59D4A0C2D220B45D68A26FA6E3
      A663C09DFA078317BBC7C597DB9D03EEA4F7BCF714876B5E567B46A76AEB38DC
      34B25D323A559BCFFD1AC49E450DA20699D7A040FB0DC7604FC94BCD6B35C84C
      EB50836CD120F62C6A109F17470DA2065183A841D4206A903B35A8E6604568BC
      D7DF76DD31E00E4E55EFAF8E89CFB53A07DC49EFF8ED7C4F510BEE7CCDCB6ACF
      E8546D1D879B46B64B46A76AF3E5A5056584265B993D2B5F3D8B1A54581A7467
      DF338BE33DB6EC276B12B883D3BCF714C4E07C4F510BEE7CCDCB6A4F761A9BF7
      A56C1D976810C24BA741CEB7A0AC40DD9B8830652B3BD0BEE9DACE99E64BD734
      0EB44BBA3AE7FE41D4A06C35082F5E1C11E54DCE0177EA10410D425F3EFDCC57
      B44399DA3A0E378D6C179D5335BCE4E6738906A9113AAF41066DE740F31934CD
      66B78B419D53830A51836EED796A61ACDB490D823B38CDBB062186FB3F140EA3
      16DCF99A97D5AE752AFBB2441DCAD4D6C9BB06E9C24BD620E75B5056A0FA4F5D
      84BA56DED4F6356EBBCD6E3EE3A6D9D47631AEF382A3E7CCCE90D7060D821DD5
      9A750D52ADD9A241D29A6B35082F5E181628B563C09D3A4494B806A97D59A26B
      1D879B46B68BD6A92E3C5DF3B9418374113AA941C66DB7D9CD67DC349BDA2EC6
      755EA01AB438D1630558D06A102E85AC70646A4DAB41D6C9A8413777FD6461AC
      2B38D8E4187007A7AA7714D9A2706705DC49EFF86D5DE2B3452DB8F3352FAB3D
      A353B5751C6E1AD92E199DAACD97971694119A6C65F6AC7CF5AC026276A07EF8
      F23EEBC08ECBAD1950F9DA9361FF88933D05EEE034EF3D05316CAD5F7518B5E0
      CED7BCACF68C4ED5D671BF0639DF82B2024DB6327B56BE7A56013171F3ADE173
      2F79DE7F3623C886CC8B631D8E916D6C3957427E7B0A5E340757CF4C2D3B06DC
      A9430435C8A0751C6E1AD92E199DAACD470D62CF2A020D1A39FFF2C270737466
      2C36E75D9A9F4ECD42607921109AE841E6F9813AC7C836366A500E3DE5E5A655
      87A106D9AB41CE379F19A7D4A0FCF6AC02021711E1A9FE794F7D68A23BEC1D08
      7B3DC944A687A381518CF6C83CDB79C331B28D2DE74AA8DABD25E6F384066A1C
      03EEE0943DC5E19A97D59ED1A9DA3AD4208B1AC49E450DB25D83FC4DE71DC361
      0D5A1CA8710C6D4FC18BB685D5F3D3CB8E0177D23B7E3BDF53D4823B5FF35A0D
      32D33A0E378D6C978C4ED5E6CB4B0BCA084DB6327B56BE7A566169D0E278D75C
      5FF5FC50B3EEEB9893CF3E205F84267AA0054B411F324F379C718CE4D8D49054
      B4B1E55C0977F63E1D75B6A7C01D9CAADE3B17562FFB571C03EEA477FC76BEA7
      A80577BEE665B56774AAB68EC34D23DB25A353B5F9F2D282324293ADCC9E95AF
      9E55601A34D6A18CF3838D0BC32D2A0DBBBF87015FBE96437D7E3468636C0809
      8169E3D4C6967325D41E7A167FBA0BFD358E017770CA9EE270CDCB6ACFE8546D
      1D6A90450D62CFA20699D1A0D078F7BCA76161A46D71AC53D2FFDECFA506C97F
      2AD71ADE81A5F969E7E7E274B1490D42786AA8DAD82C6AD07C7F8D63687B0A5E
      748756AFCFAC3806DC49EFF8ED7C4F510BEE7CCD6B35C84CEB38DC34B25D323A
      559B2F2F2D282334D9CAEC59F9EA5905A641133DF1C92E653C07C3E7B6AB1A24
      DF094FF5477C834BF37E45831A3F748CE4D8540D4290C9B159DCD0DCC99E0277
      EA0EE379EC29886157CBAAC368B75677B8E665B56774AAB68EFB35C8F9169415
      68B295D9B3F2D5B30A4B83627353D1997165FD73D0377E7D9F5683961767F126
      46F8E585C06A34149F8B3BEB18BAD880568310AA2E368B1A64F1E1E159A1ED29
      78D1175EB3F87089AC803B7588708306395CED199DAAADE370D3C876C9E8546D
      BE42D120F62C6A50260DF2C6662694F17C2100B41A24DFC1200F3192E3BCC3D7
      41BAD8B41A941C5B7E3793CD0AB8537777C50B4F78AD3AB8EA1870A7EE54BBBF
      7DC561B4DBDA3A5CF3B2DA333A555BC7E1A691ED92D1A9DA7C79694119A1C956
      66CFCA57CF2A3C0D9A9B522E28166725DAEB2085D0DC4A28B81A0B3BFF7D902E
      365583D450B5B1E57713A56C7B8AFA34EF52EE290ED7BCACF68C4ED5D6A10659
      D420F62C6A90590DC2EBF56B0DC986EBA0C519759C77785D9C2E36A941DA38B5
      B1E577038BACD0F614BC188AAED52FAE3A06DCA9BB631CE95C7118ED561A0ED7
      BC5683CCB48EC34D23DB25A353B5F9F2D282324293ADCC9E95AF9E5590DF07CD
      4EE285160CF8EBAFBD9AEF831CD6A00DB169429A4A8E8D1A94434F79BF71C261
      A841F66A90F3CD67C6293528BF3DAB383428E538EFF85C5C16B1E57713A5AC50
      77BB28F19EE270CDCB6ACFE8546D1D6A90450D62CFA206D9AE410E3F2FCE490D
      B2B889526E3B2E49EFC195B55907813B7B7768CA793B27876B5EAB4126F7C30A
      3ADE2E199DAACD97971694119A6C65F6AC7CF5AC02A2EFE84F43937D72E5B311
      F3D311FFF0E8A5D79C7C6E76B6B1E57D13A5DC76355A98EC73DE3B9CE6D775BE
      6A1E1ECD3895ADE37CFDC0A319A76A1DBA3C42F6AC7CF5AC02A275EFF77B0E3D
      EE39F9424686CFBDE4AD79DFC9FD83B28DAD10EB9FB887150B89B54708218410
      42082184104208218410420821C9C4861A425D95E3E75E193DB37DF4EC76E577
      7E89C78078101562630395141337DF1A3EF792E7FD6733826CC89C6D7ED63021
      6E23D8573779FDD0C248C7E278AF96F9BE2ADD3B4E82781015626303951423E7
      5F5E186E8ECE8C294F4A9F9F4E4DFC41B5A1891E64CE363F6B9810B73176EED5
      F9910E284E3251FF681E4154888D0D6465D57DDFD19F9AB94600189FDD709980
      48C253FDF39EFAD04477D83B10F67A92894C0F4703A35016197956F9F9574188
      DB183DB33DA50069356875C67ECCC81062CB18BF5D37C1A9F7B5150D3D871E0F
      4DF6691F28B1CE94B2FDDF78B77213D67817C67080AB89E1732F51830821D4A0
      AC3408F2E16FBD661DD829B296F59C7C6129E88BCE8C4B12CF3B9A99C0EBF9A1
      E6794FC35C5F35C0000EA233636E18A211036451894AD93C77C30DCBF19DE595
      1772F35C144D6A902EBF9A4D459B9FFD9D106A90ED1A64FDA1880E6BD0E2448F
      F4EB800629D21347EE39ABBC33E75D1CEB5C18699B1F6CC4D08D2B088037DDA2
      41631D8AA60C362E0CB7A8C89D44E46B292BF73468637EB9BB87F65C6D7EF677
      629EF0F4A05D4FD18129636B384A0D2A5C0DB2FE70F8CDD020DDDF984E833054
      3AA441EB7371F1BD9666954D97823E8CC98A0CC5C7E7F814D6C0D2FCB44B3428
      34DE8D6B3448242294A83B2ACA7F2AD735EB0127E7577739544FD7E6E7B84ACC
      D377E18D6F540A5B8029636B384A0DA206D9AE41EAF54EB20639771D94A441E3
      D7F76DD420E54B131769D0444F7C624DD10EA0DD595EBE139EEA8FF806714D97
      D0A08DF9B5BBBD27E7E7B84AB2F846F5C3D7EDD2209832B686A3D4A082D6208B
      FBFF3AAF41F9BA0EC2C82C71AD062576EB98F32278C8A55683140D8DCF28AABB
      75E8F203AD06E1745D7E8EAB841A440DA206E5EB3A0823B316B76A90373633A1
      EEDEAED5A0C4EEED7131D568D086FC5A0D4ACECF719598A7F3F44EBB3408A68C
      ADE12835A8703528E2F3CCF7D758C10DD741E9E609EDD2208CCCC9B85483A098
      B878599C9568AF831442732BA1E06A2C7C4F8334F9550D524FD7E6E7B84ACCD3
      7E72C757AF085B8029636B384A0DA206E5F73A48AA52F26F5B3408A6D2E1460D
      92ABF8E25731920DD7418B337A0DD2E4971AA43D579B9FE32AC9E22EEF13DBED
      D2209832B686A3D4206A507EAF83D2ED4D6CFB9A04FC76F39A8474BBB7A3C692
      776F4FCEAFC966E76EEFA404697E6F9B5D1A0453C6D670941A54D01A5458DF07
      39798FAA89B5D985A141293525DBFC1C5789791A8E6CFDE245610B30656C0D47
      A941D4A022D5A0C4237A961767964373188D97E6FDE1A9FEB80C29376F46A687
      814B1E65430D22EEA1EEEDE7EDD2209832B686A3D4206A50116AD0FCF4B25C18
      B61058090581F21DFD4220E21B0C7B07E4BD33D1C02858768706F51DFD6968B2
      4FAEB236627E3AE21F1EBDF45AB6F939AE129768506CDE470D32AF41F9A27434
      C8FAC34052D83CF712065E7CFE4F100B2BC45F2B0FED999F4E8CCFF12FEEE377
      83E6FF99A5AD7BBFDF73E871A8674610ADB7E6FD6CF3735C25E6A93958619706
      C194D61A04E8F4335FD1CA108E52830A5783C245A1416AE61C48691F432E3EF9
      17D6DE0D84B8873BFB9EB14B83604AB5260548A2CA108E5283A84145A64185B8
      7F1021EEE1D69EA7EEFF50D8024CA9D6540192A819A841D4A0BC6B50CEA4B45F
      88FB071133CCF4558F7DB8C3FD20CE82AEE79BBB7EF2D055610B30656C0D47A9
      41D4A022FB3EA810F70F2266C0F01E2A8484380BBA9E2B5F7B726BFDAA2DC094
      B1351CA50651838A736D7641ED1F545817231FEDF861B6E02C0CCE399FABD520
      E148B252CC22D0A0979B566D416A9071066A1035A854EF511DE0F63A3970EEC5
      EFDF9A15E0C0B82964669C85C119BFFF7C7FE4AFDFD9C0A78F8435443612467E
      9CE5BC06C1A9A7EAF47260D43CC82F8B59E81A54B57B8B5D1A0453C6D670941A
      54D01A5458FB07F1390945C09B8F7EE69D49F1689778C41CC889FC380B83337E
      FFE99B91BF3810D5F297878C407E9CE5BC06C169647A78B6B3CA3CC82F8B59E8
      1A7467EFD37669104C195BC3516A1035A88835A8509E595A40ECFEDEDFEC1F17
      DFEA100F9A0339911F676170C6EF3FDC15F993BD1BF8D37D610D918D84911F67
      39AF41701AF60D073A6E9A07F965310B5D836A0F3D6B9706C194B1351CA50615
      AE0685BCD4A0CCD74105B1774301B1EBE1FB768E8AFB5BC417CC819CC88FB330
      38E3F7BFDF19FE8FBB36F0076F1881FC38CB790D82D3E8CC84BFED8679905F16
      B3D035A8F1F0AF76B5ACDA024C195BC3516A50416B909585CD00163649830CD6
      4E3B3F17E7FE3DECA841D420F7D07A6CDBFEF6155B8029636B385ABAEB3CCFBD
      3A3FD2E1420D4254882D63FCB303F5D6173603D8B15D838CD74EE7E5FB2097EF
      E55D507371F7ED18119F6D167F670EE4447E9C159F8BBBEF936F86CBF747B4FC
      D50123901F67E5632EEEBE45EFA0B7F98A79905F16B3D035A8F3E44B473A576C
      01A68CADE168C976A5605FDDE4F5430B231D8BE3BDEE01F1202AC4C6B1CEF635
      09E3D7F7714D8275F63CFA9997471471F95B732027F2EF897F598FDF5F3D1AF9
      FAF1A896AF9D88A87CFD44540BDE41FE3DF9589300A711FF58A0BDD23CC8BFA7
      28D6244017DE6F9CB005A941C6194AB62BC5861A425D95E3E75E193DB37DF4EC
      76E5777E89C78078101562E358C7757145A9418F9F8DFEF06C48CB0F4E05551E
      3F3DAF4579E76C941AE4303D67761E387DCD1660CAD81A8EB24F9122D5A042DA
      3FA88078EBC7F7370757CE4E2D9D310772223FCEC2E08CDF5B2E447F7631AC65
      CBF905959F5E58D4A2BC79218AB39CD720385D9EF7853D75E6417E59CC42D7A0
      85C93E5BE6F9014C195BC351F62952841A5468FB07151087B77CA96361F58A7F
      F9B2399013F971160667FC7EF166ECE55B4B5A5EAA8AA9241F427E9CE5BC0629
      4EE726173D75E6417E59CC42D7204288A5451105B87F1035881A44EC654DACB1
      12485EE0FE419BCAB1671EE80DAD56CDAE9807F971160667FC7EED6E6C77CDB2
      965DD5F7483E84FC38CB790D82D3D8CCD882A7CE3CC82F8B59F0737123ADB6CD
      C58DB41A5BC351780C4F0FDAE511A68CADE1287B312185CB07CF7D7330B2563B
      BF6A1EE4C759189CF17B6FDDD28186152DFB35241F427E9CE5BC06C169C43F12
      1CA8350FF2CB6216BA06F55D7823E61FB6059832B686A3D2E34844D882F4689C
      81BD989082D6A091D85A73280B905FD5A07DF5E1438D112D07EA432A071BC25A
      F00EF253839C5E17F7E1EBB1E9A185FE1A8BC0084C19589319A4C76B01F1BB11
      ABC088F498CE9ACCC05E4C48E172F595C7C797D64047C4143233CEC2E08CDF2F
      7CD0BEF574C7064EB5DF23E910F2E32CE735084E7BAFBF1B1CED300FF2CB6216
      8706CDF7555B44AB410619A8415785C8FBC3792459855D287B4A16C7CE9244FB
      87777DE713D9A2EE1F94DBB9CE6B90956216FC3DAAA777467D83C1DEBB168111
      9832B02633488F17FD62DB905560447A4C674D66704F551FBF71FE1B2D6BEED1
      20448278109599E0F1772E0A2771A510B10EF7517586F6933BA23ECF5CF76D8B
      C0084C19589319A4C7D3D3E2971EABC088F498CE9ACCE09EAA3E5B5FF560D332
      46FE5860CC0D2012C483A8A8418414EEB57FA15FF5B79ED81EF1DAA041300253
      06D66406E9F1B8573CD9671518911ED35993195CA541FFDC10759506211E6A10
      21248F34BFB72DEC1DC86AFFBE94C0084C19589319A4C777A6C4233D568111E9
      319D3599C1551AF4505D1823FFD2CCB81B402488871A440A8E8C7F00ACA202A2
      E1C8D6F064BF0D1A34D90F5306D66406E971FFA478B0CB2A30223DA6B32633B8
      4A831EAE5D709506211E6A10679C0A6EB589031A141969750FC5FD1758F7F6F3
      A189BE998E9B1681119832B02633488FBBC7C597DBAD0223D2633A6B3283AB34
      E891EA605C8326DC0022413CD4206A50A870926C59273468B8C93D94820605DA
      6F5844AB41EA9BB1799F2EC3666B103CBA59831EBB33E32A0D423CD420AEFE72
      6C05B2C5E4A8060D36B807B7C52343B28B9A8315A1F15E7FDB758BC0084C69AD
      410E4E3FF315FCD666901E5F1D139F6BB50A8C488FAA35D5A33683AB34E8F15B
      D3AED220C4430DA20651830A42833C55A74568AAF834E8CEBE6716C77BFCADD7
      2C022330A55A9372205164683D83F4F8E288286FB20A8C488FD29ACEA39AC155
      1AF4A3AAA9ABAEF9C21491201E6A1035C89D1AB4343769468390ED8397BEA3CB
      6C8306796ADD838C27A141AE09C92E6EED796A61ACDBBA06C1084CA9D6543990
      A819A4C71786C51F36580546A447694DE751CDE02A0D7AF2C6B8AB3408F15083
      A8412ED4A094CA92AC41329B449BD9060DEAAF760F329E8406B92624BBB8B9EB
      270B635DC1C1268BC0084C19589319A4C723536B8FF5AC5A0446A4C774D66406
      5769D04F2A95A7132CCF4DB901448278A841D420B769503A65D16990369B2EB3
      F56A09F7DD760F321EA941EE09C92E2A5F7B32EC1FB1AE4130025306D66406E9
      B139B87A666AD92230223DA6B32633B84A837E766DD0551A8478A841D4205769
      9081B2E83448974D629B06F5DC740F329E8406B926247B352834506311AD0619
      6428710DFAF995014583825E378048100F35881AE42A0D32501627D72484BB2B
      DD838C27A141AE09C92EAA766F89F93C8B03351681119832B02633488F6D0BAB
      E7A7972D0223D2633A6B3283AB34E817977A5DA54188871A440DE2BA386A501E
      35E8CEDEA7A33E8FF5FD836004A60CACC90CD263E7C2EA65FF8A4560447A4C67
      4D66709506557CD415D7209F1B402488871A440DA206A5D0A0CEABEE41C693D0
      20D7846417B5879E853ACCF7D758044660CAC09ACC203D768756AFCFAC580446
      A4C774D664065769D073173A5CA54188871A9491899B6F0D9F7BC9F3FEB31941
      3664CEED14271D5183326B50C765F720E34968906B42B28BC6C3BF8AF83CC1FE
      6A8BC0084C19589319A4C7BEF0DAADB9558BC088F498CE9ACCE02A0DFAD5B956
      8CFC2BF3D36E0091201E6A504646CEBF2CE606C5EA8210510C6F695851084D21
      B33C65ACF58677B0C337DC3B3DDA9F9A318F7FCC33D1552B4FC9EDAC1C622B1A
      0DDAD43509A1B68BEE41C62335C83D21D9B677C3B16D613B34084660CAC09ACC
      203D7AC26BD5C1558BC088F498CE9ACCE02A0DDA7AB649D1A005BF1B40248887
      1A94115C4488C8B408F489D0A488FA45349082A5397CB640DB22B33C65B2A761
      B4E9EA4457CD646FE3646F533253FDAD5E4F3B34459E92DB5939C456346B1236
      756D76A8F5BC7B90F12434C83521D945E7C997A00E73FDD51681119832B02633
      488F43D1B5FAC5558BC088F498CE9ACCE02A0DDA76A61E23FFEA62C00D2012C4
      430DA20615E8DAECCDBD47B5EBBA7B90F124EE51754D48D4A082D320F0DB53B5
      770231F78078CC7F735DD21AB438217C5D6276502C8C69B9BAE3E1C4EBD094A2
      0522A64AC37867F570FD47A32D37C63BEE6839F0C467E58B89AE5A28CEF4489F
      56837467A99955746725C7762F24958DB115CD3DAA9BFBAC1E6A90531AD47366
      67C8EB599CE8B1088CC094813599417A0CAEACCD5A0646A4C7A06106B72D437A
      F9E45D97081022C96AF554496B1046728CF33303626E48A5FFE84F95015FFE53
      0EF55A0DEAB8A3A849F3F5B1D69B2AD7FEE56B9015F95A0A8A5E83369E85CC38
      456B417756726C08098169E3D4C5564CCFEA49F76439EB8D1E1DAC770F321EA9
      41EE09C92E6607EA872FEFB3059832B686A3F0B830D96797479832B686A32E5C
      0D7BA46DC80D64BB82B7B4AF832645A05F0447C4C2B864FAE2B68406C97730C8
      47FD18FC546998E8AC196DBA36D6766BBCE3AEA4E1CDEF4B0D92FF54AE687A1B
      A747FBB51AA43B4B6A104E548DE8CE4A8E4D6A10C25343D5C55664CF2CDDA475
      71D1A106F720E34968906B4222C4E1BB484A5A83308C2B935DF1F13C3435776B
      EF3D0D8ABFA34C76C5668458BEA7415DB5F12935453540EB915FA81A24DF99EC
      6998EA6B9E1E1DD8A0411BCF523508A7A73C2B393655831064CAD8B836DB0CB1
      E126F720E3911AE49E9008A10639A74122225617E3EB9F638B8D2736689058C3
      9B18E1E34BA0852A0DBEE11EEF60A7B2CA7AA4AFF3D44B5A0DF28F0FE14DE888
      7FCC33E39DD06A90F62CA0D52018493E4B171BD06A10424D8E8D1A644A83465A
      DC838C27A141AE0989106A90831A1415ABA1F878AEDC6BB3518356D659DBA841
      BDBEC12E4535C63C40AB41F21D4809C4284983369CA5D5A0946725C7B6E13A28
      556C2935A8B0F6F27680D868AB7B90F12434C835216D366B628D03AFBD8C9ED9
      7EEECEED376F36B807C483A8A841A63408971BCA05C59A64E375D09AEA7A8306
      0DF728972DE34312ED7590C2C470606264C637A9D720CD59AA06A946746725C7
      76EFFBA0F55075B1E998E9AB4675150A88B66435C8552C8CB4DAF5B5BEFE4BFC
      91D6F0F4E0261987E54D35EE7E0DEAF62FBCD53A74A475F0DDD681E3ADFD27DB
      FA4EB7F57ED8D67BBEADE7A3B66E1D97DB3AB55C6BD753A9A3A34307F2E0C48F
      DABA601F5EE00B1EE117DE11C35B2D43DE193F35C8AC06AD85D56B0DC9C6EBA0
      D5141A34D4AD5ED148365C078D0FA6D620CD595283B416746725C7965817A789
      53171B31A54163EDEEC185F5D377E18D987F783380653012119B8134FE8D4AB1
      19C0B2FB35A8C73F7FB8C5F36E4BFFF1D6BE0F5A7BCFB4F69C6BEDBED8D6A548
      4C5B878E1BEDED5AAADADB74DCCA04F2E0449882FD8BAD5DF0058FF07BBCA50F
      312092E999696A5016DF0729437D444B5C83E4EB68EAEF8386BAF1420B6465FD
      756FDAEF83D6CFD264EE497956726C9A90222963236670D71241F7D54FCF87AF
      C7A687AC3FEC5A076CC232B81610BF1BB119D894C637498360D9FD1AD4EB9F7F
      AF65E0446BFFA9D6BEB3AD3D17DABA2FB5755D6BEBBCD1D671BBBD5DC7DD8E36
      2DD51DAD3A6A32813C77DB5B610AF6AFB775C2173CC22FBCBFDFDA8F4866A841
      D63428DD386FA041E9D424B7B372888D10BB3468BEAFDA5EA8419BAD41FDFEE0
      FBAD7DA7DB7ACEB5757FD4DE7515EAD30EF551F4A5AEA345477D47B39686241A
      33D1103FB1AEA319F66F77E062AA031EE1F77C5BCFE9D69EF7DBFAE6667DD420
      6A1021593F60E7F4CEA86F30D87BD75E601396C145BFD8366433B0298D6F9206
      C1B2FB35C8E39F3BDB86CB9FAE2BED5D95509F8EF69AF6D6FA8E9696CEE6CDA0
      B5B349D2DC09316A812F78845F78572E88DA7A1666BDD4A0CC53DF477F2AC23E
      B9F2D99025B13C377AE93579CA4477BD5C5F6DC468FFD440AB3C25B7B372888D
      10EBB49FDC11F579E6BA6FDB0B6CC232383D2D7EE9B119D894C6BF7A456C06B0
      EC7E0D1AF2CF5E68EDBC12FFAEE74E7B6B6D7B735347735B4743E76651AFD089
      DF0DF0D2D4D1048FF00BEF88E1626B5768768A1A94F9D9F27BBFDF73E871CFC9
      1732327CEE256FCDFBB99DE2A42342AC768A13DB235EFB35083661191CF78A27
      FB6C0636A5F14DD2205876BF068D0466AEB57554C5BFDCA96F6F6EE9688446F4
      76D6F56D0EFD5D09F01A5EE00B1EE117DE11032289C6A3A2061142B2A2F9BD6D
      61EFC06C6795BDC0262C8377A6C4233D36039BD2F82669102CBB5F83C682A15B
      4353B523534D63DEF6095FEFD4B467DA3FE4F70F6F12D381047EC50B7CC123FC
      C23B6240244B4B316A1021245B1A8E6C0D4FF6DBAF4193FDB00CF64F8A07BB6C
      0636A5F12F5E149B012CBB5F83BCC160E380A7CD33D03B343038DC3F36D23F39
      D63F35DEEF1DDB14A6C71378E35EE00B1E874614EF88019188F01C352823D9EE
      97BD38D6E118D6F7F2262407EADE7E3E34D137D371D35E601396C1EE71F1E576
      9B814D697C93340896DDAF41BE60B06DA0BF67B0DF33D8373ADC3735DA0BBCA3
      3DBED1DECD607A1D5FDC8B7407BFF08E18108908CF5283323272FEE585E1E6E8
      CC586CCEBB343F9D9A85C0F2422034D183CCF303758E916D6C1C3C898D1A1468
      BF6191D8BC4FFB4F7B3508C6374F8360BC1035C81F9CEBF2F40E0CF58E0CF74E
      8E744F8D747B4715A6C73605FF688F04AFA52378845F78470C88448467A84166
      D66687A7FAE73DF5A189EEB07720ECF52413991E8E064631DA23F36CE70DC7C8
      36360E9EC4166A0E5684C67BFD6DD7AD8061FCF4335FC16FF51DD88465F0EA98
      F85CAB2554E3EA3BB0298DDB2240D2B8F64D5876BF06CD04E7FA3D3D439EEE89
      A1AEA9912EEF70A74FA1CB3FB229044613E035BCC0173CC2EFC4502762402422
      14A006D9AE41FEA6F38E410D2279E1CEBE6716C77BFCADD772460EE3124586E2
      6FC2262C831747447953EEE88CCB3761531AB7458054E3EAFBB0EC7E0D9A0BCE
      0E7ABAC6873A27873AA6863ABCC31DD30A9DFEE18E64021B99196ED733B281B9
      513DC81358B7062FF0058FF00BEFE3431D88442CF27971A6346871BC6BAEAF7A
      7EA859F775CCC9671F902F42133DD082A5A00F99A71BCE3846726C6A482ADAD8
      3878A67C3EF3E651AC95766BCF530B63DD5634481DC625F24DD88465F0C2B0F8
      C386DCD119976FC2A6347EFF87C20A3AE3EAFBB0EC7E0D0A0667C6063AA606DB
      A706DBBC836DBEC1F6694F9B7FB03D30D496CCCCF00666875A8D090EEBC19B38
      515AF3C77DC123FCC2FB94A71D9188056A90390D1AEB50C6F9C1C685E1169586
      DDDFC3802F5FCBA13E3F1AB431368484C0B4716A63E393DC5CFB04B6C2E2E6AE
      9F2C8C7505079BEC053661191C995A7BAC67D55E60531A7FE8AAD80C60D9FD1A
      B410F44F7A5AA7065AA63C2D5E4FF3F4608BDFA3101804CD3A66363237A427A8
      A74907F2CC24AC251CC123FCC23B6240246281CFEA31A541A1F1EE794FC3C248
      DBE258A7A4FFBD9F4B0D92FF54AE35BC034BF3D3CECFC5E962931A84F0D450B5
      B15183643A5C35B2E5B51B8E017745A64195AF3D19F68FD8AE41B009CBA039B8
      7A666AD95E60531ADF5ABFBA19C0B2FB352814F44F799ABD034DBE387E4F73C0
      D32499196CD431EBD9C09CA741073EFA6EA44107F2E0449852BDC0A3748D1810
      0935C8AC064DF4C427BB94F11C0C9FDBAE6A907C273CD51FF10D2ECDFB150D6A
      FCD03192635335084126C7460D92E9A9376E6DAF5DAD991003B39B0B5CC011DC
      15A50685066AECC5190D7AB969753328100D9A9EEA6FF40E344C0F34023FE86F
      0C0C34CC28D4EBD0294E70A04EC7C260C346EA7520CF5CC25A03BCC0973FEE17
      20064422E6F9BC38531A149B9B8ACE8C2BEB9F83BEF1EBFBB41AB4BC388B3731
      C22F2F0456A3A1F85CDC59C7D0C506B41A845075B15183121AB4FB5693573C7B
      CB09E008EE8A4C83AA766F89F93C8B0335F6029BB00CDA1656CF4F2FDB0B6C4A
      E39BA441B0EC7E0D9AEAABF7F6D5F9FAEAFD7102FD7560A6AF76B61FD4E808F6
      D76A99EFAF31666140CF7CDC48DC5A2DBC4877D2B52F1EC99AE70E35E8FF6FEF
      DC83DB38F23BEFBDBABF7CE5ABABABBAAAFBE3EAEAFE4CD531290CDE70152FC9
      6E92CA6EE295E347720993D4511225324B890A493DBCF1D9F2DA596F7C916CC7
      EB5D7BFD5A59B664CB922CCB962C4BD69B96483D298A6FF0FD00DF14DF4F8073
      BFEE9E190C6606830106180CC01FFC150CF6F474377A7EE8CF744F77FF8C3168
      64793244DAF3D909909C412C041A7980116BE72DEE0729CA266790BA6CC820F6
      7AF69DEF9AC7F9EAF356083282ECF26D5EDCBBCF2E8D76A5DD7F10A40929839A
      6723E7C6C3E915A4C912CF10832065FB5FB8FE2FF78F066FCC8E748BEA9A1BE9
      9A17E6D076EA0BAE8E4A9D311A5169544A96E40279CD1209B94349A03C064B8E
      0C82EE06E950CC3D6092F78388E6A7C2F3D391E505EB9F0729CA2631482AAABC
      6CC820F67AEEBD6B0DA3FCD63356083282ECF28C41370EBC00CD4BC21BE36405
      6942CAA0D6F9C8C5C9707A0569B2C433C420483927AE1D34FB4C035FBE2AE8AB
      787A2D4D1213147394CA60BCD8C8A065F82CF6359862FA417393523B6FF1BC38
      45D91883E4E594970D19C45E7B7F5B7B6B887FF2A815828C20BB3C63D09D8FFF
      7971B46BBAA336BD82342165507061AD662A925E419A2CF15FDF8B644290324E
      98CC9CF0791079E6F260083EC8050DBEF87944F63CC86206C5944D56A46175D9
      9041ECF5B30F6F001A9E3866852023C82EDF7C371C796521030C8234216550D7
      C25AED7424BD823459E2EF378633214839077E3E2B354B63BD3611BFB2880C32
      C920CD76DEF2B1B824CA860C62AF973EBA096878FCA815828C20BB3C6350F3F1
      FDC08BA98EDAF40AD28494413D4B6BB7E622E915A4C9123FD41CCE8420656410
      32C80E0CB278BF3864500AAF9F1FBA757388DFF09915828C203B64907D1874EC
      4E2813B23F83FA4FEEA30CEAB3898041501E9C179750C1C37BE687826CE6B39E
      66C616C77BFBCFBE69E5BED9C9960D19C45E2F1FBE7D33C43F76C40A4146905D
      9E31A8EDE41B649A53A82DBD82342165D07478ED41BA0569B2C43FF8E2422604
      29E70683C6FB6DA2A4183419AC4DDF1C898C0B4A9BCEA1EF24FD655BE93F681D
      FAF24E0B837EF1E99DC6317EDB592B0419417679C6A0079DB77ACFBD970941CA
      B343C10C250E296734716450E6188442E513835EF9ACBE679AFFD55D2B041941
      7678E1503661D0F2C4804D840C42AD5B06ED3BDE3030CB1F6CB6429011648717
      0E850C4206A19041ECF5EA89FBA139FE48AB15828C203BBC70289B30686572D0
      264206A1D62D835E3BD9383CCF9FE8B04290116487172E2B4AE1413632081964
      3785AE1CE83DB5BFEBE85E1D41048896D1C8A83432E88DD32DE38BFCF97E2B04
      19417678E1B2B5B87EAAEDF274FB15835A1F0C0AD944C82083EA3DFDEA40C3E5
      B1FE4E1D410488C622F353DD3CBFAAA7A96E29F26C6FFDCACCB88E20028B8C4A
      2383DEFCBA756291BF3A64852023C80E2F1C32C82E0CB2D18259649021751EDD
      3BD4766BA8FDAE9EDA6E413416995F1CE59726F4B4382A455E180E2E089BD6C6
      D170904546A591416F9D0B0ECEF3F726AC106404D9E185430621839041A932E8
      F9C1A6EB838DDFE9A9E93A446391F9D9417EA65F4FB3835264E2EAB4BF514F03
      CD2C322A8D0C3A58D3DD31B1B81C59CBF47269C8023282ECF0C221836CC2A0D5
      A9619B0819840C5AB70CEA1B9B397CADE79D0B9D16083282EC70E93732081984
      0C4A4D5D47F70E365D1B68B8A22388D04547CCE09D9F1DE0A77AF4343B20459E
      1B689AEDBDA72388D0856371E966907D5AC8C8647FAE2817DB6764900683A647
      6C2264907106859AEB80323A82085106CD0D110CE9686E488A3C3FD8AABF1B0F
      44400621839041C820641032282F19942BC341D240103228EB0C7AFB4ED0B8D8
      29FFF0D647C6C54E99095E352E6450320C1AB58990414930A8A52ED472435732
      06CD0FF1F3C3BA923128D43A1F6AD3556619043FBAF95C78498D435A18F47143
      DFEE4F2E5B26C82ECF1864B09EE50C7AEACCC49F7EB2F8C34F17E4FAD16782E0
      331C8538C8A04C33283C33661321838C3368B4AF7DACBF43471021CA207E096E
      B475B524455E9E1E599919D31144B080413677C6917606FDF468CDBE50A46E8E
      EF5CCAAC200BC808B2CB3F06BDDE9B400A06FDC597E3DF3FB8F4838F1641F041
      FA2C09429E3C8D0C4206A1E23068B05B472A06457415CBA0B9491DE93368A4EE
      58FFD937BB8EBD60447DA75F0D5DF910194418F459CDDD79FE85012B04194176
      F9C7A057BA1348C1A01F1D1FF7BDB3E47F7711041F98D89F52E08FBF18470665
      9C41B3E33611322829068D877A75A46290FE2B8641ABF3533AD26750EFA9FDFC
      EA549C5C56699F6B992A4C343F0CF19141F07AF6D877CD0B7C758F15828C20BB
      FC63D08B9D315A991AFA7CFF1679889A418E5F2D72BF5E00C107103B8585B040
      88A3CF20760A32C80C83227313361132C8F8FA2023FDA0E8FA2003FD2029B291
      7E90CEFAA0AEE32F51D08445B1D71AF9BC3CC92F8D93C74F8B637C7886880FAB
      DD79AF4F063DF7F9B586797E6B9715828C20BBFC63D0B3C1A8181A40F2400583
      FEFAAB093983A4538C33483A05196482418B76133228F719B44C735C12F3E529
      8C56097A0040B303E47D658A081924BEF69EACBD35C73FD96A852023C82EFF18
      B4B34D9084069014085230E86FBF9A283AB254F41991FC14164274640938158F
      41F25390417983210490C1FDE2467BDB80327AEA6D8BEE17C72FCAA0A0A94529
      F2F2D43050464F53C33AFBC5890C5A1415163A4110480034C896C40AFBD4F12B
      C820F6FAD95737000D4FB45A21C808B2CB3F069D991624A101240582140CFAFB
      AF26FEF1D4D28E2FE741F2535808088EFE7D7C06C94F410699C2D097FB9906BE
      7C55D05792640B224EBDCE3478EADF049D96F4862831448C239D15BBB6424C5F
      CC512A03F2C588828776855A6F8DF605750411201A8BCC2F8C8A4F61E2686154
      8A3C3F145C9E1ED5114460919362D0DC9DA3C8209DD74BA76F021A1E6FB54290
      1164977F0CAA9B8B4AA2833C50C1A0CDA7C75FBAB0F2E28525107C904E61212C
      10E2E88CC5218350EB53F5EFFCA4ED4045D7F117750411205A46231B67D054CD
      BB4CC8A078AF9F9FB975738EDFD06A852023C82EFF18145C8C11A3833C44C1A0
      D2AF275EAB597DB56605041F40EC1416C202218EFE9C0464100A65AF397B2A06
      8D9D79452E6490E6EBE56F6EDF9CE51F6BB142901164977F0C1A5F510AE820FF
      53C1A0F2B3936FD785DFAA5B950B4E913EC3518893706E36320885B22D833A0E
      EF510B19A47EFDE2DC9DC6057E5BB715828C20BBFC6350249C400A06FDE3B793
      1FDF0B7F7C6F35BEC21007D707D96DAF456C66D7C9705FF0D0AECEA37B3B8F3E
      0FD274EACD0E419C5EB2D4F4809A41E75F2B8D276490E2F5CAF9FA9E65FE5723
      56083282EC70AF9E6D9FDC7DF964F3CB5F34C5D5C96688830CCA9C7ACFBD377E
      EF4C6479C1B89041EB446D072AC8B407D5EC3BB24F5D739DB863EA75D050DB2D
      E2375C5C6A8AF3E2527BEDBBD830B0C21F9CB042901164877B96E29EA5366150
      7861C6B824063D758107155D495AD8BCE7C890DA8B747E9DB00A693CD44B3EF4
      77845A6EB07DB9898B22EA2C6FA8FDEE587FA7B4738261068D132183C4D7AB97
      EF8756F8239356083282ECD07703FA6EC86906FDFE37CBA0EF5F4C5AD8BCAF0B
      06AD2D08223C5A1556AD0280A6FBF8C94EFE4137DDCA7B88EC11840CA2AFD7AE
      360EAFF227A6AC106404D9613F08FB413661D0CAEC8471490CFA9FE7E6531336
      EFEB824191394104438B7C649E7C06F44C74F0A32D441341A2C82C3288BDDEB8
      DE321EE6CFCF5921C808B2C3E741E8BBC1260C22EBE20D4B6250E0EA526AC2E6
      3DBF19D476A0822E8995C6E2A25B3190B138E64D6F2E44F6ED014D75E39EA5EC
      F5666DEB4498BFBA60852023C80E7D3730DF0D72A1EF86AC30686962C0B8AC67
      D072CFEDAE7B359913A42FCFEEDC58F8E040E4975DCB3F0B2E57B5AE6C6E5861
      C5861EDCF72F2EAF9FE7592933A8E1DDF2E0E13DE8BB21D9D75BB7828361FEDE
      B215828C20BBFCF6DDF0F9FE2D2B5343467C374862A724E5BB819D820CCA0A83
      A0714E4D493786F76A326AC6903E32288D0C4A970FBBF5E647F5E0FDEE8EB9C5
      E5B5B54CD313B2808C20BBFCF6DDC0B62F004024F4DD20493AC5F8BED9D229C8
      20330C5A18ED322E8941DB9B578D0B1A7349C8A0FC6690791F7693C1DAD8DD05
      6D2A28671A19D4F760E67063CF3B773B2D106404D9E5B7EF066927370084BEEF
      060583E41832C8204D0C21838C33687EA8DDB82406BD105C36AE9FC9840CCA6F
      06F59EDA3FDCD930391212343A44443F4334E267BC2F4834D00582D4D4CF83D6
      C95A6F7B2EFDCE0FDF0D20F9A6D6097C3788929F62C47783FED6D9C820E30C9A
      EB6F342EE9C7F246CFB27141932E29271804650674420F0E1994C2BC3888363E
      D0C53411EA038D0FF6C0E7E160FD50FB1D4861A8EDF64857230802D5F3E2D627
      83B2F2CA57DF0D72F70D097D37484AD67703EE9B9D5D0641439D9A9041F9CF20
      38B1B79D699C9E0BAC8138801E763ABC0F773480C69041C8A04CFA6E9087C4F3
      DD2049E1B8C1B8EF069C9360924133DD778C4BB25B68AB53133228EFF7EAA10C
      6A6302CA4027888CBCF5052980AE1378355D03725178752083904199F0DDA0F0
      DAA0E3BB4192DC6B8341DF0DF100840C4A6E8DEACC9871593F708D0CCAB93D4B
      3519D47C623F32081964B1EF06858CF86E90CBA0EF0664904906252564102E5F
      4DE8BB41CDA08643CF31E933C8FCDA2264D07A6610FA6EC82DAD85C3C0A06485
      0CCAF4F79D0CD68A1D10BD3E88BC27224D12B627836EFFA65C2E1D06B51DA820
      9EC4A3FB728C881A9E0FB5CD0FB6CE0D34CD0DB62C0C7780667BEBD900600A5D
      3630E3943B7AC820F4DD800C4ACFCDDB437C46850C4AF9410CB4C3C2269F7C84
      8AA7EF2B74DFE901A2A91E7EA69F88B83F58D59CDE6C72954DCA5C5330E8C2BF
      FC8D5AF11804E7AE4C8F2E4D0E322D3F1822249A0CC1E7999EFA99AEDB53C15A
      D04CD72DD0D2E4003B374AAEE911B9E643AD802D815C03CDA085E120231754A8
      6C4FA1A518CD0F910D85D89E42B383448BA39A7B0AE53A80F28C41B867293208
      1994AE0969CBD3A3493148738F02305D7E6D6D2D12590BAF465697232B8BE1A5
      F9F0E2CCEAFC14D97E767A141A6DD2D48FF72D8EF52C8C7442FB4CFB1A2DA4B9
      EE6F4CD9F2E50CFAA0F247F1A4C320821E2AF8BC32334E8B3A02A59AEDBB4F26
      C6F4D413B8845A21909DCB6A0CA0B3323709225F103ECC8CC1D7A1F4699AEDBD
      C766752E8C744182505D50A17096F94ACE4B06196F1EB32EF4DD90EB0CEABAFC
      99114958492AFEFA61107419E026593D920381526FC2489C8C30682D0E836614
      0CEACA0483929D172730481C8B8372AECE3D60C4A440692634196822C41CE904
      CA20839041D80FCA7506CD257A2918643CFEFA6150E7D1E7A101670DA05C10D8
      29365C1087BAD1D150676CE3964E06F10283D63418342632A83F4B0CBA0332C8
      A0C18BEFC532A88BD20419840C42DF0DF9C0A08B5F1EB974EAD8D5B35FD65D3A
      5B5F7BA5B9FE6667CBFD81EE8ED1D08026830CC65F570C62EDB65203CD7028CA
      20E6BD5A25294EA618145132487A54041F9626640C1A62CFFDE1BB349965504F
      2B13D996A7BF93AD5A2500BA5FD35F7FB1FFDE65B2CEA8A50E021332A8F7D43E
      266490350C4AAAA5CDAED077437E30E8FC1787FBBA3B43FD7D2343A189B1D1A9
      079373B3334B8B8B80154D0649F18337CEE9C45F3F0C82D68935740A416074F7
      0068F75883A65257A6FB41310C9A85269A0188993763D0226150471A1934D2DD
      CC4448041DA2EE16F80CE8E9BF7BA1F7D637A0FEBBE74123DD4DFA0CEAF8F49F
      E4420621837418A4F0D4A096BEEF0690DC718311DF0D9631282776F1952B2906
      7D7BFCA3AE60AB1A43D0BBD164108B0F003AF0CCD3720C29E22383ECC0205E60
      D00A61D0727C068D3206B5938964E61814DD604150BBA8B650CB0D618385E6DA
      A1B6DB20F9060B6A06DD7EAB4C2D641032281E8398838695A921B5F47D37689E
      A2BF6FB6E629196550FECD15919872F6E8876D8DF7D4186AAEBFA9C92088CF00
      C4246148113F8D0CE257163327E30CFAFD6F969FBAA0CD207102708C20308641
      D0A66949D1B8A56B6EB68A414B91B80CEA4D2383CCAC339533E8F80B7F1D4FC8
      2064902683145E1BE4D2F7DDA0798A3E83344F4106A5C6A06F8EBC7FFF769D1A
      43F5B557341904F1197D20BE1C438AF8E9625056FCA8668441AC655349D1B825
      BF4675AFE65A1ECA209E3228BC1696316841974121B30C32B9BE55734E02BCE3
      9C0464504206693A6E30E8BB41718A11DF0D3A00420625C5A03387DFB973FDB2
      1A437597CE6A3248115FC29022FE3ADA9D06184456ACB4A9940A83D2B80C210E
      83A6E331684162D080BD18A49A9B8D0CC279711AF3E2F2D877438EDE1B1864D0
      D71FBF5D77E91B3586AE9EFD529341EAF80C438AF8C8202583A071D392850C5A
      30C4A0C1288332EAD254DD7D1319246CD1B34A81B24A66928F936E1A650ABC93
      028FF5029B9041C8A078BE1B98FB86A47C3730F70D49F96ED0D93A1B19649C41
      A70EFEAAE69B936A0C5D3A754C934106E3E7F7D6C70A06910650B5C73804C630
      08DA372D991E8B7BDEF0589C2683062883BA351904EFB2D9E64D311AD057B35A
      F3720D36AB0D953068660CA0C3149E9F064157083E93128E740256A09CC04DD0
      AAC820DCAB0719A4F6DDA0297DDF0DA0647D3758392F2E8F19F4D58137002BD0
      BB3973F89D6F8EBC7FF6E887DF1EFFE8FC17872F7E7944934106E3E7A81B8B99
      EE3BACC99D1F6A5F18ED82261AC4C685C20B332068C9B519A45AA3AA62504453
      9A731284F12875A31AD3AE36B17635FE9C04630C1AD765902E4744B524526B54
      21416A43852F0285892CCD0B5A5E20A29FC9A63D40F6E95122E819CD4E008FEC
      B0672932C83E0CCA63DF0DF9CD209BEF93902B0C22A346B1523148FBA539379B
      41473DB8241F5F62434C7028FEDC6CB642883268953268692E2E83462406B5C8
      19A4CF9158B5C5D510533BD30295DA5047EA8EF59F7D33B77C372083ECC3A03C
      F6DD90C70CB2FF7E71F66710DC2AC7EB07C5EC9310A71FA4B94F423618D4A9CD
      205D8EC42A18D5B05A1D0AA90D15F29DE9BCF9A0F9F2F8DDD363B74F82E0C3F8
      9DAFC66E7F09EFF240880331213E3228ED0C82163257B47E7C37E4EBBCB89CD8
      371B19945E06853518D4273248DA322ECA207D8E08823E14DD47544B5D4C8BA0
      D11821836CC8A08CCE42C9DCB496BCDFB31419840CD265D05EF5B31BA2A961D9
      9EA57B95CFBE45755A3B16A764D0642206E972044ED4D6584F1CF54A4206D90D
      4028DBFA6E40062183D2C1A0654D59C220EABE4160D08C82414BBA0CD2E708D1
      B8A43ED09286FAD94C36859041C8206410324852B0B1FEFC67EFDF3DFD51C7A5
      23F00E9F21241E5F8C445E3F0C0A1EDA4566B21170C40802E190F1389967D0A2
      168306F519A4CF11563F514D320DC65168F94154F9C120941D846371B9CEA0B3
      47DEEFBBFDED604FE7F4D483B9B9397887CF1002E16A00198CBC7E183419AC6D
      3B5001EC500802E53EEC12C6C9CCDC6C852BD5380C52B9528D324824485A9E14
      4022F4AB91AF830C42A59141F9ED3F2847E78A186410B0A3E3FEADF1B1D196FA
      1BB5E74F5D3871A8EEC2E9F6FB772004C21564311E79FD3028BD4AF77E712A06
      2D26C72069E71CF37762C2A6EEE21A5E7B32680DAACC06520CF721658C30288F
      FD07E5E85C11230C0A36D64317666C74E4F69573F76A2FF7065B264787877ABB
      5AEB6FD45FBF04E170541A679347BE76EAF099B79FFFE89927CFBEF3C2CD73C7
      D5919141591F76D662D07CB20C226B4267461932D222B2030F55BA18C4E7EF0B
      1994148314DE8256A68692F51F04A724EB3F48E1B2017DD825E5C30E74FEB3F7
      FBBBDAEFDFFAEEF6D56FFB3ADB437DDDA3A17EC0D0F4E444CBDDBAB6865B7014
      E228225FFDE2E007953F92EBE6B9638AC8C820BB3068CD2083BAB41944372500
      A56B2C6E75616A75619A2D53CA3A833EBEDAB7FBCDCBF614940D199414839893
      20C98BD0E7FBB7489E83F4FD07495E84D829DCAF1798747C37480062A7186750
      0ABFA3FC66D0DDD31F4D4E4CD49C3971FFC6779DCD0DD00F1AE8EE181EE81D1F
      0E0D74B5D79EFF0A8E421C45E4936FECF9E4F9BF3DFEF21626F8FCCD6FF62A22
      23836CC1205E60D09A1E83FA7518A4DEFF8148E4885C6141338216159A55C80E
      0CFAE9DB35FB6E44EA427CE7031B09CA03A582B2218392621073120462686082
      CF52783CFF411280A4538C3048718A4106A1140CEAB874647676F6FCE71FDFBF
      79ADA5FE66B0B1BEBBAD89758846067ACF9F380447218E22F287BBFFE2F247AF
      5C3DBC9F093E1F7CE649456464908D1814D165D0848C41A23B6F8941FA1C11B4
      341747F3315A9E8F44B5600B06BD557377847FA1C676825241D9904149318839
      0992A3410284BEFF20CD53F4FD07699E820C4AAD1F34313E7EF5F4F19B97CF36
      DCA869BA53D7D670877588828D77AF9D3B0947E5FD2016F9F357ABBFFBF4F5E0
      8D734CF0F9D4AF9F55444606D99541B39A0C5A1C616EEC540CD2E5481C2D425E
      71B424C90E0C7AF69DEF9AC7F9EAF3B613940ACA860C4A8A410ACF4172E9FB0F
      D23C45DF7F90713FAA39346F3C5BCF837A3BDBEE7E77F1EAD79FDFAEB9505F7B
      A5F1D675D621BA7DF5DBC65BD7E0A8FC79108B7CEE93B7BFF8D7F286F347C6FA
      DBE11D3E5FFDE2A0223232C8260C92B9F35E0C2F4719C4B43419121814EBCE5B
      62903E4704ADCAB5ACD05A542B4461417660D073EF5D6B18E5B79EB19DA05450
      363983AC7C74253D8ACA2D0629BC05A995D07F90DC799041FF4109DBF91C9A37
      9E1506B1A96E2343A16B674F5E397DBCF6C2D777BEBB78BBE67CEDF9D37517BE
      8670F5BC3816F9ECE1B78EEFAFFA70F75F9C787DE7C563EFAB23E722830C2A67
      1924B852959E8A92D53A0F424A77DE0A06E972444BAB1A8AC81566B20383F6FE
      B6F6D610FFE451DB094A05659333C89A47578A4751B9C5207BFA0F4AD7BC71C5
      1CF24CCC1BCF0A83D8929FF6FA1B234383776A2E5C3975F4FCE71F5F397DACFE
      FA25088170F5FA208391738E41C695530CD274E73DB54A375E200B7FD40C0AC5
      30489F23F11511B416151F2B3B30E8671FDE80D6FE8963B613940ACA16C320AB
      1E5DC91F4599F7F0682583ECE93F4873DEB85A09E78DCB6570DE78AE3048DAFA
      A0B7B36D627C6C767616DEE1B3FE3E090923E318B58D19342D326844C1A00535
      837439224A77C125AF90F0B203835EFAE826B4F68F1FB59DA054503639832C7B
      74257F14955B0CB2A7FF20F5BC714DE9CF1B57C8C8BCF1DC6210EE17B76E18B4
      10C3A0E9380C1A8C32489F23665E7660D0CF0FDDBA39C46FF8CC76825241D9E4
      0CB2ECD195FC51546E31C89EFE8314F3C6A54974EC839179E38A538C3048714A
      4E30689DEF9B9D7F32B9A494EDB691D11D42D41B7A58CFA0970FDFBE19E21F3B
      623B41A9A06C720659366C281F06CC2106D976EE997CDE3893348F4E1E186FDE
      3893748A10A23B6F5C31732F57FA41C82054D6653D837EF1E99DC6317EDB59DB
      094A05659333C8B26143F93060AE302857E68D3349BB2BC803E3CD1B67924E61
      7FEACF1B4F790F07AB19B4B2980611834BE544B44C941D18F4CA67F53DD3FCAF
      EEDA4E502A289B9C41960D1BCA87017518048D1B32288579E3D2F8D8D1D79F85
      CF46E68D2B4E6173C8F5E78D2B4EB12783BAEED56451FA659BED6B486AA25A3C
      413A0B63DD69490AD2496352F8C3B40983F61D6F1898E50F36DB4E502A289B9C
      41960D1BCA8701E33148BAC74606253B6F9CA141FE21E1BC711653FE21E1BC71
      6914CECECF830004E1077D5951420605BF7E7B79BCD7BC201D50DF226F5E2CA9
      BFBFC49B17A493E9A739F6DCAADD860C7AF5C4FDD01C7FA4D576825241D9E40C
      B26CD8503E0CA8C920C53E69C8A0CCCD1B9794A179E35967D0D2586756949041
      6D5FFD6A79AC67B6A3CE8C20054807746182FF659F29410A2CA9B43008D23132
      AB2D32D99F2B4AD7D6BED633E8B5938DC3F3FC890EDB094A05659333C8B26143
      F930A09A419AFBA4C563506EDD4A65E2B6CAE6F3C69141FA0C9A09D69A113208
      1994F0F5C6E996F145FE7CBFED04A582B2C91964D9B0A17C1850CD20CD7DD2E2
      3128BA4020D75E69F49860E779E35967D0E248302B4AC8A0E62FDE581AED9E6E
      BF6E469002A4033A33CEBFD2634A90024B2A2D0C827490413661D09B5FB74E2C
      F257876C272815944DCE20CB860DE5C38026E7C5218370CF527D062D0CB76745
      0919D478FCB5A5D1AEA9D6EFCC08528074405F8CF1CF779912A4C092FADFDFF2
      E605E920836CC2A0B7CE0507E7F97B13B613940ACA26679065C386F261406410
      6A7D32A8E1E8BEC511B30C8214201DD067237C75D094200596545A1804E92083
      6CC2A08335DD1D138BCB91355B3580501E2815944DCE20CBBA6CF22E18320895
      5106CD875AB2A2840CAAFFF4958591CE07CD57CD08528074401F0DF3FFD0664A
      90024B2A2D0C82749041366150DFD8CCE16B3DEF5CE8B49BA054503639832CEB
      B2C9BB60C820BB4DB1B360588F68CA2206CD0D366745091974FBD0CB0B431D66
      1934D401E980DE1FE2FF4F8B29410A2CA927CFF0E605E920836CC2A0DC703749
      CB694D974DD1054306D9709A77A65D1159C9A0A9DE7B59514206DD3CF8E27C28
      38D974C58C20054807F4D620FF74A329410A2CA9B43008D24106218392659065
      5D3679170C19644306A5E68AE8071F2DCAF5478704A95D11218324064D345E36
      23641032280F5E76F0E58D0CB21583E45E870016065D11F9DF5D648253E03DF0
      9E20B52B226B19549F15256450DD6FF7CE0FB68FDFBF68469002A403FAB701FE
      CF1A4C09526049A58541900E32C8260CFAB8A16FF72797ED29285B6A084823FE
      9041E9D957D3DC9E9CF15C11493B26197145C4FD7A01249DE27A7B8149ED06C2
      5206F5DCCD8A1232E8DA7BFF776EB06DBCE18219410A900EE8FFF5F17F70D794
      200596545A1804E920836CC2A09F1EADD9178AD4CDF19D4B361294074A0565B3
      0983D2E0C42A671994DD7D3515BB6B6ABA22624C9102E3B9229200249D820CD2
      51CD3B3F9D1D6835C9204801D201BDD4CB7B6E9B12A4C092DAF0156F5E900E32
      C82E0CFAACE6EE3CFFC280ED04A582B2613FC80E0C8A4C0D64516A06C99D1049
      1F801A095C117D263821923EC0294547355C11218340577EBD6B76A065BAFBAE
      19410A900EE8D0F0DAB6B68819410A2CA992F3BC79413AC8209B30E8D963DF35
      2FF0D53DB613940ACA860CB20383B2B5B7B37A8767B52B222689293AAE88767C
      392F97748ADA1591950C7AD07D272B4AC8A04B6F562F8CF7996410A400E980EA
      A723278757CD08526049BD7C2B625E900E32C8260C7AEEF36B0DF3FCD62EDB09
      4A05654306D98141AB93BD59949A4192CB21B91853745C11BD78612946E70517
      E16A5744C8208941F39D7566940906BD7A37625E79CFA091BA63FD67DFEC3AF6
      8211F59D7E3574E543617F8C77CB8387F7247BA299A666EFC9DA5B73FC93ADB6
      13940ACA860CB203835626BAB3283583249743F1C46BB9227AB566259E14AE88
      9041A0AB6FED5E1EED9AEBAC33234801D201DD9F8D9C1E5B3523488125951606
      413AF9CDA0DE53FB873B1B26474282468788E8E7B1FECEB1FE8EB1BE20D14017
      28D47203E20BFBA51FA8981F0A2E4F0D8B1A11353C1F6A9B1F6C858ECFDC60CB
      C2700768B6B79E9D68A6A9F9D95737A0B57FA2D576825241D99041C820358352
      7345A4F64014CF1591A50CEABA9D15259E17F7EEB34BA35D26FD07410A900EA8
      7936726E3C6C4690024B2A2D0C8274F29B415DC75F02D08C0F74314D84FA40E3
      833DF07938583FD47E07B833D4767BA4AB110481D0A9914E5C991E5D9A1C645A
      7E304448341982CF333DF5335DB7A782B5A099AE5BA0A5C90176A299A6E6A5D3
      37A1B57FBCD576825241D990417660D0F2785716A56650A65D11218340370EBC
      000499E9A833234801D201B5CE472E4E86CD08526049A58541904EFE33A82F38
      DADBCE343ED83D1EEA05D6402708D003001A6CBA06EFC31D0DA0311583087AA8
      E0F3CACC3809991A991B689EEDBB3FD37D0760341F6A0541A07906FDFCCCAD9B
      73FC8656DB094A0565B33383E239F2CE3F0665CBCF9ADADB9A35AE88AC64D064
      C7ADAC282183EE7CFCCF8BA35DD31DB5660429403AA0E0C25ACD54C48C200596
      D4AFEF45CC0BD2591F0C6A6302CA4027888CBCF5052980AE0F345C010C0DB5DF
      05418F49C920712C6E65766275EE01BC43E07CA88D60A8F7DEDC40D3C2482768
      6566CC3C835EFEE6F6CD59FEB116DB094A0565B32D83A4A58EC8208B1994677B
      96DA96410D475E5930CD204801D201752DACD54E47CC08526049BDDF18362F48
      677D3208DED3C4A02E505A18F48B73771A17F86DDDB613940ACA664F0629963A
      E63F83463BB2A884AD654EFB6E980CDECC8A12FB513DBE1F0832D5516B469002
      A403EA595ABB3517312348812575A8396C5E90CEFA61D007953F8A277D061D7F
      E1AFE3298D0C7AE57C7DCF32FFAB11DB094A0565B32183E4008A87A13C6350B6
      FC4D1BF43A8D0C5A570C3A7627645EEB8A41A00BFFF2376A19E907DD7EAB4CAD
      F4F683F65D6C1858E10F4ED84E502A289B0D19A40010537E33285BBE3ED51E3F
      F36F2C6EA2FD46569490416D27DF981FE99A0BB59911A400E980A6C36B0FCC09
      5260497DF0C505F38274D6DB58DCEDDF94CB657C2CAEE3D37F922BED6371AF5E
      BE1F5AE18F4CDA4E502A281BCE8BB3058386DAB228F37312ECEC3F68A2AD2E2B
      4AC8A0079DB77ACFBD675E90CEEC50302D49413A694C6A1D3E0F6A38F41C53B2
      CF837A4FED63CAC4F3A0D7AE360EAFF227A66C272815940D1964070665CBDFB4
      DAEB741EFA0FEABA9715E5F10867BA949773129A4FEC4F6D4EC2E0C5F7323427
      E18DEB2DE361FEFC9CED04A582B22183ECC0A06CF99B567B9D56FB0FD27421C4
      EBFA0F622E84ECE23FA8BB212B4206E1DC6CCAA03BA0ECCE8B7BB3B67522CC5F
      5DB09DA054503664901D18343BD09445A919247715A4E942888FEF3F48ED4228
      BBBE1B66FA9AB2A29C6090653EAAF296413DAD4C645B9EFE4EB66A9500E87E4D
      7FFDC5FE7B97432D752008543148D8A267756E72757E6A15183433BE30DC4131
      D404EF8B63BD2060937906BD752B3818E6EF2DDB4E502A281B32C81E0C6ACCA2
      74FC072926C927F41FA4E94228BB0CCA966740FB33084A08466881F2984123DD
      CD4C8444D021EA6E81CF809EFEBB177A6F7D03EABF7B1E34D2DD14C3A0993180
      0E53787E1A045D21F8BC38DABD30D2090002182D4DF48356D3C1A083F7BB3BE6
      1697D7D66CD5004279A054503664901D1834D57B2F8B8AE73F487392BCBEFF20
      CD53B2E83F68B9E776B6DC0242D639C1A04C7B06C95706B51DA808B5DE92C6E2
      A44D7BE073A8E546A8B96EB0E9DA6073ED50DB6DD040C36569CF52F8B038DE1B
      599A17B4BC40443F934D7B66C6C8EE3D20E819CD4E008FCCEF59DAF760E67063
      CF3B773BED262815940D19640F06D56751F1FC07694E92D7F71FA4794A16FD07
      A1123228D3BB70E42B835273C190B2D3073E7F5FE8CB1B1964D07F905CBC31FF
      4182B2E73F08959041995E7D96AF0CB252E17098CFEB97F44D2783B5D68C0FA7
      4550DAFC615096FC4DABBD4EE799FF20544206657AE67FBE3228651F76C820FD
      71ADF9DC793193400665824179E33F08959041997EDA98AF0CEA3DB59F5F9D8A
      F3E35E856695E797A9C244F3C3D2F3A0146730AE2706595F80353EE9091B79C6
      A06CF9FA547BFCCC33FF4128030CCAEC486F1ECF8BA3A0098B121B33F8BC3CC9
      2F8D0377F8C5313E3C43C487A57971C8201B322885173228A30C32F2CA09FF41
      A8C40CCA702F3BAF1904DD9C255111FAB308934E10A00700343B40DE57A68890
      41C82064906106E5D39EA52864508619B4282A2C748220900068909FEA21185A
      9A20E2579041C8205B33284BFEA60D7A9D46E53183327D87B3FE18B4860CC2E7
      41C8206490D59BDE3CC4675419645086AD6B3D30E8FC6BA5F1840C5A0FFDA0E9
      F62B49692678D50E4206E513171487BA8EBFF8F67365EFED29FA70F75FC23B7C
      869078E918899C390665DAA7F93AE907751CDEA316F683729D419A5EBCF38941
      D001147C7D66B81DD057BE3E0F82A6FBE0EEA78D486AEA938A1F8F41BFF959C5
      E9D777B6DFBC34D9D7361B0AC23B7C8610085703C860E40C3228C3FE64D7CF58
      DCD89957E4C2B1B81C6250240E8034BD78E7653FC8560C4A615E9C3D7DD831A6
      30BF6C3A5230C8787C4D06013BEA4E1FEE1BE83ED6F1E0A5E6C5B2FAD57F6E59
      3AD133032110AE208BF1C8996350A6FDC9AEABE7415335EF32E1F3A05C679062
      EF657D0699C70164217DD681944431886F9E687666507EF8B09398F24EEFEA87
      FDAB9F0E864F0C85CF8C842F8E87AF4D866F4F451A67229A0C32185FCDA0AEE3
      2F4217A6B7AFEB97CDD3EFF7C25991FEC5B53B536B9F0E44DE0A2E40381C95C6
      D96222D7351DFFEDBE833F7DFA8B03FB0EDF6C5647CEE0BCB8743BEF63BF0BE9
      CFF5362761EECE519C9390EB731234F75ECE10831850581609B12201488AAF9F
      AC5A711994E1F1107D25F461A7169FC8871D28EB3EEC24A6FCB26B1508727F26
      D23617E959580B2DAE8D2FAFCDACAE41A02683A4F8C11BE774E2AB19F4F67365
      AD75E73F6D1D79AB3B7C7F66AD6D6EAD7B616D60716D7499FF6420F279F7341C
      85388AC8BFB9DEF441E58FE43A74B3591139730CCAB41FA5753F377B9C081994
      53CF8334F75ECE1083141D2EFD7E8D04A084F1215CF35BE40A8324EF756AE9FB
      B0D33C255BFE8324A6ECEB58B93E195163087A379A0C62F10140079E795A8E21
      457C3583DEDB5334DED3BCF7DECC89A1C8CDA9B57B336BCDB36B1DF36B7D8B6B
      371E445E6A5E84A3104711F9E3F7F77DF2FCDF1E7F790B137CFEFCC03E4564F4
      1F645306AD2D08223C5A1556AD0280A6FBF8C94EFE41373F3F44C42F21836CDD
      0F8A2C9B99176786410C0D1232145D151D601989AF88AC00969D19C41CD56962
      54DF879DE62959665028F8F3F6954BE36135862E8E87E1A89241343E03109384
      21457C35833EDCFD9733A160E9DD9573636B5726D66A1FACDD995E631D222051
      59FD0A1C85388AC890C5E58F5EB97A783F137C3EF8D3A7159133C4206B94AFBE
      BC0971227382088616F9C83CF90CE899E8E0475B8826824491596490AD1994FC
      AEB0691C8B9394102B09BB363AA7E83F0FCAF473617DC5F36107527C59299C8F
      E3C30EA438A5E8E852B67CD8494C79BE75E5EC68588DA13323DA0C82F88C3E10
      5F8E21457CCD7ED05877D3F377A70E0E44CE8E452E4DAC7D37B9C63A44E7C722
      2F36CEC351793F8845FEEDBBFBBEFBF475C882093E1FF9609F22725E4E9ECF75
      1F76FCC2A86C2C4EDAB467918CC5CD0D9181B8B910D9B70734D58D7B96E6F11A
      5533F3E21487F4B192DA2CBB7809DA9941CC519DC2939D3C908FE3C38E493AA5
      E28B1950B67CD8494C79A669F5CBE1B01A432786B419A4882F6148115FF37950
      4BEDB71F37F4FF4B30FCE548E4CC68E4FCB8D0217AAB3B7CA46D148ECA9F07B1
      C8FB6B9ABEF8D7F286F347C6FADBE11D3EFFE67A93223232286F7CD82183708D
      AA79ACA47D6EF6445B5D1695D0871DD024591F76704AD67DD8494CA9BCBF7A74
      28ACC6D0A783DA0C52C7671852C48F372FAEBBBB63DF9DE15F04C3BFED8B0089
      0E0F465EEF0CBF767F02C2D5F3E258E47D354D1FBCBBEFB7CF3CFDE17BFB7E79
      AD491D1919B49E7DD8218332FE0A678D4136591F94F6F9B149295F7DD8494C29
      BFB7FAF160448DA10FFB573519A4191FDE15F1E3AD0FBAFED5C75DDD1D1FDDEB
      7BEECE83D2BBCBCFDF9D3AD438082110AE5E1F643032320819840CB2788DEAFA
      625077431695AF3EEC44A6B497DC5D05AC40EFE699A6D5E75B577EDEBEB2AF63
      E5975DABEFF40253DA550C321A5F7F9F8496DA6F47BB1A670683F00E9FF5F749
      48181919840C4206E5CD589C4D50256750A6D768E82B5F7DD8494CD1979A4106
      E3E7FA7E7159D764B0D69AC9E16911941619640D8372CE97F754DBE5A464C37E
      90DD1894EC5E3DF6F46197ADFDE27265DF6C542E6DC0BB3E18948BB725B95566
      CDDB2A40C0EC406B1695C77B96666BDF6C64100A1994028350D97225C6AF2C66
      51E83F088542062183D6AD967B6E5BB6625D535000BC0A28140A8542A545DF7F
      ECBFDFFCDE43E4E5857FBF03FF82F0EF24FCFBDE43FF95860FDFF8DE4357FFE3
      43F49FF8EAFFEE280A651FA14DA2D0265128B44914DA240A853689429B44A1D0
      265168932814DA240A853689429B44A1D0265168932814DA240A6D1285429B44
      A14DA25068932814DA240A6D1285429B44A14DA250689328B449140A6D128536
      8942A14DA250689328B449140A6D1285368942A14DA2D0265128B44914DA240A
      85368942A14DA2D0265128B44914DA240A853689429B44A1D0265128B44914DA
      240A853689429B44A1D0265168932814DA240A6D1285429B44A1D02651689328
      14DA240A6D1285429B44A14DA250689328B449140A6D1285429B44A14DA25068
      9328B449140A6D1285368942A14DA2D0265128B449140A6D1285368942A14DA2
      D0265128B44914DA240A853689429B44A1D0265128B44914DA240A853689429B
      44A1D0265168932814DA240A853689429B44A1D0265168932814DA240A6D1285
      429B44A14DA25068932814DA240A6D1285429B44A14DA250689328B449140A6D
      1285368942A14DA250689328B449140A6D1285368942A14DA2D0265128B44914
      DA240A85368942A14DA2D0265128B44914DA240A853689429B44A1D026516893
      2814DA240A853689429B44A1D0265168932814DA240A6D1285429B44A1D02651
      68932814DA240A6D1285429B44A14DA250689328B449140A6D1285429B44A14D
      A250689328B449140A6D1285368942A14DA2D0265128B449140A6D1285368942
      A14DA2D0265128B44914DA240A853689429B44A1D0265128B44914DA240A8536
      89429B44A1D0265168932814DA240A6D1285429B44A1D0265168932814DA240A
      6D1285429B44A14DA25068932814DA240A6D1285429B44A14DA2506893A83CB3
      C9EF3F76EDE187E86B17FCFB1DF8F777F0CF07FFBEF7D0BFA7E18FC3F1FFFC1F
      D8BFFFF490FCB597EAA1BD7BD9FFC87F2408DE2E5DBA04213CD5433CCFFE47FE
      2341F036F55032AFE462E30B5FF8C217BEF0852F7CE12BF75EC9DE1F7EFFB17F
      133EFF2FE12EF6BFC1BFFF42EF62BF47C39F7A287A17FBEF64E792BBD1BDCA1B
      5B932F925ED15FFEF1134FFE70C38FFFEE918777955416728F3C5CF593B2EDDB
      8BB795146ED8B2A56C5389D3E1F0B1C0E29DD5A51595857F58BEAD647359F1E6
      925D8F3CCC824AB61597951756EDDCB1A3A2B2FA0F8ACBB7C1B1DFDB54B14D3C
      BEB3B2BC70F7EEDDBF273F4212840FDB4AB65757153EF270D1E33FFCC1534F3F
      F1C74F423976946DAADE59595208A96EFFBD8DDB763CF230E4BDA9BA6C578978
      E49187B71557FDA490BCB1083187AB3655ECDC5E5DE87FE46147213BC0227185
      A565DBAB77976DDF5CB19B85380B77089F5C8550929D65D525DBAA5880BB7053
      C5F6EACA8A72E16F4FE1B6CD651BB7B23FBC705E34739F2CDD6868D19F6C78E2
      B11FFEF84F36C0372A2FD9525D5D01D503F10A0305CEC0230F57966D2D8D8639
      7DEE02978345DC5801E1DB58B8BF00AA5F882C0F27F1E9914DE565508395259B
      AA0B21C457E0F47370C0FBC8C31BB70AB501C52AD953F8BB7061E9178809F5B0
      1CAB2081EA4DA585624EB2BFA184B2BF58116401E4EB92CC8B2B4B8AA1002EC8
      DFC9F22F2DABAE2EA9AA8EF9E6BE82E801E5F70F14F8634E927F5BA8318733F6
      CCD8CAF0420417146F27046EAFA2B5E128A0FF410D15EFA82EABD84E035D051E
      5642B714B962CB96AA1248430A28DB4EB2675FAE6C3BB18A1D153B76C27FAC02
      2A379754EE2EDB5C5D5AE8A2E60DD60F555959B67DAB68A465DB8AB79690C862
      40C9962D24F3B292AD95C5CF546D2A2E2F79E4E12D1595DBB6956D6729D12B59
      F4F886C79F7EFCAF7EF8E33FDAF0576032CC9C62AE9693D5774C9857615CBE02
      9FD2B6FC5E12A6AC535F81DBAF61587E0807EBA43F045A6550590501AEC003DF
      B66A13FC1CCAB71557FEA4A47253453934057EB793F338DCB187D89766111C66
      0DACE84F7FF8E3A7F42A85D3A8149FA2525CC4EE1406C71578D595E229E0DC5A
      BF36070D8FF9AD81A9BB0B383FB992DBAB6973F9879565C5E5ECEFD212924421
      3989FC5955FD4C3969B4C867CD7AE114F5C225AE9727FFEC873FFEC1863FDFF0
      046931376DACDEBEA578534921E7F5BA399FD7C582AA4BF65043DEC4EA0D8EFA
      7C3EB862528814A114722F67657679BD7E48421E48A3C94E86A46527C4845795
      16D39CDC6E07E7F68805DDF0FD1FFDF10F9EA225A54D33E7226DF3A6F28AAA12
      F6AB7BB4AA7A33FB449AE96DC57BD4C1CE42F8BDA8835D85C4F276EE501F7117
      563D53457EBFEA439E42A1557854F83F69D245003C2A7E202DBBD8066C2CAE64
      C762FF7EE4617FA1F0676C66B27862A60131A6FC7B6BC4E31C62C4683D6845E3
      A46852BD684573165643B3A3AE83225931FE8E34AE705D7E40821434653F2907
      2336317E68D6440E73D1D0428F035A0A1FD0C72526201D82DF0AF9B59023629B
      281D93DAE96D15953BA0105B0BC5CF106373E1B69F90DF09349C9BC96FEF9187
      C1B8D8798475D084D144379755156F2C676956C536FE7087510CC96CDAB6897D
      35B83B204D766CD642202B99E621295BE501F1FBC41E2C92AE9C58B38F15EF29
      DB56F6533395EB21B5EBF66AD5AE87542F39947CF56E2ED952BCB35C59B31E52
      B524412355BB4DFA6EF2DA8522431A50646F40AB865DF4E2B9E547E52520D9FB
      E507E355B468FB5245976D3759D1506450C0A951D1C4BCDDF4509A2A9A5C513F
      4DD050454BDFCDFA8A96B7B2625D3F01614FEF48BDA6398ED600E7F26BD43539
      48104B0EA6A9B64992F065699246EA9B7D67556D736E6A249C97D3AE6F729C94
      5C763CA6146E7AC1E487E3D4790C52C44A7FF2992A00CFFF200752AC7997176E
      5CBC05E49B04D435CF0E3A858369A9798E26E9F2B0248DD4BCF0CD2D6BAF85DB
      00B18E93A85887DCA40B00727E07ED5EC4AB3613154A6EC3C49E5E01EB01EADF
      7E7AE5B79F5BAA3656946F96DF848205729CC32511457684E3BC7E17B9BB2D86
      9B3C724B515D585D4C48FC0F3BABAACBB63C03B7AF340B87F041380DBA039CD3
      2FD994FC9007AE3DE727BD08E10E51FC249645BC8B14AA47F3D8964AF8A6B1B5
      26145D7D80064955161B4CBE89D0F11383E8FD77344CB8D516BA6E241F687A8B
      AB352E1B3D9BDDD646A381119554EE2A2E2F74CA2E393B06664633DD595E4E4F
      A577F3E22DA7AE01BA121AA0D059D3B03F27613A1C72FB4C992029A3ACF29C1E
      1624AF3C0FF985EF2A833EB160AB1EAEC01F28F0B8A570450262ECD834A42BE7
      8406B580B6489017E95AD3506852481BE5E452EF80298D1E82766E2FD94EDAA6
      CDB29F82D3EB723A3D5E0D9390EA517940F84619B7A19D556CB0412A7FEC5FB2
      E10829AC48D181316D701EB8B4706314D0B0383F193628E01C5C3A4D2E8EC549
      AC81FC5C345BD23190B598701BE44DD86026692E24D7F8F6F303A1F172BBA148
      4EA5FD70E9378722AD9EA849A4B980326EE868913E815BE35E811CE402EC605A
      EE151C3449978B2569C77B05752FDE7C1D738100AD638ED3BA1F8383A48E392E
      6D754C9224754C92B461EF5931FC91061BE65CB47E9D1E2D1B8683A47E29CDD2
      64C39024A95FC6B754BBD01654B1B2FB6CA28A496712AAD815D0AA62D2EF09B0
      83E9AA62489254314932F5CE7306AB383AECA61C9B78AAE22938967ABF39E0A6
      FD4FCEA3D16D0EB869DF93F3A4ADD70C2992EE2AE749AE9EAB2BAAE997B4A8B6
      D978F88F9F7A62C39F47C799BD6E32CE2C8C7D46C797AB2B2ACA77146F2F297F
      94BE93B16512A488E72A04586FFAC9C68A3D8FD20F640CB2820C2B6F2DDEB9B5
      E451FA4E869277C5FCED2DA4F19467F90A6332F41796176F843FE93B191A86BA
      82AC8A2B1F153FD071E052AD60AE706B65D9E647C91B1BDE2DDEF828FC83CFAE
      C292CD65D58F9237F8CB5DB8AD645BC5A3E40DFEF21496B287342435E9131CF0
      16EED23EE02B2C2FABAA265F44F83F84F90BE1426F64DF4EF800A10156536274
      F91F50B78EC2AA1D65DB69C9C40F104ABE45C5CE1D24BE78119C8555D59B59BD
      881F20D405A1C5D53BAB58FD89A16E2194145A3CDF235C69592538E1DBEDDC41
      6CE951F63F08F215962A83FCE2F300D5377606C4433A5FD1E59022A96BC7C589
      4F924959A31FE18853FE78413E780FC75C7059769493279E7055840F10EC86CB
      A811EC29845F07FCE89426EC2DDC58515DAA7DE55DBEC28D655B55BF05975F0C
      562616A0BF12F9430EE923FC2C1CD25166AB1A513831E5786938E511E2260316
      C1BE05D4B3F409C2DDD460779595EC7E54FC00A11EF86D9594D050F103847A05
      FB89F9EDBA7D859565706989FD881F20D45F58B2875591F07F080B145695933E
      DEA3EC7FD00E403B53B20BE2D077F89B13729059A3C7295AADD24E3DA2956BFC
      543CA2AD6B1897C7436B5DEB88971ED14ACF478FC873F7CBDA3F797840302B95
      91781DB2230A3BF1724223A1087616EEA29754EB1497D0D4691C2B92181A034A
      B7C673DFDF9573D2EDF117387DD04175C0BD42C0AD7A24AC9A8341C62739F533
      61C61EE5236106BDE8036132F242867DD50FBC631FE42A1F7FAB1EECAA060D32
      D95F15782E1FEEF00438AFD3A57E8647AB33E0A7D5E9720A89C51C75C17D073D
      2A7B6EB45976DBE26297C3ED619723E13D8889EE715569C5EE2D159B7656D1C4
      A1ED603313B694172B4603A3C7E2856BDD6C448FAAEF52A2C7C0A0B703B52A4B
      64155E24FD9292B667A83E6F01549EC7AF30656774D242D496A1C7E849D596A1
      EB52E062B394D26CCB1A9392E4D373A283BAB251E74D25DB29E3F47E074E9DDF
      01457574E050CA63E7F67847C8E58B37A09CCE3166B883DBB143697942A0CC78
      0A3543634D2AC536D2E3297071057E478147396586B5858A39338E0252D3A937
      904E171D9ACEF506924C8F517772A116A12E39878756664CEB4802C93117AB68
      55DB68BC5F96976DA2D8CD4ADE7C03055E6741808C34ABCCD7AF9E6259E03763
      BCE402FA6C63BCF47AA7F238C3E3F7706E9F7A9811EAD24FEB928ED7479B463A
      B313420B383F9DEE465A3B16461EC1B85CB452142D291728F081C5BB0B025AED
      AC8B1C84D40252A195A7FB0B9C62CA2C822A0D7241381F8D217DC9F80DBD1041
      A7C54FF4BB2BA23D84E40D9454A893D4A92FB181722EAD799AC60D9463B317D3
      6CA03B2A2BB6C2AD7E9560072C1B57349C65EFA6A344E4610FDC756C2CD95AB6
      3D8AB992ED9BA37F40B3515DB6099A2413B62F66AD60A446B0EA14F90CCA5DA9
      5D53F8A25EF245E1F7E2504DBEF5282F2ABD501AD34C5D462F2A994792D98BCA
      09D978141735E0252D02982E6B120C5D552EEB57551C7D4398E4124C80180C26
      7E2D98407200139F5B03266E7290F0C61D07261EF2E8D71BA029C78109F4755C
      D02FA551ACA1496A3D40CECD15D0651F051EAFCA44555D408F4B6B863BE9426A
      D8A8C745677B2AACD4030D9A033B81B9D009A4E3E2C9B30C7E86D0A9234FEF02
      0A8B72AB179290AE62EA630AD22D9D4D1ABD22F1914AF2BF43E03F6975FC6446
      95A2DAA03AFD86EE0138364D3061C539C84F1E7E8CFEF4561C596142BE3F6D7D
      6579B08104F635A15DF48175402BE09790A0384E6E10E03899C02CBF0760B1E4
      E6AB1528CDEEE3B8800B5AA5A2D2D42F0999CF4AA648F8D5F826F72F2A7EBB4D
      8CF5BAE147EA843E8A33EDB61CBD24B23CE455CED139E89CD355E00F685D12B6
      48807379E871F9CDB6FA92388C5C12F29431E9AB116D03CBF600494BCACB591B
      005D46A797740CBDF0DD20F52A681F3755478F9370729C4CB327C7E97045F4B0
      4F383D209C2EA52E6B65DDF24C652DAD3C3C3AB5908D49D19B0E55321A29C43B
      B9BC6C3B59744AABCE1570FB398E2EC054CD5E4DB1A562D5147BC7466A263684
      7C3B550E62A03C1B314C312D580C8E3213BEADBAB5152B517524667CA9A8BA78
      630A23DC2EE86CC04DB8CB03C60B29B0C9233E3AA8C6915B46A73457593C4A7E
      C7703F447A544EA15A6487C8E44432D64016095690D992DB6507E147420E7A94
      F73D1EF1BE47E3462551BF00EE223510E98E73D3E5A6D371ABC9EDA47C7E2329
      A362326CF1C6AA8D5B859B40C816EE78C94F851D50B6EBE6DAA4348EA6AA8D54
      B808B1FD0AFA105E7C26AFB023FA81D5C31EC5DFCF503B230F2A93363427990B
      EDA72B81A19D53DDF8A871E1E14CE0C215ED5DA41917F1A6F7A47A0D3546BBBD
      0EB7CFE3E534AFAF0C3C8AE9F85A47C8D5D50A973A545A078BC8EC95A4AF2F69
      325CE4610559CBE2543DF975A92EAF878429AFAE537B85B4C74B1B074BBA4A99
      BFC08E6C5D59351E850C54E145D1E92BC9DF177AD86317271960702B07619D2E
      7527C7ED4E7D14968C4893E50E1918B18BDE19725EA8408F938D7DEF90552D84
      390ABC7EF9B0B9FCB0D34156A605585578BDECB2C5C42037D13486C3198DA1B8
      76907B347DC5715AD96E92BA2F7ABE320E292089E377B338D5A53BB76D14B2E7
      E8B02A17F0C4903E1AC1EB6511FC0E1681A41D3D2C99160D6290E0C81A06D9DF
      4EE96FC59DB0324C7923BCB5FC991DA55A3F088D03A4581AC145BB52B763A753
      58E5EB2808B854FD1BA7DB5097D35BE03632ECCC46E7BC9968CFE45D4E6A4960
      C80A2B166C1B0C39BE1593193DE46134A765C52486DF45230402DA36ECA3BF50
      4D1B763AE00E0E4E668BA8340C984420570262B839B9F93ADD5C810F4EF5F865
      6B876587E15E941CF679D972DFDC325D61AA63E649ECD622B13B0E89D9FDB325
      24A66B8E68165E8E4C8FE1DCB28D0E620EC2572547DD5EE16E35E620B47CE4A0
      3760705D13098AE97192263690E1BB74CDD158215099B12C5896BF2C542C862C
      4876EB1FFF4643FB98EAD79EF02644F3571E7356BC636C5A42DC24E31E26E9C5
      3D186500ADC55DB2F9B8A5B1874A65876227F1D2C3B141CAEEB7380F34F93E38
      B4FD60DE3EB2DE4BDD3172AA8684D9E09ADDE64CC65D7C2DFE16C9D724EB47E0
      CEDFED51FD8C65F7D9F21F3039C9CD4EF27A52F901D31913EC062AE54775AA5F
      ABFEEDBB9B634DA253EB0EDE45864CA1B9F2412DB8553F2172D4EDA147C98642
      BA77F3021FE83792A6C5D34DA4D4C3F5429526184092CFB047EC143A030E36A7
      C65D10501B2C391A801FAE9B8E93A9C0132055C1B1C3E4A64561B92E8701F690
      DD7DC89D19C207E1A30F1F62376CE993ACD3E84C34134C6F0A5991B87821A591
      3ECE4336FD037AF9D4FBC2A987FA8068015340F35809B474CE7DD518FCE3A015
      0D28C719DC5E32A0E92B88AE5536F87371FAC9C520CB08BC9AE30B9030C7D194
      0329FC7468EA5EB034327C40A68314890BCC92BF0982868E3091238FDAD4F8E0
      021AFC703A3401C2C501884BD9E52613FB69A7C1DAD916E496C4E3A71307939D
      6F11D7BEA2BBC7A43C2F34C7665F88CB159596F6BB9CF147A569FA2547F76F2C
      92AD9B4CFE2740C6DAC8DD319919E8F3A89E7C0534C64D03A93F507792DD3932
      F08424E5C921D2EAD2947A509C076E32BD1E0DE468ADAB703BCC2E3C73676232
      02CED34AA5A5E0E2B714B26915D1A59629D85700EC2A00FD322FDB025AD14957
      AF6B74A5FECBA44BC13C39FAEC52B152275E17197AE44E3A13406B468DD34766
      AA42273AE01376AF53DC7504D87117271CD77F9C292C464F61CA1947E79B7164
      089953362AD16BA9FF00C0D8358F76EAD37BC555778931E3F08A317CE528BCEA
      B06C0C5E7593C81E2DB89C71C7F8359E2168C4913D45282A4DF1C2D1EFE020BB
      AF91DD7602B97FE1E8E3479733C79E3216C5EEEF907CA3EB23C3A26E37DC2C6B
      0C8B7A3596F27001E3034A7EF58012D400FCE4F14146DAC692E8621A6F816280
      283DA3499C03DA660FE9D3C57694C97400AFB3203AB921F670C0413AD2646E9B
      4FE377E271F8C861A7533A2C6716594441D2F7C4F99590C4A1ED22A9BBB41F64
      92F4490CC880C4500E1AD1B90C2E79E1953168F9BD340B4F9C9127FA1DBC340F
      8F850F3FD41BB6A4F307CF6E87143FF868EF25C511640B7EF0E210B2671D0D21
      8B0B45DD160C22E3EF3D2BBFF70C8C372B76734AE75354AD01007C8A8A4F5195
      4F51636F58CD3E4C95761D4BE7A243B7C6A2437781476BBDB3DB1B07835EAB1F
      A492151B01F82EAC37A631C6554A866F8436017E565ED253E1C876EBD09E450F
      41C7C2493A199096936C7E4C8E88F3B69CF23FE9B42DF9AECB293DCC7678A9F3
      028E2CD192FB66E2D8AEB16C8B0D614BE742958F1AD956B51A3E68E064711750
      95471952B63D8A6362001451BED1B0A61F1C61CA1F19A463BFAB40C04F9C46C9
      C2E5EEA2DC9CCFE124FDF62269F3BBE40D968CBF06D8222927E7523DBD31B644
      DF15BDC9CB46975B3EDAC811872CC400E83C66B78951C7D2D42B95ACDD24435D
      E459AAC395B8212000B4DB38464CA59235AFA452DDC45F5DC044A5CA375E4C7E
      012E198572B34BEB7525F6E50637685E2D5F6E2EAD7A85AF487E4BCAAD07E0CA
      F854EEC76475ABE18C2CB66E398DC5A4166FC2A4589622B35327AB509F935568
      EC3E4C3E173D4A76676647736A2726B23A8E3C3B777170151D99DA9149FE9422
      E6B63B951DEBC84255E27D48F998023A22EA95173EB32B2F1CB8F202575E684D
      5F97EF739BFC46A2645FA30237F18CA9BE03766A3DCD1537B94BED791BB9E1C6
      A7B93931EF2366A3E4F4C2DFAD31CAE8D29E6664749CC045D9EFCDF10D181DEB
      0BFAD66C491BE32F26C9E6916326EC760B8BE99566ECD2DA47D4D47C17E1B970
      8EEF23EAF738BC01B53B4F5A8FA43E7D5E569FB11B2DFB5847908CB4B2A3B6B4
      669D5B550BAC3A7AF320DB435EE99D43BDCB7CF2A64FB659F60A97CAEF35B05E
      C6C99935FD7CD842579A57AC347D9F8FD6A78734297E95E993DAF6FB696DD371
      1034FD644CDF49276EF8E8B621452A3F0C293C20F552ACBAC9C316ADBB1755FF
      CE19D09C1491D4A6892E5FDEDA3E799642EA934C9057DDC4B8C93306723410B0
      F34D8CFD9B7D6DFF22C94FEBE298F59367009AD61FD0B8773769FDDEDCBF778F
      7BD3431FB338C97825A761FD2E27BB85270FD1D0FA93B67EE0261DB7229ED28A
      248739E97C12087735AA2781BE028D1B1D36C345FD24D0A7DC53475897E2E1AC
      18082912DD056561FD86C67E37A29B227B9446E62729CDAB48BCEAFDD3DC2E13
      33210427AF19D8633466BF6CA030CDC663781374A77CBB6CA7AD364117DD5CD9
      C3D604FF5AE95DB0A73592E6714B666264C19E93865BB3608F34CFA5B22E117D
      B240469F39A78F1DDD153D0ADD2188E071FB0A4877891C8C9D4B434214736948
      1094313680152B366C57EC3C3A8E4C9AA09E86480163D71052AF001E5FCC4C03
      61CE5880908774E8BCDE98C332F2B9BD1E12C9ED772823490074FBE9D44177C0
      47A394D232CBB271B34D22DD5E61473F590479469C8B4573FA55D1A259918D03
      48243A139246628E2715F9051C2C3B875B1945912389483254478CC933200CA1
      9168BB34BE9F8F7D3DBAAF6BDC6FE7635F4E1129261F1FFB6A2C8AE637233396
      20279F4B19439119890799A9E3C5E44762417E24561C834A7D911EF5BD97FAF6
      B4D116C8EBE67CE4C6B2B47267B970B74656F638BDC014326E4C4A5F2ADBCC89
      389E25DBD17AC84EB57EF2FD63CFF3B9E95EA64E5ACBF24DA0DCEC3C32F44F36
      552ED9BC954E1F2054A06D8DB88D2CE776795D64F56011F52768A2792E2715A9
      6C69374B13723837999143E7DC44FD155AB05CD4696220CC4340EFC11D3553DA
      5153E9813295C7FA7EBACDA1CB91614F191E32E0E9CFD5D587B15DDDB8AB0FC9
      AC78822FBFC6A5F67B6833C239A0F3E674A9AE38F52B468E3B85E346AE7CCA7B
      69789CF4C2939573EA2BEF2DD01CEF7398B9F4C4498A3F5FB6D2107FF531F33E
      5C1E61E57BB25B69909D8DE89577F9A09A3C1AB38E896307614D7DD25B69D0D4
      A99F272FB3ABA25807B4C90F1D9019B47E364745CB765478805F7DC094E9B833
      D10D4C38219ECCD375FA5D746F71672060744A3C476F235C747A0D3D4D3129DE
      AD9E14EF564C8A2753549CAC536AD5A478F88E0EE219DE990CA4C820928B2C81
      215B6E91C511166F2B26F7969CFCA8AF17D81720837B64C1B7DFC06E42642EB2
      2BF5515F377DD4EDB4DE90899F0527F5B3406E80DD460D99DE2F534F22F07FB7
      43BD4C4C6DC82E0D43163CFB5965C84E52D1E4C99833094376FABD74B49ADA02
      1959CD8221A78C7217593D4F0CD9EBD23064A7C6836BBAF8207543F6D2F5FA5C
      5EEF8B45DC331333E29C69DE178BB4EB2E6AA05C0A30275D33D2E292D5682ED2
      181589DEDF53F0B2C3DA3FB2A98166FBE7D298AFCEB9CD980DD99C83CBE3CD47
      32D6CD8BCE4B4C71E33CE1527BE35C6A4E6B093467E65273BEFCBED4C491A168
      CF6ACF4D8498A4CE459C686C3BCE1E831AC18DB028252D739E3D89FBF82ECDBD
      BFC87453AD55293E1AAE5CC1EA544D7A4EC3AA149CF49CE649CFAA754F999AFE
      EC51AFD373D16566EAB5A52E2DA706D039C9D3B54F64F9A4C7E1CEBD59D0A656
      3E79AD5DF9C4BA8829CE0D22831D01BAC098F59D12ED3ECD69EE3EEDD276124D
      06D8DDCABD43C4C541164E0E725A30B13FE616482334974CD829EC42ECF43AD9
      63A14C9BF02E3A0DC844FB4CBA24E4C13AE7275387B8C476EC7468EFA2EED2F2
      734A1608BB15CFD449036675036D851D737E1FAD4927C7B19A8CB167D224D3A3
      E4CE881ECD25BBCEFCFA9452B386ECA2E31C1E4ED38A552BD7C9964F5AB7194E
      ADD6982CF653DF66B89973C67CB362D205818AE43C4E0D2BF6B05A2623FD68C4
      2A23FEFFDCC82CC9}
  end
  object bsSkinMessage1: TbsSkinMessage
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
    Left = 576
    Top = 2
  end
  object OpenDialog1: TbsSkinOpenDialog
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
    Title = #25171#24320#25991#20214
    Filter = #25968#25454#25991#20214'(*.DB)|*.DB'
    FilterIndex = 1
    Left = 516
    Top = 3
  end
  object SaveDialog1: TbsSkinSaveDialog
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
    Left = 545
    Top = 3
  end
  object bsSkinPopupMenu3: TbsSkinPopupMenu
    SkinData = bsSkinData1
    Left = 452
    Top = 3
    object N5: TMenuItem
      Caption = #21333#34892#23548#20986
      OnClick = N5Click
    end
  end
  object PrintDBGridEh1: TPrintDBGridEh
    Options = []
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'Tahoma'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'Tahoma'
    PageHeader.Font.Style = []
    Units = MM
    Left = 485
    Top = 3
  end
  object SavePictureDialog1: TbsSkinSavePictureDialog
    OverwritePromt = False
    DialogWidth = 0
    DialogHeight = 0
    DialogMinWidth = 0
    DialogMinHeight = 0
    CheckFileExists = True
    StretchPicture = False
    MultiSelection = False
    AlphaBlend = False
    AlphaBlendValue = 200
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
    Title = 'Save file'
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf)|*.bmp;*.ico;*.emf;*.wmf|Bitmaps (*' +
      '.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf' +
      '|Metafiles (*.wmf)|*.wmf'
    FilterIndex = 1
    Left = 388
    Top = 3
  end
  object OpenPictureDialog1: TbsSkinOpenPictureDialog
    OverwritePromt = False
    DialogWidth = 0
    DialogHeight = 0
    DialogMinWidth = 0
    DialogMinHeight = 0
    CheckFileExists = True
    StretchPicture = False
    MultiSelection = False
    AlphaBlend = False
    AlphaBlendValue = 200
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
    Title = 'OpenPictureDialog1'
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf)|*.bmp;*.ico;*.emf;*.wmf|Bitmaps (*' +
      '.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf' +
      '|Metafiles (*.wmf)|*.wmf'
    FilterIndex = 1
    Left = 420
    Top = 3
  end
  object InputDialog: TbsSkinInputDialog
    AlphaBlend = False
    AlphaBlendValue = 200
    AlphaBlendAnimation = False
    SkinData = bsSkinData1
    CtrlSkinData = bsSkinData1
    ButtonSkinDataName = 'button'
    LabelSkinDataName = 'stdlabel'
    EditSkinDataName = 'edit'
    DefaultLabelFont.Charset = GB2312_CHARSET
    DefaultLabelFont.Color = clWindowText
    DefaultLabelFont.Height = -12
    DefaultLabelFont.Name = #23435#20307
    DefaultLabelFont.Style = []
    DefaultButtonFont.Charset = GB2312_CHARSET
    DefaultButtonFont.Color = clWindowText
    DefaultButtonFont.Height = -12
    DefaultButtonFont.Name = #23435#20307
    DefaultButtonFont.Style = []
    DefaultEditFont.Charset = GB2312_CHARSET
    DefaultEditFont.Color = clWindowText
    DefaultEditFont.Height = -12
    DefaultEditFont.Name = #23435#20307
    DefaultEditFont.Style = []
    UseSkinFont = True
    Left = 355
    Top = 4
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 321
    Top = 3
  end
  object bsSkinSelectDirectoryDialog1: TbsSkinSelectDirectoryDialog
    DialogWidth = 0
    DialogHeight = 0
    DialogMinWidth = 0
    DialogMinHeight = 0
    AlphaBlend = False
    AlphaBlendValue = 200
    AlphaBlendAnimation = False
    SkinData = bsSkinData1
    CtrlSkinData = bsSkinData1
    DefaultFont.Charset = GB2312_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -12
    DefaultFont.Name = #23435#20307
    DefaultFont.Style = []
    Title = #36873#25321#20445#23384#25991#20214#36335#24452
    ShowToolBar = False
    Left = 288
    Top = 4
  end
end
