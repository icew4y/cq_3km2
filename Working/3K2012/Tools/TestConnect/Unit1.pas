unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JSocket, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure Disconnect(Sender: TObject; Socket: TCustomWinSocket);
  end;

var
  Form1: TForm1;
  Connected, DisConnected : Integer;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  I, Count : Integer;
begin
  Connected := 0;
  DisConnected := 0;
  Count := StrToIntDef(Edit3.Text, 256);
  for I := 0 to Count - 1 do
    with TClientSocket.Create(Self) do begin
      ClientType := ctNonBlocking;
      Address := Edit1.Text;
      Port := StrToIntDef(Edit2.Text, 7000);
      OnConnect := Connect;
      OnDisconnect := Disconnect;
      Open;
    end;
end;
procedure TForm1.Connect(Sender: TObject; Socket: TCustomWinSocket);
begin
  Inc(Connected);
end;

procedure TForm1.Disconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  Inc(DisConnected);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Edit4.Text := IntToStr(Connected);
  Edit5.Text := IntToStr(DisConnected);
end;

end.
