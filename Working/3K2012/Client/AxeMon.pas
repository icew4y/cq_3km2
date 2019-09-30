unit AxeMon;//¹ÖÎïµ¥Ôª£¿ÄÇÎªÊ²Ã´Òª¼Ó¸öaxe?

interface

uses
  Windows, Classes, 
  Grobal2, DxDraws, CliUtil, ClFunc, magiceff, Actor, ClEvent, SysUtils;


const
   DEATHEFFECTBASE = 340;//÷¼÷Ã¶´ÀïµÄ÷¼÷ÃËÀÍöÐ§¹û
   DEATHFIREEFFECTBASE = 2860;//µÀ²ÝÈËËÀÍöÐ§¹û
   AXEMONATTACKFRAME = 6;//mon3ÖÐÖÀ¸«¿ÞÂ·520-525,,530-535,,540-545,,
   KUDEGIGASBASE = 1445;//mon3ÖÐ¶´ÇùÅç¶¾Ö­Ð§¹û,,ÔÚ´«Ææ·þÎñÆ÷ÎÄ¼þÖÐ,kudegigas,,±í¶´Çù?
   COWMONFIREBASE = 1800;//mon4ÖÐ»ðÑæÎÖÂê»ðÑæ¹¥»÷Ð§¹û,,,,´«Ææ·þÎñÆ÷µÄmonÖÐ,,cowmon ±í»ðÑæÎÖÂê»¹ÊÇËüËùÊôµÄÒ»¸ö´óÀà?
   //»ðÑæÎÖÂêÊôÓÚcowmon?
   COWMONLIGHTBASE = 1900;//mon4ÖÐÎÖÂê½ÌÖ÷µÄÄ§·¨¹¥»÷Ð§¹û£¬light??µç¹â¹¥»÷??
   ZOMBILIGHTINGBASE = 350;//mon5ÖÐµç½©Ê¬µÄ¼«¹â¹¥»÷Ð§¹û
   ZOMBIDIEBASE = 340; //mon5ÖÐµç½©Ê¬ËÀÍöµÄ¹âÓ°Ð§¹û
   SCULPTUREFIREBASE = 1680;//mon7ÖÐ×æÂê½ÌÖ÷ÊÖÖÐÄÇÍÅ»ðµÄ¹¥»÷Ð§¹û
   MOTHPOISONGASBASE = 3590;//mon4ÖÐïÆ¶êÅç¶¾Ö­Ð§¹û,,ïÆ¶êÔÚ´«Ææ·þÎñ¶ËµÄÃû×Ö½Ð
   DUNGPOISONGASBASE = 3590;//mon3ÖÐºçÄ§Ð«ÎÀ¹¥»÷Ð§¹û
   WARRIORELFFIREBASE = 820;//warrior elf fire mon18ÖÐÉñÊÞ´µ»ðµÄÄ§·¨¹¥»÷Ð§¹û
   WARRIORELFFIREBASE1 = 250;//warrior elf fire magic8ÖÐÊ¥ÊÞ´µ»ðµÄÄ§·¨¹¥»÷Ð§¹û
   SUPERIORGUARDBASE = 760;  //´øµ¶»¤ÎÀ

type
   TSkeletonOma = class (TActor) //Size:25C   //¿ÞÂ·ºÍ°ëÊÞ×å
   private
   protected
      EffectSurface: TDirectDrawSurface;    //0x240
      ax:Integer;                           //0x244
      ay: integer;                          //0x248
   public
      constructor Create; override;
      //destructor Destroy; override;
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
   end;

   TDualAxeOma = class (TSkeletonOma)  //µµ³¢´øÁö´Â ¸÷ //Ë«¸«¹Ö£¬£¬ÖÀ¸«¿ÞÂ·??
   private
   public
      procedure Run; override;
      destructor Destroy; override;
   end;

   TCatMon = class (TSkeletonOma)
   private
   public
      procedure DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
      destructor Destroy; override;
   end;

   TWealthAnimalMon = class (TSkeletonOma) //¸»¹óÊÞ
   private
      DieEffectSurface    :TDirectDrawSurface;    //0x254
      bx                  :integer;
      by                  :integer;
   public
      constructor Create; override;
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
      destructor Destroy; override;
   end;

   TArcherMon = class (TCatMon)//Size: 0x25C Address: 0x00461A90   //¹­¼ýÊÖ¹ÖÎï
   public
      procedure Run; override;
      destructor Destroy; override;
   end;

   TScorpionMon = class (TCatMon) //Ð«×Ó¹ÖÎï
   public
     destructor Destroy; override;
   end;

   THuSuABi = class (TSkeletonOma)
   public
      procedure LoadSurface; override;
      destructor Destroy; override;
   end;

   TZombiDigOut = class (TSkeletonOma) //Ê¯Ä¹Ê¬ÍõÅÀ³öÀ´  ,,´ÓtskeletonomaÅÉÉú,,Ê¯Ä¹Ê¬Íõ(½©Ê¬ZombiÀàµÄÒ»ÖÖ)Ò²ÊôÓÚ°ëÊÞ¿ÞÂ·×å?
   public
      procedure RunFrameAction (frame: integer); override;
      destructor Destroy; override;
   end;

   TZombiZilkin = class (TSkeletonOma)
   public
     destructor Destroy; override;
   end;

   TWhiteSkeleton = class (TSkeletonOma) //°×É«¿ÞÂ·??
   public
     destructor Destroy; override;
   end;

   TGasKuDeGi = class (TActor)//Size 0x274
   protected
      AttackEffectSurface :TDirectDrawSurface;    //0x250
      DieEffectSurface    :TDirectDrawSurface;    //0x254
      m_LightSurface      :TDirectDrawSurface;   //ÔÂÁé±íÃæ²ã¹â 20080722
      BoUseDieEffect      :Boolean;    //0x258
      firedir             :integer;    //0x25C
      fire16dir           :integer;    //0c260
      m_nLightX           :Integer;
      m_nLightY           :Integer;
      ax                  :integer;    //0x264
      ay                  :integer;    //0x268
      bx                  :integer;
      by                  :integer;
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure CalcActorFrame; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;

   TFireCowFaceMon = class (TGasKuDeGi)
   public
      function   Light: integer; override;
      destructor Destroy; override;
   end;

   TCowFaceKing = class (TGasKuDeGi)
   public
      function   Light: integer; override;
      destructor Destroy; override;
   end;

   TZombiLighting = class (TGasKuDeGi)
   protected
   public
     destructor Destroy; override;
   end;

   TheCrutchesSpider = class (TGasKuDeGi) //½ðÕÈÖ©Öë
   protected
   public
     destructor Destroy; override;
     procedure Run; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
   end;

   TYanLeiWangSpider = class (TGasKuDeGi) //À×Ñ×ÖëÍõ
   protected
   public
     procedure CalcActorFrame; override;
     procedure Run; override;
   end;

   TSnowy = class (TGasKuDeGi) //Ñ©Óòº®±ùÄ§¡¢Ñ©ÓòÃðÌìÄ§¡¢Ñ©ÓòÎå¶¾Ä§
   protected
   public
     destructor Destroy; override;
     procedure Run; override;
     procedure CalcActorFrame; override;
     procedure LoadSurface; override;
   end;

   TSuperiorGuard = class (TGasKuDeGi)
   protected
   public
     destructor Destroy; override;
   end;
   TSwordsmanMon = class (TGasKuDeGi)   //Áé»êÊÕ¸îÕß,À¶Ó°µ¶¿Ís
   protected
   public
     destructor Destroy; override;
   end;
   TExplosionSpider = class (TGasKuDeGi)
   protected
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      destructor Destroy; override;
   end;
   TFlyingSpider = class (TSkeletonOma)//Size: 0x25C Address: 0x00461F38
   protected
   public
     procedure CalcActorFrame; override;
     destructor Destroy; override;
   end;
   TSculptureMon = class (TSkeletonOma) //µñÏñÀà¹ÖÎï?
   private
      AttackEffectSurface: TDirectDrawSurface;
      ax, ay, firedir: integer;
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
      procedure Run; override;
      destructor Destroy; override;
   end;

   TSculptureKingMon = class (TSculptureMon)//×æÂê½ÌÖ÷
   public
     destructor Destroy; override;
   end;

   TRedThunderZuma = class (TGasKuDeGi)
    boCasted:Boolean;
   protected
   public
     procedure CalcActorFrame; override;
     constructor Create; override;
     function   GetDefaultFrame (wmode: Boolean): integer; override;
     procedure LoadSurface; override;
   end;

   TSmallElfMonster = class (TSkeletonOma)//elf,,Ð¡¾«Áé£¬£¬°«ÈË, ÌÔÆø¹í, ¶ñ×÷¾çµÄÈË£¬£¬
   public
     destructor Destroy; override;
   end;

   TWarriorElfMonster = class (TSkeletonOma)//warrior,,ÓÂÊ¿ ,,,ÓÂÊ¿¾«Áé=ÉñÊÞ(¿´À´´Ó×ÖÃæÉÏÕæÄÑÀí½â,±ØÐë¿¿ÍæCQµÄÊµ¼ù+¶ÁÏÂÃæ¾ßÌåµÄÔ´³ÌÐòÀ´²Â½âËüµÄÒâË¼)
   private
      oldframe: integer;
   public
      procedure  RunFrameAction (frame: integer); override;
      destructor Destroy; override;
   end;
   //´óòÚò¼
   TElectronicScolpionMon = class (TGasKuDeGi)//Size 0x274 0x3c
   protected
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      destructor Destroy; override;
   end;
   TBossPigMon = class (TGasKuDeGi)//0x3d
   protected
   public
      procedure LoadSurface; override;
      destructor Destroy; override;
   end;
   TKingOfSculpureKingMon = class (TGasKuDeGi)//0x3e
   protected
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      destructor Destroy; override;
   end;
   TSkeletonKingMon = class (TGasKuDeGi)//0x3f
   protected
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure Run; override;
      destructor Destroy; override;
   end;
   TSamuraiMon = class (TGasKuDeGi)//0x41
   protected
   public
     destructor Destroy; override;
   end;
   TSkeletonSoldierMon = class (TGasKuDeGi)//0x42 0x43 0x44
   protected
   public
     destructor Destroy; override;
   end;
   TSkeletonArcherMon = class (TArcherMon)//Size: 0x26C Address: 0x004623B4 //0x45
      AttackEffectSurface :TDirectDrawSurface;//0x25C
      bo260:Boolean;
      n264:integer;
      n268:integer;
   protected
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
      destructor Destroy; override;
   end;
   TBanyaGuardMon = class (TSkeletonArcherMon)//Size: 0x270 Address: 0x00462430 0x46 0x47 0x48 0x4e
     n26C:TDirectDrawSurface;
   protected
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;
   TStoneMonster = class (TSkeletonArcherMon)//Size: 0x270 0x4d 0x4b
     n26C:TDirectDrawSurface;
   protected
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;
   TPBOMA1Mon = class (TCatMon)//0x49
   protected
   public
     destructor Destroy; override;
      procedure Run; override;
   end;
   TPBOMA6Mon = class (TCatMon)//0x4f
   protected
   public
     destructor Destroy; override;
      procedure Run; override;
   end;
   TAngel = class (TBanyaGuardMon)//Size: 0x27C 0x51
     n270:Integer;
     n274:Integer;
     n278:TDirectDrawSurface;
   protected
   public
      destructor Destroy; override;
      procedure  LoadSurface; override;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
   end;
   TFireDragon = class (TSkeletonArcherMon)//0x53
     n270:TDirectDrawSurface;
   private
      procedure AttackEff;
   protected
     firedir             :Byte;
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;
   //ÐÂ»ðÁú£¬²»Ö§³ÖÀ×µç
   TNewFireDragon = class (TFireDragon)
   private
   	boChangeColor: Boolean;
   public
     constructor Create; override;
     procedure CalcActorFrame; override;
   	 procedure Run; override;
     procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
   end;
   TDragonStatue = class (TSkeletonArcherMon)//Size: 0x270 0x54
     n26C:TDirectDrawSurface;
   protected
   public
      constructor Create; override;
      destructor Destroy; override;
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure Run; override;
      procedure DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;
implementation

uses
   ClMain, SoundUtil, WIL, MShare;


{============================== TSkeletonOma =============================}

//      ÇØ°ñ ¿À¸¶(ÇØ°ñ, Å«µµ³¢ÇØ°ñ, ÇØ°ñÀü»ç)

{--------------------------}


constructor TSkeletonOma.Create;
begin
   inherited Create;
   EffectSurface := nil;
   m_boUseEffect := FALSE;
end;

{destructor TSkeletonOma.Destroy;
begin
  inherited;
end;  }

procedure TSkeletonOma.CalcActorFrame;
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
      SM_TURN:
         begin
            m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
            m_dwFrameTime := pm.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := pm.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_WALK, SM_BACKSTEP:
         begin
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
      SM_DIGUP: //°È±â ¾øÀ½, SM_DIGUP, ¹æÇâ ¾øÀ½.
         begin
            if (m_wAppearance <> 9010) and (m_wAppearance <> 9011) and (m_wAppearance <> 9012) then begin //Ç¿»¯÷¼÷Ã
              if (m_btRace = 23) then begin //or (m_btRace = 54) or (m_btRace = 55) then begin
                 //¹é°ñ
                 m_nStartFrame := pm.ActDeath.start;
              end else begin
                 m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
              end;
              m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
              m_dwFrameTime := pm.ActDeath.ftime;
              m_dwStartTime := GetTickCount;
              //WarMode := FALSE;
              Shift (m_btDir, 0, 0, 1);
            end;
         end;
      SM_DIGDOWN:
         begin
            if m_btRace = 55 then begin
               //½Å¼ö1 ÀÎ °æ¿ì ¿ªº¯½Å
               m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
               m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
               m_dwFrameTime := pm.ActCritical.ftime;
               m_dwStartTime := GetTickCount;
               m_boReverseFrame := TRUE;
               //WarMode := FALSE;
               Shift (m_btDir, 0, 0, 1);
            end;
         end;
      SM_HIT,
      SM_FLYAXE,
      SM_LIGHTING:
         begin
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            if (m_btRace = 16) or (m_btRace = 54) then
               m_boUseEffect := TRUE;
            Shift (m_btDir, 0, 0, 1);


            m_nEffectFrame := m_nStartFrame;
            m_nEffectStart := m_nStartFrame;

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
            if m_btRace <> 22 then
               m_boUseEffect := TRUE;
         end;
      SM_SKELETON:
         begin
            m_nStartFrame := pm.ActDeath.start;
            m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
            m_dwFrameTime := pm.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_ALIVE:
         begin
            m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
            m_dwFrameTime := pm.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
         end;
   end;
end;

function  TSkeletonOma.GetDefaultFrame (wmode: Boolean): integer;
var
   cf: integer;
   pm: PTMonsterAction;
begin
   Result:=0;//jacky
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   if m_boDeath then begin
      //¿ì¸é±ÍÀÏ °æ¿ì
      if m_wAppearance in [30..34, 151] then //¿ì¸é±ÍÀÎ °æ¿ì ½ÃÃ¼°¡ »ç¶÷À» µ¤´Â °ÍÀ» ¸·±â À§ÇØ
         m_nDownDrawLevel := 1;

      if m_boSkeleton then
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      m_nDefFrameCount := pm.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
      else cf := m_nCurrentDefFrame;
      Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
   end;
end;

procedure  TSkeletonOma.LoadSurface;
begin
  inherited LoadSurface;
  case m_btRace of
    14, 15, 17, 22, 53: begin
      if m_boUseEffect then
        EffectSurface := {FrmMain.WMon3Img20080720×¢ÊÍ}g_WMonImagesArr[2].GetCachedImage (DEATHEFFECTBASE + m_nCurrentFrame-m_nStartFrame, ax, ay);
    end;
    23: begin//±äÒì÷¼÷Ã
      if m_nCurrentAction = SM_DIGUP then begin
        m_BodySurface := nil;
        EffectSurface := {FrmMain.WMon4Img20080720×¢ÊÍ}g_WMonImagesArr[3].GetCachedImage (m_nBodyOffset + m_nCurrentFrame, ax, ay);
        m_boUseEffect := TRUE;
      end else m_boUseEffect := FALSE;
    end;
    55: begin //Ê¥ÊÞ
      if m_boUseEffect then begin
        if (m_wAppearance =9013) or (m_wAppearance =9014) or (m_wAppearance =9015) then begin
          EffectSurface := g_WMagic8Images16.GetCachedImage (1970 + (m_wAppearance-9013)*10 + m_nCurrentFrame-m_nStartFrame, ax, ay);  
        end;
      end;
    end;
  end;
end;

procedure  TSkeletonOma.Run;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   bofly: Boolean;
begin
  try
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


procedure TSkeletonOma.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
   ceff: TColorEffect;
   idx: Integer;
   d: TDirectDrawSurface;
   Wax, Way: Integer;
begin
  try
   //if not (m_btDir in [0..7]) then exit;
   if m_btDir > 7 then Exit;

   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //bodysurfaceµîÀÌ loadsurface¸¦ ´Ù½Ã ºÎ¸£Áö ¾Ê¾Æ ¸Þ¸ð¸®°¡ ÇÁ¸®µÇ´Â °ÍÀ» ¸·À½
   end;

   ceff := GetDrawEffectValue;

   DrawMyShow(dsurface,dx,dy); //ÏÔÊ¾×ÔÉí¶¯»­
   if m_BodySurface <> nil then begin
      DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
   end;
    if not m_boDeath then begin  //ËÀÍö²»ÏÔÊ¾
      if m_nState and $02000000 <> 0 then begin //Íò½£¹é×Ú»÷ÖÐ×´Ì¬
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, Wax, Way);
          if d <> nil then
            DrawBlend (dsurface, dx + Wax + m_nShiftX, dy + Way + m_nShiftY, d, 120);
      end;
      if m_nState and $00004000 <> 0 then begin //¶¨Éí×´Ì¬
          idx := 1080 + (m_nGenAniCount mod 8);
          d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
      end;
    end;
   if m_boUseEffect then
      //È¾ºÚ
      if EffectSurface <> nil then begin
         DrawBlend (dsurface,
                    dx + ax + m_nShiftX,
                    dy + ay + m_nShiftY,
                    EffectSurface, 200);
      end;
  except
    DebugOutStr('TSkeletonOma.DrawChr');
  end;
end;




{============================== TSkeletonOma =============================}

//      ÇØ°ñ ¿À¸¶(ÇØ°ñ, Å«µµ³¢ÇØ°ñ, ÇØ°ñÀü»ç)

{--------------------------}


destructor TDualAxeOma.Destroy;
begin
  inherited;
end;

procedure  TDualAxeOma.Run;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   meff: TFlyingAxe;
begin
  try
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢} then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   //»ç¿îµå È¿°ú
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   //ÇÁ·¡ÀÓ¸¶´Ù ÇØ¾ß ÇÒÀÏ
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
         end;
         if (m_nCurrentAction = SM_FLYAXE) and (m_nCurrentFrame-m_nStartFrame = AXEMONATTACKFRAME-4) then begin
            //¸¶¹ý ¹ß»ç
            meff := TFlyingAxe (PlayScene.NewFlyObject (self,
                             m_nCurrX,
                             m_nCurrY,
                             m_nTargetX,
                             m_nTargetY,
                             m_nTargetRecog,
                             mtFlyAxe));
            if meff <> nil then begin
               case m_btRace of
                  15: meff.FlyImageBase := FLYOMAAXEBASE;
                  22: begin
                    if m_wAppearance = 328 then begin  //ºüÔÂ½Ç³æ
                      meff.FlyImageBase := 3586;
                      meff.ImgLib := g_WMonImagesArr[32];
                      meff.frame := 4;
                    end else if m_wAppearance = 329 then begin
                      meff.FlyImageBase := 4016;
                      meff.ImgLib := g_WMonImagesArr[32];
                      meff.frame := 4;
                    end else begin
                      meff.FlyImageBase := THORNBASE;
                      meff.ImgLib := g_WMonImagesArr[2];
                    end;
                  end;
               end;
            end;      
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
    DebugOutStr('TDualAxeOma.Run');
  end;
end;


{============================== TGasKuDeGi =============================}

//         TCatMon : ±ªÀÌ,  ÇÁ·¡ÀÓÀº ÇØ°ñÀÌ¶û °°°í, ÅÍÁö´Â ¾Ö´Ï°¡ ¾øÀ½.


destructor TWarriorElfMonster.Destroy;
begin
  inherited;
end;

procedure  TWarriorElfMonster.RunFrameAction (frame: integer); //ÇÁ·¡ÀÓ¸¶´Ù µ¶Æ¯ÇÏ°Ô ÇØ¾ßÇÒÀÏ
var
   meff: TMapEffect;
begin
   if m_nCurrentAction = SM_HIT then begin
      if (frame = 5) and (oldframe <> frame) then begin
        case m_wAppearance of
          273: begin//ÆÕÍ¨Ê¥ÊÞ
            meff := TMapEffect.Create (WARRIORELFFIREBASE1 + 10 * m_btDir + 1, 5, m_nCurrX, m_nCurrY);
            meff.ImgLib := g_WMagic8Images;
            meff.NextFrameTime := 100;
            PlayScene.m_EffectList.Add (meff);
          end;
          9013..9015: begin//Ç¿»¯Ê¥ÊÞ
            meff := TMapEffect.Create (WARRIORELFFIREBASE1 + (m_wAppearance-9013)*80 + 10 * m_btDir + 1, 5, m_nCurrX, m_nCurrY);
            meff.ImgLib := g_WMagic8Images;
            meff.NextFrameTime := 100;
            PlayScene.m_EffectList.Add (meff);
          end;
          else begin//ÆÕÍ¨ÉñÊÞ
            meff := TMapEffect.Create (WARRIORELFFIREBASE + 10 * m_btDir + 1, 5, m_nCurrX, m_nCurrY);
            meff.ImgLib := g_WMonImagesArr[17];
            meff.NextFrameTime := 100;
            PlayScene.m_EffectList.Add (meff);
          end;
        end;
      end;
      oldframe := frame;
   end;
end;

{============================== TGasKuDeGi =============================}

//         TCatMon : ±ªÀÌ,  ÇÁ·¡ÀÓÀº ÇØ°ñÀÌ¶û °°°í, ÅÍÁö´Â ¾Ö´Ï°¡ ¾øÀ½.

{--------------------------}


destructor TCatMon.Destroy;
begin
  inherited;
end;

procedure TCatMon.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
  ceff: TColorEffect;
  idx, Wax, Way: Integer;
  d: TDirectDrawSurface;
begin
  try
   //if not (m_btDir in [0..7]) then exit;
   if m_btDir > 7 then Exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //bodysurfaceµîÀÌ loadsurface¸¦ ´Ù½Ã ºÎ¸£Áö ¾Ê¾Æ ¸Þ¸ð¸®°¡ ÇÁ¸®µÇ´Â °ÍÀ» ¸·À½
   end;

   ceff := GetDrawEffectValue;
   DrawMyShow(dsurface,dx,dy); //ÏÔÊ¾×ÔÉí¶¯»­
   if m_BodySurface <> nil then
      DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
    if not m_boDeath then begin  //ËÀÍö²»ÏÔÊ¾
      if m_nState and $02000000 <> 0 then begin //Íò½£¹é×Ú»÷ÖÐ×´Ì¬
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, Wax, Way);
          if d <> nil then
            DrawBlend (dsurface, dx + Wax + m_nShiftX, dy + Way + m_nShiftY, d, 150);
      end;
      if m_nState and $00004000 <> 0 then begin //¶¨Éí×´Ì¬
          idx := 1080 + (m_nGenAniCount mod 8);
          d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
      end;
    end;
  except
    DebugOutStr('TCatMon.DrawChr');
  end;
end;


{============================= TArcherMon =============================}


destructor TArcherMon.Destroy;
begin

  inherited;
end;

procedure TArcherMon.Run;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   meff: TFlyingAxe;
begin
  try
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //ÁÖ¼úÀÇ¸· µî... ¾Ö´Ï¸ÞÀÌ¼Ç È¿°ú
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
   end;
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢} then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   //»ç¿îµå È¿°ú
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   //ÇÁ·¡ÀÓ¸¶´Ù ÇØ¾ß ÇÒÀÏ
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
         end;
         if (m_nCurrentAction = SM_FLYAXE) and (m_nCurrentFrame-m_nStartFrame = 4) then begin
            //È­»ì ³ª°¨
//(** 6¿ùÆÐÄ¡

            meff := TFlyingArrow (PlayScene.NewFlyObject (self,
                             m_nCurrX,
                             m_nCurrY,
                             m_nTargetX,
                             m_nTargetY,
                             m_nTargetRecog,
                             mtFlyArrow));
            if meff <> nil then begin
               meff.ImgLib := {FrmMain.WEffectImg}g_WEffectImages; 
               meff.NextFrameTime := 30;
               meff.FlyImageBase := ARCHERBASE2;
            end;
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
    DebugOutStr('TArcherMon.Run');
  end;
end;


{============================= TZombiDigOut =============================}


destructor TZombiDigOut.Destroy;
begin
  inherited;
end;

procedure TZombiDigOut.RunFrameAction (frame: integer);
var
   clevent: TClEvent;
begin
   if m_nCurrentAction = SM_DIGUP then begin
      if frame = 6 then begin
         clevent := TClEvent.Create (m_nCurrentEvent, m_nCurrX, m_nCurrY, ET_DIGOUTZOMBI);
         clevent.m_nDir := m_btDir;
         EventMan.AddEvent (clevent);
      end;
   end;
end;


{============================== THuSuABi =============================}

//      Çã¼ö¾Æºñ

{--------------------------}


destructor THuSuABi.Destroy;
begin
  inherited;
end;

procedure  THuSuABi.LoadSurface;
begin
   inherited LoadSurface;
   if m_boUseEffect then
      EffectSurface := g_WMonImagesArr[2].GetCachedImage (DEATHFIREEFFECTBASE + m_nCurrentFrame-m_nStartFrame, ax, ay);
end;


{============================== TGasKuDeGi =============================}

//      ´ëÇü±¸µ¥±â (°¡½º½î´Â ±¸µ¥±â)

{--------------------------}


constructor TGasKuDeGi.Create;
begin
   inherited Create;
   AttackEffectSurface := nil;
   DieEffectSurface := nil;
   m_boUseEffect := FALSE;
   BoUseDieEffect := FALSE;
end;

procedure TGasKuDeGi.CalcActorFrame;
var
   pm: PTMonsterAction;
   actor: TActor;
   scx, scy, stx, sty: integer;
begin
   m_nCurrentFrame := -1;

   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   case m_nCurrentAction of
      SM_TURN:
         begin
            m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
            m_dwFrameTime := pm.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := pm.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_WALK:
         begin
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
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            m_boUseEffect := TRUE;
            m_nEffectFrame := m_nStartFrame;
            m_nEffectStart := m_nStartFrame;
            m_nEffectEnd := m_nEndFrame;
            m_dwEffectStartTime := GetTickCount;
            m_dwEffectFrameTime := m_dwFrameTime;
            Shift (m_btDir, 0, 0, 1);

                m_nMagicStartSound := 11010;
                m_nMagicExplosionSound := 11012;

                PlaySound (m_nMagicStartSound);
            end;
      SM_HIT,
      SM_LIGHTING:
         begin
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            //m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
            if m_btRace <> 96 then
            m_boUseEffect := TRUE;
            firedir := m_btDir;
            m_nEffectFrame := m_nStartFrame;
            m_nEffectStart := m_nStartFrame;
            if m_btRace = 20 then m_nEffectEnd := m_nEndFrame + 1
            else m_nEffectEnd := m_nEndFrame;
            m_dwEffectStartTime := GetTickCount;
            m_dwEffectFrameTime := m_dwFrameTime;

            //16¹æÇâÀÎ ¸¶¹ý ¼³Á¤
            actor := PlayScene.FindActor (m_nTargetRecog);
            if actor <> nil then begin
               PlayScene.ScreenXYfromMCXY (m_nCurrX, m_nCurrY, scx, scy);
               PlayScene.ScreenXYfromMCXY (actor.m_nCurrX, actor.m_nCurrY, stx, sty);
               fire16dir := GetFlyDirection16 (scx, scy, stx, sty);
            end else
               fire16dir := firedir * 2;
               
            if (m_btRace = 100) then begin  //ÔÂÁé¹¥»÷ÉùÒô 20080405
                    m_nMagicStartSound := 11000;
                    m_nMagicExplosionSound := 11002;
                PlaySound (m_nMagicStartSound);
            end;
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

            if (m_btRace = 40) or (m_btRace = 65) or (m_btRace = 66) or (m_btRace = 67) or (m_btRace = 68) or (m_btRace = 69) or (m_btRace = 100) then
               BoUseDieEffect := TRUE;
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

function  TGasKuDeGi.GetDefaultFrame (wmode: Boolean): integer;
var
   cf: integer;
   pm: PTMonsterAction;
begin
   Result:=0;//jacky
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   if m_boDeath then begin
      if m_boSkeleton then
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      m_nDefFrameCount := pm.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
      else cf := m_nCurrentDefFrame;
      Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
   end;
end;

procedure  TGasKuDeGi.LoadSurface;
begin
   inherited LoadSurface;
   case m_btRace of
      //¹¥»÷Ð§¹û
      16://¶´Çù
         begin
            if m_boUseEffect then
               AttackEffectSurface := {FrmMain.WMon3Img20080720×¢ÊÍ}g_WMonImagesArr[2].GetCachedImage (
                        KUDEGIGASBASE-1 + (firedir * 10) + m_nEffectFrame-m_nEffectStart, //°¡½º´Â Ã³À½ ÇÑÇÁ·¹À½ ´Ê°Ô ½ÃÀÛÇÔ.
                        ax, ay);
         end;
      20://»ðÑæÎÖÂê
         begin
            if m_boUseEffect then
               AttackEffectSurface := g_WMonImagesArr[3].GetCachedImage (
                        COWMONFIREBASE + (firedir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
         end;
      21://ÎÖÂê½ÌÖ÷
         begin
            if m_boUseEffect then
               AttackEffectSurface := {FrmMain.WMon4Img20080720×¢ÊÍ}g_WMonImagesArr[3].GetCachedImage (
                        COWMONLIGHTBASE + (firedir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
         end;
      24: //´øµ¶»¤ÎÀ
         begin
            if m_boUseEffect then
               AttackEffectSurface := {FrmMain.WMonImg0080720×¢ÊÍ}g_WMonImagesArr[0].GetCachedImage (
                        SUPERIORGUARDBASE + (m_btDir * 8) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
         end;

      40://½©Ê¬1
         begin
            if m_boUseEffect then begin
               AttackEffectSurface := {FrmMain.WMon5Img20080720×¢ÊÍ}g_WMonImagesArr[4].GetCachedImage (
                        ZOMBILIGHTINGBASE + (fire16dir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
            end;
            if BoUseDieEffect then begin
               DieEffectSurface := {FrmMain.WMon5Img20080720×¢ÊÍ}g_WMonImagesArr[4].GetCachedImage (
                        ZOMBIDIEBASE + m_nCurrentFrame-m_nStartFrame, //
                        bx, by);
            end;
         end;
      52://Ð¨¶ê
         begin
            if m_boUseEffect then
               AttackEffectSurface := {FrmMain.WMon4Img20080720×¢ÊÍ}g_WMonImagesArr[3].GetCachedImage (
                        MOTHPOISONGASBASE + (firedir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
         end;
      53://·à³æ
         begin
            if m_boUseEffect then
               AttackEffectSurface := {FrmMain.WMon3Img20080720×¢ÊÍ}g_WMonImagesArr[2].GetCachedImage (
                        DUNGPOISONGASBASE + (firedir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
         end;
      64: begin
        if m_boUseEffect then begin
          AttackEffectSurface := {FrmMain.WMon20Img20080720×¢ÊÍ}g_WMonImagesArr[19].GetCachedImage (
                        720 + (firedir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
        end;
      end;
      65: begin
        if BoUseDieEffect then begin
          DieEffectSurface:= {FrmMain.WMon20Img20080720×¢ÊÍ}g_WMonImagesArr[19].GetCachedImage (
                        350 + m_nCurrentFrame-m_nStartFrame, bx, by);
        end;
      end;
      66: begin
        if BoUseDieEffect then begin
          DieEffectSurface:= {FrmMain.WMon20Img20080720×¢ÊÍ}g_WMonImagesArr[19].GetCachedImage (
                        1600 + m_nCurrentFrame-m_nStartFrame, bx, by);
        end;
      end;
      67: begin
        if BoUseDieEffect then begin
          DieEffectSurface:= {FrmMain.WMon20Img20080720×¢ÊÍ}g_WMonImagesArr[19].GetCachedImage (
                        1160 + (m_btDir * 10) + m_nCurrentFrame-m_nStartFrame, bx, by);
        end;
      end;
      68: begin
        if BoUseDieEffect then begin
          DieEffectSurface:= {FrmMain.WMon20Img20080720×¢ÊÍ}g_WMonImagesArr[19].GetCachedImage (
                        1600 + m_nCurrentFrame-m_nStartFrame, bx, by);
        end;
      end;
      96: begin
       if m_boUseEffect then
               AttackEffectSurface := {FrmMain.WMonImg0080720×¢ÊÍ}g_WMonImagesArr[24].GetCachedImage (
                        426 + (m_btDir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
      end;
      97: begin
       if m_boUseEffect then
               AttackEffectSurface := {FrmMain.WMonImg0080720×¢ÊÍ}g_WMonImagesArr[24].GetCachedImage (
                        932 + (m_btDir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
      end;
     100: begin   //ÔÂÁé ¹¥»÷
        m_LightSurface := g_WMonImagesArr[17].GetCachedImage (920 + m_nCurrentFrame-360, m_nLightX, m_nLightY);//ÔÂÁé2007.12.12
        if (m_boUseEffect) and (m_nCurrentAction = SM_LIGHTING) then
               AttackEffectSurface := g_WMagic5Images.GetCachedImage (
                            100 + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
        if (m_boUseEffect) and (m_nCurrentAction = SM_FAIRYATTACKRATE) then begin
               AttackEffectSurface := g_WMagic5Images.GetCachedImage (
                            280 + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
        end;                          
        if m_boUseEffect and (m_nCurrentAction = SM_DIGUP) then begin
               AttackEffectSurface := g_WMonImagesArr[17].GetCachedImage (m_nBodyOffset + m_nCurrentFrame, ax, ay);
        end;
        if BoUseDieEffect then begin  //ÔÂÁéËÀÍö 20080322
          DieEffectSurface:= {FrmMain.WMon18Img20080720×¢ÊÍ}g_WMonImagesArr[17].GetCachedImage (
                        1180 + (m_btDir * 9) + m_nCurrentFrame-m_nEndFrame, bx, by);
        end;
     end;
   end;
end;

procedure  TGasKuDeGi.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   bo11: boolean;
begin
  try
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //ÁÖ¼úÀÇ¸· µî... ¾Ö´Ï¸ÞÀÌ¼Ç È¿°ú
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
   end;
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢ }then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   //
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   if m_btRace = 96 then begin
     if (m_nCurrentAction = SM_HIT) and (m_nCurrentFrame - m_nStartFrame = 2) then  m_boUseEffect := True;
   end;

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
   
  //ÔÂÁé Ê¹ÓÃÄ§·¨
    if m_boUseEffect then begin
       if m_nEffectFrame >= m_nEffectEnd-1 then begin //¸¶¹ý ¹ß»ç ½ÃÁ¡
         if (m_btRace = 100) and (m_nCurrentAction = SM_LIGHTING) then begin
            PlayScene.NewMagic (Self,100,100,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtFly,True,0,0,bo11);
         end;
         if (m_btRace = 100) and (m_nCurrentAction = SM_FAIRYATTACKRATE) then begin
            PlayScene.NewMagic (Self,101,101,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtFly,True,0,0,bo11);
         end;

         if bo11 then
            PlaySound (m_nMagicExplosionSound);
       end;
    end;           
  //ÔÂÁé Ê¹ÓÃÄ§·¨

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
    DebugOutStr('TGasKuDeGi.Run');
  end;
end;


procedure TGasKuDeGi.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
  ceff: TColorEffect;
  idx, Wax, Way: Integer;
  d: TDirectDrawSurface;
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
   if m_btRace = 100 then
      DrawBlend (dsurface,
                    dx + m_nLightX + m_nShiftX,
                    dy + m_nLightY + m_nShiftY,
                    m_LightSurface, 200);
      DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
   end;
    if not m_boDeath then begin  //ËÀÍö²»ÏÔÊ¾
      if m_nState and $02000000 <> 0 then begin //Íò½£¹é×Ú»÷ÖÐ×´Ì¬
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, Wax, Way);
          if d <> nil then
            DrawBlend (dsurface, dx + Wax + m_nShiftX, dy + Way + m_nShiftY, d, 150);
      end;
      if m_nState and $00004000 <> 0 then begin //¶¨Éí×´Ì¬
          idx := 1080 + (m_nGenAniCount mod 8);
          d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
      end;
    end;
  except
    DebugOutStr('TGasKuDeGi.DrawChr');
  end;
end;

procedure TGasKuDeGi.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
  try
    if m_boUseEffect and (AttackEffectSurface <> nil) then begin
      DrawBlend (dsurface,
                  dx + ax + m_nShiftX,
                  dy + ay + m_nShiftY,
                  AttackEffectSurface, 200);
    end;


    if BoUseDieEffect and (DieEffectSurface <> nil) then begin
      DrawBlend (dsurface,
              dx + bx + m_nShiftX,
              dy + by + m_nShiftY,
              DieEffectSurface, 200);
    end;
  except
     DebugOutStr('TGasKuDeGi.DrawEff');
  end
end;



{-----------------------------------------------------------}

destructor TFireCowFaceMon.Destroy;
begin
  inherited;
end;

function  TFireCowFaceMon.Light: integer; //»ðÃæÅ£¹Ö??
var
   l: integer;
begin
   l := m_nChrLight;
   if l < 2 then begin
      if m_boUseEffect then
         l := 2;
   end;
   Result := l;
end;

destructor TCowFaceKing.Destroy;
begin
  inherited;
end;

function  TCowFaceKing.Light: integer;
var
   l: integer;
begin
   l := m_nChrLight;
   if l < 2 then begin
      if m_boUseEffect then
         l := 2;
   end;
   Result := l;
end;


{-----------------------------------------------------------}

//procedure TZombiLighting.Run;


{-----------------------------------------------------------}


procedure TSculptureMon.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
   m_nCurrentFrame := -1;

   m_nBodyOffset := GetOffset (m_wAppearance);   //È¡Í¼
   pm := GetRaceByPM (m_btRace,m_wAppearance);   //È¡¶¯×÷Ïà¹Ø²½Êý
   if pm = nil then Exit;
   m_boUseEffect := False;

   case m_nCurrentAction of
      SM_TURN:   //×ªÉí
         begin
            if (m_nState and STATE_STONE_MODE) <> 0 then begin
               if (m_btRace = 48) or (m_btRace = 49) then
                  m_nStartFrame := pm.ActDeath.start // + Dir * (pm.ActDeath.frame + pm.ActDeath.skip)
               else  //´ËÎªµñÏó
                  m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
               m_nEndFrame := m_nStartFrame;
               m_dwFrameTime := pm.ActDeath.ftime;
               m_dwStartTime := GetTickCount;
               m_nDefFrameCount := pm.ActDeath.frame;
            end else begin
               m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
               m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
               m_dwFrameTime := pm.ActStand.ftime;
               m_dwStartTime := GetTickCount;
               m_nDefFrameCount := pm.ActStand.frame;
            end;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_WALK, SM_BACKSTEP: //×ßÂ·£¬ºóÍË
         begin
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
      SM_DIGUP: //°È±â ¾øÀ½, SM_DIGUP, ¹æÇâ ¾øÀ½.
         begin
            if (m_btRace = 48) or (m_btRace = 49) then begin
               m_nStartFrame := pm.ActDeath.start;
            end else begin
               m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
            end;
            m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
            m_dwFrameTime := pm.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := FALSE;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_HIT:
         begin
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            if m_btRace = 49 then begin
               m_boUseEffect := TRUE;
               firedir := m_btDir;
               m_nEffectFrame := 0; //startframe;
               m_nEffectStart := 0; //startframe;
               m_nEffectEnd := m_nEffectStart + 8;
               m_dwEffectStartTime := GetTickCount;
               m_dwEffectFrameTime := m_dwFrameTime;
            end;
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
   end;
end;

procedure  TSculptureMon.LoadSurface;
begin
   inherited LoadSurface;
   case m_btRace of
      48, 49:
         begin
            if m_boUseEffect then
               AttackEffectSurface := {FrmMain.WMon7Img20080720×¢ÊÍ}g_WMonImagesArr[6].GetCachedImage (
                        SCULPTUREFIREBASE + (firedir * 10) + m_nEffectFrame-m_nEffectStart, //
                        ax, ay);
         end;
   (*   91: begin
          case m_nCurrentAction of
            SM_WALK: begin
              m_boUseEffect := TRUE;
              m_nEffectStart:=0;
              m_nEffectFrame:=0;
              m_nEffectEnd:=6;
              m_dwEffectStartTime:=GetTickCount;
              m_dwEffectFrameTime:=150;
              AttackEffectSurface := g_WMonImagesArr[23].GetCachedImage (
                                2350 + (m_btDir * 10) + m_nEffectFrame - m_nEffectStart,
                                ax, ay);
            end;
            SM_Hit: begin
              m_boUseEffect := TRUE;
              m_nEffectStart:=0;
              m_nEffectFrame:=0;
              m_nEffectEnd:=6;
              m_dwEffectStartTime:=GetTickCount;
              m_dwEffectFrameTime:=150;
              AttackEffectSurface := g_WMonImagesArr[23].GetCachedImage (
                                2430 + (firedir * 10) + m_nEffectFrame - m_nEffectStart,
                                ax, ay);
            end;
            {else begin
              m_boUseEffect := TRUE;
              m_nEffectStart:=0;
              m_nEffectFrame:=0;
              m_nEffectEnd:=4;
              m_dwEffectStartTime:=GetTickCount;
              m_dwEffectFrameTime:=150;
              AttackEffectSurface := g_WMonImagesArr[23].GetCachedImage (
                                1770 + (m_btDir * 10) + m_nEffectFrame,
                                ax, ay);
            end;  }
          end;
      end;    *)
   end;
end;

function  TSculptureMon.GetDefaultFrame (wmode: Boolean): integer;
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
         case m_btRace of
            47: Result := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
            48, 49: Result := pm.ActDeath.start;
         end;
      end else begin
         m_nDefFrameCount := pm.ActStand.frame;
         if m_nCurrentDefFrame < 0 then cf := 0
         else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
         else cf := m_nCurrentDefFrame;
         Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
      end;
   end;
end;

procedure TSculptureMon.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
  try
    if m_boUseEffect and (AttackEffectSurface <> nil) then begin
         DrawBlend (dsurface,
                    dx + ax + m_nShiftX,
                    dy + ay + m_nShiftY,
                    AttackEffectSurface, 200);
    end;
  except
    DebugOutStr('TSculptureMon.DrawEff');
  end;
end;

procedure TSculptureMon.Run;
var
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
   inherited Run;
  except
    DebugOutStr('TSculptureMon.Run');
  end;
end;


{ TBanyaGuardMon }

procedure TBanyaGuardMon.CalcActorFrame;
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
       m_dwWarModeTime := GetTickCount;
       Shift (m_btDir, 0, 0, 1);
       m_boUseEffect := TRUE;

       m_nEffectFrame := m_nStartFrame;
       m_nEffectStart := m_nStartFrame;
       m_nEffectEnd := m_nEndFrame;
       m_dwEffectStartTime := GetTickCount;
       m_dwEffectFrameTime := m_dwFrameTime;
     end;
     SM_LIGHTING: begin
       m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
       m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
       m_dwFrameTime := pm.ActCritical.ftime;
       m_dwStartTime := GetTickCount;
       m_nCurEffFrame:=0;
       m_boUseMagic:=True;
       m_dwWarModeTime := GetTickCount;
       Shift (m_btDir, 0, 0, 1);
       if (m_btRace = 71) then begin
         m_boUseEffect := TRUE;
         m_nEffectFrame := m_nStartFrame;
         m_nEffectStart := m_nStartFrame;
         m_nEffectEnd := m_nEndFrame;
         m_dwEffectStartTime := GetTickCount;
         m_dwEffectFrameTime := m_dwFrameTime;
       end;
     end;
     else begin
       inherited;
     end;
   end;

end;

constructor TBanyaGuardMon.Create;
begin
  inherited;
  n26C:=nil;
end;

destructor TBanyaGuardMon.Destroy;
begin
  inherited;
end;

procedure TBanyaGuardMon.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
begin
  try
    inherited;
    if m_boUseEffect and (n26C <> nil) then begin
      DrawBlend (dsurface,dx + ax + m_nShiftX,dy + ay + m_nShiftY,n26C, 200);
    end;
  except
    DebugOutStr('TBanyaGuardMon.DrawEff');
  end;
end;

procedure TBanyaGuardMon.LoadSurface;
begin
  inherited;
  if bo260 then begin
    case m_btRace of
      70: begin
        AttackEffectSurface := {FrmMain.WMon21Img20080720×¢ÊÍ}g_WMonImagesArr[20].GetCachedImage (
                        2320 + m_nCurrentFrame - m_nStartFrame,
                        n264, n268);

      end;
      71: begin
        AttackEffectSurface := {FrmMain.WMon21Img20080720×¢ÊÍ}g_WMonImagesArr[20].GetCachedImage (
                        2870 + (m_btDir * 10) + m_nCurrentFrame - m_nStartFrame,
                        n264, n268);
      end;
      78: begin
        AttackEffectSurface := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21].GetCachedImage (
                        3120 + (m_btDir * 20) + m_nCurrentFrame - m_nStartFrame,
                        n264, n268);
      end;
    end;
  end else begin
    if m_boUseEffect then begin
      case m_btRace of
        70: begin
          if m_nCurrentAction = SM_HIT then begin
            n26C := {FrmMain.WMon21Img20080720×¢ÊÍ}g_WMonImagesArr[20].GetCachedImage (
                            2230 + (m_btDir * 10) + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
          end;
        end;
        71: begin
          case m_nCurrentAction of
            SM_HIT: begin
              n26C := {FrmMain.WMon21Img20080720×¢ÊÍ}g_WMonImagesArr[20].GetCachedImage (
                            2780 + (m_btDir * 10) + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
            end;
            SM_FLYAXE ..SM_LIGHTING: begin
              n26C := {FrmMain.WMon21Img20080720×¢ÊÍ}g_WMonImagesArr[20].GetCachedImage (
                            2960 + (m_btDir * 10) + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
            end;
          end;
        end;
        72: begin
          if m_nCurrentAction = SM_HIT then begin
            n26C := {FrmMain.WMon21Img20080720×¢ÊÍ}g_WMonImagesArr[20].GetCachedImage (
                            3490 + (m_btDir * 10) + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
          end;
        end;
        78: begin
          if m_nCurrentAction = SM_HIT then begin
            n26C := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21].GetCachedImage (
                            3440 + (m_btDir * 10) + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
          end;
        end;
      end;
    end;
  end;
end;

procedure TBanyaGuardMon.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   bo11:Boolean;
begin
  try
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //ÁÖ¼úÀÇ¸· µî... ¾Ö´Ï¸ÞÀÌ¼Ç È¿°ú
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
   end;
  if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢}then exit;
   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   if m_boUseEffect then begin
      if m_boMsgMuch then m_dwEffectFrameTimetime := Round(m_dwEffectFrameTime * 2 / 3)
      else m_dwEffectFrameTimetime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
         m_dwEffectStartTime := GetTickCount;
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
         end else begin
            m_boUseEffect := FALSE;
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
            m_boUseEffect := FALSE;
            bo260:=False;
         end;
         if m_nCurrentAction = SM_LIGHTING then begin
           if (m_nCurrentFrame - m_nStartFrame) = 4 then begin
             if (m_btRace = 70) or (m_btRace = 81) then begin
               PlayScene.NewMagic (Self,m_nMagicNum,8,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtThunder,False,30,0,bo11);
               PlaySound(10112);
             end;
             if (m_btRace = 71) then begin
               PlayScene.NewMagic (Self,1,1,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtFly,True,30,0,bo11);
               PlaySound(10012);
             end;
             if (m_btRace = 72) then begin
               PlayScene.NewMagic (Self,11,32,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mt13,False,30,0,bo11);
               PlaySound(2276);
             end;
             if (m_btRace = 78) then begin
               PlayScene.NewMagic (Self,11,37,m_nCurrX,m_nCurrY,m_nCurrX,m_nCurrY,m_nRecogId,mt13,False,30,0,bo11);
               PlaySound(2396);
             end;
           end;
         end;
         m_nCurrentDefFrame := 0;
         m_dwDefFrameTime := GetTickCount;
      end;
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
    DebugOutStr('TBanyaGuardMon.Run');
  end;
end;

{ TElectronicScolpionMon }

procedure TElectronicScolpionMon.CalcActorFrame;
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
       m_dwWarModeTime := GetTickCount;
       Shift (m_btDir, 0, 0, 1);
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

destructor TElectronicScolpionMon.Destroy;
begin
  inherited;
end;

procedure TElectronicScolpionMon.LoadSurface;
begin
  inherited;
  if (m_btRace = 60) and m_boUseEffect and (m_nCurrentAction = SM_LIGHTING) then begin
    AttackEffectSurface := {FrmMain.WMon19Img20080720×¢ÊÍ}g_WMonImagesArr[18].GetCachedImage (
                        430 + (firedir * 10) + m_nEffectFrame - m_nEffectStart,
                        ax, ay);
  end;
end;

{ TBossPigMon }

destructor TBossPigMon.Destroy;
begin
  inherited;
end;

procedure TBossPigMon.LoadSurface;
begin
  inherited;
  if (m_btRace = 61) and m_boUseEffect then begin
    AttackEffectSurface := {FrmMain.WMon19Img20080720×¢ÊÍ}g_WMonImagesArr[18].GetCachedImage (
                        860 + (firedir * 10) + m_nEffectFrame - m_nEffectStart,
                        ax, ay);
  end;
end;

{ TKingOfSculpureKingMon }

procedure TKingOfSculpureKingMon.CalcActorFrame;
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
       m_dwWarModeTime := GetTickCount;
       Shift (m_btDir, 0, 0, 1);
       m_boUseEffect := TRUE;
       firedir := m_btDir;
       m_nEffectFrame := m_nStartFrame;
       m_nEffectStart := m_nStartFrame;
       m_nEffectEnd := m_nEndFrame;
       m_dwEffectStartTime := GetTickCount;
       m_dwEffectFrameTime := m_dwFrameTime;
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
       m_nEffectFrame := m_nStartFrame;
       m_nEffectStart := m_nStartFrame;
       m_nEffectEnd := m_nEndFrame;
       m_dwEffectStartTime := GetTickCount;
       m_dwEffectFrameTime := m_dwFrameTime;
     end;
     SM_NOWDEATH: begin
       m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
       m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
       m_dwFrameTime := pm.ActDie.ftime;
       m_dwStartTime := GetTickCount;
       m_nEffectFrame := pm.ActDie.start;
       m_nEffectStart := pm.ActDie.start;
       m_nEffectEnd := pm.ActDie.start + pm.ActDie.frame - 1;
       m_dwEffectStartTime := GetTickCount;
       m_dwEffectFrameTime := m_dwFrameTime;
       m_boUseEffect := TRUE;
     end;
     else begin
      inherited;
     end;     
   end;
end;

destructor TKingOfSculpureKingMon.Destroy;
begin
  inherited;
end;

procedure TKingOfSculpureKingMon.LoadSurface;
begin
  inherited;
  if (m_btRace = 62) and m_boUseEffect then begin
    case m_nCurrentAction of
      SM_HIT: begin
        AttackEffectSurface := {FrmMain.WMon19Img20080720×¢ÊÍ}g_WMonImagesArr[18].GetCachedImage (
                        1490 + (firedir * 10) + m_nEffectFrame - m_nEffectStart,
                        ax, ay);
      end;
      SM_LIGHTING: begin
        AttackEffectSurface := {FrmMain.WMon19Img20080720×¢ÊÍ}g_WMonImagesArr[18].GetCachedImage (
                        1380 + (firedir * 10) + m_nEffectFrame - m_nEffectStart,
                        ax, ay);
      end;
      SM_NOWDEATH: begin
        AttackEffectSurface := {FrmMain.WMon19Img20080720×¢ÊÍ}g_WMonImagesArr[18].GetCachedImage (
                        1470 + m_nEffectFrame - m_nEffectStart,
                        ax, ay);
      end;
    end;

  end;
end;

{ TSkeletonArcherMon }

procedure TSkeletonArcherMon.CalcActorFrame;
begin
  inherited;
  if (m_nCurrentAction = SM_NOWDEATH) and (m_btRace <> 72) then begin
    bo260:=True;
  end;
end;

destructor TSkeletonArcherMon.Destroy;
begin
  inherited;
end;

procedure TSkeletonArcherMon.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
begin
  try
    inherited;
    if bo260 and (AttackEffectSurface <> nil) then begin
      DrawBlend (dsurface,dx + n264 + m_nShiftX,dy + n268 + m_nShiftY,AttackEffectSurface, 200);
    end;
  except
    DebugOutStr('TSkeletonArcherMon.DrawEff');
  end;
end;

procedure TSkeletonArcherMon.LoadSurface;
begin
  inherited;
  if bo260 then begin
        AttackEffectSurface := {FrmMain.WMon20Img20080720×¢ÊÍ}g_WMonImagesArr[19].GetCachedImage (
                        1600 + m_nEffectFrame - m_nEffectStart,
                        n264, n268);
  end;
end;

procedure TSkeletonArcherMon.Run;
var
  m_dwFrameTimetime: longword;
begin
  try
    if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
    else m_dwFrameTimetime := m_dwFrameTime;
    if m_nCurrentAction <> 0 then begin
      if (GetTickCount - m_dwStartTime) > m_dwFrameTimetime then begin
        if m_nCurrentFrame < m_nEndFrame then begin
        end else begin
          m_nCurrentAction:=0;
          bo260:=False;
        end;
      end;
    end;
     inherited;
  except
    DebugOutStr('TSkeletonArcherMon.Run');
  end;
  
end;

{ TFlyingSpider }

procedure TFlyingSpider.CalcActorFrame;
var
  Eff8:TNormalDrawEffect;
begin
  inherited;
  if m_nCurrentAction = SM_NOWDEATH then begin
    Eff8:=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,{FrmMain.WMon12Img20080720×¢ÊÍ}g_WMonImagesArr[11],1420,20,m_dwFrameTime,True);
    if Eff8 <> nil then begin
      Eff8.MagOwner:=g_MySelf;
      PlayScene.m_EffectList.Add(Eff8);
    end;
  end;
end;

destructor TFlyingSpider.Destroy;
begin
  inherited;
end;

{ TExplosionSpider }

procedure TExplosionSpider.CalcActorFrame;
begin
  inherited;
  case m_nCurrentAction of
    SM_HIT: begin
      m_boUseEffect:=False;
    end;
    SM_NOWDEATH: begin
      m_nEffectStart:=m_nStartFrame;
      m_nEffectFrame:=m_nStartFrame;
      m_dwEffectStartTime:=GetTickCount();
      m_dwEffectFrameTime:=m_dwFrameTime;
      m_nEffectEnd:=m_nEndFrame;
      m_boUseEffect:=True;
    end;
  end;
end;

destructor TExplosionSpider.Destroy;
begin
  inherited;
end;

procedure TExplosionSpider.LoadSurface;
begin
  inherited;
  if m_boUseEffect then
    AttackEffectSurface := {WMon14Img20080720×¢ÊÍ}g_WMonImagesArr[13].GetCachedImage (
                        730 + m_nEffectFrame-m_nEffectStart,
                        ax, ay);
end;

{ TSkeletonKingMon }

procedure TSkeletonKingMon.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
   m_nCurrentFrame := -1;

   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;

   case m_nCurrentAction of
     SM_BACKSTEP,SM_WALK: begin
       m_nStartFrame := pm.ActWalk.start + m_btDir * (pm.ActWalk.frame + pm.ActWalk.skip);
       m_nEndFrame := m_nStartFrame + pm.ActWalk.frame - 1;
       m_dwFrameTime := pm.ActWalk.ftime;
       m_dwStartTime := GetTickCount;
       m_nEffectFrame:=pm.ActWalk.start;
       m_nEffectStart:=pm.ActWalk.start;
       m_nEffectEnd:=pm.ActWalk.start + pm.ActWalk.frame -1;
       m_dwEffectStartTime:=GetTickCount();
       m_dwEffectFrameTime:=m_dwFrameTime;
       m_boUseEffect:=True;
       m_nMaxTick := pm.ActWalk.UseTick;
       m_nCurTick := 0;
            //WarMode := FALSE;
       m_nMoveStep := 1;
       if m_nCurrentAction = SM_WALK then
         Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
       else
         Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
     end;
     SM_HIT: begin
       m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
       m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
       m_dwFrameTime := pm.ActAttack.ftime;
       m_dwStartTime := GetTickCount;
       m_dwWarModeTime:= GetTickCount;
       Shift (m_btDir, 0, 0, 1);
       m_boUseEffect := TRUE;
       firedir := m_btDir;
       m_nEffectFrame:=m_nStartFrame;
       m_nEffectStart:=m_nStartFrame;
       m_nEffectEnd:=m_nEndFrame;
       m_dwEffectStartTime:=GetTickCount();
       m_dwEffectFrameTime := m_dwFrameTime;
     end;
     SM_FLYAXE: begin
       m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
       m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
       m_dwFrameTime := pm.ActCritical.ftime;
       m_dwStartTime := GetTickCount;
       m_dwWarModeTime:= GetTickCount;
       Shift (m_btDir, 0, 0, 1);
       m_boUseEffect := TRUE;
       firedir := m_btDir;
       m_nEffectFrame:=m_nStartFrame;
       m_nEffectStart:=m_nStartFrame;
       m_nEffectEnd:=m_nEndFrame;
       m_dwEffectStartTime:=GetTickCount();
       m_dwEffectFrameTime := m_dwFrameTime;
     end;
     SM_LIGHTING: begin
       m_nStartFrame := 80 + pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
       m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
       m_dwFrameTime := pm.ActAttack.ftime;
       m_dwStartTime := GetTickCount;
       m_dwWarModeTime:= GetTickCount;
       Shift (m_btDir, 0, 0, 1);
       m_boUseEffect := TRUE;
       firedir := m_btDir;
       m_nEffectFrame:=m_nStartFrame;
       m_nEffectStart:=m_nStartFrame;
       m_nEffectEnd:=m_nEndFrame;
       m_dwEffectStartTime:=GetTickCount();
       m_dwEffectFrameTime := m_dwFrameTime;
     end;
     SM_STRUCK: begin
       m_nStartFrame := pm.ActStruck.start + m_btDir * (pm.ActStruck.frame + pm.ActStruck.skip);
       m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
       m_dwFrameTime := pm.ActStruck.ftime;
       m_dwStartTime := GetTickCount;
       m_nEffectFrame:=pm.ActStruck.start;
       m_nEffectStart:=pm.ActStruck.start;
       m_nEffectEnd:=pm.ActStruck.start + pm.ActStruck.frame -1;
       m_dwEffectStartTime:=GetTickCount;
       m_dwEffectFrameTime:=m_dwFrameTime;
       m_boUseEffect := TRUE;
     end;
     SM_NOWDEATH: begin
       m_nStartFrame := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip);
       m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
       m_dwFrameTime := pm.ActDie.ftime;
       m_dwStartTime := GetTickCount;
       m_nEffectFrame := pm.ActDie.start;
       m_nEffectStart := pm.ActDie.start;
       m_nEffectEnd := pm.ActDie.start + pm.ActDie.frame - 1;
       m_dwEffectStartTime := GetTickCount;
       m_dwEffectFrameTime := m_dwFrameTime;
       m_boUseEffect := TRUE;
     end;
     else begin
       inherited;
     end;
   end;
end;

destructor TSkeletonKingMon.Destroy;
begin
  inherited;
end;

procedure TSkeletonKingMon.LoadSurface;
begin
  inherited;
   if (m_btRace = 63) and m_boUseEffect then begin
     case m_nCurrentAction of
       SM_WALK: begin
         AttackEffectSurface := g_WMonImagesArr[19].GetCachedImage (
                                3060 + (m_btDir * 10) + m_nEffectFrame-m_nEffectStart,
                                ax,
                                ay);
       end;
       SM_HIT: begin
         AttackEffectSurface := g_WMonImagesArr[19].GetCachedImage (
                                3140 + (firedir * 10) + m_nEffectFrame-m_nEffectStart,
                                ax,
                                ay);
       end;
       SM_FLYAXE: begin
         AttackEffectSurface := g_WMonImagesArr[19].GetCachedImage (
                                3300 + (firedir * 10) + m_nEffectFrame-m_nEffectStart,
                                ax,
                                ay);
       end;
       SM_LIGHTING: begin
         AttackEffectSurface := g_WMonImagesArr[19].GetCachedImage (
                                3220 + (firedir * 10) + m_nEffectFrame-m_nEffectStart,
                                ax,
                                ay);
       end;
       SM_STRUCK: begin
         AttackEffectSurface := g_WMonImagesArr[19].GetCachedImage (
                                3380 + (m_btDir * 2) + m_nEffectFrame-m_nEffectStart,
                                ax,
                                ay);       
       end;
       SM_NOWDEATH: begin
         AttackEffectSurface := g_WMonImagesArr[19].GetCachedImage (
                                3400 + (m_btDir * 4) + m_nEffectFrame-m_nEffectStart,
                                ax,
                                ay);
       end;
     end;
   end;
end;

procedure TSkeletonKingMon.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   meff: TFlyingFireBall;
begin
  try
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN) 20080803×¢ÊÍÆïÂíÏûÏ¢}then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   //
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   if m_boUseEffect then begin
      if m_boMsgMuch then m_dwEffectFrameTimetime := Round(m_dwEffectFrameTime * 2 / 3)
      else m_dwEffectFrameTimetime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
         m_dwEffectStartTime := GetTickCount;
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
         end else begin
            m_boUseEffect := FALSE;
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
            m_boUseEffect:=False;
            BoUseDieEffect := FALSE;
         end;

         if (m_nCurrentAction = SM_FLYAXE) and (m_nCurrentFrame-m_nStartFrame = 4) then begin
            meff := TFlyingFireBall (PlayScene.NewFlyObject (self,
                             m_nCurrX,
                             m_nCurrY,
                             m_nTargetX,
                             m_nTargetY,
                             m_nTargetRecog,
                             mt12));
            if meff <> nil then begin
               meff.ImgLib := {FrmMain.WMon20Img20080720×¢ÊÍ}g_WMonImagesArr[19];
               meff.NextFrameTime := 40;
               meff.FlyImageBase := 3573;
            end;
         end;
        m_nCurrentDefFrame := 0;
        m_dwDefFrameTime := GetTickCount;
      end;
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
    DebugOutStr('TSkeletonKingMon.Run');
  end;
end;

{ TStoneMonster }

procedure TStoneMonster.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
   m_boUseMagic:=False;
   m_nCurrentFrame := -1;
   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   m_btDir:=0;
   case m_nCurrentAction of
     SM_TURN: begin
       m_nStartFrame := pm.ActStand.start;
       m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
       m_dwFrameTime := pm.ActStand.ftime;
       m_dwStartTime := GetTickCount;
       m_nDefFrameCount:=pm.ActStand.frame;
       if not m_boUseEffect then begin
         m_boUseEffect:=True;
         m_nEffectFrame := m_nStartFrame;
         m_nEffectStart := m_nStartFrame;
         m_nEffectEnd := m_nEndFrame;
         m_dwEffectStartTime := GetTickCount;
         m_dwEffectFrameTime := 300;
       end;
     end;
     SM_HIT: begin
       m_nStartFrame := pm.ActAttack.start;
       m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
       m_dwFrameTime := pm.ActAttack.ftime;
       m_dwStartTime := GetTickCount;
       m_dwWarModeTime := GetTickCount;
       if not m_boUseEffect then begin
         m_boUseEffect:=True;
         m_nEffectFrame := m_nStartFrame;
         m_nEffectStart := m_nStartFrame;
         m_nEffectEnd := m_nStartFrame + 25;
         m_dwEffectStartTime := GetTickCount;
         m_dwEffectFrameTime := 150;
       end;
     end;
     SM_STRUCK: begin
       m_nStartFrame := pm.ActStruck.start;
       m_nEndFrame := m_nStartFrame + pm.ActStruck.frame - 1;
       m_dwFrameTime := pm.ActStruck.ftime;
       m_dwStartTime := GetTickCount;
     end;
     SM_DEATH: begin
       m_nStartFrame := pm.ActDie.start;
       m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
       m_dwFrameTime := pm.ActDie.ftime;
       m_dwStartTime := GetTickCount;
     end;
     SM_NOWDEATH: begin
       m_nStartFrame := pm.ActDie.start;
       m_nEndFrame := m_nStartFrame + pm.ActDie.frame - 1;
       m_dwFrameTime := pm.ActDie.ftime;
       m_dwStartTime := GetTickCount;
       bo260:=True;
       m_nEffectFrame := m_nStartFrame;
       m_nEffectStart := m_nStartFrame;
       m_nEffectEnd := m_nStartFrame + 19;
       m_dwEffectStartTime := GetTickCount;
       m_dwEffectFrameTime := 80;
     end;
   end;
end;

constructor TStoneMonster.Create;
begin
  inherited;
  n26C:=nil;
  m_boUseEffect:=False;
  bo260:=False;
end;

destructor TStoneMonster.Destroy;
begin
  inherited;
end;

procedure TStoneMonster.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
begin
  try
    inherited;
    if m_boUseEffect and (n26C <> nil) then begin
      DrawBlend (dsurface,
                 dx + ax + m_nShiftX,
                 dy + ay + m_nShiftY,
                 n26C, 200);
    end;
  except
    DebugOutStr('TStoneMonster.DrawEff');
  end;
end;

procedure TStoneMonster.LoadSurface;
begin
  inherited;
  if bo260 then begin
    case m_btRace of
      75: begin
        AttackEffectSurface := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21].GetCachedImage (
                        2530 + m_nEffectFrame - m_nEffectStart,
                        n264, n268);
      end;
      77: begin
        AttackEffectSurface := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21].GetCachedImage (
                        2660 + m_nEffectFrame - m_nEffectStart,
                        n264, n268);      
      end;
    end;
  end else begin
    if m_boUseEffect then
      case m_btRace of
        75: begin
          case m_nCurrentAction of
            SM_HIT: begin
              n26C := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21].GetCachedImage (
                            2500 + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
            end;
            SM_TURN: begin
              n26C := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21].GetCachedImage (
                            2490 + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
            end;
          end;
        end;
        77: begin
          case m_nCurrentAction of
            SM_HIT: begin
              n26C := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21].GetCachedImage (
                            2630 + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
            end;
            SM_TURN: begin
              n26C := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21].GetCachedImage (
                            2620 + m_nEffectFrame - m_nEffectStart,
                            ax, ay);
            end;
          end;
        end;
      end;
  end;
end;

procedure TStoneMonster.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime: longword;
   m_dwFrameTimetime: longword;
begin
  try
  if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢} then exit;
   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   RunActSound (m_nCurrentFrame - m_nStartFrame);
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   if m_boUseEffect or bo260 then begin
      if m_boMsgMuch then m_dwEffectFrameTimetime := Round(m_dwEffectFrameTime * 2 / 3)
      else m_dwEffectFrameTimetime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
         m_dwEffectStartTime := GetTickCount;
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
         end else begin
            m_boUseEffect := FALSE;
            bo260:=False;
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
         end;
         m_nCurrentDefFrame := 0;
         m_dwDefFrameTime := GetTickCount;
      end;
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

   if (prv <> m_nCurrentFrame) or (prv <> m_nEffectFrame) then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
   end;
  except
    DebugOutStr('TStoneMonster.Run');
  end;
end;

{ TAngel }

destructor TAngel.Destroy;
begin
  inherited;
end;

procedure TAngel.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer;
  blend, boFlag: Boolean);
var
  ceff: TColorEffect;
  idx, Wax, Way: Integer;
  d: TDirectDrawSurface;
begin
  try
  //if not (m_btDir in [0..7]) then exit;
  if m_btDir > 7 then Exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //bodysurfaceµîÀÌ loadsurface¸¦ ´Ù½Ã ºÎ¸£Áö ¾Ê¾Æ ¸Þ¸ð¸®°¡ ÇÁ¸®µÇ´Â °ÍÀ» ¸·À½
   end;


  if n278 <> nil then begin
    //DrawBlendEx (dsurface, dx + n270 + m_nShiftX, dy + n274 + m_nShiftY, n278,
    //             0, 0, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, 1);

//    g_ImgMixSurface.Fill(0);
//    g_ImgMixSurface.Draw (0, 0, m_BodySurface.ClientRect, m_BodySurface, FALSE);
//    DrawEffect (0, 0, m_BodySurface.Width, m_BodySurface.Height, g_ImgMixSurface, ceBright);
//    DrawBlend (dsurface, dx + n270 + m_nShiftX, dy + n274 + m_nShiftY, g_ImgMixSurface, 1);

    DrawBlend (dsurface, dx + n270 + m_nShiftX, dy + n274 + m_nShiftY, n278, 200);
  end;
  //inherited;

  ceff := GetDrawEffectValue;
  //ceff := ceBright;

  if m_BodySurface <> nil then begin
    DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
  end;
    if not m_boDeath then begin  //ËÀÍö²»ÏÔÊ¾
      if m_nState and $02000000 <> 0 then begin //Íò½£¹é×Ú»÷ÖÐ×´Ì¬
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, Wax, Way);
          if d <> nil then
            DrawBlend (dsurface, dx + Wax + m_nShiftX, dy + Way + m_nShiftY, d, 150);
      end;
      if m_nState and $00004000 <> 0 then begin //¶¨Éí×´Ì¬
          idx := 1080 + (m_nGenAniCount mod 8);
          d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
      end;
    end;
  except
    DebugOutStr('TAngel.DrawChr');
  end;
end;

procedure TAngel.LoadSurface;
var
   mimg: TWMImages;
begin
   mimg := GetMonImg (m_wAppearance);
   if mimg <> nil then begin
     if (not m_boReverseFrame) then begin
       m_BodySurface := mimg.GetCachedImage (1280 + m_nCurrentFrame, m_nPx, m_nPy);
       n278 := mimg.GetCachedImage (920 + m_nCurrentFrame, n270, n274);
     end else begin
       m_BodySurface := mimg.GetCachedImage (
                            1280 + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame),
                            m_nPx, m_nPy);
       n278 := mimg.GetCachedImage (
                            920 + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame),
                            n270, n274);
     end;
   end;
end;

{ TPBOMA6Mon }

destructor TPBOMA6Mon.Destroy;
begin
  inherited;
end;

procedure TPBOMA6Mon.Run;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   meff: TFlyingAxe;
begin
  try
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢} then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

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
            m_nCurrentAction := 0;
            m_boUseEffect := FALSE;
         end;
         if (m_nCurrentAction = SM_FLYAXE) and (m_nCurrentFrame - m_nStartFrame = 4) then begin
            meff := TFlyingAxe (PlayScene.NewFlyObject (self,
                             m_nCurrX,
                             m_nCurrY,
                             g_nTargetX,
                             g_nTargetY,
                             m_nTargetRecog,
                             mt16));
            if meff <> nil then begin
               meff.ImgLib := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21];
               meff.NextFrameTime := 50;
               meff.FlyImageBase:=1989;
            end;
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
    DebugOutStr('TPBOMA6Mon.Run');
  end;
end;

{ TDragonStatue }

procedure TDragonStatue.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
   m_btDir:=0;
   m_nCurrentFrame := -1;
   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   case m_nCurrentAction of
     SM_DIGUP: begin
       Shift (0, 0, 0, 1);
       m_nStartFrame:=0;
       m_nEndFrame:=9;
       m_dwFrameTime:=100;
       m_dwStartTime:=GetTickCount;
     end;
     SM_LIGHTING: begin
       m_nStartFrame:=0;
       m_nEndFrame:=9;
       m_dwFrameTime:=100;
       m_dwStartTime:=GetTickCount;
       m_boUseEffect:=True;
       m_nEffectStart:=0;
       m_nEffectFrame:=0;
       m_nEffectEnd:=9;
       m_dwEffectStartTime:=GetTickCount;
       m_dwEffectFrameTime:=100;
     end;
   end;
end;

constructor TDragonStatue.Create;
begin
  inherited;
  n26C:=nil;
end;

destructor TDragonStatue.Destroy;
begin
  inherited;
end;

procedure TDragonStatue.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
begin
  try
  inherited;
  if m_boUseEffect and (EffectSurface <> nil) then begin
    DrawBlend (dsurface,dx + ax + m_nShiftX,dy + ay + m_nShiftY,EffectSurface, 200);
  end;
  except
    DebugOutStr('TDragonStatue.DrawEff');
  end;
end;

procedure TDragonStatue.LoadSurface;
var
  mimg:TWMImages;
begin
   mimg :={FrmMain.WDragonImg}g_WDragonImages;
   if mimg <> nil then
     m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nCurrentFrame, m_nPx, m_nPy);
   if m_boUseEffect then begin
     case m_btRace of
       84..86: begin
         EffectSurface:= mimg.GetCachedImage (310 + m_nEffectFrame, ax, ay);
       end;
       87..89: begin
         EffectSurface:= mimg.GetCachedImage (330 + m_nEffectFrame, ax, ay);
       end;
     end;
   end;
end;

procedure TDragonStatue.Run;
var
   prv: integer;
   dwEffectFrameTime, m_dwFrameTimetime: longword;
   bo11:Boolean;
begin
  try
    m_btDir:=0;
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) {or 20080803×¢ÊÍÆïÂíÏûÏ¢
      (m_nCurrentAction = SM_HORSERUN) }then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

   if m_boUseEffect then begin
      if m_boMsgMuch then dwEffectFrameTime := Round(m_dwEffectFrameTime * 2 / 3)
      else dwEffectFrameTime := m_dwEffectFrameTime;
      if GetTickCount - m_dwEffectStartTime > dwEffectFrameTime then begin
         m_dwEffectStartTime := GetTickCount;
         if m_nEffectFrame < m_nEffectEnd then begin
            Inc (m_nEffectFrame);
         end else begin
            m_boUseEffect := FALSE;
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
            m_boUseEffect := FALSE;
            bo260:=False;
         end;
         if (m_nCurrentAction = SM_LIGHTING) and (m_nCurrentFrame = 4) then begin
           PlayScene.NewMagic (Self,74,74,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,0,mtThunder,False,30,0,bo11);
           PlaySound(8222);
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
    DebugOutStr('TDragonStatue.Run');
  end;
end;

{ TPBOMA1Mon }

destructor TPBOMA1Mon.Destroy;
begin
  inherited;
end;

procedure TPBOMA1Mon.Run;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   meff: TFlyingBug;
begin
  try
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN) 20080803×¢ÊÍÆïÂíÏûÏ¢}then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;

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
            m_nCurrentAction := 0;
            m_boUseEffect := FALSE;
         end;
         if (m_nCurrentAction = SM_FLYAXE) and (m_nCurrentFrame - m_nStartFrame = 4) then begin
            meff := TFlyingBug (PlayScene.NewFlyObject (self,
                             m_nCurrX,
                             m_nCurrY,
                             m_nTargetX,
                             m_nTargetY,
                             m_nTargetRecog,
                             mt15));
            if meff <> nil then begin
               meff.ImgLib := {FrmMain.WMon22Img20080720×¢ÊÍ}g_WMonImagesArr[21];
               meff.NextFrameTime := 50;
               meff.FlyImageBase:=350;
               meff.MagExplosionBase := 430;
            end;
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
    DebugOutStr('TPBOMA1Mon.Run');
  end;
end;
{******************************************************************************}
procedure TFireDragon.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  try
   m_boUseMagic := False;
       case m_btDir of
        3,4:firedir:=0;
        5:firedir:=1;
        6,7:firedir:=2;
       end;
   m_btDir:=0;
   m_nCurrentFrame := -1;
   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then Exit;
   case m_nCurrentAction of
     SM_DIGUP: begin
       Shift (0, 0, 0, 1);
       m_nStartFrame:=0;
       m_nEndFrame:=9;
       m_dwFrameTime:=300;
       m_dwStartTime:=GetTickCount;
     end;
     SM_HIT: begin
       m_btDir:=0;

       m_nStartFrame:=0;
       m_nEndFrame:=19;
       m_dwFrameTime:=150;
       m_dwStartTime:=GetTickCount;
       m_boUseEffect:=True;
       m_nEffectStart:=0;
       m_nEffectFrame:=0;
       m_nEffectEnd:=19;
       m_dwEffectStartTime:=GetTickCount;
       m_dwEffectFrameTime:=150;
       m_nCurEffFrame:=0;
       m_boUseMagic:=True;
       m_dwWarModeTime:=GetTickcount;
       Shift (m_btDir, 0, 0, 1);   
     end;
     SM_LIGHTING: begin //´ó»ðÈ¦¹¥»÷
       m_nStartFrame:=0;
       m_nEndFrame:=5;
       m_dwFrameTime:=150;
       m_dwStartTime:=GetTickCount;
       m_boUseEffect:=True;
       m_nEffectStart:=0;
       m_nEffectFrame:=0;
       m_nEffectEnd:=4;
       m_dwEffectStartTime:=GetTickCount;
       m_dwEffectFrameTime:=150;
       m_nCurEffFrame:=0;
       m_boUseMagic:=True;
       m_dwWarModeTime:=GetTickcount;
       Shift (m_btDir, 0, 0, 1);
     end;
     SM_STRUCK: begin
       m_nStartFrame:=0;
       m_nEndFrame:=9;
       m_dwFrameTime:=300;
       m_dwStartTime:=GetTickCount;
     end;
   end;
   except
      DebugOutStr ('TFireDragon.CalcActorFrame');
   end;
end;

constructor TFireDragon.Create;
begin
  inherited;
  n270:=nil;
  firedir := 0;
end;

procedure TFireDragon.AttackEff;
var
  n8,nC,n10,n14,n18:integer;
  bo11:Boolean;
  i,iCount:integer;
begin
  try
    if m_boDeath then exit;
    n8:=m_nCurrX;
    nC:=m_nCurrY;
    iCount:=Random(1);
    for i:=0 to iCount do begin
      n10:=Random(4);
      n14:=Random(8);
      n18:=Random(8);
      case n10 of
        0: begin
          PlayScene.NewMagic (Self,80,80,m_nCurrX,m_nCurrY,n8 - n14 - 2,nC + n18 + 1,0,mtRedThunder,False,30,0,bo11);
        end;
        1: begin
          PlayScene.NewMagic (Self,80,80,m_nCurrX,m_nCurrY,n8 - n14,nC + n18,0,mtRedThunder,False,30,0,bo11);
        end;
        2: begin
          PlayScene.NewMagic (Self,80,80,m_nCurrX,m_nCurrY,n8 - n14,nC + n18 + 1,0,mtRedThunder,False,30,0,bo11);
        end;
        3: begin
          PlayScene.NewMagic (Self,80,80,m_nCurrX,m_nCurrY,n8 - n14 - 2,nC + n18,0,mtRedThunder,False,30,0,bo11);
        end;
      end;
      PlaySound(8206);
    end;
  except
    DebugOutStr ('TFireDragon.AttackEff');
  end;
end;

procedure TFireDragon.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
begin
  try
  inherited;
  if m_boUseEffect and (n270 <> nil) then begin
    DrawBlend (dsurface,dx + ax + m_nShiftX,dy + ay + m_nShiftY,n270, 200);
  end;
  except
    DebugOutStr ('TFireDragon.DrawEff');
  end;
end;

procedure TFireDragon.LoadSurface;
var
  mimg:TWMImages;
begin
  try
   mimg := {FrmMain.WDragonImg}g_WDragonImages;
   if mimg = nil then exit;
     //if (not m_boReverseFrame) then begin
       case m_nCurrentAction of
         SM_HIT: begin
           m_BodySurface := mimg.GetCachedImage (40 + m_nCurrentFrame, m_nPx, m_nPy);
         end;
         SM_LIGHTING: begin
           m_BodySurface := mimg.GetCachedImage (10 + firedir * 10 + m_nCurrentFrame, m_nPx, m_nPy);
         end;
         {81: begin
           m_BodySurface := mimg.GetCachedImage (10 + m_nCurrentFrame, m_nPx, m_nPy);
         end;
         82: begin
           m_BodySurface := mimg.GetCachedImage (20 + m_nCurrentFrame, m_nPx, m_nPy);
         end;
         83: begin
           m_BodySurface := mimg.GetCachedImage (30 + m_nCurrentFrame, m_nPx, m_nPy);
         end;}
         else begin
           m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nCurrentFrame, m_nPx, m_nPy);
         end;
       end;
     (*end else begin
       case m_nCurrentAction of
         SM_HIT: begin
           m_BodySurface := mimg.GetCachedImage (40 + m_nEndFrame - m_nCurrentFrame, ax, ay);
         end;
         SM_LIGHTING: begin
           m_BodySurface := mimg.GetCachedImage (10 + m_btDir * 10 + m_nCurrentFrame, m_nPx, m_nPy);
         end;
         {81: begin
           m_BodySurface := mimg.GetCachedImage (10 + m_nEndFrame - m_nCurrentFrame, ax, ay);
         end;
         82: begin
           m_BodySurface := mimg.GetCachedImage (20 + m_nEndFrame - m_nCurrentFrame, ax, ay);
         end;
         83: begin
           m_BodySurface := mimg.GetCachedImage (30 + m_nEndFrame - m_nCurrentFrame, ax, ay);
         end; }
         else begin
           m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nEndFrame - m_nCurrentFrame, m_nPx, m_nPy);
         end;
       end;
     end;  *)

   if m_boUseEffect then begin
     case m_nCurrentAction of
       SM_HIT: begin
         n270 := {FrmMain.WDragonImg}g_WDragonImages.GetCachedImage (60 + m_nEffectFrame, ax, ay);
       end;
       SM_LIGHTING: begin
         n270 := {FrmMain.WDragonImg}g_WDragonImages.GetCachedImage (90+ firedir * 10 + m_nEffectFrame, ax, ay);
       end;
       (*81: begin
         n270 := {FrmMain.WDragonImg}g_WDragonImages.GetCachedImage (90 + m_nEffectFrame, ax, ay);
       end;
       82: begin
         n270 := {FrmMain.WDragonImg}g_WDragonImages.GetCachedImage (100 + m_nEffectFrame, ax, ay);
       end;
       83: begin
         n270 := {FrmMain.WDragonImg}g_WDragonImages.GetCachedImage (110 + m_nEffectFrame, ax, ay);
       end; *)

     end;
   end;
   except
    DebugOutStr ('TFireDragon.LoadSurface');
   end;
end;


procedure TFireDragon.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   bo11:Boolean;
begin
  try
     if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢} then exit;

     m_boMsgMuch := FALSE;
     if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
     if m_boRunSound then begin
       PlaySound(8201);
       m_boRunSound:=False;
     end;

     if m_boUseEffect then begin
        if m_boMsgMuch then m_dwEffectFrameTimetime := Round(m_dwEffectFrameTime * 2 / 3)
        else m_dwEffectFrameTimetime := m_dwEffectFrameTime;
        if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
           m_dwEffectStartTime := GetTickCount;
           if m_nEffectFrame < m_nEffectEnd then begin
              Inc (m_nEffectFrame);
           end else begin
              m_boUseEffect := FALSE;
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
              m_boUseEffect := FALSE;
              bo260:=False;
           end;

           if (m_nCurrentAction = SM_LIGHTING) and (m_nCurrentFrame - m_nStartFrame = 1) then begin
             PlayScene.NewMagic (Self,102,102,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtFly,True,30,0,bo11);
           end;

           if (m_nCurrentAction = SM_HIT){ and (m_nCurrentFrame = 4) } then begin//and (m_nCurrentFrame = 4) then begin
             AttackEff;
             PlaySound(8202);
           end;

           {if (m_nCurrentAction = 81) or (m_nCurrentAction = 82) or (m_nCurrentAction = 83) then begin
             if (m_nCurrentFrame - m_nStartFrame) = 4 then begin
               PlayScene.NewMagic (Self,m_nCurrentAction,m_nCurrentAction,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtFly,True,30,bo11);
               PlaySound(8203);
             end;
           end;  }

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
    DebugOutStr ('TFireDragon.Run');
  end;
end;
{******************************************************************************}
{ TFairyMonster }


{ TScorpionMon }

destructor TScorpionMon.Destroy;
begin
  inherited;
end;

{ TZombiZilkin }

destructor TZombiZilkin.Destroy;
begin
  inherited;
end;

{ TWhiteSkeleton }

destructor TWhiteSkeleton.Destroy;
begin
  inherited;
end;

destructor TGasKuDeGi.Destroy;
begin
  inherited;
end;

{ TZombiLighting }

destructor TZombiLighting.Destroy;
begin
  inherited;
end;

{ TSuperiorGuard }

destructor TSuperiorGuard.Destroy;
begin
  inherited;
end;

destructor TSculptureMon.Destroy;
begin
  inherited;
end;

{ TSculptureKingMon }

destructor TSculptureKingMon.Destroy;
begin
  inherited;
end;

{ TSmallElfMonster }

destructor TSmallElfMonster.Destroy;
begin
  inherited;
end;

{ TSamuraiMon }

destructor TSamuraiMon.Destroy;
begin
  inherited;
end;

{ TSkeletonSoldierMon }

destructor TSkeletonSoldierMon.Destroy;
begin
  inherited;
end;

destructor TFireDragon.Destroy;
begin
  inherited;
end;

//Ê¥µîÎÀÊ¿
constructor TRedThunderZuma.Create;
begin
  inherited;
  boCasted:=FALSE;
end;

procedure TRedThunderZuma.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then Exit;

  case m_nCurrentAction of
    SM_TURN: begin
      if (m_nState and STATE_STONE_MODE) <> 0 then begin
        m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
        m_nEndFrame := m_nStartFrame;
        m_dwFrameTime := pm.ActDeath.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := pm.ActDeath.frame;
      end else
        inherited;
    end;
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
      m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
      m_dwFrameTime := pm.ActCritical.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      firedir := m_btDir;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
      m_nEffectStart:=0;
      m_nEffectFrame:=0;
      m_nEffectEnd:=6;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=150;
      m_nCurEffFrame:=0;
      boCasted:=TRUE;
    end;
    SM_DIGUP: begin
      m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
      m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
      m_dwFrameTime := pm.ActDeath.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
    end;
    SM_HIT:
     begin
        m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
        m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
        m_dwFrameTime := pm.ActAttack.ftime;
        m_dwStartTime := GetTickCount;
        m_boUseEffect := TRUE;
        firedir := m_btDir;
        m_nEffectFrame := 0; //startframe;
        m_nEffectStart := 0; //startframe;
        m_nEffectEnd := m_nEffectStart + 6;
        m_dwEffectStartTime := GetTickCount;
        m_dwEffectFrameTime := m_dwFrameTime;
     end;
    else begin
      inherited;
    end;
  end;
end;


function  TRedThunderZuma.GetDefaultFrame (wmode: Boolean): integer;
var
   pm: PTMonsterAction;
begin
  Result:=0;
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  {
  if boActive = FALSE then begin

    if pm = nil then exit;
    if m_boDeath then begin
      inherited GetDefaultFrame(wmode);
      exit;
    end;
    m_nDefFrameCount := 1;
    if m_nCurrentDefFrame < 0 then cf := 0
    else if m_nCurrentDefFrame >= 0 then cf := 0
    else cf := m_nCurrentDefFrame;
    Result := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip) + cf;
    }


  if (m_nState and STATE_STONE_MODE) <> 0 then begin
    Result := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
  end else begin
    Result:= inherited GetDefaultFrame(wmode);
      m_boUseEffect := TRUE;
      m_nEffectStart:=0;
      m_nEffectFrame:=0;
      m_nEffectEnd:=4;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=150;
      AttackEffectSurface := g_WMonImagesArr[23].GetCachedImage (
                        2270 + (m_btDir * 10) + m_nEffectFrame,
                        ax, ay);
  end;
end;

procedure TRedThunderZuma.LoadSurface;
begin
  inherited;
  if (m_nState and STATE_STONE_MODE) <> 0  then Exit;
  case m_nCurrentAction of
    SM_WALK: begin
      m_nEffectStart:=0;
      m_nEffectFrame:=0;
      m_nEffectEnd:=6;
      AttackEffectSurface := g_WMonImagesArr[23].GetCachedImage (
                        2350 + (m_btDir * 10) + m_nEffectFrame - m_nEffectStart,
                        ax, ay);
    end;
    SM_Hit: begin
      AttackEffectSurface := g_WMonImagesArr[23].GetCachedImage (
                        2430 + (firedir * 10) + m_nEffectFrame - m_nEffectStart,
                        ax, ay);
    end;
    {else begin
      m_boUseEffect := TRUE;
      m_nEffectStart:=0;
      m_nEffectFrame:=0;
      m_nEffectEnd:=4;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=150;
      AttackEffectSurface := g_WMonImagesArr[23].GetCachedImage (
                        2270 + (m_btDir * 10) + m_nEffectFrame,
                        ax, ay);
    end; }
  end;
end;

{ TheCrutchesSpider }
//½ðÕÈÖ©Öë
procedure TheCrutchesSpider.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
  SM_FAIRYATTACKRATE,
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
      m_nEffectStart:=0;
      m_nEffectFrame:=0;
      m_nEffectEnd:=2;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=pm.ActAttack.ftime;
      m_nCurEffFrame:=0;
    end;
    else begin
      inherited;
    end;
  end;
end;

destructor TheCrutchesSpider.Destroy;
begin

  inherited;
end;

procedure TheCrutchesSpider.LoadSurface;
var
  Meff:TMagicEff;
begin
  inherited;
  case m_nCurrentAction of
    SM_LIGHTING: begin
      AttackEffectSurface := nil;
      if (m_nEffectFrame = 1) then begin
        meff := TObjectEffects.Create(self,g_WMagicImages,3840,10,60,TRUE);
        meff.ImgLib := g_WMagicImages;
        PlayScene.m_EffectList.Add (meff);
        PlaySound(10330);
      end;
    end;
      SM_FAIRYATTACKRATE: begin
        AttackEffectSurface := nil;
        if (m_nEffectFrame = 1) then begin
          meff := TObjectEffects.Create(self,g_WMagicImages,1790,10,60,TRUE);
          meff.ImgLib := g_WMagicImages;
          PlayScene.m_EffectList.Add (meff);
          PlaySound(10290);
        end;
      end;
  end;
end;

procedure TheCrutchesSpider.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   bo11: boolean;
begin
  try
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢ }then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
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
         //½ðÕÈÖ©Öë ÊÍ·Å±ùÅØÏøÄ§·¨
         if (m_btRace = 92) and (m_nCurrentAction = SM_LIGHTING) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
           PlayScene.NewMagic(Self,111,31,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
           PlaySound(10332);
         end;
         //½ðÕÈÖ©Öë ÊÍ·ÅÖÎÁÆÊõÄ§·¨
         if (m_btRace = 92) and (m_nCurrentAction = SM_FAIRYATTACKRATE) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
           PlayScene.NewMagic(Self,111,27,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
           PlaySound(10292);
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



{ TYanLeiWangSpider }

procedure TYanLeiWangSpider.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActCritical.start + m_btDir * (pm.ActCritical.frame + pm.ActCritical.skip);
      m_nEndFrame := m_nStartFrame + pm.ActCritical.frame - 1;
      m_dwFrameTime := pm.ActCritical.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
      m_nEffectStart:=0;
      m_nEffectFrame:=0;
      m_nEffectEnd:=10;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=pm.ActCritical.ftime;
      m_nCurEffFrame:=0;
    end;
    else begin
      inherited;
    end;
  end;
end;


procedure TYanLeiWangSpider.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   bo11: boolean;
begin
  try
    if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢ }then exit;

    m_boMsgMuch := FALSE;
    if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
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
         //½ðÕÈÖ©Öë ÊÍ·Å±ùÅØÏøÄ§·¨
         if (m_nCurrentAction = SM_LIGHTING) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
            PlayScene.NewMagic(Self,111,102,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
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
    DeBugOutStr('TYanLeiWangSpider.Run');
  end;
end;

{ TSnowy }

procedure TSnowy.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  m_nCurrentFrame := -1;
  m_nBodyOffset := GetOffset (m_wAppearance);
  pm := GetRaceByPM (m_btRace,m_wAppearance);
  if pm = nil then exit;

  case m_nCurrentAction of
  SM_FAIRYATTACKRATE,
    SM_LIGHTING: begin
      m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
      m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
      m_dwFrameTime := pm.ActAttack.ftime;
      m_dwStartTime := GetTickCount;
      m_dwWarModeTime := GetTickCount;
      Shift (m_btDir, 0, 0, 1);
      m_boUseEffect := TRUE;
      m_nEffectStart:=0;
      m_nEffectFrame:=0;
      m_nEffectEnd:=2;
      m_dwEffectStartTime:=GetTickCount;
      m_dwEffectFrameTime:=pm.ActAttack.ftime;
      m_nCurEffFrame:=0;
    end;
    else begin
      inherited;
    end;
  end;
end;

destructor TSnowy.Destroy;
begin

  inherited;
end;

procedure TSnowy.LoadSurface;
var
  Meff:TMagicEff;
begin
  inherited;
  case m_wAppearance of
    252: begin
      case m_nCurrentAction of
        SM_LIGHTING: begin   //±ù
          AttackEffectSurface := nil;
          if (m_nEffectFrame = 1) then begin
            meff := TObjectEffects.Create(self,g_WMagicImages,3840,10,60,TRUE);
            meff.ImgLib := g_WMagicImages;
            PlayScene.m_EffectList.Add (meff);
            PlaySound(10330);
          end;
        end;
        SM_FAIRYATTACKRATE: begin  //ÊÍ·Å¶¾Êõ
          AttackEffectSurface := nil;
          if (m_nEffectFrame = 1) then begin
            meff := TObjectEffects.Create(self,g_WMagicImages,600,10,60,TRUE);
            meff.ImgLib := g_WMagicImages;
            PlayScene.m_EffectList.Add (meff);
            PlaySound(10060);
          end;
        end;
      end;
    end;
    253: begin
      case m_nCurrentAction of
        SM_LIGHTING: begin   //ÃðÌì»ð
          AttackEffectSurface := nil;
          if (m_nEffectFrame = 1) then begin
            meff := TObjectEffects.Create(self,g_WMagic2Images,130,10,60,TRUE);
            meff.ImgLib := g_WMagic2Images;
            PlayScene.m_EffectList.Add (meff);
            PlaySound(10450);
          end;
        end;
        SM_FAIRYATTACKRATE: begin  //ÊÍ·Å¶¾Êõ
          AttackEffectSurface := nil;
          if (m_nEffectFrame = 1) then begin
            meff := TObjectEffects.Create(self,g_WMagicImages,600,10,60,TRUE);
            meff.ImgLib := g_WMagicImages;
            PlayScene.m_EffectList.Add (meff);
            PlaySound(10060);
          end;
        end;
      end;
    end;
    254: begin
      case m_nCurrentAction of
        SM_LIGHTING: begin   //º®±ùÕÆ
          AttackEffectSurface := nil;
          if (m_nEffectFrame = 1) then begin
            meff := TObjectEffects.Create(self,g_WMagic2Images,400,10,60,TRUE);
            meff.ImgLib := g_WMagic2Images;
            PlayScene.m_EffectList.Add (meff);
            PlaySound(10390);
          end;
        end;
        SM_FAIRYATTACKRATE: begin  //ÖÎÓúÊõ
          AttackEffectSurface := nil;
          if (m_nEffectFrame = 1) then begin
            meff := TObjectEffects.Create(self,g_WMagicImages,200,10,60,TRUE);
            meff.ImgLib := g_WMagicImages;
            PlayScene.m_EffectList.Add (meff);
            PlaySound(10020);
          end;
        end;
      end;
    end;
  end;
end;

procedure TSnowy.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   bo11: boolean;
begin
  try
   if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN) {or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢ }then exit;

   m_boMsgMuch := FALSE;
   if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
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
         case m_wAppearance of
           252: begin
             //ÊÍ·Å±ùÅØÏøÄ§·¨
             if (m_btRace = 94) and (m_nCurrentAction = SM_LIGHTING) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
               PlayScene.NewMagic(Self,111,31,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
               PlaySound(10332);
             end;
             //ÊÍ·ÅÊ©¶¾ÊõÄ§·¨
             if (m_btRace = 94) and (m_nCurrentAction = SM_FAIRYATTACKRATE) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
               PlayScene.NewMagic(Self,111,4,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
               PlaySound(10062);
             end;
           end;
           253: begin
             //ÊÍ·ÅÃðÌì»ðÄ§·¨
             if (m_btRace = 94) and (m_nCurrentAction = SM_LIGHTING) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
               PlayScene.NewMagic(Self,111,34,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
             end;
             //ÊÍ·ÅÊ©¶¾ÊõÄ§·¨
             if (m_btRace = 94) and (m_nCurrentAction = SM_FAIRYATTACKRATE) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
               PlayScene.NewMagic(Self,111,4,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
               PlaySound(10062);
             end;
           end;
           254: begin
             //ÊÍ·Åº®±ùÕÆÄ§·¨
             if (m_btRace = 94) and (m_nCurrentAction = SM_LIGHTING) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
               PlayScene.NewMagic(Self,111,39,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtFly,True,0,0,bo11);
               PlaySound(10391);
             end;
             //ÊÍ·ÅÖÎÓúÊõÄ§·¨
             if (m_btRace = 94) and (m_nCurrentAction = SM_FAIRYATTACKRATE) and (m_nCurrentFrame - m_nStartFrame = 1)  then begin
               PlayScene.NewMagic(Self,111,2,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtExplosion,True,0,0,bo11);
               PlaySound(10022);
             end;
           end;
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
    DebugOutStr('TSnowy.Run');
  end;
end;

{ TSwordsmanMon }

destructor TSwordsmanMon.Destroy;
begin
  inherited;
end;

{ TWealthAnimalMon }

procedure TWealthAnimalMon.CalcActorFrame;
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
      SM_TURN:
         begin
            m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
            m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
            m_dwFrameTime := pm.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := pm.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_WALK, SM_BACKSTEP:
         begin
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
      SM_DIGUP: //°È±â ¾øÀ½, SM_DIGUP, ¹æÇâ ¾øÀ½.
         begin
            m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
            m_dwFrameTime := pm.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := FALSE;
            Shift (m_btDir, 0, 0, 1);
            PlaySound (2845);
         end;
      SM_HIT,
      SM_FLYAXE,
      SM_LIGHTING:
         begin
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
            m_dwFrameTime := pm.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            if (m_btRace = 16) or (m_btRace = 54) then
               m_boUseEffect := TRUE;
            Shift (m_btDir, 0, 0, 1);


            m_nEffectFrame := m_nStartFrame;
            m_nEffectStart := m_nStartFrame;

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
            m_boUseEffect := TRUE;
         end;
      SM_SKELETON:
         begin
            m_nStartFrame := pm.ActDeath.start;
            m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
            m_dwFrameTime := pm.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_ALIVE:
         begin
            m_nStartFrame := pm.ActDeath.start + m_btDir * (pm.ActDeath.frame + pm.ActDeath.skip);
            m_nEndFrame := m_nStartFrame + pm.ActDeath.frame - 1;
            m_dwFrameTime := pm.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
         end;
   end;
end;

constructor TWealthAnimalMon.Create;
begin
  inherited Create;
  DieEffectSurface := nil;
end;

destructor TWealthAnimalMon.Destroy;
begin
  inherited;
end;

procedure TWealthAnimalMon.DrawChr(dsurface: TDirectDrawSurface; dx,
  dy: integer; blend, boFlag: Boolean);
var
  ceff: TColorEffect;
  idx, Wax, Way: Integer;
  d: TDirectDrawSurface;
begin
  try
   //if not (m_btDir in [0..7]) then exit;
   if m_btDir > 7 then Exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //bodysurfaceµîÀÌ loadsurface¸¦ ´Ù½Ã ºÎ¸£Áö ¾Ê¾Æ ¸Þ¸ð¸®°¡ ÇÁ¸®µÇ´Â °ÍÀ» ¸·À½
   end;

   ceff := GetDrawEffectValue;
   DrawMyShow(dsurface,dx,dy); //ÏÔÊ¾×ÔÉí¶¯»­
   if m_BodySurface <> nil then
      DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
    if not m_boDeath then begin  //ËÀÍö²»ÏÔÊ¾
      if m_nState and $02000000 <> 0 then begin //Íò½£¹é×Ú»÷ÖÐ×´Ì¬
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, Wax, Way);
          if d <> nil then
            DrawBlend (dsurface, dx + Wax + m_nShiftX, dy + Way + m_nShiftY, d, 200);
      end;
      if m_nState and $00004000 <> 0 then begin //¶¨Éí×´Ì¬
          idx := 1080 + (m_nGenAniCount mod 8);
          d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
      end;
    end;
  except
    DebugOutStr('TWealthAnimalMon.DrawChr');
  end;
end;

procedure TWealthAnimalMon.DrawEff(dsurface: TDirectDrawSurface; dx,
  dy: integer);
begin
  try
    if m_boUseEffect and (DieEffectSurface <> nil) then begin
      DrawBlend (dsurface,
              dx + bx + m_nShiftX,
              dy + by + m_nShiftY,
              DieEffectSurface, 200);
    end;
  except
     DebugOutStr('TWealthAnimalMon.DrawEff');
  end
end;

procedure TWealthAnimalMon.LoadSurface;
begin
  inherited LoadSurface;
  if m_boUseEffect then begin
     DieEffectSurface := {FrmMain.WMon5Img20080720×¢ÊÍ}g_WMonImagesArr[24].GetCachedImage (
              1600 + m_nCurrentFrame-m_nStartFrame, //
              bx, by);
  end;
end;

{ TNewFireDragon }

procedure TNewFireDragon.CalcActorFrame;
var
   pm: PTMonsterAction;
begin
  try
   m_boUseMagic := False;
       case m_btDir of
        3,4:firedir:=0;
        5:firedir:=1;
        6,7:firedir:=2;
       end;
   m_btDir:=0;
   m_nCurrentFrame := -1;
   m_nBodyOffset := GetOffset (m_wAppearance);
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then Exit;
   case m_nCurrentAction of
     SM_DIGUP: begin
       Shift (0, 0, 0, 1);
       m_nStartFrame:=0;
       m_nEndFrame:=9;
       m_dwFrameTime:=300;
       m_dwStartTime:=GetTickCount;
     end;
     SM_HIT: begin
       m_btDir:=0;
       boChangeColor := True;
       m_nStartFrame:=0;
       m_nEndFrame:=19;
       m_dwFrameTime:=150;
       m_dwStartTime:=GetTickCount;
       //m_boUseEffect:=True;
       m_nEffectStart:=0;
       m_nEffectFrame:=0;
       m_nEffectEnd:=19;
       m_dwEffectStartTime:=GetTickCount;
       m_dwEffectFrameTime:=150;
       m_nCurEffFrame:=0;
       m_boUseMagic:=True;
       m_dwWarModeTime:=GetTickcount;
       Shift (m_btDir, 0, 0, 1);   
     end;
     SM_LIGHTING: begin //´ó»ðÈ¦¹¥»÷
       m_nStartFrame:=0;
       m_nEndFrame:=5;
       m_dwFrameTime:=150;
       m_dwStartTime:=GetTickCount;
       m_boUseEffect:=True;
       m_nEffectStart:=0;
       m_nEffectFrame:=0;
       m_nEffectEnd:=4;
       m_dwEffectStartTime:=GetTickCount;
       m_dwEffectFrameTime:=150;
       m_nCurEffFrame:=0;
       m_boUseMagic:=True;
       m_dwWarModeTime:=GetTickcount;
       Shift (m_btDir, 0, 0, 1);
     end;
     SM_STRUCK: begin
       m_nStartFrame:=0;
       m_nEndFrame:=9;
       m_dwFrameTime:=300;
       m_dwStartTime:=GetTickCount;
     end;
   end;
   except
      DebugOutStr ('TNewFireDragon.CalcActorFrame');
   end;
end;

constructor TNewFireDragon.Create;
begin
  inherited Create;
  boChangeColor := False;
end;

procedure TNewFireDragon.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer;
  blend, boFlag: Boolean);
var
  ceff: TColorEffect;
  idx, Wax, Way: Integer;
  d: TDirectDrawSurface;
begin
  try
   //if not (m_btDir in [0..7]) then exit;
   if m_btDir > 7 then Exit;
   if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //bodysurfaceµîÀÌ loadsurface¸¦ ´Ù½Ã ºÎ¸£Áö ¾Ê¾Æ ¸Þ¸ð¸®°¡ ÇÁ¸®µÇ´Â °ÍÀ» ¸·À½
   end;
   if boChangeColor then
   	 ceff := ceFuchsia
   else ceff := GetDrawEffectValue;
   DrawMyShow(dsurface,dx,dy); //ÏÔÊ¾×ÔÉí¶¯»­
   if m_BodySurface <> nil then
      DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
    if not m_boDeath then begin  //ËÀÍö²»ÏÔÊ¾
      if m_nState and $02000000 <> 0 then begin //Íò½£¹é×Ú»÷ÖÐ×´Ì¬
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, Wax, Way);
          if d <> nil then
            DrawBlend (dsurface, dx + Wax + m_nShiftX, dy + Way + m_nShiftY, d, 150);
      end;
      if m_nState and $00004000 <> 0 then begin //¶¨Éí×´Ì¬
          idx := 1080 + (m_nGenAniCount mod 8);
          d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
      end;
    end;
  except
    DebugOutStr('TNewFireDragon.DrawChr');
  end;
end;

procedure TNewFireDragon.Run;
var
   prv: integer;
   m_dwEffectFrameTimetime, m_dwFrameTimetime: longword;
   bo11:Boolean;
begin
  try
     if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_BACKSTEP) or (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803×¢ÊÍÆïÂíÏûÏ¢} then exit;

     m_boMsgMuch := FALSE;
     if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
     if m_boRunSound then begin
       PlaySound(8201);
       m_boRunSound:=False;
     end;

     if m_boUseEffect then begin
        if m_boMsgMuch then m_dwEffectFrameTimetime := Round(m_dwEffectFrameTime * 2 / 3)
        else m_dwEffectFrameTimetime := m_dwEffectFrameTime;
        if GetTickCount - m_dwEffectStartTime > m_dwEffectFrameTimetime then begin
           m_dwEffectStartTime := GetTickCount;
           if m_nEffectFrame < m_nEffectEnd then begin
              Inc (m_nEffectFrame);
           end else begin
              m_boUseEffect := FALSE;
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
              m_boUseEffect := FALSE;
              bo260:=False;
           end;
           if m_nCurrentFrame > m_nEndFrame-4 then boChangeColor := False;
           

           if (m_nCurrentAction = SM_LIGHTING) and (m_nCurrentFrame - m_nStartFrame = 1) then begin
             PlayScene.NewMagic (Self,102,102,m_nCurrX,m_nCurrY,m_nTargetX,m_nTargetY,m_nTargetRecog,mtFly,True,30,0,bo11);
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
    DebugOutStr ('TNewFireDragon.Run');
  end;
end;

end.
