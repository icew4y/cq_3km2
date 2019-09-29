object Form1: TForm1
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = '3K'#31185#25216#25968#25454#26684#24335#21319#32423#24037#20855
  ClientHeight = 381
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 381
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #21319#32423#21040#26368#26032#29256
      OnContextPopup = TabSheet1ContextPopup
      DesignSize = (
        680
        353)
      object Label1: TLabel
        Left = 8
        Top = 4
        Width = 52
        Height = 13
        Caption = #20445#23384#30446#24405':'
      end
      object SpeedButton1: TSpeedButton
        Left = 645
        Top = 0
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object Label15: TLabel
        Left = 15
        Top = 98
        Width = 600
        Height = 24
        Caption = 
          #27880#24847#65306#21319#32423#20043#21069#19968#23450#35201#22791#20221'FDB'#24211#65292#21542#21017#36896#25104#20219#20309#21518#26524#33258#36127#12290' '#22914#26524#26377#36716#25442#19981#20102#25110#36716#25442#20043#21518#20154#29289#20986#38169#35831#21040#32852#31995#23458#26381#12290#13'Http://Www.' +
          '3kM2.Com('#22797#21046#25991#20214#21518#65292#35831#33258#34892#21024#38500'Mir.DB.idx'#25991#20214')'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 3
        Top = 337
        Width = 116
        Height = 13
        Caption = #26356#26032#26102#38388#65306'2012/01/14'
      end
      object Edit1: TEdit
        Left = 64
        Top = 1
        Width = 582
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
        TabOrder = 0
      end
      object GroupBox3: TGroupBox
        Left = 4
        Top = 23
        Width = 671
        Height = 69
        Caption = #38656#36716#25442#30340#25968#25454#25991#20214
        TabOrder = 1
        DesignSize = (
          671
          69)
        object Label9: TLabel
          Left = 11
          Top = 20
          Width = 30
          Height = 13
          Caption = 'Mir.db'
        end
        object SpeedButton4: TSpeedButton
          Left = 641
          Top = 18
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton4Click
        end
        object Label2: TLabel
          Left = 11
          Top = 47
          Width = 53
          Height = 13
          Caption = 'HeroMir.db'
        end
        object SpeedButton2: TSpeedButton
          Left = 640
          Top = 45
          Width = 23
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          OnClick = SpeedButton2Click
        end
        object Mir_db1: TEdit
          Left = 51
          Top = 17
          Width = 591
          Height = 21
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 0
        end
        object Edit2: TEdit
          Left = 70
          Top = 44
          Width = 572
          Height = 21
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          TabOrder = 1
        end
      end
      object GroupBox2: TGroupBox
        Left = 3
        Top = 128
        Width = 677
        Height = 183
        Anchors = [akLeft, akRight, akBottom]
        Caption = #36827#24230#20449#24687
        TabOrder = 2
        DesignSize = (
          677
          183)
        object Label3: TLabel
          Left = 8
          Top = 16
          Width = 28
          Height = 13
          Caption = #20449#24687':'
        end
        object Label6: TLabel
          Left = 8
          Top = 32
          Width = 16
          Height = 13
          Caption = '0/0'
        end
        object Memo1: TMemo
          Left = 3
          Top = 53
          Width = 658
          Height = 123
          Anchors = [akLeft, akTop, akRight]
          ImeName = #20013#25991' ('#31616#20307') - '#32654#24335#38190#30424
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object Button2: TButton
        Left = 540
        Top = 317
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #36864#20986
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 448
        Top = 317
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = #24320#22987#36716#25442
        Default = True
        TabOrder = 4
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 304
        Top = 320
        Width = 75
        Height = 25
        Caption = 'Button3'
        TabOrder = 5
        Visible = False
        OnClick = Button3Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #25968#25454#25991#20214'(*.DB)|*.DB'
    Left = 422
    Top = 75
  end
  object RzSelectFolderDialog1: TRzSelectFolderDialog
    Left = 464
    Top = 80
  end
end
