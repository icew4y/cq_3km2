object Form1: TForm1
  Left = 399
  Top = 312
  Width = 464
  Height = 324
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 17
  object Splitter1: TSplitter
    Left = 157
    Top = 0
    Width = 12
    Height = 284
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 157
    Height = 284
    Align = alLeft
    ContraColCount = 0
    DataSource = MasterDS
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -14
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    VertScrollBar.Tracking = True
  end
  object DBGridEh2: TDBGridEh
    Left = 169
    Top = 0
    Width = 287
    Height = 284
    Align = alClient
    ContraColCount = 0
    DataSource = DetailDS
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -14
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -14
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object MasterTBL: TADOTable
    Active = True
    ConnectionString = 
      'FILE NAME=C:\Program Files\Common Files\System\OLE DB\Data Links' +
      '\DBDEMOS.udl'
    CursorType = ctStatic
    TableName = 'orders'
    Left = 16
    Top = 40
  end
  object DetailMemTBL: TMemTableEh
    Active = True
    DetailFields = 'orderno'
    MasterDetailSide = mdsOnSelfAfterProviderEh
    MasterFields = 'orderno'
    MasterSource = MasterDS
    Params = <
      item
        DataType = ftInteger
        Name = 'MasterKey'
        ParamType = ptInput
        Value = '1'
      end>
    DataDriver = DetailDataDrv
    ReadOnly = True
    Left = 196
    Top = 128
  end
  object MasterDS: TDataSource
    DataSet = MasterTBL
    Left = 72
    Top = 40
  end
  object DetailDS: TDataSource
    DataSet = DetailMemTBL
    Left = 256
    Top = 144
  end
  object DetailDataDrv: TADODataDriverEh
    ConnectionString = 
      'FILE NAME=C:\Program Files\Common Files\System\OLE DB\Data Links' +
      '\DBDEMOS.udl'
    SelectCommand.CommandText.Strings = (
      'SELECT * '
      'FROM items'
      'where OrderNo=:OrderNo')
    SelectCommand.Parameters = <
      item
        Name = 'OrderNo'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    UpdateCommand.Parameters = <>
    InsertCommand.Parameters = <>
    DeleteCommand.Parameters = <>
    GetrecCommand.Parameters = <>
    Left = 256
    Top = 96
  end
end
