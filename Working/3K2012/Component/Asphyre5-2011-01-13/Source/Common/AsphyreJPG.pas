unit AsphyreJPG;
//---------------------------------------------------------------------------
// AsphyreJPG.pas                                       Modified: 08-Ago-2005
// JPEG format support for Asphyre                                Version 1.0
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
 Types, Classes, SysUtils, Graphics, JPEG;

//---------------------------------------------------------------------------
type
 TJPGFlag  = (jfProgressive, jfGrayscale);
 TJPGFlags = set of TJPGFlag;

//---------------------------------------------------------------------------
// LoadJPGtoBMP()
//
// Loads JPEG-compressed stream to destination bitmap.
//---------------------------------------------------------------------------
function LoadJPGtoBMP(Stream: TStream; Dest: TBitmap): Boolean; overload;

//---------------------------------------------------------------------------
// SaveBMPtoJPG()
//
// Saves source bitmap to JPEG-compressed stream.
// NOTICE: 'Quality' is between 0 and 100.
//---------------------------------------------------------------------------
function SaveBMPtoJPG(Stream: TStream; Source: TBitmap; Flags: TJPGFlags;
 Quality: Cardinal): Boolean; overload;

//---------------------------------------------------------------------------
// Overloaded functions to save/load JPGs to/from external files.
//---------------------------------------------------------------------------
function LoadJPGtoBMP(const FileName: string; Dest: TBitmap): Boolean; overload;
function SaveBMPtoJPG(const FileName: string; Source: TBitmap;
 Flags: TJPGFlags; Quality: Cardinal): Boolean; overload;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
function LoadJPGtoBMP(Stream: TStream; Dest: TBitmap): Boolean;
var
 Image: TJpegImage;
begin
 Result:= True;
 Image:= TJpegImage.Create();

 try
  Image.LoadFromStream(Stream);
 except
  Result:= False;
 end;

 if (Result) then Dest.Assign(Image);
 Image.Free();
end;

//---------------------------------------------------------------------------
function SaveBMPtoJPG(Stream: TStream; Source: TBitmap; Flags: TJPGFlags;
 Quality: Cardinal): Boolean;
var
 Image: TJpegImage;
begin
 Result:= True;

 Image:= TJpegImage.Create();
 Image.Assign(Source);

 // set save options
 Image.ProgressiveEncoding:= jfProgressive in Flags;
 Image.Grayscale:= jfGrayscale in Flags;

 // set compression quality
 Image.CompressionQuality:= Quality;

 // save jpeg data
 try
  Image.SaveToStream(Stream);
 except
  Result:= False;
 end;

 Image.Free();
end;

//---------------------------------------------------------------------------
function LoadJPGtoBMP(const FileName: string; Dest: TBitmap): Boolean;
var
 Image: TJpegImage;
begin
 Result:= True;

 Image:= TJpegImage.Create();
 try
  Image.LoadFromFile(FileName);
 except
  Result:= False;
 end;

 if (Result) then Dest.Assign(Image);
 Image.Free();
end;

//---------------------------------------------------------------------------
function SaveBMPtoJPG(const FileName: string; Source: TBitmap;
 Flags: TJPGFlags; Quality: Cardinal): Boolean; overload;
var
 Image: TJpegImage;
begin
 Result:= True;

 Image:= TJpegImage.Create();
 Image.Assign(Source);

 // set save options
 Image.ProgressiveEncoding:= jfProgressive in Flags;
 Image.Grayscale:= jfGrayscale in Flags;

 // set compression quality
 Image.CompressionQuality:= Quality;

 // save jpeg data
 try
  Image.SaveToFile(FileName);
 except
  Result:= False;
 end;

 Image.Free();
end;

//---------------------------------------------------------------------------
end.
