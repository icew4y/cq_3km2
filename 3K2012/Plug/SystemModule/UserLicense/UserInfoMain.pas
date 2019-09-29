unit UserInfoMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, RzEdit, RzButton;
type
  TUserFrm = class(TForm)
    GroupBox1: TGroupBox;
    MsgLabel: TLabel;
    UserLabel: TLabel;
    UserEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditUserName: TRzEdit;
    EditEnterKey: TRzEdit;
    ButtonEnterKey: TRzBitBtn;
    RzBitBtnClose: TRzBitBtn;
    procedure ButtonEnterKeyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzBitBtnCloseClick(Sender: TObject);
    //==============================================================================
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;
var
  UserFrm: TUserFrm;
implementation
uses LicenseMain;
{$R *.dfm}
procedure TUserFrm.Open();
begin
  ShowModal;
end;

procedure TUserFrm.ButtonEnterKeyClick(Sender: TObject);
var
  sEnterKey: String;
  sUserName:String;
begin
  sEnterKey := Trim(EditEnterKey.Text);
  sUserName := Trim(EditUserName.Text);
  if sUserName = '' then begin
    Application.MessageBox('请输入用户名！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  if sEnterKey = '' then begin
    Application.MessageBox('请输入注册码！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;
  case StartRegister(sEnterKey, sUserName) of
    1:begin
      Application.MessageBox('注册成功,请重新启动本程序以确认注册！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
    end;
    else begin
      Application.MessageBox('注册码不正确！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
    end;
  end;
  Close;
end;

procedure TUserFrm.FormCreate(Sender: TObject);
begin
  UserEdit.Text := IntToStr(License.RegisterName);
end;

procedure TUserFrm.RzBitBtnCloseClick(Sender: TObject);
begin
  Close;
end;

end.

