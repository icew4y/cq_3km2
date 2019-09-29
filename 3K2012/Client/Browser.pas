unit Browser;

interface

uses
  Windows, Messages, Classes, Controls, Forms,
  OleCtrls, SHDocVw, StdCtrls, Buttons, ExtCtrls, AppEvnts, Share, SysUtils;

type
  TfrmBrowser = class(TForm)
    NavPanel: TPanel;
    SpeedButton1: TSpeedButton;
    lblProgress: TLabel;
    WebBrowser1: TWebBrowser;
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure WebBrowser1NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
  private
    { Private declarations }
  public
    procedure Open(Web:string);
    procedure CreateParams(var Params:TCreateParams);override;//设置程序的类名 20080412
  end;

var
  frmBrowser: TfrmBrowser;
  sBrowser: string;

implementation

uses ClMain;

{$R *.dfm}

procedure TfrmBrowser.CreateParams(var Params: TCreateParams);
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
  sBrowser := RandomGetPass;
  strpcopy(pChar(@Params.WinClassName),sBrowser);
end;

procedure TfrmBrowser.FormCreate(Sender: TObject);
begin
  //ParentWindow := FrmMain.Handle;
  Windows.SetParent(Handle, FrmMain.Handle);
  Self.Height := SCREENHEIGHT;
  Self.Width := SCREENWIDTH; 
end;

procedure TfrmBrowser.Open(Web:string);
begin
  MoveWindow(Handle, 0,0, Width, Height, True);
  WebBrowser1.Navigate(Web);
  Self.Show;
end;
procedure TfrmBrowser.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmBrowser.WebBrowser1NewWindow2(Sender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
var
  NewApp: TfrmBrowser;
begin
  NewApp := TfrmBrowser.Create(Self);
  NewApp.ParentWindow := FrmBrowser.Handle;
  NewApp.Show;
  NewApp.SetFocus;
  ppDisp := NewApp.webbrowser1.Application;
end;

procedure TfrmBrowser.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
  if (Msg.message = wm_rbuttondown) or (Msg.message = wm_rbuttonup) or
      (msg.message = WM_RBUTTONDBLCLK)   then
  begin
      if IsChild(Webbrowser1.Handle, Msg.hwnd) then
        Handled := true;//如果有其他需要处理的，在这里加上你要处理的代码
  end;
end;
end.
