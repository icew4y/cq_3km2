unit UpRegM2Date;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TUpRegM2DateFrm = class(TForm)
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Edit7: TEdit;
    EdtDLName: TEdit;
    Edit1: TEdit;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    EdtUserAccount: TEdit;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label12: TLabel;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    bois176: Boolean;
  public
    procedure Open(is176: Boolean);
  end;

var
  UpRegM2DateFrm: TUpRegM2DateFrm;
  dwRegM2Tick: LongWord;
implementation

uses Main, Share, Common, StrUtils;
{$R *.dfm}

procedure TUpRegM2DateFrm.BitBtn1Click(Sender: TObject);
  function CheckAccountName(sName: string): Boolean;//检查是否有非法字符
  begin
    Result := False;
    if (sName = '') or (pos('/',sName) > 0) or (pos('\',sName) > 0) or
       (pos(':',sName) > 0) or (pos('?',sName) > 0) or (pos('<',sName) > 0) or
       (pos('>',sName) > 0) then Exit;
    Result := true;
  end;
var
  sUserTpye: String;
begin
  if not g_boConnect then begin
    Application.MessageBox('和服务器已经断开连接,请重新登陆！', '错误', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  if RadioButton1.Checked then sUserTpye:= '[包年延期]' else sUserTpye:= '[包月延期]';
  if Application.MessageBox(PChar(sUserTpye+'是否确定进行用户延期？注意:延期成功则从当日计算使用日期'), '提示',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    if Trim(EdtUserAccount.Text) = '' then begin
      Application.MessageBox('请填写用户登陆帐号！', 'Error', MB_OK + MB_ICONSTOP);
      EdtUserAccount.SetFocus;
      Exit;
    end;
    if not CheckAccountName(Trim(EdtUserAccount.Text)) then begin
      Application.MessageBox('用户登陆帐号包含非法字符！', 'Error', MB_OK + MB_ICONSTOP);
      EdtUserAccount.SetFocus;
      Exit;
    end;
    if GetTickCount - dwRegM2Tick < 5000 then begin
      Application.MessageBox('你操作过快，请稍后操作！', 'Error', MB_OK + MB_ICONWARNING);
      Exit;
    end;
    sUserTpye:= '';
    if RadioButton1.Checked then sUserTpye := '1' //设置注册M2类型 20110712
    else if RadioButton2.Checked then sUserTpye := '2';

    FrmMain.SendM2DateUpdata(EdtUserAccount.Text, sUserTpye, bois176);
    dwRegM2Tick := GetTickCount();
    StatusBar1.Panels[0].Text := '正在进行引擎用户延期，请稍后……';
  end;
end;

procedure TUpRegM2DateFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TUpRegM2DateFrm.FormDestroy(Sender: TObject);
begin
  UpRegM2DateFrm:= nil;
end;

procedure TUpRegM2DateFrm.Open(is176: Boolean);
begin
  if is176 then begin
    Caption := '1.76引擎延期';
  end else Caption := '连击引擎延期';
  bois176 := is176;
  EdtDLName.Text := g_MySelf.sAccount;
  Edit7.Text:= CurrToStr(g_MySelf.sM2Price);
  Edit1.Text:= CurrToStr(g_MySelf.sM2PriceMonth);//显示包月价格 20110712
  EdtUserAccount.Text := '';
  StatusBar1.Panels[0].Text := '';
  ShowModal;
end;
end.
