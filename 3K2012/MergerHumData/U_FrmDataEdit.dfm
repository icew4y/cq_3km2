object FrmDataEdit: TFrmDataEdit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #25968#25454#35843#25972'('#20174#24211')'
  ClientHeight = 379
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 12
  object lbl12: TLabel
    Left = 300
    Top = 13
    Width = 12
    Height = 12
    Caption = #32423
  end
  object lbl10: TLabel
    Left = 90
    Top = 43
    Width = 12
    Height = 12
    Caption = #21407
  end
  object lbl11: TLabel
    Left = 163
    Top = 43
    Width = 24
    Height = 12
    Caption = '=>'#26032
  end
  object lbl13: TLabel
    Left = 89
    Top = 74
    Width = 12
    Height = 12
    Caption = #21407
  end
  object lbl14: TLabel
    Left = 162
    Top = 74
    Width = 24
    Height = 12
    Caption = '=>'#26032
  end
  object lbl17: TLabel
    Left = 200
    Top = 169
    Width = 30
    Height = 12
    Caption = 'X'#22352#26631
  end
  object lbl19: TLabel
    Left = 289
    Top = 169
    Width = 30
    Height = 12
    Caption = 'Y'#22352#26631
  end
  object lbl16: TLabel
    Left = 177
    Top = 107
    Width = 24
    Height = 12
    Caption = #20195#30721
  end
  object lbl18: TLabel
    Left = 177
    Top = 137
    Width = 24
    Height = 12
    Caption = #20195#30721
  end
  object cbb1: TComboBox
    Left = 90
    Top = 10
    Width = 50
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 1
    Text = #22823#20110
    Items.Strings = (
      #22823#20110
      #31561#20110
      #23569#20110)
  end
  object edt2: TRzSpinEdit
    Left = 146
    Top = 10
    Width = 47
    Height = 20
    AllowKeyEdit = True
    Max = 65535.000000000000000000
    TabOrder = 2
  end
  object cbb2: TComboBox
    Left = 197
    Top = 10
    Width = 46
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 3
    Text = #26367#25442
    Items.Strings = (
      #26367#25442
      #22686#21152
      #20943#23569)
  end
  object edt3: TRzSpinEdit
    Left = 248
    Top = 10
    Width = 47
    Height = 20
    AllowKeyEdit = True
    Max = 65535.000000000000000000
    TabOrder = 4
  end
  object btn22: TButton
    Left = 9
    Top = 8
    Width = 75
    Height = 25
    Caption = #20154#29289#31561#32423
    TabOrder = 0
    OnClick = btn22Click
  end
  object btn23: TButton
    Left = 9
    Top = 38
    Width = 75
    Height = 25
    Caption = #35013#22791#20195#30721
    TabOrder = 5
    OnClick = btn23Click
  end
  object edt4: TRzSpinEdit
    Left = 110
    Top = 40
    Width = 47
    Height = 20
    AllowKeyEdit = True
    Max = 65535.000000000000000000
    TabOrder = 6
  end
  object edt5: TRzSpinEdit
    Left = 193
    Top = 40
    Width = 47
    Height = 20
    AllowKeyEdit = True
    Max = 65535.000000000000000000
    TabOrder = 7
  end
  object chk1: TCheckBox
    Left = 253
    Top = 42
    Width = 97
    Height = 17
    Caption = #20445#25345#21407#26377#23646#24615
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object btn24: TButton
    Left = 8
    Top = 69
    Width = 75
    Height = 25
    Caption = #25216#33021#20195#30721
    TabOrder = 9
    OnClick = btn24Click
  end
  object edt6: TRzSpinEdit
    Left = 109
    Top = 71
    Width = 47
    Height = 20
    AllowKeyEdit = True
    Max = 65535.000000000000000000
    TabOrder = 10
  end
  object edt7: TRzSpinEdit
    Left = 192
    Top = 71
    Width = 47
    Height = 20
    AllowKeyEdit = True
    Max = 65535.000000000000000000
    TabOrder = 11
  end
  object chk2: TCheckBox
    Left = 252
    Top = 73
    Width = 97
    Height = 17
    Caption = #20445#25345#21407#26377#23646#24615
    Checked = True
    State = cbChecked
    TabOrder = 12
  end
  object cbb5: TComboBox
    Left = 229
    Top = 199
    Width = 81
    Height = 20
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 12
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 26
    Text = #20840#37096#22686#21152
    Items.Strings = (
      #20840#37096#22686#21152
      #20840#37096#20943#23569
      #20840#37096#31561#20110)
  end
  object edt10: TRzSpinEdit
    Left = 327
    Top = 199
    Width = 97
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 27
  end
  object btn21: TButton
    Left = 10
    Top = 197
    Width = 75
    Height = 25
    Caption = 'PK'#20540
    TabOrder = 23
    OnClick = btn21Click
  end
  object btn27: TButton
    Left = 10
    Top = 230
    Width = 75
    Height = 25
    Caption = #32463#39564
    TabOrder = 28
    OnClick = btn27Click
  end
  object cbb6: TComboBox
    Left = 229
    Top = 232
    Width = 81
    Height = 20
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 12
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 31
    Text = #20840#37096#22686#21152
    Items.Strings = (
      #20840#37096#22686#21152
      #20840#37096#20943#23569
      #20840#37096#31561#20110)
  end
  object edt11: TRzSpinEdit
    Left = 327
    Top = 232
    Width = 97
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 32
  end
  object cbb7: TComboBox
    Left = 229
    Top = 264
    Width = 81
    Height = 20
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 12
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 36
    Text = #20840#37096#22686#21152
    Items.Strings = (
      #20840#37096#22686#21152
      #20840#37096#20943#23569
      #20840#37096#31561#20110)
  end
  object edt12: TRzSpinEdit
    Left = 327
    Top = 264
    Width = 97
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 37
  end
  object btn29: TButton
    Left = 10
    Top = 262
    Width = 75
    Height = 25
    Caption = #23646#24615#28857
    TabOrder = 33
    OnClick = btn29Click
  end
  object btn30: TButton
    Left = 9
    Top = 295
    Width = 75
    Height = 25
    Caption = #37329#38065
    TabOrder = 38
    OnClick = btn30Click
  end
  object cbb8: TComboBox
    Left = 229
    Top = 297
    Width = 81
    Height = 20
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 12
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 41
    Text = #20840#37096#22686#21152
    Items.Strings = (
      #20840#37096#22686#21152
      #20840#37096#20943#23569
      #20840#37096#31561#20110)
  end
  object edt13: TRzSpinEdit
    Left = 326
    Top = 297
    Width = 97
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 42
  end
  object edt14: TEdit
    Left = 90
    Top = 166
    Width = 104
    Height = 20
    TabOrder = 20
  end
  object edt15: TRzSpinEdit
    Left = 236
    Top = 166
    Width = 47
    Height = 20
    AllowKeyEdit = True
    Max = 65535.000000000000000000
    TabOrder = 21
  end
  object edt16: TRzSpinEdit
    Left = 325
    Top = 166
    Width = 47
    Height = 20
    AllowKeyEdit = True
    Max = 65535.000000000000000000
    TabOrder = 22
  end
  object btn33: TButton
    Left = 9
    Top = 164
    Width = 75
    Height = 25
    Caption = #24403#21069#22320#22270
    TabOrder = 19
    OnClick = btn33Click
  end
  object cbb9: TComboBox
    Left = 229
    Top = 329
    Width = 81
    Height = 20
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 12
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 47
    Text = #20840#37096#22686#21152
    Items.Strings = (
      #20840#37096#22686#21152
      #20840#37096#20943#23569
      #20840#37096#31561#20110)
  end
  object edt20: TRzSpinEdit
    Left = 326
    Top = 329
    Width = 97
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 48
  end
  object cbb10: TComboBox
    Left = 91
    Top = 199
    Width = 50
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 24
    Text = #22823#20110
    Items.Strings = (
      #22823#20110
      #31561#20110
      #23569#20110)
  end
  object edt23: TRzSpinEdit
    Left = 146
    Top = 199
    Width = 77
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 25
  end
  object cbb11: TComboBox
    Left = 90
    Top = 232
    Width = 50
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 29
    Text = #22823#20110
    Items.Strings = (
      #22823#20110
      #31561#20110
      #23569#20110)
  end
  object edt24: TRzSpinEdit
    Left = 146
    Top = 232
    Width = 78
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 30
  end
  object cbb12: TComboBox
    Left = 91
    Top = 264
    Width = 50
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 34
    Text = #22823#20110
    Items.Strings = (
      #22823#20110
      #31561#20110
      #23569#20110)
  end
  object edt25: TRzSpinEdit
    Left = 146
    Top = 264
    Width = 77
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 35
  end
  object cbb13: TComboBox
    Left = 90
    Top = 297
    Width = 50
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 39
    Text = #22823#20110
    Items.Strings = (
      #22823#20110
      #31561#20110
      #23569#20110)
  end
  object edt26: TRzSpinEdit
    Left = 146
    Top = 297
    Width = 77
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 40
  end
  object edt27: TRzSpinEdit
    Left = 146
    Top = 329
    Width = 77
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 46
  end
  object cbb14: TComboBox
    Left = 90
    Top = 329
    Width = 50
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    ItemIndex = 0
    TabOrder = 45
    Text = #22823#20110
    Items.Strings = (
      #22823#20110
      #31561#20110
      #23569#20110)
  end
  object btn40: TButton
    Left = 9
    Top = 327
    Width = 75
    Height = 25
    Caption = #20803#23453
    TabOrder = 44
    OnClick = btn40Click
  end
  object btn25: TButton
    Left = 9
    Top = 100
    Width = 75
    Height = 25
    Caption = #29289#21697#21024#38500
    TabOrder = 13
    OnClick = btn25Click
  end
  object cbb3: TComboBox
    Left = 90
    Top = 103
    Width = 81
    Height = 20
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 12
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 14
    Text = #25351#23450#29289#21697
    Items.Strings = (
      #25351#23450#29289#21697
      #25152#26377#29289#21697
      #36523#19978#29289#21697
      #21253#35065#29289#21697
      #20179#24211#29289#21697)
  end
  object edt8: TRzSpinEdit
    Left = 207
    Top = 103
    Width = 67
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 15
  end
  object edt9: TRzSpinEdit
    Left = 207
    Top = 133
    Width = 67
    Height = 20
    AllowKeyEdit = True
    Max = 2147483647.000000000000000000
    TabOrder = 18
  end
  object cbb4: TComboBox
    Left = 90
    Top = 133
    Width = 81
    Height = 20
    Style = csDropDownList
    BiDiMode = bdLeftToRight
    ItemHeight = 12
    ItemIndex = 0
    ParentBiDiMode = False
    TabOrder = 17
    Text = #25351#23450#25216#33021
    Items.Strings = (
      #25351#23450#25216#33021
      #25152#26377#25216#33021)
  end
  object btn26: TButton
    Left = 9
    Top = 131
    Width = 75
    Height = 25
    Caption = #25216#33021#21024#38500
    TabOrder = 16
    OnClick = btn26Click
  end
  object btn1: TButton
    Left = 472
    Top = 324
    Width = 75
    Height = 25
    Caption = #36864#20986'(X)'
    TabOrder = 43
    OnClick = btn1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 360
    Width = 576
    Height = 19
    Panels = <
      item
        Width = 490
      end
      item
        Width = 50
      end>
  end
end
