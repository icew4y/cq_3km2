unit cliUtil;

interface

uses
  Windows, SysUtils, DXDraws, DirectX, DIB, HUtil32, Share, Grobal2;


const
   MAXGRADE = 64;

type
  TColorEffect = (ceNone, ceGrayScale{灰色}, ceBright, ceBlack, ceWhite, ceRed, ceGreen, ceBlue, ceYellow, ceFuchsia{紫红色});

  TNearestIndexHeader = record
    Title: string[30];
    IndexCount: integer;
    desc: array[0..10] of byte;
  end;
  //查表混合
  TBGRS = array[0..High(Word)] of TBGR;
  PBGRS = ^TBGRS;
  TRGBEffects = array[0..255, 0..255] of Byte;
  PRGBEffects = ^TRGBEffects;

procedure BuildColorLevels (ctable: TRGBQuads);
procedure BuildNearestIndex (ctable: TRGBQuads);
procedure SaveNearestIndex (flname: string);
function  LoadNearestIndex (flname: string): Boolean;
procedure MakeDark (ssuf: TDirectDrawSurface; darklevel: integer);
{$IF M2Version = 2}
procedure DrawFog (ssuf: TDirectDrawSurface; fogmask: PByte; fogwidth: integer);
procedure FogCopy (PSource: Pbyte; ssx, ssy, swidth, sheight: integer;
                   PDest: Pbyte; ddx, ddy, dwidth, dheight, maxfog: integer);
{$IFEND}
procedure DrawBlend (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; btAlpha:Byte = 180);
//MMX
procedure DrawBlendEx (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight: integer; btAlpha:Byte);
//查表
//procedure DrawBlendEx (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode: integer; btAlpha:Byte);
//解决火龙教主引起程序崩溃问题  20080608
procedure DrawEx (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode: integer);
procedure DrawEffect(X, Y: Integer; ssuf, dsuf: TDirectDrawSurface; eff: TColorEffect);
//procedure DrawEffect (x, y, width, height: integer; ssuf: TDirectDrawSurface; eff: TColorEffect);
procedure BuildRealRGB (ctable: TRGBQuads); //解决火龙教主引起程序崩溃问题  20080608
var
   DarkLevel : integer;


implementation

var
  Color256Mix: array[0..255, 0..255] of byte;
  Color256Anti: array[0..255, 0..255] of byte;
  HeavyDarkColorLevel: array[0..255, 0..255] of byte;
  LightDarkColorLevel: array[0..255, 0..255] of byte;
  DengunColorLevel: array[0..255, 0..255] of byte;
  BrightColorLevel: array[0..255] of byte;
  GrayScaleLevel: array[0..255] of byte;
  RedishColorLevel: array[0..255] of byte;
  BlackColorLevel: array[0..255] of byte;
  WhiteColorLevel: array[0..255] of byte;
  GreenColorLevel: array[0..255] of byte;
  YellowColorLevel: array[0..255] of byte;
  BlueColorLevel: array[0..255] of byte;
  FuchsiaColorLevel: array[0..255] of byte;
//解决火龙教主引起程序崩溃问题  20080608
  Color256real: array[0..255, 0..255] of byte;

  RGBEffects: TRGBEffects;
  BGRS: TBGRS;
  masknogreen: Int64;
  maskred: Int64 = $F800F800F800F800;
  maskblue: Int64 = $001F001F001F001F;
  maskgreen: Int64 = $07E007E007E007E0;
  maskbyte: Int64 = $7E0F81F;
  maskkey: Int64 = $0000000000000000;
  maskdate1: Int64 = $0100010001000100;//$00FF00FF00FF00FF;
  maskdate2: Int64 = $FFFFFFFFFFFFFFFF;
  maskdate3: Int64 = $00F800F800F800F8;
  maskdate4: Int64 = $00FC00FC00FC00FC;
  maskdate5: Int64 = $0008000800080008;
  maskdate6: Int64 = $000C000C000C000C;
procedure BuildNearestIndex (ctable: TRGBQuads);
var
   MinDif, ColDif: Integer;
   MatchColor: Byte;
   pal0, pal1, pal2: TRGBQuad;

   procedure BuildMix;
   var
      i, j, n: integer;
   begin
      for i:=0 to 255 do begin
         pal0 := ctable[i];
         for j:=0 to 255 do begin
            pal1 := ctable[j];
            pal1.rgbRed := pal0.rgbRed div 2 + pal1.rgbRed div 2;
            pal1.rgbGreen := pal0.rgbGreen div 2 + pal1.rgbGreen div 2;
            pal1.rgbBlue := pal0.rgbBlue div 2 + pal1.rgbBlue div 2;
            MinDif := 768;
            MatchColor := 0;
            for n:=0 to 255 do begin
               pal2 := ctable[n];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := n;
               end;
            end;
            Color256Mix[i, j] := MatchColor;
         end;
      end;
   end;
   procedure BuildAnti;
   var
      i, j, n: integer;
   begin
      for i:=0 to 255 do begin
         pal0 := ctable[i];
         for j:=0 to 255 do begin
            pal1 := ctable[j];
            //ever := _MAX(pal0.rgbRed, pal0.rgbGreen);
            //ever := _MAX(ever, pal0.rgbBlue);
            pal1.rgbRed := _MIN(255, Round (pal0.rgbRed  + (255-pal0.rgbRed)/255 * pal1.rgbRed));
            pal1.rgbGreen := _MIN(255, Round (pal0.rgbGreen  + (255-pal0.rgbGreen)/255 * pal1.rgbGreen));
            pal1.rgbBlue := _MIN(255, Round (pal0.rgbBlue  + (255-pal0.rgbBlue)/255 * pal1.rgbBlue));
            MinDif := 768;
            MatchColor := 0;
            for n:=0 to 255 do begin
               pal2 := ctable[n];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := n;
               end;
            end;
            Color256Anti[i, j] := MatchColor;
         end;
      end;
   end;
   procedure BuildColorLevels;
   var
      n, i, j, rr, gg, bb: integer;
   begin
      for n:=0 to 30 do begin
         for i:=0 to 255 do begin
            pal1 := ctable[i];
            rr := _MIN(Round(pal1.rgbRed * (n+1) / 31) - 5, 255);      //(n + (n-1)*3) / 121);
            gg := _MIN(Round(pal1.rgbGreen * (n+1) / 31) - 5, 255);  //(n + (n-1)*3) / 121);
            bb := _MIN(Round(pal1.rgbBlue * (n+1) / 31) - 5, 255);    //(n + (n-1)*3) / 121);
            pal1.rgbRed := _MAX(0, rr);
            pal1.rgbGreen := _MAX(0, gg);
            pal1.rgbBlue := _MAX(0, bb);
            MinDif := 768;
            MatchColor := 0;
            for j:=0 to 255 do begin
               pal2 := ctable[j];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := j;
               end;
            end;
            HeavyDarkColorLevel[n, i] := MatchColor;
         end;
      end;
      for n:=0 to 30 do begin
         for i:=0 to 255 do begin
            pal1 := ctable[i];
            pal1.rgbRed := _MIN(Round(pal1.rgbRed * (n*3+47) / 140), 255);
            pal1.rgbGreen := _MIN(Round(pal1.rgbGreen * (n*3+47) / 140), 255);
            pal1.rgbBlue := _MIN(Round(pal1.rgbBlue * (n*3+47) / 140), 255);
            MinDif := 768;
            MatchColor := 0;
            for j:=0 to 255 do begin
               pal2 := ctable[j];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := j;
               end;
            end;
            LightDarkColorLevel[n, i] := MatchColor;
         end;
      end;
      for n:=0 to 30 do begin
         for i:=0 to 255 do begin
            pal1 := ctable[i];
            pal1.rgbRed := _MIN(Round(pal1.rgbRed * (n*3+120) / 214), 255);
            pal1.rgbGreen := _MIN(Round(pal1.rgbGreen * (n*3+120) / 214), 255);
            pal1.rgbBlue := _MIN(Round(pal1.rgbBlue * (n*3+120) / 214), 255);
            MinDif := 768;
            MatchColor := 0;
            for j:=0 to 255 do begin
               pal2 := ctable[j];
               ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                         Abs(pal2.rgbGreen - pal1.rgbGreen) +
                         Abs(pal2.rgbBlue - pal1.rgbBlue);
               if ColDif < MinDif then begin
                  MinDif := ColDif;
                  MatchColor := j;
               end;
            end;
            DengunColorLevel[n, i] := MatchColor;
         end;
      end;
      for n:=31 to 255 do
         for i:=0 to 255 do begin
            HeavyDarkColorLevel[n, i] := HeavyDarkColorLevel[30, i];
            LightDarkColorLevel[n, i] := LightDarkColorLevel[30, i];
            DengunColorLevel[n, i] := DengunColorLevel[30, i];
         end;

   end;
begin
   BuildMix;
   BuildAnti;
   BuildColorLevels;
end;

procedure BuildColorLevels (ctable: TRGBQuads);
var
   n, i, j, MinDif, ColDif: integer;
   pal1, pal2: TRGBQuad;
   MatchColor: byte;
begin
   BrightColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      pal1.rgbRed := _MIN(Round(pal1.rgbRed * 1.3), 255);
      pal1.rgbGreen := _MIN(Round(pal1.rgbGreen * 1.3), 255);
      pal1.rgbBlue := _MIN(Round(pal1.rgbBlue * 1.3), 255);
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      BrightColorLevel[i] := MatchColor;
   end;
   GrayScaleLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := n; //Round(pal1.rgbRed * (n*3+25) / 118);
      pal1.rgbGreen := n; //Round(pal1.rgbGreen * (n*3+25) / 118);
      pal1.rgbBlue := n; //Round(pal1.rgbBlue * (n*3+25) / 118);
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      GrayScaleLevel[i] := MatchColor;
   end;
   BlackColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := Round ((pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) / 3 * 0.6);
      pal1.rgbRed := n; //_MAX(8, Round(pal1.rgbRed * 0.7));
      pal1.rgbGreen := n; //_MAX(8, Round(pal1.rgbGreen * 0.7));
      pal1.rgbBlue := n; //_MAX(8, Round(pal1.rgbBlue * 0.7));
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      BlackColorLevel[i] := MatchColor;
   end;
   WhiteColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := _MIN (Round ((pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) / 3 * 1.6), 255);
      pal1.rgbRed := n; //_MAX(8, Round(pal1.rgbRed * 0.7));
      pal1.rgbGreen := n; //_MAX(8, Round(pal1.rgbGreen * 0.7));
      pal1.rgbBlue := n; //_MAX(8, Round(pal1.rgbBlue * 0.7));
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      WhiteColorLevel[i] := MatchColor;
   end;
   RedishColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := n;
      pal1.rgbGreen := 0;
      pal1.rgbBlue := 0;
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      RedishColorLevel[i] := MatchColor;
   end;
   GreenColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := 0;
      pal1.rgbGreen := n;
      pal1.rgbBlue := 0;
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      GreenColorLevel[i] := MatchColor;
   end;
   YellowColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := n;
      pal1.rgbGreen := n;
      pal1.rgbBlue := 0;
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      YellowColorLevel[i] := MatchColor;
   end;
   BlueColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := 0; //_MIN(Round(n*1.3), 255);
      pal1.rgbGreen := 0; //_MIN(Round(n), 255);
      pal1.rgbBlue := n; //_MIN(Round(n*1.3), 255);
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      BlueColorLevel[i] := MatchColor;
   end;
   FuchsiaColorLevel[0] := 0;
   for i:=1 to 255 do begin
      pal1 := ctable[i];
      n := (pal1.rgbRed + pal1.rgbGreen + pal1.rgbBlue) div 3;
      pal1.rgbRed := n;
      pal1.rgbGreen := 0;
      pal1.rgbBlue := n;
      MinDif := 768;
      MatchColor := 0;
      for j:=1 to 255 do begin
         pal2 := ctable[j];
         ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                   Abs(pal2.rgbGreen - pal1.rgbGreen) +
                   Abs(pal2.rgbBlue - pal1.rgbBlue);
         if ColDif < MinDif then begin
            MinDif := ColDif;
            MatchColor := j;
         end;
      end;
      FuchsiaColorLevel[i] := MatchColor;
   end;
end;


procedure SaveNearestIndex (flname: string);
var
   nih: TNearestIndexHeader;
   fhandle: integer;
begin
   nih.Title := 'WEMADE Entertainment Inc.';
   nih.IndexCount := Sizeof(Color256Mix);
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenWrite or fmShareDenyNone);
   end else
      fhandle := FileCreate (flname);
   if fhandle > 0 then begin
      FileWrite (fhandle, nih, sizeof(TNearestIndexHeader));
      FileWrite (fhandle, Color256Mix, sizeof(Color256Mix));
      FileWrite (fhandle, Color256Anti, sizeof(Color256Anti));
      FileWrite (fhandle, HeavyDarkColorLevel, sizeof(HeavyDarkColorLevel));
      FileWrite (fhandle, LightDarkColorLevel, sizeof(LightDarkColorLevel)); 
      FileWrite (fhandle, DengunColorLevel, sizeof(DengunColorLevel));
      FileClose (fhandle);
   end;
end;

function LoadNearestIndex (flname: string): Boolean;
var
   nih: TNearestIndexHeader;
   fhandle, rsize: integer;
begin
   Result := FALSE;
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, nih, sizeof(TNearestIndexHeader));
         if nih.IndexCount = Sizeof(Color256Mix) then begin
            Result := TRUE;
            rsize := 256*256;
            if rsize <> FileRead (fhandle, Color256Mix, sizeof(Color256Mix)) then Result := FALSE;
            if rsize <> FileRead (fhandle, Color256Anti, sizeof(Color256Anti)) then Result := FALSE;
            if rsize <> FileRead (fhandle, HeavyDarkColorLevel, sizeof(HeavyDarkColorLevel)) then Result := FALSE;
            if rsize <> FileRead (fhandle, LightDarkColorLevel, sizeof(LightDarkColorLevel)) then Result := FALSE;
            if rsize <> FileRead (fhandle, DengunColorLevel, sizeof(DengunColorLevel)) then Result := FALSE;
         end;
         FileClose (fhandle);
      end;
   end;
end;

{$IF M2Version = 2}  //1.76
procedure FogCopy (PSource: Pbyte; ssx, ssy, swidth, sheight: integer;
                   PDest: Pbyte; ddx, ddy, dwidth, dheight, maxfog: integer);
var
   row, srclen, srcheight, spitch, dpitch: integer;
begin
   if (PSource = nil) or (pDest = nil) then exit; 
   spitch := swidth;
   dpitch := dwidth;
   if ddx < 0 then begin
      ssx := ssx - ddx;
      swidth := swidth + ddx;
      ddx := 0;
   end;
   if ddy < 0 then begin
      ssy := ssy - ddy;
      sheight := sheight + ddy;
      ddy := 0;
   end;
   srclen := _MIN(swidth*2, (dwidth-ddx)*2);
   srcheight := _MIN(sheight, dheight-ddy);
   if (srclen <= 0) or (srcheight <= 0) then exit;

   asm
         mov   row, 0
      @@NextRow:
         mov   eax, row
         cmp   eax, srcheight
         jae   @@Finish

         mov   esi, psource
         mov   eax, ssy
         add   eax, row
         mov   ebx, spitch
         imul  eax, ebx
         add   eax, ssx
         add   esi, eax          //sptr

         mov   edi, pdest
         mov   eax, ddy
         add   eax, row
         mov   ebx, dpitch
         imul  eax, ebx
         add   eax, ddx
         add   edi, eax          //dptr

         mov   ebx, srclen
      @@FogNext:
         cmp   ebx, 0
         jbe   @@FinOne
         cmp   ebx, 8
         jb    @@FinOne   //@@EageNext

         db $0F,$6F,$06           /// movq  mm0, [esi]
         db $0F,$6F,$0F           /// movq  mm1, [edi]
         db $0F,$FE,$C8           /// paddd mm1, mm0
         db $0F,$7F,$0F           /// movq [edi], mm1

         sub   ebx, 8
         add   esi, 8
         add   edi, 8
         jmp   @@FogNext
      @@FinOne:
         inc   row
         jmp   @@NextRow

      @@Finish:
         db $0F,$77               /// emms
   end;
end;

procedure DrawFog (ssuf: TDirectDrawSurface; fogmask: PByte; fogwidth: integer);
var
  row: integer;
   ddsd: TDDSurfaceDesc2;
   srclen, srcheight: integer;
   lpitch: integer;
   {pSrc,} psource, pColorLevel: pbyte; 
   I,II: Integer;
   src, msk: array[0..7] of byte;
   sptr:PWord;
   sptr2, pSrc: PByte;
   dest2:word;
   ccc:Byte;
begin
   if ssuf.Width > SCREENWIDTH + 100 then exit;
//   if ssuf.Width > 900 then exit;
   case DarkLevel of
      1: pColorLevel := @HeavyDarkColorLevel;
      2: pColorLevel := @LightDarkColorLevel;
      3: pColorLevel := @DengunColorLevel;
      else exit;
   end;
   try
      ddsd.dwSize := SizeOf(ddsd);
      ssuf.Lock (TRect(nil^), ddsd);
      srclen := _MIN(ssuf.Width, fogwidth);
     //pSrc := @src;
      srcheight := ssuf.Height;
      lpitch := ddsd.lPitch;
      psource := ddsd.lpSurface;
        for i:=0 to srcheight-1 do begin
          sptr := PWord(integer(psource) + (lpitch * I));
          sptr2:= pbyte(Integer(fogmask) + (fogwidth * I));
          for II:=0 to srclen -1 do begin
            dest2:=sptr^;
            asm
              mov   edi, sptr2      //edi = fogmask

              mov   edx, pColorLevel  //edx =  pColorLevel
              movzx eax, [edi].byte   //fogmask

              imul  eax, 256
              movzx ebx, [dest2].byte   //家胶 ddsd.lpSurface;
              add   eax, ebx
              mov   al, [edx+eax].byte //pColorLevel
              mov   CCC, al
            end;
            sptr^:=CCC;
            Inc(sptr2);
            Inc(sptr);
          end;
        end;
   finally
      ssuf.UnLock();
   end;
end;
{$IFEND}
(*
原版8位版
procedure DrawFog (ssuf: TDirectDrawSurface; fogmask: PByte; fogwidth: integer);
var
   row: integer;
   ddsd: TDDSurfaceDesc2;
   srclen, srcheight: integer;
   lpitch: integer;
   {pSrc,} psource, pColorLevel: Pbyte;
begin
   if ssuf.Width > SCREENWIDTH + 100 then exit;
   case DarkLevel of
      1: pColorLevel := @HeavyDarkColorLevel;
      2: pColorLevel := @LightDarkColorLevel;
      3: pColorLevel := @DengunColorLevel;
      else exit;
   end;

   try
      ddsd.dwSize := SizeOf(ddsd);
      ssuf.Lock (TRect(nil^), ddsd);
      srclen := _MIN(ssuf.Width, fogwidth);
     //pSrc := @src;
      srcheight := ssuf.Height;
      lpitch := ddsd.lPitch;
      psource := ddsd.lpSurface;

      asm
            mov   row, 0
         @@NextRow:
            mov   ebx, row
            mov   eax, srcheight
            cmp   ebx, eax
            jae   @@DrawFogFin

            mov   esi, psource      //esi = ddsd.lpSurface;
            mov   eax, lpitch
            mov   ebx, row
            imul  eax, ebx
            add   esi, eax

            mov   edi, fogmask      //edi = fogmask
            mov   eax, fogwidth
            mov   ebx, row
            imul  eax, ebx
            add   edi, eax

            mov   ecx, srclen
            mov   edx, pColorLevel

         @@NextByte:
            cmp   ecx, 0
            jbe   @@Finish

            movzx eax, [edi].byte   //fogmask
            ///cmp   eax, 30
            ///ja    @@SkipByte
            imul  eax, 256
            movzx ebx, [esi].byte   //家胶 ddsd.lpSurface;
            add   eax, ebx
            mov   al, [edx+eax].byte //pColorLevel
            mov   [esi].byte, al
         ///@@SkipByte:
            dec   ecx
            inc   esi
            inc   edi
            jmp   @@NextByte

         @@Finish:
            inc   row
            jmp   @@NextRow

         @@DrawFogFin:
            db $0F,$77               /// emms
      end;
   finally
      ssuf.UnLock();
   end;
end;*)
{procedure MakeDark (ssuf: TDirectDrawSurface; darklevel: integer);
var
   row, count: integer;
   ddsd: TDDSurfaceDesc;
   //source: array[0..910] of byte;
   scount, srclen, srcheight: integer;
   lpitch: integer;
   src: array[0..7] of byte;
   pSrc, psource, pColorLevel: Pbyte;
begin
   if not darklevel in [1..30] then exit;
   if ssuf.Width > SCREENWIDTH + 100 then exit;
//   if ssuf.Width > 900 then exit;
   try
      ddsd.dwSize := SizeOf(ddsd);
      ssuf.Lock (TRect(nil^), ddsd);
      srclen := ssuf.Width;
      srcheight := ssuf.Height;
      pSrc := @src;
      //if HeavyDark then pColorLevel := @HeavyDarkColorLevel
      //else pColorLevel := @LightDarkColorLevel;
      pColorLevel := @HeavyDarkColorLevel;
      lpitch := ddsd.lPitch;
      psource := ddsd.lpSurface;

      asm
            mov   row, 0
         @@NextRow:
            mov   ebx, row
            mov   eax, srcheight
            cmp   ebx, eax
            jae   @@DrawFogFin

            mov   esi, psource      //sptr
            mov   eax, lpitch
            mov   ebx, row
            imul  eax, ebx
            add   esi, eax

            mov   eax, srclen
            mov   scount, eax
         @@FogNext:
            mov   edx, pSrc     //pSrc = array[0..7]
            mov   ebx, scount
            cmp   ebx, 0
            jbe   @@Finish
            cmp   ebx, 8
            jb    @@FogSmall

            db $0F,$6F,$06           /// movq  mm0, [esi]       //8官捞飘 佬澜 sptr
            db $0F,$7F,$02           /// movq  [edx], mm0
            mov   count, 8

          @@LevelChange:
            mov   eax, darklevel
            imul  eax, 256
            movzx ebx, [edx].byte   //8官捞飘 弓澜栏肺 佬篮 单捞磐
            add   eax, ebx
            mov   ebx, pColorLevel
            mov   al, [ebx+eax].byte
            mov   [edx].byte, al

         @@Skip1:
            dec   count
            inc   edx
            inc   edi
            cmp   count, 0
            ja    @@LevelChange
            sub   edx, 8

            db $0F,$6F,$02           /// movq  mm0, [edx]
            db $0F,$7F,$06           /// movq  [esi], mm0
         @@Skip_8Byte:
            sub   scount, 8
            add   esi, 8
            jmp   @@FogNext

         @@FogSmall:
            mov   eax, darklevel
            imul  eax, 256
            movzx ebx, [edx].byte
            add   eax, ebx
            mov   ebx, pColorLevel
            mov   al, [ebx+eax].byte
            mov   [esi].byte, al

         @@Skip2:
            inc   edi
            inc   esi
            dec   scount
            jmp   @@FogNext

         @@Finish:
            inc   row
            jmp   @@NextRow

         @@DrawFogFin:
            db $0F,$77               /// emms
      end;
   finally
      ssuf.UnLock();
   end;
end;  }


//图象转黑再变亮的代码。用来开门与人物选取之间的转接
procedure MakeDark (ssuf: TDirectDrawSurface; darklevel: integer);
begin
   if not darklevel in [1..30] then exit;
   ssuf.FillRectAlpha(ssuf.ClientRect,0,round((30-darklevel)*255/30));
end;

//ssurface + dsurface => dsurface
{procedure DrawBlend (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; blendmode: integer);
begin
   DrawBlendEx (dsuf, x, y, ssuf, 0, 0, ssuf.Width, ssuf.Height, blendmode);
end;}
//ssurface + dsurface => dsurface
procedure DrawBlend (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; btAlpha:Byte = 180);
begin
  DrawBlendEx (dsuf, x, y, ssuf, 0, 0, ssuf.Width, ssuf.Height, btAlpha);
end;

//MMX
procedure DrawBlendEx (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight: integer; btAlpha:Byte);
var
  ta, tb, tc, td, I, j, k, L, tmp, srcleft, srctop, srcwidth, srcbottom, sidx, didx: Integer;
  sptr, dptr, pmix: PWord;
  bitindex, scount, dcount, SrcLen, destlen, wcount, AWidth, bwidth: Integer;
  r, G, b, dr, dg, db, stmp, dtmp: Word;
  SrcBits, DstBits: PWord;
  SrcDDSD, DstDDSD: TDDSurfaceDesc2;
begin
  if (dsuf = nil) or (ssuf = nil) then Exit;
  if X >= dsuf.Width then Exit;
  if Y >= dsuf.Height then Exit;

  if X < 0 then begin
    srcleft := -X;
    srcwidth := ssufwidth + X;
    X := 0;
  end else begin
    srcleft := ssufleft;
    srcwidth := ssufwidth;
  end;
  if Y < 0 then begin
    srctop := -Y;
    srcbottom := ssufheight;
    Y := 0;
  end else begin
    srctop := ssuftop;
    srcbottom := srctop + ssufheight;
  end;
  if srcleft + srcwidth > ssuf.Width then srcwidth := ssuf.Width - srcleft;
  if srcbottom > ssuf.Height then
    srcbottom := ssuf.Height; //-srcheight;
  if X + srcwidth > dsuf.Width then srcwidth := (dsuf.Width - X) div 4 * 4;
  if Y + srcbottom - srctop > dsuf.Height then
    srcbottom := dsuf.Height - Y + srctop;
  if (X + srcwidth) * (Y + srcbottom - srctop) > dsuf.Width * dsuf.Height then //烙矫..
    srcbottom := srctop + (srcbottom - srctop) div 2;

  if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= ssuf.Width) or (srctop >= ssuf.Height) then Exit;

  if srcwidth > SCREENWIDTH + 100 then Exit;

  AWidth := srcwidth div 4; //ssuf.Width div 4;
  bwidth := srcwidth; //ssuf.Width;
  SrcLen := srcwidth; //ssuf.Width;
  destlen := srcwidth; //ssuf.Width;
    try
      SrcDDSD.dwSize := SizeOf(SrcDDSD);
      DstDDSD.dwSize := SizeOf(DstDDSD);
      dsuf.Lock(TRect(nil^), DstDDSD);
      ssuf.Lock(TRect(nil^), SrcDDSD);
      SrcBits := SrcDDSD.lpSurface;
      DstBits := DstDDSD.lpSurface;
      if IsSSE then begin
        for I := srctop to srcbottom - 1 do begin
          sptr := PWord(Integer(SrcBits) + SrcDDSD.lPitch * I + srcleft * 2);
          dptr := PWord(Integer(DstBits) + (Y + I - srctop) * DstDDSD.lPitch + X * 2);
          j := srcwidth div 4;
          k := srcwidth mod 4;
          asm
                                    push edx
                                    push ecx
                           //sse2处理
                            @@SSE:
                                    cmp j,0  //if j = 0
                                    jle @@Exit //跳转Exit
                                    cmp j,1 //if j = 1
                                    jle @@MMX //跳转MMX

                                    mov ecx,sptr//ecx:=sptr
                                    mov edx,dptr//edx:=dptr

                                    movdqu xmm7,[ecx] //xmm7 := sptr
                                    movlps xmm4,maskkey//把源存储器64位内容送入目的寄存器低64位,高64位不变,内存变量不必对齐内存16字节.
                                    movhps xmm4,maskkey//把源存储器64位内容送入目的寄存器高64位,低64位不变,内存变量不必对齐内存16字节.
                                    PCMPEQW xmm7,xmm4//目的寄存器与源存储器按字比较,如果对应字相等,就置目的寄存器对应字为0ffffh,否则为0000h, 

                                    movdqu xmm0,[ecx]//MOVDQA 和 MOVDQU 指令用于把 128 位数据传送到 XMM 寄存器中，或者在 XMM 寄存器之间传送数据。助记符的 A 和 U 分别代表对准和不对准，它们表示数据是如何存储在内存中的。如果对准 16 个字节边界的数据，就使用 A 选项；否则，就使用 U 选项。
                                    movdqu xmm1,[edx]//MOVDQA 和 MOVDQU 指令用于把 128 位数据传送到 XMM 寄存器中，或者在 XMM 寄存器之间传送数据。助记符的 A 和 U 分别代表对准和不对准，它们表示数据是如何存储在内存中的。如果对准 16 个字节边界的数据，就使用 A 选项；否则，就使用 U 选项。
                                    movlps xmm4,maskred//把源存储器64位内容送入目的寄存器低64位,高64位不变,内存变量不必对齐内存16字节.
                                    movhps xmm4,maskred//把源存储器64位内容送入目的寄存器高64位,低64位不变,内存变量不必对齐内存16字节. 
                                    pand xmm0,xmm4//r := (sptr^) and $F800
                                    pand xmm1,xmm4//dr := (dptr^) and $F800
                                    PSRLW xmm0,8//往右移8位 r := r shr 8
                                    PSRLW xmm1,8//往右移8位 dr := dr shr 8
                                    movlps xmm2,maskdate1//把源存储器64位内容送入目的寄存器低64位,高64位不变,内存变量不必对齐内存16字节.
                                    movhps xmm2,maskdate1//把源存储器64位内容送入目的寄存器高64位,低64位不变,内存变量不必对齐内存16字节.
                                    PSUBUSW xmm2,xmm0//源存储器与目的寄存器按字对齐无符号饱和相减(目的减去源),内存变量必须对齐内存16字节. 255-r  
                                    PMULLW xmm2,xmm1//有符号数乘取低位  (255-r) * dr
                                    PSRLW xmm2,8      //成组数据的逻辑右移8 ((255-r) * dr) shr 8
                                    PADDUSW xmm2,xmm0 //把目的寄存器按字由源存储器(或imm8 立即数)指定位数逻辑右移,移出的位丢失. 
                                    movlps xmm4,maskdate3//把源存储器64位内容送入目的寄存器低64位,高64位不变,内存变量不必对齐内存16字节.
                                    movhps xmm4,maskdate3//把源存储器64位内容送入目的寄存器高64位,低64位不变,内存变量不必对齐内存16字节. 
                                    PMINSW xmm2,xmm4//把源存储器与目的寄存器按字有符号(补码)整数比较,较小数放入目的寄存器对应字,源存储器为m128时,内存变量必须对齐内存16字节.  
                                    movlps xmm4,maskdate5
                                    movhps xmm4,maskdate5
                                    PMAXSW xmm2,xmm4
                                    PSLLW xmm2,8
                                    movlps xmm4,maskred
                                    movhps xmm4,maskred
                                    pand xmm2,xmm4

                                    movdqu xmm0,[ecx]
                                    movdqu xmm1,[edx]
                                    movlps xmm4,maskgreen
                                    movhps xmm4,maskgreen
                                    pand xmm0,xmm4
                                    pand xmm1,xmm4
                                    PSRLW xmm0,3
                                    PSRLW xmm1,3
                                    movlps xmm3,maskdate1
                                    movhps xmm3,maskdate1
                                    PSUBUSW xmm3,xmm0
                                    PMULLW xmm3,xmm1
                                    PSRLW xmm3,8
                                    PADDUSW xmm3,xmm0
                                    movlps xmm4,maskdate4
                                    movhps xmm4,maskdate4
                                    PMINSW xmm3,xmm4
                                    movlps xmm4,maskdate6
                                    movhps xmm4,maskdate6
                                    PMAXSW xmm3,xmm4
                                    PSLLW xmm3,3
                                    movlps xmm4,maskgreen
                                    movhps xmm4,maskgreen
                                    pand xmm3,xmm4
                                    por xmm2,xmm3

                                    movdqu xmm0,[ecx]
                                    movdqu xmm1,[edx]
                                    movlps xmm4,maskblue
                                    movhps xmm4,maskblue
                                    pand xmm0,xmm4
                                    pand xmm1,xmm4
                                    PSLLW xmm0,3
                                    PSLLW xmm1,3
                                    movlps xmm3,maskdate1
                                    movhps xmm3,maskdate1
                                    PSUBUSW xmm3,xmm0
                                    PMULLW xmm3,xmm1
                                    PSRLW xmm3,8
                                    PADDUSW xmm3,xmm0
                                    movlps xmm4,maskdate3
                                    movhps xmm4,maskdate3
                                    PMINSW xmm3,xmm4
                                    movlps xmm4,maskdate5
                                    movhps xmm4,maskdate5
                                    PMAXSW xmm3,xmm4
                                    PSRLW xmm3,3
                                    movlps xmm4,maskblue
                                    movhps xmm4,maskblue
                                    pand xmm3,xmm4
                                    por xmm2,xmm3

                                    movdqu xmm1,[edx]
                                    pand xmm1,xmm7
                                    movlps xmm4,maskdate2
                                    movhps xmm4,maskdate2
                                    pandn xmm7,xmm4
                                    pand xmm2,xmm7

                                    por xmm2,xmm1
                                    movdqu [edx],xmm2

                                    add ecx,16
                                    add edx,16
                                    mov sptr,ecx
                                    mov dptr,edx

                                    sub j,2
                                    jmp @@SSE

                            //mmx处理
                            @@MMX:
                                    cmp j,0
                                    jle @@Exit

                                    mov ecx,sptr //ecx:=sptr
                                    mov edx,dptr //edx:=dptr

                                    movq mm7,[ecx] //mm7:=ecx
                                    PCMPEQW mm7,maskkey//该指令将目标操作数和源操作数的相应数据元素进行比较,相等则目标寄存器的对应数据元素被置为全1,否则置为全0.
                                    //red颜色操作
                                    //pascal code
                                    //r := (sptr^) and $F800 shr 8;
                                    //dr := (dptr^) and $F800 shr 8;
                                    //r := _MIN(255, r + Round((255 - r) / 255 * dr));
                                    //r shl 8 and $F800

                                    movq mm0,[ecx]//mm0 := ecx
                                    movq mm1,[edx]//mm1 := edx
                                    pand mm0,maskred //mm0 := r :=(sptr^) and $F800
                                    pand mm1,maskred //mm1 := rd :=(dptr^) and $F800
                                    PSRLW mm0,8 //成组数据的逻辑右移8 mm0 := r:= (sptr^) and $F800 shr 8
                                    PSRLW mm1,8 //成组数据的逻辑右移8 mm1 := dr :=(dptr^) and $F800 shr 8
                                    movq mm2,maskdate1  //mm2 := maskdate1     maskdate1:=$00FF := 255
                                    PSUBUSW mm2,mm0//饱和方式相减,小于0为0   mm2 := 255-r
                                    PMULLW mm2,mm1 //mm2 := (255-r) *dr
                                    PSRLW mm2,8      //成组数据的逻辑右移8   ((255-r) * dr / 255   往右移8位 也可以为除255
                                    PADDUSW mm2,mm0 //饱和方式相加 mm2+mm0  mm2 := (((255-r) *rd) / 255)+r
                                    PMINSW mm2,maskdate3//r := _Min((((255-r) * (dptr^)*rd) / 255)+r, $00F800F800F800F8{248});
                                    PMAXSW mm2,maskdate5// _Max(r, $0008000800080008{8});
                                    PSLLW mm2,8 //r := r shl 8
                                    pand mm2,maskred//r := r and $F800
                                    //green颜色操作
                                    movq mm0,[ecx]
                                    movq mm1,[edx]
                                    pand mm0,maskgreen
                                    pand mm1,maskgreen
                                    PSRLW mm0,3
                                    PSRLW mm1,3
                                    movq mm3,maskdate1
                                    PSUBUSW mm3,mm0
                                    PMULLW mm3,mm1
                                    PSRLW mm3,8
                                    PADDUSW mm3,mm0
                                    PMINSW mm3,maskdate4
                                    PMAXSW mm3,maskdate6
                                    PSLLW mm3,3
                                    pand mm3,maskgreen
                                    por mm2,mm3

                                    movq mm0,[ecx]
                                    movq mm1,[edx]
                                    pand mm0,maskblue
                                    pand mm1,maskblue
                                    PSLLW mm0,3
                                    PSLLW mm1,3
                                    movq mm3,maskdate1
                                    PSUBUSW mm3,mm0
                                    PMULLW mm3,mm1
                                    PSRLW mm3,8
                                    PADDUSW mm3,mm0
                                    PMINSW mm3,maskdate3
                                    PMAXSW mm3,maskdate5
                                    PSRLW mm3,3
                                    pand mm3,maskblue
                                    por mm2,mm3

                                    movq mm1,[edx]
                                    pand mm1,mm7
                                    pandn mm7,maskdate2
                                    pand mm2,mm7

                                    por mm2,mm1
                                    movq [edx],mm2
                            @@Nextflag:
                                    add ecx,8
                                    add edx,8
                                    mov sptr,ecx
                                    mov dptr,edx

                                    sub j,1
                                    jmp @@MMX

                            @@Exit:
                                    emms
                                    pop edx
                                    pop ecx

          end;                                      
          for L := 1 to k do begin //剩余像素处理
            r := (sptr^) and $F800 shr 8;
            G := (sptr^) and $07E0 shr 3;
            b := (sptr^) and $001F shl 3;

            dr := (dptr^) and $F800 shr 8;
            dg := (dptr^) and $07E0 shr 3;
            db := (dptr^) and $001F shl 3;

            r := _MIN(255, r + Round((255 - r) / 255 * dr));
            G := _MIN(255, G + Round((255 - G) / 255 * dg));
            b := _MIN(255, b + Round((255 - b) / 255 * db));

            dptr^ := (r shl 8 and $F800) or (G shl 3 and $07E0) or (b shr 3 and $001F);
            Inc(sptr, 1);
            Inc(dptr, 1);
          end;
        end;
      end else begin
        for I := srctop to srcbottom - 1 do begin
          sptr := PWord(Integer(SrcBits) + SrcDDSD.lPitch * I + srcleft * 2);
          dptr := PWord(Integer(DstBits) + (Y + I - srctop) * DstDDSD.lPitch + X * 2);
          j := srcwidth div 4;
          k := srcwidth mod 4;
          asm
                                    push edx
                                    push ecx
                            //mmx处理
                            @@MMX:
                                    cmp j,0   //J是否为0
                                    jle @@Exit

                                    mov ecx,sptr //sptr移入ecx
                                    mov edx,dptr //edx

                                    movq mm7,[ecx] //sptr的8 bytes 到 mm7--4个sptr点到mm7
                                    PCMPEQW mm7,maskkey  // 比较 maskkey 和原来的sptr,如果相等,则相应的mm7的位为1
                                    //red颜色操作
                                    //pascal code
                                    //r := (sptr^) and $F800 shr 8;
                                    //dr := (dptr^) and $F800 shr 8;
                                    //r := _MIN(255, r + Round((255 - r) / 255 * dr));
                                    //r shl 8 and $F800
                                    //mmx算法
                                    //r := (sptr^) and $F800 shr 8;
                                    //dr := (dptr^) and $F800 shr 8;
                                    //r := r + (255 - r) * dr / 255
                                    movq mm0,[ecx] //mm0 := sptr
                                    movq mm1,[edx] //mm1 := dptr
                                    pand mm0,maskred //r :=(sptr^) and $F800
                                    pand mm1,maskred //dr :=(dptr^) and $F800;
                                    PSRLW mm0,8 //r:= r shr 8
                                    PSRLW mm1,8 //dr := dr shr 8
                                    movq mm2,maskdate1 //mm2 := $00FF := 255
                                    PSUBUSW mm2,mm0 //饱和方式相减,小于0为0   mm2 := 255 - r 
                                    PMULLW mm2,mm1 //mm2 := (255-r) *dr
                                    PSRLW mm2,8      //成组数据的逻辑右移8  ((255-r) * dr / 255   往右移8位 也可以为除255
                                    PADDUSW mm2,mm0  //((255-r) * dr / 255 + r
                                    PMINSW mm2,maskdate3
                                    PMAXSW mm2,maskdate5
                                    PSLLW mm2,8
                                    pand mm2,maskred

                                    movq mm0,[ecx]
                                    movq mm1,[edx]
                                    pand mm0,maskgreen
                                    pand mm1,maskgreen
                                    PSRLW mm0,3
                                    PSRLW mm1,3
                                    movq mm3,maskdate1
                                    PSUBUSW mm3,mm0
                                    PMULLW mm3,mm1
                                    PSRLW mm3,8
                                    PADDUSW mm3,mm0
                                    PMINSW mm3,maskdate4
                                    PMAXSW mm3,maskdate6
                                    PSLLW mm3,3
                                    pand mm3,maskgreen
                                    por mm2,mm3

                                    movq mm0,[ecx]
                                    movq mm1,[edx]
                                    pand mm0,maskblue
                                    pand mm1,maskblue
                                    PSLLW mm0,3
                                    PSLLW mm1,3
                                    movq mm3,maskdate1
                                    PSUBUSW mm3,mm0
                                    PMULLW mm3,mm1
                                    PSRLW mm3,8
                                    PADDUSW mm3,mm0
                                    PMINSW mm3,maskdate3
                                    PMAXSW mm3,maskdate5
                                    PSRLW mm3,3
                                    pand mm3,maskblue
                                    por mm2,mm3

                                    movq mm1,[edx]
                                    pand mm1,mm7
                                    pandn mm7,maskdate2
                                    pand mm2,mm7

                                    por mm2,mm1
                                    movq [edx],mm2
                            @@Nextflag:
                                    add ecx,8
                                    add edx,8
                                    mov sptr,ecx
                                    mov dptr,edx

                                    sub j,1
                                    jmp @@MMX

                            @@Exit:
                                    emms
                                    pop edx
                                    pop ecx

          end;
          for L := 1 to k do begin //剩余像素处理
            r := (sptr^) and $F800 shr 8;
            G := (sptr^) and $07E0 shr 3;
            b := (sptr^) and $001F shl 3;

            dr := (dptr^) and $F800 shr 8;
            dg := (dptr^) and $07E0 shr 3;
            db := (dptr^) and $001F shl 3;       //RGBEffects[BGRS[dptr^].R, BGRS[sptr^].R] shl 8 and $F800)

            r := _MIN(255, r + Round((255 - r) / 255 * dr));
            G := _MIN(255, G + Round((255 - G) / 255 * dg));
            b := _MIN(255, b + Round((255 - b) / 255 * db));

            dptr^ := (r shl 8 and $F800) or (G shl 3 and $07E0) or (b shr 3 and $001F);
            Inc(sptr, 1);
            Inc(dptr, 1);
          end;
        end;
      end;
    finally
      SSuf.UnLock();
      DSuf.UnLock();
    end;
end;
//查表
{procedure DrawBlendEx (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode: integer; btAlpha:Byte);
var
  ta, tb, tc, td, I, II, j, k, L, tmp, srcleft, srctop, srcwidth, srcbottom, sidx, didx: Integer;
  sptr, dptr, pmix: PWord;
  bitindex, scount, dcount, SrcLen, destlen, wcount, AWidth, bwidth: Integer;

  SrcBits, DstBits: PWord;
  SrcDDSD, DstDDSD: TDDSurfaceDesc2;
begin
  if (dsuf = nil) or (ssuf = nil) then Exit;
  if X >= dsuf.Width then Exit;
  if Y >= dsuf.Height then Exit;

  if X < 0 then begin
    srcleft := -X;
    srcwidth := ssufwidth + X;
    X := 0;
  end else begin
    srcleft := ssufleft;
    srcwidth := ssufwidth;
  end;
  if Y < 0 then begin
    srctop := -Y;
    srcbottom := ssufheight;
    Y := 0;
  end else begin
    srctop := ssuftop;
    srcbottom := srctop + ssufheight;
  end;
  if srcleft + srcwidth > ssuf.Width then srcwidth := ssuf.Width - srcleft;
  if srcbottom > ssuf.Height then
    srcbottom := ssuf.Height; //-srcheight;
  if X + srcwidth > dsuf.Width then srcwidth := (dsuf.Width - X) div 4 * 4;
  if Y + srcbottom - srctop > dsuf.Height then
    srcbottom := dsuf.Height - Y + srctop;
  if (X + srcwidth) * (Y + srcbottom - srctop) > dsuf.Width * dsuf.Height then //烙矫..
    srcbottom := srctop + (srcbottom - srctop) div 2;

  if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= ssuf.Width) or (srctop >= ssuf.Height) then Exit;

  if srcwidth > SCREENWIDTH + 100 then Exit;

  AWidth := srcwidth div 4; //ssuf.Width div 4;
  bwidth := srcwidth; //ssuf.Width;
  SrcLen := srcwidth; //ssuf.Width;
  destlen := srcwidth; //ssuf.Width;
    try
      SrcDDSD.dwSize := SizeOf(SrcDDSD);
      DstDDSD.dwSize := SizeOf(DstDDSD);
      dsuf.Lock(TRect(nil^), DstDDSD);
      ssuf.Lock(TRect(nil^), SrcDDSD);
      SrcBits := SrcDDSD.lpSurface;
      DstBits := DstDDSD.lpSurface;
      for I := srctop to srcbottom - 1 do begin
        sptr := PWord(Integer(SrcBits) + SrcDDSD.lPitch * I + srcleft * 2);
        dptr := PWord(Integer(DstBits) + (Y + I - srctop) * DstDDSD.lPitch + X * 2);
        for II := 0 to srcwidth - 1 do begin
          dptr^ :=
            (RGBEffects[BGRS[dptr^].R, BGRS[sptr^].R] shl 8 and $F800) or
            (RGBEffects[BGRS[dptr^].G, BGRS[sptr^].G] shl 3 and $07E0) or
            (RGBEffects[BGRS[dptr^].B, BGRS[sptr^].B] shr 3 and $001F);
        
          Inc(sptr); Inc(dptr);
        end;
      end;
    finally
      SSuf.UnLock();
      DSuf.UnLock();
    end;
end;  }

//解决火龙教主引起程序崩溃问题  20080608
procedure DrawEx (dsuf: TDirectDrawSurface; x, y: integer; ssuf: TDirectDrawSurface; ssufleft, ssuftop, ssufwidth, ssufheight, blendmode: integer);
var
   i, srcleft, srctop, srcwidth, srcbottom, sidx: integer;
   sddsd, dddsd: TDDSurfaceDesc2;
   sptr, dptr, pmix: PByte;
   source, dest: array[0..910] of byte;
   scount, dcount, srclen, destlen, wcount, awidth, bwidth: integer;
begin
   if (dsuf.canvas = nil) or (ssuf.canvas = nil) then exit;
   if x >= dsuf.Width then exit;
   if y >= dsuf.Height then exit;
   if x < 0 then begin
      srcleft := -x;
      srcwidth := ssufwidth + x;
      x := 0;
   end else begin
      srcleft := ssufleft;
      srcwidth := ssufwidth;
   end;
   if y < 0 then begin
      srctop := -y;
      srcbottom := ssufheight;
      y := 0;
   end else begin
      srctop := ssuftop;
      srcbottom := srctop + ssufheight;
   end;
   if srcleft + srcwidth > ssuf.Width then srcwidth := ssuf.Width-srcleft;
   if srcbottom > ssuf.Height then
      srcbottom := ssuf.Height;
   if x + srcwidth > dsuf.Width then srcwidth := (dsuf.Width-x) div 4 * 4;
   if y + srcbottom - srctop > dsuf.Height then
      srcbottom := dsuf.Height-y+srctop;
   if (x+srcwidth) * (y+srcbottom-srctop) > dsuf.Width * dsuf.Height then
      srcbottom := srctop + (srcbottom-srctop) div 2;

   if (srcwidth <= 0) or (srcbottom <= 0) or (srcleft >= ssuf.Width) or (srctop >= ssuf.Height) then exit;
   if srcWidth > SCREENWIDTH + 100 then exit;
   try
      sddsd.dwSize := SizeOf(sddsd);
      dddsd.dwSize := SizeOf(dddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      dsuf.Lock (TRect(nil^), dddsd);
      awidth := srcwidth div 4; //ssuf.Width div 4;
      bwidth := srcwidth; //ssuf.Width;
      srclen := srcwidth; //ssuf.Width;
      destlen := srcwidth; //ssuf.Width;
      pmix := @Color256real[0,0];
      for i:=srctop to srcbottom-1 do begin
         sptr := PBYTE(integer(sddsd.lpSurface) + sddsd.lPitch * i + srcleft);
         dptr := PBYTE(integer(dddsd.lpSurface) + (y+i-srctop) * dddsd.lPitch + x);
         asm
               mov   scount, 0
               mov   esi, sptr
               lea   edi, source
               mov   ebx, scount        //ebx = scount
            @@CopySource:
               cmp   ebx, srclen
               jae    @@EndSourceCopy
               db $0F,$6F,$04,$1E       /// movq  mm0, [esi+ebx]
               db $0F,$7F,$04,$1F       /// movq  [edi+ebx], mm0
               add   ebx, 8
               jmp   @@CopySource
            @@EndSourceCopy:

               mov   dcount, 0
               mov   esi, dptr
               lea   edi, dest
               mov   ebx, dcount
            @@CopyDest:
               cmp   ebx, destlen
               jae    @@EndDestCopy
               db $0F,$6F,$04,$1E       /// movq  mm0, [esi+ebx]
               db $0F,$7F,$04,$1F       /// movq  [edi+ebx], mm0
               add   ebx, 8
               jmp   @@CopyDest
            @@EndDestCopy:

               lea   esi, source
               lea   edi, dest
               mov   wcount, 0

            @@BlendNext:
               mov   ebx, wcount
               cmp   [esi+ebx].byte, 0     //if _src[bitindex] > 0
               jz    @@EndBlend

               movzx eax, [esi+ebx].byte     //sidx := _src[bitindex]
               shl   eax, 8                  //sidx * 256
               mov   sidx, eax

               movzx eax, [edi+ebx].byte     //didx := _dest[bitindex]
               add   sidx, eax

               mov   edx, pmix
               mov   ecx, sidx
               movzx eax, [edx+ecx].byte     //
               mov   [edi+ebx], al

            @@EndBlend:
               inc   wcount
               mov   eax, bwidth
               cmp   wcount, eax
               jb    @@BlendNext

               lea   esi, dest               //Move (_src, dptr^, 4)
               mov   edi, dptr
               mov   ecx, awidth
               cld
               rep movsd

         end;
      end;
      asm
         db $0F,$77               /// emms
      end;

   finally
      ssuf.UnLock();
      dsuf.UnLock();
   end;
end;
{
procedure DrawEffect (x, y, width, height: integer; ssuf: TDirectDrawSurface; eff: TColorEffect);
var
   i, j, n,srclen: integer;
   sddsd: DDSURFACEDESC2;
   wptr:PWord;
   b1,b2,b3:byte;
begin
       case eff of
         ceBright :begin  //高亮
           try
             sddsd.dwSize := SizeOf(sddsd);
             ssuf.Lock (TRect(nil^), sddsd);
             srclen := width;
             for i:=0 to height-1 do begin
               wptr :=PWord (integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
               for j:=0 to srclen -1 do
               begin
                 if wptr^=$FFFF then
                   wptr^:=0
                 else begin
                   b1:=_Min(31,round(((wptr^ and $F800) shr 11)*1.2));
                   b2:=_Min(63,round(((wptr^ and $7E0) shr 5)*1.2));
                   b3:=_Min(31,round((wptr^ and $1F)*1.2));
                   wptr^:=(b1 shl 11) or (b2 shl 5) or b3;
                 end;
                 wptr:=PWord(integer(wptr)+2);
               end;
             end;
           finally
             ssuf.UnLock;
           end;
         end;
         ceGrayScale:begin
           try
             sddsd.dwSize := SizeOf(sddsd);
             ssuf.Lock (TRect(nil^), sddsd);
             srclen := width;
             for i:=0 to height-1 do begin
               wptr :=PWord (LongInt(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
               for j:=0 to srclen -1 do
               begin
                 if wptr^=$FFFF then
                   wptr^:=0
                 else begin
                   b1:=(wptr^ and $F800) shr 11;
                   b2:=(wptr^ and $7E0) shr 5;
                   b3:=wptr^ and $1F;
                   n:=(b1+b2+b3) div 4;
                   wptr^:=(n shl 11) or (n shl 6) or n;
                 end;
                 wptr:=PWord(integer(wptr)+2);
               end;
             end;
           finally
             ssuf.UnLock;
           end;
         end;
         ceBlack:begin
           try
             sddsd.dwSize := SizeOf(sddsd);
             ssuf.Lock (TRect(nil^), sddsd);
             srclen := width;
             for i:=0 to height-1 do begin
               wptr :=PWord (integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
               for j:=0 to srclen -1 do
               begin
                 if wptr^=$FFFF then
                   wptr^:=0
                  else begin
                    b1:=(wptr^ and $F800) shr 11;
                    b2:=(wptr^ and $7E0) shr 5;
                    b3:=wptr^ and $1F;
                    n:=round(((b1+b2+b3) div 4)*0.6);
                    wptr^:=(n shl 11) or (n shl 6) or n;
                  end;
                  wptr:=PWord(integer(wptr)+2);
                end;
              end;
            finally
              ssuf.UnLock;
            end;
          end;
         ceWhite:begin
            try
              sddsd.dwSize := SizeOf(sddsd);
              ssuf.Lock (TRect(nil^), sddsd);
              srclen := width;
              for i:=0 to height-1 do begin
                wptr :=PWord (integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
                for j:=0 to srclen -1 do
                begin
                  if wptr^=$FFFF then
                    wptr^:=0
                  else begin
                    b1:=(wptr^ and $F800) shr 11;
                    b2:=(wptr^ and $7E0) shr 5;
                    b3:=wptr^ and $1F;
                    n:=round(((b1+b2+b3) div 4)*1.6);
                    wptr^:=(n shl 11) or (n shl 6) or n;
                  end;
                  wptr:=PWord(integer(wptr)+2);
                end;
              end;
            finally
              ssuf.UnLock;
            end;
         end;
         ceRed:begin
           try
             sddsd.dwSize := SizeOf(sddsd);
             ssuf.Lock (TRect(nil^), sddsd);
             srclen := width;
             for i:=0 to height-1 do begin
               wptr :=PWord (integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
               for j:=0 to srclen -1 do
               begin
                 if wptr^=$FFFF then
                   wptr^:=0
                 else begin
                   b1:=(wptr^ and $F800) shr 11;
                   b2:=(wptr^ and $7E0) shr 5;
                   b3:= wptr^ and $1F;
                   n:=(b1+b2+b3) div 4;
                   wptr^:=n shl 11;
                 end;
                 wptr:=PWord(integer(wptr)+2);
               end;
             end;
           finally
             ssuf.UnLock;
           end;
         end;
         ceGreen:begin
           try
             sddsd.dwSize := SizeOf(sddsd);
             ssuf.Lock (TRect(nil^), sddsd);
             srclen := width;
             for i:=0 to height-1 do begin
               wptr :=PWord (integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
               for j:=0 to srclen -1 do
               begin
                 if wptr^=$FFFF then
                   wptr^:=0
                 else begin
                   b1:=(wptr^ and $F800) shr 11;
                   b2:=(wptr^ and $7E0) shr 5;
                   b3:= wptr^ and $1F;
                   n:=(b1+b2+b3) div 4;
                   wptr^:=n shl 6;
                 end;
                 wptr:=PWord(integer(wptr)+2);
               end;
             end;
           finally
             ssuf.UnLock;
           end;
         end;
         ceBlue:begin
           try
             sddsd.dwSize := SizeOf(sddsd);
             ssuf.Lock (TRect(nil^), sddsd);
             srclen := width;
             for i:=0 to height-1 do begin
               wptr :=PWord (integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
               for j:=0 to srclen -1 do
               begin
                 if wptr^=$FFFF then
                   wptr^:=0
                 else begin
                   b1:=(wptr^ and $F800) shr 11;
                   b2:=(wptr^ and $7E0) shr 5;
                   b3:= wptr^ and $1F;
                   wptr^:=(b1+b2+b3) div 4;
                 end;
                 wptr:=PWord(integer(wptr)+2);
               end;
             end;
           finally
             ssuf.UnLock;
           end;
         end;
         ceYellow:begin
           try
             sddsd.dwSize := SizeOf(sddsd);
             ssuf.Lock (TRect(nil^), sddsd);
             srclen := width;
             for i:=0 to height-1 do begin
               wptr :=PWord (integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
               for j:=0 to srclen -1 do
               begin
                 if wptr^=$FFFF then
                   wptr^:=0
                 else begin
                   b1:=(wptr^ and $F800) shr 11;
                   b2:=(wptr^ and $7E0) shr 5;
                   b3:= wptr^ and $1F;
                   n:=(b1+b2+b3) div 4;
                   wptr^:=(n shl 11) or (n shl 6);
                 end;
                 wptr:=PWord(integer(wptr)+2);
               end;
             end;
           finally
             ssuf.UnLock;
           end;
         end;
         ceFuchsia:begin
           try
             sddsd.dwSize := SizeOf(sddsd);
             ssuf.Lock (TRect(nil^), sddsd);
             srclen := width;
             for i:=0 to height-1 do begin
               wptr :=PWord (integer(sddsd.lpSurface) + (y+i) * sddsd.lPitch + x);
               for j:=0 to srclen -1 do
               begin
                 if wptr^=$FFFF then
                   wptr^:=0
                 else begin
                   b1:=(wptr^ and $F800) shr 11;
                   b2:=(wptr^ and $7E0) shr 5;
                   b3:= wptr^ and $1F;
                   n:=(b1+b2+b3) div 4;
                   wptr^:=(n shl 11) or n;
                 end;
                 wptr:=PWord(integer(wptr)+2);
               end;
             end;
           finally
             ssuf.UnLock;
           end;
         end;
       end;
end;      }

procedure DrawEffect(X, Y: Integer; ssuf, dsuf: TDirectDrawSurface; eff: TColorEffect);
  procedure BlackEffect(X, Y, Width, Height: Integer;
    ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      //srclen := width;
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then
          begin
            tmp := sptr^;
            r := Word(_MAX(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3 * 0.6), 1));
            G := r;
            b := r;
            sptr^ := Word((r and $F8 shl 8) or (G and $FC shl 3) or (b and $F8 shr 3));
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;

  procedure WhiteEffect(X, Y, Width, Height: Integer;
    ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
                                   //if not ((sptr^)=0) then
          begin
            tmp := sptr^;
            r := Word(_MIN(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3 * 1.6), 255));
            G := r;
            b := r;
            sptr^ := Word((r and $F8 shl 8) or (G and $FC shl 3) or (b and $F8 shr 3));
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;

  procedure GreenEffect(X, Y, Width, Height: Integer;
    ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b, n: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then
          begin
            tmp := sptr^;
            r := 0;
            G := Word(_MAX(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3), $20)); //max处理见蓝色的注释
            b := 0;
            sptr^ := Word((r and $F8 shl 8) or (G and $FC shl 3) or (b and $F8 shr 3));
            sptr^ := G and $FC shl 3;
                                                  {r := tmp and $F800 shr 8;
                                                  g := tmp and $07E0 shr 3;
                                                  b := tmp and $001F shl 3;
                                                  if (r > 0) or (g > 0) or (b > 0) then begin
                                                          g := _max(round((r + g + b)/3),$20);
                                                          sptr^ := g and $FC shl 3;
                                                  end else begin

                                                  end;   }


          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;

  procedure BlueEffect(X, Y, Width, Height: Integer;
    ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then begin
            tmp := sptr^;
            r := 0;
            G := 0;
            b := Word(_MAX(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3), $08)); //0x08是最小的颜色值，如果不这样处理，可能会变成黑色，就是透明了
            sptr^ := Word((r and $F8 shl 8) or (G and $FC shl 3) or (b and $F8 shr 3));
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;

  procedure YellowEffect(X, Y, Width, Height: Integer; ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then
          begin
            tmp := sptr^;
            r := Word(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3));
            G := r;
            b := 0;
            sptr^ := Word((r and $F8 shl 8) or (G and $FC shl 3) or (b and $F8 shr 3));
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;

  procedure FuchsiaEffect(X, Y, Width, Height: Integer; ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then
          begin
            tmp := sptr^;
            r := Word(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3));
            G := 0;
            b := r;
            sptr^ := _MAX(Word((r and $F8 shl 8) or (b and $F8 shr 3)), $0801);
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;


//iamwgh加亮效果        psrlq mm1,1

  procedure BrightEffect(ssuf: TDirectDrawSurface; Width, Height: Integer);
  var
    I, j, k, L: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (I * sddsd.lPitch));
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then
          begin
            tmp := sptr^;
            r := _MIN(Round((tmp and $F800 shr 8) * 1.3), 255);
            G := _MIN(Round((tmp and $07E0 shr 3) * 1.3), 255);
            b := _MIN(Round((tmp and $001F shl 3) * 1.3), 255);
            sptr^ := Word((r and $F8 shl 8) or (G and $FC shl 3) or (b and $F8 shr 3));
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;

//iamwgh黑白效果，灰度

  procedure GrayEffect(X, Y, Width, Height: Integer; ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then
          begin
            tmp := sptr^;
            r := Word(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3));
            G := r;
            b := r;
            sptr^ := _MAX(Word((r and $F8 shl 8) or (G and $FC shl 3) or (b and $F8 shr 3)), $0821);
                                                  {if  ((tmp and $F800 shr 8) = 160)  or ((r>200) and (g>200) and (b>200)) then
                                                  begin
                                                          sptr^ := $0821;
                                                  end;     }
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;

//iamwgh红色效果

  procedure RedEffect(X, Y, Width, Height: Integer; ssuf: TDirectDrawSurface);
  var
    I, j: Integer;
    sptr: PWord;
    tmp: Word;
    r, G, b: byte;
    sddsd: TDDSURFACEDESC2;
  begin
    try
      sddsd.dwSize := SizeOf(sddsd);
      ssuf.Lock (TRect(nil^), sddsd);
      for I := 0 to Height - 1 do begin
        sptr := PWord(Integer(sddsd.lpSurface) + (Y + I) * sddsd.lPitch + X * 2);
        for j := 0 to Width - 1 do begin
          if not ((sptr^) = 0) then
          begin
            tmp := sptr^;
            r := Word(Round(((tmp and $F800 shr 8) + (tmp and $07E0 shr 3) + (tmp and $001F shl 3)) / 3));
            G := 0;
            b := 0;
            sptr^ := _MAX(Word(r and $F8 shl 8), $0800);
                                                  //sptr^ :=  word((r and $F8 shl 8) or (g and $FC shl 3) or (b and $F8 shr 3));
          end;
          Inc(sptr);
        end;
      end;
    finally
      ssuf.UnLock;
    end;
  end;
begin
  if ssuf = nil then Exit;
  case eff of
    ceBright: BrightEffect(ssuf, ssuf.Width, ssuf.Height);
    ceGrayScale: GrayEffect(X, Y,  ssuf.Width, ssuf.Height, ssuf);
    ceRed: RedEffect(X, Y,  ssuf.Width, ssuf.Height, ssuf);
    ceBlack: BlackEffect(X, Y,  ssuf.Width, ssuf.Height, ssuf);
    ceWhite: WhiteEffect(X, Y,  ssuf.Width, ssuf.Height, ssuf);
    ceGreen: GreenEffect(X, Y,  ssuf.Width, ssuf.Height, ssuf);
    ceBlue: BlueEffect(X, Y,  ssuf.Width, ssuf.Height, ssuf);
    ceYellow: YellowEffect(X, Y,  ssuf.Width, ssuf.Height, ssuf);
    ceFuchsia: FuchsiaEffect(X, Y,  ssuf.Width, ssuf.Height, ssuf);
  end;
end;



//解决火龙教主引起程序崩溃问题  20080608
procedure BuildRealRGB(ctable: TRGBQuads);
var
   MinDif, ColDif: Integer;
   MatchColor: Byte;
   pal0, pal1, pal2: TRGBQuad;
   I, j, n: integer;
begin
  for I:=0 to 255 do begin
     pal0 := ctable[i];
     for j:=0 to 255 do begin
        pal1 := ctable[j];
        pal1.rgbRed := pal0.rgbRed;
        pal1.rgbGreen := pal0.rgbGreen;
        pal1.rgbBlue := pal0.rgbBlue;
        MinDif := 1;
        MatchColor := 0;
        for n:=0 to 255 do begin
           pal2 := ctable[n];
           ColDif := Abs(pal2.rgbRed - pal1.rgbRed) +
                     Abs(pal2.rgbGreen - pal1.rgbGreen) +
                     Abs(pal2.rgbBlue - pal1.rgbBlue);
           if ColDif < MinDif then begin
              MinDif := ColDif;
              MatchColor := n;
           end;
        end;
        Color256real[i, j] := MatchColor;
     end;
  end;
end;
//查表混合初始化
procedure InitColorTable;
var
  I, II, III: Integer;
begin
  for I := 0 to High(Word) do begin
    BGRS[I].R := I and $F800 shr 8;
    BGRS[I].G := I and $07E0 shr 3;
    BGRS[I].B := I and $001F shl 3;
  end;

  for I := 0 to 255 do begin
    for II := 0 to 255 do begin
      RGBEffects[I, II] := _Min(255, II + Round((255 - II) / 255 * I));
    end;
  end;
end;
//查表混合初始化
initialization
  begin
    InitColorTable;
  end;
end.
