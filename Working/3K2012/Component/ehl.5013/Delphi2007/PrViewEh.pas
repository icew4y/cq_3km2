{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{                  TPreviewBox component                }
{                    (Build 5.0.00)                     } 
{                                                       }
{   Copyright (c) 1998-2006 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrViewEh {$IFDEF CIL} platform{$ENDIF};

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, PrntsEh,
{$IFDEF CIL}
  WinUtils,
{$ELSE}
{$ENDIF}
  ExtCtrls, Printers;

type

  TViewMode = (vm500, vm200, vm150, vm100, vm75, vm50, vm25, vm10, vmPageWidth, vmFullPage);

{ TDrawPanel }

  TDrawPanel = class(TPanel)
  private
    FOldMousePos: TPoint;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  end;

  TPrinterPreview = class;

{ TPreviewBox }

  TPreviewBox = class(TScrollBox)
  private
    FDrawPanel: TDrawPanel;
    FOnOpenPreviewer: TNotifyEvent;
    FOnPrinterPreviewChanged: TNotifyEvent;
    FOnPrinterSetupChanged: TNotifyEvent;
    FOnPrinterSetupDialog: TNotifyEvent;
    FPageCount: Integer;
    FPageIndex: Integer;
    FPrinter: TPrinterPreview;
    FPrinterSetupOwner: TComponent;
    FViewMode: TViewMode;
    pnlShadow: TPanel;
//    FOnNeedOpenPreview: TNotifyEvent;
    procedure SetPageIndex(Value: Integer);
    procedure SetPrinter(const Value: TPrinterPreview);
    procedure SetPrinterSetupOwner(const Value: TComponent);
    procedure SetViewMode(const Value: TViewMode);
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    FScalePercent: Integer;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PrintDialog;
    procedure PrinterSetupDialog;
    procedure UpdatePageSetup;
    procedure UpdatePreview;
    property OnPrinterSetupChanged: TNotifyEvent read FOnPrinterSetupChanged { write FOnPrinterSetupChanged};
    property OnPrinterSetupDialog: TNotifyEvent read FOnPrinterSetupDialog { write FOnPrinterSetupDialog};
    property PageCount: Integer read FPageCount;
    property PageIndex: Integer read FPageIndex write SetPageIndex;
    property Printer: TPrinterPreview read FPrinter write SetPrinter;
    property PrinterSetupOwner: TComponent read FPrinterSetupOwner write SetPrinterSetupOwner;
    property ViewMode: TViewMode read FViewMode write SetViewMode;
  published
    property OnOpenPreviewer: TNotifyEvent read FOnOpenPreviewer write FOnOpenPreviewer;
    property OnPrinterPreviewChanged: TNotifyEvent read FOnPrinterPreviewChanged write FOnPrinterPreviewChanged;
//    property OnNeedOpenPreview:TNotifyEvent read FOnNeedOpenPreview write FOnNeedOpenPreview;
  end;

//  TGetPreviewerEvent = function (Sender: TObject): TPreviewBox of object;

{ TPrinterPreview }

  TPrinterPreview = class(TVirtualPrinter)
  private
    FAborted: Boolean;
    FMetafileCanvas: TMetafileCanvas;
    FMetafileList: TList;
    FOnPrinterSetupChanged: TNotifyEvent;
    FOnPrinterSetupDialog: TNotifyEvent;
    FPageNumber: Integer;
    FPreviewer: TPreviewBox;
    FPrinter: TPrinter;
    FPrinterSetupOwner: TComponent;
    FPrinting: Boolean;
//    FOnGetPreviewer: TGetPreviewerEvent;
//    FOnOpenPreviewer: TNotifyEvent;
    function GetPropPrinter: TPrinter;
    procedure SetOnPrinterSetupDialog(const Value: TNotifyEvent);
    procedure SetPreviewer(const Value: TPreviewBox);
//    function Previewer: TPreviewBox;
  protected
    function GetAborted: Boolean; override;
    function GetCanvas: TCanvas; override;
    function GetCapabilities: TPrinterCapabilities; override;
    function GetFonts: TStrings; override;
    function GetFullPageHeight: Integer; override;
    function GetFullPageWidth: Integer; override;
    function GetHandle: HDC; override;
    function GetNumCopies: Integer; override;
    function GetOrientation: TPrinterOrientation; override;
    function GetPageHeight: Integer; override;
    function GetPageNumber: Integer; override;
    function GetPageWidth: Integer; override;
    function GetPrinterIndex: Integer; override;
    function GetPrinters: TStrings; override;
    function GetPrinting: Boolean; override;
    function GetTitle: String; override;
    function GetPixelsPerInchX: Integer; override;
    function GetPixelsPerInchY: Integer; override;
    procedure DrawPage(Sender: TObject; Canvas: TCanvas; PageNumber: Integer);
    procedure SetNumCopies(const Value: Integer); override;
    procedure SetOrientation(const Value: TPrinterOrientation); override;
    procedure SetPrinterIndex(const Value: Integer); override;
    procedure SetTitle(const Value: string); override;
    procedure ShowProgress(Percent: Integer); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Abort; override;
    procedure BeginDoc; override;
    procedure EndDoc; override;
{$IFDEF CIL}
    procedure GetPrinter(ADevice, ADriver, APort: String; var ADeviceMode: IntPtr); override;
    procedure SetPrinter(ADevice, ADriver, APort: String; ADeviceMode: IntPtr); override;
{$ELSE}
    procedure GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle); override;
    procedure SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle); override;
{$ENDIF}
    procedure NewPage; override;
    procedure OpenPreview;
    procedure Print;
    property OnPrinterSetupChanged: TNotifyEvent read FOnPrinterSetupChanged write FOnPrinterSetupChanged;
    property OnPrinterSetupDialog: TNotifyEvent read FOnPrinterSetupDialog write SetOnPrinterSetupDialog;
    property Previewer: TPreviewBox read FPreviewer write SetPreviewer;
    property Printer: TPrinter read GetPropPrinter;
    property PrinterSetupOwner: TComponent read FPrinterSetupOwner write FPrinterSetupOwner;
    property PixelsPerInchX: Integer read GetPixelsPerInchX;
    property PixelsPerInchY: Integer read GetPixelsPerInchY;
//    property OnGetPreviewer: TGetPreviewerEvent read FOnGetPreviewer write FOnGetPreviewer;
//    property OnOpenPreviewer: TNotifyEvent read FOnOpenPreviewer write FOnOpenPreviewer;
  end;


function PrinterPreview: TPrinterPreview;
function SetPrinterPreview(NewPrinterPreview: TPrinterPreview): TPrinterPreview;

const
  DefaultPrinterPhysicalOffSetX: Integer = 130;
  DefaultPrinterPhysicalOffSetY: Integer = 150;
  DefaultPrinterPageWidth: Integer = 4676;
  DefaultPrinterPageHeight: Integer = 6744;
  DefaultPrinterPixelsPerInchX: Integer = 600;
  DefaultPrinterPixelsPerInchY: Integer = 600;
  DefaultPrinterVerticalSizeMM: Integer = 285;
  DefaultPrinterHorizontalSizeMM: Integer = 198;

implementation

{$R PrViewEh.RES}

uses PrvFrmEh {$IFDEF EH_LIB_6} ,Types {$ENDIF};

var crMagnifier: Integer = 0;
  crHand: Integer = 0;

var
  FPrinterPreview: TPrinterPreview = nil;

function PrintersSetPrinter(NewPrinter: TPrinter): TPrinter;
begin
  Result := SetPrinter(NewPrinter);
end;

function PrintersPrinter: TPrinter;
begin
  Result := Printer;
end;

{ TDrawPanel }

constructor TDrawPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clWhite;
  //Visible:=False;
  Cursor := crMagnifier;
  ControlStyle := ControlStyle + [csCaptureMouse];
end;

procedure TDrawPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.style := Params.WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TDrawPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FOldMousePos := Point(X, Y);
end;

procedure TDrawPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var Parent: TPreviewBox;
  oldScrollPos: TPoint;
begin
  inherited MouseMove(Shift, X, Y);
  Parent := TPreviewBox(Self.Parent);
  if (ssLeft in Shift) and
    ((FOldMousePos.x <> X) or (FOldMousePos.y <> Y) or (Cursor = crHand)) and
    MouseCapture then
  begin
    if (Cursor <> crHand) then
    begin
      Cursor := crHand;
      Perform(WM_SETCURSOR, Handle, HTCLIENT);
    end;
    oldScrollPos := Point(Parent.HorzScrollBar.Position, Parent.VertScrollBar.Position);
    Parent.VertScrollBar.Position := Parent.VertScrollBar.Position + FOldMousePos.y - Y;
    Parent.HorzScrollBar.Position := Parent.HorzScrollBar.Position + FOldMousePos.x - X;
    if oldScrollPos.x = Parent.HorzScrollBar.Position then FOldMousePos.x := X;
    if oldScrollPos.y = Parent.VertScrollBar.Position then FOldMousePos.y := Y;
  end;
end;

procedure TDrawPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var oldh, oldw, oldl, oldt: Integer;
  Parent: TPreviewBox;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if (Button = mbLeft) and (Cursor = crMagnifier) then
  begin
    Parent := TPreviewBox(Self.Parent);
    if Parent.ViewMode = vmFullPage then
    begin
      oldh := Height; oldw := Width;
      oldl := Left; oldt := Top;
      Parent.ViewMode := vm150;
      Parent.VertScrollBar.Position := Height * Y div oldh + 16 - oldt - Y;
      Parent.HorzScrollBar.Position := Width * X div oldw + 16 - oldl - X;
    end
    else Parent.ViewMode := vmFullPage;
  end
  else Cursor := crMagnifier;
end;

procedure TDrawPanel.Paint;
var
  FullWidth, FullHeight, XOffSet, YOffSet: Integer;
  Parent: TPreviewBox;
begin
  Parent := TPreviewBox(Self.Parent);
  if Parent.Printer.Printers.Count > 0 then
  begin
    XOffSet := GetDeviceCaps(Parent.Printer.Handle, PHYSICALOFFSETX);
    YOffSet := GetDeviceCaps(Parent.Printer.Handle, PHYSICALOFFSETY);
  end else
  begin
    XOffSet := DefaultPrinterPhysicalOffSetX;
    YOffSet := DefaultPrinterPhysicalOffSetY;
  end;
  FullWidth := Parent.Printer.PageWidth + XOffSet * 2;
  FullHeight := Parent.Printer.PageHeight + YOffSet * 2;
  with Canvas do
  begin
    Brush.Color := clWhite;
    Brush.Style := bsSolid;
    FillRect(ClientRect);
    SetMapMode(Canvas.Handle, mm_AnIsotropic);
    SetWindowExtEx(Canvas.Handle, FullWidth, FullHeight, nil);
    SetViewportExtEx(Canvas.Handle, Width, Height, nil);
    SetViewportOrgEx(Canvas.Handle, Trunc(XOffSet * Width / FullWidth),
      Trunc(YOffSet * Height / FullHeight), nil);

    if Parent.Printer.Printers.Count > 0 then
    begin
      Font.PixelsPerInch := GetDeviceCaps(Parent.Printer.Handle, LOGPIXELSX);
      if Font.PixelsPerInch > GetDeviceCaps(Parent.Printer.Handle, LOGPIXELSY) then
        Font.PixelsPerInch := GetDeviceCaps(Parent.Printer.Handle, LOGPIXELSY);
    end
    else
      Font.PixelsPerInch := DefaultPrinterPixelsPerInchX;

    if Assigned(Parent.Printer) and (Parent.PageCount > 0) then
      Parent.Printer.DrawPage(Self, Self.Canvas, Parent.PageIndex);
  end;
end;

procedure TDrawPanel.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  if Cursor = crHand then Cursor := crMagnifier;
end;

{ TPreviewBox }

constructor TPreviewBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls]; //clip_children
  FViewMode := vmFullPage;
  FPageCount := 0;
  FPageIndex := 1;
  pnlShadow := TPanel.Create(Self {AOwner});
  with pnlShadow do
  begin
    ControlStyle := ControlStyle - [csAcceptsControls];
    Parent := Self;
    BevelOuter := bvNone;
    Color := 4210752;
    Enabled := False;
    TabOrder := 0;
    //Visible := False;
  end;
  FDrawPanel := TDrawPanel.Create(Self {AOwner});
  with FDrawPanel do
  begin
    ControlStyle := ControlStyle - [csAcceptsControls];
    Parent := Self;
    BevelOuter := bvNone;
    ParentCtl3D := False;
    Ctl3D := False;
    BorderStyle := bsSingle;
    Left := 8;
    Top := 8;
  end;
  FPrinter := TPrinterPreview.Create;
  FPrinter.Previewer := Self;
  HorzScrollBar.Tracking := True;
  VertScrollBar.Tracking := True;
  FScalePercent := 100;
end;

destructor TPreviewBox.Destroy;
begin
  FreeAndNil(FPrinter);
  inherited;
end;

procedure TPreviewBox.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CLIPCHILDREN;
end;

procedure TPreviewBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  with VertScrollBar do
    case Key of
      VK_UP:
        if ssCtrl in Shift then Position := Position - ClientHeight + Increment
        else Position := Position - Increment;
      VK_Down:
        if ssCtrl in Shift then Position := Position + ClientHeight - Increment
        else Position := Position + Increment;
      VK_Prior:
        if ssCtrl in Shift then Position := 0
        else Position := Position - ClientHeight + Increment;
      VK_Next:
        if ssCtrl in Shift then Position := Range
        else Position := Position + ClientHeight - Increment;
    end;
  with HorzScrollBar do
    case Key of
      VK_Left:
        if ssCtrl in Shift then Position := Position - ClientWidth + Increment
        else Position := Position - Increment;
      VK_Right:
        if ssCtrl in Shift then Position := Position + ClientWidth - Increment
        else Position := Position + Increment;
      VK_Home:
        if ssCtrl in Shift then
        begin
          Position := 0;
          VertScrollBar.Position := 0;
        end
        else Position := 0;
      VK_End:
        if ssCtrl in Shift then
        begin
          Position := Range;
          VertScrollBar.Position := VertScrollBar.Range;
        end
        else Position := Range;
    end;
end;

procedure TPreviewBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  SetFocus;
end;

procedure TPreviewBox.PrintDialog;
var Page: Integer;
  OldPrinter: TPrinter;
begin
  OldPrinter := PrintersSetPrinter(Printer.Printer);
  try
    with TPrintDialog.Create(Owner) do
    try
      Options := Options + [poPageNums];
      MinPage := 1;
      MaxPage := PageCount;
      FromPage := 1;
      ToPage := PageCount;
      if Execute then
        if Assigned(Printer) then
        begin
          if Printer.FMetafileList.Count = 0 then Exit;
          with PrintersPrinter do
          begin
            BeginDoc;
            for Page := FromPage to ToPage do
            begin
              Printer.DrawPage(Printer, Canvas, Page);
              if Page < ToPage then NewPage;
            end;
            EndDoc;
          end;
        end;
    finally
      Free;
    end;
  finally
    PrintersSetPrinter(OldPrinter);
  end;
end;

procedure TPreviewBox.PrinterSetupDialog;
var OldPrinter: TPrinter;
begin
  OldPrinter := PrintersSetPrinter(Printer.Printer);
  try
    if Assigned(OnPrinterSetupDialog) then
      OnPrinterSetupDialog(Self)
    else
      with TPrinterSetupDialog.Create(Owner) do
      try
        if Execute then
        begin
          UpdatePageSetup;
          if Assigned(FOnPrinterSetupChanged)
            then FOnPrinterSetupChanged(Self);
        end;
      finally
        Free;
      end;
  finally
    PrintersSetPrinter(OldPrinter);
  end;
end;

procedure TPreviewBox.SetPageIndex(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > PageCount then Value := PageCount;
  if Value <> FPageIndex then
  begin
    FPageIndex := Value;
    UpdatePreview;
    if Assigned(OnPrinterPreviewChanged) then OnPrinterPreviewChanged(Self);
  end;
end;

procedure TPreviewBox.SetPrinter(const Value: TPrinterPreview);
begin
  FPrinter := Value;
end;

procedure TPreviewBox.SetViewMode(const Value: TViewMode);
begin
  if Value <> FViewMode then
  begin
    FViewMode := Value;
    UpdatePageSetup;
  end;
  if Assigned(OnPrinterPreviewChanged) then OnPrinterPreviewChanged(Self);
end;

procedure TPreviewBox.UpdatePageSetup;
var
  Scaling: Integer;
  ALeft, ATop, AWidth, AHeight: Integer;
begin
//  pnlShadow.Visible:=False;
//  LockWindowUpdate(Handle);
  try
    with FDrawPanel, Printer do
    begin
      ALeft := Left; ATop := Top; AWidth := Width; AHeight := Height;
//    Visible:=False;
      case FViewMode of
        vm500: Scaling := 500;
        vm200: Scaling := 200;
        vm150: Scaling := 150;
        vm100: Scaling := 100;
        vm75: Scaling := 75;
        vm50: Scaling := 50;
        vm25: Scaling := 25;
        vm10: Scaling := 10;
        vmPageWidth: // on width pages
          begin
            VertScrollBar.Position := 0;
            HorzScrollBar.Position := 0;
            Scaling := 1;
            ALeft := 8;
            ATop := 8;
            AWidth := Self.Width - 20 - GetSystemMetrics(sm_CXVScroll);
            if Printer.Printers.Count > 0 then
            begin
              AHeight := AWidth * GetDeviceCaps(Printer.Handle, VertSize) div
                GetDeviceCaps(Printer.Handle, HorzSize);
              FScalePercent := AWidth * 100 div (PageWidth * (Self.Owner as TForm).PixelsPerInch div
                GetDeviceCaps(Printer.Handle, LOGPIXELSX));
            end else
            begin
              AHeight := AWidth * DefaultPrinterVerticalSizeMM div
                DefaultPrinterHorizontalSizeMM;
              FScalePercent := AWidth * 100 div (PageWidth * (Self.Owner as TForm).PixelsPerInch div
                DefaultPrinterPixelsPerInchX);
            end;
            VertScrollBar.Range := AHeight + 16;
            HorzScrollBar.Range := 0;
          end;
        vmFullPage: // страница целиком
          begin
            Scaling := 1;
            VertScrollBar.Range := 0;
            HorzScrollBar.Range := 0;
            VertScrollBar.Position := 0;
            HorzScrollBar.Position := 0;
            AHeight := Self.ClientHeight - 16;
            if Printer.Printers.Count > 0 then
              AWidth := AHeight * GetDeviceCaps(Printer.Handle, HorzSize) div
                GetDeviceCaps(Printer.Handle, VertSize)
            else
              AWidth := AHeight * DefaultPrinterHorizontalSizeMM div
                DefaultPrinterVerticalSizeMM;
            if AWidth > Self.ClientWidth - 16 then
            begin
              AWidth := Self.ClientWidth - 16;
              if Printer.Printers.Count > 0 then
                AHeight := AWidth * GetDeviceCaps(Printer.Handle, VertSize) div
                  GetDeviceCaps(Printer.Handle, HorzSize)
              else
                AHeight := AWidth * DefaultPrinterVerticalSizeMM div
                  DefaultPrinterHorizontalSizeMM;
            end;
            ALeft := (Self.ClientWidth - AWidth) div 2;
            ATop := (Self.ClientHeight - AHeight) div 2;
            FScalePercent := 100;
          end;
      else Scaling := 1;
      end;
      case FViewMode of
        vm500..vm10:
          begin
            VertScrollBar.Position := 0;
            HorzScrollBar.Position := 0;
            ALeft := 8;
            ATop := 8;
            if Printer.Printers.Count > 0 then
            begin
//              AWidth := Scaling * PageWidth * (Self.Owner as TForm).PixelsPerInch div
              AWidth := Scaling * PageWidth * Screen.PixelsPerInch div
                GetDeviceCaps(Printer.Handle, LOGPIXELSX) div 100;
              AHeight := AWidth * GetDeviceCaps(Printer.Handle, VertSize) div
                GetDeviceCaps(Printer.Handle, HorzSize);
            end else
            begin
//              AWidth := Scaling * PageWidth * (Self.Owner as TForm).PixelsPerInch div
              AWidth := Scaling * PageWidth * Screen.PixelsPerInch div
                DefaultPrinterPixelsPerInchX div 100;
              AHeight := AWidth * DefaultPrinterVerticalSizeMM div
                DefaultPrinterHorizontalSizeMM;
            end;
            VertScrollBar.Range := AHeight + 16;
            HorzScrollBar.Range := AWidth + 16;
            if (AWidth + 16) < Self.ClientWidth then
              ALeft := (Self.ClientWidth - AWidth) div 2;
            if (AHeight + 16) < Self.ClientHeight then
              ATop := (Self.ClientHeight - AHeight) div 2;
            FScalePercent := Scaling;
          end;
      end;
    //Visible:=True;
    end;
    FDrawPanel.Invalidate;
    FDrawPanel.SetBounds(ALeft, ATop, AWidth, AHeight);
    pnlShadow.SetBounds(FDrawPanel.Left + 4, FDrawPanel.Top + 4, FDrawPanel.Width, FDrawPanel.Height);
    //pnlShadow.Visible:=True;
  finally
//    LockWindowUpdate(0);
  end;
end;

procedure TPreviewBox.UpdatePreview;
begin
  Invalidate;
  FDrawPanel.Invalidate;
{  with FDrawPanel do
  begin
    Hide;
    Show;
  end;}
end;

procedure TPreviewBox.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  Msg.Result := DLGC_WANTARROWS;
end;

procedure TPreviewBox.WMSize(var Message: TWMSize);
begin
  inherited;
  if (ViewMode in [vmPageWidth, vmFullPage]) or
    ((FDrawPanel.Width + 16) < ClientWidth) or
    ((FDrawPanel.Height + 16) < ClientHeight) then
    UpdatePageSetup;
end;

procedure TPreviewBox.SetPrinterSetupOwner(const Value: TComponent);
begin
  if FPrinterSetupOwner = Value then Exit;
  FPrinterSetupOwner := Value;
  if Assigned(Value) then FPrinterSetupOwner.FreeNotification(Self);
  if Assigned(OnPrinterPreviewChanged) then OnPrinterPreviewChanged(Self);
end;

procedure TPreviewBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = PrinterSetupOwner)
    then PrinterSetupOwner := nil;
end;

function TPreviewBox.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    with VertScrollBar do
      if Range < ClientHeight
        then PageIndex := PageIndex + 1
        else Position := Position + Increment * Mouse.WheelScrollLines * FScalePercent div 100;
    Result := True;
  end;
end;

function TPreviewBox.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    with VertScrollBar do
      if Range < ClientHeight
        then PageIndex := PageIndex - 1
        else Position := Position - Increment * Mouse.WheelScrollLines * FScalePercent div 100;
    Result := True;
  end;
end;

{ TPrinterPreview }

constructor TPrinterPreview.Create;
begin
  inherited Create;
  FMetafileList := TList.Create;
  FPrinter := TPrinter.Create;
end;

destructor TPrinterPreview.Destroy;
var i: Integer;
begin
  for i := 0 to FMetafileList.Count - 1 do
    TMetaFile(FMetafileList[i]).Free;
  FreeAndNil(FMetafileList);
  FreeAndNil(FPrinter);
  inherited Destroy;
end;

procedure TPrinterPreview.Abort;
begin
  FAborted := True;
end;

procedure TPrinterPreview.BeginDoc;
var i: Integer;
  FontSize: Integer;
begin
  for i := 0 to FMetafileList.Count - 1 do TMetaFile(FMetafileList[i]).Free;
  FMetafileList.Clear;

  FMetafileList.Add(TMetaFile.Create());
  if Printer.Printers.Count > 0
    then FMetafileCanvas := TMetafileCanvas.Create(
      TMetafile(FMetafileList[FMetafileList.Count - 1]), Printer.Handle {0})
  else FMetafileCanvas := TMetafileCanvas.Create(
      TMetafile(FMetafileList[FMetafileList.Count - 1]), 0);
  FontSize := FMetafileCanvas.Font.Size;

  if Printer.Printers.Count > 0 then
  begin
    FMetafileCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    if FMetafileCanvas.Font.PixelsPerInch > GetDeviceCaps(Printer.Handle, LOGPIXELSY) then
      FMetafileCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  end
  else
    FMetafileCanvas.Font.PixelsPerInch := DefaultPrinterPixelsPerInchX;

  FMetafileCanvas.Font.Size := FontSize;
  FPageNumber := 1;
  FAborted := False;
  FPrinting := True;
  Previewer.FPageCount := 1;
  Previewer.FPageIndex := 1;
  if Assigned(Previewer.OnPrinterPreviewChanged)
    then Previewer.OnPrinterPreviewChanged(Self);
end;

procedure TPrinterPreview.NewPage;
var FontSize: Integer;
begin
  FMetafileList.Add(TMetaFile.Create());
  FMetafileCanvas.Free;
  if FMetafileList.Count = 2 then
    Previewer.UpdatePageSetup; //UpdatePreview;
  if Printer.Printers.Count > 0 then
    FMetafileCanvas := TMetafileCanvas.Create(
      TMetafile(FMetafileList[FMetafileList.Count - 1]), Printer.Handle {0})
  else
    FMetafileCanvas := TMetafileCanvas.Create(
      TMetafile(FMetafileList[FMetafileList.Count - 1]), 0);
  FontSize := FMetafileCanvas.Font.Size;
  if Printer.Printers.Count > 0 then
  begin
    FMetafileCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
    if FMetafileCanvas.Font.PixelsPerInch > GetDeviceCaps(Printer.Handle, LOGPIXELSY) then
      FMetafileCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  end
  else
    FMetafileCanvas.Font.PixelsPerInch := DefaultPrinterPixelsPerInchX;
  FMetafileCanvas.Font.Size := FontSize;
  Inc(FPageNumber);
  Previewer.FPageCount := FMetafileList.Count - 1;
  //if Assigned(Previewer.OnNeedOpenPreview) then Previewer.OnNeedOpenPreview(Self);
  OpenPreview;
  if Assigned(Previewer.OnPrinterPreviewChanged)
    then Previewer.OnPrinterPreviewChanged(Self);
end;

procedure TPrinterPreview.EndDoc;
begin
  FreeAndNil(FMetafileCanvas);
  Previewer.FPageCount := FMetafileList.Count;
  if FMetafileList.Count = 1 then Previewer.UpdatePageSetup; // UpdatePreview;
  FPageNumber := -1;
  FPrinting := False;
  Previewer.FOnPrinterSetupDialog := OnPrinterSetupDialog;
  OnPrinterSetupDialog := nil;
  Previewer.FOnPrinterSetupChanged := OnPrinterSetupChanged;
  OnPrinterSetupChanged := nil;
  Previewer.PrinterSetupOwner := PrinterSetupOwner;
  PrinterSetupOwner := nil;
  //if Assigned(Previewer.OnNeedOpenPreview) then Previewer.OnNeedOpenPreview(Self);
  OpenPreview;
  if Assigned(Previewer.OnPrinterPreviewChanged)
    then Previewer.OnPrinterPreviewChanged(Self);
end;

function TPrinterPreview.GetAborted: Boolean;
begin
  Result := FAborted;
end;

function TPrinterPreview.GetCanvas: TCanvas;
begin
  Result := FMetafileCanvas;
end;

function TPrinterPreview.GetFonts: TStrings;
begin
  Result := Printer.Fonts;
end;

function TPrinterPreview.GetNumCopies: Integer;
begin
  Result := Printer.Copies;
end;

function TPrinterPreview.GetOrientation: TPrinterOrientation;
begin
  Result := Printer.Orientation;
end;

function TPrinterPreview.GetPageHeight: Integer;
begin
  if Printer.Printers.Count > 0
    then Result := Printer.PageHeight
    else Result := DefaultPrinterPageHeight;
end;

function TPrinterPreview.GetPageNumber: Integer;
begin
  Result := FPageNumber;
end;

function TPrinterPreview.GetPageWidth: Integer;
begin
  if Printer.Printers.Count > 0
    then Result := Printer.PageWidth
    else Result := DefaultPrinterPageWidth;
end;

function TPrinterPreview.GetPrinting: Boolean;
begin
  Result := FPrinting;
end;

function TPrinterPreview.GetTitle: String;
begin
  Result := Printer.Title;
end;

procedure TPrinterPreview.DrawPage(Sender: TObject;
  Canvas: TCanvas; PageNumber: Integer);
begin
  Canvas.Draw(0, 0, TMetafile(FMetafileList[PageNumber - 1]));
end;

procedure TPrinterPreview.SetNumCopies(const Value: Integer);
begin
  Printer.Copies := Value;
end;

procedure TPrinterPreview.SetOnPrinterSetupDialog(const Value: TNotifyEvent);
begin
  FOnPrinterSetupDialog := Value;
end;

procedure TPrinterPreview.SetOrientation(const Value: TPrinterOrientation);
begin
  Printer.Orientation := Value;
end;

procedure TPrinterPreview.SetTitle(const Value: string);
begin
  Printer.Title := Value;
end;

procedure TPrinterPreview.ShowProgress(Percent: Integer);
begin
end;

function TPrinterPreview.GetPropPrinter: TPrinter;
begin
  Result := FPrinter;
end;

function TPrinterPreview.GetFullPageHeight: Integer;
begin
  if Printer.Printers.Count > 0 then
    Result := Printer.PageHeight + GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY) * 2
  else
    Result := DefaultPrinterPageHeight + DefaultPrinterPhysicalOffSetY * 2;
end;

function TPrinterPreview.GetFullPageWidth: Integer;
begin
  if Printer.Printers.Count > 0 then
    Result := Printer.PageWidth + GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX) * 2
  else
    Result := DefaultPrinterPageWidth + DefaultPrinterPhysicalOffSetX * 2;
end;

function TPrinterPreview.GetHandle: HDC;
begin
  Result := Printer.Handle;
end;

function TPrinterPreview.GetPixelsPerInchX: Integer;
begin
  if Printer.Printers.Count > 0 then
    Result := GetDeviceCaps(Printer.Handle, LOGPIXELSX)
  else
    Result := DefaultPrinterPixelsPerInchX;
end;

function TPrinterPreview.GetPixelsPerInchY: Integer;
begin
  if Printer.Printers.Count > 0 then
    Result := GetDeviceCaps(Printer.Handle, LOGPIXELSY)
  else
    Result := DefaultPrinterPixelsPerInchY;
end;

{$IFDEF CIL}
procedure TPrinterPreview.GetPrinter(ADevice, ADriver, APort: String; var ADeviceMode: IntPtr);
{$ELSE}
procedure TPrinterPreview.GetPrinter(ADevice, ADriver, APort: PChar; var ADeviceMode: THandle);
{$ENDIF}
begin
  Printer.GetPrinter(ADevice, ADriver, APort, ADeviceMode);
end;

{$IFDEF CIL}
procedure TPrinterPreview.SetPrinter(ADevice, ADriver, APort: String; ADeviceMode: IntPtr);
{$ELSE}
procedure TPrinterPreview.SetPrinter(ADevice, ADriver, APort: PChar; ADeviceMode: THandle);
{$ENDIF}
begin
  Printer.SetPrinter(ADevice, ADriver, APort, ADeviceMode);
end;

function TPrinterPreview.GetCapabilities: TPrinterCapabilities;
begin
  Result := Printer.Capabilities;
end;

function TPrinterPreview.GetPrinterIndex: Integer;
begin
  Result := Printer.PrinterIndex;
end;

function TPrinterPreview.GetPrinters: TStrings;
begin
  Result := Printer.Printers;
end;

procedure TPrinterPreview.SetPrinterIndex(const Value: Integer);
begin
  Printer.PrinterIndex := Value;
end;

{
function TPrinterPreview.Previewer: TPreviewBox;
begin
  Result := nil;
  if Assigned(OnGetPreviewer) then Result := OnGetPreviewer(Self);
  if not Assigned(Result) then
  begin
    if not Assigned(PreviewFormEh) then PreviewFormEh := TPreviewFormEh.Create(Application.MainForm);
    Result := PreviewFormEh.PreviewEh1;
  end;
end;
}

procedure TPrinterPreview.OpenPreview;
begin
  if Assigned(Previewer.OnOpenPreviewer) then Previewer.OnOpenPreviewer(Self);

{  if Assigned(OnOpenPreviewer) then OnOpenPreviewer(Self)
  else if not Assigned(PreviewFormEh) then
  begin
    PreviewFormEh := PreviewFormEh.Create(Application.MainForm);
    PreviewFormEh.Show;
  end
  else
  begin
    if IsIconic(PreviewFormEh.Handle) then ShowWindow(PreviewFormEh.Handle,sw_Restore);
    BringWindowToTop(PreviewFormEh.Handle);
    if not PreviewFormEh.Visible then PreviewFormEh.Show;
  end;}
end;

procedure TPrinterPreview.Print;
var
  Page: Integer;
  OldPrinter: TPrinter;
begin
  if FMetafileList.Count = 0 then Exit;
  OldPrinter := PrintersSetPrinter(Printer);
  try
    with PrintersPrinter do
    begin
      BeginDoc;
      for Page := 0 to FMetafileList.Count - 1 do
      begin
        DrawPage(Self, Canvas, Page + 1);
        if Page < FMetafileList.Count - 1 then NewPage;
      end;
      EndDoc;
    end;
  finally
    PrintersSetPrinter(OldPrinter);
  end;
end;

function PrinterPreview: TPrinterPreview;
begin
  if FPrinterPreview = nil then
  begin
    PreviewFormEh := TPreviewFormEh.Create(Application);
    FPrinterPreview := PreviewFormEh.PreviewEh1.Printer;
  end;
  Result := FPrinterPreview;
end;

function SetPrinterPreview(NewPrinterPreview: TPrinterPreview): TPrinterPreview;
begin
  Result := FPrinterPreview;
  FPrinterPreview := NewPrinterPreview;
end;

procedure TPrinterPreview.SetPreviewer(const Value: TPreviewBox);
begin
  FPreviewer := Value;
end;

function DefineCursor(Identifier: String): TCursor;
var
  Handle: HCursor;
begin
{$IFDEF CIL}
  Handle := LoadCursor(hInstance, Identifier);
{$ELSE}
  Handle := LoadCursor(hInstance, PChar(Identifier));
{$ENDIF}
  if Handle = 0 then raise EOutOfResources.Create('Cannot load cursor resource');
  for Result := 1 to High(TCursor) do
    if Screen.Cursors[Result] = Screen.Cursors[crArrow] then
    begin
      Screen.Cursors[Result] := Handle;
      Exit;
    end;
  raise EOutOfResources.Create('Too many user-defined cursors');
end;

initialization
  crMagnifier := DefineCursor('MAGNIFIEREH');
  crHand := DefineCursor('HANDEH');
end.
