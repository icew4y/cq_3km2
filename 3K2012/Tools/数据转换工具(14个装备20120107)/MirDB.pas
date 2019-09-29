unit MirDB;
///对记录类文件流的操作
interface
uses Classes, sysutils;

type

  TMirRecord = class(TFileStream)
  private
    FRecSize: Int64;
    FileHeaderSize: Integer;
    function GetNumRecs: Longint;
    function GetCurRec: Longint;
    procedure SetCurRec(RecNo: Longint);
    procedure SetRecSize(Size: Int64);
    function GetRecSize: Int64;
    procedure SetHeaderSize(Size: Integer);
    function GetHeaderSize: Integer;
  protected
  public
    function SeekRec(RecNo: Longint; Origin: Word): Longint;
    function WriteRec(const Rec): Longint;
    function AppendRec(const Rec): Longint;
    function ReadRec(var Rec): Longint;
    function GetIndexOf(var Rec; RecNo: Longint): Longint;
    function SetIndexof(const Rec; RecNo: Longint): Longint;
    procedure First;
    procedure Last;
    procedure NextRec;
    procedure PreviousRec;
    property NumRecs: Longint read GetNumRecs;
    property CurRec: Longint read GetCurRec write SetCurRec;
    property RecSize: Int64 read GetRecSize write SetRecSize;
    property HeaderSize:Integer read GetHeaderSize write SetHeaderSize;
  end;

implementation

{ TMirRecord }

function TMirRecord.GetCurRec: Longint;
begin
  Result := ((Position - FileHeaderSize) div FRecSize) + 1;
end;

function TMirRecord.GetRecSize: Int64;
begin
  Result := FRecSize;
end;

function TMirRecord.GetHeaderSize: Integer;
begin
  Result := FileHeaderSize;
end;

procedure TMirRecord.SetRecSize(Size: Int64);
begin
  FRecSize := Size;
end;

procedure TMirRecord.SetHeaderSize(Size: Integer);
begin
  FileHeaderSize := Size;
end;

function TMirRecord.GetIndexOf(var Rec; RecNo: integer): Longint;
begin
  Result := -1;
  if RecNo > 0 then begin
    Position := (RecNo - 1) * FRecSize + FileHeaderSize;
    Result := Read(Rec, FRecSize);
    Seek(-GetRecSize, 1);
  end;
end;

function TMirRecord.GetNumRecs: Longint;
begin
  Result := (Size - FileHeaderSize) div FRecSize;
end;

function TMirRecord.SeekRec(RecNo: Integer; Origin: Word): Longint;
begin
  Result := Seek(RecNo * FRecSize - FRecSize, Origin);
  //对指针在文件头里的处理在ReadRec处理了
end;

procedure TMirRecord.SetCurRec(RecNo: Integer);
begin
  if RecNo > 0 then Position := (RecNo - 1) * FRecSize + FileHeaderSize
  else raise Exception.Create('不能超越文件的开头。');
end;

function TMirRecord.SetIndexof(const Rec; RecNo: Integer): Longint;
begin
  Result := -1;
  if RecNo > 0 then begin
    Position := (RecNo - 1) * FRecSize + FileHeaderSize;
    Result := Write(Rec, FRecSize);
  end;
end;

function TMirRecord.AppendRec(const Rec): Longint;
begin
  Seek(0, 2);
  Result := Write(Rec, FRecSize);
end;

procedure TMirRecord.First;
begin
  Seek(0, 0);
  seek(FileHeaderSize, 1);
end;

procedure TMirRecord.Last;
begin
  Seek(0, 2);
  Seek(-GetRecSize, 1);
end;

procedure TMirRecord.NextRec;
begin
  if ((Position - FileHeaderSize + FRecSize) div FRecSize) = GetNumRecs then exit
  else Seek(GetRecSize, 1);
end;

procedure TMirRecord.PreviousRec;
begin
  if (Position - FRecSize >= FileHeaderSize) then Seek(-GetRecSize, 1);
end;

function TMirRecord.ReadRec(var Rec): Longint;
begin
  if Position < FileHeaderSize then Seek(FileHeaderSize, 1);
  Result := Read(Rec, FRecSize);
  Seek(-GetRecSize, 1);
end;

function TMirRecord.WriteRec(const Rec): Longint;
begin
  Result := Write(Rec, FRecSize);
end;

end.

