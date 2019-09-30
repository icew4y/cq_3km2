program MouseEvent;

{$R *.res}

uses
  Windows, SysUtils, HGEImages, HGECanvas, HGEDef, HGE, Classes, HGESpriteEngine;

type
  TMoveDirection=(mdLeft,mdRight);

  TSheep=class(TAnimatedSprite)
  private
     FMoveSpeed: Single;
     FMoveDirection: TMoveDirection;
  public
     procedure DoMove(const MoveCount: Single); override;
     procedure OnLMouseDown; override;
     procedure OnMouseDbClick; override;
     procedure OnMouseLeave; override;
     procedure OnMouseEnter; override;
     procedure OnMouseDrag; override;
     procedure OnRMouseDown; override;
     procedure OnMouseWheelDown; override;
     procedure OnAnimEnd; override;
     property MoveSpeed: Single read  FMoveSpeed write  FMoveSpeed;
     property MoveDirection: TMoveDirection read FMoveDirection write FMoveDirection;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Font: TSysFont;
  SpriteEngine: TSpriteEngine;
  OffsetW,OffsetH: Integer;
  Mx,My: Single;

procedure TSheep.OnMouseEnter;
begin
     SetColor(255,150,255);
end;

procedure TSheep.OnMouseLeave;
begin
     Setcolor(255,255,255);
end;

procedure TSheep.OnLMouseDown;
begin
    OffsetW:= Round(X-Mx);
    OffsetH:= Round(Y-My);
    X:= Mx + OffsetW;
    Y:= My + OffsetH;
    SetAnim('Scare', 0, 6, 0.1, True);
    FMoveSpeed:= 0.5;
end;

procedure TSheep.OnMouseDbClick;
begin
     SetAnim('Run', 0, 2, 0.1, True);
     FmoveSpeed:=1;
end;

procedure TSheep.OnMouseDrag;
begin
     X:= Mx+OffsetW;
     Y:= My+OffsetH;
     SetAnim('Scare', 0, 6, 0.1, True);
end;

procedure TSheep.OnRMouseDown;
begin
     SetAnim('HandStand', 0, 2, 0.1, True);
     FMoveSpeed:=0.5;
end;

procedure TSheep.OnMouseWheelDown;
begin
     SetAnim('Rolling', 0, 8, 0.15, True);
     FMoveSpeed:=1;
end;

procedure TSheep.DoMove(const movecount: Single);

begin
     DoMouseEvent;

     ActiveRect:=Rect(Round(X), Round(Y), Round(X+40), Round(Y+40));
     case FMoveDirection of
         mdLeft:
         begin
              X:=X-MoveSpeed;
              MirrorX:= True;
         end;
         mdRight:
         begin
              X:=X+ MoveSpeed;
              MirrorX:= False;
         end;
     end;

     if (X>750) then FMovedirection:= mdLeft;
     if (X<10)  then FMovedirection:= mdRight;
     inherited;
end;

procedure TSheep.OnAnimEnd;
begin
     if ImageName= 'Scare' then
        SetAnim('Walk', 0, 2, 0.1, True);
end;

function FrameFunc: Boolean;
begin
  GetMouseEvent;
  HGE.Input_GetMousePos(Mx,My);
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
  HGE.Gfx_Clear(0);
  Canvas.Draw(Images.Image['Background'],0,0,0,Blend_default);
  SpriteEngine.Draw;
  SpriteEngine.Move(1);
  SpriteEngine.Dead;
  //Font.Print(100,100,IntToStr(HGE.Timer_GetFPS));
  Font.Print(300,490,'Left Mouse: Scare');
  Font.Print(300,510,'Right Mouse: Hand Stand');
  Font.Print(300,530,'Mouse Double Click: Run');
  Font.Print(300,550,'Mouse Wheel: Rolling');
  Font.Print(300,570,'Mouse Drag: Move');
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
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  HGE.System_SetState(HGE_HIDEMOUSE, False);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  SpriteEngine := TSpriteEngine.Create(nil);
  Spriteengine.Images := Images;
  SpriteEngine.Canvas := Canvas;

  if (HGE.System_Initiate) then
  begin
    Font:=TSysFont.Create;
    Font.CreateFont('arial',12,[]);
    Images.LoadFromFile('Background.jpg');
    Images.LoadFromFile('Walk.png',40,40);
    Images.LoadFromFile('Run.png',40,40);
    Images.LoadFromFile('HandStand.png',40,40);
    Images.LoadFromFile('Scare.png',40,40);
    Images.LoadFromFile('Rolling.png',40,40);
    Randomize;
    for I := 0 to 20 do
     begin
          with TSheep.Create(SpriteEngine) do
          begin
               SetAnim('Walk',0,2,0.1,True);
               DoAnimate := True;
               Width := 40;
               Height:=40;
               X := Random(750);
               Y := Random(550);
               FMoveSpeed := 0.5;
               FMoveDirection := TMoveDirection(Random(2));
               Tag := I;
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
