{------------------------------------------------------------------------------}
{ 单元名称: Wil.pas                                                            }
{                                                                              }
{ 创建日期: 2007-10-28 20:30:00                                                }
{                                                                              }
{ 功能介绍: 传奇2 Wil,Wis 文件读取单元                                         }
{                                                                              }
{ 使用说明:                                                                    }
{                                                                              }
{   WIL 位图文件: 由 文件头+调色板(256色)+(TImageInfo+位图 Bits)*N项 组成      }
{   WIX 索引文件: 实际上就是一个文件头+指针数组, 指针指向 TImageInfo 结构      }
{------------------------------------------------------------------------------}
{   WIS 文件: 由 文件头+(TImageInfo+位图 Bits)*N项+索引部分(一图12字节) 组成   }
{   索引部分: 一个索引12字节，包含数据有，图片在文件中的位置，图片的大小，     }
{             TWisIndexInfo                                                    }
{  图片部分：12字节(TWisImageInfo结构)+图片数据                                }
{------------------------------------------------------------------------------}
{ 更新历史:
    20091117 增加主将英雄和副将英雄(383 * X) 资源的读取
    20091004 增加对cbohum.wis(倚天战甲连击动作)文件部分图的读取

    20090905 修改读wis索引办法，从尾部读取，一直读到指针为512的索引时停止(第一个图)
             然后再循环把列表倒序排序(由于用循环把列表倒序排序，效率比较低，如使用
             TList.Sort方法进行排序，原图的位置与旧版的位置有冲突，所以暂时无法处理)

    20090828 增加433,406,478Wis图的读取
                                                                               }
{   20090616 增加支持wis文件格式的读取                                         }
{ 尚存问题:                                                                    }
{                                                                              }
{    WIL 的调色板是不是都是一样的？如果是，则可以省略                          }
{    注意： WIL 的数据格式定义都是没有 pack 的 record                          }
{                                                                              }
{    Weapon.wix 数据有误: 索引文件头设置的图片数量为 40856, 实际能读出的数量   }
{      为 40855, 传奇源代码可以正常运行的原因是它没有检测可读出的内容.         }
{      可能需要重建索引. 目前的解决方法是在 LoadIndexFile 中根据读出的实际内   }
{      容对 FImageCount 进行修正.                                              }
{------------------------------------------------------------------------------}

unit WIL;

interface

uses
  Windows, Classes, Graphics, SysUtils, DXDraws, DirectX, DIB, wmUtil, {u_QuickSort} MapFiles,ZLib;
{------------------------------------------------------------------------------}
// WIL 常量定义
{------------------------------------------------------------------------------}
var
  g_boUseDIBSurface  :Boolean = FALSE;// 是否在创建 WIL Surface 时使用 DIB 绘制
                                  // 如果直接使用 WIL 文件中的位图 Bits 会出现少量颜色
                                  // 显示不正确，在传奇源代码中的结果也是如此。

  ColorArray: array[0..1023] of byte = (//调色板数据
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
{------------------------------------------------------------------------------}
// WIL 文件格式定义
{------------------------------------------------------------------------------}
type
// WIL 文件头格式 (56Byte)
  TLibType = (ltLoadBmp, ltLoadMemory, ltLoadMunual, ltUseCache);

  TBmpImage = record
    Bmp           :TBitmap;
    dwLatestTime  :LongWord;
  end;
  pTBmpImage = ^TBmpImage;

   TBmpImageArr  = array[0..MaxListSize div 4] of TBmpImage;
   TDxImageArr   = array[0..MaxListSize div 4] of TDxImage;
   PTBmpImageArr = ^TBmpImageArr;
   PTDxImageArr  = ^TDxImageArr;

   TSourceFileType =(sftWis,sftWil,sftWzl);
{------------------------------------------------------------------------------}
// TWilFile class
{------------------------------------------------------------------------------}
   TWMImages = class (TComponent)
   private
      FFileName: String;              //0x24  // WIL 文件名
      FFileType:TSourceFileType;
      FImageCount: integer;           //0x28  // 图片数量
      FLibType: TLibType;             //0x2C  //图象装载方式
      FDxDraw: TDxDraw;               //0x30
      FDDraw: TDirectDraw;            //0x34
      //FMaxMemorySize: integer;        //0x38
      btVersion:Byte;                 //0x3C
      btWisFile,btWzlFile: Boolean;//是否为wis文件
      m_bt458    :Byte;
      FAppr:Word;

      FBitCount: byte;
      FBitFormat:TPixelFormat; //20090915
      FBytesPerPixels:byte; //20090915
      UseIndexList: TList; //释放内存用
      {FGetImageBitmap: TBitmap;
      FGetImageSurface: TDirectDrawSurface;  }
      procedure LoadAllData;
      procedure LoadIndexWil (idxfile: string);
      procedure LoadIndexWzl (idxfile: string);
      procedure LoadZlibPalette;
      function  LoadWisIndex (filename: string): Boolean;//读取wis索引数据
      procedure LoadDxImage (position, nSize: integer; pdximg: PTDxImage);
      procedure LoadBmpImage (position: integer; pbmpimg: PTBmpImage);
      //procedure FreeOldMemorys;
      procedure FreeOldMemorys;
      function  FGetImageSurface (index: integer): TDirectDrawSurface;
      procedure FSetDxDraw (fdd: TDxDraw);
      procedure FreeOldBmps;
      function  FGetImageBitmap (index: integer): TBitmap;

      function DecodeWis(ASrc, ADst: PByte; ASrcSize, ADstSize: Integer): Boolean;//WIS算法(压缩解法) 20100803
      function Wis_RLE8_Decode(ASrc, ADst: PByte; ASrcSize,nWidth: Integer): Boolean;//未压缩数据使用
      function Wis_RLE8_Decode1(ASrc, ADst: PByte; ASrcSize, ADstSize, nWidth, nHeight: Integer): Boolean;//Wis图片数据还原(压缩数据使用)
   protected
      lsDib: TDib;              //0x40
      m_dwMemChecktTick: LongWord;   //0x44
      FBitMap:TBitMap;
      FSrcMemory,FDstMemory:TMemoryStream;
   public
      m_ImgArr    :pTDxImageArr;     //0x48
      m_BmpArr    :pTBmpImageArr;    //0x4C
      m_IndexList :TList;         //0x50
      m_FileStream: TFileStream;      //0x54
      MainPalette: TRgbQuads;
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Initialize;
      procedure Finalize;
      procedure ClearCache;
      procedure LoadPalette;
      procedure LoadWisPalette;//由于Wis没有256色的调色板，需要自行创建调色板
      procedure FreeBitmap (index: integer);
      function  GetImage (index: integer; var px, py: integer): TDirectDrawSurface;
      function  GetCachedImage (index: integer; var px, py: integer): TDirectDrawSurface;
      function  GetCachedSurface (index: integer): TDirectDrawSurface;
      function  GetCachedBitmap (index: integer): TBitmap;
      property Images[index: integer]: TDirectDrawSurface read FGetImageSurface;
    	property Bitmaps[Index: Integer]: TBitmap read FGetImageBitmap;
      property DDraw: TDirectDraw read FDDraw write FDDraw;
   published
      property FileName: string read FFileName write FFileName;
      property ImageCount: integer read FImageCount;
      property DxDraw: TDxDraw read FDxDraw write FSetDxDraw;
      property LibType: TLibType read FLibType write FLibType;
      //property MaxMemorySize: integer read FMaxMemorySize write FMaxMemorySize;
      property Appr:Word read FAppr write FAppr;
      property BitCount: byte read FBitCount write FBitCount;
   end;
procedure ChangeDIBPixelFormat(adib:TDIB;pf:TPixelFormat);
procedure Move1(const Source; var Dest; count: Integer);
procedure Register;

implementation

uses HUtil32;

procedure Register;
begin
   RegisterComponents('MirGame', [TWmImages]);
end;

procedure ChangeDIBPixelFormat(adib:TDIB;pf:TPixelFormat);
begin
     if pf=pf8bit then begin
       with aDib.PixelFormat do begin
         RBitMask:=$FF0000;
         GBitMask:=$00FF00;
         BBitMask:=$0000FF;
       end;
       aDib.BitCount:=8;
     end else if pf=pf16bit then begin
       with aDib.PixelFormat do begin  //565格式
         RBitMask:=$F800;
         GBitMask:=$07E0;
         BBitMask:=$001F; 
       end;
       aDib.BitCount:=16;
     end else if pf=pf24bit then begin
        with aDib.PixelFormat do begin
         RBitMask:=$FF0000;
         GBitMask:=$00FF00;
         BBitMask:=$0000FF;
       end;
       aDib.BitCount:=24;
     end else if pf=pf32Bit then begin
       with aDib.PixelFormat do begin
         RBitMask:=$FF0000;
         GBitMask:=$00FF00;
         BBitMask:=$0000FF;
       end;
       aDib.BitCount:=32;
     end;
end;

constructor TWMImages.Create (AOwner: TComponent);
begin
  inherited Create (AOwner);
  FFileName := '';
  FLibType := ltLoadBmp;
  FImageCount := 0;
  //FMaxMemorySize := 1024*1000; //1M
  FBitCount := 8;
  
  FDDraw := nil;
  FDxDraw := nil;
  m_FileStream := nil;
  m_ImgArr := nil;
  m_BmpArr := nil;
  m_IndexList := TList.Create;
  UseIndexList := TList.Create; //释放内存用
  lsDib := TDib.Create;
  lsDib.BitCount := 8;

  m_dwMemChecktTick := GetTickCount;
  btVersion:=0;
  m_bt458:=0;
  btWisFile:= False;//是否为wis文件
  btWzlFile:=False;

  FBitMap:=TBitMap.Create;
  FBitMap.PixelFormat:=pf8bit;
  FbitMap.Width:=1;
  FBitMap.Height:=1;

  FSrcMemory:=TMemoryStream.Create;
  FDstMemory:=TMemoryStream.Create;
end;

destructor TWMImages.Destroy;
begin
  m_IndexList.Free;
  UseIndexList.Free;
  if m_FileStream <> nil then m_FileStream.Free;
  lsDib.Free;

  FBitMap.Free;
  FSrcMemory.Free;
  FDstMemory.Free;  
  inherited Destroy;
end;

procedure TWMImages.Initialize;
var
  Idxfile: String;
  Header :TWMImageHeader;
  WisHeader: TWisHeader;
  ZlibHeader: TWMZlibImageHeader;  //Zlib
  ExtName,NewFileName:string;
begin
  if not (csDesigning in ComponentState) then begin
    if FFileName = '' then Exit;
    if (LibType <> ltLoadBmp) and (FDDraw = nil) then Exit;
    ExtName:=ExtractFileExt(FFileName);
    NewFileName:=Copy(FFileName,1,Length(FFileName)-Length(ExtName));

    if FileExists (FFileName) then begin
      if m_FileStream = nil then m_FileStream := TFileStream.Create (FFileName, fmOpenRead or fmShareDenyNone);
      m_FileStream.Read (WisHeader, SizeOf(TWisHeader));
      if AnsiCompareStr(WisHeader.shTitle, Wis_Title) = 0 then begin//检查文件头是否为wis文件格式
        if not LoadWisIndex(ExtractFileName(FFileName)) then Exit; //加载头文件信息
        btWisFile:= True;//是否为wis文件
        m_ImgArr:= AllocMem(SizeOf(TDxImage) * FImageCount);
        if m_ImgArr = nil then raise Exception.Create (self.Name + ' ImgArr = nil');
        LoadWisPalette;//创建Wis256色调色板
      end else begin
        m_FileStream.Seek(0,0);
        m_FileStream.Read (Header, SizeOf(TWMImageHeader));
        if header.VerFlag = 0 then begin
          btVersion:=1;
          m_FileStream.Seek(-4,soFromCurrent);
        end;

        FImageCount := Header.ImageCount;
         //读取颜色和改变颜色
         //--------------------------------
         if header.ColorCount=256 then begin
           FBitFormat:=pf8Bit;
           FBytesPerPixels:=1;
         end else if header.ColorCount=65536 then begin
           FBitCount := 16;
           FBitFormat:=pf16bit;
           FBytesPerPixels:=2;
         end else if header.colorcount=16777216 then begin
           FBitFormat:=pf24Bit; FBytesPerPixels:=4
         end else if header.ColorCount>16777216 then begin
           FBitFormat:=pf32Bit; FBytesPerPixels:=4;
         end;
         ChangeDIBPixelFormat(lsDIB,FBitFormat);
        if LibType = ltLoadBmp then begin
          m_BmpArr := AllocMem (SizeOf(TBmpImage) * FImageCount);
          if m_BmpArr = nil then
             raise Exception.Create (self.Name + ' BmpArr = nil');
        end else begin
          m_ImgArr:=AllocMem(SizeOf(TDxImage) * FImageCount);
          if m_ImgArr = nil then
             raise Exception.Create (self.Name + ' ImgArr = nil');
        end;
        //索引文件
        idxfile := ExtractFilePath(FFileName) + ExtractFileNameOnly(FFileName) + '.WIX';
        LoadPalette;
        if LibType = ltLoadMemory then
          LoadAllData
        else begin
          LoadIndexWil (idxfile);
        end;
      end;
    end else if FileExists(NewFileName+'.wzl') then
    begin
      FFileType:=sftWzl;
      FFileName:=NewFileName+'.wzl';
      if m_FileStream = nil then m_FileStream := TFileStream.Create (FFileName, fmOpenRead or fmShareDenyNone);
      m_FileStream.Read (ZlibHeader, SizeOf(TWMZlibImageHeader));
      if ZlibHeader.Title<>ZlibTitle then Exit; //检查文件头是否为wzl文件格式

      btWzlFile:=True;
      FImageCount := ZlibHeader.ImageCount;
      if FImageCount < 1 then Exit;
      
      if LibType = ltLoadBmp then begin
        m_BmpArr := AllocMem (SizeOf(TBmpImage) * FImageCount);
        if m_BmpArr = nil then
           raise Exception.Create (self.Name + ' BmpArr = nil');
      end else begin
        m_ImgArr:=AllocMem(SizeOf(TDxImage) * FImageCount);
        if m_ImgArr = nil then
           raise Exception.Create (self.Name + ' ImgArr = nil');
      end;
      
      //索引文件
      LoadZLibPalette;
      idxfile := ExtractFilePath(FFileName) + ExtractFileNameOnly(FFileName) + '.WZX';
      if LibType = ltLoadMemory then
        LoadAllData
      else begin
        LoadIndexWzl (idxfile);
      end;
    end else
    begin
      Exit;
    end;
  end;
end;

procedure TWMImages.Finalize;
var
  i: integer;
begin
  //释放装载的所有图片
  //if FImageCount > 0 then begin//20080629
   for i:=0 to FImageCount-1 do begin
      if m_ImgArr[i].Surface <> nil then begin
         m_ImgArr[i].Surface.Free;
         m_ImgArr[i].Surface := nil;
      end;
   end;
  //end;
  if m_FileStream <> nil then FreeAndNil(m_FileStream);

  if FImageCount > 0 then begin
    if LibType = ltLoadBmp then begin //20080718释放内存
      FreeMem(m_BmpArr);
    end else begin
      FreeMem(m_ImgArr);
    end;
  end;
  UseIndexList.Clear;
end;

//装载图片到内存，需要大量内存！
procedure TWMImages.LoadAllData;
var
  i: integer;
  imgi: TWMImageInfo;
  dib: TDIB;
  dximg: TDxImage;
begin
  dib := TDIB.Create;
  if FImageCount > 0 then begin//20080629
    for i:=0 to FImageCount-1 do begin
      if btVersion <> 0 then m_FileStream.Read (imgi, sizeof(TWMImageInfo) - 4)
      else m_FileStream.Read (imgi, sizeof(TWMImageInfo));

      dib.Width := imgi.nWidth;
      dib.Height := imgi.nHeight;
      dib.ColorTable := MainPalette;
      dib.UpdatePalette;
      m_FileStream.Read (dib.PBits^, imgi.nWidth * imgi.nHeight);

      dximg.nPx := imgi.px;
      dximg.nPy := imgi.py;
      dximg.surface := TDirectDrawSurface.Create (FDDraw);
      dximg.surface.SystemMemory := True;
      dximg.surface.SetSize (imgi.nWidth, imgi.nHeight);
      //dximg.surface.LoadFromDIB (dib);
      dximg.surface.Canvas.Draw(0, 0, dib);
      dximg.surface.Canvas.Release;
      dib.Clear; //FreeImage;

      dximg.surface.TransparentColor := 0;
      m_ImgArr[i] := dximg;
      FreeAndNil(dximg.surface); //20080719添加
    end;
  end;
  dib.Free;
end;

//从WIL文件中装载调色板
procedure TWMImages.LoadPalette;
begin
   if btVersion <> 0 then
     m_FileStream.Seek (sizeof(TWMImageHeader) - 4, 0)
   else m_FileStream.Seek (sizeof(TWMImageHeader), 0);
     
   m_FileStream.Read (MainPalette, sizeof(TRgbQuad) * 256); //
end;

procedure TWMImages.LoadIndexWil (idxfile: string);
var
  fhandle, i, value: integer;
  header: TWMIndexHeader;
  //pidx: PTWMIndexInfo;  //20080718注释释放内存
  pvalue: PInteger;
begin
  m_IndexList.Clear;
  if FileExists (idxfile) then begin
    fhandle := FileOpen (idxfile, fmOpenRead or fmShareDenyNone);
    if fhandle > 0 then begin
      if btVersion <> 0 then
        FileRead (fhandle, header, sizeof(TWMIndexHeader) - 4)
      else
        FileRead (fhandle, header, sizeof(TWMIndexHeader));

      GetMem (pvalue, 4*header.IndexCount);
      FileRead (fhandle, pvalue^, 4*header.IndexCount);
      if header.IndexCount > 0 then //20080629
      for i:=0 to header.IndexCount-1 do begin
        value := PInteger(integer(pvalue) + 4*i)^;
        m_IndexList.Add (pointer(value));
      end;
      FreeMem(pvalue);
      FileClose (fhandle);
    end;
  end;
end;

procedure TWMImages.LoadIndexWzl (idxfile: string);
var
  fhandle, i, value: integer;
  header: TWMZlibIndexHeader;
  //pidx: PTWMIndexInfo;  //20080718注释释放内存
  pvalue: PInteger;
begin
  m_IndexList.Clear;
  if FileExists (idxfile) then begin
    fhandle := FileOpen (idxfile, fmOpenRead or fmShareDenyNone);
    if fhandle > 0 then begin
      FileRead (fhandle, header, sizeof(TWMZlibIndexHeader));
      //SetLength(IndexList,ZlibHeaderofIndex.IndexCount+1);
      //FileRead (fhandle, IndexList[0], 4*ZlibHeaderofIndex.IndexCount);
      //FileRead (fhandle, IndexList[0], 4*ZlibHeaderofIndex.IndexCount);

      GetMem (pvalue, 4*header.IndexCount);
      FileRead (fhandle, pvalue^, 4*header.IndexCount);
      if header.IndexCount > 0 then //20080629
        for i:=0 to header.IndexCount-1 do begin
          value := PInteger(integer(pvalue) + 4*i)^;
          m_IndexList.Add (pointer(value));
        end;
      FreeMem(pvalue);
      FileClose (fhandle);
    end;
  end;
end;

procedure TWMImages.LoadZlibPalette;
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

{----------------- Private Variables ---------------------}

function  TWMImages.FGetImageSurface (index: integer): TDirectDrawSurface;
begin
   Result := nil;
   if LibType = ltUseCache then begin
      Result := GetCachedSurface (index);
   end else
   if LibType = ltLoadMemory then begin
     if (index >= 0) and (index < ImageCount) then
       Result := m_ImgArr[index].Surface;
   end;
end;

function  TWMImages.FGetImageBitmap (index: integer): TBitmap;
begin
  Result:=nil;
  if LibType <> ltLoadBmp then exit;
  Result := GetCachedBitmap (index);
end;

procedure TWMImages.FSetDxDraw (fdd: TDxDraw);
begin
  FDxDraw := fdd;
end;

// *** DirectDrawSurface Functions
  procedure Move1(const Source; var Dest; count: Integer);
  asm
      cmp     eax, edx
      je      @@Exit {Source = Dest}
      cmp     ecx, 32
      ja      @@LargeMove {Count > 32 or Count < 0}
      sub     ecx, 8
      jg      @@SmallMove
    @@TinyMove: {0..8 Byte Move}
      jmp     dword ptr [@@JumpTable+32+ecx*4]
    @@SmallMove: {9..32 Byte Move}
      fild    qword ptr [eax+ecx] {Load Last 8}
      fild    qword ptr [eax] {Load First 8}
      cmp     ecx, 8
      jle     @@Small16
      fild    qword ptr [eax+8] {Load Second 8}
      cmp     ecx, 16
      jle     @@Small24
      fild    qword ptr [eax+16] {Load Third 8}
      fistp   qword ptr [edx+16] {Save Third 8}
    @@Small24:
      fistp   qword ptr [edx+8] {Save Second 8}
    @@Small16:
      fistp   qword ptr [edx] {Save First 8}
      fistp   qword ptr [edx+ecx] {Save Last 8}
    @@exit:
      ret
      nop {4-Byte Align JumpTable}
      nop
    @@JumpTable: {4-Byte Aligned}
      dd      @@Exit, @@M01, @@M02, @@M03, @@M04, @@M05, @@M06, @@M07, @@M08
    @@LargeForwardMove: {4-Byte Aligned}
      push    edx
      fild    qword ptr [eax] {First 8}
      lea     eax, [eax+ecx-8]
      lea     ecx, [ecx+edx-8]
      fild    qword ptr [eax] {Last 8}
      push    ecx
      neg     ecx
      and     edx, -8 {8-Byte Align Writes}
      lea     ecx, [ecx+edx+8]
      pop     edx
    @FwdLoop:
      fild    qword ptr [eax+ecx]
      fistp   qword ptr [edx+ecx]
      add     ecx, 8
      jl      @FwdLoop
      fistp   qword ptr [edx] {Last 8}
      pop     edx
      fistp   qword ptr [edx] {First 8}
      ret
    @@LargeMove:
      jng     @@LargeDone {Count < 0}
      cmp     eax, edx
      ja      @@LargeForwardMove
      sub     edx, ecx
      cmp     eax, edx
      lea     edx, [edx+ecx]
      jna     @@LargeForwardMove
      sub     ecx, 8 {Backward Move}
      push    ecx
      fild    qword ptr [eax+ecx] {Last 8}
      fild    qword ptr [eax] {First 8}
      add     ecx, edx
      and     ecx, -8 {8-Byte Align Writes}
      sub     ecx, edx
    @BwdLoop:
      fild    qword ptr [eax+ecx]
      fistp   qword ptr [edx+ecx]
      sub     ecx, 8
      jg      @BwdLoop
      pop     ecx
      fistp   qword ptr [edx] {First 8}
      fistp   qword ptr [edx+ecx] {Last 8}
    @@LargeDone:
      ret
    @@M01:
      movzx   ecx, [eax]
      mov     [edx], cl
      ret
    @@M02:
      movzx   ecx, word ptr [eax]
      mov     [edx], cx
      ret
    @@M03:
      mov     cx, [eax]
      mov     al, [eax+2]
      mov     [edx], cx
      mov     [edx+2], al
      ret
    @@M04:
      mov     ecx, [eax]
      mov     [edx], ecx
      ret
    @@M05:
      mov     ecx, [eax]
      mov     al, [eax+4]
      mov     [edx], ecx
      mov     [edx+4], al
      ret
    @@M06:
      mov     ecx, [eax]
      mov     ax, [eax+4]
      mov     [edx], ecx
      mov     [edx+4], ax
      ret
    @@M07:
      mov     ecx, [eax]
      mov     eax, [eax+3]
      mov     [edx], ecx
      mov     [edx+3], eax
      ret
    @@M08:
      fild    qword ptr [eax]
      fistp   qword ptr [edx]
  end;

procedure TWMImages.LoadDxImage (position, nSize: integer; pdximg: PTDxImage);

var
  imginfo: TWMImageInfo;
//  ddsd: TDDSurfaceDesc;
  SBits, PSrc, DBits: PByte;
 // n, slen: integer;
  WisImgInfo: TWisImageInfo;
  nPitch: Integer;
  nWidth: Integer;
  SrcP, DestP: Pointer;
  wDestP1, wDestP2, wDestP3, wDestP4: PWord;
  wSrcP1, wSrcP2, wSrcP3, wSrcP4: PWord;
  I, j: Integer;
  btSrcP1, btSrcP2, btSrcP3, btSrcP4: PByte;
  tmpcolor: TRGBQuad;

  {SrcDDSD, }DstDDSD: TDDSurfaceDesc2;
  S, D: Pointer;

  tmpDeStream: TDecompressionStream;
  ZlibImgInfo: TWMZlibImageInfo;
  tmpBitCount,nSize1: Integer;
  FColorCount,nHeight:Integer;
  FBitCount: byte;
  FBitFormat:TPixelFormat; //20090915

  procedure DecompressionMemoryStream;
  begin
    if ZlibImgInfo.DecodeSize>0 then
    begin
      try
        tmpDeStream := TDecompressionStream.Create(FSrcMemory);
      except
        tmpDeStream.Free;
        Exit;
      end;
      FDstMemory.Clear;
      FDstMemory.SetSize(nSize1);
      tmpDeStream.Read(FDstMemory.Memory^, nSize1);
      //move(FDstMemory.Memory^, Source.PBits^, nSize1);
      tmpDeStream.Free;
    end else
    begin
      FDstMemory.Clear;
      FDstMemory.SetSize(nSize1);
      m_FileStream.Read(FDstMemory.Memory^, nSize1);
    end;
  end;
  
begin
  if not btWisFile then
  begin//不是Wis文件
    if btWzlFile then
    begin
      m_FileStream.Seek (position, 0);
      m_FileStream.Read (ZlibImgInfo, sizeof(TWMZlibImageInfo));
      if (ZlibImgInfo.Width > 2000) or (ZlibImgInfo.Height > 2000) or
         (ZlibImgInfo.Width <1) or (ZlibImgInfo.Height <1) then Exit;

      if ZlibImgInfo.wColor = $103 then begin
        FColorCount := 256;
        FBitFormat:=pf8Bit;
        FBytesPerPixels:=1;
        tmpBitCount:=8;
      end else if ZlibImgInfo.wColor = $105 then begin
        FColorCount := 65536;
        FBitFormat:=pf16Bit;
        FBytesPerPixels:=2;
        tmpBitCount:=16;
      end else begin
        {FBitMap.Width := 1;
        FBitMap.Height := 1;
        FBitMap.Canvas.Brush.Color:=ClBlack;
        FBitMap.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));
        Exit;}
      end;

      pdximg.nPx := ZlibImgInfo.px;
      pdximg.nPy := ZlibImgInfo.py;
      nHeight := ZlibImgInfo.Height;
      if tmpBitCount = 8 then begin
        nWidth := WidthBytes(ZlibImgInfo.Width);
        nSize1 := nWidth * nHeight;
      end else begin
        nWidth := ZlibImgInfo.Width;
        nSize1 := nWidth * nHeight * (tmpBitCount div 8); //ImageInfo.nWidth
      end;

      if ZlibImgInfo.DecodeSize>0 then
      begin
        FSrcMemory.Clear;
        FSrcMemory.CopyFrom(m_FileStream, ZlibImgInfo.DecodeSize);
        FSrcMemory.Position:=0;
      end;

      if tmpBitCount = 16 then begin
        nWidth := ZlibImgInfo.Width;
        nPitch := WidthBytes(nWidth * 2);
        pdximg.Surface := TDirectDrawSurface.Create (FDDraw);
        pdximg.surface.SystemMemory := TRUE;
        pdximg.Surface.SetSize(nWidth, ZlibImgInfo.Height);
        {pdximg.Surface.Canvas.Brush.Color:=ClBlack;
        pdximg.Surface.Canvas.FillRect(Rect(0,0,nWidth,ImgInfo.nHeight));
        pdximg.Surface.Canvas.Release; }
        pdximg.nPx := ZlibImgInfo.px;
        pdximg.nPy := ZlibImgInfo.py;
        //DestP := pdximg.Surface.PBits;
        DstDDSD.dwSize := SizeOf(DstDDSD);
        pdximg.Surface.Lock(TRect(nil^), DstDDSD);
        
        //GetMem(SrcP, {nWidth *}nPitch * ImgInfo.nHeight {* 2});
        try
          DestP := DstDDSD.lpSurface;
          nSize1:=nPitch * nHeight;
          DecompressionMemoryStream;
          //m_FileStream.Read(SrcP^, {nWidth * }nPitch * ImgInfo.nHeight{ * 2});
          for I := ZlibImgInfo.Height - 1 downto 0 do begin
            wSrcP1 := PWord(Integer(FDstMemory.Memory) + nPitch * I);
            Move1(wSrcP1^, DestP^, nPitch);
            Inc(Integer(DestP), DstDDSD.lPitch);
          end;
        finally
          pdximg.Surface.UnLock();
          //FreeMem(SrcP, {nWidth * }nPitch *ImgInfo.nHeight{ * 2});
        end;
      end else begin
        nWidth := WidthBytes(ZlibImgInfo.Width);
        pdximg.Surface := TDirectDrawSurface.Create (FDDraw);
        pdximg.surface.SystemMemory := TRUE;
        pdximg.Surface.SetSize(ZlibImgInfo.Width, ZlibImgInfo.Height);
        pdximg.nPx := ZlibImgInfo.px;
        pdximg.nPy := ZlibImgInfo.py;

        DstDDSD.dwSize := SizeOf(DstDDSD);
        pdximg.Surface.Lock(TRect(nil^), DstDDSD);
        //DestP := pdximg.Surface.PBits;
        //DestP := DstDDSD.lpSurface;
        //GetMem(SrcP, nWidth * ImgInfo.nHeight);
        try
          wDestP1 := DstDDSD.lpSurface;
          //m_FileStream.Read(SrcP^, nWidth * ImgInfo.nHeight);
          nSize1:=nWidth * nHeight;
          DecompressionMemoryStream;
          for I := ZlibImgInfo.Height - 1 downto 0 do begin //wil的256色数据转换成16位数据
            btSrcP1 := PByte(Integer(FDstMemory.Memory) + nWidth * I);
            wDestP2 := wDestP1;
            for j := 0 to ZlibImgInfo.Width - 1 do begin
              tmpcolor := MainPalette[btSrcP1^];
              if Integer(tmpcolor) = 0 then begin
                wDestP2^ := 0;
              end else begin

                        //wDestP2^ :=Word((tmpcolor.rgbRed and $F8 shl 8) or (tmpcolor.rgbGreen and $FC shl 3) or (tmpcolor.rgbBlue and $F8 shr 3));
                wDestP2^ := Word((_MAX(tmpcolor.rgbRed and $F8, 8) shl 8) or (_MAX(tmpcolor.rgbGreen and $FC, 8) shl 3) or (_MAX(tmpcolor.rgbBlue and $F8, 8) shr 3)); //565格式
                     { end else begin
                        wDestP2^ := Word((_MAX(tmpcolor.rgbRed and $F8, 8) shl 7) or (_MAX(tmpcolor.rgbGreen and $F8, 8) shl 2) or (_MAX(tmpcolor.rgbBlue and $F8, 8) shr 3)); //555格式
                      end; }
              end;
              Inc(btSrcP1);
              Inc(wDestP2);
            end;
            Inc(Integer(wDestP1), DstDDSD.lPitch);
          end;
          pdximg.Surface.TransparentColor := 0;
        finally
          pdximg.Surface.UnLock();
          //FreeMem(SrcP, nWidth * ImgInfo.nHeight);
        end;
      end;

      {case tmpBitCount of
        8: begin
            Source := TDIB.Create;
            Move(MainPalette, Source.ColorTable, SizeOf(MainPalette));
            Source.UpdatePalette;
            Source.SetSize(nWidth, nHeight, 8);
            Source.Canvas.Brush.Color := clBlack;
            Source.Canvas.FillRect(Source.Canvas.ClipRect);
            DecompressionMemoryStream;
            SrcP := Source.PBits;
            NewWilTexture(SrcP, nWidth, nHeight, 8, pdximg, Source);
            Source.Free;
          end;
        16: begin
            Source := TDIB.Create;
            Source.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
            Source.SetSize(nWidth, nHeight, 16);
            Source.Canvas.Brush.Color := clBlack;
            Source.Canvas.FillRect(Source.Canvas.ClipRect);
            if nWidth =WidthBytes(nWidth) then
            begin
              DecompressionMemoryStream;
            end else
            begin
              nSize1 := WidthBytes(2*nWidth) * nHeight;  // * (BitCount div 8); //ImageInfo.nWidth
              //m_FileStream.Read(Source.PBits^, nSize1);
              DecompressionMemoryStream;
            end;

            if nWidth <> WidthBytes(nWidth) then
            begin
              nWidth := WidthBytes(nWidth);
              NewSource := TDIB.Create;
              NewSource.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
              NewSource.SetSize(nWidth, nHeight, 16);
              NewSource.Canvas.Brush.Color := clBlack;
              NewSource.Canvas.FillRect(NewSource.Canvas.ClipRect);
              NewSource.Canvas.Draw(0, 0, Source);
              Source.Free;
              Source := NewSource;
            end;
            SrcP := Source.PBits;
            NewWilTexture(SrcP, nWidth, nHeight, 16, pdximg, Source);
            Source.Free;
          end;
      end;}
    end else
    begin
      m_FileStream.Seek (position, 0);
      if btVersion <> 0 then m_FileStream.Read (imginfo, SizeOf(TWMImageInfo)-4)
      else m_FileStream.Read (imginfo, SizeOf(TWMImageInfo));

      (*try   //解决16色+ 花屏问题
        lsDib.Clear;
        lsDib.Width := imginfo.nWidth;
        lsDib.Height := imginfo.nHeight;
        ChangeDIBPixelFormat(lsDIB,FBitFormat);
      except
      end;
      lsDib.ColorTable := MainPalette;
      lsDib.UpdatePalette;
      lsDib.Canvas.Lock;
      try
        lsDib.Canvas.Brush.Color:=ClBlack;
        lsDib.Canvas.FillRect(Rect(0,0,lsdib.Width,lsdib.Height));
      finally
        lsDib.Canvas.Unlock;
      end;

      DBits := lsDib.PBits;
      m_FileStream.Read (DBits^, imginfo.nWidth * imgInfo.nHeight * FBytesPerPixels);
      pdximg.nPx := imginfo.px;
      pdximg.nPy := imginfo.py;
      pdximg.surface := TDirectDrawSurface.Create (FDDraw);
      pdximg.surface.SystemMemory := TRUE;
      pdximg.surface.SetSize (imginfo.nWidth, imginfo.nHeight);
      pdximg.Surface.Canvas.Lock;
      pdximg.surface.Canvas.Draw (0, 0, lsDib);
      pdximg.surface.Canvas.Release;
      pdximg.surface.TransparentColor := 0; *)
      if BitCount = 16 then begin
        nWidth := ImgInfo.nWidth;
        nPitch := WidthBytes(nWidth * 2);
        pdximg.Surface := TDirectDrawSurface.Create (FDDraw);
        pdximg.surface.SystemMemory := TRUE;
        pdximg.Surface.SetSize(nWidth, ImgInfo.nHeight);
        {pdximg.Surface.Canvas.Brush.Color:=ClBlack;
        pdximg.Surface.Canvas.FillRect(Rect(0,0,nWidth,ImgInfo.nHeight));
        pdximg.Surface.Canvas.Release; }
        pdximg.nPx := ImgInfo.px;
        pdximg.nPy := ImgInfo.py;
        //DestP := pdximg.Surface.PBits;
        DstDDSD.dwSize := SizeOf(DstDDSD);
        pdximg.Surface.Lock(TRect(nil^), DstDDSD);
        GetMem(SrcP, {nWidth *}nPitch * ImgInfo.nHeight {* 2});
        try
          DestP := DstDDSD.lpSurface;
          m_FileStream.Read(SrcP^, {nWidth * }nPitch * ImgInfo.nHeight{ * 2});
          for I := ImgInfo.nHeight - 1 downto 0 do begin
            wSrcP1 := PWord(Integer(SrcP) + nPitch * I);
            Move1(wSrcP1^, DestP^, nPitch);
            Inc(Integer(DestP), DstDDSD.lPitch);
          end;
        finally
          pdximg.Surface.UnLock();
          FreeMem(SrcP, {nWidth * }nPitch *ImgInfo.nHeight{ * 2});
        end;
      end else begin
        nWidth := WidthBytes(ImgInfo.nWidth);
        nPitch := nWidth * 2;
        pdximg.Surface := TDirectDrawSurface.Create (FDDraw);
        pdximg.surface.SystemMemory := TRUE;
        pdximg.Surface.SetSize(nWidth, ImgInfo.nHeight);
        pdximg.nPx := ImgInfo.px;
        pdximg.nPy := ImgInfo.py;

        DstDDSD.dwSize := SizeOf(DstDDSD);
        pdximg.Surface.Lock(TRect(nil^), DstDDSD);
        //DestP := pdximg.Surface.PBits;
        //DestP := DstDDSD.lpSurface;
        GetMem(SrcP, nWidth * ImgInfo.nHeight);
        try
          wDestP1 := DstDDSD.lpSurface;
          m_FileStream.Read(SrcP^, nWidth * ImgInfo.nHeight);
          for I := ImgInfo.nHeight - 1 downto 0 do begin //wil的256色数据转换成16位数据
            btSrcP1 := PByte(Integer(SrcP) + nWidth * I);
            wDestP2 := wDestP1;
            for j := 0 to ImgInfo.nWidth - 1 do begin
              tmpcolor := MainPalette[btSrcP1^];
              if Integer(tmpcolor) = 0 then begin
                wDestP2^ := 0;
              end else begin

                        //wDestP2^ :=Word((tmpcolor.rgbRed and $F8 shl 8) or (tmpcolor.rgbGreen and $FC shl 3) or (tmpcolor.rgbBlue and $F8 shr 3));
                wDestP2^ := Word((_MAX(tmpcolor.rgbRed and $F8, 8) shl 8) or (_MAX(tmpcolor.rgbGreen and $FC, 8) shl 3) or (_MAX(tmpcolor.rgbBlue and $F8, 8) shr 3)); //565格式
                     { end else begin
                        wDestP2^ := Word((_MAX(tmpcolor.rgbRed and $F8, 8) shl 7) or (_MAX(tmpcolor.rgbGreen and $F8, 8) shl 2) or (_MAX(tmpcolor.rgbBlue and $F8, 8) shr 3)); //555格式
                      end; }
              end;
              Inc(btSrcP1);
              Inc(wDestP2);
            end;
            Inc(Integer(wDestP1), DstDDSD.lPitch);
          end;
          pdximg.Surface.TransparentColor := 0;
        finally
          pdximg.Surface.UnLock();
          FreeMem(SrcP, nWidth * ImgInfo.nHeight);
        end;
      end;
    end;
  end else
  begin//Wis文件
    if position <= 0 then Exit;//20090905 增加，指针为0则退出
    m_FileStream.Seek (position, 0);
    m_FileStream.Read (WisImgInfo, SizeOf(TWisImageInfo));
    //if g_boUseDIBSurface then begin //DIB
      //非全屏时
      try
        lsDib.Clear;
        lsDib.Width := WisImgInfo.Width;
        lsDib.Height := WisImgInfo.Height;
      except
      end;
      lsDib.ColorTable := MainPalette;
      lsDib.UpdatePalette;
      DBits := lsDib.PBits;
      case WisImgInfo.nUnknown of
        0:begin//未压缩的图片数据
          FBytesPerPixels:= 1;
          ChangeDIBPixelFormat(lsDib, FBitFormat);//这个过程，FBitFormat格式，主要这个，原来设置为pf8bit,就是全黑
          lsDib.Width := WisImgInfo.Width;
          lsDib.Height := WisImgInfo.Height;//X, Y ,高，宽正确
          lsDib.ColorTable := MainPalette;
          lsDib.UpdatePalette;//更新系统调色板
          lsDib.Canvas.Brush.Color:= ClBlack;
          lsDIB.Canvas.FillRect(lsDIB.Canvas.ClipRect);//20100515 替换
          DBits := lsDib.PBits;
          for I := 0 to lsDIB.Height - 1 do begin
            SBits := PByte(Integer(lsDIB.PBits) + (lsDIB.Height - 1 - I) * lsDIB.WidthBytes);
            m_FileStream.Read(SBits^, WisImgInfo.Width);
          end;
        end;
        1: begin //压缩
          FBytesPerPixels:= 1;
          ChangeDIBPixelFormat(lsDib, FBitFormat);//这个过程，FBitFormat格式，主要这个，原来设置为pf8bit,就是全黑
          lsDib.Width := WisImgInfo.Width;
          lsDib.Height := WisImgInfo.Height;//X, Y ,高，宽正确
          lsDib.ColorTable := MainPalette;
          lsDib.UpdatePalette;//更新系统调色板
          lsDib.Canvas.Brush.Color:= ClBlack;
          lsDIB.Canvas.FillRect(lsDIB.Canvas.ClipRect);//20100515 替换
          DBits := lsDib.PBits;
          GetMem(S, nSize * FBytesPerPixels);
          GetMem(D, WisImgInfo.Width * WisImgInfo.Height);
          try
            SBits := S;
            DBits := D;
            m_FileStream.Read(SBits^, nSize * FBytesPerPixels);
            DecodeWis(SBits, DBits, nSize * FBytesPerPixels, WisImgInfo.Width * WisImgInfo.Height);
            for I := 0 to lsDIB.Height - 1 do begin
              SBits := PByte(Integer(D) + I * WisImgInfo.Width);
              DBits := PByte(Integer(lsDIB.PBits) + (lsDIB.Height - 1 - I) * lsDIB.WidthBytes);
              Move(SBits^, DBits^, lsDIB.Width);
            end;
          finally
            FreeMem(S);
            FreeMem(D);
          end;
        end;
        2: begin//16位图不压缩
          ChangeDIBPixelFormat(lsDib, pf16bit);//这个过程，FBitFormat格式，主要这个，原来设置为pf8bit,就是全黑
          lsDib.Width := WisImgInfo.Width;
          lsDib.Height := WisImgInfo.Height;//X, Y ,高，宽正确
          lsDib.ColorTable := MainPalette;
          lsDib.UpdatePalette;//更新系统调色板
          lsDib.Canvas.Brush.Color:= ClBlack;
          lsDIB.Canvas.FillRect(lsDIB.Canvas.ClipRect);
          DBits := lsDib.PBits;
          FBytesPerPixels:= 2;

          for I := 0 to lsDIB.Height - 1 do begin
            SBits := PByte(Integer(lsDIB.PBits) + (lsDIB.Height - 1 - I) * lsDIB.WidthBytes);
            m_FileStream.Read(SBits^, WisImgInfo.Width * FBytesPerPixels);
          end;
        end;
        3: begin//16位压缩

        end;
      end;//case
      (*if WisImgInfo.nUnknown <> 1 then begin//未加密的图片数据
        case WisImgInfo.Width of
          3,5,6,7,9..11,13..15,17..19,21..23,25..27,29..31,33..35,37..39,41..43,45..47,
          49..51,53..55,57..59,61..63,65..67,69..71,73..75,77..79,81..83,85..87,89..91,
          93..95,97..99,101..103,105..107,109..111,113..115,117..119,
          121..123,125..127,129,
          130,133..135,137,
          142,147,145,169,191,217,241,263,
          289,313,335,361,383,406,433,478:begin
            GetMem(SBits, nSize{ * FBytesPerPixels});
            try
              m_FileStream.Read(SBits^, nSize{ * FBytesPerPixels});
              Wis_RLE8_Decode(SBits, DBits, nSize{ * FBytesPerPixels}, WisImgInfo.Width);
            finally
              FreeMem(SBits);
            end;
          end;
          else begin
            m_FileStream.Read(DBits^, nSize{ * FBytesPerPixels});
          end;
        end;
      end else begin//加密的图片数据
        GetMem(SBits, nSize{ * FBytesPerPixels});
        try
          m_FileStream.Read(SBits^, nSize{ * FBytesPerPixels});
          Wis_RLE8_Decode1(SBits, DBits, nSize{ * FBytesPerPixels}, WisImgInfo.Width * WisImgInfo.Height, WisImgInfo.Width, WisImgInfo.Height);
        finally
          FreeMem(SBits);
        end;
      end; *)
      pdximg.nPx := WisImgInfo.px;
      pdximg.nPy := WisImgInfo.py;

      pdximg.surface := TDirectDrawSurface.Create (FDDraw);
      pdximg.surface.SystemMemory := TRUE;
      pdximg.surface.SetSize (WisImgInfo.Width, WisImgInfo.Height);
      //StretchBlt(lsDib.Canvas.Handle,0,0,lsDib.Width,lsDib.Height, lsDib.Canvas.Handle,0,lsDib.Height-1,lsDib.Width, -1*lsDib.Height,SRCCOPY);
      //pdximg.surface.LoadFromDIB(lsDib);
      pdximg.surface.Canvas.Draw (0, 0, lsDib);
      pdximg.surface.Canvas.Release;

      pdximg.surface.TransparentColor := 0;
    (*end else begin //此处代码Wis显示错乱，暂时找不出原因 20090617  所有图需要不同于以前的处理，如308图， 每行填充4字节后为正确的图片 20090803
      //全屏时
      pdximg.surface := TDirectDrawSurface.Create (FDDraw);
      pdximg.surface.SystemMemory := TRUE;
      pdximg.surface.SetSize (WisImgInfo.Width, WisImgInfo.Height);

      pdximg.nPx := imginfo.px;
      pdximg.nPy := imginfo.py;
      ddsd.dwSize := SizeOf(ddsd);

      if WisImgInfo.nUnknown <> 1 then begin//未加密的图片数据
        case WisImgInfo.Width of
          {3,5,6,7,9..11,13..15,17..19,21..23,25..27,29..31,33..35,37..39,41..43,45..47,
          49..51,53..55,57..59,61..63,65..67,69..71,73..75,77..79,81..83,85..87,89..91,
          93..95,97..99,101..103,105..107,109..111,113,114,118,145,169,191,217,241,263,
          289,313,335,361,406,433,478:begin
            GetMem(SBits, nSize);
            try
              m_FileStream.Read(SBits^, nSize);
              pdximg.surface.Lock (TRect(nil^), ddsd);
              try
                DBits := ddsd.lpSurface;
                Wis_RLE8_Decode(SBits, DBits, nSize, WisImgInfo.Width);
                pdximg.surface.TransparentColor := 0;
              finally
                pdximg.surface.UnLock();
              end;
            finally
              FreeMem(SBits);
            end;
          end;     }
          12,20,28,35,36,44,52,76,100,308,420,452:begin
            GetMem(SBits, nSize{ * FBytesPerPixels});
            try
              m_FileStream.Read(SBits^, nSize{ * FBytesPerPixels});
              pdximg.surface.Lock (TRect(nil^), ddsd);
              try
                DBits := ddsd.lpSurface;
                Wis_RLE8_DecodeAll(SBits, DBits, nSize{ * FBytesPerPixels}, WisImgInfo.Width);
                pdximg.surface.TransparentColor := 0;
              finally
                pdximg.surface.UnLock();
              end;
            finally
              FreeMem(SBits);
            end;
          end;
          else begin
            pdximg.surface.Lock (TRect(nil^), ddsd);
            try
              DBits := ddsd.lpSurface;
              m_FileStream.Read(DBits^, nSize{ * FBytesPerPixels});
              pdximg.surface.TransparentColor := 0;
            finally
              pdximg.surface.UnLock();
            end;
          end;
        end;
      end else begin//加密的图片数据
        case WisImgInfo.Width of
          12,20,28,36,52,60,92,276:begin
            GetMem(SBits, nSize{ * FBytesPerPixels});
            try
              m_FileStream.Read(SBits^, nSize{ * FBytesPerPixels});
              pdximg.surface.Lock (TRect(nil^), ddsd);
              try
                DBits := ddsd.lpSurface;
                Wis_RLE8_Decode1All(SBits, DBits, nSize{ * FBytesPerPixels}, WisImgInfo.Width * WisImgInfo.Height, WisImgInfo.Width, WisImgInfo.Height);
                pdximg.surface.TransparentColor := 0;
              finally
                pdximg.surface.UnLock();
              end;
            finally
              FreeMem(SBits);
            end;
          end;
          else begin
            GetMem(SBits, nSize{ * FBytesPerPixels});
            try
              m_FileStream.Read(SBits^, nSize{ * FBytesPerPixels});
              pdximg.surface.Lock (TRect(nil^), ddsd);
              try
                DBits := ddsd.lpSurface;
                Wis_RLE8_Decode1(SBits, DBits, nSize{ * FBytesPerPixels}, WisImgInfo.Width * WisImgInfo.Height, WisImgInfo.Width, WisImgInfo.Height);
                pdximg.surface.TransparentColor := 0;
              finally
                pdximg.surface.UnLock();
              end;
            finally
              FreeMem(SBits);
            end;
          end;
        end;
      end;      
    end; *)
  end;
end;

procedure TWMImages.LoadBmpImage (position: integer; pbmpimg: PTBmpImage);
var
  imginfo: TWMImageInfo;
  DBits: PByte;
begin
  m_FileStream.Seek (position, 0);
  m_FileStream.Read (imginfo, sizeof(TWMImageInfo)-4);

  lsDib.Width := imginfo.nWidth;
  lsDib.Height := imginfo.nHeight;
  lsDib.ColorTable := MainPalette;
  lsDib.UpdatePalette;
  DBits := lsDib.PBits;
  m_FileStream.Read (DBits^, imginfo.nWidth * imgInfo.nHeight);

  pbmpimg.bmp := TBitmap.Create;
  pbmpimg.bmp.Width := lsDib.Width;
  pbmpimg.bmp.Height := lsDib.Height;
  pbmpimg.bmp.Canvas.Draw (0, 0, lsDib);
  lsDib.Clear;
end;

procedure TWMImages.ClearCache;
var
  i: integer;
begin
  if ImageCount > 0 then //20080629
  for i:=0 to ImageCount - 1 do begin
    if m_ImgArr[i].Surface <> nil then begin
       m_ImgArr[i].Surface.Free;
       m_ImgArr[i].Surface := nil;
    end;
  end;
  UseIndexList.Clear;
  //MemorySize := 0;
end;

function  TWMImages.GetImage (index: integer; var px, py: integer): TDirectDrawSurface;
begin
  if (index >= 0) and (index < ImageCount) then begin
    px := m_ImgArr[index].nPx;
    py := m_ImgArr[index].nPy;
    Result := m_ImgArr[index].surface;
  end else Result := nil;
end;

{--------------- BMP functions ----------------}

procedure TWMImages.FreeOldBmps;
var
  i, ntime{, curtime}: integer;
begin
  ntime := 0;
  if ImageCount > 0 then //20080629
  for i:=0 to ImageCount-1 do begin
  //      curtime := GetTickCount;
    if m_BmpArr[i].Bmp <> nil then begin
      if GetTickCount - m_BmpArr[i].dwLatestTime > 5000 then begin
        m_BmpArr[i].Bmp.Free;
        m_BmpArr[i].Bmp := nil;
      end else begin
        if GetTickCount - m_BmpArr[i].dwLatestTime > ntime then begin
          ntime := GetTickCount - m_BmpArr[i].dwLatestTime;
        end;
      end;
    end;
  end;
end;

procedure TWMImages.FreeBitmap (index: integer);
begin
  if (index >= 0) and (index < ImageCount) then begin
    if m_BmpArr[index].Bmp <> nil then begin
      //MemorySize  := MemorySize - BmpArr[index].Bmp.Width * BmpArr[index].Bmp.Height;
      //if MemorySize < 0 then MemorySize := 0;
      m_BmpArr[index].Bmp.FreeImage;
      m_BmpArr[index].Bmp.Free;
      m_BmpArr[index].Bmp := nil;
    end;
  end;
end;


procedure TWMImages.FreeOldMemorys;
var
  i: integer;
begin
  if ImageCount > 0 then //20080629
  for i:=0 to ImageCount-1 do begin
    if m_ImgArr[i].Surface <> nil then begin
      if GetTickCount - m_ImgArr[i].dwLatestTime > 2 * 60 * 1000 then begin
        try
          if m_ImgArr[I].Surface <> nil then m_ImgArr[I].Surface.Free;
        except
          m_ImgArr[I].Surface := nil;
        end;
        m_ImgArr[I].Surface := nil;
        //FreeAndNil(m_ImgArr[i].Surface); //20081719修改
      end;
    end;
  end;
end;

//Cache甫 捞侩窃
function  TWMImages.GetCachedSurface (index: integer): TDirectDrawSurface;
var
  nPosition, nSize:Integer;
begin
  Result := nil;
  try
    if (index < 0) or (index >= ImageCount) then exit;
    if GetTickCount - m_dwMemChecktTick > 10000 then  begin
      m_dwMemChecktTick := GetTickCount;
      //if MemorySize > FMaxMemorySize then begin
      FreeOldMemorys();
      //end;
    end;
    if m_ImgArr[index].Surface = nil then begin //cache登绢 乐瘤 臼澜. 货肺 佬绢具窃.
      if index < m_IndexList.Count then begin
        if not btWisFile then begin
          nPosition:= Integer(m_IndexList[index]);
          LoadDxImage (nPosition, 0, @m_ImgArr[index]);
        end else begin
          nPosition := pTWisIndexInfo(m_IndexList.Items[index]).nPosition;//图片在流中的位置
          nSize := pTWisIndexInfo(m_IndexList.Items[index]).nSize;//图片数据块大小
          LoadDxImage (nPosition, nSize, @m_ImgArr[index]);
        end;
        m_ImgArr[index].dwLatestTime := GetTickCount;
        Result := m_ImgArr[index].Surface;
        //MemorySize := MemorySize + ImgArr[index].Surface.Width * ImgArr[index].Surface.Height;
      end;
    end else begin
      m_ImgArr[index].dwLatestTime := GetTickCount;
      Result := m_ImgArr[index].Surface;
    end;
  except
    //DebugOutStr ('GetCachedSurface 3 Index: ' + IntToStr(index) + ' Error Code: ' + IntToStr(nErrCode));
  end;
end;

function  TWMImages.GetCachedImage (index: integer; var px, py: integer): TDirectDrawSurface;
var
  position, nSize: integer;
begin
  Result := nil;
  try
    if (index < 0) or (index >= ImageCount) then Exit;
    if GetTickCount - m_dwMemChecktTick > 10000 then  begin
      m_dwMemChecktTick := GetTickCount;
      //if MemorySize > FMaxMemorySize then begin
      FreeOldMemorys();
      //end;
    end;
    if m_ImgArr[index].Surface = nil then begin //cache
      if index < m_IndexList.Count then begin
        if not btWisFile then begin
          position := Integer(m_IndexList[index]);
          LoadDxImage (position, 0, @m_ImgArr[index]);
        end else begin
          Position := pTWisIndexInfo(m_IndexList.Items[index]).nPosition;//图片在流中的位置
          nSize := pTWisIndexInfo(m_IndexList.Items[index]).nSize;//图片数据块大小
          LoadDxImage (position, nSize, @m_ImgArr[index]);
        end;
        m_ImgArr[index].dwLatestTime := GetTickCount;
        px := m_ImgArr[index].nPx;
        py := m_ImgArr[index].nPy;
        Result := m_ImgArr[index].Surface;
        //MemorySize := MemorySize + ImgArr[index].Surface.Width * ImgArr[index].Surface.Height;
      end;
    end else begin
      m_ImgArr[index].dwLatestTime := GetTickCount;
      px := m_ImgArr[index].nPx;
      py := m_ImgArr[index].nPy;
      Result := m_ImgArr[index].Surface;
    end;
  except
    //DebugOutStr ('GetCachedImage 3 Index: ' + IntToStr(index) + ' Error Code: ' + IntToStr(nErrCode));
  end;
end;

function  TWMImages.GetCachedBitmap (index: integer): TBitmap;
var
  position: integer;
begin
   Result := nil;
   if (index < 0) or (index >= ImageCount) then exit;
   if m_BmpArr[index].Bmp = nil then begin //cache登绢 乐瘤 臼澜. 货肺 佬绢具窃.
      if index < m_IndexList.Count then begin
        position := Integer(m_IndexList[index]);
        LoadBmpImage (position, @m_BmpArr[index]);
        m_BmpArr[index].dwLatestTime := GetTickCount;
        Result := m_BmpArr[index].Bmp;
        //MemorySize := MemorySize + BmpArr[index].Bmp.Width * BmpArr[index].Bmp.Height;
        //if (MemorySize > FMaxMemorySize) then begin
        FreeOldBmps;
        //end;
      end;
   end else begin
     m_BmpArr[index].dwLatestTime:=GetTickCount;
     Result := m_BmpArr[index].Bmp;
   end;
end;

//------------------------------------------------------------------------------
function ListSortMax(iP1, iP2: Pointer):Integer;//降序
begin
  if pTWisIndexInfo(iP1)^.nUnknown > pTWisIndexInfo(iP2)^.nUnknown then Result := -1
  else if pTWisIndexInfo(iP1)^.nUnknown = pTWisIndexInfo(iP2)^.nUnknown then Result := 0
  else Result := 1;
end;
//读取wis文件图片索引
function TWMImages.LoadWisIndex (filename: string): Boolean;
  function DecPointer(P: Pointer; Size: Integer): Pointer;
  begin
    Result := Pointer(Integer(P) - Size);
  end;
var
  //K: TWisIndexInfo;
  KK: pTWisIndexInfo;
  //I, nSize, J: Integer;

  MapStream: TMapStream;
  WisHeader: pTWisIndexInfo;
  IndexArray: TWisFileHeaderArray;
  WisIndexArray: TWisFileHeaderArray;
  iFileOffset, nIndex, nIndexOffset: Integer;
begin
  Result := False;
  m_IndexList.Clear;
 (* m_FileStream.Position := m_FileStream.Size - 12;//找到最后一个索引的位置,计算出索引开始的位置
  nSize:= SizeOf(TWisIndexInfo);
  if {(filename <> '') and }(CompareStr(filename, 'Prguse.wis') <> 0) and (CompareStr(filename, 'StateItem.wis') <> 0) and (CompareStr(filename, 'cbohair.wis') <> 0) then begin
    m_FileStream.ReadBuffer(K, nSize);//20090905 注释，换办法读Wis索引
    if k.nSize < 13 then begin
      m_FileStream.Position := 13 + K.nPosition;
    end else begin
      m_FileStream.Position := k.nSize + K.nPosition;
    end;
    while (m_FileStream.Position < m_FileStream.Size) do Begin
      FillChar(K, nSize, #0);
      m_FileStream.ReadBuffer(K, nSize);
      New(KK);
      KK.nPosition:= K.nPosition;
      KK.nSize:= K.nSize - nSize;
      m_IndexList.Add(KK);
    end;
  end else begin
    J:= 0;
    while (m_FileStream.Position < m_FileStream.Size) and (m_FileStream.Position > 511) do Begin//从尾部读出，一直读到指针为512时，即第一个图时退出
      if (m_FileStream.Position < 512) then Break;
      FillChar(K, nSize{SizeOf(TWisIndexInfo)}, #0);
      m_FileStream.ReadBuffer(K, nSize{SizeOf(TWisIndexInfo)});
      if (K.nPosition > 511) and (K.nSize > 12) and (K.nPosition < m_FileStream.Size) and (K.nSize < m_FileStream.Size) then begin//20090904 增加
        Inc(J);
        New(KK);
        KK.nPosition:= K.nPosition;
        KK.nSize:= K.nSize - nSize{SizeOf(TWisImageInfo)};//由于 TWisImageInfo,TWisIndexInfo大小一致，所以可以使用同个大小
        KK.nUnknown:= J;
        //TempList.Add(KK);
        m_IndexList.Add(KK);
      end;
      if (K.nPosition = 512) then Break;
      m_FileStream.Position := m_FileStream.Position - 24;
    end;
    if m_IndexList.Count > 0 then TDQuickSort(m_IndexList, 0 , m_IndexList.Count - 1, ListSortMax);//m_IndexList.Sort(@ListSortMax);
  end;        *)

//-------------------------------------------------------------------------------
  MapStream := TMapStream.Create;
  try
    if MapStream.LoadFromFile(FFileName) then begin
      iFileOffset := 512;
      nIndexOffset := MapStream.Size;
      WisHeader := Pointer(Integer(MapStream.Memory) + MapStream.Size);
      while True do begin
        if nIndexOffset > iFileOffset then begin
          Dec(nIndexOffset, SizeOf(TWisIndexInfo));
          WisHeader := DecPointer(WisHeader, SizeOf(TWisIndexInfo));
          if (WisHeader.nPosition >= iFileOffset) and (WisHeader.nSize >= 1) then begin
            SetLength(WisIndexArray, Length(WisIndexArray) + 1);
            WisIndexArray[Length(WisIndexArray) - 1] := WisHeader^;
            if (WisHeader.nPosition <= iFileOffset) then break;
          end else break;
        end else break;
      end;

      //SetLength(IndexArray, Length(WisIndexArray));
      for nIndex := 0 to Length(WisIndexArray) - 1 do begin//由于从文件尾部读出，所以需要重循环写入才能得到正确的顺序
        //IndexArray[nIndex] := WisIndexArray[Length(WisIndexArray) - nIndex - 1];
        New(KK);
        KK.nPosition:= WisIndexArray[Length(WisIndexArray) - nIndex - 1].nPosition;
        KK.nSize:= WisIndexArray[Length(WisIndexArray) - nIndex - 1].nSize;
        m_IndexList.Add(KK);
      end;
    end;
  finally
    MapStream.Free;
  end;
//-------------------------------------------------------------------------------

  if m_IndexList.Count > 0 then begin
    FImageCount := m_IndexList.Count;//图片数量
    Result := True;
  end;
end;

//由于Wis没有256色的调色板，需要自行创建调色板
procedure TWMImages.LoadWisPalette;
begin
  Move(ColorArray, MainPalette, SizeOf(ColorArray));//传递调色板数据
end;

//WIS算法(压缩解法) 20100803
function TWMImages.DecodeWis(ASrc, ADst: PByte; ASrcSize, ADstSize: Integer): Boolean;
var
  V, Len, L, I: Byte;
  boSkip: Boolean;
begin
  Result := False;
  boSkip := False;
  Len := 0;
  L := 0;
  while (ASrcSize > 0) and (ADstSize > 0) do begin
    if not boSkip then begin
      V := ASrc^;
      Dec(ASrcSize);
      Inc(PByte(ASrc));
    end;
    if (V = 0) and (Len <= 0) then begin
      V := ASrc^;
      Len := V;
      Dec(ASrcSize);
      Inc(PByte(ASrc));
      boSkip := True;
    end;
    if boSkip then begin
      if Len <> 0 then begin
        Dec(ADstSize, Len);
        Dec(ASrcSize, Len);
        Move(ASrc^, ADst^, Len);
        Inc(PByte(ADst), Len);
        Inc(PByte(ASrc), Len);
      end else boSkip := False;
      Len := 0;
    end else begin
      L := V;
      Dec(ASrcSize);
      Dec(ADstSize, L);
      V := ASrc^;
      Inc(PByte(ASrc));
      for I := 1 to L do begin
        ADst^ := V;
        Inc(ADst);
      end;
      L := 0;
    end;
  end;
  Result := True;
end;

//Wis图片数据还原(压缩数据使用) 20090805 修改
function TWMImages.Wis_RLE8_Decode1(ASrc, ADst: PByte; ASrcSize, ADstSize, nWidth, nHeight: Integer): Boolean;
var
  L,K: Byte;
  I,nCount:Integer;
begin
  Result := False;
  nCount:= 0;
  while (ASrcSize > 0) and (ADstSize > 0) do begin
    L := ASrc^;
    Inc(ASrc);
    Dec(ASrcSize, 2);
    K:= ASrc^;
    if L = 0 then begin
      Dec(ADstSize, K);
      for I := 1 to K do begin
        Inc(nCount);
        Inc(ASrc);
        ADst^ := ASrc^;
        Inc(ADst);
        if (nCount >= nWidth) then begin
          if Odd(nWidth) then begin//宽度为奇数时，达到宽度时增加一字节
            case nWidth of
              7,11,15,19,23,27,31,35,39,43,47,51,55,59,63,67,
              71,75,79,83,87,91,95,99,103,107,111,115,119,123,127,
              131,135,139,143,147,151,155,159,163,167,171,175,179,183,187,191,195,199,207,
              211,215,219,223,227,231,235,243,247,251,255,259,263,275,279,283,287,291,295,299,307,311,
              315,319,323,327,331,335,339,343,347,351,359,363,367,371,375,379,387,391,395,399,
              403,407,411,415,419,423,435,439,443,459,479:begin
                ADst^ := 0;
                Inc(ADst);
              end;
              5,9,13,17,21,25,29,33,37,41,45,49,53,57,61,65,69,73,77,81,85,89,93,97,
              101,105,109,113,117,121,125,129,133,137,141,145,149,153,157,161,165,169,173,177,181,185,189,193,197,
              201,205,209,213,217,221,225,229,233,237,241,245,249,253,257,261,265,269,273,277,281,285,289,293,297,
              301,305,313,317,321,325,329,333,337,341,345,349,353,357,361,365,369,373,377,381,385,389,397,
              401,405,413,417,421,425,429,433,441,457,461:begin
                ADst^ := 0;
                Inc(ADst);
                ADst^ := 0;
                Inc(ADst);
                ADst^ := 0;
                Inc(ADst);
              end;
            end;
          end else begin
             case nWidth of   //18*的图有点问题 cboHumEffect.wis 尾部
               6,10,14,18,22,26,30,34,38,42,46,50,54,58,62,66,70,74,78,82,86,90,94,98,
               102,106,114,118,110,122,126,130,134,138,142,146,
               150,154,158,162,166,170,174,178,
               182,186,190,194,198,202,206,210,214,218,222,226,
               230,234,238,242,246,250,254,258,262,266,270,274,278,282,286,290,294,298,
               302,306,314,326,330,334,338,342,346,350,354,358,362,366,370,374,378,382,390,394,398,402,406,410,414,434,438,478:begin
                 ADst^ := 0;
                 Inc(ADst);
                 ADst^ := 0;
                 Inc(ADst);
               end;
             end;
          end;
          nCount:= 0;
        end;
      end;
    end else begin
      Dec(ADstSize, L);
      for I := 1 to L do begin
        Inc(nCount);
        ADst^ := K;
        Inc(ADst);
        if (nCount >= nWidth) then begin
          if Odd(nWidth) then begin//宽度为奇数时，达到宽度时增加一字节
            case nWidth of
              7,11,15,19,23,27,31,35,39,43,47,51,55,59,63,67,
              71,75,79,83,87,91,95,99,103,107,111,115,119,123,127,
              131,135,139,143,147,151,155,159,163,167,171,175,179,183,187,191,195,199,207,
              211,215,219,223,227,231,235,243,247,251,255,259,263,275,279,283,287,291,295,299,307,311,
              315,319,323,327,331,335,339,343,347,351,359,363,367,371,375,379,387,391,395,399,
              403,407,411,415,419,423,435,439,443,459,479:begin
                ADst^ := K;
                Inc(ADst);
              end;
              5,9,13,17,21,25,29,33,37,41,45,49,53,57,61,65,69,73,77,81,85,89,93,97,
              101,105,109,113,117,121,125,129,133,137,141,145,149,153,157,161,165,169,173,177,181,185,189,193,197,
              201,205,209,213,217,221,225,229,233,237,241,245,249,253,257,261,265,269,273,277,281,285,289,293,297,
              301,305,313,317,321,325,329,333,337,341,345,349,353,357,361,365,369,373,377,381,385,389,397,
              401,405,413,417,421,425,429,433,441,457,461:begin
                ADst^ := 0;
                Inc(ADst);
                ADst^ := 0;
                Inc(ADst);
                ADst^ := 0;
                Inc(ADst);
              end;
            end;
          end else begin
             case nWidth of   //18*的图有点问题 cboHumEffect.wis 尾部
               6,10,14,18,22,26,30,34,38,42,46,50,54,58,62,66,70,74,78,82,86,90,94,98,
               102,106,114,118,110,122,126,130,134,138,142,146,
               150,154,158,162,166,170,174,178,
               182,186,190,194,198,202,206,210,214,218,222,226,
               230,234,238,242,246,250,254,258,262,266,270,274,278,282,286,290,294,298,
               302,306,314,326,330,334,338,342,346,350,354,358,362,366,370,374,378,382,390,394,398,402,406,410,414,434,438,478:begin
                 ADst^ := K;
                 Inc(ADst);
                 ADst^ := K;
                 Inc(ADst);
               end;
             end;
          end;
          nCount:= 0;
        end;
      end;
    end;
    Inc(ASrc);
  end;
  Result := True;
end;

//Wis图片数据还原(未压缩的数据) 20091117 修改
function TWMImages.Wis_RLE8_Decode(ASrc, ADst: PByte; ASrcSize,nWidth: Integer): Boolean;
var
  K: Byte;
  nCount:Integer;
  IsOdd: Boolean;
begin
  nCount:= 0;
  if (nWidth = 5) then begin
    ADst^ := 0;
    Inc(ADst);
    Dec(ASrcSize);
  end;
  IsOdd:= Odd(nWidth);
  while (ASrcSize > 0) do begin
    K:= ASrc^;
    ADst^:= K;
    Inc(ADst);
    Inc(ASrc);
    Dec(ASrcSize);
    Inc(nCount);
    if (nCount >= nWidth) then begin
      if IsOdd then begin//宽度为奇数时，达到宽度时增加一字节
        case nWidth of
          3,7,11,15,19,27,35,23,31,39,43,47,51,55,59,63,67,71,75,79,83,87,91,
          95,99,103,107,111,115,119,123,127,135,147,191,263,335,383:begin
            ADst^ := K;
            Inc(ADst);
          end;
          9,13,17,21,25,29,33,37,41,45,49,53,57,61,65,69,73,77,81,85,89,93,97,
          101,105,109,113,117,121,125,129,133,137,145,169,217,241,289,313,361,433:begin
            ADst^ := K;
            Inc(ADst);
            ADst^ := K;
            Inc(ADst);
            ADst^ := K;
            Inc(ADst);
          end;
          5:begin
            ADst^ := 0;
            Inc(ADst);
            ADst^ := 0;
            Inc(ADst);
            ADst^ := 0;
            Inc(ADst);
          end;
        end;
      end else begin
        case nWidth of
          10,14,18,22,26,30,34,38,42,46,50,54,58,62,66,70,74,78,82,86,90,94,98,
          102,106,110,114,118,122,126,130,134,142,406,478:begin
             ADst^ := K;
             Inc(ADst);
             ADst^ := K;
             Inc(ADst);
           end;
           6:begin
             ADst^ := 0;
             Inc(ADst);
             ADst^ := 0;
             Inc(ADst);
           end; 
        end;
      end;
      nCount:= 0;
    end;
  end;
  Result := True;
end;
//-----------------------------------------------------------------------------

end.

