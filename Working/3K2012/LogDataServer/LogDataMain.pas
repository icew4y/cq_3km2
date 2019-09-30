unit LogDataMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, IniFiles, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdSocketHandle, Menus, DB, ADODB;
type
  TFrmLogData = class(TForm)
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    IdUDPServerLog: TIdUDPServer;
    StartTimer: TTimer;
    MainMenu1: TMainMenu;
    V1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    A1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure WriteLogFile();
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure StartTimerTimer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IdUDPServerLogUDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
  private
    LogMsgList: TStringList;
    m_boRemoteClose: Boolean;
    { Private declarations }
   //写入数据
  procedure WriteAccess(FileName,s0, s1, s2, s3, s4, s5, s6, s7, s8, s10: String);
  public
   //建立Access文件，如果文件存在则失败
    function CreateAccessFile(FileName:String;PassWord:string=''):boolean;
    //连接数据库
    procedure ConnectedAccess(FileName:String;PassWord:string='');
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
   //判断表是否存在(用异常判断)
   function TableExists(log:string):Boolean;  
    { Public declarations }
  end;

var
  FrmLogData: TFrmLogData;
  sLogFile: String;
  boBusy: Boolean = false;//20080928 增加判断TTimer 是否重入
  boIsRaedLog: Boolean = false;//20080928 是否在接收日志
//声明连接字符串
Const
SConnectionString = 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;'
                  +'Jet OLEDB:Database Password=%s;';
implementation

uses LDShare, Grobal2, HUtil32,ComObj,ActiveX,LogSelect,DM,About;

{$R *.DFM}
//-----------------------------MDB数据库操作-----------------------------------
//连接数据库
procedure TFrmLogData.ConnectedAccess(FileName:String;PassWord:string='');
begin
with DMFrm.ADOconn do
 begin
  ConnectionString:=format(SConnectionString,[FileName,PassWord]);
  connected:=true;
 end;
end;

//写入数据
procedure TFrmLogData.WriteAccess(FileName,s0, s1, s2, s3, s4, s5, s6, s7, s8, s10: String);
var Str2:string;
begin
  try
    Str2:=s0;
    if not DMFrm.ADOconn.Connected then ConnectedAccess(FileName,'');
    case strtoint(s0) of
      0:Str2:='取回物品';//取回物品
      1:Str2:='存放物品';//存放物品
      2:Str2:='炼制药品';//炼制药品
      3:Str2:='持久消失';//持久消失
      4:Str2:='捡起物品';//捡起物品
      5:Str2:='制造物品';//制造物品
      6:Str2:='毁掉物品';//毁掉物品
      7:Str2:='扔掉物品';//扔掉物品
      8:Str2:='交易物品';//交易物品
      9:Str2:='购买物品'; //购买物品
      10:Str2:='出售物品';//出售物品
      11:Str2:='使用物品';//使用物品
      12:Str2:='人物升级';//人物升级
      13:Str2:='减少金币';//减少金币
      14:Str2:='增加金币';//增加金币
      15:Str2:='死亡掉落';//死亡掉落
      16:Str2:='掉落物品';//掉落物品
      17:Str2:='等级调整';//等级调整
      18:Str2:='无效代码';//无效代码
      19:Str2:='人物死亡';//人物死亡
      20:Str2:='升级成功';//升级成功
      21:Str2:='升级失败';//升级失败
      22:Str2:='城堡取钱';//城堡取钱
      23:Str2:='城堡存钱';//城堡存钱
      24:Str2:='升级取回';//升级取回
      25:Str2:='武器升级';//武器升级
      26:Str2:='背包减少';//背包减少
      27:Str2:='改变城主';//改变城主
      111:Str2:='元宝改变';//元宝改变
      29:Str2:='能量改变';//能量改变
      30:Str2:='商铺购买';//商铺购买
      31:Str2:='装备升级';//装备升级
      32:Str2:='寄售物品';//寄售物品
      33:Str2:='寄售购买';//寄售购买
      34:Str2:='个人商店';//个人商店
      35:Str2:='行会酒泉';//行会酒泉
      36:Str2:='挑战物品';//挑战物品
      37:Str2:='挖人形怪';//挖人形怪
      38:Str2:='NPC 酿酒';//NPC 酿酒
      39:Str2:='获得矿石';//获得矿石
      40:Str2:='开启宝箱';
      41:Str2:='粹练物品';
      42:Str2:='拆分物品';
      43:Str2:='合并物品';
      44:Str2:='锻炼物品';
      45:Str2:='高级鉴定';
      46:Str2:='挖取宝物';
      112:Str2:='游戏点改变';
      113:Str2:='金刚石改变';
      114:Str2:='灵符改变';
      116:Str2:='荣誉改变';
    end;

    with DMFrm.ADOQuery1 do begin
      close;
      SQL.Clear;
      SQL.Add('Insert Into Log (动作,地图,X坐标,Y坐标,');
      SQL.Add('人物名称,物品名称,物品ID,记录,交易对像,时间)');
      SQL.Add('  Values(:a0,:a1,:a2,:a3,:a4,:a5,:a6,:a7,:a8,:a9)');
      parameters.ParamByName('a0').DataType:=Ftstring;
      parameters.ParamByName('a0').Value :=Trim(Str2);
      parameters.ParamByName('a1').DataType :=Ftstring;
      parameters.ParamByName('a1').Value :=Trim(s1);
      parameters.ParamByName('a2').DataType:=Ftinteger;
      parameters.ParamByName('a2').Value :=strToint(Trim(s2));
      parameters.ParamByName('a3').DataType :=Ftinteger;
      parameters.ParamByName('a3').Value :=strToint(Trim(s3));
      parameters.ParamByName('a4').DataType :=Ftstring;
      parameters.ParamByName('a4').Value :=Trim(s4);
      parameters.ParamByName('a5').DataType :=Ftstring;
      parameters.ParamByName('a5').Value :=Trim(s5);
      parameters.ParamByName('a6').DataType :=Ftstring;
      parameters.ParamByName('a6').Value :=Trim(s6);
      parameters.ParamByName('a7').DataType :=Ftstring;
      parameters.ParamByName('a7').Value :=Trim(s7);
      parameters.ParamByName('a8').DataType :=Ftstring;
      parameters.ParamByName('a8').Value :=Trim(s8);
      //parameters.ParamByName('a9').DataType :=Ftdate;
      //parameters.ParamByName('a9').Value :=now();
      parameters.ParamByName('a9').DataType :=Ftstring;
      parameters.ParamByName('a9').Value :=Trim(s10);
      ExecSQL;
    end;
  except
  end;
end;

//判断表是否存在(用异常判断)
function TFrmLogData.TableExists(log:string):Boolean;
begin
  Result:=False;
  try
   with DMFrm.ADOQuery1 do
     begin
      close;
      SQL.Clear;
      SQL.Add('select top 1 动作 from '+log);
      open;
      Result:=True;
     end;
  except
    Result:=False;
  end;
end;

function GetTempPathFileName():string;
//取得临时文件名
var
  SPath,SFile:array [0..254] of char;
begin
  GetTempPath(254,SPath);
  GetTempFileName(SPath,'~SM',0,SFile);
  result:=SFile;
  DeleteFile(PChar(result));
end;

//建立Access文件，如果文件存在则失败
function TFrmLogData.CreateAccessFile(FileName:String;PassWord:string=''):boolean;
var
  STempFileName:string;
  vCatalog:OleVariant;
begin
  STempFileName:=GetTempPathFileName;
  try
    vCatalog:=CreateOleObject('ADOX.Catalog');
    vCatalog.Create(format(SConnectionString,[STempFileName,PassWord]));
    result:=CopyFile(PChar(STempFileName),PChar(FileName),True);
    DeleteFile(STempFileName);
  except
    result:=false;
  end;
end;

//--------------------------------------------------------------------------

procedure TFrmLogData.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
begin
  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  nX := Str_ToInt(ParamStr(2), -1);
  nY := Str_ToInt(ParamStr(3), -1);
  if (nX >= 0) or (nY >= 0) then begin
    Left := nX;
    Top := nY;
  end;

  m_boRemoteClose := False;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  SendGameCenterMsg(SG_STARTNOW, '正在启动日志服务器...');
  LogMsgList := TStringList.Create;
  StartTimer.Enabled := True;
end;

procedure TFrmLogData.FormDestroy(Sender: TObject);
begin
  LogMsgList.Free;
end;

procedure TFrmLogData.IdUDPServerLogUDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var
  LogStr: String;
begin
  try
    boIsRaedLog:= True;
    SetLength(LogStr, AData.Size);
    AData.Read(LogStr[1], AData.Size);
    LogMsgList.Add(LogStr+ '	'+DateTimeToStr(Now));
    boIsRaedLog:= False;
  except
    boIsRaedLog:= False;
  end;
end;

procedure TFrmLogData.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if m_boRemoteClose then exit;
  if Application.MessageBox('是否确认退出服务器？',
    '提示信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
  end else CanClose := False;
end;

procedure TFrmLogData.Timer1Timer(Sender: TObject);
begin
  if boBusy then Exit;
  boBusy:= True;
  try
    WriteLogFile();
  finally
    boBusy:= False;
  end;
end;


procedure TFrmLogData.WriteLogFile();
var
  I: Integer;
  Year, Month, Day: Word;
  S10,s0, s1, s2, s3, s4, s5, s6, s7, s8, sA,sB,sC: String;
begin
try
  DecodeDate(Date, Year, Month, Day);

//目录不存在,则创建目录
  if not FileExists(sBaseDir) then CreateDirectoryA(PChar(sBaseDir), nil);

  sLogFile :=sBaseDir + IntToStr(Year) + '-' + IntToString(Month) + '-' + IntToString(Day)+ '.mdb';
  Label4.Caption := sLogFile;

  //日志文件不存在,则创建
  if not FileExists(sLogFile) then begin
    DMFrm.ADOconn.Connected:=False;
    CreateAccessFile(sLogFile,'');
  end;
  //如果没有连接数据库,则连接数据库
  if not DMFrm.ADOconn.Connected then ConnectedAccess(sLogFile,''); //连接数据库

//日志文件存在
  if FileExists(sLogFile) then begin
   if (not TableExists('Log')) then begin //表不存在,则创建表
     with DMFrm.ADOQuery1 do begin //创建数据表
       close;
       SQL.Clear;
       SQL.Add('Create Table Log (编号 Counter,动作 string,地图 string,X坐标 integer,Y坐标 integer,');
       SQL.Add('人物名称 string,物品名称  string,物品ID  string,记录  string,交易对像  string,时间 DateTime)');
       ExecSQL;
     end;
   end else begin //写入数据
     for I := LogMsgList.Count - 1 downto 0 do begin //处理数据
       if (LogMsgList.Count <= 0) or boIsRaedLog then Break;
       s10 := LogMsgList.Strings[I];
       if (s10 <> '') then begin
          s0:='';
          s1:='';
          s2:='';
          s3:='';
          s4:='';
          s5:='';
          s6:='';
          s7:='';
          s8:='';
          s10 := GetValidStr3(s10, sA, ['	']);
          s10 := GetValidStr3(s10, sB, ['	']);
          s10 := GetValidStr3(s10, sC, ['	']);
          s10 := GetValidStr3(s10, s0, ['	']);
          s10 := GetValidStr3(s10, s1, ['	']);
          s10 := GetValidStr3(s10, s2, ['	']);
          s10 := GetValidStr3(s10, s3, ['	']);
          s10 := GetValidStr3(s10, s4, ['	']);
          s10 := GetValidStr3(s10, s5, ['	']);
          s10 := GetValidStr3(s10, s6, ['	']);
          s10 := GetValidStr3(s10, s7, ['	']);
          s10 := GetValidStr3(s10, s8, ['	']);
          if (S0<>'') and  (s1 <> '') and (s2 <> '') and (s3 <> '') and
             (S4<>'') and  (s5 <> '') and (s6 <> '') and (s7 <> '') and
             (s8 <> '') then begin
              if boIsRaedLog then Break;
             //写入数据表
              WriteAccess(sLogFile, s0, s1, s2, s3, s4, s5, s6, s7, s8, s10);
              LogMsgList.Delete(I);//20080928 修改
             end;
       end;
     end;
     //LogMsgList.Clear;//20080928 注释
    end;
  end;
  except
    
  end;
end;


procedure TFrmLogData.MyMessage(var MsgData: TWmCopyData);
var
  sData: String;
  //ProgramType: TProgamType;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  //  ProgramType:=TProgamType(LoWord(MsgData.From));
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of //
    GS_QUIT: begin
        m_boRemoteClose := True;
        Close();
      end;
    1: ;
    2: ;
    3: ;
  end; // case
end;

procedure TFrmLogData.StartTimerTimer(Sender: TObject);
var
  Conf: TIniFile;
  boMinimize: Boolean;
begin
  boMinimize:= False;
  StartTimer.Enabled := False;
  Conf := TIniFile.Create('.\LogData.ini');
  if Conf <> nil then begin
    sBaseDir := Conf.ReadString('Setup', 'BaseDir', sBaseDir);
    sServerName := Conf.ReadString('Setup', 'Caption', sServerName);
    sServerName := Conf.ReadString('Setup', 'ServerName', sServerName);
    nServerPort := Conf.ReadInteger('Setup', 'Port', nServerPort);
    boMinimize := Conf.ReadBool('Setup', 'Minimize', True);
    Conf.Free;
  end;
  Caption := sCaption + ' (' + sServerName + ')';
  IdUDPServerLog.DefaultPort := nServerPort;
  try
    IdUDPServerLog.Active := True;
  except
    Application.MessageBox(PChar(IntToStr(nServerPort)+'端口被占用。'), '提示', MB_OK + MB_ICONSTOP);
  end;
  if boMinimize then Application.Minimize;//最小化窗口
  SendGameCenterMsg(SG_STARTOK, '日志服务器启动完成...');
end;

procedure TFrmLogData.N1Click(Sender: TObject);
begin
  if not Assigned(LogFrm) then begin
    try
      LogFrm := TLogFrm.Create(Owner);
      LogFrm.ShowModal;
    finally
      LogFrm.Free;
    end;
  end;
end;

procedure TFrmLogData.A1Click(Sender: TObject);
begin
  AboutFrm := TAboutFrm.Create(Owner);
  AboutFrm.Open();
  AboutFrm.Free;
end;

procedure TFrmLogData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Application.Terminate;
end;

end.

