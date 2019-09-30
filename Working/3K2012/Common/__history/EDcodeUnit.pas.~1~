//////////////////////////////////////////////////////////////
//                                                          //
//                                                          //
//                        加密/解密单元                     //
//                                                          //
//                                                          //
//////////////////////////////////////////////////////////////
unit EDcodeUnit;

interface
uses
  Windows, SysUtils, DESTR, Des;

type
  TStringInfo = packed record
    btLength: Byte;
    nUniCode: Integer;
    sString: array[0..High(Byte) - 1] of Char;
  end;
  pTStringInfo = ^TStringInfo;

  TString = packed record
    btLength: Byte;
    nUniCode: Integer;
    sString: array[0..High(Word) - 1] of Char;
  end;
  pTString = ^TString;

function Encrypt_Decrypt(m: Int64; E: Int64 = $2C86F9; n: Int64 = $69AAA0E3): Integer;
function Chinese2UniCode(AiChinese: string): Integer;
function GetUniCode(msg: string): Integer;
function Encode(Src: string; var Dest: string): Boolean;
function Decode(Src: string; var Dest: string): Boolean;
function Base64EncodeStr(const Value: string): string;
{ Encode a string into Base64 format }
function Base64DecodeStr(const Value: string): string;
{ Decode a Base64 format string }
function Base64Encode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
{ Encode a lump of raw data (output is (4/3) times bigger than input) }
function Base64Decode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
{ Decode a lump of raw data }


function EncodeString_3des(Source, Key: string): string;
function DecodeString_3des(Source, Key: string): string;
function CalcFileCRC(sFileName: string): Integer;
function CalcBufferCRC(Buffer: PChar; nSize: Integer): Integer;

function DecryptString(Src: string): string;
function EncryptString(Src: string): string;
function EncryptBuffer(Buf: PChar; bufsize: Integer): string;
procedure DecryptBuffer(Src: string; Buf: PChar; bufsize: Integer);

implementation
uses
  Grobal2;

const
  BUFFERSIZE = 10000;
  B64: array[0..63] of Byte = (65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
    81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
    109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 43, 47);
  //Key: array[0..2, 0..7] of Byte = (($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF), ($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF), ($FF, $FE, $FF, $FE, $FF, $FE, $FF, $FF));
var
  CSEncode: TRTLCriticalSection;

function CalcFileCRC(sFileName: string): Integer;
var
  I: Integer;
  nFileHandle: Integer;
  nFileSize, nBuffSize: Integer;
  Buffer: PChar;
  Int: ^Integer;
  nCrc: Integer;
begin
  Result := 0;
  if not FileExists(sFileName) then Exit;
  nFileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
  if nFileHandle = 0 then
    Exit;
  nFileSize := FileSeek(nFileHandle, 0, 2);       //改变文件的指针
  nBuffSize := (nFileSize div 4) * 4;
  GetMem(Buffer, nBuffSize);
  FillChar(Buffer^, nBuffSize, 0);
  FileSeek(nFileHandle, 0, 0);
  FileRead(nFileHandle, Buffer^, nBuffSize);
  FileClose(nFileHandle);
  Int := Pointer(Buffer);
  nCrc := 0;
  //Exception.Create(IntToStr(SizeOf(Integer)));//20080303 异常提示,注释掉此句就可以不泄漏内存
  for I := 0 to nBuffSize div 4 - 1 do begin
    nCrc := nCrc xor Int^;
    Int := Pointer(Integer(Int) + 4);
  end;
  FreeMem(Buffer);
  Result := nCrc;
end;

function CalcBufferCRC(Buffer: PChar; nSize: Integer): Integer;
var
  I: Integer;
  Int: ^Integer;
  nCrc: Integer;
begin
  Int := Pointer(Buffer);
  nCrc := 0;
  for I := 0 to nSize div 4 - 1 do begin
    nCrc := nCrc xor Int^;
    Int := Pointer(Integer(Int) + 4);
  end;
  Result := nCrc;
end;
function Base64Encode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
var
  I, iptr, optr: Integer;
  Input, Output: PByteArray;
begin
  Input := PByteArray(pInput); Output := PByteArray(pOutput);
  iptr := 0; optr := 0;
  for I := 1 to (Size div 3) do begin
    Output^[optr + 0] := B64[Input^[iptr] shr 2];
    Output^[optr + 1] := B64[((Input^[iptr] and 3) shl 4) + (Input^[iptr + 1] shr 4)];
    Output^[optr + 2] := B64[((Input^[iptr + 1] and 15) shl 2) + (Input^[iptr + 2] shr 6)];
    Output^[optr + 3] := B64[Input^[iptr + 2] and 63];
    Inc(optr, 4); Inc(iptr, 3);
  end;
  case (Size mod 3) of
    1: begin
        Output^[optr + 0] := B64[Input^[iptr] shr 2];
        Output^[optr + 1] := B64[(Input^[iptr] and 3) shl 4];
        Output^[optr + 2] := Byte('=');
        Output^[optr + 3] := Byte('=');
      end;
    2: begin
        Output^[optr + 0] := B64[Input^[iptr] shr 2];
        Output^[optr + 1] := B64[((Input^[iptr] and 3) shl 4) + (Input^[iptr + 1] shr 4)];
        Output^[optr + 2] := B64[(Input^[iptr + 1] and 15) shl 2];
        Output^[optr + 3] := Byte('=');
      end;
  end;
  Result := ((Size + 2) div 3) * 4;
end;

function Base64EncodeStr(const Value: string): string;
begin
  setlength(Result, ((Length(Value) + 2) div 3) * 4);
  Base64Encode(@Value[1], @Result[1], Length(Value));
end;

function Base64Decode(pInput: Pointer; pOutput: Pointer; Size: LongInt): LongInt;
var
  I, J, iptr, optr: Integer;
  temp: array[0..3] of Byte;
  Input, Output: PByteArray;
begin
  Input := PByteArray(pInput); Output := PByteArray(pOutput);
  iptr := 0; optr := 0;
  Result := 0;
  for I := 1 to (Size div 4) do begin
    for J := 0 to 3 do begin
      case Input^[iptr] of
        65..90: temp[J] := Input^[iptr] - Ord('A');
        97..122: temp[J] := Input^[iptr] - Ord('a') + 26;
        48..57: temp[J] := Input^[iptr] - Ord('0') + 52;
        43: temp[J] := 62;
        47: temp[J] := 63;
        61: temp[J] := $FF;
      end;
      Inc(iptr);
    end;
    Output^[optr] := (temp[0] shl 2) or (temp[1] shr 4);
    Result := optr + 1;
    if (temp[2] <> $FF) and (temp[3] = $FF) then begin//数组越界
      Output^[optr + 1] := (temp[1] shl 4) or (temp[2] shr 2);
      Result := optr + 2;
      Inc(optr)
    end else if (temp[2] <> $FF) then begin//数组越界
      Output^[optr + 1] := (temp[1] shl 4) or (temp[2] shr 2);
      Output^[optr + 2] := (temp[2] shl 6) or temp[3];
      Result := optr + 3;
      Inc(optr, 2);
    end;
    Inc(optr);
  end;
end;

function Base64DecodeStr(const Value: string): string;
begin
  setlength(Result, (Length(Value) div 4) * 3);
  setlength(Result, Base64Decode(@Value[1], @Result[1], Length(Value)));
end;

function ReverseStr(SourceStr: string): string;
var
  Counter: Integer;
begin
  Result := '';
  for Counter := 1 to Length(SourceStr) do
    Result := SourceStr[Counter] + Result;
end;

{function Encry(Src, Key: string): string;
var
  sSrc, sKey: string;
begin
  EnterCriticalSection(CSEncode);
  try
    if Key = '' then sKey := IntToStr(240621028)
    else sKey := Key;
    sSrc := EncryStrHex(Src, sKey);
    Result := ReverseStr(sSrc);
  finally
    LeaveCriticalSection(CSEncode);
  end;
end;

function Decry(Src, Key: string): string;
var
  sSrc, sKey: string;
begin
  EnterCriticalSection(CSEncode);
  try
    try
      if Key = '' then sKey := IntToStr(240621028)
      else sKey := Key;
      sSrc := ReverseStr(Src);
      Result := DecryStrHex(sSrc, sKey);
    except
      Result := '';
    end;
  finally
    LeaveCriticalSection(CSEncode);
  end;
end;}

{function Chinese2UniCode(AiChinese: string): Integer;
var
  Ch, cl: string[2];
  A: array[1..2] of Char;
begin
  StringToWideChar(Copy(AiChinese, 1, 2), @(A[1]), 2);
  Ch := IntToHex(Integer(A[2]), 2);
  cl := IntToHex(Integer(A[1]), 2);
  Result := StrToInt('$' + Ch + cl);
end;}
function Chinese2UniCode(AiChinese: string): Integer;
var
  Ch, cl: string[2];
  A: array[1..2] of Char;
begin
  SetMultiByteConversionCodePage(GB2312_CHARSET);  //设置字符集GB2312_CHARSET 兼容WIN7 2010810
  StringToWideChar(Copy(AiChinese, 1, 2), @(A[1]), 2);
  SetMultiByteConversionCodePage(GetACP);   //设置字符集系统默认 兼容WIN7 2010810
  Ch := IntToHex(Integer(A[2]), 2);
  cl := IntToHex(Integer(A[1]), 2);
  Result := StrToInt('$' + Ch + cl);
end;

function GetUniCode(msg: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 1 to Length(msg) do begin
    Result := Result + Chinese2UniCode(msg[I]) * I;
  end;
end;

function PowMod(base: Int64; pow: Int64; n: Int64): Int64;
var
  A, b, c: Int64;
begin
  A := base;
  b := pow;
  c := 1;
  while (b > 0) do begin
    while (not ((b and 1) > 0)) do begin
      b := b shr 1;
      A := A * A mod n;
    end;
    Dec(b);
    c := A * c mod n;
  end;
  Result := c;
end;
//RSA的加密和解密函数，等价于(m^e) mod n（即m的e次幂对n求余）
function Encrypt_Decrypt(m: Int64; E: Int64 = $2C86F9; n: Int64 = $69AAA0E3): Integer;
var
  A, b, c: Int64;
//  nN: Integer;
const
  nNumber = 100000;
  MaxValue = 1400000000;
  MinValue = 1299999999;
  function GetInteger(n: Int64): Int64;
  var
    D: Int64;
  begin
    D := n;
    while D > MaxValue do D := D - nNumber;
    while D < MinValue do D := D + nNumber;
    if D = MinValue then D := D + m;
    if D = MaxValue then D := D - m;
    Result := D;
  end;
begin
  EnterCriticalSection(CSEncode);
  try
    A := m;
    b := E;
    c := 1;
    while b <> 0 do
      if (b mod 2) = 0
        then begin
        b := b div 2;
        A := (A * A) mod n;
      end
      else begin
        b := b - 1;
        c := (A * c) mod n;
      end;
    while (c < MinValue) or (c > MaxValue) do c := GetInteger(c);
    Result := c;
  finally
    LeaveCriticalSection(CSEncode);
  end;
end;

function DecodeString_3des(Source, Key: string): string;
var
  DesDecode: TDCP_3des;
  Str: string;
begin
  try
    Result := '';
    DesDecode := TDCP_3des.Create(nil);
    DesDecode.InitStr(Key);
    DesDecode.Reset;
    Str := DesDecode.DecryptString(Source);
    DesDecode.Reset;
    Result := Str;
    DesDecode.Free;
  except
    Result := '';
  end;
end;

function EncodeString_3des(Source, Key: string): string;
var
  DesEncode: TDCP_3des;
  Str: string;
begin
  try
    Result := '';
    DesEncode := TDCP_3des.Create(nil);
    DesEncode.InitStr(Key);
    DesEncode.Reset;
    Str := DesEncode.EncryptString(Source);
    DesEncode.Reset;
    Result := Str;
    DesEncode.Free;
  except
    Result := '';
  end;
end;

function Encode(Src: string; var Dest: string): Boolean;
var
  StringInfo: TStringInfo;
  sDest: string;
begin
//  Result := False;
  Dest := '';
  FillChar(StringInfo, SizeOf(TStringInfo), 0);
  StringInfo.btLength := Length(Src);
  StringInfo.nUniCode := GetUniCode(Src);
  FillChar(StringInfo.sString, SizeOf(StringInfo.sString), 0);
  Move(Src[1], StringInfo.sString, StringInfo.btLength);
  setlength(sDest, SizeOf(Byte) + SizeOf(Integer) + StringInfo.btLength);
  Move(StringInfo, sDest[1], SizeOf(Byte) + SizeOf(Integer) + StringInfo.btLength);
  Dest := ReverseStr(EncryStrHex(sDest, IntToStr(398432431{240621028})));
  Result := True;
end;

function Decode(Src: string; var Dest: string): Boolean;
var
  StringInfo: TStringInfo;
  sDest: string;
  sSrc: string;
begin
  Result := False;
  Dest := '';
  sDest := ReverseStr(Trim(Src));
  try
    sDest := DecryStrHex(sDest, IntToStr(398432431{240621028}));
  except
    Exit;
  end;
  FillChar(StringInfo, SizeOf(TStringInfo), 0);
  Move(sDest[1], StringInfo, Length(sDest));
  sSrc := StrPas(@StringInfo.sString);
  if (GetUniCode(sSrc) = StringInfo.nUniCode) and (Length(sSrc) = StringInfo.btLength) then begin
    Dest := sSrc;
    Result := True;
  end;
end;

function DecryptString(Src: string): string;
begin
  Result := ReverseStr(Base64DecodeStr(Src));
end;

function EncryptString(Src: string): string;
begin
  Result := Base64EncodeStr(ReverseStr(Src));
end;

function EncryptBuffer(Buf: PChar; bufsize: Integer): string;
var
  Src: string;
begin
  setlength(Src, bufsize + 1);
  Move(Buf^, Src[1], bufsize + 1);
  Result := EncryptString(Src);
end;

procedure DecryptBuffer(Src: string; Buf: PChar; bufsize: Integer);
var
  Dest: string;
begin
  Dest := DecryptString(Src);
  if Dest <> '' then
    Move(Dest[1], Buf^, bufsize);
end;


initialization
  begin
    InitializeCriticalSection(CSEncode);
  end;
finalization
  begin
    DeleteCriticalSection(CSEncode);
  end;
end.

