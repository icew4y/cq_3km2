object DMFrm: TDMFrm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 386
  Top = 296
  Height = 172
  Width = 220
  object ADOConn: TADOConnection
    LoginPrompt = False
    Left = 16
    Top = 8
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 56
    Top = 8
  end
  object ADOSelect: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 104
    Top = 8
  end
  object ADODel: TADOQuery
    Connection = ADOConn
    Parameters = <>
    Left = 24
    Top = 88
  end
end
