unit Share;

interface

uses SysUtils, Gost, Classes, uFileUnit, ZLib;

type
  //自身信息记录  (登陆器+图片文件+套装文件+经络文件+内挂文件+TRecinfo结构)
  TRecinfo = record
    GameListURL: string[255];
    BakGameListURL: string[255];
    PatchListURL: string[255];
    GameMonListURL: string[255];
    GameESystemUrl: string[255];
    //boGameMon :Boolean;
    boAutoUpData : Boolean;//是否开启自动下载关键文件
    lnkName: string[20];
    ClientFileName: string[20];
    //GameSdoFilter: array[0..50000] of char;
    //TzHintFile: array[0..5000] of Char;
    //PulsDesc: array[0..10000] of Char;
    GatePass: string[34];
    SourceFileSize: Int64;//登陆器原文件大小
    MainImagesFileSize: Int64;//图片文件大小
    TzHintListFileSize: Int64;//套装文件大小
    PulsDescFileSize: Int64;//经络文件大小
    GameSdoFilterFileSize: Int64;//内挂文件大小
    FDFileSize: Int64;//内挂文件大小
  end;
  //网关自身信息记录
  TRecGateinfo = record
    GatePass: string[34];
  end;

const
  RecInfoSize = Sizeof(TRecinfo);  //返回被TRecinfo所占用的字节数
  RecGateInfoSize = SizeOf(TRecGateinfo);
  
function CertKey(key: string): string;
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
//将输入的信息写入网关
function WriteGateInfo(const FilePath: string; MyRecInfo: TRecGateInfo): Boolean;
//加密2
function LoginMainImagesA(aStr: string; acKey: string): string;
function LoginMainImagesC(Source, Key: string): string;//加密2(gost)

//压缩流
procedure EnCompressStream(CompressedStream: TMemoryStream);
//流解压
procedure DeCompressStream(CompressedStream: TMemoryStream);

implementation
type
  TByte32 = array[1..32] of byte;
  TSData = array[0..63] of byte;
  TBlock = array[0..7] of byte;
const
  SA1: TSData =
  (1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1,
    0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1);
  SA2: TSData =
  (1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1);
  SA3: TSData =
  (1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0,
    1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1);
  SA4: TSData =
  (0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1,
    1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1);
  SA5: TSData =
  (0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0,
    0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0);
  SA6: TSData =
  (1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1,
    1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1);
  SA7: TSData =
  (0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1);
  SA8: TSData =
  (1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1);
  SB1: TSData =
  (1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1);
  SB2: TSData =
  (1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1,
    0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0);
  SB3: TSData =
  (0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0,
    1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1);
  SB4: TSData =
  (1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0,
    0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1);
  SB5: TSData =
  (0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0);
  SB6: TSData =
  (1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0,
    0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1);
  SB7: TSData =
  (1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1,
    0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1);
  SB8: TSData =
  (1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0);
  SC1: TSData =
  (1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0);
  SC2: TSData =
  (1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0,
    0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0);
  SC3: TSData =
  (1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0);
  SC4: TSData =
  (1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0,
    1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1);
  SC5: TSData =
  (1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1,
    0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1);
  SC6: TSData =
  (0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0);
  SC7: TSData =
  (0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0);
  SC8: TSData =
  (0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1,
    1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1);
  SD1: TSData =
  (0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0,
    0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1);
  SD2: TSData =
  (1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1,
    0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1);
  SD3: TSData =
  (0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1,
    1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0);
  SD4: TSData =
  (1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0);
  SD5: TSData =
  (0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0,
    0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1);
  SD6: TSData =
  (0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0,
    1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1);
  SD7: TSData =
  (0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0);
  SD8: TSData =
  (1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0,
    1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1);
  Sc: array[1..16, 1..48] of byte =
  ((15, 18, 12, 25, 2, 6, 4, 1, 16, 7, 22, 11, 24, 20, 13, 5, 27, 9, 17, 8, 28, 21, 14, 3,
    42, 53, 32, 38, 48, 56, 31, 41, 52, 46, 34, 49, 45, 50, 40, 29, 35, 54, 47, 43, 51, 37, 30, 33),
    (16, 19, 13, 26, 3, 7, 5, 2, 17, 8, 23, 12, 25, 21, 14, 6, 28, 10, 18, 9, 1, 22, 15, 4,
    43, 54, 33, 39, 49, 29, 32, 42, 53, 47, 35, 50, 46, 51, 41, 30, 36, 55, 48, 44, 52, 38, 31, 34),
    (18, 21, 15, 28, 5, 9, 7, 4, 19, 10, 25, 14, 27, 23, 16, 8, 2, 12, 20, 11, 3, 24, 17, 6,
    45, 56, 35, 41, 51, 31, 34, 44, 55, 49, 37, 52, 48, 53, 43, 32, 38, 29, 50, 46, 54, 40, 33, 36),
    (20, 23, 17, 2, 7, 11, 9, 6, 21, 12, 27, 16, 1, 25, 18, 10, 4, 14, 22, 13, 5, 26, 19, 8,
    47, 30, 37, 43, 53, 33, 36, 46, 29, 51, 39, 54, 50, 55, 45, 34, 40, 31, 52, 48, 56, 42, 35, 38),
    (22, 25, 19, 4, 9, 13, 11, 8, 23, 14, 1, 18, 3, 27, 20, 12, 6, 16, 24, 15, 7, 28, 21, 10,
    49, 32, 39, 45, 55, 35, 38, 48, 31, 53, 41, 56, 52, 29, 47, 36, 42, 33, 54, 50, 30, 44, 37, 40),
    (24, 27, 21, 6, 11, 15, 13, 10, 25, 16, 3, 20, 5, 1, 22, 14, 8, 18, 26, 17, 9, 2, 23, 12,
    51, 34, 41, 47, 29, 37, 40, 50, 33, 55, 43, 30, 54, 31, 49, 38, 44, 35, 56, 52, 32, 46, 39, 42),
    (26, 1, 23, 8, 13, 17, 15, 12, 27, 18, 5, 22, 7, 3, 24, 16, 10, 20, 28, 19, 11, 4, 25, 14,
    53, 36, 43, 49, 31, 39, 42, 52, 35, 29, 45, 32, 56, 33, 51, 40, 46, 37, 30, 54, 34, 48, 41, 44),
    (28, 3, 25, 10, 15, 19, 17, 14, 1, 20, 7, 24, 9, 5, 26, 18, 12, 22, 2, 21, 13, 6, 27, 16,
    55, 38, 45, 51, 33, 41, 44, 54, 37, 31, 47, 34, 30, 35, 53, 42, 48, 39, 32, 56, 36, 50, 43, 46),
    (1, 4, 26, 11, 16, 20, 18, 15, 2, 21, 8, 25, 10, 6, 27, 19, 13, 23, 3, 22, 14, 7, 28, 17,
    56, 39, 46, 52, 34, 42, 45, 55, 38, 32, 48, 35, 31, 36, 54, 43, 49, 40, 33, 29, 37, 51, 44, 47),
    (3, 6, 28, 13, 18, 22, 20, 17, 4, 23, 10, 27, 12, 8, 1, 21, 15, 25, 5, 24, 16, 9, 2, 19,
    30, 41, 48, 54, 36, 44, 47, 29, 40, 34, 50, 37, 33, 38, 56, 45, 51, 42, 35, 31, 39, 53, 46, 49),
    (5, 8, 2, 15, 20, 24, 22, 19, 6, 25, 12, 1, 14, 10, 3, 23, 17, 27, 7, 26, 18, 11, 4, 21,
    32, 43, 50, 56, 38, 46, 49, 31, 42, 36, 52, 39, 35, 40, 30, 47, 53, 44, 37, 33, 41, 55, 48, 51),
    (7, 10, 4, 17, 22, 26, 24, 21, 8, 27, 14, 3, 16, 12, 5, 25, 19, 1, 9, 28, 20, 13, 6, 23,
    34, 45, 52, 30, 40, 48, 51, 33, 44, 38, 54, 41, 37, 42, 32, 49, 55, 46, 39, 35, 43, 29, 50, 53),
    (9, 12, 6, 19, 24, 28, 26, 23, 10, 1, 16, 5, 18, 14, 7, 27, 21, 3, 11, 2, 22, 15, 8, 25,
    36, 47, 54, 32, 42, 50, 53, 35, 46, 40, 56, 43, 39, 44, 34, 51, 29, 48, 41, 37, 45, 31, 52, 55),
    (11, 14, 8, 21, 26, 2, 28, 25, 12, 3, 18, 7, 20, 16, 9, 1, 23, 5, 13, 4, 24, 17, 10, 27,
    38, 49, 56, 34, 44, 52, 55, 37, 48, 42, 30, 45, 41, 46, 36, 53, 31, 50, 43, 39, 47, 33, 54, 29),
    (13, 16, 10, 23, 28, 4, 2, 27, 14, 5, 20, 9, 22, 18, 11, 3, 25, 7, 15, 6, 26, 19, 12, 1,
    40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47, 43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 56, 31),
    (14, 17, 11, 24, 1, 5, 3, 28, 15, 6, 21, 10, 23, 19, 12, 4, 26, 8, 16, 7, 27, 20, 13, 2,
    41, 52, 31, 37, 47, 55, 30, 40, 51, 45, 33, 48, 44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32));
var
  G: array[1..16, 1..48] of byte;
  L, R, F: TByte32;
  c: array[1..56] of byte;
function CertKey(key: string): string;
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;

//压缩流
procedure EnCompressStream(CompressedStream: TMemoryStream);
var
  SM: TCompressionStream;
  DM: TMemoryStream;
  Count: int64; //注意，此处修改了,原来是int
begin
  if CompressedStream.Size <= 0 then exit;
  CompressedStream.Position := 0;
  Count := CompressedStream.Size; //获得流的原始尺寸
  DM := TMemoryStream.Create;
  SM := TCompressionStream.Create(clMax, DM);//其中的clMax表示压缩级别,可以更改,值是下列参数之一:clNone, clFastest, clDefault, clMax
  try
    CompressedStream.SaveToStream(SM); //SourceStream中保存着原始的流
    SM.Free; //将原始流进行压缩，DestStream中保存着压缩后的流
    CompressedStream.Clear;
    CompressedStream.WriteBuffer(Count, SizeOf(Count)); //写入原始文件的尺寸
    CompressedStream.CopyFrom(DM, 0); //写入经过压缩的流
    CompressedStream.Position := 0;
  finally
    DM.Free;
  end;
end;
//流解压
procedure DeCompressStream(CompressedStream: TMemoryStream);
var
  MS: TDecompressionStream;
  Buffer: PChar;
  Count: int64;
begin
  if CompressedStream.Size <= 0 then exit;
  CompressedStream.Position := 0; //复位流指针
  CompressedStream.ReadBuffer(Count, SizeOf(Count));
  //从被压缩的文件流中读出原始的尺寸
  GetMem(Buffer, Count); //根据尺寸大小为将要读入的原始流分配内存块
  MS := TDecompressionStream.Create(CompressedStream);
  try
    MS.ReadBuffer(Buffer^, Count);
    //将被压缩的流解压缩，然后存入 Buffer内存块中
    CompressedStream.Clear;
    CompressedStream.WriteBuffer(Buffer^, Count); //将原始流保存至 MS流中
    CompressedStream.Position := 0; //复位流指针
  finally
    FreeMem(Buffer);
  end;
end;
//-------------------------------------------------------------------------------

//将输入的信息写入登陆器
{function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end; }
//将输入的信息写入登陆器
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
var
  TargetFile: file;
  Stream: TMemoryStream;
  nFileSize:integer;
begin
  Result := True;
  Stream:= TMemoryStream.Create;
  try
    Stream.Position:= 0;
    Stream.WriteBuffer(MyRecInfo, RecInfoSize);
    Stream.Position:= 0;
    EncDecToStream(Stream, TDiyDecEncAlg(0), 'dfgt542');//加密流
    EnCompressStream(Stream);//压缩流
    try
      nFileSize:= Stream.Size;//记录结构文件大小
      AssignFile(TargetFile, FilePath);
      FileMode := 2;
      Reset(TargetFile, 1);
      Seek(TargetFile, FileSize(TargetFile));
      BlockWrite(TargetFile, Stream, Stream.size);
      BlockWrite(TargetFile, nFileSize, Sizeof(nFileSize));
      CloseFile(TargetFile);
    except
      Result := False;
    end;
  finally
    Stream.free;
  end;
end;

//将输入的信息写入网关
function WriteGateInfo(const FilePath: string; MyRecInfo: TRecGateInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecGateInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end;

procedure DES_Init(Key: TBlock; FCode: Boolean);
var
  n, h: byte;
begin
  c[1] := Ord(Key[7] and 128 > 0); c[29] := Ord(Key[7] and 2 > 0);
  c[2] := Ord(Key[6] and 128 > 0); c[30] := Ord(Key[6] and 2 > 0);
  c[3] := Ord(Key[5] and 128 > 0); c[31] := Ord(Key[5] and 2 > 0);
  c[4] := Ord(Key[4] and 128 > 0); c[32] := Ord(Key[4] and 2 > 0);
  c[5] := Ord(Key[3] and 128 > 0); c[33] := Ord(Key[3] and 2 > 0);
  c[6] := Ord(Key[2] and 128 > 0); c[34] := Ord(Key[2] and 2 > 0);
  c[7] := Ord(Key[1] and 128 > 0); c[35] := Ord(Key[1] and 2 > 0);
  c[8] := Ord(Key[0] and 128 > 0); c[36] := Ord(Key[0] and 2 > 0);

  c[9] := Ord(Key[7] and 64 > 0); c[37] := Ord(Key[7] and 4 > 0);
  c[10] := Ord(Key[6] and 64 > 0); c[38] := Ord(Key[6] and 4 > 0);
  c[11] := Ord(Key[5] and 64 > 0); c[39] := Ord(Key[5] and 4 > 0);
  c[12] := Ord(Key[4] and 64 > 0); c[40] := Ord(Key[4] and 4 > 0);
  c[13] := Ord(Key[3] and 64 > 0); c[41] := Ord(Key[3] and 4 > 0);
  c[14] := Ord(Key[2] and 64 > 0); c[42] := Ord(Key[2] and 4 > 0);
  c[15] := Ord(Key[1] and 64 > 0); c[43] := Ord(Key[1] and 4 > 0);
  c[16] := Ord(Key[0] and 64 > 0); c[44] := Ord(Key[0] and 4 > 0);

  c[17] := Ord(Key[7] and 32 > 0); c[45] := Ord(Key[7] and 8 > 0);
  c[18] := Ord(Key[6] and 32 > 0); c[46] := Ord(Key[6] and 8 > 0);
  c[19] := Ord(Key[5] and 32 > 0); c[47] := Ord(Key[5] and 8 > 0);
  c[20] := Ord(Key[4] and 32 > 0); c[48] := Ord(Key[4] and 8 > 0);
  c[21] := Ord(Key[3] and 32 > 0); c[49] := Ord(Key[3] and 8 > 0);
  c[22] := Ord(Key[2] and 32 > 0); c[50] := Ord(Key[2] and 8 > 0);
  c[23] := Ord(Key[1] and 32 > 0); c[51] := Ord(Key[1] and 8 > 0);
  c[24] := Ord(Key[0] and 32 > 0); c[52] := Ord(Key[0] and 8 > 0);

  c[25] := Ord(Key[7] and 16 > 0); c[53] := Ord(Key[3] and 16 > 0);
  c[26] := Ord(Key[6] and 16 > 0); c[54] := Ord(Key[2] and 16 > 0);
  c[27] := Ord(Key[5] and 16 > 0); c[55] := Ord(Key[1] and 16 > 0);
  c[28] := Ord(Key[4] and 16 > 0); c[56] := Ord(Key[0] and 16 > 0);

  if FCode then
  begin
    for n := 1 to 16 do
    begin
      for h := 1 to 48 do
      begin
        G[n, h] := c[Sc[n, h]];
      end;
    end;
  end
  else
  begin
    for n := 1 to 16 do
    begin
      for h := 1 to 48 do
      begin
        G[17 - n, h] := c[Sc[n, h]];
      end;
    end;
  end;
end;

procedure DES_Code(Input: TBlock; var Output: TBlock);
var
  n: byte;
  z: Word;
begin
  L[1] := Ord(Input[7] and 64 > 0); R[1] := Ord(Input[7] and 128 > 0);
  L[2] := Ord(Input[6] and 64 > 0); R[2] := Ord(Input[6] and 128 > 0);
  L[3] := Ord(Input[5] and 64 > 0); R[3] := Ord(Input[5] and 128 > 0);
  L[4] := Ord(Input[4] and 64 > 0); R[4] := Ord(Input[4] and 128 > 0);
  L[5] := Ord(Input[3] and 64 > 0); R[5] := Ord(Input[3] and 128 > 0);
  L[6] := Ord(Input[2] and 64 > 0); R[6] := Ord(Input[2] and 128 > 0);
  L[7] := Ord(Input[1] and 64 > 0); R[7] := Ord(Input[1] and 128 > 0);
  L[8] := Ord(Input[0] and 64 > 0); R[8] := Ord(Input[0] and 128 > 0);
  L[9] := Ord(Input[7] and 16 > 0); R[9] := Ord(Input[7] and 32 > 0);
  L[10] := Ord(Input[6] and 16 > 0); R[10] := Ord(Input[6] and 32 > 0);
  L[11] := Ord(Input[5] and 16 > 0); R[11] := Ord(Input[5] and 32 > 0);
  L[12] := Ord(Input[4] and 16 > 0); R[12] := Ord(Input[4] and 32 > 0);
  L[13] := Ord(Input[3] and 16 > 0); R[13] := Ord(Input[3] and 32 > 0);
  L[14] := Ord(Input[2] and 16 > 0); R[14] := Ord(Input[2] and 32 > 0);
  L[15] := Ord(Input[1] and 16 > 0); R[15] := Ord(Input[1] and 32 > 0);
  L[16] := Ord(Input[0] and 16 > 0); R[16] := Ord(Input[0] and 32 > 0);
  L[17] := Ord(Input[7] and 4 > 0); R[17] := Ord(Input[7] and 8 > 0);
  L[18] := Ord(Input[6] and 4 > 0); R[18] := Ord(Input[6] and 8 > 0);
  L[19] := Ord(Input[5] and 4 > 0); R[19] := Ord(Input[5] and 8 > 0);
  L[20] := Ord(Input[4] and 4 > 0); R[20] := Ord(Input[4] and 8 > 0);
  L[21] := Ord(Input[3] and 4 > 0); R[21] := Ord(Input[3] and 8 > 0);
  L[22] := Ord(Input[2] and 4 > 0); R[22] := Ord(Input[2] and 8 > 0);
  L[23] := Ord(Input[1] and 4 > 0); R[23] := Ord(Input[1] and 8 > 0);
  L[24] := Ord(Input[0] and 4 > 0); R[24] := Ord(Input[0] and 8 > 0);
  L[25] := Input[7] and 1; R[25] := Ord(Input[7] and 2 > 0);
  L[26] := Input[6] and 1; R[26] := Ord(Input[6] and 2 > 0);
  L[27] := Input[5] and 1; R[27] := Ord(Input[5] and 2 > 0);
  L[28] := Input[4] and 1; R[28] := Ord(Input[4] and 2 > 0);
  L[29] := Input[3] and 1; R[29] := Ord(Input[3] and 2 > 0);
  L[30] := Input[2] and 1; R[30] := Ord(Input[2] and 2 > 0);
  L[31] := Input[1] and 1; R[31] := Ord(Input[1] and 2 > 0);
  L[32] := Input[0] and 1; R[32] := Ord(Input[0] and 2 > 0);

  for n := 1 to 16 do
  begin
    z := ((R[32] xor G[n, 1]) shl 5) or ((R[5] xor G[n, 6]) shl 4)
      or ((R[1] xor G[n, 2]) shl 3) or ((R[2] xor G[n, 3]) shl 2)
      or ((R[3] xor G[n, 4]) shl 1) or (R[4] xor G[n, 5]);
    F[9] := L[9] xor SA1[z];
    F[17] := L[17] xor SB1[z];
    F[23] := L[23] xor SC1[z];
    F[31] := L[31] xor SD1[z];

    z := ((R[4] xor G[n, 7]) shl 5) or ((R[9] xor G[n, 12]) shl 4)
      or ((R[5] xor G[n, 8]) shl 3) or ((R[6] xor G[n, 9]) shl 2)
      or ((R[7] xor G[n, 10]) shl 1) or (R[8] xor G[n, 11]);
    F[13] := L[13] xor SA2[z];
    F[28] := L[28] xor SB2[z];
    F[2] := L[2] xor SC2[z];
    F[18] := L[18] xor SD2[z];

    z := ((R[8] xor G[n, 13]) shl 5) or ((R[13] xor G[n, 18]) shl 4)
      or ((R[9] xor G[n, 14]) shl 3) or ((R[10] xor G[n, 15]) shl 2)
      or ((R[11] xor G[n, 16]) shl 1) or (R[12] xor G[n, 17]);
    F[24] := L[24] xor SA3[z];
    F[16] := L[16] xor SB3[z];
    F[30] := L[30] xor SC3[z];
    F[6] := L[6] xor SD3[z];

    z := ((R[12] xor G[n, 19]) shl 5) or ((R[17] xor G[n, 24]) shl 4)
      or ((R[13] xor G[n, 20]) shl 3) or ((R[14] xor G[n, 21]) shl 2)
      or ((R[15] xor G[n, 22]) shl 1) or (R[16] xor G[n, 23]);
    F[26] := L[26] xor SA4[z];
    F[20] := L[20] xor SB4[z];
    F[10] := L[10] xor SC4[z];
    F[1] := L[1] xor SD4[z];

    z := ((R[16] xor G[n, 25]) shl 5) or ((R[21] xor G[n, 30]) shl 4)
      or ((R[17] xor G[n, 26]) shl 3) or ((R[18] xor G[n, 27]) shl 2)
      or ((R[19] xor G[n, 28]) shl 1) or (R[20] xor G[n, 29]);
    F[8] := L[8] xor SA5[z];
    F[14] := L[14] xor SB5[z];
    F[25] := L[25] xor SC5[z];
    F[3] := L[3] xor SD5[z];

    z := ((R[20] xor G[n, 31]) shl 5) or ((R[25] xor G[n, 36]) shl 4)
      or ((R[21] xor G[n, 32]) shl 3) or ((R[22] xor G[n, 33]) shl 2)
      or ((R[23] xor G[n, 34]) shl 1) or (R[24] xor G[n, 35]);
    F[4] := L[4] xor SA6[z];
    F[29] := L[29] xor SB6[z];
    F[11] := L[11] xor SC6[z];
    F[19] := L[19] xor SD6[z];

    z := ((R[24] xor G[n, 37]) shl 5) or ((R[29] xor G[n, 42]) shl 4)
      or ((R[25] xor G[n, 38]) shl 3) or ((R[26] xor G[n, 39]) shl 2)
      or ((R[27] xor G[n, 40]) shl 1) or (R[28] xor G[n, 41]);
    F[32] := L[32] xor SA7[z];
    F[12] := L[12] xor SB7[z];
    F[22] := L[22] xor SC7[z];
    F[7] := L[7] xor SD7[z];

    z := ((R[28] xor G[n, 43]) shl 5) or ((R[1] xor G[n, 48]) shl 4)
      or ((R[29] xor G[n, 44]) shl 3) or ((R[30] xor G[n, 45]) shl 2)
      or ((R[31] xor G[n, 46]) shl 1) or (R[32] xor G[n, 47]);
    F[5] := L[5] xor SA8[z];
    F[27] := L[27] xor SB8[z];
    F[15] := L[15] xor SC8[z];
    F[21] := L[21] xor SD8[z];

    L := R;
    R := F;
  end;

  Output[0] := (L[8] shl 7) or (R[8] shl 6) or (L[16] shl 5) or (R[16] shl 4)
    or (L[24] shl 3) or (R[24] shl 2) or (L[32] shl 1) or R[32];
  Output[1] := (L[7] shl 7) or (R[7] shl 6) or (L[15] shl 5) or (R[15] shl 4)
    or (L[23] shl 3) or (R[23] shl 2) or (L[31] shl 1) or R[31];
  Output[2] := (L[6] shl 7) or (R[6] shl 6) or (L[14] shl 5) or (R[14] shl 4)
    or (L[22] shl 3) or (R[22] shl 2) or (L[30] shl 1) or R[30];
  Output[3] := (L[5] shl 7) or (R[5] shl 6) or (L[13] shl 5) or (R[13] shl 4)
    or (L[21] shl 3) or (R[21] shl 2) or (L[29] shl 1) or R[29];
  Output[4] := (L[4] shl 7) or (R[4] shl 6) or (L[12] shl 5) or (R[12] shl 4)
    or (L[20] shl 3) or (R[20] shl 2) or (L[28] shl 1) or R[28];
  Output[5] := (L[3] shl 7) or (R[3] shl 6) or (L[11] shl 5) or (R[11] shl 4)
    or (L[19] shl 3) or (R[19] shl 2) or (L[27] shl 1) or R[27];
  Output[6] := (L[2] shl 7) or (R[2] shl 6) or (L[10] shl 5) or (R[10] shl 4)
    or (L[18] shl 3) or (R[18] shl 2) or (L[26] shl 1) or R[26];
  Output[7] := (L[1] shl 7) or (R[1] shl 6) or (L[9] shl 5) or (R[9] shl 4)
    or (L[17] shl 3) or (R[17] shl 2) or (L[25] shl 1) or R[25];
end;

function StrToKey(aKey: string): TBlock;
var
  Key: TBlock;
  i: Integer;
begin
  FillChar(Key, sizeof(TBlock), 0);
  for i := 1 to Length(aKey) do
  begin
    Key[i mod sizeof(TBlock)] := Key[i mod sizeof(TBlock)] + Ord(aKey[i]);
  end;

  Result := Key;
end;

//加密2
function LoginMainImagesA(aStr: string; acKey: string): string;
var
  ReadBuf: TBlock;
  WriteBuf: TBlock;
  Key: TBlock;
  Count: Integer;
  Offset: Integer;

  i: Integer;
  S: string;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  Result := '';

  Key := StrToKey(acKey);
  DES_Init(Key, true);

  Offset := 1;
  Count := Length(aStr);
  repeat
    S := Copy(aStr, Offset, 8);
    FillChar(ReadBuf, 8, 0);
    Move(S[1], ReadBuf, Length(S));
    DES_Code(ReadBuf, WriteBuf);

    for i := 0 to 7 do
    begin
      Result := Result + IntToHex(WriteBuf[i], 2);
    end;

    Offset := Offset + 8;
  until Offset > ((Count + 7) div 8) * 8;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;

function LoginMainImagesC(Source, Key: string): string;//加密3(RC5)
var
  //DesEncode: TDCP_rc5;
  //DesEncode: TDCP_ice;
  DesEncode: TDCP_gost;
  Str: string;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  try
    Result := '';
    DesEncode := TDCP_gost.Create(nil);//TDCP_rc5.Create(nil);
    DesEncode.InitStr(Key);
    DesEncode.Reset;
    Str := DesEncode.EncryptString(Source);
    DesEncode.Reset;
    Result := Str;
    DesEncode.Free;
  except
    Result := '';
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;

end.
 