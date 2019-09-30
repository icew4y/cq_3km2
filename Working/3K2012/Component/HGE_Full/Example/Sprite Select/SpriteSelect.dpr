program SpriteSelect;

{$R *.res}

uses
  Windows, SysUtils, Classes, HgeDef, HGEImages, HGECanvas, HGESpriteEngine,
  HGE;

type

  TMySprite =class(TAnimatedSprite)
    FSelected: Boolean;
    FCanMove : Boolean;
    FMovespeed: Single;
    FBright: Byte;
  public
    procedure DoMove(const MoveCount: Single);override;
    procedure OnLMouseUp; override;
  end;

const
  MaxUnits = 55;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  SpriteEngine: TSpriteEngine;
  MySprite: array[0..MaxUnits] of TMySprite;
  Font: TSysFont;
  Cx, Cy,Mx, My: Single;

procedure TMySprite.DoMove(const MoveCount: Single);
begin
     inherited;
     DoMouseEvent;
     if HGE.Input_KeyDown(HGEK_LBUTTON) then
     begin
       Cx := Mx;
       Cy := My;
       FCanMove := True;
     end;

     if HGE.Input_KeyUp(HGEK_RBUTTON) then
     begin
       FCanMove := False;
       FSelected := False;
       SetColor(128,128,128);
     end;

     if FSelected then
     begin
          Red:= Trunc(Cos256(FBright)*80 +100);
          Green:= Trunc(Cos256(FBright)*80 +100);
          Blue:= Trunc(Cos256(FBright)*80 +100);
          Inc(FBright, 4);
     end
     else
         FBright := 128;

     ActiveRect := Rect(Trunc(X+10), Trunc(Y+10), Trunc(X+54), Trunc(Y+54));
     if FSelected and FCanMove then
        TowardToPos(Trunc(Cx)-25, Trunc(Cy)-25, 3, False);
end;

procedure TMySprite.OnLMouseUp;
begin
   BlendMode:= Blend_Bright;
     FSelected := True;
     FCanMove := False;
end;


function FrameFunc: Boolean;
var
 I:integer;
begin
  GetMouseEvent;
  HGE.Input_GetMousePos(Mx, My);
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
  Canvas.Draw(Images.Image['Background'],0,0,0,Blend_Default);
  SpriteEngine.Draw;
  SpriteEngine.Move(1);
  Font.Print(200,200,inttostr(hge.Timer_GetFPS));
  Font.Print(240,500, 'Mouse Left:  Select  and  Move');
  Font.Print(240,525, 'Mouse Right:  Disable Select');

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
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP,32);
  HGE.System_SetState(HGE_TEXTUREFILTER, true);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  HGE.System_SetState(HGE_HIDEMOUSE, False);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  SpriteEngine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Images.LoadFromFile('Background.jpg');
    Images.LoadFromFile('Bird.png',64,64);
    Font := TSysFont.Create;
    Font.CreateFont('Arial',12,[]);
    for I := 0 to MaxUnits do
    begin
          MySprite[I] := TMySprite.Create(SpriteEngine);
          with MySprite[I] do
          begin
               AnimStart := Random(7);
               SetAnim('Bird',0 ,8, 0.25, True, False, True);
               X := Random(750);
               Y := Random(500);
               FBright:=0;
               Z:=100;
               SetColor(128, 128, 128);
               BlendMode := Blend_Bright;
          end;
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
