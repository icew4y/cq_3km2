unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Mask, RzEdit, Share;

type
  TFrmMakeKey = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    UserKeyEdit: TEdit;
    UserDateTimeEdit: TRzDateTimeEdit;
    CountSpinEdit: TSpinEdit;
    RzDateTimeEditRegister: TRzDateTimeEdit;
    UserModeRadioGroup: TRadioGroup;
    Label4: TLabel;
    EditUserName: TEdit;
    EditEnterKey: TEdit;
    Label9: TLabel;
    MakeKeyButton: TButton;
    ButtonExit: TButton;
    Label2: TLabel;
    SpinEditPersonCount: TSpinEdit;
    RadioGroupLicDay: TRadioGroup;
    LabelInfo: TLabel;
    procedure MakeKeyButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure RadioGroupLicDayClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    SpinEditVersion: TSpinEdit;
    LabelVersion: TLabel;
    function InitPulg(): Boolean;
    procedure UnInitPulg();
    procedure MakeVersionCustom();
  public
    { Public declarations }
  end;

var
  FrmMakeKey: TFrmMakeKey;
  N_SOFTTYPE: Integer = 88888888;
const
  SuperUser = 398432431; //飘飘网络
  Version = SuperUser;

implementation
uses SystemManage,DESCrypt;
{$R *.dfm}
function GetDayCount(MaxDate, MinDate: TDateTime): Integer;
var
  Day: LongInt;
begin
  Day := Trunc(MaxDate) - Trunc(MinDate);
  if Day > 0 then Result := Day else Result := 0;
end;

function Str_ToInt(Str: string; def: LongInt): LongInt;
begin
  Result := def;
  if Str <> '' then begin
    if ((word(Str[1]) >= word('0')) and (word(Str[1]) <= word('9'))) or
      (Str[1] = '+') or (Str[1] = '-') then try
      Result := StrToInt64(Str);
    except
    end;
  end;
end;
procedure TFrmMakeKey.MakeVersionCustom();
begin
  SpinEditVersion := TSpinEdit.Create(Owner);
  LabelVersion := TLabel.Create(Owner);
  SpinEditVersion.Parent := FrmMakeKey;
  LabelVersion.Parent := FrmMakeKey;
  SpinEditVersion.MaxValue := 2000000000;
  SpinEditVersion.MinValue := 0;
  SpinEditVersion.Value := 398432431;
  SpinEditVersion.Left := 192;
  SpinEditVersion.Top := 212;
  LabelVersion.Left := 120;
  LabelVersion.Top := 216;
  LabelVersion.Caption := '输入用户QQ：';
  LabelVersion.Visible:=False;
  SpinEditVersion.Visible:=False;
end;

procedure TFrmMakeKey.MakeKeyButtonClick(Sender: TObject);
var
  nUserCode: Integer;
  sUserCode: string;
  sUserName: string;
  btUserMode: Byte;
  wCount: Integer;
  wPersonCount: Integer;
  sEnterKey: string;
  m_nCheckCode: Integer;
  nVersion: Integer;
  s01: string;
begin
  if boEnterKey then begin
    sUserCode := Trim(UserKeyEdit.Text);
    sUserName := Trim(EditUserName.Text);
    btUserMode := UserModeRadioGroup.ItemIndex + 1;
    case btUserMode of
      1: wCount := CountSpinEdit.Value;
      2: wCount := GetDayCount(UserDateTimeEdit.Date, Date);
      3: wCount := High(word);
    end;
    wPersonCount := SpinEditPersonCount.Value;
    if sUserCode = '' then begin
      Application.MessageBox('请输入机器码！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    if sUserName = '' then begin
      Application.MessageBox('请输入用户名！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    try
      m_nCheckCode := nCheckCode * Integer(boEnterKey);
      nVersion := SpinEditVersion.Value;
      InitLicense(nVersion, 0, 0, 0, Date, PChar(sUserName));
      sEnterKey := StrPas(MakeRegisterInfo(btUserMode * m_nCheckCode div 1003, PChar(sUserCode), wCount, wPersonCount, PChar(sUserName), RzDateTimeEditRegister.Date));
      EditEnterKey.Text := DeCrypt(sEnterKey,inttostr(Version));
    except
      EditEnterKey.Text := '';
    end;
    //Caption := '注册码长度：' + IntToStr(Length(EditEnterKey.Text));
    UnInitLicense();
  end;
  wCount := GetDayCount(UserDateTimeEdit.Date, RzDateTimeEditRegister.Date);
  case UserModeRadioGroup.ItemIndex of
    0: s01 := '次数限制';
    1: s01 := '日期限制';
    2: s01 := '无限制';
    else begin
        s01 := '未知';
      end;
  end;
  Application.MessageBox(PChar('注册类型：' + s01 + #13 + '授权天数：' + IntToStr(wCount)), '提示信息', MB_OK + MB_ICONINFORMATION);
end;

function TFrmMakeKey.InitPulg(): Boolean;
var
  sPlugLibFileName: string;
begin
  Result := False;
  sPlugLibFileName := ExtractFilePath(ParamStr(0)) + 'License.dll';
  if FileExists(sPlugLibFileName) then begin
    Moudle := LoadLibrary(PChar(sPlugLibFileName));
    if Moudle > 0 then begin
      @Init := GetProcAddress(Moudle, 'Init');
      @GetFunAddr := GetProcAddress(Moudle, 'GetFunAddr');
      Result := True;
    end;
  end;
end;

procedure TFrmMakeKey.UnInitPulg();
begin
  if Moudle > 0 then begin
    UnInit := GetProcAddress(Moudle, 'UnInit');
    if Assigned(UnInit) then begin
      UnInit;
    end;
    FreeLibrary(Moudle);
  end;
end;

procedure TFrmMakeKey.FormCreate(Sender: TObject);
var
  UserMode: Byte;
  wCount: word;
  ErrorInfo: Integer;
  btStatus: Byte;
begin
  boEnterKey := True;
  nCheckCode := 1003;
  MakeVersionCustom();
(*  Application.ShowMainForm := False;
  boEnterKey := False;
  nCheckCode := 1000;
  nRegisterCode := 0;
  Moudle := 0;
  if InitPulg() then begin
    if Assigned(Init) and Assigned(GetFunAddr) then begin
      TInit(Init)(N_SOFTTYPE, 0, 0, Now, nil);
      nCheckCode := 1001;
      GetLicenseShare := GetFunAddr(2);
      if Assigned(GetLicenseShare) then begin
        TGetLicense(GetLicenseShare)(UserMode, wCount, ErrorInfo, btStatus);
        nCheckCode := 1002;
        {Showmessage('UserMode '+IntToStr(UserMode));
        Showmessage('wCount '+IntToStr(wCount));
        Showmessage('ErrorInfo '+IntToStr(ErrorInfo));
        Showmessage('btStatus '+IntToStr(ErrorInfo)); }
        if (ErrorInfo <= 0) and (UserMode = 3) and (btStatus <= 0) then begin
          GetRegisterCodeShare := GetFunAddr(1);
          if Assigned(GetRegisterCodeShare) then begin
            nRegisterCode := TGetRegisterCode(GetRegisterCodeShare);
            boEnterKey := True;
            nCheckCode := 1003;
            MakeVersionCustom();
            Application.ShowMainForm := True;
          end else Application.Terminate;
        end else begin
          OpenDiaLog := GetFunAddr(3);
          if Assigned(OpenDiaLog) then begin
            TOpenDiaLog(OpenDiaLog);
            Application.Terminate;
          end else Application.Terminate;
        end;
      end else Application.Terminate;
      UnInitPulg();
    end else Application.Terminate;
    RzDateTimeEditRegister.Date := Date;
    UserDateTimeEdit.Date := Date + 365;
    CountSpinEdit.Value := High(word);
    SpinEditPersonCount.Value := High(word);
  end else Application.Terminate;    *)
end;

procedure TFrmMakeKey.ButtonExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMakeKey.RadioGroupLicDayClick(Sender: TObject);
const
  nYear = 365;
begin
  case RadioGroupLicDay.ItemIndex of
    0: UserDateTimeEdit.Date := Date + 30;
    1: UserDateTimeEdit.Date := Date + nYear div 2;
    2: UserDateTimeEdit.Date := Date + nYear;
    3: UserDateTimeEdit.Date := Date + nYear + nYear div 2;
    4: UserDateTimeEdit.Date := Date + nYear * 2;
  end;
end;

procedure TFrmMakeKey.FormShow(Sender: TObject);
const
  nYear = 365;
begin
  RzDateTimeEditRegister.Date:=now();
  case RadioGroupLicDay.ItemIndex of
    0: UserDateTimeEdit.Date := Date + 30;
    1: UserDateTimeEdit.Date := Date + nYear div 2;
    2: UserDateTimeEdit.Date := Date + nYear;
    3: UserDateTimeEdit.Date := Date + nYear + nYear div 2;
    4: UserDateTimeEdit.Date := Date + nYear * 2;
  end;
end;

end.

