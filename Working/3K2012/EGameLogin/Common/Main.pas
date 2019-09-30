unit Main;

interface
uses
  Messages, ExtCtrls, Forms, Classes, Windows, Grobal2, Graphics;//整合两种界面By TasNat at: 2012-10-11 09:22:58
type
  TFrmMain = class(TForm)
  private
    procedure WndProc(var Message: TMessage); override;
  public
    TimerPatch: TTimer;
    SecrchTimer: TTimer;
    TimeGetGameList: TTimer;
    TimerKillCheat : TTimer;
    procedure SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd); virtual; abstract;//发送新建账号
    procedure SendChgPw(sAccount, sPasswd, sNewPasswd: string); virtual; abstract;//发送修改密码
    procedure SendGetBackPassword(sAccount, sQuest1, sAnswer1, sQuest2, sAnswer2, sBirthDay: string); virtual; abstract;//发送找回密码
  protected
    procedure DoCreate; override;
    procedure SetEnabledServerList(Value : Boolean); virtual; abstract;
    procedure SetStatusString(const Value : string); virtual; abstract;
    procedure SetStatusColor(const Value : TColor); virtual; abstract;
  public
    property EnabledServerList:  Boolean write SetEnabledServerList;
    property StatusString:  string write SetStatusString;
    property StatusColor:  TColor write SetStatusColor;
  end;
var
  FrmMain : TFrmMain;
implementation

procedure TFrmMain.DoCreate;
begin
  //TimerPatch
  TimerPatch := TTimer.Create(Self);

  //TimerPatch
  TimerPatch.Name := 'TimerPatch';
  TimerPatch.Enabled := False;
  TimerPatch.Interval := 1;

    //SecrchTimer
  SecrchTimer := TTimer.Create(Self);

  //SecrchTimer
  SecrchTimer.Name := 'SecrchTimer';
  SecrchTimer.Enabled := False;
  SecrchTimer.Interval := 1;

    //TimeGetGameList
  TimeGetGameList := TTimer.Create(Self);

  //TimeGetGameList
  TimeGetGameList.Name := 'TimeGetGameList';
  TimeGetGameList.Enabled := False;
  TimeGetGameList.Interval := 100;

  TimerKillCheat := TTimer.Create(Self);

  //TimerPatchSelf
  TimerKillCheat.Name := 'TimerKillCheat';
  TimerKillCheat.Enabled := False;
  inherited;
end;

procedure TFrmMain.WndProc(var Message: TMessage);
begin
  asm db $EB,$10,'VMProtect begin',0 end;
  with Message do
    if Msg = (Handle mod WM_USER) or WM_USER then begin
      Result := (((WParamHi xor 30) shl ((WParamLo xor 25) mod 3)) xor (LParam xor 3))
    end else inherited;
  asm db $EB,$0E,'VMProtect end',0; end;
end;


end.
