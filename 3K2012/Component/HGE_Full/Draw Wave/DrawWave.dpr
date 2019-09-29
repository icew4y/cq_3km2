program DrawWave;

{$R *.res}

uses
  Windows, SysUtils, HGEImages, HGECanvas, HGEDef, HGE;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Value: Integer;

function FrameFunc: Boolean;
var
  DT: Single;
begin
  DT := HGE.Timer_GetDelta;
  Value:=Value+1+Trunc(DT*100);
 
  case HGE.Input_GetKey of
    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function RenderFunc: Boolean;
begin
  HGE.Gfx_BeginScene;
  Canvas.DrawPart(Images.Image['bg2'],0,0,0,0,800,600,$FFFFFFFF,Blend_Default);
  Canvas.DrawWaveX(Images.Image['Lena'],30,100,350,350,Trunc(Cos512(Value div 5)*15),30,Value,  $FFFFFFFF,Blend_Default);
  Canvas.DrawWaveY(Images.Image['Lena'],420,100,330,350,Trunc(Cos512(Value div 5)*15),30,Value,  $FFFFFFFF,Blend_Default);
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
  HGE.System_SetState(HGE_SCREENBPP,32);
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;

  if (HGE.System_Initiate) then
  begin
    Images.LoadFromFile('bg2.png');
    Images.LoadFromFile('Lena.jpg');
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
