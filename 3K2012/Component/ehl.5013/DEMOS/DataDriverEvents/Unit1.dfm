object Form1: TForm1
  Left = 237
  Top = 133
  Width = 575
  Height = 428
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 7
    Width = 436
    Height = 51
    AutoSize = False
    Caption = 
      'You can use TDataSetDriverEh.OnBuildDataStruct and ReadRecord ev' +
      'ents to convert data that transfer from DataDriver to MemTable.'#13 +
      #10'For example to divide DataTime field to Data and Time.'
    WordWrap = True
  end
  object DBGridEh1: TDBGridEh
    Left = 11
    Top = 60
    Width = 548
    Height = 335
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Style = []
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Verdana'
    TitleFont.Style = []
    VertScrollBar.Tracking = True
    Columns = <
      item
        EditButtons = <>
        FieldName = 'CustNo'
        Footers = <>
        Width = 50
      end
      item
        EditButtons = <>
        FieldName = 'Company'
        Footers = <>
        Width = 191
      end
      item
        Color = cl3DLight
        EditButtons = <>
        FieldName = 'LastInvoiceDate'
        Footers = <>
        ReadOnly = True
        Width = 103
      end
      item
        EditButtons = <>
        FieldName = 'LastInvoiceDate1'
        Footers = <>
      end
      item
        DisplayFormat = 'HH:MM:SS'
        EditButtons = <>
        FieldName = 'LastInvoiceTime1'
        Footers = <>
        Width = 63
      end>
  end
  object MemTableEh1: TMemTableEh
    Active = True
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = DataSetDriverEh1
    OnSetFieldValue = MemTableEh1SetFieldValue
    Left = 52
    Top = 80
  end
  object DataSetDriverEh1: TDataSetDriverEh
    ProviderDataSet = Table1
    OnBuildDataStruct = DataSetDriverEh1BuildDataStruct
    OnReadRecord = DataSetDriverEh1ReadRecord
    Left = 84
    Top = 80
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'customer.db'
    Left = 116
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 20
    Top = 80
  end
end
