unit DM;

interface

uses
  SysUtils, Classes, DB, DBTables;

type
  TFrmDM = class(TDataModule)
    DataSourceMagic: TDataSource;
    TableMagic: TTable;
    TableMonster: TTable;
    DataSourceMonster: TDataSource;
    DataSourceStdItems: TDataSource;
    TableStdItems: TTable;
    Query1: TQuery;
    DataSourceFongHao: TDataSource;
    TableFongHao: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
   FrmDM: TFrmDM;

implementation

{$R *.dfm}

end.
