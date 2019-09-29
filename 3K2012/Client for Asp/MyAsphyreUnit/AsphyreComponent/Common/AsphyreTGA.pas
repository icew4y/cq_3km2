unit AsphyreTGA;
//---------------------------------------------------------------------------
// AsphyreTGA.pas                                       Modified: 08-Ago-2005
// Truevision TARGA format support for Asphyre                    Version 1.0
//---------------------------------------------------------------------------
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Types, Classes, SysUtils, Graphics;

//---------------------------------------------------------------------------
type
 TTGAFlag  = (tfMirrored, tfFlipped, tfCompressed);
 TTGAFlags = set of TTGAFlag;

//---------------------------------------------------------------------------
// LoadTGAtoBMP()
//
// Loads 24-bit or 32-bit Truevision TARGA file from stream and stores all
// information in destination bitmap.
//---------------------------------------------------------------------------
function LoadTGAtoBMP(Stream: TStream; Dest: TBitmap): Boolean; overload;

//---------------------------------------------------------------------------
// SaveBMPtoTGA()
//
// Saves 24-bit or 32-bit bitmap as Truevision TARGA file to stream.
//---------------------------------------------------------------------------
function SaveBMPtoTGA(Stream: TStream; Source: TBitmap;
 Flags: TTGAFlags): Boolean; overload;

//---------------------------------------------------------------------------
// Overloaded functions to save/load TGAs to/from external files.
//---------------------------------------------------------------------------
function LoadTGAtoBMP(const FileName: string; Dest: TBitmap): Boolean; overload;
function SaveBMPtoTGA(const FileName: string; Source: TBitmap;
 Flags: TTGAFlags): Boolean; overload;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
type
 TTGAHeader = packed record
  tfIDLength     : Byte;
  tfColorMapType : Byte;
  tfImageType    : Byte;
  tfColorMapSpec : packed array[0..4] of Byte;
  tfOrigX        : Word;
  tfOrigY        : Word;
  tfWidth        : Word;
  tfHeight       : Word;
  tfBpp          : Byte;
  tfImageDesc    : Byte;
 end;

//---------------------------------------------------------------------------
procedure DecodeTargaRLE(Stream: TStream; Dest: Pointer; DestSize,
 tgaBpp: Integer);
var
 Write: Pointer;
 Count, bSize: Integer;
 RLEHeader,
 BlockLength: Byte;
 RLEBuf: Longword;
begin
 // bytes to write
 Count:= DestSize;
 // pointer to destination
 Write:= Dest;

 // read pixels
 while (Count > 0) do
  begin
   // read the RLE header
   Stream.ReadBuffer(RLEHeader, SizeOf(RLEHeader));
   // RLE Block length
   BlockLength:= (RLEHeader and $7F) + 1;
   if (RLEHeader and $80) = $80 then
    begin
     // if highest bit is set, the read one pixel and repeat it BlockLength times
     Stream.ReadBuffer(RLEBuf, tgaBpp);
     // write BlockLength pixels of RLEBuf
     while (BlockLength > 0) do
      begin
       Move(RLEBuf, Write^, tgaBpp); // repeat the pixel, one at a time
       Inc(Integer(Write), tgaBpp);
       Dec(Count, tgaBpp);
       Dec(BlockLength);
      end;
    end else
    begin
     // size of scanline to read
     bSize:= Integer(BlockLength) * tgaBpp;
     // read BlockLength pixels
     Stream.ReadBuffer(Write^, bSize);
     // increment destination pointer
     Inc(Integer(Write), bSize);
     // decrement the remaining byte count
     Dec(Count, bSize);
    end; // if RLEHeader
  end; // while
end;

//---------------------------------------------------------------------------
procedure Flip(Image: TBitmap);
var
 i, j: Integer;
 ScanBuf: Pointer;
 MyPitch: Integer;
begin
 if (Image.PixelFormat <> pf32bit) then Image.PixelFormat:= pf32bit;

 // determine scanline size
 MyPitch:= Image.Width * 4;

 // proceed only if scanline exists
 if (MyPitch > 0) then
  begin
   // allocate memory for temporary buffer
   GetMem(ScanBuf, MyPitch);

   // flip the image
   for i:= 0 to (Image.Height div 2) - 1 do
    begin
     // calculate the opposite line
     j:= (Image.Height - 1) - i;

     // copy scanline[i] to buffer
     Move(Image.Scanline[i]^, ScanBuf^, MyPitch);
     // copy scanline[j] to scanline[i]
     Move(Image.Scanline[j]^, Image.Scanline[i]^, MyPitch);
     // copy buffer to scanline[j]
     Move(ScanBuf^, Image.Scanline[j]^, MyPitch);
    end;

   // free unused memory
   FreeMem(ScanBuf);
  end; // if
end;

//---------------------------------------------------------------------------
procedure Mirror(Image: TBitmap);
var
 i, j: Integer;
 ScanBuf, Dest, Source: Pointer;
 MyPitch: Integer;
begin
 if (Image.PixelFormat <> pf32bit) then Image.PixelFormat:= pf32bit;

 // determine scanline size
 MyPitch:= Image.Width * 4;

 // proceed only if scanline exists
 if (MyPitch > 0) then
  begin
   // allocate memory for temporary buffer
   GetMem(ScanBuf, MyPitch);

   // mirror the image
   for j:= 0 to Image.Height - 1 do
    begin
     // assume the destination is the same as source
     Move(Image.Scanline[j]^, ScanBuf^, MyPitch);

     // point destination to the first pixel
     Dest:= ScanBuf;
     // point source to last pixel
     Source:= Pointer(Integer(Image.Scanline[j]) + (MyPitch - 4));

     for i:= 0 to Image.Width - 1 do
      begin
       Longword(Dest^):= Longword(Source^);
       Dec(Integer(Source), 4);
       Inc(Integer(Dest), 4);
      end; // for i

     // copy the mirrored scanline back
     Move(ScanBuf^, Image.Scanline[j]^, MyPitch);
    end; // for j

   // free unused memory
   FreeMem(ScanBuf);
  end; // if
end;

//---------------------------------------------------------------------------
function LoadTGAtoBMP(Stream: TStream; Dest: TBitmap): Boolean;
var
 tgaHeader: TTGAHeader;
 tgaBpp, i: Integer;
 BufSize, ScanLength: Integer;
 PixBuffer, Read: Pointer;
begin
 Result:= False;
 PixBuffer:= nil;

 try
  // read TGA header
  Stream.ReadBuffer(tgaHeader, SizeOf(TTGAHeader));

  // check if the image is either True-Color or RLE encoded
  if (tgaHeader.tfImageType <> 2)and(tgaHeader.tfImageType <> 10) then Exit;

  // color-mapping
  if (tgaHeader.tfColorMapType <> 0) then Exit;

  // bit-depth check
  tgaBpp:= tgaHeader.tfBpp;
  if (tgaBpp <> 32)and(tgaBpp <> 24) then Exit;

  // skip Image ID field
  if (tgaHeader.tfIDLength <> 0) then
   Stream.Seek(tgaHeader.tfIDLength, soFromCurrent);

  // create pixel buffer
  BufSize:= Integer(tgaHeader.tfWidth) * tgaHeader.tfHeight * (tgaBpp div 8);
  PixBuffer:= AllocMem(BufSize);

  // read pixels
  if (tgaHeader.tfImageType <> 10) then
   begin
    // read raw pixel data
    Stream.ReadBuffer(pixBuffer^, bufSize);
   end else
   begin
    // read RLE data
    DecodeTargaRLE(Stream, pixBuffer, bufSize, tgaBpp div 8);
   end;
 except
  if (PixBuffer <> nil) then FreeMem(PixBuffer);
  Exit;
 end; 

 // specify file size
 Dest.Width := tgaHeader.tfWidth;
 Dest.Height:= tgaHeader.tfHeight;

 // specify bit-depth
 if (tgaBpp = 32) then Dest.PixelFormat:= pf32bit else Dest.PixelFormat:= pf24bit;

 // source pointer
 Read:= pixBuffer;
 // scanline width
 ScanLength:= Dest.Width * (tgaBpp div 8);

 // set pixel data
 for i:= 0 to Dest.Height - 1 do
  begin
   Move(Read^, Dest.Scanline[i]^, ScanLength);
   Inc(Integer(Read), ScanLength);
  end;

 // check if the image is mirrored
 if (tgaHeader.tfImageDesc and $10 = $10) then Mirror(Dest);

 // check if the image is flipped
 if (tgaHeader.tfImageDesc and $20 <> $20) then Flip(Dest);

 // release the buffer memory and reading stream
 FreeMem(PixBuffer);
 Result:= True;
end;

//---------------------------------------------------------------------------
procedure ScanRLE(Data: Pointer; PixRemain, iBpp: Integer;
 out PixCount: Integer; out DoRepeat: Boolean);
var
 Pixels: array[0..2] of Longword;
 nPixel: Longword;
 i: Integer;
begin
 // case 0: less than 3 pixels to write
 if (PixRemain < 3) then
  begin
   PixCount:= PixRemain;
   DoRepeat:= False;
   Exit;
  end;
 // read next 3 pixels
 for i:= 0 to 2 do
  begin
   Pixels[i]:= 0;
   Move(Pointer(Integer(Data) + (iBpp * i))^, Pixels[i], iBpp);
  end;
 // case 1: repeating pixels
 nPixel:= 0;
 if (Pixels[0] = Pixels[1])and(Pixels[1] = Pixels[2]) then
  begin
   PixCount:= 3;
   nPixel:= Pixels[0];
   while (PixCount < PixRemain)and(PixCount < $80)and(nPixel = Pixels[0]) do
    begin
     // increment repeated pixel count
     Inc(PixCount);
     Move(Pointer(Integer(Data) + (iBpp * PixCount))^, nPixel, iBpp);
    end;
   DoRepeat:= True;
   Exit;
  end;
 // case 2: non-repeating pixels
 PixCount:= 2;
 while (PixCount < PixRemain - 1)and(PixCount < $80) do
  begin
   // read next 3 pixels
   for i:= 0 to 2 do
    begin
     Pixels[i]:= 0;
     Move(Pointer(Integer(Data) + (iBpp * (i + PixCount)))^, Pixels[i], iBpp);
    end;
   // check if the pixels are different
   if (Pixels[0] = Pixels[1])and(Pixels[1] = Pixels[2]) then Break
    else Inc(PixCount);
  end;
 DoRepeat:= False;
end;

//---------------------------------------------------------------------------
procedure EncodeTargaRLE(Stream: TStream; Source: Pointer;
 SourceSize, tgaBpp: Integer);
var
 Read: Pointer;
 Count, bSize: Integer;
 RLEHeader: Byte;
 PixCount: Integer;
 DoRepeat: Boolean;
begin
 // bytes to read
 Count:= SourceSize;
 // pointer to source
 Read:= Source;

 // write pixels
 while (Count > 0) do
  begin
   // scan repeating pixels
   ScanRLE(Read, Count div tgaBpp, tgaBpp, PixCount, DoRepeat);
   // calculate scanline size
   bSize:= PixCount * tgaBpp;
   // set # of pixels
   RLEHeader:= (PixCount - 1) and $7F;
   if (DoRepeat) then
    begin
     // update RLE header
     RLEHeader:= RLEHeader or $80; // set RLE bit
     // write updated RLE header
     Stream.WriteBuffer(RLEHeader, SizeOf(RLEHeader));
     // write the repeating pixel data
     Stream.WriteBuffer(Read^, tgaBpp);
    end else
    begin
     // write RLE header
     Stream.WriteBuffer(RLEHeader, SizeOf(RLEHeader));
     // write pixel data
     Stream.WriteBuffer(Read^, bSize);
    end;

   // increment source pointer by number of scanned pixels
   Inc(Integer(Read), bSize);
   // decrement bytes remaining
   Dec(Count, bSize);
  end; // while
end;

//---------------------------------------------------------------------------
function SaveBMPtoTGA(Stream: TStream; Source: TBitmap;
 Flags: TTGAFlags): Boolean;
var
 tgaHeader: TTGAHeader;
 tgaBpp, i: Integer;
 BufSize, ScanLength: Integer;
 PixBuffer, Write: Pointer;
begin
 // check bit-depth
 if (not (Source.PixelFormat in [pf24bit, pf32bit])) then
  begin
   Result:= False;
   Exit;
  end;

 // bit-depth configuration
 tgaBpp:= 24;
 if (Source.PixelFormat = pf32bit) then tgaBpp:= 32;

 // create pixel buffer
 BufSize:= Source.Width * Source.Height * (tgaBpp div 8);
 GetMem(PixBuffer, BufSize);

 // source pointer
 Write:= PixBuffer;
 // scanline width
 ScanLength:= Source.Width * (tgaBpp div 8);

 // apply flip & mirror attributes
 if (tfFlipped in Flags) then Flip(Source);
 if (tfMirrored in Flags) then Mirror(Source);

 // set pixel data
 for i:= 0 to Source.Height - 1 do
  begin
   Move(Source.Scanline[i]^, Write^, ScanLength);
   Inc(Integer(Write), ScanLength);
  end;

 // return image to normal state
 if (tfFlipped in Flags) then Flip(Source);
 if (tfMirrored in Flags) then Mirror(Source);

 // clear TARGA header
 FillChar(tgaHeader, SizeOf(TTGAHeader), 0);

 // create new TARGA header
 tgaHeader.tfImageType:= 2;    // True-color
 if (tfCompressed in Flags) then tgaHeader.tfImageType:= 10;    // RLE-encoded

 // set flip & mirror attributes
 tgaHeader.tfImageDesc:= $00;   // the image is flipped
 // mirrored
 if (tfFlipped in Flags) then
  tgaHeader.tfImageDesc:= tgaHeader.tfImageDesc or $20;
 // flipped
 if (tfMirrored in Flags) then
  tgaHeader.tfImageDesc:= tgaHeader.tfImageDesc or $10;

 tgaHeader.tfColorMapType := 0;     // no colormapping
 tgaHeader.tfWidth        := Source.Width; // image width
 tgaHeader.tfHeight       := Source.Height;// image height
 tgaHeader.tfBpp          := tgaBpp;// image bit-depth

 Result:= True;
 try
  // write new TARGA header
  Stream.WriteBuffer(tgaHeader, SizeOf(TTGAHeader));

  // encode pixel data
  if (tfCompressed in Flags) then
   begin
    EncodeTargaRLE(Stream, pixBuffer, bufSize, tgaBpp div 8);
   end else
   begin
    Stream.WriteBuffer(pixBuffer^, bufSize);
   end;
 except
  Result:= False;
 end; 

 // release the buffer memory and reading stream
 FreeMem(PixBuffer);
end;

//---------------------------------------------------------------------------
function LoadTGAtoBMP(const FileName: string; Dest: TBitmap): Boolean; overload;
var
 Stream: TStream;
begin
 try
  Stream:= TFileStream.Create(FileName, fmOpenRead	or fmShareDenyWrite);
 except
  Result:= False;
  Exit;
 end;

 try
  Result:= LoadTGAtoBMP(Stream, Dest);
 finally
  Stream.Free();
 end;
end;

//---------------------------------------------------------------------------
function SaveBMPtoTGA(const FileName: string; Source: TBitmap;
 Flags: TTGAFlags): Boolean;
var
 Stream: TStream;
begin
 try
  Stream:= TFileStream.Create(FileName, fmCreate or fmShareExclusive);
 except
  Result:= False;
  Exit;
 end;

 try
  Result:= SaveBMPtoTGA(Stream, Source, Flags);
 finally
  Stream.Free();
 end;
end;


//---------------------------------------------------------------------------
end.
