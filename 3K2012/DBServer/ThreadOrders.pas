unit ThreadOrders;
//排行线程
interface

uses
  Classes, Windows, SysUtils, MudUtil, DBShare, Forms;


type
  TThreadOrders = class
  private
    { Private declarations }
  protected
    m_boForm: Boolean;
    m_boSorting: Boolean;
    m_sDBFile: string;
    m_nRunTime: LongWord;
    m_nFileHandle: Integer;
    m_SelfTaxisList: TQuickPointList;
    m_SelfWarrList: TQuickPointList;
    m_SelfWaidList: TQuickPointList;
    m_SelfTaosList: TQuickPointList;
    m_HeroTaxisList: TQuickPointList;
    m_HeroWarrList: TQuickPointList;
    m_HeroWaidList: TQuickPointList;
    m_HeroTaosList: TQuickPointList;
    m_MasterList: TQuickPointList;

    procedure FrmShowHint(sMsg: string);
    procedure FrmShowProgress(Min, Max: Integer);
    procedure LoadHumDB();
    procedure ClearList();
    procedure Sort();
  public
    constructor Create(sDBFile: string; boForm: Boolean);
    destructor Destroy; override;
    procedure Execute;
  end;

implementation
uses HumanOrder, grobal2, HumDB, ComCtrls;

constructor TThreadOrders.Create(sDBFile: string; boForm: Boolean);
begin
  m_boForm := boForm;
  m_sDBFile := sDBFile;
  m_SelfTaxisList := TQuickPointList.Create;
  m_SelfWarrList := TQuickPointList.Create;
  m_SelfWaidList := TQuickPointList.Create;
  m_SelfTaosList := TQuickPointList.Create;
  m_HeroTaxisList := TQuickPointList.Create;
  m_HeroWarrList := TQuickPointList.Create;
  m_HeroWaidList := TQuickPointList.Create;
  m_HeroTaosList := TQuickPointList.Create;
  m_MasterList := TQuickPointList.Create;
end;

destructor TThreadOrders.Destroy;
begin
  inherited;
end;

procedure TThreadOrders.Execute;
resourcestring
  sLoadDB = '正在计算排行榜...';
  sLoadOK = '排行榜记算完成，共耗时(%d)毫秒...';
var
  nCheckCode: Byte;
begin
  try
    nCheckCode := 0;
    if not m_boSorting then begin
      m_boSorting := True;
      try
        m_nRunTime := GetTickCount;
        nCheckCode := 1;
        FrmShowHint(sLoadDB);
        nCheckCode := 2;
        LoadHumDB();
        nCheckCode := 3;
        FrmShowHint(Format(sLoadOK, [GetTickCount - m_nRunTime]));
        nCheckCode := 4;
        Sort;
        nCheckCode := 5;
        ClearList;
        nCheckCode := 6;
      finally
        m_boSorting := False;
      end;
    end;
  except
    MainOutMessage('[异常] TThreadOrders.Execute ' + IntToStr(nCheckCode));
  end;
end;

procedure TThreadOrders.LoadHumDB();
{const
   MaxBaseValue=100000; // 原来是60000 }

  function GetMagicId_105Level(HumInfo: THumDataInfo): Byte; //取龙卫心法等级
  var
    I: integer;
    UserMagic: THumMagic;
  begin
    Result := 0;
    for i := Low(HumInfo.Data.HumMagics) to High(HumInfo.Data.HumMagics) do begin
      if HumInfo.Data.HumMagics[i].wMagIdx <= 0 then Continue;
      UserMagic := HumInfo.Data.HumMagics[i];
      if UserMagic.wMagIdx = 105 then begin //龙卫心法
        Result := UserMagic.btLevel;
        Break;
      end;
    end;
  end;
var
  I, Count: integer;
  HumRecord: THumDataInfo;
  TOrders: pTOrders;
  nCode: Byte;
begin
  try
    if
      HumDataDB.Open(True) and (HumDataDB.Count > 0) then begin //20110128 修改
{$IF DBSMode = 1}
      Count := 90;
      HumDataDB.GetHumRanking(nSortLevel, nSortMaxLevel, -1, m_SelfTaxisList);
      FrmShowProgress(10, Count);
      HumDataDB.GetHumRanking(nSortLevel, nSortMaxLevel, 0, m_SelfWarrList);
      FrmShowProgress(20, Count);
      HumDataDB.GetHumRanking(nSortLevel, nSortMaxLevel, 1, m_SelfWaidList);
      FrmShowProgress(30, Count);
      HumDataDB.GetHumRanking(nSortLevel, nSortMaxLevel, 2, m_SelfTaosList);
      FrmShowProgress(40, Count);

      HumDataDB.GetHeroRanking(nSortLevel, nSortMaxLevel, -1, m_HeroTaxisList);
      FrmShowProgress(50, Count);
      HumDataDB.GetHeroRanking(nSortLevel, nSortMaxLevel, 0, m_HeroWarrList);
      FrmShowProgress(60, Count);
      HumDataDB.GetHeroRanking(nSortLevel, nSortMaxLevel, 1, m_HeroWaidList);
      FrmShowProgress(70, Count);
      HumDataDB.GetHeroRanking(nSortLevel, nSortMaxLevel, 2, m_HeroTaosList);

      FrmShowProgress(80, Count);
      HumDataDB.GetMasterRanking(nSortLevel, nSortMaxLevel, m_MasterList);
      FrmShowProgress(90, Count);
{$ELSE}
      nCode := 0;
      try
        Count := HumDataDB.Count - 1;
        nCode := 1;
        for i := 0 to Count do begin
          if HumDataDB.Get(I, HumRecord) > -1 then begin
            nCode := 2;
            if (not HumRecord.Header.boDeleted) and
              (HumRecord.Data.sChrName <> '') and
              (not GetDisableUserNameList(HumRecord.Data.sChrName)) and
              (HumRecord.Data.Abil.Level > nSortLevel) and (HumRecord.Data.Abil.Level < nSortMaxLevel) then begin
              nCode := 3;
              if (CompareText(HumRecord.Data.sChrName, HumRecord.Header.sName) <> 0) or (HumRecord.Data.btJob > 2) or (HumRecord.Data.btSex > 1) then Continue; //检查两处名字是否一致，不一样则认为是乱码继续
              nCode := 4;
              New(TOrders);
              TOrders.nLevel := HumRecord.Data.Abil.Level;
              TOrders.nExp := HumRecord.Data.Abil.nExp;
              TOrders.nMaster := HumRecord.Data.wMasterCount;
              nCode := 5;
              if HumRecord.Data.boIsHero then begin
                nCode := 6;
                TOrders.sName := HumRecord.Data.sMasterName;
                TOrders.sHeroName := HumRecord.Data.sChrName;
                nCode := 7;
                m_HeroTaxisList.AddPointer((TOrders.nLevel * 60000) + (TOrders.nExp div 1000000), TOrders, True);
                nCode := 8;
                case HumRecord.Data.btJob of
                  0: m_HeroWarrList.AddPointer((TOrders.nLevel * 60000) + TOrders.nExp div 1000000, TOrders, True);
                  1: m_HeroWaidList.AddPointer((TOrders.nLevel * 60000) + TOrders.nExp div 1000000, TOrders, True);
                  2: m_HeroTaosList.AddPointer((TOrders.nLevel * 60000) + TOrders.nExp div 1000000, TOrders, True);
                end;
              end else begin
                nCode := 9;
                TOrders.sName := HumRecord.Data.sChrName;
                TOrders.sHeroName := HumRecord.Data.sHeroChrName;
                if HumRecord.Data.sHeartName <> '' then begin //龙卫心法自定义名不为空时才查找
                  TOrders.nHeartLevel := GetMagicId_105Level(HumRecord); //取龙卫心法等级
                end else TOrders.nHeartLevel := 0;
                nCode := 10;
                m_SelfTaxisList.AddPointer((TOrders.nLevel * 60000) + {TOrders.nExp div 100000000+}(TOrders.nHeartLevel), TOrders, True);
                nCode := 11;
                case HumRecord.Data.btJob of
                  0: m_SelfWarrList.AddPointer((TOrders.nLevel * 60000) + {TOrders.nExp div 1000000 +}(TOrders.nHeartLevel), TOrders, True); // * 10000
                  1: m_SelfWaidList.AddPointer((TOrders.nLevel * 60000) + {TOrders.nExp div 1000000 +}(TOrders.nHeartLevel), TOrders, True);
                  2: m_SelfTaosList.AddPointer((TOrders.nLevel * 60000) + {TOrders.nExp div 1000000 +}(TOrders.nHeartLevel), TOrders, True);
                end;
                if TOrders.nMaster > 0 then begin
                  nCode := 12;
                  m_MasterList.AddPointer(TOrders.nMaster, TOrders, True);
                end;
              end;
            end;
          end;
          nCode := 13;
          FrmShowProgress(I, Count);
        end;
      except
        MainOutMessage('[异常] TThreadOrders.ReadHumDB Code:' + IntToStr(nCode));
      end;
{$IFEND}
    end;
  finally
    HumDataDB.Close;
  end;
end;

procedure TThreadOrders.Sort();

  procedure SaveList(List: TQuickPointList; var Taxis: THumSort);
  var
    i: integer;
    Temp: pTOrders;
  begin
    FillChar(Taxis, SizeOf(THumSort), #0);
    Taxis.nUpDate := Now;
    for I := 0 to List.Count - 1 do begin
      if i > High(Taxis.List) then break;
      Temp := List.GetPointer(I);
      Taxis.List[I].nIndex := I + 1;
      Taxis.List[I].sChrName := Temp.sName;
      Taxis.List[I].wLevel := Temp.nLevel;
      Taxis.List[I].nHeartLevel := Temp.nHeartLevel;
      Taxis.nMaxIdx := I + 1;
    end;
  end;

  procedure SaveHeroList(List: TQuickPointList; var Taxis: THeroSort);
  var
    i: integer;
    Temp: pTOrders;
  begin
    FillChar(Taxis, SizeOf(THeroSort), #0);
    Taxis.nUpDate := Now;
    for I := 0 to List.Count - 1 do begin
      if i > High(Taxis.List) then break;
      Temp := List.GetPointer(I);
      Taxis.List[I].nIndex := I + 1;
      Taxis.List[I].sChrName := Temp.sName;
      Taxis.List[I].sHeroName := Temp.sHeroName;
      Taxis.List[I].wLevel := Temp.nLevel;
      Taxis.nMaxIdx := I + 1;
    end;
  end;

  procedure SaveMasterList(List: TQuickPointList; var Taxis: THumSort);
  var
    i: integer;
    Temp: pTOrders;
  begin
    FillChar(Taxis, SizeOf(THumSort), #0);
    Taxis.nUpDate := Now;
    for I := 0 to List.Count - 1 do begin
      if i > High(Taxis.List) then break;
      Temp := List.GetPointer(I);
      Taxis.List[I].nIndex := I + 1;
      Taxis.List[I].sChrName := Temp.sName;
      Taxis.List[I].wLevel := Temp.nMaster;
      Taxis.nMaxIdx := I + 1;
    end;
  end;

begin
  ForceDirectories(sSort);
  SaveList(m_SelfTaxisList, g_TaxisAllList);
  SaveHumToFile(sSort + 'AllHum.DB', g_TaxisAllList);

  SaveList(m_SelfWarrList, g_TaxisWarrList);
  SaveHumToFile(sSort + 'WarrHum.DB', g_TaxisWarrList);

  SaveList(m_SelfWaidList, g_TaxisWaidList);
  SaveHumToFile(sSort + 'WizardHum.DB', g_TaxisWaidList);

  SaveList(m_SelfTaosList, g_TaxisTaosList);
  SaveHumToFile(sSort + 'TaosHum.DB', g_TaxisTaosList);

  SaveHeroList(m_HeroTaxisList, g_HeroAllList);
  SaveHeroToFile(sSort + 'AllHero.DB', g_HeroAllList);

  SaveHeroList(m_HeroWarrList, g_HeroWarrList);
  SaveHeroToFile(sSort + 'WarrHero.DB', g_HeroWarrList);

  SaveHeroList(m_HeroWaidList, g_HeroWaidList);
  SaveHeroToFile(sSort + 'WizardHero.DB', g_HeroWaidList);

  SaveHeroList(m_HeroTaosList, g_HeroTaosList);
  SaveHeroToFile(sSort + 'TaosHero.DB', g_HeroTaosList);

  SaveMasterList(m_MasterList, g_MasterList);
  SaveHumToFile(sSort + 'Master.DB', g_MasterList);
end;

procedure TThreadOrders.ClearList();
var
  I: integer;
begin
{$IF DBSMode = 1}
  if m_SelfTaxisList.Count > 0 then begin
    for I := 0 to m_SelfTaxisList.Count - 1 do Dispose(pTOrders(m_SelfTaxisList.GetPointer(I)));
  end;
  m_SelfTaxisList.Free;

  if m_SelfWarrList.Count > 0 then begin
    for I := 0 to m_SelfWarrList.Count - 1 do Dispose(pTOrders(m_SelfWarrList.GetPointer(I)));
  end;
  m_SelfWarrList.Free;

  if m_SelfWaidList.Count > 0 then begin
    for I := 0 to m_SelfWaidList.Count - 1 do Dispose(pTOrders(m_SelfWaidList.GetPointer(I)));
  end;
  m_SelfWaidList.Free;

  if m_SelfTaosList.Count > 0 then begin
    for I := 0 to m_SelfTaosList.Count - 1 do Dispose(pTOrders(m_SelfTaosList.GetPointer(I)));
  end;
  m_SelfTaosList.Free;

  if m_HeroTaxisList.Count > 0 then begin
    for I := 0 to m_HeroTaxisList.Count - 1 do Dispose(pTOrders(m_HeroTaxisList.GetPointer(I)));
  end;
  m_HeroTaxisList.Free;

  if m_HeroWarrList.Count > 0 then begin
    for I := 0 to m_HeroWarrList.Count - 1 do Dispose(pTOrders(m_HeroWarrList.GetPointer(I)));
  end;
  m_HeroWarrList.Free;

  if m_HeroWaidList.Count > 0 then begin
    for I := 0 to m_HeroWaidList.Count - 1 do Dispose(pTOrders(m_HeroWaidList.GetPointer(I)));
  end;
  m_HeroWaidList.Free;

  if m_HeroTaosList.Count > 0 then begin
    for I := 0 to m_HeroTaosList.Count - 1 do Dispose(pTOrders(m_HeroTaosList.GetPointer(I)));
  end;
  m_HeroTaosList.Free;

  if m_MasterList.Count > 0 then begin
    for I := 0 to m_MasterList.Count - 1 do Dispose(pTOrders(m_MasterList.GetPointer(I)));
  end;
  m_MasterList.Free;
{$ELSE}
  for I := 0 to m_SelfTaxisList.Count - 1 do Dispose(pTOrders(m_SelfTaxisList.GetPointer(I)));
  for I := 0 to m_HeroTaxisList.Count - 1 do Dispose(pTOrders(m_HeroTaxisList.GetPointer(I)));

  m_SelfTaxisList.Free;
  m_SelfWarrList.Free;
  m_SelfWaidList.Free;
  m_SelfTaosList.Free;
  m_HeroTaxisList.Free;
  m_HeroWarrList.Free;
  m_HeroWaidList.Free;
  m_HeroTaosList.Free;
  m_MasterList.Free;
{$IFEND}
end;

procedure TThreadOrders.FrmShowHint(sMsg: string);
begin
  if m_boForm then begin
    HumanOrderFrm.Label5.Caption := sMsg;
    HumanOrderFrm.Label5.Refresh;
  end;
end;

procedure TThreadOrders.FrmShowProgress(Min, Max: Integer);
begin
  if m_boForm then begin
    if Max > 0 then HumanOrderFrm.ProgressBar1.Position := Trunc(Min / Max * 100);
  end;
  //修复排行时的假死 By TasBat at : 2012-03-05 09:47:26
  if Min mod 100 = 0 then
    Application.ProcessMessages;
end;

end.
 
