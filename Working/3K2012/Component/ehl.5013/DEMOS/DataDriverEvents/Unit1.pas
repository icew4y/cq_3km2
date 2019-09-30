unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF EH_LIB_7} XPMan, {$ENDIF}
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Db, GridsEh, DBGridEh, DBTables, DataDriverEh, MemTableEh, MemTableDataEh,
  DBCtrlsEh, StdCtrls;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DataSetDriverEh1: TDataSetDriverEh;
    Table1: TTable;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    Label1: TLabel;
    procedure DataSetDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
      DataStruct: TMTDataStructEh);
    procedure DataSetDriverEh1ReadRecord(DataDriver: TDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
      var ProviderEOF: Boolean);
    procedure MemTableEh1SetFieldValue(MemTable: TCustomMemTableEh;
      Field: TField; var Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DataSetDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
  DataStruct: TMTDataStructEh);
var
  DataField: TMTDataFieldEh;
begin
  DataSetDriverEh1.DefaultBuildDataStruct(DataStruct);

  DataField := DataStruct.CreateField(TMTDateTimeDataFieldEh);
  DataField.FieldName := 'LastInvoiceDate1';
  TMTDateTimeDataFieldEh(DataField).DateTimeDataType :=  fdtDateEh;

  DataField := DataStruct.CreateField(TMTDateTimeDataFieldEh);
  DataField.FieldName := 'LastInvoiceTime1';
  TMTDateTimeDataFieldEh(DataField).DateTimeDataType :=  fdtTimeEh;
end;

procedure TForm1.DataSetDriverEh1ReadRecord(DataDriver: TDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
  var ProviderEOF: Boolean);
var
  Field: TField;
begin
  Field := DataSetDriverEh1.ProviderDataSet.FieldByName('LastInvoiceDate');
  if not Field.IsNull then
  begin
    MemRec.DataValues['LastInvoiceDate1', dvvValueEh] := Integer(Trunc(Field.AsDateTime));
    MemRec.DataValues['LastInvoiceTime1', dvvValueEh] := Frac(Field.AsDateTime);
  end;
  DataSetDriverEh1.DefaultReadRecord(MemTableData, MemRec, ProviderEOF);
end;

procedure TForm1.MemTableEh1SetFieldValue(MemTable: TCustomMemTableEh;
  Field: TField; var Value: Variant);
begin
  if (Field.FieldName = 'LastInvoiceDate1') then
  begin
    if not VarIsNull(Value) and Value < EncodeDate(1900, 1, 1) then
      raise Exception.Create('Date is too low');
    MemTable.FieldByName('LastInvoiceDate').AsDateTime
      := MemTable.FieldByName('LastInvoiceTime1').AsDateTime + Field.AsDateTime;

  end;
  if (Field.FieldName = 'LastInvoiceTime1') then
    MemTable.FieldByName('LastInvoiceDate').AsDateTime
      := MemTable.FieldByName('LastInvoiceDate1').AsDateTime + Field.AsDateTime;
end;

initialization
  DefFontData.Name := 'Microsoft Sans Serif';
end.
