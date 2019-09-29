unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls,  Mask,
  BusinessSkinForm, bsSkinCtrls,
  bsSkinBoxCtrls, bsSkinShellCtrls, DBTables, IniFiles;

type
  TFrmLogin = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    EditServerDir: TbsSkinDirectoryEdit;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    bsSkinStdLabel3: TbsSkinStdLabel;
    EditDBBase: TbsSkinEdit;
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure LoadConfig; //读入配置
    function SaveConfig():Boolean;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation
uses Main, EGameToolsShare, DM;
{$R *.dfm}

procedure TFrmLogin.LoadConfig; //读入配置
var
  MyIni: TIniFile;
begin
  MyIni := TIniFile.Create(ConfigFileName);
  DBEName := MyIni.ReadString('SYSTEM','DBEName',DBEName);
  sGameDirectory := MyIni.ReadString('SYSTEM','ServerDir',sGameDirectory);
  sWilDirectory:= MyIni.ReadString('SYSTEM','WilDirectory',sWilDirectory);
  EditServerDir.Text:= sGameDirectory;
  EditDBBase.Text:= DBEName;
  MyIni.Free;
end;

function TFrmLogin.SaveConfig: Boolean;
var
  MyIni: TIniFile;
begin
  Result := False;
  MyIni:= TIniFile.Create(ConfigFileName);
  MyIni.WriteString('SYSTEM','ServerDir',EditServerDir.Text);
  MyIni.WriteString('SYSTEM','DBEName',EditDBBase.Text);
  MyIni.Free;
  Result := True;
end;

procedure TFrmLogin.bsSkinButton1Click(Sender: TObject);
var
  ap: TStringList;
  sDir: string;
begin
 ap := Tstringlist.Create;
 session.GetAliasNames(ap);
 sDir := EditServerDir.Text;
  if not (sDir[length(sDir)] = '\') then begin
    FrmMain.bsSkinMessage1.MessageDlg('版本目录名称最后一个字符必须为"\"！！！',mtInformation,[mbOK],0);
    EditServerDir.SetFocus;
    exit;
  end;
 if (ap.IndexOf(Trim(EditDBBase.Text)) = -1)then begin
    FrmMain.bsSkinMessage1.MessageDlg('没检测到"'+Trim(EditDBBase.Text)+'"数据源',mtInformation,[mbOK],0);
    ap.Free;
    Exit;
 end;
 if SaveConfig then begin
    FrmMain.LoadConfig;
    FrmMain.Open;
    FrmDM.Query1.DatabaseName:= Trim(EditDBBase.Text);//20080304 设置数据源
    Close;
 end;
  ap.Free;
end;

procedure TFrmLogin.bsSkinButton2Click(Sender: TObject);
begin
  Application.Terminate;
end;


procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  LoadConfig; //读入配置
end;

end.
