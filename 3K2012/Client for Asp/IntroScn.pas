unit IntroScn;//游戏的引导场景，，比如选人,注册，，登录等,,与游戏的主场景构成游戏的整个场景
//一般场景定义
interface

uses
  Windows, SysUtils, Classes, Graphics, StdCtrls, Controls, Forms, Dialogs,
  extctrls, AbstractCanvas, AbstractTextures, AsphyreTextureFonts, FState,
  Grobal2, SoundUtil, HUtil32;


const
   SELECTEDFRAME = 16;//selected frame 选人时点了左边或右边的角色此时会有人物动画，有16帧
   //打开ChrSel.wil,,可以看到男54是40-55,,
   FREEZEFRAME = 13;//freeze frame 男54,,60-72,,共13帧

type
   TLoginState = (lsLogin, lsNewid, lsNewidRetry, lsChgpw, lsCloseAll);
   TSceneType = (stIntro, stLogin, stSelectCountry, stSelectChr, stNewChr, stLoading,
                   stLoginNotice, stPlayGame);
   TSelChar = record
      Valid: Boolean;
      UserChr: TUserCharacterInfo;
      Selected: Boolean;
      FreezeState: Boolean; //TRUE:倔篮惑怕 FALSE:踌篮惑怕
      Unfreezing: Boolean; //踌绊 乐绰 惑怕牢啊?
      Freezing: Boolean;  //倔绊 乐绰 惑怕?
      AniIndex: integer;  //踌绰(绢绰) 局聪皋捞记
      DarkLevel: integer;
      EffIndex: integer;  //瓤苞 局聪皋捞记
      StartTime: longword;
      moretime: longword;
      startefftime: longword;
   end;

   TScene = class
   private
   public
      SceneType: TSceneType;
      constructor Create (scenetype: TSceneType);
      destructor Destroy; override;
      procedure Initialize; dynamic;
      procedure Finalize; dynamic;
      procedure OpenScene; dynamic;
      procedure CloseScene; dynamic;
      procedure OpeningScene; dynamic;
      procedure KeyPress (var Key: Char); dynamic;
      procedure KeyDown (var Key: Word; Shift: TShiftState); dynamic;
      procedure MouseMove (Shift: TShiftState; X, Y: Integer); dynamic;
      procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); dynamic;
      procedure PlayScene (MSurface: TAsphyreCanvas); virtual; abstract;
   end;

   TIntroScene = class (TScene)
   private
   public
      constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TAsphyreCanvas); override;
   end;

   TLoginScene = class (TScene)
   private

//建立新ID对话框(新用户对话框)
     m_EdNewId        :TEdit;
     m_EdNewPasswd    :TEdit;
     m_EdConfirm      :TEdit;
     m_EdYourName     :TEdit;
     m_EdSSNo         :TEdit;
     m_EdBirthDay     :TEdit;
     m_EdQuiz1        :TEdit;//密码提示问题1
     m_EdAnswer1      :TEdit;
     m_EdQuiz2        :TEdit;
     m_EdAnswer2      :TEdit;
     m_EdPhone        :TEdit;
     m_EdMobPhone     :TEdit;
     m_EdEMail        :TEdit;
//密码修改
     m_EdChgId        :TEdit;
     m_EdChgCurrentpw :TEdit;
     m_EdChgNewPw     :TEdit;
     m_EdChgRepeat    :TEdit;
     m_nCurFrame      :Integer;
     m_nMaxFrame      :Integer;
    // m_dwStartTime    :LongWord;  //茄 橇贰烙寸 矫埃
     m_boNowOpening   :Boolean;
     m_boOpenFirst    :Boolean;
     m_NewIdRetryUE   :TUserEntry;//UE:user entry info ,,grobal2中定义的那个结构
     m_NewIdRetryAdd  :TUserEntryAdd;
(*{******************************************************************************}
//仿盛大输入界面 拦截消息  20080315
     EdIdOldWnd: TWndMethod;
     EdPasswdOldWnd: TWndMethod;
{******************************************************************************}  *)
     //procedure EdLoginIdKeyPress (Sender: TObject; var Key: Char);
     //procedure EdLoginPasswdKeyPress (Sender: TObject; var Key: Char);
     procedure EdNewIdKeyPress (Sender: TObject; var Key: Char);
     procedure EdNewOnEnter (Sender: TObject);
     function  CheckUserEntrys: Boolean;
     function  NewIdCheckNewId: Boolean;
     function  NewIdCheckBirthDay: Boolean;
(*{******************************************************************************}
//仿盛大输入界面 拦截消息  20080315
     procedure EdIdWnd(var message: TMessage);
     procedure EdPasswdWnd(var message: TMessage);
{******************************************************************************} *)

   public
   //登录对话框
   //  m_EdId           :TEdit; //用户名输入框
   //  m_EdPasswd       :TEdit; //密码输入框

     m_sLoginId            :String;
     m_sLoginPasswd        :String;
     m_boUpdateAccountMode :Boolean;
      constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TAsphyreCanvas); override;
      procedure ChangeLoginState (state: TLoginState);
      procedure NewClick;
      procedure NewIdRetry (boupdate: Boolean);
      procedure UpdateAccountInfos (ue: TUserEntry);
      procedure OkClick;
      procedure ChgPwClick;
      procedure NewAccountOk;
      procedure NewAccountClose;
      procedure ChgpwOk;
      procedure ChgpwCancel;
      procedure HideLoginBox; //验证通过，，隐藏登录对话框
      procedure OpenLoginDoor;//开门
      procedure PassWdFail;
   end;

   TSelectChrScene = class (TScene)
   private
      SoundTimer: TTimer;
      //CreateChrMode: Boolean;
      EdChrName: TEdit;
      procedure SoundOnTimer (Sender: TObject);
      procedure MakeNewChar (index: integer);
      procedure EdChrnameKeyPress (Sender: TObject; var Key: Char);
   public
      NewIndex: integer;
      ChrArr: array[0..1] of TSelChar;
      constructor Create;
      destructor Destroy; override;
      procedure OpenScene; override;
      procedure CloseScene; override;
      procedure PlayScene (MSurface: TAsphyreCanvas); override;
      procedure SelChrSelect1Click;
      procedure SelChrSelect2Click;
      procedure SelChrStartClick;
      procedure SelChrNewChrClick;
      procedure SelChrEraseChrClick;
      procedure SelChrCreditsClick;
      procedure SelChrExitClick;
      procedure SelChrNewClose;
      procedure SelChrNewJob (job: integer);
      procedure SelChrNewm_btSex (sex: integer);
      procedure SelChrNewPrevHair;
      procedure SelChrNewNextHair;
      procedure SelChrNewOk;
      procedure ClearChrs;
      procedure AddChr (uname: string; job, hair, level, sex: integer);
      procedure SelectChr (index: integer);
   end;

   TLoginNotice = class (TScene)
   private
   public
     dwOpenTick : DWord; //打开的时间 By TasNat at: 2012-04-19 11:13:36
      constructor Create;
      destructor Destroy; override;
      procedure PlayScene (MSurface: TAsphyreCanvas); override;
   end;


implementation

uses
   ClMain, MShare, Share;


constructor TScene.Create (scenetype: TSceneType);
begin
   SceneType := scenetype;
end;

procedure TScene.Initialize;
begin
end;

procedure TScene.Finalize;
begin
end;

procedure TScene.OpenScene;
begin
   ;
end;

procedure TScene.CloseScene;
begin
   ;
end;

procedure TScene.OpeningScene;
begin
end;

procedure TScene.KeyPress (var Key: Char);
begin
end;

procedure TScene.KeyDown (var Key: Word; Shift: TShiftState);
begin
end;

procedure TScene.MouseMove (Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TScene.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end;

{procedure TScene.PlayScene (MSurface: TAsphyreCanvas);
begin
   ;
end;  }


{------------------- TIntroScene ----------------------}

//游戏介绍场景（这里没有内容），一般用来播放片头动画
constructor TIntroScene.Create;
begin
   inherited Create (stIntro);
end;

destructor TIntroScene.Destroy;
begin
   inherited Destroy;
end;

procedure TIntroScene.OpenScene;
begin
end;

procedure TIntroScene.CloseScene;
begin
end;

procedure TIntroScene.PlayScene (MSurface: TAsphyreCanvas);
var
  d: TAsphyreLockableTexture;
begin
  d := g_TasUiImages.Images[18];
  if d = nil then
  d := g_WChrSelImages.Images[22];
  if d <> nil then begin
     MSurface.Draw ((g_D3DConfig.wScreenWidth - 800) div 2, (g_D3DConfig.wScreenHeight - 600) div 2, d.ClientRect, d, FALSE);
  end;
end;


{--------------------- Login ----------------------}

//登录场景
constructor TLoginScene.Create;
var
   nx, ny: integer;
begin
   inherited Create (stLogin);
  //登陆ID输入框
//ID和密码输入框不是DDraw下的ctl,,而是StdCtrls,,,文件开头的include中有
 {  m_EdId := TEdit.Create (FrmMain.Owner);
   with m_EdId do begin
      Parent := FrmMain;
      Color  := clBlack;
      Font.Charset := DEFAULT_CHARSET;
      Font.Color := clWhite;
      Font.Height := -12;
      Font.Name := 'Courier New';
      MaxLength := 10;
      BorderStyle := bsNone;
      OnKeyPress := EdLoginIdKeyPress;
      Visible := FALSE;
      Tag := 10;
   end;
//密码输入框
   m_EdPasswd := TEdit.Create (FrmMain.Owner);
   with m_EdPasswd do begin
      Parent := FrmMain; Color  := clBlack; Font.Size := 10; MaxLength := 10; Font.Color := clWhite;
      BorderStyle := bsNone;
      PasswordChar := '*';
      OnKeyPress := EdLoginPasswdKeyPress;
      Visible := FALSE;
      Tag := 10;
   end;       }
(*{******************************************************************************}
//仿盛大输入界面 拦截消息  20080315
  EdIdOldWnd := m_EdId.WindowProc;
  EdPasswdOldWnd := m_EdPasswd.WindowProc;
  m_EdId.WindowProc := EdIdWnd;
  m_EdPasswd.WindowProc := EdPasswdWnd;
{******************************************************************************} *)
   nx := g_D3DConfig.wScreenWidth div 2 - 320 {192}{79};
   ny := g_D3DConfig.wScreenHeight div 2 - 238{146}{64};
   
   m_EdNewId := TEdit.Create (FrmMain.Owner);
   with m_EdNewId do begin
      Parent := FrmMain;//父窗口为frmmain
//整个工程中有二窗口,,frmmain和fstate,,,frmmain uses了fstate,,frmmain为启动窗体
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 116;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);

      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;


   m_EdNewPasswd := TEdit.Create (FrmMain.Owner);
   with m_EdNewPasswd do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 137;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      PasswordChar := '*'; Visible := FALSE;  OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;

   m_EdConfirm := TEdit.Create (FrmMain.Owner);
   with m_EdConfirm do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 158;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone; Color := clBlack; Font.Color := clWhite; MaxLength := 10;
      PasswordChar := '*';  Visible := FALSE;  OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdYourName := TEdit.Create (FrmMain.Owner);
   with m_EdYourName do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 187;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      Tag := 11;
   end;
   m_EdSSNo := TEdit.Create (FrmMain.Owner);
   with m_EdSSNo do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 207;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 14;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      Tag := 11;
   end;
   m_EdBirthDay := TEdit.Create (FrmMain.Owner);
   with m_EdBirthDay do begin
      Parent := FrmMain; Height := 16; Width  := 116; Left := nx + 161; Top  := ny + 227;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 10;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      Tag := 11;
   end;
   m_EdQuiz1 := TEdit.Create (FrmMain.Owner);
   with m_EdQuiz1 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 256;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      Tag := 11;
   end;

   m_EdAnswer1 := TEdit.Create (FrmMain.Owner);
   with m_EdAnswer1 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 276;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 12;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      Tag := 11;
   end;
   m_EdQuiz2 := TEdit.Create (FrmMain.Owner);
   with m_EdQuiz2 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 297;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 20;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      Tag := 11;
   end;
   m_EdAnswer2 := TEdit.Create (FrmMain.Owner);
   with m_EdAnswer2 do begin
      Parent := FrmMain;  Height := 16; Width  := 163; Left := nx + 161; Top  := ny + 317;
      BorderStyle := bsNone; Color  := clBlack; Font.Color := clWhite; MaxLength := 12;
      Visible := FALSE; OnKeyPress := EdNewIdKeyPress; OnEnter := EdNewOnEnter;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      Tag := 11;
   end;
   m_EdPhone := TEdit.Create (FrmMain.Owner);
   with m_EdPhone do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 347;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone;
      Color  := clBlack;
      Font.Color := clWhite;
      MaxLength := 14;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdMobPhone := TEdit.Create (FrmMain.Owner);
   with m_EdMobPhone do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 368;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone;
      Color  := clBlack;
      Font.Color := clWhite;
      MaxLength := 13;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;
   m_EdEMail := TEdit.Create (FrmMain.Owner);
   with m_EdEMail do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 116;
      Left := nx + 161;
      Top  := ny + 388;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 40;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 11;
   end;

   nx := g_D3DConfig.wScreenWidth div 2 - 210 {192}{192};
   ny := g_D3DConfig.wScreenHeight div 2 - 150{146}{150};
   m_EdChgId := TEdit.Create (FrmMain.Owner);
   with m_EdChgId do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+117;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgCurrentpw := TEdit.Create (FrmMain.Owner);
   with m_EdChgCurrentpw do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+149;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgNewPw := TEdit.Create (FrmMain.Owner);
   with m_EdChgNewPw do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+176;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
   m_EdChgRepeat := TEdit.Create (FrmMain.Owner);
   with m_EdChgRepeat do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      Left := nx+239;
      Top  := ny+208;
      Left := Left - ((g_D3DConfig.wScreenWidth - 800) div 2);
      Top := Top - ((g_D3DConfig.wScreenHeight - 600) div 2);
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      MaxLength := 10;
      PasswordChar := '*';
      Visible := FALSE;
      OnKeyPress := EdNewIdKeyPress;
      OnEnter := EdNewOnEnter;
      Tag := 12;
   end;
end;

destructor TLoginScene.Destroy;
begin
   inherited Destroy;
end;
(*{******************************************************************************}
//仿盛大输入界面 拦截消息  20080315
procedure TLoginScene.EdIdWnd(var message: TMessage);
begin
  case message.Msg of
  WM_LBUTTONDBLCLK:;  //双击鼠标左键
  WM_RBUTTONDOWN:;    //按下鼠标右键
  WM_MOUSEMOVE:;     //鼠标移动
  WM_LBUTTONDOWN:m_EdId.SetFocus;  //鼠标左键按下
  WM_SETFOCUS:          //获得焦点
  begin
    EdIdOldWnd(message);
    m_EdId.SelStart:=Length(m_EdId.Text);
    m_EdId.SelLength:=0;
  end
  else
    EdIdOldWnd(message);
  end;
end;   

procedure TLoginScene.EdPasswdWnd(var message: TMessage);
begin
  case message.Msg of
  WM_LBUTTONDBLCLK:;  //双击鼠标左键
  WM_RBUTTONDOWN:;    //按下鼠标右键
  WM_MOUSEMOVE:;     //鼠标移动
  WM_LBUTTONDOWN:m_EdPasswd.SetFocus;  //鼠标左键按下
  WM_SETFOCUS:          //获得焦点
  begin
    EdPasswdOldWnd(message);
    m_EdPasswd.SelStart:=Length(m_EdPasswd.Text);
    m_EdPasswd.SelLength:=0;
  end
  else
    EdPasswdOldWnd(message);
  end;
end;   *)
{******************************************************************************}

procedure TLoginScene.OpenScene;
begin
   
   m_nCurFrame := 0;
   m_nMaxFrame := 10;
   m_sLoginId := '';
   m_sLoginPasswd := '';

 (*  with m_EdId do begin
      Left   := g_D3DConfig.wScreenWidth div 2 - 68 + 18 + 25{350};
      Top    := g_D3DConfig.wScreenHeight div 2 - 8 -34 -42{259};
      Height := 16;
      Width  := 137;
      Visible := FALSE;
   end;
   with m_EdPasswd do begin
      Left   := g_D3DConfig.wScreenWidth div 2 - 68 + 18 + 25{350};
      Top    := g_D3DConfig.wScreenHeight div 2  - 8 - 34 - 10{291};
      Height := 16;
      Width  := 137;
      Visible := FALSE;
   end;     *)
   m_boOpenFirst := TRUE;

   FrmDlg.DLogin.Visible := TRUE;
   FrmDlg.DNewAccount.Visible := FALSE;
   m_boNowOpening := FALSE;
   //PlayBGM (bmg_intro);    20080521

end;

procedure TLoginScene.CloseScene;
begin
  // m_EdId.Visible := FALSE;
   //m_EdPasswd.Visible := FALSE;
   FrmDlg.DLogin.Visible := FALSE;
   SilenceSound;
end;

{procedure TLoginScene.EdLoginIdKeyPress (Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin
      Key := #0;
      m_sLoginId := LowerCase(m_EdId.Text);
      if m_sLoginId <> '' then begin
         m_EdPasswd.SetFocus;
      end;
   end;  
end; }

{procedure TLoginScene.EdLoginPasswdKeyPress (Sender: TObject; var Key: Char);
begin
   if (Key = '~') or (Key = '''') then Key := '_';
   if Key = #13 then begin
      Key := #0;
      m_sLoginId := LowerCase(m_EdId.Text);
      m_sLoginPasswd := m_EdPasswd.Text;
      if (m_sLoginId <> '') and (m_sLoginPasswd <> '') then begin
         //发送到服务器验证密码
         FrmMain.SendLogin (m_sLoginId, m_sLoginPasswd);
         m_EdId.Text := '';
         m_EdPasswd.Text := '';
         m_EdId.Visible := FALSE;
         m_EdPasswd.Visible := FALSE;
      end else
         if (m_EdId.Visible) and (m_EdId.Text = '') then m_EdId.SetFocus;
   end;     
end;   }

procedure TLoginScene.PassWdFail;
begin
  //m_EdId.Visible := TRUE;
  //m_EdPasswd.Visible := TRUE;
  FrmDlg.m_EdId.SetFocus;
end;


function  TLoginScene.NewIdCheckNewId: Boolean;
begin
   Result := TRUE;
   m_EdNewId.Text := Trim(m_EdNewId.Text);
   if Length(m_EdNewId.Text) < 3 then begin
      FrmDlg.DMessageDlg ('你的ID必须至少有4个字符且不能有空格。再输入一遍吧。', [mbOk]);
      Beep;
      m_EdNewId.SetFocus;
      Result := FALSE;
   end;
end;

function  TLoginScene.NewIdCheckBirthDay: Boolean;
var
   str, syear, smon, sday: string;
   ayear, amon, aday: integer;
   flag: Boolean;
begin
   Result := TRUE;
   flag := TRUE;
   str := m_EdBirthDay.Text;
   str := GetValidStr3 (str, syear, ['/']);
   str := GetValidStr3 (str, smon, ['/']);
   str := GetValidStr3 (str, sday, ['/']);
   ayear := Str_ToInt(syear, 0);
   amon := Str_ToInt(smon, 0);
   aday := Str_ToInt(sday, 0);
   if (ayear <= 1890) or (ayear > 2101) then flag := FALSE;
   if (amon <= 0) or (amon > 12) then flag := FALSE;
   if (aday <= 0) or (aday > 31) then flag := FALSE;
   if not flag then begin
      Beep;
      m_EdBirthDay.SetFocus;
      Result := FALSE;
   end;
end;


procedure TLoginScene.EdNewIdKeyPress (Sender: TObject; var Key: Char);
begin
   if (Sender = m_EdNewPasswd) or (Sender = m_EdChgNewPw) or (Sender = m_EdChgRepeat) then
      if (Key = '~') or (Key = '''') or (Key = ' ') then Key := #0;
   if Key = #13 then begin
      Key := #0;
      if Sender = m_EdNewId then begin
         if not NewIdCheckNewId then
            exit;
      end;
      if Sender = m_EdNewPasswd then begin
         if Length(m_EdNewPasswd.Text) < 4 then begin
            FrmDlg.DMessageDlg ('密码长度必须大于 4位.', [mbOk]);
            Beep;
            m_EdNewPasswd.SetFocus;
            exit;
         end;
      end;
      if Sender = m_EdConfirm then begin
         if m_EdNewPasswd.Text <> m_EdConfirm.Text then begin
            FrmDlg.DMessageDlg ('二次输入的密码不一至！！！', [mbOk]);
            Beep;
            m_EdConfirm.SetFocus;
            exit;
         end;
      end;
      if (Sender = m_EdYourName) or (Sender = m_EdQuiz1) or (Sender = m_EdAnswer1) or
         (Sender = m_EdQuiz2) or (Sender = m_EdAnswer2) or (Sender = m_EdPhone) or
         (Sender = m_EdMobPhone) or (Sender = m_EdEMail)
      then begin
         TEdit(Sender).Text := Trim(TEdit(Sender).Text);
         if TEdit(Sender).Text = '' then begin
            Beep;
            TEdit(Sender).SetFocus;
            exit;
         end;
      end;
      if Sender = m_EdBirthDay then begin
         if not NewIdCheckBirthDay then
            exit;
      end;
      if TEdit(Sender).Text <> '' then begin
         if Sender = m_EdNewId then m_EdNewPasswd.SetFocus;
         if Sender = m_EdNewPasswd then m_EdConfirm.SetFocus;
         if Sender = m_EdConfirm then m_EdYourName.SetFocus;
         if Sender = m_EdYourName then m_EdSSNo.SetFocus;
         if Sender = m_EdSSNo then m_EdBirthDay.SetFocus;
         if Sender = m_EdBirthDay then m_EdQuiz1.SetFocus;
         if Sender = m_EdQuiz1 then m_EdAnswer1.SetFocus;
         if Sender = m_EdAnswer1 then m_EdQuiz2.SetFocus;
         if Sender = m_EdQuiz2 then m_EdAnswer2.SetFocus;
         if Sender = m_EdAnswer2 then m_EdPhone.SetFocus;
         if Sender = m_EdPhone then m_EdMobPhone.SetFocus;
         if Sender = m_EdMobPhone then m_EdEMail.SetFocus;
         if Sender = m_EdEMail then begin
            if m_EdNewId.Enabled then m_EdNewId.SetFocus
            else if m_EdNewPasswd.Enabled then m_EdNewPasswd.SetFocus;
         end;

         if Sender = m_EdChgId then m_EdChgCurrentpw.SetFocus;
         if Sender = m_EdChgCurrentpw then m_EdChgNewPw.SetFocus;
         if Sender = m_EdChgNewPw then m_EdChgRepeat.SetFocus;
         if Sender = m_EdChgRepeat then m_EdChgId.SetFocus;
      end;
   end;
end;

procedure TLoginScene.EdNewOnEnter (Sender: TObject);
begin
   //腮飘
   FrmDlg.NAHelps.Clear;
   if Sender = m_EdNewId then begin
      FrmDlg.NAHelps.Add ('你的ID可以是以下内容的组合');
      FrmDlg.NAHelps.Add ('字符和数字.');
      FrmDlg.NAHelps.Add ('ID必须至少有4位.');
      FrmDlg.NAHelps.Add ('你输入的名字是你游戏中角色的名字');
      FrmDlg.NAHelps.Add ('请仔细选择你的ID');
      FrmDlg.NAHelps.Add ('你的登陆名可以');
      FrmDlg.NAHelps.Add ('用于我们所有的服务器.');
      FrmDlg.NAHelps.Add ('');
      FrmDlg.NAHelps.Add ('我建议你用一个不同的名字');
      FrmDlg.NAHelps.Add('和你想给游戏角色用的那个');
      FrmDlg.NAHelps.Add('区别开来.');
   end;
   if Sender = m_EdNewPasswd then begin
      FrmDlg.NAHelps.Add('你的密码可以是一个');
      FrmDlg.NAHelps.Add('组合，包括字符和数字，而且');
      FrmDlg.NAHelps.Add('它至少要有4位');
      FrmDlg.NAHelps.Add('把你的密码记住是玩');
      FrmDlg.NAHelps.Add('我们的游戏的最基本的要素');
      FrmDlg.NAHelps.Add('所以请确认你已经记好了它.');
      FrmDlg.NAHelps.Add('我们建议你最好不要用');
      FrmDlg.NAHelps.Add('一个简单的密码');
      FrmDlg.NAHelps.Add('已消除一些');
      FrmDlg.NAHelps.Add('不安定的因素');
   end;
   if Sender = m_EdConfirm then begin
      FrmDlg.NAHelps.Add('再次输入密码');
      FrmDlg.NAHelps.Add('以便确认.');
   end;
   if Sender = m_EdYourName then begin
      FrmDlg.NAHelps.Add('键入你的全名.');
   end;
   if Sender = m_EdSSNo then begin
      FrmDlg.NAHelps.Add('寸脚狼 林刮殿废锅龋甫 涝仿窍绞');
      FrmDlg.NAHelps.Add('矫坷. 抗) 720101-146720');
   end;
   if Sender = m_EdBirthDay then begin
      FrmDlg.NAHelps.Add('请键入你的出生日期和月份');
      FrmDlg.NAHelps.Add('年/月/日 1977/10/15');
   end;
   if (Sender = m_EdQuiz1) or (Sender = m_EdQuiz2) then begin
      FrmDlg.NAHelps.Add('请输入一个密码提示问题');
      FrmDlg.NAHelps.Add('请明确只有你本人才知道这个问题.');
   end;
   if (Sender = m_EdAnswer1) or (Sender = m_EdAnswer2) then begin
      FrmDlg.NAHelps.Add('请输入上面问题的');
      FrmDlg.NAHelps.Add('答案.');
   end;
   if (Sender=m_EdYourName) or (Sender=m_EdSSNo) or (Sender=m_EdQuiz1) or (Sender=m_EdQuiz2) or (Sender=m_EdAnswer1) or (Sender=m_EdAnswer2) then begin
      FrmDlg.NAHelps.Add('你必须输入正确');
      FrmDlg.NAHelps.Add('的信息');
      FrmDlg.NAHelps.Add('如果使用可错误的信息.');
      FrmDlg.NAHelps.Add('');
      FrmDlg.NAHelps.Add('你将不能接受');
      FrmDlg.NAHelps.Add('我们所有的服务');
      FrmDlg.NAHelps.Add('如果你提供了');
      FrmDlg.NAHelps.Add('错误信息，你的帐户 ');
      FrmDlg.NAHelps.Add('将被取消');
   end;

   if Sender = m_EdPhone then begin
      FrmDlg.NAHelps.Add('请键入你的电话');
      FrmDlg.NAHelps.Add('号码.');
   end;
   if Sender = m_EdMobPhone then begin
      FrmDlg.NAHelps.Add('请键入你的手机号码.');
   end;
   if Sender = m_EdEMail then begin
      FrmDlg.NAHelps.Add('请键入你的邮件地址，你的邮件 ');
      FrmDlg.NAHelps.Add('将被用于访问我们的一些服务器.');
      FrmDlg.NAHelps.Add('你能收到最近更新的一些信息');
   end;
end;

procedure TLoginScene.HideLoginBox;
begin
   ChangeLoginState (lsCloseAll);
end;

procedure TLoginScene.OpenLoginDoor;
begin
   m_boNowOpening := TRUE;        
  // m_dwStartTime := GetTickCount;
   HideLoginBox;
   PlaySound (s_rock_door_open);
end;

procedure TLoginScene.PlayScene (MSurface: TAsphyreCanvas);
var
   d: TAsphyreLockableTexture;
begin
   if m_boOpenFirst then begin
      m_boOpenFirst := FALSE;
      FrmDlg.m_EdId.SetFocus;
      {m_EdId.Visible := TRUE;
      m_EdPasswd.Visible := TRUE;
      m_EdId.SetFocus; }
      
   end;  
   //优先考虑GM定义的皮肤文件 By TasNat at: 2012-04-15 13:46:46
   d := g_TasUiImages.Images[20];
   if d = nil then
     d := g_WChrSelImages.Images[22];
   if d <> nil then begin
      MSurface.Draw ((g_D3DConfig.wScreenWidth - 800) div 2, (g_D3DConfig.wScreenHeight - 600) div 2, d.ClientRect, d, FALSE);
   end;  
   if m_boNowOpening then begin
//开门速度
      //if GetTickCount - m_dwStartTime > 1 then begin
         //m_dwStartTime := GetTickCount;
         Inc (m_nCurFrame);
      //end;


      if m_nCurFrame >= m_nMaxFrame-1 then begin
         m_nCurFrame := m_nMaxFrame-1;
         if not g_boDoFadeOut and not g_boDoFadeIn then begin
            g_boDoFadeOut := TRUE;
            g_boDoFadeIn := TRUE;
            g_nFadeIndex := 29;
         end;
      end;
      //优先考虑GM定义的皮肤文件 By TasNat at: 2012-04-15 13:46:46
      d := g_TasUiImages.Images[21 + m_nCurFrame];
      if d = nil then
        d := g_WChrSelImages.Images[103 + m_nCurFrame-80];

      if d <> nil then
         MSurface.Draw ((g_D3DConfig.wScreenWidth - d.Width) div 2, (g_D3DConfig.wScreenHeight - d.Height) div 2, d.ClientRect, d, TRUE);

      if g_boDoFadeOut then begin
         if g_nFadeIndex <= 1 then begin
            g_WMainImages.ClearCache;
            g_WChrSelImages.ClearCache;
            DScreen.ChangeScene (stSelectChr); //
         end;
      end;
   end; 
end;

procedure TLoginScene.ChangeLoginState (state: TLoginState);
var
   i, focus: integer;
   c: TControl;
begin
   focus := -1;
   case state of
      lsLogin: focus := 10;
      lsNewIdRetry, lsNewId: focus := 11;
      lsChgpw: focus := 12;
      lsCloseAll: focus := -1;
   end;
   with FrmMain do begin  //login
      if ControlCount > 0 then //20080629
      for i:=0 to ControlCount-1 do begin
         c := Controls[i];
         if c is TEdit then begin
            if c.Tag in [11..12] then begin
               if c.Tag = focus then begin
                  c.Visible := TRUE;
                  TEdit(c).Text := '';
               end else begin
                  c.Visible := FALSE;
                  TEdit(c).Text := '';
               end;
            end;
         end;
      end;
      m_EdSSNo.Visible := FALSE;

      case state of
         lsLogin:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := TRUE;
               if FrmDlg.m_EdId.Visible then FrmDlg.m_EdId.SetFocus;
            end;
         lsNewIdRetry,
         lsNewId:
            begin
               if m_boUpdateAccountMode then
                  m_EdNewId.Enabled := FALSE
               else
                  m_EdNewId.Enabled := TRUE;
               FrmDlg.DNewAccount.Visible := TRUE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := FALSE;
               if m_EdNewId.Visible and m_EdNewId.Enabled then begin
                  m_EdNewId.SetFocus;
               end else begin
                  if m_EdConfirm.Visible and m_EdConfirm.Enabled then
                     m_EdConfirm.SetFocus;
               end;
            end;
         lsChgpw:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := TRUE;
               FrmDlg.DLogin.Visible := FALSE;
               if m_EdChgId.Visible then m_EdChgId.SetFocus;
            end;
         lsCloseAll:
            begin
               FrmDlg.DNewAccount.Visible := FALSE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := FALSE;
            end;
      end;
   end;
end;

procedure TLoginScene.NewClick;
begin
   m_boUpdateAccountMode := FALSE;
   FrmDlg.NewAccountTitle := '';
   ChangeLoginState (lsNewId);
                  m_EdNewId.Enabled := TRUE;
               FrmDlg.DNewAccount.Visible := TRUE;
               FrmDlg.DChgPw.Visible := FALSE;
               FrmDlg.DLogin.Visible := FALSE;
               if m_EdNewId.Visible and m_EdNewId.Enabled then begin
                  m_EdNewId.SetFocus;
               end else begin
                  if m_EdConfirm.Visible and m_EdConfirm.Enabled then
                     m_EdConfirm.SetFocus;
               end;
end;

procedure TLoginScene.NewIdRetry (boupdate: Boolean);
begin
   m_boUpdateAccountMode := boupdate;
   ChangeLoginState (lsNewidRetry);
   m_EdNewId.Text     := m_NewIdRetryUE.sAccount;
   m_EdNewPasswd.Text := m_NewIdRetryUE.sPassword;
   m_EdYourName.Text  := m_NewIdRetryUE.sUserName;
   m_EdSSNo.Text      := m_NewIdRetryUE.sSSNo;
   m_EdQuiz1.Text     := m_NewIdRetryUE.sQuiz;
   m_EdAnswer1.Text   := m_NewIdRetryUE.sAnswer;
   m_EdPhone.Text     := m_NewIdRetryUE.sPhone;
   m_EdEMail.Text     := m_NewIdRetryUE.sEMail;
   m_EdQuiz2.Text     := m_NewIdRetryAdd.sQuiz2;
   m_EdAnswer2.Text   := m_NewIdRetryAdd.sAnswer2;
   m_EdMobPhone.Text  := m_NewIdRetryAdd.sMobilePhone;
   m_EdBirthDay.Text  := m_NewIdRetryAdd.sBirthDay;
end;

procedure TLoginScene.UpdateAccountInfos (ue: TUserEntry);
begin
   m_NewIdRetryUE := ue;
   FillChar (m_NewIdRetryAdd, sizeof(TUserEntryAdd), #0);
   m_boUpdateAccountMode := TRUE; //扁粮俊 乐绰 沥焊甫 犁涝仿窍绰 版快
   NewIdRetry (TRUE);
   FrmDlg.NewAccountTitle := '(请填写帐号相关信息。)';
end;

procedure TLoginScene.OkClick;
var
   key: char;
begin
   key := #13;
   //EdLoginPasswdKeyPress (self, key);
   FrmDlg.m_EdPasswdKeyPress(FrmDlg.m_EdPasswd, key);
end;

procedure TLoginScene.ChgPwClick;
begin
   ChangeLoginState (lsChgPw);
end;

function  TLoginScene.CheckUserEntrys: Boolean;
begin
   Result := FALSE;
   m_EdNewId.Text := Trim(m_EdNewId.Text);
   m_EdQuiz1.Text := Trim(m_EdQuiz1.Text);
   m_EdYourName.Text := Trim(m_EdYourName.Text);
   if not NewIdCheckNewId then exit;

   if not NewIdCheckBirthday then exit;
   if Length(m_EdNewId.Text) < 3 then begin
      m_EdNewId.SetFocus;
      exit;
   end;
   if Length(m_EdNewPasswd.Text) < 3 then begin
      m_EdNewPasswd.SetFocus;
      exit;
   end;
   if m_EdNewPasswd.Text <> m_EdConfirm.Text then begin
      m_EdConfirm.SetFocus;
      exit;
   end;
   if Length(m_EdQuiz1.Text) < 1 then begin
      m_EdQuiz1.SetFocus;
      exit;
   end;
   if Length(m_EdAnswer1.Text) < 1 then begin
      m_EdAnswer1.SetFocus;
      exit;
   end;
   if Length(m_EdQuiz2.Text) < 1 then begin
      m_EdQuiz2.SetFocus;
      exit;
   end;
   if Length(m_EdAnswer2.Text) < 1 then begin
      m_EdAnswer2.SetFocus;
      exit;
   end;
   if Length(m_EdYourName.Text) < 1 then begin
      m_EdYourName.SetFocus;
      exit;
   end;
   Result := TRUE;
end;

procedure TLoginScene.NewAccountOk;
var
   ue: TUserEntry;
   ua: TUserEntryAdd;
begin
   if CheckUserEntrys then begin
      FillChar (ue, sizeof(TUserEntry), #0);
      FillChar (ua, sizeof(TUserEntryAdd), #0);
      ue.sAccount := LowerCase(m_EdNewId.Text);
      ue.sPassword := m_EdNewPasswd.Text;
      ue.sUserName := m_EdYourName.Text;
      ue.sSSNo := '650101-1455111';
      ue.sQuiz := m_EdQuiz1.Text;
      ue.sAnswer := Trim(m_EdAnswer1.Text);
      ue.sPhone := m_EdPhone.Text;
      ue.sEMail := Trim(m_EdEMail.Text);

      ua.sQuiz2 := m_EdQuiz2.Text;
      ua.sAnswer2 := Trim(m_EdAnswer2.Text);
      ua.sBirthday := m_EdBirthDay.Text;
      ua.sMobilePhone := m_EdMobPhone.Text;

      m_NewIdRetryUE := ue;    //犁矫档锭 荤侩
      m_NewIdRetryUE.sAccount := '';
      m_NewIdRetryUE.sPassword := '';
      m_NewIdRetryAdd := ua;

      if not m_boUpdateAccountMode then
         FrmMain.SendNewAccount (ue, ua)
      else
         FrmMain.SendUpdateAccount (ue, ua);
      m_boUpdateAccountMode := FALSE;
      NewAccountClose;
   end;
end;

procedure TLoginScene.NewAccountClose;
begin
   if not m_boUpdateAccountMode then
      ChangeLoginState (lsLogin);
end;

procedure TLoginScene.ChgpwOk;
var
   uid, passwd, newpasswd: string;
begin
   if m_EdChgNewPw.Text = m_EdChgRepeat.Text then begin
      uid := m_EdChgId.Text;
      passwd := m_EdChgCurrentpw.Text;
      newpasswd := m_EdChgNewPw.Text;
      FrmMain.SendChgPw (uid, passwd, newpasswd);
      ChgpwCancel;
   end else begin
      FrmDlg.DMessageDlg ('两次输入的新密码不一致，请重新输入。', [mbOk]);
      m_EdChgNewPw.SetFocus;
   end;
end;

procedure TLoginScene.ChgpwCancel;
begin
   ChangeLoginState (lsLogin);
end;


{-------------------- TSelectChrScene ------------------------}
//选择角色场景
constructor TSelectChrScene.Create;
begin
   //CreateChrMode := FALSE;
   FillChar (ChrArr, sizeof(TSelChar)*2, #0);
   ChrArr[0].FreezeState := TRUE; //扁夯捞 倔绢 乐绰 惑怕
   ChrArr[1].FreezeState := TRUE;
   NewIndex := 0;
   EdChrName := TEdit.Create (FrmMain.Owner);
   with EdChrName do begin
      Parent := FrmMain;
      Height := 16;
      Width  := 137;
      BorderStyle := bsNone;
      Color := clBlack;
      Font.Color := clWhite;
      ImeMode := LocalLanguage;
      MaxLength := 14;
      Visible := FALSE;
      OnKeyPress := EdChrnameKeyPress;
   end;
   SoundTimer := TTimer.Create (FrmMain.Owner);
   with SoundTimer do begin
      OnTimer := SoundOnTimer;
      Interval := 1;
      Enabled := FALSE;
   end;
   inherited Create (stSelectChr);
end;

destructor TSelectChrScene.Destroy;
begin
   inherited Destroy;
end;

procedure TSelectChrScene.OpenScene;
begin
   FrmDlg.DSelectChr.Visible := TRUE;
   SoundTimer.Enabled := TRUE;
   SoundTimer.Interval := 1;
   //3.3 场景切换时 开始按钮不可用
   {with FrmDlg.DscStart do begin
      Enabled := False;
      g_ReSelClientRect := FrmDlg.DscStart.ClientRect;
    end;
    g_dwReSelConnectTick := GetTickCount + 500; }
end;

procedure TSelectChrScene.CloseScene;
begin
   SilenceSound;
   FrmDlg.DSelectChr.Visible := FALSE;
   SoundTimer.Enabled := FALSE;
end;

procedure TSelectChrScene.SoundOnTimer (Sender: TObject);
begin
   PlayBGM (bmg_select);
   SoundTimer.Enabled := FALSE;
   //SoundTimer.Interval := 38 * 1000;
end;

procedure TSelectChrScene.SelChrSelect1Click;
begin
   if (not ChrArr[0].Selected) and (ChrArr[0].Valid) then begin
      FrmMain.SelectChr(ChrArr[0].UserChr.Name);//2004/05/17
      ChrArr[0].Selected := TRUE;
      ChrArr[1].Selected := FALSE;
      ChrArr[0].Unfreezing := TRUE;
      ChrArr[0].AniIndex := 0;
      ChrArr[0].DarkLevel := 0;
      ChrArr[0].EffIndex := 0;
      ChrArr[0].StartTime := GetTickCount;
      ChrArr[0].MoreTime := GetTickCount;
      ChrArr[0].StartEffTime := GetTickCount;
      PlaySound (s_meltstone);
   end;
end;

procedure TSelectChrScene.SelChrSelect2Click;
begin
   if (not ChrArr[1].Selected) and (ChrArr[1].Valid) then begin
      FrmMain.SelectChr(ChrArr[1].UserChr.Name);//2004/05/17
      ChrArr[1].Selected := TRUE;
      ChrArr[0].Selected := FALSE;
      ChrArr[1].Unfreezing := TRUE;
      ChrArr[1].AniIndex := 0;
      ChrArr[1].DarkLevel := 0;
      ChrArr[1].EffIndex := 0;
      ChrArr[1].StartTime := GetTickCount;
      ChrArr[1].MoreTime := GetTickCount;
      ChrArr[1].StartEffTime := GetTickCount;
      PlaySound (s_meltstone);
   end;
end;

procedure TSelectChrScene.SelChrStartClick;
var
   chrname: string;
begin
   chrname := '';
   if ChrArr[0].Valid and ChrArr[0].Selected then chrname := ChrArr[0].UserChr.Name;
   if ChrArr[1].Valid and ChrArr[1].Selected then chrname := ChrArr[1].UserChr.Name;
   if chrname <> '' then begin
      {  20080721注释 加快开始游戏速度
      if not g_boDoFadeOut and not g_boDoFadeIn then begin
         g_boDoFastFadeOut := TRUE;
         g_nFadeIndex := 29;
      end; }
      FrmMain.SendSelChr (chrname);
   end else
      FrmDlg.DMessageDlg ('当前没有可选择的角色。\<创建角色>按钮可以打开创建角色对话框以便创建新的角色。', [mbOk]);
end;

procedure TSelectChrScene.SelChrNewChrClick;
begin
   if not ChrArr[0].Valid or not ChrArr[1].Valid then begin
      if not ChrArr[0].Valid then MakeNewChar (0)
      else MakeNewChar (1);
   end else
      FrmDlg.DMessageDlg ('你最多可以为每个单独的帐户创建两个角色。\你可以先删除已有的角色再创建新的角色。', [mbOk]);
end;

procedure TSelectChrScene.SelChrEraseChrClick;
var
   n: integer;
begin
   n := 0;
   if ChrArr[0].Valid and ChrArr[0].Selected then n := 0;
   if ChrArr[1].Valid and ChrArr[1].Selected then n := 1;
   if (ChrArr[n].Valid) and (not ChrArr[n].FreezeState) and (ChrArr[n].UserChr.Name <> '') then begin
      //版绊 皋技瘤甫 焊辰促.
      if mrYes = FrmDlg.DMessageDlg ('“' + ChrArr[n].UserChr.Name +
      '” 删除的角色是不能被恢复的,\一段时间内您将不能使用相同的角色名称.\你真的确定要删除吗？', [mbYes, mbNo]) then
         FrmMain.SendDelChr (ChrArr[n].UserChr.Name);
   end;
end;

procedure TSelectChrScene.SelChrCreditsClick;
begin
  FrmMain.SendQueryDelChr();
  FrmDlg.btnRecvChrCloseClick(nil, 0, 0);
end;

procedure TSelectChrScene.SelChrExitClick;
begin
   FrmMain.Close;
end;

procedure TSelectChrScene.ClearChrs;
begin
   FillChar (ChrArr, sizeof(TSelChar)*2, #0);
   ChrArr[0].FreezeState := FALSE;
   ChrArr[1].FreezeState := TRUE; //扁夯捞 倔绢 乐绰 惑怕
   ChrArr[0].Selected := TRUE;
   ChrArr[1].Selected := FALSE;
   ChrArr[0].UserChr.Name := '';
   ChrArr[1].UserChr.Name := '';
end;

procedure TSelectChrScene.AddChr (uname: string; job, hair, level, sex: integer);
var
   n: integer;
begin
   if not ChrArr[0].Valid then n := 0
   else if not ChrArr[1].Valid then n := 1
   else exit;
   ChrArr[n].UserChr.Name := uname;
   ChrArr[n].UserChr.Job := job;
   ChrArr[n].UserChr.Hair := hair;

   ChrArr[n].UserChr.Level := level;
   ChrArr[n].UserChr.Sex := sex;
   ChrArr[n].Valid := TRUE;
end;

procedure TSelectChrScene.MakeNewChar (index: integer);
begin
   //CreateChrMode := TRUE;
   NewIndex := index;
   if index = 0 then begin
      FrmDlg.DCreateChr.GLeft := 415;
      FrmDlg.DCreateChr.GTop := 15;
   end else begin
      FrmDlg.DCreateChr.GLeft := 75;
      FrmDlg.DCreateChr.GTop := 15;
   end;
   FrmDlg.DCreateChr.Visible := TRUE;
   ChrArr[NewIndex].Valid := TRUE;
   ChrArr[NewIndex].FreezeState := FALSE;
   EdChrName.Left := FrmDlg.DCreateChr.GLeft + 71;
   EdChrName.Top  := FrmDlg.DCreateChr.GTop + 107;
   EdChrName.Visible := TRUE;
   EdChrName.SetFocus;
   SelectChr (NewIndex);
   FillChar (ChrArr[NewIndex].UserChr, sizeof(TUserCharacterInfo), #0);
end;

procedure TSelectChrScene.EdChrnameKeyPress (Sender: TObject; var Key: Char);
begin

end;


procedure TSelectChrScene.SelectChr (index: integer);
begin
   ChrArr[index].Selected := TRUE;
   ChrArr[index].DarkLevel := 30;
   ChrArr[index].StartTime := GetTickCount;
   ChrArr[index].Moretime := GetTickCount;
   if index = 0 then ChrArr[1].Selected := FALSE
   else ChrArr[0].Selected := FALSE;
end;

procedure TSelectChrScene.SelChrNewClose;
begin
   ChrArr[NewIndex].Valid := FALSE;
   //CreateChrMode := FALSE;
   FrmDlg.DCreateChr.Visible := FALSE;
   EdChrName.Visible := FALSE;
   if NewIndex = 1 then begin
      ChrArr[0].Selected := TRUE;
      ChrArr[0].FreezeState := FALSE;
   end;
end;

procedure TSelectChrScene.SelChrNewOk;
var
   chrname, shair, sjob, ssex: string;
begin
   chrname := Trim(EdChrName.Text);
   if chrname <> '' then begin
      ChrArr[NewIndex].Valid := FALSE;
      //CreateChrMode := FALSE;
      FrmDlg.DCreateChr.Visible := FALSE;
      EdChrName.Visible := FALSE;
      if NewIndex = 1 then begin
         ChrArr[0].Selected := TRUE;
         ChrArr[0].FreezeState := FALSE;
      end;
      shair := IntToStr(1 + Random(5)); //////IntToStr(ChrArr[NewIndex].UserChr.Hair);
      sjob  := IntToStr(ChrArr[NewIndex].UserChr.Job);
      ssex  := IntToStr(ChrArr[NewIndex].UserChr.Sex);
      FrmMain.SendNewChr (FrmMain.LoginId, chrname, shair, sjob, ssex); //货 某腐磐甫 父电促.
   end;
end;

procedure TSelectChrScene.SelChrNewJob (job: integer);
begin
   if (job in [0..2]) and (ChrArr[NewIndex].UserChr.Job <> job) then begin
      ChrArr[NewIndex].UserChr.Job := job;
      SelectChr (NewIndex);
   end;
end;

procedure TSelectChrScene.SelChrNewm_btSex (sex: integer);
begin
   if sex <> ChrArr[NewIndex].UserChr.Sex then begin
      ChrArr[NewIndex].UserChr.Sex := sex;
      SelectChr (NewIndex);
   end;
end;

procedure TSelectChrScene.SelChrNewPrevHair;
begin
end;

procedure TSelectChrScene.SelChrNewNextHair;
begin
end;

procedure TSelectChrScene.PlayScene (MSurface: TAsphyreCanvas);
var
   n, bx, by, fx, fy, img: integer;
   ex, ey:Integer; //选择人物时显示的效果光位置
   d, e, dd: TAsphyreLockableTexture;
   svname: string;
begin
   bx:=0;
   by:=0;
   fx:=0;
   fy:=0;//Jacky
   d := g_TasUiImages.Images[19];//优先考虑GM定义的文件 By TasNat at: 2012-04-22 17:46:23
   if d = nil then
   d := g_WMain3Images.Images[400];

   //显示选择人物背景画面
   if d <> nil then begin
//      MSurface.Draw (0, 0, d.ClientRect, d, FALSE);
      MSurface.Draw ((g_D3DConfig.wScreenWidth - d.Width) div 2,(g_D3DConfig.wScreenHeight - d.Height) div 2, d.ClientRect, d, FALSE);
   end;

   for n:=0 to 1 do begin
      if ChrArr[n].Valid then begin
         ex := (g_D3DConfig.wScreenWidth - 800) div 2 + 90{90};
         ey := (g_D3DConfig.wScreenHeight - 600) div 2 + 60-2{60-2};
         case ChrArr[n].UserChr.Job of
            0: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (g_D3DConfig.wScreenWidth - 800) div 2 + 71{71};
                  by := (g_D3DConfig.wScreenHeight - 600) div 2 + 75-23{75-23}; //巢磊
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (g_D3DConfig.wScreenWidth - 800) div 2 + 65{65};
                  by := (g_D3DConfig.wScreenHeight - 600) div 2 + 75-2-18{75-2-18};  //咯磊  倒惑怕
                  fx := bx-28+28;
                  fy := by-16+16;    //框流捞绰 惑怕
               end;
            end;
            1: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (g_D3DConfig.wScreenWidth - 800) div 2 + 77{77};
                  by := (g_D3DConfig.wScreenHeight - 600) div 2 + 75-29{75-29};
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (g_D3DConfig.wScreenWidth - 800) div 2 + 141+30{141+30};
                  by := (g_D3DConfig.wScreenHeight - 600) div 2 + 85+14-2{85+14-2};
                  fx := bx-30;
                  fy := by-14;
               end;
            end;
            2: begin
               if ChrArr[n].UserChr.Sex = 0 then begin
                  bx := (g_D3DConfig.wScreenWidth - 800) div 2 + 85{85};
                  by := (g_D3DConfig.wScreenHeight - 600) div 2 + 75-12{75-12};
                  fx := bx;
                  fy := by;
               end else begin
                  bx := (g_D3DConfig.wScreenWidth - 800) div 2 + 141+23{141+23};
                  by := (g_D3DConfig.wScreenHeight - 600) div 2 + 85+20-2{85+20-2};
                  fx := bx-23;
                  fy := by-20;
               end;
            end;
         end;
         if n = 1 then begin
            ex := (g_D3DConfig.wScreenWidth - 800) div 2 + 430{430};
            ey := (g_D3DConfig.wScreenHeight - 600) div 2 + 60{60};
            bx := bx + 340;
            by := by + 2;
            fx := fx + 340;
            fy := fy + 2;
         end;
         if ChrArr[n].Unfreezing then begin //踌绊 乐绰 吝
            img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
            d := g_WChrSelImages.Images[img + ChrArr[n].aniIndex];
            e := g_WChrSelImages.Images[4 + ChrArr[n].effIndex];
            if d <> nil then MSurface.Draw (bx, by, d.ClientRect, d, TRUE);
            if e <> nil then MSurface.DrawBlend (ex, ey, e);
            if GetTickCount - ChrArr[n].StartTime > 50{120} then begin
               ChrArr[n].StartTime := GetTickCount;
               ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
            end;
            if GetTickCount - ChrArr[n].startefftime >50{ 110} then begin
               ChrArr[n].startefftime := GetTickCount;
               ChrArr[n].effIndex := ChrArr[n].effIndex + 1;
               //if ChrArr[n].effIndex > EFFECTFRAME-1 then
               //   ChrArr[n].effIndex := EFFECTFRAME-1;
            end;
            if ChrArr[n].aniIndex > FREEZEFRAME-1 then begin
               ChrArr[n].Unfreezing := FALSE; //促 踌疽澜
               ChrArr[n].FreezeState := FALSE; //
               ChrArr[n].aniIndex := 0;
            end;
         end else
            if not ChrArr[n].Selected and (not ChrArr[n].FreezeState and not ChrArr[n].Freezing) then begin //急琶登瘤 臼疽绰单 踌酒乐栏搁
               ChrArr[n].Freezing := TRUE;
               ChrArr[n].aniIndex := 0;
               ChrArr[n].StartTime := GetTickCount;
            end;
         if ChrArr[n].Freezing then begin //倔绊 乐绰 吝
            img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
            d := g_WChrSelImages.Images[img + FREEZEFRAME - ChrArr[n].aniIndex - 1];
            if d <> nil then MSurface.Draw (bx, by, d.ClientRect, d, TRUE);
            if GetTickCount - ChrArr[n].StartTime > 50 then begin
               ChrArr[n].StartTime := GetTickCount;
               ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
            end;
            if ChrArr[n].aniIndex > FREEZEFRAME-1 then begin
               ChrArr[n].Freezing := FALSE; //促 倔菌澜
               ChrArr[n].FreezeState := TRUE; //
               ChrArr[n].aniIndex := 0;
            end;
         end;
         if not ChrArr[n].Unfreezing and not ChrArr[n].Freezing then begin
            if not ChrArr[n].FreezeState then begin  //踌酒乐绰惑怕
               img := 120 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].aniIndex + ChrArr[n].UserChr.Sex * 120;
               d := g_WChrSelImages.Images[img];
               if d <> nil then begin
                  if ChrArr[n].DarkLevel > 0 then begin
                     {asp 引擎
                     dd := TDirectDrawSurface.Create (frmMain.DXDraw.DDraw);
                     dd.SystemMemory := TRUE;
                     dd.SetSize (d.Width, d.Height);
                     dd.Draw (0, 0, d.ClientRect, d, FALSE);
                     MakeDark (dd, 30-ChrArr[n].DarkLevel);
                     MSurface.Draw (fx, fy, dd.ClientRect, dd, TRUE);
                     dd.Free;  }
                     MSurface.DrawAlpha(fx, fy, d.ClientRect, d, TRUE,255-ChrArr[n].DarkLevel*7);
                  end else MSurface.Draw (fx, fy, d.ClientRect, d, TRUE);
               end;
            end else begin      //倔绢乐绰惑怕
               img := 140 - 80 + ChrArr[n].UserChr.Job * 40 + ChrArr[n].UserChr.Sex * 120;
               d := g_WChrSelImages.Images[img];
               if d <> nil then
                  MSurface.Draw (bx, by, d.ClientRect, d, TRUE);
            end;
            if ChrArr[n].Selected then begin
               if GetTickCount - ChrArr[n].StartTime > 300 then begin
                  ChrArr[n].StartTime := GetTickCount;
                  ChrArr[n].aniIndex := ChrArr[n].aniIndex + 1;
                  if ChrArr[n].aniIndex > SELECTEDFRAME-1 then
                     ChrArr[n].aniIndex := 0;
               end;
               if GetTickCount - ChrArr[n].moretime > 25 then begin
                  ChrArr[n].moretime := GetTickCount;
                  if ChrArr[n].DarkLevel > 0 then
                     ChrArr[n].DarkLevel := ChrArr[n].DarkLevel - 1;
               end;
            end;
         end;
         //显示选择角色时人物名称等级
         if n = 0 then begin
            if ChrArr[n].UserChr.Name <> '' then begin
              AspTextureFont.BoldTextOut ((g_D3DConfig.wScreenWidth - 800) div 2 + 116{117}, (g_D3DConfig.wScreenHeight - 600) div 2 + 493 {492+2}, ChrArr[n].UserChr.Name, clWhite, clBlack);
              AspTextureFont.BoldTextOut ((g_D3DConfig.wScreenWidth - 800) div 2 + 116{117}, (g_D3DConfig.wScreenHeight - 600) div 2 + 522{523}, IntToStr(ChrArr[n].UserChr.Level), clWhite, clBlack);
              AspTextureFont.BoldTextOut ((g_D3DConfig.wScreenWidth - 800) div 2 + 116{117}, (g_D3DConfig.wScreenHeight - 600) div 2 + 552{553}, GetJobName(ChrArr[n].UserChr.Job), clWhite, clBlack);
            end;
         end else begin
            if ChrArr[n].UserChr.Name <> '' then begin
              AspTextureFont.BoldTextOut ((g_D3DConfig.wScreenWidth - 800) div 2 + 670{671}, (g_D3DConfig.wScreenHeight - 600) div 2 + 493 {492+4}, ChrArr[n].UserChr.Name, clWhite, clBlack);
              AspTextureFont.BoldTextOut ((g_D3DConfig.wScreenWidth - 800) div 2 + 670{671}, (g_D3DConfig.wScreenHeight - 600) div 2 + 523 {525}, IntToStr(ChrArr[n].UserChr.Level), clWhite, clBlack);
              AspTextureFont.BoldTextOut ((g_D3DConfig.wScreenWidth - 800) div 2 + 670{671}, (g_D3DConfig.wScreenHeight - 600) div 2 + 553 {555}, GetJobName(ChrArr[n].UserChr.Job), clWhite, clBlack);
            end;
         end;
         svname := g_sServerName;
         AspTextureFont.BoldTextOut ((g_D3DConfig.wScreenWidth div 2) - AspTextureFont.TextWidth(svname) div 2, 7 + (g_D3DConfig.wScreenHeight - 600) div 2, svname, clWhite, clBlack);
         {$if M2Version <> 2}
         if g_sTips <> '' then
         AspTextureFont.BoldTextOut ((g_D3DConfig.wScreenWidth div 2) - AspTextureFont.TextWidth(g_sTips) div 2, 583 + (g_D3DConfig.wScreenHeight - 600) div 2, g_sTips, clYellow, clBlack);
         {$IFEND}
      end;
   end;
end;


{--------------------------- TLoginNotice ----------------------------}

constructor TLoginNotice.Create;
begin
   inherited Create (stLoginNotice);
end;

destructor TLoginNotice.Destroy;
begin
   inherited Destroy;
end;

procedure TLoginNotice.PlayScene (MSurface: TAsphyreCanvas);
var
  msgstr : string;
  n : Integer;
begin
  //超时未连接则回到角色选择  By TasNat at: 2012-04-19 11:45:13
  //if g_SendNoticePass then
  Exit;
  if dwOpenTick = 0 then Exit;
  n := (GetTickCount - dwOpenTick) div 1000;
  if n < 10 then begin
   if n > 3 then //超时三秒后显示时间
     msgstr := '连接中' + IntToStr(10 - n) + '....'
   else
     msgstr := '连接中....';
   AspTextureFont.BoldTextOut((g_D3DConfig.wScreenWidth - AspTextureFont.TextWidth(msgstr)) div 2, (g_D3DConfig.wScreenHeight - AspTextureFont.TextHeight(msgstr)) div 2,
      msgstr, clWhite, clBlack);
  end else begin//10秒还没连接
    frmMain.SendClientMessage(CM_SOFTCLOSE, 0, 0, 0, 0);
    frmMain.ActiveCmdTimer(tcReSelConnect);
    dwOpenTick := 0;
  end;
end;

destructor TScene.Destroy;
begin
  inherited;
end;

end.
