unit IPaddrFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JSocket, WinSock, Menus, Spin, IniFiles, ComCtrls,
  RzTrkBar;

type
  TfrmIPaddrFilter = class(TForm)
    GroupBoxActive: TGroupBox;
    ListBoxActiveList: TListBox;
    GroupBox1: TGroupBox;
    ListBoxTempList: TListBox;
    ListBoxBlockList: TListBox;
    LabelTempList: TLabel;
    Label1: TLabel;
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
    Label4: TLabel;
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
    ListBox1: TListBox;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    Label9: TLabel;
    EditMaxConnOfNoLegal: TSpinEdit;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ActiveListPopupMenuPopup(Sender: TObject);
    procedure APOPMENU_KICKClick(Sender: TObject);
    procedure APOPMENU_SORTClick(Sender: TObject);
    procedure APOPMENU_ADDTEMPLISTClick(Sender: TObject);
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
    procedure RadioDisConnectClick(Sender: TObject);
    procedure RadioAddBlockListClick(Sender: TObject);
    procedure RadioAddTempListClick(Sender: TObject);
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
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure EditMaxConnOfNoLegalChange(Sender: TObject);

  private
    { Private declarations }
    procedure ChgHint;
  public
    { Public declarations }
  end;

var
  frmIPaddrFilter: TfrmIPaddrFilter;

implementation

uses Main, GateShare, HUtil32;

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
  ListBoxActiveList.Clear;
  ListBoxTempList.Clear;
  ListBoxBlockList.Clear;
  ChgHint;
end;

procedure TfrmIPaddrFilter.ActiveListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin
  APOPMENU_SORT.Enabled := ListBoxActiveList.Items.Count > 0;

  boCheck := (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count);

  APOPMENU_ADDTEMPLIST.Enabled := boCheck;
  APOPMENU_BLOCKLIST.Enabled := boCheck;
  APOPMENU_KICK.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.APOPMENU_KICKClick(Sender: TObject);
var
  I: integer;
  sIPaddr: string;
begin
  if (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count) then begin
    if Application.MessageBox(PChar('是否确认将此连接断开？'),
      PChar('确认信息 - ' + ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex]), MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
     if ListBoxActiveList.Selected[ListBoxActiveList.ItemIndex] then begin//20091121
       ListBox1.Clear;
       ListBoxActiveList.CopySelection(ListBox1);
       ListBoxActiveList.ClearSelection;
       if ListBox1.Count > 0 then begin
         for I := 0 to ListBox1.Count - 1 do begin
           sIPaddr := Copy(ListBox1.Items.Strings[I],0,pos('->',ListBox1.Items.Strings[I])-1);
           FrmMain.CloseConnect(sIPaddr);//断开连接
         end;
       end;
     end;
    //TCustomWinSocket(ListBoxActiveList.Items.Objects[ListBoxActiveList.ItemIndex]).Close;
    APOPMENU_REFLISTClick(Self);
  end;
end;

procedure TfrmIPaddrFilter.APOPMENU_SORTClick(Sender: TObject);
begin
  ListBoxActiveList.Sorted := True;
end;

procedure TfrmIPaddrFilter.APOPMENU_ADDTEMPLISTClick(Sender: TObject);
var
  sIPaddr: string;
  I: Integer;
begin
{  if (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count) then begin
    sIPaddr := ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex];
    if Application.MessageBox(PChar('是否确认将此IP加入动态过滤列表中？加入过滤列表后，此IP建立的所有连接将被强行中断。'),
      PChar('确认信息 - ' + ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex]),
      MB_OKCANCEL + MB_ICONQUESTION
      ) <> IDOK then Exit;
    ListBoxTempList.Items.Add(sIPaddr);
    FrmMain.AddTempBlockIP(sIPaddr);
    FrmMain.CloseConnect(sIPaddr);
    APOPMENU_REFLISTClick(Self);
  end; }

  if (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count) then begin
    if Application.MessageBox(PChar('是否确认将选定的IP加入动态过滤列表中？加入过滤列表后，选定的IP建立的所有连接将被强行中断。'),
     PChar('确认信息 - ' + ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex]),MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
    if ListBoxActiveList.Selected[ListBoxActiveList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxActiveList.CopySelection(ListBox1);
      ListBoxActiveList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          //sIPaddr := Copy(ListBox1.Items.Strings[I],0,pos('->',ListBox1.Items.Strings[I])-1);
          sIPaddr := ListBox1.Items.Strings[I];
          if ListBoxTempList.Items.IndexOf(sIPaddr) = -1 then begin
            ListBoxTempList.Items.Add(sIPaddr);//动态过滤列表
            FrmMain.AddTempBlockIP(sIPaddr);//加入动态过滤表表
          end;
          FrmMain.CloseConnect(sIPaddr);//断开连接
        end;
      end;
      APOPMENU_REFLISTClick(Self);//刷新连接列表
    end;
  end;
end;

procedure TfrmIPaddrFilter.APOPMENU_BLOCKLISTClick(Sender: TObject);
var
  sIPaddr: string;
  I: Integer;
begin
{  if (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count) then begin
    sIPaddr := ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex];
    if Application.MessageBox(PChar('是否确认将此IP加入永久过滤列表中？加入过滤列表后，此IP建立的所有连接将被强行中断。'),
      PChar('确认信息 - ' + ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex]),
      MB_OKCANCEL + MB_ICONQUESTION
      ) <> IDOK then Exit;
    ListBoxBlockList.Items.Add(sIPaddr);
    FrmMain.AddBlockIP(sIPaddr);
    FrmMain.CloseConnect(sIPaddr);
    APOPMENU_REFLISTClick(Self);
  end; }

  if (ListBoxActiveList.ItemIndex >= 0) and (ListBoxActiveList.ItemIndex < ListBoxActiveList.Items.Count) then begin
    if Application.MessageBox(PChar('是否确认将所选的IP加入永久过滤列表中？加入过滤列表后，所选的IP建立的所有连接将被强行中断。'),
      PChar('确认信息 - ' + ListBoxActiveList.Items.Strings[ListBoxActiveList.ItemIndex]),MB_OKCANCEL + MB_ICONQUESTION) <> IDOK then Exit;
    if ListBoxActiveList.Selected[ListBoxActiveList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxActiveList.CopySelection(ListBox1);
      ListBoxActiveList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          //sIPaddr := Copy(ListBox1.Items.Strings[I],0,pos('->',ListBox1.Items.Strings[I])-1);
          sIPaddr := ListBox1.Items.Strings[I];
          if ListBoxBlockList.Items.IndexOf(sIPaddr) = -1 then begin
            ListBoxBlockList.Items.Add(sIPaddr);
            FrmMain.AddBlockIP(sIPaddr);//加入永久过滤表表
          end;
          FrmMain.CloseConnect(sIPaddr);//断开连接
        end;
      end;
      APOPMENU_REFLISTClick(Self);
    end;
  end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_SORTClick(Sender: TObject);
begin
  ListBoxTempList.Sorted := True;
end;

procedure TfrmIPaddrFilter.TPOPMENU_BLOCKLISTClick(Sender: TObject);
var
  sIPaddr: string;
  I, K: Integer;
  nIPaddr: Integer;
begin
{  if (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count) then begin
    sIPaddr := ListBoxTempList.Items.Strings[ListBoxTempList.ItemIndex];
    ListBoxTempList.Items.Delete(ListBoxTempList.ItemIndex);
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to TempBlockIPList.Count - 1 do begin
      if pTSockaddr(TempBlockIPList.Items[I]).nIPaddr = nIPaddr then begin
        TempBlockIPList.Delete(I);
        break;
      end;
    end;
    ListBoxBlockList.Items.Add(sIPaddr);
    FrmMain.AddBlockIP(sIPaddr);
  end; }

  if (ListBoxTempList.ItemIndex >=0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count) then begin
    if ListBoxTempList.Selected[ListBoxTempList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxTempList.CopySelection(ListBox1);
      ListBoxTempList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sIPaddr:= ListBox1.Items.Strings[I];
          nIPaddr:=inet_addr(PChar(sIPaddr));
          for K := 0 to TempBlockIPList.Count - 1 do begin
            if pTSockaddr(TempBlockIPList.Items[K]).nIPaddr = nIPaddr then begin
              TempBlockIPList.Delete(K);
              break;
            end;
          end;
          if ListBoxBlockList.Items.IndexOf(sIPaddr) = -1 then begin
            ListBoxBlockList.Items.Add(ListBox1.Items.Strings[I]);
            FrmMain.AddBlockIP(sIPaddr);
            SaveBlockIPList();//保存永久过滤列表
          end;
        end;
      end;
    end;
    BPOPMENU_REFLIST.Click;
    TPOPMENU_REFLIST.Click;
  end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_DELETEClick(Sender: TObject);
var
  sIPaddr: string;
  I, K, nIPaddr: Integer;
begin
{  if (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count) then begin
    sIPaddr := ListBoxTempList.Items.Strings[ListBoxTempList.ItemIndex];
    ListBoxTempList.Items.Delete(ListBoxTempList.ItemIndex);
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to TempBlockIPList.Count - 1 do begin
      if pTSockaddr(TempBlockIPList.Items[I]).nIPaddr = nIPaddr then begin
        TempBlockIPList.Delete(I);
        break;
      end;
    end;
  end; }
  if (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count) then begin
    if ListBoxTempList.Selected[ListBoxTempList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxTempList.CopySelection(ListBox1);
      ListBoxTempList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sIPaddr:= ListBox1.Items.Strings[I];
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
    TPOPMENU_REFLIST.Click;
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_SORTClick(Sender: TObject);
begin
  ListBoxBlockList.Sorted := True;
end;

procedure TfrmIPaddrFilter.BPOPMENU_ADDTEMPLISTClick(Sender: TObject);
var
  sIPaddr: string;
  I, K: Integer;
  nIPaddr: Integer;
begin
{  if (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count) then begin
    sIPaddr := ListBoxBlockList.Items.Strings[ListBoxBlockList.ItemIndex];
    ListBoxBlockList.Items.Delete(ListBoxBlockList.ItemIndex);
    nIPaddr := inet_addr(PChar(sIPaddr));
    for I := 0 to BlockIPList.Count - 1 do begin
      if pTSockaddr(BlockIPList.Items[I]).nIPaddr = nIPaddr then begin
        BlockIPList.Delete(I);
        break;
      end;
    end;
    ListBoxTempList.Items.Add(sIPaddr);
    FrmMain.AddTempBlockIP(sIPaddr);
  end; }

  if (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count) then begin
    if ListBoxBlockList.Selected[ListBoxBlockList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxBlockList.CopySelection(ListBox1);
      ListBoxBlockList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sIPaddr:= ListBox1.Items.Strings[I];
          nIPaddr:=inet_addr(PChar(sIPaddr));
          for K := 0 to BlockIPList.Count - 1 do begin
            if pTSockaddr(BlockIPList.Items[K]).nIPaddr = nIPaddr then begin
              BlockIPList.Delete(K);
              break;
            end;
          end;
          if ListBoxTempList.Items.IndexOf(ListBox1.Items.Strings[I]) = -1 then begin
            ListBoxTempList.Items.Add(ListBox1.Items.Strings[I]);
            FrmMain.AddTempBlockIP(sIPaddr);
          end;  
        end;
      end;//if ListBox1.Count > 0
    end;
    TPOPMENU_REFLIST.Click;//刷新动态过滤列表
    SaveBlockIPList();//保存永久过滤列表
    BPOPMENU_REFLIST.Click;
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_DELETEClick(Sender: TObject);
var
  sIPaddr: string;
  I, K: Integer;
  nIPaddr: Integer;
begin
{  if (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count) then begin
    sIPaddr := ListBoxBlockList.Items.Strings[ListBoxBlockList.ItemIndex];
    nIPaddr := inet_addr(PChar(sIPaddr));
    ListBoxBlockList.Items.Delete(ListBoxBlockList.ItemIndex);
    for I := 0 to BlockIPList.Count - 1 do begin
      if pTSockaddr(BlockIPList.Items[I]).nIPaddr = nIPaddr then begin
        BlockIPList.Delete(I);
        break;
      end;
    end;
  end;}
  if (ListBoxBlockList.ItemIndex >=0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count) then begin
    if ListBoxBlockList.Selected[ListBoxBlockList.ItemIndex] then begin
      ListBox1.Clear;
      ListBoxBlockList.CopySelection(ListBox1);
      ListBoxBlockList.ClearSelection;
      if ListBox1.Count > 0 then begin
        for I := 0 to ListBox1.Count - 1 do begin
          sIPaddr:= ListBox1.Items.Strings[I];
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
    BPOPMENU_REFLIST.Click;
    SaveBlockIPList();//保存永久过滤列表
  end;
end;

procedure TfrmIPaddrFilter.TempBlockListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin
  TPOPMENU_SORT.Enabled := ListBoxTempList.Items.Count > 0;

  boCheck := (ListBoxTempList.ItemIndex >= 0) and (ListBoxTempList.ItemIndex < ListBoxTempList.Items.Count);

  TPOPMENU_BLOCKLIST.Enabled := boCheck;
  TPOPMENU_DELETE.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.BlockListPopupMenuPopup(Sender: TObject);
var
  boCheck: Boolean;
begin
  BPOPMENU_SORT.Enabled := ListBoxBlockList.Items.Count > 0;

  boCheck := (ListBoxBlockList.ItemIndex >= 0) and (ListBoxBlockList.ItemIndex < ListBoxBlockList.Items.Count);

  BPOPMENU_ADDTEMPLIST.Enabled := boCheck;
  BPOPMENU_DELETE.Enabled := boCheck;
end;

procedure TfrmIPaddrFilter.EditMaxConnectChange(Sender: TObject);
begin
  nMaxConnOfIPaddr := EditMaxConnect.Value;
end;



procedure TfrmIPaddrFilter.RadioDisConnectClick(Sender: TObject);
begin
  if RadioDisConnect.Checked then BlockMethod := mDisconnect;
  UseBlockMethod := BlockMethod;
end;

procedure TfrmIPaddrFilter.RadioAddBlockListClick(Sender: TObject);
begin
  if RadioAddBlockList.Checked then BlockMethod := mBlockList;
  UseBlockMethod := BlockMethod;
end;

procedure TfrmIPaddrFilter.RadioAddTempListClick(Sender: TObject);
begin
  if RadioAddTempList.Checked then BlockMethod := mBlock;
  UseBlockMethod := BlockMethod;
end;

procedure TfrmIPaddrFilter.APOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
  sIPaddr: string;
begin
  ListBoxActiveList.Clear;
  if FrmMain.ServerSocket.Active then
    for I := 0 to FrmMain.ServerSocket.Socket.ActiveConnections - 1 do begin
      sIPaddr := FrmMain.ServerSocket.Socket.Connections[I].RemoteAddress;
      if sIPaddr <> '' then
        ListBoxActiveList.Items.AddObject(sIPaddr, TObject(FrmMain.ServerSocket.Socket.Connections[I]));
    end;
end;

procedure TfrmIPaddrFilter.TPOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxTempList.Clear;
  for I := 0 to TempBlockIPList.Count - 1 do begin
    ListBoxTempList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(TempBlockIPList.Items[I]).nIPaddr))));
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_REFLISTClick(Sender: TObject);
var
  I: Integer;
begin
  ListBoxBlockList.Clear;
  for I := 0 to BlockIPList.Count - 1 do begin
    ListBoxBlockList.Items.Add(StrPas(inet_ntoa(TInAddr(pTSockaddr(BlockIPList.Items[I]).nIPaddr))));
  end;
end;

procedure TfrmIPaddrFilter.ButtonOKClick(Sender: TObject);
var
  Conf: TIniFile;
  sFileName: string;
begin
  sFileName := '.\Config.ini';
  Conf := TIniFile.Create(sFileName);
  Conf.WriteInteger(GateClass, 'AttackLevel', g_nAttackLevel);
  Conf.WriteInteger(GateClass, 'KeepConnectTimeOut', dwKeepConnectTimeOut);
  Conf.WriteInteger(GateClass, 'MaxConnOfNoLegal', nMaxConnOfNoLegal);//20091121
  Conf.WriteInteger(GateClass, 'MaxConnOfIPaddr', nMaxConnOfIPaddr);
  Conf.WriteInteger(GateClass, 'BlockMethod', Integer(BlockMethod));

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
  sIPaddress: string;
begin
  sIPaddress := '';
  if not InputQuery('动态IP过滤', '请输入一个新的IP地址: ', sIPaddress) then Exit;
  if not IsIPaddr(sIPaddress) then begin
    Application.MessageBox('输入的地址格式错误！！！', '错误信息', MB_OK + MB_ICONERROR);
    Exit;
  end;
  if ListBoxTempList.Items.IndexOf(sIPaddress) = -1 then begin
    ListBoxTempList.Items.Add(sIPaddress);
    FrmMain.AddTempBlockIP(sIPaddress);
  end;
end;

procedure TfrmIPaddrFilter.BPOPMENU_ADDClick(Sender: TObject);
var
  sIPaddress: string;
begin
  sIPaddress := '';
  if not InputQuery('永久IP过滤', '请输入一个新的IP地址: ', sIPaddress) then Exit;
  if not IsIPaddr(sIPaddress) then begin
    if Application.MessageBox('输入的地址格式不完整，是否添加？',
      '错误信息',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then
      Exit;
  end;
  if ListBoxBlockList.Items.IndexOf(sIPaddress) = -1 then begin
    ListBoxBlockList.Items.Add(sIPaddress);
    FrmMain.AddBlockIP(sIPaddress);
    SaveBlockIPList();
  end;
end;

procedure TfrmIPaddrFilter.TrackBarAttackChange(Sender: TObject);
begin
  g_nAttackLevel := TrackBarAttack.Position;
  nUseAttackLevel := g_nAttackLevel;
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

procedure TfrmIPaddrFilter.SpinEdit4Change(Sender: TObject);
begin
  dwAttackTime:= SpinEdit4.Value;
end;

procedure TfrmIPaddrFilter.SpinEdit5Change(Sender: TObject);
begin
  nAttackCount := SpinEdit5.Value;
end;

procedure TfrmIPaddrFilter.EditMaxConnOfNoLegalChange(Sender: TObject);
begin
  nMaxConnOfNoLegal:= EditMaxConnOfNoLegal.Value;
end;

end.

