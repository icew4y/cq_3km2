{*******************************************************}
{                                                       }
{                     EhLib v5.0                        }
{                                                       }
{          TDBXDataDriverEh component (Build 5.0.00)    }
{                                                       }
{      Copyright (c) 2003,04 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit DBXDataDriverEh;

{$I EHLIB.INC}

interface

uses Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, SqlExpr, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh;
type

  TDBXDataDriverEh = class;

{ TDBXCommandEh }

  TDBXCommandEh = class(TBaseSQLCommandEh)
  private
    function GetDataDriver: TDBXDataDriverEh;
  public
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    property DataDriver: TDBXDataDriverEh read GetDataDriver;
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
  end;

{ TDBXDataDriverEh }

  TDBXDataDriverEh = class(TBaseSQLDataDriverEh)
  private
    FServerSpecOperations: TServerSpecOperationsEh;
    FSQLConnection: TSQLConnection;
    procedure SetConnection(const Value: TSQLConnection);
  protected
    function CreateCommand: TCustomSQLCommandEh; override;
    function InternalGetServerSpecOperations: TServerSpecOperationsEh; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateDesignCopy: TCustomSQLDataDriverEh; override;
    function HaveDataConnection(): Boolean; override;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DoServerSpecOperations(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
  published
    property SQLConnection: TSQLConnection read FSQLConnection write SetConnection;
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

function DefaultExecuteDBXCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ASQLConnection: TSQLConnection): Integer;

implementation

function DefaultExecuteDBXCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ASQLConnection: TSQLConnection): Integer;
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
          ACursor := TSQLQuery.Create(nil);
          with ACursor as TSQLQuery do
          begin
            SQLConnection := ASQLConnection;
            SQL.Text := Command.CommandText.Text;
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
          ACursor := TSQLTable.Create(nil);
          with ACursor as TSQLTable do
          begin
            SQLConnection := ASQLConnection;
            TableName := Command.CommandText.Text;
//            Parameters.Assign(TBaseSQLCommandEh(Command).Params);
            Open;
//            TBaseSQLCommandEh(Command).Params.Assign(Parameters);
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TSQLStoredProc.Create(nil);
          with ACursor as TSQLStoredProc do
          begin
            SQLConnection := ASQLConnection;
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

{ TDBXCommandEh }

function TDBXCommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
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
          ACursor := TSQLQuery.Create(nil);
          with ACursor as TSQLQuery do
          begin
            SQLConnection := DataDriver.SQLConnection;
            SQL.Text := Self.CommandText.Text;
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
          ACursor := TSQLTable.Create(nil);
          with ACursor as TSQLTable do
          begin
            SQLConnection := DataDriver.SQLConnection;
            TableName := Self.CommandText.Text;
            Params := Self.Params;
            Open;
            Self.Params := Params;
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TSQLStoredProc.Create(nil);
          with ACursor as TSQLStoredProc do
          begin
            SQLConnection := DataDriver.SQLConnection;
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

function TDBXCommandEh.GetDataDriver: TDBXDataDriverEh;
begin
  Result := TDBXDataDriverEh(inherited DataDriver);
end;

{ TDBXDataDriverEh }

var
  DataBaseInc: Integer = 0;

function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'DBXDataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;

constructor TDBXDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TDBXDataDriverEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FServerSpecOperations);
end;

function TDBXDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TDBXDataDriverEh.Create(nil);
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
  TDBXDataDriverEh(Result).SpecParams := SpecParams;
//  TDBXDataDriverEh(Result).DatabaseName :=
//   (DesignDataBase as IDBXDesignDataBaseEh).GetDataBase.DatabaseName;
end;

type
  TDBDescription = record
    szName          : String;          { Logical name (Or alias) }
    szText          : String;          { Descriptive text }
    szPhyName       : String;          { Physical name/path }
    szDbType        : String;          { Database type }
  end;

function TDBXDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TDBXCommandEh.Create(Self);
end;

procedure TDBXDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  inherited GetBackUpdatedValues(MemRec, Command, ResDataSet);
  DoServerSpecOperations(MemRec, Command, ResDataSet);
end;

procedure TDBXDataDriverEh.DoServerSpecOperations(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
//var
//  DbType: String;
begin
(*  if (SQLConnection = nil) then
    Exit;
  DbType := UpperCase(SQLConnection.DriverName);
  if DbType = 'INFROMIX' then
    DoInformixServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if DbType = 'DB2' then
    DoDB2ServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if DbType = 'INTRBASE' then
    DoInterBaseServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if DbType = 'ORACLE' then
    DoOracleServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if DbType = 'SYBASE' then
    DoSybaseServerSpecOperations(Self, MemRec, Command, ResDataSet);
*)
end;

procedure TDBXDataDriverEh.SetConnection(const Value: TSQLConnection);
begin
  if FSQLConnection <> Value then
  begin
    FSQLConnection := Value;
    if FSQLConnection <> nil then
      FSQLConnection.FreeNotification(Self);
  end;
end;

procedure TDBXDataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
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

procedure TDBXDataDriverEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FSQLConnection = AComponent)
  then
    FSQLConnection := nil;
end;

function TDBXDataDriverEh.HaveDataConnection: Boolean;
begin
  if Assigned(SQLConnection) and SQLConnection.Connected
    then Result := True
    else Result := inherited HaveDataConnection();
end;

type
  TServerSpecOperationsEhClass = class of TServerSpecOperationsEh;

function TDBXDataDriverEh.InternalGetServerSpecOperations: TServerSpecOperationsEh;
var
  ServerOpClass: TServerSpecOperationsEhClass;
  DbType: String;
begin
  ServerOpClass := nil;
  Result := FServerSpecOperations;
  if SQLConnection <> nil then
    DbType := UpperCase(SQLConnection.DriverName);
  if DbType = 'INFORMIX' then
    ServerOpClass := TInfromixSpecOperationsEh
  else if DbType = 'DB2' then
    ServerOpClass := TDB2SpecOperationsEh
  else if DbType = 'INTRBASE' then
    ServerOpClass := TInterbaseSpecOperationsEh
  else if DbType = 'ORACLE' then
    ServerOpClass := TOracleSpecOperationsEh
  else if DbType = 'SYBASE' then
    ServerOpClass := TSybaseSpecOperationsEh;

  if (Result = nil) or (ServerOpClass <> Result.ClassType) then
  begin
    FreeAndNil(Result);
    if ServerOpClass <> nil then
      Result := ServerOpClass.Create;
    FServerSpecOperations := Result;
  end;
end;

end.
