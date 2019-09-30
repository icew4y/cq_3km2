object RzImageListEditDlg: TRzImageListEditDlg
  Left = 418
  Top = 112
  Width = 524
  Height = 296
  HorzScrollBar.Increment = 37
  VertScrollBar.Increment = 22
  VertScrollBar.Range = 131
  AutoScroll = False
  Caption = '- Image List Editor'
  Color = clBtnFace
  Constraints.MinHeight = 296
  Constraints.MinWidth = 524
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlImages: TRzPanel
    Left = 0
    Top = 110
    Width = 516
    Height = 133
    Align = alClient
    BorderOuter = fsNone
    BorderWidth = 8
    TabOrder = 1
    object GrpImages: TRzGroupBox
      Left = 8
      Top = 8
      Width = 500
      Height = 117
      Align = alClient
      BorderWidth = 8
      Caption = ' &Images '
      TabOrder = 0
      object LvwImages: TRzListView
        Left = 9
        Top = 14
        Width = 482
        Height = 65
        Hint = 'Right-Click to Change Background Color.'
        Align = alClient
        Columns = <>
        DragMode = dmAutomatic
        FillLastColumn = False
        FrameVisible = True
        IconOptions.WrapText = False
        MultiSelect = True
        PopupMenu = MnuListView
        TabOrder = 0
        OnCompare = LvwImagesCompare
        OnDragDrop = LvwImagesDragDrop
        OnDragOver = LvwImagesDragOver
        OnEdited = LvwImagesEdited
        OnKeyDown = LvwImagesKeyDown
        OnMouseMove = HintControlMouseMove
        OnResize = LvwImagesResize
        OnSelectItem = LvwImagesSelectItem
      end
      object PnlImageListButtons: TRzPanel
        Left = 9
        Top = 79
        Width = 482
        Height = 29
        Align = alBottom
        BorderOuter = fsNone
        TabOrder = 1
        object BtnReplace: TRzButton
          Left = 81
          Top = 4
          Hint = 'Replace Selected Images'
          Caption = '&Replace...'
          HotTrack = True
          TabOrder = 1
          OnClick = BtnReplaceClick
          OnMouseMove = HintControlMouseMove
        end
        object BtnAdd: TRzButton
          Left = 0
          Top = 4
          Hint = 'Add Images to List'
          Caption = '&Add...'
          HotTrack = True
          TabOrder = 0
          OnClick = BtnAddClick
          OnMouseMove = HintControlMouseMove
        end
        object BtnDelete: TRzButton
          Left = 162
          Top = 4
          Hint = 'Delete the Selected Image from the List'
          Caption = '&Delete'
          Enabled = False
          HotTrack = True
          TabOrder = 2
          OnClick = BtnDeleteClick
          OnMouseMove = HintControlMouseMove
        end
        object BtnClear: TRzButton
          Left = 244
          Top = 4
          Hint = 'Clear All Images'
          Caption = '&Clear'
          Enabled = False
          HotTrack = True
          TabOrder = 3
          OnClick = BtnClearClick
          OnMouseMove = HintControlMouseMove
        end
        object BtnExport: TRzButton
          Left = 326
          Top = 4
          Hint = 'Export All Images as a Single Image File'
          Caption = 'E&xport...'
          Enabled = False
          HotTrack = True
          TabOrder = 4
          OnClick = BtnExportClick
          OnMouseMove = HintControlMouseMove
        end
        object BtnSave: TRzButton
          Left = 407
          Top = 4
          Hint = 'Save Selected Image to a File'
          Caption = 'Save...'
          Enabled = False
          HotTrack = True
          TabOrder = 5
          OnClick = BtnSaveClick
          OnMouseMove = HintControlMouseMove
        end
      end
    end
  end
  object PnlSelectImage: TRzPanel
    Left = 0
    Top = 0
    Width = 516
    Height = 110
    Align = alTop
    BorderOuter = fsNone
    TabOrder = 0
    object PnlDialogButtons: TRzPanel
      Left = 427
      Top = 0
      Width = 89
      Height = 110
      Align = alRight
      BorderOuter = fsNone
      TabOrder = 0
      object BtnOK: TRzButton
        Left = 6
        Top = 12
        ModalResult = 1
        Caption = 'OK'
        HotTrack = True
        TabOrder = 0
      end
      object BtnCancel: TRzButton
        Left = 6
        Top = 44
        Cancel = True
        ModalResult = 2
        Caption = 'Cancel'
        HotTrack = True
        TabOrder = 1
      end
      object BtnApply: TRzButton
        Left = 6
        Top = 76
        Hint = 'Apply Changes'
        Caption = 'A&pply'
        HotTrack = True
        TabOrder = 2
        OnClick = BtnApplyClick
        OnMouseMove = HintControlMouseMove
      end
    end
    object GrpSelected: TRzGroupBox
      Left = 8
      Top = 8
      Width = 413
      Height = 101
      Caption = ' &Selected Image '
      TabOrder = 1
      object LblTransparentColor: TRzLabel
        Left = 95
        Top = 15
        Width = 109
        Height = 13
        Caption = '&Transparent Color:'
        FocusControl = CbxTransparentColor
        ParentColor = False
      end
      object LblFillColor: TRzLabel
        Left = 94
        Top = 55
        Width = 55
        Height = 13
        Caption = '&Fill Color:'
        FocusControl = CbxFillColor
        ParentColor = False
      end
      object GrpOptions: TRzRadioGroup
        Left = 300
        Top = 12
        Width = 105
        Height = 81
        Caption = ' Options '
        GroupStyle = gsCustom
        ItemHotTrack = True
        Items.Strings = (
          'Cr&op'
          'St&retch'
          'C&enter')
        TabOrder = 2
        OnClick = GrpOptionsClick
      end
      object PnlSelected: TRzPanel
        Left = 12
        Top = 18
        Width = 73
        Height = 73
        BorderOuter = fsFlat
        TabOrder = 3
        object ImgPreview: TImage
          Left = 1
          Top = 1
          Width = 71
          Height = 71
          Hint = 'Left-Click to Select Transparent Color. Right-Click '
          Align = alClient
          Stretch = True
          OnMouseDown = ImgPreviewMouseDown
          OnMouseMove = ImgPreviewMouseMove
        end
      end
      object CbxTransparentColor: TRzComboBox
        Left = 94
        Top = 30
        Width = 190
        Height = 21
        Ctl3D = False
        FlatButtons = True
        FrameVisible = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 0
        OnChange = CbxTransparentColorChange
        OnExit = CbxTransparentColorExit
      end
      object CbxFillColor: TRzComboBox
        Left = 94
        Top = 70
        Width = 190
        Height = 21
        Ctl3D = False
        FlatButtons = True
        FrameVisible = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 1
        OnChange = CbxTransparentColorChange
        OnExit = CbxTransparentColorExit
      end
    end
  end
  object StatusBar: TRzStatusBar
    Left = 0
    Top = 243
    Width = 516
    Height = 19
    AutoStyle = False
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 2
    object StsHints: TRzStatusPane
      Left = 0
      Top = 0
      Width = 516
      Height = 19
      Align = alClient
    end
  end
  object DlgSavePicture: TSavePictureDialog
    DefaultExt = '.bmp'
    Filter = 
      'All (*.bmp;*.ico)|*.bmp;*.ico|Bitmaps (*.bmp)|*.bmp|Icons (*.ico' +
      ')|*.ico'
    FilterIndex = 2
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 27
    Top = 140
  end
  object DlgColor: TColorDialog
    Ctl3D = True
    Left = 61
    Top = 140
  end
  object DlgOpenPicture: TOpenPictureDialog
    Filter = 
      'All (*.bmp;*.ico)|*.bmp;*.ico|Bitmaps (*.bmp)|*.bmp|Icons (*.ico' +
      ')|*.ico'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 96
    Top = 140
  end
  object MnuListView: TPopupMenu
    Left = 284
    Top = 146
    object MnuBackgroundColor: TMenuItem
      Caption = 'Change &Background color...'
      ShortCut = 16450
      OnClick = MnuBackgroundColorClick
    end
    object MnuSep1: TMenuItem
      Caption = '-'
    end
    object MnuRestoreBackgroundColor: TMenuItem
      Caption = '&Restore Background Color'
      OnClick = MnuRestoreBackgroundColorClick
    end
  end
end
