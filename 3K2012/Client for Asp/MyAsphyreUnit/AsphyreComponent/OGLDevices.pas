unit OGLDevices;
//---------------------------------------------------------------------------
// OGLDevices.pas                                       Modified: 16-Mar-2008
// OpenGL device and window handling                              Version 1.0
//---------------------------------------------------------------------------
// Important Notice:
//
// If you modify/use this code or one of its parts either in original or
// modified form, you must comply with Mozilla Public License v1.1,
// specifically section 3, "Distribution Obligations". Failure to do so will
// result in the license breach, which will be resolved in the court.
// Remember that violating author's rights is considered a serious crime in
// many countries. Thank you!
//
// !! Please *read* Mozilla Public License 1.1 document located at:
//  http://www.mozilla.org/MPL/
//---------------------------------------------------------------------------
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//
// The Original Code is OGLDevices.pas.
//
// The Initial Developer of the Original Code is M. Sc. Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007,
// M. Sc. Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, Classes, AbstractDevices;

//---------------------------------------------------------------------------
type
 TOGLDevice = class(TAsphyreDevice)
 private
  ModeChanged: Boolean;
{  WindowRect : TRect;
  BorderStyle: TBorderStyle;}
  WinDC      : HDC;
  Palette    : HPALETTE;
  Context    : HGLRC;
  BitCount   : Integer;

  function FindDisplayMode(Bpp: Integer): Integer;
  function FindBestMode(): Integer;
  function ChangeVideoMode(Mode: Integer): Boolean;
  function RestoreDisplayMode(): Boolean;
  function InitVideoMode(): Boolean;
  procedure SaveWindowState();
  procedure RestoreWindowState();
  function RetreiveWindowDC(): Boolean;
  procedure ReleaseWindowDC();
  function GetFormatDescriptor(): TPixelFormatDescriptor;
  function UpdatePixelFormat(): TPixelFormatDescriptor;
  function VerifyPalette(const FormatDesc: TPixelFormatDescriptor): Boolean;
  function UpdateWindowDC(): Boolean;
  procedure Clear(Color: Cardinal);
  procedure Flip();
 protected
  function InitDevice(): Boolean; override;
  procedure DoneDevice(); override;

  procedure ResetDevice(); override;
  procedure UpdateParams(); override;
 public
  function MayRender(): Boolean; override;

  procedure RenderWith(hWnd: THandle; Handler: TNotifyEvent;
   Background: Cardinal); override;

  procedure RenderToTarget(Handler: TNotifyEvent;
   Background: Cardinal; FillBk: Boolean); override;

  constructor Create(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 GL, AsphyreErrors;

//---------------------------------------------------------------------------
const
 ENUM_CURRENT_SETTINGS  = Cardinal(-1);
 ENUM_REGISTRY_SETTINGS = Cardinal(-2);

//---------------------------------------------------------------------------
function ChangeDisplaySettings(lpDevMode: PDeviceModeA;
 dwFlags: Longword): Integer; stdcall; external user32
 name 'ChangeDisplaySettingsA';

//---------------------------------------------------------------------------
constructor TOGLDevice.Create();
begin
 inherited;

 ModeChanged:= False;
// wglSwapIntervalEXT()
end;

//---------------------------------------------------------------------------
function TOGLDevice.FindDisplayMode(Bpp: Integer): Integer;
var
 DevMode  : TDeviceMode;
 Index    : Integer;
 Avail    : Boolean;
 ModeAvail: Boolean;
 MatchSize: Boolean;
 MatchBpp : Boolean;
begin
 Avail:= False;
 Index:= 0;
 
 while (not Avail) do
  begin
   ModeAvail:= EnumDisplaySettings(nil, Index, DevMode);
   if (ModeAvail) then
    begin
     MatchSize:= (Integer(DevMode.dmPelsWidth) = Size.x)and
      (Integer(DevMode.dmPelsHeight) = Size.y);
     MatchBpp := (Bpp = 0)or(Integer(DevMode.dmBitsPerPel) = Bpp);

     if (MatchSize)and(MatchBpp) then
      begin
       Result:= Index;
       Exit;
      end;
    end;

   Inc(Index);
  end;

 Result:= -1;
end;

//---------------------------------------------------------------------------
function TOGLDevice.FindBestMode(): Integer;
var
 Bits : array[0..2] of Integer;
 i, j : Integer;
 Index: Integer;
begin
 Bits[0]:= 32;
 Bits[1]:= 24;
 Bits[2]:= 16;

 if (not HighBitDepth) then
  begin
   Bits[0]:= 16;
   Bits[1]:= 24;
   Bits[2]:= 32;
  end;

 for j:= 0 to 2 do
  for i:= 0 to 1 do
   begin
    Index:= FindDisplayMode(Bits[j]);
    if (Index <> -1) then
     begin
      Result:= Index;
      Exit;
     end;
   end;

 Result:= -1;
end;

//---------------------------------------------------------------------------
function TOGLDevice.ChangeVideoMode(Mode: Integer): Boolean;
var
 DevMode: TDeviceMode;
begin
 SaveWindowState();

 Result:= EnumDisplaySettings(nil, Mode, DevMode);
 if (not Result) then
  begin
   AsphyreError:= errEnumDisplayMode;
   Exit;
  end;

 Result:=
  ChangeDisplaySettings(@DevMode, CDS_FULLSCREEN) = DISP_CHANGE_SUCCESSFUL;
 if (not Result) then
  begin
   AsphyreError:= errChangeDisplayMode;
   Exit;
  end;

 BitCount:= DevMode.dmBitsPerPel;

{ with MainForm do
  begin
   BorderStyle:= bsNone;
   Left  := 0;
   Top   := 0;
  end;
 MainForm.Width := Width;
 MainForm.Height:= Height;}

 ModeChanged := True;
 AsphyreError:= errNone;
end;

//---------------------------------------------------------------------------
function TOGLDevice.RestoreDisplayMode(): Boolean;
begin
 Result:=
  ChangeDisplaySettings(nil, 0) = DISP_CHANGE_SUCCESSFUL;

 if (not Result) then
  begin
   AsphyreError:= errRestoreDisplayMode;
   Exit;
  end;

 RestoreWindowState();

 ModeChanged := False;
 AsphyreError:= errNone;
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.SaveWindowState();
begin
{ WindowRect := Bounds(MainForm.Left, MainForm.Top, MainForm.Width, MainForm.Height);
 BorderStyle:= MainForm.BorderStyle;}
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.RestoreWindowState();
begin
{ MainForm.BorderStyle:= BorderStyle;
 MainForm.Left  := WindowRect.Left;
 MainForm.Top   := WindowRect.Top;
 MainForm.Width := WindowRect.Right - WindowRect.Left;
 MainForm.Height:= WindowRect.Bottom - WindowRect.Top;}
end;

//---------------------------------------------------------------------------
function TOGLDevice.GetFormatDescriptor(): TPixelFormatDescriptor;
begin
 FillChar(Result, SizeOf(TPixelFormatDescriptor), 0);
 with Result do
  begin
   nSize     := SizeOf(TPixelFormatDescriptor);
   iLayerType:= PFD_MAIN_PLANE; // this is deprecated
   nVersion  := 1;
   dwFlags   := PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or PFD_DOUBLEBUFFER;
   iPixelType:= PFD_TYPE_RGBA;
   cColorBits:= BitCount;
   cDepthBits:= 32;
  end;
end;

//---------------------------------------------------------------------------
function TOGLDevice.InitVideoMode(): Boolean;
var
 Mode: Integer;
begin
 Mode  := FindBestMode();
 Result:= Mode <> -1;

 if (not Result) then
  begin
   AsphyreError:= errUnsupportedDisplayMode;
   Exit;
  end;

 Result:= ChangeVideoMode(Mode);
end;

//---------------------------------------------------------------------------
function TOGLDevice.RetreiveWindowDC(): Boolean;
begin
 WinDC := GetDC(WindowHandle);
 Result:= WinDC <> 0;

 if (not Result) then
  AsphyreError:= errInvalidWindowHandle
   else AsphyreError:= errNone;
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.ReleaseWindowDC();
begin
 ReleaseDC(WindowHandle, WinDC);
end;

//---------------------------------------------------------------------------
function TOGLDevice.UpdatePixelFormat(): TPixelFormatDescriptor;
var
 FormatIndex: Integer;
 FormatDesc : TPixelFormatDescriptor;
begin
 // step 1. prepare some form of requested format
 FormatDesc:= GetFormatDescriptor();

 // step 2. find a best format match
 FormatIndex:= ChoosePixelFormat(WinDC, @FormatDesc);

 // step 3. update the format of the window
 SetPixelFormat(WinDC, FormatIndex, @FormatDesc);

 // step 4. retreive information of updated format
 DescribePixelFormat(WinDC, FormatIndex, SizeOf(TPixelFormatDescriptor),
  FormatDesc);

 Result:= FormatDesc;
end;

//---------------------------------------------------------------------------
function TOGLDevice.VerifyPalette(
 const FormatDesc: TPixelFormatDescriptor): Boolean;
var
 ColorCount: Integer;
 MyPal     : PLogPalette;
 RedMask   : Integer;
 GreenMask : Integer;
 BlueMask  : Integer;
 Index     : Integer;
begin
 Palette:= 0;

 if ((FormatDesc.dwFlags and PFD_NEED_PALETTE) <> 0) then
  begin
   ColorCount:= 1 shl FormatDesc.cColorBits;
   MyPal:= AllocMem(SizeOf(TLogPalette) + (ColorCount * SizeOf(TPaletteEntry)));

   MyPal.palVersion   := $300;
   MyPal.palNumEntries:= ColorCount;

   RedMask  := (1 shl FormatDesc.cRedBits) - 1;
   GreenMask:= (1 shl FormatDesc.cGreenBits) - 1;
   BlueMask := (1 shl FormatDesc.cBlueBits) - 1;

   for Index:= 0 to ColorCount - 1 do
    begin
     MyPal.palPalEntry[Index].peRed:=
      (((Index shr FormatDesc.cRedShift) and RedMask)   * 255) div RedMask;

     MyPal.palPalEntry[Index].peGreen:=
      (((Index shr FormatDesc.cGreenShift) and GreenMask) * 255) div GreenMask;

     MyPal.palPalEntry[Index].peBlue:=
      (((Index shr FormatDesc.cBlueShift) and BlueMask)  * 255) div BlueMask;
      
     MyPal.palPalEntry[Index].peFlags:= 0;
    end;

   Palette:= CreatePalette(MyPal^);
   FreeMem(MyPal);

   Result:= Palette <> 0;
   if (not Result) then
    begin
     AsphyreError:= errCreateWindowPalette;
     Exit;
    end;

   SelectPalette(WinDC, Palette, False);
   RealizePalette(WinDC);
  end;

 Result:= True;
end;

//---------------------------------------------------------------------------
function TOGLDevice.UpdateWindowDC(): Boolean;
var
 FormatDesc: TPixelFormatDescriptor;
begin
 Result:= RetreiveWindowDC();
 if (not Result) then Exit;

 FormatDesc:= UpdatePixelFormat();
 Result:= VerifyPalette(FormatDesc);
end;

//---------------------------------------------------------------------------
function TOGLDevice.InitDevice(): Boolean;
var
 Interval: Integer;
begin
 // (1) Setup the required display mode.
 if (not Windowed) then
  begin
   Result:= InitVideoMode();
   if (not Result) then Exit;
  end;

 // (2) Update the window's DC handle.
 Result:= UpdateWindowDC();
 if (not Result) then
  begin
   RestoreDisplayMode();
   Exit;
  end;

 // (3) Create and activate OpenGL context.
 Context:= wglCreateContext(WinDC);

 ActivateRenderingContext(WinDC, Context);

 wglMakeCurrent(WinDC, Context);

 ReadExtensions();
 ReadImplementationProperties();

 if WGL_EXT_swap_control then
  begin
   Interval:= wglGetSwapIntervalEXT;

   if (VSync)and(Interval <> 1) then wglSwapIntervalEXT(1);
   if (not VSync)and(Interval <> 0) then wglSwapIntervalEXT(0);
  end;

 // (4) Specify some default OpenGL states.
 glEnable(GL_TEXTURE_2D);
 glShadeModel(GL_SMOOTH);
 glClearColor(0.0, 0.0, 0.5, 1.0);
 glClearDepth(1.0);
 glEnable(GL_DEPTH_TEST);
 glDepthFunc(GL_LEQUAL);
 glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);

 glViewport(0, 0, Size.x, Size.y);
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.DoneDevice();
begin
 // (1) Restore display mode, if was set during initialization.
 if (ModeChanged) then
  RestoreDisplayMode();

 // (2) Clear up any OpenGL contexts.
 if (Context <> 0) then
  begin
   wglMakeCurrent(0, 0);
   wglDeleteContext(Context);
  end;

 // (3) Release the palette.
 if (Palette <> 0) then DeleteObject(Palette);

 // (4) Release window's DC.
 ReleaseWindowDC();
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.Flip();
begin
 SwapBuffers(WinDC);
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.Clear(Color: Cardinal);
begin
 glClearColor(((Color shr 16) and $FF) / 255.0, ((Color shr 8) and $FF) / 255.0,
  (Color and $FF) / 255.0, 1.0);

 glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.ResetDevice();
begin
 // no code
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.UpdateParams();
begin
 Finalize();
 Initialize();
end;

//---------------------------------------------------------------------------
function TOGLDevice.MayRender(): Boolean;
begin
 Result:= True;
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.RenderWith(hWnd: THandle; Handler: TNotifyEvent;
 Background: Cardinal);
begin
 Clear(Background);

 EventBeginScene.Notify(Self, nil);
 Handler(Self);
 EventEndScene.Notify(Self, nil);

 Flip();
end;

//---------------------------------------------------------------------------
procedure TOGLDevice.RenderToTarget(Handler: TNotifyEvent;
 Background: Cardinal; FillBk: Boolean);
begin
 if (FillBk) then Clear(Background);

 EventBeginScene.Notify(Self, nil);
 Handler(Self);
 EventEndScene.Notify(Self, nil);
end;

//---------------------------------------------------------------------------
initialization
 InitOpenGL();

//---------------------------------------------------------------------------
end.
