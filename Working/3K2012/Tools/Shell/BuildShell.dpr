program BuildShell;
uses
  Windows, SysUtils, Classes, Dialogs;
//生成程序 By TasNat at: 2012-10-21 10:34:33

function SaveRes(sFileName : string; const sOutFile : string; Buf : PChar; BufSize : DWord): Boolean;
var
  Handle : THandle;
  sInFile : string;
  TmpBuf : array [1..1024] of Byte;
begin
  sInFile := sOutFile;
  Result := CopyFile(PChar(sFileName), PChar(sInFile), False);
  if Result then begin
    Handle := BeginUpdateResource(PChar(sInFile), False);
    Result := Handle > 0;
    if Result then begin
      Move(Buf[4096], TmpBuf, 1024);//保存4096
      Move(Buf^, Buf[4096], 1024);//将头部移到4096
      Move(TmpBuf, Buf^, 1024);//往头部写入4096
      Result := UpdateResource(Handle, RT_RCDATA, 'PACKAGEINFO', 0, Buf, BufSize);
      EndUpdateResource(Handle, False);
    end;
  end;
end;

var
  Dlg : TOpenDialog;
  M : TMemoryStream;
  sName : string[20] = '测试登陆器';
begin
  Dlg := TOpenDialog.Create(nil);
  Dlg.Filter := '登陆器文件|*.exe';
  if Dlg.Execute(0) then begin
    M := TMemoryStream.Create;
    M.LoadFromFile(Dlg.FileName);
    M.Position := M.Size;
    M.Write(sName, SizeOf(sName));//加登陆器名字
    SaveRes(ExtractFilePath(ParamStr(0)) + '\Shell.exe', ExtractFilePath(ParamStr(0)) + '\Out.exe', M.Memory, M.Size);
    M.Free;
  end;
  Dlg.Free;
end.

