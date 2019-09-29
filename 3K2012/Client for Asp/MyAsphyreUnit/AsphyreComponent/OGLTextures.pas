unit OGLTextures;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 AsphyreTypes, AbstractTextures, SystemSurfaces;

//---------------------------------------------------------------------------
type
 TOGLTexture = class(TAsphyreTexture)
 private
  FTexture: Cardinal;

  function FindInternalFormat(): Integer;
  function BindTexture(): Boolean;
 protected
  function CreateTexture(): Boolean; override;
  procedure DestroyTexture(); override;
 public
  property Texture: Cardinal read FTexture;

  procedure Lock(out Bits: Pointer; out Pitch: Integer); override;
  procedure Unlock(); override;

  function WriteScanline(Index: Integer; Source: Pointer): Boolean; override;

  procedure AssignToStage(StageNo: Integer); override;

  procedure UpdateMipmaps(); override;

  function GetPixelData(Level: Integer;
   Buffer: TSystemSurface): Boolean; override;

  function SetPixelData(Level: Integer;
   Buffer: TSystemSurface): Boolean; override;

  function BeginDrawTo(): Boolean; override;
  procedure EndDrawTo(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 GL, AsphyreErrors;

//---------------------------------------------------------------------------
const
 GL_BGRA = $080E1;

//---------------------------------------------------------------------------
function TOGLTexture.FindInternalFormat(): Integer;
begin
 if (HighQuality) then
  begin
   if (AlphaChannel) then Result:= GL_RGBA8
    else Result:= GL_RGB8;
  end else
  begin
   if (AlphaChannel) then Result:= GL_RGBA4
    else Result:= GL_RGB5;
  end;
end;

//---------------------------------------------------------------------------
function TOGLTexture.BindTexture(): Boolean;
begin
 glBindTexture(GL_TEXTURE_2D, FTexture);

 Result:= glGetError() = GL_NO_ERROR;

 AsphyreError:= errNone;
 if (not Result) then AsphyreError:= errCannotSelectTexture;
end;

//---------------------------------------------------------------------------
function TOGLTexture.CreateTexture(): Boolean;
begin
 FFormat:= COLOR_A8R8G8B8;

 glEnable(GL_TEXTURE_2D);
 glGenTextures(1, @FTexture);

 Result:= BindTexture();
 if (not Result) then Exit;

 glTexImage2D(GL_TEXTURE_2D, 0, FindInternalFormat(), Size.X, Size.Y,
  0, GL_BGRA, GL_UNSIGNED_BYTE, nil);
 Result:= glGetError() = GL_NO_ERROR;

 if (not Result) then
  AsphyreError:= errCannotCreateTexture;
end;

//---------------------------------------------------------------------------
procedure TOGLTexture.DestroyTexture();
begin
 glDeleteTextures(1, @FTexture);
end;

//---------------------------------------------------------------------------
procedure TOGLTexture.Lock(out Bits: Pointer; out Pitch: Integer);
begin
 Bits := nil;
 Pitch:= 0;

 AsphyreError:= errUnsupportedOperation;
end;

//---------------------------------------------------------------------------
procedure TOGLTexture.Unlock();
begin
 // Unsupported
end;

//---------------------------------------------------------------------------
procedure TOGLTexture.AssignToStage(StageNo: Integer);
begin
 BindTexture();
end;

//---------------------------------------------------------------------------
function TOGLTexture.WriteScanline(Index: Integer; Source: Pointer): Boolean;
begin
 Result:= BindTexture();
 if (not Result) then Exit;

 glTexSubImage2D(GL_TEXTURE_2D, 0, 0, Index, Size.x, 1, GL_BGRA,
  GL_UNSIGNED_BYTE, Source);

 Result:= glGetError() = GL_NO_ERROR;
 if (not Result) then AsphyreError:= errUploadTexturePixels;
end;

//---------------------------------------------------------------------------
function TOGLTexture.GetPixelData(Level: Integer;
 Buffer: TSystemSurface): Boolean;
var
 TexWidth, TexHeight: GLint;
begin
 Result:= BindTexture();
 if (not Result) then Exit;

 glGetTexLevelParameteriv(GL_TEXTURE_2D, 0, GL_TEXTURE_WIDTH, @TexWidth);
 glGetTexLevelParameteriv(GL_TEXTURE_2D, 0, GL_TEXTURE_HEIGHT, @TexHeight);

 Buffer.SetSize(TexWidth, TexHeight);

 glGetTexImage(GL_TEXTURE_2D, 0, GL_BGRA, GL_UNSIGNED_BYTE, Buffer.Bits);

 Result:= glGetError() = GL_NO_ERROR;
 if (not Result) then AsphyreError:= errDownloadTexturePixels;
end;

//---------------------------------------------------------------------------
function TOGLTexture.SetPixelData(Level: Integer;
 Buffer: TSystemSurface): Boolean;
begin
 Result:= BindTexture();
 if (not Result) then Exit;

 glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, Size.x, Size.y, GL_BGRA,
  GL_UNSIGNED_BYTE, Buffer.Bits);

 Result:= glGetError() = GL_NO_ERROR;
 if (not Result) then AsphyreError:= errUploadTexturePixels;
end;

//---------------------------------------------------------------------------
procedure TOGLTexture.UpdateMipmaps();
begin
 // Unsupported
end;

//---------------------------------------------------------------------------
function TOGLTexture.BeginDrawTo(): Boolean;
begin
 Result:= False;
 AsphyreError:= errUnsupportedOperation;
end;

//---------------------------------------------------------------------------
procedure TOGLTexture.EndDrawTo();
begin
 // Unsupported
end;

//---------------------------------------------------------------------------
end.
