unit Hashtable;

interface



type
      { THashTable }

  PPHashItem = ^PHashItem;
  PHashItem = ^THashItem;
  THashItem = record
    Next: PHashItem;
    Key: string;
    Value: string;
    Data: Pointer;
  end;

  THashTable = class
  private
    Buckets: array of PHashItem;
    function GetCount: Integer;
    function GetValue(const Name: string): string;
    procedure SetValue(const Name: string; Value: string);

    function GetData(const Name: string): Pointer;
    procedure SetData(const Name: string; Value: Pointer);

    function Get(Index: Integer): Pointer;
    procedure Put(Index: Integer; Value: Pointer);
  protected
    function Find(const Name: string): PPHashItem;

  public
    constructor Create(Size: Integer = 256);
    destructor Destroy; override;
    function HashOf(const Name: string): Cardinal; virtual;
    procedure Clear;
    procedure Remove(const Name: string);
    function Modify(const Name: string; Value: string): Boolean;
    function Add(const Name: string; const Value: string; P: Pointer): Boolean;
    property Values[const Name: string]: string read GetValue write SetValue;
    property Datas[const Name: string]: Pointer read GetData write SetData;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: Pointer read Get write Put;
  end;

implementation

    { THashTable }

function THashTable.GetCount: Integer;
begin
  Result := Length(Buckets);
end;

function THashTable.Get(Index: Integer): Pointer;
begin
  if Buckets[Index] <> nil then
    Result := Buckets[Index].Data
  else
    Result := nil;
end;

procedure THashTable.Put(Index: Integer; Value: Pointer);
begin
  if Buckets[Index] <> nil then
    Buckets[Index].Data := Value;
end;

function THashTable.GetValue(const Name: string): string;
var
  P: PHashItem;
begin
  P := Find(Name)^;
  if P <> nil then
    Result := P^.Value
  else
    Result := '';
end;

procedure THashTable.SetValue(const Name: string; Value: string);
var
  Hash: Integer;
  Bucket: PHashItem;
begin
  Hash := HashOf(Name) mod Cardinal(Length(Buckets));
  New(Bucket);
  Bucket^.Key := Name;
  Bucket^.Value := Value;
  Bucket^.Next := Buckets[Hash];
  Bucket^.Data := nil;
  Buckets[Hash] := Bucket;
end;

function THashTable.GetData(const Name: string): Pointer;
var
  P: PHashItem;
begin
  P := Find(Name)^;
  if P <> nil then
    Result := P^.Data
  else
    Result := nil;
end;

procedure THashTable.SetData(const Name: string; Value: Pointer);
var
  Hash: Integer;
  Bucket: PHashItem;
begin
  Hash := HashOf(Name) mod Cardinal(Length(Buckets));
  New(Bucket);
  Bucket^.Key := Name;
  Bucket^.Value := '';
  Bucket^.Next := Buckets[Hash];
  Bucket^.Data := Value;
  Buckets[Hash] := Bucket;
end;

procedure THashTable.Clear;
var
  I: Integer;
  P, N: PHashItem;
begin
  for I := 0 to Length(Buckets) - 1 do
  begin
    P := Buckets[I];
    while P <> nil do
    begin
      N := P^.Next;
      Dispose(P);
      P := N;
    end;
    Buckets[I] := nil;
  end;
end;

constructor THashTable.Create(Size: Integer);
begin
  inherited Create;
  SetLength(Buckets, Size);
end;

destructor THashTable.Destroy;
begin
  Clear;
  inherited;
end;

function THashTable.Find(const Name: string): PPHashItem;
var
  Hash: Integer;
begin
  Hash := HashOf(Name) mod Cardinal(Length(Buckets));
  Result := @Buckets[Hash];
  while Result^ <> nil do
  begin
    if Result^.Key = Name then
      Exit
    else
      Result := @Result^.Next;
  end;
end;

function THashTable.HashOf(const Name: string): Cardinal;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(Name) do
    Result := ((Result shl 2) or (Result shr (SizeOf(Result) * 8 - 2))) xor
      Ord(Name[I]);
end;

function THashTable.Add(const Name: string; const Value: string; P: Pointer): Boolean;
var
  Hash: Integer;
  Bucket: PHashItem;
begin

  Hash := HashOf(Name) mod Cardinal(Length(Buckets));
  New(Bucket);
  Bucket^.Key := Name;
  Bucket^.Value := Value;
  Bucket^.Next := Buckets[Hash];
  Bucket^.Data := P;
  Buckets[Hash] := Bucket;
end;

function THashTable.Modify(const Name: string; Value: string): Boolean;
var
  P: PHashItem;
begin
  P := Find(Name)^;
  if P <> nil then
  begin
    Result := True;
    P^.Value := Value;
  end
  else
    Result := False;
end;

procedure THashTable.Remove(const Name: string);
var
  P: PHashItem;
  Prev: PPHashItem;
begin
  Prev := Find(Name);
  P := Prev^;
  if P <> nil then
  begin
    Prev^ := P^.Next;
    Dispose(P);
  end;
end;

end.

