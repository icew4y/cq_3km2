unit LoginType;

interface
uses
  Windows, Messages, Classes, SysUtils, JSocket;
type
  TIpSockaddr = record
    sIPaddr: string[15];
    nIPCount: Integer;
    nAttackCount: Integer;
    dwConnctCheckTick: LongWord;
  end;
  pTIpSockaddr = ^TIpSockaddr;

  TIPRangeInfo = record
    sIPaddr: string[15];
    btSameLevel: Byte; //相似程度
  end;
  pTIPRangeInfo = ^TIPRangeInfo;

  TIPRange = record
    btIPaddr: Byte;
    IpSockaddrList: TStringList;
  end;
  pTIPRange = ^TIPRange;

  TUserSession = record
    Socket: TCustomWinSocket;
    SocketHandle: Integer;
    sRemoteIPaddr: string[15];
    nSendMsgLen: Integer;
    nReviceMsgLen: Integer;
    nCheckSendLength: Integer;
    boSendAvailable: Boolean;
    boSendCheck: Boolean;
    bo0C: Boolean;
    dwSendLockTimeOut: LongWord;
    dwUserTimeOutTick: LongWord;
    dwConnctCheckTick: LongWord;
    dwReceiveTick: LongWord;
    dwReceiveTimeTick: LongWord;
    boReceiveAvailable: Boolean;
    MsgList: TStringList;
  end;
  pTUserSession = ^TUserSession;

  TConfig = record
    GateName: string;
    TitleName: string;
    ServerPort: Integer;
    ServerAddr: string;
    GatePort: Integer;
    GateAddr: string;
    nMaxConnOfIPaddr: Integer;
    dwKeepConnectTimeOut: LongWord;
    nConnctCheckTime: Integer;
    boMinimize: Boolean;
  end;

  TGList = class(TList)
  private
    GLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;
  {=================================TGStringList================================}
  TGStringList = class(TStringList)
  private
    CriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
  end;
  TSStringList = class(TGStringList)
  public
    procedure QuickSort(Order: Boolean);
  end;
implementation
procedure TSStringList.QuickSort(Order: Boolean); //速度更快的排行
  procedure QuickSortStrListCase(List: TStringList; l, r: Integer);
  var
    I, J: Integer;
    p: string;
  begin
    if List.Count <= 0 then Exit;
    repeat
      I := l;
      J := r;
      p := List[(l + r) shr 1];
      repeat
        if Order then begin //升序
          while CompareStr(List[I], p) < 0 do Inc(I);
          while CompareStr(List[J], p) > 0 do Dec(J);
        end else begin //降序
          while CompareStr(p, List[I]) < 0 do Inc(I);
          while CompareStr(p, List[J]) > 0 do Dec(J);
        end;
        if I <= J then begin
          List.Exchange(I, J);
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if l < J then QuickSortStrListCase(List, l, J);
      l := I;
    until I >= r;
  end;
  procedure AddList(TempList: TStringList; slen: string; s: string; AObject: TObject);
  var
    I: Integer;
    List: TStringList;
    boFound: Boolean;
  begin
    boFound := False;
    for I := 0 to TempList.Count - 1 do begin
      if CompareText(TempList.Strings[I], slen) = 0 then begin
        List := TStringList(TempList.Objects[I]);
        List.AddObject(s, AObject);
        boFound := True;
        Break;
      end;
    end;
    if not boFound then begin
      List := TStringList.Create;
      List.AddObject(s, AObject);
      TempList.AddObject(slen, List);
    end;
  end;
var
  TempList: TStringList;
  List: TStringList;
  I: Integer;
  nLen: Integer;
begin
  TempList := TStringList.Create;
  for I := 0 to Self.Count - 1 do begin
    nLen := Length(Self.Strings[I]);
    AddList(TempList, IntToStr(nLen), Self.Strings[I], Self.Objects[I]);
  end;
  QuickSortStrListCase(TempList, 0, TempList.Count - 1);
  Self.Clear;
  for I := 0 to TempList.Count - 1 do begin
    List := TStringList(TempList.Objects[I]);
    QuickSortStrListCase(List, 0, List.Count - 1);
    Self.AddStrings(List);
    List.Free;
  end;
  TempList.Free;
end;
{ TGStringList }

constructor TGStringList.Create;
begin
  inherited;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGStringList.Destroy;
begin
  DeleteCriticalSection(CriticalSection);
  inherited;
end;

procedure TGStringList.Lock;
begin
  EnterCriticalSection(CriticalSection);
end;

procedure TGStringList.UnLock;
begin
  LeaveCriticalSection(CriticalSection);
end;

constructor TGList.Create;
begin
  inherited Create;
  InitializeCriticalSection(GLock);
end;

destructor TGList.Destroy;
begin
  DeleteCriticalSection(GLock);
  inherited;
end;

procedure TGList.Lock;
begin
  EnterCriticalSection(GLock);
end;

procedure TGList.UnLock;
begin
  LeaveCriticalSection(GLock);
end;
end.

