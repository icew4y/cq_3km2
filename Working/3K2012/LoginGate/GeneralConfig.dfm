object frmGeneralConfig: TfrmGeneralConfig
  Left = 624
  Top = 503
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#26412#35774#32622
  ClientHeight = 201
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 377
    Height = 185
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#21442#25968
      object GroupBoxNet: TGroupBox
        Left = 8
        Top = 8
        Width = 185
        Height = 113
        Caption = #32593#32476#35774#32622
        TabOrder = 0
        object LabelGateIPaddr: TLabel
          Left = 8
          Top = 20
          Width = 54
          Height = 12
          Caption = #32593#20851#22320#22336':'
        end
        object LabelGatePort: TLabel
          Left = 8
          Top = 44
          Width = 54
          Height = 12
          Caption = #32593#20851#31471#21475':'
        end
        object LabelServerPort: TLabel
          Left = 8
          Top = 92
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#31471#21475':'
        end
        object LabelServerIPaddr: TLabel
          Left = 8
          Top = 68
          Width = 66
          Height = 12
          Caption = #26381#21153#22120#22320#22336':'
        end
        object EditGateIPaddr: TEdit
          Left = 80
          Top = 16
          Width = 97
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
          Text = '127.0.0.1'
        end
        object EditGatePort: TEdit
          Left = 80
          Top = 40
          Width = 41
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 1
          Text = '7200'
        end
        object EditServerPort: TEdit
          Left = 80
          Top = 88
          Width = 41
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 2
          Text = '5000'
        end
        object EditServerIPaddr: TEdit
          Left = 80
          Top = 64
          Width = 97
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 3
          Text = '127.0.0.1'
        end
      end
      object GroupBoxInfo: TGroupBox
        Left = 200
        Top = 8
        Width = 161
        Height = 113
        Caption = #22522#26412#21442#25968
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 20
          Width = 30
          Height = 12
          Caption = #26631#39064':'
        end
        object LabelShowLogLevel: TLabel
          Left = 8
          Top = 44
          Width = 78
          Height = 12
          Caption = #26174#31034#26085#24535#31561#32423':'
        end
        object EditTitle: TEdit
          Left = 40
          Top = 16
          Width = 105
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
          Text = #32593#34013#31185#25216
        end
        object TrackBarLogLevel: TTrackBar
          Left = 8
          Top = 56
          Width = 145
          Height = 25
          TabOrder = 1
        end
        object CheckBoxMinimize: TCheckBox
          Left = 8
          Top = 88
          Width = 137
          Height = 17
          Caption = #21551#21160#25104#21151#21518#26368#23567#21270
          TabOrder = 2
          OnClick = CheckBoxMinimizeClick
        end
      end
      object ButtonOK: TButton
        Left = 296
        Top = 128
        Width = 65
        Height = 25
        Caption = #30830#23450'(&O)'
        TabOrder = 2
        OnClick = ButtonOKClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #19987#29992#30331#38470#22120#35774#32622
      ImageIndex = 1
      object Label2: TLabel
        Left = 120
        Top = 14
        Width = 60
        Height = 12
        Caption = #30331#38470#23494#30721#65306
      end
      object Label3: TLabel
        Left = 8
        Top = 133
        Width = 150
        Height = 12
        Caption = #25442#34892#33258#21160#22788#29702'.'#20462#25913#31435#21363#29983#25928
      end
      object CheckBoxSpecLogin: TCheckBox
        Left = 8
        Top = 12
        Width = 102
        Height = 17
        Hint = #25171#24320#27492#21151#33021#21518#65292#23458#25143#31471#24517#39035#30001#25351#23450#30340#19987#29992#30331#38470#22120#25165#33021#30331#38470
        Caption = #24320#21551#19987#29992#30331#38470#22120
        Checked = True
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 0
      end
      object EdtPassword: TEdit
        Left = 179
        Top = 10
        Width = 182
        Height = 20
        Hint = #35774#32622#23458#25143#31471#26657#39564#23494#30721#65292#27492#23494#30721#23558#34987#21152#23494#21518#20256#36755
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 12
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        Text = 'Password'
      end
      object MemoWarningMsg: TMemo
        Left = 8
        Top = 36
        Width = 353
        Height = 85
        Hint = #35774#32622#38750#19987#29992#30331#38470#22120#30331#38470#26102#25552#31034#30340#38169#35823#20449#24687
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        Lines.Strings = (
          ''
          '                 '#24744#24403#21069#30340#30331#38470#22120#26080#27861#30331#38470#26412#28216#25103
          '             '#30331#38470#22120#19979#36733#22320#22336'http://www.3KM2.com')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnChange = MemoWarningMsgChange
      end
      object Button1: TButton
        Left = 296
        Top = 128
        Width = 65
        Height = 25
        Caption = #30830#23450'(&O)'
        TabOrder = 3
        OnClick = ButtonOKClick
      end
    end
  end
end
