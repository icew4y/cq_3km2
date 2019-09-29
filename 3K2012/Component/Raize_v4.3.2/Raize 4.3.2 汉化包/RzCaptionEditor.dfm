object RzCaptionEditDlg: TRzCaptionEditDlg
  Left = 204
  Top = 113
  Width = 350
  Height = 250
  Caption = 'Caption/Hint Editor'
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlEditor: TRzPanel
    Left = 0
    Top = 0
    Width = 342
    Height = 180
    Align = alClient
    BorderOuter = fsNone
    BorderWidth = 8
    TabOrder = 0
    object EdtCaption: TRzMemo
      Left = 8
      Top = 8
      Width = 326
      Height = 164
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
      FrameVisible = True
    end
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 180
    Width = 342
    CaptionOk = 'OK'
    CaptionCancel = 'Cancel'
    CaptionHelp = '&Help'
    HotTrack = True
    TabOrder = 1
  end
end
