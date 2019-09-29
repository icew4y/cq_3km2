unit RegM2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ComCtrls, Clipbrd;

type
  TFrmRegM2 = class(TForm)
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtGameListURL: TEdit;
    EdtBakGameListURL: TEdit;
    EdtPatchListURL: TEdit;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit7: TEdit;
    EdtDLName: TEdit;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label12: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    EdtUserAccount: TEdit;
    EdtUserQQ: TEdit;
    Label4: TLabel;
    Edit1: TEdit;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure EdtUserAccountKeyPress(Sender: TObject; var Key: Char);
    procedure EdtUserQQKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    bois176: Boolean;
  public
    procedure Open(is176: Boolean);
  end;

var
  FrmRegM2: TFrmRegM2;
  dwCheckRegM2AccountTick: LongWord;
  dwRegM2Tick: LongWord;
implementation

uses Main, Share, Common, StrUtils;

{$R *.dfm}

procedure TFrmRegM2.Open(is176: Boolean);
begin
  if is176 then begin
    Caption := '1.76引擎注册';
  end else Caption := '连击引擎注册';
  bois176 := is176;
  EdtDLName.Text := g_MySelf.sAccount;
  Edit7.Text:= CurrToStr(g_MySelf.sM2Price);
  Edit1.Text:= CurrToStr(g_MySelf.sM2PriceMonth);//显示包月价格 20110712
  EdtUserAccount.Text := '';
  EdtUserQQ.Text := '';
  EdtGameListURL.Text := '';
  EdtBakGameListURL.Text := '10.10.10.10';
  EdtPatchListURL.Text := '';
  StatusBar1.Panels[0].Text := '';
  ShowModal;
end;

procedure TFrmRegM2.SpeedButton1Click(Sender: TObject);
begin
  if Trim(EdtUserAccount.Text) = '' then begin
    Application.MessageBox('请填写要查询的用户名！', '提示', MB_OK + 
      MB_ICONWARNING);
    EdtUserAccount.SetFocus;
    Exit;
  end;
  if GetTickCount - dwCheckRegM2AccountTick < 5000 then begin
    Application.MessageBox('你操作过快，请稍后操作！', 'Error', MB_OK +
      MB_ICONWARNING);
    Exit;
  end;
  FrmMain.SendCheckRegM2Account(Trim(EdtUserAccount.Text));
  dwCheckRegM2AccountTick := GetTickCount();
end;

procedure TFrmRegM2.EdtUserAccountKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in['0'..'9','a'..'z','A'..'Z',#8,#13]) then key := #0;
end;

procedure TFrmRegM2.EdtUserQQKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8,#13]) then Key := #0;
end;

procedure TFrmRegM2.BitBtn3Click(Sender: TObject);
var
  Str, Str1: string;
begin
  if EdtGameListURL.Text = '' then begin
    Application.MessageBox('公司信息不能为空！', '错误', MB_OK +
      MB_ICONSTOP);
    EdtGameListURL.SetFocus;
    Exit;
  end;
  if EdtBakGameListURL.Text = '' then begin
    Application.MessageBox('IP地址不能为空！', '错误', MB_OK +
      MB_ICONSTOP);
    EdtBakGameListURL.SetFocus;
    Exit;  
  end;
  if EdtPatchListURL.Text = '' then begin
    Application.MessageBox('硬件信息不能为空！', '错误', MB_OK +
      MB_ICONSTOP);
    EdtPatchListURL.SetFocus;
    Exit;  
  end;
  if bois176 then str1 := '1.76' else Str1 := '连击';
  Str := '尊敬的用户：欢迎购买3K'+str1+'引擎' + #13 + #10 +
         '请确认以下信息是否正确,绑定注册信息后不能更改!' + #13 + #10 +
         '' + #13 + #10 +
         '用户登陆帐号：' + EdtUserAccount.Text + #13 + #10 +
         '用户QQ号码：' + EdtUserQQ.Text + #13 + #10 +
         '公司信息：' + EdtGameListURL.Text + #13 + #10 +
         'IP地址：' + EdtBakGameListURL.Text + #13 + #10 +
         '硬件信息：' + EdtPatchListURL.Text;
  Clipbrd.Clipboard.AsText := str ;
  Application.MessageBox(PChar('配置信息已经复制成功  内容如下：' + #13 + #13 + #10 + Str), '提示', MB_OK +
    MB_ICONINFORMATION);
end;

procedure TFrmRegM2.BitBtn1Click(Sender: TObject);
  {/////////////////////////////////////////////////////////
    功  能:  检测IP地址是否有效
    参  数:  字符串
    返回值:  成功:  True  失败: False;
    备 注:   uses StrUtils
  ////////////////////////////////////////////////////////}
  function IsIPAddr(IP: string): Boolean;
  var
    Node: array[0..3] of Integer;
    tIP: string;
    tNode: string;
    tPos: Integer;
    tLen: Integer;
  begin
    Result := False;
    tIP := IP;
    tLen := Length(tIP);
    tPos := Pos('.', tIP);
    tNode := MidStr(tIP, 1, tPos - 1);
    tIP := MidStr(tIP, tPos + 1, tLen - tPos);
    if not TryStrToInt(tNode, Node[0]) then Exit;

    tLen := Length(tIP);
    tPos := Pos('.', tIP);
    tNode := MidStr(tIP, 1, tPos - 1);
    tIP := MidStr(tIP, tPos + 1, tLen - tPos);
    if not TryStrToInt(tNode, Node[1]) then Exit;

    tLen := Length(tIP);
    tPos := Pos('.', tIP);
    tNode := MidStr(tIP, 1, tPos - 1);
    tIP := MidStr(tIP, tPos + 1, tLen - tPos);
    if not TryStrToInt(tNode, Node[2]) then Exit;

    if not TryStrToInt(tIP, Node[3]) then Exit;
    for tLen := Low(Node) to High(Node) do begin
      if (Node[tLen] < 0) or (Node[tLen] > 255) then Exit;
    end;
    Result := True;
  end;
  function CheckAccountName(sName: string): Boolean;//检查是否有非法字符 20090904
  var
    I: Integer;
    nLen: Integer;
  begin
    Result := False;
    if (sName = '') or (pos('/',sName) > 0) or (pos('\',sName) > 0) or (pos(':',sName) > 0) or (pos('?',sName) > 0) or (pos('<',sName) > 0) or (pos('>',sName) > 0) then Exit;
    Result := true;
    {nLen := length(sName);
    I := 1;
    while (true) do begin
      if I > nLen then break;
      if (sName[I] < '0') or (sName[I] > 'z') then begin
        Result := False;
        if (sName[I] >= #$B0) and (sName[I] <= #$C8) then begin //#表示转换成字符 $B0-16进制编码
          Inc(I);
          if I <= nLen then
            if (sName[I] >= #$A1) and (sName[I] <= #$FE) then Result := true;
        end;
        if not Result then break;
      end;
      Inc(I);
    end; }
  end;
var
  ue: TM2UserEntry;
  sUserTpye: String;
begin
  if not g_boConnect then begin
    Application.MessageBox('和服务器已经断开连接,请重新登陆！', '错误', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  if RadioButton1.Checked then sUserTpye:= '[包年注册]' else sUserTpye:= '[包月注册]';

  if Application.MessageBox(PChar(sUserTpye+'是否确定注册信息？注册后不允许更改！'), '提示',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    if Trim(EdtUserAccount.Text) = '' then begin
      Application.MessageBox('请填写用户登陆帐号！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtUserAccount.SetFocus;
      Exit;
    end;
    if not CheckAccountName(Trim(EdtUserAccount.Text)) then begin
      Application.MessageBox('用户登陆帐号包含非法字符！', 'Error', MB_OK + MB_ICONSTOP);
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
      Application.MessageBox('公司信息不能为空！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtGameListURL.SetFocus;
      Exit;
    end;
    if not CheckAccountName(Trim(EdtGameListURL.Text)) then begin
      Application.MessageBox('公司信息包含非法字符！', 'Error', MB_OK + MB_ICONSTOP);
      EdtGameListURL.SetFocus;
      Exit;
    end;
    if EdtBakGameListURL.Text = '' then begin
      Application.MessageBox('IP地址不能为空！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtBakGameListURL.SetFocus;
      Exit;  
    end;
    if EdtPatchListURL.Text = '' then begin
      Application.MessageBox('硬件信息不能为空！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtPatchListURL.SetFocus;
      Exit;
    end;
    if GetTickCount - dwRegM2Tick < 5000 then begin
      Application.MessageBox('你操作过快，请稍后操作！', 'Error', MB_OK + 
        MB_ICONWARNING);
      Exit;
    end;
    if not IsIPAddr(Trim(EdtBakGameListURL.Text)) then begin
      Application.MessageBox('输入的IP地址不是有效的地址！', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtBakGameListURL.SetFocus;
      Exit;
    end;

    FillChar(ue, sizeof(TM2UserEntry), #0);
    ue.sAccount := Trim(EdtUserAccount.Text);
    ue.sUserQQ := Trim(EdtUserQQ.Text);
    ue.sGameListUrl := Trim(EdtGameListURL.Text);//公司
    ue.sBakGameListUrl := Trim(EdtBakGameListURL.Text);//IP地址
    ue.sPatchListUrl := Trim(EdtPatchListURL.Text);//硬件信息
    if RadioButton1.Checked then ue.sUserTpye := 1 //设置注册M2类型 20110712
    else if RadioButton2.Checked then ue.sUserTpye := 2;
    FrmMain.SendAddRegM2Account(ue, bois176);
    dwRegM2Tick := GetTickCount();
    StatusBar1.Panels[0].Text := '正在注册信息，请稍后……';
  end;
end;

procedure TFrmRegM2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFrmRegM2.FormDestroy(Sender: TObject);
begin
  FrmRegM2:= nil;
end;


end.
