program DynamicLight;

{$R *.res}

uses
  Windows, SysUtils, HGEImages, HGECanvas, HGE, HGESprite, HGEFont;

type
  TLight = record
    X, Y: Single;
    DX, DY: Single;
  end;

var
  HGE: IHGE = nil;
  Font: TSysFont;
  Images: THGEimages;
  Canvas: THGECanvas;
  LightSurface: ITarget;
  Light:array[0..4] of  TLight;
  Bright: Byte =90;

function FrameFunc: Boolean;
var
  DT: Single;
  I: INteger;
begin
  DT := HGE.Timer_GetDelta;
  for I := 0 to 4 do
  begin
    with Light[I] do
    begin
      X := X + DX * DT;
      if (X > 800) or (X < 0) then
        DX := -DX;
        Y := Y + DY * DT;
      if (Y > 600) or (Y < 0) then
        DY := -DY;
     end;
  end;
  // Process keys
  case HGE.Input_GetKey of
    HGEK_UP:
    begin
      Inc(Bright);
    end;
    HGEK_DOWN:
    begin
      Dec(Bright);
    end;
    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      FreeAndNil(Font);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function RenderFunc: Boolean;
var
  I: Integer;
begin
  //draw light surface
  HGE.Gfx_BeginScene(LightSurface);
  HGE.Rectangle(0,0,1024,1024,ARGB(255,Bright, Bright, Bright), True);
  Canvas.DrawEx(Images.Image['Light'], 0, 410, 280, 128, 128, 1, 0.7,
                 False ,False, $FFFFFFFF, Blend_SrcColorAdd);
  for I := 0 to 4 do
    with Light[I] do
    begin
      Canvas.DrawEx(Images.Image['Light'], 0, X, Y, 128, 128, 1, 0.7,
                    False ,False, $FFFFFFFF, Blend_SrcColorAdd);
    end;
  HGE.Gfx_EndScene;
  //

  HGE.Gfx_BeginScene;
  Canvas.Draw(Images.Image['Background'],0,0,0,Blend_default);
  Canvas.DrawPart(LightSurface.GetTexture,0,0,0,0,1024,1024,$FFFFFFFF, blend_Multiply);
    for I := 0 to 4 do
    with Light[I] do
    begin
      Canvas.Draw(Images.Image['Sprite'],0, X-15, Y-40, Blend_Default);
    end;

  Font.Print(50,50,'Bright= '+IntToStr(Bright));
  Font.Print(300,530,'Press Up: Bright+');
  Font.Print(300,560,'Press Down: Bright-');
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
  HGE.System_SetState(HGE_WINDOWED,false);
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP,16);
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  Canvas := THGeCanvas.Create;
  Images:=THGEImages.Create;

  if (HGE.System_Initiate) then
  begin
    Font := TSysFont.Create;
    Font.CreateFont('Arial',15,[]);
    Images.LoadFromFile('Background.jpg');
    Images.LoadFromFile('Sprite.png');
    Images.LoadFromFile('Light.png');
    LightSurface := HGE.Target_Create(1024,1024, False);
    for I := 0 to 4 do
      with Light[I] do
      begin
        X := HGE.Random_Float(0, 800);
        Y := HGE.Random_Float(0, 600);
        DX := HGE.Random_Float(-100,100);
        DY := HGE.Random_Float(-100,100);
      end;

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
