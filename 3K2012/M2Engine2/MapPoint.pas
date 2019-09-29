unit MapPoint;

interface
uses
  Windows, Classes, Envir, ObjBase, Grobal2;
type
  TPathType = (t_Dynamic{动态}, t_Fixed{固定});

  TMapPoint = class
  private
    FX, FY: Integer;
    FThrough: Boolean;
  public
    constructor Create(nX, nY: Integer);
    destructor Destroy; override;
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;

    property Through: Boolean read FThrough write FThrough;
  end;

  TPointManager = class
    m_nCurrX, m_nCurrY: Integer;
    m_nPostion: Integer;
    m_btDirection: Byte;
    m_nTurnCount: Integer;
    m_PEnvir: TEnvirnoment;
  private
    FPointList: TList;
    FBaseObject: TBaseObject;
    FPathType: TPathType;
    function GetCount: Integer;
  public
    constructor Create(ABaseObject: TBaseObject);
    destructor Destroy; override;
    procedure Initialize(Envir: TEnvirnoment);
    function GetPoint(var nX, nY: Integer): Boolean;
    function GetPoint1(var nX, nY: Integer): Boolean;
    property Count: Integer read GetCount;
    property PathType: TPathType read FPathType write FPathType;
  end;
implementation
uses
  M2Share;

constructor TMapPoint.Create(nX, nY: Integer);
begin
  FX := nX;
  FY := nY;
  FThrough := False;
end;

destructor TMapPoint.Destroy;
begin
  inherited;
end;

{----------------------------------TPointManager--------------------------------}

constructor TPointManager.Create(ABaseObject: TBaseObject);
begin
  m_nCurrX := -1;
  m_nCurrY := -1;
  m_nPostion := -1;
  FBaseObject := ABaseObject;
  FPointList := TList.Create;
  FPathType := t_Dynamic; //t_Fixed; //t_Dynamic;
  m_PEnvir := nil;
end;

destructor TPointManager.Destroy;
begin
  FPointList.Free;
  inherited;
end;

function TPointManager.GetCount: Integer;
begin
  Result := FPointList.Count;
end;

procedure TPointManager.Initialize(Envir: TEnvirnoment);
begin
  m_PEnvir := Envir;
  m_nPostion := 0;
end;

function TPointManager.GetPoint(var nX, nY: Integer): Boolean;
  function GetNextDir(btDir: Byte): Byte;
  begin
    case btDir of
      DR_UP{0}: Result := DR_UPRIGHT{1};
      DR_UPRIGHT{1}: Result := DR_RIGHT{2};
      DR_RIGHT{2}: Result := DR_DOWNRIGHT{3};
      DR_DOWNRIGHT{3}: Result := DR_DOWN{4};
      DR_DOWN{4}: Result := DR_DOWNLEFT{5};
      DR_DOWNLEFT{5}: Result := DR_LEFT{6};
      DR_LEFT{6}: Result := DR_UPLEFT{7};
      DR_UPLEFT{7}: Result := DR_UP{0};
    end;
  end;
var
  I, nMX, nMY, nC, n10, nIndex, nPostion: Integer;
  MapPoint, MapPoint10: TMapPoint;
  boFind: Boolean;
  nCurrX, nCurrY: Integer;
  btDir: Byte;
  Pt: Integer;
  nX1, nY1, nX2, nY2, nStep: Integer;
begin
  Result := False;
  if FPathType = t_Dynamic then begin
    m_nCurrX := nX;
    m_nCurrY := nY;
    m_btDirection := TBaseObject(FBaseObject).m_btDirection;
    for I := 2 downto 1 do begin
      if TBaseObject(FBaseObject).m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, m_btDirection, I, nMX, nMY) then begin
        if TBaseObject(FBaseObject).CanMove(nMX, nMY, False) then begin
          m_nTurnCount := 0;
          nX := nMX;
          nY := nMY;
          Result := True;
          Exit;
        end;
      end;
    end;
    nC := 0;
    btDir := m_btDirection;
    while True do begin
      btDir := GetNextDir(btDir);
      for I := 2 downto 1 do begin
        if TBaseObject(FBaseObject).m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, btDir, I, nMX, nMY) then begin
          if TBaseObject(FBaseObject).CanMove(nMX, nMY, False) then begin
            nX := nMX;
            nY := nMY;
            Result := True;
            Exit;
          end;
        end;
      end;
      Inc(nC);
      if (nC >= 8) then Break;
    end;   
  end else begin
    nMX := 0;
    nMY := 0;
    if TBaseObject(FBaseObject).m_PEnvir <> m_PEnvir then begin
      m_PEnvir := TBaseObject(FBaseObject).m_PEnvir;
      m_nPostion := 0;
      m_nCurrX := nX;
      m_nCurrY := nY;
    end;

    nIndex := m_PEnvir.m_PointList.Count;
    n10 := 99999;
    if not ((m_nPostion >= 0) and (m_nPostion < m_PEnvir.m_PointList.Count) and
      (m_nCurrX = nX) and (m_nCurrY = nY)) then begin
      m_nPostion := 0;
    end;
    for I := m_nPostion to m_PEnvir.m_PointList.Count - 1 do begin
      Pt := Integer(m_PEnvir.m_PointList.Items[I]);
      nCurrX := LoWord(Pt);
      nCurrY := HiWord(Pt);
      nC := abs(nX - nCurrX) + abs(nY - nCurrY);
      if nC < n10 then begin
        n10 := nC;
        nMX := nCurrX;
        nMY := nCurrY;
        nIndex := I;
        m_nPostion := I;
        Result := True;
        if (n10 <= 0) then break;
      end;
    end;

    if nIndex >= m_PEnvir.m_PointList.Count - 1 then begin
      Result := False;
    end else begin
      if (n10 <= 0) and (nIndex >= 0) then begin
        nStep := 0;
        for I := m_nPostion + 1 to m_PEnvir.m_PointList.Count - 1 do begin
          Pt := Integer(m_PEnvir.m_PointList.Items[I]);
          nCurrX := LoWord(Pt);
          nCurrY := HiWord(Pt);

          if nStep = 0 then begin
            btDir := GetNextDirection(nX, nY, nCurrX, nCurrY);
            nMX := nCurrX;
            nMY := nCurrY;
            m_nPostion := I;
          end else begin
            if (GetNextDirection(nMX, nMY, nCurrX, nCurrY) = btDir) then begin
              nMX := nCurrX;
              nMY := nCurrY;
              m_nPostion := I;
            end else begin
              break;
            end;
          end;
          nStep := nStep + 1;
          if nStep >= 2 then break
        end;
      end;

      if not (TBaseObject(FBaseObject).CanRun(nX, nY, nMX, nMY, False)) then begin
        for I := m_nPostion + 1 to m_PEnvir.m_PointList.Count - 1 do begin
          Pt := Integer(m_PEnvir.m_PointList.Items[I]);
          nCurrX := LoWord(Pt);
          nCurrY := HiWord(Pt);
          m_nPostion := I;
          if m_PEnvir.CanWalkEx(nCurrX, nCurrY, False) then begin
            nMX := nCurrX;
            nMY := nCurrY;
            break;
          end;
        end;
      end;
      nX := nMX;
      nY := nMY;
      m_nCurrX := nX;
      m_nCurrY := nY;
    end;
  end;
end;
//朱火魔专用
function TPointManager.GetPoint1(var nX, nY: Integer): Boolean;
  function GetNextDir(btDir: Byte): Byte;
  begin
    case btDir of
      DR_UP{0}: begin
        case Random(4) of
          0: Result := DR_UPRIGHT{1};
          1: Result := DR_RIGHT{2};
          2: Result := DR_UPLEFT{7};
          3: Result := DR_LEFT{6};
        end;
      end;
      DR_UPRIGHT{1}: begin
        case Random(4) of
          0: Result := DR_RIGHT{2};
          1: Result := DR_DOWNRIGHT{3};
          2: Result := DR_UP{0};
          3: Result := DR_UPLEFT{7};
        end;
      end;
      DR_RIGHT{2}: begin
        case Random(4) of
          0: Result := DR_DOWNRIGHT{3};
          1: Result := DR_DOWN{4};
          2: Result := DR_UPRIGHT{1};
          3: Result := DR_UP{0};
        end;
      end;
      DR_DOWNRIGHT{3}: begin
        case Random(4) of
          0: Result := DR_DOWN{4};
          1: Result := DR_DOWNLEFT{5};
          2: Result := DR_RIGHT{2};
          3: Result := DR_UPRIGHT{1};
        end;
      end;
      DR_DOWN{4}: begin
        case Random(4) of
          0: Result := DR_DOWNLEFT{5};
          1: Result := DR_LEFT{6};
          2: Result := DR_DOWNRIGHT{3};
          3: Result := DR_RIGHT{2};
        end;
      end;
      DR_DOWNLEFT{5}: begin
        case Random(4) of
          0: Result := DR_LEFT{6};
          1: Result := DR_UPLEFT{7};
          2: Result := DR_DOWN{4};
          3: Result := DR_DOWNRIGHT{3};
        end;
      end;
      DR_LEFT{6}: begin
        case Random(4) of
          0: Result := DR_UPLEFT{7};
          1: Result := DR_UP{0};
          2: Result := DR_DOWNLEFT{5};
          3: Result := DR_DOWN{4};
        end;
      end;
      DR_UPLEFT{7}: begin
        case Random(4) of
          0: Result := DR_UP{0};
          1: Result := DR_UPRIGHT{1};
          2: Result := DR_LEFT{6};
          3: Result := DR_DOWNLEFT{5};
        end;
      end;
    end;
  end;
var
  I, nMX, nMY, nC, n10, nIndex, nPostion: Integer;
  MapPoint, MapPoint10: TMapPoint;
  boFind: Boolean;
  nCurrX, nCurrY: Integer;
  btDir: Byte;
  Pt: Integer;
  nX1, nY1, nX2, nY2, nStep: Integer;
begin
  Result := False;
  if FPathType = t_Dynamic then begin
    m_nCurrX := nX;
    m_nCurrY := nY;
    nC := 0;
    btDir := TBaseObject(FBaseObject).m_btDirection;
    while True do begin
      btDir := GetNextDir(btDir);
      for I := 2 downto 1 do begin
        if TBaseObject(FBaseObject).m_PEnvir.GetNextPosition(m_nCurrX, m_nCurrY, btDir, I, nMX, nMY) then begin
          if TBaseObject(FBaseObject).CanMove(nMX, nMY, False) then begin
            nX := nMX;
            nY := nMY;
            Result := True;
            Exit;
          end;
        end;
      end;
      Inc(nC);
      if (nC >= 8) then Break;
    end;
  end else begin
    nMX := 0;
    nMY := 0;
    if TBaseObject(FBaseObject).m_PEnvir <> m_PEnvir then begin
      m_PEnvir := TBaseObject(FBaseObject).m_PEnvir;
      m_nPostion := 0;
      m_nCurrX := nX;
      m_nCurrY := nY;
    end;

    nIndex := m_PEnvir.m_PointList.Count;
    n10 := 99999;
    if not ((m_nPostion >= 0) and (m_nPostion < m_PEnvir.m_PointList.Count) and
      (m_nCurrX = nX) and (m_nCurrY = nY)) then begin
      m_nPostion := 0;
    end;
    for I := m_nPostion to m_PEnvir.m_PointList.Count - 1 do begin
      Pt := Integer(m_PEnvir.m_PointList.Items[I]);
      nCurrX := LoWord(Pt);
      nCurrY := HiWord(Pt);
      nC := abs(nX - nCurrX) + abs(nY - nCurrY);
      if nC < n10 then begin
        n10 := nC;
        nMX := nCurrX;
        nMY := nCurrY;
        nIndex := I;
        m_nPostion := I;
        Result := True;
        if (n10 <= 0) then break;
      end;
    end;

    if nIndex >= m_PEnvir.m_PointList.Count - 1 then begin
      Result := False;
    end else begin
      if (n10 <= 0) and (nIndex >= 0) then begin
        nStep := 0;
        for I := m_nPostion + 1 to m_PEnvir.m_PointList.Count - 1 do begin
          Pt := Integer(m_PEnvir.m_PointList.Items[I]);
          nCurrX := LoWord(Pt);
          nCurrY := HiWord(Pt);

          if nStep = 0 then begin
            btDir := GetNextDirection(nX, nY, nCurrX, nCurrY);
            nMX := nCurrX;
            nMY := nCurrY;
            m_nPostion := I;
          end else begin
            if (GetNextDirection(nMX, nMY, nCurrX, nCurrY) = btDir) then begin
              nMX := nCurrX;
              nMY := nCurrY;
              m_nPostion := I;
            end else begin
              break;
            end;
          end;
          nStep := nStep + 1;
          if nStep >= 2 then break
        end;
      end;

      if not (TBaseObject(FBaseObject).CanRun(nX, nY, nMX, nMY, False)) then begin
        for I := m_nPostion + 1 to m_PEnvir.m_PointList.Count - 1 do begin
          Pt := Integer(m_PEnvir.m_PointList.Items[I]);
          nCurrX := LoWord(Pt);
          nCurrY := HiWord(Pt);
          m_nPostion := I;
          if m_PEnvir.CanWalkEx(nCurrX, nCurrY, False) then begin
            nMX := nCurrX;
            nMY := nCurrY;
            break;
          end;
        end;
      end;
      nX := nMX;
      nY := nMY;
      m_nCurrX := nX;
      m_nCurrY := nY;
    end;
  end;
end;

end.

