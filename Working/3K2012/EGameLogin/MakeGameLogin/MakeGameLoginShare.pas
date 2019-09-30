unit MakeGameLoginShare;

interface
uses Windows, Messages, Classes, DBTables, SysUtils, HUtil32, Dialogs;
Type
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
const
  FilterFileName = 'GameFilterItemNameList.txt';
  TzHintList = 'TzHintList.txt';
  GameMonName = 'QKGameMonList.txt';
  g_sVersion = '9EF6E8B6AFDDC9112F344FC7EADF5DF9C5C3C9374D92394E';////////////2.00 Build 20121015
  g_sUpDateTime = 'A19DA0E9AD8A7CF7CF3ABB7DBC68FB4D';/////////////2012/10/15
  g_sProgram = '2F78A1AC5432FFAA0A64AD4A01FBC2E8'; //3K引擎
  g_sWebSite = '92A51ADA62A0738AC5DB86D6E7E9CDE140574B5A981AB1753188062D144466D7'; //http://www.3KM2.com(官网站)
  g_sBbsSite = '6136601E4431B32C60BFBF8207DB95FA40574B5A981AB1753188062D144466D7'; //http://www.3KM2.net(程序站)

  GVersion = 2;      //0为连击版, 1为0627版 ,2为1.76版本

  {$IF GVersion = 1}
  g_sProductName: string = 'E14A1EC77CDEF28AF45799A3753D3C5020DD90E9CB1342BAEA8C46B85879AAD413D803ECF93E40BF08F88DB81913645E';
  //3K引擎免费登陆器配置器(非连击0627版)
  {$ELSEIF GVersion = 2}
  g_sProductName: string = '1523EBD346918F79E64FFAB6A66DDD19EA8C46B85879AAD413D803ECF93E40BF859889855D9356C3';
  //3K引擎免费登陆器配置器(1.76版)
  {$ELSE}
  g_sProductName: string = '1523EBD346918F79D9D0E4296A0746E9EA8C46B85879AAD413D803ECF93E40BF859889855D9356C3';
  //3K引擎免费登陆器配置器(连击版)
  {$IFEND}
var
  StdItemList: TList; //List_54
  Query: TQuery;
  g_FilterItemList: TList; //过滤列表
procedure ReleaseRes(const ResName, ResType, FileName: PChar);

function LoadItemsDB: Integer;
function RandomGetName():string;
function encrypt(const s:string; skey:string):string;
function CertKey(key: string): string;
function GetFilterItemType(ItemType: TFilterItemType): string;
procedure LoadFilterItemList(sFileName: string);
procedure UnLoadFilterItemList;
function FindFilterItemName(sItemName: string): string;
procedure SaveFilterItemList(sFileName: string);
implementation
uses Main;

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
      //Application.MessageBox(PChar(sFileName+'保存完成！'), '提示', MB_OK + MB_ICONINFORMATION);
      MainFrm.Mes.MessageDlg(PChar(sFileName+'保存完成！'),mtInformation,[mbOK],0);
    except
      MainFrm.Mes.MessageDlg(PChar(sFileName+'保存失败！'),mtError,[mbOK],0);
    end;
  finally
    SaveList.Free;
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
       MainFrm.RefListViewFilterItem(i_All);
      end;
    end;
  finally
    LoadList.Free;
  end;
end;

//释放资源文件
procedure ReleaseRes(const ResName, ResType, FileName: PChar);
var
  HResource, HGlobal, HFile: THandle;
  FSize, WSize: DWORD;
  FMemory: Pointer;
begin
  HResource := FindResource(HInstance, ResName, ResType);
  if (HResource = 0) then Exit;
  HGlobal := LoadResource(HInstance, HResource);
  if (HGlobal = 0) then Exit;
  FMemory := LockResource(HGlobal);
  if (FMemory = nil) then
  begin
    FreeResource(HGlobal);
    Exit;
  end;
  HFile := CreateFile(FileName, GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile = INVALID_HANDLE_VALUE) then
  begin
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
    Exit;
  end;
  FSize := SizeOfResource(HInstance, HResource);
  WriteFile(HFile, FMemory^, FSize, Wsize, nil);
  if (FSize <> Wsize) then
  begin
    UnlockResource(HGlobal);
    FreeResource(HGlobal);
    Exit;
  end;
  SetEndofFile(HFile);
  CloseHandle(HFile);
  UnlockResource(HGlobal);
  FreeResource(HGlobal);
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
//随机取名
function RandomGetName():string;
var
  s,s1:string;
  I,i0:integer;
begin
    s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
    s1:='';
    for i:=0 to 6 do
    begin
      i0:=random(35);
      s1:=s1+copy(s,i0,1);
    end;
    Result := s1;
end;
{******************************************************************************}
//加密字符串函数
function myStrtoHex(s: string): string;
var tmpstr:string;
    i:integer;
begin
    tmpstr := '';
    for i:=1 to length(s) do
    begin
        tmpstr := tmpstr + inttoHex(ord(s[i]),2);
    end;
    result := tmpstr;
end;

function myHextoStr(S: string): string;
var hexS,tmpstr:string;
    i:integer;
    a:byte;
begin
    hexS  :=s;//应该是该字符串
    if length(hexS) mod 2=1 then
    begin
        hexS:=hexS+'0';
    end;
    tmpstr:='';
    for i:=1 to (length(hexS) div 2) do
    begin
        a:=strtoint('$'+hexS[2*i-1]+hexS[2*i]);
        tmpstr := tmpstr+chr(a);
    end;
    result :=tmpstr;
end;

//加密
function encrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS   :=myStrtoHex(s);
    hexskey:=myStrtoHex(skey);
    midS   :=hexS;
    for i:=1 to (length(hexskey) div 2)   do
    begin
        if i<>1 then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := tmpstr;
end;
{******************************************************************************}
//解密密钥
function CertKey(key: string): string;
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;
{******************************************************************************}
end.
