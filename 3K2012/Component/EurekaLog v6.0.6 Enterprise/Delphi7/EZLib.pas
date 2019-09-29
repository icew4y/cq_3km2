{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          ZLib and Zip Unit - EZLib             }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EZlib;

{$I Exceptions.inc}

interface

uses
  Windows, SysUtils;

{$L obj\zip.obj}
{$L obj\unzip.obj}
{$L obj\ioapi.obj}
{$L obj\iowin32.obj}
{$L obj\adler32.obj}
{$L obj\compress.obj}
{$L obj\crc32.obj}
{$L obj\deflate.obj}
{$L obj\infback.obj}
{$L obj\inffast.obj}
{$L obj\inflate.obj}
{$L obj\inftrees.obj}
{$L obj\trees.obj}

const
  ZLIB_VERSION = '1.2.3';

  {** return code messages **************************************************}

  _z_errmsg: array[0..9] of PChar = (
    '需要字典', // Z_NEED_DICT      (2)
    '流结束', // Z_STREAM_END     (1)
    '', // Z_OK             (0)
    '文件错误', // Z_ERRNO          (-1)
    '流错误', // Z_STREAM_ERROR   (-2)
    '日期错误', // Z_DATA_ERROR     (-3)
    '内存不足', // Z_MEM_ERROR      (-4)
    '缓冲区错误', // Z_BUF_ERROR      (-5)
    '版本不兼容', // Z_VERSION_ERROR  (-6)
    ''
    );

  WRITEBUFFERSIZE = 65536; // 64Kb

  {** flush constants *******************************************************}

  Z_NO_FLUSH = 0;
  Z_PARTIAL_FLUSH = 1;
  Z_SYNC_FLUSH = 2;
  Z_FULL_FLUSH = 3;
  Z_FINISH = 4;

  {** return codes **********************************************************}

  Z_OK = 0;
  Z_STREAM_END = 1;
  Z_NEED_DICT = 2;
  Z_ERRNO = (-1);
  Z_STREAM_ERROR = (-2);
  Z_DATA_ERROR = (-3);
  Z_MEM_ERROR = (-4);
  Z_BUF_ERROR = (-5);
  Z_VERSION_ERROR = (-6);

  {** compression levels ****************************************************}

  Z_NO_COMPRESSION = 0;
  Z_BEST_SPEED = 1;
  Z_BEST_COMPRESSION = 9;
  Z_DEFAULT_COMPRESSION = (-1);

  {** zip constants *********************************************************}

  ZIP_OK = 0;

  {** unzip constants *******************************************************}

  UNZ_OK = 0;
  UNZ_END_OF_LIST_OF_FILE = -100;
  UNZ_ERRNO = Z_ERRNO;
  UNZ_EOF = 0;
  UNZ_PARAMERROR = -102;
  UNZ_BADZIPFILE = -103;
  UNZ_INTERNALERROR = -104;
  UNZ_CRCERROR = -105;

type
  tm_zip = packed record
    tm_sec, tm_min, tm_hour, tm_mday, tm_mon, tm_year: DWord;
  end;

  zip_fileinfo = packed record
    tmz_date: tm_zip;
    dosDate, internal_fa, external_fa: DWord;
  end;
  Pzip_fileinfo = ^zip_fileinfo;

  unz_file_info = packed record
    version, version_needed, flag, compression_method, dosDate, crc,
      compressed_size, uncompressed_size, size_filename, size_file_extra,
      size_file_comment, disk_num_start, internal_fa, external_fa: DWord;
    tmu_date: tm_zip;
  end;
  Punz_file_info = ^unz_file_info;

  unz_global_info = packed record
    number_entry, size_comment: DWord;
  end;
  Punz_global_info = ^unz_global_info;

  TZAlloc = function(opaque: Pointer; items, size: Integer): Pointer;
  TZFree = procedure(opaque, block: Pointer);

  {** TZStreamRec ***********************************************************}

  TZStreamRec = packed record
    next_in: PChar; // next input byte
    avail_in: Longint; // number of bytes available at next_in
    total_in: Longint; // total nb of input bytes read so far
    next_out: PChar; // next output byte should be put here
    avail_out: Longint; // remaining free space at next_out
    total_out: Longint; // total nb of bytes output so far
    msg: PChar; // last error message, NULL if no error
    state: Pointer; // not visible by applications
    zalloc: TZAlloc; // used to allocate the internal state
    zfree: TZFree; // used to free the internal state
    opaque: Pointer; // private data object passed to zalloc and zfree
    data_type: Integer; // best guess about the data type: ascii or binary
    adler: Longint; // adler32 value of the uncompressed data
    reserved: Longint; // reserved for future use
  end;

  EZLibError = class(Exception);

// ZLib routines...
function compressBound(sourceLen: LongInt): LongInt; external;
function adler32(adler: LongInt; const buf: PChar; len: Integer): LongInt; external;
function crc32(crc: DWord; const buf; len: DWord): DWord; external;

{** deflate routines ********************************************************}
function deflateInit_(var strm: TZStreamRec; level: Integer; version: PChar;
  recsize: Integer): Integer; external;
function deflate(var strm: TZStreamRec; flush: Integer): Integer; external;
function deflateEnd(var strm: TZStreamRec): Integer; external;

{** inflate routines ********************************************************}
function inflateInit_(var strm: TZStreamRec; version: PChar;
  recsize: Integer): Integer; external;
function inflate(var strm: TZStreamRec; flush: Integer): Integer; external;
function inflateEnd(var strm: TZStreamRec): Integer; external;
function inflateReset(var strm: TZStreamRec): Integer; external;

// Used only to avoid a Delphi4/5 hint message 'Package ? does not use or export...';
//------------------------------------------------------------------------------
function inflateBackInit_(var strm: TZStreamRec; windowBits: Integer;
  window: Pointer; version: PChar; stream_size: Integer): Integer; external;
function inflateBack(var strm: TZStreamRec; infunc, in_desc, outfunc,
  out_desc: Pointer): Integer; external;
function inflateBackEnd(var strm: TZStreamRec): Integer; external;
//------------------------------------------------------------------------------

// Zip routines...
function zipOpen(const pathname: PChar; append: Integer): THandle; external;
function zipOpenNewFileInZip3(hFile: THandle; const filename: PChar;
  zipfi: Pzip_fileinfo;
  const extrafield_local: Pointer; size_extrafield_local: DWord;
  const extrafield_global: Pointer; size_extrafield_global: DWord;
  const comment: PChar; method, level, raw, windowBits, memLevel, strategy: Integer;
  const password: PChar; crcForCrypting: DWord): Integer; external;
function zipWriteInFileInZip(hFile: THandle; var buf; len: DWord): Integer; external;
function zipCloseFileInZip(hFile: THandle): Integer; external;
function zipClose(hFile: THandle; const global_comment: PChar): Integer; external;

// Unzip routines...
function unzGetCurrentFileInfo(hFile: THandle; pfile_info: Punz_file_info;
  const szFileName: PChar; fileNameBufferSize: DWord;
  extraField: Pointer; extraFieldBufferSize: DWord;
  const szComment: PChar; commentBufferSize: DWord): Integer; external;
function unzOpenCurrentFilePassword(hFile: THandle; const password: PChar): Integer; external;
function unzReadCurrentFile(hFile: THandle; var buf; len: DWord): Integer; external;
function unzCloseCurrentFile(hFile: THandle): Integer; external;
function unzGetGlobalInfo(hFile: THandle; pglobal_info: Punz_global_info): Integer; external;
function unzGoToNextFile(hFile: THandle): Integer; external;
function unzOpen(const path: PChar): Integer; external;

{** zlib routines ***********************************************************}
procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer);
procedure ZDecompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer);

{** zip routines ************************************************************}
function CreateZipFile(ZipFile: PChar): THandle;
function AddZipFile(ZipHandle: THandle; FileToZip, FileName, Password: PChar): Boolean;
function CloseZipFile(ZipHandle: THandle): Boolean;
function ExtractZipFiles(ZipFile, OutputDir, Password: PChar): Boolean;

implementation

{** zlib function implementations *******************************************}

function zcalloc(opaque: Pointer; items, size: Integer): Pointer;
begin
  GetMem(result, items * size);
end;

procedure zcfree(opaque, block: Pointer);
begin
  FreeMem(block);
end;

{** custom zlib routines ****************************************************}

function DeflateInit(var stream: TZStreamRec; level: Integer): Integer;
begin
  result := DeflateInit_(stream, level, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

function InflateInit(var stream: TZStreamRec): Integer;
begin
  result := InflateInit_(stream, ZLIB_VERSION, SizeOf(TZStreamRec));
end;

{****************************************************************************}

function ZCheck(code: Integer): Integer;
begin
  Result := code;

  if (code < 0) then
  begin
    raise EZLibError.Create(_z_errmsg[2 - code]);
  end;
end;

procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer);
const
  delta = 256;
var
  zstream: TZStreamRec;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  outSize := ((inSize + (inSize div 10) + 12) + 255) and not 255;
  GetMem(outBuffer, outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZCheck(DeflateInit(zstream, Z_BEST_COMPRESSION));

    try
      while ZCheck(deflate(zstream, Z_FINISH)) <> Z_STREAM_END do
      begin
        Inc(outSize, delta);
        ReallocMem(outBuffer, outSize);

        zstream.next_out := PChar(Integer(outBuffer) + zstream.total_out);
        zstream.avail_out := delta;
      end;
    finally
      ZCheck(deflateEnd(zstream));
    end;

    ReallocMem(outBuffer, zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;

procedure ZDecompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer);
var
  zstream: TZStreamRec;
  delta: Integer;
  Res: Integer;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  delta := (inSize + 255) and not 255;
  outSize := delta;

  GetMem(outBuffer, outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZCheck(InflateInit(zstream));

    try
      repeat
        Res := inflate(zstream, Z_NO_FLUSH);
        if (Res = Z_OK) then
        begin
          Inc(outSize, delta);
          ReallocMem(outBuffer, outSize);

          zstream.next_out := PChar(Integer(outBuffer) + zstream.total_out);
          zstream.avail_out := delta;
        end;
      until (Res <> Z_OK);
    finally
      ZCheck(inflateEnd(zstream));
    end;

    ReallocMem(outBuffer, zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;

{** c function implementations **********************************************}

procedure _memset(p: Pointer; b: Byte; count: Integer); cdecl;
begin
  FillChar(p^, count, b);
end;

procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

function _malloc(size: integer): pointer; cdecl;
begin
  GetMem(result, size);
end;

procedure _free(p: pointer); cdecl;
begin
  FreeMem(p);
end;

function _strlen(const Str: PChar): Cardinal; cdecl;
begin
  Result := StrLen(Str);
end;

function _time(const PTime: Pointer): Cardinal; cdecl;
begin
  Result := GetTickCount;
end;

function _rand: Integer; cdecl;
begin
  Result := Random(32768);
end;

procedure _srand(seed: DWord); cdecl;
begin
  RandSeed := Seed;
end;

function _fopen(const filename, mode: PChar): THandle; cdecl;
begin
  Result := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE,
    FILE_SHARE_READ, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
end;

function _fread(var buffer; size, count: Integer; hFile: THandle): Integer; cdecl;
var
  BytesRead, BytesToRead: Integer;
begin
  BytesToRead := (size * count);
  BytesRead := FileRead(hFile, buffer, BytesToRead);
  Result := (BytesRead div size);
end;

function _fwrite(const buffer; size, count: Integer; hFile: THandle): Integer; cdecl;
var
  BytesWrote, BytesToWrite: Integer;
begin
  BytesToWrite := (size * count);
  BytesWrote := FileWrite(hFile, buffer, BytesToWrite);
  Result := (BytesWrote div size);
end;

function _ftell(hFile: THandle): Integer; cdecl;
begin
  Result := FileSeek(hFile, 0, 1);
end;

function _fseek(hFile: THandle; offset, origin: Integer): Integer; cdecl;
begin
  if (FileSeek(hFile, offset, origin) <> Integer($FFFFFFFF)) then
    Result := 0
  else
    Result := 1;
end;

function _fclose(hFile: THandle): Integer; cdecl;
begin
  if (CloseHandle(hFile)) then
    Result := 0
  else
    Result := 1;
end;

{****************************************************************************}

procedure GetModifiedDate(sFileName: string; var tm: zip_fileinfo);
var
  ffd: TWin32FindData;
  lft: TFileTime;
  h: THandle;
  DateTime: TDateTime;
  Ye, Mo, Da, Ho, Mi, Se, Ms: Word;
begin
  FillChar(tm, SizeOf(tm), #0);
  // Get file information
  h := Windows.FindFirstFile(PChar(sFileName), ffd);
  if (h <> INVALID_HANDLE_VALUE) then
  begin
    // We're looking for just one file, so close our "find"
    Windows.FindClose(h);
    // Convert the FILETIME to local FILETIME
    if FileTimeToLocalFileTime(ffd.ftLastWriteTime, lft) then
    begin
      // Convert FILETIME to DOS time
      if FileTimeToDosDateTime(lft, LongRec(tm.dosDate).Hi, LongRec(tm.dosDate).Lo) then
      begin
        DateTime := FileDateToDateTime(tm.dosDate);
        DecodeDate(DateTime, Ye, Mo, Da);
        DecodeTime(DateTime, Ho, Mi, Se, Ms);
        with tm.tmz_date do
        begin
          tm_sec := Se;
          tm_min := Mi;
          tm_hour := Ho;
          tm_mday := Da;
          tm_mon := Mo;
          tm_year := Ye;
        end;
      end;
    end;
  end;
end;

function CreateZipFile(ZipFile: PChar): THandle;
begin;
  DeleteFile(ZipFile);
  Result := zipOpen(ZipFile, 0);
end;

function AddZipFile(ZipHandle: THandle; FileToZip, FileName, Password: PChar): Boolean;
var
  err, size_buf, size_read: Integer;
  buf: Pointer;
  fin: THandle;
  zi: zip_fileinfo;
  crcFile: DWord;

  function GetFileSize(const FileName: string): DWord;
  var
    FFD: TWIN32FindData;
  begin
    if Windows.FindClose(Windows.FindFirstFile(PChar(FileName), FFD)) then
      Result := FFD.nFileSizeLow
    else
      Result := 0;
  end;

begin;
  Result := False;

  crcFile := 0;
  size_buf := GetFileSize(FileToZip);

  GetMem(buf, size_buf);
  try
    FillChar(zi, SizeOf(zi), #0);
    GetModifiedDate(FileToZip, zi);

    fin := FileOpen(FileToZip, fmOpenRead or fmShareDenyWrite);
    if (fin = INVALID_HANDLE_VALUE) then Exit;

    try
      size_read := FileRead(fin, buf^, size_buf);
      if (size_read <> size_buf) then Exit;

      if (password <> nil) and (password^ = '') then Password := nil;

      if (password <> nil) then
        crcFile := crc32(0, buf^, size_buf);

      err := zipOpenNewFileInZip3(ZipHandle,
        PChar(FileName), @zi, nil, 0, nil, 0, nil {comment},
        8 {Z_DEFLATED}, 9 {max compress level}, 0,
        -15 {-MAX_WBITS}, 8 {DEF_MEM_LEVEL}, 0 {Z_DEFAULT_STRATEGY},
        Password, crcFile);
      if (err <> ZIP_OK) then Exit;

      err := zipWriteInFileInZip(ZipHandle, buf^, size_read);
      if (err < 0) then exit;
    finally
      FileClose(fin);
    end;
  finally
    FreeMem(buf);
  end;
  Result := True;
end;

function CloseZipFile(ZipHandle: THandle): Boolean;
var
  err: Integer;
begin;
  Result := False;

  err := zipCloseFileInZip(ZipHandle);
  if (err <> ZIP_OK) then Exit;

  err := zipClose(ZipHandle, nil);
  if (err <> ZIP_OK) then Exit;

  Result := True;
end;

function DoExtractCurrentFile(uf: THandle; OutDir, password: PChar): Boolean;
var
  filename_inzip: array[0..255] of char;
  err: Integer;
  fout: THandle;
  size_buf: DWord;
  buf: Pointer;
  file_info: unz_file_info;
  ODir: string;
begin
  Result := False;
  ODir := Trim(string(OutDir));
  if (Copy(ODir, Length(ODir), 1) <> '\') then ODir := (ODir + '\');

  err := unzGetCurrentFileInfo(uf, @file_info, filename_inzip, SizeOf(filename_inzip), nil, 0, nil, 0);
  if (err <> UNZ_OK) then Exit;

  size_buf := WRITEBUFFERSIZE;
  GetMem(buf, size_buf);
  try
    err := unzOpenCurrentFilePassword(uf, password);
    if (err <> UNZ_OK) then Exit;

    fout := CreateFile(PChar(ODir + filename_inzip), GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if (fout <> INVALID_HANDLE_VALUE) then
    begin
      repeat
        err := unzReadCurrentFile(uf, buf^, size_buf);
        if (err > 0) and (FileWrite(fout, buf^, err) <> err) then Exit;
      until (err <= 0);
      FileClose(fout);
//    if (err = 0) then change_file_date(write_filename, file_info.dosDate, file_info.tmu_date);
    end;

    if (err = UNZ_OK) then
    begin
      err := unzCloseCurrentFile(uf);
      if (err <> UNZ_OK) then Exit;
    end
    else
      unzCloseCurrentFile(uf); // don't lose the error
  finally
    FreeMem(buf);
  end;
  Result := True;
end;

function DoExtract(uf: THandle; OutDir, password: PChar): Boolean;
var
  i, err: DWord;
  OK: Boolean;
  gi: unz_global_info;
begin
  Result := False;
  err := unzGetGlobalInfo(uf, @gi);
  if (err <> UNZ_OK) then Exit;

  for i := 0 to (gi.number_entry - 1) do
  begin
    OK := DoExtractCurrentFile(uf, OutDir, password);
    if (not OK) then Exit;

    if ((i + 1) < gi.number_entry) then
    begin
      err := unzGoToNextFile(uf);
      if (err <> UNZ_OK) then Exit;
    end;
  end;

  Result := True;
end;

function ExtractZipFiles(ZipFile, OutputDir, Password: PChar): Boolean;
var
  uf: THandle;
begin
  Result := False;

  uf := unzOpen(ZipFile);
  if (uf = 0) then Exit;

  try
    Result := DoExtract(uf, OutputDir, password);
  finally
    unzCloseCurrentFile(uf);
  end;
end;

end.

