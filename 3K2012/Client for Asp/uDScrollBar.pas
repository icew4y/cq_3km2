{如滚动块在顶部拉不下需MaxValue > Height}
unit uDScrollBar;

interface
uses Types, Classes, Controls, Math, Graphics, AbstractCanvas, AbstractTextures,DWinCtl, WIL;
type
  TDScrollBar = class(TDControl)
  private
    FItemHeight: Integer;
    FItemIndex: Integer;

    FMaxValue, FPosition: Integer;
    FPrevImageIndex: TDImageIndex;
    FNextImageIndex: TDImageIndex;
    FBarImageIndex: TDImageIndex;

    FPrevImageSize: Integer;
    FNextImageSize: Integer;
    FBarImageSize: Integer;

    FPrevMouseDown: Boolean;
    FNextMouseDown: Boolean;
    FBarMouseDown: Boolean;

    FPrevMouseMove: Boolean;
    FNextMouseMove: Boolean;
    FBarMouseMove: Boolean;



    FBarTop: Integer;
    FRemoveSize: Integer;
    FScrollSize: Integer;
    FOnScroll: TOnScroll;
    procedure SetItemIndex(Value: Integer);
    procedure SetItemHeight(Value: Integer);
    procedure SetMaxValue(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetRemoveSize(const Value: Integer);
    procedure SetScrollSize(const Value: Integer);
    function InPrevRange(X, Y: Integer): Boolean;
    function InNextRange(X, Y: Integer): Boolean;
    function InBarRange(X, Y: Integer): Boolean;
    procedure PrevImageIndexChange(Sender: TObject);
    procedure NextImageIndexChange(Sender: TObject);
    procedure BarImageIndexChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DirectPaint (dsurface: TAsphyreCanvas); override;
    procedure DoResize(var NewRect: TRect);
    //function Click(X, Y: Integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    procedure Next;
    procedure Previous;
    procedure First;
    procedure Last;
  published
    property ItemHeight: Integer read FItemHeight write SetItemHeight;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property ScrollSize: Integer read FScrollSize write SetScrollSize;

    property PrevImageIndex: TDImageIndex read FPrevImageIndex write FPrevImageIndex;
    property NextImageIndex: TDImageIndex read FNextImageIndex write FNextImageIndex;
    property BarImageIndex: TDImageIndex read FBarImageIndex write FBarImageIndex;

    property MaxValue: Integer read FMaxValue write SetMaxValue;
    property Position: Integer read FPosition write SetPosition;
    property RemoveSize: Integer read FRemoveSize write SetRemoveSize;
    property OnScroll: TOnScroll read FOnScroll write FOnScroll;
  end;
procedure Register;
implementation
uses uDScrollBox, uDListView;

procedure Register;
begin
   RegisterComponents('MirGame', [TDScrollBar]);
end;

{ TDScrollBar }

procedure TDScrollBar.BarImageIndexChange(Sender: TObject);
var
  D: TAsphyreLockableTexture;
  nIndex: Integer;
begin
  nIndex := -1;
  if FBarImageIndex.Up >= 0 then
    nIndex := FBarImageIndex.Up
  else
    if FBarImageIndex.Hot >= 0 then
    nIndex := FBarImageIndex.Hot
  else
    if FBarImageIndex.Down >= 0 then
    nIndex := FBarImageIndex.Down;

  if (WLib <> nil) and (nIndex >= 0) then begin
    D := WLib.Images[nIndex];
    if D <> nil then
      FBarImageSize := D.Height;
  end;
end;

constructor TDScrollBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 10;
  Height := 46;
  FPrevImageIndex := TDImageIndex.Create;
  FNextImageIndex := TDImageIndex.Create;
  FBarImageIndex := TDImageIndex.Create;

  FPrevImageIndex.OnChange := PrevImageIndexChange;
  FNextImageIndex.OnChange := NextImageIndexChange;
  FBarImageIndex.OnChange := BarImageIndexChange;

  FPrevMouseDown := False;
  FNextMouseDown := False;
  FBarMouseDown := False;

  FPrevMouseMove := False;
  FNextMouseMove := False;
  FBarMouseMove := False;

  FMaxValue := 100;
  FPosition := 0;
  FRemoveSize := 50;
  FItemHeight := 12;
  FItemIndex := -1;

  FBarTop := 0;
end;

destructor TDScrollBar.Destroy;
begin
  FPrevImageIndex.Free;
  FNextImageIndex.Free;
  FBarImageIndex.Free;
  inherited;
end;

procedure TDScrollBar.DirectPaint(dsurface: TAsphyreCanvas);
var
  d: TAsphyreLockableTexture;
  Rc:TRect;
  nIndex: Integer;
begin
  if Assigned (OnDirectPaint) then
    OnDirectPaint (self, dsurface)
  else begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        Rc := d.ClientRect;
        Rc.Bottom := GHeight;
        dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), Rc, d, True);
        Rc := d.ClientRect;
        Rc.Top := d.Height-GHeight;
        Rc.Bottom := d.Height;
        dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop)+1, Rc, d, True);
      end;
    end;
    nIndex := -1;
    if FPrevMouseDown and (FPrevImageIndex.Down >= 0) then nIndex := FPrevImageIndex.Down
    else if FPrevMouseMove and (FPrevImageIndex.Hot >= 0) then nIndex := FPrevImageIndex.Hot
    else if (FPrevImageIndex.Up >= 0) then nIndex := FPrevImageIndex.Up;
    if (nIndex >= 0) then begin
      D := WLib.Images[nIndex];
      if D <> nil then begin
        DSurface.Draw(SurfaceX(GLeft)+1, SurfaceY(GTop)+1, D.ClientRect, D, True);
      end;
    end;

    nIndex := -1;
    if FNextMouseDown and (FNextImageIndex.Down >= 0) then nIndex := FNextImageIndex.Down
    else if FNextMouseMove and (FNextImageIndex.Hot >= 0) then nIndex := FNextImageIndex.Hot
    else if (FNextImageIndex.Up >= 0) then nIndex := FNextImageIndex.Up;
    if nIndex >= 0 then begin
      D := WLib.Images[nIndex];
      if D <> nil then begin
        DSurface.Draw(SurfaceX(GLeft)+1, SurfaceY(GTop + GHeight - D.Height), D.ClientRect, D, True);
      end;
    end;

    nIndex := -1;
    if FBarMouseDown and (FBarImageIndex.Down >= 0) then nIndex := FBarImageIndex.Down
    else if FBarMouseMove and (FBarImageIndex.Hot >= 0) then nIndex := FBarImageIndex.Hot
    else if (FBarImageIndex.Up >= 0) then nIndex := FBarImageIndex.Up;
    if nIndex >= 0 then begin
      D := WLib.Images[nIndex];
      if D <> nil then begin
        DSurface.Draw(SurfaceX(GLeft)+1, SurfaceY(GTop + FBarTop), D.ClientRect, D, True);
      end;
    end;
  end;
end;

procedure TDScrollBar.DoResize(var NewRect: TRect);
begin
  inherited;

end;


procedure TDScrollBar.First;
var
  P: Integer;
  nHeight: Integer;
  nMaxValue: Integer;
begin
  if FPosition > 0 then begin
    P := 0;
    {if DParent is TDScrollBox then begin
      TDScrollBox(DParent).DoScroll(FPosition - P);
    end else if DParent is TDListView then begin
      TDListView(DParent).DoScroll(FPosition - P);
    end; }
    if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
    FPosition := P;
  end;

  nMaxValue := FMaxValue - FRemoveSize;
  nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

  if (nMaxValue > 0) and (nHeight > 0) then
    FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
  else
    FBarTop := 0;

  if FPosition = nMaxValue then
    FBarTop := GHeight - FNextImageSize - FBarImageSize
  else
    if FPosition = 0 then
    FBarTop := FPrevImageSize
  else
    FBarTop := FBarTop + FPrevImageSize;
end;

function TDScrollBar.InBarRange(X, Y: Integer): Boolean;
var
  nHeight: Integer;
  nMaxValue: Integer;
  nBarTop: Integer;
begin
  Result := False;
  if (X >= GLeft) and (Y < GTop+GHeight - FNextImageSize) and
    (Y > GTop + FPrevImageSize) then begin
    if FPosition > 0 then begin
      nMaxValue := FMaxValue - FRemoveSize;
      nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;
      if (nMaxValue > 0) and (nHeight > 0) then
        nBarTop := Round(FPosition * nHeight / nMaxValue)
      else
        nBarTop := FPrevImageSize;
      Result := (Y >= GTop + FPrevImageSize + nBarTop) and (Y <= GTop + FPrevImageSize + nBarTop + FBarImageSize);
    end else begin
      Result := (Y <= GTop + FPrevImageSize + FBarImageSize);
    end;
  end;
end;

function TDScrollBar.InNextRange(X, Y: Integer): Boolean;
begin
  Result := (X >= GLeft) and (Y >= GTop + (GHeight - FNextImageSize));
end;

function TDScrollBar.InPrevRange(X, Y: Integer): Boolean;
begin
  Result := (X >= GLeft) and (Y <= GTop + FPrevImageSize);
end;

procedure TDScrollBar.Last;
var
  P: Integer;
  nHeight: Integer;
  nMaxValue: Integer;
begin
  nMaxValue := FMaxValue - FRemoveSize;
  nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;
  //if (nMaxValue > 0) and (MaxValue > GHeight) and (nHeight > 0) then begin
  if (nMaxValue > 0) and (nHeight > 0) and (nMaxValue > nHeight) then begin
    if FPosition < nMaxValue then begin
      P := nMaxValue;
      {if DParent is TDScrollBox then begin
        TDScrollBox(DParent).DoScroll(FPosition - P);
      end else if DParent is TDListView then begin
        TDListView(DParent).DoScroll(FPosition - P);
      end;  }
      if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
      FPosition := P;
    end;
  end else begin
    if FPosition > 0 then begin
      P := 0;
      {if DParent is TDScrollBox then begin
        TDScrollBox(DParent).DoScroll(FPosition - P);
      end else if DParent is TDListView then begin
        TDListView(DParent).DoScroll(FPosition - P);
      end;   }
      if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
      FPosition := P;
    end;
  end;

  if (nMaxValue > 0) and (nHeight > 0) then
    FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
  else
    FBarTop := 0;

  if FPosition = nMaxValue then
    FBarTop := GHeight - FNextImageSize - FBarImageSize
  else
    if FPosition = 0 then
    FBarTop := FPrevImageSize
  else
    FBarTop := FBarTop + FPrevImageSize;
end;

function TDScrollBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  nHeight: Integer;
  nMaxValue: Integer;
  nBarTop: Integer;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl=nil) then begin
      FPrevMouseMove := False;
      FNextMouseMove := False;
      FBarMouseMove := False;
      if (Button = mbLeft) then begin
        FPrevMouseDown := InPrevRange(X, Y);
        FNextMouseDown := InNextRange(X, Y);
        FBarMouseDown := InBarRange(X, Y);
        if (not FPrevMouseDown) and (not FNextMouseDown) and (not FBarMouseDown) then begin
          if InRange(x, y) then begin
            nMaxValue := FMaxValue - FRemoveSize;
            nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;
            if ((nMaxValue > 0) and (MaxValue > GHeight) and (nHeight > 0)) or (Position > 0) then begin
              nBarTop := Max(Y - GTop - FPrevImageSize - FBarImageSize div 2, 0);
              Position := Round(nBarTop * nMaxValue / nHeight);
            end else begin
              Position := 0;
            end;

            if (nMaxValue > 0) and (nHeight > 0) then
              FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
            else
              FBarTop := 0;

            if FPosition = nMaxValue then
              FBarTop := GHeight - FNextImageSize - FBarImageSize
            else
              if FPosition = 0 then
              FBarTop := FPrevImageSize
            else
              FBarTop := FBarTop + FPrevImageSize;
            SetDCapture (self);
            Result := True;
            Exit;
          end;
        end else begin
          if FPrevMouseDown then begin
            Previous;
          end else
          if FNextMouseDown then begin
              Next;
          end;
          SetDCapture (self);
          Result := True;
          Exit;
        end;

      end;
      FItemIndex := (Y - GTop) div FItemHeight + FPosition div FItemHeight;
      if FItemIndex >= FMaxValue div FItemHeight then
        FItemIndex := -1;
    end;
    Result := True;
  end;
end;

function TDScrollBar.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  nHeight: Integer;
  nMaxValue: Integer;
  nBarTop: Integer;
begin
  Result := inherited MouseMove (Shift, X, Y);
  //if (not Background) and (not Result) then begin
  if Result then begin
    //Result := inherited MouseMove (Shift, X, Y);
    if MouseCaptureControl = self then begin
      if ssLeft in Shift then begin
        FPrevMouseMove := InPrevRange(X, Y);
        FNextMouseMove := InNextRange(X, Y);
        FBarMouseMove := InBarRange(X, Y);
        if FBarMouseDown then begin
          FPrevMouseMove := False;
          FNextMouseMove := False;
          nMaxValue := FMaxValue - FRemoveSize;
          nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;
          if ((nMaxValue > 0) and (MaxValue > GHeight) and (nHeight > 0)) or (Position > 0) then begin
            //vRect := VirtualRect;
            nBarTop := Max(Y - GTop - FPrevImageSize - FBarImageSize div 2, 0);
            Position := Round(nBarTop * nMaxValue / nHeight);
          end else begin
            Position := 0;
          end;
          
          if (nMaxValue > 0) and (nHeight > 0) then
            FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
          else
            FBarTop := 0;

          if FPosition = nMaxValue then
            FBarTop := GHeight - FNextImageSize - FBarImageSize
          else
            if FPosition = 0 then
            FBarTop := FPrevImageSize
          else
            FBarTop := FBarTop + FPrevImageSize;

            //Exit;
        end else begin
          FItemIndex := (Y - GTop) div FItemHeight + FPosition div FItemHeight;
          if FItemIndex >= FMaxValue div FItemHeight then
            FItemIndex := -1;
        end;
      {end else begin
        FPrevMouseDown := False;
        FNextMouseDown := False;
        FBarMouseDown := False;
        FPrevMouseMove := False;
        FNextMouseMove := False;
        FBarMouseMove := False;
        FItemIndex := -1;     }
      end;
    end;
  end; 
end;

function TDScrollBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
begin
  Result := inherited MouseUp(Button, Shift, X, Y);
  if Result then ReleaseDCapture;
  FBarMouseDown := False;
  FPrevMouseDown := False;
  FNextMouseDown := False;
end;

procedure TDScrollBar.Next;
var
  P: Integer;
  nHeight: Integer;
  nMaxValue: Integer;
begin
  nMaxValue := FMaxValue - FRemoveSize;
  nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

  if (nMaxValue > 0) {and (FMaxValue > nHeight)} and (nHeight > 0) then begin
    if (FPosition < nMaxValue) then begin
      if FPosition + FItemHeight <= nMaxValue then begin
        P := FPosition + FItemHeight;
        {if DParent is TDScrollBox then begin
          TDScrollBox(DParent).DoScroll(FPosition - P);
        end else if DParent is TDListView then begin
          TDListView(DParent).DoScroll(FPosition - P);
        end;  }
        if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
        FPosition := P;
      end else begin
        P := nMaxValue;
        {if DParent is TDScrollBox then begin
          TDScrollBox(DParent).DoScroll(FPosition - P);
        end else if DParent is TDListView then begin
          TDListView(DParent).DoScroll(FPosition - P);
        end;}
        if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
        FPosition := P;
      end;
    end;
  end else begin
    if FPosition > 0 then begin
      P := 0;
      {if DParent is TDScrollBox then begin
        TDScrollBox(DParent).DoScroll(FPosition - P);
      end else if DParent is TDListView then begin
        TDListView(DParent).DoScroll(FPosition - P);
      end;}
      if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
      FPosition := P;
    end;
  end;
  if (nMaxValue > 0) and (nHeight > 0) then
    FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
  else
    FBarTop := 0;

  if FPosition = nMaxValue then
    FBarTop := GHeight - FNextImageSize - FBarImageSize
  else
    if FPosition = 0 then
    FBarTop := FPrevImageSize
  else
    FBarTop := FBarTop + FPrevImageSize;
end;

procedure TDScrollBar.NextImageIndexChange(Sender: TObject);
var
  D: TAsphyreLockableTexture;
  nIndex: Integer;
begin
  nIndex := -1;
  if FNextImageIndex.Up >= 0 then
    nIndex := FNextImageIndex.Up
  else
    if FNextImageIndex.Hot >= 0 then
    nIndex := FNextImageIndex.Hot
  else
    if FNextImageIndex.Down >= 0 then
    nIndex := FNextImageIndex.Down;

  if (WLib <> nil) and (nIndex >= 0) then begin
    D := WLib.Images[nIndex];
    if D <> nil then
      FNextImageSize := D.Height;
  end;
end;

procedure TDScrollBar.PrevImageIndexChange(Sender: TObject);
var
  D: TAsphyreLockableTexture;
  nIndex: Integer;
begin
  nIndex := -1;
  if FPrevImageIndex.Up >= 0 then
    nIndex := FPrevImageIndex.Up
  else
    if FPrevImageIndex.Hot >= 0 then
    nIndex := FPrevImageIndex.Hot
  else
    if FPrevImageIndex.Down >= 0 then
    nIndex := FPrevImageIndex.Down;

  if (WLib <> nil) and (nIndex >= 0) then begin
    D := WLib.Images[nIndex];
    if D <> nil then
      FPrevImageSize := D.Height;
  end;
end;

procedure TDScrollBar.Previous;
var
  P: Integer;
  nHeight: Integer;
  nMaxValue: Integer;
begin
  if FPosition > 0 then begin
    nMaxValue := FMaxValue - FRemoveSize;
    nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

    if (nMaxValue > 0) and (nHeight > 0) then begin
      if FPosition - FItemHeight >= 0 then begin
        P := FPosition - FItemHeight;
        {if DParent is TDScrollBox then begin
          TDScrollBox(DParent).DoScroll(FPosition - P);
        end else if DParent is TDListView then begin
          TDListView(DParent).DoScroll(FPosition - P);
        end;}
        if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
        FPosition := P;
      end else begin
        P := 0;
        {if DParent is TDScrollBox then begin
          TDScrollBox(DParent).DoScroll(FPosition - P);
        end else if DParent is TDListView then begin
          TDListView(DParent).DoScroll(FPosition - P);
        end;}
        if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
        FPosition := P;
      end;
    end else begin
      P := 0;
      {if DParent is TDScrollBox then begin
        TDScrollBox(DParent).DoScroll(FPosition - P);
      end else if DParent is TDListView then begin
        TDListView(DParent).DoScroll(FPosition - P);
      end; }
      if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
      FPosition := P;
    end;
  end;

  if (nMaxValue > 0) and (nHeight > 0) then
    FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
  else
    FBarTop := 0;

  if FPosition = nMaxValue then
    FBarTop := GHeight - FNextImageSize - FBarImageSize
  else
    if FPosition = 0 then
    FBarTop := FPrevImageSize
  else
    FBarTop := FBarTop + FPrevImageSize;
end;

procedure TDScrollBar.SetItemHeight(Value: Integer);
begin
  FItemHeight := Max(Value, Canvas.TextHeight('Pp'));
end;

procedure TDScrollBar.SetItemIndex(Value: Integer);
var
  nItemCount: Integer;
begin
  if FItemIndex <> Value then begin
    FItemIndex := Value;
    nItemCount := FMaxValue div FItemHeight;
    if FItemIndex >= nItemCount then FItemIndex := -1;
    if FItemIndex >= 0 then begin
      if FItemIndex * FItemHeight < FRemoveSize then
        Position := 0
      else
        Position := FItemIndex * FItemHeight - FRemoveSize;
    end;
  end;
end;

procedure TDScrollBar.SetMaxValue(const Value: Integer);
var
  P, nMaxValue, nHeight: Integer;
begin
  if FMaxValue <> Value then begin
    FMaxValue := Max(Value, 0);
    if FMaxValue - FRemoveSize >= 0 then begin
      if FPosition > FMaxValue - FRemoveSize then begin
        P := Max(FMaxValue - FRemoveSize, 0);
        //if FMaxValue < GHeight then P := 0;
        {if DParent is TDScrollBox then begin
          TDScrollBox(DParent).DoScroll(FPosition - P);
        end else if DParent is TDListView then begin
          TDListView(DParent).DoScroll(FPosition - P);
        end;   }
        if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
        FPosition := P;
      end;
    end else begin
      P := 0;
      {if DParent is TDScrollBox then begin
        TDScrollBox(DParent).DoScroll(FPosition - P);
      end else if DParent is TDListView then begin
        TDListView(DParent).DoScroll(FPosition - P);
      end;   }
      if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
      FPosition := P;
    end;
  end;

             
  nMaxValue := FMaxValue - FRemoveSize;
  nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

  if (nMaxValue > 0) and (nHeight > 0) then
    FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
  else
    FBarTop := 0;

  if FPosition = nMaxValue then
    FBarTop := GHeight - FNextImageSize - FBarImageSize
  else
    if FPosition = 0 then
    FBarTop := FPrevImageSize
  else
    FBarTop := FBarTop + FPrevImageSize;
end;

procedure TDScrollBar.SetPosition(const Value: Integer);
var
  P, nMaxValue, nHeight: Integer;
begin
  if FPosition <> Value then begin
    P := Value;
    if P < 0 then P := 0;
    if P > FMaxValue - FRemoveSize then
      P := Max(FMaxValue - FRemoveSize, 0);

    //if FMaxValue < GHeight then P := 0;
    {if DParent is TDScrollBox then begin
      TDScrollBox(DParent).DoScroll(FPosition - P);
    end else if DParent is TDListView then begin
      TDListView(DParent).DoScroll(FPosition - P);
    end; }
    if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
    FPosition := P;
  end;
  
  nMaxValue := FMaxValue - FRemoveSize;
  nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

  if (nMaxValue > 0) and (nHeight > 0) then
    FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
  else
    FBarTop := 0;

  if FPosition = nMaxValue then
    FBarTop := GHeight - FNextImageSize - FBarImageSize
  else
    if FPosition = 0 then
    FBarTop := FPrevImageSize
  else
    FBarTop := FBarTop + FPrevImageSize;
end;

procedure TDScrollBar.SetRemoveSize(const Value: Integer);
var
  P, nMaxValue, nHeight: Integer;
begin
  if FRemoveSize <> Value then begin
    FRemoveSize := Value;
    if FMaxValue - FRemoveSize >= 0 then begin
      if FPosition > FMaxValue - FRemoveSize then begin
        P := Max(FMaxValue - FRemoveSize, 0);
        //if FMaxValue < GHeight then P := 0;
        {if DParent is TDScrollBox then begin
          TDScrollBox(DParent).DoScroll(FPosition - P);
        end else if DParent is TDListView then begin
          TDListView(DParent).DoScroll(FPosition - P);
        end;   }
        if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
        FPosition := P;
      end;
    end else begin
      P := 0;
      {if DParent is TDScrollBox then begin
        TDScrollBox(DParent).DOScroll(FPosition - P);
      end else if DParent is TDListView then begin
        TDListView(DParent).DOScroll(FPosition - P);
      end;   }
      if Assigned(FOnScroll) then FOnScroll(Self, FPosition - P);
      FPosition := P;
    end;
  end;

  nMaxValue := FMaxValue - FRemoveSize;
  nHeight := GHeight - FPrevImageSize - FNextImageSize - FBarImageSize;

  if (nMaxValue > 0) and (nHeight > 0) then
    FBarTop := Max(Round(FPosition * nHeight / nMaxValue), 0)
  else
    FBarTop := 0;

  if FPosition = nMaxValue then
    FBarTop := GHeight - FNextImageSize - FBarImageSize
  else
    if FPosition = 0 then
    FBarTop := FPrevImageSize
  else
    FBarTop := FBarTop + FPrevImageSize;
end;

procedure TDScrollBar.SetScrollSize(const Value: Integer);
begin
  if FScrollSize <> Value then begin
    FScrollSize := Value;
  end;
end;

end.
