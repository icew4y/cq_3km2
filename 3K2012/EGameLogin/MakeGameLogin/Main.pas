unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, bsSkinData, BusinessSkinForm,
  bsSkinCtrls, RzTabs, ComCtrls, ExtCtrls, RzPanel, RzLabel,
  Mask, bsSkinBoxCtrls, RzEdit, RzListVw, Inifiles, bsMessages,
  RzRadGrp, bsSkinShellCtrls, CommDlg, DBTables, RzButton, 
  bsDialogs, Menus, bsSkinMenus, RzBHints, Spin, MakeGameLoginShare;

type
  TMainFrm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    RzGroupBox1: TRzGroupBox;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    bsSkinButton1: TbsSkinButton;
    bsSkinButton2: TbsSkinButton;
    LnkEdt: TRzEdit;
    GameListURLEdt: TRzEdit;
    PatchListURLEdt: TRzEdit;
    RzGroupBox2: TRzGroupBox;
    RzGroupBox3: TRzGroupBox;
    RzGroupBox4: TRzGroupBox;
    RzLabel4: TRzLabel;
    ComboBox1: TbsSkinComboBox;
    AddArrayBtn: TbsSkinButton;
    DelArrayBtn: TbsSkinButton;
    ListView1: TbsSkinListView;
    RzPanel1: TRzPanel;
    AddGameList: TbsSkinButton;
    ChangeGameList: TbsSkinButton;
    DelGameList: TbsSkinButton;
    bsSkinButton8: TbsSkinButton;
    bsSkinButton9: TbsSkinButton;
    Memo1: TbsSkinMemo;
    FileTypeRadioGroup: TRzRadioGroup;
    RzLabel5: TRzLabel;
    DirComBox: TbsSkinComboBox;
    RzLabel6: TRzLabel;
    FileNameEdt: TRzEdit;
    RzLabel7: TRzLabel;
    DownAddressEdt: TRzEdit;
    bsSkinOpenDialog1: TbsSkinOpenDialog;
    RzLabel8: TRzLabel;
    Md5Edt: TRzEdit;
    OpenFileBtn: TbsSkinButton;
    SavePatchListBtn: TbsSkinButton;
    bsSkinButton5: TbsSkinButton;
    LoadPatchListBtn: TbsSkinButton;
    RzLabel9: TRzLabel;
    LoadPatchFileOpenDialog: TbsSkinOpenDialog;
    RzLabel10: TRzLabel;
    ClientFileEdt: TRzEdit;
    TabSheet5: TRzTabSheet;
    bsSkinButton4: TbsSkinButton;
    RzLabel11: TRzLabel;
    ClientLocalFileEdt: TRzEdit;
    bsSkinButton6: TbsSkinButton;
    Mes: TbsSkinMessage;
    bsSkinInputDialog1: TbsSkinInputDialog;
    SaveTxtBtn: TbsSkinButton;
    bsSkinGroupBox1: TbsSkinGroupBox;
    bsSkinGroupBox2: TbsSkinGroupBox;
    bsSkinStdLabel6: TbsSkinStdLabel;
    Label2: TLabel;
    EditProductName: TEdit;
    EditVersion: TEdit;
    EditUpDateTime: TEdit;
    EditProgram: TEdit;
    EditWebSite: TEdit;
    EditBbsSite: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    TabSheet6: TRzTabSheet;
    RzGroupBox5: TRzGroupBox;
    BtnGameMonAdd: TRzButton;
    EditGameMon: TRzEdit;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    RzGroupBox6: TRzGroupBox;
    BtnGameMonDel: TRzButton;
    BtnChangeGameMon: TRzButton;
    BtnSaveGameMon: TRzButton;
    RzLabel12: TRzLabel;
    ListViewGameMon: TRzListView;
    GameMonTypeRadioGroup: TRzRadioGroup;
    RzLabel15: TRzLabel;
    GameMonListURLEdt: TRzEdit;
    RzGroupBox7: TRzGroupBox;
    bsSkinCheckRadioBoxSdoFilter: TbsSkinCheckRadioBox;
    bsSkinCheckRadioBoxGameMon: TbsSkinCheckRadioBox;
    bsSkinPopupMenu1: TbsSkinPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    RzLabel16: TRzLabel;
    GameESystemEdt: TRzEdit;
    RzBalloonHints1: TRzBalloonHints;
    RzRadioGroupMainImages: TRzRadioGroup;
    TabSheet7: TRzTabSheet;
    GroupBox12: TGroupBox;
    Label9: TLabel;
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
    GroupBox4: TGroupBox;
    ListViewTzItemList: TRzListView;
    BtnTzOpen: TbsSkinButton;
    BtnTzAdd: TbsSkinButton;
    BtnTzDel: TbsSkinButton;
    BtnTzChg: TbsSkinButton;
    BtnTzSave: TbsSkinButton;
    BtnTzHelp: TbsSkinButton;
    bsSkinCheckRadioBoxTzHintFile: TbsSkinCheckRadioBox;
    bsSkinCheckRadioBoxPulsDesc: TbsSkinCheckRadioBox;
    GroupBox1: TGroupBox;
    LabelItemName: TLabel;
    LabelItemType: TLabel;
    LabelTips: TRzLabel;
    BtnFilterOpen: TbsSkinButton;
    BtnFilterAdd: TbsSkinButton;
    BtnFilterSave: TbsSkinButton;
    EditFilterItemName: TRzEdit;
    GroupBox2: TGroupBox;
    BtnFilterChg: TbsSkinButton;
    BtnFilterDel: TbsSkinButton;
    BtnFromDB: TbsSkinButton;
    ListViewFilterItem: TRzListView;
    ComboBoxItemFilter: TbsSkinComboBox;
    CheckBoxHintItem: TbsSkinCheckRadioBox;
    CheckBoxPickUpItem: TbsSkinCheckRadioBox;
    CheckBoxShowItemName: TbsSkinCheckRadioBox;
    bsSkinSaveDialog1: TbsSkinSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure AddArrayBtnClick(Sender: TObject);
    procedure DelArrayBtnClick(Sender: TObject);
    procedure AddGameListClick(Sender: TObject);
    procedure DelGameListClick(Sender: TObject);
    procedure ChangeGameListClick(Sender: TObject);
    procedure bsSkinButton8Click(Sender: TObject);
    procedure OpenFileBtnClick(Sender: TObject);
    procedure bsSkinButton5Click(Sender: TObject);
    procedure SavePatchListBtnClick(Sender: TObject);
    procedure LoadPatchListBtnClick(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure bsSkinButton9Click(Sender: TObject);
    procedure bsSkinButton4Click(Sender: TObject);
    procedure bsSkinButton6Click(Sender: TObject);
    procedure SaveTxtBtnClick(Sender: TObject);
    procedure BtnGameMonAddClick(Sender: TObject);
    procedure BtnGameMonDelClick(Sender: TObject);
    procedure BtnChangeGameMonClick(Sender: TObject);
    procedure ListViewGameMonClick(Sender: TObject);
    procedure BtnSaveGameMonClick(Sender: TObject);
    procedure ListViewDisallowMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BtnTzHelpClick(Sender: TObject);
    procedure BtnTzOpenClick(Sender: TObject);
    procedure BtnTzAddClick(Sender: TObject);
    procedure BtnTzDelClick(Sender: TObject);
    procedure BtnTzChgClick(Sender: TObject);
    procedure BtnTzSaveClick(Sender: TObject);
    procedure ListViewTzItemListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnFromDBClick(Sender: TObject);
    procedure ListViewFilterItemClick(Sender: TObject);
    procedure ComboBoxItemFilterChange(Sender: TObject);
    procedure BtnFilterOpenClick(Sender: TObject);
    procedure BtnFilterAddClick(Sender: TObject);
    procedure BtnFilterChgClick(Sender: TObject);
    procedure BtnFilterDelClick(Sender: TObject);
    procedure BtnFilterSaveClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure bsSkinPopupMenu1Popup(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function InGameMonList(sFilterMsg: string): Boolean;
    procedure GetFiterItemFormBDE();
  public
    { Public declarations }
    procedure LoadConfig();
    procedure AddListView(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL:String);
    procedure ChangeListView(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL:String);
    procedure RefListViewFilterItem(ItemType: TFilterItemType);
 end;
const ConfigFile = '.\QKConfig.ini';
var
  MainFrm: TMainFrm;

implementation

uses AddGameList, MD5, HUtil32, EDcodeUnit, uTzHelp, Zlib,
  uSelectDB, Common;
{$R *.dfm}
//´ÓÂ·¾¶µÃµ½ÎÄ¼þÃû
function ExtractFileName(const Str: string): string;
var L, i, flag: integer;
begin
  flag := 0;
  L := Length(Str);
  for i := 1 to L do if Str[i] = '\' then flag := i;
  result := copy(Str, flag + 1, L - flag);
end;

function AppPath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TMainFrm.LoadConfig();
var
  IniFile: TIniFile;
  I,IEnd:Integer;
  II,IIEnd:Integer;
  ListItem: TListItem;
begin
  if not FileExists(ConfigFile) then begin
    ComboBox1.Items.Add('µçÐÅ·þÎñÆ÷');
    ComboBox1.Items.Add('ÍøÍ¨·þÎñÆ÷');

    LnkEdt.Text := '´«ÆæµÇÂ½Æ÷';
    ClientFileEdt.Text := RandomGetName()+'.THG';
    ClientLocalFileEdt.Text := RandomGetName()+'.Lis';
    GameListURLEdt.Text := 'Http://127.0.0.1/QKServerListFree.txt';
    PatchListURLEdt.Text := 'Http://127.0.0.1/QKFileList.txt';
    GameMonListURLEdt.Text := 'Http://127.0.0.1/QKGameMonList.txt';
    GameESystemEdt.Text := 'Http://127.0.0.1/rdxt.htm';

  end else begin
    IniFile := TIniFile.Create(ConfigFile);
    IEnd:=IniFile.ReadInteger('ServerList','GroupCount',0);
    IIEnd:=IniFile.ReadInteger('ServerList','ListCount',0);
    ComboBox1.Items.Clear;
    for I:=1 to IEnd do begin
       ComboBox1.Items.Add(IniFile.ReadString('ServerList','Group'+InttoStr(I),''));
    end;
    LnkEdt.Text := IniFile.ReadString('LoginInfo','LnkName','');
    ClientFileEdt.Text := IniFile.ReadString('LoginInfo','ClientFileName','');
    ClientLocalFileEdt.Text := IniFile.ReadString('LoginInfo','ClientLocalFileName','');
    GameListURLEdt.Text := IniFile.ReadString('LoginInfo','GameListURL','');
    PatchListURLEdt.Text := IniFile.ReadString('LoginInfo','PatchListURL','');
    GameMonListURLEdt.Text := IniFile.ReadString('LoginInfo','GameMonListUrl','');
    bsSkinCheckRadioBoxSdoFilter.Checked := IniFile.ReadBool('LoginInfo','SdoFilter',False);
    bsSkinCheckRadioBoxGameMon.Checked := IniFile.ReadBool('LoginInfo','GameMon',False);
    bsSkinCheckRadioBoxTzHintFile.Checked := IniFile.ReadBool('LoginInfo','TzHintFile',False);
    bsSkinCheckRadioBoxPulsDesc.Checked := IniFile.ReadBool('LoginInfo','PulsDesc',False);
    GameESystemEdt.Text := IniFile.ReadString('LoginInfo','GameESystem','');
    RzRadioGroupMainImages.ItemIndex := Inifile.ReadInteger('LoginInfo','MainJpg',0);
    for II:=1 to IIEnd do begin
      ListView1.Items.BeginUpdate;
      try
        ListItem := ListView1.Items.Add;
        ListItem.Caption:=IniFile.ReadString('ServerList','ServerArray'+InttoStr(II),'');
        ListItem.SubItems.Add(IniFile.ReadString('ServerList','ServerName'+InttoStr(II),''));
        ListItem.SubItems.Add(IniFile.ReadString('ServerList','ServerIP'+InttoStr(II),''));
        ListItem.SubItems.Add(IniFile.ReadString('ServerList','ServerPort'+InttoStr(II),''));
        ListItem.SubItems.Add(IniFile.ReadString('ServerList','ServerNoticeURL'+InttoStr(II),''));
        ListItem.SubItems.Add(IniFile.ReadString('ServerList','ServerHomeURL'+InttoStr(II),''));
      finally
          ListView1.Items.EndUpdate;
      end;
    end;
  end;
  ComboBox1.ItemIndex := 0;
  IniFile.Free;
end;

procedure TMainFrm.AddListView(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL:String);
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
  finally
    ListView1.Items.EndUpdate;
  end;
end;

procedure TMainFrm.ChangeListView(ServerArray,ServerName,ServerIp,ServerPort,ServerNoticeURL,ServerHomeURL:String);
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
  except
  end;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
var
  sProductName: string;
  sVersion: string;
  sUpDateTime: string;
  sProgram: string;
  sWebSite: string;
  sBbsSite: string;
begin
  Decode(g_sProductName, sProductName);
  Decode(g_sVersion, sVersion);
  Decode(g_sUpDateTime, sUpDateTime);
  Decode(g_sProgram, sProgram);
  Decode(g_sWebSite, sWebSite);
  Decode(g_sBbsSite, sBbsSite);
  EditProductName.Text := sProductName;
  EditVersion.Text := sVersion;
  EditUpDateTime.Text := sUpDateTime;
  EditProgram.Text := sProgram;
  EditWebSite.Text := sWebSite;
  EditBbsSite.Text := sBbsSite;
  g_FilterItemList := TList.Create;
  LoadConfig();
  StdItemList := TList.Create;
end;

procedure TMainFrm.AddArrayBtnClick(Sender: TObject);
var
  str: string;
  I: Integer;
begin
  str:= bsSkinInputDialog1.InputBox('Ôö¼Ó','ÇëÊäÈëÄãÒªÔö¼ÓµÄ·þÎñÆ÷·Ö×é£º','');
  if str <> '' then begin
    for I:=0 to ComBoBox1.Items.Count-1 do begin
      if ComBoBox1.Items.Strings[I] = str then begin
        Mes.MessageDlg('´Ë·þÎñÆ÷·Ö×éÒÑÔÚÁÐ±íÖÐ£¡£¡£¡',mtError,[mbOK],0);
        Exit;
      end;
    end;
  ComBoBox1.Items.Add(str);
  ComBoBox1.ItemIndex := ComBoBox1.Items.Count-1;
  end;
end;

procedure TMainFrm.DelArrayBtnClick(Sender: TObject);
begin
  if Mes.MessageDlg(Pchar('ÊÇ·ñÈ·¶¨É¾³ý·Ö×é ['+ComBoBox1.items[ComBoBox1.ItemIndex]+'] ÐÅÏ¢£¿'),mtConfirmation,[mbYes,mbNo],0) = IDYES then begin
  ComBoBox1.Items.Delete(ComBoBox1.ItemIndex);
  ComBoBox1.ItemIndex:=ComBoBox1.ItemIndex-1;
  end;
end;

procedure TMainFrm.AddGameListClick(Sender: TObject);
begin
  AddGameListFrm := TAddGameListFrm.Create(Owner);
  AddGameListFrm.Add;
  AddGameListFrm.Free;
end;

procedure TMainFrm.DelGameListClick(Sender: TObject);
begin
   ListView1.Items.BeginUpdate;
  try
    if ListView1.Selected <> nil then
      ListView1.DeleteSelected
      else Mes.MessageDlg('ÇëÑ¡ÔñÄãÒªÉ¾³ýµÄÐÅÏ¢£¡',mtError,[mbOK],0);
  finally
    ListView1.Items.EndUpdate;
  end;
end;

procedure TMainFrm.ChangeGameListClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem <> nil then
  AddGameListFrm.Change(ListItem.Caption,ListItem.SubItems.Strings[0],ListItem.SubItems.Strings[1],ListItem.SubItems.Strings[2],ListItem.SubItems.Strings[3],ListItem.SubItems.Strings[4])
  else Mes.MessageDlg('ÇëÑ¡ÔñÄãÒªÐÞ¸ÄµÄÐÅÏ¢£¡',mtError,[mbOK],0);
end;

procedure TMainFrm.bsSkinButton8Click(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: Classes.TStringList;
  sServerArray, sServerName, sServerIP, sServerPort, sServerNoticeURL, sServerHomeURL: String;
  sFileName, sLineText: String;
begin
  if ListView1.Items.Count <> 0 then begin
    sFileName := 'QKServerList.txt';
    SaveList := Classes.TStringList.Create();
    SaveList.Add(';·þÎñÆ÷·Ö×é'#9'ÓÎÏ·Ãû³Æ'#9'ÓÎÏ·IPµØÖ·'#9'¶Ë¿Ú'#9'¹«¸æµØÖ·'#9'ÍøÕ¾Ö÷Ò³');
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
        sLineText := sServerArray + '|' + sServerName + '|' + sServerIP + '|' + sServerPort + '|' + sServerNoticeURL + '|' + sServerHomeURL + '|' + sServerHomeURL +  '|123';
        SaveList.Add(sLineText);
      end;
    finally
      ListView1.Items.EndUpdate;
    end;
    SaveList.Text := encrypt(Trim(SaveList.Text),CertKey('?-W®ê'));
    SaveList.SaveToFile(AppPath+sFileName);
    SaveList.Free;
    Mes.MessageDlg('ÓÎÏ·ÁÐ±íÉú³É³É¹¦'+#13+'Çë¸´ÖÆÄ¿Â¼ÏÂµÄ'+' QKServerList.txt '+'´«µ½ÄãµÄÍøÕ¾Ä¿Â¼ÏÂ¼´¿É',mtInformation,[mbOK],0);
  end else Mes.MessageDlg('Äã»¹Ã»ÓÐÌí¼ÓÓÎÏ·Å¶£¡',mtError,[mbOK],0);
end;

procedure TMainFrm.OpenFileBtnClick(Sender: TObject);
begin
  if bsSkinOpenDialog1.Execute then begin
    FileNameEdt.Text := ExtractFileName(bsSkinOpenDialog1.FileName);
    Md5Edt.Text := RivestFile(bsSkinOpenDialog1.FileName);
  end;
end;

procedure TMainFrm.bsSkinButton5Click(Sender: TObject);
var
  Dir: String;
begin
  case DirComBox.ItemIndex of
    0:Dir := 'Data/';
    1:Dir := 'Map/';
    2:Dir := 'Wav/';
    3:Dir := './';
  end;
  if DirComBox.Text = '' then
    begin
      Mes.MessageDlg('ÇëÑ¡Ôñ¿Í»§¶Ë¸üÐÂÄ¿Â¼',mtInformation,[mbOK],0);
      DirComBox.SetFocus;
      exit;
    end;
  if FileNameEdt.Text = '' then
    begin
      Mes.MessageDlg('ÇëÑ¡ÔñÎÄ¼þÀ´»ñÈ¡ÎÄ¼þÃû',mtInformation,[mbOK],0);
      FileNameEdt.SetFocus;
      exit;
    end;
  if DownAddressEdt.Text = '' then
    begin
      Mes.MessageDlg('ÏÂÔØµØÖ·ÔõÃ´ÄÜ¿Õ£¿',mtInformation,[mbOK],0);
      DownAddressEdt.SetFocus;
      exit;
    end;
  if Md5Edt.Text = '' then
    begin
      Mes.MessageDlg('ÇëÑ¡ÔñÎÄ¼þÀ´»ñÈ¡ÎÄ¼þMD5Öµ',mtInformation,[mbOK],0);
      Md5Edt.SetFocus;
      exit;
    end;
  Memo1.Lines.Add(Inttostr(FileTypeRadioGroup.ItemIndex) +#9+ Dir +#9+ FileNameEdt.Text +#9+ Md5Edt.Text +#9+ DownAddressEdt.Text)
end;

procedure TMainFrm.SavePatchListBtnClick(Sender: TObject);
var
  sPatchFile: String;
  SaveList: Classes.TStringList;
begin
  sPatchFile := 'QKPatchList.txt';
  SaveList := Classes.TStringList.Create();
  SaveList.Text := (encrypt(Memo1.Lines.Text,CertKey('?-W®ê')));
  SaveList.SaveToFile(AppPath+sPatchFile);
  SaveList.Free;
  Mes.MessageDlg('ÓÎÏ·¸üÐÂÁÐ±íÉú³É³É¹¦'+#13+'Çë¸´ÖÆÄ¿Â¼ÏÂµÄ'+' QKPatchList.txt '+'´«µ½ÄãµÄÍøÕ¾Ä¿Â¼ÏÂ¼´¿É',mtInformation,[mbOK],0);
end;

procedure TMainFrm.SaveTxtBtnClick(Sender: TObject);
var
  sPatchFile: String;
begin
  sPatchFile := '¸üÐÂ²¹¶¡¼ÇÂ¼.txt';
  Memo1.Lines.SaveToFile(AppPath+sPatchFile);
  Mes.MessageDlg('ÓÎÏ·¸üÐÂÁÐ±í±£´æ³É¹¦'+#13+'Çë±£¹ÜºÃ ¸üÐÂ²¹¶¡¼ÇÂ¼.txtÎÄ¼þ '+'ÒÔºó±à¼­Éý¼¶²¹¶¡ÎÄ¼þ±à¼­¾Í¿¿ËûÁË£¡',mtInformation,[mbOK],0);
end;

procedure TMainFrm.LoadPatchListBtnClick(Sender: TObject);
begin
  if LoadPatchFileOpenDialog.Execute then begin
     Memo1.Lines.LoadFromFile(LoadPatchFileOpenDialog.FileName);
     Mes.MessageDlg('¶ÁÈ¡¸üÐÂÁÐ±íÎÄ¼þ '+LoadPatchFileOpenDialog.FileName+' ³É¹¦£¡',mtInformation,[mbOK],0);
  end;
end;

//±£´æÎÄ¼þ   uses CommDlg;
function SaveFileName(const OldName: string): string;
var
  ofn: tagOFNA;
  szFile: Pchar;
begin
  GetMem(szFile, 1024); //ÉêÇëÄÚ´æ
  ZeroMemory(szFile, 1024);
  ZeroMemory(@ofn, sizeof(tagOFNA));
  ofn.lStructSize := sizeof(tagOFNA) - SizeOf(DWORD) * 3;
  ofn.hwndOwner := Application.Handle;
  ofn.lpstrFile := szFile;
  ofn.nMaxFile := 1024;
  ofn.lpstrFilter := pchar('exeÎÄ¼þ (*.exe)'#0'*.exe'#0'È«²¿ÎÄ¼þ'#0'*.*'#0);
  ofn.nFilterIndex := 1;
  ofn.lpstrFileTitle := nil;
  ofn.nMaxFileTitle := 0;
  ofn.lpstrInitialDir := nil;
  ofn.lpstrDefExt := '.exe';
  ofn.Flags := OFN_PATHMUSTEXIST or OFN_FILEMUSTEXIST;
  if (GetSaveFileName(ofn)) then
    Result := szFile
  else
    Result := OldName;
  FreeMem(szFile);
end;
//Ñ¹ËõÁ÷
procedure EnCompressStream(CompressedStream: TMemoryStream);
var
  SM: TCompressionStream;
  DM: TMemoryStream;
  Count: int64; //×¢Òâ£¬´Ë´¦ÐÞ¸ÄÁË,Ô­À´ÊÇint
begin
  if CompressedStream.Size <= 0 then exit;
  CompressedStream.Position := 0;
  Count := CompressedStream.Size; //»ñµÃÁ÷µÄÔ­Ê¼³ß´ç
  DM := TMemoryStream.Create;
  SM := TCompressionStream.Create(clMax, DM);//ÆäÖÐµÄclMax±íÊ¾Ñ¹Ëõ¼¶±ð,¿ÉÒÔ¸ü¸Ä,ÖµÊÇÏÂÁÐ²ÎÊýÖ®Ò»:clNone, clFastest, clDefault, clMax
  try
    CompressedStream.SaveToStream(SM); //SourceStreamÖÐ±£´æ×ÅÔ­Ê¼µÄÁ÷
    SM.Free; //½«Ô­Ê¼Á÷½øÐÐÑ¹Ëõ£¬DestStreamÖÐ±£´æ×ÅÑ¹ËõºóµÄÁ÷
    CompressedStream.Clear;
    CompressedStream.WriteBuffer(Count, SizeOf(Count)); //Ð´ÈëÔ­Ê¼ÎÄ¼þµÄ³ß´ç
    CompressedStream.CopyFrom(DM, 0); //Ð´Èë¾­¹ýÑ¹ËõµÄÁ÷
    CompressedStream.Position := 0;
  finally
    DM.Free;
  end;
end;

procedure TMainFrm.bsSkinButton1Click(Sender: TObject);
var
  FilePath: string;
  MyRecInfo: TRecinfo;
  //s: string;
  //LoadList: TStringList;
  Target, TzHint, PulsDescFile, GameSdoFilterFile: TMemoryStream;//Ïà¹ØÎÄ¼þÁ÷
begin
  if LnkEdt.Text = '' then begin
    Mes.MessageDlg('ÒªÐ´ÄãµÄµÇÂ½Æ÷Éú³É×ÀÃæÍ¼±êÊ±ºòµÄÃû³ÆÒ²³Æ¿ì½Ý·½Ê½',mtInformation,[mbOK],0);
    LnkEdt.SetFocus;
    exit;
  end;
  if ClientFileEdt.Text = '' then begin
    Mes.MessageDlg('¿Í»§¶ËÎÄ¼þ²»ÄÜÎª¿Õ',mtInformation,[mbOK],0);
    ClientFileEdt.SetFocus;
    exit;
  end;
  if GameListURLEdt.Text = '' then begin
    Mes.MessageDlg('ÓÎÏ·ÁÐ±íÍøÖ·²»ÄÜÎª¿Õ',mtInformation,[mbOK],0);
    GameListURLEdt.SetFocus;
    exit;
  end;
  if GameMonListURLEdt.Text = '' then begin
    Mes.MessageDlg('·´Íâ¹ÒÁÐ±íÍøÖ·²»ÄÜÎª¿Õ',mtInformation,[mbOK],0);
    GameMonListURLEdt.SetFocus;
    exit;
  end;
  if PatchListURLEdt.Text = '' then begin
    Mes.MessageDlg('ÓÎÏ·¸üÐÂÁÐ±íÍøÖ·²»ÄÜÎª¿Õ',mtInformation,[mbOK],0);
    PatchListURLEdt.SetFocus;
    exit;
  end;

  FilePath := SaveFileName(FilePath);
  if FilePath = '' then Exit;
  ReleaseRes('GameLogin', 'exefile', PChar(FilePath));
  Target:= TMemoryStream.Create;
  try
    Target.LoadFromFile(PChar(FilePath));
    FillChar(MyRecInfo, SizeOf(MyRecInfo), 0);
    MyRecInfo.SourceFileSize:= Target.Size;//µÇÂ½Æ÷´óÐ¡

    MyRecInfo.lnkName := Trim(LnkEdt.Text);
    MyRecInfo.GameListURL := Trim(GameListURLEdt.Text);
    MyRecInfo.boAutoUpData := False;//bsSkinCheckRadioBoxGameMon.Checked;
    if bsSkinCheckRadioBoxGameMon.Checked then
      MyRecInfo.GameMonListURL := Trim(GameMonListURLEdt.Text)
    else
      MyRecInfo.GameMonListURL := '';
    MyRecInfo.PatchListURL := Trim(PatchListURLEdt.Text);
    MyRecInfo.ClientFileName := Trim(ClientFileEdt.Text);
    //MyRecInfo. := Trim(ClientlocalFileEdt.Text);
    if Trim(GameESystemEdt.Text) = '' then GameESystemEdt.Text := 'http://about:blank';
    MyRecInfo.GameESystemUrl := Trim(GameESystemEdt.Text);

    if bsSkinCheckRadioBoxTzHintFile.Checked then begin
      if FileExists(AppPath+TzHintList) then begin
        TzHint:= TMemoryStream.Create;
        try
          TzHint.LoadFromFile(PChar(AppPath+TzHintList));
          EnCompressStream(TzHint);//Ñ¹ËõÁ÷
          Target.Seek(0,soFromEnd);//ÒÆ¶¯µ½Á÷Î²²¿
          Target.CopyFrom(TzHint, TzHint.Size);//Ð´ÈëÌ××°ÎÄ¼þÁ÷
          MyRecInfo.TzHintListFileSize:= TzHint.Size;//¼ÇÂ¼Ì××°ÎÄ¼þ´óÐ¡
        finally
          TzHint.Free;
        end;
      end else begin
        Mes.MessageDlg('Éú³ÉÊ§°Ü£¡'+#13+'Ì××°ÌáÊ¾ÎÄ¼þ['+TzHintList+']²»´æÔÚ£¡ÇëÏÈÉú³ÉÌ××°ÌáÊ¾ÎÄ¼þ',mtError,[mbOK],0);
        Exit;
      end;
    end else MyRecInfo.TzHintListFileSize:= 0;

    if bsSkinCheckRadioBoxPulsDesc.Checked then begin
      if FileExists(AppPath+'PulsDesc.txt') then begin
        PulsDescFile:= TMemoryStream.Create;
        try
          PulsDescFile.LoadFromFile(PChar(AppPath+'PulsDesc.txt'));
          EnCompressStream(PulsDescFile);//Ñ¹ËõÁ÷
          Target.Seek(0,soFromEnd);//ÒÆ¶¯µ½Á÷Î²²¿
          Target.CopyFrom(PulsDescFile, PulsDescFile.Size);//Ð´Èë¾­ÂçÎÄ¼þÁ÷
          MyRecInfo.PulsDescFileSize:= PulsDescFile.Size;//¼ÇÂ¼¾­ÂçÎÄ¼þ´óÐ¡
        finally
          PulsDescFile.Free;
        end;
      end else begin
        Mes.MessageDlg('Éú³ÉÊ§°Ü£¡'+#13+'¾­ÂçÌáÊ¾ÎÄ¼þ[PulsDesc.txt]²»´æÔÚ£¡ÇëÈ·ÈÏÎÄ¼þÊÇ·ñÔÚÄ¿Â¼ÏÂ:'+AppPath,mtError,[mbOK],0);
        Exit;
      end;
    end else MyRecInfo.PulsDescFileSize:= 0;

    if bsSkinCheckRadioBoxSdoFilter.Checked then begin
      if FileExists(AppPath + FilterFileName) then begin
        GameSdoFilterFile:= TMemoryStream.Create;
        try
          GameSdoFilterFile.LoadFromFile(PChar(AppPath + FilterFileName));
          EnCompressStream(GameSdoFilterFile);//Ñ¹ËõÁ÷
          Target.Seek(0,soFromEnd);//ÒÆ¶¯µ½Á÷Î²²¿
          Target.CopyFrom(GameSdoFilterFile, GameSdoFilterFile.Size);//Ð´ÈëÎÄ¼þÁ÷
          MyRecInfo.GameSdoFilterFileSize:= GameSdoFilterFile.Size;//¼ÇÂ¼ÎÄ¼þ´óÐ¡
        finally
          GameSdoFilterFile.Free;
        end;
      end else begin
        Mes.MessageDlg('Éú³ÉÊ§°Ü£¡'+#13+'Ê¢´óÄÚ¹Ò¹ýÂËÎÄ¼þ²»´æÔÚ£¡ÇëÏÈÉú³É¹ýÂËÎÄ¼þ',mtError,[mbOK],0);
        Exit;
      end;
    end else MyRecInfo.GameSdoFilterFileSize:= 0;
    //s:= Memo2.Lines.Text;
    //strpcopy(pchar(@MyRecInfo.GameSdoFilter),s); //½«S  ¸³¸øMyRecInfo.GameSdoFilterÊý×é   ÔõÃ´ÏÔÊ¾³öÀ´²Î¿¼µÇÂ½Æ÷
    Target.SaveToFile(PChar(FilePath));
  finally
    Target.Free;
  end;
  MyRecInfo.FDDllFileSize := RzRadioGroupMainImages.ItemIndex;
  if WriteInfo(FilePath, MyRecInfo) then
  Mes.MessageDlg(PChar(FilePath + 'ÒÑÉú³ÉÍê±Ï!'),mtInformation,[mbOK],0);
end;

procedure TMainFrm.bsSkinButton2Click(Sender: TObject);
var
  Inifile: TInifile;
begin
  Inifile:=TIniFile.Create(AppPath+'QKConfig.ini');
  Inifile.WriteString('LoginInfo','LnkName',LnkEdt.Text);
  Inifile.WriteString('LoginInfo','ClientFileName',ClientFileEdt.Text);
  Inifile.WriteString('LoginInfo','ClientLocalFileName',ClientLocalFileEdt.Text);
  Inifile.WriteString('LoginInfo','GameListURL',GameListURLEdt.Text);
  Inifile.WriteString('LoginInfo','PatchListURL',PatchListURLEdt.Text);
  Inifile.WriteString('LoginInfo','GameMonListURL', GameMonListURLEdt.Text);
  Inifile.WriteBool('LoginInfo','SdoFilter',bsSkinCheckRadioBoxSdoFilter.Checked);
  Inifile.WriteBool('LoginInfo','GameMon',bsSkinCheckRadioBoxGameMon.Checked);
  Inifile.WriteBool('LoginInfo', 'TzHintFile', bsSkinCheckRadioBoxTzHintFile.Checked);
  Inifile.WriteBool('LoginInfo', 'PulsDesc', bsSkinCheckRadioBoxPulsDesc.Checked);
  Inifile.WriteString('LoginInfo','GameESystem',GameESystemEdt.Text);
  Inifile.WriteInteger('LoginInfo','MainJpg',RzRadioGroupMainImages.ItemIndex);
  Inifile.Free;
  Mes.MessageDlg('µÇÂ½Æ÷ÅäÖÃÐÅÏ¢ÒÑ±£´æ£¡',mtInformation,[mbOK],0);
end;

procedure TMainFrm.bsSkinButton9Click(Sender: TObject);
var
  Inifile: TInifile;
  I,II: Integer;
begin
  Inifile:=TIniFile.Create(AppPath+'QKConfig.ini');
  Inifile.WriteInteger('ServerList','GroupCount',ComboBox1.Items.Count);
  for I:=0 to ComboBox1.Items.Count -1 do
  begin
   Inifile.WriteString('ServerList','Group'+inttostr(I+1),ComboBox1.Items[I]);
  end;
  Inifile.WriteInteger('ServerList','ListCount',ListView1.Items.Count);
  for II:=0 to ListView1.Items.Count -1 do
  begin
   Inifile.WriteString('ServerList','ServerArray'+Inttostr(II+1),ListView1.Items.Item[II].Caption);
   Inifile.WriteString('ServerList','ServerName'+Inttostr(II+1),ListView1.Items.Item[II].SubItems.Strings[0]);
   Inifile.WriteString('ServerList','ServerIP'+Inttostr(II+1),ListView1.Items.Item[II].SubItems.Strings[1]);
   Inifile.WriteString('ServerList','ServerPort'+Inttostr(II+1),ListView1.Items.Item[II].SubItems.Strings[2]);
   Inifile.WriteString('ServerList','ServerNoticeURL'+Inttostr(II+1),ListView1.Items.Item[II].SubItems.Strings[3]);
   Inifile.WriteString('ServerList','ServerHomeURL'+Inttostr(II+1),ListView1.Items.Item[II].SubItems.Strings[4]);
  end;
   Inifile.Free;
   Mes.MessageDlg('ÓÎÏ·ÁÐ±íÅäÖÃÐÅÏ¢ÒÑ±£´æ£¡',mtInformation,[mbOK],0);
end;

procedure TMainFrm.bsSkinButton4Click(Sender: TObject);
begin
  ClientFileEdt.Text := RandomGetName()+'.THG';
end;

procedure TMainFrm.bsSkinButton6Click(Sender: TObject);
begin
  ClientLocalFileEdt.Text := RandomGetName()+'.Lis';
end;


{******************************************************************************}
//·´Íâ¹ÒÅäÖÃ
function TMainFrm.InGameMonList(sFilterMsg: string): Boolean;
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

procedure TMainFrm.BtnGameMonAddClick(Sender: TObject);
var
  sGameMonName: string;
  ListItem: TListItem;
  sGameTyep: string;
begin
  sGameMonName := Trim(EditGameMon.Text);
  if sGameMonName = '' then begin
    Mes.MessageDlg('ÇëÊäÈëÍâ¹ÒÌØÕ÷Ãû³Æ£¡',mtError,[mbOK],0);
    Exit;
  end;
  if InGameMonList(sGameMonName) then begin
    Mes.MessageDlg('ÄãÊäÈëµÄÍâ¹ÒÌØÕ÷Ãû³ÆÒÑ¾­´æÔÚ£¡£¡£¡',mtError,[mbOK],0);
    Exit;
  end;
  case GameMonTypeRadioGroup.ItemIndex of
    0: sGameTyep := '±êÌâÌØÕ÷';
    1: sGameTyep := '½ø³ÌÌØÕ÷';
    2: sGameTyep := 'Ä£¿éÌØÕ÷';
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

procedure TMainFrm.BtnGameMonDelClick(Sender: TObject);
begin
  try
    ListViewGameMon.DeleteSelected;
  except
  end;
end;

procedure TMainFrm.BtnChangeGameMonClick(Sender: TObject);
var
  sGameMonName: string;
  ListItem: TListItem;
  sGameTyep: string;
begin
  sGameMonName := Trim(EditGameMon.Text);
  if sGameMonName = '' then begin
    Mes.MessageDlg('ÇëÊäÈëÍâ¹ÒÌØÕ÷Ãû³Æ£¡',mtError,[mbOK],0);
    Exit;
  end;
  if InGameMonList(sGameMonName) then begin
    Mes.MessageDlg('ÄãÊäÈëµÄÍâ¹ÒÌØÕ÷Ãû³ÆÒÑ¾­´æÔÚ£¡£¡£¡',mtError,[mbOK],0);
    Exit;
  end;
  case GameMonTypeRadioGroup.ItemIndex of
    0: sGameTyep := '±êÌâÌØÕ÷';
    1: sGameTyep := '½ø³ÌÌØÕ÷';
    2: sGameTyep := 'Ä£¿éÌØÕ÷';
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

procedure TMainFrm.ListViewGameMonClick(Sender: TObject);
var
  ListItem: TListItem;
  nItemIndex: Integer;
  nGameMonType :Byte;
begin
  try
    nItemIndex := ListViewGameMon.ItemIndex;
    ListItem := ListViewGameMon.Items.Item[nItemIndex];
    EditGameMon.Text := ListItem.SubItems.Strings[0];
    if ListItem.Caption = '±êÌâÌØÕ÷' then nGameMonType := 0;
    if ListItem.Caption = '½ø³ÌÌØÕ÷' then nGameMonType := 1;
    if ListItem.Caption = 'Ä£¿éÌØÕ÷' then nGameMonType := 2;
    GameMonTypeRadioGroup.ItemIndex := nGameMonType;
    BtnChangeGameMon.Enabled := TRUE;
    BtnGameMonDel.Enabled := TRUE;
  except
    EditGameMon.Text := '';
    BtnChangeGameMon.Enabled := False;
    BtnGameMonDel.Enabled := False;
  end;
end;

procedure TMainFrm.BtnSaveGameMonClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;
  sGameMonName: string;
  sGameTyepName: string;
begin
  SaveList := TStringList.Create;
  SaveList.Add(';ÌØÕ÷·ÖÀà'#9'Íâ¹ÒÌØÕ÷');
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
  SaveList.SaveToFile(AppPath+GameMonName);
  SaveList.Free;
  Mes.MessageDlg('·´Íâ¹ÒÁÐ±íÉú³É³É¹¦'+#13+'Çë¸´ÖÆÄ¿Â¼ÏÂµÄ'+' QKGameMonList.txt '+'´«µ½ÄãµÄÍøÕ¾Ä¿Â¼ÏÂ¼´¿É',mtInformation,[mbOK],0);
end;

procedure TMainFrm.ListViewDisallowMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if   Button   =   mbLeft   then
  begin
      bsSkinPopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
  end
end;

//****************Ì××°²¿·Ö´úÂë******************
procedure TMainFrm.BtnTzHelpClick(Sender: TObject);
begin
  FrmTzHelp.ShowModal;
end;

procedure TMainFrm.BtnTzOpenClick(Sender: TObject);
var
  sFileName, sLineText: string;
  LoadList: TStringList;
  I: Integer;
  sTzCaption, sTzItems, sItemsCount, sItemsAbli, sMemo: string;
  ListItem: TListItem;
begin
  bsSkinOpenDialog1.Filter := 'Ì××°ÌáÊ¾ÐÅÏ¢ÎÄ¼þ|*.TxT';
  if bsSkinOpenDialog1.Execute then begin
    sFileName := bsSkinOpenDialog1.FileName;
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

procedure TMainFrm.BtnTzAddClick(Sender: TObject);
  function IsChar(str:string):integer;//ÅÐ¶ÏÓÐ¼¸¸ö'|'ºÅ
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
      Application.MessageBox('Ì××°±êÌâ²»ÄÜÎª¿Õ£¡£¡£¡', 'ÌáÊ¾ÐÅÏ¢', MB_ICONQUESTION);
      EdtTzCaption.SetFocus;
      Exit;
    end;
    if IsChar(EdtTzItems.text) <= 0 then begin
      Application.MessageBox('Ì××°Ãû×ÖÊäÈë²»ÕýÈ·,¸ñÊ½:XXX|XXX|£¡£¡£¡', 'ÌáÊ¾ÐÅÏ¢', MB_OK + MB_ICONERROR);
      EdtTzItems.SetFocus;
      Exit;
    end;
    sItemName := Trim(Memo.Text);
    if sItemName = '' then begin
      Application.MessageBox('Ì××°¹¦ÄÜ½²½â²»ÄÜÎª¿Õ£¡£¡£¡', 'ÌáÊ¾ÐÅÏ¢', MB_ICONQUESTION);
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
end;

procedure TMainFrm.BtnTzDelClick(Sender: TObject);
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

procedure TMainFrm.BtnTzChgClick(Sender: TObject);
  function IsChar(str:string):integer;//ÅÐ¶ÏÓÐ¼¸¸ö'|'ºÅ
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
    Application.MessageBox('Ì××°±êÌâ²»ÄÜÎª¿Õ£¡£¡£¡', 'ÌáÊ¾ÐÅÏ¢', MB_ICONQUESTION);
    EdtTzCaption.SetFocus;
    Exit;
  end;
  if IsChar(EdtTzItems.text) <= 0 then begin
    Application.MessageBox('Ì××°Ãû×ÖÊäÈë²»ÕýÈ·,¸ñÊ½:XXX|XXX|£¡£¡£¡', 'ÌáÊ¾ÐÅÏ¢', MB_OK + MB_ICONERROR);
    EdtTzItems.SetFocus;
    Exit;
  end;
  if SpinEdit30.Value <= 0 then begin//20090413
    Application.MessageBox('Ì××°ÊýÁ¿²»ÄÜÎª0£¡£¡£¡', 'ÌáÊ¾ÐÅÏ¢', MB_OK + MB_ICONERROR);
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

procedure TMainFrm.BtnTzSaveClick(Sender: TObject);
var
  I: Integer;
  ListItem: TListItem;
  SaveList: TStringList;

  sTzCaption, sTzItems, sItemsCount, sItemsAbli, sMemo: string;
  sFileName, sLineText: string;
begin
  if ListViewTzItemList.Items.Count = 0 then begin
    Application.MessageBox('Ì××°ÁÐ±íÊÇ¿ÕµÄÅ¶£¡', 'Error', MB_OK + 
      MB_ICONSTOP);
    Exit;
  end;

  sFileName := AppPath + TzHintList{'.\TzHintList.txt'};
  SaveList := TStringList.Create();
  SaveList.Add(';¿Í»§¶ËÌ××°ÏÔÊ¾ÅäÖÃÎÄ¼þ');
  SaveList.Add(';Ì××°±êÌâ ÊýÁ¿ Ì××°ÎïÆ· Ì××°ÊôÐÔ Ì××°¹¦ÄÜÏê½â');
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
  Application.MessageBox('TzHintList.txtÉú³É³É¹¦£¡£¡£¡', 'ÌáÊ¾ÐÅÏ¢', MB_ICONQUESTION);
end;

procedure TMainFrm.ListViewTzItemListClick(Sender: TObject);
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

procedure TMainFrm.FormShow(Sender: TObject);
var
  sProductName: string;
begin
  Decode(g_sProductName, sProductName);
  Caption := sProductName;
  bsSkinCheckRadioBoxPulsDesc.Visible := GVersion = 0;
  if GVersion = 1 then bsSkinCheckRadioBoxPulsDesc.Checked := False;
  {$IF GVersion = 2}
  bsSkinCheckRadioBoxTzHintFile.Visible := False;
  bsSkinCheckRadioBoxPulsDesc.Visible := False;
  TabSheet7.TabVisible := False;
  {$IFEND}
end;

procedure TMainFrm.BtnFromDBClick(Sender: TObject);
begin
  if FrmSelectDB.ShowModal = mrOk then begin
    GetFiterItemFormBDE();
  end;
end;

procedure TMainFrm.GetFiterItemFormBDE;
  function GetItemType(StdMode: Integer): TFilterItemType;
  begin
    case StdMode of
      0..2, 25: Result := i_HPMPDurg;//£­£­25¶¾·û
      10, 11: Result := i_Dress;
      5, 6: Result := i_Weapon;
      30: Result := i_Decorate;//30£­Ñ«ÕÂµÈ
      19, 20, 21, 28, 29: Result := i_Jewelry;
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

procedure TMainFrm.RefListViewFilterItem(ItemType: TFilterItemType);
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

procedure TMainFrm.ListViewFilterItemClick(Sender: TObject);
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

procedure TMainFrm.ComboBoxItemFilterChange(Sender: TObject);
begin
  RefListViewFilterItem(TFilterItemType(ComboBoxItemFilter.ItemIndex));
end;

procedure TMainFrm.BtnFilterOpenClick(Sender: TObject);
var
  sFileName: string;
begin
  bsSkinOpenDialog1.Filter := 'ÄÚ¹Ò¹ýÂËÎÄ¼þ|*.TxT';
  if bsSkinOpenDialog1.Execute then begin
    sFileName := bsSkinOpenDialog1.FileName;
    LoadFilterItemList(sFileName);
  end;
end;

procedure TMainFrm.BtnFilterAddClick(Sender: TObject);
var
  FilterItem: pTFilterItem;
  sItemName: string;
  nType: Integer;
begin
  sItemName := EditFilterItemName.Text;
  nType := ComboBoxItemFilter.ItemIndex;

  if sItemName = '' then begin
    Mes.MessageDlg('ÇëÊäÈëÎïÆ·Ãû³Æ£¡£¡£¡',mtError,[mbOK],0);
    Exit;
  end;
  if FindFilterItemName(sItemName) <> '' then begin
    Mes.MessageDlg('´ËÎïÆ·ÒÑ¾­Ìí¼Ó£¡£¡£¡',mtError,[mbOK],0);
    Exit;
  end;
  if nType <= 0 then begin
    Mes.MessageDlg('ÇëÑ¡ÔñÎïÆ·ÀàÐÍ£¡£¡£¡',mtError,[mbOK],0);
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

procedure TMainFrm.BtnFilterChgClick(Sender: TObject);
var
  ListItem: TListItem;
  FilterItem: pTFilterItem;
  sItemName: string;
  nType: Integer;
begin
  sItemName := EditFilterItemName.Text;
  nType := ComboBoxItemFilter.ItemIndex;
  if sItemName = '' then begin
    Mes.MessageDlg('ÇëÊäÈëÎïÆ·Ãû³Æ£¡£¡£¡',mtError,[mbOK],0);
    Exit;
  end;
  if nType <= 0 then begin
    Mes.MessageDlg('ÇëÑ¡ÔñÎïÆ·ÀàÐÍ£¡£¡£¡',mtError,[mbOK],0);
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

procedure TMainFrm.BtnFilterDelClick(Sender: TObject);
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

procedure TMainFrm.BtnFilterSaveClick(Sender: TObject);
begin
  bsSkinSaveDialog1.Filter := 'ÄÚ¹Ò¹ýÂËÎÄ¼þ|*.TxT';
  bsSkinSaveDialog1.DefaultExt := 'TxT';
  if bsSkinSaveDialog1.Execute then begin
    SaveFilterItemList(bsSkinSaveDialog1.FileName);
    BtnFilterSave.Enabled := False;
    BtnFilterChg.Enabled := False;
    BtnFilterDel.Enabled := False;
  end;
end;

procedure TMainFrm.N1Click(Sender: TObject);
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

procedure TMainFrm.N2Click(Sender: TObject);
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

procedure TMainFrm.N3Click(Sender: TObject);
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

procedure TMainFrm.bsSkinPopupMenu1Popup(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewFilterItem.Selected;
  if ListItem = nil then Exit;
  N1.Checked := ListItem.SubItems.Strings[1] = 'ÊÇ';
  N2.Checked := ListItem.SubItems.Strings[2] = 'ÊÇ';
  n3.Checked := ListItem.SubItems.Strings[3] = 'ÊÇ';
end;

procedure TMainFrm.FormDestroy(Sender: TObject);
begin
  StdItemList.Free;
  UnLoadFilterItemList;
end;

end.
