{*******************************************************}
{                                                       }
{                      EhLib v5.0                       }
{                TPrintDBGridEh component               }
{                    (Build 5.1.01)                     }
{                                                       }
{   Copyright (c) 1998-2009 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrnDbgeh {$IFDEF CIL} platform{$ENDIF};

interface

{$I EhLib.Inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, DBGridEh, PrntsEh,
{$IFDEF CIL}
  EhLibVCLNET,
  System.Text,
  System.Runtime.InteropServices,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  ImgList, PrViewEh, Forms, DB, GridsEh, StdCtrls, ComCtrls;

type
  TMeasureUnits = (MM, Inches);
  TPrintDBGridEhOption = (pghFitGridToPageWidth, pghColored, pghRowAutoStretch,
    pghFitingByColWidths, pghOptimalColWidths);
  TPrintDBGridEhOptions = set of TPrintDBGridEhOption;


  TPageParams = class(TPersistent)
  private
//    FColumns: Integer;
//    FColumnSpace: Currency;
    FBottomMargin: Currency;
    FRightMargin: Currency;
    FLeftMargin: Currency;
    FTopMargin: Currency;
    procedure SetBottomMargin(const Value: Currency);
//    procedure SetColumns(const Value: Integer);
//    procedure SetColumnSpace(const Value: Currency);
    procedure SetLeftMargin(const Value: Currency);
    procedure SetRightMargin(const Value: Currency);
    procedure SetTopMargin(const Value: Currency);
    function IsBottomMarginStored: Boolean;
    function IsLeftMarginStored: Boolean;
    function IsRightMarginStored: Boolean;
    function IsTopMarginStored: Boolean;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property BottomMargin: Currency read FBottomMargin write SetBottomMargin stored IsBottomMarginStored;
    property LeftMargin: Currency read FLeftMargin write SetLeftMargin stored IsLeftMarginStored;
    property RightMargin: Currency read FRightMargin write SetRightMargin stored IsRightMarginStored;
    property TopMargin: Currency read FTopMargin write SetTopMargin stored IsTopMarginStored;
//    property Columns:Integer read FColumns write SetColumns;
//    property ColumnSpace:Currency read FColumnSpace write SetColumnSpace;
  end;

  TPageColontitleLineType = (pcltNon, pcltSingleLine, pcltDoubleLine);

  TPageColontitle = class(TPersistent)
  private
    FCenterText: TStrings;
    FFont: TFont;
    FLeftText: TStrings;
    FLineType: TPageColontitleLineType;
    FRightText: TStrings;
    procedure SetCenterText(const Value: TStrings);
    procedure SetFont(const Value: TFont);
    procedure SetLeftText(const Value: TStrings);
    procedure SetLineType(const Value: TPageColontitleLineType);
    procedure SetRightText(const Value: TStrings);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create;
    destructor Destroy; override;
  published
    property CenterText: TStrings read FCenterText write SetCenterText;
    property Font: TFont read FFont write SetFont;
    property LeftText: TStrings read FLeftText write SetLeftText;
    property LineType: TPageColontitleLineType read FLineType write SetLineType default pcltNon;
    property RightText: TStrings read FRightText write SetRightText;
  end;

  TPrintDBGridEh = class(TComponent)
  private
    FAfterGridText: TStrings;
    FBeforeGridText: TStrings;
    FColCellParamsEh: TColCellParamsEh;
    FDBGridEh: TDBGridEh;
    FOnAfterPrint: TNotifyEvent;
    FOnBeforePrint: TNotifyEvent;
    FOnPrinterSetupDialog: TNotifyEvent;
    FOptions: TPrintDBGridEhOptions;
    FPage: TPageParams;
    FPageFooter: TPageColontitle;
    FPageHeader: TPageColontitle;
    FPrintFontName: String;
    FSubstitutesNames: TStrings;
    FSubstitutesValues: TStrings;
    FTitle: TStrings;
    FUnits: TMeasureUnits;
    FVarColCellParamsEh: TColCellParamsEh;
    FLastRowTexts: TStrings;
    function GetAfterGridText: TStrings;
    function GetBeforeGridText: TStrings;
    function GridTextReplace(RichStrings: TStrings; const SearchStr, ReplaceStr: string;
      StartPos, Length: Integer; Options: TSearchTypes; ReplaceAll: Boolean): Integer;
    procedure ReadAfterGridText(Stream: TStream);
    procedure ReadBeforeGridText(Stream: TStream);
    procedure SetAfterGridText(const Value: TStrings);
    procedure SetBeforeGridText(const Value: TStrings);
    procedure SetDBGridEh(const Value: TDBGridEh);
    procedure SetOptions(const Value: TPrintDBGridEhOptions);
    procedure SetPage(const Value: TPageParams);
    procedure SetPageFooter(const Value: TPageColontitle);
    procedure SetPageHeader(const Value: TPageColontitle);
    procedure SetPrintFontName(const Value: String);
    procedure SetTitle(const Value: TStrings);
    procedure SetUnits(const Value: TMeasureUnits);
    procedure WriteAfterGridText(Stream: TStream);
    procedure WriteBeforeGridText(Stream: TStream);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PrinterSetupDialogPreview(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function PrinterSetupDialog: Boolean;
    procedure Preview;
    procedure Print;
    procedure PrintTo(VPrinter: TVirtualPrinter);
    procedure SetSubstitutes(ASubstitutes: array of const);
  published
    property AfterGridText: TStrings read GetAfterGridText write SetAfterGridText stored False;
    property BeforeGridText: TStrings read GetBeforeGridText write SetBeforeGridText stored False;
    property DBGridEh: TDBGridEh read FDBGridEh write SetDBGridEh;
    property Options: TPrintDBGridEhOptions read FOptions write SetOptions;
    property Page: TPageParams read FPage write SetPage;
    property PageFooter: TPageColontitle read FPageFooter write SetPageFooter;
    property PageHeader: TPageColontitle read FPageHeader write SetPageHeader;
    property PrintFontName: String read FPrintFontName write SetPrintFontName;
    property Title: TStrings read FTitle write SetTitle;
    property Units: TMeasureUnits read FUnits write SetUnits;
    property OnAfterPrint: TNotifyEvent read FOnAfterPrint write FOnAfterPrint;
    property OnBeforePrint: TNotifyEvent read FOnBeforePrint write FOnBeforePrint;
    property OnPrinterSetupDialog: TNotifyEvent read FOnPrinterSetupDialog write FOnPrinterSetupDialog;
  end;


implementation

uses PrnDGDlg, RichEdit, ComStrs, EhLibConsts, ToolCtrlsEh
  {$IFDEF EH_LIB_6} ,Variants ,Types {$ENDIF};

type
  TDBGridEhCracker = class(TCustomDBGridEh);

var
  FCheckBoxWidth, FCheckBoxHeight: Integer;

procedure GetCheckSize;
begin
  with TBitmap.Create do
  try
{$IFDEF CIL}
    Handle := LoadBitmap(0, OBM_CHECKBOXES);
{$ELSE}
    Handle := LoadBitmap(0, PChar(32759));
{$ENDIF}
    FCheckBoxWidth := Width div 4;
    FCheckBoxHeight := Height div 3;
  finally
    Free;
  end;
end;

function iif(Condition: Boolean; V1, V2: Integer): Integer;
begin
  if (Condition) then Result := V1 else Result := V2;
end;

function GetTextWidth(Canvas: TCanvas; Text: String): Integer;
var ARect: TRect;
  uFormat: Integer;
begin
  uFormat := DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DT_EXPANDTABS;
  ARect := Rect(0, 0, 1, 0);
  DrawTextEh(Canvas.Handle, Text, Length(Text), ARect, uFormat);
  Result := ARect.Right - ARect.Left;
end;

{new WriteTextEh}{}
function WriteTextEh(ACanvas: TCanvas; ARect: TRect; FillRect: Boolean; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; Layout: TTextLayout; MultyL: Boolean;
  EndEllipsis: Boolean; LeftMarg, RightMarg: Integer; CalcRect: Boolean;
  ARightToLeftAlignment, ARightToLeftReading: Boolean): Integer;
const
  AlignFlags: array[TAlignment] of Integer =
  (DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_RIGHT or DT_EXPANDTABS or DT_NOPREFIX,
    DT_CENTER or DT_EXPANDTABS or DT_NOPREFIX);
  RTL: array[Boolean] of Integer = (0, DT_RTLREADING);
var opt: Integer;
  tm: TTEXTMETRIC;
  rect1: TRect;
  txth, DrawFlag: Integer;
  lpDTP: TDrawTextParams;
begin
  Result := 0;
  if ARightToLeftAlignment then
  begin
    ChangeBiDiModeAlignment(Alignment);
    opt := LeftMarg;
    LeftMarg := RightMarg;
    RightMarg := opt;
  end;
  if CalcRect = False then begin
    if (FillRect = True) then ACanvas.FillRect(ARect);

    DrawFlag := 0;
    if (MultyL = True) then DrawFlag := DrawFlag or DT_WORDBREAK;
    if (EndEllipsis = True) then DrawFlag := DrawFlag or DT_END_ELLIPSIS;
    DrawFlag := DrawFlag or AlignFlags[Alignment] or RTL[ARightToLeftReading];

    {}
    rect1.Left := 0; rect1.Top := 0; rect1.Right := 0; rect1.Bottom := 0;
    rect1 := ARect; {}

    lpDTP.cbSize := SizeOf(lpDTP);
    lpDTP.uiLengthDrawn := Length(Text);
    lpDTP.iLeftMargin := LeftMarg;
    lpDTP.iRightMargin := RightMarg;

    InflateRect(rect1, -DX, -DY);

    if (Layout <> tlTop) {and (MultyL = True)} then
      txth := WindowsDrawTextEx(ACanvas.Handle, Text, Length(Text), {}
        rect1, DrawFlag or DT_CALCRECT, lpDTP) // Получить квадрат.
    else txth := 0;
    rect1 := ARect; {}
    InflateRect(rect1, -DX, -DY);

    case Layout of
      tlTop: ;
      tlBottom: rect1.top := rect1.Bottom - txth;
      tlCenter: rect1.top := rect1.top + ((rect1.Bottom - rect1.top) div 2) - (txth div 2);
    end;

    if DX > 0 then rect1.Bottom := rect1.Bottom + 1;
      WindowsDrawTextEx(ACanvas.Handle, Text, Length(Text), rect1, DrawFlag, lpDTP); {}
  end else
  begin
    GetTextMetrics(ACanvas.Handle, tm);
    Inc(ARect.Left, DX); Inc(ARect.Top, DY);
    Dec(ARect.Right, DX); Dec(ARect.Bottom, DY);
    opt := DT_LEFT or DT_EXPANDTABS or DT_NOPREFIX or DT_CALCRECT or RTL[ARightToLeftReading];
    if MultyL
      then opt := opt or DT_WORDBREAK;
    Result := WindowsDrawTextEx(ACanvas.Handle, Text, Length(Text), ARect, opt);
    Inc(Result, tm.tmExternalLeading);
    Inc(Result, DY * 2);
  end;
end;

{$IFNDEF VER120} {Borland Delphi 3.0 }
type TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
{$ENDIF}

function StringReplaceMacros(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags; MacroChar: Char): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := NlsUpperCase(S);
    Patt := NlsUpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    if (Offset = 1) or (SearchStr[Offset - 1] <> MacroChar)
      then Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern
      else Result := Result + Copy(NewStr, 1, Offset - 1) + OldPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function GetStingListText(sl: TStrings): String;
begin
  Result := Copy(sl.Text, 1, Length(sl.Text) - 2);
end;

{ TRichEditStrings, from VCL ComCtrls.pas }

const
  ReadError = $0001;
  WriteError = $0002;
  NoError = $0000;

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

  TRichEditStrings = class(TStrings)
  private
    RichEdit: TRichEdit;
    FPlainText: Boolean;
    FConverter: TConversion;
    procedure EnableChange(const Value: Boolean);
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetTextStr(const Value: string); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; override;
    procedure AddStrings(Strings: TStrings); override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;

{$IFDEF CIL}
    procedure LoadFromFile(const FileName: string; Encoding: System.Text.Encoding); override;
    procedure LoadFromStream(Stream: TStream; Encoding: System.Text.Encoding); override;
    procedure SaveToFile(const FileName: string; Encoding: System.Text.Encoding); override;
    procedure SaveToStream(Stream: TStream; Encoding: System.Text.Encoding); override;
{$ELSE}
{$IFDEF EH_LIB_12}
    procedure LoadFromFile(const FileName: string; Encoding: TEncoding); override;
    procedure LoadFromStream(Stream: TStream; Encoding: TEncoding); override;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); override;
    procedure SaveToStream(Stream: TStream; Encoding: TEncoding); override;
{$ELSE}
    procedure LoadFromFile(const FileName: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToFile(const FileName: string); override;
    procedure SaveToStream(Stream: TStream); override;
{$ENDIF}
{$ENDIF}
    property PlainText: Boolean read FPlainText write FPlainText;
  end;

constructor TRichEditStrings.Create;
begin
  inherited Create;
  RichEdit := TRichEdit.Create(nil);
  RichEdit.Visible := False;
  //Application.CreateHandle;
  RichEdit.ParentWindow := GetDesktopWindow; //}Application.Handle;
end;

destructor TRichEditStrings.Destroy;
begin
  FreeAndNil(FConverter);
  FreeAndNil(RichEdit);
  inherited Destroy;
end;

procedure TRichEditStrings.AddStrings(Strings: TStrings);
var
  SelChange: TNotifyEvent;
begin
  SelChange := RichEdit.OnSelectionChange;
  RichEdit.OnSelectionChange := nil;
  try
    inherited AddStrings(Strings);
  finally
    RichEdit.OnSelectionChange := SelChange;
  end;
end;

function TRichEditStrings.GetCount: Integer;
begin
  Result := SendMessage(RichEdit.Handle, EM_GETLINECOUNT, 0, 0);
  if SendMessage(RichEdit.Handle, EM_LINELENGTH, SendMessage(RichEdit.Handle,
    EM_LINEINDEX, Result - 1, 0), 0) = 0 then Dec(Result);
end;

function TRichEditStrings.Get(Index: Integer): string;
var
//  Text: array[0..4095] of Char;
  Text: String;
  L: Integer;
begin
//  Word((@Text)^) := SizeOf(Text);
//  L := SendMessage(RichEdit.Handle, EM_GETLINE, Index, Longint(@Text));

  { TODO -cCheck : Chech that next line is not required?}
//  if (Text[L - 2] = #13) and (Text[L - 1] = #10) then Dec(L, 2);

//  SetString(Result, Text, L);

  L := SendGetTextMessage(RichEdit.Handle, EM_GETLINE, Index, Text, 4095);
  if (L >= 1) and (Result[L] = #13) then
    SetLength(Result, L - 1);
end;

procedure TRichEditStrings.Put(Index: Integer; const S: string);
var
  Selection: TCharRange;
begin
  if Index >= 0 then
  begin
    Selection.cpMin := SendMessage(RichEdit.Handle, EM_LINEINDEX, Index, 0);
    if Selection.cpMin <> -1 then
    begin
      Selection.cpMax := Selection.cpMin +
        SendMessage(RichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
//      SendMessage(RichEdit.Handle, EM_EXSETSEL, 0, Longint(@Selection));
//      SendMessage(RichEdit.Handle, EM_REPLACESEL, 0, Longint(PChar(S)));
      SendStructMessage(RichEdit.Handle, EM_EXSETSEL, 0, Selection);
      SendTextMessage(RichEdit.Handle, EM_REPLACESEL, 0, S);
    end;
  end;
end;

procedure TRichEditStrings.Insert(Index: Integer; const S: string);
var
  L: Integer;
  Selection: TCharRange;
{$IFDEF CIL}
  Fmt: string;
{$ELSE}
  Fmt: PChar;
{$ENDIF}
  Str: string;
begin
  if Index >= 0 then
  begin
    Selection.cpMin := SendMessage(RichEdit.Handle, EM_LINEINDEX, Index, 0);
    if Selection.cpMin >= 0 then
{$IFDEF CIL}
      Fmt := '%s'#13
{$ELSE}
      Fmt := '%s'#13#10
{$ENDIF}
    else
    begin
      Selection.cpMin :=
        SendMessage(RichEdit.Handle, EM_LINEINDEX, Index - 1, 0);
      if Selection.cpMin < 0 then Exit;
      L := SendMessage(RichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
      if L = 0 then Exit;
      Inc(Selection.cpMin, L);
{$IFDEF CIL}
      Fmt := #13'%s';
{$ELSE}
      Fmt := #13#10'%s';
{$ENDIF}
    end;
    Selection.cpMax := Selection.cpMin;
//    SendMessage(RichEdit.Handle, EM_EXSETSEL, 0, Longint(@Selection));
    SendStructMessage(RichEdit.Handle, EM_EXSETSEL, 0, Selection);
    Str := Format(Fmt, [S]);
//  SendMessage(RichEdit.Handle, EM_REPLACESEL, 0, LongInt(PChar(Str)));
    SendTextMessage(RichEdit.Handle, EM_REPLACESEL, 0, Str);
    if RichEdit.SelStart <> (Selection.cpMax + Length(Str)) then
      raise EOutOfResources.Create(sRichEditInsertError);
  end;
end;

procedure TRichEditStrings.Delete(Index: Integer);
const
{$IFDEF CIL}
  REStrEmpty = '';
{$ELSE}
  REStrEmpty: PChar = '';
{$ENDIF}
var
  Selection: TCharRange;
begin
  if Index < 0 then Exit;
  Selection.cpMin := SendMessage(RichEdit.Handle, EM_LINEINDEX, Index, 0);
  if Selection.cpMin <> -1 then
  begin
    Selection.cpMax := SendMessage(RichEdit.Handle, EM_LINEINDEX, Index + 1, 0);
    if Selection.cpMax = -1 then
      Selection.cpMax := Selection.cpMin +
        SendMessage(RichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
//    SendMessage(RichEdit.Handle, EM_EXSETSEL, 0, Longint(@Selection));
//    SendMessage(RichEdit.Handle, EM_REPLACESEL, 0, Longint(Empty));
    SendStructMessage(RichEdit.Handle, EM_EXSETSEL, 0, Selection);
    SendTextMessage(RichEdit.Handle, EM_REPLACESEL, 0, REStrEmpty);
  end;
end;

procedure TRichEditStrings.Clear;
begin
  RichEdit.Clear;
end;

procedure TRichEditStrings.SetUpdateState(Updating: Boolean);
begin
  if RichEdit.Showing then
    SendMessage(RichEdit.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then
  begin
    RichEdit.Refresh;
    RichEdit.Perform(CM_TEXTCHANGED, 0, 0);
  end;
end;

procedure TRichEditStrings.EnableChange(const Value: Boolean);
var
  EventMask: Longint;
begin
  with RichEdit do
  begin
    if Value then
      EventMask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0) or ENM_CHANGE
    else
      EventMask := SendMessage(Handle, EM_GETEVENTMASK, 0, 0) and not ENM_CHANGE;
    SendMessage(Handle, EM_SETEVENTMASK, 0, EventMask);
  end;
end;

procedure TRichEditStrings.SetTextStr(const Value: string);
begin
  EnableChange(False);
  try
    inherited SetTextStr(Value);
  finally
    EnableChange(True);
  end;
end;

{$IFDEF CIL}

//StreamSave StreamLoad TRichEditStrings.SaveToStream TRichEditStrings.SaveToStream
//AdjustLineBreaks

function AdjustLineBreaks(Dest: IntPtr; Source: TBytes; Start, Len: Integer): Integer;
var
  I, J: Integer;
begin
  I := Start; // Position in Source
  J := 0; // Position in Dest
  while I < (Len - 1) do
  begin
    if (Source[I] = 10) and (Source[I + 1] = 0) then
    begin
      // Convert #10 to #13#10
      Marshal.WriteByte(Dest, J, 13);
      Marshal.WriteByte(Dest, J + 1, 0);
      Inc(J, 2);
      Marshal.WriteByte(Dest, J, 10);
      Marshal.WriteByte(Dest, J + 1, 0);
    end
    else
    begin
      Marshal.WriteByte(Dest, J, Source[I]);
      Marshal.WriteByte(Dest, J + 1, Source[I + 1]);
      if (Source[I] = 13) and (Source[I + 1] = 0) then
      begin
        // Convert #13 to #13#10
        Inc(J, 2);
        Marshal.WriteByte(Dest, J, 10);
        Marshal.WriteByte(Dest, J + 1, 0);
        // Skip #10 if preceeded by #13
        if (Source[I + 2] = 10) and (Source[I + 3] = 0) then
          Inc(I, 2);
      end;
    end;
    Inc(I, 2);
    Inc(J, 2);
  end;
  Result := J;
end;

function StreamSave(dwCookie: Longint; pbBuff: IntPtr;
  cb: Longint; var pcb: Longint): Longint;
var
  StreamInfo: TRichEditStreamInfo;
  Buffer: TBytes;
  Handle: GCHandle;
begin
  Result := NoError;
  Handle := GCHandle(IntPtr(dwCookie));
  StreamInfo := TRichEditStreamInfo(Handle.Target);
  try
    pcb := 0;
    if StreamInfo.Converter <> nil then
    begin
      SetLength(Buffer, cb);
      Marshal.Copy(pbBuff, Buffer, 0, cb);
      // Convert from Unicode to Encoding if PlainText is set
      if StreamInfo.PlainText then
      begin
        if StreamInfo.Encoding = nil then
          Buffer := Encoding.Convert(Encoding.Unicode, Encoding.Default, Buffer)
        else
        begin
          if not Encoding.Unicode.Equals(StreamInfo.Encoding) then
            Buffer := Encoding.Convert(Encoding.Unicode, StreamInfo.Encoding, Buffer);
        end;
      end;
      pcb := StreamInfo.Converter.ConvertWriteStream(StreamInfo.Stream, Buffer, Length(Buffer));
      // Length(Buffer) may be different from 'cb' if we converted the char set
      if (pcb <> cb) and (pcb = Length(Buffer)) then
        pcb := cb; // Fake the number of bytes written
    end;
  except
    Result := WriteError;
  end;
end;

function StreamLoad(dwCookie: Longint; pbBuff: IntPtr;
  cb: Longint; var pcb: Longint): Longint;
var
  Buffer, Preamble: TBytes;
  StreamInfo: TRichEditStreamInfo;
  Handle: GCHandle;
  StartIndex: Integer;
begin
  Result := NoError;
  Handle := GCHandle(IntPtr(dwCookie));
  StreamInfo := TRichEditStreamInfo(Handle.Target);
  SetLength(Buffer, cb + 1);
  cb := cb div 2;
  StartIndex := 0;
  pcb := 0;
  try
    if StreamInfo.Converter <> nil then
      pcb := StreamInfo.Converter.ConvertReadStream(StreamInfo.Stream, Buffer, cb);
    if pcb > 0 then
    begin
      Buffer[pcb] := 0;
      if Buffer[pcb - 1] = 13 then
        Buffer[pcb - 1] := 0;

      // Convert from desired Encoding to Unicode
      if StreamInfo.PlainText then
      begin
        if StreamInfo.Encoding = nil then
        begin
          Buffer := Encoding.Convert(Encoding.Default, Encoding.Unicode, Buffer, 0, pcb);
          pcb := Length(Buffer);
        end
        else
        begin
          if not Encoding.Unicode.Equals(StreamInfo.Encoding) then
          begin
            Buffer := Encoding.Convert(StreamInfo.Encoding, Encoding.Unicode, Buffer, 0, pcb);
            pcb := Length(Buffer);
          end;
          // If Unicode preamble is present, set StartIndex to skip over it
          Preamble := Encoding.Unicode.GetPreamble;
          if (pcb >= 2) and (Buffer[0] = Preamble[0]) and (Buffer[1] = Preamble[1]) then
            StartIndex := 2;
        end;
      end;
      pcb := AdjustLineBreaks(pbBuff, Buffer, StartIndex, pcb);
    end;
  except
    Result := ReadError;
  end;
end;

procedure TRichEditStrings.LoadFromStream(Stream: TStream; Encoding: System.Text.Encoding);
var
  EditStream: TEditStream;
  Position: Longint;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
  Handle: GCHandle;
begin
  StreamInfo.Stream := Stream;
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := RichEdit.DefaultConverter.Create;
  StreamInfo.Converter := Converter;
  StreamInfo.PlainText := PlainText;
  StreamInfo.Encoding := Encoding;
  try
    Handle := GCHandle.Alloc(TObject(StreamInfo));
    try
      with EditStream do
      begin
        dwCookie := Longint(IntPtr(Handle));
        pfnCallBack := StreamLoad;
        dwError := 0;
      end;
      Position := Stream.Position;
      if PlainText then
        TextType := SF_TEXT or SF_UNICODE
      else
        TextType := SF_RTF;
      SendGetStructMessage(RichEdit.Handle, EM_STREAMIN, TextType, EditStream, True);
      if (TextType = SF_RTF) and (EditStream.dwError <> 0) then
      begin
        Stream.Position := Position;
        if PlainText then
          TextType := SF_RTF
        else
          TextType := SF_TEXT or SF_UNICODE;
        StreamInfo.PlainText := not PlainText;
        SendGetStructMessage(RichEdit.Handle, EM_STREAMIN, TextType, EditStream, True);
        if EditStream.dwError <> 0 then
          raise EOutOfResources.Create(sRichEditLoadFail);
      end;
    finally
      Handle.Free;
    end;
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

procedure TRichEditStrings.SaveToStream(Stream: TStream; Encoding: System.Text.Encoding);
var
  EditStream: TEditStream;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
  Handle: GCHandle;
  Preamble: TBytes;
begin
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := RichEdit.DefaultConverter.Create;
  StreamInfo.Stream := Stream;
  StreamInfo.Converter := Converter;
  StreamInfo.PlainText := PlainText;
  StreamInfo.Encoding := Encoding;
  try
    Handle := GCHandle.Alloc(TObject(StreamInfo));
    try
      with EditStream do
      begin
        dwCookie := LongInt(IntPtr(Handle));
        pfnCallBack := StreamSave;
        dwError := 0;
      end;
      if PlainText then
      begin
        TextType := SF_TEXT or SF_UNICODE;
        if Encoding <> nil then
        begin
          Preamble := Encoding.GetPreamble;
          if Length(Preamble) > 0 then
            Stream.WriteBuffer(Preamble, Length(Preamble));
        end;
      end
      else
        TextType := SF_RTF;
      SendGetStructMessage(RichEdit.Handle, EM_STREAMOUT, TextType, EditStream, True);
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(sRichEditSaveFail);
    finally
      Handle.Free;
    end;
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

procedure TRichEditStrings.SaveToFile(const FileName: string; Encoding: System.Text.Encoding);
begin
  inherited LoadFromFile(FileName, Encoding);
end;

procedure TRichEditStrings.LoadFromFile(const FileName: string; Encoding: System.Text.Encoding);
begin
  inherited SaveToFile(FileName, Encoding);
end;

{$ELSE}

{$IFDEF EH_LIB_12}

const
  TextConversionFormat: TConversionFormat = (
    ConversionClass: TConversion;
    Extension: 'txt');
var
  ConversionFormatList: TList;

procedure TRichEditStrings.LoadFromFile(const FileName: string; Encoding: TEncoding);
var
  I: Integer;
  Ext: string;
  Convert, LConvert: TConversionFormat;
begin
  Ext := WideLowerCase(ExtractFileExt(Filename));
  System.Delete(Ext, 1, 1);

  Convert := TextConversionFormat;
  for I := 0 to ConversionFormatList.Count - 1 do
  begin
    LConvert := PConversionFormat(ConversionFormatList[I])^;
    if LConvert.Extension = Ext then
    begin
      Convert := LConvert;
      Break;
    end;
  end;

  if FConverter = nil then
    FConverter := Convert.ConversionClass.Create;
  try
    inherited LoadFromFile(FileName, Encoding);
  except
    FConverter.Free;
    FConverter := nil;
    raise;
  end;
  SendMessage(RichEdit.Handle, EM_EXLIMITTEXT, 0, $7FFFFFF0);
//  RichEdit.DoSetMaxLength($7FFFFFF0);
end;

function ContainsPreamble(Stream: TStream; Signature: TBytes): Boolean;
var
  Buffer: TBytes;
  I, LBufLen, LSignatureLen, LPosition: Integer;
begin
  Result := True;
  LSignatureLen := Length(Signature);
  LPosition := Stream.Position;
  try
    SetLength(Buffer, LSignatureLen);
    LBufLen := Stream.Read(Buffer[0], LSignatureLen);
  finally
    Stream.Position := LPosition;
  end;

  if LBufLen = LSignatureLen then
  begin
    for I := 1 to LSignatureLen do
      if Buffer[I - 1] <> Signature [I - 1] then
      begin
        Result := False;
        Break;
      end;
  end
  else
    Result := False;
end;

function AdjustLineBreaks(Dest: PByte; Source: TBytes; Start, Len: Integer): Integer;
var
  P: PByte;
  I: Integer;
begin
  I := Start; // Position in Source
  P := Dest;
  while I < (Len - 1) do
  begin
    if (Source[I] = 10) and (Source[I + 1] = 0) then
    begin
      // Convert #10 to #13#10
      P^ := 13;
      Inc(P);
      P^ := 0;
      Inc(P);
      P^ := 10;
      Inc(P);
      P^ := 0;
      Inc(P);
    end
    else
    begin
      P^ := Source[I];
      Inc(P);
      P^ := Source[I + 1];
      Inc(P);
      if (Source[I] = 13) and (Source[I + 1] = 0) then
      begin
        // Convert #13 to #13#10
        P^ := 10;
        Inc(P);
        P^ := 0;
        Inc(P);
        // Skip #10 if preceeded by #13
        if (Source[I + 2] = 10) and (Source[I + 3] = 0) then
          Inc(I, 2);
      end;
    end;
    Inc(I, 2);
  end;
  if I = Len - 1 then
  begin
    P^ := Source[I];
    Inc(P);
  end;
  Result := Integer(P) - Integer(Dest);
end;

function StreamLoad(dwCookie: Longint; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
var
  Buffer, Preamble: TBytes;
  StreamInfo: TRichEditStreamInfo;
  StartIndex: Integer;
begin
  Result := NoError;
  StreamInfo := PRichEditStreamInfo(dwCookie)^;
  SetLength(Buffer, cb + 1);
  cb := cb div 2;
  if (cb mod 2) > 0 then
    cb := cb -1 ;
  StartIndex := 0;
  pcb := 0;
  try
    if StreamInfo.Converter <> nil then
      pcb := StreamInfo.Converter.ConvertReadStream(StreamInfo.Stream, Buffer, cb);
    if pcb > 0 then
    begin
      Buffer[pcb] := 0;
      if Buffer[pcb - 1] = 13 then
        Buffer[pcb - 1] := 0;

      // Convert from desired Encoding to Unicode
      if StreamInfo.PlainText then
      begin
        if StreamInfo.Encoding = nil then
        begin
          Buffer := TEncoding.Convert(TEncoding.Default, TEncoding.Unicode, Buffer, 0, pcb);
          pcb := Length(Buffer);
        end
        else
        begin
          if not TEncoding.Unicode.Equals(StreamInfo.Encoding) then
          begin
            Buffer := TEncoding.Convert(StreamInfo.Encoding, TEncoding.Unicode, Buffer, 0, pcb);
            pcb := Length(Buffer);
          end;
          // If Unicode preamble is present, set StartIndex to skip over it
          Preamble := TEncoding.Unicode.GetPreamble;
          if (pcb >= 2) and (Buffer[0] = Preamble[0]) and (Buffer[1] = Preamble[1]) then
            StartIndex := 2;
        end;
      end;
      pcb := AdjustLineBreaks(pbBuff, Buffer, StartIndex, pcb);
    end;
  except
    Result := ReadError;
  end;
end;

procedure TRichEditStrings.LoadFromStream(Stream: TStream; Encoding: TEncoding);
var
  EditStream: TEditStream;
  Position: Longint;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
begin
  if Encoding = nil then
  begin
    // Find the appropraite encoding
    if ContainsPreamble(Stream, TEncoding.Unicode.GetPreamble) then
      Encoding := TEncoding.Unicode
    else
      if ContainsPreamble(Stream, TEncoding.BigEndianUnicode.GetPreamble) then
        Encoding := TEncoding.BigEndianUnicode
      else
        if ContainsPreamble(Stream, TEncoding.UTF8.GetPreamble) then
          Encoding := TEncoding.UTF8
        else
          Encoding := TEncoding.Default;
  end;

  StreamInfo.Stream := Stream;
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := RichEdit.DefaultConverter.Create;
  StreamInfo.Converter := Converter;
  StreamInfo.PlainText := PlainText;
  StreamInfo.Encoding := Encoding;
  try
    try
      with EditStream do
      begin
        dwCookie := DWORD_PTR(@StreamInfo);
        pfnCallBack := StreamLoad;
        dwError := 0;
      end;
      Position := Stream.Position;
      if PlainText then
        TextType := SF_TEXT or SF_UNICODE
      else
        TextType := SF_RTF;
      SendGetStructMessage(RichEdit.Handle, EM_STREAMIN, TextType, EditStream, True);
    finally
    end;

    if (TextType = SF_RTF) and (EditStream.dwError <> 0) then
    begin
      Stream.Position := Position;
      if PlainText then
        TextType := SF_RTF
      else
        TextType := SF_TEXT or SF_UNICODE;
      StreamInfo.PlainText := not PlainText;
      SendMessage(RichEdit.Handle, EM_STREAMIN, TextType, Windows.LPARAM(@EditStream));
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(sRichEditLoadFail);
    end;
  finally
    if FConverter = nil then
      Converter.Free;
  end;
end;
procedure TRichEditStrings.SaveToFile(const FileName: string; Encoding: TEncoding);
var
  I: Integer;
  Ext: string;
  Convert, LConvert: TConversionFormat;
begin
  Ext := WideLowerCase(ExtractFileExt(Filename));
  System.Delete(Ext, 1, 1);

  Convert := TextConversionFormat;
  for I := 0 to ConversionFormatList.Count - 1 do
  begin
    LConvert := PConversionFormat(ConversionFormatList[I])^;
    if LConvert.Extension = Ext then
    begin
      Convert := LConvert;
      Break;
    end;
  end;

  if FConverter = nil then
    FConverter := Convert.ConversionClass.Create;
  try
    inherited SaveToFile(FileName, Encoding);
  except
    FConverter.Free;
    FConverter := nil;
    raise;
  end;
end;

function StreamSave(dwCookie: Longint; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
var
  StreamInfo: TRichEditStreamInfo;
  Buffer: TBytes;
begin
  Result := NoError;
  StreamInfo := PRichEditStreamInfo(dwCookie)^;
  try
    pcb := 0;
    if StreamInfo.Converter <> nil then
    begin
      SetLength(Buffer, cb);
      Move(pbBuff^, Buffer[0], cb);
      // Convert from Unicode to Encoding if PlainText is set
      if StreamInfo.PlainText then
      begin
        if StreamInfo.Encoding = nil then
          Buffer := TEncoding.Convert(TEncoding.Unicode, TEncoding.Default, Buffer)
        else
        begin
          if not TEncoding.Unicode.Equals(StreamInfo.Encoding) then
            Buffer := TEncoding.Convert(TEncoding.Unicode, StreamInfo.Encoding, Buffer);
        end;
      end;
      pcb := StreamInfo.Converter.ConvertWriteStream(StreamInfo.Stream, Buffer, Length(Buffer));
      // Length(Buffer) may be different from 'cb' if we converted the char set
      if (pcb <> cb) and (pcb = Length(Buffer)) then
        pcb := cb; // Fake the number of bytes written
    end;
  except
    Result := WriteError;
  end;
end;

procedure TRichEditStrings.SaveToStream(Stream: TStream; Encoding: TEncoding);
var
  EditStream: TEditStream;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
  Preamble: TBytes;
begin
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := RichEdit.DefaultConverter.Create;
  StreamInfo.Stream := Stream;
  StreamInfo.Converter := Converter;
  StreamInfo.PlainText := PlainText;
  StreamInfo.Encoding := Encoding;
  try
    try
      with EditStream do
      begin
        dwCookie := DWORD_PTR(@StreamInfo);
        pfnCallBack := StreamSave;
        dwError := 0;
      end;
      if PlainText then
      begin
        TextType := SF_TEXT or SF_UNICODE;
        if Encoding <> nil then
        begin
          Preamble := Encoding.GetPreamble;
          if Length(Preamble) > 0 then
            Stream.WriteBuffer(Preamble[0], Length(Preamble));
        end;
      end
      else
        TextType := SF_RTF;
      SendGetStructMessage(RichEdit.Handle, EM_STREAMOUT, TextType, EditStream, True);
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(sRichEditSaveFail);
    finally
    end;
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

{$ELSE}

  //StreamSave StreamLoad TRichEditStrings.SaveToStream TRichEditStrings.SaveToStream

function AdjustLineBreaks(Dest, Source: PChar): Integer; assembler;
asm
        PUSH    ESI
        PUSH    EDI
        MOV     EDI,EAX
        MOV     ESI,EDX
        MOV     EDX,EAX
        CLD
@@1:    LODSB
@@2:    OR      AL,AL
        JE      @@4
        CMP     AL,0AH
        JE      @@3
        STOSB
        CMP     AL,0DH
        JNE     @@1
        MOV     AL,0AH
        STOSB
        LODSB
        CMP     AL,0AH
        JE      @@1
        JMP     @@2
@@3:    MOV     EAX,0A0DH
        STOSW
        JMP     @@1
@@4:    STOSB
        LEA     EAX,[EDI-1]
        SUB     EAX,EDX
        POP     EDI
        POP     ESI
end;

function StreamSave(dwCookie: Longint; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
var
  StreamInfo: PRichEditStreamInfo;
begin
  Result := NoError;
  StreamInfo := PRichEditStreamInfo(Pointer(dwCookie));
  try
    pcb := 0;
    if StreamInfo^.Converter <> nil then
      pcb := StreamInfo^.Converter.ConvertWriteStream(StreamInfo^.Stream, PChar(pbBuff), cb);
  except
    Result := WriteError;
  end;
end;

function StreamLoad(dwCookie: Longint; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
var
  Buffer, pBuff: PChar;
  StreamInfo: PRichEditStreamInfo;
begin
  Result := NoError;
  StreamInfo := PRichEditStreamInfo(Pointer(dwCookie));
  Buffer := StrAlloc(cb + 1);
  try
    cb := cb div 2;
    pcb := 0;
    pBuff := Buffer + cb;
    try
      if StreamInfo^.Converter <> nil then
        pcb := StreamInfo^.Converter.ConvertReadStream(StreamInfo^.Stream, pBuff, cb);
      if pcb > 0 then
      begin
        pBuff[pcb] := #0;
        if pBuff[pcb - 1] = #13 then pBuff[pcb - 1] := #0;
        pcb := AdjustLineBreaks(Buffer, pBuff);
        Move(Buffer^, pbBuff^, pcb);
      end;
    except
      Result := ReadError;
    end;
  finally
    StrDispose(Buffer);
  end;
end;

procedure TRichEditStrings.LoadFromStream(Stream: TStream);
var
  EditStream: TEditStream;
  Position: Longint;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
begin
  StreamInfo.Stream := Stream;
  if FConverter <> nil then Converter := FConverter
  else Converter := RichEdit.DefaultConverter.Create;
  StreamInfo.Converter := Converter;
  try
    with EditStream do
    begin
      dwCookie := LongInt(Pointer(@StreamInfo));
      pfnCallBack := @StreamLoad;
      dwError := 0;
    end;
    Position := Stream.Position;
    if PlainText
      then TextType := SF_TEXT
      else TextType := SF_RTF;
    SendMessage(RichEdit.Handle, EM_STREAMIN, TextType, Longint(@EditStream));
    if (TextType = SF_RTF) and (EditStream.dwError <> 0) then
    begin
      Stream.Position := Position;
      if PlainText
        then TextType := SF_RTF
        else TextType := SF_TEXT;
      SendMessage(RichEdit.Handle, EM_STREAMIN, TextType, Longint(@EditStream));
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(sRichEditLoadFail);
    end;
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

procedure TRichEditStrings.SaveToStream(Stream: TStream);
var
  EditStream: TEditStream;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
begin
  if FConverter <> nil then Converter := FConverter
  else Converter := RichEdit.DefaultConverter.Create;
  StreamInfo.Stream := Stream;
  StreamInfo.Converter := Converter;
  try
    with EditStream do
    begin
      dwCookie := LongInt(Pointer(@StreamInfo));
      pfnCallBack := @StreamSave;
      dwError := 0;
    end;
    if PlainText then TextType := SF_TEXT
    else TextType := SF_RTF;
    SendMessage(RichEdit.Handle, EM_STREAMOUT, TextType, Longint(@EditStream));
    if EditStream.dwError <> 0 then
      raise EOutOfResources.Create(sRichEditSaveFail);
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

procedure TRichEditStrings.LoadFromFile(const FileName: string);
begin
  inherited LoadFromFile(FileName);
end;

procedure TRichEditStrings.SaveToFile(const FileName: string);
begin
  inherited SaveToFile(FileName);
end;

{$ENDIF}
{$ENDIF}


//type TColCellParamsEhCra cker = class(TColCellParamsEh) end;

{ TPrintDBGridEh }

constructor TPrintDBGridEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPage := TPageParams.Create;
  FPageFooter := TPageColontitle.Create;
  FPageHeader := TPageColontitle.Create;
  FTitle := TStringList.Create;
  FColCellParamsEh := TColCellParamsEh.Create;
end;

destructor TPrintDBGridEh.Destroy;
begin
  FreeAndNil(FColCellParamsEh);
  FreeAndNil(FPage);
  FreeAndNil(FPageFooter);
  FreeAndNil(FPageHeader);
  FreeAndNil(FTitle);
  FreeAndNil(FBeforeGridText);
  FreeAndNil(FAfterGridText);
  if FSubstitutesNames <> nil then FreeAndNil(FSubstitutesNames);
  if FSubstitutesValues <> nil then FreeAndNil(FSubstitutesValues);
  inherited Destroy;
end;

procedure TPrintDBGridEh.Preview;
begin
  if Assigned(OnPrinterSetupDialog) then
    PrinterPreview.OnPrinterSetupDialog := OnPrinterSetupDialog
  else
    PrinterPreview.OnPrinterSetupDialog := PrinterSetupDialogPreview;
  PrinterPreview.PrinterSetupOwner := Self;
  PrintTo(PrinterPreview);
end;

var
  MacroValues: array[0..5] of String = ('', '', '', '', '', '');

procedure TPrintDBGridEh.PrintTo(VPrinter: TVirtualPrinter);
type
  TPolyBookmark = record
    bm: TUniBookmarkEh;
    bmi: Integer;
    InDS: Boolean;
    EOF: Boolean;
  end;
//  TFooterValues = array[0..MaxListSize - 1] of Currency;
//  PFooterValues = ^TFooterValues;
  TFooterValues = array of Currency;

var
  PrnRowHeights, ColsToPages, PrnColWIdths: array of Integer;
//  ColsToPages, PrnRowHeights, PrnColWIdths: TList;
  GridWidth, RealRight, RealLeft, MinRowHeight: Integer;
  fPrnPhysOffSetX, fPrnPhysOffSetY: Integer;
  fPrnHorsRes, fPrnVertRes, PrnTitlEh, PenW, PrnTitleTextH: Integer;
  DataPrintRec, PrintRec: TRect;
  PrintOffset: Integer;
  fLogPelsX1, fLogPelsY1, fLogPelsX2, fLogPelsY2, fScaleX, fScaleY: Double;
  SavedBookMark: TUniBookmarkEh;
  PBm1, PBm2: TPolyBookmark;
  PSX1, PSY1, PSX2, PSY2: Integer;
  FirstPage, AWordWrap: Boolean;
  PolyPolyPoints: array of TPoint;//TList;
  PolyLengths: array of DWORD;
  TitleRect, FooterRect: TRect;
  PrnColumns: TColumnsEhList;
//  PrnColumnWidths: TList;
  PrnColumnWidths: array of Integer;
  FooterValues: TFooterValues;
  FSubstituted: Boolean;
  BeforeGridTextStream, AfterGridTextStream: TStream;
  CalcInfoMode: Boolean;
  PageCount: Integer;
  ACursor: TCursor;
  RenderMetafie: TMetafile;
  RenderCanvas: TMetafileCanvas;
  VPrinter_Canvas: TCanvas;

const Macros: array[0..5] of String = ('&[Page]', '&[ShortDate]', '&[Date]',
    '&[LongDate]', '&[Time]', '&[Pages]');

  procedure CreateRenderCanvas;
  begin
    RenderMetafie := TMetafile.Create;
    RenderCanvas := TMetafileCanvas.Create(RenderMetafie, VPrinter.Canvas.Handle);
    RenderCanvas.Font.PixelsPerInch := VPrinter.Canvas.Font.PixelsPerInch;
    VPrinter_Canvas := RenderCanvas;
  end;

  procedure FreeRenderCanvas;
  begin
    VPrinter_Canvas := VPrinter.Canvas;
    FreeAndNil(RenderCanvas);
    FreeAndNil(RenderMetafie);
  end;

  procedure InitMacroValues;
  begin
    MacroValues[1] := DateToStr(Now);
    MacroValues[2] := DateToStr(Now);
    MacroValues[3] := FormatDateTime(LongDateFormat, Now);
    MacroValues[4] := TimeToStr(Now);
    MacroValues[5] := IntToStr(PageCount);
  end;

  procedure InitPolyBookmark(var APBm: TPolyBookmark);
  var idx: Integer;
  begin
    if DBGridEh.DataSource.DataSet.Eof then
    begin
      APBm.InDS := False;
      APBm.bm := NilBookmarkEh; //nil;
      APBm.bmi := -1;
      if (DBGridEh.FooterRowCount = 0) then
        APBm.EOF := True
      else
      begin
        APBm.bmi := 0;
        APBm.EOF := False;
      end;
    end else
    begin
      if DBGridEh.Selection.SelectionType = gstRecordBookmarks then
      begin
        if DBGridEh.SelectedRows.Find(DBGridEh.DataSource.DataSet.Bookmark, idx) then
          APBm.bm := DBGridEh.DataSource.DataSet.Bookmark
        else
        begin
          APBm.bm := DBGridEh.SelectedRows[0];
          DBGridEh.DataSource.DataSet.Bookmark := DBGridEh.SelectedRows[0];
        end
      end else if DBGridEh.Selection.SelectionType = gstRectangle then
      begin
        APBm.bm := DBGridEh.Selection.Rect.TopRow;
        DBGridEh.DataSource.DataSet.Bookmark := DBGridEh.Selection.Rect.TopRow;
      end else
      begin
        APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
      end;
      APBm.InDS := True;
      APBm.EOF := False;
    end;
  end;

  procedure GotoPolyBookmark(var APBm: TPolyBookmark);
  begin
    if (APBm.InDS = True) then
      DBGridEh.DataSource.DataSet.Bookmark := APBm.bm;
  end;

  procedure SetNextPolyBookmark(var APBm: TPolyBookmark);
  var idx: Integer;
  begin
    if APBm.EOF then Exit;

    if (APBm.InDS = True) then
    begin
      if DBGridEh.Selection.SelectionType = gstRecordBookmarks then
      begin
        if DBGridEh.SelectedRows.Find(DBGridEh.DataSource.DataSet.Bookmark, idx) then
          if idx = DBGridEh.SelectedRows.Count - 1 then
          begin
            APBm.InDS := False;
            APBm.bm := NilBookmarkEh; //nil;
            APBm.bmi := -1;
            if (DBGridEh.FooterRowCount = 0)
              then APBm.EOF := True
            else begin
              APBm.bmi := 0; //Pointer(0);
              APBm.EOF := False;
            end;
          end
          else
          begin
            DBGridEh.DataSource.DataSet.Bookmark := DBGridEh.SelectedRows[idx + 1];
            APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
            APBm.EOF := False;
          end
        else
        begin
          DBGridEh.DataSource.DataSet.Bookmark := DBGridEh.SelectedRows[0];
          APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
          APBm.EOF := False;
        end;
      end else if DBGridEh.Selection.SelectionType = gstRectangle then
      begin
        DBGridEh.DataSource.DataSet.Next;
//        if (DBGridEh.DataSource.DataSet.CompareBookmarks(Pointer(DBGridEh.Selection.Rect.BottomRow),
        if (DataSetCompareBookmarks(
              DBGridEh.DataSource.DataSet,
              DBGridEh.Selection.Rect.BottomRow,
              DBGridEh.DataSource.DataSet.Bookmark) < 0) or
          DBGridEh.DataSource.DataSet.Eof then
        begin
          APBm.InDS := False;
          APBm.bm := NilBookmarkEh;
          APBm.bmi := -1;
          if (DBGridEh.FooterRowCount = 0) then APBm.EOF := True
          else
          begin
            APBm.bmi := 0; //Pointer(0);
            APBm.EOF := False;
          end
        end else
        begin
          APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
          APBm.EOF := False;
        end;
      end else
      begin
        DBGridEh.DataSource.DataSet.Next;
        if DBGridEh.DataSource.DataSet.Eof then
        begin
          APBm.InDS := False;
          APBm.bm := NilBookmarkEh;
          APBm.bmi := -1;
          if (DBGridEh.FooterRowCount = 0)
            then APBm.EOF := True
          else
          begin
            APBm.bmi := 0; //Pointer(0);
            APBm.EOF := False;
          end;
        end else
        begin
          APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
          APBm.EOF := False;
        end
      end
    end
    else
    begin
      if (DBGridEh.FooterRowCount - 1 <= APBm.bmi) then
      begin
        APBm.EOF := True;
        APBm.bmi := 0; //Pointer(0);
        APBm.InDS := False;
      end else
      begin
        APBm.bmi := APBm.bmi + 1;
      end;
    end;
  end;

{  function ComparePolyBookmark(var APBm1,APBm2:TPolyBookmark):Boolean;
  begin
    if (APBm1.bm = APBm2.bm) and (APBm1.InDS = APBm2.InDS) then
      Result := True
    else Result := False;
  end;}

  procedure AddPolyline(const Args: array of const);
  var
    AFrom, i: Integer;
  begin
    AFrom := Length(PolyPolyPoints);
    SetLength(PolyPolyPoints, Length(PolyPolyPoints) + (Length(Args) div 2));
    i := 0;
    while i < (Length(Args) div 2) do
    begin
{$IFDEF CIL}
      PolyPolyPoints[i + AFrom] := Point(Integer(Args[i*2]), Integer(Args[i*2+1]));
{$ELSE}
      PolyPolyPoints[i + AFrom] := Point(Args[i*2].VInteger, Args[i*2+1].VInteger);
{$ENDIF}
      Inc(i);
    end;
    SetLength(PolyLengths, Length(PolyLengths) + 1);
    PolyLengths[Length(PolyLengths)-1] := (High(Args) + 1) div 2;
  end;

  procedure CalcColumnWidths;
  var
    i, w, w1, tw: Integer;
    PM: TPolyBookmark;
    NewBackgrnd: TColor;
    Text: String;
    AAlignment: TAlignment;
    ACursor: TCursor;

    function GetTitleText(Column: TColumnEh): String;
    var i: Integer;
    begin
      if DBGridEh.UseMultiTitle then
        for i := Length(Column.Title.Caption) downto 1 do
          if (Column.Title.Caption[i] = '|') and (ByteType(Column.Title.Caption, i) = mbSingleByte) then
          begin
            Result := Copy(Column.Title.Caption, i, Length(Column.Title.Caption));
            Exit;
          end;
      Result := Column.Title.Caption;
    end;

  begin
    w := 0;
    for i := 0 to PrnColumns.Count - 1 do
    begin
//      PrnColumnWidths.Add(Pointer(Round((PrnColumns[i].Width + 1) * fScaleX)));
      SetLength(PrnColumnWidths, Length(PrnColumnWidths) + 1);
      PrnColumnWidths[Length(PrnColumnWidths)-1] :=
         (Round((PrnColumns[i].Width + 1) * fScaleX));

      Inc(w, Integer(PrnColumnWidths[i]));
    end;

    if (pghOptimalColWidths in Options) then
    begin
      CreateRenderCanvas;
      for i := 0 to PrnColumns.Count - 1 do
      begin
        PrnColumnWidths[i] := 10;
        if (DBGridEh.TitleImages <> nil) and (PrnColumns[i].Title.ImageIndex <> -1) then
          tw := Trunc(DBGridEh.TitleImages.Width * fScaleX) + PSX2 * 2
        else
        begin
          VPrinter_Canvas.Font := PrnColumns[i].Title.Font;
          if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
          tw := GetTextWidth(VPrinter_Canvas, GetTitleText(PrnColumns[i])) + PSX2 * 2;
        end;
        if tw > Integer(PrnColumnWidths[i]) then
          PrnColumnWidths[i] := tw;
      end;
      DBGridEh.DataSource.DataSet.First;
      InitPolyBookmark(PM);
      ACursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      try
        while not PM.Eof do
        begin
          for i := 0 to PrnColumns.Count - 1 do
          begin
            if PM.InDS then //Data
            begin
              case PrnColumns[i].GetColumnType of
                ctCheckboxes: tw := Trunc(FCheckBoxWidth * fScaleX) + PSX2 * 2;
                ctKeyImageList: tw := Trunc(PrnColumns[i].ImageList.Width * fScaleX) + PSX2 * 2;
              else
                VPrinter_Canvas.Font := PrnColumns[i].Font;
                if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;


                NewBackgrnd := clWhite;

                with FColCellParamsEh do
                begin
                  Row := -1;
                  Col := -1;
                  State := [];
                  Font := VPrinter_Canvas.Font;
                  Background := clWhite;
                  Alignment := taLeftJustify;
                  ImageIndex := -1;
                  Text := PrnColumns[i].DisplayText;
                  CheckboxState := PrnColumns[i].CheckboxState;

                  if Assigned(DBGridEh.OnGetCellParams) then
                    DBGridEh.OnGetCellParams(DBGridEh, PrnColumns[i], Font, NewBackgrnd, []);

                  Background := NewBackgrnd;
                  PrnColumns[i].GetColCellParams(False, FColCellParamsEh);

                  tw := GetTextWidth(VPrinter_Canvas, FColCellParamsEh.Text) + PSX2 * 2;
                  if (PrnColumns[i].ImageList <> nil) and PrnColumns[i].ShowImageAndText then
                    Inc(tw, Trunc(PrnColumns[i].ImageList.Width * fScaleX + 4 * fScaleX + fScaleX));
                  if (PrnColumns[i] = DBGridEh.VisibleColumns[0]) and (DBGridEh.GetCellTreeElmentsAreaWidth > 0) then
                    Inc(tw, Trunc(DBGridEh.GetCellTreeElmentsAreaWidth * fScaleX + fScaleX));
                end;
              end;
            end else
            begin //Footer
              VPrinter_Canvas.Font := PrnColumns[i].UsedFooter(PM.bmi).Font;
              if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
              Text := DBGridEh.GetFooterValue(PM.bmi, PrnColumns[i]);
              AAlignment := PrnColumns[i].UsedFooter(PM.bmi).Alignment;
              if Assigned(DBGridEh.OnGetFooterParams) then
                DBGridEh.OnGetFooterParams(DBGridEh, PrnColumns[i].Index, PM.bmi, PrnColumns[i],
                  VPrinter_Canvas.Font, NewBackgrnd, AAlignment, [], Text);
              tw := GetTextWidth(VPrinter_Canvas, Text) + PSX2 * 2;
            end;
            if tw > Integer(PrnColumnWidths[i]) then
              PrnColumnWidths[i] := tw;
          end;
          SetNextPolyBookmark(PM);
        end;
      finally
        Screen.Cursor := ACursor;
      end;
      DBGridEh.DataSource.DataSet.First;
      w := 0;
      for i := 0 to PrnColumns.Count - 1 do
        Inc(w, Integer(PrnColumnWidths[i]));
      FreeRenderCanvas;
    end;

    if ([pghFitingByColWidths, pghFitGridToPageWidth] * Options = [pghFitingByColWidths, pghFitGridToPageWidth]) and
      (w > DataPrintRec.Right - DataPrintRec.Left - PenW) then
    begin
      w1 := 0;
      for i := 0 to PrnColumns.Count - 1 do
      begin
        PrnColumnWidths[i] := MulDiv(Integer(PrnColumnWidths[i]), DataPrintRec.Right - DataPrintRec.Left - PenW, w);
        Inc(w1, Integer(PrnColumnWidths[i]));
      end;
      if w1 > DataPrintRec.Right - DataPrintRec.Left - PenW then
        PrnColumnWidths[PrnColumns.Count - 1] :=
          Integer(PrnColumnWidths[PrnColumns.Count - 1]) -
          w1 + (DataPrintRec.Right - DataPrintRec.Left - PenW);
    end;
  end;

  procedure CalcColsToPages;
  var curX, w: Integer;
    i: Integer;
  begin
    curX := DataPrintRec.Left + PenW;
    // PrnColWIdths.Clear;
    SetLength(PrnColWIdths, 0);
    SetLength(ColsToPages, 0);
    for i := 0 to PrnColumns.Count - 1 do
    begin
      w := Integer(PrnColumnWidths[i]);
      if (w > DataPrintRec.Right - DataPrintRec.Left)
        then w := DataPrintRec.Right - DataPrintRec.Left;
//      PrnColWidths.Add(Pointer(w));
      SetLength(PrnColWidths, Length(PrnColWidths) + 1);
      PrnColWidths[Length(PrnColWidths)-1] := w;
      curX := curX + w;
      if (curX > DataPrintRec.Right) and (i > 0) then
      begin
//        ColsToPages.Add(Pointer(i - 1));
        SetLength(ColsToPages, Length(ColsToPages)+1);
        ColsToPages[Length(ColsToPages)-1] := i - 1;

        curX := DataPrintRec.Left + w + PenW;
      end;
    end;
//    ColsToPages.Add(Pointer(PrnColumns.Count - 1));
    SetLength(ColsToPages, Length(ColsToPages)+1);
    ColsToPages[Length(ColsToPages)-1] := PrnColumns.Count - 1;
  end;

  function GetScaledRealGridWidth: Integer;
  var i: Integer;
  begin
    Result := PenW;
    if DBGridEh.RowPanel then
{$IFDEF CIL}
{$ELSE}
      Result := Result + Round(TDBGridEhCracker(DBGridEh).FGridMasterCellWidth * fScaleX)
{$ENDIF}
    else
      for i := 0 to PrnColumns.Count - 1 do
      begin
        Result := Result + Integer(PrnColumnWidths[i]);
      end;
  end;

  function GetPrintGridWidth: Integer;
  var i: Integer;
  begin
    Result := 0;
    for i := 0 to Length(PrnColWidths) - 1 do
    begin
      Result := Result + Integer(PrnColWidths[i]);
    end;
  end;

  procedure DrawClipped(imList: TCustomImageList;
    ACanvas: TCanvas; ARect: TRect; Index: Integer; Align: TAlignment);
  var CheckedRect, AUnionRect: TRect;
    OldRectRgn, RectRgn: HRGN;
    r, x, y: Integer;
    ImHeight, ImWidth: Integer;
    bm: TBitmap;
{$IFDEF CIL}
    Info: IntPtr;
    BMPInfo: TBitmapInfo;
    InfoSize: DWORD;
    Image: TBytes;
    I: Integer;
{$ELSE}
    Info: PBitmapInfo;
    InfoSize: DWORD;
    Image: Pointer;
{$ENDIF}
    ImageSize: DWORD;
    Bits: HBITMAP;
    DIBWidth, DIBHeight: Longint;
    PrintWidth, PrintHeight: Longint;
    RealRect: TRect;
  begin
    if CalcInfoMode then Exit;
    if (Index < 0) or (Index >= imList.Count) then Exit;
    ImHeight := Trunc(imList.Height * fScaleY);
    ImWidth := Trunc(imList.Width * fScaleX);
    case Align of
      taLeftJustify: x := ARect.Left;
      taRightJustify: x := ARect.Right - ImWidth;
    else
      x := (ARect.Right + ARect.Left - ImWidth) div 2;
    end;
    y := (ARect.Bottom + ARect.Top - ImHeight) div 2;
    CheckedRect := Rect(X, Y, X + ImWidth, Y + ImHeight);
    UnionRect(AUnionRect, CheckedRect, ARect);
    bm := TBitmap.Create;
    r := 0;
    OldRectRgn := 0;
    try
      //imList.BkColor := VPrinter_Canvas.Brush.Color; to avoid ImageListChange event //??? to avoid ImageListChange event
      bm.Canvas.Brush.Color := VPrinter_Canvas.Brush.Color;
      imList.GetBitmap(Index, bm);
      if EqualRect(AUnionRect, ARect) then // ARect containt image
//        VPrinter_Canvas.StretchDraw(CheckedRect,bm)
      else
      begin // Need clip
        OldRectRgn := CreateRectRgn(0, 0, VPrinter.PageWidth, VPrinter.PageHeight);
        r := GetClipRgn(ACanvas.Handle, OldRectRgn);
        RealRect := ARect;
        if (pghFitGridToPageWidth in Options) and (GridWidth > (RealRight - RealLeft)) then
        begin
         // CreateRectRgn don't support viewport
          RealRect.Right := MulDiv(RealRect.Right, RealRight - RealLeft, GridWidth);
          RealRect.Left := MulDiv(RealRect.Left, RealRight - RealLeft, GridWidth);
          RealRect.Top := MulDiv(RealRect.Top, RealRight - RealLeft, GridWidth);
          RealRect.Bottom := MulDiv(RealRect.Bottom, RealRight - RealLeft, GridWidth);
        end;
        RectRgn := CreateRectRgn(RealRect.Left, RealRect.Top, RealRect.Right, RealRect.Bottom);
        SelectClipRgn(ACanvas.Handle, RectRgn);
        DeleteObject(RectRgn);
//        VPrinter_Canvas.StretchDraw(CheckedRect,bm);
//        I have problem with StretchDraw when metafile is based on Printer.Handle
//        I will use StretchDIBits
      end;

      ACanvas.Lock;
      try
        { Paint bitmap to the printer }
        with VPrinter, ACanvas do
        begin
          Bits := bm.Handle;
          GetDIBSizes(Bits, InfoSize, ImageSize);
{$IFDEF CIL}
          Info := Marshal.AllocHGlobal(InfoSize);
          try
            for I := 0 to InfoSize - 1 do
              Marshal.WriteByte(Info, I, 0);
            SetLength(Image, ImageSize);
            GetDIB(Bits, 0, Info, Image);
            BMPInfo := TBitmapInfo(Marshal.PtrToStructure(Info, TypeOf(TBitmapInfo)));
            with BMPInfo.bmiHeader do
            begin
              DIBWidth := biWidth;
              DIBHeight := biHeight;
            end;
            PrintWidth := CheckedRect.Right - CheckedRect.Left;
            PrintHeight := CheckedRect.Bottom - CheckedRect.Top;
            Marshal.StructureToPtr(TObject(BMPInfo), Info, True);
            StretchDIBits(Canvas.Handle, 0, 0, PrintWidth, PrintHeight, 0, 0,
              DIBWidth, DIBHeight, Image, Info, DIB_RGB_COLORS, SRCCOPY);
          finally
            Marshal.FreeHGlobal(Info);
          end;
{$ELSE}
          Info := AllocMem(InfoSize);
          try
            Image := AllocMem(ImageSize);
            try
              GetDIB(Bits, 0, Info^, Image^);
              with Info^.bmiHeader do
              begin
                DIBWidth := biWidth;
                DIBHeight := biHeight;
              end;
              PrintWidth := CheckedRect.Right - CheckedRect.Left;
              PrintHeight := CheckedRect.Bottom - CheckedRect.Top;
              StretchDIBits(Canvas.Handle, CheckedRect.Left, CheckedRect.Top, PrintWidth, PrintHeight, 0, 0,
                DIBWidth, DIBHeight, Image, Info^, DIB_RGB_COLORS, SRCCOPY);
            finally
              FreeMem(Image, ImageSize);
            end;
          finally
            FreeMem(Info, InfoSize);
          end;
{$ENDIF}
        end;
      finally
        ACanvas.Unlock;
      end;

      if not EqualRect(AUnionRect, ARect) then // ARect containt image
      begin
        if r = 0
          then SelectClipRgn(ACanvas.Handle, 0)
          else SelectClipRgn(ACanvas.Handle, OldRectRgn);
        DeleteObject(OldRectRgn);
      end;
    finally
      bm.Free;
    end;
  end;

  function DrawGraphicCell(Canvas: TCanvas; Column: TColumnEh; ARect: TRect;
    Background: TColor; CalcRect: Boolean): Integer;
  var
    R: TRect;
    DrawPict: TPicture;
    Pal: HPalette;
    Stretch: Boolean;
    Center: Boolean;
    XRatio, YRatio: Double;
  begin
    with Canvas do
    begin
      DrawPict := TPicture.Create;
      Pal := 0;
      try
        if Assigned(Column.Field) and Column.Field.IsBlob then
        begin
          DrawPict.Assign(Column.Field);
          if DrawPict.Graphic is TBitmap then
            DrawPict.Bitmap.IgnorePalette := True;
        end;

        Result := DrawPict.Height;
        if DrawPict.Width > Column.Width then
          Result := Round(Result / (DrawPict.Width / Column.Width));
        Result :=  Trunc(Result * fScaleY);
        if CalcRect then Exit;

        Stretch := (Trunc(DrawPict.Width * fScaleY) > (ARect.Right-Arect.Left))
          or (Trunc(DrawPict.Height * fScaleY) > (ARect.Bottom-Arect.Top));
        Center := True;
//        if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
//          FillRect(ARect)
//        else
        if Stretch then
        begin
          XRatio := Trunc(DrawPict.Width * fScaleY) / (ARect.Right-Arect.Left);
          YRatio := Trunc(DrawPict.Height * fScaleY) / (ARect.Bottom-Arect.Top);
          R := ARect;
          if XRatio > YRatio then
          begin
            R.Bottom := Arect.Top + Round(Trunc(DrawPict.Height * fScaleY) / XRatio);
          end else
          begin
            R.Right := ARect.Left + Round(Trunc(DrawPict.Width * fScaleY) / YRatio);
          end;
        end else
        begin
          SetRect(R, ARect.Left, Arect.Top,
            ARect.Left + Trunc(DrawPict.Width  * fScaleY),
            Arect.Top + Trunc(DrawPict.Height * fScaleY));
        end;

        if Center then OffsetRect(R,
          (ARect.Right - Arect.Left - (R.Right-R.Left)) div 2,
          (ARect.Bottom - Arect.Top - (R.Bottom-R.Top)) div 2);
//        FillRect(ARect);
        StretchDraw(R, DrawPict.Graphic);
//        RectRgn := ExcludeClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
//        SelectClipRgn(Handle, 0);
      finally
        if Pal <> 0 then SelectPalette(Handle, Pal, True);
        DrawPict.Free;
      end;
    end;
  end;

  procedure DrawTreeArea(Canvas: TCanvas; ARect: TRect);

    procedure DrawOneTreeElement(Canvas: TCanvas; ARect: TRect; TreeElement: TTreeElementEh);
    begin
      Canvas.FillRect(ARect);
      DrawTreeElement(Canvas, ARect, TreeElement, False, fScaleX, fScaleY, False);
//        (DefaultRowHeight mod 2 = 1) and (TopRow mod 2 = 1));
    end;

  var
    ARect1: TRect;
    i: Integer;
    IntMemTable: IMemTableEh;
  begin
    if DBGridEh.TryUseMemTableInt and (DBGridEh.DataSource <> nil) and
      (DBGridEh.DataSource.DataSet <> nil) and (DBGridEh.FooterRowCount = 0) and
      Supports(DBGridEh.DataSource.DataSet, IMemTableEh, IntMemTable)
    then
      ARect1 := ARect
    else
      Exit;
    ARect1.Right := ARect1.Left + Trunc(18 * fScaleX);
    for i := 1 to IntMemTable.GetTreeNodeLevel-1 do
    begin
      if IntMemTable.ParentHasNextSibling(i)
        then DrawOneTreeElement(Canvas, ARect1, tehVLine)
        else Canvas.FillRect(ARect1);
      ARect1.Left := ARect1.Left + Trunc(18 * fScaleX);
      ARect1.Right := ARect1.Left + Trunc(18 * fScaleX);
    end;
    if IntMemTable.GetTreeNodeHasChields then
      if IntMemTable.ParentHasNextSibling(IntMemTable.GetTreeNodeLevel)
      then
        if IntMemTable.GetTreeNodeExpanded
          then DrawOneTreeElement(Canvas, ARect1, tehMinusUpDown)
          else DrawOneTreeElement(Canvas, ARect1, tehPlusUpDown)
      else
        if IntMemTable.GetTreeNodeExpanded
          then DrawOneTreeElement(Canvas, ARect1, tehMinusUp)
          else DrawOneTreeElement(Canvas, ARect1, tehPlusUp)
    else
      if IntMemTable.ParentHasNextSibling(IntMemTable.GetTreeNodeLevel)
        then DrawOneTreeElement(Canvas, ARect1, tehCrossUpDown)
        else DrawOneTreeElement(Canvas, ARect1, tehCrossUp);
    ARect.Left := ARect1.Right;
  end;

  procedure SetIfNeedFitWidthMapMode;
  var dc, IsoMode: Integer;
  begin
    if GridWidth > (RealRight - RealLeft) then
    begin
      if fLogPelsX2 = fLogPelsY2
        then IsoMode := MM_ISOTROPIC
        else IsoMode := MM_ANISOTROPIC;
      dc := SetMapMode(VPrinter_Canvas.Handle, IsoMode);
      if (dc = 0)
        then Raise Exception.Create(' function SetMapMode(Handle, MM_ISOTROPIC) has returned 0 ');
      SetWindowOrgEx(VPrinter_Canvas.Handle, 0, 0, nil);
      SetWindowExtEx(VPrinter_Canvas.Handle, GridWidth, Trunc(GridWidth * fLogPelsX2 / fLogPelsY2), nil);
      SetViewportExtEx(VPrinter_Canvas.Handle, RealRight - RealLeft, Trunc((RealRight - RealLeft) * fLogPelsX2 / fLogPelsY2), nil);
    end;
  end;

  procedure CalcFitedDataRect;
  begin
    if (pghFitGridToPageWidth in Options) then
    begin // On width of page
      GridWidth := GetScaledRealGridWidth;
      RealRight := DataPrintRec.Right; RealLeft := DataPrintRec.Left;
      SetIfNeedFitWidthMapMode;

      if GridWidth > (RealRight - RealLeft) then
      begin
        DataPrintRec.Right := MulDiv(DataPrintRec.Right, GridWidth, RealRight - RealLeft); // Оставить поле старого размера
        DataPrintRec.Left := MulDiv(DataPrintRec.Left, GridWidth, RealRight - RealLeft);
        DataPrintRec.Top := MulDiv(DataPrintRec.Top, GridWidth, RealRight - RealLeft);
        DataPrintRec.Bottom := MulDiv(DataPrintRec.Bottom, GridWidth, RealRight - RealLeft);
      end;
    end;
  end;

  function PrintPageColontitle(ARect: TRect; IsHeader, CalcHeight: Boolean): Integer;
  var pc: TPageColontitle;
    h, lm: Integer;
    Lay: TTextLayout;

    function ExtractMacro(s: STring): String;
    var i: Integer;
    begin
      Result := s;
      MacroValues[0] := IntToStr(VPrinter.PageNumber);
      for i := 0 to High(Macros) do
        Result := StringReplaceMacros(Result, Macros[i], MacroValues[i], [rfReplaceAll, rfIgnoreCase], '&');
    end;
  begin
    Result := 0; h := 0;
    //if not CalcHeight then VPrinter_Canvas.Rectangle(ARect.Left,ARect.Top,ARect.Right,ARect.Bottom);
    if IsHeader
      then begin pc := PageHeader; Lay := tlTop; end
      else begin pc := PageFooter; Lay := tlBottom; end;

    VPrinter_Canvas.Font := pc.Font;
    if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
    if (pc.LeftText.Text <> '') then
      Result := WriteTextEh(VPrinter_Canvas, ARect, False, 0, 0, ExtractMacro(GetStingListText(pc.LeftText)),
        taLeftJustify, Lay, False, False, 0, 0, CalcHeight or CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    if (pc.CenterText.Text <> '') then
      h := WriteTextEh(VPrinter_Canvas, ARect, False, 0, 0, ExtractMacro(GetStingListText(pc.CenterText)),
        taCenter, Lay, False, False, 0, 0, CalcHeight or CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    if (Result < h) then Result := h;
    if (pc.RightText.Text <> '') then
      h := WriteTextEh(VPrinter_Canvas, ARect, False, 0, 0, ExtractMacro(GetStingListText(pc.RightText)),
        taRightJustify, Lay, False, False, 0, 0, CalcHeight or CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    if (Result < h) then Result := h;

    if Result <> 0 then Inc(Result, Trunc(fLogPelsY2 / 20));

    if (pc.LineType <> pcltNon)
      then lm := Trunc(fLogPelsY2 / 20) else lm := 0;
    if (pc.LineType = pcltDoubleLine) then
    begin
      if not CalcHeight then
        if IsHeader then
        begin
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Bottom - Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Bottom - Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Bottom - Trunc(fLogPelsY2 / 20) - Trunc(fLogPelsY2 / 30));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Bottom - Trunc(fLogPelsY2 / 20) - Trunc(fLogPelsY2 / 30));
        end else
        begin
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Top + Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Top + Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Top + Trunc(fLogPelsY2 / 20) + Trunc(fLogPelsY2 / 30));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Top + Trunc(fLogPelsY2 / 20) + Trunc(fLogPelsY2 / 30));
        end;
      Inc(lm, Trunc(fLogPelsY2 / 30));
    end else if (pc.LineType = pcltSingleLine) then
      if not CalcHeight then
        if IsHeader then
        begin
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Bottom - Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Bottom - Trunc(fLogPelsY2 / 20));
        end else
        begin
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Top + Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Top + Trunc(fLogPelsY2 / 20));
        end;
    Inc(Result, lm);
  end;

  procedure SetPen;
  const
    FlatPenStyle = PS_Geometric or PS_Solid or PS_ENDCAP_SQUARE or PS_JOIN_MITER;
  var
    LogBrush: TLOGBRUSH;
  begin
    LogBrush.lbStyle := BS_Solid;
    LogBrush.lbColor := VPrinter_Canvas.Pen.Color;
    LogBrush.lbHatch := 0;
    VPrinter_Canvas.Pen.Handle := ExtCreatePen(FlatPenStyle, VPrinter_Canvas.Pen.Width, LogBrush, 0, nil);
  end;

  procedure ResetPrinterCanvas;
  begin
    VPrinter_Canvas.Pen.Width := PenW;
    VPrinter_Canvas.BRUSH.Style := bsClear;
    SetPen;
    VPrinter_Canvas.Brush.Color := clWhite;
    VPrinter_Canvas.Font := DBGridEh.Font;
    if (pghFitGridToPageWidth in Options) then SetIfNeedFitWidthMapMode;
  end;

  procedure VPrinter_NewPage;
  begin
    if CalcInfoMode then
    begin
      Inc(PageCount);
      ResetPrinterCanvas;
    end else
    begin
      VPrinter.NewPage;
      VPrinter_Canvas := VPrinter.Canvas;
      ResetPrinterCanvas;
      PrintPageColontitle(TitleRect, True, False);
      PrintPageColontitle(FooterRect, False, False);
    end;
  end;

  //--------------------------
  procedure CalcDeviceCaps;
  var Diver: Double;
  begin
//     fPrnPhysOffSetX := GetDeviceCaps(VPrinter_Canvas.Handle,PHYSICALOFFSETX);
    fPrnPhysOffSetX := (VPrinter.FullPageWidth - VPrinter.PageWidth) div 2;
//     fPrnPhysOffSetY := GetDeviceCaps(VPrinter_Canvas.Handle,PHYSICALOFFSETY);
    fPrnPhysOffSetY := (VPrinter.FullPageHeight - VPrinter.PageHeight) div 2;

     //fPrnHorsRes :=  GetDeviceCaps(VPrinter_Canvas.Handle,HORZRES);
    fPrnHorsRes := VPrinter.PageWidth;
     //fPrnVertRes :=  GetDeviceCaps(VPrinter_Canvas.Handle,VERTRES);
    fPrnVertRes := VPrinter.PageHeight;

    fLogPelsX1 := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);
    fLogPelsY1 := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSY);

    if VPrinter.Printers.Count > 0 then
    begin
      fLogPelsX2 := GetDeviceCaps(VPrinter.Handle, LOGPIXELSX);
      fLogPelsY2 := GetDeviceCaps(VPrinter.Handle, LOGPIXELSY);
    end else begin
      fLogPelsX2 := DefaultPrinterPixelsPerInchX;
      fLogPelsY2 := DefaultPrinterPixelsPerInchY;
    end;

    if (fLogPelsX1 > fLogPelsX2) then
      fScaleX := (fLogPelsX1 / fLogPelsX2)
    else
      fScaleX := (fLogPelsX2 / fLogPelsX1);

    if (fLogPelsY1 > fLogPelsY2) then
      fScaleY := (fLogPelsY1 / fLogPelsY2)
    else
      fScaleY := (fLogPelsY2 / fLogPelsY1);

    if Units = MM then Diver := 2.54 else Diver := 1;
    DataPrintRec.Left := Round(fLogPelsX2 * Page.LeftMargin / Diver) - fPrnPhysOffSetX;
    DataPrintRec.Top := Round(fLogPelsY2 * Page.TopMargin / Diver) - fPrnPhysOffSetY;
    DataPrintRec.Right := fPrnHorsRes - Round(fLogPelsX2 * Page.RightMargin / Diver) + fPrnPhysOffSetX;
    DataPrintRec.Bottom := fPrnVertRes - Round(fLogPelsY2 * Page.BottomMargin / Diver) + fPrnPhysOffSetY;

    PSX1 := Round(fScaleX); PSX2 := Round(fScaleX * 2);

    if DBGridEh.Flat then
    begin
      PSY1 := Round(fScaleY / 2); PSY2 := Round(fScaleY)
    end else
    begin
      PSY1 := Round(fScaleY); PSY2 := Round(fScaleY * 2);
    end;

    PenW := Trunc((fLogPelsX2 + fLogPelsY2) / 200); // PenWidth = 0.01 Inche

     //if (PenW mod 2 = 0) then Inc(PenW);           // Must be uneven

     {TopFooterPos := DataPrintRec.Bottom - Round(fLogPelsX2 / 4);  // 1/4 дюйма
     DataPrintRec.Bottom := TopFooterPos - 1;

     TopHeaderPos := DataPrintRec.Top;
     DataPrintRec.Top := DataPrintRec.Top + Round(fLogPelsX2 / 4) + 1; //  Header (TopHeaderPos, DataPrintRec.Top - 1)
     }
  end;

  function GetFooterValue(Row, Col: Integer): String;
  var
    FmtStr: string;
    Format: TFloatFormat;
    Digits: Integer;
    v: Variant;
    Field: TField;
    Footer: TColumnFooterEh;
  begin
    Result := '';
    //\\\
    Footer := PrnColumns[Col].UsedFooter(Row);
    case Footer.ValueType of
      fvtSum:
        begin
          if Footer.FieldName <> '' then
            Field := DBGridEh.DataSource.DataSet.FindField(Footer.FieldName)
          else
            Field := DBGridEh.DataSource.DataSet.FindField(PrnColumns[Col].FieldName);
          if Field = nil then Exit;
          with Field do
          begin
            v := FooterValues[Row * PrnColumns.Count + Col];
            case DataType of
              ftSmallint, ftInteger, ftAutoInc, ftWord:
                if Footer.DisplayFormat <> '' then
                  Result := FormatFloat(Footer.DisplayFormat, v)
                else with Field as TIntegerField do
                begin
                  FmtStr := DisplayFormat;
                  if FmtStr = ''
                    then Result := IntToStr(Integer(v))
                    else Result := FormatFloat(FmtStr, v);
                end;
              ftBCD:
                if Footer.DisplayFormat <> '' then
                  Result := FormatFloat(Footer.DisplayFormat, v)
                else with Field as TBCDField do
                begin
                //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                  FmtStr := DisplayFormat;
                  if FmtStr = '' then
                  begin
                    if Currency then
                    begin
                      Format := ffCurrency;
                      Digits := CurrencyDecimals;
                    end
                    else
                    begin
                      Format := ffGeneral;
                      Digits := 0;
                    end;
                    Result := CurrToStrF(v, Format, Digits);
                  end else
                    Result := FormatCurr(FmtStr, v);
                end;
{$IFDEF EH_LIB_6}
              ftFMTBcd:
                if Footer.DisplayFormat <> '' then
                  Result := FormatFloat(Footer.DisplayFormat, v)
                else with Field as TFMTBCDField do
                begin
                //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                  FmtStr := DisplayFormat;
                  if FmtStr = '' then
                  begin
                    if Currency then
                    begin
                      Format := ffCurrency;
                      Digits := CurrencyDecimals;
                    end
                    else
                    begin
                      Format := ffGeneral;
                      Digits := 0;
                    end;
                    Result := CurrToStrF(v, Format, Digits);
                  end else
                    Result := FormatCurr(FmtStr, v);
                end;
{$ENDIF}
              ftFloat, ftCurrency:
                if Footer.DisplayFormat <> '' then
                  Result := FormatFloat(Footer.DisplayFormat, v)
                else with Field as TFloatField do
                begin
               //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                  FmtStr := DisplayFormat;
                  if FmtStr = '' then
                  begin
                    if Currency then
                    begin
                      Format := ffCurrency;
                      Digits := CurrencyDecimals;
                    end
                    else begin
                      Format := ffGeneral;
                      Digits := 0;
                    end;
                    Result := FloatToStrF(v, Format, Precision, Digits);
                  end else
                    Result := FormatFloat(FmtStr, v);
                end;
            end;
          end;
        end;
      fvtCount:
        if Footer.DisplayFormat <> '' then
          Result := FormatFloat(Footer.DisplayFormat, FooterValues[Row * PrnColumns.Count + Col])
        else
          Result := FloatToStr(FooterValues[Row * PrnColumns.Count + Col]);
    end;
  end;

  function CheckColumnDuplicateValues(Column: TColumnEh; DataRow: Integer; s: String): Boolean;
  var
    ABackground: TColor;
    AIndex: Integer;
  begin
    Result := False;

    Column.FillColCellParams(FVarColCellParamsEh);
    with FVarColCellParamsEh do
    begin
      Col := Column.Index + DBGridEh.IndicatorOffset;
      Row := DataRow;
      ABackground := Background;
      if Assigned(DBGridEh.OnGetCellParams) then
        DBGridEh.OnGetCellParams(DBGridEh, Column, Font, ABackground, State);
      Column.GetColCellParams(False, FColCellParamsEh);
      AIndex := FLastRowTexts.IndexOfObject(Column);
      if (AIndex >= 0) and (FLastRowTexts[AIndex] = FVarColCellParamsEh.Text) then
        Result := True;
    end;
  end;

  function DrawCell(ACol: Integer; ARect: TRect; var APBmFrom: TPolyBookmark;
    CalcRect: Boolean; DataPageRow: Integer): Integer;
  const
    CheckBoxFlags: array[TCheckBoxState] of Integer =
    (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED, DFCS_BUTTON3STATE or DFCS_CHECKED);
  var
    CurColumn: TColumnEh;
    NewBackgrnd: TColor;
    AAlignment: TAlignment;
    Value: String;
    bm: TBitmap;
    dr, ARect1: TRect;
    oldColor, ABackground: TColor;
    Stretch: Boolean;
    Footer: TColumnFooterEh;
    ImageHeight: Integer;
    AIndex: Integer;
    AOldText: String;
  begin
    Result := 0;
    ImageHeight := 0;
    CurColumn := PrnColumns[ACol];
    NewBackgrnd := clWhite;
    ARect1 := ARect;
    Inc(ARect.Left, PSX2); Inc(ARect.Top, PSY2);
    Dec(ARect.Right, PSX2); Dec(ARect.Bottom, PSY2);
    if CalcRect
      then Stretch := pghRowAutoStretch in Options
      else Stretch := AWordWrap;
    if DBGridEh.RowPanel then
      Stretch := CurColumn.WordWrap and (CurColumn.InRowLineHeight > 1);

    if APBmFrom.InDS then
    begin // data cell
      if DBGridEh.RowPanel and CalcRect then
      begin
{$IFDEF CIL}
{$ELSE}
        Result := Round(TDBGridEhCracker(DBGridEh).FGridMasterCellHeight * fScaleX);
{$ENDIF}
        Exit;
      end;

      if pghColored in Options then NewBackgrnd := CurColumn.Color;

      VPrinter_Canvas.Font := CurColumn.Font;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;

      CurColumn.FillColCellParams(FColCellParamsEh);
//      FColCellParamsEh.Font := VPrinter_Canvas.Font;
      with FColCellParamsEh do
      begin
        Font := VPrinter_Canvas.Font;
        ABackground := NewBackgrnd;
        if Assigned(DBGridEh.OnGetCellParams) then
          DBGridEh.OnGetCellParams(DBGridEh, CurColumn, Font, ABackground, State);
        Background := ABackground;
      end;
      CurColumn.GetColCellParams(False, FColCellParamsEh);
      VPrinter_Canvas.Brush.Color := FColCellParamsEh.Background;

      if not CalcRect and CurColumn.HideDuplicates then
      begin
        AOldText := FColCellParamsEh.Text;
        if (DataPageRow <> 0) and
          CheckColumnDuplicateValues(CurColumn, DataPageRow, FColCellParamsEh.Text) then
        begin
          FColCellParamsEh.Text := '';
          FColCellParamsEh.ImageIndex := -1;
        end;
        AIndex := FLastRowTexts.IndexOfObject(CurColumn);
        if (AIndex < 0)
          then FLastRowTexts.AddObject(AOldText, CurColumn)
          else FLastRowTexts[AIndex] := AOldText;
      end;

      if not CalcRect and (VPrinter_Canvas.Brush.Color <> clWhite) and not CalcInfoMode then
      begin
        oldColor := VPrinter_Canvas.Pen.Color;
        VPrinter_Canvas.Pen.Color := VPrinter_Canvas.Brush.Color;
//        SetPen;
        VPrinter_Canvas.Rectangle(ARect1.Left, ARect1.Top, ARect1.Right, ARect1.Bottom);
        VPrinter_Canvas.Pen.Color := oldColor;
      end;

      if (CurColumn = DBGridEh.VisibleColumns[0]) and (DBGridEh.GetCellTreeElmentsAreaWidth > 0) then
      begin
        ARect1 := ARect;
        ARect1.Right := Trunc(ARect1.Left + DBGridEh.GetCellTreeElmentsAreaWidth * fScaleX);
        if not CalcRect then
          DrawTreeArea(VPrinter_Canvas, ARect1);
        ARect.Left := Trunc(ARect1.Right + fScaleX);
      end;

      if (CurColumn.ImageList <> nil) and CurColumn.ShowImageAndText then
      begin
        ARect1 := ARect;
        ARect1.Right := Trunc(ARect1.Left + CurColumn.ImageList.Width * fScaleY + 4 * fScaleY);
        if pghColored in Options then
          VPrinter_Canvas.Brush.Color := CurColumn.Color;
//        VPrinter_Canvas.FillRect(ARect);                            //FColCellParamsEh????
        if CalcRect then
          ImageHeight := Trunc(CurColumn.ImageList.Height * fScaleY + 4 * fScaleY)
        else
          DrawClipped(CurColumn.ImageList, VPrinter_Canvas, ARect1, FColCellParamsEh.ImageIndex, taCenter);
        if pghColored in Options then
          VPrinter_Canvas.Brush.Color := FColCellParamsEh.Background;
        ARect.Left := Trunc(ARect1.Right + fScaleY);
      end;

      if (CurColumn.GetColumnType = ctCheckboxes) and not CalcRect and not CalcInfoMode then
      begin
        dr.Left := ARect.Left + iif(ARect.Right - ARect.Left < Trunc(FCheckBoxWidth * fScaleX), 0,
          (ARect.Right - ARect.Left) shr 1 - Trunc(FCheckBoxWidth * fScaleX) shr 1);
        dr.Right := iif(ARect.Right - ARect.Left < Trunc(FCheckBoxWidth * fScaleX), ARect.Right,
          dr.Left + Trunc(FCheckBoxWidth * fScaleX));
        dr.Top := ARect.Top + iif(ARect.Bottom - ARect.Top < Trunc(FCheckBoxHeight * fScaleY), 0,
          (ARect.Bottom - ARect.Top) shr 1 - Trunc(FCheckBoxHeight * fScaleY) shr 1);
        dr.Bottom := iif(ARect.Bottom - ARect.Top < Trunc(FCheckBoxHeight * fScaleY), ARect.Bottom,
          dr.Top + Trunc(FCheckBoxHeight * fScaleY));
        DrawFrameControl(VPrinter_Canvas.Handle, dr, DFC_BUTTON, CheckBoxFlags[FColCellParamsEh.CheckboxState]);
      end else
        if (CurColumn.GetColumnType = ctKeyImageList) and not CalcRect then
        begin
          bm := TBitmap.Create;
        //oldColor := CurColumn.ImageList.BkColor;
        //CurColumn.ImageList.BkColor := VPrinter_Canvas.Brush.Color; to avoid ImageListChange event //??? to avoid ImageListChange event
          try
            CurColumn.ImageList.GetBitmap(FColCellParamsEh.ImageIndex, bm);
          finally
          //CurColumn.ImageList.BkColor := oldColor; to avoid ImageListChange event //??? to avoid ImageListChange event
          end;
          dr := Rect(0, 0, Trunc(CurColumn.ImageList.Height * fScaleY), Trunc(CurColumn.ImageList.Width * fScaleX));
          dr.Left := ARect.Left + (ARect.Right - ARect.Left) div 2 - dr.Right div 2;
          dr.Right := dr.Right + dr.Left;
          dr.Top := ARect.Top + (ARect.Bottom - ARect.Top) div 2 - dr.Bottom div 2;
          dr.Bottom := dr.Bottom + dr.Top;
        //VPrinter_Canvas.StretchDraw(dr,bm);
          DrawClipped(CurColumn.ImageList, VPrinter_Canvas, ARect1, FColCellParamsEh.ImageIndex, taCenter);
          bm.Free;
        end else if DBGridEh.DrawGraphicData and (CurColumn.GetColumnType = ctGraphicData)
        then
          Result := DrawGraphicCell(VPrinter_Canvas, CurColumn, ARect, VPrinter_Canvas.Brush.Color, CalcRect)
        else
        begin
          Result := WriteTextEh(VPrinter_Canvas, ARect, False, 0, 0, FColCellParamsEh.Text,
            FColCellParamsEh.Alignment, CurColumn.Layout, Stretch, CurColumn.EndEllipsis, 0, 0,
            CalcRect or CalcInfoMode, DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading) + PSY2 * 2;
          if ImageHeight > Result then
            Result := ImageHeight;
        end;
    end else
    begin // footer cell
      if APBmFrom.bmi < 0 then Exit;
      Footer := CurColumn.UsedFooter(APBmFrom.bmi);
      AAlignment := Footer.Alignment;
      if Footer.ValueType in [fvtSum, fvtCount]
        then Value := GetFooterValue(APBmFrom.bmi, ACol)
        else Value := DBGridEh.GetFooterValue(APBmFrom.bmi, CurColumn);

      if pghColored in Options
        then NewBackgrnd := Footer.Color;
      VPrinter_Canvas.Font := Footer.Font;
      if (PrintFontName <> '')
        then VPrinter_Canvas.Font.Name := PrintFontName;

      if Assigned(DBGridEh.OnGetFooterParams) then
        DBGridEh.OnGetFooterParams(DBGridEh, CurColumn.Index, APBmFrom.bmi,
          CurColumn, VPrinter_Canvas.Font, NewBackgrnd, AAlignment, [], Value);
      VPrinter_Canvas.Brush.Color := NewBackgrnd;

      if not CalcRect and (VPrinter_Canvas.Brush.Color <> clWhite) and not CalcInfoMode then
      begin
        oldColor := VPrinter_Canvas.Pen.Color;
        VPrinter_Canvas.Pen.Color := VPrinter_Canvas.Brush.Color;
//        SetPen;
        VPrinter_Canvas.Rectangle(ARect1.Left, ARect1.Top, ARect1.Right, ARect1.Bottom);
        VPrinter_Canvas.Pen.Color := oldColor;
      end;

      Result := WriteTextEh(VPrinter_Canvas, ARect, False, 0, 0, Value,
        AAlignment, CurColumn.Layout, Stretch, Footer.EndEllipsis, 0, 0,
        CalcRect or CalcInfoMode, DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading) + PSY2 * 2;
    end;
  end;

  procedure CalcFooterValues;
  var i, j: Integer;
    Field: TField;
    Footer: TColumnFooterEh;
  begin
    for i := 0 to DBGridEh.FooterRowCount - 1 do
      for j := 0 to PrnColumns.Count - 1 do
      begin
        Footer := PrnColumns[j].UsedFooter(i);
        if Footer.FieldName <> ''
          then Field := DBGridEh.DataSource.DataSet.FindField(Footer.FieldName)
          else Field := DBGridEh.DataSource.DataSet.FindField(PrnColumns[j].FieldName);
        if Field = nil then Continue;
        case Footer.ValueType of
          fvtSum:
            if (Field.IsNull = False) then
              FooterValues[i * PrnColumns.Count + j] := FooterValues[i * PrnColumns.Count + j] + Field.AsFloat;
          fvtCount:
            FooterValues[i * PrnColumns.Count + j] := FooterValues[i * PrnColumns.Count + j] + 1;
        end;
      end;
  end;

  function CalcPrintRows(APBmFrom: TPolyBookmark; PrnTop, PrnBottom: Integer): TPolyBookmark;
  var
    i, rh, ch, cPos, hLimit, AStep: Integer;
    r: TRect;
  begin
//    PrnRowHeights.Clear;
    SetLength(PrnRowHeights, 0);
    GotoPolyBookmark(APBmFrom);
    Result := APBmFrom;
    cPos := PrnTop;
    hLimit := PrnBottom;
    AStep := 0;
    while True do
    begin
      ch := 0;
      for i := 0 to PrnColumns.Count - 1 do
      begin
        SetRect(r, 0, 0, 0, 0);
        r.Right := Integer(PrnColWIdths[i]);
        rh := DrawCell(i, r, APBmFrom, True, -1);
        if ch < rh then ch := rh;
      end;

      if ch < MinRowHeight then ch := MinRowHeight;
      Inc(cPos, ch);
      if ((cPos > hLimit) or APBmFrom.EOF) and (AStep <> 0) then
      begin
        Result := APBmFrom;
        Exit;
      end;
      if APBmFrom.InDS then CalcFooterValues;
      Result := APBmFrom;
      SetNextPolyBookmark(APBmFrom);
//      PrnRowHeights.Add(Pointer(ch));
      SetLength(PrnRowHeights, Length(PrnRowHeights)+1);
      if cPos > hLimit then
        ch := ch - (cPos - hLimit);
      PrnRowHeights[Length(PrnRowHeights)-1] := ch;
      Inc(AStep);
    end;
  end;

  procedure PrintGridTitleTextHeight(FromCol, ToCol: Integer);
  var
    r: TRect;
    i, lm, rm, tm: Integer;
  begin
    r := Rect(DataPrintRec.Left,
              DataPrintRec.Top - PrnTitlEh - PrnTitleTextH + PrintOffset,
              DataPrintRec.Left,
              DataPrintRec.Top - PrnTitlEh + PrintOffset);

    if DBGridEh.RowPanel then
{$IFDEF CIL}
{$ELSE}
      Inc(r.Right, Round(TDBGridEhCracker(DBGridEh).FGridMasterCellWidth * fScaleX))
{$ENDIF}
    else
      for i := FromCol to ToCol do Inc(r.Right, Integer(PrnColWidths[i]));

    if (Title.Text <> '') then begin
      VPrinter_Canvas.Font := DBGridEh.TitleFont;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
      r := Rect(DataPrintRec.Left, DataPrintRec.Top - PrnTitlEh - PrnTitleTextH + PrintOffset, r.Right, DataPrintRec.Top - PrnTitlEh + PrintOffset);
      lm := PSX2; // if FromCol = 0 then lm := PSX2 else lm := 0;
      rm := PSX2; //if ToCol = DBGridEh.VisibleColumns.Count-1 then rm := PSX2 else  rm := 0;
      for i := 0 to FromCol - 1 do
        Dec(lm, Integer(PrnColWidths[i]));
      for i := ToCol + 1 to PrnColumns.Count - 1 do
        Dec(rm, Integer(PrnColWidths[i]));
      if DBGridEh.UseMultiTitle
        then tm := Round(DBGridEh.VTitleMargin * fScaleY / 2) else tm := PSY2;
      if pghColored in Options
        then VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor;
      if DBGridEh.UseRightToLeftAlignment then
        OffsetRect(r, (DataPrintRec.Right + DataPrintRec.Left) - (r.Left + r.Right), 0);
      WriteTextEh(VPrinter_Canvas, r, pghColored in Options, 0, tm, GetStingListText(Title),
        taCenter, tlTop, True, False, lm, rm, CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
      AddPolyline([r.Left, r.Bottom, r.Left, r.Top, r.Right, r.Top, r.Right, r.Bottom]);
    end;
  end;

  procedure PrintSimpleTitle(FromCol, ToCol: Integer);
  var r, r1: TRect;
    i: Integer;
    s: String;
  begin
    r := Rect(DataPrintRec.Left, DataPrintRec.Top - PrnTitlEh + PrintOffset, DataPrintRec.Left, DataPrintRec.Top + PrintOffset);

    for i := FromCol to ToCol do
    begin
      Inc(r.Right, Integer(PrnColWidths[i]));
      VPrinter_Canvas.Font := PrnColumns[i].Title.Font;
      if (PrintFontName <> '')
        then VPrinter_Canvas.Font.Name := PrintFontName;
      if pghColored in Options
        then VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor;
      if (DBGridEh.TitleImages <> nil) and
        (PrnColumns[i].Title.ImageIndex <> -1)
        then s := ''
        else s := PrnColumns[i].Title.Caption;
      r1 := r;
      if DBGridEh.UseRightToLeftAlignment then
        OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

      if PrnColumns[i].Title.Orientation = tohVertical then
        WriteTextVerticalEh(VPrinter_Canvas, r1, False, PSX2, PSY2 + PSY2,
          s, PrnColumns[i].Title.Alignment, tlBottom, False, CalcInfoMode)
      else
        WriteTextEh(VPrinter_Canvas, r1, pghColored in Options, PSX2, PSY2, s,
          PrnColumns[i].Title.Alignment, tlTop, False,
          PrnColumns[i].Title.EndEllipsis, 0, 0, CalcInfoMode,
          DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
      if (DBGridEh.TitleImages <> nil) and
        (PrnColumns[i].Title.ImageIndex <> -1) then
        with PrnColumns[i].Title do
          DrawClipped(DBGridEh.TitleImages, VPrinter_Canvas, r1, ImageIndex, Alignment);

      AddPolyline([r1.Left, r1.Bottom, r1.Right, r1.Bottom, r1.Right, r1.Top]);
      r.Left := r.Right;
    end;
    r.Left := DataPrintRec.Left;

    r1 := r;
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

    AddPolyline([r1.Left, r1.Bottom, r1.Left, r1.Top, r1.Right, r1.Top]);
    PrintGridTitleTextHeight(FromCol, ToCol);
  end;

  procedure PrintMultyTitle(FromCol, ToCol: Integer);
  var i, RightSide: Integer;
    r, r1: TRect;
    lpDTP: TDrawTextParams;
    s: String;
    PLeftTop, PRightTop, PRightLow: TPoint;

    function GetColNumByVisColNum(AVisColNum: Integer): Integer;
    //var i:Integer;
    begin
      //Result := -1; i := 0;
      Result := PrnColumns[AVisColNum].Index;
      {while not DBGridEh.Columns[i].Visible do
        Inc(i);
      for i := i to DBGridEh.Columns.Count-1 do
      begin
        if DBGridEh.Columns[i].Visible then
          Inc(Result);
        if Result = AVisColNum then
        begin
          Result := i;
          Break;
        end;
      end;}
    end;

    procedure PrintTitleRecurs(ANode: THeadTreeNode; ARect: TRect);
    var r, r1: TRect;
      s: String;
      lx, rx, xx: Integer;
      an, nn: THeadTreeNode;
      lpDTP: TDrawTextParams;
    begin
      if (ANode.Host.Host = nil) then Exit;
      s := ANode.Host.Text;
      lx := -(ARect.Left - DataPrintRec.Left);
      r.Bottom := ARect.Top;
      r.Top := r.Bottom - ANode.Host.HeightPrn;
      an := ANode; nn := ANode.Host.Child;
      while an <> nn do // move before Child onward
      begin
        Inc(lx, nn.WidthPrn);
        nn := nn.Next;
      end;
      if (lx > 0) then
      begin
        r.Left := DataPrintRec.Left;
        xx := ANode.Host.WidthPrn - lx + DataPrintRec.Left;
      end else
      begin
        r.Left := ARect.Left;
        xx := ANode.Host.WidthPrn + ARect.Left;
        lx := 0;
      end;

      if (xx > RightSide) then
      begin
        rx := xx - RightSide;
        xx := RightSide;
      end else
      begin
        rx := 0;
      end;
      r.Right := xx;

      r1 := r;

      if DBGridEh.UseRightToLeftAlignment then
        OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

      AddPolyline([r1.Left, r1.Top, r1.Left, r1.Bottom, r1.Right, r1.Bottom]);

      if PRightTop.y > r.Top then
      begin
        PRightTop.y := r.Top;
        PLeftTop.y := PRightTop.y;
      end;

      r1.Top := r1.Top;

      lpDTP.cbSize := SizeOf(lpDTP);
      lpDTP.uiLengthDrawn := Length(s);
      lpDTP.iLeftMargin := 0; //lx;
      lpDTP.iRightMargin := 0; //rx;

      Dec(r.Left, lx); Inc(r.Right, rx);

      VPrinter_Canvas.Font := DBGridEh.TitleFont;
      if (PrintFontName <> '')
        then VPrinter_Canvas.Font.Name := PrintFontName;
      if pghColored in Options
        then VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor;
      WriteTextEh(VPrinter_Canvas, r1, pghColored in Options, 0, PSY1, s,
        taCenter, tlCenter, true, False, -lx + PSX2, -rx + PSX2, CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);

      if (i = GetColNumByVisColNum(FromCol)) or (ANode.Host.Host.Child = ANode.Host) then
        PrintTitleRecurs(ANode.Host, r);
    end;

  begin
    PRightTop.y := DataPrintRec.Top + PrintOffset;

    RightSide := DataPrintRec.Left;
    for i := GetColNumByVisColNum(FromCol) to GetColNumByVisColNum(ToCol) do begin
      Inc(RightSide, DBGridEh.LeafFieldArr[i].FLeaf.WidthPrn);
    end;

    r.Left := DataPrintRec.Left;
    for i := GetColNumByVisColNum(FromCol) to GetColNumByVisColNum(ToCol) do
    begin
      r.Bottom := DataPrintRec.Top + PrintOffset;
      r.Top := r.Bottom - DBGridEh.LeafFieldArr[i].FLeaf.HeightPrn;
      r.Left := r.Left;
      r.Right := r.Left + DBGridEh.LeafFieldArr[i].FLeaf.WidthPrn; // Round(FLeafFieldArr[i].FLeaf.Width * fScaleX);
      s := DBGridEh.LeafFieldArr[i].FLeaf.Text;
      if (DBGridEh.TitleImages <> nil) and
        (DBGridEh.Columns[i].Title.ImageIndex <> -1)
        then s := '';

      r1 := r;
      if DBGridEh.UseRightToLeftAlignment then
        OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

      AddPolyline([r1.Left, r1.Top, r1.Left, r1.Bottom, r1.Right, r1.Bottom]);

      if i = GetColNumByVisColNum(ToCol) then
      begin
        PRightTop.x := r.Right;
        PRightLow.x := PRightTop.x;
      end;
      if PRightTop.y > r.Top then
      begin
        PRightTop.y := r.Top;
        PLeftTop.y := PRightTop.y;
      end;

      lpDTP.cbSize := SizeOf(lpDTP);
      lpDTP.uiLengthDrawn := Length(s);
      lpDTP.iLeftMargin := 0; //lx;
      lpDTP.iRightMargin := 0; //rx;

      VPrinter_Canvas.Font := DBGridEh.Columns[i].Title.Font;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;

      if pghColored in Options
        then VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor
        else VPrinter_Canvas.Brush.Color := clWhite;

      if DBGridEh.Columns[i].Title.Orientation = tohVertical then
        WriteTextVerticalEh(VPrinter_Canvas, r1, False, 0, PSY1 + PSY2,
          s, taCenter, tlBottom, False, CalcInfoMode)
      else
        WriteTextEh(VPrinter_Canvas, r1, pghColored in Options, 0, PSY1, s,
          taCenter, tlCenter, true, False, PSX2, PSX2, CalcInfoMode,
          DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);

      if (DBGridEh.TitleImages <> nil) and (DBGridEh.Columns[i].Title.ImageIndex <> -1) then
        DrawClipped(DBGridEh.TitleImages, VPrinter_Canvas, r1,
          DBGridEh.Columns[i].Title.ImageIndex, taCenter);

      if (i = GetColNumByVisColNum(FromCol)) or
        (DBGridEh.LeafFieldArr[i].FLeaf.Host.Child = DBGridEh.LeafFieldArr[i].FLeaf) then
        PrintTitleRecurs(DBGridEh.LeafFieldArr[i].FLeaf, r);

      r.Left := r.Right;
    end;

    // Draw an upper line of the headline and the most shift to the right.
    PLeftTop.x := DataPrintRec.Left;
    PRightLow.y := DataPrintRec.Top + PrintOffset;

    r1.Left := PLeftTop.x;
    r1.Top := PLeftTop.y;
    r1.Right := PRightLow.x;
    r1.Bottom := PRightLow.y;
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

    AddPolyline([r1.Left, r1.Top, r1.Right, r1.Top, r1.Right, r1.Bottom]);
     //AddPolyline([PLeftTop.x,PLeftTop.y, PRightTop.x,PRightTop.y, PRightLow.x,PRightLow.y]);

    PrintGridTitleTextHeight(FromCol, ToCol);

  end;

  function DrawRowsRange(var APBmFrom, APBMTo: TPolyBookmark): Integer;
  var
    pgs, FromCol, ToCol, i, j: Integer;
    ARect, ARect1: TRect;
    CurPBm: TPolyBookmark;
  begin
    FromCol := 0;
    Result := 0;
    for pgs := 0 to Length(ColsToPages) - 1 do
    begin
      if VPrinter.Aborted then Abort;
      if FirstPage
        then FirstPage := False
        else VPrinter_NewPage;
//        VPrinter.NewPage;
//      PolyPolyPoints.Clear; PolyLengths.Clear;
      SetLength(PolyPolyPoints, 0); SetLength(PolyLengths, 0);
//      ResetPrinterCanvas;
      ToCol := Integer(ColsToPages[pgs]);
      GotoPolyBookmark(APBmFrom);
      CurPBm := APBmFrom;
      ARect.Top := DataPrintRec.Top + PrintOffset;
      ARect.Bottom := ARect.Top;
      j := 0;
//      PrintPageColontitle(TitleRect,True,False);
//      PrintPageColontitle(FooterRect,False,False);
      if DBGridEh.UseMultiTitle
        then PrintMultyTitle(FromCol, ToCol)
        else PrintSimpleTitle(FromCol, ToCol);
      while True do
      begin
        ARect.Left := DataPrintRec.Left; ARect.Right := ARect.Left;
        if Length(PrnRowHeights) = 0 then Break;
        Inc(ARect.Bottom, Integer(PrnRowHeights[j]));
        for i := FromCol to ToCol do
        begin
          Inc(ARect.Right, Integer(PrnColWIdths[i]));
          ARect1 := ARect;
          if DBGridEh.UseRightToLeftAlignment then
            OffsetRect(ARect1, (DataPrintRec.Right + DataPrintRec.Left) - (ARect.Left + ARect.Right), 0);
          DrawCell(i, ARect1, CurPBm, False, j);
          if ((i = FromCol) and not DBGridEh.UseRightToLeftAlignment) or
            ((i = ToCol) and DBGridEh.UseRightToLeftAlignment) then
            AddPolyline([ARect1.Left, ARect1.Top, ARect1.Left, ARect1.Bottom, ARect1.Right, ARect1.Bottom, ARect1.Right, ARect1.Top])
          else
            AddPolyline([ARect1.Left, ARect1.Bottom, ARect1.Right, ARect1.Bottom, ARect1.Right, ARect1.Top]);
          ARect.Left := ARect.Right;
          if not CalcInfoMode then
            Application.ProcessMessages;
        end;
        //if ComparePolyBookMark(CurPBm,APBMTo) then Break;
        Result := ARect.Bottom - PrintRec.Top;
        if Length(PrnRowHeights) - 1 = j then Break;

        SetNextPolyBookmark(CurPBm);
        Inc(j);
        ARect.Top := ARect.Bottom;
      end;
      if not CalcInfoMode then
//        PolyPolyline(VPrinter_Canvas.Handle, PolyPolyPoints.List^, PolyLengths.List^, PolyLengths.Count);
{$IFDEF CIL}
        PolyPolyline(VPrinter_Canvas.Handle, PolyPolyPoints, PolyLengths, Length(PolyLengths));
{$ELSE}
        PolyPolyline(VPrinter_Canvas.Handle, Pointer(PolyPolyPoints)^, Pointer(PolyLengths)^, Length(PolyLengths));
{$ENDIF}
      FromCol := ToCol + 1;
    end;
  end;

  function GetGridTitleTextHeight: Integer;
  var r: Trect;
    tm: Integer;
  begin
    if (Title.Text <> '') then
    begin
      VPrinter_Canvas.Font := DBGridEh.TitleFont;
      if (PrintFontName <> '')
        then VPrinter_Canvas.Font.Name := PrintFontName;
      r := Rect(0, 0, GetPrintGridWidth, 0);
      if DBGridEh.UseMultiTitle
        then tm := Round(DBGridEh.VTitleMargin * fScaleY / 2)
        else tm := PSY2;
      Result := WriteTextEh(VPrinter_Canvas, r, False, PSX2, tm,
        GetStingListText(Title), taCenter, tlCenter, True, False, 0, 0, True,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    end else
      Result := 0;
  end;

  function SetPrnChildTreeHeight(ANode: THeadTreeNode): Integer;
  var htLast: THeadTreeNode;
    newh, maxh, th: Integer;
    rec: TRect;
    DefaultRowHeight: Integer;
    s: String;
  begin
    DefaultRowHeight := 0;
    Result := 0;

    if (ANode.Child = nil) then Exit;
    htLast := ANode.Child;
    if htLast.Column <> nil
      then VPrinter_Canvas.Font := htLast.Column.Title.Font
      else VPrinter_Canvas.Font := DBGridEh.TitleFont;
    if (PrintFontName <> '')
      then VPrinter_Canvas.Font.Name := PrintFontName;
    maxh := 0;
    if (htLast.Child <> nil) then
      maxh := SetPrnChildTreeHeight(htLast);

    rec := Rect(0, 0, Round(htLast.WidthPrn) - Round(fScaleX * 4), DefaultRowHeight);
    s := htLast.Text;
    if s = '' then s := ' ';
    if (htLast.Column <> nil) and (htLast.Column.Title.Orientation = tohVertical) then
      th := WriteTextVerticalEh(VPrinter_Canvas, rec, False, 0, 0, s, taLeftJustify,
        tlBottom, False, True) + Round(4 * fScaleY)
    else
      th := DrawTextEh(VPrinter_Canvas.Handle, s,
        Length(s), rec, DT_WORDBREAK or DT_CALCRECT or DT_EXPANDTABS or DT_NOPREFIX)
        + Round(DBGridEh.VTitleMargin * fScaleY);
    if (th > DefaultRowHeight)
      then maxh := maxh + th
      else maxh := maxh + DefaultRowHeight;

    while True do
    begin
      if (ANode.Child = htLast.Next) then begin break; end;
      htLast := htLast.Next;
      newh := 0;
      if (htLast.Child <> nil) then
        newh := SetPrnChildTreeHeight(htLast);
      rec := Rect(0, 0, Round(htLast.WidthPrn) - Round(fScaleX * 4), DefaultRowHeight);
      s := htLast.Text;
      if s = '' then s := ' ';
      if htLast.Column <> nil then
        VPrinter_Canvas.Font := htLast.Column.Title.Font;
      if (htLast.Column <> nil) and (htLast.Column.Title.Orientation = tohVertical) then
        th := WriteTextVerticalEh(VPrinter_Canvas, rec, False, 0, 0, s,
          taLeftJustify, tlBottom, False, True) + Round(4 * fScaleY)
      else
        th := DrawTextEh(VPrinter_Canvas.Handle, s,
          Length(s), rec, DT_WORDBREAK or DT_CALCRECT or DT_EXPANDTABS or DT_NOPREFIX) +
          Round(DBGridEh.VTitleMargin * fScaleY);
      if (th > DefaultRowHeight)
        then newh := newh + th
        else newh := newh + DefaultRowHeight;

      if (maxh < newh) then maxh := newh;
    end;

    htLast := ANode.Child;
    while ANode.Child <> htLast.Next do
    begin
      if (htLast.Child = nil)
        then htLast.HeightPrn := maxh
        else htLast.HeightPrn := maxh - htLast.HeightPrn;
      htLast := htLast.Next;
    end;
    if (htLast.Child = nil)
      then htLast.HeightPrn := maxh
      else htLast.HeightPrn := maxh - htLast.HeightPrn;

    ANode.HeightPrn := maxh; //сохраняем высоту ChildTree в Хосте
    Result := maxh;
  end;

  procedure SetPrnTreeWidth;
  var i, j: Integer;

    function SetPrnTreeWidthRecurs(AHost: THeadTreeNode): Integer;
    var an, nn: THeadTreeNode;
      w: Integer;
    begin
      w := 0;
      Result := AHost.WidthPrn;
      if (AHost.Child = nil) then Exit;
      an := AHost.Child;
      nn := an;
      while True do
      begin
        Inc(w, SetPrnTreeWidthRecurs(nn));
        nn := nn.Next;
        if (nn = an) then Break;
      end;
      AHost.WidthPrn := w;
      Result := w;
    end;

  begin
    j := 0;
    for i := 0 to DBGridEh.Columns.Count - 1 do
    begin
      if PrnColumns.IndexOf(DBGridEh.Columns[i]) <> -1 then
      begin
        DBGridEh.LeafFieldArr[i].FLeaf.WidthPrn := Integer(PrnColWidths[j]);
        Inc(j);
      end
      else
        DBGridEh.LeafFieldArr[i].FLeaf.WidthPrn := 0;
    end;
    SetPrnTreeWidthRecurs(DBGridEh.HeadTree);
  end;

  function GetSimpleTitleHeight: Integer;
  var i, H, K, J: Integer;
    tm: TTEXTMETRIC;
    FInterlinear: Integer;
  begin
    Result := 0;
    if DBGridEh.RowPanel then
    begin
{$IFDEF CIL}
{$ELSE}
      Result := Round(TDBGridEhCracker(DBGridEh).FGridMasterCellHeight * fScaleX);
{$ENDIF}
      Exit;
    end;
    for i := 0 to PrnColumns.Count - 1 do
    begin
      VPrinter_Canvas.Font := PrnColumns[i].Title.Font;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
      H := VPrinter_Canvas.TextHeight('Wg') + PSY2 * 2;
      if H > Result then Result := H;
    end;
    if Result = 0 then
    begin
      VPrinter_Canvas.Font := DBGridEh.TitleFont;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
      Result := VPrinter_Canvas.TextHeight('Wg') + PSY2 * 2;
    end;

    if (DBGridEh.TitleHeight <> 0) or (DBGridEh.TitleLines <> 0) then
    begin
      if DBGridEh.Flat then FInterlinear := PSY2 else FInterlinear := Round(4 * fScaleY);
      K := 0;
      for I := 0 to PrnColumns.Count - 1 do
      begin
        VPrinter_Canvas.Font := PrnColumns[I].Title.Font;
        J := VPrinter_Canvas.TextHeight('Wg') + Round(FInterlinear * fScaleY);
        if J > K then begin K := J; GetTextMetrics(VPrinter_Canvas.Handle, tm); end;
      end;
      if K = 0 then
      begin
        VPrinter_Canvas.Font := DBGridEh.TitleFont;
        GetTextMetrics(VPrinter_Canvas.Handle, tm);
      end;

      Result := tm.tmExternalLeading + tm.tmHeight * DBGridEh.TitleLines + PSY2 +
        Round(DBGridEh.TitleHeight * fScaleY);

      if dgRowLines in DBGridEh.Options then
        Result := Result + PSY1;
    end;

  end;

  function CalcMinRowHeight: Integer;
  var tm: TTEXTMETRIC;
  begin
    VPrinter_Canvas.Font := DBGridEh.Font;
    if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
    GetTextMetrics(VPrinter_Canvas.Handle, tm);
    if (DBGridEh.RowHeight = 0) and (DBGridEh.RowLines = 0) then
      Result := VPrinter_Canvas.TextHeight('Wg') + PSY2 * 2
    else
      Result := (tm.tmExternalLeading + tm.tmHeight) * DBGridEh.RowLines + Round(DBGridEh.RowHeight * fScaleY);
    AWordWrap := (Result > tm.tmExternalLeading + tm.tmHeight + PSY2 * 2) or (pghRowAutoStretch in Options);
  end;

  procedure CreatePrnColumnsList;
  var i: Integer;
  begin
    PrnColumns := TColumnsEhList.Create;
    with DBGridEh do
      case Selection.SelectionType of
        gstNon, gstAll, gstRecordBookmarks:
          for i := 0 to VisibleColumns.Count - 1 do
            PrnColumns.Add(VisibleColumns[i]);
        gstColumns:
          for i := 0 to Selection.Columns.Count - 1 do
            PrnColumns.Add(Selection.Columns[i]);
        gstRectangle:
          for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
            if Columns[i].Visible then
              PrnColumns.Add(Columns[i]);
      end;
  end;

  procedure PrintRichText(Strings: TRichEditStrings);
  var
    Range: TFormatRange;
    LastChar, MaxLen, LogX, LogY: Integer;
    SaveRect: TRect;
    RangeMode: Integer;
{$IFDEF EH_LIB_12}
    TextLen: TGetTextLengthEx;
{$ENDIF}

    function ScaleRect(ARect: TRect; XMul, YMul, XDiv, YDiv: Integer): TRect;
    begin
      Result.Left := ARect.Left * XMul div XDiv;
      Result.Right := ARect.Right * XMul div XDiv;
      Result.Top := ARect.Top * YMul div YDiv;
      Result.Bottom := ARect.Bottom * YMul div YDiv;
    end;

  begin
    if Strings.Count = 0 then Exit;
    if CalcInfoMode then RangeMode := 0 else RangeMode := 1;
{ TODO -cCheck : What to do }
{$IFNDEF CIL}
    FillChar(Range, SizeOf(TFormatRange), 0);
{$ENDIF}
    with VPrinter, Range do
    begin
      hdc := Canvas.Handle; // Canvas.Handle;
      hdcTarget := 0; //hdc;
//      LogX := GetDeviceCaps(Handle, LOGPIXELSX);
//      LogY := GetDeviceCaps(Handle, LOGPIXELSY);
      LogX := PixelsPerInchX;
      LogY := PixelsPerInchY;
      if IsRectEmpty(Strings.RichEdit.PageRect) then
      begin
        SaveRect := ScaleRect(PrintRec, 1440, 1440, LogX, LogY);
      end
      else begin
        rc.left := Strings.RichEdit.PageRect.Left * 1440 div LogX;
        rc.top := Strings.RichEdit.PageRect.Top * 1440 div LogY;
        rc.right := Strings.RichEdit.PageRect.Right * 1440 div LogX;
        rc.bottom := Strings.RichEdit.PageRect.Bottom * 1440 div LogY;
      end;
      LastChar := 0;


{$IFDEF EH_LIB_12}
      // retrieve number of characters in rich edit control
      TextLen.Flags := GTL_NUMCHARS;
      TextLen.CodePage := 1200;  // Unicode
      MaxLen := SendMessage(Strings.RichEdit.Handle,
                              EM_GETTEXTLENGTHEX, LPARAM(@TextLen), 0);
{$ELSE}
      MaxLen := Strings.RichEdit.GetTextLen;
{$ENDIF}

      chrg.cpMax := -1;
      // ensure printer DC is in text map mode
      //OldMap := SetMapMode(hdc, MM_TEXT);
      SendMessage(Strings.RichEdit.Handle, EM_FORMATRANGE, 0, 0); // flush buffer
      try
        repeat
          rc := SaveRect;
          Inc(rc.Top, PrintOffset * 1440 div LogY);
          rcPage := rc;
          chrg.cpMin := LastChar;
          hdc := Canvas.Handle; // Canvas.Handle;
{ TODO : When printer is not installed we get error. }
          hdcTarget := Handle; //hdc;
//          LastChar := SendMessage(Strings.RichEdit.Handle, EM_FORMATRANGE, RangeMode, Longint(@Range));
          LastChar := SendStructMessage(Strings.RichEdit.Handle, EM_FORMATRANGE, RangeMode, Range);
          if LastChar = 0 then Break;
          rc := ScaleRect(rc, LogX, LogY, 1440, 1440);
          PrintOffset := rc.Bottom - rc.Top;
          if (LastChar < MaxLen) and (LastChar <> -1) then
          begin
//            PrintPageColontitle(TitleRect,True,False);
//            PrintPageColontitle(FooterRect,False,False);
//            NewPage;
            VPrinter_NewPage;
            PrintOffset := 0;
//            ResetPrinterCanvas;
          end;
        until (LastChar >= MaxLen) or (LastChar = -1);
//        EndDoc;
      finally
        SendMessage(Strings.RichEdit.Handle, EM_FORMATRANGE, 0, 0); // flush buffer
       // SetMapMode(hdc, OldMap);       // restore previous map mode
      end;
    end;
  end;

  procedure SetSubstituting;
  var i: Integer;
  begin
    for i := 0 to FSubstitutesNames.Count - 1 do
    begin
      GridTextReplace(BeforeGridText, FSubstitutesNames[i], FSubstitutesValues[i], 0, -1, [], True);
      GridTextReplace(AfterGridText, FSubstitutesNames[i], FSubstitutesValues[i], 0, -1, [], True);
    end;
  end;

  function RequireTwoPass: Boolean;
  begin
    Result := Pos('&[Pages]', PageHeader.LeftText.Text) <> 0;
    if not Result then
      Result := Pos('&[Pages]', PageHeader.CenterText.Text) <> 0;
    if not Result then
      Result := Pos('&[Pages]', PageHeader.RightText.Text) <> 0;

    if not Result then
      Result := Pos('&[Pages]', PageFooter.LeftText.Text) <> 0;
    if not Result then
      Result := Pos('&[Pages]', PageFooter.CenterText.Text) <> 0;
    if not Result then
      Result := Pos('&[Pages]', PageFooter.RightText.Text) <> 0;
  end;

  procedure DrawTitleCell(Column: TColumnEh; CellRect: TRect);
  var
    s: String;
    r1: TRect;
  begin
    VPrinter_Canvas.Font := Column.Title.Font;
    if (PrintFontName <> '')
      then VPrinter_Canvas.Font.Name := PrintFontName;
    if pghColored in Options
      then VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor;
    if (DBGridEh.TitleImages <> nil) and
      (Column.Title.ImageIndex <> -1)
      then s := ''
      else s := Column.Title.Caption;
    r1 := CellRect;
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

    if Column.Title.Orientation = tohVertical then
      WriteTextVerticalEh(VPrinter_Canvas, r1, False, PSX2, PSY2 + PSY2,
        s, Column.Title.Alignment, tlBottom, False, CalcInfoMode)
    else
      WriteTextEh(VPrinter_Canvas, r1, pghColored in Options, PSX2, PSY2, s,
        Column.Title.Alignment, tlTop, False,
        Column.Title.EndEllipsis, 0, 0, CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    if (DBGridEh.TitleImages <> nil) and
      (Column.Title.ImageIndex <> -1) then
      with Column.Title do
        DrawClipped(DBGridEh.TitleImages, VPrinter_Canvas, r1, ImageIndex, Alignment);

    AddPolyline([CellRect.Left, CellRect.Bottom,
                CellRect.Right, CellRect.Bottom,
                CellRect.Right, CellRect.Top]);

  end;

  procedure PrintPanelTitle(FromPos, ToPos: Integer);
  var
    r, r1: TRect;
    i: Integer;
    CellRect: TRect;
    Col: TColumnEh;
    MasterColWidth: Integer;
  begin
{$IFDEF CIL}
{$ELSE}
    MasterColWidth := Round(TDBGridEhCracker(DBGridEh).FGridMasterCellWidth * fScaleX);
{$ENDIF}
    r := Rect(DataPrintRec.Left, DataPrintRec.Top - PrnTitlEh + PrintOffset, DataPrintRec.Left, DataPrintRec.Top + PrintOffset);

    for i := 0 to DBGridEh.Columns.Count-1 do
    begin
      Col := DBGridEh.Columns[i];
      CellRect := Rect(Col.RowPlacement.Left, Col.RowPlacement.Top,
        Col.RowPlacement.Left + Col.RowPlacement.Width,
        Col.RowPlacement.Top + Col.RowPlacement.Height);
      CellRect.Left := Round(CellRect.Left * fScaleX) + r.Left;
      CellRect.Top := Round(CellRect.Top * fScaleX) + r.Top;
      CellRect.Bottom := Round(CellRect.Bottom * fScaleX) + r.Top;
      CellRect.Right := Round(CellRect.Right * fScaleX) + r.Left;

      DrawTitleCell(Col, CellRect);

    end;

//    r1 := r;
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

    r.Right := r.Left + MasterColWidth;
{$IFDEF CIL}
{$ELSE}
    r.Bottom := r.Top + Round(TDBGridEhCracker(DBGridEh).FGridMasterCellHeight * fScaleX);
{$ENDIF}
    AddPolyline([r.Left, r.Bottom,
                 r.Left, r.Top,
                 r.Right, r.Top,
                 r.Right, r.Bottom,
                 r.Left, r.Bottom
                 ]);
    PrintGridTitleTextHeight(0, DBGridEh.Columns.Count-1);
  end;

  function DrawRowsRangePanel(var APBmFrom, APBMTo: TPolyBookmark): Integer;
  var
    pgs, i, j: Integer;
//    FromCol, ToCol,
    ARect{, ARect1}: TRect;
    CurPBm: TPolyBookmark;
    CellRect: TRect;
    Col: TColumnEh;
//    MasterColWidth: Integer;
  begin
//    FromCol := 0;
    Result := 0;
//    MasterColWidth := Round(DBGridEh.Columns[0].Width * fScaleX);
    for pgs := 0 to 0 do
    begin
      if VPrinter.Aborted then Abort;
      if FirstPage
        then FirstPage := False
        else VPrinter_NewPage;
      SetLength(PolyPolyPoints, 0); SetLength(PolyLengths, 0);

//      ToCol := Integer(ColsToPages[pgs]);
      GotoPolyBookmark(APBmFrom);
      CurPBm := APBmFrom;
      ARect.Top := DataPrintRec.Top + PrintOffset;
      ARect.Bottom := ARect.Top;
      j := 0;

      PrintPanelTitle(0,0);

      while True do
      begin
        ARect.Left := DataPrintRec.Left;
{$IFDEF CIL}
{$ELSE}
        ARect.Right := ARect.Left + Round(TDBGridEhCracker(DBGridEh).FGridMasterCellWidth * fScaleX);
        Inc(ARect.Bottom, Round(TDBGridEhCracker(DBGridEh).FGridMasterCellHeight * fScaleX));
{$ENDIF}
//        if Length(PrnRowHeights) = 0 then Break;
//        Inc(ARect.Bottom, Integer(PrnRowHeights[j]));

        for i := 0 to DBGridEh.Columns.Count-1 do
        begin
          Col := DBGridEh.Columns[i];
          CellRect := Rect(Col.RowPlacement.Left, Col.RowPlacement.Top,
            Col.RowPlacement.Left + Col.RowPlacement.Width,
            Col.RowPlacement.Top + Col.RowPlacement.Height);
          CellRect.Left := Round(CellRect.Left * fScaleX) + ARect.Left;
          CellRect.Top := Round(CellRect.Top * fScaleX) + ARect.Top;
          CellRect.Bottom := Round(CellRect.Bottom * fScaleX) + ARect.Top;
          CellRect.Right := Round(CellRect.Right * fScaleX) + ARect.Left;

//          DrawTitleCell(Col, CellRect);
          DrawCell(i, CellRect, CurPBm, False, j);
          AddPolyline([{CellRect.Left, CellRect.Top,}
                       CellRect.Left, CellRect.Bottom,
                       CellRect.Right, CellRect.Bottom,
                       CellRect.Right, CellRect.Top]);
          if CellRect.Left = ARect.Left then
            AddPolyline([CellRect.Left, CellRect.Top, CellRect.Left, CellRect.Bottom]);

          if not CalcInfoMode then
            Application.ProcessMessages;

        end;

{        for i := FromCol to ToCol do
        begin
          Inc(ARect.Right, Integer(PrnColWIdths[i]));
          ARect1 := ARect;
          if DBGridEh.UseRightToLeftAlignment then
            OffsetRect(ARect1, (DataPrintRec.Right + DataPrintRec.Left) - (ARect.Left + ARect.Right), 0);
          DrawCell(i, ARect1, CurPBm, False, j);
          if ((i = FromCol) and not DBGridEh.UseRightToLeftAlignment) or
            ((i = ToCol) and DBGridEh.UseRightToLeftAlignment) then
            AddPolyline([ARect1.Left, ARect1.Top, ARect1.Left, ARect1.Bottom, ARect1.Right, ARect1.Bottom, ARect1.Right, ARect1.Top])
          else
            AddPolyline([ARect1.Left, ARect1.Bottom, ARect1.Right, ARect1.Bottom, ARect1.Right, ARect1.Top]);
          ARect.Left := ARect.Right;
          if not CalcInfoMode then
            Application.ProcessMessages;
        end;
}

        //if ComparePolyBookMark(CurPBm,APBMTo) then Break;
        Result := ARect.Bottom - PrintRec.Top;
        if Length(PrnRowHeights) - 1 = j then Break;

        SetNextPolyBookmark(CurPBm);
        Inc(j);
        ARect.Top := ARect.Bottom;
      end;
      if not CalcInfoMode then
//        PolyPolyline(VPrinter_Canvas.Handle, PolyPolyPoints.List^, PolyLengths.List^, PolyLengths.Count);
{$IFDEF CIL}
        PolyPolyline(VPrinter_Canvas.Handle, PolyPolyPoints, PolyLengths, Length(PolyLengths));
{$ELSE}
        PolyPolyline(VPrinter_Canvas.Handle, Pointer(PolyPolyPoints)^, Pointer(PolyLengths)^, Length(PolyLengths));
{$ENDIF}
//      FromCol := ToCol + 1;
    end;
  end;

  procedure PrintOutInfo;
  begin
    PrintRichText(TRichEditStrings(BeforeGridText));
    if PrintOffset >= DataPrintRec.Bottom - DataPrintRec.Top then
    begin
      VPrinter_NewPage;
      PrintOffset := 0;
    end;

    InitPolyBookmark(PBm1);
    while True do begin
      PBm2 := CalcPrintRows(PBm1, DataPrintRec.Top + PrintOffset, DataPrintRec.Bottom);
      if DBGridEh.RowPanel
        then PrintOffset := DrawRowsRangePanel(PBm1, PBm2) + PenW
        else PrintOffset := DrawRowsRange(PBm1, PBm2) + PenW;
      if (PBm2.EOF = True)
        then Break
      else PrintOffset := 0;
      PBm1 := PBm2;
    end;

    VPrinter_Canvas.BRUSH.Style := bsClear;
    VPrinter_Canvas.Brush.Color := clWhite;

    PrintRichText(TRichEditStrings(AfterGridText));
  end;

  procedure ClearFooterValues;
  var
    i: Integer;
  begin
    for i := 0 to Length(FooterValues)-1 do
    FooterValues[i] := 0;
  end;

begin
  FSubstituted := False;
  FooterValues := nil;
  PrnColumns := nil;
  PrnColumnWidths := nil;
  BeforeGridTextStream := nil;
  AfterGridTextStream := nil;
  RenderMetafie := nil;
  RenderCanvas := nil;
  FVarColCellParamsEh := nil;
  FLastRowTexts := nil;
  PrintOffset := 0;
  PageCount := 1;
  CalcInfoMode := False;
  if not Assigned(DBGridEh) or
    not Assigned(DBGridEh.DataSource) or
    not Assigned(DBGridEh.DataSource.DataSet) or
    not DBGridEh.DataSource.DataSet.Active then Exit;

  InitMacroValues;
  ColsToPages := nil; PrnRowHeights := nil; PrnColWIdths := nil;
  PolyPolyPoints := nil; PolyLengths := nil;

  CreatePrnColumnsList;
//  PrnColumnWidths := TList.Create;
  SetLength(PrnColumnWidths, 0);
//  FooterValues := AllocMem(SizeOf(Currency) * PrnColumns.Count * DBGridEh.FooterRowCount);
  SetLength(FooterValues, PrnColumns.Count * DBGridEh.FooterRowCount);
  VPrinter.BeginDoc;
  VPrinter_Canvas := VPrinter.Canvas;
  FirstPage := True;
  SavedBookMark := DBGridEh.DataSource.DataSet.Bookmark;
  if Assigned(OnBeforePrint) then OnBeforePrint(Self);
  try
    FVarColCellParamsEh := TColCellParamsEh.Create;
    FLastRowTexts := TStringList.Create;

    if FSubstitutesNames <> nil then //Substituting
    begin
      if BeforeGridText.Count > 0 then
      begin
        BeforeGridTextStream := TMemoryStream.Create;
        BeforeGridText.SaveToStream(BeforeGridTextStream);
      end;
      if AfterGridText.Count > 0 then
      begin
        AfterGridTextStream := TMemoryStream.Create;
        AfterGridText.SaveToStream(AfterGridTextStream);
      end;
      SetSubstituting;
      FSubstituted := True;
    end;

    DBGridEh.DataSource.DataSet.DisableControls;
    DBGridEh.DataSource.DataSet.First;

//    ColsToPages := TList.Create;
//    PrnRowHeights := TList.Create;
//    PrnColWIdths := TList.Create;
//    PolyPolyPoints := TList.Create;
//    PolyLengths := TList.Create;

    VPrinter.Title := STabularInformationEh;
    VPrinter_Canvas.Brush.Style := bsClear;
    VPrinter_Canvas.Brush.Color := clWhite;
    VPrinter_Canvas.Font := DBGridEh.Font;
    if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;

    CalcDeviceCaps;
    CalcColumnWidths;
    CalcFitedDataRect;
    CalcColsToPages;
    ResetPrinterCanvas;

    TitleRect := Rect(DataPrintRec.Left, DataPrintRec.Top, DataPrintRec.Right, DataPrintRec.Top);
    Inc(TitleRect.Bottom, PrintPageColontitle(TitleRect, True, True));
    Inc(DataPrintRec.Top, TitleRect.Bottom - DataPrintRec.Top);

    FooterRect := Rect(DataPrintRec.Left, DataPrintRec.Bottom, DataPrintRec.Right, DataPrintRec.Bottom);
    Dec(FooterRect.Top, PrintPageColontitle(FooterRect, False, True));
    Dec(DataPrintRec.Bottom, FooterRect.Bottom - FooterRect.Top);


    PrintRec := DataPrintRec;
   {VPrinter_Canvas.Brush.Color := clRed;
   VPrinter_Canvas.FillRect(Rect(0,0,VPrinter.PageWidth,VPrinter.PageHeight));}
    MinRowHeight := CalcMinRowHeight;
   //FromRow := 0; PageNo := 1;

    if DBGridEh.IsUseMultiTitle then
    begin
      SetPrnTreeWidth;
      PrnTitlEh := SetPrnChildTreeHeight(DBGridEh.HeadTree);
    end else
      PrnTitlEh := GetSimpleTitleHeight;
    PrnTitleTextH := GetGridTitleTextHeight;
    Inc(DataPrintRec.Top, PrnTitlEh + PrnTitleTextH);

    if RequireTwoPass then
    begin
      CalcInfoMode := True;

      ACursor := Screen.Cursor;
      try
        Screen.Cursor := crHourGlass;
        CreateRenderCanvas;

        PrintOutInfo;

      finally
        Screen.Cursor := ACursor;
        FreeRenderCanvas;
      end;

      InitMacroValues;
      CalcInfoMode := False;
      FirstPage := True;
      PrintOffset := 0;
      DBGridEh.DataSource.DataSet.First;
{ TODO -cCheck : Dinamic array automaticaly zeroize}
//      FillChar(FooterValues^, SizeOf(Currency) * PrnColumns.Count * DBGridEh.FooterRowCount, 0);
      ClearFooterValues;
    end;

    PrintPageColontitle(TitleRect, True, False);
    PrintPageColontitle(FooterRect, False, False);

    PrintOutInfo;

  finally
    if Assigned(OnAfterPrint) then OnAfterPrint(Self);
    if FSubstituted then
    begin
      if BeforeGridTextStream <> nil then
      begin
        BeforeGridTextStream.Position := 0;
        BeforeGridText.LoadFromStream(BeforeGridTextStream);
        BeforeGridTextStream.Free;
      end;
      if AfterGridTextStream <> nil then
      begin
        AfterGridTextStream.Position := 0;
        AfterGridText.LoadFromStream(AfterGridTextStream);
        AfterGridTextStream.Free;
      end;
    end;
    DBGridEh.DataSource.DataSet.Bookmark := SavedBookMark;
    DBGridEh.DataSource.DataSet.EnableControls;
    VPrinter.EndDoc;
//    ColsToPages.Free;
//    PrnRowHeights.Free;
//    PrnColWIdths.Free;
//    PolyPolyPoints.Free;
//    PolyLengths.Free;
//    PrnColumnWidths.Free;
//    if FooterValues <> nil then FreeMem(FooterValues);
    PrnColumns.Free;
    FVarColCellParamsEh.Free;
    FLastRowTexts.Free;
    FreeRenderCanvas;
  end;
end;


procedure TPrintDBGridEh.Print;
begin
  PrintTo(VirtualPrinter);
end;

procedure TPrintDBGridEh.SetDBGridEh(const Value: TDBGridEh);
begin
  if Value <> FDBGridEh then
  begin
    FDBGridEh := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TPrintDBGridEh.SetOptions(const Value: TPrintDBGridEhOptions);
begin
  FOptions := Value;
end;

procedure TPrintDBGridEh.SetPage(const Value: TPageParams);
begin
  FPage := Value;
end;

procedure TPrintDBGridEh.SetPageFooter(const Value: TPageColontitle);
begin
  FPageFooter := Value;
end;

procedure TPrintDBGridEh.SetPageHeader(const Value: TPageColontitle);
begin
  FPageHeader := Value;
end;

procedure TPrintDBGridEh.SetPrintFontName(const Value: String);
begin
  FPrintFontName := Value;
end;

procedure TPrintDBGridEh.SetTitle(const Value: TStrings);
begin
  FTitle.Assign(Value);
end;

procedure TPrintDBGridEh.SetUnits(const Value: TMeasureUnits);
var AMul: Currency;
begin
  if Value <> FUnits then
  begin
    FUnits := Value;
    if csLoading in ComponentState then Exit;
    if Value = Inches then AMul := 1 / 2.54 else AMul := 2.54;
    with Page do
    begin
      BottomMargin := BottomMargin * AMul;
      TopMargin := TopMargin * AMul;
      LeftMargin := LeftMargin * AMul;
      RightMargin := RightMargin * AMul;
    end;
  end;
end;

function TPrintDBGridEh.PrinterSetupDialog: Boolean;
begin
  Result := False;
  if not Assigned(fPrnDBGridEhSetupDialog) then
    fPrnDBGridEhSetupDialog := TfPrnDBGridEhSetupDialog.Create(Application);

  with fPrnDBGridEhSetupDialog do
  begin
    seUpMargin.Text := FloatToStr(Page.TopMargin);
    seLowMargin.Text := FloatToStr(Page.BottomMargin);
    seLeftMargin.Text := FloatToStr(Page.LeftMargin);
    seRightMargin.Text := FloatToStr(Page.RightMargin);
    cbFitWidthToPage.Checked := pghFitGridToPageWidth in Options;
    ePrintFont.Text := PrintFontName;
    cbAutoStretch.Checked := pghRowAutoStretch in Options;
    cbColored.Checked := pghColored in Options;
    if pghFitingByColWidths in Options
      then rgFitingType.ItemIndex := 1
      else rgFitingType.ItemIndex := 0;
    cbOptimalColWidths.Checked := pghOptimalColWidths in Options;

    if ShowModal = mrOk then
    begin
      Page.TopMargin := StrToFloat(seUpMargin.Text);
      Page.BottomMargin := StrToFloat(seLowMargin.Text);
      Page.LeftMargin := StrToFloat(seLeftMargin.Text);
      Page.RightMargin := StrToFloat(seRightMargin.Text);
      if cbFitWidthToPage.Checked
        then Options := Options + [pghFitGridToPageWidth]
        else Options := Options - [pghFitGridToPageWidth];
      PrintFontName := ePrintFont.Text;
      if cbAutoStretch.Checked
        then Options := Options + [pghRowAutoStretch]
        else Options := Options - [pghRowAutoStretch];
      if cbColored.Checked
        then Options := Options + [pghColored]
        else Options := Options - [pghColored];
      if rgFitingType.ItemIndex = 1
        then Options := Options + [pghFitingByColWidths]
        else Options := Options - [pghFitingByColWidths];
      if cbOptimalColWidths.Checked
        then Options := Options + [pghOptimalColWidths]
        else Options := Options - [pghOptimalColWidths];
      Result := True;
//      Preview;
    end;
  end;
end;

procedure TPrintDBGridEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DBGridEh) then DBGridEh := nil;
end;

procedure TPrintDBGridEh.PrinterSetupDialogPreview(Sender: TObject);
begin
  if PrinterSetupDialog then
    Preview;
end;

procedure TPrintDBGridEh.SetBeforeGridText(const Value: TStrings);
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create('');
  try
    Value.SaveToStream(Stream);
    Stream.Position := 0;
    BeforeGridText.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TPrintDBGridEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('BeforeGridText_Data', ReadBeforeGridText,
    WriteBeforeGridText, BeforeGridText.Count > 0);
  Filer.DefineBinaryProperty('AfterGridText_Data', ReadAfterGridText,
    WriteAfterGridText, AfterGridText.Count > 0);
end;

procedure TPrintDBGridEh.ReadBeforeGridText(Stream: TStream);
begin
  BeforeGridText.LoadFromStream(Stream);
end;

procedure TPrintDBGridEh.WriteBeforeGridText(Stream: TStream);
begin
  BeforeGridText.SaveToStream(Stream);
end;

procedure TPrintDBGridEh.SetAfterGridText(const Value: TStrings);
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create('');
  try
    Value.SaveToStream(Stream);
    Stream.Position := 0;
    AfterGridText.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TPrintDBGridEh.ReadAfterGridText(Stream: TStream);
begin
  AfterGridText.LoadFromStream(Stream);
end;

procedure TPrintDBGridEh.WriteAfterGridText(Stream: TStream);
begin
  AfterGridText.SaveToStream(Stream);
end;

function TPrintDBGridEh.GetAfterGridText: TStrings;
begin
  if FAfterGridText = nil then
    FAfterGridText := TRichEditStrings.Create;
  Result := FAfterGridText;
end;

function TPrintDBGridEh.GetBeforeGridText: TStrings;
begin
  if FBeforeGridText = nil then
    FBeforeGridText := TRichEditStrings.Create;
  Result := FBeforeGridText;
end;

function TPrintDBGridEh.GridTextReplace(RichStrings: TStrings;
  const SearchStr, ReplaceStr: string; StartPos, Length: Integer;
  Options: TSearchTypes; ReplaceAll: Boolean): Integer;
begin
  Result := -1;
  with TRichEditStrings(RichStrings) do
  begin
    while True do
    begin
      Result := RichEdit.FindText(SearchStr, StartPos, Length, Options);
      if Result <> -1 then
      begin
        RichEdit.SelStart := Result;
{$IFDEF CIL}
        RichEdit.SelLength := Borland.Delphi.System.Length(SearchStr);
{$ELSE}
        RichEdit.SelLength := System.Length(SearchStr);
{$ENDIF}
        RichEdit.SelText := ReplaceStr;
      end;
      if not ReplaceAll or (Result = -1) then Break;
    end;
  end;
end;

procedure TPrintDBGridEh.SetSubstitutes(ASubstitutes: array of const);
var i: Integer;
begin
  if FSubstitutesNames = nil then
  begin
    FSubstitutesNames := TStringList.Create;
    FSubstitutesValues := TStringList.Create;
  end;
  FSubstitutesNames.Clear;
  FSubstitutesValues.Clear;
  for i := 0 to High(ASubstitutes) div 2 do
  begin
{$IFDEF CIL}
    FSubstitutesNames.Add(String(ASubstitutes[i * 2]));
    FSubstitutesValues.Add(String(ASubstitutes[i * 2 + 1]));
{$ELSE}
    FSubstitutesNames.Add(String(ASubstitutes[i * 2].VAnsiString));
    FSubstitutesValues.Add(String(ASubstitutes[i * 2 + 1].VAnsiString));
{$ENDIF}
  end;
end;

{ TPageParams }

procedure TPageParams.Assign(Source: TPersistent);
begin
  if Source is TPageParams then
  begin
    BottomMargin := TPageParams(Source).BottomMargin;
    LeftMargin := TPageParams(Source).LeftMargin;
    RightMargin := TPageParams(Source).RightMargin;
    TopMargin := TPageParams(Source).TopMargin;
//    Columns := TPageParams(Source).Columns;
//    ColumnSpace := TPageParams(Source).ColumnSpace;
  end
  else inherited Assign(Source);
end;

constructor TPageParams.Create;
begin
  inherited Create;
  BottomMargin := 2;
  LeftMargin := 2;
  RightMargin := 2;
  TopMargin := 2;
end;

function TPageParams.IsBottomMarginStored: Boolean;
begin
  Result := (BottomMargin <> 2);
end;

function TPageParams.IsLeftMarginStored: Boolean;
begin
  Result := (LeftMargin <> 2);
end;

function TPageParams.IsRightMarginStored: Boolean;
begin
  Result := (RightMargin <> 2);
end;

function TPageParams.IsTopMarginStored: Boolean;
begin
  Result := (TopMargin <> 2);
end;

procedure TPageParams.SetBottomMargin(const Value: Currency);
begin
  FBottomMargin := Value;
end;

(*procedure TPageParams.SetColumns(const Value: Integer);
begin
  FColumns := Value;
end;

procedure TPageParams.SetColumnSpace(const Value: Currency);
begin
  FColumnSpace := Value;
end;*)

procedure TPageParams.SetLeftMargin(const Value: Currency);
begin
  FLeftMargin := Value;
end;

procedure TPageParams.SetRightMargin(const Value: Currency);
begin
  FRightMargin := Value;
end;

procedure TPageParams.SetTopMargin(const Value: Currency);
begin
  FTopMargin := Value;
end;

{ TPageColontitle }

procedure TPageColontitle.Assign(Source: TPersistent);
begin
  if Source is TPageColontitle then
  begin
    LeftText := TPageColontitle(Source).LeftText;
    CenterText := TPageColontitle(Source).CenterText;
    RightText := TPageColontitle(Source).RightText;
    Font := TPageColontitle(Source).Font;
    LineType := TPageColontitle(Source).LineType;
  end
  else inherited Assign(Source);
end;

constructor TPageColontitle.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FCenterText := TStringList.Create;
  FLeftText := TStringList.Create;
  FRightText := TStringList.Create;
end;

destructor TPageColontitle.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FCenterText);
  FreeAndNil(FLeftText);
  FreeAndNil(FRightText);
  inherited Destroy;
end;

procedure TPageColontitle.SetCenterText(const Value: TStrings);
begin
  FCenterText.Assign(Value);
end;

procedure TPageColontitle.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TPageColontitle.SetLeftText(const Value: TStrings);
begin
  FLeftText.Assign(Value);
end;

procedure TPageColontitle.SetLineType(const Value: TPageColontitleLineType);
begin
  FLineType := Value;
end;

procedure TPageColontitle.SetRightText(const Value: TStrings);
begin
  FRightText.Assign(Value);
end;

initialization
  GetCheckSize;
end.
