unit FFPBox;
{=======================================================}
interface
{=======================================================}
uses
Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
ExtCtrls;

type
TFFPaintEvent = procedure (Sender: TObject; Canvas: TCanvas) of Object;

TFlickerFreePaintBox = class(TCustomControl)
private
{ Private declarations }
FOnFFPaint:TFFPaintEvent;
protected
{ Protected declarations }
procedure Paint; override;
procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
public
{ Public declarations }
constructor Create(AOwner: TComponent); override;
published
{ Published declarations }
property OnPaint:TFFPaintEvent read FOnFFPaint write FOnFFPaint;
property Align;
property Color;
property DragCursor;
property DragMode;
property Enabled;
property Font;
property ParentColor;
property ParentFont;
property ParentShowHint;
property PopupMenu;
property ShowHint;
property Visible;
property OnClick;
property OnDblClick;
property OnDragDrop;
property OnDragOver;
property OnEndDrag;
property OnMouseDown;
property OnMouseMove;
property OnMouseUp;
property OnStartDrag;
end;

procedure Register;
{=======================================================}
implementation
{=======================================================}
constructor TFlickerFreePaintBox.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
TabStop := False;
end;
{-------------------------------------------------------}
procedure TFlickerFreePaintBox.Paint;
var bmp: TBitmap;
begin
if csDesigning in ComponentState then
with Canvas do
begin
Pen.Style := psDash;
Brush.Style := bsSolid;
Canvas.Brush.Color := Color;
Rectangle(0, 0, Width, Height);
exit;
end;

bmp := TBitmap.Create;
try
bmp.Canvas.Brush.Color := Color;
bmp.Width := Width;
bmp.Height := Height;
bmp.Canvas.Font := Font;
if Assigned(FOnFFPaint) then begin
FOnFFPaint(Self, bmp.Canvas);
Canvas.Draw(0,0, bmp);
end;
finally
bmp.Free;
end;
end;
{-------------------------------------------------------}
{------------------------¹Ø¼üÖ®´¦-----------------------}
procedure TFlickerFreePaintBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
Message.Result := 1;
end;
{=======================================================}
procedure Register;
begin
RegisterComponents('System', [TFlickerFreePaintBox]);
end;

end.