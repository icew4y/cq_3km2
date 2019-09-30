unit HGEAnim;
(*
** Haaf's Game Engine 1.7
** Copyright (C) 2003-2007, Relish Games
** hge.relishgames.com
**
** Delphi conversion by Erik van Bilsen
**
** NOTE: The Delphi version uses a public IHGEAnimation interface instead of a
** class (more conform the main IHGE interface).
*)

interface

uses
  HGE, HGESprite;

(****************************************************************************
 * HGEAnim.h
 ****************************************************************************)

const
  HGEANIM_FWD = 0;
  HGEANIM_REV = 1;
  HGEANIM_PINGPONG = 2;
  HGEANIM_NOPINGPONG = 0;
  HGEANIM_LOOP = 4;
  HGEANIM_NOLOOP = 0;

type
  IHGEAnimation = interface(IHGESprite)
  ['{F11760E2-A61B-4A09-AFEA-72D31E7E17DE}']
    procedure Play;
    procedure Stop;
    procedure Resume;
    procedure Update(const DeltaTime: Single);
    function IsPlaying: Boolean;

    procedure SetTexture(const Tex: ITexture);
    procedure SetTextureRect(const X, Y, W, H: Single);
    procedure SetMode(const Mode: Integer);
    procedure SetSpeed(const FPS: Single);
    procedure SetFrame(const N: Integer);
    procedure SetFrames(const N: Integer);

    function GetMode: Integer;
    function GetSpeed: Single;
    function GetFrame: Integer;
    function GetFrames: Integer;
  end;

type
  THGEAnimation = class(THGESprite,IHGEAnimation)
  private
    procedure AnimationSetTextureRect(const X, Y, W, H: Single);
  protected
    { IHGEAnimation }
    procedure Play;
    procedure Stop;
    procedure Resume;
    procedure Update(const DeltaTime: Single);
    function IsPlaying: Boolean;

    procedure SetTexture(const Tex: ITexture);
    procedure IHGEAnimation.SetTextureRect = AnimationSetTextureRect;
    procedure SetMode(const Mode: Integer);
    procedure SetSpeed(const FPS: Single);
    procedure SetFrame(const N: Integer);
    procedure SetFrames(const N: Integer);

    function GetMode: Integer;
    function GetSpeed: Single;
    function GetFrame: Integer;
    function GetFrames: Integer;
  private
    FOrigWidth: Integer;
    FPlaying: Boolean;
    FSpeed: Single;
    FSinceLastFrame: Single;
    FMode: Integer;
    FDelta: Integer;
    FFrames: Integer;
    FCurFrame: Integer;
  public
    constructor Create(const Texture: ITexture; const NFrames: Integer;
      const FPS: Single; const X, Y, W, H: Single); overload;
    constructor Create(const Anim: IHGEAnimation); overload;
  end;

implementation

(****************************************************************************
 * HGEAnim.h, HGEAnim.cpp
 ****************************************************************************)

{ THGEAnimation }

procedure THGEAnimation.AnimationSetTextureRect(const X, Y, W, H: Single);
begin
  inherited;
  SetFrame(FCurFrame);
end;

constructor THGEAnimation.Create(const Texture: ITexture;
  const NFrames: Integer; const FPS, X, Y, W, H: Single);
begin
  inherited Create(Texture,X,Y,W,H);
  FOrigWidth := Texture.GetWidth(True);
  FSinceLastFrame := -1;
  FSpeed := 1 / FPS;
  FFrames := NFrames;
  FMode := HGEANIM_FWD or HGEANIM_LOOP;
  FDelta := 1;
  SetFrame(0);
end;

constructor THGEAnimation.Create(const Anim: IHGEAnimation);
begin
  inherited Create(Anim);
end;

function THGEAnimation.GetFrame: Integer;
begin
  Result := FCurFrame;
end;

function THGEAnimation.GetFrames: Integer;
begin
  Result := FFrames;
end;

function THGEAnimation.GetMode: Integer;
begin
  Result := FMode;
end;

function THGEAnimation.GetSpeed: Single;
begin
  Result := 1 / FSpeed;
end;

function THGEAnimation.IsPlaying: Boolean;
begin
  Result := FPlaying;
end;

procedure THGEAnimation.Play;
begin
  FPlaying := True;
  FSinceLastFrame := -1;
  SetMode(FMode);
end;

procedure THGEAnimation.Resume;
begin
  FPlaying := True;
end;

procedure THGEAnimation.SetFrame(const N: Integer);
var
  TX1, TY1, TX2, TY2: Single;
  XF, YF, HS: Boolean;
  NCols, I: Integer;
begin
  NCols := FOrigWidth div Trunc(Width);
  FCurFrame := N mod FFrames;
  if (FCurFrame < 0) then
    FCurFrame := FFrames + FCurFrame;

  // calculate texture coords for frame n
  TY1 := TY;
  TX1 := TX + FCurFrame * Width;
  if (TX1 > FOrigWidth - Width) then begin
    I := FCurFrame - (Trunc(FOrigWidth - TX) div Trunc(Width));
    TX1 := Width * (I mod NCols);
    TY1 := TY1 + (Height * (1 + (I div NCols)));
  end;

  TX2 := TX1 + Width;
  TY2 := TY1 + Height;

  TX1 := TX1 / TexWidth;
  TY1 := TY1 / TexHeight;
  TX2 := TX2 / TexWidth;
  TY2 := TY2 / TexHeight;

  FQuad.V[0].TX := TX1; FQuad.V[0].TY := TY1;
  FQuad.V[1].TX := TX2; FQuad.V[1].TY := TY1;
  FQuad.V[2].TX := TX2; FQuad.V[2].TY := TY2;
  FQuad.V[3].TX := TX1; FQuad.V[3].TY := TY2;

  XF := XFlip; YF := YFlip; HS := HSFlip;
  XFlip := False; YFlip := False;
  SetFlip(XF,YF,HS);
end;

procedure THGEAnimation.SetFrames(const N: Integer);
begin
  FFrames := N;
end;

procedure THGEAnimation.SetMode(const Mode: Integer);
begin
  FMode := Mode;
  if ((FMode and HGEANIM_REV) <> 0) then begin
    FDelta := -1;
    SetFrame(FFrames - 1);
  end else begin
    FDelta := 1;
    SetFrame(0);
  end;
end;

procedure THGEAnimation.SetSpeed(const FPS: Single);
begin
  FSpeed := 1 / FPS;
end;

procedure THGEAnimation.SetTexture(const Tex: ITexture);
begin
  inherited;
  FOrigWidth := Tex.GetWidth(True);
end;

procedure THGEAnimation.Stop;
begin
  FPlaying := False;
end;

procedure THGEAnimation.Update(const DeltaTime: Single);
begin
  if (not FPlaying) then
    Exit;

  if (FSinceLastFrame = -1) then
    FSinceLastFrame := 0
  else
    FSinceLastFrame := FSinceLastFrame + DeltaTime;

  while (FSinceLastFrame >= FSpeed) do begin
    FSinceLastFrame := FSinceLastFrame - FSpeed;

    if (FCurFrame + FDelta = FFrames) then begin
      case FMode of
        HGEANIM_FWD,
        HGEANIM_REV or HGEANIM_PINGPONG:
          FPlaying := False;
        HGEANIM_FWD or HGEANIM_PINGPONG,
        HGEANIM_FWD or HGEANIM_PINGPONG or HGEANIM_LOOP,
        HGEANIM_REV or HGEANIM_PINGPONG or HGEANIM_LOOP:
          FDelta := -FDelta;
      end;
    end else if (FCurFrame + FDelta < 0) then begin
      case FMode of
        HGEANIM_REV,
        HGEANIM_FWD or HGEANIM_PINGPONG:
          FPlaying := False;
        HGEANIM_REV or HGEANIM_PINGPONG,
        HGEANIM_REV or HGEANIM_PINGPONG or HGEANIM_LOOP,
        HGEANIM_FWD or HGEANIM_PINGPONG or HGEANIM_LOOP:
          FDelta := -FDelta;
      end;
    end;

    if (FPlaying) then
      SetFrame(FCurFrame + FDelta);
  end;
end;

end.
