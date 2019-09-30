unit AspMapFiles;

interface
uses Windows, Classes;
type
  TMapStream = class
  private
    FFileName: string; // WIL 文件名
    FFileHandle: THandle; // 文件句柄
    FFileMapping: THandle; // 文件映射句柄
    FMemory: Pointer; // 文件内容指针(使用文件映射)
    FSize: Int64;
    FPosition: Int64;
    FInitialized:Boolean;
    procedure SetPosition(Pos: Int64);
    procedure SetSize(NewSize: Int64);
  public
    constructor Create();
    destructor Destroy; override;
    function LoadFromFile(const FileName: string): Boolean;
    function Read(var Buffer; Count: Longint): Longint;
    function Seek(Offset: Longint; Origin: Word): Longint;
    function Write(const Buffer; Count: Longint): Longint;

    property Position: Int64 read FPosition write SetPosition;
    property Size: Int64 read FSize write SetSize;
    property Memory: Pointer read FMemory;
  end;
implementation

constructor TMapStream.Create();
begin
  FFileName := ''; // WIL 文件名
  FFileHandle := 0; // 文件句柄
  FFileMapping := 0; // 文件映射句柄
  FMemory := nil; // 文件内容指针(使用文件映射)
  FSize := 0;
  FPosition := 0;
  FInitialized:=False;
end;

destructor TMapStream.Destroy;
begin
  if FMemory <> nil then UnmapViewOfFile(FMemory);
  if FFileMapping <> 0 then CloseHandle(FFileMapping);
  if FFileHandle <> INVALID_HANDLE_VALUE then CloseHandle(FFileHandle);
  inherited;
end;

function TMapStream.LoadFromFile(const FileName: string): Boolean;
var
  H, L: DWord;
begin
  Result := False;
  if FMemory <> nil then UnmapViewOfFile(FMemory);
  if FFileMapping <> 0 then CloseHandle(FFileMapping);
  if FFileHandle <> INVALID_HANDLE_VALUE then CloseHandle(FFileHandle);

  FFileName := ''; // WIL 文件名
  FFileHandle := 0; // 文件句柄
  FFileMapping := 0; // 文件映射句柄
  FMemory := nil; // 文件内容指针(使用文件映射)
  FSize := 0;
  FPosition := 0;
  FInitialized:=False;
  FFileName := FileName;
  FFileHandle := CreateFile(PChar(FFileName), GENERIC_READ,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_RANDOM_ACCESS, 0);
  if (FFileHandle = INVALID_HANDLE_VALUE) then Exit;

  FFileMapping := CreateFileMapping(FFileHandle, nil, PAGE_READONLY, 0, 0, nil);

  if FFileMapping = 0 then begin
    CloseHandle(FFileHandle);
    Exit;
  end;

  // 映射文件至内存
  FMemory := MapViewOfFile(FFileMapping, FILE_MAP_READ, 0, 0, 0);
  if FMemory = nil then begin
    CloseHandle(FFileMapping);
    CloseHandle(FFileHandle);
    Exit;
  end;

  L := GetFileSize(FFileHandle, @H);
  FSize := H;
  FSize := (FSize shl 32) or L;
  FInitialized:=True;
  Result := True;
end;

function TMapStream.Read(var Buffer; Count: Longint): Longint;
begin
  if (Count > 0) and FInitialized then begin
    Result := Size - Position;
    if (Result >= Count) then begin
      Result := Count;
      System.Move(Pointer(Integer(Memory) + Position)^, Buffer, Count);
      FPosition := Position + Count;
    end;
    //else raise EMMEndOfFile.Create(SEOFError);
  end
  else Result := 0;
end;

function TMapStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning: Position := Offset;
    soFromCurrent: Position := Position + Offset;
    soFromEnd: Position := Size + Offset;
  end;
  Result := Position;
end;

function TMapStream.Write(const Buffer; Count: Longint): Longint;
begin

end;

procedure TMapStream.SetPosition(Pos: Int64);
begin
  if (Pos <= Size) then
    FPosition := Pos;
  //else raise EMMEndOfFile.Create(SEOFError);
end;

procedure TMapStream.SetSize(NewSize: Int64);
begin

end;

end.

