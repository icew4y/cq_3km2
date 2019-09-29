object Form1: TForm1
  Left = 287
  Top = 131
  Width = 509
  Height = 345
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 13
    Top = 72
    Width = 476
    Height = 225
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Style = []
    FrozenCols = 1
    HorzScrollBar.Tracking = True
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDblClickOptimizeColWidth, dghDialogFind, dghRecordMoving, dghColumnResize, dghColumnMove, dghExtendVertLines]
    STFilter.Local = True
    STFilter.Visible = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    VertScrollBar.Tracking = True
    Columns = <
      item
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
        Width = 220
      end
      item
        EditButtons = <>
        FieldName = 'ID'
        Footers = <>
        Width = 48
      end
      item
        EditButtons = <>
        FieldName = 'ID_PARENT'
        Footers = <>
        Width = 63
      end
      item
        EditButtons = <>
        FieldName = 'Expanded'
        Footer.FieldName = 'ExpCount'
        Footer.ValueType = fvtFieldValue
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'Visible'
        Footers = <>
        Width = 38
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 43
    Top = 38
    Width = 220
    Height = 25
    DataSource = DataSource1
    Flat = True
    TabOrder = 1
  end
  object Button1: TButton
    Left = 185
    Top = 13
    Width = 61
    Height = 20
    Caption = 'Button1'
    TabOrder = 2
    Visible = False
    OnClick = Button1Click
  end
  object MemTableEh1: TMemTableEh
    CachedUpdates = True
    FieldDefs = <>
    FetchAllOnOpen = True
    IndexDefs = <
      item
        Name = 'MemTableEh1Index1'
        Fields = 'ID'
        Options = [ixPrimary]
      end>
    Params = <>
    DataDriver = DataSetDriverEh1
    StoreDefs = True
    Left = 8
    Top = 16
    object MemTableEh1ExpCount: TAggregateField
      FieldName = 'ExpCount'
      Active = True
      Expression = 'SUM(Expanded)'
    end
  end
  object DataSetDriverEh1: TDataSetDriverEh
    KeyFields = 'ID'
    ProviderDataSet = Table1
    Left = 48
    Top = 16
  end
  object Table1: TTable
    DatabaseName = 'C:\Delphi5\EhLib\MemTableEh\DEMOS\TreeView\'
    TableName = 'testTree'
    Left = 80
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 8
    Top = 48
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 358
    Top = 24
  end
end
