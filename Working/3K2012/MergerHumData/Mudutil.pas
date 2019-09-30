unit Mudutil;

interface
uses
  Windows, Classes, SysUtils;

type
   TQuickName = record //人物或帐号变更列表
    sName: string[14]; //原名字
    sNewName: string[14]; //新名字
  end;
  pTQuickName = ^TQuickName;

  TQuickID = record //帐号索引用的每个帐号包含的人物表
    sAccount: string[10]; //0x
    sChrName: string[14]; //0x
    nIndex: Integer; //0x
  end;
  pTQuickID = ^TQuickID;

  TQuickHum = record //hum索引
    sAccount: string[10]; //0x
    sChrName: string[14]; //0x
    boIsDel: Boolean;
    boIsHero: Boolean;
    nIndex: Integer; //0x
  end;
  pTQuickHum = ^TQuickHum;

 { TQuickAC = record //装备列表处理复制品时用
    sAccount: string[10]; //帐号
    sChrName: string[14]; //人物名
    MakeIndex: Cardinal; //装备编号
    wIndex: Word; //装备名称
    HumIsBa: Byte; //包裹还是仓库还是人体和四格
    baindex: integer; //物品在包裹或仓库四格等的index
    idindex: Integer; //人物在数据库的ID号
  end;
  pTQuickAc = ^TQuickAC;

   TQuickAC1 = record //装备列表处理重复编号时用
    MakeIndex: Cardinal; //装备编号
    HumIsBa: Byte; //包裹还是仓库还是人体和四格
    baindex: integer; //物品在包裹或仓库四格等的index
    idindex: Integer; //人物在数据库的ID号
  end;
  pTQuickAc1 = ^TQuickAC1;    }

  TMagic = record //技能类
    wMagicId: Word;//技能ID
    sMagicName: string[18];//技能名称 20091201修改由12->18
    btEffectType: Byte;//动作效果
    btEffect: Byte;//魔法效果
    //bt11: Byte;//未使用 20080531
    wSpell: Word;//魔法消耗
    wPower: Word;//基本威力
    TrainLevel: array[0..3] of Byte;//技能等级
    //w02: Word;//未使用
    MaxTrain: array[0..3] of LongWord{Integer};//各技能等级最高修炼点  68,71,99,100技能MaxTrain[0]--升级修炼点数 20091223修改
    btTrainLv: Byte;//修炼等级
    btJob: Byte;//职业 0-战 1-法 2-道 3-刺客
    //wMagicIdx: Word;//未使用 20080531
    dwDelayTime: LongWord;//技能延时
    btDefSpell: Byte;//升级魔法
    btDefPower: Byte;//升级威力
    wMaxPower: Word;//最大威力
    btDefMaxPower: Byte;//升级最大威力
    sDescr: string[8];//备注说明
  end;
  pTMagic = ^TMagic;

  TQuickList = class(TStringList)
  private
    CriticalSection: TRTLCriticalSection;
    function GetCaseSensitive: Boolean;
    procedure SetCaseSensitive(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    procedure SortString(nMIN, nMax: Integer);
    function GetIndex(sName: string): Integer;
    function AddRecord(sName: string; nIndex: Integer): Boolean;
    function AddItemRecord(MakeIndex: string; aObject: TObject): Boolean;
    function AddHumRecord(sName, sAccount: string; nIndex: Integer; isDel: Boolean;
      IsHero: Boolean): Boolean;
    procedure Lock;
    procedure UnLock;
  published
    property boCaseSensitive: Boolean read GetCaseSensitive write
      SetCaseSensitive;
  end;
  TQuickIDList = class(TStringList)
  public
    procedure AddRecord(sAccount, sChrName: string; nIndex: Integer);
    procedure DelRecord(nIndex: Integer; sChrName: string);
    function GetChrList(sAccount: string; var ChrNameList: TList): Integer;
  end;

  TQuickMagicList = class(TList)
  public
    function GetMagicName(MagIdx: Word): string;
  end;

implementation

{ TQuickIDList }

procedure TQuickIDList.AddRecord(sAccount, sChrName: string; nIndex: Integer);
var
  QuickID: pTQuickID;
  ChrList: TList;
  nLow, nHigh, nMed, n1C, n20: Integer;
begin
  New(QuickID);
  QuickID.sAccount := sAccount;
  QuickID.sChrName := sChrName;
  QuickID.nIndex := nIndex;
  if Count = 0 then begin
    ChrList := TList.Create;
    ChrList.Add(QuickID);
    AddObject(sAccount, ChrList);
  end else begin
    if Count = 1 then begin
      nMed := CompareStr(sAccount, Self.Strings[0]);
      if nMed > 0 then begin
        ChrList := TList.Create;
        ChrList.Add(QuickID);
        AddObject(sAccount, ChrList);
      end else begin
        if nMed < 0 then begin
          ChrList := TList.Create;
          ChrList.Add(QuickID);
          InsertObject(0, sAccount, ChrList);
        end else begin
          ChrList := TList(Self.Objects[0]);
          ChrList.Add(QuickID);
        end;
      end;
    end else begin
      nLow := 0;
      nHigh := Self.Count - 1;
      nMed := (nHigh - nLow) div 2 + nLow;
      while (True) do begin
        if (nHigh - nLow) = 1 then begin
          n20 := CompareStr(sAccount, Self.Strings[nHigh]);
          if n20 > 0 then begin
            ChrList := TList.Create;
            ChrList.Add(QuickID);
            InsertObject(nHigh + 1, sAccount, ChrList);
            Break;
          end else begin
            if CompareStr(sAccount, Self.Strings[nHigh]) = 0 then begin
              ChrList := TList(Self.Objects[nHigh]);
              ChrList.Add(QuickID);
              Break;
            end else begin
              n20 := CompareStr(sAccount, Self.Strings[nLow]);
              if n20 > 0 then begin
                ChrList := TList.Create;
                ChrList.Add(QuickID);
                InsertObject(nLow + 1, sAccount, ChrList);
                Break;
              end else begin
                if n20 < 0 then begin
                  ChrList := TList.Create;
                  ChrList.Add(QuickID);
                  InsertObject(nLow, sAccount, ChrList);
                  Break;
                end else begin
                  ChrList := TList(Self.Objects[n20]);
                  ChrList.Add(QuickID);
                  Break;
                end;
              end;
            end;
          end;
        end else begin
          n1C := CompareStr(sAccount, Self.Strings[nMed]);
          if n1C > 0 then begin
            nLow := nMed;
            nMed := (nHigh - nLow) div 2 + nLow;
            Continue;
          end;
          if n1C < 0 then begin
            nHigh := nMed;
            nMed := (nHigh - nLow) div 2 + nLow;
            Continue;
          end;
          ChrList := TList(Self.Objects[nMed]);
          ChrList.Add(QuickID);
          Break;
        end;
      end;
    end;
  end;
end;

procedure TQuickIDList.DelRecord(nIndex: Integer; sChrName: string);
var
  QuickID: pTQuickID;
  ChrList: TList;
  I: Integer;
begin
  if (Self.Count - 1) < nIndex then Exit;
  ChrList := TList(Self.Objects[nIndex]);
  for I := 0 to ChrList.Count - 1 do begin
    QuickID := ChrList.Items[I];
    if QuickID.sChrName = sChrName then begin
      Dispose(QuickID);
      ChrList.Delete(I);
      Break;
    end;
  end;
  if ChrList.Count <= 0 then begin
    ChrList.Free;
    Self.Delete(nIndex);
  end;
end;

function TQuickIDList.GetChrList(sAccount: string; var ChrNameList: TList): Integer;
var
  nHigh, nLow, nMed, n20, n24: Integer;
begin
  Result := -1;
  if Self.Count = 0 then Exit;
  if Self.Count = 1 then begin
    if CompareStr(sAccount, Self.Strings[0]) = 0 then begin
      ChrNameList := TList(Self.Objects[0]);
      Result := 0;
    end;
  end else begin
    nLow := 0;
    nHigh := Self.Count - 1;
    nMed := (nHigh - nLow) div 2 + nLow;
    n24 := -1;
    while (True) do begin
      if (nHigh - nLow) = 1 then begin
        if CompareStr(sAccount, Self.Strings[nHigh]) = 0 then n24 := nHigh;
        if CompareStr(sAccount, Self.Strings[nLow]) = 0 then n24 := nLow;
        Break;
      end else begin
        n20 := CompareStr(sAccount, Self.Strings[nMed]);
        if n20 > 0 then begin
          nLow := nMed;
          nMed := (nHigh - nLow) div 2 + nLow;
          Continue;
        end;
        if n20 < 0 then begin
          nHigh := nMed;
          nMed := (nHigh - nLow) div 2 + nLow;
          Continue;
        end;
        n24 := nMed;
        Break;
      end;
    end;
    if n24 <> -1 then ChrNameList := TList(Self.Objects[n24]);
    Result := n24;
  end;
end;

{ TQuickList }

function TQuickList.GetIndex(sName: string): Integer;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
begin
  Result := -1;
  if Self.Count <> 0 then begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        if CompareStr(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        if CompareText(sName, Self.Strings[0]) = 0 then begin
          Result := 0;
          exit;
        end;
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareStr(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareStr(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareStr(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        if CompareText(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        if CompareText(sName, Self.Strings[0]) = 0 then begin
          Result := 0;
          exit;
        end;
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareText(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareText(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin
            nCompareVal := CompareText(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end;
        end;
      end;
    end;
  end;
end;


procedure TQuickList.SortString(nMIN, nMax: Integer);
var
  ntMin, ntMax: Integer;
  s18: string;
begin
  if Self.Count > 0 then
    while (True) do begin
      ntMin := nMIN;
      ntMax := nMax;
      s18 := Self.Strings[(nMIN + nMax) shr 1];
      while (True) do begin
        while (CompareText(Self.Strings[ntMin], s18) < 0) do Inc(ntMin);
        while (CompareText(Self.Strings[ntMax], s18) > 0) do Dec(ntMax);
        if ntMin <= ntMax then begin
          Self.Exchange(ntMin, ntMax);
          Inc(ntMin);
          Dec(ntMax);
        end;
        if ntMin > ntMax then Break;
      end;
      if nMIN < ntMax then SortString(nMIN, ntMax);
      nMIN := ntMin;
      if ntMin >= nMax then Break;
    end;
end;

function TQuickList.AddItemRecord(MakeIndex: string; aObject: TObject): Boolean;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
begin
  Result := True;
  if Self.Count = 0 then begin
    Self.AddObject(MakeIndex, aObject);
  end else begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        nMed := CompareStr(MakeIndex, Self.Strings[0]);
        if nMed > 0 then
          Self.AddObject(MakeIndex, aObject)
        else begin
          if nMed < 0 then Self.InsertObject(0, MakeIndex, aObject);
        end;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareStr(MakeIndex, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, MakeIndex, aObject);
              Break;
            end else begin
              nMed := CompareStr(MakeIndex, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, MakeIndex, aObject);
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, MakeIndex, aObject);
                  Break;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareStr(MakeIndex, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        nMed := CompareText(MakeIndex, Self.Strings[0]);
        if nMed > 0 then Self.AddObject(MakeIndex, aObject)
        else begin
          if nMed < 0 then Self.InsertObject(0, MakeIndex, aObject);
        end;
      end else begin //
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareText(MakeIndex, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, MakeIndex, aObject);
              Break;
            end else begin
              nMed := CompareText(MakeIndex, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, MakeIndex, aObject);
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, MakeIndex, aObject);
                  Break;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareText(MakeIndex, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TQuickList.AddRecord(sName: string; nIndex: Integer): Boolean;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
begin
  Result := True;
  if Self.Count = 0 then begin
    Self.AddObject(sName, TObject(nIndex));
  end else begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        nMed := CompareStr(sName, Self.Strings[0]);
        if nMed > 0 then Self.AddObject(sName, TObject(nIndex))
        else begin
          if nMed < 0 then Self.InsertObject(0, sName, TObject(nIndex));
        end;
      end else begin //0x0045B19F
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareStr(sName, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, sName, TObject(nIndex));
              Break;
            end else begin
              nMed := CompareStr(sName, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, sName, TObject(nIndex));
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, sName, TObject(nIndex));
                  Break;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareStr(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        nMed := CompareText(sName, Self.Strings[0]);
        if nMed > 0 then Self.AddObject(sName, TObject(nIndex))
        else begin
          if nMed < 0 then Self.InsertObject(0, sName, TObject(nIndex));
        end;
      end else begin //
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareText(sName, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, sName, TObject(nIndex));
              Break;
            end else begin
              nMed := CompareText(sName, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, sName, TObject(nIndex));
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, sName, TObject(nIndex));
                  Break;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareText(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TQuickList.AddHumRecord(sName, sAccount: string; nIndex: Integer;
  isDel: Boolean; IsHero: Boolean): Boolean;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
  QuickHum: pTQuickHum;
begin
  Result := True;
  New(QuickHum);
  QuickHum.sAccount := sAccount;
  QuickHum.sChrName := sName;
  QuickHum.boIsDel := isDel;
  QuickHum.boIsHero := IsHero;
  QuickHum.nIndex := nIndex;
  if Self.Count = 0 then begin
    Self.AddObject(sName, TObject(QuickHum));
  end else begin
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        nMed := CompareStr(sName, Self.Strings[0]);
        if nMed > 0 then Self.AddObject(sName, TObject(QuickHum))
        else begin
          if nMed < 0 then Self.InsertObject(0, sName, TObject(QuickHum));
        end;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareStr(sName, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, sName, TObject(QuickHum));
              Break;
            end else begin
              nMed := CompareStr(sName, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, sName, TObject(QuickHum));
                Break;
              end else begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, sName, TObject(QuickHum));
                  Break;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareStr(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end else begin
      if Self.Count = 1 then begin
        nMed := CompareText(sName, Self.Strings[0]);
        if nMed > 0 then Self.AddObject(sName, TObject(QuickHum))
        else begin
          if nMed < 0 then Self.InsertObject(0, sName, TObject(QuickHum));
        end;
      end else begin //
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            nMed := CompareText(sName, Self.Strings[nHigh]);
            if nMed > 0 then begin
              Self.InsertObject(nHigh + 1, sName, TObject(QuickHum));
              Break;
            end else begin
              nMed := CompareText(sName, Self.Strings[nLow]);
              if nMed > 0 then begin
                Self.InsertObject(nLow + 1, sName, TObject(QuickHum));
                Break;
              end else  begin
                if nMed < 0 then begin
                  Self.InsertObject(nLow, sName, TObject(QuickHum));
                  Break;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin
            nCompareVal := CompareText(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := False;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TQuickList.GetCaseSensitive: Boolean;
begin
  Result := CaseSensitive;
end;

procedure TQuickList.SetCaseSensitive(const Value: Boolean);
begin
  CaseSensitive := Value;
end;

procedure TQuickList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TQuickList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

constructor TQuickList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TQuickList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

{ TMagicList }

function TQuickMagicList.GetMagicName(MagIdx: Word): string;
var
  nHigh, nLow, nMed: Integer;
begin
  Result := '';
  if Self.Count = 0 then Exit;
  if Self.Count = 1 then begin
    if MagIdx = pTMagic(self.Items[0]).wMagicId then begin
      Result := pTMagic(self.Items[0]).sMagicName;
    end;
  end else begin
    nLow := 0;
    nHigh := Self.Count - 1;
    nMed := (nHigh - nLow) div 2 + nLow;
    while (True) do begin
      if (nHigh - nLow) = 1 then begin
        if MagIdx = pTMagic(self.Items[nHigh]).wMagicId then Result := pTMagic(self.Items[nHigh]).sMagicName;
        if MagIdx = pTMagic(self.Items[nLow]).wMagicId then Result := pTMagic(self.Items[nLow]).sMagicName;
        Break;
      end else begin
        if MagIdx = pTMagic(self.Items[nMed]).wMagicId then begin
          Result := pTMagic(self.Items[nMed]).sMagicName;
          Break;
        end;
        if MagIdx > pTMagic(self.Items[nMed]).wMagicId then begin
          nLow := nMed;
          nMed := (nHigh - nLow) div 2 + nLow;
          Continue;
        end else begin
          nHigh := nMed;
          nMed := (nHigh - nLow) div 2 + nLow;
          Continue;
        end;
      end;
    end;
  end;
end;

end.

