unit EngineRegister;

interface

uses
  SysUtils, Classes, Controls, Forms, WinlicenseSDK, Windows,
  Dialogs, StdCtrls, RzButton, Mask, RzEdit, jpeg, ExtCtrls;

type
  TFrmRegister = class(TForm)
    RzBitBtnRegister: TRzBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    EditUserName: TRzEdit;
    EditRegisterName: TRzEdit;
    Label4: TLabel;
    CompanyNameEdit: TRzEdit;
    Label5: TLabel;
    EditIPdata: TRzEdit;
    Label6: TLabel;
    RegDateTime: TRzEdit;
    Label2: TLabel;
    RzEdit1: TRzEdit;
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RzBitBtnRegisterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open();
  end;

var
  FrmRegister: TFrmRegister;

implementation
uses M2Share, SDK , DESCrypt;
{$R *.dfm}
procedure TFrmRegister.Open();
var
  MachineId: array [0..100] of AnsiChar;
  RegName: array [0..255] of AnsiChar;
  CompanyName: array [0..255] of AnsiChar;
  CustomData: array [0..255] of AnsiChar;
  TrialDate: SYSTEMTIME;
begin
{$IF UserMode1 = 2}
  if not WLProtectCheckDebugger then begin//检测调试器存在内存中
    EditRegisterName.Text := 'http://3KM2.com';
    TrialDate.wYear := 0;
    TrialDate.wMonth := 0;
    TrialDate.wDay := 0;
    TrialDate.wSecond := 0;
    TrialDate.wDayOfWeek := 0;
    TrialDate.wHour := 0;
    TrialDate.wMinute := 0;
    TrialDate.wSecond := 0;
    TrialDate.wMilliseconds := 0;

    {$I VM_Start.inc}//虚拟机标识
    WLHardwareGetID(MachineId);//取硬件ID
    {$I VM_End.inc}
    {$I Encode_Start.inc}//代码加密标识
    if WLHardwareCheckID(MachineId) and (pMaxPlayCount^ > 10000) then begin//检查硬件ID是否合法
      EditRegisterName.Text := MachineId;
      WLRegGetLicenseInfo(RegName, CompanyName, CustomData);//读取注册信息
      EditUserName.Text := RegName;//用户
      CompanyNameEdit.Text := CompanyName;//公司
      EditIPdata.Text := {CustomData}'-';//IP
      //WLRegExpirationDate(Addr(TrialDate));//取到期日期
      WLRegExpirationDate(TrialDate);//取到期日期 20101128修改WL参数,因升级2140版
      if TrialDate.wYear <> 0 then begin
        RegDateTime.text := DateToStr(SystemTimeToDateTime(TrialDate));
      end else RegDateTime.text := '-';
      RzEdit1.Text := IntToStr({WLRegDaysLeft()}WLRegDateDaysLeft);

      {  WLRegLicenseCreationDate(TrialDate);
        MainOutMessage(Format('WLRegExecutionsLeft:%d WLRegTotalExecutions:%d WLRegTotalDays:%d %s %d %d WLRegTotalDays:%d',[WLRegExecutionsLeft,
          WLRegTotalExecutions,
          WLRegTotalDays,
          DateToStr(SystemTimeToDateTime(TrialDate)),
          WLRegDateDaysLeft(),
          WLRegGlobalTimeLeft(),
          WLRegTotalDays]));  }

      {  WLRegExecutionsLeft--处决的人数留在目前的许可密钥
        WLRegTotalExecutions总数处决在目前的许可密钥
        WLRegTotalDays总日数在目前的许可密钥
        WLRegLicenseCreationDate//许可证创建日期   }

      ShowModal;
    end else begin
      asm //关闭程序
        MOV FS:[0],0;
        MOV DS:[0],EAX;
      end;    
    end;
    {$I Encode_End.inc}
  end;
{$IFEND}
end;

procedure TFrmRegister.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmRegister.FormDestroy(Sender: TObject);
begin
  FrmRegister:= nil;
end;

procedure TFrmRegister.RzBitBtnRegisterClick(Sender: TObject);
begin
  Close;
end;
end.
