object frmViewList: TfrmViewList
  Left = 282
  Top = 163
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26597#30475#21015#34920#19968#20449#24687
  ClientHeight = 272
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object PageControlViewList: TPageControl
    Left = 0
    Top = 0
    Width = 554
    Height = 272
    ActivePage = TabSheet16
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #31105#27490#21046#36896#29289#21697
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox3: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #31105#27490#21046#36896#21015#34920
        TabOrder = 0
        object ListBoxDisableMakeList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableMakeListClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList1: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          MultiSelect = True
          TabOrder = 0
          OnClick = ListBoxitemList1Click
        end
      end
      object ButtonDisableMakeAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonDisableMakeAddClick
      end
      object ButtonDisableMakeDelete: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonDisableMakeDeleteClick
      end
      object ButtonDisableMakeSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonDisableMakeSaveClick
      end
      object ButtonDisableMakeAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 5
        OnClick = ButtonDisableMakeAddAllClick
      end
      object ButtonDisableMakeDeleteAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 6
        OnClick = ButtonDisableMakeDeleteAllClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20801#35768#21046#36896#29289#21697
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox2: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #29289#21697#21015#34920
        TabOrder = 0
        object ListBoxItemList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxItemListClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #20801#35768#21046#36896#21015#34920
        TabOrder = 1
        object ListBoxEnableMakeList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxEnableMakeListClick
        end
      end
      object ButtonEnableMakeAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonEnableMakeAddClick
      end
      object ButtonEnableMakeDelete: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonEnableMakeDeleteClick
      end
      object ButtonEnableMakeSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 4
        OnClick = ButtonEnableMakeSaveClick
      end
      object ButtonEnableMakeAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 5
        OnClick = ButtonEnableMakeAddAllClick
      end
      object ButtonEnableMakeDeleteAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 6
        OnClick = ButtonEnableMakeDeleteAllClick
      end
    end
    object TabSheet8: TTabSheet
      Hint = #28216#25103#26085#24535#36807#28388#65292#21487#20197#25351#23450#35760#24405#37027#20123#29289#21697#20135#29983#30340#26085#24535#65292#20174#32780#20943#23569#26085#24535#30340#22823#23567#12290
      Caption = #28216#25103#26085#24535#36807#28388
      ImageIndex = 8
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox8: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #35760#24405#29289#21697'/'#20107#20214#21015#34920
        TabOrder = 0
        object ListBoxGameLogList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxGameLogListClick
        end
      end
      object ButtonGameLogAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonGameLogAddClick
      end
      object ButtonGameLogDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonGameLogDelClick
      end
      object ButtonGameLogAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonGameLogAddAllClick
      end
      object ButtonGameLogDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonGameLogDelAllClick
      end
      object ButtonGameLogSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonGameLogSaveClick
      end
      object GroupBox9: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #20107#20214'/'#29289#21697#21015#34920
        TabOrder = 6
        object ListBoxitemList2: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList2Click
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #31105#27490#20256#36865#22320#22270
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox5: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #31105#27490#22320#22270#21015#34920
        TabOrder = 0
        object ListBoxDisableMoveMap: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableMoveMapClick
        end
      end
      object ButtonDisableMoveMapAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonDisableMoveMapAddClick
      end
      object ButtonDisableMoveMapDelete: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonDisableMoveMapDeleteClick
      end
      object ButtonDisableMoveMapAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonDisableMoveMapAddAllClick
      end
      object ButtonDisableMoveMapDeleteAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonDisableMoveMapDeleteAllClick
      end
      object ButtonDisableMoveMapSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonDisableMoveMapSaveClick
      end
      object GroupBox6: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #22320#22270#21015#34920
        TabOrder = 6
        object ListBoxMapList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxMapListClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #31105#27490#21457#35328#21015#34920
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox24: TGroupBox
        Left = 3
        Top = 4
        Width = 327
        Height = 177
        Caption = #31105#27490#21457#35328#21015#34920
        TabOrder = 0
        object ListBoxDisableSendMsg: TListBox
          Left = 8
          Top = 16
          Width = 313
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableSendMsgClick
        end
      end
      object GroupBox25: TGroupBox
        Left = 336
        Top = 4
        Width = 189
        Height = 177
        TabOrder = 1
        object Label22: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #35282#33394#21517#31216':'
        end
        object DisableSendMsg_Edt: TEdit
          Left = 64
          Top = 40
          Width = 97
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
          OnChange = DisableSendMsg_EdtChange
        end
        object ListBoxDisableSendMsgAdd: TButton
          Left = 32
          Top = 96
          Width = 57
          Height = 25
          Caption = #22686#21152'(&A)'
          Enabled = False
          TabOrder = 1
          OnClick = ListBoxDisableSendMsgAddClick
        end
        object ListBoxDisableSendMsgDelete: TButton
          Left = 96
          Top = 96
          Width = 57
          Height = 25
          Caption = #21024#38500'(&D)'
          Enabled = False
          TabOrder = 2
          OnClick = ListBoxDisableSendMsgDeleteClick
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #29289#21697#24080#21495#32465#23450
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridItemBindAccount: TStringGrid
        Left = 8
        Top = 8
        Width = 337
        Height = 177
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#30331#24405#24080#21495#32465#23450#65292#21482#26377#20197#32465#23450#30340#30331#24405#24080#21495#30331#24405#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697#12290
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindAccountClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox16: TGroupBox
        Left = 352
        Top = 8
        Width = 169
        Height = 177
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label6: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label7: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label8: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #32465#23450#24080#21495':'
        end
        object Label9: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindAcountMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindAcountModClick
        end
        object EditItemBindAccountItemIdx: TSpinEdit
          Left = 68
          Top = 39
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindAccountItemIdxChange
        end
        object EditItemBindAccountItemMakeIdx: TSpinEdit
          Left = 68
          Top = 63
          Width = 93
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindAccountItemMakeIdxChange
        end
        object EditItemBindAccountItemName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindAcountAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindAcountAddClick
        end
        object ButtonItemBindAcountRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindAcountRefClick
        end
        object ButtonItemBindAcountDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindAcountDelClick
        end
        object EditItemBindAccountName: TEdit
          Left = 68
          Top = 88
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 7
          OnChange = EditItemBindAccountNameChange
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #29289#21697#20154#29289#32465#23450
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridItemBindCharName: TStringGrid
        Left = 8
        Top = 8
        Width = 337
        Height = 177
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#20154#29289#21517#31216#32465#23450#65292#21482#26377#32465#23450#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697#12290
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindCharNameClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox17: TGroupBox
        Left = 352
        Top = 8
        Width = 169
        Height = 177
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label10: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label11: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label12: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #32465#23450#20154#29289':'
        end
        object Label13: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindCharNameMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindCharNameModClick
        end
        object EditItemBindCharNameItemIdx: TSpinEdit
          Left = 68
          Top = 39
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindCharNameItemIdxChange
        end
        object EditItemBindCharNameItemMakeIdx: TSpinEdit
          Left = 68
          Top = 63
          Width = 93
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindCharNameItemMakeIdxChange
        end
        object EditItemBindCharNameItemName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          Color = clScrollBar
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindCharNameAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindCharNameAddClick
        end
        object ButtonItemBindCharNameRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindCharNameRefClick
        end
        object ButtonItemBindCharNameDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindCharNameDelClick
        end
        object EditItemBindCharNameName: TEdit
          Left = 68
          Top = 88
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 7
          OnChange = EditItemBindCharNameNameChange
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #29289#21697'IP'#32465#23450
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridItemBindIPaddr: TStringGrid
        Left = 8
        Top = 8
        Width = 337
        Height = 177
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#30331#24405'IP'#22320#22336#32465#23450#65292#21482#26377#20197#32465#23450#30340#30331#24405'IP'#22320#22336#30331#24405#30340#20154#29289#25165#21487#20197#25140#19978#27492#29289#21697#12290
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemBindIPaddrClick
        ColWidths = (
          91
          63
          68
          88)
      end
      object GroupBox18: TGroupBox
        Left = 352
        Top = 8
        Width = 169
        Height = 177
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label14: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label15: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label16: TLabel
          Left = 8
          Top = 90
          Width = 42
          Height = 12
          Caption = #32465#23450'IP:'
        end
        object Label17: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindIPaddrMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindIPaddrModClick
        end
        object EditItemBindIPaddrItemIdx: TSpinEdit
          Left = 68
          Top = 39
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindIPaddrItemIdxChange
        end
        object EditItemBindIPaddrItemMakeIdx: TSpinEdit
          Left = 68
          Top = 63
          Width = 93
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemBindIPaddrItemMakeIdxChange
        end
        object EditItemBindIPaddrItemName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemBindIPaddrAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemBindIPaddrAddClick
        end
        object ButtonItemBindIPaddrRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemBindIPaddrRefClick
        end
        object ButtonItemBindIPaddrDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemBindIPaddrDelClick
        end
        object EditItemBindIPaddrName: TEdit
          Left = 68
          Top = 88
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 7
          OnChange = EditItemBindIPaddrNameChange
        end
      end
    end
    object TabSheet12: TTabSheet
      Caption = #29289#21697#21517#31216#33258#23450#20041
      ImageIndex = 12
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridItemNameList: TStringGrid
        Left = 8
        Top = 8
        Width = 337
        Height = 177
        ColCount = 3
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridItemNameListClick
        ColWidths = (
          97
          69
          145)
      end
      object GroupBox19: TGroupBox
        Left = 352
        Top = 8
        Width = 169
        Height = 177
        Caption = #29289#21697#33258#23450#20041#21517#31216
        TabOrder = 1
        object Label18: TLabel
          Left = 8
          Top = 42
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object Label19: TLabel
          Left = 8
          Top = 66
          Width = 54
          Height = 12
          Caption = #29289#21697#24207#21495':'
        end
        object Label20: TLabel
          Left = 8
          Top = 90
          Width = 54
          Height = 12
          Caption = #33258#23450#20041#21517':'
        end
        object Label21: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemNameMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemNameModClick
        end
        object EditItemNameIdx: TSpinEdit
          Left = 68
          Top = 39
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemNameIdxChange
        end
        object EditItemNameMakeIndex: TSpinEdit
          Left = 68
          Top = 63
          Width = 93
          Height = 21
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditItemNameMakeIndexChange
        end
        object EditItemNameOldName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 3
        end
        object ButtonItemNameAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 4
          OnClick = ButtonItemNameAddClick
        end
        object ButtonItemNameRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 5
          OnClick = ButtonItemNameRefClick
        end
        object ButtonItemNameDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 6
          OnClick = ButtonItemNameDelClick
        end
        object EditItemNameNewName: TEdit
          Left = 68
          Top = 88
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 7
          OnChange = EditItemNameNewNameChange
        end
      end
    end
    object TabSheetMonDrop: TTabSheet
      Caption = #24618#29289#29190#29289#21697
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object StringGridMonDropLimit: TStringGrid
        Left = 8
        Top = 8
        Width = 281
        Height = 177
        ColCount = 4
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = StringGridMonDropLimitClick
        ColWidths = (
          81
          64
          57
          52)
      end
      object GroupBox7: TGroupBox
        Left = 296
        Top = 1
        Width = 169
        Height = 192
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object Label29: TLabel
          Left = 8
          Top = 39
          Width = 54
          Height = 12
          Caption = #24050#29190#25968#37327':'
        end
        object Label1: TLabel
          Left = 8
          Top = 63
          Width = 54
          Height = 12
          Caption = #38480#21046#25968#37327':'
        end
        object Label2: TLabel
          Left = 8
          Top = 87
          Width = 54
          Height = 12
          Caption = #26410#29190#25968#37327':'
        end
        object Label3: TLabel
          Left = 8
          Top = 15
          Width = 48
          Height = 12
          Caption = #29289#21697#21517#31216
        end
        object ButtonMonDropLimitSave: TButton
          Left = 96
          Top = 107
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonMonDropLimitSaveClick
        end
        object EditDropCount: TSpinEdit
          Left = 68
          Top = 36
          Width = 61
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 1
          Value = 10
          OnChange = EditDropCountChange
        end
        object EditCountLimit: TSpinEdit
          Left = 68
          Top = 60
          Width = 61
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 2
          Value = 10
          OnChange = EditCountLimitChange
        end
        object EditNoDropCount: TSpinEdit
          Left = 68
          Top = 84
          Width = 61
          Height = 21
          MaxValue = 100000
          MinValue = 0
          TabOrder = 3
          Value = 10
          OnChange = EditNoDropCountChange
        end
        object EditItemName: TEdit
          Left = 68
          Top = 13
          Width = 89
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 4
        end
        object ButtonMonDropLimitAdd: TButton
          Left = 8
          Top = 107
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 5
          OnClick = ButtonMonDropLimitAddClick
        end
        object ButtonMonDropLimitRef: TButton
          Left = 96
          Top = 134
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 6
          OnClick = ButtonMonDropLimitRefClick
        end
        object ButtonMonDropLimitDel: TButton
          Left = 8
          Top = 135
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 7
          OnClick = ButtonMonDropLimitDelClick
        end
        object ButtonMonDropLimitClear: TButton
          Left = 9
          Top = 162
          Width = 65
          Height = 25
          Hint = #29190#25968#37327#12289#26410#29190#25968#37327#28165'0'
          Caption = #21021#22987#37197#32622
          TabOrder = 8
          OnClick = ButtonMonDropLimitClearClick
        end
      end
    end
    object TabSheet9: TTabSheet
      Hint = #31105#27490#21462#19979#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#25140#22312#36523#19978#21518#23558#19981#21487#20197#21462#19979#26469#65292#27515#20129#20063#19981#20250#25481#33853#12290
      Caption = #31105#27490#21462#19979#29289#21697
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox10: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #31105#27490#21462#19979#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxDisableTakeOffList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          Hint = #31105#27490#21462#19979#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#25140#22312#36523#19978#21518#23558#19981#21487#20197#21462#19979#26469#65292#27515#20129#20063#19981#20250#25481#33853#12290
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxDisableTakeOffListClick
        end
      end
      object ButtonDisableTakeOffAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonDisableTakeOffAddClick
      end
      object ButtonDisableTakeOffDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonDisableTakeOffDelClick
      end
      object ButtonDisableTakeOffAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonDisableTakeOffAddAllClick
      end
      object ButtonDisableTakeOffDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonDisableTakeOffDelAllClick
      end
      object ButtonDisableTakeOffSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonDisableTakeOffSaveClick
      end
      object GroupBox11: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #29289#21697#21015#34920
        TabOrder = 6
        object ListBoxitemList3: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList3Click
        end
      end
    end
    object TabSheet13: TTabSheet
      Caption = #20801#35768#23492#21806#29289#21697
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox20: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #20801#35768#23492#21806#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxSellOffList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          Hint = #20801#35768#23492#21806#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#25165#21487#20197#36827#34892#25293#21334
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxSellOffListClick
        end
      end
      object GroupBox21: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList4: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList4Click
        end
      end
      object ButtonSellOffAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonSellOffAddClick
      end
      object ButtonSellOffDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonSellOffDelClick
      end
      object ButtonSellOffAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonSellOffAddAllClick
      end
      object ButtonSellOffDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 5
        OnClick = ButtonSellOffDelAllClick
      end
      object ButtonSellOffSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonSellOffSaveClick
      end
    end
    object TabSheet11: TTabSheet
      Caption = #31105#27490#28165#29702#24618#29289#21015#34920
      ImageIndex = 11
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox13: TGroupBox
        Left = 8
        Top = 3
        Width = 177
        Height = 177
        Caption = #31105#27490#28165#29702#24618#29289#21015#34920
        TabOrder = 0
        object ListBoxNoClearMonList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          Hint = #31105#27490#28165#38500#24618#29289#35774#32622#65292#29992#20110#33050#26412#21629#20196'CLEARMAPMON'#65292#21152#20837#27492#21015#34920#30340#24618#29289#65292#22312#20351#29992#27492#33050#26412#21629#20196#26102#19981#20250#34987#28165#38500#12290
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxNoClearMonListClick
        end
      end
      object ButtonNoClearMonAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonNoClearMonAddClick
      end
      object ButtonNoClearMonDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonNoClearMonDelClick
      end
      object ButtonNoClearMonAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonNoClearMonAddAllClick
      end
      object ButtonNoClearMonDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonNoClearMonDelAllClick
      end
      object ButtonNoClearMonSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonNoClearMonSaveClick
      end
      object GroupBox14: TGroupBox
        Left = 288
        Top = 3
        Width = 177
        Height = 177
        Caption = #24618#29289#21015#34920
        TabOrder = 6
        object ListBoxMonList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxMonListClick
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = #31649#29702#21592#21015#34920
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox12: TGroupBox
        Left = 8
        Top = 4
        Width = 273
        Height = 177
        Caption = #31649#29702#21592#21015#34920
        TabOrder = 0
        object ListBoxAdminList: TListBox
          Left = 8
          Top = 16
          Width = 257
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxAdminListClick
        end
      end
      object GroupBox15: TGroupBox
        Left = 312
        Top = 4
        Width = 209
        Height = 141
        Caption = #31649#29702#21592#20449#24687
        TabOrder = 1
        object Label4: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = #35282#33394#21517#31216':'
        end
        object Label5: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #35282#33394#31561#32423':'
        end
        object LabelAdminIPaddr: TLabel
          Left = 8
          Top = 68
          Width = 42
          Height = 12
          Caption = #30331#24405'IP:'
        end
        object EditAdminName: TEdit
          Left = 64
          Top = 16
          Width = 97
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
        end
        object EditAdminPremission: TSpinEdit
          Left = 64
          Top = 39
          Width = 61
          Height = 21
          MaxValue = 10
          MinValue = 1
          TabOrder = 1
          Value = 10
        end
        object ButtonAdminListAdd: TButton
          Left = 16
          Top = 104
          Width = 57
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 2
          OnClick = ButtonAdminListAddClick
        end
        object ButtonAdminListChange: TButton
          Left = 80
          Top = 104
          Width = 57
          Height = 25
          Caption = #20462#25913'(&M)'
          TabOrder = 3
          OnClick = ButtonAdminListChangeClick
        end
        object ButtonAdminListDel: TButton
          Left = 144
          Top = 104
          Width = 57
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 4
          OnClick = ButtonAdminListDelClick
        end
        object EditAdminIPaddr: TEdit
          Left = 64
          Top = 64
          Width = 97
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 5
        end
      end
      object ButtonAdminLitsSave: TButton
        Left = 464
        Top = 152
        Width = 57
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 2
        OnClick = ButtonAdminLitsSaveClick
      end
    end
    object TabSheet14: TTabSheet
      Caption = #20998#36523'('#33521#38596')'#25441#21462#29289#21697
      ImageIndex = 14
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox22: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #20998#36523#20801#35768#25441#21462#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxAllowPickUpItem: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          Hint = #20801#35768#20998#36523#25441#21462#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#20998#36523#25165#20250#25441#21462
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxAllowPickUpItemClick
        end
      end
      object GroupBox23: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList5: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList5Click
        end
      end
      object ButtonPickItemAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonPickItemAddClick
      end
      object ButtonPickItemDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonPickItemDelClick
      end
      object ButtonPickItemAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonPickItemAddAllClick
      end
      object ButtonPickItemDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 5
        OnClick = ButtonPickItemDelAllClick
      end
      object ButtonPickItemSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonPickItemSaveClick
      end
    end
    object ts1: TTabSheet
      Caption = #27515#20129#19981#29190#20986#32465#23450
      ImageIndex = 15
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GridITemBindDieName: TStringGrid
        Left = 3
        Top = 1
        Width = 342
        Height = 188
        Hint = #21152#20837#27492#21015#34920#20013#30340#29289#21697#23558#19982#25351#23450#30340#20154#29289#21517#31216#32465#23450#65292#32465#23450#21518#65292#20154#29289#23545#24212#29289#21697#27515#20129#19981#29190#20986#12290
        ColCount = 3
        DefaultRowHeight = 18
        FixedCols = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
        OnClick = GridITemBindDieNameClick
        ColWidths = (
          119
          63
          132)
      end
      object grp1: TGroupBox
        Left = 364
        Top = 13
        Width = 170
        Height = 177
        Caption = #35268#21017#35774#32622
        TabOrder = 1
        object lbl1: TLabel
          Left = 8
          Top = 46
          Width = 48
          Height = 12
          Caption = #29289#21697'IDX:'
        end
        object lbl3: TLabel
          Left = 8
          Top = 73
          Width = 54
          Height = 12
          Caption = #32465#23450#20154#29289':'
        end
        object lbl4: TLabel
          Left = 8
          Top = 18
          Width = 54
          Height = 12
          Caption = #29289#21697#21517#31216':'
        end
        object ButtonItemBindDieNameMod: TButton
          Left = 96
          Top = 112
          Width = 65
          Height = 25
          Caption = #20462#25913'(&S)'
          TabOrder = 0
          OnClick = ButtonItemBindDieNameModClick
        end
        object EditItemBindDieNameItemIdx: TSpinEdit
          Left = 68
          Top = 43
          Width = 93
          Height = 21
          MaxValue = 5000
          MinValue = 1
          TabOrder = 1
          Value = 10
          OnChange = EditItemBindDieNameItemIdxChange
        end
        object EditItemBindDieNameItemName: TEdit
          Left = 68
          Top = 16
          Width = 93
          Height = 20
          Color = clScrollBar
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 2
        end
        object ButtonItemBindDieNameAdd: TButton
          Left = 8
          Top = 112
          Width = 65
          Height = 25
          Caption = #22686#21152'(&A)'
          TabOrder = 3
          OnClick = ButtonItemBindDieNameAddClick
        end
        object ButtonItemBindDieNameRef: TButton
          Left = 96
          Top = 144
          Width = 65
          Height = 25
          Caption = #21047#26032'(&R)'
          TabOrder = 4
          OnClick = ButtonItemBindDieNameRefClick
        end
        object ButtonItemBindDieNameDel: TButton
          Left = 8
          Top = 144
          Width = 65
          Height = 25
          Caption = #21024#38500'(&D)'
          TabOrder = 5
          OnClick = ButtonItemBindDieNameDelClick
        end
        object EditItemBindDieNameName: TEdit
          Left = 68
          Top = 71
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 6
        end
      end
    end
    object TabSheet15: TTabSheet
      Caption = #20817#25442#21367#36724#30862#29255
      ImageIndex = 16
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label23: TLabel
        Left = 201
        Top = 66
        Width = 54
        Height = 12
        Caption = #29289#21697#21517#31216':'
      end
      object Label24: TLabel
        Left = 201
        Top = 90
        Width = 54
        Height = 12
        Caption = #21487#20817#25442#37327':'
      end
      object GroupBox26: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #21487#20817#25442#21367#36724#30862#29255#21015#34920
        TabOrder = 0
        object ListBoxArmsExchangeList: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxArmsExchangeListClick
        end
      end
      object ButtonEnableArmsExchangeAdd: TButton
        Left = 201
        Top = 119
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 1
        OnClick = ButtonEnableArmsExchangeAddClick
      end
      object ButtonEnableArmsExchangeDelete: TButton
        Left = 285
        Top = 119
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 2
        OnClick = ButtonEnableArmsExchangeDeleteClick
      end
      object ButtonEnableArmsExchangeSave: TButton
        Left = 285
        Top = 151
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 3
        OnClick = ButtonEnableArmsExchangeSaveClick
      end
      object GroupBox27: TGroupBox
        Left = 366
        Top = 3
        Width = 177
        Height = 177
        Caption = #29289#21697#21015#34920
        TabOrder = 4
        object ListBoxItemList6: TListBox
          Left = 9
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxItemList6Click
        end
      end
      object Edit1: TEdit
        Left = 257
        Top = 62
        Width = 97
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 5
      end
      object SpinEdit1: TSpinEdit
        Left = 261
        Top = 84
        Width = 61
        Height = 21
        MaxValue = 999
        MinValue = 1
        TabOrder = 6
        Value = 10
      end
    end
    object TabSheet16: TTabSheet
      Caption = #20551#20154#25441#21462#29289#21697
      ImageIndex = 17
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox28: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #20551#20154#20801#35768#25441#21462#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxAllowAIPickUpItem: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          Hint = #20801#35768#20551#20154#25441#21462#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#20551#20154#25165#20250#25441#21462
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxAllowAIPickUpItemClick
        end
      end
      object GroupBox29: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxitemList7: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList7Click
        end
      end
      object ButtonAIPickItemAdd: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonAIPickItemAddClick
      end
      object ButtonAIPickItemDel: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonAIPickItemDelClick
      end
      object ButtonAIPickItemAddAll: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonAIPickItemAddAllClick
      end
      object ButtonAIPickItemDelAll: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 5
        OnClick = ButtonAIPickItemDelAllClick
      end
      object ButtonAIPickItemSave: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonAIPickItemSaveClick
      end
    end
    object TabSheet17: TTabSheet
      Caption = #38480#26102#29289#21697
      ImageIndex = 18
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label25: TLabel
        Left = 201
        Top = 66
        Width = 54
        Height = 12
        Caption = #29289#21697#21517#31216':'
      end
      object Label26: TLabel
        Left = 201
        Top = 90
        Width = 54
        Height = 12
        Caption = #21487#29992#23567#26102':'
      end
      object GroupBox30: TGroupBox
        Left = 8
        Top = 1
        Width = 177
        Height = 186
        Caption = #38480#26102#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxLimitItemList: TListBox
          Left = 2
          Top = 14
          Width = 173
          Height = 170
          Align = alClient
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxLimitItemListClick
        end
      end
      object GroupBox31: TGroupBox
        Left = 366
        Top = 0
        Width = 177
        Height = 186
        Caption = #29289#21697#21015#34920
        TabOrder = 1
        object ListBoxItemList8: TListBox
          Left = 2
          Top = 14
          Width = 173
          Height = 170
          Align = alClient
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxItemList8Click
        end
      end
      object Edit2: TEdit
        Left = 257
        Top = 62
        Width = 97
        Height = 20
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 2
      end
      object SpinEdit2: TSpinEdit
        Left = 257
        Top = 86
        Width = 61
        Height = 21
        MaxValue = 65535
        MinValue = 1
        TabOrder = 3
        Value = 24
      end
      object ButtonLimitItemListAdd: TButton
        Left = 201
        Top = 119
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 4
        OnClick = ButtonLimitItemListAddClick
      end
      object ButtonLimitItemListDelete: TButton
        Left = 285
        Top = 119
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 5
        OnClick = ButtonLimitItemListDeleteClick
      end
      object ButtonLimitItemListSave: TButton
        Left = 285
        Top = 151
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = ButtonLimitItemListSaveClick
      end
    end
    object TabSheet18: TTabSheet
      Caption = #31105#27490#33635#32768#28857#36141#20080
      ImageIndex = 19
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox32: TGroupBox
        Left = 288
        Top = 4
        Width = 177
        Height = 177
        Caption = #29289#21697#21015#34920
        TabOrder = 0
        object ListBoxitemList9: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxitemList9Click
        end
      end
      object GroupBox33: TGroupBox
        Left = 8
        Top = 4
        Width = 177
        Height = 177
        Caption = #20801#35768#36141#20080#29289#21697#21015#34920
        TabOrder = 1
        object ListBoxAllowShopItem: TListBox
          Left = 8
          Top = 16
          Width = 161
          Height = 153
          Hint = #20801#35768#20551#20154#25441#21462#29289#21697#35774#32622#65292#21152#20837#27492#21015#34920#30340#29289#21697#20551#20154#25165#20250#25441#21462
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 12
          TabOrder = 0
          OnClick = ListBoxAllowShopItemClick
        end
      end
      object Button1: TButton
        Left = 200
        Top = 24
        Width = 73
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 200
        Top = 56
        Width = 73
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 200
        Top = 88
        Width = 73
        Height = 25
        Caption = #20840#37096#22686#21152'(&A)'
        TabOrder = 4
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 200
        Top = 120
        Width = 73
        Height = 25
        Caption = #20840#37096#21024#38500'(&D)'
        TabOrder = 5
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 200
        Top = 152
        Width = 73
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 6
        OnClick = Button5Click
      end
    end
  end
end
