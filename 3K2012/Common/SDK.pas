unit SDK;

interface
uses
  Windows, SysUtils, Classes, Grobal2;
const
  MAXPULGCOUNT = 20;

  sROAUTORUN = '#AUTORUN';
  sRONPCLABLEJMP = 'NPC';
  nRONPCLABLEJMP = 100;
  sRODAY = 'DAY';
  nRODAY = 200;
  sROHOUR = 'HOUR';
  nROHOUR = 201;
  sROMIN = 'MIN';
  nROMIN = 202;
  sROSEC = 'SEC';
  nROSEC = 203;
  sRUNONWEEK = 'RUNONWEEK'; //指定星期几运行
  nRUNONWEEK = 300;
  sRUNONDAY = 'RUNONDAY'; //指定几日运行
  nRUNONDAY = 301;
  {sRUNONHOUR = 'RUNONHOUR'; //指定小时运行  //20080818 注释
  nRUNONHOUR = 302;
  sRUNONMIN = 'RUNONMIN'; //指定分钟运行
  nRUNONMIN = 303;
  sRUNONSEC = 'RUNONSEC';
  nRUNONSEC = 304; } 

type
  //TOpType = (o_NPC);//20080917 未使用
  TAutoRunInfo = record
    dwRunTick: LongWord; //上一次运行时间记录
    dwRunTimeLen: LongWord; //运行间隔时间长
    nRunCmd: Integer; //自动运行类型
    nMoethod: Integer;
    sParam1: string; //运行脚本标签
    sParam2: string; //传送到脚本参数内容
    sParam3: string;
    sParam4: string;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    nParam4: Integer;
    boStatus: Boolean;
  end;
  pTAutoRunInfo = ^TAutoRunInfo;

  TProcArrayInfo = record
    sProcName: string;
    nProcAddr: Pointer;
    nProcCode: Integer;
  end;
  pTProcArrayInfo = ^TProcArrayInfo; 

  TObjectArrayInfo = record
    Obj: TObject;
    sObjcName: string;
    nObjcCode: Integer;
  end;
  pTObjectArrayInfo = ^TObjectArrayInfo;

  TProcArray = array[0..MAXPULGCOUNT - 1] of TProcArrayInfo;
  TObjectArray = array[0..MAXPULGCOUNT - 1] of TObjectArrayInfo;

  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
  //TFindProc = function(ProcName: PChar; nNameLen: Integer; nProcCode: Integer): Pointer; stdcall;
  TFindProc = function(ProcName: PChar; nNameLen: Integer): Pointer; stdcall;//20080729 修改
  //TSetProc = function(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer; nProcCode: Integer): Boolean; stdcall;
  TSetProc = function(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean; stdcall;//20080729 修改
  TFindObj = function(ObjName: PChar; nNameLen: Integer; nObjcCode: Integer): TObject; stdcall;
  TStartPlug = function(): Boolean; stdcall;
  TSetStartPlug = function(StartPlug: TStartPlug): Boolean; stdcall;
  TGetFunAddr = function(nIndex: Integer): Pointer; stdcall;//20080729 增加

  //TPlugInit = function(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; FindObj: TFindObj): PChar; stdcall;
  TPlugInit = function(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;//20080729 修改
  TClassProc = procedure(Sender: TObject);
  TStartProc = procedure(); stdcall;
  TStartRegister = function(sRegisterInfo, sUserName: PChar): Integer; stdcall;{20071108}
  TGetStrProc = procedure(sRegisterCode: PChar); stdcall;
  TGameDataLog = function(ProcName: PChar; nNameLen: Integer): Boolean; stdcall;
  TIPLocal = procedure(sIPaddr: PChar; sLocal: PChar; nLocalLen: Integer); stdcall;
  TDeCryptString = procedure(Src: PChar; Dest: PChar; nSrc: Integer); stdcall; {20071111}
  TGetDateIP= procedure(Src: PChar; Dest: PChar); stdcall; {20080217 脚本解密函数,SystemModule.dll输出}
  TGetSysDate =  function(Dest: PChar): Boolean; stdcall;//20081203  SystemModule.dll输出,检查是否为3K插件
  TGetIPString = function (): Boolean; stdcall;//20081016 脚本插件函出判断是否注册信息
  TGetProductAddress = function(Src0: PChar): Boolean; stdcall;//访问指定网站文本,如果为特殊指令,则在M2上显示相关信息(输出由M2调用) 20081018
  TGetHintInfAddress = function(Src0: PChar): Boolean; stdcall;//访问指定网站文本,取广告

  TGetProcInt = function(): PChar; stdcall; {20071108}
{20071106 begin}
{  TRunSocketObject_Open = procedure(GateIdx, nSocket: Integer; sIPaddr: PChar); stdcall;//20080813 注释
  TRunSocketObject_Close = procedure(GateIdx, nSocket: Integer); stdcall;
  TRunSocketObject_Eeceive_OK = procedure(); stdcall;
  TRunSocketObject_Data = procedure(GateIdx, nSocket: Integer; MsgBuff: PChar); stdcall; }
{20071106 end}
{  TShortString = packed record
    btLen: Byte;
    Strings: array[0..High(Byte) - 1] of Char;
  end;
  PTShortString = ^TShortString;

  _TBANKPWD = string[6];
  _LPTBANKPWD = ^_TBANKPWD;
  _TMAPNAME = string[MAPNAMELEN];
  _LPTMAPNAME = ^_TMAPNAME;
  _TACTORNAME = string[ACTORNAMELEN];
  _LPTACTORNAME = ^_TACTORNAME;
  _TPATHNAME = string[MAXPATHLEN];
  _LPTPATHNAME = ^_TPATHNAME;
  //_TDIRNAME = string[DIRPATHLEN];//20080729 注释
  //_LPTDIRNAME = ^_TDIRNAME;//20080729 注释

  TObjectAction = procedure(PlayObject: TObject); stdcall;
  TObjectActionEx = function(PlayObject: TObject): BOOL; stdcall;
  TObjectActionXY = procedure(AObject, BObject: TObject; nX, nY: Integer); stdcall;
  TObjectActionXYD = procedure(AObject, BObject: TObject; nX, nY: Integer; btDir: Byte); stdcall;
  TObjectActionXYDM = procedure(AObject, BObject: TObject; nX, nY: Integer; btDir: Byte; nMode: Integer); stdcall;
  TObjectActionXYDWS = procedure(AObject, BObject: TObject; wIdent: Word; nX, nY: Integer; btDir: Byte; pszMsg: PChar); stdcall;
  TObjectActionObject = procedure(AObject, BObject, CObject: TObject; nInt: Integer); stdcall;
  TObjectActionDetailGoods = procedure(Merchant: TObject; PlayObject: TObject; pszItemName: PChar; nInt: Integer); stdcall;
  TObjectActionUserSelect = procedure(Merchant: TObject; PlayObject: TObject; pszLabel, pszData: PChar); stdcall;//***

  TObjectUserCmd = function(AObject: TObject; pszCmd, pszParam1, pszParam2, pszParam3, pszParam4, pszParam5, pszParam6, pszParam7: PChar): Boolean; stdcall;
  TPlaySendSocket = function(AObject: TObject; DefMsg: pTDefaultMessage; pszMsg: PChar): Boolean; stdcall;
  TObjectActionItem = function(AObject: TObject; pszItemName: PChar; boHintMsg: Boolean): Boolean; stdcall;
  TObjectClientMsg = function(PlayObject: TObject; DefMsg: pTDefaultMessage; Buff: PChar; NewBuff: PChar): Integer; stdcall;
  TObjectActionFeature = function(AObject, BObject: TObject): Integer; stdcall;
  TObjectActionSendGoods = procedure(AObject: TObject; nNpcRecog, nCount, nPostion: Integer; pszData: PChar); stdcall;
  TObjectActionCheckUserItem = function(nIdx: Integer; StdItem: pTStdItem): Boolean; stdcall;
  TObjectActionEnterMap = function(AObject: TObject; Envir: TObject; nX, nY: Integer): Boolean; stdcall;
  TObjectFilterMsg = function(PlayObject: TObject; pszSrcMsg, pszDestMsg: PChar): Boolean; stdcall; //20071113 修改

  //TEDCode = procedure(pszSource: PChar; pszDest: PChar; nSrcLen, nDestLen: Integer); stdcall;
  TDoSpell = function(MagicManager: TObject; PlayObject: TObject; UserMagic: pTUserMagic; nTargetX, nTargetY: Integer; TargeTBaseObject: TObject; var boSpellFail, boSpellFire: Boolean): Boolean; stdcall;

  TScriptCmd = function(pszCmd: PChar): Integer; stdcall;

  TScriptAction = procedure(NPC: TObject;
    PlayObject: TObject;
    nCMDCode: Integer;
    pszParam1: PChar;
    nParam1: Integer;
    pszParam2: PChar;
    nParam2: Integer;
    pszParam3: PChar;
    nParam3: Integer;
    pszParam4: PChar;
    nParam4: Integer;
    pszParam5: PChar;
    nParam5: Integer;
    pszParam6: PChar;
    nParam6: Integer); stdcall;

  TScriptCondition = function(NPC: TObject;
    PlayObject: TObject;
    nCMDCode: Integer;
    pszParam1: PChar;
    nParam1: Integer;
    pszParam2: PChar;
    nParam2: Integer;
    pszParam3: PChar;
    nParam3: Integer;
    pszParam4: PChar;
    nParam4: Integer;
    pszParam5: PChar;
    nParam5: Integer;
    pszParam6: PChar;
    nParam6: Integer): Boolean; stdcall;

  TObjectOperateMessage = function(BaseObject: TObject;
    wIdent: Word;
    wParam: Word;
    nParam1: Integer;
    nParam2: Integer;
    nParam3: Integer;
    MsgObject: TObject;
    dwDeliveryTime: LongWord;
    pszMsg: PChar;
    var boReturn: Boolean): Boolean; stdcall;   }

  {===================================TGList===================================}

  TGList = class(TList)
  private
    CriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  {=================================TGStringList================================}
  TGStringList = class(TStringList)
  private
    CriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;

  TSellOffGoodList = class
  private
    FRecCount: Cardinal;
    FUpDateSellOff: Boolean;
    m_nChangeCount: Integer;
    m_SellOffGoodList: TGList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadSellOffGoodList();
    procedure UnLoadSellOffGoodList();
    procedure GetSellOffGoodList(var SellOffList: TList);
    procedure GetUserSellOffGoodListByChrName(sChrName: string; var SellOffList: TList);
    procedure GetUserSellOffGoodListByItemName(sItemName: string; var SellOffList: TList);
    procedure GetUserSellOffGoodListByMakeIndex(nMakeIndex: Integer; var SellOffInfo: pTSellOffInfo);
    procedure GetUserSellOffItem(sItemName: string; nMakeIndex: Integer; var SellOffInfo: pTSellOffInfo; var StdItem: pTStdItem);
    function GetUserSellOffCount(sCharName: string): Integer;
    //function GetUserLimitSellOffCount(sCharName: string): Boolean; //20080504 去掉拍卖功能
    procedure GetUserSellOffListByIndex(nIndex: Integer; var SellOffList: TList);
    function AddItemToSellOffGoodsList(SellOffInfo: pTSellOffInfo): Boolean;
    function DelSellOffItem(nMakeIndex: Integer): Boolean;
    function SaveSellOffGoodList(): Boolean;
  published
    property RecCount: Cardinal read FRecCount write FRecCount;
    property UpDateSellOff: Boolean read FUpDateSellOff write FUpDateSellOff;
  end;

  TSellOffGoldList = class
  private
    FRecCount: Cardinal;
    FUpDateSellOff: Boolean;
    m_nChangeCount: Integer;
    m_SellOffGoldList: TGList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadSellOffGoldList();
    procedure UnLoadSellOffGoldList();
    procedure GetUserSellOffGoldListByChrName(sChrName: string; var SellOffList: TList);
    function AddItemToSellOffGoldList(SellOffInfo: pTSellOffInfo): Boolean;
    function DelSellOffGoldItem(nMakeIndex: Integer): Boolean;
    function SaveSellOffGoldList(): Boolean;
  published
    property RecCount: Cardinal read FRecCount write FRecCount;
    property UpDateSellOff: Boolean read FUpDateSellOff write FUpDateSellOff;
  end;

  //==============================================================================
  TStorage = class
  private
    FRecordCount: Cardinal;
    FHumManCount: Cardinal;
    m_ItemCount: TItemCount;
  public
    m_StorageList: TGStringList;
    constructor Create;
    destructor Destroy; override;
    procedure LoadBigStorageList(const sFileName: string);
    procedure UnLoadBigStorageList();
    function GetUserBigStorageList(sChrName: string): TList;
    function Add(var StorageList: TList; sChrName: string; UserItem: pTUserItem): Boolean;
    function Delete(var StorageList: TList; sItemName: string; nMakeIndex: Integer): Boolean;
    function GetItem(StorageList: TList; sItemName: string; nMakeIndex: Integer; var UserItem: TUserItem): Boolean;
    procedure SaveToFile(const sFileName: string);
  published
    property RecordCount: Cardinal read FRecordCount write FRecordCount;
    property HumManCount: Cardinal read FHumManCount write FHumManCount;
  end;
  {=================================TSortStringList================================}

  TSortStringList = class(TGStringList)
  public
    procedure StringSort(Order: Boolean);
    procedure ObjectSort(Order: Boolean);
  end;

  TSStringList = class(TGStringList)
  public
    procedure QuickSort(Order: Boolean);
  end;
implementation
uses ItmUnit, UsrEngn, M2Share, HUtil32;


procedure TSStringList.QuickSort(Order: Boolean); //速度更快的排行
  procedure QuickSortStrListCase(List: TStringList; l, r: Integer);
  var
    I, j: Integer;
    p: string;
  begin
    if List.Count <= 0 then Exit;
    repeat
      I := l;
      j := r;
      p := List[(l + r) shr 1];
      repeat
        if Order then begin //升序
          while CompareStr(List[I], p) < 0 do Inc(I);
          while CompareStr(List[j], p) > 0 do Dec(j);
        end else begin //降序
          while CompareStr(p, List[I]) < 0 do Inc(I);
          while CompareStr(p, List[j]) > 0 do Dec(j);
        end;
        if I <= j then begin
          List.Exchange(I, j);
          Inc(I);
          Dec(j);
        end;
      until I > j;
      if l < j then QuickSortStrListCase(List, l, j);
      l := I;
    until I >= r;
  end;
  procedure AddList(TempList: TStringList; slen: string; s: string; AObject: TObject);
  var
    I: Integer;
    List: TStringList;
    boFound: Boolean;
  begin
    boFound := False;
    if TempList.Count > 0 then begin//20080630
      for I := 0 to TempList.Count - 1 do begin
        if CompareText(TempList.Strings[I], slen) = 0 then begin
          List := TStringList(TempList.Objects[I]);
          List.AddObject(s, AObject);
          boFound := True;
          Break;
        end;
      end;
    end;
    if not boFound then begin
      List := TStringList.Create;
      List.AddObject(s, AObject);
      TempList.AddObject(slen, List);
    end;
  end;
var
  TempList: TStringList;
  List: TStringList;
  I: Integer;
  nLen: Integer;
begin
  TempList := TStringList.Create;
  for I := 0 to Self.Count - 1 do begin
    nLen := Length(Self.Strings[I]);
    AddList(TempList, IntToStr(nLen), Self.Strings[I], Self.Objects[I]);
  end;
  QuickSortStrListCase(TempList, 0, TempList.Count - 1);
  Self.Clear;
  for I := 0 to TempList.Count - 1 do begin
    List := TStringList(TempList.Objects[I]);
    QuickSortStrListCase(List, 0, List.Count - 1);
    Self.AddStrings(List);
    List.Free;
  end;
  TempList.Free;
end;

{ TBigStorage }

constructor TStorage.Create;
begin
  FRecordCount := 0;
  FHumManCount := 0;
  m_StorageList := TGStringList.Create;
  FillChar(m_ItemCount, SizeOf(TItemCount), #0);
end;

destructor TStorage.Destroy;
begin
  UnLoadBigStorageList();
  m_StorageList.Free;
end;
//读取无限仓库数据
procedure TStorage.LoadBigStorageList(const sFileName: string);
var
  I: Integer;
  FileHandle: Integer;
  List: TList;
  BigStorage: pTBigStorage;
  ItemCount: TItemCount;
begin
  m_StorageList.Lock();
  try
    if FileExists(sFileName) then begin
      FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
     // List := nil;
      if FileHandle > 0 then begin
        if FileRead(FileHandle, ItemCount, SizeOf(TItemCount)) = SizeOf(TItemCount) then begin
          for I := 0 to ItemCount - 1 do begin
            New(BigStorage);
            FillChar(BigStorage.UseItems, SizeOf(TUserItem), #0);
            if (FileRead(FileHandle, BigStorage^, SizeOf(TBigStorage)) = SizeOf(TBigStorage)) and (not BigStorage.boDelete) then begin
              Inc(m_ItemCount);
              List := GetUserBigStorageList(BigStorage.sCharName);
              if List = nil then begin
                List := TList.Create;
                List.Add(BigStorage);
                m_StorageList.AddObject(BigStorage.sCharName, List);
              end else begin
                List.Add(BigStorage);
              end;
            end else begin
              Dispose(BigStorage); //By TasNat
                       BigStorage  := nil;
            end;
          end;
          FileClose(FileHandle);
        end;
      end;
    end else begin
      FileHandle := FileCreate(sFileName);
      if FileHandle > 0 then begin
        m_ItemCount := 0;
        FileWrite(FileHandle, m_ItemCount, SizeOf(TItemCount));
        FileClose(FileHandle);
      end;
    end;
    FRecordCount := m_ItemCount;
    FHumManCount := m_StorageList.Count;
  finally
    m_StorageList.UnLock();
  end;
end;

procedure TStorage.UnLoadBigStorageList();
var
  I, II: Integer;
  List: TList;
begin
  m_StorageList.Lock();
  try
    if m_StorageList.Count > 0 then begin//20080630
      for I := 0 to m_StorageList.Count - 1 do begin
        List := TList(m_StorageList.Objects[I]);
        if List <> nil then begin
          if List.Count > 0 then begin//20080630
            for II := 0 to List.Count - 1 do begin
              Dispose(List.Items[II]);
            end;
          end;
          FreeAndNil(List);
        end;
      end;
      m_StorageList.Clear;
    end;
  finally
    m_StorageList.UnLock();
  end;
end;

function TStorage.GetUserBigStorageList(sChrName: string): TList;
var
  I: Integer;
begin
  Result := nil;
  m_StorageList.Lock();
  try
    if m_StorageList.Count > 0 then begin//20080630
      for I := 0 to m_StorageList.Count - 1 do begin
        if CompareText(m_StorageList.Strings[I], sChrName) = 0 then begin
          Result := TList(m_StorageList.Objects[I]);
          Break;
        end;
      end;
    end;
  finally
    m_StorageList.UnLock();
  end;
end;

function TStorage.Add(var StorageList: TList; sChrName: string; UserItem: pTUserItem): Boolean;
var
  Storage: pTBigStorage;
begin
  Result := False;
  m_StorageList.Lock();
  try
    New(Storage);
    FillChar(Storage^.UseItems, SizeOf(TUserItem), #0);
    Storage^.boDelete := False;
    Storage^.sCharName := sChrName;
    Storage^.SaveDateTime := Now;
    Storage^.UseItems := UserItem^;
    if StorageList = nil then begin
      StorageList := TList.Create;
      m_StorageList.AddObject(sChrName, StorageList);
    end;
    StorageList.Add(Storage);
    Inc(m_ItemCount);
    Result := True;
  finally
    m_StorageList.UnLock();
  end;
end;

function TStorage.Delete(var StorageList: TList; sItemName: string; nMakeIndex: Integer): Boolean;
var
  I: Integer;
  Storage: pTBigStorage;
  sUserItemName: string;
begin
  Result := False;
  m_StorageList.Lock();
  try
    if StorageList <> nil then begin
      for I := StorageList.Count - 1 downto 0 do begin
        if StorageList.Count <= 0 then Break;//20080917
        Storage := pTBigStorage(StorageList.Items[I]);
        if (Storage.UseItems.MakeIndex = nMakeIndex) and (not Storage.boDelete) then begin
          sUserItemName := '';
          if Storage.UseItems.btValue[13] = 1 then
            sUserItemName := ItemUnit.GetCustomItemName(Storage.UseItems.MakeIndex, Storage.UseItems.wIndex);
          if sUserItemName = '' then
            sUserItemName := UserEngine.GetStdItemName(Storage.UseItems.wIndex);
          if CompareText(sUserItemName, sItemName) = 0 then begin
            StorageList.Delete(I);
            Dispose(Storage);
            Dec(m_ItemCount);
            Result := True;
            Break;
          end;
        end;
      end;
      if StorageList.Count <= 0 then begin
        for I := m_StorageList.Count - 1 downto 0 do begin
          if m_StorageList.Count <= 0 then Break;//20080917
          if m_StorageList.Objects[I] = StorageList then begin
            m_StorageList.Delete(I);
            FreeAndNil(StorageList);
            Break;
          end;
        end;
      end;
    end;
  finally
    m_StorageList.UnLock();
  end;
end;

function TStorage.GetItem(StorageList: TList; sItemName: string; nMakeIndex: Integer; var UserItem: TUserItem): Boolean;
var
  I: Integer;
  Storage: pTBigStorage;
  sUserItemName: string;
begin
  Result := False;
  m_StorageList.Lock();
  try
    if StorageList <> nil then begin
      if StorageList.Count > 0 then begin//20080630
        for I := 0 to StorageList.Count - 1 do begin
          Storage := pTBigStorage(StorageList.Items[I]);
          if (Storage.UseItems.MakeIndex = nMakeIndex) and (not Storage.boDelete) then begin
            sUserItemName := '';
            if Storage.UseItems.btValue[13] = 1 then
              sUserItemName := ItemUnit.GetCustomItemName(Storage.UseItems.MakeIndex, Storage.UseItems.wIndex);
            if sUserItemName = '' then
              sUserItemName := UserEngine.GetStdItemName(Storage.UseItems.wIndex);
            if CompareText(sUserItemName, sItemName) = 0 then begin
              UserItem := Storage.UseItems;
              Result := True;
              Break;
            end;
          end;
        end;//for
      end;
    end;
  finally
    m_StorageList.UnLock();
  end;
end;

procedure TStorage.SaveToFile(const sFileName: string);
var
  I, II: Integer;
  FileHandle: Integer;
  Storage: pTBigStorage;
  List: TList;
begin
  m_StorageList.Lock();
  try
    //if FileExists(sFileName) then DeleteFile(sFileName);
    FileHandle := FileCreate(sFileName);
    if FileHandle > 0 then begin
      {FillChar(ItemCount, SizeOf(TItemCount), #0);
      for i := m_StorageList.Count - 1 downto 0 do begin
        List := TList(m_StorageList.Objects[i]);
        if List <> nil then begin
          if List.Count <= 0 then begin
            FreeAndNil(List);
            m_StorageList.Delete(i);
            Continue;
          end;
          Inc(ItemCount, List.Count);
        end else m_StorageList.Delete(i);
      end;}
      FileSeek(FileHandle, 0, 0);
      FileWrite(FileHandle, m_ItemCount, SizeOf(TItemCount));
      if m_StorageList.Count > 0 then begin//20080630
        for I := 0 to m_StorageList.Count - 1 do begin
          List := TList(m_StorageList.Objects[I]);
          if List.Count > 0 then begin//20080630
            for II := 0 to List.Count - 1 do begin
              try//20091124 增加
                Storage := pTBigStorage(List.Items[II]);
                if Storage <> nil then begin//20090129
                  if (Storage.UseItems.AddValue[0] = 1) and (GetHoursCount(Storage.UseItems.MaxDate, Now) <= 0) then Continue;//过期物品则不保存
                  if not Storage.boDelete then begin
                    FileWrite(FileHandle, Storage^, SizeOf(TBigStorage));
                  end;
                end;
              except
              end;
            end;
          end;
        end;//for
      end;
      FileClose(FileHandle);
    end;
  finally
    m_StorageList.UnLock();
  end;
end;

{ TGList }
constructor TGList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

procedure TGList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TGList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

{ TGStringList }

constructor TGStringList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGStringList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

procedure TGStringList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TGStringList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

{TSellOffGoodList}


constructor TSellOffGoodList.Create;
begin
  inherited Create;
  FRecCount := 0;
  FUpDateSellOff := False;
  m_nChangeCount := 0;
  m_SellOffGoodList := TGList.Create;
end;

destructor TSellOffGoodList.Destroy;
begin
  UnLoadSellOffGoodList();
  inherited;
end;

procedure TSellOffGoodList.UnLoadSellOffGoodList();
var
  I, II: Integer;
begin
  m_SellOffGoodList.Lock();
  try
    SaveSellOffGoodList();
    FUpDateSellOff := True;
    if m_SellOffGoodList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoodList.Count - 1 do begin
        if m_SellOffGoodList.Count <= 0 then Break;
        if TList(m_SellOffGoodList.Items[I]).Count <= 0 then begin
          TList(m_SellOffGoodList.Items[I]).Free;
          Continue;
        end;
        if TList(m_SellOffGoodList.Items[I]).Count > 0 then begin//20080630
          for II := 0 to TList(m_SellOffGoodList.Items[I]).Count - 1 do begin
            if pTSellOffInfo(TList(m_SellOffGoodList.Items[I]).Items[II]) <> nil then
               Dispose(pTSellOffInfo(TList(m_SellOffGoodList.Items[I]).Items[II]));
          end;
        end;
        TList(m_SellOffGoodList.Items[I]).Free;
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
  m_SellOffGoodList.Free;
end;

procedure TSellOffGoodList.LoadSellOffGoodList();
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  List: TList;
  SellOffInfo: pTSellOffInfo;
  Header420: TSellOffHeader;
begin
  m_SellOffGoodList.Lock();
  try
    sFileName := g_Config.sEnvirDir + '\Market_SellOff\UserSellOff.sell';
    if FileExists(sFileName) then begin
      FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
      List := nil;
      if FileHandle > 0 then begin
        if FileRead(FileHandle, Header420, SizeOf(TSellOffHeader)) = SizeOf(TSellOffHeader) then begin
          FRecCount := Header420.nItemCount;
          for I := 0 to Header420.nItemCount - 1 do begin
            New(SellOffInfo);
            FillChar(SellOffInfo.UseItems, SizeOf(TUserItem), #0);
            if (FileRead(FileHandle, SellOffInfo^, SizeOf(TSellOffInfo)) = SizeOf(TSellOffInfo)) and (SellOffInfo.UseItems.wIndex > 0) then begin
              if List = nil then begin
                List := TList.Create;
                List.Add(SellOffInfo);
              end else begin
                if pTSellOffInfo(List.Items[0]).UseItems.wIndex = SellOffInfo.UseItems.wIndex then begin
                  List.Add(SellOffInfo);
                end else begin
                  m_SellOffGoodList.Add(List);
                  List := TList.Create;
                  List.Add(SellOffInfo);
                end;
              end;
            end else begin
              Dispose(SellOffInfo);
            end;
          end;//for
          if List <> nil then m_SellOffGoodList.Add(List);
          FileClose(FileHandle);
        end;
      end;
    end else begin
      FileHandle := FileCreate(sFileName);
      if FileHandle > 0 then begin
        Header420.nItemCount := 0;
        FileWrite(FileHandle, Header420, SizeOf(TSellOffHeader));
        FileClose(FileHandle);
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
  //MainOutMessage('LoadSellGoodRecord: '+IntToStr(Self.Count));
end;

procedure TSellOffGoodList.GetSellOffGoodList(var SellOffList: TList);
var
  I: Integer;
  List: TList;
  SellOffInfo: pTSellOffInfo;
begin
  m_SellOffGoodList.Lock();
  try
    if SellOffList <> nil then begin
      SellOffList.Clear;
      if m_SellOffGoodList.Count > 0 then begin//20080630
        for I := 0 to m_SellOffGoodList.Count - 1 do begin
          if m_SellOffGoodList.Count <= 0 then Break;
          List := TList(m_SellOffGoodList.Items[I]);
          if List.Count <= 0 then Continue;
          SellOffInfo := pTSellOffInfo(List.Items[0]);
          SellOffList.Add(SellOffInfo);
        end;
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

procedure TSellOffGoodList.GetUserSellOffGoodListByChrName(sChrName: string; var SellOffList: TList);
var
  I, II: Integer;
  List: TList;
  SellOffInfo: pTSellOffInfo;
begin
  m_SellOffGoodList.Lock();
  try
    if m_SellOffGoodList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoodList.Count - 1 do begin
        if m_SellOffGoodList.Count <= 0 then Break;
        List := TList(m_SellOffGoodList.Items[I]);
        if List = nil then Continue;
        if List.Count <= 0 then Continue;
        for II := 0 to List.Count - 1 do begin
          SellOffInfo := pTSellOffInfo(List.Items[II]);
          if CompareText(SellOffInfo.sCharName, sChrName) = 0 then
            SellOffList.Add(SellOffInfo);
        end;
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

procedure TSellOffGoodList.GetUserSellOffGoodListByItemName(sItemName: string; var SellOffList: TList);
var
  I: Integer;
  List: TList;
  SellOffInfo: pTSellOffInfo;
  sUserItemName: string;
  StdItem: pTStdItem;
begin
  m_SellOffGoodList.Lock();
  try
    SellOffList := nil;
    if m_SellOffGoodList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoodList.Count - 1 do begin
        if m_SellOffGoodList.Count <= 0 then Break;
        List := TList(m_SellOffGoodList.Items[I]);
        if List = nil then Continue;
        if List.Count <= 0 then Continue;
        SellOffInfo := pTSellOffInfo(List.Items[0]);
        sUserItemName := '';
        if SellOffInfo.UseItems.btValue[13] = 1 then
          sUserItemName := ItemUnit.GetCustomItemName(SellOffInfo.UseItems.MakeIndex, SellOffInfo.UseItems.wIndex);
        if sUserItemName = '' then
          sUserItemName := UserEngine.GetStdItemName(SellOffInfo.UseItems.wIndex);
        StdItem := UserEngine.GetStdItem(SellOffInfo.UseItems.wIndex);
        if (StdItem <> nil) and (CompareText(sUserItemName, sItemName) = 0) then begin
          SellOffList := List;
          Break;
        end;
      end;//for
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

procedure TSellOffGoodList.GetUserSellOffGoodListByMakeIndex(nMakeIndex: Integer; var SellOffInfo: pTSellOffInfo);
var
  I, II: Integer;
  List: TList;
begin
  m_SellOffGoodList.Lock();
  try
    SellOffInfo := nil;
    if m_SellOffGoodList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoodList.Count - 1 do begin
        if m_SellOffGoodList.Count <= 0 then Break;
        List := TList(m_SellOffGoodList.Items[I]);
        if List.Count <= 0 then Continue;
        for II := List.Count - 1 downto 0 do begin
          if pTSellOffInfo(List.Items[II]).UseItems.MakeIndex = nMakeIndex then begin
            SellOffInfo := pTSellOffInfo(List.Items[II]);
            Break;
          end;
        end;
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

procedure TSellOffGoodList.GetUserSellOffItem(sItemName: string; nMakeIndex: Integer; var SellOffInfo: pTSellOffInfo; var StdItem: pTStdItem);
var
  I, II, n01: Integer;
  List: TList;
  sUserItemName: string;
begin
  m_SellOffGoodList.Lock();
  try
    SellOffInfo := nil;
    StdItem := nil;
    n01 := 0;
    if m_SellOffGoodList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoodList.Count - 1 do begin
        if m_SellOffGoodList.Count <= 0 then Break;
        List := TList(m_SellOffGoodList.Items[I]);
        if List.Count <= 0 then Continue;
        SellOffInfo := pTSellOffInfo(List.Items[0]);
        sUserItemName := '';
        if SellOffInfo.UseItems.btValue[13] = 1 then
          sUserItemName := ItemUnit.GetCustomItemName(SellOffInfo.UseItems.MakeIndex, SellOffInfo.UseItems.wIndex);
        if sUserItemName = '' then
          sUserItemName := UserEngine.GetStdItemName(SellOffInfo.UseItems.wIndex);
        StdItem := UserEngine.GetStdItem(SellOffInfo.UseItems.wIndex);
        if (StdItem <> nil) and (CompareText(sUserItemName, sItemName) = 0) then begin
          if List.Count > 0 then begin//20080630
            for II := 0 to List.Count - 1 do begin
              SellOffInfo := pTSellOffInfo(List.Items[II]);
              if (StdItem.StdMode <= 4) or
                (StdItem.StdMode = 42) or
                (StdItem.StdMode = 31) or
                (SellOffInfo.UseItems.MakeIndex = nMakeIndex) then begin
                Inc(n01);
                Break;
              end;
            end;//for
          end;
          Break;
        end;
      end;//for
    end;
    if n01 = 0 then begin
      SellOffInfo := nil;
      StdItem := nil;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

function TSellOffGoodList.GetUserSellOffCount(sCharName: string): Integer;
var
  ItemList: TList;
  I, II: Integer;
begin
  m_SellOffGoodList.Lock();
  try
    Result := -1;
    if m_SellOffGoodList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoodList.Count - 1 do begin
        if m_SellOffGoodList.Count <= 0 then Break;
        ItemList := TList(m_SellOffGoodList.Items[I]);
        if ItemList.Count <= 0 then Continue;
        for II := ItemList.Count - 1 downto 0 do begin
          if ItemList.Count <= 0 then Continue;
          if CompareText(pTSellOffInfo(ItemList.Items[II]).sCharName, sCharName) = 0 then
            Inc(Result);
        end;
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;
{ //20080504 去掉拍卖功能
function TSellOffGoodList.GetUserLimitSellOffCount(sCharName: string): Boolean;
var
  ItemList: TList;
  I, II: Integer;
  n01: Integer;
begin
  m_SellOffGoodList.Lock();
  try
    n01 := 0;
    Result := False;
    for I := 0 to m_SellOffGoodList.Count - 1 do begin
      if m_SellOffGoodList.Count <= 0 then Break;
      ItemList := TList(m_SellOffGoodList.Items[I]);
      if ItemList.Count <= 0 then Continue;
      for II := ItemList.Count - 1 downto 0 do begin
        if ItemList.Count <= 0 then Continue;
        if CompareText(pTSellOffInfo(ItemList.Items[II]).sCharName, sCharName) = 0 then begin
          Inc(n01);
          if n01 >= g_Config.nUserSellOffCount then begin
            Result := True;
            Break;
          end;
        end;
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;
}
procedure TSellOffGoodList.GetUserSellOffListByIndex(nIndex: Integer; var SellOffList: TList); //0049F118
var
  I: Integer;
  List: TList;
begin
  m_SellOffGoodList.Lock();
  try
    SellOffList := nil;
    if m_SellOffGoodList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoodList.Count - 1 do begin
        if nIndex <= 0 then Break;
        List := TList(m_SellOffGoodList.Items[I]);
        if List.Count > 0 then begin
          if pTSellOffInfo(List.Items[0]).UseItems.wIndex = nIndex then begin
            SellOffList := List;
            Break;
          end;
        end;
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

function TSellOffGoodList.AddItemToSellOffGoodsList(SellOffInfo: pTSellOffInfo): Boolean;
var
  ItemList: TList;
begin
  m_SellOffGoodList.Lock();
  try
    Result := False;
    GetUserSellOffListByIndex(SellOffInfo.UseItems.wIndex, ItemList);
    if ItemList = nil then begin
      ItemList := TList.Create;
      m_SellOffGoodList.Add(ItemList);
    end;
    ItemList.Insert(0, SellOffInfo);
    Inc(m_nChangeCount);
    Result := True;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

function TSellOffGoodList.DelSellOffItem(nMakeIndex: Integer): Boolean;
var
  I, II: Integer;
  List: TList;
begin
  Result := False;
  m_SellOffGoodList.Lock();
  try
    for I := m_SellOffGoodList.Count - 1 downto 0 do begin
      if m_SellOffGoodList.Count <= 0 then Break;
      List := TList(m_SellOffGoodList.Items[I]);
      if List.Count <= 0 then begin
        List.Free;
        m_SellOffGoodList.Delete(I);
        Continue;
      end;
      for II := List.Count - 1 downto 0 do begin
        if List.Count <= 0 then Break;//20080917
        if pTSellOffInfo(List.Items[II]).UseItems.MakeIndex = nMakeIndex then begin
          Dispose(pTSellOffInfo(List.Items[II]));
          List.Delete(II);
          if List.Count <= 0 then begin
            List.Free;
            m_SellOffGoodList.Delete(I);
          end;
          Inc(m_nChangeCount);
          Result := True;
          Break;
        end;
      end;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

function TSellOffGoodList.SaveSellOffGoodList(): Boolean;
var
  I, II: Integer;
  sFileName: string;
  FileHandle: Integer;
  SellOffInfo: pTSellOffInfo;
  List: TList;
  Header420: TSellOffHeader;
  //nChangeCount: Integer;
begin
  m_SellOffGoodList.Lock();
  try
    Result := False;
    if (g_boExitServer) and (m_nChangeCount <= 0) then m_nChangeCount := 1;
    if (not FUpDateSellOff) and (m_nChangeCount > 0) then begin
      //nChangeCount := m_nChangeCount;//20080522
      FUpDateSellOff := True;
      sFileName := g_Config.sEnvirDir + '\Market_SellOff\UserSellOff.sell';
      if FileExists(sFileName) then begin
        FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
      end else begin
        FileHandle := FileCreate(sFileName);
      end;
      if FileHandle > 0 then begin
        FillChar(Header420, SizeOf(TSellOffHeader), #0);
        for I := m_SellOffGoodList.Count - 1 downto 0 do begin
          if m_SellOffGoodList.Count <= 0 then Break;//20080917
          List := TList(m_SellOffGoodList.Items[I]);
          if List <> nil then begin
            if List.Count <= 0 then begin
              List.Free;
              m_SellOffGoodList.Delete(I);
            end;
          end;
        end;

        if m_SellOffGoodList.Count > 0 then begin//20080630
          for I := 0 to m_SellOffGoodList.Count - 1 do begin
            List := TList(m_SellOffGoodList.Items[I]);
            if List <> nil then begin
              Inc(Header420.nItemCount, List.Count);
            end;
          end;
        end;
        FileWrite(FileHandle, Header420, SizeOf(TSellOffHeader));
        if m_SellOffGoodList.Count > 0 then begin//20080630
          for I := 0 to m_SellOffGoodList.Count - 1 do begin
            List := TList(m_SellOffGoodList.Items[I]);
            for II := 0 to List.Count - 1 do begin
              if (List = nil) or (List.Count <= 0) then Continue;
              SellOffInfo := pTSellOffInfo(List.Items[II]);
              if SellOffInfo <> nil then
                FileWrite(FileHandle, SellOffInfo^, SizeOf(TSellOffInfo));
            end;
          end;
        end;
        FileClose(FileHandle);
      end;
      FUpDateSellOff := False;
      m_nChangeCount := 0;
      Result := True;
    end;
  finally
    m_SellOffGoodList.UnLock();
  end;
end;

{TSellOffGoldList}

constructor TSellOffGoldList.Create;
begin
  inherited Create;
  FRecCount := 0;
  FUpDateSellOff := False;
  m_nChangeCount := 0;
  m_SellOffGoldList := TGList.Create;
end;

destructor TSellOffGoldList.Destroy;
begin
  UnLoadSellOffGoldList();
  inherited;
end;

procedure TSellOffGoldList.UnLoadSellOffGoldList();
var
  I: Integer;
begin
  m_SellOffGoldList.Lock();
  try
    SaveSellOffGoldList();
    FUpDateSellOff := True;
    if m_SellOffGoldList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoldList.Count - 1 do begin
        if m_SellOffGoldList.Count <= 0 then Break;
        if pTSellOffInfo(m_SellOffGoldList.Items[I]) <> nil then
           Dispose(pTSellOffInfo(m_SellOffGoldList.Items[I]));
      end;
    end;
  finally
    m_SellOffGoldList.UnLock();
  end;
  m_SellOffGoldList.Free;
end;

procedure TSellOffGoldList.LoadSellOffGoldList();
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  SellOffInfo: pTSellOffInfo;
  Header420: TSellOffHeader;
begin
  m_SellOffGoldList.Lock();
  try
    sFileName := g_Config.sEnvirDir + '\Market_SellOff\UserSellOff.gold';
    if FileExists(sFileName) then begin
      FileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
      if FileHandle > 0 then begin
        if FileRead(FileHandle, Header420, SizeOf(TSellOffHeader)) = SizeOf(TSellOffHeader) then begin
          FRecCount := Header420.nItemCount;
          for I := 0 to Header420.nItemCount - 1 do begin
            New(SellOffInfo);
            FillChar(SellOffInfo.UseItems, SizeOf(TUserItem), #0);
            if (FileRead(FileHandle, SellOffInfo^, SizeOf(TSellOffInfo)) = SizeOf(TSellOffInfo)) and (SellOffInfo.UseItems.wIndex > 0) then begin
              m_SellOffGoldList.Add(SellOffInfo);
            end else begin
              Dispose(SellOffInfo);
            end;
          end;
          FileClose(FileHandle);
        end;
      end;
    end else begin
      FileHandle := FileCreate(sFileName);
      if FileHandle > 0 then begin
        Header420.nItemCount := 0;
        FileWrite(FileHandle, Header420, SizeOf(TSellOffHeader));
        FileClose(FileHandle);
      end;
    end;
  finally
    m_SellOffGoldList.UnLock();
  end;
end;

procedure TSellOffGoldList.GetUserSellOffGoldListByChrName(sChrName: string; var SellOffList: TList);
var
  I: Integer;
  SellOffInfo: pTSellOffInfo;
begin
  m_SellOffGoldList.Lock();
  try
    if m_SellOffGoldList.Count > 0 then begin//20080630
      for I := 0 to m_SellOffGoldList.Count - 1 do begin
        if m_SellOffGoldList.Count <= 0 then Break;
        SellOffInfo := pTSellOffInfo(m_SellOffGoldList.Items[I]);
        if (SellOffInfo <> nil) and (CompareText(SellOffInfo.sCharName, sChrName) = 0) and (SellOffInfo.nSellGold > 0) then
          SellOffList.Add(SellOffInfo);
      end;
    end;
  finally
    m_SellOffGoldList.UnLock();
  end;
end;

function TSellOffGoldList.AddItemToSellOffGoldList(SellOffInfo: pTSellOffInfo): Boolean;
begin
  m_SellOffGoldList.Lock();
  try
    Result := False;
    m_SellOffGoldList.Add(SellOffInfo);
    Inc(m_nChangeCount);
    Result := True;
  finally
    m_SellOffGoldList.UnLock();
  end;
end;

function TSellOffGoldList.DelSellOffGoldItem(nMakeIndex: Integer): Boolean;
var
  I: Integer;
begin
  m_SellOffGoldList.Lock();
  try
    Result := False;
    for I := m_SellOffGoldList.Count - 1 downto 0 do begin
      if m_SellOffGoldList.Count <= 0 then Break;
      if pTSellOffInfo(m_SellOffGoldList.Items[I]).UseItems.MakeIndex = nMakeIndex then begin
        Dispose(pTSellOffInfo(m_SellOffGoldList.Items[I]));
        m_SellOffGoldList.Delete(I);
        Inc(m_nChangeCount);
        Result := True;
        Break;
      end;
    end;
  finally
    m_SellOffGoldList.UnLock();
  end;
end;

function TSellOffGoldList.SaveSellOffGoldList(): Boolean;
var
  I: Integer;
  sFileName: string;
  FileHandle: Integer;
  SellOffInfo: pTSellOffInfo;
  Header420: TSellOffHeader; //Inc(m_nChangeCount);
  //nChangeCount: Integer;
begin
  m_SellOffGoldList.Lock();
  try
    Result := False;
    if (g_boExitServer) and (m_nChangeCount <= 0) then m_nChangeCount := 1;
    if (not FUpDateSellOff) and (m_nChangeCount > 0) then begin
      //nChangeCount := m_nChangeCount;//20080522
      FUpDateSellOff := True;
      sFileName := g_Config.sEnvirDir + '\Market_SellOff\UserSellOff.gold';
      if FileExists(sFileName) then begin
        FileHandle := FileOpen(sFileName, fmOpenWrite or fmShareDenyNone);
      end else begin
        FileHandle := FileCreate(sFileName);
      end;
      if FileHandle > 0 then begin
        FillChar(Header420, SizeOf(TSellOffHeader), #0);
        Header420.nItemCount := m_SellOffGoldList.Count;
        FileWrite(FileHandle, Header420, SizeOf(TSellOffHeader));
        if m_SellOffGoldList.Count > 0 then begin//20080630
          for I := 0 to m_SellOffGoldList.Count - 1 do begin
            SellOffInfo := m_SellOffGoldList.Items[I];
            if SellOffInfo <> nil then
              FileWrite(FileHandle, SellOffInfo^, SizeOf(TSellOffInfo));
          end;
        end;
        FileClose(FileHandle);
      end;
      FUpDateSellOff := False;
      m_nChangeCount := 0;
      Result := True;
    end;
  finally
    m_SellOffGoldList.UnLock();
  end;
end;

{===================================排序StringList=============================}

procedure TSortStringList.ObjectSort(Order: Boolean);
var
  nIndex, j: Integer;
  TempList: TStringList;
  MinList: TStringList;
  MaxList: TStringList;
  nMax, nMIN, nMaxIndex, nMinIndex: Integer;
begin
  TempList := TStringList.Create;
  MinList := TStringList.Create;
  MaxList := TStringList.Create;
  TempList.AddStrings(Self);
  Clear;
  while True do begin
    if TempList.Count <= 0 then Break;
    nMax := Low(Integer);
    nMIN := High(Integer);
    nMaxIndex := -1;
    nMinIndex := -1;
    nIndex := 0;
    while True do begin
      if TempList.Count <= nIndex then Break;
      j := Integer(TempList.Objects[nIndex]);
      if j > nMax then begin
        nMax := j;
        nMaxIndex := nIndex;
      end;
      if j < nMIN then begin
        nMIN := j;
        nMinIndex := nIndex;
      end;
      Inc(nIndex);
    end;
    if Order then begin
      if nMinIndex = nMaxIndex then begin
        if nMinIndex >= 0 then begin
          MinList.AddObject(TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
          TempList.Delete(nMinIndex);
        end;
      end else begin
        if nMinIndex < nMaxIndex then begin
          if nMaxIndex >= 0 then begin
            MaxList.InsertObject(0, TempList.Strings[nMaxIndex], TempList.Objects[nMaxIndex]);
            TempList.Delete(nMaxIndex);
          end;
          if nMinIndex >= 0 then begin
            MinList.AddObject(TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
            TempList.Delete(nMinIndex);
          end;
        end else begin
          if nMinIndex >= 0 then begin
            MinList.AddObject(TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
            TempList.Delete(nMinIndex);
          end;
          if nMaxIndex >= 0 then begin
            MaxList.InsertObject(0, TempList.Strings[nMaxIndex], TempList.Objects[nMaxIndex]);
            TempList.Delete(nMaxIndex);
          end;
        end;
      end;
    end else begin
      if nMinIndex = nMaxIndex then begin
        if nMinIndex >= 0 then begin
          MaxList.AddObject(TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
          TempList.Delete(nMinIndex);
        end;
      end else begin
        if nMinIndex < nMaxIndex then begin
          if nMaxIndex >= 0 then begin
            MaxList.AddObject(TempList.Strings[nMaxIndex], TempList.Objects[nMaxIndex]);
            TempList.Delete(nMaxIndex);
          end;
          if nMinIndex >= 0 then begin
            MinList.InsertObject(0, TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
            TempList.Delete(nMinIndex);
          end;
        end else begin
          if nMinIndex >= 0 then begin
            MinList.InsertObject(0, TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
            TempList.Delete(nMinIndex);
          end;
          if nMaxIndex >= 0 then begin
            MaxList.AddObject(TempList.Strings[nMaxIndex], TempList.Objects[nMaxIndex]);
            TempList.Delete(nMaxIndex);
          end;
        end;
      end;
    end;
  end;
  if Order then begin
    AddStrings(MinList);
    AddStrings(MaxList);
  end else begin
    AddStrings(MaxList);
    AddStrings(MinList);
  end;
  TempList.Free;
  MinList.Free;
  MaxList.Free;
end;

procedure TSortStringList.StringSort(Order: Boolean);
var
  nIndex, j: Integer;
  TempList: TStringList;
  MinList: TStringList;
  MaxList: TStringList;
  nMax, nMIN, nMaxIndex, nMinIndex: Integer;
begin
  TempList := TStringList.Create;
  MinList := TStringList.Create;
  MaxList := TStringList.Create;
  TempList.AddStrings(Self);
  Clear;
  while True do begin
    if TempList.Count <= 0 then Break;
    nMax := Low(Integer);
    nMIN := High(Integer);
    nMaxIndex := -1;
    nMinIndex := -1;
    nIndex := 0;
    while True do begin
      if TempList.Count <= nIndex then Break;
      j := StrToInt(TempList.Strings[nIndex]);
      if j > nMax then begin
        nMax := j;
        nMaxIndex := nIndex;
      end;
      if j < nMIN then begin
        nMIN := j;
        nMinIndex := nIndex;
      end;
      Inc(nIndex);
    end;
    if Order then begin
      if nMinIndex = nMaxIndex then begin
        if nMinIndex >= 0 then begin
          MinList.AddObject(TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
          TempList.Delete(nMinIndex);
        end;
      end else begin
        if nMinIndex < nMaxIndex then begin
          if nMaxIndex >= 0 then begin
            MaxList.InsertObject(0, TempList.Strings[nMaxIndex], TempList.Objects[nMaxIndex]);
            TempList.Delete(nMaxIndex);
          end;
          if nMinIndex >= 0 then begin
            MinList.AddObject(TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
            TempList.Delete(nMinIndex);
          end;
        end else begin
          if nMinIndex >= 0 then begin
            MinList.AddObject(TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
            TempList.Delete(nMinIndex);
          end;
          if nMaxIndex >= 0 then begin
            MaxList.InsertObject(0, TempList.Strings[nMaxIndex], TempList.Objects[nMaxIndex]);
            TempList.Delete(nMaxIndex);
          end;
        end;
      end;
    end else begin
      if nMinIndex = nMaxIndex then begin
        if nMinIndex >= 0 then begin
          MaxList.AddObject(TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
          TempList.Delete(nMinIndex);
        end;
      end else begin
        if nMinIndex < nMaxIndex then begin
          if nMaxIndex >= 0 then begin
            MaxList.AddObject(TempList.Strings[nMaxIndex], TempList.Objects[nMaxIndex]);
            TempList.Delete(nMaxIndex);
          end;
          if nMinIndex >= 0 then begin
            MinList.InsertObject(0, TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
            TempList.Delete(nMinIndex);
          end;
        end else begin
          if nMinIndex >= 0 then begin
            MinList.InsertObject(0, TempList.Strings[nMinIndex], TempList.Objects[nMinIndex]);
            TempList.Delete(nMinIndex);
          end;
          if nMaxIndex >= 0 then begin
            MaxList.AddObject(TempList.Strings[nMaxIndex], TempList.Objects[nMaxIndex]);
            TempList.Delete(nMaxIndex);
          end;
        end;
      end;
    end;
  end;
  if Order then begin
    AddStrings(MinList);
    AddStrings(MaxList);
  end else begin
    AddStrings(MaxList);
    AddStrings(MinList);
  end;
  TempList.Free;
  MinList.Free;
  MaxList.Free;
end;

end.

