object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 425
  ClientWidth = 789
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 12
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 305
    Height = 401
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 30
      Height = 12
      Caption = 'Key1:'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 30
      Height = 12
      Caption = 'Key2:'
    end
    object Label3: TLabel
      Left = 3
      Top = 66
      Width = 36
      Height = 12
      Caption = 'PKey3:'
    end
    object Label4: TLabel
      Left = 8
      Top = 88
      Width = 30
      Height = 12
      Caption = #26126#25991':'
    end
    object Label5: TLabel
      Left = 8
      Top = 205
      Width = 30
      Height = 12
      Caption = #23494#25991':'
    end
    object Label9: TLabel
      Left = 42
      Top = 319
      Width = 36
      Height = 12
      Caption = 'Label9'
    end
    object Edit1: TEdit
      Left = 42
      Top = 13
      Width = 250
      Height = 20
      TabOrder = 0
      Text = 'Edit1'
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 42
      Top = 37
      Width = 250
      Height = 20
      TabOrder = 1
      Text = 'Edit1'
      OnChange = Edit2Change
    end
    object Edit3: TEdit
      Left = 42
      Top = 61
      Width = 250
      Height = 20
      TabOrder = 2
      Text = 'Edit1'
      OnChange = Edit3Change
    end
    object Memo1: TMemo
      Left = 42
      Top = 88
      Width = 247
      Height = 111
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 3
    end
    object Memo2: TMemo
      Left = 42
      Top = 205
      Width = 247
      Height = 105
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 4
    end
    object Button1: TButton
      Left = 40
      Top = 368
      Width = 75
      Height = 25
      Caption = #21152#23494
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 176
      Top = 368
      Width = 75
      Height = 25
      Caption = #35299#23494
      TabOrder = 6
      OnClick = Button2Click
    end
    object RadioButton1: TRadioButton
      Left = 40
      Top = 344
      Width = 113
      Height = 17
      Caption = 'Server'
      Checked = True
      TabOrder = 7
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 168
      Top = 344
      Width = 113
      Height = 17
      Caption = 'Client'
      TabOrder = 8
      OnClick = RadioButton1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 327
    Top = 8
    Width = 454
    Height = 401
    TabOrder = 1
    object Label11: TLabel
      Left = 104
      Top = 47
      Width = 46
      Height = 14
      AutoSize = False
      Caption = #38543#26426#25968'1'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 280
      Top = 47
      Width = 41
      Height = 15
      AutoSize = False
      Caption = #38543#26426#25968'2'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 70
      Top = 163
      Width = 30
      Height = 12
      Caption = 'Key1:'
    end
    object Label7: TLabel
      Left = 70
      Top = 187
      Width = 30
      Height = 12
      Caption = 'Key2:'
    end
    object Label8: TLabel
      Left = 70
      Top = 211
      Width = 30
      Height = 12
      Caption = 'Key3:'
    end
    object Button3: TButton
      Left = 11
      Top = 41
      Width = 81
      Height = 25
      Caption = #29983#25104#38543#26426#25968
      TabOrder = 0
      OnClick = Button3Click
    end
    object Edit4: TEdit
      Left = 153
      Top = 43
      Width = 121
      Height = 20
      ImeName = #32043#20809#25340#38899#36755#20837#27861
      TabOrder = 1
    end
    object Edit5: TEdit
      Left = 327
      Top = 43
      Width = 121
      Height = 20
      ImeName = #32043#20809#25340#38899#36755#20837#27861
      TabOrder = 2
    end
    object Edit14: TEdit
      Left = 153
      Top = 13
      Width = 121
      Height = 20
      TabOrder = 3
      Text = '65537'
    end
    object Button4: TButton
      Left = 11
      Top = 104
      Width = 81
      Height = 25
      Caption = #29983#25104#23494#38053
      TabOrder = 4
      OnClick = Button4Click
    end
    object Edit6: TEdit
      Left = 104
      Top = 160
      Width = 250
      Height = 20
      TabOrder = 5
      Text = 'Edit1'
    end
    object Edit7: TEdit
      Left = 104
      Top = 184
      Width = 250
      Height = 20
      TabOrder = 6
      Text = 'Edit1'
    end
    object Edit8: TEdit
      Left = 104
      Top = 208
      Width = 250
      Height = 20
      TabOrder = 7
      Text = 'Edit1'
    end
    object Button5: TButton
      Left = 160
      Top = 256
      Width = 75
      Height = 25
      Caption = #20256#20837#24038#36793
      TabOrder = 8
      OnClick = Button5Click
    end
  end
  object RSA1: TRSA
    Server = True
    Left = 288
  end
end
