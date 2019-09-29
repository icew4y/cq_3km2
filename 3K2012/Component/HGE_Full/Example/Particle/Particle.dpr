program Particle;

{$R *.res}

uses
  Windows,
  SysUtils,
  HGEImages,
  HGECanvas,
  HGEDef,
  HGE,
  HGESpriteEngine;

type
  P = class(TParticleSprite)
  public
    procedure DoMove(const MoveCount: Single); override;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Font: TSysFont;
  SpriteEngine: TSpriteEngine;
  ticks: Integer;
  

procedure P.DoMove(const MoveCount: Single);
begin
     inherited;
     Alpha := Alpha - 1;
     Red := Red - 1;
     Blue := Blue - 1;
     ScaleX := ScaleX - 0.005;
     ScaleY := ScaleY - 0.005;
end;

procedure CreateParticle;
var
     Pos: TPoint2;
begin
     Pos.x := 300.0 + (Cos(ticks / 130.0) * 150) - (Sin(ticks / 20.0) * 150);
     Pos.y := 256.0 + (Sin(ticks / 30.0) * 150) + (Cos(ticks / 20.0) * 150);
     Inc(ticks);
     with P.Create(SpriteEngine) do
     begin
          Decay := 1.5;
          LifeTime := 255;
          X := Pos.x;
          Y := Pos.y;
          AnimStart := 0;
          AnimCount := 32;
          DoAnimate := True;
          AnimSpeed := 0.8;
          AnimLooped := True;
          ImageName := 'circle';
          BlendMode := Blend_Bright;
     end;

     Pos.x := 400.0 + (Cos(ticks / 130.0) * 150) + (Sin(ticks / 20.0) * 150);
     Pos.y := 256.0 - (Sin(ticks / 30.0) * 150) + (Cos(ticks / 20.0) * 150);
     with P.Create(SpriteEngine) do
     begin
          Decay := 1.5;
          LifeTime := 255;
          X := Pos.x;
          Y := Pos.y;
          AnimStart := 0;
          AnimCount := 32;
          DoAnimate := True;
          AnimSpeed := 0.8;
          AnimLooped := True;
          ImageName := 'circle';
          BlendMode := Blend_Bright;
     end;
end;


function FrameFunc: Boolean;
begin
  CreateParticle;
  case HGE.Input_GetKey of
    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      FreeAndNil(SpriteEngine);
      FreeAndNil(Font);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function RenderFunc: Boolean;
begin
  HGE.Gfx_BeginScene;
  HGE.Gfx_Clear(ARGB(255,0,150,150));
  SpriteEngine.Draw;
  SpriteEngine.Move(1);
  SpriteEngine.Dead;
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
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP,16);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Images.LoadFromFile('circle.png',60,60);
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
