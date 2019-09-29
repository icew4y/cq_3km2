object FrmChange: TFrmChange
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #37325#21517#21464#26356#35760#24405'('#20174#24211')'
  ClientHeight = 311
  ClientWidth = 929
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object grp1: TGroupBox
    Left = -1
    Top = 2
    Width = 231
    Height = 304
    Caption = 'ID'#26356#25913#26085#24535
    TabOrder = 0
    object lv1: TListView
      Left = 3
      Top = 18
      Width = 225
      Height = 281
      Columns = <
        item
          Caption = 'index'
          Width = 0
        end
        item
          Alignment = taCenter
          Caption = #21407#21517#31216
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #26032#21517#31216
          Width = 100
        end>
      GridLines = True
      OwnerData = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnData = lv1Data
    end
  end
  object grp2: TGroupBox
    Left = 230
    Top = 2
    Width = 232
    Height = 305
    Caption = #21517#23383#26356#25913#26085#24535
    TabOrder = 1
    object lv2: TListView
      Left = 3
      Top = 18
      Width = 226
      Height = 281
      Columns = <
        item
          Caption = 'index'
          Width = 0
        end
        item
          Alignment = taCenter
          Caption = #21407#21517#31216
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #26032#21517#31216
          Width = 100
        end>
      GridLines = True
      OwnerData = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnData = lv2Data
    end
  end
  object grp3: TGroupBox
    Left = 463
    Top = 2
    Width = 231
    Height = 305
    Caption = #34892#20250#21517#31216#26356#25913#26085#24535
    TabOrder = 2
    object lv3: TListView
      Left = 3
      Top = 21
      Width = 226
      Height = 281
      Columns = <
        item
          Caption = 'index'
          Width = 0
        end
        item
          Alignment = taCenter
          Caption = #21407#21517#31216
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #26032#21517#31216
          Width = 100
        end>
      GridLines = True
      OwnerData = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnData = lv3Data
    end
  end
  object GroupBox1: TGroupBox
    Left = 696
    Top = 2
    Width = 231
    Height = 305
    Caption = #38376#27966#21517#31216#26356#25913#26085#24535
    TabOrder = 3
    object Lv4: TListView
      Left = 2
      Top = 18
      Width = 226
      Height = 281
      Columns = <
        item
          Caption = 'index'
          Width = 0
        end
        item
          Alignment = taCenter
          Caption = #21407#21517#31216
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = #26032#21517#31216
          Width = 100
        end>
      GridLines = True
      OwnerData = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnData = Lv4Data
    end
  end
end
