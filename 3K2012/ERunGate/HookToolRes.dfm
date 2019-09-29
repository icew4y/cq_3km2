object FrmHookCheck: TFrmHookCheck
  Left = 296
  Top = 261
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #36895#24230#25511#21046
  ClientHeight = 265
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label13: TLabel
    Left = 13
    Top = 245
    Width = 192
    Height = 12
    Caption = #27880#24847#65306#20197#19978#21442#25968#35843#33410#21518#23558#31435#21363#29983#25928#65281
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 6
    Width = 603
    Height = 230
    TabOrder = 0
    object Label4: TLabel
      Left = 437
      Top = 114
      Width = 162
      Height = 108
      Caption = 
        #35302#21457#22788#29702':'#21152#36895#32047#35745#36798#21040'50'#27425#65292#13#10'  '#25191#34892'QFunction-0.txt'#30340#13#10'  [@Punishment]'#33050#26412#13#10#25481#32447#22788#29702':'#21152 +
        #36895#32047#35745#36798#21040'50'#27425#65292#13#10'  '#36386#20986#29609#23478#13#10#20572#39039#22788#29702':'#21152#36895#32047#35745#36798#21040'10'#27425#65292#13#10'  '#35753#29609#23478#20572#39039#19968#20250#13#10#33647#21697#65292#25441#29289#19981#25191#34892#20197#19978#22788#29702#65292#13#10'  ' +
        #21482#36827#34892#20002#21253
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label10: TLabel
      Left = 439
      Top = 97
      Width = 102
      Height = 12
      Caption = #27491#24120#21160#20316#30340#20943#23569#20540':'
    end
    object Label9: TLabel
      Left = 439
      Top = 74
      Width = 102
      Height = 12
      Caption = #27599#27425#21152#36895#30340#32047#21152#20540':'
    end
    object Label21: TLabel
      Left = 227
      Top = 20
      Width = 114
      Height = 12
      Caption = #35013#22791#21152#36895#24230#36739#27491#22240#25968':'
    end
    object Label19: TLabel
      Left = 227
      Top = 44
      Width = 114
      Height = 12
      Caption = #23545#21152#36895#23553#21253#22788#29702#26041#24335':'
    end
    object LabeltWarningMsgFColor: TLabel
      Left = 261
      Top = 176
      Width = 9
      Height = 17
      AutoSize = False
      Color = clBackground
      ParentColor = False
    end
    object Label109: TLabel
      Left = 272
      Top = 178
      Width = 30
      Height = 12
      Caption = #32972#26223':'
    end
    object LabelWarningMsgBColor: TLabel
      Left = 349
      Top = 176
      Width = 9
      Height = 17
      AutoSize = False
      Color = clBackground
      ParentColor = False
    end
    object Label108: TLabel
      Left = 182
      Top = 178
      Width = 30
      Height = 12
      Caption = #25991#23383':'
    end
    object CheckBoxWalk: TCheckBox
      Left = 16
      Top = 44
      Width = 201
      Height = 20
      Caption = #36208#36335#25511#21046#26102#38388#38388#38548':         '#27627#31186
      Enabled = False
      TabOrder = 0
      OnClick = CheckBoxWalkClick
    end
    object CheckBoxRun: TCheckBox
      Left = 16
      Top = 67
      Width = 201
      Height = 17
      Caption = #36305#27493#25511#21046#26102#38388#38388#38548':         '#27627#31186
      Enabled = False
      TabOrder = 1
      OnClick = CheckBoxRunClick
    end
    object CheckBoxHit: TCheckBox
      Left = 16
      Top = 20
      Width = 201
      Height = 20
      Caption = #25915#20987#25511#21046#26102#38388#38388#38548':         '#27627#31186
      Enabled = False
      TabOrder = 2
      OnClick = CheckBoxHitClick
    end
    object CheckBoxSpell: TCheckBox
      Left = 16
      Top = 131
      Width = 201
      Height = 17
      Caption = #39764#27861#36895#24230#38388#38548#26102#38388#25511#21046'('#35774#32622#21015#34920')'
      Enabled = False
      TabOrder = 3
      OnClick = CheckBoxSpellClick
    end
    object EditErrMsg: TEdit
      Left = 16
      Top = 196
      Width = 416
      Height = 20
      Color = clRed
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      MaxLength = 255
      ParentFont = False
      TabOrder = 4
      Text = '['#25552#31034']: '#35831#29233#25252#28216#25103#29615#22659#65292#20851#38381#21152#36895#22806#25346#37325#26032#30331#38470
      OnChange = EditErrMsgChange
    end
    object CheckBoxWarning: TCheckBox
      Left = 17
      Top = 176
      Width = 96
      Height = 15
      Caption = #24320#21551#21152#36895#25552#31034
      TabOrder = 5
      OnClick = CheckBoxWarningClick
    end
    object ComBoxSpeedHackWarningType: TComboBox
      Left = 106
      Top = 174
      Width = 72
      Height = 20
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 12
      ItemIndex = 0
      TabOrder = 6
      Text = #23494#20154#25552#31034
      OnChange = ComBoxSpeedHackWarningTypeChange
      Items.Strings = (
        #23494#20154#25552#31034
        #24377#31383#25552#31034)
    end
    object SpinEditWalk: TSpinEdit
      Left = 135
      Top = 40
      Width = 49
      Height = 21
      Hint = #27492#20540#24212#19982'M2('#21442#25968#35774#32622'->'#28216#25103#36895#24230')'#36208#36335#36895#24230#35774#32622#30456#36817#20284
      EditorEnabled = False
      Enabled = False
      Increment = 10
      MaxValue = 45000
      MinValue = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Value = 600
      OnChange = SpinEditWalkChange
    end
    object SpinEditHit: TSpinEdit
      Left = 135
      Top = 17
      Width = 49
      Height = 21
      Hint = #27492#20540#24212#19982'M2('#21442#25968#35774#32622'->'#28216#25103#36895#24230')'#25915#20987#36895#24230#35774#32622#30456#36817#20284#13#10#38656#32771#34385#24102#21152#36895#29289#21697#21518#30340#25915#20987#36895#24230
      EditorEnabled = False
      Enabled = False
      Increment = 10
      MaxValue = 45000
      MinValue = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Value = 900
      OnChange = SpinEditHitChange
    end
    object SpinEditRun: TSpinEdit
      Left = 135
      Top = 63
      Width = 49
      Height = 21
      Hint = #27492#20540#24212#19982'M2('#21442#25968#35774#32622'->'#28216#25103#36895#24230')'#36305#27493#36895#24230#35774#32622#30456#36817#20284
      Enabled = False
      Increment = 10
      MaxValue = 45000
      MinValue = 10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      Value = 430
      OnChange = SpinEditRunChange
    end
    object SpinEditIncErrorCount: TSpinEdit
      Left = 544
      Top = 69
      Width = 41
      Height = 21
      EditorEnabled = False
      Enabled = False
      MaxValue = 500
      MinValue = 1
      TabOrder = 10
      Value = 5
      OnChange = SpinEditIncErrorCountChange
    end
    object SpinEditDecErrorCount: TSpinEdit
      Left = 544
      Top = 93
      Width = 41
      Height = 21
      EditorEnabled = False
      Enabled = False
      MaxValue = 500
      MinValue = 1
      TabOrder = 11
      Value = 1
      OnChange = SpinEditDecErrorCountChange
    end
    object CheckBoxButch: TCheckBox
      Left = 16
      Top = 88
      Width = 201
      Height = 17
      Caption = #25366#32905#25511#21046#26102#38388#38388#38548':         '#27627#31186
      Enabled = False
      TabOrder = 12
      OnClick = CheckBoxButchClick
    end
    object SpinEditButch: TSpinEdit
      Left = 135
      Top = 86
      Width = 49
      Height = 21
      EditorEnabled = False
      Enabled = False
      Increment = 10
      MaxValue = 45000
      MinValue = 100
      ParentShowHint = False
      ShowHint = False
      TabOrder = 13
      Value = 430
      OnChange = SpinEditButchChange
    end
    object CheckBoxTurn: TCheckBox
      Left = 16
      Top = 109
      Width = 201
      Height = 17
      Caption = #36716#36523#25511#21046#26102#38388#38388#38548':         '#27627#31186
      Enabled = False
      TabOrder = 14
      OnClick = CheckBoxTurnClick
    end
    object SpinEditTurn: TSpinEdit
      Left = 135
      Top = 108
      Width = 49
      Height = 21
      EditorEnabled = False
      Enabled = False
      Increment = 10
      MaxValue = 45000
      MinValue = 100
      ParentShowHint = False
      ShowHint = False
      TabOrder = 15
      Value = 430
      OnChange = SpinEditTurnChange
    end
    object speItemSpeed: TSpinEdit
      Left = 343
      Top = 17
      Width = 74
      Height = 21
      Hint = #29609#23478#21152#36895#24230#35013#22791#22240#25968#65292#25968#20540#36234#23567#65292#23553#21152#36895#36234#20005#21385#65292#40664#35748'60'#12290
      EditorEnabled = False
      MaxValue = 100
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
      Value = 100
      OnChange = speItemSpeedChange
    end
    object CombPunishType: TComboBox
      Left = 343
      Top = 40
      Width = 74
      Height = 20
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 12
      ItemIndex = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      Text = #20572#39039#22788#29702
      OnChange = CombPunishTypeChange
      Items.Strings = (
        #20572#39039#22788#29702
        #35302#21457#22788#29702
        #25481#32447#22788#29702)
    end
    object GroupBox2: TGroupBox
      Left = 225
      Top = 63
      Width = 204
      Height = 109
      Caption = #32452#21512#36895#24230#25511#21046
      TabOrder = 18
      object Label2: TLabel
        Left = 9
        Top = 16
        Width = 132
        Height = 12
        Caption = #31227#21160#21518#20854#20182#21160#20316#26102#38388#38388#38548
        Enabled = False
      end
      object Label5: TLabel
        Left = 9
        Top = 40
        Width = 132
        Height = 12
        Caption = #25915#20987#21518#20854#20182#21160#20316#26102#38388#38388#38548
        Enabled = False
      end
      object Label6: TLabel
        Left = 9
        Top = 64
        Width = 132
        Height = 12
        Caption = #39764#27861#21518#20854#20182#21160#20316#26102#38388#38388#38548
        Enabled = False
      end
      object Label7: TLabel
        Left = 11
        Top = 216
        Width = 132
        Height = 12
        Caption = #27491#24120#31227#21160#30340#24674#22797#35745#26102#38388#38548
        Enabled = False
      end
      object Label8: TLabel
        Left = 11
        Top = 240
        Width = 132
        Height = 12
        Caption = #27491#24120#25915#20987#30340#24674#22797#35745#26102#38388#38548
        Enabled = False
      end
      object Label11: TLabel
        Left = 11
        Top = 264
        Width = 132
        Height = 12
        Caption = #27491#24120#39764#27861#30340#24674#22797#35745#26102#38388#38548
        Enabled = False
      end
      object Label12: TLabel
        Left = 8
        Top = 87
        Width = 132
        Height = 12
        Caption = #21152#36895#29609#23478#30340#24809#32602#26102#38388#22522#25968
        Enabled = False
      end
      object speCOMPENSATE_MAGIC_VALUE: TSpinEdit
        Left = 148
        Top = 260
        Width = 49
        Height = 21
        Hint = #24674#22797#35745#26102#26102#38388#38388#38548#65292#25968#20540#36234#22823#65292#23553#21152#36895#36234#20005#21385#65292#40664#35748'4000'#12290
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 45000
        MinValue = 100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Value = 600
      end
      object speCOMPENSATE_ATTACK_VALUE: TSpinEdit
        Left = 148
        Top = 236
        Width = 49
        Height = 21
        Hint = #24674#22797#35745#26102#26102#38388#38388#38548#65292#25968#20540#36234#22823#65292#23553#21152#36895#36234#20005#21385#65292#40664#35748'4200'#12290
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 45000
        MinValue = 10
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Value = 600
      end
      object speCOMPENSATE_MOVE_VALUE: TSpinEdit
        Left = 148
        Top = 212
        Width = 49
        Height = 21
        Hint = #24674#22797#35745#26102#26102#38388#38388#38548#65292#25968#20540#36234#22823#65292#23553#21152#36895#36234#20005#21385#65292#40664#35748'4000'#12290
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 45000
        MinValue = 10
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Value = 320
      end
      object speMagicInv: TSpinEdit
        Left = 146
        Top = 61
        Width = 49
        Height = 21
        Hint = #39764#27861#21518#23545#31227#21160#65292#25915#20987#31561#20854#20182#21160#20316#30340#34917#20607#26102#38388#65292#25968#20540#36234#23567#65292#23553#21152#36895#36234#20005#21385#65292#40664#35748'200'#12290
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 9999
        MinValue = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Value = 600
      end
      object speAttackInv: TSpinEdit
        Left = 146
        Top = 37
        Width = 49
        Height = 21
        Hint = #25915#20987#21518#23545#31227#21160#65292#39764#27861#31561#20854#20182#21160#20316#30340#34917#20607#26102#38388#65292#25968#20540#36234#23567#65292#23553#21152#36895#36234#20005#21385#65292#40664#35748'200'#12290
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 9999
        MinValue = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        Value = 600
      end
      object speActionCompensate: TSpinEdit
        Left = 146
        Top = 13
        Width = 49
        Height = 21
        Hint = #31227#21160#21518#23545#25915#20987#65292#39764#27861#31561#20854#20182#21160#20316#30340#34917#20607#26102#38388#65292#25968#20540#36234#23567#65292#23553#21152#36895#36234#20005#21385#65292#40664#35748'280'#12290
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 9999
        MinValue = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        Value = 320
      end
      object spePunishOverSpeed: TSpinEdit
        Left = 146
        Top = 84
        Width = 49
        Height = 21
        Hint = #23545#21152#36895#24809#32602#30340#22522#25968#65292#25968#25454#36234#22823#65292#23553#21152#36895#36234#20005#21385#65292#40664#35748'0'#65292#24314#35758#35843#33410#21040'20~120'#12290
        EditorEnabled = False
        Enabled = False
        Increment = 10
        MaxValue = 45000
        MinValue = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        Value = 600
      end
    end
    object ComBoxMagic: TComboBox
      Left = 16
      Top = 150
      Width = 137
      Height = 20
      Style = csDropDownList
      Enabled = False
      ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
      ItemHeight = 12
      TabOrder = 19
      OnChange = ComBoxMagicChange
      Items.Strings = (
        #28779#29699#26415
        #27835#24840#26415
        #22823#28779#29699
        #26045#27602#26415
        #25239#25298#28779#29615
        #22320#29425#28779
        #30142#20809#30005#24433
        #38647#30005#26415
        #28789#39746#28779#31526
        #24189#28789#30462
        #31070#22307#25112#30002#26415
        #22256#39764#21650
        #21484#21796#39607#39621
        #38544#36523#26415
        #38598#20307#38544#36523#26415
        #35825#24785#20043#20809
        #30636#24687#31227#21160
        #28779#22681
        #29190#35010#28779#28976
        #22320#29425#38647#20809
        #37326#34542#20914#25758
        #24515#28789#21551#31034
        #32676#20307#27835#30103#26415
        #21484#21796#31070#20861
        #22307#35328#26415
        #20912#21638#21742
        #35299#27602#26415
        #29422#21564#21151
        #28779#28976#20912
        #32676#20307#38647#30005#26415
        #32676#20307#26045#27602#26415
        #24443#22320#38025
        #29422#23376#21564
        #23506#20912#25484
        #28781#22825#28779
        #20998#36523#26415
        #28779#40857#28976
        #27668#21151#27874
        #20928#21270#26415
        #26080#26497#30495#27668
        #39123#39118#30772
        #35781#21650#26415
        #34880#21650
        #39607#39621#21650
        #25810#40857#25163
        #20094#22372#22823#25386#31227
        #22797#27963#26415
        #27969#26143#28779#38632
        #22124#34880#26415
        #21484#21796#22307#20861
        #21484#21796#26376#28789)
    end
    object speCLTMagic: TSpinEdit
      Left = 156
      Top = 149
      Width = 55
      Height = 21
      Enabled = False
      Increment = 100
      MaxValue = 45000
      MinValue = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 20
      Value = 600
      OnChange = speCLTMagicChange
    end
    object CheckBoxEat: TCheckBox
      Left = 441
      Top = 30
      Width = 106
      Height = 17
      Caption = #21507#33647#21697#26102#38388#38388#38548
      TabOrder = 21
      OnClick = CheckBoxEatClick
    end
    object CheckBoxPickUp: TCheckBox
      Left = 441
      Top = 52
      Width = 108
      Height = 17
      Caption = #25441#29289#21697#26102#38388#38388#38548
      TabOrder = 22
      OnClick = CheckBoxPickUpClick
    end
    object spePickUpItemInvTime: TSpinEdit
      Left = 543
      Top = 48
      Width = 52
      Height = 21
      EditorEnabled = False
      Enabled = False
      Increment = 10
      MaxValue = 45000
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 23
      Value = 600
      OnChange = spePickUpItemInvTimeChange
    end
    object speEatItemInvTime: TSpinEdit
      Left = 543
      Top = 27
      Width = 52
      Height = 21
      EditorEnabled = False
      Enabled = False
      Increment = 10
      MaxValue = 45000
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 24
      Value = 600
      OnChange = speEatItemInvTimeChange
    end
    object CheckBoxCheck: TCheckBox
      Left = 15
      Top = -2
      Width = 92
      Height = 17
      Caption = #21551#29992#22806#25346#25511#21046
      TabOrder = 25
      OnClick = CheckBoxCheckClick
    end
    object EditWarningMsgFColor: TSpinEdit
      Left = 213
      Top = 174
      Width = 41
      Height = 21
      EditorEnabled = False
      MaxValue = 255
      MinValue = 0
      TabOrder = 26
      Value = 100
      OnChange = EditWarningMsgFColorChange
    end
    object EditWarningMsgBColor: TSpinEdit
      Left = 301
      Top = 174
      Width = 41
      Height = 21
      EditorEnabled = False
      MaxValue = 255
      MinValue = 0
      TabOrder = 27
      Value = 100
      OnChange = EditWarningMsgBColorChange
    end
    object CheckBoxOther: TCheckBox
      Left = 441
      Top = 10
      Width = 106
      Height = 17
      Caption = #20854#23427#25805#26102#38388#38388#38548
      TabOrder = 28
      OnClick = CheckBoxEatClick
    end
  end
  object BitBtnVSetup: TBitBtn
    Left = 416
    Top = 237
    Width = 105
    Height = 25
    Caption = #24674#22797#40664#35748#35774#32622'(&C)'
    TabOrder = 1
    OnClick = BitBtnVSetupClick
  end
  object BitBtnOK: TBitBtn
    Left = 304
    Top = 237
    Width = 105
    Height = 25
    Caption = #20445#23384#21551#29992#35774#32622'(&O)'
    Enabled = False
    TabOrder = 2
    OnClick = BitBtnOKClick
  end
  object BitBtnCancel: TBitBtn
    Left = 528
    Top = 237
    Width = 81
    Height = 25
    Caption = #20851#38381'(&C)'
    ModalResult = 2
    TabOrder = 3
    OnClick = BitBtnCancelClick
  end
end
