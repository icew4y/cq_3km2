unit AsphyreImages;
//---------------------------------------------------------------------------
// AsphyreImages.pas                                    Modified: 17-Sep-2008
// Asphyre Images class                                          Version 2.22
//---------------------------------------------------------------------------
// Important Notice:
//
// If you modify/use this code or one of its parts either in original or
// modified form, you must comply with Mozilla Public License v1.1,
// specifically section 3, "Distribution Obligations". Failure to do so will
// result in the license breach, which will be resolved in the court.
// Remember that violating author's rights is considered a serious crime in
// many countries. Thank you!
//
// !! Please *read* Mozilla Public License 1.1 document located at:
//  http://www.mozilla.org/MPL/
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
//
// The Original Code is AsphyreImages.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Types, Classes, SysUtils, Graphics, Vectors2px, AsphyreTypes, AsphyreDb,
 AbstractTextures;

//---------------------------------------------------------------------------
type
 TAsphyreImage = class
 private
  FName: string;

  Textures: array of TAsphyreLockableTexture;

  FPatternCount: Integer;
  FPatternSize : TPoint2px;
  FVisibleSize : TPoint2px;
  FMipMapping  : Boolean;
  FPixelFormat : TAsphyrePixelFormat;
  FDynamicImage: Boolean;

  function GetTexture(Index: Integer): TAsphyreLockableTexture;
  function GetTextureCount(): Integer;

  function UploadStreamNative(Stream: TStream;
   Texture: TAsphyreLockableTexture): Boolean;
  function UploadStream32toX(Stream: TStream;
   Texture: TAsphyreLockableTexture): Boolean;
  function UploadStreamXtoX(Stream: TStream; Texture: TAsphyreLockableTexture;
   InFormat: TAsphyrePixelFormat): Boolean;

  function FindPatternTex(Pattern: Integer; out PatInRow,
   PatInCol: Integer): Integer;
  procedure FindPatternMapping(Pattern, PatInRow, PatInCol: Integer;
   Tex: TAsphyreLockableTexture; var Mapping: TPoint4); overload;
  procedure FindPatternMapping(Pattern, PatInRow, PatInCol: Integer;
   const ViewPos, ViewSize: TPoint2px; Tex: TAsphyreLockableTexture;
   var Mapping: TPoint4); overload;
  function StreamToPixelFormat(Value: Byte): TAsphyrePixelFormat;
 public
  property Name: string read FName write FName;

  property PatternCount: Integer read FPatternCount write FPatternCount;
  property PatternSize : TPoint2px read FPatternSize write FPatternSize;
  property VisibleSize : TPoint2px read FVisibleSize write FVisibleSize;
  property MipMapping  : Boolean read FMipMapping write FMipMapping;
  property PixelFormat : TAsphyrePixelFormat read FPixelFormat write FPixelFormat;
  property DynamicImage: Boolean read FDynamicImage write FDynamicImage;

  property Texture[Index: Integer]: TAsphyreLockableTexture read GetTexture;
  property TextureCount: Integer read GetTextureCount;

  function InsertTexture(): Integer; overload;
  function InsertTexture(Width,
   Height: Integer): TAsphyreLockableTexture; overload;

  procedure RemoveTexture(Index: Integer);
  function IndexOfTexture(Texture: TAsphyreLockableTexture): Integer;
  procedure RemoveAllTextures();

  function LoadFromStream(Stream: TStream): Boolean;
  function LoadFromFile(const FileName: string): Boolean;
  function LoadFromASDb(const Key: string; ASDb: TASDb): Boolean;

  function RetreiveTex(Pattern: Integer;
   var Mapping: TPoint4): Integer; overload;
  function RetreiveTex(Pattern: Integer; const SrcRect: TRect; Mirror,
   Flip: Boolean; var Mapping: TPoint4): Integer; overload;

  procedure HandleDeviceReset(); virtual;
  procedure HandleDeviceLost(); virtual;

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
 TAsphyreImages = class
 private
  Images: array of TAsphyreImage;

  SearchObjects: array of Integer;
  SearchDirty  : Boolean;

  DestroyHandle : Cardinal;
  ResetHandle   : Cardinal;
  LostHandle    : Cardinal;

  Archive: TASDb;

  function GetItem(Index: Integer): TAsphyreImage;
  function GetItemCount(): Integer;
  function Insert(Image: TAsphyreImage): Integer;

  procedure OnDeviceDestroy(Sender: TObject; Param: Pointer;
   var Handled: Boolean);
  procedure OnDeviceReset(Sender: TObject; Param: Pointer;
   var Handled: Boolean);
  procedure OnDeviceLost(Sender: TObject; Param: Pointer;
   var Handled: Boolean);

  procedure InitSearchObjects();
  procedure SwapSearchObjects(Index1, Index2: Integer);
  function CompareSearchObjects(Obj1, Obj2: TAsphyreImage): Integer;
  function SplitSearchObjects(Start, Stop: Integer): integer;
  procedure SortSearchObjects(Start, Stop: integer);
  procedure UpdateSearchObjects();
  function GetImage(const Name: string): TAsphyreImage;
 public
  property Items[Index: Integer]: TAsphyreImage read GetItem; default;
  property ItemCount: Integer read GetItemCount;

  property Image[const Name: string]: TAsphyreImage read GetImage;

  function IndexOf(Element: TAsphyreImage): Integer; overload;
  function IndexOf(const Name: string): Integer; overload;
  function Include(Element: TAsphyreImage): Integer;
  procedure Remove(Index: Integer);

  function AddFromASDb(const Key: string; ASDb: TASDb;
   const Name: string = ''; MipMapping: Boolean = True): Integer;

  function AddFromASDbEx(const Key: string; ASDb: TASDb;
   const Name: string = ''; PixelFormat: TAsphyrePixelFormat = apf_Unknown;
   MipMapping: Boolean = True; DynamicImage: Boolean = False): Integer;

  function AddFromFile(const FileName: string; const Name: string = '';
   MipMapping: Boolean = True): Integer;

  function AddFromFileEx(const FileName: string; const Name: string = '';
   PixelFormat: TAsphyrePixelFormat = apf_Unknown; MipMapping: Boolean = True;
   DynamicImage: Boolean = False): Integer;

  procedure RemoveAll();
  procedure MarkSearchDirty();

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 AsphyreUtils, AbstractDevices, AsphyreFactory, AsphyreBmp, AsphyreBmpLoad,
 AsphyreConv, AsphyreLegacyFormats, MediaUtils, AsphyreAuth;

//---------------------------------------------------------------------------
constructor TAsphyreImage.Create();
begin
 inherited;

 FPatternCount:= -1;
 FPatternSize := ZeroPoint2px;
 FMipMapping  := False;
 FPixelFormat := apf_Unknown;
 FDynamicImage:= False;
end;

//---------------------------------------------------------------------------
destructor TAsphyreImage.Destroy();
begin
 RemoveAllTextures();

 inherited;
end;

//---------------------------------------------------------------------------
function TAsphyreImage.GetTexture(Index: Integer): TAsphyreLockableTexture;
begin
 if (Index >= 0)and(Index < Length(Textures)) then
  Result:= Textures[Index] else Result:= nil;
end;

//---------------------------------------------------------------------------
function TAsphyreImage.GetTextureCount(): Integer;
begin
 Result:= Length(Textures);
end;

//---------------------------------------------------------------------------
procedure TAsphyreImage.HandleDeviceReset();
var
 i: Integer;
begin
 for i:= 0 to Length(Textures) - 1 do
  if (Textures[i] <> nil) then Textures[i].HandleDeviceReset();
end;

//---------------------------------------------------------------------------
procedure TAsphyreImage.HandleDeviceLost();
var
 i: Integer;
begin
 for i:= 0 to Length(Textures) - 1 do
  if (Textures[i] <> nil) then Textures[i].HandleDeviceLost();
end;

//---------------------------------------------------------------------------
function TAsphyreImage.InsertTexture(): Integer;
var
 Texture: TAsphyreLockableTexture;
begin
 Texture:= Factory.CreateLockableTexture();
 if (Texture = nil) then
  begin
   Result:= -1;
   Exit;
  end;

 Result:= Length(Textures);
 SetLength(Textures, Result + 1);

 Textures[Result]:= Texture;
end;

//---------------------------------------------------------------------------
function TAsphyreImage.IndexOfTexture(Texture: TAsphyreLockableTexture): Integer;
var
 i: Integer;
begin
 Result:= -1;

 for i:= 0 to Length(Textures) - 1 do
  if (Textures[i] = Texture) then
   begin
    Result:= i;
    Break;
   end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImage.RemoveTexture(Index: Integer);
var
 i: Integer;
begin
 if (Index < 0)or(Index >= Length(Textures)) then Exit;

 if (Textures[Index] <> nil) then FreeAndNil(Textures[Index]);

 for i:= Index to Length(Textures) - 2 do
  Textures[i]:= Textures[i + 1];

 SetLength(Textures, Length(Textures) - 1);
end;

//---------------------------------------------------------------------------
procedure TAsphyreImage.RemoveAllTextures();
var
 i: Integer;
begin
 for i:= 0 to Length(Textures) - 1 do
  if (Textures[i] <> nil) then
   begin
    Textures[i].Free();
    Textures[i]:= nil;
   end;

 SetLength(Textures, 0);
end;

//---------------------------------------------------------------------------
function TAsphyreImage.InsertTexture(Width,
 Height: Integer): TAsphyreLockableTexture;
var
 Index: Integer;
begin
 Result:= Factory.CreateLockableTexture();
 if (Result = nil) then Exit;

 Result.Width := Width;
 Result.Height:= Height;
 Result.Format:= FPixelFormat;

 Result.MipMapping:= FMipMapping;
 Result.DynamicTexture:= FDynamicImage;

 if (not Result.Initialize()) then
  begin
   FreeAndNil(Result);
   Exit;
  end;

 Index:= Length(Textures);
 SetLength(Textures, Index + 1);

 Textures[Index]:= Result;
end;

//---------------------------------------------------------------------------
function TAsphyreImage.LoadFromFile(const FileName: string): Boolean;
var
 Image  : TBitmapEx;
 Texture: TAsphyreLockableTexture;
 Bits   : Pointer;
 Pitch  : Integer;
 Index  : Integer;
 WritePx: Pointer;
begin
 RemoveAllTextures();

 Image:= TBitmapEx.Create();

 if (not LoadBitmap(FileName, Image)) then
  begin
   Image.Free();
   Result:= False;
   Exit;
  end;

 if (FPixelFormat = apf_Unknown) then
  begin
   FPixelFormat:= apf_A8R8G8B8;
   if (Image.PixelFormat <> pf32bit) then
    begin
     FPixelFormat:= apf_R8G8B8;
     Image.PixelFormat:= pf32bit;
    end else
    begin
     if (not Image.HasAlphaChannel()) then
      FPixelFormat:= apf_X8R8G8B8;
    end;
  end else
   if (Image.PixelFormat <> pf32bit) then Image.PixelFormat:= pf32bit;

 Texture:= InsertTexture(Image.Width, Image.Height);
 if (Texture = nil) then
  begin
   Image.Free();
   Result:= False;
   Exit;
  end;

 Texture.Lock(Bounds(0, 0, Texture.Width, Texture.Height), Bits, Pitch);
 if (Bits = nil)or(Pitch < 1) then
  begin
   RemoveAllTextures();
   Image.Free();
   Result:= False;
   Exit;
  end;

 WritePx:= Bits;

 for Index:= 0 to Image.Height - 1 do
  begin
   Pixel32toXArray(Image.ScanLine[Index], WritePx, Texture.Format, Image.Width);

   Inc(Integer(WritePx), Pitch);
  end;

 Texture.Unlock();
 Image.Free();

 if (Texture.MipMapping) then Texture.UpdateMipmaps();
 Result:= True;
end;

//---------------------------------------------------------------------------
function TAsphyreImage.UploadStreamNative(Stream: TStream;
 Texture: TAsphyreLockableTexture): Boolean;
var
 Bits : Pointer;
 Pitch: Integer;
 Bytes: Integer;
 Index: Integer;
begin
 Texture.Lock(Bounds(0, 0, Texture.Width, Texture.Height), Bits, Pitch);

 Result:= (Bits <> nil)and(Pitch > 0);
 if (not Result) then
  begin
   Result:= False;
   Exit;
  end;

 Bytes:= Texture.BytesPerPixel * Texture.Width;

 for Index:= 0 to Texture.Height - 1 do
  begin
   Result:= Stream.Read(Bits^, Bytes) = Bytes;
   if (not Result) then Break;

   Inc(Integer(Bits), Pitch);
  end;

 Texture.Unlock();
end;

//---------------------------------------------------------------------------
function TAsphyreImage.UploadStream32toX(Stream: TStream;
 Texture: TAsphyreLockableTexture{; InFormat: TAsphyrePixelFormat}): Boolean;
var
 Bits  : Pointer;
 Pitch : Integer;
 InMem : Pointer;
 InSize: Integer;
 Index : Integer;
begin
 Texture.Lock(Bounds(0, 0, Texture.Width, Texture.Height), Bits, Pitch);

 Result:= (Bits <> nil)and(Pitch > 0);
 if (not Result) then
  begin
   Result:= False;
   Exit;
  end;

 InSize:= Texture.Width * 4;
 InMem := AllocMem(InSize);

 for Index:= 0 to Texture.Height - 1 do
  begin
   Result:= Stream.Read(InMem^, InSize) = InSize;
   if (not Result) then Break;

   Pixel32toXArray(InMem, Bits, Texture.Format, Texture.Width);

   Inc(Integer(Bits), Pitch);
  end;

 FreeMem(InMem);

 Texture.Unlock();
end;

//---------------------------------------------------------------------------
function TAsphyreImage.UploadStreamXtoX(Stream: TStream;
 Texture: TAsphyreLockableTexture; InFormat: TAsphyrePixelFormat): Boolean;
var
 Bits   : Pointer;
 Pitch  : Integer;
 InMem  : Pointer;
 InSize : Integer;
 AuxMem : Pointer;
 AuxSize: Integer;
 Index  : Integer;
begin
 Texture.Lock(Bounds(0, 0, Texture.Width, Texture.Height), Bits, Pitch);

 Result:= (Bits <> nil)and(Pitch > 0);
 if (not Result) then
  begin
   Result:= False;
   Exit;
  end;

 InSize:= (AsphyrePixelFormatBits[InFormat] * Texture.Width) div 8;
 InMem := AllocMem(InSize);

 AuxSize:= Texture.Width * 4;
 AuxMem := AllocMem(AuxSize);

 for Index:= 0 to Texture.Height - 1 do
  begin
   Result:= Stream.Read(InMem^, InSize) = InSize;
   if (not Result) then Break;

   PixelXto32Array(InMem, AuxMem, InFormat, Texture.Width);
   Pixel32toXArray(AuxMem, Bits, Texture.Format, Texture.Width);

   Inc(Integer(Bits), Pitch);
  end;

 FreeMem(AuxMem);
 FreeMem(InMem);

 Texture.Unlock();
end;

//---------------------------------------------------------------------------
function TAsphyreImage.StreamToPixelFormat(Value: Byte): TAsphyrePixelFormat;
begin
 if (Value and $80 > 0) then
  begin // Extended pixel format
   Result:= TAsphyrePixelFormat(Value and $7F); 
  end else
  begin // Legacy pixel format
   Result:= LegacyToPixelFormat(TColorFormat(Value));
  end;
end;

//---------------------------------------------------------------------------
function TAsphyreImage.LoadFromStream(Stream: TStream): Boolean;
var
 StreamFormat: Byte;
 StoredFormat: TAsphyrePixelFormat;
 TextureSize : TPoint2px;
 TextureCount: Integer;
 TextureNo   : Integer;
 Texture     : TAsphyreLockableTexture;
begin
 RemoveAllTextures();

 Result:= True;

 try
  Stream.ReadBuffer(StreamFormat,  SizeOf(TColorFormat));
  Stream.ReadBuffer(FPatternSize,  SizeOf(TPoint2px));
  Stream.ReadBuffer(FVisibleSize,  SizeOf(TPoint2px));
  Stream.ReadBuffer(FPatternCount, SizeOf(Integer));
  Stream.ReadBuffer(TextureSize,   SizeOf(TPoint2px));
  Stream.ReadBuffer(TextureCount,  SizeOf(Integer));
 except
  Result:= False;
  Exit;
 end;

 StoredFormat:= StreamToPixelFormat(StreamFormat);
 if (FPixelFormat = apf_Unknown) then FPixelFormat:= StoredFormat;

 for TextureNo:= 0 to TextureCount - 1 do
  begin
   Texture:= InsertTexture(TextureSize.x, TextureSize.y);
   if (Texture = nil) then
    begin
     RemoveAllTextures();
     Result:= False;
     Exit;
    end;

   if (StoredFormat = Texture.Format) then
    begin
     Result:= UploadStreamNative(Stream, Texture);
    end else
    begin
     if (StoredFormat = apf_A8R8G8B8) then UploadStream32toX(Stream, Texture)
      else UploadStreamXtoX(Stream, Texture, StoredFormat);
    end;
   if (not Result) then
    begin
     RemoveAllTextures();
     Break;
    end;

   if (Texture.MipMapping) then Texture.UpdateMipmaps();
  end;
end;

//---------------------------------------------------------------------------
function TAsphyreImage.LoadFromASDb(const Key: string; ASDb: TASDb): Boolean;
var
 Stream: TMemoryStream;
begin
 Stream:= TMemoryStream.Create();

 // (1) Make sure ASDb is up-to-date.
 Result:= ASDb.UpdateOnce();
 if (not Result) then Exit;

 // (2) Provide password for secure ASDb archives.
 Auth.Authorize(Self, ASDb);

 // (3) Read the requested record as stream.
 Result:= ASDb.ReadStream(Key, Stream);
 if (not Result) then
  begin
   Auth.Unauthorize();
   Stream.Free();
   Exit;
  end;

 // (4) Burn the archive password.
 Auth.Unauthorize();

 // (5) Load graphics data from stream.
 Stream.Seek(0, soFromBeginning);
 Result:= LoadFromStream(Stream);

 // (6) Release the stream.
 Stream.Free();
end;

//---------------------------------------------------------------------------
function TAsphyreImage.FindPatternTex(Pattern: Integer; out PatInRow,
 PatInCol: Integer): Integer;
var
 TexIndex, PatInTex: Integer;
begin
 TexIndex:= 0;
 PatInTex:= -1;
 PatInRow:= 1;
 PatInCol:= 1;

 // Cycle through textures to find where Pattern is located.
 while (TexIndex < Length(Textures)) do
  begin
   PatInRow:= Textures[TexIndex].Width div FPatternSize.x;
   PatInCol:= Textures[TexIndex].Height div FPatternSize.y;
   PatInTex:= PatInRow * PatInCol;

   if (Pattern >= PatInTex) then
    begin
     Inc(TexIndex);
     Dec(Pattern, PatInTex);
    end else Break;
  end;

 // If couldn't find the desired texture, just exit.
 if (TexIndex >= Length(Textures))or(Pattern >= PatInTex) then
  begin
   Result:= -1;
   Exit;
  end;

 Result:= TexIndex;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImage.FindPatternMapping(Pattern, PatInRow,
 PatInCol: Integer; Tex: TAsphyreLockableTexture; var Mapping: TPoint4);
var
 Source: TPoint2px;
 Dest  : TPoint2px;
begin
 Source.x:= (Pattern mod PatInRow) * FPatternSize.x;
 Source.y:= ((Pattern div PatInRow) mod PatInCol) * FPatternSize.y;
{$IFDEF VER185}
  Dest    := Vectors2pxAdd(Source, FVisibleSize);
{$ELSE}
  Dest    := Source + FVisibleSize;
{$ENDIF}

 Mapping[0].x:= Source.x / Tex.Width;
 Mapping[0].y:= Source.y / Tex.Height;

 Mapping[1].x:= Dest.x / Tex.Width;
 Mapping[1].y:= Mapping[0].y;

 Mapping[2].x:= Mapping[1].x;
 Mapping[2].y:= Dest.y / Tex.Height;

 Mapping[3].x:= Mapping[0].x;
 Mapping[3].y:= Mapping[2].y;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImage.FindPatternMapping(Pattern, PatInRow, PatInCol: Integer;
 const ViewPos, ViewSize: TPoint2px; Tex: TAsphyreLockableTexture;
 var Mapping: TPoint4);
var
 Source : TPoint2px;
 Dest   : TPoint2px;
begin
 Source.x:= (Pattern mod PatInRow) * FPatternSize.x + ViewPos.x;
 Source.y:= ((Pattern div PatInRow) mod PatInCol) * FPatternSize.y + ViewPos.y;
 Dest.x  := Source.x + Min2(ViewSize.x, FVisibleSize.x);
 Dest.y  := Source.y + Min2(ViewSize.y, FVisibleSize.y);

 Mapping[0].x:= Source.x / Tex.Width;
 Mapping[0].y:= Source.y / Tex.Height;

 Mapping[1].x:= Dest.x / Tex.Width;
 Mapping[1].y:= Mapping[0].y;

 Mapping[2].x:= Mapping[1].x;
 Mapping[2].y:= Dest.y / Tex.Height;

 Mapping[3].x:= Mapping[0].x;
 Mapping[3].y:= Mapping[2].y;
end;

//---------------------------------------------------------------------------
function TAsphyreImage.RetreiveTex(Pattern: Integer;
 var Mapping: TPoint4): Integer;
var
 PatInRow, PatInCol: Integer;
begin
 Result:= FindPatternTex(Pattern, PatInRow, PatInCol);
 if (Result = -1) then Exit;

 FindPatternMapping(Pattern, PatInRow, PatInCol, Textures[Result], Mapping);
end;

//---------------------------------------------------------------------------
function TAsphyreImage.RetreiveTex(Pattern: Integer; const SrcRect: TRect;
 Mirror, Flip: Boolean; var Mapping: TPoint4): Integer;
var
 PatInRow, PatInCol: Integer;
 Aux: Single;
begin
 Result:= FindPatternTex(Pattern, PatInRow, PatInCol);
 if (Result = -1) then Exit;
{$IFDEF VER185}
 FindPatternMapping(Pattern, PatInRow, PatInCol, PointToPoint2px(SrcRect.TopLeft),
  Point2px(SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top),
  Textures[Result], Mapping);
{$ELSE}
 FindPatternMapping(Pattern, PatInRow, PatInCol, SrcRect.TopLeft,
  Point2px(SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top),
  Textures[Result], Mapping);
{$ENDIF}

 if (Mirror) then
  begin
   Aux:= Mapping[0].x;

   Mapping[0].x:= Mapping[1].x;
   Mapping[3].x:= Mapping[1].x;
   Mapping[1].x:= Aux;
   Mapping[2].x:= Aux;
  end;
 if (Flip) then
  begin
   Aux:= Mapping[0].y;

   Mapping[0].y:= Mapping[2].y;
   Mapping[1].y:= Mapping[2].y;
   Mapping[2].y:= Aux;
   Mapping[3].y:= Aux;
  end;
end;

//---------------------------------------------------------------------------
constructor TAsphyreImages.Create();
begin
 inherited;

 Archive:= TASDb.Create();
 Archive.OpenMode:= opReadOnly;

 DestroyHandle:= EventDeviceDestroy.Subscribe(OnDeviceDestroy, -1);
 ResetHandle  := EventDeviceReset.Subscribe(OnDeviceReset, -1);
 LostHandle   := EventDeviceLost.Subscribe(OnDeviceLost, -1);

 SearchDirty:= False;
end;

//---------------------------------------------------------------------------
destructor TAsphyreImages.Destroy();
begin
 EventDeviceDestroy.Unsubscribe(LostHandle);
 EventDeviceDestroy.Unsubscribe(ResetHandle);
 EventDeviceDestroy.Unsubscribe(DestroyHandle);

 RemoveAll();

 FreeAndNil(Archive);

 inherited;
end;

//---------------------------------------------------------------------------
function TAsphyreImages.GetItem(Index: Integer): TAsphyreImage;
begin
 if (Index >= 0)and(Index < Length(Images)) then
  Result:= Images[Index] else Result:= nil;
end;

//---------------------------------------------------------------------------
function TAsphyreImages.GetItemCount(): Integer;
begin
 Result:= Length(Images);
end;

//---------------------------------------------------------------------------
function TAsphyreImages.Insert(Image: TAsphyreImage): Integer;
var
 Index: Integer;
begin
 Index:= Length(Images);
 SetLength(Images, Index + 1);

 Images[Index]:= Image;
 Result:= Index;

 SearchDirty:= True;
end;

//---------------------------------------------------------------------------
function TAsphyreImages.IndexOf(Element: TAsphyreImage): Integer;
var
 i: Integer;
begin
 Result:= -1;

 for i:= 0 to Length(Images) - 1 do
  if (Images[i] = Element) then
   begin
    Result:= i;
    Break;
   end;
end;

//---------------------------------------------------------------------------
function TAsphyreImages.Include(Element: TAsphyreImage): Integer;
begin
 Result:= IndexOf(Element);
 if (Result = -1) then Result:= Insert(Element);
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.RemoveAll();
var
 i: Integer;
begin
 for i:= 0 to Length(Images) - 1 do
  if (Images[i] <> nil) then
   FreeAndNil(Images[i]);

 SetLength(Images, 0);

 SearchDirty:= True;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.OnDeviceDestroy(Sender: TObject; Param: Pointer;
 var Handled: Boolean);
begin
 RemoveAll();
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.OnDeviceReset(Sender: TObject; Param: Pointer;
 var Handled: Boolean);
var
 i: Integer;
begin
 for i:= 0 to Length(Images) - 1 do
  if (Images[i] <> nil) then Images[i].HandleDeviceReset();
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.OnDeviceLost(Sender: TObject; Param: Pointer;
 var Handled: Boolean);
var
 i: Integer;
begin
 for i:= 0 to Length(Images) - 1 do
  if (Images[i] <> nil) then Images[i].HandleDeviceLost();
end;

//---------------------------------------------------------------------------
function TAsphyreImages.AddFromASDbEx(const Key: string; ASDb: TASDb;
 const Name: string; PixelFormat: TAsphyrePixelFormat; MipMapping,
 DynamicImage: Boolean): Integer;
var
 Image: TAsphyreImage;
begin
 Image:= TAsphyreImage.Create();
 if (Name <> '') then Image.Name:= Name
  else Image.Name:= ExtractPureKey(Key);

 Image.MipMapping  := MipMapping;
 Image.DynamicImage:= DynamicImage;
 Image.PixelFormat := PixelFormat;

 if (not Image.LoadFromASDb(Key, ASDb)) then
  begin
   Image.Free();
   Result:= -1;
   Exit;
  end;

 Result:= Insert(Image);
end;

//---------------------------------------------------------------------------
function TAsphyreImages.AddFromASDb(const Key: string; ASDb: TASDb;
 const Name: string = ''; MipMapping: Boolean = True): Integer;
begin
 Result:= AddFromASDbEx(Key, ASDb, Name, apf_Unknown, MipMapping, False);
end;

//---------------------------------------------------------------------------
function TAsphyreImages.AddFromFileEx(const FileName, Name: string;
 PixelFormat: TAsphyrePixelFormat; MipMapping, DynamicImage: Boolean): Integer;
var
 Image: TAsphyreImage;
begin
 Image:= TAsphyreImage.Create();
 if (Name <> '') then Image.Name:= Name
  else Image.Name:= ChangeFileExt(ExtractFileName(FileName), '');

 Image.MipMapping  := MipMapping;
 Image.DynamicImage:= DynamicImage;
 Image.PixelFormat := PixelFormat;

 if (not Image.LoadFromFile(FileName)) then
  begin
   Image.Free();
   Result:= -1;
   Exit;
  end;

 Result:= Insert(Image);
end;

//---------------------------------------------------------------------------
function TAsphyreImages.AddFromFile(const FileName: string;
 const Name: string = ''; MipMapping: Boolean = True): Integer;
begin
 Result:= AddFromFileEx(FileName, Name, apf_Unknown, MipMapping, False);
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.Remove(Index: Integer);
var
 i: Integer;
begin
 if (Index < 0)or(Index >= Length(Images)) then Exit;

 if (Images[Index] <> nil) then FreeAndNil(Images[Index]);

 for i:= Index to Length(Images) - 2 do
  Images[i]:= Images[i + 1];

 SetLength(Images, Length(Images) - 1);

 SearchDirty:= True;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.InitSearchObjects();
var
 i: Integer;
begin
 if (Length(Images) <> Length(SearchObjects)) then
  SetLength(SearchObjects, Length(Images));

 for i:= 0 to Length(Images) - 1 do
  SearchObjects[i]:= i;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.SwapSearchObjects(Index1, Index2: Integer);
var
 Aux: Integer;
begin
 Aux:= SearchObjects[Index1];

 SearchObjects[Index1]:= SearchObjects[Index2];
 SearchObjects[Index2]:= Aux;
end;

//---------------------------------------------------------------------------
function TAsphyreImages.CompareSearchObjects(Obj1, Obj2: TAsphyreImage): Integer;
begin
 Result:= CompareText(Obj1.Name, Obj2.Name);
end;

//---------------------------------------------------------------------------
function TAsphyreImages.SplitSearchObjects(Start, Stop: Integer): integer;
var
 Left, Right: Integer;
 Pivot: TAsphyreImage;
begin
 Left := Start + 1;
 Right:= Stop;
 Pivot:= Images[SearchObjects[Start]];

 while (Left <= Right) do
  begin
   while (Left <= Stop)and(CompareSearchObjects(Images[SearchObjects[Left]],
    Pivot) < 0) do Inc(Left);

   while (Right > Start)and(CompareSearchObjects(Images[SearchObjects[Right]],
    Pivot) >= 0) do Dec(Right);

   if (Left < Right) then SwapSearchObjects(Left, Right);
  end;

 SwapSearchObjects(Start, Right);

 Result:= Right;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.SortSearchObjects(Start, Stop: integer);
var
 SplitPt: integer;
begin
 if (Start < Stop) then
  begin
   SplitPt:= SplitSearchObjects(Start, Stop);

   SortSearchObjects(Start, SplitPt - 1);
   SortSearchObjects(SplitPt + 1, Stop);
  end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.UpdateSearchObjects();
begin
 InitSearchObjects();
 SortSearchObjects(0, Length(SearchObjects) - 1);

 SearchDirty:= False;
end;

//---------------------------------------------------------------------------
function TAsphyreImages.IndexOf(const Name: string): Integer;
var
 Lo, Hi, Mid: Integer;
begin
 if (SearchDirty) then UpdateSearchObjects();

 Result:= -1;

 Lo:= 0;
 Hi:= Length(SearchObjects) - 1;

 while (Lo <= Hi) do
  begin
   Mid:= (Lo + Hi) div 2;

   if (CompareText(Images[SearchObjects[Mid]].Name, Name) = 0) then
    begin
     Result:= SearchObjects[Mid];
     Break;
    end;

   if (CompareText(Images[SearchObjects[Mid]].Name, Name) > 0) then
    Hi:= Mid - 1 else Lo:= Mid + 1;
 end;
end;

//---------------------------------------------------------------------------
function TAsphyreImages.GetImage(const Name: string): TAsphyreImage;
var
 Index: Integer;
begin
 Index:= IndexOf(Name);
 if (Index <> -1) then Result:= Images[Index] else Result:= nil;
end;

//---------------------------------------------------------------------------
procedure TAsphyreImages.MarkSearchDirty();
begin
 SearchDirty:= True;
end;

//---------------------------------------------------------------------------
end.
