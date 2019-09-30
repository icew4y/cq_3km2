unit HGEImages;
//---------------------------------------------------------------------------
//                                                     Modified: 17-Dec-2008
// HGE Images class                                          
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
// The Original Code is AsphyreImages.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
(*
** hgeImages helper class
** Extension to the HGE engine
** Extension added by DraculaLin
** This extension is NOT part of the original HGE engine.
*)

interface

uses
  Windows, SysUtils, StrUtils, HGE;

type

 THGEImages = class
 private
   Images: array of ITexture;
   SearchObjects: array of Integer;
   SearchDirty  : Boolean;
   function GetItem(Index: Integer): ITexture;
   function GetItemCount(): Integer;
   procedure InitSearchObjects();
   procedure SwapSearchObjects(Index1, Index2: Integer);
   function CompareSearchObjects(Obj1, Obj2: ITexture): Integer;
   function SplitSearchObjects(Start, Stop: Integer): integer;
   procedure SortSearchObjects(Start, Stop: integer);
   procedure UpdateSearchObjects();
   function GetImage(const Name: string): ITexture;
 public
   property Items[Index: Integer]: ITexture read GetItem; default;
   property ItemCount: Integer read GetItemCount;
   property Image[const Name: string]: ITexture read GetImage;
   function IndexOf(Element: ITexture): Integer; overload;
   function IndexOf(const Name: string): Integer; overload;
   procedure Remove(Index: Integer);
   procedure LoadFromFile(FileName: string); overload;
   procedure LoadFromFile(FileName: string; PatternWidth, PatternHeight: Integer); overload;
   procedure RemoveAll();
   procedure MarkSearchDirty();
   constructor Create();
   destructor Destroy(); override;
 end;

implementation
var
  FHGE: IHGE = nil;

constructor THGEImages.Create();
begin
 //inherited;
  FHGE := HGECreate(HGE_VERSION);
  SearchDirty:= False;
end;

destructor THGEImages.Destroy();
begin
  RemoveAll();
  inherited;
end;

function THGEImages.GetItem(Index: Integer): ITexture;
begin
  if (Index >= 0)and(Index < Length(Images)) then
    Result:= Images[Index] else Result:= nil;
end;

function THGEImages.GetItemCount(): Integer;
begin
  Result:= Length(Images);
end;

function THGEImages.IndexOf(Element: ITexture): Integer;
var
 I: Integer;
begin
  Result:= -1;

  for I:= 0 to Length(Images) - 1 do
    if (Images[i] = Element) then
    begin
      Result:= I;
      Break;
    end;
end;

procedure THGEImages.RemoveAll();
begin
  SetLength(Images, 0);
  SearchDirty:= True;
end;

procedure THGEImages.Remove(Index: Integer);
var
 I: Integer;
begin
  if (Index < 0)or(Index >= Length(Images)) then Exit;
  for I:= Index to Length(Images) - 2 do
    Images[I]:= Images[I + 1];
  SetLength(Images, Length(Images) - 1);
  SearchDirty:= True;
end;

procedure THGEImages.InitSearchObjects();
var
 I: Integer;
begin
  if (Length(Images) <> Length(SearchObjects)) then
    SetLength(SearchObjects, Length(Images));
  for I:= 0 to Length(Images) - 1 do
    SearchObjects[I]:= I;
end;

procedure THGEImages.SwapSearchObjects(Index1, Index2: Integer);
var
 Aux: Integer;
begin
  Aux:= SearchObjects[Index1];
  SearchObjects[Index1]:= SearchObjects[Index2];
  SearchObjects[Index2]:= Aux;
end;

function THGEImages.CompareSearchObjects(Obj1, Obj2: ITexture): Integer;
begin
  Result:= CompareText(Obj1.Name, Obj2.Name);
end;

function THGEImages.SplitSearchObjects(Start, Stop: Integer): Integer;
var
  Left, Right: Integer;
  Pivot: ITexture;
begin
  Left := Start + 1;
  Right:= Stop;
  Pivot:= Images[SearchObjects[Start]];
  while (Left <= Right) do
  begin
    while (Left <= Stop)and(CompareSearchObjects(Images[SearchObjects[Left]],
    Pivot) < 0) do Inc(Left);

    while (Right > Start)and(CompareSearchObjects(Images[SearchObjects[Right]],
    Pivot) >= 0) do Dec(Right);

    if (Left < Right) then SwapSearchObjects(Left, Right);
  end;

  SwapSearchObjects(Start, Right);
  Result:= Right;
end;


procedure THGEImages.SortSearchObjects(Start, Stop: Integer);
var
 SplitPt: integer;
begin
  if (Start < Stop) then
  begin
    SplitPt:= SplitSearchObjects(Start, Stop);
    SortSearchObjects(Start, SplitPt - 1);
    SortSearchObjects(SplitPt + 1, Stop);
  end;
end;


procedure THGEImages.UpdateSearchObjects();
begin
  InitSearchObjects();
  SortSearchObjects(0, Length(SearchObjects) - 1);
  SearchDirty:= False;
end;

function THGEImages.IndexOf(const Name: string): Integer;
var
 Lo, Hi, Mid: Integer;
begin
  if (SearchDirty) then UpdateSearchObjects();
  Result:= -1;
  Lo:= 0;
  Hi:= Length(SearchObjects) - 1;
  while (Lo <= Hi) do
  begin
    Mid:= (Lo + Hi) div 2;
    if (CompareText(Images[SearchObjects[Mid]].Name, Name) = 0) then
    begin
      Result:= SearchObjects[Mid];
      Break;
    end;
    if (CompareText(Images[SearchObjects[Mid]].Name, Name) > 0) then
      Hi:= Mid - 1 else Lo:= Mid + 1;
  end;
end;

function THGEImages.GetImage(const Name: string): ITexture;
var
 Index: Integer;
begin
  Index:= IndexOf(Name);
  if (Index <> -1) then Result:= Images[Index] else Result:= nil;
end;

procedure THGEImages.MarkSearchDirty();
begin
  SearchDirty:= True;
end;

procedure THGEImages.LoadFromFile(FileName: string);
var
  Index: Integer;
begin
  Index:= Length(Images);
  SetLength(Images, Index + 1);
  Images[Index] := FHGE.Texture_Load(FileName);
  Images[Index].Name := ExtractFileName(MidStr(FileName, 0, Length(FileName)-4));
  Images[Index].PatternWidth := Images[Index].GetWidth(True);
  Images[Index].PatternHeight := Images[Index].GetHeight(True);
  SearchDirty:= True;
end;

procedure THGEImages.LoadFromFile(FileName: string; PatternWidth, PatternHeight: Integer);
var
  Index: Integer;
begin
  Index:= Length(Images);
  SetLength(Images, Index + 1);
  Images[Index] := FHGE.Texture_Load(FileName);
  Images[Index].Name := ExtractFileName(MidStr(FileName, 0, Length(FileName)-4));
  Images[Index].PatternWidth := PatternWidth;
  Images[Index].PatternHeight := PatternHeight;
  SearchDirty:= True;
end;

initialization
  FHGE := nil;

end.
