object FrmDM: TFrmDM
  OldCreateOrder = False
  Height = 210
  Width = 236
  object DataSourceMagic: TDataSource
    DataSet = TableMagic
    Left = 20
  end
  object TableMagic: TTable
    AutoRefresh = True
    TableName = 'Magic.DB'
    Left = 76
  end
  object TableMonster: TTable
    AutoRefresh = True
    TableName = 'Monster.DB'
    Left = 76
    Top = 48
  end
  object DataSourceMonster: TDataSource
    DataSet = TableMonster
    Left = 20
    Top = 48
  end
  object DataSourceStdItems: TDataSource
    DataSet = TableStdItems
    Left = 20
    Top = 104
  end
  object TableStdItems: TTable
    AutoRefresh = True
    TableName = 'StdItems.DB'
    Left = 76
    Top = 104
  end
  object Query1: TQuery
    Left = 152
    Top = 104
  end
  object DataSourceFongHao: TDataSource
    DataSet = TableFongHao
    Left = 20
    Top = 152
  end
  object TableFongHao: TTable
    AutoRefresh = True
    TableName = 'FengHaos.DB'
    Left = 76
    Top = 152
  end
end
