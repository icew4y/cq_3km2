program Shell;

{.$APPTYPE CONSOLE}

{$R 'VistaUAC.res' 'VistaUAC.rc'}

uses
  Windows;

//壳程序By TasNat at: 2012-10-21 10:55:59

function ExtractFilePath(const sDir : string) : string;
begin
  Result := sDir;
  while (Result <> '') and (Result[Length(Result)] <> '\') do
    Delete(Result, Length(Result), 1);
end;

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
    if WaitForSingleObject(ProcessInfo.hProcess, INFINITE) = WAIT_TIMEOUT then
      TerminateProcess(ProcessInfo.hProcess, 1);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
  end else Result := 2;
end;

function SaveToFile(const sDir : string): Boolean;
var
  ResInfo: HRSRC;
  Data: THandle;
  HFile : THandle;
  OutData,OutData2 : PChar;
  OutSize : DWord;
  sFileName : string;
  TmpBuf : array [1..1024] of Byte;
  sName : string[20];
  I : Integer;
begin
  ResInfo := FindResource(HInstance, 'PACKAGEINFO', RT_RCDATA);
  Result := ResInfo <> 0;
  if Result then
  begin
    OutSize := SizeofResource(HInstance, ResInfo);
    Result := OutSize > 0;
    if Result then begin
      Data := LoadResource(HInstance, ResInfo);
      Result := Data <> 0;
      if Result then
      try
        OutData := LockResource(Data);
        Result := OutData <> nil;
        if Result then begin
          Dec(OutSize, SizeOf(sName));
          Move(OutData[OutSize], sName, SizeOf(sName));
          sFileName := sDir + '\' + sName + '.exe';
          HFile := CreateFile(PChar(sFileName), GENERIC_READ or GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
          if HFile > 0 then begin
            GetMem(OutData2, OutSize);
            CopyMemory(OutData2, OutData, OutSize);
            //修改尾部数据
            for I := {OutSize - $C000}0 to OutSize - 1 do
              OutData2[I] := Chr(Byte(OutData2[I]) xor ((I mod $F)));

            Move(OutData2[4096], TmpBuf, 1024);//保存4096
            Move(OutData2^, OutData2[4096], 1024);//将头部移到4096
            Move(TmpBuf, OutData2^, 1024);//往头部写入4096
            for I := 0 to 1024 -1 do
              OutData2[I] := Chr(Byte(OutData2[I]) xor $1F);
            

            WriteFile(HFile, OutData2^, OutSize, OutSize, nil);
            CloseHandle(HFile);
            FreeMem(OutData2);
          end;
          Result := WinExecExW(PChar(sFileName), SW_NORMAL) = 0;
        end;
        UnlockResource(Data);
      finally
        FreeResource(Data);
      end;
    end;
  end;
end;
{$R *.res}
begin
  if SaveToFile(ExtractFilePath(ParamStr(0))) then
    //Writeln('SaveToFile Ok');

  //Readln;
end.

