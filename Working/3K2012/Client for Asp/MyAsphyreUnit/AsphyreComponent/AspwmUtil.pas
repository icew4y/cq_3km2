unit Aspwmutil;

interface

uses
  Windows, AbstractTextures;

const
  ZlibTitle = 'www.shandagames.com';
  
type

//-----------------------Zlib----------------------

   TWMZlibIndexHeader = record
      Title: array[0..43] of Char;  //string[44];
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

   TWMImageHeader = record
      Title: String[40];        // 库文件标题 'WEMADE Entertainment inc.'
      ImageCount: integer;      // 图片数量
      ColorCount: integer;      // 色彩数量
      PaletteSize: integer;     // 调色板大小
      VerFlag:integer;
   end;
   PTWMImageHeader = ^TWMImageHeader;

   TWMImageInfo = record
     nWidth    :SmallInt;     // 位图宽度
     nHeight   :SmallInt;     // 位图高度
      px: smallint;
      py: smallint;
      bits: PByte;
   end;
   PTWMImageInfo = ^TWMImageInfo;

   TWMIndexHeader = record
      Title: string[40];        //'WEMADE Entertainment inc.'
      IndexCount: integer;      // 索引总数
      VerFlag:integer;
   end;

   PTWMIndexHeader = ^TWMIndexHeader;

   TWMIndexInfo = record
      Position: integer;
      Size: integer;
   end;
   PTWMIndexInfo = ^TWMIndexInfo;


   TDXImage = record
     nPx          :SmallInt;
     nPy          :SmallInt;
     LoadFailCount:DWord;
     Surface      :TAsphyreLockableTexture;
     dwLatestAlphaTime: LongWord;
     dwLatestTime :LongWord;
   end;
   pTDxImage = ^TDXImage;
//==============================Wis格式结构=====================================
  TWisHeader = packed record
    shTitle: array[0..11] of Char;//文件标识:WISA?V�?
    shComp: {DWord}Integer;  //DWord,Integer为4位
    shOffset: {DWord}Integer ;//位置
  end;

  TWisIndexInfo = packed record//Wis索引
    nPosition: Integer;//图片所在流中位置
    nSize: Integer;//图片数据块大小
    nUnknown: Integer;
  end;
  pTWisIndexInfo = ^TWisIndexInfo;
  TWisFileHeaderArray = array of TWisIndexInfo;
  
  TWisImageInfo = record
    nUnknown: Integer;//是否进行压缩处理 01 00 00 00,表示处理过，00 00 00 00,未处理过
    Width: smallint;//宽
    Height: smallint;//高
    px: smallint;//X
    py: smallint;//Y   
  end;

  TXY= array[0..65536] of Integer;
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
  
const
  Wis_Title = 'WISA?V�?';
function WidthBytes(w: Integer): Integer;

implementation

function WidthBytes(w: Integer): Integer;
begin
  Result := (((w * 8) + 31) div 32) * 4;
end;

end.
