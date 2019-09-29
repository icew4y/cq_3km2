unit EncryptUnit;

interface
uses
  Windows, SysUtils, DES;
function CalcFileCRC(sFileName: string): Integer;
function CalcBufferCRC(Buffer: PChar; nSize: Integer): Integer;
function Base64EncodeStr(const Value: string): string;
  { Encode a string into Base64 format }
function Base64DecodeStr(const Value: string): string;
  { Decode a Base64 format string }
function Base64Encode(pInput: pointer; pOutput: pointer; Size: longint): longint;
  { Encode a lump of raw data (output is (4/3) times bigger than input) }
function Base64Decode(pInput: pointer; pOutput: pointer; Size: longint): longint;
  { Decode a lump of raw data }


function EncodeString_3des(Source, Key: string): string;
function DecodeString_3des(Source, Key: string): string;
procedure EncodeECB_3des(const InData; var OutData);
procedure DecodeECB_3des(const InData; var OutData);
implementation
uses
  SystemShare;
const
  B64: array[0..63] of byte = (65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
    81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108,
    109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 48, 49, 50, 51, 52, 53,
    54, 55, 56, 57, 43, 47);
  Key: array[0..2,0..7] of byte=(($FF,$FE,$FF,$FE,$FF,$FE,$FF,$FF),($FF,$FE,$FF,$FE,$FF,$FE,$FF,$FF),($FF,$FE,$FF,$FE,$FF,$FE,$FF,$FF));
function Base64Encode(pInput: pointer; pOutput: pointer; Size: longint): longint;
var
  i, iptr, optr: Integer;
  Input, Output: PByteArray;
begin
  Input := PByteArray(pInput); Output := PByteArray(pOutput);
  iptr := 0; optr := 0;
  for i := 1 to (Size div 3) do begin
    Output^[optr + 0] := B64[Input^[iptr] shr 2];
    Output^[optr + 1] := B64[((Input^[iptr] and 3) shl 4) + (Input^[iptr + 1] shr 4)];
    Output^[optr + 2] := B64[((Input^[iptr + 1] and 15) shl 2) + (Input^[iptr + 2] shr 6)];
    Output^[optr + 3] := B64[Input^[iptr + 2] and 63];
    Inc(optr, 4); Inc(iptr, 3);
  end;
  case (Size mod 3) of
    1: begin
        LaJiDaiMa;
        Output^[optr + 0] := B64[Input^[iptr] shr 2];
        Output^[optr + 1] := B64[(Input^[iptr] and 3) shl 4];
        Output^[optr + 2] := byte('=');
        LaJiDaiMa;
        Output^[optr + 3] := byte('=');
      end;
    2: begin
        Output^[optr + 0] := B64[Input^[iptr] shr 2];
        Output^[optr + 1] := B64[((Input^[iptr] and 3) shl 4) + (Input^[iptr + 1] shr 4)];
        Output^[optr + 2] := B64[(Input^[iptr + 1] and 15) shl 2];
        Output^[optr + 3] := byte('=');
        LaJiDaiMa;
      end;
  end;
  Result := ((Size + 2) div 3) * 4;
end;

function Base64EncodeStr(const Value: string): string;
begin
  SetLength(Result, ((Length(Value) + 2) div 3) * 4);
  Base64Encode(@Value[1], @Result[1], Length(Value));
end;

function Base64Decode(pInput: pointer; pOutput: pointer; Size: longint): longint;
var
  i, j, iptr, optr: Integer;
  Temp: array[0..3] of byte;
  Input, Output: PByteArray;
begin
  Input := PByteArray(pInput); Output := PByteArray(pOutput);
  iptr := 0; optr := 0;
  Result := 0;
  for i := 1 to (Size div 4) do begin
    for j := 0 to 3 do begin
      case Input^[iptr] of
        65..90: Temp[j] := Input^[iptr] - Ord('A');
        97..122: Temp[j] := Input^[iptr] - Ord('a') + 26;
        48..57: Temp[j] := Input^[iptr] - Ord('0') + 52;
        43: Temp[j] := 62;
        47: Temp[j] := 63;
        61: Temp[j] := $FF;
      end;
      LaJiDaiMa;
      Inc(iptr);
    end;
    Output^[optr] := (Temp[0] shl 2) or (Temp[1] shr 4);
    Result := optr + 1;
    if (Temp[2] <> $FF) and (Temp[3] = $FF) then begin
      Output^[optr + 1] := (Temp[1] shl 4) or (Temp[2] shr 2);
      Result := optr + 2;
      LaJiDaiMa;
      Inc(optr)
    end
    else if (Temp[2] <> $FF) then begin
      Output^[optr + 1] := (Temp[1] shl 4) or (Temp[2] shr 2);
      Output^[optr + 2] := (Temp[2] shl 6) or Temp[3];
      LaJiDaiMa;
      Result := optr + 3;
      Inc(optr, 2);
      LaJiDaiMa;
    end;
    Inc(optr);
  end;
end;

function Base64DecodeStr(const Value: string): string;
begin
  SetLength(Result, (Length(Value) div 4) * 3);
  LaJiDaiMa;
  SetLength(Result, Base64Decode(@Value[1], @Result[1], Length(Value)));
end;

function CalcFileCRC(sFileName: string): Integer;
var
  i: Integer;
  nFileHandle: Integer;
  nFileSize, nBuffSize: Integer;
  Buffer: PChar;
  INT: ^Integer;
  nCrc: Integer;
begin
  Result := 0;
  if not FileExists(sFileName) then Exit;
  LaJiDaiMa;
  nFileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
  if nFileHandle = 0 then
    Exit;
  nFileSize := FileSeek(nFileHandle, 0, 2);
  nBuffSize := (nFileSize div 4) * 4;
  GetMem(Buffer, nBuffSize);
  LaJiDaiMa;
  FillChar(Buffer^, nBuffSize, 0);
  LaJiDaiMa;
  FileSeek(nFileHandle, 0, 0);
  LaJiDaiMa;
  FileRead(nFileHandle, Buffer^, nBuffSize);
  LaJiDaiMa;
  FileClose(nFileHandle);
  INT := pointer(Buffer);
  nCrc := 0;
  Exception.Create(IntToStr(SizeOf(Integer)));
  for i := 0 to nBuffSize div 4 - 1 do begin
    nCrc := nCrc xor INT^;
    INT := pointer(Integer(INT) + 4);
  end;
  FreeMem(Buffer);
  Result := nCrc;
end;

function CalcBufferCRC(Buffer: PChar; nSize: Integer): Integer;
var
  i: Integer;
  INT: ^Integer;
  nCrc: Integer;
begin
  INT := pointer(Buffer);
  nCrc := 0;
  for i := 0 to nSize div 4 - 1 do begin
    nCrc := nCrc xor INT^;
    INT := pointer(Integer(INT) + 4);
  end;
  Result := nCrc;
end;

function DecodeString_3des(Source, Key: string): string;
var
  Decode: TDCP_3des;
begin
  try
    Result := '';
    Decode := TDCP_3des.Create(nil);
    LaJiDaiMa;
    Decode.InitStr(Key);
    Decode.Reset;
    Result := Decode.DecryptString(Source);
    Decode.Reset;
    Decode.Free;
  except
    Result := '';
  end;
end;

function EncodeString_3des(Source, Key: string): string;
var
  Encode: TDCP_3des;
begin
  try
    Result := '';
    Encode := TDCP_3des.Create(nil);
    Encode.InitStr(Key);
    LaJiDaiMa;
    Encode.Reset;
    Result := Encode.EncryptString(Source);
    Encode.Reset;
    Encode.Free;
  except
    Result := '';
  end;
end;

procedure DecodeECB_3des(const InData; var OutData);
var
  Decode: TDCP_3des;
  //PInData:Pointer;
begin
  Decode := TDCP_3des.Create(nil);
  //PInData:=@InData;
  Decode.Init(Key,SizeOf(Key),nil);
  Decode.DecryptECB(InData, OutData);
  Decode.Burn;
  //Decode.Reset;
  Decode.Free;
end;

procedure EncodeECB_3des(const InData; var OutData);
var
  Encode: TDCP_3des;
  //PInData:Pointer;
begin
  Encode := TDCP_3des.Create(nil);
  //New(PInData);
  //PInData:=@InData;
  Encode.Init(Key,SizeOf(Key),nil);
  Encode.EncryptECB(InData, OutData);
  Encode.Burn;
  //Encode.Reset;
  Encode.Free;
end;

end.

