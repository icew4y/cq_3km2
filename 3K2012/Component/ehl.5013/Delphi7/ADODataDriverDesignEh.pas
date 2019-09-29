{*******************************************************}
{                                                       }
{                     EhLib v5.0                        }
{                                                       }
{         TADODesignDataBaseEh (Build 5.0.00)           }
{                                                       }
{     Copyright (c) 2004-2007 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit ADODataDriverDesignEh;

{$I EHLIB.INC}

interface

{$IFDEF CIL}

//{$R DBXDataDriverEh.TDBXDataDriverEh.bmp}
{$R ADODataDriverEh.TADODataDriverEh.bmp}
//{$R BDEDataDriverEh.TBDEDataDriverEh.bmp}

{$ENDIF}

uses Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, ADODB, Dialogs,
  SQLDriverEditEh, ADODataDriverEh, ComCtrls, MemTableEh, Forms,
  UpdateSQLEditEh;

type

(*{ IADODesignDataBaseEh }

  IADODesignDataBaseEh = interface
  ['{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}']
    function GetConnection: TADOConnection;
  end;*)

{ TADODesignDataBaseEh }

  TADODesignDataBaseEh = class(TDesignDataBaseEh)//, IADODesignDataBaseEh)
  private
    FTablesMT: TMemTableEh;
    FColumnsMT: TMemTableEh;
    FConnection: TADOConnection;
    FTreeNodeMan: TCustomDBService;
    FDBServiceClass: TCustomDBServiceClass;
    FApplicationConnection: TADOConnection;
    procedure SetApplicationConnection(const Value: TADOConnection);
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
    function GetConnection: TADOConnection;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
    function BuildObjectTree(List: TList): Boolean; override;
//    function BuildInformixObjectTree(TreeView: TTreeView): Boolean;
    function BuildInterbaseObjectTree2(TreeView: TTreeView): Boolean;
    function BuildOracleObjectTree(TreeView: TTreeView): Boolean;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean; override;
    function GetSpecParamsList: String; override;
    function SupportCustomSQLDataDriver: Boolean; override;
    function GetCustomDBService: TCustomDBService; override;
    procedure EditDatabaseParams; override;
    property DBServiceClass: TCustomDBServiceClass read FDBServiceClass;
    property ApplicationConnection: TADOConnection read FApplicationConnection write SetApplicationConnection; 
  end;

{ TADOAccessEngineEh }

  TADOAccessEngineEh = class(TAccessEngineEh)
    function AccessEngineName: String; override;
    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
      DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh; override;
//    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh): TDesignDataBaseEh; override;
  end;

{ TADODesignDataBaseEh }

  TADOUniService = class(TCustomDBService)
  private
    FDesignDB: TDesignDataBaseEh;
    FSpecPraramsService: TCustomDBService;
    FNoAskForSpecPraramsService: Boolean;
  protected
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    destructor Destroy; override;
    function GetSpecParamsList: String; override;
    function ShowPopup(Source: TObject; Coord: TPoint; Params: TServicePopupParams): Integer; override;
    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); override;
    class function GetDBServiceName: String; override;
  end;

procedure UnregisterADOAccessEngines;
procedure RegisterADOAccessEngines;

procedure Register;

implementation

uses
{$IFDEF CIL}
  Borland.Vcl.Design.AdoConEd,
  Borland.Vcl.Design.AdoDBReg,
{$ELSE}
  AdoConEd,
{$ENDIF}
{$IFDEF DESIGNTIME}
	MemTableDesignEh,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
  Borland.Vcl.Design.DesignEditors,
{$ELSE}
  {$IFDEF EH_LIB_6}
     DesignIntf,
     DesignEditors,
  {$ELSE} //EH_LIB_6
      DsgnIntf,
  {$ENDIF}
  DBReg,
  ADOReg,
{$ENDIF}
{$ENDIF}
FormSelectFromList, DesignConnectionListEh, SelectFromListDialog;

(* как в MSSQL получить план запроса
1. использовать SET SHOWPLAN_TEXT { ON | OFF } или SET SHOWPLAN_ALL { ON | OFF } или аналогичные
т.е. в например в начале SQL запроса добавить SET SHOWPLAN_ALL ON
в конце SET SHOWPLAN_ALL OFF. отправить на сервер и в результате получишь датасет с тем что тебе надо.
*)

function GetServerName(IBDatabase: TADOConnection; var ServerName: String): Boolean;
begin
  ServerName := 'MSACCESS';//AnsiUpperCase(IBDatabase.DriverName);
  Result := True;
end;

//var
//  DataBaseInc: Integer = 0;

function GUISelectADOAccessEngine(SelectDBService: TSelectDBService): Boolean;
var
  f: TfSelectFromList;
begin
  Result := False;
  f := TfSelectFromList.Create(Application);
  f.cbEngine.Items := AccessEngineList;
  f.cbEngine.ItemIndex := f.cbEngine.Items.IndexOf('ADO');
  f.cbEngine.Enabled := False;
  f.cbDBService.Items := GetDBServiceList;
  f.eDataBaseName.Text := SelectDBService.DBName;
  f.DBServiceEngineList := GetDBServiceEngineList;
  if f.ShowModal = mrOk then
  begin
    if f.cbEngine.ItemIndex >= 0
      then SelectDBService.AccessEngine := TAccessEngineEh(AccessEngineList.Objects[f.cbEngine.ItemIndex])
      else SelectDBService.AccessEngine := nil;
    if f.cbDBService.ItemIndex >= 0
      then SelectDBService.DBServiceClass := TCustomDBServiceClass(f.cbDBService.Items.Objects[f.cbDBService.ItemIndex])
//      then SelectDBService.DBServiceClass := TCustomDBServiceClass(DBServiceList.Objects[f.cbDBService.ItemIndex])
      else SelectDBService.DBServiceClass := nil;
    SelectDBService.DBName := f.eDataBaseName.Text;
    Result := True;
  end;
  f.Free;
end;

{function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'ADODataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;
}

{function CreateDesignDataBase(DataDriver: TADODataDriverEh): TComponent;
var
  DesignDataBase: TADODesignDataBaseEh;
//  SourceIBDatabase: TADOConnection;
begin
  DesignDataBase :=  TADODesignDataBaseEh.Create;
//  SourceIBDatabase := TADOConnection.Create(nil);
  if DataDriver.ADOConnection <> nil then
  begin
    DesignDataBase.FConnection.ConnectionString := DataDriver.ADOConnection.ConnectionString;
  end;
//    SourceIBDatabase.FDBEDataBase.DatabaseName := GetUnicalDataBaseName;
  Result := DesignDataBase;
end;
}

procedure SetDesignADODataBaseProcEh(DataDriver: TCustomSQLDataDriverEh);
var
  i: Integer;
  DesignDataBase: TComponent;
  sdb: TSelectDBService;
  ADODesignDataBase: TADODesignDataBaseEh;
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
    begin
      sdb := TSelectDBService.Create;
      if GUISelectADOAccessEngine(sdb) and (sdb.AccessEngine <> nil) then
      begin
        if sdb.AccessEngine is TADOAccessEngineEh then
        begin
          ADODesignDataBase := TADODesignDataBaseEh.Create;
          ADODesignDataBase.FDBServiceClass := sdb.DBServiceClass;
          if (ADODesignDataBase is TADODesignDataBaseEh) and
              (DataDriver is TADODataDriverEh) and
              (TADODataDriverEh(DataDriver).ADOConnection <> nil)
          then
          begin
            ADODesignDataBase.FConnection.ConnectionString :=
              TADODataDriverEh(DataDriver).ADOConnection.ConnectionString;
            ADODesignDataBase.ApplicationConnection := TADODataDriverEh(DataDriver).ADOConnection;
          end;  
          ADODesignDataBase.EditDatabaseParams;
          DataDriver.DesignDataBase := ADODesignDataBase;
        end else
          DataDriver.DesignDataBase :=
            sdb.AccessEngine.CreateDesignDataBase(DataDriver, sdb.DBServiceClass, sdb.DBName);
      end;
      sdb.Free;
    end;
//    DataDriver.DesignDataBase := CreateDesignDataBase(TADODataDriverEh(DataDriver));
  end;
end;

{ TADODesignDataBaseEh }

function TADODesignDataBaseEh.BuildObjectTree(List: TList): Boolean;
var
  NList: Tlist;
  i: Integer;
//TreeNode: TTreeNode;
begin
  Result := False;
//  TreeView.Items.Clear;
  if Assigned(FDBServiceClass) then
  begin
    if FTreeNodeMan <> nil then
      FTreeNodeMan.Free;
    FTreeNodeMan := FDBServiceClass.Create(Self);
    NList := FTreeNodeMan.CreateRootNodes;
//    List.Assign(NList, laCopy);
    List.Clear;
    for I := 0 to NList.Count - 1 do
      List.Add(NList[I]);

//    List.Free;
//    List := FTreeNodeMan.CreateRootNodes;
{    for i := 0 to List.Count-1 do
    begin
      TreeNode := TreeView.Items.Add(nil, TSQLTreeNode(List[i]).FName);
      TreeNode.HasChildren := True;
      TreeNode.Data := List[i];
    end;}
    NList.Free;
    Result := True;
  end;

{  if ServerTypeName = 'INFORMIX' then
//    Result := BuildInformixObjectTree(TreeView)
  else if ServerTypeName = 'INTERBASE' then
    Result := BuildInterbaseObjectTree2(TreeView)
  else
    Result := False;}
end;

function TADODesignDataBaseEh.BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := EditDataDriverUpdateSQL(DataDriver as TCustomSQLDataDriverEh);// UpdateSQLEditEh
end;

constructor TADODesignDataBaseEh.Create;
begin
  inherited Create;
  FConnection := TADOConnection.Create(Application);
//  FConnection := TADOConnection.Create(nil);
  FTablesMT := TMemTableEh.Create(nil);
  FColumnsMT := TMemTableEh.Create(nil);
end;

destructor TADODesignDataBaseEh.Destroy;
begin
//  FConnection.Free; Will be deleted in TApplication
  FTablesMT.Free;
  FColumnsMT.Free;
  FTreeNodeMan.Free;
  inherited Destroy;
end;

function TADODesignDataBaseEh.CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
begin
  Result := TADODataDriverEh.Create(nil);
  Result.SelectCommand := RTDataDriver.SelectCommand;
  Result.UpdateCommand := RTDataDriver.UpdateCommand;
  Result.InsertCommand := RTDataDriver.InsertCommand;
  Result.DeleteCommand := RTDataDriver.DeleteCommand;
  Result.GetrecCommand := RTDataDriver.GetrecCommand;
  TADODataDriverEh(Result).SpecParams := TADODataDriverEh(RTDataDriver).SpecParams;
  TADODataDriverEh(Result).ADOConnection := FConnection;
end;

function TADODesignDataBaseEh.DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
  if DataDriver is TADODataDriverEh then
  begin
    if TADODataDriverEh(DataDriver).ADOConnection <> nil then
      Result := (ApplicationConnection = TADODataDriverEh(DataDriver).ADOConnection)
    else
      Result := (FConnection.ConnectionString = TADODataDriverEh(DataDriver).ConnectionString);
  end;  
end;

function TADODesignDataBaseEh.Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  Result := -1;
  FreeOnEof := True;
  with Command do
    case CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          Cursor := TADOQuery.Create(nil);
          with Cursor as TADOQuery do
          begin
            Connection := FConnection;
            SQL.Text := Command.CommandText.Text;
            Parameters.Assign(Command.GetParams);
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
          Cursor := TADOTable.Create(nil);
          with Cursor as TADOTable do
          begin
            Connection := FConnection;
            TableName := Command.CommandText.Text;
//            Params := Command.Params;
            Open;
          end;
        end;
      cthStoredProc:
        begin
          Cursor := TADOStoredProc.Create(nil);
          with Cursor as TADOStoredProc do
          begin
            Connection := FConnection;
            ProcedureName := Command.CommandText.Text;
            Parameters.Assign(Command.GetParams);
            ExecProc;
          end;
        end;
    end;
end;

function TADODesignDataBaseEh.GetConnection: TADOConnection;
begin
  Result := FConnection;
end;

function TADODesignDataBaseEh.ServerTypeName: String;
var
  Description: String;
begin
//  if not SQLCo.Connected then
//    FDBEDataBase.Open;
  if GetServerName(FConnection, Description) then
  begin
    Result := UpperCase(Description);
  end;
end;

function TADODesignDataBaseEh.BuildInterbaseObjectTree2(TreeView: TTreeView): Boolean;
var
  List: Tlist;
  i: Integer;
  TreeNode: TTreeNode;
begin
  if FTreeNodeMan <> nil then
    FTreeNodeMan.Free;
  FTreeNodeMan := TInterbaseDBService.Create(Self);
  List := FTreeNodeMan.CreateRootNodes;
  for i := 0 to List.Count-1 do
  begin
    TreeNode := TreeView.Items.Add(nil, TSQLTreeNode(List[i]).FName);
    TreeNode.HasChildren := True;
    TreeNode.Data := List[i];
  end;
  List.Free;
  Result := True;
end;

function TADODesignDataBaseEh.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Query: TADOQuery;
  i: Integer;
  dt: TFieldType;
  p: TParam;
  Params: TParams;
begin
  Query := TADOQuery.Create(nil);
  Query.Connection := FConnection;
  Query.SQL.Text := SQL;
  Params := TParams.Create;
  try
    if High(FParams) > Low(FParams) then
      for i := Low(FParams) to High(FParams) div 2 do
      begin
        dt := VarTypeToDataType(VarType(FParams[i*2+1]));
        if dt = ftUnknown then
          dt := ftString;
        p := Params.CreateParam(dt, FParams[i*2], ptInputOutput);
        p.Value := FParams[i*2+1];
      end;
    Query.Parameters.Assign(Params);
  finally
    Params.Free;
  end;
  try
    Query.Open;
  except
    Query.Free;
    raise;
  end;
  Result := Query;
end;

function TADODesignDataBaseEh.BuildOracleObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

procedure TADODesignDataBaseEh.EditDatabaseParams;
begin
  EditConnectionString(FConnection);
//  inherited;
end;

function TADODesignDataBaseEh.GetEngineName: String;
begin
  Result := 'ADO';
end;

function TADODesignDataBaseEh.GetConnected: Boolean;
begin
  Result := FConnection.Connected;
end;

procedure TADODesignDataBaseEh.SetConnected(const Value: Boolean);
begin
  FConnection.Connected := Value;
end;

function TADODesignDataBaseEh.SupportCustomSQLDataDriver: Boolean;
begin
  Result := True;
end;

function TADODesignDataBaseEh.GetFieldList(const TableName: string;
  DataSet: TDataSet): Boolean;
var
  table: TADOTable;
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
{$IFDEF CIL}
          Borland.Delphi.System.Delete(FieldNames, 1, SepPos);
{$ELSE}
          System.Delete(FieldNames, 1, SepPos);
{$ENDIF}
          Index := list.IndexOf(FName);
          if Index > -1 then list.Objects[Index] := TObject(1);
        end;
        break;
      end;
  end;

begin
  table := TADOTable.Create(nil);
  table.Connection := FConnection;
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

function TADODesignDataBaseEh.GetSpecParamsList: String;
begin
  if FTreeNodeMan <> nil then
  begin
    Result := FTreeNodeMan.GetSpecParamsList;
  end;
end;

function TADODesignDataBaseEh.GetCustomDBService: TCustomDBService;
begin
  Result := FTreeNodeMan;
end;

procedure TADODesignDataBaseEh.SetApplicationConnection(const Value: TADOConnection);
begin
  if FApplicationConnection <> Value then
  begin
    FApplicationConnection := Value;
    if FApplicationConnection <> nil then
      FApplicationConnection.FreeNotification(Self);
  end;
end;

procedure TADODesignDataBaseEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FApplicationConnection = AComponent)
  then
    FApplicationConnection := nil;
end;

{ TADOAccessEngineEh }

function TADOAccessEngineEh.AccessEngineName: String;
begin
  Result := 'ADO';
end;

//function TADOAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh): TDesignDataBaseEh;
function TADOAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
  DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh;
var
  ADODesignDataBase: TADODesignDataBaseEh;
begin
  ADODesignDataBase := TADODesignDataBaseEh.Create;
  ADODesignDataBase.FDBServiceClass := DBServiceClass;
  ADODesignDataBase.EditDatabaseParams;
  Result := ADODesignDataBase;
//  DataDriver.DesignDataBase := ADODesignDataBase;
end;

procedure RegisterADOAccessEngines;
var
  Engine: TADOAccessEngineEh;
begin
  RegisterDesignDataBuilderProcEh(TADODataDriverEh, SetDesignADODataBaseProcEh);
  Engine := TADOAccessEngineEh.Create;
  RegisterAccessEngine('ADO', Engine);
  RegisterDBServiceEngine(Engine, TADOUniService);
  RegisterDBServiceEngine(Engine, TMSSQLDBService);
  RegisterDBServiceEngine(Engine, TOracleDBService);
  RegisterDBServiceEngine(Engine, TInterbaseDBService);
  RegisterDBServiceEngine(Engine, TInformixDBService);
  RegisterDBService('ADOUniService', TADOUniService);
end;

procedure UnregisterADOAccessEngines;
begin
  UnregisterDesignDataBuilderProcEh(TADODataDriverEh);
  UnregisterAccessEngine('ADO');
  UnregisterDBServiceEngine(TADOUniService);
  UnregisterDBServiceEngine(TMSSQLDBService);
  UnregisterDBServiceEngine(TOracleDBService);
  UnregisterDBServiceEngine(TInterbaseDBService);
  UnregisterDBServiceEngine(TInformixDBService);
  UnregisterDBService('ADOUniService');
//  UnregisterDBServiceEngine(Engine, BDEUniService);
end;

{ TADOUniService }

constructor TADOUniService.Create(ADesignDB: TDesignDataBaseEh);
var
  Template: TSQLTreeNodeTemplate;
begin
  inherited Create(ADesignDB);
  FDesignDB := ADesignDB;

  AddSQLClass('ServerItems', 'ServerItems');
  AddSQLClass('Tables', 'Tables');
  AddSQLClass('Views', 'Views');
  AddSQLClass('Synonyms', 'Synonyms');
  AddSQLClass('SystemTables', 'SystemTables');
  AddSQLClass('TableColumns', 'TableColumns');
  AddSQLClass('Procedures', 'Procedures');
  AddSQLClass('ProcedureParameters', 'ProcedureParameters');

//Some ADO Server
  Template := TSQLTreeNodeTemplate.Create(Self, 'ADO Server');
  with Template do
  begin
    NodesSQLClassName :=  'ServerItems';
    MasterTemplateName := '';
    NodesMemTableName :=  'ServerItems';
    // Params             [], //Params
    ObjIdFieldName :=     'OBJ_NAME';
    InTreeTextFieldName :='OBJ_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'OBJ_NAME';
    //ColumnAttributesStr :=
  end;

//Tables
  Template := TSQLTreeNodeTemplate.Create(Self, 'Tables');
  with Template do
  begin
    NodesSQLClassName :=  'Tables';
    MasterTemplateName := 'Tables';
    NodesMemTableName :=  'TableObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid := 'TABLE_NAME';
    ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//Views
  Template := TSQLTreeNodeTemplate.Create(Self, 'Views');
  with Template do
  begin
    NodesSQLClassName :=  'Views';
    MasterTemplateName := 'Views';
    NodesMemTableName :=  'ViewObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid := 'TABLE_NAME';
    ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//Sinonims
  Template := TSQLTreeNodeTemplate.Create(Self, 'Synonyms');
  with Template do
  begin
    NodesSQLClassName :=  'Synonyms';
    MasterTemplateName := 'Synonyms';
    NodesMemTableName :=  'SynonymObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid := 'TABLE_NAME';
    ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//SystemTables
  Template := TSQLTreeNodeTemplate.Create(Self, 'SystemTables');
  with Template do
  begin
    NodesSQLClassName :=  'SystemTables';
    MasterTemplateName := 'SystemTables';
    NodesMemTableName :=  'SystemTableObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid := 'TABLE_NAME';
    ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//TableColumns
  Template := TSQLTreeNodeTemplate.Create(Self, 'TableColumns');
  with Template do
  begin
    NodesSQLClassName :=  'TableColumns';
    MasterTemplateName := '';
    NodesMemTableName :=  'TableColumns';
    // Params             [], //Params
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='COLUMN_NAME';
    HasNodes :=           False;
    NodesFilter :=        '[TABLE_NAME] = ''%[TABLE_NAME]''';
//    NodesFieldsInGrid :=  'COLUMN_NAME;DATA_TYPE;IS_NULLABLE;COLUMN_DEFAULT';
    ColumnAttributesStr :='"COLUMN_NAME", "Column name", "100", '+
      '"DATA_TYPE",  "Type", "50", '+
      '"IS_NULLABLE", "Can Null", "20", ' +
      '"COLUMN_DEFAULT", "Def. Value", "50" ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//Procedures
  Template := TSQLTreeNodeTemplate.Create(Self, 'Procedures');
  with Template do
  begin
    NodesSQLClassName :=  'Procedures';
    MasterTemplateName := 'Procedures';
    NodesMemTableName :=  'ProceduresObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'PROCEDURE_NAME';
    InTreeTextFieldName :='PROCEDURE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'PROCEDURE_NAME';
    ColumnAttributesStr := '"PROCEDURE_NAME", "Name", "100", ' +
    '"DESCRIPTION", "Description", 100, ' +
    '"PROCEDURE_TYPE", "Type", 30, ' +
    '"PROCEDURE_CATALOG", "Catalog", 100, ' +
    '"PROCEDURE_SCHEMA", "Schema", 100, ' +
    '"PROCEDURE_DEFINITION", "Definition", 100 ';
  end;

//Parameters
  Template := TSQLTreeNodeTemplate.Create(Self, 'ProcedureParameters');
  with Template do
  begin
    NodesSQLClassName :=  'ProcedureParameters';
    MasterTemplateName := '';
    NodesMemTableName :=  'ProcedureParameters';
    // Params             [], //Params
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='PARAMETER_NAME';
    HasNodes :=           False;
    NodesFilter :=        '[PROCEDURE_NAME] = ''%[PROCEDURE_NAME]''';
//    NodesFieldsInGrid :=  'PARAMETER_NAME;DATA_TYPE;IS_RESULT';
    ColumnAttributesStr :='"PARAMETER_NAME", "Param name", "100", '+
      '"DATA_TYPE",  "Type", "50", '+
      '"IS_RESULT", "Is Result", "20"';
  end;

(*
//Views
  TSQLTreeNodeTemplate.Create(
    Self,
    'Views',
    'Views', //NodesSQLClassName

    'Views', //MasterTemplateName
    'ViewsObjects', //NodesMemTableName
    [], //Params
    'TABLE_NAME', //ObjIdFieldName
    'TABLE_NAME', //InTreeTextFieldName
    True,
    '',
    'TABLE_NAME',
    '"TABLE_NAME", "View name", "200" '
    );

*)
end;

destructor TADOUniService.Destroy;
begin
  FreeAndNil(FSpecPraramsService);
  inherited Destroy;
end;

function TADOUniService.ShowPopup(Source: TObject; Coord: TPoint;
  Params: TServicePopupParams): Integer;
begin
  Result := -1;
end;

function TADOUniService.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Connection: TADOConnection;
  ADOReader: TADODataSet;
  Reader: TMemTableEh;
  DataField: TMTDataFieldEh;

  procedure CreateAdditionalFields(DataStruct: TMTDataStructEh);
  begin
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'TEMPLATE_NAME';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'NODES_SQLCLASS_NAME';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'LOCAL_FILTER';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTNumericDataFieldEh);
    DataField.FieldName := 'Image_Index';
  end;
begin
  Connection := TADODesignDataBaseEh(FDesignDB).GetConnection;
//  Connection.CheckActive;
  Reader := nil;
  ADOReader := TADODataSet.Create(nil);
  try
    if SQL = 'ServerItems' then
    begin
      Reader := TMemTableEh.Create(nil);
//Build Struct
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'OBJ_NAME';
      DataField.Size := 20;
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
//      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      Reader.Open;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Tables';
      Reader['TEMPLATE_NAME'] := 'Tables';
      Reader['NODES_SQLCLASS_NAME'] := 'TableObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 0;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Views';
      Reader['TEMPLATE_NAME'] := 'Views';
      Reader['NODES_SQLCLASS_NAME'] := 'ViewsObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Synonyms';
      Reader['TEMPLATE_NAME'] := 'Synonyms';
      Reader['NODES_SQLCLASS_NAME'] := 'SynonymObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'SystemTables';
      Reader['TEMPLATE_NAME'] := 'SystemTables';
      Reader['NODES_SQLCLASS_NAME'] := 'SystemTablesObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Procedures';
      Reader['TEMPLATE_NAME'] := 'Procedures';
      Reader['NODES_SQLCLASS_NAME'] := 'Procedures';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 3;
      Reader.Post;

{      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TEMPLATE_NAME';
        Reader['NODES_SQLCLASS_NAME'] := 'NODES_SQLCLASS_NAME';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;}
    end else if SQL = 'Tables' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('TABLE')]), EmptyParam, ADOReader);
//      Connection.OpenSchema(siTables, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Views' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('VIEW')]), EmptyParam, ADOReader);
//      Connection.OpenSchema(siViews, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Synonyms' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('SYNONYM')]), EmptyParam, ADOReader);
//      Connection.OpenSchema(siViews, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'SystemTables' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('SYSTEM TABLE')]), EmptyParam, ADOReader);
//      Connection.OpenSchema(siViews, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'TableColumns' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siColumns, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'ID';
      DataField.Size := 100;
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ViewColumnsProps';
        Reader['NODES_SQLCLASS_NAME'] := 'NODES_SQLCLASS_NAME';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 4;
        Reader['ID'] := Reader['COLUMN_NAME'] + '.' + Reader['TABLE_NAME'];
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Procedures' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siProcedures, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ProcedureParameters';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'ProcedureParameters' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siProcedureParameters, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'ID';
      DataField.Size := 100;
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ViewProceduresColumnsProps';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 4;
        Reader['ID'] := Reader['PARAMETER_NAME'] + '.' + Reader['PROCEDURE_NAME'];
        Reader.Post;
        Reader.Next;
      end;
     end;
  finally
    ADOReader.Free;
  end;
  Result := Reader;
end;

class function TADOUniService.GetDBServiceName: String;
begin
  Result := 'ADOUniService';
end;

function TADOUniService.GetSpecParamsList: String;
var
  s: TStringList;
  i: Integer;
begin
  if (FSpecPraramsService = nil) and not FNoAskForSpecPraramsService then
  begin
    s := TStringList.Create;
    for i := 0 to GetDBServiceList.Count-1 do
      s.Add(GetDBServiceList[i]);
    i := SelectFromList(s);
    if i <> -1 then
      FSpecPraramsService := GetDBServiceByName(s[i]).Create(FDesignDB);
    s.Free;
  end;
  if FSpecPraramsService <> nil then
    Result := FSpecPraramsService.GetSpecParamsList;
end;

procedure TADOUniService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
var
  s: TStringList;
  i: Integer;
begin
  if (FSpecPraramsService = nil) and not FNoAskForSpecPraramsService then
  begin
    s := TStringList.Create;
    for i := 0 to GetDBServiceList.Count-1 do
      s.Add(GetDBServiceList[i]);
    i := SelectFromList(s);
    if i <> -1 then
      FSpecPraramsService := GetDBServiceByName(s[i]).Create(FDesignDB);
    s.Free;
  end;
  if FSpecPraramsService <> nil then
    FSpecPraramsService.GenGetSpecParams(DesignUpdateParams, DesignUpdateInfo);
end;

{$IFDEF EH_LIB_6}
{$IFDEF DESIGNTIME}
{ TDataDriverEhSelectionEditor }

type
 TADODataDriverEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;

procedure TADODataDriverEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
   Proc('ADODB');
end;
{$ENDIF}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('EhLib', [TADODataDriverEh]);
{$IFDEF DESIGNTIME}
  RegisterComponentEditor(TADODataDriverEh, TSQLDataDriverEhEditor);
  RegisterPropertyEditor(TypeInfo(WideString), TADODataDriverEh, 'ConnectionString', TConnectionStringProperty);
{$IFDEF EH_LIB_6}
  RegisterSelectionEditor(TADODataDriverEh, TADODataDriverEhSelectionEditor);
{$ENDIF}
{$ENDIF}
end;

initialization
  RegisterADOAccessEngines();
finalization
//  ShowMessage('UnRegistering ADO');
  UnregisterADOAccessEngines();
//  ShowMessage('UnRegistered ADO');
end.

