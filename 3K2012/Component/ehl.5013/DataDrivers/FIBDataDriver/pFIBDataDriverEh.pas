{*******************************************************}
{                                                       }
{                     EhLib vX.X                        }
{                                                       }
{          TpFIBDataDriverEh component (Build 3)        }
{                                                       }
{    Copyright (c) 2004,2005 by Serguei S. Borisoff     }
{                   jr_ross@mail.ru                     }
{                                                       }
{*******************************************************}

unit pFIBDataDriverEh;

{$I EhLib.inc}

interface

uses
  Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh,
  pFIBDatabase;

type
  TpFIBDataDriverEh = class;

{ TpFIBCommandEh }

  TpFIBCommandEh = class(TBaseSQLCommandEh)
  private
    function GetDataDriver: TpFIBDataDriverEh;
  public
    function Execute(var Cursor: TDataSet;
      var FreeOnEof: Boolean): Integer; override;
    property DataDriver: TpFIBDataDriverEh read GetDataDriver;
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
  end;

{ TpFIBDataDriverEh }

  TPFIBDataDriverEh = class(TBaseSQLDataDriverEh)
  private
    FDatabase: TpFIBDatabase;
    procedure SetDatabase(const Value: TpFIBDatabase);
  protected
    function CreateSelectCommand: TCustomSQLCommandEh; override;
    function CreateUpdateCommand: TCustomSQLCommandEh; override;
    function CreateInsertCommand: TCustomSQLCommandEh; override;
    function CreateDeleteCommand: TCustomSQLCommandEh; override;
    function CreateGetrecCommand: TCustomSQLCommandEh; override;
    procedure SetAutoIncFields(Fields: TFields;
      DataStruct: TMTDataStructEh); override;
  public
    function CreateDesignCopy: TCustomSQLDataDriverEh; override;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh;
      Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DoServerSpecOperations(MemRec: TMemoryRecordEh;
      Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
  published
    property Database: TpFIBDatabase read FDatabase write SetDatabase;
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

function DefaultExecuteFIBCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
  Command: TCustomSQLCommandEh; var Cursor: TDataSet;
  var FreeOnEof, Processed: Boolean; ADatabase: TpFIBDatabase): Integer;

procedure Register;
  
implementation

uses
  FIBQuery, FIBDataSet, pFIBQuery, pFIBDataSet, pFIBProps, FIBDatabase;

procedure ParamsToFIB(const Params: TParams; const FIBParams: TFIBXSQLDA);
var
  i: Integer;
  param: TParam;
  fib_param: TFIBXSQLVAR;
begin
  for i := 0 to Params.Count - 1 do begin
    param := Params[i];
    fib_param := FIBParams.FindParam(param.Name);
    if Assigned(fib_param) then
      fib_param.Value := param.Value;
  end;
end;

procedure FIBToParams(const FIBParams: TFIBXSQLDA; const Params: TParams);
var
  i: Integer;
  fib_param: TFIBXSQLVAR;
  param: TParam;
begin
  for i := 0 to FIBParams.Count - 1 do begin
    fib_param := FIBParams[i];
    param := Params.FindParam(fib_param.Name);
    if Assigned(param) then
      param.Value := fib_param.Value;
  end;  
end;

function ExecuteSQLCommand(CommandType: TSQLCommandTypeEh;
  const CommandText: TStrings; const CommandParams: TParams;
  const Database: TpFIBDatabase;
  var Cursor: TpFIBDataSet; var FreeOnEof: Boolean): Integer;
var
  q: TpFIBQuery;
begin
  Result := - 1;

  FreeOnEof := False;
  Cursor := nil;
  
  case CommandType of
    cthSelectQuery, cthTable: begin
      FreeOnEof := True;
      Cursor := TpFIBDataSet.Create(Database);
      Cursor.Database := Database;
      Cursor.Transaction := Database.DefaultTransaction;
      Cursor.AutoCommit := False;
      Cursor.Options := Cursor.Options + [poStartTransaction];
      Cursor.SelectSQL := CommandText;

      if CommandType = cthSelectQuery then
        ParamsToFIB(CommandParams, Cursor.Params);

      if not Database.Connected then
        Database.Open();

      Cursor.Open();

      if CommandType = cthSelectQuery then
        FIBToParams(Cursor.Params, CommandParams);
    end;
    cthUpdateQuery, cthStoredProc: begin
      q := TpFIBQuery.Create(Database);
      try
        q.Database := Database;
        q.Transaction := TpFIBTransaction.Create(q);
        q.Transaction.DefaultDatabase := q.Database;
        TpFIBTransaction(q.Transaction).TPBMode := tpbReadCommitted;
        q.Options := [qoStartTransaction, qoAutoCommit];
        q.SQL := CommandText;
      
        ParamsToFIB(CommandParams, q.Params);

        if not Database.Connected then
          Database.Open();

        if CommandType = cthUpdateQuery then begin
          q.ExecQuery();
          Result := q.RowsAffected;
        end
        else begin // CommandType = cthStoredProc
          q.ExecProc();
//??          Result := q.RowsAffected;
        end;

        FIBToParams(q.Params, CommandParams);
      finally
        q.Free();
      end;
    end;
  end;  
end;

function DefaultExecuteFIBCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
  Command: TCustomSQLCommandEh; var Cursor: TDataSet;
  var FreeOnEof, Processed: Boolean; ADatabase: TpFIBDatabase): Integer;
begin
  with TBaseSQLCommandEh(Command) do
    Result := ExecuteSQLCommand(CommandType, CommandText, Params,
      ADatabase, TpFIBDataSet(Cursor), FreeOnEof);

  Processed := True;
end;

procedure DoInterbaseServerSpecOperations(DataDriver: TpFIBDataDriverEh;
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  SGENSQL = 'select gen_id(%s, %d) from rdb$database';  {do not localize}
var
  Generator, GeneratorField: String;
  q: TpFIBQuery;
begin
  if Command = DataDriver.InsertCommand then begin
    Generator := DataDriver.SpecParams.Values['GENERATOR'];
    GeneratorField := DataDriver.SpecParams.Values['GENERATOR_FIELD'];
    if (Generator <> '') and (GeneratorField <> '') and
       Assigned(MemRec.DataStruct.FindField(GeneratorField))
    then begin
      q := TpFIBQuery.Create(DataDriver.Database);
      try
        q.Database := DataDriver.Database;
        q.Options := [qoTrimCharFields, qoStartTransaction];
        q.SQL.Text := Format(SGENSQL, [Generator, 1]);
        q.ExecQuery();

        MemRec.DataValues[GeneratorField, dvvValueEh] := q.Fields[0].Value;
      finally
        q.Free();
      end;
    end;
  end;  
end;


{ class TpFIBCommandEh }

function TpFIBCommandEh.Execute(var Cursor: TDataSet;
  var FreeOnEof: Boolean): Integer;
begin
  Result := ExecuteSQLCommand(CommandType, CommandText, Params,
    DataDriver.Database, TpFIBDataSet(Cursor), FreeOnEof);
end;

function TpFIBCommandEh.GetDataDriver: TpFIBDataDriverEh;
begin
  Result := TpFIBDataDriverEh(inherited DataDriver);
end;


{ class TpFIBDataDriverEh }

function TpFIBDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TpFIBDataDriverEh.Create(nil);
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
{  TpFIBDataDriverEh(Result).DatabaseName :=
   (DesignDataBase as IFIBDesignDataBaseEh).GetDataBase.DatabaseName;}
end;

function TpFIBDataDriverEh.CreateInsertCommand: TCustomSQLCommandEh;
begin
  Result := TpFIBCommandEh.Create(Self);
end;

function TpFIBDataDriverEh.CreateSelectCommand: TCustomSQLCommandEh;
begin
  Result := TpFIBCommandEh.Create(Self);
end;

function TpFIBDataDriverEh.CreateGetrecCommand: TCustomSQLCommandEh;
begin
  Result := TpFIBCommandEh.Create(Self);
end;

function TpFIBDataDriverEh.CreateUpdateCommand: TCustomSQLCommandEh;
begin
  Result := TpFIBCommandEh.Create(Self);
end;

function TpFIBDataDriverEh.CreateDeleteCommand: TCustomSQLCommandEh;
begin
  Result := TpFIBCommandEh.Create(Self);
end;

procedure TpFIBDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  inherited;
  
  DoServerSpecOperations(MemRec, Command, ResDataSet);
end;

procedure TpFIBDataDriverEh.DoServerSpecOperations(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  if Assigned(Database) then
    DoInterBaseServerSpecOperations(Self, MemRec, Command, ResDataSet)
end;

procedure TpFIBDataDriverEh.SetDatabase(const Value: TpFIBDatabase);
begin
  FDatabase := Value;
end;

procedure TpFIBDataDriverEh.SetAutoIncFields(Fields: TFields;
  DataStruct: TMTDataStructEh);
var
  AutoIncFieldName: String;
  AutoIncField: TMTDataFieldEh;
begin
  AutoIncFieldName := SpecParams.Values['AUTO_INCREMENT_FIELD'];
  if AutoIncFieldName <> '' then begin
    AutoIncField := DataStruct.FindField(AutoIncFieldName);
    if Assigned(AutoIncField) and (AutoIncField is TMTNumericDataFieldEh) then
      TMTNumericDataFieldEh(AutoIncField).NumericDataType := fdtAutoIncEh;
  end;    
end;


procedure Register;
begin
{$IFDEF EH_LIB_5}
  RegisterComponents('EhLib', [TpFIBDataDriverEh]);
{$ENDIF}
end;

end.
