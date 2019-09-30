unit CastleManage;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ComCtrls, StdCtrls, Spin, Guild, Castle;

type
  TfrmCastleManage = class(TForm)
    GroupBox1: TGroupBox;
    ListViewCastle: TListView;
    GroupBox2: TGroupBox;
    PageControlCastle: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    EditOwenGuildName: TEdit;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditCastleName: TEdit;
    EditCastleOfGuild: TEdit;
    EditHomeMap: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    EditTotalGold: TSpinEdit;
    EditTodayIncome: TSpinEdit;
    Label7: TLabel;
    EditTechLevel: TSpinEdit;
    Label8: TLabel;
    EditPower: TSpinEdit;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    ListViewGuard: TListView;
    ButtonRefresh: TButton;
    TabSheet4: TTabSheet;
    GroupBox6: TGroupBox;
    ListViewAttackSabukWall: TListView;
    ButtonAttackAd: TButton;
    ButtonAttackEdit: TButton;
    ButtonAttackDel: TButton;
    ButtonAttackR: TButton;
    Label9: TLabel;
    Label10: TLabel;
    EditTunnelMap: TEdit;
    Label11: TLabel;
    EditPalace: TEdit;
    SpinEditNomeX: TSpinEdit;
    SpinEditNomeY: TSpinEdit;
    ButtonSave: TButton;
    Button1: TButton;
    Button2: TButton;
    Label12: TLabel;
    EditHomeMap1: TEdit;
    Label13: TLabel;
    SpinEditNomeX1: TSpinEdit;
    SpinEditNomeY1: TSpinEdit;
    procedure ListViewCastleClick(Sender: TObject);
    procedure ButtonRefreshClick(Sender: TObject);
    procedure ButtonAttackAdClick(Sender: TObject);
    procedure ButtonAttackEditClick(Sender: TObject);
    procedure ListViewAttackSabukWallClick(Sender: TObject);
    procedure ButtonAttackRClick(Sender: TObject);
    procedure ButtonAttackDelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EditOwenGuildNameClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    procedure RefCastleList;
    procedure RefCastleInfo;
    procedure RefCastleAttackSabukWall;
    { Private declarations }
  public
    procedure Open();
    function InListOfGuildName(sGuildName: string): TGUild;
    function AddAttackSabukWallOfGuild(sGuildName: string; AttackSabukWall: TDate): Boolean;
    function ChgAttackSabukWallOfGuild(sGuildName: string; AttackSabukWall: TDate): Boolean;
    function IsAttackSabukWallOfGuild(sGuildName: string; AttackDate: TDate): Boolean;
    { Public declarations }
  end;

var
  frmCastleManage: TfrmCastleManage;
  nCount: Integer;
  CurCastle: TUserCastle;
implementation

uses AttackSabukWallConfig, M2Share, Grobal2;

{$R *.dfm}
var
  boRefing: Boolean;
  SelAttackGuildInfo: pTAttackerInfo;
  { TfrmCastleManage }

procedure TfrmCastleManage.Open;
begin
  nCount := 0;
  ButtonSave.Enabled := True;
  SelAttackGuildInfo := nil;
  RefCastleList();
  ShowModal;
end;

procedure TfrmCastleManage.RefCastleInfo;
var
  I, II: Integer;
  ListItem: TListItem;
  ObjUnit: pTObjUnit;
begin
  if CurCastle = nil then Exit;
  boRefing := True;
  if CurCastle.m_MasterGuild = nil then EditOwenGuildName.Text := ''
  else EditOwenGuildName.Text := CurCastle.m_MasterGuild.sGuildName;
  EditTotalGold.Value := CurCastle.m_nTotalGold;
  EditTodayIncome.Value := CurCastle.m_nTodayIncome;
  EditTechLevel.Value := CurCastle.m_nTechLevel;
  EditPower.Value := CurCastle.m_nPower;
  ListViewGuard.Clear;
  ListItem := ListViewGuard.Items.Add;
  ListItem.Caption := '0';
  if CurCastle.m_MainDoor.BaseObject <> nil then begin
    ListItem.SubItems.Add(CurCastle.m_MainDoor.BaseObject.m_sCharName);
    ListItem.SubItems.Add(Format('%d:%d', [CurCastle.m_MainDoor.BaseObject.m_nCurrX, CurCastle.m_MainDoor.BaseObject.m_nCurrY]));
    ListItem.SubItems.Add(Format('%d/%d', [CurCastle.m_MainDoor.BaseObject.m_WAbil.HP, CurCastle.m_MainDoor.BaseObject.m_WAbil.MaxHP]));
    if CurCastle.m_MainDoor.BaseObject.m_boDeath then begin
      ListItem.SubItems.Add('损坏');
    end else begin
      if (CurCastle.m_DoorStatus <> nil) then begin
        if CurCastle.m_DoorStatus.boOpened then begin
          ListItem.SubItems.Add('开启');
        end else begin
          ListItem.SubItems.Add('关闭');
        end;
      end;  
    end;
    ListItem.SubItems.Add(CurCastle.m_MainDoor.BaseObject.m_PEnvir.sMapName);//20090403 增加，地图名
  end else begin
    ListItem.SubItems.Add(CurCastle.m_MainDoor.sName);
    ListItem.SubItems.Add(Format('%d:%d', [CurCastle.m_MainDoor.nX, CurCastle.m_MainDoor.nY]));
    ListItem.SubItems.Add(Format('%d/%d', [0, 0]));
    ListItem.SubItems.Add(' ');
    ListItem.SubItems.Add(' ');
  end;

  ListItem := ListViewGuard.Items.Add;
  ListItem.Caption := '1';
  if CurCastle.m_LeftWall.BaseObject <> nil then begin
    ListItem.SubItems.Add(CurCastle.m_LeftWall.BaseObject.m_sCharName);
    ListItem.SubItems.Add(Format('%d:%d', [CurCastle.m_LeftWall.BaseObject.m_nCurrX, CurCastle.m_LeftWall.BaseObject.m_nCurrY]));
    ListItem.SubItems.Add(Format('%d/%d', [CurCastle.m_LeftWall.BaseObject.m_WAbil.HP, CurCastle.m_LeftWall.BaseObject.m_WAbil.MaxHP]));
    if CurCastle.m_LeftWall.BaseObject.m_boDeath then begin
      ListItem.SubItems.Add('损坏');
    end else ListItem.SubItems.Add(' ');
    ListItem.SubItems.Add(CurCastle.m_LeftWall.BaseObject.m_PEnvir.sMapName);//20090403 增加，地图名
  end else begin
    ListItem.SubItems.Add(CurCastle.m_LeftWall.sName);
    ListItem.SubItems.Add(Format('%d:%d', [CurCastle.m_LeftWall.nX, CurCastle.m_LeftWall.nY]));
    ListItem.SubItems.Add(Format('%d/%d', [0, 0]));
    ListItem.SubItems.Add(' ');
    ListItem.SubItems.Add(' ');
  end;

  ListItem := ListViewGuard.Items.Add;
  ListItem.Caption := '2';
  if CurCastle.m_CenterWall.BaseObject <> nil then begin
    ListItem.SubItems.Add(CurCastle.m_CenterWall.BaseObject.m_sCharName);
    ListItem.SubItems.Add(Format('%d:%d', [CurCastle.m_CenterWall.BaseObject.m_nCurrX, CurCastle.m_CenterWall.BaseObject.m_nCurrY]));
    ListItem.SubItems.Add(Format('%d/%d', [CurCastle.m_CenterWall.BaseObject.m_WAbil.HP, CurCastle.m_CenterWall.BaseObject.m_WAbil.MaxHP]));
    if CurCastle.m_CenterWall.BaseObject.m_boDeath then begin
      ListItem.SubItems.Add('损坏');
    end else ListItem.SubItems.Add(' ');
    ListItem.SubItems.Add(CurCastle.m_CenterWall.BaseObject.m_PEnvir.sMapName);//20090403 增加，地图名
  end else begin
    ListItem.SubItems.Add(CurCastle.m_CenterWall.sName);
    ListItem.SubItems.Add(Format('%d:%d', [CurCastle.m_CenterWall.nX, CurCastle.m_CenterWall.nY]));
    ListItem.SubItems.Add(Format('%d/%d', [0, 0]));
    ListItem.SubItems.Add(' ');
    ListItem.SubItems.Add(' ');
  end;

  ListItem := ListViewGuard.Items.Add;
  ListItem.Caption := '3';
  if CurCastle.m_RightWall.BaseObject <> nil then begin
    ListItem.SubItems.Add(CurCastle.m_RightWall.BaseObject.m_sCharName);
    ListItem.SubItems.Add(Format('%d:%d', [CurCastle.m_RightWall.BaseObject.m_nCurrX, CurCastle.m_RightWall.BaseObject.m_nCurrY]));
    ListItem.SubItems.Add(Format('%d/%d', [CurCastle.m_RightWall.BaseObject.m_WAbil.HP, CurCastle.m_RightWall.BaseObject.m_WAbil.MaxHP]));
    if CurCastle.m_RightWall.BaseObject.m_boDeath then begin
      ListItem.SubItems.Add('损坏');
    end else ListItem.SubItems.Add(' ');
    ListItem.SubItems.Add(CurCastle.m_RightWall.BaseObject.m_PEnvir.sMapName);//20090403 增加，地图名
  end else begin
    ListItem.SubItems.Add(CurCastle.m_RightWall.sName);
    ListItem.SubItems.Add(Format('%d:%d', [CurCastle.m_RightWall.nX, CurCastle.m_RightWall.nY]));
    ListItem.SubItems.Add(Format('%d/%d', [0, 0]));
    ListItem.SubItems.Add(' ');
    ListItem.SubItems.Add(' ');    
  end;
  for I := Low(CurCastle.m_Archer) to High(CurCastle.m_Archer) do begin
    ObjUnit := @CurCastle.m_Archer[I];
    ListItem := ListViewGuard.Items.Add;
    ListItem.Caption := IntToStr(I + 4);
    if ObjUnit.BaseObject <> nil then begin
      ListItem.SubItems.Add(ObjUnit.BaseObject.m_sCharName);
      ListItem.SubItems.Add(Format('%d:%d', [ObjUnit.BaseObject.m_nCurrX, ObjUnit.BaseObject.m_nCurrY]));
      ListItem.SubItems.Add(Format('%d/%d', [ObjUnit.BaseObject.m_WAbil.HP, ObjUnit.BaseObject.m_WAbil.MaxHP]));
    end else begin
      ListItem.SubItems.Add(ObjUnit.sName);
      ListItem.SubItems.Add(Format('%d:%d', [ObjUnit.nX, ObjUnit.nY]));
      ListItem.SubItems.Add(Format('%d/%d', [0, 0]));
    end;
  end;
  I:= 9 + High(CurCastle.m_Archer);
  for II := Low(CurCastle.m_Guard) to High(CurCastle.m_Guard) do begin
    ObjUnit := @CurCastle.m_Guard[II];
    ListItem := ListViewGuard.Items.Add;
    ListItem.Caption := IntToStr(II + I);
    if ObjUnit.BaseObject <> nil then begin
      ListItem.SubItems.Add(ObjUnit.BaseObject.m_sCharName);
      ListItem.SubItems.Add(Format('%d:%d', [ObjUnit.BaseObject.m_nCurrX, ObjUnit.BaseObject.m_nCurrY]));
      ListItem.SubItems.Add(Format('%d/%d', [ObjUnit.BaseObject.m_WAbil.HP, ObjUnit.BaseObject.m_WAbil.MaxHP]));
    end else begin
      ListItem.SubItems.Add(ObjUnit.sName);
      ListItem.SubItems.Add(Format('%d:%d', [ObjUnit.nX, ObjUnit.nY]));
      ListItem.SubItems.Add(Format('%d/%d', [0, 0]));
    end;
  end;
  EditCastleName.Text := CurCastle.m_sName;
  if CurCastle.m_MasterGuild <> nil then
    EditCastleOfGuild.Text := CurCastle.m_MasterGuild.sGuildName
  else EditCastleOfGuild.Text := '';
  EditPalace.Text := CurCastle.m_sPalaceMap;
  EditHomeMap.Text := CurCastle.m_sHomeMap;
  SpinEditNomeX.Value := CurCastle.m_nHomeX;
  SpinEditNomeY.Value := CurCastle.m_nHomeY;
  EditTunnelMap.Text := CurCastle.m_sSecretMap;
  EditHomeMap1.Text := CurCastle.m_sWarAreaHomeMap;//攻方行会回城点地图 20090527
  SpinEditNomeX1.Value := CurCastle.m_nWarAreaHomeX; //攻方行会回城点X 20090527
  SpinEditNomeY1.Value := CurCastle.m_nWarAreaHomeY; //攻方行会回城点Y 20090527
  RefCastleAttackSabukWall;
  boRefing := False;
end;

procedure TfrmCastleManage.RefCastleList;
var
  I: Integer;
  UserCastle: TUserCastle;
  ListItem: TListItem;
begin
  g_CastleManager.Lock;
  try
    if g_CastleManager.m_CastleList.Count > 0 then begin//20080630
      for I := 0 to g_CastleManager.m_CastleList.Count - 1 do begin
        UserCastle := TUserCastle(g_CastleManager.m_CastleList.Items[I]);
        ListItem := ListViewCastle.Items.Add;
        ListItem.Caption := IntToStr(I);
        ListItem.SubItems.AddObject(UserCastle.m_sConfigDir, UserCastle);
        ListItem.SubItems.Add(UserCastle.m_sName)
      end;
    end;
  finally
    g_CastleManager.UnLock;
  end;
end;

procedure TfrmCastleManage.RefCastleAttackSabukWall;
var
  I: Integer;
  ListItem: TListItem;
  AttackerInfo: pTAttackerInfo;
begin
  nCount := 0;
  ListViewAttackSabukWall.Items.Clear;
  ListViewAttackSabukWall.Items.BeginUpdate;
  try
    if CurCastle.m_AttackWarList.Count > 0 then begin//20080630
      for I := 0 to CurCastle.m_AttackWarList.Count - 1 do begin
        AttackerInfo := pTAttackerInfo(CurCastle.m_AttackWarList.Items[I]);
        ListItem := ListViewAttackSabukWall.Items.Add;
        if AttackerInfo <> nil then begin
          ListItem.Caption := IntToStr(nCount);
          ListItem.SubItems.AddObject(AttackerInfo.sGuildName, TObject(AttackerInfo));
          ListItem.SubItems.Add(DateToStr(AttackerInfo.AttackDate));
          Inc(nCount);
        end;
      end;
    end;
  finally
    ListViewAttackSabukWall.Items.EndUpdate;
  end;
end;

procedure TfrmCastleManage.ListViewCastleClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewCastle.Selected;
  if ListItem = nil then Exit;
  CurCastle := TUserCastle(ListItem.SubItems.Objects[0]);
  RefCastleInfo();
  if CurCastle <> nil then begin
    if CurCastle.m_boUnderWar then Button2.Caption:='关闭攻城'
    else  Button2.Caption:='开始攻城';
    Button2.Enabled:= True;
  end;
end;

procedure TfrmCastleManage.ButtonRefreshClick(Sender: TObject);
begin
  RefCastleInfo();
end;

function TfrmCastleManage.InListOfGuildName(sGuildName: string): TGUild;
var
  I: Integer;
  Guild: TGUild;
begin
  Result := nil;
  if g_GuildManager.GuildList.Count > 0 then begin//20080630
    for I := 0 to g_GuildManager.GuildList.Count - 1 do begin
      Guild := TGUild(g_GuildManager.GuildList.Items[I]);
      if Guild <> nil then begin
        if CompareText(sGuildName, Guild.sGuildName) = 0 then begin
          Result := Guild;
          Break;
        end;
      end;
    end;
  end;
end;

function TfrmCastleManage.AddAttackSabukWallOfGuild(sGuildName: string; AttackSabukWall: TDate): Boolean;
var
  AttackerInfo: pTAttackerInfo;
  Guild: TGUild;
  ListItem: TListItem;
begin
  Result := False;
  //Guild := nil;
  Guild := InListOfGuildName(sGuildName);
  if Guild = nil then begin
    Application.MessageBox('输入的行会名不存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if CurCastle = nil then Exit;
  New(AttackerInfo);
  AttackerInfo.AttackDate := AttackSabukWall;
  AttackerInfo.sGuildName := sGuildName;
  AttackerInfo.Guild := Guild;
  CurCastle.m_AttackWarList.Add(AttackerInfo);
  ListViewAttackSabukWall.Items.BeginUpdate;
  try
    ListItem := ListViewAttackSabukWall.Items.Add;
    Inc(nCount);
    ListItem.Caption := IntToStr(nCount);
    ListItem.SubItems.AddObject(AttackerInfo.sGuildName, TObject(AttackerInfo));
    ListItem.SubItems.Add(DateToStr(AttackerInfo.AttackDate));
    CurCastle.Save;
    Result := True;
  finally
    ListViewAttackSabukWall.Items.EndUpdate;
  end;
end;

function TfrmCastleManage.IsAttackSabukWallOfGuild(sGuildName: string; AttackDate: TDate): Boolean;
var
  I: Integer;
  ListItem: TListItem;
  AttackerInfo: pTAttackerInfo;
begin
  Result := False;
  if ListViewAttackSabukWall.Items.Count > 0 then begin//20080630
    for I := 0 to ListViewAttackSabukWall.Items.Count - 1 do begin
      ListItem := ListViewAttackSabukWall.Items.Item[I];
      AttackerInfo := pTAttackerInfo(ListItem.SubItems.Objects[0]);
      if AttackerInfo <> nil then begin
        if (CompareText(sGuildName, AttackerInfo.sGuildName) = 0) and (AttackerInfo.AttackDate = AttackDate) then begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

function TfrmCastleManage.ChgAttackSabukWallOfGuild(sGuildName: string; AttackSabukWall: TDate): Boolean;
var
  AttackerInfo: pTAttackerInfo;
  Guild: TGUild;
  ListItem: TListItem;
  I: Integer;
  boFound: Boolean;
begin
  Result := False;
  //Guild := nil;
  boFound := False;
  Guild := InListOfGuildName(sGuildName);
  if Guild = nil then begin
    Application.MessageBox('输入的行会名不存在！！！', '提示信息', MB_ICONQUESTION);
    Exit;
  end;
  if CurCastle = nil then Exit;
  if ListViewAttackSabukWall.Items.Count > 0 then begin//20080630
    for I := 0 to ListViewAttackSabukWall.Items.Count - 1 do begin
      ListItem := ListViewAttackSabukWall.Items.Item[I];
      AttackerInfo := pTAttackerInfo(ListItem.SubItems.Objects[0]);
      if AttackerInfo <> nil then begin//20090215
        if CompareText(sGuildName, AttackerInfo.sGuildName) = 0 then begin
          AttackerInfo.AttackDate := AttackSabukWall;
          AttackerInfo.sGuildName := sGuildName;
          ListItem.SubItems.Strings[0] := sGuildName;
          ListItem.SubItems.Strings[1] := DateToStr(AttackSabukWall);
          CurCastle.Save;
          boFound := True;
          Result := True;
          Break;
        end;
      end;
    end;
  end;
  if not boFound then Result := AddAttackSabukWallOfGuild(sGuildName, AttackSabukWall);
end;

procedure TfrmCastleManage.ButtonAttackAdClick(Sender: TObject);
begin
  FrmAttackSabukWall := TFrmAttackSabukWall.Create(Owner);
  FrmAttackSabukWall.Caption := '增加攻城申请';
  nStute := 0;
  FrmAttackSabukWall.Top := frmCastleManage.Top - 50;
  FrmAttackSabukWall.Left := frmCastleManage.Left + 150;
  FrmAttackSabukWall.Open();
  FrmAttackSabukWall.Free;
end;

procedure TfrmCastleManage.ButtonAttackEditClick(Sender: TObject);
begin
  if CurCastle = nil then Exit;
  if SelAttackGuildInfo = nil then Exit;
  FrmAttackSabukWall := TFrmAttackSabukWall.Create(Owner);
  FrmAttackSabukWall.Caption := '编辑攻城申请';
  nStute := 1;
  FrmAttackSabukWall.Top := frmCastleManage.Top - 50;
  FrmAttackSabukWall.Left := frmCastleManage.Left + 150;
  m_sGuildName := SelAttackGuildInfo.sGuildName;
  m_AttackDate := SelAttackGuildInfo.AttackDate;
  FrmAttackSabukWall.Open();
  FrmAttackSabukWall.Free;
end;

procedure TfrmCastleManage.ListViewAttackSabukWallClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  try
    ListItem := ListViewAttackSabukWall.Selected;
    SelAttackGuildInfo := pTAttackerInfo(ListItem.SubItems.Objects[0]);
  except
    SelAttackGuildInfo := nil;
  end;
end;

procedure TfrmCastleManage.ButtonAttackRClick(Sender: TObject);
begin
  if CurCastle = nil then Exit;
  RefCastleAttackSabukWall;
end;

procedure TfrmCastleManage.ButtonAttackDelClick(Sender: TObject);
var
  I: Integer;
  AttackerInfo: pTAttackerInfo;
begin
  if CurCastle = nil then Exit;
  if SelAttackGuildInfo = nil then Exit;
  if Application.MessageBox(PChar('是否确认删除此行会攻城申请？' + #10#10 +
    '行会名称：' + SelAttackGuildInfo.sGuildName + #10 +
    '攻城时间：' + DateToStr(SelAttackGuildInfo.AttackDate)), '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    for I := CurCastle.m_AttackWarList.Count - 1 downto 0 do begin//20080917 修改
      if CurCastle.m_AttackWarList.Count <= 0 then Break;//20080917
      AttackerInfo := pTAttackerInfo(CurCastle.m_AttackWarList.Items[I]);
      if AttackerInfo = SelAttackGuildInfo then begin
        CurCastle.m_AttackWarList.Delete(I);
        CurCastle.Save;
        Break;
      end;
    end;
    try
      ListViewAttackSabukWall.DeleteSelected;
    except
    end;
  end;
end;

procedure TfrmCastleManage.ButtonSaveClick(Sender: TObject);
begin
  if CurCastle = nil then Exit;
  CurCastle.m_sPalaceMap := EditPalace.Text;
  CurCastle.m_sHomeMap := EditHomeMap.Text;
  CurCastle.m_nHomeX := SpinEditNomeX.Value;
  CurCastle.m_nHomeY := SpinEditNomeY.Value;
  CurCastle.m_sSecretMap := EditTunnelMap.Text;
  CurCastle.m_sWarAreaHomeMap:= EditHomeMap1.text; //攻方行会回城点地图 20090527
  CurCastle.m_nWarAreaHomeX:= SpinEditNomeX1.Value; //攻方行会回城点X 20090527
  CurCastle.m_nWarAreaHomeY:= SpinEditNomeY1.Value; //攻方行会回城点Y 20090527
  CurCastle.Save;
  ButtonSave.Enabled := False;
end;

procedure TfrmCastleManage.Button1Click(Sender: TObject);
var
  I: Integer;
  Guild: TGUild;
  boIsOK: boolean;
begin
  Try
    boIsOK:= False;
    if CurCastle = nil then Exit;
    if EditOwenGuildName.Text <> '' then begin
      if g_GuildManager.GuildList.Count > 0 then begin
        for I := 0 to g_GuildManager.GuildList.Count - 1 do begin
          Guild := TGUild(g_GuildManager.GuildList.Items[I]);
          if CompareText(Guild.sGuildName, EditOwenGuildName.Text) = 0 then begin
            boIsOK:= True;
            CurCastle.GetCastle(Guild);//占领城堡
            Break;
          end;
        end;
      end;
    end;
    if not boIsOK then Application.MessageBox('输入的行会不存在!', '提示信息', MB_OK + MB_ICONERROR);
    Button1.Enabled:= False;
  Except
    MainOutMessage(Format('{%s} TfrmCastleManage.Button1Click', [g_sExceptionVer]));
  end;
end;

procedure TfrmCastleManage.EditOwenGuildNameClick(Sender: TObject);
begin
  Button1.Enabled:= True;
end;

procedure TfrmCastleManage.Button2Click(Sender: TObject);
var
  s20: string;
  Guild: TGUild;
  I: Integer;
begin
  if CurCastle = nil then begin
    Button2.Enabled:= False;
    Exit;
  end;

  CurCastle.m_boUnderWar := not CurCastle.m_boUnderWar;//设置为攻城
  if CurCastle.m_boUnderWar then begin//正在攻城
    if g_GuildManager.GuildList.Count > 0 then begin//20080816 增加所有行会为攻城行会
      for I := 0 to g_GuildManager.GuildList.Count - 1 do begin
        Guild := TGUild(g_GuildManager.GuildList.Items[I]);
        CurCastle.m_AttackGuildList.Add(Guild);
      end;
    end;
    CurCastle.m_boShowOverMsg := False;//20080816
    CurCastle.m_WarDate := Now();//20080816

    CurCastle.m_dwStartCastleWarTick := GetTickCount();
    CurCastle.StartWallconquestWar();

    //UserEngine.SendServerGroupMsg(SS_212, nServerIndex, '');
    s20 := '[' + CurCastle.m_sName + ' 攻城战已经开始]';
    UserEngine.SendBroadCastMsg(s20, t_System);
    //UserEngine.SendServerGroupMsg(SS_204, nServerIndex, s20);
    CurCastle.MainDoorControl(True);
    MainOutMessage(s20);
    Button2.Caption:='关闭攻城'
  end else begin
    CurCastle.StopWallconquestWar();
    Button2.Caption:='开始攻城';
  end;
  Button2.Enabled:= False;
end;

procedure TfrmCastleManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCastleManage.FormDestroy(Sender: TObject);
begin
  frmCastleManage:= nil;
end;

end.
