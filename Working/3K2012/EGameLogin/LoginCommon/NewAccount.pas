unit NewAccount;

interface

uses
  Windows, Messages, SysUtils, Forms,
  HUtil32, Grobal2, RzBmpBtn,
  RzLabel, Classes, Controls, StdCtrls, ExtCtrls, jpeg;

type
  TFrmNewAccount = class(TForm)
    mainImage: TImage;
    RzLabel3: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    EditPassword: TEdit;
    EditAccount: TEdit;
    EditConfirm: TEdit;
    EditYourName: TEdit;
    EditBirthDay: TEdit;
    EditQuiz1: TEdit;
    EditAnswer1: TEdit;
    EditQuiz2: TEdit;
    EditAnswer2: TEdit;
    ButtonOK: TRzBmpButton;
    clButton: TRzBmpButton;
    EditEMail: TEdit;
    EditPoer: TEdit;
    Label1: TLabel;
    procedure EditAccountKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditConfirmKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditYourNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBirthDayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditQuiz1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditAnswer1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditQuiz2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditAnswer2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditEMailKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonOKClick(Sender: TObject);
    procedure clButtonClick(Sender: TObject);
    procedure mainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    function CheckUserEntrys():Boolean;
    function NewIdCheckBirthDay():Boolean;
  public
    procedure Open();
    procedure CreateParams(var Params:TCreateParams);override;//设置程序的类名 20080412
  end;

var
  FrmNewAccount: TFrmNewAccount;
implementation

uses Main, MsgBox, GameLoginShare;
var
  dwOKTick     : LongWord;
  NewIdRetryUE : TUserEntry;
  NewIdRetryAdd: TUserEntryAdd;
{$R *.dfm}

//用户打开注册窗体 初始化
procedure TFrmNewAccount.Open;
begin
  ButtonOK.Enabled:=True;
  EditAccount.Text:='';
  EditPassword.Text:='';
  EditConfirm.Text:='';
  EditYourName.Text:='';
  EditBirthDay.Text:='';
  EditQuiz1.Text:='';
  EditAnswer1.Text:='';
  EditQuiz2.Text:='';
  EditAnswer2.Text:='';
  EditEMail.Text:='';
  ShowModal;
end;
//检测用户日期是否添入正确
function TFrmNewAccount.NewIdCheckBirthDay: Boolean;
var
   str, syear, smon, sday: string;
   ayear, amon, aday: integer;
   flag: Boolean;
begin
   Result := TRUE;
   flag := TRUE;
   str := EditBirthDay.Text;
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
      EditBirthDay.SetFocus;
      Result := FALSE;
   end;
end;
//检测用户输入是否正确
function TFrmNewAccount.CheckUserEntrys: Boolean;
begin
   Result:=False;
   EditAccount.Text:=Trim(EditAccount.Text);
   EditQuiz1.Text := Trim(EditQuiz1.Text);
   EditYourName.Text := Trim(EditYourName.Text);
   if Length(EditAccount.Text) < 3 then begin
      FrmMessageBox.LabelHintMsg.Caption := {'登录帐号的长度必须大于3位.'}SetDate('喝统谂凳核极骨咀咪稽苷<链!');
      FrmMessageBox.ShowModal;
      Beep;
      EditAccount.SetFocus;
      exit;
   end;
   if not NewIdCheckBirthday then exit;
   if Length(EditPassword.Text) < 3 then begin
      EditPassword.SetFocus;
      exit;
   end;
   if EditPassword.Text <> EditConfirm.Text then begin
      EditConfirm.SetFocus;
      exit;
   end;
   if Length(EditQuiz1.Text) < 1 then begin
      EditQuiz1.SetFocus;
      exit;
   end;
   if Length(EditAnswer1.Text) < 1 then begin
      EditAnswer1.SetFocus;
      exit;
   end;
   if Length(EditQuiz2.Text) < 1 then begin
      EditQuiz2.SetFocus;
      exit;
   end;
   if Length(EditAnswer2.Text) < 1 then begin
      EditAnswer2.SetFocus;
      exit;
   end;
   if Length(EditYourName.Text) < 1 then begin
      EditYourName.SetFocus;
      exit;
   end;
   Result:=True;
end;

//点击 确定按钮

procedure TFrmNewAccount.EditAccountKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditPassword.SetFocus ;
end;

procedure TFrmNewAccount.EditPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditConfirm.SetFocus ;
end;

procedure TFrmNewAccount.EditConfirmKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditYourName.SetFocus ;
end;

procedure TFrmNewAccount.EditYourNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditBirthDay.SetFocus ;
end;

procedure TFrmNewAccount.EditBirthDayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditQuiz1.SetFocus ;
end;

procedure TFrmNewAccount.EditQuiz1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditAnswer1.SetFocus ;
end;

procedure TFrmNewAccount.EditAnswer1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditQuiz2.SetFocus ;
end;

procedure TFrmNewAccount.EditQuiz2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditAnswer2.SetFocus ;
end;

procedure TFrmNewAccount.EditAnswer2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditEMail.SetFocus ;
end;

procedure TFrmNewAccount.EditEMailKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then ButtonOK.Click ;
end;

procedure TFrmNewAccount.ButtonOKClick(Sender: TObject);
var
   ue: TUserEntry;
   ua: TUserEntryAdd;
begin
  if GetTickCount - dwOKTick < 5000 then begin
    FrmMessageBox.LabelHintMsg.Caption := {'请稍候再点确定！！！'}SetDate('蠕欺谍壑红歉恭');
    FrmMessageBox.ShowModal;
    exit;
  end;
  if CheckUserEntrys then begin
    FillChar(ue, sizeof(TUserEntry), #0);
    FillChar(ua, sizeof(TUserEntryAdd), #0);
    ue.sAccount:= LowerCase(EditAccount.Text);
    ue.sPassword:= EditPassword.Text;
    ue.sUserName:= EditYourName.Text;
    ue.sSSNo:= {'650101-1455111'}SetDate('9:?>?>">;::>>>');
    ue.sQuiz:= EditQuiz1.Text;
    ue.sAnswer:= Trim(EditAnswer1.Text);
    ue.sPhone:= '';
    ue.sEMail:= Trim(EditEMail.Text);
    ua.sQuiz2:= EditQuiz2.Text;
    ua.sAnswer2:= Trim(EditAnswer2.Text);
    ua.sBirthday:= EditBirthday.Text;
    ua.sMobilePhone:= '';
    NewIdRetryUE := ue;
    NewIdRetryUE.sAccount := '';
    NewIdRetryUE.sPassword := '';
    NewIdRetryAdd := ua;
    FrmMain.SendUpdateAccount(ue, ua);
    ButtonOK.Enabled:=False;
    dwOKTick:=GetTickCount();
  end;
end;

procedure TFrmNewAccount.clButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmNewAccount.CreateParams(var Params: TCreateParams);
  //随机取密码
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //随机种子
      for i:=0 to 8 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
var
  sClassName: string;
begin
  Inherited CreateParams(Params);
  sClassName := RandomGetPass;
  strpcopy(pchar(@Params.WinClassName),sClassName);
end;

procedure TFrmNewAccount.mainImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

end.
