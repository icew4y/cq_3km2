program NGame;

{$R *.res}

uses
  Windows, SysUtils, Classes, HGEDef, HGEImages, HGECanvas, HGESpriteEngine,
  HGENURBS, HGE;

type
  TPlayer = class(TAnimatedSprite)
  public
    procedure DoMove(const MoveCount: Single); override;
    constructor Create(const AParent: TSprite); override;
  end;

  TSpaceBall = class(TNPathSprite)
  private
    FColor: Cardinal;
    FID: Integer;
  published
    property ID: Integer read FID write FID;
    property Color: Cardinal read FColor write FColor;
    procedure DoMove(const MoveCount: Single); override;
    procedure DoCollision(const Sprite: TSprite); override;
    destructor Destroy; override;
  end;

  TShotBall = class(TAnimatedSprite)
  private
    FVelocity: Single;
    FLifeTime: Real;
    FDecay: Real;
    FFired: Boolean;
    FColor: Cardinal;
  public
    property Color: Cardinal read FColor write FColor;
    property Fired: Boolean read FFired write FFired;
    property Velocity: Single read FVelocity write FVelocity;
    property Decay: Real read FDecay write FDecay;
    property LifeTime: Real read FLifeTime write FLifeTime;
    procedure DoMove(const MoveCount: Single); override;
    procedure MoveOut;
    procedure SwitchColor;
    procedure DoCollision(const Sprite: TSprite); override;
    constructor Create(const AParent: TSprite); override;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  SpriteEngine: TSpriteEngine;
  LevelPath: TNURBSCurveEx;
  Player: TPlayer;
  ShotBall: TShotBall;
  ShotSpeed: Single = 20.0;
  CanCharge: Boolean;
  GameBallCount: Integer;
  GameSpeed: Single = 3.6;
  NextBallReady: boolean;
  NextBallInterval: Single;
  MousePosition: TPoint2;
  Font: TSysFont;
  MouseX, MouseY: Single;

procedure ChargeShot;
begin
  ShotBall := TShotBall.Create(SpriteEngine);
  CanCharge := false;
end;

constructor TPlayer.Create(const AParent: TSprite);
begin
  inherited;
  ImageName := 'Cannon';
  DrawMode  := 1;
  X := 600;
  Y := 500;
end;

procedure TPlayer.DoMove(const MoveCount: Single);
begin
  inherited;
  Angle := Angle2(Point2(MouseX - X + Engine.WorldX, MousePosition.y - Y + Engine.WorldY)) + pi/2;
end;

{ TSpaceBall }
destructor TSpaceBall.Destroy;
begin
  inherited;
end;

procedure TSpaceBall.DoCollision(const Sprite: TSprite);
begin
  inherited;
end;

procedure TSpaceBall.DoMove(const MoveCount: Single);
begin
  inherited;
  CollidePos := Point2(Trunc(X),Trunc(Y));
  if Distance >= 100 then Dead;
  LookAt(pi/2);
end;


{ TShotBall }

constructor TShotBall.Create(const AParent: TSprite);
begin
  inherited;
  case Random(3) of
    0: ImageName := 'Ball0';
    1: ImageName := 'Ball1';
    2: ImageName := 'Ball2';
  end;
  DrawMode := 1;
  Collisioned := True;
  CollideMode := cmCircle;
  CollideRadius := 64;
  Velocity := ShotSpeed;
  LifeTime := Velocity;
  Decay := LifeTime/100;
  Fired := False;
  Angle := Player.Angle;
  X := Player.X;
  Y := Player.Y;
  Z := 100;
  Collisioned := True;
  CollideMode := cmCircle;
  CollideRadius := Trunc(0.7*Width*ScaleX/2);
end;

procedure TShotBall.DoCollision(const Sprite: TSprite);
begin
  inherited;
  if (Sprite is TSpaceBall) then
    if Sprite.ImageName = Self.ImageName then
      begin
        Sprite.Dead;
        MoveOut;
      end
    else
      begin
        MoveOut;
      end;
end;

procedure TShotBall.DoMove(const MoveCount: Single);
begin
  inherited;
  if not Fired then
    begin
      Angle := Player.Angle;
      X := Player.X;
      Y := Player.Y;
    end
  else
    begin
      X := X + Cos(Angle - pi/2)*Velocity;
      Y := Y + Sin(Angle - pi/2)*Velocity;
      CollidePos := Point2(Trunc(X),Trunc(Y));
      if (X < -20) or (Y < -20) or (X > 820) or (Y > 620) then MoveOut;
      Collision;
    end;
end;

procedure TShotBall.MoveOut;
begin
  Self.Dead;
  CanCharge := True;
end;

procedure TShotBall.SwitchColor;
begin
  if ImageName = 'Ball0' then
    begin
      ImageName := 'Ball1';
      Exit;
    end;
  if ImageName = 'Ball1' then
    begin
      ImageName := 'Ball2';
      Exit;
    end;
  if ImageName = 'Ball2' then
    begin
      ImageName := 'Ball0';
      Exit;
    end;
end;

function FrameFunc: Boolean;
var
 I: Integer;
begin
  HGE.Input_GetMousePos(MouseX, MouseY);
  MousePosition.X := MouseX;
  MousePosition.Y := MouseY;
  if HGE.Input_KeyDown(HGEK_LBUTTON) then
  begin
    if not ShotBall.Fired then
    begin
      ShotBall.Fired := true;
      ShotBall.Z := 0;
    end;
  end;
  //
  if HGE.Input_KeyDown(HGEK_RBUTTON) then
  begin
    if not ShotBall.Fired then ShotBall.SwitchColor;
  end;

  NextBallInterval := 3;
  for I := 0 to SpriteEngine.Count - 1 do
  begin
    if (SpriteEngine.Items[I] is TSpaceBall) and
       (TSpaceBall(SpriteEngine.Items[I]).ID = GameBallCount - 1) then
        if TSpaceBall(SpriteEngine.Items[I]).Distance >= NextBallInterval then
          NextBallReady := True;
  end;

  if NextBallReady then
  begin
    with TSpaceBall.Create(SpriteEngine) do
    begin
      ID := GameBallCount;
      case Random(3) of
          0: ImageName := 'Ball0';
          1: ImageName := 'Ball1';
          2: ImageName := 'Ball2';
      end;
      DrawMode := 1;
      MoveSpeed := GameSpeed;
      Path := LevelPath;
      X := Path.GetXY(0).X;
      Y := Path.GetXY(0).Y;
      Collisioned := True;
      CollideMode := cmCircle;
      CollideRadius := Trunc(0.7*Width*ScaleX/2);
    end;
    NextBallReady := False;
    Inc(GameBallCount);
  end;

  if CanCharge then ChargeShot;

  case HGE.Input_GetKey of
    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      FreeAndNil(SpriteEngine);
      FreeAndNil(LevelPath);
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
  Canvas.Draw(Images.Image['Back'], 0, 0, 0, Blend_Default);
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
  HGE.System_SetState(HGE_WINDOWED, False);
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP,32);
  HGE.System_SetState(HGE_TEXTUREFILTER, true);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  HGE.System_SetState(HGE_HIDEMOUSE, False);
  Canvas := THGECanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  SpriteEngine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Images.LoadFromFile('Back.jpg');
    Images.LoadFromFile('Ball0.png');
    Images.LoadFromFile('Ball1.png');
    Images.LoadFromFile('Ball2.png');
    Images.LoadFromFile('Cannon.png');
    Font := TSysFont.Create;
    Font.CreateFont('Arial',12,[]);
    Player := TPlayer.Create(SpriteEngine);
    LevelPath := TNURBSCurveEx.Create;
    LevelPath.FittingCurveType := fcConstantSpeed;
    LevelPath.LoadCurve('nurbs.data');
    NextBallReady := True;
    CanCharge := True;
    Randomize;

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
