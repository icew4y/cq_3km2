unit clEvent;//不是消息标识的处理单元(clmain.pas中procedure TFrmMain.DecodeMessagePacket (datablock: string);),而是客户端事件管理器

interface

uses
  Windows, Classes, DXDraws, Grobal2, CliUtil, MShare;
const
   ZOMBIDIGUPDUSTBASE = 420;//石墓尸王从土中钻出来(的事件event),,这里是图片帧，存在于
   //mon6.wil中从第420开始的地图效果
   STONEFRAGMENTBASE = 64;//Effect.wil中,,,挖矿时会有二个地图效果，1，尘土飞扬，不在地面堆积
   //2,,碎石坠落，，在地面产生变化就像ZOMBIDIGUPDUSTBASE,,
   HOLYCURTAINBASE = 1390; //Magic.wil,,困魔咒的地面效果
   FIREBURNBASE = 1630;//火墙的地面效果
   FIREFENGHAO = 1695; //粉色火墙的地面效果
   SCULPTUREFRAGMENT = 1349;//mon7.wil中祖玛教主被激活
type
  TClEvent = class
    m_nX      :Integer;
    m_nY      :Integer;
    m_nDir    :Integer;
    m_nPx     :Integer;
    m_nPy     :Integer;
    m_nEventType  :Integer;
    m_nEventParam :Integer;
    m_nServerId   :Integer;
    m_Dsurface    :TDirectDrawSurface;
    m_boBlend     :Boolean;
    m_dwFrameTime :LongWord;
    m_dwFrameTime1:LongWord;//烟花
    m_dwCurframe  :LongWord;
    m_dwCurframe1 :LongWord;//烟花
    m_nLight      :Integer;
   private
   public
      constructor Create (svid, ax, ay, evtype: integer);
      destructor Destroy; override;
      procedure DrawEvent (backsurface: TDirectDrawSurface; ax, ay: integer); dynamic;
      procedure Run; dynamic;
   end;

   TClEventManager = class
   private
   public
      EventList: TList;
      constructor Create;
      destructor Destroy; override;
      procedure ClearEvents;
      function  AddEvent (evn: TClEvent): TClEvent;
      procedure DelEvent (evn: TClEvent);
      procedure DelEventById (svid: integer);
      function  GetEvent (ax, ay, etype: integer): TClEvent;
      procedure Execute;
   end;


implementation

constructor TClEvent.Create (svid, ax, ay, evtype: integer);
begin
   m_nServerId := svid;
   m_nX := ax;
   m_nY := ay;
   m_nEventType := evtype;
   m_nEventParam := 0;
   m_boBlend := FALSE;
   m_dwFrameTime := GetTickCount;
   m_dwCurframe := 0;
   m_dwCurframe1 := 0;
   m_nLight := 0;
end;

destructor TClEvent.Destroy;
begin
   inherited Destroy;
end;

procedure TClEvent.DrawEvent (backsurface: TDirectDrawSurface; ax, ay: integer);
begin
   if m_Dsurface <> nil then
      if m_boBlend then DrawBlend (backsurface, ax + m_nPx, ay + m_nPy, m_Dsurface, 120)
      else backsurface.Draw(ax + m_nPx, ay+m_nPy, m_Dsurface.ClientRect, m_Dsurface, TRUE);
end;

procedure TClEvent.Run;
begin
  m_Dsurface := nil;
  if GetTickCount - m_dwFrameTime > {100{}20 then begin
    m_dwFrameTime := GetTickCount;
    Inc (m_dwCurframe);
  end;
  
  if m_nEventType in [ET_FIREFLOWER_1..ET_FIREFLOWER_7] then begin
    if GetTickCount - m_dwFrameTime1 > 180 then begin
      m_dwFrameTime1 := GetTickCount;
      Inc (m_dwCurframe1);
    end;
    if m_dwCurframe1 >= 20 then Exit;
  end;

  if m_nEventType = SM_HEROLOGOUT then begin
    if GetTickCount - m_dwFrameTime1 > 100 then begin
      m_dwFrameTime1 := GetTickCount;
      Inc (m_dwCurframe1);
    end;
    if m_dwCurframe1 >= 10 then Exit;
  end;

  if m_nEventType = ET_DIEEVENT then begin
    if GetTickCount - m_dwFrameTime1 > 60 then begin
      m_dwFrameTime1 := GetTickCount;
      Inc (m_dwCurframe1);
    end;
    if m_dwCurframe1 >= 15 then Exit;
  end;

  if m_nEventType = ET_FIREDRAGON then begin
    if GetTickCount - m_dwFrameTime1 > 50 then begin
      m_dwFrameTime1 := GetTickCount;
      Inc (m_dwCurframe1);
    end;
    if m_dwCurframe1 >= 34 then Exit;
  end;

  if m_nEventType = ET_FOUNTAIN then begin //喷发泉水
    if GetTickCount - m_dwFrameTime1 > 80 then begin
      m_dwFrameTime1 := GetTickCount;
      Inc (m_dwCurframe1);
    end;
    if m_dwCurframe1 >= 12 then m_dwCurframe1 := 0;
  end;

  if m_nEventType = ET_VORTEX then begin //漩涡
    if GetTickCount - m_dwFrameTime1 > 100 then begin
      m_dwFrameTime1 := GetTickCount;
      Inc (m_dwCurframe1);
    end;
    if m_dwCurframe1 > 6 then m_dwCurframe1 := 3;
  end;

  case m_nEventType of
    ET_DIGOUTZOMBI: m_Dsurface := {FrmMain.WMon6Img20080720注释}g_WMonImagesArr[5].GetCachedImage (ZOMBIDIGUPDUSTBASE+m_nDir, m_nPx, m_nPy);
    ET_PILESTONES: begin
      if m_nEventParam <= 0 then m_nEventParam := 1;
      if m_nEventParam > 5 then m_nEventParam := 5;
      m_Dsurface := {FrmMain.WEffectImg}g_WEffectImages.GetCachedImage (STONEFRAGMENTBASE+(m_nEventParam-1), m_nPx, m_nPy);
    end;
    ET_HOLYCURTAIN: begin
      m_Dsurface := g_WMagicImages.GetCachedImage(HOLYCURTAINBASE+(m_dwCurframe mod 10), m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIRE: begin
      m_Dsurface := g_WMagicImages.GetCachedImage(FIREBURNBASE+((m_dwCurframe div 2) mod 6), m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIRE_1: begin
      m_Dsurface := g_WMagic7Images16.GetCachedImage(90+((m_dwCurframe div 2) mod 8), m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIRE_2: begin
      m_Dsurface := g_WMagic7Images16.GetCachedImage(100+((m_dwCurframe div 2) mod 8), m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIRE_3: begin
      m_Dsurface := g_WMagic7Images16.GetCachedImage(110+((m_dwCurframe div 2) mod 8), m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIRE_FENGHAO: begin //粉色火墙效果
      m_Dsurface := g_WMagic5Images.GetCachedImage(FIREFENGHAO+((m_dwCurframe div 2) mod 6), m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;

    ET_VORTEX: begin //漩涡
      m_Dsurface := g_WMonImagesArr[32].GetCachedImage(2670+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_NOTGOTO: begin//不能穿过(天雷乱舞)
      m_Dsurface := g_WMagic10Images.GetCachedImage(970+(m_dwCurframe mod 16), m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIREFLOWER_1: begin//一心一意
      m_Dsurface := g_WMagic3Images.GetCachedImage(60+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    SM_HEROLOGOUT: begin   //20080419 英雄退出动画显示
      m_Dsurface := g_WEffectImages.GetCachedImage(810+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIREDRAGON: begin
      m_Dsurface := g_WDragonImages.GetCachedImage(350+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
//---------------------------------------------------------------------------------
//20080103
    ET_FIREFLOWER_2: begin //心心相印
      m_Dsurface := g_WMagic3Images.GetCachedImage(80+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIREFLOWER_3: begin
      m_Dsurface := g_WMagic3Images.GetCachedImage(100+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIREFLOWER_4: begin
      m_Dsurface := g_WMagic3Images.GetCachedImage(120+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIREFLOWER_5: begin
      m_Dsurface := g_WMagic3Images.GetCachedImage(140+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIREFLOWER_6: begin
      m_Dsurface := g_WMagic3Images.GetCachedImage(160+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_FIREFLOWER_7: begin
      m_Dsurface := g_WMagic3Images.GetCachedImage(180+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
//---------------------------------------------------------------------------------

    ET_SCULPEICE: begin
      m_Dsurface := {FrmMain.WMon7Img20080720注释}g_WMonImagesArr[6].GetCachedImage(SCULPTUREFRAGMENT, m_nPx, m_nPy);
    end;
    ET_FOUNTAIN: begin // 泉水喷发 20080624
      m_Dsurface := g_WMain2Images.GetCachedImage(550+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_DIEEVENT: begin
      m_Dsurface := g_WMain2Images.GetCachedImage(110+m_dwCurframe1, m_nPx, m_nPy);
      m_boBlend := TRUE;
      m_nLight := 1;
    end;
    ET_SCULPEICE_1: begin
      m_Dsurface := g_WMonImagesArr[26].GetCachedImage(2019+m_nDir*10, m_nPx, m_nPy);
    end;
  end;
end;


{-----------------------------------------------------------------------------}



{-----------------------------------------------------------------------------}

constructor TClEventManager.Create;
begin
   EventList := TList.Create;
end;

destructor TClEventManager.Destroy;
var
  i: integer;
begin
  if EventList.Count > 0 then //20080629
  for i:=0 to EventList.Count-1 do
    TClEvent(EventList[i]).Free;
  EventList.Free;
  inherited Destroy;
end;

procedure TClEventManager.ClearEvents;
var
  i: integer;
begin
  if EventList.Count > 0 then //20080629
  for i:=0 to EventList.Count-1 do
    TClEvent(EventList[i]).Free;
  EventList.Clear;
end;

function  TClEventManager.AddEvent (evn: TClEvent): TClEvent;
var
  i: integer;
begin
  if EventList.Count > 0 then //20080629
  for i:=0 to EventList.Count-1 do
    if (EventList[i] = evn) or (TClEvent(EventList[i]).m_nServerId = evn.m_nServerId) then begin
      evn.Free;
      Result := nil;
      exit;
    end;
  EventList.Add (evn);
  Result := evn;
end;

procedure TClEventManager.DelEvent (evn: TClEvent);
var
  i: integer;
begin
  if EventList.Count > 0 then //20080629
  for i:=0 to EventList.Count-1 do
    if EventList[i] = evn then begin
      TClEvent(EventList[i]).Free;
      EventList.Delete (i);
      break;
    end;
end;

procedure TClEventManager.DelEventById (svid: integer);
var
  i: integer;
begin
  if EventList.Count > 0 then //20080629
  for i:=0 to EventList.Count-1 do
    if TClEvent(EventList[i]).m_nServerId = svid then begin
      TClEvent(EventList[i]).Free;
      EventList.Delete (i);
      break;
    end;
end;

function  TClEventManager.GetEvent (ax, ay, etype: integer): TClEvent;
var
  i: integer;
begin
  Result := nil;
  if EventList.Count > 0 then //20080629
  for i:=0 to EventList.Count-1 do
    if (TClEvent(EventList[i]).m_nX = ax) and (TClEvent(EventList[i]).m_nY = ay) and
       (TClEvent(EventList[i]).m_nEventType = etype) then begin
      Result := TClEvent(EventList[i]);
      break;
    end;
end;

procedure TClEventManager.Execute;
var
  i: integer;
begin
  if EventList.Count > 0 then //20080629
  for i:=0 to EventList.Count-1 do
    TClEvent(EventList[i]).Run;
end;

end.
