unit AsphyreLegacyFormats;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 AsphyreTypes;

//---------------------------------------------------------------------------
type
 PColorFormat = ^TColorFormat;
 TColorFormat = (COLOR_R3G3B2, COLOR_R5G6B5, COLOR_X8R8G8B8, COLOR_X1R5G5B5,
  COLOR_X4R4G4B4, COLOR_A8R8G8B8, COLOR_A1R5G5B5, COLOR_A4R4G4B4,
  COLOR_A8R3G3B2, COLOR_A2R2G2B2, COLOR_UNKNOWN);

//---------------------------------------------------------------------------
function LegacyToPixelFormat(ColorFormat: TColorFormat): TAsphyrePixelFormat;
function PixelFormatToLegacy(Format: TAsphyrePixelFormat): TColorFormat;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
function LegacyToPixelFormat(ColorFormat: TColorFormat): TAsphyrePixelFormat;
begin
 case ColorFormat of
  COLOR_R3G3B2:
   Result:= apf_R3G3B2;

  COLOR_R5G6B5:
   Result:= apf_R5G6B5;

  COLOR_X8R8G8B8:
   Result:= apf_X8R8G8B8;

  COLOR_X1R5G5B5:
   Result:= apf_X1R5G5B5;

  COLOR_X4R4G4B4:
   Result:= apf_X4R4G4B4;

  COLOR_A8R8G8B8:
   Result:= apf_A8R8G8B8;

  COLOR_A1R5G5B5:
   Result:= apf_A1R5G5B5;

  COLOR_A4R4G4B4:
   Result:= apf_A4R4G4B4;

  COLOR_A8R3G3B2:
   Result:= apf_A8R3G3B2;

  else Result:= apf_Unknown;
 end;
end;

//---------------------------------------------------------------------------
function PixelFormatToLegacy(Format: TAsphyrePixelFormat): TColorFormat;
begin
 case Format of
  apf_R3G3B2:
   Result:= COLOR_R3G3B2;

  apf_R5G6B5:
   Result:= COLOR_R5G6B5;

  apf_X8R8G8B8:
   Result:= COLOR_X8R8G8B8;

  apf_X1R5G5B5:
   Result:= COLOR_X1R5G5B5;

  apf_X4R4G4B4:
   Result:= COLOR_X4R4G4B4;

  apf_A8R8G8B8:
   Result:= COLOR_A8R8G8B8;

  apf_A1R5G5B5:
   Result:= COLOR_A1R5G5B5;

  apf_A4R4G4B4:
   Result:= COLOR_A4R4G4B4;

  apf_A8R3G3B2:
   Result:= COLOR_A8R3G3B2;

  else Result:= COLOR_UNKNOWN;
 end;
end;

//---------------------------------------------------------------------------
end.
