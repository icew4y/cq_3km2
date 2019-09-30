program DouDou;

{$R *.res}

uses
  Windows, SysUtils, Classes, HGEImages, HGECanvas, HGEDef, HGE, HGESpriteEngine;

type
  TActorState = (StandLeft, StandRight, WalkLeft, WalkRight, Die);

  TTileAttribute = (taNormal, taPlatform, taBlock, taTreasure, taSlope);
  TMapRec = record
     X, Y: Integer;
     ImageName: string[10];
  end;

  TTile = class(TAnimatedSprite)
  private
    FCollideRight: Integer;
    FCollideBottom: Integer;
  public
    ID: Integer;
    procedure DoMove(const MoveCount: Single); override;
  end;

  TActor = class(TJumperSprite)
  private
    FState: TActorState;
    FMoveSpeed: Single;
    FLeft, FTop, FRight, FBottom: Integer;
  public
    procedure DoMove(const MoveCount: Single); override;
    procedure DoCollision(const Sprite: TSprite); override;
    constructor Create(const AParent: TSprite); override;
    property MoveSpeed: Single read FMoveSpeed write FMoveSpeed;
    property State: TActorState read FState write FState;
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property Right: Integer read FRight write FRight;
    property Bottom: Integer read FBottom write FBottom;
   end;

  TEnemy = class(TjumperSprite)
  private
    FState: TActorState;
    FCollideRight: Integer;
    FCollideBottom: Integer;
  public
    procedure DoMove(const MoveCount: Single); override;
    procedure DoCollision(const Sprite: TSprite); override;
    property State: TActorState read FState write FState;
  end;

  TSpray = class(TPlayerSprite)
  public
    procedure DoMove(const MoveCount: Single); override;
  end;

  TGreenApple = class(TJumperSprite)
  public
    procedure DoMove(const MoveCount: Single); override;
    procedure DoCollision(const Sprite: TSprite); override;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Font: TSysFont;
  SpriteEngine: TSpriteEngine;
  Fs: TFileStream;
  FileSize: Integer;
  MapData: array of TMapRec;
  Layer1Pos: Single;
  Layer2Pos: Single;
  LeftEdge, RightEdge: Integer;
  FruitCount: Integer;
  Actor: TActor;
  UserRefreshRate: Integer;

procedure LoadImages;
var
  FileSearchRec: TSearchRec;
begin
  if FindFirst(ExtractFilePath(ParamStr(0)) + 'Gfx\'+ '*.png', faAnyfile, FileSearchRec) = 0 then
  repeat
    Images.LoadFromFile('Gfx\'+FileSearchRec.Name);
  until  FindNext(FileSearchRec) <> 0;
  FindClose(FileSearchRec);
  Images.LoadFromFile('Idle.png',110, 118);
  Images.LoadFromFile('Walk.png',110, 118);
  Images.LoadFromFile('Jump.png',110, 118);
  Images.LoadFromFile('Dead.png',110, 118);
  Images.LoadFromFile('Enemy1.png',50, 40);
  Images.LoadFromFile('Enemy2.png',40, 40);
  Images.LoadFromFile('Enemy3.png',48, 35);
  Images.LoadFromFile('Spring1.png',48, 48);
end;

procedure LoadMapData(FileName: string);
begin
     Fs := TFileStream.Create(ExtractFilePath(ParamStr(0)) + FileName, fmOpenRead);
     Fs.ReadBuffer(FileSize, SizeOf(FileSize));
     SetLength(MapData, FileSize);
     Fs.ReadBuffer(MapData[0], SizeOf(TMapRec) * FileSize);
     Fs.Destroy;
end;

procedure CreateMap;
var
   I:Integer;
begin
     Actor := TActor.Create(SpriteEngine);
     Actor.Z:=15;
     Actor.TruncMove := True;
     for I := FileSize - 1 downto 0 do
     begin
          if (MapData[i].ImageName <> 'Enemy1') and  (MapData[i].ImageName <> 'Enemy2') and (MapData[i].ImageName <> 'Enemy3') then
          begin
               with  TTile.Create(SpriteEngine) do
               begin
                    ImageName := MapData[i].ImageName;
                    X := MapData[i].X - 540;
                    Y := MapData[i].Y - 150;
                    Z:=10;
                    TruncMove := True;
                   // Moved := False;
                    Width := PatternWidth;
                    Height := PatternHeight;
                    CollideMode := cmRect;
                    Collisioned := True;
                    FCollideRight := PatternWidth;
                    FCollideBottom:= PatternHeight;
               end;
          end
          else
         //create Enemy
          begin
               with TEnemy.Create(SpriteEngine) do
               begin
                    ImageName := MapData[i].ImageName;
                    X := MapData[i].X - 540;
                    Y := MapData[i].Y - 150;
                    Z := 15;
                    TruncMove := True;
                    Width := PatternWidth;
                    Height := PatternHeight;
                    Collisioned := True;
                    CollideMode := cmRect;
                    FCollideRight :=PatternWidth;
                    FCollideBottom:=PatternHeight;
                    State := Walkleft;
                    JumpState := jsfalling;
                    AnimCount := PatternCount;
              end;
         end;
    end;
end;


procedure SprayBox(PosX, PosY: Single);
var
   I: Integer;
begin
     for I := 0 to 6 do
     begin
          with TParticleSprite.Create(SpriteEngine) do
          begin
               ImageName := 'Star';
               X := PosX + Random(20);
               Y := PosY + Random(20);
               Z := 20;
               LifeTime := 150;
               Decay := 1;
               ScaleX := 1.2;
               ScaleY := 1.2;
               UpdateSpeed := 0.5;
               VelocityX := -4 + Random * 8;
               VelocityY := -Random * 7;
               AccelX := 0;
               AccelY := 0.2 + Random / 2;
          end;
     end;
end;

procedure TSpray.DoMove(const MoveCount: Single);
begin
     Accelerate;
     UpdatePos(1);
     Alpha := Alpha - 3;
     if Alpha < 0 then Dead;
end;

procedure SprayFruit(PosX, PosY: Single);
var
   I: Integer;
begin
     for I :=0 to 15 do
     begin
          with TSpray.Create(SpriteEngine) do
          begin
               ImageName:='flare';
               BlendMode := Blend_Add;
               X := PosX;
               Y := PosY;
               Z := 20;
               ScaleX := 0.1;
               ScaleY := 0.1;
               Red := 255;
               Green := 50;
               Blue := 0;
               Acceleration := 0.05;
               MinSpeed := 0.8;
               MaxSpeed := 1;
               Direction:= I * 16;
          end;
     end;
end;

procedure TGreenApple.DoMove(const MoveCount: Single);
begin
     inherited;
     CollideRect := Rect(Round(X),
                    Round(Y),
                    Round(X + PatternWidth),
                    Round(Y + PatternHeight));
     Collision;
end;

procedure TGreenApple.DoCollision(const Sprite: TSprite);
begin
     if (Sprite is TTile) then
     begin
          if  (TTile(Sprite).ImageName = 'Ground1')  or (TTile(Sprite).ImageName='Rock1') or ( TTile(Sprite).ImageName= 'Rock2')  then
          begin
               JumpState := jsNone;
               Y := TTile(Sprite).Y-28;
          end;
     end;
end;

procedure CreateGreenApple(PosX, PosY: Single);
begin
     Randomize;
     if Random(3) = 1 then
     begin
          with TGreenApple.Create(SpriteEngine) do
          begin
               ImageName := 'Fruit'+ IntToStr( 2 + Random(2));
               X := PosX;
               Y := PosY;
               Z := 5;
               CollideMode := cmRect;
               Collisioned := True;
               DoJump := True;
          end;
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

procedure TTile.DoMove;
begin
     inherited;
     CollideRect := Rect(Round(X),
                    Round(Y),
                    Round(X + FCollideRight),
                    Round(Y + FCollideBottom));

     if ImageName='Spring1' then
     CollideRect := Rect(Round(X),
                    Round(Y + 25),
                    Round(X + FCollideRight),
                    Round(Y + FCollideBottom));
end;

procedure TActor.DoMove(const MoveCount: Single);
begin
     inherited;
     if Y > 1200 then
     begin
          SpriteEngine.Clear;
          CreateMap;
       //   MainForm.Music.Songs.Find('Music1').Play;
          FruitCount:=0;
          Exit;
     end;
     Left :=   Round(X + 45);
     Top :=    Round(Y + 45);
     Right :=  Round(X + 65);
     Bottom := Round(Y + 110);
     CollideRect := Rect(Left, Top, Right, Bottom);
     //falling--when walk out of tile edge
     if (Self.Right < LeftEdge) or (Self.Left > RightEdge+1) then
     begin
          if JumpState <> jsJumping then
               JumpState := jsFalling;
     end;

     if HGE.Input_GetKeyState(HGEK_RIGHT) and (state <> Die)then
     begin
          State := WalkRight;
          X := X + MoveSpeed;
          case JumpState of
               jsNone:
               begin
                     if UserRefreshRate=60 then SetAnim('Walk', 0, 12, 0.45, True, False, True);
                     if UserRefreshRate=75 then SetAnim('Walk', 0, 12, 0.4, True, False, True);
                     if UserRefreshRate=85 then SetAnim('Walk', 0, 12, 0.35, True, False, True);
                     if UserRefreshRate=100 then SetAnim('Walk', 0, 12, 0.3, True, False, True);
                     if UserRefreshRate=120 then SetAnim('Walk', 0, 12, 0.25, True, False, True);
               end;
               jsJumping: SetAnim('Jump', 0, 3, 0.06, False, False, True);
               jsFalling: SetAnim('Jump', 2, 2, 0, False, False, True);
          end;
     end;

     if HGE.Input_GetKeyState(HGEK_LEFT)and (State <> Die) then
     begin
          State := WalkLeft;
          X := X - MoveSpeed;
          case JumpState of
               jsNone:
               begin
                    if UserRefreshRate=60 then  SetAnim('Walk', 0, 12, 0.45, True, True, True);
                    if UserRefreshRate=75 then  SetAnim('Walk', 0, 12, 0.4, True, True, True);
                    if UserRefreshRate=85 then  SetAnim('Walk', 0, 12, 0.35, True, True, True);
                    if UserRefreshRate=100 then  SetAnim('Walk', 0, 12, 0.3, True, True, True);
                    if UserRefreshRate=120 then  SetAnim('Walk', 0, 12, 0.25, True, True, True);
               end;
               jsJumping: SetAnim('Jump', 0, 3, 0.06, False, True, True);
               jsFalling: SetAnim('Jump', 2, 2, 0, False, True, True);
          end;
     end;

     if HGE.Input_KeyUp(HGEK_RIGHT) and (State <> Die)then
     begin
          State := StandRight;
          if JumpState = jsNone then
               SetAnim('Idle', 0, 12, 0.25, True, False, True);
     end;

     if HGE.Input_KeyUp(HGEK_LEFT)and (State <> Die) then
     begin
          State := StandLeft;
          if JumpState = jsNone then
               SetAnim('Idle', 0, 12, 0.25, True, True, True);
     end;

     if (JumpState = jsNone) then
     begin
          if HGE.Input_KeyDown(HGEK_CTRL) or HGE.Input_KeyDown(HGEK_Space) and (state<>die)then
          begin
               DoJump := True;
            //   MainForm.Music.Songs.Items[1].Play;
               Animpos := 0;
               case State of
                    StandRight:
                    begin
                         if UserRefreshRate=60 then SetAnim('Jump', 0, 3, 0.06, True, False, True);
                         if UserRefreshRate=75 then SetAnim('Jump', 0, 3, 0.05, True, False, True);
                         if UserRefreshRate=85 then SetAnim('Jump', 0, 3, 0.04, True, False, True);
                         if UserRefreshRate=100 then SetAnim('Jump', 0, 3, 0.03, True, False, True);
                         if UserRefreshRate=120 then SetAnim('Jump', 0, 3, 0.02, True, False, True);
                    end;
                    StandLeft:
                    begin
                         if UserRefreshRate=60 then SetAnim('Jump', 0, 3, 0.06, True, True, True);
                         if UserRefreshRate=75 then SetAnim('Jump', 0, 3, 0.05, True, True, True);
                         if UserRefreshRate=85 then SetAnim('Jump', 0, 3, 0.04, True, True, True);
                         if UserRefreshRate=100 then SetAnim('Jump', 0, 3, 0.03, True, True, True);
                         if UserRefreshRate=120 then SetAnim('Jump', 0, 3, 0.03, True, True, True);
                    end;
               end;
          end;
     end;

     if Engine.WorldX < (X - 350) then
            Engine.WorldX := X - 350;

     if Engine.WorldX > (X - 345) then
            Engine.WorldX := X - 345;

     if Engine.WorldY > (Y + 50) then
           Engine.Worldy := Y + 50 ;

     if Y < 250 then
     begin
          if Engine.WorldY < (Y - 250) then
               Engine.WorldY := Y - 250;
     end;
     if UserRefreshRate = 60 then
     begin
          Layer1pos := Engine.Worldx*2*0.25-20000;
          Layer2pos := Engine.Worldx*1*0.25-20000;
     end;
     if  (UserRefreshRate=75)  then
     begin
          Layer1pos:=Engine.Worldx*1.5*0.5-20000;
          Layer2pos:=Engine.Worldx*0.5-20000;
     end;
     if  (UserRefreshRate=85)  then
     begin
          Layer1pos:=Engine.Worldx*1.5*0.5-20000;
          Layer2pos:=Engine.Worldx*1*0.5-20000;
     end;
     if  (UserRefreshRate=100)  then
     begin
          Layer1pos:=Engine.Worldx*1.5*0.5-20000;
          Layer2pos:=Engine.Worldx*1*0.5-20000;
     end;
     if  (UserRefreshRate=120)  then
     begin
          Layer1pos:=Engine.Worldx*1*0.5-20000;
          Layer2pos:=Engine.Worldx*1*0.25-20000;
     end;
     Collision;
end;

procedure TActor.DoCollision(const Sprite: TSprite);
var
   TileName: string;
   TileLeft, TileRight,
   TileTop, TileBottom: Integer;
begin
     if (Sprite is TTile) then
     begin
          TileName := TTile(Sprite).ImageName;
          //only those tile can collision
          if (TileName='Ground1') or (TileName ='Rock2') or (TileName = 'Rock1') or (TileName='Box1') or (TileName='Box2') or(TileName='Box3') or (TileName='Box4') or (TileName='Spring1') then
          begin
               TileLeft := Trunc(TTile(Sprite).X);
               TileTop := Trunc(TTile(Sprite).Y);
               TileRight := Trunc(TTile(Sprite).X) + TTile(Sprite).PatternWidth;
               TileBottom := Trunc(TTile(Sprite).Y) + TTile(Sprite).PatternHeight;
               LeftEdge := Trunc(TTile(Sprite).X);
               RightEdge := Trunc(TTile(Sprite).X) + TTile(Sprite).PatternWidth;
          end;
          //Falling-- land at ground
          if JumpState = jsFalling then
          begin
               if  (TileName = 'Ground1') or (TileName = 'Rock2')or (TileName = 'Rock1') or (TileName='Box1') or (TileName='Box2') or(TileName='Box3') or (TileName='Box4') then
               begin
                    if(Self.Right - 4 > TileLeft) and
                    (Self.Left + 3 < TileRight)   and
                    (Self.Bottom - 12 < TileTop)   then
                    begin
                         JumpState := jsNone;
                         case UserRefreshRate of
                              60:
                              begin
                                    JumpSpeed := 0.49;
                                    JumpHeight := 13.3;
                                    MaxFallSpeed := 9;
                              end;
                              75:
                              begin
                                    JumpSpeed := 0.3;
                                    JumpHeight := 10.5;
                                    MaxFallSpeed := 9;
                              end;
                              85:
                              begin
                                    JumpSpeed := 0.2;
                                    JumpHeight := 8.5;
                                    MaxFallSpeed := 8;
                              end;
                              100:
                              begin
                                    JumpSpeed := 0.13;
                                    JumpHeight := 6.9;
                                    MaxFallSpeed := 8;
                              end;
                              120:
                              begin
                                   JumpSpeed := 0.1;
                                   JumpHeight := 5;
                                   MaxFallSpeed := 8;
                              end;
                          end;
                         Self.Y := TileTop - 102;

                         case State of
                             StandLeft: SetAnim('Idle', 0, 12, 0.25, True, True, True);
                             StandRight:SetAnim('Idle', 0, 12, 0.25, True, False, True);
                             WalkLeft:  SetAnim('walk', 0, 12, 0.2, True, True, True);
                             WalkRight: SetAnim('walk', 0, 12, 0.2, True, False, True);
                         end;
                    end;
               end;
          end;
          // jumping-- touch top tiles
          if JumpState = jsJumping then
          begin
               if (TileName = 'Rock2')or (TileName = 'Rock1') or (TileName='Box1') or (TileName='Box2') or(TileName='Box3') or (TileName='Box4')then
               begin
                    if (Self.Right - 4 > TileLeft)  and
                       (Self.Left + 3  < TileRight) and
                       (Self.Top < TileBottom - 5)   and
                       (Self.Bottom >TileTop + 8)    then
                    begin
                         Jumpstate:= jsfalling;
                         if  (TileName='Box1') or (TileName='Box2') or(TileName='Box3') or (TileName='Box4') then
                         begin
                            //   MainForm.Music.Songs.Items[2].Play;
                              TTile(Sprite).Dead;
                              SprayBox(TTile(Sprite).X, TTile(Sprite).Y);
                              CreateGreenApple(TTile(Sprite).X, TTile(Sprite).Y);
                         end;
                    end;
               end;
          end;

          //tiles collision
          if (TileName = 'Rock2')or (TileName = 'Rock1') or (TileName='Box1') or (TileName='Box2') or(TileName='Box3') or (TileName='Box4') or (TileName='Spring1')then
          begin
               if State=WalkLeft then
               begin
                     if (Self.Left + 8 > TileRight) and
                        (Self.Top + 10 < TileBottom)   and
                        (Self.Bottom - 8 >TileTop)     then
                           Self.X := TTile(Sprite).X + (TTile(sprite).PatternWidth-45)-3;
               end;

               if State=WalkRight then
               begin
                    if (Self.Right - 8  < TileLeft) and
                       (Self.Top + 10 < TileBottom)  and
                       (Self.Bottom - 8 > TileTop)    then
                          Self.X := TTile(Sprite).X - (Self.PatternWidth-45)+3; // 64= self right
               end;
          end;
          //get  fruit
          if (TileName='Fruit1') or (TileName='Fruit4')   then
          begin
                  Inc(FruitCount);
                  //  MainForm.Music.Songs.Find('GetFruit').Play;
                  TTile(Sprite).Dead;
                  SprayFruit(TTile(Sprite).X + 10, TTile(Sprite).Y + 10);
          end;

          //
          if (TileName = 'Spring1') and (JumpState = jsFalling)  then
          begin
              // MainForm.Music.Songs.Find('Rebon').Play;
               Self.Y:=TileTop-85;
               JumpState:=jsNone;
               DoJump:=True;
               if UserRefreshRate=60 then
               begin
                    JumpSpeed := 0.5;
                    JumpHeight := 20.5;
                    MaxFallSpeed := 12;
               end;
               if UserRefreshRate=75 then
               begin
                    JumpSpeed := 0.25;
                    JumpHeight := 14.5;
                    MaxFallSpeed := 10;
               end;
               if UserRefreshRate=85 then
               begin
                    JumpSpeed := 0.2;
                    JumpHeight := 13;
                    MaxFallSpeed := 8.5;
               end;
               if UserRefreshRate=100 then
               begin
                    JumpSpeed := 0.12;
                    JumpHeight := 10;
                    MaxFallSpeed := 8.5;
               end;
               if UserRefreshRate=120 then
               begin
                    JumpSpeed := 0.12;
                    JumpHeight := 10;
                    MaxFallSpeed := 8.5;
               end;
               AnimPos:=0;
               case State of
                    StandRight: SetAnim('Jump', 0, 3, 0.06, False, False, True);
                    StandLeft: SetAnim('Jump', 0, 3, 0.06, False, True, True);
               end;
               TTile(Sprite).AnimPos:=0;
               TTile(Sprite).SetAnim('Spring1',0,6,0.2,False,False,True);
          end;
     end;

     // get green Apple
    if (Sprite is TGreenApple) then
    begin
         if TGreenApple(Sprite).JumpState= jsNone then
         begin
         //   MainForm.Music.Songs.Find('GetGreenApple').Play;
              TTile(Sprite).Dead;
         end;
    end;

    // jump fall and kill enemy
    if (Sprite is TEnemy) then
    begin
         if (jumpState=jsNone) or (JumpState=jsJumping) then
         begin
              // MainForm.Music.Songs.Find('Dead').Play;
              // MainForm.Music.Songs.Find('Music1').Stop;;
              State := Die;
              Sleep(1000);
              Collisioned := False;
              DoJump := True;
              JumpSpeed := 0.1;
              JumpHeight := 5;
              AnimPos := 0;
              SetAnim('Dead',0,6,0.1,True,False,True);
         end;
         if (jumpState=jsFalling) and (Y+100< TEnemy(Sprite).Y)  then
         begin
              // MainForm.Music.Songs.Find('Ka').Play;;
              JumpState := jsNone;
              DoJump := True;
              if UserRefreshRate = 85 then
              begin
                   JumpSpeed := 0.2;
                   JumpHeight := 7;
              end;
              if UserRefreshRate = 60 then
              begin
                   JumpSpeed := 0.5;
                   JumpHeight := 10;
              end;
              with TEnemy(Sprite) do
              begin
                   Y := Y-1;
                   State := Die;
                   Collisioned := False;
                   DoAnimate := False;
                   MirrorY := True;
                   DoJump := True;
                   JumpSpeed := 0.2;
                   JumpHeight := 5;
              end;
         end;
    end;
end;

constructor TActor.Create(const AParent: TSprite);
begin
     inherited;
     X := 810;
     Y := 200;
     CollideMode := cmRect;
     ImageName := 'Idle';
     AnimStart := 0;
     AnimCount := 12;
     AnimSpeed := 0.25;
     AnimLooped := True;
     DoAnimate := True;
     Collisioned := True;
     State := StandLeft;
     case UserRefreshRate of
          60: FMoveSpeed := 3;
          75: FMoveSpeed := 2.5;
          85: FMoveSpeed := 2;
          100: FMoveSpeed:= 1.5;
          120: FMoveSpeed:= 1;
     end;
     Animpos := 5;
     JumpSpeed := 0.2;
     JumpHeight := 8.5;
     MaxFallSpeed := 8;
     JumpState := jsjumping;
     State := StandRight;
end;

procedure TEnemy.DoMove(const MoveCount: Single);
begin
     inherited;
     CollideRect := Rect(Round(X),
                    Round(Y),
                    Round(X + Self.FCollideRight),
                    Round(Y + Self.FCollideBottom));
     if (State <> Die) then
     begin
          case State of
               WalkLeft:
               begin
                    if UserRefreshRate=60 then
                    begin
                         X := X - 1.5;
                         SetAnim(ImageName,0,AnimCount, 0.4, True, False, True);
                    end;
                    if UserRefreshRate=75 then
                    begin
                         X := X - 1.25;
                         SetAnim(ImageName,0,AnimCount, 0.35, True, False, True);
                    end;
                    if UserRefreshRate=85 then
                    begin
                         X := X - 1;
                         SetAnim(ImageName,0,AnimCount, 0.3, True, False, True);
                    end;
                    if UserRefreshRate=100 then
                    begin
                         X := X - 1;
                         SetAnim(ImageName, 0, AnimCount, 0.25, True, False, True);
                    end;
                     if UserRefreshRate = 120 then
                    begin
                         X:=X-0.5;
                         SetAnim(ImageName,0,AnimCount, 0.2, True, False, True);
                    end;
               end;
               WalkRight:
               begin
                    if UserRefreshRate = 60 then
                    begin
                         X := X + 1.5;
                         SetAnim(ImageName, 0, AnimCount, 0.4, True, True, True);
                    end;
                    if UserRefreshRate = 75 then
                    begin
                         X := X + 1.25;
                         SetAnim(ImageName,0,AnimCount, 0.35, True, True, True);
                    end;
                    if UserRefreshRate = 85 then
                    begin
                         X := X + 1;
                         SetAnim(ImageName, 0, AnimCount, 0.3, True, True, True);
                    end;
                     if UserRefreshRate = 100 then
                    begin
                         X := X + 1;
                         SetAnim(ImageName, 0, AnimCount, 0.25, True, True, True);
                    end;
                    if UserRefreshRate = 120 then
                    begin
                         X := X + 0.5;
                         SetAnim(ImageName, 0, AnimCount, 0.2, True, True, True);
                    end;
               end;
          end;
     end;
    if ImageName = 'Enemy3' then AnimSpeed := 0.15;
    if Y > 600 then Dead;
    Collision;
end;

procedure TEnemy.DoCollision(const Sprite: TSprite);
begin
     if(Sprite is TTile) then
     begin
          if (TTile(Sprite).ImageName='Ground1') or (TTile(Sprite).ImageName='Rock2' )then
          JumpState := jsNone;
          //  y:=TTile(sprite).Y-150;
          if TTile(Sprite).ImageName = 'Test1' then
          begin
               if State = WalkLeft then
               begin
                    X := X + 3;
                    State := WalkRight;
               end
               else
               begin
                    X := X - 3;
                    State := WalkLeft;
               end;
          end;
     end;
end;


function RenderFunc: Boolean;
begin
  HGE.Gfx_BeginScene;
  HGE.Gfx_Clear(0);
  Canvas.Draw(Images.Image['Back3'],0,0,0,Blend_Default);
  Canvas.DrawPart(Images.Image['Back2'],0,310,Trunc(Layer2Pos)-640,0,800,248,$FFFFFFFF,Blend_Default);
  Canvas.DrawPart(Images.Image['Back1'],0,330,Trunc(Layer1Pos)-640,0,800,240,$FFFFFFFF,Blend_Default);
  SpriteEngine.Draw;
  SpriteEngine.Move(1);
  SpriteEngine.Dead;
 // Font.Print(100,100,IntToStr(UserRefreshRate));
  HGE.Gfx_EndScene;
  Result := False;
end;

procedure Main;
var
  I: Integer;
  MonitorFrequency: Integer;
  DC: THandle;
begin
  HGE := HGECreate(HGE_VERSION);
  HGE.System_SetState(HGE_FRAMEFUNC,FrameFunc);
  HGE.System_SetState(HGE_RENDERFUNC,RenderFunc);
  HGE.System_SetState(HGE_USESOUND, False);
  HGE.System_SetState(HGE_WINDOWED,False);
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP, 16);
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;
  DC   := GetDC(HGE.System_GetState(HGE_HWND) );
  MonitorFrequency := GetDeviceCaps(DC, VREFRESH);
  case MonitorFrequency of
          60..70:UserRefreshRate:=60;
          71..75:UserRefreshRate:=75;
          76..85:UserRefreshRate:=85;
          86..100:UserRefreshRate:=100;
          101..120:UserRefreshRate:=120;
  end;

  if (HGE.System_Initiate) then
  begin
    Font:=TSysFont.Create;
    Font.CreateFont('arial',15,[]);
    LoadImages;
    LoadMapData('Stage1-1.map');
    CreateMap;
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
