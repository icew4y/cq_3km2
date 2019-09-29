unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, DataDriverEh, BDEDataDriverEh, MemTableEh, DBGridEh,
  MemTableDataEh, StdCtrls, GridsEh;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    mtPhoneList: TMemTableEh;
    BDEDataDriverIB: TBDEDataDriverEh;
    Database1: TDatabase;
    Button1: TButton;
    Button2: TButton;
    procedure BDEDataDriverIBBuildDataStruct(DataDriver: TDataDriverEh; DataStruct: TMTDataStructEh);
    procedure BDEDataDriverIBUpdateError(DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh;
      MemRec: TMemoryRecordEh; var Action: TUpdateErrorActionEh);
    procedure BDEDataDriverIBUpdateRecord(DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh;
      MemRec: TMemoryRecordEh);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BDEDataDriverIBBuildDataStruct(DataDriver: TDataDriverEh;
  DataStruct: TMTDataStructEh);
begin
  BDEDataDriverIB.DefaultBuildDataStruct(DataStruct);
  DataStruct.CreateField(TMTBooleanDataFieldEh).FieldName := 'Bool';
end;

procedure TForm1.BDEDataDriverIBUpdateError(DataDriver: TDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Action: TUpdateErrorActionEh);
begin
  Action := ueaCountinueEh;
end;

procedure TForm1.BDEDataDriverIBUpdateRecord(DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh);
begin
  if MemRec.UpdateStatus in [usModified, usInserted] then
  begin
    BDEDataDriverIB.DefaultUpdateRecord(MemTableData, MemRec);
    BDEDataDriverIB.RefreshRecord(MemRec);
  end else
    BDEDataDriverIB.DefaultUpdateRecord(MemTableData, MemRec);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  mtPhoneList.ApplyUpdates(-1);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  mtPhoneList.CancelUpdates;
end;

procedure TForm1.DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if mtPhoneList.UpdateStatus <> usUnmodified then
    Background := $00FAD5BC;
end;

initialization
  DefFontData.Name := 'Microsoft Sans Serif';
end.
