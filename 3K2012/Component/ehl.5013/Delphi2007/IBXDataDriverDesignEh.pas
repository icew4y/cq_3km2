{*******************************************************}
{                                                       }
{                     EhLib v5.0                        }
{                                                       }
{            TIBXDesignDataBaseEh (Build 5.0.00)        }
{                                                       }
{     Copyright (c) 2004-2005 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit IBXDataDriverDesignEh;

{$I EHLIB.INC}

interface

uses Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, IBDatabase,
  IBQuery, IBTable, IBStoredProc, SQLDriverEditEh, IBXDataDriverEh,
  ComCtrls, MemTableEh, Forms, UpdateSQLEditEh, Dialogs
//design-time  ,Ibdatabaseedit
{$IFDEF DESIGNTIME}
  {$IFDEF CIL}
   ,Borland.Vcl.Design.Ibdatabaseedit
  {$ELSE}
   ,Ibdatabaseedit
  {$ENDIF}
{$ENDIF}
  ;

type

{ IIBXDesignDataBaseEh }

  IIBXDesignDataBaseEh = interface
  ['{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}']
    function GetDatabase: TIBDatabase;
  end;

{ TIBXDesignDataBaseEh }

  TIBXDesignDataBaseEh = class(TDesignDataBaseEh, IIBXDesignDataBaseEh)
  private
    FTablesMT: TMemTableEh;
    FColumnsMT: TMemTableEh;
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
    FTreeNodeMan: TCustomDBService;
    FDBService: TCustomDBService;
    FUpdateObjectsList: TStringList;
    FApplicationDatabase: TIBDatabase;
    procedure SetApplicationDatabase(const Value: TIBDatabase);
  protected
    function GetConnected: Boolean; override;
    procedure SetConnected(const Value: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create;
    destructor Destroy; override;
    function GetEngineName: String; override;
    function ServerTypeName: String;
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh; override;
    function DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    function GetDatabase: TIBDatabase;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
    function BuildObjectTree(List: TList): Boolean; override;
//    function BuildInformixObjectTree(TreeView: TTreeView): Boolean;
    function BuildInterbaseObjectTree2(List: TList): Boolean;
    function BuildOracleObjectTree(TreeView: TTreeView): Boolean;
    function SupportCustomSQLDataDriver: Boolean; override;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean; override;
    function GetSpecParamsList: String; override;
    function GetCustomDBService: TCustomDBService; override;
    function GetIncrementObjectsList: TStrings; override;
    procedure EditDatabaseParams; override;
    property ApplicationDatabase: TIBDatabase read FApplicationDatabase write SetApplicationDatabase;
  end;

  TIBXAccessEngineEh = class(TAccessEngineEh)
    function AccessEngineName: String; override;
//    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh): TDesignDataBaseEh; override;
    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
      DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh; override;
  end;

procedure RegisterIBXAccessEngines;
procedure UnregisterIBXAccessEngines;

procedure Register;

implementation

uses
{$IFDEF DESIGNTIME}
	MemTableDesignEh,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
{$ELSE}
  {$IFDEF EH_LIB_6}
     DesignIntf,
  {$ELSE} //EH_LIB_6
      DsgnIntf,
  {$ENDIF}
  DBReg,
{$ENDIF}
{$ENDIF}
DesignConnectionListEh;

function CreateDesignDataBase(DataDriver: TIBXDataDriverEh): TComponent;
var
  DesignDataBase: TIBXDesignDataBaseEh;
//  SourceIBDatabase: TIBDatabase;
begin
  DesignDataBase :=  TIBXDesignDataBaseEh.Create;
//  SourceIBDatabase := TIBDatabase.Create(nil);
  if DataDriver.Database <> nil then
  begin
    DesignDataBase.FDatabase.DataBaseName := DataDriver.Database.DataBaseName;
    DesignDataBase.FDatabase.Params := DataDriver.Database.Params;
    DesignDataBase.FDatabase.SQLDialect := DataDriver.Database.SQLDialect;
    DesignDataBase.ApplicationDatabase := DataDriver.Database;
  end;
{$IFDEF DESIGNTIME}
    EditIBDatabase(DesignDataBase.FDatabase);
{$ENDIF}
//    SourceIBDatabase.FDBEDataBase.DatabaseName := GetUnicalDataBaseName;
  Result := DesignDataBase;
end;

procedure SetDesignIBXDataBaseProcEh(DataDriver: TCustomSQLDataDriverEh);
var
  i: Integer;
  DesignDataBase: TComponent;
begin
  if DataDriver.DesignDataBase = nil then
  begin
    for i := 0 to GetDesignDataBaseList.Count-1 do
      if TDesignDataBaseEh(GetDesignDataBaseList[i]).DesignDataBaseConnetionEqual(DataDriver) then
      begin
        DataDriver.DesignDataBase := TComponent(GetDesignDataBaseList[i]);
        Exit;
      end;

    if GetDesignDataBaseList.Count > 0 then
    begin
      DesignDataBase := SelectDesignConnectionListEh(DesignDataBaseList);
      if (DesignDataBase <> nil) and (DesignDataBase <> DataDriver.DesignDataBase) then
        DataDriver.DesignDataBase := DesignDataBase;
    end else
      DataDriver.DesignDataBase := CreateDesignDataBase(TIBXDataDriverEh(DataDriver));
  end;
end;

procedure RegisterIBXAccessEngines;
begin
  RegisterDesignDataBuilderProcEh(TIBXDataDriverEh, SetDesignIBXDataBaseProcEh);
  RegisterAccessEngine('IBX', TIBXAccessEngineEh.Create);
end;

procedure UnregisterIBXAccessEngines;
begin
  UnregisterDesignDataBuilderProcEh(TIBXDataDriverEh);
  UnregisterAccessEngine('IBX');
//  UnregisterDBServiceEngine(Engine, BDEUniService);
end;

function GetServerName(IBDatabase: TIBDatabase; var ServerName: String): Boolean;
begin
  ServerName := 'INTERBASE';//AnsiUpperCase(IBDatabase.DriverName);
  Result := True;
end;

{
var
  DataBaseInc: Integer = 0;

function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'IBXDataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;
}

{ TIBXDesignDataBaseEh }

function TIBXDesignDataBaseEh.BuildObjectTree(List: TList): Boolean;
begin
  Result := False;
//  TreeView.Items.Clear;
  if ServerTypeName = 'INFORMIX' then
//    Result := BuildInformixObjectTree(TreeView)
  else if ServerTypeName = 'INTERBASE' then
    Result := BuildInterbaseObjectTree2(List)
  else
    Result := False;
end;

function TIBXDesignDataBaseEh.BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := EditDataDriverUpdateSQL(DataDriver as TCustomSQLDataDriverEh);// UpdateSQLEditEh
end;

constructor TIBXDesignDataBaseEh.Create;
begin
  inherited Create;
  FDatabase := TIBDatabase.Create(Application);
  FTransaction := TIBTransaction.Create(Application);
  FTransaction.DefaultDatabase := FDatabase;
  FTablesMT := TMemTableEh.Create(nil);
  FColumnsMT := TMemTableEh.Create(nil);
  FDBService := TInterbaseDBService.Create(Self)
end;

destructor TIBXDesignDataBaseEh.Destroy;
begin
  if not (csDestroying in Application.ComponentState) then
    FDatabase.Free;
  if not (csDestroying in Application.ComponentState) then
    FTransaction.Free;
  FTablesMT.Free;
  FColumnsMT.Free;
  FTreeNodeMan.Free;
  FreeAndNil(FDBService);
  FreeAndNil(FUpdateObjectsList);
  inherited Destroy;
end;

function TIBXDesignDataBaseEh.CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
begin
  Result := TIBXDataDriverEh.Create(nil);
  Result.SelectCommand := RTDataDriver.SelectCommand;
  Result.UpdateCommand := RTDataDriver.UpdateCommand;
  Result.InsertCommand := RTDataDriver.InsertCommand;
  Result.DeleteCommand := RTDataDriver.DeleteCommand;
  Result.GetrecCommand := RTDataDriver.GetrecCommand;
  TIBXDataDriverEh(Result).SpecParams := TIBXDataDriverEh(RTDataDriver).SpecParams;
//  TIBXDataDriverEh(Result).Database := FDatabase;
end;

function TIBXDesignDataBaseEh.DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
  if DataDriver is TIBXDataDriverEh then
  begin
    if TIBXDataDriverEh(DataDriver).Database <> nil then
      Result := (ApplicationDatabase = TIBXDataDriverEh(DataDriver).Database);
  end;
end;

function TIBXDesignDataBaseEh.Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  Result := -1;
  FreeOnEof := True;
  with Command do
    case CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          Cursor := TIBQuery.Create(nil);
          with Cursor as TIBQuery do
          begin
            Database := FDatabase;
            SQL := Command.CommandText;
            Params := Command.GetParams;
            if CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
          end;
        end;
      cthTable:
        begin
          Cursor := TIBTable.Create(nil);
          with Cursor as TIBTable do
          begin
            Database := FDatabase;
            TableName := Command.CommandText.Text;
//            Params := Command.GetParams;
            Open;
          end;
        end;
      cthStoredProc:
        begin
          Cursor := TIBStoredProc.Create(nil);
          with Cursor as TIBStoredProc do
          begin
            Database := FDatabase;
            StoredProcName := Command.CommandText.Text;
            Params := Command.GetParams;
            ExecProc;
          end;
        end;
    end;
end;

function TIBXDesignDataBaseEh.GetDatabase: TIBDatabase;
begin
  Result := FDatabase;
end;

function TIBXDesignDataBaseEh.ServerTypeName: String;
var
  Description: String;
begin
//  if not SQLCo.Connected then
//    FDBEDataBase.Open;
  if GetServerName(FDatabase, Description) then
  begin
    Result := UpperCase(Description);
  end;
end;

function TIBXDesignDataBaseEh.BuildInterbaseObjectTree2(List: TList): Boolean;
var
  NList: Tlist;
  i: Integer;
//  TreeNode: TTreeNode;
begin
  if FTreeNodeMan <> nil then
    FTreeNodeMan.Free;
  FTreeNodeMan := TInterbaseDBService.Create(Self);
  NList := FTreeNodeMan.CreateRootNodes;
//  List.Assign(NList, laCopy);
  List.Clear;
  for I := 0 to NList.Count - 1 do
    List.Add(NList[I]);

{  for i := 0 to List.Count-1 do
  begin
    TreeNode := TreeView.Items.Add(nil, TSQLTreeNode(List[i]).FName);
    TreeNode.HasChildren := True;
    TreeNode.Data := List[i];
  end;}
  NList.Free;
  Result := True;
end;

function TIBXDesignDataBaseEh.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Query: TIBQuery;
  i: Integer;
  dt: TFieldType;
  p: TParam;
begin
  Query := TIBQuery.Create(nil);
  Query.Database := FDatabase;
  Query.SQL.Text := SQL;
  if High(FParams) > Low(FParams) then
    for i := Low(FParams) to High(FParams) div 2 do
    begin
      dt := VarTypeToDataType(VarType(FParams[i*2+1]));
      if dt = ftUnknown then
        dt := ftString;
      p := Query.Params.CreateParam(dt, FParams[i*2], ptInputOutput);
      p.Value := FParams[i*2+1];
    end;
  try
    Query.Open;
  except
    Query.Free;
    raise;
  end;
  Result := Query;
end;

function TIBXDesignDataBaseEh.BuildOracleObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

procedure TIBXDesignDataBaseEh.EditDatabaseParams;
begin
//design-time EditIBDatabase(FDatabase);
{$IFDEF DESIGNTIME}
  EditIBDatabase(FDatabase);
{$ENDIF}
end;

function TIBXDesignDataBaseEh.GetEngineName: String;
begin
  Result := 'IBX';
end;

function TIBXDesignDataBaseEh.SupportCustomSQLDataDriver: Boolean;
begin
  Result := True;
end;

function TIBXDesignDataBaseEh.GetFieldList(const TableName: string;
  DataSet: TDataSet): Boolean;
var
  table: TIBTable;
  list: TStrings;
  i: Integer;

  procedure GetDataFieldNames(Dataset: TDataset; ErrorName: string; List: TStrings);
  var
    I: Integer;
  begin
    with Dataset do
    try
      FieldDefs.Update;
      List.BeginUpdate;
      try
        List.Clear;
        for I := 0 to FieldDefs.Count - 1 do
          List.Add(FieldDefs[I].Name);
      finally
        List.EndUpdate;
      end;
    except
      if ErrorName <> '' then
        MessageDlg(Format('SSQLDataSetOpen', [ErrorName]), mtError, [mbOK], 0);
    end;
  end;

  procedure SetKeyFields;
  var
    SepPos, I, Index: Integer;
    FName, FieldNames: string;
  begin
    table.IndexDefs.Update;
    for I := 0 to table.IndexDefs.Count - 1  do
      if ixPrimary in table.IndexDefs[I].Options then
      begin
        FieldNames := table.IndexDefs[I].Fields + ';';
        while Length(FieldNames) > 0 do
        begin
          SepPos := Pos(';', FieldNames);
          if SepPos < 1 then Break;
          FName := Copy(FieldNames, 1, SepPos - 1);
          System.Delete(FieldNames, 1, SepPos);
          Index := list.IndexOf(FName);
          if Index > -1 then list.Objects[Index] := TObject(1);
        end;
        break;
      end;
  end;

begin
  table := TIBTable.Create(nil);
  table.Database := FDatabase;
  table.TableName := TableName;
  list := TStringList.Create;
  GetDataFieldNames(table, 'Error', list);
  SetKeyFields;
  for i := 0 to list.Count-1 do
    if list.Objects[i] = TObject(1)
      then DataSet.AppendRecord([list[i], True])
      else DataSet.AppendRecord([list[i], False]);
  list.Free;
  table.Free;
  Result := True;
end;

function TIBXDesignDataBaseEh.GetConnected: Boolean;
begin
  Result := FDatabase.Connected;
end;

procedure TIBXDesignDataBaseEh.SetConnected(const Value: Boolean);
begin
  FDatabase.Connected := Value;
end;

function TIBXDesignDataBaseEh.GetCustomDBService: TCustomDBService;
begin
  Result := FDBService;
end;

function TIBXDesignDataBaseEh.GetIncrementObjectsList: TStrings;
begin
  if FUpdateObjectsList = nil then
    FUpdateObjectsList := TStringList.Create;
  if GetCustomDBService <> nil then
  begin
    FUpdateObjectsList.Assign(GetCustomDBService.GetIncrementObjectsList);
    Result := FUpdateObjectsList;
  end else
    Result := nil;
end;

function TIBXDesignDataBaseEh.GetSpecParamsList: String;
begin
  if GetCustomDBService <> nil then
    Result := GetCustomDBService.GetSpecParamsList;
end;

procedure TIBXDesignDataBaseEh.SetApplicationDatabase(const Value: TIBDatabase);
begin
  if FApplicationDatabase <> Value then
  begin
    FApplicationDatabase := Value;
    if FApplicationDatabase <> nil then
      FApplicationDatabase.FreeNotification(Self);
  end;
end;

procedure TIBXDesignDataBaseEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FApplicationDatabase = AComponent)
  then
    FApplicationDatabase := nil;
end;

{ TIBXAccessEngineEh }

function TIBXAccessEngineEh.AccessEngineName: String;
begin
  Result := 'IBX';
end;

//function TIBXAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh): TDesignDataBaseEh;
function TIBXAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
  DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh;
var
  IBXDesignDataBase: TIBXDesignDataBaseEh;
begin
  IBXDesignDataBase := TIBXDesignDataBaseEh.Create;
  IBXDesignDataBase.EditDatabaseParams;
  Result := IBXDesignDataBase;
//  DataDriver.DesignDataBase := IBXDesignDataBase;
end;

procedure Register;
begin
  RegisterComponents('EhLib', [TIBXDataDriverEh]);
{$IFDEF DESIGNTIME}
  RegisterComponentEditor(TIBXDataDriverEh, TSQLDataDriverEhEditor);
{$ENDIF}
end;

initialization
//  ShowMessage('Registering IBX');
  RegisterIBXAccessEngines;
//  ShowMessage('Registered IBX');
finalization
//  ShowMessage('UnRegistering IBX');
  UnregisterIBXAccessEngines;
//  ShowMessage('UnRegistered IBX');
end.
