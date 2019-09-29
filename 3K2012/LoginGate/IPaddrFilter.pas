unit IPaddrFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JSocket, WinSock, Menus, Spin, IniFiles, ComCtrls,
  RzTrkBar, ExtCtrls;

type
  TfrmIPaddrFilter = class(TForm)
    BlockListPopupMenu: TPopupMenu;
    TempBlockListPopupMenu: TPopupMenu;
    ActiveListPopupMenu: TPopupMenu;
    APOPMENU_SORT: TMenuItem;
    APOPMENU_ADDTEMPLIST: TMenuItem;
    APOPMENU_BLOCKLIST: TMenuItem;
    APOPMENU_KICK: TMenuItem;
    TPOPMENU_SORT: TMenuItem;
    TPOPMENU_BLOCKLIST: TMenuItem;
    TPOPMENU_DELETE: TMenuItem;
    BPOPMENU_ADDTEMPLIST: TMenuItem;
    BPOPMENU_SORT: TMenuItem;
    BPOPMENU_DELETE: TMenuItem;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    EditMaxConnect: TSpinEdit;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    RadioAddBlockList: TRadioButton;
    RadioAddTempList: TRadioButton;
    RadioDisConnect: TRadioButton;
    APOPMENU_REFLIST: TMenuItem;
    ButtonOK: TButton;
    TPOPMENU_REFLIST: TMenuItem;
    BPOPMENU_REFLIST: TMenuItem;
    Label7: TLabel;
    TPOPMENU_ADD: TMenuItem;
    BPOPMENU_ADD: TMenuItem;
    Label5: TLabel;
    TrackBarAttack: TTrackBar;
    CheckBoxChg: TCheckBox;
    CheckBoxAutoClearTempList: TCheckBox;
    SpinEdit2: TSpinEdit;
    CheckBoxReliefDefend: TCheckBox;
    SpinEdit3: TSpinEdit;
    SpinEdit1: TSpinEdit;
    Panel1: TPanel;
    GroupBoxActive: TGroupBox;
    Panel3: TPanel;
    ListBoxTempHCList: TListBox;
    LabelTempList: TLabel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    ListBoxBlockHCList: TListBox;
    Label1: TLabel;
    ListBox1: TListBox;
    Label6: TLabel;
    Label8: TLabel;
    EditMaxConnOfNoLegal: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label9: TLabel;
    SpinEdit5: TSpinEdit;
    APOPMENU_HC: TMenuItem;
    APOPMENU_BLOCKLIST_HC: TMenuItem;
    APOPMENU_ADDTEMPLIST_HC: TMenuItem;
    APOPMENU_IP: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel5: TPanel;
    Label10: TLabel;
    ListBoxTempList: TListBox;
    Panel6: TPanel;
    Label11: TLabel;
    ListBoxBlockList: TListBox;
    Splitter3: TSplitter;
    Panel7: TPanel;
    ListViewActiveList: TListView;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure ActiveListPopupMenuPopup(Sender: TObject);
    procedure APOPMENU_KICKClick(Sender: TObject);
    procedure APOPMENU_SORTClick(Sender: TObject);
    procedure APOPMENU_ADDTEMPLIST_Click(Sender: TObject);
    procedure APOPMENU_BLOCKLISTClick(Sender: TObject);
    procedure TPOPMENU_SORTClick(Sender: TObject);
    procedure TPOPMENU_BLOCKLISTClick(Sender: TObject);
    procedure TPOPMENU_DELETEClick(Sender: TObject);
    procedure BPOPMENU_SORTClick(Sender: TObject);
    procedure BPOPMENU_ADDTEMPLISTClick(Sender: TObject);
    procedure BPOPMENU_DELETEClick(Sender: TObject);
    procedure TempBlockListPopupMenuPopup(Sender: TObject);
    procedure BlockListPopupMenuPopup(Sender: TObject);
    procedure EditMaxConnectChange(Sender: TObject);
    procedure rbBlockMethodClick(Sender: TObject);
    procedure BlockMethodDataClick(Sender: TObject);
    procedure APOPMENU_REFLISTClick(Sender: TObject);
    procedure TPOPMENU_REFLISTClick(Sender: TObject);
    procedure BPOPMENU_REFLISTClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure TPOPMENU_ADDClick(Sender: TObject);
    procedure BPOPMENU_ADDClick(Sender: TObject);
    procedure TrackBarAttackChange(Sender: TObject);
    procedure CheckBoxChgClick(Sender: TObject);
    procedure CheckBoxAutoClearTempListClick(Sender: TObject);
    procedure CheckBoxReliefDefendClick(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure EditMaxConnOfNoLegalChange(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure APOPMENU_BLOCKLIST_HCClick(Sender: TObject);
    procedure APOPMENU_ADDTEMPLIST_HCClick(Sender: TObject);

  private
    { Private declarations }
    procedure ChgHint;
  public
    { Public declarations }
  end;

var
  frmIPaddrFilter: TfrmIPaddrFilter;

implementation

uses Main, GateShare, HUtil32, StrUtils;

{$R *.dfm}

procedure TfrmIPaddrFilter.ChgHint;
begin
  TrackBarAttack.Hint := '调整范围在：1-10。分别是：严格-宽松。等级为0时关闭攻击防御！当前等级：' + IntToStr(TrackBarAttack.Position);
  CheckBoxChg.Hint := '被攻击' + IntToStr(g_nChgDefendLevel) + '次后，如果你的防御等级不是1级，程序将自动调整你的防御等级为1级';
  SpinEdit1.Hint := CheckBoxChg.Hint;
  CheckBoxAutoClearTempList.Hint := '每隔' + IntToStr(g_dwClearTempList) + '秒自动清除动态过滤列表中的IP';
  SpinEdit2.Hint := CheckBoxAutoClearTempList.Hint;
  CheckBoxReliefDefend.Hint := '在没有攻击后，等待' + IntToStr(g_dwReliefDefend) + '秒程序将防御等级还原成你最初的设置';
  SpinEdit3.Hint := CheckBoxReliefDefend.Hint;
end;

procedure TfrmIPaddrFilter.FormCreate(Sender: TObject);
begin
  ListViewActiveList.Clear;
  ListBoxTempList.Clear;
  ListBoxBlockList.Clear;
  ChgHint;
end;

procedure TfrmIPaddrFilter.APOPMENU_BLOCKLIST_HCClick(Sender: TObject);
var
  I: integer;
  UserSession :pTUserSession;
  sCode : string;
begin
  if (ListViewActiveList.SelCount > 0) then begin
    if Application.MessageBox(PChar('是否确认将选定的IP加入动态过滤列表中？'+ sLineBreak + '加入过滤列表后，选定的IP建立的所有连接将被强行中断。'),
      PChar('确认信息'), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
    for I := 0 to ListViewActiveList.Items.Count - 1 do with ListViewActiveList.Items[I] do begin
      if Selected then begin
        UserSession := pTUserSession(Data);
        if (UserSession <> nil) and (UserSession.Socket <> nil) and (UserSession.Socket.nIndex >=0) then
          UserSession.Socket.Close;
        sCode := SubItems[0];
        if ListBoxBlockHCList.Items.IndexOf(sCode) = -1 then
          ListBoxBlockHCList.Items.Add(sCode);//动态过滤列表
        FrmMain.AddBlockHC(Str_ToInt(sCode, 0));//加入动态过滤表表
        Delete;
      end;
    end;
    PageControl1.ActivePage := TabSheet2;
  end;
end;

procedure TfrmIPaddrFilter.APOPMENU_ADDTEMPLIST_HCClick(Sender: TObject);
var
  I: integer;
  UserSession :pTUserSession;
  sCode : string;
begin
  if (ListViewActiveList.SelCount > 0) then begin
    if Application.MessageBox(PChar('是否确认将选定的机器码加入永久过滤列表中？'+ sLineBreak + '加入过滤列表后，选定的IP建立的所有连接将被强行中断。'),
      PChar('确认信息'), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
    for I := 0 to ListViewActiveList.Items.Count - 1 do with ListViewActiveList.Items[I] do begin
      if Selected then begin
        UserSession := pTUserSession(Data);
        if (UserSession <> nil) and (UserSession.Socket <> nil) and (UserSession.Socket.nIndex >=0) then
          UserSession.Socket.Close;
        sCode := SubItems[0];
        if ListBoxTempHCList.Items.IndexOf(sCode) = -1 then
          ListBoxTempHCList.Items.Add(sCode);//动态过滤列表
        FrmMain.AddTempBlockHC(Str_ToInt(sCode, 0));//加入动态过滤表表
        Delete;
      end;
    end;
    PageControl1.ActivePage := TabSheet2;
  end;
end;

procedure TfrmIPaddrFilter.ActiveListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin
  APOPMENU_SORT.Enabled := ListViewActiveList.Items.Count > 0;

  boCheck := (ListViewActiveList.ItemIndex >= 0) and (ListViewActiveList.ItemIndex < ListViewActiveList.Items.Count);

  APOPMENU_IP.Enabled := boCheck;
  APOPMENU_HC.Enabled := boCheck;
  APOPMENU_KICK.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.APOPMENU_KICKClick(Sender: TObject);
var
  I: integer;
  UserSession :pTUserSession;
begin
  if (ListViewActiveList.SelCount > 0) then begin
    if Application.MessageBox(PChar('是否确认将这些连接断开？'),
      PChar('确认信息' {+ ListViewActiveList.Items.Strings[ListBoxActiveList.ItemIndex]}), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
    for I := 0 to ListViewActiveList.Items.Count - 1 do with ListViewActiveList.Items[I] do begin
      if Selected then begin
        UserSession := pTUserSession(Data);
        if (UserSession <> nil) and (UserSession.Socket <> nil) and (UserSession.Socket.nIndex >=0) then
          UserSession.Socket.Close;
        Delete;
      end;
    end;
  end;
end;

procedure TfrmIPaddrFilter.APOPMENU_SORTClick(Sender: TObject);
begin
  //ListViewActiveList.SortType := True;
end;

procedure TfrmIPaddrFilter.APOPMENU_ADDTEMPLIST_Click(Sender: TObject);
var
  I: integer;
  UserSession :pTUserSession;
  sIPAddr : string;
begin
  if (ListViewActiveList.SelCount > 0) then begin
    if Application.MessageBox(PChar('是否确认将选定的IP加入动态过滤列表中？'+ sLineBreak + '加入过滤列表后，选定的IP建立的所有连接将被强行中断。'),
      PChar('确认信息' {+ ListViewActiveList.Items.Strings[ListBoxActiveList.ItemIndex]}), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
    for I := 0 to ListViewActiveList.Items.Count - 1 do with ListViewActiveList.Items[I] do begin
      if Selected then begin
        UserSession := pTUserSession(Data);
        if (UserSession <> nil) and (UserSession.Socket <> nil) and (UserSession.Socket.nIndex >=0) then
          UserSession.Socket.Close;
        sIPAddr := Caption;
        if ListBoxTempList.Items.IndexOf(sIPAddr) = -1 then
          ListBoxTempList.Items.Add(sIPAddr);//动态过滤列表
        FrmMain.AddTempBlockIP(sIPAddr,SubItems[1]);//加入动态过滤表表
        Delete;
      end;
    end;
  end;
end;

procedure TfrmIPaddrFilter.APOPMENU_BLOCKLISTClick(Sender: TObject);
var
  I: integer;
  UserSession :pTUserSession;
  sIPAddr : string;
begin
  if (ListViewActiveList.SelCount > 0) then begin
    if Application.MessageBox(PChar('是否确认将选定的IP加入永久过滤列表中？'+ sLineBreak + '加入过滤列表后，选定的IP建立的所有连接将被强行中断。'),
      PChar('确认信息' {+ ListViewActiveList.Items.Strings[ListBoxActiveList.ItemIndex]}), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
    for I := 0 to ListViewActiveList.Items.Count - 1 do with ListViewActiveList.Items[I] do begin
      if Selected then begin
        UserSession := pTUserSession(Data);
        if (UserSession <> nil) and (UserSession.Socket <> nil) and (UserSession.Socket.nIndex >=0) then
          UserSession.Socket.Close;
        sIPAddr := Caption;
        if ListBoxBlockList.Items.IndexOf(sIPAddr) = -1 then
          ListBoxBlockList.Items.Add(sIPAddr);//动态过滤列表
        FrmMain.AddBlockIP(sIPAddr,SubItems[1]);//加入动态过滤表表
        Delete;
      end;
    end;
  end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_SORTClick(Sender: TObject);
begin
  ListBoxTempList.Sorted := True;
end;
//动态到永久
procedure TfrmIPaddrFilter.TPOPMENU_BLOCKLISTClick(Sender: TObject);
var
  sIPaddr, sCode: string;
  I, K: Integer;
  nIPaddr: Integer;
  dwCode : DWord;
begin
  if PageControl1.ActivePage = TabSheet1 then begin
  if (ListBoxTempList.ItemIndex >=0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count) then begin
    if ListBoxTempList.Selected[ListBoxTempList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxTempList.CopySelection(ListBox1);
      //ListBoxTempList.ClearSelection;
      ListBoxTempList.DeleteSelected;//Modified by TasNat at 2012-3-25 15:27:05
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sIPaddr:= Copy(ListBox1.Items.Strings[I], 0 ,pos('->',ListBox1.Items.Strings[I])-1);
          if pos('*',sIPaddr) > 0 then begin//判断是否是IP段 20081030
            for K := 0 to TempBlockIPList.Count - 1 do begin
              if pTSockaddr(TempBlockIPList.Items[K]).sIPaddr = sIPaddr then begin
                TempBlockIPList.Delete(K);
                break;
              end;
            end;
          end else begin
            nIPaddr:=inet_addr(PChar(sIPaddr));
            for K := 0 to TempBlockIPList.Count - 1 do begin
              if pTSockaddr(TempBlockIPList.Items[K]).nIPaddr = nIPaddr then begin
                TempBlockIPList.Delete(K);
                break;
              end;
            end;
          end;
          if ListBoxBlockList.Items.IndexOf(ListBox1.Items.Strings[I]) = -1 then begin
            ListBoxBlockList.Items.Add(ListBox1.Items.Strings[I]);
            FrmMain.AddBlockIP(sIPaddr, SearchIPLocal(sIPaddr));
            SaveBlockIPList();//保存永久过滤列表
          end;
        end;
      end;
    end;
    BPOPMENU_REFLIST.Click;
    TPOPMENU_REFLIST.Click;
  end;
  end else begin

  if (ListBoxTempHCList.ItemIndex >=0) and (ListBoxTempHCList.ItemIndex < ListBoxTempHCList.Items.Count) then begin
    if ListBoxTempHCList.Selected[ListBoxTempHCList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxTempHCList.CopySelection(ListBox1);
      ListBoxTempHCList.DeleteSelected;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sCode:= ListBox1.Items.Strings[I];
          dwCode:= Str_ToInt(sCode, 0);
          TempBlockHCList.Remove(Pointer(dwCode));
          if ListBoxBlockHCList.Items.IndexOf(sCode) = -1 then begin
            ListBoxBlockHCList.Items.Add(sCode);
            FrmMain.AddBlockHC(dwCode);
          end;
        end;
        SaveBlockHCList();//保存永久过滤列表
        BPOPMENU_REFLIST.Click;
        TPOPMENU_REFLIST.Click;
      end;
    end;    
  end;
  end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_DELETEClick(Sender: TObject);
var
  sIPaddr, sLines: string;
  I, K, nIPaddr: Integer;
  dwHCode  : Dword;
begin
  if PageControl1.ActivePage = TabSheet1 then begin
  if (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count) then begin
    if ListBoxTempList.Selected[ListBoxTempList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxTempList.CopySelection(ListBox1);
      ListBoxTempList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sIPaddr:= Copy(ListBox1.Items.Strings[I],0,pos('->',ListBox1.Items.Strings[I])-1);
          if pos('*',sIPaddr) > 0 then begin//判断是否是IP段 20081030
            for K := 0 to TempBlockIPList.Count - 1 do begin
              if pTSockaddr(TempBlockIPList.Items[K]).sIPaddr = sIPaddr then begin
                TempBlockIPList.Delete(K);
                break;
              end;
            end;
          end else begin
            nIPaddr:=inet_addr(PChar(sIPaddr));
            for K := 0 to TempBlockIPList.Count - 1 do begin
              if pTSockaddr(TempBlockIPList.Items[K]).nIPaddr = nIPaddr then begin
                TempBlockIPList.Delete(K);
                break;
              end;
            end;
          end;
        end;
      end;
    end;
    TPOPMENU_REFLIST.Click;
  end;
  end else begin
  if (ListBoxTempHCList.ItemIndex >= 0) and (ListBoxTempHCList.ItemIndex < ListBoxTempHCList.Items.Count) then begin
    if ListBoxTempHCList.Selected[ListBoxTempHCList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxTempHCList.CopySelection(ListBox1);
      ListBoxTempHCList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sLines := ListBox1.Items.Strings[I];
          if sLines <> '' then begin//判断是否是IP段 20081030
            dwHCode := Str_ToInt(sLines, 0);
            TempBlockHCList.Remove(Pointer(dwHCode));
          end;
        end;
      end;
    end;
    TPOPMENU_REFLIST.Click;
  end;
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_SORTClick(Sender: TObject);
begin
  ListBoxBlockList.Sorted := True;
end;
//永久到动态列表
procedure TfrmIPaddrFilter.BPOPMENU_ADDTEMPLISTClick(Sender: TObject);
var
  sIPaddr, sCode: string;
  I, K, II: Integer;
  nIPaddr: Integer;
  dwCode : DWord;
begin
  if PageControl1.ActivePage = TabSheet1 then begin
  if (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count) then begin
     if ListBoxBlockList.Selected[ListBoxBlockList.ItemIndex] then begin
        ListBox1.Clear;
        ListBoxBlockList.CopySelection(ListBox1);
        ListBoxBlockList.ClearSelection;
        if ListBox1.Count > 0 then begin
          for I := 0 to ListBox1.Count - 1 do begin
            sIPaddr:= Copy(ListBox1.Items.Strings[I], 0, pos('->',ListBox1.Items.Strings[I])-1);
            if pos('*',sIPaddr) > 0 then begin//判断是否是IP段 20081030
              for K := 0 to BlockIPList.Count - 1 do begin
                if pTSockaddr(BlockIPList.Items[K]).sIPaddr = sIPaddr then begin
                  BlockIPList.Delete(K);
                  break;
                end;
              end;
            end else begin
              nIPaddr:=inet_addr(PChar(sIPaddr));
              for K := 0 to BlockIPList.Count - 1 do begin
                if pTSockaddr(BlockIPList.Items[K]).nIPaddr = nIPaddr then begin
                  BlockIPList.Delete(K);
                  break;
                end;
              end;
            end;
            if ListBoxTempList.Items.IndexOf(ListBox1.Items.Strings[I]) = -1 then begin
              ListBoxTempList.Items.Add(ListBox1.Items.Strings[I]);
              FrmMain.AddTempBlockIP(sIPaddr, SearchIPLocal(sIPaddr));
            end;
          end;
        end;//if ListBox1.Count > 0
     end;
    TPOPMENU_REFLIST.Click;//刷新动态过滤列表
    SaveBlockIPList();//保存永久过滤列表
    BPOPMENU_REFLIST.Click;
  end;
  end else begin
  if (ListBoxBlockHCList.ItemIndex >= 0) and (ListBoxBlockHCList.ItemIndex < ListBoxBlockHCList.Items.Count) then begin
     if ListBoxBlockHCList.Selected[ListBoxBlockHCList.ItemIndex] then begin
        ListBox1.Clear;
        ListBoxBlockHCList.CopySelection(ListBox1);
        ListBoxBlockHCList.DeleteSelected;
        if ListBox1.Count > 0 then begin
          for I := 0 to ListBox1.Count - 1 do begin
            sCode:= ListBox1.Items.Strings[I];
            dwCode := Str_ToInt(sCode, 0);
            II := TempBlockHCList.IndexOf(Pointer(dwCode));
            if II = -1 then begin
              BlockHCList.Remove(Pointer(dwCode));
            if ListBoxTempHCList.Items.IndexOf(sCode) = -1 then begin
              ListBoxTempHCList.Items.Add(sCode);
              FrmMain.AddTempBlockHC(dwCode);
            end;
            end;
          end;
          TPOPMENU_REFLIST.Click;//刷新动态过滤列表
          SaveBlockHCList();//保存永久过滤列表
          BPOPMENU_REFLIST.Click; 
        end;//if ListBox1.Count > 0
     end;
  end;
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_DELETEClick(Sender: TObject);
var
  sIPaddr, sLines: string;
  I, K: Integer;
  nIPaddr: Integer;
  dwHCode : DWord;
begin
  if PageControl1.ActivePage = TabSheet1 then begin
  if (ListBoxBlockList.ItemIndex >=0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count) then begin
    if ListBoxBlockList.Selected[ListBoxBlockList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxBlockList.CopySelection(ListBox1);
      ListBoxBlockList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sIPaddr:= Copy(ListBox1.Items.Strings[I], 0, pos('->',ListBox1.Items.Strings[I])-1);
          if pos('*',sIPaddr) > 0 then begin//判断是否是IP段 20081030
            for K := 0 to BlockIPList.Count - 1 do begin
              if pTSockaddr(BlockIPList.Items[K]).sIPaddr = sIPaddr then begin
                BlockIPList.Delete(K);
                break;
              end;
            end;
          end else begin
            nIPaddr:=inet_addr(PChar(sIPaddr));
            for K := 0 to BlockIPList.Count - 1 do begin
              if pTSockaddr(BlockIPList.Items[K]).nIPaddr = nIPaddr then begin
                BlockIPList.Delete(K);
                break;
              end;
            end;
          end;
        end;
      end;
    end;
    BPOPMENU_REFLIST.Click;
    SaveBlockIPList();//保存永久过滤列表
  end;
  end else begin
  if (ListBoxBlockHCList.ItemIndex >=0) and (ListBoxBlockHCList.ItemIndex < ListBoxBlockHCList.Items.Count) then begin
    if ListBoxBlockHCList.Selected[ListBoxBlockHCList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxBlockHCList.CopySelection(ListBox1);
      ListBoxBlockHCList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sLines := ListBox1.Items.Strings[I];
          if sLines <> '' then begin//判断是否是IP段 20081030
            dwHCode := Str_ToInt(sLines, 0);
            BlockHCList.Remove(Pointer(dwHCode));
          end;
        end;
      end;
    end;
    BPOPMENU_REFLIST.Click;
    SaveBlockHCList();//保存永久过滤列表
  end;
  end;
end;

procedure TfrmIPaddrFilter.TempBlockListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin
  if PageControl1.ActivePage = TabSheet1 then begin
    TPOPMENU_SORT.Enabled := ListBoxTempList.Items.Count > 0;

    boCheck := (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count);

  end else begin
    TPOPMENU_SORT.Enabled := ListBoxTempHCList.Items.Count > 0;

    boCheck := (ListBoxTempHCList.ItemIndex >= 0) and (ListBoxTempHCList.ItemIndex < ListBoxTempHCList.Items.Count);

  end;
  TPOPMENU_BLOCKLIST.Enabled := boCheck;
  TPOPMENU_DELETE.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.BlockListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin  
  if PageControl1.ActivePage = TabSheet1 then begin
    BPOPMENU_SORT.Enabled := ListBoxBlockList.Items.Count > 0;
    boCheck := (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count);
  end else begin
    TPOPMENU_SORT.Enabled := ListBoxBlockHCList.Items.Count > 0;
    boCheck := (ListBoxBlockHCList.ItemIndex >= 0) and (ListBoxBlockHCList.ItemIndex < ListBoxBlockHCList.Items.Count);
  end;
  BPOPMENU_ADDTEMPLIST.Enabled := boCheck;
  BPOPMENU_DELETE.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.EditMaxConnectChange(Sender: TObject);
begin
  nMaxConnOfIPaddr := EditMaxConnect.Value;
end;

procedure TfrmIPaddrFilter.rbBlockMethodClick(Sender: TObject);
var
  nAddH : Integer;
begin
  if TRadioButton(Sender).Checked then
    g_BlockMethod := TBlockIPMethod(TRadioButton(Sender).Tag);

  nAddH := Byte(g_BlockMethod <> mDisconnect) * (159 - 70);
  GroupBox3.Height := 70 + nAddH;
  Label7.Top := 277 + nAddH;
  ButtonOK.Top := 299 + nAddH;
  ClientHeight := 369 + nAddH;
end;

procedure TfrmIPaddrFilter.BlockMethodDataClick(Sender: TObject);
begin
  if TRadioButton(Sender).Checked then
    g_BlockMethodData := TBlockMethodData(TRadioButton(Sender).Tag);
end;

procedure TfrmIPaddrFilter.APOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
  sIPaddr: string;
  UserSession :pTUserSession;
begin
  ListViewActiveList.Items.BeginUpdate;
  try
    ListViewActiveList.Clear;
    for I := 0 to GATEMAXSESSION - 1 do begin
      UserSession := @g_SessionArray[I];
      if (UserSession.Socket <> nil) and (UserSession.Socket.nIndex = I) then
      with ListViewActiveList.Items.Add do begin
        Caption := UserSession.sRemoteIPaddr;
        SubItems.Add('$' + IntToHex(UserSession.nHCode, 8));
        SubItems.Add(SearchIPLocal(UserSession.sRemoteIPaddr));
        Data := UserSession;
      end;
    end;
  finally
    ListViewActiveList.Items.EndUpdate;
  end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxTempList.Clear;
  for I := 0 to TempBlockIPList.Count - 1 do begin
    if pos('*',pTSockaddr(TempBlockIPList.Items[I]).sIPaddr) > 0 then begin//判断是否是IP段 20081030
      ListBoxTempList.Items.Add(pTSockaddr(TempBlockIPList.Items[I]).sIPaddr);
    end else begin
      ListBoxTempList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(TempBlockIPList.Items[I]).nIPaddr)))+'->'+pTSockaddr(TempBlockIPList.Items[I]).sIPDate);//20080414
    end;
  end;
  ListBoxTempHCList.Clear;
  for I := 0 to TempBlockHCList.Count - 1 do begin
    ListBoxTempHCList.Items.Add('$' + IntToHex(Cardinal(TempBlockHCList.Items[I]), 8));
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxBlockList.Clear;
  for I := 0 to BlockIPList.Count - 1 do begin
    if pos('*',pTSockaddr(BlockIPList.Items[I]).sIPaddr) > 0 then begin//判断是否是IP段 20081030
      ListBoxBlockList.Items.Add(pTSockaddr(BlockIPList.Items[I]).sIPaddr);
    end else begin
      ListBoxBlockList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr)))+'->'+pTSockaddr(BlockIPList.Items[I]).sIPDate);//20080414
    end;
  end;
  ListBoxBlockHCList.Clear;
  for I := 0 to BlockHCList.Count - 1 do begin
    ListBoxBlockHCList.Items.Add('$' + IntToHex(Cardinal(BlockHCList.Items[I]), 8));
  end;
end;

procedure TfrmIPaddrFilter.ButtonOKClick(Sender: TObject);
var
  Conf: TIniFile;
  sFileName: string;
begin
  sFileName := '.\Config.ini';
  Conf := TIniFile.Create(sFileName);
  Conf.WriteInteger(GateClass, 'AttackLevel', nAttackLevel);
  Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
  Conf.WriteInteger(GateClass, 'MaxConnOfNoLegal', nMaxConnOfNoLegal);//20091121
  Conf.WriteInteger(GateClass, 'MaxConnOfIPaddr', nMaxConnOfIPaddr);
  Conf.WriteInteger(GateClass, 'BlockMethod', Integer(g_BlockMethod));
  Conf.WriteInteger(GateClass, 'BlockMethodData', Integer(g_BlockMethodData));

  Conf.WriteBool(GateClass, 'ChgDefendLevel', g_boChgDefendLevel);
  Conf.WriteBool(GateClass, 'ClearTempList', g_boClearTempList);
  Conf.WriteBool(GateClass, 'ReliefDefend', g_boReliefDefend);
  Conf.WriteInteger(GateClass, 'ChgDefendLevelCount', g_nChgDefendLevel);
  Conf.WriteInteger(GateClass, 'ClearTempListTime', g_dwClearTempList);
  Conf.WriteInteger(GateClass, 'ReliefDefendTime', g_dwReliefDefend);

  Conf.WriteInteger(GateClass, 'AttackTime', dwAttackTime);//20091121
  Conf.WriteInteger(GateClass, 'AttackCount', nAttackCount);//20091121
  Conf.Free;
  Close;
end;

procedure TfrmIPaddrFilter.TPOPMENU_ADDClick(Sender: TObject);
var
  sIPaddress, nIP: string;
begin
  sIPaddress := '';
  if PageControl1.ActivePage = TabSheet1 then begin
  if not InputQuery('动态IP过滤', '请输入一个新的IP地址: ', sIPaddress) then Exit;
  if not IsIPaddr(sIPaddress) then begin
    if Application.MessageBox('输入的地址格式不完整，是否添加？',
      '错误信息', MB_YESNO + MB_ICONQUESTION) <> ID_YES then Exit;
  end;
  nIP:= SearchIPLocal(sIPaddress); //20080414
  if ListBoxTempList.Items.IndexOf(sIPaddress + '->'+nIP) = -1 then begin
    ListBoxTempList.Items.Add(sIPaddress + '->'+nIP);//20080414
    FrmMain.AddTempBlockIP(sIPaddress, nIP);//20080414
  end;
  end else begin
    if not InputQuery('动态机器码过滤', '请输入一个机器码: ', sIPaddress) then Exit;
    if (sIPaddress <> '') and (sIPaddress[1] = '$') then begin
      if ListBoxTempHCList.Items.IndexOf(sIPaddress) = -1 then begin
        ListBoxTempHCList.Items.Add(sIPaddress);
        FrmMain.AddTempBlockHC(Str_ToInt(sIPaddress, 0));
      end;
    end;
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_ADDClick(Sender: TObject);
var
  sIPaddress, nIP: string;
begin
  sIPaddress := '';
  if PageControl1.ActivePage = TabSheet1 then begin
  if not InputQuery('永久IP过滤', '请输入一个新的IP地址: ', sIPaddress) then Exit;
  if not IsIPaddr(sIPaddress) then begin
    if Application.MessageBox('输入的地址格式不完整，是否添加？',
      '错误信息', MB_YESNO + MB_ICONQUESTION) <> ID_YES then Exit;
  end;
  nIP:= SearchIPLocal(sIPaddress);//查询IP所属地址
  if ListBoxBlockList.Items.IndexOf(sIPaddress + '->'+ nIP) = -1 then begin
    ListBoxBlockList.Items.Add(sIPaddress + '->'+ nIP);
    FrmMain.AddBlockIP(sIPaddress, nIP);
    SaveBlockIPList();
  end;
  end else begin
    if not InputQuery('永久机器码过滤', '请输入一个机器码: ', sIPaddress) then Exit;
    if (sIPaddress <> '') and (sIPaddress[1] = '$') then begin
      if ListBoxBlockHCList.Items.IndexOf(sIPaddress) = -1 then begin
        ListBoxBlockHCList.Items.Add(sIPaddress);
        FrmMain.AddBlockHC(Str_ToInt(sIPaddress, 0));
      end;
    end;
  end;
end;

procedure TfrmIPaddrFilter.TrackBarAttackChange(Sender: TObject);
begin
  nAttackLevel := TrackBarAttack.Position;
  nUseAttackLevel := nAttackLevel;
  ChgHint;
end;

procedure TfrmIPaddrFilter.CheckBoxChgClick(Sender: TObject);
begin
  g_boChgDefendLevel := CheckBoxChg.Checked;
end;

procedure TfrmIPaddrFilter.CheckBoxAutoClearTempListClick(Sender: TObject);
begin
  g_boClearTempList := CheckBoxAutoClearTempList.Checked;
end;

procedure TfrmIPaddrFilter.CheckBoxReliefDefendClick(Sender: TObject);
begin
  g_boReliefDefend := CheckBoxReliefDefend.Checked;
end;

procedure TfrmIPaddrFilter.SpinEdit1Change(Sender: TObject);
begin
  g_nChgDefendLevel := SpinEdit1.Value;
  ChgHint;
end;

procedure TfrmIPaddrFilter.SpinEdit2Change(Sender: TObject);
begin
  g_dwClearTempList := SpinEdit2.Value;
  ChgHint;
end;

procedure TfrmIPaddrFilter.SpinEdit3Change(Sender: TObject);
begin
  g_dwReliefDefend := SpinEdit3.Value;
  ChgHint;
end;

procedure TfrmIPaddrFilter.EditMaxConnOfNoLegalChange(Sender: TObject);
begin
  nMaxConnOfNoLegal:= EditMaxConnOfNoLegal.Value;
end;

procedure TfrmIPaddrFilter.SpinEdit4Change(Sender: TObject);
begin
  dwAttackTime:= SpinEdit4.Value;
end;

procedure TfrmIPaddrFilter.SpinEdit5Change(Sender: TObject);
begin
  nAttackCount := SpinEdit5.Value;
end;

end.

