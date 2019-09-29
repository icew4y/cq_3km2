unit NetLinks;
//---------------------------------------------------------------------------
// NetLinks.pas                                         Modified: 25-May-2008
// Network Cacheable Connections                                 Version 1.01
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
// The Original Code is NetLinks.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2005 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, SysUtils, Math, PackedNums;

//---------------------------------------------------------------------------
type
//---------------------------------------------------------------------------
 TLink = record
  Host    : ShortString;
  Port    : Integer;
  Incoming: TPackedList;
  SendID  : Integer;
  Updated : Cardinal;
 end;

//---------------------------------------------------------------------------
 TLinks = class
 private
  Data: array of TLink;
  DataCount: Integer;

  procedure ReqData(Amount: Integer);
  function GetItem(Num: Integer): TLink;
  function GetDesc(): string;
 public
  property Count: Integer read DataCount;
  property Items[Num: Integer]: TLink read GetItem; default;
  property Desc: string read GetDesc;

  function Find(const Host: ShortString; Port: Integer): Integer;
  function Add(const Host: ShortString; Port: Integer): Integer;

  function GetSendID(const Host: ShortString; Port: Integer): Integer;
  function Confirmed(const Host: ShortString; Port: Integer;
   MsgID: Integer): Boolean;

  procedure Update(const Host: ShortString; Port: Integer);
  procedure Remove(Num: Integer);
  procedure Clear();
  procedure Timeout(Milliseconds: Integer);

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
const
 CacheSize = 256;
 NoIndex   = -1;

//---------------------------------------------------------------------------
constructor TLinks.Create();
begin
 inherited;

 ReqData(1);
 DataCount:= 0;
end;

//---------------------------------------------------------------------------
destructor TLinks.Destroy();
begin
 Clear();

 inherited;
end;

//---------------------------------------------------------------------------
procedure TLinks.ReqData(Amount: Integer);
var
 NewAmount: Integer;
begin
 NewAmount:= Ceil(Amount / CacheSize) * CacheSize;
 if (Length(Data) < NewAmount) then
  SetLength(Data, NewAmount);
end;

//---------------------------------------------------------------------------
function TLinks.GetItem(Num: Integer): TLink;
begin
 if (Num < 0)or(Num >= DataCount) then
  begin
   FillChar(Result, SizeOf(TLink), 0);
   Exit;
  end;

 Result:= Data[Num];
end;

//---------------------------------------------------------------------------
function TLinks.Find(const Host: ShortString; Port: Integer): Integer;
var
 i: Integer;
begin
 for i:= 0 to DataCount - 1 do
  if (Port = Data[i].Port)and(SameText(Host, Data[i].Host)) then
   begin
    Result:= i;
    Exit;
   end;

 Result:= NoIndex;
end;

//---------------------------------------------------------------------------
function TLinks.Add(const Host: ShortString; Port: Integer): Integer;
var
 Index: Integer;
begin
 // check if the host already exists
 Index:= Find(Host, Port);
 if (Index <> NoIndex) then
  begin
   Result:= Index;
   Exit;
  end;

 // request additional data units
 ReqData(DataCount + 1);

 // increment the data index
 Index:= DataCount;
 Inc(DataCount);

 // initialize comm contents
 Data[Index].Host    := LowerCase(Host);
 Data[Index].Port    := Port;
 Data[Index].Incoming:= TPackedList.Create();
 Data[Index].SendID  := 0;
 Data[Index].Updated := GetTickCount();

 Result:= Index;
end;

//---------------------------------------------------------------------------
procedure TLinks.Clear();
var
 i: Integer;
begin
 for i:= 0 to DataCount - 1 do
  if (Data[i].Incoming <> nil) then
   begin
    Data[i].Incoming.Free();
    Data[i].Incoming:= nil;
   end;

 DataCount:= 0;
end;

//---------------------------------------------------------------------------
procedure TLinks.Remove(Num: Integer);
var
 i: Integer;
begin
 if (Num < 0)or(Num >= DataCount) then Exit;

 if (Data[Num].Incoming <> nil) then
  begin
   Data[Num].Incoming.Free();
   Data[Num].Incoming:= nil;
  end;

 for i:= Num to DataCount - 2 do
  Data[i]:= Data[i + 1];

 Dec(DataCount);
end;

//---------------------------------------------------------------------------
procedure TLinks.Update(const Host: ShortString; Port: Integer);
var
 Index: Integer;
begin
 Index:= Add(Host, Port);
 if (Index <> NoIndex) then
  Data[Index].Updated:= GetTickCount();
end;

//---------------------------------------------------------------------------
procedure TLinks.Timeout(Milliseconds: Integer);
var
 CurTime: Cardinal;
 i: Integer;
begin
 CurTime:= GetTickCount();

 for i:= DataCount - 1 downto 0 do
  if (CurTime - Data[i].Updated > Cardinal(Milliseconds)) then Remove(i);
end;

//---------------------------------------------------------------------------
function TLinks.GetDesc(): string;
var
 s: string;
 i: Integer;
 CurTime: TDateTime;
begin
 CurTime:= Now();
 s:= '';

 for i:= 0 to DataCount - 1 do
  begin
   s:= s + Data[i].Host;
   s:= s + ':' + IntToStr(Data[i].Port);
   s:= s + ' <- ' + IntToStr(Data[i].SendID);
   s:= s + ' ' + Data[i].Incoming.Desc;
   s:= s + ' @ ' + TimeToStr(CurTime - Data[i].Updated) + #13#10;
  end;

 Result:= s;
end;

//---------------------------------------------------------------------------
function TLinks.GetSendID(const Host: ShortString; Port: Integer): Integer;
var
 Index: Integer;
begin
 // retreive the link
 Index:= Add(Host, Port);

 // retreive current ID
 Result:= Data[Index].SendID;

 // increment current ID
 Inc(Data[Index].SendID);
end;

//---------------------------------------------------------------------------
function TLinks.Confirmed(const Host: ShortString; Port: Integer;
 MsgID: Integer): Boolean;
var
 Index: Integer;
begin
 // retreive the link
 Index:= Add(Host, Port);

 // check if the packet has been confirmed
 Result:= Data[Index].Incoming[MsgID];

 // confirm the packet
 Data[Index].Incoming.Include(MsgID);
end;

//---------------------------------------------------------------------------
end.

