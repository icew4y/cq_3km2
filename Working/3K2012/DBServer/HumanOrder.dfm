object HumanOrderFrm: THumanOrderFrm
  Left = 235
  Top = 142
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #25490#34892#27036#31649#29702
  ClientHeight = 418
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 4
    Width = 467
    Height = 109
    Caption = #25490#34892#27036#35774#32622
    TabOrder = 0
    object Label10: TLabel
      Left = 13
      Top = 43
      Width = 120
      Height = 13
      Caption = #26368#20302#31561#32423'                    '#32423
    end
    object Label2: TLabel
      Left = 262
      Top = 17
      Width = 12
      Height = 13
      Caption = #28857
    end
    object Label1: TLabel
      Left = 336
      Top = 17
      Width = 12
      Height = 13
      Caption = #20998
    end
    object Label3: TLabel
      Left = 262
      Top = 41
      Width = 24
      Height = 13
      Caption = #23567#26102
    end
    object Label4: TLabel
      Left = 336
      Top = 41
      Width = 12
      Height = 13
      Caption = #20998
    end
    object Label5: TLabel
      Left = 137
      Top = 67
      Width = 7
      Height = 13
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 12
      Top = 67
      Width = 120
      Height = 13
      Caption = #26368#39640#31561#32423'                    '#32423
    end
    object boAutoSort: TCheckBox
      Left = 16
      Top = 19
      Width = 113
      Height = 17
      Caption = #33258#21160#35745#31639#25490#34892#27036
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = boAutoSortClick
    end
    object SortLevel: TSpinEdit
      Left = 64
      Top = 39
      Width = 53
      Height = 22
      Hint = #24403#29609#23478#25110#33521#38596#31561#32423#20302#20110#35813#31561#32423#26102#65292#19981#36827#34892#25490#34892
      MaxValue = 65535
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 0
      OnChange = SortLevelChange
    end
    object RadioButton1: TRadioButton
      Left = 152
      Top = 16
      Width = 61
      Height = 17
      Caption = #27599#22825
      TabOrder = 2
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 152
      Top = 40
      Width = 59
      Height = 17
      Caption = #27599#38548
      TabOrder = 3
      OnClick = RadioButton2Click
    end
    object SpinEdit1: TSpinEdit
      Left = 212
      Top = 13
      Width = 46
      Height = 22
      MaxValue = 23
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Value = 0
      OnChange = SpinEdit1Change
    end
    object SpinEdit4: TSpinEdit
      Left = 286
      Top = 13
      Width = 46
      Height = 22
      MaxValue = 59
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Value = 0
      OnChange = SpinEdit4Change
    end
    object SpinEdit2: TSpinEdit
      Left = 212
      Top = 37
      Width = 46
      Height = 22
      MaxValue = 999
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Value = 0
      OnChange = SpinEdit2Change
    end
    object SpinEdit3: TSpinEdit
      Left = 286
      Top = 37
      Width = 46
      Height = 22
      MaxValue = 59
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Value = 0
      OnChange = SpinEdit3Change
    end
    object Button1: TButton
      Left = 376
      Top = 16
      Width = 65
      Height = 25
      Caption = #20445' '#23384
      Enabled = False
      TabOrder = 8
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 376
      Top = 46
      Width = 65
      Height = 25
      Caption = #21047#26032
      TabOrder = 9
      OnClick = Button2Click
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 89
      Width = 451
      Height = 12
      TabOrder = 10
    end
    object SpinEdit5: TSpinEdit
      Left = 64
      Top = 63
      Width = 54
      Height = 22
      Hint = #24403#29609#23478#25110#33521#38596#31561#32423#39640#20110#35813#31561#32423#26102#65292#19981#36827#34892#25490#34892
      MaxValue = 65535
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      Value = 0
      OnChange = SpinEdit5Change
    end
  end
  object PageControl1: TPageControl
    Left = 7
    Top = 119
    Width = 465
    Height = 292
    ActivePage = TabSheet2
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #20010#20154#27036
      object PageControl2: TPageControl
        Left = 7
        Top = 3
        Width = 441
        Height = 255
        ActivePage = TabSheet6
        TabOrder = 0
        OnChange = PageControl1Change
        object TabSheet4: TTabSheet
          Caption = #32676#33521#27036
          object ListView1: TListView
            Left = 5
            Top = 5
            Width = 422
            Height = 217
            Columns = <
              item
                Caption = #24207#20301
                Width = 80
              end
              item
                Caption = #35282#33394#21517
                Width = 150
              end
              item
                Caption = #31561#32423
                Width = 70
              end
              item
                Caption = #24515#27861#31561#32423
              end>
            GridLines = True
            MultiSelect = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet5: TTabSheet
          Caption = #25112#31070#27036
          ImageIndex = 1
          object ListView2: TListView
            Left = 5
            Top = 5
            Width = 422
            Height = 217
            Columns = <
              item
                Caption = #24207#20301
                Width = 80
              end
              item
                Caption = #35282#33394#21517
                Width = 150
              end
              item
                Caption = #31561#32423
                Width = 70
              end
              item
                Caption = #24515#27861#31561#32423
              end>
            GridLines = True
            MultiSelect = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet6: TTabSheet
          Caption = #27861#22307#27036
          ImageIndex = 2
          object ListView3: TListView
            Left = 5
            Top = 5
            Width = 422
            Height = 217
            Columns = <
              item
                Caption = #24207#20301
                Width = 80
              end
              item
                Caption = #35282#33394#21517
                Width = 150
              end
              item
                Caption = #31561#32423
                Width = 70
              end
              item
                Caption = #24515#27861#31561#32423
              end>
            GridLines = True
            MultiSelect = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet7: TTabSheet
          Caption = #36947#23562#27036
          ImageIndex = 3
          object ListView4: TListView
            Left = 5
            Top = 5
            Width = 422
            Height = 217
            Columns = <
              item
                Caption = #24207#20301
                Width = 80
              end
              item
                Caption = #35282#33394#21517
                Width = 150
              end
              item
                Caption = #31561#32423
                Width = 70
              end
              item
                Caption = #24515#27861#31561#32423
              end>
            GridLines = True
            MultiSelect = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #33521#38596#27036
      ImageIndex = 1
      object PageControl3: TPageControl
        Left = 7
        Top = 3
        Width = 441
        Height = 255
        ActivePage = TabSheet8
        TabOrder = 0
        OnChange = PageControl1Change
        object TabSheet8: TTabSheet
          Caption = #24635#25490#34892
          object PageControl5: TPageControl
            Left = -8
            Top = -28
            Width = 441
            Height = 255
            ActivePage = TabSheet18
            TabOrder = 0
            object TabSheet16: TTabSheet
              Caption = #32676#33521#27036
              object ListView5: TListView
                Left = 5
                Top = 5
                Width = 422
                Height = 217
                Columns = <
                  item
                    Caption = #24207#21495
                    Width = 80
                  end
                  item
                    Caption = #35282#33394#21517
                    Width = 150
                  end
                  item
                    Caption = #31561#32423
                    Width = 70
                  end>
                GridLines = True
                MultiSelect = True
                RowSelect = True
                TabOrder = 0
                ViewStyle = vsReport
              end
            end
            object TabSheet17: TTabSheet
              Caption = #25112#31070#27036
              ImageIndex = 1
              object ListView6: TListView
                Left = 5
                Top = 5
                Width = 422
                Height = 217
                Columns = <
                  item
                    Caption = #24207#21495
                    Width = 80
                  end
                  item
                    Caption = #35282#33394#21517
                    Width = 150
                  end
                  item
                    Caption = #31561#32423
                    Width = 70
                  end>
                GridLines = True
                MultiSelect = True
                RowSelect = True
                TabOrder = 0
                ViewStyle = vsReport
              end
            end
            object TabSheet18: TTabSheet
              Caption = #27861#22307#27036
              ImageIndex = 2
              ExplicitTop = 56
              object ListView7: TListView
                Left = 9
                Top = 9
                Width = 422
                Height = 217
                Columns = <
                  item
                    Caption = #24207#20301
                    Width = 55
                  end
                  item
                    Caption = #33521#38596#21517
                    Width = 145
                  end
                  item
                    Caption = #35282#33394#21517
                    Width = 145
                  end
                  item
                    Caption = #31561#32423
                    Width = 55
                  end>
                GridLines = True
                MultiSelect = True
                RowSelect = True
                TabOrder = 0
                ViewStyle = vsReport
              end
            end
            object TabSheet19: TTabSheet
              Caption = #36947#23562#27036
              ImageIndex = 3
              object ListView8: TListView
                Left = 5
                Top = 5
                Width = 422
                Height = 217
                Columns = <
                  item
                    Caption = #24207#21495
                    Width = 80
                  end
                  item
                    Caption = #35282#33394#21517
                    Width = 150
                  end
                  item
                    Caption = #31561#32423
                    Width = 70
                  end>
                GridLines = True
                MultiSelect = True
                RowSelect = True
                TabOrder = 0
                ViewStyle = vsReport
              end
            end
          end
        end
        object TabSheet9: TTabSheet
          Caption = #25112#22763#33521#38596#27036
          ImageIndex = 1
          object ListView9: TListView
            Left = 5
            Top = 5
            Width = 422
            Height = 217
            Columns = <
              item
                Caption = #24207#20301
                Width = 55
              end
              item
                Caption = #33521#38596#21517
                Width = 145
              end
              item
                Caption = #35282#33394#21517
                Width = 145
              end
              item
                Caption = #31561#32423
                Width = 55
              end>
            GridLines = True
            MultiSelect = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet10: TTabSheet
          Caption = #27861#24072#33521#38596#27036
          ImageIndex = 2
          object ListView10: TListView
            Left = 5
            Top = 5
            Width = 422
            Height = 217
            Columns = <
              item
                Caption = #24207#20301
                Width = 55
              end
              item
                Caption = #33521#38596#21517
                Width = 145
              end
              item
                Caption = #35282#33394#21517
                Width = 145
              end
              item
                Caption = #31561#32423
                Width = 55
              end>
            GridLines = True
            MultiSelect = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
        object TabSheet11: TTabSheet
          Caption = #36947#22763#33521#38596#27036
          ImageIndex = 3
          object ListView11: TListView
            Left = 5
            Top = 5
            Width = 422
            Height = 217
            Columns = <
              item
                Caption = #24207#20301
                Width = 55
              end
              item
                Caption = #33521#38596#21517
                Width = 145
              end
              item
                Caption = #35282#33394#21517
                Width = 145
              end
              item
                Caption = #31561#32423
                Width = 55
              end>
            GridLines = True
            MultiSelect = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #21517#24072#27036
      ImageIndex = 2
      object ListView12: TListView
        Left = 3
        Top = 3
        Width = 444
        Height = 252
        Columns = <
          item
            Caption = #24207#20301
            Width = 65
          end
          item
            Caption = #35282#33394#21517
            Width = 150
          end
          item
            Caption = #20986#24072#24466#24351#25968
            Width = 80
          end>
        GridLines = True
        MultiSelect = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
end
