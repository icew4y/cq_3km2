object frmViewList2: TfrmViewList2
  Left = 191
  Top = 207
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26597#30475#21015#34920#20108#20449#24687
  ClientHeight = 449
  ClientWidth = 723
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 723
    Height = 449
    ActivePage = TabSheet1
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22871#35013#29289#21697
      object Label34: TLabel
        Left = 6
        Top = 371
        Width = 324
        Height = 48
        Caption = 
          #37325#35201#35828#26126#65306#22871#35013#29289#21697#19981#19968#23450#35201#36319#22871#35013#25968#37327#30456#31561#65292#20363#22914#22871#35013#25968#37327#13#35774#32622#20026'2'#65292#22871#35013#29289#21697#35774#32622#20026#25163#38255#65292#21482#35201#24102#21452#25163#38255#21363#35302#21457#12290#21482#25345#13#21333#20214#35013#22791#26080#27861#35302#21457 +
          #20351#29992#12290#20363#22914#65306#22307#25112#25163#38255#21152#22836#30420#19968#22871#65292#22307#25112#25163#13#38255#21152#39033#38142#21448#26159#19968#22871'('#22871#35013#29289#21697#26684#24335#65306'XXXX|XXXX|)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 0
        Width = 334
        Height = 361
        Caption = #22871#35013#21015#34920
        TabOrder = 0
        object ListView1: TListView
          Left = 6
          Top = 15
          Width = 323
          Height = 338
          Columns = <
            item
              Caption = #24207#21495
              Width = 40
            end
            item
              Caption = #22871#35013#35828#26126
              Width = 120
            end
            item
              Caption = #25968#37327
              Width = 38
            end
            item
              Caption = #22871#35013#29289#21697
              Width = 120
            end
            item
              Caption = #23646#24615
              Width = 120
            end>
          GridLines = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListView1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 346
        Top = 0
        Width = 363
        Height = 361
        Caption = #38468#21152#23646#24615#35774#32622
        TabOrder = 1
        object Label1: TLabel
          Left = 3
          Top = 17
          Width = 41
          Height = 13
          Caption = 'HP'#22686#21152':'
        end
        object Label2: TLabel
          Left = 126
          Top = 16
          Width = 42
          Height = 13
          Caption = 'MP'#22686#21152':'
        end
        object Label3: TLabel
          Left = 243
          Top = 16
          Width = 52
          Height = 13
          Caption = #32463#39564#20493#25968':'
        end
        object Label4: TLabel
          Left = 3
          Top = 38
          Width = 52
          Height = 13
          Caption = #25915#20987#19978#38480':'
        end
        object Label5: TLabel
          Left = 126
          Top = 38
          Width = 52
          Height = 13
          Caption = #25915#20987#19979#38480':'
        end
        object Label6: TLabel
          Left = 243
          Top = 38
          Width = 52
          Height = 13
          Caption = #25915#20987#20493#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 6
          Top = 61
          Width = 52
          Height = 13
          Caption = #39764#27861#19978#38480':'
        end
        object Label8: TLabel
          Left = 126
          Top = 61
          Width = 52
          Height = 13
          Caption = #39764#27861#19979#38480':'
        end
        object Label9: TLabel
          Left = 243
          Top = 61
          Width = 52
          Height = 13
          Caption = #39764#27861#20493#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 6
          Top = 84
          Width = 52
          Height = 13
          Caption = #36947#26415#19978#38480':'
        end
        object Label11: TLabel
          Left = 126
          Top = 84
          Width = 52
          Height = 13
          Caption = #36947#26415#19979#38480':'
        end
        object Label12: TLabel
          Left = 243
          Top = 84
          Width = 52
          Height = 13
          Caption = #36947#26415#20493#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 6
          Top = 106
          Width = 52
          Height = 13
          Caption = #38450#24481#19978#38480':'
        end
        object Label14: TLabel
          Left = 126
          Top = 106
          Width = 52
          Height = 13
          Caption = #38450#24481#19979#38480':'
        end
        object Label15: TLabel
          Left = 243
          Top = 106
          Width = 52
          Height = 13
          Caption = #38450#24481#20493#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 243
          Top = 129
          Width = 52
          Height = 13
          Caption = #39764#24481#20493#25968':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 126
          Top = 129
          Width = 52
          Height = 13
          Caption = #39764#24481#19979#38480':'
        end
        object Label18: TLabel
          Left = 6
          Top = 129
          Width = 52
          Height = 13
          Caption = #39764#24481#19978#38480':'
        end
        object Label19: TLabel
          Left = 6
          Top = 152
          Width = 46
          Height = 13
          Caption = #20934' '#30830' '#24230':'
        end
        object Label20: TLabel
          Left = 126
          Top = 152
          Width = 46
          Height = 13
          Caption = #25935' '#25463' '#24230':'
        end
        object Label21: TLabel
          Left = 243
          Top = 152
          Width = 52
          Height = 13
          Caption = #39764#27861#36530#36991':'
        end
        object Label22: TLabel
          Left = 243
          Top = 175
          Width = 52
          Height = 13
          Caption = #27602#29289#36530#36991':'
        end
        object Label23: TLabel
          Left = 126
          Top = 175
          Width = 52
          Height = 13
          Caption = #39764#27861#24674#22797':'
        end
        object Label24: TLabel
          Left = 6
          Top = 175
          Width = 52
          Height = 13
          Caption = #20307#21147#24674#22797':'
        end
        object Label27: TLabel
          Left = 126
          Top = 198
          Width = 46
          Height = 13
          Caption = #24184' '#36816' '#20540':'
        end
        object Label28: TLabel
          Left = 6
          Top = 197
          Width = 56
          Height = 13
          Caption = #21560#34880'('#34425#39764')'
        end
        object Label29: TLabel
          Left = 243
          Top = 198
          Width = 52
          Height = 13
          Caption = #20013#27602#24674#22797':'
        end
        object Label30: TLabel
          Left = 5
          Top = 219
          Width = 52
          Height = 13
          Caption = #20869#21147#24674#22797':'
        end
        object Label31: TLabel
          Left = 7
          Top = 316
          Width = 52
          Height = 13
          Caption = #22871#35013#25968#37327':'
        end
        object Label32: TLabel
          Left = 123
          Top = 316
          Width = 52
          Height = 13
          Caption = #22871#35013#35828#26126':'
        end
        object Label33: TLabel
          Left = 7
          Top = 337
          Width = 52
          Height = 13
          Caption = #22871#35013#29289#21697':'
        end
        object Label82: TLabel
          Left = 126
          Top = 218
          Width = 52
          Height = 13
          Caption = #21512#20987#20260#23475':'
        end
        object Label83: TLabel
          Left = 243
          Top = 218
          Width = 49
          Height = 13
          Caption = #38450'       '#29190':'
        end
        object Label26: TLabel
          Left = 5
          Top = 242
          Width = 56
          Height = 13
          Caption = #21560#34880'('#34382#23041')'
          Enabled = False
        end
        object Label80: TLabel
          Left = 126
          Top = 241
          Width = 52
          Height = 13
          Caption = #20869#21147#20260#23475':'
        end
        object Label84: TLabel
          Left = 243
          Top = 241
          Width = 52
          Height = 13
          Caption = #21484#21796#24040#39764':'
        end
        object Label85: TLabel
          Left = 10
          Top = 264
          Width = 49
          Height = 13
          Caption = #32844'       '#19994':'
        end
        object Label86: TLabel
          Left = 123
          Top = 261
          Width = 58
          Height = 13
          Caption = #21512#20987#20260#23475'2:'
        end
        object Label87: TLabel
          Left = 244
          Top = 263
          Width = 52
          Height = 13
          Caption = #20027'  '#23646'  '#24615':'
        end
        object SpinEdtMaxHP: TSpinEdit
          Left = 61
          Top = 12
          Width = 61
          Height = 22
          Hint = 'HP'#22686#21152#30340#28857#25968#65292#23454#38469#20540#31561#20110#21407'HP * '#65288#35774#23450#20540' / 100'#65289
          EditorEnabled = False
          MaxValue = 1000000000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          Value = 0
        end
        object SpinEdtMaxMP: TSpinEdit
          Left = 178
          Top = 12
          Width = 61
          Height = 22
          Hint = 'MP'#22686#21152#30340#28857#25968#65292#23454#38469#20540#31561#20110#21407'MP * '#65288#35774#23450#20540' / 100'#65289
          EditorEnabled = False
          MaxValue = 1000000000
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Value = 0
        end
        object SpinEdit2: TSpinEdit
          Left = 297
          Top = 12
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'1'#21017#34920#31034'1'#20493'  ('#25152#24471#21040#30340#32463#39564#20540'='#24403#21069#32463#39564#20540'*'#32463#39564#20493#25968'),'#22914#26524#35774#32622#20026'1'#20493','#21017#26159#21407#26469#30340#32463#39564#25968#12290
          MaxValue = 65535
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Value = 1
        end
        object SpinEdit3: TSpinEdit
          Left = 61
          Top = 34
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 3
          Value = 0
        end
        object SpinEdit4: TSpinEdit
          Left = 178
          Top = 34
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 4
          Value = 0
        end
        object SpinEdit5: TSpinEdit
          Left = 297
          Top = 34
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#25915#20987#20540'='#25915#20987#20540'*'#35774#32622#25968'/10),'#22914#26524#35774#32622#20026'10,'#21017#26159#21407#26469#30340#25915#20987#20540#12290
          MaxValue = 65535
          MinValue = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 10
        end
        object SpinEdit6: TSpinEdit
          Left = 61
          Top = 57
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 6
          Value = 0
        end
        object SpinEdit7: TSpinEdit
          Left = 178
          Top = 57
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 7
          Value = 0
        end
        object SpinEdit8: TSpinEdit
          Left = 297
          Top = 57
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#39764#27861#20540'='#39764#27861#20540'*'#35774#32622#20540'/10),'#22914#26524#35774#32622#20026'10,'#21017#26159#21407#26469#30340#39764#27861#20540#12290
          MaxValue = 65535
          MinValue = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          Value = 10
        end
        object SpinEdit9: TSpinEdit
          Left = 61
          Top = 80
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 9
          Value = 0
        end
        object SpinEdit10: TSpinEdit
          Left = 178
          Top = 80
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 10
          Value = 0
        end
        object SpinEdit11: TSpinEdit
          Left = 298
          Top = 80
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#36947#26415#20540'='#36947#26415#20540'*'#35774#32622#20540'/10),'#22914#26524#35774#32622#20026'10,'#21017#26159#21407#26469#30340#36947#26415#20540#12290
          MaxValue = 65535
          MinValue = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          Value = 10
        end
        object SpinEdit12: TSpinEdit
          Left = 61
          Top = 102
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 12
          Value = 0
        end
        object SpinEdit13: TSpinEdit
          Left = 178
          Top = 102
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 13
          Value = 0
        end
        object SpinEdit14: TSpinEdit
          Left = 298
          Top = 102
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#38450#24481#20540'='#38450#24481#20540'*'#35774#32622#25968'/10),'#22914#26524#35774#32622#20026'10,'#21017#26159#21407#26469#30340#38450#24481#20540#12290
          MaxValue = 65535
          MinValue = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          Value = 10
        end
        object SpinEdit15: TSpinEdit
          Left = 298
          Top = 125
          Width = 61
          Height = 22
          Hint = #35813#20540#20026#23454#38469#20493#25968#12290#20540#20026'10'#21017#34920#31034'1'#20493','#19978#38480#21644#19979#38480#21516#26102#32763#20493' ('#39764#24481#20540'='#39764#24481#20540'*'#35774#32622#20540'/10),'#22914#26524#35774#32622#20026'10,'#21017#26159#21407#26469#30340#39764#24481#20540#12290
          MaxValue = 65535
          MinValue = 10
          ParentShowHint = False
          ShowHint = True
          TabOrder = 15
          Value = 10
        end
        object SpinEdit16: TSpinEdit
          Left = 178
          Top = 125
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 16
          Value = 0
        end
        object SpinEdit17: TSpinEdit
          Left = 61
          Top = 125
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 17
          Value = 0
        end
        object SpinEdit18: TSpinEdit
          Left = 61
          Top = 148
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 18
          Value = 0
        end
        object SpinEdit19: TSpinEdit
          Left = 178
          Top = 148
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 19
          Value = 0
        end
        object SpinEdit20: TSpinEdit
          Left = 298
          Top = 148
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 20
          Value = 0
        end
        object SpinEdit21: TSpinEdit
          Left = 298
          Top = 171
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 21
          Value = 0
        end
        object SpinEdit22: TSpinEdit
          Left = 178
          Top = 171
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 22
          Value = 0
        end
        object SpinEdit23: TSpinEdit
          Left = 61
          Top = 171
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 23
          Value = 0
        end
        object SpinEdit26: TSpinEdit
          Left = 178
          Top = 194
          Width = 61
          Height = 22
          MaxValue = 65535
          MinValue = 0
          TabOrder = 24
          Value = 0
        end
        object SpinEdit24: TSpinEdit
          Left = 61
          Top = 193
          Width = 61
          Height = 22
          Hint = #25171#24618#25481#34880'200,'#35774#32622#20540#20026'5,200/100*5=10,'#21363#21152#34880'10'#28857
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 25
          Value = 0
        end
        object SpinEdit28: TSpinEdit
          Left = 298
          Top = 194
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#22686#21152'1'
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 26
          Value = 0
        end
        object SpinEdit25: TSpinEdit
          Left = 61
          Top = 215
          Width = 61
          Height = 22
          Hint = #35774#32622'1'#28857#20195#34920#20869#21147#24674#22797#36895#24230'+1%'#13#10
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 27
          Value = 0
        end
        object SpinEdit30: TSpinEdit
          Left = 59
          Top = 312
          Width = 61
          Height = 22
          MaxValue = 12
          MinValue = 1
          TabOrder = 28
          Value = 1
        end
        object Edit1: TEdit
          Left = 176
          Top = 313
          Width = 183
          Height = 21
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 29
        end
        object Edit2: TEdit
          Left = 58
          Top = 335
          Width = 300
          Height = 21
          Hint = #29289#21697#26684#24335#65306'XXXX'#65073
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 30
        end
        object SpinEdit27: TSpinEdit
          Left = 178
          Top = 214
          Width = 61
          Height = 22
          Hint = #21512#20987#20260#23475#22686#21152#30334#20998#29575
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 31
          Value = 0
        end
        object SpinEdit29: TSpinEdit
          Left = 298
          Top = 214
          Width = 61
          Height = 22
          MaxValue = 255
          MinValue = 0
          TabOrder = 32
          Value = 0
        end
        object CheckBoxTeleport: TCheckBox
          Left = 6
          Top = 280
          Width = 44
          Height = 17
          Caption = #20256#36865
          TabOrder = 33
        end
        object CheckBoxParalysis: TCheckBox
          Left = 52
          Top = 280
          Width = 45
          Height = 17
          Caption = #40635#30201
          TabOrder = 34
        end
        object CheckBoxRevival: TCheckBox
          Left = 99
          Top = 280
          Width = 45
          Height = 17
          Caption = #22797#27963
          TabOrder = 35
        end
        object CheckBoxMagicShield: TCheckBox
          Left = 146
          Top = 280
          Width = 45
          Height = 17
          Caption = #25252#36523
          TabOrder = 36
        end
        object CheckBoxUnParalysis: TCheckBox
          Left = 190
          Top = 280
          Width = 56
          Height = 17
          Caption = #38450#40635#30201
          TabOrder = 37
        end
        object CheckBoxUnRevival: TCheckBox
          Left = 246
          Top = 280
          Width = 57
          Height = 17
          Caption = #38450#22797#27963
          TabOrder = 38
        end
        object CheckBoxUnMagicShield: TCheckBox
          Left = 303
          Top = 280
          Width = 57
          Height = 17
          Caption = #38450#25252#36523
          TabOrder = 39
        end
        object SpinEdit62: TSpinEdit
          Left = 61
          Top = 238
          Width = 61
          Height = 22
          Hint = #34382#23041#35013#22791#29983#25928#26102','#26368#39640#30446#26631#25481#34880#20540#21487#21560#34880#30340#27604#20363#13#10#22914#35774#32622'50,'#34920#31034','#30446#26631#25481#34880#26102','#21560#34880#29983#25928#26102','#21560#34880#20540'='#20260#23475#20540'*'#38543#26426'(50)/100'
          Enabled = False
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 40
          Value = 0
        end
        object SpinEdit63: TSpinEdit
          Left = 178
          Top = 237
          Width = 61
          Height = 22
          Hint = #25915#20987#30446#26631','#20351#30446#26631#30340#20869#21147#20540#20943#23569
          MaxValue = 255
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 41
          Value = 0
        end
        object SpinEdit64: TSpinEdit
          Left = 299
          Top = 237
          Width = 61
          Height = 22
          Hint = 
            #20256#22855#31070#21073#20026#20351#29992#35813#25216#33021#30340#24517#22791#36947#20855#65292#32570#22833#23558#20007#22833#35813#25216#33021#13#10#20197#31561#32423#26368#39640#20026#20934','#21363#22914#26377'N'#22871#35013#21487#22686#21152#21484#21796#24040#39764#31561#32423','#21017#20197#20540#26368#39640#30340#20026#20934#13#10#21482#23545#20027#20307 +
            #29983#25928
          MaxValue = 4
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 42
          Value = 0
        end
        object SpinEdit65: TSpinEdit
          Left = 62
          Top = 260
          Width = 61
          Height = 22
          Hint = '0-'#25112' 1-'#27861' 2-'#36947' 3-'#19981#38480#32844#19994
          MaxValue = 3
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 43
          Value = 3
        end
        object SpinEdit66: TSpinEdit
          Left = 178
          Top = 257
          Width = 61
          Height = 22
          Hint = #21512#20987#20260#23475#22686#21152#28857#25968
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 44
          Value = 0
        end
        object SpinEdit67: TSpinEdit
          Left = 299
          Top = 256
          Width = 61
          Height = 22
          Hint = #25112#22763#20329#25140#22686#21152#25915#20987#65292#27861#24072#20329#25140#22686#21152#39764#27861#65292#36947#22763#20329#25140#22686#21152#36947#26415
          MaxValue = 65535
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 45
          Value = 0
        end
        object CheckBox1: TCheckBox
          Left = 6
          Top = 295
          Width = 71
          Height = 17
          Caption = #25112#24847#40635#30201
          TabOrder = 46
        end
        object CheckBox2: TCheckBox
          Left = 78
          Top = 295
          Width = 71
          Height = 17
          Caption = #39764#36947#40635#30201
          TabOrder = 47
        end
        object CheckBox3: TCheckBox
          Left = 150
          Top = 295
          Width = 71
          Height = 17
          Caption = #39764#24847#40635#30201
          TabOrder = 48
        end
        object CheckBox4: TCheckBox
          Left = 220
          Top = 295
          Width = 125
          Height = 17
          Caption = 'HPMP'#25353#30334#20998#27604#22686#21152
          TabOrder = 49
        end
      end
      object Button1: TButton
        Left = 350
        Top = 365
        Width = 63
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 422
        Top = 365
        Width = 63
        Height = 25
        Caption = #21024#38500'(&D)'
        Enabled = False
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 495
        Top = 365
        Width = 63
        Height = 25
        Caption = #20462#25913'(&E)'
        Enabled = False
        TabOrder = 4
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 566
        Top = 365
        Width = 63
        Height = 25
        Caption = #20445#23384'(&S)'
        Enabled = False
        TabOrder = 5
        OnClick = Button4Click
      end
      object Button7: TButton
        Left = 635
        Top = 367
        Width = 65
        Height = 25
        Hint = #37325#26032#21152#36733#26032#30340#22871#35013#37197#32622','#21363#22312'M2'#37324#29983#25928','#22914#19981#37325#26032#21152#36733','#21017#28216#25103#37324#19981#33021#20351#29992#26032#30340#37197#32622
        Caption = #37325#26032#21152#36733
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = Button7Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #21464#37327#31649#29702
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label35: TLabel
        Left = 8
        Top = 2
        Width = 72
        Height = 13
        Caption = #20840#23616#25972#24418#21464#37327
      end
      object Label36: TLabel
        Left = 349
        Top = 4
        Width = 72
        Height = 13
        Caption = #20840#23616#23383#31526#21464#37327
      end
      object ListView2: TListView
        Left = 0
        Top = 22
        Width = 329
        Height = 395
        Hint = #21452#20987#20462#25913#21464#37327#20540
        Columns = <
          item
            Caption = #24207#21495
          end
          item
            Caption = #25968#20540#21464#37327#20540
            Width = 230
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = ListView2DblClick
      end
      object ListView3: TListView
        Left = 342
        Top = 22
        Width = 355
        Height = 395
        Hint = #21452#20987#20462#25913#21464#37327#20540
        Columns = <
          item
            Caption = #24207#21495
          end
          item
            Caption = #23383#31526#21464#37327#20540
            Width = 270
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = ListView3DblClick
      end
      object Button5: TButton
        Left = 248
        Top = 4
        Width = 76
        Height = 19
        Caption = #20840#37096#28165#38500
        TabOrder = 2
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 619
        Top = 4
        Width = 76
        Height = 19
        Caption = #20840#37096#28165#38500
        TabOrder = 3
        OnClick = Button6Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #28140#32451#37197#32622
      ImageIndex = 2
      OnShow = TabSheet3Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label37: TLabel
        Left = 0
        Top = 408
        Width = 432
        Height = 12
        Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label38: TLabel
        Left = 0
        Top = 0
        Width = 72
        Height = 13
        Caption = #28140#32451#26448#26009#21015#34920
      end
      object Label39: TLabel
        Left = 192
        Top = 0
        Width = 108
        Height = 13
        Caption = #28140#32451#25104#21151#21518#24471#21040#29289#21697
      end
      object Label78: TLabel
        Left = 360
        Top = 0
        Width = 6
        Height = 11
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object RefineItemListBox: TListBox
        Left = -1
        Top = 13
        Width = 189
        Height = 288
        Hint = #21452#20987#36873#25321#23545#24212#30340#26448#26009#36827#34892#25805#20316
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnDblClick = RefineItemListBoxDblClick
      end
      object ListView4: TListView
        Left = 189
        Top = 13
        Width = 308
        Height = 392
        Hint = #21452#20987#36873#25321#29289#21697#25968#25454'('#20462#25913#29289#21697#21517#31216#26080#25928')'
        Columns = <
          item
            Caption = #29289#21697
            Width = 65
          end
          item
            Caption = #25104#21151#29575
            Width = 48
          end
          item
            Caption = #36824#21407#29575
            Width = 48
          end
          item
            Caption = #26159#21542#28040#22833
            Width = 60
          end
          item
            Caption = #26497#21697#29575
            Width = 48
          end
          item
            Caption = #23646#24615#35774#32622
            Width = 200
          end>
        GridLines = True
        RowSelect = True
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        ViewStyle = vsReport
        OnClick = ListView4Click
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 304
        Width = 188
        Height = 101
        Caption = #28140#32451#26448#26009#35774#32622
        TabOrder = 2
        object Label40: TLabel
          Left = 4
          Top = 23
          Width = 40
          Height = 13
          Caption = #26448#26009#19968':'
        end
        object Label41: TLabel
          Left = 4
          Top = 46
          Width = 40
          Height = 13
          Caption = #26448#26009#20108':'
        end
        object Label42: TLabel
          Left = 4
          Top = 70
          Width = 40
          Height = 13
          Caption = #26448#26009#19977':'
        end
        object Edit3: TEdit
          Left = 44
          Top = 19
          Width = 75
          Height = 21
          Hint = #19977#20214#26448#26009#20013#38656#35201#26377#19968#20214#26159#28779#20113#30707#25110#28779#20113#26230#30707
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Edit4: TEdit
          Left = 44
          Top = 43
          Width = 75
          Height = 21
          Hint = #19977#20214#26448#26009#20013#38656#35201#26377#19968#20214#26159#28779#20113#30707#25110#28779#20113#26230#30707
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object Edit5: TEdit
          Left = 44
          Top = 67
          Width = 75
          Height = 21
          Hint = #19977#20214#26448#26009#20013#38656#35201#26377#19968#20214#26159#28779#20113#30707#25110#28779#20113#26230#30707
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object Button8: TButton
          Left = 121
          Top = 9
          Width = 62
          Height = 22
          Caption = #22686#21152
          TabOrder = 3
          OnClick = Button8Click
        end
        object Button9: TButton
          Left = 121
          Top = 31
          Width = 62
          Height = 22
          Caption = #20462#25913
          Enabled = False
          TabOrder = 4
          OnClick = Button9Click
        end
        object Button10: TButton
          Left = 121
          Top = 53
          Width = 62
          Height = 22
          Caption = #21024#38500
          Enabled = False
          TabOrder = 5
          OnClick = Button10Click
        end
        object Button11: TButton
          Left = 121
          Top = 75
          Width = 62
          Height = 22
          Caption = #20445#23384
          Enabled = False
          TabOrder = 6
          OnClick = Button11Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 501
        Top = 8
        Width = 214
        Height = 409
        Caption = #29289#21697#35774#32622
        TabOrder = 3
        object Label43: TLabel
          Left = 5
          Top = 17
          Width = 52
          Height = 13
          Caption = #29289#21697#21517#31216':'
        end
        object Label44: TLabel
          Left = 6
          Top = 40
          Width = 40
          Height = 13
          Caption = #25104#21151#29575':'
        end
        object Label45: TLabel
          Left = 100
          Top = 40
          Width = 40
          Height = 13
          Hint = #31929#32451#22833#36133#21518','#36824#21407#29289#21697#30340#26426#29575','#21363#21319#32423#29289#21697#23646#24615#19981#21464#31561
          Caption = #36824#21407#29575':'
          ParentShowHint = False
          ShowHint = True
        end
        object Label46: TLabel
          Left = 6
          Top = 64
          Width = 40
          Height = 13
          Caption = #28779#20113#30707':'
        end
        object Label47: TLabel
          Left = 100
          Top = 64
          Width = 40
          Height = 13
          Hint = #31929#32451#22833#36133#21518','#36824#21407#29289#21697#30340#26426#29575','#21363#21319#32423#29289#21697#23646#24615#19981#21464#31561
          Caption = #26497#21697#29575':'
          ParentShowHint = False
          ShowHint = True
        end
        object Button12: TButton
          Left = 149
          Top = 307
          Width = 62
          Height = 22
          Caption = #22686#21152
          TabOrder = 0
          OnClick = Button12Click
        end
        object Button13: TButton
          Left = 149
          Top = 331
          Width = 62
          Height = 22
          Caption = #20462#25913
          TabOrder = 1
          OnClick = Button13Click
        end
        object Button14: TButton
          Left = 149
          Top = 355
          Width = 62
          Height = 22
          Caption = #21024#38500
          TabOrder = 2
          OnClick = Button14Click
        end
        object Button15: TButton
          Left = 150
          Top = 379
          Width = 62
          Height = 22
          Caption = #20445#23384
          TabOrder = 3
          OnClick = Button15Click
        end
        object Edit6: TEdit
          Left = 58
          Top = 13
          Width = 127
          Height = 21
          Hint = #20462#25913#26102#29289#21697#21517#23383#20462#25913#26080#25928';'#22686#21152#26102','#29289#21697#21517#31216#37325#22797#23558#26080#25928'!'
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object SpinEdit1: TSpinEdit
          Left = 49
          Top = 35
          Width = 44
          Height = 22
          Hint = #31929#32451#25104#21151#30340#26426#29575','#20540#20026'100,'#21363#30334#20998#30334#31929#32451#25104#21151
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Value = 0
        end
        object SpinEdit31: TSpinEdit
          Left = 144
          Top = 35
          Width = 44
          Height = 22
          Hint = #31929#32451#22833#36133#36824#21407#29289#21697#30340#26426#29575','#20540#20026'100,'#21363#31929#32451#22833#36133#21518','#30334#20998#30334#36864#22238#21407#29289#21697
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          Value = 0
        end
        object SpinEdit32: TSpinEdit
          Left = 49
          Top = 59
          Width = 44
          Height = 22
          Hint = #28779#20113#30707#26159#21542#28040#22833',0='#20943#23569#25345#20037' ,1='#28040#22833
          MaxValue = 1
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Value = 0
        end
        object SpinEdit33: TSpinEdit
          Left = 144
          Top = 59
          Width = 44
          Height = 22
          Hint = #31929#32451#25104#21151#21518','#21462#24471#26426#21697#23646#24615#30340#26426#29575','#27880':'#27492#26497#21697#23646#24615#38750#35774#32622#30340#23646#24615
          MaxValue = 100
          MinValue = 0
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          Value = 0
        end
        object GroupBox5: TGroupBox
          Left = 4
          Top = 82
          Width = 143
          Height = 324
          TabOrder = 9
          object Label48: TLabel
            Left = 6
            Top = 18
            Width = 40
            Height = 13
            Hint = 'AC2'
            Caption = #23646#24615#19968':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label49: TLabel
            Left = 6
            Top = 38
            Width = 40
            Height = 13
            Hint = 'MAC2'
            Caption = #23646#24615#20108':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label50: TLabel
            Left = 6
            Top = 61
            Width = 40
            Height = 13
            Hint = 'DC2'
            Caption = #23646#24615#19977':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label51: TLabel
            Left = 7
            Top = 85
            Width = 40
            Height = 13
            Hint = 'MC2'
            Caption = #23646#24615#22235':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label52: TLabel
            Left = 7
            Top = 106
            Width = 40
            Height = 13
            Hint = 'SC2'
            Caption = #23646#24615#20116':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label53: TLabel
            Left = 7
            Top = 126
            Width = 40
            Height = 13
            Hint = #20329#24102#38656#27714
            Caption = #23646#24615#20845':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label54: TLabel
            Left = 7
            Top = 149
            Width = 40
            Height = 13
            Hint = #20329#24102#32423#21035' '
            Caption = #23646#24615#19971':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label55: TLabel
            Left = 7
            Top = 172
            Width = 40
            Height = 13
            Hint = 'Reserved'
            Caption = #23646#24615#20843':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label56: TLabel
            Left = 2
            Top = 238
            Width = 48
            Height = 13
            Caption = #23646#24615#21313#19968
          end
          object Label57: TLabel
            Left = 1
            Top = 259
            Width = 48
            Height = 13
            Caption = #23646#24615#21313#20108
            Enabled = False
          end
          object Label58: TLabel
            Left = 1
            Top = 281
            Width = 48
            Height = 13
            Caption = #23646#24615#21313#19977
          end
          object Label59: TLabel
            Left = 2
            Top = 304
            Width = 48
            Height = 13
            Hint = #25345#20037
            Caption = #23646#24615#21313#22235
            ParentShowHint = False
            ShowHint = True
          end
          object Label60: TLabel
            Left = 8
            Top = 216
            Width = 40
            Height = 13
            Caption = #23646#24615#21313':'
          end
          object Label61: TLabel
            Left = 7
            Top = 193
            Width = 40
            Height = 13
            Caption = #23646#24615#20061':'
          end
          object Label62: TLabel
            Left = 87
            Top = 18
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label63: TLabel
            Left = 87
            Top = 38
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label64: TLabel
            Left = 86
            Top = 61
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label65: TLabel
            Left = 87
            Top = 85
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label66: TLabel
            Left = 87
            Top = 106
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label67: TLabel
            Left = 87
            Top = 126
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label68: TLabel
            Left = 87
            Top = 149
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label69: TLabel
            Left = 87
            Top = 172
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label70: TLabel
            Left = 87
            Top = 193
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label71: TLabel
            Left = 87
            Top = 216
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label72: TLabel
            Left = 87
            Top = 238
            Width = 12
            Height = 13
            Caption = #19968
            Enabled = False
          end
          object Label73: TLabel
            Left = 87
            Top = 259
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label74: TLabel
            Left = 87
            Top = 281
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label75: TLabel
            Left = 88
            Top = 303
            Width = 12
            Height = 13
            Caption = #19968
          end
          object Label76: TLabel
            Left = 45
            Top = -1
            Width = 48
            Height = 13
            Caption = #26368#39640#28857#25968
          end
          object Label77: TLabel
            Left = 102
            Top = -1
            Width = 24
            Height = 13
            Caption = #38590#24230
          end
          object SpinEdit34: TSpinEdit
            Left = 49
            Top = 13
            Width = 40
            Height = 22
            Hint = 
              #27494#22120'(5,6) '#20026#25915#20987#13#39033#38142'(19) '#20026#39764#27861#36530#36991#13#39033#38142'(20)\ '#25163#38255'(24) '#20026#20934#30830#13#39033#38142'(21) '#20026#20307#21147#24674#22797#13#25106#25351'(23) ' +
              #20026#27602#29289#36530#36991#13#20854#20182'   '#20026#38450#24481
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Value = 0
          end
          object SpinEdit36: TSpinEdit
            Left = 49
            Top = 35
            Width = 40
            Height = 22
            Hint = 
              #39033#38142'(19)  '#20026#24184#36816#13#39033#38142'(20)\'#25163#38255'(24) '#20026#25935#25463#13#39033#38142'(21)   '#20026#39764#27861#24674#22797#13#25106#25351'(23)   '#20026#20013#27602#24674#22797#13#27494#22120'(5' +
              ',6)  '#20026#39764#27861#13#20854#20182' '#20026#39764#24481
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Value = 0
          end
          object SpinEdit37: TSpinEdit
            Left = 49
            Top = 57
            Width = 40
            Height = 22
            Hint = #27494#22120'(5,6)  '#20026#36947#26415#13#20854#20182'         '#20026#25915#20987
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Value = 0
          end
          object SpinEdit38: TSpinEdit
            Left = 49
            Top = 79
            Width = 40
            Height = 22
            Hint = #27494#22120'(5,6)  '#20026#24184#36816#13#20854#20182'         '#20026#39764#27861
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Value = 0
          end
          object SpinEdit39: TSpinEdit
            Left = 49
            Top = 167
            Width = 40
            Height = 22
            Hint = #27494#22120'  '#20026#24378#24230#13#25106#25351'\'#25163#38255'\'#39033#38142' '#20026#20329#24102#32423#21035#13#20854#20182#26080#25928
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Value = 0
          end
          object SpinEdit40: TSpinEdit
            Left = 49
            Top = 101
            Width = 40
            Height = 22
            Hint = #27494#22120'(5,6)  '#20026#35781#21650#13#20854#20182'         '#20026#36947#26415
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            Value = 0
          end
          object SpinEdit41: TSpinEdit
            Left = 49
            Top = 123
            Width = 40
            Height = 22
            Hint = #27494#22120'(5,6)  '#20026#20934#30830#13#22836#30420'\'#26007#31520'  '#20026#20329#24102#38656#27714#13#20854#20182'    '#26080#25928
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            Value = 0
          end
          object SpinEdit42: TSpinEdit
            Left = 49
            Top = 145
            Width = 40
            Height = 22
            Hint = 
              #27494#22120'(5,6)         '#20026#25915#20987#36895#24230' '#13#25106#25351'\'#25163#38255'\'#39033#38142'  '#20026#20329#24102#38656#27714#13#22836#30420'\'#26007#31520'         '#20026#20329#24102#32423#21035#13#20854#20182'  '#26080 +
              #25928
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
            Value = 0
          end
          object SpinEdit43: TSpinEdit
            Left = 49
            Top = 189
            Width = 40
            Height = 22
            Hint = #22836#30420','#26007#31520','#25106#25351','#25163#22871','#25163#38255'  '#20026#31070#31192#23646#24615#13#20854#20182#26080#25928' '
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            Value = 0
          end
          object SpinEdit44: TSpinEdit
            Left = 49
            Top = 211
            Width = 40
            Height = 22
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
            Value = 0
          end
          object SpinEdit45: TSpinEdit
            Left = 49
            Top = 233
            Width = 40
            Height = 22
            Hint = #27494#22120'  '#20026#38656#24320#23553#13#20854#20182#26080#25928
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 10
            Value = 0
          end
          object SpinEdit46: TSpinEdit
            Left = 49
            Top = 255
            Width = 40
            Height = 22
            Hint = #20445#30041#23646#24615
            Enabled = False
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 11
            Value = 0
          end
          object SpinEdit47: TSpinEdit
            Left = 49
            Top = 277
            Width = 40
            Height = 22
            Hint = #27494#22120#26080#25928','#20540#20026'1'#26102','#21457#20142
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 12
            Value = 0
          end
          object SpinEdit48: TSpinEdit
            Left = 49
            Top = 299
            Width = 40
            Height = 22
            Hint = #20540#20026'1'#26102','#20026#33258#23450#20041#29289#21697
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 13
            Value = 0
          end
          object SpinEdit35: TSpinEdit
            Left = 96
            Top = 13
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 14
            Value = 0
          end
          object SpinEdit49: TSpinEdit
            Left = 96
            Top = 35
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 15
            Value = 0
          end
          object SpinEdit50: TSpinEdit
            Left = 96
            Top = 57
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 16
            Value = 0
          end
          object SpinEdit51: TSpinEdit
            Left = 96
            Top = 79
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 17
            Value = 0
          end
          object SpinEdit52: TSpinEdit
            Left = 96
            Top = 101
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 18
            Value = 0
          end
          object SpinEdit53: TSpinEdit
            Left = 96
            Top = 123
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 19
            Value = 0
          end
          object SpinEdit54: TSpinEdit
            Left = 96
            Top = 145
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 20
            Value = 0
          end
          object SpinEdit55: TSpinEdit
            Left = 96
            Top = 167
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 21
            Value = 0
          end
          object SpinEdit56: TSpinEdit
            Left = 96
            Top = 189
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 22
            Value = 0
          end
          object SpinEdit57: TSpinEdit
            Left = 96
            Top = 211
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 23
            Value = 0
          end
          object SpinEdit58: TSpinEdit
            Left = 96
            Top = 233
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ReadOnly = True
            ShowHint = True
            TabOrder = 24
            Value = 0
          end
          object SpinEdit59: TSpinEdit
            Left = 96
            Top = 255
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            Enabled = False
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 25
            Value = 0
          end
          object SpinEdit60: TSpinEdit
            Left = 96
            Top = 277
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 26
            Value = 0
          end
          object SpinEdit61: TSpinEdit
            Left = 96
            Top = 299
            Width = 40
            Height = 22
            Hint = 
              #38590#24230#20540','#21363#25353#38590#24230#31995#25968#21028#26029#27492#27425#23646#24615#26159#21542#36798#21040#26368#39640#28857','#13#22914#26524#19981#33021#36798#21040','#21017#23646#24615#20540'='#23646#24615#20540'+1,'#20294#19981#33021#36798#21040#26368#39640#13#20540',('#25968#23383#36234#22823#36234#38590#28140#28860#21040#39640 +
              #28857#23646#24615')'
            MaxValue = 100
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 27
            Value = 0
          end
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #33258#23450#20041#21629#20196
      ImageIndex = 4
      OnShow = TabSheet5Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label79: TLabel
        Left = 246
        Top = 214
        Width = 60
        Height = 13
        Caption = #21629#20196#21517#31216#65306
      end
      object Label81: TLabel
        Left = 246
        Top = 238
        Width = 60
        Height = 13
        Caption = #21629#20196#32534#21495#65306
      end
      object GroupBox6: TGroupBox
        Left = 11
        Top = 8
        Width = 209
        Height = 407
        Caption = #33258#23450#20041#21629#20196#21015#34920
        TabOrder = 0
        object ListBoxUserCommand: TListBox
          Left = 8
          Top = 16
          Width = 193
          Height = 381
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBoxUserCommandClick
        end
      end
      object SpinEditCommandIdx: TSpinEdit
        Left = 310
        Top = 234
        Width = 161
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object EditCommandName: TEdit
        Left = 310
        Top = 210
        Width = 161
        Height = 21
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 2
      end
      object ButtonUserCommandAdd: TButton
        Left = 318
        Top = 262
        Width = 75
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 3
        OnClick = ButtonUserCommandAddClick
      end
      object ButtonUserCommandDel: TButton
        Left = 398
        Top = 262
        Width = 75
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 4
        OnClick = ButtonUserCommandDelClick
      end
      object ButtonUserCommandChg: TButton
        Left = 318
        Top = 294
        Width = 75
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 5
        OnClick = ButtonUserCommandChgClick
      end
      object ButtonLoadUserCommandList: TButton
        Left = 318
        Top = 326
        Width = 153
        Height = 25
        Caption = #37325#26032#21152#36733#33258#23450#20041#21629#20196#21015#34920
        TabOrder = 6
        OnClick = ButtonLoadUserCommandListClick
      end
      object ButtonUserCommandSave: TButton
        Left = 398
        Top = 294
        Width = 75
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 7
        OnClick = ButtonUserCommandSaveClick
      end
    end
    object TabSheet6: TTabSheet
      Caption = #29289#21697#35268#21017
      ImageIndex = 5
      OnShow = TabSheet6Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label92: TLabel
        Left = 8
        Top = 399
        Width = 432
        Height = 12
        Caption = #35843#25972#30340#21442#25968#31435#21363#29983#25928#65292#22312#32447#26102#35831#30830#35748#27492#21442#25968#30340#20316#29992#20877#35843#25972#65292#20081#35843#25972#23558#23548#33268#28216#25103#28151#20081
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 8
        Width = 193
        Height = 386
        Caption = #31105#27490#29289#21697#21015#34920
        TabOrder = 0
        object ListBoxDisallow: TListBox
          Left = 13
          Top = 13
          Width = 177
          Height = 362
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBoxDisallowClick
        end
      end
      object GroupBox21: TGroupBox
        Left = 394
        Top = 8
        Width = 193
        Height = 386
        Caption = #29289#21697#21015#34920'(CTRL+F'#26597#25214')'
        TabOrder = 1
        object ListBoxitemList: TListBox
          Left = 8
          Top = 16
          Width = 177
          Height = 363
          Hint = 'Ctrl+F '#26597#25214
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ListBoxitemListClick
          OnKeyDown = ListBoxitemListKeyDown
        end
      end
      object GroupBox8: TGroupBox
        Left = 208
        Top = 8
        Width = 179
        Height = 386
        Caption = #35268#21017#35774#32622
        TabOrder = 2
        object Label89: TLabel
          Left = 8
          Top = 24
          Width = 52
          Height = 13
          Caption = #29289#21697#21517#31216':'
        end
        object Label88: TLabel
          Left = 6
          Top = 266
          Width = 76
          Height = 13
          Caption = #38480#26102#32465#23450#26102#38271':'
        end
        object EditItemName: TEdit
          Left = 64
          Top = 20
          Width = 106
          Height = 21
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
        end
        object GroupBox9: TGroupBox
          Left = 7
          Top = 50
          Width = 165
          Height = 206
          Caption = #32534#36753#29289#21697#23646#24615
          TabOrder = 1
          object BtnDisallowSelAll: TButton
            Left = 5
            Top = 174
            Width = 75
            Height = 23
            Caption = #20840#37096#36873#20013
            TabOrder = 0
            OnClick = BtnDisallowSelAllClick
          end
          object BtnDisallowCancelAll: TButton
            Left = 85
            Top = 174
            Width = 75
            Height = 23
            Caption = #20840#37096#21462#28040
            TabOrder = 1
            OnClick = BtnDisallowCancelAllClick
          end
          object CheckBoxDisallowDrop: TCheckBox
            Left = 4
            Top = 18
            Width = 65
            Height = 17
            Caption = #31105#27490#20002#24323
            TabOrder = 2
          end
          object CheckBoxDisallowDeal: TCheckBox
            Left = 88
            Top = 18
            Width = 65
            Height = 17
            Caption = #31105#27490#20132#26131
            TabOrder = 3
          end
          object CheckBoxDisallowStorage: TCheckBox
            Left = 4
            Top = 33
            Width = 65
            Height = 17
            Caption = #31105#27490#23384#20179
            TabOrder = 4
          end
          object CheckBoxDisallowRepair: TCheckBox
            Left = 88
            Top = 33
            Width = 65
            Height = 17
            Caption = #31105#27490#20462#29702
            TabOrder = 5
          end
          object CheckBoxDisallowDropHint: TCheckBox
            Left = 4
            Top = 48
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25481#33853#22312#22320#19978#26102#21521#20840#26381#21457#24067#22320#22270#19982#22352#26631#25552#31034#12290
            Caption = #25481#33853#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
          end
          object CheckBoxDisallowOpenBoxsHint: TCheckBox
            Left = 88
            Top = 48
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#29289#21697#25171#24320#23453#31665#33719#24471#26102#21521#20840#26381#21457#36865#25552#31034#12290
            Caption = #23453#31665#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 7
          end
          object CheckBoxDisallowNoDropItem: TCheckBox
            Left = 4
            Top = 63
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#35813#29289#21697#27515#20129#19981#25481#33853#12290
            Caption = #27704#19981#29190#20986
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            OnClick = CheckBoxDisallowNoDropItemClick
          end
          object CheckBoxDisallowButchHint: TCheckBox
            Left = 88
            Top = 63
            Width = 65
            Height = 17
            Hint = #36873#20013#35813#39033#65292#20174#24618#29289#25110#20154#22411#24618#36523#19978#25366#21040#35813#29289#21697#26102#36827#34892#20840#26381#25552#31034#12290
            Caption = #25366#21462#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
            OnClick = CheckBoxDisallowButchHintClick
          end
          object CheckBoxDisallowHeroUse: TCheckBox
            Left = 4
            Top = 78
            Width = 68
            Height = 17
            Hint = #36873#20013#35813#39033#65292#33521#38596#19981#21487#20197#31359#25140#35813#29289#21697#12290#13#10#20027#20307#19981#33021#25226#29289#21697#25918#21040#33521#38596#21253#35065#20013#12290
            Caption = #31105#27490#33521#38596
            ParentShowHint = False
            ShowHint = True
            TabOrder = 10
          end
          object CheckBoxDisallowPickUpItem: TCheckBox
            Left = 88
            Top = 78
            Width = 65
            Height = 17
            Caption = #31105#27490#25441#36215
            TabOrder = 11
          end
          object CheckBoxDieDropItems: TCheckBox
            Left = 4
            Top = 93
            Width = 65
            Height = 17
            Caption = #27515#20129#24517#26292
            TabOrder = 12
            OnClick = CheckBoxDieDropItemsClick
          end
          object CheckBoxBuyShopItemGive: TCheckBox
            Left = 88
            Top = 93
            Width = 65
            Height = 17
            Hint = #31105#27490#29289#21697#21830#38138#36192#36865
            Caption = #31105#27490#36192#36865
            ParentShowHint = False
            ShowHint = True
            TabOrder = 13
          end
          object CheckBoxButchItem: TCheckBox
            Left = 4
            Top = 108
            Width = 65
            Height = 17
            Caption = #31105#27490#25366#21462
            TabOrder = 14
            OnClick = CheckBoxButchItemClick
          end
          object CheckBoxRefineItem: TCheckBox
            Left = 88
            Top = 108
            Width = 65
            Height = 17
            Hint = #31929#32451#25104#21151#20840#26381#25552#31034
            Caption = #28140#32451#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 15
          end
          object CheckBoxNpcGiveItem: TCheckBox
            Left = 4
            Top = 123
            Width = 65
            Height = 17
            Hint = #38548#19968#23450#26102#38388#25165#33021#25441#36215#29289#21697
            Caption = #38548#26102#25441#36215
            ParentShowHint = False
            ShowHint = True
            TabOrder = 16
          end
          object CheckBoxDigJewelHint: TCheckBox
            Left = 88
            Top = 123
            Width = 65
            Height = 17
            Hint = #25366#23453#25104#21151#20840#26381#25552#31034
            Caption = #25366#23453#25552#31034
            ParentShowHint = False
            ShowHint = True
            TabOrder = 17
          end
          object CheckBox24HourDisap: TCheckBox
            Left = 4
            Top = 138
            Width = 65
            Height = 17
            Hint = '24'#26102#29289#21697#28040#22833','#21363#24403#22825#26377#25928#29289#21697';'#35774#32622#21518#19981#33021#35774#32622'"'#27704#20037#32465#23450'"'#12289#8220#32465#23450'48'#26102#8221
            Caption = '24'#26102#28040#22833
            ParentShowHint = False
            ShowHint = True
            TabOrder = 18
            OnClick = CheckBox24HourDisapClick
          end
          object CheckBoxPermanentBind: TCheckBox
            Left = 88
            Top = 138
            Width = 65
            Height = 17
            Hint = #29190#20986#21518#19981#21487#25441#36215#65307#36873#20013#35813#39033','#21017#19981#33021#35774#32622#8220'24'#26102#28040#22833#8221#12289#8220#32465#23450'48'#26102#8221#12290
            Caption = #27704#20037#32465#23450
            ParentShowHint = False
            ShowHint = True
            TabOrder = 19
            OnClick = CheckBoxPermanentBindClick
          end
          object CheckBox48HourUnBind: TCheckBox
            Left = 4
            Top = 154
            Width = 75
            Height = 17
            Hint = #33719#24471#29289#21697'('#25441#36215','#20132#26131#31561'),'#38480#26102#32465#23450'; '#32465#23450#26399#29190#20986#19981#33021#25441';'#13#10#35774#32622#21518#19981#33021#35774#32622'"'#27704#20037#32465#23450'"'#12289'"24'#26102#28040#22833'"'
            Caption = #38480#26102#32465#23450
            ParentShowHint = False
            ShowHint = True
            TabOrder = 20
            OnClick = CheckBox48HourUnBindClick
          end
          object CheckBox12: TCheckBox
            Left = 88
            Top = 154
            Width = 65
            Height = 17
            Caption = #39044#30041#20301#32622
            Enabled = False
            TabOrder = 21
          end
        end
        object BtnDisallowAdd: TButton
          Left = 8
          Top = 292
          Width = 78
          Height = 23
          Caption = #22686#21152'(&A)'
          TabOrder = 2
          OnClick = BtnDisallowAddClick
        end
        object BtnDisallowDel: TButton
          Left = 93
          Top = 292
          Width = 78
          Height = 23
          Caption = #21024#38500'(&D)'
          TabOrder = 3
          OnClick = BtnDisallowDelClick
        end
        object BtnDisallowAddAll: TButton
          Left = 8
          Top = 322
          Width = 78
          Height = 23
          Caption = #20840#37096#22686#21152'(&A)'
          TabOrder = 4
          OnClick = BtnDisallowAddAllClick
        end
        object BtnDisallowDelAll: TButton
          Left = 93
          Top = 322
          Width = 78
          Height = 23
          Caption = #20840#37096#21024#38500'(&D)'
          TabOrder = 5
          OnClick = BtnDisallowDelAllClick
        end
        object BtnDisallowChg: TButton
          Left = 8
          Top = 353
          Width = 78
          Height = 23
          Caption = #20462#25913'(&C)'
          TabOrder = 6
          OnClick = BtnDisallowChgClick
        end
        object BtnDisallowSave: TButton
          Left = 92
          Top = 353
          Width = 78
          Height = 23
          Caption = #20445#23384'(&S)'
          TabOrder = 7
          OnClick = BtnDisallowSaveClick
        end
        object SpinEditLimitItemTime: TSpinEdit
          Left = 87
          Top = 262
          Width = 41
          Height = 22
          Hint = #38480#26102#32465#23450#26102#38271#35774#23450#12290#38024#23545#29289#21697#35268#21017'"'#38480#26102#32465#23450'",'#19968#20462#25913#21363#29983#25928
          EditorEnabled = False
          MaxValue = 255
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          Value = 1
          OnChange = SpinEditLimitItemTimeChange
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #28040#24687#36807#28388
      ImageIndex = 6
      OnShow = TabSheet7Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox22: TGroupBox
        Left = 8
        Top = 8
        Width = 697
        Height = 252
        Caption = #28040#24687#36807#28388#21015#34920
        TabOrder = 0
        object ListViewMsgFilter: TListView
          Left = 8
          Top = 16
          Width = 681
          Height = 226
          Columns = <
            item
              Caption = #36807#28388#28040#24687
              Width = 200
            end
            item
              Caption = #26367#25442#28040#24687
              Width = 200
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewMsgFilterClick
        end
      end
      object GroupBox23: TGroupBox
        Left = 8
        Top = 264
        Width = 697
        Height = 81
        Caption = #28040#24687#36807#28388#21015#34920#32534#36753
        TabOrder = 1
        object Label93: TLabel
          Left = 8
          Top = 24
          Width = 60
          Height = 13
          Caption = #36807#28388#28040#24687#65306
        end
        object Label94: TLabel
          Left = 8
          Top = 48
          Width = 60
          Height = 13
          Caption = #26367#25442#28040#24687#65306
        end
        object EditFilterMsg: TEdit
          Left = 72
          Top = 20
          Width = 609
          Height = 21
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
        end
        object EditNewMsg: TEdit
          Left = 72
          Top = 44
          Width = 609
          Height = 21
          Hint = #26367#25442#28040#24687#20026#31354#26102#65292#20002#25481#25972#21477#12290
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object ButtonMsgFilterAdd: TButton
        Left = 104
        Top = 355
        Width = 68
        Height = 25
        Caption = #22686#21152'(&A)'
        TabOrder = 2
        OnClick = ButtonMsgFilterAddClick
      end
      object ButtonMsgFilterDel: TButton
        Left = 178
        Top = 355
        Width = 68
        Height = 25
        Caption = #21024#38500'(&D)'
        TabOrder = 3
        OnClick = ButtonMsgFilterDelClick
      end
      object ButtonMsgFilterChg: TButton
        Left = 252
        Top = 355
        Width = 68
        Height = 25
        Caption = #20462#25913'(&C)'
        TabOrder = 4
        OnClick = ButtonMsgFilterChgClick
      end
      object ButtonMsgFilterSave: TButton
        Left = 326
        Top = 355
        Width = 68
        Height = 25
        Caption = #20445#23384'(&S)'
        TabOrder = 5
        OnClick = ButtonMsgFilterSaveClick
      end
      object ButtonLoadMsgFilterList: TButton
        Left = 400
        Top = 355
        Width = 145
        Height = 25
        Caption = #37325#26032#21152#36733#28040#24687#36807#28388#21015#34920
        TabOrder = 6
        OnClick = ButtonLoadMsgFilterListClick
      end
    end
    object TabSheet8: TTabSheet
      Caption = #21830#38138#35774#32622
      ImageIndex = 7
      OnShow = TabSheet8Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label103: TLabel
        Left = 1
        Top = 386
        Width = 702
        Height = 36
        Caption = 
          #27880#24847#65306'['#21160#30011#35774#32622'] '#26159#26576#29992#25143#28857#20987#21830#38138#29289#21697' '#22312#21830#38138#30028#38754#24038#19978#35282#26174#31034#30340#21160#30011#65307'['#19981#26174#31034#21160#30011'] '#35831#22312' '#8220#22270#29255#24320#22987#8221' '#22788#28155'380,'#8220#22270#29255#32467#26463 +
          #8221#13#22788#28155'0  '#20999#35760#65307'['#26174#31034#21160#30011'] '#22270#29255#24320#22987#22788#35831#28155' '#21160#30011#26174#31034#30340#31532'1'#24352#22270#25968'   '#22270#29255#32467#26463#22788#28155' '#26174#31034#23436#21160#30011#30340#37027#24352#22270#30340#25968#65307#27880#24847#65306' '#21160#30011#26174 +
          #31034#30340#22270#13#29255#22312#23458#25143#31471#30340' '#8220'Effect.wil'#8221' '#37324#12290#25805#20316#8220#22686#21152#12289#20462#25913#12289#21024#38500#8221#21518#65292#35201#28857#20987#8220#20445#23384#8221#65292#25165#33021#20445#23384#25968#25454#12290
        Color = clBtnFace
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object GroupBox10: TGroupBox
        Left = 0
        Top = -1
        Width = 587
        Height = 247
        Caption = #21830#21697#21015#34920
        TabOrder = 0
        object ListViewItemList: TListView
          Left = 3
          Top = 14
          Width = 581
          Height = 229
          Columns = <
            item
              Caption = #21830#21697#21517#31216
              Width = 85
            end
            item
              Caption = #31867#22411
              Width = 36
            end
            item
              Caption = #21830#21697#20215#26684
              Width = 60
            end
            item
              Caption = #22270#29255#24320#22987
              Width = 60
            end
            item
              Caption = #22270#29255#32467#26463
              Width = 60
            end
            item
              Caption = #25968#37327
              Width = 36
            end
            item
              Caption = #31616#21333#20171#32461
              Width = 90
            end
            item
              Caption = #21830#21697#25551#36848
              Width = 160
            end>
          GridLines = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnClick = ListViewItemListClick
        end
      end
      object GroupBox11: TGroupBox
        Left = 587
        Top = -1
        Width = 129
        Height = 385
        Caption = #29289#21697#21015#34920'(CTRL+F'#26597#25214')'
        TabOrder = 1
        object ListBoxItemListShop: TListBox
          Left = 3
          Top = 15
          Width = 123
          Height = 365
          Hint = 'Ctrl+F '#26597#25214
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ListBoxItemListShopClick
          OnKeyDown = ListBoxItemListShopKeyDown
        end
      end
      object Panel1: TPanel
        Left = 3
        Top = 246
        Width = 585
        Height = 137
        ParentBackground = False
        TabOrder = 2
        object Label99: TLabel
          Left = 159
          Top = 29
          Width = 60
          Height = 13
          Caption = #21830#21697#31867#21035#65306
        end
        object Label98: TLabel
          Left = 294
          Top = 5
          Width = 60
          Height = 13
          Caption = #21830#21697#20171#32461#65306
        end
        object Label97: TLabel
          Left = 6
          Top = 29
          Width = 60
          Height = 13
          Caption = #21830#21697#20215#26684#65306
        end
        object Label96: TLabel
          Left = 294
          Top = 26
          Width = 60
          Height = 13
          Caption = #21830#21697#25551#36848#65306
        end
        object Label95: TLabel
          Left = 6
          Top = 6
          Width = 60
          Height = 13
          Caption = #21830#21697#21517#31216#65306
        end
        object Label100: TLabel
          Left = 456
          Top = 88
          Width = 90
          Height = 13
          Caption = #20803#23453#20817#25442'1'#20010#28789#31526
        end
        object Label25: TLabel
          Left = 210
          Top = 5
          Width = 28
          Height = 13
          Caption = #25968#37327':'
        end
        object SpinEditPrice: TSpinEdit
          Left = 66
          Top = 25
          Width = 92
          Height = 22
          MaxValue = 21470000
          MinValue = 0
          TabOrder = 0
          Value = 100
        end
        object SpinEditGameGird: TSpinEdit
          Left = 379
          Top = 84
          Width = 71
          Height = 22
          MaxValue = 21470000
          MinValue = 0
          TabOrder = 1
          Value = 1
          OnChange = SpinEditGameGirdChange
        end
        object ShopTypeBoBox: TComboBox
          Left = 217
          Top = 24
          Width = 71
          Height = 21
          Style = csDropDownList
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 0
          ItemIndex = 0
          TabOrder = 2
          Text = '0--'#35013#39280
          Items.Strings = (
            '0--'#35013#39280
            '1--'#34917#32473
            '2--'#24378#21270
            '3--'#22909#21451
            '4--'#38480#37327
            '5--'#22855#29645)
        end
        object Memo1: TMemo
          Left = 353
          Top = 24
          Width = 228
          Height = 58
          Hint = #25551#36848#20013#38388#30340#65073#20195#34920#25442#34892
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ParentShowHint = False
          ScrollBars = ssVertical
          ShowHint = True
          TabOrder = 3
        end
        object GroupBox12: TGroupBox
          Left = 4
          Top = 45
          Width = 283
          Height = 33
          Caption = #21160#30011#35774#32622
          Color = clBtnFace
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 4
          object Label101: TLabel
            Left = 8
            Top = 15
            Width = 60
            Height = 12
            Caption = #22270#29255#24320#22987#65306
          end
          object Label102: TLabel
            Left = 133
            Top = 14
            Width = 60
            Height = 12
            Caption = #22270#29255#32467#26463#65306
          end
          object EditShopImgBegin: TEdit
            Left = 66
            Top = 10
            Width = 63
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 0
            Text = '380'
          end
          object EditShopImgEnd: TEdit
            Left = 200
            Top = 10
            Width = 73
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
            TabOrder = 1
            Text = '0'
          end
        end
        object EditShopItemName: TEdit
          Left = 65
          Top = 2
          Width = 143
          Height = 21
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ReadOnly = True
          TabOrder = 5
        end
        object EditShopItemIntroduce: TEdit
          Left = 352
          Top = 2
          Width = 228
          Height = 21
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 6
        end
        object CheckBoxBuyGameGird: TCheckBox
          Left = 289
          Top = 86
          Width = 91
          Height = 17
          Caption = #24320#21551#20817#25442#28789#31526
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = CheckBoxBuyGameGirdClick
        end
        object ButtonSaveShopItemList: TButton
          Left = 220
          Top = 78
          Width = 65
          Height = 20
          Caption = #20445#23384'(&S)'
          TabOrder = 8
          OnClick = ButtonSaveShopItemListClick
        end
        object ButtonLoadShopItemList: TButton
          Left = 4
          Top = 101
          Width = 281
          Height = 18
          Caption = #37325#26032#21152#36733#21830#21697#21015#34920'(&R)'
          TabOrder = 9
          OnClick = ButtonLoadShopItemListClick
        end
        object ButtonDelShopItem: TButton
          Left = 4
          Top = 78
          Width = 65
          Height = 20
          Caption = #21024#38500'(&D)'
          TabOrder = 10
          OnClick = ButtonDelShopItemClick
        end
        object ButtonChgShopItem: TButton
          Left = 76
          Top = 78
          Width = 65
          Height = 20
          Caption = #20462#25913'(&C)'
          TabOrder = 11
          OnClick = ButtonChgShopItemClick
        end
        object ButtonAddShopItem: TButton
          Left = 148
          Top = 78
          Width = 65
          Height = 20
          Caption = #22686#21152'(&A)'
          TabOrder = 12
          OnClick = ButtonAddShopItemClick
        end
        object SpinEditShopItemCount: TSpinEdit
          Left = 237
          Top = 2
          Width = 51
          Height = 22
          Hint = #19968#27425#36141#20080#21487#20197#33719#24471#30340#29289#21697#25968#37327','#26368#22823'46'
          MaxValue = 46
          MinValue = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          Value = 1
        end
        object CheckBoxCanShop: TCheckBox
          Left = 486
          Top = 117
          Width = 92
          Height = 17
          Hint = #21830#38138#21151#33021#24320#21551
          Caption = #24320#21551#21830#38138#21151#33021
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 14
          Visible = False
          OnClick = CheckBoxCanShopClick
        end
        object RadioButtonShopGameGold: TRadioButton
          Left = 508
          Top = 91
          Width = 73
          Height = 17
          Caption = #20803#23453#20986#21806
          Checked = True
          TabOrder = 15
          TabStop = True
          Visible = False
          OnClick = RadioButtonShopGameGoldClick
        end
        object RadioButtonShopUseGold: TRadioButton
          Left = 508
          Top = 107
          Width = 73
          Height = 17
          Caption = #37329#24065#20986#21806
          TabOrder = 16
          Visible = False
          OnClick = RadioButtonShopUseGoldClick
        end
        object CheckBoxboShopGamePoint: TCheckBox
          Left = 291
          Top = 111
          Width = 127
          Height = 17
          Caption = #24320#21551#28216#25103#28857#36141#20080#21151#33021
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          OnClick = CheckBoxboShopGamePointClick
        end
        object CheckBoxCanBuyShopItemGive: TCheckBox
          Left = 424
          Top = 111
          Width = 65
          Height = 17
          Caption = #24320#21551#36192#36865
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 18
          OnClick = CheckBoxCanBuyShopItemGiveClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #29289#21697#29305#25928
      ImageIndex = 7
      OnShow = TabSheet4Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox13: TGroupBox
        Left = 6
        Top = 3
        Width = 193
        Height = 415
        Caption = #29289#21697#21015#34920'(CTRL+F'#26597#25214')'
        TabOrder = 0
        object ItemEffectList: TListBox
          Left = 8
          Top = 16
          Width = 177
          Height = 392
          Hint = 'Ctrl+F '#26597#25214
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 13
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ItemEffectListClick
          OnKeyDown = ItemEffectListKeyDown
        end
      end
      object GroupBox14: TGroupBox
        Left = 205
        Top = 3
        Width = 193
        Height = 415
        Caption = #29305#25928#29289#21697#21015#34920
        TabOrder = 1
        object EffecItemtList: TListBox
          Left = 7
          Top = 13
          Width = 177
          Height = 396
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ItemHeight = 13
          TabOrder = 0
          OnClick = EffecItemtListClick
        end
      end
      object GroupBox15: TGroupBox
        Left = 404
        Top = 3
        Width = 309
        Height = 415
        Caption = #29305#25928#35774#32622
        TabOrder = 2
        object Label90: TLabel
          Left = 20
          Top = 24
          Width = 52
          Height = 13
          Caption = #29289#21697#21517#31216':'
        end
        object Button16: TButton
          Left = 32
          Top = 348
          Width = 78
          Height = 23
          Caption = #22686#21152'(&A)'
          TabOrder = 0
          OnClick = Button16Click
        end
        object Button17: TButton
          Left = 32
          Top = 377
          Width = 78
          Height = 23
          Caption = #21024#38500'(&D)'
          TabOrder = 1
          OnClick = Button17Click
        end
        object Button18: TButton
          Left = 116
          Top = 348
          Width = 78
          Height = 23
          Caption = #20462#25913'(&C)'
          TabOrder = 2
          OnClick = Button18Click
        end
        object Edit7: TEdit
          Left = 76
          Top = 20
          Width = 106
          Height = 21
          Enabled = False
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 3
        end
        object GroupBox16: TGroupBox
          Left = 15
          Top = 134
          Width = 289
          Height = 87
          Caption = #20869#35266#29305#25928
          TabOrder = 4
          object Label91: TLabel
            Left = 8
            Top = 19
            Width = 52
            Height = 13
            Caption = #24320#22987#22270#29255':'
          end
          object Label104: TLabel
            Left = 8
            Top = 42
            Width = 52
            Height = 13
            Caption = #25773#25918#25968#37327':'
          end
          object Label105: TLabel
            Left = 8
            Top = 66
            Width = 52
            Height = 13
            Caption = #36164#28304#25991#20214':'
          end
          object Label106: TLabel
            Left = 173
            Top = 19
            Width = 34
            Height = 13
            Caption = 'X'#22352#26631':'
          end
          object Label107: TLabel
            Left = 173
            Top = 41
            Width = 34
            Height = 13
            Caption = 'Y'#22352#26631':'
          end
          object SpinEdit68: TSpinEdit
            Left = 66
            Top = 15
            Width = 95
            Height = 22
            MaxValue = 65535
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Value = 0
            OnChange = SpinEditLimitItemTimeChange
          end
          object SpinEdit69: TSpinEdit
            Left = 66
            Top = 38
            Width = 95
            Height = 22
            Hint = #35774#32622#20540#20026'0'#26102#65292#21017#20026#20851#38381#29305#25928
            MaxValue = 255
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Value = 0
            OnChange = SpinEditLimitItemTimeChange
          end
          object ComboBox1: TComboBox
            Left = 66
            Top = 61
            Width = 143
            Height = 21
            ItemHeight = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Items.Strings = (
              'Prguse.wil'
              'Prguse2.wil'
              'Prguse3.wil'
              'ui1.wil'
              'Effect.wil'
              'StateEffect.wil'
              'HumEffect.wil'
              'HumEffect2.wil'
              'stateitem.wil'
              'stateitem2.wil')
          end
          object SpinEdit70: TSpinEdit
            Left = 207
            Top = 14
            Width = 47
            Height = 22
            Hint = 'X'#22352#26631#20462#27491'(-128..127)'
            MaxValue = 127
            MinValue = -128
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Value = 0
            OnChange = SpinEditLimitItemTimeChange
          end
          object SpinEdit71: TSpinEdit
            Left = 207
            Top = 37
            Width = 47
            Height = 22
            Hint = 'Y'#22352#26631#20462#27491'(-128..127)'
            MaxValue = 127
            MinValue = -128
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Value = 0
            OnChange = SpinEditLimitItemTimeChange
          end
        end
        object GroupBox17: TGroupBox
          Left = 15
          Top = 224
          Width = 291
          Height = 90
          Caption = #22806#35266#29305#25928
          TabOrder = 5
          object Label108: TLabel
            Left = 8
            Top = 19
            Width = 52
            Height = 13
            Caption = #24320#22987#22270#29255':'
          end
          object Label110: TLabel
            Left = 8
            Top = 43
            Width = 52
            Height = 13
            Caption = #36164#28304#25991#20214':'
          end
          object Label118: TLabel
            Left = 3
            Top = 66
            Width = 286
            Height = 13
            Caption = #21482#25903#25345#34915#26381#21644#27494#22120'("'#24320#22987#22270#29255'"'#20026'65535'#26102#34920#31034#29305#25928#20851#38381')'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
          end
          object SpinEdit72: TSpinEdit
            Left = 66
            Top = 15
            Width = 95
            Height = 22
            MaxValue = 65535
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Value = 65535
            OnChange = SpinEditLimitItemTimeChange
          end
          object ComboBox2: TComboBox
            Left = 66
            Top = 38
            Width = 143
            Height = 21
            ItemHeight = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Items.Strings = (
              'HumEffect.wil'
              'HumEffect2.wil'
              'WeaponEffect.wil'
              'HumEffect3.wil'
              'HumEffect4.wil'
              'WeaponEffect4.wil')
          end
        end
        object GroupBox18: TGroupBox
          Left = 15
          Top = 45
          Width = 289
          Height = 87
          Caption = #21253#35065#29305#25928
          TabOrder = 6
          object Label113: TLabel
            Left = 8
            Top = 19
            Width = 52
            Height = 13
            Caption = #24320#22987#22270#29255':'
          end
          object Label114: TLabel
            Left = 8
            Top = 42
            Width = 52
            Height = 13
            Caption = #25773#25918#25968#37327':'
          end
          object Label115: TLabel
            Left = 8
            Top = 66
            Width = 52
            Height = 13
            Caption = #36164#28304#25991#20214':'
          end
          object Label116: TLabel
            Left = 173
            Top = 19
            Width = 34
            Height = 13
            Caption = 'X'#22352#26631':'
          end
          object Label117: TLabel
            Left = 173
            Top = 41
            Width = 34
            Height = 13
            Caption = 'Y'#22352#26631':'
          end
          object SpinEdit76: TSpinEdit
            Left = 66
            Top = 15
            Width = 95
            Height = 22
            MaxValue = 65535
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            Value = 0
            OnChange = SpinEditLimitItemTimeChange
          end
          object SpinEdit77: TSpinEdit
            Left = 66
            Top = 38
            Width = 95
            Height = 22
            Hint = #35774#32622#20540#20026'0'#26102#65292#21017#20026#20851#38381#29305#25928
            MaxValue = 255
            MinValue = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Value = 0
            OnChange = SpinEditLimitItemTimeChange
          end
          object ComboBox3: TComboBox
            Left = 66
            Top = 61
            Width = 143
            Height = 21
            ItemHeight = 0
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Items.Strings = (
              'Prguse.wil'
              'Prguse2.wil'
              'Prguse3.wil'
              'ui1.wil'
              'Effect.wil'
              'StateEffect.wil'
              'HumEffect.wil'
              'HumEffect2.wil'
              'stateitem.wil'
              'stateitem2.wil')
          end
          object SpinEdit78: TSpinEdit
            Left = 207
            Top = 14
            Width = 47
            Height = 22
            Hint = 'X'#22352#26631#20462#27491'(-128..127)'
            MaxValue = 127
            MinValue = -128
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            Value = 0
            OnChange = SpinEditLimitItemTimeChange
          end
          object SpinEdit79: TSpinEdit
            Left = 207
            Top = 37
            Width = 47
            Height = 22
            Hint = 'Y'#22352#26631#20462#27491'(-128..127)'
            MaxValue = 127
            MinValue = -128
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            Value = 0
            OnChange = SpinEditLimitItemTimeChange
          end
        end
        object Button19: TButton
          Left = 116
          Top = 377
          Width = 78
          Height = 23
          Caption = #20445#23384'(&S)'
          TabOrder = 7
          OnClick = Button19Click
        end
      end
    end
  end
end
