object fDesignConnectionListEh: TfDesignConnectionListEh
  Left = 304
  Top = 114
  AutoScroll = False
  Caption = 'Active design connections'
  ClientHeight = 322
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultSizeOnly
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 41
    Width = 588
    Height = 281
    Align = alClient
    AutoFitColWidths = True
    DataSource = DataSource1
    Flat = True
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Style = []
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Style = []
    UseMultiTitle = True
    Columns = <
      item
        EditButtons = <>
        FieldName = 'ConnectionName'
        Footers = <>
        Title.Caption = 'Connection Name'
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'Engine'
        Footers = <>
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'ServerType'
        Footers = <>
        Width = 100
      end
      item
        EditButtons = <>
        FieldName = 'Connected'
        Footers = <>
        Width = 26
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 588
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object bSelect: TButton
      Left = 14
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Select'
      ModalResult = 1
      TabOrder = 0
      OnClick = bSelectClick
    end
    object bNew: TButton
      Left = 282
      Top = 10
      Width = 75
      Height = 25
      Caption = '&New'
      TabOrder = 1
      OnClick = bNewClick
    end
    object bDelete: TButton
      Left = 362
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Delete'
      TabOrder = 2
      OnClick = bDeleteClick
    end
    object bCancel: TButton
      Left = 93
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 3
    end
    object bEdit: TButton
      Left = 202
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Edit'
      TabOrder = 4
      OnClick = bEditClick
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    OnDataChange = DataSource1DataChange
    Left = 14
    Top = 98
  end
  object MemTableEh1: TMemTableEh
    Active = True
    FieldDefs = <
      item
        Name = 'ConnectionName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Engine'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ServerType'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Connected'
        DataType = ftBoolean
      end
      item
        Name = 'RefObject'
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 50
    Top = 98
    object MemTableEh1ConnectionName: TStringField
      DisplayWidth = 18
      FieldName = 'ConnectionName'
      Size = 255
    end
    object MemTableEh1Engine: TStringField
      DisplayWidth = 12
      FieldName = 'Engine'
      Size = 255
    end
    object MemTableEh1ServerType: TStringField
      DisplayWidth = 14
      FieldName = 'ServerType'
      Size = 255
    end
    object MemTableEh1Connected: TBooleanField
      DisplayWidth = 5
      FieldName = 'Connected'
    end
    object MemTableEh1RefObject: TRefObjectField
      FieldName = 'RefObject'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object ConnectionName: TMTStringDataFieldEh
          FieldName = 'ConnectionName'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 255
          Transliterate = False
        end
        object Engine: TMTStringDataFieldEh
          FieldName = 'Engine'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 255
          Transliterate = False
        end
        object ServerType: TMTStringDataFieldEh
          FieldName = 'ServerType'
          StringDataType = fdtStringEh
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
          Size = 255
          Transliterate = False
        end
        object Connected: TMTBooleanDataFieldEh
          FieldName = 'Connected'
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
        end
        object RefObject: TMTRefObjectFieldEh
          FieldName = 'RefObject'
          Alignment = taLeftJustify
          DisplayWidth = 0
          Required = False
          Visible = False
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
end
