object frmGuildManage: TfrmGuildManage
  Left = 364
  Top = 247
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #34892#20250#31649#29702
  ClientHeight = 312
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
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
    Top = 4
    Width = 191
    Height = 304
    Caption = #34892#20250#21015#34920
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
          Caption = #34892#20250#21517#31216
          Width = 115
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewGuildClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 198
    Top = 4
    Width = 289
    Height = 261
    Caption = #34892#20250#20449#24687
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 8
      Top = 14
      Width = 275
      Height = 241
      ActivePage = TabSheet1
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #22522#26412#24773#20917
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox3: TGroupBox
          Left = 4
          Top = 0
          Width = 260
          Height = 210
          TabOrder = 0
          object Label2: TLabel
            Left = 8
            Top = 20
            Width = 54
            Height = 12
            Caption = #34892#20250#21517#31216':'
          end
          object Label1: TLabel
            Left = 8
            Top = 44
            Width = 54
            Height = 12
            Caption = #24314' '#31569' '#24230':'
          end
          object Label3: TLabel
            Left = 8
            Top = 68
            Width = 54
            Height = 12
            Caption = #20154' '#27668' '#24230':'
          end
          object Label7: TLabel
            Left = 8
            Top = 92
            Width = 54
            Height = 12
            Caption = #23433' '#23450' '#24230':'
          end
          object Label8: TLabel
            Left = 8
            Top = 116
            Width = 54
            Height = 12
            Caption = #32321' '#33635' '#24230':'
          end
          object Label4: TLabel
            Left = 8
            Top = 140
            Width = 54
            Height = 12
            Caption = #35013' '#22791' '#25968':'
          end
          object Label5: TLabel
            Left = 8
            Top = 164
            Width = 54
            Height = 12
            Caption = #34892#20250#27849#27700':'
          end
          object Label9: TLabel
            Left = 8
            Top = 188
            Width = 54
            Height = 12
            Caption = #25104#21592#19978#38480':'
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
          object EditBuildPoint: TSpinEdit
            Left = 64
            Top = 40
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 1
            Value = 0
            OnChange = EditBuildPointChange
          end
          object EditAurae: TSpinEdit
            Left = 64
            Top = 64
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 2
            Value = 0
            OnChange = EditBuildPointChange
          end
          object EditStability: TSpinEdit
            Left = 64
            Top = 88
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 3
            Value = 0
            OnChange = EditBuildPointChange
          end
          object EditFlourishing: TSpinEdit
            Left = 64
            Top = 112
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 4
            Value = 0
            OnChange = EditBuildPointChange
          end
          object EditChiefItemCount: TSpinEdit
            Left = 64
            Top = 136
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 5
            Value = 0
            OnChange = EditBuildPointChange
          end
          object EditGuildFountain: TSpinEdit
            Left = 64
            Top = 160
            Width = 81
            Height = 21
            MaxValue = 2000000000
            MinValue = 0
            TabOrder = 6
            Value = 0
            OnChange = EditBuildPointChange
          end
          object Button1: TButton
            Left = 168
            Top = 160
            Width = 75
            Height = 25
            Caption = #20445#23384'(&S)'
            Enabled = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            OnClick = Button1Click
          end
          object SpinEditGuildMemberCount: TSpinEdit
            Left = 64
            Top = 184
            Width = 81
            Height = 21
            MaxValue = 65535
            MinValue = 1
            TabOrder = 8
            Value = 1
            OnChange = EditBuildPointChange
          end
        end
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 200
    Top = 267
    Width = 287
    Height = 41
    Caption = #34892#20250#35774#32622
    TabOrder = 2
    object Label6: TLabel
      Left = 18
      Top = 18
      Width = 102
      Height = 12
      Caption = #26032#24314#34892#20250#25104#21592#19978#38480':'
    end
    object EditGuildMemberCount: TSpinEdit
      Left = 125
      Top = 12
      Width = 60
      Height = 21
      Hint = #26032#24314#34892#20250#65292#26368#22823#30340#25104#21592#25968#37327#65292#24314#35758#22312'200-300'#20043#38388
      MaxValue = 65535
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 1
      OnChange = EditGuildMemberCountChange
    end
    object Button2: TButton
      Left = 200
      Top = 10
      Width = 75
      Height = 25
      Caption = #20445#23384
      Enabled = False
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
