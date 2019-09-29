unit AboutUnit;

interface

uses
  Classes, Controls, Forms, Graphics, StdCtrls, jpeg, ExtCtrls;

type
  TFrmAbout = class(TForm)
    ButtonOK: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmAbout: TFrmAbout;

implementation
uses EDcodeUnit, M2Share;
{$R *.dfm}
procedure TFrmAbout.Open();
var
  sProductName: string;
  sVersion: string;
  sUpDateTime: string;
  sProgram: string;
  sWebSite: string;
  sBbsSite: string;
  sTemp: string;
begin
    sTemp:=addStringList(g_sVersion);
    Decode(sTemp, sVersion);

    sTemp:=addStringList(g_sUpDateTime);
    Decode(sTemp, sUpDateTime);

  if not boShowSetTxt then begin
    sTemp:=addStringList(g_sProductName);
    Decode(sTemp, sProductName);

    sTemp:=addStringList(g_sProgram);
    Decode(sTemp, sProgram);

    sTemp:=addStringList(g_sWebSite);
    Decode(sTemp, sWebSite);

    sTemp:=addStringList(g_sBbsSite);
    Decode(sTemp, sBbsSite);
  end else begin
    sProductName:= sProductName1;
    sProgram:= sProgram1;
    sWebSite:= sWebSite1;
    sBbsSite:= sBbsSite1;
  end;
  EditProductName.Text := sProductName;
  EditVersion.Text := sVersion;
  EditUpDateTime.Text := sUpDateTime;
  EditProgram.Text := sProgram;
  EditWebSite.Text := sWebSite;
  EditBbsSite.Text := sBbsSite;
  if (nErrorLevel <> 0) or (nCrackedLevel <> 0) then Label1.Font.Color:= clRed;//20090507 检查是否是破解程序
  ShowModal;
end;

procedure TFrmAbout.ButtonOKClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmAbout.FormDestroy(Sender: TObject);
begin
  FrmAbout := nil;
end;

end.
