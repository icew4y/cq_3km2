unit PackedNums;
//---------------------------------------------------------------------------
// PackedNums.pas                                      Modified: 27-Jan-2005
// Packed Number Lists                                            Version 1.0
//---------------------------------------------------------------------------
// Purpose:
//  An implementation of integer packed lists used to store a list of
//  integer numbers in a packed format:
//   [1], [2 - 8], [11], [23 - 100]
//
//  This is useful when storing sequential IDs or similar information where
//  the difference of elements is 1 (e.g. 1,2,3,..,10) and can be stored in
//  a packed form (e.g. [1 - 10]) to reduce the occupying memory.
//---------------------------------------------------------------------------
// Important Notice:
//
// If you modify/use this code or one of its parts either in original or
// modified form, you must comply with Mozilla Public License v1.1,
// specifically section 3, "Distribution Obligations". Failure to do so will
// result in the license breach, which will be resolved in the court.
// Remember that violating author's rights is considered a serious crime in
// many countries. Thank you!
//
// !! Please *read* Mozilla Public License 1.1 document located at:
//  http://www.mozilla.org/MPL/
//---------------------------------------------------------------------------
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//
// The Original Code is PackedNums.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2005 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 SysUtils, Math;

//---------------------------------------------------------------------------
type
 TPackedRec = record
  FromNum, ToNum: Integer;
 end;

//---------------------------------------------------------------------------
 TPackedList = class
 private
  Data: array of TPackedRec;
  DataCount: Integer;

  procedure ReqAmount(Amount: Integer);
  procedure Insert(Element: TPackedRec);
  procedure Remove(Index: Integer); overload;
  procedure Remove(Index0, Index1: Integer); overload;
  function FindRec(Num: Integer): Integer;
  function GetItem(Num: Integer): Boolean;
  procedure SetItem(Num: Integer; const Value: Boolean);
  function GetDesc(): string;
 public
  property Items[Num: Integer]: Boolean read GetItem write SetItem; default;
  property Desc: string read GetDesc;

  procedure Include(Num: Integer);
  procedure Clear();

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
const
 CacheSize = 128;
 NoIndex = -1;

//---------------------------------------------------------------------------
constructor TPackedList.Create();
begin
 inherited;

 ReqAmount(1);
 DataCount:= 0;
end;

//---------------------------------------------------------------------------
destructor TPackedList.Destroy();
begin

 inherited;
end;

//---------------------------------------------------------------------------
procedure TPackedList.ReqAmount(Amount: Integer);
var
 NewAmount: Integer;
begin
 NewAmount:= Ceil(Amount / CacheSize) * CacheSize;
 if (Length(Data) < NewAmount) then
  SetLength(Data, NewAmount);
end;

//---------------------------------------------------------------------------
procedure TPackedList.Insert(Element: TPackedRec);
var
 Index: Integer;
begin
 ReqAmount(DataCount + 1);

 Index:= DataCount;
 Inc(DataCount);

 Data[Index]:= Element;
end;

//---------------------------------------------------------------------------
procedure TPackedList.Remove(Index: Integer);
var
 i: Integer;
begin
 if (Index < 0)or(Index >= DataCount) then Exit;

 for i:= Index to DataCount - 2 do
  Data[i]:= Data[i + 1];

 Dec(DataCount);
end;

//---------------------------------------------------------------------------
procedure TPackedList.Remove(Index0, Index1: Integer);
var
 vMin, vMax: Integer;
begin
 vMin:= Min(Index0, Index1);
 vMax:= Max(Index0, Index1);

 Remove(vMax);
 Remove(vMin);
end;

//---------------------------------------------------------------------------
function TPackedList.FindRec(Num: Integer): Integer;
var
 i: Integer;
begin
 for i:= 0 to DataCount - 1 do
  if (Data[i].FromNum <= Num)and(Data[i].ToNum >= Num) then
   begin
    Result:= i;
    Exit;
   end;

 Result:= NoIndex;
end;

//---------------------------------------------------------------------------
procedure TPackedList.Include(Num: Integer);
var
 nIndex, Left, Right: Integer;
 NewRec: TPackedRec;
begin
 // check if this number is already included
 nIndex:= FindRec(Num);
 if (nIndex <> NoIndex) then Exit;

 // find closest numbers
 Left := FindRec(Num - 1);
 Right:= FindRec(Num + 1);

 // case 0: no neighbor numbers
 if (Left = NoIndex)and(Right = NoIndex) then
  begin
   NewRec.FromNum:= Num;
   NewRec.ToNum  := Num;
   Insert(NewRec);
  end else
 // case 1: [x..(Num - 1)] exists
 if (Left <> NoIndex)and(Right = NoIndex) then
  begin
   NewRec.FromNum:= Data[Left].FromNum;
   NewRec.ToNum  := Num;
   Remove(Left);
   Insert(NewRec);
  end else
 // case 2: [(Num - 1)..x] exists
 if (Left = NoIndex)and(Right <> NoIndex) then
  begin
   NewRec.FromNum:= Num;
   NewRec.ToNum  := Data[Right].ToNum;
   Remove(Right);
   Insert(NewRec);
  end else
 // case 3: [x..(Num - 1)] and [(Num + 1)..x] exist
 if (Left <> NoIndex)and(Right <> NoIndex) then
  begin
   NewRec.FromNum:= Data[Left].FromNum;
   NewRec.ToNum  := Data[Right].ToNum;
   Remove(Left, Right);
   Insert(NewRec);
  end;
end;

//---------------------------------------------------------------------------
procedure TPackedList.Clear();
begin
 DataCount:= 0;
end;

//---------------------------------------------------------------------------
function TPackedList.GetItem(Num: Integer): Boolean;
var
 Index: Integer;
begin
 Index:= FindRec(Num);
 Result:= (Index <> NoIndex);
end;

//---------------------------------------------------------------------------
procedure TPackedList.SetItem(Num: Integer; const Value: Boolean);
begin
 if (Value) then Include(Num);
end;

//---------------------------------------------------------------------------
function TPackedList.GetDesc(): string;
var
 s: string;
 i: Integer;
begin
 s:= '';
 for i:= 0 to DataCount - 1 do
  if (Data[i].FromNum <> Data[i].ToNum) then
   s:= s + '[' + IntToStr(Data[i].FromNum) + ' - ' + IntToStr(Data[i].ToNum) +  ']'
    else s:= s + '[' + IntToStr(Data[i].FromNum) + ']';

 Result:= s;
end;

//---------------------------------------------------------------------------
end.
