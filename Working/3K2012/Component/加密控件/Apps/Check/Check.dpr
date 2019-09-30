{******************************************************************************}
{* DCPcrypt v2.0 written by David Barton (davebarton@bigfoot.com) *************}
{******************************************************************************}
{* A program to check cross platform interoperablity of DCPcrypt **************}
{******************************************************************************}
{* Copyright (c) 1999-2000 David Barton                                       *}
{* Permission is hereby granted, free of charge, to any person obtaining a    *}
{* copy of this software and associated documentation files (the "Software"), *}
{* to deal in the Software without restriction, including without limitation  *}
{* the rights to use, copy, modify, merge, publish, distribute, sublicense,   *}
{* and/or sell copies of the Software, and to permit persons to whom the      *}
{* Software is furnished to do so, subject to the following conditions:       *}
{*                                                                            *}
{* The above copyright notice and this permission notice shall be included in *}
{* all copies or substantial portions of the Software.                        *}
{*                                                                            *}
{* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR *}
{* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   *}
{* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    *}
{* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER *}
{* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    *}
{* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        *}
{* DEALINGS IN THE SOFTWARE.                                                  *}
{******************************************************************************}

program Check;
{$IFNDEF FPK}
  {$APPTYPE CONSOLE}
{$ENDIF}
uses
  Sysutils, DCPcrypt,
  Blowfish, Cast128, Cast256, DES, Gost, Ice, Mars, Misty1, RC2, RC4, RC5, RC6,
  Rijndael, Twofish,
  Haval, MD4, MD5, Rmd160, SHA1;

var
  Cipher: TDCP_cipher;
  NextCipher: PDCP_cipherinfo;
  Hash: TDCP_hash;
  NextHash: PDCP_hashinfo;
  InBuffer, OutBuffer: array[0..8191] of byte;
  Dest: file;
  i: integer;
  s: string;
begin
  try
    if ParamCount= 0 then
      AssignFile(Dest,'Check.out')
    else
      AssignFile(Dest,ParamStr(1));
    Rewrite(Dest,1);
  except
    Writeln('Unable to open file for writing');
    Exit;
  end;
  for i:= 0 to 8191 do
    InBuffer[i]:= byte(i) xor byte(i shr 8);
  NextCipher:= DCPcipherlist;
  while NextCipher<> nil do
  begin
    s:= NextCipher^.Name;
    BlockWrite(Dest,s[1],Length(s));
    Cipher:= NextCipher^.Cipher.Create(nil);
    Cipher.InitStr('Hello World');
    if NextCipher^.Block then
    begin
      Move(InBuffer,OutBuffer,8192);
      s:= 'ECB';
      BlockWrite(Dest,s[1],Length(s));
      for i:= 0 to 31 do
      begin
        TDCP_blockcipher(Cipher).EncryptECB(OutBuffer,OutBuffer);
        BlockWrite(Dest,OutBuffer,TDCP_blockcipher(Cipher).BlockSize div 8);
      end;
      s:= 'CBC';
      BlockWrite(Dest,s[1],Length(s));
      TDCP_blockcipher(Cipher).EncryptCBC(InBuffer,OutBuffer,Sizeof(OutBuffer));
      BlockWrite(Dest,OutBuffer,Sizeof(OutBuffer));
      s:= 'CFB8';
      BlockWrite(Dest,s[1],Length(s));
      TDCP_blockcipher(Cipher).EncryptCFB8bit(InBuffer,OutBuffer,Sizeof(OutBuffer));
      BlockWrite(Dest,OutBuffer,Sizeof(OutBuffer));
      s:= 'CBCBlock';
      BlockWrite(Dest,s[1],Length(s));
      TDCP_blockcipher(Cipher).EncryptCFBblock(InBuffer,OutBuffer,Sizeof(OutBuffer));
      BlockWrite(Dest,OutBuffer,Sizeof(OutBuffer));
      s:= 'OFB';
      BlockWrite(Dest,s[1],Length(s));
      TDCP_blockcipher(Cipher).EncryptOFB(InBuffer,OutBuffer,Sizeof(OutBuffer));
      BlockWrite(Dest,OutBuffer,Sizeof(OutBuffer));
    end
    else
    begin
      Cipher.Encrypt(InBuffer,OutBuffer,Sizeof(OutBuffer));
      BlockWrite(Dest,OutBuffer,Sizeof(OutBuffer));
    end;
    Cipher.Free;
    NextCipher:= NextCipher^.Next;
  end;
  NextHash:= DCPhashlist;
  while NextHash<> nil do
  begin
    s:= NextHash^.Name;
    BlockWrite(Dest,s[1],Length(s));
    Hash:= NextHash^.Hash.Create(nil);
    Hash.Init;
    Hash.Update(InBuffer,Sizeof(InBuffer));
    Hash.Final(OutBuffer);
    BlockWrite(Dest,OutBuffer,Hash.HashSize div 8);
    Hash.Free;
    NextHash:= NextHash^.Next;
  end;
  CloseFile(Dest);
end.
