unit BasicSet;

interface

uses
  Classes, Controls, Forms,
  StdCtrls, ComCtrls, Mask, RzEdit, RzBtnEdt, ExtDlgs, Dialogs, Jpeg, FileCtrl,
  IniFiles, SysUtils, Spin;

type
  TFrmBasicSet = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtSkinFile: TRzButtonEdit;
    EdtLoginExe: TRzButtonEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    EdtHttp: TEdit;
    Label6: TLabel;
    EdtMakeDir: TRzButtonEdit;
    OpenDialog1: TOpenDialog;
    TabSheet3: TTabSheet;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    EdtGateExe: TRzButtonEdit;
    BtnSave: TButton;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    EdtUpFileDir: TRzButtonEdit;
    Label13: TLabel;
    EdtUserOneTimeMake: TSpinEdit;
    Label14: TLabel;
    Label17: TLabel;
    Edt0627GateExe: TRzButtonEdit;
    Label3: TLabel;
    Edt0627LoginExe: TRzButtonEdit;
    Label4: TLabel;
    Edt176SkinFile: TRzButtonEdit;
    Label9: TLabel;
    Edt176LoginExe: TRzButtonEdit;
    Label10: TLabel;
    Edt176GateExe: TRzButtonEdit;
    procedure EdtSkinFileButtonClick(Sender: TObject);
    procedure EdtLoginExeButtonClick(Sender: TObject);
    procedure EdtGateExeButtonClick(Sender: TObject);
    procedure EdtMakeDirButtonClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure EdtUpFileDirButtonClick(Sender: TObject);
    procedure Edt0627LoginExeButtonClick(Sender: TObject);
    procedure Edt0627GateExeButtonClick(Sender: TObject);
    procedure Edt176SkinFileButtonClick(Sender: TObject);
    procedure Edt176LoginExeButtonClick(Sender: TObject);
    procedure Edt176GateExeButtonClick(Sender: TObject);
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
  EdtSkinFile.Text := g_LoginSkinFile;
  Edt176SkinFile.Text := g_176LoginSkinFile;
  EdtLoginExe.Text := g_LoginExe;
  Edt176LoginExe.Text := g_176LoginExe;
  Edt0627LoginExe.Text := g_0627LoginExe;
  EdtGateExe.Text := g_GateExe;
  Edt176GateExe.Text := g_176GateExe;
  Edt0627GateExe.Text := g_0627GateExe;
  EdtHttp.Text := g_Http;
  EdtMakeDir.Text := g_MakeDir;
  EdtUpFileDir.Text := g_UpFileDir;
  EdtUserOneTimeMake.Value := g_nUserOneTimeMake;
  ShowModal;
end;

procedure TFrmBasicSet.EdtSkinFileButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    EdtSkinFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtLoginExeButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    EdtLoginExe.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtGateExeButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    EdtGateExe.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.EdtMakeDirButtonClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := 'E:\';
  if SelectDirectory('选择生成目录' ,'' ,Dir) then begin
    EdtMakeDir.Text := Dir;
  end;
end;

procedure TFrmBasicSet.EdtUpFileDirButtonClick(Sender: TObject);
var
  Dir: string;
begin
  Dir := 'E:\';
  if SelectDirectory('选择生成目录' ,'' ,Dir) then begin
    EdtUpFileDir.Text := Dir;
  end;
end;

procedure TFrmBasicSet.BtnSaveClick(Sender: TObject);
var
  Conf: TIniFile; 
begin
  g_LoginSkinFile := EdtSkinFile.Text;
  g_176LoginSkinFile := Edt176SkinFile.Text;
  g_LoginExe := EdtLoginExe.Text;
  g_176LoginExe := Edt176LoginExe.Text;
  g_0627LoginExe := Edt0627LoginExe.Text;
  g_GateExe := EdtGateExe.Text;
  g_176GateExe := Edt176GateExe.Text;
  g_0627GateExe := Edt0627GateExe.Text;
  g_Http := EdtHttp.Text;
  g_MakeDir := EdtMakeDir.Text;
  g_UpFileDir := EdtUpFileDir.Text;
  g_nUserOneTimeMake := EdtUserOneTimeMake.Value;

  Conf := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
  Conf.WriteString(MakeClass, '3KSkinFile', g_LoginSkinFile);
  Conf.WriteString(MakeClass, '1763KSkinFile', g_176LoginSkinFile);
  Conf.WriteString(MakeClass, 'LoginExe', g_LoginExe);
  Conf.WriteString(MakeClass, '176LoginExe', g_176LoginExe); 
  Conf.WriteString(MakeClass, '0627LoginExe', g_0627LoginExe);
  Conf.WriteString(MakeClass, 'GateExe', g_GateExe);
  Conf.WriteString(MakeClass, '176GateExe', g_176GateExe);
  Conf.WriteString(MakeClass, '0627GateExe', g_0627GateExe);
  Conf.WriteString(MakeClass, 'Http', g_Http);
  Conf.WriteString(MakeClass, 'MakeDir', g_MakeDir);
  Conf.WriteString(MakeClass, 'UpFileDir', g_UpFileDir);
  Conf.WriteInteger(MakeClass, 'UserOneTimeMake', g_nUserOneTimeMake);
  Conf.Free;
  Close;
end;
procedure TFrmBasicSet.Edt0627LoginExeButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Edt0627LoginExe.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.Edt0627GateExeButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Edt0627GateExe.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.Edt176SkinFileButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Edt176SkinFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.Edt176LoginExeButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Edt176LoginExe.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmBasicSet.Edt176GateExeButtonClick(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Edt176GateExe.Text := OpenDialog1.FileName;
  end;
end;

end.
