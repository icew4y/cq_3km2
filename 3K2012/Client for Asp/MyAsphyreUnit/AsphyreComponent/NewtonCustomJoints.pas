{*******************************************************************************}
{                                                                               }
{      Newton Game Dynamics Custom Joints Delphi-Headertranslation              }
{       Current SDK version 1.53                                                }
{                                                                               }
{      Copyright (c) 2005,06 Sascha Willems                                     }
{                            Jon Walton                                         }
{                                                                               }
{*******************************************************************************}
{                                                                               }
{ License :                                                                     }
{                                                                               }
{  The contents of this file are used with permission, subject to               }
{  the Mozilla Public License Version 1.1 (the "License"); you may              }
{  not use this file except in compliance with the License. You may             }
{  obtain a copy of the License at                                              }
{  http://www.mozilla.org/MPL/MPL-1.1.html                                      }
{                                                                               }
{  Software distributed under the License is distributed on an                  }
{  "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or               }
{  implied. See the License for the specific language governing                 }
{  rights and limitations under the License.                                    }
{                                                                               }
{*******************************************************************************}
{  Custom Joints in SDK :             Implemented :                             }
{   - BallAndSocket                     Yes                                     }
{   - LimitedBallAndSocket              Yes                                     }
{   - CorkScrew                         Yes                                     }
{   - DryRollingFriction                Yes                                     }
{   - Gear                              Yes                                     }
{   - Hinge                             Yes                                     }
{   - Pulley                            Yes                                     }
{   - Slider                            Yes                                     }
{   - Universal                         Yes                                     }
{   - UpVector                          Yes                                     }
{   - WormGear                          Yes                                     }
{*******************************************************************************}

unit NewtonCustomJoints;

interface

uses
  Math,
  SysUtils,

  NewtonImport,
  NewtonCustomJoints_Math;
  
{$I delphinewton.inc}
{$IFDEF FPC}
 {$MODE DELPHI}
 {$APPTYPE GUI}
{$ENDIF}

type
 // TNewtonCustomBaseJoint =====================================================
 TNewtonCustomBaseJoint = Class(TObject)
  private
   FMaxDOF : Integer;
   FBody0  : PNewtonBody;
   FBody1  : PNewtonBody;
   FJoint  : PNewtonJoint;
   FWorld  : PNewtonWorld;
  public
   constructor Create(aMaxDOF : Integer; aBody0, aBody1 : PNewtonBody);
   destructor Destroy; override;
   procedure CalculateGlobalMatrix(const aLocalMatrix0, aLocalMatrix1 : TMatrix4f; out aMatrix0, aMatrix1 : TMatrix4f);
   procedure CalculateLocalMatrix(const aPivot, aDir : TVector3f; out aLocalMatrix0, aLocalMatrix1 : TMatrix4f);
   property Joint : PNewtonJoint read FJoint;
  protected
   procedure SubmitConstraint; virtual; abstract;
  end;                                 

 // TNewtonCustomJointUpVector =================================================
 TNewtonCustomJointUpVector = Class(TNewtonCustomBaseJoint)
  private
   FLocalMatrix0 : TMatrix4f;
   FLocalMatrix1 : TMatrix4f;
  public
   constructor Create(aPin: TVector3f; aBody : PNewtonBody);
   procedure SetPinDir(const aDir : TVector3f);
  protected
   procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointBallAndSocket ============================================
 TNewtonCustomJointBallAndSocket = Class(TNewtonCustomBaseJoint)
  private
   FLocalMatrix0 : TMatrix4f;
   FLocalMatrix1 : TMatrix4f;
  public
   constructor Create(aPivot : TVector3f; aChild, aParent : PNewtonBody);
  protected
   procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointLimitedBallAndSocket =====================================
 TNewtonCustomJointLimitedBallAndSocket = Class(TNewtonCustomJointBallAndSocket)
  private
   FConeAngle    : Single;
   FTwistAngle   : Single;
   FCosConeAngle : Single;
  public
    constructor Create(aPivot, aConeDir : TVector3f; aConeAngle, aTwistAngle : Single; aChild, aParent : PNewtonBody);
  protected
    procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointCorkScrew ================================================
 TNewtonCustomJointCorkScrew = Class(TNewtonCustomBaseJoint)
  private
   FLocalMatrix0   : TMatrix4f;
   FLocalMatrix1   : TMatrix4f;
   FLimitsOn       : Boolean;
   FMinDist        : Single;
   FMaxDist        : Single;
   FAngularMotorOn : Boolean;
   FAngularDamp    : Single;
   FAngularAccel   : Single;
  public
   constructor Create(aPivot, aPin : TVector3f; aChild, aParent : PNewtonBody);
   procedure EnableLimits(aEnabled : Boolean);
   procedure SetLimits(aMinDist, aMaxDist : Single);
  protected
    procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointSlider =============================================
 TNewtonCustomJointSlider = Class(TNewtonCustomBaseJoint)
  private
   FLocalMatrix0 : TMatrix4f;
   FLocalMatrix1 : TMatrix4f;
   FLimitsOn     : Boolean;
   FMinDist      : Single;
   FMaxDist      : Single;
  public
   constructor Create(aPivot, aPin : TVector3f; aChild, aParent : PNewtonBody);
   procedure EnableLimits(aEnabled : Boolean);
   procedure SetLimits(aMinDist, aMaxDist : Single);
  protected
   procedure SubmitConstraint; override;
  end;

  // TNewtonCustomJointHinge ===================================================
  TNewtonCustomJointHinge = Class(TNewtonCustomBaseJoint)
   private
    FLocalMatrix0   : TMatrix4f;
    FLocalMatrix1   : TMatrix4f;
    FLimitsOn       : Boolean;
    FMinAngle       : Single;
    FMaxAngle       : Single;
   public
    constructor Create(aPivot, aPin : TVector3f; aChild, aParent : PNewtonBody);
    procedure EnableLimits(aEnabled : Boolean);
    procedure SetLimits(aMinAngle, aMaxAngle : Single);
  protected
    procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointDryRollingFriction =======================================
 // This joint is usefull to simulate the rolling friction of a rolling ball over
 // a flat surface.
 // Normally this is not important for non spherical objects, but for games like
 // pool, pinball, bowling, golf or any other where the movement of balls is the
 // main objective, the rolling friction is a real big problem.
 TNewtonCustomJointDryRollingFriction = Class(TNewtonCustomBaseJoint)
  private
   FFrictionCoef   : Single;
   FFrictionTorque : Single;
  public
   constructor Create(aRadius, aCoefficient : Single; aChild : PNewtonBody);
  protected
   procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointUniversal ================================================
 TNewtonCustomJointUniversal = Class(TNewtonCustomBaseJoint)
  private
   FLocalMatrix0    : TMatrix4f;
   FLocalMatrix1    : TMatrix4f;
   FLimit0On        : Boolean;
   FLimit1On        : Boolean;
   FMinAngle0       : Single;
   FMaxAngle0       : Single;
   FMinAngle1       : Single;
   FMaxAngle1       : Single;
   FAngularMotor0On : Boolean;
   FAngularMotor1On : Boolean;
   FAngularDamp0    : Single;
   FAngularAccel0   : Single;
   FAngularDamp1    : Single;
   FAngularAccel1   : Single;
  public 
   constructor Create(aPivot, aPin0, aPin1 : TVector3f; aChild, aParent : PNewtonBody);
   procedure EnableLimit0(aEnabled : Boolean);
   procedure EnableLimit1(aEnabled : Boolean);
   procedure SetLimits0(aMinAngle, aMaxAngle : Single);
   procedure SetLimits1(aMinAngle, aMaxAngle : Single);
   procedure EnableMotor0(aEnabled : Boolean);
   procedure EnableMotor1(aEnabled : Boolean);
  protected
   procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointPulley ===================================================
 TNewtonCustomJointPulley = Class(TNewtonCustomBaseJoint)
  private
   FLocalMatrix0 : TMatrix4f;
   FLocalMatrix1 : TMatrix4f;
   FGearRatio    : Single;
  public
   property GearRatio : Single read FGearRatio write FGearRatio;
   constructor Create(aGearRatio : Single; aChildPin, aParentPin : TVector3f; aParentBody, aChildBody : PNewtonBody);
  protected
   procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointGear =====================================================
 TNewtonCustomJointGear = Class(TNewtonCustomBaseJoint)
  private
   FLocalMatrix0 : TMatrix4f;
   FLocalMatrix1 : TMatrix4f;
   FGearRatio    : Single;
  public
   property GearRatio : Single read FGearRatio write FGearRatio;
   constructor Create(aGearRatio : Single; aChildPin, aParentPin : TVector3f; aParentBody, aChildBody : PNewtonBody);
  protected
   procedure SubmitConstraint; override;
  end;

 // TNewtonCustomJointWormGear =================================================
 TNewtonCustomJointWormGear = Class(TNewtonCustomBaseJoint)
  private
   FLocalMatrix0 : TMatrix4f;
   FLocalMatrix1 : TMatrix4f;
   FGearRatio    : Single;
  public
   property GearRatio : Single read FGearRatio write FGearRatio;
   constructor Create(aGearRatio : Single; aRotationalPin, aLinearPin : TVector3f; aRotationalBody, aLinearBody : PNewtonBody);
  protected
   procedure SubmitConstraint; override;
  end;

implementation

const
  MIN_JOINT_PIN_LENGTH : Single = 50.0;

// =============================================================================
//  MatrixGrammSchmidt
// =============================================================================
function MatrixGrammSchmidt(const aDir: TVector3f): TMatrix4f;
var
 LUp    : TVector4f;
 LRight : TVector4f;
 LFront : TVector4f;
Begin
LFront := V4(aDir[0], aDir[1], aDir[2], 0);
LFront := VScale(LFront, 1.0 / sqrt(VDot(LFront, LFront)));
if abs(LFront[2]) > 0.577 then
 LRight := VCross(LFront, V4(-LFront[1], LFront[2], 0, 0))
else
 LRight := VCross(LFront, V4(-LFront[1], LFront[0], 0, 0));
LRight := VScale(LRight, 1.0 / sqrt(VDot(LRight, LRight)));
LUp    := VCross(LRight, LFront);
LFront[3] := 0;
LUp[3]    := 0;
LRight[3] := 0;
Matrix_SetColumn(Result, 0, LFront);
Matrix_SetColumn(Result, 1, LUp);
Matrix_SetColumn(Result, 2, LRight);
Matrix_SetColumn(Result, 3, V4(0,0,0,1));
end;

// =============================================================================
//  JointDestructor
// =============================================================================
procedure JointDestructor(const aJoint: PNewtonJoint); cdecl;
var
 LBaseJoint : TNewtonCustomBaseJoint;
Begin
LBaseJoint := TNewtonCustomBaseJoint(NewtonJointGetUserData(aJoint));
NewtonJointSetDestructor(aJoint, nil);
NewtonJointSetUserData(aJoint, nil);
FreeAndNil(LBaseJoint);
end;

// =============================================================================
//  SubmitJointConstraint
// =============================================================================
function SubmitJointConstraint(const aJoint: PNewtonJoint): unsigned_int; cdecl;
var
 LBaseJoint: TNewtonCustomBaseJoint;
begin
Result := 0;
LBaseJoint := TNewtonCustomBaseJoint(NewtonJointGetUserData(aJoint));
if LBaseJoint <> nil then
 LBaseJoint.SubmitConstraint;
end;


// *****************************************************************************
// *****************************************************************************
//  Base Joint
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomBaseJoint.Create(aMaxDOF: Integer; aBody0, aBody1: PNewtonBody);
begin
FBody0  := aBody0;
FBody1  := aBody1;
FMaxDOF := aMaxDOF;

FWorld := NewtonBodyGetWorld(aBody0);
// @SubmitJointConstraint not working in FP
FJoint := NewtonConstraintCreateUserJoint(FWorld, FMaxDOF, @SubmitJointConstraint, FBody0, FBody1);
//FJoint := NewtonConstraintCreateUserJoint(FWorld, FMaxDOF, @SubmitJointConstraint, FBody0, FBody1);

NewtonJointSetStiffness(FJoint, 1);
NewtonJointSetUserData(FJoint, Self);
NewtonJointSetDestructor(FJoint, @JointDestructor);
end;

destructor TNewtonCustomBaseJoint.Destroy;
begin
if NewtonJointGetUserData(FJoint) <> nil then
 begin
 NewtonJointSetDestructor(FJoint, nil);
 NewtonDestroyJoint(FWorld, FJoint);
 end;
end;

procedure TNewtonCustomBaseJoint.CalculateGlobalMatrix(const aLocalMatrix0, aLocalMatrix1: TMatrix4f; out aMatrix0, aMatrix1: TMatrix4f);
var
 LBody0Matrix: TMatrix4f;
 LBody1Matrix: TMatrix4f;
begin
// get the global matrices of each body
NewtonBodyGetMatrix(FBody0, @LBody0Matrix[0,0]);
LBody1Matrix := IdentityMatrix;
if FBody1 <> nil then
 NewtonBodyGetMatrix(FBody1, @LBody1Matrix[0,0]);
aMatrix0 := Matrix_Multiply(aLocalMatrix0, LBody0Matrix);
aMatrix1 := Matrix_Multiply(aLocalMatrix1, LBody1Matrix);
end;

procedure TNewtonCustomBaseJoint.CalculateLocalMatrix(const aPivot, aDir: TVector3f; out aLocalMatrix0, aLocalMatrix1: TMatrix4f);
var
 LMatrix0             : TMatrix4f;
 LMatrix1             : TMatrix4f;
 LPinAndPivoTMatrix4f : TMatrix4f;
 LInverseMatrix       : TMatrix4f;
begin
// get the global matrices of each body
NewtonBodyGetMatrix(FBody0, @LMatrix0[0, 0]);
LMatrix1 := IdentityMatrix;
if FBody1 <> nil then
 NewtonBodyGetMatrix(FBody1, @LMatrix1[0, 0]);
// create a global matrix at the pivot point with front vector aligned to the pin vector
LPinAndPivotMatrix4f := MatrixGrammSchmidt(aDir);
Matrix_SetTransform(LPinAndPivotMatrix4f, aPivot);

// calculate the relative matrix of the pin and pivot on each body
LInverseMatrix := LMatrix0;
Matrix_Inverse(LInverseMatrix);
aLocalMatrix0 := Matrix_Multiply(LPinAndPivotMatrix4f, LInverseMatrix);

LInverseMatrix := LMatrix1;
Matrix_Inverse(LInverseMatrix);
aLocalMatrix1 := Matrix_Multiply(LPinAndPivotMatrix4f, LInverseMatrix);
end;


// *****************************************************************************
// *****************************************************************************
//  Up Vector
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointUpVector.Create(aPin: TVector3f; aBody: PNewtonBody);
var
 LPivot    : TMatrix4f;
 LPivotPos : TVector3f;
begin
inherited
Create(2, aBody, nil);
NewtonBodyGetMatrix(aBody, @LPivot[0, 0]);
LPivotPos := V3(LPivot[3, 0], LPivot[3, 1], LPivot[3, 2]);
CalculateLocalMatrix(LPivotPos, aPin, FLocalMatrix0, FLocalMatrix1);
end;

procedure TNewtonCustomJointUpVector.SetPinDir(const aDir: TVector3f);
Begin
FLocalMatrix1 := MatrixGrammSchmidt(aDir);
end;

procedure TNewtonCustomJointUpVector.SubmitConstraint;
var
 LMag        : Single;
 LAngle      : Single;
 LMatrix0    : TMatrix4f;
 LMatrix1    : TMatrix4f;
 LLateralDir : TVector4f;
 LFrontDir   : TVector4f;
begin
// calculate the position of the pivot point and the jacoviam direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, LMatrix0, LMatrix1);

// if the body has rotated by some amount, there will be a plane of rotation
LLateralDir := VCross(V4(LMatrix0[0,0], LMatrix0[1,0], LMatrix0[2,0], LMatrix0[3,0]),
                      V4(LMatrix1[0,0], LMatrix1[1,0], LMatrix1[2,0], LMatrix1[3,0]));

LMag := VDot(LLateralDir, LLateralDir);
if LMag > 1.0e-6 then
 begin
 // if the vector is not 0 it means the body has rotated
 LMag := sqrt(LMag);
 VScale(LLateralDir, 1.0 / LMag);
 LAngle := ArcSin(LMag);

 // add an angular constraint to correct the error angle
 NewtonUserJointAddAngularRow(FJoint, LAngle, @LLateralDir[0]);

 // in theory only one correction is needed, but this produces instability as the body may move sideway.
 // a lateral correction prevent this from happening.
 LFrontDir := VCross(LLateralDir, V4(LMatrix1[0,0], LMatrix1[1,0], LMatrix1[2,0], LMatrix1[3,0]));
 NewtonUserJointAddAngularRow(FJoint, 0.0, @LFrontDir[0]);
 end
else
 begin
 // if the angle error is very small then two angular correction along the plane axis do the trick
 NewtonUserJointAddAngularRow(FJoint, 0.0, @LMatrix0[1, 0]);
 NewtonUserJointAddAngularRow(FJoint, 0.0, @LMatrix0[2, 0]);
 end;
end;


// *****************************************************************************
// *****************************************************************************
//  Ball and Socket
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointBallAndSocket.Create(aPivot: TVector3f; aChild, aParent: PNewtonBody);
var
 LMatrix : TMatrix4f;
 LPin    : TVector4f;
begin
inherited
Create(5, aChild, aParent);

// use as primary pin vector the line that goes from the pivot to the origin of body zero
// this eliminates some offset unwanted torques
NewtonBodyGetMatrix(FBody0, @LMatrix[0, 0]);

LPin := VSub(V4(LMatrix[0,3], LMatrix[1,3], LMatrix[2,3], LMatrix[3,3]), V4(aPivot[0], aPivot[1], aPivot[2], 0));

// the the pivot is already at the origin
if VDot(LPin, LPin) < 1.0e-3 then
 LPin := V4(LMatrix[0,0], LMatrix[1,0], LMatrix[2,0], LMatrix[3,0]);

// calculate the two local matrix of the pivot point
CalculateLocalMatrix(aPivot, V3(LPin[0], LPin[1], LPin[2]), FLocalMatrix0, FLocalMatrix1);
end;

procedure TNewtonCustomJointBallAndSocket.SubmitConstraint;
var
 LMatrix0 : TMatrix4f;
 LMatrix1 : TMatrix4f;
Begin
// calculate the position of the pivot point and the jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, LMatrix0, LMatrix1);

// Restrict the movement on the pivot point along all tree orthonormal direction
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[0, 0]);
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[1, 0]);
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[2, 0]);
end;


// *****************************************************************************
// *****************************************************************************
//  Limited Ball And Socket
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointLimitedBallAndSocket.Create(aPivot, aConeDir: TVector3f; aConeAngle, aTwistAngle: Single; aChild, aParent: PNewtonBody);
Begin
inherited
Create(aPivot, aChild, aParent);
FConeAngle    := aConeAngle * PI / 180;
FTwistAngle   := aTwistAngle * PI / 180;
FCosConeAngle := Cos(FConeAngle);
// Recalculate local matrices so that the front vector align with the cone pin
CalculateLocalMatrix(aPivot, aConeDir, FLocalMatrix0, FLocalMatrix1);
end;

procedure TNewtonCustomJointLimitedBallAndSocket.SubmitConstraint;
var
 LConeCos        : Single;
 LMatrix0        : TMatrix4f;
 LMatrix1        : TMatrix4f;
 LP0             : TVector4f;
 LP1             : TVector4f;
 LLateralDir     : TVector4f;
 LUnitLateralDir : TVector4f;
 LTangentDir     : TVector4f;
begin
// calculate the position of the pivot point and the Jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, LMatrix0, LMatrix1);

// Restrict the movement on the pivot point along all tree orthonormal direction
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[0, 0]);
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[1, 0]);
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[2, 0]);

// add a row to keep the child body inside the cone limit
// The child is inside the cone if the cos of the angle between the pin and
LConeCos := VDot(V4(LMatrix0[0,0], LMatrix0[1,0], LMatrix0[2,0], LMatrix0[3,0]), V4(LMatrix1[0,0], LMatrix1[1,0], LMatrix1[2,0], LMatrix1[3,0]));
if LConeCos < FCosConeAngle then
 begin
 // the child body has violated the cone limit we need to stop it from keep moving
 // for that we are going to pick a point along the the child body front vector
 LP0 := VAdd(V4(LMatrix0, 3), VScale(V4(LMatrix0,0), MIN_JOINT_PIN_LENGTH));
 LP1 := VAdd(V4(LMatrix1, 3), VScale(V4(LMatrix1,0), MIN_JOINT_PIN_LENGTH));

 // get a vectors perpendicular to the plane of motion
 LLateralDir := VCross(V4(LMatrix0,0), V4(LMatrix1,0));

 // note this could fail if the angle between matrix0.m_front and matrix1.m_front is 90 degree
 LUnitLateralDir := VScale(LLateralDir, 1.0 / sqrt(VDot(LLateralDir, LLateralDir)));

 // now we will add a constraint row along the lateral direction,
 // this will add stability as it will prevent the child body from moving sideways
 NewtonUserJointAddLinearRow(FJoint, @LP0[0], @LP0[0], @LUnitLateralDir[0]);

 // calculate the unit vector tangent to the trajectory
 LTangentDir := VCross(LUnitLateralDir, V4(LMatrix0,0));

 LP1 := VAdd(LP0, VScale(VSub(LP1, LP0), 0.2));
 NewtonUserJointAddLinearRow(FJoint, @LP0[0], @LP1[0], @LTangentdir[0]);

 // we need to allow the body to mo in opposite direction to the penetration
 // that can be done by setting the min friction to zero
 NewtonUserJointSetRowMinimumFriction(FJoint, 0.0);
 end;
end;


// *****************************************************************************
// *****************************************************************************
//  Corkscrew
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointCorkScrew.Create(aPivot, aPin: TVector3f; aChild, aParent: PNewtonBody);
Begin
inherited
Create(6, aChild, aParent);
FLimitsOn       := False;
FMinDist        := -1.0;
FMaxDist        := 1.0;
FAngularMotorOn := False;
FAngularDamp    := 0.1;
FAngularAccel   := 5.0;
// Calculate the two local matrix of the pivot point
CalculateLocalMatrix(aPivot, aPin, FLocalMatrix0, FLocalMatrix1);
end;

procedure TNewtonCustomJointCorkScrew.EnableLimits(aEnabled: Boolean);
Begin
FLimitsOn := aEnabled;
end;

procedure TNewtonCustomJointCorkScrew.SetLimits(aMinDist, aMaxDist: Single);
Begin
FMinDist := aMinDist;
FMaxDist := aMaxDist;
end;

procedure TNewtonCustomJointCorkScrew.SubmitConstraint;
var
 LDist     : Single;
 LMatrix0  : TMatrix4f;
 LMatrix1  : TMatrix4f;
 LP0       : TVector4f;
 LP1       : TVector4f;
 LQ0       : TVector4f;
 LQ1       : TVector4f;
 LRelOmega : Single;
 LRelAccel : Single;
 LOmega0   : TVector4f;
 LOmega1   : TVector4f;
begin
// Calculate the position of the pivot point and the Jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, LMatrix0, LMatrix1);

// Restrict the movement on the pivot point along all tree orthonormal direction
LP0 := V4(LMatrix0,3);
LP1 := VAdd(V4(LMatrix1,3), VScale(V4(LMatrix1,0), VDot(VSub(LP0, V4(LMatrix1,3)), V4(LMatrix1,0))));
NewtonUserJointAddLinearRow(FJoint, @LP0[0], @LP1[0], @LMatrix0[1, 0]);
NewtonUserJointAddLInearRow(FJoint, @LP0[0], @LP1[0], @LMatrix1[2, 0]);

// Get a point along the pin axis at some reasonable large distance from the pivot
LQ0 := VAdd(LP0, VScale(V4(LMatrix0,0), MIN_JOINT_PIN_LENGTH));
LQ1 := VAdd(LP1, VScale(V4(LMatrix1,0), MIN_JOINT_PIN_LENGTH));

// Two constraints row perpendiculars to the hinge pin
NewtonUserJointAddLinearRow(FJoint, @LQ0[0], @LQ1[0], @LMatrix0[1, 0]);
NewtonUserJointAddLinearRow(FJoint, @LQ0[0], @LQ1[0], @LMatrix0[2, 0]);

if FLimitsOn then
 begin
 LDist := VDot(VSub(V4(LMatrix0,3), V4(LMatrix1,3)), V4(LMatrix0,0));
 if LDist < FMinDist then
  begin
  // get a point along the up vector and set a constraint
  NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix0[3, 0], @LMatrix0[0, 0]);
  // allow the object to return but not to kick going forward
  NewtonUserJointSetRowMinimumFriction(FJoint, 0);
  end
 else
  if LDist > FMaxDist then
   begin
   // get a point along the up vector and set a constraint
   NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix0[3, 0], @LMatrix0[0, 0]);
   //  allow the object to return but not to kick going forward
   NewtonUserJointSetRowMaximumFriction(FJoint, 0);
   end;
  end;

 if FAngularMotorOn then
  begin
  LOmega0 := V4(0, 0, 0);
  LOmega1 := V4(0, 0, 0);

  // get relative angular velocity
  NewtonBodyGetOmega(FBody0, @LOmega0[0]);

  if FBody1 <> nil then
   NewtonBodyGetOmega(FBody1, @LOmega1[0]);

  // calculate the desired acceleration
  LRelOmega := VDot(VSub(LOmega0, LOmega1), V4(LMatrix0,0));
  LRelAccel := FAngularAccel - FAngularDamp * LRelOmega;

  // if the motor capability is on, then set angular acceleration with zero angular correction
  NewtonUserJointAddAngularRow(FJoint, 0.0, @LMatrix0[0, 0]);

  // override the angular acceleration for this Jacobian to the desired acceleration
  NewtonUserJointSetRowAcceleration(FJoint, LRelAccel);
  end;
end;

// *****************************************************************************
// *****************************************************************************
//  Slider
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointSlider.Create(aPivot, aPin: TVector3f; aChild, aParent: PNewtonBody);
begin
inherited
Create(6, aChild, aParent);

FLimitsOn := False;
FMinDist  := -1.0;
FMaxDist  := 1.0;

// calculate the two local matrix of the pivot point
CalculateLocalMatrix(aPivot, aPin, FLocalMatrix0, FLocalMatrix1);
end;

procedure TNewtonCustomJointSlider.EnableLimits(aEnabled: Boolean);
Begin
FLimitsOn := aEnabled;
end;

procedure TNewtonCustomJointSlider.SetLimits(aMinDist, aMaxDist: Single);
Begin
FMinDist := aMinDist;
FMaxDist := aMaxDist;
end;

procedure TNewtonCustomJointSlider.SubmitConstraint;
var
 LDist    : Single;
 LMatrix0 : TMatrix4f;
 LMatrix1 : TMatrix4f;
 LP0      : TVector4f;
 LP1      : TVector4f;
 LQ0      : TVector4f;
 LQ1      : TVector4f;
 LR0      : TVector4f;
 LR1      : TVector4f;
begin
// calculate the position of the pivot point and the Jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, LMatrix0, LMatrix1);

// Restrict the movement on the pivot point along all tree orthonormal direction
LP0 := V4(LMatrix0,3);
LP1 := VAdd(V4(LMatrix1,3), VScale(V4(LMatrix1,0), VDot(VSub(LP0, V4(LMatrix1,3)), V4(LMatrix1,0))));

NewtonUserJointAddLinearRow(FJoint, @LP0[0], @LP1[0], @LMatrix0[1, 0]);
NewtonUserJointAddLinearRow(FJoint, @LP0[0], @LP1[0], @LMatrix0[2, 0]);

// get a point along the ping axis at some reasonable large distance from the pivot
LQ0 := VAdd(LP0, VScale(V4(LMatrix0,0), MIN_JOINT_PIN_LENGTH));
LQ1 := VAdd(LP1, VScale(V4(LMatrix1,0), MIN_JOINT_PIN_LENGTH));

// two constraints row perpendicular to the pin
NewtonUserJointAddLinearRow(FJoint, @LQ0[0], @LQ1[0], @LMatrix0[1, 0]);
NewtonUserJointAddLinearRow(FJoint, @LQ0[0], @LQ1[0], @LMatrix0[2, 0]);

// get a point along the ping axis at some reasonable large distance from the pivot
LR0 := VAdd(LP0, VScale(V4(LMatrix0,1), MIN_JOINT_PIN_LENGTH));
LR1 := VAdd(LP0, VScale(V4(LMatrix1,1), MIN_JOINT_PIN_LENGTH));

// one constraint row perpendicular to the pin
NewtonUserJointAddLinearRow(FJoint, @LR0[0], @LR1[0], @LMatrix0[2, 0]);

if FLimitsOn then
 begin
 LDist := VDot(VSub(V4(LMatrix0,3), V4(LMatrix1,3)), V4(LMatrix0,0));
 if LDist < FMinDist then
  begin
  // get a point along the up vector and set a constraint
  NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix0[3, 0], @LMatrix0[0, 0]);

  // allow the object to return but not to kick going forward
  NewtonUserJointSetRowMinimumFriction(FJoint, 0.0);
  end
 else
  if LDist > FMaxDist then
   begin
   // invert the matrix for the stop limits on the other side. this is a bug fix for the origional SDK joint
   Matrix_Inverse(LMatrix1);

   // get a point along the up vector and set a constraint
   NewtonUserJointAddLinearRow(FJoint, @LMatrix1[3, 0], @LMatrix1[3, 0], @LMatrix1[0, 0]);

   // allow the object to return but not to kick going forward
   NewtonUserJointSetRowMinimumFriction(FJoint, 0.0);
   end;
 end;
end;

// *****************************************************************************
// *****************************************************************************
//  Hinge
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointHinge.Create(aPivot, aPin: TVector3f; aChild, aParent: PNewtonBody);
Begin
inherited Create(6, aChild, aParent);
FLimitsOn     := False;
FMinAngle     := -45 * PI / 180;
FMaxAngle     := 45 * PI / 180;
// calculate the two local matrix of the pivot point
CalculateLocalMatrix(aPivot, aPin, FLocalMatrix0, FLocalMatrix1);
end;

procedure TNewtonCustomJointHinge.EnableLimits(aEnabled: Boolean);
begin
FLimitsOn := aEnabled;
end;

procedure TNewtonCustomJointHinge.SetLimits(aMinAngle, aMaxAngle: Single);
begin
FMinAngle := aMinAngle * PI / 180;
FMaxAngle := aMaxAngle * PI / 180;
end;

procedure TNewtonCustomJointHinge.SubmitConstraint;
var
 LAngle    : Single;
 LSinAngle : Single;
 LCosAngle : Single;
 LRelAngle : Single;
 LMatrix0  : TMatrix4f;
 LMatrix1  : TMatrix4f;
 LQ0       : TVector4f;
 LQ1       : TVector4f;
begin
if FJoint = nil then
 exit;

// calculate the position of the pivot point and the Jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, LMatrix0, LMatrix1);

// Restrict the movement on the pivot point along all tree orthonormal direction
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[0, 0]);
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[1, 0]);
NewtonUserJointAddLinearRow(FJoint, @LMatrix0[3, 0], @LMatrix1[3, 0], @LMatrix0[2, 0]);

// get a point along the pin axis at some reasonable large distance from the pivot
LQ0 := VAdd(V4(LMatrix0,3), VScale(V4(LMatrix0,0), MIN_JOINT_PIN_LENGTH));
LQ1 := VAdd(V4(LMatrix0,3), VScale(V4(LMatrix0,0), MIN_JOINT_PIN_LENGTH));

// two constraints row perpendiculars to the hinge pin
NewtonUserJointAddLinearRow(FJoint, @LQ0[0], @LQ1[0], @LMatrix0[1, 0]);
NewtonUserJointAddLinearRow(FJoint, @LQ0[0], @LQ1[0], @LMatrix0[2, 0]);

// the joint angle can be determine by getting the angle between any two non parallel vectors
LSinAngle := VDot(V4(LMatrix0,0), VCross(V4(LMatrix0,1), V4(LMatrix1,1)));
LCosAngle := VDot(V4(LMatrix0,1), V4(LMatrix1,1));
LAngle    := ArcTan2(LSinAngle, LCosAngle);

// Limit angular movement
if FLimitsOn then
 begin
 if LAngle < FMinAngle then
  begin
  LRelAngle := LAngle - FMinAngle;
  // tell joint error will minimize the exceeded angle error
  NewtonUserJointAddAngularRow(FJoint, LRelAngle, @LMatrix0[0, 0]);
  // need high stiffness here
  NewtonUserJointSetRowStiffness(FJoint, 1.0);
  end
 else
  if LAngle > FMaxAngle then
   begin
   LRelAngle := LAngle - FMaxAngle;
   // tell joint error will minimize the exceeded angle error
   NewtonUserJointAddAngularRow(FJoint, LRelAngle, @LMatrix0[0, 0]);
   // need high stiffness here
   NewtonUserJointSetRowStiffness(FJoint, 1.0);
   end;
 end;
end;

// *****************************************************************************
// *****************************************************************************
//  Dry Rolling Friction
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointDryRollingFriction.Create(aRadius, aCoefficient: Single; aChild: PNewtonBody);
var
 LMass : Single;
 LIxx  : Single;
 LIyy  : Single;
 LIzz  : Single;
Begin
inherited
Create(1, aChild, nil);
NewtonBodyGetMassMatrix(aChild, @LMass, @LIxx, @LIyy, @LIzz);
FFrictionCoef   := aCoefficient;
FFrictionTorque := LIxx * aRadius;
end;

// rolling friction works as follow: the idealization of the contact of a spherical object
// with a another surface is a point that pass by the center of the sphere.
// in most cases this is enough to model the collision but in insufficient for modeling
// the rolling friction. In reality contact with the sphere with the other surface is not
// a point but a contact patch. A contact patch has the property the it generates a fix
// constant rolling torque that opposes the movement of the sphere.
// we can model this torque by adding a clamped torque aligned to the instantaneously axis
// of rotation of the ball. and with a magnitude of the stopping angular acceleration.
procedure TNewtonCustomJointDryRollingFriction.SubmitConstraint;
var
 LOmega          : TVector3f;
 LPin            : TVector3f;
 LTime           : Single;
 LOmegaMag       : Single;
 LTorqueFriction : Single;
Begin
// get the omega vector
NewtonBodyGetOmega(FBody0, @LOmega[0]);

LOmegaMag := sqrt(VDot(LOmega, LOmega));

if LOmegaMag > 0.1 then
 begin
 // Tell Newton to use the friction of the omega vector to apply the rolling friction
 LPin := VScale(LOmega, 1.0 / LOmegaMag);
 NewtonUserJointAddAngularRow(FJoint, 0.0, @LPin[0]);

 // calculate the acceleration to stop the ball in one time step
 LTime := NewtonGetTimeStep(FWorld);
 NewtonUserJointSetRowAcceleration(FJoint, -LOmegaMag / LTime);

 // set the friction limit proportional the sphere Inertia
 LTorqueFriction := FFrictionTorque * FFrictionCoef;
 NewtonUserJointSetRowMinimumFriction(FJoint, -LTorqueFriction);
 NewtonUserJointSetRowMaximumFriction(FJoint, LTorqueFriction);
 end
else
 begin
 // when omega is too low scale a little bit and damp the omega directly
 VScale(LOmega, 0.2);
 NewtonBodySetOmega(FBody0, @LOmega[0]);
 end;
end;


// *****************************************************************************
// *****************************************************************************
//  Universal
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointUniversal.Create(aPivot, aPin0, aPin1: TVector3f; aChild, aParent: PNewtonBody);
var
 LMatrix0      : TMatrix4f;
 LMatrix1      : TMatrix4f;
 LPinAndPivot  : TMatrix4f;
 LMatrixInvert : TMatrix4f;
 LPin0         : TVector4f;
 LPin1         : TVector4f;
begin
inherited
Create(6, aChild, aParent);

LPin0 := V4(aPin0[0], aPin0[1], aPin0[2]);
LPin1 := V4(aPin1[0], aPin1[1], aPin1[2]);

FMinAngle0 := -45 * PI / 180;
FMaxAngle0 :=  45 * PI / 180;

FMinAngle1 := -45 * PI / 180;
FMaxAngle1 :=  45 * PI / 180;

FAngularDamp0  := 0.5;
FAngularAccel0 := -4;

FAngularDamp1  := 0.3;
FAngularAccel1 := -4;

// get the global matrices of each rigid body.
NewtonBodyGetMatrix(FBody0, @LMatrix0[0, 0]);
LMatrix1 := IdentityMatrix;
if FBody1 <> nil then
  NewtonBodyGetMatrix(FBody1, @LMatrix1[0, 0]);

// create a global matrix at the pivot point with front vector aligned to the pin vector
Matrix_SetColumn(LPinAndPivot, 0, VScale(LPin0, 1.0 / sqrt(VDot(LPin0, LPin0))));
Matrix_SetColumn(LPinAndPivot, 2, VCross(LPin0, LPin1));
Matrix_SetColumn(LPinAndPivot, 2, VScale(V4(LPinAndPivot,2), 1.0 / sqrt(VDot(V4(LPinAndPivot,2), V4(LPinAndPivot,2)))));
Matrix_SetColumn(LPinAndPivot, 1, VCross(V4(LPinAndPivot,2), V4(LPinAndPivot,0)));
Matrix_SetColumn(LPinAndPivot, 3, V4(aPivot[0], aPivot[1], aPivot[2], 1));

// calculate the relative matrix of the pin and pivot on each body
LMatrixInvert := LMatrix0;
Matrix_Inverse(LMatrixInvert);
FLocalMatrix0 := Matrix_Multiply(LPinAndPivot, LMatrixInvert);

LMatrixInvert := LMatrix1;
Matrix_Inverse(LMatrixInvert);
FLocalMatrix1 := Matrix_Multiply(LPinAndPivot, LMatrixInvert);
end;

procedure TNewtonCustomJointUniversal.EnableLimit0(aEnabled: Boolean);
begin
FLimit0on := aEnabled;
end;

procedure TNewtonCustomJointUniversal.EnableLimit1(aEnabled: Boolean);
begin
FLimit1on := aEnabled;
end;

procedure TNewtonCustomJointUniversal.SetLimits0(aMinAngle, aMaxAngle: Single);
begin
FMinAngle0 := aMinAngle * PI / 180;
FMaxAngle0 := aMaxAngle * PI / 180;
end;

procedure TNewtonCustomJointUniversal.SetLimits1(aMinAngle, aMaxAngle: Single);
begin
FMinAngle1 := aMinAngle * PI / 180;
FMaxAngle1 := aMaxAngle * PI / 180;
end;

procedure TNewtonCustomJointUniversal.EnableMotor0(aEnabled: Boolean);
begin
FAngularMotor0On := aEnabled;
end;

procedure TNewtonCustomJointUniversal.EnableMotor1(aEnabled: Boolean);
begin
FAngularMotor1On := aEnabled;
end;

procedure TNewtonCustomJointUniversal.SubmitConstraint;
var
 LAngle    : Single;
 LSinAngle : Single;
 LCosAngle : Single;
 LRelAngle : Single;
 LRelOmega : Single;
 LRelAccel : Single;
 LMatrix0  : TMatrix4f;
 LMatrix1  : TMatrix4f;
 LDir0     : TVector4f;
 LDir1     : TVector4f;
 LDir2     : TVector4f;
 LDir3     : TVector4f;
 LP0       : TVector4f;
 LP1       : TVector4f;
 LQ0       : TVector4f;
 LQ1       : TVector4f;
 LOmega0   : TVector4f;
 LOmega1   : TVector4f;
begin
// calculate the position of the pivot point and the Jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, LMatrix0, LMatrix1);

// get the pin fixed to the first body
LDir0 := V4(LMatrix0, 0);
// get the pin fixed to the second body
LDir1 := V4(LMatrix1, 1);

// construct an othoganal coordinate system with these two vectors
LDir2 := VCross(LDir0, LDir1);
LDir3 := VCross(LDir2, LDir0);
LDir3 := VScale(LDir3, 1.0 / sqrt(VDot(LDir3, LDir3)));

LP0 := V4(LMatrix0, 3);
LP1 := V4(LMatrix1, 3);

LQ0 := VAdd(LP0, VScale(LDir3, MIN_JOINT_PIN_LENGTH));
LQ1 := VAdd(LP1, VScale(LDir1, MIN_JOINT_PIN_LENGTH));

NewtonUserJointAddLinearRow(FJoint, @LP0[0], @LP1[0], @LDir0[0]);
NewtonUserJointSetRowStiffness(FJoint, 1.0);

NewtonUserJointAddLinearRow(FJoint, @LP0[0], @LP1[0], @LDir1[0]);
NewtonUserJointSetRowStiffness(FJoint, 1.0);

NewtonUserJointAddLinearRow(FJoint, @LP0[0], @LP1[0], @LDir2[0]);
NewtonUserJointSetRowStiffness(FJoint, 1.0);

NewtonUserJointAddLinearRow(FJoint, @LQ0[0], @LQ1[0], @LDir0[0]);
NewtonUserJointSetRowStiffness(FJoint, 1.0);

if FLimit0On then
 begin
 LSinAngle := VDot(V4(LMatrix1,1), VCross(V4(LMatrix0,0), V4(LMatrix1,0)));
 LCosAngle := VDot(V4(LMatrix0,0), V4(LMatrix1,0));
 LAngle    := ArcTan2(LSinAngle, LCosAngle);
 if LAngle < FMinAngle0 then
  begin
  LRelAngle := LAngle - FMinAngle0;
  // tell joint error will minimize the exceeded angle error
  NewtonUserJointAddAngularRow(FJoint, LRelAngle, @LMatrix1[1, 0]);
  // need high stiffness here
  NewtonUserJointSetRowStiffness(FJoint, 1.0);
  end
 else
  if LAngle > FMaxAngle0 then
   begin
   LRelAngle := LAngle - FMaxAngle0;
   // tell joint error will minimize the exceeded angle error
   NewtonUserJointAddAngularRow(FJoint, LRelAngle, @LMatrix1[1, 0]);
   // need high stiffness here
   NewtonUserJointSetRowStiffness(FJoint, 1.0);
   end;
 end
 else
  if FAngularMotor0On then
   begin
   // get relative angular velocity
   NewtonBodyGetOmega(FBody0, @LOmega0[0]);
   if FBody1 <> nil then
    NewtonBodyGetOmega(FBody1, @LOmega1[0])
   else
    LOmega1 := V4(0,0,0,0);
   // calculate the desired acceleration
   LRelOmega := VDot(VSub(LOmega0, LOmega1), V4(LMatrix1, 1));
   LRelAccel := FAngularAccel0 - FAngularDamp0 * LRelOmega;
   // add an angular constraint row that will set the relative acceleration to zero
   NewtonUserJointAddAngularRow(FJoint, 0.0, @LMatrix1[1, 0]);
   NewtonUserJointSetRowAcceleration(FJoint, LRelAccel);
   end;

if FLimit1On then
 begin
 LSinAngle := VDot(V4(LMatrix0, 0), VCross(V4(LMatrix0, 1), V4(LMatrix1, 1)));
 LCosAngle := VDot(V4(LMatrix0, 1), V4(LMatrix1, 1));
 LAngle    := ArcTan2(LSinAngle, LCosAngle);
 if LAngle < FMinAngle1 then
  begin
  LRelAngle := LAngle - FMinAngle1;
  // tell joint error will minimize the exceeded angle error
  NewtonUserJointAddAngularRow(FJoint, LRelAngle, @LMatrix0[0, 0]);
  // need high stiffness here
  NewtonUserJointSetRowStiffness(FJoint, 1.0);
  end
 else
  if LAngle > FMaxAngle1 then
   begin
   LRelAngle := LAngle - FMaxAngle1;
   // tell joint error will minimize the exceeded angle error
   NewtonUserJointAddAngularRow(FJoint, LRelAngle, @LMatrix0[0, 0]);
   // need high stiffness here
   NewtonUserJointSetRowStiffness(FJoint, 1.0);
   end;
  end
 else
  if FAngularMotor1On then
   begin
   // get relative angular velocity
   NewtonBodyGetOmega(FBody0, @LOmega0[0]);
   if FBody1 <> nil then
     NewtonBodyGetOmega(FBody1, @LOmega1[0])
   else
    LOmega1 := V4(0,0,0,0);
   // calculate the desired acceleration
   LRelOmega := VDot(VSub(LOmega0, LOmega1), V4(LMatrix0, 0));
   LRelAccel := FAngularAccel1 - FAngularDamp1 * LRelOmega;
   // add an angular constraint row that will set the relative acceleration to zero
   NewtonUserJointAddAngularRow(FJoint, 0.0, @LMatrix0[0, 0]);
   NewtonUserJointSetRowAcceleration(FJoint, LRelAccel);
   end;
end;

// *****************************************************************************
// *****************************************************************************
//  Gear
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointGear.Create(aGearRatio : Single; aChildPin, aParentPin : TVector3f; aParentBody, aChildBody : PNewtonBody);
var
 Pivot       : TVector3f;
 DummyMatrix : TMatrix4f;
begin
inherited Create(1, aChildBody, aParentBody);
FGearRatio := aGearRatio;
// calculate the two local matrix of the pivot point
Pivot := V3(0, 0, 0);
// calculate the local matrix for body body0
CalculateLocalMatrix(Pivot, aChildPin, FLocalMatrix0, DummyMatrix);
// calculate the local matrix for body body1
CalculateLocalMatrix(Pivot, aParentPin, DummyMatrix, FlocalMatrix1);
end;

procedure TNewtonCustomJointGear.SubmitConstraint;
var
 w0, w1    : Single;
 Time      : Single;
 RelAccel  : Single;
 RelOmega  : Single;
 Omega0    : TVector3f;
 Omega1    : TVector3f;
 Matrix0   : TMatrix4f;
 Matrix1   : TMatrix4f;
 Jacobian0 : array[0..5] of Single;
 Jacobian1 : array[0..5] of Single;
begin
// calculate the position of the pivot point and the Jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, Matrix0, Matrix1);
// calculate the angular velocity for both bodies
NewtonBodyGetOmega(FBody0, @Omega0[0]);
NewtonBodyGetOmega(FBody1, @Omega1[0]);
// get angular velocity relative to the pin vector
w0 := VDot(Omega0, V3(Matrix0, 0));
w1 := VDot(Omega1, V3(Matrix1, 0));
// establish the gear equation.
RelOmega := w0 + FGearRatio * w1;
// calculate the relative angular acceleration by dividing by the time step
Time     := NewtonGetTimeStep(FWorld);
RelAccel := -RelOmega / Time;
// set the linear part of Jacobian 0 to zero
Jacobian0[0] := 0;
Jacobian0[1] := 0;
Jacobian0[2] := 0;
// set the angular part of Jacobian 0 pin vector
Jacobian0[3] := V3(Matrix0, 0)[0];
Jacobian0[4] := V3(Matrix0, 0)[1];
Jacobian0[5] := V3(Matrix0, 0)[2];
// set the linear part of Jacobian 1 to zero
Jacobian1[0] :=	0;
Jacobian1[1] :=	0;
Jacobian1[2] :=	0;
// set the angular part of Jacobian 1 pin vector
Jacobian1[3] := V3(matrix1, 0)[0];
Jacobian1[4] := V3(matrix1, 0)[1];
Jacobian1[5] := V3(matrix1, 0)[2];
// add a angular constraint
NewtonUserJointAddGeneralRow(FJoint, @Jacobian0[0], @Jacobian1[0]);
// set the desired angular acceleration between the two bodies
NewtonUserJointSetRowAcceleration(FJoint, RelAccel);
end;


// *****************************************************************************
// *****************************************************************************
//  Pulley
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointPulley.Create(aGearRatio : Single; aChildPin, aParentPin : TVector3f; aParentBody, aChildBody : PNewtonBody);
var
 Pivot       : TVector3f;
 DummyMatrix : TMatrix4f;
begin
inherited Create(1, aChildBody, aParentBody);
FGearRatio := aGearRatio;
// calculate the two local matrix of the pivot point
Pivot := V3(0, 0, 0);
// calculate the local matrix for body body0
CalculateLocalMatrix(Pivot, aChildPin, FLocalMatrix0, DummyMatrix);
// calculate the local matrix for body body1
CalculateLocalMatrix(Pivot, aParentPin, DummyMatrix, FlocalMatrix1);
end;

procedure TNewtonCustomJointPulley.SubmitConstraint;
var
 w0, w1    : Single;
 Time      : Single;
 RelAccel  : Single;
 RelVeloc  : Single;
 Veloc0    : TVector3f;
 Veloc1    : TVector3f;
 Matrix0   : TMatrix4f;
 Matrix1   : TMatrix4f;
 Jacobian0 : array[0..5] of Single;
 Jacobian1 : array[0..5] of Single;
begin
// calculate the position of the pivot point and the Jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, Matrix0, Matrix1);
// calculate the angular velocity for both bodies
NewtonBodyGetVelocity(FBody0, @Veloc0[0]);
NewtonBodyGetVelocity(FBody1, @Veloc1[0]);
// get angular velocity relative to the pin vector
w0 := VDot(Veloc0, V3(Matrix0, 0));
w1 := VDot(Veloc1, V3(Matrix1, 0));
// establish the gear equation.
RelVeloc := w0 + FGearRatio * w1;
// calculate the relative angular acceleration by dividing by the time step
Time     := NewtonGetTimeStep(FWorld);
RelAccel := -RelVeloc / Time;
// set the linear part of Jacobian 0 to translational pin vector
Jacobian0[0] := V3(Matrix0, 0)[0];
Jacobian0[1] := V3(Matrix0, 0)[1];
Jacobian0[2] := V3(Matrix0, 0)[2];
// set the rotational part of Jacobian 0 to zero
Jacobian0[3] := 0;
Jacobian0[4] := 0;
Jacobian0[5] := 0;
// set the linear part of Jacobian 1 to translational pin vector
Jacobian1[0] :=	V3(matrix1, 0)[0];
Jacobian1[1] :=	V3(matrix1, 0)[1];
Jacobian1[2] :=	V3(matrix1, 0)[2];
// set the rotational part of Jacobian 1 to zero
Jacobian1[3] := 0;
Jacobian1[4] := 0;
Jacobian1[5] := 0;
// add a angular constraint
NewtonUserJointAddGeneralRow(FJoint, @Jacobian0[0], @Jacobian1[0]);
// set the desired angular acceleration between the two bodies
NewtonUserJointSetRowAcceleration(FJoint, RelAccel);
end;


// *****************************************************************************
// *****************************************************************************
//  Worm Gear
// *****************************************************************************
// *****************************************************************************
constructor TNewtonCustomJointWormGear.Create(aGearRatio : Single; aRotationalPin, aLinearPin : TVector3f; aRotationalBody, aLinearBody : PNewtonBody);
var
 Pivot       : TVector3f;
 DummyMatrix : TMatrix4f;
begin
inherited Create(1, aRotationalBody, aLinearBody);
FGearRatio := aGearRatio;
// calculate the two local matrix of the pivot point
Pivot := V3(0, 0, 0);
// calculate the local matrix for body body0
CalculateLocalMatrix(Pivot, aRotationalPin, FLocalMatrix0, DummyMatrix);
// calculate the local matrix for body body1
CalculateLocalMatrix(Pivot, aLinearPin, DummyMatrix, FlocalMatrix1);
end;

procedure TNewtonCustomJointWormGear.SubmitConstraint;
var
 w0, w1    : Single;
 Time      : Single;
 RelAccel  : Single;
 RelVeloc  : Single;
 Omega0    : TVector3f;
 Veloc1    : TVector3f;
 Matrix0   : TMatrix4f;
 Matrix1   : TMatrix4f;
 Jacobian0 : array[0..5] of Single;
 Jacobian1 : array[0..5] of Single;
begin
// calculate the position of the pivot point and the Jacobian direction vectors, in global space.
CalculateGlobalMatrix(FLocalMatrix0, FLocalMatrix1, Matrix0, Matrix1);
// calculate the angular velocity for both bodies
NewtonBodyGetOmega(FBody0, @Omega0[0]);
NewtonBodyGetVelocity(FBody1, @Veloc1[0]);
// get angular velocity relative to the pin vector
w0 := VDot(Omega0, V3(Matrix0, 0));
w1 := VDot(Veloc1, V3(Matrix1, 0));
// establish the gear equation.
RelVeloc := w0 + FGearRatio * w1;
// calculate the relative angular acceleration by dividing by the time step
Time     := NewtonGetTimeStep(FWorld);
RelAccel := -RelVeloc / Time;
// set the linear part of Jacobian 0 to zero
Jacobian0[0] := 0;
Jacobian0[1] := 0;
Jacobian0[2] := 0;
// set the rotational part of Jacobian 0 to pin vector
Jacobian0[3] := V3(Matrix0, 0)[0];
Jacobian0[4] := V3(Matrix0, 0)[0];
Jacobian0[5] := V3(Matrix0, 0)[0];
// set the linear part of Jacobian 1 to translational pin vector
Jacobian1[0] :=	V3(matrix1, 0)[0];
Jacobian1[1] :=	V3(matrix1, 0)[1];
Jacobian1[2] :=	V3(matrix1, 0)[2];
// set the rotational part of Jacobian 1 to zero
Jacobian1[3] := 0;
Jacobian1[4] := 0;
Jacobian1[5] := 0;
// add a angular constraint
NewtonUserJointAddGeneralRow(FJoint, @Jacobian0[0], @Jacobian1[0]);
// set the desired angular acceleration between the two bodies
NewtonUserJointSetRowAcceleration(FJoint, RelAccel);
end;


end.
