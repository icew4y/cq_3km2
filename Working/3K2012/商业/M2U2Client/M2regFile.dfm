object M2regFileFrm: TM2regFileFrm
  Left = 513
  Top = 320
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #27880#20876#25991#20214#29983#25104
  ClientHeight = 121
  ClientWidth = 387
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
  object Label12: TLabel
    Left = 112
    Top = 8
    Width = 42
    Height = 12
    Caption = 'Label12'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 387
    Height = 121
    ActivePage = TabSheet2
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheet4: TTabSheet
      Caption = #27880#20876#25991#20214#29983#25104
      ImageIndex = 3
      object Label1: TLabel
        Left = 24
        Top = 18
        Width = 60
        Height = 12
        Caption = #20844#21496#20449#24687#65306
      end
      object Label2: TLabel
        Left = 24
        Top = 71
        Width = 60
        Height = 12
        Caption = 'IP '#22320' '#22336#65306
        Visible = False
      end
      object Label3: TLabel
        Left = 24
        Top = 39
        Width = 60
        Height = 12
        Caption = #30828#20214#20449#24687#65306
      end
      object Label13: TLabel
        Left = 24
        Top = 64
        Width = 120
        Height = 12
        Caption = #20462#25913#36807#30828#20214#20449#24687#27425#25968#65306
      end
      object Label15: TLabel
        Left = 144
        Top = 64
        Width = 132
        Height = 12
        Caption = #21097#20313#20462#25913#30828#20214#20449#24687#27425#25968#65306
      end
      object Button1: TButton
        Left = 272
        Top = 64
        Width = 89
        Height = 25
        Caption = #29983#25104#27880#20876#25991#20214
        TabOrder = 0
        OnClick = Button1Click
      end
      object EdtGameListURL: TEdit
        Left = 95
        Top = 15
        Width = 247
        Height = 18
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
      end
      object EdtBakGameListURL: TEdit
        Left = 95
        Top = 68
        Width = 247
        Height = 18
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
        Visible = False
      end
      object EdtPatchListURL: TEdit
        Left = 95
        Top = 36
        Width = 247
        Height = 18
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object TabSheet1: TTabSheet
      Caption = #20462#25913'IP'#22320#22336
      ImageIndex = 1
      object Label4: TLabel
        Left = 8
        Top = 80
        Width = 360
        Height = 24
        Caption = #27880#24847#65306#27599#20010#36134#21495#21482#33021#20462#25913'IP'#25110#30828#20214#20449#24687#19977#27425#65292#22914#31532#19968#27425#20462#25913'IP'#20449#24687#65292#13#10#21017#21518#38754#20108#27425#21482#33021#20462#25913'IP'#20449#24687#65292#36798#21040#19977#27425#21518#65292#23558#19981#33021#20877#20462#25913#65281
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 24
        Top = 18
        Width = 60
        Height = 12
        Caption = #20844#21496#20449#24687#65306
      end
      object Label7: TLabel
        Left = 24
        Top = 61
        Width = 60
        Height = 12
        Caption = 'IP '#22320' '#22336#65306
        Visible = False
      end
      object Label8: TLabel
        Left = 24
        Top = 39
        Width = 60
        Height = 12
        Caption = #30828#20214#20449#24687#65306
      end
      object Edit1: TEdit
        Left = 95
        Top = 15
        Width = 247
        Height = 18
        Color = clGrayText
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit2: TEdit
        Left = 95
        Top = 57
        Width = 247
        Height = 18
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        TabOrder = 1
        Visible = False
      end
      object Edit3: TEdit
        Left = 95
        Top = 36
        Width = 247
        Height = 18
        Color = clGrayText
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
      end
      object Button2: TButton
        Left = 272
        Top = 108
        Width = 75
        Height = 25
        Caption = #20462#25913'IP'#22320#22336
        TabOrder = 3
        OnClick = Button2Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = #20462#25913#30828#20214#20449#24687
      ImageIndex = 2
      object Label5: TLabel
        Left = 24
        Top = 80
        Width = 216
        Height = 12
        Caption = #27880#24847#65306#27599#20010#36134#21495#21482#33021#20462#25913#30828#20214#20449#24687#19977#27425#65281
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 24
        Top = 18
        Width = 60
        Height = 12
        Caption = #20844#21496#20449#24687#65306
      end
      object Label10: TLabel
        Left = 24
        Top = 39
        Width = 60
        Height = 12
        Caption = #30828#20214#20449#24687#65306
      end
      object Label11: TLabel
        Left = 24
        Top = 103
        Width = 60
        Height = 12
        Caption = 'IP '#22320' '#22336#65306
        Visible = False
      end
      object Label14: TLabel
        Left = 24
        Top = 64
        Width = 120
        Height = 12
        Caption = #20462#25913#36807#30828#20214#20449#24687#27425#25968#65306
      end
      object Label16: TLabel
        Left = 144
        Top = 64
        Width = 132
        Height = 12
        Caption = #21097#20313#20462#25913#30828#20214#20449#24687#27425#25968#65306
      end
      object Edit4: TEdit
        Left = 95
        Top = 15
        Width = 247
        Height = 18
        Color = clGrayText
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
      end
      object Edit5: TEdit
        Left = 95
        Top = 100
        Width = 247
        Height = 18
        Color = clGrayText
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
        Visible = False
      end
      object Edit6: TEdit
        Left = 95
        Top = 36
        Width = 247
        Height = 18
        Ctl3D = False
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        MaxLength = 120
        ParentCtl3D = False
        TabOrder = 2
      end
      object Button3: TButton
        Left = 272
        Top = 64
        Width = 81
        Height = 25
        Caption = #20462#25913#30828#20214#20449#24687
        TabOrder = 3
        OnClick = Button3Click
      end
    end
  end
end
