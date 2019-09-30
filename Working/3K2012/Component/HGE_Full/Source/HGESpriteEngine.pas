unit HGESpriteEngine;
 (*
** HGE Sprite Engine helper class
** Extension to the HGE engine
** Extension added by DraculaLin
** This extension is NOT part of the original HGE engine.
*)

interface
uses
   Windows, Types, Classes, SysUtils, Math, HGE, HGEDef, HGEImages, HGECanvas,
   HGENURBS;


type
 TCollideMode = (cmCircle, cmRect, cmQuadrangle, cmPolygon);
 TAnimPlayMode = (pmForward, pmBackward, pmPingPong);
 TJumpState = (jsNone, jsJumping, jsFalling);
 TImageType = (itSingleImage, itSpriteSheet);
 TGUIType = (gtNormal, gtForm, gtButton, gtScrollBar, gtEdit);

  {  ESpriteError  }

 ESpriteError = class(Exception);

 TSpriteEngine = class;
 TSpriteClass = class of TSprite;

 TSprite = class
 private
      FEngine: TSpriteEngine;
      FParent: TSprite;
      FList: TList;
      FDrawList: TList;
      FDeaded: Boolean;
      FWidth: Integer;
      FHeight: Integer;
      FName: string;
      FX, FY: Single;
      FZ: Integer;
      FWorldX, FWorldY: Single;
      FVisible: Boolean;
      FBlendMode: Integer;
      FDoCollision: Boolean;
      FCollisioned: Boolean;
      FImageName: string;
      FPatternIndex: Integer;
      FImageIndex: Integer;
      FMoved: Boolean;
      FTruncMove: Boolean;
      FCollidePos: TPoint2;
      FCollideRadius: Integer;
      FCollideRect: TRect;
      FTag: Integer;
      FCollideQuadrangle: TPoint4;
      FCollidePolygon : TPolygon;
      FCollideMode: TCollideMode;
      FZSet: Boolean;
      procedure Add(Sprite: TSprite);
      procedure Remove(Sprite: TSprite);
      procedure AddDrawList(Sprite: TSprite);
      procedure Draw; virtual;
      function GetCount: Integer;
      function GetItem(Index: Integer): TSprite;
      function GetImageWidth: Integer;
      function GetImageHeight: Integer;
      function GetPatternWidth: Integer;
      function GetPatternHeight: Integer;
      function GetPatternCount: Integer;
 protected
      procedure DoDraw; virtual;
      procedure DoMove(const MoveCount: Single); virtual;
      procedure DoCollision(const Sprite: TSprite); virtual;
      procedure SetName(const Value: string); virtual;
      procedure SetImageName(const Value: string); virtual;
      procedure SetPatternIndex(const Value: Integer); virtual;
      procedure SetX(const Value: Single); virtual;
      procedure SetY(const Value: Single); virtual;
      procedure SetZ(const Value: Integer); virtual;
 public
      constructor Create(const AParent: TSprite); virtual;
      destructor Destroy; override;
      procedure Assign(const Value: TSprite); virtual;
      procedure Clear;
      procedure Move(const MoveCount: Single);
      procedure SetPos(X, Y: Single); overload;
      procedure SetPos(X, Y: Single; Z: Integer); overload;
      procedure Collision(const Other: TSprite); overload; virtual;
      procedure Collision; overload; virtual;
      procedure Dead;
      property Visible: Boolean read FVisible write FVisible;
      property X: Single read FX write SetX;
      property Y: Single read FY write SetY;
      property Z: Integer read FZ write SetZ;
      property ImageName: string read FImageName write SetImageName;
      property PatternIndex: Integer read FPatternIndex write SetPatternIndex;
      property ImageIndex : Integer read FImageIndex write FImageIndex;
      property ImageWidth: Integer read GetImageWidth;
      property ImageHeight: Integer read GetImageHeight;
      property PatternWidth: Integer read GetPatternWidth;
      property PatternHeight: Integer read GetPatternHeight;
      property Width: Integer read FWidth write FWidth ;
      property Height:Integer read FHeight write FHeight ;
      property PatternCount: Integer read GetPatternCount;
      property WorldX: Single read FWorldX write FWorldX;
      property WorldY: Single read FWorldY write FWorldY;
      property BlendMode: Integer read FBlendMode write FBlendMode;
      property Name: string read FName write SetName;
      property Moved: Boolean read FMoved write FMoved;
      property TruncMove: Boolean read FTruncMove write FTruncMove;
      property CollidePos: TPoint2 read FCollidePos write FCollidePos;
      property CollideRadius: Integer read FCollideRadius write FCollideRadius;
      property CollideRect: TRect read FCollideRect write FCollideRect;
      property CollideQuadrangle: TPoint4 read FCollideQuadrangle write FCollideQuadrangle;
      property CollidePolygon : TPolygon read FCollidePolygon write FCollidePolygon;
      property CollideMode: TCollideMode read FCollideMode write FCollideMode;
      property Collisioned: Boolean read FCollisioned write FCollisioned;
      property Items[Index: Integer]: TSprite read GetItem; default;
      property Count: Integer read GetCount;
      property Engine: TSpriteEngine read FEngine write FEngine;
      property Parent: TSprite read FParent;
      property Tag: Integer read FTag write FTag;
 end;

 TSpriteEx=class(TSprite)
 private
      FX1, FY1, FX2, FY2, FX3, FY3, FX4, FY4: Single;
      FMirrorX, FMirrorY: Boolean;
      FCenterX, FCenterY: Single;
      FDoCenter: Boolean;
      FColor1, FColor2, FColor3, FColor4: Cardinal;
      FRed, FGreen, FBlue: Integer;
      FAlpha: Integer;
      FAngle: Single;
      FAngle360: Integer;
      FSrcAngle, FDestAngle: Single;
      FScaleX, FScaleY: Single;
      FOffsetX, FOffsetY: Single;
      FDrawMode: Integer;
      FImageType: TImageType;
      FSelected : Boolean;
      FGroupNumber : Integer;
      FMouseEnterFlag: Boolean;
      FMouseDownFlag: Boolean;
      FActiveRect : TRect;
      FSpeedX, FSpeedY: Single;
      FPositionListX, FPositionListY: TList;
      FAttachTo: TSprite;
      FCanCollision: Boolean;
 protected
      procedure SetRed(const Value: Integer); virtual;
      procedure SetGreen(const Value: Integer); virtual;
      procedure SetBlue(const Value: Integer); virtual;
      procedure SetAlpha(const Value: Integer); virtual;
      procedure SetDrawMode(const Value: Integer); virtual;
      procedure SetAngle360(Value: Integer);
      Procedure SetGroupNumber(AGroupNumber: Integer); virtual;
      procedure SetSelected(ASelected: Boolean); virtual;
      function GetBoundsRect: TRect; virtual;
 public
      constructor Create(const AParent: TSprite); override;
      destructor Destroy; override;
      procedure Assign(const Value: TSprite); override;
      procedure DoDraw; override;
      procedure SetColor(const Color: Cardinal); overload;
      procedure SetColor(Red, Green, Blue: Cardinal; Alpha: Cardinal=255); overload;
      procedure LookAt(TargetX, TargetY: Integer);
      procedure TowardToAngle(Angle: Integer; Speed: Single; DoLookAt: Boolean);
      procedure TowardToPos(TargetX, TargetY: Integer; Speed: Single;DoLookAt: Boolean);
      procedure RotateToAngle(Angle: Integer; RotateSpeed, MoveSpeed: Single );
      procedure RotateToPos(DestX, DestY: Integer; RotateSpeed, MoveSpeed: Single );
      procedure CircleToAngle(Angle, LookAtX, LookAtY: Integer; RotateSpeed, MoveSpeed: Single; DoLookAt: Boolean);
      procedure CircleToPos(DestX, DestY, LookAtX, LookAtY: Integer; RotateSpeed, MoveSpeed: Single; DoLookAt: Boolean);
      procedure Attach(Sprite: TSprite); virtual;
      procedure Detach;
      function GetSpriteAt(X, Y: Integer): TSprite;
      function GetDistance(Sprite1, Sprite2: TSprite): Real;
      function MouseInRect: Boolean;
      function SpriteInRect1(InArea: TRect): Boolean;
      function SpriteInRect2(InArea: TRect): Boolean;
      procedure DoMouseEvent;
      procedure OnMouseEnter; virtual;
      procedure OnMouseLeave; virtual;
      procedure OnMouseMove; virtual;
      procedure OnLMouseDown; virtual;
      procedure OnLMouseUp; virtual;
      procedure OnRMouseDown; virtual;
      procedure OnRMouseUp; virtual;
      procedure OnMouseDbClick; virtual;
      procedure OnMouseWheelUp; virtual;
      procedure OnMouseWheelDown; virtual;
      procedure OnMouseDrag; virtual;
      property  ActiveRect:TRect read FActiveRect write FActiveRect; //for mouse event
      property X1: Single read FX1 write FX1;
      property Y1: Single read FY1 write FY1;
      property X2: Single read FX2 write FX2;
      property Y2: Single read FY2 write FY2;
      property X3: Single read FX3 write FX3;
      property Y3: Single read FY3 write FY3;
      property X4: Single read FX4 write FX4;
      property Y4: Single read FY4 write FY4;
      property Red: Integer read FRed write SetRed default 255;
      property Green: Integer read FGreen write SetGreen default 255;
      property Blue: Integer read FBlue write SetBlue default 255;
      property Alpha: Integer read FAlpha write SetAlpha default 255;
      property Color1: Cardinal read FColor1 write FColor1;
      property Color2: Cardinal read FColor2 write FColor2;
      property Color3: Cardinal read FColor3 write FColor3;
      property Color4: Cardinal read FColor4 write FColor4;
      property Angle: Single read FAngle write FAngle;
      property Angle360: Integer  read FAngle360 write SetAngle360;
      property CenterX: Single read FCenterX write FCenterX;
      property CenterY: Single read FCenterY write FCenterY;
      property ScaleX: Single read FScaleX write FScaleX;
      property ScaleY: Single read FScaleY write FScaleY;
      property OffsetX: Single read FOffsetX write FOffsetX;
      property OffsetY: Single read FOffsetY write FOffsetY;
      property DoCenter: Boolean read FDoCenter write FDoCenter;
      property MirrorX: Boolean read FMirrorX write FMirrorX;
      property MirrorY: Boolean read FMirrorY write FMirrorY;
      property SpeedX: Single read FSpeedX write FSpeedX;
      property SpeedY: Single read FSpeedY write FSpeedY;
      property DrawMode: Integer read FDrawMode write SetDrawMode;
      property ImageType: TImageType read FImageType write FImageType;
      property BoundsRect: TRect read GetBoundsRect;
      property GroupNumber: Integer read FGroupNumber write SetGroupNumber;
      property Selected: Boolean read FSelected write SetSelected;
      property CanCollision: Boolean read FCanCollision write FCanCollision;
 end;

 TAnimatedSprite = class(TSpriteEx)
 private
      FDoAnimate: Boolean;
      FAnimLooped: Boolean;
      FAnimStart: Integer;
      FAnimCount: Integer;
      FAnimSpeed: Single;
      FAnimPos: Single;
      FAnimEnded: Boolean;
      FDoFlag1, FDoFlag2: Boolean;
      FAnimPlayMode: TAnimPlayMode;
      procedure SetAnimStart(Value: Integer);
 public
      constructor Create(const AParent: TSprite); override;
      procedure Assign(const Value: TSprite); override;
      procedure DoMove(const MoveCount: Single); override;
      procedure SetAnim(AniImageName: string; AniStart, AniCount: Integer; AniSpeed: Single; AniLooped, DoMirror, DoAnimate: Boolean; PlayMode: TAnimPlayMode=pmForward); overload; virtual;
      procedure SetAnim(AniImageName: string; AniStart, AniCount: Integer; AniSpeed: Single; AniLooped: Boolean;  PlayMode: TAnimPlayMode=pmForward); overload; virtual;
      procedure OnAnimStart; virtual;
      procedure OnAnimEnd; virtual;
      property AnimPos: Single read FAnimPos write FAnimPos;
      property AnimStart: Integer read FAnimStart write SetAnimStart;
      property AnimCount: Integer read FAnimCount write FAnimCount;
      property AnimSpeed: Single read FAnimSpeed write FAnimSpeed;
      property AnimLooped: Boolean read FAnimLooped write FAnimLooped;
      property DoAnimate: Boolean read FDoAnimate write FDoAnimate;
      property AnimEnded: Boolean read FAnimEnded;
      property AnimPlayMode: TAnimPlayMode read FAnimPlayMode write FAnimPlayMode;
 end;

 TParticleSprite = class(TAnimatedSprite)
 private
      FAccelX: Real;
      FAccelY: Real;
      FVelocityX: Real;
      FVelocityY: Real;
      FUpdateSpeed : Single;
      FDecay: Real;
      FLifeTime: Real;
 public
      constructor Create(const AParent: TSprite); override;
      procedure DoMove(const MoveCount: Single); override;
      property AccelX: Real read FAccelX write FAccelX;
      property AccelY: Real read FAccelY write FAccelY;
      property VelocityX: Real read FVelocityX write FVelocityX;
      property VelocityY: Real read FVelocityY write FVelocityY;
      property UpdateSpeed : Single read FUpdateSpeed write FUpdateSpeed;
      property Decay: Real read FDecay write FDecay;
      property LifeTime: Real read FLifeTime write FLifeTime;
 end;

 TPlayerSprite = class(TAnimatedSprite)
 private
      FSpeed: Single;
      FAcc: Single;
      FDcc: Single;
      FMinSpeed: Single;
      FMaxSpeed: Single;
      FVelocityX: Single;
      FVelocityY: Single;
      FDirection: Integer;
      procedure SetSpeed(Value: Single);
      procedure SetDirection(Value: Integer);
 public
      constructor Create(const AParent: TSprite); override;
      procedure UpdatePos(const MoveCount: Single);
      procedure FlipXDirection;
      procedure FlipYDirection;
      procedure Accelerate; virtual;
      procedure Deccelerate; virtual;
      property Speed: Single read FSpeed write SetSpeed;
      property MinSpeed: Single read FMinSpeed write FMinSpeed;
      property MaxSpeed: Single read FMaxSpeed write FMaxSpeed;
      property VelocityX: Single read FVelocityX write FVelocityX;
      property VelocityY: Single read FVelocityY write FVelocityY;
      property Acceleration: Single read FAcc write FAcc;
      property Decceleration: Single read FDcc write FDcc;
      property Direction: Integer read FDirection write SetDirection;
 end;

 TFaderSprite=class(TAnimatedSprite)
 private
      FMirrorCount, FCurrentColorCount, FNumColors: Integer;
      FCurCol, FMultiCols: ^Cardinal;
      FMulti: Boolean;
      Counter: Single;
      FSpeed: Single;
      FLooped, FMultiFade, FMirrorFade, FFadeEnded: Boolean;
      FSrcR, FSrcG, FSrcB, FSrcA,
      FDestR, FDestG, FDestB, FDestA,
      FCurR, FCurG, FCurB, FCurA: Byte;
      procedure SetFadeSpeed(Speed: Single);
 public
      constructor Create(const AParent: TSprite); override;
      destructor Destroy; override;
      procedure DoMove(const MoveCount: Single); override;
      procedure MultiFade(Colors: array of Cardinal);
      procedure SetSourceColor(Red, Green, Blue, Alpha: Byte); overload;
      procedure SetSourceColor(Color: Cardinal); overload;
      procedure SetDestinationColor(Red, Green, Blue, Alpha: Byte); overload;
      procedure SetDestinationColor(Color: Cardinal); overload;
      procedure FadeIn(Red, Green, Blue: Byte; Speed: Single);
      procedure FadeOut(Red, Green, Blue: Byte; Speed: Single);
      procedure SwapColors;
      procedure Reset;
      procedure Stop;
      property FadeEnded: Boolean read FFadeEnded;
      property FadeSpeed: Single read FSpeed write SetFadeSpeed;
      property MirrorFade: Boolean read FMirrorFade write FMirrorFade;
      property LoopFade: Boolean read FLooped write FLooped;
 end;

 TJumperSprite = class(TPlayerSprite)
 private
      FJumpCount: Integer;
      FJumpSpeed: Single;
      FJumpHeight: Single;
      FMaxFallSpeed: Single;
      FDoJump: Boolean;
      FJumpState: TJumpState;
      procedure SetJumpState(Value: TJumpState);
 public
      constructor Create(const AParent: TSprite); override;
      procedure DoMove(const MoveCount: Single); override;
      procedure Accelerate; override;
      procedure Deccelerate; override;
      property JumpCount: Integer read FJumpCount write FJumpCount;
      property JumpState: TJumpState read FJumpState write SetJumpState;
      property JumpSpeed: Single read FJumpSpeed write FJumpSpeed;
      property JumpHeight: Single read FJumpHeight write FJumpHeight;
      property MaxFallSpeed: Single read FMaxFallSpeed write FMaxFallSpeed;
      property DoJump: Boolean read  FDoJump write FDoJump;
 end;

 TJumperSpriteEx = class(TPlayerSprite)
 private
     FJumpCount: Integer;
     FJumpSpeed: Single;
     FJumpStartSpeed: Single;
     FJumpHeight: Single;
     FLowJumpSpeed: Single;
     FLowJumpGravity: Single;
     FHighJumpValue: Integer;
     FHighJumpSpeed: Single;
     FFallingSpeed: Single;
     FMaxFallSpeed: Single;
     FDoJump: Boolean;
     FJumpState: TJumpState;
     FHoldKey: Boolean;
     FOffset:Single;
     procedure SetJumpState(Value: TJumpState);
 public
     constructor Create(const AParent: TSprite); override;
     procedure DoMove(const MoveCount: Single); override;
     procedure Accelerate; override;
     procedure Deccelerate; override;
     property JumpStartSpeed: Single read FJumpStartSpeed write FJumpStartSpeed;
     property LowJumpSpeed: Single read FLowJumpSpeed write FLowJumpSpeed;
     property LowJumpGravity: Single read FLowJumpGravity write FLowJumpgravity;
     property HighJumpValue: Integer read  FHighJumpValue write FHighJumpValue;
     property HighJumpSpeed: Single read  FHighJumpSpeed write FHighJumpSpeed;
     property FallingSpeed: single read FFallingSpeed write FFallingSpeed;
     property HoldKey: Boolean read FHoldKey write FHoldKey;
     property JumpCount: Integer read FJumpCount write FJumpCount;
     property JumpState: TJumpState read FJumpState write SetJumpState;
     property JumpSpeed: Single read FJumpSpeed write FJumpSpeed;
     property JumpHeight: Single read FJumpHeight write FJumpHeight;
     property MaxFallSpeed: Single read FMaxFallSpeed write FMaxFallSpeed;
     property DoJump: Boolean read  FDoJump write FDoJump;
 end;

 TTileMapSprite = class(TSpriteEx)
 private
      FCollisionMap: Pointer;
      FMap: Pointer;
      FMapW:Integer;
      FMapH: Integer;
      FMapWidth: Integer;
      FMapHeight: Integer;
      FDoTile: Boolean;
      function GetCollisionMapItem(X, Y: Integer): Boolean;
      function GetCell(X, Y: Integer): Integer;
      procedure Draw; override;
      procedure SetCell(X, Y: Integer; Value: Integer);
      procedure SetCollisionMapItem(X, Y: Integer; Value: Boolean);
      procedure SetMapHeight(Value: Integer);
      procedure SetMapWidth(Value: Integer);
 protected
      function GetBoundsRect: TRect; override;
      function TestCollision(Sprite: TSprite): Boolean;
 public
      constructor Create(const AParent: TSprite); override;
      destructor Destroy; override;
      procedure DoDraw; override;
      property BoundsRect: TRect read GetBoundsRect;
      procedure SetMapSize(AMapWidth, AMapHeight: Integer);
      property Cells[X, Y: Integer]: Integer read GetCell write SetCell;
      property CollisionMap[X, Y: Integer]: Boolean read GetCollisionMapItem write SetCollisionMapItem;
      property MapHeight: Integer read FMapHeight write SetMapHeight;
      property MapWidth: Integer read FMapWidth write SetMapWidth;
      property DoTile: Boolean read FDoTile write FDoTile;
 end;
 TContainer = array[0..20, 0..50] of TRect;

 TGUISprite = class(TAnimatedSprite)
 private
      FOwner: TGUISprite;
      FEnabled: Boolean;
      FGUIType: TGUIType;
      FHighLight: Boolean;
      FCaption: string;
      FShowHint: Boolean;
      FHintString: string;
      FCanDrag: Boolean;
      FCanFlip: Boolean;
      FPickUp: Boolean;
      FCanPickUp: Boolean;
      FUseContainer: Boolean;
      FZList: TList;
      FMouseOffsetX, FMouseOffsetY: Integer;
      FIsMouseDown: Boolean;
      FClicked : Boolean;
 public
      Container : TContainer;// read FContainer write FContainer;
      constructor Create(const AParent: TSprite); override;
      destructor Destroy; override;
      procedure DoMove(const MoveCount: Single); override;
      procedure OnLMouseUp; override;
      procedure OnLMouseDown; override;
      procedure OnMouseMove; override;
      procedure OnMouseEnter; override;
      procedure OnMouseLeave; override;
      procedure OnMouseDrag; override;
      property GuiType: TGuiType read FGuiType write FGuiType;
      property Enabled: Boolean read FEnabled write FEnabled;
      property HighLight: Boolean read FHighLight write FHighLight;
      property ShowHint: Boolean read FShowHint write FShowHint;
      property HintString: string read FHintString write FHintString;
      property CanDrag: Boolean read FCanDrag write FCanDrag;
      property CanFlip: Boolean read FCanFlip write FCanFlip;
      property CanPickUp: Boolean read FCanPickUp write FCanPickUp;
      property UseContainer: Boolean read FUseContainer write FUseContainer;
      property Caption: string read FCaption write FCaption;
      property Owner: TGUISprite read FOwner write FOwner;
 end;

 TPathSprite = class(TAnimatedSprite)
 private
      FLooped: Boolean;
      FSegment: Integer;
      FDistance: Single;
      FPosition: TPoint;
      FMoveSpeed: Single;
      function Calculate(P0, P1, P2, P3: Integer; T: Single): Integer;
      function CalculatePoint(CP0, CP1, CP2, CP3: TPoint; T: Single): TPoint;
      function GetPosition: TPoint;
      function GetSegment: Integer;
      procedure SetSegment(const Value: Integer);
      procedure SetLooped(const Value: Boolean);
      procedure SetDistance(const Value: Single);
 public
      FCtrlPts: array of TPoint;
      function GetPoint(Index: Integer): TPoint;
      constructor Create(const AParent: TSprite); override;
      procedure DoMove(const MoveCount: Single); override;
      destructor Destroy; override;
      procedure AddPoint(X, Y: Integer); overload;
      procedure AddPoint(Point: TPoint); overload;
      property Looped: Boolean read FLooped write SetLooped;
      property Segment: Integer read GetSegment write SetSegment;
      property Distance: Single read FDistance write SetDistance;
      property Position: TPoint read GetPosition;
      property MoveSpeed: Single read FMoveSpeed write FMoveSpeed; 
 end;

 TNPathSprite = class(TAnimatedSprite)
 private
      FPath: TNURBSCurveEx;
      FDistance: Single;  // [0,100]
      FPosition: TPoint2;
      FMoveSpeed: Single;
      FAccel: Single;
      FUpdateSpeed : Single;
      FMaxParameter: Integer;
      function GetPosition: TPoint2;
      procedure SetDistance(const Value: Single);
 public
      property Path: TNURBSCurveEx read FPath write FPath;
      procedure DoMove(const MoveCount: Single); override;
      procedure LookAt(anAngle: Single);
      property Distance: Single read FDistance write SetDistance;
      property Position: TPoint2 read GetPosition;
      property MoveSpeed: Single read FMoveSpeed write FMoveSpeed;
      property Accel: Single read FAccel write FAccel;
      property UpdateSpeed : Single read FUpdateSpeed write FUpdateSpeed;
      property MaxParameter: Integer read FMaxParameter write FMaxParameter;
      constructor Create(const AParent: TSprite); override;
      destructor Destroy; override;
 end;

 TSpriteEngine = class(TSprite)
 private
      FAllCount: Integer;
      FDeadList: TList;
      FDrawCount: Integer;
      FWorldX, FWorldY: Single;
      FObjectsSelected : Boolean;
      FGroupCount: Integer;
      FGroups:array of TList;
      FCurrentSelected : TList;
      FVisibleWidth: Integer;
      FVisibleHeight: Integer;
      FDoMouseEvent: Boolean;
      FZCounter: Integer;
      FImages: THGEImages;
      FCanvas: THGECanvas;
 protected
      procedure SetGroupCount(AGroupCount: Integer); virtual;
      function GetGroup(Index: Integer): TList; virtual;
 public
      constructor Create(const AParent: TSprite); override;
      destructor Destroy; override;
      procedure Draw; override;
      procedure Dead;
      function Select(Point: TPoint; Filter: array of TSpriteClass; Add: Boolean = False): TSprite; overload;
      function Select(Point: TPoint; Add: Boolean = False): TSprite; overload;
      procedure ClearCurrent;
      procedure ClearGroup(GroupNumber: Integer);
      procedure GroupToCurrent(GroupNumber: Integer; Add: Boolean = False);
      procedure CurrentToGroup(GroupNumber: Integer; Add: Boolean = False);
      procedure GroupSelect(const Area: TRect; Filter: array of TSpriteClass; Add: Boolean = False); overload;
      procedure GroupSelect(const Area: TRect; Add: Boolean = False); overload;
      property AllCount: Integer read FAllCount;
      property DrawCount: Integer read FDrawCount;
      property VisibleWidth:Integer read FVisibleWidth write FVisibleWidth;
      property VisibleHeight: Integer read FVisibleHeight write FVisibleHeight;
      property WorldX: Single read FWorldX write FWorldX;
      property WorldY: Single read FWorldY write FWorldY;
      property CurrentSelected: TList  read FCurrentSelected;
      property ObjectsSelected: Boolean read FObjectsSelected;
      property Groups[index: Integer]: TList read GetGroup;
      property GroupCount: Integer read FGroupCount write SetGroupCount;
      property Images: THGEImages read FImages write FImages;
      property Canvas: THGECanvas read FCanvas write FCanvas;
 end;

procedure GetMouseEvent;

implementation

var
  FHGE: IHGE = nil;
  Event:THGEInputEvent;
  MouseX, MouseY: Single;

procedure GetMouseEvent;
begin
  FHge.Input_GetMousePos(MouseX, MouseY);
  FHGE.Input_GetEvent(Event);
end;

  {  TSprite }
constructor TSprite.Create(const AParent: TSprite);
begin
     inherited Create;
     FParent := AParent;
     if FParent <> nil then
     begin
          FParent.Add(Self);
          if FParent is TSpriteEngine then
              FEngine := TSpriteEngine(FParent)
          else
              FEngine := FParent.Engine;
          Inc(FEngine.FAllCount);
     end;
     FX := 200;
     FY := 200;
     FZ := 0;
     if Z = 0 then Z := 1;
     FWidth := 64;
     FHeight:= 64;
     FName := '';
     FZ := 0;
     FPatternIndex := 0;
     FDoCollision := False;
     FMoved := True;
     FBlendMode := Blend_Default;
     FVisible := True;
     TruncMove := True;
     FTag := 0;
end;

destructor TSprite.Destroy;
begin
     Clear;
     if FParent <> nil then
     begin
          Dec(FEngine.FAllCount);
          FParent.Remove(Self);
          FEngine.FDeadList.Remove(Self);
     end;
     FList.Free;
     FDrawList.Free;
     inherited Destroy;
end;

procedure TSprite.Assign(const Value: TSprite);
begin
     FName := Value.Name;
     FImageName := Value.ImageName;
     FX  := Value.X;
     FY  := Value.Y;
     FZ  := Value.Z;
     FWorldX  := Value.WorldX;
     FWorldY  := Value.WorldY;
     FPatternIndex := Value.PatternIndex;
     FImageIndex := Value.ImageIndex;
     FCollideMode := Value.CollideMode;
     FCollisioned := Value.Collisioned;
     FCollidePos := Value.CollidePos;
     FCollideRadius := Value.CollideRadius;
     FCollideRect := Value.CollideRect;
     FCollideQuadrangle := Value.CollideQuadrangle;
     FMoved := Value.Moved;
     FBlendMode := Value.BlendMode;
     FVisible := Value.Visible;
     FTag := Value.Tag;
end;

procedure TSprite.Add(Sprite: TSprite);
begin
     if FList = nil then
     begin
          FList := TList.Create;
          FDrawList := TList.Create;
     end;
     FList.Add(Sprite);
     // optimization for HUGE large-map, to optimize load time
     //AddDrawList(Sprite);
end;

procedure TSprite.Remove(Sprite: TSprite);
begin
     FList.Remove(Sprite);
     FDrawList.Remove(Sprite);
     if FList.Count = 0 then
     begin
          FList.Free;
          FList := nil;
          FDrawList.Free;
          FDrawList := nil;
     end;
end;

procedure TSprite.AddDrawList(Sprite: TSprite);
var
   L, H, I, C: Integer;
begin
     L := 0;
     H := FDrawList.Count - 1;
     while L <= H do
     begin
          I := (L + H) div 2;
          C := TSprite(FDrawList[I]).Z - Sprite.Z;
          if C < 0 then
              L := I + 1
          else
              H := I - 1;
     end;
     FDrawList.Insert(L, Sprite);
end;

procedure TSprite.Clear;
begin
     while Count > 0 do
         Items[Count - 1].Free;
end;

procedure TSprite.Dead;
begin
     if (FEngine <> nil) and (not FDeaded) then
     begin
          FDeaded := True;
          FEngine.FDeadList.Add(Self);
     end;
end;

procedure TSprite.DoMove;
begin
end;

procedure TSprite.Move(const MoveCount: Single);
var
   i: Integer;
begin
     if FMoved then
     begin
          DoMove(MoveCount);
          for i := 0 to Count - 1 do
              Items[i].Move(MoveCount);
     end;
end;

procedure TSprite.Draw;
var
   i: Integer;
begin
     if FVisible then
     begin
          if FEngine <> nil then
          begin
               if (X > FEngine.WorldX - Width ) and
               (Y > FEngine.WorldY - Height)    and
               (X < FEngine.WorldX + FEngine.VisibleWidth)  and
               (Y < FEngine.WorldY + FEngine.VisibleHeight) then
               begin
                    DoDraw;
                    Inc(FEngine.FDrawCount);
               end;
          end;
          if FDrawList <> nil then
          begin
               for i := 0 to FDrawList.Count-1 do
                   TSprite(FDrawList[i]).Draw;
          end;
     end;
end;

function TSprite.GetCount: Integer;
begin
     if FList <> nil then
         Result := FList.Count
     else
         Result := 0;
end;

function TSprite.GetItem(Index: Integer): TSprite;
begin
     if FList <> nil then
         Result := FList[Index]
     else
         raise ESpriteError.CreateFmt('Index of the list exceeds the range. (%d)', [Index]);
end;

function TSprite.GetImageWidth: Integer;
begin
     Result := FEngine.Images.Image[FImageName].GetWidth(True);
end;

function TSprite.GetImageHeight: Integer;
begin
     Result := FEngine.Images.Image[FImageName].GetHeight(True);
end;

function TSprite.GetPatternWidth: Integer;
begin
     if FEngine.FImages <> nil then
        Result := FEngine.Images.Image[FImageName].PatternWidth
     else
        Result := 0
end;

function TSprite.GetPatternHeight: Integer;
begin
     if FEngine.FImages <> nil then
        Result := FEngine.Images.Image[FImageName].PatternHeight
     else
        Result := 0;
end;

function TSprite.GetPatternCount: Integer;
begin
     Result := FEngine.FImages.Image[FImageName].PatternCount;
end;

procedure TSprite.DoDraw;
begin
     if not FVisible then Exit;
     if FEngine.FImages = nil then Exit;

     case FTruncMove of
     True:

     FEngine.FCanvas.Draw(FEngine.FImages.Image[FImageName],
     FPatternIndex,
     Trunc(FX + FWorldX - FEngine.FWorldX),
     Trunc(FY + FWorldY - FEngine.FWorldY),
     FBlendMode);

     False:
     FEngine.FCanvas.Draw(FEngine.FImages.Image[FImageName],
     FPatternIndex,
     FX + FWorldX - FEngine.FWorldX,
     FY + FWorldY - FEngine.FWorldY,
     FBlendMode);
     end;

end;

procedure TSprite.SetPos(X, Y: Single);
begin
     FX := X;
     FY := Y;
end;

procedure TSprite.SetPos(X, Y: Single; Z: Integer);
begin
     FX := X;
     FY := Y;
     FZ := Z;
end;

procedure TSprite.SetName(const Value: string);
begin
     Self.FName := Value;
end;

procedure TSprite.SetPatternIndex(const Value: Integer);
begin
     Self.FPatternIndex := Value;
     if FImageName = ' ' then Exit;
end;

procedure TSprite.SetImageName(const Value: string);
begin
     // Self.FImageName := Value;
     if CompareText(FImageName, Value) <> 0 then
     begin
          FImageName := Value;
        //  if FEngine <> nil then
          //   FImageName := FEngine.FImages.Image[FImageName];
     end;
end;

procedure TSprite.SetX(const Value: Single);
begin
     Self.FX := Value;
end;

procedure TSprite.SetY(const Value: Single);
begin
     Self.FY := Value;
end;

procedure TSprite.SetZ(const Value: Integer);
begin
     if FZ <> Value then
     begin
          FZ := Value;
          if Parent <> nil then
          begin
               //  optimize load time
               if FZSet then
                  Parent.FDrawList.Remove(Self);

               Parent.AddDrawList(Self);
               FZSet := True;
          end;
     end;
end;

procedure TSprite.Collision(const Other: TSprite);
var
   Delta: Real;
   IsCollide: Boolean;
begin
     IsCollide := False;

     if (FCollisioned) and (Other.FCollisioned) and (not FDeaded) and (not Other.FDeaded) then
     begin
          case FCollideMode of
               cmCircle:
               begin
                    Delta := Sqrt(Sqr(Self.FCollidePos.X - Other.FCollidePos.X) +
                             Sqr(Self.FCollidePos.Y - Other.FCollidePos.Y));
                    IsCollide := (Delta < (Self.FCollideRadius + Other.FCollideRadius));
               end;
               cmRect:
               begin
                    IsCollide := OverlapRect(Self.FCollideRect, Other.FCollideRect);
               end;
               cmQuadrangle:
               begin
                    IsCollide := OverlapQuadrangle(Self.FCollideQuadrangle, Other.FCollideQuadrangle);
               end;
               cmPolygon:
               begin
                    IsCollide := OverlapPolygon(Self.FCollidePolygon, Other.FCollidePolygon);
               end;
          end;

          if IsCollide then
          begin
               DoCollision(Other);
               Other.DoCollision(Self);
          end;
     end;
end;

procedure TSprite.Collision;
var
   i: Integer;
begin
     if (FEngine <> nil) and (not FDeaded) and (Collisioned) then
     begin
          for i := 0 to Engine.Count - 1 do
              Self.Collision(Engine.Items[i]);
     end;
end;

procedure TSprite.DoCollision(const Sprite: TSprite);
begin
end;

{TSpriteEx}
constructor TSpriteEx.Create(const AParent: TSprite);
begin
     inherited;
     FGroupNumber := -1;
     FImageType := itSpriteSheet;
     FColor1 := $FFFFFFFF;
     FColor2 := $FFFFFFFF;
     FColor3 := $FFFFFFFF;
     FColor4 := $FFFFFFFF;
     FCenterX := 0;
     FCenterY := 0;
     FX1 := 0;
     FY1 := 0;
     FX2 := 10;
     FY2 := 0;
     FX3 := 10;
     FY3 := 10;
     FX4 := 0;
     FY4 := 10;
     FRed := 255;
     FGreen := 255;
     FBlue := 255;
     FAlpha := 255;
     FAngle := 0;
     FScaleX := 1;
     FScaleY := 1;
     FDoCenter := False;
     FOffsetX := 0;
     FOffsetY := 0;
     FMirrorX := False;
     FMirrorY := False;
     FDrawMode := 0;
     FMouseEnterFlag := False;
     FMouseDownFlag:= False;
     FPositionListX := TList.Create;
     FPositionListY := TList.Create;
     FAttachTo := nil;
end;

destructor TSpriteEx.Destroy;
begin
     GroupNumber := -1;
     Selected := False;
     FPositionListX.Free;
     FPositionListY.Free;
     inherited Destroy;
end;

procedure TSpriteEx.Assign(const Value: TSprite);
begin
     FImageType := TSpriteEx(Value).ImageType;
     FX1 := TSpriteEx(Value).X1;
     FY1 := TSpriteEx(Value).Y1;
     FX2 := TSpriteEx(Value).X2;
     FY2 := TSpriteEx(Value).Y2;
     FX3 := TSpriteEx(Value).X3;
     FY3 := TSpriteEx(Value).Y3;
     FX4 := TSpriteEx(Value).X4;
     FY4 := TSpriteEx(Value).Y4;
     FOffsetX := TSpriteEx(Value).OffsetX;
     FOffsetY := TSpriteEx(Value).OffsetY;
     FCenterX := TSpriteEx(Value).CenterX;
     FCenterY := TSpriteEx(Value).CenterY;
     FMirrorX := TSpriteEx(Value).MirrorX;
     FMirrorY := TSpriteEx(Value).MirrorY;
     FScaleX := TSpriteEx(Value).ScaleX;
     FScaleY := TSpriteEx(Value).ScaleY;
     FDoCenter := TSpriteEx(Value).DoCenter;
     FRed := TSpriteEx(Value).Red;
     FGreen := TSpriteEx(Value).Green;
     FBlue := TSpriteEx(Value).Blue;
     FAlpha := TSpriteEx(Value).Alpha;
     FColor1 := TSpriteEx(Value).Color1;
     FColor2 := TSpriteEx(Value).Color2;
     FColor3 := TSpriteEx(Value).Color3;
     FColor4 := TSpriteEx(Value).Color4;
     Angle := TSpriteEx(Value).Angle;
     FDrawMode := TSpriteEx(Value).DrawMode;
end;

function TSpriteEx.GetSpriteAt(X, Y: Integer): TSprite;

  procedure Collision_GetSpriteAt(X, Y: Double; Sprite: TSpriteEx);
  var
    i,SWidth,SHeight: Integer;
    X1,Y1: Double;
    X2,Y2: Double;
    IsCollision:Boolean;
  begin
       if (Sprite.Parent<>nil) and not Sprite.Parent.visible then  Exit;
       Sprite.Collisioned:=false;
       if Sprite.CanCollision  then
       begin
            SWidth:=Round(Sprite.PatternWidth*Sprite.ScaleX);
            SHeight:=Round(Sprite.PatternHeight*Sprite.ScaleY);
            if Sprite.DrawMode=1 then
            begin
                 X1 := X-Sprite.X-Sprite.Parent.X;
                 Y1 := Y-Sprite.Y-Sprite.Parent.Y;
            end
            else
            if Sprite.DoCenter then
            begin
                 X1 := X-Sprite.X-Sprite.Parent.X-Sprite.PatternWidth/2;
                 Y1 := Y-Sprite.Y-Sprite.Parent.Y-Sprite.PatternHeight/2;
            end
            else
            begin
                 X1 := X-Sprite.X-Sprite.Parent.X-SWidth/2;
                 Y1 := Y-Sprite.Y-Sprite.Parent.Y-SHeight/2;
            end;
            X2 := Y1 * sin(Sprite.Angle) + X1 * cos(Sprite.Angle);
            Y2 := Y1 * cos(Sprite.Angle) - X1 * sin(Sprite.Angle);

            IsCollision:=Sprite.Visible and PointInRect(
              Point(Round(X2), Round(Y2)),
            Bounds(-SWidth div 2,-SHeight div 2,SWidth, SHeight));

            if IsCollision then
            begin
                 if (Result=nil) or (Sprite.Z>Result.Z) then
                    Result := Sprite;
            end;
    end;

    for i:=0 to Sprite.Count-1 do
      Collision_GetSpriteAt(X, Y, TSpriteex(Sprite.Items[i]));

  end;

var
  i: Integer;
begin
     Result := nil;
     if self.FEngine <> nil then
        Collision_GetSpriteAt(X, Y, TSpriteEx(Self));
     for i:=0 to Count-1 do
        Collision_GetSpriteAt(X, Y, TSpriteEx(Items[i]));
     if Result<>nil then
     begin
          Result.Collisioned := True;
          Result.DoCollision(Result);
     end;
end;

function GetAngle360(X, Y: Integer): Real;
begin
     Result := (Arctan2(X, Y) * -57.4) + 180;
end;

procedure TSpriteEx.LookAt(TargetX, TargetY: Integer);
begin
   //  Angle360 := Trunc(
   //  GetAngle360(TargetX - Trunc(Self.X) + Trunc(Engine.WorldX),
    //  TargetY - Trunc(Self.Y) + Trunc(Engine.WorldY ) )
      //);
     Angle:=Angle256(TargetX-Trunc(X) ,TargetY-Trunc(Y) )/40.3 ;
end;

procedure TSpriteEx.TowardToAngle(Angle: Integer; Speed: Single; DoLookAt: Boolean);
begin
     if DoLookAt then FAngle := Angle / 40;
     X := X + (Sin256(Angle) * Speed);
     Y := Y - (Cos256(Angle) * Speed);
end;

procedure TSpriteEx.TowardToPos(TargetX, TargetY: Integer; Speed: Single; DoLookAt: Boolean);
var
   Direction: Integer;
begin
     if DoLookAt then LookAt(TargetX, TargetY);
     Direction:=Trunc(
     Angle256(TargetX - Trunc(Self.X), TargetY - Trunc(Self.Y))
     );
    if (not SameValue(X, TargetX, Speed + 1)) or
    (not SameValue(Y, TargetY, Speed + 1))  then
    begin
          X := X + (Sin256(Direction) * Speed);
          Y := Y - (Cos256(Direction) * Speed);
    end
    else
    begin
         // make sure it gets to final pos
         X := TargetX;
         Y := TargetY;
    end;

end;
//toward(rotate self angle automation)(straight) move direction
//and move by rotation speed(to destination angle)
procedure TSpriteEx.RotateToAngle(Angle: Integer; RotateSpeed, MoveSpeed: Single );
begin
     FDestAngle := Angle;
     if not SameValue(FSrcAngle, FDestAngle, RotateSpeed + 1)  then
     begin
          if AngleDiff(FSrcAngle, FDestAngle) > 0 then
              FSrcAngle := FSrcAngle + RotateSpeed;
          if AngleDiff(FSrcAngle, FDestAngle) < 0 then
              FSrcAngle := FSrcAngle - RotateSpeed;
     end;
     if FSrcAngle > 255 then FSrcAngle := FSrcAngle - 255;
     if FSrcAngle < 0 then FSrcAngle := 255 + FSrcAngle;
     FAngle := FSrcAngle / 40;
     X := X + (Sin256(Trunc(FSrcAngle))* MoveSpeed);
     Y := Y - (Cos256(Trunc(FSrcAngle))* MoveSpeed);

end;
//toward(rotate self angle automation)(straight) move  direction
//and move by rotation speed(to destination position)
procedure TSpriteEx.RotateToPos(DestX, DestY: Integer; RotateSpeed, MoveSpeed: Single );
begin
     FDestAngle:= Trunc(
      Angle256(DestX - Trunc(X), DestY - Trunc(Y) )
      );

     if not SameValue(FSrcAngle, FDestAngle, RotateSpeed + 1)  then
     begin
          if AngleDiff(FSrcAngle, FDestAngle) > 0 then
              FSrcAngle := FSrcAngle + RotateSpeed;
          if AngleDiff(FSrcAngle, FDestAngle) < 0 then
              FSrcAngle := FSrcAngle - RotateSpeed;
     end;
     if FSrcAngle > 255 then FSrcAngle := FSrcAngle - 255;
     if FSrcAngle < 0 then FSrcAngle := 255 + FSrcAngle;
     FAngle := FSrcAngle / 40;
     X := X + (Sin256(Trunc(FSrcAngle))* MoveSpeed);
     Y := Y - (Cos256(Trunc(FSrcAngle))* MoveSpeed);
end;
//move by rotation speed to destination angle,but not straight direction(no rotate self)
//but can be custom angle
procedure TSpriteEx.CircleToAngle(Angle, LookAtX, LookAtY: Integer; RotateSpeed, MoveSpeed: Single; DoLookAt: Boolean);
begin
     if  DoLookAt then LookAt(LookAtX, LookAtY);
     FDestAngle := Angle;
     if not SameValue(FSrcAngle, FDestAngle, RotateSpeed + 1)  then
     begin
          if AngleDiff(FSrcAngle, FDestAngle) > 0 then
              FSrcAngle := FSrcAngle + RotateSpeed;
          if AngleDiff(FSrcAngle, FDestAngle) < 0 then
              FSrcAngle := FSrcAngle - RotateSpeed;
     end;                                               
     if FSrcAngle > 255 then FSrcAngle := FSrcAngle - 255;
     if FSrcAngle < 0 then FSrcAngle := 255 + FSrcAngle;
     X := X + (Sin256(Trunc(FSrcAngle))* MoveSpeed);
     Y := Y - (Cos256(Trunc(FSrcAngle))* MoveSpeed);
end;
//move by rotation speed to destination position,but not straight direction(no rotae self)
//but can be custom angle
procedure TSpriteEx.CircleToPos(DestX, DestY, LookAtX, LookAtY: Integer; RotateSpeed, MoveSpeed: Single; DoLookAt: Boolean);
begin
      if  DoLookAt then LookAt(LookAtX, LookAtY);
      FDestAngle:= Trunc(
      Angle256(DestX - Trunc(X), DestY - Trunc(Y) )
      );

     if not SameValue(FSrcAngle, FDestAngle, RotateSpeed + 1)  then
     begin
          if AngleDiff(FSrcAngle, FDestAngle) > 0 then
              FSrcAngle := FSrcAngle + RotateSpeed;
          if AngleDiff(FSrcAngle, FDestAngle) < 0 then
              FSrcAngle := FSrcAngle - RotateSpeed;
     end;
     if FSrcAngle > 255 then FSrcAngle := FSrcAngle - 255;
     if FSrcAngle < 0 then FSrcAngle := 255 + FSrcAngle;
     X := X + (Sin256(Trunc(FSrcAngle))* MoveSpeed);
     Y := Y - (Cos256(Trunc(FSrcAngle))* MoveSpeed);
end;

procedure  TSpriteEx.Attach(Sprite: TSprite);
var
   CurrentPositionX, PredPositionX, LastPositionX: ^Single;
   CurrentPositionY, PredPositionY, LastPositionY: ^Single;
begin
     FAttachTo := Sprite;
     New(CurrentPositionX);
     New(CurrentPositionY);
     CurrentPositionX^ := FAttachTo.FX;
     CurrentPositionY^ := FAttachTo.FY;
     FPositionListX.Add(CurrentPositionX);
     FPositionListY.Add(CurrentPositionY);
     if FPositionListX.Count > 2 then
     begin
          LastPositionX := FPositionListX.Last;
          LastPositionY := FPositionListY.Last;
          PredPositionX := FPositionListX.Items[1];
          PredPositionY := FPositionListY.Items[1];
          FX := FX + (LastPositionX^ - PredPositionX^);
          FY := FY + (LastPositionY^ - PredPositionY^);
          FPositionListX.Delete(0);
          FPositionListY.Delete(0);
     end;
end;

procedure TSpriteEx.Detach;
begin
     FAttachTo := nil;
end;

function TSpriteEx.GetDistance(Sprite1: TSprite; Sprite2: TSprite): Real;
begin
     Result:= Hypot(Sprite1.X - Sprite2.X, Sprite1.Y - Sprite2.Y);
end;


procedure TSpriteEx.DoDraw;
//var
//   ImgName: string;
begin
     {
     case ImageType of
          itSingleImage: ImgName := FImageName + IntToStr(FImageIndex);
          itSpriteSheet: ImgName := FImageName;
     end;
     }
     //Trunc(FX + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)),
     //Trunc(FY + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
     case FDrawMode of
          //1 color mode
          0:
          case TruncMove of
            True:
            FEngine.FCanvas.DrawColor1(FEngine.FImages.Image[FImageName],
            FPatternIndex,
            Trunc(FX + FWorldX + FOffsetX - FEngine.FWorldX),
            Trunc(FY + FWorldY + FOffsetY - FEngine.FWorldY),
            FScaleX, FScaleY, FDoCenter,
            FMirrorX, FMirrorY,
            FRed, FGreen, FBlue, FAlpha, FBlendMode);

            False:
            FEngine.FCanvas.DrawColor1(FEngine.FImages.Image[FImageName],
            FPatternIndex,
            FX + FWorldX + FOffsetX - FEngine.FWorldX,
            FY + FWorldY + FOffsetY - FEngine.FWorldY,
            FScaleX, FScaleY, FDoCenter,
            FMirrorX, FMirrorY,
            FRed, FGreen, FBlue, FAlpha, FBlendMode);
          end;

           // 1 color mode+Rotation
          1:FEngine.FCanvas.DrawRotateC(FEngine.FImages.Image[FImageName],
            FPatternIndex,
            FX + FWorldX + FOffsetX - FEngine.FWorldX,
            FY + FWorldY + FOffsetY - FEngine.FWorldY,
            FAngle, FScaleX, FScaleY,
            FMirrorX, FMirrorY,
            ARGB(FAlpha, FRed, FGreen, FGreen), FBlendMode);

           //4 color mode
          2:FEngine.FCanvas.DrawColor4(FEngine.FImages.Image[FImageName],
            FPatternIndex,
            Trunc(FX + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)),
            Trunc(FY + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
            FScaleX, FScaleY, FDoCenter,
            FMirrorX, FMirrorY,
            Color1, Color2, Color3, Color4, FBlendMode);

            //1 color  mode+transform
          3:FEngine.FCanvas.Draw4V(FEngine.FImages.Image[FImageName],
            FPatternIndex,
            Trunc(FX1 + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)), Trunc(FY1 + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
            Trunc(FX2 + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)), Trunc(FY2 + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
            Trunc(FX3 + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)), Trunc(FY3 + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
            Trunc(FX4 + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)), Trunc(FY4 + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
            FMirrorX, FMirrorY,
            ARGB(FRed, FGreen, FBlue, FAlpha), FBlendMode);

            //4 color mode+transform
           4:FEngine.FCanvas.Draw4v(FEngine.FImages.Image[FImageName],
             FPatternIndex,
             Trunc(FX1 + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)), Trunc(FY1 + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
             Trunc(FX2 + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)), Trunc(FY2 + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
             Trunc(FX3 + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)), Trunc(FY3 + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
             Trunc(FX4 + FWorldX + FOffsetX - Trunc(FEngine.FWorldX)), Trunc(FY4 + FWorldY + FOffsetY - Trunc(FEngine.FWorldY)),
             FMirrorX, FMirrorY,
             Color1, Color2, Color3, Color4, FBlendMode);
     end;
end;

procedure TSpriteEx.SetColor(const Color: Cardinal);
begin
end;

procedure TSpriteEx.SetColor(Red, Green, Blue: Cardinal; Alpha: Cardinal = 255);
begin
     FRed := Red;
     FGreen := Green;
     FBlue := Blue;
     FAlpha := Alpha;
end;

procedure TSpriteEx.SetRed(const Value: Integer);
begin
     inherited;
     Self.FRed := Value;
     SetColor(ARGB(FAlpha, FRed, FGreen, FBlue));
end;

procedure TSpriteEx.SetGreen(const Value: Integer);
begin
     inherited;
     Self.FGreen := Value;
     SetColor(ARGB(FAlpha, FRed, FGreen, FBlue));
end;

procedure TSpriteEx.SetBlue(const Value: Integer);
begin
     inherited;
     Self.FBlue := Value;
     SetColor(ARGB(FAlpha, FRed, FGreen, FBlue));
end;

procedure TSpriteEx.SetAlpha(const Value: Integer);
begin
     inherited;
     Self.FAlpha := Value;
     SetColor(ARGB(FAlpha, FRed, FGreen, FBlue));
end;

procedure TSpriteEx.SetAngle360(Value: Integer);
begin
     if FAngle360 <> Value then
         FAngle := DegToRad(Value);
end;

procedure TSpriteEx.SetDrawMode(const Value: Integer);
begin
     Self.FDrawMode := Value;
     if FDrawMode > 4 then FDrawMode := 0;
end;

procedure TSpriteEx.SetGroupNumber(AGroupNumber: Integer);
begin
     if (AGroupNumber <> GroupNumber) and  (Engine <> nil) then
     begin
          if Groupnumber >= 0 then
              Engine.Groups[GroupNumber].Remove(Self);
          if AGroupNumber >= 0 then
              Engine.Groups[AGroupNumber].Add(Self);
     end;
end;

procedure TSpriteEx.SetSelected(ASelected : Boolean);
begin
     if (ASelected <> FSelected) and  (Engine <> nil) then
     begin
          FSelected := ASelected;
          if Selected then
              Engine.CurrentSelected.Add(Self)
          else
              Engine.CurrentSelected.Remove(Self);
              Engine.FObjectsSelected := Engine.CurrentSelected.Count <> 0;
     end;
end;

function TSpriteEx.GetBoundsRect: TRect;
begin
     Result := Bounds(Round(FX), Round(FY), Round(FX + Width), Round(FY + Height));
end;

function TSpriteEx.MouseInRect: Boolean;
begin
     Result:= PtInRect(Rect(FActiveRect.Left - Trunc(FEngine.WorldX),
                            FActiveRect.Top - Trunc(FEngine.WorldY),
                            FActiveRect.Right - Trunc(FEngine.WorldX),
                            FActiveRect.Bottom - Trunc(FEngine.WorldY)),
                       Point(Trunc(MouseX), Trunc(MouseY)));
end;

function TSpriteEx.SpriteInRect1(InArea: TRect): Boolean;
begin
     Result := RectInRect(FActiveRect, InArea);
end;

function TSpriteEx.SpriteInRect2(InArea: TRect): Boolean;
begin
     Result := RectInRect(Rect(FActiveRect.Left - Trunc(FEngine.WorldX),
                               FActiveRect.Top - Trunc(FEngine.WorldY),
                               FActiveRect.Right -Trunc(FEngine.WorldX),
                               FActiveRect.Bottom - Trunc(FEngine.WorldY)),
                               InArea);
end;

procedure TSpriteEx.DoMouseEvent;
begin
  if (Event.EventType=4) then
     FMouseDownFlag:= False;
  if MouseInRect then
  begin
    if FMouseEnterFlag = False then
    begin

      OnMouseEnter;
      FMouseEnterFlag := True;
    end;
    //
    case Event.EventType of
         //mouse down
         3:
         begin
           if Event.Key = HGEK_LBUTTON then
           begin
             FMouseDownFlag:=True;
             OnLMouseDown;
           end;
           if Event.Key = HGEK_RBUTTON then
              OnRMouseDown;
         end;
         //mouse up
         4:
         begin
           if Event.Key = HGEK_LBUTTON then
           begin
              FMouseDownFlag := False;
              OnLMouseUp;
           end;
           if Event.Key = HGEK_RBUTTON then
              OnRMouseUp;
         end;
         //mouse move
         5:
         begin
           OnMouseMove;
           if FMouseDownFlag = True then
              OnMouseDrag;
         end;
    end;


    if Event.Flags =96 then
       OnMouseDbClick;
    if Event.Wheel=1 then
       OnMouseWheelUp;
    if Event.Wheel=-1 then
       OnMouseWheelDown;
  end;

  if (not MouseInRect) then
  begin
    if FMouseEnterFlag = True then
    begin
      OnMouseLeave;
      FMouseEnterFlag := False;
    end;
  end;
end;

procedure TSpriteEx.OnMouseEnter;
begin
end;

procedure TSpriteEx.OnMouseLeave;
begin
end;

procedure TSpriteEx.OnMouseMove;
begin
end;

procedure TSpriteEx.OnLMouseDown;
begin
end;

procedure TSpriteEx.OnLMouseUp;
begin
end;

procedure TSpriteEx.OnRMouseDown;
begin
end;

procedure TSpriteEx.OnRMouseUp;
begin
end;

procedure TSpriteEx.OnMouseDbClick;
begin
end;

procedure TSpriteEx.OnMouseWheelUp;
begin
end;

procedure TSpriteEx.OnMouseWheelDown;
begin
end;

procedure TSpriteEx.OnMouseDrag;
begin
end;

{  TAnimatedSprite  }
constructor TAnimatedSprite.Create(const AParent: TSprite);
begin
     inherited;
     FDoAnimate := False;
     FAnimLooped := True;
     FAnimStart := 0;
     FAnimCount := 0;
     FAnimSpeed := 0;
     FAnimPos := 0;
     FAnimPlayMode := pmForward;
     FDoFlag1 := False;
     FDoFlag2 := False;
end;

procedure TAnimatedSprite.Assign(const Value: TSprite);
begin
     if (Value is TAnimatedSprite) then
     begin
          DoAnimate := TAnimatedSprite(Value).DoAnimate;
          AnimStart := TAnimatedSprite(Value).AnimStart;
          AnimCount := TAnimatedSprite(Value).AnimCount;
          AnimSpeed := TAnimatedSprite(Value).AnimSpeed;
          AnimLooped := TAnimatedSprite(Value).AnimLooped;
     end;
     inherited;
end;

procedure TAnimatedSprite.SetAnimStart(Value: Integer);
begin
     if FAnimStart <> Value then
     begin
          FAnimStart := Value;
          FAnimPos := Value;
     end;
end;

function Mod2f(i: Double; i2: Integer): Double;
begin
     if i2=0 then
          Result := i
     else
     begin
          Result := i-Trunc(i / i2) * i2;
          if Result<0 then
               Result := i2 + Result;
     end;
end;

procedure TAnimatedSprite.DoMove(const MoveCount: Single);
begin
     if not FDoAnimate then Exit;
     case FAnimPlayMode of
          pmForward: //12345 12345  12345
          begin
               FAnimPos := FAnimPos + FAnimSpeed * MoveCount;
               if (FAnimPos >= FAnimStart + FAnimCount ) then
               begin
                    if (Trunc(FAnimPos))= FAnimStart then OnAnimStart;
                    if (Trunc(FAnimPos)) = FAnimStart + FAnimCount then
                    begin
                         FAnimEnded := True;
                         OnAnimEnd;
                    end;

                    if FAnimLooped then
                       FAnimPos := FAnimStart
                    else
                    begin
                         FAnimPos := FAnimStart + FAnimCount-1 ;
                         FDoAnimate := False;
                    end;
               end;
               FPatternIndex := Trunc(FAnimPos);
               FImageIndex := Trunc(FAnimPos);
               {
               FAnimPos := FAnimPos + FAnimSpeed*MoveCount;
               if FAnimLooped then
               begin
                    if FAnimCount>0 then
                         FAnimPos := Mod2f(FAnimPos, FAnimCount)
                    else
                         FAnimPos := 0;
               end
               else
               begin
                    if FAnimPos>=FAnimCount then
                    begin
                         FAnimPos := FAnimCount-1;
                         FAnimSpeed := 0;
                    end;
                    if FAnimPos<0 then
                    begin
                         FAnimPos := 0;
                         FAnimSpeed := 0;
                    end;
               end;
               if (Trunc(AnimPos))= FAnimStart then OnAnimStart;
               if (Trunc(FAnimPos)) = FAnimStart + FAnimCount then
               begin
                    FAnimEnded := True;
                    OnAnimEnd;
               end;
               FPatternIndex := Trunc(FAnimPos)+FAnimStart;
               FImageIndex := Trunc(FAnimPos)+FAnimStart;
          }
          end;
          pmBackward: //54321 54321 54321
          begin
               FAnimPos := FAnimPos - FAnimSpeed * MoveCount;
               if (FAnimPos < FAnimStart) then
               begin
                   if FAnimLooped then
                        FAnimPos := FAnimStart + FAnimCount
               else
               begin
                   // FAnimPos := FAnimStart;
                     FAnimPos := FAnimStart + FAnimCount;
                    FDoAnimate := False;
               end;
               end;
               FPatternIndex := Trunc(FAnimPos);
               FImageIndex := Trunc(FAnimPos);
          end;
          pmPingPong: // 12345432123454321
          begin
               FAnimPos := FAnimPos + FAnimSpeed * MoveCount;
               if FAnimLooped then
               begin
                    if (FAnimPos > FAnimStart + FAnimCount - 1) or (FAnimPos < FAnimStart) then
                        FAnimSpeed := -FAnimSpeed;
               end
               else
               begin
                    if (FAnimPos > FAnimStart + FAnimCount) or (FAnimPos < FAnimStart) then
                         FAnimSpeed := -FAnimSpeed;
                    if (Trunc(FAnimPos)) = (FAnimStart + FAnimCount) then
                              FDoFlag1 := True;
                    if (Trunc(FAnimPos) = FAnimStart) and (FDoFlag1) then
                              FDoFlag2 := True;
                    if (FDoFlag1) and (FDoFlag2) then
                    begin
                         //FAnimPos := FAnimStart;
                         FDoAnimate := False;
                         FDoFlag1 := False;
                         FDoFlag2 := False;
                    end;
               end;
                   FPatternIndex := Round(FAnimPos);
                   FImageIndex := Round(FAnimPos);
          end;
     end;
   // FPatternIndex := Trunc(FAnimPos);
   // FImageIndex := Trunc(FAnimPos);
end;

procedure TAnimatedSprite.SetAnim(AniImageName: string; AniStart, AniCount: Integer; AniSpeed: Single; AniLooped, DoMirror, DoAnimate: Boolean;
                  PlayMode: TAnimPlayMode = pmForward);
begin
     ImageName := AniImageName;
     FAnimStart := AniStart;
     FAnimCount := AniCount;
     FAnimSpeed := AniSpeed;
     FAnimLooped:= AniLooped;
     MirrorX := DoMirror;
     FDoAnimate := DoAnimate;
     FAnimPlayMode := PlayMode;

    if (FPatternIndex < FAnimStart) or (FPatternIndex >= FAnimCount + FAnimStart) then
    begin
         FPatternIndex := FAnimStart mod fanimcount ;
         FAnimPos := FAnimStart;
    end;
end;

procedure TAnimatedSprite.SetAnim(AniImageName: string; AniStart, AniCount: Integer; AniSpeed: Single; AniLooped: Boolean;
                  PlayMode: TAnimPlayMode = pmForward);
begin
     ImageName := AniImageName;
     FAnimStart := AniStart;
     FAnimCount := AniCount;
     FAnimSpeed := AniSpeed;
     FAnimLooped:= AniLooped;
     FAnimPlayMode := PlayMode;
     if (FPatternIndex < FAnimStart) or (FPatternIndex >= FAnimCount + FAnimStart) then
     begin
          FPatternIndex := FAnimStart mod fanimcount;
          FAnimPos := FAnimStart;
     end;
end;

procedure TAnimatedSprite.OnAnimStart;
begin
end;

procedure TAnimatedSprite.OnAnimEnd;
begin
end;

{ TParticleSprite}
constructor TParticleSprite.Create(const AParent: TSprite);
begin
     inherited;
     FAccelX := 0;
     FAccelY := 0;
     FVelocityX := 0;
     FVelocityY := 0;
     FUpdateSpeed :=0;
     FDecay := 0;
     FLifeTime := 1;
end;

procedure TParticleSprite.DoMove(const MoveCount: Single);
begin
     inherited;
     X := X + FVelocityX * UpdateSpeed * MoveCount;
     Y := Y + FVelocityY * UpdateSpeed * MoveCount;
     FVelocityX := FVelocityX + FAccelX * UpdateSpeed;
     FVelocityY := FVelocityY + FAccelY * UpdateSpeed;
     FLifeTime := FLifeTime - FDecay * MoveCount;
     if FLifeTime <= 0 then Dead;
end;

{  TPlayerSprite   }
constructor TPlayerSprite.Create(const AParent: TSprite);
begin
     inherited;
     FVelocityX := 0;
     FVelocityY := 0;
     Acceleration := 0;
     Decceleration := 0;
     Speed := 0;
     MinSpeed := 0;
     MaxSpeed := 0;
     FDirection := 0;
end;

procedure TPlayerSprite.SetSpeed(Value: Single);
begin
     if FSpeed > FMaxSpeed then
          FSpeed := FMaxSpeed
     else
          if FSpeed < FMinSpeed then
               FSpeed := FMinSpeed;
     FSpeed := Value;
     VelocityX := Cos256(FDirection + 192) * Speed;
     VelocityY := Sin256(FDirection + 192) * Speed;
end;

procedure TPlayerSprite.SetDirection(Value: Integer);
begin
     FDirection := Value;
     VelocityX := Cos256(FDirection + 192) * Speed;
     VelocityY := Sin256(FDirection + 192) * Speed;
end;

procedure TPlayerSprite.FlipXDirection;
begin
     if FDirection >= 64 then
          FDirection := 192 + (64 - FDirection)
     else
          if FDirection > 0 then
               FDirection := 256 - FDirection;
end;

procedure TPlayerSprite.FlipYDirection;
begin
     if FDirection > 128 then
          FDirection := 128 + (256 - FDirection)
     else
          FDirection := 128 - FDirection;
end;

procedure TPlayerSprite.Accelerate;
begin
     if FSpeed <> FMaxSpeed then
     begin
          FSpeed := FSpeed + FAcc;
          if FSpeed > FMaxSpeed then
               FSpeed := FMaxSpeed;
          VelocityX := Cos256(FDirection + 192) * Speed;
          VelocityY := Sin256(FDirection + 192) * Speed;
     end;
end;

procedure TPlayerSprite.Deccelerate;
begin
     if FSpeed <> FMinSpeed then
     begin
          FSpeed := FSpeed - FDcc;
          if FSpeed < FMinSpeed then
               FSpeed := FMinSpeed;
          VelocityX := Cos256(FDirection + 192) * Speed;
          VelocityY := Sin256(FDirection + 192) * Speed;
     end;
end;

procedure TPlayerSprite.UpdatePos(const MoveCount: Single);
begin
     inherited;
     X := X + VelocityX * MoveCount;
     Y := Y + VelocityY * MoveCount;
end;

{TFaderSprite}
procedure TFaderSprite.DoMove(const MoveCount: Single);
var
   a, b: Single;
begin
     inherited;
     FFadeEnded := False;
     a := Counter * 0.01;
     b := 1 - a;
     FCurR := Round(FSrcR * b + a * FDestR);
     FCurG := Round(FSrcG * b + a * FDestG);
     FCurB := Round(FSrcB * b + a * FDestB);
     FCurA := Round(FSrcA * b + a * FDestA);
     Counter := Counter + FSpeed * MoveCount;
     if Counter >= 100 then
     begin
          if FMultiFade then
          begin
               Inc(FCurrentColorCount);
               if FCurrentColorCount > FNumColors then
               begin
                    if FLooped then
                    begin
                         Counter := 0;
                         FCurrentColorCount := 0;
                         FCurCol := FMultiCols;
                         SetSourceColor(FCurR, FCurG, FCurB, FCurA);
                         SetDestinationColor(FCurCol^);
                         Exit;
                    end
                    else
                    begin
                         Counter := 100;
                         FFadeEnded := True;
                         FMultiFade := False;
                         FMulti := False;
                         FreeMem(FMultiCols);
                    end;
                    Exit;
               end;
               Inc(FCurCol);
               Counter := 0;
               SetSourceColor(FCurR, FCurG, FCurB, FCurA);
               SetDestinationColor(FCurCol^);
          end
          else
          if FMirrorFade then
          begin
               Inc(FMirrorCount);
               if (FMirrorCount > 1) and (FLooped = False) then
               begin
                    Counter := 100;
                    FFadeEnded := True;
               end
               else
               begin
                    Counter := 0;
                    SetDestinationColor(FSrcR, FSrcG, FSrcB, FSrcA);
                    SetSourceColor(FCurR, FCurG, FCurB, FCurA);
               end;
          end
          else
          begin
               if (FLooped) then Counter := 0
               else
               begin
                    Counter := 100;
                    FFadeEnded := True;
               end;
          end;
     end;
     Self.Red := FCurR;
     Self.Green := FCurG;
     Self.Blue := FCurB;
     Self.Alpha := FCurA;
end;

procedure TFaderSprite.Reset;
begin
     Counter := 0;
     FMirrorCount := 0;
     FFadeEnded := False;
end;

procedure TFaderSprite.SetSourceColor(Red, Green, Blue, Alpha: Byte);
begin
     FSrcR := Red;
     FSrcG := Green;
     FSrcB := Blue;
     FSrcA := Alpha;
     FCurR := Red;
     FCurG := Green;
     FCurB := Blue;
     FCurA := Alpha;
end;

procedure TFaderSprite.SetDestinationColor(Red, Green, Blue, Alpha: Byte);
begin
     FDestR := Red;
     FDestG := Green;
     FDestB := Blue;
     FDestA := Alpha;
end;

procedure TFaderSprite.SetDestinationColor(Color: Cardinal);
begin
     SetDestinationColor(ARGB(Alpha, Green, Blue , Alpha));
end;

procedure TFaderSprite.SetSourceColor(Color: Cardinal);
begin
     SetSourceColor(ARGB(Alpha,Red, Green, Blue));
end;

procedure TFaderSprite.SetFadeSpeed(Speed: Single);
begin
     if Speed > 100 then Speed := 100;
     if Speed < 0 then Speed := 0;
     FSpeed := Speed;
end;

constructor  TFaderSprite.Create(const AParent: TSprite);
begin
     inherited;
     FMultiFade := False;
     FLooped := False;
     FMulti := False;

     SetFadeSpeed(0.1);
     SetSourceColor(0, 0, 0, 0);
     SetDestinationColor(0, 0, 0, 255);
     FMirrorFade := False;
     FMirrorCount := 0;
     Reset;
end;

destructor TFaderSprite.Destroy;
begin
     if FMulti {FMultiCols<>nil{assigned(FMultiCols)} then Freemem(FMultiCols);
     inherited Destroy;;
end;

procedure TFaderSprite.SwapColors;
begin
     FCurR := FDestR;
     FCurG := FDestG;
     FCurB := FDestB;
     FCurA := FDestA;
     FDestR := FSrcR;
     FDestG := FSrcG;
     FDestB := FSrcB;
     FDestA := FSrcA;
     FSrcR := FCurR;
     FSrcG := FCurG;
     FSrcB := FCurB;
     FSrcA := FCurA;
end;

procedure TFaderSprite.FadeIn(Red, Green, blue: Byte; Speed: Single);
begin
     SetSourceColor(Red, Green, Blue, 0);
     SetDestinationColor(Red, green, Blue, 255);
     SetFadeSpeed(Speed);
     Reset;
end;

procedure TFaderSprite.FadeOut(Red, Green, Blue: Byte; Speed: Single);
begin
     SetSourceColor(Red, Green, Blue, 255);
     SetDestinationColor(Red, Green, Blue, 0);
     SetFadeSpeed(Speed);
     Reset;
end;

procedure TFaderSprite.MultiFade(Colors: array of Cardinal);
begin
     GetMem(FMultiCols, SizeOf(Colors));
     FMulti := True;
     System.Move(Colors, FMultiCols^, SizeOf(Colors));
     FNumColors := High(Colors);
     if FNumColors < 0 then Exit;
     SetSourceColor(Colors[0]);
     if FNumColors > 0 then SetDestinationColor(Colors[1]);
     FCurrentColorCount := 0;
     FCurCol := FMultiCols;
     Inc(FCurCol);
     FMultiFade := True;
     Reset;
end;

procedure TFaderSprite.Stop;
begin
     FFadeEnded := True;
end;

{ TJumperSprite }
constructor TJumperSprite.Create(const AParent: TSprite);
begin
     inherited;
     FVelocityX := 0;
     FVelocityY := 0;
     MaxSpeed := FMaxSpeed;
     FDirection := 0;
     FJumpState := jsNone;
     FJumpSpeed := 0.25;
     FJumpHeight := 8;
     Acceleration := 0.2;
     Decceleration := 0.2;
     FMaxFallSpeed := 5;
     DoJump := False;
end;

procedure TJumperSprite.SetJumpState(Value: TJumpState);
begin
     if FJumpState <> Value then
     begin
          FJumpState := Value;
          case Value of
               jsNone,
               jsFalling:
               begin
                    FVelocityY := 0;
               end;
          end;
     end;
end;

procedure TJumperSprite.Accelerate;
begin
     if FSpeed <> FMaxSpeed then
     begin
          FSpeed := FSpeed + FAcc;
          if FSpeed > FMaxSpeed then
             FSpeed := FMaxSpeed;
          VelocityX := Cos256(FDirection) * Speed;
     end;
end;

procedure TJumperSprite.Deccelerate;
begin
     if FSpeed <> FMaxSpeed then
     begin
          FSpeed := FSpeed + FAcc;
          if FSpeed < FMaxSpeed then
             FSpeed := FMaxSpeed;
          VelocityX := Cos256(FDirection) * Speed;
     end;
end;

procedure TJumperSprite.DoMove(const MoveCount: Single);
begin
     inherited;
     case FJumpState of
          jsNone:
          begin
               if DoJump then
               begin
                    FJumpState := jsJumping;
                    VelocityY := -FJumpHeight;
               end;
          end;
          jsJumping:
          begin
               Y := Y + FVelocityY * MoveCount ;
               VelocityY := FVelocityY + FJumpSpeed;
               if VelocityY > 0 then
                  FJumpState := jsFalling;
          end;
          jsFalling:
          begin
               Y := Y + FVelocityY * MoveCount ;
               VelocityY := VelocityY + FJumpSpeed;
               if VelocityY > FMaxFallSpeed then
                  VelocityY := FMaxFallSpeed;
          end;
     end;
     DoJump := False;
end;

{ TJumperSpriteEx }
constructor TJumperSpriteEx.Create(const AParent: TSprite);
begin
     inherited;
     FVelocityX := 0;
     FVelocityY := 0;
     MaxSpeed := FMaxSpeed;
     FDirection := 0;
     FJumpState := jsNone;
     FJumpSpeed := 0.2;
     FJumpStartSpeed := 0.2;
     FLowJumpSpeed := 0.185;
     FLowJumpGravity :=0.6;
     FHighJumpValue:=1000;
     FHighJumpSpeed:=0.1;
     FFallingSpeed:=0.2;
     FJumpCount := 0;
     FJumpHeight := 8;
     Acceleration := 0.2;
     Decceleration := 0.2;
     FMaxFallSpeed := 5;
     DoJump:= False;
end;

procedure TJumperSpriteEx.SetJumpState(Value: TJumpState);
begin
     if FJumpState <> Value then
     begin
          FJumpState := Value;
          case Value of
               jsNone,
               jsFalling:
               begin
                    FVelocityY := 0;
               end;
          end;
     end;
end;

procedure TJumperSpriteEx.Accelerate;
begin
     if FSpeed <> FMaxSpeed then
     begin
          FSpeed := FSpeed + FAcc;
          if FSpeed > FMaxSpeed then
             FSpeed := FMaxSpeed;
          VelocityX := Cos256(FDirection) * Speed;
     end;
end;

procedure TJumperSpriteEx.Deccelerate;
begin
     if FSpeed <> FMaxSpeed then
     begin
          FSpeed:= FSpeed+FAcc;
          if FSpeed < FMaxSpeed then
             FSpeed := FMaxSpeed;
          VelocityX := Cos256(FDirection) * Speed;
     end;
end;

procedure TJumperSpriteEx.DoMove(const MoveCount: Single);
begin
    inherited;
    case FJumpState of
         jsNone:
         begin
               if DoJump then
               begin
                    FHoldKey := True;
                    FJumpSpeed := FJumpStartSpeed;
                    FJumpState := jsJumping;
                    VelocityY := -FJumpHeight;
               end;
         end;
         jsJumping:
         begin
              if FHoldKey = True then  Inc(FJumpCount);
              if FHoldKey = False then
              begin
                   FJumpSpeed := FLowJumpSpeed;//0.185;
                   FOffset := VelocityY;
                   VelocityY := FOffset * FLowJumpGravity;//0.6;  //range 0.0-->1.0
                   FHoldKey := True;
                   FJumpCount := 0;
              end;
              if (FJumpCount > FHighJumpValue)  then
                  FJumpSpeed := FHighJumpSpeed;
              Y := Y + FVelocityY * MoveCount ;
              VelocityY := FVelocityY + FJumpSpeed * MoveCount;
              if VelocityY > 0 then
                  FJumpState := jsFalling;
         end;
         jsFalling:
         begin
              FJumpCount := 0;
              FJumpSpeed := FFallingSpeed;
              Y := Y + FVelocityY * MoveCount;
              VelocityY := VelocityY + FJumpSpeed * MoveCount ;
              if VelocityY > FMaxFallSpeed then
                  VelocityY := FMaxFallSpeed;
         end;
     end;
     DoJump := False;
end;

{  TTileMapSprite  }
constructor TTileMapSprite.Create(const AParent: TSprite);
begin
     inherited Create(AParent);
     X := 0;
     Y := 0;
     Collisioned := False;
end;

destructor TTileMapSprite.Destroy;
begin
     SetMapSize(0, 0);
     inherited Destroy;
end;

procedure TTileMapSprite.Draw;
var
  i: Integer;
begin
     if FVisible then
     begin
          if FEngine <> nil then
          begin
               if  FDoTile then
               begin
                    {
                    if (X > FEngine.WorldX - Width + X) and
                    (Y > FEngine.WorldY - Height + Y) and
                    (X < FEngine.WorldX + FEngine.VisibleWidth + X )  and
                    (Y < FEngine.WorldY + FEngine.VisibleHeight+ Y) then
                    }
                    if (X > FEngine.WorldX - Width -Engine.WorldX) and
                    (Y > FEngine.WorldY - Height -Engine.WorldY) and
                    (X < FEngine.WorldX + FEngine.VisibleWidth -Engine.WorldX )  and
                    (Y < FEngine.WorldY + FEngine.VisibleHeight-Engine.WorldY) then
                    begin
                         DoDraw;
                         Inc(FEngine.FDrawCount);
                    end;
               end
               else
               begin
                    if (X > FEngine.WorldX - Width - FMapW) and
                    (Y > FEngine.WorldY - Height - FMapH)   and
                    (X < FEngine.WorldX + FEngine.VisibleWidth + 200)  and
                    (Y < FEngine.WorldY + FEngine.VisibleHeight + 200) then
                    begin
                         DoDraw;
                         Inc(FEngine.FDrawCount);
                    end;
               end;
          end;

          if FDrawList <> nil then
          begin
               for i := 0 to FDrawList.Count - 1 do
                   TSprite(FDrawList[i]).Draw;
          end;
     end;
end;

function Mod2(i, i2: Integer): Integer;
begin
     Result := i mod i2;
     if Result < 0 then
        Result := i2 + Result;
end;

procedure TTileMapSprite.DoDraw;
var
   _x, _y, cx, cy, cx2, cy2, c, ChipWidth, ChipHeight: Integer;
   StartX, StartY, EndX, EndY, StartX_, StartY_, OfsX, OfsY, dWidth, dHeight: Integer;
begin
     if (FMapWidth <= 0) or (FMapHeight <= 0) then Exit;
     ChipWidth := Self.Width;
     ChipHeight := Self.Height;

     dWidth := (Engine.VisibleWidth + ChipWidth) div ChipWidth + 1;
     dHeight := (Engine.VisibleHeight + ChipHeight) div ChipHeight + 1;

     _x := Trunc(-Engine.WorldX - X);
     _y := Trunc(-Engine.WorldY - Y);

     OfsX := _x mod ChipWidth;
     OfsY := _y mod ChipHeight;

     StartX := _x div ChipWidth;
     StartX_ := 0;

     if StartX < 0 then
     begin
          StartX_ := -StartX;
          StartX := 0;
     end;

     StartY := _y div ChipHeight;
     StartY_ := 0;

     if StartY < 0 then
     begin
          StartY_ := -StartY;
          StartY := 0;
     end;

     EndX := Min(StartX + FMapWidth - StartX_, dWidth);
     EndY := Min(StartY + FMapHeight - StartY_, dHeight);

     if FDoTile then
     begin
          for cy := -1 to dHeight do
          begin
               cy2 := Mod2((cy - StartY + StartY_), FMapHeight);
               for cx := -1 to dWidth do
               begin
                    cx2 := Mod2((cx - StartX + StartX_), FMapWidth);
                    c := Cells[cx2, cy2];
                    if c >= 0 then
                       FEngine.FCanvas.DrawColor1(
                       FEngine.FImages.Image[ImageName],
                       c,
                       cx * ChipWidth + OfsX,
                       cy * ChipHeight + OfsY,
                       FScaleX, FScaleY, FDoCenter,
                       FMirrorX, FMirrorY,
                       FRed, FGreen, FBlue, FAlpha, FBlendMode);
               end;
          end;
     end
     else
     begin
          for cy := StartY to EndY - 1 do
          begin
               for cx := StartX to EndX - 1 do
               begin
                    c := Cells[cx - StartX + StartX_, cy - StartY + StartY_];
                    if c >= 0 then
                         FEngine.FCanvas.DrawColor1(
                         FEngine.Images.Image[FImageName],
                         c,
                         cx * ChipWidth + OfsX ,
                         cy * ChipHeight + OfsY,
                         FScaleX, FScaleY, FDoCenter,
                         FMirrorX, FMirrorY,
                         FRed, FGreen, FBlue, FAlpha, FBlendmode);
               end;
          end;
     end;
end;

function TTileMapSprite.TestCollision(Sprite: TSprite): Boolean;
var
  b, b1, b2: TRect;
  cx, cy, ChipWidth, ChipHeight: Integer;
begin
     Result := True;
     if ImageName=' ' then Exit;
     if (FMapWidth <= 0) or (FMapHeight <= 0) then Exit;
     ChipWidth := Self.Width;
     ChipHeight := Self.Height;
     b1 := Rect(Trunc(Sprite.X), Trunc(Sprite.Y), Trunc(Sprite.X) + Width,Trunc(Sprite.Y) + Height);
     b2 := BoundsRect;

     IntersectRect(b, b1, b2);

     OffsetRect(b, -Trunc(Engine.WorldX), - Trunc(Engine.WorldY));
     OffsetRect(b1, -Trunc(Engine.WorldX), - Trunc(Engine.WorldY));

     for cy := (b.Top - ChipHeight + 1) div ChipHeight to b.Bottom div ChipHeight do
     begin
          for cx := (b.Left - ChipWidth+1) div ChipWidth to b.Right div ChipWidth do
          begin
              if CollisionMap[Mod2(cx, MapWidth), Mod2(cy, MapHeight)] then
              begin
                   if OverlapRect(Bounds(cx * ChipWidth, cy * ChipHeight, ChipWidth, ChipHeight), b1) then Exit;
              end;
          end;
     end;

     Result := False;
end;

function TTileMapSprite.GetCell(X, Y: Integer): Integer;
begin
     if (X >= 0) and (X < FMapWidth) and (Y >= 0) and (Y < FMapHeight) then
         Result := PInteger(Integer(FMap) + (Y * FMapWidth + X ) * SizeOf(Integer))^
     else
         Result := -1;
end;

type
  PBoolean = ^Boolean;

function TTileMapSprite.GetCollisionMapItem(X, Y: Integer): Boolean;
begin
     if (X >= 0) and (X < FMapWidth) and (Y >= 0) and (Y < FMapHeight) then
         Result := PBoolean(Integer(FCollisionMap) + (Y * FMapWidth+X) * SizeOf(Boolean))^
     else
         Result := False;
end;

function TTileMapSprite.GetBoundsRect: TRect;
begin
     if FDoTile then
          Result := Rect(0, 0,Engine.VisibleWidth, Engine.VisibleHeight)
     else
     begin
          if ImageName <> ' ' then
               Result := Bounds(Trunc(-Engine.WorldX - X), Trunc(-Engine.WorldY - Y),
               Width * FMapWidth, Height * FMapHeight)
          else
               Result := Rect(0, 0, 0, 0);
     end;
end;

procedure TTileMapSprite.SetCell(X, Y: Integer; Value: Integer);
begin
     if (X >= 0) and (X < FMapWidth) and (Y >= 0) and (Y < FMapHeight) then
         PInteger(Integer(FMap) + (Y * FMapWidth + X) * SizeOf(Integer))^ := Value;
end;

procedure TTileMapSprite.SetCollisionMapItem(X, Y: Integer; Value: Boolean);
begin
     if (X >= 0) and (X < FMapWidth) and (Y >= 0) and (Y < FMapHeight) then
         PBoolean(Integer(FCollisionMap) + (Y * FMapWidth + X) * SizeOf(Boolean))^ := Value;
end;

procedure TTileMapSprite.SetMapHeight(Value: Integer);
begin
     SetMapSize(FMapWidth, Value);
end;

procedure TTileMapSprite.SetMapWidth(Value: Integer);
begin
     SetMapSize(Value, FMapHeight);
end;

procedure TTileMapSprite.SetMapSize(AMapWidth, AMapHeight: Integer);
begin
     FMapW := Width * AMapWidth;
     FMapH := Height * AMapHeight;
     if (FMapWidth <> AMapWidth) or (FMapHeight <> AMapHeight) then
     begin
          if (AMapWidth <= 0) or (AMapHeight <= 0) then
          begin
               AMapWidth := 0;
               AMapHeight := 0;
          end;
          {else
          begin
              FWidth:=AMapWidth*Image.Width;
              FHeight:=AMapHeight*Image.Height;
          end;
          }
          FMapWidth := AMapWidth;
          FMapHeight := AMapHeight;

          ReAllocMem(FMap, FMapWidth * FMapHeight * SizeOf(Integer));
          FillChar(FMap^, FMapWidth * FMapHeight * SizeOf(Integer), 0);

          ReAllocMem(FCollisionMap, FMapWidth * FMapHeight * SizeOf(Boolean));
          FillChar(FCollisionMap^, FMapWidth * FMapHeight * SizeOf(Boolean), 1);
     end;
end;

{TGuiSprite}
function Rects(Left, Top, Right, Bottom: Single): TRect;
begin
     Result.Left := Trunc(Left);
     Result.Top  := Trunc(Top);
     Result.Right:= Trunc(Right);
     Result.Bottom := Trunc(Bottom);
end;

function PointInRects(const Point: TPoint; const Rect: TRect): Boolean;
begin
     Result:= (Trunc(Point.X) >= Trunc(Rect.Left))and(Trunc(Point.X) <= Trunc(Rect.Right))and
     (Trunc(Point.Y) >= Trunc(Rect.Top))and(Trunc(Point.Y) <= Trunc(Rect.Bottom));
end;

constructor TGUISprite.Create(const AParent: TSprite);
var
 I, J :integer;
begin
     inherited;
     FGuiType := gtNormal;
     FCanDrag := False;
     FCanFlip := False;
     FHighLight := False;
     FEnabled := True;
     FShowHint := False;
     FHintString :='';
     FOwner := nil;
     FPickUp := False;
     FCanPickUp:= False;
     FUseContainer := False;
     FZList := TList.Create;
     FIsMouseDown := False;
     FClicked := False;

     for I := 0 to 20 do
      for j := 0 to 50 do
         Container[i,j]:=Rect(0,0,0,0);
end;

destructor TGUISprite.Destroy;
begin
     FZList.Free;
     inherited Destroy;
end;

procedure TGUISprite.DoMove(const MoveCount: Single);
var
   I, J, K: Integer;
   Left, Top, Right, Bottom: Integer;
   SpriteX, SpriteY: Single;
begin
     inherited;

     FActiveRect := Rect(Round(X), Round(Y), Round(X + FWidth), Round(Y + FHeight));
     if  (CanPickUp) and (FPickUp) then
     begin
          Detach;
          X := MouseX - Width  div 2;
          Y := MouseY - Height div 2;
          if FShowHint then  FSHowHint := False;
          for I := 0 to 20 do
          begin
               for J := 0 to 50 do
               begin
                    for K:= 0 to Engine.Count - 1 do
                    begin
                         if  TGUISprite(FEngine.Items[K]).UseContainer and
                         TGUISprite(FEngine.Items[K]).Visible then
                         begin
                              SpriteX := TGUISprite(FEngine.Items[K]).X;
                              SpriteY := TGUISprite(FEngine.Items[K]).Y;
                              Left:= TGUISprite(FEngine.Items[K]).Container[I, J].Left;
                              Top := TGUISprite(FEngine.Items[K]).Container[I, J].Top;
                              Right  := TGUISprite(FEngine.Items[K]).Container[I, J].Right;
                              Bottom := TGUISprite(FEngine.Items[K]).Container[I, J].Bottom;
                              if PointInRects(Point(Trunc(X) + (Width div 2), Trunc(Y) + (Height div 2)),
                              Rects(Left + SpriteX, Top + SpriteY, Right + SpriteX, Bottom + SpriteY))then
                              begin
                               //    FEngine.FCanvas.FillRect(
                                 //  Rects(Left + SpriteX,
                                //   Top + SpriteY,
                                 //  Right + SpriteX,
                                //   Bottom + SpriteY),
                                  // cRGB4(0,255,0,80), opDiffuse);
                              end;
                         end;
                    end;
               end;
          end;
     end;

     if (FIsMouseDown) and (fCanpickup)  then
     begin
          for I := 0 to 20 do
          begin
               for J := 0 to 50 do
               begin
                    for K:= 0 to Engine.Count - 1 do
                    begin
                         if  (TGUISprite(FEngine.Items[K]).UseContainer) then

                         begin
                              SpriteX := TGUISprite(FEngine.Items[K]).X;
                              SpriteY := TGUISprite(FEngine.Items[K]).Y;
                              Left:= TGUISprite(FEngine.Items[K]).Container[I, J].Left;
                              Top := TGUISprite(FEngine.Items[K]).Container[I, J].Top;
                              Right  := TGUISprite(FEngine.Items[K]).Container[I, J].Right;
                              Bottom := TGUISprite(FEngine.Items[K]).Container[I, J].Bottom;
                              if PointInRects(Point(Trunc(X) + (Width div 2), Trunc(Y) + (Height div 2)),
                              Rects(Left + SpriteX, Top + SpriteY, Right + SpriteX, Bottom + SpriteY))then
                              begin
                                   if (FIsMouseDown)  then
                                   begin
                                        if FCanPickUp then
                                            FPickUp := not FPickUp;
                                        if (CanPickUp) and (FPickUp = False) then
                                        begin
                                             FShowHint := True;
                                        end;
                                        if TGUISprite(FEngine.Items[K]).FClicked then
                                            Owner:=TGUISprite(FEngine.Items[K]);
                                        Self.X := Left + SpriteX;
                                        Self.Y := Top  + SpriteY;
                                        FIsMouseDown := False;
                                   end;
                              end;
                         end;
                    end;
               end;
          end;
     end;
     if (FOwner <> nil)then
     begin
          Attach(FOwner);
          Self.Z := FOwner.Z + 1 ;
          Self.Visible := FOwner.Visible;
     end;
end;

function CompareInteger(Int1, Int2: Integer): Integer;
begin
     if Int1 > Int2 then
         Result := 1
     else
     if Int1 < Int2 then
         Result := -1
     else
         Result := 0;
end;

function Compare(Item1, Item2: Pointer): Integer;
var
    PI1, PI2: PInt;
begin
     PI1 := Item1;
     PI2 := Item2;
     Result := CompareInteger(PI1^, PI2^);
end;

procedure TGUISprite.OnLMouseDown;
var
   I: Integer;
   CurrentZ, ZArray: array of ^Integer;
   Last: ^Integer;
begin
     FIsMouseDown := True;
     FMouseOffsetX := Round(Self.X - MouseX);
     FMouseOffsetY := Round(Self.Y - MouseY);
     SetLength(ZArray, FEngine.Count);
     SetLength(CurrentZ, FEngine.Count);
     for I := 0 to FEngine.Count - 1 do
     begin
          New(CurrentZ[I]);
          if (TGUISprite(FEngine.Items[I]).MouseInRect) and
          TGUISprite(FEngine.Items[I]).FVisible then
              CurrentZ[I]^ := TGUISprite(FEngine.Items[I]).Z;
          FZList.Add(CurrentZ[I]);

     end;
     FZList.Sort(Compare);
     Last := FZList.Last;

     for I := 0 to FEngine.Count - 1 do
     begin
          New(ZArray[I]);
          ZArray[I] := FZList.Items[I];
     end;
     if FZlist.Count > 0 then
     begin
          for I := 0 to FEngine.Count - 1 do
          begin
               if (TGUISprite(FEngine.Items[I]).Z <> Last^)  then
               begin
                    TGUISprite(FEngine.Items[I]).FCanFlip := False;
               end;
               if TGUISprite(FEngine.Items[I]).Z = Last^ then
                  TGUISprite(FEngine.Items[I]).FClicked := True;
          end;
     end;

     if (FVisible) and (FCanFlip) then
     begin
          Inc(Engine.FZCounter, 2);
          Self.Z := FEngine.FZCounter;
     end;
     for I := 0 to FEngine.Count - 1 do
     begin
          TGUISprite(FEngine.Items[I]).FCanFlip := True;
          if (CanPickUp) and (FPickUp) then
          begin
               TGUISprite(FEngine.Items[i]).FClicked := False;
          end;
     end;

     FZList.Clear;
end;

procedure TGUISprite.OnLMouseUp;
begin
     FIsMouseDown := False;
end;

procedure TGUISprite.OnMouseMove;
begin
     if FHighLight then
       BlendMode := Blend_Bright;
end;

procedure TGUISprite.OnMouseEnter;
var
   StringW: Integer;
   MiddlePos: Integer;
begin
     if not Visible then Exit;

     if ShowHint then
     begin
          StringW   := Length(HintString) * 7;
          MiddlePos := StringW div 2 - 12;

         // FEngine.FPowerDraw.Device.FillRect(Rect(Round(X - MiddlePos), Round(Y - 20),
         // Round(X + StringW - MiddlePos), Round(Y - 5)),
         // cRGB1(180, 255, 250), OpDiffuse);

      //    FEngine.FPowerDraw.Fonts[0].TextOut(HintString, Round(X - MiddlePos) + 2, Round(Y - 20),
        //  cRGB1(0, 0, 0));
        //  FEngine.FPowerDraw.Device.FrameRect(Rect(Round(X - MiddlePos), Round(Y - 20),
         // Round(X + StringW - MiddlePos), Round(Y - 5)),
         // cRGB1(0, 0, 0), OpDiffuse);
     end;
end;

procedure TGUISprite.OnMouseLeave;
begin
     BlendMode := Blend_Default;
end;

procedure TGUISprite.OnMouseDrag;
begin
     if (FCanDrag) and (FVisible) then
     begin
          if (GuiType <> gtForm)  then
          begin
               FX := MouseX + FMouseOffsetX;
               FY := MouseY + FMouseOffsetY;
          end;
          if (GUIType=gtForm) and (Z = FEngine.FZCounter)  then
          begin
               FX := MouseX + FMouseOffsetX;
               FY := MouseY + FMouseOffsetY;
          end;
     end;
end;

{ TPathSprite }
destructor TPathSprite.Destroy;
begin
     FCtrlPts := nil;
     inherited;
end;

procedure TPathSprite.SetSegment(const Value: Integer);
begin
     FSegment := Value;
end;

function TPathSprite.GetSegment: Integer;
begin
    Result := FSegment;
end;

procedure TPathSprite.SetLooped(const Value: Boolean);
begin
     FLooped := Value;
end;

function TPathSprite.GetPoint(Index: Integer): TPoint;
begin
     if Index < 0 then
     begin
          Result := FCtrlPts[Length(FCtrlPts) + Index];
     end
     else
     if Index > High(FCtrlPts) then
     begin
          Result := FCtrlPts[Index - Length(FCtrlPts)];
     end
     else
     begin
          Result := FCtrlPts[Index];
     end;
end;

function TPathSprite.GetPosition: TPoint;
begin
     if FDistance > 1.0 then
     begin
          FDistance := FDistance - 1.0;
          Inc(FSegment);
          if Looped then
          begin
               if FSegment = High(FCtrlPts) + 1 then FSegment := 0;
          end;
     end;

     Result := CalculatePoint(GetPoint(FSegment - 1), GetPoint(FSegment),
                              GetPoint(FSegment + 1), GetPoint(FSegment + 2),
                              FDistance);
end;

procedure TPathSprite.SetDistance(const Value: Single);
begin
     FDistance := Value;
end;

procedure TPathSprite.AddPoint(X, Y: Integer);
var
  Point: TPoint;
begin
     Point.X := X;
     Point.Y := Y;
     AddPoint(Point);
end;

procedure TPathSprite.AddPoint(Point: TPoint);
begin
     SetLength(FCtrlPts, Length(FCtrlPts) + 1);
     FCtrlPts[High(FCtrlPts)] := Point;
end;

function TPathSprite.Calculate(P0, P1, P2, P3: Integer; T: Single): Integer;
begin
  Result := Trunc(( 2 * P1 +
                   (-P0 + P2) * T +
                   (2 * P0 - 5 * P1 + 4 * P2 - P3) * T * T +
                   (-P0 + 3 * P1 - 3 * P2 + P3) * T * T * T) / 2);
end;

function TPathSprite.CalculatePoint(CP0, CP1, CP2, CP3: TPoint; T: Single): TPoint;
begin
     Result.X := Calculate(CP0.X, CP1.X, CP2.X, CP3.X, T);
     Result.Y := Calculate(CP0.Y, CP1.Y, CP2.Y, CP3.Y, T);
end;

procedure TPathSprite.DoMove(const MoveCount: Single);
begin
     inherited;
     FDistance := FDistance + FMoveSpeed * MoveCount;
     X := Position.X;
     Y := Position.Y;
end;

constructor TPathSprite.Create;
begin
  inherited;
  FSegment :=0;
  FDistance := 0;
  FLooped := False;
  FMoveSpeed := 0.01;
end;

{ TNPathSprite }
constructor TNPathSprite.Create(const AParent: TSprite);
begin
  inherited;
  FDistance := 0;
  FMoveSpeed := 0;
  FUpdateSpeed := 0.01;
  FMaxParameter := 100;
  // CurveName := '';
end;

destructor TNPathSprite.Destroy;
begin
  inherited;
//  FPath.Destroy;  
end;

procedure TNPathSprite.DoMove(const MoveCount: Single);
var
  Point: TPoint2;
begin
  inherited;
  FDistance := FDistance + FMoveSpeed * FUpdateSpeed;
  FMoveSpeed := FMoveSpeed + FAccel * FUpdateSpeed;
  if FDistance > FMaxParameter then FDistance := FMaxParameter;
  if FDistance < 0 then FDistance := 0;
  Point := GetPosition;
  X := Point.X;
  Y := Point.Y;
end;

function TNPathSprite.GetPosition: TPoint2;
begin
  Result := FPath.GetXY(Distance/FMaxParameter);
end;

procedure TNPathSprite.LookAt(anAngle: Single);
begin
  Angle := Path.GetTangent(Distance/FMaxParameter) + anAngle;
end;

procedure TNPathSprite.SetDistance(const Value: Single);
begin
  FDistance := Value;
end;



{    TSpriteEngine    }
constructor TSpriteEngine.Create(const AParent: TSprite);
begin
     inherited Create(AParent);
     //Application.OnMessage := MouseMessage;
     FDeadList := TList.Create;
     FCurrentSelected := TList.Create;
     GroupCount := 10;
     FVisibleWidth := 800;
     FVisibleHeight := 600;
     FDoMouseEvent := False;
     FZCounter:=3;
     FHGE := HGECreate(HGE_VERSION);
end;

destructor TSpriteEngine.Destroy;
begin
     ClearCurrent;
     GroupCount := 0;
     FDeadList.Free;
     inherited Destroy;
     FCurrentSelected.Free;
end;

procedure TSpriteEngine.GroupSelect(const Area: TRect; Add: Boolean = False);
begin
     GroupSelect(Area, [TSprite], Add);
end;

procedure TSpriteEngine.GroupSelect(const Area: TRect; Filter: array of TSpriteClass; Add: Boolean = False);
var
    Index, Index2: Integer;
    Sprite: TSprite;
begin
     Assert(Length(Filter) <> 0, 'Filter = []');
     if not Add then
         ClearCurrent;
     if Length(Filter) = 1 then
     begin
          for Index := 0 to Count - 1 do
          begin
               Sprite := TSpriteEx(Items[Index]);
               if (Sprite is Filter[0]) and  OverlapRect(TSpriteEx(Sprite).GetBoundsRect, Area) then
                   TSpriteEx(Sprite).Selected := True;
          end
     end
     else
     begin
          for Index := 0 to Count - 1 do
          begin
               Sprite := Items[Index];
               for Index2 := 0 to High(Filter) do
               begin
                    if (Sprite is Filter[Index2]) and  OverlapRect(TSpriteEx(Sprite).GetBoundsRect,Area) then
                    begin
                         TSpriteEx(Sprite).Selected := True;
                         Break;
                    end;
               end;
          end
     end;
     FObjectsSelected := CurrentSelected.Count <> 0;
end;

function TSpriteEngine.Select(Point: TPoint; Filter: array of TSpriteClass; Add:Boolean = False): TSprite;
var
  Index,Index2: Integer;
begin
     Assert(Length(Filter) <> 0, 'Filter = []');
     if not Add then
         ClearCurrent;
     // By searching the Drawlist in reverse
     // we select the highest sprite if the sprit is under the point
     Assert(FDrawList <> nil, 'FDrawList = nil');
     if Length(Filter) = 1 then
     begin
          for Index := FDrawList.Count-1 downto 0 do
          begin
               Result := FDrawList[Index];
               if (Result is Filter[0]) and  PointInRect(Point, TSpriteEx(Result).GetBoundsRect) then
               begin
                    TSpriteEx(Result).Selected := True;
                    FObjectsSelected := CurrentSelected.Count <> 0;
                    Exit;
               end;
          end
     end
     else
     begin
          for Index := FDrawList.Count - 1 downto 0 do
          begin
               Result := FDrawList[Index];
               for Index2 := 0 to High(Filter) do
               begin
                    if (Result is Filter[Index2]) and  PointInRect(Point, TSpriteEx(Result).GetBoundsRect) then
                    begin
                         TSpriteEx(Result).Selected := True;
                         FObjectsSelected := CurrentSelected.Count <> 0;
                         Exit;
                    end;
               end;
          end
     end;
     Result := nil;
end;

function TSpriteEngine.Select(Point: TPoint; Add: Boolean = False): TSprite;
begin
     Result := Select(Point, [TSprite], Add);
end;

procedure TSpriteEngine.ClearCurrent;
begin
     while CurrentSelected.Count <> 0 do
        TSpriteEx(CurrentSelected[CurrentSelected.Count - 1]).Selected := False;
     FObjectsSelected := False;
end;

procedure TSpriteEngine.ClearGroup(GroupNumber: Integer);
var
  Index: Integer;
  Group: TList;
begin
     Group := Groups[GroupNumber];
     if Group <> nil then
     for Index := 0 to Group.Count - 1 do
       TSpriteEx(Group[Index]).Selected := False;
end; {ClearGroup}

procedure TSpriteEngine.CurrentToGroup(GroupNumber: Integer; Add: Boolean = False);
var
  Group: TList;
  Index: Integer;
begin
     Group := Groups[GroupNumber];
     if Group = nil then
        Exit;
     if not Add then
        ClearGroup(GroupNumber);
     for Index := 0 to Group.Count - 1 do
        TSpriteEx(Group[Index]).GroupNumber := GroupNumber;
end;

procedure TSpriteEngine.GroupToCurrent(GroupNumber: Integer; Add: Boolean = False);
var
  Group: TList;
  Index: Integer;
begin
     if not Add then
        ClearCurrent;
     Group := Groups[GroupNumber];
     if Group <> nil then
        for Index := 0 to Group.Count - 1 do
           TSpriteEx(Group[Index]).Selected := True;
end;

function TSpriteEngine.GetGroup(Index : Integer) : TList;
begin
     if (Index >= 0) or (Index < FGroupCount ) then
        Result := FGroups[Index]
     else
        Result := nil;
end;

procedure TSpriteEngine.SetGroupCount(AGroupCount: Integer);
var
   Index: Integer;
begin
     if (AGroupCount <> FGroupCount) and (AGroupCount >= 0) then
     begin
          if FGroupCount > AGroupCount then
          begin // remove groups
               for Index := AGroupCount to FGroupCount - 1 do
               begin
                    ClearGroup(Index);
                    FGroups[Index].Free;
               end;
               SetLength(FGroups, AGroupCount);
          end
          else
          begin // add groups
               SetLength(FGroups, AGroupCount);
               for Index := FGroupCount to AGroupCount - 1 do
                   FGroups[Index] := TList.Create;
          end;
          FGroupCount := Length(FGroups);
     end;
end;

procedure TSpriteEngine.Dead;
begin
     while FDeadList.Count > 0 do
         TSprite(FDeadList[FDeadList.Count - 1]).Free;
end;

procedure TSpriteEngine.Draw;
begin
     FDrawCount := 0;
     inherited Draw;
end;


initialization
  FHGE := nil;

end.
