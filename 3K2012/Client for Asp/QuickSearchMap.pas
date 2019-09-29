unit QuickSearchMap;

interface

uses
  Windows, Classes, SysUtils, Grobal2;

type
  // -------------------------------------------------------------------------------
  // Map
  // -------------------------------------------------------------------------------

  TQuickSearchMapHeader = packed record
    Width: Word;
    Height: Word;
    Title: string[15];
    UpdateDate: TDateTime;
    Reserved: array[0..23] of Char;
  end;


  TQuickSearchMapInfo = packed record
    BkImg: Word;
    MidImg: Word;
    FrImg: Word;
    DoorIndex: Byte; //$80 (πÆ¬¶), πÆ¿« Ωƒ∫∞ ¿Œµ¶Ω∫
    DoorOffset: Byte; //¥›»˘ πÆ¿« ±◊∏≤¿« ªÛ¥Î ¿ßƒ°, $80 (ø≠∏≤/¥›»˚(±‚∫ª))
    AniFrame: Byte; //$80(Draw Alpha) +  «¡∑°¿” ºˆ
    anitick: Byte;
    Area: Byte; //¡ˆø™ ¡§∫∏
    light: Byte; //0..1..4 ±§ø¯ »ø∞˙
  end;
  TQuickMapInfo = packed record
    BkImg: Word;
    FrImg: Word;
    DoorIndex: Byte; //$80 (πÆ¬¶), πÆ¿« Ωƒ∫∞ ¿Œµ¶Ω∫
    DoorOffset: Byte; //¥›»˘ πÆ¿« ±◊∏≤¿« ªÛ¥Î ¿ßƒ°, $80 (ø≠∏≤/¥›»˚(±‚∫ª))
  end;
  PTQuickSearchMapInfo = ^TQuickSearchMapInfo;

  TQuickSearchMap = class
  private
//    function loadmapinfo(mapfile: string; var Width, Height: Integer): Boolean;
//    procedure updatemapseg(cx, cy: Integer); //, maxsegx, maxsegy: integer);
    procedure updatemap(cx, cy: Integer);
  public
    MapBase: string;
    MapHeight, Mapwidth: Integer;
    MArr: array of array of TQuickMapInfo;
    pass: array of longword;

    ClientRect: TRect;
    OldClientRect: TRect;
    BlockLeft, BlockTop: Integer; //≈∏¿œ ¡¬«•∑Œ øﬁ¬ , ≤¿¥Î±‚ ¡¬«•
    oldleft, oldtop: Integer;
    oldmap: string;
    CurUnitX, CurUnitY: Integer;
    CurrentMap: string;
    Segmented: Boolean;
    SegXCount, SegYCount: Integer;
   // MiniMapBmp: TBitMap;
    constructor Create;
    destructor Destroy; override;
    procedure UpdateMapSquare(cx, cy: Integer);
    procedure UpdateMapPos(mx, my: Integer);

    procedure ReadyReload;
    procedure LoadMap(mapname: string; mx, my: Integer);
    procedure MarkCanWalk(mx, my: Integer; bowalk: Boolean);
    function CanMove(mx, my: Integer): Boolean;


    function CanFly(mx, my: Integer): Boolean;
    function GetDoor(mx, my: Integer): Integer;
    function IsDoorOpen(mx, my: Integer): Boolean;
    function OpenDoor(mx, my: Integer): Boolean;
    function CloseDoor(mx, my: Integer): Boolean;
  end;



implementation
uses MShare, Share;


constructor TQuickSearchMap.Create;
begin
  inherited Create;
  //GetMem (MInfoArr, sizeof(TMapInfo) * LOGICALMAPUNIT * 3 * LOGICALMAPUNIT * 3);
  ClientRect := Rect(0, 0, 0, 0);
  MapBase := g_ParamDir+MAPDIR;
  CurrentMap := '';
  Segmented := False;
  SegXCount := 0;
  SegYCount := 0;
  CurUnitX := -1;
  CurUnitY := -1;
  BlockLeft := -1;
  BlockTop := -1;
  oldmap := '';
  //MiniMapBmp := TBitMap.Create;
end;

destructor TQuickSearchMap.Destroy;
begin
  setlength(MArr, 0, 0);
  setlength(pass, 0);
  inherited Destroy;

end;

{function TQuickSearchMap.loadmapinfo(mapfile: string; var Width, Height: Integer): Boolean;
var
  flname: string;
  fhandle: Integer;
  header: TQuickSearchMapHeader;
begin
  Result := False;
  flname := MapBase + mapfile;
  if FileExists(flname) then
  begin
    fhandle := FileOpen(flname, fmOpenRead or fmShareDenyNone);
    if fhandle > 0 then
    begin
      FileRead(fhandle, header, SizeOf(TQuickSearchMapHeader));
      Width := header.Width;
      Height := header.Height;
      setlength(MArr, Width, Height);
    end;
    FileClose(fhandle);
  end;
end;

//segmented map ¿Œ ∞ÊøÏ

procedure TQuickSearchMap.updatemapseg(cx, cy: Integer); //, maxsegx, maxsegy: integer);
begin

end;}
procedure TQuickSearchMap.updatemap(cx, cy: Integer);
var
  fhandle, i, j, aline, lx, rx, ty, by,count: Integer;
  header: TQuickSearchMapHeader;
  flname: string;
  TempMaar:Array of TQuickSearchMapInfo;
begin
  Fillchar(MArr, SizeOf(MArr), 0);
  //Fillchar(pass, SizeOf(pass), 0);
  flname := MapBase + CurrentMap + '.map';
  if FileExists(flname) then begin
    fhandle := FileOpen(flname, fmOpenRead or fmShareDenyNone);
    if fhandle > 0 then begin
      FileRead(fhandle, header, SizeOf(TQuickSearchMapHeader));
      lx := 0;
      rx := header.Width; //rx
      ty := 0;
      by := header.Height;
      if lx < 0 then lx := 0;
      if ty < 0 then ty := 0;
      if by >= header.Height then by := header.Height;
      aline := SizeOf(TQuickSearchMapInfo) * header.Height;
      //SetLength(Marr,0,0);
      SetLength(MArr, header.Width, header.Height);
      SetLength(TempMaar,Header.Height);
      MapHeight := header.Height;
      Mapwidth := header.Width;
      for i := lx to rx - 1 do begin
        if (i >= 0) and (i < header.Width) then begin
          FileSeek(fhandle, SizeOf(TQuickSearchMapHeader) + (aline * i) + (SizeOf(TQuickSearchMapInfo)
            * ty), 0);
         Count:=(by - ty);
         FileRead(fhandle, TempMaar[0], SizeOf(TQuickSearchMapInfo) * (by - ty));
         for j:=0 to Count-1 do begin
            Marr[i-lx,j].BkImg:= TempMaar[j].BkImg;
            Marr[i-lx,j].FrImg:= TempMaar[j].FrImg;
            Marr[i-lx,j].DoorIndex:= TempMaar[j].DoorIndex;
            Marr[i-lx,j].DoorOffset:= TempMaar[j].DoorOffset;
         end;
        end;
      end;
      SetLength(TempMaar,0);  //20080728  Õ∑≈ƒ⁄¥Ê
      //TempMaar := nil;
      FileClose(fhandle);
    end;
  end;
end;
procedure TQuickSearchMap.ReadyReload;
begin
  CurUnitX := -1;
  CurUnitY := -1;
end;
//cx, cy: ¡ﬂæ”, Counted by unit..
procedure TQuickSearchMap.UpdateMapSquare(cx, cy: Integer);
begin
      updatemap(cx, cy);
end;


procedure TQuickSearchMap.UpdateMapPos(mx, my: Integer);
var
  cx, cy: Integer;

begin
  cx := mx div LOGICALMAPUNIT;
  cy := my div LOGICALMAPUNIT;
  BlockLeft := 0;
  BlockTop := 0;

  UpdateMapSquare(cx, cy);


  oldleft := BlockLeft;
  oldtop := BlockTop;
end;
procedure TQuickSearchMap.LoadMap(mapname: string; mx, my: Integer);
begin
  CurUnitX := -1;
  CurUnitY := -1;
  CurrentMap := mapname;
  Segmented := False; 
  UpdateMapPos(mx, my);
  oldmap := CurrentMap;
end;

procedure TQuickSearchMap.MarkCanWalk(mx, my: Integer; bowalk: Boolean);
begin

end;

function TQuickSearchMap.CanMove(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := False;
  cx := mx - BlockLeft;
  cy := my - BlockTop;
  // if (cx > MAXX * 3) or (cy > MAXX * 3) then
  //   Exit;

  if (cx < 0) or (cy < 0) then
    Exit;
    if (cx>Mapwidth) or(Cy>MapHeight) then
      Exit;

  Result := ((MArr[cx, cy].BkImg and $8000) + (MArr[cx, cy].FrImg and
    $8000)) = 0;
  if Result then
  begin //πÆ∞ÀªÁ
    if MArr[cx, cy].DoorIndex and $80 > 0 then
    begin //πÆ¬¶¿Ã ¿÷¿Ω
      if (MArr[cx, cy].DoorOffset and $80) = 0 then
        Result := False; //πÆ¿Ã æ» ø≠∑»¿Ω.
    end;
  end;
end;

function TQuickSearchMap.CanFly(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  cx := mx - BlockLeft;
  cy := my - BlockTop;
  // if (cx < 0) or (cy < 0) then
  //   Exit;
  Result := (MArr[cx, cy].FrImg and $8000) = 0;
  if Result then begin //πÆ∞ÀªÁ
    if MArr[cx, cy].DoorIndex and $80 > 0 then  begin //πÆ¬¶¿Ã ¿÷¿Ω
      if (MArr[cx, cy].DoorOffset and $80) = 0 then
        Result := False; //πÆ¿Ã æ» ø≠∑»¿Ω.
    end;
  end;
end;

function TQuickSearchMap.GetDoor(mx, my: Integer): Integer;
var
  cx, cy: Integer;
begin
  Result := 0;
  cx := mx - BlockLeft;
  cy := my - BlockTop;
  if (cx>Mapwidth) or(Cy>MapHeight) then Exit;

  if MArr[cx, cy].DoorIndex and $80 > 0 then begin
    Result := MArr[cx, cy].DoorIndex and $7F;
  end;
end;

function TQuickSearchMap.IsDoorOpen(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := False;
  cx := mx - BlockLeft;
  cy := my - BlockTop;
    if (cx>Mapwidth) or(Cy>MapHeight) then Exit;

  if MArr[cx, cy].DoorIndex and $80 > 0 then begin
    Result := (MArr[cx, cy].DoorOffset and $80 <> 0);
  end;
end;

function TQuickSearchMap.OpenDoor(mx, my: Integer): Boolean;
var
  i, j, cx, cy, idx: Integer;
begin
  Result := False;
  cx := mx - BlockLeft;
  cy := my - BlockTop;
  // if (cx < 0) or (cy < 0) then
  //   Exit;
  if (cx>Mapwidth) or(Cy>MapHeight) then Exit;

  if MArr[cx, cy].DoorIndex and $80 > 0 then begin
    idx := MArr[cx, cy].DoorIndex and $7F;
    for i := cx - 10 to cx + 10 do
      for j := cy - 10 to cy + 10 do begin
        if (i > 0) and (j > 0) then
          if (MArr[i, j].DoorIndex and $7F) = idx then
            MArr[i, j].DoorOffset := MArr[i, j].DoorOffset or $80;
      end;
  end;
end;

function TQuickSearchMap.CloseDoor(mx, my: Integer): Boolean;
var
  i, j, cx, cy, idx: Integer;
begin
  Result := False;
  cx := mx - BlockLeft;
  cy := my - BlockTop;
  if (cx < 0) or (cy < 0) then Exit;
  if (cx > Mapwidth) or(Cy > MapHeight) then Exit;
    
  if MArr[cx, cy].DoorIndex and $80 > 0 then begin
    idx := MArr[cx, cy].DoorIndex and $7F;
    for i := cx - 8 to cx + 10 do
      for j := cy - 8 to cy + 10 do begin
        if (MArr[i, j].DoorIndex and $7F) = idx then
          MArr[i, j].DoorOffset := MArr[i, j].DoorOffset and $7F;
      end;
  end;
end;





end.
