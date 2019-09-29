unit Splash;

interface
//{$Region '天龙印'}
uses
  Windows, Messages, SysUtils, Forms, RzLabel, Controls, ExtCtrls, ComCtrls, Classes,
  Dialogs, EDcodeUnit, StdCtrls;

type

  TSplashForm = class(TForm)
    ProgressBar1: TProgressBar;
    StateLabel: TRzLabel;
    Timer2: TTimer;
    Timer3: TTimer;
    Image1: TImage;
    LabelTips: TRzLabel;

    procedure Timer2Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer3Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure LoadTips();
  public
    procedure CreateParams(var Params:TCreateParams);override;//设置程序的类名 20080412
  end;



var
  SplashForm: TSplashForm;
  IsConnectOK: Boolean;
  Numm: Integer;
  boIsFirstStart: Boolean = False;

implementation

uses clmain, MShare, FState,  Share, ClFunc, aclapi, accctrl, Variants, Browser;
{$R *.dfm}

{$IF GVersion <> 1}
//反加速代码  --20090511
function UserFunction: Boolean;
var
  hProcess: THandle;
  hToken: THandle;
  sia: TSIDIdentifierAuthority;
  sid: PSID;
  dwReturnLength: DWord;
  TokenInformation: Pointer;
  dw: DWORD;
  TokenUserInfo: PSIDAndAttributes;
  Buf: array[0..$200 - 1] of Byte;
  Acl: PACL;
begin

  hProcess := GetCurrentProcess;//获取当前进程的一个伪句柄
  FillChar(sia, SizeOf(sia), 0);
  sia.Value[5] := 1;
  Result := False;
  if AllocateAndInitializeSid(sia, 1, 0, 0, 0, 0, 0, 0, 0, 0, sid) then begin//分配和初始化SID
    if OpenProcessToken(hProcess, TOKEN_QUERY, hToken) then begin//得到进程的令牌句柄
      GetTokenInformation(hToken, TokenUser, nil, 0, dwReturnLength);
      if dwReturnLength < $400 then begin
        TokenInformation := Pointer(LocalAlloc(LPTR, $400));
        if GetTokenInformation(hToken, TokenUser, TokenInformation, $400, dw) then begin
          TokenUserInfo := PSIDAndAttributes(TokenInformation);
          Acl := PACL(@Buf[0]);
          if InitializeAcl(Acl^, 1024, 2)
            and AddAccessDeniedAce(Acl^, 2, $000000FA, sid)
            and AddAccessAllowedAce(Acl^, 2, $00100701, TokenUserInfo^.Sid)
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

  procedure DeleteMainForm;
  var
    AppMainForm:Pointer;
  begin
    AppMainForm:=@Application.MainForm;
    TForm(AppMainForm^):=nil;
    Application.MainFormOnTaskbar :=True;
  end;

begin
{$if GVersion <> 0}
  ProgressBar1.Position := ProgressBar1.Position + 1;
  if not boIsFirstStart then begin
    boIsFirstStart := True;

    Image1.Refresh;
  end;
  if (ProgressBar1.Position=ProgressBar1.Max) then begin
    if not IsConnectOK then begin
      Timer3.Enabled := True;
      Timer2.Enabled := False;
      Exit;
    end;
  end;

  if (ProgressBar1.Position=ProgressBar1.Max) {and (not ConnectFAIL) } and (IsConnectOK)then
  begin
    Timer2.Enabled := False;
    Timer3.Enabled := False;
    SplashForm.Hide;
    Image1.Picture.Assign(nil);
    DeleteMainForm;
    Application.CreateForm(TfrmMain, frmMain);
    FrmMain.Show;
    SplashForm.Free;
  end;
{$ELSE}
  Timer2.Enabled := False;
  Timer3.Enabled := False;
  DeleteMainForm;
  Application.CreateForm(TfrmMain, frmMain);
  Image1.Refresh;

  //if FileExists(BugFile) then SendMailTimer.Enabled := True;
  SplashForm.Hide;
  Image1.Picture.Assign(nil);
  frmMain.Show;
{$ifend}
end;

procedure TSplashForm.FormCreate(Sender: TObject);

  //检查是否传奇目录
var
  nResult : Integer;
  function CheckMirDir(DirName: string): Boolean;
  begin
    if (not DirectoryExists(DirName + 'Data')) or
      (not DirectoryExists(DirName + 'Map')) or
      (not DirectoryExists(DirName + 'Wav')) then
      Result := FALSE else Result := True;
  end;

begin
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
    g_D3DConfig.wScreenWidth := wScreenWidth;
    g_D3DConfig.wScreenHeight := wScreenHeight;
    g_D3DConfig.btBitCount := btBitCount;
    g_sGameESystem := sESystemUrl;
    g_D3DConfig.boFullScreen := boFullScreen;
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;

  if not CheckMirDir(g_ParamDir) then begin
    DebugOutStr('找不到路径::'+ g_ParamDir);
    Application.MessageBox('找不到游戏目录路径，请联系管理员！', PChar(g_ParamDir), MB_OK + MB_ICONSTOP);
    Application.Terminate;
  end;
  {$ELSE}
  g_ParamDir := ExtractFilePath(ProgramPath);
  {$IFEND}
  //ExtractInfo(ProgramPath, g_RecInfo);//读出自身的信息
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
  //修改为消息认证 By TasNat at: 2012-03-10 11:37:13
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
  //application.Terminate;
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
    Randomize(); //随机种子
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
  StateLabel.Caption := '正在初始化网络连接...'+Inttostr(Numm);
  if Numm >= 30 then begin
    SplashForm.Hide;
    Timer3.Enabled := False;
    Application.MessageBox('初始化网络连接失败，请完成自动更新后重新登陆。', 'Error', MB_OK + MB_IConERROR);
    Application.Terminate;
  end;
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
    LabelTips.Left := LabelTips.Left - Canvas.TextWidth('小提示：'+s19) div 2;
    LabelTips.Caption := '小提示：'+s19;
    LabelTips.Visible := True;
  end;
end;

end.
