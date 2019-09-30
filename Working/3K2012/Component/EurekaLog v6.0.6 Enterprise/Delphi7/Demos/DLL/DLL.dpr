library DLL;

uses
  ExceptionLog,
  SysUtils,
  Classes;

type
  PByte = ^Byte;

procedure Error2;
begin
  PByte(nil)^ := 0;
end;

procedure Error1;
begin
  Error2;
end;

procedure Error0;
begin
  Error1;
end;

procedure DLL_Error;
begin
  Error0;
end;

exports
  DLL_Error;

end.

