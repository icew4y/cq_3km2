unit HGEDistort;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Delphi conversion by Erik van Bilsen
**
** NOTE: The Delphi version uses a public IHGEDistortionMesh interface instead
** of a class (more conform the main IHGE interface).
*)

interface

uses
  HGE;

(****************************************************************************
 * HGEDistort.h
 ****************************************************************************)

const
  HGEDISP_NODE = 0;
  HGEDISP_TOPLEFT = 1;
  HGEDISP_CENTER = 2;

type
  IHGEDistortionMesh = interface
  ['{3F54F2EC-7CF5-45B6-82E8-6C20F339C85E}']
    { NOTE: This replaces the '=' operator in the C++ code }
    procedure Assign(const DM: IHGEDistortionMesh);

    procedure Render(const X, Y: Single);
    procedure Clear(const Col: Longword = $FFFFFFFF; const Z: Single = 0.5);

    procedure SetTexture(const Tex: ITexture);
    procedure SetTextureRect(const X, Y, W, H: Single);
    procedure SetBlendMode(const Blend: Integer);
    procedure SetZ(const Col, Row: Integer; const Z: Single);
    procedure SetColor(const Col, Row: Integer; const Color: Longword);
    procedure SetDisplacement(const Col, Row: Integer; const DX, DY: Single;
      const Ref: Integer);

    function GetTexture: ITexture;
    procedure GetTextureRect(out X, Y, W, H: Single);
    function GetBlendMode: Integer;
    function GetZ(const Col, Row: Integer): Single;
    function GetColor(const Col, Row: Integer): Longword;
    procedure GetDisplacement(const Col, Row: Integer; out DX, DY: Single;
      const Ref: Integer);

    function GetRows: Integer;
    function GetCols: Integer;

    function Implementor: TObject;
  end;

type
  THGEDistortionMesh = class(TInterfacedObject,IHGEDistortionMesh)
  protected
    { IHGEDistortionMesh }
    procedure Assign(const DM: IHGEDistortionMesh);

    procedure Render(const X, Y: Single);
    procedure Clear(const Col: Longword = $FFFFFFFF; const Z: Single = 0.5);

    procedure SetTexture(const Tex: ITexture);
    procedure SetTextureRect(const X, Y, W, H: Single);
    procedure SetBlendMode(const Blend: Integer);
    procedure SetZ(const Col, Row: Integer; const Z: Single);
    procedure SetColor(const Col, Row: Integer; const Color: Longword);
    procedure SetDisplacement(const Col, Row: Integer; const DX, DY: Single;
      const Ref: Integer);

    function GetTexture: ITexture;
    procedure GetTextureRect(out X, Y, W, H: Single);
    function GetBlendMode: Integer;
    function GetZ(const Col, Row: Integer): Single;
    function GetColor(const Col, Row: Integer): Longword;
    procedure GetDisplacement(const Col, Row: Integer; out DX, DY: Single;
      const Ref: Integer);

    function GetRows: Integer;
    function GetCols: Integer;

    function Implementor: TObject;
  private
    class var
      FHGE: IHGE;
  private
    FDispArray: PHGEVertexArray;
    FRows, FCols: Integer;
    FCellW, FCellH: Single;
    FTX, FTY, FWidth, FHeight: Single;
    FQuad: THGEQuad;
  public
    destructor Destroy; override;
    constructor Create(const Cols, Rows: Integer); overload;
    constructor Create(const DM: IHGEDistortionMesh); overload;
  end;

implementation

(****************************************************************************
 * HGEDistort.h, HGEDistort.cpp
 ****************************************************************************)

{ THGEDistortionMesh }

procedure THGEDistortionMesh.Assign(const DM: IHGEDistortionMesh);
var
  Src: THGEDistortionMesh;
begin
  Src := DM.Implementor as THGEDistortionMesh;
  if (Src <> Self) then begin
    FRows := Src.FRows;
    FCols := Src.FCols;
    FCellW := Src.FCellW;
    FCellH := Src.FCellH;
    FTX := Src.FTX;
    FTY := Src.FTY;
    FWidth := Src.FWidth;
    FHeight := Src.FHeight;
    FQuad := Src.FQuad;
    ReallocMem(FDispArray,FRows * FCols * SizeOf(THGEVertex));
    Move(Src.FDispArray^,FDispArray^,FRows * FCols * SizeOf(THGEVertex));
  end;
end;

procedure THGEDistortionMesh.Clear(const Col: Longword; const Z: Single);
var
  I, J: Integer;
begin
  for J := 0 to FRows - 1 do
    for I := 0 to FCols - 1 do begin
      FDispArray[J * FCols + I].X := I * FCellW;
      FDispArray[J * FCols + I].Y := J * FCellH;
      FDispArray[J * FCols + I].Col := Col;
      FDispArray[J * FCols + I].Z := Z;
    end;
end;

constructor THGEDistortionMesh.Create(const Cols, Rows: Integer);
var
  I: Integer;
begin
  inherited Create;
  FHGE := HGECreate(HGE_VERSION);
  FRows := Rows;
  FCols := Cols;
  FQuad.Blend := BLEND_COLORMUL or BLEND_ALPHABLEND or BLEND_ZWRITE;
  GetMem(FDispArray,Rows * Cols * SizeOf(THGEVertex));
  for I := 0 to Rows * Cols - 1 do begin
    FDispArray[I].X := 0;
    FDispArray[I].Y := 0;
    FDispArray[I].TX := 0;
    FDispArray[I].TY := 0;
    FDispArray[I].Z := 0.5;
    FDispArray[I].Col := $FFFFFFFF;
  end;
end;

constructor THGEDistortionMesh.Create(const DM: IHGEDistortionMesh);
begin
  inherited Create;
  FHGE := HGECreate(HGE_VERSION);
  Assign(DM);
end;

destructor THGEDistortionMesh.Destroy;
begin
  FreeMem(FDispArray);
  inherited;
end;

function THGEDistortionMesh.GetBlendMode: Integer;
begin
  Result := FQuad.Blend;
end;

function THGEDistortionMesh.GetColor(const Col, Row: Integer): Longword;
begin
  if (Row < FRows) and (Col < FCols) then
    Result := FDispArray[Row * FCols + Col].Col
  else
    Result := 0;
end;

function THGEDistortionMesh.GetCols: Integer;
begin
  Result := FCols;
end;

procedure THGEDistortionMesh.GetDisplacement(const Col, Row: Integer; out DX,
  DY: Single; const Ref: Integer);
begin
  if (Row < FRows) and (Col < FCols) then begin
    case Ref of
      HGEDISP_NODE:
        begin
          DX := FDispArray[Row * FCols + Col].X - Col * FCellW;
          DY := FDispArray[Row * FCols + Col].Y - Row * FCellH;
        end;
      HGEDISP_CENTER:
        begin
          DX := FDispArray[Row * FCols + Col].X - (FCellW * (FCols - 1) / 2);
          DY := FDispArray[Row * FCols + Col].Y - (FCellH * (FRows - 1) / 2);
        end;
    else
      begin
        DX := FDispArray[Row * FCols + Col].X;
        DY := FDispArray[Row * FCols + Col].Y;
      end;
    end;
  end;
end;

function THGEDistortionMesh.GetRows: Integer;
begin
  Result := FRows;
end;

function THGEDistortionMesh.GetTexture: ITexture;
begin
  Result := FQuad.Tex;
end;

procedure THGEDistortionMesh.GetTextureRect(out X, Y, W, H: Single);
begin
  X := FTX;
  Y := FTY;
  W := FWidth;
  H := FHeight;
end;

function THGEDistortionMesh.GetZ(const Col, Row: Integer): Single;
begin
  if (Row < FRows) and (Col < FCols) then
    Result := FDispArray[Row * FCols + Col].Z
  else
    Result := 0;
end;

function THGEDistortionMesh.Implementor: TObject;
begin
  Result := Self;
end;

procedure THGEDistortionMesh.Render(const X, Y: Single);
var
  I, J, Idx: Integer;
begin
  for J := 0 to FRows - 2 do
    for I := 0 to FCols - 2 do begin
      Idx := J * FCols + I;

      FQuad.V[0].TX := FDispArray[Idx].TX;
      FQuad.V[0].TY := FDispArray[Idx].TY;
      FQuad.V[0].X := X+FDispArray[Idx].X;
      FQuad.V[0].Y := Y+FDispArray[Idx].Y;
      FQuad.V[0].Z := FDispArray[Idx].Z;
      FQuad.V[0].Col := FDispArray[Idx].Col;

      FQuad.V[1].TX := FDispArray[Idx+1].TX;
      FQuad.V[1].TY := FDispArray[Idx+1].TY;
      FQuad.V[1].X := X+FDispArray[Idx+1].X;
      FQuad.V[1].Y := Y+FDispArray[Idx+1].Y;
      FQuad.V[1].Z := FDispArray[Idx+1].Z;
      FQuad.V[1].Col := FDispArray[Idx+1].Col;

      FQuad.V[2].TX := FDispArray[Idx+FCols+1].TX;
      FQuad.V[2].TY := FDispArray[Idx+FCols+1].TY;
      FQuad.V[2].X := X+FDispArray[Idx+FCols+1].X;
      FQuad.V[2].Y := Y+FDispArray[Idx+FCols+1].Y;
      FQuad.V[2].Z := FDispArray[Idx+FCols+1].Z;
      FQuad.V[2].Col := FDispArray[Idx+FCols+1].Col;

      FQuad.V[3].TX := FDispArray[Idx+FCols].TX;
      FQuad.V[3].TY := FDispArray[Idx+FCols].TY;
      FQuad.V[3].X := X+FDispArray[Idx+FCols].X;
      FQuad.V[3].Y := Y+FDispArray[Idx+FCols].Y;
      FQuad.V[3].Z := FDispArray[Idx+FCols].Z;
      FQuad.V[3].Col := FDispArray[Idx+FCols].Col;

      FHGE.Gfx_RenderQuad(FQuad);
    end;
end;

procedure THGEDistortionMesh.SetBlendMode(const Blend: Integer);
begin
  FQuad.Blend := Blend;
end;

procedure THGEDistortionMesh.SetColor(const Col, Row: Integer;
  const Color: Longword);
begin
  if (Row < FRows) and (Col < FCols) then
    FDispArray[Row * FCols + Col].Col := Color;
end;

procedure THGEDistortionMesh.SetDisplacement(const Col, Row: Integer; const DX,
  DY: Single; const Ref: Integer);
var
  XDelta, YDelta: Single;
begin
  if (Row < FRows) and (Col < FCols) then begin
    case Ref of
      HGEDISP_NODE:
        begin
          XDelta := DX + Col * FCellW;
          YDelta := DY + Row * FCellH;
        end;
      HGEDISP_CENTER:
        begin
          XDelta := DX + (FCellW * (FCols - 1) / 2);
          YDelta := DY + (FCellH * (FRows - 1) / 2);
        end;
    else
      begin
        XDelta := DX;
        YDelta := DY;
      end;
    end;
    FDispArray[Row * FCols + Col].X := XDelta;
    FDispArray[Row * FCols + Col].Y := YDelta;
  end;
end;

procedure THGEDistortionMesh.SetTexture(const Tex: ITexture);
begin
  FQuad.Tex := Tex;
end;

procedure THGEDistortionMesh.SetTextureRect(const X, Y, W, H: Single);
var
  I, J: Integer;
  TW, TH: Single;
begin
  FTX := X;
  FTY := Y;
  FWidth := W;
  FHeight := H;
  if Assigned(FQuad.Tex) then begin
    TW := FQuad.Tex.GetWidth;
    TH := FQuad.Tex.GetHeight;
  end else begin
    TW := W;
    TH := H;
  end;

  FCellW := W / (FCols - 1);
  FCellH := H / (FRows - 1);

  for J := 0 to FRows - 1 do
    for I := 0 to FCols - 1 do begin
      FDispArray[J * FCols + I].TX := (X + I * FCellW) / TW;
      FDispArray[J * FCols + I].TY := (Y + J * FCellH) / TH;

      FDispArray[J * FCols + I].X := I * FCellW;
      FDispArray[J * FCols + I].Y := J * FCellH;
    end;
end;

procedure THGEDistortionMesh.SetZ(const Col, Row: Integer; const Z: Single);
begin
  if (Row < FRows) and (Col < FCols) then
    FDispArray[Row * FCols + Col].Z := Z;
end;

initialization
  THGEDistortionMesh.FHGE := nil;

end.
