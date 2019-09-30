{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{            Base64 Unit - EBase64               }
{                                                }
{************************************************}

unit EBase64;

{$I Exceptions.inc}

{$O+} // Without the Compiler Optimizations the ASM code raise AV exception.

// ----------------------------------------------
// 11-October-2004   Modify by Fabio Dell'Aria. |
// ----------------------------------------------

// Modifies:
// -----------------------------------------------------------------
// 1)...make Delphi 3 compatible                                   |
// 2)...removed many not needed functionalities                    |
// 3)...some new functions added                                   |
// -----------------------------------------------------------------

// Comment of original unit...
{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 * Unit Name : uBase64Codec
 * Author    : Daniel Wischnewski
 * Copyright : Copyright © 2001-2003 by gate(n)etwork GmbH. All Rights Reserved.
 * Creator   : Daniel Wischnewski
 * Contact   : Daniel Wischnewski (e-mail: delphi3000(at)wischnewski.tv);
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

//                               * * * License * * *
//
// The contents of this file are used with permission, subject to the Mozilla
// Public License Version 1.1 (the "License"); you may not use this file except
// in compliance with the License. You may obtain a copy of the License at
//
//                       http://www.mozilla.org/MPL/MPL-1.1.html
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or  implied. See the License for
// the specific language governing rights and limitations under the License.
//

//                               * * * My Wish * * *
//
// If you come to use this unit for your work, I would like to know about it.
// Drop me an e-mail and let me know how it worked out for you. If you wish, you
// can send me a copy of your work. No obligations!
// My e-mail address: delphi3000(at)wischnewski.tv
//

//                               * * * History * * *
//
// Version 1.0 (Oct-10 2002)
//    first published on Delphi-PRAXiS (www.delphipraxis.net)
//
// Version 1.1 (May-13 2003)
//    introduced a compiler switch (SpeedDecode) to switch between a faster
//    decoding variant (prior version) and a litte less fast, but secure variant
//    to work around bad formatted data (decoding only!)
//
// Version 1.2 (Juni-09 2004)
//    included compiler switch {$0+}. In Delphi 6 and 7 projects using this code
//    with compiler optimizations turned off will raise an access violation
//    {$O+} will ensure that this unit runs with compiler optimizations.
//    This option does *not* influence other parts of the project including this
//    unit.
//    Thanks to Ralf Manschewski for pointing out this problem.

interface

uses Windows, SysUtils;

  function CalcEncodedSize(InSize: DWord): DWord;
  function CalcDecodedSize(const InBuffer; InSize: DWord): DWord;

  procedure Base64Encode(const InBuffer; InSize: DWord; var OutBuffer);
  procedure Base64Decode(const InBuffer; InSize: DWord; var OutBuffer);

  function Base64EncodeString(const InText: string): string;
  function Base64DecodeString(const InText: string): string;

  function Base64EncodeToString(const InBuffer; InSize: DWord): string;

implementation

const
  cBase64Codec: array[0..63] of AnsiChar =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  Base64Filler = '=';

function CalcEncodedSize(InSize: DWord): DWord;
begin
  // no buffers passed along, calculate outbuffer size needed
  Result := (InSize div 3) shl 2;
  if ((InSize mod 3) > 0)
  then Inc(Result, 4);
end;

function CalcDecodedSize(const InBuffer; InSize: DWord): DWord;
begin
  Result := 0;
  if InSize = 0 then Exit;
  if (InSize mod 4 <> 0) then Exit;
  Result := InSize div 4 * 3;
  if (PByte(DWord(InBuffer) + InSize - 2)^ = Ord(Base64Filler)) then Dec(Result, 2)
  else
    if (PByte(DWord(InBuffer) + InSize - 1)^ = Ord(Base64Filler)) then Dec(Result);
end;

procedure Base64Encode(const InBuffer; InSize: DWord; var OutBuffer);
var
  ByThrees, LeftOver: DWord;
  // reset in- and outbytes positions
asm
  // load addresses for source and destination
  // PBYTE(InBuffer);
  mov  ESI, [EAX]
  // PBYTE(OutBuffer);
  mov  EDI, [ECX]
  // ByThrees := InSize div 3;
  // LeftOver := InSize mod 3;
  // load InSize (stored in EBX)
  mov  EAX, EBX
  // load 3
  mov  ECX, $03
  // clear upper 32 bits
  xor  EDX, EDX
  // divide by ECX
  div  ECX
  // save result
  mov  ByThrees, EAX
  // save remainder
  mov  LeftOver, EDX
  // load addresses
  lea  ECX, cBase64Codec[0]
  // while I < ByThrees do
  // begin
  xor  EAX, EAX
  xor  EBX, EBX
  xor  EDX, EDX
  cmp  ByThrees, 0
  jz   @@LeftOver
  @@LoopStart:
    // load the first two bytes of the source triplet
    LODSW
    // write Bits 0..5 to destination
    mov  BL, AL
    shr  BL, 2
    mov  DL, BYTE PTR [ECX + EBX]
    // save the Bits 12..15 for later use [1]
    mov  BH, AH
    and  BH, $0F
    // save Bits 6..11
    rol  AX, 4
    and  AX, $3F
    mov  DH, BYTE PTR [ECX + EAX]
    mov  AX, DX
    // store the first two bytes of the destination quadruple
    STOSW
    // laod last byte (Bits 16..23) of the source triplet
    LODSB
    // extend bits 12..15 [1] with Bits 16..17 and save them
    mov  BL, AL
    shr  BX, 6
    mov  DL, BYTE PTR [ECX + EBX]
    // save bits 18..23
    and  AL, $3F
    xor  AH, AH
    mov  DH, BYTE PTR [ECX + EAX]
    mov  AX, DX
    // store the last two bytes of the destination quadruple
    STOSW
    dec  ByThrees
  jnz  @@LoopStart
  @@LeftOver:
  // there are up to two more bytes to encode
  cmp  LeftOver, 0
  jz   @@Done
  // clear result
  xor  EAX, EAX
  xor  EBX, EBX
  xor  EDX, EDX
  // get left over 1
  LODSB
  // load the first six bits
  shl  AX, 6
  mov  BL, AH
  // save them
  mov  DL, BYTE PTR [ECX + EBX]
  // another byte ?
  dec  LeftOver
  jz   @@SaveOne
  // save remaining two bits
  shl  AX, 2
  and  AH, $03
  // get left over 2
  LODSB
  // load next 4 bits
  shl  AX, 4
  mov  BL, AH
  // save all 6 bits
  mov  DH, BYTE PTR [ECX + EBX]
  shl  EDX, 16
  // save last 4 bits
  shr  AL, 2
  mov  BL, AL
  // save them
  mov  DL, BYTE PTR [ECX + EBX]
  // load base 64 'no more data flag'
  mov  DH, Base64Filler
  jmp  @@WriteLast4
  @@SaveOne:
  // adjust the last two bits
  shr  AL, 2
  mov  BL, AL
  // save them
  mov  DH, BYTE PTR [ECX + EBX]
  shl  EDX, 16
  // load base 64 'no more data flags'
  mov  DH, Base64Filler
  mov  DL, Base64Filler
  // ignore jump, as jump reference is next line !
  // jmp  @@WriteLast4
  @@WriteLast4:
    // load and adjust result
    mov  EAX, EDX
    ror EAX, 16
    // save it to destination
    STOSD
  @@Done:
end;

procedure Base64Decode(const InBuffer; InSize: DWord; var OutBuffer);
const
  cBase64Codec: array[0..127] of Byte =
  (
    $FF, $FF, $FF, $FF, $FF, {005>} $FF, $FF, $FF, $FF, $FF, // 000..009
    $FF, $FF, $FF, $FF, $FF, {015>} $FF, $FF, $FF, $FF, $FF, // 010..019
    $FF, $FF, $FF, $FF, $FF, {025>} $FF, $FF, $FF, $FF, $FF, // 020..029
    $FF, $FF, $FF, $FF, $FF, {035>} $FF, $FF, $FF, $FF, $FF, // 030..039
    $FF, $FF, $FF, $3E, $FF, {045>} $FF, $FF, $3F, $34, $35, // 040..049
    $36, $37, $38, $39, $3A, {055>} $3B, $3C, $3D, $FF, $FF, // 050..059
    $FF, $FF, $FF, $FF, $FF, {065>} $00, $01, $02, $03, $04, // 060..069
    $05, $06, $07, $08, $09, {075>} $0A, $0B, $0C, $0D, $0E, // 070..079
    $0F, $10, $11, $12, $13, {085>} $14, $15, $16, $17, $18, // 080..089
    $19, $FF, $FF, $FF, $FF, {095>} $FF, $FF, $1A, $1B, $1C, // 090..099
    $1D, $1E, $1F, $20, $21, {105>} $22, $23, $24, $25, $26, // 100..109
    $27, $28, $29, $2A, $2B, {115>} $2C, $2D, $2E, $2F, $30, // 110..119
    $31, $32, $33, $FF, $FF, {125>} $FF, $FF, $FF            // 120..127
  );
asm
  push EBX
  mov  ESI, [EAX]
  mov  EDI, [ECX]
  mov  EAX, InSize
  shr  EAX, 2
  jz   @@Done
  lea  ECX, cBase64Codec[0]
  xor  EBX, EBX
  dec  EAX
  jz   @@LeftOver
  push EBP
  mov  EBP, EAX
  @@LoopStart:
    // load four bytes into EAX
    LODSD
    // save them to EDX as AX is used to store results
    mov  EDX, EAX
    // get bits 0..5
    mov  BL, DL
    // decode
    mov  AH, BYTE PTR [ECX + EBX]
    // get bits 6..11
    mov  BL, DH
    // decode
    mov  AL, BYTE PTR [ECX + EBX]
    // align last 6 bits
    shl  AL, 2
    // get first 8 bits
    ror  AX, 6
    // store first byte
    STOSB
    // align remaining 4 bits
    shr  AX, 12
    // get next two bytes from source quad
    shr  EDX, 16
    // load bits 12..17
    mov  BL, DL
    // decode
    mov  AH, BYTE PTR [ECX + EBX]
    // align ...
    shl  AH, 2
    // ... and adjust
    rol  AX, 4
    // get last bits 18..23
    mov  BL, DH
    // decord
    mov  BL, BYTE PTR [ECX + EBX]
    // enter in destination word
    or   AH, BL
    // and store to destination
    STOSW
    // more coming ?
    dec  EBP
  jnz  @@LoopStart
  pop  EBP
  // no
  // last four bytes are handled separately, as special checking is needed
  // on the last two bytes (may be end of data signals '=' or '==')
  @@LeftOver:
  // get the last four bytes
  LODSD
  // save them to EDX as AX is used to store results
  mov  EDX, EAX
  // get bits 0..5
  mov  BL, DL
  // decode
  mov  AH, BYTE PTR [ECX + EBX]
  // get bits 6..11
  mov  BL, DH
  // decode
  mov  AL, BYTE PTR [ECX + EBX]
  // align last 6 bits
  shl  AL, 2
  // get first 8 bits
  ror  AX, 6
  // store first byte
  STOSB
  // get next two bytes from source quad
  shr  EDX, 16
  // check DL for "end of data signal"
  cmp  DL, Base64Filler
  jz   @@SuccessDone
  // align remaining 4 bits
  shr  AX, 12
  // load bits 12..17
  mov  BL, DL
  // decode
  mov  AH, BYTE PTR [ECX + EBX]
  // align ...
  shl  AH, 2
  // ... and adjust
  rol  AX, 4
  // store second byte
  STOSB
  // check DH for "end of data signal"
  cmp  DH, Base64Filler
  jz   @@SuccessDone
  // get last bits 18..23
  mov  BL, DH
  // decord
  mov  BL, BYTE PTR [ECX + EBX]
  // enter in destination word
  or   AH, BL
  // AH - AL for saving last byte
  mov  AL, AH
  // store third byte
  STOSB
  @@SuccessDone:
  @@Done:
  pop  EBX
end;

procedure Base64EncodeStr(const InText: string; var OutText: string);
var
  InSize, OutSize: DWord;
  PIn, POut: Pointer;
begin
  // get size of source
  InSize := Length(InText);
  // calculate size for destination
  OutSize := CalcEncodedSize(InSize);
  // prepare string length to fit result data
  SetLength(OutText, OutSize);
  PIn := @InText[1];
  POut := @OutText[1];
  // encode !
  Base64Encode(PIn, InSize, POut);
end;

procedure Base64DecodeStr(const InText: string; var OutText: string);
var
  InSize, OutSize: DWord;
  PIn, POut: Pointer;
begin
  // get size of source
  InSize := Length(InText);
  // calculate size for destination
  PIn := @InText[1];
  OutSize := CalcDecodedSize(PIn, InSize);
  // prepare string length to fit result data
  SetLength(OutText, OutSize);
  FillChar(OutText[1], OutSize, '.');
  POut := @OutText[1];
  // encode !
  Base64Decode(PIn, InSize, POut);
end;

function Base64EncodeString(const InText: string): string;
begin
  Base64EncodeStr(InText, Result);
end;

function Base64DecodeString(const InText: string): string;
begin
  Base64DecodeStr(InText, Result);
end;

function Base64EncodeToString(const InBuffer; InSize: DWord): string;
var
  POut: Pointer;
begin
  SetLength(Result, CalcEncodedSize(InSize));
  POut := @Result[1];
  Base64Encode(InBuffer, InSize, POut);
end;

end.
