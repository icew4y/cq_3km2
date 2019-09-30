unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses EDcode;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit2.text:= EncodeInfo(Edit1.text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Edit1.text:= DecodeInfo(Edit2.text);
end;

end.
