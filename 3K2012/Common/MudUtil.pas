unit Mudutil;

interface
uses
  Windows, Classes, SysUtils;
type
  TQuickID = record
    sAccount: string[16]; //账号
    sChrName: string[20]; //姓名
    nIndex: Integer; //0x34
    nSelectID: Integer;
    boIsHero: Boolean;
  end;
  pTQuickID = ^TQuickID;
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
    procedure Lock;
    procedure UnLock;
  published
    property boCaseSensitive: Boolean read GetCaseSensitive write SetCaseSensitive;
  end;
  TQuickIDList = class(TStringList)
  public
    procedure AddRecord(sAccount, sChrName: string; nIndex, nSelIndex: Integer; boIsHero: Boolean);
    procedure DelRecord(nIndex: Integer; sChrName: string);
    function GetChrList(sAccount: string; var ChrNameList: TList): Integer;
  end;

  TQuickPointList=class(TList)//DBS排行榜使用 
    m_List  :TList;
  public
    constructor Create();
    destructor Destroy; override;
    procedure ClearPointer;
    Function AddPointer(nIndex:Integer;Item:Pointer;boAdd:Boolean):Pointer;
    Function GetPointer(nIndex:Integer):Pointer;
  end;

implementation

{ TQuickIDList }

procedure TQuickIDList.AddRecord(sAccount, sChrName: string; nIndex, nSelIndex: Integer; boIsHero: Boolean);
var
  QuickID: pTQuickID;
  ChrList: TList;
  nLow, nHigh, nMed, n1C, n20: Integer;
begin
  New(QuickID);
  QuickID.sAccount := sAccount;
  QuickID.sChrName := sChrName;
  QuickID.nIndex := nIndex;
  QuickID.nSelectID := nSelIndex;
  QuickID.boIsHero := boIsHero;
  if Count = 0 then begin
    ChrList := TList.Create;
    ChrList.Add(QuickID);
    AddObject(sAccount, ChrList);
  end else begin //0x0045B839
    if Count = 1 then begin
      nMed := CompareStr(sAccount, Self.Strings[0]);
      if nMed > 0 then begin
        ChrList := TList.Create;
        ChrList.Add(QuickID);
        AddObject(sAccount, ChrList);
      end else begin //0x0045B89C
        if nMed < 0 then begin
          ChrList := TList.Create;
          ChrList.Add(QuickID);
          InsertObject(0, sAccount, ChrList);
        end else begin
          ChrList := TList(Self.Objects[0]);
          ChrList.Add(QuickID);
        end;
      end;
    end else begin //0x0045B8EF
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
            end else begin //0x0045B9BB
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

        end else begin //0x0045BA6A
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
  for I := ChrList.Count - 1 downto 0 do begin//20080917 修改
    if ChrList.Count <= 0 then Break;//20080917
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
  sId : string;
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
        sId := Self.Strings[nMed];
        n20 := CompareStr(sAccount, sId);
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
    if Self.Sorted then begin//是否排序
      if Self.Count = 1 then begin
        if CompareStr(sName, Self.Strings[0]) = 0 then Result := 0; // - > 0x0045B71D
      end else begin //0x0045B51E
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareStr(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareStr(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break; // - > 0x0045B71D
          end else begin
            nCompareVal := CompareStr(sName, Self.Strings[nMed]);
            if nCompareVal > 0 then begin
              nLow := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end; //0x0045B5DA
            if nCompareVal < 0 then begin
              nHigh := nMed;
              nMed := (nHigh - nLow) div 2 + nLow;
              Continue;
            end;
            Result := nMed;
            Break;
          end; //0x0045B609
        end;
      end;
    end else begin //0x0045B609
      if Self.Count = 1 then begin
        if CompareText(sName, Self.Strings[0]) = 0 then Result := 0;
      end else begin
        nLow := 0;
        nHigh := Self.Count - 1;
        nMed := (nHigh - nLow) div 2 + nLow;
        while (True) do begin
          if (nHigh - nLow) = 1 then begin
            if CompareText(sName, Self.Strings[nHigh]) = 0 then Result := nHigh;
            if CompareText(sName, Self.Strings[nLow]) = 0 then Result := nLow;
            Break;
          end else begin //0x0045B6B3
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
    end; //0x0045B71D
  end;
end;

procedure TQuickList.SortString(nMIN, nMax: Integer);
//0x0045AF78
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
        if ntMin > ntMax then Break
      end;
      if nMIN < ntMax then SortString(nMIN, ntMax);
      nMIN := ntMin;
      if ntMin >= nMax then Break;
    end;
end;

function TQuickList.AddRecord(sName: string; nIndex: Integer): Boolean;
var
  nLow, nHigh, nMed, nCompareVal: Integer;
begin
  Result := True;
  if Self.Count = 0 then begin
    Self.AddObject(sName, TObject(nIndex));
  end else begin //0x0045B133
    if Self.Sorted then begin
      if Self.Count = 1 then begin
        nMed := CompareStr(sName, Self.Strings[0]);
        if nMed > 0 then
          Self.AddObject(sName, TObject(nIndex))
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
                  Break; ;
                end else begin
                  Result := False;
                  Break;
                end;
              end;
            end;
          end else begin //0x0045B26A
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
        if nMed > 0 then
          Self.AddObject(sName, TObject(nIndex))
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
          end else begin //0x0045B26A
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

{TQuickPointList}

constructor TQuickPointList.Create();
begin
  inherited Create;
  m_List:=TList.Create;
end;

destructor TQuickPointList.Destroy;
begin
  m_List.Free;
  inherited;

end;

procedure TQuickPointList.ClearPointer();
begin
  m_List.Clear;
end;

Function TQuickPointList.GetPointer(nIndex:Integer):Pointer;
begin
  Result:=m_List.Items[nIndex];
end;

Function TQuickPointList.AddPointer(nIndex:Integer;Item:Pointer;boAdd:Boolean):Pointer;
var
  nLow,nHigh,nMed,n1C,n20:Integer;
begin
  Result:=Nil;
  if Count = 0 then begin
    Add(Pointer(nIndex));
    m_List.Add(Item);
  end else begin
    if Count = 1 then begin
      nMed:= Integer(Items[0]) - nIndex;
      if nMed > 0 then begin
        Add(Pointer(nIndex));
        m_List.Add(Item);
      end else begin
        if nMed < 0 then begin
          Insert(0,Pointer(nIndex));
          m_List.Insert(0,Item);
        end else begin
          Result:=m_List.Items[0];
          if boAdd then begin
            Add(Pointer(nIndex));
            m_List.Add(Item);
          end;
        end;
      end;
    end else begin//if Count = 1
      nLow:=0;
      nHigh:=Count -1;
      nMed:=(nHigh - nLow) div 2 + nLow;
      while (true) do begin
        if (nHigh - nLow) = 1 then begin
          n20:=Integer(Items[nHigh]) - nIndex;
          if n20 > 0 then begin
            Insert(nHigh + 1,Pointer(nIndex));
            m_List.Insert(nHigh + 1,Item);
            break;
          end else begin  //if n20 > 0
            if (Integer(Items[nHigh])  - nIndex) = 0 then begin
              Result:=m_List.Items[nHigh];
              if boAdd then begin
                Insert(nHigh + 1,Pointer(nIndex));
                m_List.Insert(nHigh + 1,Item);
              end;
              break;
            end else begin //0x0045B9BB
              n20:=Integer(Items[nLow])  - nIndex;
              if n20 > 0 then begin
                Insert(nLow + 1,Pointer(nIndex));
                m_List.Insert(nLow + 1,Item);
                break;
              end else begin
                if n20 < 0 then begin
                  Insert(nLow,Pointer(nIndex));
                  m_List.Insert(nLow,Item);
                  break;
                end else begin
                  Result:=m_List.Items[nLow];
                  if boAdd then begin
                    Insert(nLow + 1,Pointer(nIndex));
                    m_List.Insert(nLow + 1,Item);
                  end;
                  break;
                end;
              end; //if n20 > 0
            end; //if (nIndex
          end;//if n20 > 0
        end else begin//if (nHigh - nLow) = 1
          n1C:=Integer(Items[nMed])  - nIndex;
          if n1C > 0 then begin
            nLow:=nMed;
            nMed:=(nHigh - nLow) div 2 + nLow;
            Continue;
          end;
          if n1C < 0 then begin
            nHigh:=nMed;
            nMed:=(nHigh - nLow) div 2 + nLow;
            Continue;
          end;
          Result:=m_List.Items[nMed];
          if boAdd then begin
            Insert(nMed + 1,Pointer(nIndex));
            m_List.Insert(nMed + 1,Item);
          end;
          break;
        end; //if (nHigh - nLow) = 1
      end; //while
    end;//if Count = 1
  end; //if Count = 0
end;

end.



