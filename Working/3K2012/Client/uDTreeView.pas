unit uDTreeView;

interface
uses Classes, DWinCtl, uDControls, Controls, DXDraws, uDScrollBar, Types, Graphics, Wil;

type
  TDTreeView = class;
  TDTreeNode = class;
  TTreeNodeEventEvent = procedure(Sender: TObject; TreeNode: TDTreeNode) of object;
  TDTreeNode = class
  private
    FOwner: TDTreeView;
    FParent: TDTreeNode;

    FList: TList;
    FCaption: string;

    FStyle: TButtonStyle;
    FChecked: Boolean;
    FExpand: Boolean;
    FLevel: Integer;
    FIndex: Integer;

    FClickSound: TClickSound;
    FOnClick: TOnClickEx;
    FOnClickSound: TOnClickSound;

    procedure SetCaption(Value: string);
    procedure SetExpand(Value: Boolean);
    procedure SetChecked(Value: Boolean);
    function GetLevel: Integer;
    function GetItem(Index: Integer): TDTreeNode;
    function GetCount: Integer;
  public
    Data: Pointer;
    CaptionColor: TDCaptionColor;
    MouseDowned: Boolean;
    MouseMoveed: Boolean;
    constructor Create();
    destructor Destroy(); override;
    property List: TList read FList;
    property Owner: TDTreeView read FOwner write FOwner;
    property Parent: TDTreeNode read FParent write FParent;
    property Caption: string read FCaption write SetCaption;
    property Style: TButtonStyle read FStyle write FStyle;
    property Expand: Boolean read FExpand write SetExpand;
    property Checked: Boolean read FChecked write SetChecked;
    property ClickCount: TClickSound read FClickSound write FClickSound;
    property OnClickSound: TOnClickSound read FOnClickSound write FOnClickSound;
    property Items[Index: Integer]: TDTreeNode read GetItem;
    property Count: Integer read GetCount;
    property Level: Integer read GetLevel;
    procedure Add(Item: TDTreeNode); overload;
    procedure Add(TreeNodeList: TList); overload;
    procedure Delete(Item: TDTreeNode);
    procedure Clear;
    function IndexOf(Item: TDTreeNode): Integer;
    function ExpandCount: Integer;
  end;

  TDTreeView = class(TDControl)
  private
    FHScrollBar: TDScrollBar;
    FList: TList;
    FTreeNodeList: TList;
    FOnSelect: TTreeNodeEventEvent;
    function GetItem(Index: Integer): TDTreeNode;
    function Get(Index: Integer): TDTreeNode;
    function GetCount: Integer;
    procedure SetHScrollBar(Value: TDScrollBar);
  protected
  public
    unfoldImg: Integer; //Õ¹¿ªÍ¼Æ¬
    shrinkImg: Integer; //ÊÕËõÍ¼Æ¬
    WWLib: TWMImages;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure DirectPaint (dsurface: TDirectDrawSurface); override;
    function  Click (X, Y: integer): Boolean; override;
    function MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseMove(Shift: TShiftState; X, Y: Integer): Boolean; override;
    function MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer): Boolean; override;
    property Items[Index: Integer]: TDTreeNode read GetItem;
    property Indexs[Index: Integer]: TDTreeNode read Get;
    property Count: Integer read GetCount;
    procedure Add(Item: TDTreeNode);
    procedure Delete(Item: TDTreeNode);
    procedure Clear;
    procedure RefTreeNodeList();
    function IndexOf(Item: TDTreeNode): Integer;
  published
    property OnSelect: TTreeNodeEventEvent read FOnSelect write FOnSelect;
    property HScrollBar: TDScrollBar read FHScrollBar write SetHScrollBar;
    property TreeNodeList: TList read FTreeNodeList;
  end;

procedure Register;
implementation
uses Math;

procedure Register;
begin
   RegisterComponents('MirGame', [TDTreeView]);
end;
{ TDTreeNode }

procedure TDTreeNode.Add(TreeNodeList: TList);
var
  I: Integer;
  TreeNode: TDTreeNode;
begin
  if Expand then begin
    TreeNodeList.Add(Self);
    for I := 0 to FList.Count - 1 do begin
      TreeNode := TDTreeNode(FList.Items[I]);
      if TreeNode.Expand then
        TreeNode.Add(TreeNodeList)
      else
        TreeNodeList.Add(TreeNode);
    end;
  end;
end;

procedure TDTreeNode.Add(Item: TDTreeNode);
begin
  FList.Add(Item);
  Item.Owner := Owner;
  Item.Parent := Self;
  Item.Expand := True;
  if (Item.Parent = nil) or Item.Parent.Expand then
    Owner.RefTreeNodeList();
end;

procedure TDTreeNode.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do begin
    TDTreeNode(FList.Items[I]).Free;
  end;
  FList.Clear;
  Owner.RefTreeNodeList();
end;

constructor TDTreeNode.Create;
begin
  FOwner := nil;
  FParent := nil;

  FCaption := '';

  FStyle := bsRadio;
  FChecked := False;
  FExpand := False;
  FLevel := 0;
  FIndex := 0;

  FClickSound := csNone;
  FOnClick := nil;
  FOnClickSound := nil;

  MouseDowned := False;
  MouseMoveed := False;

  FList := TList.Create;
  CaptionColor := TDCaptionColor.Create;
end;

procedure TDTreeNode.Delete(Item: TDTreeNode);
begin
  FList.Remove(Item);
end;

destructor TDTreeNode.Destroy;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    TDTreeNode(FList.Items[I]).Free;
  FList.Free;
  CaptionColor.Free;
  inherited;
end;

function TDTreeNode.ExpandCount: Integer;
var
  I: Integer;
  TreeNode: TDTreeNode;
begin
  Result := 1;
  if Expand then begin
    Inc(Result, Count);
    for I := 0 to FList.Count - 1 do begin
      TreeNode := TDTreeNode(FList.Items[I]);
      Inc(Result, TreeNode.ExpandCount);
    end;
  end;
end;

function TDTreeNode.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDTreeNode.GetItem(Index: Integer): TDTreeNode;
begin
  if (Index >= 0) and (Index < FList.Count) then
    Result := FList.Items[Index]
  else
    Result := nil;
end;

function TDTreeNode.GetLevel: Integer;
var
  P: TDTreeNode;
begin
  Result := 0;
  P := Parent;
  while True do begin
    if P = nil then break;
    P := P.Parent;
    Inc(Result);
  end;
end;

function TDTreeNode.IndexOf(Item: TDTreeNode): Integer;
begin
  Result := FList.IndexOf(Item);
end;

procedure TDTreeNode.SetCaption(Value: string);
begin
  if FCaption <> Value then
    FCaption := Value;
end;

procedure TDTreeNode.SetChecked(Value: Boolean);
var
  I: Integer;
begin
  if FChecked <> Value then begin
    FChecked := Value;
    {if Parent = nil then begin

    end else begin
      for I := 0 to FList.Count - 1 do begin
        TreeNode := TDxTreeNode(FList.Items[I]);
        TreeNode.Checked := Value;
      end;
    end;}
  end;
end;

procedure TDTreeNode.SetExpand(Value: Boolean);
var
  I: Integer;
  TreeNode: TDTreeNode;
begin
  if FExpand <> Value then begin
    if FList.Count > 0 then
      FExpand := Value
    else
      FExpand := True;
    if not FExpand then begin
      for I := 0 to FList.Count - 1 do begin
        TreeNode := TDTreeNode(FList.Items[I]);
        TreeNode.MouseDowned := False;
        TreeNode.MouseMoveed := False;
        //TreeNode.Expand := Value;
        TreeNode.Checked := Value;
      end;
    end;
    Owner.RefTreeNodeList();
  end;
end;



{ TDTreeView }

procedure TDTreeView.Add(Item: TDTreeNode);
begin
  FList.Add(Item);
  Item.Owner := Self;
  Item.Parent := nil;
  //Item.Expand := True;
  RefTreeNodeList();
end;

procedure TDTreeView.Clear;
var
  I: Integer;
  TreeNode: TDTreeNode;
begin
  for I := 0 to FList.Count - 1 do begin
    Items[I].Free;
  end;
  FList.Clear;
  FHScrollBar.Position := 0;
  FHScrollBar.MaxValue := 16;
  RefTreeNodeList();
end;

function TDTreeView.Click(X, Y: integer): Boolean;
var
  I: Integer;
  nWidth: Integer;
  nLeft: Integer;
  nRow: Integer;
  vRect: TRect;
  TreeNode: TDTreeNode;
begin
  Result := False;
  if inherited Click(X, Y) then begin
    Result := True;
    nRow := (Y - GTop) div FHScrollBar.ItemHeight + FHScrollBar.Position div FHScrollBar.ItemHeight;
    TreeNode := Indexs[nRow];
    if TreeNode <> nil then begin
      nLeft := (TreeNode.Level + 1) * MainForm.Canvas.TextWidth('0') * 2;
      TreeNode.Expand := not TreeNode.Expand;
      RefTreeNodeList();
      case TreeNode.Style of
        bsRadio: begin
          if not TreeNode.Checked then begin
            for I := 0 to TreeNodeList.Count - 1 do begin
              TDTreeNode(TreeNodeList.Items[I]).Checked := False;
            end;
            TreeNode.Checked := True;
          end;
        end;
        bsCheckBox: begin
          TreeNode.Checked := not TreeNode.Checked;
        end;
      end;
      if Assigned(FOnSelect) then FOnSelect(Self, TreeNode);
    end;
  end;
end;

constructor TDTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList := TList.Create;
  FTreeNodeList := TList.Create;
  FOnSelect := nil;
  WWLib := nil;
  unfoldImg := 0; //Õ¹¿ªÍ¼Æ¬
  shrinkImg := 0; //ÊÕËõÍ¼Æ¬
end;

procedure TDTreeView.Delete(Item: TDTreeNode);
begin
  FList.Remove(Item);
end;

destructor TDTreeView.Destroy;
var
  I: Integer;
  TreeNode: TDTreeNode;
begin
  for I := 0 to FList.Count - 1 do begin
    Items[I].Free;
  end;
  FList.Free;
  TreeNodeList.Free;
  inherited Destroy();
end;

procedure TDTreeView.DirectPaint(dsurface: TDirectDrawSurface);
var
  I, II, III, nIndex, {nCount,} nLeft, nTop, n01: Integer;
  X1, Y1, X2, Y2, nHeight, nWidth: Integer;
  FaceIndex: Integer;
  nMaxValue: Integer;
  nBarTop: Integer;
  D: TDirectDrawSurface;
  vtRect: TRect;
  vbRect: TRect;
  PaintRect: TRect;
  TreeNode: TDTreeNode;
  OldSize: Integer;
  OldFontName: TFontName;
  OldStyle: TFontStyles;
  Font: TDFont;
begin
  if Assigned (OnDirectPaint) then
    OnDirectPaint (self, dsurface)
  else begin
      nTop := 0;
      n01 := 0;
      nIndex := FHScrollBar.Position div FHScrollBar.ItemHeight;
      nMaxValue := GHeight div FHScrollBar.ItemHeight;

      //nCount := Min(nMaxValue, TreeNodeList.Count - 1);
      for I := nIndex to {nCount}TreeNodeList.Count - 1 do begin
        TreeNode := TreeNodeList[I];

        if TreeNode.Expand then begin //¡ú
          nHeight := MainForm.Canvas.TextHeight('0');
          nWidth := MainForm.Canvas.TextWidth('0') - 3;
          X1 := TreeNode.Level * (MainForm.Canvas.TextWidth('0')) * 2; //TreeNode.Level * nWidth;
          Y1 := nTop + (FHScrollBar.ItemHeight - nHeight) div 2;
          X2 := X1 + nWidth; 
          Y2 := nTop + FHScrollBar.ItemHeight div 2;
            if WWLib <> nil then begin
              d := WWLib.Images[unfoldImg];
              if d <> nil then begin
                dsurface.Draw(SurfaceX(GLeft+X1), SurfaceY(GTop+Y1), d.ClientRect, d, True);
              end;
            end;
        end else begin //¡ý
          nWidth := MainForm.Canvas.TextWidth('0') + 1;
          nHeight := MainForm.Canvas.TextHeight('0') - 4;

          X1 := TreeNode.Level * (MainForm.Canvas.TextWidth('0')) * 2; //TreeNode.Level * nWidth;
          Y1 := nTop + (FHScrollBar.ItemHeight - nHeight) div 2;
          X2 := X1 + nWidth div 2;
          Y2 := nTop + FHScrollBar.ItemHeight div 2 + nHeight;
            if WWLib <> nil then begin
              d := WWLib.Images[shrinkImg];
              if d <> nil then begin
                dsurface.Draw(SurfaceX(GLeft+X1), SurfaceY(GTop+Y1), d.ClientRect, d, True);
              end;
            end;
        end;

        nLeft := (TreeNode.Level + 1) * (MainForm.Canvas.TextWidth('0')) * 2;
        if TreeNode.Caption <> '' then begin
          OldSize := MainForm.Canvas.Font.Size;
          OldFontName := MainForm.Canvas.Font.Name;
          OldStyle := MainForm.Canvas.Font.Style;
          if TreeNode.Checked then begin
            Font := TreeNode.CaptionColor.Down;
          end else begin
            if TreeNode.MouseDowned then begin
              Font := TreeNode.CaptionColor.Down;
            end else
              if TreeNode.MouseMoveed then begin
              Font := TreeNode.CaptionColor.Hot;
            end else begin
              Font := TreeNode.CaptionColor.Up;
            end;
          end;

          MainForm.Canvas.Font.Size := Font.Size;
          if Font.Name <> '' then
            MainForm.Canvas.Font.Name := Font.Name;
          MainForm.Canvas.Font.Style := Font.Style;

          if Font.Bold then
            DSurface.BoldTextOut(SurfaceX(GLeft+nLeft), SurfaceY(GTop+nTop) + (FHScrollBar.ItemHeight - MainForm.Canvas.TextHeight('0')) div 2, Font.Color, Font.BColor, TreeNode.Caption)
          else
            DSurface.TextOut(SurfaceX(GLeft+nLeft), SurfaceY(GTop+nTop) + (FHScrollBar.ItemHeight - MainForm.Canvas.TextHeight('0')) div 2, Font.Color, TreeNode.Caption);

          MainForm.Canvas.Font.Size := OldSize;
          MainForm.Canvas.Font.Name := OldFontName;
          MainForm.Canvas.Font.Style := OldStyle;
        end;
        Inc(n01);
        Inc(nTop, FHScrollBar.ItemHeight);
        if n01 >= nMaxValue then break;
      end;

      if WLib <> nil then begin
        if FaceIndex >= 0 then begin
          D := WLib.Images[FaceIndex];
          if D <> nil then begin
            DSurface.StretchDraw(DSurface.ClientRect, D, True);
          end;
        end;
      end;
  if DControls.Count > 0 then //20080629
  for i:=0 to DControls.Count-1 do
    if TDControl(DControls[i]).Visible then
      TDControl(DControls[i]).DirectPaint (dsurface);
  end;
end;

function TDTreeView.Get(Index: Integer): TDTreeNode;
begin
  if (Index >= 0) and (Index < TreeNodeList.Count) then
    Result := TreeNodeList[Index]
  else
    Result := nil;
end;

function TDTreeView.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TDTreeView.GetItem(Index: Integer): TDTreeNode;
begin
  if (Index >= 0) and (Index < FList.Count) then
    Result := FList.Items[Index]
  else
    Result := nil;
end;

function TDTreeView.IndexOf(Item: TDTreeNode): Integer;
var
  D, P: TDTreeNode;
begin
  Result := -1;
  if Item.Parent = nil then
    Result := FList.IndexOf(Item)
  else begin
    D := Item;
    P := D.Parent;

    Result := P.List.IndexOf(D) + 1;

    D := P;
    P := P.Parent;

    while True do begin
      if P.Parent = nil then begin
        Inc(Result, FList.IndexOf(P) + 1);
        break;
      end else begin
        Inc(Result, P.Count);
      end;
      D := P;
      P := P.Parent;
      if P = nil then break;
    end;
  end;
end;

function TDTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  I: Integer;
  nLeft: Integer;
  nRow: Integer;
  vRect: TRect;
  TreeNode: TDTreeNode;
begin
  Result := False;
  if inherited MouseDown(Button, Shift, X, Y) then begin
    if (not Background) and (MouseCaptureControl=nil) then begin
      RefTreeNodeList();
      nRow := (Y - GTop) div FHScrollBar.ItemHeight + FHScrollBar.Position div FHScrollBar.ItemHeight;
      TreeNode := Indexs[nRow];

      if TreeNode <> nil then begin
        nLeft := (TreeNode.Level + 1) * MainForm.Canvas.TextWidth('0') * 2;
          for I := 0 to TreeNodeList.Count - 1 do begin
            TDTreeNode(TreeNodeList.Items[I]).MouseDowned := False;
            TDTreeNode(TreeNodeList.Items[I]).MouseMoveed := False;
          end;
          TreeNode.MouseDowned := True;
          TreeNode.MouseMoveed := False;
      end;
      SetDCapture (self);
    end;
    Result := True;
  end;
end;

function TDTreeView.MouseMove(Shift: TShiftState; X, Y: Integer): Boolean;
var
  I: Integer;
  nLeft: Integer;
  nRow: Integer;
  vRect: TRect;
  TreeNode: TDTreeNode;
begin
  Result := inherited MouseMove (Shift, X, Y);
  if (not Background) and (not Result) then begin
    Result := inherited MouseMove (Shift, X, Y);
  end else if InRange(x, y) then begin
    nRow := (Y - GTop) div FHScrollBar.ItemHeight + FHScrollBar.Position div FHScrollBar.ItemHeight;
    TreeNode := Indexs[nRow];
    if TreeNode <> nil then begin
      nLeft := (TreeNode.Level + 1) * MainForm.Canvas.TextWidth('0') * 2;
      for I := 0 to TreeNodeList.Count - 1 do begin
        TDTreeNode(TreeNodeList.Items[I]).MouseMoveed := False;
      end;
      TreeNode.MouseMoveed := True;
      Exit;
    end;
  end;
  {Result := False;
  if inherited MouseMove(Shift, X, Y) then begin
    Result := True;
    if not (FPrevMouseMove and FNextMouseMove and FBarMouseMove) then begin
      vRect := VirtualRect;

      nRow := (Y - vRect.GTop) div ItemHeight + Position div ItemHeight;
      TreeNode := Indexs[nRow];

      if TreeNode <> nil then begin
        nLeft := (TreeNode.Level + 1) * ImageCanvas.TextWidth('0') * 2;
        vRect.GLeft := vRect.GLeft + nLeft;
        vRect.Right := vRect.Right - FScrollSize;
        if PointInRect(Point(X, Y), vRect) then begin
          //TreeNode.MouseDowned := True;
          for I := 0 to TreeNodeList.Count - 1 do begin
            //TDxTreeNode(TreeNodeList.Items[I]).MouseDowned := False;
            TDxTreeNode(TreeNodeList.Items[I]).MouseMoveed := False;
          end;
          TreeNode.MouseMoveed := True;
          Exit;
        end;
      end;
    end;
  end;
  for I := 0 to TreeNodeList.Count - 1 do begin
            //TDxTreeNode(TreeNodeList.Items[I]).MouseDowned := False;
    TDxTreeNode(TreeNodeList.Items[I]).MouseMoveed := False;
  end;  }
end;

function TDTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer): Boolean;
var
  I: Integer;
  nLeft: Integer;
  nRow: Integer;
  vRect: TRect;
  TreeNode: TDTreeNode;
begin
  Result := False;
  if inherited MouseUp(Button, Shift, X, Y) then begin
    ReleaseDCapture;
    Result := True;
    nRow := (Y - GTop) div FHScrollBar.ItemHeight + FHScrollBar.Position div FHScrollBar.ItemHeight;
    TreeNode := Indexs[nRow];

    if TreeNode <> nil then begin
      nLeft := (TreeNode.Level + 1) * MainForm.Canvas.TextWidth('0') * 2;
      //MouseDowned := False;
      //MouseMoveed := False;
      for I := 0 to TreeNodeList.Count - 1 do begin
        TDTreeNode(TreeNodeList.Items[I]).MouseDowned := False;
        TDTreeNode(TreeNodeList.Items[I]).MouseMoveed := False;
      end;
      Exit;
    end;
  end else ReleaseDCapture;
  //MouseDowned := False;
  //MouseMoveed := False;
end;

procedure TDTreeView.RefTreeNodeList;
var
  I: Integer;
  TreeNode: TDTreeNode;
begin
  TreeNodeList.Clear;
  for I := 0 to FList.Count - 1 do begin
    TreeNode := Items[I];
    TreeNode.Add(TreeNodeList);
    if not TreeNode.Expand then
      TreeNodeList.Add(TreeNode);
  end;
  FHScrollBar.MaxValue := TreeNodeList.Count * FHScrollBar.ItemHeight + FHScrollBar.ItemHeight;
end;

procedure TDTreeView.SetHScrollBar(Value: TDScrollBar);
begin
  FHScrollBar := Value;
end;

end.
