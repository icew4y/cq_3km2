unit ViewOnlineHuman;

interface

uses
  Windows, SysUtils, StrUtils, Classes, Controls, Forms,
  Grids, ExtCtrls, StdCtrls, Spin, Menus;

type
  TfrmViewOnlineHuman = class(TForm)
    PanelStatus: TPanel;
    GridHuman : TStringGrid;
    Timer: TTimer;
    Panel1: TPanel;
    ButtonRefGrid: TButton;
    Label1: TLabel;
    ComboBoxSort: TComboBox;
    EditSearchName: TEdit;
    ButtonSearch: TButton;
    ButtonView: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    EditMinLevel: TSpinEdit;
    EditMaxLevel: TSpinEdit;
    CheckBoxSendOnlineCount: TCheckBox;
    Edit1: TEdit;
    Button1: TButton;
    ButtonKick: TButton;
    CheckBoxShowHero: TCheckBox;
    PopupMenu: TPopupMenu;
    T3: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ButtonRefGridClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBoxSortClick(Sender: TObject);
    procedure GridHumanDblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure ButtonViewClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonKickClick(Sender: TObject);
    procedure CheckBoxShowHeroClick(Sender: TObject);
    procedure T3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    ViewList: TStringList;
    dwTimeOutTick: LongWord;
    procedure RefGridSession();
    procedure GetOnlineList();
    procedure SortOnlineList(nSort: Integer);//排序在线列表
    procedure ShowHumanInfo();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmViewOnlineHuman: TfrmViewOnlineHuman;

implementation

uses UsrEngn, M2Share, ObjBase, HUtil32, HumanInfo, Grobal2, ObjAIPlayObject, MapPoint, ObjHero;

{$R *.dfm}

{ TfrmViewOnlineHuman }

procedure TfrmViewOnlineHuman.Open;
begin
  try
    {$IF M2Version <> 2}
    ComboBoxSort.Items.Add('内功等级');
    {$IFEND}
    {$IF HEROVERSION <> 1}
    CheckBoxShowHero.Visible:= False;
    {$IFEND}
    if not Assigned(frmHumanInfo) then frmHumanInfo := TfrmHumanInfo.Create(Owner);//20110225 修改
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    RefGridSession();
    Timer.Enabled := True;
    ShowModal;
    Timer.Enabled := False;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TfrmViewOnlineHuman.Open %s',[g_sExceptionVer, E.Message]));
    end;
  end;
end;
//取在线人物列表
procedure TfrmViewOnlineHuman.GetOnlineList;
var
  I: Integer;
begin
  try
    ViewList.Clear;
    EnterCriticalSection(ProcessHumanCriticalSection);
    try
      if UserEngine <> nil then begin
        for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
          if CheckBoxShowHero.Checked then begin//显示英雄
            {$IF HEROVERSION = 1}
            if TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_MyHero <> nil then begin
              ViewList.AddObject(TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_MyHero.m_sCharName, TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_MyHero);
            end;
            {$IFEND}
          end else ViewList.AddObject(UserEngine.m_PlayObjectList.Strings[I], UserEngine.m_PlayObjectList.Objects[I]);
        end;
      end;
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.GetOnlineList',[g_sExceptionVer]));
  end;
end;
procedure TfrmViewOnlineHuman.RefGridSession;
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    PanelStatus.Caption := '正在取得数据...';
    GridHuman.Visible := False;
    GridHuman.Cells[0, 1] := '';
    GridHuman.Cells[1, 1] := '';
    GridHuman.Cells[2, 1] := '';
    GridHuman.Cells[3, 1] := '';
    GridHuman.Cells[4, 1] := '';
    GridHuman.Cells[5, 1] := '';
    GridHuman.Cells[6, 1] := '';
    GridHuman.Cells[7, 1] := '';
    GridHuman.Cells[8, 1] := '';
    GridHuman.Cells[9, 1] := '';  // 登陆IP
    GridHuman.Cells[10, 1] := ''; // 登陆机器码
    GridHuman.Cells[11, 1] := '';
    GridHuman.Cells[12, 1] := '';
    GridHuman.Cells[13, 1] := '';
    GridHuman.Cells[14, 1] := '';
    GridHuman.Cells[15, 1] := '';
    GridHuman.Cells[16, 1] := '';
    GridHuman.Cells[17, 1] := '';
    GridHuman.Cells[18, 1] := '';
    GridHuman.Cells[19, 1] := '';//20081204
    GridHuman.Cells[20, 1] := '';//20081204

    if ViewList.Count <= 0 then begin
      GridHuman.RowCount := 2;
      GridHuman.FixedRows := 1;
    end else begin
      GridHuman.RowCount := ViewList.Count + 1;
    end;
    for I := 0 to ViewList.Count - 1 do begin
      PlayObject := TPlayObject(ViewList.Objects[I]);
      if PlayObject <> nil then begin
        GridHuman.Cells[0, I + 1] := IntToStr(I);
        GridHuman.Cells[1, I + 1] := PlayObject.m_sCharName;
        GridHuman.Cells[2, I + 1] := IntToSex(PlayObject.m_btGender);
        GridHuman.Cells[3, I + 1] := IntToJob(PlayObject.m_btJob);
        GridHuman.Cells[4, I + 1] := IntToStr(PlayObject.m_Abil.Level);
        GridHuman.Cells[6, I + 1] := PlayObject.m_sMapName;
        GridHuman.Cells[7, I + 1] := IntToStr(PlayObject.m_nCurrX) + ':' + IntToStr(PlayObject.m_nCurrY);
        if not CheckBoxShowHero.Checked then begin//显示英雄
          {$IF M2Version <> 2}
          GridHuman.Cells[5, I + 1] := IntToStr(PlayObject.m_NGLevel);//内功等级
          {$IFEND}
          GridHuman.Cells[8, I + 1] := PlayObject.m_sUserID;
          GridHuman.Cells[9, I + 1] := PlayObject.m_sIPaddr;
          GridHuman.Cells[10, I + 1] := '$'+IntToHex(PlayObject.m_dwHCode, 8);

          GridHuman.Cells[11, I + 1] := IntToStr(PlayObject.m_btPermission);
          GridHuman.Cells[12, I + 1] := PlayObject.m_sIPLocal; // GetIPLocal(PlayObject.m_sIPaddr);
          GridHuman.Cells[13, I + 1] := IntToStr(PlayObject.m_nGameGold);
          GridHuman.Cells[14, I + 1] := IntToStr(PlayObject.m_nGamePoint);
          GridHuman.Cells[15, I + 1] := IntToStr(PlayObject.m_nPayMentPoint);
          GridHuman.Cells[16, I + 1] := BooleanToStr(PlayObject.m_boNotOnlineAddExp);
          GridHuman.Cells[17, I + 1] := PlayObject.m_sAutoSendMsg;
          GridHuman.Cells[18, I + 1] := IntToStr(PlayObject.MessageCount);
          GridHuman.Cells[19, I + 1] := IntToStr(PlayObject.m_nGameDiaMond);
          GridHuman.Cells[20, I + 1] := IntToStr(PlayObject.m_nGameGird);
        end else begin
          {$IF M2Version <> 2}
          GridHuman.Cells[5, I + 1] := IntToStr(THeroObject(PlayObject).m_NGLevel);//内功等级
          {$IFEND}
          GridHuman.Cells[8, I + 1] := '';
          GridHuman.Cells[9, I + 1] := '';
          if PlayObject.m_Master <> nil then begin
            if not PlayObject.m_Master.m_boGhost then begin
              GridHuman.Cells[8, I + 1] := TPlayObject(PlayObject.m_Master).m_sUserID;
              GridHuman.Cells[9, I + 1] := TPlayObject(PlayObject.m_Master).m_sIPaddr;
              GridHuman.Cells[10, I + 1] := '$'+IntToHex(PlayObject.m_dwHCode, 8);
            end;
          end;
          GridHuman.Cells[11, I + 1] := '';
          GridHuman.Cells[12, I + 1] := '';
          GridHuman.Cells[13, I + 1] := '';
          GridHuman.Cells[14, I + 1] := '';
          GridHuman.Cells[15, I + 1] := '';
          GridHuman.Cells[16, I + 1] := '';
          GridHuman.Cells[17, I + 1] := '';
          GridHuman.Cells[18, I + 1] := '';
          GridHuman.Cells[19, I + 1] := '';
          GridHuman.Cells[20, I + 1] := '';
        end;
      end;
    end;
    GridHuman.Visible := True;
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.RefGridSession',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.FormCreate(Sender: TObject);
begin
  try
    ViewList := TStringList.Create;
    GridHuman.Cells[0, 0] := '序号';
    GridHuman.Cells[1, 0] := '人物名称';
    GridHuman.Cells[2, 0] := '性别';
    GridHuman.Cells[3, 0] := '职业';
    GridHuman.Cells[4, 0] := '等级';
    {$IF M2Version <> 2}
    GridHuman.Cells[5, 0] := '内功等级';
    {$ELSE}
    GridHuman.Cells[5, 0] := '预留属性';
    {$IFEND}
    GridHuman.Cells[6, 0] := '地图';
    GridHuman.Cells[7, 0] := '座标';
    GridHuman.Cells[8, 0] := '登录帐号';
    GridHuman.Cells[9, 0] := '登录IP';
    GridHuman.Cells[10, 0] := '机器码';
    GridHuman.Cells[11, 0] := '权限';
    GridHuman.Cells[12, 0] := '所在地区';
    GridHuman.Cells[13, 0] := g_Config.sGameGoldName;
    GridHuman.Cells[14, 0] := g_Config.sGamePointName;
    GridHuman.Cells[15, 0] := g_Config.sPayMentPointName;
    GridHuman.Cells[16, 0] := '离线挂机';
    GridHuman.Cells[17, 0] := '自动回复';
    GridHuman.Cells[18, 0] := '未处理消息';
    GridHuman.Cells[19, 0] := g_Config.sGameDiaMond; //20071226 金刚石
    GridHuman.Cells[20, 0] := g_Config.sGameGird;//20071226 灵符
    if UserEngine <> nil then  Caption := Format(' [在线人数：%d]', [UserEngine.PlayObjectCount]);
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.FormCreate',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.ButtonRefGridClick(Sender: TObject);
begin
  try
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    RefGridSession();
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.ButtonRefGridClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.FormDestroy(Sender: TObject);
begin
  ViewList.Free;
  frmViewOnlineHuman:= nil;
end;

procedure TfrmViewOnlineHuman.ComboBoxSortClick(Sender: TObject);
begin
  try
    if ComboBoxSort.ItemIndex < 0 then Exit;
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    SortOnlineList(ComboBoxSort.ItemIndex);
    RefGridSession();
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.ComboBoxSortClick',[g_sExceptionVer]));
  end;
end;

//按数字大小倒排序的函数 20090131
function DescCompareInt(List: TStringList; I1, I2: Integer): Integer;
begin
  I1 := StrToIntDef(List[I1], 0);
  I2 := StrToIntDef(List[I2], 0);
  if I1 > I2 then Result:=-1
  else if I1 < I2 then Result:=1
  else Result:=0;
end;
//字符串排序  20081024
function StrSort_2(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := 0;
  try
    Result := CompareStr(List[Index1], List[Index2]);
  except
  end;
end;

procedure TfrmViewOnlineHuman.SortOnlineList(nSort: Integer);
var
  I: Integer;
  SortList: TStringList;
begin
  try
    if (ViewList = nil) or (ViewList.Count = 0) then Exit;//20080503
    SortList := TStringList.Create;
    try
      case nSort of
        0: begin
            ViewList.Sort;
            Exit;
          end;
        1: begin
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btGender), ViewList.Objects[I]);
            end;
            SortList.CustomSort(DescCompareInt);//排序时调用那个函数 20081023 OK
          end;
        2: begin
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btJob), ViewList.Objects[I]);
            end;
            SortList.CustomSort(DescCompareInt);//排序时调用那个函数 20081023 OK
          end;
        3: begin
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_Abil.Level), ViewList.Objects[I]);
            end;
            SortList.CustomSort(DescCompareInt);//排序时调用那个函数 20081005 OK
          end;
        4: begin
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sMapName, ViewList.Objects[I]);
            end;
            SortList.CustomSort(StrSort_2);//文字排序 20081024
          end;
        5: begin
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sIPaddr, ViewList.Objects[I]);
            end;
            SortList.CustomSort(StrSort_2);//文字排序 20081024
          end;
        6: begin
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_btPermission), ViewList.Objects[I]);
            end;
            SortList.CustomSort(DescCompareInt);//排序时调用那个函数 20081005
          end;
        7: begin
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(TPlayObject(ViewList.Objects[I]).m_sIPLocal, ViewList.Objects[I]);
            end;
            SortList.CustomSort(StrSort_2);//文字排序 20081024
          end;
        8: begin//非挂机 20080811
            for I := 0 to ViewList.Count - 1 do begin
              if not TPlayObject(ViewList.Objects[I]).m_boNotOnlineAddExp then begin
                SortList.AddObject(IntToStr(I), ViewList.Objects[I]);
              end;
            end;
          end;//8
        9: begin//元宝
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_nGameGold), ViewList.Objects[I]);
            end;
            SortList.CustomSort(DescCompareInt);//排序时调用那个函数 20080928
          end;//9
        10: begin//非假人
            for I := 0 to ViewList.Count - 1 do begin
              if not TPlayObject(ViewList.Objects[I]).m_boAI then begin
                SortList.AddObject(IntToStr(I), ViewList.Objects[I]);
              end;
            end;
          end;//10
        11:begin//内功等级
            {$IF M2Version <> 2}
            for I := 0 to ViewList.Count - 1 do begin
              SortList.AddObject(IntToStr(TPlayObject(ViewList.Objects[I]).m_NGLevel), ViewList.Objects[I]);
            end;
            SortList.CustomSort(DescCompareInt);//排序时调用那个函数
            {$IFEND}
          end;//11
      end;
      //ViewList.Free;
      //ViewList := SortList; //20080503 修改成下面两段

      ViewList.Clear;
      for I := 0 to SortList.Count - 1 do begin
        ViewList.AddObject(IntToStr(I), SortList.Objects[I]);
      end;

      ViewList.Sort;
    finally
      SortList.Free;//20080117
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.SortOnlineList',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.GridHumanDblClick(Sender: TObject);
begin
  try
    ShowHumanInfo();
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.GridHumanDblClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.N2Click(Sender: TObject);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
      if PlayObject.m_boAI then begin
        TAIPlayObject(PlayObject).Start(TPathType(0));
      end;
      Application.ProcessMessages;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TfrmViewOnlineHuman.N3Click(Sender: TObject);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
      if PlayObject.m_boAI then begin
        TAIPlayObject(PlayObject).Stop;
      end;
      Application.ProcessMessages;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TfrmViewOnlineHuman.T3Click(Sender: TObject);
var
  I: Integer;
  PlayObject: TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
      PlayObject := TPlayObject(UserEngine.m_PlayObjectList.Objects[I]);
      if PlayObject.m_boAI then begin
        PlayObject.m_boEmergencyClose := True;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  dwTimeOutTick := GetTickCount();
  GetOnlineList();
  RefGridSession();
end;

procedure TfrmViewOnlineHuman.TimerTimer(Sender: TObject);
begin
  try
    if (GetTickCount - dwTimeOutTick > 30000) and (ViewList.Count > 0) then begin
      ViewList.Clear;
      RefGridSession();
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.TimerTimer',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.ButtonSearchClick(Sender: TObject);
var
  I: Integer;
  sHumanName: string;
  PlayObject: TPlayObject;
begin
  try
    sHumanName := Trim(EditSearchName.Text);
    if sHumanName = '' then begin
      Application.MessageBox('请输入一个人物名称！！！', '错误信息', MB_OK + MB_ICONEXCLAMATION);
      Exit;
    end;
    if Sender = ButtonSearch then begin
      for I := 0 to ViewList.Count - 1 do begin
        PlayObject := TPlayObject(ViewList.Objects[I]);
        if CompareText(PlayObject.m_sCharName, sHumanName) = 0 then begin
          GridHuman.Row := I + 1;
          Exit;
        end;
      end;
      Application.MessageBox('人物没有在线！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
    GetOnlineList();
    RefGridSession();
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.ButtonSearchClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.ButtonViewClick(Sender: TObject);
begin
  try
    ShowHumanInfo();
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.ButtonViewClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.ShowHumanInfo;
var
  nSelIndex: Integer;
  sPlayObjectName: string;
  PlayObject: TPlayObject;
  BaseObject: TBaseObject;
  nCode: Byte;
begin
  nCode:= 0;
  try
    nSelIndex := GridHuman.Row;
    Dec(nSelIndex);
    if (nSelIndex < 0) or (ViewList.Count <= nSelIndex) then begin
      if CheckBoxShowHero.Checked then begin
        Application.MessageBox('请先选择一个要查看的英雄！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
      end else begin
        Application.MessageBox('请先选择一个要查看的人物！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
      end;
      Exit;
    end;
    nCode:= 1;
    sPlayObjectName := GridHuman.Cells[1, nSelIndex + 1];
    if CheckBoxShowHero.Checked then begin//显示英雄
      {$IF HEROVERSION = 1}
      nCode:= 2;
      BaseObject := UserEngine.GetHeroObject(sPlayObjectName);
      nCode:= 3;
      if BaseObject = nil then begin
        Application.MessageBox('此人物已经不在线！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
        Exit;
      end;
      PlayObject := TPlayObject(BaseObject.m_Master);
      nCode:= 4;
      if PlayObject = nil then begin
        Application.MessageBox('此人物已经不在线！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
        Exit;
      end;
      nCode:= 4;
      if PlayObject <> nil then begin
        frmHumanInfo.PlayObject := PlayObject;
        frmHumanInfo.Top := Self.Top + 20;
        frmHumanInfo.Left := Self.Left;
        nCode:= 5;
        frmHumanInfo.Open(1);
      end;
      {$IFEND}
    end else begin
      nCode:= 6;
      PlayObject := UserEngine.GetPlayObject(sPlayObjectName);
      if PlayObject = nil then begin
        Application.MessageBox('此人物已经不在线！！！', '提示信息', MB_OK + MB_ICONINFORMATION);
        Exit;
      end;
      nCode:= 7;
      frmHumanInfo.PlayObject := {TPlayObject(ViewList.Objects[nSelIndex])}PlayObject;//20110225 修改
      frmHumanInfo.Top := Self.Top + 20;
      frmHumanInfo.Left := Self.Left;
      nCode:= 8;
      frmHumanInfo.Open(0);
    end;
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.ShowHumanInfo Code:%d.%p',[g_sExceptionVer, nCode, ExceptAddr]));
  end;
end;

procedure TfrmViewOnlineHuman.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  try
    try
      EnterCriticalSection(ProcessHumanCriticalSection);
      for I := 0 to UserEngine.m_PlayObjectList.Count - 1 do begin
        if TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boNotOnlineAddExp then begin
          if (TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_Abil.Level >= EditMinLevel.Value) and
            (TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_Abil.Level <= EditMaxLevel.Value) then begin
            TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boEmergencyClose := True;//20090726 增加
            TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boNotOnlineAddExp := False;
            TPlayObject(UserEngine.m_PlayObjectList.Objects[I]).m_boPlayOffLine := False;
          end;
        end;
      end;
    finally
      LeaveCriticalSection(ProcessHumanCriticalSection);
    end;
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    RefGridSession();
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.Button1Click',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frmViewOnlineHuman := nil;
end;

procedure TfrmViewOnlineHuman.ButtonKickClick(Sender: TObject);
var
  I: Integer;
  sHumanName: string;
  PlayObject: TPlayObject;
begin
  try
    sHumanName := Trim(Edit1.Text);
    if (sHumanName = '') and (not CheckBoxSendOnlineCount.Checked) then begin
      Application.MessageBox('请输入一个人物名称！！！', '错误信息', MB_OK + MB_ICONEXCLAMATION);
      Exit;
    end;
    for I := 0 to ViewList.Count - 1 do begin
      PlayObject := TPlayObject(ViewList.Objects[I]);
      if CheckBoxSendOnlineCount.Checked then begin
        if AnsiContainsText(PlayObject.m_sCharName, sHumanName) then begin
          PlayObject.m_boEmergencyClose := True;
          PlayObject.m_boNotOnlineAddExp := False;
          PlayObject.m_boPlayOffLine := False;
        end;
      end else begin
        if CompareText(PlayObject.m_sCharName, sHumanName) = 0 then begin
          PlayObject.m_boEmergencyClose := True;
          PlayObject.m_boNotOnlineAddExp := False;
          PlayObject.m_boPlayOffLine := False;
          Break;
        end;
      end;
    end;
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    RefGridSession();
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.ButtonKickClick',[g_sExceptionVer]));
  end;
end;

procedure TfrmViewOnlineHuman.CheckBoxShowHeroClick(Sender: TObject);
begin
  try
    ButtonKick.Enabled := not CheckBoxShowHero.Checked;
    dwTimeOutTick := GetTickCount();
    GetOnlineList();
    RefGridSession();
  except
    MainOutMessage(Format('{%s} TfrmViewOnlineHuman.CheckBoxShowHeroClick',[g_sExceptionVer]));
  end;
end;

end.

