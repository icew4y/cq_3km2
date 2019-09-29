program Shape2D;

{$R *.res}

uses
  Windows,
  SysUtils,
  HGEImages,
  HGECanvas,
  Classes,
  HGE;


var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  P:array[0..4] of TPoint;

function FrameFunc: Boolean;
begin
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
  //HGE.Circle(100,100,60, ARGB(255,255,0,0), True);
  //HGE.Circle(250,100,60,2, ARGB(255,0,255,0),False);
  //HGE.Triangle(400,50,350,150,450,150,ARGB(255,0,0,255),True);
  {HGE.Ellipse(550,100,80,50,ARGB(255,255,255,0), True);
  HGE.Ellipse(710,100,50,80,ARGB(255,255,0,255), False);
  HGE.Arc(100,250,60,50,300,ARGB(255,0,255,0),True,TRue);
  HGE.Line2Color(200,200,300,300,ARGB(255,255,0,0),ARGB(255,0,0,255),Blend_Default);
  HGE.Line2Color(200,300,300,200,ARGB(255,255,255,0),ARGB(255,0,255,255),Blend_Default);
  HGE.Rectangle(330,200,150,150,ARGB(255,255,0,255),True);
  HGE.Rectangle(510,200,150,150,ARGB(255,0,255,255),False);
  HGE.Quadrangle4Color(50,400,200,400,200,550,50,550,
     ARGB(255,255,0,0),ARGB(255,0,255,0),ARGB(255,0,0,255),ARGB(255,255,255,0),True);
  HGE.Quadrangle4Color(250,400,400,400,400,550,250,550,
     ARGB(255,255,0,0),ARGB(255,0,255,0),ARGB(255,0,0,255),ARGB(255,255,255,0),False);
  P[0]:=Point(550,420);  P[1]:=Point(470,420); P[2]:=Point(420,485); P[3]:=Point(470,550); P[4]:=point(550,550);
  HGE.Polygon(P, ARGB(255,55,255,150), True);
  }HGE.Gfx_EndScene;
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
  HGE.System_SetState(HGE_TEXTUREFILTER, true);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;

  if (HGE.System_Initiate) then
  begin
    Images.LoadFromFile('bg2.png');
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
