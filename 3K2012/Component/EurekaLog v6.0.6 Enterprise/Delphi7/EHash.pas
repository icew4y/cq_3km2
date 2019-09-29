{************************************************}
{                                                }
{              EHash EurekaLog v 6.x             }
{               Hash Unit - EHashes              }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EHash;

{$I Exceptions.inc}

interface

uses Windows;

function GetCRC32(Buf: Pointer; Size: DWord): DWord;
function GetCRC16(const Src: string): Word;
procedure GetMD5(var Digest; const Buffer; Size: DWord);

implementation

Const
  Crc16Tab : array[0..255] of Word =
    ($0000, $1021, $2042, $3063, $4084, $50a5, $60c6, $70e7,
    $8108, $9129, $a14a, $b16b, $c18c, $d1ad, $e1ce, $f1ef,
    $1231, $0210, $3273, $2252, $52b5, $4294, $72f7, $62d6,
    $9339, $8318, $b37b, $a35a, $d3bd, $c39c, $f3ff, $e3de,
    $2462, $3443, $0420, $1401, $64e6, $74c7, $44a4, $5485,
    $a56a, $b54b, $8528, $9509, $e5ee, $f5cf, $c5ac, $d58d,
    $3653, $2672, $1611, $0630, $76d7, $66f6, $5695, $46b4,
    $b75b, $a77a, $9719, $8738, $f7df, $e7fe, $d79d, $c7bc,
    $48c4, $58e5, $6886, $78a7, $0840, $1861, $2802, $3823,
    $c9cc, $d9ed, $e98e, $f9af, $8948, $9969, $a90a, $b92b,
    $5af5, $4ad4, $7ab7, $6a96, $1a71, $0a50, $3a33, $2a12,
    $dbfd, $cbdc, $fbbf, $eb9e, $9b79, $8b58, $bb3b, $ab1a,
    $6ca6, $7c87, $4ce4, $5cc5, $2c22, $3c03, $0c60, $1c41,
    $edae, $fd8f, $cdec, $ddcd, $ad2a, $bd0b, $8d68, $9d49,
    $7e97, $6eb6, $5ed5, $4ef4, $3e13, $2e32, $1e51, $0e70,
    $ff9f, $efbe, $dfdd, $cffc, $bf1b, $af3a, $9f59, $8f78,
    $9188, $81a9, $b1ca, $a1eb, $d10c, $c12d, $f14e, $e16f,
    $1080, $00a1, $30c2, $20e3, $5004, $4025, $7046, $6067,
    $83b9, $9398, $a3fb, $b3da, $c33d, $d31c, $e37f, $f35e,
    $02b1, $1290, $22f3, $32d2, $4235, $5214, $6277, $7256,
    $b5ea, $a5cb, $95a8, $8589, $f56e, $e54f, $d52c, $c50d,
    $34e2, $24c3, $14a0, $0481, $7466, $6447, $5424, $4405,
    $a7db, $b7fa, $8799, $97b8, $e75f, $f77e, $c71d, $d73c,
    $26d3, $36f2, $0691, $16b0, $6657, $7676, $4615, $5634,
    $d94c, $c96d, $f90e, $e92f, $99c8, $89e9, $b98a, $a9ab,
    $5844, $4865, $7806, $6827, $18c0, $08e1, $3882, $28a3,
    $cb7d, $db5c, $eb3f, $fb1e, $8bf9, $9bd8, $abbb, $bb9a,
    $4a75, $5a54, $6a37, $7a16, $0af1, $1ad0, $2ab3, $3a92,
    $fd2e, $ed0f, $dd6c, $cd4d, $bdaa, $ad8b, $9de8, $8dc9,
    $7c26, $6c07, $5c64, $4c45, $3ca2, $2c83, $1ce0, $0cc1,
    $ef1f, $ff3e, $cf5d, $df7c, $af9b, $bfba, $8fd9, $9ff8,
    $6e17, $7e36, $4e55, $5e74, $2e93, $3eb2, $0ed1, $1ef0);

var
  crc_table: array [0..255] of DWord; // Table of CRCs of all 8-bit messages.
  crc_table_computed: Boolean = False; // Flag: has the table been computed? Initially "false.

// Make the table for a fast CRC.
procedure make_crc_table;
var
 c    : DWord;
 n,k  : Integer;
 poly : DWord; { polynomial exclusive-or pattern }

const
 { terms of polynomial defining this crc (except x^32): }
 p: array [0..13] of Byte = (0,1,2,4,5,7,8,10,11,12,16,22,23,26);

begin
  { make exclusive-or pattern from polynomial ($EDB88320) }
  poly := 0;
  for n := 0 to ((SizeOf(p) div SizeOf(Byte)) - 1) do
    poly := (poly or (DWord(1) shl (31 - p[n])));

  for n := 0 to 255 do
  begin
    c := DWord(n);
    for k := 0 to 7 do
    begin
      if ((c and 1) <> 0) then c := (poly xor (c shr 1))
      else c := (c shr 1);
    end;
    crc_table[n] := c;
  end;
  crc_table_computed := True;
end;

function GetCRC32(Buf: Pointer; Size: DWord): DWord;
var
  crc: DWord;
begin
  if (buf = nil) then Result := 0
  else
  begin
    if (not crc_table_computed) then make_crc_table;
    crc := (0 xor uLong($ffffffff));
    repeat
      crc := crc_table[(crc xor PByte(Buf)^) and $ff] xor (crc shr 8);
      Inc(PByte(Buf));
      Dec(Size);
    until (Size = 0);
    Result := (crc xor uLong($ffffffff));
  end;
end;

function GetCRC16(const Src: string): Word;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(src) do
    Result := (Crc16Tab[((Result shr 8) xor Ord(Src[i])) and $ff] xor ((Result shl 8) and $FFFF));
End;

procedure GetMD5(var Digest; const Buffer; Size: DWord);
var
  LenHi, LenLo, Index: DWord;
  CurrentHash: array[0..3] of DWord;
  HashBuffer: array[0..63] of Byte;
  PBuf: ^Byte;

  procedure Compress;
  var
    Data: array[0..15] of DWord;
    A, B, C, D: DWord;

    function LRot32(a, b: DWord): DWord;
    begin
      Result := (a shl b) or (a shr (32 - b));
    end;

  begin
    Move(HashBuffer, Data, Sizeof(Data));
    A := CurrentHash[0];
    B := CurrentHash[1];
    C := CurrentHash[2];
    D := CurrentHash[3];

    A := B + LRot32(A + (D xor (B and (C xor D))) + Data[0] + $D76AA478, 7);
    D := A + LRot32(D + (C xor (A and (B xor C))) + Data[1] + $E8C7B756, 12);
    C := D + LRot32(C + (B xor (D and (A xor B))) + Data[2] + $242070DB, 17);
    B := C + LRot32(B + (A xor (C and (D xor A))) + Data[3] + $C1BDCEEE, 22);
    A := B + LRot32(A + (D xor (B and (C xor D))) + Data[4] + $F57C0FAF, 7);
    D := A + LRot32(D + (C xor (A and (B xor C))) + Data[5] + $4787C62A, 12);
    C := D + LRot32(C + (B xor (D and (A xor B))) + Data[6] + $A8304613, 17);
    B := C + LRot32(B + (A xor (C and (D xor A))) + Data[7] + $FD469501, 22);
    A := B + LRot32(A + (D xor (B and (C xor D))) + Data[8] + $698098D8, 7);
    D := A + LRot32(D + (C xor (A and (B xor C))) + Data[9] + $8B44F7AF, 12);
    C := D + LRot32(C + (B xor (D and (A xor B))) + Data[10] + $FFFF5BB1, 17);
    B := C + LRot32(B + (A xor (C and (D xor A))) + Data[11] + $895CD7BE, 22);
    A := B + LRot32(A + (D xor (B and (C xor D))) + Data[12] + $6B901122, 7);
    D := A + LRot32(D + (C xor (A and (B xor C))) + Data[13] + $FD987193, 12);
    C := D + LRot32(C + (B xor (D and (A xor B))) + Data[14] + $A679438E, 17);
    B := C + LRot32(B + (A xor (C and (D xor A))) + Data[15] + $49B40821, 22);

    A := B + LRot32(A + (C xor (D and (B xor C))) + Data[1] + $F61E2562, 5);
    D := A + LRot32(D + (B xor (C and (A xor B))) + Data[6] + $C040B340, 9);
    C := D + LRot32(C + (A xor (B and (D xor A))) + Data[11] + $265E5A51, 14);
    B := C + LRot32(B + (D xor (A and (C xor D))) + Data[0] + $E9B6C7AA, 20);
    A := B + LRot32(A + (C xor (D and (B xor C))) + Data[5] + $D62F105D, 5);
    D := A + LRot32(D + (B xor (C and (A xor B))) + Data[10] + $02441453, 9);
    C := D + LRot32(C + (A xor (B and (D xor A))) + Data[15] + $D8A1E681, 14);
    B := C + LRot32(B + (D xor (A and (C xor D))) + Data[4] + $E7D3FBC8, 20);
    A := B + LRot32(A + (C xor (D and (B xor C))) + Data[9] + $21E1CDE6, 5);
    D := A + LRot32(D + (B xor (C and (A xor B))) + Data[14] + $C33707D6, 9);
    C := D + LRot32(C + (A xor (B and (D xor A))) + Data[3] + $F4D50D87, 14);
    B := C + LRot32(B + (D xor (A and (C xor D))) + Data[8] + $455A14ED, 20);
    A := B + LRot32(A + (C xor (D and (B xor C))) + Data[13] + $A9E3E905, 5);
    D := A + LRot32(D + (B xor (C and (A xor B))) + Data[2] + $FCEFA3F8, 9);
    C := D + LRot32(C + (A xor (B and (D xor A))) + Data[7] + $676F02D9, 14);
    B := C + LRot32(B + (D xor (A and (C xor D))) + Data[12] + $8D2A4C8A, 20);

    A := B + LRot32(A + (B xor C xor D) + Data[5] + $FFFA3942, 4);
    D := A + LRot32(D + (A xor B xor C) + Data[8] + $8771F681, 11);
    C := D + LRot32(C + (D xor A xor B) + Data[11] + $6D9D6122, 16);
    B := C + LRot32(B + (C xor D xor A) + Data[14] + $FDE5380C, 23);
    A := B + LRot32(A + (B xor C xor D) + Data[1] + $A4BEEA44, 4);
    D := A + LRot32(D + (A xor B xor C) + Data[4] + $4BDECFA9, 11);
    C := D + LRot32(C + (D xor A xor B) + Data[7] + $F6BB4B60, 16);
    B := C + LRot32(B + (C xor D xor A) + Data[10] + $BEBFBC70, 23);
    A := B + LRot32(A + (B xor C xor D) + Data[13] + $289B7EC6, 4);
    D := A + LRot32(D + (A xor B xor C) + Data[0] + $EAA127FA, 11);
    C := D + LRot32(C + (D xor A xor B) + Data[3] + $D4EF3085, 16);
    B := C + LRot32(B + (C xor D xor A) + Data[6] + $04881D05, 23);
    A := B + LRot32(A + (B xor C xor D) + Data[9] + $D9D4D039, 4);
    D := A + LRot32(D + (A xor B xor C) + Data[12] + $E6DB99E5, 11);
    C := D + LRot32(C + (D xor A xor B) + Data[15] + $1FA27CF8, 16);
    B := C + LRot32(B + (C xor D xor A) + Data[2] + $C4AC5665, 23);

    A := B + LRot32(A + (C xor (B or (not D))) + Data[0] + $F4292244, 6);
    D := A + LRot32(D + (B xor (A or (not C))) + Data[7] + $432AFF97, 10);
    C := D + LRot32(C + (A xor (D or (not B))) + Data[14] + $AB9423A7, 15);
    B := C + LRot32(B + (D xor (C or (not A))) + Data[5] + $FC93A039, 21);
    A := B + LRot32(A + (C xor (B or (not D))) + Data[12] + $655B59C3, 6);
    D := A + LRot32(D + (B xor (A or (not C))) + Data[3] + $8F0CCC92, 10);
    C := D + LRot32(C + (A xor (D or (not B))) + Data[10] + $FFEFF47D, 15);
    B := C + LRot32(B + (D xor (C or (not A))) + Data[1] + $85845DD1, 21);
    A := B + LRot32(A + (C xor (B or (not D))) + Data[8] + $6FA87E4F, 6);
    D := A + LRot32(D + (B xor (A or (not C))) + Data[15] + $FE2CE6E0, 10);
    C := D + LRot32(C + (A xor (D or (not B))) + Data[6] + $A3014314, 15);
    B := C + LRot32(B + (D xor (C or (not A))) + Data[13] + $4E0811A1, 21);
    A := B + LRot32(A + (C xor (B or (not D))) + Data[4] + $F7537E82, 6);
    D := A + LRot32(D + (B xor (A or (not C))) + Data[11] + $BD3AF235, 10);
    C := D + LRot32(C + (A xor (D or (not B))) + Data[2] + $2AD7D2BB, 15);
    B := C + LRot32(B + (D xor (C or (not A))) + Data[9] + $EB86D391, 21);

    Inc(CurrentHash[0], A);
    Inc(CurrentHash[1], B);
    Inc(CurrentHash[2], C);
    Inc(CurrentHash[3], D);
    Index := 0;
    FillChar(HashBuffer, Sizeof(HashBuffer), 0);
  end;

begin
  LenHi := 0;
  LenLo := 0;
  Index := 0;
  FillChar(HashBuffer, Sizeof(HashBuffer), 0);
  FillChar(CurrentHash, Sizeof(CurrentHash), 0);

  CurrentHash[0] := $67452301;
  CurrentHash[1] := $EFCDAB89;
  CurrentHash[2] := $98BADCFE;
  CurrentHash[3] := $10325476;

  Inc(LenHi, Size shr 29);
  Inc(LenLo, Size * 8);
  if (LenLo < (Size * 8)) then Inc(LenHi);

  PBuf := @Buffer;
  while (Size > 0) do
  begin
    if (Sizeof(HashBuffer) - Index) <= DWord(Size) then
    begin
      Move(PBuf^, HashBuffer[Index], Sizeof(HashBuffer) - Index);
      Dec(Size, Sizeof(HashBuffer) - Index);
      Inc(PBuf, Sizeof(HashBuffer) - Index);
      Compress;
    end
    else
    begin
      Move(PBuf^, HashBuffer[Index], Size);
      Inc(Index, Size);
      Size := 0;
    end;
  end;
  HashBuffer[Index] := $80;
  if (Index >= 56) then Compress;
  PDWord(@HashBuffer[56])^ := LenLo;
  PDWord(@HashBuffer[60])^ := LenHi;
  Compress;
  Move(CurrentHash, Digest, Sizeof(CurrentHash));
end;

end.
