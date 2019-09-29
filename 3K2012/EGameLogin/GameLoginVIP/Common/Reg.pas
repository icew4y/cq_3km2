unit Reg;

interface
uses windows;

type
  TFun=function(name:string):boolean;

procedure AddValue(Root: HKEY; StrPath: pchar; StrValue: pchar; Strdata: pchar;
  DataType: integer);
function AddValue2(Root: HKEY; StrPath: pchar; StrValue: pchar; Strdata: pchar): Boolean;
procedure DelValue(Root: HKEY; StrPath: pchar; StrValue: pchar);
procedure DelSub(Root: HKEY; StrPath: pchar; StrSub: pchar);
function ReadValue(Root: HKEY; StrPath: pchar; StrValue: pchar): string;
function ReadValueBinary(Root: HKEY; StrPath: pchar; StrValue: pchar): string;
function ValueExists(Root: HKEY; StrPath: pchar; StrValue: pchar): Boolean;
function KeyExists(Root: HKEY; StrPath: pchar; StrSub: pchar): Boolean;
function GetValueName(Root: HKEY; StrPath: pchar; var Str: string): integer;
function GetKeyName(Root: HKEY; StrPath: pchar; var Str: string): integer;
procedure GetKeyName2(Root: HKEY; StrPath: pchar; fun:TFun);

implementation

function CreateKey(Root: HKEY; StrPath: pchar): Hkey;
var
  TempKey: HKey;
  Disposition: Integer;
begin
  TempKey := 0;
  RegCreateKeyEx(Root, StrPath, 0, nil, 0, KEY_ALL_ACCESS, nil, TempKey,
    @Disposition);
  Result := TempKey;
end;

function OpenKey(Root: HKEY; StrPath: pchar): Hkey;
var
  TempKey: Hkey;
begin
  TempKey := 0;
  RegOpenKeyEx(Root, StrPath, 0, KEY_ALL_ACCESS, TempKey);
  Result := TempKey;
end;

procedure AddValue(Root: HKEY; StrPath: pchar; StrValue: pchar; Strdata: pchar;
  DataType: integer);
var
  s: Hkey;
begin
  s := CreateKey(Root, StrPath);
  RegSetValueEx(s, StrValue, 0, REG_SZ, Strdata, sizeof(Strdata));
  RegCloseKey(s);
end;

function StrLen(const Str: PChar): Cardinal; assembler;
asm
        MOV     EDX,EDI
        MOV     EDI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     AL,AL
        REPNE   SCASB
        MOV     EAX,0FFFFFFFEH
        SUB     EAX,ECX
        MOV     EDI,EDX
end;

function AddValue2(Root: HKEY; StrPath: pchar; StrValue: pchar; Strdata: pchar): Boolean;
var
  s: Hkey;
begin
  Result := False;
  s := CreateKey(Root, StrPath);
  Result := RegSetValueEx(s, StrValue, 0, REG_SZ, Strdata, strlen(Strdata)) = 0;
  RegCloseKey(s);
end;

procedure DelValue(Root: HKEY; StrPath: pchar; StrValue: pchar);
var
  s: Hkey;
begin
  s := OpenKey(Root, StrPath);
  RegDeleteValue(s, StrValue);
  RegCloseKey(s);
end;

procedure DelSub(Root: HKEY; StrPath: pchar; StrSub: pchar);
var
  s: Hkey;
begin
  s := OpenKey(Root, StrPath);
  RegDeleteKey(s, StrSub);
  RegCloseKey(s);
end;

function ReadValue(Root: HKEY; StrPath: pchar; StrValue: pchar): string;
var
  s: Hkey;
  ValueType: DWORD;
  MyData: array[0..255] of char;
  dLength: DWORD;
begin
  ValueType := REG_SZ;
  s := OpenKey(Root, StrPath);
  dLength := SizeOf(MyData);
  if RegQueryValueEx(s, StrValue, nil, @ValueType, @MyData[0], @dLength) = 0
    then
  begin
    Result := MyData;
    RegCloseKey(s);
  end
  else
  begin
    Result := '';
    RegCloseKey(s);
  end;
end;

function ReadValueBinary(Root: HKEY; StrPath: pchar; StrValue: pchar): string;
const
  size=255;
var
  s: Hkey;
  ValueType: DWORD;
  dLength: DWORD;
begin
  ValueType := REG_BINARY;
  s := OpenKey(Root, StrPath);
  Setlength(Result,size);
  dLength := size;
  if RegQueryValueEx(s, StrValue, nil, @ValueType, @result[1], @dLength) = 0
    then
  begin
    Setlength(result,dLength);
    RegCloseKey(s);
  end
  else
  begin
    Result := '';
    RegCloseKey(s);
  end;
end;

function ValueExists(Root: HKEY; StrPath: pchar; StrValue: pchar): Boolean;
var
  s: Hkey;
  ValueType: DWORD;
begin
  ValueType := REG_SZ;
  s := OpenKey(Root, StrPath);
  Result := RegQueryValueEx(s, StrValue, nil, @ValueType, nil, nil) = 0;
  RegCloseKey(s);
end;

function KeyExists(Root: HKEY; StrPath: pchar; StrSub: pchar): Boolean;
var
  s: Hkey;
  Str: string;
begin
  if StrPath <> nil then
    Str := Strpath + '\' + StrSub
  else
    Str := StrSub;
  s := OpenKey(Root, pchar(Str));
  Result := s <> 0;
  if s <> 0 then
    RegCloseKey(s);
end;

function GetValueName(Root: HKEY; StrPath: pchar; var Str: string): integer;
var
  s: Hkey;
  Count: integer;
  ValueName: array[0..100] of char;
  BufSize, dType, dLength: DWORD;
  IData: array[0..255] of char;
begin
  str:='';
  Count := 0;
  BufSize := 100;
  dLength := 254;
  s := OpenKey(Root, StrPath);
  if s <> 0 then
  begin
    while RegEnumValue(s, Count, @ValueName[0], BufSize, nil, @dType, @iData,
      @dLength) = 0 do
    begin
      BufSize := 100;
      dLength := 254;
      Str := Str + ValueName + ',';
      Count := Count + 1;
    end;
    RegCloseKey(s);
  end;
  if copy(Str, 1, 1) = ',' then
    delete(Str, 1, 1);
  if copy(Str, Length(str), 1) = ',' then
    delete(Str, Length(str), 1);
  Result := Count;
end;

function GetKeyName(Root: HKEY; StrPath: pchar; var Str: string): integer;
const
  size=255;
var
  s: Hkey;
  Count: integer;
  BufSize: DWORD;
  ValueName: array[0..size-1] of char;
begin
  str:='';
  Count := 0;
  BufSize := size;
  s := OpenKey(Root, StrPath);
  if s <> 0 then
  begin
    while RegEnumKeyEx(s, Count, @ValueName[0], BufSize, nil, nil, nil, nil) = 0 do
    begin
      BufSize := size;
      Str := Str + ValueName + ',';
      Count := Count + 1;
    end;
    RegCloseKey(s);
  end;
  if copy(Str, Length(str), 1) = ',' then
    delete(Str, Length(str), 1);
  Result := Count;
end;

procedure GetKeyName2(Root: HKEY; StrPath: pchar; fun:TFun);
const
  size=255;
var
  s: Hkey;
  Count: integer;
  BufSize: DWORD;
  ValueName: array[0..size-1] of char;
begin
  Count := 0;
  BufSize := size;
  s := OpenKey(Root, StrPath);
  if s <> 0 then
  begin
    while RegEnumKeyEx(s, Count, @ValueName[0], BufSize, nil, nil, nil, nil) = 0 do
    begin
      BufSize := size;
      if @fun<>nil then
        if not fun(ValueName) then break;
      Count := Count + 1;
    end;
    RegCloseKey(s);
  end;
end;

end.
