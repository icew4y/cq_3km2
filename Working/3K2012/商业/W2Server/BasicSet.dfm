object FrmBasicSet: TFrmBasicSet
  Left = 238
  Top = 206
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 293
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 12
  object BtnSave: TButton
    Left = 236
    Top = 257
    Width = 75
    Height = 25
    Caption = #20445#23384'(&S)'
    TabOrder = 0
    OnClick = BtnSaveClick
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 328
    Height = 251
    ActivePage = TabSheet3
    Align = alTop
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #22522#26412#35774#32622
      object Label5: TLabel
        Left = 7
        Top = 38
        Width = 96
        Height = 12
        Caption = #25968#25454#24211#36830#25509#22320#22336#65306
      end
      object Label1: TLabel
        Left = 7
        Top = 14
        Width = 108
        Height = 12
        Caption = #27599#26085#26368#22823#29983#25104#27425#25968#65306
      end
      object EdtSqlLienk: TEdit
        Left = 121
        Top = 35
        Width = 175
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 0
      end
      object EdtMaxDayMakeNum: TEdit
        Left = 121
        Top = 9
        Width = 176
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = #37197#32622#22120#35774#32622
      ImageIndex = 1
      object Label4: TLabel
        Left = 19
        Top = 13
        Width = 144
        Height = 12
        Caption = #24403#21069#30331#24405#22120#37197#32622#22120#29256#26412#21495#65306
      end
      object Label6: TLabel
        Left = 19
        Top = 37
        Width = 132
        Height = 12
        Caption = #24403#21069#24341#25806#37197#32622#22120#29256#26412#21495#65306
      end
      object Label8: TLabel
        Left = 19
        Top = 61
        Width = 132
        Height = 12
        Caption = #24403#21069'1.76'#30331#24405#22120#29256#26412#21495#65306
      end
      object Label9: TLabel
        Left = 19
        Top = 84
        Width = 120
        Height = 12
        Caption = #24403#21069'1.76'#24341#25806#29256#26412#21495#65306
      end
      object Label7: TLabel
        Left = 19
        Top = 108
        Width = 132
        Height = 12
        Caption = #24403#21069#20195#29702#37197#32622#22120#29256#26412#21495#65306
      end
      object EdtLoginVersion: TEdit
        Left = 178
        Top = 10
        Width = 121
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 0
      end
      object EdtM2Version: TEdit
        Left = 178
        Top = 34
        Width = 121
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 1
      end
      object Edt176LoginVersion: TEdit
        Left = 178
        Top = 57
        Width = 121
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 2
      end
      object Edt176M2Version: TEdit
        Left = 178
        Top = 81
        Width = 121
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 3
      end
      object EdtW2Version: TEdit
        Left = 178
        Top = 105
        Width = 121
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 4
      end
    end
    object TabSheet3: TTabSheet
      Caption = #20854#20182#35774#32622
      ImageIndex = 2
      object Label2: TLabel
        Left = 7
        Top = 38
        Width = 108
        Height = 12
        Caption = #24403#21069#32593#20851#30340#29256#26412#21495#65306
      end
      object Label3: TLabel
        Left = 8
        Top = 61
        Width = 108
        Height = 12
        Caption = #24403#21069#30331#38470#22120#29256#26412#21495#65306
      end
      object Label10: TLabel
        Left = 7
        Top = 84
        Width = 132
        Height = 12
        Caption = #24403#21069'1.76'#32593#20851#30340#29256#26412#21495#65306
      end
      object Label11: TLabel
        Left = 8
        Top = 107
        Width = 132
        Height = 12
        Caption = #24403#21069'1.76'#30331#38470#22120#29256#26412#21495#65306
      end
      object EdtGateVersionNum: TEdit
        Left = 142
        Top = 35
        Width = 157
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 0
      end
      object EdtLoginVersionNum: TEdit
        Left = 142
        Top = 58
        Width = 157
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 1
      end
      object Edt176GateVersionNum: TEdit
        Left = 142
        Top = 81
        Width = 157
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 2
      end
      object Edt176LoginVersionNum: TEdit
        Left = 142
        Top = 104
        Width = 157
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 3
      end
    end
  end
end
