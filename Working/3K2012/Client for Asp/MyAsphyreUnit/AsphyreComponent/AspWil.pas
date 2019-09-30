{------------------------------------------------------------------------------}
{ 单元名称: AspWil.pas                                                         }
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

unit AspWIL;

interface

uses
  Windows, Classes, Graphics, SysUtils, AsphyreDIB, AspwmUtil,
  AbstractTextures, AsphyreTypes, AsphyreConv, AsphyreFactory,AsphyreBmp, AsphyreBmpLoad,
  AspHUtil32, AspMapFiles, uGameTexture, uMyDxUnit,ZLib;
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
  TSourceFileType =(sftWis,sftWil,sftWzl);

   TDxImageArr   = array[0..MaxListSize div 4] of TDxImage;
   PTDxImageArr  = ^TDxImageArr;
{------------------------------------------------------------------------------}
// TWilFile class
{------------------------------------------------------------------------------}
   TAspWmImages = class (TComponent)
   private
      FFileName: String;              //0x24  // WIL 文件名
      FFileType:TSourceFileType;
      FImageCount: integer;           //0x28  // 图片数量
      FLibType: TLibType;             //0x2C  //图象装载方式
      FOffSet:Integer;
      FType:Integer; //文件类型  3为Zlib文件
      {FDxDraw: TDxDraw;               //0x30
      FDDraw: TDirectDraw;            //0x34 }
      //FMaxMemorySize: integer;        //0x38
      btVersion:Byte;                 //0x3C
      btWisFile: Boolean;//是否为wis文件
      m_bt458    :Byte;
      FAppr:Word;
      m_ImgArr    :pTDxImageArr;     //0x48
      FColorCount:Integer;
      FBitCount: byte;
      FBitFormat:TPixelFormat; //20090915
      FBytesPerPixels:byte; //20090915
      UseIndexList: TList; //释放内存用
      procedure LoadIndexWil (idxfile: string);
      procedure LoadIndexWzl (idxfile: string);
      function  LoadWisIndex (filename: string): Boolean;//读取wis索引数据
      procedure LoadDxImage (position, nSize: integer; pdximg: PTDxImage);
      procedure FreeOldMemorys;
      function  FGetImageSurface (index: integer): TAsphyreLockableTexture;
      function DecodeWis(ASrc, ADst: PByte; ASrcSize, ADstSize: Integer): Boolean;//WIS算法(压缩解法) 20100803
      function Wis_RLE8_Decode(ASrc, ADst: PByte; ASrcSize,nWidth: Integer): Boolean;//未压缩数据使用
      function Wis_RLE8_Decode1(ASrc, ADst: PByte; ASrcSize, ADstSize, nWidth, nHeight: Integer): Boolean;//Wis图片数据还原(压缩数据使用)
   protected
      FX,FY:TXY;
      lsDib: TDib;              //0x40
      FSrcMemory,FDstMemory:TMemoryStream;
      m_dwMemChecktTick: LongWord;   //0x44
      m_dwAlphaMemChecktTick: LongWord;
      FInitialized : Boolean;
      function  GetImage (index: integer; var px, py: integer): TAsphyreLockableTexture;
   public

      m_IndexList :TList;         //0x50
      m_AlphaIndexList: TList;
      m_FileStream: TFileStream;      //0x54


      NewHeaderofIndex: TNewWixHeader;
      headerofIndex: TWMIndexHeader;
      ZlibHeaderofIndex: TWMZlibIndexHeader; //Zlib
      IndexList: Array of Integer;
      
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Initialize;
      procedure Finalize;
      procedure ClearCache;
      procedure LoadPalette;
      procedure LoadWisPalette;//由于Wis没有256色的调色板，需要自行创建调色板

      function  GetCachedImage (index: integer; var px, py: integer): TAsphyreLockableTexture;
      function  GetCachedSurface (index: integer): TAsphyreLockableTexture;
      property Images[index: integer]: TAsphyreLockableTexture read FGetImageSurface;
      //property DDraw: TDirectDraw read FDDraw write FDDraw;
   published
      property FileName: string read FFileName write FFileName;
      property ImageCount: integer read FImageCount;
      //property DxDraw: TDxDraw read FDxDraw write FSetDxDraw;
      property LibType: TLibType read FLibType write FLibType;
      //property MaxMemorySize: integer read FMaxMemorySize write FMaxMemorySize;
      property Appr:Word read FAppr write FAppr;
      property BitCount: byte read FBitCount write FBitCount;
   end;
var
  g_WilList                 :TList;
   procedure ChangeDIBPixelFormat(adib:TDIB;pf:TPixelFormat); overload;
   procedure ChangeDIBPixelFormat(adib:TDIB;pf:TPixelFormat;BitMap:TBitMap); overload;
procedure Register;

implementation
var
  MainPalette: TRgbQuads;

procedure Register;
begin
   RegisterComponents('AspMirGame', [TAspWmImages]);
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

constructor TAspWmImages.Create (AOwner: TComponent);
begin
  inherited Create (AOwner);
  g_WilList.Add(Self);

  FFileName := '';
  FLibType := ltLoadBmp;
  FImageCount := 0;
  //FMaxMemorySize := 1024*1000; //1M
  FBitCount := 8;
  
  {FDDraw := nil;
  FDxDraw := nil; }
  m_FileStream := nil;
  m_ImgArr := nil;
  m_IndexList := TList.Create;
  m_AlphaIndexList := TList.Create;
  UseIndexList := TList.Create; //释放内存用
  lsDib := TDib.Create;
  lsDib.BitCount := 8;

  m_dwMemChecktTick := GetTickCount;
  btVersion:=0;
  m_bt458:=0;
  btWisFile:= False;//是否为wis文件

  FSrcMemory:=TMemoryStream.Create;
  FDstMemory:=TMemoryStream.Create;
end;

destructor TAspWmImages.Destroy;
begin
  g_WilList.Remove(Self);
  m_IndexList.Free;
  m_AlphaIndexList.Free;
  UseIndexList.Free;
  if m_FileStream <> nil then FreeAndNil(m_FileStream);
  lsDib.Free;

  FSrcMemory.Free;
  FDstMemory.Free;
  inherited Destroy;
end;

procedure TAspWmImages.Initialize;
var
  Idxfile: String;
  Header :TWMImageHeader;
  WisHeader: TWisHeader;
  ZlibHeader: TWMZlibImageHeader;  //Zlib
  ExtName,NewFileName:string;
begin
  if (not (csDesigning in ComponentState)) and (not FInitialized )then begin
    FInitialized := True;
    if FFileName = '' then Exit;

    //if (LibType <> ltLoadBmp){ and (FDDraw = nil)} then Exit;
    ExtName:=ExtractFileExt(FFileName);
    NewFileName:=Copy(FFileName,1,Length(FFileName)-Length(ExtName));
    if m_FileStream <> nil then
    try
      FreeAndNil(m_FileStream);
    except
      m_FileStream := nil;
    end;

    if FileExists(NewFileName +'.wil') then begin
      FFileType:=sftWil;
      FFileName:=NewFileName+'.wil';
    end else begin
      FFileType:=sftWis;
      FFileName:=NewFileName+'.wis';
    end;
    if FileExists(FFileName) then
      m_FileStream := TFileStream.Create (FFileName, fmOpenRead or fmShareDenyNone);
    if m_FileStream <> nil then
    begin
      m_FileStream.Read (WisHeader, SizeOf(TWisHeader));
      if AnsiCompareStr(WisHeader.shTitle, Wis_Title) = 0 then begin//检查文件头是否为wis文件格式
        if not LoadWisIndex(ExtractFileName(FFileName)) then Exit; //加载头文件信息
        btWisFile:= True;//是否为wis文件
        if m_ImgArr <> nil then
          FreeMem(m_ImgArr);
        m_ImgArr:= AllocMem(SizeOf(TDxImage) * FImageCount);
        if (m_ImgArr = nil) and (FImageCount > 0) then //修改空文件报异常 By TasNat at: 2012-03-28 15:14:33
          Exit;//raise Exception.Create (self.Name + ' ImgArr = nil');
        LoadWisPalette;//创建Wis256色调色板
      end else
      begin
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
         if m_ImgArr <> nil then
          FreeMem(m_ImgArr);
          m_ImgArr:=AllocMem(SizeOf(TDxImage) * FImageCount);
          if (m_ImgArr = nil) and (FImageCount > 0) then //修改空文件报异常 By TasNat at: 2012-03-28 15:14:33
            Exit;//   raise Exception.Create (self.Name + ' ImgArr = nil');

        //索引文件
        idxfile := ExtractFilePath(FFileName) + ExtractFileNameOnly(FFileName) + '.WIX';
        LoadPalette;
        LoadIndexWil (idxfile);
      end;
    end else if FileExists(NewFileName+'.wzl') then
    begin
      FFileType:=sftWzl;
      FFileName:=NewFileName+'.wzl';
      if m_FileStream = nil then m_FileStream := TFileStream.Create (FFileName, fmOpenRead or fmShareDenyNone);
      m_FileStream.Read (ZlibHeader, SizeOf(TWMZlibImageHeader));
      //if ZlibHeader.Title<>ZlibTitle then Exit; //检查文件头是否为wzl文件格式

      FImageCount := ZlibHeader.ImageCount;
      if (FImageCount > 0) and (FImageCount < 655360) then begin
        if m_ImgArr <> nil then
          FreeMem(m_ImgArr);
                                                           
        m_ImgArr:=AllocMem(SizeOf(TDxImage) * FImageCount);
        if (m_ImgArr = nil) and (FImageCount > 0) then //修改空文件报异常 By TasNat at: 2012-03-28 15:14:33
           Exit;//raise Exception.Create (self.Name + ' ImgArr = nil');
      end;

      //索引文件
      idxfile := ExtractFilePath(FFileName) + ExtractFileNameOnly(FFileName) + '.WZX';

        LoadIndexWzl (idxfile);

    end else
    begin
      Exit;
    end;
  end;
end;

procedure TAspWmImages.Finalize;
var
  i: integer;
begin
  if not FInitialized then Exit;

  //释放装载的所有图片
  if m_ImgArr <> nil then begin//20080629
    for i:=0 to FImageCount-1 do begin
      if m_ImgArr[i].Surface <> nil then begin
        FreeAndNil(m_ImgArr[i].Surface);
      end;
    end;
    FreeMem(m_ImgArr);//修正可以调用多次 Finalize By TasNat at: 2012-03-10 23:28:23
    m_ImgArr := nil;
  end;
  if m_FileStream <> nil then FreeAndNil(m_FileStream);

  UseIndexList.Clear;
  FInitialized := False;
end;

//从WIL文件中装载调色板
procedure TAspWmImages.LoadPalette;
begin
   if btVersion <> 0 then
     m_FileStream.Seek (sizeof(TWMImageHeader) - 4, 0)
   else m_FileStream.Seek (sizeof(TWMImageHeader), 0);

   m_FileStream.Read (MainPalette, sizeof(TRgbQuad) * 256); //
   //Move(MainPalette,g_DefColorTable,SizeOf(g_DefColorTable));
   //m_FileStream.Read (g_DefColorTable, sizeof(TRgbQuad) * 256); //
end;

procedure TAspWmImages.LoadIndexWil (idxfile: string);
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

procedure TAspWmImages.LoadIndexWzl (idxfile: string);
var
  fhandle, i, value: integer;
  header: TWMZlibIndexHeader;
  pvalue: PInteger;
begin
  m_IndexList.Clear;
  if FileExists (idxfile) then begin
    fhandle := FileOpen (idxfile, fmOpenRead or fmShareDenyNone);
    if fhandle > 0 then begin
      FileRead (fhandle, header, sizeof(TWMZlibIndexHeader));
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

{----------------- Private Variables ---------------------}

function  TAspWmImages.FGetImageSurface (index: integer): TAsphyreLockableTexture;
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



var
  lDIB8 : TDIB;
  lDIB16 : TDIB;

procedure TAspWmImages.LoadDxImage (position, nSize: integer; pdximg: PTDxImage);
  procedure NewWilTexture(ASrc: PByte; AWidth, AHeight: Integer; ASrcBit: Byte; pdximg: PTDxImage; ADib: TDib);
  var
    FileData: Pointer;
    FileSize: Integer;
    Pitch, X, nY, Y,K: Integer;
    Bits: Pointer;
    PBits: PByte;
    PDest: PCardinal;
    PSrc16: pWord;
    PDes16: pWord;
    RGB: TRGBQuad;
    Pix: Cardinal;
    M : TMemoryStream;
    function LoadFromStream: TAsphyreLockableTexture;
    var
      Image: TBitmapEx;
      Bits: Pointer;
      Pitch: Integer;
      Index: Integer;
      WritePx: Pointer;
      X, Y: Integer;
      Pix: Cardinal;
      RGBQuad: TRGBQuad;
      ScrP: PCardinal;
      Stream: TMemoryStream;
    begin
      Result := Factory.CreateLockableTexture;
      if Result <> nil then begin
        //Stream:= TMemoryStream.Create;
        //ADib.SaveToStream(Stream);
        //Stream.Position := 0;
        Image := TBitmapEx.Create();
        //Image.Assign(ADib);
        Image.SetSize(ADib.Width, ADib.Height);
        Image.Canvas.Draw(0,0,ADib);
        //Image.LoadFromStream(Stream);
        //Stream.Free;
        Image.PixelFormat := pf32bit;
        Result.MipMapping := False;
        Result.SetSize(Image.Width, Image.Height, False);

        if not Result.Initialize then begin
          Image.Free();
          Result.Free;
          Result := nil;
          Exit;
        end;

        Result.Lock(Bits, Pitch);
        if (Bits = nil) or (Pitch < 1) then
        begin
          Image.Free();
          Result.Free;
          Result := nil;
          Exit;
        end;

        WritePx := Bits;

        for Y := 0 to Image.Height - 1 do begin
          ScrP := Image.ScanLine[Y];
          for X := 0 to Image.Width - 1 do begin
            Pix := PCardinal(Integer(ScrP) + X * 4)^;
            if Pix > 0 then
              Pix := Pix or $FF000000;
            PCardinal(Integer(WritePx) + Y * Pitch + X * 4)^ := Pix;
          end;
        end;

        Result.Unlock();
        Image.Free();

      end;
    end;
  begin            
    if pdximg.Surface <> nil then begin
        try
          pdximg.Surface.Free;
          pdximg.Surface := nil;
        except
        end;
    end;

    {M := TMemoryStream.Create;
    try
      ADib.SaveToStream(M);
      pdximg.Surface := NewTexture(M.Memory, M.Size, ADib.Width, ADib.Height);
      if pdximg.Surface = nil then
        Inc(pdximg.LoadFailCount)
      else
        pdximg.LoadFailCount := 0;
    finally
      M.Free;
    end;

    Exit;}

    //pdximg.Surface := LoadFromStream;
    //if pdximg.Surface <> nil then Exit;
    
    //pdximg.Surface := Factory.CreateLockableTexture;
    {if pdximg.Surface <> nil then begin
      if g_GameDevice.PixelFormat = apf_A1R5G5B5 then
        pdximg.Surface.Format := apf_A1R5G5B5
      else
        if g_GameDevice.PixelFormat = apf_X1R5G5B5 then
        pdximg.Surface.Format := apf_A1R5G5B5
      else
        if g_GameDevice.PixelFormat = apf_R5G6B5 then
        pdximg.Surface.Format := apf_A1R5G5B5 //apf_R5G6B5
      else
        if g_GameDevice.PixelFormat = apf_A8R8G8B8 then
        pdximg.Surface.Format := apf_A8R8G8B8
      else
        if g_GameDevice.PixelFormat = apf_X8R8G8B8 then
        pdximg.Surface.Format := apf_A8R8G8B8
      else
        pdximg.Surface.Format := apf_Unknown; //apf_A8R8G8B8;
      pdximg.Surface.Mipmapping := False;
      pdximg.Surface.SetSize(AWidth, AHeight, False);
      M := TMemoryStream.Create;
      try
        ADib.SaveToStream(M);
        LoadFromStream();
        //ADib.SaveToFile('C:\1.bmp');
        //if pdximg.Surface.LoadFromFile('C:\1.bmp') then Exit;
        //if pdximg.Surface.LoadFromData(M.Memory, M.Size, ADib.BitCount) then Exit;
      finally
        M.Free;
      end;
      Exit;
    end; }
    if ASrcBit = 8 then begin
      {if g_GameDevice.PixelFormat in [apf_A1R5G5B5, apf_X1R5G5B5, apf_R5G6B5] then begin
        NewBitmapFile(AWidth, AHeight, 16, FileData, FileSize, g_GameDevice.PixelFormat = apf_R5G6B5);
        Bits := Pointer(Integer(FileData) + SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader));
        Pitch := AWidth * 2;

        nY := 0;
        for Y := AHeight - 1 downto 0 do
        begin
          PBits := PByte(Integer(ASrc) + Y * ADib.WidthBytes);
          PDest := PCardinal(Integer(Bits) + nY * Pitch);
          for X := 0 to AWidth - 1 do begin
            RGB := g_DefColorTable[PBits^]; //
            if Integer(RGB) = 0 then begin
              PWord(PDest)^ :=0; //$00;
            end else begin
              //PWord(PDest)^ :=Word((_MAX(RGB.rgbRed and $F8, 8) shl 8) or (_MAX(RGB.rgbGreen and $FC, 8) shl 3) or (_MAX(RGB.rgbBlue and $F8, 8) shr 3))
              //PByte(PDest)^ :=PBits^; //Byte((RGB.rgbRed ) or (RGB.rgbGreen ) or (RGB.rgbBlue ));
              PWord(PDest)^ :=Word((RGB.rgbRed and $F8 shl 7) or (RGB.rgbGreen and $F8 shl 2) or (RGB.rgbBlue and $F8 shr 3));
            end;
            Inc(PBits);
            Inc(PWord(PDest));
          end;
          Inc(nY);
        end;
      end else begin }
        M := TMemoryStream.Create;
    try
      ADib.SaveToStream(M);
      pdximg.Surface := NewTexture(M.Memory, M.Size, ADib.Width, ADib.Height);
      if pdximg.Surface = nil then
        Inc(pdximg.LoadFailCount)
      else
        pdximg.LoadFailCount := 0;
    finally
      M.Free;
    end;
        {NewBitmapFile(AWidth, AHeight, 32, FileData, FileSize);
        Bits := Pointer(Integer(FileData) + SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader));
        Pitch := AWidth * 4;

        nY := 0;
        for Y := AHeight - 1 downto 0 do begin
          PBits := PByte(Integer(ASrc) + Y * ADib.WidthBytes);
          PDest := PCardinal(Integer(Bits) + nY * Pitch);
          for X := 0 to AWidth - 1 do begin
            RGB := g_DefColorTable[PBits^];
            Pix := Cardinal(RGB);
            if Pix > 0 then begin
              Pix := Pix or $FF000000;
              //end else begin
                //Pix := $000000FF;
            end;
            PDest^ := Pix;
            Inc(PBits);
            Inc(PDest);
          end;
          Inc(nY);
        end;
      end;
      pdximg.Surface := NewTexture(FileData, FileSize, AWidth, AHeight);
      FreeMem(FileData);
      }
    end else begin//ASrcBit <> 8
      (*if g_GameDevice.PixelFormat in [apf_A1R5G5B5, apf_X1R5G5B5, apf_R5G6B5] then
      begin
        {M := TMemoryStream.Create;
        ADib.SaveToStream(M);
        FileSize := M.Size;
        M.Position := 0;
        GetMem(FileData, FileSize);
        M.Read(FileData^, FileSize);
        M.Free;}
        NewBitmapFile(AWidth, AHeight, 16, FileData, FileSize, g_GameDevice.PixelFormat = apf_R5G6B5);
        Bits := Pointer(Integer(FileData) + SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader));
        Pitch := AWidth * 2;
        nY := 0;
        for Y := AHeight - 1 downto 0 do begin
          PBits := PByte(Integer(Bits) + nY * Pitch);
          {    //16转32 MMX优化
          Pixel16to32Array(PByte(Integer(ASrc) + Y * ADib.WidthBytes), PBits, AWidth);

          PDest := PCardinal(PBits);
          for X := 0 to AWidth - 1 do begin
            if PCardinal(PDest)^ > 0 then
              PCardinal(PDest)^ := PCardinal(PDest)^ or $FF000000;
            Inc(PDest);
          end;
          }
          PDes16 := PWord(PBits);
          //PSrc16 := PWord(ADib.ScanLine[Y]);
          PSrc16 := PWord(Integer(ASrc) + Y * ADib.WidthBytes);
          for X := 0 to AWidth - 1 do begin
            RGB.rgbRed := PSrc16^ and $F800 shr 8;
            RGB.rgbGreen := PSrc16^ and $07E0 shr 3;
            RGB.rgbBlue := PSrc16^ and $001F shl 3;
            RGB.rgbReserved := 0;
            //PWord(PDest)^ := Word((_Max(RGB.rgbRed and $F8, 8) shl 7) or (_Max(RGB.rgbGreen and $F8, 8) shl 2) or (_Max(RGB.rgbBlue and $F8, 8) shr 3)); //555格式

            if Cardinal(RGB) > 0 then
              PWord(PDes16)^ := Word((_Max(RGB.rgbRed and $F8, 8) shl 7) or (_Max(RGB.rgbGreen and $F8, 8) shl 2) or (_Max(RGB.rgbBlue and $F8, 8) shr 3)) //555格式
            else
              PWord(PDes16)^ := 0;
            //PCardinal(PDest)^ := Cardinal(RGB);
            Inc(PDes16);
            Inc(PSrc16);
          end;
          Inc(nY);
        end;
        {for Y := 0 to AHeight - 1 do begin
          PBits := PByte(Integer(Bits) + Y * Pitch);
          //ASrc := PByte(ADib.ScanLine[Y]);
          ASrc := PByte(Integer(ADib.PBits) + Y * ADib.WidthBytes);
          PDest := PCardinal(PBits);
          for X := 0 to AWidth - 1 do begin
            if PWord(ASrc)^ <> 0 then begin
              RGB.rgbRed := PWord(ASrc)^ and $F800 shr 8;
              RGB.rgbGreen := PWord(ASrc)^ and $07E0 shr 3;
              RGB.rgbBlue := PWord(ASrc)^ and $001F shl 3;
              PWord(PDest)^ := Word((_Max(RGB.rgbRed and $F8, 8) shl 7) or (_Max(RGB.rgbGreen and $F8, 8) shl 2) or (_Max(RGB.rgbBlue and $F8, 8) shr 3)); //555格式
            end else begin
              PWord(PDest)^ := 0;
            end;
            Inc(PWord(PDest));
            Inc(PWord(ASrc));
          end;
        end;}
      end else *)begin
        NewBitmapFile(AWidth, AHeight, 32, FileData, FileSize);
        Bits := Pointer(Integer(FileData) + SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader));
        Pitch := AWidth * 4;

        nY := 0;
        for Y := AHeight - 1 downto 0 do begin
          PDest := PCardinal(Integer(Bits) + nY * Pitch);
          PSrc16 := PWord(Integer(ASrc) + Y * ADib.WidthBytes);
          for X := 0 to AWidth - 1 do begin
            RGB.rgbRed := PSrc16^ and $F800 shr 8;
            RGB.rgbGreen := PSrc16^ and $07E0 shr 3;
            RGB.rgbBlue := PSrc16^ and $001F shl 3;
            RGB.rgbReserved := 0;
            //PWord(PDest)^ := Word((_Max(RGB.rgbRed and $F8, 8) shl 7) or (_Max(RGB.rgbGreen and $F8, 8) shl 2) or (_Max(RGB.rgbBlue and $F8, 8) shr 3)); //555格式

            if Cardinal(RGB) > 0 then
              RGB.rgbReserved := $FF;

            PCardinal(PDest)^ := Cardinal(RGB);
            Inc(PDest);
            Inc(PSrc16);
          end;
          Inc(nY);
        end;    
      end;
      pdximg.Surface := NewTexture(FileData, FileSize, AWidth, AHeight);
      if pdximg.Surface = nil then
        Inc(pdximg.LoadFailCount)
      else
        pdximg.LoadFailCount := 0;
    end;  
  end;

var
  imginfo:TWMImageInfo;
  SBits, PSrc, DBits: PByte;
  WisImgInfo: TWisImageInfo;
  nPitch: Integer;
  nWidth, nHeight: Integer;
  SrcP, DestP: Pointer;
  wDestP1, wDestP2, wDestP3, wDestP4: PWord;
  wSrcP1, wSrcP2, wSrcP3, wSrcP4: PWord;
  I, j: Integer;
  btSrcP1, btSrcP2, btSrcP3, btSrcP4: PByte;
  tmpcolor: TRGBQuad;
    FileData: Pointer;
    FileSize: Integer;
  S, D: Pointer;
  RGB: TRGBQuad;
  Pitch, X, nY, Y: Integer;
  PDest: PCardinal;
  Bits: Pointer;

  PBits: PByte;
  Pix: Cardinal;
  DesP: PByte;

  //DeskHWnd:HWND;

  ZlibImgInfo: TWMZlibImageInfo;
  tmpBitCount: Integer;

  procedure DecompressionMemoryStream(S : TStream; DIB : TDIB);
  var
    FZRec: TZStreamRec;
    tmpDeStream: TDecompressionStream;
    Mems : TMemoryStream;
  begin
    if ZlibImgInfo.DecodeSize>0 then
    begin
      try
        Mems := TMemoryStream.Create;
        Mems.CopyFrom(S, ZlibImgInfo.DecodeSize);
        Mems.Position := 0;
        tmpDeStream := TDecompressionStream.Create(Mems);
      except
        tmpDeStream.Free;
        Exit;
      end;
      tmpDeStream.Read(DIB.PBits^, DIB.Size);
      //减少内存拷贝 By TasNat at: 2012-03-12 13:43:54
      Mems.Free;
      tmpDeStream.Free;
    end else
    begin
      S.Read(DIB.PBits^, DIB.Size);
    end;
  end;

 const
  g_boD3DFormat = True;
begin
  //太没效率了和谐之 By TasNat at: 2012-03-12 12:31:45
  if not btWisFile then begin//不是Wis文件
    if FFileType=sftWzl then
    begin
      m_FileStream.Seek (position, 0);
      m_FileStream.Read (ZlibImgInfo, sizeof(TWMZlibImageInfo));
      if (ZlibImgInfo.Width > 2000) or (ZlibImgInfo.Height > 2000) or
         (ZlibImgInfo.Width <1) or (ZlibImgInfo.Height <1) then Exit;

      if ZlibImgInfo.wColor = $103 then begin
        tmpBitCount:=8;
      end else if ZlibImgInfo.wColor = $105 then begin
        tmpBitCount:=16;
      end else begin
      end;

      pdximg.nPx := ZlibImgInfo.px;
      pdximg.nPy := ZlibImgInfo.py;
      nHeight := ZlibImgInfo.Height;
      nWidth := ZlibImgInfo.Width;
      case tmpBitCount of
        8: begin
            if lDIB8 = nil then begin
              lDIB8 := TDIB.Create;
              Move(MainPalette, lDIB8.ColorTable, SizeOf(MainPalette));
              lDIB8.UpdatePalette;
            end;
            //lDIB8.LoadFromFile('C:\156129.bmp');
            lDIB8.SetSize(nWidth, nHeight, 8);
            //lDIB8.Canvas.Brush.Color := clBlack;
            //lDIB8.Canvas.FillRect(lDIB8.Canvas.ClipRect);
            DecompressionMemoryStream(m_FileStream, lDIB8);
            SrcP := lDIB8.PBits;
            NewWilTexture(SrcP, nWidth, nHeight, 8, pdximg, lDIB8);

          end;
        16: begin
            if lDIB16 = nil then begin
              lDIB16 := TDIB.Create;
              lDIB16.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
            end;
            lDIB16.SetSize(nWidth, nHeight, 16);
            //lDIB16.Canvas.Brush.Color := clBlack;
            //lDIB16.Canvas.FillRect(lDIB16.Canvas.ClipRect);
            DecompressionMemoryStream(m_FileStream, lDIB16);
            //lDIB16.SaveToFile('C:\' + IntTostr(position) +'.bmp');
            SrcP := lDIB16.PBits;
            NewWilTexture(SrcP, nWidth, nHeight, 16, pdximg, lDIB16);
          end;
      end;

    end else begin // 是wil 文件
      m_FileStream.Seek (position, 0);
      if btVersion <> 0 then m_FileStream.Read (imginfo, SizeOf(TWMImageInfo)-4)
      else m_FileStream.Read (imginfo, SizeOf(TWMImageInfo));
      if (imginfo.nWidth > 2000) or (imginfo.nHeight > 2000) or
      (imginfo.nWidth <1) or (imginfo.nHeight <1) then Exit;//大小检测 By TasNat at: 2012-03-12 14:47:35

      pdximg.nPx := ImgInfo.px;
      pdximg.nPy := ImgInfo.py;
      nHeight := ImgInfo.nHeight;
      nWidth := ImgInfo.nWidth;

      case BitCount of
        8: begin
            if lDIB8 = nil then begin
              lDIB8 := TDIB.Create;
              Move(MainPalette, lDIB8.ColorTable, SizeOf(MainPalette));
              lDIB8.UpdatePalette;
            end;
            lDIB8.SetSize(ImgInfo.nWidth, nHeight, 8);
            //lDIB8.Canvas.Brush.Color := clBlack;
            //lDIB8.Canvas.FillRect(lDIB8.Canvas.ClipRect);
            SrcP := lDIB8.PBits;
            m_FileStream.Read(SrcP^, lDIB8.Size);
            //lDIB8.SaveToFile('C:\8.bmp');
            NewWilTexture(SrcP, nWidth, nHeight, 8, pdximg, lDIB8);
          end;
        16: begin
            if lDIB16 = nil then begin
              lDIB16 := TDIB.Create;
              lDIB16.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
            end;
            lDIB16.SetSize(ImgInfo.nWidth, nHeight, 16);
            //lDIB16.Canvas.Brush.Color := clBlack;
            //lDIB16.Canvas.FillRect(lDIB16.Canvas.ClipRect);
            SrcP := lDIB16.PBits;
            m_FileStream.Read(SrcP^, lDIB16.Size);
            //lDIB16.SaveToFile('C:\16.bmp');
            NewWilTexture(SrcP, nWidth, nHeight, 16, pdximg, lDIB16);
          end;
      end;
    end;

  end else begin//Wis文件
    if position <= 0 then Exit;//20090905 增加，指针为0则退出
    m_FileStream.Seek (Position, 0);
    m_FileStream.Read (WisImgInfo, SizeOf(TWisImageInfo));
    if (WisImgInfo.Width > 2000) or (WisImgInfo.Height > 2000) or
    (WisImgInfo.Width <1) or (WisImgInfo.Height <1) then Exit;//大小检测 By TasNat at: 2012-03-12 14:47:35
    pdximg.nPx := WisImgInfo.px;
    pdximg.nPy := WisImgInfo.py;
    nWidth := WidthBytes(WisImgInfo.Width);
    nHeight := WisImgInfo.Height;
    case WisImgInfo.nUnknown of
      0:begin//8位 未压缩的图片数据
        if lDIB8 = nil then begin
          lDIB8 := TDIB.Create;
          Move(MainPalette, lDIB8.ColorTable, SizeOf(MainPalette));
          lDIB8.UpdatePalette;
        end;
        lDIB8.SetSize(nWidth, nHeight, 8);
        //lDIB8.Canvas.Brush.Color := clBlack;
        //lDIB8.Canvas.FillRect(lDIB8.Canvas.ClipRect);
        DBits := lDIB8.PBits;
        for I := 0 to nHeight - 1 do begin
          SBits := PByte(Integer(DBits) + (nHeight - 1 - I) * lDIB8.WidthBytes);
          m_FileStream.Read(SBits^, WisImgInfo.Width);
        end;
        NewWilTexture(DBits, nWidth, nHeight, 8, pdximg, lDIB8);
      end;
      1: begin //8压缩
        if lDIB8 = nil then begin
          lDIB8 := TDIB.Create;
          Move(MainPalette, lDIB8.ColorTable, SizeOf(MainPalette));
          lDIB8.UpdatePalette;
        end;
        lDIB8.SetSize(nWidth, nHeight, 8);
        //lDIB8.Canvas.Brush.Color := clBlack;
        //lDIB8.Canvas.FillRect(lDIB8.Canvas.ClipRect);

        DBits := lDIB8.PBits;
        GetMem(S, nSize);
        GetMem(D, WisImgInfo.Width * WisImgInfo.Height);
        try
          SBits := S;
          DBits := D;
          m_FileStream.Read(SBits^, nSize);
          DecodeWis(SBits, DBits, nSize, WisImgInfo.Width * WisImgInfo.Height);
          for I := 0 to lDIB8.Height - 1 do begin
            SBits := PByte(Integer(D) + I * WisImgInfo.Width);
            DBits := PByte(Integer(lDIB8.PBits) + (lDIB8.Height - 1 - I) * lDIB8.WidthBytes);
            Move(SBits^, DBits^, lDIB8.Width);
          end;
        finally
          FreeMem(S);
          FreeMem(D);
        end;
        NewWilTexture(DBits, nWidth, nHeight, 8, pdximg, lDIB8);
      end;
      2: begin//16位图不压缩
        if lDIB16 = nil then begin
          lDIB16 := TDIB.Create;
          lDIB16.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
        end;
        lDIB16.SetSize(nWidth, nHeight, 16);
        //lDIB16.Canvas.Brush.Color := clBlack;
        //lDIB16.Canvas.FillRect(lDIB16.Canvas.ClipRect);
        DBits := lDIB16.PBits;
        for I := 0 to nHeight - 1 do begin
          SBits := PByte(Integer(DBits) + (nHeight - 1 - I) * lDIB16.WidthBytes);
          m_FileStream.Read(SBits^, WisImgInfo.Width * 2);
        end;
        NewWilTexture(DBits, nWidth, nHeight, 16, pdximg, lDIB16);
      end;
      3: begin//16位压缩

      end;
    end;//case
  end;
end;


procedure TAspWmImages.ClearCache;
var
  i: integer;
begin
  for i:=0 to ImageCount - 1 do begin
    if m_ImgArr[i].Surface <> nil then begin
       FreeAndNil(m_ImgArr[i].Surface);
    end;
  end;
  UseIndexList.Clear;
  //MemorySize := 0;
end;

function  TAspWmImages.GetImage (index: integer; var px, py: integer): TAsphyreLockableTexture;
begin
  if (m_ImgArr <> nil) and (index >= 0) and (index < ImageCount) then begin
    px := m_ImgArr[index].nPx;
    py := m_ImgArr[index].nPy;
    Result := m_ImgArr[index].surface;
  end else Result := nil;
end;



procedure TAspWmImages.FreeOldMemorys;
var
  i, dwTimeTick: integer;
  pTexture : ^TAsphyreLockableTexture;
begin
  dwTimeTick := GetTickCount;
  if m_ImgArr <> nil then
  for i:=0 to ImageCount-1 do begin
    pTexture := @m_ImgArr[i].Surface;
    if GetTickCount - dwTimeTick > 200 then Break;//防止释放内存卡死By TasNat at: 2012-10-15 13:36:54
    if pTexture^ <> nil then begin
      if dwTimeTick - m_ImgArr[i].dwLatestTime > 3 * 60 * 1000 then begin
        try
          pTexture.Free;
        except
        end;
        pTexture^ := nil;
        //FreeAndNil(m_ImgArr[i].Surface); //20081719修改
      end;
    end;
  end;
end;


var
 lLastIndex : Integer;
 lLastFile : TAspWmImages;
function  TAspWmImages.GetCachedSurface (index: integer): TAsphyreLockableTexture;
var
  nPosition, nSize:Integer;
begin
  Result := nil;
  try
    if (m_ImgArr = nil) and (ImageCount < 1) then//重新初始化
      Initialize;

    if (m_ImgArr = nil) or (index < 0) or (index >= ImageCount) then exit;
    if GetTickCount - m_dwMemChecktTick > 1 * 60 * 1000 then  begin//一分钟检测一次
      m_dwMemChecktTick := GetTickCount;
      //if MemorySize > FMaxMemorySize then begin
      FreeOldMemorys();
      //end;
    end;
    //或许会有读取失败 By TasNat at: 2012-07-02 11:45:46
    if m_ImgArr[index].LoadFailCount > 3 then Exit;  
    if (m_ImgArr[index].Surface = nil) or
    (not m_ImgArr[index].Surface.Active)//增加点检测吧没别的办法了 By TasNat at: 2012-03-10 20:01:48
    then begin
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
    if (lLastIndex <> index) and (Self <> lLastFile) then begin
      lLastIndex := index;
      lLastFile := Self;
    end;
  end;
end;

function  TAspWmImages.GetCachedImage (index: integer; var px, py: integer): TAsphyreLockableTexture;
var
  position, nSize: integer;
begin
  Result := nil;
  try
    if (m_ImgArr = nil) and (ImageCount < 1) then
      Initialize;

    if (m_ImgArr = nil) or (index < 0) or (index >= ImageCount) then Exit;
    //此处多为Hum调用为什么不释放内存呢
    if GetTickCount - m_dwMemChecktTick > 10000 then  begin
      m_dwMemChecktTick := GetTickCount;
      //if MemorySize > FMaxMemorySize then begin
      FreeOldMemorys();
      //end;
    end;
    if (m_ImgArr[index].Surface = nil) or
    (not m_ImgArr[index].Surface.Active) //增加点检测吧没别的办法了 By TasNat at: 2012-03-10 20:01:48
    then begin //cache
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


//------------------------------------------------------------------------------
function ListSortMax(iP1, iP2: Pointer):Integer;//降序
begin
  if pTWisIndexInfo(iP1)^.nUnknown > pTWisIndexInfo(iP2)^.nUnknown then Result := -1
  else if pTWisIndexInfo(iP1)^.nUnknown = pTWisIndexInfo(iP2)^.nUnknown then Result := 0
  else Result := 1;
end;
//读取wis文件图片索引
function TAspWmImages.LoadWisIndex (filename: string): Boolean;
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
procedure TAspWmImages.LoadWisPalette;
begin
  Move(ColorArray, MainPalette, SizeOf(ColorArray));//传递调色板数据
end;

//WIS算法(压缩解法) 20100803
function TAspWmImages.DecodeWis(ASrc, ADst: PByte; ASrcSize, ADstSize: Integer): Boolean;
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
function TAspWmImages.Wis_RLE8_Decode1(ASrc, ADst: PByte; ASrcSize, ADstSize, nWidth, nHeight: Integer): Boolean;
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
function TAspWmImages.Wis_RLE8_Decode(ASrc, ADst: PByte; ASrcSize,nWidth: Integer): Boolean;
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

