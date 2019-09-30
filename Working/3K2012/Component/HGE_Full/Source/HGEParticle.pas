unit HGEParticle;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Delphi conversion by Erik van Bilsen
**
** NOTE: The Delphi version uses public IHGEParticleSystem and
** IHGEParticleManager interfaces instead of a classes (more conform the main
** IHGE interface).
*)

interface

(****************************************************************************
 * HGEParticle.h
 ****************************************************************************)

uses
  HGE, HGERect, HGEVector, HGEColor, HGESprite;
  
const
  MAX_PARTICLES  = 500;
  MAX_PSYSTEMS  = 100;

type
  THGEParticle = record
    Location: THGEVector;
    Velocity: THGEVector;

    Gravity: Single;
    RadialAccel: Single;
    TangentialAccel: Single;

    Spin: Single;
    SpinDelta: Single;

    Size: Single;
    SizeDelta: Single;

    Color: THGEColor;
    ColorDelta: THGEColor;

    Age: Single;
    TerminalAge: Single;
  end;
  PHGEParticle = ^THGEParticle;

type
  { Maps directly onto PSI files, 128 bytes }
  THGEParticleSystemInfo = record
    Sprite: IHGESprite;
    Emission: Integer;
    Lifetime: Single;

    ParticleLifeMin: Single;
    ParticleLifeMax: Single;

    Direction: Single;
    Spread: Single;
    Relative: Boolean;

    SpeedMin: Single;
    SpeedMax: Single;

    GravityMin: Single;
    GravityMax: Single;

    RadialAccelMin: Single;
    RadialAccelMax: Single;

    TangentialAccelMin: Single;
    TangentialAccelMax: Single;

    SizeStart: Single;
    SizeEnd: Single;
    SizeVar: Single;

    SpinStart: Single;
    SpinEnd: Single;
    SpinVar: Single;

    ColorStart: THGEColor;
    ColorEnd: THGEColor;
    ColorVar: Single;
    AlphaVar: Single;
  end;
  PHGEParticleSystemInfo = ^THGEParticleSystemInfo;

type
  IHGEParticleSystem = interface
  ['{69A7DF86-8F28-419C-B265-742E7CE4F78B}']
    function GetInfo: PHGEParticleSystemInfo;

    { NOTE: This replaces the C++ '=' operator }
    procedure Assign(const PS: IHGEParticleSystem);

    procedure Render;
    procedure FireAt(const X, Y: Single);
    procedure Fire;
    procedure Stop(const KillParticles: Boolean = False);
    procedure Update(const DeltaTime: Single);
    procedure MoveTo(const X, Y: Single; const MoveParticles: Boolean = False);
    procedure Transpose(const X, Y: Single);
    procedure TrackBoundingBox(const Track: Boolean);

    function GetParticlesAlive: Integer;
    function GetAge: Single;
    procedure GetPosition(out X, Y: Single);
    procedure GetTransposition(out X, Y: Single);
    function GetBoundingBox(out Rect: THGERect): PHGERect;

    function Implementor: TObject;

    property Info: PHGEParticleSystemInfo read GetInfo;
  end;

type
  IHGEParticleManager = interface
  ['{C1A425FF-BB58-4539-870B-70C917149E4D}']
    procedure Update(const DT: Single);
    procedure Render;

    function SpawnPS(const PSI: THGEParticleSystemInfo;
      const X, Y: Single): IHGEParticleSystem;
    function IsPSAlive(const PS: IHGEParticleSystem): Boolean;
    procedure Transpose(const X, Y: Single);
    procedure GetTransposition(out DX, DY: Single);
    procedure KillPS(const PS: IHGEParticleSystem);
    procedure KillAll;
  end;

type
  THGEParticleSystem = class(TInterfacedObject,IHGEParticleSystem)
  protected
    { IHGEParticleSystem }
    function GetInfo: PHGEParticleSystemInfo;
    procedure Assign(const PS: IHGEParticleSystem);

    procedure Render;
    procedure FireAt(const X, Y: Single);
    procedure Fire;
    procedure Stop(const KillParticles: Boolean = False);
    procedure Update(const DeltaTime: Single);
    procedure MoveTo(const X, Y: Single; const MoveParticles: Boolean = False);
    procedure Transpose(const X, Y: Single);
    procedure TrackBoundingBox(const Track: Boolean);

    function GetParticlesAlive: Integer;
    function GetAge: Single;
    procedure GetPosition(out X, Y: Single);
    procedure GetTransposition(out X, Y: Single);
    function GetBoundingBox(out Rect: THGERect): PHGERect;

    function Implementor: TObject;
  private
    class var
      FHGE: IHGE;
  private
    FInfo: THGEParticleSystemInfo;
    FAge: Single;
    FEmissionResidue: Single;
    FPrevLocation: THGEVector;
    FLocation: THGEVector;
    FTX, FTY: Single;
    FParticlesAlive: Integer;
    FBoundingBox: THGERect;
    FUpdateBoundingBox: Boolean;
    FParticles: array [0..MAX_PARTICLES - 1] of THGEParticle;
  public
    constructor Create(const Filename: String; const Sprite: IHGESprite); overload;
    constructor Create(const PSI: THGEParticleSystemInfo); overload;
    constructor Create(const PS: IHGEParticleSystem); overload;
    procedure DoUpdate(const DeltaTime: Single);
  end;

type
  THGEParticleManager = class(TInterfacedObject,IHGEParticleManager)
  protected
    { IHGEParticleManager }
    procedure Update(const DT: Single);
    procedure Render;

    function SpawnPS(const PSI: THGEParticleSystemInfo;
      const X, Y: Single): IHGEParticleSystem;
    function IsPSAlive(const PS: IHGEParticleSystem): Boolean;
    procedure Transpose(const X, Y: Single);
    procedure GetTransposition(out DX, DY: Single);
    procedure KillPS(const PS: IHGEParticleSystem);
    procedure KillAll;
  private
    FNPS: Integer;
    FTX: Single;
    FTY: Single;
    FPSList: array [0..MAX_PSYSTEMS - 1] of IHGEParticleSystem;
  public
    destructor Destroy; override;
  end;

implementation

uses
  HGEUtils;

(****************************************************************************
 * HGEParticle.h, HGEParticle.cpp, HGEParticleManager.cpp
 ****************************************************************************)

{ THGEParticleSystem }

procedure THGEParticleSystem.Assign(const PS: IHGEParticleSystem);
begin
  CopyInstanceData(PS.Implementor,Self);
end;

constructor THGEParticleSystem.Create(const Filename: String;
  const Sprite: IHGESprite);
var
  PSI: IResource;
  P: PByte;
begin
  inherited Create;
  FHGE := HGECreate(HGE_VERSION);
  PSI := FHGE.Resource_Load(Filename);
  if (PSI = nil) then
    Exit;
  P := PSI.Handle;
  Inc(P,4);
  Move(P^,FInfo.Emission,SizeOf(THGEParticleSystemInfo) - 4);
  PSI := nil;
  FInfo.Sprite := Sprite;
  FAge := -2;
  FBoundingBox.Clear;
end;

constructor THGEParticleSystem.Create(const PS: IHGEParticleSystem);
begin
  inherited Create;
  CopyInstanceData(PS.Implementor,Self);
  FHGE := HGECreate(HGE_VERSION);
end;

constructor THGEParticleSystem.Create(const PSI: THGEParticleSystemInfo);
begin
  inherited Create;
  FHGE := HGECreate(HGE_VERSION);
  Move(PSI.Emission,FInfo.Emission,SizeOf(THGEParticleSystemInfo) - 4);
  FInfo.Sprite := PSI.Sprite;
  FAge := -2;
  FBoundingBox.Clear;
end;

procedure THGEParticleSystem.DoUpdate(const DeltaTime: Single);
var
  I, ParticlesCreated: Integer;
  Ang, ParticlesNeeded: Single;
  Par: PHGEParticle;
  Accel, Accel2, Temp: THGEVector;
begin
  if (FAge >= 0) then begin
    FAge := FAge + DeltaTime;
    if (FAge >= FInfo.Lifetime) then
      FAge := -2;
  end;

  // update all alive particles

  if (FUpdateBoundingBox) then
    FBoundingBox.Clear;
  Par := @FParticles[0];

  I := 0;
  while (I < FParticlesAlive) do begin
    Par.Age := Par.Age + DeltaTime;
    if (Par.Age >= Par.TerminalAge) then begin
      Dec(FParticlesAlive);
      Par^:= FParticles[FParticlesAlive];
      Continue;
    end;

    Accel := Par.Location - FLocation;
    Accel.Normalize;
    Accel2 := Accel;
    Accel := Accel * Par.RadialAccel;

    // vecAccel2.Rotate(M_PI_2);
    // the following is faster
    Ang := Accel2.X;
    Accel2.X := -Accel2.Y;
    Accel2.Y := Ang;

    Accel2 := Accel2 * Par.TangentialAccel;
    Par.Velocity.Increment((Accel + Accel2) * DeltaTime);
    Par.Velocity.Y := Par.Velocity.Y + Par.Gravity * DeltaTime;

    Par.Location.Increment(Par.Velocity);

    Par.Spin := Par.Spin + (Par.SpinDelta * DeltaTime);
    Par.Size := Par.Size + (Par.SizeDelta * DeltaTime);
    Par.Color.Increment(Par.ColorDelta * DeltaTime);

    if (FUpdateBoundingBox) then
      FBoundingBox.Encapsulate(Par.Location.X,Par.Location.Y);

    Inc(Par);
    Inc(I);
  end;

  // generate new particles

  if (FAge <> -2) then begin
    ParticlesNeeded := FInfo.Emission * DeltaTime + FEmissionResidue;
    ParticlesCreated := Trunc(ParticlesNeeded);
    FEmissionResidue := ParticlesNeeded - ParticlesCreated;

    Par := @FParticles[FParticlesAlive];
    for I := 0 to ParticlesCreated - 1 do begin
      if (FParticlesAlive >= MAX_PARTICLES) then
        Break;

      Par.Age := 0;
      Par.TerminalAge := FHGE.Random_Float(FInfo.ParticleLifeMin,FInfo.ParticleLifeMax);

      Par.Location := (FLocation - FPrevLocation) * FHGE.Random_Float(0,1);
      Par.Location.Increment(FPrevLocation);
      Par.Location.X := Par.Location.X + FHGE.Random_Float(-2,2);
      Par.Location.Y := Par.Location.Y + FHGE.Random_Float(-2,2);

      Ang := FInfo.Direction - M_PI_2 + FHGE.Random_Float(0,FInfo.Spread) - FInfo.Spread / 2;
      if (FInfo.Relative) then begin
        Temp := FPrevLocation - FLocation;
        Ang := Ang + Temp.Angle + M_PI_2;
      end;
      Par.Velocity.X := Cos(Ang);
      Par.Velocity.Y := Sin(Ang);
      Par.Velocity.Scale(FHGE.Random_Float(FInfo.SpeedMin,FInfo.SpeedMax));

      Par.Gravity := FHGE.Random_Float(FInfo.GravityMin,FInfo.GravityMax);
      Par.RadialAccel := FHGE.Random_Float(FInfo.RadialAccelMin,FInfo.RadialAccelMax);
      Par.TangentialAccel := FHGE.Random_Float(FInfo.TangentialAccelMin,FInfo.TangentialAccelMax);

      Par.Size := FHGE.Random_Float(FInfo.SizeStart,
        FInfo.SizeStart + (FInfo.SizeEnd - FInfo.SizeStart) * FInfo.SizeVar);
      Par.SpinDelta := (FInfo.SizeEnd - Par.Size) / Par.TerminalAge;

      Par.Spin := FHGE.Random_Float(FInfo.SpinStart,
        FInfo.SpinStart + (FInfo.SpinEnd - FInfo.SpinStart) * FInfo.SpinVar);
      Par.SpinDelta := (FInfo.SpinEnd - Par.Spin) / Par.TerminalAge;

      Par.Color.R := FHGE.Random_Float(FInfo.ColorStart.R,
        FInfo.ColorStart.R + (FInfo.ColorEnd.R - FInfo.ColorStart.R) * FInfo.ColorVar);
      Par.Color.G := FHGE.Random_Float(FInfo.ColorStart.G,
        FInfo.ColorStart.G + (FInfo.ColorEnd.G - FInfo.ColorStart.G) * FInfo.ColorVar);
      Par.Color.B := FHGE.Random_Float(FInfo.ColorStart.B,
        FInfo.ColorStart.B + (FInfo.ColorEnd.B - FInfo.ColorStart.B) * FInfo.ColorVar);
      Par.Color.A := FHGE.Random_Float(FInfo.ColorStart.A,
        FInfo.ColorStart.A + (FInfo.ColorEnd.A - FInfo.ColorStart.A) * FInfo.ColorVar);

      Par.ColorDelta.R := (FInfo.ColorEnd.R - Par.Color.R) / Par.TerminalAge;
      Par.ColorDelta.G := (FInfo.ColorEnd.G - Par.Color.G) / Par.TerminalAge;
      Par.ColorDelta.B := (FInfo.ColorEnd.B - Par.Color.B) / Par.TerminalAge;
      Par.ColorDelta.A := (FInfo.ColorEnd.A - Par.Color.A) / Par.TerminalAge;

      if (FUpdateBoundingBox) then
        FBoundingBox.Encapsulate(Par.Location.X,Par.Location.Y);

      Inc(FParticlesAlive);
      Inc(Par);
    end;
  end;

  FPrevLocation := FLocation;
end;

procedure THGEParticleSystem.Fire;
begin
  if (FInfo.Lifetime = -1) then
    FAge := -1
  else
    FAge := 0;
end;

procedure THGEParticleSystem.FireAt(const X, Y: Single);
begin
  Stop;
  MoveTo(X,Y);
  Fire;
end;

function THGEParticleSystem.GetAge: Single;
begin
  Result := FAge;
end;

function THGEParticleSystem.GetBoundingBox(out Rect: THGERect): PHGERect;
begin
  Rect := FBoundingBox;
  Result := @Rect;
end;

function THGEParticleSystem.GetInfo: PHGEParticleSystemInfo;
begin
  Result := @FInfo;
end;

function THGEParticleSystem.GetParticlesAlive: Integer;
begin
  Result := FParticlesAlive;
end;

procedure THGEParticleSystem.GetPosition(out X, Y: Single);
begin
  X := FLocation.X;
  Y := FLocation.Y;
end;

procedure THGEParticleSystem.GetTransposition(out X, Y: Single);
begin
  X := FTX;
  Y := FTY;
end;

function THGEParticleSystem.Implementor: TObject;
begin
  Result := Self;
end;

procedure THGEParticleSystem.MoveTo(const X, Y: Single;
  const MoveParticles: Boolean);
var
  I: Integer;
  DX, DY: Single;
begin
  if (MoveParticles) then begin
    DX := X - FLocation.X;
    DY := Y - FLocation.Y;
    for I := 0 to FParticlesAlive - 1 do begin
      FParticles[I].Location.X := FParticles[I].Location.X + DX;
      FParticles[I].Location.Y := FParticles[I].Location.Y + DY;
    end;
    FPrevLocation.X := FPrevLocation.X + DX;
    FPrevLocation.Y := FPrevLocation.Y + DY;
  end else begin
    if (FAge = -2) then begin
      FPrevLocation.X := X;
      FPrevLocation.Y := Y;
    end else begin
      FPrevLocation.X := FLocation.X;
      FPrevLocation.Y := FLocation.Y;
    end;
  end;
  FLocation.X := X;
  FLocation.Y := Y;
end;

procedure THGEParticleSystem.Render;
var
  I: Integer;
  Col: Longword;
  Par: PHGEParticle;
begin
  Par := @FParticles[0];
  Col := FInfo.Sprite.GetColor;
  for I := 0 to FParticlesAlive - 1 do begin
    FInfo.Sprite.SetColor(Par.Color.GetHWColor);
    FInfo.Sprite.RenderEx(Par.Location.X + FTX,Par.Location.Y + FTY,
      Par.Spin * Par.Age,Par.Size);
    Inc(Par);
  end;
  FInfo.Sprite.SetColor(Col);
end;

procedure THGEParticleSystem.Stop(const KillParticles: Boolean);
begin
  FAge := -2;
  if (KillParticles) then begin
    FParticlesAlive := 0;
    FBoundingBox.Clear;
  end;
end;

procedure THGEParticleSystem.TrackBoundingBox(const Track: Boolean);
begin
  FUpdateBoundingBox := Track;
end;

procedure THGEParticleSystem.Transpose(const X, Y: Single);
begin
  FTX := X;
  FTY := Y;
end;

procedure THGEParticleSystem.Update(const DeltaTime: Single);
var
  I, ParticlesCreated: Integer;
  Ang, ParticlesNeeded: Single;
  Par: PHGEParticle;
  Accel, Accel2, V: THGEVector;
begin
  if (FAge >= 0) then begin
    FAge := FAge + DeltaTime;
    if (FAge >= FInfo.Lifetime) then
      FAge := -2;
  end;

	// update all alive particles
  if (FUpdateBoundingBox) then
    FBoundingBox.Clear;
  Par := @FParticles;

  I := 0;
  while (I < FParticlesAlive) do begin
    Par.Age := Par.Age + DeltaTime;
    if (Par.Age >= Par.TerminalAge) then begin
      Dec(FParticlesAlive);
      Move(FParticles[FParticlesAlive],Par^,SizeOf(THGEParticle));
      Continue;
    end;

    Accel := Par.Location - FLocation;
    Accel.Normalize;
    Accel2 := Accel;
    Accel.Scale(Par.RadialAccel);

		// vecAccel2.Rotate(M_PI_2);
		// the following is faster
    Ang := Accel2.X;
    Accel2.X := -Accel2.Y;
    Accel2.Y := Ang;

    Accel2.Scale(Par.TangentialAccel);
    Par.Velocity.Increment((Accel + Accel2) * DeltaTime);
    Par.Velocity.Y := Par.Velocity.Y + (Par.Gravity * DeltaTime);

    Par.Location.Increment(Par.Velocity * DeltaTime);

    Par.Spin := Par.Spin + (Par.SpinDelta * DeltaTime);
    Par.Size := Par.Size + (Par.SizeDelta * DeltaTime);
    Par.Color := Par.Color + (Par.ColorDelta * DeltaTime);

    if (FUpdateBoundingBox) then
      FBoundingBox.Encapsulate(Par.Location.X,Par.Location.Y);

    Inc(Par);
    Inc(I);
  end;

	// generate new particles
  if (FAge <> -2) then begin
    ParticlesNeeded := FInfo.Emission * DeltaTime + FEmissionResidue;
    ParticlesCreated := Trunc(ParticlesNeeded);
    FEmissionResidue := ParticlesNeeded - ParticlesCreated;

    Par := @FParticles[FParticlesAlive];

    for I := 0 to ParticlesCreated - 1 do begin
      if (FParticlesAlive >= MAX_PARTICLES) then
        Break;

      Par.Age := 0;
      Par.TerminalAge := FHGE.Random_Float(FInfo.ParticleLifeMin,FInfo.ParticleLifeMax);

      Par.Location := FPrevLocation + (FLocation - FPrevLocation)
        * FHGE.Random_Float(0,1);
      Par.Location.X := Par.Location.X + FHGE.Random_Float(-2,2);
      Par.Location.Y := Par.Location.Y + FHGE.Random_Float(-2,2);

      Ang := FInfo.Direction - M_PI_2 + FHGE.Random_Float(0,FInfo.Spread)
        - FInfo.Spread / 2;
      if (FInfo.Relative) then begin
        V := FPrevLocation - FLocation;
        Ang := Ang + (V.Angle + M_PI_2);
      end;
      Par.Velocity.X := Cos(Ang);
      Par.Velocity.Y := Sin(Ang);
      Par.Velocity.Scale(FHGE.Random_Float(FInfo.SpeedMin,FInfo.SpeedMax));

      Par.Gravity := FHGE.Random_Float(FInfo.GravityMin,FInfo.GravityMax);
      Par.RadialAccel := FHGE.Random_Float(FInfo.RadialAccelMin,FInfo.RadialAccelMax);
      Par.TangentialAccel := FHGE.Random_Float(FInfo.TangentialAccelMin,FInfo.TangentialAccelMax);

      Par.Size := FHGE.Random_Float(FInfo.SizeStart,FInfo.SizeStart
        + (FInfo.SizeEnd - FInfo.SizeStart) * FInfo.SizeVar);
      Par.SizeDelta := (FInfo.SizeEnd - Par.Size) / Par.TerminalAge;

      Par.Spin := FHGE.Random_Float(FInfo.SpinStart,FInfo.SpinStart
        + (FInfo.SpinEnd - FInfo.SpinStart) * FInfo.SpinVar);
      Par.SpinDelta := (Finfo.SpinEnd - Par.Spin) / Par.TerminalAge;

      Par.Color.R := FHGE.Random_Float(FInfo.ColorStart.R,FInfo.ColorStart.R
        + (FInfo.ColorEnd.R - FInfo.ColorStart.R) * FInfo.ColorVar);
      Par.Color.G := FHGE.Random_Float(FInfo.ColorStart.G,FInfo.ColorStart.G
        + (FInfo.ColorEnd.G - FInfo.ColorStart.G) * FInfo.ColorVar);
      Par.Color.B := FHGE.Random_Float(FInfo.ColorStart.B,FInfo.ColorStart.B
        + (FInfo.ColorEnd.B - FInfo.ColorStart.B) * FInfo.ColorVar);
      Par.Color.A := FHGE.Random_Float(FInfo.ColorStart.A,FInfo.ColorStart.A
        + (FInfo.ColorEnd.A - FInfo.ColorStart.A) * FInfo.ColorVar);

      Par.ColorDelta.R := (FInfo.ColorEnd.R - Par.Color.R) / Par.TerminalAge;
      Par.ColorDelta.G := (FInfo.ColorEnd.G - Par.Color.G) / Par.TerminalAge;
      Par.ColorDelta.B := (FInfo.ColorEnd.B - Par.Color.B) / Par.TerminalAge;
      Par.ColorDelta.A := (FInfo.ColorEnd.A - Par.Color.A) / Par.TerminalAge;

      if (FUpdateBoundingBox) then
        FBoundingBox.Encapsulate(Par.Location.X,Par.Location.Y);

      Inc(FParticlesAlive);
      Inc(Par);
    end;
  end;
  FPrevLocation := FLocation;
end;

{ THGEParticleManager }

destructor THGEParticleManager.Destroy;
begin
  KillAll;
  inherited;
end;

procedure THGEParticleManager.GetTransposition(out DX, DY: Single);
begin
  DX := FTX;
  DY := FTY;
end;

function THGEParticleManager.IsPSAlive(const PS: IHGEParticleSystem): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to FNPS - 1 do
    if (FPSList[I] = PS) then
      Exit;
  Result := False;
end;

procedure THGEParticleManager.KillAll;
var
  I: Integer;
begin
  for I := 0 to FNPS - 1 do
    FPSList[I] := nil;
  FNPS := 0;
end;

procedure THGEParticleManager.KillPS(const PS: IHGEParticleSystem);
var
  I: Integer;
begin
  for I := 0 to FNPS - 1 do begin
    if (FPSList[I] = PS) then begin
      FPSList[I] := FPSList[FNPS - 1];
      Dec(FNPS);
      Exit;
    end;
  end;
end;

procedure THGEParticleManager.Render;
var
  I: Integer;
begin
  for I := 0 to FNPS - 1 do
    FPSList[I].Render;
end;

function THGEParticleManager.SpawnPS(const PSI: THGEParticleSystemInfo; const X,
  Y: Single): IHGEParticleSystem;
begin
  if (FNPS = MAX_PSYSTEMS) then
    Result := nil
  else begin
    FPSList[FNPS] := THGEParticleSystem.Create(PSI);
    FPSList[FNPS].FireAt(X,Y);
    FPSList[FNPS].Transpose(FTX,FTY);
    Result := FPSList[FNPS];
    Inc(FNPS);
  end;
end;

procedure THGEParticleManager.Transpose(const X, Y: Single);
var
  I: Integer;
begin
  for I := 0 to FNPS - 1 do
    FPSList[I].Transpose(X,Y);
  FTX := X;
  FTY := Y;
end;

procedure THGEParticleManager.Update(const DT: Single);
var
  I: Integer;
begin
  I := 0;
  while (I < FNPS) do begin
    FPSList[I].Update(DT);
    if (FPSList[I].GetAge = -2) and (FPSList[I].GetParticlesAlive = 0) then begin
      FPSList[I] := FPSList[FNPS - 1];
      Dec(FNPS);
      Dec(I);
    end;
    Inc(I);
  end;
end;

initialization
  Assert(SizeOf(THGEParticleSystemInfo) = 128);
  THGEParticleSystem.FHGE := nil;

end.
