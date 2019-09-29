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

unit bsSkinMenus;

{$P+,S-,W-,R-}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Menus, ExtCtrls, ImgList, bsSkinData, bsUtils, bsSkinHint;

type
  TbsSkinPopupWindow = class;
  TbsSkinMenuItem = class(TObject)
  protected
    Parent: TbsSkinPopupWindow;
    MI: TbsDataSkinMenuItem;
    ActivePicture: TBitMap;
    FMorphKf: Double;
    procedure SetMorphKf(Value: Double);
    procedure Redraw;
  public
    MenuItem: TMenuItem;
    ObjectRect: TRect;
    Active: Boolean;
    Down: Boolean;
    FVisible: Boolean;
    WaitCommand: Boolean;
    //
    CurrentFrame: Integer;
    //
    constructor Create(AParent: TbsSkinPopupWindow; AMenuItem: TMenuItem;
                       AData: TbsDataSkinMenuItem);
    function EnableMorphing: Boolean;
    function EnableAnimation: Boolean;
    procedure Draw(Cnvs: TCanvas);
    procedure DefaultDraw(Cnvs: TCanvas);
    procedure MouseDown(X, Y: Integer);
    procedure MouseEnter(Kb: Boolean);
    procedure MouseLeave;
    function CanMorphing: Boolean; virtual;
    procedure DoMorphing;
    property MorphKf: Double read FMorphKf write SetMorphKf;
  end;

  TbsSkinMenu = class;

  TbsSkinPopupWindow = class(TCustomControl)
  private
    DSMI: TbsDataSkinMenuItem;
    VisibleCount: Integer;
    VisibleStartIndex: Integer;
    Scroll: Boolean;
    Scroll2: Boolean;
    ScrollCode: Integer;
    NewLTPoint, NewRTPoint,
    NewLBPoint, NewRBPoint: TPoint;
    NewItemsRect: TRect;
    FRgn: HRGN;
    ShowX, ShowY: Integer;
    OMX, OMY: Integer;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMEraseBkGrnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CreateMenu(Item: TMenuItem; StartIndex: Integer);
    procedure CreateMenu2(Item, Item2: TMenuItem; StartIndex: Integer);
    procedure CreateRealImage(B: TBitMap);
    procedure SetMenuWindowRegion;
    procedure DrawUpMarker(Cnvs: TCanvas);
    procedure DrawDownMarker(Cnvs: TCanvas);
    procedure StartScroll;
    procedure StopScroll;
  protected
    ImgL: TCustomImageList;
    GlyphWidth: Integer;
    WindowPicture, MaskPicture: TBitMap;
    OldActiveItem: Integer;
    MouseTimer, MorphTimer: TTimer;
    ParentMenu: TbsSkinMenu;
    SD: TbsSkinData;
    PW: TbsDataSkinPopupWindow;
    procedure TestMorph(Sender: TObject);
    procedure WMTimer(var Message: TWMTimer); message WM_Timer;
    function CanScroll(AScrollCode: Integer): Boolean;
    procedure ScrollUp(Cycle: Boolean);
    procedure ScrollDown(Cycle: Boolean);
    function GetEndStartVisibleIndex: Integer;
    procedure CalcItemRects;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure TestMouse(Sender: TObject);
    procedure TestActive(X, Y: Integer);
    function InWindow(P: TPoint): Boolean;
    procedure UpDatePW;
    function GetActive(X, Y: Integer): Boolean;
  public
    ItemList: TList;
    ActiveItem: Integer;

    constructor CreateEx(AOwner: TComponent; AParentMenu: TbsSkinMenu;
                       AData: TbsDataSkinPopupWindow);
    destructor Destroy; override;
     procedure Hide;
    procedure Show(R: TRect; AItem: TMenuItem; StartIndex: Integer;
                   PopupByItem: Boolean;  PopupUp: Boolean);
    procedure Show2(R: TRect; AItem, AItem2: TMenuItem; StartIndex: Integer;
                   PopupByItem: Boolean;  PopupUp: Boolean);
    procedure PaintMenu(DC: HDC);
    procedure PopupKeyDown(CharCode: Integer);
  end;

  TbsSkinMenu = class(TComponent)
  protected
    FUseSkinFont: Boolean;
    FFirst: Boolean;
    FDefaultMenuItemHeight: Integer;
    FDefaultMenuItemFont: TFont;
    PopupCtrl, DCtrl: TControl;
    FForm: TForm;
    WaitTimer: TTimer;
    WItem: TbsSkinMenuItem;
    WorkArea: TRect;
    FVisible: Boolean;
    SkinData: TbsSkinData;
    FOnMenuClose: TNotifyEvent;

    procedure SetDefaultMenuItemFont(Value: TFont);
    function GetWorkArea: TRect;
    function GetPWIndex(PW: TbsSkinPopupWindow): Integer;
    procedure CheckItem(PW: TbsSkinPopupWindow; MI: TbsSkinMenuItem; Down: Boolean; Kb: Boolean);
    procedure CloseMenu(EndIndex: Integer);
    procedure PopupSub(R: TRect; AItem: TMenuItem; StartIndex: Integer;
                       PopupByItem, PopupUp: Boolean);
    procedure PopupSub2(R: TRect; AItem, AItem2: TMenuItem; StartIndex: Integer;
                       PopupByItem, PopupUp: Boolean);
    procedure WaitItem(Sender: TObject);

  public
    FPopupList: TList;
    AlphaBlend: Boolean;
    AlphaBlendValue: Byte;
    AlphaBlendAnimation: Boolean;
    MaxMenuItemsInWindow: Integer;
    property First: Boolean read FFirst;
    property Visible: Boolean read FVisible;
    constructor CreateEx(AOwner: TComponent; AForm: TForm);
    destructor Destroy; override;
    procedure Popup(APopupCtrl: TControl; ASkinData: TbsSkinData; StartIndex: Integer;
                    R: TRect; AItem: TMenuItem; PopupUp: Boolean);
    procedure Popup2(APopupCtrl: TControl; ASkinData: TbsSkinData; StartIndex: Integer;
                    R: TRect; AItem, AItem2: TMenuItem; PopupUp: Boolean);
    procedure Hide;
    property DefaultMenuItemFont: TFont
      read FDefaultMenuItemFont write SetDefaultMenuItemFont;
    property DefaultMenuItemHeight: Integer
      read FDefaultMenuItemHeight write FDefaultMenuItemHeight;
    property UseSkinFont: Boolean
     read FUseSkinFont write FUseSkinFont;
    property OnMenuClose: TNotifyEvent read FOnMenuClose write FOnMenuClose;
  end;

  TbsSkinPopupMenu = class(TPopupMenu)
  private
    FPopupPoint: TPoint;
  protected
    FSD: TbsSkinData;
    FComponentForm: TForm;
    FOnMenuClose: TNotifyEvent;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Popup(X, Y: Integer); override;
    procedure PopupFromRect(R: TRect; APopupUp: Boolean);
    procedure Popup2(ACtrl: TControl; X, Y: Integer);
    procedure PopupFromRect2(ACtrl: TControl; R: TRect; APopupUp: Boolean);
    property ComponentForm: TForm read FComponentForm write FComponentForm;
    property PopupPoint: TPoint read FPopupPoint;
  published
    property SkinData: TbsSkinData read FSD write FSD;
    property OnMenuClose: TNotifyEvent read
      FOnMenuClose write FOnMenuClose;
  end;


  // Images menu ---------------------------------------------------------------
  TbsSkinImagesMenu = class;

  TbsImagesMenuItem = class(TCollectionItem)
  private
    FImageIndex: TImageIndex;
    FCaption: String;
    FOnClick: TNotifyEvent;
    FButton: Boolean;
    FHint: String;
  protected
    procedure SetImageIndex(const Value: TImageIndex); virtual;
    procedure SetCaption(const Value: String); virtual;
  public
    ItemRect: TRect;
    FColor: TColor;
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Button: Boolean read FButton write FButton;
    property Caption: String read FCaption write SetCaption;
    property Hint: String read FHint write FHint;
    property ImageIndex: TImageIndex read FImageIndex
      write SetImageIndex default -1;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TbsImagesMenuItems = class(TCollection)
  private
    function GetItem(Index: Integer):  TbsImagesMenuItem;
    procedure SetItem(Index: Integer; Value:  TbsImagesMenuItem);
  protected
    function GetOwner: TPersistent; override;
  public
    ImagesMenu: TbsSkinImagesMenu;
    constructor Create(AImagesMenu: TbsSkinImagesMenu);
    property Items[Index: Integer]:  TbsImagesMenuItem read GetItem write SetItem; default;
  end;

  TbsSkinImagesMenuPopupWindow = class(TCustomControl)
  private
    FSkinSupport: Boolean;
    OldAppMessage: TMessageEvent;
    ImagesMenu: TbsSkinImagesMenu;
    FRgn: HRGN;
    NewLTPoint, NewRTPoint,
    NewLBPoint, NewRBPoint: TPoint;
    NewItemsRect: TRect;
    WindowPicture, MaskPicture: TBitMap;
    MouseInItem, OldMouseInItem: Integer;
    FDown: Boolean;
    FItemDown: Boolean;
    procedure AssignItemRects;
    procedure CreateMenu;
    procedure HookApp;
    procedure UnHookApp;
    procedure NewAppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure SetMenuWindowRegion;
    procedure DrawItems(ActiveIndex, SelectedIndex: Integer; C: TCanvas);
    function GetItemRect(Index: Integer): TRect;
    function GetItemFromPoint(P: TPoint): Integer;
    procedure DrawItemCaption(ACaption: String; R: TRect; C: TCanvas; AActive, ADown: Boolean);
    procedure DrawActiveItem(R: TRect; C: TCanvas; ASelected: Boolean);
    procedure TestActive(X, Y: Integer);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMEraseBkGrnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Show(PopupRect: TRect);
    procedure Hide(AProcessEvents: Boolean);
    procedure Paint; override;
  end;

  TbsSkinImagesMenu = class(TComponent)
  private
    FImages: TCustomImageList;
    FImagesItems: TbsImagesMenuItems;
    FItemIndex: Integer;
    FColumnsCount: Integer;
    FOnItemClick: TNotifyEvent;
    FSkinData: TbsSkinData;
    FPopupWindow: TbsSkinImagesMenuPopupWindow;
    FShowSelectedItem: Boolean;
    FOldItemIndex: Integer;
    FOnChange: TNotifyEvent;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    FOnInternalChange: TNotifyEvent;
    FOnMenuClose: TNotifyEvent;
    FOnMenuPopup: TNotifyEvent;
    FOnInternalMenuClose: TNotifyEvent;
    FDefaultFont: TFont;
    FUseSkinFont: Boolean;
    FSkinHint: TbsSkinHint;
    FShowHints: Boolean;
    procedure SetDefaultFont(Value: TFont);
    procedure SetImagesItems(Value: TbsImagesMenuItems);
    procedure SetImages(Value: TCustomImageList);
    procedure SetColumnsCount(Value: Integer);
    procedure SetSkinData(Value: TbsSkinData);
    function GetSelectedItem: TbsImagesMenuItem;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ProcessEvents(ACanProcess: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Popup(X, Y: Integer);
    procedure PopupFromRect(R: TRect);
    procedure Hide;
    property SelectedItem: TbsImagesMenuItem read GetSelectedItem;
    property OnInternalChange: TNotifyEvent read FOnInternalChange write FOnInternalChange;
    property OnInternalMenuClose: TNotifyEvent read FOnInternalMenuClose write FOnInternalMenuClose;
  published
    property Images: TCustomImageList read FImages write SetImages;
    property SkinHint: TbsSkinHint read FSkinHint write FSkinHint;
    property ShowHints: Boolean read FShowHints write FShowHints;
    property ImagesItems: TbsImagesMenuItems read FImagesItems write SetImagesItems;
    property ItemIndex: Integer read FItemIndex write FItemIndex;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property ColumnsCount: Integer read FColumnsCount write SetColumnsCount;
    property SkinData: TbsSkinData read FSkinData write SetSkinData;
    property ShowSelectedItem: Boolean read FShowSelectedItem write FShowSelectedItem;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnMenuPopup: TNotifyEvent read FOnMenuPopup write FOnMenuPopup;
    property OnMenuClose: TNotifyEvent read FOnMenuClose write FOnMenuClose;
  end;

  function CanMenuClose(Msg: Cardinal): Boolean;

const
   WM_CLOSESKINMENU = WM_USER + 204;
   WM_AFTERDISPATCH = WM_USER + 205;

implementation

   Uses BusinessSkinForm, bsEffects, bsConst;

const
  MouseTimerInterval = 50;
  MorphTimerInterval = 20;
  MorphInc = 0.2;
  WaitTimerInterval = 500;
  MarkerItemHeight = 10;
  ScrollTimerInterval = 100;

  MI_MINNAME = 'BSF_MINITEM';
  MI_MAXNAME = 'BSF_MAXITEM';
  MI_CLOSENAME = 'BSF_CLOSE';
  MI_RESTORENAME = 'BSF_RESTORE';
  MI_MINTOTRAYNAME = 'BSF_MINTOTRAY';
  MI_ROLLUPNAME = 'BSF_ROLLUP';

  TMI_RESTORENAME = 'TRAY_BSF_RESTORE';
  TMI_CLOSENAME = 'TRAY_BSF_CLOSE';

  CS_DROPSHADOW_ = $20000;

procedure DrawCheckImage(Cnvs: TCanvas; X, Y: Integer; Color: TColor);
var
  i: Integer;
begin
  with Cnvs do
  begin
    Pen.Color := Color;
    for i := 0 to 2 do
    begin
      MoveTo(X, Y + 5 - i);
      LineTo(X + 2, Y + 7 - i);
      LineTo(X + 7, Y + 2 - i);
    end;
  end;
end;

procedure DrawSubImage(Cnvs: TCanvas; X, Y: Integer; Color: TColor);
var
  i: Integer;
begin
  with Cnvs do
  begin
    Pen.Color := Color;
    for i := 0 to 3 do
    begin
      MoveTo(X + i, Y + i);
      LineTo(X + i, Y + 7 - i);
    end;
  end;
end;

procedure DrawRadioImage(Cnvs: TCanvas; X, Y: Integer; Color: TColor);
begin
  with Cnvs do
  begin
    Pen.Color := Color;
    Brush.Color := Color;
    Ellipse(X, Y, X + 6, Y + 6);
  end;
end;

function RectWidth(R: TRect): Integer;
begin
  Result := R.Right - R.Left;
end;

function RectHeight(R: TRect): Integer;
begin
  Result := R.Bottom - R.Top;
end;

function CanMenuClose;
begin
  Result := False;
  case Msg of
    WM_MOUSEACTIVATE, WM_ACTIVATE,
    WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN,
    WM_NCLBUTTONDOWN, WM_NCMBUTTONDOWN, WM_NCRBUTTONDOWN,
    WM_KILLFOCUS, WM_MOVE, WM_SIZE, WM_CANCELMODE, WM_PARENTNOTIFY:
      Result := True;
  end;
end;

//===============TbsSkinMenuItem===================//
constructor TbsSkinMenuItem.Create;
begin
  WaitCommand := False;
  Parent := AParent;
  MenuItem := AMenuItem;
  FVisible := True;
  MI := AData;
  if MI <> nil
  then
    with AData do
    begin
      if (ActivePictureIndex <> - 1) and
         (ActivePictureIndex < Self.Parent.SD.FActivePictures.Count)
      then
        ActivePicture := Self.Parent.SD.FActivePictures.Items[ActivePictureIndex]
      else
        begin
          ActivePicture := nil;
          SkinRect := NullRect;
          ActiveSkinRect := NullRect;
        end;
    end;
  FMorphKf := 0;
  CurrentFrame := 0;
end;

function TbsSkinMenuItem.EnableMorphing: Boolean;
begin
  Result := (MI <> nil) and MI.Morphing and (Parent.SD <> nil) and
             not (Parent.SD.Empty) and
             Parent.SD.EnableSkinEffects;
end;

function TbsSkinMenuItem.EnableAnimation: Boolean;
begin
  Result := (MI <> nil) and not IsNullRect(MI.AnimateSkinRect) and (Parent.SD <> nil) and
             not (Parent.SD.Empty) and
             Parent.SD.EnableSkinEffects;
end;


function TbsSkinMenuItem.CanMorphing;
var
  AD: Boolean;
begin
  AD := Active or Down;
  Result := FVisible and ((AD and (MorphKf < 1)) or
                         (not AD and (MorphKf > 0)));
  if not FVisible and (FMorphKf <> 0)
  then
    begin
      Active := False;
      Down := False;
      FMorphKf := 0;
    end;
end;

procedure TbsSkinMenuItem.DoMorphing;
begin
  if Active or Down
  then MorphKf := MorphKf + MorphInc
  else MorphKf := MorphKf - MorphInc;
  Draw(Parent.Canvas);
end;

procedure TbsSkinMenuItem.SetMorphKf(Value: Double);
begin
  FMorphKf := Value;
  if FMorphKf < 0 then FMorphKf := 0 else
  if FMorphKf > 1 then FMorphKf := 1;
end;

procedure TbsSkinMenuItem.ReDraw;
begin
  if (MI <> nil) and EnableAnimation
  then
    begin
      if  Parent.MorphTimer.Interval <> MI.AnimateInterval
      then
        Parent.MorphTimer.Interval := MI.AnimateInterval;
       if EnableAnimation and not MI.InActiveAnimation and not Active
       then
        begin
          CurrentFrame := 0;
          Draw(Parent.Canvas);
       end
      else
        Parent.MorphTimer.Enabled := True
    end
  else
  if (MI <> nil) and EnableMorphing
  then
    begin
      if Parent.MorphTimer.Interval <> MorphTimerInterval
      then
        Parent.MorphTimer.Interval := MorphTimerInterval;
      Parent.MorphTimer.Enabled := True
    end
  else
    Draw(Parent.Canvas);
end;

procedure TbsSkinMenuItem.MouseDown(X, Y: Integer);
begin
  WaitCommand := False;
  if not Down and MenuItem.Enabled
  then
    Parent.ParentMenu.CheckItem(Parent, Self, True, False);
end;

procedure TbsSkinMenuItem.MouseEnter;
var
  i: Integer;
begin
  Active := True;
  if EnableAnimation then CurrentFrame := 0;          
  for i := 0 to Parent.ItemList.Count - 1 do
    if (TbsSkinMenuItem(Parent.ItemList.Items[i]) <> Self)
       and TbsSkinMenuItem(Parent.ItemList.Items[i]).Down
    then
      with TbsSkinMenuItem(Parent.ItemList.Items[i]) do
      begin
        Down := False;
        ReDraw;
      end;

  if WaitCommand and not Kb
  then
    begin
      ReDraw;
    end
  else  
  if not Down
  then
    begin
      ReDraw;
      Parent.ParentMenu.CheckItem(Parent, Self, False, Kb);
    end
  else
    with Parent.ParentMenu do
    begin
      i := GetPWIndex(Parent);
      if i + 2 < FPopupList.Count
      then
        TbsSkinPopupWindow(FPopupList.Items[i + 1]).UpDatePW;
    end;

  if Parent.Hint <> MenuItem.Hint then Parent.Hint := MenuItem.Hint;
end;

procedure TbsSkinMenuItem.MouseLeave;
begin
  Active := False;
  if EnableAnimation then CurrentFrame := MI.FrameCount + 1;
  WaitCommand := False;
  if not Down then ReDraw;
  with Parent.ParentMenu do
  begin
    if (WItem <> nil) and (WItem = Self)
    then
      begin
        WaitTimer.Enabled := False;
        WItem := nil;
      end;
  end;
end;

procedure TbsSkinMenuItem.DefaultDraw(Cnvs: TCanvas);
var
  MIShortCut: WideString;
  B: TBitMap;
  TextOffset: Integer;
  R, TR, SR: TRect;
  DrawGlyph: Boolean;
  GX, GY, IX, IY: Integer;
begin
  if MenuItem.ShortCut <> 0
  then
    MIShortCut := ShortCutToText(MenuItem.ShortCut)
  else
    MIShortCut := '';
  B := TBitMap.Create;
  B.Width := RectWidth(ObjectRect);
  B.Height := RectHeight(ObjectRect);

  if Parent.ImgL = nil
  then TextOffset := 19
  else TextOffset := Parent.GlyphWidth;

  with B.Canvas do
  begin
    R := Rect(0, 0, B.Width, B.Height);
    Font.Assign(Parent.ParentMenu.FDefaultMenuItemFont);
    if (Parent.ParentMenu.SkinData <> nil) and
       (Parent.ParentMenu.SkinData.ResourceStrData <> nil)
    then
      Font.CharSet := Self.Parent.ParentMenu.SkinData.ResourceStrData.Charset;
    if (Active or Down) and (MenuItem.Caption <> '-')
    then
      begin
        Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
        Brush.Color := BS_XP_BTNACTIVECOLOR;
        Font.Color := clWindowText;
        FillRect(R);
      end
    else
      begin
        R := Rect(0, 0, TextOffset, B.Height);
        Brush.Color := clBtnFace;
        FillRect(R);
        R := Rect(TextOffset, 0, B.Width, B.Height);
        Brush.Color := clWindow;
        if MenuItem.Enabled
        then
          Font.Color := clWindowText
        else
          Font.Color := clBtnShadow;
        FillRect(R);
      end;
  end;

  if MenuItem.Caption = '-'
  then
    begin
      R.Left := TextOffset;
      R.Top := B.Height div 2;
      R.Right := B.Width;
      R.Bottom := B.Height div 2 + 1;
      Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
      Cnvs.Draw(ObjectRect.Left, ObjectRect.Top, B);
      B.Free;
      Exit;
    end;

  TR := Rect(2, 2, B.Width - 2, B.Height - 2);
  // text
  R := Rect(TR.Left + TextOffset, 0, TR.Right - 19, 0);
  BSDrawSkinText(B.Canvas, MenuItem.Caption, R,
             DT_CALCRECT);
  OffsetRect(R, 0, TR.Top + RectHeight(TR) div 2 - R.Bottom div 2);
  Inc(R.Right, 2);
  BSDrawSkinText(B.Canvas, MenuItem.Caption, R,
    Parent.ParentMenu.FForm.DrawTextBiDiModeFlags(DT_CENTER or DT_VCENTER));
  // short cut
  if MIShortCut <> ''
  then
    begin
      SR := Rect(0, 0, 0, 0);
      BSDrawSkinText(B.Canvas, MIShortCut, SR, DT_CALCRECT);
      SR := Rect(TR.Right - SR.Right - 19, R.Top, TR.Right - 19, R.Bottom);
      BSDrawSkinText(B.Canvas, MIShortCut, SR,
       Parent.ParentMenu.FForm.DrawTextBiDiModeFlags(DT_CENTER or DT_VCENTER));
    end;
  //
  if MenuItem.Count <> 0
  then
    DrawSubImage(B.Canvas,
                 TR.Right - 7, TR.Top + RectHeight(TR) div 2 - 4,
                 B.Canvas.Font.Color);
  //
  DrawGlyph := (not MenuItem.Bitmap.Empty) or  ((Parent.ImgL <> nil) and (MenuItem.ImageIndex > -1) and
       (MenuItem.ImageIndex < Parent.ImgL.Count));

  if DrawGlyph
  then
    begin
      if not MenuItem.Bitmap.Empty
        then
          begin
            GX := TR.Left + 2;
            GY := TR.Top + RectHeight(TR) div 2 - MenuItem.Bitmap.Height div 2;
            if MenuItem.Checked
            then
              with B.Canvas do
              begin
                Brush.Style := bsClear;
                Pen.Color := Font.Color;
                Rectangle(GX - 1, GY - 1,
                          GX + MenuItem.Bitmap.Width + 1,
                          GY + MenuItem.Bitmap.Height + 1);
             end;
          end
        else
          begin
            GX := TR.Left + 2;
            GY := TR.Top + RectHeight(TR) div 2 - Parent.ImgL.Height div 2;
            if MenuItem.Checked
            then
              with B.Canvas do
              begin
                Brush.Style := bsClear;
                Pen.Color := Font.Color;
                Rectangle(GX - 1, GY - 1,
                          GX + Parent.ImgL.Width + 1,
                          GY + Parent.ImgL.Height + 1);
             end;
           end;
    end
  else
    begin
      GX := 0; GY := 0;
      IY := TR.Top + RectHeight(TR) div 2 - 4;
      IX := TR.Left + 2;
      if (MenuItem.Name = MI_CLOSENAME) or (MenuItem.Name = TMI_CLOSENAME)
      then DrawCloseImage(B.Canvas, IX, IY, B.Canvas.Font.Color) else
      if MenuItem.Name = MI_MINNAME
      then DrawMinimizeImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
      else
      if MenuItem.Name = MI_MAXNAME
      then DrawMaximizeImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
      else
      if (MenuItem.Name = MI_RESTORENAME) or (MenuItem.Name = TMI_RESTORENAME)
      then DrawRestoreImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
      else
      if MenuItem.Name = MI_ROLLUPNAME
      then DrawRollUpImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
      else
      if MenuItem.Name = MI_MINTOTRAYNAME
      then DrawMTImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
      else
      if MenuItem.Checked
      then
      if MenuItem.RadioItem
      then
        DrawRadioImage(B.Canvas,
                       TR.Left + 3, TR.Top + RectHeight(TR) div 2 - 3,
                       B.Canvas.Font.Color)
      else
        DrawCheckImage(B.Canvas,
                       TR.Left + 3, TR.Top + RectHeight(TR) div 2 - 4,
                       B.Canvas.Font.Color);
    end;
  //
 //
  if DrawGlyph
  then
    if not MenuItem.Bitmap.Empty
    then
      B.Canvas.Draw(GX, GY, MenuItem.BitMap)
    else
      Parent.ImgL.Draw(B.Canvas, GX, GY,
        MenuItem.ImageIndex, MenuItem.Enabled);
        
  Cnvs.Draw(ObjectRect.Left, ObjectRect.Top, B);
  B.Free;
end;

procedure TbsSkinMenuItem.Draw;
var
  GX, GY: Integer;
  DrawGlyph: Boolean; 
  kf: Double;
  SpecRect: TRect;

procedure CreateItemImage(B: TBitMap; AActive: Boolean; FromSpecRect: Boolean);
var
  R, TR, SR, Rct: TRect;
  TextOffset: Integer;
  MIShortCut: WideString;
  IX, IY: Integer;
  SE: Boolean;
begin

  if MenuItem.ShortCut <> 0
  then
    MIShortCut := ShortCutToText(MenuItem.ShortCut)
  else
    MIShortCut := '';

  if AActive
  then
    begin
      Rct := MI.ActiveSkinRect;
      SE := MI.StretchEffect;
    end
  else
    begin
      Rct := MI.SkinRect;
      SE := MI.InActiveStretchEffect;
      if not MI.InActiveStretchEffect and MI.StretchEffect
      then
        SE := MI.StretchEffect and FromSpecRect;
    end;

  if FromSpecRect then Rct := SpecRect;

  CreateHSkinImage(MI.ItemLO, MI.ItemRO,
   B, ActivePicture, Rct,
   RectWidth(ObjectRect), RectHeight(ObjectRect), SE);

  if Parent.ImgL = nil
  then TextOffset := 16
  else TextOffset := Parent.GlyphWidth;

  if not IsNullRect(MI.ImageRct) then TextOffset := 0; 

  TR := MI.TextRct;
  TR.Right := B.Width - (RectWidth(MI.SkinRect) - MI.TextRct.Right);

  with B.Canvas do
  begin
    Brush.Style := bsClear;

    if Self.Parent.ParentMenu.UseSkinFont
    then
      begin
        Font.Name := MI.FontName;
        Font.Style := MI.FontStyle;
        Font.Height := MI.FontHeight;
      end
    else
      Font.Assign(Self.Parent.ParentMenu.DefaultMenuItemFont);

    if (Self.Parent.ParentMenu.SkinData <> nil) and
       (Self.Parent.ParentMenu.SkinData.ResourceStrData <> nil)
    then
      Font.CharSet := Self.Parent.ParentMenu.SkinData.ResourceStrData.Charset
    else
      Font.CharSet := Self.Parent.ParentMenu.FDefaultMenuItemFont.Charset;
      
    if AActive
    then
      Font.Color := MI.ActiveFontColor
    else
      if MenuItem.Enabled
      then
        Font.Color := MI.FontColor
      else
        Font.Color := MI.UnEnabledFontColor;
    //
    if Assigned(MenuItem.OnDrawItem)
    then
      begin
        MenuItem.OnDrawItem(Self, B.Canvas, TR, AActive);
        Exit;
      end;
    //
    R := Rect(TR.Left + TextOffset, 0, TR.Right - 16, 0);
    BSDrawSkinText(B.Canvas, MenuItem.Caption, R, DT_CALCRECT);
    OffsetRect(R, 0, TR.Top + RectHeight(TR) div 2 - R.Bottom div 2);
    Inc(R.Right, 2);
    BSDrawSkinText(B.Canvas, MenuItem.Caption, R,
      Parent.ParentMenu.FForm.DrawTextBiDiModeFlags(DT_CENTER or DT_VCENTER));
    // shortcut
    if MIShortCut <> ''
    then
      begin
        SR := Rect(0, 0, 0, 0);
        BSDrawSkinText(B.Canvas, MIShortCut, SR, DT_CALCRECT);
        SR := Rect(TR.Right - SR.Right - 16, R.Top, TR.Right - 16, R.Bottom);
        BSDrawSkinText(B.Canvas,  MIShortCut, SR,
         Parent.ParentMenu.FForm.DrawTextBiDiModeFlags(DT_CENTER or DT_VCENTER));
      end;
    //
    if MenuItem.Count <> 0
    then
      DrawSubImage(B.Canvas,
                   TR.Right - 7, TR.Top + RectHeight(TR) div 2 - 4,
                   B.Canvas.Font.Color);
    //


    DrawGlyph := (not MenuItem.Bitmap.Empty) or  ((Parent.ImgL <> nil) and (MenuItem.ImageIndex > -1) and
       (MenuItem.ImageIndex < Parent.ImgL.Count));

    if MI.UseImageColor
    then
      begin
        if AActive
        then
          Font.Color := MI.ActiveImageColor
        else
          Font.Color := MI.ImageColor;
      end;

    if DrawGlyph
    then
      begin
        if not MenuItem.Bitmap.Empty
        then
          begin
            if IsNullRect(MI.ImageRct)
            then
              begin
                GX := TR.Left + 2;
                GY := TR.Top + RectHeight(TR) div 2 - MenuItem.Bitmap.Height div 2;
              end
            else
              begin
                GX := MI.ImageRct.Left + RectWidth(MI.ImageRct) div 2 -
                      MenuItem.Bitmap.Width div 2;
                GY := MI.ImageRct.Top + RectHeight(MI.ImageRct) div 2 - MenuItem.Bitmap.Height div 2;
              end;

            if MenuItem.Checked
            then
              begin
                Brush.Style := bsClear;
                Pen.Color := Font.Color;
                Rectangle(GX - 1, GY - 1,
                          GX + MenuItem.Bitmap.Width + 1,
                          GY + MenuItem.Bitmap.Height + 1);
             end;
          end
        else
          begin
            if IsNullRect(MI.ImageRct)
            then
              begin
                GX := TR.Left + 2;
                GY := TR.Top + RectHeight(TR) div 2 - Parent.ImgL.Height div 2;
              end
            else
              begin
                GX := MI.ImageRct.Left + RectWidth(MI.ImageRct) div 2 -
                       Parent.ImgL.Width div 2;
                GY := MI.ImageRct.Top + RectHeight(MI.ImageRct) div 2 - Parent.ImgL.Height div 2;
              end;
            if MenuItem.Checked
            then
              begin
                Brush.Style := bsClear;
                Pen.Color := Font.Color;
                Rectangle(GX - 1, GY - 1,
                          GX + Parent.ImgL.Width + 1,
                          GY + Parent.ImgL.Height + 1);
             end;
           end;
      end
    else
      begin
        if IsNullRect(MI.ImageRct)
        then
          begin
            IY := TR.Top + RectHeight(TR) div 2 - 4;
            IX := TR.Left + 2;
          end
        else
          begin
            IY := MI.ImageRct.Top + RectHeight(MI.ImageRct) div 2 - 4;
            IX := MI.ImageRct.Left + RectWidth(MI.ImageRct) div 2 - 4
          end;

        if (MenuItem.Name = MI_CLOSENAME) or (MenuItem.Name = TMI_CLOSENAME)
        then DrawCloseImage(B.Canvas, IX, IY, B.Canvas.Font.Color) else
        if MenuItem.Name = MI_MINNAME
        then DrawMinimizeImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
        else
        if MenuItem.Name = MI_MAXNAME
        then DrawMaximizeImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
        else
        if (MenuItem.Name = MI_RESTORENAME) or (MenuItem.Name = TMI_RESTORENAME)
        then DrawRestoreImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
        else
        if MenuItem.Name = MI_ROLLUPNAME
        then DrawRollUpImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
        else
        if MenuItem.Name = MI_MINTOTRAYNAME
        then DrawMTImage(B.Canvas, IX, IY, B.Canvas.Font.Color)
        else
        if MenuItem.Checked
        then
          if MenuItem.RadioItem
          then
            DrawRadioImage(B.Canvas,
                           IX, IY + 1,
                           B.Canvas.Font.Color)
          else
            DrawCheckImage(B.Canvas,
                           IX, IY,
                           B.Canvas.Font.Color);
      end;
  end;
  //
  if DrawGlyph
  then
    if not MenuItem.Bitmap.Empty
    then
      B.Canvas.Draw(GX, GY, MenuItem.BitMap)
    else
      Parent.ImgL.Draw(B.Canvas, GX, GY,
        MenuItem.ImageIndex, MenuItem.Enabled);
end;


function GetAnimationFrameRect: TRect;
var
  fs: Integer;
begin
  if RectHeight(MI.AnimateSkinRect) > RectHeight(MI.SkinRect)
  then
    begin
      fs := RectHeight(MI.AnimateSkinRect) div MI.FrameCount;
      Result := Rect(MI.AnimateSkinRect.Left,
                     MI.AnimateSkinRect.Top + (CurrentFrame - 1) * fs,
                     MI.AnimateSkinRect.Right,
                     MI.AnimateSkinRect.Top + CurrentFrame * fs);
    end
  else
    begin
      fs := RectWidth(MI.AnimateSkinRect) div MI.FrameCount;
      Result := Rect(MI.AnimateSkinRect.Left + (CurrentFrame - 1) * fs,
                 MI.AnimateSkinRect.Top,
                 MI.AnimateSkinRect.Left + CurrentFrame * fs,
                 MI.AnimateSkinRect.Bottom);
    end;
end;


var
  B, AB: TBitMap;
  EffB, EffAB: TbsEffectBmp;
  AD: Boolean;
begin
  if not FVisible then Exit;
  if MI = nil
  then
    begin
      DefaultDraw(Cnvs);
      Exit;
    end;  
  B := TBitMap.Create;
  if MenuItem.Caption = '-'
  then
    begin
      CreateHSkinImage(MI.DividerLO, MI.DividerRO,
        B, ActivePicture, MI.DividerRect,
       RectWidth(ObjectRect), RectHeight(ObjectRect), MI.DividerStretchEffect);
    end   
  else
    begin
      AD := Active or Down;
      if EnableAnimation and  
      (CurrentFrame >= 1) and (CurrentFrame <= MI.FrameCount)
      then
        begin
          SpecRect := GetAnimationFrameRect;
          CreateItemImage(B, AD, True);
        end
      else
      if not EnableMorphing or
      ((AD and (MorphKf = 1)) or (not AD and (MorphKf  = 0)))
      then
        CreateItemImage(B, AD, False)
      else
        begin
          CreateItemImage(B, False, False);
          AB := TBitMap.Create;
          CreateItemImage(AB, True, False);
          EffB := TbsEffectBmp.CreateFromhWnd(B.Handle);
          EffAB := TbsEffectBmp.CreateFromhWnd(AB.Handle);
          case MI.MorphKind of
            mkDefault: EffB.Morph(EffAB, MorphKf);
            mkGradient: EffB.MorphGrad(EffAB, MorphKf);
            mkLeftGradient: EffB.MorphLeftGrad(EffAB, MorphKf);
            mkRightGradient: EffB.MorphRightGrad(EffAB, MorphKf);
            mkLeftSlide: EffB.MorphLeftSlide(EffAB, MorphKf);
            mkRightSlide: EffB.MorphRightSlide(EffAB, MorphKf);
            mkPush: EffB.MorphPush(EffAB, MorphKf);
          end;
          EffB.Draw(B.Canvas.Handle, 0, 0);
          AB.Free;
          EffB.Free;
          EffAB.Free;
        end;
    end;
  Cnvs.Draw(ObjectRect.Left, ObjectRect.Top, B);
  B.Free;
end;


//================TbsSkinPopupWindow======================//
constructor TbsSkinPopupWindow.CreateEx;
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable,
                  csAcceptsControls];

  ParentMenu := AParentMenu;

  Ctl3D := False;
  ParentCtl3D := False;
  Visible := False;
  ItemList := TList.Create;

  MouseTimer := TTimer.Create(Self);
  MouseTimer.Enabled := False;
  MouseTimer.OnTimer := TestMouse;
  MouseTimer.Interval := MouseTimerInterval;

  MorphTimer := TTimer.Create(Self);
  MorphTimer.Enabled := False;
  MorphTimer.OnTimer := TestMorph;
  MorphTimer.Interval := MorphTimerInterval;

  FRgn := 0;

  WindowPicture := nil;
  MaskPicture := nil;

  if (AData = nil) or (AData.WindowPictureIndex = -1)
  then
    begin
      PW := nil;
      SD := nil;
    end
  else
    begin
      PW := AData;
      SD := ParentMenu.SkinData;
      with PW do
      begin
        if (WindowPictureIndex <> - 1) and
           (WindowPictureIndex < SD.FActivePictures.Count)
        then
          WindowPicture := SD.FActivePictures.Items[WindowPictureIndex];

        if (MaskPictureIndex <> - 1) and
           (MaskPictureIndex < SD.FActivePictures.Count)
        then
          MaskPicture := SD.FActivePictures.Items[MaskPictureIndex];
      end;
    end;

  ActiveItem := -1;
  OldActiveItem := -1;

  OMX := -1;
  OMY := -1;

  DSMI := nil;
  ScrollCode := 0;
  Scroll2 := False;
end;

destructor TbsSkinPopupWindow.Destroy;
var
  i: Integer;
begin
  for i := 0 to ItemList.Count - 1 do
    TbsSkinMenuItem(ItemList.Items[i]).Free;
  ItemList.Clear;
  ItemList.Free;
  MouseTimer.Free;
  MorphTimer.Free;
  inherited Destroy;
  if FRgn <> 0 then DeleteObject(FRgn);
end;

procedure TbsSkinPopupWindow.TestMorph;
var
  i: Integer;
  StopMorph: Boolean;
begin
  if PW = nil then Exit;
  StopMorph := True;
  for i := 0 to ItemList.Count  - 1 do
    with TbsSkinMenuItem(ItemList.Items[i]) do
    begin
      if EnableMorphing and CanMorphing
      then
        begin
          DoMorphing;
          StopMorph := False;
        end
      else
      if EnableAnimation
      then
        begin
          if Active and (CurrentFrame <= MI.FrameCount)
            then
              begin
                Inc(CurrentFrame);
                Draw(Canvas);
                StopMorph := False;
              end
            else
            if not Active and (CurrentFrame > 0)
            then
              begin
                Dec(CurrentFrame);
                Draw(Canvas);
                StopMorph := False;
              end;
        end;
    end;
  if StopMorph then MorphTimer.Enabled := False;
end;


function TbsSkinPopupWindow.CanScroll;
begin
  Result := False;
  case AScrollCode of
    1: Result := VisibleStartIndex > 0;
    2: Result := VisibleStartIndex + VisibleCount - 1 < ItemList.Count - 1;
  end;
end;

procedure TbsSkinPopupWindow.WMTimer;
begin
  inherited;
  case ScrollCode of
    1: if CanScroll(1) then ScrollUp(False) else StopScroll;
    2: if CanScroll(2) then ScrollDown(False) else StopScroll;
  end;
end;

procedure TbsSkinPopupWindow.DrawUpMarker;
var
  R: TRect;
  C: TColor;
begin
  if PW <> nil
  then
    begin
      R := Rect(NewItemsRect.Left, NewItemsRect.Top,
                NewItemsRect.Right, NewItemsRect.Top + MarkerItemHeight);
      if ScrollCode = 1
      then C := PW.ScrollMarkerActiveColor
      else C := PW.ScrollMarkerColor;
    end
  else
    begin
      R := Rect(3, 3, Width - 3, 3 + MarkerItemHeight);
      if ScrollCode = 1
      then C := clBtnText
      else C := clBtnShadow;
    end;  
  DrawArrowImage(Cnvs, R, C, 3);
end;

procedure TbsSkinPopupWindow.DrawDownMarker;
var
  R: TRect;
  C: TColor;
begin
  if PW <> nil
  then
    begin
      R := Rect(NewItemsRect.Left, NewItemsRect.Bottom - MarkerItemHeight,
            NewItemsRect.Right, NewItemsRect.Bottom);
      if ScrollCode = 2
      then C := PW.ScrollMarkerActiveColor
      else C := PW.ScrollMarkerColor;
    end
  else
    begin
      R := Rect(3, Height - MarkerItemHeight, Width - 3, Height - 3);
      if ScrollCode = 2
      then C := clBtnText
      else C := clBtnShadow;
    end;
  DrawArrowImage(Cnvs, R, C, 4);
end;

procedure TbsSkinPopupWindow.StartScroll;
var
  i: Integer;
begin
  i := ParentMenu.GetPWIndex(Self);
  ParentMenu.CloseMenu(i + 1);
  KillTimer(Handle, 1);
  SetTimer(Handle, 1, ScrollTimerInterval, nil);
end;

procedure TbsSkinPopupWindow.StopScroll;
begin
  ScrollCode := 0;
  DrawUpMarker(Canvas);
  DrawDownMarker(Canvas);
  KillTimer(Handle, 1);
end;

procedure TbsSkinPopupWindow.ScrollUp;
begin
  if VisibleStartIndex > 0
  then
    begin
      VisibleStartIndex := VisibleStartIndex - 1;
      CalcItemRects;
      RePaint;
    end
  else
    if Cycle
    then
      begin
        VisibleStartIndex := GetEndStartVisibleIndex;
        CalcItemRects;
        RePaint;
      end;
end;

procedure TbsSkinPopupWindow.ScrollDown(Cycle: Boolean);
begin
  if VisibleStartIndex + VisibleCount - 1 < ItemList.Count - 1
  then
    begin
      VisibleStartIndex := VisibleStartIndex + 1;
      CalcItemRects;
      RePaint;
    end
  else
    if Cycle
    then
      begin
        VisibleStartIndex := 0;
        CalcItemRects;
        RePaint;
      end;
end;

procedure TbsSkinPopupWindow.PopupKeyDown(CharCode: Integer);
var
  PW: TbsSkinPopupWindow;

 procedure NextItem;
 var
   i, j: Integer;
 begin
   if Scroll and (ScrollCode = 0) and (ActiveItem = VisibleStartIndex + VisibleCount - 1)
   then ScrollDown(True);
   OldActiveItem := ActiveItem;
   if ActiveItem < 0 then j := 0 else j := ActiveItem + 1;
   if j = ItemList.Count then j := 0;
   for i := j to ItemList.Count - 1 do
     with TbsSkinMenuItem(ItemList.Items[i]) do
     begin
       if MenuItem.Enabled and (MenuItem.Caption <> '-')
       then
         begin
           ActiveItem := i;
           Break;
         end
       else
         begin
           if Scroll and (ScrollCode = 0) and (i = VisibleStartIndex + VisibleCount - 1)
           then ScrollDown(True);
         end;
     end;

   if OldActiveItem <> ActiveItem
   then
     begin
       if ActiveItem > -1 then
       with TbsSkinMenuItem(ItemList.Items[ActiveItem]) do
       begin
         MouseEnter(True);
       end;
       if OldActiveItem > -1 then
       with TbsSkinMenuItem(ItemList.Items[OldActiveItem]) do
        begin
          MouseLeave;
        end;
     end;
 end;

 procedure PriorItem;
 var
   i, j: Integer;
 begin
   if Scroll and (ScrollCode = 0) and (ActiveItem = VisibleStartIndex)
   then ScrollUp(True);
   OldActiveItem := ActiveItem;
   if ActiveItem < 0 then j := ItemList.Count - 1 else j := ActiveItem - 1;
   if (j = -1) then j := ItemList.Count - 1;
   for i := j downto 0 do
     with TbsSkinMenuItem(ItemList.Items[i]) do
     begin
       if MenuItem.Enabled and (MenuItem.Caption <> '-')
       then
         begin
           ActiveItem := i;
           Break;
         end
       else
         begin
           if Scroll and (ScrollCode = 0) and  (i = VisibleStartIndex)
           then ScrollUp(True);
         end;
     end;

   if OldActiveItem <> ActiveItem
   then
     begin
       if ActiveItem > -1 then
       with TbsSkinMenuItem(ItemList.Items[ActiveItem]) do
       begin
         MouseEnter(True);
       end;
       if OldActiveItem > -1 then
       with TbsSkinMenuItem(ItemList.Items[OldActiveItem]) do
        begin
          MouseLeave;
        end;
     end;
 end;

function FindHotKeyItem: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to ItemList.Count - 1 do
      with TbsSkinMenuItem(ItemList.Items[i]) do
      begin
        if Enabled and IsAccel(CharCode, MenuItem.Caption)
        then
          begin
            MouseEnter(False);
            OldActiveItem := ActiveItem;
            ActiveItem := i;
            if OldActiveItem <> -1
            then
              TbsSkinMenuItem(ItemList.Items[OldActiveItem]).MouseLeave;
            MouseDown(0, 0);
            Result := True;
            Break;
          end;
      end
end;

begin
  if not Visible then Exit;
  if not FindHotKeyItem
  then 
  case CharCode of
    VK_DOWN:
      NextItem;
    VK_UP:
      PriorItem;
    VK_RIGHT:
      begin
        if ActiveItem <> -1
        then
          with TbsSkinMenuItem(ItemList.Items[ActiveItem]) do
          begin
            if MenuItem.Count <> 0 then MouseDown(0, 0);
          end;
      end;
    VK_RETURN:
      begin
        if ActiveItem <> -1
        then
          with TbsSkinMenuItem(ItemList.Items[ActiveItem]) do
          begin
            MouseDown(0, 0);
          end;
      end;
    VK_LEFT:
      begin
        if ParentMenu.FPopupList.Count > 1
        then
          begin
            ParentMenu.CloseMenu(ParentMenu.FPopupList.Count - 1);
            PW := TbsSkinPopupWindow(ParentMenu.FPopupList.Items[ParentMenu.FPopupList.Count - 1]);
            if PW.ActiveItem <> -1
            then
              TbsSkinMenuItem(PW.ItemList.Items[PW.ActiveItem]).Down := False;
          end
      end;
    VK_ESCAPE:
      begin
        ParentMenu.CloseMenu(ParentMenu.FPopupList.Count - 1);
        if ParentMenu.FPopupList.Count > 0
        then
          begin
            PW := TbsSkinPopupWindow(ParentMenu.FPopupList.Items[ParentMenu.FPopupList.Count - 1]);
            if PW.ActiveItem <> -1
            then
              TbsSkinMenuItem(PW.ItemList.Items[PW.ActiveItem]).Down := False;
          end;   
      end;
  end;
end;

procedure TbsSkinPopupWindow.UpDatePW;
var
  i: Integer;
  j: Integer;
begin
  j := ParentMenu.GetPWIndex(Self);
  if j + 1 < ParentMenu.FPopupList.Count
  then ParentMenu.CloseMenu(j + 1);
  for i := 0 to ItemList.Count - 1 do
    if TbsSkinMenuItem(ItemList.Items[i]).Down
    then
      with TbsSkinMenuItem(ItemList.Items[i]) do
      begin
        Down := False;
        if EnableAnimation and not MI.InActiveAnimation
        then
          begin
            CurrentFrame := 0;
            Draw(Canvas);
          end
        else
          ReDraw;
      end;
end;

procedure TbsSkinPopupWindow.SetMenuWindowRegion;
var
  TempRgn: HRgn;
begin
  if PW = nil then Exit;
  TempRgn := FRgn;
  CreateSkinRegion
    (FRgn, PW.LTPoint, PW.RTPoint, PW.LBPoint, PW.RBPoint, PW.ItemsRect,
     NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewItemsRect,
     MaskPicture, Width, Height);
  SetWindowRgn(Handle, FRgn, True);
  if TempRgn <> 0 then DeleteObject(TempRgn);
end;

procedure TbsSkinPopupWindow.CreateRealImage;
var
  R: TRect;
  TextOffset: Integer;
begin
  if PW <> nil
  then
    CreateSkinImageBS(PW.LTPoint, PW.RTPoint, PW.LBPoint, PW.RBPoint,
      PW.ItemsRect, NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint,
      NewItemsRect, B, WindowPicture,
      Rect(0, 0, WindowPicture.Width, WindowPicture.Height),
      Width, Height, Scroll, PW.LeftStretch, PW.TopStretch,
      PW.RightStretch, PW.BottomStretch)
  else
    begin
      B.Width := Width;
      B.Height := Height;
      with B.Canvas do
      begin
        if ImgL = nil
        then TextOffset := 21
        else TextOffset := GlyphWidth + 2;
        R := Rect(0, 0, TextOffset, Height);
        Brush.Color := clBtnFace;
        FillRect(R);
        R := Rect(TextOffset, 0, Width, Height);
        Brush.Color := clWindow;
        FillRect(R);
      end;
      R := Rect(0, 0, Width, Height);
      Frame3D(B.Canvas, R, clBtnShadow, clBtnShadow, 1);
      Frame3D(B.Canvas, R, clWindow, clWindow, 1);
    end;
end;

procedure TbsSkinPopupWindow.CreateMenu2;
var
  sw, sh: Integer;
  i, j: Integer;
  Menu: TMenu;

  function CalcItemTextWidth(Item: TMenuItem): Integer;
  var
    R: TRect;
    MICaption: WideString;
  begin
   if Item.ShortCut <> 0
   then
     MICaption := Item.Caption + '  ' + ShortCutToText(Item.ShortCut)
   else
     MICaption := Item.Caption;
    R := Rect(0, 0, 0, 0);
    BSDrawSkinText(Canvas, MICaption, R, DT_CALCRECT);
    Result := R.Right + 2;
  end;

  function GetMenuWindowHeight: Integer;
  var
    i, j, k, ih: integer;
  begin
    j := 0;
    k := 0;
    for i := VisibleStartIndex to VisibleCount - 1 do
    with TbsSkinMenuItem(ItemList.Items[i]) do
     begin
      if PW <> nil
      then
        begin
          if MenuItem.Caption = '-'
          then ih := RectHeight(DSMI.DividerRect)
          else ih := RectHeight(DSMI.SkinRect);
        end
      else
        begin
          if MenuItem.Caption = '-'
          then ih := 4
          else ih := ParentMenu.DefaultMenuItemHeight;
        end;
      inc(j, ih);
      inc(k);
    end;

    if (ParentMenu.MaxMenuItemsInWindow <> 0) and (ParentMenu.MaxMenuItemsInWindow < k)
    then
      begin
        if PW <> nil
        then
          ih := RectHeight(DSMI.SkinRect)
        else
          ih := ParentMenu.DefaultMenuItemHeight;
        j := ParentMenu.MaxMenuItemsInWindow * ih;
        if PW <> nil
        then
          Result := j + PW.ItemsRect.Top + (WindowPicture.Height - PW.ItemsRect.Bottom)
        else
          Result := j + 6;
        Result := Result + MarkerItemHeight * 2;
      end
    else
      begin
        if PW <> nil
        then
          Result := j + PW.ItemsRect.Top + (WindowPicture.Height - PW.ItemsRect.Bottom)
        else
          Result := j + 6;
      end;    
  end;

  function GetMenuWindowWidth: Integer;
  var
    i, iw: Integer;
  begin
    iw := 0;
    for i := 0 to ItemList.Count - 1 do
    begin
      j := CalcItemTextWidth(TbsSkinMenuItem(ItemList.Items[i]).MenuItem);
      if j > iw then iw := j;
    end;
    inc(iw, 19);
    if ImgL <> nil
    then
      GlyphWidth := ImgL.Width + 5
    else
      GlyphWidth := 19;
    Inc(iw, GlyphWidth);
    if PW <> nil
    then
      begin
        Inc(iw, DSMI.TextRct.Left);
        Inc(iw, RectWidth(DSMI.SkinRect) - DSMI.TextRct.Right);
        Result := iw + PW.ItemsRect.Left + (WindowPicture.Width - PW.ItemsRect.Right);
      end
    else
      Result := iw + 10;
  end;


procedure CalcSizes;
var
  W, H: Integer;
begin
  //
  VisibleStartIndex := 0;
  VisibleCount := ItemList.Count;
  Scroll := False;
  Scroll2 := False;
  W := GetMenuWindowWidth;
  H := GetMenuWindowHeight;
  //
  if H > RectHeight(ParentMenu.WorkArea)
  then
    begin
      H := RectHeight(ParentMenu.WorkArea);
      Scroll := True;
    end;  
  //
  Width := W;
  Height := H;
end;

function GetMenuItemData: TbsDataSkinMenuItem;
var
  i: Integer;
begin
  Result := nil;
  if (SD <> nil) and not SD.Empty
  then 
    for i := 0 to SD.ObjectList.Count - 1 do
    if TbsDataSkinObject(SD.ObjectList.Items[i]) is TbsDataSkinMenuItem
    then
      begin
        Result := TbsDataSkinMenuItem(SD.ObjectList.Items[i]);
        Break;
      end;
end;

var
  TmpStartIndex: Integer;
begin
  DSMI := GetMenuItemData;
  if (PW <> nil) and (DSMI <> nil) and ParentMenu.UseSkinFont
  then
    begin
      with Canvas.Font do
      begin
        Height := DSMI.FontHeight;
        Style := DSMI.FontStyle;
        Name := DSMI.FontName;
      end;
    end
  else
    Canvas.Font.Assign(Self.ParentMenu.FDefaultMenuItemFont);

  if (ParentMenu.SkinData <> nil) and
     (ParentMenu.SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.CharSet := ParentMenu.SkinData.ResourceStrData.Charset
  else
    Canvas.Font.CharSet := ParentMenu.FDefaultMenuItemFont.Charset;

  Menu := Item.GetParentMenu;

  if (Menu <> nil) and (Menu.AutoLineReduction = maAutomatic)
  then
    Item.RethinkLines;

  if Menu <> nil
  then
    ImgL := Menu.Images
  else
    ImgL := nil;

  j := Item.Count;
  if StartIndex < j then
  for i := StartIndex to  j - 1 do
   if TMenuItem(Item.Items[i]).Visible
   then
     begin
       if TMenuItem(Item.Items[i]).Action <> nil
       then
         TMenuItem(Item.Items[i]).Action.Update;
       ItemList.Add(TbsSkinMenuItem.Create(Self, TMenuItem(Item.Items[i]), DSMI));
     end;

  TmpStartIndex := StartIndex - Item.Count;
  if TmpStartIndex < 0 then TmpStartIndex := 0;
  j := Item2.Count;
  if TmpStartIndex < j then
  for i := TmpStartIndex to  j - 1 do
   if TMenuItem(Item2.Items[i]).Visible
   then
     begin
       if TMenuItem(Item2.Items[i]).Action <> nil
       then
         TMenuItem(Item2.Items[i]).Action.Update;
       ItemList.Add(TbsSkinMenuItem.Create(Self, TMenuItem(Item2.Items[i]), DSMI));
     end;
  //

  CalcSizes;

  if PW <> nil
  then
    begin
      sw := WindowPicture.Width;
      sh := WindowPicture.Height;
      NewLTPoint := PW.LTPoint;
      NewRTPoint := Point(Width - (sw - PW.RTPoint.X), PW.RTPoint.Y);
      NewLBPoint := Point(PW.LBPoint.X, Height - (sh - PW.LBPoint.Y));
      NewRBPoint := Point(Width - (sw - PW.RBPoint.X),
                          Height - (sh - PW.RBPoint.Y));

      NewItemsRect := Rect(PW.ItemsRect.Left, PW.ItemsRect.Top,
                           Width - (sw - PW.ItemsRect.Right),
                           Height - (sh - PW.ItemsRect.Bottom));

    end
  else
    NewItemsRect := Rect(2, 2, Width - 2, Height - 2);
  CalcItemRects;
  if MaskPicture <> nil then SetMenuWindowRegion;

end;

procedure TbsSkinPopupWindow.CreateMenu;
var
  sw, sh: Integer;
  i, j: Integer;
  Menu: TMenu;

  function CalcItemTextWidth(Item: TMenuItem): Integer;
  var
    R: TRect;
    MICaption: WideString;
  begin
   if Item.ShortCut <> 0
   then
     MICaption := Item.Caption + '  ' + ShortCutToText(Item.ShortCut)
   else
     MICaption := Item.Caption;
    R := Rect(0, 0, 0, 0);
    BSDrawSkinText(Canvas, MICaption, R, DT_CALCRECT);
    Result := R.Right + 2;
  end;

  function GetMenuWindowHeight: Integer;
  var
    i, j, k, ih: integer;
  begin
    j := 0;
    k := 0;
    for i := VisibleStartIndex to VisibleCount - 1 do
    with TbsSkinMenuItem(ItemList.Items[i]) do
     begin
      if PW <> nil
      then
        begin
          if MenuItem.Caption = '-'
          then ih := RectHeight(DSMI.DividerRect)
          else ih := RectHeight(DSMI.SkinRect);
        end
      else
        begin
          if MenuItem.Caption = '-'
          then ih := 4
          else ih := ParentMenu.DefaultMenuItemHeight;
        end;
      inc(j, ih);
      inc(k);
    end;

    if (ParentMenu.MaxMenuItemsInWindow <> 0) and (ParentMenu.MaxMenuItemsInWindow < k)
    then
      begin
        if PW <> nil
        then
          ih := RectHeight(DSMI.SkinRect)
        else
          ih := ParentMenu.DefaultMenuItemHeight;
        j := ParentMenu.MaxMenuItemsInWindow * ih;
        if PW <> nil
        then
          Result := j + PW.ItemsRect.Top + (WindowPicture.Height - PW.ItemsRect.Bottom)
        else
          Result := j + 4;
        Result := Result + MarkerItemHeight * 2;
        Self.Scroll := True;
        Self.Scroll2 := True;
      end
    else
      begin
        if PW <> nil
        then
          Result := j + PW.ItemsRect.Top + (WindowPicture.Height - PW.ItemsRect.Bottom)
        else
          Result := j + 4;
      end;    
  end;

  function GetMenuWindowWidth: Integer;
  var
    i, iw: Integer;
  begin
    iw := 0;
    for i := 0 to ItemList.Count - 1 do
    begin
      j := CalcItemTextWidth(TbsSkinMenuItem(ItemList.Items[i]).MenuItem);
      if j > iw then iw := j;
    end;
    inc(iw, 19);
    if ImgL <> nil
    then
      GlyphWidth := ImgL.Width + 5
    else
      GlyphWidth := 19;
    Inc(iw, GlyphWidth);
    if PW <> nil
    then
      begin
        Inc(iw, DSMI.TextRct.Left);
        Inc(iw, RectWidth(DSMI.SkinRect) - DSMI.TextRct.Right);
        Result := iw + PW.ItemsRect.Left + (WindowPicture.Width - PW.ItemsRect.Right);
      end
    else
      Result := iw + 10;
  end;


procedure CalcSizes;
var
  W, H: Integer;
begin
  //
  VisibleStartIndex := 0;
  VisibleCount := ItemList.Count;
  Scroll := False;
  Scroll2 := False;
  W := GetMenuWindowWidth;
  H := GetMenuWindowHeight;
  //
  if H > RectHeight(ParentMenu.WorkArea)
  then
    begin
      H := RectHeight(ParentMenu.WorkArea);
      Scroll := True;
    end;  
  //
  Width := W;
  Height := H;
end;

function GetMenuItemData: TbsDataSkinMenuItem;
var
  i: Integer;
begin
  Result := nil;
  if (SD <> nil) and not SD.Empty
  then
    for i := 0 to SD.ObjectList.Count - 1 do
    if TbsDataSkinObject(SD.ObjectList.Items[i]) is TbsDataSkinMenuItem
    then
      begin
        Result := TbsDataSkinMenuItem(SD.ObjectList.Items[i]);
        Break;
      end;
end;

begin
  DSMI := GetMenuItemData;
  if (PW <> nil) and (DSMI <> nil) and ParentMenu.UseSkinFont
  then
    begin
      with Canvas.Font do
      begin
        Height := DSMI.FontHeight;
        Style := DSMI.FontStyle;
        Name := DSMI.FontName;
      end;
    end
  else
    Canvas.Font.Assign(Self.ParentMenu.FDefaultMenuItemFont);

  if (ParentMenu.SkinData <> nil) and
     (ParentMenu.SkinData.ResourceStrData <> nil)
  then
    Canvas.Font.CharSet := ParentMenu.SkinData.ResourceStrData.Charset
  else
    Canvas.Font.CharSet := ParentMenu.FDefaultMenuItemFont.Charset;

  Menu := Item.GetParentMenu;

  if (Menu <> nil) and (Menu.AutoLineReduction = maAutomatic)
  then
    Item.RethinkLines;

  if Menu <> nil
  then
    ImgL := Menu.Images
  else
    ImgL := nil;
  j := Item.Count;
  for i := StartIndex to  j - 1 do
   if TMenuItem(Item.Items[i]).Visible
   then
     begin
       if TMenuItem(Item.Items[i]).Action <> nil
       then
         TMenuItem(Item.Items[i]).Action.Update;
       ItemList.Add(TbsSkinMenuItem.Create(Self, TMenuItem(Item.Items[i]), DSMI));
     end;
  //

  CalcSizes;

  if PW <> nil
  then
    begin
      sw := WindowPicture.Width;
      sh := WindowPicture.Height;
      NewLTPoint := PW.LTPoint;
      NewRTPoint := Point(Width - (sw - PW.RTPoint.X), PW.RTPoint.Y);
      NewLBPoint := Point(PW.LBPoint.X, Height - (sh - PW.LBPoint.Y));
      NewRBPoint := Point(Width - (sw - PW.RBPoint.X),
                          Height - (sh - PW.RBPoint.Y));

      NewItemsRect := Rect(PW.ItemsRect.Left, PW.ItemsRect.Top,
                           Width - (sw - PW.ItemsRect.Right),
                           Height - (sh - PW.ItemsRect.Bottom));

    end
  else
    NewItemsRect := Rect(2, 2, Width - 2, Height - 2);
  CalcItemRects;
  if MaskPicture <> nil then SetMenuWindowRegion;
end;

function TbsSkinPopupWindow.GetEndStartVisibleIndex: Integer;
var
  i, j, k, ih, H: Integer;
begin
  j := NewItemsRect.Bottom - MarkerItemHeight;
  H := MarkerItemHeight;
  k := 0;
  for i := ItemList.Count - 1 downto 0 do
  begin
    with TbsSkinMenuItem(ItemList.Items[i]) do
     begin
       if DSMI <> nil
       then
         begin
           if MenuItem.Caption = '-'
           then ih := RectHeight(DSMI.DividerRect)
           else ih := RectHeight(DSMI.SkinRect);
         end
       else
         begin
           if MenuItem.Caption = '-'
           then ih := 4
           else ih := ParentMenu.DefaultMenuItemHeight;
         end;
       j := j - ih;
       if j >= H
       then
         inc(k)
       else
         Break;
     end;
  end;
  Result := ItemList.Count - k;
end;

procedure TbsSkinPopupWindow.CalcItemRects;
var
  i, j, ih, H: Integer;
begin
  j := NewItemsRect.Top;
  H := NewItemsRect.Bottom;
  if Scroll
  then
    begin
      H := H - MarkerItemHeight;
      j := j + MarkerItemHeight;
    end;
  VisibleCount := 0;
  for i := VisibleStartIndex to ItemList.Count - 1 do
    with TbsSkinMenuItem(ItemList.Items[i]) do
     begin
      if DSMI <> nil
      then
        begin
          if MenuItem.Caption = '-'
          then ih := RectHeight(DSMI.DividerRect)
          else ih := RectHeight(DSMI.SkinRect)
        end
      else
        begin
          if MenuItem.Caption = '-'
          then ih := 4
          else ih := ParentMenu.DefaultMenuItemHeight;
        end;
      ObjectRect.Left := NewItemsRect.Left;
      ObjectRect.Right := NewItemsRect.Right;
      ObjectRect.Top := j;
      ObjectRect.Bottom :=  j + ih;
      if ObjectRect.Bottom <= H
      then
        begin
          FVisible := True;
          Inc(VisibleCount)
        end
      else
        Break;
      inc(j, ih);
    end;

  if Scroll
  then
    begin
      if VisibleStartIndex > 0
      then
        for i := 0 to VisibleStartIndex - 1 do
          TbsSkinMenuItem(ItemList.Items[i]).FVisible := False;
      if VisibleCount + VisibleStartIndex <= ItemList.Count - 1
      then
        for i := VisibleCount + VisibleStartIndex to ItemList.Count - 1 do
          TbsSkinMenuItem(ItemList.Items[i]).FVisible := False;
    end;

end;

procedure TbsSkinPopupWindow.CMMouseEnter;
begin
  inherited;
end;

procedure TbsSkinPopupWindow.CMMouseLeave;
begin
  inherited;
end;

procedure TbsSkinPopupWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if CheckWXP then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW_ ;
  end;
end;

procedure TbsSkinPopupWindow.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TbsSkinPopupWindow.Hide;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  MorphTimer.Enabled := False;
  MouseTimer.Enabled := False;
  Visible := False;
end;

procedure TbsSkinPopupWindow.Show;

procedure CalcMenuPos(var X, Y: Integer; R: TRect);
var
  WA: TRect;
  ChangeY: Boolean;

  function GetY: Integer;
  var
    Offset: Integer;
  begin
    if Scroll and not Scroll2
    then
      Result := WA.Top
    else
      begin
        if PopupByItem
        then
          begin
            Offset := R.Top + Height - NewItemsRect.Top - WA.Bottom;
            if Offset > 0
            then
              begin
                if R.Top < WA.Top + RectHeight(WA) div 2
                then
                  Result := WA.Bottom - Height
                else
                  begin
                    Result := R.Bottom - Height + NewItemsRect.Top;
                    if Result  < WA.Top then Result := WA.Top;
                  end
              end
            else
              Result := R.Top - NewItemsRect.Top;
          end
        else
          begin
            if PopupUp
            then
              begin
                if R.Top - Height < WA.Top
                then
                  begin
                    if R.Top < WA.Top + RectHeight(WA) div 2
                    then
                      begin
                        Result := R.Bottom;
                        Offset := Result + Height - WA.Bottom;
                        if Offset > 0
                        then
                          begin
                            Result  := Result - Offset;
                            ChangeY := True;
                          end;
                       end
                     else
                       begin
                         Result := WA.Top;
                         ChangeY := True;
                       end;
                  end
                else
                  Result  := R.Top - Height;
              end
            else
              begin
                Offset := R.Bottom + Height - WA.Bottom;
                if Offset > 0
                then
                  begin
                    if R.Top < WA.Top + RectHeight(WA) div 2
                    then
                      begin
                        Result := R.Bottom - Offset;
                        ChangeY := True
                      end
                    else
                      begin
                        if R.Top - Height < WA.Top
                        then
                          begin
                            Result := WA.Top;
                            ChangeY := True;
                          end
                        else
                          Result := R.Top - Height;
                      end
                  end
                else
                  Result := R.Bottom;
              end;
          end;
      end;
  end;

  function GetX: Integer;
  begin
    if PopupByItem or (Scroll and not Scroll2) or ChangeY
    then
      begin
        if R.Right + Width + 1 > WA.Right
        then Result := R.Left - Width - 1 else Result := R.Right + 1;
      end
    else
      begin
        if R.Left + Width > WA.Right
        then Result := WA.Right - Width else
        if R.Left < WA.Left then Result := WA.Left else Result := R.Left;
      end;
  end;

begin
  WA := ParentMenu.WorkArea;
  ChangeY := False;
  Y := GetY;
  X := GetX;
end;

const
  WS_EX_LAYERED = $80000;
  AnimationStep = 10;
var
  i: Integer;
  ABV: Integer;
  TickCount: DWORD;
begin
  if CheckW2KWXP and ParentMenu.AlphaBlend and ParentMenu.AlphaBlendAnimation and
     ParentMenu.First
  then
    Application.ProcessMessages;
    
  CreateMenu(AItem, StartIndex);
  CalcMenuPos(ShowX, ShowY, R);
  //
  if CheckW2KWXP and ParentMenu.AlphaBlend
  then
    begin
      SetWindowLong(Handle, GWL_EXSTYLE,
                    GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
      if ParentMenu.First and ParentMenu.AlphaBlendAnimation
      then SetAlphaBlendTransparent(Handle, 0)
      else SetAlphaBlendTransparent(Handle, ParentMenu.AlphaBlendValue);
    end;
  //
  SetWindowPos(Handle, HWND_TOPMOST, ShowX, ShowY, 0, 0,
               SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);
  Visible := True;
  if CheckW2KWXP and ParentMenu.AlphaBlend and ParentMenu.AlphaBlendAnimation and
     ParentMenu.First
  then
    begin
      TickCount := 0;
      i := 0;
      ABV := ParentMenu.AlphaBlendValue;
      repeat
       if (GetTickCount - TickCount > 5)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, AnimationStep);
            if i > ABV then i := ABV;
            SetAlphaBlendTransparent(Handle, i);
          end;  
      until i >= ABV;
    end;
  //
  MouseTimer.Enabled := True;
  ActiveItem := -1;
  if ItemList.Count > 0
  then
    for i := 0 to ItemList.Count - 1 do
     with TbsSkinMenuItem(ItemList.Items[i]) do
     begin
       if (MenuItem.Enabled) and (MenuItem.Caption <> '-')
       then
         begin
           WaitCommand := True;
           ActiveItem := i;
           MouseEnter(True);
           Break;
         end;
     end;
end;

procedure TbsSkinPopupWindow.Show2;

procedure CalcMenuPos(var X, Y: Integer; R: TRect);
var
  WA: TRect;
  ChangeY: Boolean;

  function GetY: Integer;
  var
    Offset: Integer;
  begin
    if Scroll and not Scroll2
    then
      Result := WA.Top
    else
      begin
        if PopupByItem
        then
          begin
            Offset := R.Top + Height - NewItemsRect.Top - WA.Bottom;
            if Offset > 0
            then
              begin
                if R.Top < WA.Top + RectHeight(WA) div 2
                then
                  Result := WA.Bottom - Height
                else
                  begin
                    Result := R.Bottom - Height + NewItemsRect.Top;
                    if Result  < WA.Top then Result := WA.Top;
                  end
              end
            else
              Result := R.Top - NewItemsRect.Top;
          end
        else
          begin
            if PopupUp
            then
              begin
                if R.Top - Height < WA.Top
                then
                  begin
                    if R.Top < WA.Top + RectHeight(WA) div 2
                    then
                      begin
                        Result := R.Bottom;
                        Offset := Result + Height - WA.Bottom;
                        if Offset > 0
                        then
                          begin
                            Result  := Result - Offset;
                            ChangeY := True;
                          end;
                       end
                     else
                       begin
                         Result := WA.Top;
                         ChangeY := True;
                       end;
                  end
                else
                  Result  := R.Top - Height;
              end
            else
              begin
                Offset := R.Bottom + Height - WA.Bottom;
                if Offset > 0
                then
                  begin
                    if R.Top < WA.Top + RectHeight(WA) div 2
                    then
                      begin
                        Result := R.Bottom - Offset;
                        ChangeY := True
                      end
                    else
                      begin
                        if R.Top - Height < WA.Top
                        then
                          begin
                            Result := WA.Top;
                            ChangeY := True;
                          end
                        else
                          Result := R.Top - Height;
                      end
                  end
                else
                  Result := R.Bottom;
              end;
          end;
      end;
  end;

  function GetX: Integer;
  begin
    if PopupByItem or (Scroll and not Scroll2) or ChangeY
    then
      begin
        if R.Right + Width + 1 > WA.Right
        then Result := R.Left - Width - 1 else Result := R.Right + 1;
      end
    else
      begin
        if R.Left + Width > WA.Right
        then Result := WA.Right - Width else
        if R.Left < WA.Left then Result := WA.Left else Result := R.Left;
      end;
  end;

begin
  WA := ParentMenu.WorkArea;
  ChangeY := False;
  Y := GetY;
  X := GetX;
end;

const
  WS_EX_LAYERED = $80000;
  AnimationStep = 10;
var
  i: Integer;
  ABV: Integer;
  TickCount: DWORD;
begin
  if CheckW2KWXP and ParentMenu.AlphaBlend and ParentMenu.AlphaBlendAnimation and
     ParentMenu.First
  then
    Application.ProcessMessages;
    
  CreateMenu2(AItem, AItem2, StartIndex);
  CalcMenuPos(ShowX, ShowY, R);
  //
  if CheckW2KWXP and ParentMenu.AlphaBlend
  then
    begin
      SetWindowLong(Handle, GWL_EXSTYLE,
                    GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
      if ParentMenu.First and ParentMenu.AlphaBlendAnimation
      then SetAlphaBlendTransparent(Handle, 0)
      else SetAlphaBlendTransparent(Handle, ParentMenu.AlphaBlendValue);
    end;
  //
  SetWindowPos(Handle, HWND_TOPMOST, ShowX, ShowY, 0, 0,
               SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);
  Visible := True;
  if CheckW2KWXP and ParentMenu.AlphaBlend and ParentMenu.AlphaBlendAnimation and
     ParentMenu.First
  then
    begin
      i := 0;
      TickCount := 0;
      ABV := ParentMenu.AlphaBlendValue;
      repeat
        if (GetTickCount - TickCount > 5)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, AnimationStep);
            if i > ABV then i := ABV;
            SetAlphaBlendTransparent(Handle, i);
          end;  
      until i >= ABV;
    end;
  //
  MouseTimer.Enabled := True;
  ActiveItem := -1;
  if ItemList.Count > 0
  then
    for i := 0 to ItemList.Count - 1 do
     with TbsSkinMenuItem(ItemList.Items[i]) do
     begin
       if MenuItem.Enabled and (MenuItem.Caption <> '-')
       then
         begin
           WaitCommand := True;
           ActiveItem := i;
           MouseEnter(True);
           Break;
         end;
     end;
end;

procedure TbsSkinPopupWindow.PaintMenu;
var
  C: TCanvas;
  i: Integer;
  B: TBitMap;
begin
  C := TCanvas.Create;
  C.Handle := DC;
  B := TBitMap.Create;
  CreateRealImage(B);
  // Draw items
  for i := VisibleStartIndex to VisibleStartIndex + VisibleCount - 1 do
    TbsSkinMenuItem(ItemList.Items[i]).Draw(B.Canvas);
  // markers
  if Scroll
  then
    begin
      DrawUpMarker(B.Canvas);
      DrawDownMarker(B.Canvas);
    end;
  C.Draw(0, 0, B);
  B.Free;
  C.Free;
end;

procedure TbsSkinPopupWindow.WMEraseBkgrnd;
begin
  PaintMenu(Message.WParam);
end;

procedure TbsSkinPopupWindow.MouseUp;
begin
  TestActive(X, Y);
  if (ActiveItem <> -1) and (Button = mbleft) and GetActive(X, Y)
  then
    with TbsSkinMenuItem(ItemList.Items[ActiveItem]) do
     if MenuItem.Caption <> '-' then MouseDown(X, Y);
end;

procedure TbsSkinPopupWindow.TestMouse;
var
  P, P1: TPoint;
begin
  GetCursorPos(P1);
  P := ScreenToClient(P1);
  if (OMX <> P.X) or (OMY <> P.Y)
  then 
    if InWindow(P1)
    then
      TestActive(P.X, P.Y)
    else
      if Scroll
      then
        begin
          ScrollCode := 0;
          DrawUpMarker(Canvas);
          DrawDownMarker(Canvas);
        end;
  OMX := P.X;
  OMY := P.Y;
end;

function TbsSkinPopupWindow.GetActive;
var
  i: Integer;
begin
  i := -1;
  if ItemList.Count = 0
  then
    Result := False
  else
  repeat
    Inc(i);
    with TbsSkinMenuItem(ItemList.Items[i]) do
      Result := FVisible and PtInRect(ObjectRect, Point(X, Y));
  until Result or (i = ItemList.Count - 1);
end;

procedure TbsSkinPopupWindow.TestActive;
var
  i: Integer;
  B: Boolean;
  R1, R2: TRect;
begin
  if Scroll
  then
    begin
      R1 := Rect(NewItemsRect.Left, NewItemsRect.Top,
            NewItemsRect.Right, NewItemsRect.Top + MarkerItemHeight);
      R2 := Rect(NewItemsRect.Left, NewItemsRect.Bottom - MarkerItemHeight,
            NewItemsRect.Right, NewItemsRect.Bottom);

      if PtInRect(R1, Point(X, Y)) and (ScrollCode = 0) and CanScroll(1)
      then
        begin
          ScrollCode := 1;
          DrawUpMarker(Canvas);
          StartScroll;
        end
      else
      if PtInRect(R2, Point(X, Y)) and (ScrollCode = 0)  and CanScroll(2)
      then
        begin
          ScrollCode := 2;
          DrawDownMarker(Canvas);
          StartScroll;
        end
      else
        if (ScrollCode <> 0) and not PtInRect(R1, Point(X, Y)) and
                                 not PtInRect(R2, Point(X, Y))
        then
          StopScroll;
     end;

  if (ItemList.Count = 0) then Exit;

  OldActiveItem := ActiveItem;

  i := -1;
  repeat
    Inc(i);
    with TbsSkinMenuItem(ItemList.Items[i]) do
    begin
      B := FVisible and PtInRect(ObjectRect, Point(X, Y));
    end;
  until B or (i = ItemList.Count - 1);

  if B then ActiveItem := i;

  if OldActiveItem >= ItemList.Count then OldActiveItem := -1;
  if ActiveItem >= ItemList.Count then ActiveItem := -1;
  if (OldActiveItem = ActiveItem) and (ActiveItem <> -1)
  then
    begin
      with TbsSkinMenuItem(ItemList.Items[ActiveItem]) do
       if WaitCommand
       then
         begin
           WaitCommand := False;
           if MenuItem.Count <> 0
           then
             MouseEnter(False);
         end;
    end
  else
  if (OldActiveItem <> ActiveItem)
  then
    begin
      if OldActiveItem <> - 1
      then
        with TbsSkinMenuItem(ItemList.Items[OldActiveItem]) do
        begin
          if MenuItem.Enabled and (MenuItem.Caption <> '-')
          then
            MouseLeave;
        end;

      if ActiveItem <> - 1
      then
        with TbsSkinMenuItem(ItemList.Items[ActiveItem]) do
        begin
          if MenuItem.Enabled and (MenuItem.Caption <> '-')
          then
            MouseEnter(False);
        end;
    end;

end;

function TbsSkinPopupWindow.InWindow;
var
  H: HWND;
begin
  H := WindowFromPoint(P);
  Result := H = Handle;
end;

//====================TbsSkinMenu===================//
constructor TbsSkinMenu.CreateEx;
begin
  inherited Create(AOwner);
  FOnMenuClose := nil;
  MaxMenuItemsInWindow := 0;
  FUseSkinFont := False;
  AlphaBlendAnimation := False;
  AlphaBlend := False;
  AlphaBlendValue := 150;
  FPopupList := TList.Create;
  WaitTimer := TTimer.Create(Self);
  WaitTimer.Enabled := False;
  WaitTimer.OnTimer := WaitItem;
  WaitTimer.Interval := WaitTimerInterval;
  WItem := nil;
  FVisible := False;
  FForm := AForm;
  PopupCtrl := nil;
  DCtrl := nil;
  FDefaultMenuItemHeight := 20;
  FDefaultMenuItemFont := TFont.Create;
  with FDefaultMenuItemFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSkinMenu.Destroy;
begin
  CloseMenu(0);
  FPopupList.Free;
  WaitTimer.Free;
  FDefaultMenuItemFont.Free;
  inherited Destroy;
end;

procedure TbsSkinMenu.SetDefaultMenuItemFont(Value: TFont);
begin
  FDefaultMenuItemFont.Assign(Value);
end;

function TbsSkinMenu.GetWorkArea;
begin
  Result := GetMonitorWorkArea(FForm.Handle, True);
end;

procedure TbsSkinMenu.WaitItem(Sender: TObject);
begin
  if WItem <> nil then CheckItem(WItem.Parent, WItem, True, False);
  WaitTimer.Enabled := False;
end;

function TbsSkinMenu.GetPWIndex;
var
  i: Integer;
begin
  for i := 0 to FPopupList.Count - 1 do
    if PW = TbsSkinPopupWindow(FPopupList.Items[i]) then Break;
  Result := i;
end;

procedure TbsSkinMenu.CheckItem;
var
  Menu: TMenu;
  MenuI: TMenuItem;
  i: Integer;
  R: TRect;
begin
  if (MI.MenuItem.Count = 0) and not Down
  then
    begin
      WaitTimer.Enabled := False;
      WItem := nil;
      i := GetPWIndex(PW);
      if i < FPopupList.Count - 1 then CloseMenu(i + 1);
    end
  else
  if (MI.MenuItem.Count = 0) and Down
  then
    begin
      WaitTimer.Enabled := False;
      WItem := nil;
      MenuI := MI.MenuItem;
      Hide;
      //
      Menu := MenuI.GetParentMenu;
      Menu.DispatchCommand(MenuI.Command);
      //
      if DCtrl <> nil
      then
        if DCtrl is TWinControl
        then
          SendMessage(TWinControl(DCtrl).Handle, WM_AFTERDISPATCH, 0, 0)
        else
          DCtrl.Perform(WM_AFTERDISPATCH, 0, 0);
      DCtrl := nil;
      //
    end
  else
  if (MI.MenuItem.Count <> 0) and not Down and not Kb
  then
    begin
      WaitTimer.Enabled := False;
      WItem := nil;
      i := GetPWIndex(PW);
      if i < FPopupList.Count - 1 then CloseMenu(i + 1);
      WItem := MI;
      WaitTimer.Enabled := True;
    end
  else
  if (MI.MenuItem.Count <> 0) and Down
  then
    begin
      //
      MenuI := MI.MenuItem;
      Menu := MenuI.GetParentMenu;
      Menu.DispatchCommand(MenuI.Command);
      //
      WaitTimer.Enabled := False;
      WItem := nil;
      MI.Down := True;
      R.Left := PW.Left + MI.ObjectRect.Left;
      R.Top := PW.Top + MI.ObjectRect.Top;
      R.Right := PW.Left + MI.ObjectRect.Right;
      R.Bottom := PW.Top + MI.ObjectRect.Bottom;
      PopupSub(R, MI.MenuItem, 0, True, False);
    end
end;

procedure TbsSkinMenu.Popup;
var
  BSF: TbsBusinessSkinForm;
begin
  FFirst := not FVisible;
  PopupCtrl := APopupCtrl;
  if FPopupList.Count <> 0 then CloseMenu(0);
  WorkArea := GetWorkArea;
  SkinData := ASkinData;
  if (AItem.Count = 0) or (StartIndex >= AItem.Count) then Exit;
  FVisible := True;
  PopupSub(R, AItem, StartIndex, False, PopupUp);
  FFirst := False;
end;

procedure TbsSkinMenu.Popup2;
var
  BSF: TbsBusinessSkinForm;
begin
  FFirst := not FVisible;
  PopupCtrl := APopupCtrl;
  if FPopupList.Count <> 0 then CloseMenu(0);
  WorkArea := GetWorkArea;
  SkinData := ASkinData;
  if (AItem.Count = 0) or (StartIndex >= AItem.Count + AItem2.Count) then Exit;
  FVisible := True;
  PopupSub2(R, AItem, AItem2, StartIndex, False, PopupUp);
  FFirst := False;
end;

procedure TbsSkinMenu.PopupSub2;
var
  P: TbsSkinPopupWindow;
begin
  if (SkinData = nil) or (SkinData.Empty)
  then
    P := TbsSkinPopupWindow.CreateEx(Self, Self, nil)
  else
    P := TbsSkinPopupWindow.CreateEx(Self, Self, SkinData.PopupWindow);
  FPopupList.Add(P);
  with P do Show2(R, AItem, AItem2, StartIndex, PopupByItem, PopupUp);
end;

procedure TbsSkinMenu.PopupSub;
var
  P: TbsSkinPopupWindow;
begin
  if (SkinData = nil) or (SkinData.Empty)
  then
    P := TbsSkinPopupWindow.CreateEx(Self, Self, nil)
  else
    P := TbsSkinPopupWindow.CreateEx(Self, Self, SkinData.PopupWindow);
  FPopupList.Add(P);
  with P do Show(R, AItem, StartIndex, PopupByItem, PopupUp);
end;

procedure TbsSkinMenu.CloseMenu;
var
  i: Integer;
begin
  for i := FPopupList.Count - 1 downto EndIndex do
  begin
    TbsSkinPopupWindow(FPopupList.Items[i]).Free;
    FPopupList.Delete(i);
  end;
  if EndIndex = 0
  then
    begin
      FVisible := False;
      WaitTimer.Enabled := False;
      DCtrl := PopupCtrl;
      if PopupCtrl <> nil
      then
        begin
          if PopupCtrl is TWinControl
          then
            SendMessage(TWinControl(PopupCtrl).Handle, WM_CLOSESKINMENU, 0, 0)
          else
            PopupCtrl.Perform(WM_CLOSESKINMENU, 0, 0);
          PopupCtrl := nil;
        end;
      if Assigned(FOnMenuClose) then FOnMenuClose(Self);
      FOnMenuClose := nil;  
    end;
end;

procedure TbsSkinMenu.Hide;
begin
  CloseMenu(0);
  WaitTimer.Enabled := False;
  WItem := nil;
  if FForm <> nil then
  SendMessage(FForm.Handle, WM_CLOSESKINMENU, 0, 0);
  if PopupCtrl <> nil
  then
    begin
      if PopupCtrl is TWinControl
      then
        SendMessage(TWinControl(PopupCtrl).Handle, WM_CLOSESKINMENU, 0, 0)
      else
        PopupCtrl.Perform(WM_CLOSESKINMENU, 0, 0);
      PopupCtrl := nil;
    end;
end;

//============= TbsSkinPopupMenu =============//
function FindBSFComponent(AForm: TForm): TbsBusinessSkinForm;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to AForm.ComponentCount - 1 do
   if AForm.Components[i] is TbsBusinessSkinForm
   then
     begin
       Result := TbsBusinessSkinForm(AForm.Components[i]);
       Break;
     end;
end;

constructor TbsSkinPopupMenu.Create;
begin
  inherited Create(AOwner);
  FOnMenuClose := nil;
  FComponentForm := nil;
  FSD := nil;
  FPopupPoint := Point(-1,-1);
end;

procedure TbsSkinPopupMenu.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
end;

procedure TbsSkinPopupMenu.PopupFromRect;
var
  BSF: TbsBusinessSkinForm;
begin
  if Assigned(OnPopup) then OnPopup(Self);
  if FComponentForm = nil
  then
    begin
      if Owner.InheritsFrom(TForm) then
        BSF := FindBSFComponent(TForm(Owner)) else
         if Owner.Owner.InheritsFrom(TForm) then
         BSF := FindBSFComponent(TForm(Owner.Owner)) else
         BSF := nil;
      if (BSF <> nil) and (BSF.FForm.FormStyle = fsMDIChild)
      then
        BSF := FindBSFComponent(Application.MainForm);
    end
  else
    BSF := FindBSFComponent(FComponentForm);
  if (BSF <> nil) and (FSD = nil)
  then
    if BSF.MenusSkinData = nil
    then
      FSD := BSF.SkinData
    else
      FSD := BSF.MenusSkinData;
  if BSF <> nil
  then
    begin
      if BSF.SkinMenu.Visible then BSF.SkinMenuClose;
      FPopupPoint := Point(R.Left, R.Top);
      BSF.SkinMenuOpen;
      BSF.SkinMenu.Popup(nil, FSD, 0, R, Items, APopupUp);
      if Assigned(FOnMenuClose)
      then
        BSF.SkinMenu.OnMenuClose := Self.FOnMenuClose;
    end;
end;

procedure TbsSkinPopupMenu.Popup;
var
  BSF: TbsBusinessSkinForm;
var
  R: TRect;
begin
  if Assigned(OnPopup) then OnPopup(Self);
  if FComponentForm = nil
  then
    begin
      if Owner.InheritsFrom(TForm) then
        BSF := FindBSFComponent(TForm(Owner)) else
         if Owner.Owner.InheritsFrom(TForm) then
         BSF := FindBSFComponent(TForm(Owner.Owner)) else
         BSF := nil;
      if (BSF <> nil) and (BSF.FForm.FormStyle = fsMDIChild)
      then
        BSF := FindBSFComponent(Application.MainForm);
    end
  else
    BSF := FindBSFComponent(FComponentForm);
  if (BSF <> nil) and (FSD = nil)
  then
    if BSF.MenusSkinData = nil
    then
      FSD := BSF.SkinData
    else
      FSD := BSF.MenusSkinData;
  if BSF <> nil
  then
    begin
      if BSF.SkinMenu.Visible then BSF.SkinMenuClose;
      BSF.SkinMenuOpen;
      R := Rect(X, Y, X, Y);
      FPopupPoint := Point(R.Left, R.Top);
      BSF.SkinMenu.Popup(nil, FSD, 0, R, Items, False);
      if Assigned(FOnMenuClose)
      then
        BSF.SkinMenu.OnMenuClose := Self.FOnMenuClose;
    end;
end;

procedure TbsSkinPopupMenu.PopupFromRect2;
var
  BSF: TbsBusinessSkinForm;
begin
  if Assigned(OnPopup) then OnPopup(Self);
  if FComponentForm = nil
  then
    begin
      if Owner.InheritsFrom(TForm) then
        BSF := FindBSFComponent(TForm(Owner)) else
         if Owner.Owner.InheritsFrom(TForm) then
         BSF := FindBSFComponent(TForm(Owner.Owner)) else
         BSF := nil;
      if (BSF <> nil) and (BSF.FForm.FormStyle = fsMDIChild)
      then
        BSF := FindBSFComponent(Application.MainForm);
    end
  else
    BSF := FindBSFComponent(FComponentForm);
  if (BSF <> nil) and (FSD = nil)
  then
    if BSF.MenusSkinData = nil
    then
      FSD := BSF.SkinData
    else
      FSD := BSF.MenusSkinData;
  if BSF <> nil
  then
    begin
      if BSF.SkinMenu.Visible then BSF.SkinMenuClose;
      FPopupPoint := Point(R.Left, R.Top);
      BSF.SkinMenuOpen;
      BSF.SkinMenu.Popup(ACtrl, FSD, 0, R, Items, APopupUp);
      if Assigned(FOnMenuClose)
      then
        BSF.SkinMenu.OnMenuClose := Self.FOnMenuClose;
    end;
end;

procedure TbsSkinPopupMenu.Popup2;
var
  R: TRect;
  BSF: TbsBusinessSkinForm;
begin
  if Assigned(OnPopup) then OnPopup(Self);
  if FComponentForm = nil
  then
    begin
      if Owner.InheritsFrom(TForm) then
        BSF := FindBSFComponent(TForm(Owner)) else
         if Owner.Owner.InheritsFrom(TForm) then
         BSF := FindBSFComponent(TForm(Owner.Owner)) else
         BSF := nil;
      if (BSF <> nil) and (BSF.FForm.FormStyle = fsMDIChild)
      then
        BSF := FindBSFComponent(Application.MainForm);
    end
  else
    BSF := FindBSFComponent(FComponentForm);
  if (BSF <> nil) and (FSD = nil)
  then
    if BSF.MenusSkinData = nil
    then
      FSD := BSF.SkinData
    else
      FSD := BSF.MenusSkinData;
  if (BSF <> nil) and (FSD <> nil)
  then
    begin
      if BSF.SkinMenu.Visible then BSF.SkinMenuClose;
      BSF.SkinMenuOpen;
      R := Rect(X, Y, X, Y);
      FPopupPoint := Point(R.Left, R.Top);
      BSF.SkinMenu.Popup(ACtrl, FSD, 0, R, Items, False);
      if Assigned(FOnMenuClose)
      then
        BSF.SkinMenu.OnMenuClose := Self.FOnMenuClose;
    end;
end;

// TbsSkinImagesMenu ===========================================================

constructor TbsImagesMenuItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
  FCaption := '';
  FButton := False;
  FHint := '';
end;

procedure TbsImagesMenuItem.Assign(Source: TPersistent);
begin
  if Source is TbsImagesMenuItem then
  begin
    FImageIndex := TbsImagesMenuItem(Source).ImageIndex;
    FCaption := TbsImagesMenuItem(Source).Caption;
    FButton := TbsImagesMenuItem(Source).Button;
    FHint := TbsImagesMenuItem(Source).Hint;
  end
  else
    inherited Assign(Source);
end;

procedure TbsImagesMenuItem.SetImageIndex(const Value: TImageIndex);
begin
  FImageIndex := Value;
end;

procedure TbsImagesMenuItem.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

constructor TbsImagesMenuItems.Create;
begin
  inherited Create(TbsImagesMenuItem);
  ImagesMenu := AImagesMenu;
end;

function TbsImagesMenuItems.GetOwner: TPersistent;
begin
  Result := ImagesMenu;
end;

function TbsImagesMenuItems.GetItem(Index: Integer):  TbsImagesMenuItem;
begin
  Result := TbsImagesMenuItem(inherited GetItem(Index));
end;

procedure TbsImagesMenuItems.SetItem(Index: Integer; Value:  TbsImagesMenuItem);
begin
  inherited SetItem(Index, Value);
end;

constructor TbsSkinImagesMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImagesItems := TbsImagesMenuItems.Create(Self);
  FShowHints := True;
  FItemIndex := -1;
  FColumnsCount := 1;
  FSkinHint := nil;
  FOnItemClick := nil;
  FSkinData := nil;
  FPopupWindow := nil;
  FShowSelectedItem := True;
  FAlphaBlend := False;
  FAlphaBlendValue := 200;
  FAlphaBlendAnimation := False;
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  FUseSkinFont := False;
end;

function TbsSkinImagesMenu.GetSelectedItem;
begin
  if (ItemIndex >=0) and (ItemIndex < FImagesItems.Count)
  then
    Result := FImagesItems[ItemIndex]
  else
    Result := nil;
end;

procedure TbsSkinImagesMenu.SetSkinData;
begin
  FSkinData := Value;
end;

destructor TbsSkinImagesMenu.Destroy;
begin
  if FPopupWindow <> nil then FPopupWindow.Free;
  FDefaultFont.Free;
  FImagesItems.Free;
  inherited Destroy;
end;

procedure TbsSkinImagesMenu.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;


procedure TbsSkinImagesMenu.SetColumnsCount(Value: Integer);
begin
  if (Value > 0) and (Value < 51)
  then
    FColumnsCount := Value;
end;

procedure TbsSkinImagesMenu.SetImagesItems(Value: TbsImagesMenuItems);
begin
  FImagesItems.Assign(Value);
end;

procedure TbsSkinImagesMenu.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Images) then
    Images := nil;
  if (Operation = opRemove) and (AComponent = SkinData) then
    SkinData := nil;
  if (Operation = opRemove) and (AComponent = FSkinHint) then
    FSkinHint := nil;
end;

procedure TbsSkinImagesMenu.SetImages(Value: TCustomImageList);
begin
  FImages := Value;
end;

procedure TbsSkinImagesMenu.Popup(X, Y: Integer);
begin
  if FPopupWindow <> nil then FPopupWindow.Hide(False);

  if Assigned(FOnMenuPopup) then FOnMenuPopup(Self);

  if (FImages = nil) or (FImages.Count = 0) then Exit;
  FOldItemIndex := ItemIndex;
  FPopupWindow := TbsSkinImagesMenuPopupWindow.Create(Self);
  FPopupWindow.Show(Rect(X, Y, X, Y));
end;

procedure TbsSkinImagesMenu.PopupFromRect(R: TRect);
begin
  if FPopupWindow <> nil then FPopupWindow.Hide(False);

  if Assigned(FOnMenuPopup) then FOnMenuPopup(Self);

  if (FImages = nil) or (FImages.Count = 0) then Exit;
  FOldItemIndex := ItemIndex;
  FPopupWindow := TbsSkinImagesMenuPopupWindow.Create(Self);
  FPopupWindow.Show(R);
end;

procedure TbsSkinImagesMenu.ProcessEvents;
begin
  if FPopupWindow = nil then Exit;
  FPopupWindow.Free;
  FPopupWindow := nil;

  if Assigned(FOnInternalMenuClose)
  then
    FOnInternalMenuClose(Self);

  if Assigned(FOnMenuClose)
  then
    FOnMenuClose(Self);

  if ACanProcess and (ItemIndex <> -1)
  then
   begin
      if Assigned(FImagesItems[ItemIndex].OnClick)
      then
        FImagesItems[ItemIndex].OnClick(Self);
      if Assigned(FOnItemClick) then FOnItemClick(Self);

      if (FOldItemIndex <> ItemIndex) and
         Assigned(FOnInternalChange) then FOnInternalChange(Self);

      if (FOldItemIndex <> ItemIndex) and
         Assigned(FOnChange) then FOnChange(Self);
    end;
end;

procedure TbsSkinImagesMenu.Hide;
begin
  if FPopupWindow <> nil then FPopupWindow.Hide(False);
end;

constructor TbsSkinImagesMenuPopupWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Visible := False;
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  ImagesMenu := TbsSkinImagesMenu(AOwner);
  FRgn := 0;
  WindowPicture := nil;
  MaskPicture := nil;
  FSkinSupport := False;
  MouseInItem := -1;
  OldMouseInItem := -1;
  FDown := False;
  FItemDown := False;
end;

destructor TbsSkinImagesMenuPopupWindow.Destroy;
begin
  inherited Destroy;
  if FRgn <> 0 then DeleteObject(FRgn);
end;

procedure TbsSkinImagesMenuPopupWindow.WMEraseBkGrnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

function TbsSkinImagesMenuPopupWindow.GetItemFromPoint;
var
  I: Integer;
  R: TRect;
begin
  Result := -1;
  for I := 0 to ImagesMenu.ImagesItems.Count - 1 do
  begin
    R := GetItemRect(I);
    if PointInRect(R, P)
    then
      begin
        Result := i;
        Break;
      end;
  end;
end;

procedure TbsSkinImagesMenuPopupWindow.AssignItemRects;
var
  I, W, X, Y,StartX, StartY: Integer;
  ItemWidth, ItemHeight: Integer;
  R: TRect;
begin
  ItemWidth := ImagesMenu.FImages.Width + 10;
  ItemHeight := ImagesMenu.FImages.Height + 10;
  W := ItemWidth * ImagesMenu.ColumnsCount;
  if FSkinSupport
  then
    begin
      StartX := ImagesMenu.SkinData.PopupWindow.ItemsRect.Left;
      StartY := ImagesMenu.SkinData.PopupWindow.ItemsRect.Top;
    end
  else
    begin
      StartX := 5;
      StartY := 5;
    end;
  X := StartX;
  Y := StartY;  
  for I := 0 to ImagesMenu.ImagesItems.Count - 1 do
  with ImagesMenu.ImagesItems[I] do
  begin
    if Button
    then
      begin
        if X <> StartX then Inc(Y, ItemHeight + 1);
        ItemRect := Rect(StartX, Y, StartX + W, Y + ItemHeight);
        Inc(Y, ItemHeight + 1);
      end
    else
      begin
        ItemRect := Rect(X, Y, X + ItemWidth, Y + ItemHeight);
        X := X + ItemWidth;
        if X + ItemWidth > StartX + W
        then
          begin
            X := StartX;
            Inc(Y, ItemHeight + 1);
          end;
      end;
  end;
end;


function TbsSkinImagesMenuPopupWindow.GetItemRect(Index: Integer): TRect;
begin
  Result := ImagesMenu.ImagesItems[Index].ItemRect;
end;

procedure TbsSkinImagesMenuPopupWindow.TestActive(X, Y: Integer);
begin
  MouseInItem := GetItemFromPoint(Point(X, Y));
  if MouseInItem <> OldMouseInItem
  then
    begin
      OldMouseInItem := MouseInItem;
      RePaint;
      if ImagesMenu.ShowHints and (MouseInItem <> -1) and (ImagesMenu.SkinHint <> nil)
      then
        begin
          ImagesMenu.SkinHint.HideHint;
          with ImagesMenu.ImagesItems[MouseInItem] do
          begin
            if Hint <> '' then ImagesMenu.SkinHint.ActivateHint2(Hint);
           end;
        end;
    end;
end;

procedure TbsSkinImagesMenuPopupWindow.Show(PopupRect: TRect);

procedure CorrectMenuPos(var X, Y: Integer);
var
  WorkArea: TRect;
begin
  WorkArea := GetMonitorWorkArea(Handle, True);
  if Y + Height > WorkArea.Bottom
  then
    Y := Y - Height - RectHeight(PopupRect);
  if X + Width > WorkArea.Right
  then
    X := X - ((X + Width) - WorkArea.Right);
  if X < WorkArea.Left then X := WorkArea.Left;
  if Y < WorkArea.Top then Y := WorkArea.Top;  
end;

const
  WS_EX_LAYERED = $80000;

var
  ShowX, ShowY: Integer;
  I: Integer;
  TickCount: DWORD;
begin
  CreateMenu;
  ShowX := PopupRect.Left;
  ShowY := PopupRect.Bottom;
  CorrectMenuPos(ShowX, ShowY);

  if CheckW2KWXP and ImagesMenu.AlphaBlend
  then
    begin
      SetWindowLong(Handle, GWL_EXSTYLE,
                    GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
      if ImagesMenu.AlphaBlendAnimation
      then
        SetAlphaBlendTransparent(Handle, 0)
      else
        SetAlphaBlendTransparent(Handle, ImagesMenu.AlphaBlendValue);
    end;

  SetWindowPos(Handle, HWND_TOPMOST, ShowX, ShowY, 0, 0,
               SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_NOSIZE);


  Visible := True;

  if ImagesMenu.AlphaBlendAnimation and ImagesMenu.AlphaBlend and CheckW2KWXP
  then
    begin
      Application.ProcessMessages;
      I := 0;
      TickCount := 0;
      repeat
        if (GetTickCount - TickCount > 5)
        then
          begin
            TickCount := GetTickCount;
            Inc(i, 10);
            if i > ImagesMenu.AlphaBlendValue then i := ImagesMenu.AlphaBlendValue;
            SetAlphaBlendTransparent(Handle, i);
          end;  
      until i >= ImagesMenu.AlphaBlendValue;
    end;

  HookApp;

  SetCapture(Handle);
end;

procedure TbsSkinImagesMenuPopupWindow.Hide;
begin
  if ImagesMenu.ShowHints and (ImagesMenu.SkinHint <> nil)
  then
    ImagesMenu.SkinHint.HideHint;
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
  UnHookApp;
  if GetCapture = Handle then ReleaseCapture;
  ImagesMenu.ProcessEvents(AProcessEvents);
end;

procedure TbsSkinImagesMenuPopupWindow.DrawItems(ActiveIndex, SelectedIndex: Integer; C: TCanvas);
var
  I: Integer;
  R: TRect;
  IX, IY: Integer;
  Offset: Integer;
  IsActive, IsDown: Boolean;
begin
  for I := 0 to ImagesMenu.ImagesItems.Count - 1 do
  begin
    R := GetItemRect(I);
    IX := R.Left + 5;
    IY := R.Top + 5;
    Offset := 0;
    if (I = SelectedIndex) and not FItemDown then DrawActiveItem(R, C, True) else
    if I = ActiveIndex then DrawActiveItem(R, C, FItemDown);
    if (ImagesMenu.ImagesItems[I].ImageIndex >= 0) and
       (ImagesMenu.ImagesItems[I].ImageIndex < ImagesMenu.Images.Count)
    then
      begin
        ImagesMenu.Images.Draw(C, IX, IY, ImagesMenu.ImagesItems[I].ImageIndex, True);
        Offset := ImagesMenu.Images.Width + 5;
      end;
    if ImagesMenu.ImagesItems[I].Button and (ImagesMenu.ImagesItems[I].Caption <> '') then
    begin
      R.Left := R.Left + Offset;
      isDown := False;
      isActive := False;
      if (I = SelectedIndex) and not FItemDown
      then
        isDown := True
      else
      if I = ActiveIndex
      then
        begin
          if FItemDown then isDown := True else isActive := True;
        end;
      DrawItemCaption(ImagesMenu.ImagesItems[I].Caption, R, C, isActive, isDown);
    end;
  end;
end;

procedure TbsSkinImagesMenuPopupWindow.DrawItemCaption;
var
  MenuItemData: TbsDataSkinMenuItem;
  ButtonData: TbsDataSkinButtonControl;
  I: Integer;
begin
  MenuItemData := nil;
  ButtonData := nil;
  if FSKinSupport
  then
    begin
      I := ImagesMenu.SkinData.GetIndex('menuitem');
      if I = -1 then I := ImagesMenu.SkinData.GetIndex('MENUITEM');
      if I = -1
      then MenuItemData := nil
      else MenuItemData := TbsDataSkinMenuItem(ImagesMenu.SkinData.ObjectList[I]);

      I := ImagesMenu.SkinData.GetControlIndex('menuitembutton');
      if I = -1
      then
      I := ImagesMenu.SkinData.GetControlIndex('resizebutton');
      if I = -1
      then ButtonData := nil
      else ButtonData := TbsDataSkinButtonControl(ImagesMenu.SkinData.CtrlList[I]);
    end;
  if (MenuItemData <> nil) and (ButtonData <> nil)
  then
    begin
      if ImagesMenu.UseSkinFont
      then
        begin
          C.Font.Name := ButtonData.FontName;
          C.Font.Height := ButtonData.FontHeight;
          C.Font.Style := ButtonData.FontStyle;
        end
      else
        C.Font.Assign(ImagesMenu.DefaultFont);

      if (ImagesMenu.SkinData <> nil) and (ImagesMenu.SkinData.ResourceStrData <> nil)
      then
        C.Font.Charset := ImagesMenu.SkinData.ResourceStrData.CharSet
      else
        C.Font.CharSet := ImagesMenu.FDefaultFont.Charset;

      if ADown
      then
        C.Font.Color := ButtonData.DownFontColor
      else
      if AActive
      then
        C.Font.Color := ButtonData.ActiveFontColor
      else
        C.Font.Color := MenuItemData.FontColor;
    end
  else
    begin
      C.Font.Assign(ImagesMenu.DefaultFont);
      C.Font.Color := clWindowText;
    end;
  C.Brush.Style := bsClear;
  if RectWidth(R) < C.TextWidth(ACaption)
  then
   DrawText(C.Handle, PChar(ACaption), Length(ACaption), R,
     DT_VCENTER or DT_SINGLELINE or DT_LEFT)
  else
    DrawText(C.Handle, PChar(ACaption), Length(ACaption), R,
     DT_VCENTER or DT_SINGLELINE or DT_CENTER);
end;


procedure TbsSkinImagesMenuPopupWindow.DrawActiveItem(R: TRect; C: TCanvas; ASelected: Boolean);
var
  ButtonData: TbsDataSkinButtonControl;
  Buffer: TBitMap;
  CIndex: Integer;
  XO, YO: Integer;
  FSkinPicture: TBitMap;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  NewCLRect: TRect;
  SknR: TRect;
begin
  Buffer := TBitMap.Create;
  Buffer.Width := RectWidth(R);
  Buffer.Height := RectHeight(R);
  ButtonData := nil;
  if FSkinSupport
  then
    begin
      CIndex := ImagesMenu.SkinData.GetControlIndex('menuitembutton');
      if CIndex = -1
      then
        CIndex := ImagesMenu.SkinData.GetControlIndex('resizebutton');
      if CIndex <> -1
      then
        ButtonData := TbsDataSkinButtonControl(ImagesMenu.SkinData.CtrlList[CIndex]);
    end;
  if ButtonData <> nil
  then
    with ButtonData do
    begin
      XO := RectWidth(R) - RectWidth(SkinRect);
      YO := RectHeight(R) - RectHeight(SkinRect);
      NewLTPoint := LTPoint;
      NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
      NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
      NewClRect := Rect(CLRect.Left, ClRect.Top,
        CLRect.Right + XO, ClRect.Bottom + YO);
      FSkinPicture := TBitMap(ImagesMenu.SkinData.FActivePictures.Items[ButtonData.PictureIndex]);
      if (ASelected and not IsNullRect(DownSkinRect))
      then
        SknR := DownSkinRect
      else
        SknR := ActiveSkinRect;
      if IsNullRect(SknR) then SknR := SkinRect;
      CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          Buffer, FSkinPicture, SknR, Buffer.Width, Buffer.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect);
    end
  else
    begin
      SknR := Rect(0, 0, Buffer.Width, Buffer.Height);
      Frame3D(Buffer.Canvas, SknR, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR, 1);
      if ASelected
      then
        Buffer.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR
      else
        Buffer.Canvas.Brush.Color := BS_XP_BTNACTIVECOLOR;
      Buffer.Canvas.FillRect(SknR);
    end;
  C.Draw(R.Left, R.Top, Buffer);
  Buffer.Free;
end;

procedure TbsSkinImagesMenuPopupWindow.Paint;
var
  Buffer: TBitMap;
  SelectedIndex: Integer;
begin
  FSkinSupport := (ImagesMenu.SkinData <> nil) and (not ImagesMenu.SkinData.Empty) and
                  (ImagesMenu.SkinData.PopupWindow.WindowPictureIndex <> -1);

  if ImagesMenu.ShowSelectedItem
  then SelectedIndex := ImagesMenu.ItemIndex
  else SelectedIndex := -1;


  Buffer := TBitMap.Create;
  Buffer.Width := Width;
  Buffer.Height := Height;
  if FSkinSupport
  then
    with ImagesMenu.SkinData.PopupWindow do
    begin
      CreateSkinImageBS(LTPoint, RTPoint, LBPoint, RBPoint,
      ItemsRect, NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint,
      NewItemsRect, Buffer, WindowPicture,
      Rect(0, 0, WindowPicture.Width, WindowPicture.Height),
      Width, Height, True, LeftStretch, TopStretch,
      RightStretch, BottomStretch);
      DrawItems(MouseInItem, SelectedIndex, Buffer.Canvas);
    end
  else
    with Buffer.Canvas do
    begin
      Pen.Color := clBtnShadow;
      Brush.Color := clWindow;
      Rectangle(0, 0, Buffer.Width, Buffer.Height);
      DrawItems(MouseInItem, SelectedIndex, Buffer.Canvas);
    end;
  Canvas.Draw(0, 0, Buffer);
  Buffer.Free;
end;

procedure TbsSkinImagesMenuPopupWindow.CreateMenu;
var
  ItemsWidth, ItemsHeight: Integer;
  ItemsR: TRect;
begin

  FSkinSupport := (ImagesMenu.SkinData <> nil) and (not ImagesMenu.SkinData.Empty) and
                  (ImagesMenu.SkinData.PopupWindow.WindowPictureIndex <> -1);

  AssignItemRects;

  ItemsWidth := (ImagesMenu.Images.Width + 10) * ImagesMenu.ColumnsCount;

  ItemsR := Rect(ImagesMenu.ImagesItems[0].ItemRect.Left,
                 ImagesMenu.ImagesItems[0].ItemRect.Top,
                 ImagesMenu.ImagesItems[0].ItemRect.Left + ItemsWidth,
                 ImagesMenu.ImagesItems[ImagesMenu.ImagesItems.Count - 1].ItemRect.Bottom);


  ItemsHeight := RectHeight(ItemsR);

  if (ImagesMenu.SkinData <> nil) and (not ImagesMenu.SkinData.Empty) and
     (ImagesMenu.SkinData.PopupWindow.WindowPictureIndex <> -1)
  then
    with ImagesMenu.SkinData.PopupWindow do
    begin
      if (WindowPictureIndex <> - 1) and
         (WindowPictureIndex < ImagesMenu.SkinData.FActivePictures.Count)
      then
        WindowPicture := ImagesMenu.SkinData.FActivePictures.Items[WindowPictureIndex];

      if (MaskPictureIndex <> - 1) and
           (MaskPictureIndex < ImagesMenu.SkinData.FActivePictures.Count)
      then
        MaskPicture := ImagesMenu.SkinData.FActivePictures.Items[MaskPictureIndex]
      else
        MaskPicture := nil;

      Self.Width := ItemsWidth + (WindowPicture.Width - RectWidth(ItemsRect));
      Self.Height := ItemsHeight + (WindowPicture.Height - RectHeight(ItemsRect));

      NewLTPoint := LTPoint;
      NewRTPoint := Point(Width - (WindowPicture.Width - RTPoint.X), RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, Height - (WindowPicture.Height - LBPoint.Y));
      NewRBPoint := Point(Width - (WindowPicture.Width - RBPoint.X),
                          Height - (WindowPicture.Height - RBPoint.Y));

      NewItemsRect := Rect(ItemsRect.Left, ItemsRect.Top,
                           Width - (WindowPicture.Width - ItemsRect.Right),
                           Height - (WindowPicture.Height - ItemsRect.Bottom));

      if MaskPicture <> nil then SetMenuWindowRegion;
    end
  else
    begin
      Self.Width := ItemsWidth + 10;
      Self.Height := ItemsHeight + 10;
    end;
end;

procedure TbsSkinImagesMenuPopupWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    if CheckWXP then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW_ ;
  end;
end;

procedure TbsSkinImagesMenuPopupWindow.CMMouseLeave(var Message: TMessage);
begin
  if ImagesMenu.ShowHints and (ImagesMenu.SkinHint <> nil)
  then
    ImagesMenu.SkinHint.HideHint;
  MouseInItem := -1;
  OldMouseInItem := -1;
  RePaint;
end;

procedure TbsSkinImagesMenuPopupWindow.CMMouseEnter(var Message: TMessage);
begin

end;

procedure TbsSkinImagesMenuPopupWindow.MouseDown(Button: TMouseButton; Shift: TShiftState;
   X, Y: Integer);
begin
  inherited;
  if ImagesMenu.ShowHints and (ImagesMenu.SkinHint <> nil)
  then
    ImagesMenu.SkinHint.HideHint;
  FDown := True;
  if GetItemFromPoint(Point(X, Y)) <> -1
    then FItemDown := True else FItemDown := False;
  RePaint;
end;

procedure TbsSkinImagesMenuPopupWindow.MouseUp(Button: TMouseButton; Shift: TShiftState;
   X, Y: Integer);
var
  I: Integer;
begin
  inherited;

  if not FDown
  then
    begin
      if GetCapture = Handle then ReleaseCapture;
      SetCapture(Handle);
    end
  else
    begin
      I := GetItemFromPoint(Point(X, Y));
      if I <> -1 then ImagesMenu.ItemIndex := I;
      Hide(I <> -1);
    end;
end;

procedure TbsSkinImagesMenuPopupWindow.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TestActive(X, Y);
end;

procedure TbsSkinImagesMenuPopupWindow.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TbsSkinImagesMenuPopupWindow.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
     begin
       if Windows.WindowFromPoint(Mouse.CursorPos) <> Self.Handle
       then
         Hide(False);
     end;
  end;
end;

procedure TbsSkinImagesMenuPopupWindow.HookApp;
begin
  OldAppMessage := Application.OnMessage;
  Application.OnMessage := NewAppMessage;
end;

procedure TbsSkinImagesMenuPopupWindow.UnHookApp;
begin
  Application.OnMessage := OldAppMessage;
end;

procedure TbsSkinImagesMenuPopupWindow.NewAppMessage;
begin
  case Msg.message of
     WM_MOUSEACTIVATE, WM_ACTIVATE,
     WM_RBUTTONDOWN, WM_MBUTTONDOWN,
     WM_NCLBUTTONDOWN, WM_NCMBUTTONDOWN, WM_NCRBUTTONDOWN,
     WM_KILLFOCUS, WM_MOVE, WM_SIZE, WM_CANCELMODE, WM_PARENTNOTIFY,
     WM_KEYDOWN, WM_CHAR, WM_KEYUP, WM_SYSKEYDOWN, WM_SYSCHAR:
      begin
        Hide(False);
      end;
  end;
end;

procedure TbsSkinImagesMenuPopupWindow.SetMenuWindowRegion;
var
  TempRgn: HRgn;
begin
  TempRgn := FRgn;
  with ImagesMenu.FSkinData.PopupWindow do
  CreateSkinRegion
    (FRgn, LTPoint, RTPoint, LBPoint, RBPoint, ItemsRect,
     NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewItemsRect,
     MaskPicture, Width, Height);
  SetWindowRgn(Handle, FRgn, True);
  if TempRgn <> 0 then DeleteObject(TempRgn);
end;


end.
