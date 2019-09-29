unit CommFunc;

interface

uses Windows, Classes, SysUtils, StrUtils;

function GetArray(StrText: string; var Str: array of string; SepText: string): Integer; // add by liuzhigang 字符串解析成 数组
procedure ClearList(var AList: TList; bFreeList {,bIsObj}: Boolean);
                                                //SB liuzhigang Record 不能这样 Dispos By TasNat at: 2012-03-27 12:28:33
implementation


function GetArray(StrText: string; var Str: array of string; SepText: string): Integer;
var iPos, StartPos, Len: Integer;
begin
  Result := 0;
  if StrText = '' then Exit;
  Len := Length(SepText);

  StartPos := 1;
  iPos := Pos(SepText, StrText);
  while iPos > 0 do
  begin
    Str[Result] := Copy(StrText, StartPos, iPos - StartPos);
    StartPos := iPos + Len;
    iPos := PosEx(SepText, StrText, StartPos);
    Result := Result + 1;
  end;
  Str[Result] := Copy(StrText, StartPos, Length(StrText) - StartPos + 1);
  if Str[Result] <> '' then
    Result := Result + 1;
end;

procedure ClearList(var AList: TList; bFreeList {,bIsObj}: Boolean);
var I: Integer;
begin
  for I := 0 to AList.Count - 1 do
  begin
    {if bIsObj then }TObject(AList[I]).Free // else Dispose(AList[I]);
  end;
  if bFreeList then FreeAndNil(AList) else AList.Clear;
end;


end.

