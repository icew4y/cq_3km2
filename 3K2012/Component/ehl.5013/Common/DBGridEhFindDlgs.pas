{*******************************************************}
{                                                       }
{                    EhLib v5.0                         }
{                                                       }
{        Find dialog for TDBGridEh component            }
{                      Build 5.0.00                     }
{                                                       }
{     Copyright (c) 2004 by Dmitry V. Bolshakov         }
{                                                       }
{*******************************************************}

unit DBGridEhFindDlgs  {$IFDEF CIL} platform{$ENDIF};

interface

uses
  Windows, Messages, SysUtils, {$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrlsEh, StdCtrls, Mask, DBGridEh, ToolCtrlsEh;

type

  TColumnFieldItemEh = record
    Caption: String;
    Column: TColumnEh;
  end;

  TColumnFieldsArrEh = array of TColumnFieldItemEh;

  TDBGridEhFindDlg = class(TForm)
    cbText: TDBComboBoxEh;
    bFind: TButton;
    bCancel: TButton;
    Label1: TLabel;
    cbFindIn: TDBComboBoxEh;
    Label2: TLabel;
    cbMatchinType: TDBComboBoxEh;
    cbMatchType: TLabel;
    cbFindDirection: TDBComboBoxEh;
    Label3: TLabel;
    cbCharCase: TDBCheckBoxEh;
    cbUseFormat: TDBCheckBoxEh;
    Label4: TLabel;
    dbcTreeFindRange: TDBComboBoxEh;
    procedure bFindClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure cbFindInChange(Sender: TObject);
    procedure cbTextChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FGrid: TCustomDBGridEh;
    IsFirstTry: Boolean;
    FFindColumnsList: TColumnsEhList;
    FCurInListColIndex: Integer;
    FColumnFields: TColumnFieldsArrEh;
    FSourceHeight: Integer;
//    function ColText(Col: TColumnEh): String;
  public
    procedure FillFindColumnsList;
    procedure FillColumnsList;
    procedure Execute(AGrid: TCustomDBGridEh; Text, ColumnFieldName: String;
      ColumnFields: TColumnFieldsArrEh; Modal: Boolean);
    property Grid: TCustomDBGridEh read FGrid;
  end;

var
  DBGridEhFindDlg: TDBGridEhFindDlg;

procedure ExecuteDBGridEhFindDialog(Grid: TCustomDBGridEh; Text, FieldName: String;
  ColumnFields: TColumnFieldsArrEh;  Modal: Boolean);

type
  TExecuteDBGridEhFindDialogProc = procedure (Grid: TCustomDBGridEh; Text, FieldName: String;
    ColumnFields: TColumnFieldsArrEh;  Modal: Boolean);
var
  ExecuteDBGridEhFindDialogProc: TExecuteDBGridEhFindDialogProc;

implementation

uses EhLibConsts;

{$R *.dfm}

procedure ExecuteDBGridEhFindDialog(Grid: TCustomDbGridEh; Text, FieldName: String;
  ColumnFields: TColumnFieldsArrEh;  Modal: Boolean);
begin
  if not Assigned(DBGridEhFindDlg) then
    DBGridEhFindDlg := TDBGridEhFindDlg.Create(Application);
  DBGridEhFindDlg.Execute(Grid, Text, FieldName, ColumnFields, Modal);
end;

procedure TDBGridEhFindDlg.Execute(AGrid: TCustomDBGridEh; Text, ColumnFieldName: String;
  ColumnFields: TColumnFieldsArrEh; Modal: Boolean);
var
  IntMemTable: IMemTableEh;
begin
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) and
     (AGrid.DataSource.DataSet.Active) and
      Supports(AGrid.DataSource.DataSet, IMemTableEh, IntMemTable) and
      IntMemTable.MemTableIsTreeList
  then
  begin
    Height := FSourceHeight;
    Label4.Visible := True;
    dbcTreeFindRange.Visible := True;
  end else
  begin
    ClientHeight := dbcTreeFindRange.Top;
    Label4.Visible := False;
    dbcTreeFindRange.Visible := False;
  end;
  FCurInListColIndex := -1;
  cbText.Text := Text;
  FGrid := AGrid;
  FillColumnsList;
  cbFindIn.ItemIndex := cbFindIn.Items.IndexOf(FGrid.Columns[FGrid.SelectedIndex].Title.Caption);
  IsFirstTry := True;
  Close;
  ActiveControl := cbText;
  FillFindColumnsList;
  if Modal then
  begin
    FormStyle := fsNormal;
    ShowModal;
  end else
  begin
    FormStyle := fsStayOnTop;
    Show;
    SetFocus;
  end;
end;

function AnsiContainsText(const AText, ASubText: string): Boolean;
begin
  Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
end;

function AnsiContainsStr(const AText, ASubText: string): Boolean;
begin
  Result := AnsiPos(ASubText, AText) > 0;
end;

procedure TDBGridEhFindDlg.bFindClick(Sender: TObject);
var
  BackFind: Boolean;

  function CheckEofBof: Boolean;
  begin
    if (cbFindDirection.ItemIndex = 0) xor BackFind
      then Result := Grid.DataSource.DataSet.Bof
      else Result := Grid.DataSource.DataSet.Eof;
  end;

  procedure ToNextRec;
  begin
    if (cbFindDirection.ItemIndex = 0) xor BackFind then
    begin
      if FCurInListColIndex > 0 then
        Dec(FCurInListColIndex)
      else
      begin
        Grid.DataSource.DataSet.Prior;
        FCurInListColIndex := FFindColumnsList.Count-1;
      end;
    end else
    begin
      if FCurInListColIndex < FFindColumnsList.Count-1 then
        Inc(FCurInListColIndex)
      else
      begin
        Grid.DataSource.DataSet.Next;
        FCurInListColIndex := 0;
      end;
    end;
  end;

var
  RecordFounded: Boolean;
//  DataText: String;
//  TLocateTextOptionEh = (ltoCaseInsensitiveEh, ltoAllFieldsEh, ltoMatchFormatEh, ltoIgnoteCurrentPosEh);
  Options: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; // = (ltdUpEh, ltdDownEh, ltdAllEh);
  Matching: TLocateTextMatchingEh; // = (ltmAnyPartEh, ltmWholeEh, ltmFromBegingEh);
  TreeFindRange: TLocateTextTreeFindRangeEh;
  FieldName: String;

begin
  if GetKeyState(VK_CONTROL) < 0
    then BackFind := True
    else BackFind := False;
  if cbText.Items.IndexOf(cbText.Text) = -1 then
    cbText.Items.Add(cbText.Text);
//  RecordFounded := False;
  if Assigned(Grid) and Assigned(Grid.DataSource) and Assigned(Grid.DataSource.DataSet)
    and Grid.DataSource.DataSet.Active
  then
  begin
    Options := [];
    if not cbCharCase.Checked then
      Options := Options + [ltoCaseInsensitiveEh];
    if cbUseFormat.Checked then
      Options := Options + [ltoMatchFormatEh];
    if cbFindIn.ItemIndex = cbFindIn.Items.Count-1 then
      Options := Options + [ltoAllFieldsEh];
    case cbFindDirection.ItemIndex of
      0: Direction := ltdUpEh;
      1: Direction := ltdDownEh;
      2: Direction := ltdAllEh;
    else
      Direction := ltdAllEh;
    end;
    if BackFind then
      if Direction = ltdUpEh
        then Direction := ltdDownEh
        else Direction := ltdUpEh;
    if not IsFirstTry and (Direction = ltdAllEh) then
      Direction := ltdDownEh;
    case cbMatchinType.ItemIndex of
      0: Matching := ltmAnyPartEh;
      1: Matching := ltmWholeEh;
      2: Matching := ltmFromBegingEh;
    else
      Matching := ltmAnyPartEh;
    end;
    if (cbFindIn.ItemIndex >= 0) and (cbFindIn.Items.Objects[cbFindIn.ItemIndex] <> nil) then
      FieldName := TColumnEh(cbFindIn.Items.Objects[cbFindIn.ItemIndex]).FieldName
    else
      FieldName := '';
    case dbcTreeFindRange.ItemIndex of
      0: TreeFindRange := lttInAllNodesEh;
      1: TreeFindRange := lttInExpandedNodesEh;
      2: TreeFindRange := lttInCurrentLevelEh;
      3: TreeFindRange := lttInCurrentNodeEh;
    else
      TreeFindRange := lttInAllNodesEh;
    end;

    RecordFounded := Grid.LocateText(Grid, FieldName, cbText.Text,
      Options, Direction, Matching, TreeFindRange);
    if RecordFounded then
      IsFirstTry := False;

{    if (FFindColumnsList.Count = 0) then Exit;
    with Grid do
    begin
      Grid.DataSource.DataSet.DisableControls;
      SaveBookmark;
      try
        if (cbFindDirection.ItemIndex = 2) and IsFirstTry then
          Grid.DataSource.DataSet.First;
        if not IsFirstTry then
          ToNextRec;
        while not CheckEofBof do
        begin
          DataText := ColText(FFindColumnsList[FCurInListColIndex]);
          //CharCase
          if cbCharCase.Checked then
          begin
            //From any part of field
            if ( (cbMatchinType.ItemIndex = 0) and (
                AnsiContainsStr(DataText, cbText.Text) )
               ) or (
            //Whole field
              (cbMatchinType.ItemIndex = 1) and (DataText = cbText.Text)
              ) or ((cbMatchinType.ItemIndex = 2) and
            //From beging of field
              (Copy(DataText, 1, Length(cbText.Text)) =
                cbText.Text) ) then
            begin
              RecordFounded := True;
              IsFirstTry := False;
              Break;
            end
          end else
          //From any part of field
          if ( (cbMatchinType.ItemIndex = 0) and (
              AnsiContainsText(DataText, cbText.Text) )
             ) or (
          //Whole field
            (cbMatchinType.ItemIndex = 1) and (
            AnsiUpperCase(DataText) =
            AnsiUpperCase(cbText.Text))
            ) or ((cbMatchinType.ItemIndex = 2) and
          //From beging of field
            (AnsiUpperCase(Copy(DataText, 1, Length(cbText.Text))) =
            AnsiUpperCase(cbText.Text)) ) then
          begin
            RecordFounded := True;
            Grid.SelectedIndex := FFindColumnsList[FCurInListColIndex].Index;
            IsFirstTry := False;
            Break;
          end;
          ToNextRec;
        end;
        if not RecordFounded then RestoreBookmark;
      finally
        Grid.DataSource.DataSet.EnableControls;
      end;
      if not RecordFounded then
        ShowMessage(Format(SFindDialogStringNotFoundMessageEh, [cbText.Text]));
    end;
  }end;
end;

procedure TDBGridEhFindDlg.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TDBGridEhFindDlg.FillColumnsList;
var
  i: Integer;
begin
  cbFindIn.OnChange := nil;
  cbFindIn.Items.Clear;
  if Length(FColumnFields) <> 0 then
  begin
    for i := 0 to Length(FColumnFields)-1 do
      cbFindIn.Items.AddObject(FColumnFields[i].Caption, FColumnFields[i].Column);
  end else
  begin
    for i:= 0 to FGrid.VisibleColumns.Count-1 do
      cbFindIn.Items.AddObject(FGrid.VisibleColumns[i].Title.Caption,
        FGrid.VisibleColumns[i]);
  end;
  cbFindIn.Items.AddObject('<All>', nil);
  cbFindIn.KeyItems.Clear;
  for i:= 0 to cbFindIn.Items.Count-1 do
    cbFindIn.KeyItems.Add(cbFindIn.Items[i]);
  cbFindIn.OnChange := cbFindInChange;
end;

procedure TDBGridEhFindDlg.FillFindColumnsList;
var
  i: Integer;
begin
  if FFindColumnsList = nil then
    FFindColumnsList := TColumnsEhList.Create;
  FFindColumnsList.Clear;
  if cbFindIn.ItemIndex = -1 then
    cbFindIn.ItemIndex := cbFindIn.Items.Count-1;
  if cbFindIn.ItemIndex = cbFindIn.Items.Count-1 then //All
  begin
    for i := 0 to cbFindIn.Items.Count-2 do
      FFindColumnsList.Add(cbFindIn.Items.Objects[i])
  end else
    FFindColumnsList.Add(cbFindIn.Items.Objects[cbFindIn.ItemIndex]);

  cbTextChange(nil);
end;

procedure TDBGridEhFindDlg.cbFindInChange(Sender: TObject);
begin
  FillFindColumnsList;
end;

procedure TDBGridEhFindDlg.cbTextChange(Sender: TObject);
begin
  IsFirstTry := True;
  if cbFindDirection.ItemIndex = 0
    then FCurInListColIndex := FFindColumnsList.Count-1
    else FCurInListColIndex := 0;
end;

{function TDBGridEhFindDlg.ColText(Col: TColumnEh): String;
begin
  if cbUseFormat.Checked then
    Result := Col.DisplayText
  else if Col.Field <> nil then
    Result := Col.Field.AsString
  else
    Result := '';
end;}

procedure TDBGridEhFindDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key in [VK_ESCAPE, VK_RETURN]) then
  begin
    if (ActiveControl <> nil) and
       (ActiveControl.Perform(CM_WANTSPECIALKEY, Key, 0) <> 0)
    then
      Exit;
    if (Key = VK_ESCAPE) and not (fsModal in FormState) then
     Close
    else if (Key = VK_RETURN) then
      bFindClick(nil);
    cbText.Modified := False;
  end;
end;

procedure TDBGridEhFindDlg.FormCreate(Sender: TObject);
begin
  FSourceHeight := Height;
end;

procedure TDBGridEhFindDlg.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FFindColumnsList);
end;

initialization
  ExecuteDBGridEhFindDialogProc := ExecuteDBGridEhFindDialog;
end.
