{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{    Encryption/Decryption TEA Unit - EEncrypt   }
{                                                }
{  Copyright (c) 2001 - 2005 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EEncrypt;

{$I Exceptions.inc}

interface

uses Windows;

procedure InitKey(const Key: string);
procedure Encrypt(const InData; var Outdata; Size: DWord);
procedure Decrypt(const InData; var Outdata; Size: DWord);

implementation

uses EHash;

const
  Delta = $9E3779B9;
  Rounds = 32;

var
  CV: array[0..7] of Byte;
  KeyData: array[0..3] of DWord;

// Generic functions...
// -----------------------------------------------------------------------------

procedure XorBlock(var InData1, InData2; Size: DWord);
var
  n: DWord;
begin
  for n := 1 to Size do
    PByte(DWord(@InData1) + n - 1)^ := PByte(DWord(@InData1) + n - 1)^ xor
      PByte(DWord(@InData2) + n - 1)^;
end;

function SwapDWord(a: DWord): DWord;
begin
  Result := ((a and $FF) shl 24) or ((a and $FF00) shl 8) or
    ((a and $FF0000) shr 8) or ((a and $FF000000) shr 24);
end;

// -----------------------------------------------------------------------------

procedure TEA_Encrypt(const InData; var OutData);
var
  a, b, c, d, x, y, n, sum: DWord;
begin
  x := SwapDWord(PDWord(@InData)^);
  y := SwapDWord(PDWord(DWord(@InData) + 4)^);
  sum := 0;
  a := KeyData[0];
  b := KeyData[1];
  c := KeyData[2];
  d := KeyData[3];
  for n := 1 to Rounds do
  begin
    Inc(sum, Delta);
    Inc(x, (y shl 4) + (a xor y) + (sum xor (y shr 5)) + b);
    Inc(y, (x shl 4) + (c xor x) + (sum xor (x shr 5)) + d);
  end;
  PDWord(@OutData)^ := SwapDWord(x);
  PDWord(DWord(@OutData) + 4)^ := SwapDWord(y);
end;

procedure TEA_Decrypt(const InData; var OutData);
var
  a, b, c, d, x, y, n, sum: DWord;
begin
  x := SwapDWord(PDWord(@InData)^);
  y := SwapDWord(PDWord(DWord(@InData) + 4)^);
  sum := Delta shl 5;
  a := KeyData[0];
  b := KeyData[1];
  c := KeyData[2];
  d := KeyData[3];
  for n := 1 to Rounds do
  begin
    Dec(y, (x shl 4) + (c xor x) + (sum xor (x shr 5)) + d);
    Dec(x, (y shl 4) + (a xor y) + (sum xor (y shr 5)) + b);
    Dec(sum, Delta);
  end;
  PDWord(@OutData)^ := SwapDWord(x);
  PDWord(DWord(@OutData) + 4)^ := SwapDWord(y);
end;

procedure InitKey(const Key: string);
var
  Digest: Pointer;
begin
  GetMem(Digest, 128 div 8);
  try
    GetMD5(Digest^, Key[1], Length(Key));
    Move(Digest^, KeyData, 128 div 8);
    KeyData[0] := SwapDWord(KeyData[0]);
    KeyData[1] := SwapDWord(KeyData[1]);
    KeyData[2] := SwapDWord(KeyData[2]);
    KeyData[3] := SwapDWord(KeyData[3]);
  finally
    FreeMem(Digest);
  end;
end;

procedure Encrypt(const InData; var Outdata; Size: DWord);
var
  i: DWord;
  p1, p2: Pointer;
begin
  FillChar(CV, 8, $FF);
  p1 := @InData;
  p2 := @Outdata;
  for i := 1 to (Size div 8) do
  begin
    Move(p1^, p2^, 8);
    XorBlock(p2^, CV, 8);
    TEA_Encrypt(p2^, p2^);
    Move(p2^, CV, 8);
    p1 := Pointer(DWord(p1) + 8);
    p2 := Pointer(DWord(p2) + 8);
  end;
  if ((Size mod 8) <> 0) then
  begin
    TEA_Encrypt(CV, CV);
    Move(p1^, p2^, Size mod 8);
    XorBlock(p2^, CV, Size mod 8);
  end;
end;

procedure Decrypt(const InData; var Outdata; Size: DWord);
var
  i: DWord;
  p1, p2: Pointer;
  Temp: array[0..7] of Byte;
begin
  FillChar(CV, 8, $FF);
  p1 := @InData;
  p2 := @OutData;
  for i := 1 to (Size div 8) do
  begin
    Move(p1^, p2^, 8);
    Move(p1^, Temp, 8);
    TEA_Decrypt(p2^, p2^);
    XorBlock(p2^, CV, 8);
    Move(Temp, CV, 8);
    p1 := Pointer(DWord(p1) + 8);
    p2 := Pointer(DWord(p2) + 8);
  end;
  if ((Size mod 8) <> 0) then
  begin
    TEA_Encrypt(CV, CV);
    Move(p1^, p2^, Size mod 8);
    XorBlock(p2^, CV, Size mod 8);
  end;
end;

end.

