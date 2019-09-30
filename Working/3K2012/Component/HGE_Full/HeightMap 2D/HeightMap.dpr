program HeightMap;

{$R *.res}

uses
  Windows,  SysUtils,  Classes,  HGEImages,  HGECanvas, HGEDef,
  MMSystem, Math, HGE;

const
  MAPXSIZE = 100; MAPYSIZE = 120;
  ROCKPIC = 1; GRASSPIC = 0; WATERPIC = 2;
  MUDPIC = 3; GRASSPIC2 = 4;
  BACKMUD = 6; playerPIC = 7; PALMPIC = 8;

  NUMLAYERS = 5; // only using 4 at the moment
  e = 230; // the normal darkness level. Make your textures quite bright and it works fine
  SCRWIDTH = 800;
  SCRHEIGHT = 600;

type
  Tcell = record
    Alpha: Integer;
    PicNumber: Integer;
    CellNumber: Integer;
  end;

  TPlanes = record
    Plane: array[0..MAPXSIZE + 1, 0..MAPYSIZE + 1] of Tcell;
    CurrentImage: Integer;
  end;

  TMapInfo = record
      { Following three affect all layers equally }
    Ph: array[0..MAPXSIZE + 1, 0..MAPYSIZE + 1] of Integer; // height of the vertices
    Darkness: array[0..MAPXSIZE + 1, 0..MAPYSIZE + 1] of Integer; // darkness of the vertices
    ContainsObject: array[0..MAPXSIZE + 1, 0..MAPYSIZE + 1] of Boolean; // Does this tile have an object, then seacrh wich one
    ExternalLight: array[0..MAPXSIZE + 1, 0..MAPYSIZE + 1] of Integer; // Add to darkness calculations

    Layers: array[1..NUMLAYERS] of TPlanes; // 1 rock, 2 grass, 3 dirt, 4 objects, 5 canopy
    CurrentLayer: Integer; // 1..5
    ShowCursorTime: Cardinal;
    EditTimer: Cardinal; // prevent from editing too quickly
    Cutoff: Integer; // point at what alpha to start drawing. Setting it high prevents drawing speeding up gfx
  end;
  // probably better to have polayer as another object in the ObjectList
  TPlayer = record
    Tx, Ty: Integer;
    Fx, Fy: real;
    PicNum: Integer;
    CellPic: Integer;
    CellReal: Double;
    Anim: Cardinal;
    HasNotDrawnThisFrame: Boolean; //only update player once, even though he has to drawn a few times each frame
    MoveDir: Integer; //0,1,2,3,4 still, east, south, west, north
  end;
  // Like trees etc
  TGroundObject = class
    Tx, Ty: Integer;
    Fx, Fy: Integer;
    PicNum: Integer;
    CellPic: Integer;
  end;

var
  HGE: IHGE = nil;
  Images: THGEimages;
  Canvas: THGECanvas;
  Font: TSysFont;
  CellX, CellY: Integer; // where mouse cursor is
  Blendmode: Integer;
  MapInfo: TMapInfo; // contains all the map information
  PlateauHeight: Integer; //
  LEFTOFFSET: Double; // Where left and top of the world is
  TOPOFFSET: Double;
  TileWidth: Integer; // size of tiles
  TileHeight: Integer;
  Player: TPlayer;
  ShowCheckers: Boolean; // checker mode
  ObjectList: Tlist; // contains the trees
  ObjectInst: TGroundObject;
  MouseX, MouseY: Single;
  Event:THGEInputEvent;

function Dan_Limit(Num, Min, Max: Integer): Integer;
begin
  if Num < Min then Result := Min
  else if Num > Max then Result := Max
  else Result := Num;
end;

procedure CentrePlayer;
begin
    // move the world and keep the player centred
  LEFTOFFSET := -1 * (Player.Tx * TileWidth) + 400 - (Player.Fx);
  TOPOFFSET := -1 * (Player.Ty * TileHeight) + 300 - (Player.Fy);
end;

procedure DoMouseAndKeyboard;
var
  deltaX, deltaY: Double; // speed at which player moves
  StdSpeed: Integer; // pixels per second
  OldFx, OldFy: Double; // Starting pos on tile. Go back if illegal move
begin

  Player.MoveDir := 0;
  if HGE.Input_GetKeyState(HGEK_UP) or
    HGE.Input_GetKeyState(HGEK_LEFT) or
    HGE.Input_GetKeyState(HGEK_RIGHT) or
    HGE.Input_GetKeyState(HGEK_DOWN) then
  begin
    StdSpeed := 1; // speed of the player
    deltaX := (StdSpeed) * 5; // the size of the movement based on speed of rendering
    deltaY := (StdSpeed) * 5; // run slower up teh screen

    OldFx := Player.Fx;
    OldFy := Player.Fy;
    if HGE.Input_GetKeyState(HGEK_RIGHT) then begin Player.Fx := Trunc(Player.Fx + deltaX); Player.MoveDir := 1; end;
    if HGE.Input_GetKeyState(HGEK_LEFT) then begin Player.Fx := Trunc(Player.Fx - deltaX); Player.MoveDir := 3; end;
    if HGE.Input_GetKeyState(HGEK_UP) then begin Player.Fy := Trunc(Player.Fy - deltaY); Player.MoveDir := 4; end;
    if HGE.Input_GetKeyState(HGEK_DOWN) then begin Player.Fy := Trunc(Player.Fy + deltaY); Player.MoveDir := 2; end;
    // don't go over the bounds of the map
    if (Player.Fx < 0) and (Player.Tx <= 1) then Player.Fx := OldFx;
    if (Player.Fx >= TileWidth - 1) and (Player.Tx >= MAPXSIZE - 2) then Player.Fx := OldFx;
    if (Player.Fy < 0) and (Player.Ty <= 4) then Player.Fy := OldFy;
    if (Player.Fy >= TileHeight - 1) and (Player.Ty >= MAPYSIZE - 5) then Player.Fy := OldFy;

   //  if tile goes off the tile then recalculate what tile they are in
   //  and change the fine X and Y coordinates within that new tile
    if (Player.Fx >= TileWidth - 1) or (Player.Fx < 0) then
    begin
      Player.Tx := ((Player.Tx * TileWidth) + Trunc(Player.Fx)) div TileWidth;

      if (Player.Fx >= TileWidth) then Player.Fx := Player.Fx - TileWidth
      else
        if (Player.Fx < 0) then Player.Fx := Player.Fx + TileWidth;
    end;
   // if the fine Y coord goes off the tile
   // recalculate the the actual tile that the player is in
   // and reset the fine Y coord
    if (Player.Fy >= TileHeight) or (Player.Fy < 0) then
    begin
      Player.Ty := (((Player.Ty * TileHeight) + Trunc(Player.Fy)) div TileHeight);
      if (Player.Fy >= TileHeight) then Player.Fy := Player.Fy - TileHeight
      else
        if (Player.Fy < 0) then Player.Fy := Player.Fy + TileHeight;
    end;
    CentrePlayer;
  end; //  if OmegaInput1.Keyboard.States <> [] then

 // shift the screen around with the mouse
  if MouseX < (10) then LEFTOFFSET := LEFTOFFSET + 20;
  if MouseX > (SCRWIDTH - 10) then LEFTOFFSET := LEFTOFFSET - 20;
  if MouseY < (10) then TOPOFFSET := TOPOFFSET + 20;
  if MouseY > (SCRHEIGHT - 10) then TOPOFFSET := TOPOFFSET - 20;

  // work out where left and top of the world is
  if LEFTOFFSET > 0 then LEFTOFFSET := 0;
  if TOPOFFSET > -120 then TOPOFFSET := -120;
  if TOPOFFSET < -1 * ((TileHeight * MAPYSIZE) - (SCRHEIGHT + 60)) then TOPOFFSET := -1 * ((TileHeight * MAPYSIZE) - (SCRHEIGHT + 60));
  if LEFTOFFSET < -1 * ((TileWidth * MAPXSIZE) - (SCRWIDTH + 60)) then LEFTOFFSET := -1 * ((TileWidth * MAPXSIZE) - (SCRWIDTH + 60));
end;

function DrawLowerRocks(X, Y, PosX, PosY, dk1, dk2, dk3, dk4: Integer): Boolean; // true is did draw
var
  a, b, c, d: Integer;
begin
  Result := False;
  if (PosY - MapInfo.Ph[X, Y] > SCRHEIGHT) or (PosY + TileHeight - MapInfo.Ph[X, Y + 1] < -30) then exit;

  if (MapInfo.Layers[1].Plane[X, Y].Alpha > 1) then // alpha value higher than zero, i.e. does layer contain visible info?
  begin
    a := MapInfo.Layers[1].Plane[X, Y].Alpha; // get the alpha values for these vertices
    b := MapInfo.Layers[1].Plane[X + 1, Y].Alpha;
    c := MapInfo.Layers[1].Plane[X + 1, Y + 1].Alpha;
    d := MapInfo.Layers[1].Plane[X, Y + 1].Alpha;

    Canvas.Draw4V(Images[MapInfo.Layers[1].Plane[X, Y].PicNumber],
      MapInfo.Layers[1].Plane[X, Y].CellNumber,
      PosX, PosY - MapInfo.Ph[X, Y],
      PosX + TileWidth, PosY - MapInfo.Ph[X + 1, Y],
      PosX + TileWidth, PosY + TileHeight - MapInfo.Ph[X + 1, Y + 1],
      PosX, PosY + TileHeight - MapInfo.Ph[X, Y + 1],
      False, False,
      ARGB(a, dk1, dk1, dk1),
      ARGB(b, dk2, dk2, dk2),
      ARGB(c, dk3, dk3, dk3),
      ARGB(d, dk4, dk4, dk4),
      Blend_Default);
  end;
  Result := True;
end;

procedure DrawGrass1(X, Y, PosX, PosY, dk1, dk2, dk3, dk4: Integer);
var
  a, b, c, d: Integer;
begin
  if (PosY - MapInfo.Ph[X, Y] > SCRHEIGHT) or (PosY + TileHeight - MapInfo.Ph[X, Y + 1] < -30) then exit;

  if (MapInfo.Layers[2].Plane[X, Y].Alpha > MapInfo.Cutoff) then // alpha value higher than zero, i.e. does layer contain visible info?
  begin
    a := MapInfo.Layers[2].Plane[X, Y].Alpha; // get the alpha values for these vertices
    b := MapInfo.Layers[2].Plane[X + 1, Y].Alpha;
    c := MapInfo.Layers[2].Plane[X + 1, Y + 1].Alpha;
    d := MapInfo.Layers[2].Plane[X, Y + 1].Alpha;

      Canvas.Draw4V(Images[MapInfo.Layers[2].Plane[X, Y].PicNumber],
      MapInfo.Layers[2].Plane[X, Y].CellNumber,
      PosX, PosY - MapInfo.Ph[X, Y],
      PosX + TileWidth, PosY - MapInfo.Ph[X + 1, Y],
      PosX + TileWidth, PosY + TileHeight - MapInfo.Ph[X + 1, Y + 1],
      PosX, PosY + TileHeight - MapInfo.Ph[X, Y + 1],
      False, False,
      ARGB(a, dk1, dk1, dk1),
      ARGB(b, dk2, dk2, dk2),
      ARGB(c, dk3, dk3, dk3),
      ARGB(d, dk4, dk4, dk4),
      Blend_Default);
  end;
end;

procedure DrawWater(X, Y, PosX, PosY, dk1, dk2, dk3, dk4: Integer);
var
  a, b, c, d: Integer;
begin
  if (PosY - MapInfo.Ph[X, Y] > SCRHEIGHT) or (PosY + TileHeight - MapInfo.Ph[X, Y + 1] < -30) then exit;

  if (MapInfo.Layers[3].Plane[X, Y].Alpha > MapInfo.Cutoff) then // alpha value higher than zero, i.e. does layer contain visible info?
  begin
    a := MapInfo.Layers[3].Plane[X, Y].Alpha; // get the alpha values for these vertices
    b := MapInfo.Layers[3].Plane[X + 1, Y].Alpha;
    c := MapInfo.Layers[3].Plane[X + 1, Y + 1].Alpha;
    d := MapInfo.Layers[3].Plane[X, Y + 1].Alpha;
    // the actual drawing of tiles
      Canvas.Draw4V(Images[MapInfo.Layers[3].Plane[X, Y].PicNumber],
      MapInfo.Layers[3].Plane[X, Y].CellNumber,
      PosX, PosY - MapInfo.Ph[X, Y],
      PosX + TileWidth, PosY - MapInfo.Ph[X + 1, Y],
      PosX + TileWidth, PosY + TileHeight - MapInfo.Ph[X + 1, Y + 1],
      PosX, PosY + TileHeight - MapInfo.Ph[X, Y + 1],
      False, False,
      ARGB(a, dk1, dk1, dk1),
      ARGB(b, dk2, dk2, dk2),
      ARGB(c, dk3, dk3, dk3),
      ARGB(d, dk4, dk4, dk4),
      Blend_Default);
  end;
end;

procedure DrawMud(X, Y, PosX, PosY, dk1, dk2, dk3, dk4: Integer);
var
  a, b, c, d: Integer;
begin
  if (PosY - MapInfo.Ph[X, Y] > SCRHEIGHT) or (PosY + TileHeight - MapInfo.Ph[X, Y + 1] < -30) then exit;

  if (MapInfo.Layers[4].Plane[X, Y].Alpha > MapInfo.Cutoff) then // alpha value higher than zero, i.e. does layer contain visible info?
  begin
    a := MapInfo.Layers[4].Plane[X, Y].Alpha; // get the alpha values for these vertices
    b := MapInfo.Layers[4].Plane[X + 1, Y].Alpha;
    c := MapInfo.Layers[4].Plane[X + 1, Y + 1].Alpha;
    d := MapInfo.Layers[4].Plane[X, Y + 1].Alpha;
    // the actual drawing of tiles
      Canvas.Draw4V(Images[MapInfo.Layers[4].Plane[X, Y].PicNumber],
      MapInfo.Layers[4].Plane[X, Y].CellNumber,
      PosX, PosY - MapInfo.Ph[X, Y],
      PosX + TileWidth, PosY - MapInfo.Ph[X + 1, Y],
      PosX + TileWidth, PosY + TileHeight - MapInfo.Ph[X + 1, Y + 1],
      PosX, PosY + TileHeight - MapInfo.Ph[X, Y + 1],
      False, False,
      ARGB(a, dk1, dk1, dk1),
      ARGB(b, dk2, dk2, dk2),
      ARGB(c, dk3, dk3, dk3),
      ARGB(d, dk4, dk4, dk4),
      Blend_Default);
   end;
end;
// checker mode

procedure DrawCheckers(X, Y, PosX, PosY, dk1, dk2, dk3, dk4: Integer);
var
  a, b, c, d: Integer;
begin
  if (MapInfo.Layers[5].Plane[X, Y].Alpha > 10) then // alpha value higher than zero, i.e. does layer contain visible info?
  begin
    a := MapInfo.Layers[5].Plane[X, Y].Alpha; // get the alpha values for these vertices
    b := MapInfo.Layers[5].Plane[X + 1, Y].Alpha;
    c := MapInfo.Layers[5].Plane[X + 1, Y + 1].Alpha;
    d := MapInfo.Layers[5].Plane[X, Y + 1].Alpha;

    // the actual drawing of tiles

     Canvas.Draw4V(Images[MapInfo.Layers[5].Plane[X, Y].PicNumber],
      MapInfo.Layers[5].Plane[X, Y].CellNumber,
      PosX, PosY - MapInfo.Ph[X, Y],
      PosX + TileWidth, PosY - MapInfo.Ph[X + 1, Y],
      PosX + TileWidth, PosY + TileHeight - MapInfo.Ph[X + 1, Y + 1],
      PosX, PosY + TileHeight - MapInfo.Ph[X, Y + 1],
      False, False,
      ARGB(a, dk1, dk1, dk1),
      ARGB(b, dk2, dk2, dk2),
      ARGB(c, dk3, dk3, dk3),
      ARGB(d, dk4, dk4, dk4),
      Blend_Default);
  end;
end;

//------------------------------------------------------------------------------
// GetplayerPosition     (Codetapper)
//
// tL = Height at top left vertex
// tR = Height at top right vertex
// bL = Height at bottom left vertex
// bR = Height at bottom right vertex
// percX = Percentage in from the left of the tile (range 0 - 1)
// percY = Percentage down from the top of the tile (range 0 - 1)
// TileWidth = Gap between each tile (horizontally)
// TileDepth = Gap between each tile (backwards, into the screen)
//------------------------------------------------------------------------------
procedure GetplayerPosition(tL, tR, bL, bR: Double; percX, PercY: Double; var newX, newY: Integer);
var
  bXMidpoint, tXMidpoint: real; HeightMidpoint: Integer;
begin
  tXMidpoint := tL + (percX * (tR - tL));
  bXMidpoint := bL + (percX * (bR - bL));
  HeightMidpoint := Round(tXMidpoint + (PercY * (bXMidpoint - tXMidpoint)));

  newX := Round(percX * TileWidth);
  newY := HeightMidpoint;
end;

//------------------------------------------------------------------------------
// draw the player
//------------------------------------------------------------------------------

procedure Drawplayer(X, Y: Integer; PosX, PosY: Integer);
var
  vertex: array[1..4] of Double;
  PercentageDownTile, PercentageAcrossTile: Double;
begin
  PercentageDownTile := (Player.Fy / TileHeight);
  PercentageAcrossTile := (Player.Fx / TileWidth);

  vertex[1] := PosY - MapInfo.Ph[X, Y];
  vertex[2] := PosY - MapInfo.Ph[X + 1, Y];
  vertex[3] := PosY + TileHeight - MapInfo.Ph[X + 1, Y + 1];
  vertex[4] := PosY + TileHeight - MapInfo.Ph[X, Y + 1];

  GetplayerPosition(vertex[1], vertex[2], vertex[4], vertex[3], PercentageAcrossTile, PercentageDownTile, PosX, PosY);
  PosX := PosX + Trunc(LEFTOFFSET + (X * TileWidth));

  if (Player.MoveDir <> 0) and (Player.HasNotDrawnThisFrame) then
  begin
    Player.HasNotDrawnThisFrame := False;
    Player.Anim := timeGetTime + 10;

     // update the animation of player. Double makes for smoother animation
    Player.CellReal := Player.CellReal + (0.55);
    if Player.CellReal > Images.Items[Player.PicNum].PatternCount - 1 then Player.CellReal := frac(Player.CellReal); // - OmegaImageList1.ImageList.Items[player.picnum].NumOfColumns-2;
    Player.CellPic := Trunc(Player.CellReal);

    case Player.MoveDir of
      1: Player.PicNum := 9;
      2: Player.PicNum := 10;
      3: Player.PicNum := 11;
      4: Player.PicNum := 12;
    end; // case
    
    if ShowCheckers then Player.PicNum := playerPIC;
  end
  else // if standing still show end cell
    if Player.MoveDir = 0 then Player.CellPic := Images.Items[Player.PicNum].PatternCount; // OmegaImageList1.ImageList.Items[Player.picnum].NumOfColumns - 1;}

  if not ShowCheckers then // i.e drawing the landscape
  begin
   // the actual drawing of tiles
   // draw shadow

     Canvas.Draw4V(Images[Player.PicNum],
      Player.CellPic,
      PosX - 66, PosY - 40,
      PosX - 2, PosY - 40,
      PosX + 48, PosY,
      PosX, PosY,
      False, False,
      ARGB(48, 0, 0, 0),
      ARGB(48, 0, 0, 0),
      ARGB(48, 0, 0, 0),
      ARGB(48, 0, 0, 0),
      Blend_Default);
      Canvas.Draw(Images[Player.PicNum],Player.CellPic, PosX - 64, PosY - 104,Blend_Default);
  end
  else
  begin
   // the actual drawing of tiles
      Canvas.Draw4V(Images[Player.PicNum],
      Player.CellPic,
      PosX - 64, PosY - 64,
      PosX - 32, PosY - 64,
      PosX + 16, PosY,
      PosX - 16, PosY,
      False, False,
      ARGB(48,0, 0, 0),
      ARGB(48,0, 0, 0),
      ARGB(48,0, 0, 0),
      ARGB(48,0, 0, 0),
      Blend_Default);
     Canvas.Draw(Images[Player.PicNum], Player.CellPic, PosX - 16, PosY - 64, Blend_Default);
  end
end;

{
 Draw the ground objects stored in a Tlist
}

procedure DrawGroundObject(PosX, PosY, Index: Integer); // index is index of the ObjectList
begin
 //   posx := trunc(LEFTOFFSET+(x * TILEWIDTH));
 //  posy := trunc(TOPOFFSET+(y * TILEHEIGHT))-MapInfo.ph[x,y];
  if not ShowCheckers then
  begin
   // the actual drawing of tiles
      Canvas.Draw4V(Images[TGroundObject(ObjectList[Index]).PicNum],
      TGroundObject(ObjectList[Index]).CellPic,
      PosX - 70, PosY - 40,
      PosX - 6, PosY - 40,
      PosX + 64, PosY + 20,
      PosX, PosY + 20,
      False, False,
      ARGB(96, 0, 0, 0),
      ARGB(96, 0, 0, 0),
      ARGB(96, 0, 0, 0),
      ARGB(96, 0, 0, 0),
      Blend_Default);

   // the actual drawing of tiles
      Canvas.Draw4V(Images[TGroundObject(ObjectList[Index]).PicNum],
      TGroundObject(ObjectList[Index]).CellPic,
      PosX, PosY - 96,
      PosX + 64, PosY - 96,
      PosX + 64, PosY + 20,
      PosX, PosY + 20,
      False, False,
      $FFFFFFFF,
      Blend_Default);
  end
  else
  begin
   // the actual drawing of tiles
   // shadow
      Canvas.Draw4v(Images[13],
      TGroundObject(ObjectList[Index]).CellPic,
      PosX - 100, PosY - 80,
      PosX - 36, PosY - 80,
      PosX + 64, PosY + 20,
      PosX, PosY + 20,
      False, False,
      ARGB(96, 0, 0, 0),
      ARGB(96, 0, 0, 0),
      ARGB(96, 0, 0, 0),
      ARGB(96, 0, 0, 0),
      Blend_Default);

  // the actual drawing of tiles

      Canvas.Draw4V(Images[13],
      TGroundObject(ObjectList[Index]).CellPic,
      PosX, PosY - 96,
      PosX + 64, PosY - 96,
      PosX + 64, PosY + 20,
      PosX, PosY + 20,
      False, False,
      $FFFFFFFF,
      Blend_Default);
  end
end;

procedure MakeMountains;
var
  X, Y: Integer;
begin
  for X := 0 to MAPXSIZE do
    for Y := 0 to MAPYSIZE do
    begin
      if (MapInfo.Ph[X, Y] < 20) and (MapInfo.Layers[4].Plane[X, Y].Alpha > 1) then MapInfo.Layers[4].Plane[X, Y].Alpha := 30 - MapInfo.Ph[X, Y];
      if (MapInfo.Ph[X, Y] > 40) and (MapInfo.Layers[4].Plane[X, Y].Alpha > 1) then MapInfo.Layers[4].Plane[X, Y].Alpha := 100 - MapInfo.Ph[X, Y];
    //  if (MapInfo.ph[x,y]>50) and (mapinfo.layers[4].plane[x,y].alpha>1)then mapinfo.layers[4].plane[x,y].alpha := 0;//100-MapInfo.ph[x,y];

      if (MapInfo.Ph[X, Y] > 40) and (MapInfo.Layers[2].Plane[X, Y].Alpha > 1) then MapInfo.Layers[2].Plane[X, Y].Alpha := 70 - MapInfo.Ph[X, Y];

      if MapInfo.Layers[4].Plane[X, Y].Alpha < 2 then MapInfo.Layers[4].Plane[X, Y].Alpha := 1;
      if MapInfo.Layers[4].Plane[X, Y].Alpha > 255 then MapInfo.Layers[4].Plane[X, Y].Alpha := 255;

      if MapInfo.Layers[2].Plane[X, Y].Alpha < 2 then MapInfo.Layers[2].Plane[X, Y].Alpha := 1;
      if MapInfo.Layers[2].Plane[X, Y].Alpha > 255 then MapInfo.Layers[2].Plane[X, Y].Alpha := 255;
    end;
end;

procedure CalculateDarkness;
var
  i, j, k, m, cd: Integer;
begin
  for i := 0 to MAPXSIZE do
    for j := 0 to MAPYSIZE do
    begin
      MapInfo.Darkness[i, j] := 220;
    end;

  for i := 1 to MAPXSIZE - 1 do
    for j := 1 to MAPYSIZE - 1 do
    begin
      if MapInfo.Ph[i, j] > MapInfo.Ph[i - 1, j - 1] then
        MapInfo.Darkness[i - 1, j - 1] := Dan_Limit(
          MapInfo.Darkness[i - 1, j - 1] - (MapInfo.Ph[i, j] - MapInfo.Ph[i - 1, j - 1]) * 5,
          90, MapInfo.Darkness[i - 1, j - 1]);

      if MapInfo.Ph[i, j] > MapInfo.Ph[i - 1, j] then
        MapInfo.Darkness[i - 1, j] := Dan_Limit(
          MapInfo.Darkness[i - 1, j] - (MapInfo.Ph[i, j] - MapInfo.Ph[i - 1, j]) * 4,
          90, MapInfo.Darkness[i - 1, j]);

      if MapInfo.Ph[i, j] > MapInfo.Ph[i, j - 1] then
        MapInfo.Darkness[i, j - 1] := Dan_Limit(
          MapInfo.Darkness[i, j - 1] - (MapInfo.Ph[i, j] - MapInfo.Ph[i, j - 1]) * 4,
          90, MapInfo.Darkness[i, j - 1]);

      m := MapInfo.Ph[i, j];
      Inc(m, -TileHeight * 2);
      k := 2;
      while (m > TileHeight * 2) do
      begin
        cd := MapInfo.Darkness[i - k, j - k];
        if MapInfo.Ph[i, j] > MapInfo.Ph[i - k, j - k] then
          MapInfo.Darkness[i - k, j - k] := Dan_Limit(
            MapInfo.Darkness[i - k, j - k] - (MapInfo.Ph[i, j] - MapInfo.Ph[i - k, j - k]) * 5,
            Dan_Limit(90 + k * 7, 0, cd), cd);
        Inc(k);
        Inc(m, -TileHeight * 2);
      end;
    end;

  for i := 0 to MAPXSIZE do
    for j := 0 to MAPYSIZE do
    begin
      MapInfo.Darkness[i, j] := MapInfo.Darkness[i, j] + MapInfo.ExternalLight[i, j];
      if MapInfo.Darkness[i, j] > 255 then MapInfo.Darkness[i, j] := 255;
      if MapInfo.Darkness[i, j] < 1 then MapInfo.Darkness[i, j] := 1;
    end;
end;

procedure LoadMap;
var
  i, j, l: Integer;
  Stream: TFileStream;
  TempFileName, TmpStr: string[255];
begin
  if not fileexists(Lowercase(ExtractFilePath(paramstr(0))) + 'WorldMap.sav') then exit;
  TempFileName := Lowercase(ExtractFilePath(paramstr(0))) + 'WorldMap.sav';

  try
    Stream := TFileStream.Create(TempFileName, fmOpenRead);
    with Stream do
    begin
      Read(Player.Tx, SizeOf(Player.Tx));
      Read(Player.Ty, SizeOf(Player.Ty));

      for j := 0 to MAPXSIZE do // save the map
        for i := 0 to MAPXSIZE do
        begin
          for l := 1 to NUMLAYERS do
            Read(MapInfo.Layers[l].Plane[i, j], SizeOf(MapInfo.Layers[l].Plane[i, j]));
          Read(MapInfo.Ph[i, j], SizeOf(MapInfo.Ph[i, j]));
          Read(MapInfo.Darkness[i, j], SizeOf(MapInfo.Darkness[i, j]));
          Read(MapInfo.ExternalLight[i, j], SizeOf(MapInfo.ExternalLight[i, j]));
        end;

    end;
  finally
    if Stream <> nil then Stream.Free;
  end;
end;

procedure CreateGame;
var
  X, Y: Integer; a, b: Double;
begin
  TileWidth := 64;
  TileHeight := 48;

  randomize; Randseed := timeGetTime;
  PlateauHeight := -10;

  for X := 0 to MAPXSIZE do
    for Y := 0 to MAPYSIZE do
    begin
      // Set up some heights to start with
      a := (sin(DegToRad(X * 30)) * 9);
      b := (cos(DegToRad(Y * 30)) * 9);
      MapInfo.Ph[X, Y] := Round(a * b); //round(a*b)+(random(3));//*trunc(a));//PlateauHeight;//round(a*b);

      if Random(10) = 0 then
        MapInfo.Layers[2].Plane[X, Y].Alpha := 220 - (Random(50))
      else
        MapInfo.Layers[2].Plane[X, Y].Alpha := 255;

      MapInfo.Layers[1].Plane[X, Y].Alpha := 255; //-mapinfo.layer[2].plane[x,y].alpha;

      MapInfo.Layers[3].Plane[X, Y].Alpha := 0;
      MapInfo.Layers[4].Plane[X, Y].Alpha := 255;
      MapInfo.Layers[5].Plane[X, Y].Alpha := 0;

      if (X mod 2 = 0) and (Y mod 2 = 0) then
      begin
        MapInfo.Layers[5].Plane[X, Y].PicNumber := 5;
        MapInfo.Layers[5].Plane[X, Y].Alpha := 255;
      end
      else
        if (X mod 2 = 1) and (Y mod 2 = 1) then
        begin
          MapInfo.Layers[5].Plane[X, Y].PicNumber := 5;
          MapInfo.Layers[5].Plane[X, Y].Alpha := 255;
        end
        else
        begin
          MapInfo.Layers[5].Plane[X, Y].PicNumber := 6;
          MapInfo.Layers[5].Plane[X, Y].Alpha := 255;
        end;

      MapInfo.Layers[1].Plane[X, Y].PicNumber := ROCKPIC;
      MapInfo.Layers[1].Plane[X, Y].CellNumber := Random(5); ;
      MapInfo.Layers[2].Plane[X, Y].PicNumber := GRASSPIC;
      MapInfo.Layers[2].Plane[X, Y].CellNumber := Random(5);
      MapInfo.Layers[4].Plane[X, Y].PicNumber := MUDPIC;
      MapInfo.Layers[4].Plane[X, Y].CellNumber := Random(5);

      MapInfo.ContainsObject[X, Y] := False;
    end;

  MapInfo.Cutoff := 5;
  MapInfo.CurrentLayer := 2;
  MapInfo.Layers[1].CurrentImage := ROCKPIC;
  MapInfo.Layers[2].CurrentImage := GRASSPIC;
  MapInfo.Layers[3].CurrentImage := WATERPIC;
  MapInfo.Layers[4].CurrentImage := MUDPIC;
  MapInfo.Layers[5].CurrentImage := GRASSPIC2;

  Blendmode := 0;

  MakeMountains; // high mountains have layer 2 removed to expose rock

  CalculateDarkness;

  LEFTOFFSET := -500; TOPOFFSET := -500;
//  SetCursorPos(self.Left + (SCRWIDTH div 2), self.top + (SCRheight div 2));

  with Player do
  begin
    Tx := 15;
    Ty := 23;
    Fx := TileWidth div 2;
    Fy := TileHeight div 2;
    PicNum := 9;
    CellPic := 0;
    MoveDir := 0;
  end;

  ObjectList := Tlist.Create;
  for X := 1 to 200 do
  begin
    ObjectInst := TGroundObject.Create;
    with ObjectInst do
    begin
      Tx := 1 + Random(90);
      Ty := 1 + Random(90);
      PicNum := PALMPIC;
      CellPic := Random(5);
      MapInfo.ContainsObject[Tx, Ty] := True;
    end;
    ObjectList.Add(ObjectInst);
  end;
  if fileexists(Lowercase(ExtractFilePath(paramstr(0))) + 'WorldMap.sav') then LoadMap;

  CentrePlayer;
end;

procedure FreeObjects;
begin
  while ObjectList.count > 0 do
  begin
    TGroundObject(ObjectList[0]).Free;
    ObjectList.Delete(0);
  end;
  ObjectList.Free;
end;

procedure DoMouseMove;
begin
  MapInfo.ShowCursorTime := timeGetTime + 1200;
 // where is the cursor?
  CellX := Trunc((MouseX - LEFTOFFSET) / TileWidth);
  CellY := Trunc((MouseY - TOPOFFSET) / TileHeight);

  if CellX < 1 then CellX := 1;
  if CellY < 1 then CellY := 1;
  if CellX > MAPXSIZE - 1 then CellX := MAPXSIZE - 1;
  if CellY > MAPYSIZE - 1 then CellY := MAPYSIZE - 1;

 // flatten the ground
 {
  if ssshift in Shift then
  begin
    for i := CellX - 1 to CellX + 1 do
      for j := CellY - 1 to CellY + 1 do
        MapInfo.Ph[i, j] := PlateauHeight;

    CalculateDarkness;
  end
  }
end;

procedure MoveGround(MoveDown: Boolean; Cx, Cy: Integer);
begin
  if MoveDown then
  begin

    if not HGE.Input_GetKeyState(HGEK_ALT ) then // if alt is not held then do normal move down
    begin
      MapInfo.Ph[Cx - 1, Cy - 1] := MapInfo.Ph[Cx - 1, Cy - 1] - 3;
      MapInfo.Ph[Cx, Cy - 1] := MapInfo.Ph[Cx, Cy - 1] - 5;
      MapInfo.Ph[Cx + 1, Cy - 1] := MapInfo.Ph[Cx + 1, Cy - 1] - 3;

      MapInfo.Ph[Cx - 1, Cy] := MapInfo.Ph[Cx - 1, Cy] - 5;
      MapInfo.Ph[Cx, Cy] := MapInfo.Ph[Cx, Cy] - 6;
      MapInfo.Ph[Cx + 1, Cy] := MapInfo.Ph[Cx + 1, Cy] - 5;

      MapInfo.Ph[Cx - 1, Cy + 1] := MapInfo.Ph[Cx - 1, Cy + 1] - 3;
      MapInfo.Ph[Cx, Cy + 1] := MapInfo.Ph[Cx, Cy + 1] - 5;
      MapInfo.Ph[Cx + 1, Cy + 1] := MapInfo.Ph[Cx + 1, Cy + 1] - 3;

    end
    else
    begin // if alt is  held then do move down one vertix only
      MapInfo.Ph[Cx, Cy] := MapInfo.Ph[Cx, Cy] - 6;
    end;
  end
  else
  begin
    if not HGE.Input_GetKeyState(HGEK_ALT) then // if alt is not held then do normal move down
    begin
      MapInfo.Ph[Cx - 1, Cy - 1] := MapInfo.Ph[Cx - 1, Cy - 1] + 3;
      MapInfo.Ph[Cx, Cy - 1] := MapInfo.Ph[Cx, Cy - 1] + 5;
      MapInfo.Ph[Cx + 1, Cy - 1] := MapInfo.Ph[Cx + 1, Cy - 1] + 3;

      MapInfo.Ph[Cx - 1, Cy] := MapInfo.Ph[Cx - 1, Cy] + 5;
      MapInfo.Ph[Cx, Cy] := MapInfo.Ph[Cx, Cy] + 6;
      MapInfo.Ph[Cx + 1, Cy] := MapInfo.Ph[Cx + 1, Cy] + 5;

      MapInfo.Ph[Cx - 1, Cy + 1] := MapInfo.Ph[Cx - 1, Cy + 1] + 3;
      MapInfo.Ph[Cx, Cy + 1] := MapInfo.Ph[Cx, Cy + 1] + 5;
      MapInfo.Ph[Cx + 1, Cy + 1] := MapInfo.Ph[Cx + 1, Cy + 1] + 3;
    end
    else
    begin // if alt is  held then do move down one vertix only
      MapInfo.Ph[Cx, Cy] := MapInfo.Ph[Cx, Cy] + 6;
    end;
  end;
  CalculateDarkness;
end;

// for example, fog of war, the sun or clouds
procedure LightGround(Lighten: Boolean; Cx, Cy: Integer);
begin
  if Lighten then
  begin
    MapInfo.ExternalLight[Cx - 1, Cy - 1] := MapInfo.ExternalLight[Cx - 1, Cy - 1] - 3;
    MapInfo.ExternalLight[Cx, Cy - 1] := MapInfo.ExternalLight[Cx, Cy - 1] - 5;
    MapInfo.ExternalLight[Cx + 1, Cy - 1] := MapInfo.ExternalLight[Cx + 1, Cy - 1] - 3;

    MapInfo.ExternalLight[Cx - 1, Cy] := MapInfo.ExternalLight[Cx - 1, Cy] - 5;
    MapInfo.ExternalLight[Cx, Cy] := MapInfo.ExternalLight[Cx, Cy] - 8;
    MapInfo.ExternalLight[Cx + 1, Cy] := MapInfo.ExternalLight[Cx + 1, Cy] - 5;

    MapInfo.ExternalLight[Cx - 1, Cy + 1] := MapInfo.ExternalLight[Cx - 1, Cy + 1] - 3;
    MapInfo.ExternalLight[Cx, Cy + 1] := MapInfo.ExternalLight[Cx, Cy + 1] - 5;
    MapInfo.ExternalLight[Cx + 1, Cy + 1] := MapInfo.ExternalLight[Cx + 1, Cy + 1] - 3;
  end
  else
  begin
    MapInfo.ExternalLight[Cx - 1, Cy - 1] := MapInfo.ExternalLight[Cx - 1, Cy - 1] + 3;
    MapInfo.ExternalLight[Cx, Cy - 1] := MapInfo.ExternalLight[Cx, Cy - 1] + 5;
    MapInfo.ExternalLight[Cx + 1, Cy - 1] := MapInfo.ExternalLight[Cx + 1, Cy - 1] + 3;

    MapInfo.ExternalLight[Cx - 1, Cy] := MapInfo.ExternalLight[Cx - 1, Cy] + 5;
    MapInfo.ExternalLight[Cx, Cy] := MapInfo.ExternalLight[Cx, Cy] + 8;
    MapInfo.ExternalLight[Cx + 1, Cy] := MapInfo.ExternalLight[Cx + 1, Cy] + 5;

    MapInfo.ExternalLight[Cx - 1, Cy + 1] := MapInfo.ExternalLight[Cx - 1, Cy + 1] + 3;
    MapInfo.ExternalLight[Cx, Cy + 1] := MapInfo.ExternalLight[Cx, Cy + 1] + 5;
    MapInfo.ExternalLight[Cx + 1, Cy + 1] := MapInfo.ExternalLight[Cx + 1, Cy + 1] + 3;
  end;
  CalculateDarkness;
end;

//------------------------------------------------------------------------------
//  Make shadows and bright areas
//------------------------------------------------------------------------------
procedure SaveMap;
var
  i, j, l: Integer;
  Stream: TFileStream;
  TempFileName: string;
begin
  TempFileName := Lowercase(ExtractFilePath(paramstr(0))) + 'WorldMap.sav';

  try
    Stream := TFileStream.Create(TempFileName, fmcreate);
    with Stream do
    begin
      Write(Player.Tx, SizeOf(Player.Tx));
      Write(Player.Ty, SizeOf(Player.Ty));

      for j := 0 to MAPXSIZE do // save the map
        for i := 0 to MAPXSIZE do
        begin
          for l := 1 to NUMLAYERS do
            Write(MapInfo.Layers[l].Plane[i, j], SizeOf(MapInfo.Layers[l].Plane[i, j]));
          Write(MapInfo.Ph[i, j], SizeOf(MapInfo.Ph[i, j]));
          Write(MapInfo.Darkness[i, j], SizeOf(MapInfo.Darkness[i, j]));
          Write(MapInfo.ExternalLight[i, j], SizeOf(MapInfo.ExternalLight[i, j]));
        end;
    end;
  finally
    if Stream <> nil then Stream.Free;
  end;
end;


procedure DrawPanel;
var
  X: Integer;
  p: Integer;
begin
  p := 0;
  for X := 0 to 3 do
  begin
    Canvas.Draw(Images.Image['Panel'],p, X * 256, 510, Blend_Default);
    Inc(p);
  end;
end;

procedure DoMouseDown;
var
  i, j, NewAlpha: Integer;

  function AlphaUp: Integer;
  begin
    if NewAlpha < 20 then Result := 20;
    if NewAlpha > 255 then Result := 255;
    //if ssCtrl in Shift then Result := 255; // Control key
    //if ssAlt in Shift then Result := 0; // Left menu = Alt
  end;

begin
  if HGE.Input_KeyDown(HGEK_LBUTTON) then // holding down left mouse button, i.e. removing a layers alpha value (less visible)
  begin
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY - 1].Alpha * 0.90); if NewAlpha < 2 then NewAlpha := 2; // top left
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY - 1].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY - 1].Alpha * 0.7); if NewAlpha < 2 then NewAlpha := 2; // top middle
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY - 1].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY - 1].Alpha * 0.90); if NewAlpha < 2 then NewAlpha := 2; // top right
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY - 1].Alpha := NewAlpha;

    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY].Alpha * 0.7); if NewAlpha < 2 then NewAlpha := 2; // left
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY].Alpha * 0.5); if NewAlpha < 2 then NewAlpha := 2; // middle
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY].Alpha * 0.7); if NewAlpha < 2 then NewAlpha := 2; // right
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY].Alpha := NewAlpha;

    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY + 1].Alpha * 0.90); if NewAlpha < 2 then NewAlpha := 2; // Bot left
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY + 1].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY + 1].Alpha * 0.7); if NewAlpha < 2 then NewAlpha := 2; // Bot middle
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY + 1].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY + 1].Alpha * 0.90); if NewAlpha < 2 then NewAlpha := 2; // Bot right
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY + 1].Alpha := NewAlpha;
  end;

  if HGE.Input_KeyDown(HGEK_RBUTTON) then // holding down left mouse button, i.e. adding to a layer's alpha value(more visible)
  begin
    if MapInfo.Layers[MapInfo.CurrentLayer].CurrentImage < 0 then MapInfo.Layers[MapInfo.CurrentLayer].CurrentImage := MUDPIC;

    for i := CellX - 1 to CellX + 1 do
      for j := CellY - 1 to CellY + 1 do
      begin
        MapInfo.Layers[MapInfo.CurrentLayer].Plane[i, j].PicNumber := MapInfo.Layers[MapInfo.CurrentLayer].CurrentImage;
        MapInfo.Layers[MapInfo.CurrentLayer].Plane[i, j].CellNumber := Random(Images.Items[MapInfo.Layers[MapInfo.CurrentLayer].CurrentImage].PatternCount);
      end;

    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY - 1].Alpha * 1.1); NewAlpha := AlphaUp; // top left
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY - 1].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY - 1].Alpha * 1.25); NewAlpha := AlphaUp; // top middle
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY - 1].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY - 1].Alpha * 1.1); NewAlpha := AlphaUp; // top right
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY - 1].Alpha := NewAlpha;

    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY].Alpha * 1.25); NewAlpha := AlphaUp; // left
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY].Alpha * 4); NewAlpha := AlphaUp; // middle
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY].Alpha * 1.25); NewAlpha := AlphaUp; // right
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY].Alpha := NewAlpha;

    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY + 1].Alpha * 1.1); NewAlpha := AlphaUp; // Bot left
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX - 1, CellY + 1].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY + 1].Alpha * 1.25); NewAlpha := AlphaUp; // Bot middle
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY + 1].Alpha := NewAlpha;
    NewAlpha := Round(MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY + 1].Alpha * 1.1); NewAlpha := AlphaUp; // Bot right
    MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX + 1, CellY + 1].Alpha := NewAlpha;

    // if drawing the water level then flaten the land. i.e. set heigt o Plateau height
    if MapInfo.Layers[MapInfo.CurrentLayer].Plane[CellX, CellY].PicNumber = WATERPIC then
    begin
      if (CellX > 2) and (CellY > 2) then
      begin
        while MapInfo.Ph[CellX - 1, CellY - 1] > PlateauHeight do MoveGround(True, CellX - 1, CellY - 1);
        while MapInfo.Ph[CellX, CellY - 1] > PlateauHeight do MoveGround(True, CellX, CellY - 1);
        while MapInfo.Ph[CellX + 1, CellY - 1] > PlateauHeight do MoveGround(True, CellX + 1, CellY - 1);

        while MapInfo.Ph[CellX - 1, CellY] > PlateauHeight do MoveGround(True, CellX - 1, CellY);
        while MapInfo.Ph[CellX, CellY] > PlateauHeight do MoveGround(True, CellX, CellY);
        while MapInfo.Ph[CellX + 1, CellY] > PlateauHeight do MoveGround(True, CellX + 1, CellY);

        while MapInfo.Ph[CellX - 1, CellY + 1] > PlateauHeight do MoveGround(True, CellX - 1, CellY + 1);
        while MapInfo.Ph[CellX, CellY + 1] > PlateauHeight do MoveGround(True, CellX, CellY + 1);
        while MapInfo.Ph[CellX + 1, CellY + 1] > PlateauHeight do MoveGround(True, CellX + 1, CellY + 1);
      end;

      // alter light pattern over the water
      for i := CellX - 1 to CellX + 1 do
        for j := CellY - 1 to CellY + 1 do
        begin
          MapInfo.ExternalLight[i, j] := Random(20);
        end;

      MapInfo.Ph[CellX - 1, CellY - 1] := PlateauHeight;
      MapInfo.Ph[CellX, CellY - 1] := PlateauHeight;
      MapInfo.Ph[CellX + 1, CellY - 1] := PlateauHeight;

      MapInfo.Ph[CellX - 1, CellY] := PlateauHeight;
      MapInfo.Ph[CellX, CellY] := PlateauHeight;
      MapInfo.Ph[CellX + 1, CellY] := PlateauHeight;

      MapInfo.Ph[CellX - 1, CellY + 1] := PlateauHeight;
      MapInfo.Ph[CellX, CellY + 1] := PlateauHeight;
      MapInfo.Ph[CellX + 1, CellY + 1] := PlateauHeight;
    end;
  end;
end;

function FrameFunc: Boolean;
var
w:integer;
begin
  HGE.Input_GetMousePos(MouseX, MouseY);
  HGE.Input_GetEvent(Event);
  DoMouseDown;
  DoMouseMove;
  DoMouseAndKeyboard;

  if Event.Wheel=1 then
     MoveGround(False, CellX, CellY);
  if Event.Wheel=-1 then
     MoveGround(True, CellX, CellY);
   Event.Wheel:=0;
  if  HGE.Input_GetKeyState(HGEK_ADD) then Inc(PlateauHeight, 5);
  if  HGE.Input_GetKeyState(HGEK_SUBTRACT) then dec(PlateauHeight, 5);

 // select a new drawing layer
  if HGE.Input_KeyDown(HGEK_COMMA) then
  begin
    Inc(MapInfo.CurrentLayer);
    if MapInfo.CurrentLayer > 5 then MapInfo.CurrentLayer := 1;
  end;

  if HGE.Input_KeyDown(HGEK_PERIOD) then
  begin
    dec(MapInfo.CurrentLayer);
    if MapInfo.CurrentLayer < 1 then MapInfo.CurrentLayer := 5;
  end;

  if HGE.Input_KeyDown(HGEK_M) then MakeMountains;

  if HGE.Input_KeyDown(HGEK_C) then ShowCheckers := not ShowCheckers;

  if HGE.Input_KeyDown(HGEK_B) then
  begin
    Inc(Blendmode);

    if Blendmode > 13 then Blendmode := 0;
  end;

  if HGE.Input_GetKeyState(HGEK_S) then
  begin
    SaveMap;
  end;

  if HGE.Input_GetKeyState(HGEK_0) then
  begin
    LoadMap;
  end;

  case HGE.Input_GetKey of
    HGEK_ESCAPE:
    begin
      FreeAndNil(Canvas);
      FreeAndNil(Images);
      FreeAndNil(Font);
      FreeObjects;
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function RenderFunc: Boolean;
var
  X, Y, i, j, dk1, dk2, dk3, dk4: Integer; PosX, PosY: Integer;
  sX1, sX2, sY1, sY2: Integer;
  DontDrawAnyMOre: Boolean;
begin
  //HGE.Gfx_Clear(0);
  Player.HasNotDrawnThisFrame := True;
  // calculate visible area
  sX1 := Trunc(Abs(LEFTOFFSET) / TileWidth);
  sX2 := sX1 + 14; //(SCRWIDTH div TILEWIDTH)+2;
  sY1 := Trunc(abs(TOPOFFSET) / TileHeight) - 3;
  sY2 := Trunc(sY1 + (SCRHEIGHT / TileHeight) + 3);
  if sY1 < 1 then sY1 := 0;
  HGE.Gfx_BeginScene;
  for Y := sY1 to sY2 do
  begin
      X := sX1;
      while X <= sX2 do
      begin
        dk1 := MapInfo.Darkness[X, Y]; // get the light/darkness values for these vertices
        dk2 := MapInfo.Darkness[X + 1, Y]; //
        dk3 := MapInfo.Darkness[X + 1, Y + 1];
        dk4 := MapInfo.Darkness[X, Y + 1];

        PosX := Trunc(LEFTOFFSET + (X * TileWidth));
        PosY := Trunc(TOPOFFSET + (Y * TileHeight));

        if not ShowCheckers then
        begin
          DontDrawAnyMOre := False; // if top of tile actually below screen then don't draw rest of the row

          if not DrawLowerRocks(X, Y, PosX, PosY, dk1, dk2, dk3, dk4) then DontDrawAnyMOre := True;
          if not DontDrawAnyMOre then
            DrawGrass1(X, Y, PosX, PosY, dk1, dk2, dk3, dk4);
          if not DontDrawAnyMOre then
            DrawWater(X, Y, PosX, PosY, dk1, dk2, dk3, dk4);

          if not (DontDrawAnyMOre) then
            DrawMud(X, Y, PosX, PosY, dk1, dk2, dk3, dk4);
        end
        else
        begin
          DrawCheckers(X, Y, PosX, PosY, dk1, dk2, dk3, dk4);
        end;

        if (X = CellX) and (Y = CellY) then
        begin
          HGE.Quadrangle4Color(
            PosX, PosY - MapInfo.Ph[X, Y] + 1,
            PosX + TileWidth, PosY - MapInfo.Ph[X + 1, Y] + 1,
            PosX + TileWidth, PosY + TileHeight - MapInfo.Ph[X + 1, Y + 1] + 1,
            PosX, PosY + TileHeight - MapInfo.Ph[X, Y + 1] + 1,
            ARGB(205, 255, 125, 255),
            ARGB(50, 125, 0, 255),
            ARGB(5, 5, 0, 5),
            ARGB(50, 125, 0, 255),
            True,
            Blend_Default);
            Font.Print(PosX - 5, PosY - MapInfo.Ph[X, Y] + 1,IntToStr(MapInfo.Ph[X + 1, Y]),255, 255, 255,255);
        end;

        if (X = Player.Tx) and (Y = Player.Ty) then Drawplayer(X, Y, PosX, PosY); // in current tile
        if (X = Player.Tx + 1) and (Y = Player.Ty) and (Player.Fx > 16) then Drawplayer(X - 1, Y, PosX, PosY); // in previous tile
        if (X = Player.Tx) and (Y = Player.Ty + 1) then Drawplayer(X, Y - 1, PosX, PosY - TileHeight); // in previous tile

        if MapInfo.ContainsObject[X, Y] then
          for i := ObjectList.count - 1 downto 0 do
            if (X = TGroundObject(ObjectList[i]).Tx) and (Y = TGroundObject(ObjectList[i]).Ty) then
              DrawGroundObject(PosX, PosY - MapInfo.Ph[X, Y], i);

        Inc(X);
      end; // while x :<=sx2 do
    end;
    DrawPanel;
    if MapInfo.Layers[MapInfo.CurrentLayer].CurrentImage >= 0 then
      Canvas.DrawStretch(Images[MapInfo.Layers[MapInfo.CurrentLayer].CurrentImage], 0, 700, 10, 764, 74, False, False, $FFFFFFFF, Blend_Default);
  Font.Print(8,25,'Current Water Level = ' + IntToStr(PlateauHeight));
  Font.Print(8,525,'Mousewheel = change height; c = Toggle Landscape / checkers; Shift + Move mouse = flattens ground');
  Font.Print(8,550,'"," & "." = change drawing Image; Right Mouse (ctrl or alt) = add image to the landscape');
  Font.Print(8,575,'Left Mouse = Remove Image; "+" & "-" = change water level; s & l = save and load landscape');

  //Font.Print(100,100,IntToStr(HGE.Timer_GetFPS));
  HGE.Gfx_EndScene;
  Result := False;
end;

procedure Main;
var
  I: Integer;
begin
  HGE := HGECreate(HGE_VERSION);
  HGE.System_SetState(HGE_FRAMEFUNC,FrameFunc);
  HGE.System_SetState(HGE_RENDERFUNC,RenderFunc);
  HGE.System_SetState(HGE_USESOUND, False);
  HGE.System_SetState(HGE_WINDOWED,False);
  HGE.System_SetState(HGE_SCREENWIDTH, 800);
  HGE.System_SetState(HGE_SCREENHEIGHT,600);
  HGE.System_SetState(HGE_SCREENBPP,16);
  HGE.System_SetState(HGE_TEXTUREFILTER, False);
  HGE.System_SetState(HGE_FPS,HGEFPS_VSYNC);
  HGE.System_SetState(HGE_HIDEMOUSE, False);
  Canvas := THGeCanvas.Create;
  Images := THGEImages.Create;

  if (HGE.System_Initiate) then
  begin
    Font:=TSysFont.Create;
    Font.CreateFont('arial',12,[]);
    Images.LoadFromFile('Grass.jpg',256, 256);
    Images.LoadFromFile('Rocks.jpg', 256, 256);
    Images.LoadFromFile('Water.png');
    Images.LoadFromFile('Dirt.jpg',256, 256);
    Images.LoadFromFile('Grass2.jpg', 256, 256);
    Images.LoadFromFile('CheckBlue.png');
    Images.LoadFromFile('CheckWhite.png');
    Images.LoadFromFile('Ball.png',32, 64);
    Images.LoadFromFile('Palm.png', 96, 101);
    Images.LoadFromFile('RunningEast.png',128,128);
    Images.LoadFromFile('RunningSouth.png',128,128);
    Images.LoadFromFile('RunningWest.png',128,128);
    Images.LoadFromFile('RunningNorth.png',128,128);
    Images.LoadFromFile('Objects.png',96,101);
    Images.LoadFromFile('Panel.jpg',256, 90);
    CreateGame;
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
