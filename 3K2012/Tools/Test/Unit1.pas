unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Clipbrd, WinSock;

type
  TForm1 = class(TForm)
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Run;
  end;

var
  Form1: TForm1;
  WSData : TWSAData;
implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  WSAStartup(MakeWord(2,2), WSData);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  WSACleanup;
end;

procedure TForm1.Run;
var
  I , II: DWORD;
  FDSet : TFDSet;
  TimeVal : TTimeVal;

  ASocket : TSocket;
begin            
  Caption := 'º”ÀŸºÏ≤‚';
  FD_ZERO(FDSet);
  ASocket := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
  FD_SET(ASocket, FDSet);
  TimeVal.tv_usec := 500000;
  TimeVal.tv_sec := 0;
  I := GetTickCount;
  //WinSock.select(1,nil,@FDSet,nil, @TimeVal);
  Sleep(50);
  //for II  := 0 to 10000000000 do ;//asm nop end;
  I := GetTickCount - I;
  Caption := (IntToHex(I, 4));
  closesocket(ASocket);

end;

procedure TForm1.FormClick(Sender: TObject);
begin
  Run
end;

end.

