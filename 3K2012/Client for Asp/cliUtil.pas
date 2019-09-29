unit cliUtil;

interface

uses
  Windows, SysUtils, AsphyreDIB, HUtil32, Grobal2,
  AbstractCanvas;


const
   MAXGRADE = 64;

type
  TColorEffect = (ceNone, ceGrayScale{灰色}, ceBright, ceBlack, ceWhite, ceRed, ceGreen, ceBlue, ceYellow, ceFuchsia{紫红色});

  TNearestIndexHeader = record
    Title: string[30];
    IndexCount: integer;
    desc: array[0..10] of byte;
  end;

procedure BuildColorLevels (ctable: TRGBQuads);
procedure BuildNearestIndex (ctable: TRGBQuads);
procedure SaveNearestIndex (flname: string);
function  LoadNearestIndex (flname: string): Boolean;
procedure MakeDark (ssuf: TAsphyreCanvas; darklevel: integer);
{$IF M2Version = 2}
//procedure DrawFog (ssuf: TAsphyreCanvas; fogmask: PByte; fogwidth: integer);
//procedure FogCopy (PSource: Pbyte; ssx, ssy, swidth, sheight: integer;
//                   PDest: Pbyte; ddx, ddy, dwidth, dheight, maxfog: integer);
{$IFEND}
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

  masknogreen: Int64;
  maskred: Int64 = $F800F800F800F800;
  maskblue: Int64 = $001F001F001F001F;
  maskgreen: Int64 = $07E007E007E007E0;
  maskbyte: Int64 = $7E0F81F;
  maskkey: Int64 = $0000000000000000;
  maskdate1: Int64 = $00FF00FF00FF00FF;
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


//{$IF M2Version = 2}  //1.76
{procedure FogCopy (PSource: Pbyte; ssx, ssy, swidth, sheight: integer;
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

{procedure DrawFog (ssuf: TAsphyreCanvas; fogmask: PByte; fogwidth: integer);
var
  row: integer;
   ddsd: TDDSurfaceDesc2;
   srclen, srcheight: integer;
   lpitch: integer;
   {pSrc,} {psource, pColorLevel: pbyte;
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
end;}
// {$IFEND}

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
procedure MakeDark (ssuf: TAsphyreCanvas; darklevel: integer);
begin
   if not darklevel in [1..30] then exit;
   ssuf.FillRectAlpha(ssuf.ClientRect,0,round((30-darklevel)*255/30));
end;

end.
