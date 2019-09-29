unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IniFiles, HUtil32, MShare, SDK, ExtCtrls;

type
  TGameZone = record
    Name: string;
    Ipaddr: string;
    Port: Integer;
  end;
  pTGameZone = ^TGameZone;

  TFrmLogin = class(TForm)
    GroupBox1: TGroupBox;
    ListView: TListView;
    ButtonStart: TButton;
    ButtonClose: TButton;
    CheckBoxWindowMode: TCheckBox;
    ButtonAdd: TButton;
    ButtonDel: TButton;
    ButtonSave: TButton;
    EditServerAddr: TEdit;
    EditServerPort: TEdit;
    EditServerName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBoxScreenMode: TComboBox;
    RadioGroup: TRadioGroup;
    ComboBoxBitCount: TComboBox;
    CheckBoxVSync: TCheckBox;
    CheckBoxD3DFormat: TCheckBox;
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListViewClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBoxWindowModeClick(Sender: TObject);
  private
    { Private declarations }
    procedure RefGameList;
    procedure LoadGameList;
    procedure UnLoadGameList;
    procedure SaveGameList;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;
  g_GameList: TList;
implementation
uses GameImages;
{$R *.dfm}

procedure TFrmLogin.ButtonStartClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  GameZone: pTGameZone;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    GameZone := pTGameZone(ListItem.SubItems.Objects[0]);
    g_sServerAddr := GameZone.Ipaddr;
    g_nServerPort := GameZone.Port;
    g_boWindowMode := CheckBoxWindowMode.Checked;
    ButtonStart.ModalResult := mrOk;
    g_nScreenMode := ComboBoxScreenMode.ItemIndex;
    if RadioGroup.ItemIndex < 0 then RadioGroup.ItemIndex := 3;
    g_nClientVersion := RadioGroup.ItemIndex;
    g_boVSync := CheckBoxVSync.Checked;
    g_boD3DFormat := CheckBoxD3DFormat.Checked;
    if ComboBoxBitCount.ItemIndex = 0 then g_nBitCount := 32 else g_nBitCount := 16;

    Close;
  end else Application.MessageBox('请选择你要登陆的服务器！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

procedure TFrmLogin.ButtonCloseClick(Sender: TObject);
begin
  ButtonStart.ModalResult := mrNone;
  ButtonClose.ModalResult := mrOk;
  Close;
end;

procedure TFrmLogin.RefGameList;
var
  I: Integer;
  GameZone: pTGameZone;
  ListItem: TListItem;
begin
  ListView.Items.Clear;
  for I := 0 to g_GameList.Count - 1 do begin
    GameZone := g_GameList.Items[I];
    ListItem := ListView.Items.Add;
    ListItem.Caption := GameZone.Name;
    ListItem.SubItems.AddObject(GameZone.Ipaddr, TObject(GameZone));
    ListItem.SubItems.Add(IntToStr(GameZone.Port));
  end;
end;

procedure TFrmLogin.LoadGameList;
var
  I: Integer;
  IniFile: TIniFile;
  StringList: TStringList;
  GameZone: pTGameZone;
  sname: string;
  sIpaddr: string;
  sport: string;
  nPort: Integer;
begin
  IniFile := TIniFile.Create('.\GameList.ini');
  StringList := TStringList.Create;
  IniFile.ReadSections(StringList);
  for I := 0 to StringList.Count - 1 do begin
    sname := IniFile.ReadString(StringList.Strings[I], 'ServerName', '');
    sIpaddr := IniFile.ReadString(StringList.Strings[I], 'ServerAddr', '');
    sport := IniFile.ReadString(StringList.Strings[I], 'ServerPort', '');
    if (sname <> '') and (sIpaddr <> '') and (sport <> '') then begin
      nPort := Str_ToInt(sport, 7000);
      New(GameZone);
      GameZone.Name := sname;
      GameZone.Ipaddr := sIpaddr;
      GameZone.Port := nPort;
      g_GameList.Add(GameZone);
    end;
  end;
  StringList.Free;
  IniFile.Free;
  if g_GameList.Count = 0 then begin
    New(GameZone);
    GameZone.Name := '传奇外传';
    GameZone.Ipaddr := '127.0.0.1';
    GameZone.Port := 7000;
    g_GameList.Add(GameZone);
  end;
end;

procedure TFrmLogin.UnLoadGameList;
var
  I: Integer;
begin
  for I := 0 to g_GameList.Count - 1 do begin
    Dispose(pTGameZone(g_GameList.Items[I]));
  end;
  g_GameList.Clear;
end;

procedure TFrmLogin.SaveGameList;
var
  I: Integer;
  IniFile: TIniFile;
  GameZone: pTGameZone;
begin
  IniFile := TIniFile.Create('.\GameList.ini');
  for I := 0 to g_GameList.Count - 1 do begin
    GameZone := g_GameList.Items[I];
    IniFile.WriteString(IntToStr(I), 'ServerName', GameZone.Name);
    IniFile.WriteString(IntToStr(I), 'ServerAddr', GameZone.Ipaddr);
    IniFile.WriteInteger(IntToStr(I), 'ServerPort', GameZone.Port);
  end;
  IniFile.Free;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  g_GameList := TList.Create;
  LoadGameList;
  RefGameList;
  if ListView.Items.Count > 0 then ListView.itemindex := 0;
end;

procedure TFrmLogin.ListViewClick(Sender: TObject);
var
  ListItem: TListItem;
  GameZone: pTGameZone;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    GameZone := pTGameZone(ListItem.SubItems.Objects[0]);
    EditServerName.Text := GameZone.Name;
    EditServerAddr.Text := GameZone.Ipaddr;
    EditServerPort.Text := IntToStr(GameZone.Port);
  end;
end;

procedure TFrmLogin.ButtonDelClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  GameZone: pTGameZone;
begin
  ListItem := ListView.Selected;
  if ListItem <> nil then begin
    GameZone := pTGameZone(ListItem.SubItems.Objects[0]);
    ListView.DeleteSelected;
    for I := 0 to g_GameList.Count - 1 do begin
      if GameZone = g_GameList.Items[I] then begin
        Dispose(pTGameZone(g_GameList.Items[I]));
        g_GameList.Delete(I);
        RefGameList;
        Break;
      end;
    end;
  end;
end;

procedure TFrmLogin.ButtonSaveClick(Sender: TObject);
begin
  SaveGameList;
end;

procedure TFrmLogin.ButtonAddClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  GameZone: pTGameZone;
  sname: string;
  sIpaddr: string;
  sport: string;
  nPort: Integer;
begin
  sname := Trim(EditServerName.Text);
  sIpaddr := Trim(EditServerAddr.Text);
  sport := Trim(EditServerPort.Text);
  nPort := Str_ToInt(sport, -1);

  if sname = '' then begin
    Application.MessageBox('服务器名称，输入不正确！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
    EditServerName.SetFocus;
    Exit;
  end;

  for I := 0 to g_GameList.Count - 1 do begin
    GameZone := g_GameList.Items[I];
    if (GameZone.Name = sname) and (GameZone.Ipaddr = sIpaddr) then begin
      //Dispose(pTGameZone(g_GameList.Items[I]));
      //g_GameList.Delete(I);
      Application.MessageBox('该服务器已经存在！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
      EditServerName.SetFocus;
      Exit;
    end;
  end;

  if sIpaddr = '' then begin
    Application.MessageBox('服务器地址，输入不正确！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
    EditServerAddr.SetFocus;
    Exit;
  end;
  if (nPort < 0) or (nPort > 65535) then begin
    Application.MessageBox('服务器端口，输入不正确！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
    EditServerPort.SetFocus;
    Exit;
  end;

  New(GameZone);
  GameZone.Name := sname;
  GameZone.Ipaddr := sIpaddr;
  GameZone.Port := nPort;
  g_GameList.Add(GameZone);
  RefGameList;
  {ListItem := ListView.Items.Add;
  ListItem := ListView.Items.Add;
  ListItem.Caption := GameZone.Name;
  ListItem.SubItems.AddObject(GameZone.Ipaddr, TObject(GameZone));
  ListItem.SubItems.Add(IntToStr(GameZone.Port));  }
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
  UnLoadGameList;
  g_GameList.Free;
end;

procedure TFrmLogin.CheckBoxWindowModeClick(Sender: TObject);
begin
  g_boWindowMode := CheckBoxWindowMode.Checked;
end;

end.

