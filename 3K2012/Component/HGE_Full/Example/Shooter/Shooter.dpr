program Shooter;

{$R *.res}

uses
  Windows, SysUtils, HGEImages, HGECanvas,  HGEDef, HGE, HGESpriteEngine;

type
   TBullet = class(TAnimatedSprite)
  private
    FMoveSpeed: Single;
  public
    procedure DoMove(const MoveCount: Single); override;
    procedure DoCollision(const Sprite: TSprite); override;
    property MoveSpeed: Single read FMoveSpeed write FMoveSpeed;
  end;

  TCustomShip = class(TAnimatedSprite)
  private
    FMoveSpeed: Single;
  public
    procedure SetAnim(DoMirror: Boolean; APlayMode: TAnimPlayMode);
    procedure DoMove(const MoveCount: Single); override;
    property MoveSpeed: Single read FMoveSpeed write FMoveSpeed;
  end;

  TTail = class(TAnimatedSprite)
  private
    FMoveSpeed: Single;
  public
    procedure DoMove(const MoveCount: Single); override;
    property MoveSpeed: Single read FMoveSpeed write FMoveSpeed;
  end;

  TShip = class(TCustomShip)
  private
    FShadow: TCustomShip;
    FTail: TTail;
  public
    constructor Create(const AParent: TSprite); override;
    property Shadow: TCustomShip read FShadow write FShadow;
    property Tail: TTail read FTail write FTail;
  end;

  TEnemy = class(TAnimatedSprite)
  private
    FAI: Integer;
    FVelocity1: Single;
    FVelocity2: Single;
    Curve: Integer;
    OriginalX: Single;
    FShadow: TEnemy;
  public
    procedure DoMove(const MoveCount: Single); override;
    property AI: Integer read FAI write FAI;
    property Velocity1: Single read FVelocity1 write FVelocity1;
    property Velocity2: Single read FVelocity2 write FVelocity2;
    property Shadow: TEnemy read FShadow write FShadow;
  end;

  TCloud = class(TAnimatedSprite)
  private
    FSize: Single;
    FValue: Single;
  public
    procedure DoMove(const MoveCount: Single); override;
    property Size : Single read FSize write FSize;
    property Value : Single read FValue  write FValue;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Font: TSysFont;
  SpriteEngine: TSpriteEngine;
  Y1, Y2: Integer;
  Ship: TShip;
  BackX: Single;

procedure CreateEnemy;
var
     RandEnemy: Integer;
     Enemy: TEnemy;
begin
     for RandEnemy := 0 to 3 do
     begin
          if Random(120) = 25 then
          begin
               Enemy := TEnemy.Create(SpriteEngine);
               Enemy.Shadow := TEnemy.Create(SpriteEngine);
               with Enemy do
               begin
                    X := Random(700);
                    Y := -Random(200);
                    ImageName := 'Enemy' + IntToStr(Random(5));
                    Width := PatternWidth;
                    Height := PatternHeight;
                    AnimSpeed := 0.35;
                    AnimStart := 0;
                    AnimCount := 8;
                    AnimLooped := True;
                    DoAnimate := True;
                    CollideMode := cmCircle;
                    DoCenter := False;
                    Collisioned := True;
                    CollideRadius := 16;
                    AI := Random(3);
                    OriginalX := X;
                    Velocity1 := 1;
                    Velocity2 := 2;
                    //enemy's shadow
                    Shadow.X := X + 30;
                    Shadow.Y := Y + 30;
                    Shadow.ImageName := Imagename;
                    Shadow.AnimSpeed := 0.35;
                    Shadow.AnimStart := 0;
                    Shadow.AnimCount := 8;
                    Shadow.AnimLooped := True;
                    Shadow.DoAnimate := True;
                    Shadow.DoCenter := False;
                    Shadow.AI := AI;
                    Shadow.OriginalX := X + 40;
                    Shadow.Velocity1 := 1;
                    Shadow.Velocity2 := 2;
                    Shadow.Red := 0;
                    Shadow.Green := 0;
                    Shadow.Blue := 0;
                    Shadow.Alpha := 50;
                    Shadow.ScaleX := 0.7;
                    Shadow.ScaleY := 0.7;
               end;
          end;
     end;
end;

procedure CreateCloud;
var
     Cloud: TCloud;
begin
     if Random(80) = 40 then
     begin
          Cloud := TCloud.Create(SpriteEngine);
          with Cloud do
          begin
               X := Random(800);
               Y := -Random(500) - 200;
               ImageName := 'cloud' + IntToStr(Random(2));
               Width := PatternWidth;
               Height:=PatternHeight;
               ScaleY := 0.7;
               Size := 1;
               Value := 0.003;
               DoCenter := True;
               BlendMode := Blend_Add;
          end;
     end;
end;


procedure TBullet.DoMove(const MoveCount: Single);
begin
     inherited;
     Y := Y - FMoveSpeed;
     if Y < 0 then
     begin
          Dead;
          Visible := False;
     end;
     CollidePos := Point2(X + 13, Y + 8);
     Collision;
end;

procedure TBullet.DoCollision(const Sprite: TSprite);
begin
     if (Sprite is TEnemy) then
     begin
          Collisioned := False;
          Visible := False;
          Dead;
          with TEnemy(Sprite) do
          begin
               BlendMode := Blend_Add;
               ImageName := 'explode';
               AnimCount := 32;
               AnimSpeed := 0.35;
               AnimLooped := False;
               Shadow.Dead;
          end;
     end;
end;

procedure TCustomShip.SetAnim(DoMirror: Boolean; APlayMode: TAnimPlayMode);
begin
     MirrorX := DoMirror;
     AnimStart := 0;

     AnimPlayMode := APlayMode;
     AnimCount := 4;
     AnimSpeed := 0.15;
     DoAnimate := True;
end;

procedure TCustomShip.DoMove(const MoveCount: Single);

begin
     inherited;
    //move Right
     if HGE.Input_GetKeyState(HGEK_RIGHT) then
     begin
          X := X + FMoveSpeed;
          if X > 560 then X:=560;
          if Trunc(AnimPos) = 0 then
               SetAnim(False, pmForward);
     end;

     if HGE.Input_KeyUp(HGEK_RIGHT) then
          SetAnim(False, pmBackward);

     //move left
     if HGE.Input_GetKeyState(HGEK_LEFT) then
     begin
          X := X - FMoveSpeed;
          if X < -50 then X:=-50;
          if Trunc(AnimPos) = 0 then
               SetAnim(True, pmForward);
     end;

     if HGE.Input_KeyUp(HGEK_LEFT) then
          SetAnim(True, pmBackward);

     if HGE.Input_GetKeyState(HGEK_UP) then
     begin
          Y := Y - FMoveSpeed;
          if Y < -40 then Y := -40;
     end;

     if HGE.Input_GetKeyState(HGEK_DOWN) then
     begin
          Y := Y + FMoveSpeed;
          if Y > 380 then Y := 380;
     end;
     Collision;
end;

constructor TShip.Create(const AParent: TSprite);
begin
     inherited;
     X := 300;
     Y := 300;
     ScaleX := 0.5;
     ScaleY := 0.5;
     MoveSpeed := 2;
     ImageName := 'ship4';
     Animlooped:=False;
  // self shadow
     Shadow := TCustomShip.Create(SpriteEngine);
     Shadow.X := 300;
     Shadow.Y := 250;
     Shadow.ScaleX := 0.4;
     Shadow.ScaleY := 0.4;
     Shadow.MoveSpeed := 1.2;
     Shadow.Red := 0;
     Shadow.Green := 0;
     Shadow.Blue := 0;
     Shadow.Alpha := 80;
     Shadow.ImageName := 'ship4';
  //
     Tail := TTail.Create(SpriteEngine);
     Tail.X := 322;
     Tail.Y := 356;
     Tail.ScaleX := 0.5;
     Tail.ScaleY := 0.65;
     Tail.MoveSpeed := 2;
     Tail.ImageName := 'tail';
     Tail.AnimSpeed := 0.1;
     Tail.AnimStart := 0;
     Tail.AnimCount := 3;
     Tail.AnimLooped := True;
     Tail.DoAnimate := True;
     Tail.BlendMode := Blend_Add;
end;

procedure TTail.DoMove(const MoveCount: Single);
begin
     inherited;
     if HGE.Input_GetKeyState(HGEK_RIGHT) then
     begin
          X := X + FMoveSpeed;
          if X > 582 then X := 582;
     end;
     if HGE.Input_GetKeyState(HGEK_LEFT) then
     begin
          X := X - FMoveSpeed;
          if x<-30 then X:=-30;
     end;
     if HGE.Input_GetKeyState(HGEK_UP) then
          Y := Y - FMoveSpeed;

     if HGE.Input_GetKeyState(HGEK_DOWN) then
     begin
          Y := Y + FMoveSpeed;
          if Y > 440 then Y:=440;
     end;
end;

procedure TEnemy.DoMove(const MoveCount: Single);
begin
     inherited;

     CollidePos := Point2(X + 32, Y + 32);
     if ImageName = 'explode' then
     begin
          Collisioned := False;
          Velocity1 := 0;
          Velocity2 := 0;
          if Trunc(AnimPos) = 31 then
               Dead;
      end;
    // AI = 0 just move the enemy downwards
    // AI = 1 move the enemy down in a nice sinus curve
    // AI = 2 make the enemy hunt the player
     case FAI of
          0: begin
                    Y := Y + Velocity2;
             end;
          1: begin
                    Y := Y + Velocity1;
                    Curve := Curve + Round(Velocity1);
                    X := OriginalX + Round(100 * sin(2 * PI * Curve / 360));
             end;
          2: begin
                    Y := Y + Velocity2;
                    if Ship.X > X then X := X + Velocity1;
                    if Ship.X < X then X := X - Velocity1;
             end;
     end;
     // if the enemy goes out of screen clear it out of memory
     if (Y > 600) then
     begin
          Dead;
          Visible := False;
          Collisioned := False;
     end;
end;

procedure TCloud.DoMove(const MoveCount: Single);
begin
     inherited;
     Y := Y + 0.8;
     FSize := FSize + FValue;
     if (FSize > 1) or (FSize < 0.9) then FValue := -FValue;
     ScaleX := FSize;
     if HGE.Input_GetKeyState(HGEK_RIGHT) then
          X := X - 0.35;
     if HGE.Input_GetKeyState(HGEK_LEFT) then
          X := X +0.35;
     if Y > 600 then
     begin
          Dead;
          Visible := False;
     end;
end;


function FrameFunc: Boolean;
var
   I: Integer;
   Bullet: TBullet;
begin
   if HGE.Input_KeyDown(HGEK_CTRL) or  HGE.Input_KeyDown(HGEK_SPACE) then
    begin
          for I := 0 to 1 do
          begin
               Bullet := TBullet.Create(SpriteEngine);
               Bullet.Collisioned := True;
               Bullet.CollideMode := cmCircle;
               Bullet.CollideRadius := 5;
               Bullet.MoveSpeed := 7;
               Bullet.DoCenter := False;
               Bullet.X := Ship.X + 10;
               if i = 1 then Bullet.X := Ship.X + 28;
               Bullet.Y := Ship.Y + 10;
               Bullet.ImageName := 'Bulletr';
               Bullet.BlendMode := Blend_Add;
               Bullet.ScaleX := 0.1;
               Bullet.ScaleY := 0.15;
               Bullet.MirrorY := True;
          end;
     end;

  case HGE.Input_GetKey of
    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      FreeAndNil(SpriteEngine);
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
  Canvas.DrawPart(Images.Image['jungle'], BackX, 0, 0, Y1, 800, 1024 , $FFFFFFFF, Blend_Default);
  Y1 := Y1 - 1;
  Y2 := Y2 + 1;
  CreateEnemy;
  CreateCloud;
  SpriteEngine.Draw;
  SpriteEngine.Move(1);
  SpriteEngine.Dead;
  if HGE.Input_GetKeyState(HGEK_RIGHT) then
      BackX := BackX - 0.25;
  if HGE.Input_GetKeyState(HGEK_LEFT) then
      BackX := BackX + 0.25;
  Ship.Shadow.PatternIndex := Ship.PatternIndex;
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
  HGE.System_SetState(HGE_SCREENWIDTH, 640);
  HGE.System_SetState(HGE_SCREENHEIGHT,480);
  HGE.System_SetState(HGE_SCREENBPP,16);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Images.LoadFromFile('bulletr.png');
    Images.LoadFromFile('cloud0.png');
    Images.LoadFromFile('cloud1.png');
    Images.LoadFromFile('enemy0.png',64,64);
    Images.LoadFromFile('enemy1.png',64,64);
    Images.LoadFromFile('enemy2.png',64,64);
    Images.LoadFromFile('enemy3.png',64,64);
    Images.LoadFromFile('enemy4.png',64,64);
    Images.LoadFromFile('explode.png',64,64);
    Images.LoadFromFile('jungle.png');
    Images.LoadFromFile('tail.png',40,20);
    Images.LoadFromFile('ship4.png',128,128);
    Ship := TShip.Create(SpriteEngine);
    Ship.Z := -5;
    BackX := -100;
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
