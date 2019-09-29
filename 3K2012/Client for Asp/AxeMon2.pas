unit AxeMon2;

interface
uses Windows, Actor, AxeMon, AbstractCanvas, AbstractTextures,
Grobal2, MShare, cliUtil, magiceff;

type
   TSnowyHousecarl = class (TGasKuDeGi) //Ñ©ÓòÊÌÎÀ£¬Ñ©ÓòÕ½½«  Ñ©ÓòÌì½«
   protected
     boEff: Boolean;
   public
     destructor Destroy; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
     procedure Run; override;
   end;

   TSnowyLuxman = class (TGasKuDeGi) //Ñ©ÓòÁ¦Ê¿
   protected
   public
     destructor Destroy; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
   end;
   TSnowyGuards = class (TSculptureMon) //Ñ©ÓòÎÀÊ¿
   protected
    AttackEffectSurface :TAsphyreLockableTexture;    //0x250
    DieEffectSurface    :TAsphyreLockableTexture;    //0x254
    BoUseDieEffect      :Boolean;    //0x258
    bx                  :integer;
    by                  :integer;
    ax                  :integer;    //0x264
    ay                  :integer;    //0x268
    oldframe            :integer;
    firedir             :integer;
    EffImg              :Integer;
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure RunFrameAction (frame: integer); override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure DrawChr (dsurface: TAsphyreCanvas; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
      procedure DrawEff (dsurface: TAsphyreCanvas; dx, dy: integer); override;
      procedure Run; override;
   end;

   TSnowyBE = class (TGasKuDeGi) //Ñ©ÓòÄ§Íõ
   protected
     m_LightSurface      :TAsphyreLockableTexture;
     //m_LightSurface1     :TDirectDrawSurface;
     m_nLightX           :Integer;
     m_nLightY           :Integer;
    // m_nLightX1          :Integer;
    // m_nLightY1          :Integer;
   public
     destructor Destroy; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
     procedure DrawChr (dsurface: TAsphyreCanvas; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
   end;
//***************************************************//
//ºÚºü¡¢³àºü¡¢ËØºü
   TFoxRed = class (TGasKuDeGi)
   protected
     oldframe: integer;
   public
     destructor Destroy; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
     procedure Run; override;
     procedure DrawEff (dsurface: TAsphyreCanvas; dx, dy: integer); override;
     procedure RunFrameAction (frame: integer); override;
   end;
//ºüÔÂÖ®ÑÛ
   TFoxBall = class (TGasKuDeGi)
   protected
     m_LightSurface      :TAsphyreLockableTexture;
     m_nLightX           :Integer;
     m_nLightY           :Integer;
     function GetStateImg(): Integer;
   public
     destructor Destroy; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
     procedure DrawEff (dsurface: TAsphyreCanvas; dx, dy: integer); override;
     function  GetDefaultFrame (wmode: Boolean): integer; override;
   end;
   //Öì»ðµ¯
   TFoxBall1 = class (TFoxBall)
   protected
    boState: Boolean;
   public
     constructor Create; override;
     procedure CalcActorFrame; override;
     procedure Run; override;
   end;
//¾ÅÎ²»êÊ¯
   TFoxStone = class (TGasKuDeGi)
   protected
   public
     destructor Destroy; override;
     procedure CalcActorFrame; override;
     procedure Run; override;
     procedure LoadSurface; override;
     procedure DrawEff (dsurface: TAsphyreCanvas; dx, dy: integer); override;
     function  GetDefaultFrame (wmode: Boolean): integer; override;
   end;
//ÔÂÁé
   TFairyMonster = class (TActor)
   protected
     m_LightSurface: TAsphyreLockableTexture;
     m_nLightX, m_nLightY: Integer;
   public
     constructor Create; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
     procedure DrawChr (dsurface: TAsphyreCanvas; dx, dy: integer; blend: Boolean; boFlag: Boolean); override;
  end;
//»ðÁé
   TFireMonster = class (TFairyMonster)
     procedure LoadSurface; override;
   end;
//ÍÃ×Ó
   TRabbitMonster = class(TSkeletonOma)
   	procedure CalcActorFrame; override;
   end;
//29.wilÀïºóÃæÀàËÆNPCÍ¼
   TNPCMonster = class (TActor)
    procedure CalcActorFrame; override;
   end;

//ÀÏ»¢
   TTigerMonster = class(TActor)
   public
     procedure CalcActorFrame; override;
   end;

implementation
uses ClMain, ClFunc, SoundUtil, AspWil;
{ TSnowyHousecarl }
procedure TSnowyHousecarl.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_HIT: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      if m_btRace = 106 then begin //Ñ©ÓòÌì½«
        m_boUseEffect := TRUE;
        firedir := m_btDir;
        m_nEffectStart:=m_nStartFrame;
        m_nEffectFrame:=m_nStartFrame;
        m_nEffectEnd:=m_nEndFrame;
        m_dwEffectStartTime:=GetTickCount;
        m_dwEffectFrameTime:=pm.ActAttack.ftime;
      end;
    end;
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
      m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
      m_dwFrameTime := pm.ActCritical.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
      if m_btRace = 106 then boEff := True; //Ñ©ÓòÌì½«
      firedir := m_btDir;
      m_nEffectStart:=m_nStartFrame;
      m_nEffectFrame:=m_nStartFrame;
      m_nEffectEnd:=m_nEndFrame;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=pm.ActCritical.ftime;
    end;
    else begin
      inherited;
    end;
  end;
end;

destructor TSnowyHousecarl.Destroy;
begin
  inherited;
end;

procedure TSnowyHousecarl.LoadSurface;
begin
  inherited LoadSurface;
  case m_btRace of
    102: begin  //Ñ©ÓòÊÌÎÀ
      if m_boUseEffect then
         AttackEffectSurface := g_WMonImagesArr[25].GetCachedImage (
                  930 + (firedir * 10) + m_nEffectFrame-m_nEffectStart,
                  ax, ay);
    end;
    105: begin //Ñ©ÓòÕ½½«
      if m_boUseEffect then
         AttackEffectSurface := g_WMonImagesArr[25].GetCachedImage (
                  420 + (firedir * 10) + m_nEffectFrame-m_nEffectStart,
                  ax, ay);
    end;
    106: begin //Ñ©ÓòÌì½«
      if m_boUseEffect then begin
        if not boEff then begin
          AttackEffectSurface := g_WMonImagesArr[25].GetCachedImage (
                  2571 + (firedir * 10) + m_nEffectFrame-m_nEffectStart,
                  ax, ay);
        end else begin
          AttackEffectSurface := g_WMonImagesArr[25].GetCachedImage (
                  2650 + (firedir * 10) + m_nEffectFrame-m_nEffectStart,
                  ax, ay);
        end;
      end;
    end;
  end;
end;


procedure TSnowyHousecarl.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
begin
  try
    if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢ }then exit;
    m_boMsgMuch := FALSE;
    if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
    RunActSound (m_nCurrentFrame - m_nStartFrame);
    RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   if m_boUseEffect then begin
      if m_boMsgMuch then m_dwEffectFrameTimetime := Round(m_dwEffectFrameTime * 2 / 3)
      else m_dwEffectFrameTimetime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
            m_dwEffectStartTime := GetTickCount;
         end else begin
            m_boUseEffect := FALSE;
            boEff := False;
         end;
      end;
   end;

   prv := m_nCurrentFrame;
    if m_nCurrentAction <> 0 then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;

      if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else m_dwFrameTimetime := m_dwFrameTime;

      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            Inc (m_nCurrentFrame);
            m_dwStartTime := GetTickCount;
         end else begin
            m_nCurrentAction := 0;
            BoUseDieEffect := FALSE;
         end;
      end;
      m_nCurrentDefFrame := 0;
      m_dwDefFrameTime := GetTickCount;
    end else begin
      if GetTickCount - m_dwSmoothMoveTime > 200 then begin
         if GetTickCount - m_dwDefFrameTime > 500 then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then
               m_nCurrentDefFrame := 0;
         end;
         DefaultMotion;
      end;
    end;


    if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
    end;
  except
    DebugOutStr('TheCrutchesSpider.Run');
  end;
end;

{ TSnowyLuxman }

procedure TSnowyLuxman.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_HIT: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
      m_nEffectFrame := m_nStartFrame;
      m_nEffectStart := m_nStartFrame;
      m_nEffectEnd := m_nEndFrame;
      m_dwEffectStartTime := GetTickCount;
      m_dwEffectFrameTime := m_dwFrameTime;
    end;
    else begin
      inherited;
    end;
  end;
end;

destructor TSnowyLuxman.Destroy;
begin
  inherited;
end;

procedure TSnowyLuxman.LoadSurface;
begin
  inherited LoadSurface;
  if m_boUseEffect then
     AttackEffectSurface := g_WMonImagesArr[26].GetCachedImage (
              1182 + + m_nEffectFrame-m_nEffectStart, 
              ax, ay);
end;

{ TSnowyGuards }

procedure TSnowyGuards.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;
  m_boUseEffect := False;
  case m_nCurrentAction of
    SM_TURN: begin
      if (m_nState and STATE_STONE_MODE) <> 0 then begin
         m_nStartFrame := pm.ActStand.start+740 + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
         m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
         m_dwFrameTime := pm.ActStand.ftime;
         m_dwStartTime := GetTickCount;
         m_nDefFrameCount := pm.ActStand.frame;
      end else begin
         m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
         m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
         m_dwFrameTime := pm.ActStand.ftime;
         m_dwStartTime := GetTickCount;
         m_nDefFrameCount := pm.ActStand.frame;
      end;
      Shift (m_btDir, 0, 0, 1);
    end;
    SM_HIT: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      m_boUseEffect := TRUE;
      firedir := m_btDir;
      EffImg := 1610;
      m_nEffectStart:=m_nStartFrame;
      m_nEffectFrame:=m_nStartFrame;
      m_nEffectEnd:=m_nEndFrame;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=pm.ActCritical.ftime;
    end;
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
      m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
      m_dwFrameTime := pm.ActCritical.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
      firedir := m_btDir;
      EffImg := 1690;
      m_nEffectStart:=m_nStartFrame;
      m_nEffectFrame:=m_nStartFrame;
      m_nEffectEnd:=m_nEndFrame;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=pm.ActCritical.ftime;
    end;
    SM_DIGUP: begin
      m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
      m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
      m_dwFrameTime := pm.ActDeath.ftime;
      m_dwStartTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
    end;
    SM_NOWDEATH: begin
      m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
      m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
      m_dwFrameTime := pm.ActDie.ftime;
      m_dwStartTime := GetTickCount;
      BoUseDieEffect := TRUE;
    end;
  else inherited;
  end;
end;

constructor TSnowyGuards.Create;
begin
   inherited Create;
   DieEffectSurface := nil;
   AttackEffectSurface := nil;
   BoUseDieEffect := False;
end;

destructor TSnowyGuards.Destroy;
begin
  inherited;
end;

procedure TSnowyGuards.DrawChr(dsurface: TAsphyreCanvas; dx,
  dy: integer; blend, boFlag: Boolean);
begin
  inherited;
end;


procedure TSnowyGuards.DrawEff(dsurface: TAsphyreCanvas; dx,
  dy: integer);
begin
  try
    if m_boUseEffect and (AttackEffectSurface <> nil) then begin
      dsurface.DrawBlend (
                  dx + ax + m_nShiftX,
                  dy + ay + m_nShiftY,
                  AttackEffectSurface);
    end;   

    if BoUseDieEffect and (DieEffectSurface <> nil) then begin
      dsurface.DrawBlend (
              dx + bx + m_nShiftX,
              dy + by + m_nShiftY,
              DieEffectSurface);
    end;
  except
    DebugOutStr('TSnowyGuards.DrawEff');
  end
end;

function TSnowyGuards.GetDefaultFrame(wmode: Boolean): integer;
var
   cf: integer;
   pm: PTMonsterAction;
begin
  Result:=0;//jacky
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  if m_boDeath then begin
    Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
  end else begin
    if (m_nState and STATE_STONE_MODE) <> 0 then begin
      Result := pm.ActStand.start +740 + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
    end else begin
      m_nDefFrameCount := pm.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
      else cf := m_nCurrentDefFrame;
      Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
    end;
  end;
end;

procedure TSnowyGuards.LoadSurface;
begin
  inherited;
  if m_boUseEffect then begin
     AttackEffectSurface := g_WMonImagesArr[26].GetCachedImage (
              EffImg + (firedir * 10) + m_nEffectFrame-m_nEffectStart,
              ax, ay);
  end;
  if BoUseDieEffect then begin
     DieEffectSurface := g_WMonImagesArr[26].GetCachedImage (
              1770 + m_nCurrentFrame-m_nStartFrame, //
              bx, by);
  end;
end;

procedure TSnowyGuards.Run;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   m_dwEffectFrameTimetime: longword;
begin
  try
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢} then exit;
   if m_boUseEffect then begin
      m_dwEffectFrameTimetime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
         m_dwEffectStartTime := GetTickCount;
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
         end else begin
            m_boUseEffect := FALSE;
         end;
      end;
   end;
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //ÁÖ¼úÀÇ¸· µî... ¾Ö´Ï¸ÞÀÌ¼Ç È¿°ú
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
   end;
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢}then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   //»ç¿îµå È¿°ú
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;

      if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else m_dwFrameTimetime := m_dwFrameTime;

      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            Inc (m_nCurrentFrame);
            m_dwStartTime := GetTickCount;
         end else begin
            //µ¿ÀÛÀÌ ³¡³².
            m_nCurrentAction := 0; //µ¿ÀÛ ¿Ï·á
            m_boUseEffect := FALSE;
            BoUseDieEffect := FALSE;
            //boUseBody := False;
         end;
      end;
      
      m_nCurrentDefFrame := 0;
      m_dwDefFrameTime := GetTickCount;
   end else begin
      if GetTickCount - m_dwSmoothMoveTime > 200 then begin
         if GetTickCount - m_dwDefFrameTime > 500 then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then
               m_nCurrentDefFrame := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
  except
    DebugOutStr('TSkeletonOma.Run');
  end;
end;

procedure TSnowyGuards.RunFrameAction(frame: integer);
var
   meff: TMapEffect;
begin
  if m_nCurrentAction = SM_DIGUP then begin
    if frame <> oldframe then begin
      if frame = 4 then begin
        meff := TMapEffect.Create (1854 + 10 * m_btDir, 6, m_nCurrX, m_nCurrY);
        meff.ImgLib := g_WMonImagesArr[26];
        meff.NextFrameTime := 100;
        meff.boC8 := False;
        PlayScene.m_EffectList.Add (meff);
      end;
    end;
    oldframe := frame;
  end;
end;

{ TSnowyBE }

procedure TSnowyBE.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_HIT: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
    end;
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
      m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
      m_dwFrameTime := pm.ActDeath.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
      firedir := m_btDir;
      m_nEffectStart:=m_nStartFrame;
      m_nEffectFrame:=m_nStartFrame;
      m_nEffectEnd:=m_nEndFrame;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=pm.ActDeath.ftime;
    end;
    else begin
      inherited;
    end;
  end;
end;

destructor TSnowyBE.Destroy;
begin

  inherited;
end;

procedure TSnowyBE.DrawChr(dsurface: TAsphyreCanvas; dx, dy: integer;
  blend, boFlag: Boolean);
var
  ceff: TColorEffect;
  idx, Wax, Way: Integer;
  d: TAsphyreLockableTexture;
begin
  try
    //if not (m_btDir in [0..7]) then exit;
    if m_btDir > 7 then Exit;
    if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; 
    end;

    ceff := GetDrawEffectValue;
    DrawMyShow(dsurface,dx,dy); //ÏÔÊ¾×ÔÉí¶¯»­
    if m_BodySurface <> nil then begin
      {if m_LightSurface1 <> nil then begin
        DrawBlend (dsurface,
                      dx + m_nLightX1 + m_nShiftX,
                      dy + m_nLightY1 + m_nShiftY,
                      m_LightSurface1, 1, 200);
      end; }
      DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
      if m_LightSurface <> nil then begin
        dsurface.DrawBlend (
                      dx + m_nLightX + m_nShiftX,
                      dy + m_nLightY + m_nShiftY,
                      m_LightSurface);
      end;
    end;
    if not m_boDeath then begin  //ËÀÍö²»ÏÔÊ¾
      if m_nState and $02000000 <> 0 then begin //Íò½£¹é×Ú»÷ÖÐ×´Ì¬
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, Wax, Way);
          if d <> nil then
            dsurface.DrawBlend (dx + Wax + m_nShiftX, dy + Way + m_nShiftY, d);
      end;
    end;
  except
    DebugOutStr('TSnowyBE.DrawChr');
  end;
end;

procedure TSnowyBE.LoadSurface;
begin
  inherited LoadSurface;
  if m_boUseEffect then begin
    case m_wAppearance of
      256: begin  //Ñ©ÓòÄ§Íõ´ó
        AttackEffectSurface := g_WMonImagesArr[25].GetCachedImage (
              3670 + (m_btDir * 10) + m_nEffectFrame-m_nEffectStart,
              ax, ay);
      end;
      267: begin //Ñ©ÓòÄ§ÍõÐ¡
        AttackEffectSurface := g_WMonImagesArr[26].GetCachedImage (
              3470 + (m_btDir * 10) + m_nEffectFrame-m_nEffectStart,
              ax, ay);
      end;
      268: begin //Ñ©ÓòÄ§ÍõÖÐ
        AttackEffectSurface := g_WMonImagesArr[26].GetCachedImage (
              4500 + (m_btDir * 10) + m_nEffectFrame-m_nEffectStart,
              ax, ay);
      end;
    end;
  end;
  case m_wAppearance of
    256: begin  //Ñ©ÓòÄ§Íõ´ó
      m_LightSurface := g_WMonImagesArr[25].GetCachedImage (2740 + m_nCurrentFrame+500, m_nLightX, m_nLightY);
    //  m_LightSurface1  := g_WMonImagesArr[25].GetCachedImage (3500 + m_nCurrentFrame, m_nLightX1, m_nLightY1);
    end;
    267: begin //Ñ©ÓòÄ§ÍõÐ¡
      m_LightSurface := g_WMonImagesArr[26].GetCachedImage (2540 + m_nCurrentFrame+500, m_nLightX, m_nLightY);
    end;
    268: begin //Ñ©ÓòÄ§ÍõÖÐ
      m_LightSurface := g_WMonImagesArr[26].GetCachedImage (3570 + m_nCurrentFrame+500, m_nLightX, m_nLightY);
    end;
  end;
end;

{ TFoxRed }

procedure TFoxRed.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_HIT: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      if m_btRace = 108 then begin //ºÚºü
        m_boUseEffect := TRUE;
        firedir := m_btDir;
        m_nEffectStart:=m_nStartFrame;
        m_nEffectFrame:=m_nStartFrame;
        m_nEffectEnd:=m_nEndFrame;
        m_dwEffectStartTime:=GetTickCount;
        m_dwEffectFrameTime:=pm.ActAttack.ftime;
      end;
    end;
    SM_LIGHTING, SM_FAIRYATTACKRATE: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
    end;
    else begin
      inherited;
    end;
  end;
end;

destructor TFoxRed.Destroy;
begin

  inherited;
end;

procedure TFoxRed.DrawEff(dsurface: TAsphyreCanvas; dx, dy: integer);
begin
  try
    if m_boUseEffect and (AttackEffectSurface <> nil) then begin
      dsurface.DrawBlend (
                  dx + ax + m_nShiftX,
                  dy + ay + m_nShiftY,
                  AttackEffectSurface);
    end;
  except
    DebugOutStr('TFoxRed.DrawEff');
  end
end;

procedure TFoxRed.LoadSurface;
begin
  inherited;
  if m_boUseEffect then begin
     AttackEffectSurface := g_WMonImagesArr[32].GetCachedImage (
              352 + (m_btDir * 10) + m_nEffectFrame-m_nEffectStart,
              ax, ay);
  end;
end;

procedure TFoxRed.Run;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   m_dwEffectFrameTimetime: longword;
begin
  try
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢} then exit;
   if m_boUseEffect then begin
      m_dwEffectFrameTimetime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
         m_dwEffectStartTime := GetTickCount;
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
         end else begin
            m_boUseEffect := FALSE;
         end;
      end;
   end;
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //ÁÖ¼úÀÇ¸· µî... ¾Ö´Ï¸ÞÀÌ¼Ç È¿°ú
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
   end;
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢}then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   //»ç¿îµå È¿°ú
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;

      if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else m_dwFrameTimetime := m_dwFrameTime;

      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            Inc (m_nCurrentFrame);
            m_dwStartTime := GetTickCount;
         end else begin
            //µ¿ÀÛÀÌ ³¡³².
            m_nCurrentAction := 0; //µ¿ÀÛ ¿Ï·á
            m_boUseEffect := FALSE;
            BoUseDieEffect := FALSE;
            //boUseBody := False;
         end;
      end;
      
      m_nCurrentDefFrame := 0;
      m_dwDefFrameTime := GetTickCount;
   end else begin
      if GetTickCount - m_dwSmoothMoveTime > 200 then begin
         if GetTickCount - m_dwDefFrameTime > 500 then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then
               m_nCurrentDefFrame := 0;
         end;
         DefaultMotion;
      end;
   end;

   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
  except
    DebugOutStr('TFoxRed.Run');
  end;
end;

procedure TFoxRed.RunFrameAction(frame: integer);
var
  Effect :TFoxRedDrawEffect;
  MapEff: TMapEffect;
begin
  if (frame <> oldframe) then begin
    case m_btRace of
      109: begin  //³àºü
        case m_nCurrentAction of
          SM_LIGHTING: begin
            if m_nCurrentFrame = m_nEndFrame then begin
              Effect := TFoxRedDrawEffect.Create(m_nTargetX, m_nTargetY, g_WMonImagesArr[32], 780, 10, 80, 10);
              if Effect <> nil then begin
                Effect.MagOwner:=Self;
                PlayScene.m_EffectList.Add(Effect);
              end;
            end;
          end;
          SM_FAIRYATTACKRATE: begin
            if m_nCurrentFrame = m_nEndFrame then begin
              MapEff := TMapEffect.Create (1320, 16, m_nTargetX, m_nTargetY);
              MapEff.ImgLib := g_WMagicImages;
              MapEff.NextFrameTime := 80;
              PlayScene.m_EffectList.Add (MapEff);
            end;
          end;
        end;
      end;
      110: begin //ËØºü
        case m_nCurrentAction of
          SM_LIGHTING: begin
            if m_nCurrentFrame = m_nEndFrame then begin
              MapEff := TMapEffect.Create (1330, 19, m_nTargetX, m_nTargetY);
              MapEff.ImgLib := g_WMonImagesArr[32];
              MapEff.NextFrameTime := 80;
              PlayScene.m_EffectList.Add (MapEff);
            end;
          end;
          SM_FAIRYATTACKRATE: begin
            if m_nCurrentFrame = m_nEndFrame then begin
              MapEff := TMapEffect.Create (1340, 16, m_nTargetX, m_nTargetY);
              MapEff.ImgLib := g_WMagicImages;
              MapEff.NextFrameTime := 80;
              PlayScene.m_EffectList.Add (MapEff);
            end;
          end;
        end;
      end;
    end;
  end;
  oldframe := frame;
end;

{ TFoxBall }

procedure TFoxBall.CalcActorFrame;
var
  Effect :TFoxRedDrawEffect;
  Meff1: TMagicEff;
  pm: PTMonsterAction;
  meff: TMapEffect;
  Target: TActor;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  if m_btRace = 113 then begin
    m_nBodyOffset := m_nBodyOffset + GetStateImg;
  end;
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_HIT: begin
      m_nStartFrame := pm.ActAttack.start;
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      if m_btRace = 113 then begin
          meff := TMapEffect.Create (100, 10, m_nCurrX, m_nCurrY);
          meff.MagOwner:=Self;
          meff.ImgLib := g_WMonImagesArr[14];
          meff.NextFrameTime := 100;
          PlayScene.m_EffectList.Add (meff);
      end;
    end;
    SM_LIGHTING, SM_FAIRYATTACKRATE: begin
      m_nStartFrame := pm.ActAttack.start;
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      if m_btRace = 113 then begin
        if m_nCurrentAction = SM_LIGHTING then begin
          Effect := TFoxRedDrawEffect.Create(m_nTargetX, m_nTargetY, g_WMonImagesArr[32], 780, 10, 80, 10);
          if Effect <> nil then begin
            Effect.MagOwner:=Self;
            PlayScene.m_EffectList.Add(Effect);
          end;
        end else begin
          Target := PlayScene.FindActor (m_nTargetRecog);
          if Target <> nil then begin
            Meff1 := TObjectEffects.Create(Target,g_WMonImagesArr[32],3350,20,120,TRUE{BlendÄ£Ê½});
            Meff1.ImgLib := g_WMonImagesArr[32];
            Meff1.MagOwner:=Self;
            PlayScene.m_EffectList.Add(Meff1);
          end;
        end;
      end;
    end;
    SM_TURN:
       begin
          m_nStartFrame := pm.ActStand.start;
          m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
          m_dwFrameTime := pm.ActStand.ftime;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActStand.frame;
          Shift (m_btDir, 0, 0, 1);
       end;
    SM_WALK:
       begin
          m_nStartFrame := pm.ActWalk.start;
          m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
          m_dwFrameTime := pm.ActWalk.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := pm.ActWalk.UseTick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          if m_nCurrentAction = SM_WALK then
             Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
          else
             Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
       end;

    SM_STRUCK:
       begin
         if m_btRace <> 113 then begin
           m_nStartFrame := pm.ActStruck.start;
           m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
           m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
           m_dwStartTime := GetTickCount;
         end;
       end;
    SM_DEATH:
       begin
          m_nStartFrame := pm.ActDie.start;
          m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
          m_nStartFrame := m_nEndFrame; //
          m_dwFrameTime := pm.ActDie.ftime;
          m_dwStartTime := GetTickCount;
       end;
    SM_NOWDEATH:
       begin
          m_nBodyOffset := GetOffset (m_wAppearance);
          m_nStartFrame := pm.ActDie.start;
          m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
          m_dwFrameTime := pm.ActDie.ftime;
          m_dwStartTime := GetTickCount;
       end;
    SM_SKELETON:
       begin
          m_nStartFrame := pm.ActDeath.start;
          m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
          m_dwFrameTime := pm.ActDeath.ftime;
          m_dwStartTime := GetTickCount;
       end;
  end;
end;

destructor TFoxBall.Destroy;
begin

  inherited;
end;

procedure TFoxBall.DrawEff(dsurface: TAsphyreCanvas; dx, dy: integer);
begin
  if m_boDeath and (m_nCurrentFrame >= m_nEndFrame) then Exit;
  if (m_LightSurface <> nil) then begin
    dsurface.DrawBlend (
                dx + m_nLightX + m_nShiftX,
                dy + m_nLightY + m_nShiftY,
                m_LightSurface);
  end;
end;

function TFoxBall.GetDefaultFrame(wmode: Boolean): integer;
var
  cf: integer;
  pm: PTMonsterAction;
begin
  Result:=0;
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;
  if m_boDeath then begin            //ËÀÍö
    if m_boSkeleton then            //µØÉÏÊ¬Ìå÷¼÷Ã
       Result := pm.ActDeath.start
    else Result := pm.ActDie.start + (pm.ActDie.frame - 1);
  end else begin
    m_nDefFrameCount := pm.ActStand.frame;
    if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
      else cf := m_nCurrentDefFrame;
    Result := pm.ActStand.start + + cf;
  end;
end;

function TFoxBall.GetStateImg: Integer;
begin
  Result:= 0;//¸ù¾ÝÑªÁ¿¸Ä±ä×´Ì¬
  if not m_boDeath then begin
    if (m_Abil.HP < Round(m_Abil.MaxHP * 0.2)) then Result:= 4
    else  if (m_Abil.HP < Round(m_Abil.MaxHP * 0.4)) then Result:= 3
    else  if (m_Abil.HP < Round(m_Abil.MaxHP * 0.6)) then Result:= 2
    else  if (m_Abil.HP < Round(m_Abil.MaxHP * 0.8)) then Result:= 1;
  end;
  Result := Result * 80;
end;

procedure TFoxBall.LoadSurface;
var
   mimg: TAspWMImages;
   nErrCode: Byte;
begin


   mimg := GetMonImg (m_wAppearance);
   if mimg <> nil then begin
      if (not m_boReverseFrame) then begin
         m_BodySurface := mimg.GetCachedImage (m_nBodyOffset + m_nCurrentFrame, m_nPx, m_nPy);
      end else begin
         m_BodySurface := mimg.GetCachedImage (
                            m_nBodyOffset + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame),
                            m_nPx, m_nPy);

      end;
   end;

  if m_boDeath and (m_nCurrentFrame >= m_nEndFrame) then Exit;
  if m_btRace = 111 then begin
    m_LightSurface := g_WMonImagesArr[32].GetCachedImage (m_nBodyOffset + m_nCurrentFrame + 50, m_nLightX, m_nLightY);
  end else if m_btRace = 113 then begin
    m_LightSurface := g_WMonImagesArr[32].GetCachedImage (m_nBodyOffset + m_nCurrentFrame + 40, m_nLightX, m_nLightY);
  end;

  {case m_wAppearance of
    325: begin  //ºüÔÂÖ®ÑÛ
      m_LightSurface := g_WMonImagesArr[32].GetCachedImage (m_nBodyOffset + m_nCurrentFrame, m_nLightX, m_nLightY);
    end;
    {326: begin
      m_LightSurface := g_WMonImagesArr[32].GetCachedImage (2840 + m_nCurrentFrame, m_nLightX, m_nLightY);
    end;
    327: begin

    end;
  end   }
end;

{ TFoxStone }

procedure TFoxStone.CalcActorFrame;
var
   pm: PTMonsterAction;     
var
  bo11: boolean;
  meff: TMagicEff;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;   

  case m_nCurrentAction of
    {SM_HIT: begin
      m_nStartFrame := pm.ActAttack.start;
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
    end;  }
    SM_LIGHTING{, SM_FAIRYATTACKRATE}: begin
      {m_nStartFrame := pm.ActCritical.start;
      m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
      m_dwFrameTime := pm.ActCritical.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);  }
      {meff := TMagicEff.Create (111, 51, scx, scy, sctx, scty, mtype, Recusion, anitime);
      meff.MagExplosionBase := 640;
      meff.TargetActor := nil; //target;
      meff.NextFrameTime := 46;
      meff.ExplosionFrame := 40;
      meff.Light := 3;
      if wimg <> nil then
        meff.ImgLib:=wimg;  }
      PlayScene.NewMagic(Self,111,51,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
      if not bo11 then MyPlaySound ('wav\M58-3.wav');
    end;
    {SM_TURN:
       begin
          m_nStartFrame := pm.ActStand.start;
          m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
          m_dwFrameTime := pm.ActStand.ftime;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActStand.frame;
          Shift (m_btDir, 0, 0, 1);
       end;
    SM_WALK:
       begin
          m_nStartFrame := pm.ActWalk.start;
          m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
          m_dwFrameTime := pm.ActWalk.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := pm.ActWalk.UseTick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          if m_nCurrentAction = SM_WALK then
             Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
          else
             Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
       end;

    SM_STRUCK:
       begin
          m_nStartFrame := pm.ActStruck.start;
          m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
          m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
          m_dwStartTime := GetTickCount;
       end; 
    SM_DEATH:
       begin
          m_nStartFrame := pm.ActDie.start;
          m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
          m_nStartFrame := m_nEndFrame; //
          m_dwFrameTime := pm.ActDie.ftime;
          m_dwStartTime := GetTickCount;
       end; }
    SM_NOWDEATH:
       begin
          m_nStartFrame := pm.ActDie.start;
          m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
          m_dwFrameTime := pm.ActDie.ftime;
          m_dwStartTime := GetTickCount;
          BoUseDieEffect := TRUE;
       end;  
    {SM_SKELETON:
       begin
          m_nStartFrame := pm.ActDeath.start;
          m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
          m_dwFrameTime := pm.ActDeath.ftime;
          m_dwStartTime := GetTickCount;
       end; }
  end;
end;

destructor TFoxStone.Destroy;
begin

  inherited;
end;

procedure TFoxStone.DrawEff(dsurface: TAsphyreCanvas; dx, dy: integer);
begin
    if BoUseDieEffect and (DieEffectSurface <> nil) then begin
      dsurface.DrawBlend (
              dx + bx + m_nShiftX,
              dy + by + m_nShiftY,
              DieEffectSurface);
    end;
end;

function TFoxStone.GetDefaultFrame(wmode: Boolean): integer;
var
  cf: integer;
  pm: PTMonsterAction;
begin
  Result:=0;
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;
  if m_boDeath then begin            //ËÀÍö
    if m_boSkeleton then            //µØÉÏÊ¬Ìå÷¼÷Ã
       Result := pm.ActDeath.start
    else Result := pm.ActDie.start + (pm.ActDie.frame - 1);
  end else begin
    m_nDefFrameCount := 4;
    if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
      else cf := m_nCurrentDefFrame;
    Result := pm.ActStand.start + + cf;
  end;
end;

procedure TFoxStone.LoadSurface;
begin
  inherited;
  if BoUseDieEffect then
     DieEffectSurface := g_WMonImagesArr[32].GetCachedImage (
               m_nBodyOffset+m_nCurrentFrame+10, //
              bx, by);
end;

procedure TFoxStone.Run;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   m_dwEffectFrameTimetime: longword;
begin
  try
 {  if m_boUseEffect then begin
      m_dwEffectFrameTimetime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
         m_dwEffectStartTime := GetTickCount;
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
         end else begin
            m_boUseEffect := FALSE;
         end;
      end;
   end;}
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //ÁÖ¼úÀÇ¸· µî... ¾Ö´Ï¸ÞÀÌ¼Ç È¿°ú
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
   end;
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢}then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   //»ç¿îµå È¿°ú
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;

      if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else m_dwFrameTimetime := m_dwFrameTime;

      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            Inc (m_nCurrentFrame);
            m_dwStartTime := GetTickCount;
         end else begin
            //µ¿ÀÛÀÌ ³¡³².
            m_nCurrentAction := 0; //µ¿ÀÛ ¿Ï·á
            m_boUseEffect := FALSE;
            BoUseDieEffect := FALSE;
            //boUseBody := False;
         end;
      end;
      
      m_nCurrentDefFrame := 0;
      m_dwDefFrameTime := GetTickCount;
   end;
   if m_nCurrentAction <> SM_NOWDEATH then
    if GetTickCount - m_dwSmoothMoveTime > 200 then begin
       if GetTickCount - m_dwDefFrameTime > 500 then begin
          m_dwDefFrameTime := GetTickCount;
          Inc (m_nCurrentDefFrame);
          if m_nCurrentDefFrame >= m_nDefFrameCount then
             m_nCurrentDefFrame := 0;
       end;
       DefaultMotion;
    end;

   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
  except
    DebugOutStr('TFoxStone.Run');
  end;
end;

{ TFoxBall1 }

procedure TFoxBall1.CalcActorFrame;
var
  pm: PTMonsterAction;
begin
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    {SM_HIT: begin
      m_nStartFrame := pm.ActAttack.start;
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
    end; }
    SM_FAIRYATTACKRATE: begin
    	m_nCurrentFrame := -1;
      boState := True;
      m_nStartFrame := pm.ActAttack.start;
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;

    end;
    SM_LIGHTING: begin
    	m_nCurrentFrame := -1;
      boState := True;
       m_nStartFrame := pm.ActStruck.start;
       m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
       m_dwFrameTime := pm.ActStruck.ftime;
       m_dwStartTime := GetTickCount;
     // Shift (m_btDir, 0, 0, 1);

    end;
    {SM_TURN:
       begin
          m_nStartFrame := pm.ActStand.start;
          m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
          m_dwFrameTime := pm.ActStand.ftime;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActStand.frame;
          Shift (m_btDir, 0, 0, 1);
       end;
    SM_WALK:
       begin
          m_nStartFrame := pm.ActWalk.start;
          m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
          m_dwFrameTime := pm.ActWalk.ftime;
          m_dwStartTime := GetTickCount;
          m_nMaxTick := pm.ActWalk.UseTick;
          m_nCurTick := 0;
          m_nMoveStep := 1;
          if m_nCurrentAction = SM_WALK then
             Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
          else
             Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
       end; }

    {SM_STRUCK:
       begin
           m_nStartFrame := pm.ActStruck.start;
           m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
           m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
           m_dwStartTime := GetTickCount;
           //boState := True;
       end;}
    SM_DEATH:
       begin
  m_nCurrentFrame := -1;
  boState := False;
          m_nStartFrame := pm.ActDie.start;
          m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
          m_nStartFrame := m_nEndFrame; //
          m_dwFrameTime := pm.ActDie.ftime;
          m_dwStartTime := GetTickCount;
       end;
    SM_NOWDEATH:
       begin
  m_nCurrentFrame := -1;
  boState := False;
          m_nBodyOffset := GetOffset (m_wAppearance);
          m_nStartFrame := pm.ActDie.start;
          m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
          m_dwFrameTime := pm.ActDie.ftime;
          m_dwStartTime := GetTickCount;
       end;
    SM_SKELETON:
       begin
  m_nCurrentFrame := -1;
  boState := False;
          m_nStartFrame := pm.ActDeath.start;
          m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
          m_dwFrameTime := pm.ActDeath.ftime;
          m_dwStartTime := GetTickCount;
       end;
  end;
end;

constructor TFoxBall1.Create;
begin
   inherited Create;
   boState := False;
end;

procedure TFoxBall1.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   bo11: boolean;
begin
  try
    if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) then exit;

    m_boMsgMuch := FALSE;
    //if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
    //
    RunActSound (m_nCurrentFrame - m_nStartFrame);
    RunFrameAction (m_nCurrentFrame - m_nStartFrame);

    if m_boUseEffect then begin
      if m_boMsgMuch then m_dwEffectFrameTimetime := Round(m_dwEffectFrameTime * 2 / 3)
      else m_dwEffectFrameTimetime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
            m_dwEffectStartTime := GetTickCount;
         end else begin
            m_boUseEffect := FALSE;
         end;
      end;
    end;

   prv := m_nCurrentFrame;
   if (m_nCurrentAction <> 0) or boState then begin
    	m_nCurrentAction := 0;
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame >= m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;

      if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
      else m_dwFrameTimetime := m_dwFrameTime;

      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            Inc (m_nCurrentFrame);
            m_dwStartTime := GetTickCount;
         end else begin
          	m_nCurrentAction := 0;
            BoUseDieEffect := FALSE;
         end;
      end;
      m_nCurrentDefFrame := 0;
      m_dwDefFrameTime := GetTickCount;
   end else begin
      if GetTickCount - m_dwSmoothMoveTime > 200 then begin
         if GetTickCount - m_dwDefFrameTime > 500 then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then
               m_nCurrentDefFrame := 0;
         end;
         DefaultMotion;
      end;
   end;


   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
  except
    DebugOutStr('TFoxBall1.Run');
  end;
end;

{ TFairyMonster }
constructor TFairyMonster.Create;
begin
  inherited;
  m_LightSurface := nil;
end;

procedure TFairyMonster.CalcActorFrame;
var
   pm: PTMonsterAction;
   actor: TActor;
   scx, scy, stx, sty: integer;
   bo11: boolean;
begin
   m_nCurrentFrame := -1;
   m_boUseMagic := False;
   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   case m_nCurrentAction of
      SM_TURN: begin
        m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := pm.ActStand.frame;
        Shift (m_btDir, 0, 0, 1);
      end;
      SM_WALK: begin
        m_nStartFrame := pm.ActWalk.start + m_btDir * (pm.ActWalk.frame + pm.ActWalk.skip);
        m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
        m_dwFrameTime := pm.ActWalk.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := pm.ActWalk.UseTick;
        m_nCurTick := 0;
        //WarMode := FALSE;
        m_nMoveStep := 1;
        if m_nCurrentAction = SM_WALK then
           Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
        else  //sm_backstep
           Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
      end;
      SM_FAIRYATTACKRATE: begin //ÔÂÁéÖØ»÷
        m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
        m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
        m_dwFrameTime := pm.ActCritical.ftime;
        m_dwStartTime := GetTickCount;

        m_boUseMagic := True;
        m_nCurEffFrame := 0;
        m_nMagLight := 2;
        m_nSpellFrame := DEFSPELLFRAME;
        m_dwWaitMagicRequest := GetTickCount;
        m_boWarMode := True;
        m_dwWarModeTime := GetTickCount;

        m_CurMagic.ServerMagicCode := 111;
        m_CurMagic.MagicSerial := 200;
        m_CurMagic.EffectNumber := 200;
        m_CurMagic.targx := m_nTargetX;
        m_CurMagic.targy := m_nTargetY;
        m_CurMagic.target := m_nTargetRecog;
        m_CurMagic.EffectType := mtFly;

        m_nMagicStartSound := 11010;
        m_nMagicExplosionSound := 11012;
        PlaySound (m_nMagicStartSound);
        Shift (m_btDir, 0, 0, 1);
      end;
      SM_HIT,
      SM_LIGHTING:
         begin
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;

            m_boUseMagic := True;
            m_nCurEffFrame := 0;
            m_nMagLight := 2;
            m_nSpellFrame := 5;
            m_dwWaitMagicRequest := GetTickCount;
            m_boWarMode := True;
            m_dwWarModeTime := GetTickCount;

            m_CurMagic.ServerMagicCode := 111;
            m_CurMagic.MagicSerial := 199;
            m_CurMagic.EffectNumber := 199;
            m_CurMagic.targx := m_nTargetX;
            m_CurMagic.targy := m_nTargetY;
            m_CurMagic.target := m_nTargetRecog;
            m_CurMagic.EffectType := mtFly;

            m_nMagicStartSound := 11000;
            m_nMagicExplosionSound := 11002;
            PlaySound (m_nMagicStartSound);
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_STRUCK:
         begin
            m_nStartFrame := pm.ActStruck.start + m_btDir * (pm.ActStruck.frame + pm.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_DEATH:
         begin
            m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_nStartFrame := m_nEndFrame; //
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_NOWDEATH:
         begin
            m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
            m_dwFrameTime := pm.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_SKELETON:
         begin
            m_nStartFrame := pm.ActDeath.start;
            m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
            m_dwFrameTime := pm.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
         end;
   end;
end;

procedure TFairyMonster.DrawChr (dsurface: TAsphyreCanvas; dx, dy: integer;
	blend: Boolean; boFlag: Boolean);
var
  idx: integer;
  d: TAsphyreLockableTexture;
  ceff: TColorEffect;
  wimg: TAspWMImages;
  ax, ay: integer;
begin
	try
   if m_btDir > 7 then Exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;

   if m_LightSurface<>nil then
     dsurface.DrawBlend (
                dx + m_nLightX + m_nShiftX,
                dy + m_nLightY + m_nShiftY,
                m_LightSurface.ClientRect, m_LightSurface);



   ceff := GetDrawEffectValue;

   if m_BodySurface <> nil then
      DrawEffSurface (dsurface,
                      m_BodySurface,
                      dx + m_nPx + m_nShiftX,
                      dy + m_nPy + m_nShiftY,
                      blend,
                      ceff);
    if not m_boDeath then begin  //ËÀÍö²»ÏÔÊ¾
      if m_nState and $02000000 <> 0 then begin //Íò½£¹é×Ú»÷ÖÐ×´Ì¬
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, ax, ay);
          if d <> nil then
          	dsurface.DrawBlend (dx + ax + m_nShiftX, dy + ay + m_nShiftY, d.ClientRect, d);
      end;
      if m_nState and $00004000 <> 0 then begin //¶¨Éí×´Ì¬
          idx := 1080 + (m_nGenAniCount mod 8);
          d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            dsurface.DrawBlend (dx + ax + m_nShiftX, dy + ay + m_nShiftY, d.ClientRect, d);
      end;
    end;
   if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then
      if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
          GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx, m_btDir, m_CurMagic.EffectLevelEx);
         idx := idx + m_nCurEffFrame;
         if wimg <> nil then
            d := wimg.GetCachedImage (idx, ax, ay);
         if d <> nil then
         		dsurface.DrawBlend ( dx + ax + m_nShiftX, dy + ay + m_nShiftY, d.ClientRect, d);
      end;
  except
  	DebugOutStr('[Exception] TFairyMonster.DrawChr');
  end;
end;

procedure TFairyMonster.LoadSurface;
var
  mimg: TAspWMImages;
begin
	try
  	inherited LoadSurface;
  	mimg := GetMonImg (m_wAppearance);
  	if mimg <> nil then begin
    	if (not m_boReverseFrame) then
      	m_LightSurface:=mimg.GetCachedImage(GetOffset(m_wAppearance)+m_nCurrentFrame-360, m_nLightX, m_nLightY)
    	else
     	  m_LightSurface:=mimg.GetCachedImage(GetOffset (m_wAppearance) + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame)-360,
       																	 m_nLightX, m_nLightY);
  	end;
	except
  	DebugOutStr('[Exception] TFairyMonster.LoadSurface');
	end;
end;

{ TFireMonster }

procedure TFireMonster.LoadSurface;
var
  mimg: TAspWMImages;
begin
	try
  	inherited LoadSurface;
  	mimg := GetMonImg (m_wAppearance);
  	if mimg <> nil then begin
    	if (not m_boReverseFrame) then
      	m_LightSurface:=mimg.GetCachedImage(GetOffset(m_wAppearance)+m_nCurrentFrame+340, m_nLightX, m_nLightY)
    	else
     	  m_LightSurface:=mimg.GetCachedImage(GetOffset (m_wAppearance) + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame)+340,
       																	 m_nLightX, m_nLightY);
  	end;
	except
  	DebugOutStr('[Exception] TFairyMonster.LoadSurface');
	end;
end;
{ TRabbitMonster }

procedure TRabbitMonster.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
   m_nCurrentFrame := -1;
   m_boReverseFrame := FALSE;
   m_boUseEffect := FALSE;

   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   case m_nCurrentAction of
     SM_FLYAXE: begin
        m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
        m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
        m_dwFrameTime := pm.ActDeath.ftime;
        m_dwStartTime := GetTickCount;
        m_dwWarModeTime := GetTickCount;
        Shift (m_btDir, 0, 0, 1);
     end
     else inherited;
   end;
end;

{ TNPCMonster }

procedure TNPCMonster.CalcActorFrame;
begin
	if m_nCurrentAction <> SM_HIT then
  	inherited CalcActorFrame
  else m_nCurrentAction := 0;
end;

{ TTigerMonster }  // new copy by liuzhigang
procedure TTigerMonster.CalcActorFrame;  // ÀÏ»¢ºÍÇàÁú¶¼ÊÇÔÚÕâ¸öµØ·½ÊµÏÖµÄ¡£
var
  pm: PTMonsterAction;
  Meff:TMagicEff;
begin
  try
    m_nCurrentFrame := -1;
    m_boReverseFrame := FALSE;
    m_boUseEffect := FALSE;

    m_nBodyOffset := GetOffset (m_wAppearance); // ÓÉÕâ¸öÇø·ÖÈ¡Í¼Æ¬µÄÆ«ÒÆ
    pm := GetRaceByPM (m_btRace,m_wAppearance);
    if pm = nil then exit;

    case m_nCurrentAction of
      SM_HIT: begin //ÆÕÍ¨¹¥»÷
        m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := GetTickCount;
        Shift (m_btDir, 0, 0, 1);
        meff :=TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMonImagesArr[34], m_btDir*10+503, 7, 100, True);
        PlayScene.m_EffectList.Add(meff);
      end;
      SM_LIGHTING: begin //ÌØÊâ¹¥»÷
        m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
        m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
        m_dwFrameTime := pm.ActCritical.ftime;
        m_dwStartTime := GetTickCount;
        Shift (m_btDir, 0, 0, 1);
        meff :=TNormalDrawEffect.Create(m_nCurrX, m_nCurrY, g_WMonImagesArr[34], m_btDir*10+581, 9, 100, True);
        PlayScene.m_EffectList.Add(meff);
      end;
      else inherited;
    end;
  except
    DebugOutStr('TTigerMonster.CalcActorFrame');
  end;
end;

end.
