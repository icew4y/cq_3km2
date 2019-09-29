program ColorEffect;

{$R *.res}

uses
  Windows, SysUtils, HGEImages, HGECanvas,  HGEDef, HGE, HGESpriteEngine;

type
  TMapPoint = record
     R, G, B: Byte;
     RPl, GPl, BPl: Integer;
  end;

  TMapInfo = record
     Width,
     Height: Integer;
     MapPoints: array of array of TMapPoint;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Font: TSysFont;
  SpriteEngine: TSpriteEngine;
  MapInfo: TMapInfo;
  ColorTile: array of array of TAnimatedSprite;
  DT: Single;
  Counter: Integer;

procedure CreateTile;
var
  I, J: Integer;
begin
     MapInfo.Width := Trunc(1024 / (128 * 2)) + 1;
     MapInfo.Height := Trunc(768 / (128 * 2)) + 1;
     SetLength(MapInfo.MapPoints, MapInfo.Width + 1, MapInfo.Height + 1);
     SetLength(ColorTile, MapInfo.Width + 1, MapInfo.Height + 1);
     for i := 0 to MapInfo.Width - 1 do
     begin
          for j := 0 to MapInfo.Height - 1 do
          with MapInfo do
          begin
               MapPoints[i, j].R := Random(256);
               MapPoints[i, j].G := Random(256);
               MapPoints[i, j].B := Random(256);
               MapPoints[i, j].RPl := Random(7) - 3;
               MapPoints[i, j].GPl := Random(7) - 3;
               MapPoints[i, j].BPl := Random(7) - 3;
               ColorTile[i, j]:= TAnimatedSprite.Create(SpriteEngine);
               ColorTile[i, j].ImageName:='tile';
               ColorTile[i, j].DrawMode:= 4;
               ColorTile[i, j].AnimStart:=0;
               ColorTile[i, j].AnimSpeed:=0.1;
               ColorTile[i, j].AnimCount:=32;
               ColorTile[i, j].DoAnimate:= True;
               ColorTile[i, j].AnimLooped:= True;
               ColorTile[i, j].X1 := i * (128 * 2);
               ColorTile[i, j].Y1 := j * (128 * 2);
               ColorTile[i, j].X2 := i * (128 * 2) + (128 * 2);
               ColorTile[i, j].Y2 := j * (128 * 2);
               ColorTile[i, j].X3 := i * (128 * 2) + (128 * 2);
               ColorTile[i, j].Y3 := j * (128 * 2) + (128 * 2);
               ColorTile[i, j].X4 := i * (128 * 2);
               ColorTile[i, j].Y4 := j * (128 * 2) + (128 * 2);
          end;
     end;
end;

procedure ProcessPoints;
var
     i, j: Integer;
begin
     for i := 0 to MapInfo.Width do
          for j := 0 to MapInfo.Height do
               with MapInfo.MapPoints[i, j] do
               begin
                    if R + RPl > 255 then
                    begin
                         R := 255;
                         RPl := -RPl;
                    end
                    else
                    begin
                         if R + RPl < 0 then
                         begin
                              R := 0;
                              RPl := -RPl;
                         end
                         else
                              R := R + RPl;
                    end;
                    if G + GPl > 255 then
                    begin
                         G := 255;
                         GPl := -GPl;
                    end
                    else
                    begin
                         if G + GPl < 0 then
                         begin
                              G := 0;
                              GPl := -GPl;
                         end
                         else
                              G := G + GPl;
                    end;
                    if B + BPl > 255 then
                    begin
                         B := 255;
                         BPl := -BPl;
                    end
                    else
                    begin
                         if B + BPl < 0 then
                         begin
                              B := 0;
                              BPl := -BPl;
                         end
                         else
                              B := B + BPl;
                    end;
               end;
end;

procedure DrawColorTile;
var
     i, j: Integer;
begin
     for i := 0 to MapInfo.Width - 1 do
     begin
          for j := 0 to MapInfo.Height - 1 do
          begin
               ColorTile[i, j].Color1 := ARGB(255, MapInfo.MapPoints[i, j].R, MapInfo.MapPoints[i, j].G, MapInfo.MapPoints[i, j].B);
               ColorTile[i, j].Color2 := ARGB(255, MapInfo.MapPoints[i + 1, j].R, MapInfo.MapPoints[i + 1, j].G, MapInfo.MapPoints[i + 1, j].B);
               ColorTile[i, j].Color3 := ARGB(255, MapInfo.MapPoints[i + 1, j + 1].R, MapInfo.MapPoints[i + 1, j + 1].G, MapInfo.MapPoints[i + 1, j + 1].B);
               ColorTile[i, j].Color4 := ARGB(255, MapInfo.MapPoints[i, j + 1].R, MapInfo.MapPoints[i, j + 1].G, MapInfo.MapPoints[i, j + 1].B);
               ColorTile[i, j].DoDraw;
               ColorTile[i, j].Move(350*DT);
          end;
     end;
end;

function FrameFunc: Boolean;
begin
  DT := HGE.Timer_GetDelta;
  Counter:=Counter+8;
  if (Counter mod 2)=0 then
    ProcessPoints;

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
  DrawColorTile;
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
  HGE.System_SetState(HGE_SCREENWIDTH, 1024);
  HGE.System_SetState(HGE_SCREENHEIGHT,768);
  HGE.System_SetState(HGE_SCREENBPP,16);
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Images.LoadFromFile('Tile.png',128, 128);
    CreateTile;
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
