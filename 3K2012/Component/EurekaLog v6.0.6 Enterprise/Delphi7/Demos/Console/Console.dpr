program Console;
{$APPTYPE CONSOLE}
uses
  ExceptionLog,
  SysUtils,
  Windows,
  Classes;

var
  idx: integer;

procedure Error;
var
  A, B: integer;
  C: variant;
  L: TList;
begin
  case idx of
    0:
      begin
        PByte(nil)^ := 0;
      end;
    1:
      begin
        A := 0;
        B := A div A;
        if B = 0 then
          Halt;
      end;
    2:
      begin
        WriteLn (StrToDateTime('99/99/1998'));      
      end;
    3:
      begin
        raise Exception.Create('Custom exception');
      end;
    4:
      begin
        C := 'Hello';
        A := C;
        if A = 0 then
          Halt;
      end;
    5:
      begin
        L := TList.Create;
        try
          if L[0] <> nil then
            Halt;
        finally
          L.Free;
        end;
      end;
  end;
end;

procedure GoToError;
begin
  Error;
end;

procedure RaiseException;
begin
  GoToError;
end;

begin
  WriteLn('----------------------------------------------');
  WriteLn('|  EurekaLog 6.x - Concole Application Demo  |');
  WriteLn('----------------------------------------------');
  WriteLn('|                                            |');
  WriteLn('|  Select the exception to raise:            |');
  WriteLn('|    0)...Access violation                   |');
  WriteLn('|    1)...Division by zero                   |');
  WriteLn('|    2)...String conversion errors           |');
  WriteLn('|    3)...Raise custom exception             |');
  WriteLn('|    4)...Invalid variant type conversion    |');
  WriteLn('|    5)...List index out of bounds           |');
  WriteLn('|                                            |');
  WriteLn('----------------------------------------------');
  WriteLn;
  repeat
    Write('Select the exception number: ');
    ReadLn(idx);
    WriteLn;
    if not ((idx >= 0) and (idx <= 5)) then
      WriteLn('Select the number beetwen 0 and 5.');
  until (idx >= 0) and (idx <= 5);
  RaiseException;
end.

