unit Share;

interface
uses Graphics, Common, Forms, Classes, DBTables, Windows, SysUtils, HUtil32, RzCommon, RzBmpBtn, EncdDecd, Controls;
resourcestring
  sSkinHeaderDesc = '3k登陆器皮肤文件';
type
  TFilterItemType = (i_All, i_Other, i_HPMPDurg, i_Dress, i_Weapon, i_Jewelry, i_Decoration, i_Decorate);
  
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

  TFilterItem = record
    ItemType: TFilterItemType;
    sItemName: string[14];
    boHintMsg: Boolean;
    boPickup: Boolean;
    boShowName: Boolean;
  end;
  pTFilterItem = ^TFilterItem;


  T3KControlVisible = record
    TreeView: Boolean;
    ComboBox1: Boolean;
    //Btn
    MinimizeBtn: Boolean;
    CloseBtn: Boolean;
    StartButton: Boolean;
    ButtonHomePage: Boolean;
    RzBmpButton1: Boolean;
    RzBmpButton2: Boolean;
    ButtonNewAccount: Boolean;
    ButtonChgPassword: Boolean;
    ButtonGetBackPassword: Boolean;
    ImageButtonClose: Boolean;
    //BtnEnd
    RzCheckBox1: Boolean;
    RzCheckBoxFullScreen: Boolean;
    RzLabelStatus: Boolean;
    RzComboBox1: Boolean;
    WebBrowser1: Boolean;
    RzProgressBar1: Boolean;
    RzProgressBar2: Boolean;
    ProgressBarCurDownload: Boolean;
    ProgressBarAll: Boolean;
  end;
  TSkinFileHeader = packed record
    sDesc: string[$10]; //16
    boServerList: Boolean; //是否为TreeView
    boProgressBarDown: Boolean;
    boProgressBarAll: Boolean;
    boFrmTransparent: Boolean; //窗体是否透明
    ControlVisible: T3KControlVisible; //控件是否可见
    dCreateDate: TDateTime;  
  end;
  pTSkinFileHeader = ^TSkinFileHeader;

  T3KBase = record
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
    //Visible: Boolean;
  end;

  T3KFont = record
    Charset: TFontCharset;
    Color: TColor;
    Height: Integer;
    NameLen: Integer;
    Pitch: TFontPitch;
    Size: Integer;
    Style: TFontStyles;
  end;

  T3KBitMaps = record
    UpLen: Integer;
    DownLen: Integer;
    HotLen: Integer;
    DisabledLen: Integer;
  end;
//--控件
  T3KBImage = record
    ImageLen: Integer;
  end;
  T3KTreeView = record
    Base: T3KBase;
    Font: T3KFont;
    Color: TColor;
  end;
  T3KButton = record
    Base: T3KBase;
    BitMaps: T3KBitMaps;
  end;
  T3KCheckBox = record
    Base: T3KBase;
    Font: T3KFont;
    FrameColor: TColor;
    HotTrackColor: TColor;
  end;
  T3KLabel = record
    Base: T3KBase;
    Font: T3KFont;
    Color1: TColor;  //连接成功颜色
    Color2: TColor;  //连接失败颜色
  end;
  T3KCombobox = record
    Base: T3KBase;
    Font: T3KFont;
    bColor: TColor; //背景颜色
  end;
  T3KRzCombobox = record
    Base: T3KBase;
    Font: T3KFont;
    bColor: TColor;
    FrameColor: TColor;
  end;
  T3KWebBrowser = record
    Base: T3KBase;
  end;
  T3KImageProgressBar = record
    Base: T3KBase;
    BarImageLen: Integer;
    BfBarImageLen: Integer;
  end;
  T3KRzProgressBar = record
    Base: T3KBase;
    BarStyle: TBarStyle;
    BackColor: TColor;
    FlatColor: TColor;
    BarColor: TColor;
  end;

  //----
  TTrialRun = record
    boTreeVisble: Boolean;
    boProgressBar1Visible: Boolean;
    boProgressBar2Visible: Boolean;
    nWebWidth: Integer;
    boTrialRun: Boolean;
  end;
const
  g_Version = 0;//1为1.76版本



  GameMonName = 'QKGameMonList.txt';
  FilterFileName = 'GameFilterItemNameList.txt';
  {$IF g_Version = 1}
  g_sProductName: string = 'CC290B30788530C7104AA0826BA7DD2CDA1AA7E62A68B79E9C6E0CAF85FC8EE4A69175BA8918A3E7'; //3KM2 1.76登陆器VIP配置器(Client)
  {$ELSE}
  g_sProductName: string = 'CC290B30788530C7104AA0826BA7DD2CDA1AA7E62A68B79EB409FA1EF74D4BA9A69175BA8918A3E7'; //3KM2 连击登陆器VIP配置器(Client)
  {$IFEND}
  g_sVersion = 'CC62A57A896CDBAA2F344FC7EADF5DF9C5C3C9374D92394E';  //2.00 Build 20120515
  g_sUpDateTime = '76D7AFDCFDB49101CF3ABB7DBC68FB4D'; //2012/05/18
  g_sProgram = 'BF329B13CBE9010C601B4C1E88011620'; //3K科技
  g_sWebSite = '92A51ADA62A0738AC5DB86D6E7E9CDE140574B5A981AB1753188062D144466D7'; // http://www.3KM2.com(官网站)
  g_sBbsSite = '6136601E4431B32C60BFBF8207DB95FA40574B5A981AB1753188062D144466D7'; //http://www.3KM2.net(程序站)
  g_sServerAdd = '9BECFDD8143865D3B2B818A56E2743A02BF1CB066D8203D3'; //vip.3Km2.com
  g_sFtpServerAdd = '9BECFDD8143865D343B34FE6E6685A948DA9ED19FDBAEDB1'; //ftp.3km2.com
  g_sFtpUser = 'AA6591AB9081007292D5A33CDA5DC193';//56m2vip
  g_sFtpPass = '8F618E113AFF24F7AEB6A37AADB53431ECB7CB18A523A87F'; //werks%*&@&@#

  _sProductAddress ='224B21DC4825956E209CC996D0C2121800B4F4692E0C07EF7CF957402C49244906B327DBB14599B7';//http://notice.3km2.com/version.xml 放特殊指令的文本
  _sProductAddressBak ='224B21DC4825956E209CC996D0C21218C315B9FB5F3048F57CF957402C49244906B327DBB14599B7';//备用网站 http://notice.66h6.com/version.xml 放特殊指令的文本
  _sProductAddress1 ='{{{"5>a>"oca"ob';//www.92m2.com.cn //改版权指令(文本里需加密),即网站文本第一行内容
  {$IF g_Version = 1}
  g_sVersionNum = '7C72039B3FB2617CA2EF55A91686646F';//20110130 //1.76本配置器的版本号
  {$ELSE}
  g_sVersionNum = '7C72039B3FB2617CA2EF55A91686646F';//20110130 //本配置器的版本号
  {$IFEND}
  //CLIENT_USEPE = 1;//登陆器使用壳标识 0-VMP 1-WL
  (*文本内容
{{{"5>a>"oca"ob
本站网站已经修改成XXXXXX|登陆不进去的用户请从新网站从新下载商业配置器
*)
var
  g_MySelf: TUserInfo;
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
  g_FilterItemList: TList; //过滤列表
  g_ConnectLabelColor: TColor = clLime;
  g_DisconnectLabelColor: TColor = clRed;
  g_TrialRun: TTrialRun;
function LoadItemsDB: Integer;
function GetFilterItemType(ItemType: TFilterItemType): string;
function FindFilterItemName(sItemName: string): string;
procedure UnLoadFilterItemList;
procedure LoadFilterItemList(sFileName: string);
procedure SaveFilterItemList(sFileName: string);

function MakeBitmapIntoString(const sInfo:TGraphic):string;
function MakeStringIntoBitmap(const sBitmapString:String): TStringStream;
function WriteGuiBase(Sender: TObject): T3KBase;
procedure ReadGuiBase(ABase: T3KBase; Sender: TObject);
function WriteGuiFont(AFont: TFont): T3KFont;
procedure ReadGuiFont(AFont: T3KFont; BFont: TFont);
procedure WriteGuiBitMaps(FileStream: TFileStream; Btn: TRzButtonBitmaps; bfBtn: T3KButton);
procedure ReadGuiBitMaps(FileStream: TFileStream; ABitMaps: T3KBitMaps; BitMaps: TRzButtonBitmaps);
function getXmlNodeValue(strEntityEngineFile: string; xmlNodePath: string;
  const xmlattrname: string = ''; const dep: Char = '.'): string;

implementation
uses MakeLogin, uDesignMain, XMLIntf, XMLDoc;
procedure SaveFilterItemList(sFileName: string);
  function BoolToInt(boBoolean: Boolean): Integer;
  begin
    if boBoolean then Result := 1 else Result := 0;
  end;
var
  I: Integer;
  SaveList: TStringList;
  FilterItem: pTFilterItem;
begin
  if g_FilterItemList = nil then Exit;
  SaveList := TStringList.Create;
  try
    SaveList.Add(';3K引擎盛大挂过滤配置文件');
    SaveList.Add(';物品类型'#9'物品名称'#9'极品显示'#9'自动捡取'#9'显示名称');
    for I := 0 to g_FilterItemList.Count - 1 do begin
      FilterItem := pTFilterItem(g_FilterItemList.Items[I]);
      SaveList.Add(IntToStr(Integer(FilterItem.ItemType)) + #9 + FilterItem.sItemName + #9 +
        IntToStr(BoolToInt(FilterItem.boHintMsg)) + #9 + IntToStr(BoolToInt(FilterItem.boPickup)) + #9 + IntToStr(BoolToInt(FilterItem.boShowName)));
    end;
    //sFileName := ExtractFilePath(Application.ExeName) + 'FilterItemList.txt';
    //sFileName := CreateUserDirectory + 'FilterItemList.Dat';
    try
      SaveList.SaveToFile(sFileName);
      Application.MessageBox(PChar(sFileName+'保存完成！'), '提示', MB_OK + MB_ICONINFORMATION);
    except
      Application.MessageBox(PChar(sFileName+'保存失败！'), 'Error', MB_OK + MB_ICONSTOP);
    end;
  finally
    SaveList.Free;
  end;
end;

procedure LoadFilterItemList(sFileName: string);
var
  I: Integer;
  LoadList: TStringList;
  FilterItem: pTFilterItem;
  sLineText, sItemType, sItemName, sHint, sPick, sShow: string;
  nType: Integer;
begin
  UnLoadFilterItemList;
  g_FilterItemList := TList.Create;
  LoadList := TStringList.Create;
  try
    if FileExists(sFileName) then begin
      try
        LoadList.LoadFromFile(sFileName);
      except
        LoadList.Clear;
      end;
      if LoadList.Count > 0 then begin
        for I := 0 to LoadList.Count - 1 do begin
          sLineText := Trim(LoadList.Strings[I]);
          if sLineText = '' then Continue;
          if (sLineText <> '') and (sLineText[1] = ';') then Continue;
          sLineText := GetValidStr3(sLineText, sItemType, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sHint, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sPick, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sShow, [' ', #9]);
          nType := Str_ToInt(sItemType, -1);
          if (nType in [0..6]) and (sItemName <> '') then begin
            New(FilterItem);
            FilterItem.ItemType := TFilterItemType(nType);
            FilterItem.sItemName := sItemName;
            FilterItem.boHintMsg := sHint = '1';
            FilterItem.boPickup := sPick = '1';
            FilterItem.boShowName := sShow = '1';
            g_FilterItemList.Add(FilterItem);
          end;
        end;
       FrmMakeLogin.RefListViewFilterItem(i_All);
      end;
    end;
  finally
    LoadList.Free;
  end;
end;

function FindFilterItemName(sItemName: string): string;
var
  I: Integer;
begin
  Result := '';
  if g_FilterItemList = nil then Exit;
  for I := 0 to g_FilterItemList.Count - 1 do begin
    if CompareText(pTFilterItem(g_FilterItemList.Items[I]).sItemName, sItemName) = 0 then begin
      Result := pTFilterItem(g_FilterItemList.Items[I]).sItemName;
      Break;
    end;
  end;
end;
function GetFilterItemType(ItemType: TFilterItemType): string;
begin
  case ItemType of
    i_Other: Result := '其它类';
    i_HPMPDurg: Result := '药品类';
    i_Dress: Result := '服装类';
    i_Weapon: Result := '武器类';
    i_Jewelry: Result := '首饰类';
    i_Decoration: Result := '饰品类';
    i_Decorate: Result := '装饰类';
  end;
end;

procedure UnLoadFilterItemList;
var
  I: Integer;
begin
  if g_FilterItemList = nil then Exit;
  for I := 0 to g_FilterItemList.Count - 1 do begin
    Dispose(pTFilterItem(g_FilterItemList.Items[I]));
  end;
  FreeAndNil(g_FilterItemList);
end;

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



function MakeBitmapIntoString(const sInfo:TGraphic):string;
var
  ass:TStringStream;
begin
  ass:=TStringStream.Create('');
  try
    sInfo.SaveToStream(ass);
    Result:=EncodeString(ass.DataString);
  finally
    ass.Free;
  end;
end;

function MakeStringIntoBitmap(const sBitmapString:String): TStringStream;
var 
  ass:TStringStream;
begin
  ass:=TStringStream.Create(DecodeString(sBitmapString));
  try
    Result := ass;
  finally 
   // ass.Free;
  end;
end;

function WriteGuiBase(Sender: TObject): T3KBase;
begin
  Result.Left := TWinControl(Sender).Left;
  Result.Top := TWinControl(Sender).Top - FrmDesignMain.Panel2.Height;
  Result.Width := TWinControl(Sender).Width;
  Result.Height := TWinControl(Sender).Height;
//  Result.Visible := TWinControl(Sender).ShowHint;
end;

procedure ReadGuiBase(ABase: T3KBase; Sender: TObject);
begin
  TWinControl(Sender).Left := ABase.Left;
  TWinControl(Sender).Top := ABase.Top + FrmDesignMain.Panel2.Height;
  TWinControl(Sender).Width := ABase.Width;
  TWinControl(Sender).Height := ABase.Height;
//  TWinControl(Sender).ShowHint := ABase.Visible;
end;

function WriteGuiFont(AFont: TFont): T3KFont;
begin
  Result.Charset := AFont.Charset;
  Result.Color := AFont.Color;
  Result.Height := AFont.Height;
  Result.NameLen := Length(AFont.Name);
  Result.Pitch := AFont.Pitch;
  Result.Size := AFont.Size;
  Result.Style := AFont.Style;
end;

procedure ReadGuiFont(AFont: T3KFont; BFont: TFont);
begin
  BFont.Charset := AFont.Charset;
  BFont.Color := AFont.Color;
  BFont.Height := AFont.Height;
  BFont.Pitch := AFont.Pitch;
  BFont.Size := AFont.Size;
  BFont.Style := AFont.Style;
end;

procedure WriteGuiBitMaps(FileStream: TFileStream; Btn: TRzButtonBitmaps; bfBtn: T3KButton);
var
  sUp, sDown, sHot, sDisabled: string; //Btn
begin
  if Btn.Up <> nil then begin
    sUp := MakeBitmapIntoString(Btn.Up);
    bfBtn.BitMaps.UpLen := Length(sUp);
  end;
  if Btn.Down <> nil then begin
    sDown := MakeBitmapIntoString(Btn.Down);
    bfBtn.BitMaps.DownLen := Length(sDown);
  end;
  if Btn.Hot <> nil then begin
    sHot := MakeBitmapIntoString(Btn.Hot);
    bfBtn.BitMaps.HotLen := Length(sHot);
  end;
  if Btn.Disabled <> nil then begin
    sDisabled := MakeBitmapIntoString(Btn.Disabled);
    bfBtn.BitMaps.DisabledLen := Length(sDisabled);
  end;
  FileStream.Write(bfBtn, SizeOf(T3KButton));
  if bfBtn.BitMaps.UpLen > 0 then begin
    FileStream.Write(sUp[1], bfBtn.BitMaps.UpLen);
  end;
  if bfBtn.BitMaps.DownLen > 0 then begin
    FileStream.Write(sDown[1], bfBtn.BitMaps.DownLen);
  end;
  if bfBtn.BitMaps.HotLen > 0 then begin
    FileStream.Write(sHot[1], bfBtn.BitMaps.HotLen);
  end;
  if bfBtn.BitMaps.DisabledLen > 0 then begin
    FileStream.Write(sDisabled[1], bfBtn.BitMaps.DisabledLen);
  end;
end;

procedure ReadGuiBitMaps(FileStream: TFileStream; ABitMaps: T3KBitMaps; BitMaps: TRzButtonBitmaps);
var
  sText: string;
begin
  if ABitMaps.UpLen > 0 then begin
    SetLength(sText, ABitMaps.UpLen);
    FileStream.Read(sText[1], ABitMaps.UpLen);
    Bitmaps.Up.LoadFromStream(MakeStringIntoBitmap(sText));
    MakeStringIntoBitmap(sText).Free;
    SetLength(sText, 0);
  end;
  if ABitMaps.DownLen > 0 then begin
    SetLength(sText, ABitMaps.DownLen);
    FileStream.Read(sText[1], ABitMaps.DownLen);
    Bitmaps.Down.LoadFromStream(MakeStringIntoBitmap(sText));
    MakeStringIntoBitmap(sText).Free;
    SetLength(sText, 0);
  end;
  if ABitMaps.HotLen > 0 then begin
    SetLength(sText, ABitMaps.HotLen);
    FileStream.Read(sText[1], ABitMaps.HotLen);
    Bitmaps.Hot.LoadFromStream(MakeStringIntoBitmap(sText));
    MakeStringIntoBitmap(sText).Free;
    SetLength(sText, 0);
  end;
  if ABitMaps.DisabledLen > 0 then begin
    SetLength(sText,ABitMaps.DisabledLen);
    FileStream.Read(sText[1], ABitMaps.DisabledLen);
    Bitmaps.Disabled.LoadFromStream(MakeStringIntoBitmap(sText));
    MakeStringIntoBitmap(sText).Free;
    SetLength(sText, 0);
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
  xmlnodeList.Free;
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
