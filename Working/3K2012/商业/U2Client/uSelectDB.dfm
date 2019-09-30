object FrmSelectDB: TFrmSelectDB
  Left = 392
  Top = 310
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'BDE'#25968#25454#24211#36873#25321
  ClientHeight = 93
  ClientWidth = 382
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
  object Label1: TLabel
    Left = 99
    Top = 27
    Width = 60
    Height = 12
    Caption = #25968#25454#24211#21517#65306
    Transparent = False
  end
  object EdtDBName: TEdit
    Left = 158
    Top = 24
    Width = 93
    Height = 18
    Ctl3D = False
    ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
    ParentCtl3D = False
    TabOrder = 0
    Text = 'HeroDB'
  end
  object BtnOK: TButton
    Left = 208
    Top = 64
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 1
    OnClick = BtnOKClick
  end
  object BtnNo: TButton
    Left = 296
    Top = 64
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
    OnClick = BtnNoClick
  end
end
