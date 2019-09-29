unit HGESprite;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Delphi conversion by Erik van Bilsen
**
** NOTE: The Delphi version uses a public IHGESprite interface instead of a
** class (more conform the main IHGE interface).
*)

interface

uses
  HGE, HGERect;

(****************************************************************************
 * HGESprite.h
 ****************************************************************************)

type
  IHGESprite = interface
  ['{862BF27E-78C1-4ABE-815D-1B844C9DAAD8}']
    procedure Render(const X, Y: Single);
    procedure RenderEx(const X, Y, Rot: Single; const HScale: Single = 1.0;
      VScale: Single = 0.0);
    procedure RenderStretch(const X1, Y1, X2, Y2: Single);
    procedure Render4V(const X0, Y0, X1, Y1, X2, Y2, X3, Y3: Single);

    procedure SetTexture(const Tex: ITexture);
    procedure SetTextureRect(const X, Y, W, H: Single;
      const AdjSize: Boolean = True);
    procedure SetColor(const Col: Longword; const I: Integer = -1);
    procedure SetZ(const Z: Single; const I: Integer = -1);
    procedure SetBlendMode(const Blend: Integer);
    procedure SetHotSpot(const X, Y: Single);
    procedure SetFlip(const X, Y: Boolean; const HotSpot: Boolean = False);

    function GetTexture: ITexture;
    procedure GetTextureRect(out X, Y, W, H: Single);
    function GetColor(const I: Integer = 0): Longword;
    function GetZ(const I: Integer = -0): Single;
    function GetBlendMode: Integer;
    procedure GetHotSpot(out X, Y: Single);
    procedure GetFlip(out X, Y: Boolean);

    function GetWidth: Single;
    function GetHeight: Single;
    function GetBoundingBox(const X, Y: Single; var Rect: THGERect): PHGERect;
    function GetBoundingBoxEx(const X, Y, Rot, HScale, VScale: Single; var Rect: THGERect): PHGERect;

    function Implementor: TObject;
  end;

type
  THGESprite = class(TInterfacedObject,IHGESprite)
  protected
     { IHGESprite }
    procedure Render(const X, Y: Single);
    procedure RenderEx(const X, Y, Rot: Single; const HScale: Single = 1.0;
      VScale: Single = 0.0);
    procedure RenderStretch(const X1, Y1, X2, Y2: Single);
    procedure Render4V(const X0, Y0, X1, Y1, X2, Y2, X3, Y3: Single);

    procedure SetTexture(const Tex: ITexture);
    procedure SetTextureRect(const X, Y, W, H: Single;
      const AdjSize: Boolean = True);
    procedure SetColor(const Col: Longword; const I: Integer = -1);
    procedure SetZ(const Z: Single; const I: Integer = -1);
    procedure SetBlendMode(const Blend: Integer);
    procedure SetHotSpot(const X, Y: Single);
    procedure SetFlip(const X, Y: Boolean; const HotSpot: Boolean = False);

    function GetTexture: ITexture;
    procedure GetTextureRect(out X, Y, W, H: Single);
    function GetColor(const I: Integer = 0): Longword;
    function GetZ(const I: Integer = -0): Single;
    function GetBlendMode: Integer;
    procedure GetHotSpot(out X, Y: Single);
    procedure GetFlip(out X, Y: Boolean);

    function GetBoundingBox(const X, Y: Single; var Rect: THGERect): PHGERect;
    function GetBoundingBoxEx(const X, Y, Rot, HScale, VScale: Single; var Rect: THGERect): PHGERect;
    function GetWidth: Single;
    function GetHeight: Single;

    function Implementor: TObject;
  private
    class var
      FHGE: IHGE;
  private
    FTX, FTY, FWidth, FHeight: Single;
    FTexWidth, FTexHeight: Single;
    FHotX, FHotY: Single;
    FXFlip, FYFlip, FHSFlip: Boolean;
  protected
    FQuad: THGEQuad;
    property TX: Single read FTX;
    property TY: Single read FTY;
    property Width: Single read FWidth;
    property Height: Single read FHeight;
    property TexWidth: Single read FTexWidth;
    property TexHeight: Single read FTexHeight;
    property HotX: Single read FHotX;
    property HotY: Single read FHotY;
    property XFlip: Boolean read FXFlip write FXFlip;
    property YFlip: Boolean read FYFlip write FYFlip;
    property HSFlip: Boolean read FHSFlip write FHSFlip;
  public
    constructor Create(const Texture: ITexture; const TexX, TexY, W, H: Single); overload;
    constructor Create(const Spr: IHGESprite); overload;
  end;

implementation

uses
  HGEUtils;

(****************************************************************************
 * HGESprite.h, HGESprite.cpp
 ****************************************************************************)

{ THGESprite }

constructor THGESprite.Create(const Texture: ITexture; const TexX, TexY,
  W, H: Single);
var
  TexX1, TexY1, TexX2, TexY2: Single;
begin
  inherited Create;
  FHGE := HGECreate(HGE_VERSION);
  FTX := TexX;
  FTY := TexY;
  FWidth := W;
  FHeight := H;

  if Assigned(Texture) then begin
    FTexWidth := FHGE.Texture_GetWidth(Texture);
    FTexHeight := FHGE.Texture_GetHeight(Texture);
  end else begin
    FTexWidth := 1;
    FTexHeight := 1;
  end;

  FQuad.Tex := Texture;

  TexX1 := TexX / FTexWidth;
  TexY1 := TexY / FTexHeight;
  TexX2 := (TexX + W) / FTexWidth;
  TexY2 := (TexY + H) / FTexHeight;

  FQuad.V[0].TX := TexX1; FQuad.V[0].TY := TexY1;
  FQuad.V[1].TX := TexX2; FQuad.V[1].TY := TexY1;
  FQuad.V[2].TX := TexX2; FQuad.V[2].TY := TexY2;
  FQuad.V[3].TX := TexX1; FQuad.V[3].TY := TexY2;

  FQuad.V[0].Z := 0.5;
  FQuad.V[1].Z := 0.5;
  FQuad.V[2].Z := 0.5;
  FQuad.V[3].Z := 0.5;

  FQuad.V[0].Col := $ffffffff;
  FQuad.V[1].Col := $ffffffff;
  FQuad.V[2].Col := $ffffffff;
  FQuad.V[3].Col := $ffffffff;

  FQuad.Blend := BLEND_DEFAULT;
end;

constructor THGESprite.Create(const Spr: IHGESprite);
begin
  inherited Create;
  CopyInstanceData(Spr.Implementor,Self);
  FHGE := HGECreate(HGE_VERSION);
end;

function THGESprite.GetBlendMode: Integer;
begin
  Result := FQuad.Blend;
end;

function THGESprite.GetBoundingBox(const X, Y: Single;
  var Rect: THGERect): PHGERect;
begin
  Rect.SetRect(X - FHotX,Y - FHotY,X - FHotX + FWidth,Y - FHotY + FHeight);
  Result := @Rect;
end;

function THGESprite.GetBoundingBoxEx(const X, Y, Rot, HScale, VScale: Single;
  var Rect: THGERect): PHGERect;
var
  TX1, TY1, TX2, TY2, SinT, CosT: Single;
begin
  Rect.Clear;

  TX1 := -FHotX * HScale;
  TY1 := -FHotY * VScale;
  TX2 := (FWidth - FHotX) * HScale;
  TY2 := (FHeight - FHotY) * VScale;

  if (Rot <> 0.0) then begin
    CosT := Cos(Rot);
    SinT := Sin(Rot);

    Rect.Encapsulate(TX1 * CosT - TY1 * SinT + X,TX1 * SinT + TY1 * CosT + Y);
    Rect.Encapsulate(TX2 * CosT - TY1 * SinT + X,TX2 * SinT + TY1 * CosT + Y);
    Rect.Encapsulate(TX2 * CosT - TY2 * SinT + X,TX2 * SinT + TY2 * CosT + Y);
    Rect.Encapsulate(TX1 * CosT - TY2 * SinT + X,TX1 * SinT + TY2 * CosT + Y);
  end else begin
    Rect.Encapsulate(TX1 + X, TY1 + Y);
    Rect.Encapsulate(TX2 + X, TY1 + Y);
    Rect.Encapsulate(TX2 + X, TY2 + Y);
    Rect.Encapsulate(TX1 + X, TY2 + Y);
  end;

  Result := @Rect;
end;

function THGESprite.GetColor(const I: Integer): Longword;
begin
  Result := FQuad.V[I].Col;
end;

procedure THGESprite.GetFlip(out X, Y: Boolean);
begin
  X := FXFlip;
  Y := FYFlip;
end;

function THGESprite.GetHeight: Single;
begin
  Result := FHeight;
end;

procedure THGESprite.GetHotSpot(out X, Y: Single);
begin
  X := FHotX;
  Y := FHotY;
end;

function THGESprite.GetTexture: ITexture;
begin
  Result := FQuad.Tex;
end;

procedure THGESprite.GetTextureRect(out X, Y, W, H: Single);
begin
  X := FTX;
  Y := FTY;
  W := FWidth;
  H := FHeight;
end;

function THGESprite.GetWidth: Single;
begin
  Result := FWidth;
end;

function THGESprite.GetZ(const I: Integer): Single;
begin
  Result := FQuad.V[I].Z;
end;

function THGESprite.Implementor: TObject;
begin
  Result := Self;
end;

procedure THGESprite.Render(const X, Y: Single);
var
  TempX1, TempY1, TempX2, TempY2: Single;
begin
  TempX1 := X - FHotX;
  TempY1 := Y - FHotY;
  TempX2 := X + FWidth - FHotX;
  TempY2 := Y + FHeight - FHotY;

  FQuad.V[0].X := TempX1; FQuad.V[0].Y := TempY1;
  FQuad.V[1].X := TempX2; FQuad.V[1].Y := TempY1;
  FQuad.V[2].X := TempX2; FQuad.V[2].Y := TempY2;
  FQuad.V[3].X := TempX1; FQuad.V[3].Y := TempY2;

  FHGE.Gfx_RenderQuad(FQuad);
end;

procedure THGESprite.Render4V(const X0, Y0, X1, Y1, X2, Y2, X3, Y3: Single);
begin
  FQuad.V[0].X := X0; FQuad.V[0].Y := Y0;
  FQuad.V[1].X := X1; FQuad.V[1].Y := Y1;
  FQuad.V[2].X := X2; FQuad.V[2].Y := Y2;
  FQuad.V[3].X := X3; FQuad.V[3].Y := Y3;

  FHGE.Gfx_RenderQuad(FQuad);
end;

procedure THGESprite.RenderEx(const X, Y, Rot, HScale: Single; VScale: Single);
var
  TX1, TY1, TX2, TY2, SinT, CosT: Single;
begin
  if (VScale=0) then
    VScale := HScale;

  TX1 := -FHotX * HScale;
  TY1 := -FHotY * VScale;
  TX2 := (FWidth - FHotX) * HScale;
  TY2 := (FHeight - FHotY) * VScale;

  if (Rot <> 0.0) then begin
    CosT := Cos(Rot);
    SinT := Sin(Rot);

    FQuad.V[0].X := TX1 * CosT - TY1 * SinT + X;
    FQuad.V[0].Y := TX1 * SinT + TY1 * CosT + Y;

    FQuad.V[1].X := TX2 * CosT - TY1 * SinT + X;
    FQuad.V[1].Y := TX2 * SinT + TY1 * CosT + Y;

    FQuad.V[2].X := TX2 * CosT - TY2 * SinT + X;
    FQuad.V[2].Y := TX2 * SinT + TY2 * CosT + Y;

    FQuad.V[3].X := TX1 * CosT - TY2 * SinT + X;
    FQuad.V[3].Y := TX1 * SinT + TY2 * CosT + Y;
  end else begin
    FQuad.V[0].X := TX1 + X; FQuad.V[0].Y := TY1 + Y;
    FQuad.V[1].X := TX2 + X; FQuad.V[1].Y := TY1 + Y;
    FQuad.V[2].X := TX2 + X; FQuad.V[2].Y := TY2 + Y;
    FQuad.V[3].X := TX1 + X; FQuad.V[3].Y := TY2 + Y;
  end;

  FHGE.Gfx_RenderQuad(FQuad);
end;

procedure THGESprite.RenderStretch(const X1, Y1, X2, Y2: Single);
begin
  FQuad.V[0].X := X1; FQuad.V[0].Y := Y1;
  FQuad.V[1].X := X2; FQuad.V[1].Y := Y1;
  FQuad.V[2].X := X2; FQuad.V[2].Y := Y2;
  FQuad.V[3].X := X1; FQuad.V[3].Y := Y2;

  FHGE.Gfx_RenderQuad(FQuad);
end;

procedure THGESprite.SetBlendMode(const Blend: Integer);
begin
  FQuad.Blend := Blend;
end;

procedure THGESprite.SetColor(const Col: Longword; const I: Integer);
begin
  if (I <> -1) then
    FQuad.V[I].Col := Col
  else begin
    FQuad.V[0].Col := Col;
    FQuad.V[1].Col := Col;
    FQuad.V[2].Col := Col;
    FQuad.V[3].Col := Col;
  end;
end;

procedure THGESprite.SetFlip(const X, Y: Boolean; const HotSpot: Boolean = False);
var
  TX, TY: Single;
begin
  if (FHSFlip and FXFlip) then
    FHotX := Width - FHotX;
  if (FHSFlip and FYFlip) then
    FHotY := Height - FHotY;

  FHSFlip := HotSpot;

  if (FHSFlip and FXFlip) then
    FHotX := Width - FHotX;
  if (FHSFlip and FYFlip) then
    FHotY := Height - FHotY;

  if (X <> FXFlip) then begin
    TX := FQuad.V[0].TX; FQuad.V[0].TX := FQuad.V[1].TX; FQuad.V[1].TX := TX;
    TY := FQuad.V[0].TY; FQuad.V[0].TY := FQuad.V[1].TY; FQuad.V[1].TY := TY;
    TX := FQuad.V[3].TX; FQuad.V[3].TX := FQuad.V[2].TX; FQuad.V[2].TX := TX;
    TY := FQuad.V[3].TY; FQuad.V[3].TY := FQuad.V[2].TY; FQuad.V[2].TY := TY;
    FXFlip := not FXFlip;
  end;

  if(Y <>  FYFlip) then begin
    TX := FQuad.V[0].TX; FQuad.V[0].TX := FQuad.V[3].TX; FQuad.V[3].TX := TX;
    TY := FQuad.V[0].TY; FQuad.V[0].TY := FQuad.V[3].TY; FQuad.V[3].TY := TY;
    TX := FQuad.V[1].TX; FQuad.V[1].TX := FQuad.V[2].TX; FQuad.V[2].TX := TX;
    TY := FQuad.V[1].TY; FQuad.V[1].TY := FQuad.V[2].TY; FQuad.V[2].TY := TY;
    FYFlip := not FYFlip;
  end;
end;

procedure THGESprite.SetHotSpot(const X, Y: Single);
begin
  FHotX := X;
  FHotY := Y;
end;

procedure THGESprite.SetTexture(const Tex: ITexture);
var
  TX1, TY1, TX2, TY2, TW, TH: Single;
begin
  FQuad.Tex := Tex;

  if Assigned(Tex) then begin
    TW := FHGE.Texture_GetWidth(Tex);
    TH := FHGE.Texture_GetHeight(Tex);
  end else begin
    TW := 1.0;
    TH := 1.0;
  end;

  if (TW <> FTexWidth) or (TH <> FTexHeight) then begin
    TX1 := FQuad.V[0].TX * FTexWidth;
    TY1 := FQuad.V[0].TY * FTexHeight;
    TX2 := FQuad.V[2].TX * FTexWidth;
    TY2 := FQuad.V[2].TY * FTexHeight;

    FTexWidth := TW;
    FTexHeight := TH;

    TX1 := TX1 / TW; TY1 := TY1 / TH;
    TX2 := TX2 / TW; TY2 := TY2 / TH;

    FQuad.V[0].TX := TX1; FQuad.V[0].TY := TY1;
    FQuad.V[1].TX := TX2; FQuad.V[1].TY := TY1;
    FQuad.V[2].TX := TX2; FQuad.V[2].TY := TY2;
    FQuad.V[3].TX := TX1; FQuad.V[3].TY := TY2;
  end;
end;

procedure THGESprite.SetTextureRect(const X, Y, W, H: Single;
  const AdjSize: Boolean = True);
var
  TX1, TY1, TX2, TY2: Single;
  BX, BY, BHS: Boolean;
begin
  FTX := X;
  FTY := Y;
  if (AdjSize) then begin
    FWidth := W;
    FHeight := H;
  end;

  TX1 := FTX / FTexWidth; TY1 := FTY / FTexHeight;
  TX2 := (FTX + W) / FTexWidth; TY2 := (FTY + H) / FTexHeight;

  FQuad.V[0].TX := TX1; FQuad.V[0].TY := TY1;
  FQuad.V[1].TX := TX2; FQuad.V[1].TY := TY1;
  FQuad.V[2].TX := TX2; FQuad.V[2].TY := TY2;
  FQuad.V[3].TX := TX1; FQuad.V[3].TY := TY2;

  BX := FXFlip; BY := FYFlip; BHS := FHSFlip;
  FXFlip := False; FYFlip := False;
  SetFlip(BX,BY,BHS);
end;

procedure THGESprite.SetZ(const Z: Single; const I: Integer);
begin
  if (I <> -1) then
    FQuad.V[I].Z := Z
  else begin
    FQuad.V[0].Z := Z;
    FQuad.V[1].Z := Z;
    FQuad.V[2].Z := Z;
    FQuad.V[3].Z := Z;
  end;
end;

initialization
  THGESprite.FHGE := nil;

end.
