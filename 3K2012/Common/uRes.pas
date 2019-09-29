{*******************************************************}
{                                                       }
{       PE资源读写                                      }
{                                                       }
{       版权所有 (C) 2012 TasNat                        }
{                                                       }
{*******************************************************}

unit uRes;
{$DEFINE UseWL}

interface
uses
  Windows, SysUtils, Classes;
function LoadRes(var OutData : PChar; var OutSize : DWord; Module: HMODULE = 0): Boolean;
function SaveRes(sFileName : string; const sOutFile : string; Buf : PChar; BufSize : DWord): Boolean;
function LoadResToMemStream(sOut : TMemoryStream; Module: HMODULE = 0): Boolean;
var
  Cmds : string = 'cmd /c E:\WinLicense\WinLicense /protect DLQ /inputfile "%s" /outputfile "%s"';
  TimeOut : DWord = 60*1000;
implementation

function LoadResToMemStream(sOut : TMemoryStream; Module: HMODULE = 0): Boolean;
var
  OutData : PChar;
  OutSize : DWord;
begin
  sOut.Clear;
  Result := LoadRes(OutData, OutSize, Module) and (OutData <> nil) and (OutSize > 0);
  if Result then begin
    sOut.Write(OutData^, OutSize);
  end;
end;

function LoadRes(var OutData : PChar; var OutSize : DWord; Module: HMODULE = 0): Boolean;
var
  ResInfo: HRSRC;
  Data: THandle;
begin
  OutData := nil;
  ResInfo := FindResource(Module, 'PACKAGEINFO', RT_RCDATA);
  Result := ResInfo <> 0;
  if Result then
  begin
    OutSize := SizeofResource(Module, ResInfo);
    Result := OutSize > 0;
    if Result then begin
      Data := LoadResource(Module, ResInfo);
      Result := Data <> 0;
      if Result then
      try
        OutData := LockResource(Data);
        Result := OutData <> nil;
        UnlockResource(Data);
      finally
        FreeResource(Data);
      end;
    end;
  end;
end;
{$Ifdef UseWL}
function WinExecExW(cmd: PChar; visiable: integer): DWORD;
var
  StartupInfo       : TStartupInfo;
  ProcessInfo       : TProcessInformation;
begin
  Result := 1;
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := visiable;
  if CreateProcess(nil, cmd, nil, nil, False, CREATE_FORCEDOS or Create_new_console or Normal_priority_class, nil, nil, StartupInfo, ProcessInfo) then begin
    Result := 0;
    if WaitForSingleObject(ProcessInfo.hProcess, TimeOut) = WAIT_TIMEOUT then
      TerminateProcess(ProcessInfo.hProcess, 1);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end else Result := 2;
end;
{$ENDIF}

function SaveRes(sFileName : string; const sOutFile : string; Buf : PChar; BufSize : DWord): Boolean;
var
  Handle : THandle;
  sInFile : string;
begin
  sInFile := sOutFile{$Ifdef UseWL} + '.tmp'{$ENDIF};
  Result := CopyFile(PChar(sFileName), PChar(sInFile), False);
  if Result then begin
    Handle := BeginUpdateResource(PChar(sInFile), False);
    Result := Handle > 0;
    if Result then begin
      Result := UpdateResource(Handle, RT_RCDATA, 'PACKAGEINFO', 0, Buf, BufSize);
      EndUpdateResource(Handle, False);
      {$Ifdef UseWL}
      if Result then begin
        Result := WinExecExW(PChar(Format(Cmds,[sInFile, sOutFile])), SW_SHOW) = 0;
        DeleteFile(sInFile);
        DeleteFile(sInFile + '.log');
      end;
      {$ENDIF}
    end;
  end;
end;


end.
