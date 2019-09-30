object fEditDBXConn: TfEditDBXConn
  Left = 279
  Top = 188
  AutoScroll = False
  Caption = 'Edit DBExpress Connection'
  ClientHeight = 202
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    592
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object ValueListEditor1: TValueListEditor
    Left = 288
    Top = 7
    Width = 297
    Height = 188
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    OnSetEditText = ValueListEditor1SetEditText
    ColWidths = (
      142
      149)
  end
  object cbConnectionName: TDBComboBoxEh
    Left = 111
    Top = 8
    Width = 169
    Height = 21
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 1
    Text = 'cbConnectionName'
    Visible = True
    OnChange = cbConnectionNameChange
  end
  object StaticText1: TStaticText
    Left = 16
    Top = 8
    Width = 87
    Height = 17
    Caption = 'Connection name'
    TabOrder = 2
  end
  object cbDriverName: TDBComboBoxEh
    Left = 111
    Top = 32
    Width = 169
    Height = 21
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 3
    Text = 'cbDriverName'
    Visible = True
    OnChange = cbDriverNameChange
  end
  object StaticText2: TStaticText
    Left = 16
    Top = 32
    Width = 61
    Height = 17
    Caption = 'Driver name'
    TabOrder = 4
  end
  object cbLibraryName: TDBComboBoxEh
    Left = 111
    Top = 56
    Width = 169
    Height = 21
    EditButtons = <>
    TabOrder = 5
    Text = 'cbLibraryName'
    Visible = True
    OnChange = cbLibraryNameChange
  end
  object StaticText3: TStaticText
    Left = 16
    Top = 56
    Width = 64
    Height = 17
    Caption = 'Library name'
    TabOrder = 6
  end
  object cbVendorLib: TDBComboBoxEh
    Left = 111
    Top = 80
    Width = 169
    Height = 21
    EditButtons = <>
    TabOrder = 7
    Text = 'cbVendorLib'
    Visible = True
    OnChange = cbVendorLibChange
  end
  object StaticText4: TStaticText
    Left = 16
    Top = 80
    Width = 68
    Height = 17
    Caption = 'Vendor library'
    TabOrder = 8
  end
  object bbConnect: TBitBtn
    Left = 111
    Top = 112
    Width = 169
    Height = 23
    Caption = 'Test connection'
    TabOrder = 9
    OnClick = bbConnectClick
  end
  object bbOk: TBitBtn
    Left = 51
    Top = 171
    Width = 92
    Height = 23
    Anchors = [akLeft, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 10
  end
  object bbCancel: TBitBtn
    Left = 149
    Top = 171
    Width = 91
    Height = 23
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 11
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    Params.Strings = (
      'BlobSize=-1'
      'CommitRetain=False'
      'Database=database.gdb'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Password=masterkey'
      'RoleName=RoleName'
      'ServerCharSet='
      'SQLDialect=1'
      'Interbase TransIsolation=ReadCommited'
      'User_Name=sysdba'
      'WaitOnLocks=True')
    VendorLib = 'GDS32.DLL'
    Left = 8
    Top = 136
  end
end
