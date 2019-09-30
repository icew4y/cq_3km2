unit Share;

interface
uses Common, Classes, DBTables, Windows, SysUtils;
type
  TStdItem = packed record
    Name: string[14];//物品名称
    StdMode: Byte; //0/1/2/3：药， 5/6:武器，10/11：盔甲，15：头盔，22/23：戒指，24/26：手镯，19/20/21：项链
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: ShortInt;
    Reserved: Byte; //0x14
    NeedIdentify: Byte; //0x15 需要
    Looks: Word; //0x16 外观，即Items.WIL中的图片索引
    DuraMax: Word; //0x18  最大持久
    Reserved1: Word;
    AC: Integer; //0x1A
    MAC: Integer; //0x1C
    DC: Integer; //0x1E
    MC: Integer; //0x20
    SC: Integer; //0x22
    Need: Integer; //0x24
    NeedLevel: Integer; //0x25
    Price: Integer; //0x28
  end;
  pTStdItem = ^TStdItem;
const
  Version = 0;//1为1.76版本

  GameMonName = 'QKGameMonList.txt';
  FilterFileName = 'GameFilterItemNameList.txt';
  {$IF Version = 1}
  g_sProductName = 'FC3CFB19E1FDDD4B8327EFFEE704954717D6D6987B92E63C569D34FD66A227292F76CB751D17C111'; //3KM2 1.76引擎生成客户端(Client)
  {$ELSE}
  g_sProductName = 'FC3CFB19E1FDDD4B8327EFFEE704954717D6D6987B92E63C02CBB391478E55132F76CB751D17C111'; //3KM2 连击引擎生成客户端(Client)
  {$IFEND}
  g_sVersion = '03D66443562E29112F344FC7EADF5DF9C5C3C9374D92394E';  //2.00 Build 20110718
  g_sUpDateTime = 'A42FBF7986B704A9CF3ABB7DBC68FB4D'; //2011/07/18
  g_sProgram = 'BF329B13CBE9010C601B4C1E88011620'; //3K科技
  g_sWebSite = '92A51ADA62A0738AC5DB86D6E7E9CDE140574B5A981AB1753188062D144466D7'; // http://www.3KM2.com(官网站)
  g_sBbsSite = '6136601E4431B32C60BFBF8207DB95FA40574B5A981AB1753188062D144466D7'; //http://www.3KM2.net(程序站)
  g_sServerAdd = '9BECFDD8143865D343B34FE6E6685A942BF1CB066D8203D3'; //vip.3km2.com
  g_sFtpServerAdd = '9BECFDD8143865D343B34FE6E6685A948DA9ED19FDBAEDB1'; //ftp.3km2.com
  g_sFtpUser = 'AA6591AB9081007292D5A33CDA5DC193';//56m2vip
  g_sFtpPass = '8F618E113AFF24F7AEB6A37AADB53431ECB7CB18A523A87F'; //werks%*&@&@#

  _sProductAddress ='224B21DC4825956E209CC996D0C2121800B4F4692E0C07EF7CF957402C49244906B327DBB14599B7';//http://notice.3km2.com/version.xml 放特殊指令的文本
  _sProductAddressBak ='224B21DC4825956E209CC996D0C21218C315B9FB5F3048F57CF957402C49244906B327DBB14599B7';//备用网站 http://notice.66h6.com/version.xml 放特殊指令的文本
  _sProductAddress1 ='{{{"5>a>"oca"ob';//www.92m2.com.cn //改版权指令(文本里需加密),即网站文本第一行内容
  {$IF Version = 1}
  g_sVersionNum = 'D8A4BF98D27175C3A2EF55A91686646F';//20110718 //1.76本配置器的版本号
  {$ELSE}
  g_sVersionNum = 'D8A4BF98D27175C3A2EF55A91686646F';//20110718 //本配置器的版本号
  {$IFEND}

  (*文本内容
{{{"5>a>"oca"ob
本站网站已经修改成XXXXXX|登陆不进去的用户请从新网站从新下载商业配置器
*)
var
  g_MySelf: TM2UserInfo;
  g_boConnect: Boolean = False;
  g_boLogined: Boolean = False;
  g_sRecvMsg: string;
  g_sRecvGameMsg: string;
  g_boBusy: Boolean;
  g_sAccount: string;
  g_sPassword: string;
  g_boFirstOpen: Boolean = False;
  StdItemList: TList; //List_54
  Query: TQuery;
  MakeType: Byte = 0;
function LoadItemsDB: Integer;
function getXmlNodeValue(strEntityEngineFile: string; xmlNodePath: string;
  const xmlattrname: string = ''; const dep: Char = '.'): string;
implementation
uses XMLIntf, XMLDoc;
function LoadItemsDB: Integer;
var
  I, Idx: Integer;
  StdItem: pTStdItem;
resourcestring
  sSQLString = 'select * from StdItems';
begin
    try
      for I := 0 to StdItemList.Count - 1 do begin
        Dispose(pTStdItem(StdItemList.Items[I]));
      end;
      StdItemList.Clear;
      Result := -1;
      Query.SQL.Clear;
      Query.SQL.Add(sSQLString);
        try
          Query.Open;
        finally
          Result := -2;
        end;
      for I := 0 to Query.RecordCount - 1 do begin
        New(StdItem);
        Idx := Query.FieldByName('Idx').AsInteger;
        StdItem.Name := Query.FieldByName('Name').AsString;
        StdItem.StdMode := Query.FieldByName('StdMode').AsInteger;
        StdItem.Shape := Query.FieldByName('Shape').AsInteger;
        StdItem.Weight := Query.FieldByName('Weight').AsInteger;
        StdItem.AniCount := Query.FieldByName('AniCount').AsInteger;
        StdItem.Source := Query.FieldByName('Source').AsInteger;
        StdItem.Reserved := Query.FieldByName('Reserved').AsInteger;
        StdItem.Looks := Query.FieldByName('Looks').AsInteger;
        StdItem.DuraMax := Word(Query.FieldByName('DuraMax').AsInteger);
        StdItem.AC := MakeLong(Round(Query.FieldByName('Ac').AsInteger * (10 / 10)), Round(Query.FieldByName('Ac2').AsInteger * (10 / 10)));
        StdItem.MAC := MakeLong(Round(Query.FieldByName('Mac').AsInteger * (10 / 10)), Round(Query.FieldByName('MAc2').AsInteger * (10 / 10)));
        StdItem.DC := MakeLong(Round(Query.FieldByName('Dc').AsInteger * (10 / 10)), Round(Query.FieldByName('Dc2').AsInteger * (10 / 10)));
        StdItem.MC := MakeLong(Round(Query.FieldByName('Mc').AsInteger * (10 / 10)), Round(Query.FieldByName('Mc2').AsInteger * (10 / 10)));
        StdItem.SC := MakeLong(Round(Query.FieldByName('Sc').AsInteger * (10 / 10)), Round(Query.FieldByName('Sc2').AsInteger * (10 / 10)));
        StdItem.Need := Query.FieldByName('Need').AsInteger;
        StdItem.NeedLevel := Query.FieldByName('NeedLevel').AsInteger;
        StdItem.Price := Query.FieldByName('Price').AsInteger;
        //StdItem.NeedIdentify := GetGameLogItemNameList(StdItem.Name);
        if StdItemList.Count = Idx then begin
          StdItemList.Add(StdItem);
          Result := 1;
        end else begin
          //Memo.Lines.Add(Format('加载物品(Idx:%d Name:%s)数据失败！！！', [Idx, StdItem.Name]));
          Result := -100;
          Exit;
        end;
        Query.Next;
      end;
    finally
      Query.Close;
    end;
end;

{-------------------------------------------------------------------------------
  xml功能
}
function getnodefromIXMLNodeList(childnodes: IXMLNodeList; nodename: string): IXMLNode;
var
  i: Integer;
begin
  for i := 1 to childnodes.Count do begin
    if (childnodes.Get(i - 1).NodeName = nodename) then begin
      result := childnodes[i - 1];
      exit;
    end;
  end;
end;

{----------------------------------------------------------------------------------------------------------------------------
  函数功能：直接读取xml文件中的某个节点第一次出现的值
  入口参数：xmlFile xml文件
            xmlnodepath 节点
            xmlattrname 节点中的属性名称，如果直接取节点值则可以忽略此参数。
            dep  节点的参数的分隔符，默认为.
  返 回 值：末级点的值
}

function getXmlNodeValue(strEntityEngineFile: string; xmlNodePath: string;
  const xmlattrname: string = ''; const dep: Char = '.'): string;
var
  xmlDocument: IXMLDocument;
  node: IXMLNode;
  xmlnodeList: TStrings;
  i: Integer;
  urlcount: Integer;
begin
    //xml节点路径
  xmlnodeList := TStringList.Create;
  xmlnodeList.Delimiter := dep;
  xmlnodeList.DelimitedText := xmlnodepath;
  urlcount := xmlnodeList.Count;
    //xml对象
  xmlDocument := TXMLDocument.Create(nil);
  //xmlDocument.LoadFromFile(strEntityEngineFile);
  xmlDocument.XML.Text := strEntityEngineFile;
  xmlDocument.Active := true;
  try
    node := xmlDocument.DocumentElement;
    if (node.NodeName = xmlnodeList[0]) then begin
            //扫描节点
      for i := 1 to urlcount - 1 do begin
        if (node <> nil) then
          node := getnodefromIXMLNodeList(node.ChildNodes, xmlnodeList[i])
        else Break;
      end;
      if (node = nil) then begin
        result := '';
      end else begin
                //判断是取属性还是取节点内容
        if (Trim(xmlattrname) = '') then
          result := node.Text
        else
          result := node.AttributeNodes.Nodes[xmlattrname].NodeValue;
      end;
    end else begin
      result := '';
    end;

  except
    result := 'error';
  end;
  xmlDocument.Active := false;
end;


initialization
begin
  StdItemList := TList.Create;
  Query := TQuery.Create(nil);
end;
finalization
begin
  //StdItemList.Free;  不知道为什么 一释放就出错
  Query.Free;
end;
end.
