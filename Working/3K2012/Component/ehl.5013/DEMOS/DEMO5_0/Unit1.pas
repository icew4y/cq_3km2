unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_7} XPMan, {$ENDIF}
  Dialogs, StdCtrls, ExtCtrls, GridsEh, DBGridEh, DB, DBTables, Buttons,
  MemTableDataEh, MemTableEh, DataDriverEh, DBCtrls, Mask, DBCtrlsEh,
  ComCtrls, EhLibMTE;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGridEh1: TDBGridEh;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    DBGridEh2: TDBGridEh;
    TabSheet4: TTabSheet;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    DBEditEh3: TDBEditEh;
    DBEditEh4: TDBEditEh;
    DBEditEh6: TDBEditEh;
    DBEditEh7: TDBEditEh;
    TabSheet2: TTabSheet;
    DBGridEh3: TDBGridEh;
    PageControl3: TPageControl;
    TabSheet5: TTabSheet;
    DBImage1: TDBImage;
    TabSheet6: TTabSheet;
    DBMemo1: TDBMemo;
    TabSheet7: TTabSheet;
    DBGridEh4: TDBGridEh;
    TabSheet8: TTabSheet;
    DBGridEh5: TDBGridEh;
    DBNavigator1: TDBNavigator;
    DataSource1: TDataSource;
    Table1: TTable;
    dsdTable1: TDataSetDriverEh;
    mtTable1: TMemTableEh;
    MemTableEh1: TMemTableEh;
    DataSetDriverEh1: TDataSetDriverEh;
    Table2: TTable;
    DataSource2: TDataSource;
    dsBioLife: TDataSource;
    Table3: TTable;
    ddrBioLife: TDataSetDriverEh;
    mtBioLife: TMemTableEh;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    procedure DBGridEh1Enter(Sender: TObject);
    procedure DBGridEh1Exit(Sender: TObject);
    procedure DBGridEh1RowDetailPanelShow(Sender: TCustomDBGridEh;
      var CanShow: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure dsdTable1AssignFieldValue(DataDriver: TDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
      DataFieldIndex: Integer; DataValueVersion: TDataValueVersionEh;
      ReaderDataSet: TDataSet);
    procedure DBGridEh1Columns3EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    InGrid1, InGrid2: TDBGridEh;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DBGridEh1Enter(Sender: TObject);
begin
  DBNavigator1.DataSource := TDBGridEh(Sender).DataSource;
  if InGrid1 <> nil
    then InGrid2 := TDBGridEh(Sender)
    else InGrid1 := TDBGridEh(Sender);
end;

procedure TForm1.DBGridEh1Exit(Sender: TObject);
begin
  if InGrid2 <> nil then
  begin
    DBNavigator1.DataSource := InGrid1.DataSource;
    InGrid2 := nil;
  end else
    InGrid1 := nil;
end;

procedure TForm1.DBGridEh1RowDetailPanelShow(Sender: TCustomDBGridEh;
  var CanShow: Boolean);
begin
  if PageControl2.ActivePageIndex = 0
   then Sender.RowDetailPanel.ActiveControl := DBGridEh2
   else Sender.RowDetailPanel.ActiveControl := DBEditEh1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGridEhDefaultStyle.IsDrawFocusRect := False;
end;

procedure TForm1.dsdTable1AssignFieldValue(DataDriver: TDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
  DataFieldIndex: Integer; DataValueVersion: TDataValueVersionEh;
  ReaderDataSet: TDataSet);
var
  Field: TField;
  DateTime: TDateTime;
begin
  if MemTableData.DataStruct[DataFieldIndex].FieldName = 'LastInvoiceDate' then
  begin
    Field := ReaderDataSet.FindField(MemRec.DataStruct[DataFieldIndex].FieldName);
    if Field <> nil then
    begin
      DateTime := Trunc(Field.Value);
      MemRec.Value[DataFieldIndex, DataValueVersion] := DateTime;
    end;
  end else
    DataDriver.DefaultAssignFieldValue(MemTableData, MemRec, DataFieldIndex,
      DataValueVersion, ReaderDataSet);
end;

procedure TForm1.DBGridEh1Columns3EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
begin
  ShowMessage('Ellipsis button clicked');
end;

end.
