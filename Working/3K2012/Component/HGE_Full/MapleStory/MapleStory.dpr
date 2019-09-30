program MapleStory;

{$R *.res}

uses
  Windows, Classes, SysUtils, StrUtils, HGEImages, HGECanvas, HGE,
  HGESpriteEngine;

type
  TMapRec = record
      X, Y, Z: Integer;
      ImageName: string[50];
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  SpriteEngine: TSpriteEngine;
  FileSize: Integer;
  MapData: array of TMapRec;
  PosX: Integer;

procedure LoadImages;
var
  FileSearchRec: TSearchRec;
begin
  if FindFirst(ExtractFilePath(ParamStr(0)) + 'Gfx\'+ '*.png', faAnyfile, FileSearchRec) = 0 then
  repeat
    Images.LoadFromFile('Gfx\'+FileSearchRec.Name);
  until  FindNext(FileSearchRec) <> 0;
  FindClose(FileSearchRec);
end;

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

procedure CreateMap(OffX, OffY: Integer);
var
  I: Integer;
begin
  for I := 0 to FileSize - 1   do
  begin
    if (Leftstr(MapData[I].ImageName, 3) = 'Obj') or
    (Leftstr(MapData[I].ImageName, 4) = 'Tile')  then
    begin
      with  TSprite.Create(SpriteEngine) do
      begin
        ImageName := MapData[I].ImageName;
        Width := PatternWidth;
        Height:= PatternHeight;
        X := MapData[I].X + OffX;
        Y := MapData[I].Y + OffY;
        Z := MapData[I].Z;
        Moved := False;
      end;
    end;
    //
    if  (MapData[I].ImageName = 'MapHelper.img.Portal') then
    begin
       with  TAnimatedSprite.Create(SpriteEngine) do
       begin
         ImageName := MapData[I].ImageName;
         Width := PatternWidth;
         Height:= PatternHeight;
         X := MapData[I].X +OffX;
         Y := MapData[I].Y +OffY;
         Z := MapData[I].Z;
         SetAnim(ImageName, 0, PatternCount, 0.15, True, False, True);
       end;
    end;
  end;

end;

function FrameFunc: Boolean;
begin
  if HGE.Input_GetKeyState(HGEK_UP) then
     SpriteEngine.WorldY := SpriteEngine.WorldY- 3;
  if HGE.Input_GetKeyState(HGEK_Down) then
     SpriteEngine.WorldY := SpriteEngine.WorldY+ 3;
  if HGE.Input_GetKeyState(HGEK_Left) then
     SpriteEngine.WorldX := SpriteEngine.WorldX- 3;
  if HGE.Input_GetKeyState(HGEK_Right) then
     SpriteEngine.WorldX :=  SpriteEngine.WorldX+ 3;
  if  SpriteEngine.WorldX <- 1100 then
      SpriteEngine.WorldX :=- 1100;
  if  SpriteEngine.WorldX > 2480 then
      SpriteEngine.WorldX := 2480;
  if  SpriteEngine.WorldY > -20 then
      SpriteEngine.WorldY := -20;
  if  SpriteEngine.WorldY < -1600 then
      SpriteEngine.WorldY := -1600;
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
  HGE.Gfx_Clear(ARGB(255,0,150,250));
  Canvas.DrawPart(Images.Image['Back.1'],0, 0, PosX, 0, 1024 + PosX, 579, $FFFFFFFF, Blend_Default);
  Canvas.Draw(Images.Image['Back.5'], 0, 0, 345, Blend_Default);
  Inc(PosX);
  SpriteEngine.Draw;
  SpriteEngine.Move(1);
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
  HGE.System_SetState(HGE_SCREENBPP, 16);
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  HGE.System_SetState(HGE_FPS, HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;
  if (HGE.System_Initiate) then
  begin
    LoadImages;
    Images.LoadFromFile('MapHelper.img.Portal.png', 88, 256);
    LoadMap('Amherst.map');
    CreateMap(3440, 200);
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
