{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{               Zip Unit - EZip                  }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EZip;

{$I Exceptions.inc}

interface

uses
  Windows, SysUtils, Classes;

type
  TZipExtractor = class
  protected
    FStream: TMemoryStream;
    FBytesToGo: Integer;
  public
    constructor Create(const InputName: string; OutDir: string);
  end;

  TZipWriter = class
  protected
    FZipHandle: THandle;
    FPassword: string;
  public
    constructor Create(const FileName, Password: string);
    destructor Destroy; override;
    procedure AddFile(const FileName: string; ArchiveFileName: string);
  end;

//------------------------------------------------------------------------------

implementation

uses EZLib;

{ TZipExtractor }

constructor TZipExtractor.Create(const InputName: string; OutDir: string);
begin
  ExtractZipFiles(PChar(InputName), PChar(OutDir), nil);
end;

{ TZipWriter }

constructor TZipWriter.Create(const FileName, Password: string);
begin
  FZipHandle := CreateZipFile(PChar(FileName));
  FPassword := Password;
end;

procedure TZipWriter.AddFile(const FileName: string; ArchiveFileName: string);
begin
  AddZipFile(FZipHandle, PChar(FileName), PChar(ArchiveFileName), PChar(FPassword));
end;

destructor TZipWriter.Destroy;
begin
  CloseZipFile(FZipHandle);
  inherited;
end;

end.

