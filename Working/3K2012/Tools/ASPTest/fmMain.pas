unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AbstractTextures, AbstractDevices, AbstractCanvas, ExtCtrls, AsphyreFonts,
  AsphyreImages, StdCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  g_Device : TAsphyreDevice;
  g_Canvas : TAsphyreCanvas;
  g_Fonts: TAsphyreFonts;
  g_Images: TAsphyreImages;
  lpDevMode: TDeviceMode;
  lpDefDevMode: TDeviceMode;
implementation
uses
  DX8Providers, Vectors2px;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  g_Device := DX8Provider.CreateDevice;
  g_Canvas := DX8Provider.CreateCanvas;
  g_Fonts:= TAsphyreFonts.Create();
  g_Fonts.Images:= g_Images;
  g_Fonts.Canvas:= g_Canvas;

  g_Device.WindowHandle := Handle;
  g_Device.Windowed := False;
  EnumDisplaySettings(nil, DWord(-1), lpDefDevMode);
  lpDevMode := lpDefDevMode;
  lpDevMode.dmPelsWidth := 800;
  lpDevMode.dmPelsHeight := 600;
  lpDevMode.dmBitsPerPel := 32;
  ClientWidth := lpDevMode.dmPelsWidth;
  ClientHeight := lpDevMode.dmPelsHeight;
  g_Device.Size := Point2px(ClientWidth, ClientHeight);
  g_Device.ExclusiveMode := True;
  g_Device.VSync := True;
  ChangeDisplaySettings(lpDevMode, 0)
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if (ssAlt in Shift) and (Key = VK_RETURN) then begin
    g_Device.Finalize;
    g_Device.Windowed := not g_Device.Windowed;
    if not g_Device.Windowed then begin
      lpDevMode := lpDefDevMode;
      lpDevMode.dmBitsPerPel := 32;
      ChangeDisplaySettings(lpDevMode, 0);
      BorderStyle := bsSingle;
      ClientWidth := 800;
      ClientHeight := 600;
      g_Device.Size := Point2px(ClientWidth, ClientHeight);
      g_Device.ExclusiveMode := False;
      g_Device.VSync := True;
    end else begin
      lpDevMode.dmPelsWidth := 800;
      lpDevMode.dmPelsHeight := 600;
      lpDevMode.dmBitsPerPel := 32;
      ChangeDisplaySettings(lpDevMode, 0);
      BorderStyle := bsNone;
      ClientWidth := 800;
      ClientHeight := 600;
      g_Device.Size := Point2px(ClientWidth, ClientHeight);
      g_Device.ExclusiveMode := False;
      g_Device.VSync := True;
    end;
    g_Device.Reset;
    g_Device.Initialize;
  end;

end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  g_Canvas.Line(Random(1100),Random(1100),Random(1100),Random(1100),$FF00fFFF);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  g_Device.Initialize;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  g_Device.Render(FormPaint, 0);
end;

end.
