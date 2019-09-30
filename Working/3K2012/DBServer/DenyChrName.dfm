object DenyChrNameFrm: TDenyChrNameFrm
  Left = 529
  Top = 228
  Width = 431
  Height = 278
  BorderIcons = [biSystemMenu]
  Caption = #27880#20876#35282#33394#21517#36807#28388#35774#32622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = -1
    Width = 421
    Height = 242
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #36807#28388#21517#23383
      object GroupBox24: TGroupBox
        Left = 3
        Top = 4
        Width = 214
        Height = 206
        Caption = #36807#28388#21517#23383#21015#34920
        TabOrder = 0
        object sDisableNameList: TListBox
          Left = 8
          Top = 16
          Width = 197
          Height = 182
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 13
          TabOrder = 0
          OnClick = sDisableNameListClick
        end
      end
      object GroupBox25: TGroupBox
        Left = 221
        Top = 4
        Width = 185
        Height = 206
        TabOrder = 1
        object Label22: TLabel
          Left = 8
          Top = 44
          Width = 51
          Height = 13
          Caption = #35282#33394#21517#31216':'
        end
        object DisableName_Edt: TEdit
          Left = 64
          Top = 40
          Width = 97
          Height = 21
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
          OnChange = DisableName_EdtChange
        end
        object DisableName_Add: TButton
          Left = 32
          Top = 96
          Width = 57
          Height = 25
          Caption = #22686#21152'(&A)'
          Enabled = False
          TabOrder = 1
          OnClick = DisableName_AddClick
        end
        object DisableNameListDelete: TButton
          Left = 96
          Top = 96
          Width = 57
          Height = 25
          Caption = #21024#38500'(&D)'
          Enabled = False
          TabOrder = 2
          OnClick = DisableNameListDeleteClick
        end
      end
    end
  end
end
