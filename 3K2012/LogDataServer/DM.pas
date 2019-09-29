unit DM;

interface

uses
  SysUtils, Classes, DB, ADODB,windows;

type
  TDMFrm = class(TDataModule)
    ADOConn: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOSelect: TADOQuery;
    ADODel: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMFrm: TDMFrm;

implementation
uses LDShare,IniFiles,Grobal2,LogDataMain;
{$R *.dfm}

procedure TDMFrm.DataModuleCreate(Sender: TObject);
var
  Conf: TIniFile;
  Year, Month, Day: Word;
  LogFile:string;
begin
  Conf := TIniFile.Create('.\LogData.ini');
  if Conf <> nil then begin
    sBaseDir := Conf.ReadString('Setup', 'BaseDir', sBaseDir);
    Conf.Free;
  end;

  DecodeDate(Date, Year, Month, Day);

//目录不存在,则创建目录
  if not FileExists(sBaseDir) then CreateDirectoryA(PChar(sBaseDir), nil);

  LogFile :=sBaseDir + IntToStr(Year) + '-' + IntToString(Month) + '-' + IntToString(Day)+ '.mdb';

//日志文件不存在,则创建
  if not FileExists(LogFile) then begin
   if FrmLogData.CreateAccessFile(LogFile,'') then begin
      if not ADOconn.Connected then FrmLogData.ConnectedAccess(LogFile,''); //连接数据库
       with ADOQuery1 do  //创建数据表
         begin
          close;
          SQL.Clear;
          SQL.Add('Create Table Log (编号 Counter,动作 string,地图 string,X坐标 integer,Y坐标 integer,');
          SQL.Add('人物名称 string,物品名称  string,物品ID  string,记录  string,交易对像  string,时间 DateTime)');
          ExecSQL;
         end;
    end;
  end else if not ADOconn.Connected then FrmLogData.ConnectedAccess(LogFile,''); //连接数据库
end;

procedure TDMFrm.DataModuleDestroy(Sender: TObject);
begin
  ADOconn.Close ;
end;

end.
