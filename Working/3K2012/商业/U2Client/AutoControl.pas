unit AutoControl;

// -----------------------------------------------------------------------------
// Component Name:  TAutoControl
// Module:          SizerControl
// Description:     Enables runtime moving and resizing of controls.
// Version:         3.93
// Date:            6-APRIL-2005
// Compiler:        Delphi 3 - Delphi 7
// Author:          Angus Johnson,   angusj-AT-myrealbox-DOT-com
// Copyright        ?1997-2005 Angus Johnson
// -----------------------------------------------------------------------------

//6 April 2005
//  * bugfix: Bug in Notification() method caused an access violation when
//    the form was destroyed.
//18 November 2004
//  * bugfix: Notification() method added to properly manage Target property.
//2 October 2004
//  * bugfix (with thanks to Daniel Newton): Scrolling forms left a dirty grid.
//29 May 2003
//  * bugfix: When clicking the form, the target was selected from back to front
//9 Mar 2003
//  * bugfix: Keyboard events are now passed to fOwnerForm when
//    fOwnerForm.KeyPreview = true
//21 Mar 2002
//  * bugfix: Divide-by-zero in MouseUp() method (spotted by Wayne Brantley)
//20 Mar 2002
//  * Clicking a new control will now immediately start a move/resize operation.
//  * SnapToGrid property added.
//14 Dec 2001
//  * ControlActions property added - allows user to specify
//    Move, Copy or both TAutoControl actions
//21 Nov 2001
//  * bugfix: *Much* improved handling of Aligned targeted controls
//  * New properties added: Target_Align, Target_Left, Target_Top
//    Target_Width & Target_Height.
//  * Demo updated to incorporate new features.
//  * Numerous bug fixes related to installing on the IDE component palette.
//16 Nov 2001
//  * bugfix: Aligned controls can now be resized (but not moved obviously)
//  * bugfix: Resizing/moving with arrow keys reported incorrect ControlRect
//    coordinates in OnMoving & OnResizing events.
//  * OnMoved and OnResized events added.
//8 Nov 2001
//  * Cursor keys are now disabled while moving/resizing controls with the mouse
//  * bugfix: Clicking a control when target = nil often resulted in the
//    wrong control being selected.
//2 Nov 2001
//  * Conditional defines added to stop compiler warings in Delphi6
//  * Minor bug fixes
//1 Nov 2001
//  * Hooks the form's WindowProc to handle target selection.
//  * Creates a design grid on the form (when GridSize > 0)
//  * Can now click a child of a targeted control
//  * New Enable property added
//29 Sept 2001
//  * Tabbing will now access nested controls.
//  * Added OnTargetChanging event.
//  * Added Color property

interface

{$R AUTOCONTROL}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms;

const
  CM_NEWTARGET = WM_USER + $400;

type
  TControlActions = (caSizeMove,caSizeOnly,caMoveOnly);
  TMouseButtons = set of TMouseButton;
  TMouseOp = (moNone, moResizing, moMoving);
  TSizingBorder = (sbNone, sbLeft, sbTopLeft, sbTop, sbTopRight,
    sbRight, sbBottomRight, sbBottom, sbBottomLeft);
  TAutoControlEvent = procedure (Sender: TObject; ControlRect: TRect) of object;
  TNewTargetEvent = procedure (Sender: TObject; NewTarget: TControl) of object;
  TTargetChangingEvent = procedure (Sender: TObject;
    NewTarget: TControl; var IsValidTarget: boolean) of object;

  TAutoControl = class(TCustomControl)
  private
    fTarget: TControl;
    fControlActions: TControlActions;
    fOwnerForm: TCustomForm;
    fMyParent: TWinControl;
    fPostedTarget: TControl;
    fSizingBorder: TSizingBorder;
    fMouseOp: TMouseOp;
    fButtons: TMouseButtons;
    fGridSize: integer;
    fSnapToGrid: boolean;
    fOffset: TPoint;
    fAllowTab: boolean;
    fMinWidth: integer;
    fMinHeight: integer;
    fSizingRect: TRect;
    fInternalChanging: boolean; //avoids calling DoTargetChanging twice
    fOnMoving: TAutoControlEvent;
    fOnResizing: TAutoControlEvent;
    fOnMoved: TAutoControlEvent;
    fOnResized: TAutoControlEvent;
    fOnTargetChanged: TNewTargetEvent;
    fOnTargetChanging: TTargetChangingEvent;

    fOldFormWindowProc: TWndMethod;
    procedure NewFormWindowProc(var Msg : TMessage);
    procedure HookFormWindowProc;
    procedure UnHookFormWindowProc;

    procedure SetTarget(target: TControl);
    procedure DrawRect;
    function GetColor: TColor;
    procedure SetColor(Color: TColor);
    procedure SetGridSize(GridSize: integer);
    procedure UpdateTargetCoords(MouseOp: TMouseOp);
    function GetTargetAlign: TAlign;
    procedure SetTargetAlign(NewAlign: TAlign);
    function GetTargetLeft: integer;
    procedure SetTargetLeft(NewLeft: integer);
    function GetTargetTop: integer;
    procedure SetTargetTop(NewTop: integer);
    function GetTargetWidth: integer;
    procedure SetTargetWidth(NewWidth: integer);
    function GetTargetHeight: integer;
    procedure SetTargetHeight(NewHeight: integer);
    procedure SetControlActions(ControlActions: TControlActions);
    procedure WMKeyDown(var Message: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TMessage); message WM_KEYUP;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure CMChanged(var Message: TMessage); message CM_CHANGED;
    procedure CMNewTarget(var Message: TMessage); message CM_NEWTARGET;
  protected
    procedure SetEnabled(Enable: boolean); {$IFNDEF VER100} override;{$ENDIF}
    {$IFDEF VER100}
    function GetEnabled: boolean;
    {$ENDIF}
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var key: Word; Shift: TShiftState); override;
    procedure KeyUp(var key: Word; Shift: TShiftState); override;
    function DoTargetChanging(NewTarget: TControl): boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetFocus; override;

    property Target_Align: TAlign read GetTargetAlign write SetTargetAlign;
    property Target_Left: integer read GetTargetLeft write SetTargetLeft;
    property Target_Top: integer read GetTargetTop write SetTargetTop;
    property Target_Width: integer read GetTargetWidth write SetTargetWidth;
    property Target_Height: integer read GetTargetHeight write SetTargetHeight;
  published
    property AllowTab: boolean read fAllowTab write fAllowTab;
    property Color: TColor read GetColor write SetColor;
    property ControlActions: TControlActions read
      fControlActions write SetControlActions;
    property MinHeight: integer read fMinHeight write fMinHeight;
    property MinWidth: integer read fMinWidth write fMinWidth;
    property OnMoving: TAutoControlEvent read fOnMoving write fOnMoving;
    property OnResizing: TAutoControlEvent read fOnResizing write fOnResizing;
    property OnMoved: TAutoControlEvent read fOnMoved write fOnMoved;
    property OnResized: TAutoControlEvent read fOnResized write fOnResized;
    property OnTargetChanged: TNewTargetEvent
      read fOnTargetChanged write fOnTargetChanged;
    property OnTargetChanging: TTargetChangingEvent
      read fOnTargetChanging write fOnTargetChanging;
    property MouseButtons: TMouseButtons read fButtons write fButtons;
    {$IFDEF VER100}
    property Enabled: boolean read GetEnabled write SetEnabled;
    {$ELSE}
    property Enabled;
    {$ENDIF}
    property GridSize: integer read fGridSize write SetGridSize;
    property SnapToGrid: boolean read fSnapToGrid write fSnapToGrid;
    property Target: TControl read fTarget write SetTarget;
    property PopupMenu;
  end;

procedure Register;

implementation

const
  crSizeNSEW = 1;

//------------------------------------------------------------------------------
// Miscellaneous functions ...
//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('Samples', [TAutoControl]);
end;
//------------------------------------------------------------------------------

function OffsetPt(pt: TPoint; xOffset, yOffset: integer): TPoint;
begin
  result := Point(pt.x + xOffset, pt.y + yOffset);
end;
//------------------------------------------------------------------------------

function GetControlFromPt(Owner: TWinControl; pt: TPoint): TControl;
var
  i: integer;
begin
  //nb: As TAutoControl does not assign its Parent property,
  //    it will never be found in TWinControl.Controls[]
  with Owner do
    //reverse search order to get topmost controls first ... (29May03)
    for i := ControlCount-1 downto 0 do
      if PtInRect(Controls[i].BoundsRect,pt) and Controls[i].visible  then
      begin
        if (Controls[i] is TWinControl) then
          result := GetControlFromPt(TWinControl(Controls[i]),
            OffsetPt(pt,-Controls[i].left,-Controls[i].top))
        else
          result := Controls[i];
        exit;
      end;
  result := Owner;
end;

//------------------------------------------------------------------------------
// TAutoControl methods ...
//------------------------------------------------------------------------------

constructor TAutoControl.Create(aOwner: TComponent);
begin
  inherited;
  inherited setbounds(0,0,28,28);
  canvas.brush.style := bsClear;
  canvas.pen.color := $003366FF; //orange
  canvas.pen.Width := 4;
  visible := false;
  fMinHeight := 5;
  fMinWidth := 5;
  fAllowTab := true;
  fGridSize := 8;
  fButtons := [mbLeft,mbRight];
  //fControlActions := caSizeMove;
  if not (aOwner is TCustomForm) then
    raise Exception.create('TAutoControl.create - Owner must be a TCustomFrom');
  fOwnerForm := TCustomForm(aOwner);
  fMyParent := fOwnerForm;
  //nb: Can't add TAutoControls to Parent's control list as that makes it
  //impossible for TAutoControl to be positioned above an aligned control ...
  if (csDesigning in ComponentState) then
    Parent := fOwnerForm else
    ParentWindow := fMyParent.Handle;
  screen.Cursors[crSizeNSEW] := loadcursor(hInstance,'NSEW');
  if not (csDesigning in ComponentState) then
    HookFormWindowProc;
end;
//------------------------------------------------------------------------------

destructor TAutoControl.Destroy;
begin
  if not (csDesigning in ComponentState) then UnHookFormWindowProc;
  inherited;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.HookFormWindowProc;
begin
  fOldFormWindowProc := fOwnerForm.WindowProc;
  fOwnerForm.WindowProc := NewFormWindowProc;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.UnHookFormWindowProc;
begin
  fOwnerForm.WindowProc := fOldFormWindowProc;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.CMChanged(var Message: TMessage);
begin
  if assigned(fOnTargetChanged) then fOnTargetChanged(self, fTarget);
end;
//------------------------------------------------------------------------------

procedure TAutoControl.CMNewTarget(var Message: TMessage);
var
  dummyButton: TMouseButton;
begin
  if target = fPostedTarget then
  begin
    fInternalChanging := false;
    exit;
  end;
  target := fPostedTarget;
  releaseCapture;
  if assigned(fOnTargetChanged) then fOnTargetChanged(self, fTarget);
  fPostedTarget := nil;
  if not assigned(fTarget) then exit;
  //this enables the sizeControl to respond immediately to mouse movements...
  WMSetCursor(TWMSetCursor(Message));
  if mbLeft in fButtons then dummyButton := mbLeft
  else if mbRight in fButtons then dummyButton := mbRight
  else dummyButton := mbMiddle;
  with TWMParentNotify(Message) do MouseDown(dummyButton,[],XPos,YPos);
end;
//------------------------------------------------------------------------------

procedure TAutoControl.NewFormWindowProc(var Msg : TMessage);

  procedure PostNewTarget(Msg: TWMParentNotify);
  var
    relPt, ScreenPt, FormPt: TPoint;
    rec: TRect;
  begin
    if not fAllowTab then exit;
    //Msg coords are relative to owning form ...
    FormPt := Point(Msg.XPos,Msg.YPos);
    ScreenPt := fOwnerForm.ClientToScreen(FormPt);
    //get point relative to parent as self.BoundsRect is relative to parent
    //and make sure we're not just clicking the SizeControl ...
    relPt := fMyParent.ScreenToClient(ScreenPt);
    if visible and PtInRect(BoundsRect,relPt) then exit;

    fPostedTarget := GetControlFromPt(fOwnerForm,FormPt);
    if (fPostedTarget <> target) and DoTargetChanging(fPostedTarget) then
    begin
      fInternalChanging := true;
      if assigned(fPostedTarget) then
      begin
        if fPostedTarget is TWinControl then
        begin
          //fixup for any diff between WindowOrigins & ClientOrigins ...
          GetWindowRect(TWinControl(fPostedTarget).handle, rec);
          relPt := Point(ScreenPt.x - rec.Left, ScreenPt.y - rec.Top);
        end
        else
          relPt := fPostedTarget.ScreenToClient(ScreenPt);
        PostMessage(self.handle,CM_NEWTARGET,0, integer(SmallPoint(relPt.x,relPt.y)));
      end else
        PostMessage(self.handle,CM_NEWTARGET,0, 0);
    end
    else
      setfocus;
  end;

var
  i,j: integer;
  oldCoords, newCoords: TRect;
  scrollOffsetX, scrollOffsetY: Integer;
begin
  if not enabled then
  begin
    fOldFormWindowProc(Msg);
    exit;
  end;

  case Msg.Msg of
    //workaround - setting the ZOrder in SetTarget doesn't work prior to show
    WM_SHOWWINDOW: SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
    //Handling TAutoControl's focus (using ParentWindow) is tricky!!
    //There's probably a better way to do this - I just haven't found it yet. :) )
    CM_ACTIVATE: begin fOwnerForm.activeControl := nil; setfocus; end;
    WM_GETDLGCODE:
      begin
        Msg.Result := DLGC_WANTTAB;
        exit;
      end;
    WM_SIZE: if assigned(fTarget) then oldCoords := fTarget.BoundsRect;
    WM_LBUTTONDOWN:
      if mbLeft in fButtons then PostNewTarget(TWMParentNotify(Msg));
    WM_RBUTTONDOWN:
      if mbRight in fButtons then PostNewTarget(TWMParentNotify(Msg)); 
    WM_MBUTTONDOWN:
      if mbMiddle in fButtons then PostNewTarget(TWMParentNotify(Msg));
    WM_PARENTNOTIFY:
      case TWMParentNotify(Msg).Event of
        WM_LBUTTONDOWN:
          if mbLeft in fButtons then PostNewTarget(TWMParentNotify(Msg));
        WM_RBUTTONDOWN:
          if mbRight in fButtons then PostNewTarget(TWMParentNotify(Msg));
        WM_MBUTTONDOWN:
          if mbMiddle in fButtons then PostNewTarget(TWMParentNotify(Msg));
      end;
  end;

  //do default processing...
  fOldFormWindowProc(Msg);

  //stop any other controls on the form from receiving focus ...
  if (Msg.Msg = WM_COMMAND) and (HIWORD(Msg.WParam) > 1) then
  begin
    fOwnerForm.activeControl := nil;
    setfocus;
  end
  //if form has been resized, update target's dimensions...
  else if (Msg.Msg = WM_SIZE) and fOwnerForm.visible and
    assigned(fTarget) then
  begin
    newCoords := fTarget.BoundsRect;
    if (newCoords.Right <> oldCoords.Right) or
      (newCoords.Bottom <> oldCoords.Bottom) then
    UpdateTargetCoords(moResizing);
  end
  //finally paint a grid on the form ...
  else if (Msg.Msg = WM_PAINT) and (fGridSize > 0) then
    with fOwnerForm do
    begin
      // offset the grid to account for the scrolled position of the form
      //(Bug fix - thanks to Daniel Newton)
      scrollOffsetX := HorzScrollBar.ScrollPos mod fGridSize;
      scrollOffsetY := VertScrollBar.ScrollPos mod fGridSize;
      // draw grid (+1 to balance scrollOffsets)
      for i := 0 to ClientWidth div fGridSize + 1 do
        for j := 0 to ClientHeight div fGridSize + 1 do
          canvas.Pixels[i*fGridSize-scrollOffsetX,j*fGridSize-scrollOffsetY] := clDkGray;
    end;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.WMGetDlgCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTTAB or DLGC_WANTARROWS;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.WMEraseBkgnd(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then
    inherited else
    Message.Result := 1;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (csDesigning in ComponentState) then
    inherited SetBounds(ALeft,ATop,Width,Height) else
    inherited SetBounds(ALeft,ATop,AWidth,AHeight);
end;
//------------------------------------------------------------------------------

function TAutoControl.DoTargetChanging(NewTarget: TControl): boolean;
begin
  result := true;
  if assigned(fOnTargetChanging) then fOnTargetChanging(self,NewTarget,result);
end;
//------------------------------------------------------------------------------

function TAutoControl.GetTargetAlign: TAlign;
begin
  if (fTarget <> nil) then result := fTarget.Align
  else result := alNone;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetTargetAlign(NewAlign: TAlign);
begin
  if (fTarget = nil) or (fTarget.Align = NewAlign) then exit;
  fTarget.Align := NewAlign;
  UpdateTargetCoords(moMoving);;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.UpdateTargetCoords(MouseOp: TMouseOp);
begin
  invalidate;
  with fTarget do self.setbounds(Left,top,width,height);
  invalidate;
  if (MouseOp = moResizing) and assigned(fOnResized) then
    fOnResized(self, BoundsRect)
  else if (MouseOp = moMoving) and assigned(fOnMoved) then
    fOnMoved(self, BoundsRect);
end;
//------------------------------------------------------------------------------

function TAutoControl.GetTargetLeft: integer;
begin
  if (fTarget <> nil) then result := fTarget.Left
  else result := fOwnerForm.Left;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetTargetLeft(NewLeft: integer);
begin
  if (fTarget = nil) or (fTarget.Left = NewLeft) then exit;
  fTarget.Left := NewLeft;
  UpdateTargetCoords(moMoving);
end;
//------------------------------------------------------------------------------

function TAutoControl.GetTargetTop: integer;
begin
  if (fTarget <> nil) then result := fTarget.Top
  else result := fOwnerForm.Top;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetTargetTop(NewTop: integer);
begin
  if (fTarget = nil) or (fTarget.Top = NewTop) then exit;
  fTarget.Top := NewTop;
  UpdateTargetCoords(moMoving);
end;
//------------------------------------------------------------------------------

function TAutoControl.GetTargetWidth: integer;
begin
  if (fTarget <> nil) then result := fTarget.Width
  else result := fOwnerForm.Width;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetTargetWidth(NewWidth: integer);
begin
  if (fTarget = nil) or (fTarget.Width = NewWidth) then exit;
  fTarget.Width := NewWidth;
  UpdateTargetCoords(moResizing);
end;
//------------------------------------------------------------------------------

function TAutoControl.GetTargetHeight: integer;
begin
  if (fTarget <> nil) then result := fTarget.Height
  else result := fOwnerForm.Height;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetTargetHeight(NewHeight: integer);
begin
  if (fTarget = nil) or (fTarget.Height = NewHeight) then exit;
  fTarget.Height := NewHeight;
  UpdateTargetCoords(moResizing);
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetControlActions(ControlActions: TControlActions);
begin
  fControlActions := ControlActions;
  if not (csDesigning in ComponentState) then invalidate;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.KeyDown(var Key: Word; Shift: TShiftState);

  //-----------------------------------------------------------------------

  function GetParentIndexOfControl(Control: TControl): integer;
  begin
    result := 0;
    while Control.Parent.Controls[result] <> Control do inc(result);
  end;
  //-----------------------------------------------------------------------

  function GetNextVisibleSibling(Parent: TWinControl; CurrentIndex: integer): TControl;
  var
    i: integer;
  begin
    result := nil;
    i := CurrentIndex+1;
    with Parent do
    begin
      while (i < ControlCount) and not (Controls[i].visible) do inc(i);
      if (i < ControlCount) then result := Controls[i];
    end;
  end;
  //-----------------------------------------------------------------------

 function GetFirstVisibleChild(Current: TControl): TControl;
  var
    i: integer;
  begin
    result := nil;
    if not (Current is TWinControl) then exit;
    with TWinControl(Current) do
    begin
      i := 0;
      while (i < ControlCount) and not (Controls[i].visible) do inc(i);
      if (i < ControlCount) then result := Controls[i];
    end;
  end;
  //-----------------------------------------------------------------------

  function GetPriorVisible(Parent: TWinControl; CurrentIndex: integer): TControl;
  var
    i: integer;
  begin
    i := CurrentIndex-1;
    with Parent do
    begin
      while (i >= 0) and not (Controls[i].visible) do dec(i);
      if (i >= 0) then
      begin
        //if prior sibling found check for nested controls...
        if (Controls[i] is TWinControl) and
          (TWinControl(Controls[i]).ControlCount > 0) then
            result := GetPriorVisible(TWinControl(Controls[i]),
              TWinControl(Controls[i]).ControlCount)
        else
          result := Controls[i];
        exit; //found!!
      end;
    end;
    result := Parent;
    if (result is TCustomForm) then
      result := GetPriorVisible(TWinControl(result),
        TWinControl(result).Controlcount);
  end;
  //-----------------------------------------------------------------------

  function TabNextControl(Current: TControl): TControl;
  var
    i: integer;
  label CheckOK;
  begin
    result := nil;
    if not assigned (Current) then exit;
    //try for an assignable child ...
    result := GetFirstVisibleChild(Current);
    if assigned(result) then goto CheckOK;
    //try for next sibling...
    i := GetParentIndexOfControl(Current);
    result := GetNextVisibleSibling(Current.Parent,i);
    while not assigned(result) do
    begin
      //go up another level ...
      Current := Current.Parent;
      //if at the top then find the very first visible control ...
      if (Current is TCustomForm) then
        result := GetNextVisibleSibling(TWinControl(Current), -1)
      else
      //otherwise move to the next sibling and try again...
      begin
        i := GetParentIndexOfControl(Current);
        result := GetNextVisibleSibling(Current.Parent,i);
      end;
    end;
  CheckOK:
    if not DoTargetChanging(result) then result := TabNextControl(result);
    fInternalChanging := (result <> fTarget);
  end;
  //-----------------------------------------------------------------------

  function TabPriorControl(Current: TControl): TControl;
  var
    i: integer;
  begin
    result := nil;
    if not assigned (Current) then exit;
    i := GetParentIndexOfControl(Current);
    result := GetPriorVisible(Current.Parent,i);
    if not DoTargetChanging(result) then result := TabPriorControl(result);
    fInternalChanging := result <> fTarget;
  end;
  //-----------------------------------------------------------------------

var
  rec: TRect;
begin
  inherited;

  if fMouseOp <> moNone then exit;
  case Key of
    VK_ESCAPE:
      if fAllowTab and DoTargetChanging(fMyParent) then
      begin
        fInternalChanging := true;
        if (fMyParent is TCustomForm) then SetTarget(nil)
        else SetTarget(fMyParent);
      end;
    VK_TAB:
      if fAllowTab then
      begin
        if not assigned(fTarget) then
          SetTarget(GetNextVisibleSibling(fOwnerForm,-1))
        else if ssShift in Shift then
          SetTarget(TabPriorControl(fTarget))
        else
          SetTarget(TabNextControl(fTarget));
      end;
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT:
      begin
        invalidate;
        if (ssShift in Shift) and (fControlActions = caMoveOnly) then
          Shift := Shift - [ssShift]
        else if not (ssShift in Shift) and (fControlActions = caSizeOnly) then
          Shift := Shift + [ssShift];
        if (fTarget.Align <> alNone) then
        begin
          //Aligned controls can't be moved nor ClientAligned controls resized
          if not (ssShift in Shift) or (fTarget.Align = alClient) then exit;

          case Key of
            VK_UP:
              if (fTarget.Align in [alLeft,alRight]) then exit
              else if (fTarget.Align = alTop) then
                fTarget.SetBounds(Left, Top, Width, Height-1) else
                fTarget.SetBounds(Left, Top-1, Width, Height+1);
            VK_DOWN:
              if (fTarget.Align in [alLeft,alRight]) then exit
              else if (fTarget.Align = alTop) then
                fTarget.SetBounds(Left, Top, Width, Height+1) else
                fTarget.SetBounds(Left, Top+1, Width, Height-1);
            VK_LEFT:
              if (fTarget.Align in [alTop,alBottom]) then exit
              else if (fTarget.Align = alLeft) then
                fTarget.SetBounds(Left, Top, Width-1, Height) else
                fTarget.SetBounds(Left-1, Top, Width+1, Height);
            VK_RIGHT:
              if (fTarget.Align in [alTop,alBottom]) then exit
              else if (fTarget.Align = alLeft) then
                fTarget.SetBounds(Left, Top, Width+1, Height) else
                fTarget.SetBounds(Left+1, Top, Width-1, Height);
          end;
          rec := fTarget.BoundsRect;
        end else //target is not aligned...
        begin
          rec := BoundsRect;
          case Key of
            VK_UP: if (ssShift in Shift) then dec(rec.Bottom)
                   else offsetRect(rec,0,-1);
            VK_DOWN: if (ssShift in Shift) then inc(rec.Bottom)
                   else offsetRect(rec,0,1);
            VK_LEFT: if (ssShift in Shift) then dec(rec.Right)
                     else offsetRect(rec,-1,0);
            VK_RIGHT: if (ssShift in Shift) then inc(rec.Right)
                      else offsetRect(rec,1,0);
          end;
          with rec do
          begin
            if right-Left < fMinWidth then right := Left+fMinWidth;
            if bottom-Top < fMinHeight then bottom := Top+fMinHeight;
            fTarget.SetBounds(left,top,right-left,bottom-top);
          end;
        end;
        with fTarget.BoundsRect do
          self.SetBounds(left,top,right-left,bottom-top);
        if (ssShift in Shift) then
        begin
          if assigned(fOnResizing) then fOnResizing(self, rec)
        end
        else if assigned(fOnMoving) then fOnMoving(self, rec);
      end;
  end;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.KeyUp(var key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT:
    begin
      //if aligned and was trying to move or is client aligned the exit ...
      if (fTarget.Align <> alNone) and
         (not (ssShift in Shift) or (fTarget.Align = alClient)) then exit;

      if (ssShift in Shift) then
      begin
       if assigned(fOnResized) then fOnResized(self, BoundsRect)
      end
      else if assigned(fOnMoved) then fOnMoved(self, BoundsRect);
    end;
  end;
end;
//------------------------------------------------------------------------------

{$IFDEF VER100}
function TAutoControl.GetEnabled: boolean;
begin
  result := inherited Enabled;
end;
{$ENDIF}

//------------------------------------------------------------------------------

procedure TAutoControl.SetEnabled(Enable: boolean);
begin
  {$IFDEF VER100}
  inherited Enabled := Enable;
  {$ELSE}
  inherited SetEnabled(Enable);
  {$ENDIF}
  visible := Enable and assigned(fTarget);
  if visible then setFocus;
  //hide/show the grid ...
  if not (csDesigning in ComponentState) then fOwnerForm.invalidate;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetFocus;
begin
  if assigned (fTarget) and fOwnerForm.visible and
    fMyParent.canfocus and enabled then
    begin
      fOwnerForm.activeControl := nil; 
      Windows.SetFocus(Handle);
      invalidate; //belt and braces because no Parent assigned
    end;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetGridSize(GridSize: integer);
begin
  if (GridSize < 0) or (GridSize > 50) or (fGridSize = GridSize) then exit;
  fGridSize := GridSize;
  if (csDesigning in ComponentState) then exit;
  fOwnerForm.invalidate;
  self.invalidate;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetTarget(target: TControl);
begin
  if fInternalChanging then fInternalChanging := false
  else if (fTarget = target) or (target is TAutoControl) then exit
  else if not (csDesigning in ComponentState) and
    not DoTargetChanging(target) then exit;

  //just incase a target is posted just before calling SetTarget...
  if fPostedTarget <> nil then fPostedTarget := target;

  if (target = nil) or (target.parent = nil) then
    fTarget := nil else
    fTarget := target;
  if (csDesigning in ComponentState) then exit;
  visible := false;
  //nb: Can't use Parent property as this causes havoc when trying
  //to position TAutoControl above aligned Targets ...
  parent := nil;
  fMyParent := fOwnerForm;
  ParentWindow := fMyParent.Handle;
  if assigned(fTarget) then
  begin
    fMyParent := fTarget.parent;
    ParentWindow := fMyParent.Handle;
    with fTarget do
      self.setbounds(Left,top,width,height);
    if not Enabled then exit;
    fMouseOp := moNone;
    //bringToFront...
    SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE);
    visible := true;
    SetFocus;
  end else
    windows.SetFocus(ParentWindow);
  PostMessage(handle, CM_CHANGED, 0, 0);
end;
//------------------------------------------------------------------------------

procedure TAutoControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if not (csDestroying in ComponentState) and //6 Apr 2005
    (Operation = opRemove) and (AComponent = fTarget) then SetTarget(nil);
end;
//------------------------------------------------------------------------------

procedure TAutoControl.DrawRect;
var
  dc: hDC;
begin
  //draw (or erase) a FocusRect at the current Sizing coordinates...
  dc := GetDC(0);
  try
    DrawFocusRect(dc,fSizingRect);
  finally
    ReleaseDC(0,dc);
  end;
end;
//------------------------------------------------------------------------------


procedure TAutoControl.WMKeyDown(var Message: TMessage);
begin
  //nb: GetParentForm() called in TWinControl.DoKeyDown() always returns nil
  //    because TAutoControl has no assigned Parent property, so...
  if fOwnerForm.KeyPreview then
    with Message do
      Result := SendMessage(fOwnerForm.Handle,Msg,WParam,LParam);
  inherited;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.WMKeyUp(var Message: TMessage);
begin
  //nb: GetParentForm() called in TWinControl.DoKeyUp() always returns nil
  //    because TAutoControl has no assigned Parent property, so...
  if fOwnerForm.KeyPreview then
    with Message do
      Result := SendMessage(fOwnerForm.Handle,Msg,WParam,LParam);
  inherited;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.WMSetCursor(var Message: TWMSetCursor);
var
  pt: TPoint;
  rec: TRect;
  i: integer;

  procedure SetSizingBorderAndCursorFromPoint(pt: TPoint);
  begin
    fSizingBorder := sbNone;
    with pt do
      if (x < 5) then //left edge somewhere...
      begin
        if (y < 5) then
        begin
          if fTarget.Align <> alNone then exit;
          fSizingBorder := sbTopLeft;
          Windows.SetCursor(Screen.Cursors[crSizeNWSE]);
        end else
        if (y > height-5) then
        begin
          if fTarget.Align <> alNone then exit;
          fSizingBorder := sbBottomLeft;
          Windows.SetCursor(Screen.Cursors[crSizeNESW]);
        end else
        begin
          if (fTarget.Align <> alNone) and (fTarget.Align <> alRight) then exit;
          fSizingBorder := sbLeft;
          Windows.SetCursor(Screen.Cursors[crSizeWE]);
        end;
      end
      else if (x > width-5) then //right edge somewhere ...
      begin
        if (y < 5) then
        begin
          if fTarget.Align <> alNone then exit;
          fSizingBorder := sbTopRight;
          Windows.SetCursor(Screen.Cursors[crSizeNESW]);
        end else
        if (y > height-5) then
        begin
          if fTarget.Align <> alNone then exit;
          fSizingBorder := sbBottomRight;
          Windows.SetCursor(Screen.Cursors[crSizeNWSE]);
        end else
        begin
          if (fTarget.Align <> alNone) and (fTarget.Align <> alLeft) then exit;
          fSizingBorder := sbRight;
          Windows.SetCursor(Screen.Cursors[crSizeWE]);
        end;
      end
      else if (y < 5) then //top
      begin
        if (fTarget.Align <> alNone) and (fTarget.Align <> alBottom) then exit;
        fSizingBorder := sbTop;
        Windows.SetCursor(Screen.Cursors[crSizeNS]);
      end else if (y > height-5) then //bottom
      begin
        if (fTarget.Align <> alNone) and (fTarget.Align <> alTop) then exit;
        fSizingBorder := sbBottom;
        Windows.SetCursor(Screen.Cursors[crSizeNS]);
      end;
  end;

begin
  if (csDesigning in ComponentState) or (Screen.Cursor <> crDefault) then
  begin
    inherited;
    exit;
  end;

  Message.Result := 1;
  GetCursorPos(pt);
  windows.ScreenToClient(handle,pt);
  //Change cursor depending whether on an edge (ie sizing) or middle (moving)...
  rec := clientrect;
  inflaterect(rec,-4,-4);
  if PtInRect(rec,pt) then
  begin

    //check if over a child of the target ...
    if fTarget is TWinControl then
      with TWinControl(fTarget) do
        for i := 0 to ControlCount-1 do
          if Controls[i].visible and PtInRect(Controls[i].BoundsRect,pt) then
          begin
            Windows.SetCursor(Screen.Cursors[crDefault]);
            exit;
          end;

    //aligned controls can't be moved ...
    if (fTarget.Align = alNone) and (fControlActions <> caSizeOnly)
    then
      Windows.SetCursor(Screen.Cursors[crSizeNSEW]) else
      Windows.SetCursor(Screen.Cursors[crDefault]);
    fSizingBorder := sbNone;
  end
  //if non-aligned and MoveOnly then just move...
  else if (fControlActions = caMoveOnly) and (fTarget.Align = alNone) then
  begin
    Windows.SetCursor(Screen.Cursors[crSizeNSEW]);
    fSizingBorder := sbNone;
  end
  //if SizeOnly and non-aligned then ignore top & left borders ...
  else if ((fControlActions = caSizeOnly) and (fTarget.Align = alNone) and
    ((pt.x < 5) or (pt.y < 5))) or
    //also can't move aligned controls ...
    ((fControlActions = caMoveOnly) and (fTarget.Align <> alNone)) then
  begin
    Windows.SetCursor(Screen.Cursors[crDefault]);
    fSizingBorder := sbNone;
  end
  else
    SetSizingBorderAndCursorFromPoint(pt);
end;
//------------------------------------------------------------------------------

procedure TAutoControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
  rec: TRect;
  i: integer;
  dummy: TWMSetCursor;
begin
  inherited MouseDown(Button, Shift, X, Y);


  fMouseOp := moNone;
  if not (Button in fButtons) then exit;
  pt := Point(X,Y);
  //check if selecting a child of the target ...
  if fTarget is TWinControl and  fAllowTab then
    with TWinControl(fTarget) do
    begin
      //first check if it's just the sizing border which is being clicked...
      rec := BoundsRect;
      OffsetRect(rec,-left,-top);
      inflateRect(rec,-4,-4);
      if PtInRect(rec,pt) then
        //OK, clicking somewhere withing target...
        for i := 0 to ControlCount-1 do
          if Controls[i].visible and PtInRect(Controls[i].BoundsRect,pt) and
            DoTargetChanging(Controls[i]) then
            begin
              pt := fTarget.ClientToScreen(pt);
              pt := Controls[i].ScreenToClient(pt);
              fInternalChanging := true;
              Target := Controls[i];
              if assigned(fOnTargetChanged) then fOnTargetChanged(self, fTarget);
              //this enables the sizeControl to respond immediately to mouse movements...
              WMSetCursor(dummy);
            end;
    end;

  if (fSizingBorder = sbNone) then
  begin
    if (fTarget.Align <> alNone) or (GetCursor <> Screen.Cursors[crSizeNSEW]) then exit;
    fMouseOp := moMoving;
  end else
    fMouseOp := moResizing;

  fOffset := pt;
  GetWindowRect(handle,fSizingRect); //nb: screen coords
  DrawRect;
  //set a ClipCursor region to restrict mouse movement...
  rec := fMyParent.ClientRect;
  case fSizingBorder of
    sbLeft: rec.right := left+width-fMinWidth;
    sbTopLeft:
      begin rec.right := left+width-fMinWidth; rec.bottom := top+height-fMinHeight; end;
    sbTop: rec.bottom := top+height-fMinHeight;
    sbTopRight:
      begin rec.bottom := top+height-fMinHeight; rec.left := left+fMinWidth; end;
    sbRight: rec.left := left+fMinWidth;
    sbBottomRight:
      begin rec.left := left+fMinWidth; rec.top := top+fMinHeight; end;
    sbBottom: rec.top := top+fMinHeight;
    sbBottomLeft:
      begin rec.top := top+fMinHeight; rec.right := left+width-fMinWidth; end;
  end;
  offsetrect(rec,fMyParent.ClientOrigin.x,fMyParent.ClientOrigin.y);
  ClipCursor(@rec);
  MouseCapture := true;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  formOffset: TPoint;
  offset, HalfGridSize: integer;
begin
  inherited MouseUp(Button, Shift, X, Y);
  MouseCapture := false;
  if (fMouseOp = moNone) then exit;
  ClipCursor(nil);
  DrawRect;
  if (fTarget <> nil) then
  begin
    invalidate;
    //convert fSizingRect from screen to parent's coords...
    with fSizingRect do
    begin
      //snap to grid...
      if (fGridSize > 1) and fSnapToGrid then
      begin
        formOffset := Point(fOwnerForm.ClientOrigin.x mod GridSize,
          fOwnerForm.ClientOrigin.y mod GridSize);

        HalfGridSize := GridSize div 2;
        offset := (left-formOffset.x) mod GridSize;
        if offset < HalfGridSize then
          dec(left, offset) else inc(left, GridSize - offset);
        offset := (top-formOffset.y) mod GridSize;
        if offset < HalfGridSize then
          dec(top, offset) else inc(top, GridSize - offset);
        offset := (right-formOffset.x) mod GridSize;
        if offset < HalfGridSize then
          dec(right, offset) else inc(right, GridSize - offset);
        offset := (bottom-formOffset.y) mod GridSize;
        if offset < HalfGridSize then
          dec(bottom, offset) else inc(bottom, GridSize - offset);
      end;
      windows.ScreenToClient(fMyParent.Handle,topleft);
      windows.ScreenToClient(fMyParent.Handle,bottomright);
      fTarget.SetBounds(left,top,right-left,bottom-top);
      UpdateTargetCoords(fMouseOp);
    end;
  end;
  fMouseOp := moNone;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  pt: TPoint;
  rec: TRect;
begin
  inherited MouseMove(Shift, X, Y);
  if fMouseOp = moNone then exit;

  DrawRect; //hides previous FocusRect (XORing bits)
  pt := point(X,Y);
  windows.clienttoscreen(handle,pt);
  if fMouseOp = moMoving then
  begin
    inc(fSizingRect.right, (pt.X - fOffset.X) - fSizingRect.Left);
    inc(fSizingRect.bottom, (pt.Y - fOffset.Y) - fSizingRect.Top);
    fSizingRect.Left := pt.X - fOffset.X;
    fSizingRect.Top := pt.Y - fOffset.Y;
    if assigned(fOnMoving) then
    begin
      pt := fMyParent.ClientOrigin;
      rec := fSizingRect;
      offsetrect(rec,-pt.x,-pt.y);
      fOnMoving(self, rec);
    end;
  end
  else if fMouseOp = moResizing then
  begin
    case fSizingBorder of
      sbLeft: fSizingRect.Left := pt.X - fOffset.X;
      sbTopLeft:
        begin
          fSizingRect.Left := pt.X - fOffset.X;
          fSizingRect.Top := pt.Y - fOffset.Y;
        end;
      sbTop: fSizingRect.Top := pt.Y - fOffset.Y;
      sbTopRight:
        begin
          fSizingRect.right := (pt.X - fOffset.X) + width;
          fSizingRect.Top := pt.Y - fOffset.Y;
        end;
      sbRight: fSizingRect.right := (pt.X - fOffset.X) + width;
      sbBottomRight:
        begin
          fSizingRect.right := (pt.X - fOffset.X) + width;
          fSizingRect.bottom := (pt.Y - fOffset.Y) + height;
        end;
      sbBottom: fSizingRect.bottom := (pt.Y - fOffset.Y) + height;
      sbBottomLeft:
        begin
          fSizingRect.Left := pt.X - fOffset.X;
          fSizingRect.bottom := (pt.Y - fOffset.Y) + height;
        end;
    end;
    if assigned(fOnResizing) then
    begin
      pt := fMyParent.ClientOrigin;
      rec := fSizingRect;
      offsetrect(rec,-pt.x,-pt.y);
      fOnResizing(self, rec);
    end;
  end;
  DrawRect; //draw new FocusRect
end;
//------------------------------------------------------------------------------

procedure TAutoControl.Paint;

  procedure DrawLine(FromX, FromY, ToX, ToY: integer);
  begin
    canvas.moveto(FromX, FromY);
    canvas.lineto(ToX, ToY);
  end;

var
  saveColor: TColor;
begin
  inherited;
  saveColor := canvas.pen.color;
  if (csDesigning in ComponentState) or
    ((fTarget.Align = alNone) and (fControlActions <> caSizeOnly)) then
    canvas.rectangle(1,1,width,height)
  else if (fTarget.Align = alNone) then  //ie caSizeOnly ...
  begin
    DrawLine(1,height-1,width,height-1); //bottom
    DrawLine(width-1,1,width-1,height);  //right
    canvas.pen.color := clBtnShadow;
    DrawLine(1,1,1,height);              //left
    DrawLine(1,1,width,1);               //top
    canvas.pen.color := saveColor;
  end else
  begin
    if (fControlActions = caMoveOnly) then
      canvas.pen.color := clBtnShadow;
    case fTarget.Align of
      alTop: DrawLine(1,height-1,width,height-1);
      alBottom: DrawLine(1,1,width,1);
      alRight: DrawLine(1,1,1,height);
      alLeft: DrawLine(width-1,1,width-1,height);
    end;
    if (fControlActions = caMoveOnly) then
      canvas.pen.color := saveColor;
  end;
end;
//------------------------------------------------------------------------------

function TAutoControl.GetColor: TColor;
begin
  result := canvas.pen.color;
end;
//------------------------------------------------------------------------------

procedure TAutoControl.SetColor(Color: TColor);
begin
  canvas.pen.color := Color;
  invalidate;
end;
//------------------------------------------------------------------------------


end.

