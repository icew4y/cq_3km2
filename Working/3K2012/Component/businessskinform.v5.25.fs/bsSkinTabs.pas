{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 5.25                                                }
{                                                                   }
{       Copyright (c) 2000-2006 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsSkinTabs;

{$P+,S-,W-,R-}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, StdCtrls,
     CommCtrl, ComCtrls, ExtCtrls, bsSkinData, bsSkinBoxCtrls;
type

  TbsSkinCustomTabSheet = class(TTabSheet)
  private
    FWallPaper: TBitMap;
  protected
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetWallPaper(Value: TBitmap);
  public
    procedure PaintBG(DC: HDC);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property WallPaper: TBitMap read FWallPaper write SetWallPaper;
  end;

  TbsSkinTabSheet = class(TbsSkinCustomTabSheet)
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;


  TbsDrawSkinTabEvent = procedure(TabIndex: Integer; const Rct: TRect; Active,
    MouseIn: Boolean; Cnvs: TCanvas) of object;

  TbsSkinPageControl = class(TPageControl)
  private
    FTabsBGTransparent: Boolean;
    FActiveTab, FOldActiveTab: Integer;
    FActiveTabIndex, FOldActiveTabIndex: Integer;
    FOnDrawSkinTab: TbsDrawSkinTabEvent;
    function GetPosition: Integer;
    function  GetInVisibleItemCount: Integer;
    procedure OnUpDownChange(Sender: TObject);
    procedure DrawTabs(Cnvs: TCanvas);
    procedure DrawTab(TI: Integer; const Rct: TRect; Active, MouseIn: Boolean; Cnvs: TCanvas);
    function GetItemRect(index: integer): TRect;
    procedure SetItemSize(AWidth, AHeight: integer);
    procedure CheckScroll;
    procedure ShowSkinUpDown;
    procedure HideSkinUpDown;
    procedure TestActive(X, Y: Integer);
    procedure SetTabsBGTransparent(Value: Boolean);
    procedure DrawEmptyBackGround(DC: HDC);
  protected
    //
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FSkinUpDown: TbsSkinUpDown;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultItemHeight: Integer;
    procedure SetDefaultItemHeight(Value: Integer);
    procedure SetDefaultFont(Value: TFont);
    procedure Change; override;
    procedure Change2;
    procedure GetSkinData;
    //
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMHSCROLL(var Msg: TWMEraseBkGnd); message WM_HSCROLL;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure PaintDefaultWindow(Cnvs: TCanvas);
    procedure PaintSkinWindow(Cnvs: TCanvas);
    procedure PaintWindow(DC: HDC); override;
    procedure WndProc(var Message:TMessage); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
  public
    //
    Picture: TBitMap;
    SkinRect, ClRect, TabRect,
    ActiveTabRect, FocusTabRect, MouseInTabRect: TRect;
    TabsBGRect: TRect;
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    TabLeftOffset, TabRightOffset: Integer;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, FocusFontColor, MouseInFontColor: TColor;
    UpDown: String;
    BGPictureIndex: Integer;
    TabStretchEffect: Boolean;
    ShowFocus: Boolean;
    FocusOffsetX, FocusOffsetY: Integer;
    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure Loaded; override;
    procedure UpDateTabs;
  published
    property TabsBGTransparent: Boolean read FTabsBGTransparent write SetTabsBGTransparent;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultItemHeight: Integer read FDefaultItemHeight write SetDefaultItemHeight;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Color;
    property ActivePage;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HotTrack;
    property Images;
    property OwnerDraw;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RaggedRight;
    property ScrollOpposite;
    property ShowHint;
    property TabHeight;
    property TabOrder;
    property TabPosition;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnChange;
    property OnDrawSkinTab: TbsDrawSkinTabEvent
      read FOnDrawSkinTab write FOnDrawSkinTab; 
    property OnChanging;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawTab;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TbsSkinTabControl = class(TTabControl)
  private
    FTabsBGTransparent: Boolean;
    FOnDrawSkinTab: TbsDrawSkinTabEvent;
    FromWMPaint: Boolean;
    FOldTop, FOldBottom: Integer;
    FActiveTab, FOldActiveTab: Integer;
    function GetPosition: Integer;
    function  GetInVisibleItemCount: Integer;
    procedure OnUpDownChange(Sender: TObject);
    procedure DrawTabs(Cnvs: TCanvas);
    procedure DrawTab(TI: Integer; const Rct: TRect; Active, MouseIn: Boolean; Cnvs: TCanvas);
    function GetItemRect(index: integer): TRect;
    procedure SetItemSize(AWidth, AHeight: integer);
    procedure CheckScroll;
    procedure ShowSkinUpDown;
    procedure HideSkinUpDown;
    procedure TestActive(X, Y: Integer);
    procedure SetTabsBGTransparent(Value: Boolean);
  protected
    //
    FSD: TbsSkinData;
    FSkinDataName: String;
    FIndex: Integer;
    FSkinUpDown: TbsSkinUpDown;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FDefaultItemHeight: Integer;

    procedure SetDefaultItemHeight(Value: Integer);
    procedure SetDefaultFont(Value: TFont);
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure GetSkinData;
    //
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetSkinData(Value: TbsSkinData);
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMHSCROLL(var Msg: TWMEraseBkGnd); message WM_HSCROLL;
    procedure PaintDefaultWindow(Cnvs: TCanvas);
    procedure PaintSkinWindow(Cnvs: TCanvas);
    procedure PaintWindow(DC: HDC); override;
    procedure WndProc(var Message:TMessage); override;
    procedure Change; override;
    procedure Change2;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public

    Picture: TBitMap;
    SkinRect, ClRect, TabRect,
    ActiveTabRect, FocusTabRect, MouseInTabRect: TRect;
    TabsBGRect: TRect;
    LTPoint, RTPoint, LBPoint, RBPoint: TPoint;
    TabLeftOffset, TabRightOffset: Integer;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    FontColor, ActiveFontColor, FocusFontColor, MouseInFontColor: TColor;
    UpDown: String;
    BGPictureIndex: Integer;
    TabStretchEffect: Boolean;
    LeftStretch, TopStretch, RightStretch, BottomStretch: Boolean;
    ShowFocus: Boolean;
    FocusOffsetX, FocusOffsetY: Integer;
    //
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ChangeSkinData;
    procedure Loaded; override;
    procedure UpDateTabs;
    //
    procedure PaintBG(DC: HDC);
    //
  published
    property TabsBGTransparent: Boolean read FTabsBGTransparent write SetTabsBGTransparent;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultItemHeight: Integer read FDefaultItemHeight write SetDefaultItemHeight;
    property SkinData: TbsSkinData read FSD write SetSkinData;
    property SkinDataName: String read FSkinDataName write FSkinDataName;
    property Color;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HotTrack;
    property Images;
    property OwnerDraw;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RaggedRight;
    property ScrollOpposite;
    property ShowHint;
    property TabHeight;
    property TabOrder;
    property TabPosition;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnDrawSkinTab: TbsDrawSkinTabEvent
      read FOnDrawSkinTab write FOnDrawSkinTab;
    property OnChange;
    property OnChanging;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawTab;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

uses Consts, ComStrs, bsUtils, ImgList, BusinessSkinForm, bsEffects;


procedure DrawRotate90_1(Cnvs: TCanvas; B: TBitMap; X, Y: Integer);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Height, B1.Width);
  B1.Rotate90_1(B2);
  B2.Draw(Cnvs.Handle, X, Y);
  B1.Free;
  B2.Free;
end;

procedure DrawFlipVert(B: TBitMap);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Width, B1.Height);
  B1.FlipVert(B2);
  B2.Draw(B.Canvas.Handle, 0, 0);
  B1.Free;
  B2.Free;
end;

procedure DrawRotate90_2(Cnvs: TCanvas; B: TBitMap; X, Y: Integer);
var
  B1, B2: TbsEffectBmp;
begin
  B1 := TbsEffectBmp.CreateFromhWnd(B.Handle);
  B2 := TbsEffectBmp.Create(B1.Height, B1.Width);
  B1.Rotate90_2(B2);
  B2.Draw(Cnvs.Handle, X, Y);
  B1.Free;
  B2.Free;
end;

procedure DrawTabGlyphAndText(Cnvs: TCanvas; W, H: Integer; S: String;
                              IM: TCustomImageList; IMIndex: Integer;
                              AEnabled: Boolean);

var
  R, TR: TRect;
  GX, GY, GW, GH, TW, TH: Integer;
begin
  R := Rect(0, 0, 0, 0);
  DrawText(Cnvs.Handle, PChar(S), Length(S), R, DT_CALCRECT);
  TW := RectWidth(R) + 2;
  TH := RectHeight(R);
  GW := IM.Width;
  GH := IM.Height;
  GX := W div 2 - (GW + TW + 2) div 2;
  GY := H div 2 - GH div 2;
  TR.Left := GX + GW + 2;
  TR.Top := H div 2 - TH div 2;
  TR.Right := TR.Left + TW;
  TR.Bottom := TR.Top + TH;
  DrawText(Cnvs.Handle, PChar(S), Length(S), TR, DT_CENTER);
  IM.Draw(Cnvs, GX, GY, IMIndex, AEnabled);
end;

constructor TbsSkinCustomTabSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  Visible := False;
  FWallPaper := TBitMap.Create;
end;

procedure TbsSkinCustomTabSheet.SetWallPaper(Value: TBitmap);
begin
  FWallPaper.Assign(Value);
  if (csDesigning in ComponentState) then RePaint;
end;


procedure TbsSkinCustomTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
    with Params.WindowClass do
      Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

destructor TbsSkinCustomTabSheet.Destroy;
begin
  PageControl := nil;
  FWallPaper.Free;
  inherited Destroy;
end;

procedure TbsSkinCustomTabSheet.WMEraseBkGnd;
begin
  PaintBG(Msg.DC);
end;

procedure TbsSkinCustomTabSheet.WMSize;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinCustomTabSheet.PaintBG;
var
  C: TCanvas;
  TabSheetBG: TBitMap;
  PC: TbsSkinPageControl;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
begin
  if (Width <= 0) or (Height <=0) then Exit;
  PC := TbsSkinPageControl(Parent);
  if PC = nil then Exit;
  PC.GetSkinData;
  C := TCanvas.Create;
  C.Handle := DC;

  
  if not FWallPaper.Empty
  then
    begin
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div FWallPaper.Width;
          YCnt := Height div FWallPaper.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(X * FWallPaper.Width, Y * FWallPaper.Height, FWallPaper);
        end;
      C.Free;
      Exit;
    end;

  if (PC.FSD <> nil) and (not PC.FSD.Empty) and
     (PC.FIndex <> -1) and (PC.BGPictureIndex <> -1)
  then
    begin
      TabSheetBG := TBitMap(PC.FSD.FActivePictures.Items[PC.BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div TabSheetBG.Width;
          YCnt := Height div TabSheetBG.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(X * TabSheetBG.Width, Y * TabSheetBG.Height, TabSheetBG);
        end;
      C.Free;
      Exit;
    end;
 
  w1 := Width;
  h1 := Height;

  if PC.FIndex <> -1
  then
    with PC do
    begin
      TabSheetBG := TBitMap.Create;
      TabSheetBG.Width := RectWidth(ClRect);
      TabSheetBG.Height := RectHeight(ClRect);
      TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
        PC.Picture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
      XCnt := w1 div w;
      YCnt := h1 div h;
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
        C.Draw(X * w, Y * h, TabSheetBG);
      TabSheetBG.Free;
    end
  else
  with C do
  begin
    Brush.Color := clbtnface;
    FillRect(Rect(0, 0, w1, h1));
  end;
  C.Free;
end;


{TTabSheetes}
constructor TbsSkinTabSheet.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

destructor TbsSkinTabSheet.Destroy;
begin
  inherited Destroy;
end;

procedure TbsSkinTabSheet.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

{ TbsSkinPageControl }

constructor TbsSkinPageControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTabsBGTransparent := False;
  Ctl3D := False;
  FIndex := -1;
  Picture := nil;
  Font.Name := '宋体';
  Font.Charset := GB2312_CHARSET;
  Font.Style := [];
  Font.Color := clBtnText;
  Font.Height := -12;
  FSkinUpDown := nil;
  FSkinDataName := 'tab';
  FDefaultFont := TFont.Create;
  FDefaultFont.Name := '宋体';
  FDefaultFont.Charset := GB2312_CHARSET;
  FDefaultFont.Style := [];
  FDefaultFont.Color := clBtnText;
  FDefaultFont.Height := -12;
  FDefaultItemHeight := 20;
  FActiveTab := -1;
  FOldActiveTab := -1;
  FActiveTabIndex := -1;
  FOldActiveTabIndex := -1;
  FUseSkinFont := False;
end;

destructor TbsSkinPageControl.Destroy;
begin
  FDefaultFont.Free;
  inherited Destroy;
end;

procedure TbsSkinPageControl.DrawEmptyBackGround(DC: HDC);
var
  C: TCanvas;
  TabSheetBG: TBitMap;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
begin
  if (Width <= 0) or (Height <=0) then Exit;

  C := TCanvas.Create;
  C.Handle := DC;

  if BGPictureIndex <> -1
  then
    begin
      TabSheetBG := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div TabSheetBG.Width;
          YCnt := Height div TabSheetBG.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
            C.Draw(X * TabSheetBG.Width, Y * TabSheetBG.Height, TabSheetBG);
        end;
    end
 else
   begin
     w1 := Width;
     h1 := Height;
     TabSheetBG := TBitMap.Create;
     TabSheetBG.Width := RectWidth(ClRect);
     TabSheetBG.Height := RectHeight(ClRect);
     TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
       Picture.Canvas,
        Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
             SkinRect.Left + ClRect.Right,
             SkinRect.Top + ClRect.Bottom));
     w := RectWidth(ClRect);
     h := RectHeight(ClRect);
     XCnt := w1 div w;
     YCnt := h1 div h;
     for X := 0 to XCnt do
     for Y := 0 to YCnt do
       C.Draw(X * w, Y * h, TabSheetBG);
     TabSheetBG.Free;
   end;
  C.Free;
end;


procedure TbsSkinPageControl.SetTabsBGTransparent(Value: Boolean);
begin
  if FTabsBGTransparent <> Value
  then
    begin
      FTabsBGTransparent := Value;
      Invalidate;
    end;
end;

procedure TbsSkinPageControl.UpDateTabs;
begin
  if FIndex <> -1
  then
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, RectHeight(TabRect))
      else
        SetItemSize(TabWidth, TabHeight);
    end
  else
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
    end;
  if MultiLine and (FSkinUpDown <> nil)
  then
    HideSkinUpDown;
  ReAlign;
end;

procedure TbsSkinPageControl.CMMouseLeave;
var
  R: TRect;
begin
  if (FOldActiveTabIndex <> - 1) and (FOldActiveTabIndex <> TabIndex) and
     (FOldActiveTabIndex < PageCount)
  then
    begin
      R := GetItemRect(FOldActiveTabIndex);
      DrawTab(FOldActiveTab, R, False, False, Canvas);
      FOldActiveTabIndex := -1;
      FOldActiveTab := -1;
    end;

  if (FActiveTabIndex <> - 1) and (FActiveTabIndex <> TabIndex) and
     (FActiveTabIndex < PageCount)
  then
    begin
      R := GetItemRect(FActiveTabIndex);
      DrawTab(FActiveTab, R, False, False, Canvas);
      FActiveTabIndex := -1;
      FActiveTab := -1;
    end;
end;

procedure TbsSkinPageControl.MouseDown;
begin
  inherited;
  if (Button = mbLeft) and not (csDesigning in ComponentState)
  then
    TestActive(X, Y);
end;

procedure TbsSkinPageControl.MouseMove;
begin
 inherited;
 if  not (csDesigning in ComponentState)
 then
   TestActive(X, Y);
end;

procedure TbsSkinPageControl.SetDefaultItemHeight;
begin
  FDefaultItemHeight := Value;
  if FIndex = -1
  then
    begin
      SetItemSize(TabWidth, FDefaultItemHeight);
      Change2;
      ReAlign;
    end;
end;


procedure TbsSkinPageControl.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinPageControl.OnUpDownChange(Sender: TObject);
begin
  FSkinUpDown.Max := GetInVisibleItemCount;
  SendMessage(Handle, WM_HSCROLL,
    MakeWParam(SB_THUMBPOSITION, FSkinUpDown.Position), 0);
end;

function TbsSkinPageControl.GetPosition: Integer;
var
  i, j, k: Integer;
  R: TRect;
begin
  j := 0;
  k := -1;
  for i := 0 to PageCount - 1 do
  if Pages[i].TabVisible then
  begin
    inc(k);
    R := GetItemRect(k);
    if R.Right <= 0 then inc(j);
  end;
  Result := j;
end;

function TbsSkinPageControl.GetInVisibleItemCount;
var
  i, j, k: Integer;
  R: TRect;
  Limit: Integer;
begin
  if FSkinUpDown = nil
  then
    Limit := Width - 3
  else
    Limit := Width - FSkinUpDown.Width - 3;
  j := 0;
  k := -1;
  for i := 0 to PageCount - 1 do
  if Pages[i].TabVisible
  then
  begin
    inc(k);
    R := GetItemRect(k);
    if (R.Right > Limit) or (R.Right <= 0)
    then inc(j);
  end;
  Result := j;
end;

procedure TbsSkinPageControl.CheckScroll;
var
  Wnd: HWND;
  InVCount: Integer;
begin
  Wnd := FindWindowEx(Handle, 0, 'msctls_updown32', nil);
  if Wnd <> 0 then DestroyWindow(Wnd);
  InVCount := GetInVisibleItemCount;
  if ((InVCount = 0) or MultiLine) and (FSkinUpDown <> nil)
  then
    HideSkinUpDown
  else
  if (InVCount > 0) and (FSkinUpDown = nil)
  then
    ShowSkinUpDown;
  if FSkinUpDown <> nil
  then
    begin
      FSkinUpDown.Max := InVCount;
      FSkinUpDown.Left := Width - FSkinUpDown.Width;
      if TabPosition = tpTop
      then
        FSkinUpDown.Top := 0
      else
       FSkinUpDown.Top := Height - FSkinUpDown.Height;
    end;
end;

procedure TbsSkinPageControl.ShowSkinUpDown;
begin
  FSkinUpDown := TbsSkinUpDown.Create(Self);
  FSkinUpDown.Parent := Self;
  FSkinUpDown.Width := FDefaultItemHeight * 2;
  FSkinUpDown.Height := FDefaultItemHeight;
  FSkinUpDown.Min := 0;
  FSkinUpDown.Max := GetInVisibleItemCount;
  FSkinUpDown.Position := GetPosition;
  FSkinUpDown.Increment := 1;
  FSkinUpDown.OnChange := OnUpDownChange;
  FSkinUpDown.Left := Width - FSkinUpDown.Width;
  if TabPosition = tpTop
  then
    FSkinUpDown.Top := 0
  else
    FSkinUpDown.Top := Height - FSkinUpDown.Height;
  FSkinUpDown.SkinDataName := UpDown;
  FSkinUpDown.SkinData := SkinData;
  FSkinUpDown.Visible := True;
end;

procedure TbsSkinPageControl.HideSkinUpDown;
begin
  FSkinUpDown.Free;
  FSkinUpDown := nil;
end;

procedure TbsSkinPageControl.WMHSCROLL;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinPageControl.WMSize;
begin
  GetSkinData;
  inherited;
end;

procedure TbsSkinPageControl.Change;
begin
  if FSkinUpDown <> nil
  then FSkinUpDown.Position := GetPosition;
  inherited;
  Invalidate;
  if ActivePage <> nil then ActivePage.Invalidate;
end;

procedure TbsSkinPageControl.Change2;
begin
  if FSkinUpDown <> nil
  then FSkinUpDown.Position := GetPosition;
  Invalidate;
end;

procedure TbsSkinPageControl.GetSkinData;
begin
  BGPictureIndex := -1;
  if FSD = nil
  then
    begin
      FIndex := -1;
      Exit;
    end;
  if FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  //
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinTabControl
    then
      with TbsDataSkinTabControl(FSD.CtrlList.Items[FIndex]) do
      begin
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        Self.SkinRect := SkinRect;
        Self.ClRect := ClRect;
        Self.TabRect := TabRect;
        if IsNullRect(ActiveTabRect)
        then
          Self.ActiveTabRect := TabRect
        else
          Self.ActiveTabRect := ActiveTabRect;
        if IsNullRect(FocusTabRect)
        then
          Self.FocusTabRect := ActiveTabRect
        else
          Self.FocusTabRect := FocusTabRect;
        //
        Self.TabsBGRect := TabsBGRect;
        Self.LTPoint := LTPoint;
        Self.RTPoint := RTPoint;
        Self.LBPoint := LBPoint;
        Self.RBPoint := RBPoint;
        Self.TabLeftOffset := TabLeftOffset;
        Self.TabRightOffset := TabRightOffset;
        //
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.ActiveFontColor := ActiveFontColor;
        Self.FocusFontColor := FocusFontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.UpDown := UpDown;
        Self.BGPictureIndex := BGPictureIndex;
        Self.MouseInTabRect := MouseInTabRect;
        Self.MouseInFontColor := MouseInFontColor;
        Self.TabStretchEffect := TabStretchEffect;
        Self.ShowFocus := ShowFocus;
        Self.FocusOffsetX := FocusOffsetX;
        Self.FocusOffsetY := FocusOffsetY;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch;
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
      end;
end;

procedure TbsSkinPageControl.ChangeSkinData;
var
  UpDownVisible: Boolean;
begin
   GetSkinData;
  //
  if FIndex <> -1
  then
    begin
      if FUseSkinFont
      then
        begin
          Font.Name := FontName;
          Font.Height := FontHeight;
          Font.Style := FontStyle;
        end
      else
        Font.Assign(FDefaultFont);

      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet
       else
        Font.CharSet := DefaultFont.CharSet;

      Font.Color := FontColor;
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, RectHeight(TabRect))
      else
        SetItemSize(TabWidth, TabHeight);
    end
  else
    begin
      Font.Assign(FDefaultFont);
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet;

      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
    end;
  //
  Change2;
  ReAlign;
  if FSkinUpDown <> nil
  then
    begin
      HideSkinUpDown;
      CheckScroll;
    end;
  if ActivePage <> nil then ActivePage.RePaint;
end;

procedure TbsSkinPageControl.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinPageControl.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinPageControl.PaintDefaultWindow;
var
  R: TRect;
begin
  with Cnvs do
  begin
    Brush.Color := clBtnFace;
    FillRect(ClientRect);
    R := Self.DisplayRect;
    InflateRect(R, 1, 1);
    Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
  end;
end;

procedure TbsSkinPageControl.PaintSkinWindow;
var
  TOff, LOff, Roff, BOff: Integer;
  NewClRect, DR, R: TRect;
  TBGOffX, TBGOffY, X, Y, XCnt, YCnt, w, h, rw, rh, XO, YO: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  LB, RB, TB, BB, ClB: TBitMap;
  R1, R2: TRect;
begin
  GetSkinData;
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  //
  DR := Self.DisplayRect;
  //
  R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
  XO := RectWidth(R) - RectWidth(SkinRect);
  YO := RectHeight(R) - RectHeight(SkinRect);
  NewLTPoint := LTPoint;
  NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
  NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
  NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
  NewCLRect := Rect(ClRect.Left, ClRect.Top, ClRect.Right + XO, ClRect.Bottom + YO);
  // Draw frame around displayrect
  LB := TBitMap.Create;
  TB := TBitMap.Create;
  RB := TBitMap.Create;
  BB := TBitMap.Create;
  CreateSkinBorderImages(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
     NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
     LB, TB, RB, BB, Picture, SkinRect, RectWidth(R), RectHeight(R),
     LeftStretch, TopStretch, RightStretch, BottomStretch);
  Cnvs.Draw(R.Left, R.Top, TB);
  Cnvs.Draw(R.Left, R.Top + TB.Height, LB);
  Cnvs.Draw(R.Left + RectWidth(R) - RB.Width, R.Top + TB.Height, RB);
  Cnvs.Draw(R.Left, R.Top + RectHeight(R) - BB.Height, BB);
  LB.Free;
  TB.Free;
  RB.Free;
  BB.Free;
end;


procedure TbsSkinPageControl.Loaded;
begin
  inherited Loaded;
  if FIndex = -1
  then
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
      Change2;
      ReAlign;
    end;
end;

procedure TbsSkinPageControl.WMPaint(var Msg: TWMPaint);
begin
  if (PageCount = 0)
  then
    begin
      PaintHandler(Msg);
    end
  else
    inherited;
end;

procedure TbsSkinPageControl.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  if (PageCount = 0)
  then
    begin
      GetSkinData;
      if FIndex = -1
      then
        inherited
      else
        DrawEmptyBackGround(Msg.DC);
    end
  else
    Msg.Result := 1;
end;

procedure TbsSkinPageControl.WndProc(var Message:TMessage);
var
  TOff, LOff, Roff, BOff: Integer;
begin
  if Message.Msg = TCM_ADJUSTRECT
  then
    begin
      inherited WndProc(Message);
      if FIndex <> -1
      then
        begin
          TOff := ClRect.Top;
          LOff := ClRect.Left;
          ROff := RectWidth(SkinRect) - ClRect.Right;
          BOff := RectHeight(SkinRect) - ClRect.Bottom;
        end;
      case TabPosition of
        tpLeft:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left + LOff - 4;
               PRect(Message.LParam)^.Right := ClientWidth - ROff;
               {$IFNDEF VER130}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
               {$ELSE}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               {$ENDIF}
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 3;
               PRect(Message.LParam)^.Right := ClientWidth - 1;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpRight:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := LOff;
               PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - ROff + 4;
               {$IFNDEF VER130}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
               {$ELSE}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               {$ENDIF}
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 3;
               PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 3;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpTop:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := LOff;
               PRect(Message.LParam)^.Right := ClientWidth - ROff;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := 1;
               PRect(Message.LParam)^.Right := ClientWidth - 1;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpBottom:
          if FIndex <> -1
          then
            begin
              PRect(Message.LParam)^.Left := LOff;
              PRect(Message.LParam)^.Right := ClientWidth - ROff;
              {$IFNDEF VER130}
              PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
              {$ELSE}
              PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
              {$ENDIF}
              PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 4 - BOff;
            end
          else
            begin
              PRect(Message.LParam)^.Left := 1;
              PRect(Message.LParam)^.Right := ClientWidth - 1;
              PRect(Message.LParam)^.Top := 1;
              PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 3;
            end;

      end;
    end
  else
    if Message.Msg = TCM_GETITEMRECT
    then
      begin
        inherited WndProc(Message);
        if Style = tsTabs
        then
          case TabPosition of
            tpLeft:
                begin
                  PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                  PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                end;
            tpRight:
                begin
                  PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left + 2;
                  PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 2;
                end;

            tpTop:
                begin
                  if not MultiLine
                  then
                    begin
                      PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                      PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                    end;
                  PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 2;
                  PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom - 2;
                end;
            tpBottom:
                begin
                  if not MultiLine
                  then
                    begin
                      PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                      PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                    end;
                  PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top + 2;
                  PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 2;
                end;
          end;
      end
  else
  inherited WndProc(Message);
  if (Message.Msg = WM_SIZE) and (not MultiLine) and
     not (csDesigning in ComponentState)
  then
    begin
      CheckScroll;
    end;
end;

function TbsSkinPageControl.GetItemRect(index: integer): TRect;
var
  R: TRect;
begin
  SendMessage(Handle, TCM_GETITEMRECT, index, Integer(@R));
  Result := R;
  if (Index = 0) and not MultiLine then Result.Left := Result.Left + 1;
end;

procedure TbsSkinPageControl.SetItemSize;
begin
  SendMessage(Handle, TCM_SETITEMSIZE, 0, MakeLParam(AWidth, AHeight));
end;

procedure TbsSkinPageControl.PaintWindow(DC: HDC);
var
  SaveIndex: Integer;
begin
  if (Width <= 0) or (Height <=0) then Exit;
  GetSkinData;
  SaveIndex := SaveDC(DC);
  try
    Canvas.Handle := DC;
    if FIndex = -1
    then
      PaintDefaultWindow(Canvas)
    else
      PaintSkinWindow(Canvas);
    DrawTabs(Canvas);
    Canvas.Handle := 0;
  finally
    RestoreDC(DC, SaveIndex);
  end;
end;

procedure TbsSkinPageControl.TestActive(X, Y: Integer);
var
  i, j, k: Integer;
  R: TRect;
begin
  FOldActiveTab := FActiveTab;
  FOldActiveTabIndex := FActiveTabIndex;
  k := -1;
  j := -1;
  for i := 0 to PageCount - 1 do
  if Pages[i].TabVisible then
  begin
    Inc(k);
    R := GetItemRect(k);
    if PtInRect(R, Point(X, Y))
    then
      begin
        j := k;
        Break;
      end;
  end;

  FActiveTab := i;
  FActiveTabIndex := j;

  if (FOldActiveTabIndex <> FActiveTabIndex)
  then
    begin
      if (FOldActiveTabIndex <> - 1) and (FOldActiveTabIndex <> TabIndex) and
         (FOldActiveTabIndex < PageCount)
      then
        begin
          R := GetItemRect(FOldActiveTabIndex);
          DrawTab(FOldActiveTab, R, False, False, Canvas);
        end;
      if (FActiveTabIndex <> -1) and (FActiveTabIndex <> TabIndex) and
         (FActiveTabIndex < PageCount)
      then
        begin
          R := GetItemRect(FActiveTabIndex);
          DrawTab(FActiveTab, R, False, True, Canvas );
        end;
    end;
end;

procedure TbsSkinPageControl.DrawTabs;
var
  i, j: integer;
  IR: TRect;
  w, h, XCnt, YCnt, X, Y, TOff, LOff, Roff, BOff: Integer;
  Rct, R, DR: TRect;
  Buffer, Buffer2: TBitMap;
  ATabIndex: Integer;
begin
  //
  if PageCount = 0 then Exit;
  if FIndex = -1
  then
    begin
      j := -1;
      for i := 0 to PageCount-1 do
      if Pages[i].TabVisible then
      begin
        inc(j);
        R := GetItemRect(j);
        DrawTab(i, R, (j = TabIndex), j = FActiveTabIndex, Cnvs);
      end;
      Exit;
    end;
  //
  GetSkinData;
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  DR := Self.DisplayRect;
  R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
  Buffer := TBitMap.Create;
  case TabPosition of
    tpTop:
      begin
        Buffer.Width := Width;
        Buffer.Height := R.Top;
      end;
    tpBottom:
      begin
        Buffer.Width := Width;
        Buffer.Height := Height - R.Bottom;
      end;
    tpRight:
      begin
        Buffer.Width := Width - R.Right;
        Buffer.Height := Height;
      end;
    tpLeft:
      begin
        Buffer.Width := R.Left;
        Buffer.Height := Height;
      end;
  end;
  // draw tabsbg
  if IsNullRect(TabsBGRect)
  then
    begin
      TabsBGRect := ClRect;
      OffsetRect(TabsBGRect, SkinRect.Left, SkinRect.Top);
    end;
  w := RectWidth(TabsBGRect);
  h := RectHeight(TabsBGRect);
  XCnt := Buffer.Width div w;
  YCnt := Buffer.Height div h;
  if not TabsBGTransparent
  then
    begin
      Buffer2 := TBitMap.Create;
      Buffer2.Width := w;
      Buffer2.Height := h;
      Buffer2.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas, TabsBGRect);
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
      begin
       Buffer.Canvas.Draw(X * w, Y * h, Buffer2);
      end;
      Buffer2.Free;
    end
  else
    begin
      case TabPosition of
        tpTop:
          Rct := Rect(0, 0, Width, R.Top);
        tpBottom:
          Rct := Rect(0, Height - R.Bottom, Width, Height);
        tpRight:
          Rct := Rect(Width - R.Right, 0, Width, Height);
        tpLeft:
          Rct := Rect(0, 0, R.Left, R.Bottom);
      end;
      GetParentImageRect(Self, Rct, Buffer.Canvas);
    end;
  //
  j := -1;
  ATabIndex := 0;
  for i := 0 to PageCount-1 do
  if Pages[I].TabVisible then
  begin
    inc(j);
    IR := GetItemRect(j);
    case TabPosition of
    tpTop:
      begin
      end;
    tpBottom:
      begin
        OffsetRect(IR, 0, -R.Bottom);
      end;
    tpRight:
      begin
        OffsetRect(IR, - R.Right, 0);
      end;
    tpLeft:
      begin
                            
      end;
     end;
    DrawTab(i, IR, (j = TabIndex), j = FActiveTabIndex, Buffer.Canvas);
    if j = TabIndex then ATabIndex := i;
  end;
 case TabPosition of
    tpTop:
      begin
        Cnvs.Draw(0, 0, Buffer);
      end;
    tpBottom:
      begin
        Cnvs.Draw(0, Height - Buffer.Height, Buffer);
      end;
    tpRight:
      begin
        Cnvs.Draw(Width - Buffer.Width, 0, Buffer);
      end;
    tpLeft:
      begin
        Cnvs.Draw(0, 0, Buffer);
      end;
  end;
  Buffer.Free;
  if (ATabIndex <> -1) and (TabIndex <> -1) and (TabIndex >= 0) and (TabIndex < PageCount)
  then
    begin
      IR := GetItemRect(TabIndex);
      if (FIndex <> -1) and (RectHeight(TabRect) <> RectHeight(ActiveTabRect))
      then
        begin
          if (TabPosition = tpBottom) then OffsetRect(IR, 0, -1) else
          if (TabPosition = tpRight) then OffsetRect(IR, -1, 0);
        end;
      DrawTab(ATabIndex, IR, True, TabIndex = FActiveTabIndex, Cnvs);
    end;
end;

procedure TbsSkinPageControl.DrawTab;
var
  R, R1: TRect;
  S: String;
  TB, BufferTB: TBitMap;
  DrawGlyph: Boolean;
  W, H: Integer;
begin
  if TI > PageCount - 1 then Exit;
  DrawGlyph := (Images <> nil) and (TI < Images.Count);
  S := Pages[TI].Caption;
  if (TabPosition = tpTop) or (TabPosition = tpBottom)
  then
    begin
      W := RectWidth(Rct);
      H := RectHeight(Rct);
    end
  else
    begin
      H := RectWidth(Rct);
      W := RectHeight(Rct);
    end;
  if (W <= 0) or (H <= 0) then Exit;
  TB := TBitMap.Create;
  TB.Width := W;
  TB.Height := H;
  R := Rect(0, 0, W, H);
  if FIndex <> -1
  then
    begin
      if TabHeight <= 0
      then
        begin
          if MouseIn and not Active and not IsNullRect(MouseInTabRect)
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             TB, Picture, MouseInTabRect, W, H, TabStretchEffect)
          else
            if Active and Focused
          then
           CreateHSkinImage(TabLeftOffset, TabRightOffset,
            TB, Picture, FocusTabRect, W, H, TabStretchEffect)
          else
          if Active
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
              TB, Picture, ActiveTabRect, W, H, TabStretchEffect)
          else
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             TB, Picture, TabRect, W, H, TabStretchEffect); 
       end
     else
       begin
         BufferTB := TBitMap.Create;
         BufferTB.Width := W;
         BufferTB.Height := RectHeight(TabRect);
         if MouseIn and not Active and not IsNullRect(MouseInTabRect)
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             BufferTB, Picture, MouseInTabRect, W, H, TabStretchEffect)
          else
            if Active and Focused
          then
           CreateHSkinImage(TabLeftOffset, TabRightOffset,
            BufferTB, Picture, FocusTabRect, W, H, TabStretchEffect)
          else
          if Active
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
              BufferTB, Picture, ActiveTabRect, W, H, TabStretchEffect)
          else
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             BufferTB, Picture, TabRect, W, H, TabStretchEffect);
         TB.Width := W;
         TB.Height := H;
         TB.Canvas.StretchDraw(R, BufferTB);
         BufferTB.Free;
       end;
      if TabPosition = tpBottom then DrawFlipVert(TB);
      with TB.Canvas do
      begin
        Brush.Style := bsClear;
        if FUseSkinFont
        then
          begin
            Font.Name := FontName;
            Font.Style := FontStyle;
            Font.Height := FontHeight;
          end
        else
           Font.Assign(Self.Font);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet
        else
          Font.CharSet := Self.Font.CharSet;
        if MouseIn and not Active
        then
          Font.Color := MouseInFontColor
        else
        if Active and Focused
        then
          Font.Color := FocusFontColor
        else
          if Active
          then Font.Color := ActiveFontColor
          else Font.Color := FontColor;
      end;
    end
  else
    begin
      TB.Width := W;
      TB.Height := H;
      if MouseIn and not Active
      then
        begin
          TB.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          TB.Canvas.FillRect(R);
        end
      else
      if Active and Focused
      then
        begin
          Frame3D(TB.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          TB.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          TB.Canvas.FillRect(R);
        end
      else
      if Active
      then
        begin
          Frame3D(TB.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          TB.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          TB.Canvas.FillRect(R);
        end
      else
        begin
          TB.Canvas.Brush.Color := clBtnFace;
          TB.Canvas.FillRect(R);
        end;
      with TB.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Assign(Self.Font);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet;
      end;
    end;
  //
  if (FIndex <> -1) and ShowFocus and Focused and Active
  then
    begin
      R1 := R;
      InflateRect(R1, -FocusOffsetX, -FocusOffsetY);
      TB.Canvas.Brush.Style := bsSolid;
      TB.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      TB.Canvas.DrawFocusRect(R1);
      TB.Canvas.Brush.Style := bsClear;
    end;
  //
  if Assigned(Self.FOnDrawSkinTab)
  then
    begin
      FOnDrawSkinTab(TI, Rect(0, 0, TB.Width, TB.Height), Active, MouseIn, TB.Canvas);
    end
  else
  if DrawGlyph
  then
    DrawTabGlyphAndText(TB.Canvas, TB.Width, TB.Height, S,
                        Images, Pages[TI].ImageIndex, Pages[TI].Enabled)
  else
    DrawText(TB.Canvas.Handle, PChar(S), Length(S), R, DT_CENTER or DT_SINGLELINE or DT_VCENTER);


  if TabPosition = tpLeft
  then
    DrawRotate90_1(Cnvs, TB, Rct.Left, Rct.Top)
  else
  if TabPosition = tpRight
  then
    DrawRotate90_2(Cnvs, TB, Rct.Left, Rct.Top)
  else
    Cnvs.Draw(Rct.Left, Rct.Top, TB);
  TB.Free;
end;


{ TbsSkinTabControl }

constructor TbsSkinTabControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTabsBGTransparent := False;
  FromWMPaint := False;
  Ctl3D := False;
  FIndex := -1;
  Picture := nil;
  Font.Name := '宋体';
  Font.Charset := GB2312_CHARSET;
  Font.Style := [];
  Font.Color := clBtnText;
  Font.Height := -12;
  FOldTop := 0;
  FOldBottom := 0;
  FSkinUpDown := nil;
  FSkinDataName := 'tab';
  FDefaultFont := TFont.Create;
  FDefaultFont.Name := '宋体';
  FDefaultFont.Charset := GB2312_CHARSET;
  FDefaultFont.Style := [];
  FDefaultFont.Color := clBtnText;
  FDefaultFont.Height := -12;
  FDefaultItemHeight := 20;
  FUseSkinFont := False;
  TabStretchEffect := False;
end;

procedure TbsSkinTabControl.SetTabsBGTransparent(Value: Boolean);
begin
  if FTabsBGTransparent <> Value
  then
    begin
      FTabsBGTransparent := Value;
      Invalidate;
    end;
end;

procedure TbsSkinTabControl.MouseMove;
begin
 inherited;
 if not (csDesigning in ComponentState)
 then
   TestActive(X, Y);
end;

procedure TbsSkinTabControl.MouseDown;
begin
  inherited;
  if (Button = mbLeft) and not (csDesigning in ComponentState)
  then
    TestActive(X, Y);
end;

procedure TbsSkinTabControl.CMMouseLeave;
var
  R: TRect;
begin
  if (FOldActiveTab <> - 1) and (FOldActiveTab <> TabIndex) and
     (FOldActiveTab < Self.Tabs.Count)
  then
    begin
      R := GetItemRect(FOldActiveTab);
      DrawTab(FOldActiveTab, R, False, False, Canvas);
      FOldActiveTab := -1;
    end;

  if (FActiveTab <> - 1) and (FActiveTab <> TabIndex) and
     (FActiveTab < Self.Tabs.Count)
  then
    begin
      R := GetItemRect(FActiveTab);
      DrawTab(FActiveTab, R, False, False, Canvas);
      FActiveTab := -1;
    end;
end;

procedure TbsSkinTabControl.TestActive(X, Y: Integer);
var
  i, j: Integer;
  R: TRect;
begin
  FOldActiveTab := FActiveTab;
  j := -1;
  for i := 0 to Tabs.Count-1 do
  begin
    R := GetItemRect(i);
    if PtInRect(R, Point(X, Y))
    then
      begin
        j := i;
        Break;
      end;
  end;

  FActiveTab := j;

  if (FOldActiveTab <> FActiveTab)
  then
    begin
      if (FOldActiveTab <> - 1) and (FOldActiveTab <> TabIndex) and
         (FOldActiveTab < Self.Tabs.Count)
      then
        begin
          R := GetItemRect(FOldActiveTab);
          DrawTab(FOldActiveTab, R, False, False, Canvas);
        end;
      if (FActiveTab <> -1) and (FActiveTab <> TabIndex) and
         (FActiveTab < Self.Tabs.Count)
      then
        begin
          R := GetItemRect(FActiveTab);
          DrawTab(FActiveTab, R, False, True, Canvas );
        end;
    end;
end;

procedure TbsSkinTabControl.SetDefaultItemHeight;
begin
  FDefaultItemHeight := Value;
  if FIndex = -1
  then
    begin
      SetitemSize(TabWidth, FDefaultItemHeight);
      Change2;
      ReAlign;
    end;
end;


procedure TbsSkinTabControl.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinTabControl.OnUpDownChange(Sender: TObject);
begin
  FSkinUpDown.Max := GetInVisibleItemCount;
  SendMessage(Handle, WM_HSCROLL,
    MakeWParam(SB_THUMBPOSITION, FSkinUpDown.Position), 0);
end;

function TbsSkinTabControl.GetPosition: Integer;
var
  i, j: Integer;
  R: TRect;
begin
  j := 0;
  for i := 0 to Tabs.Count - 1 do
  begin
    R := GetItemRect(i);
    if R.Right <= 0 then inc(j);
  end;
  Result := j;
end;

function TbsSkinTabControl.GetInVisibleItemCount;
var
  i, j: Integer;
  R: TRect;
  Limit: Integer;
begin
  if FSkinUpDown = nil
  then
    Limit := Width - 3
  else
    Limit := Width - FSkinUpDown.Width - 3;
  j := 0;
  for i := 0 to Tabs.Count - 1 do
  begin
    R := GetItemRect(i);
    if (R.Right > Limit) or (R.Right <= 0)
    then inc(j);
  end;
  Result := j;
end;

procedure TbsSkinTabControl.CheckScroll;
var
  Wnd: HWND;
  InVCount: Integer;
begin
  Wnd := FindWindowEx(Handle, 0, 'msctls_updown32', nil);
  if Wnd <> 0 then DestroyWindow(Wnd);
  InVCount := GetInVisibleItemCount;
  if (InVCount = 0) and (FSkinUpDown <> nil)
  then
    HideSkinUpDown
  else
  if (InVCount > 0) and (FSkinUpDown = nil)
  then
    ShowSkinUpDown;
  if FSkinUpDown <> nil
  then
    begin
      FSkinUpDown.Max := InVCount;
      FSkinUpDown.Left := Width - FSkinUpDown.Width;
      if TabPosition = tpTop
      then
        FSkinUpDown.Top := 0
      else
       FSkinUpDown.Top := Height - FSkinUpDown.Height;
    end;
end;

procedure TbsSkinTabControl.ShowSkinUpDown;
begin
  FSkinUpDown := TbsSkinUpDown.Create(Self);
  FSkinUpDown.Parent := Self;
  FSkinUpDown.Width := 36;
  FSkinUpDown.Height := 18;
  FSkinUpDown.Min := 0;
  FSkinUpDown.Max := GetInVisibleItemCount;
  FSkinUpDown.Position := GetPosition;
  FSkinUpDown.Increment := 1;
  FSkinUpDown.OnChange := OnUpDownChange;
  FSkinUpDown.Left := Width - FSkinUpDown.Width;
  if TabPosition = tpTop
  then
    FSkinUpDown.Top := 0
  else
    FSkinUpDown.Top := Height - FSkinUpDown.Height;
  FSkinUpDown.SkinDataName := UpDown;
  FSkinUpDown.SkinData := SkinData;
  FSkinUpDown.Visible := True;
end;

procedure TbsSkinTabControl.HideSkinUpDown;
begin
  FSkinUpDown.Free;
  FSkinUpDown := nil;
end;

procedure TbsSkinTabControl.WMPaint;
begin
  FromWMPaint := True;
  if ControlCount = 0
  then
    PaintHandler(Msg)
  else
    inherited;
  FromWMPaint := False;
end;

procedure TbsSkinTabControl.WMHSCROLL;
begin
  inherited;
  RePaint;
end;

procedure TbsSkinTabControl.WMSize;
begin
  inherited;
end;

destructor TbsSkinTabControl.Destroy;
begin
  FDefaultFont.Free;
  inherited Destroy;
end;

procedure TbsSkinTabControl.Change;
begin
  if FSkinUpDown <> nil
  then FSkinUpDown.Position := GetPosition;
  inherited;
  Invalidate;
end;

procedure TbsSkinTabControl.Change2;
begin
  if FSkinUpDown <> nil
  then FSkinUpDown.Position := GetPosition;
  Invalidate;
end;

procedure TbsSkinTabControl.GetSkinData;
begin
  BGPictureIndex := -1;
  if FSD = nil
  then
    begin
      FIndex := -1;
      Exit;
    end;
  if FSD.Empty
  then
    FIndex := -1
  else
    FIndex := FSD.GetControlIndex(FSkinDataName);
  //
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinTabControl
    then
      with TbsDataSkinTabControl(FSD.CtrlList.Items[FIndex]) do
      begin
        if (PictureIndex <> -1) and (PictureIndex < FSD.FActivePictures.Count)
        then
          Picture := TBitMap(FSD.FActivePictures.Items[PictureIndex])
        else
          Picture := nil;
        Self.SkinRect := SkinRect;
        Self.ClRect := ClRect;
        Self.TabRect := TabRect;
        if IsNullRect(ActiveTabRect)
        then
          Self.ActiveTabRect := TabRect
        else
          Self.ActiveTabRect := ActiveTabRect;
        if IsNullRect(FocusTabRect)
        then
          Self.FocusTabRect := ActiveTabRect
        else
          Self.FocusTabRect := FocusTabRect;
        //
        Self.TabsBGRect := TabsBGRect; 
        Self.LTPoint := LTPoint;
        Self.RTPoint := RTPoint;
        Self.LBPoint := LBPoint;
        Self.RBPoint := RBPoint;
        Self.TabLeftOffset := TabLeftOffset;
        Self.TabRightOffset := TabRightOffset;
        //
        Self.FontName := FontName;
        Self.FontColor := FontColor;
        Self.ActiveFontColor := ActiveFontColor;
        Self.FocusFontColor := FocusFontColor;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.UpDown := UpDown;
        Self.BGPictureIndex := BGPictureIndex;
        Self.MouseInFontColor := MouseInFontColor;
        Self.MouseInTabRect := MouseInTabRect;
        Self.TabStretchEffect := TabStretchEffect;
        Self.LeftStretch := LeftStretch;
        Self.TopStretch := TopStretch;
        Self.RightStretch := RightStretch;
        Self.BottomStretch := BottomStretch;
        Self.ShowFocus := ShowFocus;
        Self.FocusOffsetX := FocusOffsetX;
        Self.FocusOffsetY := FocusOffsetY;
      end;
end;

procedure TbsSkinTabControl.ChangeSkinData;
begin
  GetSkinData;
  //
  if FIndex <> -1
  then
    begin
      Font.Color := FontColor;
      if FUseSkinFont
      then
        begin
          Font.Name := FontName;
          Font.Height := FontHeight;
          Font.Style := FontStyle;
        end
      else
        Font.Assign(FDefaultFont);

      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet
      else
        Font.CharSet := DefaultFont.CharSet;

      if TabHeight <= 0
      then
        SetItemSize(TabWidth, RectHeight(TabRect))
      else
        SetItemSize(TabWidth, TabHeight);
    end
  else
    begin
      Font.Assign(FDefaultFont);
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        Font.Charset := SkinData.ResourceStrData.CharSet;
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
    end;
  //
  Change2;
  ReAlign;
  RePaint;
  if FSkinUpDown <> nil
  then
    begin
      HideSkinUpDown;
      CheckScroll;
    end;
end;

procedure TbsSkinTabControl.SetSkinData;
begin
  FSD := Value;
  if (FSD <> nil) then
  if not FSD.Empty and not (csDesigning in ComponentState)
  then
    ChangeSkinData;
end;

procedure TbsSkinTabControl.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinTabControl.PaintDefaultWindow;
var
  R: TRect;
begin
  with Cnvs do
  begin
    Brush.Color := clBtnFace;
    FillRect(ClientRect);
    R := Self.DisplayRect;
    InflateRect(R, 1, 1);
    Frame3D(Cnvs, R, clBtnShadow, clBtnShadow, 1);
  end;
end;

procedure TbsSkinTabControl.PaintSkinWindow;
var
  TOff, LOff, Roff, BOff: Integer;
  NewClRect, DR, R: TRect;
  TBGOffX, TBGOffY, X, Y, XCnt, YCnt, w, h, rw, rh, XO, YO, w1, h1: Integer;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  B, LB, RB, TB, BB, ClB, Buffer: TBitMap;
  SaveIndex: Integer;
begin
  GetSkinData;
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  DR := Self.DisplayRect;
  R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
  XO := RectWidth(R) - RectWidth(SkinRect);
  YO := RectHeight(R) - RectHeight(SkinRect);
  NewLTPoint := LTPoint;
  NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
  NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
  NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
  NewCLRect := Rect(ClRect.Left, ClRect.Top, ClRect.Right + XO, ClRect.Bottom + YO);
  // DrawBG
  if BGPictureIndex <> -1
  then
    begin
      B := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div B.Width;
          YCnt := Height div B.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          Cnvs.Draw(X * B.Width, Y * B.Height, B);
        end;
      Exit;
    end;
  w := RectWidth(ClRect);
  h := RectHeight(ClRect);
  w1 := Width;
  h1 := Height;
  XCnt := w1 div w;
  YCnt := h1 div h;
  Clb := TBitMap.Create;
  Clb.Width := w;
  Clb.Height := h;
  Clb.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas,
  Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
       SkinRect.Left + ClRect.Right,
      SkinRect.Top + ClRect.Bottom));
  SaveIndex := SaveDC(Cnvs.Handle);
  IntersectClipRect(Cnvs.Handle, DR.Left, DR.Top, DR.Right, DR.Bottom);
  for X := 0 to XCnt do
  for Y := 0 to YCnt do
  begin
    Cnvs.Draw(X * w, Y * h, Clb);
  end;
  RestoreDC(Cnvs.Handle, SaveIndex);
  Clb.Free;
  // Draw frame around displayrect
  LB := TBitMap.Create;
  TB := TBitMap.Create;
  RB := TBitMap.Create;
  BB := TBitMap.Create;
  CreateSkinBorderImages(LtPoint, RTPoint, LBPoint, RBPoint, ClRect,
     NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewClRect,
     LB, TB, RB, BB, Picture, SkinRect, RectWidth(R), RectHeight(R),
     LeftStretch, TopStretch, RightStretch, BottomStretch);
  Cnvs.Draw(R.Left, R.Top, TB);
  Cnvs.Draw(R.Left, R.Top + TB.Height, LB);
  Cnvs.Draw(R.Left + RectWidth(R) - RB.Width, R.Top + TB.Height, RB);
  Cnvs.Draw(R.Left, R.Top + RectHeight(R) - BB.Height, BB);
  LB.Free;
  TB.Free;
  RB.Free;
  BB.Free;
end;

procedure TbsSkinTabControl.Loaded;
begin
  inherited Loaded;
  if FIndex = -1
  then
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
      Change2;
      ReAlign;
    end;
end;

procedure TbsSkinTabControl.PaintBG;
var
  C: TCanvas;
  TabSheetBG: TBitMap;
  X, Y, XCnt, YCnt, w, h, w1, h1: Integer;
  R: TRect;
begin

  if (Width <= 0) or (Height <=0) then Exit;

  GetSkinData;
  C := TCanvas.Create;
  C.Handle := DC;
  if (FSD <> nil) and (not FSD.Empty) and
     (FIndex <> -1) and (BGPictureIndex <> -1)
  then
    begin
      TabSheetBG := TBitMap(FSD.FActivePictures.Items[BGPictureIndex]);
      if (Width > 0) and (Height > 0)
      then
        begin
          XCnt := Width div TabSheetBG.Width;
          YCnt := Height div TabSheetBG.Height;
          for X := 0 to XCnt do
          for Y := 0 to YCnt do
          C.Draw(X * TabSheetBG.Width, Y * TabSheetBG.Height, TabSheetBG);
        end;
      C.Free;
      Exit;
    end;


  w1 := Width;
  h1 := Height;

  if FIndex <> -1
  then
    begin
      TabSheetBG := TBitMap.Create;
      TabSheetBG.Width := RectWidth(ClRect);
      TabSheetBG.Height := RectHeight(ClRect);
      TabSheetBG.Canvas.CopyRect(Rect(0, 0, TabSheetBG.Width, TabSheetBG.Height),
        Picture.Canvas,
          Rect(SkinRect.Left + ClRect.Left, SkinRect.Top + ClRect.Top,
               SkinRect.Left + ClRect.Right,
               SkinRect.Top + ClRect.Bottom));
      w := RectWidth(ClRect);
      h := RectHeight(ClRect);
      XCnt := w1 div w;
      YCnt := h1 div h;
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
       C.Draw(X * w, Y * h, TabSheetBG);
      TabSheetBG.Free;
    end
  else
  with C do
  begin
    Brush.Color := clbtnface;
    FillRect(Rect(0, 0, w1, h1));
  end;
  C.Free;
end;

procedure TbsSkinTabControl.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  Msg.Result := 1;
end;

procedure TbsSkinTabControl.WndProc(var Message:TMessage);
var
  TOff, LOff, Roff, BOff: Integer;
begin
  if Message.Msg = TCM_ADJUSTRECT
  then
    begin
      inherited WndProc(Message);

      TOff := 0;
      LOff := 0;
      ROff := 0;
      BOff := 0;
      if (FIndex <> -1) and (BGPictureIndex = -1)
      then
        begin
          TOff := ClRect.Top;
          LOff := ClRect.Left;
          ROff := RectWidth(SkinRect) - ClRect.Right;
          BOff := RectHeight(SkinRect) - ClRect.Bottom;
        end;
      case TabPosition of
        tpLeft:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left + LOff - 4;
               PRect(Message.LParam)^.Right := ClientWidth - ROff;
               {$IFNDEF VER130}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
               {$ELSE}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               {$ENDIF}
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 3;
               PRect(Message.LParam)^.Right := ClientWidth - 1;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpRight:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := LOff;
               PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - ROff + 4;
               {$IFNDEF VER130}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
               {$ELSE}
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               {$ENDIF}
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 3;
               PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 3;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpTop:
           if FIndex <> -1
           then
             begin
               PRect(Message.LParam)^.Left := LOff;
               PRect(Message.LParam)^.Right := ClientWidth - ROff;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
               PRect(Message.LParam)^.Bottom := ClientHeight - BOff;
             end
           else
             begin
               PRect(Message.LParam)^.Left := 1;
               PRect(Message.LParam)^.Right := ClientWidth - 1;
               PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 5;
               PRect(Message.LParam)^.Bottom := ClientHeight - 1;
             end;
        tpBottom:
          if FIndex <> -1
          then
            begin
              PRect(Message.LParam)^.Left := LOff;
              PRect(Message.LParam)^.Right := ClientWidth - ROff;
              {$IFNDEF VER130}
              PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 4 + TOff;
              {$ELSE}
              PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 6 + TOff;
              {$ENDIF}
              PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 4 - BOff;
            end
          else
            begin
              PRect(Message.LParam)^.Left := 1;
              PRect(Message.LParam)^.Right := ClientWidth - 1;
              PRect(Message.LParam)^.Top := 1;
              PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 3;
            end;

      end;
    end
  else
    if Message.Msg = TCM_GETITEMRECT
    then
      begin
        inherited WndProc(Message);
        if Style = tsTabs
        then
          case TabPosition of
            tpLeft:
                begin
                  PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                  PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                end;
            tpRight:
                begin
                  PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left + 2;
                  PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right + 2;
                end;

            tpTop:
                begin
                  if not MultiLine
                  then
                    begin
                      PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                      PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                    end;
                  PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top - 2;
                  PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom - 2;
                end;
            tpBottom:
                begin
                  if not MultiLine
                  then
                    begin
                      PRect(Message.LParam)^.Left := PRect(Message.LParam)^.Left - 2;
                      PRect(Message.LParam)^.Right := PRect(Message.LParam)^.Right - 2;
                    end;
                  PRect(Message.LParam)^.Top := PRect(Message.LParam)^.Top + 2;
                  PRect(Message.LParam)^.Bottom := PRect(Message.LParam)^.Bottom + 2;
                end;
          end;
      end
  else
  inherited WndProc(Message);
  if (Message.Msg = WM_SIZE) and (not MultiLine)
  then
    begin
      CheckScroll;
    end;
end;

function TbsSkinTabControl.GetItemRect(index: integer): TRect;
var
  R: TRect;
begin
  SendMessage(Handle, TCM_GETITEMRECT, index, Integer(@R));
  Result := R;
  if (Index = 0) and not MultiLine then Result.Left := Result.Left + 1;
end;

procedure TbsSkinTabControl.SetItemSize;
begin
  SendMessage(Handle, TCM_SETITEMSIZE, 0, MakeLParam(AWidth, AHeight));
end;

procedure TbsSkinTabControl.PaintWindow(DC: HDC);
var
  SaveIndex: Integer;
  C: TCanvas;
begin
  GetSkinData;
  SaveIndex := SaveDC(DC);
  try
    C := TCanvas.Create;
    C.Handle := DC;
    if FIndex = -1
    then
     PaintDefaultWindow(C)
   else
     PaintSkinWindow(C);
    DrawTabs(C);
    C.Handle := 0;
    C.Free;
  finally
    RestoreDC(DC, SaveIndex);
  end;
end;

procedure TbsSkinTabControl.DrawTabs;
var
  i, j: integer;
  IR: TRect;
  w, h, XCnt, YCnt, X, Y, TOff, LOff, Roff, BOff: Integer;
  Rct, R, DR: TRect;
  Buffer, Buffer2: TBitMap;
begin
  //
  if Tabs.Count = 0 then Exit;
  if FIndex = -1
  then
    begin
      for i := 0 to Tabs.Count-1 do
      begin
        R := GetItemRect(i);
        DrawTab(i, R, i = TabIndex, i = FActiveTab, Cnvs);
      end;
      Exit;
    end;
  //
  GetSkinData;
  TOff := ClRect.Top;
  LOff := ClRect.Left;
  ROff := RectWidth(SkinRect) - ClRect.Right;
  BOff := RectHeight(SkinRect) - ClRect.Bottom;
  Self.GetClientRect;
  //
  DR := ClientRect;
  SendMessage(Handle, TCM_ADJUSTRECT, 0, Integer(@DR));
  Inc(DR.Top, 2);
  //
//  DR := Self.GetDisplayRect;
  R := Rect(DR.Left - LOff, DR.Top - TOff, DR.Right + ROff, DR.Bottom + BOff);
  Buffer := TBitMap.Create;
  case TabPosition of
    tpTop:
      begin
        Buffer.Width := Width;
        Buffer.Height := R.Top;
      end;
    tpBottom:
      begin
        Buffer.Width := Width;
        Buffer.Height := Height - R.Bottom;
      end;
    tpRight:
      begin
        Buffer.Width := Width - R.Right;
        Buffer.Height := Height;
      end;
    tpLeft:
      begin
        Buffer.Width := R.Left;
        Buffer.Height := Height;
      end;
  end;
  // draw tabsbg
  if IsNullRect(TabsBGRect)
  then
    begin
      TabsBGRect := ClRect;
      OffsetRect(TabsBGRect, SkinRect.Left, SkinRect.Top);
    end;
  w := RectWidth(TabsBGRect);
  h := RectHeight(TabsBGRect);
  XCnt := Buffer.Width div w;
  YCnt := Buffer.Height div h;
  if not TabsBGTransparent
  then
    begin
      Buffer2 := TBitMap.Create;
      Buffer2.Width := w;
      Buffer2.Height := h;
      Buffer2.Canvas.CopyRect(Rect(0, 0, w, h), Picture.Canvas, TabsBGRect);
      for X := 0 to XCnt do
      for Y := 0 to YCnt do
      begin
       Buffer.Canvas.Draw(X * w, Y * h, Buffer2);
      end;
      Buffer2.Free;
    end
  else
    begin
      case TabPosition of
        tpTop:
          Rct := Rect(0, 0, Width, R.Top);
        tpBottom:
          Rct := Rect(0, Height - R.Bottom, Width, Height);
        tpRight:
          Rct := Rect(Width - R.Right, 0, Width, Height);
        tpLeft:
          Rct := Rect(0, 0, R.Left, R.Bottom);
      end;
      GetParentImageRect(Self, Rct, Buffer.Canvas);
    end;
  //
  j := -1;
  for i := 0 to Tabs.Count - 1 do
  begin
    IR := GetItemRect(i);
    case TabPosition of
    tpTop:
      begin
      end;
    tpBottom:
      begin
        OffsetRect(IR, 0, -R.Bottom);
      end;
    tpRight:
      begin
        OffsetRect(IR, - R.Right, 0);
      end;
    tpLeft:
      begin

      end;
  end;
   DrawTab(i, IR, i = TabIndex, i = FActiveTab, Buffer.Canvas);
  end;
 case TabPosition of
    tpTop:
      begin
        Cnvs.Draw(0, 0, Buffer);
      end;
    tpBottom:
      begin
        Cnvs.Draw(0, Height - Buffer.Height, Buffer);
      end;
    tpRight:
      begin
        Cnvs.Draw(Width - Buffer.Width, 0, Buffer);
      end;
    tpLeft:
      begin
        Cnvs.Draw(0, 0, Buffer);
      end;
  end;
  Buffer.Free;
  if (TabIndex <> -1) and (TabIndex >= 0) and (TabIndex < Tabs.Count)
  then
    begin
      IR := GetItemRect(TabIndex);
      if (FIndex <> -1) and (RectHeight(TabRect) <> RectHeight(ActiveTabRect))
      then
        begin
          if (TabPosition = tpBottom) then OffsetRect(IR, 0, -1) else
          if (TabPosition = tpRight) then OffsetRect(IR, -1, 0);
        end;
      DrawTab(TabIndex, IR, True, TabIndex = FActiveTab, Cnvs);
    end;
end;

procedure TbsSkinTabControl.UpDateTabs;
begin
  if FIndex <> -1
  then
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, RectHeight(TabRect))
      else
        SetItemSize(TabWidth, TabHeight);
    end
  else
    begin
      if TabHeight <= 0
      then
        SetItemSize(TabWidth, FDefaultItemHeight)
      else
        SetItemSize(TabWidth, TabHeight);
    end;
  if MultiLine and (FSkinUpDown <> nil)
  then
    HideSkinUpDown;
  ReAlign;
end;

procedure TbsSkinTabControl.DrawTab;
var
  R, R1: TRect;
  S: String;
  TB, BufferTB: TBitMap;
  DrawGlyph: Boolean;
  W, H: Integer;
begin
  if TI > Tabs.Count - 1 then Exit;
  DrawGlyph := (Images <> nil) and (TI < Images.Count);
  S := Tabs[TI];
  if (TabPosition = tpTop) or (TabPosition = tpBottom)
  then
    begin
      W := RectWidth(Rct);
      H := RectHeight(Rct);
    end
  else
    begin
      H := RectWidth(Rct);
      W := RectHeight(Rct);
    end;
  if (W <= 0) or (H <= 0) then Exit;   
  R := Rect(0, 0, W, H);
  TB := TBitMap.Create;
  TB.Width := W;
  TB.Height := H;
  if FIndex <> -1
  then
    begin
      if TabHeight <= 0
      then
        begin
          if MouseIn and not Active and not IsNullRect(MouseInTabRect)
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             TB, Picture, MouseInTabRect, W, H, TabStretchEffect)
          else
            if Active and Focused
          then
           CreateHSkinImage(TabLeftOffset, TabRightOffset,
            TB, Picture, FocusTabRect, W, H, TabStretchEffect)
          else
          if Active
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
              TB, Picture, ActiveTabRect, W, H, TabStretchEffect)
          else
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             TB, Picture, TabRect, W, H, TabStretchEffect);
       end
     else
       begin
         BufferTB := TBitMap.Create;
         BufferTB.Width := W;
         BufferTB.Height := RectHeight(TabRect);
         if MouseIn and not Active and not IsNullRect(MouseInTabRect)
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             BufferTB, Picture, MouseInTabRect, W, H, TabStretchEffect)
          else
            if Active and Focused
          then
           CreateHSkinImage(TabLeftOffset, TabRightOffset,
            BufferTB, Picture, FocusTabRect, W, H, TabStretchEffect)
          else
          if Active
          then
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
              BufferTB, Picture, ActiveTabRect, W, H, TabStretchEffect)
          else
            CreateHSkinImage(TabLeftOffset, TabRightOffset,
             BufferTB, Picture, TabRect, W, H, TabStretchEffect);
         TB.Width := W;
         TB.Height := H;
         TB.Canvas.StretchDraw(R, BufferTB);
         BufferTB.Free;
       end;
      if TabPosition = tpBottom then DrawFlipVert(TB);
      with TB.Canvas do
      begin
        Brush.Style := bsClear;
        if FUseSkinFont
        then
          begin
            Font.Name := FontName;
            Font.Style := FontStyle;
            Font.Height := FontHeight;
          end
        else
           Font.Assign(Self.Font);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet
        else
          Font.CharSet := Self.Font.CharSet;
        if MouseIn and not Active
        then
          Font.Color := MouseInFontColor
        else
        if Active and Focused
        then
          Font.Color := FocusFontColor
        else
          if Active
          then Font.Color := ActiveFontColor
          else Font.Color := FontColor;
      end;
    end
  else
    begin
      TB.Width := W;
      TB.Height := H;
      if MouseIn and not Active
      then
        begin
          TB.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          TB.Canvas.FillRect(R);
        end
      else
      if Active and Focused
      then
        begin
          Frame3D(TB.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          TB.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
          TB.Canvas.FillRect(R);
        end
      else
      if Active
      then
        begin
          Frame3D(TB.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
          TB.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
          TB.Canvas.FillRect(R);
        end
      else
        begin
          TB.Canvas.Brush.Color := clBtnFace;
          TB.Canvas.FillRect(R);
        end;
      with TB.Canvas do
      begin
        Brush.Style := bsClear;
        Font.Assign(Self.Font);
        if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
        then
          Font.Charset := SkinData.ResourceStrData.CharSet
      end;
    end;
  
  //
  if (FIndex <> -1) and ShowFocus and Focused and Active
  then
    begin
      R1 := R;
      InflateRect(R1, -FocusOffsetX, -FocusOffsetY);
      TB.Canvas.Brush.Style := bsSolid;
      TB.Canvas.Brush.Color := FSD.SkinColors.cBtnFace;
      TB.Canvas.DrawFocusRect(R1);
      TB.Canvas.Brush.Style := bsClear;
    end;
  //
  if Assigned(Self.FOnDrawSkinTab)
  then
    begin
      FOnDrawSkinTab(TI, Rect(0, 0, TB.Width, TB.Height), Active, MouseIn, TB.Canvas);
    end
  else
  if DrawGlyph
  then
    DrawTabGlyphAndText(TB.Canvas, TB.Width, TB.Height, S,
                        Images, TI, True)
  else
    DrawText(TB.Canvas.Handle, PChar(S), Length(S), R, DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  if TabPosition = tpLeft
  then
    DrawRotate90_1(Cnvs, TB, Rct.Left, Rct.Top)
  else
  if TabPosition = tpRight
  then
    DrawRotate90_2(Cnvs, TB, Rct.Left, Rct.Top)
  else
    Cnvs.Draw(Rct.Left, Rct.Top, TB);
  TB.Free;
end;


end.
