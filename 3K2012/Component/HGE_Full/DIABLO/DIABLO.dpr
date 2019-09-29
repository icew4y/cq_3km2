program DIABLO;

{$R *.res}

uses
  Windows, SysUtils, HGEImages, HGECanvas, HGEDef, HGE,
  Math, HGESpriteEngine;

type
  TShadowSprite = class;
  TTile = class(TSprite)
  public
     procedure DoDraw; override;
  end;

  TFinger = class(TAnimatedSprite)
  public
    procedure DoMove(const MoveCount: Single); override;
    procedure DoCollision(const Sprite: TSprite); override;
  end;

  TCharacter = class(TAnimatedSprite)
  private
    FWalkSpeed: Single;
    FDirection: Integer;
    FFramePerDir: Integer;
    FShadow: TShadowSprite;
  protected
    procedure SetDirectionAnim; virtual;
    procedure GoDirection8; virtual;
  public
    constructor Create(const AParent: TSprite); override;
    procedure DoDraw;override;
    property Shadow: TShadowSprite read FShadow write FShadow;
    property Direction: Integer read FDirection write FDirection;
    property WalkSpeed: Single read FWalkSpeed write FWalkSpeed;
    property FramePerDir: Integer read FFramePerDir write FFramePerDir;
  end;

  TLight=class(TCharacter);

  TShadowSprite = class(TCharacter)
  public
    procedure GoDirection8; override;
    procedure DoDraw; override;
    procedure DoMove(const MoveCount: Single); override;
  end;

  THero = class(TCharacter)
  private
    FShadow: TShadowSprite;
  public
    procedure DoMove(const MoveCount: Single); override;
    procedure DoDraw; override;
    property Shadow: TShadowSprite read FShadow write FShadow;
  end;

  TMonster = class(TCharacter)
  private
    FLight: TLight;
  public
    procedure DoMove(const MoveCount: Single); override;
    property Light: TLight read FLight write FLight;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Font: TSysFont;
  SpriteEngine: TSpriteEngine;
  Tiles: array of array of TTile;
  Monster: array of array of TMonster;
  Hero: THero;
  Finger: TFinger;
  MX, MY: Single;
  Velocity1: Single;
  Velocity2: Single;

procedure TTile.DoDraw;
begin
  if (X > Engine.WorldX-Width)and
  (Y > Engine.WorldY-Height) and
  (X < Engine.WorldX +800) and
  (Y < Engine.WorldY +600) then
     inherited DoDraw;
end;

procedure TCharacter.DoDraw;
begin
  if (X > Engine.WorldX-Width) and
  (Y > Engine.WorldY-Height)and
  (X < Engine.WorldX +800)and
  (Y < Engine.WorldY +600) then
     inherited DoDraw;
end;

procedure TFinger.DoMove(const MoveCount: Single);
begin
  inherited;
  X := Mx + Engine.WorldX;
  Y := My + Engine.WorldY;
  CollidePos := Point2(X + 16, Y + 16);
end;

procedure TCharacter.SetDirectionAnim;
begin
     case Direction of
          0: begin AnimStart := 0 * FramePerDir; MirrorX := False; end;
          1: begin AnimStart := 1 * FramePerDir; MirrorX := False; end;
          2: begin AnimStart := 2 * FramePerDir; MirrorX := False; end;
          3: begin AnimStart := 3 * FramePerDir; MirrorX := False; end;
          4: begin AnimStart := 4 * FramePerDir; MirrorX := False; end;
          //5,6,7 use image mirror
          5: begin AnimStart := 3 * FramePerDir; MirrorX := True; end;
          6: begin AnimStart := (3 - 1) * FramePerDir; MirrorX := True; end;
          7: begin AnimStart := (3 - 2) * FramePerDir; MirrorX := True; end;
     end;
end;

procedure TCharacter.GoDirection8;
begin
     if Direction = 0 then Y := Y - FWalkSpeed;
     if Direction = 1 then begin X := X + FWalkSpeed; Y := Y - FWalkSpeed; end;
     if Direction = 2 then X := X + FWalkSpeed;
     if Direction = 3 then begin X := X + FWalkSpeed; Y := Y + FWalkSpeed; end;
     if Direction = 4 then Y := Y + FWalkSpeed;
     if Direction = 5 then begin X := X - FWalkSpeed; Y := Y + FWalkSpeed; end;
     if Direction = 6 then X := X - FWalkSpeed;
     if Direction = 7 then begin X := X - FWalkSpeed; Y := Y - FWalkSpeed; end;
end;

procedure TFinger.DoCollision(const Sprite: TSprite);
begin

     if (Sprite is TMonster) then
     begin
          with TMonster(Sprite) do
          begin
               Red := 180;
               Green := 180;
               Blue := 180;
               Font.Print(Round(X - Engine.WorldX) + 10,
               Round(Y - Engine.WorldY) - 15,ImageName);

          end;
     end;

     if (Sprite is THero) then
     begin
          with THero(Sprite) do
          begin
               Red := 200;
               Green := 200;
               Blue := 200;
               BlendMode := Blend_Bright;//FxBrightAdd;
               Font.Print( Round(X - Engine.WorldX) + 30,
               Round(Y - Engine.WorldY),ImageName);

          end;
     end;
end;

constructor TCharacter.Create(const AParent: TSprite);
begin
     inherited;
     FWalkSpeed := 1.25;
end;

procedure TShadowSprite.DoDraw;
begin
           if (X1 > Engine.WorldX-Width )and
          (Y1 > Engine.WorldY-Height) and
          (X1 < Engine.WorldX +Engine.VisibleWidth)  and
          (Y1 < Engine.WorldY +Engine.VisibleHeight) then
          Engine.Canvas.Draw4V(Engine.Images.Image[ImageName],
          PatternIndex,
          Trunc(X1 + OffsetX - Engine.WorldX), Trunc(Y1 + OffsetY - Engine.WorldY),
          Trunc(X2 + OffsetX - Engine.WorldX), Trunc(Y2 + OffsetY - Engine.WorldY),
          Trunc(X3 + OffsetX - Engine.WorldX), Trunc(Y3 + OffsetY - Engine.WorldY),
          Trunc(X4 + OffsetX - Engine.WorldX), Trunc(Y4 + OffsetY - Engine.WorldY),
          MirrorX, MirrorY,
          ARGB(Alpha,Red, Green, Blue),Blend_Default);
end;

procedure TShadowSprite.DoMove;
begin
     inherited;
     GoDirection8;
     SetDirectionAnim;
end;

procedure TShadowSprite.GoDirection8;
begin
     if Direction = 0 then begin Y1 := Y1 - FWalkSpeed; Y2 := Y2 - FWalkSpeed; Y3 := Y3 - FWalkSpeed; Y4 := Y4 - FWalkSpeed; end;
     if Direction = 1 then begin X1 := X1 + FWalkSpeed; X2 := X2 + FWalkSpeed; X3 := X3 + FWalkSpeed; X4 := X4 + FWalkSpeed; Y1 := Y1 - FWalkSpeed; Y2 := Y2 - FWalkSpeed; Y3 := Y3 - FWalkSpeed; Y4 := Y4 - FWalkSpeed; end;
     if Direction = 2 then begin X1 := X1 + FWalkSpeed; X2 := X2 + FWalkSpeed; X3 := X3 + FWalkSpeed; X4 := X4 + FWalkSpeed; end;
     if Direction = 3 then begin X1 := X1 + FWalkSpeed; X2 := X2 + FWalkSpeed; X3 := X3 + FWalkSpeed; X4 := X4 + FWalkSpeed; Y1 := Y1 + FWalkSpeed; Y2 := Y2 + FWalkSpeed; Y3 := Y3 + FWalkSpeed; Y4 := Y4 + FWalkSpeed; end;
     if Direction = 4 then begin Y1 := Y1 + FWalkSpeed; Y2 := Y2 + FWalkSpeed; Y3 := Y3 + FWalkSpeed; Y4 := Y4 + FWalkSpeed; end;
     if Direction = 5 then begin X1 := X1 - FWalkSpeed; X2 := X2 - FWalkSpeed; X3 := X3 - FWalkSpeed; X4 := X4 - FWalkSpeed; Y1 := Y1 + FWalkSpeed; Y2 := Y2 + FWalkSpeed; Y3 := Y3 + FWalkSpeed; Y4 := Y4 + FWalkSpeed; end;
     if Direction = 6 then begin X1 := X1 - FWalkSpeed; X2 := X2 - FWalkSpeed; X3 := X3 - FWalkSpeed; X4 := X4 - FWalkSpeed; end;
     if Direction = 7 then begin X1 := X1 - FWalkSpeed; X2 := X2 - FWalkSpeed; X3 := X3 - FWalkSpeed; X4 := X4 - FWalkSpeed; Y1 := Y1 - FWalkSpeed; Y2 := Y2 - FWalkSpeed; Y3 := Y3 - FWalkSpeed; Y4 := Y4 - FWalkSpeed; end;
end;

procedure TMonster.DoMove(const MoveCount: Single);
begin
     inherited;
     case Random(100) of
          50: Direction := Random(8);
     end;
     GoDirection8;
     SetDirectionAnim;
     CollidePos := Point2(X + 60, Y + 50);
     Light.X := X + Width div 2;
     Light.Y := Y + Height div 2+20;
     if ImageName = 'Mega Demon' then CollidePos := Point2(X + 120, Y + 100);
end;

procedure CreateTiles(ArrayA, ArrayB, OffsetX, OffsetY: Integer);
var
  a, b: Integer;
begin
  SetLength(Tiles, ArrayA, ArrayB);
  for a := 0 to ArrayA - 1 do
  begin
    for b := 0 to ArrayB - 1 do
    begin
      Tiles[a,b] := TTile.Create(SpriteEngine);
      Tiles[a,b].ImageName := 'Floor';
      Tiles[a,b].Width:=Tiles[a,b].PatternWidth;
      Tiles[a,b].Height:=Tiles[a,b].PatternHeight;
      Tiles[a,b].Moved := False;
      Tiles[a,b].X := 79 * b + OffsetX;
      if (b mod 2) = 0 then
        Tiles[a, b].Y := 79 * a + OffsetY;
      if (b mod 2) = 1 then
        Tiles[a, b].Y := 40 + 79 * a + OffsetY;
      Tiles[a, b].PatternIndex := Random(30);
    end;
  end;
end;

procedure DrawTiles;
var
  a, b: Integer;
begin
  for a := 0 to High(Tiles) - 1 do
  begin
    for b := 0 to High(Tiles[0]) - 1 do
    begin
      Tiles[a, b].DoDraw;
  // Tiles[a,b].Move(1);
    end;
  end;
end;

procedure CreateMonsters(ArrayA, ArrayB: Integer);
var
  a, b: Integer;
begin
  SetLength(Monster, ArrayA, ArrayB);
  for a := 0 to ArrayA - 1 do
  begin
    for b := 0 to ArrayB - 1 do
    begin
      Monster[a, b] := TMonster.Create(SpriteEngine);
      Monster[a, b].ImageName := Images.Items[Random(7)].Name;
      Monster[a,b].Width:=Monster[a,b].PatternWidth;
      Monster[a,b].Height:=Monster[a,b].PatternHeight;
      Monster[a, b].FramePerDir := Monster[a, b].PatternCount div 5;
      Monster[a, b].X := Random(7000) - 3000;
      Monster[a, b].Y := Random(7000) - 3000;
      Monster[a, b].Direction := Random(8);
      Monster[a, b].AnimCount := Monster[a, b].FramePerDir;
      Monster[a, b].AnimSpeed := 0.35;
      Monster[a, b].DoAnimate := True;
      Monster[a, b].AnimLooped := True;
      Monster[a, b].Red := 165;
      Monster[a, b].Green := 165;
      Monster[a, b].Blue := 165;
      Monster[a,b].BlendMode:= Blend_Bright;
      Monster[a, b].CollideRadius := 25;
      if Monster[a, b].ImageName = 'dm' then Monster[a, b].CollideRadius := 50;
      Monster[a, b].Collisioned := True;
      Monster[a, b].Light := TLight.Create(SpriteEngine);
      Monster[a, b].Light.ImageName := 'Light';
      Monster[a,b].Light.Moved:=False;
      Monster[a,b].Light.Collisioned:=False;
      Monster[a,b].Light.Width:= Monster[a,b].Light.PatternWidth;
      Monster[a,b].Light.Height:= Monster[a,b].Light.PatternHeight;
      Monster[a, b].Light.BlendMode := Blend_Light;
      Monster[a, b].Light.ScaleX := 0.5;
      Monster[a, b].Light.ScaleY := 0.3;
      Monster[a, b].Light.DoCenter:=True;
      //Create Sprite's shadow
      Monster[a, b].Shadow := TShadowSprite.Create(SpriteEngine);
      Monster[a, b].Shadow.DrawMode := 1;
      Monster[a, b].Shadow.Red := 0;
      Monster[a, b].Shadow.Green := 0;
      Monster[a, b].Shadow.Blue := 0;
      Monster[a, b].Shadow.Alpha := 80;
      Monster[a, b].Shadow.ImageName := Monster[a, b].ImageName;
      Monster[a, b].Shadow.AnimCount := Monster[a, b].FramePerDir;
      Monster[a, b].Shadow.AnimSpeed := 0.35;
      Monster[a, b].Shadow.AnimLooped := True;
      Monster[a, b].Shadow.DoAnimate := True;
      Monster[a, b].Shadow.Direction := Monster[a, b].Direction;
      Monster[a, b].Shadow.X1 := -(Monster[a, b].PatternWidth div 2) + Monster[a, b].X + 6;
      Monster[a, b].Shadow.Y1 := (Monster[a, b].PatternHeight div 2) + Monster[a, b].Y;
      Monster[a, b].Shadow.X2 := (Monster[a, b].PatternWidth div 2) + Monster[a, b].X + 6;
      Monster[a, b].Shadow.Y2 := (Monster[a, b].PatternHeight div 2) + Monster[a, b].Y;
      Monster[a, b].Shadow.X3 := Monster[a, b].PatternWidth + Monster[a, b].X + 6;
      Monster[a, b].Shadow.Y3 := Monster[a, b].PatternHeight + Monster[a, b].Y;
      Monster[a, b].Shadow.X4 := Monster[a, b].X + 6;
      Monster[a, b].Shadow.Y4 := Monster[a, b].PatternHeight + Monster[a, b].Y;
    end;
  end;
end;

procedure DrawMonsters;
var
  a, b: Integer;
begin
  for a := 0 to High(Monster) - 1 do
  begin
    for b := 0 to High(Monster[0]) - 1 do
    begin
      Monster[a, b].Shadow.DoDraw;
      Monster[a, b].Shadow.Move(1);
      Monster[a, b].DoDraw;
      Monster[a, b].Move(1);
      Monster[a, b].Shadow.Direction := Monster[a, b].Direction;
      Monster[a, b].Red := 65;
      Monster[a, b].Green := 65;
      Monster[a, b].Blue := 65;
      Monster[a, b].Light.DoDraw;
      Finger.Collision(Monster[a, b]);
    end;
  end;
end;
{
procedure THeroShadow.Draw;
begin
  PowerDraw.Device.DrawTransForm(PowerDraw.Images.Image[ImageName],
    PatternIndex,
    RoundNormal(X1 + OffsetX - Parent.WorldX), RoundNormal(Y1 + OffsetY - Parent.WorldY),
    RoundNormal(X2 + OffsetX - Parent.WorldX), RoundNormal(Y2 + OffsetY - Parent.WorldY),
    RoundNormal(X3 + OffsetX - Parent.WorldX), RoundNormal(Y3 + OffsetY - Parent.WorldY),
    RoundNormal(X4 + OffsetX - Parent.WorldX), RoundNormal(Y4 + OffsetY - Parent.WorldY),
    MirrorH, MirrorV,
    RGB1(Red, Green, Blue, Alpha), opSrcAlpha or opDiffuse);
end;
 }
procedure CreateHero;
begin
  Hero := THero.Create(SpriteEngine);
  Hero.ImageName := 'Player';
  Hero.Width:=Hero.PatternWidth;
  Hero.Height:=Hero.PatternHeight;
  Hero.X := 320;
  Hero.Y := 200;
  Hero.FramePerDir := 8;
  Hero.AnimSpeed := 0.30;
  Hero.DoAnimate := False;
  Hero.AnimLooped := True;
  Hero.AnimCount := 8;
  Hero.Red := 65;
  Hero.Green := 65;
  Hero.Blue := 65;
  Hero.Collisioned := True;
  Hero.CollideRadius := 20;
 //create hero's shadow
  Hero.Shadow := TShadowSprite.Create(SpriteEngine);
  Hero.Shadow.DrawMode := 3;
  Hero.Shadow.Red := 0;
  Hero.Shadow.Green := 0;
  Hero.Shadow.Blue := 0;
  Hero.Shadow.Alpha := 128;
  Hero.Shadow.ImageName := 'Player';
  Hero.Shadow.Width:=Hero.Shadow.PatternWidth;
  Hero.Shadow.Height:=Hero.Shadow.PatternHeight;
  Hero.Shadow.AnimCount := 8;
  Hero.Shadow.FramePerDir := 8;
  Hero.Shadow.AnimSpeed := 0.30;
  Hero.Shadow.AnimLooped := True;
  Hero.Shadow.DoAnimate := False;
end;

procedure DrawHero;
begin
  Hero.Shadow.DoDraw;
  Hero.Shadow.Move(1);
  Hero.DoDraw;
  Hero.Move(1);
  Hero.Shadow.X1 := -(Hero.PatternWidth div 2) + Hero.X - 6;
  Hero.Shadow.Y1 := (Hero.PatternHeight div 2) + Hero.Y;
  Hero.Shadow.X2 := (Hero.PatternWidth div 2) + Hero.X + 6;
  Hero.Shadow.Y2 := (Hero.PatternHeight div 2) + Hero.Y;
  Hero.Shadow.X3 := Hero.PatternWidth + Hero.X + 6;
  Hero.Shadow.Y3 := Hero.PatternHeight + Hero.Y;
  Hero.Shadow.X4 := Hero.X + 6;
  Hero.Shadow.Y4 := Hero.PatternHeight + Hero.Y;
  Hero.Shadow.Direction := Hero.Direction;
end;

function Angles(X, Y: Integer): Real;
begin
  Result := Abs(((Arctan2(X, Y) * 40.5)) - 128);
end;

procedure THero.DoMove(const MoveCount: Single);
var
  Directions: Integer;

begin
  inherited;

  Hero.CollidePos := point2(320 + Engine.WorldX + 70, 200 + Engine.WorldY + 70);
  Hero.X := Engine.WorldX + 320;
  Hero.Y := Engine.WorldY + 200;
  Directions := Round(Angles(trunc(MX) - 320, trunc(MY) - 200));

  case Directions of
    240..255,
      0..15:
      begin
        Direction := 0;
        Engine.WorldY := Engine.WorldY - Velocity1;
      end;
    16..47:
      begin
        Direction := 1;
        Engine.WorldX := Engine.WorldX + Velocity2;
        Engine.WorldY := Engine.WorldY - Velocity2;
      end;
    48..79:
      begin
        Direction := 2;
        Engine.WorldX := Engine.WorldX + Velocity1;
      end;
    80..111:
      begin
        Direction := 3;
        Engine.WorldX := Engine.WorldX + Velocity2;
        Engine.WorldY := Engine.WorldY + Velocity2;
      end;
    112..143:
      begin
        Direction := 4;
        Engine.WorldY := Engine.WorldY + Velocity1;
      end;
    144..175:
      begin
        Direction := 5;
        Engine.WorldX := Engine.WorldX - Velocity2;
        Engine.WorldY := Engine.WorldY + Velocity2;
      end;
    176..207:
      begin
        Direction := 6;
        Engine.WorldX := Engine.WorldX - Velocity1;
      end;
    208..239:
      begin
        Direction := 7;
        Engine.WorldX := Engine.WorldX - Velocity2;
        Engine.WorldY := Engine.WorldY - Velocity2;
      end;
  end;
  SetDirectionAnim;
end;

procedure THero.DoDraw;
begin
  inherited;
  Red := 65;
  Green := 65;
  Blue := 65;
  Finger.Collision(Hero);
end;

function FrameFunc: Boolean;
begin
  HGE.Input_GetMousePos(Mx,My);

  if HGE.Input_KeyDown(HGEK_LBUTTON) then
  begin
    Velocity1 := 2;
    Velocity2 := 1.5;
    Hero.DoAnimate := True;
    Hero.Shadow.DoAnimate := True;
  end;
  if HGE.Input_KeyUp(HGEK_LBUTTON) then
  begin
    Velocity1 := 0;
    Velocity2 := 0;
    Hero.DoAnimate := False;
    Hero.Shadow.DoAnimate := False;
  end;

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
  DrawTiles;
  DrawMonsters;
  DrawHero;
  Canvas.DrawEx(Images.Image['Light'],0,250,220,0,0,0.5,0.3,false,false,
               $FFFFFFFF,Blend_Light);
  Finger.Move(1);
  Canvas.Draw(Images.Image['panel1'],0,120, 555, Blend_Default);
  Canvas.Draw(Images.Image['panel3'],0, 0, 500, Blend_Default);
  Canvas.Draw(Images.Image['panel2'],0,690, 500, Blend_Default);
  Finger.DoDraw;
  Font.Print(100,100,IntToStr(HGE.Timer_GetFPS));
  Font.Print(300,500,'Mouse Down to Walk');
  HGE.Gfx_EndScene;
  Result := False;
end;

procedure Main;
begin
  HGE := HGECreate(HGE_VERSION);
  HGE.System_SetState(HGE_FRAMEFUNC,FrameFunc);
  HGE.System_SetState(HGE_RENDERFUNC,RenderFunc);
  HGE.System_SetState(HGE_USESOUND, False);
  HGE.System_SetState(HGE_WINDOWED,True);
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP,16);
  HGE.System_SetState(HGE_TEXTUREFILTER,False);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Font:=TSysFont.Create;
    Font.CreateFont('arial',12,[]);
    Images.LoadFromFile('Gfx\Dark Lord.png',54,79);
    Images.LoadFromFile('Gfx\Desert Wing.png',98,77);
    Images.LoadFromFile('Gfx\Enraged Fallen.png',54,64);
    Images.LoadFromFile('Gfx\Enraged Shaman.png',123,111);
    Images.LoadFromFile('Gfx\Night Clan.png',46,75);
    Images.LoadFromFile('Gfx\Mega Demon.png',171,153);
    Images.LoadFromFile('Gfx\Hell Buzzard.png',70,86);
    Images.LoadFromFile('Gfx\Player.png',83,108);
    Images.LoadFromFile('Gfx\Floor.png',160,80);
    Images.LoadFromFile('Gfx\Finger.png');
    Images.LoadFromFile('Gfx\Light.png');
    Images.LoadFromFile('Gfx\Panel1.png');
    Images.LoadFromFile('Gfx\Panel2.png');
    Images.LoadFromFile('Gfx\Panel3.png');
    CreateTiles(100, 100, -3000, -3000);
    CreateMonsters(30, 30);
    CreateHero;
    Finger := TFinger.Create(SpriteEngine);
    Finger.ImageName := 'finger';
    Finger.Width:=Finger.PatternWidth;
    Finger.Height:=Finger.PatternHeight;
    Finger.Collisioned := True;
    Finger.CollideRadius := 16;
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
