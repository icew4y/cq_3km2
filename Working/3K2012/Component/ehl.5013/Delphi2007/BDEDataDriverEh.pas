{*******************************************************}
{                                                       }
{                     EhLib v5.0                        }
{                                                       }
{          TBDEDataDriverEh component (Build 5.0.00)    }
{                                                       }
{      Copyright (c) 2003-05 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit BDEDataDriverEh {$IFDEF CIL} platform{$ENDIF};

{$I EHLIB.INC}

interface

{ TODO :
  if (ResDataSet is TDBDataSet) and (TDBDataSet(ResDataSet).Database <> nil) then
    Check(DbiGetProp(hDBIObj(TDBDataSet(ResDataSet).Database.Handle), drvNATIVESQLCA, @sqlca, SizeOf(tsqlca), res));
does't work }

uses Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, DBTables;
type

  TBDEDataDriverEh = class;

{ TBDECommandEh }

  TBDECommandEh = class(TBaseSQLCommandEh)
  private
    function GetDataDriver: TBDEDataDriverEh;
  public
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    property DataDriver: TBDEDataDriverEh read GetDataDriver;
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
  end;

{ TBDEDataDriverEh }

  TBDEDataDriverEh = class(TBaseSQLDataDriverEh)
  private
    FDatabaseName: string;
    FSessionName: string;
    FServerSpecOperations: TServerSpecOperationsEh;
    function GetDBSession: TSession;
    procedure SetDatabaseName(const Value: string);
    procedure SetSessionName(const Value: string);
  protected
    function CreateCommand: TCustomSQLCommandEh; override;
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); override;
    function InternalGetServerSpecOperations: TServerSpecOperationsEh; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateDesignCopy: TCustomSQLDataDriverEh; override;
    function HaveDataConnection(): Boolean; override;
//    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DefaultGetUpdatedServerValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DoServerSpecOperations(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
    property DBSession: TSession read GetDBSession;
    property SessionName: string read FSessionName write SetSessionName;
  published
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property SelectCommand;
    property SelectSQL;
    property UpdateCommand;
    property UpdateSQL;
    property InsertCommand;
    property InsertSQL;
    property DeleteCommand;
    property DeleteSQL;
    property GetrecCommand;
    property GetrecSQL;
    property DynaSQLParams;
    property ProviderDataSet;
    property KeyFields;
    property SpecParams;

    property OnExecuteCommand;
    property OnBuildDataStruct;
    property OnGetBackUpdatedValues;
    property OnProduceDataReader;
    property OnAssignFieldValue;
    property OnReadRecord;
    property OnRefreshRecord;
    property OnUpdateRecord;
    property OnAssignCommandParam;
    property OnUpdateError;
  end;

function DefaultExecuteBDECommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ADatabaseName: String): Integer;

implementation

uses
{$IFDEF CIL}
  System.Text,
{$ENDIF}
  BDE;

function DefaultExecuteBDECommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ADatabaseName: String): Integer;
var
  ACursor: TDataSet;
begin
  Result := -1;
  Cursor := nil;
  FreeOnEof := False;
  ACursor := nil;
  Processed := True;
  try
    case Command.CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          ACursor := TQuery.Create(nil);
          with ACursor as TQuery do
          begin
            DatabaseName := ADatabaseName;
            SQL := Command.CommandText;
            Params := TBaseSQLCommandEh(Command).Params;
            if Command.CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
            TBaseSQLCommandEh(Command).Params := Params;
          end;
        end;
      cthTable:
        begin
          ACursor := TTable.Create(nil);
          with ACursor as TTable do
          begin
            DatabaseName := ADatabaseName;
            TableName := Command.CommandText.Text;
//            Parameters.Assign(TBaseSQLCommandEh(Command).Params);
            Open;
//            TBaseSQLCommandEh(Command).Params.Assign(Parameters);
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TStoredProc.Create(nil);
          with ACursor as TStoredProc do
          begin
            DatabaseName := ADatabaseName;
            StoredProcName := Command.CommandText.Text;
            Params := TBaseSQLCommandEh(Command).Params;
            ExecProc;
//??            Result := RowsAffected;
            TBaseSQLCommandEh(Command).Params := Params;
          end;
        end;
    end;
    if ACursor.Active then
    begin
      Cursor := ACursor;
      FreeOnEof := True;
      ACursor := nil;
    end
  finally
    if ACursor <> nil then
      ACursor.Free;
  end;
end;

{ TBDECommandEh }

function TBDECommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  ACursor: TDataSet;
begin
  Result := -1;
  Cursor := nil;
  FreeOnEof := False;
  ACursor := nil;
  try
    case CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          ACursor := TQuery.Create(nil);
          with ACursor as TQuery do
          begin
            DataBaseName := DataDriver.DatabaseName;
            SQL := Self.CommandText;
            Params := Self.Params;
            if CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
            Self.Params := Params;
          end;
        end;
      cthTable:
        begin
          ACursor := TTable.Create(nil);
          with ACursor as TTable do
          begin
            DataBaseName := DataDriver.DatabaseName;
            TableName := Self.CommandText.Text;
            Params := Self.Params;
            Open;
            Self.Params := Params;
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TStoredProc.Create(nil);
          with ACursor as TStoredProc do
          begin
            DataBaseName := DataDriver.DatabaseName;
            StoredProcName := Self.CommandText.Text;
            Params := Self.Params;
            ExecProc;
//??            Result := RowsAffected;
            Self.Params := Params;
          end;
        end;
    end;
    if ACursor.Active then
    begin
      Cursor := ACursor;
      FreeOnEof := True;
      ACursor := nil;
    end
  finally
    if ACursor <> nil then
      ACursor.Free;
  end;
end;

function TBDECommandEh.GetDataDriver: TBDEDataDriverEh;
begin
  Result := TBDEDataDriverEh(inherited DataDriver);
end;

{ TBDEDataDriverEh }

(*
var
  DataBaseInc: Integer = 0;

function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'BDEDataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;
*)

constructor TBDEDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TBDEDataDriverEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FServerSpecOperations);
end;

function TBDEDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TBDEDataDriverEh.Create(nil);
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
  TBDEDataDriverEh(Result).SpecParams := SpecParams;
//  TBDEDataDriverEh(Result).DatabaseName :=
//   (DesignDataBase as IBDEDesignDataBaseEh).GetDataBase.DatabaseName;
end;

type
  TDBDescription = record
    szName          : String;          { Logical name (Or alias) }
    szText          : String;          { Descriptive text }
    szPhyName       : String;          { Physical name/path }
    szDbType        : String;          { Database type }
  end;

{$IFDEF CIL}
function StrToOem(const AnsiStr: string): string;
var
  Len: Cardinal;
  Buffer: StringBuilder;
begin
  Len := Length(AnsiStr);
  if Len > 0 then
  begin
    Buffer := StringBuilder.Create(Len);
    CharToOemA(AnsiStr, Buffer);
    Result := Buffer.ToString;
  end;
end;
{$ELSE}
{$IFDEF EH_LIB_12}
function StrToOem(const AnsiStr: AnsiString): AnsiString;
begin
  Result := AnsiStr;
  if Length(Result) > 0 then
    CharToOemA(PAnsiChar(Result), PAnsiChar(Result));
end;
{$ELSE}
function StrToOem(const AnsiStr: string): string;
begin
  SetLength(Result, Length(AnsiStr));
  if Length(Result) > 0 then
    CharToOem(PChar(AnsiStr), PChar(Result));
end;
{$ENDIF}
{$ENDIF}

function GetDatabaseDesc(DBName: String; var Description: TDBDescription): Boolean;
var
  Desc: DBDesc;
begin
  Result := False;
{$IFDEF CIL}
  if DbiGetDatabaseDesc(StrToOem(DBName), Desc) <> 0 then Exit;
{$ELSE}
{$IFDEF EH_LIB_12}
  if DbiGetDatabaseDesc(PAnsiChar(StrToOem(AnsiString(DBName))), @Desc) <> 0 then Exit;
{$ELSE}
  if DbiGetDatabaseDesc(PChar(StrToOem(DBName)), @Desc) <> 0 then Exit;
{$ENDIF}
{$ENDIF}
  Description.szName := String(Desc.szName);
  Description.szText := String(Desc.szText);
  Description.szPhyName := String(Desc.szPhyName);
  Description.szDbType := String(Desc.szDbType);
  Result := True;
end;

function TBDEDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TBDECommandEh.Create(Self);
end;

procedure TBDEDataDriverEh.SetDatabaseName(const Value: string);
begin
  FDatabaseName := Value;
end;

procedure TBDEDataDriverEh.DoServerSpecOperations(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
//var
//  Description: TDBDescription;
begin
(*  if not GetDatabaseDesc(DatabaseName, Description) then
    Exit;
  if Description.szDbType = 'INFORMIX' then
    DoInformixServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'DB2' then
    DoDB2ServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'INTRBASE' then
//    DoInterBaseServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'ORACLE' then
    DoOracleServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'SYBASE' then
    DoSybaseServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'SQL Server' then
    DoMSSQLServerSpecOperations(Self, MemRec, Command, ResDataSet)
*)    
end;

function TBDEDataDriverEh.GetDBSession: TSession;
begin
  Result := Sessions.FindSession(SessionName);
  if Result = nil then Result := DBTables.Session;
end;

procedure TBDEDataDriverEh.SetSessionName(const Value: string);
begin
  FSessionName := Value;
end;

procedure TBDEDataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
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

function TBDEDataDriverEh.HaveDataConnection: Boolean;
var
  DataBase: TDatabase;
begin
  if DatabaseName <> '' then
  begin
    Result := False;
    DataBase := Session.FindDatabase(DatabaseName);
    if (DataBase <> nil) and DataBase.Connected then
      Result := True;
  end else
    Result := inherited HaveDataConnection();
end;

procedure TBDEDataDriverEh.DefaultGetUpdatedServerValues(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
var
  Processed: Boolean;
begin
  Processed := False;
  if DefaultSQLDataDriverResolver <> nil then
    DefaultSQLDataDriverResolver.GetBackUpdatedValues(Self, MemRec, Command, ResDataSet, Processed);
  if not Processed then
    DoServerSpecOperations(MemRec, Command, ResDataSet);
end;

type
  TServerSpecOperationsEhClass = class of TServerSpecOperationsEh;

function TBDEDataDriverEh.InternalGetServerSpecOperations: TServerSpecOperationsEh;
var
  Description: TDBDescription;
  ServerOpClass: TServerSpecOperationsEhClass;
begin
  ServerOpClass := nil;
  Result := FServerSpecOperations;
  if not GetDatabaseDesc(DatabaseName, Description) then
    Exit;
  if Description.szDbType = 'INFORMIX' then
    ServerOpClass := TInfromixSpecOperationsEh
  else if Description.szDbType = 'DB2' then
    ServerOpClass := TDB2SpecOperationsEh
  else if Description.szDbType = 'INTRBASE' then
    ServerOpClass := TInterbaseSpecOperationsEh
  else if Description.szDbType = 'ORACLE' then
    ServerOpClass := TOracleSpecOperationsEh
  else if Description.szDbType = 'SYBASE' then
    ServerOpClass := TSybaseSpecOperationsEh
  else if Description.szDbType = 'SQL Server' then
    ServerOpClass := TMSSQLSpecOperationsEh;

  if (Result = nil) or (ServerOpClass <> Result.ClassType) then
  begin
    FreeAndNil(Result);
    if ServerOpClass <> nil then
      Result := ServerOpClass.Create;
    FServerSpecOperations := Result;
  end;
end;

end.
