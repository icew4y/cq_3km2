unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, StdCtrls, RzCmboBx, Mask, RzEdit, Buttons,
  WinSkinData;

type
  TFrmLogin = class(TForm)
    BtnLogin: TBitBtn;
    BtnExit: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    EdtPass: TEdit;
    ComboBoxUser: TComboBox;
    procedure BtnExitClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses Main, Share, EDcodeUnit, WinlicenseSDK, Clipbrd;

{$R *.dfm}

procedure TFrmLogin.BtnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
var
  sAccount: string;
  sPassword: string;
  sServerAdd: string;
begin
  sAccount := Trim(ComboBoxUser.Text);
  sPassword := Trim(EdtPass.Text);
  if sAccount = '' then begin
    Application.MessageBox('请输入登录帐号！', '提示信息', MB_OK + MB_ICONWARNING);
    ComboBoxUser.SetFocus;
    Exit;
  end;
  if sPassword = '' then begin
    Application.MessageBox('请输入密码！', '提示信息', MB_OK + MB_ICONWARNING);
    EdtPass.SetFocus;
    Exit;
  end;
  BtnLogin.Enabled := False;
  ComboBoxUser.Enabled := False;
  EdtPass.Enabled := False;
  g_sAccount := sAccount;
  g_sPassword := sPassword;
  Decode(g_sServerAdd, sServerAdd);
  FrmMain.ClientSocket.Active := False;
  FrmMain.ClientSocket.Host := sServerAdd;
  FrmMain.ClientSocket.Port := 36009;
  FrmMain.ClientSocket.Active := True;
  FrmMain.StatusPaneMsg.Panels[0].Text := '正在连接服务器...';  
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
var
  nX, nY: Integer;
  ClStr, s1:string;
  MachineId: array [0..100] of AnsiChar;
begin
  if WLProtectCheckDebugger then begin//检测调试器存在内存中
    asm //关闭程序
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;
  nY:= WLRegGetStatus(nX);
  if nY = 0 then begin//检查程序是否注册 没有注册则提示
    WLHardwareGetID(MachineId);//取硬件ID
    Clipbrd.Clipboard.AsText := MachineId;//复制到剪切板上
    //使用普通程序加密函数
    Decode('243F2F9136D9C6465A54A4BA779F619B5EEED0F138F326D167474A5D5AC935FD77CC253F46D9021D', s1); //请不要修改计算机日期，注册软件：
    ClStr:= s1+#13+#13;
    Decode('E7FEAF3C7D9F4C29DF69FE5E0BEF3653', s1);//机器信息：
    ClStr:= ClStr+s1+MachineId;
    Decode('5D3CA29078AABDFAB945726BA94B8FFB22DBA80E58FC037699E6A68EB2FC282496757BDE4AF342C4D870098E6590BBC3', s1);// (Ctrl+v粘贴到文本) 发送给管理员进行注册
    ClStr:= ClStr+s1+#13+#13;;
    Decode('83D7FD6174C8CE82FFE6BEC522700B9AFA458CECC1AEA7EC6CC672654BD08339DC7B66F228B8D058', s1);//官方网站：http://www.3km2.com
    ClStr:= ClStr+s1;
    Decode('4F760445F72C3BF5818267F89D7FD29A', s1);//3k软件
    Application.MessageBox(PChar(ClStr) ,PChar(s1),MB_IConERROR+MB_OK);
    asm //关闭程序
      MOV FS:[0],0;
      MOV DS:[0],EAX;  
    end;
  end else
  if nY = wlIsRegistered then begin//已注册的，取IP信息
  end else begin
    asm //关闭程序
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;   
  end;
end;

end.
