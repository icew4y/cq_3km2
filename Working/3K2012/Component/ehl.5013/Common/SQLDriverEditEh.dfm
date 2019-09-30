object SQLDataEditWin: TSQLDataEditWin
  Left = 361
  Top = 396
  AutoScroll = False
  Caption = 'Edit SQLDataDriver'
  ClientHeight = 391
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter3: TSplitter
    Left = 0
    Top = 280
    Width = 692
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 284
    Width = 692
    Height = 107
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object DBGridEh1: TDBGridEh
      Left = 0
      Top = 0
      Width = 692
      Height = 65
      Align = alClient
      ColumnDefValues.AlwaysShowEditButton = True
      ColumnDefValues.Title.ToolTips = True
      ColumnDefValues.ToolTips = True
      DataSource = DataSource1
      DrawMemoText = True
      EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'Tahoma'
      FooterFont.Style = []
      HorzScrollBar.Tracking = True
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghTraceColSizing, dghIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      VertScrollBar.Tracking = True
    end
    object StatusBar1: TStatusBar
      Left = 0
      Top = 65
      Width = 692
      Height = 42
      Panels = <>
      ParentColor = True
      SimplePanel = False
    end
    object Button1: TButton
      Left = 617
      Top = 76
      Width = 62
      Height = 24
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
    object Button2: TButton
      Left = 551
      Top = 76
      Width = 61
      Height = 24
      Anchors = [akRight, akBottom]
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 280
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 127
      Top = 0
      Width = 4
      Height = 280
      Cursor = crHSplit
      ResizeStyle = rsUpdate
    end
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 127
      Height = 280
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Panel6'
      TabOrder = 0
      object Splitter4: TSplitter
        Left = 0
        Top = 158
        Width = 127
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        ResizeStyle = rsUpdate
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 127
        Height = 20
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object sbRefreshTree: TSpeedButton
          Left = 108
          Top = 2
          Width = 15
          Height = 17
          Hint = 'Refresh schema'
          Flat = True
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            3333333777333777FF33339993707399933333773337F3777FF3399933000339
            9933377333777F3377F3399333707333993337733337333337FF993333333333
            399377F33333F333377F993333303333399377F33337FF333373993333707333
            333377F333777F333333993333101333333377F333777F3FFFFF993333000399
            999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
            99933773FF777F3F777F339993707399999333773F373F77777F333999999999
            3393333777333777337333333999993333333333377777333333}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = sbRefreshTreeClick
        end
        object DBEditEh1: TDBEditEh
          Left = 2
          Top = 2
          Width = 105
          Height = 19
          EditButtons = <
            item
              Style = ebsEllipsisEh
              OnClick = DBEditEh1EditButtons0Click
            end
            item
              OnClick = DBEditEh1EditButtons1Click
            end>
          Flat = True
          ShowHint = True
          TabOrder = 0
          Text = 'DataBaseName'
          Visible = True
        end
      end
      object gridTreeDetail: TDBGridEh
        Left = 0
        Top = 163
        Width = 127
        Height = 117
        Align = alBottom
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataSource = dsTreeDetail
        DrawMemoText = True
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Tahoma'
        FooterFont.Style = []
        HorzScrollBar.Tracking = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        VertScrollBar.Tracking = True
      end
      object gridDBTree: TDBGridEh
        Left = 0
        Top = 20
        Width = 127
        Height = 138
        Align = alClient
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataSource = dsDBTree
        DrawMemoText = True
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Tahoma'
        FooterFont.Style = []
        HorzScrollBar.Tracking = True
        Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth]
        ParentShowHint = False
        ShowHint = True
        STFilter.Local = True
        STFilter.Visible = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        VertScrollBar.Tracking = True
        OnMouseDown = gridDBTreeMouseDown
        OnStartDrag = gridDBTreeStartDrag
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            ImageList = ImageList2
            ShowImageAndText = True
            Width = 119
            OnGetCellParams = gridDBTreeColumns0GetCellParams
          end
          item
            EditButtons = <>
            FieldName = 'ChieldCount'
            Footers = <>
            Width = 27
          end
          item
            EditButtons = <>
            FieldName = 'Description'
            Footers = <>
            Width = 3505
          end
          item
            EditButtons = <>
            FieldName = 'Id'
            Footers = <>
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'RefParent'
            Footers = <>
            Width = 73
          end
          item
            EditButtons = <>
            FieldName = 'RefData'
            Footers = <>
            Width = 74
          end
          item
            EditButtons = <>
            FieldName = 'ImageIndex'
            Footers = <>
            Width = 52
          end>
      end
    end
    object Panel3: TPanel
      Left = 131
      Top = 0
      Width = 561
      Height = 280
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 1
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 561
        Height = 280
        ActivePage = TabSheet1
        Align = alClient
        MultiLine = True
        Style = tsFlatButtons
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'Select'
          object Splitter2: TSplitter
            Left = 390
            Top = 0
            Width = 4
            Height = 249
            Cursor = crHSplit
            Align = alRight
            ResizeStyle = rsUpdate
            OnCanResize = Splitter2CanResize
          end
          object PanelParams: TPanel
            Left = 394
            Top = 0
            Width = 159
            Height = 249
            Align = alRight
            BevelOuter = bvNone
            BevelWidth = 5
            BiDiMode = bdLeftToRight
            Caption = 'Panel2'
            ParentBiDiMode = False
            TabOrder = 0
            object gridParams: TDBGridEh
              Left = 0
              Top = 0
              Width = 159
              Height = 249
              Align = alClient
              ColumnDefValues.AlwaysShowEditButton = True
              ColumnDefValues.Title.ToolTips = True
              ColumnDefValues.ToolTips = True
              DataSource = dsParams
              Flat = True
              FooterColor = clWindow
              FooterFont.Charset = DEFAULT_CHARSET
              FooterFont.Color = clWindowText
              FooterFont.Height = -11
              FooterFont.Name = 'Tahoma'
              FooterFont.Style = []
              OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -11
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = []
              UseMultiTitle = True
              VTitleMargin = 4
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'ParName'
                  Footers = <>
                  Title.Caption = 'Params|Name'
                  Width = 59
                  OnUpdateData = gridParamsColumns0UpdateData
                end
                item
                  DropDownRows = 37
                  EditButtons = <>
                  FieldName = 'ParType'
                  Footers = <>
                  PickList.Strings = (
                    'ftUnknown'
                    'ftString'
                    'ftFixedChar'
                    'ftMemo'
                    'ftAdt'
                    'ftSmallint'
                    'ftWord'
                    'ftAutoInc'
                    'ftInteger'
                    'ftTime'
                    'ftDate'
                    'ftDateTime'
                    'ftBCD'
                    'ftFMTBCD'
                    'ftCurrency'
                    'ftFloat'
                    'ftTimeStamp'
                    'ftBoolean'
                    'ftBytes'
                    'ftVarBytes'
                    'ftBlob'
                    'ftGraphic'
                    'ftTypedBinary'
                    'ftOraBlob'
                    'ftOraClob'
                    'ftArray'
                    'ftDataSet'
                    'ftReference'
                    'ftCursor')
                  Title.Caption = 'Params|Type'
                  Width = 51
                  OnUpdateData = gridParamsColumns0UpdateData
                end
                item
                  EditButtons = <>
                  FieldName = 'ParValue'
                  Footers = <>
                  Title.Caption = 'Params|Value'
                  Width = 29
                  OnUpdateData = gridParamsColumns0UpdateData
                end>
            end
            object Panel4: TPanel
              Left = 1
              Top = 1
              Width = 13
              Height = 14
              Caption = 'Panel8'
              TabOrder = 1
              object sbRefresh: TSpeedButton
                Left = 1
                Top = 1
                Width = 12
                Height = 13
                Hint = 'Refresh list of params'
                Anchors = [akLeft, akTop, akRight, akBottom]
                Flat = True
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000130B0000130B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
                  3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
                  3333333777333777FF33339993707399933333773337F3777FF3399933000339
                  9933377333777F3377F3399333707333993337733337333337FF993333333333
                  399377F33333F333377F993333303333399377F33337FF333373993333707333
                  333377F333777F333333993333101333333377F333777F3FFFFF993333000399
                  999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
                  99933773FF777F3F777F339993707399999333773F373F77777F333999999999
                  3393333777333777337333333999993333333333377777333333}
                NumGlyphs = 2
                ParentShowHint = False
                ShowHint = True
                Transparent = False
                OnClick = sbRefreshClick
              end
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 390
            Height = 249
            Align = alClient
            BevelOuter = bvNone
            BevelWidth = 5
            Caption = 'Panel3'
            TabOrder = 1
            object Image1: TImage
              Left = 5
              Top = 40
              Width = 10
              Height = 6
              AutoSize = True
              Picture.Data = {
                07544269746D6170A6000000424DA60000000000000076000000280000000A00
                000006000000010004000000000030000000CE0E0000C40E0000100000000000
                000000000000000080000080000000808000800000008000800080800000C0C0
                C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
                FF00333333333300000030999999030000003309999033000000333099033300
                000033330033330000003333333333000000}
              Transparent = True
              Visible = False
            end
            object Memo1: TMemo
              Left = 0
              Top = 25
              Width = 390
              Height = 224
              Align = alClient
              PopupMenu = PopupMenu1
              ScrollBars = ssBoth
              TabOrder = 0
              OnDragDrop = Memo1DragDrop
              OnDragOver = Memo1DragOver
              OnEnter = Memo1Enter
              OnExit = Memo1Exit
            end
            object Panel8: TPanel
              Left = 0
              Top = 0
              Width = 390
              Height = 25
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object spCut: TSpeedButton
                Left = 246
                Top = 2
                Width = 24
                Height = 24
                Action = EditCut1
                Flat = True
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  1800000000000003000000000000000000000000000000000000FF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FFA44108A44107A23F08FF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA23F08A44108A2
                  3F08A44108FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFA44107FF00FFFF00FFA23F08A23F08FF00FFA23F08A441
                  07FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA44107FF00FFFF
                  00FFA23F08FF00FFA23F08A23F08A23F08A44108FF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFA44108A23F08A23F08A23F08FF00FFA23F08FF00FFFF00
                  FFA44107FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA23F08A4
                  4107A44108A23F08A44108FF00FFFF00FFA23F08FF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FFFF00FF9E420E91471EA23F08A44107A44108A441
                  08A23F08FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF91
                  7E758E7B717C4E35A23F08A23F08A23F08FF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FF8E7C729C918D8E7C728E7C72FF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8E7C72C8BEBD8E
                  7C729D95918E7C72FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FF8E7C72D3CBCB8E7C729D9591C6BBB98E7C72FF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8E7C72D3CBCB8E7C72FF00FF8E
                  7C72D3CBCB8E7C72FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FF8E7C728E7C72FF00FFFF00FF8E7C72D3CBCB8E7C72FF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8E7C72FF00FFFF00FFFF00FF8E
                  7C72D3CBCB8E7C72FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFFF00FFFF00FF8E7C728E7C72FF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8E
                  7C72FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              end
              object sbCopy: TSpeedButton
                Left = 270
                Top = 2
                Width = 24
                Height = 24
                Action = EditCopy1
                Flat = True
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  1800000000000003000000000000000000000000000000000000FF00FFFF00FF
                  FF00FFFF00FFFF00FFA57873A57873A57873A57873A57873A57873A57873A578
                  73A578738C5D5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA97B75FCE3CAFD
                  E1C5FDDFC1FCDAB9FCDAB9F9D4B0F9D4B0F5CCA68C5D5CFF00FFFF00FFFF00FF
                  FF00FFFF00FFFF00FFAD7E75FAE6D4E5A556E5A556E5A556E5A556E5A556E5A5
                  56F9D4B08C5D5CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB5867AFBEEE2F9
                  E9D9FBE4CFFCE3CAFDE1C5FCDDBDFCDAB9F9D4B08C5D5CFF00FFA57873A57873
                  A57873A57873A57873BA8C7DFBF1E7E5A556E5A556E5A556E5A556E5A556E5A5
                  56FCDAB98C5D5CFF00FFA97B75FCE3CAFDE1C5FDDFC1FCDAB9BD9184FDF5EDFB
                  F1E7FBEEE2F9E9D9FAE6D4FCE3CAFDE1C5FDDFC18C5D5CFF00FFAD7E75FAE6D4
                  E5A556E5A556E5A556BD9184FEF9F3E5A556E5A556E5A556E5A556E5A556E5A5
                  56FCE3CA8C5D5CFF00FFB5867AFBEEE2F9E9D9FBE4CFFCE3CADEAB84FEFBF9FE
                  F9F5FDF7F0FCF4EAFBF1E7FBEEE2F9E9D9FAE5D18C5D5CFF00FFBA8C7DFBF1E7
                  E5A556E5A556E5A556DEAB84FEFBF9FEFBF9FEF9F5FEF9F3FDF5EDF9E9D9ECC5
                  A2BD91848C5D5CFF00FFBD9184FDF5EDFBF1E7FBEEE2F9E9D9E2B18AFEFBF9FE
                  FBF9FEFBF9FEFBF8FEF9F3B28176B28176B28176B07F75FF00FFBD9184FEF9F3
                  E5A556E5A556E5A556E5B68EFEFBF9FEFBF9FEFBF9FEFBF9FEFBF8B28176E5AE
                  70E4A353FF00FFFF00FFDEAB84FEFBF9FEF9F5FDF7F0FCF4EAE5B68EDEAB84DE
                  AB84DEAB84DEAB84DEAB84B28176E8AB5EFF00FFFF00FFFF00FFDEAB84FEFBF9
                  FEFBF9FEF9F5FEF9F3FDF5EDF9E9D9ECC5A2BD91848C5D5CFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFE2B18AFEFBF9FEFBF9FEFBF9FEFBF8FEF9F3B28176B2
                  8176B28176B07F75FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE5B68EFEFBF9
                  FEFBF9FEFBF9FEFBF9FEFBF8B28176E5AE70E4A353FF00FFFF00FFFF00FFFF00
                  FFFF00FFFF00FFFF00FFE5B68EDEAB84DEAB84DEAB84DEAB84DEAB84B28176E8
                  AB5EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              end
              object spPaste: TSpeedButton
                Left = 294
                Top = 2
                Width = 24
                Height = 24
                Action = EditPaste1
                Flat = True
                Glyph.Data = {
                  36030000424D3603000000000000360000002800000010000000100000000100
                  1800000000000003000000000000000000000000000000000000FF00FFFF00FF
                  00669A00669A00669AA37F77A37F77A37F77A37F77A37F77A37F77A37F77A37F
                  77A37F778F6261FF00FFFF00FF00669A4BC3E44BC3E44BC3E4B38476F7ECDEFA
                  F1E7F8EEE1F7ECDEF7ECDEF7ECDEF7ECDEF7ECDE8F6261FF00FFFF00FF00669A
                  4AC5E64BC3E44BC3E4B38476F5E7D8E3A55BE4A559E4A559E4A559E4A559E4A5
                  59F5E3D18F6261FF00FFFF00FF00669A4CC7E94AC5E64BC3E4B98775F7ECDEF5
                  E4D2EFDCC9EFDCC9EFDCC9EBD8C6EFDCC9F5E4D28F6261FF00FFFF00FF00669A
                  57CDED50C9EA4AC5E6B98775F9EFE4E3A55BE4A559E4A559E4A559E4A559E4A5
                  59F5E5D58F6261FF00FFFF00FF00669A5DD1EF57CDED53CBEBC18C72FAF2E9F7
                  ECDEF5E4D2F5E4D2F5E3D1F3E1CDF5E4D2F5E9DB8F6261FF00FFFF00FF00669A
                  65D6F261D4F15BD0EEC6906FFAF4EEE3A55BE4A559E4A559E4A559E4A559E4A5
                  59F9EEE28F6261FF00FFFF00FF00669A6DDBF569D9F461D4F1C6906FFBF8F4FB
                  F6F2F9F0E6F9EFE4F8EEE1F9EEE2F9F0E6F5E9DB8F6261FF00FFFF00FF00669A
                  75DFF871DDF669D9F4D5A589FBF8F4FCFAF9FCFAF9FCFAF9FCFAF9B38476B384
                  76B38476B38476FF00FFFF00FF00669A7CE2F978E1F971DDF6D5A589FCFAF8FC
                  FAF9FCFAF9FCFAF9FCFAF9B38476DDA572E2A45BFF00FFFF00FFFF00FF00669A
                  7EE3F97CE2F978E1F9D5A589D9A682D9A682D9A682D9A682D9A682B38476C6AE
                  9A00669AFF00FFFF00FFFF00FF00669A88E5F97EE3F97EE3F97EE3F978E1F975
                  DFF86DDBF565D6F25DD1EF57CDED53CBEB00669AFF00FFFF00FFFF00FF00669A
                  88E5F988E5F973727273727273727273727273727273727273727261D4F15BD0
                  EE00669AFF00FFFF00FFFF00FF00669A88E5F988E5F9737272D1C5BAD1C5BAD1
                  C5BAD1C5BAC9BFB673727269D9F461D4F100669AFF00FFFF00FFFF00FFFF00FF
                  00669A00669A737272EBD8C6FAFAF9FCF9F7FCF9F7D1C5BA73727200669A0066
                  9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF73727273727273
                  7272737272737272FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              end
              object sbSelectAll: TSpeedButton
                Left = 318
                Top = 2
                Width = 24
                Height = 24
                Action = EditSelectAll1
                Flat = True
                Glyph.Data = {
                  36040000424D3604000000000000360000002800000010000000100000000100
                  2000000000000004000000000000000000000000000000000000FF00FF00FF00
                  FF00694731006947310069473100694731006947310069473100694731006947
                  31006947310069473100694731006947310069473100FF00FF00FF00FF00C3AE
                  9F00F5F0ED00B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
                  9300B7A29300B7A29300B7A29300000FB600B7A2930069473100FF00FF00C3AE
                  9F00F7F4F100F5F0ED00F2ECE800EFE8E300EDE4DF00EAE0DA00E7DBD500E4D7
                  D000E2D3CB00DFCFC600DCCBC1000018C800B7A2930069473100FF00FF00C3AE
                  9F00FAF8F6009830000098300000F2ECE8009830000098300000EAE0DA009830
                  0000983000000030F800002CF0000022DC000018C8000014C000FF00FF00C3AE
                  9F00FDFCFB00FAF8F600F7F4F100F5F0ED00F2ECE800EFE8E300EDE4DF00EAE0
                  DA00E7DBD500E4D7D00098300000002CF000B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF0098300000FCFAF900E4CBBF00A2451A0098300000B16440009830
                  000098300000E7DBD500E4D7D0000030F800B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF0098300000FEFEFD00B66C4A0098300000EBDAD200E4CEC3009830
                  000098300000EBE2DD0098300000E4D7D000B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF00FFFFFF00FFFFFF00BD7A5B0098300000D8B2A100F0E7E1009830
                  000098300000EEE6E10098300000E9DED800B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF0098300000FFFFFF00F6ECE800C2846700A85027009B3608009830
                  000098300000F1EAE600EEE6E100EBE2DD00B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF0098300000FFFFFF00FFFFFF00FFFFFF00FEFEFD00EAD5CB009830
                  00009F3F1300F3EEEA0098300000EEE6E100B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A3471C009830000098300000A850
                  2700DBB9A800F6F2EF0098300000F1EAE600B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF0098300000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFE
                  FD00FCFAF900F9F6F400F6F2EF00F3EEEA00B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF0098300000FFFFFF009830000098300000FFFFFF00983000009830
                  0000FFFFFF009830000098300000F7F4F100B7A2930069473100FF00FF00C3AE
                  9F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                  FF00FFFFFF00FFFFFF00FDFCFB00FAF8F600F7F4F10069473100FF00FF00FF00
                  FF00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE
                  9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                  FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
              end
              object bExecute: TButton
                Left = 0
                Top = 2
                Width = 77
                Height = 24
                Caption = '&Execute'
                TabOrder = 0
                OnClick = bExecuteClick
              end
              object bCheck: TButton
                Left = 77
                Top = 2
                Width = 77
                Height = 24
                Caption = 'C&heck'
                TabOrder = 1
              end
              object bQueryPlan: TButton
                Left = 154
                Top = 2
                Width = 77
                Height = 24
                Caption = 'Query &plan'
                TabOrder = 2
                OnClick = bQueryPlanClick
              end
            end
          end
          object Panel9: TPanel
            Left = 536
            Top = 1
            Width = 16
            Height = 16
            Anchors = [akTop, akRight]
            Caption = 'Panel8'
            TabOrder = 2
            object SpeedButton2: TSpeedButton
              Left = 1
              Top = 1
              Width = 14
              Height = 15
              Anchors = [akLeft, akTop, akRight, akBottom]
              Flat = True
              Glyph.Data = {
                B6000000424DB600000000000000760000002800000010000000080000000100
                0400000000004000000000000000000000001000000000000000000000000000
                8000008000000080800080000000800080008080000080808000C0C0C0000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0FFFFFF0FFFFFFF00FFFFFF00FFFFF000FFFFFF000FFFF000FFFFFF0
                00FFFFF00FFFFFF00FFFFFFF0FFFFFF0FFFFFFFFFFFFFFFFFFFF}
              NumGlyphs = 2
              Transparent = False
              OnClick = sbHideShowClick
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Insert'
          ImageIndex = 1
          inline FrameInsertSQL: TSQLEditFrame
            Width = 553
            Height = 249
            Align = alClient
            inherited Panel1: TPanel
              Width = 553
              Height = 249
              inherited Splitter2: TSplitter
                Left = 342
                Height = 249
              end
              inherited Panel4: TPanel
                Width = 342
                Height = 249
                inherited RichEdit1: TRichEdit
                  Width = 342
                  Height = 224
                end
                inherited Panel5: TPanel
                  Width = 342
                end
              end
              inherited Panel3: TPanel
                Left = 348
                Height = 249
                inherited gridParams: TDBGridEh
                  Height = 357
                  FooterFont.Name = 'Tahoma'
                  TitleFont.Name = 'Tahoma'
                end
              end
            end
            inherited Panel8: TPanel
              Left = 534
            end
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'Update'
          ImageIndex = 2
          inline FrameUpdateSQL: TSQLEditFrame
            Width = 553
            Height = 249
            Align = alClient
            inherited Panel1: TPanel
              Width = 553
              Height = 249
              inherited Splitter2: TSplitter
                Left = 342
                Height = 249
              end
              inherited Panel4: TPanel
                Width = 342
                Height = 249
                inherited RichEdit1: TRichEdit
                  Width = 342
                  Height = 224
                end
                inherited Panel5: TPanel
                  Width = 342
                end
              end
              inherited Panel3: TPanel
                Left = 348
                Height = 249
                inherited gridParams: TDBGridEh
                  Height = 357
                  FooterFont.Name = 'Tahoma'
                  TitleFont.Name = 'Tahoma'
                end
              end
            end
            inherited Panel8: TPanel
              Left = 534
            end
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Delete'
          ImageIndex = 3
          inline FrameDeleteSQL: TSQLEditFrame
            Width = 553
            Height = 249
            Align = alClient
            inherited Panel1: TPanel
              Width = 553
              Height = 249
              inherited Splitter2: TSplitter
                Left = 342
                Height = 249
              end
              inherited Panel4: TPanel
                Width = 342
                Height = 249
                inherited RichEdit1: TRichEdit
                  Width = 342
                  Height = 224
                end
                inherited Panel5: TPanel
                  Width = 342
                end
              end
              inherited Panel3: TPanel
                Left = 348
                Height = 249
                inherited gridParams: TDBGridEh
                  Height = 357
                  FooterFont.Name = 'Tahoma'
                  TitleFont.Name = 'Tahoma'
                end
              end
            end
            inherited Panel8: TPanel
              Left = 534
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'GetRec'
          ImageIndex = 4
          inline FrameGetRecSQL: TSQLEditFrame
            Width = 553
            Height = 249
            Align = alClient
            inherited Panel1: TPanel
              Width = 553
              Height = 249
              inherited Splitter2: TSplitter
                Left = 342
                Height = 249
              end
              inherited Panel4: TPanel
                Width = 342
                Height = 249
                inherited RichEdit1: TRichEdit
                  Width = 342
                  Height = 224
                end
                inherited Panel5: TPanel
                  Width = 342
                end
              end
              inherited Panel3: TPanel
                Left = 348
                Height = 249
                inherited gridParams: TDBGridEh
                  Height = 357
                  FooterFont.Name = 'Tahoma'
                  TitleFont.Name = 'Tahoma'
                end
              end
            end
            inherited Panel8: TPanel
              Left = 534
            end
          end
        end
        object tsSpecParams: TTabSheet
          Caption = 'Other'
          ImageIndex = 5
          object Panel11: TPanel
            Left = 274
            Top = 0
            Width = 279
            Height = 249
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            object Label1: TLabel
              Left = 10
              Top = 187
              Width = 63
              Height = 13
              Caption = 'Update fields'
            end
            object Label2: TLabel
              Left = 10
              Top = 116
              Width = 46
              Height = 13
              Caption = 'Key fields'
            end
            object Bevel1: TBevel
              Left = 80
              Top = 192
              Width = 193
              Height = 2
            end
            object Bevel2: TBevel
              Left = 63
              Top = 123
              Width = 210
              Height = 2
            end
            object Label3: TLabel
              Left = 10
              Top = 72
              Width = 62
              Height = 13
              Caption = 'Update table'
            end
            object Bevel3: TBevel
              Left = 80
              Top = 79
              Width = 192
              Height = 2
            end
            object Bevel5: TBevel
              Left = 4
              Top = 6
              Width = 2
              Height = 352
            end
            object MemoUpdateFields: TMemo
              Left = 10
              Top = 202
              Width = 263
              Height = 50
              Anchors = [akLeft, akTop, akBottom]
              ScrollBars = ssVertical
              TabOrder = 0
            end
            object MemoKeyFields: TMemo
              Left = 10
              Top = 133
              Width = 264
              Height = 47
              ScrollBars = ssVertical
              TabOrder = 1
            end
            object dbeUpdateTable: TDBEditEh
              Left = 10
              Top = 89
              Width = 263
              Height = 21
              EditButtons = <>
              ShowHint = True
              TabOrder = 2
              Text = 'TableName'
              Visible = True
            end
            object GroupBox1: TGroupBox
              Left = 10
              Top = -2
              Width = 264
              Height = 69
              Caption = ' Dinamic generation '
              TabOrder = 3
              object cbDinaDeleteSQL: TCheckBox
                Left = 10
                Top = 49
                Width = 248
                Height = 14
                Caption = 'Dinamic delete SQL'
                TabOrder = 0
              end
              object cbDinaInsertSQL: TCheckBox
                Left = 10
                Top = 32
                Width = 248
                Height = 13
                Caption = 'Dinamic insert SQL'
                TabOrder = 1
              end
              object cbDinaUpdateSQL: TCheckBox
                Left = 10
                Top = 15
                Width = 249
                Height = 14
                Caption = 'Dinamic update SQL'
                TabOrder = 2
              end
            end
          end
          object Panel12: TPanel
            Left = 0
            Top = 0
            Width = 274
            Height = 249
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel12'
            TabOrder = 1
            object mSpecParams: TMemo
              Left = 0
              Top = 26
              Width = 274
              Height = 223
              Align = alClient
              TabOrder = 0
            end
            object Panel10: TPanel
              Left = 0
              Top = 0
              Width = 274
              Height = 26
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 1
              object Label4: TLabel
                Left = 3
                Top = 7
                Width = 58
                Height = 13
                Caption = 'SpecParams'
              end
              object Bevel4: TBevel
                Left = 72
                Top = 14
                Width = 133
                Height = 2
              end
              object bLoadSpecString: TButton
                Left = 209
                Top = 2
                Width = 66
                Height = 24
                Caption = 'Load list'
                TabOrder = 0
                OnClick = bLoadSpecStringClick
              end
            end
          end
        end
      end
      object bBuildUpdates: TButton
        Left = 349
        Top = 1
        Width = 79
        Height = 22
        Caption = 'Build updates'
        TabOrder = 1
        OnClick = bBuildUpdatesClick
      end
    end
  end
  object MemTableEh1: TMemTableEh
    Params = <>
    AfterOpen = MemTableEh1AfterOpen
    Left = 6
    Top = 319
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 34
    Top = 319
  end
  object mtParams: TMemTableEh
    Active = True
    CachedUpdates = True
    Params = <>
    Left = 452
    Top = 222
    object mtParamsParName: TStringField
      DisplayWidth = 10
      FieldName = 'ParName'
      Size = 255
    end
    object mtParamsParType: TStringField
      DefaultExpression = 'ftString'
      DisplayWidth = 13
      FieldName = 'ParType'
      Size = 255
    end
    object mtParamsParValue: TStringField
      DisplayWidth = 14
      FieldName = 'ParValue'
      Size = 255
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object ParName: TMTStringDataFieldEh
          FieldName = 'ParName'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 255
          Transliterate = False
        end
        object ParType: TMTStringDataFieldEh
          FieldName = 'ParType'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 255
          Transliterate = False
        end
        object ParValue: TMTStringDataFieldEh
          FieldName = 'ParValue'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 255
          Transliterate = False
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object dsParams: TDataSource
    DataSet = mtParams
    Left = 424
    Top = 222
  end
  object mtTreeDetail: TMemTableEh
    Params = <>
    Left = 12
    Top = 247
  end
  object dsTreeDetail: TDataSource
    Left = 40
    Top = 247
  end
  object PopupMenu1: TPopupMenu
    Left = 248
    Top = 162
    object Ggg1: TMenuItem
      Caption = ' '
      OnClick = Ggg1Click
    end
  end
  object dsDBTree: TDataSource
    DataSet = mtDBTree
    OnDataChange = dsDBTreeDataChange
    Left = 8
    Top = 156
  end
  object mtDBTree: TMemTableEh
    Active = True
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftAutoInc
      end
      item
        Name = 'RefParent'
        DataType = ftInteger
      end
      item
        Name = 'Name'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'ChieldCount'
        DataType = ftInteger
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'RefData'
      end
      item
        Name = 'ImageIndex'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 38
    Top = 156
    object mtDBTreeId: TAutoIncField
      FieldName = 'Id'
    end
    object mtDBTreeRefParent: TIntegerField
      FieldName = 'RefParent'
    end
    object mtDBTreeName: TStringField
      FieldName = 'Name'
      Size = 500
    end
    object mtDBTreeChieldCount: TIntegerField
      FieldName = 'ChieldCount'
    end
    object mtDBTreeDescription: TStringField
      FieldName = 'Description'
      Size = 500
    end
    object mtDBTreeRefData: TRefObjectField
      FieldName = 'RefData'
    end
    object mtDBTreeImageIndex: TIntegerField
      FieldName = 'ImageIndex'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object Id: TMTNumericDataFieldEh
          FieldName = 'Id'
          NumericDataType = fdtAutoIncEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          currency = False
          Precision = 0
        end
        object RefParent: TMTNumericDataFieldEh
          FieldName = 'RefParent'
          NumericDataType = fdtIntegerEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          currency = False
          Precision = 0
        end
        object Name: TMTStringDataFieldEh
          FieldName = 'Name'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 500
          Transliterate = False
        end
        object ChieldCount: TMTNumericDataFieldEh
          FieldName = 'ChieldCount'
          NumericDataType = fdtIntegerEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          currency = False
          Precision = 0
        end
        object Description: TMTStringDataFieldEh
          FieldName = 'Description'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 500
          Transliterate = False
        end
        object RefData: TMTRefObjectFieldEh
          FieldName = 'RefData'
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
        end
        object ImageIndex: TMTNumericDataFieldEh
          FieldName = 'ImageIndex'
          NumericDataType = fdtIntegerEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          currency = False
          Precision = 0
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 437
    Top = 150
    object EditCut1: TEditCut
      Category = 'Edit'
      Enabled = False
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditCopy1: TEditCopy
      Category = 'Edit'
      Enabled = False
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Hint = 'Select All|Selects the entire document'
      ImageIndex = 3
      ShortCut = 16449
    end
  end
  object ImageList1: TImageList
    Left = 441
    Top = 182
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A4410800A4410700A23F080000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5787300A5787300A5787300A5787300A5787300A5787300A578
      7300A5787300A57873008C5D5C0000000000000000000000000000669A000066
      9A0000669A00A37F7700A37F7700A37F7700A37F7700A37F7700A37F7700A37F
      7700A37F7700A37F77008F626100000000000000000000000000694731006947
      3100694731006947310069473100694731006947310069473100694731006947
      3100694731006947310069473100000000000000000000000000000000000000
      000000000000A23F0800A4410800A23F0800A441080000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A97B7500FCE3CA00FDE1C500FDDFC100FCDAB900FCDAB900F9D4
      B000F9D4B000F5CCA6008C5D5C00000000000000000000669A004BC3E4004BC3
      E4004BC3E400B3847600F7ECDE00FAF1E700F8EEE100F7ECDE00F7ECDE00F7EC
      DE00F7ECDE00F7ECDE008F6261000000000000000000C3AE9F00F5F0ED00B7A2
      9300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A29300B7A2
      9300B7A29300000FB600B7A29300694731000000000000000000000000000000
      000000000000A44107000000000000000000A23F0800A23F080000000000A23F
      0800A44107000000000000000000000000000000000000000000000000000000
      000000000000AD7E7500FAE6D400E5A55600E5A55600E5A55600E5A55600E5A5
      5600E5A55600F9D4B0008C5D5C00000000000000000000669A004AC5E6004BC3
      E4004BC3E400B3847600F5E7D800E3A55B00E4A55900E4A55900E4A55900E4A5
      5900E4A55900F5E3D1008F6261000000000000000000C3AE9F00F7F4F100F5F0
      ED00F2ECE800EFE8E300EDE4DF00EAE0DA00E7DBD500E4D7D000E2D3CB00DFCF
      C600DCCBC1000018C800B7A29300694731000000000000000000000000000000
      000000000000A44107000000000000000000A23F080000000000A23F0800A23F
      0800A23F0800A441080000000000000000000000000000000000000000000000
      000000000000B5867A00FBEEE200F9E9D900FBE4CF00FCE3CA00FDE1C500FCDD
      BD00FCDAB900F9D4B0008C5D5C00000000000000000000669A004CC7E9004AC5
      E6004BC3E400B9877500F7ECDE00F5E4D200EFDCC900EFDCC900EFDCC900EBD8
      C600EFDCC900F5E4D2008F6261000000000000000000C3AE9F00FAF8F6009830
      000098300000F2ECE8009830000098300000EAE0DA0098300000983000000030
      F800002CF0000022DC000018C8000014C0000000000000000000000000000000
      000000000000A4410800A23F0800A23F0800A23F080000000000A23F08000000
      000000000000A44107000000000000000000A5787300A5787300A5787300A578
      7300A5787300BA8C7D00FBF1E700E5A55600E5A55600E5A55600E5A55600E5A5
      5600E5A55600FCDAB9008C5D5C00000000000000000000669A0057CDED0050C9
      EA004AC5E600B9877500F9EFE400E3A55B00E4A55900E4A55900E4A55900E4A5
      5900E4A55900F5E5D5008F6261000000000000000000C3AE9F00FDFCFB00FAF8
      F600F7F4F100F5F0ED00F2ECE800EFE8E300EDE4DF00EAE0DA00E7DBD500E4D7
      D00098300000002CF000B7A29300694731000000000000000000000000000000
      00000000000000000000A23F0800A4410700A4410800A23F0800A44108000000
      000000000000A23F08000000000000000000A97B7500FCE3CA00FDE1C500FDDF
      C100FCDAB900BD918400FDF5ED00FBF1E700FBEEE200F9E9D900FAE6D400FCE3
      CA00FDE1C500FDDFC1008C5D5C00000000000000000000669A005DD1EF0057CD
      ED0053CBEB00C18C7200FAF2E900F7ECDE00F5E4D200F5E4D200F5E3D100F3E1
      CD00F5E4D200F5E9DB008F6261000000000000000000C3AE9F00FFFFFF009830
      0000FCFAF900E4CBBF00A2451A0098300000B16440009830000098300000E7DB
      D500E4D7D0000030F800B7A29300694731000000000000000000000000000000
      00000000000000000000000000009E420E0091471E00A23F0800A4410700A441
      0800A4410800A23F08000000000000000000AD7E7500FAE6D400E5A55600E5A5
      5600E5A55600BD918400FEF9F300E5A55600E5A55600E5A55600E5A55600E5A5
      5600E5A55600FCE3CA008C5D5C00000000000000000000669A0065D6F20061D4
      F1005BD0EE00C6906F00FAF4EE00E3A55B00E4A55900E4A55900E4A55900E4A5
      5900E4A55900F9EEE2008F6261000000000000000000C3AE9F00FFFFFF009830
      0000FEFEFD00B66C4A0098300000EBDAD200E4CEC3009830000098300000EBE2
      DD0098300000E4D7D000B7A29300694731000000000000000000000000000000
      0000000000000000000000000000917E75008E7B71007C4E3500A23F0800A23F
      0800A23F0800000000000000000000000000B5867A00FBEEE200F9E9D900FBE4
      CF00FCE3CA00DEAB8400FEFBF900FEF9F500FDF7F000FCF4EA00FBF1E700FBEE
      E200F9E9D900FAE5D1008C5D5C00000000000000000000669A006DDBF50069D9
      F40061D4F100C6906F00FBF8F400FBF6F200F9F0E600F9EFE400F8EEE100F9EE
      E200F9F0E600F5E9DB008F6261000000000000000000C3AE9F00FFFFFF00FFFF
      FF00FFFFFF00BD7A5B0098300000D8B2A100F0E7E1009830000098300000EEE6
      E10098300000E9DED800B7A29300694731000000000000000000000000000000
      000000000000000000008E7C72009C918D008E7C72008E7C7200000000000000
      000000000000000000000000000000000000BA8C7D00FBF1E700E5A55600E5A5
      5600E5A55600DEAB8400FEFBF900FEFBF900FEF9F500FEF9F300FDF5ED00F9E9
      D900ECC5A200BD9184008C5D5C00000000000000000000669A0075DFF80071DD
      F60069D9F400D5A58900FBF8F400FCFAF900FCFAF900FCFAF900FCFAF900B384
      7600B3847600B3847600B38476000000000000000000C3AE9F00FFFFFF009830
      0000FFFFFF00F6ECE800C2846700A85027009B3608009830000098300000F1EA
      E600EEE6E100EBE2DD00B7A29300694731000000000000000000000000000000
      0000000000008E7C7200C8BEBD008E7C72009D9591008E7C7200000000000000
      000000000000000000000000000000000000BD918400FDF5ED00FBF1E700FBEE
      E200F9E9D900E2B18A00FEFBF900FEFBF900FEFBF900FEFBF800FEF9F300B281
      7600B2817600B2817600B07F7500000000000000000000669A007CE2F90078E1
      F90071DDF600D5A58900FCFAF800FCFAF900FCFAF900FCFAF900FCFAF900B384
      7600DDA57200E2A45B00000000000000000000000000C3AE9F00FFFFFF009830
      0000FFFFFF00FFFFFF00FFFFFF00FEFEFD00EAD5CB00983000009F3F1300F3EE
      EA0098300000EEE6E100B7A29300694731000000000000000000000000000000
      00008E7C7200D3CBCB008E7C72009D959100C6BBB9008E7C7200000000000000
      000000000000000000000000000000000000BD918400FEF9F300E5A55600E5A5
      5600E5A55600E5B68E00FEFBF900FEFBF900FEFBF900FEFBF900FEFBF800B281
      7600E5AE7000E4A3530000000000000000000000000000669A007EE3F9007CE2
      F90078E1F900D5A58900D9A68200D9A68200D9A68200D9A68200D9A68200B384
      7600C6AE9A0000669A00000000000000000000000000C3AE9F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A3471C009830000098300000A8502700DBB9A800F6F2
      EF0098300000F1EAE600B7A29300694731000000000000000000000000008E7C
      7200D3CBCB008E7C7200000000008E7C7200D3CBCB008E7C7200000000000000
      000000000000000000000000000000000000DEAB8400FEFBF900FEF9F500FDF7
      F000FCF4EA00E5B68E00DEAB8400DEAB8400DEAB8400DEAB8400DEAB8400B281
      7600E8AB5E000000000000000000000000000000000000669A0088E5F9007EE3
      F9007EE3F9007EE3F90078E1F90075DFF8006DDBF50065D6F2005DD1EF0057CD
      ED0053CBEB0000669A00000000000000000000000000C3AE9F00FFFFFF009830
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFD00FCFAF900F9F6
      F400F6F2EF00F3EEEA00B7A29300694731000000000000000000000000008E7C
      72008E7C720000000000000000008E7C7200D3CBCB008E7C7200000000000000
      000000000000000000000000000000000000DEAB8400FEFBF900FEFBF900FEF9
      F500FEF9F300FDF5ED00F9E9D900ECC5A200BD9184008C5D5C00000000000000
      0000000000000000000000000000000000000000000000669A0088E5F90088E5
      F9007372720073727200737272007372720073727200737272007372720061D4
      F1005BD0EE0000669A00000000000000000000000000C3AE9F00FFFFFF009830
      0000FFFFFF009830000098300000FFFFFF009830000098300000FFFFFF009830
      000098300000F7F4F100B7A29300694731000000000000000000000000008E7C
      72000000000000000000000000008E7C7200D3CBCB008E7C7200000000000000
      000000000000000000000000000000000000E2B18A00FEFBF900FEFBF900FEFB
      F900FEFBF800FEF9F300B2817600B2817600B2817600B07F7500000000000000
      0000000000000000000000000000000000000000000000669A0088E5F90088E5
      F90073727200D1C5BA00D1C5BA00D1C5BA00D1C5BA00C9BFB6007372720069D9
      F40061D4F10000669A00000000000000000000000000C3AE9F00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FDFCFB00FAF8F600F7F4F100694731000000000000000000000000000000
      00000000000000000000000000008E7C72008E7C720000000000000000000000
      000000000000000000000000000000000000E5B68E00FEFBF900FEFBF900FEFB
      F900FEFBF900FEFBF800B2817600E5AE7000E4A3530000000000000000000000
      000000000000000000000000000000000000000000000000000000669A000066
      9A0073727200EBD8C600FAFAF900FCF9F700FCF9F700D1C5BA00737272000066
      9A0000669A000000000000000000000000000000000000000000C3AE9F00C3AE
      9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE9F00C3AE
      9F00C3AE9F00C3AE9F00C3AE9F00000000000000000000000000000000000000
      00000000000000000000000000008E7C72000000000000000000000000000000
      000000000000000000000000000000000000E5B68E00DEAB8400DEAB8400DEAB
      8400DEAB8400DEAB8400B2817600E8AB5E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007372720073727200737272007372720073727200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FC7FF801C001C001F87FF80180018000
      FB27F80180018000FB43F80180018000F85B000180018000FC1B000180018000
      FE03000180018000FE07000180018000FC3F000180018000F83F000180038000
      F03F000380038000E23F000780038000E63F003F80038000EE3F003F80038000
      FE7F007FC007C001FEFF00FFF83FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList2: TImageList
    Left = 120
    Top = 192
    Bitmap = {
      494C010105000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000007777770077777700393939003939
      3900393939003939390077777700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000077777700CCFFFF0039393900CCFFFF00CCFF
      FF00CCFFFF00CCFFFF0039393900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077777700CCFFFF00CCFFFF0039393900CCFFFF007777
      770077777700CCFFFF0039393900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000292929002929
      2900292929005F5F5F0090A9AD00CCFFFF00CCFFFF0039393900CCFFFF00CCFF
      FF00CCFFFF00CCFFFF0039393900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029292900DDDDDD00DDDD
      DD00C0C0C00096969600C0DCC00090A9AD00CCFFFF0039393900CCFFFF007777
      7700393939003939390039393900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000029292900F0CAA600F8F8F8000000
      0000A4A0A000E3E3E300C0DCC000C0C0C00090A9AD0039393900CCFFFF00CCFF
      FF0039393900CCFFFF0039393900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000029292900F0CAA600F1F1F1000000
      000099999900D6E7E700C0DCC000C0C0C00090A9AD0077777700393939003939
      3900393939003939390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000029292900F0CAA600F1F1F100A4A0
      A000EAEAEA00E3E3E300C0DCC000C0C0C00090A9AD00CCFFFF00999999009999
      9900999999000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000029292900F0CAA600F1F1F100A4A0
      A000999999009696960077777700666666005F5F5F0077777700777777000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000029292900FFECCC00F8F8F8000000
      0000FFECCC00CCCC990099996600666633002929290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000029292900CCCCCC00292929002929
      2900292929002929290029292900666633002929290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000292929002929290096969600CCCC
      9900CCCCCC00CC99660066330000292929002929290000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000029292900D7D7D700F8F8
      F800F8F8F800FFECCC00CC996600292929000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000292929002929
      2900292929002929290029292900000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000006666
      6600424242004242420042424200424242004242420042424200424242006666
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099660000666600006666000066660000666600006666
      0000666600006666000099660000000000000000000042424200424242004242
      4200424242004242420042424200999999000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000990000009900000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF004242
      4200000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0CAA600CCFFFF00CCFFFF00CCFFFF0066660000CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000099999900000000000000
      0000000000000000000000000000424242009966000066660000666600006666
      0000666600006666000099660000000000000000000000000000000000000000
      000077777700393939003939390039393900393939000099000066CC33000099
      0000000000000000000000000000000000000000000066666600424242004242
      4200CCFFFF004242420042424200CCFFFF004242420042424200CCFFFF004242
      4200000000000000000000000000000000000000000000000000000000000000
      00000000000039393900F0CAA600CCFFFF0066660000CCFFFF0066660000CCFF
      FF0066660000CCFFFF0066660000000000000000000099999900000000004242
      420000000000000000000000000042424200CCFFFF00CCFFFF00CCFFFF00CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000000000000000000000000
      000039393900CCFFFF00CCFFFF00CCFFFF00CCFFFF000099000066CC330066CC
      3300009900000000000000000000000000000000000042424200CCFFFF004242
      4200CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF004242
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000003939390039393900CCFFFF00CCFFFF00CCFFFF0066660000CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000099999900000000004242
      420099999900424242000000000042424200CCFFFF00CCFFFF00CCFFFF00CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000000000000000000005555
      550039393900CCFFFF007777770077777700777777000099000066CC330066CC
      330066CC33000099000000000000000000000000000042424200CCFFFF004242
      4200CCFFFF004242420042424200CCFFFF004242420042424200CCFFFF004242
      42005F5F5F000000000000000000000000000000000039393900393939003939
      39003939390039393900393939003939390066660000CCFFFF0066660000CCFF
      FF0066660000CCFFFF0066660000000000000000000099999900000000000000
      000042424200424242000000000042424200CCFFFF0066660000666600006666
      000066660000CCFFFF006666000000000000000000000000000055555500DDDD
      DD0039393900CCFFFF00CCFFFF00CCFFFF00CCFFFF000099000066CC330066CC
      3300C0DCC0006699330000000000000000000000000042424200CCFFFF004242
      4200F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA6004242
      4200999933002929290000000000000000000000000039393900FFECCC00FFEC
      CC00FFECCC003939390039393900CCFFFF00CCFFFF00CCFFFF0066660000CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000099999900000000000000
      000000000000000000000000000042424200CCFFFF00CCFFFF00CCFFFF00CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000055555500F0CAA600F8F8
      F80039393900CCFFFF007777770077777700777777000099000066CC3300C0DC
      C000669933000000000000000000000000000000000042424200CCFFFF009966
      0000666600006666000066660000666600006666000066660000666600009966
      0000999933002929290000000000000000000000000039393900FFECCC00CC99
      6600F0CAA60039393900F0CAA600CCFFFF0066660000CCFFFF0066660000CCFF
      FF0066660000CCFFFF0066660000000000000000000099999900999999009999
      990099999900999999009999990042424200CCFFFF0066660000666600006666
      000066660000CCFFFF0066660000000000000000000055555500F0CAA600F1F1
      F10039393900CCFFFF00CCFFFF00CCFFFF00CCFFFF0000990000C0DCC0006699
      3300000000000000000000000000000000000000000042424200F0CAA600F0CA
      A600F0CAA600F0CAA600F0CAA600F0CAA600F0CAA60042424200FFECCC00CCCC
      9900666633002929290000000000000000000000000039393900FFECCC009999
      6600CCCC9900FFECCC00F0CAA600CCFFFF00CCFFFF00CCFFFF0066660000CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000000000000000000009966
      0000CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000055555500F0CAA600F1F1
      F100777777003939390039393900393939003939390000990000669933000000
      0000000000000000000000000000000000000000000099660000666600006666
      0000666600006666000066660000666600006666000099660000FFECCC009999
      6600666633002929290000000000000000000000000096969600999966009999
      3300CCCC9900FFECCC0066660000666600006666000066660000666600006666
      0000666600006666000066660000000000000000000000000000000000006666
      0000CCFFFF0066660000CCFFFF00CCFFFF006666000066660000666600006666
      000066660000CCFFFF0066660000000000000000000055555500F0CAA600F1F1
      F10000000000FFECCC00FFECCC00F0CAA6009999660086868600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005F5F5F00FFECCC00F8F8F80000000000FFECCC00CCCC99009999
      6600666633002929290000000000000000000000000055555500999966009999
      6600CCCC9900FFECCC0099660000666600006666000066660000666600006666
      0000666600006666000099660000000000000000000000000000000000006666
      0000CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000055555500FFECCC00F8F8
      F80000000000FFECCC00CCCC9900999966006666330055555500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000029292900FFECCC00292929002929290029292900292929002929
      2900666633002929290000000000000000000000000055555500999966009999
      6600CCCC9900FFECCC0000000000F8F8F800FFECCC0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      0000CCFFFF0066660000CCFFFF00CCFFFF006666000066660000666600006666
      000066660000CCFFFF0066660000000000000000000055555500CCCCCC005555
      5500555555005555550055555500555555006666330055555500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000292929002929290096969600CCCC9900CCCCCC00CC9966006633
      0000292929002929290000000000000000000000000055555500999966005555
      550055555500555555005555550055555500CCCCCC0055555500000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      0000CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFFFF00CCFF
      FF00CCFFFF00CCFFFF0066660000000000000000000055555500555555009696
      9600CCCC9900CCCCCC00CC996600999966005555550055555500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000029292900D7D7D700F8F8F800F8F8F800FFECCC00CC99
      6600292929000000000000000000000000000000000055555500555555009999
      6600CC996600CCCCCC00CCCC9900969696005555550055555500000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      0000666600006666000066660000666600006666000066660000666600006666
      000066660000666600006666000000000000000000000000000055555500D7D7
      D700F8F8F800F8F8F800FFECCC00CC9966005555550000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000292929002929290029292900292929002929
      290000000000000000000000000000000000000000000000000055555500CC99
      6600FFECCC00F8F8F800F8F8F800D7D7D7005555550000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009966
      0000666600006666000066660000666600006666000066660000666600006666
      0000666600006666000099660000000000000000000000000000000000005555
      5500555555005555550055555500555555000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005555
      5500555555005555550055555500555555000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFF000000000000FF01000000000000
      FE01000000000000FC01000000000000C0010000000000008001000000000000
      100100000000000010030000000000000007000000000000001F000000000000
      107F000000000000007F000000000000007F00000000000080FF000000000000
      C1FF000000000000FFFF000000000000FFFFFFFFFFFFFFFFE00FFC0180FFFF9F
      E00FFC01BE01F00F800FF801AE01F007800FF801A201E00380078001B201C003
      80038001BE018007800380018001800F80038001E001801F80038001E001883F
      F8838001E001883FF803823FE001803FF803803FE001803FFC07803FE001C07F
      FE0FC07FE001E0FFFFFFE0FFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
