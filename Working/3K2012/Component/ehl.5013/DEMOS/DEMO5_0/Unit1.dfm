object Form1: TForm1
  Left = 436
  Top = 162
  Width = 733
  Height = 511
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 717
    Height = 473
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Customers'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 709
        Height = 445
        Align = alClient
        AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.Title.TitleButton = True
        ColumnDefValues.ToolTips = True
        Ctl3D = True
        DataSource = DataSource1
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
        OnEnter = DBGridEh1Enter
        OnExit = DBGridEh1Exit
        OnRowDetailPanelShow = DBGridEh1RowDetailPanelShow
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
            ButtonStyle = cbsAltDropDown
            EditButtons = <>
            FieldName = 'TaxRate'
            Footers = <>
          end
          item
            ButtonStyle = cbsAltDropDown
            EditButtons = <
              item
                Style = ebsEllipsisEh
                OnClick = DBGridEh1Columns3EditButtons0Click
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
            Width = 645
            Height = 218
            ActivePage = TabSheet3
            Align = alClient
            TabOrder = 0
            object TabSheet3: TTabSheet
              Caption = 'Orders'
              object DBGridEh2: TDBGridEh
                Left = 0
                Top = 0
                Width = 637
                Height = 190
                Align = alClient
                ColumnDefValues.AlwaysShowEditButton = True
                Ctl3D = True
                DataSource = DataSource2
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
                OnEnter = DBGridEh1Enter
                OnExit = DBGridEh1Exit
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
                    FieldName = 'ShipToCountry'
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
                    FieldName = 'ShipToContact'
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
                    FieldName = 'ShipToAddr2'
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
                    FieldName = 'ShipToAddr1'
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
                    FieldName = 'ShipToZip'
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
                  end>
                object RowDetailData: TRowDetailPanelControlEh
                end
              end
            end
            object TabSheet4: TTabSheet
              Caption = 'Customer details'
              ImageIndex = 1
              object ScrollBox1: TScrollBox
                Left = 0
                Top = 0
                Width = 637
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
                object Label2: TLabel
                  Left = 7
                  Top = 33
                  Width = 36
                  Height = 13
                  Caption = 'Country'
                end
                object Label3: TLabel
                  Left = 7
                  Top = 59
                  Width = 35
                  Height = 13
                  Caption = 'CustNo'
                end
                object Label4: TLabel
                  Left = 7
                  Top = 85
                  Width = 20
                  Height = 13
                  Caption = 'FAX'
                end
                object Label5: TLabel
                  Left = 7
                  Top = 111
                  Width = 78
                  Height = 13
                  Caption = 'LastInvoiceDate'
                end
                object Label6: TLabel
                  Left = 7
                  Top = 137
                  Width = 31
                  Height = 13
                  Caption = 'Phone'
                end
                object Label7: TLabel
                  Left = 7
                  Top = 163
                  Width = 25
                  Height = 13
                  Caption = 'State'
                end
                object DBEditEh1: TDBEditEh
                  Left = 98
                  Top = 7
                  Width = 98
                  Height = 21
                  DataField = 'City'
                  DataSource = DataSource1
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 0
                  Visible = True
                end
                object DBEditEh2: TDBEditEh
                  Left = 98
                  Top = 33
                  Width = 98
                  Height = 21
                  DataField = 'Country'
                  DataSource = DataSource1
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 1
                  Visible = True
                end
                object DBEditEh3: TDBEditEh
                  Left = 98
                  Top = 59
                  Width = 98
                  Height = 21
                  DataField = 'CustNo'
                  DataSource = DataSource1
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 2
                  Visible = True
                end
                object DBEditEh4: TDBEditEh
                  Left = 98
                  Top = 85
                  Width = 98
                  Height = 21
                  DataField = 'FAX'
                  DataSource = DataSource1
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 3
                  Visible = True
                end
                object DBEditEh6: TDBEditEh
                  Left = 98
                  Top = 137
                  Width = 98
                  Height = 21
                  DataField = 'Phone'
                  DataSource = DataSource1
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 4
                  Visible = True
                end
                object DBEditEh7: TDBEditEh
                  Left = 98
                  Top = 163
                  Width = 98
                  Height = 21
                  DataField = 'State'
                  DataSource = DataSource1
                  EditButtons = <>
                  ShowHint = True
                  TabOrder = 5
                  Visible = True
                end
                object DBDateTimeEditEh1: TDBDateTimeEditEh
                  Left = 98
                  Top = 110
                  Width = 98
                  Height = 21
                  DataField = 'LastInvoiceDate'
                  DataSource = DataSource1
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
    object TabSheet2: TTabSheet
      Caption = 'BioLife #1'
      ImageIndex = 1
      object DBGridEh3: TDBGridEh
        Left = 0
        Top = 0
        Width = 709
        Height = 445
        Align = alClient
        DataSource = dsBioLife
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = RUSSIAN_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        RowDetailPanel.Active = True
        RowDetailPanel.Height = 300
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = RUSSIAN_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        OnEnter = DBGridEh1Enter
        OnExit = DBGridEh1Exit
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Species No'
            Footers = <>
            Width = 148
          end
          item
            EditButtons = <>
            FieldName = 'Category'
            Footers = <>
            Width = 110
          end
          item
            EditButtons = <>
            FieldName = 'Common_Name'
            Footers = <>
            Width = 158
          end
          item
            EditButtons = <>
            FieldName = 'Species Name'
            Footers = <>
            Width = 170
          end
          item
            EditButtons = <>
            FieldName = 'Length (cm)'
            Footers = <>
            Width = 52
          end
          item
            EditButtons = <>
            FieldName = 'Length_In'
            Footers = <>
            Width = 52
          end>
        object RowDetailData: TRowDetailPanelControlEh
          object PageControl3: TPageControl
            Left = 0
            Top = 0
            Width = 645
            Height = 298
            ActivePage = TabSheet5
            Align = alClient
            TabOrder = 0
            object TabSheet5: TTabSheet
              Caption = 'Graphic'
              object DBImage1: TDBImage
                Left = 0
                Top = 0
                Width = 637
                Height = 270
                Align = alClient
                BorderStyle = bsNone
                DataField = 'Graphic'
                DataSource = dsBioLife
                TabOrder = 0
              end
            end
            object TabSheet6: TTabSheet
              Caption = 'Notes'
              ImageIndex = 1
              object DBMemo1: TDBMemo
                Left = 0
                Top = 0
                Width = 637
                Height = 270
                Align = alClient
                BorderStyle = bsNone
                DataField = 'Notes'
                DataSource = dsBioLife
                TabOrder = 0
              end
            end
          end
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'BioLife #2'
      ImageIndex = 2
      object DBGridEh4: TDBGridEh
        Left = 0
        Top = 0
        Width = 709
        Height = 445
        Align = alClient
        AutoFitColWidths = True
        DataSource = dsBioLife
        DrawGraphicData = True
        DrawMemoText = True
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = RUSSIAN_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghExtendVertLines]
        RowDetailPanel.Height = 300
        RowDetailPanel.Color = clBtnFace
        TabOrder = 0
        TitleFont.Charset = RUSSIAN_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        UseMultiTitle = True
        VertScrollBar.SmoothStep = True
        OnEnter = DBGridEh1Enter
        OnExit = DBGridEh1Exit
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Species No'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'Category'
            Footers = <>
            Visible = False
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'Common_Name'
            Footers = <>
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'Species Name'
            Footers = <>
            Visible = False
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'Length (cm)'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'Length_In'
            Footers = <>
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'Notes'
            Footers = <>
            Width = 383
          end
          item
            EditButtons = <>
            FieldName = 'Graphic'
            Footers = <>
            Width = 195
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'BioLife #3'
      ImageIndex = 3
      object DBGridEh5: TDBGridEh
        Left = 0
        Top = 0
        Width = 709
        Height = 445
        Align = alClient
        AutoFitColWidths = True
        DataSource = dsBioLife
        DrawGraphicData = True
        DrawMemoText = True
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = RUSSIAN_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'Microsoft Sans Serif'
        FooterFont.Style = []
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
        RowDetailPanel.Height = 300
        RowDetailPanel.Color = clBtnFace
        RowSizingAllowed = True
        RowPanel = True
        TabOrder = 0
        TitleFont.Charset = RUSSIAN_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Microsoft Sans Serif'
        TitleFont.Style = []
        VertScrollBar.SmoothStep = True
        OnEnter = DBGridEh1Enter
        OnExit = DBGridEh1Exit
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
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -9
            Font.Name = 'Microsoft Sans Serif'
            Font.Style = []
            Footers = <>
            Width = 480
            InRowLinePos = 1
            InRowLineHeight = 4
          end
          item
            EditButtons = <>
            FieldName = 'Category'
            Footers = <>
            Width = 91
          end
          item
            EditButtons = <>
            FieldName = 'Common_Name'
            Footers = <>
            Width = 115
          end
          item
            EditButtons = <>
            FieldName = 'Species Name'
            Footers = <>
            Width = 152
          end
          item
            EditButtons = <>
            FieldName = 'Length (cm)'
            Footers = <>
            Width = 69
          end
          item
            EditButtons = <>
            FieldName = 'Length_In'
            Footers = <>
            Visible = False
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'Graphic'
            Footers = <>
            Title.Alignment = taCenter
            Width = 203
            InRowLineHeight = 5
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 414
    Top = 2
    Width = 200
    Height = 18
    Anchors = [akTop, akRight]
    Flat = True
    TabOrder = 1
  end
  object DataSource1: TDataSource
    DataSet = mtTable1
    Left = 974
    Top = 374
  end
  object Table1: TTable
    Active = True
    CachedUpdates = True
    DatabaseName = 'DBDEMOS'
    TableName = 'customer.db'
    Left = 1005
    Top = 375
  end
  object dsdTable1: TDataSetDriverEh
    ProviderDataSet = Table1
    OnAssignFieldValue = dsdTable1AssignFieldValue
    ResolveToDataSet = False
    Left = 1035
    Top = 375
  end
  object mtTable1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = dsdTable1
    Left = 1066
    Top = 375
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    DetailFields = 'CustNo'
    FetchAllOnOpen = True
    MasterFields = 'CustNo'
    MasterSource = DataSource1
    Params = <>
    DataDriver = DataSetDriverEh1
    Left = 1066
    Top = 407
  end
  object DataSetDriverEh1: TDataSetDriverEh
    ProviderDataSet = Table2
    ResolveToDataSet = False
    Left = 1035
    Top = 407
  end
  object Table2: TTable
    Active = True
    CachedUpdates = True
    DatabaseName = 'DBDEMOS'
    TableName = 'orders.db'
    Left = 1005
    Top = 407
  end
  object DataSource2: TDataSource
    DataSet = MemTableEh1
    Left = 974
    Top = 406
  end
  object dsBioLife: TDataSource
    DataSet = mtBioLife
    Left = 974
    Top = 454
  end
  object Table3: TTable
    Active = True
    CachedUpdates = True
    DatabaseName = 'DBDEMOS'
    TableName = 'biolife.db'
    Left = 1005
    Top = 455
  end
  object ddrBioLife: TDataSetDriverEh
    ProviderDataSet = Table3
    ResolveToDataSet = False
    Left = 1035
    Top = 455
  end
  object mtBioLife: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = ddrBioLife
    Left = 1066
    Top = 455
  end
end
