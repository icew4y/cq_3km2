object PictureEditorDlg: TPictureEditorDlg
  Left = 232
  Top = 143
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #22270#29255#32534#36753
  ClientHeight = 306
  ClientWidth = 357
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object OKButton: TButton
    Left = 274
    Top = 12
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelButton: TButton
    Left = 274
    Top = 41
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 7
    Width = 255
    Height = 288
    TabOrder = 2
    object ImagePanel: TPanel
      Left = 10
      Top = 16
      Width = 235
      Height = 235
      BevelOuter = bvNone
      BorderWidth = 5
      BorderStyle = bsSingle
      Color = clWindow
      ParentBackground = False
      TabOrder = 0
      object ImagePaintBox: TPaintBox
        Left = 5
        Top = 5
        Width = 221
        Height = 221
        Align = alClient
        OnPaint = ImagePaintBoxPaint
      end
    end
    object Load: TButton
      Left = 10
      Top = 257
      Width = 75
      Height = 23
      Caption = #25171#24320#22270#29255'...'
      TabOrder = 1
      OnClick = LoadClick
    end
    object Save: TButton
      Left = 90
      Top = 257
      Width = 75
      Height = 23
      Caption = #20445#23384#22270#29255'...'
      TabOrder = 2
      OnClick = SaveClick
    end
    object Clear: TButton
      Left = 170
      Top = 257
      Width = 75
      Height = 23
      Caption = #28165#38500#22270#29255'...'
      TabOrder = 3
      OnClick = ClearClick
    end
  end
  object OpenDialog: TOpenPictureDialog
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf)|*.bmp;*.ico;*.emf;*.wmf|Bitmaps (*' +
      '.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf' +
      '|Metafiles (*.wmf)|*.wmf'
    Left = 140
    Top = 20
  end
  object SaveDialog: TSavePictureDialog
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf)|*.bmp;*.ico;*.emf;*.wmf|Bitmaps (*' +
      '.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf' +
      '|Metafiles (*.wmf)|*.wmf'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Left = 140
    Top = 68
  end
end
