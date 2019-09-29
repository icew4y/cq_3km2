unit EventProviders;
//---------------------------------------------------------------------------
// EventProviders.pas                                   Modified: 12-May-2007
//---------------------------------------------------------------------------
//
// Observer Pattern implementation, also called Subscriber-Publisher.
//
//---------------------------------------------------------------------------
// This source code is copyright protected and cannot be used without
// explicit permission of the following persons:
//
//  M. Sc. Yuriy Kotsarenko  - yunkot@gmail.com
//  Eng. Humberto Andrade    - humberto.andrade@gmail.com
//
// The contents of this file are copyright (c) 2007 of the authors specified
// above. All rights reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
type
 TEventCallback = procedure(Sender: TObject; Param: Pointer;
  var Handled: Boolean) of object;

//---------------------------------------------------------------------------
 PEventItem = ^TEventItem;
 TEventItem = record
  EventID : Cardinal;
  Callback: TEventCallback;
  Priority: Integer;
 end;

//---------------------------------------------------------------------------
type
 TEventProvider = class
 private
  CurrentID : Cardinal;
  EventItems: array of TEventItem;
  OrderDirty: Boolean;

  function NextID(): Cardinal;
  function IndexOf(EventID: Cardinal): Integer;
  procedure Remove(Index: Integer);
  procedure DoSort(Left, Right: Integer);
  procedure SortCallbacks();
 public
  function Subscribe(Callback: TEventCallback; Priority: Integer): Cardinal;
  procedure Unsubscribe(EventID: Cardinal);

  function Notify(Sender: TObject; Param: Pointer): Boolean;

  constructor Create();
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
constructor TEventProvider.Create();
begin
 inherited;

 CurrentID:= 0;
end;

//---------------------------------------------------------------------------
function TEventProvider.NextID(): Cardinal;
begin
 Result:= CurrentID;
 Inc(CurrentID);
end;

//---------------------------------------------------------------------------
function TEventProvider.IndexOf(EventID: Cardinal): Integer;
var
 i: Integer;
begin
 Result:= -1;
 for i:= 0 to Length(EventItems) - 1 do
  if (EventItems[i].EventID = EventID) then
   begin
    Result:= i;
    Break;
   end;
end;

//---------------------------------------------------------------------------
function TEventProvider.Subscribe(Callback: TEventCallback;
 Priority: Integer): Cardinal;
var
 Index: Integer;
begin
 Result:= NextID();

 Index:= Length(EventItems);
 SetLength(EventItems, Index + 1);

 EventItems[Index].EventID := Result;
 EventItems[Index].Callback:= Callback;
 EventItems[Index].Priority:= Priority;

 OrderDirty:= True;
end;

//---------------------------------------------------------------------------
procedure TEventProvider.Remove(Index: Integer);
var
 i: Integer;
begin
 if (Index < 0)or(Index >= Length(EventItems)) then Exit;

 for i:= Index to Length(EventItems) - 2 do
  EventItems[i]:= EventItems[i + 1];

 SetLength(EventItems, Length(EventItems) - 1);

 OrderDirty:= True;
end;

//---------------------------------------------------------------------------
procedure TEventProvider.Unsubscribe(EventID: Cardinal);
begin
 Remove(IndexOf(EventID));
end;

//---------------------------------------------------------------------------
procedure TEventProvider.DoSort(Left, Right: Integer);
var
 Lo, Hi  : Integer;
 TempItem: TEventItem;
 MidValue: Integer;
begin
 Lo:= Left;
 Hi:= Right;
 MidValue:= EventItems[(Left + Right) div 2].Priority;

 repeat
  while (EventItems[Lo].Priority < MidValue) do Inc(Lo);
  while (EventItems[Hi].Priority > MidValue) do Dec(Hi);

  if (Lo <= Hi) then
   begin
    TempItem:= EventItems[Lo];
    EventItems[Lo]:= EventItems[Hi];
    EventItems[Hi]:= TempItem;

    Inc(Lo);
    Dec(Hi);
   end;
 until (Lo > Hi);

 if (Left < Hi) then DoSort(Left, Hi);
 if (Lo < Right) then DoSort(Lo, Right);
end;

//---------------------------------------------------------------------------
procedure TEventProvider.SortCallbacks();
begin
 if (Length(EventItems) > 0) then DoSort(0, Length(EventItems) - 1);

 OrderDirty:= False;
end;

//---------------------------------------------------------------------------
function TEventProvider.Notify(Sender: TObject; Param: Pointer): Boolean;
var
 i: Integer;
begin
 if (OrderDirty) then SortCallbacks();

 Result:= False;
 for i:= 0 to Length(EventItems) - 1 do
  begin
   EventItems[i].Callback(Sender, Param, Result);
   if (Result) then Break;
  end;
end;

//---------------------------------------------------------------------------
end.
