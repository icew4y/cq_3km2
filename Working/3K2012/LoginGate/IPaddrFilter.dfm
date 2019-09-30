object frmIPaddrFilter: TfrmIPaddrFilter
  Left = 225
  Top = 219
  Caption = #32593#32476#23433#20840#36807#28388
  ClientHeight = 369
  ClientWidth = 624
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
  object Label6: TLabel
    Left = 0
    Top = 333
    Width = 624
    Height = 36
    Align = alBottom
    Caption = 
      ' '#35828#26126#65306'IP'#27573#36807#28388#65292#22914#35201#23631#34109'192.168.1.0'#33267'192.168.255.255'#30340#20840#37096'IP'#65292#21487#20197#28155#21152'192.168.*.*'#13' ' +
      #22914#21482#38656'192.168.1.0'#33267'192.168.1.255,'#28155#21152'192.168.1.* '#21363#21487'.'#13' '#27880#24847#65306'192.168.*.15,' +
      #21482#33021#23631#34109'192.168.0.0-192.168.255.255'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 492
  end
  object ListBox1: TListBox
    Left = 509
    Top = 323
    Width = 69
    Height = 41
    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
    ItemHeight = 12
    TabOrder = 0
    Visible = False
  end
  object Panel7: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 333
    Align = alClient
    Caption = 'Panel7'
    Ctl3D = True
    UseDockManager = False
    ParentCtl3D = False
    TabOrder = 1
    ExplicitWidth = 626
    object GroupBox2: TGroupBox
      Left = 437
      Top = 1
      Width = 186
      Height = 331
      Align = alRight
      Caption = #25915#20987#20445#25252
      TabOrder = 0
      ExplicitLeft = 439
      object Label2: TLabel
        Left = 5
        Top = 65
        Width = 54
        Height = 12
        Caption = #36830#25509#38480#21046':'
      end
      object Label3: TLabel
        Left = 133
        Top = 65
        Width = 42
        Height = 12
        Caption = #36830#25509'/IP'
      end
      object Label7: TLabel
        Left = 29
        Top = 277
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
        Left = 5
        Top = 85
        Width = 84
        Height = 12
        Caption = #38450#24481#31561#32423#35843#25972#65306
      end
      object Label8: TLabel
        Left = 5
        Top = 41
        Width = 54
        Height = 12
        Caption = #38750#27861#36830#25509':'
      end
      object Label9: TLabel
        Left = 4
        Top = 19
        Width = 138
        Height = 12
        Caption = #21333'IP         '#27627#31186#21487#36830#25509
      end
      object EditMaxConnect: TSpinEdit
        Left = 61
        Top = 61
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
        Left = 6
        Top = 203
        Width = 171
        Height = 70
        Caption = #25915#20987#25805#20316
        TabOrder = 1
        object RadioAddBlockList: TRadioButton
          Tag = 2
          Left = 16
          Top = 50
          Width = 129
          Height = 17
          Hint = #23558#27492#36830#25509#30340'IP'#21152#20837#27704#20037#36807#28388#21015#34920#65292#24182#23558#27492'IP'#30340#25152#26377#36830#25509#24378#34892#20013#26029
          Caption = #21152#20837#27704#20037#36807#28388#21015#34920
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = rbBlockMethodClick
        end
        object RadioAddTempList: TRadioButton
          Tag = 1
          Left = 16
          Top = 33
          Width = 129
          Height = 17
          Hint = #23558#27492#36830#25509#30340'IP'#21152#20837#21160#24577#36807#28388#21015#34920#65292#24182#23558#27492'IP'#30340#25152#26377#36830#25509#24378#34892#20013#26029
          Caption = #21152#20837#21160#24577#36807#28388#21015#34920
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = rbBlockMethodClick
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
          OnClick = rbBlockMethodClick
        end
        object GroupBox1: TGroupBox
          Left = 26
          Top = 73
          Width = 111
          Height = 75
          Caption = #36807#28388#31867#22411
          TabOrder = 3
          object RadioButton1: TRadioButton
            Tag = 2
            Left = 16
            Top = 54
            Width = 61
            Height = 17
            Caption = #26426#22120#30721
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            OnClick = BlockMethodDataClick
          end
          object RadioButton2: TRadioButton
            Tag = 1
            Left = 16
            Top = 35
            Width = 61
            Height = 17
            Caption = 'IP'
            ParentShowHint = False
            ShowHint = False
            TabOrder = 1
            OnClick = BlockMethodDataClick
          end
          object RadioButton3: TRadioButton
            Left = 16
            Top = 16
            Width = 75
            Height = 17
            Caption = 'IP+'#26426#22120#30721
            ParentShowHint = False
            ShowHint = False
            TabOrder = 2
            OnClick = BlockMethodDataClick
          end
        end
      end
      object TrackBarAttack: TTrackBar
        Left = 5
        Top = 101
        Width = 177
        Height = 33
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnChange = TrackBarAttackChange
      end
      object CheckBoxChg: TCheckBox
        Left = 5
        Top = 133
        Width = 129
        Height = 17
        Caption = #35843#25972#38450#24481#31561#32423#20026'1'#32423
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = CheckBoxChgClick
      end
      object CheckBoxAutoClearTempList: TCheckBox
        Left = 5
        Top = 157
        Width = 121
        Height = 17
        Caption = #28165#38500#21160#24577#36807#28388#21015#34920
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = CheckBoxAutoClearTempListClick
      end
      object SpinEdit2: TSpinEdit
        Left = 133
        Top = 157
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
        Left = 5
        Top = 181
        Width = 129
        Height = 17
        Caption = #26080#25915#20987#36824#21407#38450#24481#31561#32423
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = CheckBoxReliefDefendClick
      end
      object SpinEdit3: TSpinEdit
        Left = 133
        Top = 181
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
        Left = 133
        Top = 133
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
      object EditMaxConnOfNoLegal: TSpinEdit
        Left = 61
        Top = 37
        Width = 65
        Height = 21
        Hint = #21333#20010'IP'#22320#22336#65292#38750#27861#36830#25509#27425#25968#65292#36229#36807#35774#32622#20540#23558#25353#36827#34892#25915#20987#25805#20316#22788#29702#65292#21482#23545#21160#24577#21644#27704#20037#36807#28388#21015#34920#36215#20316#29992
        EditorEnabled = False
        MaxValue = 1000
        MinValue = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        Value = 5
        OnChange = EditMaxConnOfNoLegalChange
      end
      object SpinEdit4: TSpinEdit
        Left = 28
        Top = 15
        Width = 55
        Height = 21
        Hint = #19968#20010'IP'#22312#25351#23450#30340#26102#38388#20869#21487#36830#20987#30340#27425#25968#65292#36229#36807#27425#25968#21017#35748#20026#26159#25915#20987
        Increment = 100
        MaxValue = 65535
        MinValue = 100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        Value = 100
        OnChange = SpinEdit4Change
      end
      object SpinEdit5: TSpinEdit
        Left = 141
        Top = 13
        Width = 43
        Height = 21
        Hint = #27425
        MaxValue = 1000
        MinValue = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        Value = 1
        OnChange = SpinEdit5Change
      end
      object ButtonOK: TButton
        Left = 41
        Top = 299
        Width = 89
        Height = 25
        Caption = #30830#23450'(&O)'
        Default = True
        TabOrder = 12
        OnClick = ButtonOKClick
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 436
      Height = 331
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 438
      object GroupBoxActive: TGroupBox
        Left = 0
        Top = 0
        Width = 139
        Height = 331
        Align = alClient
        Caption = #24403#21069#36830#25509
        TabOrder = 0
        ExplicitWidth = 141
        object ListViewActiveList: TListView
          Left = 2
          Top = 14
          Width = 135
          Height = 315
          Align = alClient
          Columns = <
            item
              Caption = 'IP'
              Width = 130
            end
            item
              Caption = #26426#22120#30721
              Width = 150
            end
            item
              Caption = #25152#22312#22320
              Width = 250
            end>
          ReadOnly = True
          RowSelect = True
          PopupMenu = ActiveListPopupMenu
          SortType = stText
          TabOrder = 0
          ViewStyle = vsReport
          ExplicitWidth = 137
        end
      end
      object PageControl1: TPageControl
        Left = 139
        Top = 0
        Width = 297
        Height = 331
        ActivePage = TabSheet2
        Align = alRight
        TabOrder = 1
        ExplicitLeft = 141
        object TabSheet1: TTabSheet
          Caption = 'IP'#36807#28388#21015#34920
          object Splitter3: TSplitter
            Left = 139
            Top = 0
            Height = 304
            ExplicitLeft = 148
            ExplicitTop = 2
            ExplicitHeight = 302
          end
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 139
            Height = 304
            Align = alLeft
            BevelOuter = bvNone
            BiDiMode = bdLeftToRight
            Ctl3D = True
            ParentBiDiMode = False
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
            object Label10: TLabel
              Left = 0
              Top = 0
              Width = 139
              Height = 12
              Align = alTop
              Caption = ' '#21160#24577#36807#28388':'
              ExplicitWidth = 60
            end
            object ListBoxTempList: TListBox
              Left = 0
              Top = 12
              Width = 139
              Height = 292
              Hint = #21160#24577#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#20294#22312#31243#24207#37325#26032#21551#21160#26102#27492#21015#34920#30340#20449#24687#23558#34987#28165#31354
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ItemHeight = 12
              Items.Strings = (
                '888.888.888.888')
              MultiSelect = True
              ParentFont = False
              ParentShowHint = False
              PopupMenu = TempBlockListPopupMenu
              ShowHint = True
              Sorted = True
              TabOrder = 0
            end
          end
          object Panel6: TPanel
            Left = 142
            Top = 0
            Width = 147
            Height = 304
            Align = alClient
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            object Label11: TLabel
              Left = 0
              Top = 0
              Width = 147
              Height = 12
              Align = alTop
              Caption = ' '#27704#20037#36807#28388':'
              ExplicitWidth = 60
            end
            object ListBoxBlockList: TListBox
              Left = 0
              Top = 12
              Width = 147
              Height = 292
              Hint = #27704#20037#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#27492#21015#34920#23558#20445#23384#20110#37197#32622#25991#20214#20013#65292#22312#31243#24207#37325#26032#21551#21160#26102#20250#37325#26032#21152#36733#27492#21015#34920
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ItemHeight = 12
              Items.Strings = (
                '888.888.888.888')
              MultiSelect = True
              ParentFont = False
              ParentShowHint = False
              PopupMenu = BlockListPopupMenu
              ShowHint = True
              Sorted = True
              TabOrder = 0
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #26426#22120#30721#36807#28388#21015#34920
          ImageIndex = 1
          object Splitter2: TSplitter
            Left = 139
            Top = 0
            Height = 304
            ExplicitLeft = 142
            ExplicitTop = -3
            ExplicitHeight = 302
          end
          object Panel3: TPanel
            Left = 0
            Top = 0
            Width = 139
            Height = 304
            Align = alLeft
            BevelOuter = bvNone
            BiDiMode = bdLeftToRight
            Ctl3D = True
            ParentBiDiMode = False
            ParentBackground = False
            ParentCtl3D = False
            TabOrder = 0
            object LabelTempList: TLabel
              Left = 0
              Top = 0
              Width = 139
              Height = 12
              Align = alTop
              Caption = ' '#21160#24577#36807#28388':'
              ExplicitWidth = 60
            end
            object ListBoxTempHCList: TListBox
              Left = 0
              Top = 12
              Width = 139
              Height = 292
              Hint = #21160#24577#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#20294#22312#31243#24207#37325#26032#21551#21160#26102#27492#21015#34920#30340#20449#24687#23558#34987#28165#31354
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ItemHeight = 12
              Items.Strings = (
                'FF-FF-FF-FF')
              MultiSelect = True
              ParentFont = False
              ParentShowHint = False
              PopupMenu = TempBlockListPopupMenu
              ShowHint = True
              Sorted = True
              TabOrder = 0
            end
          end
          object Panel4: TPanel
            Left = 142
            Top = 0
            Width = 147
            Height = 304
            Align = alClient
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            object Label1: TLabel
              Left = 0
              Top = 0
              Width = 147
              Height = 12
              Align = alTop
              Caption = ' '#27704#20037#36807#28388':'
              ExplicitWidth = 60
            end
            object ListBoxBlockHCList: TListBox
              Left = 0
              Top = 12
              Width = 147
              Height = 292
              Hint = #27704#20037#36807#28388#21015#34920#65292#22312#27492#21015#34920#20013#30340'IP'#23558#26080#27861#24314#31435#36830#25509#65292#27492#21015#34920#23558#20445#23384#20110#37197#32622#25991#20214#20013#65292#22312#31243#24207#37325#26032#21551#21160#26102#20250#37325#26032#21152#36733#27492#21015#34920
              Align = alClient
              Font.Charset = GB2312_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = #23435#20307
              Font.Style = []
              ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
              ItemHeight = 12
              Items.Strings = (
                'FF-FF-FF-FF')
              MultiSelect = True
              ParentFont = False
              ParentShowHint = False
              PopupMenu = BlockListPopupMenu
              ShowHint = True
              Sorted = True
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  object BlockListPopupMenu: TPopupMenu
    OnPopup = BlockListPopupMenuPopup
    Left = 336
    Top = 160
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
      Visible = False
      OnClick = APOPMENU_SORTClick
    end
    object APOPMENU_IP: TMenuItem
      Caption = 'IP'
      object APOPMENU_BLOCKLIST: TMenuItem
        Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&D)'
        OnClick = APOPMENU_BLOCKLISTClick
      end
      object APOPMENU_ADDTEMPLIST: TMenuItem
        Caption = #21152#20837#21160#24577#36807#28388#21015#34920'(&A)'
        OnClick = APOPMENU_ADDTEMPLIST_Click
      end
    end
    object APOPMENU_HC: TMenuItem
      Caption = #26426#22120#30721
      object APOPMENU_BLOCKLIST_HC: TMenuItem
        Caption = #21152#20837#27704#20037#36807#28388#21015#34920'(&A)'
        OnClick = APOPMENU_BLOCKLIST_HCClick
      end
      object APOPMENU_ADDTEMPLIST_HC: TMenuItem
        Caption = #21152#20837#21160#24577#36807#28388#21015#34920'(&D)'
        OnClick = APOPMENU_ADDTEMPLIST_HCClick
      end
    end
    object APOPMENU_KICK: TMenuItem
      Caption = #36386#38500#19979#32447'(&K)'
      OnClick = APOPMENU_KICKClick
    end
  end
end
