unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket, ExtCtrls, fsShare, WilRead;

const
  MaxConnectCount = 1024;
type
  TConnect = record
    Socket: TCustomWinSocket;
    DataBuf : string;
    boCheckPass : Boolean;//是否通过验证
  end;
  pTConnect = ^TConnect;
  TFrmMain = class(TForm)
    ServerSocket1: TServerSocket;
    TimerProcData: TTimer;
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1Listen(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1Accept(Sender: TObject; Socket: TCustomWinSocket);
    procedure TimerProcDataTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FConnects : array [0..MaxConnectCount - 1] of TConnect;
    FWileFiles : array [0..1024 - 1] of TWilRead;
    procedure QueryWilData(C : pTConnect; Msg : pTFSMessage; sBody : string);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation


{$R *.dfm}

procedure TFrmMain.ServerSocket1Accept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//
end;

procedure TFrmMain.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  I : Integer;
begin
  Socket.nIndex := -1;
  for I := 0 to MaxConnectCount - 1 do
    if FConnects[I].Socket = nil then begin
      FConnects[I].boCheckPass := False;
      FConnects[I].Socket := Socket;
      FConnects[I].DataBuf := '';
      Socket.nIndex := I;
      Exit;
    end;

end;

procedure TFrmMain.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
   Socket.ReceiveText
end;

procedure TFrmMain.ServerSocket1Listen(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  //
end;

procedure TFrmMain.TimerProcDataTimer(Sender: TObject);
var
  I : Integer;
  Connect : pTConnect;
  sData : string;
  Msg : TFSMessage;
begin
  for I := 0 to MaxConnectCount - 1 do begin
    Connect := @FConnects[I];
    if (Connect.Socket <> nil) and Connect.Socket.Connected then begin
      sData := Connect.DataBuf;
      if Length(sData) > SizeOf(TFSMessage) then begin
        Move(sData, Msg, SizeOf(TFSMessage));
        Delete(sData, 1, SizeOf(TFSMessage));
        case Msg.Ident of
          QF_WilIndexData:QueryWilData(Connect, @Msg, sData);
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  //ShowMessage(IntToStr(SizeOf(AData)));
end;

procedure TFrmMain.QueryWilData(C : pTConnect; Msg : pTFSMessage; sBody : string);
begin

end;

end.
