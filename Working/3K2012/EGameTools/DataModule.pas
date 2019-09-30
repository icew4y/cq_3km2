unit DataModule;

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
