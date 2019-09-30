unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF EH_LIB_7} XPMan, {$ENDIF}
  DBTables, DataDriverEh, Db, MemTableEh, DBGridEh, ExtCtrls,
  DBCtrls, MemTableDataEh, StdCtrls, DBClient, EhLibMTE, GridsEh;

type
  TForm1 = class(TForm)
    MemTableEh1: TMemTableEh;
    DataSetDriverEh1: TDataSetDriverEh;
    Table1: TTable;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    MemTableEh1ExpCount: TAggregateField;
    ClientDataSet1: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Table1.DatabaseName := ExtractFileDir(ParamStr(0));
  MemTableEh1.TreeList.Active := True;
  MemTableEh1.TreeList.KeyFieldName := 'ID';
  MemTableEh1.TreeList.RefParentFieldName := 'ID_PARENT';
  MemTableEh1.TreeList.DefaultNodeExpanded := True;
  MemTableEh1.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  MemTableEh1.TreeList.Active := not MemTableEh1.TreeList.Active;
//  MemTableEh1.CancelUpdates;
//  MemTableEh1.Locate('ID', 25,[]);
end;

initialization
  DBGridEhCenter.FilterEditCloseUpApplyFilter := True;
  DefFontData.Name := 'Microsoft Sans Serif';
end.
