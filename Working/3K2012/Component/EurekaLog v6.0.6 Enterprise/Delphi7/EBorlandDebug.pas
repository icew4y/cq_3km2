{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{       Borland Debug Unit - EBorlandDebug       }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EBorlandDebug;

{$I Exceptions.inc}

interface

uses Windows, Classes, SysUtils;

procedure CompleteMapFile(const MapFile: string);
procedure GetDebugData(FileName: string; Data: TStrings);

implementation

uses ECore;

const
  DllName = 'BorDebug.dll';

  sstAlignSym = 293;
  sstSrcModule = 295;
  sstGlobalSym = 297;

  st_GProfRef = 32;
  st_GProc32 = 517;

  MapSourceLine = 'Line numbers for %s(%s) segment .text';
  MapPublicLine = '  Address         Publics by Value';
  MapSearchedLine0 = ' Address Publics by Name'; //          C++Builder 6 linker.
  MapSearchedLine1 = '  Address         Publics by Name'; // C++Builder 5 linker.

type
  TArray = array[0..0] of DWord;
  PArray = ^TArray;

// Borland Debug API...

var
  _BorDebugRegisterFile: function(const FileName: PChar; SkipNames: LongBool;
    CacheNames: LongBool; var Failure: DWord): THandle; cdecl;

  _BorDebugUnregisterFile: procedure(Handle: THandle); cdecl;

  _BorDebugSubSectionCount: function(Handle: THandle): DWord; cdecl;

  _BorDebugSubSection: procedure(Handle: THandle; SubSectionNo: DWord;
    var SubsectionType, Module, Offset, Size: DWord); cdecl;

  _BorDebugSrcModule: procedure(Handle: THandle; Offset: DWord;
    var RangeCount, SourceCount: DWord); cdecl;

  _BorDebugSrcModuleSources: procedure(Handle: THandle; Offset: DWord;
    SourceOffsets, Names, RangeCounts: PArray); cdecl;

  _BorDebugSrcModuleSourceRanges: procedure(Handle: THandle; Offset,
    Source: DWord; Segments, SegmentStarts, SegmentEnds,
    LineNumberCounts: PArray); cdecl;

  _BorDebugSrcModuleLineNumbers: procedure(Handle: THandle; Offset, Source,
    Range: DWord; LineNumbers, LineOffsets: PArray); cdecl;

  _BorDebugNameIndexToName: procedure(Handle: THandle; NameIndex: DWord;
    Buf: PChar; BufLen: DWord); cdecl;

  _BorDebugStartSymbols: procedure(Handle: THandle; SubSectionType, Offset,
    Size: DWord); cdecl;

  _BorDebugNextSymbol: procedure(Handle: THandle; var Kind, SymOffset,
    SymLen: DWord); cdecl;

  _BorDebugSymbolGPROC32: function(Handle: THandle; SymOffset: DWord;
    var Parent, End_, Next, CodeLength, DebugStart, DebugEnd, Offset,
    Segment, Flags, TypeIndex, NameIndex, BrowserOffset: DWord;
    LinkName: PChar; MaxLinkName: DWord): DWord; cdecl;

  _BorDebugSymbolGPROCREF: procedure(Handle: THandle; SymOffset: DWord;
    var RefSymOffset, TypeIndex, NameIndex, BrowserOffset, CodeSegment,
    CodeOffset: DWord); cdecl;

  DllHandle: THandle;

procedure GetDebugData(FileName: string; Data: TStrings);
type
  TSegment = packed record
    SegStart, SegEnd: DWord;
    Name: string;
  end;
var
  Res: DWord;
  Handle: THandle;

  Procedures: TStringList;

  n, l, SourceIndex, RangeIndex: Integer;

  SectionCount, SubsectionType, Module,
    Offset, Size, RangeCount, SourceCount, LineNo, LastLineNo: DWord;

  SymKind, SymOffset, SymLen, RefOffset: DWord;

  SymEOF: boolean;

  SymName: string;

  SegmentsList: TStringList;

  Seg: TSegment;

  SourceOffsets, Names, RangeCounts, LineNumbers, LineOffsets,
    Segments, SegmentStarts, SegmentEnds, LineNumberCounts: PArray;

  SourceName: string;

  four: DWord;

  UnitSourceLine: string;

  Parent, End_, Next, CodeLength, DebugStart, DebugEnd, SOffset, Segment,
    Flags, TypeIndex, NameIndex, BrowserOffset: DWord;

  function SixSpaces(num: DWord): string;
  var
    i: integer;
  begin
    Result := IntToStr(num);
    for i := length(Result) to 5 do Result := ' ' + Result;
  end;

  function GetName(Handle: THandle; idx: DWord): string;
  var
    Buffer: array[0..260] of char;
  begin
    _BorDebugNameIndexToName(Handle, idx, @Buffer, SizeOf(Buffer));
    SetString(Result, Buffer, StrLen(Buffer));
  end;

  function ExtractProcName(LineStr: string): string;
  var
    i: integer;

    procedure ExtractStr;
    var
      p, i: integer;
      List: TStringList;
    begin
      List := TStringList.Create;
      i := 1;
      p := i;
      repeat
        while (i <= length(LineStr)) and (LineStr[i] <> '.') do
          inc(i);
        List.Add(Copy(LineStr, p, i - p));
        inc(i);
        p := i;
      until (i > length(LineStr));
      case List.Count of
        1: Result := List[0];
        2: Result := List[0] + '.' + List[1];
        3: Result := List[0] + '.' + List[1] + '.' + List[2];
      end;
      List.Free;
    end;

  begin
    Result := LineStr;
    if (LineStr <> '') then
    begin
      if (LineStr[1] = '@') then // BPL
      begin
        if (length(LineStr) > 1) and (LineStr[2] <> '$') then
        begin
          i := Pos('$', LineStr);
          if i <> 0 then
            LineStr := Copy(LineStr, 1, i - 1);
          i := Pos('%', LineStr);
          if i <> 0 then
            LineStr := Copy(LineStr, 1, i - 1);
          if (LineStr <> '') and (LineStr[length(LineStr)] = '@') then
            Delete(LineStr, length(LineStr), 1);
          if (LineStr <> '') then
          begin
            Delete(LineStr, 1, 1);
            i := Pos('@@', LineStr);
            if i > 0 then LineStr[i + 1] := '_'; // System '@' --> '_'
            i := 1;
            while (i <= length(LineStr)) do
            begin
              if (LineStr[i] = '@') then
              begin
                LineStr[i] := '.';
                inc(i); // Skip the second '@' char
              end;
              inc(i);
            end;
            ExtractStr;
          end;
        end
        else
          Result := '';
      end;
    end;
  end;

  function ExtractFileNameEx(const FileName: string): string;
  var
    n: integer;
  begin
    Result := ExtractFileName(FileName);
    for n := 1 to length(Result) do
      if Result[n] = '/' then Result[n] := '\';
  end;

  function ErrorType(Cod: Integer): string;
  begin
    if (Cod > 0) and (Cod < 6) then
      case Cod of
        1: Result := 'Unknown extension.';
        2: Result := 'Cannot open the file.';
        3: Result := 'No debug info presents.';
        4: Result := 'Error reading file.';
        5: Result := 'Out of memory.';
      end;
  end;

begin
  Handle := _BorDebugRegisterFile(PChar(FileName), False, True, Res);
  if (Res <> 0) or (Handle = 0) then
    raise Exception.CreateFmt('Cannot open the debug file: %s.'#13#10'Error: %s',
      [FileName, ErrorType(Res)]);

  Seg.Name := '';
  SectionCount := _BorDebugSubSectionCount(Handle);
  SegmentsList := TStringList.Create;
  SegmentsList.Sorted := True;
  Procedures := TStringList.Create;
  Procedures.Sorted := True;
  try
    for n := 0 to SectionCount - 1 do
    begin
      _BorDebugSubSection(Handle, n, SubsectionType, Module, Offset, Size);
      if SubsectionType = sstSrcModule then
      begin
        _BorDebugSrcModule(Handle, Offset, RangeCount, SourceCount);

        // Get the Sources data...
        GetMem(SourceOffsets, SourceCount * 4);
        GetMem(Names, SourceCount * 4);
        GetMem(RangeCounts, SourceCount * 4);
        _BorDebugSrcModuleSources(Handle, Offset, SourceOffsets, Names, RangeCounts);

        // Get the Ranges data...
        for SourceIndex := 0 to SourceCount - 1 do
        begin

          four := 0;
          UnitSourceLine := '';

          // Get the Source names...
          SourceName := GetName(Handle, Names^[SourceIndex]);

          Data.Add(Format(MapSourceLine + #13#10,
            [ChangeFileExt(ExtractFileNameEx(SourceName), ''),
            ExtractFileNameEx(SourceName)]));

          GetMem(Segments, RangeCounts^[SourceIndex] * 4);
          GetMem(SegmentStarts, RangeCounts^[SourceIndex] * 4);
          GetMem(SegmentEnds, RangeCounts^[SourceIndex] * 4);
          GetMem(LineNumberCounts, RangeCounts^[SourceIndex] * 4);
          _BorDebugSrcModuleSourceRanges(Handle, Offset, SourceIndex,
            Segments, SegmentStarts, SegmentEnds, LineNumberCounts);

          // Get the Lines data...
          LastLineNo := 0;
          for RangeIndex := 0 to RangeCounts^[SourceIndex] - 1 do
          begin
            GetMem(LineNumbers, LineNumberCounts^[RangeIndex] * 4);
            GetMem(LineOffsets, LineNumberCounts^[RangeIndex] * 4);

            _BorDebugSrcModuleLineNumbers
              (Handle, Offset, SourceIndex, RangeIndex, LineNumbers, LineOffsets);

            for l := 0 to LineNumberCounts^[RangeIndex] - 1 do
            begin
              LineNo := LineNumbers^[l];
              if (LineNo <> 0) and (LineNo > LastLineNo) then
              begin
                LastLineNo := LineNo;
                UnitSourceLine := UnitSourceLine +
                  SixSpaces(LineNumbers^[l]) + ' 0001:' + IntToHex(LineOffsets^[l], 8);
                inc(four);
                if four = 4 then
                begin
                  Data.Add(UnitSourceLine);
                  four := 0;
                  UnitSourceLine := '';
                end;
              end;
            end;

          if (SourceName <> Seg.Name) then
          begin
            if (Seg.Name <> '') then
            begin
              SegmentsList.Add(
                Format(' 0001:%s %s C=CODE    S=_TEXT    G=(none)   M=%s ACBP=A9',
                [IntToHex(Seg.SegStart, 8), IntToHex((Seg.SegEnd - Seg.SegStart), 8),
                ExtractFileName(Seg.Name)]));
            end;
            Seg.Name := SourceName;
            Seg.SegStart := LineOffsets^[0];
            Seg.SegEnd := LineOffsets^[LineNumberCounts^[RangeIndex] - 1];
          end
          else
          begin
            Seg.SegEnd := LineOffsets^[LineNumberCounts^[RangeIndex] - 1];
          end;

            FreeMem(LineNumbers);
            FreeMem(LineOffsets);
          end;

          FreeMem(Segments);
          FreeMem(SegmentStarts);
          FreeMem(SegmentEnds);
          FreeMem(LineNumberCounts);

          if four > 0 then Data.Add(UnitSourceLine);

          if LastLineNo > 0 then Data.Add('')
          else Data.Delete(Data.Count - 1);
        end;

        FreeMem(SourceOffsets);
        FreeMem(Names);
        FreeMem(RangeCounts);
      end
      else
        if SubsectionType = sstAlignSym then
        begin
          _BorDebugStartSymbols(Handle, SubsectionType, Offset, Size);
          repeat
            _BorDebugNextSymbol(Handle, SymKind, SymOffset, SymLen);
            SymEOF := ((SymKind = 0) and (SymOffset = 0) and (SymLen = 0));
            if (not SymEOF) and (SymKind = st_GProc32) then
            begin
              _BorDebugSymbolGPROC32(Handle, SymOffset, Parent, End_, Next,
                CodeLength, DebugStart, DebugEnd, SOffset, Segment, Flags,
                TypeIndex, NameIndex, BrowserOffset, nil, 0);
              SymName := ExtractProcName(GetName(Handle, NameIndex));
              if SymName <> '' then
                Procedures.Add(' 0001:' + IntToHex(SOffset, 8) + '       ' + SymName);
            end;
          until SymEOF;
        end
        else
          if SubsectionType = sstGlobalSym then
          begin
            _BorDebugStartSymbols(Handle, SubsectionType, Offset, Size);
            repeat
              _BorDebugNextSymbol(Handle, SymKind, SymOffset, SymLen);
              SymEOF := ((SymKind = 0) and (SymOffset = 0) and (SymLen = 0));
              if (not SymEOF) and (SymKind = st_GProfRef) then
              begin
                _BorDebugSymbolGPROCREF(Handle, SymOffset,
                  RefOffset, TypeIndex, NameIndex, BrowserOffset, Segment, SOffset);
                SymName := ExtractProcName(GetName(Handle, NameIndex));
                if SymName <> '' then
                  Procedures.Add(' 0001:' + IntToHex(SOffset, 8) + '       ' + SymName);
              end;
            until SymEOF;
          end;
    end;
  finally
    Data.Text :=  (#13#10 +' Start Length Name Class' + #13#10 +
      ' 0001:00000000 00000000CH _TEXT                  CODE' + #13#10#13#10#13#10 +
      'Detailed map of segments' + #13#10 + SegmentsList.Text + #13#10 +
      MapPublicLine + #13#10#13#10 + Procedures.Text + #13#10 + Data.Text);
    SegmentsList.Free;
    Procedures.Free;
    _BorDebugUnregisterFile(Handle);
  end;
end;

procedure CompleteMapFile(const MapFile: string);
var
  Lines: TStringList;
begin
  Lines := TStringList.Create;
  try
    GetDebugData(ChangeFileExt(MapFile, '.tds'), Lines);
    Lines.SaveToFile(MapFile);
  finally
    Lines.Free;
  end;
end;

{procedure CompleteMapFile(const MapFile: string);
var
  Lines, Map: TStringList;
  idx, i: integer;
begin
  Lines := TStringList.Create;
  Map := TStringList.Create;
  try
    GetDebugData(ChangeFileExt(MapFile, '.tds'), Lines);
    Map.LoadFromFile(MapFile);
    idx := Map.IndexOf(MapSearchedLine0);
    if (idx = -1) then idx := Map.IndexOf(MapSearchedLine1);
    if (idx <> -1) then
    begin
      for i := 0 to idx - 1 do Lines.Insert(i, Map[i]);
      Lines.SaveToFile(MapFile);
    end
    else
      // Check if the Map file is just converted or not...
      if (Map.IndexOf(MapSourceLine) <> -1) then
        raise Exception.CreateFmt('Invalid map file: %s', [MapFile]);
  finally
    Map.Free;
    Lines.Free;
  end;
end; }

function DllFullPath: string;
var
  Buff: array[0..MAX_PATH - 1] of Char;
  Path: string;
  Ver: string;
begin
  Ver := Copy(Real_RADVersionString, 1, Pos('.', Real_RADVersionString) - 1);
  Result := ReadKey(HKEY_CURRENT_USER, 'Software\EurekaLog', 'AppDir');
  if (Result <> '') then  Result := (Result + '\' + DllName)
  else
  begin
    GetModuleFileName(HInstance, Buff, SizeOf(Buff));
    Path := ExtractFilePath(Buff);
    Result := PChar(Path + DllName);
    // Try to found the DLL file into the parent folder...
    if (not FileExists(Result)) then Result := (ExtractFilePath(Path) + DllName);
  end;
end;

procedure Init;
begin
  DllHandle := LoadLibrary(PChar(DllFullPath));
  Assert(DllHandle <> 0, 'Cannot load the "' + DllFullPath + '" library.');
  _BorDebugRegisterFile := GetProcAddress(DllHandle, '_BorDebugRegisterFile');
  _BorDebugUnregisterFile := GetProcAddress(DllHandle, '_BorDebugUnregisterFile');
  _BorDebugSubSectionCount := GetProcAddress(DllHandle, '_BorDebugSubSectionCount');
  _BorDebugSubSection := GetProcAddress(DllHandle, '_BorDebugSubSection');
  _BorDebugSrcModule := GetProcAddress(DllHandle, '_BorDebugSrcModule');
  _BorDebugSrcModuleSources := GetProcAddress(DllHandle, '_BorDebugSrcModuleSources');
  _BorDebugSrcModuleSourceRanges := GetProcAddress(DllHandle, '_BorDebugSrcModuleSourceRanges');
  _BorDebugSrcModuleLineNumbers := GetProcAddress(DllHandle, '_BorDebugSrcModuleLineNumbers');
  _BorDebugNameIndexToName := GetProcAddress(DllHandle, '_BorDebugNameIndexToName');
  _BorDebugStartSymbols := GetProcAddress(DllHandle, '_BorDebugStartSymbols');
  _BorDebugNextSymbol := GetProcAddress(DllHandle, '_BorDebugNextSymbol');
  _BorDebugSymbolGPROC32 := GetProcAddress(DllHandle, '_BorDebugSymbolGPROC32');
  _BorDebugSymbolGPROCREF := GetProcAddress(DllHandle, '_BorDebugSymbolGPROCREF');
end;

procedure Done;
begin
  FreeLibrary(DllHandle);
end;

initialization
  Init;

finalization
  Done;

end.

