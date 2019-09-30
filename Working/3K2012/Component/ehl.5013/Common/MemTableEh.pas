{*******************************************************}
{                                                       }
{                      EhLib v5.0                       }
{                 TMemTableEh component                 }
{                     Build 5.1.02                      }
{                                                       }
{      Copyright (c) 2004-09 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit MemTableEh;// {$IFDEF CIL} platform{$ENDIF};

{$I EHLIB.INC}

interface

uses Windows, SysUtils, Classes, Controls, DB, Dialogs,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF CIL}
  System.Runtime.InteropServices,
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, MemTreeEh;

type

  TCustomMemTableEh = class;

  TLoadMode = (lmCopy, lmAppend);

// TMemTableOptionsEh = ddoCascadeDeletesEh, ddoCascadeUpdatesEh

{ TMasterDataLinkEh }

  TMasterDataLinkEh = class(TDetailDataLink)
  private
    FDataSet: TDataSet;
    FFieldNames: string;
    FFields: TObjectList;
    FOnMasterChange: TNotifyEvent;
    FOnMasterDisable: TNotifyEvent;
    procedure SetFieldNames(const Value: string);
  protected
    function GetDetailDataSet: TDataSet; override;
    procedure ActiveChanged; override;
    procedure CheckBrowseMode; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(DataSet: TDataSet);
    destructor Destroy; override;
    property FieldNames: string read FFieldNames write SetFieldNames;
    property Fields: TObjectList read FFields;
    property OnMasterChange: TNotifyEvent read FOnMasterChange write FOnMasterChange;
    property OnMasterDisable: TNotifyEvent read FOnMasterDisable write FOnMasterDisable;
  end;

{ TMemTableTreeListEh }

  TMemTableTreeListEh = class(TPersistent)
  private
    FMemTable: TCustomMemTableEh;
    FLoadingActive: Boolean;
    function GetActive: Boolean;
    function GetDefaultNodeExpanded: Boolean;
    function GetDefaultNodeHasChildren: Boolean;
    function GetFilterNodeIfParentVisible: Boolean;
    function GetFullBuildCheck: Boolean;
    function GetKeyFieldName: String;
    function GetRefParentFieldName: String;
    procedure SetActive(const Value: Boolean);
    procedure SetDefaultNodeExpanded(const Value: Boolean);
    procedure SetDefaultNodeHasChildren(const Value: Boolean);
    procedure SetFilterNodeIfParentVisible(const Value: Boolean);
    procedure SetFullBuildCheck(const Value: Boolean);
    procedure SetKeyFieldName(const Value: String);
    procedure SetRefParentFieldName(const Value: String);
  public
    constructor Create(AMemTable: TCustomMemTableEh);
    function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean; virtual;
    procedure FullCollapse; virtual;
    procedure FullExpand; virtual;
  published
    property Active: Boolean read GetActive write SetActive default False;
    property KeyFieldName: String read GetKeyFieldName write SetKeyFieldName;
    property RefParentFieldName: String read GetRefParentFieldName write SetRefParentFieldName;
    property DefaultNodeExpanded: Boolean read GetDefaultNodeExpanded write SetDefaultNodeExpanded default False;
    property DefaultNodeHasChildren: Boolean read GetDefaultNodeHasChildren write SetDefaultNodeHasChildren default False;
    property FullBuildCheck: Boolean read GetFullBuildCheck write SetFullBuildCheck default True;
    property FilterNodeIfParentVisible: Boolean read GetFilterNodeIfParentVisible write SetFilterNodeIfParentVisible default True;
  end;

{ TCustomMemTableEh }

  TMasterDetailSideEh = (mdsOnSelfEh, mdsOnProviderEh, mdsOnSelfAfterProviderEh);

  TMTUpdateActionEh = (uaFailEh, uaAbortEh, uaSkipEh, uaRetryEh, uaApplyEh, uaAppliedEh);

  TMTUpdateRecordEventEh = procedure(DeltaDataSet: TDataSet; UpdateKind: TUpdateKind;
    var UpdateAction: TMTUpdateActionEh) of object;

  TMTFetchRecordEventEh = procedure(PacketDataSet: TDataSet; var ProviderEOF,
    Applied: Boolean) of object;

  TMTRefreshRecordEventEh = procedure(PacketDataSet: TDataSet; var Applied: Boolean)
    of object;

  TMTTreeNodeExpandingEventEh = procedure(Sender: TObject; RecNo: Integer;
    var AllowExpansion: Boolean) of object;

  TRecordsViewTreeNodeExpandingEventEh = procedure (Sender: TObject; Node: TMemRecViewEh;
    var AllowExpansion: Boolean) of object;

  TRecordsViewTreeNodeExpandedEventEh = procedure (Sender: TObject; Node: TMemRecViewEh) of object;

  TRecordsViewCheckMoveNodeEventEh = function (Sender: TObject;
    SourceNode, AppointedParent: TMemRecViewEh; AppointedIndex: Integer): Boolean of object;

  TMemTableChangeFieldValueEventEh = procedure (MemTable: TCustomMemTableEh;
    Field: TField; var Value: Variant) of object;

{  TRecInfo = record
    Bookmark: TRecIdEh;
    BookmarkFlag: TBookmarkFlag;
    RecordStatus: Integer;
    RecordNumber: Integer;
    NewTreeNodeExpanded: Boolean;
    NewTreeNodeHasChildren: Boolean;
    TreeNode: TMemRecViewEh;
  end;}

{  TFieldValBuf = record
    VarValue: Variant;
  end;

  PFieldValBuf = ^TFieldValBuf;}

  TFBRecBufValues = array of Variant;

{ TRecBuf }

  TRecBuf = class(TObject)
  private
//    function GetTreeNode: TMemRecViewEh;
//    function GetMemRec: TMemoryRecordEh;
  public
    InUse: Boolean;
    Bookmark: Integer;
    BookmarkFlag: TBookmarkFlag;
    RecordStatus: Integer;
    RecordNumber: Integer;
    NewTreeNodeExpanded: Boolean;
    NewTreeNodeHasChildren: Boolean;
    RecView: TMemRecViewEh;
    MemRec: TMemoryRecordEh;
//    RecordsView: TRecordsViewEh;
    Values: TFBRecBufValues;
    UseMemRec: Boolean;
    function GetValue(Field: TField): Variant;
    function ReadValueCount: Integer;
    procedure SetValue(Field: TField; v: Variant);
    procedure SetLength(Len: Integer);
    procedure Clear;
    destructor Destroy; override;
    property Value[Field: TField]: Variant read GetValue write SetValue;
    property ValueCount: Integer read ReadValueCount;
//    property TreeNode: TMemRecViewEh read GetTreeNode;
//    property MemRec: TMemoryRecordEh read GetMemRec;
  end;

//  PRecBuf = ^TRecBuf;

  TSortedVarItemEh = class (TObject)
  protected
    Value:Variant;
  public
    constructor Create(NewValue:variant);
  end;

  TSortedVarlistEh = class(TObjectList)
  protected
    function  VarInList(Value:variant):boolean;
    function  FindValueIndex(Value: Variant; var Index: Integer):boolean;
  public
    function Add(AObject: TSortedVarItemEh): Integer;
    procedure Insert(Index: Integer; AObject: TSortedVarItemEh);
  end;

  TCustomMemTableEh = class(TDataSet, IMemTableEh {$IFNDEF CIL}, IUnknown{$ENDIF})
  private
    FStateInsert: Boolean;
    FEventReceivers: TObjectList;
    FRecordCache: TObjectList;
    FActive: Boolean;
    FAutoInc: Longint;
//    FCachedUpdates: Boolean;
    FCalcFieldIndexes: array of Integer;
    FDataDriver: TDataDriverEh;
//    FDataRecordSize: Integer;
    FDataSetReader: TDataSet;
    FDetailFieldList: TObjectList;
    FDetailFields: String;
    FDetailMode: Boolean;
    FFetchAllOnOpen: Boolean;
    FFilterExpr: TDataSetExprParserEh;
{$IFDEF CIL}
//    FInstantBuffer: TRecordBuffer;
{$ELSE}
//    FInstantBuffer: PChar;
{$ENDIF}
    FInstantBuffers: TObjectList;
    FInstantReadCurRowNum: Integer;
//    FKeyFields: String;
    FMasterDetailSide: TMasterDetailSideEh;
    FMasterValues: Variant;
//    FOnFetchRecord: TMTFetchRecordEventEh;
    FOnTreeNodeExpanding: TMTTreeNodeExpandingEventEh;
    FOnRecordsViewTreeNodeExpanding: TRecordsViewTreeNodeExpandingEventEh;
    FOnRecordsViewTreeNodeExpanded: TRecordsViewTreeNodeExpandedEventEh;
    FOnRecordsViewCheckMoveNode: TRecordsViewCheckMoveNodeEventEh;
//    FOnUpdateRecord: TMTUpdateRecordEventEh;
//    FOrderByList: TList;
    FParams: TParams;
    FReadOnly: Boolean;
    FRecBufSize: Integer;
    FRecordPos: Integer;
    FRecordsView: TRecordsViewEh;
    FTreeList: TMemTableTreeListEh;
    FIndexDefs: TIndexDefs;
    FStoreDefs: Boolean;
    FDetailRecList: TObjectList;
    FDetailRecListActive: Boolean;
    FInternMemTableData: TMemTableDataEh;
    FExternalMemData: TCustomMemTableEh;
    FRecordsViewUpdating: Integer;
    FRecordsViewUpdated: Boolean;
    FMasterValList: TSortedVarlistEh;
    FSortOrder: String;
    FOnGetFieldValue: TMemTableChangeFieldValueEventEh;
    FOnSetFieldValue: TMemTableChangeFieldValueEventEh;
    FMTViewDataEventInactiveCount: Integer;
    FInactiveEventRowNum: Integer;
    FInactiveEvent: TMTViewEventTypeEh;
    FInactiveEventOldRowNum: Integer;
    FOldControlsDisabled: Boolean;
    FOldActive: Boolean;

    procedure BeginRecordsViewUpdate;
    procedure EndRecordsViewUpdate(AutoResync: Boolean);
    function GetAggregatesActive: Boolean;
    function GetAutoIncrement: TAutoIncrementEh;
    function GetCachedUpdates: Boolean;
    function GetDataFieldsCount: Integer;
    function GetInstantReadCurRowNum: Integer;
//    function GetKeyFields: String;
    function GetMasterFields: String;
    function GetMasterSource: TDataSource;
    function GetTreeNode: TMemRecViewEh;
    function GetTreeNodeChildCount: Integer;
    function GetTreeNodeExpanded: Boolean;
    function GetTreeNodeHasChildren: Boolean;
    function GetUpdateError: TUpdateErrorEh;
    function GetIndexDefs: TIndexDefs;
{$IFDEF CIL}
    function GetInstantBuffer: TRecordBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
    function GetInstantBuffer: TRecordBuffer;
{$ELSE}
    function GetInstantBuffer: PChar;
{$ENDIF}
{$ENDIF}
    function IsRecordInFilter(Rec: TMemoryRecordEh): Boolean;
    procedure AncestorNotFound(Reader: TReader; const ComponentName: string; ComponentClass: TPersistentClass; var Component: TComponent);
    procedure ClearRecords;
    procedure CreateComponent(Reader: TReader; ComponentClass: TComponentClass; var Component: TComponent);
    procedure InitBufferPointers(GetProps: Boolean);
    procedure RefreshParams;
    procedure SetAggregatesActive(const Value: Boolean);
    procedure SetAutoIncrement(const Value: TAutoIncrementEh);
    procedure SetCachedUpdates(const Value: Boolean);
    procedure SetDataDriver(const Value: TDataDriverEh);
    procedure SetDetailFields(const Value: String);
    procedure SetExternalMemData(Value: TCustomMemTableEh);
//    procedure SetKeyFields(const Value: String);
    procedure SetMasterDetailSide(const Value: TMasterDetailSideEh);
    procedure SetMasterFields(const Value: String);
    procedure SetMasterSource(const Value: TDataSource);
    procedure SetParams(const Value: TParams);
    procedure SetParamsFromCursor;
    procedure SetTreeNodeExpanded(const Value: Boolean);
    procedure SetTreeNodeHasChildren(const Value: Boolean);
    procedure SetIndexDefs(Value: TIndexDefs);
    procedure SortData(ParamSort: TObject);
    function GetSortOrder: String;
    procedure SetSortOrder(const Value: String);
    function GetStatusFilter: TUpdateStatusSet;
    procedure SetStatusFilter(const Value: TUpdateStatusSet);
    procedure SetReadOnly(const Value: Boolean);
  protected
    { IProviderSupport }
    function PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs; override;
  protected
    FInstantReadMode: Boolean;
    FMasterDataLink: TMasterDataLinkEh;
    FAutoIncrementFieldName: String;

    function GetActiveRecBuf(var RecBuf: TRecBuf; IsForWrite: Boolean = False): Boolean; virtual;
    function GetTreeNodeHasChields: Boolean;
    function GetTreeNodeLevel: Integer;
    function GetRecObject: TObject;
    function GetPrevVisibleTreeNodeLevel: Integer;
    function GetNextVisibleTreeNodeLevel: Integer;
    function MemTableIsTreeList: Boolean;
    function ParentHasNextSibling(ParenLevel: Integer): Boolean;
    function IMemTableGetTreeNodeExpanded(RowNum: Integer): Boolean;
    function IMemTableEh.GetTreeNodeExpanded = IMemTableGetTreeNodeExpanded;
    function IMemTableSetTreeNodeExpanded(RowNum: Integer; Value: Boolean): Integer;
    function IMemTableEh.SetTreeNodeExpanded = IMemTableSetTreeNodeExpanded;
    function GetFieldValueList(AFieldName: String): IMemTableDataFieldValueListEh;

    procedure RecreateFilterExpr;
    procedure DestroyFilterExpr;

{$IFNDEF EH_LIB_5}
    function BCDToCurr(BCD: Pointer; var Curr: Currency): Boolean; override;
    function CurrToBCD(const Curr: Currency; BCD: Pointer; Precision,
      Decimals: Integer): Boolean; override;
{$ENDIF}
{$IFDEF EH_LIB_12}
    function AllocRecordBuffer: TRecordBuffer; override;
{$ELSE}
    function AllocRecordBuffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}; override;
{$ENDIF}
//    function ApplyUpdate(OldRecValues, NewRecValues: PRecValues; UpdateKind: TUpdateKind; TargetDataSet: TDataSet; OutRecValues: PRecValues): Integer;
    function CompareRecords(Rec1, Rec2: TMemoryRecordEh; ParamSort: TObject): Integer; virtual;
    function CompareTreeNodes(Rec1, Rec2: TBaseTreeNodeEh; ParamSort: TObject): Integer; virtual;
    function CreateDeltaDataSet: TCustomMemTableEh;
    function DoFetchRecords(Count: Integer): Integer;
    function FieldValueToVarValue(FieldBuffer: {$IFDEF CIL}TObject{$ELSE}Pointer{$ENDIF}; Field: TField): Variant;
    function GetBlobData(Field: TField; Buffer: TRecBuf): TMemBlobData;
//    function GetBlobData(Field: TField; var Data: Variant): Boolean;
{$IFDEF CIL}
    function BufferToIndex(Buf: TRecordBuffer): Integer;
    function BufferToRecBuf(Buf: TRecordBuffer): TRecBuf;
    function IndexToBuffer(I: Integer):TRecordBuffer;
    function GetBookmarkFlag(Buffer: TRecordBuffer): TBookmarkFlag; override;
    function GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    procedure ClearCalcFields(Buffer: TRecordBuffer); override;
    procedure CopyBuffer(FromBuf, ToBuf: TRecordBuffer);
{$ELSE}
{$IFDEF EH_LIB_12}
    function BufferToIndex(Buf: TRecordBuffer): Integer;
    function BufferToRecBuf(Buf: TRecordBuffer): TRecBuf;
    function IndexToBuffer(I: Integer): TRecordBuffer;
    function GetBookmarkFlag(Buffer: TRecordBuffer): TBookmarkFlag; override;
    function GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    procedure ClearCalcFields(Buffer: TRecordBuffer); override;
    procedure CopyBuffer(FromBuf, ToBuf: TRecordBuffer);
{$ELSE}
    function BufferToIndex(Buf: PChar): Integer;
    function BufferToRecBuf(Buf: PChar): TRecBuf;
    function IndexToBuffer(I: Integer): PChar;
    function GetBookmarkFlag(Buffer: PChar): TBookmarkFlag; override;
    function GetRecord(Buffer: PChar; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    procedure ClearCalcFields(Buffer: PChar); override;
    procedure CopyBuffer(FromBuf, ToBuf: PChar);
{$ENDIF}
{$ENDIF}
    function GetAggregateValue(Field: TField): Variant; override;
    function GetDataSource: TDataSource; override;
    function GetBookmarkStr: TBookmarkStr; override;
    function GetCanModify: Boolean; override;
    function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
    function GetRecNo: Integer; override;
    function GetRecordCount: Integer; override;
    function GetRecordSize: Word; override;
    function GetRec: TMemoryRecordEh;
    function IndexOfBookmark(Bookmark: TBookmark): Integer;
    function IsCursorOpen: Boolean; override;
    function InternalApplyUpdates(AMemTableData: TMemTableDataEh; MaxErrors: Integer): Integer; virtual;
//    function UpdateRecord(DeltaDataSet: TDataSet; UpdateKind: TUpdateKind; RefreshRecord: Boolean): Integer; virtual;
    function ParseOrderByStr(OrderByStr: String): TObject;
    function SetToRec(Rec: TObject): Boolean;
    procedure BindFields(Binding: Boolean); {$IFDEF EH_LIB_12} override; {$ENDIF}
    procedure BindCalFields;
    procedure CloseBlob(Field: TField); override;
    procedure CreateFields; override;
    procedure CreateIndexesFromDefs; virtual;
{$IFDEF CIL}
    procedure DataEvent(Event: TDataEvent; Info: TObject); override;
    procedure DefChanged(Sender: TObject); override;
    procedure FetchRecord(DataSet: TDataSet);
    procedure FreeRecordBuffer(var Buffer: TRecordBuffer); override;
    procedure GetBookmarkData(Buffer: TRecordBuffer; var Bookmark: TBookmark); override;
    procedure InitRecord(Buffer: TRecordBuffer); override;
    procedure InternalAddRecord(Buffer: TRecordBuffer; Append: Boolean); override;
    procedure InternalGotoBookmark(const Bookmark: TBookmark); override;
    procedure InternalInitRecord(Buffer: TRecordBuffer); override;
    procedure InternalSetToRecord(Buffer: TRecordBuffer); override;
    procedure RecordToBuffer(MemRec: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Buffer: TRecordBuffer; RecIndex: Integer);
    procedure SetBookmarkData(Buffer: TRecordBuffer; const Bookmark: TBookmark); override;
    procedure SetBookmarkFlag(Buffer: TRecordBuffer; Value: TBookmarkFlag); override;
    procedure SetFieldData(Field: TField; Buffer: TValueBuffer); override;
    procedure SetFieldData(Field: TField; Buffer: TValueBuffer; NativeFormat: Boolean); override;
    procedure SetMemoryRecordData(Buffer: TRecordBuffer; Rec: TMemoryRecordEh); virtual;
    procedure VarValueToFieldValue(VarValue: Variant; FieldBuffer: TObject; Field: TField);
{$ELSE}
{$IFDEF EH_LIB_12}
    procedure FreeRecordBuffer(var Buffer: TRecordBuffer); override;
    procedure GetBookmarkData(Buffer: TRecordBuffer; Data: Pointer); override;
    procedure InitRecord(Buffer: TRecordBuffer); override;
    procedure InternalGotoBookmark(Bookmark: Pointer); override;
    procedure InternalInitRecord(Buffer: TRecordBuffer); override;
    procedure InternalSetToRecord(Buffer: TRecordBuffer); override;
    procedure RecordToBuffer(MemRec: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Buffer: TRecordBuffer; RecIndex: Integer);
    procedure SetBookmarkData(Buffer: TRecordBuffer; Data: Pointer); override;
    procedure SetBookmarkFlag(Buffer: TRecordBuffer; Value: TBookmarkFlag); override;
    procedure SetMemoryRecordData(Buffer: TRecordBuffer; Rec: TMemoryRecordEh); virtual;
{$ELSE}
    procedure FreeRecordBuffer(var Buffer: PChar); override;
    procedure GetBookmarkData(Buffer: PChar; Data: Pointer); override;
    procedure InitRecord(Buffer: PChar); override;
    procedure InternalGotoBookmark(Bookmark: TBookmark); override;
    procedure InternalInitRecord(Buffer: PChar); override;
    procedure InternalSetToRecord(Buffer: PChar); override;
    procedure RecordToBuffer(MemRec: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Buffer: PChar; RecIndex: Integer);
    procedure SetBookmarkData(Buffer: PChar; Data: Pointer); override;
    procedure SetBookmarkFlag(Buffer: PChar; Value: TBookmarkFlag); override;
    procedure SetMemoryRecordData(Buffer: PChar; Rec: TMemoryRecordEh); virtual;
{$ENDIF}
    procedure DefChanged(Sender: TObject); override;
    procedure DataEvent(Event: TDataEvent; Info: Longint); override;
    procedure FetchRecord(DataSet: TDataSet);
    procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
    procedure SetFieldData(Field: TField; Buffer: Pointer); override;
    procedure SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean); override;
    procedure VarValueToFieldValue(VarValue: Variant; FieldBuffer: Pointer; Field: TField);
{$ENDIF}
    procedure DoOnNewRecord; override;
    procedure DoOrderBy(const OrderByStr: String); virtual;
    procedure ReadState(Reader: TReader); override;
    procedure SetExtraStructParams;
{$IFNDEF CIL}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ENDIF}
    procedure Loaded; override;
    procedure InitFieldDefsFromFields;
    procedure InternalCancel; override;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalFirst; override;
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalInsert; override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalRefresh; override;
    procedure MasterChange(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OpenCursor(InfoQuery: Boolean); override;
    procedure ResetAggField(Field: TField); override;
    procedure SetBlobData(Field: TField; Buffer: TRecBuf; Value: TMemBlobData);
    procedure SetFiltered(Value: Boolean); override;
    procedure SetOnFilterRecord(const Value: TFilterRecordEvent); override;
    procedure SetRecNo(Value: Integer); override;
    procedure UpdateDetailMode(AutoRefresh: Boolean);
    procedure UpdateIndexDefs; override;
    procedure UpdateSortOrder; virtual;
    procedure RegisterEventReceiver(AComponent: TComponent);
    procedure UnregisterEventReceiver(AComponent: TComponent);
    procedure MTViewDataEvent(RowNum: Integer; Event: TMTViewEventTypeEh; OldRowNum: Integer); virtual;
    function ViewRecordIndexToViewRowNum(ViewRecordIndex: Integer): Integer;

    function GetPrefilteredList: TObjectList;
    procedure ViewDataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification);
    procedure ViewRecordMovedEvent(MemRec: TMemoryRecordEh; OldIndex, NewIndex: Integer);
    procedure MTApplyUpdates(AMemTableData: TMemTableDataEh);
    function TreeViewNodeExpanding(Sender: TBaseTreeNodeEh): Boolean;
    procedure TreeViewNodeExpanded(Sender: TBaseTreeNodeEh);
    property AggregatesActive: Boolean read GetAggregatesActive write SetAggregatesActive default False;
    property DataFieldsCount: Integer read GetDataFieldsCount;
{$IFDEF CIL}
    property InstantBuffer: TRecordBuffer read GetInstantBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
    property InstantBuffer: TRecordBuffer read GetInstantBuffer;
{$ELSE}
    property InstantBuffer: PChar read GetInstantBuffer;
{$ENDIF}
{$ENDIF}
//    property InstantBuffer: PChar read GetInstantBuffer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ApplyUpdates(MaxErrors: Integer): Integer; virtual;

    function BookmarkValid({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmark): Boolean; override;
    function BookmarkToRecNo(Bookmark: TBookmark): Integer;
    function BookmarkStrToRecNo(Bookmark: TBookmarkStr): Integer;
{$IFDEF EH_LIB_12}
    function RecNoToBookmarkStr(RecNo: Integer): TBookmarkStr;
    function RecNoToBookmark(RecNo: Integer): TBookmark;
{$ELSE}
    function RecNoToBookmarkStr(RecNo: Integer): TBookmarkStr;
{$ENDIF}
    function CompareBookmarks({$IFDEF CIL}const{$ENDIF} Bookmark1, Bookmark2: TBookmark): Integer; override;
{$IFDEF EH_LIB_12}
    function GetCurrentRecord(Buffer: TRecordBuffer): Boolean; override;
{$ELSE}
    function GetCurrentRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): Boolean; override;
{$ENDIF}
    function GetBookmark: TBookmark; override;
    function GetFieldData(Field: TField; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}): Boolean; override;
    function GetFieldData(Field: TField; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}; NativeFormat: Boolean): Boolean; override;
    function GetFieldData(FieldNo: Integer; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}): Boolean; overload; override;
    function GetFieldDataAsObject(Field: TField; var Value: TObject): Boolean; virtual;
{$IFDEF CIL}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
{$ENDIF}
    function GotoRec(Rec: TMemoryRecordEh): Boolean;
    function CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream; override;
    function FetchRecords(Count: Integer): Integer;
    function FindRec(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Integer;
    function InstantReadIndexOfBookmark(Bookmark: TUniBookmarkEh): Integer;
    function InstantReadRowCount: Integer;
    function IsSequenced: Boolean; override;
    function LoadFromDataSet(Source: TDataSet; RecordCount: Integer; Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;
    function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions): Boolean; override;
    function Lookup(const KeyFields: string; const KeyValues: Variant; const ResultFields: string): Variant; override;
    function SaveToDataSet(Dest: TDataSet; RecordCount: Integer): Integer;
    function UpdateStatus: TUpdateStatus; override;
    function SetTempRecBufForRecord(Rec: TMemoryRecordEh; TreeNode: TMemRecViewEh; RecNum: Integer): TRecBuf;
    function MoveRecord(FromIndex, ToIndex: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
    function MoveRecords(BookmarkList: TBMListEh; ToRecNo: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
    procedure CancelUpdates;
    procedure CopyStructure(Source: TDataSet);
    procedure CreateDataSet;
    procedure DriverStructChanged;
    procedure DestroyTable;
    procedure EmptyTable;
    procedure FetchParams;
    procedure InstantReadEnter(RowNum: Integer); overload;
    procedure InstantReadEnter(RecView: TMemRecViewEh; RowNum: Integer); overload;
    procedure InstantReadEnter(MemRec: TMemoryRecordEh; RowNum: Integer); overload;
    procedure InstantReadLeave;
    procedure MergeChangeLog;
    procedure RefreshRecord;
    procedure Resync(Mode: TResyncMode); override;
    procedure RevertRecord;
    procedure SetFieldDataAsObject(Field: TField; Value: TObject); virtual;
    procedure SetFilterText(const Value: string); override;
    procedure SortByFields(const SortByStr: string);

//    property KeyFields: String read GetKeyFields write SetKeyFields;
    property AutoIncrement: TAutoIncrementEh read GetAutoIncrement write SetAutoIncrement;
    property CachedUpdates: Boolean read GetCachedUpdates write SetCachedUpdates default False;
    property DataDriver: TDataDriverEh read FDataDriver write SetDataDriver;
    property DetailFields: String read FDetailFields write SetDetailFields;
    property ExternalMemData: TCustomMemTableEh read FExternalMemData write SetExternalMemData;
    property FetchAllOnOpen: Boolean read FFetchAllOnOpen write FFetchAllOnOpen default False;
    property FieldDefs stored FStoreDefs;
    property IndexDefs: TIndexDefs read GetIndexDefs write SetIndexDefs stored FStoreDefs;
    property InstantReadCurRow: Integer read GetInstantReadCurRowNum;
    property MasterDetailSide: TMasterDetailSideEh read FMasterDetailSide write SetMasterDetailSide default mdsOnSelfEh;
    property MasterFields: String read GetMasterFields write SetMasterFields;
    property MasterSource: TDataSource read GetMasterSource write SetMasterSource;
    property Params: TParams read FParams write SetParams;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Rec: TMemoryRecordEh read GetRec;
    property RecordsView: TRecordsViewEh read FRecordsView;
    property SortOrder: String read GetSortOrder write SetSortOrder;
    property StatusFilter: TUpdateStatusSet read GetStatusFilter write SetStatusFilter default [usUnmodified, usModified, usInserted];
    property StoreDefs: Boolean read FStoreDefs write FStoreDefs default False;
    property TreeList: TMemTableTreeListEh read FTreeList write FTreeList;
    property TreeNode: TMemRecViewEh read GetTreeNode;
    property TreeNodeChildCount: Integer read GetTreeNodeChildCount;
    property TreeNodeExpanded: Boolean read GetTreeNodeExpanded write SetTreeNodeExpanded;
    property TreeNodeHasChildren: Boolean read GetTreeNodeHasChildren write SetTreeNodeHasChildren;
    property TreeNodeLevel: Integer read GetTreeNodeLevel;
    property UpdateError: TUpdateErrorEh read GetUpdateError;

//    property OnUpdateRecord: TMTUpdateRecordEventEh read FOnUpdateRecord write FOnUpdateRecord;
//    property OnFetchRecord: TMTFetchRecordEventEh read FOnFetchRecord write FOnFetchRecord;
    property OnTreeNodeExpanding: TMTTreeNodeExpandingEventEh read FOnTreeNodeExpanding write FOnTreeNodeExpanding;
    property OnRecordsViewTreeNodeExpanding: TRecordsViewTreeNodeExpandingEventEh
      read FOnRecordsViewTreeNodeExpanding write FOnRecordsViewTreeNodeExpanding;
    property OnRecordsViewTreeNodeExpanded: TRecordsViewTreeNodeExpandedEventEh
      read FOnRecordsViewTreeNodeExpanded write FOnRecordsViewTreeNodeExpanded;
    property OnRecordsViewCheckMoveNode: TRecordsViewCheckMoveNodeEventEh
      read FOnRecordsViewCheckMoveNode write FOnRecordsViewCheckMoveNode;
    property OnGetFieldValue: TMemTableChangeFieldValueEventEh read FOnGetFieldValue write FOnGetFieldValue;
    property OnSetFieldValue: TMemTableChangeFieldValueEventEh read FOnSetFieldValue write FOnSetFieldValue;
  end;

{ TMemBlobStreamEh }

  TMemBlobStreamEh = class(TMemoryStream)
  private
    FField: TBlobField;
    FDataSet: TCustomMemTableEh;
//    FBuffer: PChar;
    FBuffer: TRecBuf;
    FFieldNo: Integer;
    FModified: Boolean;
    FData: Variant;
    FFieldData: Variant;
  protected
    procedure ReadBlobData;
{$IFDEF CIL}
    function Realloc(var NewCapacity: Longint): TBytes; override;
{$ELSE}
    function Realloc(var NewCapacity: Longint): Pointer; override;
{$ENDIF}
  public
    constructor Create(Field: TBlobField; Mode: TBlobStreamMode);
    destructor Destroy; override;
{$IFDEF CIL}
    function Write(const Buffer: array of Byte; Offset, Count: Longint): Longint; override;
{$ELSE}
    function Write(const Buffer; Count: Longint): Longint; override;
{$ENDIF}
    procedure Truncate;
  end;

{ TMemTableEh }

  TMemTableEh = class(TCustomMemTableEh)
  published
    property Active;
    property AggregatesActive;
    property AutoCalcFields;
    property AutoIncrement;
    property CachedUpdates;
    property DetailFields;
    property ExternalMemData;
    property FieldDefs;
    property Filter;
    property Filtered;
    property FetchAllOnOpen; //FetchAllOnOpen
    property IndexDefs;
//    property KeyFields;
    property MasterDetailSide;
    property MasterFields;
    property MasterSource;
    property Params;
//    property ProviderDataSet;
    property DataDriver;
    property ReadOnly;
    property SortOrder;
    property StoreDefs;
    property TreeList;
//    property ObjectView default False;

    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;
    property BeforeRefresh;
    property AfterRefresh;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
//    property OnFetchRecord;
    property OnFilterRecord;
    property OnNewRecord;
    property OnPostError;
    property OnGetFieldValue;
    property OnSetFieldValue;
//    property OnUpdateRecord;
  end;

{ TMemTableDataFieldValueListEh }

  TMemTableDataFieldValueListEh = class(TInterfacedObject, IMemTableDataFieldValueListEh)
  private
    FValues: TStringList;
    FDataObsoleted: Boolean;
    FFieldName: String;
    FNotificator: TRecordsListNotificatorEh;
//    function GetMemTableData: TMemTableDataEh;
    function GetValues: TStrings;
    procedure SetFieldName(const Value: String);
//    procedure SetMemTableData(const Value: TMemTableDataEh);

    function GetDataObject: TComponent;
    procedure SetDataObject(const Value: TComponent);
  protected
    procedure MTDataEvent(MemRec: TMemoryRecordEh; Index: Integer; Action: TRecordsListNotification);
    procedure RecordListChanged; virtual;
    procedure RefreshValues;
  public
    constructor Create;
    destructor Destroy; override;
    property FieldName: String read FFieldName write SetFieldName;
//    property RecordsList: TRecordsListEh read GetRecordsList write SetRecordsList;
//    property MemTableData: TMemTableDataEh read GetMemTableData write SetMemTableData;
    property DataObject: TComponent read GetDataObject write SetDataObject;
    property Values: TStrings read GetValues;
  end;

{ TRefObjectField }

  TRefObjectField = class(TField)
  protected
    class procedure CheckTypeSize(Value: Integer); override;
    function GetAsVariant: Variant; override;
    function GetValue: TObject;
    procedure SetValue(const Value: TObject);
    procedure SetVarValue(const Value: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Value: TObject read GetValue write SetValue;
  end;

{ TMTOrderByList }

  TMTOrderByList = class(TOrderByList)
  end;

  procedure AssignRecord(Source, Destinate: TDataSet);

//var
//  GlobalUseMemRec: Boolean;

implementation

uses Forms, DbConsts, Math,
{$IFDEF EH_LIB_6}
  SqlTimSt, FmtBcd,
{$ENDIF}
  TypInfo;

resourcestring
  SMemNoRecords = 'No data found';

const
  ftBlobTypes = [ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle,
    ftDBaseOle, ftTypedBinary {$IFDEF EH_LIB_5}, ftOraBlob, ftOraClob {$ENDIF}];

  ftSupported = [ftUnknown, ftString, ftSmallint, ftInteger, ftWord, ftBoolean, ftFloat,
    ftCurrency, ftDate, ftTime, ftDateTime, ftAutoInc, ftBCD, ftBytes,
    ftVarBytes, ftADT, ftFixedChar, ftWideString,
    ftInterface, ftIDispatch,
    ftLargeint {$IFDEF EH_LIB_5}, ftVariant, ftGuid {$ENDIF}] +
    ftBlobTypes;

  fkStoredFields = [fkData, fkInternalCalc];

{$IFDEF EH_LIB_5}
  GuidSize = 38;
{$ENDIF}

type
  CharArray = array of Char;

procedure Error(const Msg: string);
begin
  DatabaseError(Msg);
end;

procedure ErrorFmt(const Msg: string; const Args: array of const);
begin
  DatabaseErrorFmt(Msg, Args);
end;

//{$DEBUGINFO OFF}
function VarEquals(const V1, V2: Variant): Boolean;
var i: Integer;
begin
  Result := not (VarIsArray(V1) xor VarIsArray(V2));
  if not Result then Exit;
  Result := False;
  try
    if VarIsArray(V1) and VarIsArray(V2) and
      (VarArrayDimCount(V1) = VarArrayDimCount(V2)) and
      (VarArrayLowBound(V1, 1) = VarArrayLowBound(V2, 1)) and
      (VarArrayHighBound(V1, 1) = VarArrayHighBound(V2, 1))
      then
      for i := VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do
      begin
        Result := V1[i] = V2[i];
        if not Result then Exit;
      end
    else
      Result := V1 = V2;
  except
  end;
end;
//{$DEBUGINFO ON}

(*
function GetOldFieldValue(DataSet: TDataSet; const FieldName: string): Variant;
var
  I: Integer;
  Fields: TObjectList;
begin
  if Pos(';', FieldName) <> 0 then
  begin
    Fields := TObjectList.Create(False);
    try
      DataSet.GetFieldList(Fields, FieldName);
      Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
      for I := 0 to Fields.Count - 1 do
        Result[I] := TField(Fields[I]).OldValue;
    finally
      Fields.Free;
    end;
  end else
    Result := DataSet.FieldByName(FieldName).OldValue
end;
*)

{ TRecBuf }
{unction TRecBuf.GetTreeNode: TMemRecViewEh;
begin
  Result := nil;
  if Assigned(RecordsView) and (RecordNumber >= 0) and RecordsView.ViewAsTreeList then
    Result := RecordsView.MemoryTreeList.VisibleItem[RecordNumber];
end;

function TRecBuf.GetMemRec: TMemoryRecordEh;
begin
  Result := nil;
  if Assigned(RecordsView) and (RecordNumber >= 0) then
    Result := RecordsView.ViewRecord[RecordNumber];
end;}

destructor TRecBuf.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(Values) - 1 do
    Values[i] := Null;
  Values := nil;
  inherited Destroy;
end;

function TRecBuf.GetValue(Field: TField): Variant;
begin
  if UseMemRec and (MemRec <> nil) and (Field.FieldNo > 0) then
    Result := MemRec.Value[Field.FieldNo-1, dvvValueEh]
  else
    Result := Values[Field.Index];
end;

procedure TRecBuf.SetValue(Field: TField; v: Variant);
var
  i: Integer;
begin
  if UseMemRec and not (Field.FieldKind in [fkCalculated, fkLookup]) then
  begin
    for i := 0 to Field.DataSet.Fields.Count-1 do
      if Field.DataSet.Fields[i].FieldNo > 0 then
        Values[Field.DataSet.Fields[i].Index] :=
          MemRec.Value[Field.DataSet.Fields[i].FieldNo-1, dvvValueEh];
    UseMemRec := False;
  end;
  Values[Field.Index] := v;
end;

function TRecBuf.ReadValueCount: Integer;
begin
  Result := Length(Values);
end;

procedure TRecBuf.SetLength(Len: Integer);
begin
{$IFDEF CIL}
  Borland.Delphi.System.SetLength(Values, Len);
{$ELSE}
  System.SetLength(Values, Len);
{$ENDIF}
  Clear;
end;

procedure TRecBuf.Clear;
var
  I: Integer;
begin
  for I := 0 to Length(Values) - 1 do
    Values[I] := Null;
end;
{
type
  TDataSetOrderByList = class(TOrderByList)
  protected
    FDataSet: TDataSet;
    function FindFieldIndex(FieldName: String): Integer; override;
  public
    constructor Create(ADataSet: TDataSet);
  end;

constructor TDataSetOrderByList.Create(ADataSet: TDataSet);
begin
  inherited Create;
  FDataSet := ADataSet;
end;

function TDataSetOrderByList.FindFieldIndex(FieldName: String): Integer;
var
  Field: TField;
begin
  Result := -1;
  Field := FDataSet.FindField(FieldName);
  if Field <> nil then
    Result := Field.Index;
end;
}

{ TMasterDataLinkEh }

constructor TMasterDataLinkEh.Create(DataSet: TDataSet);
begin
  inherited Create;
  FDataSet := DataSet;
  FFields := TObjectList.Create(False);
end;

destructor TMasterDataLinkEh.Destroy;
begin
  FreeAndNil(FFields);
  inherited Destroy;
end;

procedure TMasterDataLinkEh.ActiveChanged;
begin
  FFields.Clear;
  if Active then
    try
      DataSet.GetFieldList(FFields, FFieldNames);
    except
      FFields.Clear;
      raise;
    end;
  if FDataSet.Active and not (csDestroying in FDataSet.ComponentState) then
    if Active {and (FFields.Count > 0)} then
    begin
      if Assigned(FOnMasterChange) then FOnMasterChange(Self);
    end else
      if Assigned(FOnMasterDisable) then FOnMasterDisable(Self);
end;

procedure TMasterDataLinkEh.CheckBrowseMode;
begin
  if FDataSet.Active then FDataSet.CheckBrowseMode;
end;

function TMasterDataLinkEh.GetDetailDataSet: TDataSet;
begin
  Result := FDataSet;
end;

procedure TMasterDataLinkEh.LayoutChanged;
begin
  ActiveChanged;
end;

procedure TMasterDataLinkEh.RecordChanged(Field: TField);
begin
  if (DataSource.State <> dsSetKey) and FDataSet.Active and
    {(FFields.Count > 0) and }((Field = nil) or
    (FFields.IndexOf(Field) >= 0)) and
     Assigned(FOnMasterChange)
  then
    FOnMasterChange(Self);
end;

procedure TMasterDataLinkEh.SetFieldNames(const Value: string);
begin
  if FFieldNames <> Value then
  begin
    FFieldNames := Value;
    ActiveChanged;
  end;
end;

{ TCustomMemTableEh }

constructor TCustomMemTableEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRecordPos := -1;
  FInstantReadCurRowNum := -1;
  FAutoInc := 1;
  FRecordCache := TObjectList.Create(True);
  FEventReceivers := TObjectList.Create(False);

  FInternMemTableData := TMemTableDataEh.Create(Self);
  FInternMemTableData.Name := 'MemTableData';

  FRecordsView := TRecordsViewEh.Create(Self);
  FRecordsView.OnFilterRecord := IsRecordInFilter;
  FRecordsView.OnParseOrderByStr := ParseOrderByStr;
  FRecordsView.OnCompareRecords := CompareRecords;
  FRecordsView.OnCompareTreeNode := CompareTreeNodes;
  FRecordsView.OnGetPrefilteredList := GetPrefilteredList;
  FRecordsView.OnViewDataEvent := ViewDataEvent;
  FRecordsView.OnViewRecordMovedEvent := ViewRecordMovedEvent; 
//  FRecordsView.MemTableData := FInternMemTableData;
  FRecordsView.DataObject := FInternMemTableData;
  FRecordsView.OnFetchRecords := DoFetchRecords;
  FRecordsView.MemoryTreeList.OnExpandedChanging := TreeViewNodeExpanding;
  FRecordsView.MemoryTreeList.OnExpandedChanged := TreeViewNodeExpanded;
  FRecordsView.OnApplyUpdates := MTApplyUpdates;

  FMasterDataLink := TMasterDataLinkEh.Create(Self);
  FMasterDataLink.OnMasterChange := MasterChange;
  FDetailFieldList := TObjectList.Create(False);
  FParams := TParams.Create(Self);
  FFilterExpr := TDataSetExprParserEh.Create(Self, dsptFilterEh);
  FTreeList := TMemTableTreeListEh.Create(Self);
  FDetailRecList := TObjectList.Create(False);
  FInstantBuffers := TObjectList.Create(False);
  FMasterValList := TSortedVarlistEh.Create;
  FMasterValList.Clear;

end;

destructor TCustomMemTableEh.Destroy;
begin
  Close;
  FreeAndNil(FMasterValList);
  TreeList.Active := False;
  FreeAndNil(FFilterExpr);
  FreeAndNil(FParams);
  FDetailFieldList.Clear;
  FreeAndNil(FDetailFieldList);
  if ExternalMemData = nil then
    ClearRecords;
  FreeAndNil(FRecordsView);
  FreeAndNil(FMasterDataLink);
  FreeAndNil(FTreeList);
  FreeAndNil(FIndexDefs);
  FreeAndNil(FRecordCache);
  FreeAndNil(FDetailRecList);
  FreeAndNil(FInternMemTableData);
  FreeAndNil(FInstantBuffers);
  DataDriver := nil;
  inherited Destroy;
  FreeAndNil(FEventReceivers);
end;

{ Field Management }

{$IFNDEF EH_LIB_5}

function TCustomMemTableEh.BCDToCurr(BCD: Pointer; var Curr: Currency): Boolean;
begin
  Move(BCD^, Curr, SizeOf(Currency));
  Result := True;
end;

function TCustomMemTableEh.CurrToBCD(const Curr: Currency; BCD: Pointer; Precision,
  Decimals: Integer): Boolean;
begin
  Move(Curr, BCD^, SizeOf(Currency));
  Result := True;
end;

{$ENDIF EH_LIB_5}

procedure TCustomMemTableEh.InitFieldDefsFromFields;
var
  I: Integer;
begin
  if FieldDefs.Count = 0 then
  begin
    FAutoIncrementFieldName := '';
    for I := 0 to FieldCount - 1 do
    begin
      with Fields[I] do
      begin
        if (FieldKind in fkStoredFields) and not (DataType in ftSupported) then
          ErrorFmt(SUnknownFieldType, [DisplayName]);
        if AutoGenerateValue = arAutoInc then
          FAutoIncrementFieldName := FieldName;
      end;
    end;
//    FreeIndexList;
  end;

  inherited InitFieldDefsFromFields;
end;

procedure TCustomMemTableEh.Loaded;
begin
  inherited Loaded;
  if TreeList.FLoadingActive then
    TreeList.Active := TreeList.FLoadingActive;
end;

{ Buffer Manipulation }

procedure TCustomMemTableEh.InitBufferPointers(GetProps: Boolean);
begin
//  if GetProps then
//    FDataRecordSize := (Fields.Count * SizeOf(OleVariant));

  { TODO : FRecBufSize need? }
  FRecBufSize := -1; //SizeOf(TRecInfo) + (Fields.Count * SizeOf(Pointer));
end;

procedure TCustomMemTableEh.ClearRecords;
begin
  RecordsView.MemTableData.RecordsList.Clear;
  RecordsView.MemTableData.AutoIncrement.Reset;
  FRecordPos := -1;
  FInstantReadCurRowNum := -1;
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.IndexToBuffer(I: Integer): TRecordBuffer;
begin
  Result := TRecordBuffer(I + 1);
end;
{$ELSE}
function TCustomMemTableEh.IndexToBuffer(I: Integer): {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
begin
{$IFDEF CIL}
  Result := TRecordBuffer(I + 1);
{$ELSE}
  Result := PChar(I + 1);
{$ENDIF}
end;
{$ENDIF}

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.BufferToIndex(Buf: TRecordBuffer): Integer;
{$ELSE}
function TCustomMemTableEh.BufferToIndex(Buf: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): Integer;
{$ENDIF}
begin
  Result := Integer(Buf) - 1; // Buf is off by one so that nil (0) represents an invalid buffer
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.BufferToRecBuf(Buf: TRecordBuffer): TRecBuf;
{$ELSE}
function TCustomMemTableEh.BufferToRecBuf(Buf: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): TRecBuf;
{$ENDIF}
begin
  Result := TRecBuf(FRecordCache[BufferToIndex(Buf)]);
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.AllocRecordBuffer: TRecordBuffer;
{$ELSE}
function TCustomMemTableEh.AllocRecordBuffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}

  procedure ClearBuffer(RecBuf: TRecBuf);
//  var
//    I: Integer;
  begin
    RecBuf.SetLength(FieldCount);
//    SetLength(RecBuf.Values, FieldCount);
//    for I := 0 to Fields.Count - 1 do
//      RecBuf.Values[I] := Null;
  end;

{$IFDEF EH_LIB_12}
  function InitializeBuffer(I: Integer): TRecordBuffer;
{$ELSE}
  function InitializeBuffer(I: Integer): {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}
  begin
    TRecBuf(FRecordCache[I]).InUse := True;
    TRecBuf(FRecordCache[I]).RecordNumber := -2;
    ClearBuffer(TRecBuf(FRecordCache[I]));
    Result := IndexToBuffer(I);
  end;

var
  RecBuf: TRecBuf;
  I, NewIndex: Integer;
begin
  for I := 0 to FRecordCache.Count - 1 do
    if not TRecBuf(FRecordCache[I]).InUse then
    begin
      Result := InitializeBuffer(I);
      Exit;
    end;

  RecBuf := TRecBuf.Create;
  ClearBuffer(RecBuf);
  RecBuf.RecordStatus := -2;
  RecBuf.RecView := nil;
  RecBuf.MemRec := nil;
//  RecBuf.RecordsView := nil;
  NewIndex := FRecordCache.Add(RecBuf);
  Result := InitializeBuffer(NewIndex);
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.FreeRecordBuffer(var Buffer: TRecordBuffer);
{$ELSE}
procedure TCustomMemTableEh.FreeRecordBuffer(var Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
var
//  RecBuf: TRecBuf;
  I{, J}: Integer;
begin

  I := BufferToIndex(Buffer);
  if (I = FRecordCache.Count - 1) and (BufferCount < FRecordCache.Count - 2) then
  begin
//    FRecordCache[FRecordCache.Count-1].Free;
    FRecordCache.Count := I;
  end else
  begin
    TRecBuf(FRecordCache[I]).InUse := False;
    TRecBuf(FRecordCache[I]).RecordNumber := -1;
//    for J := 0 to Length(TRecBuf(FRecordCache[I]).Values) - 1 do
//      TRecBuf(FRecordCache[I]).Values[J] := Null;
    TRecBuf(FRecordCache[I]).Clear;
    TRecBuf(FRecordCache[I]).RecView := nil;
    TRecBuf(FRecordCache[I]).MemRec := nil;
    TRecBuf(FRecordCache[I]).UseMemRec := False;
//    TRecBuf(FRecordCache[I]).RecordsView := nil;
  end;

{  RecBuf := PRecBuf(Buffer);
  SetLength(RecBuf^.Values, 0);
  Dispose(RecBuf);}
  Buffer := nil;
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.ClearCalcFields(Buffer: TRecordBuffer);
{$ELSE}
procedure TCustomMemTableEh.ClearCalcFields(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
var
  I: Integer;
begin
  if CalcFieldsSize > 0 then
    for I := 0 to Fields.Count - 1 do
      with Fields[I] do
        if FieldKind in [fkCalculated, fkLookup] then
//          BufferToRecBuf(Buffer).Values[Index] := Null;
          BufferToRecBuf(Buffer).Value[Fields[I]] := Null;
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.InternalInitRecord(Buffer: TRecordBuffer);
{$ELSE}
procedure TCustomMemTableEh.InternalInitRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
//var
//  I: Integer;
begin
//  for I := 0 to Fields.Count - 1 do
//    BufferToRecBuf(Buffer).Values[I] := Null;
  BufferToRecBuf(Buffer).Clear;
  BufferToRecBuf(Buffer).RecView := nil;
  BufferToRecBuf(Buffer).MemRec := nil;
  BufferToRecBuf(Buffer).UseMemRec := False;
//  BufferToRecBuf(Buffer).RecordsView := Nil;
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.InitRecord(Buffer: TRecordBuffer);
{$ELSE}
procedure TCustomMemTableEh.InitRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
begin
  inherited InitRecord(Buffer);

  with BufferToRecBuf(Buffer) do
  begin
    Bookmark := Low(Integer);
    BookmarkFlag := bfInserted;
//    RecordStatus := 0;
    RecordNumber := -1;
  end;
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.GetCurrentRecord(Buffer: TRecordBuffer): Boolean;
{$ELSE}
function TCustomMemTableEh.GetCurrentRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): Boolean;
{$ENDIF}
begin
  Result := False;
{  if not IsEmpty and (GetBookmarkFlag(ActiveBuffer) = bfCurrent) then
  begin
    UpdateCursorPos;
    if (FRecordPos >= 0) and (FRecordPos < RecordCount) then
    begin
      Move(FRecords[FRecordPos]^, Buffer^, FDataRecordSize);
      Result := True;
    end;
  end;
}
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.RecordToBuffer(MemRec: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh;
  Buffer: TRecordBuffer; RecIndex: Integer);
{$ELSE}
procedure TCustomMemTableEh.RecordToBuffer(MemRec: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh;
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}; RecIndex: Integer);
{$ENDIF}
//var
//  i: Integer;
begin

  with BufferToRecBuf(Buffer) do
  begin
    Bookmark := RecIndex + 1; //FRecordsView.ViewRecord[FRecordPos].ID;
    RecordNumber := RecIndex;
    BookmarkFlag := bfCurrent;
//    RecordStatus := 0; //Recordset.Status;
  end;
  BufferToRecBuf(Buffer).MemRec := MemRec;

  // Don't need assign data values
  // Will do in on first SetFieldData
//  if GlobalUseMemRec then
    BufferToRecBuf(Buffer).UseMemRec := True;
//  else
//    for i := 0 to FieldCount-1 do
//      if Fields[i].FieldNo > 0 then
//        BufferToRecBuf(Buffer).Values[Fields[i].Index] := MemRec.Value[Fields[i].FieldNo-1, dvvValueEh];

  GetCalcFields(Buffer);
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.SetMemoryRecordData(Buffer: TRecordBuffer;
  Rec: TMemoryRecordEh);
{$ELSE}
procedure TCustomMemTableEh.SetMemoryRecordData(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
  Rec: TMemoryRecordEh);
{$ENDIF}
var
  i: Integer;
begin
  if State = dsFilter then
    Error(SNotEditing);
  for i := 0 to FieldCount-1 do
    if Fields[i].FieldNo > 0 then
      Rec.Value[Fields[i].FieldNo-1, dvvValueEh] :=
//        BufferToRecBuf(Buffer).Values[Fields[i].Index];
        BufferToRecBuf(Buffer).Value[Fields[i]];
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.CopyBuffer(FromBuf, ToBuf: TRecordBuffer);
{$ELSE}
procedure TCustomMemTableEh.CopyBuffer(FromBuf, ToBuf: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
var
  i: Integer;
  FromRecBuf, ToRecBuf: TRecBuf;
begin
  FromRecBuf := BufferToRecBuf(FromBuf);
  ToRecBuf := BufferToRecBuf(ToBuf);
//  BufferToRecBuf(Buffer).RecInfo := BufferToRecBuf(Buffer).RecInfo;
  ToRecBuf.Bookmark := FromRecBuf.Bookmark;
  ToRecBuf.BookmarkFlag := FromRecBuf.BookmarkFlag;
  ToRecBuf.RecordStatus := FromRecBuf.RecordStatus;
  ToRecBuf.RecordNumber := FromRecBuf.RecordNumber;
  ToRecBuf.NewTreeNodeExpanded := FromRecBuf.NewTreeNodeExpanded;
  ToRecBuf.NewTreeNodeHasChildren := FromRecBuf.NewTreeNodeHasChildren;
  ToRecBuf.RecView := FromRecBuf.RecView;
  ToRecBuf.MemRec := FromRecBuf.MemRec;
//  ToRecBuf.RecordsView := FromRecBuf.RecordsView;

//  SetLength(ToRecBuf.Values, Length(FromRecBuf.Values));
  ToRecBuf.SetLength(Length(FromRecBuf.Values));
  for i := 0 to Length(ToRecBuf.Values)-1 do
    ToRecBuf.Values[i] := FromRecBuf.Values[i];

  ToRecBuf.UseMemRec := FromRecBuf.UseMemRec;
end;

procedure TCustomMemTableEh.VarValueToFieldValue(VarValue: Variant;
  FieldBuffer: {$IFDEF CIL}TObject{$ELSE}Pointer{$ENDIF}; Field: TField);
//var
//  FieldValBuf: PFieldValBuf;
begin
//  FieldValBuf := PFieldValBuf(FieldBuffer);
//  FieldValBuf.VarValue := VarValue;
end;

function TCustomMemTableEh.FieldValueToVarValue(
  FieldBuffer: {$IFDEF CIL}TObject{$ELSE}Pointer{$ENDIF}; Field: TField): Variant;
//var
//  FieldValBuf: PFieldValBuf;
begin
//  FieldValBuf := PFieldValBuf(FieldBuffer);
//  Result := FieldValBuf^.VarValue;
  Result := Unassigned;
end;

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.GetRecord(Buffer: TRecordBuffer;
  GetMode: TGetMode; DoCheck: Boolean): TGetResult;
{$ELSE}
function TCustomMemTableEh.GetRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
  GetMode: TGetMode; DoCheck: Boolean): TGetResult;
{$ENDIF}
begin
  Result := grOk;
//  if (BufferToRecBuf(Buffer).BookmarkFlag = bfCurrent) and (State in dsEditModes) then
//    Exit;
  case GetMode of
    gmPrior:
      if FRecordPos <= 0 then
      begin
        Result := grBOF;
        FRecordPos := -1;
        FInstantReadCurRowNum := 0;
      end else
        Dec(FRecordPos);
    gmCurrent:
      if (FRecordPos < 0) or (FRecordPos >= RecordsView.ViewItemsCount) then
        Result := grError;
    gmNext:
      begin
        if FRecordPos >= FRecordsView.ViewItemsCount - 1 then
        begin
          BeginRecordsViewUpdate;
          try
            if FetchAllOnOpen
              then DoFetchRecords(-1)
              else DoFetchRecords(1);
          finally
            EndRecordsViewUpdate(False);
          end;
        end;
        if FRecordPos >= FRecordsView.ViewItemsCount - 1 then
        begin
          FRecordPos := FRecordsView.ViewItemsCount;
          Result := grEOF
        end else
          Inc(FRecordPos);
      end;
  end;
  if FRecordPos >= 0 then
    FInstantReadCurRowNum := FRecordPos;
  if Result = grOk then
  begin
    RecordToBuffer(FRecordsView.ViewRecord[FRecordPos], dvvValueEh, Buffer, FRecordPos);
//    BufferToRecBuf(Buffer).Bookmark := FRecordPos + 1;//FRecordsView.ViewRecord[FRecordPos].ID;
//    BufferToRecBuf(Buffer).RecordNumber := FRecordPos;
    BufferToRecBuf(Buffer).MemRec := FRecordsView.ViewRecord[FRecordPos];
//    BufferToRecBuf(Buffer).RecordsView := FRecordsView;
    if FRecordsView.ViewAsTreeList
      then BufferToRecBuf(Buffer).RecView := FRecordsView.MemoryTreeList.VisibleItem[FRecordPos]
      else BufferToRecBuf(Buffer).RecView := nil;
  end else if (Result = grError) and DoCheck then
    Error(SMemNoRecords);
end;

procedure TCustomMemTableEh.Resync(Mode: TResyncMode);
begin
  if FRecordsViewUpdating = 0
    then inherited Resync(Mode)
    else FRecordsViewUpdated := True;
end;

function TCustomMemTableEh.GetRecordSize: Word;
begin
  Result := FRecBufSize;
end;

function TCustomMemTableEh.GetActiveRecBuf(var RecBuf: TRecBuf; IsForWrite: Boolean): Boolean;

{$IFDEF EH_LIB_12}
  function GetOldValuesBuffer: TRecordBuffer;
{$ELSE}
  function GetOldValuesBuffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}
  begin
    UpdateCursorPos;
    if (FRecordPos >= 0) and (FRecordsView.ViewRecord[FRecordPos].OldData <> nil) then
    begin
      Result := TempBuffer;
      RecordToBuffer(FRecordsView.ViewRecord[FRecordPos], dvvOldValueEh, Result, FRecordPos);
    end else
      Result := nil;
  end;

{$IFDEF EH_LIB_12}
  function GetCurValuesBuffer: TRecordBuffer;
{$ELSE}
  function GetCurValuesBuffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}
  begin
    UpdateCursorPos;
    if not (GetBookmarkFlag(ActiveBuffer) in [bfBOF, bfEOF, bfInserted]) then
    begin
      Result := TempBuffer;
      RecordToBuffer(FRecordsView.ViewRecord[FRecordPos], dvvCurValueEh, Result, FRecordPos)
    end else
      Result := nil;
  end;

var
{$IFDEF EH_LIB_12}
  Buffer: TRecordBuffer;
{$ELSE}
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF};
{$ENDIF}
begin
  if FInstantReadMode and not IsForWrite then
    RecBuf := BufferToRecBuf(InstantBuffer)
  else
    case State of
      dsBrowse:
        if IsEmpty
          then RecBuf := nil
          else RecBuf := BufferToRecBuf(ActiveBuffer);
      dsOldValue:
        begin
          Buffer := GetOldValuesBuffer;
          if Buffer <> nil then
          begin
            RecBuf := BufferToRecBuf(Buffer);
            if RecBuf = nil then
              RecBuf := BufferToRecBuf(ActiveBuffer)
          end else
            RecBuf := nil;
        end;
      dsCurValue:
        begin
          Buffer := GetCurValuesBuffer;
          if Buffer <> nil then
          begin
            RecBuf := BufferToRecBuf(Buffer);
            if RecBuf = nil then
              RecBuf := BufferToRecBuf(ActiveBuffer)
          end else
            RecBuf := nil;
        end;
      dsEdit, dsInsert, dsNewValue: RecBuf := BufferToRecBuf(ActiveBuffer);
      dsCalcFields: RecBuf := BufferToRecBuf(CalcBuffer);
      dsFilter: RecBuf := BufferToRecBuf(TempBuffer);
      else RecBuf := nil;
    end;
  Result := RecBuf <> nil;
end;

{ Field Data }

function TCustomMemTableEh.GetFieldData(Field: TField;
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}; NativeFormat: Boolean): Boolean;
var
//  PVarValue: PVariant;

  RecBuf: TRecBuf;
//  FieldBufNo: Integer;


{$IFDEF CIL}
  procedure VarToBuffer(var Value: Variant);
  var
    B: TBytes;
    Len: Integer;
    TimeStamp: TTimeStamp;
    D: Double;
  begin
    case Field.DataType of
      ftWideString:
      begin
        B := WideBytesOf(Value.ToString);
        Len := Length(B);
        if Len > Field.Size * 2 then
        begin
          SetLength(B, Field.Size * 2);
          Len := Field.Size * 2;
        end;
        SetLength(B, Len + 2);
        B[Len - 1] := 0;
        B[Len] := 0; // add null terminator
        Marshal.Copy(B, 0, Buffer, Len + 2);
      end;
      ftString, ftGuid:
      begin
        B := BytesOf(Value.ToString);
        Len := Length(B);
        if Len > Field.Size then
        begin
          SetLength(B, Field.Size);
          Len := Field.Size;
        end;
        SetLength(B, Len + 1);
        B[Len] := 0; // add null terminator
        Marshal.Copy(B, 0, Buffer, Len + 1);
      end;
      ftFixedChar:
      begin
        B := BytesOf(System.String.Create(CharArray(Value)));
        Len := Length(B);
        if Len > Field.Size then
        begin
          SetLength(B, Field.Size);
          Len := Field.Size;
        end;
        SetLength(B, Len + 1);
        B[Len] := 0; // add null terminator
        Marshal.Copy(B, 0, Buffer, Len + 1);
      end;
      ftSmallint, ftWord:
        Marshal.WriteInt16(Buffer, SmallInt(Value));
      ftAutoInc, ftInteger:
        Marshal.WriteInt32(Buffer, Integer(Value));
      ftLargeInt:
        Marshal.WriteInt64(Buffer, Int64(Value));
      ftBoolean:
        if Boolean(Value) then
          Marshal.WriteInt16(Buffer, 1)
        else
          Marshal.WriteInt16(Buffer, 0);
      ftFloat, ftCurrency:
        Marshal.WriteInt64(Buffer, BitConverter.DoubleToInt64Bits(Value));
      ftBCD:
        if NativeFormat then
          Marshal.Copy(TBcd.ToBytes(Value), 0, Buffer, SizeOfTBCD)
        else
          Marshal.WriteInt64(Buffer, System.Decimal.ToOACurrency(System.Decimal(Value)));
      ftDate, ftTime, ftDateTime:
        if NativeFormat then
        begin
          TimeStamp := DateTimeToTimeStamp(TDateTime(Value));
          case Field.DataType of
            ftDate:
              Marshal.WriteInt32(Buffer, TimeStamp.Date);
           ftTime:
             Marshal.WriteInt32(Buffer, TimeStamp.Time);
           ftDateTime:
             begin
               D := TimeStampToMSecs(TimeStamp);
               Marshal.WriteInt64(Buffer, BitConverter.DoubleToInt64Bits(D));
             end;
          end;
        end
        else
          Marshal.WriteInt64(Buffer, BitConverter.DoubleToInt64Bits(Double(Value)));
      ftBytes:
        Marshal.Copy(TBytes(TObject(Value)), 0, Buffer,
          Length(TBytes(TObject(Value))));
      ftVarBytes:
        begin
          Len := Length(TBytes(TObject(Value)));
          if NativeFormat then
          begin
            Marshal.WriteInt16(Buffer, Len);
            Marshal.Copy(TBytes(TObject(Value)), 0, IntPtr(Integer(Buffer.ToInt32 + 2)), Len);
          end else
            Marshal.Copy(TBytes(TObject(Value)), 0, Buffer, Len);
        end;
      ftTimeStamp:
        Marshal.StructureToPtr(TObject(Value), Buffer, False);
      ftFMTBCD:
        Marshal.Copy(TBcd.ToBytes(Value), 0, Buffer, SizeOfTBCD);
      else
        DatabaseErrorFmt('SUsupportedFieldType', [FieldTypeNames[Field.DataType], Field.DisplayName]);
    end;
  end;
{$ELSE}
  procedure VarToBuffer(var Value: Variant);
  begin
    case Field.DataType of
      ftGuid, ftFixedChar, ftString:
        begin
          PAnsiChar(Buffer)[Field.Size] := #0;
          StrLCopy(PAnsiChar(Buffer), PAnsiChar(VarToAnsiStr(Value)), Field.Size);
        end;
      ftWideString:
{$IFDEF EH_LIB_10}
        WStrCopy(PWideChar(Buffer), PWideChar(VarToWideStr(Value)));
{$ELSE}
        WideString(Buffer^) := Value;
{$ENDIF}
      ftSmallint:
          SmallInt(Buffer^) := Value;
      ftWord:
          Word(Buffer^) := Value;
      ftAutoInc, ftInteger:
        Integer(Buffer^) := Value;
      ftFloat, ftCurrency:
          Double(Buffer^) := Value;
      ftBCD:
        if NativeFormat
          then DataConvert(Field, @Value, Buffer, True)
          else Currency(Buffer^) := Value;
      ftBoolean:
        WordBool(Buffer^) := Value;
      ftDate, ftTime, ftDateTime:
        if NativeFormat
          then DataConvert(Field, @TVarData(Value).VDate, Buffer, True)
          else TDateTime(Buffer^) := Value;
      ftBytes, ftVarBytes:
        if NativeFormat
          then DataConvert(Field, @Value, Buffer, True)
          else Variant(Buffer^) := Value;
      ftInterface: IUnknown(Buffer^) := Value;
      ftIDispatch: IDispatch(Buffer^) := Value;
{$IFDEF EH_LIB_6}
      ftLargeInt: LargeInt(Buffer^) := Value;
      ftTimeStamp:
        if NativeFormat
          then DataConvert(Field, @Value, Buffer, True)
          else TSQLTimeStamp(Buffer^) := VarToSQLTimeStamp(Value);
      ftFMTBcd:
        if NativeFormat
          then DataConvert(Field, @Value, Buffer, True)
          else TBcd(Buffer^) := VarToBcd(Value);
{$ENDIF}
      ftBlob..ftTypedBinary, ftVariant, ftOraBlob, ftOraClob: Variant(Buffer^) := Value;
{$IFDEF EH_LIB_10}
      ftWideMemo: Variant(Buffer^) := Value;
{$ENDIF}
    else
      DatabaseErrorFmt('SUsupportedFieldType', [FieldTypeNames[Field.DataType],
        Field.DisplayName]);
    end;
  end;
{$ENDIF}

var
  OutValue: Variant;
begin
  Result := GetActiveRecBuf(RecBuf);
  if not Result then Exit;
//  if Field.FieldNo > 0
//    then FieldBufNo := Field.Index //???Field.FieldNo - 1
//    else FieldBufNo := {Field.Offset}FCalcFieldIndexes[Field.Index] + DataFieldsCount;

  if Field.FieldKind = fkAggregate then
    OutValue := GetAggregateValue(Field)
  else
  begin
//    FieldBufNo := Field.Index;
//    OutValue := RecBuf.Values[FieldBufNo];
    OutValue := RecBuf.Value[Field];
    if Assigned(FOnGetFieldValue) then
      FOnGetFieldValue(Self, Field, OutValue);
  end;

  if VarIsNull(OutValue) then
    Result := False
  else if Buffer <> nil then
    VarToBuffer(OutValue);
end;

function TCustomMemTableEh.GetFieldData(Field: TField; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}): Boolean;
begin
  Result := GetFieldData(Field, Buffer, True);
end;

function TCustomMemTableEh.GetFieldData(FieldNo: Integer; Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}): Boolean;
begin
  Result := GetFieldData(FieldByNumber(FieldNo), Buffer);
end;

function TCustomMemTableEh.GetFieldDataAsObject(Field: TField; var Value: TObject): Boolean;
var
  RecBuf: TRecBuf;
//  FieldBufNo: Integer;
  OutValue: Variant;
begin
  Value := nil;
  Result := GetActiveRecBuf(RecBuf);
  if not Result then Exit;
//  FieldBufNo := Field.Index;

//  OutValue := RecBuf.Values[FieldBufNo];
  OutValue := RecBuf.Value[Field];
  if Assigned(FOnGetFieldValue) then
    FOnGetFieldValue(Self, Field, OutValue);

  if VarIsNull(OutValue)
    then Result := False
    else Value := VariantToRefObject(OutValue);
end;

procedure TCustomMemTableEh.SetFieldData(Field: TField;
  Buffer: {$IFDEF CIL}TValueBuffer{$ELSE}Pointer{$ENDIF}; NativeFormat: Boolean);
var
  RecBuf: TRecBuf;
//  FieldBufNo: Integer;
  v: Variant;

{$IFDEF CIL}
  procedure BufferToVar(var Data: Variant);
  var
    B: TBytes;
    Len: Smallint;
  begin
    case Field.DataType of
      ftWideString:
        Data := Variant(Marshal.PtrToStringUni(Buffer));
      ftString, ftGuid, ftFixedChar:
        Data := Variant(Marshal.PtrToStringAnsi(Buffer));
      ftSmallint, ftWord:
        Data := Variant(Marshal.ReadInt16(Buffer));
      ftAutoInc, ftInteger:
        Data := Variant(Marshal.ReadInt32(Buffer));
      ftLargeInt:
        Data := Variant(Marshal.ReadInt64(Buffer));
      ftBoolean:
        if Marshal.ReadInt16(Buffer) <> 0 then
          Data := Variant(True)
        else
          Data := Variant(False);
      ftFloat, ftCurrency:
        Data := Variant(BitConverter.Int64BitsToDouble(Marshal.ReadInt64(Buffer)));
      ftBCD:
        if NativeFormat then
        begin
          SetLength(B, SizeOfTBCD);
          Marshal.Copy(Buffer, B, 0, SizeOfTBCD);
          Data := Variant(TBcd.FromBytes(B));
        end
        else
          Data := System.Decimal.FromOACurrency(Marshal.ReadInt64(Buffer));
      ftDate, ftTime, ftDateTime:
        if NativeFormat then
        begin
          case Field.DataType of
            ftDate:
              Data := System.DateTime.Create(0).AddDays(Marshal.ReadInt32(Buffer));
            ftTime:
              Data := System.DateTime.Create(0).AddMilliseconds(
                Marshal.ReadInt32(Buffer));
            ftDateTime:
              Data := System.DateTime.Create(0).AddMilliseconds(
                BitConverter.Int64BitsToDouble(Marshal.ReadInt64(Buffer)));
          end;
        end
        else // data is TDateTime
          Data := System.DateTime.FromOADate(BitConverter.Int64BitsToDouble(
            Marshal.ReadInt64(Buffer)));
      ftBytes:
      begin
        SetLength(B, Field.Size);
        Marshal.Copy(Buffer, B, 0, Field.Size);
        Data := Variant(B);
      end;
      ftTimeStamp:
        Data := Variant(Marshal.PtrToStructure(Buffer, TypeOf(TSQLTimeStamp)));
      ftFMTBCD:
      begin
        SetLength(B, SizeOfTBCD);
        Marshal.Copy(Buffer, B, 0, SizeOfTBCD);
        Data := Variant(TBcd.FromBytes(B));
      end;
      ftVarBytes:
        if NativeFormat then
        begin
          Len := Marshal.ReadInt16(Buffer);
          SetLength(B, Len);
          Marshal.Copy(IntPtr(Integer(Buffer.ToInt32 + 2)), B, 0, Len);
          Data := Variant(B);
        end else
        begin
          {note, we cant support VarBytes if not length prefixed}
          DatabaseErrorFmt('SUsupportedFieldType', [FieldTypeNames[ftVarBytes],
              Field.DisplayName]);
          Data := nil; // never gets called but this makes the compiler happy
        end
      else
      begin
        {note, we cant support blob types in this way}
        DatabaseErrorFmt('SUsupportedFieldType', [FieldTypeNames[Field.DataType],
            Field.DisplayName]);
        Data := nil; // never gets called but this makes the compiler happy
      end;
    end;
  end;
{$ELSE}
  procedure BufferToVar(var Data: Variant);
  begin
    case Field.DataType of
      ftString, ftFixedChar, ftGuid:
        Data := AnsiString(PAnsiChar(Buffer));
//        SetString(Data, PChar(Buffer), StrLen(PChar(Buffer)));
      ftWideString:
{$IFDEF EH_LIB_10}
        Data := WideString(PWideChar(Buffer));
{$ELSE}
        Data := WideString(Buffer^);
{$ENDIF}
//        WStrCopy(PWideChar(Data), PWideChar(VarToWideStr(Buffer)));
      ftAutoInc, ftInteger:
        Data := LongInt(Buffer^);
      ftSmallInt:
        Data := SmallInt(Buffer^);
      ftWord:
        Data := Word(Buffer^);
      ftBoolean:
        Data := WordBool(Buffer^);
      ftFloat, ftCurrency:
        Data := Double(Buffer^);
      ftBlob, ftMemo, ftGraphic, ftVariant, ftOraBlob, ftOraClob:
        Data := Variant(Buffer^);
      ftInterface:
        Data := IUnknown(Buffer^);
      ftIDispatch:
        Data := IDispatch(Buffer^);
      ftDate, ftTime, ftDateTime:
        if NativeFormat
          then DataConvert(Field, Buffer, @TVarData(Data).VDate, False)
          else Data := TDateTime(Buffer^);
      ftBCD:
        if NativeFormat
          then DataConvert(Field, Buffer, @TVarData(Data).VCurrency, False)
          else Data := Currency(Buffer^);
      ftBytes, ftVarBytes:
        if NativeFormat
          then DataConvert(Field, Buffer, @Data, False)
          else Data := Variant(Buffer^);
{$IFDEF EH_LIB_10}
      ftWideMemo: Data := Variant(Buffer^);
{$ENDIF}
{$IFDEF EH_LIB_6}
      ftLargeInt:
          Data := Int64(Buffer^);
      ftTimeStamp:
        if NativeFormat
          then DataConvert(Field, Buffer, @Data, True)
          else Data :=  VarSQLTimeStampCreate(TSQLTimeStamp(Buffer^));
      ftFMTBcd:
        if NativeFormat
          then DataConvert(Field, Buffer, @Data, True)
          else Data := VarFMTBcdCreate(TBcd(Buffer^));
{$ENDIF}
      else
        DatabaseErrorFmt('SUsupportedFieldType', [FieldTypeNames[Field.DataType],
          Field.DisplayName]);
    end;
  end;
{$ENDIF}

begin
  if not (State in dsWriteModes) then DatabaseError(SNotEditing, Self);
  if not GetActiveRecBuf(RecBuf, True) then Exit;

//  if Field.FieldNo > 0
//    then FieldBufNo := Field.FieldNo - 1
//    else FieldBufNo := FCalcFieldIndexes[Field.Index] + DataFieldsCount;
//  FieldBufNo := Field.Index;

  Field.Validate(Buffer);

  if Buffer = nil
    then v := Null
    else BufferToVar(v);

  if Assigned(FOnSetFieldValue) then
    FOnSetFieldValue(Self, Field, v);

  RecBuf.Value[Field] := v;

  if not (State in [dsCalcFields, dsInternalCalc, dsFilter, dsNewValue]) then
{$IFDEF CIL}
    DataEvent(deFieldChange, Field);
{$ELSE}
    DataEvent(deFieldChange, Longint(Field));
{$ENDIF}
end;

procedure TCustomMemTableEh.SetFieldData(Field: TField;
  Buffer: {$IFDEF CIL}TValueBuffer{$ELSE}Pointer{$ENDIF});
begin
  SetFieldData(Field, Buffer, True);
end;

procedure TCustomMemTableEh.SetFieldDataAsObject(Field: TField; Value: TObject);
var
  RecBuf: TRecBuf;
//  FieldBufNo: Integer;
  v: Variant;
begin
  if not (State in dsWriteModes) then DatabaseError(SNotEditing, Self);
  if not GetActiveRecBuf(RecBuf, True) then Exit;

//  FieldBufNo := Field.Index;

  if Value = nil
    then v := Null
//    else BufferToVar(RecBuf.Values[FieldBufNo]);
    else v := RefObjectToVariant(Value);

  if Assigned(FOnSetFieldValue) then
    FOnSetFieldValue(Self, Field, v);

  RecBuf.Value[Field] := v;

  if not (State in [dsCalcFields, dsInternalCalc, dsFilter, dsNewValue]) then
{$IFDEF CIL}
    DataEvent(deFieldChange, Field);
{$ELSE}
    DataEvent(deFieldChange, Longint(Field));
{$ENDIF}
end;

{ Filter }

procedure TCustomMemTableEh.RecreateFilterExpr;
begin
  if Filtered
    then FFilterExpr.ParseExpression(Filter)
    else FFilterExpr.ParseExpression('');
end;

procedure TCustomMemTableEh.DestroyFilterExpr;
begin
  FFilterExpr.ParseExpression('');
end;

procedure TCustomMemTableEh.SetFilterText(const Value: string);
begin
  if Active then
  begin
    if Value <> Filter then
    begin
      inherited SetFilterText(Value);
      RecreateFilterExpr;
      Refresh;
    end;
  end else
    inherited SetFilterText(Value);
end;

procedure TCustomMemTableEh.SetFiltered(Value: Boolean);
begin
  if Active then
  begin
    CheckBrowseMode;
    if Filtered <> Value then
    begin
      inherited SetFiltered(Value);
      RecreateFilterExpr;
//      First;
      Refresh;
    end;
  end
  else inherited SetFiltered(Value);
end;

procedure TCustomMemTableEh.SetOnFilterRecord(const Value: TFilterRecordEvent);
begin
  if Active then
  begin
    CheckBrowseMode;
    inherited SetOnFilterRecord(Value);
    if Filtered then
      Refresh;
  end
  else inherited SetOnFilterRecord(Value);
end;

function TCustomMemTableEh.IsRecordInFilter(Rec: TMemoryRecordEh): Boolean;
var
  SaveState: TDataSetState;
  DetV, MasV: Variant;
begin
  Result := True;
  SaveState := dsInactive;
  if not IsCursorOpen then Exit;
  if (Filtered and (Assigned(OnFilterRecord) or (Filter <> '')) ) or FDetailMode then
  begin
    try
      if Assigned(OnFilterRecord) then
      begin
        SaveState := SetTempState(dsFilter);
        RecordToBuffer(Rec, dvvValueEh, TempBuffer, -1);
      end;

      if FFilterExpr.HasData then
        Result := FFilterExpr.IsCurRecordInFilter(Rec);

      if Filtered and Assigned(OnFilterRecord) then
        OnFilterRecord(Self, Result);

      if Result and FDetailMode and (MasterDetailSide in [mdsOnSelfEh, mdsOnSelfAfterProviderEh]) then
      begin
        if FDetailRecListActive then
          Result := (FDetailRecList.IndexOf(Rec) >= 0)
        else begin
          { TODO : Use FDetailFieldList for fast}
//          DetV := FieldValues[FDetailFields];
          DetV := Rec.DataValues[FDetailFields, dvvValueEh];
          MasV := MasterSource.DataSet.FieldValues[MasterFields];
          Result := VarEquals(DetV, MasV);
        end;
      end;

    except
      Application.HandleException(Self);
    end;

    if Assigned(OnFilterRecord) then
      RestoreState(SaveState);
  end;
end;

function TCustomMemTableEh.GetPrefilteredList: TObjectList;
begin
  if FDetailRecListActive
    then Result := FDetailRecList
    else Result := nil;
end;

function TCustomMemTableEh.GetStatusFilter: TUpdateStatusSet;
begin
  Result := RecordsView.StatusFilter;
end;

procedure TCustomMemTableEh.SetStatusFilter(const Value: TUpdateStatusSet);
begin
  RecordsView.StatusFilter := Value;
end;

procedure TCustomMemTableEh.ViewDataEvent(MemRec: TMemoryRecordEh; Index:
  Integer; Action: TRecordsListNotification);
var
  ARowNum: Integer;

  procedure ViewDataEventToMTEvent;
  var
    MTEvent: TMTViewEventTypeEh;
  begin
    if not ( Action in
      [rlnRecAddedEh, rlnRecChangedEh, rlnRecDeletedEh, rlnListChangedEh] )
    then
      Exit;
    MTEvent := mtViewDataChangedEh;
    if Action = rlnListChangedEh then
      MTViewDataEvent(-1, MTEvent, -1)
    else
    begin
      case Action of
        rlnRecAddedEh: MTEvent := mtRowInsertedEh;
        rlnRecChangedEh: MTEvent := mtRowChangedEh;
        rlnRecDeletedEh: MTEvent := mtRowDeletedEh;
      end;
      ARowNum := ViewRecordIndexToViewRowNum(Index);
      MTViewDataEvent(ARowNum, MTEvent, -1);
    end;
  end;

begin
  if Active then
  begin
    ViewDataEventToMTEvent;
    Resync([]);
  end;
end;

procedure TCustomMemTableEh.ViewRecordMovedEvent(MemRec: TMemoryRecordEh; OldIndex, NewIndex: Integer);
var
  ARowNum, OldRowNum: Integer;
begin
  if Active and not ControlsDisabled then
  begin
    ARowNum := ViewRecordIndexToViewRowNum(NewIndex);
    OldRowNum := ViewRecordIndexToViewRowNum(OldIndex);
    MTViewDataEvent(ARowNum, mtRowMovedEh, OldRowNum);
  end;
end;

procedure TCustomMemTableEh.MTApplyUpdates(AMemTableData: TMemTableDataEh);
//var
//  ShadowTable: TMemTableDataShadowEh;
begin
  InternalApplyUpdates(AMemTableData, -1);
//////////////tmp
{  if not CachedUpdates and Assigned(DataDriver) then
  begin
    ShadowTable := TMemTableDataShadowEh.Create(RecordsView.MemTableData);
    case Action of

    end;
    ShadowTable.Free;
  end;}
end;

procedure TCustomMemTableEh.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    DataEvent(deDataSetChange, {$IFDEF CIL}nil{$ELSE}0{$ENDIF});
  end;
end;

{ Blobs }

function TCustomMemTableEh.GetBlobData(Field: TField;
  Buffer: TRecBuf): TMemBlobData;
//function TCustomMemTableEh.GetBlobData(Field: TField;
//  Data: Variant): Boolean;
begin
//  with PRecBuf(Buffer)^.Values[Field.FieldNo-1] do
    if VarIsNull(Buffer.Value[Field])
      then Result := ''
      else Result := Buffer.Value[Field];
end;

procedure TCustomMemTableEh.SetBlobData(Field: TField; Buffer: TRecBuf; Value: TMemBlobData);
begin
  if (Buffer = BufferToRecBuf(ActiveBuffer)) then
  begin
    if State = dsFilter then
      Error(SNotEditing);
    Buffer.Value[Field] := Value;
  end;
end;

procedure TCustomMemTableEh.CloseBlob(Field: TField);
begin
{  if (FRecordPos >= 0) and (FRecordPos < FRecordsView.Count) and (State = dsEdit) then
    PMemBlobArray(ActiveBuffer + FBlobOfs)[Field.FieldNo] :=
      PMemBlobArray(Records[FRecordPos].FBlobs)[Field.Offset]
  else
    PMemBlobArray(ActiveBuffer + FBlobOfs)[Field.Offset] := '';}
end;

function TCustomMemTableEh.CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream;
begin
  Result := TMemBlobStreamEh.Create(Field as TBlobField, Mode);
end;

{ Bookmarks }

function TCustomMemTableEh.BookmarkToRecNo(Bookmark: TBookmark): Integer;
begin
{$IFDEF CIL}
  Result := Integer(Bookmark);
{$ELSE}
  Result := Integer(PInteger(Bookmark)^);
{$ENDIF}
end;

function TCustomMemTableEh.BookmarkStrToRecNo(Bookmark: TBookmarkStr): Integer;
{$IFDEF CIL}
var
  TempPtr: IntPtr;
begin
  try
    TempPtr := Marshal.StringToHGlobalAnsi(Bookmark);
    Result := BookmarkToRecNo(TempPtr);
  finally
    Marshal.FreeHGlobal(TempPtr);
  end;
end;
{$ELSE}
begin
  Result := BookmarkToRecNo(Pointer(Bookmark));
end;
{$ENDIF}

function TCustomMemTableEh.RecNoToBookmarkStr(RecNo: Integer): TBookmarkStr;
{$IFDEF CIL}
var
  TempPtr: IntPtr;
begin
  TempPtr := Marshal.AllocHGlobal(BookmarkSize);
  try
    Marshal.WriteIntPtr(TempPtr, IntPtr(RecNo));
    Result := Marshal.PtrToStringAnsi(TempPtr, BookmarkSize);
  finally
    Marshal.FreeHGlobal(TempPtr);
  end;
end;
{$ELSE}
{$IFDEF EH_LIB_12}
var
  PR: PAnsiChar;
begin
  SetLength(Result, BookmarkSize);
  PR := PAnsiChar(Result);
  Move(RecNo, PR^, SizeOf(Integer));
{$ELSE}
var
  PR: PChar;
begin
  SetLength(Result, BookmarkSize);
  PR := PChar(Result);
  Move(RecNo, PR^, SizeOf(Integer));
//  Move(Result, PRecNo, SizeOf(Integer));
{$ENDIF}
end;
{$ENDIF}

{$IFDEF EH_LIB_12}
function TCustomMemTableEh.RecNoToBookmark(RecNo: Integer): TBookmark;
var
  PR: PByte;
begin
  SetLength(Result, BookmarkSize);
  PR := PByte(Result);
  Move(RecNo, PR^, SizeOf(Integer));
end;
{$ENDIF}

function TCustomMemTableEh.BookmarkValid({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmark): Boolean;
var
  ARecNo: Integer;
begin
  ARecNo := BookmarkToRecNo(Bookmark);
  Result := FActive and (ARecNo > 0) and (ARecNo <= RecordCount);
end;

function TCustomMemTableEh.CompareBookmarks({$IFDEF CIL}const{$ENDIF} Bookmark1, Bookmark2: TBookmark): Integer;
var
  ARecNo1, ARecNo2: Integer;
begin
  if (Bookmark1 = nil) and (Bookmark2 = nil) then
    Result := 0
  else if (Bookmark1 <> nil) and (Bookmark2 = nil) then
    Result := 1
  else if (Bookmark1 = nil) and (Bookmark2 <> nil) then
    Result := -1
  else
  begin
    ARecNo1 := BookmarkToRecNo(Bookmark1);
    ARecNo2 := BookmarkToRecNo(Bookmark2);
    if ARecNo1 > ARecNo2 then
      Result := 1
    else if ARecNo1 < ARecNo2 then
      Result := -1
    else Result := 0;
  end;
end;

function TCustomMemTableEh.GetBookmark: TBookmark;
{$IFDEF CIL}
{$ENDIF}
begin
  if FInstantReadMode then
  begin
{$IFDEF CIL}
{$ELSE}
{$IFDEF EH_LIB_12}
    SetLength(Result, BookmarkSize);
{$ELSE}
    GetMem(Result, BookmarkSize);
{$ENDIF}
    GetBookmarkData(InstantBuffer, Result);
{$ENDIF}
  end else
    Result := inherited GetBookmark;
end;

function TCustomMemTableEh.GetBookmarkStr: TBookmarkStr;
{$IFDEF CIL}
var
  TempPtr: intPtr;
{$ENDIF}
begin
  if FInstantReadMode then
  begin
{$IFDEF CIL}
    TempPtr := Marshal.AllocHGlobal(BookmarkSize);
    try
      InitializeBuffer(TempPtr, BookmarkSize, 0);
      GetBookmarkData(InstantBuffer, TempPtr);
      Result := Marshal.PtrToStringAnsi(TempPtr, BookmarkSize);
    finally
      Marshal.FreeHGlobal(TempPtr);
    end;
{$ELSE}
    SetLength(Result, BookmarkSize);
    GetBookmarkData(InstantBuffer, Pointer(Result));
{$ENDIF}
  end else
    Result := inherited GetBookmarkStr;
end;

procedure TCustomMemTableEh.GetBookmarkData(
{$IFDEF CIL}
  Buffer: TRecordBuffer; var Bookmark: TBookmark
{$ELSE}
{$IFDEF EH_LIB_12}
  Buffer: TRecordBuffer; Data: Pointer
{$ELSE}
  Buffer: PChar; Data: Pointer
{$ENDIF}
{$ENDIF}
  );
begin
{$IFDEF CIL}
  Marshal.WriteIntPtr(BookMark, IntPtr(BufferToRecBuf(Buffer).Bookmark));
{$ELSE}
  Move(BufferToRecBuf(Buffer).Bookmark, Data^, SizeOf(Integer));
{$ENDIF}
end;

procedure TCustomMemTableEh.SetBookmarkData(
{$IFDEF CIL}
  Buffer: TRecordBuffer; const Bookmark: TBookmark
{$ELSE}
{$IFDEF EH_LIB_12}
  Buffer: TRecordBuffer; Data: Pointer
{$ELSE}
  Buffer: PChar; Data: Pointer
{$ENDIF}
{$ENDIF}
  );
begin
{$IFDEF CIL}
  BufferToRecBuf(Buffer).Bookmark := Marshal.ReadInt32(BookMark);
{$ELSE}
  Move(Data^, BufferToRecBuf(Buffer).Bookmark, SizeOf(Integer));
{$ENDIF}
end;

function TCustomMemTableEh.GetBookmarkFlag(
{$IFDEF EH_LIB_12}
  Buffer: TRecordBuffer): TBookmarkFlag;
{$ELSE}
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}): TBookmarkFlag;
{$ENDIF}
begin
  Result := BufferToRecBuf(Buffer).BookmarkFlag;
end;

procedure TCustomMemTableEh.SetBookmarkFlag(
{$IFDEF EH_LIB_12}
  Buffer: TRecordBuffer; Value: TBookmarkFlag);
{$ELSE}
  Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF}; Value: TBookmarkFlag);
{$ENDIF}
begin
  BufferToRecBuf(Buffer).BookmarkFlag := Value;
end;

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.InternalGotoBookmark(Bookmark: Pointer);
{$ELSE}
procedure TCustomMemTableEh.InternalGotoBookmark({$IFDEF CIL}const{$ENDIF} Bookmark: TBookmark);
{$ENDIF}
var
  ARecNo: Integer;
begin
  ARecNo := BookmarkToRecNo(Bookmark);
  { TODO : Add support of MemoryTreeList }
  if (ARecNo > 0) and (ARecNo <= FRecordsView.ViewItemsCount)
    then FRecordPos := ARecNo - 1
    else DatabaseError(SRecordNotFound, Self);
  FInstantReadCurRowNum := FRecordPos;
end;

function TCustomMemTableEh.InstantReadIndexOfBookmark(Bookmark: TUniBookmarkEh): Integer;
{$IFDEF CIL}
var
  TempPtr: IntPtr;
{$ENDIF}
begin
{$IFDEF CIL}
  try
    TempPtr := Marshal.StringToHGlobalAnsi(Bookmark);
    Result := IndexOfBookmark(TempPtr);
  finally
    Marshal.FreeHGlobal(TempPtr);
  end;
{$ELSE}
  Result := IndexOfBookmark(TBookmark(Bookmark));
{$ENDIF}
end;

function TCustomMemTableEh.IndexOfBookmark(Bookmark: TBookmark): Integer;
begin
  if Bookmark = nil then
    Result := -1
    { TODO : Add support of MemoryTreeList }
  else
    Result := BookmarkToRecNo(Bookmark) - 1;
end;

{ Navigation }

{$IFDEF EH_LIB_12}
procedure TCustomMemTableEh.InternalSetToRecord(Buffer: TRecordBuffer);
{$ELSE}
procedure TCustomMemTableEh.InternalSetToRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}PChar{$ENDIF});
{$ENDIF}
begin
{  if BufferToRecBuf(Buffer).RecordNumber >= 0 then
  begin
    FRecordPos := BufferToRecBuf(Buffer).RecordNumber;
    FInstantReadCurRowNum := FRecordPos;
  end;}
{$IFDEF CIL}
  { TODO : To do for CIL }
{$ELSE}
  InternalGotoBookmark(Pointer(@(BufferToRecBuf(Buffer).Bookmark)));
{$ENDIF}
end;

procedure TCustomMemTableEh.InternalFirst;
begin
  FRecordPos := -1;
  FInstantReadCurRowNum := 0;
end;

procedure TCustomMemTableEh.InternalLast;
begin
  BeginRecordsViewUpdate;
  try
    DoFetchRecords(-1);
  finally
    EndRecordsViewUpdate(False);
  end;
  FRecordPos := FRecordsView.ViewItemsCount;
  if State in dsEditModes
    then FInstantReadCurRowNum := FRecordsView.ViewItemsCount // From AppendRecord
    else FInstantReadCurRowNum := FRecordPos - 1;
end;

{ Data Manipulation }

procedure TCustomMemTableEh.InternalAddRecord(Buffer: {$IFDEF CIL}TRecordBuffer{$ELSE}Pointer{$ENDIF}; Append: Boolean);
var
  RecPos: Integer;
  Rec: TMemoryRecordEh;
begin

  if Append then
  begin
    Rec := FRecordsView.NewRecord;
    try
      SetMemoryRecordData(Buffer, Rec);
      FRecordsView.AddRecord(Rec);
{      if CachedUpdates then
        FRecordsView.AddRecord(Rec)
      else
      begin
        FRecordsView.MemTableData.RecordsList.CachedUpdates := False;
        FRecordsView.AddRecord(Rec);
        FRecordsView.MemTableData.RecordsList.CachedUpdates := True;
      end;}
    except
      Rec.Free;
      raise;
    end;
{    if not CachedUpdates then
      try
        InternalApplyUpdates(FRecordsView.MemTableData, -1);
      except
        FRecordsView.CancelUpdates;
        raise;
      end;}
//    FRecordPos := FRecordsView.ViewItemsCount - 1;
    FRecordPos := FRecordsView.IndexOf(Rec);
  end else
  begin
    Rec := FRecordsView.NewRecord;
    try
      SetMemoryRecordData(Buffer, Rec);
      if FRecordPos = -1
        then RecPos := 0
        else RecPos := FRecordPos;
      FRecordsView.InsertRecord(RecPos, Rec);
    except
      Rec.Free;
      raise;
    end;

    if not CachedUpdates then
      try
        InternalApplyUpdates(FRecordsView.MemTableData, -1);
      except
        FRecordsView.CancelUpdates;
        raise;
      end;
//    FRecordPos := RecPos;
    FRecordPos := FRecordsView.IndexOf(Rec);
  end;
end;

procedure TCustomMemTableEh.InternalCancel;
begin
  BeginRecordsViewUpdate;
  try
  if (State = dsEdit) and (FRecordsView.ViewRecord[FRecordPos].EditState = resEditEh) then
    FRecordsView.ViewRecord[FRecordPos].Cancel;
  if not CachedUpdates and FRecordsView.MemTableData.RecordsList.HasCachedChanges then
    CancelUpdates;
  finally
    EndRecordsViewUpdate(False);
  end;
//  if State = dsInsert then
//    FView Cach
end;

procedure TCustomMemTableEh.InternalPost;
var
  Rec: TMemoryRecordEh;
begin
  BeginRecordsViewUpdate;
  try
    UpdateCursorPos;
    if State = dsEdit then
    begin
//      FRecordsView.MemTableData.RecordsList.CachedUpdates := False;
      Rec := FRecordsView.ViewRecord[FRecordPos];
      Rec.Edit;
      SetMemoryRecordData(ActiveBuffer, Rec);
      Rec.Post;
//      FRecordsView.MemTableData.RecordsList.CachedUpdates := True;
      if not CachedUpdates then
        InternalApplyUpdates(FRecordsView.MemTableData, -1);
      FRecordPos := FRecordsView.IndexOf(Rec);
    end else
      InternalAddRecord(ActiveBuffer, Eof);
  finally
    EndRecordsViewUpdate(False);
  end;
{  except
    UpdateCursorPos;
    Resync([]);
    raise;
  end;}
end;

procedure TCustomMemTableEh.InternalDelete;
begin
  { TODO : Add support of MemoryTreeList }
//  if FRecordsView.MemoryTreeList.
  BeginRecordsViewUpdate;
  try
    FRecordsView.DeleteRecord(FRecordPos);
    if not CachedUpdates then
      try
        InternalApplyUpdates(FRecordsView.MemTableData, -1);
      except
        FRecordsView.CancelUpdates;
        raise;
      end;

    if FRecordPos >= FRecordsView.ViewItemsCount then
      Dec(FRecordPos);
  finally
    EndRecordsViewUpdate(False);
  end;
//  Resync([]);
end;

procedure TCustomMemTableEh.CreateFields;
var
  I: Integer;
  Field: TField;
  DataField: TMTDataFieldEh;

  procedure SetKeyFields;
  var
    Pos, j: Integer;
    KeyFields, FieldName: string;
  begin
    KeyFields := PSGetKeyFields;
    Pos := 1;
    while Pos <= Length(KeyFields) do
    begin
      FieldName := ExtractFieldName(KeyFields, Pos);
      for j := 0 to FieldCount - 1 do
        if AnsiCompareText(FieldName, Fields[j].FieldName) = 0 then
        begin
          Fields[j].ProviderFlags := Fields[j].ProviderFlags + [pfInKey];
          break;
        end;
    end;
  end;

begin
  if ObjectView then
  begin
    for I := 0 to FieldDefs.Count - 1 do
      with FieldDefs[I] do
        if {(DataType <> ftUnknown) and}
          not ((faHiddenCol in Attributes) and not FIeldDefs.HiddenFields) then
          CreateField(Self);
  end else
  begin
    for I := 0 to FieldDefList.Count - 1 do
    begin
      Field := nil;
      with FieldDefList[I] do
        if {(DataType <> ftUnknown) and} not (DataType in ObjectFieldTypes) and
          not ((faHiddenCol in Attributes) and not FIeldDefs.HiddenFields)
        then
          Field := CreateField(Self, nil, FieldDefList.Strings[I]);
      if (Field <> nil) then
      begin
        DataField :=  FRecordsView.MemTableData.DataStruct.FieldByName(FieldDefList.Strings[I]);
        if DataField <> nil then
        begin
          Field.DisplayLabel := DataField.DisplayLabel;
          Field.Visible := DataField.Visible;
        end;
      end;
    end;
  end;
  SetKeyFields;
end;
{begin
  inherited CreateFields;

end;}

procedure TCustomMemTableEh.OpenCursor(InfoQuery: Boolean);
begin
  if not InfoQuery then
  begin
    if  DataDriver <> nil then
    begin
      if (MasterSource <> nil) and (MasterDetailSide in [mdsOnProviderEh, mdsOnSelfAfterProviderEh]) then
        SetParamsFromCursor;
      { TODO : realise DataDriver.SetParams(FParams); }
      // DataDriver.PSSetParams(FParams);
      FDataSetReader := FDataDriver.GetDataReader;
      if FDataSetReader <> nil then
        FDataSetReader.FreeNotification(Self);
    end;
    if DataDriver <> nil then
    begin
      //? Добавить (FieldCount > 0) then но только не для запроса списка полей в DesignTime.
      DataDriver.BuildDataStruct(FRecordsView.MemTableData.DataStruct);
    end else
    begin
      {if FieldCount > 0 then
        FieldDefs.Clear;
      InitFieldDefsFromFields;}
      if FRecordsView.MemTableData.IsEmpty then
        DatabaseError('MemTable don''t have data.', Self);
    end;
    CreateIndexesFromDefs;
    FActive := True;
  end;
  inherited OpenCursor(InfoQuery);
end;

procedure TCustomMemTableEh.InternalOpen;
begin
  BookmarkSize := SizeOf(Integer);
  FieldDefs.Updated := False;
  FieldDefs.Update;
  if DefaultFields then
    CreateFields;
  BindFields(True);
  if FieldCount = 0 then
    DatabaseError('No fields defined. Cannot create dataset.');
  InitBufferPointers(True);
  InternalFirst;
//  FInstantBuffer := AllocRecordBuffer;
//  BufferToRecBuf(FInstantBuffer).RecordNumber := -1;
  UpdateDetailMode(False);
  RecreateFilterExpr;
//  if Filtered then
//    FRecordsView.RefreshFilteredRecsList;
  InternalRefresh;
  FRecordsView.UpdateFields;
  FRecordsView.Aggregates.Reset;
  FRecordsView.SortOrder := FSortOrder;
end;

procedure TCustomMemTableEh.InternalClose;
begin
  FMasterValList.Clear;
  FActive := False;
  DestroyFilterExpr;
  FAutoInc := 1;
  FRecordsView.Aggregates.Reset;
  BindFields(False);
  if DefaultFields then
    DestroyFields;

//  FInstantBuffers.Free;
{  if FInstantBuffers.Count > 0 then
  begin
    while FInstantBuffers.Count > 0 do
    begin
    end;
    FreeRecordBuffer(FInstantBuffer);
    FInstantBuffer := nil;
  end;}
//  SetLength(FInstantBuffers, 0);
  FDataSetReader := nil;
  if DataDriver <> nil then
    DataDriver.ConsumerClosed(Self);
  FRecordsView.SortOrder := '';
end;

procedure TCustomMemTableEh.InternalHandleException;
begin
  Application.HandleException(Self);
end;

procedure TCustomMemTableEh.InternalInitFieldDefs;
var
  TempMemTableData: TMemTableDataEh;
begin
//  ShowMessage('InternalInitFieldDefs 1');
  if not FActive and (csDesigning in ComponentState) and (DataDriver <> nil) then
  begin
//    ShowMessage('InternalInitFieldDefs 2');
    TempMemTableData := TMemTableDataEh.Create(nil);
    DataDriver.BuildDataStruct(TempMemTableData.DataStruct);
    TempMemTableData.DataStruct.BuildFieldDefsFromStruct(FieldDefs);
    TempMemTableData.Free;
  end else
    FRecordsView.MemTableData.DataStruct.BuildFieldDefsFromStruct(FieldDefs);
end;

function TCustomMemTableEh.IsCursorOpen: Boolean;
begin
  Result := FActive;
end;

{ Informational }

function TCustomMemTableEh.GetRecordCount: Integer;
begin
  CheckActive;
  Result := FRecordsView.ViewItemsCount;
end;

function TCustomMemTableEh.GetRecNo: Integer;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
//  UpdateCursorPos;
  Result := -1;
  if not GetActiveRecBuf(RecBuf)
    then Exit
    else Result := RecBuf.RecordNumber + 1;

//  if (FRecordPos = -1) and (RecordCount > 0)
//    then Result := 1
//    else Result := FRecordPos + 1;
end;

procedure TCustomMemTableEh.SetRecNo(Value: Integer);
begin
  if (Value > 0) and (Value <= FRecordsView.ViewItemsCount) then
  begin
    DoBeforeScroll;
    FRecordPos := Value - 1;
    Resync([]);
    DoAfterScroll;
  end;
end;

function TCustomMemTableEh.IsSequenced: Boolean;
begin
  Result := True;
end;

function TCustomMemTableEh.FindRec(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Integer;

var
  Fields: TObjectList;
  I, RecIndex: Integer;
  UseRecordBuffer: Boolean;
  MTIndex: TMTIndexEh;

  function CompareField(Field: TField; Value: Variant): Boolean;
  var
    S,VS: string;
  begin
    if Field.DataType in [ftString, ftWideString] then
    begin
      S := Field.AsString;
      VS := VarToStr(Value);
      if (loPartialKey in Options) then
{$IFDEF CIL}
        Borland.Delphi.System.Delete(S, Length(VS) + 1, MaxInt);
{$ELSE}
        System.Delete(S, Length(VS) + 1, MaxInt);
{$ENDIF}
      if (loCaseInsensitive in Options) then
        Result := AnsiCompareText(S, VS) = 0
      else
        Result := AnsiCompareStr(S, VS) = 0;
    end
    else
      Result := VarEquals(Field.Value, Value);
  end;

  function CompareRecord: Boolean;
  var
    I: Integer;
  begin
    if Fields.Count = 1 then
      Result := CompareField(TField(Fields.First), KeyValues)
    else begin
      Result := True;
      for I := 0 to Fields.Count - 1 do
        Result := Result and CompareField(TField(Fields[I]), KeyValues[I]);
    end;
  end;

begin
  Result := -1;
  UseRecordBuffer := False;
  MTIndex := nil;
  Fields := TObjectList.Create(False);
  try
    GetFieldList(Fields, KeyFields);

    if Options <> [] then
      UseRecordBuffer := True
    else
      for I := 0 to Fields.Count-1 do
        if TField(Fields[I]).FieldNo <= 0 then
        begin
          UseRecordBuffer := True;
          Break;
        end;

    if not UseRecordBuffer then
      MTIndex := FRecordsView.MemTableData.RecordsList.Indexes.GetIndexForFields(KeyFields);
    if MTIndex = nil then
      UseRecordBuffer := True;
//    UseRecordBuffer := True;
    if UseRecordBuffer then
      for I := 0 to RecordCount-1 do
      begin
        InstantReadEnter(I);
        try
          if CompareRecord then
          begin
            Result := I;
            Break;
          end;
        finally
          InstantReadLeave;
        end;
      end
    else
    begin
      if MTIndex.FindRecordIndexByKey(KeyValues, RecIndex) then
//        Result := RecIndex;
        Result := FRecordsView.IndexOf(FRecordsView.MemTableData.RecordsList[RecIndex]);
    end;

    while (Result = -1) and (DataDriver <> nil) and not DataDriver.ProviderEOF do
    begin
      BeginRecordsViewUpdate;
      try
        DoFetchRecords(1);
      finally
        EndRecordsViewUpdate(False);
      end;

      InstantReadEnter(RecordCount-1);
      try
        if CompareRecord then
          Result := RecordCount-1;
      finally
        InstantReadLeave;
      end;
    end;

  finally
    Fields.Free;
  end;
end;

function TCustomMemTableEh.Locate(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;
var
  FindedRecPos: Integer;
begin

  Result := False;

  CheckBrowseMode;
  if BOF and EOF then Exit;

  BeginRecordsViewUpdate;
//  FRecordsView.CatchChanged := False;

  FindedRecPos := FindRec(KeyFields, KeyValues, Options);
  if FindedRecPos <> -1 then
  begin
    FRecordPos := FindedRecPos;
//    FInstantReadCurRowNum := FindedRecPos;
    Result := True;
    Resync([rmExact, rmCenter]);
  end;

  EndRecordsViewUpdate(True);

(*  if Result {or FRecordsView.CatchChanged} then
  begin
    DoBeforeScroll;
    Resync([rmExact, rmCenter]);
    DoAfterScroll;
  end;
*)  
end;

function TCustomMemTableEh.Lookup(const KeyFields: string;
  const KeyValues: Variant; const ResultFields: string): Variant;
var
  FindedRecPos: Integer;
begin
  Result := Unassigned;

  FRecordsView.CatchChanged := False;

  FindedRecPos := FindRec(KeyFields, KeyValues, []);
  if FindedRecPos <> -1 then
  begin
    InstantReadEnter(FindedRecPos);
    try
      Result := FieldValues[ResultFields];
    finally
      InstantReadLeave;
    end;
  end;

  if FRecordsView.CatchChanged then
    Resync([]);
end;

{ Table Manipulation }

procedure TCustomMemTableEh.EmptyTable;
begin
  if Active then
  begin
    BeginRecordsViewUpdate;
    try
      CheckBrowseMode;
      ClearRecords;
      ClearBuffers;
    finally
      EndRecordsViewUpdate(True);
    end;
//    Resync([]);
//    DataEvent(deDataSetChange, 0);
  end;
end;

procedure TCustomMemTableEh.DestroyTable;
begin
  Close;
  FRecordsView.MemTableData.DestroyTable;
end;

procedure TCustomMemTableEh.CopyStructure(Source: TDataSet);

  procedure CheckDataTypes(FieldDefs: TFieldDefs);
  var
    I: Integer;
  begin
    for I := FieldDefs.Count - 1 downto 0 do
    begin
      if not (FieldDefs.Items[I].DataType in ftSupported) then
        FieldDefs.Items[I].Free
      else CheckDataTypes(FieldDefs[I].ChildDefs);
    end;
  end;

var
  I: Integer;
begin
  CheckInactive;
  for I := FieldCount - 1 downto 0 do
    Fields[I].Free;
  if (Source = nil) then Exit;
  Source.FieldDefs.Update;
  FieldDefs := Source.FieldDefs;
  CheckDataTypes(FieldDefs);
  CreateFields;
{  for I := 0 to FieldDefs.Count - 1 do
  begin
    if (csDesigning in ComponentState) and (Owner <> nil) then
      FieldDefs.Items[I].CreateField(Owner)
    else
      FieldDefs.Items[I].CreateField(Self);
  end;
}  
end;

procedure TCustomMemTableEh.FetchRecord(DataSet: TDataSet);
var
  Rec: TMemoryRecordEh;
  i: Integer;
  Field: TField;
begin
  CheckBrowseMode;

  Rec := FRecordsView.NewRecord;

  for i := 0 to FieldCount-1 do
    if Fields[i].FieldNo > 0 then
    begin
      Field := DataSet.FindField(Fields[i].FieldName);
      if Field <> nil then
        Rec.Value[Fields[i].FieldNo-1, dvvValueEh] := Field.Value;
    end;

  FRecordsView.MemTableData.RecordsList.FetchRecord(Rec);
end;

procedure AssignRecord(Source, Destinate: TDataSet);
var
  i: Integer;
  Field: TField;
begin
  for i := 0 to Destinate.FieldCount-1 do
    if Destinate.Fields[i].FieldNo > 0 then
    begin
      Field := Source.FindField(Destinate.Fields[i].FieldName);
      if Field <> nil then
        Destinate.Fields[i].Value := Field.Value;
    end;
end;

function TCustomMemTableEh.LoadFromDataSet(Source: TDataSet; RecordCount: Integer;
  Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;
var
  SourceActive: Boolean;
  MovedCount: Integer;
begin
  Result := 0;
  if Source = Self then Exit;
  SourceActive := Source.Active;
  Source.DisableControls;
  try
    DisableControls;
    try
      with Source do
      begin
        Open;
        CheckBrowseMode;
        UpdateCursorPos;
      end;
      if Mode = lmCopy then
      begin
        Close;
        FRecordsView.MemTableData.DestroyTable;
        FRecordsView.MemTableData.DataStruct.BuildStructFromFields(Source.Fields);
      end;
      if not Active then Open;
      CheckBrowseMode;
      if RecordCount > 0 then
        MovedCount := RecordCount
      else
      begin
        Source.First;
        MovedCount := MaxInt;
      end;
      try
        while not Source.EOF do
        begin
          if UseCachedUpdates and CachedUpdates then
          begin
            Append;
            AssignRecord(Source, Self);
            Post;
          end else
            FetchRecord(Source);
          Inc(Result);
          if Result >= MovedCount then Break;
          Source.Next;
        end;
      finally
        First;
      end;
    finally
      EnableControls;
    end;
  finally
    if not SourceActive then
      Source.Close;
    Source.EnableControls;
  end;
end;

function TCustomMemTableEh.SaveToDataSet(Dest: TDataSet; RecordCount: Integer): Integer;
var
  MovedCount: Integer;
begin
  Result := 0;
  if Dest = Self then Exit;
  CheckBrowseMode;
  UpdateCursorPos;
  Dest.DisableControls;
  try
    DisableControls;
    try
      if not Dest.Active
        then Dest.Open
        else Dest.CheckBrowseMode;
      if RecordCount > 0 then
        MovedCount := RecordCount
      else
      begin
        First;
        MovedCount := MaxInt;
      end;
      try
        while not EOF do
        begin
          Dest.Append;
          AssignRecord(Self, Dest);
          Dest.Post;
          Inc(Result);
          if Result >= MovedCount then Break;
          Next;
        end;
      finally
        Dest.First;
      end;
    finally
      EnableControls;
    end;
  finally
    Dest.EnableControls;
  end;
end;

procedure TCustomMemTableEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
{    if AComponent = FProviderDataSet then
      ProviderDataSet := nil;}
    if AComponent = FDataSetReader then
      FDataSetReader := nil;
    if AComponent = FDataDriver then
      DataDriver := nil;
  end;
end;

procedure TCustomMemTableEh.InternalRefresh;
var
  MTIndex: TMTIndexEh;
begin
  FDetailRecListActive := False;
  if FDetailMode then
  begin
    MTIndex := FRecordsView.MemTableData.RecordsList.Indexes.GetIndexForFields(DetailFields);
    if MTIndex <> nil then
    begin
      FDetailRecList.Clear;
      MTIndex.FillMatchedRecsList(FMasterValues, FDetailRecList);
{ TODO : Get indexex from FRecordsView }      
      FDetailRecListActive := True;
    end;
  end;
  FRecordsView.RefreshFilteredRecsList;
  FDetailRecListActive := False;
  InternalFirst;
end;

procedure TCustomMemTableEh.UpdateDetailMode(AutoRefresh: Boolean);
var
  NewDetailMode: Boolean;
begin
  NewDetailMode := False;
  if Fields.Count > 0 then
  begin
    FDetailFieldList.Clear;
    GetFieldList(FDetailFieldList, DetailFields);
    if MasterDetailSide in [mdsOnSelfEh, mdsOnSelfAfterProviderEh] then
    begin
      if (FDetailFieldList.Count > 0) and FMasterDataLink.Active and
        (FMasterDataLink.Fields.Count > 0)
      then
        NewDetailMode := True;
    end else if FMasterDataLink.Active then
      NewDetailMode := True;
  end;
  if NewDetailMode <> FDetailMode then
  begin
    FDetailMode := NewDetailMode;
    if not FDetailMode then
      FMasterValues := Unassigned
    else
      if MasterDetailSide in [mdsOnSelfEh, mdsOnSelfAfterProviderEh] then
      FMasterValues := MasterSource.DataSet.FieldValues[MasterFields];
    if AutoRefresh then
      if MasterDetailSide in [mdsOnProviderEh, mdsOnSelfAfterProviderEh]
        then RefreshParams
        else Refresh;
  end;
end;

procedure TCustomMemTableEh.MasterChange(Sender: TObject);
var
  OldDetailMode: Boolean;
begin
  OldDetailMode := FDetailMode;
  UpdateDetailMode(False);
  case  MasterDetailSide of
    mdsOnProviderEh:
      RefreshParams;
    mdsOnSelfEh:
      begin
        if (OldDetailMode <> FDetailMode) or
          (FDetailMode and not VarEquals(FMasterValues, MasterSource.DataSet.FieldValues[MasterFields])) then
         begin
           FMasterValues := MasterSource.DataSet.FieldValues[MasterFields];
           Refresh;
         end;
       end;
    mdsOnSelfAfterProviderEh:
      begin
        if (OldDetailMode <> FDetailMode) or
          (FDetailMode and not VarEquals(FMasterValues, MasterSource.DataSet.FieldValues[MasterFields])) then
        begin
          FMasterValues := MasterSource.DataSet.FieldValues[MasterFields];
          RefreshParams;
        end;
      end;
  end;
end;

function TCustomMemTableEh.GetCanModify: Boolean;
begin
  Result := not ReadOnly;
end;

procedure TCustomMemTableEh.DoOnNewRecord;
var
  i: Integer;
begin
  for i := 0 to Fields.Count-1 do
    if (Fields[i].DefaultExpression <> '') and Fields[i].CanModify then
      Fields[i].Text := Fields[i].DefaultExpression;
  if FDetailMode {and (MasterDetailSide = mdsOnSelfEh)} then
    FieldValues[FDetailFields] := MasterSource.DataSet.FieldValues[MasterFields];
  inherited DoOnNewRecord;
//  MTViewDataEvent(GetInstantReadCurRowNum, mtRowInsertedEh, -1)
end;

procedure TCustomMemTableEh.SetParams(const Value: TParams);
begin
  FParams.Assign(Value);
end;

procedure TCustomMemTableEh.SetMasterDetailSide(const Value: TMasterDetailSideEh);
begin
  if (FMasterDetailSide <> Value) then
  begin
    FMasterDetailSide := Value;
    UpdateDetailMode(False);
    if FDetailMode and Active then
      if MasterDetailSide = mdsOnProviderEh then
      begin
        Close;
        Open;
      end else
        Refresh;
  end;
end;

procedure TCustomMemTableEh.SetParamsFromCursor;
var
//  I: Integer;
  DataSet: TDataSet;
begin
  if MasterSource <> nil then
  begin
    DataSet := MasterSource.DataSet;
    if DataSet.Active and (DataSet.State <> dsSetKey) and (DataDriver <> nil) then
    begin
      DataDriver.SetReaderParamsFromCursor(DataSet);
      if MasterDetailSide=mdsOnSelfAfterProviderEh then
        FMasterValList.Add(TSortedVarItemEh.Create(Dataset.FieldValues[MasterFields]));
{    if DataSet <> nil then
    begin
      DataSet.FieldDefs.Update;
      for I := 0 to FParams.Count - 1 do
        with FParams[I] do
          if not Bound then
          begin
            AssignField(DataSet.FieldByName(Name));
            Bound := False;
          end;}
    end;
  end;
end;

procedure TCustomMemTableEh.RefreshParams;
var
  DataSet: TDataSet;
//  Field: TField;
//  I: Integer;
begin
  DisableControls;
  try
    if MasterSource <> nil then
    begin
      DataSet := MasterSource.DataSet;
      if DataSet <> nil then
        if DataSet.Active and (DataSet.State <> dsSetKey) and (DataDriver <> nil) then
        begin
          case  MasterDetailSide of
            mdsOnProviderEh:
              if DataDriver.RefreshReaderParamsFromCursor(DataSet) then
              begin
                Close;
                Open;
              end;
            mdsOnSelfAfterProviderEh:
              begin
                if  not FMasterValList.VarInList(Dataset.FieldValues[MasterFields]) then
                begin
                  DoFetchRecords(-1);
                  DataDriver.ConsumerClosed(Self);
                  SetParamsFromCursor;
                  FDataSetReader := FDataDriver.GetDataReader;
                  if FDataSetReader <> nil then
                    FDataSetReader.FreeNotification(Self);
                end;
                Refresh;
              end;
          end;

{          for I := 0 to FParams.Count - 1 do
          begin
            Field := DataSet.FindField(FParams[I].Name);
            if (Field <> nil) and not VarEquals(Field.Value, FParams[I].Value) then
            begin
              Close;
              Open;
              Break;
            end;
          end;}
        end;
    end;
  finally
    EnableControls;
  end;
end;

procedure TCustomMemTableEh.FetchParams;
//var
//  ProviderParams: TParams;
begin
  if DataDriver <> nil then
{ TODO : realise DataDriver.GetParams(FParams); }  
//    Params.Assign(DataDriver.GetParams)
{  else if ProviderDataSet <> nil then
  begin
    ProviderParams := IProviderSupport(ProviderDataSet).PSGetParams;
    Params.Assign(ProviderParams);
  end;}
end;

procedure TCustomMemTableEh.RefreshRecord;
begin
  CheckActive;
  UpdateCursorPos;
  if (DataDriver <> nil) and (RecordCount > 0) then
  begin
    DataDriver.RefreshRecord(RecordsView.ViewRecord[FRecordPos]);
    Resync([]);
  end;
end;

procedure TCustomMemTableEh.RevertRecord;
begin
  Cancel;
  CheckBrowseMode;
  UpdateCursorPos;
  if IsEmpty then
    raise Exception.Create('There are no records.');
  if FRecordsView.ViewAsTreeList
    then  { TODO : Add support of MemoryTreeList } // FRecordsView.FRecordsView.MemoryTreeList.VisibleItems[RowNum].Data.RevertRecord;
    else FRecordsView.RevertRecord(RecNo-1);
  Resync([]);
end;

function TCustomMemTableEh.UpdateStatus: TUpdateStatus;
begin
  CheckActive;
  if RecNo > 0
    then Result := FRecordsView.ViewRecord[RecNo-1].UpdateStatus
    else Result := usUnmodified;
end;

procedure TCustomMemTableEh.CancelUpdates;
begin
  FRecordsView.CancelUpdates;
  Resync([]);
end;

procedure TCustomMemTableEh.DataEvent(Event: TDataEvent; Info: {$IFDEF CIL}TObject{$ELSE}Integer{$ENDIF} );
begin
  if Active and FOldControlsDisabled and not ControlsDisabled then
  begin
    if FMTViewDataEventInactiveCount = 1 then
    begin
      MTViewDataEvent(FInactiveEventRowNum, FInactiveEvent, FInactiveEventOldRowNum);
    end else if FMTViewDataEventInactiveCount > 0 then
      MTViewDataEvent(-1, mtViewDataChangedEh, -1);
    FMTViewDataEventInactiveCount := 0;
  end;
  case Event of
    deDataSetChange, deLayoutChange:
      ;
//??      BufferToRecBuf(InstantBuffer).RecordNumber := -1;
    deFieldListChange:
      begin
        if Active and not (csLoading in ComponentState) then
        begin
          FRecordsView.Aggregates.Reset;
          Resync([]);
        end;
        BindCalFields;
      end;
    deUpdateState:
      if (State = dsInsert) and (FStateInsert = False) then
      begin
        FStateInsert := True;
        MTViewDataEvent(InstantReadCurRow, mtRowInsertedEh, -1)
      end else if (State = dsBrowse) and (FStateInsert = True) then
      begin
        FStateInsert := False;
        MTViewDataEvent(InstantReadCurRow, mtRowDeletedEh, -1)
      end;
  end;
  inherited DataEvent(Event, Info);
  if Active and not FOldActive then
    MTViewDataEvent(-1, mtViewDataChangedEh, -1);
  FOldControlsDisabled := ControlsDisabled;
  FOldActive := Active;
end;

procedure TCustomMemTableEh.CreateIndexesFromDefs;
var
  I: Integer;
  Index: TMTIndexEh;
begin
  for I := 0 to IndexDefs.Count - 1 do
  begin
    Index := FRecordsView.MemTableData.RecordsList.Indexes.Add;
    Index.Fields := IndexDefs[i].Fields;
    Index.Unical := ixUnique in IndexDefs[i].Options;
    Index.Primary := ixPrimary in IndexDefs[i].Options;
  end;
  for I := 0 to IndexDefs.Count - 1 do
    FRecordsView.MemTableData.RecordsList.Indexes.Items[i].Active := True;
end;

procedure TCustomMemTableEh.CreateDataSet;
begin
  CheckInactive;
  InitFieldDefsFromFields;
  FRecordsView.MemTableData.DestroyTable;
  FRecordsView.MemTableData.DataStruct.BuildStructFromFieldDefs(FieldDefs);
  SetExtraStructParams;
  CreateIndexesFromDefs;
  Open;
end;

procedure TCustomMemTableEh.SetExtraStructParams;
var
  i: Integer;
begin
  for i := 0 to FRecordsView.MemTableData.DataStruct.Count - 1 do
  begin
    if FRecordsView.MemTableData.DataStruct[i].FieldName = FAutoIncrementFieldName then
      FRecordsView.MemTableData.DataStruct[i].AutoIncrement := True;
  end;
end;

procedure TCustomMemTableEh.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  inherited GetChildren(Proc, Root);
  if (DataDriver = nil) and (ExternalMemData = nil) and not FRecordsView.MemTableData.IsEmpty then
    Proc(FRecordsView.MemTableData);
end;

procedure TCustomMemTableEh.AncestorNotFound(Reader: TReader;
  const ComponentName: string; ComponentClass: TPersistentClass;
  var Component: TComponent);
begin
  if (ComponentName = 'MemTableData') and (Reader.Root <> nil) then
    Component := FRecordsView.MemTableData;
end;

procedure TCustomMemTableEh.CreateComponent(Reader: TReader;
  ComponentClass: TComponentClass; var Component: TComponent);
begin
  if ComponentClass.InheritsFrom(TMemTableDataEh) then
    Component := FRecordsView.MemTableData;
end;

procedure TCustomMemTableEh.ReadState(Reader: TReader);
var
  OldOnCreateComponent: TCreateComponentEvent;
  OldOnAncestorNotFound: TAncestorNotFoundEvent;
begin
  OldOnCreateComponent := Reader.OnCreateComponent;
  OldOnAncestorNotFound := Reader.OnAncestorNotFound;
  Reader.OnCreateComponent := CreateComponent;
  Reader.OnAncestorNotFound := AncestorNotFound;

  try
    inherited ReadState(Reader);
  finally
    Reader.OnCreateComponent := OldOnCreateComponent;
    Reader.OnAncestorNotFound := OldOnAncestorNotFound;
  end;
end;

// Aggregates

procedure TCustomMemTableEh.ResetAggField(Field: TField);
var
  I: Integer;
  Agg: TMTAggregateEh;
  AggF: TAggregateField;
begin
  for I := 0 to AggFields.Count - 1 do
    if AggFields[I] = Field then
    begin
      AggF := AggFields[I] as TAggregateField;
      Agg := TMTAggregateEh(AggF.Handle);
      if Agg <> nil then
      begin
        FRecordsView.Aggregates.BeginUpdate;
        Agg.Assign(AggF);
        FRecordsView.Aggregates.EndUpdate;
        Agg.Reset;
        Agg.Recalc;
        if Active then
          DataEvent(deDataSetChange, {$IFDEF CIL}nil{$ELSE}0{$ENDIF});
      end;
    end;
end;

function TCustomMemTableEh.GetAggregateValue(Field: TField): Variant;
var
 Agg: TMTAggregateEh;
 RecBuf: TRecBuf;
begin
  Result := Null;
  if AggregatesActive and GetActiveRecBuf(RecBuf) then
  begin
    Agg := TMTAggregateEh(TAggregateField(Field).Handle);
    if Agg <> nil then
      Result := Agg.Value;
  end;
end;

procedure TCustomMemTableEh.SetAggregatesActive(const Value: Boolean);
begin
  if AggregatesActive <> Value then
  begin
    FRecordsView.Aggregates.Active := Value;
    if Active then
    begin
      if AggFields.Count > 0 then
      begin
        UpdateCursorPos;
        Resync([]);
      end;
    end;
  end;
end;

function TCustomMemTableEh.GetAggregatesActive: Boolean;
begin
  Result := FRecordsView.Aggregates.Active;
end;

function TCustomMemTableEh.CreateDeltaDataSet: TCustomMemTableEh;
begin
  Result := TCustomMemTableEh.Create(nil);
//  FMemTable.FieldDefs.Update;
  Result.FieldDefs := FieldDefs;
  Result.CachedUpdates := True;
//  Result.Open;
  Result.CreateDataSet;
end;

procedure TCustomMemTableEh.BindCalFields;
var
  i, k: Integer;
begin
  SetLength(FCalcFieldIndexes, Fields.Count);
  k := 0;
  for i := 0  to Fields.Count-1 do
    if Fields[i].FieldKind in [fkCalculated, fkLookup] then
    begin
      FCalcFieldIndexes[i] := k;
      Inc(k)
    end else
      FCalcFieldIndexes[i] := -1;
end;

procedure TCustomMemTableEh.BindFields(Binding: Boolean);
begin
  inherited BindFields(Binding);
end;

procedure TCustomMemTableEh.SetDataDriver(const Value: TDataDriverEh);
var
  ConsumerItfs: IDataDriverConsumerEh;
  Msg: TCMChanged;
begin
  if Value <> FDataDriver then
  begin

    if (Value <> nil) and (ExternalMemData <> nil) then
      raise Exception.Create('Assigning to DataDriver is not allowed if ExternalMemData is assigned');

    ConsumerItfs := nil;
    if Assigned(FDataDriver) then
      if Supports(TObject(FDataDriver), IDataDriverConsumerEh, ConsumerItfs) then
        ConsumerItfs.DataDriverConsumer := nil;
//    and ((FDataDriver as IDataDriverConsumerEh).DataDriverConsumer = Self) then
//      (FDataDriver as IDataDriverConsumerEh).DataDriverConsumer := nil;
    FDataDriver := Value;
    if Assigned(FDataDriver) then
    begin
      { If another dataset already references this updateobject, then
        remove the reference }
      if Supports(TObject(FDataDriver), IDataDriverConsumerEh, ConsumerItfs) then
      begin
        if Assigned(ConsumerItfs.DataDriverConsumer) and
          (ConsumerItfs.DataDriverConsumer is TMemTableEh) and
          (ConsumerItfs.DataDriverConsumer <> Self)
        then
          (ConsumerItfs.DataDriverConsumer as TMemTableEh).DataDriver := nil;
        ConsumerItfs.DataDriverConsumer := Self;
      end;
      DriverStructChanged;
    end;

    if Value <> nil then Value.FreeNotification(Self);

    if not (csLoading in ComponentState) and (csDesigning in ComponentState) then
    begin
      Msg.Msg := CM_CHANGED;
{$IFDEF CIL}
{$ELSE}
      Msg.Unused := 0;
      Msg.Child := nil;
{$ENDIF}
      Msg.Result := 0;
      if (Owner is TWinControl) then
        TWinControl(Owner).Broadcast(Msg);
    end;

  end;
end;

function TCustomMemTableEh.GetUpdateError: TUpdateErrorEh;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  Result := nil;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecordNumber >= 0)
  then
    Result := FRecordsView.ViewRecord[RecBuf.RecordNumber].UpdateError;
end;

function TCustomMemTableEh.GetAutoIncrement: TAutoIncrementEh;
begin
  Result := RecordsView.MemTableData.AutoIncrement
end;

procedure TCustomMemTableEh.SetAutoIncrement(const Value: TAutoIncrementEh);
begin
  RecordsView.MemTableData.AutoIncrement.Assign(Value);
end;

function TCustomMemTableEh.GetTreeNodeHasChields: Boolean;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  Result := False;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := TMemRecViewEh(RecBuf.RecView).NodeHasChildren;
end;

function TCustomMemTableEh.GetTreeNodeLevel: Integer;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  Result := -1;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := TMemRecViewEh(RecBuf.RecView).NodeLevel;
end;

function TCustomMemTableEh.GetPrevVisibleTreeNodeLevel: Integer;
begin
  CheckActive;
  Result := -1;
  if RecordsView.ViewAsTreeList and (RecNo > 1) then
    Result := RecordsView.MemoryTreeList.VisibleItem[RecNo-2].NodeLevel;
end;

function TCustomMemTableEh.GetNextVisibleTreeNodeLevel: Integer;
begin
  CheckActive;
  Result := -1;
  if RecNo < RecordCount then
    Result := RecordsView.MemoryTreeList.VisibleItem[RecNo].NodeLevel;
end;

function TCustomMemTableEh.MemTableIsTreeList: Boolean;
begin
  Result := RecordsView.ViewAsTreeList;
end;

function TCustomMemTableEh.ParentHasNextSibling(ParenLevel: Integer): Boolean;
var
  RecBuf: TRecBuf;
  TreeNode, CurNode: TMemRecViewEh;
begin
  CheckActive;
  Result := False;
  TreeNode := nil;
  if ParenLevel <= 0 then
    Exit;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    TreeNode := RecBuf.RecView;
  if TreeNode = nil then
    Exit;
  CurNode := TreeNode;
  while ParenLevel < TreeNode.NodeLevel do
  begin
    CurNode := CurNode.NodeParent;
    Inc(ParenLevel);
  end;
  if RecordsView.MemoryTreeList.GetNextVisibleSibling(CurNode) <> nil
    then Result := True
    else Result := False;
end;

function TCustomMemTableEh.SetTempRecBufForRecord(Rec: TMemoryRecordEh;
  TreeNode: TMemRecViewEh; RecNum: Integer): TRecBuf;
var
{$IFDEF CIL}
    AInstantBuffer: TRecordBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
    AInstantBuffer: TRecordBuffer;
{$ELSE}
    AInstantBuffer: PChar;
{$ENDIF}
{$ENDIF}
begin
  if FInstantReadMode then
    raise Exception.Create('TCustomMemTableEh already in instant read mode.');
  FInstantReadMode := True;
  AInstantBuffer := AllocRecordBuffer;
  try
    RecordToBuffer(Rec, dvvValueEh, AInstantBuffer, RecNum);
    {if RecNum > 0 then
    begin
      BufferToRecBuf(AInstantBuffer).Bookmark := RecNum+1;
      BufferToRecBuf(AInstantBuffer).RecordNumber := RecNum;
    end else
    begin
      BufferToRecBuf(AInstantBuffer).Bookmark := -1;
      BufferToRecBuf(AInstantBuffer).RecordNumber := -1;
    end;}
    BufferToRecBuf(AInstantBuffer).RecView := TreeNode;
    BufferToRecBuf(AInstantBuffer).MemRec := Rec;
//    BufferToRecBuf(AInstantBuffer).RecordsView := FRecordsView;
    Result := BufferToRecBuf(AInstantBuffer);
  finally
    FreeRecordBuffer(AInstantBuffer);
  end;
end;

function TCustomMemTableEh.IMemTableSetTreeNodeExpanded(RowNum: Integer; Value: Boolean): Integer;
var
  RecBuf: TRecBuf;
  TreeNode, ActiveTreeNode: TMemRecViewEh;
//  ARecNo: Integer;
  FindedRecPos: Integer;
  ActiveHided: Boolean;
//  OldBookmark: TBookmarkStr;
  AllowExpansion: Boolean;
begin
  CheckActive;
  Result := -1;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil)
    then ActiveTreeNode := RecBuf.RecView
    else ActiveTreeNode := nil;
  InstantReadEnter(RowNum);
  try
    if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    begin
      TreeNode := RecBuf.RecView;
//      ARecNo := RecBuf.RecordNumber+1;
    end else
      Exit;
  finally
    InstantReadLeave;
  end;

  AllowExpansion := True;

//  if not TreeNode.Expanded and Value and Assigned(OnTreeNodeExpanding) then
//    OnTreeNodeExpanding(Self, ARecNo, AllowExpansion);

  if AllowExpansion
    then TreeNode.NodeExpanded := Value
    else Exit;

  RecordsView.MemoryTreeList.BuildVisibleItems;
  ActiveHided := False;
  if ActiveTreeNode <> nil then
    while (FRecordsView.IndexOf(ActiveTreeNode.Rec) = -1) and (ActiveTreeNode.NodeLevel > 1) do
    begin
      ActiveTreeNode := TMemRecViewEh(ActiveTreeNode.NodeParent);
      ActiveHided := True;
    end;
  if ActiveHided then
  begin
    FindedRecPos := FRecordsView.IndexOf(ActiveTreeNode.Rec);
    if FindedRecPos <> -1 then
      Result := FindedRecPos + 1;
  end;
  Resync([]);
end;

function TCustomMemTableEh.IMemTableGetTreeNodeExpanded(RowNum: Integer): Boolean;
begin
  { TODO : To do }
  Result := False;
end;

procedure TCustomMemTableEh.SetTreeNodeHasChildren(const Value: Boolean);
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  if GetActiveRecBuf(RecBuf) then //??? Logicaly deen to set IsForWrite = True 
    if (RecBuf.RecView <> nil) then
    begin
      RecBuf.RecView.NodeHasChildren := Value;
      Resync([]);
    end else
      RecBuf.NewTreeNodeHasChildren := Value;
end;

function TCustomMemTableEh.GetTreeNodeHasChildren: Boolean;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  Result := False;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView.NodeHasChildren;
end;

function TCustomMemTableEh.GetTreeNodeExpanded: Boolean;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  Result := False;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView.NodeExpanded;
end;

procedure TCustomMemTableEh.SetTreeNodeExpanded(const Value: Boolean);
var
  RecBuf: TRecBuf;
  AllowExpansion: Boolean;
  TreeNode: TMemRecViewEh;
begin
  CheckActive;
  if GetActiveRecBuf(RecBuf) then //??? Logicaly need to set IsForWrite = True
    if (RecBuf.RecView <> nil) then
    begin
      TreeNode := RecBuf.RecView;
      AllowExpansion := True;
      if not TreeNode.NodeExpanded and Value and Assigned(OnTreeNodeExpanding) then
        OnTreeNodeExpanding(Self, RecBuf.RecordNumber+1, AllowExpansion);
      if AllowExpansion then
        RecBuf.RecView.NodeExpanded := Value;
      Resync([]);
    end else
      RecBuf.NewTreeNodeExpanded := Value;
end;

function TCustomMemTableEh.TreeViewNodeExpanding(Sender: TBaseTreeNodeEh): Boolean;
var
  RecBuf: TRecBuf;
  ActiveTreeNode: TMemRecViewEh;
//  AllowExpansion: Boolean;
  ARecNo: Integer;
  MemSender: TMemRecViewEh;
begin
  MemSender := TMemRecViewEh(Sender);
  Result := True;
  if not MemSender.NodeExpanded and Assigned(OnRecordsViewTreeNodeExpanding) then
    OnRecordsViewTreeNodeExpanding(Self, MemSender, Result);
  if Active and not MemSender.NodeExpanded and Assigned(OnTreeNodeExpanding) then
  begin
    if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil)
      then ActiveTreeNode := RecBuf.RecView
      else ActiveTreeNode := nil;
    if Sender = ActiveTreeNode then
      OnTreeNodeExpanding(Self, RecBuf.RecordNumber + 1, Result)
    else
    begin
      ARecNo := FRecordsView.MemoryTreeList.VisibleItems.IndexOf(MemSender);
      InstantReadEnter(ARecNo);
      try
        OnTreeNodeExpanding(Self, RecBuf.RecordNumber + 1, Result);
      finally
        InstantReadLeave;
      end;
      {RecBuf := SetTempRecBufForRecord(MemSender.Data, MemSender, ARecNo);
      OnTreeNodeExpanding(Self, RecBuf.RecordNumber + 1, Result);
      ReleaseTempRecBuf;}
    end;
  end;
end;

procedure TCustomMemTableEh.TreeViewNodeExpanded(Sender: TBaseTreeNodeEh);
begin
  if Active then
  begin
{ TODO : This code is hold up }
    if ControlsDisabled then Exit;
    RecordsView.MemoryTreeList.BuildVisibleItems;
    Resync([]);
  end;
end;

function TCustomMemTableEh.CompareTreeNodes(Rec1, Rec2: TBaseTreeNodeEh; ParamSort: TObject): Integer;
begin
  Result := CompareRecords(TMemRecViewEh(Rec1).Rec, TMemRecViewEh(Rec2).Rec, ParamSort);
end;

function TCustomMemTableEh.GetTreeNodeChildCount: Integer;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  Result := -1;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView.VisibleNodesCount;
end;

function TCustomMemTableEh.GetTreeNode: TMemRecViewEh;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  Result := nil;
  if GetActiveRecBuf(RecBuf) and (RecBuf.RecView <> nil) then
    Result := RecBuf.RecView;
end;

function TCustomMemTableEh.GetIndexDefs: TIndexDefs;
begin
  if FIndexDefs = nil then
    FIndexDefs := TIndexDefs.Create(Self);
  Result := FIndexDefs;
end;

procedure TCustomMemTableEh.SetIndexDefs(Value: TIndexDefs);
begin
  IndexDefs.Assign(Value);
end;

procedure TCustomMemTableEh.UpdateIndexDefs;
begin
  if (csDesigning in ComponentState) and (IndexDefs.Count > 0) then Exit;
  if Active and not IndexDefs.Updated then
  begin
    FieldDefs.Update;
    IndexDefs.Clear;
    IndexDefs.Updated := True;
  end;
end;

procedure TCustomMemTableEh.UpdateSortOrder;
begin
  if Active
    then FRecordsView.SortOrder := FSortOrder
    else FRecordsView.SortOrder := '';
end;

function TCustomMemTableEh.PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs;
begin
  Result := inherited GetIndexDefs(IndexDefs, IndexTypes);
end;

function TCustomMemTableEh.GetSortOrder: String;
begin
  Result := FSortOrder;
end;

procedure TCustomMemTableEh.SetSortOrder(const Value: String);
begin
  if FSortOrder <> Value then
  begin
    FSortOrder := Value;
    UpdateSortOrder;
  end;
end;

// FieldName [ASC|DESC] [,|;] ...

procedure TCustomMemTableEh.SortByFields(const SortByStr: string);
begin
  DoOrderBy(SortByStr);
end;

function TCustomMemTableEh.ParseOrderByStr(OrderByStr: String): TObject;
var
  FieldName, Token: String;
//  Exp: PChar;
  FromIndex: Integer;
  Desc: Boolean;
  OByItem: TOrderByItemEh;
  Field: TField;
begin
  Result := TMTOrderByList.Create;
  try
//    Exp := PChar(OrderByStr);
    FromIndex := 1;
    FieldName := TOrderByList(Result).GetToken(OrderByStr, FromIndex);
    if FieldName = '' then Exit;
    Field := FindField(FieldName);
    if Field = nil then
      raise Exception.Create(' Field - "' + FieldName + '" not found.');
    Desc := False;
    while True do
    begin
      Token := TOrderByList(Result).GetToken(OrderByStr, FromIndex);
      if AnsiUpperCase(Token) = 'ASC' then
        Continue
      else if AnsiUpperCase(Token) = 'DESC' then
      begin
        Desc := True;
        Continue
      end else if (Token = ';') or (Token = ',') or (Token = '') then

      else
        raise Exception.Create(' Invalid token - "' + Token + '"');

      OByItem := TOrderByItemEh.Create;
//      OByItem.Field := Field;
      OByItem.FieldIndex := Field.Index;
      OByItem.Desc := Desc;
      TOrderByList(Result).Add(OByItem);

      FieldName := TOrderByList(Result).GetToken(OrderByStr, FromIndex);
      if FieldName = '' then Break;
      Field := FindField(FieldName);
      if Field = nil then
        raise Exception.Create(' Field - "' + FieldName + '" not found.');
      Desc := False;
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TCustomMemTableEh.DoOrderBy(const OrderByStr: String);
var
  FOrderByList: TObject;
begin
  FOrderByList := ParseOrderByStr(OrderByStr);
  try
    SortData(FOrderByList);
  finally
    FOrderByList.Free;
  end;
end;

procedure TCustomMemTableEh.SortData(ParamSort: TObject);
begin
  if Active and (FRecordsView <> nil) and (FRecordsView.ViewItemsCount > 0) {and (OrderByList.Count > 0)} then
  begin
    CheckBrowseMode;
    if FInstantReadMode then
      raise Exception.Create('Sort data in InstantReadMode is not allowed.');
//    Pos := Bookmark;
    try
      if FRecordsView.ViewAsTreeList
        then FRecordsView.MemoryTreeList.SortData(CompareTreeNodes, ParamSort, True)
        else FRecordsView.MemTableData.RecordsList.SortData(CompareRecords, ParamSort);
      SetBufListSize(0);
      InitBufferPointers(False);
      try
        SetBufListSize(BufferCount + 1);
      except
        SetState(dsInactive);
        CloseCursor;
        raise;
      end;
    finally
//      Bookmark := Pos;
    end;
    Resync([]);
  end;
end;

function TCustomMemTableEh.CompareRecords(Rec1, Rec2: TMemoryRecordEh; ParamSort: TObject): Integer;
var
  AOrderByList: TOrderByList;
{$IFDEF CIL}
//  AInstantBuffer: TRecordBuffer;
{$ELSE}
//  AInstantBuffer: PChar;
{$ENDIF}

  function GetFieldValues(Rec: TMemoryRecordEh): Variant;
  var
    I: Integer;
    UseRecordBuffer: Boolean;
    Field: TField;
  begin
    UseRecordBuffer := False;
    for I := 0 to AOrderByList.Count-1 do
    begin
      if AOrderByList is TMTOrderByList then
      begin
        Field := Fields[AOrderByList[I].FieldIndex];
       if Field.FieldNo <= 0 then
        begin
          UseRecordBuffer := True;
          Break;
        end;
      end;  
    end;

    if UseRecordBuffer then
    begin
//      AInstantBuffer := AllocRecordBuffer;
      try
//        InstantReadEnter(RecordsView.IndexOf(Rec));
        InstantReadEnter(Rec, -1);
//        RecordToBuffer(Rec, dvvValueEh, AInstantBuffer);
//      FInstantReadMode := True;
        if AOrderByList.Count > 1 then
        begin
          Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
          for I := 0 to AOrderByList.Count - 1 do
            Result[I] := Fields[AOrderByList[I].FieldIndex].Value;
        end else
          Result := Fields[AOrderByList[0].FieldIndex].Value
      finally
//        FInstantReadMode := False;
//        FreeRecordBuffer(AInstantBuffer);
        InstantReadLeave;
      end;
    end else
    begin
      if AOrderByList.Count > 1 then
      begin
        Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
        for I := 0 to AOrderByList.Count - 1 do
          if AOrderByList is TMTOrderByList then
            Result[I] := Rec.Value[Fields[AOrderByList[I].FieldIndex].FieldNo-1, dvvValueEh]
          else
            Result[I] := Rec.Value[AOrderByList[I].FieldIndex, dvvValueEh]
      end else
        if AOrderByList is TMTOrderByList then
          Result := Rec.Value[Fields[AOrderByList[0].FieldIndex].FieldNo-1, dvvValueEh]
        else
          Result := Rec.Value[AOrderByList[0].FieldIndex, dvvValueEh]
    end;
  end;

  function CompareSimpleSortVarValues(Data1, Data2: Variant; CaseInsensitive: Boolean): Integer;
  begin
    if VarIsEmpty(Data1) or VarIsNull(Data1) then
      if VarIsEmpty(Data2) or VarIsNull(Data2) then
        Result := 0
      else
        Result := -1
    else
      if VarIsEmpty(Data2) or VarIsNull(Data2) then
        Result := 1
      else if (not CaseInsensitive and (Data1 = Data2)) or
              (    CaseInsensitive and (AnsiCompareText(Data1, Data2) = 0)) then
        Result := 0
      else if (not CaseInsensitive and (Data1 < Data2)) or
              (    CaseInsensitive and (AnsiCompareText(Data1, Data2) < 0)) then
        Result := -1
      else
        Result := 1;
  end;

  function CompareSortItem(Data1, Data2: Variant; OrderByItem: TOrderByItemEh): Integer;
  var
    CaseInsensitive: Boolean;
  begin
    if AOrderByList is TMTOrderByList then
      CaseInsensitive := OrderByItem.CaseIns and
        (Fields[OrderByItem.FieldIndex].DataType in
          [ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraClob])
    else
      CaseInsensitive := OrderByItem.CaseIns and
        (Rec1.DataStruct[OrderByItem.FieldIndex].DataType in
          [ftString, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraClob]);
    Result := CompareSimpleSortVarValues(Data1, Data2, CaseInsensitive);
    if OrderByItem.Desc then
      if Result = -1 then Result := 1
      else if Result = 1 then Result := -1;
  end;

var
  Data1, Data2: Variant;
  I: Integer;
begin
  Result := 0;
//  AOrderByList := TOrderByList(FOrderByList);
  AOrderByList := TOrderByList(ParamSort);
  if (AOrderByList <> nil) and (AOrderByList.Count > 0) then
  begin
    Data1 := GetFieldValues(Rec1);
    Data2 := GetFieldValues(Rec2);

    if AOrderByList.Count > 1 then
    begin
      for I := 0 to AOrderByList.Count - 1 do
      begin
        Result := CompareSortItem(Data1[I], Data2[I], AOrderByList[I]);
        if Result <> 0 then
          Exit;
      end;
    end else
      Result := CompareSortItem(Data1, Data2, AOrderByList[0]);
  end;
end;

function TCustomMemTableEh.GetDataFieldsCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to FieldCount-1 do
    if Fields[i].FieldNo > 0 then
      Inc(Result);

//  Result := FieldDefs.Count;
end;

procedure TCustomMemTableEh.InstantReadEnter(RecView: TMemRecViewEh; RowNum: Integer);
begin
  FInstantBuffers.Add(TObject(AllocRecordBuffer));
  FInstantReadMode := True;

  RecordToBuffer(RecView.Rec, dvvValueEh, InstantBuffer, RowNum);
  BufferToRecBuf(InstantBuffer).RecView := RecView;
  BufferToRecBuf(InstantBuffer).RecordNumber := RowNum;
  BufferToRecBuf(InstantBuffer).MemRec := RecView.Rec;
end;

procedure TCustomMemTableEh.InstantReadEnter(MemRec: TMemoryRecordEh; RowNum: Integer);
begin
  FInstantBuffers.Add(TObject(AllocRecordBuffer));
  FInstantReadMode := True;

  RecordToBuffer(MemRec, dvvValueEh, InstantBuffer, RowNum);
  BufferToRecBuf(InstantBuffer).RecView := nil;
  BufferToRecBuf(InstantBuffer).RecordNumber := RowNum;
  BufferToRecBuf(InstantBuffer).MemRec := MemRec;
end;

procedure TCustomMemTableEh.InstantReadEnter(RowNum: Integer);
begin
  FInstantBuffers.Add(TObject(AllocRecordBuffer));

  FInstantReadMode := True;
  if (State in [dsEdit, dsInsert]) and (RowNum = FInstantReadCurRowNum) then
  begin
    CopyBuffer(ActiveBuffer, InstantBuffer);
    if State = dsInsert then
    begin
      BufferToRecBuf(InstantBuffer).RecordNumber := -1;
      BufferToRecBuf(InstantBuffer).RecView := nil;
      BufferToRecBuf(InstantBuffer).MemRec := nil;
    end;
  end else if FRecordsView.ViewItemsCount = 0 then
  begin
    InternalInitRecord(InstantBuffer);
  end else
  begin
    if (State = dsInsert) and (RowNum > FInstantReadCurRowNum) then
      Dec(RowNum);
    if BufferToRecBuf(InstantBuffer).RecordNumber <> RowNum then
    begin
      RecordToBuffer(FRecordsView.ViewRecord[RowNum], dvvValueEh, InstantBuffer, RowNum);
//      BufferToRecBuf(InstantBuffer).Bookmark := RowNum+1;// FRecordsView.ViewRecord[RowNum].ID;
      if FRecordsView.ViewAsTreeList
        then BufferToRecBuf(InstantBuffer).RecView := TMemRecViewEh(FRecordsView.MemoryTreeList.VisibleItems[RowNum])
        else BufferToRecBuf(InstantBuffer).RecView := nil;
      BufferToRecBuf(InstantBuffer).RecordNumber := RowNum;
      BufferToRecBuf(InstantBuffer).MemRec := FRecordsView.ViewRecord[RowNum];
    end;
  end;
end;

procedure TCustomMemTableEh.InstantReadLeave;
var
{$IFDEF CIL}
  Buffer: TRecordBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
  Buffer: TRecordBuffer;
{$ELSE}
  Buffer: PChar;
{$ENDIF}
{$ENDIF}
begin
  if FInstantBuffers.Count = 0 then
    raise Exception.Create('TCustomMemTableEh not in instant read mode.');
{$IFDEF CIL}
  Buffer := TRecordBuffer(FInstantBuffers[FInstantBuffers.Count-1]);
{$ELSE}
{$IFDEF EH_LIB_12}
  Buffer := TRecordBuffer(FInstantBuffers[FInstantBuffers.Count-1]);
{$ELSE}
  Buffer := PChar(FInstantBuffers[FInstantBuffers.Count-1]);
{$ENDIF}
{$ENDIF}
  FreeRecordBuffer(Buffer);
  FInstantBuffers.Delete(FInstantBuffers.Count-1);
  FInstantReadMode := (FInstantBuffers.Count > 0);
end;

{$IFDEF CIL}
function TCustomMemTableEh.GetInstantBuffer: TRecordBuffer;
{$ELSE}
{$IFDEF EH_LIB_12}
function TCustomMemTableEh.GetInstantBuffer: TRecordBuffer;
{$ELSE}
function TCustomMemTableEh.GetInstantBuffer: PChar;
{$ENDIF}
{$ENDIF}
begin
  Result := nil;
  if FInstantBuffers.Count > 0 then
{$IFDEF CIL}
    Result := TRecordBuffer(FInstantBuffers[FInstantBuffers.Count-1]);
{$ELSE}
{$IFDEF EH_LIB_12}
    Result := TRecordBuffer(FInstantBuffers[FInstantBuffers.Count-1]);
{$ELSE}
    Result := PChar(FInstantBuffers[FInstantBuffers.Count-1]);
{$ENDIF}
{$ENDIF}
end;

procedure TCustomMemTableEh.InternalInsert;
begin
  if GetBookmarkFlag(ActiveBuffer) = bfEOF then
    FInstantReadCurRowNum := FRecordsView.ViewItemsCount;
end;

function TCustomMemTableEh.GetInstantReadCurRowNum: Integer;
begin
  UpdateCursorPos;
  Result := FInstantReadCurRowNum;
end;

function TCustomMemTableEh.InstantReadRowCount: Integer;
begin
  UpdateCursorPos;
  Result := RecordCount;
  if State = dsInsert then
    Inc(Result);
end;

function TCustomMemTableEh.GetRec: TMemoryRecordEh;
var
  RecBuf: TRecBuf;
begin
  CheckActive;
  Result := nil;
  if not GetActiveRecBuf(RecBuf)
    then Exit
    else Result := RecBuf.MemRec;
end;

function TCustomMemTableEh.GetRecObject: TObject;
begin
  Result := GetRec;
end;

function TCustomMemTableEh.GotoRec(Rec: TMemoryRecordEh): Boolean;
begin
  Result := SetToRec(Rec);
end;

function TCustomMemTableEh.SetToRec(Rec: TObject): Boolean;
var
  i: Integer;
begin
  CheckActive;
  Result := False;
  for i := 0 to RecordsView.ViewItemsCount-1 do
    if RecordsView.ViewRecord[i] = Rec then
    begin
      RecNo := i+1;
      Result := True;
      Exit;
    end;
end;

{procedure TCustomMemTableEh.SetKeyFields(const Value: String);
begin
  FRecordsView.MemTableData.RecordsList.KeyIndex.Fields := Value;
end;

function TCustomMemTableEh.GetKeyFields: String;
begin
  Result := FRecordsView.MemTableData.RecordsList.KeyIndex.Fields;
end;}

function TCustomMemTableEh.DoFetchRecords(Count: Integer): Integer;
var
  NeedRecordCount: Longint;
begin
  Result := 0;

  if DataDriver <> nil then
  begin
      NeedRecordCount := FRecordsView.ViewItemsCount + Count;
      Result := DataDriver.ReadData(RecordsView.MemTableData, Count);
      if (FRecordsView.ViewItemsCount < NeedRecordCount) and not DataDriver.ProviderEOF then
        // Some record excluded in filter
        while not DataDriver.ProviderEOF and (FRecordsView.ViewItemsCount < NeedRecordCount) do
          Result := Result + DataDriver.ReadData(RecordsView.MemTableData, 1);
    Exit;
  end;
end;

function TCustomMemTableEh.FetchRecords(Count: Integer): Integer;
begin
  Result := 0;
  if not Active then Exit;
  BeginRecordsViewUpdate;
  try
    Result := RecordsView.MemTableData.FetchRecords(Count);
  finally
    EndRecordsViewUpdate(True);
  end;
//  if (FRecordsViewUpdating = 0) and (Result > 0) then
//    Resync([]);
end;

procedure TCustomMemTableEh.SetDetailFields(const Value: String);
begin
  FDetailFields := Value;
  UpdateDetailMode(True);
end;

procedure TCustomMemTableEh.SetMasterFields(const Value: String);
begin
  FMasterDataLink.FieldNames := Value;
  UpdateDetailMode(True);
end;

function TCustomMemTableEh.GetMasterFields: String;
begin
  Result := FMasterDataLink.FieldNames;
end;

procedure TCustomMemTableEh.SetMasterSource(const Value: TDataSource);
begin
  FMasterDataLink.DataSource := Value;
  UpdateDetailMode(True);
end;

function TCustomMemTableEh.GetMasterSource: TDataSource;
begin
  Result := FMasterDataLink.DataSource;
end;

function TCustomMemTableEh.InternalApplyUpdates(AMemTableData: TMemTableDataEh; MaxErrors: Integer): Integer;
begin
  Result := 0;
  if DataDriver <> nil then
  begin
    Result := DataDriver.ApplyUpdates(AMemTableData);
//    FRecordsView.MergeChangeLog;
  end else
    FRecordsView.MergeChangeLog;
end;

function TCustomMemTableEh.ApplyUpdates(MaxErrors: Integer): Integer;
begin
  CheckActive;
  Result := InternalApplyUpdates(FRecordsView.MemTableData, MaxErrors);
  UpdateCursorPos;
  Resync([]);
end;

{
function TCustomMemTableEh.ApplyUpdate(OldRecValues,
  NewRecValues: PRecValues; UpdateKind: TUpdateKind;
  TargetDataSet: TDataSet; OutRecValues: PRecValues): Integer;
var
  DeltaDataSet: TCustomMemTableEh;
  j: Integer;
begin
  Result := 0;
  DeltaDataSet := CreateDeltaDataSet;
  try
    DeltaDataSet.Edit;
    for j := 0 to DeltaDataSet.FieldCount-1 do
        case UpdateKind of
        ukInsert: DeltaDataSet.Fields[j].Value := NewRecValues^[j];
        ukModify: DeltaDataSet.Fields[j].Value := OldRecValues^[j];
        ukDelete: DeltaDataSet.Fields[j].Value := NewRecValues^[j];
      end;

    DeltaDataSet.Post;
    if UpdateKind in [ukModify, ukDelete]  then
    begin
      DeltaDataSet.MergeChangeLog;
      DeltaDataSet.Edit;
      for j := 0 to DeltaDataSet.FieldCount-1 do
        DeltaDataSet.Fields[j].Value := NewRecValues^[j];
      DeltaDataSet.Post;
    end;

    Result := Result +
      UpdateRecord(DeltaDataSet, UpdateKind, OutRecValues <> nil);

    if OutRecValues <> nil then
      for j := 0 to DeltaDataSet.FieldCount-1 do
        OutRecValues^[j] := DeltaDataSet.Fields[j].Value;

    DeltaDataSet.ClearRecords;
  finally
    DeltaDataSet.Free;
  end;
end;
}
(*
function TCustomMemTableEh.UpdateRecord(DeltaDataSet: TDataSet; UpdateKind: TUpdateKind; RefreshRecord: Boolean): Integer;
var
  UpdateAction: TMTUpdateActionEh;
begin
  Result := 1;
  while True do
  begin
    UpdateAction := uaApplyEh;
    if Assigned(OnUpdateRecord) then
      OnUpdateRecord(DeltaDataSet, UpdateKind, UpdateAction);
    if UpdateAction <> uaRetryEh then Break;
  end;

  if UpdateAction in [uaAbortEh, uaSkipEh, uaAppliedEh] then Exit; { TODO : Support uaAbort in CachedUpdates mode }
  if UpdateAction = uaFailEh then
    DatabaseError('UpdateRecord is Fail');
//tmp  Result := DefaultUpdateRecord(DeltaDataSet, UpdateKind, RefreshRecord);
end;
*)

procedure TCustomMemTableEh.MergeChangeLog;
begin
  FRecordsView.MergeChangeLog;
end;

function TCustomMemTableEh.GetCachedUpdates: Boolean;
begin
  Result := FRecordsView.MemTableData.RecordsList.CachedUpdates;
//  Result := FCachedUpdates;
//  Result := FRecordsView.CachedUpdates;
end;

procedure TCustomMemTableEh.SetCachedUpdates(const Value: Boolean);
begin
  FRecordsView.MemTableData.RecordsList.CachedUpdates := Value;
//  FCachedUpdates := Value;
//  FRecordsView.CachedUpdates := Value;
end;

procedure TCustomMemTableEh.DefChanged(Sender: TObject);
begin
  FStoreDefs := True;
end;

function TCustomMemTableEh.GetFieldValueList(AFieldName: String): IMemTableDataFieldValueListEh;
var
  mtfv: TMemTableDataFieldValueListEh;
  dsfv:  TDatasetFieldValueListEh;
  Field: TField;
begin
  Field := FindField(AFieldName);
  if Field = nil then Exit;
  if Field.FieldKind = fkLookup then
  begin
    dsfv := TDatasetFieldValueListEh.Create;
    dsfv.FieldName := Field.LookupResultField;
    dsfv.DataSet := Field.LookupDataSet;
    Result := dsfv;
  end else
  begin
    mtfv := TMemTableDataFieldValueListEh.Create;
    mtfv.FieldName := AFieldName;
//    mtfv.RecordsList := RecordsView.MemTableData.RecordsList;
//    mtfv.MemTableData := RecordsView.MemTableData;
    mtfv.DataObject := RecordsView.MemTableData;
//    mtfv.DataObject := RecordsView;
    Result := mtfv;
  end;
end;

procedure TCustomMemTableEh.SetExternalMemData(Value: TCustomMemTableEh);
var
  WasActive: Boolean;
begin
  if FExternalMemData <> Value then
  begin
    if Value = Self then
      raise Exception.Create('Circular datalinks are not allowed');
    if (Value <> nil) and (DataDriver <> nil) then
      raise Exception.Create('Assigning to ExternalMemData is not allowed if DataDriver is assigned');
    WasActive := Active;
    if not (csLoading in ComponentState) then
      Close;
    if Value = nil then
      FRecordsView.MemTableData := FInternMemTableData
    else
    begin
      FRecordsView.MemTableData := Value.FInternMemTableData;
      Value.FreeNotification(Self);
    end;
    FExternalMemData := Value;
    if WasActive then
      Open;
  end;
end;

procedure TCustomMemTableEh.BeginRecordsViewUpdate;
begin
  Inc(FRecordsViewUpdating);
end;

procedure TCustomMemTableEh.EndRecordsViewUpdate(AutoResync: Boolean);
begin
  if FRecordsViewUpdating > 0 then
    Dec(FRecordsViewUpdating);
  if AutoResync and (FRecordsViewUpdating = 0) and FRecordsViewUpdated then
  begin
    FRecordsViewUpdated := False;
    Resync([]);
  end;
end;

function TCustomMemTableEh.MoveRecord(FromIndex, ToIndex: Longint;
  TreeLevel: Integer; CheckOnly: Boolean): Boolean;
var
  {ToMemRec, }CurRec, FromRec : TMemoryRecordEh;
  FromNode, PrevNode, NextNode: TMemRecViewEh;
  RefParentValue: Variant;
  NewPos: Integer;

  function InsertAfter(FromNode, AfterNode: TMemRecViewEh): Boolean;
  var
    IndexInParentNode: Integer;
  begin
    Result := True;
    RefParentValue := AfterNode.Rec.DataValues[TreeList.RefParentFieldName, dvvValueEh];
    if AfterNode.Rec.Index > FromNode.Rec.Index
      then IndexInParentNode := AfterNode.Rec.Index
      else IndexInParentNode := AfterNode.Rec.Index + 1;

    if Assigned(FOnRecordsViewCheckMoveNode) then
      Result := FOnRecordsViewCheckMoveNode(Self, FromNode, AfterNode.NodeParent, IndexInParentNode);
    if not Result then Exit;

    if CheckOnly then
      Result := not RecordsView.MemoryTreeList.CheckReferenceLoop(FromNode.Rec, RefParentValue)
    else
    begin
      FromRec := FromNode.Rec;
      FromRec.Edit;
      FromRec.DataValues[TreeList.RefParentFieldName, dvvValueEh] := RefParentValue;
      FromRec.Post;

      if AfterNode.Rec.Index > FromNode.Rec.Index
        then RecordsView.MemTableData.RecordsList.Move(FromRec.Index, AfterNode.Rec.Index)
        else RecordsView.MemTableData.RecordsList.Move(FromRec.Index, AfterNode.Rec.Index+1);
    end;
  end;

  function InsertBefore(FromNode, BeforeNode: TMemRecViewEh): Boolean;
  var
    IndexInParentNode: Integer;
  begin
    RefParentValue := BeforeNode.Rec.DataValues[TreeList.RefParentFieldName, dvvValueEh];
    Result := True;

    if BeforeNode.Rec.Index > FromNode.Rec.Index
      then IndexInParentNode := BeforeNode.Rec.Index - 1
      else IndexInParentNode := BeforeNode.Rec.Index;

    if Assigned(FOnRecordsViewCheckMoveNode) then
      Result := FOnRecordsViewCheckMoveNode(Self, FromNode, BeforeNode.NodeParent, IndexInParentNode);
    if not Result then Exit;

    if CheckOnly then
      Result := not RecordsView.MemoryTreeList.CheckReferenceLoop(FromNode.Rec, RefParentValue)
    else
    begin
      FromRec := FromNode.Rec;
      FromRec.Edit;
      FromRec.DataValues[TreeList.RefParentFieldName, dvvValueEh] := RefParentValue;
      FromRec.Post;

      if BeforeNode.Rec.Index > FromNode.Rec.Index
        then RecordsView.MemTableData.RecordsList.Move(FromRec.Index, BeforeNode.Rec.Index-1)
        else RecordsView.MemTableData.RecordsList.Move(FromRec.Index, BeforeNode.Rec.Index);
    end;
  end;

  function InsertChild(FromNode, ParentNode: TMemRecViewEh): Boolean;
  begin
    Result := True;
    RefParentValue := ParentNode.Rec.DataValues[TreeList.KeyFieldName, dvvValueEh];

    if Assigned(FOnRecordsViewCheckMoveNode) then
      Result := FOnRecordsViewCheckMoveNode(Self, FromNode, ParentNode, 0);
    if not Result then Exit;

    if CheckOnly then
      Result := not RecordsView.MemoryTreeList.CheckReferenceLoop(FromNode.Rec, RefParentValue)
    else
    begin
      FromRec := FromNode.Rec;
      FromRec.Edit;
      FromRec.DataValues[TreeList.RefParentFieldName, dvvValueEh] := RefParentValue;
      FromRec.Post;
    end;
  end;
begin
  Result := True;
  if not Active or (FromIndex > FRecordsView.ViewItemsCount) or
    (ToIndex > FRecordsView.ViewItemsCount)
  then
    Exit;
  if TreeList.Active then
  begin
    if not CheckOnly then
      BeginRecordsViewUpdate;
    try
      CurRec := TMemoryRecordEh(GetRec);
      FromNode := RecordsView.MemoryTreeList[FromIndex];
      FromRec := RecordsView.MemoryTreeList[FromIndex].Rec;
      if FromIndex < ToIndex then
      begin
        PrevNode := RecordsView.MemoryTreeList[ToIndex];
        if ToIndex+1 < RecordsView.ViewItemsCount-1
          then NextNode := RecordsView.MemoryTreeList[ToIndex+1]
          else NextNode := nil;
      end else
      begin
        if ToIndex > 0
          then PrevNode := RecordsView.MemoryTreeList[ToIndex-1]
          else PrevNode := nil;
        NextNode := RecordsView.MemoryTreeList[ToIndex];
      end;

      if (PrevNode <> nil) and (TreeLevel = PrevNode.NodeLevel) then
        Result := Result and InsertAfter(FromNode, PrevNode)
      else if (NextNode <> nil) and (TreeLevel = NextNode.NodeLevel) then
        Result := Result and InsertBefore(FromNode, NextNode)
      else if (PrevNode <> nil) and (TreeLevel > PrevNode.NodeLevel) then
        Result := Result and InsertChild(FromNode, PrevNode)
      else if (PrevNode <> nil) and (TreeLevel < PrevNode.NodeLevel) then
      begin
        while PrevNode.NodeLevel > TreeLevel do
        begin
          if PrevNode.NodeParent = PrevNode.NodeOwner.Root then
            Exit;
          PrevNode := PrevNode.NodeParent;
        end;
        Result := Result and InsertAfter(FromNode, PrevNode);
      end;

      if CheckOnly then
        Exit;
      NewPos := FRecordsView.IndexOf(CurRec);
      if NewPos > -1 then
        FRecordPos := NewPos;

    finally
      EndRecordsViewUpdate(True);
    end;
//    Resync([]);
  end else
  begin
    CurRec := TMemoryRecordEh(GetRec);
    if CheckOnly then
      Exit;
    RecordsView.MemTableData.RecordsList.Move(
      RecordsView.ViewRecord[FromIndex].Index,
      RecordsView.ViewRecord[ToIndex].Index);
    NewPos := FRecordsView.IndexOf(CurRec);
    if NewPos > -1 then
      FRecordPos := NewPos;
    Resync([]);
    { TODO : Resync to RecordList to event and back to MemTable }
  end;
end;

//var
//  FDataSet: TDataSet;

function CompareBookmarkStr(List: TBMListEh; ADataSet: TDataSet; Index1, Index2: Integer): Integer;
begin
  Result := DataSetCompareBookmarks(ADataSet, List[Index1], List[Index2]);
end;

function TCustomMemTableEh.MoveRecords(BookmarkList: TBMListEh; ToRecNo: Longint;
  TreeLevel: Integer; CheckOnly: Boolean): Boolean;
var
  i, RecIndex: Integer;
  RecList: TObjectList;
  ToIndex: Integer;
begin
  ToIndex := ToRecNo - 1;
  Result := True;
  RecList := TObjectList.Create(False);
  try
    for i := 0 to BookmarkList.Count-1 do
    begin
{$IFDEF EH_LIB_12}
      RecIndex := BookmarkToRecNo(BookmarkList[i]) - 1;
{$ELSE}
      RecIndex := BookmarkStrToRecNo(BookmarkList[i]) - 1;
{$ENDIF}
      RecList.Add(RecordsView.ViewRecord[RecIndex]);
    end;

//    MoveRecord(RecordsView.IndexOf(TMemoryRecordEh(RecList[0])), ToIndex, TreeLevel);
    if not CheckOnly then
      BeginRecordsViewUpdate;
    try
      for i := RecList.Count-1 downto 0 do
      begin
        RecIndex := RecordsView.IndexOf(TMemoryRecordEh(RecList[i]));
        if (i < RecList.Count-1) and (RecIndex < ToIndex) then
          Dec(ToIndex);
        Result := Result and MoveRecord(RecIndex, ToIndex, TreeLevel, CheckOnly);
      end;
      if CheckOnly then
        Exit;
      for i := RecList.Count-1 downto 0 do
      begin
        RecIndex := RecordsView.IndexOf(TMemoryRecordEh(RecList[i]));
{$IFDEF EH_LIB_12}
        BookmarkList[i] := RecNoToBookmark(RecIndex+1);
{$ELSE}
        BookmarkList[i] := RecNoToBookmarkStr(RecIndex+1);
{$ENDIF}
      end;
//      FDataSet := Self;
      BookmarkList.CustomSort(Self, @CompareBookmarkStr);
//      FDataSet := nil;
    finally
      if not CheckOnly then
        EndRecordsViewUpdate(True);
    end;
//    Resync([]);

  finally
    RecList.Free;
  end;
end;

function TCustomMemTableEh.GetDataSource: TDataSource;
begin
  Result := FMasterDataLink.DataSource;
end;

function TCustomMemTableEh.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
  if FieldType = ftUnknown
    then Result := TRefObjectField
    else Result := inherited GetFieldClass(FieldType);
end;

procedure TCustomMemTableEh.DriverStructChanged;
begin
  DataEvent(dePropertyChange, {$IFDEF CIL}nil{$ELSE}0{$ENDIF});
end;

procedure TCustomMemTableEh.RegisterEventReceiver(AComponent: TComponent);
begin
  if FEventReceivers.IndexOf(AComponent) < 0 then
  begin
    FEventReceivers.Add(AComponent);
    AComponent.FreeNotification(Self);
  end;
end;

procedure TCustomMemTableEh.UnregisterEventReceiver(AComponent: TComponent);
begin
  FEventReceivers.Remove(AComponent);
end;

procedure TCustomMemTableEh.MTViewDataEvent(RowNum: Integer;
  Event: TMTViewEventTypeEh; OldRowNum: Integer);
var
  i: Integer;
  IntEventReceiver: IMTEventReceiverEh;
begin
  if Active then
  begin
    if ControlsDisabled then
    begin
      if FMTViewDataEventInactiveCount < 2 then
        Inc(FMTViewDataEventInactiveCount);
      if FMTViewDataEventInactiveCount = 1 then
      begin
        FInactiveEventRowNum := RowNum;
        FInactiveEvent := Event;
        FInactiveEventOldRowNum := OldRowNum;
      end;
    end else
    begin
      for i := 0 to FEventReceivers.Count-1 do
      begin
        if Supports(FEventReceivers[i], IMTEventReceiverEh, IntEventReceiver) then
          IntEventReceiver.MTViewDataEvent(RowNum, Event, OldRowNum);
      end;
      FMTViewDataEventInactiveCount := 0;
    end;
  end;
end;

function TCustomMemTableEh.ViewRecordIndexToViewRowNum(ViewRecordIndex: Integer): Integer;
begin
  Result := ViewRecordIndex;
//  if (State = dsInsert) and (Result >= FInstantReadCurRowNum) and (RecordCount > 0) then
  if FStateInsert and (Result >= FInstantReadCurRowNum) then
    Inc(Result);
end;


{ TMemBlobStreamEh }

constructor TMemBlobStreamEh.Create(Field: TBlobField; Mode: TBlobStreamMode);
begin
  inherited Create;
  FField := Field;
  FFieldNo := FField.FieldNo - 1;
  FDataSet := FField.DataSet as TCustomMemTableEh;
  FFieldData := Null;
  FData := Null;
  if not FDataSet.GetActiveRecBuf(FBuffer) then Exit;
  if Mode <> bmRead then
  begin
    if FField.ReadOnly then
      DatabaseErrorFmt(SFieldReadOnly, [FField.DisplayName], FDataSet);
    if not (FDataSet.State in [dsEdit, dsInsert]) then
      DatabaseError(SNotEditing, FDataSet);
  end;
  if Mode = bmWrite
    then Truncate
    else ReadBlobData;
end;

destructor TMemBlobStreamEh.Destroy;
begin
  if FModified then
  try
{$IFDEF CIL}
//    FDataSet.SetFieldData(FField, FData);
    FField.Modified := True;
    FDataSet.DataEvent(deFieldChange, TObject(FField));
{$ELSE}
    FDataSet.SetFieldData(FField, @FData);
    FField.Modified := True;
    FDataSet.DataEvent(deFieldChange, Longint(FField));
{$ENDIF}
  except
{$IFDEF EH_LIB_6}
    ApplicationHandleException(Self);
{$ELSE}
    Application.HandleException(Self);
{$ENDIF}
  end;
  inherited Destroy;
end;

procedure TMemBlobStreamEh.ReadBlobData;
begin
{$IFDEF CIL}
//  FDataSet.GetFieldData(FField, FFieldData, True);
{$ELSE}
  FDataSet.GetFieldData(FField, @FFieldData, True);
{$ENDIF}
//  FDataSet.GetBlobData(FField, FBuffer);
  if not VarIsNull(FFieldData) then
  begin
    if VarType(FFieldData) = varOleStr then
    begin
{$IFDEF EH_LIB_10}
      if FField.BlobType = ftWideMemo then
        Size := Length(WideString(FFieldData)) * sizeof(widechar)
      else
{$ENDIF}
      begin
        { Convert OleStr into a pascal string (format used by TBlobField) }
        FFieldData := string(FFieldData);
        Size := Length(FFieldData);
      end;
    end else if VarType(FFieldData) = varString then
        Size := Length(FFieldData)
    else
      Size := VarArrayHighBound(FFieldData, 1) + 1;
    FFieldData := Null;
  end;
end;

{$IFDEF CIL}
function TMemBlobStreamEh.Realloc(var NewCapacity: Longint): TBytes;
{$ELSE}
function TMemBlobStreamEh.Realloc(var NewCapacity: Longint): Pointer;
{$ENDIF}

  procedure VarAlloc(var V: Variant; Field: TFieldType);
  var
{$IFDEF EH_LIB_10}
    W: WideString;
{$ENDIF}
    S: string;
  begin
    if Field in [ftMemo, ftFmtMemo, ftFixedChar, ftOraClob] then
    begin
      if not VarIsNull(V) then S := string(V);
      SetLength(S, NewCapacity);
      V := S;
    end else
{$IFDEF EH_LIB_10}
    if Field in [ftWideMemo, ftFixedWideChar] then
    begin
      if not VarIsNull(V) then W := WideString(V);
      SetLength(W, NewCapacity div 2);
      V := W;
    end else
{$ENDIF}
    begin
{$IFDEF CIL}
      if VarIsEmpty(V) or VarIsNull(V)
        then V := VarArrayCreate([0, NewCapacity-1], varByte)
       ;//else
{$ELSE}
{$IFDEF EH_LIB_12}
      if VarIsEmpty(V) or VarIsNull(V)
        then V := VarArrayCreate([0, NewCapacity-1], varByte)
        else VarArrayRedim(V, NewCapacity-1);
{$ELSE}
      if not VarIsNull(V) then S := string(V);
      SetLength(S, NewCapacity);
      V := S;
{$ENDIF}
{$ENDIF}
    end;
  end;

begin
{$IFDEF CIL}
  SetLength(Result, NewCapacity);
{$ELSE}
  Result := Memory;
  if NewCapacity <> Capacity then
  begin
    if VarIsArray(FData) then VarArrayUnlock(FData);
    if NewCapacity = 0 then
    begin
      FData := Null;
      Result := nil;
    end else
    begin
      if VarIsNull(FFieldData)
        then VarAlloc(FData, FField.DataType)
        else FData := FFieldData;
      if VarIsArray(FData)
        then Result := VarArrayLock(FData)
        else Result := TVarData(FData).VString;
    end;
  end;
{$ENDIF}
end;

{$IFDEF CIL}
function TMemBlobStreamEh.Write(const Buffer: array of Byte; Offset, Count: Longint): Longint;
{$ELSE}
function TMemBlobStreamEh.Write(const Buffer; Count: Longint): Longint;
{$ENDIF}
begin
  Result := inherited Write(Buffer, Count);
  FModified := True;
end;

procedure TMemBlobStreamEh.Truncate;
begin
  Clear;
  FModified := True;
end;


{ TMemTableTreeListEh }

constructor TMemTableTreeListEh.Create(AMemTable: TCustomMemTableEh);
begin
  inherited Create;
  FMemTable := AMemTable;
  FullBuildCheck := True;
end;

function TMemTableTreeListEh.GetActive: Boolean;
begin
  if csLoading in FMemTable.ComponentState
    then Result := FLoadingActive
    else Result := FMemTable.RecordsView.ViewAsTreeList;
end;

procedure TMemTableTreeListEh.SetActive(const Value: Boolean);
begin
  if csLoading in FMemTable.ComponentState then
    FLoadingActive := Value
  else
  begin
    FMemTable.RecordsView.ViewAsTreeList := Value;
    if FMemTable.Active then
    begin
      FMemTable.UpdateCursorPos;
      FMemTable.Resync([]);
    end;
  end;  
end;

function TMemTableTreeListEh.GetKeyFieldName: String;
begin
  Result := FMemTable.RecordsView.TreeViewKeyFieldName;
end;

procedure TMemTableTreeListEh.SetKeyFieldName(const Value: String);
begin
  FMemTable.RecordsView.TreeViewKeyFieldName := Value;
end;

function TMemTableTreeListEh.GetRefParentFieldName: String;
begin
  Result := FMemTable.RecordsView.TreeViewRefParentFieldName;
end;

procedure TMemTableTreeListEh.SetRefParentFieldName(const Value: String);
begin
  FMemTable.RecordsView.TreeViewRefParentFieldName := Value;
end;

function TMemTableTreeListEh.GetDefaultNodeExpanded: Boolean;
begin
  Result := FMemTable.RecordsView.MemoryTreeList.DefaultNodeExpanded;
end;

function TMemTableTreeListEh.GetDefaultNodeHasChildren: Boolean;
begin
  Result := FMemTable.RecordsView.MemoryTreeList.DefaultNodeHasChildren;
end;

procedure TMemTableTreeListEh.SetDefaultNodeExpanded(const Value: Boolean);
begin
  FMemTable.RecordsView.MemoryTreeList.DefaultNodeExpanded := Value;
end;

procedure TMemTableTreeListEh.SetDefaultNodeHasChildren(const Value: Boolean);
begin
  FMemTable.RecordsView.MemoryTreeList.DefaultNodeHasChildren := Value;
end;

procedure TMemTableTreeListEh.FullCollapse;
begin
  FMemTable.DisableControls;
  try
    FMemTable.RecordsView.MemoryTreeList.Collapse(nil, True);
    FMemTable.RecordsView.MemoryTreeList.BuildVisibleItems;
  finally
    FMemTable.Resync([]);
    FMemTable.EnableControls;
  end;
end;

procedure TMemTableTreeListEh.FullExpand;
begin
  FMemTable.DisableControls;
  try
    FMemTable.RecordsView.MemoryTreeList.Expand(nil, True);
    FMemTable.RecordsView.MemoryTreeList.BuildVisibleItems;
  finally
    FMemTable.Resync([]);
    FMemTable.EnableControls;
  end;
end;

function TMemTableTreeListEh.Locate(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;
var
  i: Integer;
  TreeList: TMemoryTreeListEh;
  RecView, RecViewFound: TMemRecViewEh;

  function StringValueEqual(DataStr, FindStr: String): Boolean;
  begin
    if (loPartialKey in Options) then
{$IFDEF CIL}
      Borland.Delphi.System.Delete(DataStr, Length(FindStr) + 1, MaxInt);
{$ELSE}
      System.Delete(DataStr, Length(FindStr) + 1, MaxInt);
{$ENDIF}
    if (loCaseInsensitive in Options) then
      Result := AnsiCompareText(DataStr, FindStr) = 0
    else
      Result := AnsiCompareStr(DataStr, FindStr) = 0;
  end;
  
begin
  Result := False;
  RecViewFound := nil;
  FMemTable.CheckBrowseMode;
  if FMemTable.BOF and FMemTable.EOF then Exit;
  TreeList := FMemTable.RecordsView.MemoryTreeList;
  for i := 0 to TreeList.AccountableCount - 1 do
  begin
    if (Options <> []) and (Pos(';', KeyFields) = 0) then
      Result := StringValueEqual(
                  VarToStr(TreeList.AccountableItem[i].Rec.DataValues[KeyFields,dvvValueEh]),
                  VarToStr(KeyValues))
    else
      Result := VarEquals(TreeList.AccountableItem[i].Rec.DataValues[KeyFields,dvvValueEh], KeyValues);
    if Result then
    begin
      RecViewFound := TreeList.AccountableItem[i];
      Break;
    end;
  end;
  if Result then
  begin
    RecView := RecViewFound;
    while RecView.Rec <> nil do
    begin
      RecView.NodeExpanded := True;
      RecView := RecView.NodeParent;
    end;
    FMemTable.SetToRec(RecViewFound.Rec);
  end;
end;

function TMemTableTreeListEh.GetFullBuildCheck: Boolean;
begin
  Result := FMemTable.RecordsView.MemoryTreeList.FullBuildCheck;
end;

procedure TMemTableTreeListEh.SetFullBuildCheck(const Value: Boolean);
begin
  FMemTable.RecordsView.MemoryTreeList.FullBuildCheck := Value;
end;

procedure TMemTableTreeListEh.SetFilterNodeIfParentVisible(const Value: Boolean);
begin
  FMemTable.RecordsView.MemoryTreeList.FilterNodeIfParentVisible := Value;
end;

function TMemTableTreeListEh.GetFilterNodeIfParentVisible: Boolean;
begin
  Result := FMemTable.RecordsView.MemoryTreeList.FilterNodeIfParentVisible;
end;

{ TMemTableDataFieldValueListEh }

constructor TMemTableDataFieldValueListEh.Create;
begin
  inherited Create;
  FValues := TStringList.Create;
  { TODO : Create TVarList class to have valid sorting }
//  FValues.Sorted := True; // Correctly only for text fields.
  FValues.Duplicates := dupIgnore;
  FDataObsoleted := True;
  FNotificator := TRecordsListNotificatorEh.Create(nil);
  FNotificator.OnDataEvent := MTDataEvent;
end;

destructor TMemTableDataFieldValueListEh.Destroy;
begin
  FreeAndNil(FValues);
  FreeAndNil(FNotificator);
  inherited Destroy;
end;

function TMemTableDataFieldValueListEh.GetValues: TStrings;
begin
  if FDataObsoleted then
    RefreshValues;
  Result := FValues;
end;

procedure TMemTableDataFieldValueListEh.RecordListChanged;
begin
  FDataObsoleted := True;
end;

procedure TMemTableDataFieldValueListEh.RefreshValues;
var
  i: Integer;
  DataField: TMTDataFieldEh;
  Idx: TMTIndexEh;
  s, s1: String;
  MemTableData: TMemTableDataEh;
  RecordsView: TRecordsViewEh;
  sl: TStringList;
begin
  FValues.Clear;
//  if (RecordsList = nil) or (RecordsList.DataStruct.FindField(FieldName) = nil) then
//  if MemTableData = nil then Exit;
  if DataObject = nil then Exit;
  if DataObject is TMemTableDataEh then
  begin
    MemTableData := TMemTableDataEh(DataObject);
    DataField := MemTableData.DataStruct.FindField(FieldName);
    if DataField = nil then Exit;
    if DataField.DataType in [ftString, ftWideString] then
    begin
      FValues.Sorted := True;
      for i := 0 to MemTableData.RecordsList.Count-1 do
        FValues.Add(VarToStr(MemTableData.RecordsList[i].DataValues[FieldName, dvvValueEh]))
    end else
    begin
      Idx := TMTIndexEh.CreateApart(MemTableData.RecordsList);
      try
        Idx.Fields := FieldName;
        Idx.Active := True;
        FValues.Sorted := False;
        if Idx.Count > 0 then
        begin
          s := VarToStr(Idx.KeyValue[0]);
          FValues.Add(s);
        end;
        for i := 1 to Idx.Count-1 do
        begin
          s1 := VarToStr(Idx.KeyValue[i]);
          if s <> s1 then
          begin
            s := s1;
            FValues.Add(s);
          end;
        end;
      finally
        Idx.Free;
      end;
    end;
  end
  else if DataObject is TRecordsViewEh then
  begin
    RecordsView := TRecordsViewEh(DataObject);
    sl := TStringList.Create;
    DataField := RecordsView.MemTableData.DataStruct.FindField(FieldName);
    for i := 0 to RecordsView.Count-1 do
      sl.Add(VarToStr(RecordsView.Rec[i].Value[DataField.Index, dvvValueEh]));
    sl.Sort;
    for i := 0 to sl.Count-1 do
    begin
      s1 := sl[i];
      if s <> s1 then
      begin
        s := s1;
        FValues.Add(s);
      end;
    end;
  end;
//  FValues.Sorted := True;
//  FValues.Sorted := False;
  FDataObsoleted := False;
end;

procedure TMemTableDataFieldValueListEh.SetFieldName(const Value: String);
begin
  if FFieldName <> Value then
  begin
    FDataObsoleted := True;
    FFieldName := Value;
    RefreshValues;
  end;
end;

procedure TMemTableDataFieldValueListEh.MTDataEvent(
  MemRec: TMemoryRecordEh; Index: Integer;
  Action: TRecordsListNotification);
begin
  RecordListChanged;
end;

{function TMemTableDataFieldValueListEh.GetMemTableData: TMemTableDataEh;
begin
  Result := FNotificator.MemTableData;
end;

procedure TMemTableDataFieldValueListEh.SetMemTableData(const Value: TMemTableDataEh);
begin
  FNotificator.MemTableData := Value;
end;}

function TMemTableDataFieldValueListEh.GetDataObject: TComponent;
begin
  Result := FNotificator.DataObject;
end;

procedure TMemTableDataFieldValueListEh.SetDataObject(const Value: TComponent);
begin
  FNotificator.DataObject := Value;
end;

{ TRefObjectField }

class procedure TRefObjectField.CheckTypeSize(Value: Integer);
begin
  { No validation }
end;

constructor TRefObjectField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  SetDataType(ftInteger); //ftUnknown
end;

function TRefObjectField.GetValue: TObject;
begin
  if DataSet = nil then DatabaseErrorFmt('SDataSetMissing', [DisplayName]);
{  if FValidating then
  begin
    Result := LongBool(FValueBuffer);
    if Result and (Buffer <> nil) then
      CopyData(FValueBuffer, Buffer);
  end else}
    TMemTableEh(DataSet).GetFieldDataAsObject(Self, Result);
end;

procedure TRefObjectField.SetValue(const Value: TObject);
begin
  if DataSet = nil then DatabaseErrorFmt('SDataSetMissing', [DisplayName]);
  TMemTableEh(DataSet).SetFieldDataAsObject(Self, Value);
end;

function TRefObjectField.GetAsVariant: Variant;
begin
  Result := RefObjectToVariant(Value);
end;

procedure TRefObjectField.SetVarValue(const Value: Variant);
begin
  SetValue(VariantToRefObject(Value));
end;

{ TBMListMemTBLEh }

constructor TSortedVarItemEh.Create(NewValue:variant);
begin
  inherited Create;
  Value := NewValue;
end;

function  TSortedVarlistEh.VarInList(Value:variant):boolean;
var
  Index: Integer;
begin
  Result:=  FindValueIndex(Value,Index);
end;

function  TSortedVarlistEh.FindValueIndex(Value: Variant; var Index: Integer):boolean;
var
  L, H, I: Integer;
  C: TVariantRelationship;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := DBVarCompareValue(TSortedVarItemEh(Items[i]).Value, Value);
    if C = vrNotEqual then
      raise Exception.Create('TSortedVarlistEh.FindKeyValueIndex: values is not comparable.');
    if C = vrLessThan then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = vrEqual then
      begin
        Result := True;
        {if Duplicates <> dupAccept then} L := I;
      end;
    end;
  end;
  Index := L;
end;

function TSortedVarlistEh.Add(AObject: TSortedVarItemEh): Integer;
begin
  FindValueIndex(AObject.Value,Result);
  inherited Insert(Result, AObject)
end;

procedure TSortedVarlistEh.Insert(Index: Integer; AObject: TSortedVarItemEh);
begin
  Add(AObject);
end;

end.
