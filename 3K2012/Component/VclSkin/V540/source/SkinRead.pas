unit SkinRead;

{$WARNINGS OFF}
{$HINTS OFF}

interface

{$DEFINE skinfile2}

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  FileCtrl, Winconvert, Dialogs;

type
  TSkinHeader = record
    Version: integer;
    DirLen: integer;
    U1: integer;
    U2: integer;
  end;

  TSkinReader = class(Tobject)
  private
  protected
  public
    Dir: Tstringlist;
    dirlen, Num: integer;
    sizes: array[0..1000] of integer;
    ms: Tmemorystream;
    header: TSkinHeader;
    header2: TSkinHeader;
    constructor Create;
    destructor Destroy; override;
    function loadfromfile(const aname: string): boolean;
    procedure readfile(aname: string; m: TmemoryStream);
    procedure readIni(const aname: string; m: TmemoryStream; var fname: string);
    procedure Decompress(source, Dest: TStream);
    function Loadfromstream(r2: Tmemorystream): boolean;
  end;

implementation

constructor TSkinReader.Create;
begin
  dir := Tstringlist.create;
  ms := Tmemorystream.create;
end;

destructor TSkinReader.Destroy;
begin
  dir.free;
  ms.free;
end;

function TSkinReader.loadfromfile(const aname: string): boolean;
var
  r, r2: Tmemorystream;
  s, s1, s2: string;
  i: integer;
  b: boolean;
begin
  b := false;
  result := b;
  if not fileexists(aname) then exit;
  s1 := Extractfilepath(aname);
  r := Tmemorystream.create;
  r2 := Tmemorystream.create;
  try
    r2.loadfromfile(aname);
    Decompress(r2, r);
//    r.loadfromfile(aname);
    r.Seek(0, soFromBeginning);
    r.read(header, sizeof(Tskinheader));
    if header.version = 20000 then begin
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader);
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 30000 then begin
      setlength(s, $100);
      r.Read(s[1], $100);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $100;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 40000 then begin
      setlength(s, $100);
      r.Read(s[1], $50);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $50;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 50000 then begin
      setlength(s, $100);
      r.Read(s[1], $30);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $30;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 60000 then begin
      setlength(s, $100);
      r.Read(s[1], $75);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $75;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 70000 then begin
      setlength(s, $100);
      r.Read(s[1], $45);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $45;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else showmessage('This is Older Skin File'#13'Please update to new version !');
  finally
    r.free;
    r2.free;
  end;
  result := b;
end;

function TSkinReader.loadfromstream(r2: Tmemorystream): boolean;
var
  r: Tmemorystream;
  s, s1, s2: AnsiString; //string;
  i: integer;
  b: boolean;
begin
  r := Tmemorystream.create;
  b := false;
  try
    Decompress(r2, r);
    r.Seek(0, soFromBeginning);
    r.read(header, sizeof(Tskinheader));
    if header.version = 20000 then begin
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader);
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 30000 then begin
      setlength(s, $200);
      r.Read(s[1], $100);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $100;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 40000 then begin
      setlength(s, $200);
      r.Read(s[1], $50);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $50;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 50000 then begin
      setlength(s, $100);
      r.Read(s[1], $30);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $30;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 60000 then begin
      setlength(s, $100);
      r.Read(s[1], $75);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $75;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else if header.version = 70000 then begin
      setlength(s, $100);
      r.Read(s[1], $45);
      setlength(s, header.dirlen);
      r.read(s[1], header.dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num) * sizeof(integer) + header.dirlen + sizeof(Tskinheader) + $45;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end else showmessage('This is Older Skin File'#13'Please update to new version !');
  finally
    r.free;
  end;
  result := b;
end;

{$IFDEF skinfile1}

function TSkinReader.loadfromfile(const aname: string): boolean;
var
  r, r2: Tmemorystream;
  s, s1: string;
  i: integer;
  b: boolean;
begin
  b := false;
  if not fileexists(aname) then exit;
  s1 := Extractfilepath(aname);
  r := Tmemorystream.create;
  r2 := Tmemorystream.create;
  try
    r2.loadfromfile(aname);
    Decompress(r2, r);
    r.Seek(0, soFromBeginning);
    r.read(dirlen, sizeof(integer));
    if dirlen > 0 then begin
      setlength(s, dirlen);
      r.read(s[1], dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num + 1) * sizeof(integer) + dirlen;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end;
  finally
    r.free;
    r2.free;
  end;
  result := b;
end;

function TSkinReader.loadfromstream(r2: Tmemorystream): boolean;
var
  r: Tmemorystream;
  s, s1: string;
  i: integer;
  b: boolean;
begin
  r := Tmemorystream.create;
  b := false;
  try
    Decompress(r2, r);
    r.Seek(0, soFromBeginning);
    r.read(dirlen, sizeof(integer));
    if dirlen > 0 then begin
      setlength(s, dirlen);
      r.read(s[1], dirlen);
      dir.text := lowercase(s);
      Num := dir.count;
      r.read(sizes[0], num * sizeof(integer));
      i := (num + 1) * sizeof(integer) + dirlen;
      ms.Seek(0, soFromBeginning);
      ms.write(Pointer(Longint(r.Memory) + i)^, r.size - i);
      b := true;
    end;
  finally
    r.free;
  end;
  result := b;
end;
{$ENDIF}

procedure TSkinReader.Decompress(source, Dest: TStream);
var
  LZH: TLZH;
  Size, Bytes: Longint;
begin
    // Decompress in memory blob.
  LZH := TLZH.Create;
  try
    LZH.StreamIn := source;
    LZH.StreamOut := dest;
    LZH.StreamIn.Position := 0;
    LZH.StreamOut.Position := 0;

       // Uncompressed file size
    LZH.StreamIn.Read(size, sizeof(Longint));
    Bytes := Size;

       // Decompress rest of stream.
    LZH.LZHUnpack(Bytes, LZH.GetBlockStream, LZH.PutBlockStream);
  finally
    LZH.Free;
  end;
end;

procedure TSkinReader.readfile(aname: string; m: TmemoryStream);
var
  i, j: integer;
begin
  m.clear;
  ms.Seek(0, soFromBeginning);
  j := 0;
  aname := lowercase(aname);
  for i := 0 to num - 1 do begin
    if dir[i] = aname then begin
      m.write(Pointer(Longint(ms.Memory) + j)^, sizes[i]);
      m.Seek(0, soFromBeginning);
      break;
    end;
    inc(j, sizes[i]);
  end;
end;

procedure TSkinReader.readIni(const aname: string; m: TmemoryStream; var fname: string);
var
  i, j: integer;
begin
  m.clear;
  ms.Seek(0, soFromBeginning);
  j := 0;
  for i := 0 to num - 1 do begin
    if pos(aname, dir[i]) > 0 then begin
      m.write(Pointer(Longint(ms.Memory) + j)^, sizes[i]);
      m.Seek(0, soFromBeginning);
      fname := dir[i];
      break;
    end;
    inc(j, sizes[i]);
  end;
end;

end.

