unit HGEPhysics;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Extension to the HGE engine to support box based physics.
** This extension is based on Box2D (http://www.gphysics.com).
** Extension added by Erik van Bilsen
**
** This extension is NOT part of the original HGE engine.
*)

interface

uses
  Math, HGE, HGEVector, HGEMatrix;

type
  IHGEBody = interface
  ['{99739E99-4DD1-4913-A59E-A3A85E4F4420}']
    { Property access methods }
    function GetPosition: THGEVector;
    function GetPPosition: PHGEVector;
    procedure SetPosition(const Value: THGEVector);
    function GetRotation: Single;
    procedure SetRotation(const Value: Single);
    function GetVelocity: THGEVector;
    function GetPVelocity: PHGEVector;
    procedure SetVelocity(const Value: THGEVector);
    function GetAngularVelocity: Single;
    procedure SetAngularVelocity(const Value: Single);
    function GetBiasedVelocity: THGEVector;
    function GetPBiasedVelocity: PHGEVector;
    procedure SetBiasedVelocity(const Value: THGEVector);
    function GetBiasedAngularVelocity: Single;
    procedure SetBiasedAngularVelocity(const Value: Single);
    function GetForce: THGEVector;
    function GetPForce: PHGEVector;
    procedure SetForce(const Value: THGEVector);
    function GetTorque: Single;
    procedure SetTorque(const Value: Single);
    function GetSize: THGEVector;
    function GetPSize: PHGEVector;
    function GetFriction: Single;
    procedure SetFriction(const Value: Single);
    function GetMass: Single;
    function GetInvMass: Single;
    function GetI: Single;
    function GetInvI: Single;
    function GetIsStationary: Boolean;

    { Methods }
    procedure AddForce(const Force: THGEVector);

    { Properties }
    property Position: THGEVector read GetPosition write SetPosition;
    property PPosition: PHGEVector read GetPPosition;
    property Rotation: Single read GetRotation write SetRotation;
    property Velocity: THGEVector read GetVelocity write SetVelocity;
    property PVelocity: PHGEVector read GetPVelocity;
    property AngularVelocity: Single read GetAngularVelocity write SetAngularVelocity;
    property BiasedVelocity: THGEVector read GetBiasedVelocity write SetBiasedVelocity;
    property PBiasedVelocity: PHGEVector read GetPBiasedVelocity;
    property BiasedAngularVelocity: Single read GetBiasedAngularVelocity write SetBiasedAngularVelocity;
    property Force: THGEVector read GetForce write SetForce;
    property PForce: PHGEVector read GetPForce;
    property Torque: Single read GetTorque write SetTorque;
    property Size: THGEVector read GetSize;
    property PSize: PHGEVector read GetPSize;
    property Friction: Single read GetFriction write SetFriction;
    property Mass: Single read GetMass;
    property InvMass: Single read GetInvMass;
    property I: Single read GetI;
    property InvI: Single read GetInvI;
    property IsStationary: Boolean read GetIsStationary;
  end;

type
  IHGEBodyList = interface
  ['{6C94306E-015D-477A-B6A5-BC9F98BD6533}']
    { Property access methods }
    function GetCount: Integer;
    function GetBody(const Index: Integer): IHGEBody;

    { Methods }
    procedure Add(const Body: IHGEBody);
    procedure Clear;

    { Properties }
    property Count: Integer read GetCount;
    property Bodies[const Index: Integer]: IHGEBody read GetBody; default;
  end;

type
  IHGEJoint = interface
  ['{EAA8B96D-0F27-4E01-867F-B266ACBAF258}']
    { Property access methods }
    function GetBiasFactor: Single;
    procedure SetBiasFactor(const Value: Single);
    function GetSoftness: Single;
    procedure SetSoftness(const Value: Single);
    function GetBody1: IHGEBody;
    function GetBody2: IHGEBody;
    function GetLocalAnchor1: THGEVector;
    function GetLocalAnchor2: THGEVector;

    { Methods }
    procedure PreStep(const InvDt: Single);
    procedure ApplyImpulse;

    { Properties }
    property BiasFactor: Single read GetBiasFactor write SetBiasFactor;
    property Softness: Single read GetSoftness write SetSoftness;
    property Body1: IHGEBody read GetBody1;
    property Body2: IHGEBody read GetBody2;
    property LocalAnchor1: THGEVector read GetLocalAnchor1;
    property LocalAnchor2: THGEVector read GetLocalAnchor2;
  end;

type
  IHGEJointList = interface
  ['{A7D7F96D-7D57-4EB6-B821-1BED1DB30197}']
    { Property access methods }
    function GetCount: Integer;
    function GetJoint(const Index: Integer): IHGEJoint;

    { Methods }
    procedure Add(const Joint: IHGEJoint);
    procedure Clear;

    { Properties }
    property Count: Integer read GetCount;
    property Joints[const Index: Integer]: IHGEJoint read GetJoint; default;
  end;

type
  IHGEArbiter = interface
  ['{838417B1-94EB-4C3A-9A34-4FC4F8530E1F}']
    { Property access methods }
    function GetBody1: IHGEBody;
    function GetBody2: IHGEBody;
    function GetNext: IHGEArbiter;
    procedure SetNext(const Value: IHGEArbiter);

    { Methods }
    procedure PreStep(const InvDT: Single);
    procedure ApplyImpulse;

    { Properties }
    property Body1: IHGEBody read GetBody1;
    property Body2: IHGEBody read GetBody2;

    { Internal }
    function Implementor: TObject;
    property Next: IHGEArbiter read GetNext write SetNext;
  end;

type
  IHGEArbiterList = interface
  ['{14DB415C-F609-4517-B6B5-742B7068E70A}']
    { Property access methods }
    function GetCount: Integer;

    { Methods }
    procedure Add(const Arbiter: IHGEArbiter);
    procedure Clear;
    procedure Erase(const Body1, Body2: IHGEBody);
    function First: IHGEArbiter;
    function Next: IHGEArbiter;
    function Find(const Body1, Body2: IHGEBody): IHGEArbiter;

    { Properties }
    property Count: Integer read GetCount;
  end;

type
  IHGEWorld = interface
  ['{5E229E68-FB26-4E10-A915-AFC87A44AEB3}']
    { Property access methods }
    function GetBodies: IHGEBodyList;
    function GetJoints: IHGEJointList;
    function GetArbiters: IHGEArbiterList;
    function GetGravity: THGEVector;
    function GetIterations: Integer;

    { Methods }
    procedure Add(const Body: IHGEBody); overload;
    procedure Add(const Joint: IHGEJoint); overload;
    procedure Clear;
    procedure Step(const DT: Single);

    { Properties }
    property Bodies: IHGEBodyList read GetBodies;
    property Joints: IHGEJointList read GetJoints;
    property Arbiters: IHGEArbiterList read GetArbiters;
    property Gravity: THGEVector read GetGravity;
    property Iterations: Integer read GetIterations;
  end;

type
  THGEBody = class(TInterfacedObject,IHGEBody)
  protected
    { IHGEBody }
    function GetPosition: THGEVector;
    function GetPPosition: PHGEVector;
    procedure SetPosition(const Value: THGEVector);
    function GetRotation: Single;
    procedure SetRotation(const Value: Single);
    function GetVelocity: THGEVector;
    function GetPVelocity: PHGEVector;
    procedure SetVelocity(const Value: THGEVector);
    function GetAngularVelocity: Single;
    procedure SetAngularVelocity(const Value: Single);
    function GetBiasedVelocity: THGEVector;
    function GetPBiasedVelocity: PHGEVector;
    procedure SetBiasedVelocity(const Value: THGEVector);
    function GetBiasedAngularVelocity: Single;
    procedure SetBiasedAngularVelocity(const Value: Single);
    function GetForce: THGEVector;
    function GetPForce: PHGEVector;
    procedure SetForce(const Value: THGEVector);
    function GetTorque: Single;
    procedure SetTorque(const Value: Single);
    function GetSize: THGEVector;
    function GetPSize: PHGEVector;
    function GetFriction: Single;
    procedure SetFriction(const Value: Single);
    function GetMass: Single;
    function GetInvMass: Single;
    function GetI: Single;
    function GetInvI: Single;
    function GetIsStationary: Boolean;

    procedure AddForce(const Force: THGEVector);
  private
    FPosition: THGEVector;
    FRotation: Single;
    FVelocity: THGEVector;
    FAngularVelocity: SIngle;
    FBiasedVelocity: THGEVector;
    FBiasedAngularVelocity: Single;
    FForce: THGEVector;
    FTorque: Single;
    FSize: THGEVector;
    FFriction: SIngle;
    FMass: Single;
    FInvMass: Single;
    FI: Single;
    FInvI: Single;
  public
    constructor Create; overload;
    constructor Create(const ASize: THGEVector); overload;
    constructor Create(const ASize: THGEVector; const AMass: Single); overload;
    destructor Destroy; override;
  end;

type
  THGEJoint = class(TInterfacedObject,IHGEJoint)
  protected
    { IHGEJoint }
    function GetBiasFactor: Single;
    procedure SetBiasFactor(const Value: Single);
    function GetSoftness: Single;
    procedure SetSoftness(const Value: Single);
    function GetBody1: IHGEBody;
    function GetBody2: IHGEBody;
    function GetLocalAnchor1: THGEVector;
    function GetLocalAnchor2: THGEVector;

    procedure PreStep(const InvDt: Single);
    procedure ApplyImpulse;
  private
    FBody1: IHGEBody;
    FBody2: IHGEBody;
    FLocalAnchor1: THGEVector;
    FLocalAnchor2: THGEVector;
    FBiasFactor: Single;
    FSoftness: Single;
    FM: THGEMatrix;
    FR1: THGEVector;
    FR2: THGEVector;
    FBias: THGEVector;
    FP: THGEVector;
  public
    constructor Create; overload;
    constructor Create(const ABody1, ABody2: IHGEBody;
      const AAnchor: THGEVector); overload;
    destructor Destroy; override;
  end;

type
  THGEWorld = class(TInterfacedObject,IHGEWorld)
  protected
    { IHGEWorld }
    function GetBodies: IHGEBodyList;
    function GetJoints: IHGEJointList;
    function GetArbiters: IHGEArbiterList;
    function GetGravity: THGEVector;
    function GetIterations: Integer;

    procedure Add(const Body: IHGEBody); overload;
    procedure Add(const Joint: IHGEJoint); overload;
    procedure Clear;
    procedure Step(const DT: Single);
  private
    FBodies: IHGEBodyList;
    FJoints: IHGEJointList;
    FArbiters: IHGEArbiterList;
    FGravity: THGEVector;
    FIterations: Integer;
    procedure BroadPhase;
  public
    class var AccumulateImpulses: Boolean;
    class var SplitImpules: Boolean;
    class var WarmStarting: Boolean;
    class var PositionCorrection: Boolean;
  public
    constructor Create(const AGravity: THGEVector; const AIterations: Integer);
    destructor Destroy; override;
  end;

var // Debug
  HGEBodyCount: Integer = 0;
  HGEJointCount: Integer = 0;
  HGEArbiterCount: Integer = 0;

implementation

uses
  Classes;

type
  THGEBodyList = class(TInterfacedObject,IHGEBodyList)
  protected
    { IHGEBodyList }
    function GetCount: Integer;
    function GetBody(const Index: Integer): IHGEBody;

    procedure Add(const Body: IHGEBody);
    procedure Clear;
  private
    FBodies: IInterfaceList;
  public
    constructor Create;
  end;

type
  THGEJointList = class(TInterfacedObject,IHGEJointList)
  protected
    { IHGEJointList }
    function GetCount: Integer;
    function GetJoint(const Index: Integer): IHGEJoint;

    procedure Add(const Joint: IHGEJoint);
    procedure Clear;
  private
    FJoints: IInterfaceList;
  public
    constructor Create;
  end;

type
  TEdges = packed record
    InEdge1: Byte;
    OutEdge1: Byte;
    InEdge2: Byte;
    OutEdge2: Byte;
  end;

type
  TFeaturePair = record
    case Integer of
      0: (E: TEdges);
      1: (Value: Integer);
  end;

type
  TContact = record
  public
    Position: THGEVector;
    Normal: THGEVector;
    R1: THGEVector;
    R2: THGEVector;
    Separation: Single;
    Pn: Single;  // accumulated normal impulse
    Pt: Single;  // accumulated tangent impulse
    Pnb: Single; // accumulated normal impulse for position bias
    MassNormal: Single;
    MassTangent: Single;
    Bias: Single;
    Feature: TFeaturePair;
  end;
  PContact = ^TContact;

type
  TContacts = array [0..1] of TContact;

type
  THGEArbiter = class(TInterfacedObject,IHGEArbiter)
  protected
    { IHGEArbiter }
    function GetBody1: IHGEBody;
    function GetBody2: IHGEBody;
    function GetNext: IHGEArbiter;
    procedure SetNext(const Value: IHGEArbiter);
    function Implementor: TObject;

    procedure PreStep(const InvDT: Single);
    procedure ApplyImpulse;
  private
    FBody1: IHGEBody;
    FBody2: IHGEBody;
    FNext: IHGEArbiter;
    FFriction: Single;
    FNumContacts: Integer;
    FContacts: TContacts;
  public
    constructor Create(const ABody1, ABody2: IHGEBody;
      const AContacts: TContacts; const ANumContacts: Integer);
    destructor Destroy; override;
    procedure Update(const NewContacts: TContacts; const NewNumContacts: Integer);
  end;

const
  ArbiterHashSize = 1 shl 14;
  ArbiterHashMask = ArbiterHashSize - 1;

type
  TArbiterBuckets = array [0..ArbiterHashSize - 1] of IHGEArbiter;

type
  THGEArbiterList = class(TInterfacedObject,IHGEArbiterList)
  protected
    { IHGEArbiterList }
    function GetCount: Integer;

    procedure Add(const Arbiter: IHGEArbiter);
    procedure Clear;
    procedure Erase(const Body1, Body2: IHGEBody);
    function First: IHGEArbiter;
    function Next: IHGEArbiter;
    function Find(const Body1, Body2: IHGEBody): IHGEArbiter;
  private
    FBuckets: TArbiterBuckets;
    FCount: Integer;
    FCurrentIndex: Integer;
    FCurrentEntry: IHGEArbiter;
    function Hash(const Body1, Body2: IHGEBody): Cardinal;
  public
    destructor Destroy; override;
  end;

// Box vertex and edge numbering:
//
//        ^ y
//        |
//        e1
//   v2 ------ v1
//    |        |
// e2 |        | e4  --> x
//    |        |
//   v3 ------ v4
//        e3

type
  TAxis = (FaceAX,FaceAY,FaceBX,FaceBY);

const
  NoEdge = 0;
  Edge1  = 1;
  Edge2  = 2;
  Edge3  = 3;
  Edge4  = 4;

type
  TClipVertex = record
  public
    V: THGEVector;
    FP: TFeaturePair;
  end;

type
  TClipVertices = array [0..1] of TClipVertex;

procedure Swap(var A, B: Byte); inline;
var
  T: Byte;
begin
  T := A;
  A := B;
  B := T;
end;

function Clamp(const A, Low, High: Single): Single; inline;
begin
  Result := Max(Low,Min(A,High));
end;

procedure ComputeIncidentEdge(var C: TClipVertices; const H, Pos: THGEVector;
  const Rot: THGEMatrix; const Normal: THGEVector);
var
  RotT: THGEMatrix;
  N, NAbs: THGEVector;
begin
	// The normal is from the reference box. Convert it
	// to the incident boxe's frame and flip sign.
  RotT := Rot.Transpose;
  N := -(RotT * Normal);
  NAbs := N.Abs;

  if (NAbs.X > NAbs.Y) then begin
    if (Sign(N.X) > 0) then begin
      C[0].V := THGEVector.Create(H.X,-H.Y);
      C[0].FP.E.InEdge2 := Edge3;
      C[0].FP.E.OutEdge2 := Edge4;

      C[1].V := THGEVector.Create(H.X,H.Y);
      C[1].FP.E.InEdge2 := Edge4;
      C[1].FP.E.OutEdge2 := Edge1;
    end else begin
      C[0].V := THGEVector.Create(-H.X,H.Y);
      C[0].FP.E.InEdge2 := Edge1;
      C[0].FP.E.OutEdge2 := Edge2;

      C[1].V := THGEVector.Create(-H.X,-H.Y);
      C[1].FP.E.InEdge2 := Edge2;
      C[1].FP.E.OutEdge2 := Edge3;
    end;
  end else begin
    if (Sign(N.Y) > 0) then begin
      C[0].V := THGEVector.Create(H.X,H.Y);
      C[0].FP.E.InEdge2 := Edge4;
      C[0].FP.E.OutEdge2 := Edge1;

      C[1].V := THGEVector.Create(-H.X,H.Y);
      C[1].FP.E.InEdge2 := Edge1;
      C[1].FP.E.OutEdge2 := Edge2;
    end else begin
      C[0].V := THGEVector.Create(-H.X,-H.Y);
      C[0].FP.E.InEdge2 := Edge2;
      C[0].FP.E.OutEdge2 := Edge3;

      C[1].V := THGEVector.Create(H.X,-H.Y);
      C[1].FP.E.InEdge2 := Edge3;
      C[1].FP.E.OutEdge2 := Edge4;
    end;
  end;
  C[0].V := Pos + Rot * C[0].V;
  C[1].V := Pos + Rot * C[1].V;
end;

function ClipSegmentToLine(var VOut: TClipVertices; const VIn: TClipVertices;
  const Normal: THGEVector; const Offset: Single; const ClipEdge: Byte): Integer;
var
  Distance0, Distance1, Interp: Single;
begin
	// Start with no output points
  Result := 0;

	// Calculate the distance of end points to the line
  Distance0 := Normal.Dot(VIn[0].V) - Offset;
  Distance1 := Normal.Dot(VIn[1].V) - Offset;

	// If the points are behind the plane
  if (Distance0 <= 0) then begin
    VOut[Result] := VIn[0];
    Inc(Result);
  end;

  if (Distance1 <= 0) then begin
    VOut[Result] := VIn[1];
    Inc(Result);
  end;

	// If the points are on different sides of the plane
  if (Distance0 * Distance1 < 0) then begin
		// Find intersection point of edge and plane
    Interp := Distance0 / (Distance0 - Distance1);
    VOut[Result].V := VIn[0].V + Interp * (VIn[1].V - VIn[0].V);
    if (Distance0 > 0) then begin
      VOut[Result].FP := VIn[0].FP;
      VOut[Result].FP.E.InEdge1 := ClipEdge;
      VOut[Result].FP.E.InEdge2 := NoEdge;
    end else begin
      VOut[Result].FP := VIn[1].FP;
      VOut[Result].FP.E.OutEdge1 := ClipEdge;
      VOut[Result].FP.E.OutEdge2 := NoEdge;
    end;
    Inc(Result);
  end;
end;

procedure Flip(var FP: TFeaturePair);
begin
  Swap(FP.E.InEdge1,FP.E.InEdge2);
  Swap(FP.E.OutEdge1,FP.E.OutEdge2);
end;

// The normal points from A to B
function Collide(var Contacts: TContacts; const BodyA, BodyB: IHGEBody): Integer;
const
  RelativeTol = 0.95;
	AbsoluteTol = 0.01;
var
  hA, hB, PosA, PosB, a1, a2, b1, b2, dp, dA, dB, FaceA, FaceB, Normal: THGEVector;
  FrontNormal, SideNormal: THGEVector;
  RotA, RotB, RotAT, RotBT, C, AbsC, AbsCT: THGEMatrix;
  Axis: TAxis;
  Separation, Front, NegSide, PosSide, Side: Single;
  IncidentEdge, ClipPoints1, ClipPoints2: TClipVertices;
  NegEdge, PosEdge: Byte;
  NP, I: Integer;
begin
  Result := 0;

	// Setup
  hA := 0.5 * BodyA.Size;
  hB := 0.5 * BodyB.Size;

  PosA := BodyA.Position;
  PosB := BodyB.Position;

  RotA := THGEMatrix.Create(BodyA.Rotation);
  RotB := THGEMatrix.Create(BodyB.Rotation);

  RotAT := RotA.Transpose;
  RotBT := RotB.Transpose;

  a1 := RotA.Col1;
  a2 := RotA.Col2;
  b1 := RotB.Col1;
  b2 := RotB.Col2;

  dp := PosB - PosA;
  dA := RotAT * dp;
  dB := RotBT * dp;

  C := RotAT * RotB;
  AbsC := C.Abs;
  AbsCT := AbsC.Transpose;

	// Box A faces
  FaceA := dA.Abs - hA - AbsC * hB;
  if (FaceA.X > 0) or (FaceA.Y > 0) then
    Exit;

	// Box B faces
  FaceB := dB.Abs - AbsCT * hA - hB;
  if (FaceB.X > 0) or (FaceB.Y > 0) then
    Exit;

	// Find best axis

	// Box A faces
  Axis := FaceAX;
  Separation := FaceA.X;
  if (dA.X > 0) then
    Normal := RotA.Col1
  else
    Normal := -RotA.Col1;

  if (FaceA.Y > RelativeTol * Separation + AbsoluteTol * hA.Y) then begin
    Axis := FaceAY;
    Separation := FaceA.Y;
    if (dA.Y > 0) then
      Normal := RotA.Col2
    else
      Normal := -RotA.Col2;
  end;

	// Box B faces
  if (FaceB.X > RelativeTol * Separation + AbsoluteTol * hB.X) then begin
    Axis := FaceBX;
    Separation := FaceB.X;
    if (dB.X > 0) then
      Normal := RotB.Col1
    else
      Normal := -RotB.Col1;
  end;

  if (FaceB.Y > RelativeTol * Separation + AbsoluteTol * hB.Y) then begin
    Axis := FaceBY;
//    Separation := FaceB.Y;
    if (dB.Y > 0) then
      Normal := RotB.Col2
    else
      Normal := -RotB.Col2;
  end;

	// Setup clipping plane data based on the separating axis

	// Compute the clipping lines and the line segment to be clipped.
  case Axis of
    FaceAX:
      begin
        FrontNormal := Normal;
        Front := PosA.Dot(FrontNormal) + hA.X;
        SideNormal := RotA.Col2;
        Side := PosA.Dot(SideNormal);
        NegSide := -Side + hA.Y;
        PosSide :=  Side + hA.Y;
        NegEdge := Edge3;
        PosEdge := Edge1;
        ComputeIncidentEdge(IncidentEdge,hB,PosB,RotB,FrontNormal);
      end;
    FaceAY:
      begin
        FrontNormal := Normal;
        Front := PosA.Dot(FrontNormal) + hA.Y;
        SideNormal := RotA.Col1;
        Side := PosA.Dot(SideNormal);
        NegSide := -Side + hA.X;
        PosSide :=  Side + hA.X;
        NegEdge := Edge2;
        PosEdge := Edge4;
        ComputeIncidentEdge(IncidentEdge,hB,PosB,RotB,FrontNormal);
      end;
    FaceBX:
      begin
        FrontNormal := -Normal;
        Front := PosB.Dot(FrontNormal) + hB.X;
        SideNormal := RotB.Col2;
        Side := PosB.Dot(SideNormal);
        NegSide := -Side + hB.Y;
        PosSide :=  Side + hB.Y;
        NegEdge := Edge3;
        PosEdge := Edge1;
        ComputeIncidentEdge(IncidentEdge,hA,PosA,RotA,FrontNormal);
      end;
  else
    // FaceBY:
      begin
        FrontNormal := -Normal;
        Front := PosB.Dot(FrontNormal) + hB.Y;
        SideNormal := RotB.Col1;
        Side := PosB.Dot(SideNormal);
        NegSide := -Side + hB.X;
        PosSide :=  Side + hB.X;
        NegEdge := Edge2;
        PosEdge := Edge4;
        ComputeIncidentEdge(IncidentEdge,hA,PosA,RotA,FrontNormal);
      end;
  end;

	// clip other face with 5 box planes (1 face plane, 4 edge planes)

	// Clip to box side 1
  NP := ClipSegmentToLine(ClipPoints1,IncidentEdge,-SideNormal,NegSide,NegEdge);
  if (NP < 2) then
    Exit;

	// Clip to negative box side 1
  NP := ClipSegmentToLine(ClipPoints2,ClipPoints1,SideNormal,PosSide,PosEdge);
  if (NP < 2) then
    Exit;

	// Now clipPoints2 contains the clipping points.
	// Due to roundoff, it is possible that clipping removes all points.
  for I := 0 to 1 do begin
    Separation := FrontNormal.Dot(ClipPoints2[I].V) - Front;
    if (Separation <= 0) then begin
      Contacts[Result].Separation := Separation;
      Contacts[Result].Normal := Normal;
			// slide contact point onto reference face (easy to cull)
      Contacts[Result].Position := ClipPoints2[I].V - Separation * FrontNormal;
      Contacts[Result].Feature := ClipPoints2[I].FP;
      if (Axis in [FaceBX,FaceBY]) then
        Flip(Contacts[Result].Feature);
      Inc(Result);
    end;
  end;
end;

{ THGEBody }

procedure THGEBody.AddForce(const Force: THGEVector);
begin
  FForce := FForce + Force;
end;

constructor THGEBody.Create(const ASize: THGEVector; const AMass: Single);
begin
  inherited Create;
  Inc(HGEBodyCount);
  FFriction := 0.2;
  FSize := ASize;
  FMass := AMass;

  if (FMass < MaxSingle - 1e31) then begin
    FInvMass := 1 / FMass;
    FI := FMass * ((FSize.X * FSize.X) + (FSize.Y * FSize.Y)) / 12;
    FInvI := 1 / FI;
  end else begin
    FInvMass := 0;
    FI := MaxSingle;
    FInvI := 0;
  end;
end;

destructor THGEBody.Destroy;
begin
  Dec(HGEBodyCount);
  inherited;
end;

constructor THGEBody.Create(const ASize: THGEVector);
begin
  Create(ASize,MaxSingle);
end;

constructor THGEBody.Create;
begin
  Create(THGEVector.Create(1,1),MaxSingle);
end;

function THGEBody.GetAngularVelocity: Single;
begin
  Result := FAngularVelocity;
end;

function THGEBody.GetBiasedAngularVelocity: Single;
begin
  Result := FBiasedAngularVelocity;
end;

function THGEBody.GetBiasedVelocity: THGEVector;
begin
  Result := FBiasedVelocity;
end;

function THGEBody.GetForce: THGEVector;
begin
  Result := FForce;
end;

function THGEBody.GetFriction: Single;
begin
  Result := FFriction;
end;

function THGEBody.GetI: Single;
begin
  Result := FI;
end;

function THGEBody.GetInvI: Single;
begin
  Result := FInvI;
end;

function THGEBody.GetInvMass: Single;
begin
  Result := FInvMass;
end;

function THGEBody.GetIsStationary: Boolean;
begin
  Result := (FMass > MaxSingle - 1e31);
end;

function THGEBody.GetMass: Single;
begin
  Result := FMass;
end;

function THGEBody.GetPBiasedVelocity: PHGEVector;
begin
  Result := @FBiasedVelocity;
end;

function THGEBody.GetPForce: PHGEVector;
begin
  Result := @FForce;
end;

function THGEBody.GetPosition: THGEVector;
begin
  Result := FPosition;
end;

function THGEBody.GetPPosition: PHGEVector;
begin
  Result := @FPosition;
end;

function THGEBody.GetPSize: PHGEVector;
begin
  Result := @FSize;
end;

function THGEBody.GetPVelocity: PHGEVector;
begin
  Result := @FVelocity;
end;

function THGEBody.GetRotation: Single;
begin
  Result := FRotation;
end;

function THGEBody.GetSize: THGEVector;
begin
  Result := FSize;
end;

function THGEBody.GetTorque: Single;
begin
  Result := FTorque;
end;

function THGEBody.GetVelocity: THGEVector;
begin
  Result := FVelocity;
end;

procedure THGEBody.SetAngularVelocity(const Value: Single);
begin
  FAngularVelocity := Value;
end;

procedure THGEBody.SetBiasedAngularVelocity(const Value: Single);
begin
  FBiasedAngularVelocity := Value;
end;

procedure THGEBody.SetBiasedVelocity(const Value: THGEVector);
begin
  FBiasedVelocity := Value;
end;

procedure THGEBody.SetForce(const Value: THGEVector);
begin
  FForce := Value;
end;

procedure THGEBody.SetFriction(const Value: Single);
begin
  FFriction := Value;
end;

procedure THGEBody.SetPosition(const Value: THGEVector);
begin
  FPosition := Value;
end;

procedure THGEBody.SetRotation(const Value: Single);
begin
  FRotation := Value;
end;

procedure THGEBody.SetTorque(const Value: Single);
begin
  FTorque := Value;
end;

procedure THGEBody.SetVelocity(const Value: THGEVector);
begin
  FVelocity := Value;
end;

{ THGEBodyList }

procedure THGEBodyList.Add(const Body: IHGEBody);
begin
  FBodies.Add(Body);
end;

procedure THGEBodyList.Clear;
begin
  FBodies.Clear;
end;

constructor THGEBodyList.Create;
begin
  inherited;
  FBodies := TInterfaceList.Create;
end;

function THGEBodyList.GetBody(const Index: Integer): IHGEBody;
begin
  Result := IHGEBody(FBodies[Index]);
end;

function THGEBodyList.GetCount: Integer;
begin
  Result := FBodies.Count;
end;

{ THGEJoint }

procedure THGEJoint.ApplyImpulse;
var
  DV, Impulse: THGEVector;
begin
  DV := FBody2.Velocity + Cross(FBody2.AngularVelocity,FR2) - FBody1.Velocity
    - Cross(FBody1.AngularVelocity,FR1);
  Impulse := FM * (FBias - DV - FSoftness * FP);

  FBody1.PVelocity.Decrement(FBody1.InvMass * Impulse);
  FBody1.AngularVelocity := FBody1.AngularVelocity - (FBody1.InvI * Cross(FR1,Impulse));

  FBody2.PVelocity.Increment(FBody2.InvMass * Impulse);
  FBody2.AngularVelocity := FBody2.AngularVelocity + (FBody2.InvI * Cross(FR2,Impulse));

  FP.Increment(Impulse);
end;

constructor THGEJoint.Create;
begin
  inherited;
  Inc(HGEJointCount);
  FBiasFactor := 0.2;
end;

constructor THGEJoint.Create(const ABody1, ABody2: IHGEBody;
  const AAnchor: THGEVector);
var
  Rot1, Rot2, Rot1T, Rot2T: THGEMatrix;
begin
  inherited Create;
  Inc(HGEJointCount);
  FBody1 := ABody1;
  FBody2 := ABody2;

  Rot1 := THGEMatrix.Create(FBody1.Rotation);
  Rot2 := THGEMatrix.Create(FBody2.Rotation);
  Rot1T := Rot1.Transpose;
  Rot2T := Rot2.Transpose;

  FLocalAnchor1 := Rot1T * (AAnchor - FBody1.Position);
  FLocalAnchor2 := Rot2T * (AAnchor - FBody2.Position);

  FBiasFactor := 0.2;
end;

destructor THGEJoint.Destroy;
begin
  Dec(HGEJointCount);
  inherited;
end;

function THGEJoint.GetBiasFactor: Single;
begin
  Result := FBiasFactor;
end;

function THGEJoint.GetBody1: IHGEBody;
begin
  Result := FBody1;
end;

function THGEJoint.GetBody2: IHGEBody;
begin
  Result := FBody2;
end;

function THGEJoint.GetLocalAnchor1: THGEVector;
begin
  Result := FLocalAnchor1;
end;

function THGEJoint.GetLocalAnchor2: THGEVector;
begin
  Result := FLocalAnchor2;
end;

function THGEJoint.GetSoftness: Single;
begin
  Result := FSoftness;
end;

procedure THGEJoint.PreStep(const InvDt: Single);
var
  Rot1, Rot2, K1, K2, K3, K: THGEMatrix;
  P1, P2, DP: THGEVector;
begin
	// Pre-compute anchors, mass matrix, and bias.
  Rot1 := THGEMatrix.Create(FBody1.Rotation);
  Rot2 := THGEMatrix.Create(FBody2.Rotation);

  FR1 := Rot1 * FLocalAnchor1;
  FR2 := Rot2 * FLocalAnchor2;

	// deltaV = deltaV0 + K * impulse
	// invM = [(1/m1 + 1/m2) * eye(2) - skew(FR1) * invI1 * skew(FR1) - skew(FR2) * invI2 * skew(FR2)]
	//      = [1/m1+1/m2     0    ] + invI1 * [FR1.y*FR1.y -FR1.x*FR1.y] + invI2 * [FR1.y*FR1.y -FR1.x*FR1.y]
	//        [    0     1/m1+1/m2]           [-FR1.x*FR1.y FR1.x*FR1.x]           [-FR1.x*FR1.y FR1.x*FR1.x]
  K1.Col1.X := FBody1.InvMass + FBody2.InvMass;
  K1.Col2.X := 0;
  K1.Col1.Y := 0;
  K1.Col2.Y := FBody1.InvMass + FBody2.InvMass;

  K2.Col1.X :=  FBody1.InvI * FR1.Y * FR1.Y;
  K2.Col2.X := -FBody1.InvI * FR1.X * FR1.Y;
  K2.Col1.Y := -FBody1.InvI * FR1.X * FR1.Y;
  K2.Col2.Y :=  FBody1.InvI * FR1.X * FR1.X;

  K3.Col1.X :=  FBody2.InvI * FR2.Y * FR2.Y;
  K3.Col2.X := -FBody2.InvI * FR2.X * FR2.Y;
  K3.Col1.Y := -FBody2.InvI * FR2.X * FR2.Y;
  K3.Col2.Y :=  FBody2.InvI * FR2.X * FR2.X;

  K := K1 + K2 + K3;
  K.Col1.X := K.Col1.X + FSoftness;
  K.Col1.Y := K.Col1.Y + FSoftness;

  FM := K.Invert;

  P1 := FBody1.Position + FR1;
  P2 := FBody2.Position + FR2;
  DP := P2 - P1;

  if (THGEWorld.PositionCorrection) then
    FBias := -FBiasFactor * InvDt * DP
  else
    FBias := THGEVector.Create(0,0);

  if (THGEWorld.WarmStarting) then begin
		// Apply accumulated impulse.
    FBody1.PVelocity.Decrement(FBody1.InvMass * FP);
    FBody1.AngularVelocity := FBody1.AngularVelocity - (FBody1.InvI * Cross(FR1,FP));

    FBody2.PVelocity.Increment(FBody2.InvMass * FP);
    FBody2.AngularVelocity := FBody2.AngularVelocity + (FBody2.InvI * Cross(FR2,FP));
  end else
    FP := THGEVector.Create(0,0);
end;

procedure THGEJoint.SetBiasFactor(const Value: Single);
begin
  FBiasFactor := Value;
end;

procedure THGEJoint.SetSoftness(const Value: Single);
begin
  FSoftness := Value;
end;

{ THGEJointList }

procedure THGEJointList.Add(const Joint: IHGEJoint);
begin
  FJoints.Add(Joint);
end;

procedure THGEJointList.Clear;
begin
  FJoints.Clear;
end;

constructor THGEJointList.Create;
begin
  inherited;
  FJoints := TInterfaceList.Create;
end;

function THGEJointList.GetCount: Integer;
begin
  Result := FJoints.Count;
end;

function THGEJointList.GetJoint(const Index: Integer): IHGEJoint;
begin
  Result := IHGEJoint(FJoints[Index]);
end;

{ THGEArbiter }

procedure THGEArbiter.ApplyImpulse;
var
  I: Integer;
  C: PContact;
  DV, Pn, Pb, Tangent, Pt: THGEVector;
  VN, dPn, Pn0, VNB, dPnb, Pnb0, VT, dPt, MaxPt, OldTangentImpulse: Single;
begin
  for I := 0 to FNumContacts - 1 do begin
    C := @FContacts[I];
    C.R1 := C.Position - FBody1.Position;
    C.R2 := C.Position - FBody2.Position;

		// Relative velocity at contact
    DV := FBody2.Velocity + Cross(FBody2.AngularVelocity,C.R2) - FBody1.Velocity
      - Cross(FBody1.AngularVelocity,C.R1);

		// Compute normal impulse
    VN := DV.Dot(C.Normal);
    if (THGEWorld.SplitImpules) then
      dPn := C.MassNormal * (-VN)
    else
      dPn := C.MassNormal * (-VN + C.Bias);

    if (THGEWorld.AccumulateImpulses) then begin
			// Clamp the accumulated impulse
      Pn0 := C.Pn;
      C.Pn := Max(Pn0 + dPn,0);
      dPn := C.Pn - Pn0;
    end else
      dPn := Max(dPn,0);

		// Apply contact impulse
    Pn := dPn * C.Normal;

    FBody1.PVelocity.Decrement(FBody1.InvMass * Pn);
    FBody1.AngularVelocity := FBody1.AngularVelocity - (FBody1.InvI * Cross(C.R1,Pn));

    FBody2.PVelocity.Increment(FBody2.InvMass * Pn);
    FBody2.AngularVelocity := FBody2.AngularVelocity + (FBody2.InvI * Cross(C.R2,Pn));

    if (THGEWorld.SplitImpules) then begin
			// Compute bias impulse
      DV := FBody2.BiasedVelocity + Cross(FBody2.BiasedAngularVelocity,C.R2)
        - FBody1.BiasedVelocity - Cross(FBody1.BiasedAngularVelocity,C.R1);
      VNB := DV.Dot(C.Normal);

      dPnb := C.MassNormal * (-VNB + C.Bias);
      Pnb0 := C.Pnb;
      C.Pnb := Max(Pnb0 + dPnb,0);
      dPnb := C.Pnb - Pnb0;

      Pb := dPnb * C.Normal;

      FBody1.PBiasedVelocity.Decrement(FBody1.InvMass * Pb);
      FBody1.BiasedAngularVelocity := FBody1.BiasedAngularVelocity - (FBody1.InvI * Cross(C.R1,Pb));

      FBody2.PBiasedVelocity.Increment(FBody2.InvMass * Pb);
      FBody2.BiasedAngularVelocity := FBody2.BiasedAngularVelocity + (FBody2.InvI * Cross(C.R2,Pb));
    end;

		// Relative velocity at contact
    DV := FBody2.Velocity + Cross(FBody2.AngularVelocity,C.R2) - FBody1.Velocity
      - Cross(FBody1.AngularVelocity,C.R1);
    Tangent := Cross(C.Normal,1);
    VT := DV.Dot(Tangent);
    dPt := C.MassTangent * (-VT);

    if (THGEWorld.AccumulateImpulses) then begin
			// Compute friction impulse
      MaxPt := FFriction * C.Pn;

			// Clamp friction
      OldTangentImpulse := C.Pt;
      C.Pt := Clamp(OldTangentImpulse + dPt,-MaxPt,MaxPt);
      dPt := C.Pt - OldTangentImpulse;
    end else begin
      MaxPt := FFriction * dPn;
      dPt := Clamp(dPt,-MaxPt,MaxPt);
    end;

		// Apply contact impulse
    Pt := dPt * Tangent;

    FBody1.PVelocity.Decrement(FBody1.InvMass * Pt);
    FBody1.AngularVelocity := FBody1.AngularVelocity - (FBody1.InvI * Cross(C.R1,Pt));

    FBody2.PVelocity.Increment(FBody2.InvMass * Pt);
    FBody2.AngularVelocity := FBody2.AngularVelocity + (FBody2.InvI * Cross(C.R2,Pt));
  end;
end;

constructor THGEArbiter.Create(const ABody1, ABody2: IHGEBody;
  const AContacts: TContacts; const ANumContacts: Integer);
var
  I: Integer;
begin
  inherited Create;
  Inc(HGEArbiterCount);
  if (Cardinal(ABody1) < Cardinal(ABody2)) then begin
    FBody1 := ABody1;
    FBody2 := ABody2;
  end else begin
    FBody1 := ABody2;
    FBody2 := ABody1;
  end;
  FNumContacts := ANumContacts;
  for I := 0 to FNumContacts - 1 do
    FContacts[I] := AContacts[I];
  FFriction := Sqrt(FBody1.Friction * FBody2.Friction);
end;

destructor THGEArbiter.Destroy;
begin
  FBody1 := nil;
  FBody2 := nil;
  FNext := nil;
  Dec(HGEArbiterCount);
  inherited;
end;

function THGEArbiter.GetBody1: IHGEBody;
begin
  Result := FBody1;
end;

function THGEArbiter.GetBody2: IHGEBody;
begin
  Result := FBody2;
end;

function THGEArbiter.GetNext: IHGEArbiter;
begin
  Result := FNext;
end;

function THGEArbiter.Implementor: TObject;
begin
  Result := Self;
end;

procedure THGEArbiter.PreStep(const InvDT: Single);
const
  AllowedPenetration = 0.01;
var
  BiasFactor, RN1, RN2, kNormal, RT1, RT2, kTangent: Single;
  I: Integer;
  C: PContact;
  R1, R2, Tangent, P: THGEVector;
begin
  if (THGEWorld.PositionCorrection) then
    if (THGEWorld.SplitImpules) then
      BiasFactor := 0.8
    else
      BiasFactor := 0.2
  else
    BiasFactor := 0;

  for I := 0 to FNumContacts - 1 do begin
    C := @FContacts[I];

    R1 := C.Position - FBody1.Position;
    R2 := C.Position - FBody2.Position;

		// Precompute normal mass, tangent mass, and bias.
    RN1 := R1.Dot(C.Normal);
    RN2 := R2.Dot(C.Normal);
    kNormal := FBody1.InvMass + FBody2.InvMass;
    kNormal := kNormal + (FBody1.InvI * (R1.Dot(R1) - RN1 * RN1)
      + FBody2.InvI * (R2.Dot(R2) - RN2 * RN2));
    C.MassNormal := 1 / kNormal;

    Tangent := Cross(C.Normal,1);
    RT1 := R1.Dot(Tangent);
    RT2 := R2.Dot(Tangent);
    kTangent := FBody1.InvMass + FBody2.InvMass;
    kTangent := kTangent + (FBody1.InvI * (R1.Dot(R1) - RT1 * RT1)
      + FBody2.InvI * (R2.Dot(R2) - RT2 * RT2));
    C.MassTangent := 1 / kTangent;

    C.Bias := -BiasFactor * InvDT * Min(0,C.Separation + AllowedPenetration);

    if (THGEWorld.AccumulateImpulses) then begin
			// Apply normal + friction impulse
      P := C.Pn * C.Normal + C.Pt * Tangent;

      FBody1.PVelocity.Decrement(FBody1.InvMass * P);
      FBody1.AngularVelocity := FBody1.AngularVelocity - (FBody1.InvI * Cross(R1,P));

      FBody2.PVelocity.Increment(FBody2.InvMass * P);
      FBody2.AngularVelocity := FBody2.AngularVelocity + (FBody2.InvI * Cross(R2,P));
    end;
  end;
end;

procedure THGEArbiter.SetNext(const Value: IHGEArbiter);
begin
  FNext := Value;
end;

procedure THGEArbiter.Update(const NewContacts: TContacts;
  const NewNumContacts: Integer);
var
  MergedContacts: TContacts;
  I, J, K: Integer;
  CNew, COld, C: PContact;
begin
  for I := 0 to NewNumContacts - 1 do begin
    CNew := @NewContacts[I];
    K := -1;
    for J := 0 to FNumContacts - 1 do begin
      COld := @FContacts[J];
      if (CNew.Feature.Value = COld.Feature.Value) then begin
        K := J;
        Break;
      end;
    end;

    if (K > -1) then begin
      C := @MergedContacts[I];
      COld := @FContacts[K];
      C^ := CNew^;
      if (THGEWorld.WarmStarting) then begin
        C.Pn := COld.Pn;
        C.Pt := COld.Pt;
        C.Pnb := COld.Pnb;
      end else begin
        C.Pn := 0;
        C.Pt := 0;
        C.Pnb := 0;
      end;
    end else
      MergedContacts[I] := NewContacts[I];
  end;

  for I := 0 to NewNumContacts - 1 do
    FContacts[I] := MergedContacts[I];

  FNumContacts := NewNumContacts;
end;

{ THGEArbiterList }

procedure THGEArbiterList.Add(const Arbiter: IHGEArbiter);
var
  HashCode: Cardinal;
begin
  HashCode := Hash(Arbiter.Body1,Arbiter.Body2);
  Arbiter.Next := FBuckets[HashCode];
  FBuckets[HashCode] := Arbiter;
  Inc(FCount);
end;

procedure THGEArbiterList.Clear;
var
  I: Integer;
  Entry, Next: IHGEArbiter;
begin
  FCurrentEntry := nil;
  for I := 0 to ArbiterHashSize - 1 do begin
    Entry := FBuckets[I];
    if Assigned(Entry) then begin
      FBuckets[I] := nil;
      while Assigned(Entry) do begin
        Next := Entry.Next;
        Entry.Next := nil;
        Entry := Next;
      end;
    end;
  end;
  FCount := 0;
  FCurrentIndex := -1;
end;

destructor THGEArbiterList.Destroy;
begin
  Clear;
  inherited;
end;

procedure THGEArbiterList.Erase(const Body1, Body2: IHGEBody);
var
  HashCode: Cardinal;
  B1, B2: IHGEBody;
  Entry, Prev: IHGEArbiter;
begin
  if (Cardinal(Body1) < Cardinal(Body2)) then begin
    B1 := Body1;
    B2 := Body2;
  end else begin
    B1 := Body2;
    B2 := Body1;
  end;

  HashCode := Hash(Body1,Body2);
  Prev := nil;
  Entry := FBuckets[HashCode];

  while Assigned(Entry) and ((Entry.Body1 <> B1) or (Entry.Body2 <> B2)) do begin
    Prev := Entry;
    Entry := Entry.Next;
  end;

  if Assigned(Entry) then begin
    if Assigned(Prev) then
      Prev.Next := Entry.Next
    else
      FBuckets[HashCode] := Entry.Next;
    Dec(FCount);
  end;
end;

function THGEArbiterList.Find(const Body1, Body2: IHGEBody): IHGEArbiter;
var
  HashCode: Cardinal;
  B1, B2: IHGEBody;
begin
  if (Cardinal(Body1) < Cardinal(Body2)) then begin
    B1 := Body1;
    B2 := Body2;
  end else begin
    B1 := Body2;
    B2 := Body1;
  end;

  HashCode := Hash(Body1,Body2);
  Result := FBuckets[HashCode];

  while Assigned(Result) and ((Result.Body1 <> B1) or (Result.Body2 <> B2)) do
    Result := Result.Next;
end;

function THGEArbiterList.First: IHGEArbiter;
begin
  FCurrentIndex := -1;
  FCurrentEntry := nil;
  Result := Next;
end;

function THGEArbiterList.GetCount: Integer;
begin
  Result := FCount;
end;

function THGEArbiterList.Hash(const Body1, Body2: IHGEBody): Cardinal;
begin
  Result := ((Cardinal(Body1) + Cardinal(Body2)) shr 4) and ArbiterHashMask;
end;

function THGEArbiterList.Next: IHGEArbiter;
begin
  if Assigned(FCurrentEntry) then
    Result := FCurrentEntry.Next
  else
    Result := nil;

  while (Result = nil) and (FCurrentIndex < ArbiterHashSize - 1) do begin
    Inc(FCurrentIndex);
    Result := FBuckets[FCurrentIndex];
  end;

  FCurrentEntry := Result;
end;

{ THGEWorld }

procedure THGEWorld.Add(const Joint: IHGEJoint);
begin
  FJoints.Add(Joint);
end;

procedure THGEWorld.BroadPhase;
var
  I, J, NumContacts: Integer;
  BI, BJ: IHGEBody;
  Arb: IHGEArbiter;
  Contacts: TContacts;
begin
	// O(n^2) broad-phase
  FillChar(Contacts,SizeOf(Contacts),0);
  for I := 0 to FBodies.Count - 1 do begin
    BI := FBodies[I];
    for J := I + 1 to FBodies.Count - 1 do begin
      BJ := FBodies[J];
      if (BI.InvMass <> 0) or (BJ.InvMass <> 0) then begin
        { Collide calculation depends on order of bodies as used by arbiter }
        if (Cardinal(BI) < Cardinal(BJ)) then
          NumContacts := Collide(Contacts,BI,BJ)
        else
          NumContacts := Collide(Contacts,BJ,BI);
        if (NumContacts > 0) then begin
          Arb := FArbiters.Find(BI,BJ);
          if Assigned(Arb) then
            THGEArbiter(Arb.Implementor).Update(Contacts,NumContacts)
          else begin
            Arb := THGEArbiter.Create(BI,BJ,Contacts,NumContacts);
            FArbiters.Add(Arb);
          end;
        end else
          FArbiters.Erase(BI,BJ);
      end;
    end;
  end;
end;

procedure THGEWorld.Add(const Body: IHGEBody);
begin
  FBodies.Add(Body);
end;

procedure THGEWorld.Clear;
begin
  FArbiters.Clear;
  FJoints.Clear;
  FBodies.Clear;
end;

constructor THGEWorld.Create(const AGravity: THGEVector;
  const AIterations: Integer);
begin
  inherited Create;
  FGravity := AGravity;
  FIterations := AIterations;
  FBodies := THGEBodyList.Create;
  FJoints := THGEJointList.Create;
  FArbiters := THGEArbiterList.Create;
end;

destructor THGEWorld.Destroy;
begin
  Clear;
  FArbiters := nil;
  FJoints := nil;
  FBodies := nil;
  inherited;
end;

function THGEWorld.GetArbiters: IHGEArbiterList;
begin
  Result := FArbiters;
end;

function THGEWorld.GetBodies: IHGEBodyList;
begin
  Result := FBodies;
end;

function THGEWorld.GetGravity: THGEVector;
begin
  Result := FGravity;
end;

function THGEWorld.GetIterations: Integer;
begin
  Result := FIterations;
end;

function THGEWorld.GetJoints: IHGEJointList;
begin
  Result := FJoints;
end;

procedure THGEWorld.Step(const DT: Single);
var
  InvDT: Single;
  I, J: Integer;
  B: IHGEBody;
  A: IHGEArbiter;
begin
  if (DT > 0) then
    InvDT := 1 / DT
  else
    InvDT := 0;

	// Determine overlapping bodies and update contact points.
  BroadPhase;

	// Integrate forces.
  for I := 0 to FBodies.Count - 1 do begin
    B := FBodies[I];
    if (B.InvMass <> 0) then begin
      B.PVelocity.Increment(DT * (FGravity + B.InvMass * B.Force));
      B.AngularVelocity := B.AngularVelocity + (DT * B.InvI * B.Torque);
  		// Bias velocities are reset to zero each step.
      B.BiasedVelocity := THGEVector.Create(0,0);
      B.BiasedAngularVelocity := 0;
    end;
  end;

	// Perform pre-steps.
  A := FArbiters.First;
  while Assigned(A) do begin
    A.PreStep(InvDT);
    A := FArbiters.Next;
  end;

  for I := 0 to FJoints.Count - 1 do
    FJoints[I].PreStep(InvDT);

	// Perform iterations
  for I := 0 to FIterations - 1 do begin
    A := FArbiters.First;
    while Assigned(A) do begin
      A.ApplyImpulse;
      A := FArbiters.Next;
    end;

    for J := 0 to FJoints.Count - 1 do
      FJoints[J].ApplyImpulse;
  end;

	// Integrate Velocities
  for I := 0 to FBodies.Count - 1 do begin
    B := FBodies[I];
    B.PPosition.Increment(DT * (B.Velocity + B.BiasedVelocity));
    B.Rotation := B.Rotation + (DT * (B.AngularVelocity + B.BiasedAngularVelocity));

    B.Force := THGEVector.Create(0,0);
    B.Torque := 0;
  end;
end;

initialization
  THGEWorld.AccumulateImpulses := True;
  THGEWorld.SplitImpules := True;
  THGEWorld.WarmStarting := True;
  THGEWorld.PositionCorrection := True;

end.
