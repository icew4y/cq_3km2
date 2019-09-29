unit wmutil;

interface

uses
  Windows, AbstractTextures;

type

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
     Surface      :TAsphyreLockableTexture;
     Alpha        :TAsphyreLockableTexture;
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
  
const
  Wis_Title = 'WISA?V�?';
function WidthBytes(w: Integer): Integer;

implementation

function WidthBytes(w: Integer): Integer;
begin
  Result := (((w * 8) + 31) div 32) * 4;
end;

end.
