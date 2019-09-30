object RzDBRadioGroupEditDlg: TRzDBRadioGroupEditDlg
  Left = 330
  Top = 124
  Caption = '- DBRadioGroup Editor'
  ClientHeight = 287
  ClientWidth = 582
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TRzPanel
    Left = 0
    Top = 254
    Width = 582
    Height = 33
    Align = alBottom
    BorderOuter = fsNone
    TabOrder = 1
    object btnLoad: TRzButton
      Left = 8
      Top = 0
      Caption = 'Load...'
      HotTrack = True
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object btnClear: TRzButton
      Left = 91
      Top = 0
      Caption = 'Clear'
      HotTrack = True
      TabOrder = 1
      OnClick = btnClearClick
    end
    object RzPanel1: TRzPanel
      Left = 416
      Top = 0
      Width = 166
      Height = 33
      Align = alRight
      BorderOuter = fsNone
      TabOrder = 2
      object btnOk: TRzButton
        Left = 0
        Top = 0
        Default = True
        ModalResult = 1
        Caption = 'OK'
        HotTrack = True
        TabOrder = 0
        OnClick = btnOkClick
      end
      object btnCancel: TRzButton
        Left = 82
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
    Width = 305
    Height = 254
    Align = alLeft
    BorderOuter = fsNone
    TabOrder = 0
    object pnlClientArea: TRzPanel
      Left = 0
      Top = 85
      Width = 305
      Height = 169
      Align = alClient
      BorderOuter = fsNone
      BorderWidth = 4
      TabOrder = 0
      object grdItemsValues: TRzStringGrid
        Left = 4
        Top = 4
        Width = 297
        Height = 161
        Align = alClient
        ColCount = 3
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowMoving, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
        TabOrder = 0
        OnClick = grdItemsValuesClick
        FrameVisible = True
        OnResize = grdItemsValuesResize
      end
    end
    object RzPanel2: TRzPanel
      Left = 0
      Top = 0
      Width = 305
      Height = 85
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 1
      object Label2: TRzLabel
        Left = 8
        Top = 48
        Width = 50
        Height = 13
        Caption = 'Columns'
        ParentColor = False
      end
      object Label1: TRzLabel
        Left = 8
        Top = 16
        Width = 44
        Height = 13
        Caption = 'Caption'
        ParentColor = False
      end
      object trkColumns: TRzTrackBar
        Left = 68
        Top = 35
        Width = 233
        Min = 1
        Position = 1
        TickStyle = tkOwnerDraw
        OnChange = trkColumnsChange
        OnDrawTick = trkColumnsDrawTick
        TabOrder = 0
      end
      object edtCaption: TRzEdit
        Left = 76
        Top = 12
        Width = 216
        Height = 21
        FrameVisible = True
        TabOrder = 1
        OnChange = edtCaptionChange
      end
    end
  end
  object pnlPreview: TRzPanel
    Left = 305
    Top = 0
    Width = 277
    Height = 254
    Align = alClient
    BorderOuter = fsNone
    BorderWidth = 8
    Constraints.MinHeight = 150
    Constraints.MinWidth = 100
    TabOrder = 2
    object grpPreview: TRzDBRadioGroup
      Left = 8
      Top = 8
      Width = 261
      Height = 238
      Align = alClient
      TabOrder = 0
    end
  end
  object dlgOpen: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Text Files|*.txt|All Files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 180
    Top = 236
  end
end
