unit GetBackPassword;

interface

uses
  Windows,  SysUtils, Forms, RzBmpBtn, RzLabel, 
  Classes, Controls, StdCtrls, ExtCtrls, jpeg;

type
  TFrmGetBackPassword = class(TForm)
    ImageMain: TImage;
    RzLabel10: TRzLabel;
    RzLabel3: TRzLabel;
    EditAccount: TEdit;
    RzLabel1: TRzLabel;
    EditBirthDay: TEdit;
    RzLabel2: TRzLabel;
    EditQuiz1: TEdit;
    RzLabel4: TRzLabel;
    EditAnswer1: TEdit;
    RzLabel5: TRzLabel;
    EditQuiz2: TEdit;
    RzLabel6: TRzLabel;
    EditAnswer2: TEdit;
    RzLabel7: TRzLabel;
    EditPassword: TEdit;
    ButtonOK: TRzBmpButton;
    btnCancel: TRzBmpButton;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
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
    procedure ButtonOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
    procedure CreateParams(var Params:TCreateParams);override;//设置程序的类名 20080412
  end;

var
  FrmGetBackPassword: TFrmGetBackPassword;
  dwOKTick     : LongWord;
implementation

uses Main, MsgBox, GameLoginShare;

{$R *.dfm}
procedure TFrmGetBackPassword.Open();
begin
  ButtonOK.Enabled:=True;
  EditPassword.Text:='';
  EditAccount.Text:='';
  EditQuiz1.Text:='';
  EditAnswer1.Text:='';
  EditQuiz2.Text:='';
  EditAnswer2.Text:='';
  EditBirthDay.Text:='';
  ShowModal;
end;

procedure TFrmGetBackPassword.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditBirthDay.SetFocus ;
end;

procedure TFrmGetBackPassword.EditBirthDayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditQuiz1.SetFocus ;
end;

procedure TFrmGetBackPassword.EditQuiz1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditAnswer1.SetFocus ;
end;

procedure TFrmGetBackPassword.EditAnswer1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditQuiz2.SetFocus ;
end;

procedure TFrmGetBackPassword.EditQuiz2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditAnswer2.SetFocus ;
end;

procedure TFrmGetBackPassword.EditAnswer2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF Key=13 then EditPassword.SetFocus ;
end;

procedure TFrmGetBackPassword.ButtonOKClick(Sender: TObject);
var
  sAccount,sQuest1,sAnswer1,sQuest2,sAnswer2,sBirthDay:String;
begin
  if GetTickCount - dwOKTick < 10000 then begin
    FrmMessageBox.LabelHintMsg.Caption :=  {'请稍候10秒后再点确定！！！'} SetDate('蠕欺谍>?啼迭壑红歉恭');
    FrmMessageBox.ShowModal;
    Exit;
  end;
  dwOKTick:=GetTickCount();
  sAccount:=Trim(EditAccount.Text);
  sQuest1:=Trim(EditQuiz1.Text);
  sAnswer1:=Trim(EditAnswer1.Text);
  sQuest2:=Trim(EditQuiz2.Text);
  sAnswer2:=Trim(EditAnswer2.Text);
  sBirthDay:=Trim(EditBirthDay.Text);
  if sAccount = '' then begin
    FrmMessageBox.LabelHintMsg.Caption := {'帐号输入不正确！！！'} SetDate('谂凳烹卿酱隍歉');
    FrmMessageBox.ShowModal;
    EditAccount.SetFocus;
    Exit;
  end;
  if (sQuest1 = '') and (sAnswer1 = '') and (sQuest2 = '') and (sAnswer2 = '') then begin
    FrmMessageBox.LabelHintMsg.Caption := {'密码问答输入不正确！！！'} SetDate('逃弯僚?烹卿酱隍歉');
    FrmMessageBox.ShowModal;
    Exit;
  end;
  if (sQuest1 = '') and (sAnswer1 = '') and (sQuest2 = '') and (sAnswer2 = '') then begin
    FrmMessageBox.LabelHintMsg.Caption := {'密码问答输入不正确！！！'} SetDate('逃弯僚?烹卿酱隍歉');
    FrmMessageBox.ShowModal;
    Exit;
  end;
  if (sBirthDay = '') then begin
    FrmMessageBox.LabelHintMsg.Caption := {'出生日期输入不正确！！！'} SetDate('践契勤烧烹卿酱隍歉');
    FrmMessageBox.ShowModal;
    EditBirthDay.SetFocus;
    Exit;
  end;

  if sQuest1 = '' then sQuest1:={'test'}SetDate('{j|{');
  if sAnswer1 = '' then sAnswer1:={'test'}SetDate('{j|{');
  if sQuest2 = '' then sQuest2:={'test'}SetDate('{j|{');
  if sAnswer2 = '' then sAnswer2:={'test'}SetDate('{j|{');

  FrmMain.SendGetBackPassword(sAccount, sQuest1, sAnswer1,sQuest2,sAnswer2,sBirthDay);
  ButtonOK.Enabled:=False;
end;

procedure TFrmGetBackPassword.CreateParams(var Params: TCreateParams);
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

procedure TFrmGetBackPassword.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
