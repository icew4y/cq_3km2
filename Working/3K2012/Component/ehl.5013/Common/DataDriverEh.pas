{*******************************************************}
{                                                       }
{                     EhLib v5.0                        }
{                                                       }
{           TDataDriverEh, TSQLDataDriverEh             }
{                components (Build 5.0.00)              }
{                                                       }
{     Copyright (c) 2003-09 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit DataDriverEh;// {$IFDEF CIL} platform{$ENDIF};

{$I EHLIB.INC}

interface

uses SysUtils, Classes, Controls, DB, Windows,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh;
type

{ TDataDriverEh }
  TDataDriverEh = class;

  TUpdateErrorActionEh = (ueaBreakAbortEh, ueaBreakRaiseEh, ueaCountinueEh, ueaRetryEh, ueaCountinueSkip);

  TDataDriverProduceDataReaderEhEvent = procedure (DataDriver: TDataDriverEh; var DataReader: TDataSet; var FreeOnEof: Boolean) of object;
  TDataDriverBuildDataStructEhEvent = procedure (DataDriver: TDataDriverEh; DataStruct: TMTDataStructEh) of object;
  TDataDriverReadRecordEhEvent = procedure (DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh;
    MemRec: TMemoryRecordEh; var ProviderEOF: Boolean) of object;
  TDataDriverUpdateErrorEhEvent = procedure (DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh;
    MemRec: TMemoryRecordEh; var Action: TUpdateErrorActionEh) of object;
  TDataDriverRecordEhEvent = procedure (DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh) of object;
  TDataDriverAssignFieldValueEhEvent = procedure (DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
    DataFieldIndex: Integer; DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet) of object;

// TProviderOption = (poFetchBlobsOnDemand, poFetchDetailsOnDemand, poIncFieldProps,
//                    poCascadeDeletes, poCascadeUpdates, poReadOnly, poAllowMultiRecordUpdates,
//                    poDisableInserts, poDisableEdits, poDisableDeletes, poNoReset,
//                    poAutoRefresh, poPropogateChanges, poAllowCommandText, poRetainServerOrder);

// TDataDriverOptionEh = (ddoAutoRefresh, ddoUpdatesInTransactionEh);

  IDataDriverConsumerEh = interface
    ['{E390BBF2-666F-43D7-8CC8-1FA2BA8263D1}']
    procedure SetDataDriverConsumer(AObject: TObject);
    function GetDataDriverConsumer: TObject;
    property DataDriverConsumer: TObject read GetDataDriverConsumer write SetDataDriverConsumer;
  end;

  TDataDriverEh = class(TComponent, IDataDriverConsumerEh{$IFNDEF CIL}, IUnknown{$ENDIF})
  private
    FKeyFields: String;
    FOnAssignFieldValue: TDataDriverAssignFieldValueEhEvent;
    FOnBuildDataStruct: TDataDriverBuildDataStructEhEvent;
    FOnProduceDataReader: TDataDriverProduceDataReaderEhEvent;
    FOnReadRecord: TDataDriverReadRecordEhEvent;
    FOnRefreshRecord: TDataDriverRecordEhEvent;
    FOnUpdateError: TDataDriverUpdateErrorEhEvent;
    FOnUpdateRecord: TDataDriverRecordEhEvent;
    FProviderDataSet: TDataSet;
    FProviderEOF: Boolean;
    FReaderDataSet: TDataSet;
    FReaderDataSetFreeOnEof: Boolean;
    FResolveToDataSet: Boolean;
    FDataDriverConsumer: TObject;
    procedure SetKeyFields(const Value: String);
    procedure SetProviderDataSet(const Value: TDataSet);
    procedure SetProviderEOF(const Value: Boolean);
  protected
    function GetDataDriverConsumer: TObject;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); virtual;
    procedure SetDataDriverConsumer(ADataDriverConsumer: TObject);
    property KeyFields: String read FKeyFields write SetKeyFields;
    property ProviderDataSet: TDataSet read FProviderDataSet write SetProviderDataSet;
    property ReaderDataSet: TDataSet read FReaderDataSet;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ApplyUpdates(MemTableData: TMemTableDataEh): Integer; virtual;
    function DefaultUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; virtual;
    function GetDataReader: TDataSet; virtual;
    function ReadData(MemTableData: TMemTableDataEh; Count: Integer): Integer; virtual;
    function RefreshReaderParamsFromCursor(DataSet: TDataSet): Boolean; virtual;
    procedure AssignFieldValue(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
      DataFieldIndex: Integer; DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet); virtual;
    procedure UpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh); virtual;
    procedure ConsumerClosed(ConsumerDataSet: TDataSet); virtual;
    procedure DefaultAssignFieldValue(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
      DataFieldIndex: Integer; DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet); virtual;
    procedure DefaultBuildDataStruct(DataStruct: TMTDataStructEh); virtual;
    procedure DefaultProduceDataReader(var DataSet: TDataSet; var FreeOnEof: Boolean); virtual;
    procedure DefaultReadRecord(MemTableData: TMemTableDataEh; Rec: TMemoryRecordEh; var ProviderEOF: Boolean); virtual;
    procedure DefaultUpdateError(MemTableData: TMemTableDataEh;
      MemRec: TMemoryRecordEh; var Action: TUpdateErrorActionEh); virtual;
    procedure DefaultRefreshRecord(MemRecord: TMemoryRecordEh); virtual;
    procedure BuildDataStruct(DataStruct: TMTDataStructEh); virtual;
    procedure RefreshRecord(MemRecord: TMemoryRecordEh); virtual;
    procedure SetReaderParamsFromCursor(DataSet: TDataSet); virtual;
    property ProviderEOF: Boolean read FProviderEOF write SetProviderEOF;
    property ResolveToDataSet: Boolean read FResolveToDataSet write FResolveToDataSet default True;
    property OnBuildDataStruct: TDataDriverBuildDataStructEhEvent read FOnBuildDataStruct write FOnBuildDataStruct;
    property OnProduceDataReader: TDataDriverProduceDataReaderEhEvent read FOnProduceDataReader write FOnProduceDataReader;
    property OnAssignFieldValue: TDataDriverAssignFieldValueEhEvent read FOnAssignFieldValue write FOnAssignFieldValue;
    property OnReadRecord: TDataDriverReadRecordEhEvent read FOnReadRecord write FOnReadRecord;
    property OnRefreshRecord: TDataDriverRecordEhEvent read  FOnRefreshRecord write FOnRefreshRecord;
    property OnUpdateRecord: TDataDriverRecordEhEvent read  FOnUpdateRecord write FOnUpdateRecord;
    property OnUpdateError: TDataDriverUpdateErrorEhEvent read  FOnUpdateError write FOnUpdateError;
  end;

  TDataSetDriverEh = class(TDataDriverEh)
  published
    property KeyFields;
    property ProviderDataSet;
    property OnBuildDataStruct;
    property OnProduceDataReader;
    property OnAssignFieldValue;
    property OnReadRecord;
    property OnRefreshRecord;
    property OnUpdateRecord;
    property OnUpdateError;
    property ResolveToDataSet;
  end;

  TCustomSQLDataDriverEh = class;
  TCustomSQLCommandEh = class;
  TServerSpecOperationsEh = class;


{ TDynaSQLParamsEh }

  TDynaSQLOptionEh = ( dsoDynamicSQLInsertEh, dsoDynamicSQLUpdateEh, dsoDynamicSQLDeleteEh);
  TDynaSQLOptionsEh = set of TDynaSQLOptionEh;

  TDynaSQLParamsEh = class(TPersistent)
  private
    FDataDriver: TCustomSQLDataDriverEh;
    FUpdateTable: String;
    FUpdateFields: String;
    FKeyFields: String;
    FSkipUnchangedFields: Boolean;
    FOptions: TDynaSQLOptionsEh;
    procedure SetKeyFields(const Value: String);
    procedure SetUpdateFields(const Value: String);
    procedure SetUpdateTable(const Value: String);
  public
    constructor Create(ADataDriver: TCustomSQLDataDriverEh);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property DataDriver: TCustomSQLDataDriverEh read FDataDriver;
  published
    property KeyFields: String read FKeyFields write SetKeyFields;
    property UpdateFields: String read FUpdateFields write SetUpdateFields;
    property UpdateTable: String read FUpdateTable write SetUpdateTable;
    property SkipUnchangedFields: Boolean read FSkipUnchangedFields write FSkipUnchangedFields default False;
    property Options: TDynaSQLOptionsEh read FOptions write FOptions;
  end;

{ TCustomSQLCommandEh }

  TSQLCommandTypeEh = (cthSelectQuery, cthUpdateQuery, cthTable, cthStoredProc);
  TSQLExecuteEhEvent = function (var Cursor: TDataSet; var FreeOnEof: Boolean) : Integer of object;
  TAssignParamEhEvent = procedure (Command: TCustomSQLCommandEh;
    MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Param: TParam) of object;

  TCustomSQLCommandEh = class(TPersistent)
  private
    FCommandText: TStrings;
    FCommandType: TSQLCommandTypeEh;
    FDataDriver: TCustomSQLDataDriverEh;
//    FDynamicSQL: Boolean;
//    FOnExecute: TSQLExecuteEhEvent;
    function IsCommandTypeStored: Boolean;
//    procedure SetDynamicSQL(const Value: Boolean);
  protected
    function DefaultCommandType: TSQLCommandTypeEh; virtual;
    function GetCommandText: TStrings; virtual;
    function GetCommandType: TSQLCommandTypeEh; virtual;
    function GetOwner: TPersistent; override;
    procedure CommandTextChanged(Sender: TObject); virtual;
    procedure CommandTypeChanged; virtual;
    procedure SetCommandText(const Value: TStrings); virtual;
    procedure SetCommandType(const Value: TSQLCommandTypeEh); virtual;
  public
    constructor Create(ADataDriver: TCustomSQLDataDriverEh);
    destructor Destroy; override;
//    procedure AssignParams(AParams: TParams); virtual;
//    procedure AssignToParams(AParams: TParams); virtual;
//    property OnExecute: TSQLExecuteEhEvent read FOnExecute write FOnExecute;
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; virtual;
    function GetNamePath: String; override;
    function GetParams: TParams; virtual;
    procedure Assign(Source: TPersistent); override;
    procedure RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh); virtual;
    procedure SetParams(AParams: TParams); virtual;
    property CommandText: TStrings read GetCommandText write SetCommandText;
    property CommandType: TSQLCommandTypeEh read GetCommandType write SetCommandType stored IsCommandTypeStored;
    property DataDriver: TCustomSQLDataDriverEh read FDataDriver;
//    property DynamicSQL: Boolean read FDynamicSQL write SetDynamicSQL default False;
  end;

{ TCustomSQLDataDriverEh }

{$IFNDEF EH_LIB_6}
  IInterface = IUnknown;
{$ENDIF}

  TDataDriverExecuteCommandEhEvent = function (DataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer of object;
  TDataDriverGetBackUpdatedValuesEhEvent = procedure (DataDriver: TCustomSQLDataDriverEh;
    MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet) of object;

  TCustomSQLDataDriverEh = class(TDataDriverEh)
  private
    FDeleteCommand: TCustomSQLCommandEh;
    FDesignDataBase: TComponent;
    FGetrecCommand: TCustomSQLCommandEh;
    FInsertCommand: TCustomSQLCommandEh;
    FOnExecuteCommand: TDataDriverExecuteCommandEhEvent;
    FOnGetBackUpdatedValues: TDataDriverGetBackUpdatedValuesEhEvent;
    FSelectCommand: TCustomSQLCommandEh;
    FSpecParams: TStrings;
    FUpdateCommand: TCustomSQLCommandEh;
    FServiceCommand: TCustomSQLCommandEh;
//    FServerService: TServerServiceEh;
    FServerSpecOperations: TServerSpecOperationsEh;
    FDynaSQLParams: TDynaSQLParamsEh;
    function GetDeleteSQL: TStrings;
    function GetGetrecSQL: TStrings;
    function GetInsertSQL: TStrings;
    function GetSelectSQL: TStrings;
    function GetUpdateSQL: TStrings;
    procedure SetDeleteCommand(const Value: TCustomSQLCommandEh);
    procedure SetDeleteSQL(const Value: TStrings);
    procedure SetGetrecCommand(const Value: TCustomSQLCommandEh);
    procedure SetGetrecSQL(const Value: TStrings);
    procedure SetInsertCommand(const Value: TCustomSQLCommandEh);
    procedure SetInsertSQL(const Value: TStrings);
    procedure SetSelectCommand(const Value: TCustomSQLCommandEh);
    procedure SetSelectSQL(const Value: TStrings);
    procedure SetSpecParams(const Value: TStrings);
    procedure SetUpdateCommand(const Value: TCustomSQLCommandEh);
    procedure SetUpdateSQL(const Value: TStrings);
    procedure SetServiceCommand(const Value: TCustomSQLCommandEh);
    procedure SetDynaSQLParams(const Value: TDynaSQLParamsEh);
    procedure SetServerSpecOperations(const Value: TServerSpecOperationsEh);
  protected
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); override;
    procedure SetDesignDataBase(const Value: TComponent); virtual;
  public
    {DesignTime stuff}
    function CreateDesignCopy: TCustomSQLDataDriverEh; virtual;
    function CreateDesignDataBase: TComponent; virtual;
    function GetDesignDataBase: TComponent; virtual;
    procedure AssignFromDesignDriver(DesignDataDriver: TCustomSQLDataDriverEh); virtual;
    property DesignDataBase: TComponent read FDesignDataBase write SetDesignDataBase;
  protected
//    function GetReaderDataSet: TDataSet; override;
    function CreateCommand: TCustomSQLCommandEh; virtual;
    function CreateDeleteCommand: TCustomSQLCommandEh; virtual;
    function CreateInsertCommand: TCustomSQLCommandEh; virtual;
    function CreateSelectCommand: TCustomSQLCommandEh; virtual;
    function CreateGetrecCommand: TCustomSQLCommandEh; virtual;
    function CreateUpdateCommand: TCustomSQLCommandEh; virtual;
    function GetDefaultCommandTypeFor(Command: TCustomSQLCommandEh): TSQLCommandTypeEh; virtual;
    function InternalGetServerSpecOperations: TServerSpecOperationsEh; virtual;
    procedure CommandTextChanged(Sender: TCustomSQLCommandEh); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateServerService; virtual;
    property ServiceCommand: TCustomSQLCommandEh read FServiceCommand write SetServiceCommand;
//    property ServerService: TServerServiceEh read FServerService;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function DefaultUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; override;
    function DoUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; virtual;
    function ExecuteCommand(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; virtual;
    function DefaultExecuteCommand(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; virtual;
    function RefreshReaderParamsFromCursor(DataSet: TDataSet): Boolean; override;
    function HaveDataConnection(): Boolean; virtual;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
    procedure DefaultBuildDataStruct(DataStruct: TMTDataStructEh); override;
    procedure DefaultGetUpdatedServerValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
    procedure DefaultProduceDataReader(var DataSet: TDataSet; var FreeOnEof: Boolean); override;
    procedure DefaultRefreshRecord(MemRecord: TMemoryRecordEh); override;
    procedure GenerateDynamicSQLCommand(MemRecord: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    procedure SetReaderParamsFromCursor(DataSet: TDataSet); override;
    property DynaSQLParams: TDynaSQLParamsEh read FDynaSQLParams write SetDynaSQLParams;
    property ResolveToDataSet default False;
    property DeleteCommand: TCustomSQLCommandEh read FDeleteCommand write SetDeleteCommand;
    property DeleteSQL: TStrings read GetDeleteSQL write SetDeleteSQL stored False;
    property GetrecCommand: TCustomSQLCommandEh read FGetrecCommand write SetGetrecCommand;
    property GetrecSQL: TStrings read GetGetrecSQL write SetGetrecSQL stored False;
    property InsertCommand: TCustomSQLCommandEh read FInsertCommand write SetInsertCommand;
    property InsertSQL: TStrings read GetInsertSQL write SetInsertSQL stored False;
    property SelectCommand: TCustomSQLCommandEh read FSelectCommand write SetSelectCommand;
    property SelectSQL: TStrings read GetSelectSQL write SetSelectSQL stored False;
    property ServerSpecOperations: TServerSpecOperationsEh read FServerSpecOperations write SetServerSpecOperations;
    property SpecParams: TStrings read FSpecParams write SetSpecParams;
    property UpdateCommand: TCustomSQLCommandEh read FUpdateCommand write SetUpdateCommand;
    property UpdateSQL: TStrings read GetUpdateSQL write SetUpdateSQL stored False;
    property OnExecuteCommand: TDataDriverExecuteCommandEhEvent read FOnExecuteCommand write FOnExecuteCommand;
    property OnGetBackUpdatedValues: TDataDriverGetBackUpdatedValuesEhEvent read FOnGetBackUpdatedValues write FOnGetBackUpdatedValues;
  end;

{ TServerSpecOperationsEh }

  TServerSpecOperationsEh = class
  private
    FIncludeInsertFieldsInUpdateCommand: Boolean;
  protected
    procedure GenWhereClause(KeyFields: String; SQL: TStrings); virtual;
    procedure BuildChangedFieldList(MemRec: TMemoryRecordEh; UpdateFieldList, ChangedFieldList: TStringList); virtual;
  public
    constructor Create; virtual;
//    procedure BeforeExecuteCommand(Command: TCustomSQLCommandEh; MemRec: TMemoryRecordEh); virtual;
//    procedure AfterExecuteCommand(Command: TCustomSQLCommandEh; MemRec: TMemoryRecordEh; ResDataSet: TDataSet); virtual;
    function UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; virtual;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
    procedure GenerateDynaSQLCommand(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    procedure GenerateDeleteCommand(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    procedure GenerateUpdateCommand(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    procedure GenerateInsertCommand(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    property IncludeInsertFieldsInUpdateCommand: Boolean read FIncludeInsertFieldsInUpdateCommand write FIncludeInsertFieldsInUpdateCommand;
  end;

{ TSQLDataDriverResolver }

  TResolverExecuteCommandEhEvent = function (SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean): Integer of object;

  TResolverGetBackUpdatedValuesEhEvent = procedure (SQLDataDriver: TCustomSQLDataDriverEh;
   MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet;
   var Processed: Boolean) of object;
  TResolverGetServerSpecOperationsEh = function (var Processed: Boolean):
    TServerSpecOperationsEh of object;
  TResolverUpdateRecordEhEvent = procedure (SQLDataDriver: TCustomSQLDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean);

  TSQLDataDriverResolver = class(TPersistent)
  private
    FServerSpecOperations: TServerSpecOperationsEh;
    FOnExecuteCommand: TResolverExecuteCommandEhEvent;
    FOnGetBackUpdatedValues: TResolverGetBackUpdatedValuesEhEvent;
    FOnGetServerSpecOperations: TResolverGetServerSpecOperationsEh;
    FOnUpdateRecord: TResolverUpdateRecordEhEvent;
  public
    function ExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
      var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; virtual;
    function GetServerSpecOperations(var Processed: Boolean): TServerSpecOperationsEh; virtual;
    procedure UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean); virtual;
    procedure DefaultUpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean); virtual;
    procedure GetBackUpdatedValues(SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean); virtual;
    procedure DefaultGetUpdatedServerValues(SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean); virtual;
    property ServerSpecOperations: TServerSpecOperationsEh read FServerSpecOperations write FServerSpecOperations;
    property OnExecuteCommand: TResolverExecuteCommandEhEvent read FOnExecuteCommand write FOnExecuteCommand;
    property OnGetBackUpdatedValues: TResolverGetBackUpdatedValuesEhEvent read FOnGetBackUpdatedValues write FOnGetBackUpdatedValues;
    property OnGetServerSpecOperations: TResolverGetServerSpecOperationsEh read FOnGetServerSpecOperations write FOnGetServerSpecOperations;
    property OnUpdateRecord: TResolverUpdateRecordEhEvent read FOnUpdateRecord write FOnUpdateRecord;
  end;

  TBaseSQLCommandEh = class;
  TBaseSQLDataDriverEh = class;

  TSQLDataDriverExecuteCommandEhEvent = function (DataDriver: TBaseSQLDataDriverEh;
    Command: TBaseSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer of object;
  TSQLDataDriverAssignParamEhEvent = procedure (DataDriver: TBaseSQLDataDriverEh;
    Command: TBaseSQLCommandEh; MemRecord: TMemoryRecordEh;
    DataValueVersion: TDataValueVersionEh; Param: TParam) of object;
  TSQLDataDriverGetBackUpdatedValuesEhEvent = procedure (DataDriver: TBaseSQLDataDriverEh;
    MemRec: TMemoryRecordEh; Command: TBaseSQLCommandEh; ResDataSet: TDataSet) of object;

{ TBaseSQLDataDriverEh }

  TBaseSQLDataDriverEh = class(TCustomSQLDataDriverEh)
  private
    FOnAssignCommandParam: TSQLDataDriverAssignParamEhEvent;
    FOnExecuteCommand: TSQLDataDriverExecuteCommandEhEvent;
    FOnGetBackUpdatedValues: TSQLDataDriverGetBackUpdatedValuesEhEvent;
    function GetDeleteCommand: TBaseSQLCommandEh;
    function GetInsertCommand: TBaseSQLCommandEh;
    function GetSelectCommand: TBaseSQLCommandEh;
    function GetGetrecCommand: TBaseSQLCommandEh;
    function GetUpdateCommand: TBaseSQLCommandEh;
    procedure SetDeleteCommand(const Value: TBaseSQLCommandEh);
    procedure SetInsertCommand(const Value: TBaseSQLCommandEh);
    procedure SetSelectCommand(const Value: TBaseSQLCommandEh);
    procedure SetGetrecCommand(const Value: TBaseSQLCommandEh);
    procedure SetUpdateCommand(const Value: TBaseSQLCommandEh);
  protected
    function CreateCommand: TCustomSQLCommandEh; override;
    procedure AssignCommandParam(Command: TBaseSQLCommandEh;
      MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Param: TParam); virtual;
  public
    function ExecuteCommand(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    procedure DefaultGetUpdatedServerValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DefaultAssignCommandParam(Command: TBaseSQLCommandEh;
      MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Param: TParam); virtual;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    property DynaSQLParams;
    property DeleteCommand: TBaseSQLCommandEh read GetDeleteCommand write SetDeleteCommand;
    property GetrecCommand: TBaseSQLCommandEh read GetGetrecCommand write SetGetrecCommand;
    property InsertCommand: TBaseSQLCommandEh read GetInsertCommand write SetInsertCommand;
    property SelectCommand: TBaseSQLCommandEh read GetSelectCommand write SetSelectCommand;
    property UpdateCommand: TBaseSQLCommandEh read GetUpdateCommand write SetUpdateCommand;
    property SpecParams;
    property OnAssignCommandParam: TSQLDataDriverAssignParamEhEvent read FOnAssignCommandParam write FOnAssignCommandParam;
    property OnExecuteCommand: TSQLDataDriverExecuteCommandEhEvent read FOnExecuteCommand write FOnExecuteCommand;
    property OnGetBackUpdatedValues: TSQLDataDriverGetBackUpdatedValuesEhEvent read FOnGetBackUpdatedValues write FOnGetBackUpdatedValues;
  end;

{ TBaseSQLCommandEh }

  TBaseSQLCommandEh = class(TCustomSQLCommandEh)
  private
    FParamCheck: Boolean;
    FParams: TParams;
    FOnAssignParam: TAssignParamEhEvent;
    function GetParamCheck: Boolean;
    function GetDataDriver: TBaseSQLDataDriverEh;
  protected
    procedure CommandTextChanged(Sender: TObject); override;
    procedure SetParamCheck(const Value: Boolean); virtual;
  public
    constructor Create(ADataDriver: TBaseSQLDataDriverEh);
    destructor Destroy; override;
    function GetParams: TParams; override;
    procedure Assign(Source: TPersistent); override;
//    procedure AssignParams(AParams: TParams); override;
//    procedure AssignToParams(AParams: TParams); override;
    procedure SetParams(AParams: TParams); override;
    procedure DefaultRefreshParam(MemRecord: TMemoryRecordEh;
      DataValueVersion: TDataValueVersionEh; Param: TParam); virtual;
    procedure RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh); override;

    property DataDriver: TBaseSQLDataDriverEh read GetDataDriver;

    property OnAssignParam: TAssignParamEhEvent read FOnAssignParam write FOnAssignParam;
    property Params: TParams read GetParams write SetParams;
    property ParamCheck: Boolean read GetParamCheck write SetParamCheck default True;
  end;

{ TSQLCommandEh }

  TSQLCommandEh = class(TBaseSQLCommandEh)
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
//    property DynamicSQL;
  end;

{ TSQLDataDriverEh }

  TSQLDataDriverEh = class(TBaseSQLDataDriverEh)
  protected
    function CreateSelectCommand: TCustomSQLCommandEh; override;
    function CreateUpdateCommand: TCustomSQLCommandEh; override;
    function CreateInsertCommand: TCustomSQLCommandEh; override;
    function CreateDeleteCommand: TCustomSQLCommandEh; override;
    function CreateGetrecCommand: TCustomSQLCommandEh; override;
  published
    property DeleteCommand;
    property DeleteSQL;
    property DynaSQLParams;
    property GetrecCommand;
    property GetrecSQL;
    property InsertCommand;
    property InsertSQL;
    property SelectCommand;
    property SelectSQL;
    property UpdateCommand;
    property UpdateSQL;
    property KeyFields;
    property ProviderDataSet;
    property SpecParams;

    property OnAssignCommandParam;
    property OnAssignFieldValue;
    property OnBuildDataStruct;
    property OnExecuteCommand;
    property OnGetBackUpdatedValues;
    property OnProduceDataReader;
    property OnReadRecord;
    property OnRefreshRecord;
    property OnUpdateError;
    property OnUpdateRecord;
  end;

  TSQLDataDriverEhClass = class of TCustomSQLDataDriverEh;

{ IDesignDataBaseEh }

  IDesignDataBaseEh = interface
  ['{01F477A4-8417-4DC9-B93A-1F95D2FF2EB8}']
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
    function BuildObjectTree(List: TList): Boolean;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean;
    procedure EditDatabaseParams;
    function GetConnected: Boolean;
    procedure SetConnected(const Value: Boolean);
  end;

{ TOracleSpecOperationsEh }

  TOracleSpecOperationsEh = class(TServerSpecOperationsEh)
    function UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; override;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  end;

{ TMSSQLSpecOperationsEh }

  TMSSQLSpecOperationsEh = class(TServerSpecOperationsEh)
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  public
    constructor Create; override;
  end;

{ TInterbaseSpecOperationsEh }

  TInterbaseSpecOperationsEh = class(TServerSpecOperationsEh)
    function UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; override;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  end;

{ TInfromixSpecOperationsEh }

  TInfromixSpecOperationsEh = class(TServerSpecOperationsEh)
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  public
    constructor Create; override;
  end;

{ TDB2SpecOperationsEh }

  TDB2SpecOperationsEh = class(TServerSpecOperationsEh)
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  end;

{ TSybaseSpecOperationsEh }

  TSybaseSpecOperationsEh = class(TServerSpecOperationsEh)
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  end;

{ TMSAccessSpecOperationsEh }

  TMSAccessSpecOperationsEh = class(TServerSpecOperationsEh)
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  public
    constructor Create; override;
  end;

  TSetDesignDataBaseProcEh = procedure(DataDriver: TCustomSQLDataDriverEh);

function DefaultSQLDataDriverResolver: TSQLDataDriverResolver;
function RegisterDefaultSQLDataDriverResolver(ASQLDataDriverResolver: TSQLDataDriverResolver): TSQLDataDriverResolver;


procedure RegisterDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass;
  DesignDataBaseProc: TSetDesignDataBaseProcEh);
procedure UnregisterDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass);
function GetDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass):
  TSetDesignDataBaseProcEh;

procedure VarParamsToParams(VarParams: Variant; Params: TParams);

implementation

uses
  Dialogs,
{$IFDEF CIL}
  System.Runtime.InteropServices,
{$ENDIF}
  MemTableEh;

var
  AnsiServerSpecOperations: TServerSpecOperationsEh;
  DesignDataBuilderClasses: TList;
  DesignDataBuilderProcs: TList;

{$IFDEF CIL}

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

{$ELSE}

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TUniBookmarkEh): Integer;
begin
  Result := DataSet.CompareBookmarks(TBookmark(Bookmark1), TBookmark(Bookmark2));
end;

function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TUniBookmarkEh): Boolean;
begin
  Result := DataSet.BookmarkValid(TBookmark(Bookmark));
end;

{$ENDIF}

var
  FDefaultSQLDataDriverResolver: TSQLDataDriverResolver;

function DefaultSQLDataDriverResolver: TSQLDataDriverResolver;
begin
  Result := FDefaultSQLDataDriverResolver;
end;

function RegisterDefaultSQLDataDriverResolver(ASQLDataDriverResolver: TSQLDataDriverResolver): TSQLDataDriverResolver;
begin
  Result := FDefaultSQLDataDriverResolver;
  FDefaultSQLDataDriverResolver := ASQLDataDriverResolver;
end;

procedure InitializeUnit;
var
  Resolver: TSQLDataDriverResolver;
begin
  AnsiServerSpecOperations := TServerSpecOperationsEh.Create;
  Resolver := TSQLDataDriverResolver.Create;
//  Does add this to avoide automatic resolution for all SQLDataDriver.
//  Resolver.ServerSpecOperations := AnsiServerSpecOperations;
  RegisterDefaultSQLDataDriverResolver(Resolver);
end;

procedure FinalizaUnit;
begin
  FreeAndNil(FDefaultSQLDataDriverResolver);
  FreeAndNil(DesignDataBuilderClasses);
  FreeAndNil(DesignDataBuilderProcs);
  FreeAndNil(AnsiServerSpecOperations);
end;

procedure VarParamsToParams(VarParams: Variant; Params: TParams);
var
  i: Integer;
  dt: TFieldType;
  p: TParam;
begin
  if VarIsNull(VarParams) then
    Exit;
  if VarArrayHighBound(VarParams, 1) > VarArrayLowBound(VarParams, 1) then
    for i := VarArrayLowBound(VarParams, 1) to VarArrayHighBound(VarParams, 1) div 2 do
    begin
      dt := VarTypeToDataType(VarType(VarParams[i*2+1]));
      if dt = ftUnknown then
        dt := ftString;
      p := Params.FindParam(VarParams[i*2]);
      if not Assigned(p) then
        p := Params.CreateParam(dt, VarParams[i*2], ptInputOutput);
      p.Value := VarParams[i*2+1];
    end;
end;

{ TDataDriverEh }

constructor TDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FResolveToDataSet := True;
end;

destructor TDataDriverEh.Destroy;
begin
  ProviderEof := True;
  inherited Destroy;
end;

{$IFNDEF CIL}
function AcquireExceptionObject: Pointer;
type
  PRaiseFrame = ^TRaiseFrame;
  TRaiseFrame = record
    NextRaise: PRaiseFrame;
    ExceptAddr: Pointer;
    ExceptObject: TObject;
    ExceptionRecord: PExceptionRecord;
  end;
begin
  if RaiseList <> nil then
  begin
    Result := Exception(PRaiseFrame(RaiseList)^.ExceptObject);
    PRaiseFrame(RaiseList)^.ExceptObject := nil;
  end
  else
    Result := nil;
end;
{$ENDIF}

function TDataDriverEh.ApplyUpdates(MemTableData: TMemTableDataEh): Integer;
var
  I: Integer;
  MemRec: TMemoryRecordEh;
  Action: TUpdateErrorActionEh;
//  UpdateKind: TUpdateKind;

  procedure ApplyUpdate;
  begin
    while True do
    begin
      try
        UpdateRecord(MemTableData, MemRec);
        Result := Result + 1;
      except
        on E: EDatabaseError do
        begin
          if Assigned(OnUpdateError)
            then OnUpdateError(Self, MemRec.RecordsList.MemTableData, MemRec, Action)
            else DefaultUpdateError(MemRec.RecordsList.MemTableData, MemRec, Action);

          if Action = ueaBreakRaiseEh then
            raise
          else begin
            if MemRec.UpdateError <> nil then
              MemRec.UpdateError.Free;
            MemRec.UpdateError := TUpdateErrorEh.Create(E);
{$IFNDEF CIL}
            AcquireExceptionObject;
{$ENDIF}
            if Action = ueaRetryEh
              then Continue
              else Break;
          end;
        end;
      end;
      Break;
    end;
  end;

begin
  Result := 0;
  for I := 0 to MemTableData.RecordsList.DeltaList.Count-1 do
  begin
    MemRec := TMemoryRecordEh(MemTableData.RecordsList.DeltaList[I]);
    if MemRec = nil then Continue;
    Action := ueaBreakRaiseEh;
    ApplyUpdate;
    if Action = ueaBreakAbortEh then
      Break;
    if Action <> ueaCountinueSkip then
      MemRec.MergeChanges;
//ueaBreakAbortEh, ueaBreakRaiseEh, ueaCountinueEh, ueaRetryEh
  end;

  MemTableData.RecordsList.CleanupChangedRecs;
end;

procedure TDataDriverEh.DefaultUpdateError(MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; var Action: TUpdateErrorActionEh);
begin
  Action := ueaBreakRaiseEh;
end;

procedure TDataDriverEh.UpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh);
begin
  if Assigned(OnUpdateRecord)
    then OnUpdateRecord(Self, MemTableData, MemRec)
    else DefaultUpdateRecord(MemTableData, MemRec);
end;

function TDataDriverEh.DefaultUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer;
var
  vOldValues: Variant;
  i: Integer;
  KeyFound: Boolean;
  Bookmark: TUniBookmarkEh;
  ProviderField: TField;
  UsedKeyFields: String;
begin
  Result := 0;
  if ResolveToDataSet and (ProviderDataSet <> nil) then
  begin
    Bookmark := ProviderDataSet.Bookmark;
    try
    if KeyFields <> '' then
      UsedKeyFields := KeyFields
    else
    begin
      UsedKeyFields := '';
      for i := 0 to ProviderDataSet.FieldCount - 1 do
        if i > 0
          then UsedKeyFields := UsedKeyFields + ';' + ProviderDataSet.Fields[i].FieldName
          else UsedKeyFields := ProviderDataSet.Fields[i].FieldName;
    end;

    if MemRec.UpdateStatus in [usModified, usDeleted] then
    begin
      vOldValues := MemRec.DataValues[UsedKeyFields, dvvOldestValue];
      KeyFound := ProviderDataSet.Locate(UsedKeyFields, vOldValues, []);
      if KeyFound then
      begin
        if (DataSetCompareBookmarks(ProviderDataSet,
          ProviderDataSet.Bookmark, Bookmark) = 0) and
          (MemRec.UpdateStatus = usDeleted)
        then // Will not go to the deleted bookmark
          Bookmark := NilBookmarkEh;
      end;
    end else
      KeyFound := True;

    if KeyFound then
    begin

      if MemRec.UpdateStatus = usModified then
        ProviderDataSet.Edit
      else if MemRec.UpdateStatus = usInserted then
        ProviderDataSet.Insert
      else
        ProviderDataSet.Delete;

      if MemRec.UpdateStatus in [usModified, usInserted] then
      begin
        try
          with MemRec do
            for i := 0 to DataStruct.Count-1 do
            begin
              ProviderField := ProviderDataSet.FindField(DataStruct[i].FieldName);
              if Assigned(ProviderField) and not ProviderField.ReadOnly then
                ProviderField.Value := Value[i, dvvValueEh];
            end;
          ProviderDataSet.Post;
        except
          on E: EDatabaseError do
          begin
            if ProviderDataSet.State in dsEditModes then
              ProviderDataSet.Cancel;
            raise;
          end;
        end;
//        if RefreshRecord then
//        begin
          MemRec.Edit;
          for i := 0 to MemRec.DataStruct.Count-1 do
            begin
              ProviderField := ProviderDataSet.FindField(MemRec.DataStruct[i].FieldName);
              if Assigned(ProviderField) and not ProviderField.ReadOnly then
                MemRec.Value[i, dvvValueEh] := ProviderField.Value;
            end;
          MemRec.Post;
//        end;
      end;

      Result := 1;
    end;
    finally
      if (Bookmark <> NilBookmarkEh) and DataSetBookmarkValid(ProviderDataSet, Bookmark) then
        ProviderDataSet.Bookmark := Bookmark;
    end;

//    MemRec.MergeChanges;
  end;
end;

procedure TDataDriverEh.ConsumerClosed(ConsumerDataSet: TDataSet);
begin
  if (ProviderDataSet <> nil) then
    ProviderDataSet.Close;
  ProviderEOF := True;
end;

function TDataDriverEh.RefreshReaderParamsFromCursor(DataSet: TDataSet): Boolean;
var
  FParams: TParams;
  Field: TField;
  I: Integer;
begin
  Result := False;
  FParams := nil;
{$IFDEF EH_LIB_5}
  if (ProviderDataSet <> nil) then
    FParams := IProviderSupport(ProviderDataSet).PSGetParams();
  if FParams <> nil then
    for I := 0 to FParams.Count - 1 do
    begin
      Field := DataSet.FindField(FParams[I].Name);
      if (Field <> nil) and not VarEquals(Field.Value, FParams[I].Value) then
      begin
        Result := True;
        Break;
      end;
    end;
{$ENDIF}
end;

procedure TDataDriverEh.SetReaderParamsFromCursor(DataSet: TDataSet);
var
  I: Integer;
  FParams: TParams;
begin
  FParams := nil;
{$IFDEF EH_LIB_5}
  if (ProviderDataSet <> nil) then
    FParams := IProviderSupport(ProviderDataSet).PSGetParams();
  if FParams <> nil then
  begin
    DataSet.FieldDefs.Update;
    for I := 0 to FParams.Count - 1 do
      with FParams[I] do
        if not Bound then
        begin
          AssignField(DataSet.FieldByName(Name));
          Bound := False;
        end;
  end;
{$ENDIF}
end;

procedure TDataDriverEh.BuildDataStruct(DataStruct: TMTDataStructEh);
var
  DS: TDataSet;
begin
  if Assigned(FOnBuildDataStruct) then
    OnBuildDataStruct(Self, DataStruct)
  else if Assigned(FOnProduceDataReader) then
  begin
    DS := GetDataReader;
    DataStruct.BuildStructFromFields(DS.Fields);
  end else
    DefaultBuildDataStruct(DataStruct);
end;

procedure TDataDriverEh.DefaultBuildDataStruct(DataStruct: TMTDataStructEh);
begin
  if (ReaderDataSet <> nil) then
  begin
    DataStruct.BuildStructFromFields(ReaderDataSet.Fields);
    SetAutoIncFields(ReaderDataSet.Fields, DataStruct);
  end else if (ProviderDataSet <> nil) then
  begin
    if ProviderDataSet.FieldCount > 0 then
      DataStruct.BuildStructFromFields(ProviderDataSet.Fields)
    else
    begin
      ProviderDataSet.Active := True;
      DataStruct.BuildStructFromFields(ProviderDataSet.Fields);
      ProviderDataSet.Active := False;
    end;
    SetAutoIncFields(ProviderDataSet.Fields, DataStruct);
  end;
end;

procedure TDataDriverEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FProviderDataSet then
      ProviderDataSet := nil;
  end;
end;

function TDataDriverEh.GetDataReader: TDataSet;
begin
  if FReaderDataSet <> nil then
    Result := FReaderDataSet
  else
  begin
    FReaderDataSetFreeOnEof := False;
    ProviderEOF := False;
    if Assigned(FOnProduceDataReader) then
      OnProduceDataReader(Self, FReaderDataSet, FReaderDataSetFreeOnEof)
    else
      DefaultProduceDataReader(FReaderDataSet, FReaderDataSetFreeOnEof);
    Result := FReaderDataSet;
  end;
end;

procedure TDataDriverEh.DefaultProduceDataReader(var DataSet: TDataSet; var FreeOnEof: Boolean);
begin
  if (ProviderDataSet <> nil) then
  begin
    ProviderDataSet.Active := True;
    ProviderDataSet.First;
    FreeOnEof := False;
    DataSet := ProviderDataSet;
  end;
end;

function TDataDriverEh.ReadData(MemTableData: TMemTableDataEh; Count: Integer): Integer;
var
  Rec: TMemoryRecordEh;
  AProviderEOF: Boolean;
begin
  Result := 0;
  if ProviderEOF = True then Exit;
  while Count <> 0 do
  begin
    Rec := MemTableData.RecordsList.NewRecord;
    try
      if Assigned(OnReadRecord)
        then OnReadRecord(Self, MemTableData, Rec, AProviderEOF)
        else DefaultReadRecord(MemTableData, Rec, AProviderEOF);
    except
      Rec.Free;
      raise;
    end;
    ProviderEOF := AProviderEOF;
    if ProviderEOF
      then Rec.Free
      else MemTableData.RecordsList.FetchRecord(Rec);

    Inc(Result);
    if ProviderEOF then Exit;
    Dec(Count);
  end;
end;

procedure TDataDriverEh.DefaultReadRecord(MemTableData: TMemTableDataEh;
  Rec: TMemoryRecordEh; var ProviderEOF: Boolean);
var
  i: Integer;
begin
  ProviderEOF := False;
  if (ReaderDataSet = nil) or
   ((ReaderDataSet <> nil) and not ReaderDataSet.Active) or
   ((ReaderDataSet <> nil) and ReaderDataSet.Active and ReaderDataSet.Eof)
  then
    ProviderEOF := True;
  if (ReaderDataSet = nil) or (ProviderEOF = True) then
    Exit;

  for i := 0 to Rec.DataStruct.Count-1 do
    AssignFieldValue(MemTableData, Rec, i, dvvValueEh, ReaderDataSet);

  ReaderDataSet.Next;
end;

procedure TDataDriverEh.AssignFieldValue(MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; DataFieldIndex: Integer;
  DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet);
begin
  if Assigned(OnAssignFieldValue)
    then OnAssignFieldValue(Self, MemTableData, MemRec, DataFieldIndex, DataValueVersion, ReaderDataSet)
    else DefaultAssignFieldValue(MemTableData, MemRec, DataFieldIndex, DataValueVersion, ReaderDataSet);
end;

procedure TDataDriverEh.DefaultAssignFieldValue(MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; DataFieldIndex: Integer;
  DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet);
var
  Field: TField;
begin
  Field := ReaderDataSet.FindField(MemRec.DataStruct[DataFieldIndex].FieldName);
  if Field <> nil then
    MemRec.Value[DataFieldIndex, DataValueVersion] := Field.Value;
end;

procedure TDataDriverEh.DefaultRefreshRecord(MemRecord: TMemoryRecordEh);
var
  vValues: Variant;
  i: Integer;
  KeyFound: Boolean;
  Bookmark: TUniBookmarkEh;
//  DeltaDataSet: TMemTableDataEh;
//  DeltaRec: TMemoryRecordEh;
begin
  if (ProviderDataSet <> nil) then
  begin
//    DeltaDataSet := CreateDeltaData;
//    DeltaDataSet.DataStruct.Assign(MemRecord.DataStruct);
    try

//      DeltaRec := DeltaDataSet.RecordsList.NewRecord;

      Bookmark := ProviderDataSet.Bookmark;
      try

        if MemRecord.UpdateStatus = usModified
          then vValues := MemRecord.DataValues[KeyFields, dvvOldValueEh]
          else vValues := MemRecord.DataValues[KeyFields, dvvValueEh];
        KeyFound := ProviderDataSet.Locate(KeyFields, vValues, []);

        if KeyFound then
//          for i := 0 to DeltaDataSet.DataStruct.Count-1 do
//            DeltaRec.Value[i, dvtValueEh] :=
            for i := 0 to MemRecord.DataStruct.Count-1 do
              AssignFieldValue(MemRecord.DataStruct.MemTableData, MemRecord, i,
                dvvRefreshValue, ReaderDataSet)
        else
          raise Exception.Create('Key is not found in ProviderDataSet');

      finally
        if (Bookmark <> NilBookmarkEh) and DataSetBookmarkValid(ProviderDataSet, Bookmark) then
          ProviderDataSet.Bookmark := Bookmark;
      end;

//      MemRecord.RefreshRecord(DeltaRec);

    finally
//      DeltaDataSet.Free;
    end;
//    Resync([]);
  end;
end;

procedure TDataDriverEh.RefreshRecord(MemRecord: TMemoryRecordEh);
begin
  if Assigned(OnRefreshRecord)
    then OnRefreshRecord(Self, MemRecord.DataStruct.MemTableData, MemRecord)
    else DefaultRefreshRecord(MemRecord);
end;

procedure TDataDriverEh.SetKeyFields(const Value: String);
begin
  FKeyFields := Value;
end;

procedure TDataDriverEh.SetProviderDataSet(const Value: TDataSet);
var
  Msg: TCMChanged;
begin
  if Value <> FProviderDataSet then
  begin
    FProviderDataSet := Value;
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

{
function TDataDriverEh.GetReaderDataSet: TDataSet;
begin
  Result := ProviderDataSet;
end;
}

procedure TDataDriverEh.SetProviderEOF(const Value: Boolean);
begin
  if FProviderEOF <> Value then
  begin
    FProviderEOF := Value;
    if FProviderEOF and (FReaderDataSet <> nil) and FReaderDataSetFreeOnEof then
    begin
      FReaderDataSet.Free;
      FReaderDataSetFreeOnEof := False;
    end;
    FReaderDataSet := nil;
  end;
end;

procedure TDataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
begin
end;

function TDataDriverEh.GetDataDriverConsumer: TObject;
begin
  Result := FDataDriverConsumer;
end;

procedure TDataDriverEh.SetDataDriverConsumer(ADataDriverConsumer: TObject);
begin
  FDataDriverConsumer := ADataDriverConsumer;
end;

{ TCustomSQLCommandEh }

constructor TCustomSQLCommandEh.Create(ADataDriver: TCustomSQLDataDriverEh);
begin
  inherited Create;
  FDataDriver := ADataDriver;
  FCommandText := TStringList.Create;
  TStringList(FCommandText).OnChange := CommandTextChanged;
end;

destructor TCustomSQLCommandEh.Destroy;
begin
  FreeAndNil(FCommandText);
  inherited Destroy;
end;

function TCustomSQLCommandEh.GetCommandText: TStrings;
begin
  Result := FCommandText;
end;

procedure TCustomSQLCommandEh.SetCommandText(const Value: TStrings);
begin
  FCommandText.Assign(Value);
end;

function TCustomSQLCommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  Processed: Boolean;
begin
  Processed := False;
  Result := -1;
  Cursor := nil;
  if DefaultSQLDataDriverResolver <> nil then
    Result := DefaultSQLDataDriverResolver.ExecuteCommand(DataDriver, Self, Cursor, FreeOnEof, Processed);
end;

procedure TCustomSQLCommandEh.CommandTextChanged(Sender: TObject);
begin
  if (DataDriver <> nil) then
    DataDriver.CommandTextChanged(Self);
end;

procedure TCustomSQLCommandEh.CommandTypeChanged;
begin
end;

function TCustomSQLCommandEh.GetCommandType: TSQLCommandTypeEh;
begin
  Result := FCommandType;
end;

procedure TCustomSQLCommandEh.SetCommandType(const Value: TSQLCommandTypeEh);
begin
  FCommandType := Value;
end;

procedure TCustomSQLCommandEh.RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh);
begin
end;

function TCustomSQLCommandEh.GetOwner: TPersistent;
begin
  Result := FDataDriver;
end;

function TCustomSQLCommandEh.GetNamePath: String;
begin
  Result := 'SQLCommand';
end;

function TCustomSQLCommandEh.IsCommandTypeStored: Boolean;
begin
  Result := (FCommandType <> DefaultCommandType);
end;

function TCustomSQLCommandEh.DefaultCommandType: TSQLCommandTypeEh;
begin
  Result := DataDriver.GetDefaultCommandTypeFor(Self);
end;

procedure TCustomSQLCommandEh.Assign(Source: TPersistent);
begin
  if Source is TCustomSQLCommandEh then
    with (Source as TCustomSQLCommandEh) do
    begin
      Self.CommandText := CommandText;
      Self.CommandType := CommandType;
    end;
end;

{procedure TCustomSQLCommandEh.AssignParams(AParams: TParams);
begin
end;

procedure TCustomSQLCommandEh.AssignToParams(AParams: TParams);
begin
end;}

function TCustomSQLCommandEh.GetParams: TParams;
begin
  Result := nil;
end;

procedure TCustomSQLCommandEh.SetParams(AParams: TParams);
begin
end;

{procedure TCustomSQLCommandEh.SetDynamicSQL(const Value: Boolean);
begin
  FDynamicSQL := Value;
end;
}

{ TBaseSQLCommandEh }

constructor TBaseSQLCommandEh.Create(ADataDriver: TBaseSQLDataDriverEh);
begin
  inherited Create(ADataDriver);
  FParams := TParams.Create(Self);
  FParamCheck := True;
end;

destructor TBaseSQLCommandEh.Destroy;
begin
  FreeAndNil(FParams);
  inherited Destroy;
end;

procedure TBaseSQLCommandEh.RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh);
var
  I: Integer;
begin
  for I := 0 to Params.Count - 1 do
  begin
    if Assigned(OnAssignParam)
      then OnAssignParam(Self, MemRecord, DataValueVersion, Params[I])
      else DefaultRefreshParam(MemRecord, DataValueVersion, Params[I]);
  end;
end;

procedure TBaseSQLCommandEh.DefaultRefreshParam(MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Param: TParam);
begin
  DataDriver.AssignCommandParam(Self, MemRecord, DataValueVersion, Param);
end;

function TBaseSQLCommandEh.GetParamCheck: Boolean;
begin
  Result := FParamCheck;
end;

procedure TBaseSQLCommandEh.SetParamCheck(const Value: Boolean);
begin
  FParamCheck := Value;
end;

procedure TBaseSQLCommandEh.SetParams(AParams: TParams);
begin
  if FParams <> AParams then
    FParams.Assign(AParams);
end;

function TBaseSQLCommandEh.GetParams: TParams;
begin
  Result := FParams;
end;

procedure TBaseSQLCommandEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TBaseSQLCommandEh then
    with (Source as TBaseSQLCommandEh) do
    begin
      Self.ParamCheck := ParamCheck;
      Self.Params := Params;
    end
  else if Source is TCustomSQLCommandEh then
    with (Source as TCustomSQLCommandEh) do
    begin
      Self.ParamCheck := ParamCheck;
      Self.Params.Assign(GetParams);
    end
end;

procedure TBaseSQLCommandEh.CommandTextChanged(Sender: TObject);
var
  List: TParams;
begin
  inherited CommandTextChanged(Sender);
  if not (csReading in DataDriver.ComponentState) then
//    if ParamCheck then
//      Params.ParseSQL(CommandText.Text, True);
    if ParamCheck or (csDesigning in DataDriver.ComponentState) then
    begin
      List := TParams.Create(Self);
      try
        List.ParseSQL(CommandText.Text, True);
        List.AssignValues(Params);
        Params.Clear;
        Params.Assign(List);
      finally
        List.Free;
      end;
    end;
end;

function TBaseSQLCommandEh.GetDataDriver: TBaseSQLDataDriverEh;
begin
  Result := TBaseSQLDataDriverEh(inherited DataDriver);
end;

{procedure TBaseSQLCommandEh.AssignParams(AParams: TParams);
begin
  Params := AParams;
end;

procedure TBaseSQLCommandEh.AssignToParams(AParams: TParams);
begin
  AParams.Assign(Params);
end;}

{ TCustomSQLDataDriverEh }

constructor TCustomSQLDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSelectCommand := CreateSelectCommand;
  FSelectCommand.FCommandType := GetDefaultCommandTypeFor(FSelectCommand);
  FUpdateCommand := CreateUpdateCommand;
  FUpdateCommand.FCommandType := GetDefaultCommandTypeFor(FUpdateCommand);
  FInsertCommand := CreateInsertCommand;
  FInsertCommand.FCommandType := GetDefaultCommandTypeFor(FInsertCommand);
  FDeleteCommand := CreateDeleteCommand;
  FDeleteCommand.FCommandType := GetDefaultCommandTypeFor(FDeleteCommand);
  FGetrecCommand := CreateGetrecCommand;
  FGetrecCommand.FCommandType := GetDefaultCommandTypeFor(FGetrecCommand);
  FSpecParams := TStringList.Create;
  ResolveToDataSet := False;
  FServiceCommand := CreateCommand;
  FDynaSQLParams := TDynaSQLParamsEh.Create(Self);
end;

destructor TCustomSQLDataDriverEh.Destroy;
begin
  FreeAndNil(FDynaSQLParams);
  FreeAndNil(FSelectCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FGetrecCommand);
  FreeAndNil(FServiceCommand);
  FDesignDataBase := nil;
  FreeAndNil(FSpecParams);
  inherited Destroy;
end;

procedure TCustomSQLDataDriverEh.SetSelectCommand(const Value: TCustomSQLCommandEh);
begin
  FSelectCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetDeleteCommand(const Value: TCustomSQLCommandEh);
begin
  FDeleteCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetInsertCommand(const Value: TCustomSQLCommandEh);
begin
  FInsertCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetGetrecCommand(const Value: TCustomSQLCommandEh);
begin
  FGetrecCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetUpdateCommand(const Value: TCustomSQLCommandEh);
begin
  FUpdateCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.DefaultProduceDataReader(var DataSet: TDataSet; var FreeOnEof: Boolean);
begin
  if ProviderDataSet <> nil
    then inherited DefaultProduceDataReader(DataSet, FreeOnEof)
    else ExecuteCommand(SelectCommand, DataSet, FreeOnEof);
end;

procedure TCustomSQLDataDriverEh.DefaultBuildDataStruct(DataStruct: TMTDataStructEh);
var
  AReaderDS: TDataSet;
  AFreeOnEof: Boolean;
begin
  if (ReaderDataSet <> nil) or (ProviderDataSet <> nil) then
    inherited DefaultBuildDataStruct(DataStruct)
  else
  begin
//    if AReaderDS = nil then
      ExecuteCommand(SelectCommand, AReaderDS, AFreeOnEof);
    if AReaderDS = nil then
      raise Exception.Create('SelectCommand.Execute does not get DataSet');
    AReaderDS.Active := True;
    DataStruct.BuildStructFromFields(AReaderDS.Fields);
    AReaderDS.Active := False;
    if AFreeOnEof then
      AReaderDS.Free;
  end;
end;

function TCustomSQLDataDriverEh.DefaultExecuteCommand(Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  Processed: Boolean;
  DesignDataBaseIntf: IDesignDataBaseEh;
begin
//  ShowMessage('DefaultExecuteCommand 1');

  { TODO : Is it valid technology? }
  if HaveDataConnection then
    Result := Command.Execute(Cursor, FreeOnEof)
  else
  begin
//    ShowMessage('DefaultExecuteCommand 2');
    Result := -1;
    Processed := False;
    if (csDesigning in ComponentState) and
       (GetDesignDataBase <> nil) and
       (Supports(DesignDataBase, IDesignDataBaseEh, DesignDataBaseIntf)) then
    begin
      DesignDataBaseIntf.Execute(Command, Cursor, FreeOnEof);
      Processed := True;
    end else
    begin
      if Assigned(FDefaultSQLDataDriverResolver) then
        Result := FDefaultSQLDataDriverResolver.ExecuteCommand(Self, Command, Cursor, FreeOnEof, Processed);
      if not Processed then
        Result := Command.Execute(Cursor, FreeOnEof);
    end;
  end;
end;

function TCustomSQLDataDriverEh.ExecuteCommand(Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  if Assigned(OnExecuteCommand)
    then Result := OnExecuteCommand(Self, Command, Cursor, FreeOnEof)
    else Result := DefaultExecuteCommand(Command, Cursor, FreeOnEof);
end;

procedure TCustomSQLDataDriverEh.DefaultRefreshRecord(MemRecord: TMemoryRecordEh);
var
  i: Integer;
  RecDataSet: TDataSet;
  AFreeOnEof: Boolean;
begin
  if ResolveToDataSet then
    inherited RefreshRecord(MemRecord)
  else
  begin
    GetrecCommand.RefreshParams(MemRecord, dvvOldestValue);
    ExecuteCommand(GetrecCommand, RecDataSet, AFreeOnEof);
    try
      if RecDataSet.IsEmpty then
        raise Exception.Create('There are no fresh record on server');

      for i := 0 to MemRecord.DataStruct.Count-1 do
        AssignFieldValue(MemRecord.DataStruct.MemTableData, MemRecord, i,
          dvvOldestValue, RecDataSet)
{      begin
        Field := RecDataSet.FindField(MemRecord.DataStruct[i].FieldName);
        if Field <> nil then
          MemRecord.Value[i, dvtOldestValue] := Field.Value;
      end;}

    finally
      if AFreeOnEof then
        RecDataSet.Free;
    end;
  end;
end;

function TCustomSQLDataDriverEh.DoUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer;
var
  Command: TCustomSQLCommandEh;
  ResDataSet: TDataSet;
  AFreeOnEof: Boolean;
begin
  Result := 0;
  if ResolveToDataSet then
    Result := inherited DefaultUpdateRecord(MemTableData, MemRec)
  else
  begin
    Command := nil;
    if  ((MemRec.UpdateStatus = usModified) and (dsoDynamicSQLUpdateEh in DynaSQLParams.Options))
     or ((MemRec.UpdateStatus = usInserted) and (dsoDynamicSQLInsertEh in DynaSQLParams.Options))
     or ((MemRec.UpdateStatus = usDeleted) and (dsoDynamicSQLDeleteEh in DynaSQLParams.Options)) then
    begin
      GenerateDynamicSQLCommand(MemRec, ServiceCommand);
      if ServiceCommand.CommandText.Text <> '' then
        Command := ServiceCommand;
    end else
      case MemRec.UpdateStatus of
        usModified: Command := UpdateCommand;
        usInserted: Command := InsertCommand;
        usDeleted: Command := DeleteCommand;
      end;
    if Command = nil then Exit;
    Command.RefreshParams(MemRec, dvvValueEh);
    Result := ExecuteCommand(Command, ResDataSet, AFreeOnEof);
    GetBackUpdatedValues(MemRec, Command, ResDataSet);
    if AFreeOnEof then
      ResDataSet.Free;
//    MemRec.MergeChanges;
  end
end;

function TCustomSQLDataDriverEh.DefaultUpdateRecord(MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh): Integer;
var
  Processed: Boolean;
begin
  Result := 0;
  Processed := False;
  if Assigned(FDefaultSQLDataDriverResolver) then
    FDefaultSQLDataDriverResolver.UpdateRecord(Self, MemTableData, MemRec, Processed);
  if not Processed then
  begin
    if InternalGetServerSpecOperations <> nil
      then Result := InternalGetServerSpecOperations.UpdateRecord(Self, MemTableData, MemRec)
      else Result := DoUpdateRecord(MemTableData, MemRec);
  end;
end;

procedure TCustomSQLDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  if Assigned(FOnGetBackUpdatedValues)
    then OnGetBackUpdatedValues(Self, MemRec, Command, ResDataSet)
    else DefaultGetUpdatedServerValues(MemRec, Command, ResDataSet);
end;

procedure TCustomSQLDataDriverEh.DefaultGetUpdatedServerValues(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
var
  Processed: Boolean;
begin
  Processed := False;
  if Assigned(FDefaultSQLDataDriverResolver) then
    FDefaultSQLDataDriverResolver.GetBackUpdatedValues(Self, MemRec, Command, ResDataSet, Processed);
  if not Processed and (InternalGetServerSpecOperations <> nil) then
    InternalGetServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
end;

function TCustomSQLDataDriverEh.CreateDeleteCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

function TCustomSQLDataDriverEh.CreateInsertCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

function TCustomSQLDataDriverEh.CreateSelectCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

function TCustomSQLDataDriverEh.CreateGetrecCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

function TCustomSQLDataDriverEh.CreateUpdateCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

{
function TCustomSQLDataDriverEh.GetReaderDataSet: TDataSet;
begin
  if ProviderDataSet <> nil
    then Result := inherited GetReaderDataSet
    else Result := FReaderDataSet;
end;
}

function TCustomSQLDataDriverEh.GetDefaultCommandTypeFor(Command: TCustomSQLCommandEh): TSQLCommandTypeEh;
begin
  if (Command = SelectCommand) or (Command = GetrecCommand)
    then Result := cthSelectQuery
    else Result := cthUpdateQuery;
end;

procedure RegisterDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass;
  DesignDataBaseProc: TSetDesignDataBaseProcEh);
var
  ExistsIdx: Integer;
begin
  if DesignDataBuilderClasses = nil then
  begin
    DesignDataBuilderClasses := TList.Create;
    DesignDataBuilderProcs := TList.Create;
  end;
  ExistsIdx := DesignDataBuilderClasses.IndexOf(TObject(DataDriverClass));
  if ExistsIdx >= 0 then
    DesignDataBuilderProcs[ExistsIdx] := @DesignDataBaseProc
  else
  begin
    DesignDataBuilderClasses.Add(TObject(DataDriverClass));
    DesignDataBuilderProcs.Add(@DesignDataBaseProc);
  end;
end;

procedure UnregisterDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass);
var
  ExistsIdx: Integer;
begin
  if DesignDataBuilderClasses = nil then Exit;
  ExistsIdx := DesignDataBuilderClasses.IndexOf(TObject(DataDriverClass));
  if ExistsIdx >= 0 then
  begin
    DesignDataBuilderClasses.Delete(ExistsIdx);
    DesignDataBuilderProcs.Delete(ExistsIdx);
  end;
end;

function GetDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass):
  TSetDesignDataBaseProcEh;

  function GetDatasetFeaturesDeep(ARootClass, AClass: TClass): Integer;
  begin
    Result := 0;
    while True do
    begin
      if ARootClass = AClass then
        Exit;
      Inc(Result);
      AClass := AClass.ClassParent;
      if AClass = nil then
      begin
        Result := MAXINT;
        Exit;
      end;
    end;
  end;

var
  Deep, MeenDeep, i: Integer;
  TargetClass: TSQLDataDriverEhClass;
begin
  Result := nil;
  if DesignDataBuilderClasses = nil then Exit;
  MeenDeep := MAXINT;
  for i := 0 to DesignDataBuilderClasses.Count - 1 do
  begin
    if DataDriverClass.InheritsFrom(TSQLDataDriverEhClass(DesignDataBuilderClasses[i])) then
    begin
      TargetClass := TSQLDataDriverEhClass(DesignDataBuilderClasses[i]);
      Deep := GetDatasetFeaturesDeep(TargetClass, DataDriverClass);
      if Deep < MeenDeep then
      begin
        MeenDeep := Deep;
        Result := TSetDesignDataBaseProcEh(DesignDataBuilderProcs[i]);
      end;
    end;
  end;
end;

function TCustomSQLDataDriverEh.CreateDesignDataBase: TComponent;
begin
  Result := nil;
end;

procedure TCustomSQLDataDriverEh.AssignFromDesignDriver(DesignDataDriver: TCustomSQLDataDriverEh);
begin
  SelectCommand := DesignDataDriver.SelectCommand;
  UpdateCommand := DesignDataDriver.UpdateCommand;
  InsertCommand := DesignDataDriver.InsertCommand;
  DeleteCommand := DesignDataDriver.DeleteCommand;
  GetrecCommand := DesignDataDriver.GetrecCommand;
end;

function TCustomSQLDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TCustomSQLDataDriverEh.Create(nil);
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
end;


function TCustomSQLDataDriverEh.GetSelectSQL: TStrings;
begin
  Result := SelectCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetSelectSQL(const Value: TStrings);
begin
  SelectCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.GetDeleteSQL: TStrings;
begin
  Result := DeleteCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetDeleteSQL(const Value: TStrings);
begin
  DeleteCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.GetGetrecSQL: TStrings;
begin
  Result := GetrecCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetGetrecSQL(const Value: TStrings);
begin
  GetrecCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.GetInsertSQL: TStrings;
begin
  Result := InsertCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetInsertSQL(const Value: TStrings);
begin
  InsertCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.GetUpdateSQL: TStrings;
begin
  Result := UpdateCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetUpdateSQL(const Value: TStrings);
begin
  UpdateCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.GetDesignDataBase: TComponent;
var
  SetBaseProc: TSetDesignDataBaseProcEh;
begin
  Result := nil;
  SetBaseProc := GetDesignDataBuilderProcEh(TSQLDataDriverEhClass(ClassType));
  if @SetBaseProc = nil then Exit;
  SetBaseProc(Self);
  Result := FDesignDataBase;
end;

procedure TCustomSQLDataDriverEh.SetDesignDataBase(const Value: TComponent);
begin
  if FDesignDataBase <> Value then
  begin
    FDesignDataBase := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TCustomSQLDataDriverEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FDesignDataBase = AComponent)
  then
    FDesignDataBase := nil;
end;

function TCustomSQLDataDriverEh.RefreshReaderParamsFromCursor(DataSet: TDataSet): Boolean;
var
  FParams: TParams;
  Field: TField;
  I: Integer;
begin
  if (ProviderDataSet <> nil) then
    Result := inherited RefreshReaderParamsFromCursor(DataSet)
  else
  begin
    Result := False;
    FParams := SelectCommand.GetParams;
    if FParams <> nil then
      for I := 0 to FParams.Count - 1 do
      begin
        Field := DataSet.FindField(FParams[I].Name);
        if (Field <> nil) and not VarEquals(Field.Value, FParams[I].Value) then
        begin
          Result := True;
          Break;
        end;
      end;
  end;
end;

procedure TCustomSQLDataDriverEh.SetReaderParamsFromCursor(DataSet: TDataSet);
var
  I: Integer;
  FParams: TParams;
begin
  if (ProviderDataSet <> nil) then
    inherited SetReaderParamsFromCursor(DataSet)
  else
  begin
    FParams := SelectCommand.GetParams;
    if FParams <> nil then
    begin
      DataSet.FieldDefs.Update;
      for I := 0 to FParams.Count - 1 do
        with FParams[I] do
        begin
//          if not Bound then
//          begin
            AssignField(DataSet.FieldByName(Name));
            Bound := False;
//          end;
        end;
    end;
    SelectCommand.SetParams(FParams);
  end;
end;

procedure TCustomSQLDataDriverEh.SetSpecParams(const Value: TStrings);
begin
  FSpecParams.Assign(Value);
end;

function TCustomSQLDataDriverEh.HaveDataConnection: Boolean;
begin
  Result := False;
end;

function TCustomSQLDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TCustomSQLCommandEh.Create(Self);
end;

procedure TCustomSQLDataDriverEh.SetServiceCommand(
  const Value: TCustomSQLCommandEh);
begin
  FServiceCommand := Value;
end;

procedure TCustomSQLDataDriverEh.UpdateServerService;
begin

end;

procedure TCustomSQLDataDriverEh.SetDynaSQLParams(const Value: TDynaSQLParamsEh);
begin
  FDynaSQLParams.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetServerSpecOperations(const Value: TServerSpecOperationsEh);
begin
  FServerSpecOperations := Value;
end;

procedure TCustomSQLDataDriverEh.GenerateDynamicSQLCommand(
  MemRecord: TMemoryRecordEh; Command: TCustomSQLCommandEh);
begin
  if (InternalGetServerSpecOperations <> nil) then
    InternalGetServerSpecOperations.GenerateDynaSQLCommand(MemRecord, Command)
  else if Assigned(DefaultSQLDataDriverResolver.ServerSpecOperations) then
    DefaultSQLDataDriverResolver.ServerSpecOperations.GenerateDynaSQLCommand(MemRecord, Command)
  else
    AnsiServerSpecOperations.GenerateDynaSQLCommand(MemRecord, Command);
end;

function TCustomSQLDataDriverEh.InternalGetServerSpecOperations: TServerSpecOperationsEh;
begin
  Result := ServerSpecOperations;   
end;

procedure TCustomSQLDataDriverEh.SetAutoIncFields(Fields: TFields;
  DataStruct: TMTDataStructEh);
var
  AutoIncFieldName: String;
  AutoIncField: TMTDataFieldEh;
begin
  AutoIncFieldName := SpecParams.Values['AUTO_INCREMENT_FIELD'];
  AutoIncField := nil;
  if AutoIncFieldName <> '' then
    AutoIncField := DataStruct.FindField(AutoIncFieldName);
  if (AutoIncField <> nil) and (AutoIncField is TMTNumericDataFieldEh) then
//    TMTNumericDataFieldEh(AutoIncField).NumericDataType := fdtAutoIncEh;
    TMTNumericDataFieldEh(AutoIncField).AutoIncrement := True;
end;

procedure TCustomSQLDataDriverEh.CommandTextChanged(Sender: TCustomSQLCommandEh);
begin
  if (Sender = SelectCommand) and
     (FDataDriverConsumer <> nil) and
     (FDataDriverConsumer is TCustomMemTableEh)
  then
    (FDataDriverConsumer as TCustomMemTableEh).DriverStructChanged;
end;

{ TBaseSQLDataDriverEh }

procedure TBaseSQLDataDriverEh.AssignCommandParam(
  Command: TBaseSQLCommandEh; MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Param: TParam);
begin
  if Assigned(OnAssignCommandParam)
    then OnAssignCommandParam(Self, Command, MemRecord, DataValueVersion, Param)
    else DefaultAssignCommandParam(Command, MemRecord, DataValueVersion, Param);
end;

function TBaseSQLDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TBaseSQLCommandEh.Create(Self);
end;

procedure TBaseSQLDataDriverEh.DefaultAssignCommandParam(
  Command: TBaseSQLCommandEh; MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Param: TParam);
var
  FIndex: Integer;
begin
  FIndex := MemRecord.DataStruct.FieldIndex(Param.Name);
  if FIndex >= 0 then
  begin
    { TODO : Check DataType as in TParam.AssignFieldValue }
    if Command.ParamCheck then
      Param.DataType := MemRecord.DataStruct[FIndex].DataType;
    Param.Value := MemRecord.DataValues[Param.Name, DataValueVersion];
  end
  else if (UpperCase(Copy(Param.Name,1, Length('OLD_'))) = 'OLD_') then
  begin
    FIndex := MemRecord.DataStruct.FieldIndex(Copy(Param.Name, 5, 255));
    if FIndex >= 0 then
    begin
      if Command.ParamCheck then
        Param.DataType := MemRecord.DataStruct[FIndex].DataType;
      Param.Value := MemRecord.DataValues[Copy(Param.Name, 5, 255), dvvOldestValue];
    end
  end;
end;


procedure TBaseSQLDataDriverEh.DefaultGetUpdatedServerValues(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh;
  ResDataSet: TDataSet);
var
  i: Integer;
  DataField: TMTDataFieldEh;
  ACommand: TBaseSQLCommandEh;
begin
  inherited DefaultGetUpdatedServerValues(MemRec, Command, ResDataSet);
  ACommand := TBaseSQLCommandEh(Command);
  // Use params
  for i := 0 to ACommand.Params.Count-1 do
  begin
    DataField := nil;
    if ACommand.Params[i].ParamType in [ptOutput, ptInputOutput, ptResult] then
      DataField := MemRec.DataStruct.FindField(ACommand.Params[i].Name);
    if DataField <> nil then
    { TODO : Assign server values in future }
      MemRec.DataValues[ACommand.Params[i].Name, dvvValueEh] := ACommand.Params[i].Value;
  end;

  // Use result dataset
  if (ResDataSet <> nil) and not ResDataSet.IsEmpty then
    for i := 0 to ResDataSet.FieldCount-1 do
    begin
      DataField := MemRec.DataStruct.FindField(ResDataSet.Fields[i].FieldName);
      if DataField <> nil then
      { TODO : Assign server values in future }
        MemRec.DataValues[ResDataSet.Fields[i].FieldName, dvvValueEh] := ResDataSet.Fields[i].Value;
    end;
end;

procedure TBaseSQLDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  if Assigned(FOnGetBackUpdatedValues)
    then OnGetBackUpdatedValues(Self, MemRec, TBaseSQLCommandEh(Command), ResDataSet)
    else DefaultGetUpdatedServerValues(MemRec, Command, ResDataSet);
end;

function TBaseSQLDataDriverEh.GetDeleteCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited DeleteCommand);
end;

procedure TBaseSQLDataDriverEh.SetDeleteCommand(const Value: TBaseSQLCommandEh);
begin
  inherited DeleteCommand := Value;
end;

function TBaseSQLDataDriverEh.GetInsertCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited InsertCommand);
end;

procedure TBaseSQLDataDriverEh.SetInsertCommand(const Value: TBaseSQLCommandEh);
begin
  inherited InsertCommand := Value;
end;

function TBaseSQLDataDriverEh.GetSelectCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited SelectCommand);
end;

procedure TBaseSQLDataDriverEh.SetSelectCommand(const Value: TBaseSQLCommandEh);
begin
  inherited SelectCommand := Value;
end;

function TBaseSQLDataDriverEh.GetGetrecCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited GetrecCommand);
end;

procedure TBaseSQLDataDriverEh.SetGetrecCommand(const Value: TBaseSQLCommandEh);
begin
  inherited GetrecCommand := Value;
end;

function TBaseSQLDataDriverEh.GetUpdateCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited UpdateCommand);
end;

procedure TBaseSQLDataDriverEh.SetUpdateCommand(const Value: TBaseSQLCommandEh);
begin
  inherited UpdateCommand := Value;
end;

function TBaseSQLDataDriverEh.ExecuteCommand(Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  if Assigned(OnExecuteCommand)
    then Result := OnExecuteCommand(Self, TBaseSQLCommandEh(Command), Cursor, FreeOnEof)
    else Result := DefaultExecuteCommand(Command, Cursor, FreeOnEof);
end;

{ TSQLDataDriverEh }

function TSQLDataDriverEh.CreateDeleteCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.CreateGetrecCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.CreateInsertCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.CreateSelectCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.CreateUpdateCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

{ TSQLDataDriverResolver }

procedure TSQLDataDriverResolver.DefaultGetUpdatedServerValues(SQLDataDriver: TCustomSQLDataDriverEh;
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean);
begin
  if Assigned(ServerSpecOperations) then
  begin
    ServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end else if Assigned(SQLDataDriver.ServerSpecOperations) then
  begin
    SQLDataDriver.ServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end else if SQLDataDriver.InternalGetServerSpecOperations <> nil then
  begin
    SQLDataDriver.InternalGetServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end;
end;

function TSQLDataDriverResolver.ExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer;
begin
  Result := -1;
  if Assigned(OnExecuteCommand)
    then Result := OnExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed)
    else Processed := False;
end;

procedure TSQLDataDriverResolver.GetBackUpdatedValues(SQLDataDriver: TCustomSQLDataDriverEh;
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean);
begin
  if Assigned(FOnGetBackUpdatedValues)
    then OnGetBackUpdatedValues(SQLDataDriver, MemRec, Command, ResDataSet, Processed)
    else DefaultGetUpdatedServerValues(SQLDataDriver, MemRec, Command, ResDataSet, Processed);
end;

function TSQLDataDriverResolver.GetServerSpecOperations(
  var Processed: Boolean): TServerSpecOperationsEh;
begin
  Result := nil;
  if Assigned(OnGetServerSpecOperations) then
    Result := OnGetServerSpecOperations(Processed)
  else if Assigned(ServerSpecOperations) then
  begin
    Result := ServerSpecOperations;
    Processed := True;
  end;
end;

procedure TSQLDataDriverResolver.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; var Processed: Boolean);
begin
  if Assigned(FOnUpdateRecord) then
    FOnUpdateRecord(SQLDataDriver, MemTableData, MemRec, Processed);
  if not Processed then
    DefaultUpdateRecord(SQLDataDriver, MemTableData, MemRec, Processed);
end;

procedure TSQLDataDriverResolver.DefaultUpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; var Processed: Boolean);
begin
  if Assigned(ServerSpecOperations) then
    ServerSpecOperations.UpdateRecord(SQLDataDriver, MemTableData, MemRec)
  else if SQLDataDriver.InternalGetServerSpecOperations <> nil then
    SQLDataDriver.InternalGetServerSpecOperations.UpdateRecord(SQLDataDriver, MemTableData, MemRec)
  else
    SQLDataDriver.DoUpdateRecord(MemTableData, MemRec);
  Processed := True;
end;

{ TServerSpecOperationsEh }

procedure TServerSpecOperationsEh.GenerateDynaSQLCommand(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh);

var
  DynaSQLParams: TDynaSQLParamsEh;
  UpdateFieldList, KeyFieldList, ChangedFieldList, UFieldList: TStringList;
  Comma: String;
  I: Integer;
//  Params: TParams;

  procedure GenFieldList(const TabName, ParamChar, QuoteChar: String; IncludeInsertFields: Boolean);
  var
    L: string;
    I: integer;
    Comma: string;
  begin
    L := '  (';
    Comma := '';
    if IncludeInsertFields then
      for I := 0 to KeyFieldList.Count - 1 do
      begin
        L := Format('%s%s%s%s%s%s%4:s',
          [L, Comma, TabName, ParamChar, QuoteChar, KeyFieldList[I]]);
        if (Length(L) > 70) and (I <> KeyFieldList.Count - 1) then
        begin
          Command.CommandText.Add(L);
          L := '   ';
        end;
        Comma := ', ';
      end;
    for I := 0 to UFieldList.Count - 1 do
    begin
//      if I = UFieldList.Count - 1 then Comma := '';
      L := Format('%s%s%s%s%s%4:s%5:s',
        [L, Comma, TabName, ParamChar, QuoteChar, UFieldList[I]]);
      if (Length(L) > 70) and (I <> UFieldList.Count - 1) then
      begin
        Command.CommandText.Add(L);
        L := '   ';
      end;
      Comma := ', ';
    end;
    Command.CommandText.Add(L+')');
  end;

begin
  UpdateFieldList := nil;
  KeyFieldList := nil;
  ChangedFieldList := nil;
  Command.CommandType := cthUpdateQuery;
  try
    DynaSQLParams := Command.DataDriver.DynaSQLParams;
    UpdateFieldList := TStringList.Create;
    UpdateFieldList.CommaText := DynaSQLParams.UpdateFields;
    ChangedFieldList := TStringList.Create;
    if Command.DataDriver.DynaSQLParams.SkipUnchangedFields and
      (MemRec.UpdateStatus = usModified) then
    begin
      BuildChangedFieldList(MemRec, UpdateFieldList, ChangedFieldList);
      UFieldList := ChangedFieldList;
    end else
      UFieldList := UpdateFieldList;
    KeyFieldList := TStringList.Create;
    KeyFieldList.CommaText := DynaSQLParams.KeyFields;
    Command.CommandText.Clear;
    if MemRec.UpdateStatus = usInserted then
    begin
      Command.CommandText.Add(Format('insert into %s', [DynaSQLParams.UpdateTable]));
      GenFieldList('', '', '', True);
      Command.CommandText.Add('values');
      GenFieldList('', ':', '', True);
    end else if MemRec.UpdateStatus = usModified then
    begin
      if UFieldList.Count = 0 then
        Command.CommandText.Text := ''
      else
      begin
        Command.CommandText.Add(Format('update %s', [DynaSQLParams.UpdateTable]));
        Command.CommandText.Add('set');
        Comma := ',';
        for I := 0 to UFieldList.Count - 1 do
        begin
          if I = UFieldList.Count -1 then Comma := '';
          Command.CommandText.Add(Format(' %s = :%0:s%1:s', [UFieldList[I], Comma]));
        end;
        GenWhereClause(DynaSQLParams.KeyFields, Command.CommandText);
      end;
    end else if MemRec.UpdateStatus = usDeleted then
    begin
      Command.CommandText.Add(Format('delete from %s', [DynaSQLParams.UpdateTable]));
      GenWhereClause(DynaSQLParams.KeyFields, Command.CommandText);
    end;

{    Params := Command.GetParams;
    if Params <> nil then
    begin
      for I := 0 to Command.GetParams.Count - 1 do
      begin
        if Params[I].DataType = ftUnknown then
          Params[I].DataType := ftString;
      end;
      Command.SetParams(Params);
    end;}
  finally
    ChangedFieldList.Free;
    UpdateFieldList.Free;
    KeyFieldList.Free;
  end;
end;

procedure TServerSpecOperationsEh.GenerateInsertCommand(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh);
begin

end;

procedure TServerSpecOperationsEh.GenerateUpdateCommand(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh);
begin

end;

procedure TServerSpecOperationsEh.GenerateDeleteCommand(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh);
begin

end;

procedure TServerSpecOperationsEh.GenWhereClause(KeyFields: String; SQL: TStrings);
var
  FieldList: TStringList;
  I: Integer;
  FieldName, BindText: String;
begin
  FieldList := TStringList.Create;
  try
    FieldList.CommaText := KeyFields;
    if FieldList.Count > 0 then
    begin
      SQL.Add('where');
      for I := 0 to FieldList.Count - 1 do
      begin
        FieldName := FieldList[I];
        BindText := Format(' %s = :OLD_%0:s',
          [FieldName]);
        if I < FieldList.Count - 1 then
          BindText := Format('%s and',[BindText]);
        SQL.Add(BindText);
      end;
    end;
  finally
    FieldList.Free;
  end;
end;

procedure TServerSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  
end;

procedure TServerSpecOperationsEh.BuildChangedFieldList(
  MemRec: TMemoryRecordEh; UpdateFieldList, ChangedFieldList: TStringList);
var
  I, FieldIndex: Integer;
  FieldName: String;
begin
  ChangedFieldList.Clear;
  for I := 0 to UpdateFieldList.Count - 1 do
  begin
    FieldName := UpdateFieldList[I];
    FieldIndex := MemRec.DataStruct.FieldIndex(FieldName);
    if FieldIndex >= 0 then
    begin
      if not VarEquals(MemRec.Value[FieldIndex, dvvOldValueEh],
                   MemRec.Value[FieldIndex, dvvValueEh])
      then
        ChangedFieldList.Add(FieldName);
    end
    else
      raise Exception.Create('Invalid field name "' + FieldName + '"' +
        ' in field list "' + UpdateFieldList.CommaText + '"');
  end;
end;

function TServerSpecOperationsEh.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh): Integer;
begin
  Result := SQLDataDriver.DoUpdateRecord(MemTableData, MemRec);
end;

constructor TServerSpecOperationsEh.Create;
begin
  inherited Create;
  IncludeInsertFieldsInUpdateCommand := False;
end;

{ TOracleSpecOperationsEh }

procedure TOracleSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
(*const
  SEQSQL = 'SELECT %s.curval FROM dual';  {do not localize}
var
  Sequence, SequenceField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;*)
begin
(*  DataDriver := Command.DataDriver;
  if Command <> DataDriver.InsertCommand then Exit;
  Sequence := DataDriver.SpecParams.Values['SEQUENCE'];
  SequenceField := DataDriver.SpecParams.Values['SEQUENCE_FIELD'];
  if MemRec.DataStruct.FindField(SequenceField) = nil then
    SequenceField := '';
  ServiceCommand := DataDriver.ServiceCommand;
  if (Sequence <> '') and (SequenceField <> '') then
  begin
    ServiceCommand.CommandText.Text := Format(SEQSQL, [Sequence, 0]);
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      MemRec.DataValues[SequenceField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;*)
end;

function TOracleSpecOperationsEh.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh): Integer;

  function PromoteInterBaseGenerator: Variant;
  const
    SEQSQL = 'SELECT %s.curval FROM dual';  {do not localize}
  var
    Generator: String;
    ServiceCommand: TCustomSQLCommandEh;
    Params: TParams;
    Cursor: TDataSet;
    FreeOnEof: Boolean;
  begin
    Result := Unassigned;
  { TODO : May be better to use Memrec.UpdateStatus = Inserted ? }
    Generator := SQLDataDriver.SpecParams.Values['SEQUENCE'];
    if Generator <> '' then
    begin
      ServiceCommand := SQLDataDriver.ServiceCommand;
      ServiceCommand.CommandText.Text := Format(SEQSQL, [Generator, 1]);
      ServiceCommand.CommandType := cthSelectQuery;
      Params := ServiceCommand.GetParams;
      Params.Clear;
      ServiceCommand.SetParams(Params);
      try
        ServiceCommand.Execute(Cursor, FreeOnEof);
        // Get current GENERATOR value
        Result := Cursor.Fields[0].Value;
      finally
        if FreeOnEof then
          Cursor.Free;
      end;
    end;
  end;

var
  GenValue: Variant;
  GeneratorField: String;
begin
  if MemRec.UpdateStatus = usInserted then
  begin
    GenValue := PromoteInterBaseGenerator;
    GeneratorField := SQLDataDriver.SpecParams.Values['SEQUENCE_FIELD'];
    if MemRec.DataStruct.FindField(GeneratorField) = nil then
      GeneratorField := '';
    if not VarIsEmpty(GenValue) and (GeneratorField <> '') then
      MemRec.DataValues[GeneratorField, dvvValueEh] := GenValue;
  end;
  Result := inherited UpdateRecord(SQLDataDriver, MemTableData, MemRec);
end;

{ TMSSQLSpecOperationsEh }

constructor TMSSQLSpecOperationsEh.Create;
begin
  inherited Create;
  IncludeInsertFieldsInUpdateCommand := False;
end;

procedure TMSSQLSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  IDENTITYSQL1 = 'SELECT @@IDENTITY';  {do not localize}
  IDENTITYSQL2 = 'SELECT @@SCOPE_IDENTITY()';  {do not localize}
var
  IdentityField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;
begin
  DataDriver := Command.DataDriver;
  if Command <> DataDriver.InsertCommand then Exit;
  IdentityField := DataDriver.SpecParams.Values['AUTO_INCREMENT_FIELD'];
  ServiceCommand := DataDriver.ServiceCommand;
  if IdentityField <> '' then
  begin
    ServiceCommand.CommandText.Text := IDENTITYSQL1;
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      // Get current Sequence value
      MemRec.DataValues[IdentityField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;
end;

{ TInterbaseSpecOperationsEh }

procedure TInterbaseSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  SGENSQL = 'SELECT GEN_ID(%s, %d) FROM RDB$DATABASE';  {do not localize}
var
  Generator, GeneratorField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;
begin
  DataDriver := Command.DataDriver;
  if Command <> DataDriver.InsertCommand then Exit;
  Generator := DataDriver.SpecParams.Values['GENERATOR'];
  GeneratorField := DataDriver.SpecParams.Values['GENERATOR_FIELD'];
  if MemRec.DataStruct.FindField(GeneratorField) = nil then
    GeneratorField := '';
  ServiceCommand := DataDriver.ServiceCommand;
  if (Generator <> '') and (GeneratorField <> '') then
  begin
    ServiceCommand.CommandText.Text := Format(SGENSQL, [Generator, 0]);
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      // Get current GENERATOR value
      MemRec.DataValues[GeneratorField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;
end;

function TInterbaseSpecOperationsEh.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh): Integer;

  function PromoteInterBaseGenerator: Variant;
  const
    SGENSQL = 'SELECT GEN_ID(%s, %d) FROM RDB$DATABASE';  {do not localize}
  var
    Generator: String;
    ServiceCommand: TCustomSQLCommandEh;
    Params: TParams;
    Cursor: TDataSet;
    FreeOnEof: Boolean;
  begin
    Result := Unassigned;
  { TODO : May be better to use Memrec.UpdateStatus = Inserted ? }
    Generator := SQLDataDriver.SpecParams.Values['GENERATOR'];
    if Generator <> '' then
    begin
      ServiceCommand := SQLDataDriver.ServiceCommand;
      ServiceCommand.CommandText.Text := Format(SGENSQL, [Generator, 1]);
      ServiceCommand.CommandType := cthSelectQuery;
      Params := ServiceCommand.GetParams;
      Params.Clear;
      ServiceCommand.SetParams(Params);
      try
        ServiceCommand.Execute(Cursor, FreeOnEof);
        // Get current GENERATOR value
        Result := Cursor.Fields[0].Value;
      finally
        if FreeOnEof then
          Cursor.Free;
      end;
    end;
  end;

var
  GenValue: Variant;
  GeneratorField: String;
begin
  if MemRec.UpdateStatus = usInserted then
  begin
    GenValue := PromoteInterBaseGenerator;
    GeneratorField := SQLDataDriver.SpecParams.Values['GENERATOR_FIELD'];
    if MemRec.DataStruct.FindField(GeneratorField) = nil then
      GeneratorField := '';
    if not VarIsEmpty(GenValue) and (GeneratorField <> '') then
      MemRec.DataValues[GeneratorField, dvvValueEh] := GenValue;
  end;
  Result := inherited UpdateRecord(SQLDataDriver, MemTableData, MemRec);
end;

{ TMSAccessSpecOperationsEh }

constructor TMSAccessSpecOperationsEh.Create;
begin
  inherited Create;
  IncludeInsertFieldsInUpdateCommand := False;
end;

procedure TMSAccessSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  IDENTITYSQL1 = 'SELECT @@IDENTITY';  {do not localize}
  IDENTITYSQL2 = 'SELECT @@SCOPE_IDENTITY()';  {do not localize}
var
  IdentityField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;
begin
  DataDriver := Command.DataDriver;
  if Command <> DataDriver.InsertCommand then Exit;
  IdentityField := DataDriver.SpecParams.Values['AUTO_INCREMENT_FIELD'];
  ServiceCommand := DataDriver.ServiceCommand;
  if IdentityField <> '' then
  begin
    ServiceCommand.CommandText.Text := IDENTITYSQL1;
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      // Get current Sequence value
      MemRec.DataValues[IdentityField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;
end;

{ TInfromixSpecOperationsEh }

constructor TInfromixSpecOperationsEh.Create;
begin
  inherited Create;
  IncludeInsertFieldsInUpdateCommand := False;
end;

procedure TInfromixSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  IDENTITYSQL = 'select DBINFO("sqlca.sqlerrd1") from systables where tabid=1';  {do not localize}
var
  IdentityField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;
begin
  DataDriver := Command.DataDriver;
  if Command <> DataDriver.InsertCommand then Exit;
  IdentityField := DataDriver.SpecParams.Values['AUTO_INCREMENT_FIELD'];
  ServiceCommand := DataDriver.ServiceCommand;
  if IdentityField <> '' then
  begin
    ServiceCommand.CommandText.Text := IDENTITYSQL;
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      // Get current Sequence value
      MemRec.DataValues[IdentityField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;
end;

{ TDB2SpecOperationsEh }

procedure TDB2SpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin

end;

{ TSybaseSpecOperationsEh }

procedure TSybaseSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin

end;

{ TDynaSQLParamsEh }

constructor TDynaSQLParamsEh.Create(ADataDriver: TCustomSQLDataDriverEh);
begin
  inherited Create;
  FDataDriver := ADataDriver;
end;

destructor TDynaSQLParamsEh.Destroy;
begin
  inherited Destroy;
end;

procedure TDynaSQLParamsEh.Assign(Source: TPersistent);
begin
  if Source is TDynaSQLParamsEh then
  begin
    KeyFields := TDynaSQLParamsEh(Source).KeyFields;
    UpdateFields := TDynaSQLParamsEh(Source).UpdateFields;
    UpdateTable := TDynaSQLParamsEh(Source).UpdateTable;
    SkipUnchangedFields := TDynaSQLParamsEh(Source).SkipUnchangedFields;
    Options := TDynaSQLParamsEh(Source).Options;
  end else
    inherited Assign(Source);
end;

procedure TDynaSQLParamsEh.SetKeyFields(const Value: String);
begin
  FKeyFields := Value;
end;

procedure TDynaSQLParamsEh.SetUpdateFields(const Value: String);
begin
  FUpdateFields := Value;
end;

procedure TDynaSQLParamsEh.SetUpdateTable(const Value: String);
begin
  FUpdateTable := Value;
end;

initialization
  InitializeUnit;
finalization
//  ShowMessage('UnRegistering DataDriverEh >');
  FinalizaUnit;
//  ShowMessage('UnRegistered DataDriverEh <');
end.

