unit ItemEvent;

interface
uses
  Windows, Classes, SysUtils, SyncObjs, NewObjBase, Grobal2, SDK, HUtil32;
type
  TItemObject = class(TNewBaseObject)
    m_wLooks: Word;//外观
    m_btAniCount: Byte;
    m_btReserved: Byte;
    m_nCount: Integer;//数量
    m_OfActorObject: TObject;//物品谁可以捡起
    m_DropActorObject: TObject;//谁掉落的
    m_dwCanPickUpTick: LongWord;
    m_UserItem: TUserItem;
    m_sName: string[30];//名称

    m_PEnvir: TObject;
    m_boGhost: Boolean; //是否清除
    m_dwGhostTick: LongWord; //清除间隔
    m_dwRunTick: LongWord; //0x300
  private

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure Run();
    procedure MakeGhost;
  end;

  TItemManager = class
    m_ItemList: TGList;
    m_FreeItemList: TGList;
    m_nProcItemIDx: Integer;
  private
    function GetItemCount: Integer;
  public
    constructor Create();
    destructor Destroy; override;
    procedure Run();
    procedure AddItem(ItemObject: TItemObject);
    function FindItem(Envir: TObject; ItemObject: TItemObject): TItemObject; overload;
    function FindItem(Envir: TObject; nX, nY: Integer): TItemObject; overload;
    function FindItem(Envir: TObject; nX, nY: Integer; ItemObject: TItemObject): TItemObject; overload;
    function FindItem(Envir: TObject; nX, nY, nRange: Integer; List: TList): Integer; overload;
    property ItemCount: Integer read GetItemCount;
  end;
implementation
uses ObjBase, Envir, M2Share;

constructor TItemObject.Create();
begin
  inherited;
  m_ObjType := OS_ITEMOBJECT;
  m_sName := '';

  m_wLooks := 0;
  m_btAniCount := 0;
  m_btReserved := 0;
  m_nCount := 0;
  m_OfActorObject := nil;
  m_DropActorObject := nil;
  m_dwCanPickUpTick := 0;

  m_PEnvir := nil;
  m_boGhost := False;
  m_dwGhostTick := 0;
  m_dwRunTick := GetTickCount;
  FillChar(m_UserItem, SizeOf(TUserItem), #0);
end;

destructor TItemObject.Destroy;
begin
  if m_PEnvir <> nil then begin
    TEnvirnoment(m_PEnvir).DeleteFromMap(m_nMapX, m_nMapY, m_ObjType, Self);
    m_PEnvir := nil;
  end;
  inherited;
end;

procedure TItemObject.Run();
begin
  if not m_boGhost then begin
    if ((GetTickCount - m_dwAddTime) > g_Config.dwClearDropOnFloorItemTime) or
      ((m_UserItem.AddValue[0] = 1) and (GetHoursCount(m_UserItem.MaxDate, Now) <= 0)) then begin//清除时间到的物品
      m_boGhost := True;            
      m_dwGhostTick := GetTickCount;
    end;
  end;

  if not m_boGhost then begin
    if (m_OfActorObject <> nil) or (m_DropActorObject <> nil) then begin
      if (GetTickCount - m_dwCanPickUpTick) > g_Config.dwFloorItemCanPickUpTime {2 * 60 * 1000} then begin
        m_OfActorObject := nil;
        m_DropActorObject := nil;
      end else begin
        if TBaseObject(m_OfActorObject) <> nil then begin
          if TBaseObject(m_OfActorObject).m_boGhost then m_OfActorObject := nil;
        end;
        if TBaseObject(m_DropActorObject) <> nil then begin
          if TBaseObject(m_DropActorObject).m_boGhost then m_DropActorObject := nil;
        end;
      end;
    end;
  end else begin
    if m_PEnvir <> nil then begin
      TEnvirnoment(m_PEnvir).DeleteFromMap(m_nMapX, m_nMapY, m_ObjType, Self);
      m_PEnvir := nil;
    end;
  end;
end;

procedure TItemObject.MakeGhost;
begin
  m_boGhost := True;
  m_dwGhostTick := GetTickCount;
end;

constructor TItemManager.Create();
begin
  m_ItemList := TGList.Create;
  m_FreeItemList := TGList.Create;
  m_nProcItemIDx := 0;
end;

destructor TItemManager.Destroy;
var
  I: Integer;
begin
  if m_ItemList.Count > 0 then begin
    for I := 0 to m_ItemList.Count - 1 do begin
      TItemObject(m_ItemList.Items[I]).Free;
    end;
  end;
  m_ItemList.Free;
  if m_FreeItemList.Count > 0 then begin
    for I := 0 to m_FreeItemList.Count - 1 do begin
      TItemObject(m_FreeItemList.Items[I]).Free;
    end;
  end;
  m_FreeItemList.Free;
  inherited;
end;

function TItemManager.GetItemCount: Integer;
begin
  Result := m_ItemList.Count;
end;

procedure TItemManager.AddItem(ItemObject: TItemObject);
begin
  m_ItemList.Add(ItemObject);
end;

function TItemManager.FindItem(Envir: TObject; ItemObject: TItemObject): TItemObject;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to m_ItemList.Count - 1 do begin
    if (not TItemObject(m_ItemList.Items[I]).m_boGhost) and (TItemObject(m_ItemList.Items[I]).m_PEnvir = Envir) and (TItemObject(m_ItemList.Items[I]) = ItemObject) then begin
      Result := TItemObject(m_ItemList.Items[I]);
      Break;
    end;
  end;
end;

function TItemManager.FindItem(Envir: TObject; nX, nY: Integer): TItemObject;
var
  I: Integer;
  ItemObject: TItemObject;
begin
  Result := nil;
  for I := 0 to m_ItemList.Count - 1 do begin
    ItemObject := TItemObject(m_ItemList.Items[I]);
    if (not ItemObject.m_boGhost) and (ItemObject.m_PEnvir = Envir) and
      (ItemObject.m_nMapX = nX) and
      (ItemObject.m_nMapY = nY) then begin
      Result := ItemObject;
      Break;
    end;
  end;
end;

function TItemManager.FindItem(Envir: TObject; nX, nY: Integer; ItemObject: TItemObject): TItemObject;
var
  I: Integer;
  AItemObject: TItemObject;
begin
  Result := nil;
  for I := 0 to m_ItemList.Count - 1 do begin
    AItemObject := TItemObject(m_ItemList.Items[I]);
    if (not AItemObject.m_boGhost) and (AItemObject.m_PEnvir = Envir) and (AItemObject = ItemObject) and
      (ItemObject.m_nMapX = nX) and
      (ItemObject.m_nMapY = nY) then begin
      Result := ItemObject;
      Break;
    end;
  end;
end;

function TItemManager.FindItem(Envir: TObject; nX, nY, nRange: Integer; List: TList): Integer;
var
  I, nCount: Integer;
  ItemObject: TItemObject;
begin
  Result := 0;
  nCount := 0;
  for I := 0 to m_ItemList.Count - 1 do begin
    ItemObject := TItemObject(m_ItemList.Items[I]);
    if (not ItemObject.m_boGhost) and (ItemObject.m_PEnvir = Envir) and
      (abs(ItemObject.m_nMapX - nX) <= nRange) and
      (abs(ItemObject.m_nMapY - nY) <= nRange) then begin
      Inc(nCount);
      if List <> nil then List.Add(ItemObject);
    end;
  end;
  Result := nCount;
end;

procedure TItemManager.Run();
var
  I, nIdx: Integer;
  ItemObject: TItemObject;
  dwCurTick, dwCheckTime: LongWord;
  boCheckTimeLimit: Boolean;
resourcestring
  sExceptionMsg = '{%s} TItemManager.Run';
begin
  boCheckTimeLimit := False;
  dwCheckTime := GetTickCount();
  dwCurTick := GetTickCount();
  nIdx := m_nProcItemIDx;
  try
    while True do begin
      if m_ItemList.Count <= nIdx then Break;
      ItemObject := TItemObject(m_ItemList.Items[nIdx]);
      if (not ItemObject.m_boGhost) and ((GetTickCount - ItemObject.m_dwRunTick) > 250) then begin
        ItemObject.m_dwRunTick := GetTickCount();
        ItemObject.Run();
      end;

      if ItemObject.m_boGhost then begin
        m_FreeItemList.Add(ItemObject);
        m_ItemList.Delete(nIdx);
        Continue;
      end;

      Inc(nIdx);
      if (GetTickCount - dwCheckTime) > 10 then begin
        boCheckTimeLimit := True;
        m_nProcItemIDx := nIdx;
        Break;
      end;
    end; //while True do begin
    if not boCheckTimeLimit then m_nProcItemIDx := 0;
  except
    MainOutMessage(Format(sExceptionMsg,[g_sExceptionVer]));
  end;

  if m_FreeItemList.Count > 0 then begin
    for I := 0 to m_FreeItemList.Count - 1 do begin
      ItemObject := TItemObject(m_FreeItemList.Items[I]);
      if (GetTickCount - ItemObject.m_dwGhostTick) > 300000{5 * 60 * 1000} then begin
        m_FreeItemList.Delete(I);
        ItemObject.Free;
        break;
      end;
    end;
  end;
end;

end.

