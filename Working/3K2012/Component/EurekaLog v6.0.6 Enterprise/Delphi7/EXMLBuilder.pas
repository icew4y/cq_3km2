{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{       XML Builder Unit - EXMLBuilder           }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EXMLBuilder;

{$I Exceptions.inc}

interface

uses
  Windows, SysUtils, Classes;

type
  TXMLItem = class;

  TXMLItems = class(TList)
  private
    function GetItem(Index: Integer): TXMLItem;
  protected
  public
    destructor Destroy; override;
    function AddItem(const ItemName: string): TXMLItem;
    property Items[Index: Integer]: TXMLItem read GetItem; default;
  end;

  TXMLItem = class
  private
    FName, FValue, FEncodedValue: string;
    FFields, FSpaces: String;
    FItems: TXMLItems;
    FParent: TXMLItem;
    function GetXMLText: string;
    procedure SetValue(const Value: string);
  protected
    function EncodedString(const Value: string): string;
    procedure AppendXMLText(var Text: string);
  public
    constructor Create(AName: string);
    destructor Destroy; override;
    procedure SaveXMLToFile(const FileName: string);
    procedure AddField(const FieldName, FieldValue: string);
    function AddItem(const ItemName: string): TXMLItem;
    property Name: string read FName write FName;
    property Value: string read FValue write SetValue;
    property Parent: TXMLItem read FParent write FParent;
    property XMLText: string read GetXMLText;
  end;

implementation

{ TXMLItems }

function TXMLItems.AddItem(const ItemName: string): TXMLItem;
begin
  Result := Items[TList(Self).Add(TXMLItem.Create(ItemName))];
end;

destructor TXMLItems.Destroy;
var
  n: Integer;
begin
  for n := (Count - 1) downto 0 do
  begin
    Items[n].Free;
    Delete(n);
  end;
  inherited;
end;

function TXMLItems.GetItem(Index: Integer): TXMLItem;
begin
  Result := TXMLItem(TList(Self).Items[Index]);
end;

{ TXMLItem }

procedure TXMLItem.AddField(const FieldName, FieldValue: string);
begin
  FFields := (FFields + ' ' + FieldName + '="' + EncodedString(FieldValue) + '"');
end;

function TXMLItem.AddItem(const ItemName: string): TXMLItem;
begin
  Result := FItems.AddItem(ItemName);
  Result.Parent := Self;
end;

constructor TXMLItem.Create(AName: string);
begin
  FName := AName;
  FValue := '';
  FFields := '';
  FEncodedValue := '';
  FSpaces := '';
  FParent := nil;
  FItems := TXMLItems.Create;
end;

destructor TXMLItem.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TXMLItem.EncodedString(const Value: string): string;
const
  EncodedChars: set of char = [#0..#31, '&', '"', '''', '<', '>', #127..#255];
var
  n, Idx: Integer;
  c: Char;
  b: Byte;
begin
  SetLength(Result, Length(Value) * 6);
  Idx := 1;
  for n := 1 to Length(Value) do
  begin
    c := Value[n];
    if not (c in EncodedChars) then
    begin
      Result[Idx] := c;
      Inc(Idx);
    end
    else
    begin
      b := Ord(c);
      Result[Idx] := '&';
      Result[Idx + 1] := '#';
      Result[Idx + 2] := Chr((b div 100) + 48);
      Result[Idx + 3] := Chr(((b mod 100) div 10) + 48);
      Result[Idx + 4] := Chr(((b mod 100) mod 10) + 48);
      Result[Idx + 5] := ';';
      Inc(Idx, 6);
    end;
  end;
  SetLength(Result, (Idx - 1));
end;

procedure TXMLItem.AppendXMLText(var Text: string);
var
  n: Integer;
begin
  Text := (Text + FSpaces + '<' + FName + FFields);
  if (FEncodedValue = '') and (FItems.Count = 0) then Text := (Text + '/>'#13#10)
  else
  begin
    Text := (Text + '>');
    if (FEncodedValue <> '') then Text := (Text + FEncodedValue);
    if (FItems.Count > 0) then
    begin
      Text := (Text + #13#10);
      for n := 0 to (FItems.Count - 1) do
      begin
        FItems[n].FSpaces := (FSpaces + '  ');
        FItems[n].AppendXMLText(Text);
      end;
      Text := (Text + FSpaces);
    end;
    Text := (Text + '</' + FName + '>'#13#10);
  end;
end;

function TXMLItem.GetXMLText: string;
begin
  Result := '';
  AppendXMLText(Result);
end;

procedure TXMLItem.SetValue(const Value: string);
begin
  if (Value = FValue) then Exit;

  FValue := Value;
  FEncodedValue := EncodedString(FValue)
end;

procedure TXMLItem.SaveXMLToFile(const FileName: string);
var
  Data: TStrings;
begin
  Data := TStringList.Create;
  try
    Data.Text := XMLText;
    Data.SaveToFile(FileName);
  finally
    Data.Free;
  end;
end;

//------------------------------------------------------------------------------

end.
