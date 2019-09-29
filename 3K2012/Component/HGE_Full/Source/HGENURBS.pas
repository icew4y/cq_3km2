unit HGENURBS;
(*
** HGE NURBS helper class
** Extension to the HGE engine
** Extension added by DraculaLin
** This extension is NOT part of the original HGE engine.
*)

interface

uses
  HGE, SysUtils,  Math, HGEDef;

type
  TFittingCurveType = (fcConstantParameter, fcConstantSpeed);
  TNDrawMode = (dmNone, dmCurve, dmCurveCP, dmCurveCPHull);

  PEditPoint2 = ^TEdiTPoint2;
  TEditPoint2 = record
    X, Y: Integer;
    Radius: Integer;
    Active: Boolean;
  end;

  TNURBSCurve = class
  private
    FCPCount: Integer;
    FKnotsCount: Integer;
    FOrderOfCurve: Integer;
    FParameterStart: Single;
    FParameterEnd: Single;
    FSegments: Integer;
    FFittingCurveType: TFittingCurveType;
    FFittingCurveReady: Boolean;
    function BSFunction(KnotIndex: Integer; OrderOfCurve: Integer;
        Parameter: Single): Single;
    function CalcXY(Parameter: Single): TPoint2;
    function GetSegmentLength(Index1, Index2: Integer): Single;
    function GetCurveLength: Single;
    procedure SetSegments(const Value: Integer);
    procedure SetFittingCurveType(const Value: TFittingCurveType);
  public
    ControlPoints: array of TPoint2;
    KnotsVector: array of Single;
    FittingCurve: array of TPoint2;
    property Segments: Integer read FSegments write SetSegments;
    property FittingCurveType: TFittingCurveType read FFittingCurveType write SetFittingCurveType;
    property FittingCurveReady: Boolean read FFittingCurveReady write FFittingCurveReady;
    property CurveLength: Single read GetCurveLength;
    property CPCount: Integer read FCPCount write FCPCount;
    property KnotsCount: Integer read FKnotsCount write FKnotsCount;
    property OrderOfCurve: Integer read FOrderOfCurve write FOrderOfCurve;
    property ParameterStart: Single read FParameterStart write FParameterStart;
    property ParameterEnd: Single read FParameterEnd write FParameterEnd;
    procedure SetFittingCurve;
    function GetXY(Parameter: Single): TPoint2; {Parameter = [0,1]}
    function GetTangent(Parameter: Single): Single; {Parameter = [0,1]}
    procedure UpdateKnots;
    constructor Create(var AControlPoints: array of TPoint2); overload;
    constructor Create; overload;
    destructor Destroy; override;
  end;

  TNURBSCurveEx = class(TNURBSCurve)
  private
    FColor: Cardinal;
    FCPRadius: Integer;
    FCPColor: Cardinal;
    FCPIndex: Integer;
    FHullColor: Cardinal;
    FDragMode: Boolean;
    FDrawMode: TNDrawMode;
  public
    property CPIndex: Integer read FCPIndex write FCPIndex;
    property CPRadius: Integer read FCPRadius write FCPRadius;
    property CPColor : Cardinal read FCPColor write FCPColor;
    property HullColor : Cardinal read FHullColor write FHullColor;
    property DragMode: Boolean read FDragMode write FDragMode;
    property DrawMode: TNDrawMode read FDrawMode write FDrawMode;
    property Color: Cardinal read FColor write FColor;
    function CreateCP(X, Y: Integer): Integer;
    function GetCP(X, Y: Integer): Integer;
    procedure DeleteCP;
    procedure Draw;
    procedure SwitchDrawMode;
    procedure LoadCurve(Filename: String);
    procedure SaveCurve(Filename: String);
    procedure LoadBakeCurve(Filename: String);
    procedure SaveBakeCurve(Filename: String);
    procedure Update;
    constructor Create; overload;
    constructor Create(var AControlPoints: array of TPoint2); overload;
    destructor Destroy; override;
  end;


{ TNURBSCurves = class(TCollection)       ..... anyone? ))
  private
    NURBSCurves: array of TNURBSCurveEx;
    Archive: TASDb;
    function GetItem(Index: Integer): TNURBSCurve;
    function GetNURBS(const Name: string): TNURBSCurve;
    procedure SetItem(Index: Integer; const Value: TNURBSCurve);
    function GetItemCount(): Integer;
  public
    property Items[Index: Integer]: TNURBSCurve read GetItem; default;
    property ItemCount: Integer read GetItemCount;
    property NURBS[const Name: string]: TNURBSCurve read GetNURBS;
    function IndexOf(Element: TNURBSCurve): Integer; overload;
    function IndexOf(const Name: string): Integer; overload;
    function Include(Element: TNURBSCurve): Integer;
    procedure Remove(Index: Integer);
    procedure RemoveAll();
    procedure LoadFromASDb(Key: string; Archive: TASDb);
    procedure SaveToASDb(Key: string; Archive: TASDb);
    function LoadFromFile(const FileName: string): Integer;
    function SaveToFile(const FileName: string): Integer;
    destructor Destroy; override;
    constructor Create(); override;
  end;

var
  nurbs: TNURBSCurves = nil;}
 //function Point2(x, y: Single): TPoint2;

const
  BAKE_EXT = '.bake';


implementation

var
  FHGE: IHGE=nil;

{TNURBSCurve}

// ==========================================================================
constructor TNURBSCurve.Create(var AControlPoints: array of TPoint2);
var
  i: Integer;
begin
  OrderOfCurve := 4;  // OrderOfCurve + 1 actually, so 4 means 'cubic'
  CPCount := Length(AControlPoints);
  SetLength(ControlPoints, CPCount);
  for i:= 0 to CPCount-1 do
    begin
      ControlPoints[i].x := AControlPoints[i].x;
      ControlPoints[i].y := AControlPoints[i].y;
    end;
  Segments := 200;
  FittingCurveType := fcConstantParameter;  //fcConstantSpeed;
  FittingCurveReady := false;
  UpdateKnots;
end;

// ==========================================================================
constructor TNURBSCurve.Create;
begin
  FHGE := HGECreate(HGE_VERSION);
  OrderOfCurve := 4;
  CPCount := 0;
  SetLength(ControlPoints, CPCount);
  Segments := 100;
  FittingCurveType := fcConstantParameter;
  FittingCurveReady := false;
  UpdateKnots;
end;

// ==========================================================================
destructor TNURBSCurve.Destroy;
begin
  ControlPoints := nil;
  KnotsVector := nil;
  FittingCurve := nil;
  inherited;
end;

// ==========================================================================
function TNURBSCurve.BSFunction(KnotIndex, OrderOfCurve: Integer;
  Parameter: Single): Single;
var FirstItem, SecondItem, denominator, numerator: Single;
begin
  if (Parameter >= KnotsVector[KnotIndex + OrderOfCurve]) or
     (Parameter < KnotsVector[KnotIndex]) then BSFunction := 0
  else
    if OrderOfCurve = 1 then
      if (Parameter <= KnotsVector[KnotIndex + 1]) and
         (Parameter >= KnotsVector[KnotIndex]) then BSFunction := 1
      else Result := 0
    else
      begin
        {FirstItem}
        denominator := KnotsVector[KnotIndex + OrderOfCurve - 1] - KnotsVector[KnotIndex];
        if denominator = 0 then FirstItem := 0
          else
            begin
              numerator := Parameter - KnotsVector[KnotIndex];
              if numerator = 0 then FirstItem := 0
                else FirstItem := (numerator/denominator)*
                  BSFunction(KnotIndex, (OrderOfCurve - 1), Parameter);
            end;
        {SecondItem}
        denominator := KnotsVector[KnotIndex + OrderOfCurve] - KnotsVector[KnotIndex + 1];
        if denominator = 0 then SecondItem := 0
          else
            begin
              numerator := KnotsVector[KnotIndex + OrderOfCurve] - Parameter;
              if numerator = 0 then SecondItem := 0
                else SecondItem := (numerator/denominator)*
                  BSFunction((KnotIndex + 1), (OrderOfCurve - 1), Parameter);
            end;
        BSFunction := FirstItem + SecondItem;
      end;
end;

// ==========================================================================
function TNURBSCurve.CalcXY(Parameter: Single): TPoint2;
var
  i: Integer;
  Value: TPoint2;
  N, CheckSumm: Single;
begin
  Value.x := 0;
  Value.y := 0;
  CheckSumm := 0;
  for i := 0 to CPCount - 1 do
    begin
      N := BSFunction(i, (OrderOfCurve), Parameter);
      Value := Value + ControlPoints[i]*N;
      CheckSumm := CheckSumm + N;
    end;
  Result.X :=  Value.x/CheckSumm;
  Result.Y :=  Value.y/CheckSumm;
  // some bug here: CheckSumm of last element is time to time equal to zero
  // some fix: FittingCurve[Segments - 1].XY :=  ControlPoints[CPCount - 1].XY;
  if Parameter >= ParameterEnd then
    begin
      Result.X :=  ControlPoints[CPCount - 1].X;
      Result.Y :=  ControlPoints[CPCount - 1].Y;
    end;
end;

// ==========================================================================
procedure TNURBSCurve.SetFittingCurve;
var
  i: Integer;
  Parameter: array of Single;
  Parameter2, SegmentLength, Parameter2Delta, temp: Single;
begin
  case FittingCurveType of
    fcConstantParameter:
      begin
        SetLength(Parameter, Segments);
        Parameter[0] := ParameterStart;
        for i := 1 to Segments - 1 do
          Parameter[i] := Parameter[i-1] + (ParameterEnd - ParameterStart)/(Segments-1);
        for i := 0 to Segments - 1 do
          FittingCurve[i] := CalcXY(Parameter[i]);
        FittingCurve[Segments - 1].X :=  ControlPoints[CPCount - 1].X;
        FittingCurve[Segments - 1].Y :=  ControlPoints[CPCount - 1].Y;
      end;
    fcConstantSpeed:
      begin
        Parameter2 := ParameterStart;
        // getting CurveLength
        FittingCurveType := fcConstantParameter;
        SetFittingCurve;
        FittingCurveType := fcConstantSpeed;
        SegmentLength := CurveLength/(Segments-1);
        Parameter2Delta := SegmentLength/Segments/100;
        FittingCurve[0].X := ControlPoints[0].X;
        FittingCurve[0].Y := ControlPoints[0].Y;
        for i := 0 to Segments - 2 do
          begin
            temp := 0;
            repeat
              FittingCurve[i] := CalcXY(Parameter2);
              Parameter2 := Parameter2 + Parameter2Delta;
              if Parameter2 >= ParameterEnd then break;
            temp := GetSegmentLength(i-1, i);
            until temp >= SegmentLength;;
          end;
        FittingCurve[Segments - 1].X :=  ControlPoints[CPCount - 1].X;
        FittingCurve[Segments - 1].Y :=  ControlPoints[CPCount - 1].Y;
      end;
  end;
  FittingCurveReady := True;
  Parameter := nil;
end;

// ==========================================================================
procedure TNURBSCurve.SetFittingCurveType(const Value: TFittingCurveType);
begin
  FFittingCurveType := Value;
end;

// ==========================================================================
procedure TNURBSCurve.SetSegments(const Value: Integer);
begin
  FSegments := Value;
  SetLength(FittingCurve, Segments);
end;

// ==========================================================================
procedure TNURBSCurve.UpdateKnots;
var
  i: Integer;
begin
  KnotsCount := CPCount + OrderOfCurve;
  SetLength(KnotsVector, KnotsCount);
  for i := 0 to CPCount - 1 do
    KnotsVector[i + OrderOfCurve - 1] := i;
  for i := (KnotsCount - OrderOfCurve) to KnotsCount - 1 do
    KnotsVector[i] := KnotsVector[KnotsCount - OrderOfCurve];
  ParameterStart := KnotsVector[0];
  ParameterEnd := KnotsVector[KnotsCount - 1];
end;

// ==========================================================================
function TNURBSCurve.GetCurveLength: Single;
begin
  if not FittingCurveReady then SetFittingCurve;
  Result := GetSegmentLength(1,Segments - 1);
end;

// ==========================================================================
function TNURBSCurve.GetSegmentLength(Index1, Index2: Integer): Single;
var
  i: Integer;
begin
  if not FittingCurveReady then SetFittingCurve;
  Result := 0;
  for i := Index1 to Index2 - 1 do
    Result := Result + Length2(Point2(FittingCurve[i].x, FittingCurve[i].y) -
                               Point2(FittingCurve[i+1].x, FittingCurve[i+1].y));
end;

// ==========================================================================
function TNURBSCurve.GetTangent(Parameter: Single): Single;
var
  Index: Integer;
  ParameterDetla: Single;
  p1, p2: TPoint2;
begin
  case FittingCurveType of
    fcConstantParameter:
      begin
        ParameterDetla := 0.001;
        if (Parameter >= 1) {or (Parameter + ParameterDetla >= 1)} then
          Parameter := Parameter - ParameterDetla;
        p1 := CalcXY(Parameter*ParameterEnd);
        p2 := CalcXY(Parameter*ParameterEnd + ParameterDetla);
        Result := Angle2(p2 - p1);
      end;
    fcConstantSpeed:
      begin
        Index := Trunc(Parameter*Segments);
        if Index >= Segments - 1 then Index := Segments - 2;
        Result := Angle2(FittingCurve[Index+1] - FittingCurve[Index]);
      end;
  end;
end;

// ==========================================================================
function TNURBSCurve.GetXY(Parameter: Single): TPoint2;
var
  Index: Integer;
  k, Residue, Span : Single;
begin
  case FittingCurveType of
    fcConstantParameter:  Result := CalcXY(Parameter*ParameterEnd);
    fcConstantSpeed:
      begin
        Index := Trunc(Parameter*Segments);
        if Index > Segments - 2 then
          begin
            Result.X := FittingCurve[Segments - 1].X;
            Result.Y := FittingCurve[Segments - 1].Y;
            Exit;
        end;
        Residue := Parameter*Segments - Index;
        k := FittingCurve[Index+1].Y - FittingCurve[Index].Y;
        k := k / (FittingCurve[Index+1].X - FittingCurve[Index].X);
        Span := GetSegmentLength(Index, Index+1);
        Span := Span * Residue;
        Result.X := Span * Cos(ArcTan2(k,1));
        Result.Y := Span * Sin(ArcTan2(k,1));
        if FittingCurve[Index+1].X > FittingCurve[Index].X then
          begin
            Result.X := FittingCurve[Index].X + Result.X;
            Result.Y := FittingCurve[Index].Y + Result.Y;
          end
        else
          begin
            Result.X := FittingCurve[Index].X - Result.X;
            Result.Y := FittingCurve[Index].Y - Result.Y;
          end;
      end;
  end;
end;


{ TNURBSCurveEX }

// ==========================================================================
constructor TNURBSCurveEX.Create(var AControlPoints: array of TPoint2);
begin
  inherited;
  Color := $FFFFFFFF;
  CPColor := $FFFFFFFF;
  CPRadius := 10;
  HullColor := $FFFFFFFF;
  DragMode := false;
  DrawMode := dmCurveCPHull;
  CPIndex := 0;
end;

// ==========================================================================
constructor TNURBSCurveEX.Create;
begin
  inherited;
  Color := $FFFFFFFF;
  CPColor := $FFFFFFFF;
  CPRadius := 10;
  HullColor := $FFFFFFFF;
  DragMode := false;
  DrawMode := dmCurveCPHull;
  CPIndex := 0;
end;

// ==========================================================================
function TNURBSCurveEX.CreateCP(X, Y: Integer): Integer;
begin
  CPCount := CPCount + 1;
  SetLength(ControlPoints, CPCount);
  ControlPoints[CPCount - 1].X := X;
  ControlPoints[CPCount - 1].Y := Y;
  Result := CPCount - 1;
  UpdateKnots;
end;

// ==========================================================================
procedure TNURBSCurveEX.DeleteCP;
begin
  if CPCount = 1 then Exit;
  CPCount := CPCount - 1;
  SetLength(ControlPoints, CPCount);
  UpdateKnots;
end;

// ==========================================================================
destructor TNURBSCurveEX.Destroy;
begin
  inherited;
end;

// ==========================================================================
procedure TNURBSCurveEX.Draw;
var
  i: Integer;
begin
  case DrawMode of
    dmNone: begin end;
    dmCurve: begin
      if CPCount > 4 {BaseCurve.FOrderOfCurve} then
        for i := 1 to Segments - 1 do
          FHGE.Gfx_RenderLine(FittingCurve[i-1].x, FittingCurve[i-1].y,
                        FittingCurve[i].x, FittingCurve[i].y,
                        Color);
    end;
    dmCurveCP: begin
      for i := 0 to CPCount - 1 do
        FHGE.Circle(ControlPoints[i].X, ControlPoints[i].Y, CPRadius, $FFFFFFFF, False);
          if CPCount > 4 {BaseCurve.FOrderOfCurve} then
            for i := 1 to Segments - 1 do
               FHGE.Gfx_RenderLine(FittingCurve[i-1].x, FittingCurve[i-1].y,
                            FittingCurve[i].x, FittingCurve[i].y,
                            Color);
    end;
    dmCurveCPHull: begin
      for i := 0 to CPCount - 1 do
        FHGE.Circle(ControlPoints[i].X, ControlPoints[i].Y, CPRadius, $FFFFFFFF, False);
          if CPCount > 4 {BaseCurve.FOrderOfCurve} then
            for i := 1 to Segments - 1 do
               FHGE.Gfx_RenderLine(FittingCurve[i-1].x, FittingCurve[i-1].y,
                            FittingCurve[i].x, FittingCurve[i].y,
                            Color);
      for i := 1 to CPCount - 1 do
         FHGE.Gfx_RenderLine(ControlPoints[i-1].X, ControlPoints[i-1].Y,
                           ControlPoints[i].X, ControlPoints[i].Y,
                      HullColor);
    end;
  end;
end;

// ==========================================================================
function TNURBSCurveEX.GetCP(X, Y: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to CPCount-1 do
    if CPRadius >= sqrt((ControlPoints[i].X - X)*(ControlPoints[i].X - X) +
                                   (ControlPoints[i].Y - Y)*(ControlPoints[i].Y - Y)) then
      begin
        Result := i;
        Exit;
      end;
end;

// ==========================================================================
procedure TNURBSCurveEX.LoadBakeCurve(Filename: String);
var
  i: Integer;
  SFile: file of TPoint2;
begin
  AssignFile(SFile, Filename);
  Reset(SFile);
  Segments := FileSize(SFile);
  SetLength(FittingCurve, Segments);
  for i := 0 to Segments - 1  do
    Read(SFile, FittingCurve[i]);
  CloseFile(SFile);
  FittingCurveReady := True;
end;

// ==========================================================================
procedure TNURBSCurveEX.LoadCurve(Filename: String);
var
  i: Integer;
  SFile: file of TPoint2;
  Point: TPoint2;
begin
  AssignFile(SFile, Filename);
  Reset(SFile);
  CPCount := FileSize(SFile);
  SetLength(ControlPoints, CPCount);
  for i := 0 to CPCount - 1  do
    begin
      Read(SFile, Point);
      ControlPoints[i].X := Point.X;
      ControlPoints[i].Y := Point.Y;
    end;
  CloseFile(SFile);
  FittingCurveReady := False;
  UpdateKnots;
  if FileExists(Filename + BAKE_EXT) then LoadBakeCurve(Filename + BAKE_EXT);
end;

// ==========================================================================
procedure TNURBSCurveEX.SaveBakeCurve(Filename: String);
var
  i: Integer;
  SFile: file of TPoint2;
begin
  AssignFile(SFile, Filename + BAKE_EXT);
  Rewrite(SFile);
  for i := 0 to Segments - 1  do
    Write(SFile, FittingCurve[i]);
  CloseFile(SFile);
end;

// ==========================================================================
procedure TNURBSCurveEX.SaveCurve(Filename: String);
var
  i: Integer;
  SFile: file of TPoint2;
begin
  AssignFile(SFile, FILENAME);
  Rewrite(SFile);
  for i := 0 to CPCount - 1  do
    Write(SFile, ControlPoints[i]);
    CloseFile(SFile);
  if FileExists(Filename + BAKE_EXT) then DeleteFile(Filename + BAKE_EXT);
  if FittingCurveReady and (FittingCurveType = fcConstantSpeed) then
    SaveBakeCurve(Filename);
end;

// ==========================================================================
procedure TNURBSCurveEx.SwitchDrawMode;
begin
  case DrawMode of
    dmNone: DrawMode := dmCurve;
    dmCurve: DrawMode := dmCurveCP;
    dmCurveCP: DrawMode := dmCurveCPHull;
    dmCurveCPHull: DrawMode := dmNone;
  end;
end;

// ==========================================================================
procedure TNURBSCurveEx.Update;
var
  i: Integer;
  points: array of TPoint2;
begin
  if CPCount > 4 {BaseCurve.FOrderOfCurve} then
    begin
      SetLength(points, CPCount);
      for i := 0 to CPCount - 1 do
        begin
          points[i].x := ControlPoints[i].X;
          points[i].y := ControlPoints[i].Y;
        end;
      SetFittingCurve;
    end;
  points := nil;    
end;

initialization
  FHGE := nil;

end.
