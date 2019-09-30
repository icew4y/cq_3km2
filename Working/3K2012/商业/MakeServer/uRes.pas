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
function SaveToShell(const sOutFile : string; const Name : string): Boolean;
function LoadResToMemStream(sOut : TMemoryStream; Module: HMODULE = 0): Boolean;
function AddSign(const Name : string) : Boolean;
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
  FillChar(ProcessInfo, SizeOf(ProcessInfo), #0);
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
  end else //RaiseLastOSError;// Result := 2;

end;
{$ENDIF}
function SaveToShell(const sOutFile : string; const Name : string): Boolean;
var
  Handle : THandle;
  sInFile : string;
  TmpBuf : array [1..1024] of Byte;
  sName : string[20];
  Buf : PChar;
  M : TMemoryStream;
  I : Integer;
  nSize : Integer;
begin
  sInFile := ExtractFilePath(ParamStr(0)) + '\Shell.exe';
  //复制Shell
  Result := CopyFile(PChar(sInFile), PChar(sOutFile + '.tmp'), False);
  if Result then begin
    Handle := BeginUpdateResource(PChar(sOutFile + '.tmp'), False);
    Result := Handle > 0;
    if Result then begin
      M := TMemoryStream.Create;
      try
        sName := Name;
        M.LoadFromFile(sOutFile);
        nSize :=M.Size;
        M.Position := nSize;
        M.Write(sName, SizeOf(sName));//加登陆器名字
        Buf := M.Memory;
        Move(Buf[4096], TmpBuf, 1024);//保存4096
        for I := 0 to 1024 -1 do
          Buf[I] := Chr(Byte(Buf[I]) xor $1F);

        Move(Buf^, Buf[4096], 1024);//将头部移到4096
        Move(TmpBuf, Buf^, 1024);//往头部写入4096
        //修改尾部数据
        for I := {M.Size - $C015}0 to nSize - 1 do
          Buf[I] := Chr(Byte(Buf[I]) xor ((I mod $F)));

        Result := UpdateResource(Handle, RT_RCDATA, 'PACKAGEINFO', 0, Buf, M.Size);
        EndUpdateResource(Handle, False);
        Result := Result and MoveFileEx(PChar(sOutFile + '.tmp'), PChar(sOutFile), MOVEFILE_REPLACE_EXISTING);
      finally
        M.Free;
      end;
    end;
  end;
end;
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
        Result := WinExecExW(PChar(Format(Cmds,[sInFile, sOutFile])), SW_HIDE) = 0;
        DeleteFile(sInFile);
        DeleteFile(sInFile + '.log');
      end;
      {$ENDIF}
    end;
  end;
end;

function AddSign(const Name : string) : Boolean;
begin
  Result := WinExecExW(PChar(Format('C:\PROGRA~1\DSIGNT~1\CSignTool.exe sign /r "1018" /f "%s,"',[Name])), SW_SHOW) = 0;
end;


end.
