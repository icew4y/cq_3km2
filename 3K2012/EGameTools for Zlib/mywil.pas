unit mywil;

interface

uses
  Windows, Classes, Graphics, SysUtils,  Dialogs,DIB, DirectDraw;

const
   UseDIBSurface : Boolean = FALSE;
   BoWilNoCache : Boolean = FALSE;
   MaxListSize=160000;

   //zlib
   ZlibTitle = 'www.shandagames.com';
   ColorArray: array[0..1023] of Byte = (
  $00, $00, $00, $00, $00, $00, $80, $00, $00, $80, $00, $00, $00, $80, $80, $00,
  $80, $00, $00, $00, $80, $00, $80, $00, $80, $80, $00, $00, $C0, $C0, $C0, $00,
  $97, $80, $55, $00, $C8, $B9, $9D, $00, $73, $73, $7B, $00, $29, $29, $2D, $00,
  $52, $52, $5A, $00, $5A, $5A, $63, $00, $39, $39, $42, $00, $18, $18, $1D, $00,
  $10, $10, $18, $00, $18, $18, $29, $00, $08, $08, $10, $00, $71, $79, $F2, $00,
  $5F, $67, $E1, $00, $5A, $5A, $FF, $00, $31, $31, $FF, $00, $52, $5A, $D6, $00,
  $00, $10, $94, $00, $18, $29, $94, $00, $00, $08, $39, $00, $00, $10, $73, $00,
  $00, $18, $B5, $00, $52, $63, $BD, $00, $10, $18, $42, $00, $99, $AA, $FF, $00,
  $00, $10, $5A, $00, $29, $39, $73, $00, $31, $4A, $A5, $00, $73, $7B, $94, $00,
  $31, $52, $BD, $00, $10, $21, $52, $00, $18, $31, $7B, $00, $10, $18, $2D, $00,
  $31, $4A, $8C, $00, $00, $29, $94, $00, $00, $31, $BD, $00, $52, $73, $C6, $00,
  $18, $31, $6B, $00, $42, $6B, $C6, $00, $00, $4A, $CE, $00, $39, $63, $A5, $00,
  $18, $31, $5A, $00, $00, $10, $2A, $00, $00, $08, $15, $00, $00, $18, $3A, $00,
  $00, $00, $08, $00, $00, $00, $29, $00, $00, $00, $4A, $00, $00, $00, $9D, $00,
  $00, $00, $DC, $00, $00, $00, $DE, $00, $00, $00, $FB, $00, $52, $73, $9C, $00,
  $4A, $6B, $94, $00, $29, $4A, $73, $00, $18, $31, $52, $00, $18, $4A, $8C, $00,
  $11, $44, $88, $00, $00, $21, $4A, $00, $10, $18, $21, $00, $5A, $94, $D6, $00,
  $21, $6B, $C6, $00, $00, $6B, $EF, $00, $00, $77, $FF, $00, $84, $94, $A5, $00,
  $21, $31, $42, $00, $08, $10, $18, $00, $08, $18, $29, $00, $00, $10, $21, $00,
  $18, $29, $39, $00, $39, $63, $8C, $00, $10, $29, $42, $00, $18, $42, $6B, $00,
  $18, $4A, $7B, $00, $00, $4A, $94, $00, $7B, $84, $8C, $00, $5A, $63, $6B, $00,
  $39, $42, $4A, $00, $18, $21, $29, $00, $29, $39, $46, $00, $94, $A5, $B5, $00,
  $5A, $6B, $7B, $00, $94, $B1, $CE, $00, $73, $8C, $A5, $00, $5A, $73, $8C, $00,
  $73, $94, $B5, $00, $73, $A5, $D6, $00, $4A, $A5, $EF, $00, $8C, $C6, $EF, $00,
  $42, $63, $7B, $00, $39, $56, $6B, $00, $5A, $94, $BD, $00, $00, $39, $63, $00,
  $AD, $C6, $D6, $00, $29, $42, $52, $00, $18, $63, $94, $00, $AD, $D6, $EF, $00,
  $63, $8C, $A5, $00, $4A, $5A, $63, $00, $7B, $A5, $BD, $00, $18, $42, $5A, $00,
  $31, $8C, $BD, $00, $29, $31, $35, $00, $63, $84, $94, $00, $4A, $6B, $7B, $00,
  $5A, $8C, $A5, $00, $29, $4A, $5A, $00, $39, $7B, $9C, $00, $10, $31, $42, $00,
  $21, $AD, $EF, $00, $00, $10, $18, $00, $00, $21, $29, $00, $00, $6B, $9C, $00,
  $5A, $84, $94, $00, $18, $42, $52, $00, $29, $5A, $6B, $00, $21, $63, $7B, $00,
  $21, $7B, $9C, $00, $00, $A5, $DE, $00, $39, $52, $5A, $00, $10, $29, $31, $00,
  $7B, $BD, $CE, $00, $39, $5A, $63, $00, $4A, $84, $94, $00, $29, $A5, $C6, $00,
  $18, $9C, $10, $00, $4A, $8C, $42, $00, $42, $8C, $31, $00, $29, $94, $10, $00,
  $10, $18, $08, $00, $18, $18, $08, $00, $10, $29, $08, $00, $29, $42, $18, $00,
  $AD, $B5, $A5, $00, $73, $73, $6B, $00, $29, $29, $18, $00, $4A, $42, $18, $00,
  $4A, $42, $31, $00, $DE, $C6, $63, $00, $FF, $DD, $44, $00, $EF, $D6, $8C, $00,
  $39, $6B, $73, $00, $39, $DE, $F7, $00, $8C, $EF, $F7, $00, $00, $E7, $F7, $00,
  $5A, $6B, $6B, $00, $A5, $8C, $5A, $00, $EF, $B5, $39, $00, $CE, $9C, $4A, $00,
  $B5, $84, $31, $00, $6B, $52, $31, $00, $D6, $DE, $DE, $00, $B5, $BD, $BD, $00,
  $84, $8C, $8C, $00, $DE, $F7, $F7, $00, $18, $08, $00, $00, $39, $18, $08, $00,
  $29, $10, $08, $00, $00, $18, $08, $00, $00, $29, $08, $00, $A5, $52, $00, $00,
  $DE, $7B, $00, $00, $4A, $29, $10, $00, $6B, $39, $10, $00, $8C, $52, $10, $00,
  $A5, $5A, $21, $00, $5A, $31, $10, $00, $84, $42, $10, $00, $84, $52, $31, $00,
  $31, $21, $18, $00, $7B, $5A, $4A, $00, $A5, $6B, $52, $00, $63, $39, $29, $00,
  $DE, $4A, $10, $00, $21, $29, $29, $00, $39, $4A, $4A, $00, $18, $29, $29, $00,
  $29, $4A, $4A, $00, $42, $7B, $7B, $00, $4A, $9C, $9C, $00, $29, $5A, $5A, $00,
  $14, $42, $42, $00, $00, $39, $39, $00, $00, $59, $59, $00, $2C, $35, $CA, $00,
  $21, $73, $6B, $00, $00, $31, $29, $00, $10, $39, $31, $00, $18, $39, $31, $00,
  $00, $4A, $42, $00, $18, $63, $52, $00, $29, $73, $5A, $00, $18, $4A, $31, $00,
  $00, $21, $18, $00, $00, $31, $18, $00, $10, $39, $18, $00, $4A, $84, $63, $00,
  $4A, $BD, $6B, $00, $4A, $B5, $63, $00, $4A, $BD, $63, $00, $4A, $9C, $5A, $00,
  $39, $8C, $4A, $00, $4A, $C6, $63, $00, $4A, $D6, $63, $00, $4A, $84, $52, $00,
  $29, $73, $31, $00, $5A, $C6, $63, $00, $4A, $BD, $52, $00, $00, $FF, $10, $00,
  $18, $29, $18, $00, $4A, $88, $4A, $00, $4A, $E7, $4A, $00, $00, $5A, $00, $00,
  $00, $88, $00, $00, $00, $94, $00, $00, $00, $DE, $00, $00, $00, $EE, $00, $00,
  $00, $FB, $00, $00, $94, $5A, $4A, $00, $B5, $73, $63, $00, $D6, $8C, $7B, $00,
  $D6, $7B, $6B, $00, $FF, $88, $77, $00, $CE, $C6, $C6, $00, $9C, $94, $94, $00,
  $C6, $94, $9C, $00, $39, $31, $31, $00, $84, $18, $29, $00, $84, $00, $18, $00,
  $52, $42, $4A, $00, $7B, $42, $52, $00, $73, $5A, $63, $00, $F7, $B5, $CE, $00,
  $9C, $7B, $8C, $00, $CC, $22, $77, $00, $FF, $AA, $DD, $00, $2A, $B4, $F0, $00,
  $9F, $00, $DF, $00, $B3, $17, $E3, $00, $F0, $FB, $FF, $00, $A4, $A0, $A0, $00,
  $80, $80, $80, $00, $00, $00, $FF, $00, $00, $FF, $00, $00, $00, $FF, $FF, $00,
  $FF, $00, $00, $00, $FF, $00, $FF, $00, $FF, $FF, $00, $00, $FF, $FF, $FF, $00
  );




type
//-----------------------Zlib----------------------
   TWMZlibIndexHeader = record
      Title: array[0..43] of Char;
      IndexCount: integer;      // 索引总数
      //VerFlag:integer;
   end;
   PTWMZlibIndexHeader = ^TWMZlibIndexHeader;

   TWMZlibIndexInfo = record
      Position: integer;
      Size: integer;
   end;
   PTWMZlibIndexInfo = ^TWMZlibIndexInfo;

  TWMZlibImageHeader = record
      Title: array[0..43] of Char;        //'WEMADE Entertainment inc.'
      ImageCount: integer;//图片数量
   end;
   PTWMZlibImageHeader = ^TWMZlibImageHeader;

   TWMZlibImageInfo = record
      wColor: Word; //颜色  8位$103  16位$105
      wUnknown: Word;//未知  估计位图的格式，盛大为D3D准备
      Width: smallint;
      Height: smallint;
      px: smallint;
      py: smallint;
      DecodeSize: Integer; //读流大小
   end;
   PTWMZlibImageInfo = ^TWMZlibImageInfo;
//-------------------------------------------------
  TWMImageHeader = record
      Title: string[40];        //'WEMADE Entertainment inc.'
      ImageCount: integer;//图片数量
      ColorCount: integer;//颜色数量
      PaletteSize: integer;
   end;
   PTWMImageHeader = ^TWMImageHeader;
      TWMImageInfo = record
      Width: smallint;
      Height: smallint;
      px: smallint;
      py: smallint;
      bits: PByte;
   end;
   PTWMImageInfo = ^TWMImageInfo;

   TWMIndexHeader =record//wix索引文件头
      Title: string[40];        //'WEMADE Entertainment inc.'
      IndexCount: integer;
   end;
   PTWMIndexHeader = ^TWMIndexHeader;

   TWMIndexInfo = record
      Position: integer;
      Size: integer;
   end;
   PTWMIndexInfo = ^TWMIndexInfo;
   TLibType = (ltLoadBmp, ltLoadMemory, ltLoadMunual, ltUseCache);

   TBmpImage = record
      bmp: TBitmap;
      LatestTime: integer;
   end;
   PTBmpImage = ^TBmpImage;


   TXY= array[0..65536] of Integer;
   //PWTDxImageArr = ^TDxImageArr;
   TNewWilHeader=Packed Record
     Comp       :Smallint;
     Title      :Array[0..19] of Char;
     Ver        :Smallint;
     ImageCount :Integer;
   End;
   TNewWilImageInfo=Packed Record
     Width      :Smallint;
     Height     :Smallint;
     Px         :Smallint;
     Py         :SmallInt;
     Shadow     :Byte;
     Shadowx    :Smallint;
     Shadowy    :Smallint;
     Length     :Integer;
   End;
   TNewWixHeader=Packed Record//新的wix文件头
     Title      :Array[0..19] of char;
     ImageCount :Integer;
   End;
     TBitMapHeader=Packed Record
     bfType    :Word;         //bmp文件头标志固定为19778，记bm
     bfSize    :Integer;      //文件大小
     bfRes     :Integer;      //保留，全部为0
     bfOffBits :Integer;      //记录图像数据区的起始位置
     bfTy      :Integer;      // 图像描述信息块的大小，常为28H
     Width     :Integer;
     Height    :Integer;
     mark      :Word;
     Piexl     :Word;
     Pack      :Integer;
     Size      :Integer;
     Width1    :Integer;
     Height1   :Integer;
     ColorNum  :Integer;
     unk       :Integer;
     unk1      :integer;
     unk2      :integer;
     unk3      :integer;

  End;
   TWIL = class (TComponent)
   private
      FFileName: string;
      idxfile: string;
      FImageCount: integer;
      FLibType: TLibType;
      FX,FY:TXY;
      Fpx,FPy:Integer;
      Fwidth,FHeight:Integer;
      FOffSet:Integer;
      FType:Integer;//文件类型  3为Zlib文件
      FColorCount:Integer; //颜色数量
      
      FBitFormat:TPixelFormat;
      FBytesPerPixels:byte;
      procedure LoadIndex (idxfile: string);

      procedure LoadBmpImage (position: integer; index:integer);
      procedure LoadNewBmpImage (position: integer; index:integer);

      procedure FreeBmps;
      function  FGetImageBitmap (index: integer): TBitmap;
   protected

      lsDib: TDib;
      FBitMap:TBitMap;
   public

      IndexList: Array of Integer;

      Stream: TFileStream;
      boIsZlibFormat: Boolean; //Zlib
      MainPalette: TRgbQuads;
      NewHeaderofIndex: TNewWixHeader;
      headerofIndex: TWMIndexHeader;
      ZlibHeaderofIndex: TWMZlibIndexHeader; //Zlib
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Tran(value:Integer);
      procedure Initialize;
      procedure Finalize;
      procedure ClearCache;
      procedure LoadPalette;//读取调色板
      procedure LoadZlibPalette; //Zlib调色板
      procedure FreeBitmap (index: integer);
      function  GetCachedBitmap (index: integer): TBitmap;
      function  Changex(index:Integer;x:Smallint):Boolean;
      function  Changey(index:Integer;y:Smallint):Boolean;
      function  AddBitmap(NewBitMap:TBitMap;X,Y:SmallInt):Boolean;
      function  AddNullBitmap:Boolean;
      function  ReplaceBitMap(Index:Integer;NewBitMap:TBitMap):Boolean;
    	property  Bitmaps[Index: Integer]: TBitmap read FGetImageBitmap;
      procedure DrawZoomEx (paper: TCanvas; Rec:TRect; index: integer;  leftzero: Boolean);
      procedure DrawZoom (paper: TCanvas; x,y, index: integer; zoom:Real;Tran,leftzero: Boolean);
   published
      property FileName: string read FFileName write FFileName;
      property ImageCount: integer read FImageCount;
      property LibType: TLibType read FLibType write FLibType;
      property px:Integer Read Fpx write Fpx;
      property py:Integer Read Fpy write Fpy;
      property OffSet:Integer Read FOffSet write FOffSet;
      property Width:Integer Read FWidth write FWidth;
      property Height:Integer Read FHeight write FHeight;
      property FileType:Integer Read FType write FType;
      property FileColorCount:Integer Read FColorCount write FColorCount;

   end;
procedure ChangeDIBPixelFormat(adib:TDIB;pf:TPixelFormat;BitMap:TBitMap);
procedure Register;


implementation
uses Zlib;

procedure ChangeDIBPixelFormat(adib:TDIB;pf:TPixelFormat;BitMap:TBitMap);
begin
     if pf=pf8bit then begin
       with aDib.PixelFormat do begin
         RBitMask:=$FF0000;
         gBitMask:=$FF00;
         bBitMask:=$FF;
       end;
       aDib.BitCount:=8;
       BitMap.PixelFormat:=pf;
     end else if pf=pf16bit then begin
       with aDib.PixelFormat do begin  //565格式
         RBitMask:=$F800;
         GBitMask:=$07E0;
         BBitMask:=$001F;
       end;
       aDib.BitCount:=16;
       BitMap.PixelFormat:=pf;
     end else if pf=pf24bit then begin
        with aDib.PixelFormat do begin
         RBitMask:=$FF0000;
         GBitMask:=$00FF00;
         BBitMask:=$0000FF;
       end;
       aDib.BitCount:=24;
       BitMap.PixelFormat:=pf;
     end else if pf=pf32Bit then begin
       with aDib.PixelFormat do begin
         RBitMask:=$FF0000;
         GBitMask:=$00FF00;
         BBitMask:=$0000FF;
       end;
       aDib.BitCount:=32;
       BitMap.PixelFormat:=pf;
     end;
end;

procedure FillBitMapHeader(var BitMap:TBitMapHeader);
Begin
  Bitmap.bfType:=19778;
  Bitmap.bfRes:=0;
  Bitmap.bfTy:=40;
  BitMap.mark:=1;
  BitMap.Piexl:=16;
  BitMap.Pack:=3;
  BitMap.ColorNum:=0;
  BitMap.unk:=0;
  bitmap.bfOffBits:=66;
  Bitmap.unk1:=63488;
  Bitmap.unk2:=2016;
  Bitmap.unk3:=31;
  Bitmap.Width1:=0;
  Bitmap.Height1:=0;
End;
function DuplicateBitmap (bitmap: TBitmap): HBitmap;
var
	hbmpOldSrc, hbmpOldDest, hbmpNew : HBitmap;
   hdcSrc, hdcDest						: HDC;

begin
   hdcSrc := CreateCompatibleDC (0);
   hdcDest := CreateCompatibleDC (hdcSrc);

   hbmpOldSrc := SelectObject(hdcSrc, bitmap.Handle);

   hbmpNew := CreateCompatibleBitmap(hdcSrc, bitmap.Width, bitmap.Height);

   hbmpOldDest := SelectObject(hdcDest, hbmpNew);

   BitBlt(hdcDest, 0, 0, bitmap.Width, bitmap.Height, hdcSrc, 0, 0,
     SRCCOPY);

   SelectObject(hdcDest, hbmpOldDest);
   SelectObject(hdcSrc, hbmpOldSrc);

   DeleteDC(hdcDest);
   DeleteDC(hdcSrc);

   Result := hbmpNew;
end;

procedure SpliteBitmap (DC: HDC; X, Y: integer; bitmap: TBitmap; transcolor: TColor);
var
   hdcMixBuffer, hdcBackMask, hdcForeMask, hdcCopy 			: HDC;
   hOld, hbmCopy, hbmMixBuffer, hbmBackMask, hbmForeMask 	: HBitmap;
   oldColor: TColor;
begin

	hbmCopy := DuplicateBitmap (bitmap);
	hdcCopy := CreateCompatibleDC (DC);
   hOld := SelectObject (hdcCopy, hbmCopy);

   hdcBackMask := CreateCompatibleDC (DC);
	hdcForeMask := CreateCompatibleDC (DC);
	hdcMixBuffer:= CreateCompatibleDC (DC);

	hbmBackMask := CreateBitmap (bitmap.Width, bitmap.Height, 1, 1, nil);
	hbmForeMask := CreateBitmap (bitmap.Width, bitmap.Height, 1, 1, nil);
	hbmMixBuffer:= CreateCompatibleBitmap (DC, bitmap.Width, bitmap.Height);

   SelectObject (hdcBackMask, hbmBackMask);
	SelectObject (hdcForeMask, hbmForeMask);
	SelectObject (hdcMixBuffer, hbmMixBuffer);

	oldColor := SetBkColor (hdcCopy, transcolor); //clWhite);

	BitBlt (hdcForeMask, 0, 0, bitmap.Width, bitmap.Height, hdcCopy, 0, 0, SRCCOPY);

	SetBkColor (hdcCopy, oldColor);

	BitBlt( hdcBackMask, 0, 0, bitmap.Width, bitmap.Height, hdcForeMask, 0, 0, NOTSRCCOPY );

	BitBlt( hdcMixBuffer, 0, 0, bitmap.Width, bitmap.Height, DC, X, Y, SRCCOPY );

	BitBlt( hdcMixBuffer, 0, 0, bitmap.Width, bitmap.Height, hdcForeMask, 0, 0, SRCAND );

	BitBlt( hdcCopy, 0, 0, bitmap.Width, bitmap.Height, hdcBackMask, 0, 0, SRCAND );

	BitBlt( hdcMixBuffer, 0, 0, bitmap.Width, bitmap.Height, hdcCopy, 0, 0, SRCPAINT );

	BitBlt( DC, X, Y, bitmap.Width, bitmap.Height, hdcMixBuffer, 0, 0, SRCCOPY );

  {DeleteObject (hbmCopy);}
  DeleteObject( SelectObject( hdcCopy, hOld ) );
	DeleteObject( SelectObject( hdcForeMask, hOld ) );
	DeleteObject( SelectObject( hdcBackMask, hOld ) );
	DeleteObject( SelectObject( hdcMixBuffer, hOld ) );

	DeleteDC( hdcCopy );
	DeleteDC( hdcForeMask );
	DeleteDC( hdcBackMask );
  DeleteDC( hdcMixBuffer );

end;

function  ExtractFileNameOnly (const fname: string): string;
var
   extpos: integer;
   ext, fn: string;
begin
   ext := ExtractFileExt (fname);
   fn := ExtractFileName (fname);
   if ext <> '' then begin
      extpos := pos (ext, fn);
      Result := Copy (fn, 1, extpos-1);
   end else
      Result := fn;
end;

procedure Register;
begin
   RegisterComponents('TOPDELPHI', [TWIL]);
end;

constructor TWIL.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   boIsZlibFormat := False;
   FFileName := '';
   FLibType := ltLoadBmp;
   FImageCount := 0;

   FColorCount := 0;

   Stream := nil;

 //  IndexList := TList.Create;
   lsDib := TDib.Create;
   lsDib.BitCount := 8;
   lsdib.PixelFormat.RBitMask:=$FF0000;
   lsdib.PixelFormat.gBitMask:=$FF00;
   lsdib.PixelFormat.bBitMask:=$FF;

   FBitMap:=TBitMap.Create;
   FBitMap.PixelFormat:=pf8bit;
   FbitMap.Width:=1;
   FBitMap.Height:=1;
end;

destructor TWIL.Destroy;
begin
  // IndexList.Free;
   if Stream <> nil then Stream.Free;
   lsDib.Free;
   inherited Destroy;
end;

procedure TWIL.Initialize;
var
   header: TWMImageHeader;
   ZlibHeader: TWMZlibImageHeader;  //Zlib
   NewHeader:TNewWilHeader;
   s:Pchar;
   str:String;
begin
   if not (csDesigning in ComponentState) then begin
      if FFileName = '' then
      begin
         raise Exception.Create ('FileName not assigned..');
         exit;
      end;
      if FileExists (FFileName) then
      begin
         if Stream = nil then
            Stream := TFileStream.Create (FFileName, fmOpenReadWrite or fmShareDenyNone);
         Stream.Read (ZlibHeader, SizeOf(TWMZlibImageHeader));
         str:=ZlibHeader.Title;
         //ZlibHeader.Title := StringReplace(ZlibHeader.Title,'#0','',[rfReplaceAll]);
         if str=ZlibTitle then begin//Zlib
           if Stream<>nil then begin
             FType:=3;
             idxfile := ExtractFilePath(FFileName) + ExtractFileNameOnly(FFileName) + '.WZX';
             FImageCount := ZlibHeader.ImageCount;
             LoadIndex (idxfile);//读取索引
             LoadZlibPalette;
             boIsZlibFormat := True;
           end;
         end else begin
           Stream.Position := 0; //Zlib
           Stream.Read (header, sizeof(TWMImageHeader));
           FColorCount := header.ColorCount;
           if header.ColorCount=256 then begin
             FBitFormat:=pf8Bit; FBytesPerPixels:=1;
           end else if header.ColorCount=65536 then begin
             FBitFormat:=pf16bit; FBytesPerPixels:=2;
           end else if header.colorcount=16777216 then begin
             FBitFormat:=pf24Bit; FBytesPerPixels:=4;
           end else if header.ColorCount>16777216 then begin
             FBitFormat:=pf32Bit; FBytesPerPixels:=4;
           end;
           ChangeDIBPixelFormat(lsDIB,FBitFormat,FBitMap);
           if Header.Title='ILIB v1.0-WEMADE Entertainment inc.' then
               FType:=0
           else
            if Header.Title='WEMADE Entertainment inc.' then
               FType:=1
            else Begin
              Stream.Seek(0,0);
              Stream.Read(NewHeader,Sizeof(NewHeader));
            //  s:=NewHeader.
              s:=@NewHeader.Title;
              Str:=String(s);
              if Str='ILIB v1.0-WEMADE' then
                 FType:=2
              else Begin
                 stream.Free;
                 stream:=nil;
                 exit;
              End;
            End;
           if Ftype<2 then FImageCount := header.ImageCount;
           if Stream<>nil then Begin
             idxfile := ExtractFilePath(FFileName) + ExtractFileNameOnly(FFileName) + '.WIX';
             LoadIndex (idxfile);//读取索引
             if Ftype<2 then LoadPalette;//读取调色板
           end else MessageDlg (FFileName + ' 不是wil文件.', mtWarning, [mbOk], 0);
         end;
      end else begin
         MessageDlg (FFileName + ' 不存在.', mtWarning, [mbOk], 0);
      end;
   end;
end;

procedure TWIL.Finalize;
begin
  if Stream <> nil then FreeAndNil(Stream);
  {for i:=0 to FImageCount-1 do
     FreeBitmap(i);  无用 }
  SetLength(IndexList,0); //清理动态数组内存
  boIsZlibFormat := False;
  FOffset:=0;
  FType:=0;
end;
{procedure Log( s : string);stdcall;
var
  F : TextFile;
begin
  assignfile(f,'c:\记事本.txt');
  if fileexists('c:\记事本.txt') then append(f)
  else rewrite(f);
  writeln(f,s);
  closefile(f);
end;}
procedure TWIL.LoadPalette;
 var
 size,x:integer;
 lplogpal:pMaxLogPalette;//
begin
  if Foffset=4 then
    size:=60
  else
    size:=56;
   Stream.Seek (size, 0);
   Stream.Read (MainPalette, sizeof(TRgbQuad) * 256); //迫贰飘
   GetMem(lpLogPal,sizeof(TLOGPALETTE) + ((255) * sizeof(TPALETTEENTRY)));
   lpLogPal.palVersion := $0300;
   lpLogPal.palNumEntries := 256;
    for x := 0 to 255 do Begin
      lpLogPal.palPalEntry[x].peRed := MainPalette[x].rgbRed;
      lpLogPal.palPalEntry[x].peGreen := MainPalette[x].rgbGreen;
      lpLogPal.palPalEntry[x].peBlue := MainPalette[x].rgbBlue;
      //Log('MainPalette['+IntToStr(X)+'].rgbRed:='+inttostr(MainPalette[x].rgbRed)+';  MainPalette['+IntToStr(X)+'].rgbGreen:='+inttostr(MainPalette[x].rgbGreen)+'; MainPalette['+IntToStr(X)+'].rgbBlue:='+inttostr(MainPalette[x].rgbBlue)+';');
    End;
   FBitmap.Palette := CreatePalette(pLogPalette(lpLogPal)^);
end;

procedure TWIL.LoadZlibPalette;
var
  lplogpal:pMaxLogPalette;//
  x:integer;
begin
  Move(ColorArray, MainPalette, SizeOf(ColorArray));//传递调色板数据
  GetMem(lpLogPal,sizeof(TLOGPALETTE) + ((255) * sizeof(TPALETTEENTRY)));
  lpLogPal.palVersion := $0300;
  lpLogPal.palNumEntries := 256;
  for x := 0 to 255 do Begin
    lpLogPal.palPalEntry[x].peRed := MainPalette[x].rgbRed;
    lpLogPal.palPalEntry[x].peGreen := MainPalette[x].rgbGreen;
    lpLogPal.palPalEntry[x].peBlue := MainPalette[x].rgbBlue;
  End;
  FBitmap.Palette := CreatePalette(pLogPalette(lpLogPal)^);
end;

procedure TWIL.LoadIndex (idxfile: string);
var
   fhandle: integer;
   count:Integer;
  // pvalue: PInteger;
begin
 //  indexlist.Clear;
   if FileExists (idxfile) then begin
      fhandle := FileOpen (idxfile, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
        case FType of
         0:
          Begin
            FoffSet:=0;
            FileRead (fhandle, headerofIndex, sizeof(TWMIndexHeader));
            SetLength(IndexList,headerofIndex.IndexCount+1);
            FileRead (fhandle, IndexList[0], 4*headerofIndex.IndexCount);
          End;
         1:
          Begin
            FoffSet:=4;
            FileRead (fhandle, headerofIndex, sizeof(TWMIndexHeader));
            SetLength(IndexList,headerofIndex.IndexCount+1);
            FileSeek(fHandle,52,0);
            FileRead (fhandle, IndexList[0], 4*headerofIndex.IndexCount);
            if IndexList[0]<>1084 then Begin
              FileSeek(fHandle,48,0);
              FileRead (fhandle, IndexList[0], 4*headerofIndex.IndexCount);
              Ftype:=0;
              FoffSet:=0;
            End;
          End;
         2:
          Begin
             count:=0;
             Foffset:=0;
             FileSeek(fHandle,0,0);
             FileRead(Fhandle,NewHeaderofIndex,Sizeof(NewHeaderofIndex));
             SetLength(INdexList,NewHeaderofIndex.ImageCount);
             FileRead(fHandle,IndexList[0],NewHeaderofIndex.ImageCount*4);
             FimageCount:=NewHeaderofIndex.ImageCount;

             while (IndexList[0]<0) do Begin
               Inc(count);
               Inc(Foffset);
               Dec(FimageCOunt);
               FileSeek(fHandle,Sizeof(NewHeaderofIndex)+4*count,0);

               FileRead(fHandle,IndexList[0],FimageCOunt*4);
             End;
          end;
          3: begin //Zlib文件
            FoffSet:=12;
            FileRead (fhandle, ZlibHeaderofIndex, sizeof(TWMZlibIndexHeader));
            SetLength(IndexList,ZlibHeaderofIndex.IndexCount);
            FileRead (fhandle, IndexList[0], 4*ZlibHeaderofIndex.IndexCount);
          end;
        end;
         FileClose (fhandle);
      end;
   end;
end;

{----------------- Private Variables ---------------------}


function  TWIL.FGetImageBitmap (index: integer): TBitmap;
begin
   Result:=nil;
   if LibType <> ltLoadBmp then exit;
   Result := GetCachedBitmap (index);

end;


// *** DirectDrawSurface Functions
procedure TWIL.LoadNewBmpImage (position: integer; index:integer);
var
   imginfo: TNewWilImageInfo;
   buf:Array of word;
  //DBits: PByte;
  dbits:array of word;
  // newdib:TDib;
   nYCnt,nWidthEnd,nWidthStart,nCntCopyWord,x{,nXOffset,nYOffset}:Integer;
   {nStartX,nStartY,}nCurrWidth,nLastWidth,nCheck:integer;
  //lpbi:TBitmapInfo ;
  Bheader:TBitMapHeader;
  //hdib:HWnd;
  //d:integer;
  tmpFile:TMemoryStream;
begin
   if Position<=0 then
   Begin
     FBitMap.Width:=0;
     FbitMap.Height:=0;
     Exit;
   End;
   Stream.Seek (position, 0);
   Stream.Read (imginfo, sizeof(TNewWilImageInfo));
   FX[index]:=ImgInfo.px;
   FY[Index]:=ImgInfo.py;

   SetLength(Dbits,Imginfo.Width*Imginfo.Height*2);
   SetLength(Buf,ImgINfo.Length*2);
   Stream.Read (Buf[0], Imginfo.Length*2);
   if (ImgINfo.Width>1000) or (ImgInfo.Height>1000) then
        Exit;
   		//nXOffset	:= 0;
			//nYOffset	:= 0;

				//nStartX		:= 0;
				//nStartY		:= 0;

			 nWidthStart	:= 0;
			 nWidthEnd	:= 0;
			 nCurrWidth  := 0;
			 //nCntCopyWord := 0;
			 //nYCnt :=0;
			 //nLastWidth := 0;
       for nycnt:=0 to ImgInfo.Height do
       Begin
          nWidthEnd:=Buf[nwidthstart]+nWidthEnd;
          Inc(nWidthStart);
//          for x:=nWidthStart to nwidthend-1 do
          x:=nWidthStart;
          while x<nwidthend do
          Begin
             if Buf[x]=$c0 then
             Begin
              // inc(x);
               x:=x+1;
               nCntCopyWord:=Buf[x];
               x:=x+1;
               nCurrWidth:=nCurrWidth+nCntCopyWord;
             End
             else
               if (Buf[x]=$c1) then
               Begin
                 Inc(x);
                 nCntCopyWord:=Buf[x];
                 Inc(x);

                 nLastWidth:=nCurrWidth;
                 nCurrWidth:=nCurrWidth+nCntCopyWord;
                 if (ImgInfo.Width<nLastWidth) then
                     x:=x+nCntCopyWord
                 else
                 Begin
                   if (nLastWidth<=ImgInfo.Width) and (ImgInfo.Width<nCurrWidth) then
                   Begin
                     CopyMemory(@Dbits[(Imginfo.height-nycnt)*ImgInfo.width+nlastwidth],@buf[x],(imginfo.Width-nlastwidth)*2);
                     x:=x+ncntcopyword;
                   End
                   else
                   Begin
                     CopyMemory(@Dbits[(Imginfo.height-nycnt)*ImgInfo.width+nlastwidth],@buf[x],nCntCopyWord*2);
                     x:=x+ncntcopyword;
                   End;

                 End;

               End
               else
               Begin
                  if(Buf[x]=$c2) or (Buf[x]=$c3) then
                  Begin
                    Inc(x);
                    nCntCopyWord:=Buf[x];
                    Inc(x);
                    nLastWidth:=nCurrWidth;
                    nCurrWidth:=nCurrWidth+nCntCopyWord;
                    if (imginfo.Width<nLastWidth) then
                        x:=x+ncntcopyword
                    else
                    Begin
                        if (nlastwidth<imginfo.Width) and (imginfo.Width<nCurrWidth) then
                        Begin
                          for nCheck:=0 to (imginfo.Width-nlastwidth-1) do
                             Dbits[((imginfo.Height-nycnt)*(imginfo.Width))+(nlastwidth+ncheck)]:= Buf[x+ncheck];
                           x:=x+nCntCopyWord;
                        End
                        else
                        Begin
                          for nCheck:=0 to (nCntCopyWord-1) do
                             Dbits[((imginfo.Height-nycnt)*(imginfo.Width))+(nlastwidth+ncheck)]:= Buf[x+ncheck];
                           x:=x+nCntCopyWord;
                        End

                    End;
                  End;

               End;

          end;

          Inc(nWidthEnd);
          nWidthStart:=nWidthEnd;
          nCurrWidth:=0;

       End;
       //d:=0;

//   CreateDIBitmap(GetDC(0),lpbih,CBM_INIT,@Dbits,@lpbi,d );
     FillBitMapHeader(BHeader);
     Bheader.Width:=Imginfo.Width;
     BHeader.Height:=Imginfo.Height;
     BHeader.Size:=Imginfo.Width*Imginfo.Height*2;
     Bheader.bfSize:=66+Imginfo.Width*Imginfo.Height*2;
     tmpFile:=TMemoryStream.Create;
     TmpFile.SetSize(Imginfo.Width*Imginfo.Height*2+56);
     TmpFile.Seek(0,0);
     TmpFile.Write(BHeader,66);
     TmpFile.Write(DBits[0],Imginfo.Width*Imginfo.Height*2);
     TmpFile.Seek(0,0);

    FbitMap.LoadFromStream(TmpFile);
    TmpFile.Free;
end;

procedure TWIL.LoadBmpImage (position: integer; index:integer);
var
  imginfo: TWMImageInfo;
  DBits: PByte;
  ZlibImgInfo: TWMZlibImageInfo;
  cs: TDecompressionStream;
  OldSize: Integer;
  ms, fs: TMemoryStream; //Zlib 此流如果写在游戏中，建议当成类的子成员，类创建则创建，效率会好点
   //DDSD: TDDSurfaceDesc2;  // 用于 Surface.Lock
begin
  if position > 0 then begin //防止读头
    if boIsZlibFormat then begin
      Stream.Seek (position, 0);
      Stream.Read (ZlibImgInfo, sizeof(TWMZlibImageInfo));
      if (ZlibImgInfo.Width > 2000) or (ZlibImgInfo.Height > 2000) then Exit;
      if (ZlibImgInfo.Width > 0) and (ZlibImgInfo.Height > 0) then begin
        if ZlibImgInfo.wColor = $103 then begin
          FColorCount := 256;
          FBitFormat:=pf8Bit;
          FBytesPerPixels:=1;
        end else if ZlibImgInfo.wColor = $105 then begin
          FColorCount := 65536;
          FBitFormat:=pf16Bit;
          FBytesPerPixels:=2;
        end else begin
          FBitMap.Width := 1;
          FBitMap.Height := 1;
          FBitMap.Canvas.Brush.Color:=ClBlack;
          FBitMap.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));
          Exit;
        end;
        ChangeDIBPixelFormat(lsDIB,FBitFormat,FBitMap);
        FX[index]:=ZlibImgInfo.px;
        FY[Index]:=ZlibImgInfo.py;
        lsDib.Width := ZlibImgInfo.Width;
        lsDib.Height := ZlibImgInfo.Height;
        lsDib.ColorTable := MainPalette;
        lsDib.UpdatePalette;
        lsDib.Canvas.Brush.Color:=ClBlack;
        lsDib.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));
        DBits := lsDib.PBits;
        //Zlib解压
        OldSize := ZlibImgInfo.Width*ZlibImgInfo.Height*FBytesPerPixels;

        if ZlibImgInfo.DecodeSize>0 then
        begin
          fs := TMemoryStream.Create;
          fs.SetSize(ZlibImgInfo.DecodeSize); //原始大小
          fs.CopyFrom(Stream, ZlibImgInfo.DecodeSize);
          try
            ms := TMemoryStream.Create;
            try
              ms.SetSize(OldSize);
              fs.Position := 0;
              try
                cs := TDecompressionStream.Create(fs);
              except
                //解密异常
                FBitMap.Width := 1;
                FBitMap.Height := 1;
                FBitMap.Canvas.Brush.Color:=ClBlack;
                FBitMap.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));
                Exit;
              end;
              cs.Read(ms.Memory^, OldSize);
              move(ms.Memory^, DBits^, OldSize);
            finally
              FreeAndNil(ms);
            end;
          finally
            FreeAndNil(fs);
          end;
        end else
        begin
          Stream.ReadBuffer(DBits^, OldSize);
        end;

        //解压结束
        if (ZlibImgInfo.Width>2000) or (ZlibImgInfo.Height>2000) then Exit;
      end else begin
        lsDib.Clear;
      end;
    end else begin
      ChangeDIBPixelFormat(lsDib, FBitFormat,FBitMap);
      Stream.Seek (position, 0);
      Stream.Read (imginfo, sizeof(TWMImageInfo)-4+FOffset);
      FX[index]:=ImgInfo.px;
      FY[Index]:=ImgInfo.py;
      lsDib.Width := imginfo.Width;//(((imginfo.Width*8)+31) div 32{ shr 5}) * 4;
      lsDib.Height := imginfo.Height;
      lsDib.ColorTable := MainPalette;
      lsDib.UpdatePalette;
      lsDib.Canvas.Brush.Color:=ClBlack;
      lsDib.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));
      DBits := lsDib.PBits;
      Stream.Read (DBits^, imginfo.Width * imgInfo.Height * FBytesPerPixels);
      if (ImgINfo.Width>2000) or (ImgInfo.Height>2000) then Exit;
    end;
    FBitMap.Width := lsDib.Width;
    FBitMap.Height := lsDib.Height;
    FBitMap.Canvas.Draw (0, 0, lsDib);
    lsDib.Clear;
  end else begin
    FBitMap.Width := 1;
    FBitMap.Height := 1;
    FBitMap.Canvas.Brush.Color:=ClBlack;
    FBitMap.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));
  end;
end;

procedure TWIL.ClearCache;
begin
   FreeBmps;
end;



procedure TWIL.FreeBmps;
//var
//   i: integer;
begin

end;

procedure TWIL.FreeBitmap (index: integer);
begin

end;

function  TWIL.GetCachedBitmap (index: integer): TBitmap;
var
   position: integer;
begin
   Result := nil;
   if (index < 0) or (index >= ImageCount) then
   Begin
     FBitMap.Width:=1;
     FbitMap.Height:=1;
     Result:=FBitMap;
     exit;
   end;
  if index < ImageCount then
  begin
     position := (IndexList[index]);
     case Ftype of
       0..1, 3: LoadBmpImage (position,index);
       else LoadNewBmpImage (position,index);
     end;
     
     Result:=FBitMap;
     FWidth:=FBitMap.Width;
     FHeight:=FBitMap.Height;
  end;

   Fpx:=Fx[Index];
   Fpy:=Fy[Index];
end;

function  TWIL.AddBitmap(NewBitMap:TBitMap;X,Y:SmallInt):Boolean;
var
  Temp:TFileStream;
  DBits:PByte;
  v:smallint;
offset:integer;
  s:array[0..1] of integer;
Begin
 Result:=False;
 try
   lsDib.Width := (((NewBitMap.Width*8)+31) shr 5) * 4;
   lsDib.Height := NewBitMap.Height;
   if (NewBitMap.Width<=1)or(NewBitMap.Height<=1) then
   Begin
      AddNUllBitmap;
      Result:=True;
      Exit;
   End;
   lsDib.ColorTable := MainPalette;
   lsDib.UpdatePalette;
   lsdib.Canvas.Brush.Color:=clblack;
   lsDib.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));   
   lsDib.Canvas.Draw(0,0,NewBitmap);
 //  lsDib.SaveToFile('c:\1.bmp');
   if Stream<>nil then
   Begin
     Inc(FImageCount);
     Stream.Seek(44,0);
     Stream.Write(FImageCount,4);
 //写入图片的宽度
     offset:=Stream.Size;
     Stream.Seek(0,2);
     v:=lsDib.Width;
     Stream.Write(v,2);
 //写入图片的高度
     v:=lsDib.Height;
     Stream.Write(v,2);
 //写入图片的坐标
     Stream.Write(x,2);
     Stream.Write(y,2);
     DBits:=lsDIb.PBits;
     s[0]:=Stream.Write(DBits^,lsdib.Size);//lsDib.Height*lsDib.Width);
     Temp:= TFileStream.Create (idxfile, fmOpenReadWrite or fmShareDenyNone);
     Temp.Seek(44,0);
     Temp.Write(FImageCount,4);
     Temp.Seek(0,2);
     Temp.Write(Offset,4);
     Temp.Free;
   End;
   Result:=True;
  Except
  End;
End;
function  TWIL.AddNUllBitmap:Boolean;
var
  Temp:TFileStream;
  offset:Integer;
  v:smallint;
  vv:Byte;
Begin
   Result:=False;
   Try
   if Stream<>nil then
   Begin
     Inc(FImageCount);
     Stream.Seek(44,0);
     Stream.Write(FImageCount,4);
 //写入图片的宽度
     offset:=Stream.Size;
     Stream.Seek(0,2);
     v:=1;
     Stream.Write(v,2);
     Stream.Write(v,2);
     Stream.Write(v,2);
     Stream.Write(v,2);
     vv:=0;
     Stream.Write(vv,1);
     Temp:= TFileStream.Create (idxfile, fmOpenReadWrite or fmShareDenyNone);
     Temp.Seek(44,0);
     Temp.Write(FImageCount,4);
     Temp.Seek(0,2);
     Temp.Write(Offset,4);
     Temp.Free;

   End;
   Result:=True;
   except
   End;
End;

function TWIL.ReplaceBitMap(Index:Integer;NewBitMap:TBitMap):Boolean;
var
  Width,Height,x,y:smallint;
  Temp:TMemoryStream;
  offset,size,i,WixFileHandle:Integer;
  DBits:PByte;
Begin
 Result:=False;
  try
     lsDib.Width := (((NewBitMap.Width*8)+31) shr 5) * 4;
     lsDib.Height := NewBitMap.Height;
     lsDib.ColorTable := MainPalette;
     lsDib.UpdatePalette;
     lsdib.Canvas.Brush.Color:=clblack;
     lsDib.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));
     lsDib.Canvas.Draw(0,0,NewBitmap);
     if Stream<>nil then Begin
        OffSet:=(indexlist[index]);
        Stream.Seek(Offset,0);
        Stream.Read(Width,2);
        Stream.Read(Height,2);
        Stream.Read(x,2);
        Stream.Read(y,2);
        DBits:=lsDIb.PBits;
        if(Width=lsDib.Width) and(Height=lsDib.Height) then Begin
          Stream.Write(DBits^,lsDib.Width*lsDib.Height);
        End
        else Begin
           Size:=Stream.Size-offset-8-Width*Height;
           Temp:=TMemoryStream.Create;
           try
             Stream.Seek(0,0);
             Temp.LoadFromStream(stream);
             Stream.Seek(offset,0);
             x:=lsDib.Width;
             y:=lsDib.Height;
             Stream.Write(x,2);
             Stream.Write(y,2);
             Stream.Seek(4,1);
             Stream.Write(Dbits^,x*y);
             Temp.Seek(offset+8+Width*Height,0);
             Stream.CopyFrom(Temp,size);
           finally
             Temp.Free;
           end;
           WixFileHandle:=FileOpen(idxfile,fmOpenReadWrite);
           FileSeek(WixFileHandle,48+4*(Index+1),0);
           for i:=Index+1 to ImageCount-1 do Begin
              OffSet:=(indexlist[i])+x*y-WIdth*Height;
              IndexList[i]:=Offset;
              FileWrite(WixFileHandle,offset,4);
           End;
           FileClose(WixFIleHandle);
           LoadIndex(idxfile);
        End;
        Result:=True;
     End;
  Finally
  End;
End;

procedure TWil.DrawZoomEx (paper: TCanvas; Rec:TRect; index: integer;  leftzero: Boolean);
var
//   rc: TRect;
   bmp,bmp2: TBitmap;
begin
   if LibType <> ltLoadBmp then exit;
   //if index > BmpList.Count-1 then exit;
   bmp := Bitmaps[index];
   if bmp <> nil then
   begin
      Bmp2 := TBitmap.Create;
      Bmp2.Width :=Rec.Right-Rec.Left;
      Bmp2.Height :=Rec.Bottom-Rec.Top;
      if Bmp2.Width>Bmp.Width then  bmp2.Width:=bmp.Width;
      if bmp2.Height>bmp.Height then bmp2.Height:=bmp.Height;
      Bmp2.Canvas.StretchDraw (Rect(0, 0, Bmp2.Width, Bmp2.Height), Bmp);
      if leftzero then
      begin
        SpliteBitmap (paper.Handle, Rec.Left,rec.Top, Bmp2, $0)
      end
      else
      begin
        SpliteBitmap (paper.Handle, Rec.Left, rec.Top-Bmp2.Height, Bmp2, $0);
      end;
      FreeBitmap (index);
      bmp2.Free;
   end;
end;

procedure TWil.DrawZoom (paper: TCanvas; x,y, index: integer; zoom:Real;Tran,leftzero: Boolean);
var
   rc: TRect;
   bmp, bmp2: TBitmap;
begin

   if LibType <> ltLoadBmp then exit;
   //if index > BmpList.Count-1 then exit;
   bmp := Bitmaps[index];
   x:=x;
   y:=y;
   if bmp <> nil then
   begin
      Bmp2 := TBitmap.Create;
      Bmp2.Width := Round (Bmp.Width * zoom);
      Bmp2.Height := Round (Bmp.Height * zoom);
      rc.Left := x;
      rc.Top  := y;
      rc.Right := x + Round (bmp.Width * zoom);
      rc.Bottom := y + Round (bmp.Height * zoom);
      paper.DrawFocusRect(rc);
      if (rc.Right > rc.Left) and (rc.Bottom > rc.Top) then
      begin
         Bmp2.Canvas.StretchDraw (Rect(0, 0, Bmp2.Width, Bmp2.Height), Bmp);
         if leftzero then
         begin
           if Tran then
             SpliteBitmap (paper.Handle, X, Y, Bmp2, $0)
           else
             SpliteBitmap (paper.Handle, X, Y, Bmp2, $FF);
         end
         else
         begin
           if Tran then
              SpliteBitmap (paper.Handle, X, Y, Bmp2, $0)
           else
              SpliteBitmap (paper.Handle, X, Y, Bmp2, $FF);
         end;
      end;
      FreeBitmap (index);
      bmp2.Free;
   end;
end;
procedure TWil.Tran(value:Integer);
var
  i:integer;
Begin
  if Value=-1 then
     LoadPalette
  else
  Begin
    for i:=0 to 255 do
    Begin
       if (MainPalette[i].rgbBlue<Value)and (MainPalette[i].rgbGreen<Value) and (MainPalette[i].rgbRed<Value) then
       Begin
        //  if (abs(MainPalette[i].rgbBlue-MainPalette[i].rgbGreen)<(Value-2)) and (abs(MainPalette[i].rgbBlue-MainPalette[i].rgbRed)<(Value-2)) and (abs(MainPalette[i].rgbRed-MainPalette[i].rgbGreen)<(Value-2)) then
          Begin
            MainPalette[i].rgbBlue:=0;
            MainPalette[i].rgbGreen:=0;
            MainPalette[i].rgbRed:=0;
          end;
       End;

    End;
  End;

End;
function  TWil.Changex(index:Integer;x:Smallint):Boolean;
var
  size:integer;
Begin
  Result:=True;
  if Stream<>nil then
  Begin
     size:=IndexList[index];
     Stream.Seek(Size+4,0);
     Stream.Write(x,2);
  End;
End;

function  TWil.Changey(index:Integer;y:Smallint):Boolean;
var
  size:integer;
Begin
  Result:=True;
  if Stream<>nil then
  Begin
     size:=IndexList[index];
     Stream.Seek(Size+6,0);
     Stream.Write(y,2);
  End;
End;
end.
