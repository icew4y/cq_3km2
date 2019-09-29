unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_7} XPMan, {$ENDIF}
  Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, ADODB, DataDriverEh, ExtCtrls, GridsEh, DBGridEh,
  MemTableEh, ADODataDriverEh;

type
  TForm1 = class(TForm)
    MasterTBL: TADOTable;
    DetailMemTBL: TMemTableEh;
    DBGridEh1: TDBGridEh;
    Splitter1: TSplitter;
    DBGridEh2: TDBGridEh;
    MasterDS: TDataSource;
    DetailDS: TDataSource;
    DetailDataDrv: TADODataDriverEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

initialization
  DefFontData.Name := 'Microsoft Sans Serif';
end.
