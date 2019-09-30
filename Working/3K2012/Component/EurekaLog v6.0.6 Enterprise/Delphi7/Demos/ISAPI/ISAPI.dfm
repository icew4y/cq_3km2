object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'WebActionItem1'
      PathInfo = '/PageProducer1'
      Producer = PageProducer1
    end>
  Height = 0
  Width = 0
  object PageProducer1: TPageProducer
    HTMLDoc.Strings = (
      'CIAO')
    Left = 32
    Top = 56
  end
end
