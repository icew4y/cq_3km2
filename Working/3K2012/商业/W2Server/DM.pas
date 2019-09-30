unit DM;

interface

uses
  SysUtils, Classes, DB, ADODB, Forms;

type
  TFrmDm = class(TDataModule)
    ADOconn: TADOConnection;
    ADOQueryAddUser: TADOQuery;
    ADOQueryLogin: TADOQuery;
    ADOQuery1: TADOQuery;
    ADOConn2: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function ConnectedAccess(FileName:String): Boolean; //连接数据库
    function ConnectedAccess2: Boolean;
  end;

var
  FrmDm: TFrmDm;

implementation
uses EDCode, Main, Share;
{$R *.dfm}

{ TFrmDm }

function TFrmDm.ConnectedAccess(FileName:String): Boolean;
var
  Server,UserID,Password1,Database:string;
begin
  Server:= g_sSqlConnect;
  UserID:= DeCodeString('NPYAQ`aL'){'IGEVIP'};  //用户登录名称
  PassWord1:= DeCodeString('NPYAQ`aL'){'IGEVIP'}; //登录密码 20090206
  Database:= DeCodeString('XsA[IOUiHcUeX<'){'sq_56m2vip'};//数据库

  ADOConn.Close ;
  ADOConn.Connected :=False;
  ADOConn.ConnectionString :='';
  ADOConn.ConnectionString :='Provider=SQLOLEDB.1;Password='+Trim(PassWord1)+'; '+
                            'Persist Security Info=True;'+
                            'User ID='+Trim(UserID)+';Initial Catalog='+trim(Database)+';'+
                            'Data Source='+Server;
  Adoconn.CommandTimeout :=15;
  Adoconn.ConnectionTimeout :=15;
  try
    ADOConn.Connected :=True;
  except
    on E: Exception do begin
      ADOConn.Connected :=False;
      FrmMain.MainOutMessage('ConnectedAccess');
      FrmMain.MainOutMessage(E.Message);
    end;
  end;
  if ADOconn.Connected then
    Result := True
  else Result := False;
end;

function TFrmDm.ConnectedAccess2: Boolean;
var
  Server,UserID,Password1,Database:string;
begin
  Server:= g_sSqlConnect;
  UserID:= DeCodeString('NPYAQ`aL'){'IGEVIP'};  //用户登录名称
  PassWord1:= DeCodeString('NPYAQ`aL'){'IGEVIP'}; //登录密码 20090206
  Database:= DeCodeString('XsA[IOUiHcUeX<'){'sq_56m2vip'};//数据库


  ADOConn2.Close ;
  ADOConn2.Connected :=False;
  ADOConn2.ConnectionString :='';
  ADOConn2.ConnectionString :='Provider=SQLOLEDB.1;Password='+Trim(PassWord1)+'; '+
                            'Persist Security Info=True;'+
                            'User ID='+Trim(UserID)+';Initial Catalog='+trim(Database)+';'+
                            'Data Source='+Server;
   Adoconn2.CommandTimeout :=15;
   Adoconn2.ConnectionTimeout :=15;
  try
    ADOConn2.Connected :=True;
  except
    on E: Exception do begin
      ADOConn2.Connected :=False;
      FrmMain.MainOutMessage('DataModuleCreate');
      FrmMain.MainOutMessage(E.Message);
    end;
  end;
  if ADOconn2.Connected then
    Result := True
  else Result := False;  
end;

procedure TFrmDm.DataModuleCreate(Sender: TObject);
begin
 // ConnectedAccess2;
end;

end.
