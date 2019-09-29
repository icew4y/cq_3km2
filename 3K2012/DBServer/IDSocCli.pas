unit IDSocCli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, JSocket, Grobal2, DBShare, IniFiles, Common;
type
  TFrmIDSoc = class(TForm)
    IDSocket: TClientSocket;//与账号服务器连接
    Timer1: TTimer;
    KeepAliveTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure IDSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure KeepAliveTimerTimer(Sender: TObject);
    procedure IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    m_sSockMsg: string; //0x2E4
    //sIDAddr: string;
    //nIDPort: Integer;
    procedure ProcessSocketMsg;
    procedure ProcessAddSession(sData: string);//增加会话
    procedure ProcessDelSession(sData: string);//删除会话
    procedure ProcessGetOnlineCount(sData: string);//取在线人数

    procedure SendKeepAlivePacket();
    { Private declarations }
  public
    procedure SendSocketMsg(wIdent: Word; sMsg: string);
    function CheckSession(sAccount, sIPaddr: string; nSessionID: Integer): Boolean;
    function CheckSessionSelChr(sChr, sAccount, sIPaddr: string; nSessionID: Integer): Boolean;
    function CheckSessionLoadRcd(sAccount, sIPaddr: string; nSessionID: Integer; var boFoundSession: Boolean): Boolean;
    function SetSessionSaveRcd(sAccount: string): Boolean;
    procedure SetGlobaSessionNoPlay(nSessionID: Integer);
    procedure SetGlobaSessionPlay(nSessionID: Integer);
    function GetGlobaSessionStatus(nSessionID: Integer): Boolean;
    procedure CloseSession(sAccount: string; nSessionID: Integer); //关闭全局会话
    procedure OpenConnect();//打开连接
    procedure CloseConnect();//关闭连接
    function GetSession(sAccount, sIPaddr: string): Boolean;//取对应的会话
    { Public declarations }
  end;

var
  FrmIDSoc: TFrmIDSoc;

implementation

uses HUtil32, UsrSoc;
{$R *.DFM}

procedure TFrmIDSoc.FormCreate(Sender: TObject);
//0x004A128C
//var
  //Conf: TIniFile;
begin
  { Conf := TIniFile.Create(sConfFileName);
   if Conf <> nil then begin
     sIDAddr := Conf.ReadString('Server', 'IDSAddr', sIDServerAddr);
     nIDPort := Conf.ReadInteger('Server', 'IDSPort', nIDServerPort);
     Conf.Free;
   end;  }
  g_GlobaSessionList := TList.Create;
  m_sSockMsg := '';
end;

procedure TFrmIDSoc.FormDestroy(Sender: TObject);
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  if g_GlobaSessionList.Count > 0 then begin//20090101
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then Dispose(GlobaSessionInfo);//20081223 修改
    end;
  end;
  g_GlobaSessionList.Free;
end;

procedure TFrmIDSoc.Timer1Timer(Sender: TObject);
begin
  if (IDSocket.Address <> '') and not (IDSocket.Active) then
    IDSocket.Active := True;
end;

procedure TFrmIDSoc.IDSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_sSockMsg := m_sSockMsg + Socket.ReceiveText;
  if Pos(')', m_sSockMsg) > 0 then begin
    ProcessSocketMsg();
  end;
end;
//接logsvr.exe消息进行处理
procedure TFrmIDSoc.ProcessSocketMsg();
var
  sScoketText: string;
  sData: string;
  sCode: string;
  sBody: string;
  nIdent: Integer;
begin
  sScoketText := m_sSockMsg;
  while (Pos(')', sScoketText) > 0) do begin
    sScoketText := ArrestStringEx(sScoketText, '(', ')', sData);
    if sData = '' then break;
    sBody := GetValidStr3(sData, sCode, ['/']);
    nIdent := Str_ToInt(sCode, 0);
    case nIdent of
      SS_OPENSESSION {100}: ProcessAddSession(sBody);//增加会话
      SS_CLOSESESSION {101}: ProcessDelSession(sBody);//删除会话
      SS_KEEPALIVE {104}: ProcessGetOnlineCount(sBody);//取在线人数
    end;
  end;
  m_sSockMsg := sScoketText;
  //MainOutMessage('服务器已启动...');
end;

procedure TFrmIDSoc.SendSocketMsg(wIdent: Word; sMsg: string);
var
  sSendText: string;
resourcestring
  sFormatMsg = '(%d/%s)';
begin
  sSendText := format(sFormatMsg, [wIdent, sMsg]);
  if IDSocket.Socket.Connected then
    IDSocket.Socket.SendText(sSendText);
end;

function TFrmIDSoc.CheckSession(sAccount, sIPaddr: string; nSessionID: Integer): Boolean;
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1001800;
  Result := False;
  if g_GlobaSessionList.Count > 0 then begin
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then begin
        if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.nSessionID = nSessionID) then begin
          Result := True;
          break;
        end;
      end;
    end;
  end;
  g_CheckCode.dwThread0 := 1001801;
end;

function TFrmIDSoc.CheckSessionSelChr(sChr, sAccount, sIPaddr: string; nSessionID: Integer): Boolean;
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1001800;
  Result := False;
  if g_GlobaSessionList.Count > 0 then begin
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then begin
        if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.nSessionID = nSessionID) then begin
          Result := True;
          GlobaSessionInfo.sSelChrName := sChr;
          break;
        end;
      end;
    end;
  end;
  if not Result then
    MainOutMessage(Format('CheckSessionSelChr Fail sChr:%s, sAccount:%s, sIPaddr:%s!!', [sChr, sAccount, sIPaddr]));

  g_CheckCode.dwThread0 := 1001801;
end;

function TFrmIDSoc.CheckSessionLoadRcd(sAccount, sIPaddr: string; nSessionID: Integer; var boFoundSession: Boolean): Boolean;
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1001900;
  Result := False;
  boFoundSession := False;
  if g_GlobaSessionList.Count > 0 then begin//20090101
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then begin
        if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.nSessionID = nSessionID) then begin
          boFoundSession := True;
          if not GlobaSessionInfo.boLoadRcd then begin
            GlobaSessionInfo.boLoadRcd := True;
            Result := True;
          end;
          break;
        end;
      end;
    end;
  end;
  g_CheckCode.dwThread0 := 1001901;
end;

function TFrmIDSoc.SetSessionSaveRcd(sAccount: string): Boolean;
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1002500;
  Result := False;
  if g_GlobaSessionList.Count > 0 then begin//20090101
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then begin
        if (GlobaSessionInfo.sAccount = sAccount) then begin
          GlobaSessionInfo.boLoadRcd := False;
          Result := True;
        end;
      end;
    end;
  end;
  g_CheckCode.dwThread0 := 1002501;
end;

procedure TFrmIDSoc.SetGlobaSessionNoPlay(nSessionID: Integer);
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1002300;
  if g_GlobaSessionList.Count > 0 then begin//20090101
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then begin
        if (GlobaSessionInfo.nSessionID = nSessionID) then begin
          GlobaSessionInfo.boStartPlay := False;
          break;
        end;
      end;
    end;
  end;
  g_CheckCode.dwThread0 := 1002301;
end;

procedure TFrmIDSoc.SetGlobaSessionPlay(nSessionID: Integer);
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1002400;
  if g_GlobaSessionList.Count > 0 then begin//20090101
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then begin
        if (GlobaSessionInfo.nSessionID = nSessionID) then begin
          GlobaSessionInfo.boStartPlay := True;
          break;
        end;
      end;
    end;
  end;
  g_CheckCode.dwThread0 := 1002401;
end;

function TFrmIDSoc.GetGlobaSessionStatus(nSessionID: Integer): Boolean;
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  Result := False;
  if g_GlobaSessionList.Count > 0 then begin//20090101
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then begin
        if (GlobaSessionInfo.nSessionID = nSessionID) then begin
          Result := GlobaSessionInfo.boStartPlay;
          break;
        end;
      end;
    end;
  end;
end;

procedure TFrmIDSoc.CloseSession(sAccount: string; nSessionID: Integer);
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  for i :=g_GlobaSessionList.Count - 1 downto 0 do begin
    if g_GlobaSessionList.Count <= 0 then Break;//20090101
    GlobaSessionInfo := g_GlobaSessionList.Items[i];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.nSessionID = nSessionID) then begin
        if GlobaSessionInfo.sAccount = sAccount then begin
          g_GlobaSessionList.Delete(i);
          Dispose(GlobaSessionInfo);
          break;
        end;
      end;
    end;
  end;
end;

procedure TFrmIDSoc.IDSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  IDSocketConnected := False;
  ID_sRemoteAddress := '';
  ID_nRemotePort := 0;
end;

procedure TFrmIDSoc.ProcessAddSession(sData: string);
var
  sAccount, s10, s14, s18, sIPaddr: string;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1001600;
  sData := GetValidStr3(sData, sAccount, ['/']);
  sData := GetValidStr3(sData, s10, ['/']);
  sData := GetValidStr3(sData, s14, ['/']);
  sData := GetValidStr3(sData, s18, ['/']);
  sData := GetValidStr3(sData, sIPaddr, ['/']);
  New(GlobaSessionInfo);
  GlobaSessionInfo.sAccount := sAccount;
  GlobaSessionInfo.sIPaddr := sIPaddr;
  GlobaSessionInfo.nSessionID := Str_ToInt(s10, 0);
  GlobaSessionInfo.n24 := Str_ToInt(s14, 0);
  GlobaSessionInfo.boStartPlay := False;
  GlobaSessionInfo.boLoadRcd := False;
  GlobaSessionInfo.dwAddTick := GetTickCount();
  GlobaSessionInfo.dAddDate := Now();
  g_GlobaSessionList.Add(GlobaSessionInfo);
  g_CheckCode.dwThread0 := 1001601;
  //MainOutMessage('增加ID: '+s10);
end;

procedure TFrmIDSoc.ProcessDelSession(sData: string);
var
  sAccount: string;
  i, nSessionID: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1001700;
  sData := GetValidStr3(sData, sAccount, ['/']);
  nSessionID := Str_ToInt(sData, 0);
  if g_boRandomCode then begin//20081231 改由Logsvr发来会话ID，不由M2发来
    //MainOutMessage('删除ID: '+IntToStr(nSessionID));
    if g_CheckCodePassList.Count > 0 then begin//20090101
      i := g_CheckCodePassList.IndexOf(Pointer(nSessionID));
      if (i >= 0) then g_CheckCodePassList.Delete(i);
    end;
  end;
  for i :=g_GlobaSessionList.Count - 1 downto 0 do begin
    if g_GlobaSessionList.Count <= 0 then Break;//20090101
    GlobaSessionInfo := g_GlobaSessionList.Items[i];
    if GlobaSessionInfo <> nil then begin
      if (GlobaSessionInfo.nSessionID = nSessionID) and (GlobaSessionInfo.sAccount = sAccount) then begin
        g_GlobaSessionList.Delete(i);
        Dispose(GlobaSessionInfo);
        break;
      end;
    end;
  end;
  g_CheckCode.dwThread0 := 1001701;
end;

procedure TFrmIDSoc.SendKeepAlivePacket;
begin
  if IDSocket.Socket.Connected then begin
    IDSocket.Socket.SendText('(' + IntToStr(SS_SERVERINFO) + '/' + sServerName + '/' + '99' + '/' + IntToStr(FrmUserSoc.GetUserCount) + ')');
  end;
end;

procedure TFrmIDSoc.CloseConnect;
begin
  KeepAliveTimer.Enabled := False;
  IDSocket.Active := False;
end;

function TFrmIDSoc.GetSession(sAccount, sIPaddr: string): Boolean;
var
  i: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  g_CheckCode.dwThread0 := 1002200;
  Result := False;
  if g_GlobaSessionList.Count > 0 then begin//20090101
    for i := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[i];
      if GlobaSessionInfo <> nil then begin
        if (GlobaSessionInfo.sAccount = sAccount) and (GlobaSessionInfo.sIPaddr = sIPaddr) then begin
          Result := True;
          break;
        end;
      end;
    end;
  end;
  g_CheckCode.dwThread0 := 1002201;
end;

procedure TFrmIDSoc.OpenConnect;
begin
  IDSocket.Active := False;
  IDSocket.Host := sIDServerAddr;
  IDSocket.Address := sIDServerAddr;
  IDSocket.Port := nIDServerPort;
  IDSocket.Active := True;
  KeepAliveTimer.Enabled := True;
end;

procedure TFrmIDSoc.KeepAliveTimerTimer(Sender: TObject);
begin
  SendKeepAlivePacket();
  dwKeepIDAliveTick := GetTickCount;
end;

procedure TFrmIDSoc.ProcessGetOnlineCount(sData: string);
begin

end;

procedure TFrmIDSoc.IDSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  IDSocketConnected := True;
  ID_sRemoteAddress := Socket.RemoteAddress;
  ID_nRemotePort := Socket.LocalPort;
  MainOutMessage('账号服务器连接成功...');
end;

procedure TFrmIDSoc.IDSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  IDSocketConnected := False;
  ID_sRemoteAddress := '';
  ID_nRemotePort := 0;
end;

end.
