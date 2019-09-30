{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       UpdateSQL Component Editor                      }
{                                                       }
{       Copyright (c) 1997,1999 Borland Software Corp.  }
{                                                       }
{       Changed by Dmitry V. Bolshakov                  }
{                      Build 5.0.00                     }
{                                                       }
{*******************************************************}

unit UpdateSQLEditEh;

{$I EHLIB.INC}

interface

uses Forms, DB, ExtCtrls, StdCtrls, Controls, ComCtrls,
  Classes, SysUtils, Windows, Menus, DataDriverEh, MemTableEh, Graphics,
{$IFDEF EH_LIB_6}
  Variants,
{$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  Mask, DBCtrlsEh, MemTableDataEh;

type

  TWaitMethod = procedure of object;

  TUpdateSQLEditFormEh = class(TForm)
    OkButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    GenerateButton: TButton;
    PrimaryKeyButton: TButton;
    DefaultButton: TButton;
    UpdateTableName: TComboBox;
    FieldsPage: TTabSheet;
    SQLPage: TTabSheet;
    PageControl: TPageControl;
    KeyFieldList: TListBox;
    UpdateFieldList: TListBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    FTempTable: TMemTableEh;
    QuoteFields: TCheckBox;
    GetTableFieldsButton: TButton;
    FieldListPopup: TPopupMenu;
    miSelectAll: TMenuItem;
    miClearAll: TMenuItem;
    PageControl1: TPageControl;
    tsInsert: TTabSheet;
    tsModify: TTabSheet;
    tsDelete: TTabSheet;
    tsGetrec: TTabSheet;
    MemoInsert: TMemo;
    MemoModify: TMemo;
    MemoDelete: TMemo;
    MemoGetRec: TMemo;
    cbUpdate: TCheckBox;
    cbDelete: TCheckBox;
    cbGetRec: TCheckBox;
    cbInsert: TCheckBox;
    cbIncrementField: TComboBox;
    Label2: TLabel;
    cbIncrementObject: TComboBox;
    labelUpdateObjects: TLabel;
    tsSpecParams: TTabSheet;
    cbSpecParams: TCheckBox;
    Panel11: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    cbUpdateFields: TCheckBox;
    cbKeyFields: TCheckBox;
    cbTableName: TCheckBox;
    Label7: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Label8: TLabel;
    Bevel4: TBevel;
    bLoadSpecString: TButton;
    mSpecParams: TMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    MemoUpdateFields: TMemo;
    MemoKeyFields: TMemo;
    dbeTableName: TDBEditEh;
    procedure FormCreate(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure DefaultButtonClick(Sender: TObject);
    procedure GenerateButtonClick(Sender: TObject);
    procedure PrimaryKeyButtonClick(Sender: TObject);
    procedure PageControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure GetTableFieldsButtonClick(Sender: TObject);
    procedure SettingsChanged(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure UpdateTableNameChange(Sender: TObject);
    procedure UpdateTableNameClick(Sender: TObject);
    procedure SelectAllClick(Sender: TObject);
    procedure ClearAllClick(Sender: TObject);
    procedure cbInsertClick(Sender: TObject);
    procedure MemoModifyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    DataDriver: TCustomSQLDataDriverEh;
    FSettingsChanged: Boolean;
    FDatasetDefaults: Boolean;
    function GetTableRef(const TabName, QuoteChar: string): string;
    function Edit: Boolean;
    procedure GenWhereClause(const TabAlias, QuoteChar: string; KeyFields, SQL: TStrings);
    procedure GenDeleteSQL(const TableName, QuoteChar: string; KeyFields, SQL: TStrings);
    procedure GenInsertSQL(const TableName, QuoteChar: string; UpdateFields, SQL: TStrings);
    procedure GenModifySQL(const TableName, QuoteChar: string; KeyFields, UpdateFields, SQL: TStrings);
    procedure GenGetRecSQL(SelectSQL, KeyFields, SQL: TStrings);
    procedure GenerateSQL;
    procedure FillMemoFromList(Memo: TMemo; List: TListBox);
    procedure GenerateSQLViaDBService;
    procedure GetDataSetFieldNames;
    procedure GetTableFieldNames;
    procedure InitGenerateOptions;
    procedure InitUpdateTableNames;
    procedure SetButtonStates;
    procedure SelectPrimaryKeyFields;
    procedure SetDefaultSelections;
    procedure ShowWait(WaitMethod: TWaitMethod);
//    function TempTable: TMemTableEh;
  end;

{ TSQLParser }

  TSQLToken = (stSymbol, stAlias, stNumber, stComma, stEQ, stOther, stLParen,
    stRParen, stEnd);

  TSQLParser = class
  private
    FText: string;
    FSourcePtr: Integer;
    FTokenPtr: Integer;
    FTokenString: string;
    FToken: TSQLToken;
    FSymbolQuoted: Boolean;
    function NextToken: TSQLToken;
    function TokenSymbolIs(const S: string): Boolean;
    procedure Reset;
  public
    constructor Create(const Text: string);
    procedure GetSelectTableNames(List: TStrings);
    procedure GetUpdateTableName(var TableName: string);
    procedure GetUpdateFields(List: TStrings);
    procedure GetWhereFields(List: TStrings);
  end;

function EditDataDriverUpdateSQL(ADataDriver: TCustomSQLDataDriverEh): Boolean;

implementation

{$R *.dfm}

uses Dialogs, TypInfo, SQLDriverEditEh;

{ Global Interface functions }

function EditDataDriverUpdateSQL(ADataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  with TUpdateSQLEditFormEh.Create(Application) do
  try
    DataDriver := ADataDriver;
    Result := Edit;
  finally
    Free;
  end;
end;

{ Utility Routines }

procedure GetSelectedItems(ListBox: TListBox; List: TStrings);
var
  I: Integer;
begin
  List.Clear;
  for I := 0 to ListBox.Items.Count - 1 do
    if ListBox.Selected[I] then
      List.Add(ListBox.Items[I]);
end;

function SetSelectedItems(ListBox: TListBox; List: TStrings): Integer;
var
  I: Integer;
begin
  Result := 0;
  ListBox.Items.BeginUpdate;
  try
    for I := 0 to ListBox.Items.Count - 1 do
      if List.IndexOf(ListBox.Items[I]) > -1 then
      begin
        ListBox.Selected[I] := True;
        Inc(Result);
      end
      else
        ListBox.Selected[I] := False;
    if ListBox.Items.Count > 0 then
    begin
      ListBox.ItemIndex := 0;
      ListBox.TopIndex := 0;
    end;
  finally
    ListBox.Items.EndUpdate;
  end;
end;

procedure SelectAll(ListBox: TListBox);
var
  I: Integer;
begin
  ListBox.Items.BeginUpdate;
  try
    with ListBox do
      for I := 0 to Items.Count - 1 do
        Selected[I] := True;
    if ListBox.Items.Count > 0 then
    begin
      ListBox.ItemIndex := 0;
      ListBox.TopIndex := 0;
    end;
  finally
    ListBox.Items.EndUpdate;
  end;
end;

{procedure GetDataFieldNames(Dataset: TDataset; ErrorName: string; List: TStrings);
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
}

procedure GetSQLTableNames(const SQL: string; List: TStrings);
begin
  with TSQLParser.Create(SQL) do
  try
    GetSelectTableNames(List);
  finally
    Free;
  end;
end;

procedure ParseUpdateSQL(const SQL: string; var TableName: string;
  UpdateFields: TStrings; WhereFields: TStrings);
begin
  with TSQLParser.Create(SQL) do
  try
    GetUpdateTableName(TableName);
    if Assigned(UpdateFields) then
    begin
      Reset;
      GetUpdateFields(UpdateFields);
    end;
    if Assigned(WhereFields) then
    begin
      Reset;
      GetWhereFields(WhereFields);
    end;
  finally
    Free;
  end;
end;

{ TSQLParser }

constructor TSQLParser.Create(const Text: string);
begin
  inherited Create;
  FText := Text;
  FText := FText + #0;
  FSourcePtr := 1;
  NextToken;
end;

function TSQLParser.NextToken: TSQLToken;
var
  P, TokenStart: Integer;
  QuoteChar: Char;
  IsParam: Boolean;

{$IFDEF CIL}
{$ELSE}
  function IsKatakana(const Chr: Byte): Boolean;
  begin
    Result := (SysLocale.PriLangID = LANG_JAPANESE) and (Chr in [$A1..$DF]);
  end;
{$ENDIF}

begin
  if FToken = stEnd then SysUtils.Abort;
  FTokenString := '';
  FSymbolQuoted := False;
  P := FSourcePtr;
  while (FText[P] <> #0) and (FText[P] <= ' ') do Inc(P);
  FTokenPtr := P;
  case FText[P] of
    'A'..'Z', 'a'..'z', '_', '$', #127..High(Char):
      begin
        TokenStart := P;
        if not SysLocale.FarEast then
        begin
          Inc(P);
          while CharInSetEh(FText[P], ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', '"', '$'])
            or (FText[P] > #127)
          do
            Inc(P);
        end
        else
          begin
            while TRUE do
            begin
              if CharInSetEh(FText[P],
                    ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', '"', '$'])
{$IFDEF CIL}
{$ELSE}
                 or IsKatakana(Byte(FText[P]))
{$ENDIF}
              then
                Inc(P)
              else
                if CharInSetEh(FText[P], LeadBytes) then
                  Inc(P, 2)
                else
                  Break;
            end;
          end;
        FTokenString := Copy(FText, TokenStart, P - TokenStart);

//        SetString(FTokenString, TokenStart, P - TokenStart);
        FToken := stSymbol;
      end;
    '''', '"':
      begin
        QuoteChar := FText[P];
        Inc(P);
        IsParam := FText[P] = ':';
        if IsParam then Inc(P);
        TokenStart := P;
        while not CharInSetEh(FText[P], [AnsiChar(QuoteChar)]) and not (FText[P] = #0) do
          Inc(P);
        FTokenString := Copy(FText, TokenStart, P - TokenStart);
//        SetString(FTokenString, TokenStart, P - TokenStart);
        Inc(P);
        Trim(FTokenString);
        FToken := stSymbol;
        FSymbolQuoted := True;
      end;
    '-', '0'..'9':
      begin
        TokenStart := P;
        Inc(P);
        while CharInSetEh(FText[P], ['0'..'9', '.', 'e', 'E', '+', '-']) do
          Inc(P);
        FTokenString := Copy(FText, TokenStart, P - TokenStart);
//        SetString(FTokenString, TokenStart, P - TokenStart);
        FToken := stNumber;
      end;
    ',':
      begin
        Inc(P);
        FToken := stComma;
      end;
    '=':
      begin
        Inc(P);
        FToken := stEQ;
      end;
    '(':
      begin
        Inc(P);
        FToken := stLParen;
      end;
    ')':
      begin
        Inc(P);
        FToken := stRParen;
      end;
    #0:
      FToken := stEnd;
  else
    begin
      FToken := stOther;
      Inc(P);
    end;
  end;
  FSourcePtr := P;
  if (FToken = stSymbol) and
    (FTokenString[Length(FTokenString)] = '.') then FToken := stAlias;
  Result := FToken;
end;

procedure TSQLParser.Reset;
begin
//  FSourcePtr := PChar(FText);
  FSourcePtr := 1;
  FToken := stSymbol;
  NextToken;
end;

function TSQLParser.TokenSymbolIs(const S: string): Boolean;
begin
  Result := (FToken = stSymbol) and (CompareText(FTokenString, S) = 0);
end;

procedure TSQLParser.GetSelectTableNames(List: TStrings);
begin
  List.BeginUpdate;
  try
    List.Clear;
    if TokenSymbolIs('SELECT') then { Do not localize }
    try
      while not TokenSymbolIs('FROM') do NextToken; { Do not localize }
      NextToken;
      while FToken = stSymbol do
      begin
{$IFDEF CIL}
        List.AddObject(FTokenString, TObject(FSymbolQuoted));
{$ELSE}
        List.AddObject(FTokenString, Pointer(Integer(FSymbolQuoted)));
{$ENDIF}
        if NextToken = stSymbol then NextToken;
        if FToken = stComma
          then NextToken
          else break;
      end;
    except
    end;
  finally
    List.EndUpdate;
  end;
end;

procedure TSQLParser.GetUpdateTableName(var TableName: string);
begin
  if TokenSymbolIs('UPDATE') and (NextToken = stSymbol) then { Do not localize }
    TableName := FTokenString else
    TableName := '';
end;

procedure TSQLParser.GetUpdateFields(List: TStrings);
begin
  List.BeginUpdate;
  try
    List.Clear;
    if TokenSymbolIs('UPDATE') then { Do not localize }
    try
      while not TokenSymbolIs('SET') do NextToken; { Do not localize }
      NextToken;
      while True do
      begin
        if FToken = stAlias then NextToken;
        if FToken <> stSymbol then Break;
        List.Add(FTokenString);
        if NextToken <> stEQ then Break;
        while NextToken <> stComma do
          if TokenSymbolIs('WHERE') then Exit;{ Do not localize }
        NextToken;
      end;
    except
    end;
  finally
    List.EndUpdate;
  end;
end;

procedure TSQLParser.GetWhereFields(List: TStrings);
begin
  List.BeginUpdate;
  try
    List.Clear;
    if TokenSymbolIs('UPDATE') then { Do not localize }
    try
      while not TokenSymbolIs('WHERE') do NextToken; { Do not localize }
      NextToken;
      while True do
      begin
        while FToken in [stLParen, stAlias] do NextToken;
        if FToken <> stSymbol then Break;
        List.Add(FTokenString);
        if NextToken <> stEQ then Break;
        while true do
        begin
          NextToken;
          if FToken = stEnd then Exit;
          if TokenSymbolIs('AND') then Break; { Do not localize }
        end;
        NextToken;
      end;
    except
    end;
  finally
    List.EndUpdate;
  end;
end;

function TUpdateSQLEditFormEh.Edit: Boolean;
var
  DataSetName: string;
begin
  Result := False;
{  if Assigned(UpdateSQL.DataSet) and (UpdateSQL.DataSet is TDBDataSet) then
  begin
    DataSet := TDBDataSet(UpdateSQL.DataSet);
//    FTempTable.SessionName := DataSet.SessionName;
//    FTempTable.DatabaseName := DataSet.DatabaseName;
    DataSetName := Format('%s%s%s', [DataSet.Owner.Name, DotSep, DataSet.Name]);
  end else
    DataSetName := SNoDataSet;}
  cbIncrementObject.Enabled := TDesignDataBaseEh(DataDriver.DesignDataBase).GetIncrementObjectsList <> nil;
  if cbIncrementObject.Enabled
    then labelUpdateObjects.Font.Color := clWindowText
    else labelUpdateObjects.Font.Color := clGrayText;

  Caption := Format('%s%s%s (%s)', ['DataDriver.Owner.Name', DotSep, DataDriver.Name, DataSetName]);

  MemoModify.Lines := DataDriver.UpdateSQL;
  MemoInsert.Lines := DataDriver.InsertSQL;
  MemoDelete.Lines := DataDriver.DeleteSQL;
  MemoGetRec.Lines := DataDriver.GetrecSQL;
  mSpecParams.Lines := TBaseSQLDataDriverEh(DataDriver).SpecParams;
  MemoUpdateFields.Lines.CommaText := TBaseSQLDataDriverEh(DataDriver).DynaSQLParams.UpdateFields;
  MemoKeyFields.Lines.CommaText := TBaseSQLDataDriverEh(DataDriver).DynaSQLParams.KeyFields;
  dbeTableName.Text := TBaseSQLDataDriverEh(DataDriver).DynaSQLParams.UpdateTable;
  if TBaseSQLDataDriverEh(DataDriver).DynaSQLParams.Options <> [] then
  begin
    cbUpdateFields.Checked := True;
    cbKeyFields.Checked := True;
    cbTableName.Checked := True;
  end else
  begin
    cbUpdateFields.Checked := False;
    cbKeyFields.Checked := False;
    cbTableName.Checked := False;
  end;
//    StatementTypeClick(Self);
  InitUpdateTableNames;
  ShowWait(InitGenerateOptions);
  PageControl.ActivePage := PageControl.Pages[0];
  if ShowModal = mrOk then
  begin
    DataDriver.UpdateSQL := MemoModify.Lines;
    DataDriver.InsertSQL := MemoInsert.Lines;
    DataDriver.DeleteSQL := MemoDelete.Lines;
    DataDriver.GetrecSQL := MemoGetRec.Lines;
    TBaseSQLDataDriverEh(DataDriver).SpecParams := mSpecParams.Lines;
    TBaseSQLDataDriverEh(DataDriver).DynaSQLParams.UpdateFields := MemoUpdateFields.Lines.CommaText;
    TBaseSQLDataDriverEh(DataDriver).DynaSQLParams.KeyFields := MemoKeyFields.Lines.CommaText;
    TBaseSQLDataDriverEh(DataDriver).DynaSQLParams.UpdateTable := dbeTableName.Text;
    Result := True;
  end;
end;

procedure TUpdateSQLEditFormEh.GenWhereClause(const TabAlias, QuoteChar: string;
  KeyFields, SQL: TStrings);
var
  I: Integer;
  BindText: string;
  FieldName: string;
begin
  SQL.Add('where'); { Do not localize }
  for I := 0 to KeyFields.Count - 1 do
  begin
    FieldName := KeyFields[I];
    BindText := Format('  %s%s%s%1:s = :%1:sOLD_%2:s%1:s', { Do not localize }
      [TabAlias, QuoteChar, FieldName]);
    if I < KeyFields.Count - 1 then
      BindText := Format('%s and',[BindText]); { Do not localize }
    SQL.Add(BindText);
  end;
end;

procedure TUpdateSQLEditFormEh.GenDeleteSQL(const TableName, QuoteChar: string;
  KeyFields, SQL: TStrings);
begin
  SQL.Clear;
  SQL.Add(Format('delete from %s', [TableName])); { Do not localize }
  GenWhereClause(GetTableRef(TableName, QuoteChar), QuoteChar, KeyFields, SQL);
end;

procedure TUpdateSQLEditFormEh.GenInsertSQL(const TableName, QuoteChar: string;
  UpdateFields, SQL: TStrings);

  procedure GenFieldList(const TabName, ParamChar, QuoteChar: String);
  var
    L: string;
    I: integer;
    Comma: string;
  begin
    L := '  (';
    Comma := ', ';
    for I := 0 to UpdateFields.Count - 1 do
    begin
      if I = UpdateFields.Count - 1 then Comma := '';
      L := Format('%s%s%s%s%s%3:s%5:s',
        [L, TabName, ParamChar, QuoteChar, UpdateFields[I], Comma]);
      if (Length(L) > 70) and (I <> UpdateFields.Count - 1) then
      begin
        SQL.Add(L);
        L := '   ';
      end;
    end;
    SQL.Add(L+')');
  end;

begin
  SQL.Clear;
  SQL.Add(Format('insert into %s', [TableName])); { Do not localize }
  GenFieldList(GetTableRef(TableName, QuoteChar), '', QuoteChar);
  SQL.Add('values'); { Do not localize }
  GenFieldList('', ':', QuoteChar);
end;

procedure TUpdateSQLEditFormEh.GenModifySQL(const TableName, QuoteChar: string;
  KeyFields, UpdateFields, SQL: TStrings);
var
  I: integer;
  Comma: string;
  TableRef: string;
begin
  SQL.Clear;
  SQL.Add(Format('update %s', [TableName]));  { Do not localize }
  SQL.Add('set');                             { Do not localize }
  Comma := ',';
  TableRef := GetTableRef(TableName, QuoteChar);
  for I := 0 to UpdateFields.Count - 1 do
  begin
    if I = UpdateFields.Count -1 then Comma := '';
    SQL.Add(Format('  %s%s%s%1:s = :%1:s%2:s%1:s%3:s',
      [TableRef, QuoteChar, UpdateFields[I], Comma]));
  end;
  GenWhereClause(TableRef, QuoteChar, KeyFields, SQL);
end;

procedure TUpdateSQLEditFormEh.GenerateSQL;

  function QuotedTableName(const BaseName: string): string;
  begin
    with UpdateTableName do
      if ((ItemIndex <> -1) and (Items.Objects[ItemIndex] <> nil)) or
         ({DatabaseOpen and not Database.IsSQLBased and} (Pos('.', BaseName) > 0)) then
         Result := Format('"%s"', [BaseName]) else
         Result := BaseName;
  end;

var
  KeyFields: TStringList;
  UpdateFields: TStringList;
  QuoteChar, TableName: string;
begin
  if (KeyFieldList.SelCount = 0) or (UpdateFieldList.SelCount = 0) then
    raise Exception.Create('SSQLGenSelect');
  KeyFields := TStringList.Create;
  try
    GetSelectedItems(KeyFieldList, KeyFields);
    UpdateFields := TStringList.Create;
    try
      GetSelectedItems(UpdateFieldList, UpdateFields);
      TableName := QuotedTableName(UpdateTableName.Text);

      if TDesignDataBaseEh(DataDriver.DesignDataBase).GetCustomDBService <> nil then
        GenerateSQLViaDBService
      else
      begin
        if QuoteFields.Checked then
          QuoteChar := '"' else
          QuoteChar := '';
        if cbInsert.Checked then
          GenInsertSQL(TableName, QuoteChar, UpdateFields, MemoInsert.Lines);
        if cbUpdate.Checked then
          GenModifySQL(TableName, QuoteChar, KeyFields, UpdateFields, MemoModify.Lines);
        if cbDelete.Checked then
          GenDeleteSQL(TableName, QuoteChar, KeyFields, MemoDelete.Lines);
        if cbGetRec.Checked then
          GenGetRecSQL(DataDriver.SelectSQL, KeyFields, MemoGetRec.Lines);
        if cbUpdateFields.Checked then
          FillMemoFromList(MemoUpdateFields, UpdateFieldList);
        if cbKeyFields.Checked then
          FillMemoFromList(MemoKeyFields, KeyFieldList);
        if cbTableName.Checked then
          dbeTableName.Text := UpdateTableName.Text;
      end;

      PageControl.SelectNextPage(True);
    finally
      UpdateFields.Free;
    end;
  finally
    KeyFields.Free;
  end;
end;

procedure TUpdateSQLEditFormEh.GetDataSetFieldNames;
begin
{ TODO : realize }
{  if Assigned(DataSet) then
  begin
    GetDataFieldNames(DataSet, DataSet.Name, KeyFieldList.Items);
    UpdateFieldList.Items.Assign(KeyFieldList.Items);
  end;}
end;

function TUpdateSQLEditFormEh.GetTableRef(const TabName, QuoteChar: string): string;
begin
  if QuoteChar <> '' then
    Result :=  TabName + '.' else
    REsult := '';
end;

procedure TUpdateSQLEditFormEh.InitGenerateOptions;
var
  UpdTabName: string;

  procedure InitFromDataSet;
  begin
    // If this is a Query with more than 1 table in the "from" clause then
    //  initialize the list of fields from the table rather than the dataset.
    if (UpdateTableName.Items.Count > 1) then
      GetTableFieldNames
    else
    begin
      GetDataSetFieldNames;
      FDatasetDefaults := True;
    end;
    SetDefaultSelections;
  end;

  procedure InitFromUpdateSQL;
  var
    UpdFields,
    WhFields: TStrings;
  begin
    UpdFields := TStringList.Create;
    try
      WhFields := TStringList.Create;
      try
        ParseUpdateSQL(MemoModify.Text, UpdTabName, UpdFields, WhFields);
        GetDataSetFieldNames;
        if SetSelectedItems(UpdateFieldList, UpdFields) < 1 then
          SelectAll(UpdateFieldList);
        if SetSelectedItems(KeyFieldList, WhFields) < 1 then
          SelectAll(KeyFieldList);
      finally
        WhFields.Free;
      end;
    finally
      UpdFields.Free;
    end;
  end;

begin
  // If there are existing update SQL statements, try to initialize the
  // dialog with the fields that correspond to them.
  if MemoModify.Lines.Count > 0 then
  begin
    ParseUpdateSQL(MemoModify.Text, UpdTabName, nil, nil);
    // If the table name from the update statement is not part of the
    // dataset, then initialize from the dataset instead.
    if (UpdateTableName.Items.Count > 0) and
       (UpdateTableName.Items.IndexOf(UpdTabName) > -1) then
    begin
      UpdateTableName.Text := UpdTabName;
      InitFromUpdateSQL;
    end else
    begin
      InitFromDataSet;
      UpdateTableName.Items.Add(UpdTabName);
    end;
  end else
    InitFromDataSet;
  SetButtonStates;
end;

procedure TUpdateSQLEditFormEh.InitUpdateTableNames;
begin
  UpdateTableName.Items.Clear;
  GetSQLTableNames(DataDriver.SelectSQL.Text, UpdateTableName.Items);
  if UpdateTableName.Items.Count > 0 then
     UpdateTableName.ItemIndex := 0;
end;

procedure TUpdateSQLEditFormEh.SetButtonStates;
begin
  GetTableFieldsButton.Enabled := UpdateTableName.Text <> '';
  PrimaryKeyButton.Enabled := GetTableFieldsButton.Enabled and
    (KeyFieldList.Items.Count > 0);
  GenerateButton.Enabled := GetTableFieldsButton.Enabled and
    (UpdateFieldList.Items.Count > 0) and (KeyFieldList.Items.Count > 0);
//  DefaultButton.Enabled := Assigned(DataSet) and not FDatasetDefaults;
end;

// Table FieldNames

procedure TUpdateSQLEditFormEh.GetTableFieldNames;
var
  FieldsList: TMemTableEh;
begin
  FieldsList := TMemTableEh.Create(nil);
  FieldsList.FieldDefs.Add('FieldName', ftString, 100);
  FieldsList.FieldDefs.Add('InKey', ftBoolean);
  FieldsList.FieldDefs.Add('FieldSize', ftInteger);
  FieldsList.CreateDataSet;
  if DataDriver.DesignDataBase <> nil then
//    (DataDriver.DesignDataBase as IDesignDataBaseEh).GetFieldList(UpdateTableName.Text, FieldsList);
    TDesignDataBaseEh(DataDriver.DesignDataBase).GetFieldList(UpdateTableName.Text, FieldsList);

  KeyFieldList.Clear;
  FieldsList.First;
  while not FieldsList.Eof do
  begin
    KeyFieldList.Items.Add(VarToStr(FieldsList['FieldName']));
    FieldsList.Next;
  end;
  FieldsList.Free;
  UpdateFieldList.Items.Assign(KeyFieldList.Items);
  cbIncrementField.Items := UpdateFieldList.Items;
  if TDesignDataBaseEh(DataDriver.DesignDataBase).GetIncrementObjectsList <> nil then
    cbIncrementObject.Items := TDesignDataBaseEh(DataDriver.DesignDataBase).GetIncrementObjectsList;
end;

// PrimaryKeyFields

procedure TUpdateSQLEditFormEh.SelectPrimaryKeyFields;
var
  FieldsList: TMemTableEh;
  Index: Integer;
begin
  FieldsList := TMemTableEh.Create(nil);
  FieldsList.FieldDefs.Add('FieldName', ftString, 100);
  FieldsList.FieldDefs.Add('InKey', ftBoolean);
  FieldsList.FieldDefs.Add('FieldSize', ftInteger);
  FieldsList.CreateDataSet;
  if DataDriver.DesignDataBase <> nil then
//    (DataDriver.DesignDataBase as IDesignDataBaseEh).GetFieldList(UpdateTableName.Text, FieldsList);
    TDesignDataBaseEh(DataDriver.DesignDataBase).GetFieldList(UpdateTableName.Text, FieldsList);

  FieldsList.First;
  while not FieldsList.Eof do
  begin
    Index := -1;
    if FieldsList['InKey'] = True then
      Index := KeyFieldList.Items.IndexOf(FieldsList['FieldName']);
    if Index > -1 then KeyFieldList.Selected[Index] := True;
    FieldsList.Next;
  end;
  FieldsList.Free;
end;

procedure TUpdateSQLEditFormEh.SetDefaultSelections;
//var
//  DSFields: TStringList;
begin
  if FDatasetDefaults {r not Assigned(DataSet)}then
  begin
    SelectAll(UpdateFieldList);
    SelectAll(KeyFieldList);
  end
{ else if (DataSet.FieldDefs.Count > 0) then
  begin
    DSFields := TStringList.Create;
    try
      GetDataFieldNames(DataSet, '', DSFields);
      SetSelectedItems(KeyFieldList, DSFields);
      SetSelectedItems(UpdateFieldList, DSFields);
    finally
      DSFields.Free;
    end;
  end;}
end;

procedure TUpdateSQLEditFormEh.ShowWait(WaitMethod: TWaitMethod);
begin
  Screen.Cursor := crHourGlass;
  try
    WaitMethod;
  finally
    Screen.Cursor := crDefault;
  end;
end;

{ Event Handlers }

procedure TUpdateSQLEditFormEh.FormCreate(Sender: TObject);
begin
//  HelpContext := hcDUpdateSQL;
end;

procedure TUpdateSQLEditFormEh.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TUpdateSQLEditFormEh.DefaultButtonClick(Sender: TObject);
begin
  with UpdateTableName do
    if Items.Count > 0 then ItemIndex := 0;
  ShowWait(GetDataSetFieldNames);
  FDatasetDefaults := True;
  SetDefaultSelections;
  KeyfieldList.SetFocus;
  SetButtonStates;
end;

procedure TUpdateSQLEditFormEh.GenerateButtonClick(Sender: TObject);
begin
  GenerateSQL;
  FSettingsChanged := False;
end;

procedure TUpdateSQLEditFormEh.PrimaryKeyButtonClick(Sender: TObject);
begin
  ShowWait(SelectPrimaryKeyFields);
  SettingsChanged(Sender);
end;

procedure TUpdateSQLEditFormEh.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (PageControl.ActivePage = PageControl.Pages[0]) and
    not SQLPage.Enabled then
    AllowChange := False;
end;

procedure TUpdateSQLEditFormEh.GetTableFieldsButtonClick(Sender: TObject);
begin
  ShowWait(GetTableFieldNames);
  SetDefaultSelections;
  SettingsChanged(Sender);
end;

procedure TUpdateSQLEditFormEh.SettingsChanged(Sender: TObject);
begin
  FSettingsChanged := True;
  FDatasetDefaults := False;
  SetButtonStates;
end;

procedure TUpdateSQLEditFormEh.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (ModalResult = mrOK) and FSettingsChanged then
    CanClose := MessageDlg('SSQLNotGenerated', mtConfirmation,
      mbYesNoCancel, 0) = mrYes;
end;

procedure TUpdateSQLEditFormEh.UpdateTableNameChange(Sender: TObject);
begin
  SettingsChanged(Sender);
end;

procedure TUpdateSQLEditFormEh.UpdateTableNameClick(Sender: TObject);
begin
  if not Visible then Exit;
  GetTableFieldsButtonClick(Sender);
end;

procedure TUpdateSQLEditFormEh.SelectAllClick(Sender: TObject);
begin
  SelectAll(FieldListPopup.PopupComponent as TListBox);
end;

procedure TUpdateSQLEditFormEh.ClearAllClick(Sender: TObject);
var
  I: Integer;
begin
  with FieldListPopup.PopupComponent as TListBox do
  begin
    Items.BeginUpdate;
    try
      for I := 0 to Items.Count - 1 do
        Selected[I] := False;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TUpdateSQLEditFormEh.MemoModifyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (ssCtrl in Shift) then
    Close;
end;

procedure TUpdateSQLEditFormEh.cbInsertClick(Sender: TObject);
begin
  tsInsert.TabVisible := cbInsert.Checked;
  tsModify.TabVisible := cbUpdate.Checked;
  tsDelete.TabVisible := cbDelete.Checked;
  tsGetrec.TabVisible := cbGetrec.Checked;
  tsSpecParams.TabVisible := cbSpecParams.Checked or cbUpdateFields.Checked or
    cbKeyFields.Checked or cbTableName.Checked;
end;

procedure TUpdateSQLEditFormEh.GenGetRecSQL(SelectSQL, KeyFields, SQL: TStrings);
var
  BindText, FieldName, TabAlias: String;
  I: Integer;
begin
  BindText := '';
  SQL.Assign(SelectSQL);
  TabAlias := '';
  for I := 0 to KeyFields.Count - 1 do
  begin
    FieldName := KeyFields[I];
    BindText := Format('  %s%s%s%1:s = :%1:sOLD_%2:s%1:s', { Do not localize }
      [TabAlias, '', FieldName]);
    if I < KeyFields.Count - 1 then
      BindText := Format('%s and',[BindText]); { Do not localize }
    SQL.Add(BindText);
  end;
end;

procedure TUpdateSQLEditFormEh.GenerateSQLViaDBService;
var
//  DBService: TCustomDBService;
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh;
begin
  if TDesignDataBaseEh(DataDriver.DesignDataBase).GetCustomDBService <> nil then
  begin
    DesignUpdateParams := TDesignUpdateParamsEh.Create;
    DesignUpdateInfo := TDesignUpdateInfoEh.Create;
    DesignUpdateParams.TableName := UpdateTableName.Text;
    DesignUpdateParams.IncremenField := cbIncrementField.Text;
    DesignUpdateParams.IncremenObject := cbIncrementObject.Text;
    GetSelectedItems(KeyFieldList, DesignUpdateParams.KeyFields);
    GetSelectedItems(UpdateFieldList, DesignUpdateParams.UpdateFields);
    DesignUpdateParams.SelectSQL := DataDriver.SelectSQL;

    if TDesignDataBaseEh(DataDriver.DesignDataBase).
      GetCustomDBService.GetUpdateSQLCommand(DesignUpdateParams, DesignUpdateInfo) then
    begin
      if cbInsert.Checked then
        MemoInsert.Lines := DesignUpdateInfo.InsertSQL;
      if cbUpdate.Checked then
        MemoModify.Lines := DesignUpdateInfo.UpdateSQL;
      if cbDelete.Checked then
        MemoDelete.Lines := DesignUpdateInfo.DeleteSQL;
      if cbGetRec.Checked then
        MemoGetRec.Lines := DesignUpdateInfo.GetrecSQL;
      if cbSpecParams.Checked then
        mSpecParams.Lines := DesignUpdateInfo.SpecParams;
      if cbUpdateFields.Checked then
        MemoUpdateFields.Lines := DesignUpdateInfo.UpdateFields;
      if cbKeyFields.Checked then
        MemoKeyFields.Lines := DesignUpdateInfo.KeyFields;
      if cbTableName.Checked then
        dbeTableName.Text := DesignUpdateInfo.TableName;
    end;
    DesignUpdateParams.Free;
    DesignUpdateInfo.Free;
  end;
end;

procedure TUpdateSQLEditFormEh.FillMemoFromList(Memo: TMemo; List: TListBox);
var
  i: Integer;
begin
  Memo.Clear;
  for i := 0 to List.Items.Count-1 do
  begin
    if List.Selected[i] then
      Memo.Lines.Add(List.Items[i]);
  end;
end;

end.
