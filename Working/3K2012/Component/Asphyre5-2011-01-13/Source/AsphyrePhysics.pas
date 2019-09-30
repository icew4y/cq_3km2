unit AsphyrePhysics;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Math, NewtonImport, Vectors3, Matrices4;

//---------------------------------------------------------------------------
const
 UnknownID = High(Cardinal);

//---------------------------------------------------------------------------
type
 TNewtonObjects = class;

//---------------------------------------------------------------------------
 TNewtonCustomObject = class
 private
  FID    : Cardinal;
  FNext  : TNewtonCustomObject;
  FPrev  : TNewtonCustomObject;
  FOwner : TNewtonObjects;
  FMass  : Single;
  FColor : Cardinal;
  FSkin  : string;

  Disposed: Boolean;

  procedure SetMass(const Value: Single);
  function GetMatrix(): TMatrix4;
  procedure SetMatrix(const Value: TMatrix4);
  function GetTorque(): TVector3;
  procedure SetTorque(const Value: TVector3);
  function GetOmega(): TVector3;
  procedure SetOmega(const Value: TVector3);
  function GetVelocity(): TVector3;
  procedure SetVelocity(const Value: TVector3);
  function GetPosition(): TVector3;
  procedure SetPosition(const Value: TVector3);
  procedure SetNext(const Value: TNewtonCustomObject);
  procedure SetPrev(const Value: TNewtonCustomObject);
  procedure Unlink();
 protected
  FBody: PNewtonBody;

  function GetMassInertia(Mass: Single): TVector3; virtual; abstract;
  procedure ApplyForceAndTorque(); virtual;
  procedure DoMove(); virtual;
  procedure DoDraw(const DrawMtx: TMatrix4); virtual;
 public
  // linked list references
  property ID   : Cardinal read FID;
  property Prev : TNewtonCustomObject read FPrev write SetPrev;
  property Next : TNewtonCustomObject read FNext write SetNext;
  property Owner: TNewtonObjects read FOwner;

  // physical references
  property Body    : PNewtonBody read FBody;
  property Mass    : Single read FMass write SetMass;
  property Matrix  : TMatrix4 read GetMatrix write SetMatrix;
  property Torque  : TVector3 read GetTorque write SetTorque;
  property Omega   : TVector3 read GetOmega write SetOmega;
  property Velocity: TVector3 read GetVelocity write SetVelocity;
  property Position: TVector3 read GetPosition write SetPosition;

  // visual references
  property Color: Cardinal read FColor write FColor;
  property Skin : string read FSkin write FSkin;

  procedure Dispose();
  procedure Draw(); virtual; abstract;
  procedure Move(); virtual;

  constructor Create(AOwner: TNewtonObjects);
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
 TNewtonCustomBox = class(TNewtonCustomObject)
 private
  FSize: TVector3;
 protected
  function GetMassInertia(Mass: Single): TVector3; override;
 public
  property Size: TVector3 read FSize;

  procedure Draw(); override;

  constructor Create(AOwner: TNewtonObjects; const ASize: TVector3);
 end;

//---------------------------------------------------------------------------
 TNewtonCustomSphere = class(TNewtonCustomObject)
 private
  FRadius: Single;
 protected
  function GetMassInertia(Mass: Single): TVector3; override;
 public
  property Radius: Single read FRadius;

  procedure Draw(); override;

  constructor Create(AOwner: TNewtonObjects; ARadius: Single);
 end;

//---------------------------------------------------------------------------
 TNewtonObjects = class
 private
  FListHead: TNewtonCustomObject;

  SearchList : array of TNewtonCustomObject;
  SearchCount: Integer;
  SearchDirty: Boolean;

  CurrentID: Cardinal;

  function GenerateID(): Integer; virtual;
  function UniqueID(): Integer;
  procedure Link(Obj: TNewtonCustomObject); virtual;
  procedure Unlink(Obj: TNewtonCustomObject); virtual;

  procedure ApplySearchList(Amount: Integer);
  procedure InitSearchList();
  procedure SortSearchList(Left, Right: Integer);
  procedure MakeSearchList();
  function FindByID(ID: Cardinal): TNewtonCustomObject;
  function GetCount(): Integer;
 public
  property Items[ID: Cardinal]: TNewtonCustomObject read FindByID; default;
  property Count: Integer read GetCount;

  procedure RemoveAll();
  procedure Remove(ID: Cardinal); virtual;
  procedure Update();

  procedure Draw();

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
var
 NewtonWorld: PNewtonWorld;
 NewtonObjects: TNewtonObjects = nil;

//---------------------------------------------------------------------------
procedure CreateNewtonWorld(const WorldSize: TVector3);
procedure UpdateNewtonWorld(Latency: Single);
procedure DestroyNewtonWorld();

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
const
 // the rounding cache for object ordering
 DirtyCache = 64;

//---------------------------------------------------------------------------
procedure ForceAndTorqueCallback(const Body: PNewtonBody); cdecl;
var
 Referee: TNewtonCustomObject;
begin
 Referee:= NewtonBodyGetUserData(Body);
 Referee.ApplyForceAndTorque();
end;

//---------------------------------------------------------------------------
constructor TNewtonCustomObject.Create(AOwner: TNewtonObjects);
begin
 inherited Create();

 FPrev := nil;
 FNext := nil;
 FOwner:= AOwner;
 FBody := nil;

 Disposed:= False;

 if (Assigned(FOwner)) then
  begin
   FID:= FOwner.UniqueID();
   FOwner.Link(Self);
  end;

 FColor:= $FFFFFFFF;
 FSkin := '';
end;

//---------------------------------------------------------------------------
destructor TNewtonCustomObject.Destroy();
begin
 if (FBody <> nil) then
  begin
   NewtonDestroyBody(NewtonWorld, FBody);
   FBody:= nil;
  end;

 Unlink();

 inherited;
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.SetMass(const Value: Single);
var
 Inertia: TVector3;
begin
 FMass:= Value;

 Inertia:= GetMassInertia(FMass);
 NewtonBodySetMassMatrix(FBody, FMass, Inertia.x, Inertia.y, Inertia.z);
end;

//---------------------------------------------------------------------------
function TNewtonCustomObject.GetMatrix(): TMatrix4;
begin
 NewtonBodyGetMatrix(FBody, @Result);
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.SetMatrix(const Value: TMatrix4);
begin
 NewtonBodySetMatrix(FBody, @Value);
end;

//---------------------------------------------------------------------------
function TNewtonCustomObject.GetTorque(): TVector3;
begin
 NewtonBodyGetTorque(FBody, @Result);
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.SetTorque(const Value: TVector3);
begin
 NewtonBodySetTorque(FBody, @Value);
end;

//---------------------------------------------------------------------------
function TNewtonCustomObject.GetOmega(): TVector3;
begin
 NewtonBodyGetOmega(FBody, @Result);
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.SetOmega(const Value: TVector3);
begin
 NewtonBodySetOmega(FBody, @Value);
end;

//---------------------------------------------------------------------------
function TNewtonCustomObject.GetVelocity(): TVector3;
begin
 NewtonBodyGetVelocity(FBody, @Result);
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.SetVelocity(const Value: TVector3);
begin
 NewtonBodySetVelocity(FBody, @Value);
end;

//---------------------------------------------------------------------------
function TNewtonCustomObject.GetPosition(): TVector3;
var
 Mtx: TMatrix4;
begin
 NewtonBodyGetMatrix(FBody, @Mtx);
 Result.x:= Mtx.Data[3, 0];
 Result.y:= Mtx.Data[3, 1];
 Result.z:= Mtx.Data[3, 2];
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.SetPosition(const Value: TVector3);
var
 Mtx: TMatrix4;
begin
 NewtonBodyGetMatrix(FBody, @Mtx);
 Mtx.Data[3, 0]:= Value.x;
 Mtx.Data[3, 1]:= Value.y;
 Mtx.Data[3, 2]:= Value.z;
 NewtonBodySetMatrix(FBody, @Mtx);
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.Dispose();
begin
 Disposed:= True;
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.SetPrev(const Value: TNewtonCustomObject);
var
 UnPrev: TNewtonCustomObject;
begin
 // (1) Determine previous forward link.
 UnPrev:= nil;
 if (FPrev <> nil)and(FPrev.Next = Self) then UnPrev:= FPrev;
 // (2) Update the link.
 FPrev:= Value;
 // (3) Remove previous forward link.
 if (UnPrev <> nil) then UnPrev.Next:= nil;
 // (4) Insert forward link.
 if (FPrev <> nil)and(FPrev.Next <> Self) then FPrev.Next:= Self;
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.SetNext(const Value: TNewtonCustomObject);
var
 UnNext: TNewtonCustomObject;
begin
 // (1) Determine previous backward link.
 UnNext:= nil;
 if (FNext <> nil)and(FNext.Prev = Self) then UnNext:= FNext;
 // (2) Update the link.
 FNext:= Value;
 // (3) Remove previous backward link.
 if (UnNext <> nil) then UnNext.Prev:= nil;
 // (4) Insert backward link.
 if (FNext <> nil)and(FNext.Prev <> Self) then FNext.Prev:= Self;
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.Unlink();
var
 WasPrev, WasNext: TNewtonCustomObject;
begin
 // (1) Unlink the object from its owner.
 if (Assigned(FOwner)) then FOwner.Unlink(Self);

 // (2) Unlink previous node.
 WasPrev:= FPrev;
 WasNext:= FNext;
 FPrev:= nil;
 FNext:= nil;

 if (WasPrev = nil) then
  begin
   if (WasNext <> nil) then WasNext.Prev:= nil;
  end else WasPrev.Next:= WasNext;
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.ApplyForceAndTorque();
var
 Gravity: TVector3;
begin
 if (FMass > 0.0) then
  begin
   Gravity:= Vector3(0.0, -9.8 * FMass, 0.0);
   NewtonBodyAddForce(FBody, @Gravity);
  end;
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.DoMove();
begin
 // no code
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.DoDraw(const DrawMtx: TMatrix4);
begin
 // no code
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomObject.Move();
begin
 DoMove();
end;

//---------------------------------------------------------------------------
constructor TNewtonCustomBox.Create(AOwner: TNewtonObjects; const ASize: TVector3);
var
 Collision: PNewtonCollision;
begin
 inherited Create(AOwner);

 FSize:= ASize;

 Collision:= NewtonCreateBox(NewtonWorld, Size.x, Size.y, Size.z, nil);

 FBody:= NewtonCreateBody(NewtonWorld, Collision);

 NewtonReleaseCollision(NewtonWorld, Collision);

 NewtonBodySetForceAndTorqueCallBack(FBody, ForceAndTorqueCallBack);
 NewtonBodySetUserData(FBody, Self);
end;

//---------------------------------------------------------------------------
function TNewtonCustomBox.GetMassInertia(Mass: Single): TVector3;
begin
 Result.x:= Mass * (FSize.y * FSize.y + FSize.z * FSize.z) / 12.0;
 Result.y:= Mass * (FSize.x * FSize.x + FSize.z * FSize.z) / 12.0;
 Result.z:= Mass * (FSize.x * FSize.x + FSize.y * FSize.y) / 12.0;
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomBox.Draw();
begin
{$IFDEF VER150}
  DoDraw(Matrix4Multiply(ScaleMtx4(FSize), Matrix));
{$ELSE}
  DoDraw(ScaleMtx4(FSize) * Matrix);
{$ENDIF}
end;

//---------------------------------------------------------------------------
constructor TNewtonCustomSphere.Create(AOwner: TNewtonObjects; ARadius: Single);
var
 Collision: PNewtonCollision;
begin
 inherited Create(AOwner);

 FRadius:= ARadius;

 Collision:= NewtonCreateSphere(NewtonWorld, FRadius, FRadius, FRadius, nil);

 FBody:= NewtonCreateBody(NewtonWorld, Collision);

 NewtonReleaseCollision(NewtonWorld, Collision);

 NewtonBodySetForceAndTorqueCallBack(FBody, ForceAndTorqueCallBack);
 NewtonBodySetUserData(FBody, Self);
end;

//---------------------------------------------------------------------------
function TNewtonCustomSphere.GetMassInertia(Mass: Single): TVector3;
begin
 Result.x:= (2.0 / 5.0) * Mass * FRadius * FRadius;
 Result.y:= Result.x;
 Result.z:= Result.x;
end;

//---------------------------------------------------------------------------
procedure TNewtonCustomSphere.Draw();
begin
{$IFDEF VER150}
  DoDraw(Matrix4Multiply(ScaleMtx4(Vector3(FRadius, FRadius, FRadius)), Matrix));
{$ELSE}
  DoDraw(ScaleMtx4(Vector3(FRadius, FRadius, FRadius)) * Matrix);
{$ENDIF}
end;

//---------------------------------------------------------------------------
constructor TNewtonObjects.Create();
begin
 inherited;

 FListHead:= nil;

 SearchDirty:= False;
 SearchCount:= 0;

 CurrentID:= 0;
end;

//---------------------------------------------------------------------------
destructor TNewtonObjects.Destroy();
begin
 RemoveAll();

 inherited;
end;

//---------------------------------------------------------------------------
function TNewtonObjects.GenerateID(): Integer;
begin
 if (CurrentID = High(Cardinal)) then Inc(CurrentiD);

 Result:= CurrentID;
 Inc(CurrentID);
end;

//---------------------------------------------------------------------------
function TNewtonObjects.UniqueID(): Integer;
var
 Attempts: Cardinal;
begin
 Attempts:= High(Cardinal) - 1;
 Result:= GenerateID();

 while (FindByID(Result) <> nil) do
  begin
   if (Attempts > 0) then
    begin
     Result:= GenerateID();
     Dec(Attempts);
    end else Break;
  end;
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.RemoveAll();
var
 Node, Temp: TNewtonCustomObject;
begin
 Node:= FListHead;
 while (Node <> nil) do
  begin
   Temp:= Node;
   Node:= Node.Next;

   Temp.Free();
  end;

 FListHead:= nil;
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.Link(Obj: TNewtonCustomObject);
begin
 SearchDirty:= True;

 if (FListHead = nil) then
  begin
   Obj.Prev:= nil;
   Obj.Next:= nil;
   FListHead:= Obj;
  end else
  begin
   Obj.Prev:= nil;
   Obj.Next:= FListHead;
   FListHead:= Obj;
  end;
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.Unlink(Obj: TNewtonCustomObject);
begin
 if (FListHead = Obj) then
  begin
   if (FListHead.Next <> nil) then FListHead:=  FListHead.Next
    else FListHead:= nil;
  end;

 SearchDirty:= True;
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.ApplySearchList(Amount: Integer);
var
 Required: Integer;
begin
 Required:= Ceil(Amount / DirtyCache) * DirtyCache;
 if (Length(SearchList) < Required) then SetLength(SearchList, Required);
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.InitSearchList();
var
 Index: Integer;
 Aux: TNewtonCustomObject;
begin
 Index:= 0;
 Aux  := FListHead;
 while (Aux <> nil) do
  begin
   // ask for more data storage
   if (Length(SearchList) <= Index) then ApplySearchList(Index + 1);

   // add element to the array
   SearchList[Index]:= Aux;
   Inc(Index);

   // advance in the array
   Aux:= Aux.Next;
  end;

 SearchCount:= Index;
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.SortSearchList(Left, Right: Integer);
var
 Lo, Hi  : Integer;
 TempObj : TNewtonCustomObject;
 MidValue: Cardinal;
begin
 Lo:= Left;
 Hi:= Right;
 MidValue:= SearchList[(Left + Right) div 2].ID;

 repeat
  while (SearchList[Lo].ID < MidValue) do Inc(Lo);
  while (SearchList[Hi].ID > MidValue) do Dec(Hi);

  if (Lo <= Hi) then
   begin
    TempObj:= SearchList[Lo];
    SearchList[Lo]:= SearchList[Hi];
    SearchList[Hi]:= TempObj;

    Inc(Lo);
    Dec(Hi);
   end;
 until (Lo > Hi);

 if (Left < Hi) then SortSearchList(Left, Hi);
 if (Lo < Right) then SortSearchList(Lo, Right);
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.MakeSearchList();
begin
 InitSearchList();
 if (SearchCount > 1) then SortSearchList(0, SearchCount - 1);

 SearchDirty:= False;
end;

//---------------------------------------------------------------------------
function TNewtonObjects.FindByID(ID: Cardinal): TNewtonCustomObject;
var
 Lo, Hi, Mid: Integer;
begin
 if (SearchDirty) then MakeSearchList();

 Result:= nil;

 Lo:= 0;
 Hi:= SearchCount - 1;

 while (Lo <= Hi) do
  begin
   Mid:= (Lo + Hi) div 2;

   if (SearchList[Mid].ID = ID) then
    begin
     Result:= SearchList[Mid];
     Break;
    end;

   if (SearchList[Mid].ID > ID) then Hi:= Mid - 1 else Lo:= Mid + 1;
 end;
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.Update();
var
 Aux, Temp: TNewtonCustomObject;
 Died: Boolean;
begin
 // (1) Move objects.
 Aux:= FListHead;
 while (Aux <> nil) do
  begin
   if (not Aux.Disposed) then Aux.Move();
   Aux:= Aux.Next;
  end;

 // (2) Prune objects.
 Aux:= FListHead;
 while (Aux <> nil) do
  begin
   Died:= False;
   if (Aux.Disposed) then
    begin
     Temp:= Aux;
     Aux:= Aux.Next;
     Temp.Free();
     Died:= True;
    end;

   if (not Died) then Aux:= Aux.Next;
  end;
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.Remove(ID: Cardinal);
var
 Aux: TNewtonCustomObject;
begin
 Aux:= FindByID(ID);
 if (Aux <> nil) then Aux.Free();
end;

//---------------------------------------------------------------------------
procedure TNewtonObjects.Draw();
var
 Node: TNewtonCustomObject;
begin
 Node:= FListHead;

 while (Node <> nil) do
  begin
   Node.Draw();
   Node:= Node.Next;
  end;
end;

//---------------------------------------------------------------------------
function TNewtonObjects.GetCount(): Integer;
begin
 if (SearchDirty) then MakeSearchList();
 Result:= SearchCount;
end;

//---------------------------------------------------------------------------
procedure CreateNewtonWorld(const WorldSize: TVector3);
var
 MinPt, MaxPt: TVector3;
begin
 NewtonWorld:= NewtonCreate(nil, nil);

{$IFDEF VER150}
 MaxPt:= Vector3Multiply(WorldSize, 0.5);
 MinPt:= Vector3Negative(MaxPt);
{$ELSE}
 MaxPt:= WorldSize * 0.5;
 MinPt:= -MaxPt;
{$ENDIF}

 NewtonSetWorldSize(NewtonWorld, @MinPt, @MaxPt);
 NewtonSetPlatformArchitecture(NewtonWorld, 2);
{ NewtonSetSolverModel(NewtonWorld, 2);
 NewtonSetFrictionModel(NewtonWorld, 1);}
end;

//---------------------------------------------------------------------------
procedure DestroyNewtonWorld();
begin
 NewtonDestroy(NewtonWorld);
 NewtonWorld:= nil;
end;

//---------------------------------------------------------------------------
procedure UpdateNewtonWorld(Latency: Single);
begin
 NewtonUpdate(NewtonWorld, Latency / 1000.0);
end;

//---------------------------------------------------------------------------
initialization
 NewtonObjects:= TNewtonObjects.Create();

//---------------------------------------------------------------------------
finalization
 NewtonObjects.Free();
 NewtonObjects:= nil;

 //---------------------------------------------------------------------------
end.
