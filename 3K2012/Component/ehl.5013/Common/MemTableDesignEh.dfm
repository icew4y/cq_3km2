inherited MemTableFieldsEditorEh: TMemTableFieldsEditorEh
  Left = 329
  Top = 119
  Width = 391
  Height = 400
  Caption = 'MemTableFieldsEditorh'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Top = 326
    Width = 383
  end
  inherited Panel1: TPanel
    Width = 383
    inherited DBNavigator: TDBNavigator
      Width = 381
      Flat = True
      Hints.Strings = ()
    end
  end
  inherited FieldListBox: TListBox
    Width = 383
    Height = 305
  end
  inherited AggListBox: TListBox
    Top = 328
    Width = 383
  end
  object PageControl1: TPageControl [4]
    Left = 0
    Top = 21
    Width = 383
    Height = 305
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Edit fields'
    end
    object TabSheet2: TTabSheet
      Caption = 'Edit data'
      ImageIndex = 1
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 306
        Height = 206
        Align = alClient
        ColumnDefValues.AlwaysShowEditButton = True
        ColumnDefValues.AutoDropDown = True
        ColumnDefValues.DblClickNextVal = True
        ColumnDefValues.DropDownShowTitles = True
        ColumnDefValues.DropDownSizing = True
        ColumnDefValues.Title.EndEllipsis = True
        ColumnDefValues.Title.ToolTips = True
        ColumnDefValues.ToolTips = True
        DataSource = DataSource
        EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh, geaSelectAllEh]
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Style = []
        HorzScrollBar.Tracking = True
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        OptionsEh = [dghFixed3D, dghClearSelection, dghFitRowHeightToText, dghTraceColSizing, dghIncSearch, dghRowHighlight]
        RowHeight = 2
        RowLines = 1
        RowSizingAllowed = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Style = []
        VertScrollBar.Tracking = True
        OnContextPopup = DBGridEh1ContextPopup
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Edit dataset'
      ImageIndex = 2
      object SpeedButton1: TSpeedButton
        Left = 0
        Top = 0
        Width = 375
        Height = 22
        Action = actFetchParams
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton2: TSpeedButton
        Left = 0
        Top = 22
        Width = 375
        Height = 22
        Action = actAssignLocalData
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton3: TSpeedButton
        Left = 0
        Top = 44
        Width = 375
        Height = 22
        Action = actLoadFromMyBaseTable
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton4: TSpeedButton
        Left = 0
        Top = 88
        Width = 375
        Height = 22
        Action = actSaveToMyBaseXmlTable
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton5: TSpeedButton
        Left = 0
        Top = 110
        Width = 375
        Height = 22
        Action = actSaveToMyBaseXmlUTF8Table
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton6: TSpeedButton
        Left = 0
        Top = 132
        Width = 375
        Height = 22
        Action = actSaveToBinaryMyBaseTable
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton7: TSpeedButton
        Left = 0
        Top = 154
        Width = 375
        Height = 22
        Action = actClearData
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton8: TSpeedButton
        Left = 0
        Top = 66
        Width = 375
        Height = 22
        Action = actCreateDataSet
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
      object SpeedButton9: TSpeedButton
        Left = 0
        Top = 176
        Width = 375
        Height = 22
        Action = actCreateDataDriver
        Anchors = [akLeft, akTop, akRight]
        Flat = True
        Transparent = False
      end
    end
  end
  inherited DataSource: TDataSource
    Top = 41
  end
  inherited LocalMenu: TPopupMenu
    Top = 41
  end
  object ActionList1: TActionList
    Left = 188
    Top = 26
    object actFetchParams: TAction
      Caption = 'Fetch Params'
      OnExecute = actFetchParamsExecute
    end
    object actAssignLocalData: TAction
      Caption = 'Assign Local Data...'
      OnExecute = actAssignLocalDataExecute
    end
    object actLoadFromMyBaseTable: TAction
      Caption = 'Load from MyBase table...'
      OnExecute = actLoadFromMyBaseTableExecute
    end
    object actCreateDataSet: TAction
      Caption = 'Create DataSet'
      OnExecute = actCreateDataSetExecute
      OnUpdate = actCreateDataSetUpdate
    end
    object actSaveToMyBaseXmlTable: TAction
      Caption = 'Save to MyBase Xml table...'
      OnExecute = actSaveToMyBaseXmlTableExecute
    end
    object actSaveToMyBaseXmlUTF8Table: TAction
      Caption = 'Save to MyBase Xml UTF8 table...'
      OnExecute = actSaveToMyBaseXmlUTF8TableExecute
    end
    object actSaveToBinaryMyBaseTable: TAction
      Caption = 'Save to binary MyBase table...'
      OnExecute = actSaveToBinaryMyBaseTableExecute
    end
    object actClearData: TAction
      Caption = 'Clear Data'
      OnExecute = actClearDataExecute
    end
    object actCreateDataDriver: TAction
      Caption = 'Create DataDriver'
      OnExecute = actCreateDataDriverExecute
    end
  end
  object GridMenu: TPopupMenu
    Left = 86
    Top = 42
    object GridCut: TMenuItem
      Caption = 'Cut'
      ShortCut = 16472
      OnClick = GridCutClick
    end
    object GridCopy: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = GridCopyClick
    end
    object GridPaste: TMenuItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = GridPasteClick
    end
    object GridDelete: TMenuItem
      Caption = 'Delete'
      ShortCut = 16430
      OnClick = GridDeleteClick
    end
    object GridSelectAll: TMenuItem
      Caption = 'Select All'
      ShortCut = 16449
      OnClick = GridSelectAllClick
    end
  end
end
