unit EditRcd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grobal2, ComCtrls, StdCtrls, Spin, HumDB, DBShare;

type
  TfrmEditRcd = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditChrName: TEdit;
    Label2: TLabel;
    EditAccount: TEdit;
    Label3: TLabel;
    EditPassword: TEdit;
    Label4: TLabel;
    EditDearName: TEdit;
    Label5: TLabel;
    EditMasterName: TEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    EditIdx: TEdit;
    Label12: TLabel;
    EditCurMap: TEdit;
    Label13: TLabel;
    EditCurX: TSpinEdit;
    EditCurY: TSpinEdit;
    Label14: TLabel;
    Label15: TLabel;
    EditHomeMap: TEdit;
    EditHomeX: TSpinEdit;
    EditHomeY: TSpinEdit;
    EditLevel: TSpinEdit;
    EditGold: TSpinEdit;
    EditGameGold: TSpinEdit;
    EditGamePoint: TSpinEdit;
    Label16: TLabel;
    EditCreditPoint: TSpinEdit;
    Label10: TLabel;
    EditPayPoint: TSpinEdit;
    Label17: TLabel;
    EditPKPoint: TSpinEdit;
    Label18: TLabel;
    EditContribution: TSpinEdit;
    GroupBox3: TGroupBox;
    ListViewMagic: TListView;
    GroupBox4: TGroupBox;
    ListViewUserItem: TListView;
    GroupBox5: TGroupBox;
    ListViewStorage: TListView;
    ButtonSaveData: TButton;
    ButtonExportData: TButton;
    ButtonImportData: TButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    CheckBoxIsMaster: TCheckBox;
    Label19: TLabel;
    Label20: TLabel;
    EditExpRate: TSpinEdit;
    EditExpTime: TSpinEdit;
    Label21: TLabel;
    EditBonusPoint: TSpinEdit;
    GroupBox6: TGroupBox;
    Label22: TLabel;
    EditDC: TSpinEdit;
    Label23: TLabel;
    EditMC: TSpinEdit;
    Label24: TLabel;
    EditSC: TSpinEdit;
    Label25: TLabel;
    Label26: TLabel;
    EditAC: TSpinEdit;
    EditMAC: TSpinEdit;
    Label27: TLabel;
    EditHP: TSpinEdit;
    Label28: TLabel;
    EditMP: TSpinEdit;
    EditHit: TSpinEdit;
    EditSpeed: TSpinEdit;
    EditX2: TSpinEdit;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    EditGameGird: TSpinEdit;
    Label32: TLabel;
    EditGameDiaMond: TSpinEdit;
    Label33: TLabel;
    EditHeroLoyal: TSpinEdit;
    Label34: TLabel;
    Label35: TLabel;
    EditHeroName: TEdit;
    CheckHero: TCheckBox;
    CheckHeroTwo: TCheckBox;
    CheckBoxModeAccount: TCheckBox;
    CheckBoxModeName: TCheckBox;
    Label36: TLabel;
    Label37: TLabel;
    SpinEditNGLevel: TSpinEdit;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    EditDecDamage: TSpinEdit;
    EditPulseAddMAC1: TSpinEdit;
    EditPulseAddMAC: TSpinEdit;
    EditPulseAddAC1: TSpinEdit;
    EditPulseAddAC: TSpinEdit;
    Label43: TLabel;
    EditHero1Name: TEdit;
    procedure ButtonExportDataClick(Sender: TObject);
    procedure EditPasswordChange(Sender: TObject);
    procedure CheckBoxModeAccountClick(Sender: TObject);
    procedure CheckBoxModeNameClick(Sender: TObject);
  private
    m_boOpened: Boolean;
    procedure RefShow();
    procedure RefShowRcd();
    procedure RefShowMagic();
    procedure RefShowUserItem();
    procedure RefShowStorage();
    procedure ProcessSaveRcdToFile();
    procedure ProcessLoadRcdformFile();
    procedure ProcessSaveRcd();
    { Private declarations }
  public
    m_ChrRcd: THumDataInfo;
    m_nIdx, HumIndex: Integer;
    sHeroName1:string;
    procedure Open();
    { Public declarations }
  end;

var
  frmEditRcd: TfrmEditRcd;

implementation

{$R *.dfm}

{ TfrmEditRcd }


procedure TfrmEditRcd.RefShowRcd;
begin
  EditIdx.Text := IntToStr(m_nIdx);
  EditChrName.Text := m_ChrRcd.Data.sChrName;
  EditAccount.Text := m_ChrRcd.Data.sAccount;
  EditPassword.Text := m_ChrRcd.Data.sStoragePwd;
  EditDearName.Text := m_ChrRcd.Data.sDearName;
  EditMasterName.Text := m_ChrRcd.Data.sMasterName;
  CheckBoxIsMaster.Checked := m_ChrRcd.Data.boMaster;
  EditHeroName.Text := m_ChrRcd.Data.sHeroChrName;
  if not m_ChrRcd.Data.boIsHero then begin
    CheckHero.Enabled := True;
    CheckHeroTwo.Enabled := True;
    CheckHero.Checked:= m_ChrRcd.Data.boHasHero;
    CheckHeroTwo.Checked := m_ChrRcd.Data.boReserved1;
    CheckBoxIsMaster.Enabled := True;
    EditHeroName.Enabled := True;
    EditDearName.Enabled := True;
    EditPassword.Enabled := True;
    EditHero1Name.Visible:= True;
    Label43.Visible:= True;
    //EditHero1Name.Text:= sHeroName1;
    EditHero1Name.Text:= m_ChrRcd.Data.sHeroChrName1;//20110130 副将名
    Label5.Caption := '师徒名称:';
  end else begin
    Label5.Caption := '主人名称:';
    CheckBoxIsMaster.Enabled := False;
    EditHeroName.Enabled := False;
    EditDearName.Enabled := False;
    EditPassword.Enabled := False;
    EditHero1Name.Visible:= False;
    Label43.Visible:= False;
  end;
  EditCurMap.Text := m_ChrRcd.Data.sCurMap;
  EditCurX.Value := m_ChrRcd.Data.wCurX;
  EditCurY.Value := m_ChrRcd.Data.wCurY;

  EditHomeMap.Text := m_ChrRcd.Data.sHomeMap;
  EditHomeX.Value := m_ChrRcd.Data.wHomeX;
  EditHomeY.Value := m_ChrRcd.Data.wHomeY;

  SpinEditNGLevel.Value := {m_ChrRcd.Data.UnKnow[7]}MakeWord(m_ChrRcd.Data.UnKnow[7],m_ChrRcd.Data.UnKnow[33]);
  EditLevel.Value := m_ChrRcd.Data.Abil.Level;
  EditGold.Value := m_ChrRcd.Data.nGold;
  EditGameGold.Value := m_ChrRcd.Data.nGameGold;
  EditGamePoint.Value := m_ChrRcd.Data.nGamePoint;
  EditPayPoint.Value := m_ChrRcd.Data.nPayMentPoint;
  EditCreditPoint.Value := m_ChrRcd.Data.btCreditPoint;
  EditPKPoint.Value := m_ChrRcd.Data.nPKPoint;
  EditContribution.Value := m_ChrRcd.Data.wContribution;
  EditGameDiaMond.Value := m_ChrRcd.Data.nGameDiaMond; //20071226  金刚石
  EditGameGird.Value := m_ChrRcd.Data.nGameGird;  //20071226  灵符
  EditHeroLoyal.Enabled :=m_ChrRcd.Data.boIsHero ; //20080118 是英雄才能调整忠诚度
  EditHeroLoyal.Value := m_ChrRcd.Data.nLoyal;//英雄的忠诚度(20080109)

  EditExpRate.Value := m_ChrRcd.Data.nExpRate;
  EditExpTime.Value := m_ChrRcd.Data.nExpTime;
  EditBonusPoint.Value := m_ChrRcd.Data.nBonusPoint;

  EditDC.Value := m_ChrRcd.Data.BonusAbil.DC;
  EditMC.Value := m_ChrRcd.Data.BonusAbil.MC;
  EditSC.Value := m_ChrRcd.Data.BonusAbil.SC;
  EditAC.Value := m_ChrRcd.Data.BonusAbil.AC;
  EditMAC.Value := m_ChrRcd.Data.BonusAbil.MAC;
  EditHP.Value := m_ChrRcd.Data.BonusAbil.HP;
  EditMP.Value := m_ChrRcd.Data.BonusAbil.MP;
  EditHit.Value := m_ChrRcd.Data.BonusAbil.Hit;
  EditSpeed.Value := m_ChrRcd.Data.BonusAbil.Speed;
  EditX2.Value := m_ChrRcd.Data.BonusAbil.X2;

  EditPulseAddAC.Value := m_ChrRcd.Data.UnKnow[17];
  EditPulseAddAC1.Value := m_ChrRcd.Data.UnKnow[18];
  EditPulseAddMAC.Value := m_ChrRcd.Data.UnKnow[19];
  EditPulseAddMAC1.Value := m_ChrRcd.Data.UnKnow[20];
  EditDecDamage.Value := m_ChrRcd.Data.m_nReserved1;//吸伤属性
end;

procedure TfrmEditRcd.Open;
begin
  RefShow();
  Caption := format('编辑人物数据 [%s]', [m_ChrRcd.Data.sChrName]);
  PageControl.ActivePageIndex := 0;
  ShowModal;
end;

procedure TfrmEditRcd.RefShow;
begin
  m_boOpened := False;
  RefShowRcd();
  RefShowMagic();
  RefShowUserItem();
  RefShowStorage();
  m_boOpened := True;
end;

procedure TfrmEditRcd.RefShowMagic;
var
  i, K: Integer;
  ListItem: TListItem;
  MagicInfo: THumMagic;
  NGMagicInfo: THumNGMagic;
begin
  ListViewMagic.Clear;
  if m_ChrRcd.Data.boIsHero then K:=1;
  for i := Low(m_ChrRcd.Data.HumMagics) to High(m_ChrRcd.Data.HumMagics) do begin
    MagicInfo := m_ChrRcd.Data.HumMagics[i];
    if MagicInfo.wMagIdx = 0 then break;
    ListItem := ListViewMagic.Items.Add;
    ListItem.Caption := IntToStr(i);
    ListItem.SubItems.Add(IntToStr(MagicInfo.wMagIdx));
    ListItem.SubItems.Add(GetMagicName(MagicInfo.wMagIdx, K));
    ListItem.SubItems.Add(IntToStr(MagicInfo.btLevel));
    ListItem.SubItems.Add(IntToStr(MagicInfo.nTranPoint));
    ListItem.SubItems.Add(IntToStr(MagicInfo.btKey));
  end;
  for i := Low(m_ChrRcd.Data.HumNGMagics) to High(m_ChrRcd.Data.HumNGMagics) do begin//内功技能 20081003
    NGMagicInfo := m_ChrRcd.Data.HumNGMagics[i];
    if NGMagicInfo.wMagIdx = 0 then break;
    ListItem := ListViewMagic.Items.Add;
    ListItem.Caption := IntToStr(i);
    ListItem.SubItems.Add(IntToStr(NGMagicInfo.wMagIdx));
    ListItem.SubItems.Add(GetMagicName(NGMagicInfo.wMagIdx, 2));
    ListItem.SubItems.Add(IntToStr(NGMagicInfo.btLevel));
    ListItem.SubItems.Add(IntToStr(NGMagicInfo.nTranPoint));
    ListItem.SubItems.Add(IntToStr(NGMagicInfo.btKey));
  end;
end;

procedure TfrmEditRcd.RefShowUserItem;
var
  i: Integer;
  ListItem: TListItem;
  UserItem: TUserItem;
resourcestring
  sItemValue = '%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d-%d';
  //'%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d'
begin
  ListViewUserItem.Clear;

  for i := Low(m_ChrRcd.Data.HumItems) to High(m_ChrRcd.Data.HumItems) do begin
    UserItem := m_ChrRcd.Data.HumItems[i];
    ListItem := ListViewUserItem.Items.Add;
    ListItem.Caption := IntToStr(i);
    ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
    ListItem.SubItems.Add(IntToStr(UserItem.wIndex));
    ListItem.SubItems.Add(GetStdItemName(UserItem.wIndex)); ;
    ListItem.SubItems.Add(format('%d/%d', [UserItem.Dura, UserItem.DuraMax]));

    ListItem.SubItems.Add(format(sItemValue, [
      UserItem.btValue[0],
        UserItem.btValue[1],
        UserItem.btValue[2],
        UserItem.btValue[3],
        UserItem.btValue[4],
        UserItem.btValue[5],
        UserItem.btValue[6],
        UserItem.btValue[7],
        UserItem.btValue[8],
        UserItem.btValue[9],
        UserItem.btValue[10],
        UserItem.btValue[11],
        UserItem.btValue[12],
        UserItem.btValue[13]
        ]));

  end;

  for i := Low(m_ChrRcd.Data.HumAddItems) to High(m_ChrRcd.Data.HumAddItems) do begin
    UserItem := m_ChrRcd.Data.HumAddItems[i];
    ListItem := ListViewUserItem.Items.Add;
    ListItem.Caption := IntToStr(i);
    ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
    ListItem.SubItems.Add(IntToStr(UserItem.wIndex));
    ListItem.SubItems.Add(GetStdItemName(UserItem.wIndex)); ;
    ListItem.SubItems.Add(format('%d/%d', [UserItem.Dura, UserItem.DuraMax]));
    ListItem.SubItems.Add(format(sItemValue, [
      UserItem.btValue[0],
        UserItem.btValue[1],
        UserItem.btValue[2],
        UserItem.btValue[3],
        UserItem.btValue[4],
        UserItem.btValue[5],
        UserItem.btValue[6],
        UserItem.btValue[7],
        UserItem.btValue[8],
        UserItem.btValue[9],
        UserItem.btValue[10],
        UserItem.btValue[11],
        UserItem.btValue[12],
        UserItem.btValue[13]
        ]));
  end;
end;

procedure TfrmEditRcd.RefShowStorage;
var
  i: Integer;
  ListItem: TListItem;
  UserItem: TUserItem;
begin
  ListViewStorage.Clear;

  for i := Low(m_ChrRcd.Data.StorageItems) to High(m_ChrRcd.Data.StorageItems) do begin
    UserItem := m_ChrRcd.Data.StorageItems[i];
    if UserItem.wIndex = 0 then Continue;
    ListItem := ListViewStorage.Items.Add;
    ListItem.Caption := IntToStr(i);
    ListItem.SubItems.Add(IntToStr(UserItem.MakeIndex));
    ListItem.SubItems.Add(IntToStr(UserItem.wIndex));
    ListItem.SubItems.Add(GetStdItemName(UserItem.wIndex)); ;
    ListItem.SubItems.Add(format('%d/%d', [UserItem.Dura, UserItem.DuraMax]));
    ListItem.SubItems.Add(format('%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d/%d', [
        UserItem.btValue[0],
        UserItem.btValue[1],
        UserItem.btValue[2],
        UserItem.btValue[3],
        UserItem.btValue[4],
        UserItem.btValue[5],
        UserItem.btValue[6],
        UserItem.btValue[7],
        UserItem.btValue[8],
        UserItem.btValue[9],
        UserItem.btValue[10],
        UserItem.btValue[11],
        UserItem.btValue[12],
        UserItem.btValue[13]
        ]));

  end;
end;

procedure TfrmEditRcd.ButtonExportDataClick(Sender: TObject);
begin
  if Sender = ButtonExportData then begin
    ProcessSaveRcdToFile();
  end else
    if Sender = ButtonImportData then begin
    ProcessLoadRcdformFile();
  end else
    if Sender = ButtonSaveData then begin
    ProcessSaveRcd();
  end;  
end;
//导出人物数据文件
procedure TfrmEditRcd.ProcessSaveRcdToFile;
var
  sSaveFileName: string;
  nFileHandle: Integer;
begin
  SaveDialog.FileName := m_ChrRcd.Data.sChrName;
  SaveDialog.InitialDir := '.\';
  if not SaveDialog.Execute then Exit;
  sSaveFileName := SaveDialog.FileName;
  if FileExists(sSaveFileName) then
    nFileHandle := FileOpen(sSaveFileName, fmOpenReadWrite or fmShareDenyNone)
  else nFileHandle := FileCreate(sSaveFileName);
  if nFileHandle <= 0 then begin
    MessageBox(Handle, '保存文件出现错误！！！', '错误信息', MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;
  FileWrite(nFileHandle, m_ChrRcd, SizeOf(THumDataInfo));
  FileClose(nFileHandle);
  MessageBox(Handle, '人物数据导出成功！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;
//导入人物数据文件
procedure TfrmEditRcd.ProcessLoadRcdformFile;
var
  sLoadFileName: string;
  nFileHandle: Integer;
  ChrRcd: THumDataInfo;
begin
  OpenDialog.FileName := m_ChrRcd.Data.sChrName;
  OpenDialog.InitialDir := '.\';
  if not OpenDialog.Execute then Exit;
  sLoadFileName := OpenDialog.FileName;

  if not FileExists(sLoadFileName) then begin
    MessageBox(Handle, '指定的文件未找到！！！', '错误信息', MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;
  nFileHandle := FileOpen(sLoadFileName, fmOpenReadWrite or fmShareDenyNone);

  if nFileHandle <= 0 then begin
    MessageBox(Handle, '打开文件出现错误！！！', '错误信息', MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;
  if not FileRead(nFileHandle, ChrRcd, SizeOf(THumDataInfo)) = SizeOf(THumDataInfo) then begin
    MessageBox(Handle, '读取文件出现错误！！！'#13#13'文件格式可能不正确', '错误信息', MB_OK + MB_ICONEXCLAMATION);
    Exit;
  end;
  ChrRcd.Header := m_ChrRcd.Header;
  ChrRcd.Data.sChrName := m_ChrRcd.Data.sChrName;
  if CompareText(ChrRcd.Data.sAccount , m_ChrRcd.Data.sAccount) <> 0 then begin//20081220 导入时,检查登陆账号是否一致
    if Application.MessageBox(Pchar('导入的数据与原数据登录账号不一致,是否需要继续导入?'),
                        '提示信息',MB_ICONQUESTION+MB_YESNO)=IDYES then
    Begin

    End Else begin
      FileClose(nFileHandle);
      Exit;
    end;
  end else ChrRcd.Data.sAccount := m_ChrRcd.Data.sAccount;
  m_ChrRcd := ChrRcd;
  FileClose(nFileHandle);
  RefShow();
  MessageBox(Handle, '人物数据导入成功！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
end;

function UpdateHeroMirToName(sHeroName{英雄名},sNewHeroName: string): Boolean;
var
  ChrList: TStringList;
  nIndex, I: Integer;
  HumanRCD: TNewHeroDataInfo;
begin
  Result := False;
  try
    if HeroDataDB.Open then begin
      ChrList := TStringList.Create;
      try
        if HeroDataDB.Find(sHeroName, ChrList) >= 0 then begin
          for I := 0 to ChrList.Count - 1 do begin
            nIndex := Integer(ChrList.Objects[i]);
            if {$IF DBSMode = 1}HeroDataDB.Get(nIndex, @HumanRCD) <> -1{$ELSE}HeroDataDB.Get(nIndex, HumanRCD) <> -1{$IFEND} then begin
              HumanRCD.Data.sHeroChrName:= sNewHeroName;
              {$IF DBSMode = 1}
              HeroDataDB.Update(nIndex, @HumanRCD);
              {$ELSE}
              HeroDataDB.Update(nIndex, HumanRCD);
              {$IFEND}
              Result := True;
            end;
          end;
        end;
      finally
        ChrList.Free;
      end;
    end;
  finally
    HeroDataDB.Close;
  end;
end;


procedure TfrmEditRcd.ProcessSaveRcd;
var
  nIdx : Integer;
  boSaveOK: Boolean;
  HumRecord: THumInfo;
  //HeroNameInfo: THeroNameInfo;
  sOleHeroName: string;
begin
  boSaveOK := False;
  try
    if HumDataDB.Open then begin
      if CheckBoxModeName.Checked then begin//20090406 修改名字
        nIdx := StrToInt(EditIdx.Text);
        if (not (HumDataDB.Index(EditChrName.text) > -1)) and (nIdx >= 0) and (HumIndex >= 0) then begin//检查名字是否重复
          try
            if HumChrDB.Open then begin
              if HumChrDB.GetBy(HumIndex, HumRecord) then begin
                HumRecord.sChrName:= EditChrName.text;
                HumRecord.Header.sName:= EditChrName.text;
                {$IF DBSMode = 1}
                HumChrDB.Update(HumIndex, HumRecord);
                {$ELSE}
                HumChrDB.UpdateBy(HumIndex, HumRecord);
                {$IFEND}
                if m_ChrRcd.Data.boIsHero and (m_ChrRcd.Data.btHeroType = 3) then//如果修改的是副将英雄，则更新HeroMir.db
                  UpdateHeroMirToName(m_ChrRcd.Data.sChrName, EditChrName.text);//20100924 增加

                m_ChrRcd.Header.sName:= EditChrName.text;
                m_ChrRcd.Data.sChrName:= EditChrName.text;
                {$IF DBSMode = 1}
                if (not m_ChrRcd.Data.boIsHero) and (sHeroName1 <> '') then m_ChrRcd.Header.sName:= sHeroName1;
                HumDataDB.Update(nIdx, @m_ChrRcd, 5);
                {$ELSE}
                HumDataDB.Update(nIdx, m_ChrRcd);
                {$IFEND}
                boSaveOK := True;
              end;
            end;
          finally
            HumChrDB.Close;
          end;
        end;
      end else begin
        nIdx := HumDataDB.Index(m_ChrRcd.Header.sName);
        if (nIdx >= 0) then begin
          {$IF DBSMode = 1}
          HumDataDB.Update(nIdx, @m_ChrRcd, 5);
          {$ELSE}
          HumDataDB.Update(nIdx, m_ChrRcd);
          {$IFEND}
          boSaveOK := True;
        end;
      end;
    end;
   (* {$IF DBSMode = 0}
    if (not m_ChrRcd.Data.boIsHero) and (sHeroName1 <> '') then begin
      try//主体英雄各数据
        if HumHeroDB.Open then begin
          nIdx := HumHeroDB.Index(m_ChrRcd.Header.sName);
          if nIdx >= 0 then begin
            if HumHeroDB.Get(nIdx, HeroNameInfo) >= 0 then begin
              HeroNameInfo.Header.boDeleted:= False;
              sOleHeroName:= HeroNameInfo.Data.sNewHeroName;
              HeroNameInfo.Data.sNewHeroName:= sHeroName1;//副将名
              HumHeroDB.Update(nIdx, HeroNameInfo);
              UpdateHeroMirToName(sOleHeroName, sHeroName1);//20100922 增加
            end;
          end else begin
            HeroNameInfo.Header.boDeleted:= False;
            HeroNameInfo.Header.dCreateDate:= Now();
            HeroNameInfo.Data.sChrName:= m_ChrRcd.Header.sName;//主体名
            HeroNameInfo.Data.sNewHeroName:= sHeroName1;//副将名
            HumHeroDB.Add(HeroNameInfo);
          end;
        end;
      finally
        HumHeroDB.Close;
      end;
    end;
    {$IFEND}  *)
  finally
    HumDataDB.Close;
  end;
  if boSaveOK then begin
    MessageBox(Handle, '人物数据保存成功！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
  end else begin
    if CheckBoxModeName.Checked then begin
      MessageBox(Handle, '人物数据保存失败！！！名字重复或查找不到记录', '错误信息', MB_OK + MB_ICONEXCLAMATION);
    end else begin
      MessageBox(Handle, '人物数据保存失败！！！', '错误信息', MB_OK + MB_ICONEXCLAMATION);
    end;
  end;
end;

procedure TfrmEditRcd.EditPasswordChange(Sender: TObject);
begin
  if not m_boOpened then Exit;
  if Sender = EditAccount then begin//20081220 修改账号
    if CheckBoxModeAccount.Checked then begin
      m_ChrRcd.Data.sAccount:= Trim(EditAccount.Text);
    end;
  end else
  if Sender = EditPassword then begin
    m_ChrRcd.Data.sStoragePwd := Trim(EditPassword.Text);
  end else
    if Sender = EditDearName then begin
    m_ChrRcd.Data.sDearName := Trim(EditDearName.Text);
  end else
    if Sender = EditMasterName then begin
    m_ChrRcd.Data.sMasterName := Trim(EditMasterName.Text);
  end else
    if Sender = CheckBoxIsMaster then begin
    m_ChrRcd.Data.boMaster := CheckBoxIsMaster.Checked;
  end else
    if Sender = EditCurMap then begin
    m_ChrRcd.Data.sCurMap := Trim(EditCurMap.Text);
  end else
    if Sender = EditCurX then begin
    m_ChrRcd.Data.wCurX := EditCurX.Value;
  end else
    if Sender = EditCurY then begin
    m_ChrRcd.Data.wCurY := EditCurY.Value;
  end else
    if Sender = EditHomeMap then begin
    m_ChrRcd.Data.sHomeMap := Trim(EditHomeMap.Text);
  end else
    if Sender = EditHomeX then begin
    m_ChrRcd.Data.wHomeX := EditHomeX.Value;
  end else
    if Sender = EditCurY then begin
    m_ChrRcd.Data.wHomeY := EditHomeY.Value;
  end else                                                
    if Sender = SpinEditNGLevel then begin
    //m_ChrRcd.Data.UnKnow[7] := SpinEditNGLevel.Value;
    m_ChrRcd.Data.UnKnow[7] := LoByte(SpinEditNGLevel.Value);//内功等级 20110130
    m_ChrRcd.Data.UnKnow[33] := HiByte(SpinEditNGLevel.Value);//内功等 20110130
  end else
    if Sender = EditLevel then begin
    m_ChrRcd.Data.Abil.Level := EditLevel.Value;
  end else
    if Sender = EditGold then begin
    m_ChrRcd.Data.nGold := EditGold.Value;
  end else
    if Sender = EditGameGold then begin
    m_ChrRcd.Data.nGameGold := EditGameGold.Value;
  end else
    if Sender = EditGamePoint then begin
    m_ChrRcd.Data.nGamePoint := EditGamePoint.Value;
  end else
    if Sender = EditPayPoint then begin
    m_ChrRcd.Data.nPayMentPoint := EditPayPoint.Value;
  end else
    if Sender = EditCreditPoint then begin
    m_ChrRcd.Data.btCreditPoint := EditCreditPoint.Value;
  end else
    if Sender = EditPKPoint then begin
    m_ChrRcd.Data.nPKPoint := EditPKPoint.Value;
  end else
    if Sender = EditContribution then begin
    m_ChrRcd.Data.wContribution := EditContribution.Value;
  end else
    if Sender = EditExpRate then begin
    m_ChrRcd.Data.nExpRate := EditExpRate.Value;
  end else
    if Sender = EditExpTime then begin
    m_ChrRcd.Data.nExpTime := EditExpTime.Value;
  end else
    if Sender = EditBonusPoint then begin
    m_ChrRcd.Data.nBonusPoint := EditBonusPoint.Value;
  end else
    if Sender = EditGameDiaMond then begin
    m_ChrRcd.Data.nGameDiaMond := EditGameDiaMond.Value;
  end else
    if Sender = EditGameGird then begin
    m_ChrRcd.Data.nGameGird  := EditGameGird .Value;
  end else
    if Sender = EditHeroLoyal then begin
    m_ChrRcd.Data.nLoyal := EditHeroLoyal.Value;//忠诚度 20080109
  end else
    if Sender = EditPulseAddAC then begin
    m_ChrRcd.Data.UnKnow[17] := EditPulseAddAC.Value;
  end else
    if Sender = EditPulseAddAC1 then begin
    m_ChrRcd.Data.UnKnow[18] := EditPulseAddAC1.Value;
  end else
    if Sender = EditPulseAddMAC then begin
    m_ChrRcd.Data.UnKnow[19] := EditPulseAddMAC.Value;
  end else
    if Sender = EditPulseAddMAC1 then begin
    m_ChrRcd.Data.UnKnow[20] := EditPulseAddMAC1.Value;
  end else
    if Sender = EditDecDamage then begin
    m_ChrRcd.Data.m_nReserved1 := EditDecDamage.Value;//吸伤属性
  end else
    if Sender = EditHeroName then begin
    m_ChrRcd.Data.sHeroChrName := EditHeroName.Text;
  end else
  if Sender = EditHero1Name then begin
    //sHeroName1 := EditHero1Name.Text;
    m_ChrRcd.Data.sHeroChrName1:= EditHero1Name.Text;//20110130
  end else
    if Sender = CheckHero then begin
      if not m_ChrRcd.Data.boIsHero then begin
        m_ChrRcd.Data.boHasHero:= CheckHero.Checked;
      end;
  end else
    if Sender = CheckHeroTwo then begin
      if not m_ChrRcd.Data.boIsHero then begin
        m_ChrRcd.Data.boReserved1 := CheckHeroTwo.Checked ;
      end;
  end;
end;

procedure TfrmEditRcd.CheckBoxModeAccountClick(Sender: TObject);
begin
  if CheckBoxModeAccount.Checked then begin
    EditAccount.ReadOnly:= False;
    EditAccount.Color:= clWindow;
  end else begin
    EditAccount.ReadOnly:= True;
    EditAccount.Color:= cl3DLight;
  end;
end;

procedure TfrmEditRcd.CheckBoxModeNameClick(Sender: TObject);
begin
  if CheckBoxModeName.Checked then begin
    EditChrName.ReadOnly:= False;
    EditChrName.Color:= clWindow;
  end else begin
    EditChrName.ReadOnly:= True;
    EditChrName.Color:= cl3DLight;
  end;
end;

end.
