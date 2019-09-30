unit InterServerMsg;

interface

uses
  SysUtils, Classes, Controls, Forms,
  JSocket, ObjBase;

type
  TServerMsgInfo = record
    Socket: TCustomWinSocket;
    s2E0: string;
  end;
  pTServerMsgInfo = ^TServerMsgInfo;
  TFrmSrvMsg = class(TForm)
    MsgServer: TServerSocket;
    procedure MsgServerClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MsgServerClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure MsgServerClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure MsgServerClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    //PlayObject: TPlayObject;//20080815 ×¢ÊÍ
    SrvArray: array[0..9] of TServerMsgInfo;
    //procedure DecodeSocStr;//20080522 ×¢ÊÍ
    //procedure MsgGetUserServerChange;//20080522 ×¢ÊÍ
    procedure SendSocket(Socket: TCustomWinSocket; sMsg: string);
    { Private declarations }
  public
    constructor Create();
    destructor Destroy; override;
    procedure SendSocketMsg(sMsg: string);
    procedure StartMsgServer();
    //procedure Run();//20080815 ×¢ÊÍ
    { Public declarations }
  end;

var
  FrmSrvMsg: TFrmSrvMsg;

implementation

uses M2Share;

{$R *.dfm}

{ TFrmSrvMsg }
(*//20080815 ×¢ÊÍ
procedure TFrmSrvMsg.Run;
begin
{$IF (DEBUG = 0) and (SoftVersion <> VERDEMO)}
  if IsDebuggerPresent then Application.Terminate;
{$IFEND}
end; *)

procedure TFrmSrvMsg.StartMsgServer;
begin
  try
    MsgServer.Active := False;
    MsgServer.Address := g_Config.sMsgSrvAddr;
    MsgServer.Port := g_Config.nMsgSrvPort;
    MsgServer.Active := True;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TFrmSrvMsg::StartMsgServer %s',[g_sExceptionVer, E.Message]));
    end;
  end;
end;
(*//20080522 ×¢ÊÍ
procedure TFrmSrvMsg.DecodeSocStr;
//var
//  sData, SC, s10, s14, s18: string;
//  n1C, n20: Integer;
resourcestring
  sExceptionMsg = '{Òì³£} TFrmSrvMsg::DecodeSocStr';
begin
 { try
    if Pos(')', sRecvMsg) <= 0 then exit;
    sData := sRecvMsg;
    sRecvMsg := '';
    while (True) do begin
      sData := ArrestStringEx(sData, '(', ')', SC);
      if SC = '' then break;
      s14 := GetValidStr3(SC, s10, ['/']);
      s14 := GetValidStr3(s14, s18, ['/']);
      n1C := Str_ToInt(s10, 0);
      n20 := Str_ToInt(DeCodeString(s18), -1);
      case n1C of //
        SS_200: ;
        SS_201: ;
        SS_202: ;
        SS_WHISPER: ;
        SS_204: ;
        SS_205: ;
        SS_206: ;
        SS_207: ;
        SS_208: ;
        SS_209: ;
        SS_210: ;
        SS_211: ;
        SS_212: ;
        SS_213: ;
        SS_214: ;
      end;
      if Pos(')', sData) <= 0 then break;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;}
end;   

procedure TFrmSrvMsg.MsgGetUserServerChange;
begin

end; *)

procedure TFrmSrvMsg.SendSocket(Socket: TCustomWinSocket; sMsg: string);
begin
  if Socket.Connected then
    Socket.SendText('(' + sMsg + ')');
end;

procedure TFrmSrvMsg.SendSocketMsg(sMsg: string);
var
  I: Integer;
  ServerMsgInfo: pTServerMsgInfo;
begin
  for I := Low(SrvArray) to High(SrvArray) do begin
    ServerMsgInfo := @SrvArray[I];
    if ServerMsgInfo.Socket <> nil then
      SendSocket(ServerMsgInfo.Socket, sMsg);
  end;
end;

constructor TFrmSrvMsg.Create;
begin
  FillChar(SrvArray, SizeOf(SrvArray), 0);
  //PlayObject := TPlayObject.Create;//20080815 ×¢ÊÍ
end;

destructor TFrmSrvMsg.Destroy;
begin
  //PlayObject.Free;//20080815 ×¢ÊÍ
  inherited;
end;

procedure TFrmSrvMsg.MsgServerClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  ServerMsgInfo: pTServerMsgInfo;
begin
  for I := Low(SrvArray) to High(SrvArray) do begin
    ServerMsgInfo := @SrvArray[I];
    if ServerMsgInfo.Socket = nil then begin
      ServerMsgInfo.Socket := Socket;
      ServerMsgInfo.s2E0 := '';
      Socket.nIndex := I;
    end;
  end;
end;

procedure TFrmSrvMsg.MsgServerClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I: Integer;
  ServerMsgInfo: pTServerMsgInfo;
begin
  for I := Low(SrvArray) to High(SrvArray) do begin
    ServerMsgInfo := @SrvArray[I];
    if ServerMsgInfo.Socket = Socket then begin
      ServerMsgInfo.Socket := nil;
      ServerMsgInfo.s2E0 := '';
    end;
  end;
end;

procedure TFrmSrvMsg.MsgServerClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  Socket.Close;
  ErrorCode := 0;
end;

procedure TFrmSrvMsg.MsgServerClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  nC: Integer;
begin
  nC := Socket.nIndex;
  if nC >= Low(SrvArray) then begin//20081203 ·ÀÖ¹×éÊýÔ½½ç
    if (nC <= High(SrvArray)) and (SrvArray[nC].Socket = Socket) then begin
      SrvArray[nC].s2E0 := SrvArray[nC].s2E0 + Socket.ReceiveText;
    end;
  end;
end;

end.
