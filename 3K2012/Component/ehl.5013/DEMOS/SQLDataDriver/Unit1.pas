unit Unit1;

{$I EHLIB.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, IBDatabase, DataDriverEh, StdCtrls, ExtCtrls, DBTables,
  DBGridEh, MemTableEh, BDEDataDriverEh, IBXDataDriverEh, MemTableDataEh,
{$IFDEF EH_LIB_6}
  DBXDataDriverEh, DBXpress, SqlExpr,
{$ENDIF}
  Mask, DBCtrlsEh, GridsEh;

type
  TForm1 = class(TForm)
    RadioGroup1: TRadioGroup;
    Memo1: TMemo;
    Button1: TButton;
    SQLDataDriverEh1: TSQLDataDriverEh;
    IBDatabase1: TIBDatabase;
    Database1: TDatabase;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    IBTransaction1: TIBTransaction;
    DBEditEh1: TDBEditEh;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBEditEh1EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
  private
    { Private declarations }
  public
{$IFDEF EH_LIB_6}
    SQLConnection1: TSQLConnection;
{$ENDIF}
    function OnExecuteSQLCommand(SQLDataDriver: TCustomSQLDataDriverEh;
      Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean): Integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  DefaultSQLDataDriverResolver.OnExecuteCommand := OnExecuteSQLCommand;

{$IFDEF EH_LIB_6}
  SQLConnection1 := TSQLConnection.Create(Self);
  with SQLConnection1 do
  begin
    Name := 'SQLConnection1';
    DriverName := 'Interbase';
    GetDriverFunc := 'getSQLDriverINTERBASE';
    LibraryName := 'dbexpint.dll';
    LoginPrompt := False;
    Params.Add('BlobSize=-1');
    Params.Add('CommitRetain=False');
    Params.Add('Database=country.gdb');
    Params.Add('ErrorResourceFile=');
    Params.Add('LocaleCode=0000');
    Params.Add('Password=masterkey');
    Params.Add('RoleName=RoleName');
    Params.Add('ServerCharSet=');
    Params.Add('SQLDialect=1');
    Params.Add('Interbase TransIsolation=ReadCommited');
    Params.Add('User_Name=sysdba');
    Params.Add('WaitOnLocks=True');
    VendorLib := 'GDS32.DLL';
    Left := 82;
    Top := 220;
  end;
{$ENDIF}

end;

function TForm1.OnExecuteSQLCommand(SQLDataDriver: TCustomSQLDataDriverEh;
  Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof,
  Processed: Boolean): Integer;
begin
  Result := 0;
  case  RadioGroup1.ItemIndex of
    0:
      Result := DefaultExecuteBDECommandEh(SQLDataDriver, Command,
        Cursor, FreeOnEof, Processed, Database1.DatabaseName);
{$IFDEF EH_LIB_6}
    1:
      Result := DefaultExecuteDBXCommandEh(SQLDataDriver, Command,
        Cursor, FreeOnEof, Processed, SQLConnection1);
{$ENDIF}
    2:
      Result := DefaultExecuteIBXCommandEh(SQLDataDriver, Command,
        Cursor, FreeOnEof, Processed, IBDatabase1);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SQLDataDriverEh1.SelectSQL := Memo1.Lines;
  MemTableEh1.Close;
  MemTableEh1.Open;
end;

procedure TForm1.DBEditEh1EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
begin
  if OpenDialog1.Execute then
    DBEditEh1.Text := OpenDialog1.FileName;
end;

initialization
  DefFontData.Name := 'Microsoft Sans Serif';
end.
