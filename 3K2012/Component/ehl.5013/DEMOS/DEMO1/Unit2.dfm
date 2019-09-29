object Form2: TForm2
  Left = 584
  Top = 194
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Form2'
  ClientHeight = 227
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Microsoft Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 323
    Height = 227
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'Panel2'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object DBGridEh1: TDBGridEh
      Left = 0
      Top = 0
      Width = 296
      Height = 225
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource1
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'Microsoft Sans Serif'
      FooterFont.Style = []
      HorzScrollBar.Visible = False
      Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghTraceColSizing]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Microsoft Sans Serif'
      TitleFont.Style = []
      VertScrollBar.Tracking = True
      OnColWidthsChanged = DBGridEh1ColWidthsChanged
      OnDblClick = DBGridEh1DblClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'VendorNo'
          Footers = <>
          Width = 63
        end
        item
          EditButtons = <>
          FieldName = 'VendorName'
          Footers = <>
          Width = 215
        end>
    end
    object Panel1: TPanel
      Left = 296
      Top = 0
      Width = 25
      Height = 225
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object SpeedButton1: TSpeedButton
        Left = 2
        Top = 0
        Width = 23
        Height = 23
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          7777777744777777777777742247777777777742222477777777742222224777
          77774222A22224777777222A7A2224777777A2A777A2224777777A77777A2224
          777777777777A2224777777777777A2224777777777777A2224777777777777A
          2224777777777777A2247777777777777A2277777777777777A7}
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 2
        Top = 24
        Width = 23
        Height = 22
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000010000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00778877777777
          7777791187777798777779111877791187777911118791111877779111181111
          1877777911111111877777779111111877777777711111877777777779111187
          7777777791111187777777791118111877777791118791118777779118777911
          1877777917777791117777777777777919777777777777777777}
        OnClick = SpeedButton2Click
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 18
    Top = 20
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    ReadOnly = True
    TableName = 'VENDORS.DB'
    Left = 46
    Top = 20
  end
end
