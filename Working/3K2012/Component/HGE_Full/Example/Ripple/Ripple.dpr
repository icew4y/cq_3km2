program Ripple;
//---------------------------------------------------------------------------
// Asphyre example application
// Copyright (c) 2000 - 2007  Afterwarp Interactive
//---------------------------------------------------------------------------
// This demo illustrates how to render isometric terrain with variable
// height using Asphyre Compact Framework.
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
//---------------------------------------------------------------------------
{$R *.res}

uses
  Windows, Classes, SysUtils, HGEImages, HGECanvas, HGEDef, HGE, HGEFont;

type
 MapRec = record
  Heights: array[0..3] of Byte;
  Light  : array[0..3] of Byte;
 end;

 TLand = class
 private
   Wave: array[0..63, 0..63] of Real;
   function Sine(Value: Real): Real;
   procedure CalculateWave();
   procedure CalculateHeights();
 public
   XView,
   YView,
   Width,
   Height: Integer;
   XViewFloat,
   YViewFloat,
   XViewVel,
   YViewVel: Real;
   Alpha,
   Beta,
   Gamma: Real;
   Grid: Boolean;
   Map: array[0..127, 0..63] of MapRec;
   constructor Create();
   function SquareHeight(Xp, Yp, Corner: Integer): Integer;
   function SquareLight(Xp, Yp, Corner: Integer): Integer;
   procedure Render();
   procedure Process();
 end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Fnt: IHGEFont;
  Land: TLand;
  P:array[0..3] of TPoint;
  Index: Integer;

const
  Undefined= -1;
  TileWidth = 64;
  TileHeight = 32;

procedure Iso2Line(Xmap,Ymap:Integer;out Xline,Yline:Integer);
begin
  Yline:=(Ymap shr 1)-Xmap;
  Xline:=Xmap+(Ymap and 1)+(Ymap shr 1);
end;

procedure Line2Iso(Xline,Yline:Integer;out Xmap,Ymap:Integer);
begin
  Xmap:=(Xline-Yline) shr 1;
  Ymap:=Xline+Yline;
end;

procedure TileAtCoord(Xcoord,Ycoord,TileWidth,TileHeight:Integer;out Xmap,Ymap:Integer);
var Thh,Twh:Integer;
begin
  Twh:=TileWidth div 2;
  Thh:=TileHeight div 2;
  Ymap:=Ycoord div Thh;
  Xmap:=(Xcoord-((Ymap and 1)*Twh)) div TileWidth;
end;

procedure CoordAtTile(Xmap,Ymap,TileWidth,TileHeight:Integer;out Xcoord,Ycoord:Integer);
var Thh,Twh:Integer;
begin
  Twh:=TileWidth div 2;
  Thh:=TileHeight div 2;
  Ycoord:=Ymap*Thh;
  Xcoord:=(Xmap*TileWidth)+((Ymap and 1)*Twh);
end;

function cGray1(Gray: Cardinal): Cardinal;
begin
  Result:= ((Gray and $FF) or ((Gray and $FF) shl 8) or ((Gray and $FF) shl 16))
   or $FF000000;
end;

constructor TLand.Create();
begin
  inherited;
  FillChar(Map, SizeOf(Map), 0);
  Width:= 64;
  Height:= 128;
  XView:= 1280;
  YView:= 768;
  XViewFloat:= 1280;
  YViewFloat:= 768;
  XViewVel:= 0;
  YViewVel:= 0;
  Alpha:= 0;
  Beta:= 0;
  Gamma:= 0;
  CalculateWave();
  CalculateHeights();
end;

function TLand.Sine(Value: Real): Real;
begin
  Result:= (Sin(Value * pi) + 1) / 2;
end;

procedure TLand.CalculateWave();
var
 i, j: Integer;
begin
  for j:= 0 to 63 do
    for i:= 0 to 63 do
     Wave[j, i]:= Sine((i / 8) + Alpha) + (Sine((i / 4) + Beta) / 2) + (Sine((j / 16) + Gamma) / 2);
end;

procedure TLand.CalculateHeights();
var
 i, j, DeltaX, Value, Light, x, y: Integer;
begin
  for j:= 1 to Height - 2 do
    for i:= 1 to Width - 2 do
    begin
      DeltaX:= 1 - (j and $01);
      Iso2Line(I, j + 64, x, y);
      x:= x - 64;
      if (x >= 0)and(y >= 0)and(x < 64)and(y < 64) then
      begin
        Value:= Round(Wave[y, x] * 96) + 32;
      end else Value:= 0;

      Light:= Value;
      if (Light > 255) then Light:= 255;
      Map[j, i].Heights[0]:= Value;
      Map[j, i].Light[0]:= Light;
      Map[j + 1, i - DeltaX].Heights[1]:= Value;
      Map[j + 1, i - DeltaX].Light[1]:= Light;
      Map[j - 1, i - DeltaX].Heights[2]:= Value;
      Map[j - 1, i - DeltaX].Light[2]:= Light;
      Map[j, i - 1].Heights[3]:= Value;
      Map[j, i - 1].Light[3]:= Light;
    end;
end;

function TLand.SquareHeight(Xp, Yp, Corner: Integer): Integer;
begin
  if (Xp < 0) then Xp:= 0;
  if (Yp < 0) then Yp:= 0;
  if (Xp > Width - 1) then Xp:= Width - 1;
  if (Yp > Height - 1) then Yp:= Height - 1;
  Result:= Map[Yp,Xp].Heights[Corner];
end;

function TLand.SquareLight(Xp, Yp, Corner: Integer): Integer;
begin
  if (Xp < 0) then Xp:=0;
  if (Yp < 0) then Yp:=0;
  if (Xp > Width - 1) then Xp:= Width - 1;
  if (Yp > Height - 1) then Yp:= Height - 1;
  Result:= cGray1(Map[Yp , Xp].Light[Corner]);
end;


procedure TLand.Render();
var
 x, y, Xpos, Ypos, XposAdd, XMap, YMap, TileHWidth, TileHHeight: Integer;
begin
  TileHWidth:= TileWidth div 2;
  TileHHeight:= TileHeight div 2;
  // render tiles
  for Y:= -1 to (600 div TileHHeight) + 14 do
  begin
   Ymap:= (YView div TileHHeight) + Y;
   Ypos:= (Ymap * TileHHeight) - YView - TileHHeight;
   XposAdd:= ((Ymap and $01) * TileHWidth) - XView - TileHWidth;
   for X:= -1 to (800 div TileWidth) + 2 do
    begin
     Xmap:= (XView div TileWidth) + X;
     Xpos:= (Xmap * TileWidth) + XposAdd;

     if (Xmap >= 0)and(Ymap >= 0)and(Xmap < Width)and(Ymap < Height)and(Map[Ymap, Xmap].Light[0] > 0)
        and(Map[Ymap, Xmap].Light[1] > 0)and(Map[Ymap, Xmap].Light[2] > 0)and(Map[Ymap, Xmap].Light[3] > 0) then
      begin
       Canvas.Draw4V(Images.Image['Tile'], Index, Xpos, (Ypos + TileHHeight) - SquareHeight(Xmap, Ymap,0),
                                   Xpos + TileHWidth, Ypos - SquareHeight(Xmap, Ymap, 1),
                                   Xpos + TileWidth, (Ypos + TileHHeight) - SquareHeight(Xmap,Ymap,3),
                                   Xpos + TileHWidth, (Ypos + TileHeight) - SquareHeight(Xmap,Ymap,2),
                                   False,False,
                                   SquareLight(Xmap,Ymap,0), SquareLight(Xmap,Ymap,1),
                                   SquareLight(Xmap,Ymap,3), SquareLight(Xmap,Ymap,2), Blend_Bright);
       end;
    end;{ for X:=-1 to ... }
  end;{ for Y:=-1 to ... }
 // render grid

 for Y:=-1 to (600 div TileHHeight) + 14 do
  begin
   Ymap:= (YView div TileHHeight) + Y;
   Ypos:= (Ymap * TileHHeight) - YView - TileHHeight;
   XposAdd:= ((Ymap and $01) * TileHWidth) - XView - TileHWidth;
   for X:= -1 to (800 div TileWidth) + 2 do
    begin
     Xmap:= (XView div TileWidth) + X;
     Xpos:= (Xmap * TileWidth) + XposAdd;

     if (Xmap >= 0)and(Ymap >= 0)and(Xmap < Width)and(Ymap < Height)and(Map[Ymap, Xmap].Light[0] > 0)
        and(Map[Ymap, Xmap].Light[1] > 0)and(Map[Ymap, Xmap].Light[2] > 0)and(Map[Ymap, Xmap].Light[3] > 0) then
      begin
        P[0]:= Point(Xpos, (Ypos + TileHHeight) - SquareHeight(Xmap, Ymap,0) - 4);
        P[1]:= Point(Xpos + TileHWidth, Ypos - SquareHeight(Xmap, Ymap, 1) - 4);
        P[2]:= Point(Xpos + TileWidth, (Ypos + TileHHeight) - SquareHeight(Xmap,Ymap,3) - 4 );
        P[3]:= Point(Xpos + TileHWidth, (Ypos + TileHeight) - SquareHeight(Xmap,Ymap,2) - 4);
       if (Grid) then
       HGE.Polygon(P,$FFFFFFFF, False);

     end;
    end;{ for X:=-1 to ... }
  end;{ for Y:=-1 to ... }

end;

procedure TLand.Process();
begin
 if (XViewVel > 8) then XViewVel:= 8;
 if (YViewVel > 8) then YViewVel:= 8;
 if (XViewVel < -8) then XViewVel:= -8;
 if (YViewVel < -8) then YViewVel:= -8;

 XViewFloat:= XViewFloat + XViewVel;
 YViewFloat:= YViewFloat + YViewVel;

 if (Abs(XViewVel) < 0.3) then XViewVel:= 0;
 if (Abs(YViewVel) < 0.3) then YViewVel:= 0;
 if (XViewVel > 0) then XViewVel:= XViewVel - 0.5;
 if (YViewVel > 0) then YViewVel:= YViewVel - 0.5;
 if (XViewVel < 0) then XViewVel:= XViewVel + 0.5;
 if (YViewVel < 0) then YViewVel:= YViewVel + 0.5;

 XView:= Round(XViewFloat);
 YView:= Round(YViewFloat);
 
 Alpha:= Alpha - 0.02;
 Beta:= Beta - 0.0257;
 Gamma:= Gamma - 0.033;

 CalculateWave();
 CalculateHeights();
end;

function FrameFunc: Boolean;
begin
  Land.Process;
  if HGE.Input_KeyDown(HGEK_C) then
     Inc(Index);
  if HGE.Input_KeyDown(HGEK_G) then
     Land.Grid := not Land.Grid;
  if Index > 2 then Index:=0;
  if HGE.Input_GetKeyState(HGEK_UP) then
     Land.YViewVel :=   Land.YViewVel- 3;
  if HGE.Input_GetKeyState(HGEK_Down) then
     Land.YViewVel :=   Land.YViewVel + 3;
  if HGE.Input_GetKeyState(HGEK_Left) then
     Land.XViewVel :=   Land.XViewVel - 3;
  if HGE.Input_GetKeyState(HGEK_Right) then
     Land.XViewVel :=   Land.XViewVel + 3;
  case HGE.Input_GetKey of

    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      FreeAndNil(Land);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function RenderFunc: Boolean;
begin
  HGE.Gfx_BeginScene;
  HGE.Gfx_Clear(0);
  Land.Render;
  Fnt.PrintF(250,500, HGETEXT_LEFT, 'Arrow Key: Move Screen',[]);
  Fnt.PrintF(250,530, HGETEXT_LEFT, 'C: Change Texture',[]);
  Fnt.PrintF(250,560, HGETEXT_LEFT, 'G: Show Grid ON/OFF',[]);
  HGE.Gfx_EndScene;
  Result := False;
end;

procedure Main;
begin
  HGE := HGECreate(HGE_VERSION);
  HGE.System_SetState(HGE_FRAMEFUNC,FrameFunc);
  HGE.System_SetState(HGE_RENDERFUNC,RenderFunc);
  HGE.System_SetState(HGE_USESOUND, False);
  HGE.System_SetState(HGE_WINDOWED,False);
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP,32);
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;
  Land := TLand.Create;
  Land.XViewFloat:=200;
  Land.YViewFloat:=600;
  if (HGE.System_Initiate) then
  begin
    Fnt := THGEFont.Create('Font1.fnt');
    Images.LoadFromFile('Tile.png',64,64);
    HGE.System_Start;
  end
  else
    MessageBox(0,PChar(HGE.System_GetErrorMessage),'Error',MB_OK or MB_ICONERROR or MB_SYSTEMMODAL);

  HGE.System_Shutdown;
  HGE := nil;
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  Main;
end.
