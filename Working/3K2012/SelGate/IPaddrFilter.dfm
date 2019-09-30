object frmIPaddrFilter: TfrmIPaddrFilter
  Left = 391
  Top = 375
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #32593#32476#23433#20840#36807#28388
  ClientHeight = 329
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBoxActive: TGroupBox
    Left = 8
    Top = 8
    Width = 137
    Height = 281
    Caption = #24403#21069#36830#25509
    TabOrder = 0
    object Label4: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = #36830#25509#21015#34920':'
    end
    object ListBoxActiveList: TListBox
      Left = 8
      Top = 40
      Width = 121
      Height = 233
      Hint = #24403#21069#36830#25509#30340'IP'#22320#22336#21015#34920
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      MultiSelect = True
      ParentShowHint = False
      PopupMenu = ActiveListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 0
    end
  end
  object GroupBox1: TGroupBox
    Left = 152
    Top = 8
    Width = 265
    Height = 281
    Caption = #36807#28388#21015#34920
    TabOrder = 1
    object LabelTempList: TLabel
      Left = 8
      Top = 24
      Width = 54
      Height = 12
      Caption = #21160#24577#36807#28388':'
    end
    object Label1: TLabel
      Left = 136
      Top = 24
      Width = 54
      Height = 12
      Caption = #27704#20037#36807#28388':'
    end
    object ListBoxTempList: TListBox
      Left = 8
      Top = 40
      Width = 121
      Height = 233
      Hint = #21160#24577#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#20294#22312#31243#24207#37325#26032#21551#21160#26102#27492#21015#34920#30340#20449#24687#23558#34987#28165#31354
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      MultiSelect = True
      ParentShowHint = False
      PopupMenu = TempBlockListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 0
    end
    object ListBoxBlockList: TListBox
      Left = 136
      Top = 40
      Width = 121
      Height = 233
      Hint = #27704#20037#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#27492#21015#34920#23558#20445#23384#20110#37197#32622#25991#20214#20013#65292#22312#31243#24207#37325#26032#21551#21160#26102#20250#37325#26032#21152#36733#27492#21015#34920
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 12
      Items.Strings = (
        '888.888.888.888')
      MultiSelect = True
      ParentShowHint = False
      PopupMenu = BlockListPopupMenu
      ShowHint = True
      Sorted = True
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 424
    Top = 8
    Width = 193
    Height = 281
    Caption = #25915#20987#20445#25252
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 58
      Width = 54
      Height = 12
      Caption = #36830#25509#38480#21046':'
    end
    object Label3: TLabel
      Left = 136
      Top = 58
      Width = 42
      Height = 12
      Caption = #36830#25509'/IP'
    end
    object Label7: TLabel
      Left = 40
      Top = 262
      Width = 120
      Height = 12
      Caption = #20197#19978#21442#25968#35843#21518#31435#21363#29983#25928
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 8
      Top = 79
      Width = 84
      Height = 12
      Caption = #38450#24481#31561#32423#35843#25972#65306
    end
    object Label9: TLabel
      Left = 8
      Top = 16
      Width = 138
      Height = 12
      Caption = #21333'IP         '#27627#31186#21487#36830#25509
    end
    object Label8: TLabel
      Left = 9
      Top = 36
      Width = 54
      Height = 12
      Caption = #38750#27861#36830#25509':'
    end
    object EditMaxConnect: TSpinEdit
      Left = 64
      Top = 54
      Width = 65
      Height = 21
      Hint = #21333#20010'IP'#22320#22336#65292#26368#22810#21487#20197#24314#31435#36830#25509#25968#65292#36229#36807#25351#23450#36830#25509#25968#23558#25353#19979#38754#30340#25805#20316#22788#29702
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 50
      OnChange = EditMaxConnectChange
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 186
      Width = 177
      Height = 71
      Caption = #25915#20987#25805#20316
      TabOrder = 1
      object RadioAddBlockList: TRadioButton
        Left = 16
        Top = 50
        Width = 129
        Height = 17
        Hint = #23558#27492#36830#25509#30340'IP'#21152#20837#27704#20037#36807#28388#21015#34920#65292#24182#23558#27492'IP'#30340#25152#26377#36830#25509#24378#34892#20013#26029
        Caption = #21152#20837#27704#20037#36807#28388#21015#34920
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = RadioAddBlockListClick
      end
      object RadioAddTempList: TRadioButton
        Left = 16
        Top = 31
        Width = 129
        Height = 17
        Hint = #23558#27492#36830#25509#30340'IP'#21152#20837#21160#24577#36807#28388#21015#34920#65292#24182#23558#27492'IP'#30340#25152#26377#36830#25509#24378#34892#20013#26029
        Caption = #21152#20837#21160#24577#36807#28388#21015#34920
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = RadioAddTempListClick
      end
      object RadioDisConnect: TRadioButton
        Left = 16
        Top = 16
        Width = 129
        Height = 17
        Hint = #23558#36830#25509#31616#21333#30340#26029#24320#22788#29702
        Caption = #26029#24320#36830#25509
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = RadioDisConnectClick
      end
    end
    object TrackBarAttack: TTrackBar
      Left = 8
      Top = 92
      Width = 177
      Height = 33
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnChange = TrackBarAttackChange
    end
    object CheckBoxChg: TCheckBox
      Left = 8
      Top = 126
      Width = 129
      Height = 17
      Caption = #35843#25972#38450#24481#31561#32423#20026'1'#32423
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = CheckBoxChgClick
    end
    object CheckBoxAutoClearTempList: TCheckBox
      Left = 8
      Top = 147
      Width = 121
      Height = 17
      Caption = #28165#38500#21160#24577#36807#28388#21015#34920
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = CheckBoxAutoClearTempListClick
    end
    object SpinEdit2: TSpinEdit
      Left = 136
      Top = 144
      Width = 41
      Height = 21
      Hint = #31186
      MaxValue = 10000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Value = 1
      OnChange = SpinEdit2Change
    end
    object CheckBoxReliefDefend: TCheckBox
      Left = 8
      Top = 168
      Width = 129
      Height = 17
      Caption = #26080#25915#20987#36824#21407#38450#24481#31561#32423
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = CheckBoxReliefDefendClick
    end
    object SpinEdit3: TSpinEdit
      Left = 136
      Top = 165
      Width = 41
      Height = 21
      Hint = #31186
      MaxValue = 10000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Value = 1
      OnChange = SpinEdit3Change
    end
    object SpinEdit1: TSpinEdit
      Left = 136
      Top = 122
      Width = 41
      Height = 21
      Hint = #27425
      MaxValue = 1000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Value = 1
      OnChange = SpinEdit1Change
    end
    object SpinEdit4: TSpinEdit
      Left = 32
      Top = 12
      Width = 55
      Height = 21
      Hint = #19968#20010'IP'#22312#25351#23450#30340#26102#38388#20869#21487#36830#20987#30340#27425#25968#65292#36229#36807#27425#25968#21017#35748#20026#26159#25915#20987
      Increment = 100
      MaxValue = 65535
      MinValue = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Value = 100
      OnChange = SpinEdit4Change
    end
    object SpinEdit5: TSpinEdit
      Left = 145
      Top = 10
      Width = 43
      Height = 21
      Hint = #27425
      MaxValue = 1000
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      Value = 1
      OnChange = SpinEdit5Change
    end
    object EditMaxConnOfNoLegal: TSpinEdit
      Left = 65
      Top = 32
      Width = 65
      Height = 21
      Hint = #21333#20010'IP'#22320#22336#65292#38750#27861#36830#25509#27425#25968#65292#36229#36807#35774#32622#20540#23558#25353#36827#34892#25915#20987#25805#20316#22788#29702#65292#21482#23545#21160#24577#21644#27704#20037#36807#28388#21015#34920#36215#20316#29992
      EditorEnabled = False
      MaxValue = 1000
      MinValue = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      Value = 5
      OnChange = EditMaxConnOfNoLegalChange
    end
  end
  object ButtonOK: TButton
    Left = 528
    Top = 296
    Width = 89
    Height = 25
    Caption = #30830#23450'(&O)'
    Default = True
    TabOrder = 3
    OnClick = ButtonOKClick
  end
  object ListBox1: TListBox
    Left = 608
    Top = 260
    Width = 121
    Height = 69
    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
    ItemHeight = 12
    TabOrder = 4
    Visible = False
  end
  object BlockListPopupMenu: TPopupMenu
    OnPopup = BlockListPopupMenuPopup
    Left = 336
    Top = 168
    object BPOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = BPOPMENU_REFLISTClick
    end
    object BPOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = BPOPMENU_SORTClick
    end
    object BPOPMENU_ADD: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = BPOPMENU_ADDClick
    end
    object BPOPMENU_ADDTEMPLIST: TMenuItem
      Caption = #21152#20837#21160#24577#36807#28388#21015#34920'(&A)'
      OnClick = BPOPMENU_ADDTEMPLISTClick
    end
    object BPOPMENU_DELETE: TMenuItem
      Caption = #21024#38500'(&D)'
      OnClick = BPOPMENU_DELETEClick
    end
  end
  object TempBlockListPopupMenu: TPopupMenu
    OnPopup = TempBlockListPopupMenuPopup
    Left = 216
    Top = 160
    object TPOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = TPOPMENU_REFLISTClick
    end
    object TPOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = TPOPMENU_SORTClick
    end
    object TPOPMENU_ADD: TMenuItem
      Caption = #22686#21152'(&A)'
      OnClick = TPOPMENU_ADDClick
    end
    object TPOPMENU_BLOCKLIST: TMenuItem
      Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&D)'
      OnClick = TPOPMENU_BLOCKLISTClick
    end
    object TPOPMENU_DELETE: TMenuItem
      Caption = #21024#38500'(&D)'
      OnClick = TPOPMENU_DELETEClick
    end
  end
  object ActiveListPopupMenu: TPopupMenu
    OnPopup = ActiveListPopupMenuPopup
    Left = 56
    Top = 160
    object APOPMENU_REFLIST: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = APOPMENU_REFLISTClick
    end
    object APOPMENU_SORT: TMenuItem
      Caption = #25490#24207'(&S)'
      OnClick = APOPMENU_SORTClick
    end
    object APOPMENU_ADDTEMPLIST: TMenuItem
      Caption = #21152#20837#21160#24577#36807#28388#21015#34920'(&A)'
      OnClick = APOPMENU_ADDTEMPLISTClick
    end
    object APOPMENU_BLOCKLIST: TMenuItem
      Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&D)'
      OnClick = APOPMENU_BLOCKLISTClick
    end
    object APOPMENU_KICK: TMenuItem
      Caption = #36386#38500#19979#32447'(&K)'
      OnClick = APOPMENU_KICKClick
    end
  end
end
