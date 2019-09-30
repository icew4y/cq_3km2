{*******************************************************}
{                                                       }
{                      EhLib v5.0                       }
{                    (Build 5.0.00)                     }
{                                                       }
{                  TfEditDBXConn form                   }
{                                                       }
{        Copyright (c) 2008 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit SQLConnEdEh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ValEdit, Mask, DBCtrlsEh,
  DB, SqlExpr, DBConnAdmin, IniFiles
{$IFDEF EH_LIB_9}
, WideStrings
{$ENDIF}
;

type
  TfEditDBXConn = class(TForm)
    SQLConnection1: TSQLConnection;
    ValueListEditor1: TValueListEditor;
    cbConnectionName: TDBComboBoxEh;
    StaticText1: TStaticText;
    cbDriverName: TDBComboBoxEh;
    StaticText2: TStaticText;
    cbLibraryName: TDBComboBoxEh;
    StaticText3: TStaticText;
    cbVendorLib: TDBComboBoxEh;
    StaticText4: TStaticText;
    bbConnect: TBitBtn;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cbConnectionNameChange(Sender: TObject);
    procedure cbDriverNameChange(Sender: TObject);
    procedure bbConnectClick(Sender: TObject);
    procedure cbLibraryNameChange(Sender: TObject);
    procedure cbVendorLibChange(Sender: TObject);
    procedure ValueListEditor1SetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
  private
    { Private declarations }
  public
    ConnectionAdmin: IConnectionAdmin;
    Regeting: Boolean;
    procedure RegetProperties;
    procedure AssignFromConnection(ASQLConnection1: TSQLConnection);
    procedure AssignToConnection(ASQLConnection1: TSQLConnection);
    { Public declarations }
  end;

var
  fEditDBXConn: TfEditDBXConn;

function EditSQLConnection(ASQLConnection1: TSQLConnection): Boolean;

implementation

{$R *.dfm}

uses SqlConst;

function EditSQLConnection(ASQLConnection1: TSQLConnection): Boolean;
var
  f: TfEditDBXConn;
begin
  Result := False;
  f := TfEditDBXConn.Create(Application);
  f.AssignFromConnection(ASQLConnection1);
  if f.ShowModal = mrOk then
  begin
    f.AssignToConnection(ASQLConnection1);
    Result := True;
  end;
end;

procedure TfEditDBXConn.AssignFromConnection(ASQLConnection1: TSQLConnection);
begin
  SQLConnection1.Close;
  SQLConnection1.ConnectionName := ASQLConnection1.ConnectionName;
  SQLConnection1.DriverName := ASQLConnection1.DriverName;

  SQLConnection1.VendorLib := ASQLConnection1.VendorLib;
  SQLConnection1.LibraryName := ASQLConnection1.LibraryName;
  SQLConnection1.GetDriverFunc := ASQLConnection1.GetDriverFunc;

  SQLConnection1.Params := ASQLConnection1.Params;
  RegetProperties;
end;

procedure TfEditDBXConn.AssignToConnection(ASQLConnection1: TSQLConnection);
begin
  ASQLConnection1.Close;
  ASQLConnection1.ConnectionName := SQLConnection1.ConnectionName;
  ASQLConnection1.DriverName := SQLConnection1.DriverName;

  ASQLConnection1.VendorLib := SQLConnection1.VendorLib;
  ASQLConnection1.LibraryName := SQLConnection1.LibraryName;
  ASQLConnection1.GetDriverFunc := SQLConnection1.GetDriverFunc;

  ASQLConnection1.Params := SQLConnection1.Params;
end;

procedure TfEditDBXConn.FormCreate(Sender: TObject);
begin
  ConnectionAdmin := GetConnectionAdmin;
  ConnectionAdmin.GetConnectionNames(cbConnectionName.Items, '');
  ConnectionAdmin.GetDriverNames(cbDriverName.Items);
end;

procedure TfEditDBXConn.RegetProperties;
begin
  if Regeting then Exit;
  Regeting := True;
  try
    cbConnectionName.Text := SQLConnection1.ConnectionName;
    cbDriverName.Text := SQLConnection1.DriverName;
    cbLibraryName.Text := SQLConnection1.LibraryName;
    cbVendorLib.Text := SQLConnection1.VendorLib;
    ValueListEditor1.Strings.CommaText := SQLConnection1.Params.CommaText;
//    bbConnect.Enabled := not SQLConnection1.Connected;
//    bbDisconnect.Enabled := SQLConnection1.Connected;
  finally
  Regeting := False;
  end;
end;

function GetProfileString(Section, Setting, IniFileName: string): string;
var
  IniFile: TMemIniFile;
  List: TStrings;
begin
  List := TStringList.Create;
  try
    IniFile := TMemIniFile.Create(IniFileName);
    IniFile.ReadSectionValues(Section, List);
    try
      Result := List.Values[ Setting ];
    finally
      IniFile.Free;
    end;
  finally
    List.Free;
  end;
end;

procedure TfEditDBXConn.cbConnectionNameChange(Sender: TObject);
var
  NewDriver, AConnectionName: string;
begin
  if Regeting then Exit;
  SQLConnection1.ConnectionName := cbConnectionName.Text;

  if SQLConnection1.ConnectionName <> '' then
  begin
    AConnectionName := SQLConnection1.ConnectionName;
    NewDriver := GetProfileString(AConnectionName, DRIVERNAME_KEY, GetConnectionRegistryFile(True));
    if NewDriver <> SQLConnection1.DriverName then
      cbDriverName.Text := NewDriver;
    SQLConnection1.LoadParamsFromIniFile;
  end;

  RegetProperties;
end;

procedure TfEditDBXConn.cbDriverNameChange(Sender: TObject);
begin
  if Regeting then Exit;

  SQLConnection1.DriverName := cbDriverName.Text;

  SQLConnection1.Params.Clear;
  SQLConnection1.ParamsLoaded := False;
  if SQLConnection1.DriverName <> '' then
  begin
//    try
      SQLConnection1.VendorLib := GetProfileString(SQLConnection1.DriverName, VENDORLIB_KEY, GetDriverRegistryFile(True));
      SQLConnection1.LibraryName := GetProfileString(SQLConnection1.DriverName, DLLLIB_KEY, GetDriverRegistryFile(True));
      SQLConnection1.GetDriverFunc := GetProfileString(SQLConnection1.DriverName, GETDRIVERFUNC_KEY, GetDriverRegistryFile(True));
//      if SQLConnection1.ConnectionName = '' then
//        SQLConnection1.LoadDriverParams;
//    except
//      DatabaseErrorFmt(SDriverNotInConfigFile, [cbDriverName.Text, GetDriverRegistryFile(True)]);
//    end;
  end;

  RegetProperties;
end;

procedure TfEditDBXConn.bbConnectClick(Sender: TObject);
begin
  SQLConnection1.Open;
  ShowMessage('Test connection - OK.');
  SQLConnection1.Close;
  RegetProperties;
end;

procedure TfEditDBXConn.cbLibraryNameChange(Sender: TObject);
begin
  SQLConnection1.LibraryName := cbLibraryName.Text;
end;

procedure TfEditDBXConn.cbVendorLibChange(Sender: TObject);
begin
  SQLConnection1.VendorLib := cbVendorLib.Text;
end;

procedure TfEditDBXConn.ValueListEditor1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  if Regeting then Exit;
  SQLConnection1.Params.CommaText := ValueListEditor1.Strings.CommaText;
end;

end.
