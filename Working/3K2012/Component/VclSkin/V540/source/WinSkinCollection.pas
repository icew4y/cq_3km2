{
Provided by Malcolm Smith, MJ Freelancing as an enhancement to VCLSkin
Web:   http://www.mjfreelancing.com
Date:  11th May 2003
}

unit WinSkinCollection;

{$WARNINGS OFF}
{$HINTS OFF}

interface

uses Classes, SysUtils, Dialogs;

type

  TSkinCollectionItem = class(TCollectionItem)
  private
    FName: string;

    procedure SetName(AName: string);
    function GetDataSize: integer;
    function GetData: string;
    procedure SetData(const Value: string);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);

  protected
    function GetDisplayName: string; reintroduce; override;
    procedure DefineProperties(Filer: TFiler); reintroduce; override;

  public
    FData: TMemoryStream;
    constructor Create(ACollection: TCollection); override;
    destructor Destroy; reintroduce; override;
    procedure Assign(ASource: TPersistent); reintroduce; override;

    procedure LoadFromFile(value: string);
    procedure CopyData(AStream: TMemoryStream);
  published
    property Name: string read FName write SetName;
    property SkinData: string read GetData write Setdata stored false;
    property DataSize: integer read GetDataSize;
  end;

  TSkinCollection = class(TOwnedCollection)
  private
  public
    constructor Create(AOwner: TPersistent);
    function Add: TSkinCollectionItem; overload;
    procedure Assign(ASource: TPersistent); reintroduce; override;
  end;

implementation

{ TSkinCollectionItem }

procedure TSkinCollectionItem.Assign(ASource: TPersistent);
var
  AItem: TSkinCollectionItem;
begin
  AItem := ASource as TSkinCollectionItem;
  if AItem <> nil then
  begin
    FName := AItem.Name;
    FData.Clear;
    AItem.CopyData(FData);
  end
  else
    inherited;
end;

procedure TSkinCollectionItem.CopyData(AStream: TMemoryStream);
var
  Pos: integer;
begin
  Pos := FData.Position;
  try
    FData.Position := 0;
    AStream.CopyFrom(FData, FData.Size);
  finally
    FData.Position := Pos;
  end;
end;

constructor TSkinCollectionItem.Create(ACollection: TCollection);
begin
  inherited;
  FData := TMemoryStream.Create;
  FName := 'SkinItem' + IntToStr(ID);
end;

procedure TSkinCollectionItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('DataStream', ReadData, WriteData, True);
end;

procedure TSkinCollectionItem.ReadData(Stream: TStream);
begin
  FData.Clear;
  FData.CopyFrom(Stream, Stream.Size);
end;

procedure TSkinCollectionItem.WriteData(Stream: TStream);
begin
  FData.Position := 0;
  Stream.CopyFrom(FData, FData.Size);
end;

destructor TSkinCollectionItem.Destroy;
begin
  FData.Free;
  inherited;
end;

function TSkinCollectionItem.GetData: string;
begin
  Result := 'Load Skin';
end;

function TSkinCollectionItem.GetDataSize: integer;
begin
  Result := FData.Size;
end;

function TSkinCollectionItem.GetDisplayName: string;
begin
  Result := FName;
end;

procedure TSkinCollectionItem.LoadFromFile(value: string);
begin
  FData.Clear;
  FData.LoadFromFile(value);
  if (FName = (string('SkinItem') + IntToStr(ID))) then
    FName := ExtractFileName(value);
  ShowMessage('File is ' + IntToStr(FData.Size) + ' bytes');
end;

procedure TSkinCollectionItem.SetData(const Value: string);
begin
end;

procedure TSkinCollectionItem.SetName(AName: string);
var
  ACollection: TOwnedCollection;
  i: integer;
begin
  // need to make sure the name does not
  // already exist in the collection
  if FName <> AName then
  begin
    ACollection := GetOwner as TOwnedCollection;

    for i := 0 to ACollection.Count - 1 do
      if ACollection.Items[i] <> Self then
        if (ACollection.Items[i] as TSkinCollectionItem).Name = AName then
          raise Exception.Create('The name ' + AName + ' is already used.');

    FName := AName;

  end;
end;

{ TSkinCollection }

function TSkinCollection.Add: TSkinCollectionItem;
begin
  Result := inherited Add as TSkinCollectionItem;
end;

procedure TSkinCollection.Assign(ASource: TPersistent);
{
var
  ACollection: TSkinCollection;
}
begin
  {
  ACollection := ASource as TSkinCollection;
  if ACollection <> nil then
  begin
    // assign properties
  end
  else
  }
  inherited;
end;

constructor TSkinCollection.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TSkinCollectionItem);
end;

end.

