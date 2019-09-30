{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{            Specific routines for VCL.Win32            }
{                      Build 5.0.00                     }
{                                                       }
{     Copyright (c) 2004-08 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit EhLibVCL;

interface

{$WARNINGS OFF}

uses
  Windows, Forms, SysUtils, Classes, DB, TypInfo, Controls, Graphics,
{$IFDEF EH_LIB_6}
  RTLConsts, Variants,
{$ELSE}
  Consts,
{$ENDIF}
  Messages;

type
  TCMParentFontChanged = TMessage;
  IntPtr = Pointer;
{$IFDEF EH_LIB_12}
  TUniBookmarkEh = TBookmark;
{$ELSE}
  TBytes = array of Byte;
  TUniBookmarkEh = TBookmarkStr;
{$ENDIF}

const
{$IFDEF EH_LIB_12}
  NilBookmarkEh = nil;
{$ELSE}
  NilBookmarkEh = '';
{$ENDIF}

function CharInSetEh(C: Char; const CharSet: TSysCharSet): Boolean;
function VarToAnsiStr(const V: Variant): AnsiString;

procedure FillDWord(var Dest; Count, Value: Integer);
function StackAlloc(Size: Integer): Pointer;
procedure StackFree(P: Pointer);

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TUniBookmarkEh): Integer;
function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TUniBookmarkEh): Boolean;

function GetMasterDataSet(FDataSet: TDataSet; APropInfo: PPropInfo): TDataSet;

function DrawTextEh(hDC: HDC; Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer;
function WindowsDrawTextEx(DC: HDC; lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer; overload;
function WindowsDrawTextEx(DC: HDC; lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;

{function DrawTextEh(hDC: HDC; Text: WideString; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer; overload;
function WindowsDrawTextEx(DC: HDC; lpchText: WideString; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer; overload;
function WindowsDrawTextEx(DC: HDC; lpchText: WideString; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;
}  

function WindowsExtTextOut(DC: HDC; X, Y: Integer; Options: Longint;
  var Rect: TRect; Str: String; Count: Longint{; Dx: PInteger}): BOOL;

function WindowsGetOutlineTextMetrics(DC: HDC; p2: UINT; var OTMetricStructs: TOutlineTextMetric): UINT;

//function SendStructlParamMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
function SendStructMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
function SendTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: string): LRESULT;
function SendGetTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam: string; BufferSize: Integer): LRESULT;

function SystemParametersInfoEh(uiAction, uiParam: UINT; var pvParam; fWinIni: UINT): BOOL;
function WindowsInvalidateRect(hWnd: HWND; var Rect: TRect; bErase: BOOL): BOOL;
function WindowsValidateRect(hWnd: HWND; var Rect: TRect): BOOL;
function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; {prcUpdate: TRect; }flags: UINT): BOOL;
function WindowsScrollWindow(hWnd: HWND; dx, dy: Integer; var prcScroll, prcClip: TRect): BOOL;
function FindWindowEh(lpClassName, lpWindowName: String): HWND;

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

function WideStringCompare(ws1, ws2: WideString; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
function AnsiStringCompare(s1, s2: String; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;

procedure BitmapLoadFromResourceName(Bmp: TBitmap; Instance: THandle; const ResName: String);
function LoadBitmapEh(hInstance: HINST; lpBitmapID: Integer): HBITMAP;

//procedure Clipboard_SetBuffer(AClipboard: TClipboard; Format: Word; Buffer: TBytes; Size: Integer);

type
  TPropListArray = array of PPropInfo;

function GetPropListAsArray(ATypeInfo: PTypeInfo; TypeKinds: TTypeKinds): TPropListArray;

function HexToBinEh(Text: Pointer; var Buffer: TBytes; Count: Integer): Integer;
procedure BinToHexEh(Buffer: TBytes; var Text: String; Count: Integer);

procedure StreamWriteBytes(Stream: TStream; Buffer: TBytes);
procedure StreamReadBytes(Stream: TStream; var Buffer: TBytes; Count: Integer);

function BytesOf(S: String): TBytes;

function PropInfo_getPropType(APropInfo: PPropInfo): PTypeInfo;
function PropInfo_getName(APropInfo: PPropInfo): String;
function PropType_getKind(APropType: PTypeInfo): TTypeKind;

procedure VarArrayRedimEh(var A : Variant; HighBound: Integer);

{$IFNDEF EH_LIB_5}

function GetObjectProp(Instance: TObject; PropInfo: PPropInfo): TObject;
function GetObjectPropClass(Instance: TObject; PropInfo: PPropInfo): TClass;
procedure SetObjectProp(Instance: TObject; PropInfo: PPropInfo; Value: TObject);

{$ENDIF}

function GetUltimateOwner(APersistent: TPersistent): TPersistent;

function LongMulDiv(Mult1, Mult2, Div1: Longint): Longint; stdcall;
function EmptyRect: TRect;

function VariantToRefObject(Value: Variant): TObject;
function RefObjectToVariant(Value: TObject): Variant;
procedure DataVarCastAsObject(var Dest: Variant; const Source: Variant);

type

{ TFilerAccess }

  TFilerAccess = class(TInterfacedObject) // Same as TFilerAccess in D8.
  private
    FPersistent: TPersistent;
  public
    constructor Create(APersistent: TPersistent);
    procedure DefineProperties(AFiler: TFiler);
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent);
    function GetChildOwner: TComponent;
    function GetChildParent: TComponent;
    procedure SetAncestor(Value: Boolean);
    procedure SetChildOrder(Child: TComponent; Order: Integer);
    procedure Updated;
    procedure Updating;
  end;

{ TMemoryStreamEh }

  TMemoryStreamEh = class(TMemoryStream)
  private
    FHalfMemoryDelta: Integer;
  protected
    function Realloc(var NewCapacity: Longint): Pointer; override;
  public
    constructor Create;
    property HalfMemoryDelta: Integer read FHalfMemoryDelta write FHalfMemoryDelta;
  end;

{$IFNDEF EH_LIB_6}

type
  IInterface = IUnknown;

  IInterfaceComponentReference = interface
    ['{E28B1858-EC86-4559-8FCD-6B4F824151ED}']
    function GetComponent: TComponent;
  end;

  TDragObjectEx = class(TDragObject)
  public
    procedure BeforeDestruction; override;
  end;

{$IFDEF EH_LIB_7}
{$ELSE}
  TSetLayeredWindowAttributes = function (Hwnd: THandle; crKey: COLORREF; bAlpha: Byte; dwFlags: DWORD): Boolean; stdcall;

const
  {$EXTERNALSYM WS_EX_LAYERED}
  WS_EX_LAYERED = $00080000;
{$EXTERNALSYM LWA_ALPHA}
  LWA_ALPHA = $00000002;
{$EXTERNALSYM LWA_COLORKEY}
  LWA_COLORKEY = $00000001;

  clSkyBlue = TColor($F0CAA6);
  
var
  SetLayeredWindowAttributes: TSetLayeredWindowAttributes = nil;

function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;

{$ENDIF}

{$IFDEF EH_LIB_7}
{$ELSE}
const
//Delphi 5 or 6
  {$EXTERNALSYM CS_DROPSHADOW}
  CS_DROPSHADOW = $20000;
{$ENDIF}

const
  sLineBreak = {$IFDEF LINUX} #10 {$ELSE} #13#10 {$ENDIF};

function VarToWideStr(const V: Variant): WideString;
  
{$ENDIF}

function ExplicitLongwordToLongInt(v: Longword): LongInt;
function WStrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;

implementation

{$IFDEF EH_LIB_6}
{$ELSE}
//Delphi 5
function CheckWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
begin
  Result := (AMajor > Win32MajorVersion) or
            ((AMajor = Win32MajorVersion) and
             (AMinor >= Win32MinorVersion));
end;
{$ENDIF}

function LongMulDiv(Mult1, Mult2, Div1: Longint): Longint; stdcall;
{$IFDEF LINUX}
  external 'libwine.borland.so' name 'MulDiv';
{$ELSE}
  external 'kernel32.dll' name 'MulDiv';
{$ENDIF}

function CharInSetEh(C: Char; const CharSet: TSysCharSet): Boolean;
begin
{$IFDEF EH_LIB_12}
  Result := CharInSet(C, CharSet);
{$ELSE}
  Result := C in CharSet;
{$ENDIF}
end;

function VarToAnsiStr(const V: Variant): AnsiString;
begin
  if not VarIsNull(V)
    then Result := V
    else Result := '';
end;

function WideStringCompare(ws1, ws2: WideString; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
var
  dwCmpFlags: LongWord;
  cchCount: Integer;
begin
  if CaseInsensitive
    then dwCmpFlags := NORM_IGNORECASE
    else dwCmpFlags := 0;

  if CharCount = 0
    then cchCount := -1
    else cchCount := CharCount;

  Result := CompareStringW(LOCALE_USER_DEFAULT, dwCmpFlags, PWideChar(ws1),
      cchCount, PWideChar(ws2), cchCount) - 2;
end;

function AnsiStringCompare(s1, s2: String; CharCount: Integer = 0; CaseInsensitive: Boolean = False): Integer;
var
  dwCmpFlags: LongWord;
  cchCount: Integer;
begin
  if CaseInsensitive
    then dwCmpFlags := NORM_IGNORECASE
    else dwCmpFlags := 0;

  if CharCount = 0
    then cchCount := -1
    else cchCount := CharCount;

  Result := CompareString(LOCALE_USER_DEFAULT, dwCmpFlags, PChar(s1),
      cchCount, PChar(s2), cchCount) - 2;
end;

function IsObjectAndIntegerRefSame(AObject: TObject; IntRef: Integer): Boolean;
begin
  Result := (Integer(AObject) = IntRef);
end;

function IntPtrToObject(AIntPtr: Integer): TObject;
begin
  Result := TObject(AIntPtr);
end;

function ObjectToIntPtr(AObject: TObject): Integer;
begin
  Result := Integer(AObject);
end;

function IntPtrToString(AIntPtr: Integer): String;
begin
  Result := String(PChar(AIntPtr));
end;

procedure FillDWord(var Dest; Count, Value: Integer); register;
asm
  XCHG  EDX, ECX
  PUSH  EDI
  MOV   EDI, EAX
  MOV   EAX, EDX
  REP   STOSD
  POP   EDI
end;

{ StackAlloc allocates a 'small' block of memory from the stack by
  decrementing SP.  This provides the allocation speed of a local variable,
  but the runtime size flexibility of heap allocated memory.  }
function StackAlloc(Size: Integer): Pointer; register;
asm
  POP   ECX          { return address }
  MOV   EDX, ESP
  ADD   EAX, 3
  AND   EAX, not 3   // round up to keep ESP dword aligned
  CMP   EAX, 4092
  JLE   @@2
@@1:
  SUB   ESP, 4092
  PUSH  EAX          { make sure we touch guard page, to grow stack }
  SUB   EAX, 4096
  JNS   @@1
  ADD   EAX, 4096
@@2:
  SUB   ESP, EAX
  MOV   EAX, ESP     { function result = low memory address of block }
  PUSH  EDX          { save original SP, for cleanup }
  MOV   EDX, ESP
  SUB   EDX, 4
  PUSH  EDX          { save current SP, for sanity check  (sp = [sp]) }
  PUSH  ECX          { return to caller }
end;

{ StackFree pops the memory allocated by StackAlloc off the stack.
- Calling StackFree is optional - SP will be restored when the calling routine
  exits, but it's a good idea to free the stack allocated memory ASAP anyway.
- StackFree must be called in the same stack context as StackAlloc - not in
  a subroutine or finally block.
- Multiple StackFree calls must occur in reverse order of their corresponding
  StackAlloc calls.
- Built-in sanity checks guarantee that an improper call to StackFree will not
  corrupt the stack. Worst case is that the stack block is not released until
  the calling routine exits. }
procedure StackFree(P: Pointer); register;
asm
  POP   ECX                     { return address }
  MOV   EDX, DWORD PTR [ESP]
  SUB   EAX, 8
  CMP   EDX, ESP                { sanity check #1 (SP = [SP]) }
  JNE   @@1
  CMP   EDX, EAX                { sanity check #2 (P = this stack block) }
  JNE   @@1
  MOV   ESP, DWORD PTR [ESP+4]  { restore previous SP  }
@@1:
  PUSH  ECX                     { return to caller }
end;

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TUniBookmarkEh): Integer;
begin
  Result := DataSet.CompareBookmarks(TBookmark(Bookmark1), TBookmark(Bookmark2));
end;

function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TUniBookmarkEh): Boolean;
begin
  Result := DataSet.BookmarkValid(TBookmark(Bookmark));
end;

function GetMasterDataSet(FDataSet: TDataSet; APropInfo: PPropInfo): TDataSet;
var PropValue: TDataSource;
begin
  Result := nil;
  PropValue := nil;
  if (APropInfo <> nil) then
  begin
    if APropInfo^.PropType^.Kind = tkClass then
    try
      PropValue := (TObject(GetOrdProp(FDataSet, APropInfo)) as TDataSource);
    except // if PropInfo is not TDataSource or not inherited of
    end;
  end;
  if (PropValue <> nil)
    then Result := PropValue.DataSet;
end;

function DrawTextEh(hDC: HDC; Text: String; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer;
begin
  Result := DrawText(hDC, PChar(Text), nCount, lpRect, uFormat);
end;

function WindowsDrawTextEx(DC: HDC; lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer;
begin
  Result := DrawTextEx(DC, PChar(lpchText), cchText, p4, dwDTFormat, @DTParams);
end;

function WindowsDrawTextEx(DC: HDC; lpchText: String; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;
begin
  Result := DrawTextEx(DC, PChar(lpchText), cchText, p4, dwDTFormat, nil);
end;

{
function DrawTextEh(hDC: HDC; Text: WideString; nCount: Integer;
  var lpRect: TRect; uFormat: UINT): Integer; overload;
begin
  Result := DrawTextW(hDC, PWideChar(Text), nCount, lpRect, uFormat);
end;

function WindowsDrawTextEx(DC: HDC; lpchText: WideString; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT; DTParams: TDrawTextParams): Integer; overload;
begin
  Result := DrawTextExW(DC, PWideChar(lpchText), cchText, p4, dwDTFormat, @DTParams);
end;

function WindowsDrawTextEx(DC: HDC; lpchText: WideString; cchText: Integer;
  var p4: TRect;  dwDTFormat: UINT): Integer; overload;
begin
  Result := DrawTextExW(DC, PWideChar(lpchText), cchText, p4, dwDTFormat, nil);
end;
}

function WindowsExtTextOut(DC: HDC; X, Y: Integer; Options: Longint;
  var Rect: TRect; Str: String; Count: Longint{; Dx: PInteger}): BOOL;
begin
  Result := ExtTextOut(DC, X, Y, Options,
    @Rect, PChar(Str), Count, nil);
end;

function WindowsGetOutlineTextMetrics(DC: HDC; p2: UINT; var OTMetricStructs: TOutlineTextMetric): UINT;
begin
  Result := GetOutlineTextMetrics(DC, p2, @OTMetricStructs);
end;

{function SendStructlParamMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
begin
  Result := SendMessage(hWnd, Msg, wParam, Integer(@lParam));
end;}

function SendStructMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam): LRESULT;
begin
  Result := SendMessage(hWnd, Msg, wParam, Integer(@lParam));
end;

function SendTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: string): LRESULT;
begin
  Result := SendMessage(hWnd, Msg, wParam, Integer(PChar(lParam)));
end;

function SendGetTextMessage(hWnd: HWND; Msg: UINT; wParam: WPARAM; var lParam: String; BufferSize: Integer): LRESULT;
var
  Text: array[0..4095] of Char;
begin
  Word((@Text)^) := SizeOf(Text);
  Result := SendMessage(hWnd, HWND, wParam, Longint(@Text));
  SetString(lParam, Text, Result);
end;

function SystemParametersInfoEh(uiAction, uiParam: UINT; var pvParam; fWinIni: UINT): BOOL;
begin
  Result := SystemParametersInfo(uiAction, uiParam, @pvParam, fWinIni);
end;

function WindowsInvalidateRect(hWnd: HWND; var Rect: TRect; bErase: BOOL): BOOL;
begin
  Result := InvalidateRect(hWnd, @Rect, bErase);
end;

function WindowsValidateRect(hWnd: HWND; var Rect: TRect): BOOL;
begin
  Result := ValidateRect(hWnd, @Rect);
end;

function WindowsScrollWindowEx(hWnd: HWND; dx, dy: Integer;
  var prcScroll,  prcClip: TRect;
  hrgnUpdate: HRGN; {prcUpdate: TRect; }flags: UINT): BOOL;
begin
  Result := ScrollWindowEx(hWnd, dx, dy, @prcScroll, @prcClip,
    hrgnUpdate, nil, flags);
end;

function WindowsScrollWindow(hWnd: HWND; dx, dy: Integer; var prcScroll, prcClip: TRect): BOOL;
begin
  Result := ScrollWindow(hWnd, dx, dy, @prcScroll, @prcClip);
end;

function FindWindowEh(lpClassName, lpWindowName: String): HWND;
begin

  Result := FindWindow(PChar(lpClassName), PChar(lpWindowName));
end;

procedure VarToMessage(var VarMessage; var Message: TMessage);
begin
  Message := TMessage(VarMessage);
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
  Result := TMessage(Message);
end;

function SmallPointToInteger(SmallPoint: TSmallPoint): Integer;
begin
  Result := Integer(SmallPoint);
end;

function LongintToSmallPoint(Value: Longint): TSmallPoint;
begin
  Result := TSmallPoint(Value);
end;

function WindowsLPtoDP(DC: HDC; var ARect: TRect): BOOL;
begin
  Result := LPtoDP(DC, ARect, 2);
end;

function WindowsCreatePolygonRgn(Points: array of TPoint; Count, FillMode: Integer): HRGN;
begin
  Result := CreatePolygonRgn(Points, Count, FillMode);
end;

procedure MessageSendGetSel(hWnd: HWND; var SelStart, SelEnd: Integer);
begin
  SendMessage(hWnd, EM_GETSEL, Longint(@SelStart), Longint(@SelEnd));
end;

function NlsUpperCase(const S: String): String;
begin
  Result := AnsiUpperCase(S);
end;

function NlsLowerCase(const S: String): String;
begin
  Result := AnsiLowerCase(S);
end;

function NlsCompareStr(const S1, S2: String): Integer;
begin
  Result := AnsiCompareStr(S1, S2);
end;

function NlsCompareText(const S1, S2: String): Integer;
begin
  Result := AnsiCompareText(S1, S2);
end;

procedure BitmapLoadFromResourceName(Bmp: TBitmap; Instance: THandle; const ResName: String);
begin
  Bmp.LoadFromResourceName(Instance, ResName);
end;

function LoadBitmapEh(hInstance: HINST; lpBitmapID: Integer): HBITMAP;
begin
  Result := LoadBitmap(hInstance, PChar(lpBitmapID));
end;

function GetPropListAsArray(ATypeInfo: PTypeInfo; TypeKinds: TTypeKinds): TPropListArray;
var
  PropList: PPropList;
  PropCount, FSize, i: Integer;
begin
  PropCount := GetPropList(ATypeInfo, tkProperties, nil);
  FSize := PropCount * SizeOf(Pointer);
  GetMem(PropList, FSize);
  GetPropList(ATypeInfo, tkProperties, PropList);
  SetLength(Result, PropCount);
  for i := 0 to PropCount-1 do
    Result[i] := PropList[i];
end;

function HexToBinEh(Text: Pointer; var Buffer: TBytes; Count: Integer): Integer;
begin
  SetLength(Buffer, 0);
  SetLength(Buffer, Count div 2);
  Result := HexToBin(PChar(Text), PChar(Buffer), Count);
end;

procedure BinToHexEh(Buffer: TBytes; var Text: String; Count: Integer);
begin
  SetString(Text, nil, Count*2);
  BinToHex(PChar(Buffer), PChar(Text), Count);
end;

procedure StreamWriteBytes(Stream: TStream; Buffer: TBytes);
begin
  Stream.Write(Pointer(Buffer)^, Length(Buffer));
end;

procedure StreamReadBytes(Stream: TStream; var Buffer: TBytes; Count: Integer);
var
  bs: String;
  i: Integer;
begin
  SetLength(Buffer, Count);
  SetString(bs, nil, Count);
  Stream.Read(Pointer(bs)^, Count);
  for i := 0 to Length(bs)-1 do
    Buffer[i] := Byte(bs[i+1]);
end;

function BytesOf(S: String): TBytes;
var
  i: Integer;
begin
  SetLength(Result, Length(S));
  for i := 0 to Length(S)-1 do
    Result[i] := Byte(S[i+1]);
end;

function PropInfo_getPropType(APropInfo: PPropInfo): PTypeInfo;
begin
  Result := APropInfo^.PropType^;
end;

function PropInfo_getName(APropInfo: PPropInfo): String;
begin
  Result := APropInfo^.Name;
end;

function PropType_getKind(APropType: PTypeInfo): TTypeKind;
begin
  Result := APropType^.Kind;
end;

procedure VarArrayRedimEh(var A : Variant; HighBound: Integer);
begin
  VarArrayRedim(A, HighBound);
end;

function EmptyRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
end;

{$IFNDEF EH_LIB_5}

function GetObjectProp(Instance: TObject; PropInfo: PPropInfo): TObject;
begin
  Result := TObject(GetOrdProp(Instance, PropInfo));
end;

function GetObjectPropClass(Instance: TObject; PropInfo: PPropInfo): TClass;
var
  TypeData: PTypeData;
begin
  TypeData := GetTypeData(PropInfo^.PropType^);
  if TypeData = nil then
    raise Exception.Create('SUnknownProperty');
//    raise EPropertyError.CreateRes(@SUnknownProperty);
  Result := TypeData^.ClassType;
end;

procedure SetObjectProp(Instance: TObject; PropInfo: PPropInfo;
  Value: TObject);
begin
  if (Value is GetObjectPropClass(Instance, PropInfo)) or
     (Value = nil) then
    SetOrdProp(Instance, PropInfo, Integer(Value));
end;

{$ENDIF}

type
  TPersistentCracker = class(TPersistent);
  TComponentCracker = class(TComponent);

function GetUltimateOwner(APersistent: TPersistent): TPersistent;
begin
  Result := TPersistentCracker(APersistent).GetOwner;
end;

{ TFilerAccess }

constructor TFilerAccess.Create(APersistent: TPersistent);
begin
  inherited Create;
  FPersistent := APersistent;
end;

procedure TFilerAccess.DefineProperties(AFiler: TFiler);
begin
  TPersistentCracker(FPersistent).DefineProperties(AFiler);
end;

function TFilerAccess.GetChildOwner: TComponent;
begin
  Result := TComponentCracker(FPersistent).GetChildOwner;
end;

function TFilerAccess.GetChildParent: TComponent;
begin
  Result := TComponentCracker(FPersistent).GetChildParent;
end;

procedure TFilerAccess.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  TComponentCracker(FPersistent).GetChildren(Proc, Root);
end;

procedure TFilerAccess.SetAncestor(Value: Boolean);
begin
  TComponentCracker(FPersistent).SetAncestor(Value);
end;

procedure TFilerAccess.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TComponentCracker(FPersistent).SetChildOrder(Child, Order);
end;

procedure TFilerAccess.Updated;
begin
  TComponentCracker(FPersistent).Updated;
end;

procedure TFilerAccess.Updating;
begin
  TComponentCracker(FPersistent).Updating;
end;

{ TMemoryStream }

constructor TMemoryStreamEh.Create;
begin
  inherited Create;
  HalfMemoryDelta := $1000;
end;

function TMemoryStreamEh.Realloc(var NewCapacity: Integer): Pointer;
var
  MemoryDelta: Integer;
begin
  MemoryDelta := HalfMemoryDelta * 2;
  if (NewCapacity > 0) and (NewCapacity <> Size) then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := Memory;
  if NewCapacity <> Capacity then
  begin
    if NewCapacity = 0 then
    begin
{$IFDEF MSWINDOWS}
      GlobalFreePtr(Memory);
{$ELSE}
      FreeMem(Memory);
{$ENDIF}
      Result := nil;
    end else
    begin
{$IFDEF MSWINDOWS}
      if Capacity = 0 then
        Result := GlobalAllocPtr(HeapAllocFlags, NewCapacity)
      else
        Result := GlobalReallocPtr(Memory, NewCapacity, HeapAllocFlags);
{$ELSE}
      if Capacity = 0 then
        GetMem(Result, NewCapacity)
      else
        ReallocMem(Result, NewCapacity);
{$ENDIF}
{$IFDEF EH_LIB_5}
      if Result = nil then raise EStreamError.CreateRes(@SMemoryStreamError);
{$ELSE}
      if Result = nil then raise EStreamError.Create(SMemoryStreamError);
{$ENDIF}
    end;
  end;
end;

{$IFNDEF EH_LIB_6}

{ TDragObjectEx }

procedure TDragObjectEx.BeforeDestruction;
begin
  // Do not call inherited here otherwise DragSave will be cleared and thus
  // we will be unable to automatically free the dragobject.
end;

{$ENDIF}

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
  Result := TObject(Integer(Value));
end;

function RefObjectToVariant(Value: TObject): Variant;
begin
  Result := Integer(Value);
end;

procedure DataVarCastAsObject(var Dest: Variant; const Source: Variant);
begin
  DataVarCast(Dest, Source, varVariant);
end;

function WStrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;
var
  Src : PWideChar;
begin
  Result := Dest;
  Src := Source;
  while (Src^ <> #$00) do
  begin
    Dest^ := Src^;
    Inc(Src);
    Inc(Dest);
  end;
  Dest^ := #$00;
end;

{$RANGECHECKS OFF}
// Here and below all routins work without rangecheck

function ExplicitLongwordToLongInt(v: Longword): LongInt;
begin
  Result := LongInt(v);
end;

function VarToWideStr(const V: Variant): WideString;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := '';
end;

end.



