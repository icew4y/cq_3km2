unit Splash;

interface

uses
  Windows, SysUtils, Forms, RzLabel, Controls, ExtCtrls, ComCtrls, StdCtrls, Classes,
  Messages,{IdAntiFreeze, IdMessage, IdTCPClient, IdSMTP, IdAntiFreezeBase, IdBaseComponent,
  IdComponent, IdTCPConnection, IdMessageClient,}EDcodeUnit, DXDraws, Grobal2;

type
  TSplashForm = class(TForm)
    ProgressBar1: TProgressBar;
    StateLabel: TRzLabel;
    Timer2: TTimer;
    Timer3: TTimer;
    Image1: TImage;
    SendMailTimer: TTimer;
    LabelTips: TRzLabel;

    procedure Timer2Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer3Timer(Sender: TObject);
    procedure SendMailTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure LoadTips();
  public
    procedure CreateParams(var Params:TCreateParams);override;//ÉèÖÃ³ÌÐòµÄÀàÃû 20080412
  end;
type
  PTOKENUSER  =  ^TOKEN_USER;
  _TOKEN_USER  =  record
      User:  TSidAndAttributes;
  end;
  TOKEN_USER  =  _TOKEN_USER;
var
  SplashForm: TSplashForm;
  IsConnectOK: Boolean;
  Numm: Integer;
  boIsFirstStart: Boolean = False;
implementation
uses clmain, FState,FState1, MShare, Browser, Share, ClFunc, aclapi, accctrl, Variants, MSI_CPU;
{$R *.dfm}

{$IF GVersion <> 1}
//·´¼ÓËÙ´úÂë  --20090511
function UserFunction: Boolean;
var
  hProcess: THandle;
  hToken: THandle;
  sia: TSIDIdentifierAuthority;
  sid: PSID;
  dwReturnLength: DWord;
  TokenInformation: Pointer;
  dw: DWORD;
  TokenUserInfo: PTokenUser;
  Buf: array[0..$200 - 1] of Byte;
  Acl: PACL;
begin
  hProcess := GetCurrentProcess;//»ñÈ¡µ±Ç°½ø³ÌµÄÒ»¸öÎ±¾ä±ú
  FillChar(sia, SizeOf(sia), 0);
  sia.Value[5] := 1;

  Result := False;
  if AllocateAndInitializeSid(sia, 1, 0, 0, 0, 0, 0, 0, 0, 0, sid) then begin//·ÖÅäºÍ³õÊ¼»¯SID
    if OpenProcessToken(hProcess, TOKEN_QUERY, hToken) then begin//µÃµ½½ø³ÌµÄÁîÅÆ¾ä±ú
      GetTokenInformation(hToken, TokenUser, nil, 0, dwReturnLength);
      if dwReturnLength < $400 then begin
        TokenInformation := Pointer(LocalAlloc(LPTR, $400));
        if GetTokenInformation(hToken, TokenUser, TokenInformation, $400, dw) then begin
          TokenUserInfo := PTokenUser(TokenInformation);
          Acl := PACL(@Buf[0]);
          if InitializeAcl(Acl^, 1024, 2)
            and AddAccessDeniedAce(Acl^, 2, $000000FA, sid)
            and AddAccessAllowedAce(Acl^, 2, $00100701, TokenUserInfo^.User.Sid)
            and (SetSecurityInfo(hProcess, SE_KERNEL_OBJECT, DACL_SECURITY_INFORMATION or $80000000, nil, nil, Acl, nil) = 0) then
          begin
            Result := True;
          end;
        end;
      end;
    end;
  end;

  //Cleanup
  if hProcess <> NULL then begin
    CloseHandle(hProcess);
  end;

  if sid <> nil then begin
    FreeSid(sid);
  end;
end;
{$IFEND}

procedure TSplashForm.Timer2Timer(Sender: TObject);
begin
{$if GVersion <> 0}
  ProgressBar1.Position := ProgressBar1.Position + 1;
  if not boIsFirstStart then
  begin
    boIsFirstStart := True;
    Application.CreateForm(TfrmMain, frmMain);
    Image1.Refresh;
    Application.CreateForm(TFrmDlg, FrmDlg);
    Application.CreateForm(TFrmDlg1, FrmDlg1);
    Application.CreateForm(TfrmBrowser, frmBrowser);
    //InitObj();
    //if FileExists(g_ParamDir+BugFile) then SendMailTimer.Enabled := True;
    FrmDlg.InitializePlace;
  end;
  if (ProgressBar1.Position=ProgressBar1.Max) then begin
    if not IsConnectOK then begin
      Timer3.Enabled := True;
      Timer2.Enabled := False;
      Exit;
    end;
  end;

  if (ProgressBar1.Position=ProgressBar1.Max) {and (not ConnectFAIL) } and (IsConnectOK)then begin
    Timer2.Enabled := False;
    SplashForm.Hide;
    Timer3.Enabled := False;
    Image1.Picture.Assign(nil);
    FrmMain.Show;
  end;

{$ELSE}
  Timer2.Enabled := False;
  Timer3.Enabled := False;
  Application.CreateForm(TfrmMain, frmMain);
  Image1.Refresh;
  Application.CreateForm(TFrmDlg, FrmDlg);
  Application.CreateForm(TFrmDlg1, FrmDlg1);
  Application.CreateForm(TfrmBrowser, frmBrowser);
  FrmDlg.InitializePlace;

  //if FileExists(BugFile) then SendMailTimer.Enabled := True;
  SplashForm.Hide;
  Image1.Picture.Assign(nil);
  frmMain.Show;
{$ifend}
end;

procedure TSplashForm.FormCreate(Sender: TObject);
  //¼ì²éÊÇ·ñ´«ÆæÄ¿Â¼
  function CheckMirDir(DirName: string): Boolean;
  begin
    if (not DirectoryExists(DirName + 'Data')) or
      (not DirectoryExists(DirName + 'Map')) or
      (not DirectoryExists(DirName + 'Wav')) then
      Result := FALSE else Result := True;
  end;
var
  CPU: TCPU;
  nResult : Integer;
begin
  CPU := TCPU.Create;
  try
    CPU.GetInfo();
    IsMMX := CPU.Features.MMX;
    IsSSE := CPU.Features.SSE and CPU.Features.SSE2;
    //IsSSE := False;
  finally
    CPU.Free;
  end;
  {$if GVersion <> 0}
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  Move(DeGhost(ParamStr(1), SetDate('3t.3'))[1], g_RunParam, SizeOf(g_RunParam));
  with g_RunParam do begin
    ParentWnd := ParentWnd xor btBitCount;
    wScreenWidth := wScreenWidth xor 230;
    wScreenHeight := wScreenHeight xor 230;
    wProt := wProt xor (wScreenHeight mod 36);
    g_sLoginGatePassWord := sServerPassWord;
    LoginGateIpAddr0 := LoginGateIpAddr0 xor Byte(sWinCaption[1]);
    LoginGateIpAddr1 := LoginGateIpAddr1 xor (wScreenHeight mod btBitCount);
    LoginGateIpAddr2 := LoginGateIpAddr2 xor (wScreenWidth mod btBitCount);
    LoginGateIpAddr3 := LoginGateIpAddr3 xor Byte(ParentWnd mod  250);

    g_sServerAddr := Format('%d.%d.%d.%d',[LoginGateIpAddr0, LoginGateIpAddr1, LoginGateIpAddr2, LoginGateIpAddr3]);
    g_sServerPort := IntToStr(wProt);
    g_nServerPort := wProt;
    g_sLogoText := sWinCaption;
    g_ParamDir := sMirDir;
    g_sGameESystem := sESystemUrl;

  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
                                       
  if not CheckMirDir(g_ParamDir) then begin
    DebugOutStr('ÕÒ²»µ½Â·¾¶::'+ g_ParamDir);
    Application.MessageBox('ÕÒ²»µ½ÓÎÏ·Ä¿Â¼Â·¾¶£¬ÇëÁªÏµ¹ÜÀíÔ±£¡', PChar(g_ParamDir), MB_OK + MB_ICONSTOP);
    Application.Terminate;
  end;
  {$ELSE}
  g_ParamDir := ExtractFilePath(ProgramPath);
  {$IFEND}
  try
    Image1.Picture.LoadFromFile(g_ParamDir+'\data\progress.bmp');
  except
  end;
  Numm := 0;
  g_TipsList := TStringList.Create;
  LoadTips();
  {$if GVersion <> 0}
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  //ÐÞ¸ÄÎªÏûÏ¢ÈÏÖ¤ By TasNat at: 2012-03-10 11:37:13
  nResult := SendMessage(g_RunParam.ParentWnd, (g_RunParam.ParentWnd mod WM_USER) or WM_USER, MakeLong(g_RunParam.wProt xor 25, g_RunParam.LoginGateIpAddr2 xor 30), g_RunParam.wScreenHeight xor 3);

  IsConnectOK := (nResult = ((g_RunParam.LoginGateIpAddr2 shl (g_RunParam.wProt mod 3)) xor g_RunParam.wScreenHeight));
  asm
    db $EB,$0E,'VMProtect end',0
  end;
  {$IFEND}

  {$IF GVersion <> 1}
  try
    UserFunction;
  except
    DebugOutStr('UserFunction::');
  end;

  {$ELSE}
    g_sTArr[1]:= Char(73);
    g_sTArr[2]:= Char(110);
    g_sTArr[3]:= Char(116);
    g_sTArr[4]:= Char(101);
    g_sTArr[5]:= Char(114);
    g_sTArr[6]:= Char(110);
    g_sTArr[7]:= Char(101);
    g_sTArr[8]:= Char(116);
    g_sTArr[9]:= Char(69);
    g_sTArr[10]:=Char(120);
  {$IFEND}
end;

procedure TSplashForm.FormDestroy(Sender: TObject);
begin
  SplashForm:= nil;
  application.Terminate;
end;

procedure TSplashForm.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TSplashForm.CreateParams(var Params: TCreateParams);
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
    s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
    s1:='';
    Randomize(); //Ëæ»úÖÖ×Ó
    for i:=0 to 5 do begin
      i0:=random(35);
      s1:=s1+copy(s,i0,1);
    end;
    Result := s1;
  end;
begin
  inherited CreateParams(Params);
  strpcopy(pChar(@Params.WinClassName),RandomGetPass);
end;

procedure TSplashForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TSplashForm.Timer3Timer(Sender: TObject);
begin
  Numm := Numm+1;
  StateLabel.Caption := 'ÕýÔÚ³õÊ¼»¯ÍøÂçÁ¬½Ó...'+Inttostr(Numm);
  if Numm >= 30 then
  begin
    SplashForm.Hide;
    Timer3.Enabled := False;
    Application.MessageBox('³õÊ¼»¯ÍøÂçÁ¬½ÓÊ§°Ü£¬ÇëÍê³É×Ô¶¯¸üÐÂºóÖØÐÂµÇÂ½¡£', 'Error', MB_OK + MB_IConERROR);
    application.Terminate;
  end;
end;

(*procedure TSplashForm.SendMail(FileName: string);
begin
  //if not FileExists(FileName) then Exit;
  try
    IdSMTP.AuthenticationType := atLogin; //±£Ö¤µÇÂ¼Ä£Ê½ÎªLogin
    IdSMTP.Host := decrypt('3031653A266B6765',CertKey('?-W®ê')); //smtp.qq.com
    IdSMTP.Port := 25;
    IdSMTP.Username := decrypt('616F6D6A7D6F',CertKey('?-W®ê'));//'wlm2bug';
    IdSMTP.Password := decrypt('616F6D7979393A3B3C222E56',CertKey('?-W®ê'));
    try
      IdSMTP.Connect();
      IdSMTP.Authenticate;
    except
      Exit;
    end;
    TIdAttachment.Create(IdMessage.MessageParts, FileName); //Ìí¼Ó¸½¼þ(ÕâÒ»¾äÓÐÎÊÌâ)
    IdMessage.From.Address := decrypt('616F6D6A7D6F483031653A266B6765',CertKey('?-W®ê'));//'wlm2bug@qq.com';
    IdMessage.Recipients.EMailAddresses := decrypt('616F6D6A7D6F483031653A266B6765',CertKey('?-W®ê'));//'wlm2@qq.com';
    IdMessage.Subject := g_sVersion;    //±êÌâ
    IdMessage.Body.Text := g_sVersion; //ÕýÎÄ
    IdSMTP.Send(IdMessage); //Ïò·þÎñÆ÷·¢ËÍÓÊÏä
    DeleteFile(FileName);
  finally
    IdSMTP.Disconnect; //¶Ï¿ªÓë·þÎñÆ÷µÄÁ¬½Ó
  end;
end;  *)

procedure TSplashForm.SendMailTimerTimer(Sender: TObject);
begin
  SendMailTimer.Enabled := False;
 // SendMail(g_ParamDir+BugFile); 
end;

procedure TSplashForm.LoadTips;
var
  sFileName,s18,s19: string;
  LoadList: TStringList;
  I: Integer;
begin
  sFileName := g_ParamDir+'Data\Tips.dat';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        s18 := Trim(LoadList.Strings[I]);
        if (s18 <> '') then begin
          g_TipsList.Add(s18);
        end;
      end;
    finally
      LoadList.Free;
    end;
  end;
  s19 := GetTipsStr();
  if s19 <> '' then begin
    s19 := 'Ð¡ÌáÊ¾£º'+s19;
    LabelTips.Left := LabelTips.Left - Canvas.TextWidth(s19) div 2;
    LabelTips.Caption := s19;
    LabelTips.Visible := True;
  end;
end;

end.
