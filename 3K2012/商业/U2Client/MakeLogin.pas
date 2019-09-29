unit MakeLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Mask, RzEdit, RzBtnEdt, Buttons,
  RzLabel, ExtCtrls, RzPanel, RzRadGrp, Menus, IdAntiFreezeBase,
  IdAntiFreeze, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP, ExtDlgs, Jpeg, IdFTPCommon, RzBHints, IniFiles, Spin, RzCmboBx, DBTables, Share;

type
  TFrmMakeLogin = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtLoginName: TEdit;
    EdtClientFileName: TEdit;
    GroupBox5: TGroupBox;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    EdtMakeKey: TEdit;
    BtnMakeLogin: TButton;
    BtnMakeGate: TButton;
    GroupBox6: TGroupBox;
    Label7: TLabel;
    ComboBox1: TComboBox;
    BtnAddArray: TButton;
    BtnDelArray: TButton;
    GroupBox7: TGroupBox;
    ListView1: TListView;
    Memo1: TMemo;
    GroupBox8: TGroupBox;
    BtnGameListAdd: TSpeedButton;
    BtnGameListRea: TSpeedButton;
    BtnGameListDel: TSpeedButton;
    Button5: TButton;
    BtnSaveGameListConfig: TButton;
    ListViewGameMon: TListView;
    Label8: TLabel;
    GroupBox9: TGroupBox;
    Label9: TLabel;
    EdtGameMon: TEdit;
    BtnGameMonAdd: TSpeedButton;
    BtnChangeGameMon: TSpeedButton;
    BtnGameMonDel: TSpeedButton;
    RzLabel12: TRzLabel;
    GameMonTypeRadioGroup: TRzRadioGroup;
    FileTypeRadioGroup: TRzRadioGroup;
    Button11: TButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ComBoxDir: TComboBox;
    EdtFileName: TEdit;
    EdtDownUrl: TEdit;
    EdtMd5: TEdit;
    BtnOpenFile: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    BtnSaveGameMon: TButton;
    Button17: TButton;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    IdFTP1: TIdFTP;
    IdAntiFreeze1: TIdAntiFreeze;
    ProgressBar1: TProgressBar;
    Label16: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    EdtAssistantFilter: TEdit;
    BtnAssistantFilter: TButton;
    EdtLoginMainImages: TEdit;
    BtnLoginMainImages: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    RzBalloonHints1: TRzBalloonHints;
    TabSheet6: TTabSheet;
    GroupBox2: TGroupBox;
    ListViewTzItemList: TListView;
    BtnTzAdd: TButton;
    BtnTzDel: TButton;
    BtnTzChg: TButton;
    BtnTzSave: TButton;
    GroupBox12: TGroupBox;
    Label3: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Memo: TMemo;
    EdtTzCaption: TEdit;
    SpinEdit30: TSpinEdit;
    EdtTzItems: TEdit;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    SpinEdit8: TSpinEdit;
    SpinEdit9: TSpinEdit;
    SpinEdit10: TSpinEdit;
    SpinEdit11: TSpinEdit;
    SpinEdit12: TSpinEdit;
    SpinEdit13: TSpinEdit;
    SpinEdit14: TSpinEdit;
    SpinEdit15: TSpinEdit;
    Button1: TButton;
    Label35: TLabel;
    CheckBox3: TCheckBox;
    EdtTzHintFile: TEdit;
    BtnTzHintFile: TButton;
    Button6: TButton;
    BtnTzHelp: TButton;
    BtnTzOpen: TButton;
    Label37: TLabel;
    CheckBox4: TCheckBox;
    EdtPulsDescFile: TEdit;
    BtnPulsDescFile: TButton;
    Button4: TButton;
    LoginVerNo: TRzRadioGroup;
    cboLoginVerNo: TRzComboBox;
    ListViewFilterItem: TListView;
    GroupBox13: TGroupBox;
    BtnFilterOpen: TButton;
    BtnFilterAdd: TButton;
    BtnFilterSave: TButton;
    LabelItemName: TLabel;
    EditFilterItemName: TEdit;
    LabelItemType: TLabel;
    ComboBoxItemFilter: TComboBox;
    GroupBox14: TGroupBox;
    CheckBoxHintItem: TCheckBox;
    CheckBoxPickUpItem: TCheckBox;
    CheckBoxShowItemName: TCheckBox;
    LabelTips: TRzLabel;
    BtnFilterChg: TButton;
    BtnFilterDel: TButton;
    BtnFromDB: TButton;
    SaveDialog1: TSaveDialog;
    Button2: TButton;
    Memo2: TMemo;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    procedure BtnAddArrayClick(Sender: TObject);
    procedure BtnDelArrayClick(Sender: TObject);
    procedure BtnGameListAddClick(Sender: TObject);
    procedure BtnGameListReaClick(Sender: TObject);
    procedure BtnGameListDelClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BtnOpenFileClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure BtnGameMonAddClick(Sender: TObject);
    procedure BtnChangeGameMonClick(Sender: TObject);
    procedure BtnGameMonDelClick(Sender: TObject);
    procedure BtnSaveGameMonClick(Sender: TObject);
    procedure ListViewDisallowMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure BtnMakeLoginClick(Sender: TObject);
    procedure BtnAssistantFilterClick(Sender: TObject);
    procedure BtnLoginMainImagesClick(Sender: TObject);
    procedure IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdFTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure BtnMakeGateClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure BtnSaveGameListConfigClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure BtnTzAddClick(Sender: TObject);
    procedure BtnTzDelClick(Sender: TObject);
    procedure BtnTzChgClick(Sender: TObject);
    procedure BtnTzSaveClick(Sender: TObject);
    procedure BtnTzHelpClick(Sender: TObject);
    procedure BtnTzOpenClick(Sender: TObject);
    procedure ListViewTzItemListClick(Sender: TObject);
    procedure BtnTzHintFileClick(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure BtnPulsDescFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboLoginVerNoChange(Sender: TObject);
    procedure BtnFromDBClick(Sender: TObject);
    procedure ComboBoxItemFilterChange(Sender: TObject);
    procedure ListViewFilterItemClick(Sender: TObject);
    procedure BtnFilterDelClick(Sender: TObject);
    procedure BtnFilterChgClick(Sender: TObject);
    procedure BtnFilterAddClick(Sender: TObject);
    procedure BtnFilterOpenClick(Sender: TObject);
    procedure BtnFilterSaveClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function InGameMonList(sFilterMsg: string): Boolean;
    procedure LoadConfig();
    procedure GetFiterItemFormBDE();
  public
    procedure RefListViewFilterItem(ItemType: TFilterItemType);
    procedure Open();
    procedure AddListView(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL, GameItemsUrl ,ServerGatePass:String);
    procedure ChangeListView(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL, GameItemsURL ,ServerGatePass:String);
    procedure UpFile();
    procedure MakeGate();
  end;

var
  FrmMakeLogin: TFrmMakeLogin;
  dwMakeTick: LongWord;
implementation

uses AddGameList, Md5, Main, EDcodeUnit, HUtil32, uTzHelp,
  uSelectDB, uDesignMain;

{$R *.dfm}
procedure TFrmMakeLogin.Open;
begin
  if not g_boFirstOpen then begin
    LoadConfig();
    g_boFirstOpen := True;
    BtnTzDel.Enabled := False;
    BtnTzChg.Enabled := False;
    BtnTzSave.Enabled := False;
    BtnFilterDel.Enabled := False;
    BtnFilterChg.Enabled := False;
    BtnFilterSave.Enabled := False;
    {$IF g_Version = 1}
    TabSheet6.TabVisible := False;
    {$IFEND}
  end;
  BtnMakeLogin.Enabled := True;
  BtnMakeGate.Enabled := True;
  ProgressBar1.Position := 0;
  ShowModal;
end;
//==============================================================================
//游戏列表相关代码
procedure TFrmMakeLogin.AddListView(ServerArray, ServerName, ServerIp,
  ServerPort, ServerNoticeURL, ServerHomeURL, GameItemsURL ,ServerGatePass: String);
var
  ListItem: TListItem;
begin
  ListView1.Items.BeginUpdate;
  try
    ListItem := ListView1.Items.Add;
    ListItem.Caption := ServerArray;
    ListItem.SubItems.Add(ServerName);
    ListItem.SubItems.Add(ServerIp);
    ListItem.SubItems.Add(ServerPort);
    ListItem.SubItems.Add(ServerNoticeURL);
    ListItem.SubItems.Add(ServerHomeURL);
    ListItem.SubItems.Add(GameItemsURL);
    ListItem.SubItems.Add(ServerGatePass);
  finally
    ListView1.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnAddArrayClick(Sender: TObject);
var
  str: string;
  I: Integer;
begin
  str:= InputBox('增加','请输入你要增加的服务器分组：','');
  if str <> '' then begin
    for I:=0 to ComBoBox1.Items.Count-1 do begin
      if ComBoBox1.Items.Strings[I] = str then begin
        Application.MessageBox('此服务器分组已在列表中！！！', 'Error', MB_OK 
          + MB_ICONSTOP);
        Exit;
      end;
    end;
  ComBoBox1.Items.Add(str);
  ComBoBox1.ItemIndex := ComBoBox1.Items.Count-1;
  end;
end;

procedure TFrmMakeLogin.BtnDelArrayClick(Sender: TObject);
begin
  if Application.MessageBox(Pchar('是否确定删除分组 ['+ComBoBox1.items[ComBoBox1.ItemIndex]+'] 信息？'), '提示', MB_YESNO + MB_ICONINFORMATION) = IDYES then begin
    ComBoBox1.Items.Delete(ComBoBox1.ItemIndex);
    ComBoBox1.ItemIndex:=ComBoBox1.ItemIndex-1;
  end;
end;


procedure TFrmMakeLogin.BtnGameListAddClick(Sender: TObject);
begin
  FrmAddGameList := TFrmAddGameList.Create(Owner);
  FrmAddGameList.Add;
  FrmAddGameList.Free;
end;

procedure TFrmMakeLogin.BtnGameListReaClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem <> nil then begin
    if FrmAddGameList = nil then FrmAddGameList := TFrmAddGameList.Create(Owner);
    FrmAddGameList.Change(ListItem.Caption,ListItem.SubItems.Strings[0],ListItem.SubItems.Strings[1],ListItem.SubItems.Strings[2],ListItem.SubItems.Strings[3],ListItem.SubItems.Strings[4],ListItem.SubItems.Strings[5],ListItem.SubItems.Strings[6]);
    FrmAddGameList.Free;
  end else Application.MessageBox('请选择你要修改的信息！', 'Error', MB_OK + 
    MB_ICONSTOP);
end;

procedure TFrmMakeLogin.BtnGameListDelClick(Sender: TObject);
begin
   ListView1.Items.BeginUpdate;
  try
    if ListView1.Selected <> nil then
      ListView1.DeleteSelected
      else Application.MessageBox('请选择你要删除的信息！', 'Error', MB_OK + 
        MB_ICONSTOP);
  finally
    ListView1.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.ChangeListView(ServerArray, ServerName, ServerIp,
  ServerPort, ServerNoticeURL, ServerHomeURL, GameItemsURL ,ServerGatePass: String);
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  try
    nItemIndex := ListView1.ItemIndex;
    ListItem := ListView1.Items.Item[nItemIndex];
    ListItem.Caption := ServerArray;
    ListItem.SubItems.Strings[0] := ServerName;
    ListItem.SubItems.Strings[1] := ServerIp;
    ListItem.SubItems.Strings[2] := ServerPort;
    ListItem.SubItems.Strings[3] := ServerNoticeURL;
    ListItem.SubItems.Strings[4] := ServerHomeURL;
    ListItem.SubItems.Strings[5] := GameItemsURL;
    ListItem.SubItems.Strings[6] := ServerGatePass;
  except
  end;
end;

procedure TFrmMakeLogin.Button5Click(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;
  sServerArray, sServerName, sServerIP, sServerPort, sServerNoticeURL, sServerHomeURL, sGameItemsURL, sGatePass: String;
  sFileName, sLineText: String;
begin
  if ListView1.Items.Count <> 0 then begin
    sFileName := 'QKServerList.txt';
    SaveList := Classes.TStringList.Create();
    SaveList.Add(';服务器分组'#9'游戏名称'#9'游戏IP地址'#9'端口'#9'公告地址'#9'网站主页'#9'装备展示'#9'网关密码');
    ListView1.Items.BeginUpdate;
    try
      for I := 0 to ListView1.Items.Count - 1 do begin
        ListItem := ListView1.Items.Item[I];
        sServerArray     := ListItem.Caption;
        sServerName      := ListItem.SubItems.Strings[0];
        sServerIP        := ListItem.SubItems.Strings[1];
        sServerPort      := ListItem.SubItems.Strings[2];
        sServerNoticeURL := ListItem.SubItems.Strings[3];
        sServerHomeURL   := ListItem.SubItems.Strings[4];
        sGameItemsURL    := ListItem.SubItems.Strings[5];
        sGatePass        := ListItem.SubItems.Strings[6];
        sLineText := sServerArray + '|' + sServerName + '|' + sServerIP + '|' + sServerPort + '|' + sServerNoticeURL + '|' + sServerHomeURL + '|' + sGameItemsURL + '|' + sGatePass;
        SaveList.Add(sLineText);
      end;
    finally
      ListView1.Items.EndUpdate;
    end;
    SaveList.Text := Trim(SaveList.Text);
    SaveList.SaveToFile(ExtractFilePath(ParamStr(0))+sFileName);
    SaveList.Free;
    Application.MessageBox('游戏列表生成成功' + #13#10 + 
      '请复制目录下的 QKServerList.txt 传到你的网站目录下即可', '提示', MB_OK
      + MB_ICONINFORMATION);
  end else Application.MessageBox('你还没有添加游戏哦！', 'Error', MB_OK + 
    MB_ICONSTOP);
end;
//==============================================================================
//游戏更新配置相关代码
procedure TFrmMakeLogin.BtnOpenFileClick(Sender: TObject);
begin
  OpenDialog1.Filter := '游戏补丁文件|*.*';
  if OpenDialog1.Execute then begin
    EdtFileName.Text := ExtractFileName(OpenDialog1.FileName);
    EdtMd5.Text := RivestFile(OpenDialog1.FileName);
  end;
end;

procedure TFrmMakeLogin.Button11Click(Sender: TObject);
var
  Dir: String;
begin
  case ComBoxDir.ItemIndex of
    0:Dir := 'Data/';
    1:Dir := 'Map/';
    2:Dir := 'Wav/';
    3:Dir := './';
  end;
  if ComBoxDir.Text = '' then begin
      Application.MessageBox('请选择客户端更新目录', 'Error', MB_OK + 
        MB_ICONSTOP);
      ComBoxDir.SetFocus;
      exit;
  end;
  if EdtFileName.Text = '' then begin
      Application.MessageBox('请选择文件来获取文件名', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtFileName.SetFocus;
      exit;
  end;
  if EdtDownUrl.Text = '' then begin
      Application.MessageBox('下载地址怎么能空？', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtDownUrl.SetFocus;
      exit;
  end;
  if EdtMd5.Text = '' then begin
      Application.MessageBox('请选择文件来获取文件MD5值', 'Error', MB_OK + 
        MB_ICONSTOP);
      EdtMd5.SetFocus;
      Exit;
  end;
  Memo1.Lines.Add(IntToStr(FileTypeRadioGroup.ItemIndex) +#9+ Dir +#9+ EdtFileName.Text +#9+ EdtMd5.Text +#9+ EdtDownUrl.Text);
end;

procedure TFrmMakeLogin.Button13Click(Sender: TObject);
var
  sPatchFile: String;
  SaveList: Classes.TStringList;
begin
  sPatchFile := 'QKPatchList.txt';
  SaveList := Classes.TStringList.Create();
  SaveList.Text := Memo1.Lines.Text;
  SaveList.SaveToFile(ExtractFilePath(ParamStr(0))+sPatchFile);
  SaveList.Free;
  Application.MessageBox('游戏更新列表生成成功'+#13+'请复制目录下的'+' QKPatchList.txt '+'传到你的网站目录下即可', '提示', MB_OK +
    MB_ICONINFORMATION);
end;

procedure TFrmMakeLogin.Button14Click(Sender: TObject);
begin
  OpenDialog1.Filter := '游戏更新文件(*.TxT)|*.Txt';
  if OpenDialog1.Execute then begin
     Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
     Application.MessageBox(PChar('读取更新列表文件 '+OpenDialog1.FileName+' 成功！'), '提示', MB_OK +
       MB_ICONINFORMATION);
  end;
end;

procedure TFrmMakeLogin.Button15Click(Sender: TObject);
var
  sPatchFile: String;
begin
  sPatchFile := '更新补丁记录.txt';
  Memo1.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+sPatchFile);
  Application.MessageBox('游戏更新列表保存成功'+#13+'请保管好 更新补丁记录.txt文件 '+'以后编辑升级补丁文件编辑就靠他了！', '提示', MB_OK +
    MB_ICONINFORMATION);
end;
//==============================================================================
//反外挂配置相关代码


procedure TFrmMakeLogin.BtnGameMonAddClick(Sender: TObject);
var
  sGameMonName: string;
  ListItem: TListItem;
  sGameTyep: string;
begin
  sGameMonName := Trim(EdtGameMon.Text);
  if sGameMonName = '' then begin
    Application.MessageBox('请输入外挂特征名称！', 'Error', MB_OK + 
      MB_ICONSTOP);
    Exit;
  end;
  if InGameMonList(sGameMonName) then begin
    Application.MessageBox('你输入的外挂特征名称已经存在！！！', 'Error', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  case GameMonTypeRadioGroup.ItemIndex of
    0: sGameTyep := '标题特征';
    1: sGameTyep := '进程特征';
    2: sGameTyep := '模块特征';
  end;
  ListViewGameMon.Items.BeginUpdate;
  try
    ListItem := ListViewGameMon.Items.Add;
    ListItem.Caption := sGameTyep;
    ListItem.SubItems.Add(sGameMonName);
  finally
    ListViewGameMon.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnChangeGameMonClick(Sender: TObject);
var
  sGameMonName: string;
  ListItem: TListItem;
  sGameTyep: string;
begin
  sGameMonName := Trim(EdtGameMon.Text);
  if sGameMonName = '' then begin
    Application.MessageBox('请输入外挂特征名称！', 'Error', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  if InGameMonList(sGameMonName) then begin
    Application.MessageBox('你输入的外挂特征名称已经存在！！！', 'Error', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  case GameMonTypeRadioGroup.ItemIndex of
    0: sGameTyep := '标题特征';
    1: sGameTyep := '进程特征';
    2: sGameTyep := '模块特征';
  end;
  ListViewGameMon.Items.BeginUpdate;
  try
    ListItem := ListViewGameMon.Items.Item[ListViewGameMon.ItemIndex];
    ListItem.Caption := sGameTyep;
    ListItem.SubItems.Strings[0] := (sGameMonName);
  finally
    ListViewGameMon.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnGameMonDelClick(Sender: TObject);
begin
  try
    ListViewGameMon.DeleteSelected;
  except
  end;
end;

procedure TFrmMakeLogin.BtnSaveGameMonClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;
  sGameMonName: string;
  sGameTyepName: string;
begin
  SaveList := TStringList.Create;
  SaveList.Add(';特征分类'#9'外挂特征');
  ListViewGameMon.Items.BeginUpdate;
  try
    for I := 0 to ListViewGameMon.Items.Count - 1 do begin
      ListItem := ListViewGameMon.Items.Item[I];
      sGameTyepName := ListItem.Caption;
      sGameMonName := ListItem.SubItems.Strings[0];
      SaveList.Add(sGameTyepName + #9 + sGameMonName);
    end;
  finally
    ListViewGameMon.Items.EndUpdate;
  end;
  SaveList.SaveToFile(ExtractFilePath(ParamStr(0))+GameMonName);
  SaveList.Free;
  Application.MessageBox('反外挂列表生成成功'+#13+'请复制目录下的'+' QKGameMonList.txt '+'传到你的网站目录下即可', '提示', MB_OK +
    MB_ICONINFORMATION);
end;

function TFrmMakeLogin.InGameMonList(sFilterMsg: string): Boolean;
var
  I: Integer;
  ListItem: TListItem;
begin
  Result := False;
  ListViewGameMon.Items.BeginUpdate;
  try
    for I := 0 to ListViewGameMon.Items.Count - 1 do begin
      ListItem := ListViewGameMon.Items.Item[I];
      if CompareText(sFilterMsg, ListItem.SubItems.Strings[0]) = 0 then begin
        Result := TRUE;
        break;
      end;
    end;
  finally
    ListViewGameMon.Items.EndUpdate;
  end;
end;


//==============================================================================
//内挂过滤配置相关代码

procedure TFrmMakeLogin.ListViewDisallowMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end;
end;

procedure TFrmMakeLogin.N1Click(Sender: TObject);
var
  ListItem: TListItem;
  FilterItem: pTFilterItem;
begin
  ListItem := ListViewFilterItem.Selected;
  if ListItem = nil then Exit;
  FilterItem := pTFilterItem(ListItem.SubItems.Objects[0]);
  if FilterItem = nil then Exit;
  FilterItem.ItemType := FilterItem.ItemType;
  FilterItem.sItemName := FilterItem.sItemName;
  FilterItem.boHintMsg := not FilterItem.boHintMsg;
  FilterItem.boPickup := FilterItem.boPickup;
  FilterItem.boShowName := FilterItem.boShowName;
  RefListViewFilterItem(FilterItem.ItemType);
  BtnFilterDel.Enabled := False;
  BtnFilterChg.Enabled := False;
  BtnFilterSave.Enabled := True;
end;

procedure TFrmMakeLogin.N2Click(Sender: TObject);
var
  ListItem: TListItem;
  FilterItem: pTFilterItem;
begin
  ListItem := ListViewFilterItem.Selected;
  if ListItem = nil then Exit;
  FilterItem := pTFilterItem(ListItem.SubItems.Objects[0]);
  if FilterItem = nil then Exit;
  FilterItem.ItemType := FilterItem.ItemType;
  FilterItem.sItemName := FilterItem.sItemName;
  FilterItem.boHintMsg := FilterItem.boHintMsg;
  FilterItem.boPickup := not FilterItem.boPickup;
  FilterItem.boShowName := FilterItem.boShowName;
  RefListViewFilterItem(FilterItem.ItemType);
  BtnFilterDel.Enabled := False;
  BtnFilterChg.Enabled := False;
  BtnFilterSave.Enabled := True;
end;

procedure TFrmMakeLogin.N3Click(Sender: TObject);
var
  ListItem: TListItem;
  FilterItem: pTFilterItem;
begin
  ListItem := ListViewFilterItem.Selected;
  if ListItem = nil then Exit;
  FilterItem := pTFilterItem(ListItem.SubItems.Objects[0]);
  if FilterItem = nil then Exit;
  FilterItem.ItemType := FilterItem.ItemType;
  FilterItem.sItemName := FilterItem.sItemName;
  FilterItem.boHintMsg := FilterItem.boHintMsg;
  FilterItem.boPickup := FilterItem.boPickup;
  FilterItem.boShowName := not FilterItem.boShowName;
  RefListViewFilterItem(FilterItem.ItemType);
  BtnFilterDel.Enabled := False;
  BtnFilterChg.Enabled := False;
  BtnFilterSave.Enabled := True;
end;

//==============================================================================
//生成登陆器和配套网关相关代码
procedure TFrmMakeLogin.Button17Click(Sender: TObject);
  //随机取名
  function RandomGetName():string;
  var
    s,s1:string;
    I,i0:integer;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //随机种子
      for i:=0 to 6 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
begin
  EdtClientFileName.Text := RandomGetName()+'.THG';
end;

procedure TFrmMakeLogin.BtnAssistantFilterClick(Sender: TObject);
begin
  OpenDialog1.Filter := '内挂过滤文件(*.TXT)|*.TXT';
  if OpenDialog1.Execute then begin
    EdtAssistantFilter.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmMakeLogin.BtnLoginMainImagesClick(Sender: TObject);
begin
  OpenDialog1.Filter := '3KSkin文件|*.3KSkin';
  if OpenDialog1.Execute then begin
    EdtLoginMainImages.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmMakeLogin.BtnMakeLoginClick(Sender: TObject);
begin
  if EdtLoginName.Text = '' then begin
    Application.MessageBox('登陆器名称不能为空！', 'Error', MB_OK +
      MB_ICONSTOP);
    EdtLoginName.SetFocus;
    Exit;  
  end;
  if Trim(EdtClientFileName.Text) = '' then begin
    Application.MessageBox('客户端文件名称不能为空！', 'Error', MB_OK + 
      MB_ICONSTOP);
    EdtClientFileName.SetFocus;
    Exit;  
  end;
  if Trim(EdtMakeKey.Text) = '' then begin
    Application.MessageBox('生成密钥不能为空！', 'Error', MB_OK + MB_ICONSTOP);
    EdtMakeKey.SetFocus;
    Exit;
  end;
  if Length(EdtMakeKey.Text) <> 100 then begin
    Application.MessageBox('密钥不正确！', 'Error', MB_OK + MB_ICONSTOP);
    EdtMakeKey.SetFocus;
    Exit;
  end;
  if GetTickCount - dwMakeTick < 5000 then begin
     Application.MessageBox('你操作过快，请稍后操作！', 'Error', MB_OK +
        MB_ICONWARNING);
     Exit;
  end;
  if Trim(cboLoginVerNo.Text) = '' then begin
    Application.MessageBox('请选择版本！', 'Error', MB_OK + MB_ICONSTOP);
    cboLoginVerNo.SetFocus;
    Exit;
  end;
  dwMakeTick := GetTickCount();
  MakeType := 0;
  FrmMain.SendCheckMakeKeyAndDayMakeNum(Trim(EdtMakeKey.Text));
  BtnMakeLogin.Enabled := False;
  BtnMakeGate.Enabled := False;
end;

procedure TFrmMakeLogin.UpFile;
  function GetFileSize(const FileName: String): LongInt;
  var SearchRec: TSearchRec;
  begin
    if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
     Result := SearchRec.Size
    else
     Result := -1;
  end;
var
  boUpFileOK: Boolean;
  sSendData: string;
  sLoginName: string;
  sClientFileName: string;
  sboLoginMainImages: string;
  sboAssistantFilter: string;
  sboTzHint,sboPulsDesc: string;
  sboUseFd : string;
  sboUseAutoUpData : string;
  sServerAdd: string;
  sFtpUser: string;
  sFtpPass: string;
begin
  boUpFileOK := True;
  sboLoginMainImages := '0';
  sboAssistantFilter := '0';
  sboTzHint := '0';
  sboPulsDesc := '0';
  if CheckBox5.Checked then
    sboUseFd    := '1'
  else
    sboUseFd := '0';
  if CheckBox6.Checked then
    sboUseAutoUpData    := '1'
  else
    sboUseAutoUpData := '0';
  sLoginName := Trim(EdtLoginName.Text);
  sClientFileName := Trim(EdtClientFileName.Text);

  if (EdtAssistantFilter.Text <> '') or (EdtLoginMainImages.Text <> '') or (EdtTzHintFile.Text <> '') or (EdtPulsDescFile.Text <> '') then begin
    Decode(g_sFtpServerAdd, sServerAdd);
    Decode(g_sFtpUser, sFtpUser);
    Decode(g_sFtpPass, sFtpPass);
    IdFTP1.Host := sServerAdd;
    IdFTP1.Username := sFtpUser;
    IdFTP1.Password := sFtpPass;
    IdFTP1.Port := 21;
    try
      if IdFTP1.Connected then IdFTP1.Disconnect;//20090722 增加
      IdFTP1.Connect;
    except
      Application.MessageBox('连接服务器错误，请联系代理！错误号 Code=1', 'Error', MB_OK + MB_ICONSTOP);
      boUpFileOK := False;
    end;
    if EdtAssistantFilter.Text <> '' then begin
      if CompareText(ExtractFileExt(EdtAssistantFilter.Text), '.Txt') = 0 then begin
        if GetFileSize(EdtAssistantFilter.Text) <= 1024*0124 then begin
          if IdFTP1.Connected then begin
            IdFTP1.TransferType := ftBinary;
            try
              IdFTP1.Put(EdtAssistantFilter.Text,g_MySelf.sAccount+'_FilterItemList.txt');
              sboAssistantFilter := '1';
            except
              Application.MessageBox('1载入文件服务器连接失败！请稍后在试！', 'Error', MB_OK + MB_ICONSTOP);
              boUpFileOK := False;
            end;
          end;
        end else begin
          Application.MessageBox('内挂过滤文件大小必须小于1mb！', 'Error',
            MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
        end;
      end else begin
          Application.MessageBox('过滤文件扩展名必须为TXT！', 'Error', MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
      end;
    end;

    if (EdtTzHintFile.Text <> '') and boUpFileOK then begin
      if CompareText(ExtractFileExt(EdtTzHintFile.Text), '.Txt') = 0 then begin
        if GetFileSize(EdtTzHintFile.Text) <= 1024*500 then begin
          if IdFTP1.Connected then begin
            IdFTP1.TransferType := ftBinary;
            try
              IdFTP1.Put(EdtTzHintFile.Text,g_MySelf.sAccount+'_TzHintList.txt');
              sboTzHint := '1';
            except
              Application.MessageBox('2载入文件服务器连接失败！请稍后在试！', 'Error', MB_OK + MB_ICONSTOP);
              boUpFileOK := False;
            end;
          end;
        end else begin
          Application.MessageBox('套装提示文件大小必须小于500KB！', 'Error', MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
        end;
      end else begin
          Application.MessageBox('套装提示文件必须为TXT文件！', 'Error', MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
      end;
    end;

    if (EdtPulsDescFile.Text <> '') and boUpFileOK then begin
      if CompareText(ExtractFileExt(EdtPulsDescFile.Text), '.Txt') = 0 then begin
        if GetFileSize(EdtPulsDescFile.Text) <= 10000 then begin
          if IdFTP1.Connected then begin
            IdFTP1.TransferType := ftBinary;
            try
              IdFTP1.Put(EdtPulsDescFile.Text,g_MySelf.sAccount+'_PulsDesc.txt');
              sboPulsDesc := '1';
            except
              Application.MessageBox('2载入文件服务器连接失败！请稍后在试！', 'Error', MB_OK + MB_ICONSTOP);
              boUpFileOK := False;
            end;
          end;
        end else begin
          Application.MessageBox('经络提示文件大小必须小于9KB！', 'Error', MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
        end;
      end else begin
          Application.MessageBox('经络提示文件必须为TXT文件！', 'Error', MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
      end;
    end;


    if (EdtLoginMainImages.Text <> '') and boUpFileOK then begin
      if CompareText(ExtractFileExt(EdtLoginMainImages.Text), '.3KSkin') = 0 then begin
        if GetFileSize(EdtLoginMainImages.Text) <= 1048576 then begin
          if IdFTP1.Connected then begin
            //IdFTP1.TransferType := ftBinary;
            try
              IdFTP1.Put(EdtLoginMainImages.Text,g_MySelf.sAccount+'_LoginMain.3KSkin');
              sboLoginMainImages := '1';
            except
              Application.MessageBox('3载入文件服务器连接失败！请稍后在试！', 'Error', MB_OK + MB_ICONSTOP);
              boUpFileOK := False;
            end;
          end;
        end else begin
          Application.MessageBox('登陆器皮肤文件大小必须小于1MB！', 'Error', MB_OK + MB_ICONSTOP);
          boUpFileOK := False;
        end;
      end else begin
        Application.MessageBox('登陆器皮肤文件扩展名必须为3KSkin！', 'Error', MB_OK + MB_ICONSTOP);
        boUpFileOK := False;
      end;
    end;
    if IdFTP1.Connected then begin
      IdFTP1.Quit;
    end;
  end;
  if boUpFileOK then begin
    //生成
    if (sLoginName <> '') and (sClientFileName <> '') and (sboLoginMainImages <> '') and (sboAssistantFilter <> '') and (sboTzHint <> '') and (sboPulsDesc <> '') then begin
      sSendData := sLoginName + '/' + sClientFileName + '/' + sboLoginMainImages + '/' + sboAssistantFilter + '/' + sboTzHint + sboUseFd  + sboUseAutoUpData + '/' + sboPulsDesc  + '/' + IntToStr(cboLoginVerNo.ItemIndex);
      FrmMain.SendMakeLogin(sSendData);
    end;
  end else begin
    BtnMakeLogin.Enabled := True;
    BtnMakeGate.Enabled := True;
  end;
end;

procedure TFrmMakeLogin.IdFTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  ProgressBar1.Position := AWorkCount;
end;

procedure TFrmMakeLogin.IdFTP1WorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  ProgressBar1.Max := AWorkCountMax;
end;

procedure TFrmMakeLogin.BtnMakeGateClick(Sender: TObject);
begin
  if Trim(EdtMakeKey.Text) = '' then begin
    Application.MessageBox('生成密钥不能为空！', 'Error', MB_OK + MB_ICONSTOP);
    EdtMakeKey.SetFocus;
    Exit;
  end;
  if Length(EdtMakeKey.Text) <> 100 then begin
    Application.MessageBox('密钥不正确！', 'Error', MB_OK + MB_ICONSTOP);
    EdtMakeKey.SetFocus;
    Exit;
  end;
  if GetTickCount - dwMakeTick < 5000 then begin
     Application.MessageBox('你操作过快，请稍后操作！', 'Error', MB_OK +
        MB_ICONWARNING);
     Exit;
  end;
  dwMakeTick := GetTickCount();
  MakeType := 1;
  FrmMain.SendCheckMakeKeyAndDayMakeNum(Trim(EdtMakeKey.Text));
  BtnMakeLogin.Enabled := False;
  BtnMakeGate.Enabled := False;
end;

procedure TFrmMakeLogin.MakeGate();
begin
  FrmMain.SendMakeGate(Trim(EdtMakeKey.Text)+ '/'+ IntToStr(cboLoginVerNo.ItemIndex));
end;

procedure TFrmMakeLogin.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then begin
    BtnAssistantFilter.Enabled := True;
  end else begin
    BtnAssistantFilter.Enabled := False;
    EdtAssistantFilter.Text := '';
  end;
end;

procedure TFrmMakeLogin.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked then begin
    BtnLoginMainImages.Enabled := True;
  end else begin
    BtnLoginMainImages.Enabled := False;
    EdtLoginMainImages.Text := '';
  end;
end;

procedure TFrmMakeLogin.BtnSaveGameListConfigClick(Sender: TObject);
var
  Inifile: TInifile;
  I: Integer;
begin
  Inifile:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
  Inifile.WriteInteger('ServerList','GroupCount',ComboBox1.Items.Count);
  for I:=0 to ComboBox1.Items.Count -1 do begin
   Inifile.WriteString('ServerList','Group'+inttostr(I+1),ComboBox1.Items[I]);
  end;
  Inifile.WriteInteger('ServerList','ListCount',ListView1.Items.Count);
  for I:=0 to ListView1.Items.Count -1 do begin
   Inifile.WriteString('ServerList','ServerArray'+Inttostr(I+1),ListView1.Items.Item[I].Caption);
   Inifile.WriteString('ServerList','ServerName'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[0]);
   Inifile.WriteString('ServerList','ServerIP'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[1]);
   Inifile.WriteString('ServerList','ServerPort'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[2]);
   Inifile.WriteString('ServerList','ServerNoticeURL'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[3]);
   Inifile.WriteString('ServerList','ServerHomeURL'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[4]);
   Inifile.WriteString('ServerList','GameItemsURL'+Inttostr(I+1),ListView1.Items.Item[I].SubItems.Strings[5]);
   Inifile.WriteString('ServerList','GatePass'+IntToStr(I+1),ListView1.Items.Item[I].SubItems.Strings[6]);
  end;
   Inifile.Free;
   Application.MessageBox('游戏列表配置信息已保存！', '提示', MB_OK + 
     MB_ICONINFORMATION);
end;

procedure TFrmMakeLogin.LoadConfig;
var
  Conf: TIniFile;
  sConfigFileName: string;
  I,IEnd:Integer;
  II,IIEnd:Integer;
  ListItem: TListItem;
begin
  sConfigFileName := ExtractFilePath(ParamStr(0)) + 'Config.ini';
  if not FileExists(sConfigFileName) then begin
    ComboBox1.Items.Add('电信服务器');
    ComboBox1.Items.Add('网通服务器');
  end else begin
    Conf := TIniFile.Create(sConfigFileName);
    IEnd:=Conf.ReadInteger('ServerList','GroupCount',0);
    IIEnd:=Conf.ReadInteger('ServerList','ListCount',0);
    ComboBox1.Items.Clear;
    for I:=1 to IEnd do begin
       ComboBox1.Items.Add(Conf.ReadString('ServerList','Group'+InttoStr(I),''));
    end;
    for II:=1 to IIEnd do begin
      ListView1.Items.BeginUpdate;
      try
        ListItem := ListView1.Items.Add;
        ListItem.Caption:=Conf.ReadString('ServerList','ServerArray'+InttoStr(II),'');
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerName'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerIP'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerPort'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerNoticeURL'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','ServerHomeURL'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','GameItemsURL'+InttoStr(II),''));
        ListItem.SubItems.Add(Conf.ReadString('ServerList','GatePass'+InttoStr(II),''));
      finally
          ListView1.Items.EndUpdate;
      end;
    end;
    Conf.Free;
  end;
  ComboBox1.ItemIndex := 0;
end;

procedure TFrmMakeLogin.Button1Click(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 4;
end;

procedure TFrmMakeLogin.Button6Click(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 5;
end;
{**套装**}
procedure TFrmMakeLogin.BtnTzAddClick(Sender: TObject);
  function IsChar(str:string):integer;//判断有几个'|'号
  var I:integer;
  begin
  Result:=0;
    for I:=1 to length(str) do
      if (str[I] in ['|']) then begin
        Inc(Result);
      end;
  end;
var
  ListItem: TListItem;
  sItemName: string;
begin
    sItemName := Trim(EdtTzCaption.Text);
    if sItemName = '' then begin
      Application.MessageBox('套装标题不能为空！！！', '提示信息', MB_ICONQUESTION);
      EdtTzCaption.SetFocus;
      Exit;
    end;
    if IsChar(EdtTzItems.text) <= 0 then begin
      Application.MessageBox('套装名字输入不正确,格式:XXX|XXX|！！！', '提示信息', MB_OK + MB_ICONERROR);
      EdtTzItems.SetFocus;
      Exit;
    end;
    sItemName := Trim(Memo.Text);
    if sItemName = '' then begin
      Application.MessageBox('套装功能讲解不能为空！！！', '提示信息', MB_ICONQUESTION);
      Memo.SetFocus;
      Exit;
    end;
    ListViewTzItemList.Items.BeginUpdate;
    try
      ListItem := ListViewTzItemList.Items.Add;
      ListItem.Caption := EdtTzCaption.Text;
      ListItem.SubItems.Add(IntToStr(SpinEdit30.Value));
      ListItem.SubItems.Add(EdtTzItems.Text);
      ListItem.SubItems.Add(IntToStr(SpinEdit1.Value)+'|'+IntToStr(SpinEdit2.Value)+'|'+IntToStr(SpinEdit3.Value)+'|'+IntToStr(SpinEdit4.Value)+'|'
      +IntToStr(SpinEdit5.Value)+'|'+IntToStr(SpinEdit12.Value)+'|'+IntToStr(SpinEdit6.Value)+'|'+IntToStr(SpinEdit7.Value)+'|'+IntToStr(SpinEdit13.Value)+'|'
      +IntToStr(SpinEdit8.Value)+'|'+IntToStr(SpinEdit9.Value)+'|'+IntToStr(SpinEdit14.Value)+'|'+IntToStr(SpinEdit10.Value)+'|'+IntToStr(SpinEdit11.Value)+'|'
      +IntToStr(SpinEdit15.Value)+'|'
      );
      ListItem.SubItems.Add(Memo.Text);
    finally
      ListViewTzItemList.Items.EndUpdate;
    end;
    BtnTzSave.Enabled:= True;
    BtnTzDel.Enabled:= False;
    BtnTzChg.Enabled:= False;
end;

procedure TFrmMakeLogin.BtnTzDelClick(Sender: TObject);
begin
  ListViewTzItemList.Items.BeginUpdate;
  try
    ListViewTzItemList.DeleteSelected;
    BtnTzSave.Enabled:= True;
    BtnTzDel.Enabled:= False;
    BtnTzChg.Enabled:= False;
  finally
    ListViewTzItemList.Items.EndUpdate;
  end;
end;

procedure TFrmMakeLogin.BtnTzChgClick(Sender: TObject);
  function IsChar(str:string):integer;//判断有几个'|'号
  var I:integer;
  begin
  Result:=0;
    for I:=1 to length(str) do
      if (str[I] in ['|']) then begin
        Inc(Result);
      end;
  end;
var
  nItemIndex: Integer;
  ListItem: TListItem;
begin
  if EdtTzCaption.Text = '' then begin
    Application.MessageBox('套装标题不能为空！！！', '提示信息', MB_ICONQUESTION);
    EdtTzCaption.SetFocus;
    Exit;
  end;
  if IsChar(EdtTzItems.text) <= 0 then begin
    Application.MessageBox('套装名字输入不正确,格式:XXX|XXX|！！！', '提示信息', MB_OK + MB_ICONERROR);
    EdtTzItems.SetFocus;
    Exit;
  end;
  if SpinEdit30.Value <= 0 then begin//20090413
    Application.MessageBox('套装数量不能为0！！！', '提示信息', MB_OK + MB_ICONERROR);
    SpinEdit30.SetFocus;
    Exit;
  end; 
  try
    nItemIndex := ListViewTzItemList.ItemIndex;
    ListItem := ListViewTzItemList.Items.Item[nItemIndex];
    ListItem.Caption := EdtTzCaption.Text;
    ListItem.SubItems.Strings[0] := IntToStr(SpinEdit30.Value);
    ListItem.SubItems.Strings[1] := EdtTzItems.Text;
    ListItem.SubItems.Strings[2] := IntToStr(SpinEdit1.Value)+'|'+IntToStr(SpinEdit2.Value)+'|'+IntToStr(SpinEdit3.Value)+'|'+IntToStr(SpinEdit4.Value)+'|'
      +IntToStr(SpinEdit5.Value)+'|'+IntToStr(SpinEdit12.Value)+'|'+IntToStr(SpinEdit6.Value)+'|'+IntToStr(SpinEdit7.Value)+'|'+IntToStr(SpinEdit13.Value)+'|'
      +IntToStr(SpinEdit8.Value)+'|'+IntToStr(SpinEdit9.Value)+'|'+IntToStr(SpinEdit14.Value)+'|'+IntToStr(SpinEdit10.Value)+'|'+IntToStr(SpinEdit11.Value)+'|'
      +IntToStr(SpinEdit15.Value)+'|';
    ListItem.SubItems.Strings[3] := Memo.Text;
    BtnTzSave.Enabled:= True;
    BtnTzDel.Enabled:= False;
    BtnTzChg.Enabled:= False;
  except
  end;
end;

procedure TFrmMakeLogin.BtnTzSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;

  sTzCaption, sTzItems, sItemsCount, sItemsAbli, sMemo: string;
  sFileName, sLineText: string;
begin
  if ListViewTzItemList.Items.Count = 0 then begin
    Application.MessageBox('套装列表是空的哦！', 'Error', MB_OK + 
      MB_ICONSTOP);
    Exit;
  end;
  sFileName := '.\TzHintList.txt';
  SaveList := TStringList.Create();
  SaveList.Add(';客户端套装显示配置文件');
  SaveList.Add(';套装标题 数量 套装物品 套装属性 套装功能详解');
  ListViewTzItemList.Items.BeginUpdate;
  try
    for I := 0 to ListViewTzItemList.Items.Count - 1 do begin
      ListItem := ListViewTzItemList.Items.Item[I];
      sTzCaption := ListItem.Caption;
      sItemsCount := ListItem.SubItems.Strings[0];
      sTzItems := ListItem.SubItems.Strings[1];
      sItemsAbli := ListItem.SubItems.Strings[2];
      sMemo := ListItem.SubItems.Strings[3];
      sLineText := sTzCaption + #9 + sItemsCount + #9 + sTzItems + #9 + sItemsAbli + #9 + sMemo;
      SaveList.Add(sLineText);
    end;
  finally
    ListViewTzItemList.Items.EndUpdate;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  BtnTzDel.Enabled:= False;
  BtnTzChg.Enabled:= False;
  BtnTzSave.Enabled:= False;
  Application.MessageBox('TzHintList.txt生成成功！！！', '提示信息', MB_ICONQUESTION);
end;

procedure TFrmMakeLogin.BtnTzHelpClick(Sender: TObject);
begin
  FrmTzHelp.ShowModal;
end;

procedure TFrmMakeLogin.BtnTzOpenClick(Sender: TObject);
var
  sFileName, sLineText: string;
  LoadList: TStringList;
  I: Integer;
  sTzCaption, sTzItems, sItemsCount, sItemsAbli, sMemo: string;
  ListItem: TListItem;
begin
  OpenDialog1.Filter := '套装提示信息文件|*.TxT';
  if OpenDialog1.Execute then begin
    sFileName := OpenDialog1.FileName;
    if FileExists(sFileName) then begin
      LoadList := TStringList.Create;
      try
        LoadList.LoadFromFile(sFileName);
        if LoadList.Count > 0 then begin//20080704
          for I := 0 to LoadList.Count - 1 do begin
            sLineText := LoadList.Strings[I];
            if (sLineText <> '') and (sLineText[1] <> ';') then begin
              sLineText := GetValidStr3(sLineText, sTzCaption, [#9]);
              sLineText := GetValidStr3(sLineText, sItemsCount, [#9]);
              sLineText := GetValidStr3(sLineText, sTzItems, [#9]);
              sLineText := GetValidStr3(sLineText, sItemsAbli, [#9]);
              sLineText := GetValidStr3(sLineText, sMemo, [#9]);
              if (sTzCaption <> '') and (sItemsCount <> '') and (sTzItems <> '') and (sItemsAbli <> '') and (sMemo <> '') then begin
                ListViewTzItemList.Items.BeginUpdate;
                try
                  ListItem := ListViewTzItemList.Items.Add;
                  ListItem.Caption := sTzCaption;
                  ListItem.SubItems.Add(sItemsCount);
                  ListItem.SubItems.Add(sTzItems);
                  ListItem.SubItems.Add(sItemsAbli);
                  ListItem.SubItems.Add(sMemo);
                finally
                  ListViewTzItemList.Items.EndUpdate;
                end;
              end;
            end;
          end;
        end;
      finally
        LoadList.Free;
      end;
    end;
  end;
end;

procedure TFrmMakeLogin.ListViewTzItemListClick(Sender: TObject);
var
  nItemIndex: Integer;
  ListItem: TListItem;
  sIncNHRate, sReserved, sReserved1, sReserved2, sReserved3, sReserved4, sReserved5, sReserved6, sReserved7, sReserved8, sReserved9, sReserved10, sReserved11, sReserved12, sReserved13, sLineText: string;
begin
  try
    nItemIndex := ListViewTzItemList.ItemIndex;
    ListItem := ListViewTzItemList.Items.Item[nItemIndex];
    EdtTzCaption.Text := ListItem.Caption;
    SpinEdit30.Value := Str_ToInt(ListItem.SubItems.Strings[0],1);
    EdtTzItems.Text := ListItem.SubItems.Strings[1];
    Memo.Text := ListItem.SubItems.Strings[3];
    sLineText := ListItem.SubItems.Strings[2];
    if (sLineText <> '') then begin
      sLineText := GetValidStr3(sLineText, sIncNHRate, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved1, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved2, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved3, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved4, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved5, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved6, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved7, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved8, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved9, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved10, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved11, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved12, ['|']);
      sLineText := GetValidStr3(sLineText, sReserved13, ['|']);
      SpinEdit1.Value := Str_ToInt(sIncNHRate, 0);
      SpinEdit2.Value := Str_ToInt(sReserved, 0);
      SpinEdit3.Value := Str_ToInt(sReserved1, 0);
      SpinEdit4.Value := Str_ToInt(sReserved2, 0);
      SpinEdit5.Value := Str_ToInt(sReserved3, 0);
      SpinEdit12.Value := Str_ToInt(sReserved4, 0);
      SpinEdit6.Value := Str_ToInt(sReserved5, 0);
      SpinEdit7.Value := Str_ToInt(sReserved6, 0);
      SpinEdit13.Value := Str_ToInt(sReserved7, 0);
      SpinEdit8.Value := Str_ToInt(sReserved8, 0);
      SpinEdit9.Value := Str_ToInt(sReserved9, 0);
      SpinEdit14.Value := Str_ToInt(sReserved10, 0);
      SpinEdit10.Value := Str_ToInt(sReserved11, 0);
      SpinEdit11.Value := Str_ToInt(sReserved12, 0);
      SpinEdit15.Value := Str_ToInt(sReserved13, 0);
    end;
    BtnTzChg.Enabled := True;
    BtnTzDel.Enabled := True;
  except
    BtnTzChg.Enabled := False;
    BtnTzDel.Enabled := False;
  end;
end;

procedure TFrmMakeLogin.BtnTzHintFileClick(Sender: TObject);
begin
  OpenDialog1.Filter := '套装提示文件(*.Txt)|*.Txt';
  if OpenDialog1.Execute then begin
    EdtTzHintFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmMakeLogin.CheckBox3Click(Sender: TObject);
begin
  BtnTzHintFile.Enabled := CheckBox3.Checked;
end;

procedure TFrmMakeLogin.Button4Click(Sender: TObject);
begin
  Application.MessageBox('请参考压缩包内的“PulsDesc.txt”文件！', '提示', MB_OK 
    + MB_ICONINFORMATION);
end;

procedure TFrmMakeLogin.CheckBox4Click(Sender: TObject);
begin
  BtnPulsDescFile.Enabled := CheckBox4.Checked;
end;

procedure TFrmMakeLogin.BtnPulsDescFileClick(Sender: TObject);
begin
  OpenDialog1.Filter := '经络提示文件(*.Txt)|*.Txt';
  if OpenDialog1.Execute then begin
    EdtPulsDescFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TFrmMakeLogin.FormShow(Sender: TObject);
var
  I: Integer;
begin
  if FrmMain.TempList.Count > 0 then begin
    cboLoginVerNo.Clear;
    for I := 0 to FrmMain.TempList.Count - 1 do begin
      cboLoginVerNo.Items.Add(Trim(FrmMain.TempList.Strings[I]));
    end;
    cboLoginVerNo.ItemIndex:= 0;
  end else begin
    cboLoginVerNo.Clear;
  {$IF g_Version = 1}
    cboLoginVerNo.Items.Add('最新版');
  {$ELSE}
    cboLoginVerNo.Items.Add('最新版');
    cboLoginVerNo.Items.Add('0627版');
  {$IFEND}
  cboLoginVerNo.ItemIndex:= 0;
  end;
  {$IF g_Version = 1}
  Label35.Enabled := False;
  CheckBox3.Enabled := False;
  EdtTzHintFile.Enabled := False;
  BtnTzHintFile.Enabled := False;
  Button6.Enabled := False;
  Label37.Enabled := False;
  CheckBox4.Enabled := False;
  EdtPulsDescFile.Enabled := False;
  BtnPulsDescFile.Enabled := False;
  Button4.Enabled := False;
  {$IFEND}
end;

procedure TFrmMakeLogin.cboLoginVerNoChange(Sender: TObject);
begin
  if Pos('0627', cboLoginVerNo.Text) > 0 then begin
    CheckBox4.Enabled := False;
    CheckBox4.Checked := False;
    EdtPulsDescFile.Text:='';
  end else begin
    CheckBox4.Enabled := True;
  end;

  {//
  if Pos('测试版', cboLoginVerNo.Text) > 0 then begin
  end;    }
end;

procedure TFrmMakeLogin.BtnFromDBClick(Sender: TObject);
begin
  if FrmSelectDB.ShowModal = mrOk then begin
    GetFiterItemFormBDE();
  end;
end;

procedure TFrmMakeLogin.RefListViewFilterItem(ItemType: TFilterItemType);
var
  I: Integer;
  ListItem: TListItem;
  FilterItem: pTFilterItem;
begin
  ListViewFilterItem.Clear;
  ListViewFilterItem.Items.BeginUpdate;
  try
    for I := 0 to g_FilterItemList.Count - 1 do begin
      FilterItem := pTFilterItem(g_FilterItemList.Items[I]);
      if (ItemType = i_All) or (FilterItem.ItemType = ItemType) then begin
        ListItem := ListViewFilterItem.Items.Add;
        ListItem.Caption := GetFilterItemType(FilterItem.ItemType);
        ListItem.SubItems.AddObject(FilterItem.sItemName, TObject(FilterItem));
        ListItem.Data := FilterItem;
        ListItem.SubItems.Add(BooleanToStr(FilterItem.boHintMsg));
        ListItem.SubItems.Add(BooleanToStr(FilterItem.boPickup));
        ListItem.SubItems.Add(BooleanToStr(FilterItem.boShowName));
      end;
    end;
  finally
    ListViewFilterItem.Items.EndUpdate;
  end; 
end;
procedure TFrmMakeLogin.GetFiterItemFormBDE;
  function GetItemType(StdMode: Integer): TFilterItemType;
  begin
    case StdMode of
      0..2, 25: Result := i_HPMPDurg;//－－25毒符
      10, 11: Result := i_Dress;
      5, 6: Result := i_Weapon;
      30: Result := i_Decorate;//30－勋章等
      19, 20, 21,28,29: Result := i_Jewelry;
      15,16: Result := i_Dress;
      24, 26: Result := i_Jewelry;
      22, 23, 27: Result := i_Jewelry;
      51: Result := i_Decoration;
      54, 64: Result := i_Decorate;
      52, 62: Result := i_Decorate;
      53, 63: Result := i_Decorate;
    else Result := i_Other;
    end;
  end;
var
  I: Integer;
  nStdMode: Integer;
  Query: TQuery;
  sItemName: string;
  ItemType: TFilterItemType;
  FilterItem: pTFilterItem;
resourcestring
  sSQLString = 'select * from StdItems';
begin
  Query := TQuery.Create(nil);
  Query.DatabaseName := Trim(FrmSelectDB.EdtDBName.Text);
  Query.SQL.Clear;
  Query.SQL.Add(sSQLString);
  try
    Query.Open;
  finally
  end;
  if Query.RecordCount > 0 then begin
    if g_FilterItemList.Count > 0 then begin
      for I := 0 to g_FilterItemList.Count - 1 do begin
        Dispose(pTFilterItem(g_FilterItemList.Items[I]));
      end;
      g_FilterItemList.Clear;
    end;
    try
      for I := 0 to Query.RecordCount - 1 do begin
        nStdMode := Query.FieldByName('StdMode').AsInteger;
        sItemName := Query.FieldByName('Name').AsString;
        ItemType := GetItemType(nStdMode);
        New(FilterItem);
        FilterItem.ItemType := ItemType;
        FilterItem.sItemName := sItemName;
        FilterItem.boHintMsg := CheckBoxHintItem.Checked;
        FilterItem.boPickup := CheckBoxPickUpItem.Checked;
        FilterItem.boShowName := CheckBoxShowItemName.Checked;
        g_FilterItemList.Add(FilterItem);
        Query.Next;
      end;
    finally
      Query.Close;
    end;
    RefListViewFilterItem(i_All);
    BtnFilterSave.Enabled := True;
  end;
  Query.Free;
end;

procedure TFrmMakeLogin.ComboBoxItemFilterChange(Sender: TObject);
begin
  RefListViewFilterItem(TFilterItemType(ComboBoxItemFilter.ItemIndex));
end;

procedure TFrmMakeLogin.ListViewFilterItemClick(Sender: TObject);
var
  ListItem: TListItem;
  FilterItem: pTFilterItem;
begin
  BtnFilterChg.Enabled := False;
  BtnFilterDel.Enabled := False;
  ListItem := ListViewFilterItem.Selected;
  if ListItem = nil then Exit;
  FilterItem := pTFilterItem(ListItem.SubItems.Objects[0]);
  if FilterItem = nil then Exit;
  ComboBoxItemFilter.ItemIndex := Integer(FilterItem.ItemType);

  CheckBoxHintItem.Checked := FilterItem.boHintMsg;
  CheckBoxPickUpItem.Checked := FilterItem.boPickup;
  CheckBoxShowItemName.Checked := FilterItem.boShowName;

  EditFilterItemName.Text := FilterItem.sItemName;
  BtnFilterChg.Enabled := True;
  BtnFilterDel.Enabled := True;
end;

procedure TFrmMakeLogin.BtnFilterDelClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  FilterItem: pTFilterItem;
begin
  ListItem := ListViewFilterItem.Selected;
  if ListItem = nil then Exit;
  FilterItem := pTFilterItem(ListItem.SubItems.Objects[0]);
  if FilterItem = nil then Exit;
  for I := 0 to g_FilterItemList.Count - 1 do begin
    if g_FilterItemList.Items[I] = FilterItem then begin
      Dispose(pTFilterItem(g_FilterItemList.Items[I]));
      g_FilterItemList.Delete(I);
      Break;
    end;
  end;
  RefListViewFilterItem(TFilterItemType(ComboBoxItemFilter.ItemIndex));
  BtnFilterChg.Enabled := False;
  BtnFilterDel.Enabled := False;
  BtnFilterSave.Enabled := True;
end;

procedure TFrmMakeLogin.BtnFilterChgClick(Sender: TObject);
var
  ListItem: TListItem;
  FilterItem: pTFilterItem;
  sItemName: string;
  nType: Integer;
begin
  sItemName := EditFilterItemName.Text;
  nType := ComboBoxItemFilter.ItemIndex;
  if sItemName = '' then begin
    Application.MessageBox('请输入物品名称！！！', 'Error', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  if nType <= 0 then begin
    Application.MessageBox('请选择物品类型！！！', 'Error', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  ListItem := ListViewFilterItem.Selected;
  if ListItem = nil then Exit;
  FilterItem := pTFilterItem(ListItem.SubItems.Objects[0]);
  if FilterItem = nil then Exit;
  FilterItem.ItemType := TFilterItemType(nType);
  FilterItem.sItemName := sItemName;
  FilterItem.boHintMsg := CheckBoxHintItem.Checked;
  FilterItem.boPickup := CheckBoxPickUpItem.Checked;
  FilterItem.boShowName := CheckBoxShowItemName.Checked;
  RefListViewFilterItem(FilterItem.ItemType);
  BtnFilterDel.Enabled := False;
  BtnFilterChg.Enabled := False;
  BtnFilterSave.Enabled := True;
end;

procedure TFrmMakeLogin.BtnFilterAddClick(Sender: TObject);
var
  FilterItem: pTFilterItem;
  sItemName: string;
  nType: Integer;
begin
  sItemName := EditFilterItemName.Text;
  nType := ComboBoxItemFilter.ItemIndex;

  if sItemName = '' then begin
    Application.MessageBox('请输入物品名称！！！', 'Error', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  if FindFilterItemName(sItemName) <> '' then begin
    Application.MessageBox('此物品已经添加！！！', 'Error', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  if nType <= 0 then begin
    Application.MessageBox('请选择物品类型！！！', 'Error', MB_OK + MB_ICONSTOP);
    Exit;
  end;

  New(FilterItem);
  FilterItem.ItemType := TFilterItemType(nType);
  FilterItem.sItemName := sItemName;
  FilterItem.boHintMsg := CheckBoxHintItem.Checked;
  FilterItem.boPickup := CheckBoxPickUpItem.Checked;
  FilterItem.boShowName := CheckBoxShowItemName.Checked;
  g_FilterItemList.Add(FilterItem);
  RefListViewFilterItem(FilterItem.ItemType);
  BtnFilterSave.Enabled := True;
end;

procedure TFrmMakeLogin.BtnFilterOpenClick(Sender: TObject);
var
  sFileName: string;
begin
  OpenDialog1.Filter := '内挂过滤文件|*.TxT';
  if OpenDialog1.Execute then begin
    sFileName := OpenDialog1.FileName;
    LoadFilterItemList(sFileName);
  end;
end;

procedure TFrmMakeLogin.BtnFilterSaveClick(Sender: TObject);
begin
  SaveDialog1.Filter := '内挂过滤文件|*.TxT';
  SaveDialog1.DefaultExt := 'TxT';
  if SaveDialog1.Execute then begin
    SaveFilterItemList(SaveDialog1.FileName);
    BtnFilterSave.Enabled := False;
    BtnFilterChg.Enabled := False;
    BtnFilterDel.Enabled := False;
  end;
end;

procedure TFrmMakeLogin.PopupMenu1Popup(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewFilterItem.Selected;
  if ListItem = nil then Exit;
  N1.Checked := ListItem.SubItems.Strings[1] = '是';
  N2.Checked := ListItem.SubItems.Strings[2] = '是';
  n3.Checked := ListItem.SubItems.Strings[3] = '是';
end;

procedure TFrmMakeLogin.Button2Click(Sender: TObject);
begin
  FrmDesignMain := TFrmDesignMain.Create(Application);
  FrmDesignMain.Show;
  g_TrialRun.boTrialRun := False;
end;

end.
