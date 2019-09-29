unit DXCommon;

interface

uses
  Windows, SysUtils;

type
{$IFDEF UNICODE}
  PCharAW = PWideChar;
{$ELSE}
  PCharAW = PAnsiChar;
{$ENDIF}

const
  UnrecognizedError = 'Unrecognized Error';

function IsNTandDelphiRunning: boolean;
function RegGetStringValue(Hive: HKEY; const KeyName, ValueName: string): string;
function ExistFile(const FileName: string): Boolean;
function DirectDllFileExist(const FileName: string): Boolean;
implementation

function RegGetStringValue(Hive: HKEY; const KeyName, ValueName: string): string;
var EnvKey: HKEY;
  Buf: array[0..255] of char;
  BufSize: DWord;
  RegType: DWord;
  rc: DWord;
begin
  Result := '';
  BufSize := Sizeof(Buf);
  ZeroMemory(@Buf, BufSize);
  RegType := REG_SZ;
  try
    if (RegOpenKeyEx(Hive, PChar(KeyName), 0, KEY_READ, EnvKey) = ERROR_SUCCESS) then
    begin
      try
        if (ValueName = '') then rc := RegQueryValueEx(EnvKey, nil, nil, @RegType, @Buf, @BufSize)
        else rc := RegQueryValueEx(EnvKey, PChar(ValueName), nil, @RegType, @Buf, @BufSize);
        if rc = ERROR_SUCCESS then Result := string(Buf);
      finally
        RegCloseKey(EnvKey);
      end;
    end;
  finally
    RegCloseKey(Hive);
  end;
end;

function ExistFile(const FileName: string): Boolean;
var hFile: THandle;
begin
  hFile := CreateFile(PChar(FileName), 0, 0, nil, OPEN_EXISTING, 0, 0);
  Result := hFile <> INVALID_HANDLE_VALUE;
  if Result = true then CloseHandle(hFile);
end;

function SystemDir: string;
var
  dir: array[0..MAX_PATH] of Char;
begin
  GetSystemDirectory(dir, MAX_PATH);
  Result := string(dir);
end;

function DirectDllFileExist(const FileName: string): Boolean;  //检测D3D DLL是否存在
var
  sFileName: string;
begin
  Result := FileExists(FileName);
  if not Result then begin
    sFileName := SystemDir + '\' + FileName;
    Result := FileExists(sFileName);
  end;
end;

function IsNTandDelphiRunning: boolean; //检测delphi没有运行 不在设计模式
var
  OSVersion: TOSVersionInfo;
  AppName: array[0..255] of char;
begin
  OSVersion.dwOsVersionInfoSize := sizeof(OSVersion);
  GetVersionEx(OSVersion);
  // Not running in NT or program is not Delphi itself ?
  AppName[0] := #0;
  lstrcat(AppName, PChar(ParamStr(0))); // ParamStr(0) = Application.ExeName
  CharUpperBuff(AppName, SizeOf(AppName));
  result := ((OSVersion.dwPlatformID = VER_PLATFORM_WIN32_NT) and
    (Pos('DELPHI32.EXE', AppName) = Length(AppName) - Length('DELPHI32.EXE') + 1));
end;

end.

