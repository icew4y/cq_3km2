object Form1: TForm1
  Left = 313
  Top = 150
  AutoScroll = False
  Caption = 'Form1'
  ClientHeight = 515
  ClientWidth = 711
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 28
    Top = 22
    Width = 114
    Height = 13
    Caption = 'DBLookupComboboxEh'
  end
  object Label8: TLabel
    Left = 28
    Top = 48
    Width = 92
    Height = 13
    Caption = 'DBDateTimeEditEh'
  end
  object Label9: TLabel
    Left = 28
    Top = 72
    Width = 83
    Height = 13
    Caption = 'DBNumberEditEh'
  end
  object Label10: TLabel
    Left = 28
    Top = 96
    Width = 46
    Height = 13
    Caption = 'DBEditEh'
  end
  object Label11: TLabel
    Left = 28
    Top = 122
    Width = 79
    Height = 13
    Caption = 'DBComboBoxEh'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 711
    Height = 515
    ActivePage = TabSheet1
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Grid1'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 74
        Width = 703
        Height = 320
        Align = alClient
        AutoFitColWidths = True
        DataSource = DataModule1.DataSource1
        EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterColor = clYellow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = [fsBold]
        FooterRowCount = 2
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghResizeWholeRightPart, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack, dghExtendVertLines]
        ParentFont = False
        ParentShowHint = False
        PopupMenu = PopupMenu1
        RowDetailPanel.Color = clBtnFace
        RowSizingAllowed = True
        ShowHint = True
        SortLocal = True
        STFilter.Local = True
        STFilter.Visible = True
        SumList.Active = True
        SumList.VirtualRecords = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        TitleImages = DataModule1.ImageList1
        UseMultiTitle = True
        VTitleMargin = 5
        OnColWidthsChanged = DBGridEh1ColWidthsChanged
        OnKeyDown = DBGridEh1KeyDown
        OnTitleBtnClick = DBGridEh1TitleBtnClick
        Columns = <
          item
            AlwaysShowEditButton = True
            Checkboxes = False
            DropDownSizing = True
            EditButtons = <>
            FieldName = 'VNo'
            Footer.Value = 'Sum and count'
            Footer.ValueType = fvtStaticText
            Footers = <
              item
                Alignment = taLeftJustify
                Value = 'Sum of cost'
                ValueType = fvtStaticText
              end
              item
                Alignment = taLeftJustify
                Value = 'Record count'
                ValueType = fvtStaticText
              end>
            Title.TitleButton = True
            ToolTips = True
          end
          item
            AlwaysShowEditButton = True
            Checkboxes = False
            DropDownBox.ColumnDefValues.EndEllipsis = True
            DropDownBox.ColumnDefValues.Title.ToolTips = True
            DropDownBox.ColumnDefValues.ToolTips = True
            DropDownBox.Options = [dlgColumnResizeEh, dlgColLinesEh]
            DropDownBox.UseMultiTitle = True
            DropDownRows = 14
            DropDownShowTitles = True
            DropDownSizing = True
            DropDownSpecRow.CellsText = '<Empty>;<Null>;<Null>;<Null>'
            DropDownSpecRow.Font.Charset = DEFAULT_CHARSET
            DropDownSpecRow.Font.Color = clWindowText
            DropDownSpecRow.Font.Height = -11
            DropDownSpecRow.Font.Name = 'Microsoft Sans Serif'
            DropDownSpecRow.Font.Style = [fsBold]
            DropDownSpecRow.Visible = True
            DropDownWidth = -1
            EditButtons = <>
            FieldName = 'VName1'
            Footer.Alignment = taCenter
            Footer.ValueType = fvtCount
            Footers = <
              item
                Alignment = taCenter
                FieldName = 'PCost'
                ValueType = fvtSum
              end>
            LookupDisplayFields = 'VendorName;City;State;FAX'
            STFilter.DataField = 'VNo'
            STFilter.KeyField = 'VendorNo'
            STFilter.ListField = 'VendorName'
            STFilter.ListSource = DataModule1.dsVendors
            Title.Caption = 'Vendor of parts|Vendor Name|2'
            ToolTips = True
            Width = 139
            OnDropDownBoxGetCellParams = DBGridEh1Columns1DropDownBoxGetCellParams
          end
          item
            AlwaysShowEditButton = True
            Checkboxes = False
            DropDownSizing = True
            EditButtons = <>
            FieldName = 'PNo'
            Footers = <>
            Title.TitleButton = True
            ToolTips = True
          end
          item
            AlwaysShowEditButton = True
            Checkboxes = False
            DropDownSizing = True
            EditButtons = <>
            FieldName = 'PDescription'
            Footers = <
              item
                Value = 'Sum'
                ValueType = fvtStaticText
              end
              item
                Value = 'Vendor No'
                ValueType = fvtStaticText
              end>
            STFilter.DataField = 'PDescription'
            STFilter.KeyField = 'Description'
            STFilter.ListField = 'Description'
            STFilter.ListSource = DataModule1.dsPartsDescriprion
            Title.TitleButton = True
            ToolTips = True
            Width = 149
          end
          item
            AlwaysShowEditButton = True
            ButtonStyle = cbsUpDown
            Checkboxes = False
            DropDownSizing = True
            EditButtons = <>
            FieldName = 'PCost'
            Footer.ValueType = fvtSum
            Footers = <
              item
                ValueType = fvtSum
              end
              item
                FieldName = 'VNo'
                ValueType = fvtFieldValue
              end>
            Increment = 0.1
            Title.SortIndex = 1
            Title.SortMarker = smDownEh
            Title.TitleButton = True
            ToolTips = True
            Width = 89
          end
          item
            AlwaysShowEditButton = True
            Checkboxes = False
            DropDownSizing = True
            EditButtons = <>
            FieldName = 'IQty'
            Footers = <>
            Title.SortIndex = 2
            Title.SortMarker = smDownEh
            Title.TitleButton = True
            ToolTips = True
            Width = 41
          end
          item
            AlwaysShowEditButton = True
            Checkboxes = True
            DropDownSizing = True
            EditButtons = <>
            FieldName = 'VPreferred'
            Footers = <>
            NotInKeyListIndex = 2
            Title.Caption = 'Preferred'
            Title.Hint = 'Preferred'
            Title.ImageIndex = 0
            Title.TitleButton = True
            ToolTips = True
            Width = 20
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 703
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object bInpPreview: TButton
          Left = 236
          Top = 6
          Width = 133
          Height = 25
          Caption = 'Inplace preview'
          TabOrder = 0
          OnClick = bInpPreviewClick
        end
        object bPreview: TButton
          Left = 100
          Top = 6
          Width = 133
          Height = 25
          Caption = 'Preview'
          TabOrder = 1
          OnClick = bPreviewClick
        end
        object bOpenClose: TButton
          Left = 5
          Top = 6
          Width = 84
          Height = 25
          Caption = 'Close'
          TabOrder = 2
          OnClick = bOpenCloseClick
        end
        object cCustomPreview: TButton
          Left = 372
          Top = 6
          Width = 133
          Height = 25
          Caption = 'Custom preview as bitmap'
          TabOrder = 3
          OnClick = cCustomPreviewClick
        end
        object ToolBar1: TToolBar
          Left = 636
          Top = 0
          Width = 67
          Height = 33
          Align = alRight
          BorderWidth = 3
          EdgeBorders = []
          EdgeInner = esNone
          EdgeOuter = esNone
          Flat = True
          Images = DataModule1.ilArrows
          TabOrder = 5
          Wrapable = False
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
            Caption = 'ToolButton1'
            Enabled = False
            ImageIndex = 0
            PopupMenu = pmNoVisibleCols
            Style = tbsDropDown
            OnClick = ToolButton1Click
          end
          object ToolButton2: TToolButton
            Left = 38
            Top = 0
            Caption = 'ToolButton2'
            ImageIndex = 1
            OnClick = ToolButton2Click
          end
        end
        object bbCopy: TBitBtn
          Left = 516
          Top = 6
          Width = 84
          Height = 25
          Hint = 'Copy selected area to clipboard'
          Caption = 'Copy'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = bbCopyClick
          Glyph.Data = {
            26050000424D26050000000000003604000028000000100000000F0000000100
            080000000000F000000000000000000000000001000000010000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
            0707070707070707070707070707070704040404040404040407070707070707
            04FFFFFFFFFFFFFF040707070707070704FF0000000000FF0407000000000000
            04FFFFFFFFFFFFFF040700FFFFFFFFFF04FF0000000000FF040700FF00000000
            04FFFFFFFFFFFFFF040700FFFFFFFFFF04FF0000FF040404040700FF00000000
            04FFFFFFFF04FF04070700FFFFFFFFFF04FFFFFFFF040407070700FF0000FF00
            0404040404040707070700FFFFFFFF00FF00070707070707070700FFFFFFFF00
            0007070707070707070700000000000007070707070707070707070707070707
            07070707070707070707}
        end
      end
      object PreviewSetupPanel: TPanel
        Left = 0
        Top = 33
        Width = 703
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
        object lPageinfo: TLabel
          Left = 608
          Top = 14
          Width = 55
          Height = 13
          Caption = 'Page 1 of 1'
        end
        object bPrint: TButton
          Left = 6
          Top = 8
          Width = 87
          Height = 25
          Caption = 'Print'
          TabOrder = 0
          OnClick = bPrintClick
        end
        object bPrinterSetup: TButton
          Left = 106
          Top = 8
          Width = 87
          Height = 25
          Caption = 'Printer setup'
          TabOrder = 1
          OnClick = bPrinterSetupClick
        end
        object bPrevPage: TButton
          Left = 206
          Top = 8
          Width = 87
          Height = 25
          Caption = '< Previous'
          TabOrder = 2
          OnClick = bPrevPageClick
        end
        object bNextPage: TButton
          Left = 306
          Top = 8
          Width = 87
          Height = 25
          Caption = 'Next >'
          TabOrder = 3
          OnClick = bNextPageClick
        end
        object bStop: TButton
          Left = 406
          Top = 8
          Width = 87
          Height = 25
          Caption = 'Stop'
          TabOrder = 4
          OnClick = bStopClick
        end
        object bClosePreview: TButton
          Left = 504
          Top = 8
          Width = 87
          Height = 25
          Caption = 'Close preview'
          TabOrder = 5
          OnClick = bClosePreviewClick
        end
      end
      object PreviewBox1: TPreviewBox
        Left = 0
        Top = 394
        Width = 703
        Height = 93
        HorzScrollBar.Tracking = True
        VertScrollBar.Tracking = True
        Align = alBottom
        AutoScroll = False
        TabOrder = 3
        Visible = False
        OnPrinterPreviewChanged = PreviewBox1PrinterPreviewChanged
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Grid2'
      object DBGridEh2: TDBGridEh
        Left = 0
        Top = 0
        Width = 703
        Height = 487
        Align = alClient
        AutoFitColWidths = True
        DataSource = DataModule1.DataSource1
        DefaultDrawing = False
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        FooterRowCount = 1
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack]
        ParentShowHint = False
        PopupMenu = PopupMenu1
        RowDetailPanel.Color = clBtnFace
        ShowHint = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        VTitleMargin = 5
        OnDrawColumnCell = DBGridEh2DrawColumnCell
        OnDrawFooterCell = DBGridEh2DrawFooterCell
        OnEditButtonClick = DBGridEh2EditButtonClick
        OnGetCellParams = DBGridEh2GetCellParams
        OnGetFooterParams = DBGridEh2GetFooterParams
        Columns = <
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'VNo'
            Footer.Alignment = taLeftJustify
            Footer.Color = clYellow
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footer.Value = 'Count and sum'
            Footer.ValueType = fvtStaticText
            Footers = <>
            ToolTips = True
            Width = 123
          end
          item
            ButtonStyle = cbsDropDown
            Checkboxes = False
            EditButtons = <>
            FieldName = 'VName'
            Footer.Alignment = taCenter
            Footer.Color = clYellow
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footer.ValueType = fvtCount
            Footers = <>
            ToolTips = True
            Width = 117
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'PNo'
            Footer.Color = clYellow
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footers = <>
            ToolTips = True
            Width = 83
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'PDescription'
            Footer.Alignment = taCenter
            Footer.Color = clYellow
            Footer.FieldName = 'IQty'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footer.ValueType = fvtFieldValue
            Footers = <>
            ToolTips = True
            Width = 139
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'PCost'
            Footer.Color = clYellow
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footer.ValueType = fvtSum
            Footers = <>
            ToolTips = True
            Width = 87
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'IQty'
            Footer.Alignment = taCenter
            Footer.Color = clYellow
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footers = <>
            ToolTips = True
            Width = 92
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Master/Detale'
      object DBGridEh3: TDBGridEh
        Left = 10
        Top = 32
        Width = 684
        Height = 197
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColumnDefValues.AlwaysShowEditButton = True
        DataSource = DataModule1.DataSource2
        EditActions = [geaCopyEh, geaSelectAllEh]
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterColor = clBtnFace
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = [fsBold]
        FooterRowCount = 1
        FrozenCols = 2
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghFooter3D, dghHighlightFocus, dghClearSelection, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        ParentFont = False
        ParentShowHint = False
        RowDetailPanel.Color = clBtnFace
        ShowHint = True
        STFilter.Local = True
        STFilter.Visible = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'OrderNo'
            Footer.Alignment = taCenter
            Footer.ValueType = fvtCount
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'CustNo'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ItemsTotal'
            Footer.ValueType = fvtSum
            Footers = <>
            ToolTips = True
            Width = 81
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'TaxRate'
            Footer.ValueType = fvtSum
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Freight'
            Footer.ValueType = fvtSum
            Footers = <>
            ToolTips = True
          end
          item
            ButtonStyle = cbsDropDown
            Checkboxes = False
            EditButtons = <>
            FieldName = 'AmountPaid'
            Footer.ValueType = fvtSum
            Footers = <>
            ToolTips = True
            Width = 82
            OnGetCellParams = DBGridEh3Columns5GetCellParams
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'SaleDate'
            Footer.Alignment = taCenter
            Footer.FieldName = 'PaymentMethod'
            Footer.ValueType = fvtFieldValue
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipDate'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'EmpNo'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipToContact'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipToAddr1'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipToAddr2'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipToCity'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipToState'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipToZip'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipToCountry'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipToPhone'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ShipVIA'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'PO'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Terms'
            Footers = <>
            ToolTips = True
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'PaymentMethod'
            Footers = <>
            ToolTips = True
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object DBGridEh4: TDBGridEh
        Left = 14
        Top = 286
        Width = 363
        Height = 183
        Anchors = [akLeft, akBottom]
        AutoFitColWidths = True
        DataSource = DataModule1.DataSource3
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        FooterRowCount = 1
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghFooter3D, dghHighlightFocus, dghClearSelection, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        PopupMenu = PopupMenu1
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'OrderNo'
            Footer.Alignment = taCenter
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footer.ValueType = fvtCount
            Footers = <>
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'ItemNo'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footers = <>
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'PartNo'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footers = <>
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Qty'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footer.ValueType = fvtSum
            Footers = <>
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Discount'
            Footer.Font.Charset = DEFAULT_CHARSET
            Footer.Font.Color = clWindowText
            Footer.Font.Height = -11
            Footer.Font.Name = 'Microsoft Sans Serif'
            Footer.Font.Style = [fsBold]
            Footers = <>
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object DBNavigator2: TDBNavigator
        Left = 10
        Top = 4
        Width = 220
        Height = 25
        DataSource = DataModule1.DataSource2
        Flat = True
        TabOrder = 2
      end
      object DBNavigator3: TDBNavigator
        Left = 12
        Top = 256
        Width = 220
        Height = 25
        DataSource = DataModule1.DataSource3
        Anchors = [akLeft, akBottom]
        Flat = True
        TabOrder = 3
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Grid3D'
      object DBGridEh5: TDBGridEh
        Left = 0
        Top = 0
        Width = 703
        Height = 487
        Align = alClient
        AutoFitColWidths = True
        DataSource = DataModule1.dsEmployee
        EditActions = [geaCopyEh, geaSelectAllEh]
        Flat = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        FooterRowCount = 1
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghFrozen3D, dghFooter3D, dghData3D, dghHighlightFocus, dghClearSelection, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove]
        ParentFont = False
        ParentShowHint = False
        PopupMenu = PopupMenu1
        RowDetailPanel.Color = clBtnFace
        RowHeight = 7
        RowLines = 1
        RowSizingAllowed = True
        ShowHint = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = [fsBold]
        UseMultiTitle = True
        Columns = <
          item
            Checkboxes = False
            Color = clBtnFace
            EditButtons = <>
            FieldName = 'EmpNo'
            Footer.Color = clBtnFace
            Footers = <>
            Title.Caption = 'Emp No'
            ToolTips = True
            Width = 69
          end
          item
            Checkboxes = False
            Color = clBtnFace
            EditButtons = <>
            FieldName = 'FirstName'
            Footer.Color = clBtnFace
            Footers = <>
            Title.Caption = 'Name|First'
            ToolTips = True
            Width = 121
          end
          item
            Checkboxes = False
            Color = clBtnFace
            EditButtons = <>
            FieldName = 'LastName'
            Footer.Color = clBtnFace
            Footers = <>
            Title.Caption = 'Name|Last'
            Title.SortMarker = smDownEh
            ToolTips = True
            Width = 146
          end
          item
            Checkboxes = False
            Color = clBtnFace
            EditButtons = <>
            FieldName = 'PhoneExt'
            Footer.Color = clBtnFace
            Footers = <>
            Title.Caption = 'Phone Ext'
            ToolTips = True
            Width = 81
          end
          item
            Checkboxes = False
            Color = clBtnFace
            EditButtons = <>
            FieldName = 'HireDate'
            Footer.Color = clBtnFace
            Footers = <>
            Title.Caption = 'Hire Date'
            ToolTips = True
            Width = 82
          end
          item
            Checkboxes = False
            Color = clBtnFace
            EditButtons = <>
            FieldName = 'Salary'
            Footer.Color = clBtnFace
            Footer.FieldName = 'Salary'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = 'Salary|Sum'
            ToolTips = True
            Width = 99
          end
          item
            Checkboxes = False
            Color = clBtnFace
            EditButtons = <>
            FieldName = 'SalaryType'
            Footer.Color = clBtnFace
            Footers = <>
            ImageList = DataModule1.ImageList2
            KeyList.Strings = (
              '0'
              '1'
              '2'
              '3'
              '4'
              '5')
            PickList.Strings = (
              'Super smile'
              'Smile of third degree'
              'Smile of second degree'
              'Smile of first degree'
              'So-so'
              'No smile')
            Title.Alignment = taRightJustify
            Title.Caption = 'Salary|Face'
            Title.Orientation = tohVertical
            ToolTips = True
            Width = 29
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'DBList'
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 703
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object cbClearSelection: TCheckBox
          Left = 118
          Top = 4
          Width = 109
          Height = 17
          Caption = 'Clear selection'
          TabOrder = 2
          OnClick = cbClearSelectionClick
        end
        object cbShowIndicator: TCheckBox
          Left = 8
          Top = 20
          Width = 109
          Height = 17
          Caption = 'Show indicator'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = cbShowIndicatorClick
        end
        object cbTitle: TCheckBox
          Left = 8
          Top = 4
          Width = 109
          Height = 17
          Caption = 'Show title'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbTitleClick
        end
        object cbHighlightFocus: TCheckBox
          Left = 118
          Top = 20
          Width = 109
          Height = 17
          Caption = 'Highlight focus'
          TabOrder = 4
          OnClick = cbHighlightFocusClick
        end
        object cbMultiselect: TCheckBox
          Left = 228
          Top = 4
          Width = 109
          Height = 17
          Caption = 'Multiselect'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = cbMultiselectClick
        end
        object cbDragNDrop: TCheckBox
          Left = 228
          Top = 20
          Width = 109
          Height = 17
          Caption = 'Drag&&Drop'
          TabOrder = 5
          OnClick = cbDragNDropClick
        end
        object cbDichromatic: TCheckBox
          Left = 336
          Top = 4
          Width = 109
          Height = 17
          Caption = 'Dichromatic'
          TabOrder = 6
          OnClick = cbDichromaticClick
        end
        object cbInterAppDragNDrop: TCheckBox
          Left = 336
          Top = 20
          Width = 149
          Height = 17
          Caption = 'Interapplication Drag&&Drop'
          TabOrder = 7
          Visible = False
          OnClick = cbInterAppDragNDropClick
        end
      end
      object dbgList1: TDBGridEh
        Left = 0
        Top = 253
        Width = 703
        Height = 234
        Align = alBottom
        AutoFitColWidths = True
        BorderStyle = bsNone
        Ctl3D = False
        DataSource = DataModule1.dsCustomer2
        DragMode = dmAutomatic
        EditActions = [geaCopyEh, geaSelectAllEh]
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgTitles, dgIndicator, dgColumnResize, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghIncSearch, dghPreferIncSearch, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        ParentCtl3D = False
        PopupMenu = PopupMenu1
        RowDetailPanel.Color = clBtnFace
        SumList.Active = True
        SumList.VirtualRecords = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        Visible = False
        OnDragDrop = dbgList1DragDrop
        OnDragOver = dbgList1DragOver
        Columns = <
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Company'
            Footers = <>
            Width = 274
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Country'
            Footers = <>
            Width = 152
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'City'
            Footers = <>
            Width = 145
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'State'
            Footers = <>
            Width = 62
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object dbgList: TDBGridEh
        Left = 0
        Top = 41
        Width = 703
        Height = 212
        Align = alClient
        AutoFitColWidths = True
        BorderStyle = bsNone
        Ctl3D = False
        DataSource = DataModule1.dsCustomer
        EditActions = [geaCopyEh, geaSelectAllEh]
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgTitles, dgIndicator, dgColumnResize, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghIncSearch, dghPreferIncSearch, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove]
        ParentCtl3D = False
        ParentShowHint = False
        PopupMenu = PopupMenu1
        RowDetailPanel.Color = clBtnFace
        ShowHint = True
        SumList.Active = True
        SumList.VirtualRecords = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        OnDragDrop = dbgListDragDrop
        OnDragOver = dbgListDragOver
        OnGetCellParams = dbgListGetCellParams
        OnStartDrag = dbgListStartDrag
        Columns = <
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Company'
            Footers = <>
            ToolTips = True
            Width = 274
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'Country'
            Footers = <>
            ToolTips = True
            Width = 152
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'City'
            Footers = <>
            ToolTips = True
            Width = 145
          end
          item
            Checkboxes = False
            EditButtons = <>
            FieldName = 'State'
            Footers = <>
            ToolTips = True
            Width = 62
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Edit Controls'
      ImageIndex = 5
      object Label2: TLabel
        Left = 270
        Top = 34
        Width = 150
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '<- DBLookupComboboxEh ->'
      end
      object Label3: TLabel
        Left = 270
        Top = 60
        Width = 150
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '<- DBDateTimeEditEh ->'
      end
      object Label4: TLabel
        Left = 270
        Top = 84
        Width = 150
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '<- DBNumberEditEh ->'
      end
      object Label5: TLabel
        Left = 270
        Top = 108
        Width = 150
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '<- DBEditEh ->'
      end
      object Label6: TLabel
        Left = 270
        Top = 134
        Width = 150
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '<- DBComboBoxEh ->'
      end
      object Label12: TLabel
        Left = 4
        Top = 30
        Width = 94
        Height = 13
        Caption = 'CustNo -> Company'
      end
      object Label13: TLabel
        Left = 46
        Top = 56
        Width = 52
        Height = 13
        Caption = 'Sasle Date'
      end
      object Label14: TLabel
        Left = 49
        Top = 80
        Width = 49
        Height = 13
        Caption = 'ItemsTotal'
      end
      object Label15: TLabel
        Left = 57
        Top = 104
        Width = 41
        Height = 13
        Caption = 'Ship VIA'
      end
      object Label16: TLabel
        Left = 57
        Top = 130
        Width = 41
        Height = 13
        Caption = 'Payment'
      end
      object Bevel1: TBevel
        Left = 4
        Top = 24
        Width = 670
        Height = 2
      end
      object Label17: TLabel
        Left = 131
        Top = 8
        Width = 67
        Height = 13
        Caption = '  Data-aware  '
      end
      object Label18: TLabel
        Left = 524
        Top = 8
        Width = 82
        Height = 13
        Caption = '  No data-aware  '
      end
      object Label19: TLabel
        Left = 458
        Top = 32
        Width = 44
        Height = 13
        Caption = 'Company'
      end
      object Label20: TLabel
        Left = 472
        Top = 58
        Width = 30
        Height = 13
        Caption = 'Today'
      end
      object Label21: TLabel
        Left = 465
        Top = 82
        Width = 37
        Height = 13
        Caption = 'Number'
      end
      object Label22: TLabel
        Left = 464
        Top = 106
        Width = 38
        Height = 13
        Caption = 'Edit text'
      end
      object Label23: TLabel
        Left = 449
        Top = 134
        Width = 53
        Height = 13
        Caption = 'Combo box'
      end
      object Label24: TLabel
        Left = 270
        Top = 158
        Width = 150
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '<- DBCheckBoxEh ->'
      end
      object DBEditEh1: TDBEditEh
        Left = 104
        Top = 102
        Width = 121
        Height = 19
        AlwaysShowBorder = True
        DataField = 'ShipVIA'
        DataSource = DataModule1.DataSource2
        EditButtons = <>
        Flat = True
        MRUList.Active = True
        TabOrder = 3
        Visible = True
      end
      object DBDateTimeEditEh1: TDBDateTimeEditEh
        Left = 104
        Top = 54
        Width = 121
        Height = 19
        AlwaysShowBorder = True
        DataField = 'SaleDate'
        DataSource = DataModule1.DataSource2
        EditButtons = <>
        Flat = True
        Kind = dtkDateEh
        TabOrder = 1
        Visible = True
      end
      object DBNumberEditEh1: TDBNumberEditEh
        Left = 104
        Top = 78
        Width = 121
        Height = 19
        AlwaysShowBorder = True
        DataField = 'ItemsTotal'
        DataSource = DataModule1.DataSource2
        EditButton.Style = ebsUpDownEh
        EditButton.Visible = True
        EditButtons = <>
        Flat = True
        TabOrder = 2
        Visible = True
      end
      object DBComboBoxEh1: TDBComboBoxEh
        Left = 104
        Top = 129
        Width = 121
        Height = 22
        AlwaysShowBorder = True
        DataField = 'PaymentMethod'
        DataSource = DataModule1.DataSource2
        EditButtons = <>
        Flat = True
        Images = DataModule1.ilPaymentType
        Items.Strings = (
          'Credit'
          'Check'
          'Visa'
          'COD'
          'MC'
          'AmEx'
          'Cash')
        TabOrder = 4
        Visible = True
        OnGetItemImageIndex = DBComboBoxEh1GetItemImageIndex
      end
      object DBLookupComboboxEh3: TDBLookupComboboxEh
        Left = 104
        Top = 29
        Width = 121
        Height = 19
        AlwaysShowBorder = True
        DataField = 'CustNo'
        DataSource = DataModule1.DataSource2
        DropDownBox.Rows = 50
        DropDownBox.Sizable = True
        DropDownBox.Width = -1
        EditButtons = <>
        Flat = True
        KeyField = 'CustNo'
        ListField = 'Company'
        ListSource = DataModule1.dstCustomer
        TabOrder = 0
        Visible = True
      end
      object DBGridEh6: TDBGridEh
        Left = 2
        Top = 222
        Width = 383
        Height = 263
        ColumnDefValues.AlwaysShowEditButton = True
        DataSource = DataModule1.DataSource2
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack]
        ParentShowHint = False
        RowDetailPanel.Color = clBtnFace
        RowSizingAllowed = True
        ShowHint = True
        TabOrder = 12
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CustNo'
            Footers = <>
            Width = 48
            OnDataHintShow = DBGridEh6Columns0DataHintShow
            OnAdvDrawDataCell = DBGridEh6Columns0AdvDrawDataCell
            OnGetCellParams = DBGridEh6Columns0GetCellParams
          end
          item
            EditButtons = <>
            FieldName = 'SaleDate'
            Footers = <>
            Title.Caption = 'Sale Date'
            Width = 76
          end
          item
            EditButtons = <>
            FieldName = 'ItemsTotal'
            Footers = <>
            Title.Caption = 'Items Total'
          end
          item
            EditButtons = <>
            FieldName = 'ShipVIA'
            Footers = <>
            Title.Caption = 'Ship VIA'
          end
          item
            EditButtons = <>
            FieldName = 'PaymentMethod'
            Footers = <>
            ImageList = DataModule1.ilPaymentType
            PickList.Strings = (
              'Cash'
              'Visa'
              'MC'
              'AmEx'
              'Credit'
              'Check'
              'COD')
            ShowImageAndText = True
            Title.Caption = 'Payment Method'
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'TaxRate'
            Footers = <>
            Title.Caption = 'Tax Rate'
            Width = 39
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object DBLookupComboboxEh4: TDBLookupComboboxEh
        Left = 508
        Top = 31
        Width = 121
        Height = 19
        AlwaysShowBorder = True
        DropDownBox.Rows = 50
        DropDownBox.Sizable = True
        DropDownBox.Width = -1
        EditButtons = <>
        Flat = True
        KeyField = 'CustNo'
        ListField = 'Company'
        ListSource = DataModule1.dstCustomer
        TabOrder = 5
        Visible = True
      end
      object DBDateTimeEditEh2: TDBDateTimeEditEh
        Left = 508
        Top = 56
        Width = 121
        Height = 19
        AlwaysShowBorder = True
        EditButtons = <>
        Flat = True
        Kind = dtkDateEh
        TabOrder = 6
        Visible = True
      end
      object DBNumberEditEh2: TDBNumberEditEh
        Left = 508
        Top = 80
        Width = 121
        Height = 19
        AlwaysShowBorder = True
        EditButton.Visible = True
        EditButtons = <>
        Flat = True
        TabOrder = 7
        Value = 101.000000000000000000
        Visible = True
      end
      object DBEditEh2: TDBEditEh
        Left = 508
        Top = 104
        Width = 121
        Height = 19
        AlwaysShowBorder = True
        EditButtons = <>
        Flat = True
        MRUList.Active = True
        TabOrder = 8
        Text = 'Simple the text'
        Visible = True
      end
      object DBComboBoxEh2: TDBComboBoxEh
        Left = 508
        Top = 131
        Width = 121
        Height = 22
        AlwaysShowBorder = True
        EditButtons = <>
        Flat = True
        Images = DataModule1.ilYesNo
        Items.Strings = (
          'Yes'
          'No')
        KeyItems.Strings = (
          'Yes'
          'No')
        TabOrder = 9
        Text = 'Yes'
        Visible = True
      end
      object DBNavigator1: TDBNavigator
        Left = 43
        Top = 194
        Width = 220
        Height = 25
        DataSource = DataModule1.DataSource2
        Flat = True
        TabOrder = 11
      end
      object DBCheckBoxEh1: TDBCheckBoxEh
        Left = 508
        Top = 158
        Width = 113
        Height = 17
        AllowGrayed = True
        AlwaysShowBorder = True
        Caption = 'Check box'
        Flat = True
        TabOrder = 10
        ValueChecked = 'True'
        ValueUnchecked = 'False'
      end
      object DBCheckBoxEh2: TDBCheckBoxEh
        Left = 104
        Top = 158
        Width = 113
        Height = 17
        AlwaysShowBorder = True
        Caption = 'Check box'
        DataField = 'TaxRate'
        DataSource = DataModule1.DataSource2
        Flat = True
        TabOrder = 13
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
    object tsFishfact: TTabSheet
      Caption = 'Fishfact'
      ImageIndex = 6
      object gridFish: TDBGridEh
        Left = 6
        Top = 5
        Width = 691
        Height = 479
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.Title.TitleButton = True
        Ctl3D = True
        DataSource = DataModule1.dsFish
        DrawGraphicData = True
        DrawMemoText = True
        EditActions = [geaCopyEh, geaSelectAllEh]
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterColor = clBtnFace
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = [fsBold]
        IndicatorTitle.DropdownMenu = PopupMenu1
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        IndicatorTitle.UseGlobalMenu = False
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghFrozen3D, dghFooter3D, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghHotTrack, dghExtendVertLines]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        RowDetailPanel.Color = clBtnFace
        ShowHint = True
        SortLocal = True
        STFilter.Local = True
        STFilter.Visible = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        VertScrollBar.SmoothStep = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Species No'
            Footers = <>
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'Notes'
            Footers = <>
            STFilter.Visible = False
            Width = 347
          end
          item
            EditButtons = <>
            FieldName = 'Graphic'
            Footers = <>
            STFilter.Visible = False
            Width = 193
          end
          item
            EditButtons = <>
            FieldName = 'Category'
            Footers = <>
            Width = 78
          end
          item
            EditButtons = <>
            FieldName = 'Common_Name'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'Species Name'
            Footers = <>
            Width = 128
          end
          item
            EditButtons = <>
            FieldName = 'Length (cm)'
            Footers = <>
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'Length_In'
            Footers = <>
            Width = 105
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'RowDetailPanel'
      ImageIndex = 7
      object DBGridEh7: TDBGridEh
        Left = 0
        Top = 0
        Width = 703
        Height = 487
        Align = alClient
        AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.ToolTips = True
        Ctl3D = True
        DataSource = DataModule1.dsCustomersRDP
        EditActions = [geaCopyEh, geaSelectAllEh]
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Microsoft Sans Serif'
        Font.Style = []
        FooterColor = clBtnFace
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = [fsBold]
        FooterRowCount = 1
        IndicatorTitle.ShowDropDownSign = True
        IndicatorTitle.TitleButton = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghFooter3D, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghTraceColSizing, dghIncSearch, dghPreferIncSearch, dghRowHighlight, dghDblClickOptimizeColWidth, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        RowDetailPanel.Active = True
        RowDetailPanel.Height = 220
        RowDetailPanel.Color = clBtnFace
        RowSizingAllowed = True
        ShowHint = True
        SortLocal = True
        STFilter.Local = True
        STFilter.Visible = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        Columns = <
          item
            EditButtons = <>
            FieldName = 'CustNo'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'Company'
            Footers = <>
            Width = 128
          end
          item
            EditButtons = <>
            FieldName = 'TaxRate'
            Footers = <>
          end
          item
            ButtonStyle = cbsAltDropDown
            EditButtons = <
              item
                Style = ebsEllipsisEh
              end>
            FieldName = 'LastInvoiceDate'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'Addr1'
            Footers = <>
            Width = 145
          end
          item
            EditButtons = <>
            FieldName = 'Addr2'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'City'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'State'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'Zip'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'Country'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'Phone'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'FAX'
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'Contact'
            Footers = <>
          end>
        object TRowDetailPanelControlEh
          object PageControl2: TPageControl
            Left = 0
            Top = 0
            Width = 639
            Height = 218
            ActivePage = TabSheet8
            Align = alClient
            TabOrder = 0
            object TabSheet8: TTabSheet
              Caption = 'Orders'
              object DBGridEh8: TDBGridEh
                Left = 0
                Top = 0
                Width = 631
                Height = 190
                Align = alClient
                ColumnDefValues.AlwaysShowEditButton = True
                Ctl3D = True
                DataSource = DataModule1.dsOrdersRDP
                Flat = True
                FooterColor = clWindow
                FooterFont.Charset = DEFAULT_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -11
                FooterFont.Name = 'Microsoft Sans Serif'
                FooterFont.Style = []
                OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
                ParentCtl3D = False
                RowDetailPanel.Height = 50
                RowDetailPanel.Color = clBtnFace
                RowPanel = True
                TabOrder = 0
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -11
                TitleFont.Name = 'Microsoft Sans Serif'
                TitleFont.Style = []
                VertScrollBar.SmoothStep = True
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'OrderNo'
                    Footers = <>
                    Width = 62
                  end
                  item
                    EditButtons = <>
                    FieldName = 'CustNo'
                    Footers = <>
                    Width = 62
                    InRowLinePos = 1
                  end
                  item
                    EditButtons = <>
                    FieldName = 'SaleDate'
                    Footers = <>
                    Width = 127
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipDate'
                    Footers = <>
                    Width = 127
                    InRowLinePos = 1
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipVIA'
                    Footers = <>
                    Width = 119
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PaymentMethod'
                    Footers = <>
                    Width = 119
                    InRowLinePos = 1
                  end
                  item
                    ButtonStyle = cbsDropDown
                    EditButtons = <>
                    FieldName = 'ItemsTotal'
                    Footers = <>
                    Width = 99
                  end
                  item
                    ButtonStyle = cbsDropDown
                    EditButtons = <>
                    FieldName = 'AmountPaid'
                    Footers = <>
                    Width = 99
                    InRowLinePos = 1
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TaxRate'
                    Footers = <>
                    Width = 119
                  end
                  item
                    EditButtons = <>
                    FieldName = 'Freight'
                    Footers = <>
                    Width = 119
                    InRowLinePos = 1
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipToAddr1'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'EmpNo'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipToCity'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipToPhone'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipToZip'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipToAddr2'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'Terms'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipToCountry'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipToContact'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'ShipToState'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end
                  item
                    EditButtons = <>
                    FieldName = 'PO'
                    Footers = <>
                    Visible = False
                    Width = 52
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
            object TabSheet9: TTabSheet
              Caption = 'Customer details'
              ImageIndex = 1
              object ScrollBox1: TScrollBox
                Left = 0
                Top = 0
                Width = 631
                Height = 190
                HorzScrollBar.Tracking = True
                VertScrollBar.Tracking = True
                Align = alClient
                BorderStyle = bsNone
                TabOrder = 0
                object Label1: TLabel
                  Left = 7
                  Top = 7
                  Width = 17
                  Height = 13
                  Caption = 'City'
                end
                object Label25: TLabel
                  Left = 7
                  Top = 33
                  Width = 36
                  Height = 13
                  Caption = 'Country'
                end
                object Label26: TLabel
                  Left = 7
                  Top = 59
                  Width = 35
                  Height = 13
                  Caption = 'CustNo'
                end
                object Label27: TLabel
                  Left = 7
                  Top = 85
                  Width = 20
                  Height = 13
                  Caption = 'FAX'
                end
                object Label28: TLabel
                  Left = 7
                  Top = 111
                  Width = 78
                  Height = 13
                  Caption = 'LastInvoiceDate'
                end
                object Label29: TLabel
                  Left = 7
                  Top = 137
                  Width = 31
                  Height = 13
                  Caption = 'Phone'
                end
                object Label30: TLabel
                  Left = 7
                  Top = 163
                  Width = 25
                  Height = 13
                  Caption = 'State'
                end
                object DBEditEh3: TDBEditEh
                  Left = 98
                  Top = 7
                  Width = 98
                  Height = 21
                  DataField = 'City'
                  DataSource = DataModule1.dsCustomersRDP
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 0
                  Visible = True
                end
                object DBEditEh4: TDBEditEh
                  Left = 98
                  Top = 33
                  Width = 98
                  Height = 21
                  DataField = 'Country'
                  DataSource = DataModule1.dsCustomersRDP
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 1
                  Visible = True
                end
                object DBEditEh5: TDBEditEh
                  Left = 98
                  Top = 59
                  Width = 98
                  Height = 21
                  DataField = 'CustNo'
                  DataSource = DataModule1.dsCustomersRDP
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 2
                  Visible = True
                end
                object DBEditEh6: TDBEditEh
                  Left = 98
                  Top = 85
                  Width = 98
                  Height = 21
                  DataField = 'FAX'
                  DataSource = DataModule1.dsCustomersRDP
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 3
                  Visible = True
                end
                object DBEditEh7: TDBEditEh
                  Left = 98
                  Top = 137
                  Width = 98
                  Height = 21
                  DataField = 'Phone'
                  DataSource = DataModule1.dsCustomersRDP
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 4
                  Visible = True
                end
                object DBEditEh8: TDBEditEh
                  Left = 98
                  Top = 163
                  Width = 98
                  Height = 21
                  DataField = 'State'
                  DataSource = DataModule1.dsCustomersRDP
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 5
                  Visible = True
                end
                object DBDateTimeEditEh3: TDBDateTimeEditEh
                  Left = 98
                  Top = 110
                  Width = 97
                  Height = 21
                  DataField = 'LastInvoiceDate'
                  DataSource = DataModule1.dsCustomersRDP
                  EditButton.Style = ebsAltDropDownEh
                  EditButtons = <
                    item
                      Style = ebsEllipsisEh
                    end>
                  Kind = dtkDateEh
                  ShowHint = True
                  TabOrder = 6
                  Visible = True
                end
              end
            end
          end
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'TreeView'
      ImageIndex = 8
      object DBGridEh9: TDBGridEh
        Left = 0
        Top = 0
        Width = 703
        Height = 487
        Align = alClient
        DataSource = DataModule1.dsTreeView
        Flat = True
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        FrozenCols = 1
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDblClickOptimizeColWidth, dghDialogFind, dghRecordMoving, dghColumnResize, dghColumnMove, dghExtendVertLines]
        ParentFont = False
        RowDetailPanel.Color = clBtnFace
        STFilter.Local = True
        STFilter.Visible = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            EditButtons = <>
            FieldName = 'NAME'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Footers = <>
            Width = 220
          end
          item
            EditButtons = <>
            FieldName = 'ID'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Footers = <>
            Width = 48
          end
          item
            EditButtons = <>
            FieldName = 'ID_PARENT'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Footers = <>
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'Expanded'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Footer.FieldName = 'ExpCount'
            Footer.ValueType = fvtFieldValue
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'Visible'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Footers = <>
            Width = 38
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object PrintDBGridEh1: TPrintDBGridEh
    DBGridEh = DBGridEh1
    Options = [pghFitGridToPageWidth, pghColored, pghRowAutoStretch]
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'Microsoft Sans Serif'
    PageFooter.Font.Style = []
    PageHeader.CenterText.Strings = (
      'Page. &[Page]')
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'Microsoft Sans Serif'
    PageHeader.Font.Style = []
    PageHeader.LineType = pcltDoubleLine
    PrintFontName = 'Arial'
    Title.Strings = (
      'Title')
    Units = MM
    Left = 552
    Top = 69
    BeforeGridText_Data = {
      7B5C727466315C616E73695C64656666305C6465666C616E67313033337B5C66
      6F6E7474626C7B5C66305C66737769737320417269616C3B7D7B5C66315C6673
      77697373204D532053616E732053657269663B7D7D0D0A5C766965776B696E64
      345C7563315C706172645C71635C625C66305C66733238205269636820746578
      74206265666F726520677269642E5C6C616E67313034395C62305C6673313620
      0D0A5C706172205C70617264200D0A5C706172205C625C667331382054507269
      6E74444247726964456820636F6D706F6E656E7420616C6C6F777320796F7520
      746F206472617720726963682074657874206265666F726520677269642E0D0A
      5C706172205C62305C66733136200D0A5C706172205C756C5C625C695C667331
      3820557365204265666F726547726964546578742070726F706572747920746F
      207479706520746578742E0D0A5C706172205C756C6E6F6E655C62305C69305C
      66315C66733136200D0A5C706172207D0D0A00}
    AfterGridText_Data = {
      7B5C727466315C616E73695C64656666305C6465666C616E67313033337B5C66
      6F6E7474626C7B5C66305C66737769737320417269616C3B7D7B5C66315C6673
      77697373204D532053616E732053657269663B7D7D0D0A5C766965776B696E64
      345C7563315C706172645C625C66305C66733230200D0A5C7061722052696368
      207465787420616674657220677269640D0A5C706172205C6C616E6731303439
      5C62305C66733136200D0A5C706172205C6220255B546F6461795D5C7461625C
      7461625C7461625C7461625C7461625C7461625C7461625C7461622044617461
      2066726F6D20444244454D4F532064617461626173655C62305C6631200D0A5C
      706172207D0D0A00}
  end
  object PopupMenu1: TPopupMenu
    Left = 340
    Top = 262
    object ppmCut: TMenuItem
      Caption = 'Cu&t'
      OnClick = ppmCutClick
    end
    object ppmCopy: TMenuItem
      Caption = '&Copy'
      OnClick = ppmCopyClick
    end
    object ppmPaste: TMenuItem
      Caption = '&Paste'
      OnClick = ppmPasteClick
    end
    object ppmDelete: TMenuItem
      Caption = '&Delete'
      OnClick = ppmDeleteClick
    end
    object ppmSelectAll: TMenuItem
      Caption = 'Se&lect All'
      OnClick = ppmSelectAllClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ppmPreview: TMenuItem
      Caption = 'Pre&view'
      OnClick = ppmPreviewClick
    end
    object ppmSaveSelection: TMenuItem
      Caption = 'Save selection as ...'
      OnClick = ppmSaveSelectionClick
    end
  end
  object pmNoVisibleCols: TPopupMenu
    Left = 638
    Top = 66
  end
  object SaveDialog1: TSaveDialog
    FileName = 'file1'
    Filter = 
      'Text files (*.txt)|*.TXT|Comma separated values (*.csv)|*.CSV|HT' +
      'ML file (*.htm)|*.HTM|Rich Text Format (*.rtf)|*.RTF|Microsoft E' +
      'xcel Workbook (*.xls)|*.XLS'
    Left = 146
    Top = 254
  end
  object PropStorageEh1: TPropStorageEh
    StoredProps.Strings = (
      '<P>.ActiveControl'
      '<P>.Height'
      '<P>.Left'
      '<P>.PixelsPerInch'
      '<P>.Top'
      '<P>.Width'
      '<P>.WindowState'
      'PageControl1.<P>.ActivePage'
      'PageControl1.TabSheet1.DBGridEh1.<P>.Columns.ColumnsIndex'
      'PageControl1.TabSheet1.DBGridEh1.<P>.Columns.<ForAllItems>.Width')
    Left = 20
    Top = 67
  end
end
