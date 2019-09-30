{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{                   TDBSumList component                }
{                      Build 5.0.00                     }
{                                                       }
{   Copyright (c) 1998-2009 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBSumLst;

interface

uses
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  Windows, Forms, Dialogs,  // For evaluation
  SysUtils, Classes, DB, ToolCtrlsEh,
{$IFDEF EH_LIB_6} Variants, Contnrs, {$ENDIF}
  TypInfo {,dbugintf};

type
  TGroupOperation = (goSum, goAvg, goCount);

  TDBSum = class(TCollectionItem)
  private
    procedure SetGroupOperation(const Value: TGroupOperation);
    procedure SetFieldName(const Value: String);
  protected
    FFieldName: String;
    FGroupOperation: TGroupOperation;
    Value: Currency;
    // For Average
    FNotNullRecordCount: Integer;
    FSumValueAsSum: Currency;
    VarValue: Variant;
  public
    SumValue: Currency;
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property FieldName: String read FFieldName write SetFieldName;
    property GroupOperation: TGroupOperation read FGroupOperation write SetGroupOperation;
  end;

  TDBSumCollection = class(TCollection)
  protected
    FOwner: TPersistent;
    function GetItem(Index: Integer): TDBSum;
    function GetOwner: TPersistent; override;
    procedure SetItem(Index: Integer; Value: TDBSum);
    procedure Update(Item: TCollectionItem); override;
  public
    function GetSumByOpAndFName(AGroupOperation: TGroupOperation; AFieldName: String): TDBSum;
    property Items[Index: Integer]: TDBSum read GetItem write SetItem; default;
  end;

  TDBSumListProducer = class(TPersistent)
  private
    FVirtualRecords: Boolean;
  protected
    Changing: Boolean;
    FActive: Boolean;
    FDataSet: TDataSet;
    FDesignTimeWork: Boolean;
    FEventsOverloaded: Boolean;
    FExternalRecalc: Boolean;
    Filter: String;
    Filtered: Boolean;
    FMasterDataset: TDataset;
    FMasterPropInfo: PPropInfo;
    FOldRecNo: Integer;
    FOnAfterRecalcAll: TNotifyEvent;
    FOnRecalcAll: TNotifyEvent;
    FOwner: TComponent;
    FSumCollection: TDBSumCollection;
    FSumListChanged: TNotifyEvent;
    FTryedInsert: Boolean;
    FVirtualRecList: TBMListEh;
    OldAfterCancel: TDataSetNotifyEvent;
    OldAfterClose: TDataSetNotifyEvent;
    OldAfterEdit: TDataSetNotifyEvent;
    OldAfterInsert: TDataSetNotifyEvent;
    OldAfterOpen: TDataSetNotifyEvent;
    OldAfterPost: TDataSetNotifyEvent;
    OldAfterScroll: TDataSetNotifyEvent;
    OldBeforeDelete: TDataSetNotifyEvent;
    OldMasterAfterScroll: TDataSetNotifyEvent;
    function GetRecNo: Integer; virtual;
    function FindVirtualRecord(Bookmark: TUniBookmarkEh): Integer; virtual;
    function GetOwner: TPersistent; override;
    procedure SetRecNo(const Value: Integer); virtual;
    procedure SetVirtualRecords(const Value: Boolean);
    procedure DataSetAfterCancel(DataSet: TDataSet); virtual;
    procedure DataSetAfterClose(DataSet: TDataSet); virtual;
    procedure DataSetAfterEdit(DataSet: TDataSet); virtual;
    procedure DataSetAfterInsert(DataSet: TDataSet); virtual;
    procedure DataSetAfterOpen(DataSet: TDataSet); virtual;
    procedure DataSetAfterPost(DataSet: TDataSet); virtual;
    procedure DataSetAfterScroll(DataSet: TDataSet); virtual;
    procedure DataSetBeforeDelete(DataSet: TDataSet); virtual;
    procedure DoSumListChanged;
    procedure Loaded;
    procedure MasterDataSetAfterScroll(DataSet: TDataSet);
    procedure ResetMasterInfo;
    procedure ReturnEvents; virtual;
    procedure SetActive(const Value: Boolean);
    procedure SetDataSet(Value: TDataSet);
    procedure SetExternalRecalc(const Value: Boolean);
    procedure SetSumCollection(const Value: TDBSumCollection);
    procedure Update;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    function IsSequenced: Boolean; virtual;
    function RecordCount: Integer; virtual;
    procedure Activate(ARecalcAll: Boolean);
    procedure Assign(Source: TPersistent); override;
    procedure ClearSumValues; virtual;
    procedure Deactivate(AClearSumValues: Boolean);
    procedure RecalcAll; virtual;
    procedure SetDataSetEvents; virtual;
    property Active: Boolean read FActive write SetActive default True;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property ExternalRecalc: Boolean read FExternalRecalc write SetExternalRecalc;
    property RecNo: Integer read GetRecNo write SetRecNo;
    property SumCollection: TDBSumCollection read FSumCollection write SetSumCollection;
    property VirtualRecords: Boolean read FVirtualRecords write SetVirtualRecords;
    property SumListChanged: TNotifyEvent read FSumListChanged write FSumListChanged;
    property OnAfterRecalcAll: TNotifyEvent read FOnAfterRecalcAll write FOnAfterRecalcAll;
    property OnRecalcAll: TNotifyEvent read FOnRecalcAll write FOnRecalcAll;
  end;

  TDBSumList = class(TComponent)
  private
    function GetActive: Boolean;
    function GetDataSet: TDataSet;
    function GetExternalRecalc: Boolean;
    function GetOnAfterRecalcAll: TNotifyEvent;
    function GetOnRecalcAll: TNotifyEvent;
    function GetRecNo: Integer;
    function GetSumCollection: TDBSumCollection;
    function GetSumListChanged: TNotifyEvent;
    function GetVirtualRecords: Boolean;
    procedure SetOnAfterRecalcAll(const Value: TNotifyEvent);
    procedure SetOnRecalcAll(const Value: TNotifyEvent);
    procedure SetRecNo(const Value: Integer);
    procedure SetSumListChanged(const Value: TNotifyEvent);
    procedure SetVirtualRecords(const Value: Boolean);
  protected
    FSumListProducer: TDBSumListProducer;
    procedure DataSetAfterClose(DataSet: TDataSet);
    procedure DataSetAfterEdit(DataSet: TDataSet);
    procedure DataSetAfterInsert(DataSet: TDataSet);
    procedure DataSetAfterOpen(DataSet: TDataSet);
    procedure DataSetAfterPost(DataSet: TDataSet);
    procedure DataSetAfterScroll(DataSet: TDataSet);
    procedure DataSetBeforeDelete(DataSet: TDataSet);
    procedure DoSumListChanged;
    procedure Loaded; override;
    procedure MasterDataSetAfterScroll(DataSet: TDataSet);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetActive(const Value: Boolean);
    procedure SetDataSet(Value: TDataSet);
    procedure SetExternalRecalc(const Value: Boolean);
    procedure SetSumCollection(const Value: TDBSumCollection);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsSequenced: Boolean;
    function RecordCount: Integer;
    procedure Activate(ARecalcAll: Boolean);
    procedure ClearSumValues; virtual;
    procedure Deactivate(AClearSumValues: Boolean);
    procedure RecalcAll; virtual;
    procedure SetDataSetEvents;
    property RecNo: Integer read GetRecNo write SetRecNo;
  published
    property Active: Boolean read GetActive write SetActive default True;
    property DataSet: TDataSet read GetDataSet write SetDataSet;
    property ExternalRecalc: Boolean read GetExternalRecalc write SetExternalRecalc;
    property SumCollection: TDBSumCollection read GetSumCollection write SetSumCollection;
    property VirtualRecords: Boolean read GetVirtualRecords write SetVirtualRecords;
    property SumListChanged: TNotifyEvent read GetSumListChanged write SetSumListChanged;
    property OnAfterRecalcAll: TNotifyEvent read GetOnAfterRecalcAll write SetOnAfterRecalcAll;
    property OnRecalcAll: TNotifyEvent read GetOnRecalcAll write SetOnRecalcAll;
  end;

implementation

type

{ TSLBookmarkListEh }

  TSLBookmarkListEh = class(TBMListEh)
  private
    FSumListProducer: TDBSumListProducer;
  protected
    function GetDataSet: TDataSet; override;
  public
    constructor Create(ASumListProducer: TDBSumListProducer);
  end;

constructor TSLBookmarkListEh.Create(ASumListProducer: TDBSumListProducer);
begin
  inherited Create;
  FSumListProducer := ASumListProducer;
end;

function TSLBookmarkListEh.GetDataSet: TDataSet;
begin
  Result := FSumListProducer.DataSet;
end;


{ TDBSumListProducer }

constructor TDBSumListProducer.Create(AOwner: TComponent);
{$ifdef eval}
{$INCLUDE eval}
{$else}
begin
{$endif}
  inherited Create;
  FDesignTimeWork := False;
  FOwner := AOwner;
  FSumCollection := TDBSumCollection.Create(TDBSum);
  FSumCollection.FOwner := Self;
  FActive := True;
  FVirtualRecList := TSLBookmarkListEh.Create(Self);
end;

destructor TDBSumListProducer.Destroy;
begin
  Deactivate(False);
  FreeAndNil(FVirtualRecList);
  FreeAndNil(FSumCollection);
  inherited;
end;


procedure TDBSumListProducer.Assign(Source: TPersistent);
begin
  if Source is TDBSumListProducer then
  begin
    Active := TDBSumListProducer(Source).Active;
    DataSet := TDBSumListProducer(Source).DataSet;
    ExternalRecalc := TDBSumListProducer(Source).ExternalRecalc;
    SumCollection.Assign(TDBSumListProducer(Source).SumCollection);
    SumListChanged := TDBSumListProducer(Source).SumListChanged;
    VirtualRecords := TDBSumListProducer(Source).VirtualRecords;
    OnAfterRecalcAll := TDBSumListProducer(Source).OnAfterRecalcAll;
    OnRecalcAll := TDBSumListProducer(Source).OnRecalcAll;
  end
  else inherited Assign(Source);
end;

{ obsolete
function GetMasterSource(ADataSet:TDataSet): TDataSet;
var PropInfo: PPropInfo;
    PropValue: TDataSource;
begin
  Result := nil;
  PropValue := nil;
  PropInfo := GetPropInfo(ADataSet.ClassInfo, 'MasterSource');
  if (PropInfo <> nil) then begin
    if PropInfo^.PropType^.Kind = tkClass then
      try
        PropValue := (TObject(GetOrdProp(ADataSet, PropInfo)) as TDataSource);
      except // if PropInfo is not TDataSource or not inherited of
      end;
  end;
  if (PropValue <> nil) then Result := PropValue.DataSet;
end;
}

procedure TDBSumListProducer.ResetMasterInfo;
begin
  //if (AMasterSource = FMasterDataSet) then Exit;
  if Assigned(FMasterDataSet) then
  begin
    FMasterDataSet.AfterScroll := OldMasterAfterScroll;
  end;
  OldMasterAfterScroll := nil;
  FMasterPropInfo := GetPropInfo(FDataSet.ClassInfo, 'MasterSource');
  FMasterDataSet := GetMasterDataSet(FDataSet, FMasterPropInfo);
  if Assigned(FMasterDataSet)
    then OldMasterAfterScroll := FMasterDataSet.AfterScroll;
  if Assigned(FMasterDataSet)
    then FMasterDataSet.AfterScroll := MasterDataSetAfterScroll;
end;

procedure TDBSumListProducer.SetDataSetEvents;
begin
  if Assigned(FDataSet) and (FEventsOverloaded = False) then // Set new events
  begin

    FMasterPropInfo := GetPropInfo(FDataSet.ClassInfo, 'MasterSource');
    FMasterDataSet := GetMasterDataSet(FDataSet, FMasterPropInfo);

    OldAfterEdit := FDataSet.AfterEdit;
    OldAfterInsert := FDataSet.AfterInsert;
    OldAfterOpen := FDataSet.AfterOpen;
    OldAfterPost := FDataSet.AfterPost;
    OldAfterScroll := FDataSet.AfterScroll;
    OldBeforeDelete := FDataSet.BeforeDelete;
    OldAfterClose := FDataSet.AfterClose;
    OldAfterCancel := FDataSet.AfterCancel;
    if Assigned(FMasterDataSet)
      then OldMasterAfterScroll := FMasterDataSet.AfterScroll;

    FDataSet.AfterEdit := DataSetAfterEdit;
    FDataSet.AfterInsert := DataSetAfterInsert;
    FDataSet.AfterOpen := DataSetAfterOpen;
    FDataSet.AfterPost := DataSetAfterPost;
    FDataSet.AfterScroll := DataSetAfterScroll;
    FDataSet.BeforeDelete := DataSetBeforeDelete;
    FDataSet.AfterClose := DataSetAfterClose;
    FDataSet.AfterCancel := DataSetAfterCancel;
    if Assigned(FMasterDataSet)
      then FMasterDataSet.AfterScroll := MasterDataSetAfterScroll;

    FEventsOverloaded := True;

  end;
end;

procedure TDBSumListProducer.ReturnEvents;
//var i: Integer;
begin
  if Assigned(FDataSet) and (FEventsOverloaded = True) then
  begin // Return old events
    FDataSet.AfterEdit := OldAfterEdit;
    FDataSet.AfterInsert := OldAfterInsert;
    FDataSet.AfterOpen := OldAfterOpen;
    FDataSet.AfterPost := OldAfterPost;
    FDataSet.AfterScroll := OldAfterScroll;
    FDataSet.BeforeDelete := OldBeforeDelete;
    FDataSet.AfterClose := OldAfterClose;
    FDataSet.AfterCancel := OldAfterCancel;
    if Assigned(FMasterDataSet) then begin
      FMasterDataSet.AfterScroll := OldMasterAfterScroll;
    end;

    OldMasterAfterScroll := nil;
    OldAfterEdit := nil;
    OldAfterInsert := nil;
    OldAfterOpen := nil;
    OldAfterPost := nil;
    OldAfterScroll := nil;
    OldBeforeDelete := nil;
    OldAfterClose := nil;
    OldAfterCancel := nil;

    FMasterPropInfo := nil;
    FMasterDataSet := nil;

    FEventsOverloaded := False;
//    for i := 0 to FVirtualRecList.Count - 1
//      do FDataSet.FreeBookmark(FVirtualRecList[i]);
    FVirtualRecList.Clear;
  end;
end;

procedure TDBSumListProducer.SetDataSet(Value: TDataSet);
var OldActive: Boolean;
begin
  if Assigned(Value) and (FDataSet = Value) and (csDestroying in Value.ComponentState) then
  begin
    ReturnEvents;
    FDataSet := nil;
  end;
  if (FDataSet = Value) then Exit;
  if not (csLoading in FOwner.ComponentState) and
    (FDesignTimeWork or not (csDesigning in FOwner.ComponentState)) then
  begin
    OldActive := Active;
    Deactivate(True);
    FDataSet := Value;
    if OldActive then Activate(True);
  end else
    FDataSet := Value;
end;

procedure TDBSumListProducer.Loaded;
begin
//  inherited;
  if Assigned(FDataSet) and Active then begin
    Activate(True);
  end;
end;

procedure TDBSumListProducer.RecalcAll;
var
  i: Integer;
  item: TDBSum;
  NeedRecalc: Boolean;
  ABookmark: TUniBookmarkEh;
begin
  if (not FDesignTimeWork and (csDesigning in FOwner.ComponentState)) or
    (csLoading in FOwner.ComponentState) or (Active = False) or not Assigned(DataSet) or
    (DataSet.Active = False) or (FEventsOverloaded = False) then Exit;
  try
    ClearSumValues;
    FOldRecNo := -1;

    if Assigned(OnRecalcAll) then OnRecalcAll(Self);
    if ExternalRecalc then Exit;

    NeedRecalc := False;
    for i := 0 to FSumCollection.Count - 1 do
      if (TDBSum(FSumCollection.Items[i]).GroupOperation = goCount) or
        (TDBSum(FSumCollection.Items[i]).FieldName <> '') then
      begin
        NeedRecalc := True;
        Break;
      end;

    if not FDataSet.IsSequenced and VirtualRecords then
      NeedRecalc := True;

    if NeedRecalc then
    begin
      ABookmark := NilBookmarkEh;
      if FDataSet.Bookmark <> NilBookmarkEh then
        ABookmark := FDataSet.Bookmark;
      FDataSet.DisableControls;
//      for i := 0 to FVirtualRecList.Count - 1
//        do FDataSet.FreeBookmark(FVirtualRecList[i]);
      FVirtualRecList.Clear;
      Changing := True;

      FDataSet.First;
      while FDataSet.Eof = False do
      begin
        for i := 0 to FSumCollection.Count - 1 do
        begin
          item := TDBSum(FSumCollection.Items[i]);
          if (item.GroupOperation = goCount) or (item.FieldName <> '') then
          begin
            case Item.GroupOperation of
              goSum:
                if (FDataSet.FieldByName(Item.FieldName).IsNull = False) then
                  Item.SumValue := Item.SumValue + FDataSet.FieldByName(Item.FieldName).AsFloat;
              goCount:
                if (Item.FieldName = '') or not FDataSet.FieldByName(Item.FieldName).IsNull then
                  Item.SumValue := Item.SumValue + 1;
              goAvg:
                begin
                  if (FDataSet.FieldByName(Item.FieldName).IsNull = False) then
                    Inc(Item.FNotNullRecordCount);
                  Item.FSumValueAsSum := Item.FSumValueAsSum + FDataSet.FieldByName(Item.FieldName).AsFloat;
                end;
            end;
          end;
        end;
        if not FDataSet.IsSequenced and VirtualRecords then
//          FVirtualRecList.Add(FDataSet.Bookmark);
//          FVirtualRecList.CurrentRowSelected := True;
            FVirtualRecList.AppendItem(FDataSet.Bookmark);
        FDataSet.Next;
      end;
      if ABookmark <> NilBookmarkEh
        then FDataSet.Bookmark := ABookmark
        else FDataSet.First;

      for i := 0 to FSumCollection.Count - 1 do
        with TDBSum(FSumCollection.Items[i]) do
          if GroupOperation = goAvg then
            if FNotNullRecordCount <> 0
              then SumValue := FSumValueAsSum / FNotNullRecordCount
              else SumValue := 0;

      FDataSet.EnableControls;
    end;

    if Assigned(OnAfterRecalcAll) then OnAfterRecalcAll(Self);

////  SumValue := Cur;
  finally
    Filtered := FDataSet.Filtered;
    Filter := FDataSet.Filter;
    Changing := False;
    DoSumListChanged;
  end;
end;

procedure TDBSumListProducer.DataSetAfterEdit(DataSet: TDataSet);
var i: Integer;
  item: TDBSum;
begin
  if (Active = False) then Exit;

  for i := 0 to FSumCollection.Count - 1 do
  begin
    item := TDBSum(FSumCollection.Items[i]);
    if (item.GroupOperation = goCount) or (item.FieldName <> '') then
    begin
      case Item.GroupOperation of
        goSum, goAvg:
          begin
            if (FDataSet.FieldByName(Item.FieldName).IsNull = False)
              then Item.Value := FDataSet.FieldByName(Item.FieldName).AsFloat
              else Item.Value := 0;
            Item.VarValue := FDataSet.FieldByName(Item.FieldName).AsVariant;
          end;
        goCount:
          if (Item.FieldName = '') or not FDataSet.FieldByName(Item.FieldName).IsNull
            then Item.Value := 1
            else Item.Value := 0;
      end;
    end;
  end;
  if (Assigned(OldAfterEdit)) then
    OldAfterEdit(DataSet);
end;

procedure TDBSumListProducer.DataSetAfterInsert(DataSet: TDataSet);
var i: Integer;
  Item: TDBSum;
{$IFDEF EH_LIB_12}
  ABookMark: TBookmark;
{$ELSE}
  ABookMark: TBookmarkStr;
{$ENDIF}
begin
  if Active then
  begin
    for i := 0 to FSumCollection.Count - 1 do
    begin
      Item := TDBSum(FSumCollection.Items[i]);
      if (item.GroupOperation = goCount) or (item.FieldName <> '') then
      begin
        case Item.GroupOperation of
          goSum, goAvg:
            begin
              Item.Value := 0;
              Item.VarValue := Null;
            end;
          goCount:
            if not (Item.FieldName = '') and not FDataSet.FieldByName(Item.FieldName).IsNull
              then Item.Value := 1
              else Item.Value := 0;
        end;
      end;
    end;

    if not FDataSet.IsSequenced and VirtualRecords then
    begin
      ABookMark := FDataSet.Bookmark;
{$IFDEF EH_LIB_12}
      if ABookMark <> nil
{$ELSE}
      if ABookMark <> ''
{$ENDIF}
        then FVirtualRecList.AppendItem(ABookMark)
        else FTryedInsert := True;
    end;
  end;
  if (Assigned(OldAfterInsert)) then
    OldAfterInsert(DataSet);
end;

procedure TDBSumListProducer.DataSetAfterOpen(DataSet: TDataSet);
begin
  if Active then RecalcAll;
  if (Assigned(OldAfterOpen)) then
    OldAfterOpen(DataSet);
end;

procedure TDBSumListProducer.DataSetAfterPost(DataSet: TDataSet);
var i: Integer;
  item: TDBSum;
  ARecNo, C: Integer;
begin
  if Active then
  begin
    for i := 0 to FSumCollection.Count - 1 do
    begin
      item := TDBSum(FSumCollection.Items[i]);
      if (item.GroupOperation = goCount) or (item.FieldName <> '') then
      begin
        case Item.GroupOperation of
          goSum:
            if (FDataSet.FieldByName(Item.FieldName).IsNull = False) then
              Item.SumValue := Item.SumValue - Item.Value + FDataSet.FieldByName(Item.FieldName).AsFloat
            else
              Item.SumValue := Item.SumValue - Item.Value;
          goCount:
            if (Item.FieldName = '') or not FDataSet.FieldByName(Item.FieldName).IsNull
              then Item.SumValue := Item.SumValue - Item.Value + 1
              else Item.SumValue := Item.SumValue - Item.Value;
          goAvg:
            begin
              if (FDataSet.FieldByName(Item.FieldName).IsNull = False) then
              begin
                if Item.VarValue = Null then Inc(Item.FNotNullRecordCount);
                Item.FSumValueAsSum := Item.FSumValueAsSum - Item.Value + FDataSet.FieldByName(Item.FieldName).AsFloat
              end else
              begin
                if Item.VarValue <> Null then Dec(Item.FNotNullRecordCount);
                Item.FSumValueAsSum := Item.FSumValueAsSum - Item.Value;
              end;
              if Item.FNotNullRecordCount <> 0
                then Item.SumValue := Item.FSumValueAsSum / Item.FNotNullRecordCount
                else Item.SumValue := 0;
            end;
        end;
      end;
    end;

    if not FDataSet.IsSequenced and VirtualRecords and FTryedInsert = True then
    begin
      ARecNo := FOldRecNo;
      if (ARecNo = -1) or (ARecNo >= FVirtualRecList.Count) then ARecNo := 0;
      if (FVirtualRecList.Count > 0) then
        C := DataSetCompareBookmarks(DataSet, FVirtualRecList[ARecNo], FDataSet.Bookmark)
      else
        C := 0;
      if (C > 0) then
        while C > 0 do
        begin
          if (ARecNo = 0) then Break;
          Dec(ARecNo);
          C := DataSetCompareBookmarks(DataSet, FVirtualRecList[ARecNo], FDataSet.Bookmark);
        end
      else if (C < 0) then
        while C < 0 do
        begin
          Inc(ARecNo);
          if (ARecNo >= FVirtualRecList.Count) then Break;
          C := DataSetCompareBookmarks(DataSet, FVirtualRecList[ARecNo], FDataSet.Bookmark);
        end;
      FVirtualRecList.InsertItem(ARecNo, FDataSet.Bookmark);
      FTryedInsert := False;
    end;
    DoSumListChanged;
  end;
  if (Assigned(OldAfterPost)) then
    OldAfterPost(DataSet);
end;

procedure TDBSumListProducer.DataSetAfterScroll(DataSet: TDataSet);
begin
  if (Assigned(OldAfterScroll)) then
    OldAfterScroll(DataSet);
  if (Active = False) then Exit;

  if (Changing = False) then
  begin
    if ((DataSet.Filtered and (Filter <> DataSet.Filter)) or (Filtered <> DataSet.Filtered)) then
      RecalcAll;
   {else if (FMasterDataset <> GetMasterDataSet(FMasterPropInfo)) then begin
     ResetMasterInfo;
     RecalcAll;
   end;}
  end;
end;

procedure TDBSumListProducer.DataSetBeforeDelete(DataSet: TDataSet);
var i: Integer;
  item: TDBSum;
begin
  if (Assigned(OldBeforeDelete)) then
    OldBeforeDelete(DataSet);
  if (Active = False) then Exit;

  for i := 0 to FSumCollection.Count - 1 do
  begin
    item := TDBSum(FSumCollection.Items[i]);
    if (item.GroupOperation = goCount) or (item.FieldName <> '') then
    begin
      case Item.GroupOperation of
        goSum:
          Item.SumValue := Item.SumValue - FDataSet.FieldByName(Item.FieldName).AsFloat;
        goCount:
          if (Item.FieldName = '') or not FDataSet.FieldByName(Item.FieldName).IsNull
            then Item.SumValue := Item.SumValue - 1;
        goAvg:
          begin
            Item.FSumValueAsSum := Item.FSumValueAsSum - FDataSet.FieldByName(Item.FieldName).AsFloat;
            if not FDataSet.FieldByName(Item.FieldName).IsNull then Dec(Item.FNotNullRecordCount);
            if Item.FNotNullRecordCount <> 0
              then Item.SumValue := Item.FSumValueAsSum / Item.FNotNullRecordCount
              else Item.SumValue := 0;
          end;
      end;
    end;
  end;

  if not FDataSet.IsSequenced and VirtualRecords then
  begin
    i := FindVirtualRecord(FDataSet.Bookmark);
    if i >= 0 then
    begin
//      FDataSet.FreeBookmark(FVirtualRecList[i]);
      FVirtualRecList.DeleteItem(i);
    end;
  end;

  DoSumListChanged;
end;

procedure TDBSumListProducer.DataSetAfterClose(DataSet: TDataSet);
//var
//  i: integer;
begin
  if Active then
  begin
    ClearSumValues;
    DoSumListChanged;
    Changing := False;
  end;

//  if Assigned(FDataSet) and Assigned(FVirtualRecList) and (FVirtualRecList.Count > 0) then
//    for i := 0 to FVirtualRecList.Count - 1 do
//      FDataSet.FreeBookmark(FVirtualRecList[i]);
  FVirtualRecList.Clear;

  if (Assigned(OldAfterClose)) then
    OldAfterClose(DataSet);
end;

procedure TDBSumListProducer.SetSumCollection(const Value: TDBSumCollection);
begin
  FSumCollection.Assign(Value);
end;

procedure TDBSumListProducer.SetActive(const Value: Boolean);
begin
  if (FActive = Value) then Exit;
  if (Value = True) then Activate(True);
  if (Value = False) then Deactivate(True);
end;

procedure TDBSumListProducer.Activate(ARecalcAll: Boolean);
begin
  FActive := True;
  if (csLoading in FOwner.ComponentState) or
    (not FDesignTimeWork and (csDesigning in FOwner.ComponentState)) then Exit;
  SetDataSetEvents;
  if ARecalcAll then RecalcAll;
end;

procedure TDBSumListProducer.Deactivate(AClearSumValues: Boolean);
begin
  FActive := False;
  if (csLoading in FOwner.ComponentState) or
    (not FDesignTimeWork and (csDesigning in FOwner.ComponentState)) then Exit;
  ReturnEvents;
  if AClearSumValues then ClearSumValues;
end;

procedure TDBSumListProducer.DoSumListChanged;
begin
  if Assigned(SumListChanged) then SumListChanged(Self);
end;

procedure TDBSumListProducer.ClearSumValues;
var i: Integer;
  item: TDBSum;
begin
  for i := 0 to FSumCollection.Count - 1 do
  begin
    item := TDBSum(FSumCollection.Items[i]);
    item.SumValue := 0;
    item.Value := 0;
    item.FSumValueAsSum := 0;
    item.FNotNullRecordCount := 0;
  end;
  DoSumListChanged;
end;

procedure TDBSumListProducer.SetExternalRecalc(const Value: Boolean);
begin
  if (FExternalRecalc = Value) then Exit;
  FExternalRecalc := Value;
  RecalcAll;
end;


procedure TDBSumListProducer.MasterDataSetAfterScroll(DataSet: TDataSet);
begin
  if (Assigned(OldMasterAfterScroll)) then
    OldMasterAfterScroll(DataSet);

  if (Active = False) then Exit;
  if Changing = False then RecalcAll;
end;

procedure TDBSumListProducer.DataSetAfterCancel(DataSet: TDataSet);
begin
  if (Assigned(OldAfterCancel)) then
    OldAfterCancel(DataSet);
  FTryedInsert := False;
end;


function TDBSumListProducer.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TDBSumListProducer.Update;
begin
  if (csLoading in FOwner.ComponentState) then Exit;
  if (csDestroying in FOwner.ComponentState) then Exit; 
  {if (FSumCollection.Count = 0) then begin
    if FEventsOverloaded then ReturnEvents;
  end else begin
    if not FEventsOverloaded then SetDataSetEvents;
    RecalcAll;
  end;}
  RecalcAll;
end;

procedure TDBSumListProducer.SetVirtualRecords(const Value: Boolean);
begin
  if (FVirtualRecords = Value) then Exit;
  FVirtualRecords := Value;
  if FVirtualRecords then RecalcAll;
end;

function TDBSumListProducer.GetRecNo: Integer;
begin
  if not DataSet.IsSequenced and VirtualRecords and Active then
    Result := FindVirtualRecord(DataSet.Bookmark) + 1
  else
    Result := DataSet.RecNo;
end;

procedure TDBSumListProducer.SetRecNo(const Value: Integer);
begin
  if not DataSet.IsSequenced and VirtualRecords and Active then
    DataSet.Bookmark := FVirtualRecList[Value - 1]
  else
    DataSet.RecNo := Value;
end;

function TDBSumListProducer.RecordCount: Integer;
begin
  if Assigned(DataSet) and not DataSet.IsSequenced and VirtualRecords and Active then
    Result := FVirtualRecList.Count
  else if Assigned(DataSet) then
    Result := DataSet.RecordCount
  else Result := 0;
end;

function TDBSumListProducer.IsSequenced: Boolean;
begin
  Result := (Assigned(DataSet) and DataSet.IsSequenced) or
    (Assigned(DataSet) and VirtualRecords and Active and not ((FVirtualRecList.Count = 0) and not (DataSet.EOF and DataSet.BOF)));
//  if VirtualRecords and Active and (FVirtualRecList.Count = 0) and not (DataSet.EOF and DataSet.BOF) then // Not yet recalculated
//    Result := False;
end;

function TDBSumListProducer.FindVirtualRecord(Bookmark: TUniBookmarkEh): Integer;
var
  C: Integer;
begin
  Result := -1;
  if FOldRecNo = -1 then FOldRecNo := 0;

  if FVirtualRecList.Count = 0 then Exit;
  if FOldRecNo >= FVirtualRecList.Count then FOldRecNo := 0; //Raise Exception.Create('Unexpected error -1 in function FindVirtualRecord');

  C := DataSetCompareBookmarks(DataSet, FVirtualRecList[FOldRecNo], Bookmark);

  if (C > 0) then
    while C <> 0 do
    begin
      Dec(FOldRecNo);
      if (FOldRecNo < 0) then Exit; //Raise Exception.Create('Unexpected error -2 in function FindVirtualRecord');
      C := DataSetCompareBookmarks(DataSet, FVirtualRecList[FOldRecNo], Bookmark);
    end
  else if (C < 0) then
    while C <> 0 do
    begin
      Inc(FOldRecNo);
      if (FOldRecNo >= FVirtualRecList.Count) then Exit; //Raise Exception.Create('Unexpected error -3 in function FindVirtualRecord');
      C := DataSetCompareBookmarks(DataSet, FVirtualRecList[FOldRecNo], Bookmark);
    end;

  Result := FOldRecNo;
end;


//
//  TDBSum
//

procedure TDBSum.Assign(Source: TPersistent);
begin
  if Source is TDBSum then
  begin
    GroupOperation := TDBSum(Source).GroupOperation;
    FieldName := TDBSum(Source).FieldName;
    Value := TDBSum(Source).Value;
    SumValue := TDBSum(Source).SumValue;
  end
  else inherited Assign(Source);
end;

constructor TDBSum.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  // Delphi8 set default value for FFieldName to 'null' string. Why?????
  FFieldName := '';
end;

procedure TDBSum.SetFieldName(const Value: String);
begin
  if (FFieldName = Value) then Exit;
  FFieldName := Value;
  Changed(False);
end;

procedure TDBSum.SetGroupOperation(const Value: TGroupOperation);
begin
  if (FGroupOperation = Value) then Exit;
  FGroupOperation := Value;
  Changed(False);
end;

//
//  TDBSumCollection
//

function TDBSumCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TDBSumCollection.GetItem(Index: Integer): TDBSum;
begin
  Result := TDBSum(inherited GetItem(Index));
end;

procedure TDBSumCollection.SetItem(Index: Integer; Value: TDBSum);
begin
  inherited SetItem(Index, Value);
end;

procedure TDBSumCollection.Update(Item: TCollectionItem);
begin
  TDBSumListProducer(FOwner).Update;
end;

function TDBSumCollection.GetSumByOpAndFName(
  AGroupOperation: TGroupOperation; AFieldName: String): TDBSum;
var i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if (AGroupOperation = Items[i].GroupOperation) and
      (AnsiCompareText(AFieldName, Items[i].FieldName) = 0) then
    begin
      Result := Items[i];
      Exit;
    end;
  end;
end;


{ TDBSumList }

constructor TDBSumList.Create(AOwner: TComponent);
begin
  inherited;
  FSumListProducer := TDBSumListProducer.Create(Self);
end;

destructor TDBSumList.Destroy;
begin
  inherited;
  FreeAndNil(FSumListProducer);
end;


procedure TDBSumList.Activate(ARecalcAll: Boolean);
begin
  FSumListProducer.Activate(ARecalcAll);
end;

procedure TDBSumList.ClearSumValues;
begin
  FSumListProducer.ClearSumValues;
end;

procedure TDBSumList.DataSetAfterClose(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterClose(DataSet);
end;

procedure TDBSumList.DataSetAfterEdit(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterEdit(DataSet);
end;

procedure TDBSumList.DataSetAfterInsert(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterInsert(DataSet);
end;

procedure TDBSumList.DataSetAfterOpen(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterOpen(DataSet);
end;

procedure TDBSumList.DataSetAfterPost(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterPost(DataSet);
end;

procedure TDBSumList.DataSetAfterScroll(DataSet: TDataSet);
begin
  FSumListProducer.DataSetAfterScroll(DataSet);
end;

procedure TDBSumList.DataSetBeforeDelete(DataSet: TDataSet);
begin
  FSumListProducer.DataSetBeforeDelete(DataSet);
end;

procedure TDBSumList.Deactivate(AClearSumValues: Boolean);
begin
  FSumListProducer.Deactivate(AClearSumValues);
end;

procedure TDBSumList.DoSumListChanged;
begin
  FSumListProducer.DoSumListChanged;
end;

procedure TDBSumList.Loaded;
begin
  inherited;
  FSumListProducer.Loaded;
end;

procedure TDBSumList.MasterDataSetAfterScroll(DataSet: TDataSet);
begin
  FSumListProducer.MasterDataSetAfterScroll(DataSet);
end;

procedure TDBSumList.RecalcAll;
begin
  FSumListProducer.RecalcAll;
end;

procedure TDBSumList.SetActive(const Value: Boolean);
begin
  FSumListProducer.SetActive(Value);
end;

procedure TDBSumList.SetDataSet(Value: TDataSet);
begin
  FSumListProducer.SetDataSet(Value);
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TDBSumList.SetDataSetEvents;
begin
  FSumListProducer.SetDataSetEvents;
end;

procedure TDBSumList.SetExternalRecalc(const Value: Boolean);
begin
  FSumListProducer.SetExternalRecalc(Value);
end;

procedure TDBSumList.SetSumCollection(const Value: TDBSumCollection);
begin
  FSumListProducer.SetSumCollection(Value);
end;

function TDBSumList.GetActive: Boolean;
begin
  Result := FSumListProducer.Active;
end;

function TDBSumList.GetDataSet: TDataSet;
begin
  Result := FSumListProducer.DataSet;
end;

function TDBSumList.GetExternalRecalc: Boolean;
begin
  Result := FSumListProducer.ExternalRecalc;
end;

function TDBSumList.GetOnRecalcAll: TNotifyEvent;
begin
  Result := FSumListProducer.OnRecalcAll;
end;

function TDBSumList.GetSumCollection: TDBSumCollection;
begin
  Result := FSumListProducer.SumCollection;
end;

function TDBSumList.GetSumListChanged: TNotifyEvent;
begin
  Result := FSumListProducer.SumListChanged;
end;

procedure TDBSumList.SetOnRecalcAll(const Value: TNotifyEvent);
begin
  FSumListProducer.OnRecalcAll := Value;
end;

procedure TDBSumList.SetSumListChanged(const Value: TNotifyEvent);
begin
  FSumListProducer.SumListChanged := Value;
end;

function TDBSumList.IsSequenced: Boolean;
begin
  Result := FSumListProducer.IsSequenced;
end;

function TDBSumList.RecordCount: Integer;
begin
  Result := FSumListProducer.RecordCount;
end;

procedure TDBSumList.SetVirtualRecords(const Value: Boolean);
begin
  FSumListProducer.VirtualRecords := Value;
end;

function TDBSumList.GetVirtualRecords: Boolean;
begin
  Result := FSumListProducer.VirtualRecords;
end;

function TDBSumList.GetRecNo: Integer;
begin
  Result := FSumListProducer.RecNo;
end;

procedure TDBSumList.SetRecNo(const Value: Integer);
begin
  FSumListProducer.RecNo := Value;
end;

procedure TDBSumList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent is TDataSet) and (AComponent = DataSet) then
    begin
      DataSet := nil;
    end;
  end;
end;

function TDBSumList.GetOnAfterRecalcAll: TNotifyEvent;
begin
  Result := FSumListProducer.OnAfterRecalcAll;
end;

procedure TDBSumList.SetOnAfterRecalcAll(const Value: TNotifyEvent);
begin
  FSumListProducer.OnAfterRecalcAll := Value;
end;

end.
