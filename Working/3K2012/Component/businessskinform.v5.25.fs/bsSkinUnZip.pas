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

unit bsSkinUnZip;

interface

uses
  Windows, Messages, SysUtils, Classes;

type
  TDllPrnt = function(Buffer: PChar; Size: ULONG): integer; stdcall;
  TDllPassword = function(P: PChar; N: Integer; M, Name: PChar): integer; stdcall;
  TDllService = function (CurFile: PChar; Size: ULONG): integer; stdcall;
  TDllSnd = procedure; stdcall;
  TDllReplace = function(FileName: PChar): integer; stdcall;
  TDllMessage = procedure (UnCompSize: ULONG; CompSize: ULONG; Factor: UINT;
                           Month: UINT; Day: UINT; Year: UINT; Hour: UINT;
                           Minute: UINT; C: Char;
                           FileName: PChar; MethBuf: PChar; CRC: ULONG;
                           Crypt: Char); stdcall;

  TUserFunctions = record
    Print: TDllPrnt;
    Sound: TDllSnd;
    Replace: TDllReplace;
    Password: TDllPassword;
    SendApplicationMessage: TDllMessage;
    ServCallBk: TDllService;
    TotalSizeComp: ULONG;
    TotalSize: ULONG;
    CompFactor: Integer;
    NumMembers: UINT;
    cchComment: UINT;
  end;

  TDCL = record
    ExtractOnlyNewer: Integer;
    SpaceToUnderscore: Integer;
    PromptToOverwrite: Integer;
    fQuiet: Integer;
    nCFlag: Integer;
    nTFlag: Integer;
    nVFlag: Integer;
    nUFlag: Integer;
    nZFlag: Integer;
    nDFlag: Integer;
    nOFlag: Integer;
    nAFlag: Integer;
    nZIFlag: Integer;
    C_flag: Integer;
    fPrivilege: Integer;
    lpszZipFN: PChar;
    lpszExtractDir: PChar;   
  end ;

  TbsSkinUnZip = class(TComponent)
  protected
    procedure SetUserFunctions(var UF: TUserFunctions);
    procedure SetUnZipOptions(var AOptions: TDCL; var AFileName, ADirName: PChar);
  public
    procedure UnZipToDir(AFileName, ADir: String);
  end;

function DllPrnt(Buffer: PChar; Size: ULONG): integer; stdcall;
function DllPassword(P: PChar; N: Integer; M, Name: PChar): integer; stdcall;
function DllReplace(FileName: PChar): integer; stdcall;
function DllService(CurFile: PChar; Size: ULONG): integer; stdcall;
procedure DllMessage(UnCompSize: ULONG; CompSize: ULONG; Factor: UINT;
                     Month: UINT; Day: UINT; Year: UINT;
                     Hour: UINT; Minute: UINT; C: Char;
                     FileName: PChar; MethBuf: PChar;
                     CRC: ULONG; Crypt: Char); stdcall;


implementation

uses ShellApi;

type
  PPChar = ^PChar;

const
  UNZIPDLLNAME = 'unzip32.dll';

function DllPrnt(Buffer: PChar; Size: ULONG): integer;
begin
  Result := Size;
end;

function DllReplace(FileName: PChar): integer;
begin
  Result := 1;
end;

function DllPassword(P: PChar; N: Integer; M, Name: PChar): integer;
begin
  Result := 1;
end;

function DllService(CurFile: PChar; Size: ULONG): integer;
begin
  Result := 0;
end;

procedure DllMessage(UnCompSize: ULONG; CompSize: ULONG; Factor: UINT;
                     Month: UINT; Day: UINT; Year: UINT; Hour: UINT; Minute: UINT;
                     C: Char; FileName: PChar; MethBuf: PChar; CRC: ULONG;
                     Crypt: Char);
begin
end;

procedure TbsSkinUnZip.SetUserFunctions;
begin
  with UF do
  begin
    @Print := @DllPrnt;
    @Replace := @DllReplace;
    @Sound := nil;
    @Password := @DllPassword;
    @SendApplicationMessage := @DllMessage;
    @ServCallBk := @DllService;
  end;
end;

procedure TbsSkinUnZip.SetUnZipOptions;
begin
  with AOptions do
  begin
    ExtractOnlyNewer := 0;
    SpaceToUnderscore := 0;
    PromptToOverwrite := 1;
    fQuiet := 0;
    nCFlag := 0;
    nTFlag := 0;
    nVFlag := 0;
    nUFlag := 0;
    nZFlag := 0;
    nDFlag := 0;
    nOFlag := 0;
    nAFlag := 0;
    nZIFlag := 0;
    C_flag := 1;
    fPrivilege := 1;
    lpszExtractDir := ADirName;
    lpszZipFN := AFileName;
  end;
end;

procedure TbsSkinUnZip.UnZipToDir;
var
  UserFunctions: TUserFunctions;
  Opt: TDCL;
  FileName, DirName: PChar;
  UnZip32: Cardinal;
  Wiz_SingleEntryUnzip: function (ifnc: Integer; ifnv: PPChar; xfnc: Integer;
                                  xfnv: PPChar; var Options: TDCL;
                                  var UserFunc: TUserFunctions): Integer; stdcall;
begin
  UnZip32 := LoadLibrary(UNZIPDLLNAME);
  if UnZip32 <> 0
  then
    begin
      Wiz_SingleEntryUnzip := GetProcAddress(UnZip32, 'Wiz_SingleEntryUnzip');
      if (@Wiz_SingleEntryUnzip <> nil)
      then
        begin
          FileName := PChar(AFileName);
          DirName := PChar(ADir);
          SetUserFunctions(UserFunctions);
          SetUnZipOptions(Opt, FileName, DirName);
          WIZ_SingleEntryUnzip(0, nil, 0, nil, Opt, UserFunctions);
        end;
      FreeLibrary(UnZip32);
    end;
 end;

end.
