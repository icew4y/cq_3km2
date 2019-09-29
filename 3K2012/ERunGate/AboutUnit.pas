unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TFrmAbout = class(TForm)
    Label2: TLabel;
    ButtonOK: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditProductName: TEdit;
    EditVersion: TEdit;
    EditUpDateTime: TEdit;
    EditProgram: TEdit;
    EditWebSite: TEdit;
    EditBbsSite: TEdit;
    Image1: TImage;
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmAbout: TFrmAbout;

implementation
uses EDcodeUnit, GateShare;
{$R *.dfm}
procedure TFrmAbout.Open();
var
  sProgram, sProductName, sVersion, sBbsSite,sUpDateTime, sWebSite: string;
begin
  Decode(g_sProductName, sProductName);
  EditProductName.Text := sProductName;
  Decode(g_sVersion, sVersion);
  EditVersion.Text := sVersion;
  Decode(g_sUpDateTime, sUpDateTime);
  EditUpDateTime.Text := sUpDateTime;
  Decode(g_sProgram, sProgram);
  EditProgram.Text := sProgram;
  Decode(g_sWebSite, sWebSite);
  EditWebSite.Text := sWebSite;
  Decode(g_sBbsSite, sBbsSite);
  EditBbsSite.Text := sBbsSite;
  ShowModal;
end;
procedure TFrmAbout.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

end.
