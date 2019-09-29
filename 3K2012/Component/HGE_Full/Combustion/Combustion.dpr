program Combustion;

{$R *.res}

uses
  Windows, Classes, SysUtils,  HGEImages, HGECanvas,  HGESpriteEngine,  HGE;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  SpriteEngine: TSpriteEngine;
  DT: Single;

function FrameFunc: Boolean;
var
  I : Integer;
begin
  DT := HGE.Timer_GetDelta;
  for I := 0 to 15 do
  begin
    if (Random(7) = 0) then
    begin
      with TParticleSprite.Create(SpriteEngine) do
      begin
        ImageName := 'Fire';
        Decay := 1;
        UpdateSpeed := 1;
        LifeTime := 80;
        X := Random(640);
        Y := 470;
        Z := 2;
        Width:= 128;
        Height:=128;
        AnimStart := 0;
        AnimCount := 32;
        DoAnimate := True;
        AnimSpeed := 30 * DT;
        AccelX := 0.0;
        AccelY := -(0.0025 + (Random(10) / 200))*10 * DT;
        VelocityY := -(Random(20) / 4)*80* DT;
        AnimLooped := False;
        Angle := Random * Pi * 2;
        DrawMode := 1;
      end;
    end;
  end;
  SpriteEngine.Dead;
  SpriteEngine.Move(1);

  case HGE.Input_GetKey of
    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      FreeAndnil(SpriteEngine);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function RenderFunc: Boolean;
begin
  HGE.Gfx_BeginScene;
  Hge.Gfx_Clear(ARGB(255,0,195,155));
  SpriteEngine.Draw;
  HGE.Gfx_EndScene;
  Result := False;
end;

procedure Main;
begin
  HGE := HGECreate(HGE_VERSION);
  HGE.System_SetState(HGE_FRAMEFUNC,FrameFunc);
  HGE.System_SetState(HGE_RENDERFUNC,RenderFunc);
  HGE.System_SetState(HGE_USESOUND, False);
  HGE.System_SetState(HGE_WINDOWED,False);
  HGE.System_SetState(HGE_SCREENWIDTH, 640);
  HGE.System_SetState(HGE_SCREENHEIGHT,480);
  HGE.System_SetState(HGE_SCREENBPP,32);
  HGE.System_SetState(HGE_TEXTUREFILTER, true);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Images.LoadFromFile('Scanline.png');
    Images.LoadFromFile('Fire.png',128, 128);
    with TTileMapSprite.Create(SpriteEngine) do
    begin
      ImageName := 'Scanline';
      Width := 64;
      Height := 64;
      SetMapSize(SpriteEngine.VisibleWidth div Width, SpriteEngine.VisibleHeight div Height);
      DoTile := True;
      Z := 2;
      BlendMode:=Blend_Multiply;
    end;
    HGE.System_Start;
  end
  else
    MessageBox(0,PChar(HGE.System_GetErrorMessage),'Error',MB_OK or MB_ICONERROR or MB_SYSTEMMODAL);

  HGE.System_Shutdown;
  HGE := nil;
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  Main;
end.
