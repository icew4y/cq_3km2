{*******************************************************}
{                                                       }
{                     EhLib v5.0                        }
{          Registers object that sort data in           }
{                  TCustomMemTableEh                    }
{                    (Build 5.0.00)                     }
{                                                       }
{    Copyright (c) 2003-2006 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TMemTableEh automatically after sorting markers       }
{ will be changed.                                      }
{ TMTEDatasetFeaturesEh determine if                    }
{ TDBGridEh.SortLocal = True then it will sort data     }
{ in memory using procedure SortByFields                }
{ else if SortLocal = False and MemTable connected to   }
{ other  DataSet via ProviderDataSet, it will try to    }
{ sord data in this DataSet using                       }
{ GetDatasetFeaturesForDataSet function                 }
{*******************************************************}

unit EhLibMTE;

{$I EhLib.Inc}

interface

uses
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  DbUtilsEh, DBGridEh, Db, MemTableEh, MemTableDataEh, DataDriverEh,
  SysUtils, ToolCtrlsEh;

type

  TMTEDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  protected
    FBaseNode: TMemRecViewEh;
  public
    constructor Create; override;
    function LocateText(AGrid: TCustomDBGridEh; const FieldName: string;
      const Text: String; AOptions: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
      Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean; override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ExecuteFindDialog(Sender: TObject; Text, FieldName: String; Modal: Boolean); override;
  end;

var
  SortInView: Boolean;

implementation

uses Classes;

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh) end;
  TDataDriverEhCrack = class(TDataDriverEh) end;

procedure ApplySortingForSQLDataDriver(Grid: TCustomDBGridEh;
  SQLDriver: TCustomSQLDataDriverEh; UseFieldName: Boolean);

  function DeleteStr(str: String; sunstr: String): String;
  var
    i: Integer;
  begin
    i := Pos(sunstr, str);
    if i <> 0 then
      Delete(str, i, Length(sunstr));
    Result := str;
  end;

var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
begin

  SQL := TStringList.Create;
  try
    SQL.Text := SQLDriver.SelectSQL.Text;

    s := '';
    for i := 0 to Grid.SortMarkedColumns.Count - 1 do
    begin
      if UseFieldName
        then s := s + Grid.SortMarkedColumns[i].FieldName
        else s := s + IntToStr(Grid.SortMarkedColumns[i].Field.FieldNo);
      if Grid.SortMarkedColumns[i].Title.SortMarker = smUpEh
        then s := s + ' DESC, '
        else s := s + ', ';
    end;

    if s <> '' then
      s := 'ORDER BY ' + Copy(s, 1, Length(s) - 2);

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length('ORDER BY'))) = 'ORDER BY' then
      begin
        OrderLine := i;
        Break;
      end;
    if OrderLine = -1 then
    begin
      SQL.Add('');
      OrderLine := SQL.Count-1;
    end;

    SQL.Strings[OrderLine] := s;

    SQLDriver.SelectSQL := SQL;

  finally
    SQL.Free;
  end;
end;

procedure ApplyFilterForSQLDataDriver(Grid: TCustomDBGridEh; SQLDriver: TSQLDataDriverEh;
  DateValueToSQLString: TDateValueToSQLStringProcEh);
var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
begin

  SQL := TStringList.Create;
  try
    SQL.Text := SQLDriver.SelectSQL.Text;

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length(SQLFilterMarker))) = UpperCase(SQLFilterMarker) then
      begin
        OrderLine := i;
        Break;
      end;
    s := GetExpressionAsFilterString(Grid, GetOneExpressionAsSQLWhereString, DateValueToSQLString, True);
    if s = '' then
      s := '1=1';
    if OrderLine = -1 then
      Exit;

    SQL.Strings[OrderLine] := SQLFilterMarker + ' (' + s + ')';
    SQLDriver.SelectSQL := SQL;

  finally
    SQL.Free;
  end;
end;

function LocateTextInTree(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh; BaseNode: TMemRecViewEh): Boolean;
var
  FCurInListColIndex: Integer;
  TreeListPos: Integer;
  MemTable: TCustomMemTableEh;
  TreeList: TMemoryTreeListEh;
  RootNode, NextNode: TMemRecViewEh;

  function CheckEofBof: Boolean;
  begin
    if (Direction = ltdUpEh)
//      then Result := (TreeListPos < 0)
//      else Result := (TreeListPos > TreeList.AccountableCount-1);
      then Result := (NextNode = nil)
      else Result := (NextNode = nil);
  end;

  procedure First;
  begin
    TreeListPos := 0;
    MemTable.InstantReadLeave;
    if TreeFindRange = lttInCurrentLevelEh then
    begin
      RootNode := BaseNode.NodeParent.VisibleNodeItems[0];
      NextNode := RootNode;
    end else if TreeFindRange = lttInCurrentNodeEh then
    begin
      RootNode := BaseNode;
      NextNode := RootNode;
    end else
      NextNode := TreeList.AccountableItem[TreeListPos];
    MemTable.InstantReadEnter(NextNode, -1);
  end;

  procedure Next;
  begin
    Inc(TreeListPos);
    if TreeFindRange = lttInCurrentLevelEh then
    begin
      if (NextNode.NodeParent.VisibleNodesCount-1 = NextNode.VisibleNodeIndex)
      then
        NextNode := nil
      else
        NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex + 1];
    end else if TreeFindRange = lttInCurrentNodeEh then
    begin
      if NextNode.VisibleNodesCount > 0 then
        NextNode := NextNode.VisibleNodeItems[0]
      else if (NextNode <> BaseNode) and
              (NextNode.NodeParent.VisibleNodesCount-1 > NextNode.VisibleNodeIndex) then
        NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex + 1]
      else
      begin
        while (NextNode <> BaseNode) and (NextNode.NodeParent.VisibleNodesCount-1 = NextNode.VisibleNodeIndex)  do
          NextNode := NextNode.NodeParent;
        if NextNode = BaseNode
          then NextNode := nil
          else NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex + 1];
      end;
    end else
    begin
      if TreeListPos <= TreeList.AccountableCount-1 then
        NextNode := TreeList.AccountableItem[TreeListPos]
      else
        NextNode := nil;
    end;
    if NextNode <> nil then
    begin
      MemTable.InstantReadLeave;
      MemTable.InstantReadEnter(NextNode, -1);
    end;
  end;

  procedure Prior;
  begin
    Dec(TreeListPos);
    if TreeFindRange = lttInCurrentLevelEh then
    begin
      if NextNode.VisibleNodeIndex = 0
      then
        NextNode := nil
      else
        NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex - 1];
    end else if TreeFindRange = lttInCurrentNodeEh then
    begin
{      if NextNode.VisibleNodeIndex > 0 then
      begin
        NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex - 1];
        if NextNode.VisibleNodesCount > 0 then
          NextNode := NextNode.VisibleNodeItems[NextNode.VisibleNodesCount-1];
      end else if (NextNode.NodeParent.NodeParent <> nil)
      then
        NextNode := NextNode.NodeParent
      else
        NextNode := nil;}
      if (TreeListPos >= 0) and
       ((TreeList.AccountableItem[TreeListPos].NodeLevel > BaseNode.NodeLevel) or
        (TreeList.AccountableItem[TreeListPos] = BaseNode)) then
        NextNode := TreeList.AccountableItem[TreeListPos]
      else
        NextNode := nil;
    end else
    begin
      if TreeListPos >= 0 then
        NextNode := TreeList.AccountableItem[TreeListPos]
      else
        NextNode := nil;
    end;
    if NextNode <> nil then
    begin
      MemTable.InstantReadLeave;
      MemTable.InstantReadEnter(NextNode, -1);
    end;
  end;

  procedure ToNextRec;
  begin
    if ltoAllFieldsEh in AOptions then
      if (Direction = ltdUpEh) then
      begin
        if FCurInListColIndex > 0 then
          Dec(FCurInListColIndex)
        else
        begin
          Prior;
          FCurInListColIndex := AGrid.VisibleColCount-1;
        end;
      end else
      begin
        if FCurInListColIndex < AGrid.VisibleColCount-1 then
          Inc(FCurInListColIndex)
        else
        begin
          Next;
          FCurInListColIndex := 0;
        end;
      end
    else if (Direction = ltdUpEh) then
      Prior
    else
      Next;
  end;

  function ColText(Col: TColumnEh): String;
  begin
    if ltoMatchFormatEh in AOptions then
      Result := Col.DisplayText
    else if Col.Field <> nil then
      Result := Col.Field.AsString
    else
      Result := '';
  end;

  function AnsiContainsText(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
  end;

  function AnsiContainsStr(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(ASubText, AText) > 0;
  end;

var
  DataText: String;
  i: Integer;
  RecView, RecViewFound: TMemRecViewEh;
begin
  Result := False;
  MemTable := (AGrid.DataSource.DataSet as TCustomMemTableEh);
  MemTable.CheckBrowseMode;
  if MemTable.BOF and MemTable.EOF then Exit;
  TreeList := MemTable.RecordsView.MemoryTreeList;
  RecView := MemTable.TreeNode;
  FCurInListColIndex := AGrid.SelectedIndex;
  if (AGrid.VisibleColCount = 0) then Exit;
  MemTable.InstantReadEnter(0);
  with AGrid do
  begin
    AGrid.DataSource.DataSet.DisableControls;
    //SaveBookmark;
    try
      if (Direction = ltdAllEh) then
      begin
        First;
//        TreeListPos := 0;
//        MemTable.InstantReadLeave;
//        MemTable.InstantReadEnter(TreeList.AccountableItem[TreeListPos], -1);
//          AGrid.DataSource.DataSet.First
      end else
      begin
        TreeListPos := 0;
        for i := 0 to TreeList.AccountableCount-1 do
          if TreeList.AccountableItem[i] = RecView then
          begin
            TreeListPos := i;
            NextNode := RecView;
            Break;
          end;
        ToNextRec;
      end;
      while not CheckEofBof do
      begin
        DataText := ColText(AGrid.Columns[FCurInListColIndex]);
        //CharCase
        if not (ltoCaseInsensitiveEh in AOptions) then
        begin
          //From any part of field
          if ( (Matching = ltmAnyPartEh) and (
              AnsiContainsStr(DataText, Text) )
             ) or (
          //Whole field
            (Matching = ltmWholeEh) and (DataText = Text)
            ) or ((Matching = ltmFromBegingEh) and
          //From beging of field
            (Copy(DataText, 1, Length(Text)) = Text) )
          then
          begin
            Result := True;
//              IsFirstTry := False;
            Break;
          end
        end else
        //From any part of field
        if ( (Matching = ltmAnyPartEh) and (
            AnsiContainsText(DataText, Text) )
           ) or (
        //Whole field
          (Matching = ltmWholeEh) and (
          AnsiUpperCase(DataText) =
          AnsiUpperCase(Text))
          ) or ((Matching = ltmFromBegingEh) and
        //From beging of field
          (AnsiUpperCase(Copy(DataText, 1, Length(Text))) =
          AnsiUpperCase(Text)) ) then
        begin
          Result := True;
          AGrid.SelectedIndex := AGrid.VisibleColumns[FCurInListColIndex].Index;
//            IsFirstTry := False;
          Break;
        end;
        ToNextRec;
      end;
      //if not Result then RestoreBookmark;
    finally
      MemTable.InstantReadLeave;
      AGrid.DataSource.DataSet.EnableControls;
    end;

    if Result then
    begin
//      RecViewFound := TreeList.AccountableItem[TreeListPos];
      RecViewFound := NextNode;
      RecView := RecViewFound;
      while RecView.Rec <> nil do
      begin
        RecView.NodeExpanded := True;
        RecView := RecView.NodeParent;
      end;
      MemTable.GotoRec(RecViewFound.Rec);
    end;

//      if not RecordFounded then
//        ShowMessage(Format(SFindDialogStringNotFoundMessageEh, [cbText.Text]));
  end;
end;
{
function LocateText(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh;
  Matching: TLocateTextMatchingEh): Boolean;
var
  i: Integer;
  TreeList: TMemoryTreeListEh;
  RecView, RecViewFound: TMemRecViewEh;
  MemTable: TCustomMemTableEh;
begin
  Result := False;
  RecViewFound := nil;
  MemTable := (AGrid.DataSource.DataSet as TCustomMemTableEh);
  MemTable.CheckBrowseMode;
  if MemTable.BOF and MemTable.EOF then Exit;
  TreeList := MemTable.RecordsView.MemoryTreeList;
  for i := 0 to TreeList.AccountableCount - 1 do
  begin

//    if (Options <> []) and (Pos(';', KeyFields) = 0) then
//      Result := StringValueEqual(
//                  VarToStr(TreeList.AccountableItem[i].Rec.DataValues[KeyFields,dvvValueEh]),
//                  VarToStr(KeyValues))
//    else
//      Result := VarEquals(TreeList.AccountableItem[i].Rec.DataValues[KeyFields,dvvValueEh], KeyValues);
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
    MemTable.GotoRec(RecViewFound.Rec);
  end;
end;
}

{ TMTEDatasetFeaturesEh }

constructor TMTEDatasetFeaturesEh.Create;
begin
  inherited Create;
  SupportsLocalLike := True;
end;

procedure TMTEDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  DataDriver: TDataDriverEh;
  DS: TDataSet;
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if TDBGridEh(Sender).STFilter.Local then
  begin
    inherited ApplyFilter(Sender, DataSet, IsReopen)
  end else if (DataSet is TCustomMemTableEh) then
  begin
    if not (DataSet is TCustomMemTableEh) then Exit;
    DataDriver := TCustomMemTableEh(DataSet).DataDriver;
    if DataDriver = nil then
      raise Exception.Create('MemTableEh.DataDriver is empty');
    DS := TDataDriverEhCrack(DataDriver).ProviderDataSet;
    if DS <> nil then
    begin
      DatasetFeatures := GetDatasetFeaturesForDataSet(DS);
      if DatasetFeatures <> nil then
        DatasetFeatures.ApplyFilter(Sender, DS, False);
      DataSet.Close;
      DataSet.Open;
    end else if (DataDriver is TSQLDataDriverEh) then
    begin
      ApplyFilterForSQLDataDriver(TCustomDBGridEh(Sender),
        TSQLDataDriverEh(DataDriver), DateValueToSQLString);
    end;
  end;
end;

procedure TMTEDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  DS: TDataSet;
  MTE: TCustomMemTableEh;
  DatasetFeatures: TDatasetFeaturesEh;
  i: Integer;
  OrderByStr: String;
  DataDriver: TDataDriverEh;
begin
  if Sender is TCustomDBGridEh then
    if TCustomDBGridEh(Sender).SortLocal then
      with TCustomDBGridEh(Sender) do
        begin
          OrderByStr := '';
          for i := 0 to SortMarkedColumns.Count - 1 do
          begin
            OrderByStr := OrderByStr + SortMarkedColumns[i].FieldName + ' ';
            if SortMarkedColumns[i].Title.SortMarker = smUpEh then
              OrderByStr := OrderByStr + ' DESC';
            OrderByStr := OrderByStr + ',';
          end;
          Delete(OrderByStr, Length(OrderByStr), 1);
          if (DataSet is TCustomMemTableEh) then
          begin
            MTE := TCustomMemTableEh(DataSet);
            if SortInView
              then MTE.SortOrder := OrderByStr
              else MTE.SortByFields(OrderByStr);
          end;
        end
    else
    begin
      if not (DataSet is TCustomMemTableEh) then Exit;
      DataDriver := TCustomMemTableEh(DataSet).DataDriver;
      if DataDriver = nil then
        raise Exception.Create('MemTableEh.DataDriver is empty');
      DS := TDataDriverEhCrack(DataDriver).ProviderDataSet;
      if DS <> nil then
      begin
        DatasetFeatures := GetDatasetFeaturesForDataSet(DS);
        if DatasetFeatures <> nil then
          DatasetFeatures.ApplySorting(Sender, DS, False);
        DataSet.Close;
        DataSet.Open;
      end else if (DataDriver is TCustomSQLDataDriverEh) then
      begin
        ApplySortingForSQLDataDriver(TCustomDBGridEh(Sender),
          TCustomSQLDataDriverEh(DataDriver), SortUsingFieldName);
        DataSet.Close;
        DataSet.Open;
      end;
    end;
end;

function TMTEDatasetFeaturesEh.LocateText(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;
var
  mt: TCustomMemTableEh;
begin
  mt := nil;
  Result := False;
  if not ( (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) and
            AGrid.DataSource.DataSet.Active )
  then
    Exit;
  if (AGrid.DataSource.DataSet is TCustomMemTableEh) then
    mt := (AGrid.DataSource.DataSet as TCustomMemTableEh);
  if (mt <> nil) and mt.TreeList.Active and (TreeFindRange <> lttInExpandedNodesEh)  then
  begin
    Result := LocateTextInTree(AGrid, FieldName, Text, AOptions,
      Direction, Matching, TreeFindRange, FBaseNode);
  end else
    Result := inherited LocateText(AGrid, FieldName, Text, AOptions,
      Direction, Matching, TreeFindRange);
end;

procedure TMTEDatasetFeaturesEh.ExecuteFindDialog(Sender: TObject;
  Text, FieldName: String; Modal: Boolean);
var
  mt: TCustomMemTableEh;
  Grid: TCustomDBGridEh;
begin
  if Sender is TCustomDBGridEh then
    Grid := TCustomDBGridEh(Sender)
  else
    Exit;
  if not ( (Grid.DataSource <> nil) and (Grid.DataSource.DataSet <> nil) and
            Grid.DataSource.DataSet.Active )
  then
    Exit;
  FBaseNode := nil;
  if (Grid.DataSource.DataSet is TCustomMemTableEh) then
  begin
    mt := (Grid.DataSource.DataSet as TCustomMemTableEh);
    if mt.TreeList.Active then
      FBaseNode := mt.TreeNode;
  end;
  inherited ExecuteFindDialog(Sender, Text, FieldName, Modal);
end;

initialization
  RegisterDatasetFeaturesEh(TMTEDatasetFeaturesEh, TCustomMemTableEh);
end.
