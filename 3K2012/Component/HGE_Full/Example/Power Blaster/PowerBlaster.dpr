program PowerBlaster;

{$R *.res}

uses
  Windows, Classes, SysUtils, HGEImages, HGECanvas, HGEDef, HGE, StrUtils,
  Math, HGEFont, HGESpriteEngine;

type
  TEnemyKind = (Ship, SquareShip, AnimShip, Mine);

  TMapRec = record
      X, Y, Z: Integer;
      ImageName: string[50];
  end;

  TBullet = class(TAnimatedSprite)
  private
    DestAngle: Single;
    FMoveSpeed: Integer;
    FCounter: Integer;
  public
    constructor Create(const AParent: TSprite); override;
    procedure DoMove(const MoveCount: Single); override;
    property MoveSpeed: Integer read FMoveSpeed write FMoveSpeed;
  end;

  TPlayerBullet = class(TAnimatedSprite)
  private
    FDestX, FDestY: Integer;
    FCounter: Integer;
    FMoveSpeed: Integer;
  public
    procedure DoMove(const MoveCount: Single); override;
    procedure DoCollision(const Sprite: TSprite); override;
    property DestX: Integer read FDestX write FDestX;
    property DestY: Integer read FDestY write FDestY;
    property MoveSpeed: Integer read FMoveSpeed write FMoveSpeed;
  end;

  TEnemy = class(TAnimatedSprite)
  private
    FMoveSpeed: Single;
    FTempMoveSpeed: Single;
    FRotateSpeed: Single;
    FDestX, FDestY: Integer;
    FDestAngle: Integer;
    FLookAt: Boolean;
    FKind: TEnemykind;
    FLife: Integer;
    FBullet: TBullet;
  public
    function InOffScreen: Boolean;
    procedure DoMove(const MoveCount: Single); override;
    property Kind: TEnemyKind read FKind write FKind;
    property MoveSpeed: Single read FMoveSpeed write FMoveSpeed;
    property TempMoveSpeed: Single  read FTempMoveSpeed write FTempMoveSpeed;
    property RotateSpeed: Single read FRotateSpeed write FRotateSpeed;
    property DestX: Integer read FDestX write FDestX;
    property DestY: Integer read FDestY write FDestY;
    property DestAngle: Integer read  FDestAngle write FDestAngle;
    property LookAt: Boolean read  FLookAt write  FLookAt;
    property Life: Integer read FLife write FLife;
    property Bullet: TBullet read  FBullet write  FBullet;
  end;

  TAsteroids = class(TAnimatedSprite)
  private
    FStep: Single;
    FMoveSpeed: Single;
    FRange: Single;
    FSeed: Integer;
    FPosX: Integer;
    FPosY: Integer;
    FLife: Integer;
  public
    procedure DoMove(const MoveCount: Single); override;
    property MoveSpeed: Single read FMoveSpeed write FMoveSpeed;
    property Step: Single read FStep write FStep;
    property Seed: Integer read FSeed write FSeed;
    property Range: Single read FRange write FRange;
    property PosX: Integer read FPosX write FPosX;
    property PosY: Integer read FPosY write FPosY;
    property Life: Integer read FLife write FLife;
  end;

  TFort = class(TAnimatedSprite)
  private
     FLife: Integer;
     FBullet: TBullet;
  public
    procedure DoMove(const MoveCount: Single); override;
    property Bullet: TBullet read  FBullet write  FBullet;
    property Life: Integer read FLife write FLife;
  end;

  TPlayerShip = class(TPlayerSprite)
  private
    FDoAccelerate: Boolean;
    FDoDeccelerate: Boolean;
    FLife: Single;
    FBullet: TPlayerBullet;
    FReady: Boolean;
    FReadyTime: Integer;
  public
    procedure DoMove(const MoveCount: Single); override;
    procedure DoCollision(const Sprite: TSprite); override;
    property DoAccelerate: Boolean read  FDoaccelerate write FDoAccelerate;
    property DoDeccelerate: Boolean read  FDoDeccelerate write  FDoDeccelerate;
    property Bullet: TPlayerBullet read FBullet  write FBullet;
    property Life: Single read FLife write FLife;
  end;

  TTail = class(TPlayerSprite)
  private
    FCounter: Integer;
  public
    procedure DoMove(const MoveCount: Single); override;
    property Counter: Integer read FCounter write FCounter;
  end;

  TExplosion = class(TPlayerSprite)
  public
    procedure DoMove(const MoveCount: Single); override;
  end;

  TSpark = class(TPlayerSprite)
  public
    procedure DoMove(const MoveCount: Single); override;
  end;

  TBonus = class(TAnimatedSprite)
  private
    FPX, FPY: Single;
    FStep: Single;
    FMoveSpeed: Single;
  public
    procedure DoMove(const MoveCount: Single); override;
    property PX: Single read FPX write FPX;
    property PY: Single read FPY write FPY;
    property Step:Single read FStep write FStep;
    property MoveSpeed:Single read FMoveSpeed write FMoveSpeed;
  end;


var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Fnt: IHGEFont;
  SpriteEngine: TSpriteEngine;
  CursorX, CursorY: Single;
  SpaceLayer,MistLayer1,MistLayer2: TSpriteEngine;
  PlayerShip: TPlayerShip;
  FileSize: Integer;
  MapData: array of TMapRec;
  UserRefreshRate: Integer;
  Counter, Score: Integer;

procedure LoadMap(FileName: string);
var
   Fs: TFileStream;
begin
     Fs := TFileStream.Create(ExtractFilePath(ParamStr(0)) + FileName, fmOpenRead);
     Fs.ReadBuffer(FileSize, SizeOf(FileSize));
     SetLength(MapData, FileSize);
     Fs.ReadBuffer(MapData[0], SizeOf(TMapRec) * FileSize);
     Fs.Destroy;
end;

procedure CreateMap(OffsetX, OffsetY: Integer);
var
    I: Integer;
begin
     for I := 0 to FileSize - 1  do
     begin
          if LeftStr(MapData[I].ImageName, 4) = 'Tile' then
          begin
               with  TSprite.Create(SpriteEngine) do
               begin
                    ImageName := MapData[I].ImageName;
                    Width := PatternWidth;
                    Height:= PatternHeight;
                    X := MapData[I].X + OffsetX;
                    Y := MapData[I].Y + OffsetY;
                    Z := MapData[I].Z;
                    Moved := False;
               end;
          end;
          //
          if LeftStr(MapData[I].ImageName, 4) = 'Fort' then
          begin
               with  TFort.Create(SpriteEngine) do
               begin
                    ImageName := MapData[I].ImageName;
                    DrawMode := 1;
                    Docenter := True;
                    Width := PatternWidth;
                    Height:= PatternHeight;
                    X := MapData[I].X + OffsetX - 2500 + 22;
                    Y := MapData[I].Y + OffsetY - 2500 + 40;
                    Z := MapData[I].Z;
                    Collisioned := True;
                    CollideRadius := 24;
                    Life := 5;
               end;
          end;
     end;
end;

procedure CreateSpark(PosX, PosY: Single);
var
   I, Pattern: Integer;
const
  RandNumber: array[0..1] of Integer = (5,9);
begin
     Pattern := RandomFrom(RandNumber);
     for I := 0 to 128 do
     begin
          with TSpark.Create(SpriteEngine) do
          begin
               ImageName := 'Particles';
               Width := PatternWidth;
               Height := PatternHeight;
               BlendMode :=  Blend_Add2X;
               X := PosX + -Random(30);
               Y := PosY + Random(30);
               Z := 12000;
               PatternIndex := Pattern;
               ScaleX := 1.2;
               ScaleY := 1.2;
               Red := Random(250);
               Green := Random(250);
               Blue := Random(250);
               case UserRefreshRate of
                    60:
                    begin
                         Acceleration := 0.02*1.2;
                         MinSpeed := 0.8*1.2;
                         MaxSpeed := -(0.4 + Random(2))*1.2;
                    end;
                    75:
                    begin
                         Acceleration := 0.02*1.1;
                         MinSpeed := 0.8*1.1;
                         MaxSpeed := -(0.4 + Random(2))*1.1
                    end;
                    85:
                    begin
                         Acceleration := 0.02*1.2;
                         MinSpeed := 0.8*1.2;
                         MaxSpeed := -(0.4 + Random(2))*1.2
                    end;

               end;
               Direction := I * 2;
          end;
    end;
end;

procedure CreateBonus(BonusName: string; PosX, PosY: Single);
begin
     if (Random(3) = 1) or (Random(3) = 2) then
     begin
          with TBonus.Create(SpriteEngine) do
          begin
               ImageName := BonusName;
               Width := PatternWidth;
               Height := PatternHeight;
               MoveSpeed := 0.251;
               PX := PosX - 50;
               PY := PosY - 100;
               Z := 12000;
               ScaleX := 1.5;
               ScaleY := 1.5;
               DoCenter := True;
               Collisioned := True;
               CollideRadius := 24;
               SetAnim(ImageName, 0, PatternCount, 0.25, True, False, True);
          end;
     end;
end;

procedure LoadImages;
var
  FileSearchRec: TSearchRec;
begin
  if FindFirst(ExtractFilePath(ParamStr(0)) + 'Gfx\'+ '*.png', faAnyfile, FileSearchRec) = 0 then
  repeat
    Images.LoadFromFile('Gfx\'+FileSearchRec.Name);
  until  FindNext(FileSearchRec) <> 0;
  FindClose(FileSearchRec);
  Images.LoadFromFile('Space.jpg');
  Images.LoadFromFile('AnimShip0.png',48,62);
  Images.LoadFromFile('AnimShip1.png',64,64);
  Images.LoadFromFile('Bonus0.png',32, 32);
  Images.LoadFromFile('Bonus1.png',32, 32);
  Images.LoadFromFile('Bonus2.png',32,32);
  Images.LoadFromFile('Explode.png',64,64);
  Images.LoadFromFile('Explosion2.png',64, 64);
  Images.LoadFromFile('Explosion3.png',64, 64);
  Images.LoadFromFile('Explosions.png',64, 64);
  Images.LoadFromFile('Money.png',32,32);
  Images.LoadFromFile('Roids0.png',64,64);
  Images.LoadFromFile('Roids1.png',96,96);
  Images.LoadFromFile('Roids2.png',128, 128);
  Images.LoadFromFile('Shield.png',111, 105);
  Images.LoadFromFile('Particles.png',32, 32);
end;

procedure CreateGame;
var
  MonitorFrequency, I: Integer;
  DC: THandle;
const
  RandNumber: array[0..1] of Double=(-0.15, 0.15);  
begin
     Randomize;
     DC := GetDC(HGE.System_GetState(HGE_HWND) );
     MonitorFrequency := GetDeviceCaps(DC, VREFRESH);
     case MonitorFrequency of
          60..70: UserRefreshRate := 60;
          71..75: UserRefreshRate := 75;
          76..85: UserRefreshRate := 85;
          86..100: UserRefreshRate  := 100;
          101..120: UserRefreshRate := 120;
          else
          UserRefreshRate := 85;
     end;
     SpriteEngine := TSpriteEngine.Create(nil);
     Spriteengine.Images := Images;
     Spriteengine.Canvas := Canvas;
     SpriteEngine.VisibleWidth:=850;
     SpriteEngine.VisibleHeight:=650;
     //
     SpaceLayer := TSpriteEngine.Create(nil);
     SpaceLayer.Images:= Images;
     SpaceLayer.Canvas := Canvas;
     //
     MistLayer1 := TSpriteEngine.Create(nil);
     MistLayer1.Images:= Images;
     MistLayer1.Canvas := Canvas;
     //
     MistLayer2 := TSpriteEngine.Create(nil);
     MistLayer2.Images:= Images;
     MistLayer2.Canvas := Canvas;

     //create enemys
     for I := 0 to 400 do
     begin
          with TEnemy.Create(SpriteEngine) do
          begin
               Kind := TEnemyKind(Random(4));
               DrawMode := 1;
               X := Random(8000) - 2500;
               Y := Random(8000) - 2500;
               Z := 10000;
               Collisioned := True;
               case UserRefreshRate of
                    60:
                    begin
                         MoveSpeed := (1 + (Random(4) * 0.5))*1.5;
                         RotateSpeed := 0.5 + (Random(4) * 0.4)*1.5;
                    end;
                    75:
                    begin
                         MoveSpeed := (1 + (Random(4) * 0.5))*1.25;
                         RotateSpeed := 0.5 + (Random(4) * 0.4) *1.25;
                    end;
                    85:
                    begin
                         MoveSpeed := 1 + (Random(4) * 0.5);
                         RotateSpeed := 0.5 + (Random(4) * 0.4);
                    end;
               end;

               Life := 4;
               case Kind of
                    Ship:
                    begin
                         ImageName := 'Ship'+ IntToStr(Random(2));
                         CollideRadius := 40;
                         ScaleX := 0.7;
                         ScaleY := 0.8;
                    end;
                    SquareShip:
                    begin
                         ImageName := 'SquareShip' + IntToStr(Random(2));
                         CollideRadius := 30;
                         LookAt := True;
                    end;
                    AnimShip:
                    begin
                         ImageName := 'AnimShip' + IntToStr(Random(2));
                         CollideRadius := 25;
                         //ScaleX := 1.1;
                         //ScaleY := 1.1;
                         if ImageName = 'AnimShip1' then
                            SetAnim(ImageName, 0,8, 0.2, True, False, True);
                         if ImageName = 'AnimShip0' then
                            SetAnim(ImageName, 0, 4, 0.08, True, False, True);
                    end;
                    Mine:
                    begin
                         ImageName := 'Mine0';
                         CollideRadius := 16;
                         RotateSpeed := 0.04;
                    end;
               end;
               TempMoveSpeed := MoveSpeed;
               Width := PatternWidth;
               Height:= PatternHeight;
          end;
     end;

     //create asteroids
     for I := 0 to 500 do
     with TAsteroids.Create(SpriteEngine) do
     begin
          ImageName := 'Roids' + IntToStr(Random(3));
          AnimPos := Random(25);
          PosX := Random(8000)-2500;
          PosY := Random(8000)-2500;
          Z := 4800;
          Width := PatternWidth;
          Height:= PatternHeight;
          DrawMode := 1;
          DoCenter := True;
          SetAnim(ImageName, 0, PatternCount, 0.15, True, False, True);
          if ImageName = 'Roids0' then AnimSpeed := 0.2;
          if ImageName = 'Roids1' then AnimSpeed := 0.16;
          if ImageName = 'Roids2' then AnimSpeed := 0.25;
          case UserRefreshRate of
               60: MoveSpeed := RandomFrom(RandNumber)*1.5;
               75: MoveSpeed := RandomFrom(RandNumber)*1.25;
               85: MoveSpeed := RandomFrom(RandNumber);
          end;

          Range := 150 +  Random(200);
          Step := (Random(1512));
          Seed :=  50 + Random(100);
          Life := 6;
          ScaleX := 1;
          ScaleY := 1;
          Collisioned := True;
          if ImageName='Roids0' then CollideRadius := 32;
          if ImageName='Roids1' then CollideRadius := 48;
          if ImageName='Roids2' then CollideRadius := 50;
      end;

     //create player's ship
     PlayerShip:= TPlayerShip.Create(SpriteEngine);
     with PlayerShip do
     begin
          ImageName :='PlayerShip';
          Width := PatternWidth;
          Height:= PatternHeight;
          ScaleX := 1.2;
          ScaleY := 1.2;
          DoCenter := True;
          DrawMode := 1;

          Decceleration := 0.02;
          MinSpeed := 0;
          case  UserRefreshRate of
                60:
                begin
                      Maxspeed := 4.7;
                      Acceleration := 0.02*1.5;
                end;
                75:
                begin
                     Maxspeed := 3.5;
                     Acceleration := 0.02*1.2;
                end;
                85:
                begin
                     Maxspeed := 3;
                     Acceleration := 0.02;
                end;
                100: Maxspeed := 2.5;
                120: Maxspeed := 1.5;
          end;
          Z := 5000;
          Collisioned := True;
          CollideRadius := 25;
     end;

     LoadMap('Level1.map');
     CreateMap(-2500, -2500);

     //create planet
     for I := 0 to 100 do
     begin
          with TSprite.Create(SpaceLayer) do
          begin
               ImageName := 'Planet'+ InttoStr(Random(4));
               Width := PatternWidth;
               Height := PatternHeight;
               X := (Random(25) * 300) - 2500;
               Y := (Random(25) * 300) - 2500;
               Moved := False;
          end;
     end;
     //create a huge endless space
     with TTileMapSprite.Create(SpaceLayer) do
     begin
          ImageName := 'Space';
          Width := PatternWidth;
          Height := PatternHeight;
          SetMapSize(1, 1);
          DoTile := True;
          Moved := False;
     end;
     //create mist layer1
     with TTileMapSprite.Create(MistLayer1) do
     begin
          ImageName := 'Mist';
          Width := PatternWidth;
          Height := PatternHeight;
          BlendMode := Blend_Add2X;
          SetMapSize(1, 1);
          DoTile := True;
          Moved := False;
     end;
     //create mist layer2
     with TTileMapSprite.Create(MistLayer2) do
     begin
          ImageName := 'Mist';
          X := 200;
          Y := 200;
          Width := PatternWidth;
          Height := PatternHeight;
          BlendMode := Blend_Add2X;
          SetMapSize(1, 1);
          DoTile := True;
          Moved := False;
     end;

end;

procedure TEnemy.DoMove(const MoveCount: Single);
begin
     if (Life >= 1) and (ImageName <> 'Explosion2') then
         BlendMode := Blend_Default;
     if (InOffScreen) and (ImageName <> 'Explosion2') then
         MoveSpeed := TempMoveSpeed;
     if (Life <=0) or (not InOffScreen) then
         MoveSpeed := 0;
     if Trunc(AnimPos) >= 15 then Dead;
     if (Trunc(AnimPos) >= 1) and (ImageName = 'Explosion2') then
         Collisioned := False;

     case Kind of
     Ship:
     begin
          CollidePos := Point2(X + 64, Y + 64);
          case Random(100) of
               40..43:
               begin
                    DestAngle := Random(255);
               end;
               51..52:
               begin
                    DestAngle:=Trunc(
                    Angle256(Trunc(PlayerShip.X) - Trunc(Self.X),
                    Trunc(PlayerShip.Y) - Trunc(Self.Y))
                     );
               end;
          end;
          RotateToAngle(DestAngle, RotateSpeed, MoveSpeed);
     end;

     SquareShip:
     begin
          CollidePos := Point2(X + 30, Y + 30);
          case Random(100) of
               40..45:
               begin
                    DestX := Random(8000);
                    DestY := Random(6000)
               end;
               51..52:
               begin
                    DestX := Trunc(PlayerShip.X);
                    DestY := Trunc(PlayerShip.Y);

               end;
          end;
          CircleToPos(DestX, DestY, Trunc(PlayerShip.X), Trunc(PlayerShip.Y), RotateSpeed, MoveSpeed, LookAt);
     end;

     AnimShip:
     begin
          CollidePos := Point2(X + 20, Y + 20);
          case Random(100) of
               40..45:
               begin
                    DestX := Random(8000);
                    DestY := Random(6000)
               end;
               51..54:
               begin
                    DestX := Trunc(PlayerShip.X);
                    DestY := Trunc(PlayerShip.Y);
               end;
          end;
          RotateToPos(DestX, DestY, RotateSpeed, MoveSpeed);
     end;

     Mine:
     begin
          CollidePos := Point2(X + 32, Y + 32);
          case Random(300) of
               150:
               begin
                    DestX := Trunc(PlayerShip.X);
                    DestY := Trunc(PlayerShip.Y);
               end;
               200..202:
               begin
                    DestX := Random(8000);
                    DestY := Random(8000);
               end;
          end;
          Angle := Angle + RotateSpeed;
          TowardToPos(DestX, DestY, MoveSpeed, False);
     end;

     end;
     //enemy shoot bullet
     if (Kind = Ship) or (Kind = SquareShip) then
     begin
          if InOffScreen then
          begin
               if Random(100) = 50 then
               begin
                    Bullet := TBullet.Create(SpriteEngine);
                    Bullet.ImageName := 'BulletR';
                    case UserRefreshRate of
                         60: Bullet.MoveSpeed := 9;
                         75: Bullet.MoveSpeed := 7;
                         85: Bullet.MoveSpeed := 5;
                    end;

                    Bullet.X := Self.X + 1;
                    Bullet.Y := Self.Y;
                    Bullet.DestAngle := Angle * 40;
               end;
          end;
     end;
     inherited;
end;

function TEnemy.InOffScreen: Boolean;
begin
     if (X > Engine.WorldX -50)and
     (Y > Engine.WorldY - 50)   and
     (X < Engine.WorldX + 850) and
     (Y < Engine.WorldY + 650) then
         Result := True
     else
         Result := False;
end;

constructor TBullet.Create(const AParent: TSprite);
begin
     inherited;
     BlendMode := Blend_Add;
     Z := 4000;
     FCounter := 0;
     DrawMode := 1;
     Collisioned:= True;
     if ImageName = 'Bulletr' then CollideRadius := 15;
     if ImageName = 'BulletS' then CollideRadius := 12;
end;

procedure TBullet.DoMove;
begin
     inherited;
     CollidePos := Point2(X + 20, Y + 20);
     TowardToAngle(Trunc(DestAngle), MoveSpeed, True);
     Inc(FCounter);
     if (Trunc(AnimPos) >= 15) and  (ImageName = 'Explosion3') then Dead;
     if FCounter > 150 then Dead;
end;

procedure TPlayerBullet.DoMove;
begin
     inherited;
     TowardToAngle(Trunc(Angle * 40), MoveSpeed, True);
     CollidePos := Point2(X + 24, Y + 38);
     Inc(FCounter);
     if FCounter > 80 then
        Dead;
     if Trunc(AnimPos) >= 11 then
        Dead;
     Collision;
end;

procedure TPlayerBullet.DoCollision(const Sprite: TSprite);
var
   I: Integer;
begin
     if Sprite is TAsteroids then
     begin
          //MainForm.Music.Songs.Find('Hit').Play;
          Collisioned := False;
          MoveSpeed := 0;
          SetAnim('Explosions', 0, 12, 0.3, False, False, True);
          if Trunc(AnimPos) < 1 then
             TAsteroids(Sprite).BlendMode := Blend_Bright;
          TAsteroids(Sprite).Life := TAsteroids(Sprite).Life - 1;
          if (TAsteroids(Sprite).Life <= 0)  then
          begin
                //MainForm.Music.Songs.Find('Explode').Play;
                TAsteroids(Sprite).MoveSpeed := 0;
                for I := 0 to 128 do
                with TExplosion.Create(SpriteEngine) do
                begin
                     ImageName := 'Particles';
                     Width := PatternWidth;
                     Height := PatternHeight;
                     BlendMode := Blend_Add2X;
                     X := TAsteroids(Sprite).X+-Random(60);
                     Y := TAsteroids(Sprite).Y-Random(60);
                     Z := 4850;
                     PatternIndex := 7;
                     ScaleX := 3;
                     ScaleY := 3;
                     Red := 255;
                     Green := 50;
                     Blue := 50;
                     case UserRefreshRate of
                          60:
                          begin
                               Acceleration := 0.0252*1.2;
                               MinSpeed := 1*1.2;
                               MaxSpeed := -(0.21 + Random(2))*1.2;
                          end;
                          75:
                          begin
                               Acceleration := 0.0252*1.1;
                               MinSpeed := 1*1.1;
                               MaxSpeed := -(0.21 + Random(2))*1.1;
                          end;
                          85:
                          begin
                               Acceleration := 0.0252*1.2;
                               MinSpeed := 1*1.2;
                               MaxSpeed := -(0.21 + Random(2))*1.2;
                          end;
                     end;
                     Direction:= I * 2;
                end;
                CreateBonus('Money',TAsteroids(Sprite).X, TAsteroids(Sprite).Y);
                TAsteroids(Sprite).Dead;
          end;
     end;
     //
     if Sprite is TEnemy then
     begin
          //MainForm.Music.Songs.Find('Hit').Play;
          Collisioned := False;
          MoveSpeed := 0;
          SetAnim('Explosion3', 0, 12, 0.3, False, False, True);
          if Trunc(AnimPos) < 1 then
             TEnemy(Sprite).BlendMode := Blend_Bright;
          TEnemy(Sprite).Life := TEnemy(Sprite).Life - 1;
          if TEnemy(Sprite).Life <= 0 then
          begin
               TEnemy(Sprite).MoveSpeed := 0;
               TEnemy(Sprite).RotateSpeed := 0;
               TEnemy(Sprite).DestAngle := 0;
               TEnemy(Sprite).LookAt := False;
               TEnemy(Sprite).BlendMode := Blend_Add2X;
               TEnemy(Sprite).ScaleX := 3;
               TEnemy(Sprite).ScaleY := 3;
               TEnemy(Sprite).SetAnim('Explosion2', 0, 16, 0.15, False, False, True);
               CreateBonus('Bonus' + IntToStr(Random(3)), X, Y);
          end;
     end;
     //
     if Sprite is TFort then
     begin
          //MainForm.Music.Songs.Find('Hit').Play;
          Collisioned := False;
          MoveSpeed := 0;
          SetAnim('Explosion3', 0, 12, 0.3, False, False, True);
          if Trunc(AnimPos) < 3 then
             TFort(Sprite).SetColor(255, 0, 0);
          TFort(Sprite).Life := TFort(Sprite).Life - 1;
          if TFort(Sprite).Life <= 0 then
          begin
               TFort(Sprite).BlendMode := Blend_Add;
               TFort(Sprite).ScaleX := 3;
               TFort(Sprite).ScaleY := 3;
               TFort(Sprite).SetAnim('Explosion2', 0, 16, 0.15, False, False, True);
          end;
     end;
end;

procedure  TAsteroids.DoMove(const MoveCount: Single);
begin
     inherited;
     X := PosX + Cos(Step / (30 )) * Range - (Sin(Step / (20 )) * Range);
     Y := PosY + Sin(Step / (30 + Seed )) * Range + (Cos(Step / (20 )) * Range);
     Step := Step + MoveSpeed;
     if ImageName = 'Roids2' then  Angle := Angle + 0.02;
     if ImageName='Roids0' then CollidePos := Point2(X + 32, Y + 32);
     if ImageName='Roids1' then CollidePos := Point2(X + 30, Y + 30);
     if ImageName='Roids2' then CollidePos := Point2(X + 34, Y + 34);
     BlendMode := Blend_Default;
end;

procedure TFort.DoMove(const MoveCount: Single);
begin
     inherited;
     SetColor(255, 255, 255);
     if ImageName = 'Fort' then
     LookAt(Trunc(PlayerShip.X), Trunc(PlayerShip.Y));
     CollidePos := Point2(X + 22, Y + 36);
     if Trunc(AnimPos) >= 15 then Dead;
     if (Trunc(AnimPos) >= 1) and (ImageName = 'Explosion2') then
       Collisioned := False;

     if Random(150) = 50 then
     begin
          if (X > Engine.WorldX + 0)and
          (Y > Engine.WorldY + 0)   and
          (X < Engine.WorldX + 800) and
          (Y < Engine.WorldY + 600) then
          begin
               Bullet := TBullet.Create(SpriteEngine);
               Bullet.ImageName := 'BulletS';
               Bullet.Width := 40;
               Bullet.Height := 40;
               Bullet.BlendMode := Blend_Add;
               Bullet.MoveSpeed := 4;
               Bullet.Z := 4000;
               Bullet.FCounter := 0;
               Bullet.X := Self.X + 5;
               Bullet.Y := Self.Y;
               Bullet.DrawMode := 1;
               Bullet.DestAngle := Angle * 40;
          end;
     end;
end;

procedure  TPlayerShip.DoMove(const MoveCount: Single);
begin
      inherited;
      SetColor(255, 255, 255);
      CollidePos := Point2(X + 20, Y + 20);
      Collision;
      if DoAccelerate then Accelerate;
      if DoDeccelerate then Deccelerate;
      if ImageName = 'PlayerShip' then
      begin
           AnimPos:=0;
           UpdatePos(1);
           //LookAt(CursorX, CursorY);
           Angle := Angle256(Trunc(CursorX) - 400, Trunc(CursorY) - 300) * 0.025 ;
           Direction := Trunc(Angle256(Trunc(CursorX) - 400, Trunc(CursorY) - 300));
      end;
      if (Trunc(AnimPos)>=32) and (ImageName = 'Explode') then
      begin
           ImageName :='PlayerShip';
           AnimPos:=0;
           BlendMode := Blend_Default;
           ScaleX := 1.2;
           ScaleY := 1.2;
      end;
      if FReady then
         Inc(FReadyTime);
      if FReadyTime = 350 then
      begin
           FReady := False;
           Collisioned := True;
      end;
      Engine.WorldX := X - 400;
      Engine.WorldY := Y - 300;
end;

procedure TPlayerShip.DoCollision(const Sprite: TSprite);
begin
     if Sprite is TBonus then    
     begin
          //MainForm.Music.Songs.Find('GetBonus').Play;
          if TBonus(Sprite).ImageName =  'Bonus0' then
             Inc(Score, 100);
          if TBonus(Sprite).ImageName =  'Bonus1' then
             Inc(Score, 200);
          if TBonus(Sprite).ImageName =  'Bonus2' then
             Inc(Score, 300);
          if TBonus(Sprite).ImageName =  'Money' then
             Inc(Score, 500);
          CreateSpark(TBonus(Sprite).X, TBonus(Sprite).Y);
          TBonus(Sprite).Dead;
     end;
     if Sprite is TBullet then
     begin
          //MainForm.Music.Songs.Find('Hit').Play;
          PlayerShip.Life :=  PlayerShip.Life - 0.5;
          Self.SetColor(255, 0, 0);
          TBullet(Sprite).Collisioned := False;
          TBullet(Sprite).MoveSpeed := 0;
          TBullet(Sprite).SetAnim('Explosion3', 0, 12, 0.3, False, False, True);
          TBullet(Sprite).Z := 10000;
     end;

     if (Sprite is TAsteroids) or (Sprite is TEnemy) then
     begin
          //MainForm.Music.Songs.Find('Hit').Play;
          FReady := True;
          FReadyTime := 0;
          PlayerShip.Life :=  PlayerShip.Life - 0.25;
          AnimPos := 0;
          SetAnim('Explode', 0, 40, 0.15, False, False, True);
          Collisioned := False;
          BlendMode := Blend_Add;
          ScaleX := 1.5;
          ScaleY := 1.5;
     end;
end;

procedure TTail.DoMove(const MoveCount: Single);
begin
     inherited;
     Alpha := Alpha - 4;
     if PlayerShip.Speed < 1.1 then
     begin
          ScaleX := ScaleX + 0.01;
          ScaleY := ScaleY + 0.01;
     end
     else
     begin
          ScaleX := ScaleX + 0.025;
          ScaleY := ScaleY + 0.025;
     end;
     Angle := Angle + 0.125;
     UpdatePos(1);
     Accelerate;
     Inc(FCounter);
     if FCounter > 25 then Dead;
end;

procedure TExplosion.DoMove(const MoveCount: Single);
begin
     inherited;
     Accelerate;
     UpdatePos(1);
     Alpha := Alpha - 1;
     if Alpha < 1 then Dead;
end;

procedure TSpark.DoMove(const MoveCount: Single);
begin
     inherited;
     Accelerate;
     UpdatePos(1);
     Alpha := Alpha - 1;
     if Alpha < 1 then Dead;
end;

procedure TBonus.DoMove(const MoveCount: Single);
begin
     inherited;
     CollidePos := Point2(X + 24, Y + 24);
     X := PX + Cos(Step / (30)) * 60 - (Sin(Step / (20)) * 150);
     Y := PY + Sin(Step / (90)) * 130 + (Cos(Step / (20)) * 110);
     Step := Step + MoveSpeed;
end;

function FrameFunc: Boolean;
begin
  HGE.Input_GetMousePos(CursorX, CursorY);
  Inc(Counter);

  if (Counter mod 5) =0 then
  if PlayerShip.ImageName = 'PlayerShip' then
     begin
          with  TTail.Create(SpriteEngine) do
          begin
               ImageName := 'Tail';
               Width := PatternWidth;
               Height := PatternHeight;
               BlendMode :=  Blend_Add;
               DrawMode := 1;
               ScaleX := 0.1;
               ScaleY := 0.1;
               X := 398 + Engine.WorldX;
               Y := 298 + Engine.WorldY;
               Z := 4000;
               Acceleration := 2.51;
               MinSpeed := 1;
               if PlayerShip.Speed < 1 then
                  MaxSpeed := 2
               else
                  MaxSpeed := 0.5;
               Direction := -128 + PlayerShip.Direction;
          end;
     end;
  //
    if HGE.Input_KeyDown(HGEK_RBUTTON) then
    begin
   //       CursorX := X;
     //     CursorY := Y;
          PlayerShip.DoAccelerate := True;
          PlayerShip.DoDeccelerate := False;
     end;
     if HGE.Input_KeyDown(HGEK_LBUTTON) and (PlayerShip.ImageName = 'PlayerShip') then
     begin
          //Music.Songs.Find('Shoot').Play;
          PlayerShip.Bullet := TPlayerBullet.Create(SpriteEngine);
          with PlayerShip.Bullet do
          begin
               ImageName := 'Bb';
               Width := PatternWidth;
               Height := PatternHeight;
               ScaleX := 1;
               ScaleY := 1;
               DrawMode := 1;
               BlendMode := Blend_Add;
               DoCenter := True;
               case UserRefreshRate of
                    60: MoveSpeed := 12;
                    75: MoveSpeed := 10;
                    85: MoveSpeed := 8;
               end;

               Angle := PlayerShip.Angle + 0.05;
               X := PlayerShip.X;
               Y := PlayerShip.Y;
               Z := 11000;
               Collisioned := True;
               CollideRadius := 10;
         end;
     end;
     //
   if HGE.Input_KeyUP(HGEK_RBUTTON) then
   begin
          PlayerShip.DoAccelerate := False;
          PlayerShip.DoDeccelerate := True;
   end;
  case HGE.Input_GetKey of
    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      FreeAndNil(SpriteEngine);
      FreeAndNil(MistLayer1);
      FreeAndNil(MistLayer2);
      FreeAndNil(SpaceLayer);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function RenderFunc: Boolean;
var
   Angle: Single;
begin
  HGE.Gfx_BeginScene;
  //HGE.Gfx_Clear(0);
  SpaceLayer.Draw;
  MistLayer1.Draw;
  MistLayer2.Draw;
  SpriteEngine.Draw;
  SpriteEngine.Move(1);
  SpriteEngine.Dead;
  Angle := Angle256(Trunc(CursorX) - 400 , Trunc(CursorY) - 300 ) * 0.025 ;
  Canvas.DrawRotate(Images.Image['Cursor'], 0, Trunc(CursorX) + 5, Trunc(CursorY), 10, 15, Angle, $FFFFFFFF, Blend_Add);
  Canvas.DrawEx(Images.Image['Shield'], -Trunc(PlayerShip.Life), 10, 480, 1,
    False, $FFFFFFFF, Blend_Default);
  SpaceLayer.WorldX := SpriteEngine.WorldX * 0.71;
  SpaceLayer.WorldY := SpriteEngine.WorldY * 0.71;
  MistLayer1.WorldX := SpriteEngine.WorldX * 1.1;
  MistLayer1.WorldY := SpriteEngine.WorldY * 1.1;
  MistLayer2.WorldX := SpriteEngine.WorldX * 1.3;
  MistLayer2.WorldY := SpriteEngine.WorldY * 1.3;
  Fnt.PrintF(320,20, HGETEXT_LEFT, '%d',[Score]);
 // Fnt.PrintF(320,520, HGETEXT_LEFT, '%d',[hge.Timer_GetFPS]);
  if PlayerShip.Life < -16 then
  begin
    Fnt.PrintF(320,320, HGETEXT_LEFT, 'GAME OVER',[]);
    SpriteEngine.Moved := False;
    //Music.Songs.Find('Music1').Stop;
  end;

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
  HGE.System_SetState(HGE_TEXTUREFILTER,True);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGECanvas.Create;
  Images := THGEImages.Create;

  if (HGE.System_Initiate) then
  begin
    Fnt := THGEFont.Create('Font1.fnt');
    LoadImages;
    CreateGame;
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
