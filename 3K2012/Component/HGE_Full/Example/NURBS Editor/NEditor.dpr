program NEditor;

{$R *.res}

uses
  Windows, SysUtils, HGE, HGENURBS, Graphics;

const
  CURVE_FILE = 'nurbs.data';

var
  HGE: IHGE = nil;
  Font: TSysFont;
  Curve: TNURBSCurveEx;
  Parameter1: Single;
  ParameterDelta: Single =  0.001;
  Moving, Loop: boolean;
  ShowHelp, ShowFish, ShowFishHelp, ShowFPS, ShowParams, ShowInfo, Tab: boolean;
  MouseX, MouseY: Single;

procedure DrawPointer;
begin
  HGE.Circle(Curve.GetXY(Parameter1).X, Curve.GetXY(Parameter1).Y, 10, ARGB(255,255,0,0),False);
end;

procedure DrawTangent;
var
  s: Single;
begin
  s := Curve.GetTangent(Parameter1);
  HGE.Gfx_RenderLine(Curve.GetXY(Parameter1).X,Curve.GetXY(Parameter1).Y,
                   Curve.GetXY(Parameter1).X + cos(s)*50,Curve.GetXY(Parameter1).Y + sin(s)*50,
                            ARGB(255,255,0,0));
end;

function FrameFunc: Boolean;
begin
  HGE.Input_GetMousePos(MouseX, MouseY);
  if Moving then
  begin
    if Curve.CPCount < 4 then Exit;
    Parameter1 := Parameter1 + ParameterDelta;
    if Parameter1 > 1 then
        if Loop then
          Parameter1 := 0
        else
          begin
            Parameter1 := 1;
            Moving := false;
          end;
      if Parameter1 < 0 then
        if Loop then
          Parameter1 := 1
        else
          begin
            Parameter1 := 0;
            Moving := false;
        end;     
  end;
  //
  if Curve.DragMode then
  begin
    Curve.ControlPoints[Curve.CPIndex].X := MouseX;
    Curve.ControlPoints[Curve.CPIndex].Y := MouseY;
    Curve.Update;
  end;
  if HGE.Input_KeyUp(HGEK_LBUTTON) or HGE.Input_KeyUp(HGEK_RBUTTON) then
  begin
    if Curve.DragMode then
    begin
      Curve.DragMode := false;
      Curve.CPIndex := -1;
    end;
  end;
  //
  if HGE.Input_GetKeyState(HGEK_LEFT) then
  begin
    Parameter1 := Parameter1 - ParameterDelta;
    if Parameter1 < 0 then
      if Loop then Parameter1 := 1
       else Parameter1 := 0;
  end;
  if HGE.Input_GetKeyState(HGEK_RIGHT) then
  begin
    Parameter1 := Parameter1 + ParameterDelta;
      if Parameter1 > 1 then
        if Loop then Parameter1 := 0
        else Parameter1 := 1;
  end;
  if HGE.Input_GetKeyState(HGEK_UP) then
  begin
     Parameter1 := 0;
     Moving := False;
  end;
  if HGE.Input_GetKeyState(HGEK_DOWN) then
  begin
    Parameter1 := 1;
    Moving := False;
  end;
  if HGE.Input_GetKeyState(HGEK_PGUP) then
      ParameterDelta := ParameterDelta + 0.00004;
  if HGE.Input_GetKeyState(HGEK_PGDN) then
      ParameterDelta := ParameterDelta - 0.00004;
  if HGE.Input_GetKeyState(HGEK_HOME) then
     Parameter1 := 0;
  if HGE.Input_GetKeyState(HGEK_END) then
     Parameter1 := 1;
  //
  case HGE.Input_GetKey of
    HGEK_ENTER: Moving := not Moving;
    HGEK_INSERT: Loop := not Loop;
    HGEK_DELETE: ParameterDelta :=  0.001;
    HGEK_1:
    begin
      Curve.Segments := 50;
      if Curve.CPCount > 4 then Curve.SetFittingCurve;
    end;
    HGEK_2:
    begin
      Curve.Segments := 100;
      if Curve.CPCount > 4 then Curve.SetFittingCurve;
    end;
    HGEK_3:
    begin
      Curve.Segments := 200;
      if Curve.CPCount > 4 then Curve.SetFittingCurve;
    end;
    HGEK_4:
    begin
      Curve.Segments := 400;
      if Curve.CPCount > 4 then Curve.SetFittingCurve;
    end;
    HGEK_5:
    begin
      Curve.Segments := 800;
      if Curve.CPCount > 4 then Curve.SetFittingCurve;
    end;
    HGEK_6:
    begin
      Curve.Segments := 1600;
      if Curve.CPCount > 4 then Curve.SetFittingCurve;
    end;
    HGEK_7:
    begin
      Curve.Segments := 3200;
      if Curve.CPCount > 4 then Curve.SetFittingCurve;
    end;
    HGEK_F: ShowFPS := not ShowFPS;
    HGEK_G: ShowParams := not ShowParams;
    HGEK_H: ShowHelp := not ShowHelp;
    HGEK_I: ShowInfo := not ShowInfo;
    HGEK_J: ShowFishHelp := not ShowFishHelp;
    HGEK_K: ShowFish := not ShowFish;
    HGEK_TAB:
    begin
      ShowFPS := false;
      ShowParams := false;
      ShowHelp := false;
      ShowInfo := false;
      ShowFishHelp := false;
      ShowFish := false;
    end;     
    HGEK_SPACE:  Curve.SwitchDrawMode;
    HGEK_F1: Curve.FittingCurveType := fcConstantParameter;
    HGEK_F2: Curve.FittingCurveType := fcConstantSpeed;
    HGEK_ADD:
    begin
      Curve.Segments := Curve.Segments + 1;
      Curve.SetFittingCurve;
    end;
    HGEK_SUBTRACT:
    begin
      Curve.Segments := Curve.Segments - 1;
      if Curve.Segments < 1 then Curve.Segments := 1;
      Curve.SetFittingCurve;
    end;
    HGEK_F4: Curve.SaveCurve(CURVE_FILE);
    HGEK_F5: Curve.LoadCurve(CURVE_FILE);
    HGEK_F8: Curve.SaveBakeCurve(CURVE_FILE);
    HGEK_F9: Curve.LoadBakeCurve(CURVE_FILE);
    HGEK_BACKSPACE:
    begin
      Curve.DeleteCP;
      Curve.SetFittingCurve;
    end; 
    HGEK_ESCAPE:
    begin
      FreeAndNil(Curve);
      FreeAndNil(Font);
      Result := True;
      Exit;
    end;
  end;
  if HGE.Input_KeyDown(HGEK_LBUTTON) then
  begin
    Curve.CPIndex := Curve.CreateCP(Trunc(MouseX), Trunc(MouseY));
    Curve.DragMode := True;
    Curve.Update;
  end;
  if HGE.Input_KeyDown(HGEK_RBUTTON) then
  begin
    if Curve.GetCP(Trunc(MouseX),Trunc(MouseY)) >= 0 then
    begin
      Curve.CPIndex := Curve.GetCP(Trunc(MouseX), Trunc(MouseY));
      Curve.DragMode := True;
      Curve.Update;
    end;
  end;

  Result := False;
end;

function RenderFunc: Boolean;
begin
  HGE.Gfx_BeginScene;
  HGE.Gfx_Clear(0);
  Curve.Draw;
  if ShowFPS then
    Font.Print(4, 4,'FPS: ' + IntToStr(HGE.Timer_GetFPS), 255,255,0,255)
  else
    Font.Print(736, 4,'[F]', 255,255,0,255);

  if ShowFish then
    if Curve.CPCount > 4 then
      begin
        DrawPointer;
        DrawTangent;
      end
    else begin end
  else
    Font.Print(650, 4,'[K]', 255,255,0,255);;

  if ShowParams then
  begin
    if Curve.CPCount > 4 then
       Font.Print(80, 50, 'Length = ' + FloatToStr(Curve.CurveLength), 255,255,0,255)
    else
       Font.Print(80, 50, 'Length = ...',255,255,0,255 );

    if Curve.FittingCurveType = fcConstantParameter then
        Font.Print(80, 70, 'FittingType = ConstantParameter', 255,255,0,255)
    else
        Font.Print(80, 70, 'FittingType = ConstantSpeed', 255,255,0,255);

    Font.Print(80, 30, 'Segments = ' + IntToStr(Curve.Segments),255,255,0,255);
    Font.Print(80, 100, 'Parameter = ' + FloatToStr(Parameter1),255,255,0,255);
    Font.Print(80, 120, 'ParameterDelta = ' + FloatToStr(ParameterDelta), 255,255,0,255);
  end
  else
    Font.Print(705, 4,'[G]', 255,255,0,255);
  //
  if ShowHelp then
  begin
    Font.Print(16, 400, '"LMB": Add Control Point', 255,255,0,255);
    Font.Print(16, 420, '"RMB+Drag": Select and Move Control Point',255,255,0,255);
    Font.Print(16, 440, '"Backspace": Delete Control Point',255,255,0,255);
    Font.Print(16, 460, '"NUMPAD +/-": Increase/Decrease Segments',255,255,0,255);
    Font.Print(16, 480, '"1-6": Segmets = (50,100,200,400,800,1600,3200)',255,255,0,255);
    Font.Print(16, 500, '"Space": to change DrawType', 255,255,0,255);
    Font.Print(16, 520, '"F1/F2": Change FittingCurveType',255,255,0,255);
    Font.Print(16, 540, '"F4/F5": Save/Load Curve',255,255,0,255);
    Font.Print(16, 560, '"F,G,H,J,K,I": Toggle FPS/Params/Help/Help2/Pointer/Info', 255,255,0,255);
  end
  else
    Font.Print(764, 4,'[H]',255,255,0,255);
  //
  if ShowFishHelp then
  begin
    Font.Print(16, 200, '"Left, Right": Inc/Dec Parameter',255,255,0,255);
    Font.Print(16, 220, '"Enter": Toggle Move',255,255,0,255);
    Font.Print(16, 240, '"Up, Down": Parameter = (0,1); Stop',255,255,0,255);
    Font.Print(16, 260, '"PGUp, PGDown": Inc/Dec ParamDelta (Speed)',255,255,0,255);
    Font.Print(16, 280, '"Home, End": Parameter = (0,1); Keep Moving',255,255,0,255);
    Font.Print(16, 300, '"Insert": Toggle Loop', 255,255,0,255);
    Font.Print(16, 320, '"Delete": Reset ParamDelta',255,255,0,255);
  end
  else
    Font.Print(679, 4,'[J]',255,255,0,255);

  if ShowInfo then
    begin
      Font.Print(380, 200, 'You may use this one as NURBS Editor',255,255,0,255);
      Font.Print(480, 244, '(Ctrl+Tab)', 255,255,0,255);
    end
  else
    Font.Print(624, 4,'[I]',255,255,0,255);

  Font.Print(16,380,'"Enter": Run',255,255,0,255);
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
  HGE.System_SetState(HGE_SCREENBPP,16);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  HGE.System_SetState(HGE_HIDEMOUSE, False);

  if (HGE.System_Initiate) then
  begin
    Font:=TSysFont.Create;
    Font.CreateFont('arial',14,[]);
    Curve := TNURBSCurveEx.Create;
    Curve.DrawMode := dmCurveCPHull;
    Curve.Segments := 200;
    Curve.Color := ARGB(255,0,255,0);
    Curve.CPRadius := 10;
    Curve.CPColor := ARGB(255,0,255,255);
    Curve.HullColor := $FFFF8020;
    Moving := False;
    Loop := True;
    ShowFPS := False;
    ShowHelp := True;
    ShowFish := True;
    ShowFishHelp := False;
    ShowInfo := False;
    ShowParams := True;
    Tab := True;

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
