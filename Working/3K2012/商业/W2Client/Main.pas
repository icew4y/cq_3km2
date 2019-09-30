unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, RzPanel, RzSplit, JSocket, WinSkinData,
  StdCtrls, RzStatus, ComCtrls, ToolWin, EDcode, Common, EDcodeUnit ,Login, Clipbrd,
  RzGroupBar, OleCtrls, SHDocVw, Grobal2, IdHTTP;

type
  TFrmMain = class(TForm)
    DecodeTimer: TTimer;
    ClientSocket: TClientSocket;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LabelUserName: TLabel;
    LabelName: TLabel;
    LabelMoney: TLabel;
    LabelAddrs: TLabel;
    LabelTime: TLabel;
    LabelAllMoney: TLabel;
    Label7: TLabel;
    MainMenu: TMainMenu;
    MENU_CONTROL: TMenuItem;
    MENU_CONTROL_REFLOGIN: TMenuItem;
    MENU_CONTROL_EXIT: TMenuItem;
    MEMU_CENECT: TMenuItem;
    MEMU_CENECT_USERNAME: TMenuItem;
    MENU_HELP: TMenuItem;
    MENU_HELP_ABOUT: TMenuItem;
    StatusPaneMsg: TStatusBar;
    SkinData1: TSkinData;
    N1: TMenuItem;
    X1: TMenuItem;
    S1: TMenuItem;
    N2: TMenuItem;
    M1: TMenuItem;
    N1761: TMenuItem;
    N1762: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N1763: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure DecodeTimerTimer(Sender: TObject);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormActivate(Sender: TObject);
    procedure MEMU_CENECT_USERNAMEClick(Sender: TObject);
    procedure X1Click(Sender: TObject);
    procedure MENU_CONTROL_EXITClick(Sender: TObject);
    procedure MENU_CONTROL_REFLOGINClick(Sender: TObject);
    procedure MENU_HELP_ABOUTClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure M1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N1763Click(Sender: TObject);
  private
    Login: TFrmLogin;
    procedure SendLoginUser(sAccount, sPassword: string);
    procedure DecodeMessagePacket(sData: string);
    procedure LoginSucces(sData: string);
    procedure CheckAccount(Code: Byte);
    procedure RegLoginOK(Code: Integer;sData: string);
    procedure RegM2OK(Code: Integer;sData: string);
    procedure RegM2RegDateUPdateOK(Code: Integer; sData: string);
    procedure GetChangePass(Msg:TDefaultMessage; sData: string);
    procedure GetLoginFail(Code: Integer);
    procedure GetVersion();
    //procedure GetVersionNum(nData: Integer);
  public
    procedure SendSocket(Socket: TCustomWinSocket; sSendMsg: string);
    procedure SendAddAccount(ue: TUserEntry1; is176: Boolean);
    procedure SendAddRegM2Account(ue: TM2UserEntry; is176: Boolean);
    procedure SendCheckAccount(sAccount: string);
    procedure SendCheckRegM2Account(sAccount: string);
    procedure SendChangePass(sAccount,OldPass,NewPass: string);
    procedure SendM2DateUpdata(sAccount, sM2Type: string; is176: Boolean);
  end;
var
  FrmMain: TFrmMain;

implementation

uses Share, HUtil32, RegLogin, PassWord, About, ERecord, RegM2, UpRegM2Date;

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  LabelUserName.Caption := '';
  LabelName.Caption := '';
  LabelMoney.Caption := '￥0';
  LabelAllMoney.Caption := '￥0';
  LabelAddrs.Caption := '';
  LabelTime.Caption := '2000-00-00 00:00:00';
  GetVersion();
end;

procedure TFrmMain.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  g_sRecvMsg := '';
  g_sRecvGameMsg := '';
  g_boBusy := False;
  StatusPaneMsg.Panels[0].Text := '服务器连接成功...';
  StatusPaneMsg.Panels[0].Text := '正在登陆...';
  g_boConnect := True;
  SendLoginUser(g_sAccount, g_sPassword);
end;

procedure TFrmMain.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  StatusPaneMsg.Panels[0].Text := '服务器连接断开...';
  g_boConnect := False;
  g_boLogined := False;
 // g_MySelf.boLogined := False;
  if Login <> nil then begin
    Login.BtnLogin.Enabled := True;
    Login.ComboBoxUser.Enabled := True;
    Login.EdtPass.Enabled := True;
  end;
  if FrmRegLogin <> nil then begin
    Application.MessageBox('和服务器已经断开了连接,请重新登陆', '错误', MB_OK + MB_ICONSTOP);
    FrmRegLogin.Close;
  end;
  //Caption := g_sCaption;
end;

procedure TFrmMain.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  if Login <> nil then begin
  Login.BtnLogin.Enabled := True;
  Login.ComboBoxUser.Enabled := True;
  Login.EdtPass.Enabled := True;
  end;
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmMain.SendSocket(Socket: TCustomWinSocket; sSendMsg: string);
const
  btCode: Byte = 1;
var
  sSendText: string;
begin
  if Socket.Connected then begin
    sSendText := '#' + IntToStr(btCode) + sSendMsg + '!';
    Inc(btCode);
    if btCode >= 10 then btCode := 1;
    while True do begin
      if Socket.SendText (sSendText) <> -1 then Break;
    end;
  end;
end;
procedure TFrmMain.DecodeTimerTimer(Sender: TObject);
var
  sData: string;
begin
  if g_boBusy then Exit;
  g_boBusy := True;
  try
    g_sRecvGameMsg := g_sRecvGameMsg + g_sRecvMsg;
    g_sRecvMsg := '';
    if g_sRecvGameMsg <> '' then begin
      while Pos('!', g_sRecvGameMsg) > 0 do begin
        if Pos('!', g_sRecvGameMsg) <= 0 then Break;
        g_sRecvGameMsg := ArrestStringEx(g_sRecvGameMsg, '#', '!', sData);
        if sData = '' then Break;
        DecodeMessagePacket(sData);
        if Pos('!', g_sRecvGameMsg) <= 0 then Break;
      end;
    end;
  finally
    g_boBusy := False;
  end;
end;

procedure TFrmMain.DecodeMessagePacket(sData: string);
var
  nDataLen: Integer;
  sDataMsg, sDefMsg: string;
  DefMsg: TDefaultMessage;
begin
  nDataLen := Length(sData);
  if (nDataLen >= DEFBLOCKSIZE) then begin
    sDefMsg := Copy(sData, 1, DEFBLOCKSIZE);
    sDataMsg := Copy(sData, DEFBLOCKSIZE + 1, Length(sData) - DEFBLOCKSIZE);
    DefMsg := DecodeMessage(sDefMsg);
    case DefMsg.Ident of
      SM_LOGIN_FAIL: GetLoginFail(DefMsg.Recog); //登陆失败
      SM_LOGIN_SUCCESS: begin
        LoginSucces(sDataMsg);//登陆成功
        //GetVersionNum(DefMsg.Recog);//比较版本号 20090830
      end;
      SM_GETUSER_SUCCESS,
      SM_GETM2USER_SUCCESS: CheckAccount(DefMsg.Recog);//检测用户是否存在
      SM_ADDUSER_SUCCESS,
       SM_ADDUSER_FAIL: RegLoginOK(DefMsg.Recog, sDataMsg);//登陆器注册成功,失败
      SM_ADDM2USER_SUCCESS,
      SM_ADDM2USER_FAIL: RegM2OK(DefMsg.Recog, sDataMsg);//引擎注册成功,失败
      SM_CHANGEPASS_SUCCESS,
       SM_CHANGEPASS_FAIL: GetChangePass(DefMsg, sDataMsg); //修改密码
      SM_UPDATEM2USERREGDATE_SUCCESS,
        SM_UPDATEM2USERREGDATE_FAIL: RegM2RegDateUPdateOK(DefMsg.Recog, sDataMsg);//引擎延期
    end;
  end;
end;

procedure TFrmMain.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  g_sRecvMsg := g_sRecvMsg + Socket.ReceiveText;
end;

procedure TFrmMain.LoginSucces(sData: string);
begin
  FillChar(g_MySelf, SizeOf(TDLUserInfo), #0);
  DecryptBuffer(sData, @g_MySelf, SizeOf(TDLUserInfo));
  LabelUserName.Caption := g_MySelf.sAccount;
  LabelName.Caption := g_MySelf.sName;
  LabelMoney.Caption := '￥'+CurrToStr(g_MySelf.CurYuE);
  LabelAllMoney.Caption := '￥'+CurrToStr(g_MySelf.CurXiaoShouE);
  LabelAddrs.Caption := g_MySelf.SAddrs;
  LabelTime.Caption := FormatDateTime('yyyy-mm-dd hh:nn:ss',g_MySelf.dTimer);
  StatusPaneMsg.Panels[0].Text := '登陆成功...';
  g_boLogined := True;
  Login.Free;
  Login := nil;
end;

procedure TFrmMain.ClientSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  StatusPaneMsg.Panels[0].Text := '正在连接服务器...';
end;

procedure TFrmMain.FormActivate(Sender: TObject);
begin
  if g_boConnect then Exit;
  Login := TFrmLogin.Create(Application);
  Login.Caption := '登录';
end;

procedure TFrmMain.MEMU_CENECT_USERNAMEClick(Sender: TObject);
begin
  if g_boLogined then begin
    FrmRegLogin := TFrmRegLogin.Create(Application);
    if Sender = MEMU_CENECT_USERNAME then begin
      FrmRegLogin.Open(False);
    end else begin
      FrmRegLogin.Open(True);
    end;
    FrmRegLogin.Free;
  end;
end;

procedure TFrmMain.SendLoginUser(sAccount, sPassword: string);
//取计算机名称及当前用户名
function sdf:string;
var
  lpName:pchar;
  lpSize:DWord;
begin
  lpSize:=255;
  getmem(lpName,255);
  GetComputerName(lpName,lpSize);
  Result:=trim(lpName);
end;
var
  DefMsg: TDefaultMessage;
  sVersionNum: string;
begin
  Decode(g_sVersionNum, sVersionNum);
  DefMsg := MakeDefaultMsg(GM_LOGIN, 0, 0, 0, 0);
  SendSocket(ClientSocket.Socket, EncodeMessage(DefMsg) + EncryptString(sAccount + '/' + sPassword + '/' + sVersionNum + '/' + sdf));//20080709
end;

procedure TFrmMain.SendAddAccount(ue: TUserEntry1; is176: Boolean);
var
  Msg: TDefaultMessage;
begin
  if is176 then begin
    Msg := MakeDefaultMsg(GM_ADDUSER, 0, 0, 0, 1);
  end else begin
    Msg := MakeDefaultMsg(GM_ADDUSER, 0, 0, 0, 0);
  end;
  SendSocket(ClientSocket.Socket, EncodeMessage(Msg) + EncryptBuffer(@ue, SizeOf(TUserEntry1)));
end;

procedure TFrmMain.SendAddRegM2Account(ue: TM2UserEntry; is176: Boolean);
var
  Msg: TDefaultMessage;
begin
  if is176 then begin
    Msg := MakeDefaultMsg(GM_ADDM2USER, 0, 0, 0, 1);
  end else Msg := MakeDefaultMsg(GM_ADDM2USER, 0, 0, 0, 0);
  SendSocket(ClientSocket.Socket, EncodeMessage(Msg) + EncryptBuffer(@ue, SizeOf(TM2UserEntry)));
end;

procedure TFrmMain.SendCheckAccount(sAccount: string);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(GM_GETUSER, 0, 0, 0, 0);
  SendSocket(ClientSocket.Socket, EncodeMessage(DefMsg) + EncryptString(sAccount));//20080709
end;

procedure TFrmMain.SendCheckRegM2Account(sAccount: string);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(GM_GETM2USER, 0, 0, 0, 0);
  SendSocket(ClientSocket.Socket, EncodeMessage(DefMsg) + EncryptString(sAccount));//20080709
end;

procedure TFrmMain.CheckAccount(Code: Byte);
begin
  if code = 0 then begin
    Application.MessageBox('此帐号已存在，请换其他帐号。', '提示', MB_OK + 
      MB_ICONINFORMATION);
  end else
  if Code = 1 then begin
    Application.MessageBox('此帐号可以正常注册。', '提示', MB_OK + 
      MB_ICONINFORMATION);
  end else begin
    Application.MessageBox('系统出现未知错误，请联系管理员！', '提示', MB_OK + 
      MB_ICONSTOP);
  end;
end;

procedure TFrmMain.RegLoginOK(Code: Integer; sData: string);
var
  sDest: string;
  sAccont, sPass, sKey, sYuE, sXiaoShouE: string;
  str: string;
begin
  case Code of
    1: begin
      sDest := DecryptString(sData);
      sDest := GetValidStr3(sDest, sAccont, ['/']);
      sDest := GetValidStr3(sDest, sPass, ['/']);
      sDest := GetvalidStr3(sDest, sKey, ['/']);
      sXiaoShouE := GetvalidStr3(sDest, sYuE, ['/']);
      Str := {'尊敬的用户：欢迎购买3K科技登陆器,您正在代理人 ' + g_MySelf.sAccount + ' 处购买我们产品,' + #13 + #10 +
             '请尽快修改此密码,请好好保存以下资料,如果代理人有任何问题请联系QQ357001001 进行投诉.' + #13 + #10 +}
             '尊敬的用户：欢迎购买3K登陆器'  + #13 + #10 +
             '请到www.3Km2.com下载商业配置器。' + #13 + #10 +
             '保管好你的登陆器帐号、密码、密钥，丢失自行负责,请尽快修改此密码' + #13 + #10 +
             '' + #13 + #10 +
             '用户登陆帐号：' + sAccont + #13 + #10 +
             '用户登陆密码：' + sPass + #13 + #10 +
             '用户密钥：' + sKey + #13 + #10 + #13 + #10 +
             '配置教程：video.3Km2.com';
      Clipbrd.Clipboard.AsText := str ;
      LabelMoney.Caption := '￥'+sYuE;//注册成功更新金额 20080831
      LabelAllMoney.Caption := '￥'+sXiaoShouE;//注册成功更新金额 20080831
      Application.MessageBox(PChar('注册成功！' + #13 + '已经帮您复制了以下内容，请发给用户(Ctrl + V)' + #10 + Str), '提示', MB_OK +
        MB_ICONINFORMATION);
      FrmRegLogin.Close;
    end;
    2: begin
      Application.MessageBox('请你登陆以后在操作！', '错误', MB_OK + MB_ICONSTOP);
    end;
    3: begin
      Application.MessageBox('你要注册的登陆帐号已存在,请注册其他登陆帐号！','错误', MB_OK + MB_ICONSTOP);
    end;
    else begin
      Application.MessageBox(PChar('发生未知错误 代码:'+IntToStr(Code)), '错误', MB_OK + MB_ICONSTOP);
    end;
  end;
end;

procedure TFrmMain.RegM2OK(Code: Integer; sData: string);
var
  sDest: string;
  sAccont, sPass, sYuE, sXiaoShouE: string;
  str: string;
begin
  case Code of
    1: begin
      sDest := DecryptString(sData);
      sDest := GetValidStr3(sDest, sAccont, ['/']);
      sDest := GetValidStr3(sDest, sPass, ['/']);
      sXiaoShouE := GetvalidStr3(sDest, sYuE, ['/']);
      Str := '尊敬的用户：欢迎购买3K引擎'  + #13 + #10 +
             '请到www.3KM2.com下载引擎客户配置器。' + #13 + #10 +
             '保管好你的登陆器帐号、密码，丢失自行负责,请尽快修改此密码' + #13 + #10 +
             '' + #13 + #10 +
             '用户登陆帐号：' + sAccont + #13 + #10 +
             '用户登陆密码：' + sPass ;
      Clipbrd.Clipboard.AsText := str ;
      LabelMoney.Caption := '￥'+sYuE;//注册成功更新金额 20080831
      LabelAllMoney.Caption := '￥'+sXiaoShouE;//注册成功更新金额 20080831
      Application.MessageBox(PChar('注册成功！' + #13 + '已经帮您复制了以下内容，请发给用户(Ctrl + V)' + #10 + Str), '提示', MB_OK +
        MB_ICONINFORMATION);
      FrmRegM2.Close;
    end;
    2: begin
      Application.MessageBox('请你登陆以后在操作！', '错误', MB_OK + MB_ICONSTOP);
    end;
    3: begin
      Application.MessageBox('你要注册的登陆帐号已存在,请注册其他登陆帐号！','错误', MB_OK + MB_ICONSTOP);
    end;
    6: begin
      Application.MessageBox('你要注册的硬件信息有误！','错误', MB_OK + MB_ICONSTOP);
    end;
    else begin
      Application.MessageBox(PChar('发生未知错误 代码:'+IntToStr(Code)), '错误', MB_OK + MB_ICONSTOP);
    end;
  end;  
end;

procedure TFrmMain.RegM2RegDateUPdateOK(Code: Integer; sData: string);
var
  sDest, sYuE, sXiaoShouE: string;
begin
  case Code of
    1: begin
      sDest := DecryptString(sData);
      sXiaoShouE := GetvalidStr3(sDest, sYuE, ['/']);
      LabelMoney.Caption := '￥'+sYuE;//注册成功更新金额
      LabelAllMoney.Caption := '￥'+sXiaoShouE;//注册成功更新金额
      Application.MessageBox(PChar('引擎延期成功！' + #13 + '请重新生成引擎注册文件！'), '提示', MB_OK +
        MB_ICONINFORMATION);
      UpRegM2DateFrm.Close;
    end;
    2: begin
      Application.MessageBox('请你登陆以后在操作！', '错误', MB_OK + MB_ICONSTOP);
      UpRegM2DateFrm.StatusBar1.Panels[0].Text :='';
    end;
    7: begin
      Application.MessageBox('引擎用户不存在或用户类型有误','错误', MB_OK + MB_ICONSTOP);
      UpRegM2DateFrm.StatusBar1.Panels[0].Text :='';
    end;
    8: begin
      Application.MessageBox('引擎用户类型有误！','错误', MB_OK + MB_ICONSTOP);
      UpRegM2DateFrm.StatusBar1.Panels[0].Text :='';
    end;
    9: begin
      Application.MessageBox('余额不足！','错误', MB_OK + MB_ICONSTOP);
      UpRegM2DateFrm.StatusBar1.Panels[0].Text :='';
    end
    else begin
      Application.MessageBox(PChar('发生未知错误 代码:'+IntToStr(Code)), '错误', MB_OK + MB_ICONSTOP);
      UpRegM2DateFrm.StatusBar1.Panels[0].Text :='';
    end;    
  end;
end;

procedure TFrmMain.X1Click(Sender: TObject);
begin
  if g_boLogined then begin
    FrmPassWord := TFrmPassWord.Create(Application);
    FrmPassWord.Open();
    FrmPassWord.Free;
  end;
end;

procedure TFrmMain.SendChangePass(sAccount, OldPass, NewPass: string);
var
  DefMsg: TDefaultMessage;
begin
  DefMsg := MakeDefaultMsg(GM_CHANGEPASS, 0, 0, 0, 0);
  SendSocket(ClientSocket.Socket, EncodeMessage(DefMsg) + EncryptString(sAccount + '/' + OldPass + '/' + NewPass));//20080709
end;

procedure TFrmMain.SendM2DateUpdata(sAccount, sM2Type: string; is176: Boolean);
var
  DefMsg: TDefaultMessage;
begin
  if is176 then begin
    DefMsg := MakeDefaultMsg(GM_UPDATEM2USERREGDATE, 0, 0, 0, 1);
  end else DefMsg := MakeDefaultMsg(GM_UPDATEM2USERREGDATE, 0, 0, 0, 0);
  SendSocket(ClientSocket.Socket, EncodeMessage(DefMsg) + EncryptString(sAccount + '/' + sM2Type));
end;

procedure TFrmMain.GetChangePass(Msg: TDefaultMessage; sData: string);
begin
  if Msg.Ident = SM_CHANGEPASS_SUCCESS then begin
     Application.MessageBox('密码修改成功！', '提示', MB_OK + MB_ICONINFORMATION);
     FrmPassWord.Close;
  end else begin
    case Msg.Recog of
      -1: FrmPassWord.StatusBar1.Panels[0].Text := '请你登陆以后在操作！';
      -2: FrmPassWord.StatusBar1.Panels[0].Text := '你的登陆帐号错误！';
      -3: FrmPassWord.StatusBar1.Panels[0].Text := '原密码不正确！';
      -4: FrmPassWord.StatusBar1.Panels[0].Text := '系统未知错误 Code:'+IntToStr(Msg.Recog);
    end;
  end;
  FrmPassWord.BtnChange.Enabled := True;
end;

procedure TFrmMain.MENU_CONTROL_EXITClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.MENU_CONTROL_REFLOGINClick(Sender: TObject);
begin
  if Login = nil then begin
    g_boConnect := False;
    g_boLogined := False;
    Login := TFrmLogin.Create(nil);
    with Login do begin
      StatusPaneMsg.Panels[0].Text := '重新连接服务器...';
      Login.Update;
      Caption := '登录';
      BtnLogin.Enabled := True;
      ComboBoxUser.Enabled := True;
      EdtPass.Enabled := True;
      Label1.Visible :=True;
      label2.Visible :=True;
    end;
  end;
end;

procedure TFrmMain.MENU_HELP_ABOUTClick(Sender: TObject);
begin
  FrmAbout.Open();
end;

procedure TFrmMain.GetLoginFail(Code: Integer);
begin
  case Code of
    0: StatusPaneMsg.Panels[0].Text := '用户名或密码错误'; //登陆失败
    1: Application.MessageBox('你的帐号已经在服务器上登陆了！', 'Error', MB_OK + MB_ICONWARNING);
    2: begin
      Application.MessageBox('你使用的代理配置器是旧版本，请与管理员联系！', '提示', MB_OK + MB_ICONSTOP);
      Application.Terminate;
    end;
    3: begin
      Application.MessageBox('你正在非绑定的机器使用代理配置器！', 'Error', MB_OK + MB_ICONWARNING);
      Application.Terminate;
    end;
  end;
  if Login <> nil then begin
   Login.BtnLogin.Enabled := True;
   Login.ComboBoxUser.Enabled := True;
   Login.EdtPass.Enabled := True;
  end;
end;

procedure TFrmMain.N1763Click(Sender: TObject);
begin
  if g_boLogined then begin
    UpRegM2DateFrm := TUpRegM2DateFrm.Create(Application);
    try
      if Sender = N5 then begin
        UpRegM2DateFrm.Open(False);
      end else begin
        UpRegM2DateFrm.Open(True);
      end;
    finally
      UpRegM2DateFrm.Free;
    end;
  end;
end;

procedure TFrmMain.N2Click(Sender: TObject);
begin
  //if g_boLogined then begin
    FrmRecord := TFrmRecord.Create(Application);
    FrmRecord.Open;
    FrmRecord.Free;
  //end;
end;

procedure TFrmMain.N5Click(Sender: TObject);
begin
  if g_boLogined then begin
    UpRegM2DateFrm := TUpRegM2DateFrm.Create(Application);
    try
      if Sender = N5 then begin
        UpRegM2DateFrm.Open(False);
      end else begin
        UpRegM2DateFrm.Open(True);
      end;
    finally
      UpRegM2DateFrm.Free;
    end;
  end;
end;

//访问指定网站文本,如果为特殊指令,则在M2上显示相关信息 20081018
procedure TFrmMain.GetVersion();
(*//字符串加解密函数 20080217
Function SetDate(Text: String): String;
Var
 I: Word;
 C: Word;
Begin
asm
  db $EB,$10,'VMProtect begin',0
end;
  Result := '';
  For I := 1 To Length(Text) Do
    Begin
      C := Ord(Text[I]);
      Result := Result + Chr((C Xor 12));
    End;
asm
  db $EB,$0E,'VMProtect end',0
end;
End;
var
  sRemoteAddress: string;
  IdHTTP: TIdHTTP;
  s: TStringlist;
  sEngineVersion, str0, Str1: string;
  sStr, str2, str3, str4, str5, str6, str7, str8, str9, str10: string; *)
begin
(*asm
  db $EB,$10,'VMProtect begin',0
end;
  sRemoteAddress := '';
  Decode(_sProductAddress,sRemoteAddress);//指定网站上的文件
  if sRemoteAddress = '' then Exit;
  Try
    IdHTTP := TIdHTTP.Create(nil);
    IdHTTP.ReadTimeout := 3000;
    S := TStringlist.Create;
    Try
      S.Text := IdHTTP.Get(sRemoteAddress);
      sEngineVersion := SetDate(Trim(S.Strings[0]));//取第一行的指令
      Str1:= SetDate(_sProductAddress1);
      str0:= Trim(S.Strings[1]);
    finally
      S.Free;
      IdHTTP.Free;
    end;
    if CompareText(sEngineVersion, Str1) = 0  then begin//判断是否为指定的指令(www.92m2.com.cn)
      if str0 <> '' then begin
        sStr := GetValidStr3(str0, str2, ['|']);
        sStr := GetValidStr3(sStr, str3, ['|']);
        sStr := GetValidStr3(sStr, str4, ['|']);
        sStr := GetValidStr3(sStr, str5, ['|']);
        sStr := GetValidStr3(sStr, str6, ['|']);
        sStr := GetValidStr3(sStr, str7, ['|']);
        sStr := GetValidStr3(sStr, str8, ['|']);
        sStr := GetValidStr3(sStr, str9, ['|']);
        sStr := GetValidStr3(sStr, str10, ['|']);
        Application.MessageBox(PChar(str2 + #13#10 +str3+ #13#10 +
                              str4+ #13#10 +str5+ #13#10 +str6+ #13#10 +
                              str7+ #13#10 +str8+ #13#10 +str9+ #13#10 +
                              str10
        ), '提示', MB_OK + MB_ICONINFORMATION);
      end;
    end;
  except
    //MainOutMessasge('{异常} GetProductAddress', 0);
  end;
asm
  db $EB,$0E,'VMProtect end',0
end; *)
end;

procedure TFrmMain.M1Click(Sender: TObject);
begin
  if g_boLogined then begin
    FrmRegM2 := TFrmRegM2.Create(Application);
    if Sender = M1 then begin
      FrmRegM2.Open(False);
    end else begin
      FrmRegM2.Open(True);
    end;
    FrmRegM2.Free;
  end;
end;

{procedure TFrmMain.GetVersionNum(nData: Integer);
var
  sVersionNum: string;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
    try
      Decode(g_sVersionNum, sVersionNum);
      if nData > StrToInt(sVersionNum) then begin
        Application.MessageBox('您使用的代理配置器是旧版本，请与管理员联系！', '提示', MB_OK + MB_ICONSTOP);
        Application.Terminate;
      end;
    except
    end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end; }

end.
