unit AddGameList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Mask, RzEdit, RzSpnEdt;

type
  TFrmAddGameList = class(TForm)
    grp1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EdtServerName: TEdit;
    EdtServerIP: TEdit;
    EdtServerNoticeURL: TEdit;
    EdtServerHomeURL: TEdit;
    ComBoBoxServerArray: TComboBox;
    EdtGatePass: TEdit;
    BtnOK: TButton;
    BtnCancel: TButton;
    EdtServerPort: TEdit;
    Label8: TLabel;
    EdtGameItemsURL: TEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure EdtServerPortKeyPress(Sender: TObject; var Key: Char);
  private
    procedure Clear();
    function Check():Boolean;
  public
    procedure Add();
    procedure Change(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL, GameItemsUrl ,ServerGatePass:String);
  end;

var
  FrmAddGameList: TFrmAddGameList;
  WirteType: Integer;
implementation

uses MakeLogin;

{$R *.dfm}

{ TFrmAddGameList }

procedure TFrmAddGameList.Add;
begin
  Caption := '增加服务器列表';
  Clear();
  ComBoBoxServerArray.Items.Text := FrmMakeLogin.ComboBox1.Items.Text;
  ComBoBoxServerArray.ItemIndex := 0;
  WirteType := 0;
  ShowModal;
end;

procedure TFrmAddGameList.Clear;
begin
  EdtServerName.Text := '';
  EdtServerIP.Text := '';
  EdtServerPort.Text := '7000';
  EdtServerNoticeURL.Text := '';
  EdtServerHomeURL.Text := '';
  EdtGameItemsURL.Text := '';
  ComBoBoxServerArray.Clear;
  EdtGatePass.Text := '';
end;

procedure TFrmAddGameList.FormDestroy(Sender: TObject);
begin
  FrmAddGameList := nil;
end;

procedure TFrmAddGameList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmAddGameList.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

function TFrmAddGameList.Check: Boolean;
var
  I: Integer;
begin
  if ComBoBoxServerArray.Items[ComBoBoxServerArray.ItemIndex] = '' then begin
      Application.MessageBox('请选择服务器分组', 'Error', MB_OK + MB_ICONSTOP);
      ComBoBoxServerArray.SetFocus;
      Result:=FALSE;
      Exit;
  end;
  if EdtServerName.Text = '' then begin
      Application.MessageBox('请添写服务器名称', 'Error', MB_OK + MB_ICONSTOP);
      EdtServerName.SetFocus;
      Result:=FALSE;
      Exit;
  end;
  for I:=1 to Length(EdtServerName.Text) do begin
    if EdtServerName.Text[I] in ['\','/',':','*','?','"','<','>','|'] then begin
      Application.MessageBox('服务器名称不能包含下列任何字符之一：' + #13#10 + 
        '          \/:*?"<>|', '提示', MB_OK + MB_ICONINFORMATION);
      EdtServerName.SetFocus;
      Result:=False;
      Exit;
    end;
  end;
  if EdtServerIp.Text = '' then begin
      Application.MessageBox('请添写服务器IP地址', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtServerIp.SetFocus;
      Result:=FALSE;
      Exit;
  end;
  if EdtServerPort.Text = '' then begin
      Application.MessageBox('请添写服务器端口', 'Error', MB_OK +
        MB_ICONSTOP);
      EdtServerPort.SetFocus;
      Result:=FALSE;
      exit;
  end;
  if EdtServerNoticeURL.Text = '' then begin
      Application.MessageBox('请添写服务器公告地址', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtServerNoticeURL.SetFocus;
      Result:=FALSE;
      Exit;
  end;
  if EdtServerHomeURL.Text = '' then begin
      Application.MessageBox('请添写服务器主页地址', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtServerHomeURL.SetFocus;
      Result:=FALSE;
      exit;
  end;
  Result:=TRUE;
end;

procedure TFrmAddGameList.BtnOKClick(Sender: TObject);
begin
  if Check then begin
    case WirteType of
      0:FrmMakeLogin.AddListView(ComBoBoxServerArray.Text,EdtServerName.Text,EdtServerIP.Text,EdtServerPort.Text,EdtServerNoticeURL.Text,EdtServerHomeURL.Text, EdtGameItemsURL.Text, EdtGatePass.Text);
      1:FrmMakeLogin.ChangeListView(ComBoBoxServerArray.Text,EdtServerName.Text,EdtServerIP.Text,EdtServerPort.Text,EdtServerNoticeURL.Text,EdtServerHomeURL.Text, EdtGameItemsURL.Text ,EdtGatePass.Text);
    end;
    Close;
  end;
end;

procedure TFrmAddGameList.Change(ServerArray, ServerName, ServerIp,
  ServerPort, ServerNoticeURL, ServerHomeURL, GameItemsUrl ,ServerGatePass: String);
begin
  Caption := '修改服务器列表';
  Clear();
  EdtServerPort.Text      := '';
  EdtServerName.Text := ServerName;
  EdtServerIp.Text :=  ServerIp;
  EdtServerPort.Text := ServerPort;
  EdtServerNoticeURL.Text := ServerNoticeURL;
  EdtServerHomeURL.Text := ServerHomeURL;
  EdtGameItemsURL.Text := GameItemsUrl;
  ComBoBoxServerArray.Items.Text := FrmMakeLogin.ComboBox1.Items.Text;
  ComBoBoxServerArray.ItemIndex := ComBoBoxServerArray.Items.IndexOf(ServerArray);
  EdtGatePass.Text := ServerGatePass;
  WirteType := 1;
  ShowModal;
end;

procedure TFrmAddGameList.EdtServerPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9',#8,#13]) then Key := #0;
end;

end.
