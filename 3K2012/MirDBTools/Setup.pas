unit Setup;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Graphics,
  RzButton, IniFiles, StdCtrls, Mask, RzEdit, RzLabel,
  ExtCtrls, RzPanel, RzBtnEdt, RzShellDialogs;

type
  TSetupFrm = class(TForm)
    RzPanel2: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    RzGroupBox1: TRzGroupBox;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzGroupBox2: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzOpenDialog1: TRzOpenDialog;
    RzSelectFolderDialog1: TRzSelectFolderDialog;
    ID_DBdir: TRzButtonEdit;
    Hum_dbdir: TRzButtonEdit;
    Mir_dbdir: TRzButtonEdit;
    edt1: TRzEdit;
    RzLabel5: TRzLabel;
    CheckBox1: TCheckBox;
    RzLabel6: TRzLabel;
    HeroMir_dbdir: TRzButtonEdit;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ID_DBdirButtonClick(Sender: TObject);
    procedure Hum_dbdirButtonClick(Sender: TObject);
    procedure Mir_dbdirButtonClick(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure HeroMir_dbdirButtonClick(Sender: TObject);
    procedure ID_DBdirChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetupFrm: TSetupFrm;

implementation
uses Main,DBToolsShare;
{$R *.dfm}
procedure LoadConfig();
var
  Conf: TIniFile;
  LoadString: string;
begin
  Conf := TIniFile.Create(ExtractFilePath(Paramstr(0))+'Set.ini');
  if Conf <> nil then begin
    LoadString := Conf.ReadString('基本设置', 'HeroDB库名', '');
    if LoadString = '' then Conf.WriteString('基本设置', 'HeroDB库名', sHeroDB)
    else sHeroDB:= LoadString;

    LoadString := Conf.ReadString('基本设置', 'IDDBDir', '');
    if LoadString = '' then Conf.WriteString('基本设置', 'IDDBDir', sIDDBFilePath)
    else sIDDBFilePath:= LoadString;

    LoadString := Conf.ReadString('基本设置', 'HumDir', '');
    if LoadString = '' then Conf.WriteString('基本设置', 'HumDir', sHumDBFilePath)
    else sHumDBFilePath:= LoadString;

    LoadString := Conf.ReadString('基本设置', 'MirDir', '');
    if LoadString = '' then Conf.WriteString('基本设置', 'MirDir', sMirDBFilePath)
    else sMirDBFilePath:= LoadString;

    LoadString := Conf.ReadString('基本设置', 'HeroMirDir', '');
    if LoadString = '' then Conf.WriteString('基本设置', 'HeroMirDir', sHeroMirDBFilePath)
    else sHeroMirDBFilePath:= LoadString;

    Conf.Free;
  end;
end;

procedure SaveConfig();
var
  Conf: TIniFile;
begin
  Conf := TIniFile.Create(ExtractFilePath(Paramstr(0))+'Set.ini');
  if Conf <> nil then begin
    Conf.WriteString('基本设置', 'HeroDB库名', sHeroDB);
    Conf.WriteString('基本设置', 'IDDBDir', sIDDBFilePath);
    Conf.WriteString('基本设置', 'HumDir', sHumDBFilePath);
    Conf.WriteString('基本设置', 'MirDir', sMirDBFilePath);
    Conf.WriteString('基本设置', 'HeroMirDir', sHeroMirDBFilePath);
    Conf.Free;
  end;
end;

procedure TSetupFrm.RzBitBtn1Click(Sender: TObject);
begin
  sIDDBFilePath:= ID_DBdir.Text;
  sHumDBFilePath:= Hum_dbdir.Text;
  sMirDBFilePath:= Mir_dbdir.Text;
  sHeroMirDBFilePath:= HeroMir_dbdir.Text;
  if (sIDDBFilePath <> '') and (sHumDBFilePath <>'') and (sMirDBFilePath <> '') and (sHeroMirDBFilePath <>'') then begin
    sHeroDB:= edt1.Text;

    SaveConfig();
    //Application.MessageBox(PChar(sIDDBFilePath), '提示', MB_OK + MB_ICONINFORMATION);
    FrmMain := TFrmMain.Create(Application);
    FrmMain.Show;
    SetupFrm.Hide;
  end else begin
    Application.MessageBox('请设置好相关参数！', '提示', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TSetupFrm.FormCreate(Sender: TObject);
begin
  LoadConfig();//读取ini文件
  edt1.Text:= sHeroDB;
  ID_DBdir.Text:= sIDDBFilePath;
  Hum_dbdir.Text:= sHumDBFilePath;
  Mir_dbdir.Text:= sMirDBFilePath;
  HeroMir_dbdir.Text:= sHeroMirDBFilePath;
end;

procedure TSetupFrm.ID_DBdirButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then ID_DBdir.Text:= RzOpenDialog1.FileName;
end;

procedure TSetupFrm.ID_DBdirChange(Sender: TObject);
begin
  with TRzButtonEdit(Sender) do begin
    if not FileExists(Text) then
      Font.Color := clRed
    else
      Font.Color := clBlack;
  end;
end;

procedure TSetupFrm.HeroMir_dbdirButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then HeroMir_dbdir.Text:= RzOpenDialog1.FileName;
end;

procedure TSetupFrm.Hum_dbdirButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then  Hum_dbdir.Text:= RzOpenDialog1.FileName;
end;

procedure TSetupFrm.Mir_dbdirButtonClick(Sender: TObject);
begin
  RzOpenDialog1.Filter := '数据文件(*.DB)|*.DB';
  if RzOpenDialog1.Execute then Mir_dbdir.Text:= RzOpenDialog1.FileName;
end;

procedure TSetupFrm.edt1Change(Sender: TObject);
begin
  sHeroDB:= edt1.Text;
end;

procedure TSetupFrm.FormShow(Sender: TObject);
begin
  Application.MessageBox('注意：此版本为测试版，在修改之前请备份自己的数据库，'
    + #13#10 + '            如不备份数据，有任何后果自负。', '提示', MB_OK +
    MB_ICONINFORMATION);
end;

procedure TSetupFrm.CheckBox1Click(Sender: TObject);
begin
  boReadHumDate:= CheckBox1.Checked;
end;

end.
