unit Monpj;

interface
uses
  Windows, Actor, AxeMon, MShare, AbstractCanvas, AbstractTextures, AsphyreTextureFonts,
  AsphyreTypes, uMyDxUnit, Grobal2, AspWil;

type
  TpjMon = class (TActor) //叛军怪物
   private
   protected
      //EffectSurface: TDirectDrawSurface;
      Dyz          : TAsphyreLockableTexture;//影子
      m_nyzOffsetX, m_nyzOffsetY : Integer;
   public
      procedure CalcActorFrame; override;
      procedure LoadSurface; override;
      procedure DrawChr (dsurface: TAsphyreCanvas; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
   end;

implementation

procedure TpjMon.CalcActorFrame;
var
  MA: pTMonsterAction;
begin
  inherited;
  MA := GetRaceByPM(m_btRace,m_wAppearance);
  if MA = nil then exit;
  if m_nCurrentAction = SM_DIGUP then begin
    //if m_btRace = 123 then
     m_nStartFrame := MA.ActCritical.start + m_btDir * (MA.ActCritical.frame + MA.ActCritical.skip);
     m_nEndFrame := m_nStartFrame + MA.ActCritical.frame - 1;
     m_dwFrameTime := MA.ActCritical.ftime;
     m_dwStartTime := GetTickCount;
     m_nDefFrameCount := MA.ActCritical.frame;
     Shift (m_btDir, 0, 0, 1);
  end;
end;
procedure TpjMon.LoadSurface;
var
   mimg: TAspWMImages;
   nErrCode: Byte;
  nOffset : Integer;
begin
  nErrCode := 0;
  try
    inherited;
    Dyz := nil;
    nErrCode := 1;
     mimg := GetMonImg (m_wAppearance);
     nErrCode := 2;
     case m_wAppearance of
       351,355,357, 360, 364,366, 369, 370,371,372, 373, 386 :nOffset := 480;
       376,378:nOffset :=560;
       363,380..385:nOffset := 0;
       else nOffset := 400;
     end;
     if (mimg <> nil) and (nOffset <> 0) then begin
        if (not m_boReverseFrame) then begin
          nErrCode := 3;
           Dyz := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nCurrentFrame + nOffset, m_nyzOffsetX, m_nyzOffsetY);
        end else begin
          nErrCode := 4;
           Dyz := mimg.GetCachedImage (
                              GetOffset (m_wAppearance) + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame) + nOffset,
                              m_nyzOffsetX, m_nyzOffsetY);

        end;
     end;
  except
  end;
end;

procedure TpjMon.DrawChr (dsurface: TAsphyreCanvas; dx, dy: integer; blend: Boolean;boFlag:Boolean);
begin
  if m_btDir > 7 then Exit;
  if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
       m_dwLoadSurfaceTime := GetTickCount;
       LoadSurface; //由于图片每60秒会释放一次（60秒内未使用的话），所以每60秒要检查一下是否已经被释放了.
  end;
  if Dyz <> nil then begin
    dsurface.Draw (dx + m_nyzOffsetX + m_nShiftX, dy + m_nyzOffsety + m_nShiftY, Dyz.ClientRect, Dyz, TRUE);
  end;
  inherited; 
end;

end.
