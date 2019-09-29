unit EDcode;

interface

uses
  Windows, SysUtils, DESTR, Classes, DES;
function EncodeString(Str: string): string;
function DecodeString(Str: string): string;
function EncodeBuffer(buf: PChar; bufsize: Integer): string;
procedure DecodeBuffer(Src: string; buf: PChar; bufsize: Integer);
function EncodeBuffer_(buf: PChar; bufsize: Integer): string;
procedure DecodeBuffer_(Src: string; buf: PChar; bufsize: Integer);

procedure Decode6BitBuf(sSource: PChar; pBuf: PChar; nSrcLen, nBufLen: Integer);
procedure Encode6BitBuf(pSrc, pDest: PChar; nSrcLen, nDestLen: Integer);
function Decry(Src, Key: string): string;
function Encry(Src, Key: string): string;

function Encrypt_Decrypt(m: Int64; e: Int64 = $2C86F9; n: Int64 = $69AAA0E3): Integer;
function Chinese2UniCode(AiChinese: string): Integer;
function GetUniCode(Msg: string): Integer;
function EncodeInfo(smsg: string): string;
function DecodeInfo(smsg: string): string;
function Str_ToInt(Str: string; Def: Longint): Longint;
implementation
const
  BUFFERSIZE = 10000;
var
  CSEncode: TRTLCriticalSection;
function Str_ToInt(Str: string; Def: Longint): Longint;
begin
  Result := Def;
  if Str <> '' then begin
    if ((word(Str[1]) >= word('0')) and (word(Str[1]) <= word('9'))) or
      (Str[1] = '+') or (Str[1] = '-') then try
      Result := StrToInt64(Str);
    except
    end;
  end;
end;
procedure Encode6BitBuf(pSrc, pDest: PChar; nSrcLen, nDestLen: Integer);
var
  i, nRestCount, nDestPos: Integer;
  btMade, btCh, btRest: Byte;
begin
  nRestCount := 0;
  btRest := 0;
  nDestPos := 0;
  for i := 0 to nSrcLen - 1 do begin
    if nDestPos >= nDestLen then break;
    btCh := Byte(pSrc[i]);
    btMade := Byte((btRest or (btCh shr (2 + nRestCount))) and $3F);
    btRest := Byte(((btCh shl (8 - (2 + nRestCount))) shr 2) and $3F);
    Inc(nRestCount, 2);

    if nRestCount < 6 then begin
      pDest[nDestPos] := Char(btMade + $3C);
      Inc(nDestPos);
    end else begin
      if nDestPos < nDestLen - 1 then begin
        pDest[nDestPos] := Char(btMade + $3C);
        pDest[nDestPos + 1] := Char(btRest + $3C);
        Inc(nDestPos, 2);
      end else begin
        pDest[nDestPos] := Char(btMade + $3C);
        Inc(nDestPos);
      end;
      nRestCount := 0;
      btRest := 0;
    end;
  end;
  if nRestCount > 0 then begin
    pDest[nDestPos] := Char(btRest + $3C);
    Inc(nDestPos);
  end;
  pDest[nDestPos] := #0;
end;

procedure Decode6BitBuf(sSource: PChar; pBuf: PChar; nSrcLen, nBufLen: Integer);
const
  Masks: array[2..6] of Byte = ($FC, $F8, $F0, $E0, $C0);
  //($FE, $FC, $F8, $F0, $E0, $C0, $80, $00);
var
  i, {nLen,} nBitPos, nMadeBit, nBufPos: Integer;
  btCh, btTmp, btByte: Byte;
begin
  //  nLen:= Length (sSource);
  nBitPos := 2;
  nMadeBit := 0;
  nBufPos := 0;
  btTmp := 0;
  for i := 0 to nSrcLen - 1 do begin
    if Integer(sSource[i]) - $3C >= 0 then
      btCh := Byte(sSource[i]) - $3C
    else begin
      nBufPos := 0;
      break;
    end;
    if nBufPos >= nBufLen then break;
    if (nMadeBit + 6) >= 8 then begin
      btByte := Byte(btTmp or ((btCh and $3F) shr (6 - nBitPos)));
      pBuf[nBufPos] := Char(btByte);
      Inc(nBufPos);
      nMadeBit := 0;
      if nBitPos < 6 then Inc(nBitPos, 2)
      else begin
        nBitPos := 2;
        continue;
      end;
    end;
    btTmp := Byte(Byte(btCh shl nBitPos) and Masks[nBitPos]); // #### ##--
    Inc(nMadeBit, 8 - nBitPos);
  end;
  pBuf[nBufPos] := #0;
end;

function DecodeString(Str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  try
    EnterCriticalSection(CSEncode);
    Decode6BitBuf(PChar(Str), @EncBuf, Length(Str), Sizeof(EncBuf));
    Result := StrPas(EncBuf);
  finally
    LeaveCriticalSection(CSEncode);
  end;
end;

procedure DecodeBuffer(Src: string; buf: PChar; bufsize: Integer);
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  try
    EnterCriticalSection(CSEncode);
    Decode6BitBuf(PChar(Src), @EncBuf, Length(Src), Sizeof(EncBuf));
    Move(EncBuf, buf^, bufsize);
  finally
    LeaveCriticalSection(CSEncode);
  end;
end;

function EncodeString(Str: string): string;
var
  EncBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  try
    EnterCriticalSection(CSEncode);
    Encode6BitBuf(PChar(Str), @EncBuf, Length(Str), Sizeof(EncBuf));
    Result := StrPas(EncBuf);
  finally
    LeaveCriticalSection(CSEncode);
  end;
end;

function EncodeBuffer(buf: PChar; bufsize: Integer): string;
var
  EncBuf, TempBuf: array[0..BUFFERSIZE - 1] of Char;
begin
  try
    EnterCriticalSection(CSEncode);
    if bufsize < BUFFERSIZE then begin
      Move(buf^, TempBuf, bufsize);
      Encode6BitBuf(@TempBuf, @EncBuf, bufsize, Sizeof(EncBuf));
      Result := StrPas(EncBuf);
    end else Result := '';
  finally
    LeaveCriticalSection(CSEncode);
  end;
end;

function EncodeBuffer_(buf: PChar; bufsize: Integer): string;
var
  TempBuf: array[0..BUFFERSIZE - 1] of Char;
  sTemp: string;
begin
  SetLength(sTemp, bufsize);
  Move(buf^, sTemp[1], bufsize);
  Result := sTemp;
end;

procedure DecodeBuffer_(Src: string; buf: PChar; bufsize: Integer);
var
  sTemp: string;
begin
  Move(Src[1], buf^, bufsize);
end;

function ReverseStr(SourceStr: string): string;
var
  Counter: Integer;
begin
  Result := '';
  for Counter := 1 to Length(SourceStr) do
    Result := SourceStr[Counter] + Result;
end;

function Encry(Src, Key: string): string;
var
  sSrc, sKey: string;
begin
  EnterCriticalSection(CSEncode);
  try
    if Key = '' then sKey := IntToStr(398432431)
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
      if Key = '' then sKey := IntToStr(398432431)
      else sKey := Key;
      sSrc := ReverseStr(Src);
      Result := DecryStrHex(sSrc, sKey);
    except
      Result := '';
    end;
  finally
    LeaveCriticalSection(CSEncode);
  end;
end;

function Chinese2UniCode(AiChinese: string): Integer;
var
  ch, cl: string[2];
  a: array[1..2] of Char;
begin
  SetMultiByteConversionCodePage(GB2312_CHARSET);  //设置字符集GB2312_CHARSET 兼容WIN7 20110722
  StringToWideChar(Copy(AiChinese, 1, 2), @(A[1]), 2);
  SetMultiByteConversionCodePage(GetACP);   //设置字符集系统默认 兼容WIN7 20110722
  ch := IntToHex(Integer(a[2]), 2);
  cl := IntToHex(Integer(a[1]), 2);
  Result := StrToInt('$' + ch + cl);
end;

function GetUniCode(Msg: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 1 to Length(Msg) do begin
    Result := Result + Chinese2UniCode(Msg[i]) * i;
  end;
end;

function GetUniCodeNo(c: Char): Integer;
begin
  case c of
    '0': Result := 48;
    '1': Result := 49;
    '2': Result := 50;
    '3': Result := 51;
    '4': Result := 52;
    '5': Result := 53;
    '6': Result := 54;
    '7': Result := 55;
    '8': Result := 56;
    '9': Result := 57;
    'A': Result := 65;
    'B': Result := 66;
    'C': Result := 67;
    'D': Result := 68;
    'E': Result := 69;
    'F': Result := 70;
    'G': Result := 71;
    'H': Result := 72;
    'I': Result := 73;
    'J': Result := 74;
    'K': Result := 75;
    'L': Result := 76;
    'M': Result := 77;
    'N': Result := 78;
    'O': Result := 79;
    'P': Result := 80;
    'Q': Result := 81;
    'R': Result := 82;
    'S': Result := 83;
    'T': Result := 84;
    'U': Result := 85;
    'V': Result := 86;
    'W': Result := 87;
    'X': Result := 88;
    'Y': Result := 89;
    'Z': Result := 90;
  end;
end;

function PowMod(base: Int64; pow: Int64; n: Int64): Int64;
var
  a, b, c: Int64;
begin
  a := base;
  b := pow;
  c := 1;
  while (b > 0) do begin
    while (not ((b and 1) > 0)) do begin
      b := b shr 1;
      a := a * a mod n;
    end;
    Dec(b);
    c := a * c mod n;
  end;
  Result := c;
end;
//RSA的加密和解密函数，等价于(m^e) mod n（即m的e次幂对n求余）
function Encrypt_Decrypt(m: Int64; e: Int64 = $2C86F9; n: Int64 = $69AAA0E3): Integer;
var
  a, b, c: Int64;
  nn: Integer;
const
  nNumber = 100000;
  MaxValue = 1400000000;
  MinValue = 1299999999;
  function GetInteger(n: Int64): Int64;
  var
    d: Int64;
  begin
    d := n;
    while d > MaxValue do d := d - nNumber;
    while d < MinValue do d := d + nNumber;
    if d = MinValue then d := d + m;
    if d = MaxValue then d := d - m;
    Result := d;
  end;
begin
  EnterCriticalSection(CSEncode);
  try
    a := m;
    b := e;
    c := 1;
    while b <> 0 do
      if (b mod 2) = 0
        then begin
        b := b div 2;
        a := (a * a) mod n;
      end
      else begin
        b := b - 1;
        c := (a * c) mod n;
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

function DecodeInfo(smsg: string): string;
var
  i: Integer;
  sEncodeStr, sEncodeUniCode: string;
  nEncodeStr, nEncodeUniCode: Integer;
  Str, sDecodeStr, sDecodeUniCode: string;
begin
  Result := '';
  Str := DecodeString_3des(smsg, '');
  i := Pos('|', Str);
  if i <= 0 then Exit;
  sEncodeStr := Copy(Str, 1, i - 1);
  sEncodeUniCode := Copy(Str, i + 1, Length(Str) - i);
  sDecodeStr := DecodeString_3des(sEncodeStr, sEncodeUniCode);
  sDecodeUniCode := DecodeString(sEncodeUniCode);
  nEncodeUniCode := Str_ToInt(sDecodeUniCode, 0);
  nEncodeStr := GetUniCode(sDecodeStr);
  if nEncodeUniCode <> nEncodeStr then Exit;
  Result := sDecodeStr;
end;

function EncodeInfo(smsg: string): string;
var
  sEncodeStr, sEncodeUniCode: string;
  nEncodeStr: Integer;
begin
  nEncodeStr := GetUniCode(smsg);
  sEncodeUniCode := EncodeString(IntToStr(nEncodeStr));
  sEncodeStr := EncodeString_3des(smsg, sEncodeUniCode);
  Result := EncodeString_3des(sEncodeStr + '|' + sEncodeUniCode, '');
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

