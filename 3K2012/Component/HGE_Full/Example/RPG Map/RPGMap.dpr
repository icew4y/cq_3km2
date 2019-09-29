program RPGMap;

{$R *.res}

uses
  Windows, SysUtils, Classes, HGEImages, HGECanvas, HGEDef, HGE, HGESpriteEngine;

type
   TMapRec = record
     X, Y: Integer;
     ImageName: string[10];
   end;

   TTile = class(TSprite)
   private
     FCollideRight: Integer;
     FCollideBottom: Integer;
   public
     procedure DoMove(const MoveCount: Single); override;
   end;

   TCharacter = class(TAnimatedSprite)
   private
     FMoveSpeedX: Single;
     FMoveSpeedY: Single;
     FLeft, FTop, FRight, FBottom: Integer;
   public
     procedure DoMove(const MoveCount: Single); override;
     procedure DoCollision(const Sprite: TSprite); override;
     constructor Create(const AParent: TSprite); override;
     property MoveSpeedX: Single read FMoveSpeedX write FMoveSpeedX;
     property MoveSpeedY: Single read FMoveSpeedY write FMoveSpeedY;
     property Left: Integer read FLeft write FLeft;
     property Top: Integer read FTop write FTop;
     property Right: Integer read FRight write FRight;
     property Bottom: Integer read FBottom write FBottom;
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
  Character: TCharacter;

procedure LoadImages;
var
  FileSearchRec: TSearchRec;
begin
  if FindFirst(ExtractFilePath(ParamStr(0)) + 'Gfx\'+ '*.png', faAnyfile, FileSearchRec) = 0 then
  repeat
    Images.LoadFromFile('Gfx\'+FileSearchRec.Name);
  until  FindNext(FileSearchRec) <> 0;
  FindClose(FileSearchRec);
  Images.LoadFromFile('Player.png',32,48);
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
   I: Integer;
   Tile: array of TTile;
begin
     SetLength(Tile, FileSize);
     for I := FileSize - 1 downto 0 do
     begin
          Tile[I] := TTile.Create(SpriteEngine);
          Tile[I].ImageName := MapData[I].ImageName;
          Tile[I].X := MapData[I].X - 540;
          Tile[I].Y := MapData[I].Y - 150;
          Tile[I].Width := Tile[I].PatternWidth;
          Tile[I].Height := Tile[I].PatternHeight;
          Tile[I].CollideMode := cmRect;
          Tile[I].Moved := False;
          Tile[I].FCollideRight := Tile[I].PatternWidth;
          Tile[I].FCollideBottom := Tile[I].PatternHeight;
          if (Tile[I].ImageName= 'Block1') or
            (Tile[I].ImageName='Block2') then
          begin
               Tile[I].Visible:= False;
               Tile[I].Collisioned := True;
               Tile[I].Moved := True;
          end;
          Tile[I].Z:=1;
          if (Tile[I].ImageName='Tree1') or
             (Tile[I].ImageName='Tree2') or
             (Tile[I].ImageName='Tree3') or
             (Tile[I].ImageName='Tree4') or
             (Tile[I].ImageName='Tree5') or
             (Tile[I].ImageName='Tree6') or
             (Tile[I].ImageName='Tree9') or
             (Tile[I].ImageName='Tree10')or
             (Tile[I].ImageName='House1')or
             (Tile[I].ImageName='House3')or
             (Tile[I].ImageName='House4')or
             (Tile[I].ImageName='House5')or
             (Tile[I].ImageName='House6')or
             (Tile[I].ImageName='Object4')or
             (Tile[I].ImageName='t22')   or
             (Tile[I].ImageName='t23')   or
             (Tile[I].ImageName='t24')   then
                   Tile[I].Z := Trunc(Tile[i].Y + Tile[i].PatternHeight);
          if (Tile[i].ImageName='Tree4') then
                  Tile[I].Z:=Trunc(Tile[I].Y + Tile[I].PatternHeight)-60;
     end;
end;

constructor TCharacter.Create(const AParent: TSprite);
begin
     inherited;
     X := 200;
     Y := 200;
     z:=1;
     ImageName := 'player';
     CollideMode := cmRect;
     Collisioned := True;
     MoveSpeedX := 2;
     MoveSpeedY := 2;
end;

procedure TCharacter.DoMove(const MoveCount: Single);
begin
     inherited;
     Left :=   Round(X+5);
     Top :=    Round(Y+32);
     Right :=  Round(X + PatternWidth-6);
     Bottom := Round(Y + PatternHeight);
     CollideRect := Rect(Left, Top, Right, Bottom);
     DoAnimate := False;

     if Hge.Input_GetKeyState(HGEK_LEFT) then
     begin
          X := X - MoveSpeedX;
          AnimStart := 4;
          SetAnim('player', 4, 4, 0.15, True, False, True);
     end;
     if Hge.Input_GetKeyState(HGEK_RIGHT) then
     begin
          X := X + MoveSpeedX;
          AnimStart := 8;
          SetAnim('player', 8, 4, 0.15, True, False, True);
     end;

     if Hge.Input_GetKeyState(HGEK_UP) then
     begin
          Y := Y - MoveSpeedY;
          AnimStart := 12;
          SetAnim('player', 12, 4, 0.15, True, False, True);
     end;

       if Hge.Input_GetKeyState(HGEK_DOWN) then
     begin
          Y := Y + MoveSpeedY;
          AnimStart := 0;
          SetAnim('player', 0, 4, 0.15, True, False, True);
     end;
     Collision;
     Engine.WorldX := X - 300;
     Engine.WorldY := Y - 240;
end;

procedure TCharacter.DoCollision(const Sprite: TSprite);
var
   TileLeft, TileRight,
   TileTop, TileBottom: Integer;
begin
     if (Sprite is TTile) then
     begin
          TileLeft := Trunc(TTile(Sprite).X);
          TileTop := Trunc(TTile(Sprite).Y);
          TileRight := Trunc(TTile(Sprite).X) + TTile(Sprite).PatternWidth;
          TileBottom := Trunc(TTile(Sprite).Y) + TTile(Sprite).PatternHeight;
          if (TTile(Sprite).ImageName = 'Block1') or (TTile(Sprite).ImageName = 'Block2') then
          begin
               //walk left
               if Hge.Input_GetKeyState(HGEK_LEFT) then
               begin
                    if (Self.Left + 8 > TileRight) and
                       (Self.Top + 5< TileBottom) and
                       (Self.Bottom - 8 >TileTop)  then
                             X := TileRight - 6;
               end;
               //walk right
               if Hge.Input_GetKeyState(HGEK_RIGHT) then
               begin
                    if (Self.Right - 8 < TileLeft )and
                       (Self.Top + 5 < TileBottom) and
                       (Self.Bottom - 8 >TileTop)  then
                             X := TileLeft - 25;
               end;
               //walk up
               if Hge.Input_GetKeyState(HGEK_UP) then
               begin
                     if (Self.Top + 5 > TileBottom) and
                        (Self.Right - 4 > TileLeft) and
                        (Self.Left + 3 < TileRight) then
                              Y := TileBottom-36;
               end;
              // walk down
               if Hge.Input_GetKeyState(HGEK_DOWN) then
               begin
                    if (Self.Bottom - 4 < TileTop )  and
                       (Self.Right - 4 > TileLeft)  and
                       (Self.Left + 3 < TileRight) then
                             Y := TileTop - 45;
               end;
          end;
     end;
end;

procedure TTile.DoMove;
begin
     inherited;
     CollideRect := Rect(Round(X),
                         Round(Y),
                         Round(X + FCollideRight),
                         Round(Y + FCollideBottom));
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
  Character.Z := Trunc(Character.Y) + Character.PatternHeight + 20;
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
begin
  HGE := HGECreate(HGE_VERSION);
  HGE.System_SetState(HGE_FRAMEFUNC,FrameFunc);
  HGE.System_SetState(HGE_RENDERFUNC,RenderFunc);
  HGE.System_SetState(HGE_USESOUND, False);
  HGE.System_SetState(HGE_WINDOWED,False);
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP, 32);
  //HGE.System_SetState(HGE_TEXTUREFILTER,True);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Font:=TSysFont.Create;
    Font.CreateFont('arial',15,[]);
    LoadImages;
    Character := TCharacter.Create(SpriteEngine);
    LoadMapData('map1.map');
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
