{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{        Language Parser Unit - EParser          }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EParser;

{$I Exceptions.inc}

interface

function FindProcStartLineDelphi(const Txt, ProcName: string): Integer;
function FindProcStartLineCppBuilder(const Txt, ProcName: string): Integer;

implementation

uses
  Windows, SysUtils, Classes;

var
  // Number of comment symbols
  CommentsNumber: Integer;

  // Comment and "quote start" symbols
  StartComments: array[0..3] of string;

  // Comment and "quote end" symbols
  EndComments: array[0..3] of string;

  // Set uses for check names...
  NameSet: set of char;

  BeginWord, EndWord: string;

  CaseSensitive: Boolean;

  EndProcWord: string = ');';
  ImplementationWord: string = '实施'{'implementation'};
  InitializationWord: string = '初始化'{'initialization'};
  FinalizationWord: string = '定稿'{'finalization'};
  ForwardWord: string = '前进'{'forward'};
  ExternalWord: string = '外部'{'external'};

  ProcArray: array [0..3] of string = ('过程'{'procedure'}, '函数'{'function'},
    '构造函数'{'constructor'}, '破坏者'{'destructor'});

// This function kill spaces, linebreak (#13#10), directives and comments,
// from Txt string starting to Idx position char...
function KillInutilChars(const Txt: string; var Idx: Integer): Boolean;
var
  i, old: integer;
begin
  Result := False;
  repeat
    old := Idx;
    // Search spaces and "#13#10" chars...
    while (Idx <= Length(Txt)) and ((Txt[Idx] <= #32)) do Inc(Idx);

    // Search directives and comments...
    I := 0;
    while (I <= CommentsNumber) and
      (Copy(Txt, Idx, Length(StartComments[I])) <> StartComments[I]) do Inc(I);

    // Found a directive or comment "Start" and search the "End"...
    if (I <= CommentsNumber) then
    begin
      Inc(Idx, Length(StartComments[I]));
      while (Idx <= Length(Txt)) and
        (Copy(Txt, Idx, Length(EndComments[I])) <> EndComments[I]) do Inc(Idx);
      if Idx <= Length(Txt) then Inc(Idx, Length(EndComments[I]));
    end;
    Result := (Result) or (Idx <> old);
  until (Idx = old);
end;

function EnumerateWord(const Txt: string; var Idx: Integer; var Word: string): Boolean;
var
  old: Integer;
begin
  KillInutilChars(Txt, Idx);
  if (Idx <= Length(Txt)) and (not (Txt[Idx] in NameSet)) then
  begin
    repeat
      KillInutilChars(Txt, Idx);
      if not (Txt[Idx] in NameSet) then Inc(Idx);
    until (Idx > Length(Txt)) or (Txt[Idx] in NameSet);
  end;
  old := Idx;
  while (Idx <= Length(Txt)) and (Txt[Idx] in NameSet) do Inc(Idx);
  Word := Trim(Copy(Txt, old, Idx - old));
  Result := (Word <> '');
end;

function CompareWord(const Value: string; Words: array of string): Boolean;
var
  n: Integer;
begin
  Result := False;
  if (not CaseSensitive) then
    begin
      for n := Low(Words) to High(Words) do
        Result := (Result or (CompareText(Value, Words[n]) = 0))
    end
  else
    begin
      for n := Low(Words) to High(Words) do
        Result := (Result or (Value = Words[n]));
    end;
end;

function CharPosToLineNo(const Txt: string; Idx: Integer): Integer;
var
  Lines: TStrings;
  n, Num: Integer;
begin
  Result := 0;
  Lines := TStringList.Create;
  try
    Lines.Text := Txt;
    Num := 0;
    for n := 0 to (Lines.Count - 1) do
    begin
      if (Num < Idx) then Inc(Num, Length(Lines[n]) + 2);
      if (Num >= Idx) then
      begin
        Result := (n + 1);
        Break;
      end;
    end;
  finally
    Lines.Free;
  end;
end;

function FindWord(const Txt: string; Words: array of string; var Idx: Integer): Boolean;
var
  EnumWord: string;
begin
  repeat
    EnumerateWord(Txt, Idx, EnumWord);
    Result := CompareWord(EnumWord, Words);
  until (Idx >= Length(Txt)) or (Result);
end;

procedure SkipProcedure(const Txt: string; var Idx: Integer);
var
  OpenBegin: Integer;
  Word: string;
begin
  OpenBegin := 1;
  while (Idx <= Length(Txt)) and (OpenBegin > 0) and (EnumerateWord(Txt, Idx, Word)) do
  begin
    if (CompareWord(Word, [BeginWord])) then Inc(OpenBegin)
    else
      if (CompareWord(Word, [EndWord])) then Dec(OpenBegin);
  end;
end;

function FindProcStartIdx(const Txt: string; var Idx: Integer): Boolean;
var
  Word: string;
begin
  Result := False;
  while (Idx <= Length(Txt)) and (EnumerateWord(Txt, Idx, Word)) do
  begin
    if (CompareWord(Word, [ForwardWord])) then Exit
    else
      if (CompareWord(Word, [ExternalWord])) then
      begin
        Result := True;
        Exit;
      end
      else
        if (CompareWord(Word, ProcArray)) then
        begin
          Result := FindProcStartIdx(Txt, Idx);
          SkipProcedure(Txt, Idx);
        end
        else
          if (CompareWord(Word, [BeginWord])) then
          begin
            Result := True;
            Exit;
          end;
  end;
end;

function FindProcStartLineDelphi(const Txt, ProcName: string): Integer;

  function InternalFindProcStartLineDelphi(const Txt, ProcName: string): Integer;
  var
    Word: string;
    Old_Idx, Idx, Start_Idx: Integer;
  begin
    Result := 0;
    Idx := 1;
    if (not FindWord(Txt, [ImplementationWord], Idx)) then Idx := 1;
    Start_Idx := Idx;

    if (LowerCase(ProcName) = FinalizationWord) then
    begin
      if FindWord(Txt, [ProcName], Idx) then
        Result := CharPosToLineNo(Txt, Idx);
      Exit;
    end;

    if (LowerCase(ProcName) = InitializationWord) then
    begin
      if FindWord(Txt, [ProcName], Idx) then
        Result := CharPosToLineNo(Txt, Idx)
      else
      begin
        Idx := Start_Idx;
        Result := InternalFindProcStartLineDelphi(Txt, '');
      end;
      Exit;
    end;

    if (ProcName = '') then
    begin
      if FindWord(Txt, [InitializationWord], Idx) then
        Result := CharPosToLineNo(Txt, Idx)
      else
      begin
        Idx := Start_Idx;
        while (Idx <= Length(Txt)) and (EnumerateWord(Txt, Idx, Word)) do
        begin
          if (CompareWord(Word, ProcArray)) then
          begin
            if FindProcStartIdx(Txt, Idx) then
            begin
              Old_Idx := Idx;
              Dec(Idx, Length(BeginWord));
              EnumerateWord(Txt, Idx, Word);
              if (Old_Idx = Idx) and (CompareWord(Word, [BeginWord])) then
                SkipProcedure(Txt, Idx);
            end;
          end
          else
            if (CompareWord(Word, [BeginWord])) then
            begin
              Result := CharPosToLineNo(Txt, Idx);
              Break;
            end;
        end;
      end;
      Exit;
    end;

    while (Idx <= Length(Txt)) and (FindWord(Txt, ProcArray, Idx)) do
    begin
      EnumerateWord(Txt, Idx, Word);
      if (CompareWord(ProcName, [Word])) then
      begin
        if FindProcStartIdx(Txt, Idx) then
          Result := CharPosToLineNo(Txt, Idx)
      end;
    end;
  end;

  procedure SetGlobalVariables;
  begin
    CommentsNumber := 4;

    StartComments[0] := '{';
    StartComments[1] := '(*';
    StartComments[2] := '//';
    StartComments[3] := '''';

    EndComments[0] := '}';
    EndComments[1] := '*)';
    EndComments[2] := #13#10;
    EndComments[3] := '''';

    NameSet := ['a'..'z', 'A'..'Z', '0'..'9', '_', '.'];

    BeginWord := 'begin';
    EndWord := 'end';

    CaseSensitive := False;
  end;

begin
  SetGlobalVariables;
  Result := InternalFindProcStartLineDelphi(Txt, ProcName);
end;

function FindProcStartLineCppBuilder(const Txt, ProcName: string): Integer;
var
  Word: string;
  Idx: Integer;

  procedure SetGlobalVariables;
  begin
    CommentsNumber := 3;

    StartComments[0] := '/*';
    StartComments[1] := '//';
    StartComments[2] := '"';
    StartComments[3] := '';

    EndComments[0] := '*/';
    EndComments[1] := #13#10;
    EndComments[2] := '"';
    EndComments[3] := '';

    NameSet := ['a'..'z', 'A'..'Z', '0'..'9', '_', ':', '{', '}', ')', ';'];

    BeginWord := '{';
    EndWord := '}';

    CaseSensitive := True;
  end;

begin
  SetGlobalVariables;

  Result := 0;
  Idx := 1;
  repeat
    if (FindWord(Txt, ProcName, Idx)) then
    begin
      while (Idx <= Length(Txt)) do
      begin
        EnumerateWord(Txt, Idx, Word);
        if (CompareWord(EndProcWord, [Copy(Word, Length(Word) - 1, 2)])) then
        begin
          Result := CharPosToLineNo(Txt, Idx);
          Break;
        end
        else
          if (CompareWord(BeginWord, [Word])) then
          begin
            Result := CharPosToLineNo(Txt, Idx);
            Exit;
          end;
      end;
    end;
  until (Idx > Length(Txt));
end;

end.
