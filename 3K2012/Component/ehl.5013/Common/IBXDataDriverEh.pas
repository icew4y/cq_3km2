{*******************************************************}
{                                                       }
{                     EhLib v5.0                        }
{                                                       }
{          TIBXDataDriverEh component (Build 5.0.00)    }
{                                                       }
{      Copyright (c) 2003,04 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit IBXDataDriverEh;

{$I EHLIB.INC}

interface

uses Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh,
  IBCustomDataSet, IBDatabase, IBQuery, IBTable, IBStoredProc;
type

  TIBXDataDriverEh = class;

{ TIBXCommandEh }

  TIBXCommandEh = class(TBaseSQLCommandEh)
  private
    function GetDataDriver: TIBXDataDriverEh;
  public
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    property DataDriver: TIBXDataDriverEh read GetDataDriver;
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
  end;

{ TIBXDataDriverEh }

  TIBXDataDriverEh = class(TBaseSQLDataDriverEh)
  private
    FDatabase: TIBDatabase;
    FIbsSpecOperations: TInterbaseSpecOperationsEh;
    procedure SetDatabase(const Value: TIBDatabase);
  protected
    function CreateCommand: TCustomSQLCommandEh; override;
(*    function CreateSelectCommand: TCustomSQLCommandEh; override;
    function CreateUpdateCommand: TCustomSQLCommandEh; override;
    function CreateInsertCommand: TCustomSQLCommandEh; override;
    function CreateDeleteCommand: TCustomSQLCommandEh; override;
    function CreateGetrecCommand: TCustomSQLCommandEh; override;*)
    function InternalGetServerSpecOperations: TServerSpecOperationsEh; override;
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateDesignCopy: TCustomSQLDataDriverEh; override;
    function HaveDataConnection(): Boolean; override;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DoServerSpecOperations(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
  published
    property Database: TIBDatabase read FDatabase write SetDatabase;
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

function DefaultExecuteIBXCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ADatabase: TIBDatabase): Integer;

procedure DefaultUpdateIBXRecordEh(SQLDataDriver: TCustomSQLDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
  var Processed: Boolean; ADatabase: TIBDatabase);

implementation

function DefaultExecuteIBXCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ADatabase: TIBDatabase): Integer;
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
          ACursor := TIBQuery.Create(nil);
          with ACursor as TIBQuery do
          begin
            Database := ADatabase;
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
          ACursor := TIBTable.Create(nil);
          with ACursor as TIBTable do
          begin
            Database := ADatabase;
            TableName := Command.CommandText.Text;
//            Parameters.Assign(TBaseSQLCommandEh(Command).Params);
            Open;
//            TBaseSQLCommandEh(Command).Params.Assign(Parameters);
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TIBStoredProc.Create(nil);
          with ACursor as TIBStoredProc do
          begin
            Database := ADatabase;
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

procedure DefaultUpdateIBXRecordEh(SQLDataDriver: TCustomSQLDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
  var Processed: Boolean; ADatabase: TIBDatabase);
begin
//  SQLDataDriver
end;

{ TIBXCommandEh }

function TIBXCommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
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
          ACursor := TIBQuery.Create(nil);
          with ACursor as TIBQuery do
          begin
            Database := DataDriver.Database;
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
          ACursor := TIBTable.Create(nil);
          with ACursor as TIBTable do
          begin
            Database := DataDriver.Database;
            TableName := Self.CommandText.Text;
            Params := Self.Params;
            Open;
            Self.Params := Params;
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TIBStoredProc.Create(nil);
          with ACursor as TIBStoredProc do
          begin
            Database := DataDriver.Database;
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

function TIBXCommandEh.GetDataDriver: TIBXDataDriverEh;
begin
  Result := TIBXDataDriverEh(inherited DataDriver);
end;

{ TIBXDataDriverEh }

constructor TIBXDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIbsSpecOperations := TInterbaseSpecOperationsEh.Create;
end;

destructor TIBXDataDriverEh.Destroy;
begin
  FreeAndNil(FIbsSpecOperations);
  inherited Destroy;
end;

function TIBXDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TIBXDataDriverEh.Create(nil);
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
  TIBXDataDriverEh(Result).SpecParams := SpecParams;
//  TIBXDataDriverEh(Result).DatabaseName :=
//   (DesignDataBase as IIBXDesignDataBaseEh).GetDataBase.DatabaseName;
end;

(*function TIBXDataDriverEh.CreateInsertCommand: TCustomSQLCommandEh;
begin
  Result := TIBXCommandEh.Create(Self);
end;

function TIBXDataDriverEh.CreateSelectCommand: TCustomSQLCommandEh;
begin
  Result := TIBXCommandEh.Create(Self);
end;

function TIBXDataDriverEh.CreateGetrecCommand: TCustomSQLCommandEh;
begin
  Result := TIBXCommandEh.Create(Self);
end;

function TIBXDataDriverEh.CreateUpdateCommand: TCustomSQLCommandEh;
begin
  Result := TIBXCommandEh.Create(Self);
end;

function TIBXDataDriverEh.CreateDeleteCommand: TCustomSQLCommandEh;
begin
  Result := TIBXCommandEh.Create(Self);
end;*)

function TIBXDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TIBXCommandEh.Create(Self);
end;

procedure TIBXDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  inherited GetBackUpdatedValues(MemRec, Command, ResDataSet);
  DoServerSpecOperations(MemRec, Command, ResDataSet);
end;

(*
//InterBase
procedure DoInterBaseServerSpecOperations(DataDriver: TIBXDataDriverEh; MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  SGENSQL = 'SELECT GEN_ID(%s, %d) FROM RDB$DATABASE';  {do not localize}
var
  Generator, GeneratorField: String;
  q: TIBQuery;
begin
{ TODO : May be better to use Memrec.UpdateStatus = Inserted ? }
  if Command <> DataDriver.InsertCommand then Exit;
  Generator := DataDriver.SpecParams.Values['GENERATOR'];
  GeneratorField := DataDriver.SpecParams.Values['GENERATOR_FIELD'];
  if MemRec.DataStruct.FindField(GeneratorField) = nil then
    GeneratorField := '';
  if (Generator <> '') and (GeneratorField <> '') then
  begin
    q := TIBQuery.Create(nil);
    try
      q.Database := DataDriver.Database;
      q.SQL.Text := Format(SGENSQL, [Generator, 0]);
      q.Open;
      // Get current GENERATOR value
      MemRec.DataValues[GeneratorField, dvvValueEh] := q.Fields[0].Value;
    finally
      q.Free;
    end;
  end;
end;
*)

procedure TIBXDataDriverEh.DoServerSpecOperations(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  if (Database = nil) then
    Exit;
//  DoInterBaseServerSpecOperations(Self, MemRec, Command, ResDataSet)
end;

procedure TIBXDataDriverEh.SetDatabase(const Value: TIBDatabase);
begin
  if FDatabase <> Value then
  begin
    FDatabase := Value;
    if FDatabase <> nil then
      FDatabase.FreeNotification(Self);
  end;
end;

procedure TIBXDataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
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

function TIBXDataDriverEh.HaveDataConnection: Boolean;
begin
  if Assigned(Database) and Database.Connected
    then Result := True
    else Result := inherited HaveDataConnection();
end;

procedure TIBXDataDriverEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FDatabase = AComponent)
  then
    FDatabase := nil;
end;

function TIBXDataDriverEh.InternalGetServerSpecOperations: TServerSpecOperationsEh;
begin
  Result := FIbsSpecOperations; 
end;

end.
