object UpdateSQLEditFormEh: TUpdateSQLEditFormEh
  Left = 431
  Top = 372
  AutoScroll = False
  ClientHeight = 426
  ClientWidth = 582
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OkButton: TButton
    Left = 323
    Top = 396
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelButton: TButton
    Left = 411
    Top = 396
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object HelpButton: TButton
    Left = 499
    Top = 396
    Width = 76
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 2
    OnClick = HelpButtonClick
  end
  object PageControl: TPageControl
    Left = 6
    Top = 6
    Width = 568
    Height = 383
    ActivePage = FieldsPage
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 3
    OnChanging = PageControlChanging
    object FieldsPage: TTabSheet
      Caption = 'Options'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 4
        Width = 544
        Height = 342
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' SQL Generation '
        TabOrder = 0
        object Label1: TLabel
          Left = 12
          Top = 18
          Width = 61
          Height = 13
          Caption = 'Table &Name:'
          FocusControl = UpdateTableName
        end
        object Label3: TLabel
          Left = 255
          Top = 18
          Width = 51
          Height = 13
          Anchors = [akTop, akRight]
          Caption = '&Key Fields:'
          FocusControl = KeyFieldList
        end
        object Label4: TLabel
          Left = 398
          Top = 18
          Width = 68
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Update &Fields:'
          FocusControl = UpdateFieldList
        end
        object Label2: TLabel
          Left = 12
          Top = 57
          Width = 72
          Height = 13
          Caption = 'Increment field:'
          FocusControl = cbIncrementField
        end
        object labelUpdateObjects: TLabel
          Left = 12
          Top = 96
          Width = 82
          Height = 13
          Caption = 'Increment object:'
          FocusControl = cbIncrementObject
        end
        object UpdateTableName: TComboBox
          Left = 9
          Top = 35
          Width = 239
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 0
          OnChange = UpdateTableNameChange
          OnClick = UpdateTableNameClick
        end
        object KeyFieldList: TListBox
          Left = 255
          Top = 35
          Width = 135
          Height = 206
          Anchors = [akTop, akRight]
          ItemHeight = 13
          MultiSelect = True
          PopupMenu = FieldListPopup
          TabOrder = 6
          OnClick = SettingsChanged
        end
        object UpdateFieldList: TListBox
          Left = 398
          Top = 35
          Width = 136
          Height = 297
          Anchors = [akTop, akRight, akBottom]
          ItemHeight = 13
          MultiSelect = True
          PopupMenu = FieldListPopup
          TabOrder = 7
          OnClick = SettingsChanged
        end
        object GenerateButton: TButton
          Left = 9
          Top = 217
          Width = 239
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = '&Generate update commands'
          TabOrder = 4
          OnClick = GenerateButtonClick
        end
        object PrimaryKeyButton: TButton
          Left = 9
          Top = 190
          Width = 239
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Select &Primary Keys'
          TabOrder = 3
          OnClick = PrimaryKeyButtonClick
        end
        object DefaultButton: TButton
          Left = 9
          Top = 163
          Width = 239
          Height = 26
          Anchors = [akLeft, akTop, akRight]
          Caption = '&Dataset Defaults'
          Enabled = False
          TabOrder = 2
          OnClick = DefaultButtonClick
        end
        object QuoteFields: TCheckBox
          Left = 10
          Top = 245
          Width = 239
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = '&Quote Field Names'
          TabOrder = 5
          OnClick = SettingsChanged
        end
        object GetTableFieldsButton: TButton
          Left = 9
          Top = 137
          Width = 239
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Get &Table Fields'
          TabOrder = 1
          OnClick = GetTableFieldsButtonClick
        end
        object cbUpdate: TCheckBox
          Left = 10
          Top = 285
          Width = 180
          Height = 14
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Build update SQL'
          Checked = True
          State = cbChecked
          TabOrder = 8
          OnClick = cbInsertClick
        end
        object cbDelete: TCheckBox
          Left = 10
          Top = 302
          Width = 180
          Height = 14
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Build delete SQL'
          Checked = True
          State = cbChecked
          TabOrder = 9
          OnClick = cbInsertClick
        end
        object cbGetRec: TCheckBox
          Left = 10
          Top = 318
          Width = 180
          Height = 14
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Build getrec SQL'
          Checked = True
          State = cbChecked
          TabOrder = 10
          OnClick = cbInsertClick
        end
        object cbInsert: TCheckBox
          Left = 10
          Top = 269
          Width = 180
          Height = 13
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Build insert SQL'
          Checked = True
          State = cbChecked
          TabOrder = 11
          OnClick = cbInsertClick
        end
        object cbIncrementField: TComboBox
          Left = 9
          Top = 74
          Width = 239
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 12
        end
        object cbIncrementObject: TComboBox
          Left = 9
          Top = 113
          Width = 239
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ItemHeight = 13
          TabOrder = 13
        end
        object cbSpecParams: TCheckBox
          Left = 212
          Top = 268
          Width = 180
          Height = 14
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Build SpecParams'
          Checked = True
          State = cbChecked
          TabOrder = 14
          OnClick = cbInsertClick
        end
        object cbUpdateFields: TCheckBox
          Left = 212
          Top = 283
          Width = 180
          Height = 15
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Build updating fields list'
          Checked = True
          State = cbChecked
          TabOrder = 15
          OnClick = cbInsertClick
        end
        object cbKeyFields: TCheckBox
          Left = 212
          Top = 299
          Width = 180
          Height = 15
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Build key fields list'
          Checked = True
          State = cbChecked
          TabOrder = 16
          OnClick = cbInsertClick
        end
        object cbTableName: TCheckBox
          Left = 212
          Top = 316
          Width = 180
          Height = 14
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Build table name'
          Checked = True
          State = cbChecked
          TabOrder = 17
          OnClick = cbInsertClick
        end
      end
    end
    object SQLPage: TTabSheet
      Caption = 'SQL'
      object PageControl1: TPageControl
        Left = 7
        Top = 3
        Width = 550
        Height = 350
        ActivePage = tsInsert
        Anchors = [akLeft, akTop, akRight, akBottom]
        Style = tsFlatButtons
        TabOrder = 0
        object tsInsert: TTabSheet
          Caption = 'Insert'
          object MemoInsert: TMemo
            Left = 0
            Top = 0
            Width = 542
            Height = 319
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object tsModify: TTabSheet
          Caption = 'Modify'
          ImageIndex = 1
          object MemoModify: TMemo
            Left = 0
            Top = 0
            Width = 542
            Height = 319
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
            OnKeyDown = MemoModifyKeyDown
          end
        end
        object tsDelete: TTabSheet
          Caption = 'Delete'
          ImageIndex = 2
          object MemoDelete: TMemo
            Left = 0
            Top = 0
            Width = 542
            Height = 319
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object tsGetrec: TTabSheet
          Caption = 'Getrec'
          ImageIndex = 3
          object MemoGetRec: TMemo
            Left = 0
            Top = 0
            Width = 542
            Height = 319
            Align = alClient
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object tsSpecParams: TTabSheet
          Caption = 'Other'
          ImageIndex = 4
          object Panel11: TPanel
            Left = 266
            Top = 0
            Width = 276
            Height = 319
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            object Label5: TLabel
              Left = 10
              Top = 142
              Width = 62
              Height = 13
              Caption = 'Update fields'
            end
            object Label6: TLabel
              Left = 10
              Top = 45
              Width = 45
              Height = 13
              Caption = 'Key fields'
            end
            object Label7: TLabel
              Left = 10
              Top = 4
              Width = 61
              Height = 13
              Caption = 'Update table'
            end
            object Bevel1: TBevel
              Left = 79
              Top = 149
              Width = 194
              Height = 2
            end
            object Bevel2: TBevel
              Left = 65
              Top = 51
              Width = 209
              Height = 2
            end
            object Bevel3: TBevel
              Left = 80
              Top = 11
              Width = 193
              Height = 2
            end
            object MemoUpdateFields: TMemo
              Left = 10
              Top = 159
              Width = 263
              Height = 222
              Lines.Strings = (
                'Field1'
                'Field2')
              TabOrder = 0
            end
            object MemoKeyFields: TMemo
              Left = 10
              Top = 62
              Width = 264
              Height = 75
              Lines.Strings = (
                'KeyField1')
              TabOrder = 1
            end
            object dbeTableName: TDBEditEh
              Left = 10
              Top = 20
              Width = 263
              Height = 21
              EditButtons = <>
              TabOrder = 2
              Text = 'TableName'
              Visible = True
            end
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 266
            Height = 319
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel1'
            TabOrder = 1
            object Panel10: TPanel
              Left = 0
              Top = 0
              Width = 266
              Height = 26
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 0
              object Label8: TLabel
                Left = 3
                Top = 7
                Width = 60
                Height = 13
                Caption = 'SpecParams'
              end
              object Bevel4: TBevel
                Left = 70
                Top = 13
                Width = 123
                Height = 2
                Anchors = [akLeft, akTop, akRight]
              end
              object bLoadSpecString: TButton
                Left = 199
                Top = 3
                Width = 66
                Height = 21
                Anchors = [akTop, akRight]
                Caption = 'Load list'
                TabOrder = 0
              end
            end
            object mSpecParams: TMemo
              Left = 0
              Top = 26
              Width = 266
              Height = 293
              Align = alClient
              ScrollBars = ssVertical
              TabOrder = 1
            end
          end
        end
      end
    end
  end
  object FTempTable: TMemTableEh
    Params = <>
    Left = 148
    Top = 5
  end
  object FieldListPopup: TPopupMenu
    Left = 186
    Top = 6
    object miSelectAll: TMenuItem
      Caption = '&Select All'
      OnClick = SelectAllClick
    end
    object miClearAll: TMenuItem
      Caption = '&Clear All'
      OnClick = ClearAllClick
    end
  end
end
