object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #36164#28304#26367#25442#28436#31034
  ClientHeight = 83
  ClientWidth = 104
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Read'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Write'
    TabOrder = 1
    OnClick = Button2Click
  end
end
