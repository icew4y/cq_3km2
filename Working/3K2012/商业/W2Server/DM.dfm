object FrmDm: TFrmDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 332
  Width = 329
  object ADOconn: TADOConnection
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 8
  end
  object ADOQueryAddUser: TADOQuery
    Connection = ADOconn
    Parameters = <>
    Left = 24
    Top = 64
  end
  object ADOQueryLogin: TADOQuery
    Connection = ADOconn
    Parameters = <>
    Left = 24
    Top = 120
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConn2
    Parameters = <>
    Left = 240
    Top = 88
  end
  object ADOConn2: TADOConnection
    LoginPrompt = False
    Left = 192
    Top = 88
  end
end
