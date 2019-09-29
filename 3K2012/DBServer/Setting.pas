unit Setting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, Spin;

type
  TFrmSetting = class(TForm)
    GroupBox1: TGroupBox;
    ButtonOK: TButton;
    CheckBoxAttack: TCheckBox;
    CheckBoxDenyChrName: TCheckBox;
    CheckBoxMinimize: TCheckBox;
    CheckBoxRandomCode: TCheckBox;
    CheckBoxNoCanResDelChr: TCheckBox;
    CheckBox1: TCheckBox;
    EdituserLevel: TSpinEdit;
    procedure CheckBoxAttackClick(Sender: TObject);
    procedure CheckBoxDenyChrNameClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure CheckBoxMinimizeClick(Sender: TObject);
    procedure CheckBoxRandomCodeClick(Sender: TObject);
    procedure CheckBoxNoCanResDelChrClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure EdituserLevelChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmSetting: TFrmSetting;

implementation
uses DBShare;
{$R *.dfm}
procedure TFrmSetting.Open();
begin
  CheckBoxAttack.Checked := boAttack;
  CheckBoxDenyChrName.Checked := boDenyChrName;
  CheckBoxMinimize.Checked := boMinimize;
  CheckBoxRandomCode.Checked := g_boRandomCode;
  CheckBoxNoCanResDelChr.Checked := g_boNoCanResDelChr;//20080706 ½ûÖ¹»Ö¸´É¾³ýµÄ½ÇÉ«
  CheckBox1.Checked := g_boNoCanDelChr;
  if g_boNoCanDelChr then EdituserLevel.Enabled:= True;
  EdituserLevel.Value := dwCanDelChrLevel;
  ButtonOK.Enabled := False;
  ShowModal;
end;

procedure TFrmSetting.CheckBoxAttackClick(Sender: TObject);
begin
  boAttack := CheckBoxAttack.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxDenyChrNameClick(Sender: TObject);
begin
  boDenyChrName := CheckBoxDenyChrName.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.ButtonOKClick(Sender: TObject);
var
  Conf: TIniFile;
begin
  Conf := TIniFile.Create(sConfFileName);
  if Conf <> nil then begin
    Conf.WriteBool('Setup', 'Attack', boAttack);
    Conf.WriteBool('Setup', 'DenyChrName', boDenyChrName);
    Conf.WriteBool('Setup', 'Minimize', boMinimize);
    Conf.WriteBool('Setup', 'RandomCode', g_boRandomCode);
    Conf.WriteBool('Setup', 'NoCanResDelChr', g_boNoCanResDelChr);//20080706 ½ûÖ¹»Ö¸´É¾³ýµÄ½ÇÉ«
    Conf.WriteBool('Setup', 'NoCanDelChr', g_boNoCanDelChr);
    Conf.WriteInteger('Setup', 'CanDelChrLevel', dwCanDelChrLevel);
    Conf.Free;
    ButtonOK.Enabled := False;
  end;
end;

procedure TFrmSetting.CheckBoxMinimizeClick(Sender: TObject);
begin
  boMinimize := CheckBoxMinimize.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxRandomCodeClick(Sender: TObject);
begin
  g_boRandomCode := CheckBoxRandomCode.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBoxNoCanResDelChrClick(Sender: TObject);
begin
  g_boNoCanResDelChr :=CheckBoxNoCanResDelChr.Checked;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.CheckBox1Click(Sender: TObject);
begin
  g_boNoCanDelChr :=CheckBox1.Checked;
  if g_boNoCanDelChr then EdituserLevel.Enabled:= True
  else EdituserLevel.Enabled:= False;
  ButtonOK.Enabled := True;
end;

procedure TFrmSetting.EdituserLevelChange(Sender: TObject);
begin
  dwCanDelChrLevel :=EdituserLevel.Value;
  ButtonOK.Enabled := True;
end;

end.

