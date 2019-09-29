unit fsShare;

interface

const
  QF_WilIndexData = 1987;
  RF_WilIndexData = 1029;

type
  TFSMessage = record
    Recog: Integer;//识别码
    Ident: Word;
    Param: Word;
    Tag: Word;
    Series: Word;
  end;
  pTFSMessage = ^TFSMessage;
  TImageData = packed record
    Width: smallint;
    Height: smallint;
    px: smallint;
    py: smallint;
    btDecode: Byte;//0没有 1Zlib
    btBitCount : Byte;
    nLen : Word;
    Data : array [0..0] of Byte;
  end;
  pTImageData = ^TImageData;
implementation

end.
