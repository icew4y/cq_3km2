unit EditGame;

interface

uses
  Windows, Messages, SysUtils, Forms,
  StdCtrls, ExtCtrls,Common,GameLoginShare,
  HUtil32, RzLabel, RzLstBox, RzEdit,
  RzBmpBtn, Classes, Controls, Mask, jpeg;

type
  TFrmEditGame = class(TForm)
    Label11: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    RzLabel4: TRzLabel;
    ListBoxGame: TRzListBox;
    EditServerName: TRzEdit;
    EditGameAddr: TRzEdit;
    EditGamePort: TRzEdit;
    EditNotice: TRzEdit;
    EditHomeURL: TRzEdit;
    Image1: TImage;
    ButtonGameChange: TRzBmpButton;
    ButtonGameAdd: TRzBmpButton;
    ButtonGameDel: TRzBmpButton;
    ButtonGameSave: TRzBmpButton;
    btnCancel: TRzBmpButton;
    Label2: TLabel;
    procedure ListBoxGameClick(Sender: TObject);
    procedure EditServerNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditGameAddrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditGamePortKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditNoticeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditHomeURLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonGameChangeClick(Sender: TObject);
    procedure ButtonGameAddClick(Sender: TObject);
    procedure ButtonGameDelClick(Sender: TObject);
    procedure ButtonGameSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure GroupBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    SelServerInfo: pTServerInfo;
    procedure LoadLocalGameList;
    procedure SaveServerList();
  public
    procedure Open();
  end;

var
  FrmEditGame: TFrmEditGame;

implementation
uses Main, MsgBox;
{$R *.dfm}
procedure TfrmEditGame.Open();
begin
  SelServerInfo := nil;
  EditServerName.Text := '';
  EditGameAddr.Text := '';
  EditGamePort.Text := '7000';
  EditNotice.Text := 'http://';
  EditHomeURL.Text := 'http://';
  LoadLocalGameList;
  ShowModal;
end;

procedure TFrmEditGame.LoadLocalGameList;
var
  LoadList: Classes.TStringList;
  I: Integer;
  sLineText, sServerName, sServerIP, sServerPort, sServerNoticeURL, sServerHomeURL: string;
  ServerInfo: pTServerInfo;
begin
  ListBoxGame.Items.Clear;
  if FileExists(PChar(m_sMirClient)+m_sLocalGameListName) then begin
    LoadList := Classes.TStringList.Create();
    LoadList.LoadFromFile(PChar(m_sMirClient)+m_sLocalGameListName);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sServerName, ['|']);
        sLineText := GetValidStr3(sLineText, sServerIP, ['|']);
        sLineText := GetValidStr3(sLineText, sServerPort, ['|']);
        sLineText := GetValidStr3(sLineText, sServerNoticeURL, ['|']);
        sLineText := GetValidStr3(sLineText, sServerHomeURL, ['|']);
        if (sServerName <> '') and (sServerIP <> '') and (sServerPort <> '') then begin
          New(ServerInfo);
          ServerInfo.ServerArray := '用户收藏';
          ServerInfo.ServerName := sServerName;
          ServerInfo.ServerIP := sServerIP;
          ServerInfo.ServerPort := StrToInt(sServerPort);
          ServerInfo.ServerNoticeURL := sServerNoticeURL;
          ServerInfo.ServerHomeURL := sServerHomeURL;
          //g_ServerList.Add(ServerInfo);
        end;
        ListBoxGame.Items.AddObject(sServerName, TObject(ServerInfo));
      end;
    end;
  end;
  //Dispose(ServerInfo);
  LoadList.Free;
end;

procedure TfrmEditGame.SaveServerList();
var
  I: Integer;
  ServerInfo: pTServerInfo;
  ServerList: TStringlist;
  sLineText: string;
begin
  ServerList := TStringlist.Create;
  for I := 0 to ListBoxGame.Items.Count - 1 do begin
    ServerInfo := pTServerInfo(ListBoxGame.Items.Objects[I]);
    if ServerInfo <> nil then begin
      sLineText := ServerInfo.ServerName + '|' + ServerInfo.ServerIP + '|' + IntToStr(ServerInfo.ServerPort) +
        '|' + ServerInfo.ServerNoticeURL + '|' + ServerInfo.ServerHomeURL;
      ServerList.Add(sLineText);
    end;
  end;
  ServerList.SaveToFile(PChar(m_sMirClient)+m_sLocalGameListName);
  ServerList.Free;
end;
procedure TFrmEditGame.ListBoxGameClick(Sender: TObject);
begin
  try
    SelServerInfo := pTServerInfo(ListBoxGame.Items.Objects[ListBoxGame.ItemIndex]);
    EditServerName.Text := SelServerInfo.ServerName;
    EditGameAddr.Text := SelServerInfo.ServerIP;
    EditGamePort.Text := IntToStr(SelServerInfo.ServerPort);
    EditNotice.Text := SelServerInfo.ServerNoticeURL;
    EditHomeURL.Text := SelServerInfo.ServerHomeURL;
  except
    SelServerInfo := nil;
  end;
end;

procedure TFrmEditGame.EditServerNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditGameAddr.SetFocus ;
end;

procedure TFrmEditGame.EditGameAddrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditGamePort.SetFocus ;
end;

procedure TFrmEditGame.EditGamePortKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditNotice.SetFocus ;
end;

procedure TFrmEditGame.EditNoticeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then EditHomeURL.SetFocus ;
end;

procedure TFrmEditGame.EditHomeURLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IF Key=13 then ButtonGameAdd.Click;
end;

procedure TFrmEditGame.ButtonGameChangeClick(Sender: TObject);
var
  sServerName, sGameIPaddr, sGamePort: string;
  nGamePort, nItemIndex: Integer;
begin
  if SelServerInfo = nil then Exit;
  sServerName := Trim(EditServerName.Text);
  sGameIPaddr := Trim(EditGameAddr.Text);
  sGamePort := Trim(EditGamePort.Text);
  nGamePort := Str_ToInt(sGamePort, -1);
  if sServerName = '' then begin
    //MainFrm.bsSkinMessage1.MessageDlg('服务器名称，输入不正确！！！',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '服务器名称，输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditServerName.SetFocus;
    Exit;
  end;
  if sGameIPaddr = '' then begin
    //MainFrm.bsSkinMessage1.MessageDlg('服务器地址，输入不正确！！！',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '服务器地址，输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditGameAddr.SetFocus;
    Exit;
  end;
  if (nGamePort < 0) or (nGamePort > 65535) then begin
    //MainFrm.bsSkinMessage1.MessageDlg('服务器端口，输入不正确！！！',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '服务器端口，输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditGamePort.SetFocus;
    Exit;
  end;
  nItemIndex := ListBoxGame.ItemIndex;
  try
    ListBoxGame.Items.Strings[nItemIndex] := sServerName;
    SelServerInfo.ServerName := sServerName;
    SelServerInfo.ServerIP := sGameIPaddr;
    SelServerInfo.ServerPort := nGamePort;
    SelServerInfo.ServerNoticeURL := Trim(EditNotice.Text);
    SelServerInfo.ServerHomeURL := Trim(EditHomeURL.Text);
  except
    SelServerInfo := nil;
  end;
end;

procedure TFrmEditGame.ButtonGameAddClick(Sender: TObject);
var
  sServerName, sGameIPaddr, sGamePort: string;
  nGamePort: Integer;
  ServerInfo: pTServerInfo;
  I: Integer;
begin
  sServerName := Trim(EditServerName.Text);
  sGameIPaddr := Trim(EditGameAddr.Text);
  sGamePort := Trim(EditGamePort.Text);
  nGamePort := Str_ToInt(sGamePort, -1);
  if sServerName = '' then begin
    //MainFrm.bsSkinMessage1.MessageDlg('服务器名称，输入不正确！！！',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '服务器名称，输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditServerName.SetFocus;
    Exit;
  end;
  if sGameIPaddr = '' then begin
    //MainFrm.bsSkinMessage1.MessageDlg('服务器地址，输入不正确！！！',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '服务器地址，输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditGameAddr.SetFocus;
    Exit;
  end;
  if (nGamePort < 1024) or (nGamePort > 65535) then begin
    //MainFrm.bsSkinMessage1.MessageDlg('服务器端口，输入不正确！！！',mtError,[mbOK],0);
    FrmMessageBox.LabelHintMsg.Caption := '服务器端口，输入不正确！！！';
    FrmMessageBox.ShowModal;
    EditGamePort.SetFocus;
    Exit;
  end;
  for I := 0 to ListBoxGame.Items.Count - 1 do begin
    if ListBoxGame.Items.Strings[I] = sServerName then begin
      //MainFrm.bsSkinMessage1.MessageDlg('此私服已在列表中！！！',mtError,[mbOK],0);
      FrmMessageBox.LabelHintMsg.Caption := '此私服已在列表中！！！';
      FrmMessageBox.ShowModal;
      Exit;
    end;
  end;
  New(ServerInfo);
  ServerInfo.ServerName := sServerName;
  ServerInfo.ServerIP := sGameIPaddr;
  ServerInfo.ServerPort := nGamePort;
  ServerInfo.ServerNoticeURL := Trim(EditNotice.Text);
  ServerInfo.ServerHomeURL := Trim(EditHomeURL.Text);
  ListBoxGame.Items.AddObject(sServerName, TObject(ServerInfo));
  //Dispose(ServerInfo);
end;

procedure TFrmEditGame.ButtonGameDelClick(Sender: TObject);
begin
  if SelServerInfo = nil then Exit;
  //if Application.MessageDlg('是否确认删除此游戏?',mtWarning,[mbYes]+[mbNo],0) <> ID_YES then Exit;
    if Application.MessageBox('是否确认删除此游戏?','提示', MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;
  try
    ListBoxGame.Items.Delete(ListBoxGame.ItemIndex);
  except
  end;
end;

procedure TFrmEditGame.ButtonGameSaveClick(Sender: TObject);
begin
  SaveServerList();
  FrmMain.TreeView1.Items.Clear;
  g_ServerList.Clear;
  FrmMain.LoadServerList;
  FrmMain.LoadLocalGameList;
  Close;
end;

procedure TFrmEditGame.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmEditGame.GroupBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TFrmEditGame.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

end.
