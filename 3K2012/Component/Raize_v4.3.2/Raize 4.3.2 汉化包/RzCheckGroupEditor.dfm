object RzCheckGroupEditDlg: TRzCheckGroupEditDlg
  Left = 185
  Top = 115
  Caption = '- CheckGroup Editor'
  ClientHeight = 269
  ClientWidth = 558
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlButtons: TRzPanel
    Left = 0
    Top = 237
    Width = 558
    Height = 32
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 1
    object BtnLoad: TRzButton
      Left = 8
      Top = 0
      Caption = 'Load...'
      HotTrack = True
      TabOrder = 0
      OnClick = BtnLoadClick
    end
    object BtnClear: TRzButton
      Left = 91
      Top = 0
      Caption = 'Clear'
      HotTrack = True
      TabOrder = 1
      OnClick = BtnClearClick
    end
    object RzPanel1: TRzPanel
      Left = 390
      Top = 0
      Width = 168
      Height = 32
      Align = alRight
      BorderOuter = fsNone
      TabOrder = 2
      object BtnOk: TRzButton
        Left = 0
        Top = 0
        Default = True
        ModalResult = 1
        Caption = 'OK'
        HotTrack = True
        TabOrder = 0
      end
      object BtnCancel: TRzButton
        Left = 84
        Top = 0
        Cancel = True
        ModalResult = 2
        Caption = 'Cancel'
        HotTrack = True
        TabOrder = 1
      end
    end
  end
  object PnlOptions: TRzPanel
    Left = 0
    Top = 0
    Width = 293
    Height = 237
    Align = alLeft
    BorderOuter = fsNone
    TabOrder = 0
    object Label1: TRzLabel
      Left = 8
      Top = 16
      Width = 44
      Height = 13
      Caption = 'Caption'
      ParentColor = False
    end
    object Label2: TRzLabel
      Left = 8
      Top = 52
      Width = 50
      Height = 13
      Caption = 'Columns'
      ParentColor = False
    end
    object Label3: TRzLabel
      Left = 8
      Top = 72
      Width = 33
      Height = 13
      Caption = 'Items'
      ParentColor = False
    end
    object EdtCaption: TRzEdit
      Left = 68
      Top = 12
      Width = 216
      Height = 21
      FrameVisible = True
      TabOrder = 1
      OnChange = EdtCaptionChange
    end
    object EdtItems: TRzMemo
      Left = 8
      Top = 88
      Width = 277
      Height = 141
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
      OnChange = EdtItemsChange
      FrameVisible = True
    end
    object TrkColumns: TRzTrackBar
      Left = 60
      Top = 39
      Width = 233
      Min = 1
      Position = 1
      TickStyle = tkOwnerDraw
      OnChange = TrkColumnsChange
      OnDrawTick = TrkColumnsDrawTick
      TabOrder = 2
    end
  end
  object PnlPreview: TRzPanel
    Left = 293
    Top = 0
    Width = 265
    Height = 237
    Align = alClient
    BorderOuter = fsNone
    BorderWidth = 8
    Constraints.MinHeight = 150
    Constraints.MinWidth = 100
    TabOrder = 2
    object GrpPreview: TRzCheckGroup
      Left = 8
      Top = 8
      Width = 249
      Height = 221
      Align = alClient
      TabOrder = 0
    end
  end
  object DlgOpen: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text Files|*.txt|All Files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 180
    Top = 236
  end
end
