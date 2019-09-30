object Form1: TForm1
  Left = 327
  Top = 143
  Width = 594
  Height = 378
  ActiveControl = Button1
  Caption = 
    'Interbase multi access DEMO. You can use single SQLDataDriverEh ' +
    'for different types of data access'
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
  object Label1: TLabel
    Left = 6
    Top = 6
    Width = 108
    Height = 13
    Caption = 'InterBase DB file name'
  end
  object RadioGroup1: TRadioGroup
    Left = 6
    Top = 32
    Width = 187
    Height = 97
    Caption = 'Data access type '
    ItemIndex = 0
    Items.Strings = (
      'BDE'
      'DB Express (D6 or higher)'
      'InterBase Express')
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 212
    Top = 35
    Width = 202
    Height = 94
    Lines.Strings = (
      'select * from country')
    TabOrder = 2
  end
  object Button1: TButton
    Left = 425
    Top = 34
    Width = 56
    Height = 18
    Caption = 'Execute'
    TabOrder = 3
    OnClick = Button1Click
  end
  object DBGridEh1: TDBGridEh
    Left = 5
    Top = 136
    Width = 572
    Height = 201
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    HorzScrollBar.Tracking = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    VertScrollBar.Tracking = True
  end
  object DBEditEh1: TDBEditEh
    Left = 184
    Top = 3
    Width = 230
    Height = 21
    EditButtons = <
      item
        Style = ebsEllipsisEh
        OnClick = DBEditEh1EditButtons0Click
      end>
    TabOrder = 0
    Text = 'country.gdb'
    Visible = True
  end
  object SQLDataDriverEh1: TSQLDataDriverEh
    DeleteCommand.Params = <>
    GetrecCommand.Params = <>
    InsertCommand.Params = <>
    SelectCommand.Params = <>
    SelectCommand.CommandText.Strings = (
      'select * from country')
    UpdateCommand.Params = <>
    Left = 14
    Top = 142
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 'COUNTRY.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 46
    Top = 220
  end
  object Database1: TDatabase
    DatabaseName = 'country'
    DriverName = 'INTRBASE'
    LoginPrompt = False
    Params.Strings = (
      'SERVER NAME=country.GDB'
      'USER NAME=sysdba'
      'PASSWORD=masterkey'
      'OPEN MODE=READ/WRITE'
      'SCHEMA CACHE SIZE=8'
      'LANGDRIVER='
      'SQLQRYMODE='
      'SQLPASSTHRU MODE=SHARED AUTOCOMMIT'
      'SCHEMA CACHE TIME=-1'
      'MAX ROWS=-1'
      'BATCH COUNT=200'
      'ENABLE SCHEMA CACHE=FALSE'
      'SCHEMA CACHE DIR='
      'ENABLE BCD=FALSE'
      'BLOBS TO CACHE=64'
      'BLOB SIZE=32'
      'WAIT ON LOCKS=FALSE'
      'COMMIT RETAIN=FALSE'
      'ROLE NAME=')
    SessionName = 'Default'
    Left = 14
    Top = 220
  end
  object MemTableEh1: TMemTableEh
    Params = <>
    DataDriver = SQLDataDriverEh1
    Left = 48
    Top = 142
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 82
    Top = 142
  end
  object IBTransaction1: TIBTransaction
    Active = False
    Left = 46
    Top = 248
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.GDB'
    InitialDir = '.'
    Left = 480
    Top = 4
  end
end
