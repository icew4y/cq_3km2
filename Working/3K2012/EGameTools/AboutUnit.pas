unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BusinessSkinForm, bsSkinCtrls, StdCtrls, jpeg, ExtCtrls;

type
  TFrmAbout = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    EditProductName: TbsSkinStdLabel;
    EditVersion: TbsSkinStdLabel;
    EditUpDateTime: TbsSkinStdLabel;
    EditProgram: TbsSkinStdLabel;
    bsSkinGroupBox2: TbsSkinGroupBox;
    bsSkinStdLabel7: TbsSkinStdLabel;
    bsSkinStdLabel8: TbsSkinStdLabel;
    bsSkinButtonLabel1: TbsSkinButtonLabel;
    EditWebSite: TbsSkinLinkLabel;
    EditBbsSite: TbsSkinLinkLabel;
    Image1: TImage;
    procedure bsSkinButtonLabel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmAbout: TFrmAbout;

implementation
uses Main, EDcodeUnit, EGameToolsShare;
{$R *.dfm}
procedure TFrmAbout.Open();
var
  sProductName: string;
  sVersion: string;
  sUpDateTime: string;
  sProgram: string;
  sWebSite: string;
  sBbsSite: string;
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sVersion, sVersion);
  Decode(g_sUpDateTime, sUpDateTime);
  Decode(g_sProgram, sProgram);
  Decode(g_sWebSite, sWebSite);
  Decode(g_sBbsSite, sBbsSite);
  EditProductName.Caption := sProductName;
  EditVersion.Caption := Format(sVersion, [0]);
  EditUpDateTime.Caption := sUpDateTime;
  EditProgram.Caption := sProgram;
  EditWebSite.Caption := sWebSite;
  EditWebSite.URL := sWebSite;
  EditBbsSite.Caption := sBbsSite;
  EditBbsSite.URL := sBbsSite;
  ShowModal;
end;
procedure TFrmAbout.bsSkinButtonLabel1Click(Sender: TObject);
begin
  Close;
end;

end.
