program Basic;

{$R *.res}

uses
  Windows, SysUtils, HGEImages, HGECanvas, HGEDef, HGE,
  HGESpriteEngine;

type
  TMonoSprite = class(TSprite)
  private
    FCounter: Double;
    FLife: Integer;
    FHit: Boolean;
  public
    procedure DoMove(const MoveCount: Single); override;
  end;

  TPlayerSprite = class(TSprite)
  public
    procedure DoCollision(const Sprite: TSprite); override;
    procedure DoMove(const MoveCount: Single); override;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Font: TSysFont;
  SpriteEngine: TSpriteEngine;
  Tile: array[0..80, 0..80] of TSprite;
  PlayerSprite: TPlayerSprite;

procedure TMonoSprite.DoMove(const MoveCount: Single);
begin
     inherited;
     CollidePos := Point2(X + 80, Y + 80);
     FCounter := FCounter + 1;
     X := X + Sin256(Trunc(FCounter)) * 3;
     Y := Y + Cos256(Trunc(FCounter)) * 3;
     if FHit then
     begin
          FLife := FLife - 1;
          if FLife < 0 then Dead;
     end;
end;

procedure TPlayerSprite.DoCollision(const Sprite: TSprite);
begin
     if Sprite is TMonoSprite then
     begin
          with TMonoSprite(Sprite) do
          begin
               ImageName := 'img1-2';
               Collisioned := False;
               FHit := True;
          end;
     end;
end;

procedure TPlayerSprite.DoMove(const MoveCount: Single);
begin
     inherited;
     CollidePos := Point2(X + 50, Y + 50);
     if HGE.Input_GetKeyState(HGEK_UP) then
          Y := Y - 3;
     if HGE.Input_GetKeyState(HGEK_Down) then
          Y := Y + 3;
     if HGE.Input_GetKeyState(HGEK_Left) then
          X := X - 3;
     if HGE.Input_GetKeyState(HGEK_Right) then
          X := X + 3;
     Collision;
     Engine.WorldX := X - 340;
     Engine.WorldY := Y - 250;
end;

procedure CreateTiles;
var
   I, J: Integer;
begin
     for I := 0 to 80 do
     begin
          for J := 0 to 80 do
          begin
               Tile[I, J] := TSprite.Create(SpriteEngine);
               Tile[I, J].ImageName := 't' + IntToStr(Random(20));
               Tile[I, J].Width := Tile[I, J].PatternWidth;
               Tile[I, J].Height := Tile[I, J].PatternHeight;
               Tile[I,J].Moved := False;
               Tile[I, J].X := I * 64;
               Tile[I, J].Y := J * 64;
          end;
     end;
end;

procedure CreateSprites;
var
  I: Integer;
begin
     for I := 0 to 200 do
     begin
          with TMonoSprite.Create(SpriteEngine) do
          begin
               ImageName := 'img1';
               Width := PatternWidth;
               Height := PatternHeight;
               Collisioned := True;
               CollideRadius := 80;
               X := Random(5000);
               Y := Random(5000);
               Z := 2;
               FCounter := Random(1000);
               FLife := 15;
               FHit := False;
          end;
     end;

     PlayerSprite := TPlayerSprite.Create(SpriteEngine);
     with TPlayerSprite(PlayerSprite) do
     begin
          ImageName := 'img2';
          Z := 2;
          X := 2560;
          Y := 2560;
          Collisioned := True;
          CollideRadius := 50;
     end;
end;

function FrameFunc: Boolean;
begin
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
  HGE.Gfx_Clear(0);
  SpriteEngine.Draw;
  SpriteEngine.Move(1);
  SpriteEngine.Dead;
  //Font.Print(100,100,IntToStr(HGE.Timer_GetFPS));
  HGE.Gfx_EndScene;
  Result := False;
end;

procedure Main;
var
  I: Integer;
begin
  HGE := HGECreate(HGE_VERSION);
  HGE.System_SetState(HGE_FRAMEFUNC,FrameFunc);
  HGE.System_SetState(HGE_RENDERFUNC,RenderFunc);
  HGE.System_SetState(HGE_USESOUND, False);
  HGE.System_SetState(HGE_WINDOWED,False);
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP,16);
  //HGE.System_SetState(HGE_TEXTUREFILTER,True);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  //HGE.System_SetState(HGE_SHOWSPLASH, False);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Font:=TSysFont.Create;
    Font.CreateFont('arial',15,[]);
    for I := 0 to 20 do
     Images.LoadFromFile('Gfx\'+'t'+IntTostr(I)+'.png');
    Images.LoadFromFile('Gfx\img1.png');
    Images.LoadFromFile('Gfx\img1-2.png');
    Images.LoadFromFile('Gfx\img2.png');
    CreateSprites;
    CreateTiles;
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
