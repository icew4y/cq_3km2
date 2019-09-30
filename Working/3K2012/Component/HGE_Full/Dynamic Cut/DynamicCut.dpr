program DynamicCut;

{$R *.res}

uses
  Windows, SysUtils, HGEImages, HGECanvas, HGE;

var
  HGE: IHGE = nil;
  Font: TSysFont;
  Images: THGEimages;
  Canvas: THGECanvas;
  ANDSurface1, XORSurface1: ITarget;
  ANDSurface2, XORSurface2: ITarget;
  MouseX, MouseY: Single;
  IsMouseDown: Boolean;
  IsDrawANDSurface1: Boolean;
  IsDrawXORSurface1: Boolean;
  X1, Value1: Single;
  Y1, Value2: Single;

function FrameFunc: Boolean;
var
  DT: Single;
begin
  DT := HGE.Timer_GetDelta;
  HGE.Input_GetMousePos(MouseX, MouseY);
  if (X1 > 280) or (X1 < 0) then  Value1 := -Value1;
  X1:= X1 + Value1*100 *DT;
  if (Y1 > 360) or (Y1 < 0) then  Value2 := -Value2;
  Y1:= Y1 + Value2*100 *DT;

  if HGE.Input_KeyDown( HGEK_LBUTTON ) then  IsMouseDown := True;
  if HGE.Input_KeyUP( HGEK_LBUTTON ) then  IsMouseDown := False;
 
  case HGE.Input_GetKey of
    HGEK_Space:
    begin
       IsDrawANDSurface1 := True;
       IsDrawXORSurface1 := True;
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
  HGE.Gfx_BeginScene(ANDSurface1);
  if (IsDrawANDSurface1) then
  begin
    Canvas.DrawEx(Images.Image['Lena'],0, 0, 0, 1,
                  False, ARGB(255,0,0,0), BLEND_default);
    IsDrawANDSurface1 := False;
  end;
  if IsMouseDown then
      HGE.Circle(MouseX-50, MouseY-120,12,1, ARGB(255,255,255,255), True);
  HGE.Gfx_EndScene;
   //
  HGE.Gfx_BeginScene(XORSurface1);
  if (IsDrawXORSurface1) then
  begin
    Canvas.DrawEx(Images.Image['Lena'],0, 0, 0, 1,
                  False, ARGB(255,255,255,255), BLEND_Default);
    IsDrawXORSurface1 := False;
  end;
  if IsMouseDown then
      HGE.Circle(MouseX-50, MouseY-120,12,1, ARGB(255,0,0,0), True);
  HGE.Gfx_EndScene;
   //
  HGE.Gfx_BeginScene(ANDSurface2);
  Canvas.DrawEx(Images.Image['Lena'],0, 0, 0, 1,
                False, ARGB(255,0,0,0), BLEND_Default);
  HGE.Rectangle(X1, 120, 120, 120, ARGB(255,255,255,255), True);
  HGE.Circle(180,Y1,80,$FFFFFFFF, True);
  HGE.Gfx_EndScene;
  //
  HGE.Gfx_BeginScene(XORSurface2);
  Canvas.DrawEx(Images.Image['Lena'],0, 0, 0, 1,
                False, ARGB(255,255,255,255), BLEND_Default);
  HGE.Rectangle(X1, 120, 120, 120, ARGB(255,0,0,0), True);
  HGE.Circle(180,Y1,80,ARGB(255,0,0,0), True);
  HGE.Gfx_EndScene;
  //
  HGE.Gfx_BeginScene;
  Canvas.DrawPart(Images.Image['bg2'],0,0,0,0,800,600,$FFFFFFFF,Blend_Default);
  Canvas.DrawPart(ANDSurface1.GetTexture,50,120,0,0,300,300,$FFFFFFF,Blend_Multiply);
  Canvas.DrawPart(XORSurface1.GetTexture,50,120,0,0,300,300,$FFFFFFFF,Blend_XOR);
  Canvas.DrawPart(ANDSurface2.GetTexture,450,120,0,0,300,300,$FFFFFFF,Blend_Multiply);
  Canvas.DrawPart(XORSurface2.GetTexture,450,120,0,0,300,300,$FFFFFFFF,Blend_XOR);
  HGE.Circle(MouseX, MouseY,12,1, ARGB(255,255,0,0),False);
  Font.Print(300, 530,'Mouse Down to Erase');
  Font.Print(300,560,'Press Sapce to Reset');
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
  HGE.System_SetState(HGE_SCREENBPP,32);
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  HGE.System_SetState(HGE_HIDEMOUSE, False);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;

  if (HGE.System_Initiate) then
  begin
    Font := TSysFont.Create;
    Font.CreateFont('Arial',15,[]);
    Images.LoadFromFile('bg2.png');
    Images.LoadFromFile('Lena.jpg');
    ANDSurface1 := HGE.Target_Create(512, 512, False);
    XORSurface1 := HGE.Target_Create(512, 512, False);
    ANDSurface2 := HGE.Target_Create(512, 512, False);
    XORSurface2 := HGE.Target_Create(512, 512, False);
    IsDrawANDSurface1 := True;
    IsDrawXORSurface1 := True;
    Value1 := 1;
    Value2 := 1;
    Y1 := 50;
    X1 := 220;
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
