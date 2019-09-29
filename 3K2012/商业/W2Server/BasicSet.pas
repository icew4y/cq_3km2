unit BasicSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, ComCtrls;

type
  TFrmBasicSet = class(TForm)
    BtnSave: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    EdtSqlLienk: TEdit;
    EdtMaxDayMakeNum: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtGateVersionNum: TEdit;
    Label3: TLabel;
    EdtLoginVersionNum: TEdit;
    Label4: TLabel;
    EdtLoginVersion: TEdit;
    Label6: TLabel;
    EdtM2Version: TEdit;
    Label8: TLabel;
    Edt176LoginVersion: TEdit;
    Label9: TLabel;
    Edt176M2Version: TEdit;
    Label7: TLabel;
    EdtW2Version: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edt176GateVersionNum: TEdit;
    Edt176LoginVersionNum: TEdit;
    procedure BtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmBasicSet: TFrmBasicSet;

implementation
uses Share;
{$R *.dfm}

{ TFrmBasicSet }

procedure TFrmBasicSet.Open;
begin
  EdtMaxDayMakeNum.Text := IntToStr(g_btMaxDayMakeNum);
  EdtGateVersionNum.Text := g_sGateVersionNum;
  EdtLoginVersionNum.Text := g_sLoginVersionNum;
  Edt176GateVersionNum.Text := g_s176GateVersionNum;
  Edt176LoginVersionNum.Text := g_s176LoginVersionNum;
  Edt176LoginVersion.Text := g_s176LoginVersion;
  EdtLoginVersion.Text := g_sLoginVersion;
  EdtM2Version.Text := g_sM2Version;
  Edt176M2Version.Text := g_s176M2Version;
  EdtW2Version.Text := IntToStr(g_nW2Version);
  EdtSqlLienk.Text := g_sSqlConnect;
  ShowModal;
end;

procedure TFrmBasicSet.BtnSaveClick(Sender: TObject);
var
  Conf: TIniFile;
begin
  g_btMaxDayMakeNum := StrToInt(EdtMaxDayMakeNum.Text);
  g_sGateVersionNum := EdtGateVersionNum.Text;
  g_sLoginVersionNum := EdtLoginVersionNum.Text;

  g_s176GateVersionNum := Edt176GateVersionNum.Text;
  g_s176LoginVersionNum := Edt176LoginVersionNum.Text;

  g_sLoginVersion := EdtLoginVersion.Text;
  g_s176LoginVersion := Edt176LoginVersion.Text;
  g_sM2Version := EdtM2Version.Text;
  g_s176M2Version := Edt176M2Version.Text;
  g_nW2Version := StrToInt(EdtW2Version.Text);
  g_sSqlConnect := EdtSqlLienk.Text;

  Conf := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
  Conf.WriteInteger('W2Server', 'MaxDayMakeNum', g_btMaxDayMakeNum);
  Conf.WriteString('W2Server', 'GateVersionNum', g_sGateVersionNum);
  Conf.WriteString('W2Server', 'LoginVersionNum', g_sLoginVersionNum);

  Conf.WriteString('W2Server', '176GateVersionNum', g_s176GateVersionNum);
  Conf.WriteString('W2Server', '176LoginVersionNum', g_s176LoginVersionNum);

  Conf.WriteString('W2Server', 'LoginVersion', g_sLoginVersion);
  Conf.WriteString('W2Server', '176LoginVersion', g_s176LoginVersion);
  Conf.WriteString('W2Server', 'M2Version', g_sM2Version);
  Conf.WriteString('W2Server', '176M2Version', g_s176M2Version);                                                                            
  Conf.WriteInteger('W2Server', 'W2Version', g_nW2Version);
  Conf.WriteString('W2Server', 'SqlConnect', g_sSqlConnect);
  Conf.Free;
  Close;
end;

end.
