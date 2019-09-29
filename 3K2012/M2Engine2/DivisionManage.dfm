object FrmDivisionManage: TFrmDivisionManage
  Left = 0
  Top = 0
  Caption = #24072#38376#31649#29702
  ClientHeight = 304
  ClientWidth = 485
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 3
    Top = 0
    Width = 191
    Height = 304
    Caption = #24072#38376#21015#34920
    TabOrder = 0
    object ListViewGuild: TListView
      Left = 6
      Top = 16
      Width = 177
      Height = 281
      Columns = <
        item
          Caption = #24207#21495
          Width = 37
        end
        item
          Caption = #24072#38376#21517#31216
          Width = 115
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = ListViewGuildDblClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 197
    Top = 1
    Width = 288
    Height = 302
    Caption = #24072#38376#20449#24687
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 8
      Top = 14
      Width = 275
      Height = 198
      ActivePage = TabSheet1
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #22522#26412#24773#20917
        object GroupBox3: TGroupBox
          Left = 4
          Top = 0
          Width = 260
          Height = 167
          TabOrder = 0
          object Label2: TLabel
            Left = 8
            Top = 20
            Width = 54
            Height = 12
            Caption = #24072#38376#21517#31216':'
          end
          object Label3: TLabel
            Left = 8
            Top = 47
            Width = 54
            Height = 12
            Caption = #20154' '#27668' '#24230':'
          end
          object Label9: TLabel
            Left = 8
            Top = 102
            Width = 54
            Height = 12
            Caption = #25104#21592#19978#38480':'
          end
          object Label1: TLabel
            Left = 8
            Top = 75
            Width = 54
            Height = 12
            Caption = #24515#27861#21517#31216':'
          end
          object EditGuildName: TEdit
            Left = 64
            Top = 16
            Width = 169
            Height = 20
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ReadOnly = True
            TabOrder = 0
          end
          object EditAurae: TSpinEdit
            Left = 64
            Top = 43
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 1
            Value = 0
            OnChange = EditAuraeChange
          end
          object Button1: TButton
            Left = 168
            Top = 112
            Width = 75
            Height = 25
            Caption = #20445#23384'(&S)'
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = Button1Click
          end
          object SpinEditGuildMemberCount: TSpinEdit
            Left = 68
            Top = 97
            Width = 81
            Height = 21
            MaxValue = 25
            MinValue = 1
            TabOrder = 3
            Value = 1
            OnChange = EditAuraeChange
          end
          object Edit1: TEdit
            Left = 64
            Top = 71
            Width = 169
            Height = 20
            Enabled = False
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            ReadOnly = True
            TabOrder = 4
            OnChange = EditAuraeChange
          end
        end
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 200
    Top = 219
    Width = 280
    Height = 83
    Caption = #24072#38376#35774#32622
    TabOrder = 2
    object Label6: TLabel
      Left = 18
      Top = 18
      Width = 102
      Height = 12
      Caption = #26032#24314#24072#38376#25104#21592#19978#38480':'
    end
    object Label4: TLabel
      Left = 18
      Top = 40
      Width = 102
      Height = 12
      Caption = #21019#24314#24072#38376#25152#38656#31561#32423':'
    end
    object Label5: TLabel
      Left = 19
      Top = 61
      Width = 102
      Height = 12
      Caption = #21152#20837#38376#27966#25152#38656#31561#32423':'
    end
    object EditGuildMemberCount: TSpinEdit
      Left = 125
      Top = 12
      Width = 60
      Height = 21
      Hint = #26032#24314#24072#38376#65292#26368#22823#30340#25104#21592#25968#37327#65292#24314#35758#22312'21-50'#20043#38388
      MaxValue = 65535
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 1
      OnChange = EditGuildMemberCountChange
    end
    object Button2: TButton
      Left = 191
      Top = 29
      Width = 75
      Height = 25
      Caption = #20445#23384
      Enabled = False
      TabOrder = 1
      OnClick = Button2Click
    end
    object SpinEditBuildDivisionLevel: TSpinEdit
      Left = 125
      Top = 34
      Width = 60
      Height = 21
      MaxValue = 24
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 1
      OnChange = SpinEditBuildDivisionLevelChange
    end
    object SpinEditApplyDivisionLevel: TSpinEdit
      Left = 125
      Top = 56
      Width = 60
      Height = 21
      Hint = #30003#35831#21152#20837#38376#27966#25152#38656#35201#30340#26368#20302#31561#32423
      MaxValue = 65535
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Value = 1
      OnChange = SpinEditApplyDivisionLevelChange
    end
  end
end
