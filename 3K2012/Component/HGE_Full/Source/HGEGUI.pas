unit HGEGUI;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Delphi conversion by Erik van Bilsen
**
** NOTE: The Delphi version uses public GUI interfaces instead of
** classes (more conform the main IHGE interface).
*)

interface

uses
  HGE, HGESprite, HGERect;

(****************************************************************************
 * HGEGUI.h
 ****************************************************************************)

const
  HGEGUI_NONAVKEYS = 0;
  HGEGUI_LEFTRIGHT = 1;
  HGEGUI_UPDOWN    = 2;
  HGEGUI_CYCLED     = 4;

type
  IHGEGUI = interface;

  IHGEGUIObject = interface
  ['{892FB23E-F99E-4691-8D7C-2BBD4B4F1D40}']
    function GetId: Integer;
    function GetStatic: Boolean;
    procedure SetStatic(const Value: Boolean);
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
    function GetEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
    function GetRect: THGERect;
    procedure SetRect(const Value: THGERect);
    function GetPRect: PHGERect;
    function GetColor: Longword;
    procedure SetColor(const Value: Longword);
    function GetNext: IHGEGUIObject;
    procedure SetNext(const Value: IHGEGUIObject);
    function GetPrev: IHGEGUIObject;
    procedure SetPrev(const Value: IHGEGUIObject);
    function GetGUI: IHGEGUI;
    procedure SetGUI(const Value: IHGEGUI);

    procedure Render;
    procedure Update(const DT: Single);

    procedure Enter;
    procedure Leave;
    procedure Reset;
    function IsDone: Boolean;
    procedure Focus(const Focused: Boolean);
    procedure MouseOver(const Over: Boolean);

    function MouseMove(const X, Y: Single): Boolean;
    function MouseLButton(const Down: Boolean): Boolean;
    function MouseRButton(const Down: Boolean): Boolean;
    function MouseWheel(const Notches: Integer): Boolean;
    function KeyClick(const Key, Chr: Integer): Boolean;

    property Id: Integer read GetId;
    property IsStatic: Boolean read GetStatic write SetStatic;
    property Visible: Boolean read GetVisible write SetVisible;
    property Enabled: Boolean read GetEnabled write SetEnabled;
    property Rect: THGERect read GetRect write SetRect;
    property PRect: PHGERect read GetPRect;
    property Color: Longword read GetColor write SetColor;
    property GUI: IHGEGUI read GetGUI write SetGUI;
    property Next: IHGEGUIObject read GetNext write SetNext;
    property Prev: IHGEGUIObject read GetPrev write SetPrev;
  end;

  IHGEGUI = interface
  ['{3C926B13-D5F0-4541-9B57-EB52361075CE}']
    procedure AddCtrl(const Ctrl: IHGEGUIObject);
    procedure DelCtrl(const Id: Integer);
    function GetCtrl(const Id: Integer): IHGEGUIObject;

    procedure MoveCtrl(const Id: Integer; const X, Y: Single);
    procedure ShowCtrl(const Id: Integer; const Visible: Boolean);
    procedure EnableCtrl(const Id: Integer; const Enabled: Boolean);

    procedure SetNavMode(const Mode: Integer);
    procedure SetCursor(const Spr: IHGESprite);
    procedure SetColor(const Color: Longword);
    procedure SetFocus(const Id: Integer);
    function GetFocus: Integer;

    procedure Enter;
    procedure Leave;
    procedure Reset;
    procedure Move(const DX, DY: Single);

    function Update(const DT: Single): Integer;
    procedure Render;
  end;

type
  THGEGUIObject = class(TInterfacedObject,IHGEGUIObject)
  protected
    { IHGEGUIObject }
    function GetId: Integer;
    function GetStatic: Boolean;
    procedure SetStatic(const Value: Boolean);
    function GetVisible: Boolean;
    procedure SetVisible(const Value: Boolean);
    function GetEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
    function GetRect: THGERect;
    procedure SetRect(const Value: THGERect);
    function GetPRect: PHGERect;
    function GetColor: Longword;
    procedure SetColor(const Value: Longword);
    function GetNext: IHGEGUIObject;
    procedure SetNext(const Value: IHGEGUIObject);
    function GetPrev: IHGEGUIObject;
    procedure SetPrev(const Value: IHGEGUIObject);
    function GetGUI: IHGEGUI;
    procedure SetGUI(const Value: IHGEGUI);

    procedure Render; virtual; abstract;
    procedure Update(const DT: Single); virtual;

    procedure Enter; virtual;
    procedure Leave; virtual;
    procedure Reset; virtual;
    function IsDone: Boolean; virtual;
    procedure Focus(const Focused: Boolean); virtual;
    procedure MouseOver(const Over: Boolean); virtual;

    function MouseMove(const X, Y: Single): Boolean; virtual;
    function MouseLButton(const Down: Boolean): Boolean; virtual;
    function MouseRButton(const Down: Boolean): Boolean; virtual;
    function MouseWheel(const Notches: Integer): Boolean; virtual;
    function KeyClick(const Key, Chr: Integer): Boolean; virtual;
  private
    class var
      FHGE: IHGE;
  private
    FId: Integer;
    FStatic: Boolean;
    FVisible: Boolean;
    FEnabled: Boolean;
    FRect: THGERect;
    FColor: Longword;
    FGUI: Pointer; // Must typecast to IHGEGUI (see GUI property). Is pointer to avoid circular reference
    FNext, FPrev: IHGEGUIObject; // Must typecast to IHGEGUIObject (see Next/Prev properties)
  protected
    property Id: Integer read FId write FId;
    property IsStatic: Boolean read FStatic write FStatic;
    property Visible: Boolean read FVisible write FVisible;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Rect: THGERect read FRect write FRect;
    property PRect: PHGERect read GetPRect;
    property Color: Longword read GetColor write SetColor;
    property GUI: IHGEGUI read GetGUI write SetGUI;
    property Next: IHGEGUIObject read GetNext write SetNext;
    property Prev: IHGEGUIObject read GetPrev write SetPrev;
  public
    constructor Create;
    destructor Destroy; override;
  end;

type
  THGEGUI = class(TInterfacedObject,IHGEGUI)
  protected
    { IHGEGUI }
    procedure AddCtrl(const Ctrl: IHGEGUIObject);
    procedure DelCtrl(const Id: Integer);
    function GetCtrl(const Id: Integer): IHGEGUIObject;

    procedure MoveCtrl(const Id: Integer; const X, Y: Single);
    procedure ShowCtrl(const Id: Integer; const Visible: Boolean);
    procedure EnableCtrl(const Id: Integer; const Enabled: Boolean);

    procedure SetNavMode(const Mode: Integer);
    procedure SetCursor(const Spr: IHGESprite);
    procedure SetColor(const Color: Longword);
    procedure SetFocus(const Id: Integer);
    function GetFocus: Integer;

    procedure Enter;
    procedure Leave;
    procedure Reset;
    procedure Move(const DX, DY: Single);

    function Update(const DT: Single): Integer;
    procedure Render;
  private
    class var
      FHGE: IHGE;
  private
    FCtrls: IHGEGUIObject;
    FCtrlLock: IHGEGUIObject;
    FCtrlFocus: IHGEGUIObject;
    FCtrlOver: IHGEGUIObject;
    FNavMode: Integer;
    FEnterLeave: Integer;
    FCursor: IHGESprite;
    FMX, FMY: Single;
    FWheel: Integer;
    FLPressed, FLLastPressed: Boolean;
    FRPressed, FRLastPressed: Boolean;
  private
    function ProcessCtrl(const Ctrl: IHGEGUIObject): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Windows;

(****************************************************************************
 * HGEGUI.h, HGEGUI.cpp
 ****************************************************************************)

{ THGEGUIObject }

constructor THGEGUIObject.Create;
begin
  inherited Create;
  FHGE := HGECreate(HGE_VERSION);
  FColor := $FFFFFFFF;
end;

destructor THGEGUIObject.Destroy;
begin
  inherited;
end;

procedure THGEGUIObject.Enter;
begin
  { No default implementation }
end;

procedure THGEGUIObject.Focus(const Focused: Boolean);
begin
  { No default implementation }
end;

function THGEGUIObject.GetColor: Longword;
begin
  Result := FColor;
end;

function THGEGUIObject.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function THGEGUIObject.GetGUI: IHGEGUI;
begin
  Result := IHGEGUI(FGUI);
end;

function THGEGUIObject.GetId: Integer;
begin
  Result := FId;
end;

function THGEGUIObject.GetNext: IHGEGUIObject;
begin
  Result := FNext;
end;

function THGEGUIObject.GetPRect: PHGERect;
begin
  Result := @FRect;
end;

function THGEGUIObject.GetPrev: IHGEGUIObject;
begin
  Result := FPrev;
end;

function THGEGUIObject.GetRect: THGERect;
begin
  Result := FRect;
end;

function THGEGUIObject.GetStatic: Boolean;
begin
  Result := FStatic;
end;

function THGEGUIObject.GetVisible: Boolean;
begin
  Result := FVisible;
end;

function THGEGUIObject.IsDone: Boolean;
begin
  Result := True;
end;

function THGEGUIObject.KeyClick(const Key, Chr: Integer): Boolean;
begin
  Result := False;
end;

procedure THGEGUIObject.Leave;
begin
  { No default implementation }
end;

function THGEGUIObject.MouseLButton(const Down: Boolean): Boolean;
begin
  Result := False;
end;

function THGEGUIObject.MouseMove(const X, Y: Single): Boolean;
begin
  Result := False;
end;

procedure THGEGUIObject.MouseOver(const Over: Boolean);
begin
  { No default implementation }
end;

function THGEGUIObject.MouseRButton(const Down: Boolean): Boolean;
begin
  Result := False;
end;

function THGEGUIObject.MouseWheel(const Notches: Integer): Boolean;
begin
  Result := False;
end;

procedure THGEGUIObject.Reset;
begin
  { No default implementation }
end;

procedure THGEGUIObject.SetColor(const Value: Longword);
begin
  FColor := Value;
end;

procedure THGEGUIObject.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure THGEGUIObject.SetGUI(const Value: IHGEGUI);
begin
  FGUI := Pointer(Value);
end;

procedure THGEGUIObject.SetNext(const Value: IHGEGUIObject);
begin
  FNext := Value;
end;

procedure THGEGUIObject.SetPrev(const Value: IHGEGUIObject);
begin
  FPrev := Value;
end;

procedure THGEGUIObject.SetRect(const Value: THGERect);
begin
  FRect := Value;
end;

procedure THGEGUIObject.SetStatic(const Value: Boolean);
begin
  FStatic := Value;
end;

procedure THGEGUIObject.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

procedure THGEGUIObject.Update(const DT: Single);
begin
  { No default implementation }
end;

{ THGEGUI }

procedure THGEGUI.AddCtrl(const Ctrl: IHGEGUIObject);
var
  Last: IHGEGUIObject;
begin
  Last := FCtrls;
  Ctrl.GUI := Self;
  if (FCtrls = nil) then begin
    FCtrls := Ctrl;
    Ctrl.Prev := nil;
    Ctrl.Next := nil;
  end else begin
    while Assigned(Last.Next) do
      Last := Last.Next;
    Last.Next := Ctrl;
    Ctrl.Prev := Last;
    Ctrl.Next := nil;
  end;
end;

constructor THGEGUI.Create;
begin
  inherited Create;
  FHGE := HGECreate(HGE_VERSION);
  FNavMode := HGEGUI_NONAVKEYS;
end;

procedure THGEGUI.DelCtrl(const Id: Integer);
var
  Ctrl: IHGEGUIObject;
begin
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    if (Ctrl.Id = Id) then begin
      if Assigned(Ctrl.Prev) then
        Ctrl.Prev.Next := Ctrl.Next
      else
        FCtrls := Ctrl.Next;
      if Assigned(Ctrl.Next) then
        Ctrl.Next.Prev := Ctrl.Prev;
      Ctrl.Next := nil;
      Ctrl.Prev := nil;
      Exit;
    end;
    Ctrl := Ctrl.Next;
  end;
end;

destructor THGEGUI.Destroy;
var
  Ctrl, NextCtrl: IHGEGUIObject;
begin
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    NextCtrl := Ctrl.Next;
    Ctrl.Prev := nil;
    Ctrl.Next := nil;
    Ctrl := NextCtrl;
  end;
  FCtrls := nil;
  inherited;
end;

procedure THGEGUI.EnableCtrl(const Id: Integer; const Enabled: Boolean);
var
  Ctrl: IHGEGUIObject;
begin
  Ctrl := GetCtrl(Id);
  if Assigned(Ctrl) then
    Ctrl.Enabled := Enabled;
end;

procedure THGEGUI.Enter;
var
  Ctrl: IHGEGUIObject;
begin
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    Ctrl.Enter;
    Ctrl := Ctrl.Next;
  end;
  FEnterLeave := 2;
end;

function THGEGUI.GetCtrl(const Id: Integer): IHGEGUIObject;
begin
  Result := FCtrls;
  while Assigned(Result) do begin
    if (Result.Id = Id) then
      Exit;
    Result := Result.Next;
  end;
end;

function THGEGUI.GetFocus: Integer;
begin
  if Assigned(FCtrlFocus) then
    Result := FCtrlFocus.Id
  else
    Result := 0;
end;

procedure THGEGUI.Leave;
var
  Ctrl: IHGEGUIObject;
begin
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    Ctrl.Enter;
    Ctrl := Ctrl.Next;
  end;
  FCtrlFocus := nil;
  FCtrlOver := nil;
  FCtrlLock := nil;
  FEnterLeave := 1;
end;

procedure THGEGUI.Move(const DX, DY: Single);
var
  Ctrl: IHGEGUIObject;
  R: PHGERect;
begin
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    R := Ctrl.PRect;
    R.X1 := R.X1 + DX;
    R.Y1 := R.Y1 + DY;
    R.X2 := R.X2 + DX;
    R.Y2 := R.Y2 + DY;
    Ctrl := Ctrl.Next;
  end;
end;

procedure THGEGUI.MoveCtrl(const Id: Integer; const X, Y: Single);
var
  Ctrl: IHGEGUIObject;
  R: PHGERect;
begin
  Ctrl := GetCtrl(Id);
  if Assigned(Ctrl) then begin
    R := Ctrl.PRect;
    R.X2 := X + (R.X2 - R.X1);
    R.Y2 := Y + (R.Y2 - R.Y1);
    R.X1 := X;
    R.Y1 := Y;
  end;
end;

function THGEGUI.ProcessCtrl(const Ctrl: IHGEGUIObject): Boolean;
begin
  Result := False;
  if (not FLLastPressed) and (FLPressed) then begin
    FCtrlLock := Ctrl;
    SetFocus(Ctrl.Id);
    Result := Ctrl.MouseLButton(True) or Result;
  end;

  if (not FRLastPressed) and (FRPressed) then begin
    FCtrlLock := Ctrl;
    SetFocus(Ctrl.Id);
    Result := Ctrl.MouseRButton(True) or Result;
  end;

  if (FLLastPressed) and (not FLPressed) then
    Result := Ctrl.MouseLButton(False) or Result;

  if (FRLastPressed) and (not FRPressed) then
    Result := Ctrl.MouseRButton(False);

  if (FWheel <> 0) then
    Result := Ctrl.MouseWheel(FWheel) or Result;

  Result := Ctrl.MouseMove(FMX - Ctrl.PRect.X1,FMY - Ctrl.PRect.Y1) or Result;
end;

procedure THGEGUI.Render;
var
  Ctrl: IHGEGUIObject;
begin
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    if (Ctrl.Visible) then
      Ctrl.Render;
    Ctrl := Ctrl.Next;
  end;
  if (FHGE.Input_IsMouseOver) and Assigned(FCursor) then
    FCursor.Render(FMX,FMY);
end;

procedure THGEGUI.Reset;
var
  Ctrl: IHGEGUIObject;
begin
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    Ctrl.Reset;
    Ctrl := Ctrl.Next;
  end;
end;

procedure THGEGUI.SetColor(const Color: Longword);
var
  Ctrl: IHGEGUIObject;
begin
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    Ctrl.Color := Color;
    Ctrl := Ctrl.Next;
  end;
end;

procedure THGEGUI.SetCursor(const Spr: IHGESprite);
begin
  FCursor := Spr;
end;

procedure THGEGUI.SetFocus(const Id: Integer);
var
  CtrlNewFocus: IHGEGUIObject;
begin
  CtrlNewFocus := GetCtrl(id);
  if (CtrlNewFocus = FCtrlFocus) then
    Exit;
  if (CtrlNewFocus = nil) then begin
    if Assigned(FCtrlFocus) then
      FCtrlFocus.Focus(False);
    FCtrlFocus := nil;
  end else if (not CtrlNewFocus.IsStatic) and (CtrlNewFocus.Visible)
    and (CtrlNewFocus.Enabled)
  then begin
    if Assigned(FCtrlFocus) then
      FCtrlFocus.Focus(False);
    CtrlNewFocus.Focus(True);
    FCtrlFocus := CtrlNewFocus;
  end;
end;

procedure THGEGUI.SetNavMode(const Mode: Integer);
begin
  FNavMode := Mode;
end;

procedure THGEGUI.ShowCtrl(const Id: Integer; const Visible: Boolean);
var
  Ctrl: IHGEGUIObject;
begin
  Ctrl := GetCtrl(Id);
  if Assigned(Ctrl) then
    Ctrl.Visible := Visible;
end;

function THGEGUI.Update(const DT: Single): Integer;
var
  Done: Boolean;
  Key: Integer;
  Ctrl: IHGEGUIObject;
begin
  Result := 0;

// Update the mouse variables
  FHGE.Input_GetMousePos(FMX,FMY);
  FLLastPressed := FLPressed;
  FLPressed := FHGE.Input_GetKeyState(VK_LBUTTON);
  FRLastPressed := FRPressed;
  FRPressed := FHGE.Input_GetKeyState(VK_RBUTTON);
  FWheel := FHGE.Input_GetMouseWheel;


// Update all controls
  Ctrl := FCtrls;
  while Assigned(Ctrl) do begin
    Ctrl.Update(DT);
    Ctrl := Ctrl.Next;
  end;

// Handle Enter/Leave
  if (FEnterLeave <> 0) then begin
    Ctrl := FCtrls;
    Done := True;
    while Assigned(Ctrl) do begin
      if (not Ctrl.IsDone) then begin
        Done := False;
        Break;
      end;
      Ctrl := Ctrl.Next;
    end;
    if (not Done) then
      Exit
    else begin
      if (FEnterLeave = 1) then begin
        Result := -1;
        Exit;
      end else
        FEnterLeave := 0;
    end;
  end;

// Handle keys
  Key := FHGE.Input_GetKey;
  if ((((FNavMode and HGEGUI_LEFTRIGHT) <> 0) and (Key = HGEK_LEFT))
    or (((FNavMode and HGEGUI_UPDOWN) <> 0) and (Key = HGEK_UP)))
  then begin
    Ctrl := FCtrlFocus;
    if (Ctrl = nil) then begin
      Ctrl := FCtrls;
      if (Ctrl = nil) then
        Exit;
    end;

    repeat
      Ctrl := Ctrl.Prev;
      if (Ctrl = nil) and (((FNavMode and HGEGUI_CYCLED) <> 0) or (FCtrlFocus = nil)) then begin
        Ctrl := FCtrls;
        while Assigned(Ctrl.Next) do
          Ctrl := Ctrl.Next;
      end;
      if (Ctrl = nil) or (Ctrl = FCtrlFocus) then
        Break;
    until (not Ctrl.IsStatic) and (Ctrl.Visible) and (Ctrl.Enabled);

    if Assigned(Ctrl) and (Ctrl <> FCtrlFocus) then begin
      if Assigned(FCtrlFocus) then
        FCtrlFocus.Focus(False);
      Ctrl.Focus(True);
      FCtrlFocus := Ctrl;
    end;
  end else if ((((FNavMode and HGEGUI_LEFTRIGHT) <> 0) and (Key = HGEK_RIGHT))
    or (((FNavMode and HGEGUI_UPDOWN) <> 0) and (Key = HGEK_DOWN)))
  then begin
    Ctrl := FCtrlFocus;
    if (Ctrl = nil) then begin
      Ctrl := FCtrls;
      if (Ctrl = nil) then
        Exit;
      while Assigned(Ctrl.Next) do
        Ctrl := Ctrl.Next;
    end;

    repeat
      Ctrl := Ctrl.Next;
      if (Ctrl = nil) and (((FNavMode and HGEGUI_CYCLED) <> 0) or (FCtrlFocus = nil)) then
        Ctrl := FCtrls;
      if (Ctrl = nil) or (Ctrl = FCtrlFocus) then
        Break;
    until (not Ctrl.IsStatic) and (Ctrl.Visible) and (Ctrl.Enabled);

    if Assigned(Ctrl) and (Ctrl <> FCtrlFocus) then begin
      if Assigned(FCtrlFocus) then
        FCtrlFocus.Focus(False);
      Ctrl.Focus(True);
      FCtrlFocus := Ctrl;
    end;
  end else if Assigned(FCtrlFocus) and (Key <> 0) and (Key <> HGEK_LBUTTON)
    and (Key <> HGEK_RBUTTON)
  then begin
    if (FCtrlFocus.KeyClick(Key,FHGE.Input_GetChar)) then begin
      Result := FCtrlFocus.Id;
      Exit;
    end;
  end;

// Handle mouse
  if Assigned(FCtrlLock) then begin
    Ctrl := FCtrlLock;
    if (not FLPressed) and (not FRPressed) then
      FCtrlLock := nil;
    if (ProcessCtrl(Ctrl)) then begin
      Result := Ctrl.Id;
      Exit;
    end;
  end else begin
    // Find last (topmost) control
    Ctrl := FCtrls;
    if Assigned(Ctrl) then
      while Assigned(Ctrl.Next) do
        Ctrl := Ctrl.Next;

    while Assigned(Ctrl) do begin
      if (Ctrl.Enabled) and (Ctrl.PRect.TextPoint(FMX,FMY)) then begin
        if (FCtrlOver <> Ctrl) then begin
          if Assigned(FCtrlOver) then
            FCtrlOver.MouseOver(False);
          Ctrl.MouseOver(True);
          FCtrlOver := Ctrl;
        end;

        if (ProcessCtrl(Ctrl)) then
          Result := Ctrl.Id;
        Exit;
      end;
      Ctrl := Ctrl.Prev;
    end;

    if Assigned(FCtrlOver) then begin
      FCtrlOver.MouseOver(False);
      FCtrlOver := nil;
    end;
  end;
end;

initialization
  THGEGUIObject.FHGE := nil;
  THGEGUI.FHGE := nil;

end.
