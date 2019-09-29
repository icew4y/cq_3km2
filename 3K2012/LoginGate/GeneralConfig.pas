unit GeneralConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IniFiles;

type
  TfrmGeneralConfig = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBoxNet: TGroupBox;
    LabelGateIPaddr: TLabel;
    LabelGatePort: TLabel;
    LabelServerPort: TLabel;
    LabelServerIPaddr: TLabel;
    EditGateIPaddr: TEdit;
    EditGatePort: TEdit;
    EditServerPort: TEdit;
    EditServerIPaddr: TEdit;
    GroupBoxInfo: TGroupBox;
    Label1: TLabel;
    LabelShowLogLevel: TLabel;
    EditTitle: TEdit;
    TrackBarLogLevel: TTrackBar;
    CheckBoxMinimize: TCheckBox;
    ButtonOK: TButton;
    TabSheet2: TTabSheet;
    CheckBoxSpecLogin: TCheckBox;
    Label2: TLabel;
    EdtPassword: TEdit;
    MemoWarningMsg: TMemo;
    Button1: TButton;
    Label3: TLabel;
    procedure ButtonOKClick(Sender: TObject);
    procedure CheckBoxMinimizeClick(Sender: TObject);
    procedure EdtGateVersionKeyPress(Sender: TObject; var Key: Char);
    procedure MemoWarningMsgChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGeneralConfig: TfrmGeneralConfig;

implementation

uses StrUtils, HUtil32, GateShare;

{$R *.dfm}

procedure TfrmGeneralConfig.ButtonOKClick(Sender: TObject);
var
  sGateIPaddr, sServerIPaddr, sTitle: string;
  nGatePort, nServerPort, nShowLogLv: Integer;
  {$IF SPECVERSION = 1}
  boSpecLogin: Boolean; //20080831
  sPassWord: string;    //20080831
  {$IFEND}
  Conf: TIniFile;
begin
  sGateIPaddr := Trim(EditGateIPaddr.Text);
  nGatePort := Str_ToInt(Trim(EditGatePort.Text), -1);
  sServerIPaddr := Trim(EditServerIPaddr.Text);
  nServerPort := Str_ToInt(Trim(EditServerPort.Text), -1);
  sTitle := Trim(EditTitle.Text);
  nShowLogLv := TrackBarLogLevel.Position;
  {$IF SPECVERSION = 1}
  boSpecLogin := CheckBoxSpecLogin.Checked;  //20080831
  sPassWord := Trim(EdtPassword.Text); //20080831
  {$IFEND}
  if not IsIPaddr(sGateIPaddr) then begin
    Application.MessageBox('网关地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGateIPaddr.SetFocus;
    exit;
  end;

  if (nGatePort < 0) or (nGatePort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditGatePort.SetFocus;
    exit;
  end;

  if not IsIPaddr(sServerIPaddr) then begin
    Application.MessageBox('服务器地址设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditServerIPaddr.SetFocus;
    exit;
  end;

  if (nServerPort < 0) or (nServerPort > 65535) then begin
    Application.MessageBox('网关端口设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditServerPort.SetFocus;
    exit;
  end;
  if sTitle = '' then begin
    Application.MessageBox('标题设置错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    EditTitle.SetFocus;
    exit;
  end;

  nShowLogLevel := nShowLogLv;
  TitleName := sTitle;
  ServerAddr := sServerIPaddr;
  ServerPort := nServerPort;
  GateAddr := sGateIPaddr;
  GatePort := nGatePort;
  {$IF SPECVERSION = 1}
  g_sPassWord := sPassWord; //20080831
  g_boSpecLogin := boSpecLogin; //20080831
  if g_boSpecLogin then begin
    MemoWarningMsg.Lines.SaveToFile('.\WarningMsg.txt');
  end;
  {$IFEND}

  Conf := TIniFile.Create('.\Config.ini');
  Conf.WriteString(GateClass, 'Title', TitleName);
  Conf.WriteString(GateClass, 'ServerAddr', ServerAddr);
  Conf.WriteInteger(GateClass, 'ServerPort', ServerPort);
  Conf.WriteString(GateClass, 'GateAddr', GateAddr);
  Conf.WriteInteger(GateClass, 'GatePort', GatePort);

  Conf.WriteInteger(GateClass, 'ShowLogLevel', nShowLogLevel);
  Conf.WriteBool(GateClass, 'Minimize', g_boMinimize);
  {$IF SPECVERSION = 1}
  Conf.WriteString(GateClass, 'PassWord', g_sPassWord); //20080831
  Conf.WriteBool(GateClass, 'SpecLogin', g_boSpecLogin); //20080831
  {$IFEND}
  Conf.Free;
  Close;
end;

procedure TfrmGeneralConfig.CheckBoxMinimizeClick(Sender: TObject);
begin
  g_boMinimize := CheckBoxMinimize.Checked;
end;

procedure TfrmGeneralConfig.EdtGateVersionKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13]) then Key := #0;
end;

procedure TfrmGeneralConfig.MemoWarningMsgChange(Sender: TObject);
begin
  {$IF SPECVERSION = 1}
  g_sGataPassFailMessage := MemoWarningMsg.Lines.Text;
  g_sGataPassFailMessage := AnsiReplaceText(g_sGataPassFailMessage, sLineBreak, '\');
  {$ifend}
end;

end.

