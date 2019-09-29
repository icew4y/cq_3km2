{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 5.25                                                }
{                                                                   }
{       Copyright (c) 2000-2006 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsSkinZip;

interface

uses
  Windows, Messages, SysUtils, Classes;

type
  TDllPrnt = function(Buffer: PChar; Size: ULONG): integer; stdcall;
  TDllPassword = function(P: PChar; N: Integer; M, Name: PChar): integer; stdcall;
  TDllComment = function(Buffer: PChar): PChar; stdcall;
  TDllService = function(P: PChar; Size: ULONG): integer; stdcall;

  TZPOpt = record
    Date: PChar;
    szRootDir: PChar;
    szTempDir: PChar;
    fTemp: Bool;
    fSuffix: Bool;
    fEncrypt: Bool;
    fSystem: Bool;
    fVolume: Bool;
    fExtra: Bool;
    fNoDirEntries: Bool;
    fExcludeDate: Bool;
    fIncludeDate: Bool;
    fVerbose: Bool;
    fQuiet: Bool;
    fCRLF_LF: Bool;
    fLF_CRLF: Bool;
    fJunkDir: Bool;
    fGrow: Bool;
    fForce: Bool;
    fMove: Bool;
    fDeleteEntries: Bool;
    fUpdate: Bool;
    fFreshen: Bool;
    fJunkSFX: Bool;
    fLatestTime: Bool;
    fComment: Bool;
    fOffsets: Bool;
    fPrivilege: Bool;
    fEncryption: Bool;
    fRecurse: Integer;
    fRepair: Integer;
    fLevel: Char;
  end;

  TPCharArray = array [0..0] of PChar;
  PCharArray  = ^TPCharArray;

  TZCL = record
    argc       : Integer;
    lpszZipFN  : PChar;
    FNV        : PCharArray;     
  end;

  TZipUserFunctions = record
    Print     : TDllPrnt;
    Comment   : TDllComment;
    Password  : TDllPassword;
    Service   : TDllService;
  end;

  TbsSkinZip = class(TComponent)
  protected
    procedure SetDummyInitFunctions(var Z: TZipUserFunctions);
    procedure SetZipOptions(var Opt: TZPOpt);
  public
    procedure ZipFiles(FileName: String; FileList: TStrings);
  end;

function DummyPrint(Buffer: PChar; Size: ULONG): integer; stdcall ;
function DummyPassword(P: PChar; N: Integer; M, Name: PChar): integer; stdcall ;
function DummyComment(Buffer: PChar): PChar; stdcall ;
function DummyService(Buffer: PChar; Size: ULONG): integer; stdcall;

implementation

uses ShellApi;

const
  ZIPDLLNAME = 'zip32.dll';

function DummyPrint(Buffer: PChar; Size: ULONG): integer;
begin
  Result := Size;
end;

function DummyPassword(P: PChar; N: Integer; M, Name: PChar): integer;
begin
  Result := 1;
end;

function DummyComment(Buffer: PChar): PChar;
begin
  Result := Buffer;
end;

function DummyService(Buffer: PChar; Size: ULONG): integer;
begin
  Result := 0;
end;

procedure TbsSkinZip.SetZipOptions;
begin
  with Opt do
  begin
    fJunkDir := True;
  end;
end;

procedure TbsSkinZip.SetDummyInitFunctions(var Z: TZipUserFunctions);
begin
  with Z do
  begin
    @Print := @DummyPrint;
    @Comment := @DummyComment;
    @Password := @DummyPassword;
    @Service := @DummyService;
  end;
end;

procedure TbsSkinZip.ZipFiles(FileName: String; FileList: TStrings);
var
  Zip32: Cardinal;
  Opt: TZPOpt;
  ZpSetOptions: function (var Opts: TZPOpt): Bool; stdcall;
  ZpGetOptions: function: TZPOpt; stdcall;
  ZpInit: function(var lpZipUserFunc: TZipUserFunctions): Integer; stdcall;
  ZpArchive: function(C: TZCL): Integer; stdcall;


procedure Compress;
var
  i: integer;
  ZipRec: TZCL;
  ZUF: TZipUserFunctions;
  FNVStart: PCharArray;
begin
  if FileName = '' then Exit;
  if FileList.Count <= 0 then Exit;
  SetDummyInitFunctions(ZUF);
  ZpInit(ZUF);
  ZipRec.argc := FileList.Count;
  GetMem(ZipRec.lpszZipFN, Length(FileName) + 1 );
  ZipRec.lpszZipFN := StrPCopy( ZipRec.lpszZipFN, FileName);
  try
    GetMem(ZipRec.FNV, ZipRec.argc * SizeOf(PChar));
    FNVStart := ZipRec.FNV;
    try
      for i := 0 to ZipRec.argc - 1 do
      begin
        GetMem(ZipRec.FNV^[i], Length(FileList[i]) + 1 );
        StrPCopy(ZipRec.FNV^[i], FileList[i]);
      end;
      try
        ZpArchive(ZipRec);
      finally
        ZipRec.FNV := FNVStart;
        for i := (ZipRec.argc - 1) downto 0 do
          FreeMem(ZipRec.FNV^[i], Length(FileList[i]) + 1 );
      end;
    finally
      ZipRec.FNV := FNVStart;
      FreeMem(ZipRec.FNV, ZipRec.argc * SizeOf(PChar));
    end;
  finally
    FreeMem(ZipRec.lpszZipFN, Length(FileName) + 1 );
  end;
end;

begin
  Zip32 := LoadLibrary(ZIPDLLNAME);
  if Zip32 <> 0
  then
    begin
      ZpGetOptions := GetProcAddress(Zip32, 'ZpGetOptions');
      ZpSetOptions := GetProcAddress(Zip32, 'ZpSetOptions');
      if (@ZpGetOptions <> nil) and (@ZpSetOptions <> nil)
      then
        begin
          Opt := ZpGetOptions;
          SetZipOptions(Opt);
          ZpSetOptions(Opt);
        end;
      ZpInit := GetProcAddress(Zip32, 'ZpInit');
      ZpArchive := GetProcAddress(Zip32, 'ZpArchive');
      if (@ZpInit <> nil) and (@ZpArchive <> nil)
      then Compress;
      FreeLibrary(Zip32);
    end;
 end;

end.
