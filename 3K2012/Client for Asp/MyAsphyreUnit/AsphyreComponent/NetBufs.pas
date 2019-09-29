unit NetBufs;
//---------------------------------------------------------------------------
// NetBufs.pas                                         Modified: 25-May-2008
// Network Cacheable Buffers                                     Version 1.0
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
// The Original Code is NetBufs.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2005 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Math, SysUtils;

//---------------------------------------------------------------------------
type
 PNetBuffer = ^TNetBuffer;
 TNetBuffer = record
  Host     : ShortString;
  Port     : Integer;
  MsgID    : Integer;
  SendTime : Cardinal;
  SendCount: Integer;
  Packet   : Cardinal;
 end;

//---------------------------------------------------------------------------
 TNetBufs = class
 private
  Data: array of PNetBuffer;
  DataCount: Integer;
  FBufferSize: Integer;

  procedure Precache(Req: Integer);
  procedure SetBufferSize(const Value: Integer);
  function GetItem(Num: Integer): PNetBuffer;
 public
  property BufferSize: Integer read FBufferSize write SetBufferSize;
  property Items[Num: Integer]: PNetBuffer read GetItem; default;
  property Count: Integer read DataCount;

  function Add(): Integer;
  procedure Remove(Num: Integer);
  procedure Clear();

  function FindByID(MsgID: Integer): Integer;
  procedure RemoveID(MsgID: Integer);

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
const
 CacheSize = 32;

//---------------------------------------------------------------------------
constructor TNetBufs.Create();
begin
 inherited;

 FBufferSize:= 512;
 DataCount:= 0;
 SetLength(Data, 0);
 Precache(1);
end;

//---------------------------------------------------------------------------
destructor TNetBufs.Destroy();
var
 i: Integer;
begin
 for i:= 0 to Length(Data) - 1 do
  begin
   FreeMem(Data[i]);
   Data[i]:= nil;
  end;
 SetLength(Data, 0);
 DataCount:= 0;

 inherited;
end;

//---------------------------------------------------------------------------
procedure TNetBufs.Precache(Req: Integer);
var
 Amount, Cached, i: Integer;
begin
 Amount:= Ceil(Req / CacheSize) * CacheSize;
 Cached:= Length(Data);

 if (Cached < Amount) then
  begin
   SetLength(Data, Amount);

   for i:= Cached to Amount - 1 do
    Data[i]:= AllocMem(FBufferSize);
  end;
end;

//---------------------------------------------------------------------------
procedure TNetBufs.SetBufferSize(const Value: Integer);
var
 i: Integer;
begin
 FBufferSize:= Value;
 if (FBufferSize < 512) then FBufferSize:= 512;

 for i:= 0 to Length(Data) - 1 do
  ReallocMem(Data[i], FBufferSize);
end;

//---------------------------------------------------------------------------
function TNetBufs.GetItem(Num: Integer): PNetBuffer;
begin
 if (Num < 0)or(Num >= DataCount) then
  begin
   Result:= nil;
   Exit;
  end;

 Result:= Data[Num];  
end;

//---------------------------------------------------------------------------
procedure TNetBufs.Clear();
begin
 DataCount:= 0;
end;

//---------------------------------------------------------------------------
function TNetBufs.Add(): Integer;
var
 Index: Integer;
begin
 Precache(DataCount + 1);

 Index:= DataCount;
 Inc(DataCount);

 Result:= Index;
end;

//---------------------------------------------------------------------------
procedure TNetBufs.Remove(Num: Integer);
var
 i: Integer;
begin
 if (Num < 0)or(Num >= DataCount) then Exit;

 for i:= Num to DataCount - 2 do
  Move(Data[i + 1]^, Data[i]^, FBufferSize);

 Dec(DataCount); 
end;

//---------------------------------------------------------------------------
function TNetBufs.FindByID(MsgID: Integer): Integer;
var
 i: Integer;
begin
 for i:= 0 to DataCount - 1 do
  if (Data[i].MsgID = MsgID) then
   begin
    Result:= i;
    Exit;
   end;

 Result:= -1;   
end;

//---------------------------------------------------------------------------
procedure TNetBufs.RemoveID(MsgID: Integer);
var
 Index: Integer;
begin
 Index:= FindByID(MsgID);
 if (Index <> -1) then Remove(Index);
end;

//---------------------------------------------------------------------------
end.
