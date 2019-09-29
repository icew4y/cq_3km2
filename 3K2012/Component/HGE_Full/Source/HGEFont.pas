unit HGEFont;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Delphi conversion by Erik van Bilsen
**
** NOTE: The Delphi version uses a public IHGEFont interface instead of a
** class (more conform the main IHGE interface).
*)

interface

uses
  HGE, HGESprite;

(****************************************************************************
 * HGEFont.h
 ****************************************************************************)

const
  HGETEXT_LEFT     = 0;
  HGETEXT_RIGHT    = 1;
  HGETEXT_CENTER   = 2;
  HGETEXT_HORZMASK = $03;

  HGETEXT_TOP      = 0;
  HGETEXT_BOTTOM   = 4;
  HGETEXT_MIDDLE   = 8;
  HGETEXT_VERTMASK = $0C;

type
  IHGEFont = interface
  ['{1BB9C7BC-D1B3-474E-A195-9F74B18D597C}']
    procedure Render(const X, Y: Single; const Align: Integer; const S: String);
    procedure PrintF(const X, Y: Single; const Align: Integer;
      const Format: String; const Args: array of const);
    procedure PrintFB(const X, Y, W, H: Single; const Align: Integer;
      const Format: String; const Args: array of const);

    procedure SetColor(const Col: Longword);
    procedure SetZ(const Z: Single);
    procedure SetBlendMode(const Blend: Integer);
    procedure SetScale(const Scale: Single);
    procedure SetProportion(const Prop: Single);
    procedure SetRotation(const Rot: Single);
    procedure SetTracking(const Tracking: Single);
    procedure SetSpacing(const Spacing: Single);

    function GetColor: Longword;
    function GetZ: Single;
    function GetBlendMode: Integer;
    function GetScale: Single;
    function GetProportion: Single;
    function GetRotation: Single;
    function GetTracking: Single;
    function GetSpacing: Single;

    function GetSprite(const Chr: Char): IHGESprite;
    function GetHeight: Single;
    function GetStringWidth(const S: String;
      const FirstLineOnly: Boolean = True): Single;

    function Implementor: TObject;
  end;

type
  THGEFont = class(TInterfacedObject, IHGEFont)
  protected
    { IHGEFont }
    procedure Render(const X, Y: Single; const Algn: Integer; const S: String);
    procedure PrintF(const X, Y: Single; const Align: Integer;
      const Format: String; const Args: array of const);
    procedure PrintFB(const X, Y, W, H: Single; const Align: Integer;
      const Format: String; const Args: array of const);

    procedure SetColor(const Col: Longword);
    procedure SetZ(const Z: Single);
    procedure SetBlendMode(const Blend: Integer);
    procedure SetScale(const Scale: Single);
    procedure SetProportion(const Prop: Single);
    procedure SetRotation(const Rot: Single);
    procedure SetTracking(const Tracking: Single);
    procedure SetSpacing(const Spacing: Single);

    function GetColor: Longword;
    function GetZ: Single;
    function GetBlendMode: Integer;
    function GetScale: Single;
    function GetProportion: Single;
    function GetRotation: Single;
    function GetTracking: Single;
    function GetSpacing: Single;

    function GetSprite(const Chr: Char): IHGESprite;
    function GetHeight: Single;
    function GetStringWidth(const S: String;
      const FirstLineOnly: Boolean = True): Single;

    function Implementor: TObject;
  private
    class var
      FHGE: IHGE;
  private
    FTexture: ITexture;
    FLetters: array [0..255] of IHGESprite;
    FPre, FPost: array [0..255] of Single;
    FHeight, FScale, FProportion, FRot, FTracking, FSpacing, FZ: Single;
    FCol: Longword;
    FBlend: Integer;
    function GetLine(const FromFile, Line: PChar): PChar;
  public
    constructor Create(const Filename: String;
      const Mipmap: Boolean = False);
    destructor Destroy; override;
  end;

implementation

uses
  Windows, SysUtils;

(****************************************************************************
 * HGEFont.h, HGEFont.cpp
 ****************************************************************************)

const
  FNTHEADERTAG = '[HGEFONT]';
  FNTBITMAPTAG = 'Bitmap';
  FNTCHARTAG = 'Char';

{ THGEFont }

constructor THGEFont.Create(const Filename: String;
  const Mipmap: Boolean = False);
var
  Data: IResource;
  Size: Longword;
  Desc, PDesc, PBuf: PChar;
  LineBuf: array [0..255] of Char;
  S: String;
  Chr: Char;
  I, X, Y, W, H, A, C: Integer;

  function GetParam: Integer;
  var
    Start: PChar;
    C: Char;
  begin
    while (PBuf^ in [' ',',']) do
      Inc(PBuf);
    Start := PBuf;
    while (PBuf^ in ['0'..'9']) do
      Inc(PBuf);
    if (PBuf = Start) then
      Result := 0
    else begin
      C := PBuf^;
      PBuf^ := #0;
      Result := StrToInt(Start);
      PBuf^ := C;
    end;
  end;

begin
  inherited Create;
  // Setup variables
  FHGE := HGECreate(HGE_VERSION);

  FScale := 1.0;
  FProportion := 1;
  FSpacing := 1.0;
  FZ := 0.5;
  FBlend := BLEND_COLORMUL or BLEND_ALPHABLEND or BLEND_NOZWRITE;
  FCol := $FFFFFFFF;

  // Load font description

  Data := FHGE.Resource_Load(Filename,@Size);
  if (Data = nil) then
    Exit;

  GetMem(Desc,Size + 1);
  Move(Data.Handle^,Desc^,Size);
  Desc[Size] := #0;
  Data := nil;

  PDesc := GetLine(Desc,LineBuf);
  if (StrComp(LineBuf,FNTHEADERTAG) <> 0) then begin
    FHGE.System_Log('Font %s has incorrect format.',[Filename]);
    FreeMem(Desc);
    Exit;
  end;

  // Parse font description
  PDesc := GetLine(PDesc,LineBuf);
  while Assigned(PDesc) do begin
    if (StrLComp(LineBuf,FNTBITMAPTAG,Length(FNTBITMAPTAG)) = 0) then begin
      S := Filename;
      PBuf := StrScan(LineBuf,'=');
      if (PBuf <> nil) then begin
        Inc(PBuf);
        S := Trim(PBuf);
      end;
      FTexture := FHGE.Texture_Load(S,Mipmap);
      if (FTexture = nil) then begin
        FreeMem(Desc);
        Exit;
      end;
    end else if (StrLComp(LineBuf,FNTCHARTAG,Length(FNTCHARTAG)) = 0) then begin
      PBuf := StrScan(LineBuf,'=');
      if (PBuf = nil) then
        Continue;
      Inc(PBuf);
      while (PBuf^ = ' ') do
        Inc(PBuf);
      if (PBuf^ = '"') then begin
        Inc(PBuf);
        I := Ord(PBuf^);
        Inc(PBuf,2);
      end else begin
        I := 0;
        while (PBuf^ in ['0'..'9','A'..'F','a'..'f']) do begin
          Chr := PBuf^;
          if (Chr >= 'a') then
            Dec(Chr,Ord(Ord('a') - Ord(':')));
          if (Chr >= 'A') then
            Dec(Chr,Ord(Ord('A') - Ord(':')));
          Dec(Chr,Ord('0'));
          if (Chr > #$F) then
            Chr := #$F;
          I := (I shl 4) or Ord(Chr);
          Inc(PBuf);
        end;
        if (I < 0) or (I > 255) then
          Continue;
      end;
      X := GetParam;
      Y := GetParam;
      W := GetParam;
      H := GetParam;
      A := GetParam;
      C := GetParam;
      FLetters[I] := THGESprite.Create(FTexture,X,Y,W,H);
      FPre[I] := A;
      FPost[I] := C;
      if (H > FHeight) then
        FHeight := H;
    end;
    PDesc := GetLine(PDesc,LineBuf);
  end;
  FreeMem(Desc);
end;

destructor THGEFont.Destroy;
var
  I: Integer;
begin
  for I := 0 to 255 do
    FLetters[I] := nil;
  FTexture := nil;
  inherited;
end;

function THGEFont.GetBlendMode: Integer;
begin
  Result := FBlend;
end;

function THGEFont.GetColor: Longword;
begin
  Result := FCol;
end;

function THGEFont.GetHeight: Single;
begin
  Result := FHeight;
end;

function THGEFont.GetLine(const FromFile, Line: PChar): PChar;
var
  I: Integer;
begin
  I := 0;
  if (FromFile[I] = #0) then begin
    Result := nil;
    Exit;
  end;

  while (not (FromFile[I] in [#0,#10,#13])) do begin
    Line[I] := FromFile[I];
    Inc(I);
  end;
  Line[I] := #0;

  while (FromFile[I] <> #0) and (FromFile[I] in [#10,#13]) do
    Inc(I);

  Result := @FromFile[I];
end;

function THGEFont.GetProportion: Single;
begin
  Result := FProportion;
end;

function THGEFont.GetRotation: Single;
begin
  Result := FRot;
end;

function THGEFont.GetScale: Single;
begin
  Result := FScale;
end;

function THGEFont.GetSpacing: Single;
begin
  Result := FSpacing;
end;

function THGEFont.GetSprite(const Chr: Char): IHGESprite;
begin
  Result := FLetters[Ord(Chr)];
end;

function THGEFont.GetStringWidth(const S: String;
  const FirstLineOnly: Boolean = True): Single;
var
  I: Integer;
  LineW: Single;
  P: PChar;
begin
  Result := 0;
  P := PChar(S);
  while (P^ <> #0) do begin
    LineW := 0;
    while (not (P^ in [#0,#10,#13])) do begin
      I := Ord(P^);
      if (FLetters[I] = nil) then
        I := Ord('?');
      if Assigned(FLetters[I]) then
        LineW := LineW + FLetters[I].GetWidth + FPre[I] + FPost[I] + FTracking;
      Inc(P);
    end;
    if (LineW > Result) then
      Result := LineW;
    if (FirstLineOnly and (P^ in [#10,#13])) then
      Break;
    while (P^ in [#10,#13]) do
      Inc(P);
  end;
  Result := Result * FScale * FProportion;
end;

function THGEFont.GetTracking: Single;
begin
  Result := FTracking;
end;

function THGEFont.GetZ: Single;
begin
  Result := FZ;
end;

function THGEFont.Implementor: TObject;
begin
  Result := Self;
end;

procedure THGEFont.PrintF(const X, Y: Single; const Align: Integer;
  const Format: String; const Args: array of const);
begin
  Render(X,Y,Align,SysUtils.Format(Format,Args));
end;

procedure THGEFont.PrintFB(const X, Y, W, H: Single; const Align: Integer;
  const Format: String; const Args: array of const);
var
  I, Lines: Integer;
  LineStart, PrevWord: PChar;
  Buf: String;
  PBuf: PChar;
  Chr: Char;
  TX, TY, WW, HH: Single;
begin
  Buf := SysUtils.Format(Format,Args);
  PBuf := PChar(Buf);
  Lines := 0;
  LineStart := PBuf;
  PrevWord := nil;
  while (True) do begin
    I := 0;
    while (not (PBuf[I] in [#0,#10,#13,' '])) do
      Inc(I);
    Chr := PBuf[I];
    PBuf[I] := #0;
    WW := GetStringWidth(LineStart);
    PBuf[I] := Chr;

    if (WW > W) then begin
      if (PBuf = LineStart) then begin
        PBuf[I] := #13;
        LineStart := @PBuf[I + 1];
      end else begin
        PrevWord^ := #13;
        LineStart := PrevWord + 1;
      end;
      Inc(Lines);
    end;

    if (PBuf[I] = #13) then begin
      PrevWord := @PBuf[I];
      LineStart := @PBuf[I + 1];
      PBuf := LineStart;
      Inc(Lines);
      Continue;
    end;

    if (PBuf[I] = #0) then begin
      Inc(Lines);
      Break;
    end;

    PrevWord := @PBuf[I];
    PBuf := @PBuf[I + 1];
  end;

  TX := X;
  TY := Y;
  HH := FHeight * FSpacing * FScale * Lines;

  case (Align and HGETEXT_HORZMASK) of
    HGETEXT_RIGHT:
      TX := TX + W;
    HGETEXT_CENTER:
      TX := TX + Trunc(W / 2);
  end;

  case (Align and HGETEXT_VERTMASK) of
    HGETEXT_BOTTOM:
      TY := TY + (H - HH);
    HGETEXT_MIDDLE:
      TY := TY + Trunc((H - HH) / 2);
  end;

  Render(TX,TY,Align,Buf);
end;

procedure THGEFont.Render(const X, Y: Single; const Algn: Integer;
  const S: String);
var
  I, J, Align: Integer;
  FX, FY: Single;
begin
  FX := X;
  FY := Y;
  Align := Algn and HGETEXT_HORZMASK;
  if (Align = HGETEXT_RIGHT) then
    FX := FX - GetStringWidth(S);
  if (Align = HGETEXT_CENTER) then
    FX := FX - Trunc(GetStringWidth(S) / 2);

  for J := 1 to Length(S) do begin
    if (S[J] in [#10,#13]) then begin
      FY := FY + Trunc(FHeight * FScale * FSpacing);
      FX := X;
      if (Align = HGETEXT_RIGHT) then
        FX := FX - GetStringWidth(Copy(S,J + 1,MaxInt));
      if (Align = HGETEXT_CENTER) then
        FX := FX - Trunc(GetStringWidth(Copy(S,J + 1,MaxInt)) / 2);
    end else begin
      I := Ord(S[J]);
      if (FLetters[I] = nil) then
        I := Ord('?');
      if Assigned(FLetters[I]) then begin
        FX := FX + FPre[I] * FScale * FProportion;
        FLetters[I].RenderEx(FX,FY,FRot,FScale * FProportion,FScale);
        FX := FX + (FLetters[I].GetWidth + FPost[I] + FTracking) * FScale * FProportion;
      end;
    end;
  end;
end;

procedure THGEFont.SetBlendMode(const Blend: Integer);
var
  I: Integer;
begin
  FBlend := Blend;
  for I := 0 to 255 do
    if Assigned(FLetters[I]) then
      FLetters[I].SetBlendMode(Blend);
end;

procedure THGEFont.SetColor(const Col: Longword);
var
  I: Integer;
begin
  FCol := Col;
  for I := 0 to 255 do
    if Assigned(FLetters[I]) then
      FLetters[I].SetColor(Col);
end;

procedure THGEFont.SetProportion(const Prop: Single);
begin
  FProportion := Prop;
end;

procedure THGEFont.SetRotation(const Rot: Single);
begin
  FRot := Rot;
end;

procedure THGEFont.SetScale(const Scale: Single);
begin
  FScale := Scale;
end;

procedure THGEFont.SetSpacing(const Spacing: Single);
begin
  FSpacing := Spacing;
end;

procedure THGEFont.SetTracking(const Tracking: Single);
begin
  FTracking := Tracking;
end;

procedure THGEFont.SetZ(const Z: Single);
var
  I: Integer;
begin
  FZ := Z;
  for I := 0 to 255 do
    if Assigned(FLetters[I]) then
      FLetters[I].SetZ(Z);
end;

initialization
  THGEFont.FHGE := nil;

end.
