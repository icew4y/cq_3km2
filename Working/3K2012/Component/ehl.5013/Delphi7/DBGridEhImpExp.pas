{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{             DBGridEh import/export routines           }
{                      Build 5.0.01                     }
{                                                       }
{   Copyright (c) 1998-2009 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhImpExp;

interface

uses
  Windows, SysUtils, Classes, Graphics, Dialogs, GridsEh, Controls,
{$IFDEF EH_LIB_6}Variants, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  DBGridEh, Db, Clipbrd;

type

//{$IFNDEF CIL}
//  TFooterValues = array[0..MaxListSize - 1] of Currency;
//  PFooterValues = ^TFooterValues;
//{$ENDIF}
  TFooterValues = array of Currency;

  { TDBGridEhExport }

  TDBGridEhExport = class(TObject)
  private
    FColCellParamsEh: TColCellParamsEh;
    FDBGridEh: TCustomDBGridEh;
    FExpCols: TColumnsEhList;
    FStream: TStream;
    function GetFooterValue(Row, Col: Integer): String;
    procedure CalcFooterValues;
  protected
    FooterValues: TFooterValues;
    procedure WritePrefix; virtual;
    procedure WriteSuffix; virtual;
    procedure WriteTitle(ColumnsList: TColumnsEhList); virtual;
    procedure WriteRecord(ColumnsList: TColumnsEhList); virtual;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); virtual;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); virtual;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); virtual;
    property Stream: TStream read FStream write FStream;
    property ExpCols: TColumnsEhList read FExpCols write FExpCols;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); virtual;
    procedure ExportToFile(FileName: String; IsExportAll: Boolean); virtual;
    property DBGridEh: TCustomDBGridEh read FDBGridEh write FDBGridEh;
  end;

  TDBGridEhExportClass = class of TDBGridEhExport;

  { TDBGridEhExportAsText }

  TDBGridEhExportAsText = class(TDBGridEhExport)
  private
    FirstRec: Boolean;
    FirstCell: Boolean;
  protected
    procedure CheckFirstRec; virtual;
    procedure CheckFirstCell; virtual;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    procedure ExportToStream(Stream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsUnicodeText }

  TDBGridEhExportAsUnicodeText = class(TDBGridEhExport)
  private
    FirstRec: Boolean;
    FirstCell: Boolean;
  protected
    procedure CheckFirstRec; virtual;
    procedure CheckFirstCell; virtual;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    procedure ExportToStream(Stream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsCSV }

  TDBGridEhExportAsCSV = class(TDBGridEhExportAsText)
  private
    FSeparator: AnsiChar;
  protected
    procedure CheckFirstCell; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    constructor Create; override;
    property Separator: AnsiChar read FSeparator write FSeparator;
  end;

  { TDBGridEhExportAsHTML }

  TDBGridEhExportAsHTML = class(TDBGridEhExport)
  private
    function GetAlignment(Alignment: TAlignment): String;
    function GetColor(Color: TColor): String;
    procedure PutText(Font: TFont; Text: String);
    procedure Put(Text: String);
    procedure PutL(Text: String);
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  end;

  { TDBGridEhExportAsRTF }

  TDBGridEhExportAsRTF = class(TDBGridEhExport)
  private
    FCacheStream: TMemoryStreamEh;
    ColorTblList: TStrings;
    FontTblList: TStrings;
    function GetFontIndex(FontName: String): Integer;
    function GetColorIndex(Color: TColor): Integer;
    function GetAlignment(Alignment: TAlignment): String;
    function GetDataCellColor(ColumnsList: TColumnsEhList; ColIndex: Integer): TColor;
    function GetFooterCellColor(ColumnsList: TColumnsEhList; ColIndex: Integer;
      FooterNo: Integer): TColor;
    procedure PutText(Font: TFont; Text: String; Background: TColor);
    procedure Put(Text: String);
    procedure PutL(Text: String);
  protected
    procedure WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean);
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsXLS }

  TDBGridEhExportAsXLS = class(TDBGridEhExport)
  private
    FCol, FRow: Word;
    procedure WriteBlankCell;
    procedure WriteIntegerCell(const AValue: Integer);
    procedure WriteFloatCell(const AValue: Double);
    procedure WriteStringCell(const AValue: String);
    procedure IncColRow;
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; Text: String); override;
  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsVCLDBIF }

  {Internal format for interchange between DataSet based components}

  { BOF (Beginning of File)

   Byte       |  0    1    2    3    4    5    6 |  0 |  0    1    2    3 |
              -------------------------------------------------------------
   Contents   |  V |  C |  L |  D |  B |  I |  F |  1 |  X |  X |  X |  X |
              -------------------------------------------------------------
              |  Signatura                       |Vers|  Columns count    |
              |                                  |ion |                   |


    Fields Names

   Byte       |  0 |  0    1    2    3   ...   X |  0 |  0    1    2    3   ...
              ------------------------------------------------------------- ...
   Contents   |  X |  N |  a |  m |  e |  1 |  0 |  X |  N |  a |  m |  e |  2 | 0
              ------------------------------------------------------------- ...
              |Colu| Null terminated field name  |Colu| Null terminated field name
              |mn  |                             |mn  |
              |visi|                             |visi|
              |ble 1 or 0                        |ble 1 or 0

    Values

  ----------------
    Unassigned, skip value
    ftUnknown,  ftCursor, ftADT, ftArray, ftReference, ftDataSet, ftVariant,
     ftInterface, ftIDispatch,

   Byte       |  0 |
              ------
   Contents   |  1 |
              ------
              |Type|
  ----------------
    NULL

   Byte       |  0 |
              ------
   Contents   |  2 |
              ------
              |Type|
  ----------------
    INTEGER32
    ftSmallint, ftInteger, ftWord, ftBoolean, ftAutoInc

   Byte       |  0 |  0    1    2    3 |
              --------------------------
   Contents   |  3 |  X |  X |  X |  X |
              --------------------------
              |Type|  Intetger value   |
                   |   (Longint)       |
  ----------------
    FLOAT64
    ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,

   Byte       |  0 |  0    1    2    3    4    5    6    7 |
              ----------------------------------------------
   Contents   |  4 |  X |  X |  X |  X |  X |  X |  X |  X |
              ----------------------------------------------
              |Type|  Float value (Double)                 |
  ----------------
    STRING
    ftString, ftMemo, ftFixedChar, ftLargeint, ftOraClob, ftGuid

   Byte       |  0 |  0    1    2    3 |  0    1    2   ...   N |
              ---------------------------------------------------
   Contents   |  5 |  X |  X |  X |  X |  a |  b |  c | ...   0 |
              ---------------------------------------------------
              |Type|  Size (Longint)   |  String body including |
                                       |  null terminator       |
  ----------------
    BINARY DATA
    ftBlob, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle, ftOraBlob,
     ftBytes, ftTypedBinary, ftVarBytes, ftWideString,

   Byte       |  0 |  0    1    2    3 |  0    1    2   ...   N |
              ---------------------------------------------------
   Contents   |  6 |  X |  X |  X |  X |  a |  b |  c | ...   X |
              ---------------------------------------------------
              |Type|  Size (Longword)   |  data                  |
  ----------------
    EOF (End of File)

   Byte       |  0 |
              ------
   Contents   |  0 |
              ------
              |Type|
  }

  TVCLDBIF_BOF = packed record
    Signatura: array[0..6] of AnsiChar;
    Version: Byte;
    ColCount: Longint;
  end;

  TVCLDBIF_INTEGER32 = packed record
    AType: Byte;
    Value: Longint;
  end;

  TVCLDBIF_FLOAT64 = packed record
    AType: Byte;
    Value: Double;
  end;

  TVCLDBIF_ANSI_STRING = packed record
    AType: Byte;
    Size: Longint;
  end;

  TVCLDBIF_WIDE_STRING = packed record
    AType: Byte;
    Size: Longint;
  end;

  TVCLDBIF_BINARY_DATA = packed record
    AType: Byte;
    Size: Longint;
  end;

const
  TVCLDBIF_TYPE_EOF = 0;
  TVCLDBIF_TYPE_UNASSIGNED = 1;
  TVCLDBIF_TYPE_NULL = 2;
  TVCLDBIF_TYPE_INTEGER32 = 3;
  TVCLDBIF_TYPE_FLOAT64 = 4;
  TVCLDBIF_TYPE_ANSI_STRING = 5;
  TVCLDBIF_TYPE_BINARY_DATA = 6;
  TVCLDBIF_TYPE_WIDE_STRING = 7;

type

  TDBGridEhExportAsVCLDBIF = class(TDBGridEhExport)
  private
//    function CalcColCount:Word;
    procedure WriteUnassigned;
    procedure WriteNull;
    procedure WriteInteger(AValue: Longint);
    procedure WriteFloat(AValue: Double);
    procedure WriteAnsiString(AValue: AnsiString);
    procedure WriteWideString(AValue: WideString);
    procedure WriteBinaryData(AValue: AnsiString);
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
  end;

  { TDBGridEhImport }

  TDBGridEhImport = class(TObject)
  private
    FDBGridEh: TCustomDBGridEh;
    FStream: TStream;
    FImpCols: TColumnsEhList;
  protected
    Eos: Boolean;
    procedure ReadPrefix; virtual;
    procedure ReadSuffix; virtual;
    procedure ReadRecord(ColumnsList: TColumnsEhList); virtual;
    procedure ReadDataCell(Column: TColumnEh); virtual;
    property Stream: TStream read FStream write FStream;
    property ImpCols: TColumnsEhList read FImpCols write FImpCols;
  public
    constructor Create; virtual;
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); virtual;
    procedure ImportFromFile(FileName: String; IsImportAll: Boolean); virtual;
    property DBGridEh: TCustomDBGridEh read FDBGridEh write FDBGridEh;
  end;

  TDBGridEhImportClass = class of TDBGridEhImport;

  { TDBGridEhImportAsText }

  TImportTextSreamState = (itssChar, itssTab, itssNewLine, itssEof);

  TDBGridEhImportAsText = class(TDBGridEhImport)
  private
    FLastChar: AnsiChar;
    FLastState: TImportTextSreamState;
    FLastString: AnsiString;
    FIgnoreAll: Boolean;
    function GetChar(var ch: AnsiChar): Boolean;
    function CheckState: TImportTextSreamState;
    function GetString(var Value: AnsiString): TImportTextSreamState;
  protected
    procedure ReadPrefix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  { TDBGridEhImportAsUnicodeText }

  TDBGridEhImportAsUnicodeText = class(TDBGridEhImport)
  private
    FLastChar: WideChar;
    FLastState: TImportTextSreamState;
    FLastString: WideString;
    FIgnoreAll: Boolean;
    function GetChar(var ch: WideChar): Boolean;
    function CheckState: TImportTextSreamState;
    function GetString(var Value: WideString): TImportTextSreamState;
  protected
    procedure ReadPrefix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  { TDBGridEhImportAsVCLDBIF }

  TDBGridEhImportAsVCLDBIF = class(TDBGridEhImport)
  private
    Prefix: TVCLDBIF_BOF;
    FIgnoreAll: Boolean;
    LastValue: Variant;
    FieldNames: TStringList;
    UseFieldNames: Boolean;
    procedure ReadValue;
  protected
    procedure ReadPrefix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  { Routines to import/export DBGridEh to/from file/stream }

procedure SaveDBGridEhToExportFile(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsSaveAll: Boolean);
procedure WriteDBGridEhToExportStream(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsSaveAll: Boolean);

procedure LoadDBGridEhFromImportFile(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsLoadToAll: Boolean);
procedure ReadDBGridEhFromImportStream(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsLoadToAll: Boolean);

  { Routines to support clipboard for DBGridEh }

var
  CF_VCLDBIF: Word;

var
  ExtendedVCLDBIFImpExpRowSelect: Boolean = True;
  DBGridEhImpExpCsvSeparator: Char = ';';

procedure DBGridEh_DoCutAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoCopyAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoPasteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoDeleteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);


implementation

uses DBConsts, EhLibConsts, ToolCtrlsEh;

  { Routines to import/export DBGridEh to/from file/stream }

procedure WriteDBGridEhToExportStream(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsSaveAll: Boolean);
var DBGridEhExport: TDBGridEhExport;
begin
  DBGridEhExport := ExportClass.Create;
  try
    DBGridEhExport.DBGridEh := DBGridEh;
    DBGridEhExport.ExportToStream(Stream, IsSaveAll);
  finally
    DBGridEhExport.Free;
  end;
end;

procedure SaveDBGridEhToExportFile(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsSaveAll: Boolean);
var DBGridEhExport: TDBGridEhExport;
begin
  DBGridEhExport := ExportClass.Create;
  try
    DBGridEhExport.DBGridEh := DBGridEh;
    DBGridEhExport.ExportToFile(FileName, IsSaveAll);
  finally
    DBGridEhExport.Free;
  end;
end;

procedure LoadDBGridEhFromImportFile(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsLoadToAll: Boolean);
var DBGridEhImport: TDBGridEhImport;
begin
  DBGridEhImport := ImportClass.Create;
  try
    DBGridEhImport.DBGridEh := DBGridEh;
    DBGridEhImport.ImportFromFile(FileName, IsLoadToAll);
  finally
    DBGridEhImport.Free;
  end;
end;

procedure ReadDBGridEhFromImportStream(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsLoadToAll: Boolean);
var DBGridEhImport: TDBGridEhImport;
begin
  DBGridEhImport := ImportClass.Create;
  try
    DBGridEhImport.DBGridEh := DBGridEh;
    DBGridEhImport.ImportFromStream(Stream, IsLoadToAll);
  finally
    DBGridEhImport.Free;
  end;
end;

{ Routines to support clipboard with DBGridEh }

var
  CF_CSV: Word;
  CF_RICH_TEXT_FORMAT: Word;
//  CF_BIFF: Word;
//  CF_HTML_FORMAT: Word;

procedure Clipboard_PutFromStream(Format: Word; ms: TMemoryStream);
var
  Data: THandle;
  DataPtr: IntPtr;
{$IFNDEF CIL}
  Buffer: IntPtr;
{$ENDIF}
begin
{$IFNDEF CIL}
  Buffer := ms.Memory;
{$ENDIF}
  ClipBoard.Open;
  try
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, ms.Size);
    try
      DataPtr := GlobalLock(Data);
      try
{$IFDEF CIL}
        Marshal.Copy(ms.Memory, 0, DataPtr, ms.Size);
{$ELSE}
        Move(Buffer^, DataPtr^, ms.Size);
{$ENDIF}
        ClipBoard.SetAsHandle(Format, Data);
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    ClipBoard.Close;
  end;
end;

procedure Clipboard_GetToStream(Format: Word; ms: TMemoryStream);
var
  Data: THandle;
  DataPtr: IntPtr;
{$IFDEF CIL}
  DataBytes: TBytes;
{$ENDIF}
begin
  ClipBoard.Open;
  try
    Data := ClipBoard.GetAsHandle(Format);
    if Data = 0 then Exit;
    DataPtr := GlobalLock(Data);
    if DataPtr = nil then Exit;
    try
{$IFDEF CIL}
      SetLength(DataBytes, GlobalSize(Data));
      Marshal.Copy(DataPtr, DataBytes, 0, GlobalSize(Data));
      ms.WriteBuffer(DataBytes, Length(DataBytes));
{$ELSE}
      ms.WriteBuffer(DataPtr^, GlobalSize(Data));
{$ENDIF}
    finally
      GlobalUnlock(Data);
    end;
  finally
    ClipBoard.Close;
  end;
end;

procedure DBGridEh_DoCutAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
begin
  DBGridEh_DoCopyAction(DBGridEh, ForWholeGrid);
  DBGridEh_DoDeleteAction(DBGridEh, ForWholeGrid);
end;

procedure DBGridEh_DoDeleteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var i: Integer;
  ColList: TColumnsEhList;
  ASelectionType: TDBGridEhSelectionType;

  procedure ClearColumns;
  var
    i, j: Integer;
    Field: TField;
    FDataFields: TFieldsArrEh;

    procedure ClearField;
    begin
      if Field.DataSet.CanModify then
      begin
        Field.DataSet.Edit;
        if Field.DataSet.State in [dsEdit, dsInsert] then
          Field.Clear;
      end;
    end;
  begin
    FDataFields := nil;
    for i := 0 to ColList.Count - 1 do
    begin
      if ColList[i].CanModify(False) then
      begin
        if (ColList[i].Field <> nil) and ColList[i].Field.Lookup then
        begin
//          Field := ColList[i].Field.Dataset.FieldByName(ColList[i].Field.KeyFields)
          FDataFields := GetFieldsProperty(ColList[i].Field.Dataset,
            nil, ColList[i].Field.KeyFields);
          for j := 0 to Length(FDataFields)-1 do
          begin
            Field := FDataFields[j];
            ClearField;
          end;
        end else
        begin
          Field := ColList[i].Field;
          ClearField;
        end;
      end;
    end;
  end;

  function DeletePrompt: Boolean;
  var
    Msg: string;
  begin
    Result := True;
    if ASelectionType = gstRecordBookmarks then
      if (DBGridEh.Selection.Rows.Count > 1) then
        Msg := SDeleteMultipleRecordsQuestion
      else
        Msg := SDeleteRecordQuestion
    else if ASelectionType = gstRectangle then
      Msg := SClearSelectedCellsEh
    else
      Exit;
    Result := not (dgConfirmDelete in DBGridEh.Options) or
      (MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) <> idCancel);
  end;

begin
  with DBGridEh do
  begin
    if ForWholeGrid then ASelectionType := gstAll else ASelectionType := Selection.SelectionType;
    if (ASelectionType = gstNon) or
      (DataSource = nil) or (DataSource.Dataset = nil) or
      not DeletePrompt then
      Exit;
    with DataSource.Dataset do
    begin
      SaveBookmark;
      DisableControls;
      try
        case ASelectionType of
          gstRecordBookmarks:
            begin
              ColList := VisibleColumns;
              for i := 0 to Selection.Rows.Count - 1 do
              begin
                Bookmark := Selection.Rows[I];
                Delete;
              end;
              Selection.Clear;
            end;
          gstRectangle:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
                  if Columns[i].Visible then
                    ColList.Add(Columns[i]);
                Bookmark := Selection.Rect.TopRow;
                while True do
                begin
                  ClearColumns;
                  if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset,
                    Selection.Rect.BottomRow, Bookmark) = 0 then Break;
                  Next;
                  if Eof then Break;
                end;
              finally
                ColList.Free;
              end;
              RestoreBookmark;
            end;
          gstColumns:
            begin
              ColList := Selection.Columns;
              First;
              while Eof = False do
              begin
                ClearColumns;
                Next;
              end;
              RestoreBookmark;
            end;
          gstAll:
            begin
              ColList := VisibleColumns;
              First;
              while Eof = False do
                Delete;
            end;
        end;
      finally
        EnableControls;
      end;
    end;
  end;
end;

function IsPlatformNT():boolean;
var VI : TOSVersionInfo;
begin
  VI.dwOSVersionInfoSize := sizeof (VI);
  GetVersionEx (VI);
  result := (VI.dwPlatformId = VER_PLATFORM_WIN32_NT);
end;

{$IFNDEF CIL}
procedure Clipboard_PutUnicodeFromStream(ms: TMemoryStream);
var
  Data: THandle;
  DataPtr: IntPtr;
  BufSize: Integer;
  Buffer: IntPtr;
begin
  Buffer := ms.Memory;
  ClipBoard.Open;
  try
    BufSize := MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, Buffer, ms.Size,
      nil, 0) * 2;
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, BufSize);
    try
      DataPtr := GlobalLock(Data);
      MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, Buffer, ms.Size, DataPtr,
        BufSize div 2);
      try
        ClipBoard.SetAsHandle(CF_UNICODETEXT, Data);
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    ClipBoard.Close;
  end;
end;
{$ENDIF}

procedure SreamWriteNullAnsiStr(st: TStream);
begin
{$IFDEF CIL}
    st.WriteBuffer([0,0], 2);
{$ELSE}
    st.WriteBuffer(PAnsiChar('')^, 1);
{$ENDIF}
end;

procedure SreamWriteNullWideStr(st: TStream);
const WS: WideString = '';
begin
{$IFDEF CIL}
    st.WriteBuffer([0], 1);
{$ELSE}
    st.WriteBuffer(PWideChar(WS)^, 2);
{$ENDIF}
end;

procedure DBGridEh_DoCopyAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var
  ms: TMemoryStreamEh;
begin
  ms := nil;
  Clipboard.Open;

  DBGridEh.DataSource.Dataset.DisableControls;
  try
    ms := TMemoryStreamEh.Create;
    ms.HalfMemoryDelta := $10000;

    WriteDBGridEhToExportStream(TDBGridEhExportAsText, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_TEXT, ms);
(*
{$IFNDEF CIL}
    if IsPlatformNT() then
      Clipboard_PutUnicodeFromStream(ms);
{$ENDIF}
*)
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsUnicodeText, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullWideStr(ms);
    Clipboard_PutFromStream(CF_UNICODETEXT, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsCSV, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_CSV, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsRTF, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_RICH_TEXT_FORMAT, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsVCLDBIF, DBGridEh, ms, ForWholeGrid);
    Clipboard_PutFromStream(CF_VCLDBIF, ms);
    ms.Clear;

    { This version of HTML and Biff export routines don't work under MS Office

    WriteDBGridEhToExportStream(TDBGridEhExportAsHTML,DBGridEh,ms,ForWholeGrid);
    Clipboard_PutFromStream(CF_HTML_FORMAT,ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsXLS,DBGridEh,ms,ForWholeGrid);
    Clipboard_PutFromStream(CF_BIFF,ms);
    ms.Clear;
    }

  finally
    ms.Free;
    Clipboard.Close;
    DBGridEh.DataSource.Dataset.EnableControls;
  end;
end;

procedure DBGridEh_DoPasteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var
  ms: TMemoryStream;
begin
  ms := nil;
  Clipboard.Open;
  try
    ms := TMemoryStream.Create;

    if Clipboard.HasFormat(CF_VCLDBIF) then
    begin
      Clipboard_GetToStream(CF_VCLDBIF, ms);
      ms.Position := 0;
      ReadDBGridEhFromImportStream(TDBGridEhImportAsVCLDBIF, DBGridEh, ms, ForWholeGrid);
    end
    else if Clipboard.HasFormat(CF_UNICODETEXT) then
    begin
      Clipboard_GetToStream(CF_UNICODETEXT, ms);
      ms.Position := 0;
      ReadDBGridEhFromImportStream(TDBGridEhImportAsUnicodeText, DBGridEh, ms, ForWholeGrid);
    end
    else if Clipboard.HasFormat(CF_TEXT) then
    begin
      Clipboard_GetToStream(CF_TEXT, ms);
      ms.Position := 0;
      ReadDBGridEhFromImportStream(TDBGridEhImportAsText, DBGridEh, ms, ForWholeGrid);
    end;

  finally
    ms.Free;
    Clipboard.Close;
  end;
end;

procedure StreamWriteAnsiString(Stream: TStream; S: AnsiString);
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    b := BytesOf(AnsiString(S));
    Stream.Write(b, Length(b));
{$ELSE}
    Stream.Write(PAnsiChar(S)^, Length(S));
{$ENDIF}
end;

procedure StreamWriteWideString(Stream: TStream; S: WideString);
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    b := BytesOf(S);
    Stream.Write(b, Length(b));
{$ELSE}
    Stream.Write(PWideChar(S)^, Length(S)*2);
{$ENDIF}
end;

{ TDBGridEhExport }

procedure TDBGridEhExport.ExportToFile(FileName: String; IsExportAll: Boolean);
var FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    ExportToStream(FileStream, IsExportAll);
  finally
    FileStream.Free;
  end;
end;

procedure TDBGridEhExport.ExportToStream(AStream: TStream; IsExportAll: Boolean);
var i: Integer;
  ColList: TColumnsEhList;
  ASelectionType: TDBGridEhSelectionType;
begin
  Stream := AStream;
  try
    with DBGridEh do
    begin
      if IsExportAll
        then ASelectionType := gstAll
        else ASelectionType := Selection.SelectionType;
      with DataSource.Dataset do
      begin
        DisableControls;
        SaveBookmark;
        try
          case ASelectionType of
            gstNon:
              begin
                if ( (DataSource <> nil) and (DataSource.DataSet <> nil) and
                      not DataSource.DataSet.IsEmpty )
                then
                  Exit;
                ColList := TColumnsEhList.Create;
                try
                  ColList.Add(Columns[SelectedIndex]);
                  ExpCols := ColList;
                  WritePrefix;
                  WriteRecord(ColList);
                finally
                  ColList.Free;
                end;

              end;
            gstRecordBookmarks:
              begin
                ExpCols := VisibleColumns;
//                FooterValues := AllocMem(SizeOf(Currency) * ExpCols.Count * DBGridEh.FooterRowCount);
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in Options then WriteTitle(VisibleColumns);
                for i := 0 to Selection.Rows.Count - 1 do
                begin
                  Bookmark := Selection.Rows[I];
                  CalcFooterValues;
                  WriteRecord(VisibleColumns);
                end;
                for i := 0 to FooterRowCount - 1 do WriteFooter(VisibleColumns, i);
              end;
            gstRectangle:
              begin
                ColList := TColumnsEhList.Create;
                try
                  for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
                    if Columns[i].Visible then
                      ColList.Add(Columns[i]);
                  ExpCols := ColList;
//                  FooterValues := AllocMem(SizeOf(Currency) * ExpCols.Count * DBGridEh.FooterRowCount);
                  SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                  WritePrefix;
                  if dgTitles in Options then WriteTitle(ColList);
                  Bookmark := Selection.Rect.TopRow;
                  while True do
                  begin
                    WriteRecord(ColList);
                    CalcFooterValues;
//                    if CompareBookmarks(Pointer(Selection.Rect.BottomRow), Pointer(Bookmark)) = 0 then Break;
                    if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset, Selection.Rect.BottomRow, Bookmark) = 0 then Break;
                    Next;
                    if Eof then Break;
                  end;
                  for i := 0 to FooterRowCount - 1 do WriteFooter(ColList, i);
                finally
                  ColList.Free;
                end;
              end;
            gstColumns:
              begin
                ExpCols := Selection.Columns;
//                FooterValues := AllocMem(SizeOf(Currency) * ExpCols.Count * DBGridEh.FooterRowCount);
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in Options then WriteTitle(Selection.Columns);
                First;
                while Eof = False do
                begin
                  WriteRecord(Selection.Columns);
                  CalcFooterValues;
                  Next;
                end;
                for i := 0 to FooterRowCount - 1 do WriteFooter(Selection.Columns, i);
              end;
            gstAll:
              begin
                ExpCols := VisibleColumns;
//                FooterValues := AllocMem(SizeOf(Currency) * ExpCols.Count * DBGridEh.FooterRowCount);
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in Options then WriteTitle(VisibleColumns);
                First;
                while Eof = False do
                begin
                  WriteRecord(VisibleColumns);
                  CalcFooterValues;
                  Next;
                end;
                for i := 0 to FooterRowCount - 1 do WriteFooter(VisibleColumns, i);
              end;
          end;
        finally
          RestoreBookmark;
          EnableControls;
        end;
      end;
    end;
    WriteSuffix;
  finally
//    FreeMem(FooterValues);
  end;
end;

procedure TDBGridEhExport.WriteTitle(ColumnsList: TColumnsEhList);
begin
end;

//type TColCellParamsEhCr acker = class(TColCellParamsEh) end;

procedure TDBGridEhExport.WriteRecord(ColumnsList: TColumnsEhList);
var i: Integer;
  AFont: TFont;
  NewBackground: TColor;
//    State:TGridDrawState;
begin
  AFont := TFont.Create;
  try
    for i := 0 to ColumnsList.Count - 1 do
    begin
      AFont.Assign(ColumnsList[i].Font);

      with FColCellParamsEh do
      begin
        Row := -1;
        Col := -1;
        State := [];
        Font := AFont;
        Background := ColumnsList[i].Color;
        NewBackground := ColumnsList[i].Color;
        Alignment := ColumnsList[i].Alignment;
        ImageIndex := ColumnsList[i].GetImageIndex;
        Text := ColumnsList[i].DisplayText;
        CheckboxState := ColumnsList[i].CheckboxState;

        if Assigned(DBGridEh.OnGetCellParams) then
          DBGridEh.OnGetCellParams(DBGridEh, ColumnsList[i], Font, NewBackground, State);

        ColumnsList[i].GetColCellParams(False, FColCellParamsEh);

        Background := NewBackground;

        WriteDataCell(ColumnsList[i], FColCellParamsEh);

      end;
    end;
  finally
    AFont.Free;
  end;
end;

procedure TDBGridEhExport.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
var i: Integer;
  Font: TFont;
  Background: TColor;
  State: TGridDrawState;
  Alignment: TAlignment;
  Value: String;
begin
  Font := TFont.Create;
  try
    for i := 0 to ColumnsList.Count - 1 do
    begin
      Font.Assign(ColumnsList[i].UsedFooter(FooterNo).Font);
      Background := ColumnsList[i].UsedFooter(FooterNo).Color;
      Alignment := ColumnsList[i].UsedFooter(FooterNo).Alignment;
      if ColumnsList[i].UsedFooter(FooterNo).ValueType in [fvtSum, fvtCount] then
        Value := GetFooterValue(FooterNo, i)
      else
        Value := DBGridEh.GetFooterValue(FooterNo, ColumnsList[i]);
      State := [];
      if Assigned(DBGridEh.OnGetFooterParams) then
        DBGridEh.OnGetFooterParams(DBGridEh, ColumnsList[i].Index, FooterNo,
          ColumnsList[i], Font, Background, Alignment, State, Value);
      WriteFooterCell(i {ColumnsList[i].Index}, FooterNo, ColumnsList[i], Font, Background,
        Alignment, Value);
    end;
  finally
    Font.Free;
  end;
end;

procedure TDBGridEhExport.WritePrefix;
begin
end;

procedure TDBGridEhExport.WriteSuffix;
begin
end;

procedure TDBGridEhExport.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
end;

procedure TDBGridEhExport.WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh;
  AFont: TFont; Background: TColor; Alignment: TAlignment; Text: String);
begin
end;

procedure TDBGridEhExport.CalcFooterValues;
var i, j: Integer;
  Field: TField;
  Footer: TColumnFooterEh;
begin
  for i := 0 to DBGridEh.FooterRowCount - 1 do
    for j := 0 to ExpCols.Count - 1 do
    begin
      Footer := ExpCols[j].UsedFooter(i);
      if Footer.FieldName <> '' then
        Field := DBGridEh.DataSource.DataSet.FindField(Footer.FieldName)
      else
        Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[j].FieldName);
      if Field = nil then Continue;
      case Footer.ValueType of
        fvtSum:
          if (Field.IsNull = False) then
            FooterValues[i * ExpCols.Count + j] := FooterValues[i * ExpCols.Count + j] + Field.AsFloat;
        fvtCount:
          FooterValues[i * ExpCols.Count + j] := FooterValues[i * ExpCols.Count + j] + 1;
      end;
    end;
end;

function TDBGridEhExport.GetFooterValue(Row, Col: Integer): String;
var
  FmtStr: string;
  Format: TFloatFormat;
  Digits: Integer;
  v: Variant;
  Field: TField;
begin
  Result := '';
  case ExpCols[Col].UsedFooter(Row).ValueType of
    fvtSum:
      begin
        if ExpCols[Col].UsedFooter(Row).FieldName <> '' then
          Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[Col].UsedFooter(Row).FieldName)
        else
          Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[Col].FieldName);
        if Field = nil then Exit;
        with Field do begin
          v := FooterValues[Row * ExpCols.Count + Col];
          case DataType of
            ftSmallint, ftInteger, ftAutoInc, ftWord:
              with Field as TIntegerField do
              begin
                FmtStr := DisplayFormat;
                if FmtStr = ''
                  then Result := IntToStr(Integer(v))
                  else Result := FormatFloat(FmtStr, v);
              end;
            ftBCD:
              with Field as TBCDField do
              begin
              //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := CurrencyDecimals;
                  end else
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
              with Field as TFMTBCDField do
              begin
              //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := CurrencyDecimals;
                  end else
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
              with Field as TFloatField do
              begin
             //if EditFormat = '' then FmtStr := DisplayFormat else FmtStr := EditFormat;
                FmtStr := DisplayFormat;
                if FmtStr = '' then
                begin
                  if Currency then
                  begin
                    Format := ffCurrency;
                    Digits := CurrencyDecimals;
                  end else
                  begin
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
    fvtCount: Result := FloatToStr(FooterValues[Row * ExpCols.Count + Col]);
  end;
end;


constructor TDBGridEhExport.Create;
begin
  inherited Create;
  FColCellParamsEh := TColCellParamsEh.Create;
end;

destructor TDBGridEhExport.Destroy;
begin
  FreeAndNil(FColCellParamsEh);
  inherited Destroy;
end;

{ TDBGridEhExportAsText }

procedure TDBGridEhExportAsText.WriteTitle(ColumnsList: TColumnsEhList);
var i: Integer;
  s: AnsiString;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    s := AnsiString(ColumnsList[i].Title.Caption);
    if i <> ColumnsList.Count - 1 then
      s := s + #09;
    StreamWriteAnsiString(Stream, s);
  end;
end;

procedure TDBGridEhExportAsText.WriteRecord(ColumnsList: TColumnsEhList);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteRecord(ColumnsList);
end;

procedure TDBGridEhExportAsText.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteFooter(ColumnsList, FooterNo);
end;

procedure TDBGridEhExportAsText.WritePrefix;
begin
end;

procedure TDBGridEhExportAsText.WriteSuffix;
begin
end;

procedure TDBGridEhExportAsText.ExportToStream(Stream: TStream;
  IsExportAll: Boolean);
begin
  FirstRec := True;
  inherited ExportToStream(Stream, IsExportAll);
end;

procedure TDBGridEhExportAsText.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var s: AnsiString;
begin
  CheckFirstCell;
  s := AnsiString(FColCellParamsEh.Text);
  StreamWriteAnsiString(Stream, s);
//  Stream.Write(PChar(s)^, Length(s));
end;

procedure TDBGridEhExportAsText.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var s: AnsiString;
begin
  CheckFirstCell;
  s := AnsiString(Text);
  StreamWriteAnsiString(Stream, s);
//  Stream.Write(PChar(s)^, Length(s));
end;

procedure TDBGridEhExportAsText.CheckFirstCell;
var s: AnsiString;
begin
  if FirstCell = False then
  begin
    s := #09;
    StreamWriteAnsiString(Stream, s);
//    Stream.Write(PChar(s)^, Length(s))
  end else
    FirstCell := False;
end;

procedure TDBGridEhExportAsText.CheckFirstRec;
var s: AnsiString;
begin
  if FirstRec = False then
  begin
    s := #13#10;
    StreamWriteAnsiString(Stream, s);
//    Stream.Write(PChar(s)^, Length(s))
  end else
    FirstRec := False;
end;

{ TDBGridEhExportAsUnicodeText }

procedure TDBGridEhExportAsUnicodeText.WriteTitle(ColumnsList: TColumnsEhList);
var
  i: Integer;
  s: WideString;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    s := WideString(ColumnsList[i].Title.Caption);
    if i <> ColumnsList.Count - 1 then
      s := s + #09;
    StreamWriteWideString(Stream, s);
  end;
end;

procedure TDBGridEhExportAsUnicodeText.WriteRecord(ColumnsList: TColumnsEhList);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteRecord(ColumnsList);
end;

procedure TDBGridEhExportAsUnicodeText.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteFooter(ColumnsList, FooterNo);
end;

procedure TDBGridEhExportAsUnicodeText.WritePrefix;
begin
end;

procedure TDBGridEhExportAsUnicodeText.WriteSuffix;
begin
end;

procedure TDBGridEhExportAsUnicodeText.ExportToStream(Stream: TStream;
  IsExportAll: Boolean);
begin
  FirstRec := True;
  inherited ExportToStream(Stream, IsExportAll);
end;

procedure TDBGridEhExportAsUnicodeText.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  s: WideString;
begin
  CheckFirstCell;
  s := WideString(FColCellParamsEh.Text);
  StreamWriteWideString(Stream, s);
end;

procedure TDBGridEhExportAsUnicodeText.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var
  s: WideString;
begin
  CheckFirstCell;
  s := WideString(Text);
  StreamWriteWideString(Stream, s);
//  Stream.Write(PChar(s)^, Length(s));
end;

procedure TDBGridEhExportAsUnicodeText.CheckFirstCell;
var
  s: WideString;
begin
  if FirstCell = False then
  begin
    s := #09;
    StreamWriteWideString(Stream, s);
//    Stream.Write(PChar(s)^, Length(s))
  end else
    FirstCell := False;
end;

procedure TDBGridEhExportAsUnicodeText.CheckFirstRec;
var
  s: WideString;
begin
  if FirstRec = False then
  begin
    s := #13#10;
    StreamWriteWideString(Stream, s);
  end else
    FirstRec := False;
end;

{ TDBGridEhExportAsCVS }

procedure TDBGridEhExportAsCSV.CheckFirstCell;
var
  s: AnsiString;
begin
  if FirstCell = False then
  begin
    s := Separator;
    StreamWriteAnsiString(Stream, s);
  end else
    FirstCell := False;
end;

constructor TDBGridEhExportAsCSV.Create;
begin
  inherited Create;
  Separator := AnsiChar(DBGridEhImpExpCsvSeparator);
end;

procedure TDBGridEhExportAsCSV.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var s: AnsiString;
begin
  CheckFirstCell;
  s := AnsiString(AnsiQuotedStr(FColCellParamsEh.Text, '"'));
  StreamWriteAnsiString(Stream, s);
//  Stream.Write(PChar(s)^, Length(s));
end;

procedure TDBGridEhExportAsCSV.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var s: AnsiString;
begin
  CheckFirstCell;
  s := AnsiString(AnsiQuotedStr(Text, '"'));
  StreamWriteAnsiString(Stream, s);
//  Stream.Write(PChar(s)^, Length(s));
end;

procedure TDBGridEhExportAsCSV.WriteTitle(ColumnsList: TColumnsEhList);
var i: Integer;
  s: AnsiString;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    s := AnsiString(AnsiQuotedStr(ColumnsList[i].Title.Caption, '"'));
    if i <> ColumnsList.Count - 1 then
      s := s + Separator;
    StreamWriteAnsiString(Stream, s);
//    Stream.Write(PChar(s)^, Length(s));
  end;
end;

{ Routines to convert MultiTitle in matrix (List of Lists) }

type
  TTitleExpRec = record
    Height: Integer;
    PTLeafCol: THeadTreeNode;
  end;

  PTitleExpRec = ^TTitleExpRec;
//  TTitleExpArr = array[0..MaxListSize - 1] of TTitleExpRec;
//  PTitleExpArr = ^TTitleExpArr;
  TTitleExpArr = array of TTitleExpRec;

procedure CalcSpan(
  ColumnsList: TColumnsEhList; ListOfHeadTreeNodeList: TList;
  Row, Col: Integer;
  var AColSpan: Integer; var ARowSpan: Integer
  );
var Node: THeadTreeNode;
  i, k: Integer;
begin
  AColSpan := 1; ARowSpan := 1;
  Node := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[Row]).Items[Col]);
  if Node <> nil then
  begin
    for k := Row - 1 downto 0 do
      if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[Col]) = Node
        then
      begin
        Inc(ARowSpan);
        TList(ListOfHeadTreeNodeList.Items[k]).Items[Col] := nil;
      end else
        Break;

    for i := Col + 1 to ColumnsList.Count - 1 do
      if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[Row]).Items[i]) = Node
        then
      begin
        Inc(AColSpan);
        TList(ListOfHeadTreeNodeList.Items[Row]).Items[i] := nil;
      end else
        Break;

    for k := Row - 1 downto Row - ARowSpan + 1 do
      for i := Col + 1 to Col + AColSpan - 1 do
        TList(ListOfHeadTreeNodeList.Items[k]).Items[i] := nil;
  end;
end;

procedure CreateMultiTitleMatrix(DBGridEh: TCustomDBGridEh;
  ColumnsList: TColumnsEhList;
  var FPTitleExpArr: TTitleExpArr;
  var ListOfHeadTreeNodeList: TList);
var i: Integer;
  NeedNextStep: Boolean;
  MinHeight: Integer;
  FHeadTreeNodeList: TList;
begin
  ListOfHeadTreeNodeList := nil;
//  FPTitleExpArr := AllocMem(SizeOf(TTitleExpRec) * ColumnsList.Count);
  SetLength(FPTitleExpArr, ColumnsList.Count);
  for i := 0 to ColumnsList.Count - 1 do
  begin
    FPTitleExpArr[i].Height := DBGridEh.LeafFieldArr[ColumnsList[i].Index].FLeaf.Height;
    FPTitleExpArr[i].PTLeafCol := DBGridEh.LeafFieldArr[ColumnsList[i].Index].FLeaf;
  end;
  ListOfHeadTreeNodeList := TList.Create;
  NeedNextStep := True;
  while True do
  begin
    //search min height
    MinHeight := FPTitleExpArr[0].Height;
    for i := 1 to ColumnsList.Count - 1 do
      if FPTitleExpArr[i].Height < MinHeight then
        MinHeight := FPTitleExpArr[i].Height;
    //add NodeList
    FHeadTreeNodeList := TList.Create;
    for i := 0 to ColumnsList.Count - 1 do
    begin
      FHeadTreeNodeList.Add(FPTitleExpArr[i].PTLeafCol);
      if FPTitleExpArr[i].Height = MinHeight then
      begin
        if FPTitleExpArr[i].PTLeafCol.Host <> nil then
        begin
          FPTitleExpArr[i].PTLeafCol := FPTitleExpArr[i].PTLeafCol.Host;
          Inc(FPTitleExpArr[i].Height, FPTitleExpArr[i].PTLeafCol.Height);
          NeedNextStep := True;
        end;
      end;
    end;
    if not NeedNextStep then Break;
    ListOfHeadTreeNodeList.Add(FHeadTreeNodeList);
    NeedNextStep := False;
  end;
end;

{ TDBGridEhExportAsHTML }

procedure TDBGridEhExportAsHTML.Put(Text: String);
{$IFDEF EH_LIB_12}
var
  B: RawByteString;
{$ENDIF}
begin
{$IFDEF EH_LIB_12}
  B := UTF8Encode(Text);
  Stream.Write(Pointer(B)^, Length(B));
{$ELSE}

{$IFDEF CIL}
{$ELSE}
  Stream.Write(PChar(Text)^, Length(Text) * SizeOf(Char));
{$ENDIF}

{$ENDIF}
end;

procedure TDBGridEhExportAsHTML.PutL(Text: String);
begin
  Put(Text + #13#10);
end;

procedure TDBGridEhExportAsHTML.WritePrefix;
var s: String;
  CellPaddingInc: String;
begin
  PutL('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">');
  PutL('<html>');
  PutL('<head>');
  PutL('<title>');
  PutL(DBGridEh.Name);
  PutL('</title>');
{$IFDEF EH_LIB_12}
  PutL('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');
{$ENDIF}
  PutL('</head>');

  PutL('<body>');

  s := '<table ';
  if DBGridEh.Flat then CellPaddingInc := '1' else CellPaddingInc := '2';
  if DBGridEh.Options * [dgColLines, dgRowLines] <> [] then
    if DBGridEh.Ctl3D then s := s + 'BORDER=1 CELLSPACING=0 CELLPADDING=' + CellPaddingInc
    else s := s + 'BORDER=0 CELLSPACING=1 CELLPADDING=' + CellPaddingInc
  else
    s := s + 'BORDER=0 CELLSPACING=0 CELLPADDING=' + CellPaddingInc;
  s := s + ' BGCOLOR=#' + GetColor(DBGridEh.FixedColor) + '>' + #13#10;
  PutL(s);
end;

procedure TDBGridEhExportAsHTML.WriteSuffix;
begin
  PutL('</table>');
  PutL('</body>');
  PutL('</html>');
end;

procedure TDBGridEhExportAsHTML.WriteTitle(ColumnsList: TColumnsEhList);
var i, k: Integer;
//  FPTitleExpArr: PTitleExpArr;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TList;
  ColSpan, RowSpan: Integer;
begin
  if ColumnsList.Count = 0 then Exit;

  if DBGridEh.UseMultiTitle then
  begin
    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      for k := ListOfHeadTreeNodeList.Count - 1 downto 1 do
      begin
        PutL('<TR>');
        for i := 0 to ColumnsList.Count - 1 do
        begin
          if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            Put('  <TD ALIGN="CENTER"');
            CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
            if ColSpan > 1 then
              Put(' COLSPAN = "' + IntToStr(ColSpan) + '"');
            if RowSpan > 1 then
              Put(' ROWSPAN = "' + IntToStr(RowSpan) + '"');
            Put('>');
            PutText(DBGridEh.TitleFont,
              THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text);
            PutL('</TD>');
          end;
        end;
        PutL('</TR>');
      end;

      PutL('<TR>');
      for i := 0 to ColumnsList.Count - 1 do
      begin
        if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[0]).Items[i]) <> nil then
        begin
          Put('  <TD WIDTH=' + IntToStr(ColumnsList[i].Width) + ' ALIGN="CENTER"');
          CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);
          if ColSpan > 1 then
            Put(' COLSPAN = "' + IntToStr(ColSpan) + '"');
          if RowSpan > 1 then
            Put(' ROWSPAN = "' + IntToStr(RowSpan) + '"');
          Put('>');
          PutText(ColumnsList[i].Title.Font,
            THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[0]).Items[i]).Text);
          PutL('</TD>');
        end;
      end;
      PutL('</TR>');

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        TList(ListOfHeadTreeNodeList.Items[i]).Free;
      ListOfHeadTreeNodeList.Free;
//      FreeMem(FPTitleExpArr);
    end;
  end else
  begin
    PutL('<TR>');
    for i := 0 to ColumnsList.Count - 1 do
    begin
      Put('  <TD WIDTH=' + IntToStr(ColumnsList[i].Width) +
        ' ALIGN="' + GetAlignment(ColumnsList[i].Title.Alignment) + '"' + '>');
      PutText(ColumnsList[i].Title.Font, ColumnsList[i].Title.Caption);
      PutL('</TD>');
    end;
    PutL('</TR>');
  end;
end;

procedure TDBGridEhExportAsHTML.WriteRecord(ColumnsList: TColumnsEhList);
begin
  PutL('<TR>');
  inherited;
  PutL('</TR>');
end;

procedure TDBGridEhExportAsHTML.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
  Put('  <TD WIDTH=' + IntToStr(Column.Width) +
    ' ALIGN="' + GetAlignment(FColCellParamsEh.Alignment) + '"' +
    ' BGCOLOR=#' + GetColor(FColCellParamsEh.Background) +
    '>');
  PutText(FColCellParamsEh.Font, FColCellParamsEh.Text);
  PutL('</TD>');
end;

function TDBGridEhExportAsHTML.GetAlignment(Alignment: TAlignment): String;
begin
  case Alignment of
    taLeftJustify: Result := 'LEFT';
    taCenter: Result := 'CENTER';
    taRightJustify: Result := 'RIGHT';
  end;
end;

procedure TDBGridEhExportAsHTML.PutText(Font: TFont; Text: String);
var s: String;
begin
  s := '<FONT STYLE="font-family: ' + Font.Name;
  s := s + '; font-size: ' + IntToStr(Font.Size);
  s := s + 'pt; color: #' + GetColor(Font.Color) + '">';

  if (fsBold in Font.Style) then s := s + '<B>';
  if (fsItalic in Font.Style) then s := S + '<I>';
  if (fsUnderline in Font.Style) then s := s + '<U>';
  if (fsStrikeOut in Font.Style) then s := s + '<STRIKE>';

  Text := StringReplace(Text, '&', '&amp', [rfReplaceAll]);
  Text := StringReplace(Text, '<', '&lt', [rfReplaceAll]);
  Text := StringReplace(Text, '>', '&gt', [rfReplaceAll]);
  Text := StringReplace(Text, '"', '&quot', [rfReplaceAll]);

  if Text <> '' then
    s := s + Text
  else
    s := s + '&nbsp';

  if (fsBold in Font.Style) then s := s + '</B>';
  if (fsItalic in Font.Style) then s := S + '</I>';
  if (fsUnderline in Font.Style) then s := s + '</U>';
  if (fsStrikeOut in Font.Style) then s := s + '</STRIKE>';
  s := s + '</FONT>';

  Put(s);
end;

function TDBGridEhExportAsHTML.GetColor(Color: TColor): String;
var s: String;
begin
  if Color = clNone then
    s := '000000'
  else
    s := IntToHex(ColorToRGB(Color), 6);
  Result := Copy(s, 5, 2) + Copy(s, 3, 2) + Copy(s, 1, 2);
end;

procedure TDBGridEhExportAsHTML.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
begin
  PutL('<TR>');
  inherited;
  PutL('</TR>');
end;

procedure TDBGridEhExportAsHTML.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var Footer: TColumnFooterEh;
begin
  Footer := Column.UsedFooter(Row);
  Put('  <TD WIDTH=' + IntToStr(Column.Width) +
    ' ALIGN="' + GetAlignment(Footer.Alignment) + '"' +
    ' BGCOLOR=#' + GetColor(Background) +
    '>');
  PutText(AFont, Text);
  PutL('</TD>');
end;

{ TDBGridEhExportAsRTF }

procedure TDBGridEhExportAsRTF.ExportToStream(AStream: TStream; IsExportAll: Boolean);
var
  i: Integer;
begin
  FCacheStream := TMemoryStreamEh.Create;
  FCacheStream.HalfMemoryDelta := $10000;
  ColorTblList := TStringList.Create;
  FontTblList := TStringList.Create;
  try
    GetColorIndex(clBlack);
    GetColorIndex(clWhite);
    GetColorIndex(clBtnFace);

    inherited ExportToStream(FCacheStream, IsExportAll);

    Stream := AStream;

    PutL('{\rtf0\ansi');

    Put('{\colortbl');
    for i := 0 to ColorTblList.Count - 1 do
      Put('\red' + Trim(Copy(ColorTblList[i], 1, 3)) +
        '\green' + Trim(Copy(ColorTblList[i], 4, 3)) +
        '\blue' + Trim(Copy(ColorTblList[i], 7, 3)) + ';');
    PutL('}');

    Put('{\fonttbl');
    for i := 0 to FontTblList.Count - 1 do
      Put('\f' + IntToStr(i) + '\fnil ' + FontTblList[i] + ';');
    PutL('}');
    FCacheStream.SaveToStream(Stream);
  finally
    FCacheStream.Free;
    ColorTblList.Free;
    FontTblList.Free;
  end;
end;

procedure TDBGridEhExportAsRTF.Put(Text: String);
begin
  StreamWriteAnsiString(Stream, AnsiString(Text));
//  Stream.Write(PChar(Text)^, Length(Text));
end;

procedure TDBGridEhExportAsRTF.PutL(Text: String);
begin
  Put(Text + #13#10);
end;

procedure TDBGridEhExportAsRTF.PutText(Font: TFont; Text: String; Background: TColor);
var s: String;
begin

  s := '\fs' + IntToStr(Font.Size * 2);
  if (fsBold in Font.Style) then s := s + '\b';
  if (fsItalic in Font.Style) then s := s + '\i';
  if (fsStrikeOut in Font.Style) then s := s + '\strike';
  if (fsUnderline in Font.Style) then s := s + '\ul';
  s := s + '\f' + IntToStr(GetFontIndex(Font.Name));
  s := s + '\cf' + IntToStr(GetColorIndex(Font.Color));
  s := s + '\cb' + IntToStr(GetColorIndex(Background));
  Put(s + ' ');
  Put(Text);
end;

function TDBGridEhExportAsRTF.GetAlignment(Alignment: TAlignment): String;
begin
  case Alignment of
    taLeftJustify: Result := '\ql';
    taCenter: Result := '\qc';
    taRightJustify: Result := '\qr';
  end;
end;

function TDBGridEhExportAsRTF.GetFontIndex(FontName: String): Integer;
begin
  Result := FontTblList.IndexOf(FontName);
  if Result = -1 then
    Result := FontTblList.Add(FontName);
end;

function TDBGridEhExportAsRTF.GetColorIndex(Color: TColor): Integer;
var RGBColor: Longint;
  s: String;
begin
  RGBColor := ColorToRGB(Color);
  s := Format('%3d%3d%3d', [GetRValue(RGBColor), GetGValue(RGBColor), GetBValue(RGBColor)]);
  Result := ColorTblList.IndexOf(s);
  if Result = -1 then
    Result := ColorTblList.Add(s);
end;

procedure TDBGridEhExportAsRTF.WritePrefix;
begin
end;

procedure TDBGridEhExportAsRTF.WriteSuffix;
begin
  Put('}');
end;

procedure TDBGridEhExportAsRTF.WriteTitle(ColumnsList: TColumnsEhList);
var fLogPelsX: Integer;
  i, w, k: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TList;
  ColSpan, RowSpan: Integer;
  Text: String;
  LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean;
  ExclLeftBorders, ExclTopBorders, ExclBottomBorders, ExclRightBorders: TStringList;
  Space: String;

  procedure AddExclBorders(Col, Row, ColSpan, RowSpan: Integer);
  var i, k: Integer;
  begin
    for i := Col to Col + ColSpan - 1 do
      for k := Row downto Row - RowSpan + 1 do
      begin
        if i <> Col then
          ExclLeftBorders.Add(Format('%3d%3d', [i, k]));
        if i <> Col + ColSpan - 1 then
          ExclRightBorders.Add(Format('%3d%3d', [i, k]));
        if k <> Row then
          ExclTopBorders.Add(Format('%3d%3d', [i, k]));
        if k <> Row - RowSpan + 1 then
          ExclBottomBorders.Add(Format('%3d%3d', [i, k]));
      end;
  end;

  procedure CalcBorders(Col, Row: Integer);
  begin
    LeftBorder := True; TopBorder := True;
    BottomBorder := True; RightBorder := True;
    if ExclLeftBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      LeftBorder := False;
    if ExclRightBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      RightBorder := False;
    if ExclTopBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      TopBorder := False;
    if ExclBottomBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      BottomBorder := False;
  end;
begin
  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  if DBGridEh.UseMultiTitle then
  begin
    Space := IntToStr(Abs(Trunc(DBGridEh.VTitleMargin / 2 / fLogPelsX * 1440 - 20)));
    ExclLeftBorders := nil; ExclTopBorders := nil;
    ExclBottomBorders := nil; ExclRightBorders := nil;
    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      ExclLeftBorders := TStringList.Create;
      ExclTopBorders := TStringList.Create;
      ExclBottomBorders := TStringList.Create;
      ExclRightBorders := TStringList.Create;

      //MultiTitle
      for k := ListOfHeadTreeNodeList.Count - 1 downto 1 do
      begin
        Put('\trowd');
        PutL('\trgaph40');

        w := 0;
        for i := 0 to ColumnsList.Count - 1 do
        begin
          CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
          AddExclBorders(i, k, ColSpan, RowSpan);
          CalcBorders(i, k);

          WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder);
          Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
          Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((DBGridEh.FixedColor))));
          PutL('\cellx' + IntToStr(w));
        end;

        PutL('{\trrh0');

        for i := 0 to ColumnsList.Count - 1 do
        begin
          if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            Text := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
            Put('\pard\intbl{' + GetAlignment(taCenter) + '\sb' + Space + '\sa' + Space);
          end else
          begin
            Text := '';
            Put('\pard\intbl{' + GetAlignment(taCenter));
          end;

          PutText(DBGridEh.TitleFont, Text, DBGridEh.FixedColor);
          PutL('\cell}');
        end;
        PutL('\pard\intbl\row}');
      end;

      //Bottomest titles
      Put('\trowd');
      PutL('\trgaph40');

      w := 0;
      for i := 0 to ColumnsList.Count - 1 do
      begin
        CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);
        AddExclBorders(i, 0, ColSpan, RowSpan);
        CalcBorders(i, 0);

        WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder);

        Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
        Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((ColumnsList[i].Title.Color))));
        PutL('\cellx' + IntToStr(w));
      end;

      PutL('{\trrh0');

      for i := 0 to ColumnsList.Count - 1 do
      begin
        if THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[0]).Items[i]) <> nil then
        begin
          Text := THeadTreeNode(TList(ListOfHeadTreeNodeList.Items[0]).Items[i]).Text;
          Put('\pard\intbl{' + GetAlignment(taCenter) + '\sb' + Space + '\sa' + Space);
        end else
        begin
          Text := '';
          Put('\pard\intbl{' + GetAlignment(taCenter));
        end;
        CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);

        PutText(ColumnsList[i].Title.Font, Text, ColumnsList[i].Title.Color);
        PutL('\cell}');

      end;
      PutL('\pard\intbl\row}');

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        TList(ListOfHeadTreeNodeList.Items[i]).Free;
      ListOfHeadTreeNodeList.Free;
//      FreeMem(FPTitleExpArr);

      ExclLeftBorders.Free;
      ExclTopBorders.Free;
      ExclBottomBorders.Free;
      ExclRightBorders.Free;
    end;
  end else
  begin
    Put('\trowd');
    PutL('\trgaph40');

    w := 0;
    for i := 0 to ColumnsList.Count - 1 do
    begin
      WriteCellBorder(True, True, True, True);
      Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
      Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((ColumnsList[i].Title.Color))));
      PutL('\cellx' + IntToStr(w));
    end;

    PutL('{\trrh0');

    for i := 0 to ColumnsList.Count - 1 do
    begin
      if DBGridEh.Flat then Space := '12' else Space := '24';
      Put('\pard\intbl{' + GetAlignment(ColumnsList[i].Title.Alignment) + '\sb' + Space + '\sa' + Space);
      PutText(ColumnsList[i].Title.Font, ColumnsList[i].Title.Caption, ColumnsList[i].Title.Color);
      PutL('\cell}');
    end;

    PutL('\pard\intbl\row}');
  end;
end;

procedure TDBGridEhExportAsRTF.WriteRecord(ColumnsList: TColumnsEhList);
var fLogPelsX: Integer;
  i, w: Integer;
begin
  Put('\trowd');
  PutL('\trgaph40');

  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  w := 0;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteCellBorder(True, True, True, True);
    Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
    Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex(GetDataCellColor(ColumnsList, i))));
    PutL('\cellx' + IntToStr(w));
  end;

  PutL('{\trrh0');

  inherited WriteRecord(ColumnsList);

  PutL('\pard\intbl\row}');
end;

procedure TDBGridEhExportAsRTF.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var Space: String;
begin
  if DBGridEh.Flat then Space := '12' else Space := '24';
  Put('\pard\intbl{' + GetAlignment(FColCellParamsEh.Alignment) + '\sb' + Space + '\sa' + Space);
  PutText(FColCellParamsEh.Font, FColCellParamsEh.Text, FColCellParamsEh.Background);
  PutL('\cell}');
end;

procedure TDBGridEhExportAsRTF.WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean);
begin
  if LeftBorder then
  begin
    Put('\clbrdrl');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if TopBorder then
  begin
    Put('\clbrdrt');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if BottomBorder then
  begin
    Put('\clbrdrb');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if RightBorder then
  begin
    Put('\clbrdrr');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;
end;

procedure TDBGridEhExportAsRTF.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
var fLogPelsX: Integer;
  i, w: Integer;
begin
  Put('\trowd');
  PutL('\trgaph40');

  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  w := 0;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteCellBorder(True, True, True, True);
    Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); // in twips
    Put('\clshdng10000\clcfpat' +
      IntToStr(GetColorIndex(GetFooterCellColor(ColumnsList, i, FooterNo))));
    PutL('\cellx' + IntToStr(w));
  end;

  PutL('{\trrh0'); // row auto-height

  inherited WriteFooter(ColumnsList, FooterNo);

  PutL('\pard\intbl\row}');
end;

procedure TDBGridEhExportAsRTF.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
var Space: String;
begin
  if DBGridEh.Flat then Space := '12' else Space := '24';
  Put('\pard\intbl{' + GetAlignment(Alignment) + '\sb' + Space + '\sa' + Space);
  PutText(AFont, Text, Background);
  PutL('\cell}');
end;

function TDBGridEhExportAsRTF.GetDataCellColor(ColumnsList: TColumnsEhList;
  ColIndex: Integer): TColor;
var Font: TFont;
  State: TGridDrawState;
begin
  Font := TFont.Create;
  try
    Font.Assign(ColumnsList[ColIndex].Font);
    Result := ColumnsList[ColIndex].Color;
    State := [];
    if Assigned(DBGridEh.OnGetCellParams) then
      DBGridEh.OnGetCellParams(DBGridEh, ColumnsList[ColIndex], Font, Result, State);
  finally
    Font.Free;
  end;
end;

function TDBGridEhExportAsRTF.GetFooterCellColor(
  ColumnsList: TColumnsEhList; ColIndex: Integer; FooterNo: Integer): TColor;
var Font: TFont;
  State: TGridDrawState;
  Alignment: TAlignment;
  Value: String;
begin
  Font := TFont.Create;
  try
    Font.Assign(ColumnsList[ColIndex].UsedFooter(FooterNo).Font);
    Result := ColumnsList[ColIndex].UsedFooter(FooterNo).Color;
    Alignment := ColumnsList[ColIndex].UsedFooter(FooterNo).Alignment;
    if ColumnsList[ColIndex].UsedFooter(FooterNo).ValueType in [fvtSum, fvtCount] then
      Value := GetFooterValue(FooterNo, ColIndex)
    else
      Value := DBGridEh.GetFooterValue(FooterNo, ColumnsList[ColIndex]);
    State := [];
    if Assigned(DBGridEh.OnGetFooterParams) then
      DBGridEh.OnGetFooterParams(DBGridEh, ColumnsList[ColIndex].Index, FooterNo,
        ColumnsList[ColIndex], Font, Result, Alignment, State, Value);
  finally
    Font.Free;
  end;
end;

{ TDBGridEhExportAsXLS }

procedure StreamWriteWordArray(Stream: TStream; wr: array of Word);
var
  i: Integer;
begin
  for i := 0 to Length(wr)-1 do
{$IFDEF CIL}
    Stream.Write(wr[i]);
{$ELSE}
    Stream.Write(wr[i], SizeOf(wr[i]));
{$ENDIF}
end;

var
  CXlsBof: array[0..5] of Word = ($809, 8, 0, $10, 0, 0);
  CXlsEof: array[0..1] of Word = ($0A, 00);
  CXlsLabel: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
  CXlsNumber: array[0..4] of Word = ($203, 14, 0, 0, 0);
  CXlsRk: array[0..4] of Word = ($27E, 10, 0, 0, 0);
  CXlsBlank: array[0..4] of Word = ($201, 6, 0, 0, $17);


procedure TDBGridEhExportAsXLS.WriteBlankCell;
begin
  CXlsBlank[2] := FRow;
  CXlsBlank[3] := FCol;
  StreamWriteWordArray(Stream, CXlsBlank);
//  Stream.WriteBuffer(CXlsBlank, SizeOf(CXlsBlank));
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WriteFloatCell(const AValue: Double);
begin
  CXlsNumber[2] := FRow;
  CXlsNumber[3] := FCol;
  StreamWriteWordArray(Stream, CXlsNumber);
//  Stream.WriteBuffer(CXlsNumber, SizeOf(CXlsNumber));
  Stream.WriteBuffer(AValue, 8);
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WriteIntegerCell(const AValue: Integer);
var
  V: Integer;
begin
  CXlsRk[2] := FRow;
  CXlsRk[3] := FCol;
  StreamWriteWordArray(Stream, CXlsRk);
//  Stream.WriteBuffer(CXlsRk, SizeOf(CXlsRk));
  V := (AValue shl 2) or 2;
  Stream.WriteBuffer(V, 4);
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WriteStringCell(const AValue: string);
var
  L: Word;
begin
  L := Length(AnsiString(AValue));
  CXlsLabel[1] := 8 + L;
  CXlsLabel[2] := FRow;
  CXlsLabel[3] := FCol;
  CXlsLabel[5] := L;
  StreamWriteWordArray(Stream, CXlsLabel);
//  Stream.WriteBuffer(CXlsLabel, SizeOf(CXlsLabel));
  StreamWriteAnsiString(Stream, AnsiString(AValue));
//  Stream.WriteBuffer(Pointer(AValue)^, L);
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WritePrefix;
begin
  StreamWriteWordArray(Stream, CXlsBof);
//  Stream.WriteBuffer(CXlsBof, SizeOf(CXlsBof));
end;

procedure TDBGridEhExportAsXLS.WriteSuffix;
begin
  StreamWriteWordArray(Stream, CXlsEof);
//  Stream.WriteBuffer(CXlsEof, SizeOf(CXlsEof));
end;

procedure TDBGridEhExportAsXLS.WriteTitle(ColumnsList: TColumnsEhList);
var i: Integer;
begin
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteStringCell(ColumnsList[i].Title.Caption);
  end;
end;

procedure TDBGridEhExportAsXLS.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
  if Column.Field = nil then
    WriteBlankCell
  else if Column.GetColumnType = ctKeyPickList then
    WriteStringCell(FColCellParamsEh.Text)
  else if Column.Field.IsNull then
    WriteBlankCell
  else
    with Column.Field do
      case DataType of
        ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes:
          WriteIntegerCell(AsInteger);
        ftFloat, ftCurrency, ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}:
          WriteFloatCell(AsFloat);
      else
        WriteStringCell(FColCellParamsEh.Text);
      end;
end;

procedure TDBGridEhExportAsXLS.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; Text: String);
begin
  if Column.UsedFooter(Row).ValueType in [fvtSum, fvtCount] then
    WriteFloatCell(FooterValues[Row * ExpCols.Count + DataCol])
  else
    WriteStringCell(Text);
end;

procedure TDBGridEhExportAsXLS.ExportToStream(AStream: TStream;
  IsExportAll: Boolean);
begin
  FCol := 0;
  FRow := 0;
  inherited ExportToStream(AStream, IsExportAll);
end;

procedure TDBGridEhExportAsXLS.IncColRow;
begin
  if FCol = ExpCols.Count - 1 then
  begin
    Inc(FRow);
    FCol := 0;
  end else
    Inc(FCol);
end;

{ TDBGridEhExportAsVCLDBIF }

{$IFDEF CIL}
procedure StreamWriteStruct(Stream: TStream; AStruct: TObject; ASize: Integer);
var
  b: TBytes;
  Mem: IntPtr;
begin
  Mem := Marshal.AllocHGlobal(Marshal.SizeOf(AStruct));
  try
    Marshal.StructureToPtr(AStruct, Mem, False);
    SetLength(b, Marshal.SizeOf(AStruct));
    Marshal.Copy(Mem, b, 0, Length(b));
    Stream.Write(b, Length(b));
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;
{$ELSE}
procedure StreamWriteStruct(Stream: TStream; var AStruct; ASize: Integer);
begin
  Stream.WriteBuffer(AStruct, ASize);
end;
{$ENDIF}

var
  VCLDBIF_BOF: TVCLDBIF_BOF = (Signatura: ('V', 'C', 'L', 'D', 'B', 'I', 'F'); Version: 1; ColCount: 0);

procedure TDBGridEhExportAsVCLDBIF.WritePrefix;
var
  i: Integer;
  b: Byte;
begin
  VCLDBIF_BOF.ColCount := ExpCols.Count; //CalcColCount;
  StreamWriteStruct(Stream, VCLDBIF_BOF, SizeOf(VCLDBIF_BOF));
//  Stream.WriteBuffer(VCLDBIF_BOF, SizeOf(VCLDBIF_BOF));
  for i := 0 to ExpCols.Count - 1 do
  begin
    if ExpCols[i].Visible then b := 1 else b := 0;
    Stream.WriteBuffer(b, SizeOf(Byte));
    //Stream.WriteBuffer(PChar(ExpCols[i].FieldName)^,Length(ExpCols[i].FieldName)+1);

    SreamWriteNullAnsiStr(Stream);
    //Stream.WriteBuffer(PChar('')^, 1);
  end;
end;

procedure TDBGridEhExportAsVCLDBIF.WriteSuffix;
var b: Byte;
begin
  b := TVCLDBIF_TYPE_EOF;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

procedure TDBGridEhExportAsVCLDBIF.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  Field: TField;
  FDataFields: TFieldsArrEh;
  StrList: TStringList;
  i: Integer;
begin
  FDataFields := nil;
  if (Column.Field <> nil) and Column.Field.Lookup then
  begin
//    Field := Column.Field.Dataset.FieldByName(Column.Field.KeyFields)
    FDataFields := GetFieldsProperty(Column.Field.Dataset, nil, Column.Field.KeyFields);
    StrList := TStringList.Create;
    try
      for i := 0 to Length(FDataFields)-1 do
        StrList.Add(FDataFields[i].AsString);
      WriteWideString(WideString(StrList.CommaText));
    finally
      FreeAndNil(StrList);
    end;
  end else
  begin
    Field := Column.Field;
    if Field = nil then
      WriteUnassigned
    else if Field.IsNull then
      WriteNull
    else
      with Field do
        case DataType of
          ftSmallint, ftInteger, ftWord, ftAutoInc
{$IFDEF EH_LIB_12}, ftShortint, ftByte {$ENDIF}
            :WriteInteger(AsInteger);

          ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime
{$IFDEF EH_LIB_6}, ftTimeStamp, ftFMTBcd{$ENDIF}
            :WriteFloat(AsFloat);

          ftString, ftBoolean, ftFixedChar, ftMemo, ftLargeint
{$IFDEF EH_LIB_5}, ftGuid, ftOraClob{$ENDIF}
{$IFDEF EH_LIB_10}, ftOraTimeStamp, ftOraInterval {$ENDIF}
{$IFDEF EH_LIB_12}, ftLongWord , ftExtended {$ENDIF}
{$IFDEF EH_LIB_12}
            :WriteAnsiString(AsAnsiString);
{$ELSE}
            :WriteAnsiString(AsString);
{$ENDIF}

          ftBlob, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle,
{$IFDEF EH_LIB_5}ftOraBlob, {$ENDIF}
          ftBytes, ftTypedBinary, ftVarBytes
{$IFDEF EH_LIB_12}
            :WriteBinaryData(AsAnsiString);
{$ELSE}
            :WriteBinaryData(AsString);
{$ENDIF}
          ftWideString
{$IFDEF EH_LIB_10}, ftFixedWideChar , ftWideMemo {$ENDIF}
{$IFDEF EH_LIB_12}
            :WriteWideString(AsWideString);
{$ELSE}
            :WriteWideString(TWideStringField(Field).Value);
{$ENDIF}
        else
          WriteUnassigned;
        end;
  end;
end;

procedure TDBGridEhExportAsVCLDBIF.WriteBinaryData(AValue: AnsiString);
var
  BinaryValue: TVCLDBIF_BINARY_DATA;
begin
  BinaryValue.AType := TVCLDBIF_TYPE_BINARY_DATA;
  BinaryValue.Size := Length(AValue);

  StreamWriteStruct(Stream, BinaryValue, SizeOf(BinaryValue));
//  Stream.WriteBuffer(BinaryValue, SizeOf(BinaryValue));

  StreamWriteAnsiString(Stream, AValue);
//  Stream.WriteBuffer(Pointer(AValue)^, BinaryValue.Size);
end;

procedure TDBGridEhExportAsVCLDBIF.WriteFloat(AValue: Double);
var
  FloatValue: TVCLDBIF_FLOAT64;
begin
  FloatValue.AType := TVCLDBIF_TYPE_FLOAT64;
  FloatValue.Value := AValue;

  StreamWriteStruct(Stream, FloatValue, SizeOf(FloatValue));
//  Stream.WriteBuffer(FloatValue, SizeOf(FloatValue));
end;

procedure TDBGridEhExportAsVCLDBIF.WriteInteger(AValue: Integer);
var
  IntValue: TVCLDBIF_INTEGER32;
begin
  IntValue.AType := TVCLDBIF_TYPE_INTEGER32;
  IntValue.Value := AValue;
  StreamWriteStruct(Stream, IntValue, SizeOf(IntValue));
//  Stream.WriteBuffer(IntValue, SizeOf(IntValue));
end;

procedure TDBGridEhExportAsVCLDBIF.WriteNull;
var b: Byte;
begin
  b := TVCLDBIF_TYPE_NULL;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

procedure TDBGridEhExportAsVCLDBIF.WriteAnsiString(AValue: AnsiString);
var
  StringValue: TVCLDBIF_ANSI_STRING;
begin
  StringValue.AType := TVCLDBIF_TYPE_ANSI_STRING;
  StringValue.Size := Length(AValue);

  StreamWriteStruct(Stream, StringValue, SizeOf(StringValue));
//  Stream.WriteBuffer(StringValue, SizeOf(StringValue));

  StreamWriteAnsiString(Stream, AValue);
//  Stream.WriteBuffer(Pointer(AValue)^, StringValue.Size);
end;

procedure TDBGridEhExportAsVCLDBIF.WriteWideString(AValue: WideString);
var
  StringValue: TVCLDBIF_WIDE_STRING;
begin
  StringValue.AType := TVCLDBIF_TYPE_WIDE_STRING;
  StringValue.Size := Length(AValue)*2;

  StreamWriteStruct(Stream, StringValue, SizeOf(StringValue));
//  Stream.WriteBuffer(StringValue, SizeOf(StringValue));

  StreamWriteWideString(Stream, AValue);
//  Stream.WriteBuffer(Pointer(AValue)^, StringValue.Size);
end;

procedure TDBGridEhExportAsVCLDBIF.WriteUnassigned;
var b: Byte;
begin
  b := TVCLDBIF_TYPE_UNASSIGNED;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

{function TDBGridEhExportAsVCLDBIF.CalcColCount: Word;
var i:Integer;
begin
  Result := 0;
  with DBGridEh do
  begin
    if Selection.SelectionType = gstNon then Exit;
    case Selection.SelectionType of
      gstRecordBookmarks:
        Result := VisibleColumns.Count;
      gstRectangle:
        for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
          if Columns[i].Visible then
            Inc(Result);
      gstColumns:
        Result := Selection.Columns.Count;
      gstAll:
        Result := VisibleColumns.Count;
    end;
  end;
end;}

function StreamReadAnsiString(Stream: TStream; var S: AnsiString; Count: Longint): Longint;
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    Result := Stream.Read(b, Count);
    S := StringOf(b);
{$ELSE}
    SetString(S, nil, Count);
    Result := Stream.Read(S[1], Count);
{$ENDIF}
end;

function StreamReadWideString(Stream: TStream; var S: WideString; Size: Longint): Longint;
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    Result := Stream.Read(b, Size);
    S := StringOf(b);
{$ELSE}
    SetString(S, nil, Size div 2);
    Result := Stream.Read(S[1], Size);
{$ENDIF}
end;

{$IFDEF CIL}
function StreamReadStruct(Stream: TStream; AStruct: TObject; ASize: Integer): Longint;
var
  b: TBytes;
  Mem: IntPtr;
begin
  Mem := Marshal.AllocHGlobal(Marshal.SizeOf(AStruct));
  try
    Result := Stream.Read(b, Marshal.SizeOf(AStruct));
{ TODO : To do finish }
    Marshal.StructureToPtr(AStruct, Mem, False);
    SetLength(b, Marshal.SizeOf(AStruct));
    Marshal.Copy(Mem, b, 0, Length(b));
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;

{$ELSE}

function StreamReadStruct(Stream: TStream; var AStruct; ASize: Integer): Longint;
begin
  Result := Stream.Read(AStruct, ASize);
end;

{$ENDIF}

{ TDBGridEhImport }


constructor TDBGridEhImport.Create;
begin
  inherited Create;
end;

procedure TDBGridEhImport.ImportFromFile(FileName: String; IsImportAll: Boolean);
var FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    ImportFromStream(FileStream, IsImportAll);
  finally
    FileStream.Free;
  end;
end;

procedure TDBGridEhImport.ImportFromStream(AStream: TStream; IsImportAll: Boolean);
var i: Integer;
  ColList: TColumnsEhList;
  Inserting: Boolean;
  Appending: Boolean;
  procedure DoInserting;
  begin
    with DBGridEh.DataSource.Dataset do
      while not Eos do
      begin
        if Appending then Append else Insert;
        ReadRecord(ImpCols);
        Post;
        if not Appending then Next;
      end
  end;
begin
  Stream := AStream;
  Eos := False;
  with DBGridEh do
  begin
//    if Selection.SelectionType = gstNon then Exit;
    if IsImportAll then
    begin
      Selection.Clear;
      DataSource.Dataset.First;
      if VisibleColumns.Count > 0 then
        SelectedIndex := VisibleColumns.Items[0].Index;
    end;
    with DataSource.Dataset do
    begin
      if Eof then Appending := True else Appending := False;
      if State = dsInsert then Inserting := True else Inserting := False;
      if not Inserting then SaveBookmark;
      DisableControls;
      try
        case Selection.SelectionType of
          gstRecordBookmarks:
            begin
              ImpCols := VisibleColumns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
                for i := 0 to Selection.Rows.Count - 1 do
                begin
                  Bookmark := Selection.Rows[I];
                  ReadRecord(VisibleColumns);
                end;
            end;
          gstRectangle:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := Selection.Rect.LeftCol to Selection.Rect.RightCol do
                  if Columns[i].Visible then
                    ColList.Add(Columns[i]);
                ImpCols := ColList;
                ReadPrefix;
                if Inserting then
                  DoInserting
                else
                begin
                  Bookmark := Selection.Rect.TopRow;
                  while True do
                  begin
                    ReadRecord(ColList);
                    if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset, Selection.Rect.BottomRow, Bookmark) = 0 then Break;
//                    if CompareBookmarks(Pointer(Selection.Rect.BottomRow), Pointer(Bookmark)) = 0 then Break;
                    Next;
                    if Eof then Break;
                  end;
                end;
              finally
                ColList.Free;
              end;
            end;
          gstColumns:
            begin
              ImpCols := Selection.Columns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
              begin
                First;
                while Eof = False do
                begin
                  ReadRecord(Selection.Columns);
                  Next;
                end;
              end;
            end;
          gstAll:
            begin
              ImpCols := VisibleColumns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
              begin
                First;
                while Eof = False do
                begin
                  ReadRecord(VisibleColumns);
                  Next;
                end;
              end;
            end;
          gstNon:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := SelectedIndex to Columns.Count - 1 do
                  if Columns[i].Visible then ColList.Add(Columns[i]);
                ImpCols := ColList;
                ReadPrefix;
                if Inserting then
                  DoInserting
                else
                begin
                  RestoreBookmark;
                  while True do
                  begin
                    ReadRecord(ColList);
                    Next;
                    if Eof or Eos then Break;
                  end;
                  if alopAppendEh in DBGridEh.AllowedOperations then
                  begin
                    Inserting := True;
                    Appending := True;
                    DoInserting;
                  end;
                end;
              finally
                ColList.Free;
              end;
            end;
        end;
      finally
        if not Inserting then RestoreBookmark;
        EnableControls;
      end;
    end;
  end;
  ReadSuffix;
end;

procedure TDBGridEhImport.ReadPrefix;
begin
end;

procedure TDBGridEhImport.ReadRecord(ColumnsList: TColumnsEhList);
var i: Integer;
begin
  for i := 0 to ColumnsList.Count - 1 do
    ReadDataCell(ColumnsList[i]);
end;

procedure TDBGridEhImport.ReadDataCell(Column: TColumnEh);
begin
end;

procedure TDBGridEhImport.ReadSuffix;
begin
end;

{ TDBGridEhImportAsText }

function TDBGridEhImportAsText.CheckState: TImportTextSreamState;
begin
  if GetChar(FLastChar) then
  begin
    if FLastChar = #09 then
      if (FLastState in [itssNewLine,itssTab]) then
      begin
        FLastChar := #00;
        Result := itssChar;
        if Stream.Position >= SizeOf(AnsiChar) then
          Stream.Position := Stream.Position - SizeOf(AnsiChar);
      end else
        Result := itssTab
    else if FLastChar = #13 then
    begin
      if GetChar(FLastChar) and (FLastChar = #10) then
        if (FLastState in [itssNewLine,itssTab]) then
        begin
          FLastChar := #00;
          Result := itssChar;
          if Stream.Position >= SizeOf(AnsiChar)*2 then
            Stream.Position := Stream.Position - SizeOf(AnsiChar) * 2;
        end else
          Result := itssNewLine
      else
        raise Exception.Create('TDBGridEhImportAsText.CheckState: ' + SInvalidTextFormatEh);
    end else if FLastChar = #00 then
    begin
      Result := itssEof;
      Eos := True;
    end else
      Result := itssChar;
  end else
  begin
    Result := itssEof;
    Eos := True;
  end;
  FLastState := Result;
end;

function TDBGridEhImportAsText.GetChar(var ch: AnsiChar): Boolean;
var
  Count: Longint;
begin
  Result := False;
  if Stream.Position = Stream.Size-1 then Exit;
  Count := Stream.Read(ch, SizeOf(AnsiChar));
  if Count = SizeOf(AnsiChar) then Result := True;
end;

function TDBGridEhImportAsText.GetString(var Value: AnsiString): TImportTextSreamState;
begin
  Result := itssChar;
  Value := '';
  if FLastState = itssChar then
    Value := FLastChar;
  while True do
  begin
    Result := CheckState;
    if not (Result = itssChar) then Break;
    Value := Value + FLastChar;
  end;
//  if Result = itssTab then CheckState;
end;

procedure TDBGridEhImportAsText.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  inherited ImportFromStream(AStream, IsImportAll);
end;

procedure TDBGridEhImportAsText.ReadPrefix;
begin
  FLastState := itssNewLine;
  CheckState;
end;

procedure TDBGridEhImportAsText.ReadDataCell(Column: TColumnEh);
var
  ModalResult: Word;
  Field: TField;
  idx: Integer;
begin
  if Column.CanModify(False) then
  begin
    if Column.Field.FieldKind = fkLookUp then
    begin
      if Column.Field.KeyFields <> ''
      then Field := Column.Field
      else Exit;
    end else
      Field := Column.Field;
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if Column.Field.FieldKind = fkLookUp then
        begin
          if Column.Field.LookupDataSet.Locate(Column.Field.LookupResultField,
            FLastString, [loCaseInsensitive, loPartialKey])
          then
            Column.Field.DataSet[Column.Field.KeyFields] :=
              Column.Field.LookupDataSet[Column.Field.LookupKeyFields];
        end
        else if Column.GetColumnType = ctKeyPickList then
        begin
          idx := Column.PickList.IndexOf(String(FLastString));
          if (idx <> -1) then
            Field.AsString := Column.KeyList.Strings[idx]
          else
            Field.Clear;
        end else
          Field.AsString :=
            Column.GetAcceptableEditText(String(FLastString));
      except
        on E: Exception do
        begin
          if not FIgnoreAll then
          begin
            ModalResult := MessageDlg(SErrorDuringInsertValueEh + #10 +
              E.Message + #10 + #10 + SIgnoreErrorEh, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: FIgnoreAll := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDBGridEhImportAsText.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  if FLastState = itssEof then Exit;
  i := 0;
  if FLastState = itssChar then
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  while not (FLastState in [itssNewLine, itssEof]) do
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  CheckState;
end;

{ TDBGridEhImportAsUnicodeText }

function TDBGridEhImportAsUnicodeText.CheckState: TImportTextSreamState;
begin
  if GetChar(FLastChar) then
  begin
    if FLastChar = #09 then
      if (FLastState in [itssNewLine,itssTab]) then
      begin
        FLastChar := #00;
        Result := itssChar;
        if Stream.Position >= SizeOf(WideChar) then
          Stream.Position := Stream.Position - SizeOf(WideChar);
      end else
        Result := itssTab
    else if FLastChar = #13 then
    begin
      if GetChar(FLastChar) and (FLastChar = #10) then
        if (FLastState in [itssNewLine,itssTab]) then
        begin
          FLastChar := #00;
          Result := itssChar;
          if Stream.Position >= SizeOf(WideChar)*2 then
            Stream.Position := Stream.Position - SizeOf(WideChar) * 2;
        end else
          Result := itssNewLine
      else
        raise Exception.Create('TDBGridEhImportAsUnicodeText.CheckState: ' + SInvalidTextFormatEh);
    end else if FLastChar = #00 then
    begin
      Result := itssEof;
      Eos := True;
    end else
      Result := itssChar;
  end else
  begin
    Result := itssEof;
    Eos := True;
  end;
  FLastState := Result;
end;

function TDBGridEhImportAsUnicodeText.GetChar(var ch: WideChar): Boolean;
var
  Count: Longint;
begin
  Result := False;
  if Stream.Position = Stream.Size-1 then Exit;
  Count := Stream.Read(ch, SizeOf(WideChar));
  if Count = SizeOf(WideChar) then Result := True;
end;

function TDBGridEhImportAsUnicodeText.GetString(var Value: WideString): TImportTextSreamState;
begin
  Result := itssChar;
  Value := '';
  if FLastState = itssChar then
    Value := FLastChar;
  while True do
  begin
    Result := CheckState;
    if not (Result = itssChar) then Break;
    Value := Value + FLastChar;
  end;
//  if Result = itssTab then CheckState;
end;

procedure TDBGridEhImportAsUnicodeText.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  inherited ImportFromStream(AStream, IsImportAll);
end;

procedure TDBGridEhImportAsUnicodeText.ReadPrefix;
begin
  FLastState := itssNewLine;
  CheckState;
end;

procedure TDBGridEhImportAsUnicodeText.ReadDataCell(Column: TColumnEh);
var
  ModalResult: Word;
  Field: TField;
  idx: Integer;
begin
  if Column.CanModify(False) then
  begin
    if Column.Field.FieldKind = fkLookUp then
    begin
      if Column.Field.KeyFields <> '' then
        Field := Column.Field
      else
        Exit;
    end else
      Field := Column.Field;
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if Column.Field.FieldKind = fkLookUp then
        begin
          if Column.Field.LookupDataSet.Locate(Column.Field.LookupResultField,
            FLastString, [loCaseInsensitive, loPartialKey])
          then
            Column.Field.DataSet[Column.Field.KeyFields] :=
              Column.Field.LookupDataSet[Column.Field.LookupKeyFields];
        end
        else if Column.GetColumnType = ctKeyPickList then
        begin
          idx := Column.PickList.IndexOf(String(FLastString));
          if (idx <> -1) then
            Field.AsString := Column.KeyList.Strings[idx]
          else
            Field.Clear;
        end else
          Field.AsString :=
            Column.GetAcceptableEditText(String(FLastString));
      except
        on E: Exception do
        begin
          if not FIgnoreAll then
          begin
            ModalResult := MessageDlg(SErrorDuringInsertValueEh + #10 +
              E.Message + #10 + #10 + SIgnoreErrorEh, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: FIgnoreAll := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDBGridEhImportAsUnicodeText.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  if FLastState = itssEof then Exit;
  i := 0;
  if FLastState = itssChar then
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  while not (FLastState in [itssNewLine, itssEof]) do
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  CheckState;
end;

{ TDBGridEhImportAsVCLDBIF }

procedure TDBGridEhImportAsVCLDBIF.ReadPrefix;
var Count: Longint;
  i: Integer;
  b: Byte;
  ch: AnsiChar;
  FieldName: String;
begin
//  Count := Stream.Read(Prefix, SizeOf(TVCLDBIF_BOF));
  Count := StreamReadStruct(Stream, Prefix, SizeOf(TVCLDBIF_BOF));
  if Count < SizeOf(TVCLDBIF_BOF) then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
  if Prefix.Signatura <> 'VCLDBIF' then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
  for i := 0 to Prefix.ColCount - 1 do
  begin
    Count := Stream.Read(b, SizeOf(Byte));
    if Count < SizeOf(Byte) then
      raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
    FieldName := '';
    while True do
    begin
      Count := Stream.Read(ch, SizeOf(AnsiChar));
      if Count < SizeOf(Byte) then
        raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
      if ch <> #0 then FieldName := FieldName + String(ch)
      else Break;
    end;
    if FieldName <> '' then UseFieldNames := True;
    FieldNames.AddObject(FieldName, TObject(b));
  end;

  ReadValue;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadDataCell(Column: TColumnEh);
var
  ModalResult: Word;
  Field: TField;
  FDataFields: TFieldsArrEh;
  StrList: TStringList;
  i: Integer;

  procedure SetValue(SetAsString: Boolean);
  begin
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if SetAsString
          then Field.AsString := LastValue
          else Field.Value := LastValue;
      except
        on E: Exception do
        begin
          if not FIgnoreAll then
          begin
            ModalResult := MessageDlg(SErrorDuringInsertValueEh + #10 + E.Message + #10 + #10 +
              SIgnoreErrorEh, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: FIgnoreAll := True;
            end;
          end;
        end;
      end;
    end;
  end;
begin
  FDataFields := nil;
  if not VarIsEmpty(LastValue) and Assigned(Column) then
  begin
    if Column.CanModify(False) then
    begin
      if (Column.Field <> nil) and Column.Field.Lookup then
      begin
        FDataFields := GetFieldsProperty(Column.Field.Dataset, nil, Column.Field.KeyFields);
        StrList := TStringList.Create;
        try
          StrList.CommaText := String(LastValue);
          for i := 0 to Length(FDataFields)-1 do
          begin
            Field := FDataFields[i];
            LastValue := StrList[i];
            SetValue(True);
          end;
        finally
          FreeAndNil(StrList);
        end;
      end else
      begin
        Field := Column.Field;
        SetValue(False);
      end;
    end;
  end;
  ReadValue;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadRecord(ColumnsList: TColumnsEhList);
var i: Integer;
begin
  for i := 0 to Prefix.ColCount - 1 do
  begin
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i])
    else ReadDataCell(nil);
  end;
end;

procedure TDBGridEhImportAsVCLDBIF.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  UseFieldNames := False;
  FieldNames := TStringList.Create;
  try
    inherited ImportFromStream(AStream, IsImportAll);
  finally
    FieldNames.Free;
  end;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadValue;
var AType: Byte;
  Count: Longint;
  LongintValue: Longint;
  DoubleValue: Double;
  StringSize: Longint;
  AnsiStringValue: AnsiString;
  WideStringValue: WideString;
begin
  if Eos then Exit;
  Count := Stream.Read(AType, SizeOf(Byte));
  if Count < SizeOf(Byte) then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
  LastValue := Unassigned;
  case AType of
    TVCLDBIF_TYPE_EOF:
      Eos := True;
    TVCLDBIF_TYPE_NULL:
      LastValue := Null;
    TVCLDBIF_TYPE_INTEGER32:
      begin
        Count := Stream.Read(LongintValue, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        LastValue := LongintValue;
      end;
    TVCLDBIF_TYPE_FLOAT64:
      begin
        Count := Stream.Read(DoubleValue, SizeOf(Double));
        if Count < SizeOf(Double) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        LastValue := DoubleValue;
      end;
    TVCLDBIF_TYPE_ANSI_STRING, TVCLDBIF_TYPE_BINARY_DATA:
      begin
        Count := Stream.Read(StringSize, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
//        SetString(StringValue, nil, StringSize);
//        Count := Stream.Read(StringValue[1], StringSize);
        Count := StreamReadAnsiString(Stream, AnsiStringValue, StringSize);
        if Count < StringSize then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        LastValue := AnsiStringValue;
      end;
    TVCLDBIF_TYPE_WIDE_STRING:
      begin
        Count := Stream.Read(StringSize, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
//        SetString(StringValue, nil, StringSize);
//        Count := Stream.Read(StringValue[1], StringSize);
        Count := StreamReadWideString(Stream, WideStringValue, StringSize);
        if Count < StringSize then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + SInvalidVCLDBIFFormatEh);
        LastValue := WideStringValue;
      end;
  end;
end;

initialization

  CF_VCLDBIF := RegisterClipboardFormat('VCLDBIF');
  CF_CSV := RegisterClipboardFormat('Csv');
  CF_RICH_TEXT_FORMAT := RegisterClipboardFormat('Rich Text Format');

//  CF_BIFF := RegisterClipboardFormat('Biff');
//  CF_HTML_FORMAT := RegisterClipboardFormat('HTML Format');

end.
