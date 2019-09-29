unit Querydata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, RzLabel, RzBckgnd;

type
  TFrmQuerydata = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    StatusBar1: TStatusBar;
    RzLabel1: TRzLabel;
    RzSeparator1: TRzSeparator;
    Label1: TLabel;
    EdtGameListURL: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmQuerydata: TFrmQuerydata;

implementation
uses Share;
{$R *.dfm}

{ TFrmQuerydata }

procedure TFrmQuerydata.Open;
begin
  EdtGameListURL.Text := g_MySelf.LoginData.sGameListUrl;
  Edit1.Text := g_MySelf.LoginData.sBakGameListUrl;
  Edit2.Text := g_MySelf.LoginData.sPatchListUrl;
  Edit3.Text := g_MySelf.LoginData.sGameMonListUrl;
  Edit4.Text := g_MySelf.LoginData.sGameESystemUrl;
  Edit5.Text := g_MySelf.LoginData.sGatePass;
  ShowModal;
end;

procedure TFrmQuerydata.Button1Click(Sender: TObject);
begin
  Close;
end;

end.
