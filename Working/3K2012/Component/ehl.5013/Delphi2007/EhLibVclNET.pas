{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{             Specific routines for VLC.Net             }
{                      Build 5.0.00                     }
{                                                       }
{    Copyright (c) 2004-08 by Dmitry V. Bolshakov       }
{                                                       }
{*******************************************************}

unit EhLibVclNET platform;

interface

//{$WARNINGS OFF}

uses
  Windows, Forms, SysUtils, Classes, DB, TypInfo, Controls, Graphics, Messages,
  Variants;

type
  TUniBookmarkEh = TBookmarkStr;
  
const
  NilBookmarkEh = '';

function CharInSetEh(C: Char; const CharSet: TSysCharSet): Boolean;

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TBookmarkStr): Integer;
function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TBookmarkStr): Boolean;

function GetMasterDataSet(FDataSet: TDataSet; APropInfo: PPropInfo): TDataSet;

function DrawTextEh(hDC: HDC; Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer;
function WindowsDrawTextEx(DC: HDC; lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer; overload;
function WindowsDrawTextEx(DC: HDC; lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;

function WindowsExtTextOut(DC: HDC; X, Y: Integer; Options: Longint;
  var Rect: TRect; Str: String; Count: Longint{; Dx: PInteger}): BOOL;

function WindowsGetOutlineTextMetrics(DC: HDC; p2: UINT; var OTMetricStructs: TOutlineTextMetric): UINT;

function SendStructlParamMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: TObject; Dummy: Integer): LRESULT;

function SystemParametersInfoEh(uiAction, uiParam: UINT; var pvParam: TRect; fWinIni: UINT): BOOL;
function WindowsInvalidateRect(hWnd: HWND; var Rect: TRect; bErase: BOOL): BOOL;
function WindowsValidateRect(hWnd: HWND; var Rect: TRect): BOOL;
function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; {prcUpdate: TRect; }flags: UINT): BOOL;
function WindowsScrollWindow(hWnd: HWND; dx, dy: Integer; var prcScroll, prcClip: TRect): BOOL;

function WindowsLPtoDP(DC: HDC; var ARect: TRect): BOOL;
function WindowsCreatePolygonRgn(Points: array of TPoint; Count, FillMode: Integer): HRGN;
// WindowsSetStdCursor

function IsObjectAndIntegerRefSame(AObject: TObject; IntRef: Integer): Boolean;
function IntPtrToObject(AIntPtr: Integer): TObject;
function ObjectToIntPtr(AObject: TObject): Integer;
function IntPtrToString(AIntPtr: Integer): String;

procedure VarToMessage(var VarMessage; var Message: TMessage);
function MessageToTMessage(var Message): TMessage;
function MessageToTWMMouse(var Message): TWMMouse;
function MessageToTWMKey(var Message): TWMKey;
function UnwrapMessageEh(var Message): TMessage;

function SmallPointToInteger(SmallPoint: TSmallPoint): Integer;
function LongintToSmallPoint(Value: Longint): TSmallPoint;

procedure MessageSendGetSel(hWnd: HWND; var SelStart, SelEnd: Integer);

function NlsUpperCase(const S: String): String;
function NlsLowerCase(const S: String): String;
function NlsCompareStr(const S1, S2: String): Integer;
function NlsCompareText(const S1, S2: String): Integer;

procedure BitmapLoadFromResourceName(Bmp: TBitmap; Instance: THandle; const ResName: String);
function LoadBitmapEh(hInstance: HINST; lpBitmapID: Integer): HBITMAP;

//procedure Clipboard_SetBuffer(AClipboard: TClipboard; Format: Word; Buffer: TBytes; Size: Integer);

type
  TPropListArray = TPropList;

function GetPropListAsArray(ATypeInfo: TTypeInfo; TypeKinds: TTypeKinds): TPropList;

function HexToBinEh(Text: String; Buffer: array of Byte; Count: Integer): Integer;
procedure BinToHexEh(Buffer: array of Byte; Text: String; Count: Integer);

procedure StreamWriteBytes(Stream: TStream; Buffer: TBytes);
procedure StreamReadBytes(Stream: TStream; Buffer: TBytes; Count: Integer);

function PropInfo_getPropType(APropInfo: PPropInfo): PTypeInfo;
function PropInfo_getName(APropInfo: PPropInfo): String;
function PropType_GetKind(APropType: PTypeInfo): TTypeKind;

procedure VarArrayRedimEh(var A : Variant; HighBound: Integer);
function LongMulDiv(Mult1, Mult2, Div1: Longint): Longint;

function VariantToRefObject(Value: Variant): TObject;
function RefObjectToVariant(Value: TObject): Variant;
procedure DataVarCastAsObject(var Dest: Variant; const Source: Variant);

{ TMemoryStreamEh }

type

  TMemoryStreamEh = class(TMemoryStream)
  private
    FHalfMemoryDelta: Integer;
  protected
    function Realloc(var NewCapacity: Longint): TBytes; override;
  public
    constructor Create;
    property HalfMemoryDelta: Integer read FHalfMemoryDelta write FHalfMemoryDelta;
  end;

function ExplicitLongwordToLongInt(v: Longword): LongInt;

implementation

uses
  System.Runtime.InteropServices, System.Reflection;

function CharInSetEh(C: Char; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;

function IsObjectAndIntegerRefSame(AObject: TObject; IntRef: Integer): Boolean;
begin
  Result := (Integer(AObject) = IntRef);
end;

function IntPtrToObject(AIntPtr: Integer): TObject;
begin
  Result := GCHandle(IntPtr(AIntPtr)).Target;
end;

function ObjectToIntPtr(AObject: TObject): Integer;
begin
  Result := IntPtr(GCHandle.Alloc(AObject, GCHandleType.Weak)).ToInt32;
end;

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TBookmarkStr): Integer;
var
  I1, I2: IntPtr;
begin
  try
    I1 := Marshal.StringToHGlobalAnsi(Bookmark1);
    I2 := Marshal.StringToHGlobalAnsi(Bookmark1);
    Result := DataSet.CompareBookmarks(TBookmark(I1), TBookmark(I2));
  finally
    Marshal.FreeHGlobal(I1);
    if Assigned(I2) then
      Marshal.FreeHGlobal(I2);
  end;
end;

function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TBookmarkStr): Boolean;
var
  I1: IntPtr;
begin
  try
    I1 := Marshal.StringToHGlobalAnsi(Bookmark);
    Result := DataSet.BookmarkValid(TBookmark(I1));
  finally
    Marshal.FreeHGlobal(I1);
  end;
end;

function GetMasterDataSet(FDataSet: TDataSet; APropInfo: PPropInfo): TDataSet;
var PropValue: TDataSource;
begin
  Result := nil;
  PropValue := nil;
 { DONE : To do }
  if (APropInfo <> nil) then
  begin
    if PropType_GetKind(PropInfo_getPropType(APropInfo)) = tkClass then
    try
      PropValue := (TObject(GetObjectProp(FDataSet, APropInfo)) as TDataSource);
    except // if PropInfo is not TDataSource or not inherited of
    end;
  end;
  if (PropValue <> nil)
    then Result := PropValue.DataSet;
end;

function DrawTextEh(hDC: HDC; Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer;
begin
  Result := DrawText(hDC, Text, nCount, lpRect, uFormat);
end;

function WindowsDrawTextEx(DC: HDC; lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer;
begin
  Result := DrawTextEx(DC, lpchText, cchText, p4, dwDTFormat, DTParams);
end;

function WindowsDrawTextEx(DC: HDC; lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer;
begin
  Result := DrawTextEx(DC, lpchText, cchText, p4, dwDTFormat, nil);
end;

function WindowsExtTextOut(DC: HDC; X, Y: Integer; Options: Longint;
  var Rect: TRect; Str: String; Count: Longint{; Dx: PInteger}): BOOL;
begin
  Result := ExtTextOut(DC, X, Y, Options,
    Rect, Str, Count, nil);
end;

function WindowsGetOutlineTextMetrics(DC: HDC; p2: UINT; var OTMetricStructs: TOutlineTextMetric): UINT;
var
  OTMetricStructsArr: array of TOutlineTextMetric;
begin
  SetLength(OTMetricStructsArr, 1);
  OTMetricStructsArr[0] := OTMetricStructs;
  Result := GetOutlineTextMetrics(DC, p2, OTMetricStructsArr);
end;

function SendStructlParamMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM;
  lParam: TObject; Dummy: Integer): LRESULT;
var
  Mem: IntPtr;
begin
  Mem := Marshal.AllocHGlobal(Marshal.SizeOf(lParam));
  try
    Marshal.StructureToPtr(TObject(lParam), Mem, False);
    Result := SendMessage(hWnd, Msg, wParam, LongInt(Mem));
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;

function SystemParametersInfoEh(uiAction, uiParam: UINT; var pvParam: TRect; fWinIni: UINT): BOOL;
begin
  { DONE : To do }
  Result := SystemParametersInfo(uiAction, uiParam, pvParam, fWinIni);
  Result := False;
end;

function WindowsInvalidateRect(hWnd: HWND; var Rect: TRect; bErase: BOOL): BOOL;
begin
  Result := InvalidateRect(hWnd, Rect, bErase);
end;

function WindowsValidateRect(hWnd: HWND; var Rect: TRect): BOOL;
begin
  Result := ValidateRect(hWnd, Rect);
end;

function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; {prcUpdate: TRect; }flags: UINT): BOOL;
begin
  Result := ScrollWindowEx(hWnd, dx, dy, prcScroll, prcClip,
    hrgnUpdate, nil, flags);
end;

function WindowsScrollWindow(hWnd: HWND; dx, dy: Integer; var prcScroll, prcClip: TRect): BOOL;
begin
  Result := ScrollWindow(hWnd, dx, dy, prcScroll, prcClip);
end;

procedure VarToMessage(var VarMessage; var Message: TMessage);
begin
  Message := UnwrapMessage(TObject(VarMessage));
end;

function MessageToTMessage(var Message): TMessage;
begin
  Result := TMessage(Message);
end;

function MessageToTWMMouse(var Message): TWMMouse;
begin
  Result := TWMMouse(Message);
end;

function MessageToTWMKey(var Message): TWMKey;
begin
  Result := TWMKey(Message);
end;

function UnwrapMessageEh(var Message): TMessage;
begin
  Result := UnwrapMessage(TObject(Message));
end;

function SmallPointToInteger(SmallPoint: TSmallPoint): Integer;
begin
  Result := MakeLong(SmallPoint.X, SmallPoint.Y);
end;

function LongintToSmallPoint(Value: Longint): TSmallPoint;
begin
  Result := TSmallPoint.Create(Value);
end;

function WindowsLPtoDP(DC: HDC; var ARect: TRect): BOOL;
var
  Points: array of TPoint;
begin
  SetLength(Points, 2);
  Points[0] := ARect.TopLeft;
  Points[1] := ARect.BottomRight;
  Result := LPtoDP(DC, Points, 2);
  ARect.TopLeft := Points[0];
  ARect.BottomRight := Points[1];
end;

function WindowsCreatePolygonRgn(Points: array of TPoint; Count, FillMode: Integer): HRGN;
begin
  Result := CreatePolygonRgn(Points, Count, FillMode);
end;

procedure MessageSendGetSel(hWnd: HWND; var SelStart, SelEnd: Integer);
var
  MemStart, MemEnd: IntPtr;
begin
  MemStart := Marshal.AllocHGlobal(SizeOf(Longint));
  try
    MemEnd := Marshal.AllocHGlobal(SizeOf(Longint));
    try
      SendMessage(hWnd, EM_GETSEL, Longint(MemStart), Longint(MemEnd));
      SelStart := Marshal.ReadInt32(MemStart);
      SelEnd := Marshal.ReadInt32(MemEnd);
    finally
      Marshal.FreeHGlobal(MemEnd);
    end;
  finally
    Marshal.FreeHGlobal(MemStart);
  end;
end;

function NlsUpperCase(const S: String): String;
begin
  Result := UpperCase(S);
end;

function NlsLowerCase(const S: String): String;
begin
  Result := LowerCase(S);
end;

function NlsCompareStr(const S1, S2: String): Integer;
begin
  Result := CompareStr(S1, S2);
end;

function NlsCompareText(const S1, S2: String): Integer;
begin
  Result := CompareText(S1, S2);
end;

procedure BitmapLoadFromResourceName(Bmp: TBitmap; Instance: THandle; const ResName: String);
begin
  Bmp.LoadFromResourceName(Instance, ResName);
end;

function GetPropListAsArray(ATypeInfo: TTypeInfo; TypeKinds: TTypeKinds): TPropList;
begin
  Result := GetPropList(ATypeInfo, TypeKinds);
end;

function HexToBinEh(Text: String; Buffer: array of Byte; Count: Integer): Integer;
var
  ByteText: array of Byte;
begin
  ByteText := BytesOf(Text);
  SetLength(ByteText, Count div 2);
  Result := HexToBin(ByteText, 0, Buffer, 0, Length(Buffer));
end;

procedure BinToHexEh(Buffer: array of Byte; Text: String; Count: Integer);
var
  ByteText: array of Byte;
begin
  SetLength(ByteText, Count * 2);
  BinToHex(Buffer, 0, ByteText, 0, Length(Buffer));
  Text := StringOf(ByteText);
end;

procedure StreamWriteBytes(Stream: TStream; Buffer: array of Byte);
begin
  Stream.Write(Buffer, Length(Buffer));
end;

procedure StreamReadBytes(Stream: TStream; Buffer: TBytes; Count: Integer);
begin
  SetLength(Buffer, Count);
  Stream.Read(Buffer, 0, Count);
end;

function LoadBitmapEh(hInstance: HINST; lpBitmapID: Integer): HBITMAP;
begin
  Result := LoadBitmap(hInstance, lpBitmapID);
end;

function PropInfo_getPropType(APropInfo: PPropInfo): PTypeInfo;
begin
  Result := APropInfo.PropType;
end;

function PropInfo_getName(APropInfo: PPropInfo): String;
begin
  Result := APropInfo.Name;
end;

function PropType_GetKind(APropType: PTypeInfo): TTypeKind;
begin
  Result := APropType.Kind;
end;

function IntPtrToString(AIntPtr: Integer): String;
begin
  Result := Marshal.PtrToStringAnsi(IntPtr(AIntPtr));
end;

procedure VarArrayRedimEh(var A : Variant; HighBound: Integer);
var
  NewAr: Variant;
  i, hb: Integer;
begin
  NewAr := VarArrayCreate([0, HighBound], varVariant);
  if VarArrayHighBound(A, 1) < VarArrayHighBound(NewAr, 1)
    then hb := VarArrayHighBound(A, 1)
    else hb := VarArrayHighBound(NewAr, 1);
  for i := 0 to hb do
    NewAr[i] := A[i];
  A := NewAr;
end;

function LongMulDiv(Mult1, Mult2, Div1: Longint): Longint;
begin
  Result := MulDiv(Mult1, Mult2, Div1);
end;

{ TMemoryStream }

constructor TMemoryStreamEh.Create;
begin
  inherited Create;
  HalfMemoryDelta := $1000;
end;

function TMemoryStreamEh.Realloc(var NewCapacity: Integer): TBytes;
var
  MemoryDelta: Integer;
begin
  MemoryDelta := HalfMemoryDelta * 2;
  if (NewCapacity > 0) and (NewCapacity <> Size) then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := FMemory;
  if NewCapacity <> Length(Result) then
    SetLength(Result, NewCapacity);
end;

procedure DataVarCast(var Dest: Variant; const Source: Variant; AVarType: Integer);
//function DataVarCast(const Source: Variant; AVarType: Integer): Variant;
begin
  if VarIsNull(Source) then
    Dest := Null
  else if AVarType = varVariant then
    Dest := Source
  else
    VarCast(Dest, Source, AVarType);
end;

function VariantToRefObject(Value: Variant): TObject;
begin
  Result := TObject(Value);
end;

function RefObjectToVariant(Value: TObject): Variant;
begin
  Result := Variant(Value);
end;

procedure DataVarCastAsObject(var Dest: Variant; const Source: Variant);
begin
  DataVarCast(Dest, Source, varVariant);
end;

{$RANGECHECKS OFF}
// Here and below all routins work without rangecheck

function ExplicitLongwordToLongInt(v: Longword): LongInt;
begin
  Result := LongInt(v);
end;

end.
