unit StreamUtils;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Types, Classes, AsphyreUtils, Vectors2px;

//---------------------------------------------------------------------------
// StreamPutWideString()
//
// Stores a wide string inside the stream. If FixedLength is specified,
// a fixed number of chars is always written. In this case, the string
// cannot be larger than 65535 characters.
//---------------------------------------------------------------------------
procedure StreamPutWideString(Stream: TStream; const Text: WideString;
 FixedLength: Integer = -1);
function StreamGetWideString(Stream: TStream;
 FixedLength: Integer = -1): WideString;

//---------------------------------------------------------------------------
// StreamPutAnsiString()
//
// Stores an ansi string inside the stream. If FixedLength is specified,
// a fixed number of chars is always written. In this case, the string
// cannot be larger than 65535 characters.
//---------------------------------------------------------------------------
procedure StreamPutAnsiString(Stream: TStream; const Text: AnsiString;
 FixedLength: Integer = -1);
function StreamGetAnsiString(Stream: TStream;
 FixedLength: Integer = -1): AnsiString;


//---------------------------------------------------------------------------
// StreamPutByte()
//
// Stores a byte inside the stream. If the value is outside of 0..255 range,
// it will be clamped.
//---------------------------------------------------------------------------
procedure StreamPutByte(Stream: TStream; Value: Cardinal);
function StreamGetByte(Stream: TStream): Cardinal;

//---------------------------------------------------------------------------
// StreamPutWord()
//
// Stores a word inside the stream. If the value is outside of 0..65535 range,
// it will be clamped.
//---------------------------------------------------------------------------
procedure StreamPutWord(Stream: TStream; Value: Cardinal);
function StreamGetWord(Stream: TStream): Cardinal;

//---------------------------------------------------------------------------
// StreamPutLongword()
//
// Stores a longword inside the stream.
//---------------------------------------------------------------------------
procedure StreamPutLongword(Stream: TStream; Value: Cardinal);
function StreamGetLongword(Stream: TStream): Cardinal;

//---------------------------------------------------------------------------
// StreamPutLongint()
//
// Stores a longint inside the stream.
//---------------------------------------------------------------------------
procedure StreamPutLongint(Stream: TStream; Value: Integer);
function StreamGetLongint(Stream: TStream): Integer;

//---------------------------------------------------------------------------
// StreamPutBool()
//
// Stores a boolean value as byte. A value of 255 is equivalent of False,
// while 0 corresponds True.
//---------------------------------------------------------------------------
procedure StreamPutBool(Stream: TStream; Value: Boolean);
function StreamGetBool(Stream: TStream): Boolean;

//---------------------------------------------------------------------------
// StreamPutByteIndex()
//
// Stores an index as byte. A value of -1 (or other negatives) is stored
// as 255. All other values are clamped between 0 and 254.
//---------------------------------------------------------------------------
procedure StreamPutByteIndex(Stream: TStream; Value: Integer);
function StreamGetByteIndex(Stream: TStream): Integer;

//---------------------------------------------------------------------------
// StreamPutWordIndex()
//
// Stores an index as word. A value of -1 (or other negatives) is stored
// as 65535. All other values are clamped between 0 and 65534.
//---------------------------------------------------------------------------
procedure StreamPutWordIndex(Stream: TStream; Value: Integer);
function StreamGetWordIndex(Stream: TStream): Integer;

//---------------------------------------------------------------------------
// StreamPutWordPoint2px()
//
// Stores a 2-dimensional vector as a combination of two words. The maximum
// value for both coordinates is 65534. Higher values will be clamped.
//---------------------------------------------------------------------------
procedure StreamPutWordPoint2px(Stream: TStream; const Vec: TPoint2px);
function StreamGetWordPoint2px(Stream: TStream): TPoint2px;

//---------------------------------------------------------------------------
// StreamPutStrings()
//
// Stores the list of strings with a possibly fixed length.
//---------------------------------------------------------------------------
procedure StreamPutStrings(Stream: TStream; Strings: TStrings;
 FixedLength: Integer = -1);
procedure StreamGetStrings(Stream: TStream; Strings: TStrings;
 FixedLength: Integer = -1);

//---------------------------------------------------------------------------
// StreamPutSingle()
//
// Stores a single floating point value inside the stream.
//---------------------------------------------------------------------------
procedure StreamPutSingle(Stream: TStream; Value: Single);
function StreamGetSingle(Stream: TStream): Single;

//---------------------------------------------------------------------------
// StreamPutDouble()
//
// Stores a double floating point value inside the stream.
//---------------------------------------------------------------------------
procedure StreamPutDouble(Stream: TStream; Value: Double);
function StreamGetDouble(Stream: TStream): Double;

//---------------------------------------------------------------------------
function stReadLongint(Stream: TStream): Longint;
procedure stWriteLongint(Stream: TStream; const Value: Longint);
function stReadLongword(Stream: TStream): Longword;
procedure stWriteLongword(Stream: TStream; const Value: Longword);
function stReadInt64(Stream: TStream): Int64;
procedure stWriteInt64(Stream: TStream; const Value: Int64);
function stReadByte(Stream: TStream): Byte;
procedure stWriteByte(Stream: TStream; const Value: Byte);
function stReadShortInt(Stream: TStream): ShortInt;
procedure stWriteShortInt(Stream: TStream; const Value: ShortInt);
function stReadWord(Stream: TStream): Word;
procedure stWriteWord(Stream: TStream; const Value: Word);
function stReadSmallInt(Stream: TStream): SmallInt;
procedure stWriteSmallInt(Stream: TStream; const Value: SmallInt);
function stReadChar(Stream: TStream): Char;
function stReadSingle(Stream: TStream): Single;
procedure stWriteSingle(Stream: TStream; const Value: Single);
function stReadDouble(Stream: TStream): Double;
procedure stWriteDouble(Stream: TStream; const Value: Double);
procedure stWriteChar(Stream: TStream; const Value: Char);
function stReadBool(Stream: TStream): Boolean;
procedure stWriteBool(Stream: TStream; const Value: Boolean);
function stReadPoint(Stream: TStream): TPoint;
procedure stWritePoint(Stream: TStream; const Value: TPoint);
function stReadString(Stream: TStream): string;
procedure stWriteString(Stream: TStream; const Value: string);
function stReadWideString(Stream: TStream): WideString;
procedure stWriteWideString(Stream: TStream; const Value: WideString);

// Floating-point 3:4 (-8.0 to 7.9375)
procedure stWriteFloat34(Stream: TStream; Value: Single);
function stReadFloat34(Stream: TStream): Single;
//----------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
procedure StreamPutWideString(Stream: TStream; const Text: WideString;
 FixedLength: Integer = -1);
var
 i, LongChars: Longword;
 FixedPlaces, FixedChars, ZeroWord: Word;
begin
 FixedPlaces:= 0;
 if (FixedLength > 0)and(FixedLength < 65536) then FixedPlaces:= FixedLength;

 // -> Fixed Size (2 bytes)
 Stream.WriteBuffer(FixedPlaces, SizeOf(Word));

 if (FixedPlaces = 0) then
  begin // Unlimited size
   LongChars:= Length(Text);

   // -> Text Length (4 bytes)
   Stream.WriteBuffer(LongChars, SizeOf(Longword));

   // -> Characters (Length x 2 bytes)
   for i:= 0 to LongChars - 1 do
    Stream.WriteBuffer(Text[i + 1], SizeOf(Word));
  end else
  begin // Fixed size
   LongChars:= Min2(Length(Text), FixedPlaces);

   ZeroWord  := 0;
   FixedChars:= LongChars;

   // -> Text Length (2 bytes)
   Stream.WriteBuffer(FixedChars, SizeOf(Word));

   // Characters (FixedLength x 2 bytes)
   for i:= 0 to FixedPlaces - 1 do
    if (i < FixedChars) then
     Stream.WriteBuffer(Text[i + 1], SizeOf(Word))
      else Stream.WriteBuffer(ZeroWord, SizeOf(Word));
  end;
end;

//---------------------------------------------------------------------------
function StreamGetWideString(Stream: TStream;
 FixedLength: Integer = -1): WideString;
var
 i, LongChars: Longword;
 FixedPlaces, FixedChars, NullWord: Word;
begin
 // -> Fixed Size (2 bytes)
 Stream.ReadBuffer(FixedPlaces, SizeOf(Word));

 if (FixedLength <> -1) then FixedPlaces:= Min2(FixedPlaces, FixedLength);

 if (FixedPlaces = 0) then
  begin // Unlimited size
   // -> Text Length (4 bytes)
   Stream.ReadBuffer(LongChars, SizeOf(Longword));

   // -> Characters (Length x 2 bytes)
   SetLength(Result, LongChars);
   for i:= 0 to LongChars - 1 do
    Stream.ReadBuffer(Result[i + 1], SizeOf(Word));
  end else
  begin // Fixed size
   // -> Text Length (2 bytes)
   Stream.ReadBuffer(FixedChars, SizeOf(Word));

   // Characters (FixedLength x 2 bytes)
   SetLength(Result, Min2(FixedChars, FixedPlaces));
   for i:= 0 to FixedPlaces - 1 do
    if (i < FixedChars) then
     Stream.ReadBuffer(Result[i + 1], SizeOf(Word))
      else Stream.ReadBuffer(NullWord, SizeOf(Word));
  end;
end;

//---------------------------------------------------------------------------
procedure StreamPutAnsiString(Stream: TStream; const Text: AnsiString;
 FixedLength: Integer = -1);
var
 i, LongChars: Longword;
 FixedPlaces, FixedChars: Word;
 ZeroByte: Byte;
begin
 FixedPlaces:= 0;
 if (FixedLength > 0)and(FixedLength < 65536) then FixedPlaces:= FixedLength;

 // -> Fixed Size (2 bytes)
 Stream.WriteBuffer(FixedPlaces, SizeOf(Word));

 if (FixedPlaces = 0) then
  begin // Unlimited size
   LongChars:= Length(Text);

   // -> Text Length (4 bytes)
   Stream.WriteBuffer(LongChars, SizeOf(Longword));

   // -> Characters (Length bytes)
   for i:= 0 to LongChars - 1 do
    Stream.WriteBuffer(Text[i + 1], SizeOf(Byte));
  end else
  begin // Fixed size
   LongChars:= Min2(Length(Text), FixedPlaces);

   ZeroByte  := 0;
   FixedChars:= LongChars;

   // -> Text Length (2 bytes)
   Stream.WriteBuffer(FixedChars, SizeOf(Word));

   // Characters (FixedLength bytes)
   for i:= 0 to FixedPlaces - 1 do
    if (i < FixedChars) then
     Stream.WriteBuffer(Text[i + 1], SizeOf(Byte))
      else Stream.WriteBuffer(ZeroByte, SizeOf(Byte));
  end;
end;

//---------------------------------------------------------------------------
function StreamGetAnsiString(Stream: TStream;
 FixedLength: Integer = -1): AnsiString;
var
 i, LongChars: Longword;
 FixedPlaces, FixedChars: Word;
 NullByte: Byte;
begin
 // -> Fixed Size (2 bytes)
 Stream.ReadBuffer(FixedPlaces, SizeOf(Word));

 if (FixedLength <> -1) then FixedPlaces:= Min2(FixedPlaces, FixedLength);

 if (FixedPlaces = 0) then
  begin // Unlimited size
   // -> Text Length (4 bytes)
   Stream.ReadBuffer(LongChars, SizeOf(Longword));

   // -> Characters (Length bytes)
   SetLength(Result, LongChars);
   for i:= 0 to LongChars - 1 do
    Stream.ReadBuffer(Result[i + 1], SizeOf(Byte));
  end else
  begin // Fixed size
   // -> Text Length (2 bytes)
   Stream.ReadBuffer(FixedChars, SizeOf(Word));

   // Characters (FixedLength bytes)
   SetLength(Result, Min2(FixedChars, FixedPlaces));
   for i:= 0 to FixedPlaces - 1 do
    if (i < FixedChars) then
     Stream.ReadBuffer(Result[i + 1], SizeOf(Byte))
      else Stream.ReadBuffer(NullByte, SizeOf(Byte));
  end;
end;

//---------------------------------------------------------------------------
procedure StreamPutByte(Stream: TStream; Value: Cardinal);
var
 ByteValue: Byte;
begin
 ByteValue:= Min2(Value, 255);
 Stream.WriteBuffer(ByteValue, SizeOf(Byte));
end;

//---------------------------------------------------------------------------
function StreamGetByte(Stream: TStream): Cardinal;
var
 ByteValue: Byte;
begin
 Stream.ReadBuffer(ByteValue, SizeOf(Byte));
 Result:= ByteValue;
end;

//---------------------------------------------------------------------------
procedure StreamPutWord(Stream: TStream; Value: Cardinal);
var
 WordValue: Word;
begin
 WordValue:= Min2(Value, 65535);
 Stream.WriteBuffer(WordValue, SizeOf(Word));
end;

//---------------------------------------------------------------------------
function StreamGetWord(Stream: TStream): Cardinal;
var
 WordValue: Word;
begin
 Stream.ReadBuffer(WordValue, SizeOf(Word));
 Result:= WordValue;
end;

//---------------------------------------------------------------------------
procedure StreamPutLongword(Stream: TStream; Value: Cardinal);
begin
 Stream.WriteBuffer(Value, SizeOf(Longword));
end;

//---------------------------------------------------------------------------
function StreamGetLongword(Stream: TStream): Cardinal;
begin
 Stream.ReadBuffer(Result, SizeOf(Longword));
end;

//---------------------------------------------------------------------------
procedure StreamPutLongint(Stream: TStream; Value: Integer);
begin
 Stream.WriteBuffer(Value, SizeOf(Longint));
end;

//---------------------------------------------------------------------------
function StreamGetLongint(Stream: TStream): Integer;
begin
 Stream.ReadBuffer(Result, SizeOf(Longint));
end;

//---------------------------------------------------------------------------
procedure StreamPutBool(Stream: TStream; Value: Boolean);
var
 ByteValue: Byte;
begin
 ByteValue:= 255;
 if (Value) then ByteValue:= 0;

 Stream.WriteBuffer(ByteValue, SizeOf(Byte));
end;

//---------------------------------------------------------------------------
function StreamGetBool(Stream: TStream): Boolean;
var
 ByteValue: Byte;
begin
 Stream.ReadBuffer(ByteValue, SizeOf(Byte));
 Result:= ByteValue < 128;
end;

//---------------------------------------------------------------------------
procedure StreamPutByteIndex(Stream: TStream; Value: Integer);
var
 ByteValue: Byte;
begin
 if (Value >= 0) then ByteValue:= Min2(Value, 254)
  else ByteValue:= 255;

 Stream.WriteBuffer(ByteValue, SizeOf(Byte));
end;

//---------------------------------------------------------------------------
function StreamGetByteIndex(Stream: TStream): Integer;
var
 ByteValue: Byte;
begin
 Stream.ReadBuffer(ByteValue, SizeOf(Byte));

 if (ByteValue <> 255) then Result:= ByteValue
  else Result:= -1;
end;

//---------------------------------------------------------------------------
procedure StreamPutWordIndex(Stream: TStream; Value: Integer);
var
 WordValue: Word;
begin
 if (Value >= 0) then WordValue:= Min2(Value, 65534)
  else WordValue:= 65535;

 Stream.WriteBuffer(WordValue, SizeOf(Word));
end;

//---------------------------------------------------------------------------
function StreamGetWordIndex(Stream: TStream): Integer;
var
 WordValue: Word;
begin
 Stream.ReadBuffer(WordValue, SizeOf(Word));

 if (WordValue <> 65535) then Result:= WordValue
  else Result:= -1;
end;

//---------------------------------------------------------------------------
procedure StreamPutWordPoint2px(Stream: TStream; const Vec: TPoint2px);
var
 WordValue: Word;
begin
 if (Vec.x <> Low(Integer)) then WordValue:= MinMax2(Vec.x, 0, 65534)
  else WordValue:= 65535;

 Stream.WriteBuffer(WordValue, SizeOf(Word));

 if (Vec.y <> Low(Integer)) then WordValue:= MinMax2(Vec.y, 0, 65534)
  else WordValue:= 65535;

 Stream.WriteBuffer(WordValue, SizeOf(Word));
end;

//---------------------------------------------------------------------------
function StreamGetWordPoint2px(Stream: TStream): TPoint2px;
var
 WordValue: Word;
begin
 Stream.ReadBuffer(WordValue, SizeOf(Word));

 if (WordValue <> 65535) then Result.x:= WordValue
  else Result.x:= Low(Integer);

 Stream.ReadBuffer(WordValue, SizeOf(Word));

 if (WordValue <> 65535) then Result.y:= WordValue
  else Result.y:= Low(Integer);
end;

//---------------------------------------------------------------------------
procedure StreamPutStrings(Stream: TStream; Strings: TStrings;
 FixedLength: Integer = -1);
var
 i, Count: Integer;
begin
 // -> Number of strings
 Count:= Min2(Strings.Count, 65535);
 StreamPutWord(Stream, Strings.Count);

 // -> Strings x Count
 for i:= 0 to Count - 1 do
  StreamPutAnsiString(Stream, Strings[i], FixedLength);
end;

//---------------------------------------------------------------------------
procedure StreamGetStrings(Stream: TStream; Strings: TStrings;
 FixedLength: Integer = -1);
var
 i, Count: Integer;
begin
 // -> Number of strings
 Count:= StreamGetWord(Stream);

 Strings.Clear();
 Strings.Capacity:= Count;

 // -> Strings x Count
 for i:= 0 to Count - 1 do
  Strings.Add(StreamGetAnsiString(Stream, FixedLength));
end;

//---------------------------------------------------------------------------
procedure StreamPutSingle(Stream: TStream; Value: Single);
begin
 Stream.WriteBuffer(Value, SizeOf(Single));
end;

//---------------------------------------------------------------------------
function StreamGetSingle(Stream: TStream): Single;
begin
 Stream.ReadBuffer(Result, SizeOf(Single));
end;

//---------------------------------------------------------------------------
procedure StreamPutDouble(Stream: TStream; Value: Double);
begin
 Stream.WriteBuffer(Value, SizeOf(Double));
end;

//---------------------------------------------------------------------------
function StreamGetDouble(Stream: TStream): Double;
begin
 Stream.ReadBuffer(Result, SizeOf(Double));
end;






//---------------------------------------------------------------------------
function stReadLongint(Stream: TStream): Longint;
begin
 // read a single integer
 Stream.ReadBuffer(Result, SizeOf(Longint));
end;

//---------------------------------------------------------------------------
procedure stWriteLongint(Stream: TStream; const Value: Longint);
begin
 // write a single integer
 Stream.WriteBuffer(Value, SizeOf(Longint));
end;

//---------------------------------------------------------------------------
function stReadLongword(Stream: TStream): Longword;
begin
 // ReadBuffer a single Longword
 Stream.ReadBuffer(Result, SizeOf(Longword));
end;

//---------------------------------------------------------------------------
procedure stWriteLongword(Stream: TStream; const Value: Longword);
begin
 // WriteBuffer a single Longword
 Stream.WriteBuffer(Value, SizeOf(Longword));
end;

//---------------------------------------------------------------------------
function stReadInt64(Stream: TStream): Int64;
begin
 // ReadBuffer a single 64-bit integer
 Stream.ReadBuffer(Result, SizeOf(Int64));
end;

//---------------------------------------------------------------------------
procedure stWriteInt64(Stream: TStream; const Value: Int64);
begin
 // WriteBuffer a single 64-bit integer
 Stream.WriteBuffer(Value, SizeOf(Int64));
end;

//---------------------------------------------------------------------------
function stReadChar(Stream: TStream): Char;
begin
 // ReadBuffer a single character
 Stream.ReadBuffer(Result, SizeOf(Char));
end;

//---------------------------------------------------------------------------
procedure stWriteChar(Stream: TStream; const Value: Char);
begin
 // WriteBuffer a single character
 Stream.WriteBuffer(Value, SizeOf(Char));
end;

//---------------------------------------------------------------------------
function stReadByte(Stream: TStream): Byte;
begin
 // ReadBuffer a single character
 Stream.ReadBuffer(Result, SizeOf(Byte));
end;

//---------------------------------------------------------------------------
procedure stWriteByte(Stream: TStream; const Value: Byte);
begin
 // WriteBuffer a single character
 Stream.WriteBuffer(Value, SizeOf(Byte));
end;

//---------------------------------------------------------------------------
function stReadShortInt(Stream: TStream): ShortInt;
begin
 // ReadBuffer a single character
 Stream.ReadBuffer(Result, SizeOf(ShortInt));
end;

//---------------------------------------------------------------------------
procedure stWriteShortInt(Stream: TStream; const Value: ShortInt);
begin
 // WriteBuffer a single character
 Stream.WriteBuffer(Value, SizeOf(ShortInt));
end;

//---------------------------------------------------------------------------
function stReadWord(Stream: TStream): Word;
begin
 // ReadBuffer a single character
 Stream.ReadBuffer(Result, SizeOf(Word));
end;

//---------------------------------------------------------------------------
procedure stWriteWord(Stream: TStream; const Value: Word);
begin
 // WriteBuffer a single character
 Stream.WriteBuffer(Value, SizeOf(Word));
end;

//---------------------------------------------------------------------------
function stReadSmallInt(Stream: TStream): SmallInt;
begin
 Stream.ReadBuffer(Result, SizeOf(Word));
end;

//---------------------------------------------------------------------------
procedure stWriteSmallInt(Stream: TStream; const Value: SmallInt);
begin
 Stream.WriteBuffer(Value, SizeOf(SmallInt));
end;

//---------------------------------------------------------------------------
function stReadDouble(Stream: TStream): Double;
begin
 // ReadBuffer a single character
 Stream.ReadBuffer(Result, SizeOf(Double));
end;

//---------------------------------------------------------------------------
procedure stWriteDouble(Stream: TStream; const Value: Double);
begin
 // WriteBuffer a single character
 Stream.WriteBuffer(Value, SizeOf(Double));
end;

//---------------------------------------------------------------------------
function stReadSingle(Stream: TStream): Single;
begin
 // ReadBuffer a single character
 Stream.ReadBuffer(Result, SizeOf(Single));
end;

//---------------------------------------------------------------------------
procedure stWriteSingle(Stream: TStream; const Value: Single);
begin
 // WriteBuffer a single character
 Stream.WriteBuffer(Value, SizeOf(Single));
end;

//---------------------------------------------------------------------------
function stReadBool(Stream: TStream): Boolean;
begin
 Stream.ReadBuffer(Result, SizeOf(Boolean));
end;

//---------------------------------------------------------------------------
procedure stWriteBool(Stream: TStream; const Value: Boolean);
begin
 Stream.WriteBuffer(Value, SizeOf(Boolean));
end;

//---------------------------------------------------------------------------
function stReadPoint(Stream: TStream): TPoint;
begin
 Stream.ReadBuffer(Result, SizeOf(TPoint));
end;

//---------------------------------------------------------------------------
procedure stWritePoint(Stream: TStream; const Value: TPoint);
begin
 Stream.WriteBuffer(Value, SizeOf(TPoint));
end;

//---------------------------------------------------------------------------
function stReadString(Stream: TStream): string;
var
 Count, i: Integer;
begin
 // ReadBuffer string length
 Count:= stReadLongint(Stream);

 // define result length
 SetLength(Result, Count);

 // ReadBuffer char by char
 for i:= 0 to Count - 1 do
  Result[i + 1]:= stReadChar(Stream);
end;

//---------------------------------------------------------------------------
procedure stWriteString(Stream: TStream; const Value: string);
var
 i: Integer;
begin
 // WriteBuffer string length
 stWriteLongint(Stream, Length(Value));

 // WriteBuffer char by char
 for i:= 0 to Length(Value) - 1 do
  stWriteChar(Stream, Value[i + 1]);
end;

//----------------------------------------------------------------------------
procedure stWriteWideString(Stream: TStream; const Value: WideString);
var
 i: Integer;
begin
 stWriteLongint(Stream, Length(Value));

 for i:= 0 to Length(Value) - 1 do
  stWriteWord(Stream, Word(Value[i + 1]));
end;

//----------------------------------------------------------------------------
function stReadWideString(Stream: TStream): WideString;
var
 Count, i: Integer;
begin
 Count:= stReadLongint(Stream);

 SetLength(Result, Count);

 for i:= 0 to Count - 1 do
  Result[i + 1]:= WideChar(stReadWord(Stream));
end;

//----------------------------------------------------------------------------
procedure stWriteFloat34(Stream: TStream; Value: Single);
var
 Aux: Integer;
begin
 Aux:= Round(Value * 16.0);
 if (Aux > 127) then Aux:= 127;
 if (Aux < -128) then Aux:= -128;

 stWriteShortInt(Stream, Aux);
end;

//----------------------------------------------------------------------------
function stReadFloat34(Stream: TStream): Single;
begin
 Result:= stReadShortInt(Stream) / 16.0;
end;

//----------------------------------------------------------------------------
end.
