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

unit bsUtils;

{$P+,S-,W-,R-}
{$WARNINGS OFF}
{$HINTS OFF}

interface

{$R-}

uses
  Windows, Controls, Messages, SysUtils, Classes, Graphics, IniFiles;

const
  maxi = 10000;

  // xp office color consts

  BS_XP_BTNFRAMECOLOR = 8388608;
  BS_XP_BTNACTIVECOLOR = 13811126;
  BS_XP_BTNDOWNCOLOR = 11899781;

type
  TCharSet = set of char;


{ TbsFBitmap }

  TFBColor  = record b,g,r:Byte end;
  PFBColor =^TFBColor;
  TBLine = array[0..0]of TFBColor;
  PBLine  =^TBLine;
  TPLines = array[0..0]of PBLine;
  PPLines =^TPLines;

  TbsFBitmap = class
  private
    Bits:   Pointer;
    procedure   Initialize;
  public
    Pixels: PPLines;
    Gap,
    RowInc,
    Size,
    Width,
    Height: Integer;
    Handle,
    hDC:        Integer;
    bmInfo:     TBitmapInfo;
    bmHeader:   TBitmapInfoHeader;
    constructor Create(HBmp:Integer);
    destructor  Destroy; override;
  end;

  TRectArray = array[0..maxi] of TRect;
  

//
function EqRects(R1, R2: TRect): Boolean;
function EqPoints(const Pt1, Pt2: TPoint): Boolean;
function NullRect: TRect;
function IsNullRect(R: TRect): Boolean;
function IsNullPoint(P: TPoint): Boolean;
function RectInRect(R1, R2: TRect): Boolean;
//
function RectWidth(R: TRect): Integer;
function RectHeight(R: TRect): Integer;
function RectToCenter(var R: TRect; Bounds: TRect): TRect;
// Region functions
function CreateRgnFromBmp(B: TBitmap; XO, YO: Integer; var RgnData: PRgnData): integer;
// Stream functions
procedure WriteStringToStream(Str: String; S: TStream);
procedure ReadStringFromStream(var Str: String; S: TStream);
// Skin functions
function GetRect(S: String): TRect;
function GetPoint(S: String): TPoint;
function SetRect(R: TRect): String;

procedure CreateSkinBorderImages(LtPt, RTPt, LBPt, RBPt: TPoint; ClRect: TRect;
  NewLTPt, NewRTPt, NewLBPt, NewRBPt: TPoint; NewClRect: TRect;
  LeftB, TopB, RightB, BottomB, SB: TBitMap; R: TRect; AW, AH: Integer;
  LS, TS, RS, BS: Boolean);


procedure CreateSkinImageBS(LtPt, RTPt, LBPt, RBPt: TPoint; ClRect: TRect;
  NewLTPt, NewRTPt, NewLBPt, NewRBPt: TPoint; NewClRect: TRect;
  B, SB: TBitMap; R: TRect; AW, AH: Integer; DrawClient: Boolean;
  LS, TS, RS, BS: Boolean);

procedure CreateSkinBG(ClRect: TRect; NewClRect: TRect;
   B, SB: TBitMap; R: TRect; AW, AH: Integer);

procedure CreateSkinImage(LtPt, RTPt, LBPt, RBPt: TPoint; ClRect: TRect;
  NewLTPt, NewRTPt, NewLBPt, NewRBPt: TPoint; NewClRect: TRect;
  B, SB: TBitMap; R: TRect; AW, AH: Integer; ADrawClient: Boolean;
  ALeftStretch, ATopStretch, ARightStretch, ABottomStretch,
  AClientStretch: Boolean);

procedure CreateSkinImage2(LtPt, RTPt, LBPt, RBPt: TPoint; ClRect: TRect;
  NewLTPt, NewRTPt, NewLBPt, NewRBPt: TPoint; NewClRect: TRect;
  B, SB: TBitMap; R: TRect; AW, AH: Integer; ADrawClient,
  ALeftStretch, ATopStretch, ARightStretch, ABottomStretch,
  AClientStretch: Boolean);

procedure CreateStretchImage(B: TBitMap;  SB: TBitMap; R: TRect; ClRect: TRect;
                             ADrawClient: Boolean);

procedure CreateHSkinImage(LO, RO: Integer;
  B, SB: TBitMap; R: TRect; AW, AH: Integer; AStretch: Boolean);

procedure CreateHSkinImage2(LO, RO: Integer;
  B, SB: TBitMap; R: TRect; AW, AH: Integer; AStretch: Boolean);

procedure CreateHSkinImage3(LO, RO: Integer;
  B, SB: TBitMap; R: TRect; AW, AH: Integer; AStretch: Boolean);

procedure CreateVSkinImage(TpO, BO: Integer;
  B, SB: TBitMap; R: TRect; AW, AH: Integer; AStretch: Boolean);
  
procedure CreateSkinMask(LtPt, RTPt, LBPt, RBPt: TPoint; ClRect: TRect;
  NewLTPt, NewRTPt, NewLBPt, NewRBPt: TPoint; NewClRect: TRect;
  FMask, RMTop, RMLeft, RMRight, RMBottom: TBitMap; AW, AH: Integer);

procedure CreateSkinSimplyRegion(var FRgn: HRgn; FMask: TBitMap);

procedure CreateSkinRegion(var FRgn: HRgn;
  LtPt, RTPt, LBPt, RBPt: TPoint; ClRect: TRect;
  NewLTPt, NewRTPt, NewLBPt, NewRBPt: TPoint; NewClRect: TRect;
  FMask: TBitMap; AW, AH: Integer);

procedure DrawGlyph(Cnvs: TCanvas; X, Y: Integer; FGlyph: TBitMap;
                    FNumGlyphs, FGlyphNum: Integer);

// IniFile funcitons
function ReadRect(IniFile: TCustomIniFile; Section: String; Ident: String): TRect;
function ReadPoint(IniFile: TCustomIniFile; Section: String; Ident: String): TPoint;
function ReadBoolean(IniFile: TCustomIniFile; Section: String; Ident: String): Boolean;

function ReadFontStyles(IniFile: TCustomIniFile;
                        Section: String; Ident: String): TFontStyles;
procedure ReadStrings(IniFile: TCustomIniFile;
                      Section: String; Ident: String; S: TStrings);
procedure ReadStrings1(IniFile: TCustomIniFile;
                       Section: String; Ident: String; S: TStrings);
function ReadAlignment(IniFile: TCustomIniFile;
                       Section: String; Ident: String): TAlignment;
procedure WriteAlignment(IniFile: TCustomIniFile;
                         Section: String; Ident: String; A: TAlignment);
procedure WriteRect(IniFile: TCustomIniFile; Section: String; Ident: String; R: TRect);
procedure WritePoint(IniFile: TCustomIniFile; Section: String; Ident: String; P: TPoint);
procedure WriteBoolean(IniFile: TCustomIniFile; Section: String; Ident: String; B: Boolean);
procedure WriteFontStyles(IniFile: TCustomIniFile;
                          Section: String; Ident: String; FS: TFontStyles);
procedure WriteStrings(IniFile: TCustomIniFile;
                       Section: String; Ident: String; S: TStrings);
procedure WriteStrings1(IniFile: TCustomIniFile;
                        Section: String; Ident: String; S: TStrings);

procedure GetScreenImage(X, Y: Integer; B: TBitMap);

procedure GetWindowsVersion(var Major, Minor: Integer);

function CheckW2KWXP: Boolean;

function CheckWXP: Boolean;

procedure SetAlphaBlendTransparent(WHandle: HWnd; Value: Byte);

procedure Frm3D(Canvas: TCanvas; Rect: TRect; TopColor, BottomColor: TColor);
procedure DrawRadioImage(Cnvs: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawCheckImage(Cnvs: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawArrowImage(Cnvs: TCanvas; R: TRect; Color: TColor; Code: Integer);
procedure DrawTrackArrowImage(Cnvs: TCanvas; R: TRect; Color: TColor);
function PointInRect(R: TRect; P: TPoint): Boolean;

function CalcTextWidthW(C: TCanvas; Str: WideString): Integer;
function CalcTextHeightW(C: TCanvas; Str: WideString): Integer;
function BSDrawSkinText(ACanvas: TCanvas; AText: WideString; var Bounds: TRect; Flag: cardinal): integer;
procedure BSDrawText(Cnvs: TCanvas; S: String; R: TRect);
procedure BSDrawText2(Cnvs: TCanvas; S: String; R: TRect);
procedure BSDrawText3(Cnvs: TCanvas; S: String; R: TRect; HorOffset: Integer);
procedure BSDrawText4(Cnvs: TCanvas; S: String; R: TRect);

procedure DrawCloseImage(C: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawRCloseImage(C: TCanvas; R: TRect; Color: TColor);
procedure DrawMinimizeImage(C: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawMaximizeImage(C: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawRollUpImage(C: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawRestoreRollUpImage(C: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawRestoreImage(C: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawSysMenuImage(C: TCanvas; X, Y: Integer; Color: TColor);
procedure DrawMTImage(C: TCanvas; X, Y: Integer; Color: TColor);

function ExtractDay(ADate: TDateTime): Word;
function ExtractMonth(ADate: TDateTime): Word;
function ExtractYear(ADate: TDateTime): Word;
function IsLeapYear(AYear: Integer): Boolean;
function DaysPerMonth(AYear, AMonth: Integer): Integer;

function ReplaceStr(const S, Srch, Replace: string): string;
function Max(A, B: Longint): Longint;
function Min(A, B: Longint): Longint;

procedure CorrectTextbyWidth(C: TCanvas; var S: String; W: Integer);
procedure CorrectTextbyWidthW(C: TCanvas; var S: WideString; W: Integer);

procedure GetParentImage(Control: TControl; Dest: TCanvas);
procedure GetParentImageRect(Control: TControl; Rct: TRect; Dest: TCanvas);

function GetMonitorWorkArea(const W: HWND; const WorkArea: Boolean): TRect;
function GetPrimaryMonitorWorkArea(const WorkArea: Boolean): TRect;

function MyGetScrollBarInfo(wnd: Cardinal; idObject: Longint; var psbi: TScrollBarInfo): BOOL;

var
  BS_PlatformIsUnicode: Boolean;
  GetScrollBarInfoFunc: function (wnd: Cardinal; idObject: Longint; var psbi: TScrollBarInfo): BOOL; stdcall;

implementation

uses Forms, Consts, bsSkinTabs;

const
  LWA_ALPHA = $2;

type
  TParentControl = class(TWinControl);


function MyGetScrollBarInfo(wnd: Cardinal; idObject: Longint; var psbi: TScrollBarInfo): BOOL;
begin
  if @GetScrollBarInfoFunc <> nil then
    Result := GetScrollBarInfoFunc(wnd, idObject, psbi)
  else
  begin
    { Win95 }
    psbi.rgstate[0] := STATE_SYSTEM_INVISIBLE;
    Result := false;
  end;
end;



procedure GetParentImage(Control: TControl; Dest: TCanvas);
var
  I, X, Y, SaveIndex: Integer;
  DC: HDC;
  R, CtlR: TRect;
begin
  if (Control = nil) or (Control.Parent = nil) then Exit;
  DC := Dest.Handle;
  with Control.Parent do ControlState := ControlState + [csPaintCopy];
  try
    with Control do
    begin
      X := -Left; Y := -Top;
    end;
    SaveIndex := SaveDC(DC);
    try
      SetViewportOrgEx(DC, X, Y, nil);
      IntersectClipRect(DC, 0, 0, Control.Parent.ClientWidth,
        Control.Parent.ClientHeight);
      with TParentControl(Control.Parent) do
      begin
        if Control.Parent is TbsSkinCustomTabSheet
        then
          begin
            TbsSkinCustomTabSheet(Control.Parent).PaintBG(DC);
          end
        else
        if Control.Parent is TbsSkinTabControl
        then
          begin
            TbsSkinTabControl(Control.Parent).PaintBG(DC);
          end
        else
          begin
            if (Control.Parent is TForm) and
               (TForm(Control.Parent).FormStyle = fsMDIForm)
            then
              begin
                SendMessage(TForm(Control.Parent).ClientHandle, WM_ERASEBKGND, DC, 0);
              end
            else
              begin
                Perform(WM_ERASEBKGND, DC, 0);
                Perform(WM_PAINT, DC, 0);
                if not (Control.Parent is TForm) then PaintWindow(DC);
              end;
          end;
      end;
    finally
      RestoreDC(DC, SaveIndex);
    end;
  finally
    with Control.Parent do ControlState := ControlState - [csPaintCopy];
  end;
end;


procedure GetParentImageRect(Control: TControl; Rct: TRect; Dest: TCanvas);
var
  I, X, Y, SaveIndex: Integer;
  DC: HDC;
  R, CtlR: TRect;
begin
  if (Control = nil) or (Control.Parent = nil) then Exit;
  DC := Dest.Handle;
  with Control.Parent do ControlState := ControlState + [csPaintCopy];
  try
    with Control do
    begin
      X := -Left - Rct.Left; Y := -Top - Rct.Top;
    end;
    SaveIndex := SaveDC(DC);
    try
      SetViewportOrgEx(DC, X, Y, nil);
      IntersectClipRect(DC, 0, 0, Control.Parent.ClientWidth,
        Control.Parent.ClientHeight);
      with TParentControl(Control.Parent) do
      begin
        if Control.Parent is TbsSkinCustomTabSheet
        then
          begin
            TbsSkinCustomTabSheet(Control.Parent).PaintBG(DC);
          end
        else
        if Control.Parent is TbsSkinTabControl
        then
          begin
            TbsSkinTabControl(Control.Parent).PaintBG(DC);
          end
        else
          begin
            if (Control.Parent is TForm) and
               (TForm(Control.Parent).FormStyle = fsMDIForm)
            then
              begin
                SendMessage(TForm(Control.Parent).ClientHandle, WM_ERASEBKGND, DC, 0);
              end
            else
              begin
                Perform(WM_ERASEBKGND, DC, 0);
                Perform(WM_PAINT, DC, 0);
                if not (Control.Parent is TForm) then PaintWindow(DC);
              end;
          end;
      end;
    finally
      RestoreDC(DC, SaveIndex);
    end;
  finally
    with Control.Parent do ControlState := ControlState - [csPaintCopy];
  end;
end;

function CalcTextWidthW(C: TCanvas; Str: WideString): Integer;
var
  R: TRect;
begin
  R := Rect(0, 0, 0, 0);
  BSDrawSkinText(C, Str, R, DT_CALCRECT);
  Result := RectWidth(R);
end;

function CalcTextHeightW(C: TCanvas; Str: WideString): Integer;
var
  R: TRect;
begin
  R := Rect(0, 0, 0, 0);
  BSDrawSkinText(C, Str, R, DT_CALCRECT);
  Result := RectHeight(R);
end;

procedure CorrectTextbyWidthW(C: TCanvas; var S: WideString; W: Integer);

function GetTextWidth(Str: WideString): Integer;
var
  R: TRect;
begin
  R := Rect(0, 0, 0, 0);
  BSDrawSkinText(C, Str, R, DT_CALCRECT);
  Result := RectWidth(R);
end;

var
  j: Integer;
begin
  j := Length(S);
  if GetTextWidth(S) > w
  then
   begin
     repeat
       Delete(S, j, 1);
       Dec(j);
     until (GetTextWidth(S + '...') <= w) or (S = '');
    S := S + '...';
  end;
end;

procedure CorrectTextbyWidth(C: TCanvas; var S: String; W: Integer);
var
  j: Integer;
begin
  j := Length(S);
  with C do
  begin
    if TextWidth(S) > w
    then
      begin
        repeat
          Delete(S, j, 1);
          Dec(j);
        until (TextWidth(S + '...') <= w) or (S = '');
        S := S + '...';
      end;
  end;
end;

function Max(A, B: Longint): Longint;
begin
  if A > B then Result := A
  else Result := B;
end;

function Min(A, B: Longint): Longint;
begin
  if A < B then Result := A
  else Result := B;
end;

function ReplaceStr(const S, Srch, Replace: string): string;
var
  I: Integer;
  Source: string;
begin
  Source := S;
  Result := '';
  repeat
    I := Pos(Srch, Source);
    if I > 0 then begin
      Result := Result + Copy(Source, 1, I - 1) + Replace;
      Source := Copy(Source, I + Length(Srch), MaxInt);
    end
    else Result := Result + Source;
  until I <= 0;
end;

function BSDrawSkinText(ACanvas: TCanvas; AText: WideString; var Bounds: TRect; Flag: cardinal): integer;
var
  AnsiText: string;
begin
  if BS_PlatformIsUnicode
  then
    Result := Windows.DrawTextW(ACanvas.Handle, PWideChar(AText), Length(AText), Bounds, Flag)
  else
  begin
    AnsiText := WideCharToString(PWideChar(AText));
    Result := Windows.DrawText(ACanvas.Handle, PChar(AnsiText), Length(AnsiText), Bounds, Flag);
  end;
end;

procedure BSDrawText4(Cnvs: TCanvas; S: String; R: TRect);
begin
  if S = '' then Exit;
  if S[1] = 'W' then Inc(R.Right, 2);
  DrawText(Cnvs.Handle, PChar(S), Length(S), R,
    DT_VCENTER or DT_SINGLELINE or DT_CENTER);
end;

procedure BSDrawText(Cnvs: TCanvas; S: String; R: TRect);
begin
  if S = '' then Exit;
  DrawText(Cnvs.Handle, PChar(S), Length(S), R,
    DT_VCENTER or DT_SINGLELINE or DT_LEFT);
end;

procedure BSDrawText2(Cnvs: TCanvas; S: String; R: TRect);
var
  TX, TY: Integer;
begin
  if S = '' then Exit;
  TX := R.Left + 2;
  TY := R.Top + RectHeight(R) div 2 - Cnvs.TextHeight(S) div 2;
  Cnvs.TextRect(R, TX, TY, S);
end;

procedure BSDrawText3(Cnvs: TCanvas; S: String; R: TRect; HorOffset: Integer);
var
  TX, TY: Integer;
begin
  if S = '' then Exit;
  TX := R.Left + 2 + HorOffset;
  TY := R.Top + RectHeight(R) div 2 - Cnvs.TextHeight(S) div 2;
  Cnvs.TextRect(R, TX, TY, S);
end;

procedure DrawTrackArrowImage(Cnvs: TCanvas; R: TRect; Color: TColor);
var
  X, Y, i: Integer;
begin
  X := R.Left + RectWidth(R) div 2;
  Y := R.Top + RectHeight(R) div 2 + 2;
  for i := 2 downto 0 do
  with Cnvs do
  begin
    Pen.Color := Color;
    MoveTo(X - i, Y - i);
    LineTo(X + i + 1, Y - i);
  end;
end;

procedure DrawArrowImage(Cnvs: TCanvas; R: TRect; Color: TColor; Code: Integer);
var
  i: Integer;
  X, Y: Integer;
begin
  with Cnvs do
  begin
    Pen.Color := Color;
    case Code of
      1:
        begin
          X := R.Left + RectWidth(R) div 2 - 2;
          Y := R.Top + RectHeight(R) div 2;
          for i := 0 to 3 do
          begin
            MoveTo(X + i, Y - i);
            LineTo(X + i, Y + i + 1);
          end;
        end;
      2:
        begin
          X := R.Left + RectWidth(R) div 2 + 2;
          Y := R.Top + RectHeight(R) div 2;
          for i := 3 downto 0 do
           begin
             MoveTo(X - i, Y + i);
             LineTo(X - i, Y - i - 1);
           end;
        end;
      3:
        begin
          X := R.Left + RectWidth(R) div 2;
          Y := R.Top + RectHeight(R) div 2 - 2;
          for i := 0 to 3 do
          begin
            MoveTo(X - i, Y + i);
            LineTo(X + i + 1, Y + i);
          end;
        end;
      4:
        begin
          X := R.Left + RectWidth(R) div 2;
          Y := R.Top + RectHeight(R) div 2 + 2;
          for i := 3 downto 0 do
          begin
            MoveTo(X - i, Y - i);
            LineTo(X + i + 1, Y - i);
          end;  
        end;
    end;
  end;
end;

procedure DrawRadioImage(Cnvs: TCanvas; X, Y: Integer; Color: TColor);
begin
  with Cnvs do
  begin
    Pen.Color := Color;
    Brush.Color := Color;
    Rectangle(X, Y, X + 6, Y + 6);
  end;
end;

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

procedure Frm3D;
  procedure DoRect;
  var
    TopRight, BottomLeft: TPoint;
  begin
    with Canvas, Rect do
    begin
      TopRight.X := Right;
      TopRight.Y := Top;
      BottomLeft.X := Left;
      BottomLeft.Y := Bottom;
      Pen.Color := TopColor;
      PolyLine([BottomLeft, TopLeft, TopRight]);
      Pen.Color := BottomColor;
      Dec(BottomLeft.X);
      PolyLine([TopRight, BottomRight, BottomLeft]);
    end;
  end;

begin
  Canvas.Pen.Width := 1;
  Dec(Rect.Bottom); Dec(Rect.Right);
  DoRect;
end;

procedure GetWindowsVersion(var Major, Minor: Integer);
var
  Ver : Longint;
begin
  Ver := GetVersion;
  Major := LoByte(LoWord(Ver));
  Minor := HiByte(LoWord(Ver));
end;

function CheckWXP: Boolean;
var
  Major, Minor : Integer;
begin
  GetWindowsVersion(major, minor);
  Result := (major > 5) or ((major = 5) and (minor = 1));
end;

function CheckW2kWXP: Boolean;
var
  Major, Minor : Integer;
begin
  GetWindowsVersion(major, minor);
  Result := (major > 5) or ((major = 5) and ((minor = 0) or (minor = 1) or (minor = 2)));
end;

procedure SetAlphaBlendTransparent;
var
  User32: Cardinal;
  SetLayeredWindowAttributes: function (hwnd: LongInt; crKey: byte; bAlpha: byte; dwFlags: LongInt): LongInt; stdcall;
begin
  User32 := LoadLibrary('USER32');
  if User32 <> 0
  then
    try
     SetLayeredWindowAttributes := GetProcAddress(User32, 'SetLayeredWindowAttributes');
     if @SetLayeredWindowAttributes <> nil
     then
       SetLayeredWindowAttributes(WHandle, 0, Value, LWA_ALPHA);
     finally
        FreeLibrary(User32);
     end;
end;

procedure GetScreenImage(X, Y: Integer; B: TBitMap);
var
  DC: HDC;
begin
  DC := GetDC(0);
  BitBlt(B.Canvas.Handle, 0, 0,
         B.Width, B.Height, DC, X, Y, SrcCopy);
  ReleaseDC(0, DC);
end;

function EqPoints(const Pt1, Pt2: TPoint): Boolean;
begin
  Result := (Pt1.X = Pt2.X) and (Pt1.Y = Pt2.Y);
end;


function EqRects(R1, R2: TRect): Boolean;
begin
  Result := (R1.Left = R2.Left) and (R1.Top = R2.Top) and
            (R1.Right = R2.Right) and (R1.Bottom = R2.Bottom);
end;

function NullRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
end;

function IsNullRect(R: TRect): Boolean;
begin
  Result := (R.Right - R.Left <= 0) or (R.Bottom - R.Top <= 0)
end;

function IsNullPoint(P: TPoint): Boolean;
begin
  Result := (P.X = 0) or (P.Y = 0);
end;

function PointInRect(R: TRect; P: TPoint): Boolean;
begin
  Result := (P.X >= R.Left) and (P.Y >= R.Top) and
            (P.X <= R.Right) and (P.Y <= R.Bottom);
end;

function RectInRect(R1, R2: TRect): Boolean;
begin
  Result := PtInRect(R2, R1.TopLeft) and PtInRect(R2, R1.BottomRight)
end;

function RectToCenter(var R: TRect; Bounds: TRect): TRect;
begin
  OffsetRect(R, -R.Left, -R.Top);
  OffsetRect(R, (RectWidth(Bounds) - RectWidth(R)) div 2, (RectHeight(Bounds) - RectHeight(R)) div 2);
  OffsetRect(R, Bounds.Left, Bounds.Top);
  Result := R;
end;

function RectWidth;
begin
  Result := R.Right - R.Left;
end;

function RectHeight;
begin
  Result := R.Bottom - R.Top;
end;

const
    nums = '1234567890';
    symbols = ', ';

function GetPoint(S: String): TPoint;
var
  i, j: Integer;
  S1: String;
  SA: array[1..2] of String;
begin
  S1 := '';
  j := 1;
  for i := 1 to Length(S) do
  begin
    if S[i] = ','
    then
      begin
        SA[j] := S1;
        S1 := '';
        Inc(j);
      end
    else
      if Pos(S[i], nums) <> 0 then S1 := S1 + S[i];
  end;
  SA[j] := S1;
  Result := Point(StrToInt(SA[1]), StrToInt(SA[2]));;
end;

function GetRect(S: String): TRect;
var
  i, j: Integer;
  S1: String;
  SA: array[1..4] of String;
begin
  S1 := '';
  j := 1;
  for i := 1 to Length(S) do
  begin
    if S[i] = ','
    then
      begin
        SA[j] := S1;
        S1 := '';
        Inc(j);
      end
    else
      if Pos(S[i], nums) <> 0 then S1 := S1 + S[i];
  end;
  SA[j] := S1;
  Result := Rect(StrToInt(SA[1]), StrToInt(SA[2]),
                 StrToInt(SA[3]), StrToInt(SA[4]));
end;

function SetRect(R: TRect): String;
begin
  Result := IntToStr(R.Left) + ',' +
    IntToStr(R.Top) + ',' + IntToStr(R.Right) + ',' +
    IntToStr(R.Bottom);
end;

function ReadRect;
var
  S: String;
begin
  S := IniFile.ReadString(Section, Ident, '0,0,0,0');
  Result := GetRect(S);
end;

function ReadPoint;
var
  S: String;
begin
  S := IniFile.ReadString(Section, Ident, '0,0');
  Result := GetPoint(S);
end;

function ReadBoolean;
var
  I: Integer;
begin
  I := IniFile.ReadInteger(Section, Ident, 0);
  Result := I = 1;
end;

function ReadFontStyles;
var
  FS: TFontStyles;
  S: String;
begin
  S := IniFile.ReadString(Section, Ident, '');
  FS := [];
  if Pos('fsbold', S) <> 0 then FS := FS + [fsBold];
  if Pos('fsitalic', S) <> 0 then FS := FS + [fsItalic];
  if Pos('fsunderline', S) <> 0 then FS := FS + [fsUnderline];
  if Pos('fsstrikeout', S) <> 0 then FS := FS + [fsStrikeOut];
  Result := FS;
end;

procedure ReadStrings;
var
  Count, i: Integer;
begin
  Count := IniFile.ReadInteger(Section, Ident + 'linecount', 0);
  for i := 0 to Count - 1 do
    S.Add(IniFile.ReadString(Section, Ident + 'line' + IntToStr(i), ''));
end;

procedure ReadStrings1;
var
  Count, i: Integer;
begin
  Count := IniFile.ReadInteger(Section, Ident + 'count', 0);
  for i := 0 to Count - 1 do
    S.Add(IniFile.ReadString(Section, IntToStr(i), ''));
end;

procedure WriteRect;
var
  S: String;
begin
  S := IntToStr(R.Left) + ',' + IntToStr(R.Top) + ',' +
       IntToStr(R.Right) + ',' + IntToStr(R.Bottom);
  IniFile.WriteString(Section, Ident, S);
end;

procedure WritePoint;
var
  S: String;
begin
  S := IntToStr(P.X) + ',' + IntToStr(P.Y);
  IniFile.WriteString(Section, Ident, S);
end;

procedure WriteBoolean;
var
  I: Integer;
begin
  if B then I := 1 else I := 0;
  IniFile.WriteInteger(Section, Ident, I);
end;

procedure WriteFontStyles;
var
  S: String;
begin
  S := '';
  if fsBold in FS then S := S + 'fsbold';
  if fsItalic in FS
  then
    begin
      if Length(S) > 0 then S := S + ',';
      S := S + 'fsitalic';
    end;
  if fsUnderline in FS
  then
    begin
      if Length(S) > 0 then S := S + ',';
      S := S + 'fsunderline';
    end;
  if fsStrikeOut in FS
  then
    begin
      if Length(S) > 0 then S := S + ',';
      S := S + 'fsstrikeout';
    end;
  IniFile.WriteString(Section, Ident, S);
end;

procedure WriteStrings;
var
  i: Integer;
begin
  IniFile.WriteInteger(Section, Ident + 'linecount', S.Count);
  for i := 0 to S.Count - 1 do
    IniFile.WriteString(Section, Ident + 'line' + IntToStr(i), S[i]);
end;

procedure WriteStrings1;
var
  i: Integer;
begin
  IniFile.WriteInteger(Section, Ident + 'count', S.Count);
  for i := 0 to S.Count - 1 do
    IniFile.WriteString(Section, IntToStr(i), S[i]);
end;

function ReadAlignment;
var
  S: String;
begin
  S := IniFile.ReadString(Section, Ident, 'tacenter');
  if S = 'tacenter' then Result := taCenter else
  if S = 'taleftjustify' then Result := taLeftJustify else
  Result := taRightJustify;
end;

procedure WriteAlignment;
var
  S: String;
begin
  if A = taCenter then S := 'tacenter' else
  if A = taLeftJustify then S := 'taleftjustify' else
  S := 'tarightjustify';
  IniFile.WriteString(Section, Ident, S);
end;

{ TbsFBitmap }
constructor TbsFBitmap.Create(HBmp:Integer);
var
  Bmp:   Windows.TBITMAP;
  memDC: Integer;
begin
  GetObject(hBmp,SizeOf(Bmp),@Bmp);
  Width:=Bmp.bmWidth;
  Height:=Bmp.bmHeight;
  Size:=((Width*3)+(Width mod 4))*Height;
  with bmHeader do
  begin
    biSize:=SizeOf(bmHeader);
    biWidth:=Width;
    biHeight:=-Height;
    biPlanes:=1;
    biBitCount:=24;
    biCompression:=BI_RGB;
  end;
  bmInfo.bmiHeader:=bmHeader;
  Handle:=CreateDIBSection(0,
                 bmInfo,
                 DIB_RGB_COLORS,
                 Bits, 0, 0);
  memDC:=GetDC(0);
  GetDIBits(memDC,hBmp,0,Height,Bits,bmInfo,DIB_RGB_COLORS);
  ReleaseDC(0,memDC);
  Initialize;
end;

destructor TbsFBitmap.Destroy;
begin
  DeleteDC(hDC);
  DeleteObject(Handle);
  FreeMem(Pixels);
  inherited;
end;

procedure TbsFBitmap.Initialize;
var
  x,i: Integer;
begin
  GetMem(Pixels,Height*SizeOf(PBLine));
  RowInc:=(Width*3)+Width mod 4;
  Gap:=Width mod 4;
  Size:=RowInc*Height;
  x:=Integer(Bits);
  for i:=0 to Height-1 do
  begin
    Pixels[i]:=Pointer(x);
    Inc(x,RowInc);
  end;
  hDC:=CreateCompatibleDC(0);
  SelectObject(hDC,Handle);
end;

// Region convert
function CreateRgnFromBmp(B: TBitmap; XO, YO: Integer; var RgnData: PRgnData): integer;
const
  max = 10000;
var
  j, i, i1: integer;
  C: TFBColor;
  FB: TbsFBitmap;
  Rts: array [0..max] of TRect;
  Count: integer;
begin
  Result := 0;
  If B.Empty Then Exit;
  Count := 0;
  FB := TbsFBitmap.Create(B.Handle);
  for j := 0 to FB.Height - 1 do
  begin
    i := 0;
    while i < FB.Width do
    begin
      C := FB.Pixels[j, i];
      If C.R + C.G + C.B = 0 Then
      begin
        i1 := i;
        C := FB.Pixels[j, i1];
        while C.R + C.G + C.B = 0 do
        begin
          Inc(i1);
          If i1 > FB.Width - 1 Then Break else C := FB.Pixels[j, i1];
        end;
        Rts[Count] := Rect(i + XO, j + YO, i1 + XO, j + 1 + YO);
        Inc(Count);
        i := i1;
        Continue;
      end;
      Inc(i);
    end;
  end;
  FB.Free;
  // Make Region data
  Result := Count*SizeOf(TRect);
  GetMem(Rgndata, SizeOf(TRgnDataHeader)+Result);
  FillChar(Rgndata^, SizeOf(TRgnDataHeader)+Result, 0);
  RgnData^.rdh.dwSize := SizeOf(TRgnDataHeader);
  RgnData^.rdh.iType := RDH_RECTANGLES;
  RgnData^.rdh.nCount := Count;
  RgnData^.rdh.nRgnSize := 0;
  RgnData^.rdh.rcBound := Rect(0 + XO, 0 + YO, B.Width + XO, B.Height + YO);
  // Update New Region
  Move(Rts, RgnData^.Buffer, Result);
  Result := SizeOf(TRgnDataHeader)+Count*SizeOf(TRect);
end;

procedure WriteStringToStream(Str: String; S: TStream);
var
  L: Integer;
begin
  L := Length(Str);
  S.Write(L, SizeOf(Integer));
  S.Write(Pointer(Str)^, L);
end;


procedure ReadStringFromStream(var Str: String; S: TStream);
var
  L: Integer;
begin
  L := 0;
  S.Read(L, SizeOf(Integer));
  SetLength(Str, L);
  S.Read(Pointer(Str)^, L);
end;

procedure CreateStretchImage;
var
  LTPt, RTPt, LBPt, RBPt: TPoint;
  NewLTPt, NewRTPt, NewLBPt, NewRBPt: TPoint;
  NewClRect: TRect;
begin
  LtPt := Point(ClRect.Left, ClRect.Top);
  RtPt := Point(ClRect.Right, ClRect.Top);
  LBPt := Point(ClRect.Left, ClRect.Bottom);
  RBPt := Point(ClRect.Right, ClRect.Bottom);

  NewClRect := ClRect;
  NewClRect.Right := B.Width - (RectWidth(R) - ClRect.Right);
  NewClRect.Bottom := B.Height - (RectHeight(R) - ClRect.Bottom);

  NewLtPt := Point(NewClRect.Left, NewClRect.Top);
  NewRtPt := Point(NewClRect.Right, NewClRect.Top);
  NewLBPt := Point(NewClRect.Left, NewClRect.Bottom);
  NewRBPt := Point(NewClRect.Right, NewClRect.Bottom);

  CreateSkinImage(LtPt, RTPt, LBPt, RBPt, ClRect,
    NewLTPt, NewRTPt, NewLBPt, NewRBPt, NewClRect,
    B, SB, R, B.Width, B.Height, ADrawClient,
    True, True, True, True, True);
end;

procedure CreateHSkinImage;
var
  X, XCnt, w, XO: Integer;
  R1: TRect;
  Buffer: TBitMap;
begin
  B.Width := AW;
  B.Height := RectHeight(R);
  with B.Canvas do
  begin
    if LO <> 0 then
       CopyRect(Rect(0, 0, LO, B.Height), SB.Canvas,
                Rect(R.Left, R.Top, R.Left + LO, R.Bottom));
    if RO <> 0 then
       CopyRect(Rect(B.Width - RO, 0, B.Width, B.Height),
                SB.Canvas,
                Rect(R.Right - RO, R.Top, R.Right, R.Bottom));
    Inc(R.Left, LO);
    Dec(R.Right, RO);
    w := RectWidth(R);
    if w = 0 then w := 1;
    XCnt := (B.Width - LO - RO) div w;
    if AStretch
    then
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R);
        Buffer.Height := RectHeight(R);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
         SB.Canvas, R);
        R1 := Rect(LO, 0, B.Width - RO, B.Height);
        B.Canvas.StretchDraw(R1, Buffer);
        Buffer.Free;
      end
    else
    for X := 0 to XCnt do
    begin
      if LO + X * w + w > B.Width - RO
      then XO := LO + X * w + w - (B.Width - RO)
      else XO := 0;
      B.Canvas.CopyRect(Rect(LO + X * w, 0, LO + X * w + w - XO,
                        B.Height),
                        SB.Canvas,
                        Rect(R.Left, R.Top, R.Right - XO, R.Bottom));
    end;
  end;
end;

procedure CreateHSkinImage2;
var
  X, XCnt, w, XO: Integer;
  R1: TRect;
  Buffer: TBitMap;
begin
  B.Width := AW;
  B.Height := RectHeight(R);
  with B.Canvas do
  begin
    if LO <> 0 then
       CopyRect(Rect(0, 0, LO, B.Height), SB.Canvas,
                Rect(R.Left, R.Top, R.Left + LO, R.Bottom));
    Inc(R.Left, LO);
    Dec(R.Right, RO);
    w := RectWidth(R);
    if w = 0 then w := 1;
    XCnt := (B.Width - LO) div w;
    if AStretch
    then
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R);
        Buffer.Height := RectHeight(R);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
         SB.Canvas, R);
        R1 := Rect(LO, 0, B.Width, B.Height);
        B.Canvas.StretchDraw(R1, Buffer);
        Buffer.Free;
      end
    else
    for X := 0 to XCnt do
    begin
      if LO + X * w + w > B.Width
      then XO := LO + X * w + w - B.Width
      else XO := 0;
      B.Canvas.CopyRect(Rect(LO + X * w, 0, LO + X * w + w - XO,
                        B.Height),
                        SB.Canvas,
                        Rect(R.Left, R.Top, R.Right - XO, R.Bottom));
    end;
  end;
end;

procedure CreateHSkinImage3;
var
  X, XCnt, w, XO: Integer;
  R1: TRect;
  Buffer: TBitMap;
begin
  B.Width := AW;
  B.Height := RectHeight(R);
  with B.Canvas do
  begin
    Inc(R.Left, LO);
    Dec(R.Right, RO);
    w := RectWidth(R);
    if w = 0 then w := 1;
    XCnt := B.Width div w;
    if AStretch
    then
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R);
        Buffer.Height := RectHeight(R);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
          SB.Canvas, R);
        R1 := Rect(0, 0, B.Width, B.Height);
        B.Canvas.StretchDraw(R1, Buffer);
        Buffer.Free;
      end
    else
    for X := 0 to XCnt do
    begin
      if LO + X * w + w > B.Width
      then XO := LO + X * w + w - B.Width
      else XO := 0;
      B.Canvas.CopyRect(Rect(X * w, 0, X * w + w - XO,
                        B.Height),
                        SB.Canvas,
                        Rect(R.Left, R.Top, R.Right - XO, R.Bottom));
    end;
  end;
end;


procedure CreateVSkinImage;
var
  Y, YCnt, h, YO: Integer;
  R1: TRect;
  Buffer: TBitMap;
begin
  B.Width := RectWidth(R);
  B.Height := AH;
  with B.Canvas do
  begin
    if TpO <> 0 then
       CopyRect(Rect(0, 0, B.Width, TpO), SB.Canvas,
                Rect(R.Left, R.Top, R.Right, R.Top + TpO));
    if BO <> 0 then
       CopyRect(Rect(0, B.Height - BO, B.Width, B.Height),
                SB.Canvas,
                Rect(R.Left, R.Bottom - BO, R.Right, R.Bottom));
    Inc(R.Top, TpO);
    Dec(R.Bottom, BO);
    h := RectHeight(R);
    if H <> 0
    then
      YCnt := (B.Height - TpO - BO) div h
    else
      YCnt := 0;
    if AStretch
    then
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R);
        Buffer.Height := RectHeight(R);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
         SB.Canvas, R);
        R1 := Rect(0, TpO, B.Width, B.Height - BO);
        B.Canvas.StretchDraw(R1, Buffer);
        Buffer.Free;
      end
    else
    for Y := 0 to YCnt do
    begin
      if TpO + Y * h + h > B.Height - BO
      then YO := TpO + Y * h + h - (B.Height - BO)
      else YO := 0;
      B.Canvas.CopyRect(
        Rect(0, TpO + Y * h, B.Width, TpO + Y * h + h - YO),
        SB.Canvas,
        Rect(R.Left, R.Top, R.Right, R.Bottom - YO));
    end;
  end;
end;

procedure CreateSkinImageBS;
var
  w, h, rw, rh: Integer;
  X, Y, XCnt, YCnt: Integer;
  XO, YO: Integer;
  Rct, SRct: TRect;
  Buffer: TBitMap;
begin
  B.Width := AW;
  B.Height := AH;
  if (RBPt.X - LTPt.X  = 0) or
     (RBPt.Y - LTPt.Y = 0) or SB.Empty then  Exit;
  with B.Canvas do
  begin
    // Draw lines
    // top
    if not TS
    then
      begin
        w := RTPt.X - LTPt.X;
        XCnt := (NewRTPt.X - NewLTPt.X) div (RTPt.X - LTPt.X);
        for X := 0 to XCnt do
        begin
          if NewLTPt.X + X * w + w > NewRTPt.X
          then XO := NewLTPt.X + X * w + w - NewRTPt.X else XO := 0;
          CopyRect(Rect(NewLTPt.X + X * w, 0, NewLTPt.X + X * w + w - XO, NewClRect.Top),
               SB.Canvas, Rect(R.Left + LTPt.X, R.Top,
                 R.Left + RTPt.X - XO, R.Top + ClRect.Top));
        end;
      end
    else
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RTPt.X - LTPt.X;
        Buffer.Height := CLRect.Top;
        Rct := Rect(R.Left + LTPt.X, R.Top, R.Left + RTPt.X, R.Top + CLRect.Top);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
          SB.Canvas, Rct);
        SRct := Rect(NewLTPt.X, 0, NewRTPt.X, NewCLRect.Top);
        StretchDraw(SRct, Buffer);
        Buffer.Free;
      end;
    // bottom
    if not BS
    then
      begin
        w := RBPt.X - LBPt.X;
        XCnt := (NewRBPt.X - NewLBPt.X) div (RBPt.X - LBPt.X);
        for X := 0 to XCnt do
        begin
         if NewLBPt.X + X * w + w > NewRBPt.X
         then XO := NewLBPt.X + X * w + w - NewRBPt.X else XO := 0;
           CopyRect(Rect(NewLBPt.X + X * w, NewClRect.Bottom, NewLBPt.X + X * w + w - XO, AH),
                    SB.Canvas, Rect(R.Left + LBPt.X, R.Top + ClRect.Bottom,
                     R.Left + RBPt.X - XO, R.Bottom));
        end;             
      end
    else
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RBPt.X - LBPt.X;
        Buffer.Height := RectHeight(R) - CLRect.Bottom;
        Rct := Rect(R.Left + LBPt.X, R.Top + ClRect.Bottom,
                    R.Left + RBPt.X, R.Bottom);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
          SB.Canvas, Rct);
        SRct := Rect(NewLBPt.X, NewCLRect.Bottom, NewRBPt.X, B.Height);
        StretchDraw(SRct, Buffer);
        Buffer.Free;
      end;
    // left
    w := NewClRect.Left;
    h := LBPt.Y - LTPt.Y;
    if not LS
    then
      begin
        YCnt := (NewLBPt.Y - NewLTPt.Y) div h;
        for Y := 0 to YCnt do
        begin
          if NewLTPt.Y + Y * h + h > NewLBPt.Y
          then YO := NewLTPt.Y + Y * h + h - NewLBPt.Y else YO := 0;
          CopyRect(Rect(0, NewLTPt.Y + Y * h, w, NewLTPt.Y + Y * h + h - YO),
                   SB.Canvas,
                   Rect(R.Left, R.Top + LTPt.Y, R.Left + w, R.Top + LBPt.Y - YO));
        end;
      end
    else
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := ClRect.Left;
        Buffer.Height := LBPt.Y - LTPt.Y;
        Rct := Rect(R.Left, R.Top + LTPt.Y,
                    R.Left + CLRect.Left, R.Top + LBPt.Y);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
          SB.Canvas, Rct);
        SRct := Rect(0, NewLTPt.Y, NewCLRect.Left, NewLBPt.Y);
        StretchDraw(SRct, Buffer);
        Buffer.Free;
      end;
    // right
    h := RBPt.Y - RTPt.Y;
    if not RS
    then
      begin
        YCnt := (NewRBPt.Y - NewRTPt.Y) div h;
        for Y := 0 to YCnt do
        begin
          if NewRTPt.Y + Y * h + h > NewRBPt.Y
          then YO := NewRTPt.Y + Y * h + h - NewRBPt.Y else YO := 0;
          CopyRect(Rect(NewClRect.Right, NewRTPt.Y + Y * h,
                    AW, NewRTPt.Y + Y * h + h - YO),
                   SB.Canvas,
                   Rect(R.Left + ClRect.Right, R.Top + RTPt.Y,
                   R.Right, R.Top + RBPt.Y - YO));
        end;
      end
    else
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R) - ClRect.Right;
        Buffer.Height := RBPt.Y - RTPt.Y;
        Rct := Rect(R.Left + ClRect.Right, R.Top + RTPt.Y,
                    R.Right, R.Top + RBPt.Y);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
          SB.Canvas, Rct);
        SRct := Rect(NewClRect.Right, NewRTPt.Y, B.Width, NewRBPt.Y);
        StretchDraw(SRct, Buffer);
        Buffer.Free;
      end;

    // Draw corners
    // lefttop

    CopyRect(Rect(0, 0, NewLTPt.X, NewClRect.Top),
             SB.Canvas, Rect(R.Left, R.Top,
                             R.Left + LTPt.X, R.Top + ClRect.Top));

    CopyRect(Rect(0, NewClRect.Top, NewClRect.Left, NewLTPt.Y),
             SB.Canvas, Rect(R.Left, R.Top + ClRect.Top,
                             R.Left + ClRect.left, R.Top + LTPT.Y));

    //topright

    CopyRect(Rect(NewRTPt.X, 0, AW, NewClRect.Top), SB.Canvas,
             Rect(R.Left + RTPt.X, R.Top,  R.Right, R.Top + ClRect.Top));
    CopyRect(Rect(NewClRect.Right, NewClRect.Top, AW, NewRTPt.Y), SB.Canvas,
             Rect(R.Left + ClRect.Right, R.Top + ClRect.Top,
             R.Right, R.Top + RTPt.Y));

    //leftbottom

    CopyRect(Rect(0, NewLBPt.Y, NewClRect.Left, AH), SB.Canvas,
             Rect(R.Left, R.Top + LBPt.Y, R.Left + ClRect.Left, R.Bottom));

    CopyRect(Rect(NewClRect.Left, NewClRect.Bottom, NewLBPt.X, AH), SB.Canvas,
             Rect(R.Left + ClRect.Left, R.Top + ClRect.Bottom, R.Left + LBPt.X, R.Bottom));


    //rightbottom

    CopyRect(Rect(NewRBPt.X, NewClRect.Bottom, AW, AH), SB.Canvas,
             Rect(R.Left + RBPt.X, R.Top + ClRect.Bottom, R.Right, R.Bottom));

    CopyRect(Rect(NewClRect.Right, NewRBPt.Y, AW, NewClRect.Bottom), SB.Canvas,
             Rect(R.Left + ClRect.Right, R.Top + RBPt.Y,
                  R.Right, R.Top + ClRect.Bottom));

    //Draw client
    w := RectWidth(ClRect);
    h := RectHeight(ClRect);
    rw := RectWidth(NewClRect);
    rh := RectHeight(NewClRect);
    if DrawClient
    then
      begin
        // Draw client area
        XCnt := rw div w;
        YCnt := rh div h;
        for X := 0 to XCnt do
        for Y := 0 to YCnt do
        begin
          if X * w + w > rw then XO := X * W + W - rw else XO := 0;
          if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
          CopyRect(Rect(NewClRect.Left + X * w, NewClRect.Top + Y * h,
             NewClRect.Left + X * w + w - XO,
             NewClRect.Top + Y * h + h - YO),
             SB.Canvas,
             Rect(R.Left + ClRect.Left, R.Top + ClRect.Top,
             R.Left + ClRect.Right - XO,
             R.Top + ClRect.Bottom - YO));
         end;
    end;
  end;
end;

procedure CreateSkinBG;
var
  w, h, rw, rh: Integer;
  X, Y, XCnt, YCnt: Integer;
  XO, YO: Integer;
begin
  B.Width := AW;
  B.Height := AH;
  if RectWidth(NewClRect) = 0 then Exit;
  if RectHeight(NewClRect) = 0 then Exit;
  with B.Canvas do
  begin
    w := RectWidth(ClRect);
    h := RectHeight(ClRect);
    rw := RectWidth(NewClRect);
    rh := RectHeight(NewClRect);
    XCnt := rw div w;
    YCnt := rh div h;
    for X := 0 to XCnt do
    for Y := 0 to YCnt do
    begin
      if X * w + w > rw then XO := X * W + W - rw else XO := 0;
      if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
       CopyRect(Rect(X * w, Y * h, X * w + w - XO, Y * h + h - YO),
         SB.Canvas,
         Rect(R.Left + ClRect.Left, R.Top + ClRect.Top,
         R.Left + ClRect.Right - XO,
         R.Top + ClRect.Bottom - YO));
    end;
  end;
end;

procedure CreateSkinImage;
var
  w, h, rw, rh: Integer;
  X, Y, XCnt, YCnt: Integer;
  XO, YO: Integer;
  R1, R2, R3: TRect;
  Buffer: TBitMap;
begin
  B.Width := AW;
  B.Height := AH;
  if (RBPt.X - LTPt.X  = 0) or
     (RBPt.Y - LTPt.Y = 0) or SB.Empty then  Exit;
  with B.Canvas do
  begin
    // Draw lines
    // top
    if not ATopStretch
    then
      begin
        w := RTPt.X - LTPt.X;
        XCnt := (NewRTPt.X - NewLTPt.X) div (RTPt.X - LTPt.X);
        for X := 0 to XCnt do
        begin
          if NewLTPt.X + X * w + w > NewRTPt.X
          then XO := NewLTPt.X + X * w + w - NewRTPt.X else XO := 0;
           CopyRect(Rect(NewLTPt.X + X * w, 0, NewLTPt.X + X * w + w - XO, NewClRect.Top),
                    SB.Canvas, Rect(R.Left + LTPt.X, R.Top,
                    R.Left + RTPt.X - XO, R.Top + ClRect.Top));
        end;
    end
    else
    begin
      R1 := Rect(NewLTPt.X, 0, NewRTPt.X, NewClRect.Top);
      R2 := Rect(R.Left + LTPt.X, R.Top, R.Left + RTPt.X, R.Top + ClRect.Top);
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R2);
      Buffer.Height := RectHeight(R2);
      R3 := Rect(0, 0, Buffer.Width, Buffer.Height);
      Buffer.Canvas.CopyRect(R3, SB.Canvas, R2);
      StretchDraw(R1, Buffer);
      Buffer.Free;
    end;
    // bottom
    if not ABottomStretch
    then
      begin
        w := RBPt.X - LBPt.X;
        XCnt := (NewRBPt.X - NewLBPt.X) div (RBPt.X - LBPt.X);
        for X := 0 to XCnt do
        begin
          if NewLBPt.X + X * w + w > NewRBPt.X
          then XO := NewLBPt.X + X * w + w - NewRBPt.X else XO := 0;
            CopyRect(Rect(NewLBPt.X + X * w, NewClRect.Bottom, NewLBPt.X + X * w + w - XO, AH),
                 SB.Canvas, Rect(R.Left + LBPt.X, R.Top + ClRect.Bottom,
                 R.Left + RBPt.X - XO, R.Bottom));
        end;
      end
    else
      begin
        R1 := Rect(NewLBPt.X, NewClRect.Bottom, NewRBPt.X, AH);
        R2 := Rect(R.Left + LBPt.X, R.Top + ClRect.Bottom, R.Left + RBPt.X, R.Bottom);
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R2);
        Buffer.Height := RectHeight(R2);
        R3 := Rect(0, 0, Buffer.Width, Buffer.Height);
        Buffer.Canvas.CopyRect(R3, SB.Canvas, R2);
        StretchDraw(R1, Buffer);
        Buffer.Free;
      end;
    // left
    if not ALeftStretch
    then
      begin
        w := NewClRect.Left;
        h := LBPt.Y - LTPt.Y;
        YCnt := (NewLBPt.Y - NewLTPt.Y) div h;
        for Y := 0 to YCnt do
        begin
          if NewLTPt.Y + Y * h + h > NewLBPt.Y
          then YO := NewLTPt.Y + Y * h + h - NewLBPt.Y else YO := 0;
            CopyRect(Rect(0, NewLTPt.Y + Y * h, w, NewLTPt.Y + Y * h + h - YO),
              SB.Canvas,
              Rect(R.Left, R.Top + LTPt.Y, R.Left + w, R.Top + LBPt.Y - YO));
        end
      end
    else
      begin
        R1 := Rect(0, NewLTPt.Y, NewClRect.Left, NewLBPt.Y);
        R2 := Rect(R.Left, R.Top + LtPt.Y, R.Left + ClRect.Left, R.Top + LBPt.Y);
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R2);
        Buffer.Height := RectHeight(R2);
        R3 := Rect(0, 0, Buffer.Width, Buffer.Height);
        Buffer.Canvas.CopyRect(R3, SB.Canvas, R2);
        StretchDraw(R1, Buffer);
        Buffer.Free;
      end;
    // right
    if not ARightStretch
    then
      begin
        h := RBPt.Y - RTPt.Y;
        YCnt := (NewRBPt.Y - NewRTPt.Y) div h;
        for Y := 0 to YCnt do
        begin
         if NewRTPt.Y + Y * h + h > NewRBPt.Y
         then YO := NewRTPt.Y + Y * h + h - NewRBPt.Y else YO := 0;
          CopyRect(Rect(NewClRect.Right, NewRTPt.Y + Y * h,
                   AW, NewRTPt.Y + Y * h + h - YO),
               SB.Canvas,
               Rect(R.Left + ClRect.Right, R.Top + RTPt.Y,
                 R.Right, R.Top + RBPt.Y - YO));
       end
    end
    else
      begin
        R1 := Rect(NewClRect.Right, NewRTPt.Y, AW, NewRBPt.Y);
        R2 := Rect(R.Left + ClRect.Right, R.Top + RtPt.Y, R.Right, R.Top + RBPt.Y);
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R2);
        Buffer.Height := RectHeight(R2);
        R3 := Rect(0, 0, Buffer.Width, Buffer.Height);
        Buffer.Canvas.CopyRect(R3, SB.Canvas, R2);
        StretchDraw(R1, Buffer);
        Buffer.Free;
      end;

    // Draw corners
    // lefttop

    CopyRect(Rect(0, 0, NewLTPt.X, NewClRect.Top),
             SB.Canvas, Rect(R.Left, R.Top,
                             R.Left + LTPt.X, R.Top + ClRect.Top));

    CopyRect(Rect(0, NewClRect.Top, NewClRect.Left, NewLTPt.Y),
             SB.Canvas, Rect(R.Left, R.Top + ClRect.Top,
                             R.Left + ClRect.left, R.Top + LTPT.Y));

    //topright

    CopyRect(Rect(NewRTPt.X, 0, AW, NewClRect.Top), SB.Canvas,
             Rect(R.Left + RTPt.X, R.Top,  R.Right, R.Top + ClRect.Top));
    CopyRect(Rect(NewClRect.Right, NewClRect.Top, AW, NewRTPt.Y), SB.Canvas,
             Rect(R.Left + ClRect.Right, R.Top + ClRect.Top,
             R.Right, R.Top + RTPt.Y));

    //leftbottom

    CopyRect(Rect(0, NewLBPt.Y, NewClRect.Left, AH), SB.Canvas,
             Rect(R.Left, R.Top + LBPt.Y, R.Left + ClRect.Left, R.Bottom));

    CopyRect(Rect(NewClRect.Left, NewClRect.Bottom, NewLBPt.X, AH), SB.Canvas,
             Rect(R.Left + ClRect.Left, R.Top + ClRect.Bottom, R.Left + LBPt.X, R.Bottom));


    //rightbottom

    CopyRect(Rect(NewRBPt.X, NewClRect.Bottom, AW, AH), SB.Canvas,
             Rect(R.Left + RBPt.X, R.Top + ClRect.Bottom, R.Right, R.Bottom));

    CopyRect(Rect(NewClRect.Right, NewRBPt.Y, AW, NewClRect.Bottom), SB.Canvas,
             Rect(R.Left + ClRect.Right, R.Top + RBPt.Y,
                  R.Right, R.Top + ClRect.Bottom));

    //Draw client
    if ADrawClient
    then
    if AClientStretch
    then
      begin
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(ClRect);
        Buffer.Height := RectHeight(ClRect);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
        SB.Canvas, Rect(R.Left + ClRect.Left, R.Top + ClRect.Top,
          R.Left + ClRect.Right, R.Top + ClRect.Bottom));
        StretchDraw(NewClRect, Buffer);
        Buffer.Free;
      end
    else
      begin
        w := RectWidth(ClRect);
        h := RectHeight(ClRect);
        rw := RectWidth(NewClRect);
        rh := RectHeight(NewClRect);
        // Draw client area
        XCnt := rw div w;
        YCnt := rh div h;
        for X := 0 to XCnt do
        for Y := 0 to YCnt do
        begin
          if X * w + w > rw then XO := X * W + W - rw else XO := 0;
          if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
          CopyRect(Rect(NewClRect.Left + X * w, NewClRect.Top + Y * h,
          NewClRect.Left + X * w + w - XO,
          NewClRect.Top + Y * h + h - YO),
          SB.Canvas,
          Rect(R.Left + ClRect.Left, R.Top + ClRect.Top,
          R.Left + ClRect.Right - XO,
          R.Top + ClRect.Bottom - YO));
        end;
      end;
  end;
end;

procedure CreateSkinImage2;
var
  w, h, rw, rh: Integer;
  X, Y, XCnt, YCnt: Integer;
  XO, YO: Integer;
  NCLRect: TRect;
  R1, R2, R3: TRect;
  Buffer: TBitMap;
begin
  B.Width := AW;
  B.Height := AH;
  if (RBPt.X - LTPt.X  = 0) or
     (RBPt.Y - LTPt.Y = 0) or SB.Empty then  Exit;
  with B.Canvas do
  begin
    // Draw lines
    // top
    if not ATopStretch
    then
      begin
        w := RBPt.X - LTPt.X;
        XCnt := (AW - NewLTPt.X) div (RBPt.X - LTPt.X);
        for X := 0 to XCnt do
        begin
          if NewLTPt.X + X * w + w > AW
          then XO := NewLTPt.X + X * w + w - AW else XO := 0;
          CopyRect(Rect(NewLTPt.X + X * w, 0, NewLTPt.X + X * w + w - XO, NewClRect.Top),
               SB.Canvas, Rect(R.Left + LTPt.X, R.Top,
                 R.Left + RTPt.X - XO, R.Top + ClRect.Top));
        end;
    end
    else
      begin
        R1 := Rect(NewLTPt.X, 0, AW, NewClRect.Top);
        R2 := Rect(R.Left + LTPt.X, R.Top, R.Left + RTPt.X, R.Top + ClRect.Top);
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R2);
        Buffer.Height := RectHeight(R2);
        R3 := Rect(0, 0, Buffer.Width, Buffer.Height);
        Buffer.Canvas.CopyRect(R3, SB.Canvas, R2);
        StretchDraw(R1, Buffer);
        Buffer.Free;
      end;
    // bottom
    if not ABottomStretch
    then
      begin
        w := RBPt.X - LBPt.X;
        XCnt := (AW - NewLBPt.X) div (RBPt.X - LBPt.X);
        for X := 0 to XCnt do
        begin
          if NewLBPt.X + X * w + w > AW
          then XO := NewLBPt.X + X * w + w - AW else XO := 0;
          CopyRect(Rect(NewLBPt.X + X * w, NewClRect.Bottom, NewLBPt.X + X * w + w - XO, AH),
                   SB.Canvas, Rect(R.Left + LBPt.X, R.Top + ClRect.Bottom,
                   R.Left + RBPt.X - XO, R.Bottom));
        end
    end
    else
      begin
        R1 := Rect(NewLBPt.X, NewClRect.Bottom, AW, AH);
        R2 := Rect(R.Left + LBPt.X, R.Top + ClRect.Bottom, R.Left + RBPt.X, R.Bottom);
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R2);
        Buffer.Height := RectHeight(R2);
        R3 := Rect(0, 0, Buffer.Width, Buffer.Height);
        Buffer.Canvas.CopyRect(R3, SB.Canvas, R2);
        StretchDraw(R1, Buffer);
        Buffer.Free;
      end;
    // left
    if not ALeftStretch
    then
      begin
        w := NewClRect.Left;
        h := LBPt.Y - LTPt.Y;
        YCnt := (NewLBPt.Y - NewLTPt.Y) div h;
        for Y := 0 to YCnt do
        begin
          if NewLTPt.Y + Y * h + h > NewLBPt.Y
          then YO := NewLTPt.Y + Y * h + h - NewLBPt.Y else YO := 0;
          CopyRect(Rect(0, NewLTPt.Y + Y * h, w, NewLTPt.Y + Y * h + h - YO),
               SB.Canvas,
               Rect(R.Left, R.Top + LTPt.Y, R.Left + w, R.Top + LBPt.Y - YO));
        end;
    end
    else
      begin
        R1 := Rect(0, NewLTPt.Y, NewClRect.Left, NewLBPt.Y);
        R2 := Rect(R.Left, R.Top + LtPt.Y, R.Left + ClRect.Left, R.Top + LBPt.Y);
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(R2);
        Buffer.Height := RectHeight(R2);
        R3 := Rect(0, 0, Buffer.Width, Buffer.Height);
        Buffer.Canvas.CopyRect(R3, SB.Canvas, R2);
        StretchDraw(R1, Buffer);
        Buffer.Free;
      end;

    // lefttop

    CopyRect(Rect(0, 0, NewLTPt.X, NewClRect.Top),
             SB.Canvas, Rect(R.Left, R.Top,
                             R.Left + LTPt.X, R.Top + ClRect.Top));

    CopyRect(Rect(0, NewClRect.Top, NewClRect.Left, NewLTPt.Y),
             SB.Canvas, Rect(R.Left, R.Top + ClRect.Top,
                             R.Left + ClRect.left, R.Top + LTPT.Y));

    //leftbottom

    CopyRect(Rect(0, NewLBPt.Y, NewClRect.Left, AH), SB.Canvas,
             Rect(R.Left, R.Top + LBPt.Y, R.Left + ClRect.Left, R.Bottom));

    CopyRect(Rect(NewClRect.Left, NewClRect.Bottom, NewLBPt.X, AH), SB.Canvas,
             Rect(R.Left + ClRect.Left, R.Top + ClRect.Bottom, R.Left + LBPt.X, R.Bottom));

    //Draw client
     if ADrawClient
    then
    if  AClientStretch
    then
      begin
        NCLRect := NewClRect;
        NCLRect.Right := AW;
        Buffer := TBitMap.Create;
        Buffer.Width := RectWidth(ClRect);
        Buffer.Height := RectHeight(ClRect);
        Buffer.Canvas.CopyRect(Rect(0, 0, Buffer.Width, Buffer.Height),
        SB.Canvas, Rect(R.Left + ClRect.Left, R.Top + ClRect.Top,
          R.Left + ClRect.Right, R.Top + ClRect.Bottom));
        StretchDraw(NClRect, Buffer);
        Buffer.Free;
      end
    else
      begin
        NCLRect := NewClRect;
        NCLRect.Right := AW;
        w := RectWidth(ClRect);
        h := RectHeight(ClRect);
        rw := RectWidth(NCLRect);
        rh := RectHeight(NCLRect);
        // Draw client area
        XCnt := rw div w;
        YCnt := rh div h;
        for X := 0 to XCnt do
        for Y := 0 to YCnt do
        begin
          if X * w + w > rw then XO := X * W + W - rw else XO := 0;
          if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
          CopyRect(Rect(NCLRect.Left + X * w, NCLRect.Top + Y * h,
             NCLRect.Left + X * w + w - XO,
             NCLRect.Top + Y * h + h - YO),
             SB.Canvas,
             Rect(R.Left + ClRect.Left, R.Top + ClRect.Top,
             R.Left + ClRect.Right - XO,
             R.Top + ClRect.Bottom - YO));
         end;
      end;
  end;
end;

procedure CreateSkinMask;
var
  i, j, k: Integer;
  LWidth, TWidth, RWidth, BWidth: Integer;
  Ofs: Integer;
  W, H: Integer;
begin
  LWidth := ClRect.Left;
  TWidth := ClRect.Top;
  RWidth := FMask.Width - ClRect.Right;
  BWidth := FMask.Height - ClRect.Bottom;
  //left
  W := LWidth;
  H := RectHeight(NewClRect);
  if (W > 0) and (H > 0) then
  begin
  RMLeft.Width := W;
  RMLeft.Height := H;
  j := LBPt.Y - LTPt.Y;
  with RMLeft.Canvas do
  begin
    if j <> 0
    then
    for i := 0 to RMLeft.Height div j do
    begin
      if i * j + j > RMLeft.Height
      then Ofs := i * j + j - RMLeft.Height else Ofs := 0;
      CopyRect(Rect(0, i * j, LWidth, i * j + j - Ofs),
               FMask.Canvas,
               Rect(0, LTPt.Y, LWidth, LBPt.Y - Ofs));
    end;

    k := LTPt.Y - ClRect.Top;
    if k > 0 then
      CopyRect(Rect(0, 0, LWidth, k),
               FMask.Canvas,
               Rect(0, ClRect.Top, LWidth, LTPt.Y));

    k := ClRect.Bottom - LBPt.Y;
    if k > 0 then
      CopyRect(Rect(0, RMLeft.Height - k, LWidth, RMLeft.Height),
               FMask.Canvas,
               Rect(0, LBPt.Y, LWidth, ClRect.Bottom));
  end;
  end;
  //right
  W := RWidth;
  H := RectHeight(NewClRect);
  if (W > 0) and (H > 0) then
  begin
  RMRight.Width  := W;
  RMRight.Height := H;
  j := RBPt.Y - RTPt.Y;

  with RMRight.Canvas do
  begin
    if j <> 0 then 
    for i := 0 to RMRight.Height div j do
    begin
      if i * j + j > RMRight.Height
      then Ofs := i * j + j - RMRight.Height else Ofs := 0;
      CopyRect(Rect(0, i * j, RWidth, i * j + j - Ofs),
               FMask.Canvas,
               Rect(ClRect.Right, RTPt.Y, FMask.Width, RBPt.Y - Ofs));
    end;           

    k := RTPt.Y - ClRect.Top;
    if k > 0 then
      CopyRect(Rect(0, 0, RWidth, k),
               FMask.Canvas,
               Rect(FMask.Width - RWidth, ClRect.Top, FMask.Width, RTPt.Y));

    k := ClRect.Bottom - RBPt.Y;
    if k > 0 then
      CopyRect(Rect(0, RMRight.Height - k, RWidth, RMRight.Height),
               FMask.Canvas,
               Rect(FMask.Width - RWidth, RBPt.Y, FMask.Width, CLRect.Bottom));
  end;
  end;
  // top
  H := TWidth;
  W := AW;
  if (W > 0) and (H > 0) then
  begin
  j := RTPt.X - LTPt.X;
  RMTop.Height := H;
  RMTop.Width := W;

  with RMTop.Canvas do
  begin
    if j <> 0 then
    for i := 0 to RMTop.Width div j do
    begin
      if NewLTPt.X + i * j + j > NewRTPt.X
      then Ofs := NewLTPt.X + i * j + j - NewRTPt.X else Ofs := 0;
      CopyRect(Rect(NewLTPt.X + i * j, 0, NewLTPt.X + i * j + j - Ofs, TWidth),
               FMask.Canvas,
               Rect(LTPt.X, 0, RTPt.X - Ofs, TWidth));
    end;
    CopyRect(Rect(0, 0, LTPt.X, TWidth), FMask.Canvas,
             Rect(0, 0, LTPt.X, TWidth));
    CopyRect(Rect(NewRTPt.X, 0, RMTop.Width, TWidth), FMask.Canvas,
             Rect(RTPt.X, 0, FMask.Width, TWidth));
  end;
  end;
  // bottom
  W := AW;
  H := BWidth;
  if (W > 0) and (H > 0) then
  begin
  j := RBPt.X - LBPt.X;
  RMBottom.Height := H;
  RMBottom.Width := W;

  with RMBottom.Canvas do
  begin
    if j <> 0 then
    for i := 0 to RMBottom.Width div j do
    begin
      if NewLBPt.X + i * j + j > NewRBPt.X
      then Ofs := NewLBPt.X + i * j + j - NewRBPt.X else Ofs := 0;
      CopyRect(Rect(NewLBPt.X + i * j, 0, NewLBPt.X + i * j + j - Ofs, BWidth),
               FMask.Canvas,
               Rect(LBPt.X, ClRect.Bottom, RBPt.X - Ofs, FMask.Height));
    end;
    CopyRect(Rect(0, 0, LBPt.X, BWidth), FMask.Canvas,
             Rect(0, ClRect.Bottom, LBPt.X, FMask.Height));
    CopyRect(Rect(NewRBPt.X, 0, RMBottom.Width, BWidth), FMask.Canvas,
             Rect(RBPt.X, ClRect.Bottom, FMask.Width, FMask.Height));
  end;
  end;
end;

procedure CreateSkinSimplyRegion(var FRgn: HRgn; FMask: TBitMap);
var
  Size: Integer;
  RgnData: PRgnData;
begin
  Size := CreateRgnFromBmp(FMask, 0, 0, RgnData);
  FRgn := ExtCreateRegion(nil, Size, RgnData^);
  FreeMem(RgnData, Size);
end;

procedure CreateSkinRegion;
var
  RMTop, RMBottom, RMLeft, RMRight: TBitMap;
  Size: Integer;
  RgnData: PRgnData;
  R1, R2, R3, R4: HRGN;
begin
  if (NewLtPt.X > NewRTPt.X) or (NewLtPt.Y > NewLBPt.Y)
  then
    begin
      FRgn := 0;
      Exit;
    end;
  RMTop := TBitMap.Create;
  RMBottom := TBitMap.Create;
  RMLeft := TBitMap.Create;
  RMRight := TBitMap.Create;
  //
  CreateSkinMask(LTPt, RTPt, LBPt, RBPt, ClRect,
               NewLtPt, NewRTPt, NewLBPt, NewRBPt, NewClRect,
               FMask, RMTop, RMLeft, RMRight, RMBottom,
               AW, AH);
  //
  if (RMTop.Width > 0) and (RMTop.Height > 0) 
  then
    begin
      Size := CreateRgnFromBmp(RMTop, 0, 0, RgnData);
      R1 := ExtCreateRegion(nil, Size, RgnData^);
      FreeMem(RgnData, Size);
    end
  else
    R1 := 0;

  if (RMBottom.Width > 0) and (RMBottom.Height > 0)
  then
    begin
      Size := CreateRgnFromBmp(RMBottom, 0, NewClRect.Bottom, RgnData);
      R2 := ExtCreateRegion(nil, Size, RgnData^);
      FreeMem(RgnData, Size);
    end
  else
    R2 := 0;

  if (RMLeft.Width > 0) and (RMleft.Height > 0)
  then
    begin
      Size := CreateRgnFromBmp(RMLeft, 0, NewClRect.Top, RgnData);
      R3 := ExtCreateRegion(nil, Size, RgnData^);
      FreeMem(RgnData, Size);
    end
  else
    R3 := 0;

  if (RMRight.Width > 0) and (RMRight.Height > 0)
  then
    begin
      Size := CreateRgnFromBmp(RMRight, NewClRect.Right, NewClRect.Top, RgnData);
      R4 := ExtCreateRegion(nil, Size, RgnData^);
      FreeMem(RgnData, Size);
    end
  else
    R4 := 0;  

  if not isNullRect(NewClRect)
  then
    FRgn := CreateRectRgn(NewClRect.Left, NewClRect.Top,
                          NewClRect.Right, NewClRect.Bottom)
  else
    FRgn := 0;

  CombineRgn(R1, R1, R2, RGN_OR);
  CombineRgn(R3, R3, R4, RGN_OR);
  CombineRgn(R3, R3, R1, RGN_OR);

  CombineRgn(FRgn, FRgn, R3, RGN_OR);

  DeleteObject(R1);
  DeleteObject(R2);
  DeleteObject(R3);
  DeleteObject(R4);
  //
  RMTop.Free;
  RMBottom.Free;
  RMLeft.Free;
  RMRight.Free;
end;

procedure DrawGlyph;
var
  B: TBitMap;
  gw, gh: Integer;
  GR: TRect;
begin
  if FGlyph.Empty then Exit;
  gw := FGlyph.Width div FNumGlyphs;
  gh := FGlyph.Height;
  B := TBitMap.Create;
  B.Width := gw;
  B.Height := gh;
  GR := Rect(gw * (FGlyphNum - 1), 0, gw * FGlyphNum, gh);
  B.Canvas.CopyRect(Rect(0, 0, gw, gh), FGlyph.Canvas, GR);
  B.Transparent := True;
  Cnvs.Draw(X, Y, B);
  B.Free;
end;

procedure CreateSkinBorderImages;
var
  XCnt, YCnt, i, X, Y, XO, YO, w, h: Integer;
  TB: TBitMap;
  TR, TR1: TRect;
begin
  // top
  w := AW;
  h := NewClRect.Top;
  if (w > 0) and (h > 0) and (RTPt.X - LTPt.X > 0)
  then
    begin
      TopB.Width := w;
      TopB.Height := h;
      w := RTPt.X - LTPt.X;
      XCnt := TopB.Width div w;
      if TS
      then
        begin
          TB := TBitMap.Create;
          TR := Rect(R.Left + LTPt.X, R.Top,
                     R.Left + RTPt.X, R.Top + h);
          TR1 := Rect(NewLTPt.X, 0, NewRTPt.X, h);
          TB.Width := RectWidth(TR);
          TB.Height := RectHeight(TR);
          TB.Canvas.CopyRect(Rect(0, 0, TB.Width, TB.Height),
            SB.Canvas, TR);
          TopB.Canvas.StretchDraw(TR1, TB);
          TB.Free;
        end
      else
        for X := 0 to XCnt do
        begin
          if X * w + w > TopB.Width
          then XO := X * w + w -  TopB.Width else XO := 0;
          with TopB.Canvas do
          begin
            CopyRect(Rect(X * w, 0, X * w + w - XO, h),
                     SB.Canvas,
                     Rect(R.Left + LTPt.X, R.Top,
                     R.Left + RTPt.X - XO, R.Top + h));
          end;
        end;
      with TopB.Canvas do
      begin
        CopyRect(Rect(0, 0, NewLTPt.X, h), SB.Canvas,
                 Rect(R.Left, R.Top, R.Left + LTPt.X, R.Top + h));
        CopyRect(Rect(NewRTPt.X, 0, TopB.Width, h), SB.Canvas,
                 Rect(R.Left + RTPt.X, R.Top, R.Right, R.Top + h));
      end;
    end;

  // bottom
  w := AW;
  h := AH - NewClRect.Bottom;
  if (w > 0) and (h > 0) and (RBPt.X - LBPt.X > 0)
  then
    begin
      BottomB.Width := w;
      BottomB.Height := h;
      w := RBPt.X - LBPt.X;
      XCnt := BottomB.Width div w;
      if BS
      then
        begin
          TB := TBitMap.Create;
          TR := Rect(R.Left + LBPt.X, R.Bottom - h,
                          R.Left + RBPt.X, R.Bottom);
          TR1 := Rect(NewLBPt.X, 0, NewRBPt.X, h);
          TB.Width := RectWidth(TR);
          TB.Height := RectHeight(TR);
          TB.Canvas.CopyRect(Rect(0, 0, TB.Width, TB.Height),
          SB.Canvas, TR);
          BottomB.Canvas.StretchDraw(TR1, TB);
          TB.Free;
        end
      else
      for X := 0 to XCnt do
      begin
        if X * w + w > BottomB.Width
        then XO := X * w + w -  BottomB.Width else XO := 0;
          with BottomB.Canvas do
          begin
            CopyRect(Rect(X * w, 0, X * w + w - XO, h),
                     SB.Canvas,
                     Rect(R.Left + LBPt.X, R.Bottom - h,
                          R.Left + RBPt.X - XO, R.Bottom));
          end;
      end;
      with BottomB.Canvas do
      begin
        CopyRect(Rect(0, 0, NewLBPt.X, h), SB.Canvas,
                 Rect(R.Left, R.Bottom - h, R.Left + LBPt.X, R.Bottom));
        CopyRect(Rect(NewRBPt.X, 0, BottomB.Width, h), SB.Canvas,
                 Rect(R.Left + RBPt.X, R.Bottom - h, R.Right, R.Bottom));
      end;
    end;
  // draw left
  h := AH - BottomB.Height - TopB.Height;
  w := NewClRect.Left;
  if (w > 0) and (h > 0) and (LBPt.Y - LTPt.Y > 0)
  then
    begin
      LeftB.Width := w;
      LeftB.Height := h;
      h := LBPt.Y - LTPt.Y;
      YCnt := LeftB.Height div h;
      if LS
      then
        begin
          TB := TBitMap.Create;
          TR := Rect(R.Left, R.Top + LTPt.Y,
                     R.Left + w, R.Top + LBPt.Y);
          TR1 := Rect(0, LTPt.Y - ClRect.Top, w,
                      LeftB.Height - (ClRect.Bottom - LBPt.Y));
          TB.Width := RectWidth(TR);
          TB.Height := RectHeight(TR);
          TB.Canvas.CopyRect(Rect(0, 0, TB.Width, TB.Height),
          SB.Canvas, TR);
          LeftB.Canvas.StretchDraw(TR1, TB);
          TB.Free;
        end
      else
      for Y := 0 to YCnt do
      begin
        if Y * h + h > LeftB.Height
        then YO := Y * h + h - LeftB.Height else YO := 0;
        with LeftB.Canvas do
          CopyRect(Rect(0, Y * h, w, Y * h + h - YO),
                   SB.Canvas,
                   Rect(R.Left, R.Top + LTPt.Y, R.Left + w, R.Top + LBPt.Y - YO));
      end;
      with LeftB.Canvas do
      begin
        YO := LTPt.Y - ClRect.Top;
        if YO > 0
        then
          CopyRect(Rect(0, 0, w, YO), SB.Canvas,
                   Rect(R.Left, R.Top + ClRect.Top,
                   R.Left + w, R.Top + LTPt.Y));
        YO :=  ClRect.Bottom - LBPt.Y;
        if YO > 0
        then
          CopyRect(Rect(0, LeftB.Height - YO, w, LeftB.Height),
                   SB.Canvas,
                   Rect(R.Left, R.Top + LBPt.Y,
                   R.Left + w, R.Top + ClRect.Bottom));
      end;
    end;
   // draw right
  h := AH - BottomB.Height - TopB.Height;
  w := AW - NewClRect.Right;
  if (w > 0) and (h > 0) and (RBPt.Y - RTPt.Y > 0)
  then
    begin
      RightB.Width := w;
      RightB.Height := h;
      h := RBPt.Y - RTPt.Y;
      YCnt := RightB.Height div h;
      if RS
      then
        begin
          TB := TBitMap.Create;
          TR := Rect(R.Left + ClRect.Right, R.Top + RTPt.Y,
                                R.Right, R.Top + RBPt.Y);
          TR1 := Rect(0, RTPt.Y - ClRect.Top, w,
                      RightB.Height - (ClRect.Bottom - RBPt.Y));
          TB.Width := RectWidth(TR);
          TB.Height := RectHeight(TR);
          TB.Canvas.CopyRect(Rect(0, 0, TB.Width, TB.Height),
          SB.Canvas, TR);
          RightB.Canvas.StretchDraw(TR1, TB);
          TB.Free;
        end
      else
      for Y := 0 to YCnt do
      begin
        if Y * h + h > RightB.Height
        then YO := Y * h + h - RightB.Height else YO := 0;
        with RightB.Canvas do
        CopyRect(Rect(0, Y * h, w, Y * h + h - YO),
                 SB.Canvas,
                 Rect(R.Left + ClRect.Right, R.Top + RTPt.Y,
                      R.Right, R.Top + RBPt.Y - YO));
      end;
      with RightB.Canvas do
      begin
        YO := RTPt.Y - ClRect.Top;
        if YO > 0
        then
          CopyRect(Rect(0, 0, w, YO), SB.Canvas,
                   Rect(R.Left + ClRect.Right, R.Top + ClRect.Top,
                   R.Right, R.Top + RTPt.Y));
                  
        YO :=  ClRect.Bottom - RBPt.Y;
        if YO > 0
        then
          CopyRect(Rect(0, RightB.Height - YO, w, RightB.Height),
                   SB.Canvas,
                   Rect(R.Left + ClRect.Right, R.Top + RBPt.Y,
                        R.Right, R.Top + ClRect.Bottom));
      end;
    end;
end;


procedure DrawRCloseImage(C: TCanvas; R: TRect; Color: TColor);
var
  X, Y: Integer;
begin
  X := R.Left + RectWidth(R) div 2 - 5;
  Y := R.Top + RectHeight(R) div 2 - 5;
  DrawCloseImage(C, X, Y, Color);
end;


procedure DrawCloseImage(C: TCanvas; X, Y: Integer; Color: TColor);
begin
  with C do
  begin
    Pen.Color := Color;
    MoveTo(X + 1, Y + 1); LineTo(X + 9, Y + 9);
    MoveTo(X + 9, Y + 1); LineTo(X + 1, Y + 9);
    MoveTo(X + 2, Y + 1); LineTo(X + 10, Y + 9);
    MoveTo(X + 8, Y + 1); LineTo(X, Y + 9);
  end;
end;

procedure DrawSysMenuImage(C: TCanvas; X, Y: Integer; Color: TColor);
begin
  with C do
  begin                
    Pen.Color := Color;
    Brush.Style := bsClear;
    Rectangle(X + 1, Y + 3, X + 9, Y + 6);
  end;
end;

procedure DrawMinimizeImage(C: TCanvas; X, Y: Integer; Color: TColor);
begin
  with C do
  begin
    Pen.Color := Color;
    MoveTo(X + 1, Y + 8); LineTo(X + 9, Y + 8);
    MoveTo(X + 1, Y + 9); LineTo(X + 9, Y + 9);
  end;
end;

procedure DrawMaximizeImage(C: TCanvas; X, Y: Integer; Color: TColor);
begin
  with C do
  begin
    Brush.Style := bsClear;
    Pen.Color := Color;
    Rectangle(X, Y, X + 11, Y + 10);
    Rectangle(X, Y, X + 11, Y + 2);
  end;
end;

procedure DrawRestoreImage(C: TCanvas; X, Y: Integer; Color: TColor);
begin
  with C do
  begin
    Brush.Style := bsClear;
    Pen.Color := Color;
    Rectangle(X + 2, Y, X + 10, Y + 6);
    Rectangle(X + 2, Y, X + 10, Y + 2);
    Rectangle(X, Y + 4, X + 7, Y + 10);
    Rectangle(X, Y + 4, X + 7, Y + 6);
  end;
end;

procedure DrawRestoreRollUpImage(C: TCanvas; X, Y: Integer; Color: TColor);
begin
  with C do
  begin
    Pen.Color := Color;
    MoveTo(X + 5, Y + 6); LineTo(X + 5, Y + 6);
    MoveTo(X + 4, Y + 5); LineTo(X + 6, Y + 5);
    MoveTo(X + 3, Y + 4); LineTo(X + 7, Y + 4);
    MoveTo(X + 2, Y + 3); LineTo(X + 8, Y + 3);
    MoveTo(X + 1, Y + 2); LineTo(X + 9, Y + 2);
   end;
end;


procedure DrawRollUpImage(C: TCanvas; X, Y: Integer; Color: TColor);
begin
  with C do
  begin
    Pen.Color := Color;
    MoveTo(X + 1, Y + 6); LineTo(X + 9, Y + 6);
    MoveTo(X + 2, Y + 5); LineTo(X + 8, Y + 5);
    MoveTo(X + 3, Y + 4); LineTo(X + 7, Y + 4);
    MoveTo(X + 4, Y + 3); LineTo(X + 6, Y + 3);
    MoveTo(X + 5, Y + 2); LineTo(X + 5, Y + 2);
  end;
end;

procedure DrawMTImage(C: TCanvas; X, Y: Integer; Color: TColor);
begin
  with C do
  begin
    Pen.Color := Color;
    Brush.Color := Color;
    Rectangle(X + 2, Y + 2, X + 7, Y + 7);
  end;
end;

function ExtractDay(ADate: TDateTime): Word;
var
  M, Y: Word;
begin
  DecodeDate(ADate, Y, M, Result);
end;

function ExtractMonth(ADate: TDateTime): Word;
var
  D, Y: Word;
begin
  DecodeDate(ADate, Y, Result, D);
end;

function ExtractYear(ADate: TDateTime): Word;
var
  D, M: Word;
begin
  DecodeDate(ADate, Result, M, D);
end;

function IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer =
    (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result); { leap-year Feb is special }
end;

type

  PMonitorInfo = ^TMonitorInfo;
  TMonitorInfo = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
  end;

const
  MONITOR_DEFAULTTONEAREST = $2;
  SM_CMONITORS = 80;

var
  MonitorFromWindowFunc: function(hWnd: HWND; dwFlags: DWORD): THandle; stdcall;
  GetMonitorInfoFunc: function(hMonitor: THandle; lpMonitorInfo: PMonitorInfo): BOOL; stdcall;

function CheckMultiMonitors: Boolean;
var
  MonitorCount: Integer;
begin
  MonitorCount := GetSystemMetrics(SM_CMONITORS);
  Result := (MonitorCount > 1) and Assigned(GetMonitorInfoFunc);
end;

function GetPrimaryMonitorWorkArea(const WorkArea: Boolean): TRect;
begin
  if WorkArea
  then
    SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0)
  else
    Result := Rect(0, 0, Screen.Width, Screen.Height);
end;

function GetMonitorWorkArea(const W: HWND; const WorkArea: Boolean): TRect;
var
  MonitorInfo: TMonitorInfo;
  MH: THandle;
begin
  if CheckMultiMonitors
  then
    begin
      MH := MonitorFromWindowFunc(W, MONITOR_DEFAULTTONEAREST);
      MonitorInfo.cbSize := SizeOf(MonitorInfo);
      if GetMonitorInfoFunc(MH, @MonitorInfo)
      then
        begin
          if not WorkArea
          then
            Result := MonitorInfo.rcMonitor
          else
            Result := MonitorInfo.rcWork;
        end;
    end
  else
    Result := GetPrimaryMonitorWorkArea(WorkArea);
end;

var
  User32H: THandle;

initialization

  User32H := GetModuleHandle(user32);

  if User32H > 0 then
  begin
    MonitorFromWindowFunc := GetProcAddress(User32H, 'MonitorFromWindow');
    GetMonitorInfoFunc := GetProcAddress(User32H, 'GetMonitorInfoA');
    GetScrollBarInfoFunc := GetProcAddress(User32H, 'GetScrollBarInfo');
  end;

  BS_PlatformIsUnicode := (Win32Platform = VER_PLATFORM_WIN32_NT);

finalization

  if User32H > 0 then FreeLibrary(User32H);

  GetScrollBarInfoFunc := nil;
  MonitorFromWindowFunc := nil;
  GetMonitorInfoFunc := nil;

end.
