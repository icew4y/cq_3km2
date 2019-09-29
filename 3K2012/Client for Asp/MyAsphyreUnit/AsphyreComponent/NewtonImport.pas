{*******************************************************************************}
{                                                                               }
{      Newton Game Dynamics Delphi-Headertranslation                            }
{       Current SDK version 1.53                                                }
{                                                                               }
{      Copyright (c) 2004,05,06 Sascha Willems                                  }
{                               Jon Walton                                      }
{                               Dominique Louis                                 }
{                                                                               }
{      Initial Author : S.Spasov (Sury)                                         }
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
{                                                                               }
{  See "Readme_NewtonImport.txt" for more information and detailed history      }
{                                                                               }
{*******************************************************************************}

unit NewtonImport;

{$I delphinewton.inc}

//{$DEFINE NEWTON_DOUBLE_PRECISION} // This is needed when you want to use double precision

interface

uses
{$IFDEF __GPC__}
  system,
  gpc,
{$ENDIF}

{$IFDEF UNIX}
{$IFDEF FPC}
{$IFDEF Ver1_0}
  linux,
{$ELSE}
  pthreads,
  baseunix,
  unix,
{$ENDIF}
  x,
  xlib,
{$ELSE}
  Types,
  Libc,
  Xlib,
{$ENDIF}
{$ENDIF}

{$IFDEF __MACH__}
  GPCMacOSAll,
{$ENDIF}
  Classes;

const
{$IFDEF WIN32}
  NewtonDLL = 'Newton.dll';
{$ENDIF}

{$IFDEF UNIX}
{$IFDEF DARWIN} // MacOS X
  NewtonDLL = 'libnewton.dylib';
{$ELSE}
  NewtonDLL = 'libnewton.so';
{$ENDIF}
{$ENDIF}

{$IFDEF MACOS}
  NewtonDLL = 'libnewton';
{$ENDIF}

(*Comment this line if you get weird errors*)
{$DEFINE NICE_CODE_PARAMS}

type
{I did this to speed up the translation process and avoid bugs}
{if you don't like me screw up the Delphi syntax with those
(C++ types just do a simple find and replace =)

{Pascal to C++}
  {simple types}
  Bool = Boolean;
  {$IFDEF NEWTON_DOUBLE_PRECISION}
   Float = Double;
  {$ELSE}
   Float = Single;
  {$ENDIF}
  Long_double = Extended;

  Int = Integer;
  __int8 = ShortInt;
  __int16 = SmallInt;
  __int32 = LongInt;
  __int64 = Int64;
  NChar = ShortInt;
  Unsigned_char = Byte;
  Short = SmallInt;
  Unsigned_short = Word;
  Long = LongInt;
  Unsigned_long = LongWord;
  Unsigned_int = Cardinal;
  size_t = Cardinal;

  {Pointer types}
  Pvoid = Pointer; //void pointer
  PBool = ^Bool;
  PFloat = ^Float;
  PLong_double = ^Long_double;

  PInt = ^Int;
  P__int8 = ^__int8;
  P__int16 = ^__int16;
  P__int32 = ^__int32;
  P__int64 = ^__int64;
  P2Char = ^NChar;
  PUnsigned_char = ^Unsigned_char;
  PShort = ^Short;
  PUnsigned_short = ^Unsigned_short;
  PLong = ^Long;
  PUnsigned_long = ^Unsigned_long;
  PUnsigned_int = ^Unsigned_int;
  Psize_t = ^size_t;

{end Pascal to C++}

  {well this might look stupid
  but i did it in order to make
  code complete and code parameters hint window
  to show the actual type for ex. PNewtonWorld
  instead of just "Pointer" , thus making programming a lot easier}
{$IFDEF NICE_CODE_PARAMS}
  PNewtonBody = ^Pointer;
  PNewtonWorld = ^Pointer;
  PNewtonJoint = ^Pointer;
  PNewtonContact = ^Pointer;
  PNewtonMaterial = ^Pointer;
  PNewtonCollision = ^Pointer;

  PNewtonRagDoll = ^Pointer;
  PNewtonRagDollBone = ^Pointer;
{$ELSE}

  PNewtonBody = Pointer;
  PNewtonWorld = Pointer;
  PNewtonJoint = Pointer;
  PNewtonContact = Pointer;
  PNewtonMaterial = Pointer;
  PNewtonCollision = Pointer;

  PNewtonRagDoll = Pointer;
  PNewtonRagDollBone = Pointer;
{$ENDIF}


  PNewtonUserMeshCollisionCollideDesc = ^NewtonUserMeshCollisionCollideDesc;
  NewtonUserMeshCollisionCollideDesc = record
    m_boxP0               : array[ 0..3 ] of float;
    m_boxP1               : array[ 0..3 ] of float;
    m_userData            : Pointer;
    m_faceCount           : int;
    m_vertex              : ^float;
    m_vertexStrideInBytes : int;
    m_userAttribute       : ^int;
    m_faceIndexCount      : ^int;
    m_faceVertexIndex     : ^int;
    m_objBody             : PNewtonBody;
    m_polySoupBody        : PNewtonBody;
  end;


  PNewtonUserMeshCollisionRayHitDesc = ^NewtonUserMeshCollisionRayHitDesc;
  NewtonUserMeshCollisionRayHitDesc = record
    m_p0        : array[ 0..3 ] of float;
    m_p1        : array[ 0..3 ] of float;
    m_normalOut : array[ 0..3 ] of float;
    m_userId    : int;
    m_thickness : float;
    m_userData  : Pointer;
  end;


  PNewtonHingeSliderUpdateDesc = ^NewtonHingeSliderUpdateDesc;
  NewtonHingeSliderUpdateDesc = record
    m_accel       : float;
    m_minFriction : float;
    m_maxFriction : float;
    m_timestep    : float;
  end;

// *****************************************************************************************************************************
//
//  Callbacks
//
// *****************************************************************************************************************************
NewtonAllocMemory = function( sizeInBytes : int ) : Pointer; cdecl;
PNewtonAllocMemory = ^NewtonAllocMemory;

NewtonFreeMemory = procedure( ptr : Pointer; sizeInBytes : int ); cdecl;
PNewtonFreeMemory = ^NewtonFreeMemory;

NewtonSerialize = procedure( serializeHandle : Pointer; const buffer : Pointer; size : size_t ); cdecl;
PNewtonSerialize = ^NewtonSerialize;

NewtonDeserialize = procedure( serializeHandle : Pointer; buffer : Pointer; size : size_t ); cdecl;
PNewtonDeserialize = ^NewtonDeserialize;

NewtonUserMeshCollisionCollideCallback = procedure( NewtonUserMeshCollisionCollideDesc : PNewtonUserMeshCollisionCollideDesc ); cdecl;
PNewtonUserMeshCollisionCollideCallback = ^NewtonUserMeshCollisionCollideCallback;

NewtonUserMeshCollisionRayHitCallback = function( NewtonUserMeshCollisionRayHitDesc : PNewtonUserMeshCollisionRayHitDesc ) : int; cdecl;
PNewtonUserMeshCollisionRayHitCallback = ^NewtonUserMeshCollisionRayHitCallback;

NewtonUserMeshCollisionDestroyCallback = procedure( descData : Pointer ); cdecl;
PNewtonUserMeshCollisionDestroyCallback = ^NewtonUserMeshCollisionDestroyCallback;

NewtonTreeCollisionCallback = procedure( const bodyWithTreeCollision : PNewtonBody; const body : PNewtonBody;
                                         const vertex : PFloat; vertexstrideInBytes : int;
                                         indexCount : int; const indexArray : PInt ); cdecl;
PNewtonTreeCollisionCallback = ^NewtonTreeCollisionCallback;

NewtonBodyDestructor = procedure( const body : PNewtonBody ); cdecl;
PNewtonBodyDestructor = ^NewtonBodyDestructor;

NewtonApplyForceAndTorque = procedure( const body : PNewtonBody ); cdecl;
PNewtonApplyForceAndTorque = ^NewtonApplyForceAndTorque;

NewtonBodyActivationState = procedure( const body : PNewtonBody; state : unsigned_int ); cdecl;
PNewtonBodyActivationState = ^NewtonBodyActivationState;

NewtonSetTransform = procedure( const body : PNewtonBody; const matrix : PFloat ); cdecl;
PNewtonSetTransform = ^NewtonSetTransform;

NewtonSetRagDollTransform = procedure( const bone : PNewtonRagDollBone ); cdecl;
PNewtonSetRagDollTransform = ^NewtonSetRagDollTransform;

NewtonGetBuoyancyPlane = function(const collisionID : Int; context : Pointer; const globalSpaceMatrix : PFloat; globalSpacePlane : PFloat ) : Int; cdecl;
PNewtonGetBuoyancyPlane = ^NewtonGetBuoyancyPlane;

NewtonVehicleTireUpdate = procedure( const vehicle: PNewtonJoint ); cdecl;
PNewtonVehicleTireUpdate = ^NewtonVehicleTireUpdate;

NewtonWorldRayPrefilterCallback = function (const body : PNewtonBody; const collision : PNewtonCollision) : cardinal; cdecl;
PNewtonWorldRayPrefilterCallback = ^NewtonWorldRayPrefilterCallback;
NewtonWorldRayFilterCallback = function( const body : PNewtonBody; const hitNormal: PFloat; collisionID : Int; userData: Pointer; intersetParam: Float ) : Float; cdecl;
PNewtonWorldRayFilterCallback = ^NewtonWorldRayFilterCallback;

NewtonBodyLeaveWorld = procedure( const body : PNewtonBody ); cdecl;
PNewtonBodyLeaveWorld = ^NewtonBodyLeaveWorld;

NewtonContactBegin = function( const material : PNewtonMaterial; const body0 : PNewtonBody; const body1 : PNewtonBody ) : int; cdecl;
PNewtonContactBegin = ^NewtonContactBegin;

NewtonContactProcess = function( const material : PNewtonMaterial; const contact : PNewtonContact ) : int; cdecl;
PNewtonContactProcess = ^NewtonContactProcess;

NewtonContactEnd = procedure( const material : PNewtonMaterial ); cdecl;
PNewtonContactEnd = ^NewtonContactEnd;

NewtonBodyIterator = procedure( const body : PNewtonBody ); cdecl;
PNewtonBodyIterator = ^NewtonBodyIterator;

NewtonCollisionIterator = procedure( const body : PNewtonBody; vertexCount : int; const FaceArray : PFloat; faceId : int ); cdecl;
PNewtonCollisionIterator = ^NewtonCollisionIterator;

NewtonBallCallBack = procedure( const ball : PNewtonJoint ); cdecl;
PNewtonBallCallBack = ^NewtonBallCallBack;

NewtonHingeCallBack = function( const hinge : PNewtonJoint; desc : PNewtonHingeSliderUpdateDesc ) : Unsigned_int; cdecl;
PNewtonHingeCallBack = ^NewtonHingeCallBack;

NewtonSliderCallBack = function( const slider : PNewtonJoint; desc : PNewtonHingeSliderUpdateDesc ) : Unsigned_int; cdecl;
PNewtonSliderCallBack = ^NewtonSliderCallBack;

NewtonUniversalCallBack = function( const universal : PNewtonJoint; desc : PNewtonHingeSliderUpdateDesc ) : Unsigned_int; cdecl;
PNewtonUniversalCallBack = ^NewtonUniversalCallBack;

NewtonCorkscrewCallBack = function( const corkscrew : PNewtonJoint; desc : PNewtonHingeSliderUpdateDesc ) : Unsigned_int; cdecl;
PNewtonCorkscrewCallBack = ^NewtonCorkscrewCallBack;

NewtonUserBilateralCallBack = function( const userJoint: PNewtonJoint): unsigned_int; cdecl;
PNewtonUserBilateralCallBack = ^NewtonUserBilateralCallBack;

NewtonConstraintDestructor = procedure( const me : PNewtonJoint ); cdecl;
PNewtonConstraintDestructor = ^NewtonConstraintDestructor;


// *****************************************************************************************************************************
//
// world control functions
//
// *****************************************************************************************************************************
function  NewtonCreate( malloc : NewtonAllocMemory; mfree : NewtonFreeMemory ) : PNewtonWorld; cdecl; external{$IFDEF __GPC__}name 'NewtonCreate'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonDestroy( const newtonWorld : PNewtonWorld ); cdecl; external{$IFDEF __GPC__}name 'NewtonDestroy'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonDestroyAllBodies( const newtonWorld : PNewtonWorld ); cdecl; external{$IFDEF __GPC__}name 'NewtonDestroyAllBodies'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonUpdate( const newtonWorld : PNewtonWorld; timestep : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonUpdate'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonSetPlatformArchitecture (const newtonWorld : PNewtonWorld; mode : Integer); cdecl; external{$IFDEF __GPC__}name 'NewtonSetPlatformArchitecture'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonSetSolverModel(const NewtonWorld : PNewtonWorld; Model : Int); cdecl; external{$IFDEF __GPC__}name 'NewtonSetSolverModel'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonSetFrictionModel(const NewtonWorld : PNewtonWorld; Model : Int); cdecl; external{$IFDEF __GPC__}name 'NewtonSetFrictionModel'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonGetTimeStep(const NewtonWorld : PNewtonWorld) :Float; cdecl; external{$IFDEF __GPC__}name 'NewtonGetTimeStep'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonSetMinimumFrameRate( const newtonWorld : PNewtonWorld; frameRate : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonSetMinimumFrameRate'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonSetBodyLeaveWorldEvent( const newtonWorld : PNewtonWorld; callback : PNewtonBodyLeaveWorld ); cdecl; external{$IFDEF __GPC__}name 'NewtonSetBodyLeaveWorldEvent'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonSetWorldSize( const newtonWorld : PNewtonWorld; const minPoint : PFloat; const maxPoint : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonSetWorldSize'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonWorldFreezeBody( const newtonWorld : PNewtonWorld; const body : PNewtonBody ); cdecl; external{$IFDEF __GPC__}name 'NewtonWorldFreezeBody'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonWorldUnfreezeBody( const newtonWorld : PNewtonWorld; const body : PNewtonBody ); cdecl; external{$IFDEF __GPC__}name 'NewtonWorldUnfreezeBody'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonWorldForEachBodyDo( const newtonWorld : PNewtonWorld; callback : PNewtonBodyIterator ); cdecl; external{$IFDEF __GPC__}name 'NewtonWorldForEachBodyDo'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonWorldForEachBodyInAABBDo (const newtonWorld : PNewtonWorld; const p0 : PFloat; const p1 : PFloat; callback : PNewtonBodyIterator); cdecl; external{$IFDEF __GPC__}name 'NewtonWorldForEachBodyInAABBDo'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonWorldSetUserData( const newtonWorld : PNewtonWorld; userData : Pointer); cdecl; external{$IFDEF __GPC__}name 'NewtonWorldSetUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonWorldGetUserData( const newtonWorld : PNewtonWorld) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonWorldGetUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonWorldGetVersion( const newtonWorld : PNewtonWorld) : int; cdecl; external{$IFDEF __GPC__}name 'NewtonWorldGetVersion'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonWorldRayCast( const newtonWorld : PNewtonWorld; const p0 : PFloat; const p1 : PFloat;
                              filter : PNewtonWorldRayFilterCallback; userData: Pointer;
                              prefilter : NewtonWorldRayPrefilterCallback); cdecl; external{$IFDEF __GPC__}name 'NewtonWorldRayCast'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
//  Physics Material Section
//
// *****************************************************************************************************************************
function  NewtonMaterialGetDefaultGroupID( const newtonWorld : PNewtonWorld ) : int; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetDefaultGroupID'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonMaterialCreateGroupID( const newtonWorld : PNewtonWorld ) : int; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialCreateGroupID'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialDestroyAllGroupID( const newtonWorld : PNewtonWorld ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialDestroyAllGroupID'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonMaterialSetDefaultSoftness( const newtonWorld : PNewtonWorld; id0 : int; id1 : int; value : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetDefaultSoftness'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetDefaultElasticity( const newtonWorld : PNewtonWorld; id0 : int; id1 : int; elasticCoef : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetDefaultElasticity'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetDefaultCollidable( const newtonWorld : PNewtonWorld; id0 : int; id1 : int; state : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetDefaultCollidable'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetContinuousCollisionMode (const newtonWorld : PNewtonWOrld; id0, id1, state : int);  cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContinuousCollisionMode'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetDefaultFriction( const newtonWorld : PNewtonWorld; id0 : int; id1 : int; staticFriction : float; kineticFriction : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetDefaultFriction'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetCollisionCallback( const newtonWorld : PNewtonWorld; id0 : int; id1 : int; userData : Pointer; _begin : PNewtonContactBegin; process : PNewtonContactProcess; _end : PNewtonContactEnd ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetCollisionCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonMaterialGetUserData( const NewtonWorld: PNewtonWorld; id0: int; id1: int): Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// Physics Contact control functions
//
// *****************************************************************************************************************************
procedure NewtonMaterialDisableContact( const material : PNewtonMaterial ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialDisableContact'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonMaterialGetCurrentTimestep( const material : PNewtonMaterial) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetCurrentTimestep'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonMaterialGetMaterialPairUserData( const material : PNewtonMaterial) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetMaterialPairUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonMaterialGetContactFaceAttribute( const material : PNewtonMaterial) : Unsigned_int; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetContactFaceAttribute'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonMaterialGetBodyCollisionID( const material : PNewtonMaterial; body : PNewtonBody) : Unsigned_int; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetBodyCollisionID'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonMaterialGetContactNormalSpeed( const material : PNewtonMaterial; const contactlHandle : PNewtonContact ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetContactNormalSpeed'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialGetContactForce( const material : PNewtonMaterial; force : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetContactForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialGetContactPositionAndNormal( const material : PNewtonMaterial; posit : PFloat; normal : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetContactPositionAndNormal'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialGetContactTangentDirections( const material : PNewtonMaterial; dir0 : PFloat; dir : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetContactTangentDirections'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonMaterialGetContactTangentSpeed( const material : PNewtonMaterial; const contactlHandle : PNewtonContact; index : int ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialGetContactTangentSpeed'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonMaterialSetContactSoftness( const material : PNewtonMaterial; softness : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContactSoftness'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetContactElasticity( const material : PNewtonMaterial; restitution : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContactElasticity'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetContactFrictionState( const material : PNewtonMaterial; state : int; index : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContactFrictionState'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetContactStaticFrictionCoef( const material : PNewtonMaterial; coef : float; index : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContactStaticFrictionCoef'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetContactKineticFrictionCoef( const material : PNewtonMaterial; coef : float; index : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContactKineticFrictionCoef'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonMaterialSetContactNormalAcceleration (const material : PNewtonMaterial; accel : float); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContactNormalAcceleration'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialSetContactNormalDirection(const material : PNewtonMaterial; directionVector : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContactNormalDirection'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonMaterialSetContactTangentAcceleration( const material : PNewtonMaterial; accel : float; index : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialSetContactTangentAcceleration'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonMaterialContactRotateTangentDirections( const material : PNewtonMaterial; const directionVector : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonMaterialContactRotateTangentDirections'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// convex collision primitives creation functions
//
// *****************************************************************************************************************************
function  NewtonCreateNull( const newtonWorld : PNewtonWorld) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateNull'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCreateSphere( const newtonWorld : PNewtonWorld; radiusX, radiusY, radiusZ : float; const offsetMatrix : PFloat ) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateSphere'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCreateBox( const newtonWorld : PNewtonWorld; dx : float; dy : float; dz : float; const offsetMatrix : PFloat ) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateBox'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCreateCone( const newtonWorld : PNewtonWorld; radius : Float; height : Float; const offsetMatrix : PFloat) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateCone'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCreateCapsule( const newtonWorld : PNewtonWorld; radius : Float; height : Float; const offsetMatrix : PFloat) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateCapsule'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCreateCylinder( const newtonWorld : PNewtonWorld; radius : Float; height : Float; const offsetMatrix : PFloat) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateCylinder'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCreateChamferCylinder( const newtonWorld : PNewtonWorld; raduis : Float; height : Float; const offsetMatrix : PFloat) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateChamferCylinder'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCreateConvexHull( const newtonWorld : PNewtonWorld; count : int; const vertexCloud : PFloat; strideInBytes : int; const offsetMatrix : PFloat) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateConvexHull'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCreateConvexHullModifier( const newtonWorld : PNewtonWorld; const convexHullCollision : PNewtonCollision): PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NEwtonCreateConvexHullModifier'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonConvexHullModifierGetMatrix(const convexHullCollision : PNewtonCollision; matrix : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonConvexHullModifierGetMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonConvexHullModifierSetMatrix(const convexHullCollision : PNewtonCollision; const matrix : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonConvexHullModifierSetMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonConvexCollisionSetUserID( const convexCollision : PNewtonCollision; id : unsigned_int ); cdecl; external{$IFDEF __GPC__}name 'NewtonConvexCollisionSetUserID'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonConvexCollisionGetUserID( const convexCollision : PNewtonCollision) : unsigned_int; cdecl; external{$IFDEF __GPC__}name 'NewtonConvexCollisionGetUserID'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonConvexCollisionCalculateVolume(const convexCollision : PNewtonCollision) : Float;  cdecl; external{$IFDEF __GPC__}name 'NewtonConvexCollisionCalculateVolume'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonConvexCollisionCalculateInertialMatrix (const convexCollision : PNewtonCollision; inertia, origin : PFloat);  cdecl; external{$IFDEF __GPC__}name 'NewtonConvexCollisionCalculateInertialMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonCollisionMakeUnique (const newtonWorld : PNewtonWorld; const collision : PNewtonCollision); cdecl; external{$IFDEF __GPC__}name 'NewtonCollisionMakeUnique'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonReleaseCollision( const newtonWorld : PNewtonWorld; const collision : PNewtonCollision ); cdecl; external{$IFDEF __GPC__}name 'NewtonReleaseCollision'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// complex collision primitives creation functions
// note: can only be used with static bodies (bodies with infinite mass)
//
// *****************************************************************************************************************************
type
  TCollisionPrimitiveArray = array of PNewtonCollision;

function NewtonCreateCompoundCollision( const newtonWorld : PNewtonWorld; count : int;
                                        const collisionPrimitiveArray : TcollisionPrimitiveArray ) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateCompoundCollision'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function NewtonCreateUserMeshCollision( const newtonWorld : PNewtonWorld; const minBox : PFloat;
                                        const maxBox : PFloat; userData : Pointer; collideCallback : NewtonUserMeshCollisionCollideCallback;
                                        rayHitCallback : NewtonUserMeshCollisionRayHitCallback; destroyCallback : NewtonUserMeshCollisionDestroyCallback ) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateUserMeshCollision'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// CollisionTree Utility functions
//
// *****************************************************************************************************************************
function  NewtonCreateTreeCollision( const newtonWorld : PNewtonWorld; userCallback : NewtonTreeCollisionCallback ) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateTreeCollision'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonTreeCollisionBeginBuild( const treeCollision : PNewtonCollision ); cdecl; external{$IFDEF __GPC__}name 'NewtonTreeCollisionBeginBuild'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonTreeCollisionAddFace( const treeCollision : PNewtonCollision; vertexCount : int; const vertexPtr : PFloat;
                                      strideInBytes : int; faceAttribute : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonTreeCollisionAddFace'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonTreeCollisionEndBuild( const treeCollision : PNewtonCollision; optimize : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonTreeCollisionEndBuild'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonTreeCollisionSerialize( const treeCollision : PNewtonCollision; serializeFunction : NewtonSerialize;
                                        serializeHandle : Pointer ); cdecl; external{$IFDEF __GPC__}name 'NewtonTreeCollisionSerialize'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonCreateTreeCollisionFromSerialization( const newtonWorld : PNewtonWorld;
                                                      userCallback : NewtonTreeCollisionCallback; deserializeFunction : NewtonDeserialize; serializeHandle : Pointer ) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateTreeCollisionFromSerialization'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonTreeCollisionGetFaceAtribute( const treeCollision : PNewtonCollision; const faceIndexArray : Pint ) : int; cdecl; external{$IFDEF __GPC__}name 'NewtonTreeCollisionGetFaceAtribute'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonTreeCollisionSetFaceAtribute( const treeCollision : PNewtonCollision; const faceIndexArray : Pint;
                                              attribute : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonTreeCollisionSetFaceAtribute'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// General purpose collision library functions
//
// *****************************************************************************************************************************
function  NewtonCollisionPointDistance (const newtonWorld : PNewtonWorld; const point : PFloat;
		                                    const collision : PNewtonCollision; const matrix : PFloat;	contact : PFloat; normal : PFloat) : Int;
                                        cdecl; external{$IFDEF __GPC__}name 'NewtonCollisionPointDistance'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonCollisionClosestPoint (const newtonWorld : PNewtonWorld; const collsionA : PNewtonCollision;
                                       const matrixA : PFloat; const collisionB : PNewtonCollision; const matrixB : PFloat;
		                                   contactA, contactB, normalAB : PFloat) : Int;
                                       cdecl; external{$IFDEF __GPC__}name 'NewtonCollisionClosestPoint'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonCollisionCollide (const newtonWorld : PNewtonWorld; maxSize : Int; const collsionA : PNewtonCollision;
                                  const matrixA : PFloat; const collisionB : PNewtonCollision; const matrixB : PFloat;
                                  contacts, normals, penetration : PFloat) : Int;
                                  cdecl; external{$IFDEF __GPC__}name 'NewtonCollisionCollide'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function NewtonCollisionCollideContinue (const newtonWorld : PNewtonWorld; maxSize : Int; const timestep : Float;
		                                     const collsionA : PNewtonCollision; const matrixA : PFloat; const velocA : PFloat; const omegaA : Float;
		                                     const collsionB : PNewtonCollision; const matrixB : PFloat; const velocB : PFloat; const omegaB : Float;
		                                     timeOfImpact : PFloat; contacts : PFloat; normals : PFloat; penetration : PFloat) : Int;
                                         cdecl; external{$IFDEF __GPC__}name 'NewtonCollisionCollideContinue'{$ELSE}NewtonDLL{$ENDIF __GPC__};


function  NewtonCollisionRayCast(const collision : PNewtonCollision; const p0: PFloat; const p1: PFloat; normals: PFloat; attribute: pint): float; cdecl; external{$IFDEF __GPC__}name 'NewtonCollisionRayCast'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonCollisionCalculateAABB( const collision : PNewtonCollision; const matrix : PFloat; p0 : PFloat; p1 : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonCollisionCalculateAABB'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// transforms utility functions
//
// *****************************************************************************************************************************
procedure NewtonGetEulerAngle( const matrix : PFloat; eulersAngles : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonGetEulerAngle'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonSetEulerAngle( const eulersAngles : PFloat; matrix : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonSetEulerAngle'{$ELSE}NewtonDLL{$ENDIF __GPC__};

// *****************************************************************************************************************************
//
// body manipulation functions
//
// *****************************************************************************************************************************
function  NewtonCreateBody( const newtonWorld : PNewtonWorld; const collision : PNewtonCollision ) : PNewtonBody; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateBody'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonDestroyBody( const newtonWorld : PNewtonWorld; const body : PNewtonBody ); cdecl; external{$IFDEF __GPC__}name 'NewtonDestroyBody'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonBodyAddForce( const body : PNewtonBody; const force : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyAddForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyAddTorque( const body : PNewtonBody; const torque : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyAddTorque'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonBodySetMatrix( const body : PNewtonBody; const matrix : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetMatrixRecursive( const body : PNewtonBody; const matrix : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetMatrixRecursive'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetMassMatrix( const body : PNewtonBody; mass : float; Ixx : float; Iyy : float; Izz : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetMassMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetMaterialGroupID( const body : PNewtonBody; id : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetMaterialGroupID'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetContinuousCollisionMode(const body : PNewtonbody; state : unsigned_int); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetContinuousCollisionMode'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonBodySetJointRecursiveCollision( const body : PNewtonBody; state : unsigned_int ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetJointRecursiveCollision'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetOmega( const body : PNewtonBody; const omega : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetOmega'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetVelocity( const body : PNewtonBody; const velocity : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetVelocity'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetForce( const body : PNewtonBody; const force : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetTorque( const body : PNewtonBody; const torque : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetTorque'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonBodySetCentreOfMass(const body : PNewtonBody; const com : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetCentreOfMass'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetLinearDamping( const body : PNewtonBody; linearDamp : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetLinearDamping'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetAngularDamping( const body : PNewtonBody; const angularDamp : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetAngularDamping'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetUserData( const body : PNewtonBody; userData : Pointer ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyCoriolisForcesMode( const body : PNewtonBody; mode : int); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyCoriolisForcesMode'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetCollision( const body : PNewtonBody; const collision : PNewtonCollision ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetCollision'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetAutoFreeze( const body : PNewtonBody; state : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetAutoFreeze'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetFreezeTreshold( const body : PNewtonBody; freezeSpeed2 : float; freezeOmega2 : float; framesCount : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetFreezeTreshold'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonBodySetTransformCallback( const body : PNewtonBody; callback : NewtonSetTransform ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetTransformCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetDestructorCallback( const body : PNewtonBody; callback : NewtonBodyDestructor ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetDestructorCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetAutoactiveCallback( const body : PNewtonBody; callback : NewtonBodyActivationState ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetAutoactiveCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodySetForceAndTorqueCallback( const body : PNewtonBody; callback : NewtonApplyForceAndTorque ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodySetForceAndTorqueCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function NewtonBodyGetForceAndTorqueCallback( const body : PNewtonBody ): NewtonApplyForceAndTorque; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetForceAndTorqueCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonBodyGetWorld( const body : PNewtonBody) : PNewtonWorld; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetWorld'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonBodyGetUserData( const body : PNewtonBody ) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonBodyGetCollision( const body : PNewtonBody ) : PNewtonCollision; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetCollision'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonBodyGetMaterialGroupID( const body : PNewtonBody ) : Int; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetMaterialGroupID'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonBodyGetContinuousCollisionMode( const body : PNewtonBody ) : Int; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetContinuousCollisionMode'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonBodyGetJointRecursiveCollision( const body : PNewtonBody ) : Int; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetJointRecursiveCollision'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetMatrix( const body : PNewtonBody; matrix : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetMassMatrix( const body : PNewtonBody; mass : PFloat; Ixx : PFloat; Iyy : PFloat; Izz : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetMassMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetInvMass( const body : PNewtonBody; invMass : PFloat; invIxx : PFloat; invIyy : PFloat; invIzz : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetInvMass'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetOmega( const body : PNewtonBody; vector : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetOmega'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetVelocity( const body : PNewtonBody; vector : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetVelocity'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetForce( const body : PNewtonBody; vector : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetTorque( const body : PNewtonBody; vector : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetTorque'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetCentreOfMass(const body : PNewtonBody; com : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetCentreOfMass'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonBodyGetSleepingState( const body : PNewtonBody) : Int; cdecl; external{$IFDEF __GPC__}name 'NEwtonBodyGetSleepingState'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonBodyGetAutoFreeze( const body : PNewtonBody ) : Int; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetAutoFreeze'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonBodyGetLinearDamping( const body : PNewtonBody ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetLinearDamping'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetAngularDamping( const body : PNewtonBody; vector : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetAngularDamping'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetAABB( const body : PNewtonBody; p0 : PFloat; p1 : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetAABB'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBodyGetFreezeTreshold( const body : PNewtonBody; freezeSpeed2 : PFloat; freezeOmega2 : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyGetFreezeTreshold'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonBodyAddBuoyancyForce( const body : PNewtonBody; fluidDensity : float; fluidLinearViscosity : float; fluidAngularViscosity : float;
                                      const gravityVector : PFloat; buoyancyPlane : NewtonGetBuoyancyPlane; context : Pointer ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyAddBuoyancyForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonBodyForEachPolygonDo( const body : PNewtonBody; callback : NewtonCollisionIterator ); cdecl; external{$IFDEF __GPC__}name 'NewtonBodyForEachPolygonDo'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonAddBodyImpulse(const body : PNewtonBody; const pointDeltaVeloc : PFloat; const pointPosit : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonAddBodyImpulse'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// Common joint funtions
//
// *****************************************************************************************************************************
function  NewtonJointGetUserData( const joint : PNewtonJoint ) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonJointGetUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonJointSetUserData( const joint : PNewtonJoint; userData : Pointer ); cdecl; external{$IFDEF __GPC__}name 'NewtonJointSetUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonJointGetCollisionState( const joint : PNewtonJoint ) : int; cdecl; external{$IFDEF __GPC__}name 'NewtonJointGetCollisionState'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonJointSetCollisionState( const joint : PNewtonJoint; state : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonJointSetCollisionState'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonJointGetStiffness( const joint : PNewtonJoint): float; cdecl; external{$IFDEF __GPC__}name 'NewtonJointGetStiffness'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonJointSetStiffness( const joint: PNewtonJoint; state: float); cdecl; external{$IFDEF __GPC__}name 'NewtonJointSetStiffness'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonDestroyJoint( const newtonWorld : PNewtonWorld; const joint : PNewtonJoint ); cdecl; external{$IFDEF __GPC__}name 'NewtonDestroyJoint'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonJointSetDestructor( const joint : PNewtonJoint; _destructor : NewtonConstraintDestructor ); cdecl; external{$IFDEF __GPC__}name 'NewtonJointSetDestructor'{$ELSE}NewtonDLL{$ENDIF __GPC__};

// *****************************************************************************************************************************
//
// Ball and Socket joint functions
//
// *****************************************************************************************************************************
function  NewtonConstraintCreateBall( const newtonWorld : PNewtonWorld; const pivotPoint : PFloat;
                                      const childBody : PNewtonBody; const parentBody : PNewtonBody ) : PNewtonJoint; cdecl; external{$IFDEF __GPC__}name 'NewtonConstraintCreateBall'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonBallSetUserCallback( const ball : PNewtonJoint; callback : NewtonBallCallBack ); cdecl; external{$IFDEF __GPC__}name 'NewtonBallSetUserCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBallGetJointAngle( const ball : PNewtonJoint; angle : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBallGetJointAngle'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBallGetJointOmega( const ball : PNewtonJoint; omega : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBallGetJointOmega'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBallGetJointForce( const ball : PNewtonJoint; force : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonBallGetJointForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonBallSetConeLimits( const ball : PNewtonJoint; const pin : PFloat; maxConeAngle : float; maxTwistAngle : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonBallSetConeLimits'{$ELSE}NewtonDLL{$ENDIF __GPC__};

// *****************************************************************************************************************************
//
// Hinge joint functions
//
// *****************************************************************************************************************************
function  NewtonConstraintCreateHinge( const newtonWorld : PNewtonWorld;
                                       const pivotPoint : PFloat; const pinDir : PFloat;
                                       const childBody : PNewtonBody; const parentBody : PNewtonBody ) : PNewtonJoint; cdecl; external{$IFDEF __GPC__}name 'NewtonConstraintCreateHinge'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonHingeSetUserCallback( const hinge : PNewtonJoint; callback : NewtonHingeCallBack ); cdecl; external{$IFDEF __GPC__}name 'NewtonHingeSetUserCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonHingeGetJointAngle( const hinge : PNewtonJoint ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonHingeGetJointAngle'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonHingeGetJointOmega( const hinge : PNewtonJoint ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonHingeGetJointOmega'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonHingeGetJointForce( const hinge : PNewtonJoint; force : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonHingeGetJointForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonHingeCalculateStopAlpha( const hinge : PNewtonJoint; const desc : PNewtonHingeSliderUpdateDesc; angle : float ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonHingeCalculateStopAlpha'{$ELSE}NewtonDLL{$ENDIF __GPC__};

// *****************************************************************************************************************************
//
// Slider joint functions
//
// *****************************************************************************************************************************
function  NewtonConstraintCreateSlider( const newtonWorld : PNewtonWorld;
                                        const pivotPoint : PFloat; const pinDir : PFloat;
                                        const childBody : PNewtonBody; const parentBody : PNewtonBody ) : PNewtonJoint; cdecl; external{$IFDEF __GPC__}name 'NewtonConstraintCreateSlider'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonSliderSetUserCallback( const slider : PNewtonJoint; callback : NewtonSliderCallBack ); cdecl; external{$IFDEF __GPC__}name 'NewtonSliderSetUserCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonSliderGetJointPosit( const slider : PNewtonJoint ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonSliderGetJointPosit'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonSliderGetJointVeloc( const slider : PNewtonJoint ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonSliderGetJointVeloc'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonSliderGetJointForce( const slider : PNewtonJoint; force : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonSliderGetJointForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonSliderCalculateStopAccel( const slider : PNewtonJoint; const desc : PNewtonHingeSliderUpdateDesc; position : float ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonSliderCalculateStopAccel'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// Corkscrew joint functions
//
// *****************************************************************************************************************************
function  NewtonConstraintCreateCorkscrew( const newtonWorld : PNewtonWorld;
                                           const pivotPoint : PFloat; const pinDir : PFloat;
                                           const childBody : PNewtonBody; const parentBody : PNewtonBody ) : PNewtonJoint; cdecl; external{$IFDEF __GPC__}name 'NewtonConstraintCreateCorkscrew'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonCorkscrewSetUserCallback( const corkscrew : PNewtonJoint; callback : NewtonCorkscrewCallBack ); cdecl; external{$IFDEF __GPC__}name 'NewtonCorkscrewSetUserCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCorkscrewGetJointPosit( const corkscrew : PNewtonJoint ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonCorkscrewGetJointPosit'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCorkscrewGetJointAngle( const corkscrew : PNewtonJoint ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonCorkscrewGetJointAngle'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCorkscrewGetJointVeloc( const corkscrew : PNewtonJoint ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonCorkscrewGetJointVeloc'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCorkscrewGetJointOmega( const corkscrew : PNewtonJoint ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonCorkscrewGetJointOmega'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonCorkscrewGetJointForce( const corkscrew : PNewtonJoint; force : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonCorkscrewGetJointForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCorkscrewCalculateStopAlpha( const corkscrew : PNewtonJoint; const desc : PNewtonHingeSliderUpdateDesc; angle : float ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonCorkscrewCalculateStopAlpha'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonCorkscrewCalculateStopAccel( const corkscrew : PNewtonJoint; const desc : PNewtonHingeSliderUpdateDesc; position : float ) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonCorkscrewCalculateStopAccel'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// Universal joint functions
//
// *****************************************************************************************************************************
function  NewtonConstraintCreateUniversal( const newtonWorld: PNewtonWorld; const pivotPoint: PFloat; const pinDir0: PFloat;
                                          const pinDir1: PFloat; const childBody: PNewtonBody; const parentBody: PNewtonBody): PNewtonJoint; cdecl; external{$IFDEF __GPC__}name 'NewtonConstraintCreateUniversal'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUniversalSetUserCallback(const universal: PNewtonJoint; callback: NewtonUniversalCallback); cdecl; external{$IFDEF __GPC__}name 'NewtonUniversalSetUserCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonUniversalGetJointAngle0(const universal: PNewtonJoint):float; cdecl; external{$IFDEF __GPC__}name 'NewtonUniversalGetJointAngle0'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonUniversalGetJointAngle1(const universal: PNewtonJoint):float; cdecl; external{$IFDEF __GPC__}name 'NewtonUniversalGetJointAngle1'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonUniversalGetJointOmega0(const universal: PNewtonJoint):float; cdecl; external{$IFDEF __GPC__}name 'NewtonUniversalGetJointOmega0'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonUniversalGetJointOmega1(const universal: PNewtonJoint):float; cdecl; external{$IFDEF __GPC__}name 'NewtonUniversalGetJointOmega1'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUniversalGetJointForce(const universal: PNewtonJoint; force: PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonUniversalGetJointForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonUniversalCalculateStopAlpha0(const universal : PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: float): float; cdecl; external{$IFDEF __GPC__}name 'NewtonUniversalCalculateStopAlpha0'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonUniversalCalculateStopAlpha1(const universal : PNewtonJoint; const desc: PNewtonHingeSliderUpdateDesc; angle: float): float; cdecl; external{$IFDEF __GPC__}name 'NewtonUniversalCalculateStopAlpha1'{$ELSE}NewtonDLL{$ENDIF __GPC__};

// *****************************************************************************************************************************
//
// Up vector joint unctions
//
// *****************************************************************************************************************************
function  NewtonConstraintCreateUpVector( const newtonWorld : PNewtonWorld; const pinDir : PFloat; const body : PNewtonBody ) : PNewtonJoint; cdecl; external{$IFDEF __GPC__}name 'NewtonConstraintCreateUpVector'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUpVectorGetPin( const upVector : PNewtonJoint; pin : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonUpVectorGetPin'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUpVectorSetPin( const upVector : PNewtonJoint; const pin : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonUpVectorSetPin'{$ELSE}NewtonDLL{$ENDIF __GPC__};

// *****************************************************************************************************************************
//
// User defined bilateral Joint
//
// *****************************************************************************************************************************
function  NewtonConstraintCreateUserJoint(const NewtonWorld : PNewtonWorld; MaxDOF : Integer; Callback : PNewtonUserBilateralCallBack;
                                          const ChildBody: PNewtonBody; const parentBody: PNewtonBody): PNewtonJoint;
                                          cdecl; external{$IFDEF __GPC__}name 'NewtonConstraintCreateUserJoint'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUserJointAddLinearRow(const Joint : PNewtonJoint; const pivot0 : PFloat; const pivot1 : PFloat; const Dir : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointAddLinearRow'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUserJointAddAngularRow(const Joint : PNewtonJoint; RelativeAngle : Float; const Dir : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointAddAngularRow'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUserJointAddGeneralRow(const Joint : PNewtonJoint; const Jacobian0 : PFloat; const Jacobian1 : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointAddGeneralRow'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUserJointSetRowMinimumFriction(const Joint : PNewtonJoint; Friction : Float); cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointSetRowMinimumFriction'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUserJointSetRowMaximumFriction(const Joint : PNewtonJoint; Friction : Float); cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointSetRowMaximumFriction'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUserJointSetRowAcceleration(const Joint : PNewtonJoint; Acceleration : Float); cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointSetRowAcceleration'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUserJointSetRowStiffness(const Joint : PNewtonJoint; Stiffness : Float); cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointSetRowStiffness'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonUserJointSetRowSpringDamperAcceleration(const joint : PNewtonJoint; springK : Float; springD : Float); cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointSetRowSpringDamperAcceleration'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonUserJointGetRowForce (const Joint : PNewtonJoint; Row : Int) : Float; cdecl; external{$IFDEF __GPC__}name 'NewtonUserJointGetRowForce'{$ELSE}NewtonDLL{$ENDIF __GPC__};


// *****************************************************************************************************************************
//
// Ragdoll joint contatiner funtion
//
// *****************************************************************************************************************************
function  NewtonCreateRagDoll( const newtonWorld : PNewtonWorld ) : PNewtonRagDoll; cdecl; external{$IFDEF __GPC__}name 'NewtonCreateRagDoll'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonDestroyRagDoll( const newtonWorld : PNewtonWorld; const ragDoll : PNewtonRagDoll ); cdecl; external{$IFDEF __GPC__}name 'NewtonDestroyRagDoll'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonRagDollBegin( const ragDoll : PNewtonRagDoll ); cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollBegin'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonRagDollEnd( const ragDoll : PNewtonRagDoll ); cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollEnd'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonRagDollFindBone( const ragDoll : PNewtonRagDoll; id : int ) : PNewtonRagDollBone; cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollFindBone'{$ELSE}NewtonDLL{$ENDIF __GPC__};
//function  NewtonRagDollGetRootBone( const ragDoll : PNewtonRagDoll ) : PNewtonRagDollBone; cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollGetRootBone'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonRagDollSetForceAndTorqueCallback( const ragDoll : PNewtonRagDoll; callback : NewtonApplyForceAndTorque ); cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollSetForceAndTorqueCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonRagDollSetTransformCallback( const ragDoll : PNewtonRagDoll; callback : NewtonSetRagDollTransform ); cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollSetTransformCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonRagDollAddBone( const RagDoll : PNewtonRagDoll; const Parent : PNewtonRagDollBone; userData : Pointer; mass : Float; const matrix : PFloat;
													      const BoneCollision : PNewtonCollision; const Size : PFloat) : PNewtonRagDollBone; cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollAddBone'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonRagDollBoneGetUserData( const bone : PNewtonRagDollBone ) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollBoneGetUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonRagDollBoneGetBody( const bone : PNewtonRagDollBone ) : PNewtonBody; cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollBoneGetBody'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonRagDollBoneSetID( const bone : PNewtonRagDollBone; id : int ); cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollBoneSetID'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonRagDollBoneSetLimits( const bone : PNewtonRagDollBone;
                                      const coneDir : PFloat; minConeAngle : float; maxConeAngle : float; maxTwistAngle : float;
                                      const bilateralConeDir : PFloat; negativeBilateralConeAngle : float; positiveBilateralConeAngle : float ); cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollBoneSetLimits'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonRagDollBoneGetLocalMatrix( const bone : PNewtonRagDollBone; matrix : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollBoneGetLocalMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonRagDollBoneGetGlobalMatrix( const bone : PNewtonRagDollBone; matrix : PFloat ); cdecl; external{$IFDEF __GPC__}name 'NewtonRagDollBoneGetGlobalMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};

// *****************************************************************************************************************************
//
// Vehicle joint functions
//
// *****************************************************************************************************************************
function  NewtonConstraintCreateVehicle( const newtonWorld : PNewtonWorld; const upDir : PFloat; const body : PNewtonBody) : PNewtonJoint; cdecl; external{$IFDEF __GPC__}name 'NewtonConstraintCreateVehicle'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleReset( const vehicle : PNewtonJoint); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleReset'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleSetTireCallback( const vehicle : PNewtonJoint; update : PNewtonVehicleTireUpdate); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleSetTireCallback'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleAddTire( const vehicle : PNewtonJoint; const localMatrix : PFloat; const pin : PFloat; mass : Float; width : Float; radius : Float;
                                suspensionShock : Float; suspensionSpring : Float; suspensionLength : Float; userData : Pointer; collisionID : int) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleAddTire'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleRemoveTire( const vehicle : PNewtonJoint; tireID : Pointer); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleRemoveTire'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonVehicleGetFirstTireID( const vehicle : PNewtonJoint) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetFirstTireID'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleGetNextTireID( const vehicle : PNewtonJoint; tireId : Pointer) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetNextTireID'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonVehicleTireIsAirBorne( const vehicle : PNewtonJoint; tireId : Pointer) : int; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleTireIsAirBorne'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleTireLostSideGrip( const vehicle : PNewtonJoint; tireId : Pointer) : int; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleTireLostSideGrip'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleTireLostTraction( const vehicle : PNewtonJoint; tireId : Pointer) : int;  cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleTireLostTraction'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonVehicleGetTireUserData( const vehicle : PNewtonJoint; tireId : Pointer) : Pointer; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetTireUserData'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleGetTireOmega( const vehicle : PNewtonJoint; tireId : Pointer) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetTireOmega'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleGetTireNormalLoad( const vehicle : PNewtonJoint; tireId : Pointer) : Float; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetTireNormalLoad'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleGetTireSteerAngle( const vehicle : PNewtonJoint; tireId : Pointer) : Float; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetTireSteerAngle'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleGetTireLateralSpeed( const vehicle : PNewtonJoint; tireId : Pointer) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetTireLateralSpeed'{$ELSE}NewtonDLL{$ENDIF __GPC__};
function  NewtonVehicleGetTireLongitudinalSpeed( const vehicle : PNewtonJoint; tireId : Pointer) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetTireLongitudinalSpeed'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleGetTireMatrix( const vehicle : PNewtonJoint; tireId : Pointer; matrix : PFloat); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleGetTireMatrix'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonVehicleSetTireTorque( const vehicle : PNewtonJoint; tireId : Pointer; torque : Float); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleSetTireTorque'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleSetTireSteerAngle( const vehicle : PNewtonJoint; tireId : Pointer; angle : Float); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleSetTireSteerAngle'{$ELSE}NewtonDLL{$ENDIF __GPC__};

procedure NewtonVehicleSetTireMaxSideSleepSpeed( const vehicle : PNewtonJoint; tireId : Pointer; speed : float); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleSetTireMaxSideSleepSpeed'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleSetTireSideSleepCoeficient(const vehicle : PNewtonJoint; tireId : Pointer; coeficient : float); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleSetTireSideSleepCoeficient'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleSetTireMaxLongitudinalSlideSpeed(const vehicle : PNewtonJoint; tireId : Pointer; speed : float); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleSetTireMaxLongitudinalSlideSpeed'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleSetTireLongitudinalSlideCoeficient(const vehicle : PNewtonJoint; tireId : Pointer; coeficient : float); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleSetTireLongitudinalSlideCoeficient'{$ELSE}NewtonDLL{$ENDIF __GPC__};

function  NewtonVehicleTireCalculateMaxBrakeAcceleration(const vehicle : PNewtonJoint; tireId : Pointer) : float; cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleTireCalculateMaxBrakeAcceleration'{$ELSE}NewtonDLL{$ENDIF __GPC__};
procedure NewtonVehicleTireSetBrakeAcceleration( const vehicle : PNewtonJoint; tireId : Pointer; accelaration : float; torqeLimit : float); cdecl; external{$IFDEF __GPC__}name 'NewtonVehicleTireSetBrakeAcceleration'{$ELSE}NewtonDLL{$ENDIF __GPC__};

implementation

end.

