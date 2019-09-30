unit AsphyrePNG;
//---------------------------------------------------------------------------
// AsphyrePNG.pas                                       Modified: 04-Jan-2007
// Portable Network Graphics format support for Asphyre           Version 1.0
//---------------------------------------------------------------------------
// IMPORTANT: This file is subject to TPNGImage license agreement and is not
// covered by MPL! Please refer to 'pngimage.pas' file for information.
//
// Thanks to Gustavo Huffenbacher Daud (gustavo.daud@terra.com.br) for the
// permission to use his excellent component.
//
// You can retreive the original package at:
//    http://pngdelphi.sourceforge.net
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Classes, SysUtils, Graphics, PNGImage;

//---------------------------------------------------------------------------
// LoadPNGtoBMP()
//
// Loads Portable Network Graphics format stream to bitmap.
//---------------------------------------------------------------------------
function LoadPNGtoBMP(Stream: TStream; Dest: TBitmap): Boolean; overload;

//---------------------------------------------------------------------------
// SaveBMPtoPNG()
//
// Saves bitmap as Portable Network Graphics format in steam.
// NOTICE: 'Ratio' is between 0 and 9.
//---------------------------------------------------------------------------
function SaveBMPtoPNG(Stream: TStream; Source: TBitmap;
 Ratio: Integer): Boolean; overload;

//---------------------------------------------------------------------------
// Overloaded functions to save/load JPGs to/from external files.
//---------------------------------------------------------------------------
function LoadPNGtoBMP(const FileName: string; Dest: TBitmap): Boolean; overload;
function SaveBMPtoPNG(const FileName: string; Source: TBitmap;
 Ratio: Integer): Boolean; overload;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
function LoadPNGtoBMP(Stream: TStream; Dest: TBitmap): Boolean; overload;
var
 Image: TPngObject;
 ScanIndex, i: Integer;
 PxScan : PLongword;
 PxAlpha: PByte;
begin
 Result:= True;

 Image:= TPngObject.Create();
 try
  Image.LoadFromStream(Stream);
 except
  Result:= False;
 end;

 if (Result) then
  begin
   Image.AssignTo(Dest);

   if (Image.Header.ColorType = COLOR_RGBALPHA)or(Image.Header.ColorType = COLOR_GRAYSCALEALPHA) then
    begin
     Dest.PixelFormat:= pf32bit;

     for ScanIndex:= 0 to Dest.Height - 1 do
      begin
       PxScan := Dest.Scanline[ScanIndex];
       PxAlpha:= @Image.AlphaScanline[ScanIndex][0];
       for i:= 0 to Dest.Width - 1 do
        begin
         PxScan^:= (PxScan^ and $FFFFFF) or (Longword(Byte(PxAlpha^)) shl 24);
         Inc(PxScan);
         Inc(PxAlpha);
        end;
      end;
    end;
  end;

 Image.Free();
end;

//---------------------------------------------------------------------------
function SaveBMPtoPNG(Stream: TStream; Source: TBitmap;
 Ratio: Integer): Boolean; overload;
var
 Image: TPNGObject;
 ScanIndex, i: Integer;
 PxScan : PLongword;
 PxAlpha: PByte;
begin
 Result:= True;

 Image:= TPNGObject.Create();
 Image.Assign(Source);

 if (Source.PixelFormat = pf32bit) then
  begin
   Image.CreateAlpha();

   for ScanIndex:= 0 to Source.Height - 1 do
    begin
     PxScan := Source.Scanline[ScanIndex];
     PxAlpha:= @Image.AlphaScanline[ScanIndex][0];
     for i:= 0 to Source.Width - 1 do
      begin
       PxAlpha^:= Longword(PxScan^) shr 24;
       Inc(PxScan);
       Inc(PxAlpha);
      end;
    end;
  end;

 Image.CompressionLevel:= Ratio;
 try
  Image.SaveToStream(Stream);
 except
  Result:= False;
 end;
   
 Image.Free();
end;

//---------------------------------------------------------------------------
function LoadPNGtoBMP(const FileName: string; Dest: TBitmap): Boolean; overload;
var
 Stream: TStream;
begin
 Stream:= TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);

 try
  Result:= LoadPNGtoBMP(Stream, Dest);
 finally
  Stream.Free();
 end;
end;

//---------------------------------------------------------------------------
function SaveBMPtoPNG(const FileName: string; Source: TBitmap;
 Ratio: Integer): Boolean; overload;
var
 Stream: TStream;
begin
 Stream:= TFileStream.Create(FileName, fmCreate or fmShareExclusive);

 try
  Result:= SaveBMPtoPNG(Stream, Source, Ratio);
 finally
  Stream.Free();
 end;
end;

//---------------------------------------------------------------------------
end.
