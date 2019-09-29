unit RegLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,Clipbrd, ComCtrls, ExtCtrls;

type
  TFrmRegLogin = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnRandomGatePass: TSpeedButton;
    EdtGameListURL: TEdit;
    EdtBakGameListURL: TEdit;
    EdtPatchListURL: TEdit;
    EdtGameMonListURL: TEdit;
    EdtGameESystem: TEdit;
    EdtGatePass: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit7: TEdit;
    EdtDLName: TEdit;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    EdtUserAccount: TEdit;
    EdtUserQQ: TEdit;
    Label12: TLabel;
    procedure BitBtn3Click(Sender: TObject);
    procedure BtnRandomGatePassClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdtUserAccountKeyPress(Sender: TObject; var Key: Char);
    procedure EdtUserQQKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    bois176Login: Boolean;
  public
    procedure Open(bois176: Boolean);
  end;

var
  FrmRegLogin: TFrmRegLogin;
  dwCheckAccountTick: LongWord;
  dwRegLoginTick: LongWord;
implementation
uses Share, Common, Main;
{$R *.dfm}

procedure TFrmRegLogin.BitBtn3Click(Sender: TObject);
var
  Str, Str1: string;
begin
  if EdtGameListURL.Text = '' then begin
    Application.MessageBox('游戏列表地址不能为空！', '错误', MB_OK +
      MB_ICONSTOP);
    EdtGameListURL.SetFocus;
    Exit;
  end;
  if EdtBakGameListURL.Text = '' then begin
    Application.MessageBox('备用列表地址不能为空！', '错误', MB_OK +
      MB_ICONSTOP);
    EdtBakGameListURL.SetFocus;
    Exit;  
  end;
  if EdtPatchListURL.Text = '' then begin
    Application.MessageBox('更新列表地址不能为空！', '错误', MB_OK +
      MB_ICONSTOP);
    EdtPatchListURL.SetFocus;
    Exit;  
  end;
  if EdtGameMonListURL.Text = '' then begin
    Application.MessageBox('反外挂列表地址不能为空！', '错误', MB_OK +
      MB_ICONSTOP);
    EdtGameMonListURL.SetFocus;
    Exit;
  end;
  if bois176Login then Str1 := '1.76' else Str1 := '连击';
  Str := '尊敬的用户：欢迎购买3K'+Str1+'登陆器' + #13 + #10 +
         '请确认以下信息是否正确,绑定注册信息后不能更改!' + #13 + #10 +
         //'如果代理人有任何问题请联系QQ357001001 进行投诉.' + #13 + #10 +
         '' + #13 + #10 +
         '用户登陆帐号：' + EdtUserAccount.Text + #13 + #10 +
         '用户QQ号码：' + EdtUserQQ.Text + #13 + #10 +
         '游戏列表地址：' + EdtGameListURL.Text + #13 + #10 +
         '备用列表地址：' + EdtBakGameListURL.Text + #13 + #10 +
         '更新列表地址：' + EdtPatchListURL.Text + #13 + #10 +
         '反外挂列表地址：' + EdtGameMonListURL.Text + #13 + #10 +
         'E系统热点地址：' + EdtGameESystem.Text;{ + #13 + #10 +
         '配套网关封包码：' + EdtGatePass.Text;}
  Clipbrd.Clipboard.AsText := str ;
  Application.MessageBox(PChar('配置信息已经复制成功  内容如下：' + #13 + #13 + #10 + Str), '提示', MB_OK +
    MB_ICONINFORMATION);
end;

procedure TFrmRegLogin.BtnRandomGatePassClick(Sender: TObject);
  //随机取名
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //随机种子
      for i:=0 to 19 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
begin
  EdtGatePass.Text := RandomGetName;
end;

procedure TFrmRegLogin.Open(bois176: Boolean);
begin
  if bois176 then begin
    Caption := '1.76登陆器注册';
  end else Caption := '连击登陆器注册';
  bois176Login := bois176;
  EdtDLName.Text := g_MySelf.sAccount;
  Edit7.Text:= CurrToStr(g_MySelf.sPrice);
  EdtUserAccount.Text := '';
  EdtUserQQ.Text := '';
  EdtGameListURL.Text := 'http://www.3KM2.com/QKServerList.txt';
  EdtBakGameListURL.Text := 'http://www.3KM2.com/QKBakServerList.txt';
  EdtPatchListURL.Text := 'http://www.3KM2.com/QKFileList.txt';
  EdtGameMonListURL.Text := 'http://www.3KM2.com/QKGameMonList.txt';
  EdtGameESystem.Text := 'http://www.3KM2.com/rdxt.htm';
  EdtGatePass.Text := '请点右边随机生成...';
  StatusBar1.Panels[0].Text := '';
  ShowModal;
end;

procedure TFrmRegLogin.BitBtn1Click(Sender: TObject);
var
  ue: TUserEntry1;
begin
  if not g_boConnect then begin
    Application.MessageBox('和服务器已经断开连接,请重新登陆！', '错误', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  if Application.MessageBox('是否确定注册信息？注册后不允许更改！', '提示',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    if Trim(EdtUserAccount.Text) = '' then begin
      Application.MessageBox('请填写用户登陆帐号！', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtUserAccount.SetFocus;
      Exit;
    end;
    if Trim(EdtUserQQ.Text) = '' then begin
      Application.MessageBox('请填写用户QQ号码！', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtUserQQ.SetFocus;
      Exit;
    end;
    if EdtGameListURL.Text = '' then begin
      Application.MessageBox('游戏列表地址不能为空！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGameListURL.SetFocus;
      Exit;
    end;
    if EdtBakGameListURL.Text = '' then begin
      Application.MessageBox('备用列表地址不能为空！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtBakGameListURL.SetFocus;
      Exit;  
    end;
    if EdtPatchListURL.Text = '' then begin
      Application.MessageBox('更新列表地址不能为空！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtPatchListURL.SetFocus;
      Exit;
    end;
    if EdtGameMonListURL.Text = '' then begin
      Application.MessageBox('反外挂列表地址不能为空！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGameMonListURL.SetFocus;
      Exit;
    end;
    if (EdtGatePass.Text = '') or (EdtGatePass.Text = '请点右边随机生成...') then begin
      Application.MessageBox('请选择网关封包码！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGatePass.SetFocus;
      Exit;
    end;
    if GetTickCount - dwRegLoginTick < 5000 then begin
      Application.MessageBox('你操作过快，请稍后操作！', 'Error', MB_OK + 
        MB_ICONWARNING);
      Exit;
    end;
    FillChar(ue, sizeof(TUserEntry1), #0);
    ue.sAccount := EdtUserAccount.Text;
    ue.sUserQQ := EdtUserQQ.Text;
    ue.sGameListUrl := EdtGameListURL.Text;
    ue.sBakGameListUrl := EdtBakGameListURL.Text;
    ue.sPatchListUrl := EdtPatchListURL.Text;
    ue.sGameMonListUrl := EdtGameMonListURL.Text;
    ue.sGameESystemUrl := EdtGameESystem.Text;
    ue.sGatePass := EdtGatePass.Text;
    FrmMain.SendAddAccount(ue, bois176Login);
    dwRegLoginTick := GetTickCount();
    StatusBar1.Panels[0].Text := '正在注册信息，请稍后……';
  end;
end;

procedure TFrmRegLogin.SpeedButton1Click(Sender: TObject);
begin
  if Trim(EdtUserAccount.Text) = '' then begin
    Application.MessageBox('请填写要查询的用户名！', '提示', MB_OK + 
      MB_ICONWARNING);
    EdtUserAccount.SetFocus;
    Exit;
  end;
  if GetTickCount - dwCheckAccountTick < 5000 then begin
    Application.MessageBox('你操作过快，请稍后操作！', 'Error', MB_OK + 
      MB_ICONWARNING);
    Exit;
  end;
  FrmMain.SendCheckAccount(Trim(EdtUserAccount.Text));
  dwCheckAccountTick := GetTickCount();
end;

procedure TFrmRegLogin.EdtUserAccountKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in['0'..'9','a'..'z','A'..'Z',#8,#13]) then key := #0;
end;

procedure TFrmRegLogin.EdtUserQQKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8,#13]) then Key := #0;
end;                                            

procedure TFrmRegLogin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmRegLogin.FormDestroy(Sender: TObject);
begin
  FrmRegLogin:= nil;
end;

end.
