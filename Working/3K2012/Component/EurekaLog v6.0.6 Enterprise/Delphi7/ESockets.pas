{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{           Sockets Unit - ESockets              }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ESockets;

{$I Exceptions.inc}

interface

uses SysUtils, Windows, WinSock;

type

  TSocketErrorEvent = procedure(Sender: TObject; ErrorCode: Integer;
    const ErrorMsg: string) of object;

  TSocketSendEvent = procedure(Sender: TObject; BytesSent,
    TotalBytes: Integer) of object;

  TEurekaClientSocket = class(TObject)
  private
    FAddr: TSockAddrIn;
    FHost: string;
    FPort: Word;
    FType: Integer;
    FTimeout: DWord;
    FConnected: Boolean;
    FSocket: TSocket;
    FLog: string;
    FOnError: TSocketErrorEvent;
    FOnSent: TSocketSendEvent;
    FQuietErrors: Boolean;
    function LookupName(const Name: string): TInAddr;
  protected
    function SendBuf(var Buf; Count: Integer): Integer;
    function ReceiveBuf(var Buf; Count: Integer): Integer;
    procedure Error(const Msg: string; const Args: array of const);
  public
    constructor Create(const Host: string; Port: Word; TCP: Boolean; Timeout: DWord);
    destructor Destroy; override;
    procedure Open; virtual;
    procedure Close; virtual;
    function SendText(const Text: string): Integer;
    function ReceiveText: string;
    function GetFullText: string;
    function ReceiveFullText: string;
    property QuietErrors: Boolean read FQuietErrors write FQuietErrors;
    property OnError: TSocketErrorEvent read FOnError write FOnError;
    property OnSent: TSocketSendEvent read FOnSent write FOnSent;
  end;

  TEurekaClientSMTP = class(TEurekaClientSocket)
  public
    procedure Open; override;
    function GetText(Codes: array of Word): Boolean;
    function SendCommand(Command: string; Codes: array of Word): Boolean;
  end;

  EEurekaSocketError = class(Exception);

function GetMXServerFromEmail(const Email: string; Timeout: DWord): string;

implementation

uses Classes, ECore;

var
  Initialized: Boolean = False;

function InternalStartup: Boolean;
var
  WSAData: TWSAData;
begin
  Result := True;
  if (Initialized) then Exit;

  Result := (WSAStartup($0101, WSAData) = 0);
  Initialized := True;
end;

function InternalCleanup: Boolean;
begin
  Result := (WSACleanup = 0);
  Initialized := False;
end;

{TEurekaClientSocket}

function TEurekaClientSocket.LookupName(const Name: string): TInAddr;
var
  HostEnt: PHostEnt;
  InAddr: TInAddr;
begin
  HostEnt := gethostbyname(PChar(Name));
  FillChar(InAddr, SizeOf(InAddr), 0);
  if HostEnt <> nil then
  begin
    with InAddr, HostEnt^ do
    begin
      S_un_b.s_b1 := h_addr^[0];
      S_un_b.s_b2 := h_addr^[1];
      S_un_b.s_b3 := h_addr^[2];
      S_un_b.s_b4 := h_addr^[3];
    end;
  end;
  Result := InAddr;
end;

procedure TEurekaClientSocket.Error(const Msg: string; const Args: array of const);
var
  Text: string;
begin
  Text := Format(Msg, Args);
  if (Pos(FLog, Text) = 0) then
    Text := Text + #13#10 + 'Socket log:' + #13#10 + FLog;
  if (Assigned(FOnError)) then FOnError(Self, -1, Text);
  if (not FQuietErrors) then raise EEurekaSocketError.Create(Text)
  else Abort;
end;

constructor TEurekaClientSocket.Create(const Host: string;
  Port: Word; TCP: Boolean; Timeout: DWord);
begin
  inherited Create;
  FLog := '';
  FAddr.sin_family := PF_INET;
  FAddr.sin_addr.s_addr := INADDR_ANY;
  FAddr.sin_port := 0;
  FHost := Host;
  FPort := Port;
  if (TCP) then FType := SOCK_STREAM else FType := SOCK_DGRAM;
  FTimeout := Timeout;
  FQuietErrors := False;
  FConnected := False;
end;

destructor TEurekaClientSocket.Destroy;
begin
  if (FConnected) then Close;
  inherited;
end;

procedure TEurekaClientSocket.Close;
begin
  if closesocket(FSocket) <> 0 then
    Error('Cannot close the socket: "%s"', [SysErrorMessage(WSAGetLastError)]);
  FSocket := INVALID_SOCKET;
  FAddr.sin_family := PF_INET;
  FAddr.sin_addr.s_addr := INADDR_ANY;
  FAddr.sin_port := 0;
  FConnected := False;
  FLog := '';
end;

procedure TEurekaClientSocket.Open;
var
  Blocking: Longint;
begin
  if FConnected then Exit;

  InternalStartup;

  FSocket := socket(PF_INET, FType, IPPROTO_IP);
  if FSocket = INVALID_SOCKET then
    Error('Invalid socket: "%s".', [SysErrorMessage(WSAGetLastError)]);
  FAddr.sin_family := PF_INET;
  FAddr.sin_addr := LookupName(FHost);
  FAddr.sin_port := htons(FPort);

  WSAAsyncSelect(FSocket, 0, 0, 0);
  Blocking := 0;
  ioctlsocket(FSocket, FIONBIO, Blocking);
  if connect(FSocket, FAddr, SizeOf(FAddr)) <> 0 then
    Error('Connection error: "%s"', [SysErrorMessage(WSAGetLastError)]);
  FConnected := FSocket <> INVALID_SOCKET;
  FLog := Format('Connected to %d.%d.%d.%d port %d'#13#10,
    [Ord(FAddr.sin_addr.S_un_b.s_b1),
    Ord(FAddr.sin_addr.S_un_b.s_b2),
      Ord(FAddr.sin_addr.S_un_b.s_b3),
      Ord(FAddr.sin_addr.S_un_b.s_b4), FPort]);
end;

function TEurekaClientSocket.SendBuf(var Buf; Count: Integer): Integer;
var
  ErrorCode: Integer;
begin
  Result := 0;
  if not FConnected then Exit;

  Result := send(FSocket, Buf, Count, 0);
  if Result = SOCKET_ERROR then
  begin
    ErrorCode := WSAGetLastError;
    if (ErrorCode <> WSAEWOULDBLOCK) then
    begin
      Close;
      if ErrorCode <> 0 then
        Error('Error into "send": "%s"', [SysErrorMessage(ErrorCode)]);
    end;
  end;
end;

function TEurekaClientSocket.SendText(const Text: string): Integer;
var
  Start, Size: Integer;
  Buff: string;
begin
  Result := 0;
  Start := 1;
  repeat
    Size := (length(Text) - Start + 1);
    if (Size > 1024) then Size := 1024;
    if (Size > 0) then
    begin
      Buff := Copy(Text, Start, Size);
      Inc(Result, SendBuf(Pointer(Buff)^, Size));
      Inc(Start, Size);
      if (Assigned(FOnSent)) then FOnSent(Self, Start, length(Text));
    end;
  until (Size = 0);
end;

function TEurekaClientSocket.ReceiveBuf(var Buf; Count: Integer): Integer;
var
  ErrorCode: Integer;
begin
  Result := 0;
  if (Count = -1) and FConnected then
    ioctlsocket(FSocket, FIONREAD, Longint(Result))
  else
  begin
    if not FConnected then Exit;
    Result := recv(FSocket, Buf, Count, 0);
    if Result = SOCKET_ERROR then
    begin
      ErrorCode := WSAGetLastError;
      if ErrorCode <> WSAEWOULDBLOCK then
      begin
        Close;
        if ErrorCode <> 0 then
          Error('Error into "recv": "%s"', [SysErrorMessage(ErrorCode)]);
      end;
    end;
  end;
end;

function TEurekaClientSocket.ReceiveText: string;
var
  tmp: string;
  mSec, Len: DWord;
begin
  Result := '';
  repeat
    Len := ReceiveBuf(Pointer(nil)^, -1);
    if (Len > 0) then
    begin
      SetLength(tmp, Len);
      SetLength(tmp, ReceiveBuf(Pointer(tmp)^, Length(tmp)));
      Result := (Result + tmp);
      FLog := FLog + tmp;
      mSec := GetTickCount;
      repeat
        Len := ReceiveBuf(Pointer(nil)^, -1);
        Sleep(1);
      until ((Len > 0) or (GetTickCount - mSec > 1000));
    end;
  until (Len = 0);
end;

function TEurekaClientSocket.GetFullText: string;
var
  mSec: DWord;
begin
  mSec := GetTickCount;
  repeat
    Result := ReceiveText;
    if (Result = '') then Sleep(1);
  until (Result <> '') or (GetTickCount - mSec >= FTimeout);
end;

function TEurekaClientSocket.ReceiveFullText: string;
begin
  Result := GetFullText;
  if (Result = '') then Error('Socket timeout.', ['']);
end;

{TEurekaClientSMTP}

procedure TEurekaClientSMTP.Open;
begin
  inherited;
  if (not GetText([220])) then Error(FLog, ['']);
end;

function TEurekaClientSMTP.GetText(Codes: array of Word): Boolean;
var
  Buff: string;
  idx, i: integer;
  Cod: DWord;
begin
  Result := False;
  Buff := ReceiveFullText;
  idx := 1;
  while (idx <= length(Buff)) and (Buff[idx] in ['0'..'9']) do inc(idx);
  if (idx > 1) then
  begin
    Cod := StrToInt(Copy(Buff, 1, idx - 1));
    for i := Low(Codes) to High(Codes) do
      if (Cod = Codes[i]) then
      begin
        Result := True;
        Break;
      end;
  end;
end;

function TEurekaClientSMTP.SendCommand(Command: string;
  Codes: array of Word): Boolean;
begin
  Result := False;
  if (Command = '') then Exit;

  if (Copy(Command, length(Command) - 1, 2) <> #13#10) then
    Command := Command + #13#10;
  if (SendText(Command) = length(Command)) then
  begin
    FLog := FLog + Command;
    Result := GetText(Codes);
  end;
  if (not Result) then Error(FLog, ['']);
end;

//------------------------------------------------------------------------------
// The MX records functions...                                                 -
//------------------------------------------------------------------------------

function GetDNSList: TStringList;
type
  PIP_Addr = ^TIP_Addr;
  TIP_Addr = packed record
    Next: PIP_Addr;
    IpAddress: array[0..15] of char;
    Unused: array[0..19] of byte; // Unused bytes.
  end;
  PDNSInfo = ^TDNSInfo;
  TDNSInfo = packed record
    Unused0: array[0..267] of byte; // Unused bytes.
    DNSList: TIP_Addr;
    Unused1: array[0..275] of byte; // Unused bytes.
  end;
var
  IpHlpModule: THandle;
  DNSInfo: PDNSInfo;
  Size: DWord;
  PDNS: PIP_Addr;
  err: Integer;
  GetNetworkParams: function(Info: PDNSInfo; pLen: PDWord): DWord; stdcall;

  function IsValidDNS(const IP: string): Boolean;
  begin
    Result := (Trim(IP) <> '0.0.0.0');
  end;

  procedure AddDNS(const IP: string);
  begin
    if (IsValidDNS(IP)) then GetDNSList.Add(IP);
  end;

begin
  Result := TStringList.Create;
  Size := 0;
  IpHlpModule := LoadLibrary('IPHLPAPI.DLL');
  if (IpHlpModule <> 0) then
  try
    GetNetworkParams := GetProcAddress(IpHlpModule, 'GetNetworkParams');
    if (@GetNetworkParams <> nil) then
    begin
      err := GetNetworkParams(nil, @Size);
      if (err = ERROR_BUFFER_OVERFLOW) then
      begin
        GetMem(DNSInfo, Size);
        try
          err := GetNetworkParams(DNSInfo, @Size);
          if (err = ERROR_SUCCESS) then
            with DNSInfo^ do
            begin
              AddDNS(DNSList.IpAddress);
              PDNS := DNSList.Next;
              while PDNS <> nil do
              begin
                AddDNS(PDNS^.IPAddress);
                PDNS := PDNS.Next;
              end;
            end;
        finally
          FreeMem(DNSInfo);
        end;
      end;
    end;
  finally
    FreeLibrary(IpHlpModule);
  end;
  AddDNS('193.121.171.135'); // An alternative DNS server.
end;

function StrToWord(C1, C2: Char): Word;
begin
  Result := Word((Ord(C1) shl 8) and $FF00) or Word(Ord(C2) and $00FF);
end;

function GetDomain(Src: string; var Idx: Integer): string;
var
  Len, OldIdx, Size: Integer;
  A: Char;
begin
  Result := '';
  Size := Length(Src);
  OldIdx := 0;
  repeat
    Len := byte(Src[Idx]);
    while (Len and $C0) = $C0 do
    begin
      if (OldIdx = 0) then OldIdx := Idx + 1;
      A := Char(Len and $3F);
      Idx := StrToWord(A, Src[Idx + 1]) + 1;
      Len := Byte(Src[Idx]);
    end;
    if (Idx >= Size) or (Idx + Len > Size) then
    begin
      Result := '';
      Exit;
    end;
    Result := Result + Copy(Src, Idx + 1, Len) + '.';
    Inc(Idx, Len + 1);
  until (Src[Idx] = #0) or (Idx >= Length(Src));
  if Result[Length(Result)] = '.' then Delete(Result, Length(Result), 1);
  if (OldIdx > 0) then Idx := OldIdx;
  Inc(Idx);
end;

function CreateMXQuery(const DomainName: string): string;

  function GetDomainName(SrcDNS: string): string;
  var
    Buff: string;
    idx: Integer;
  begin
    Result := '';
    while Length(SrcDns) > 0 do
    begin
      Idx := Pos('.', SrcDns);
      if Idx = 0 then Idx := Length(SrcDns) + 1;
      Buff := Copy(SrcDns, 1, Idx - 1);
      Delete(SrcDns, 1, Idx);
      Result := Result + Chr(Length(Buff)) + Buff;
    end;
  end;

begin
  Result := 'AA'#1#0#0#1#0#0#0#0#0#0 + GetDomainName(DomainName) + #0#0#15#0#1;
end;

function GetMXBestRecord(Src: string): string;
var
  Idx, Len, Pref, MaxPref: Integer;
  Server: string;

  function GetMXRecord(Src: string; Idx: Integer; var Server: string): Integer;
  var
    OldIdx: Integer;
  begin
    OldIdx := Idx;
    Inc(Idx, 2);
    Server := GetDomain(Src, Idx);
    if (Server <> '') then
    begin
      Idx := OldIdx;
      Result := StrToWord(Src[Idx], Src[Idx + 1]);
    end
    else Result := 0;
  end;

begin
  Result := '';
  Idx := 13;
  GetDomain(Src, Idx);
  Inc(Idx, 6);
  MaxPref := -1;
  repeat
    Len := StrToWord(Src[Idx + 8], Src[Idx + 9]);
    Pref := GetMXRecord(Copy(Src, 1, Idx + 9 + Len), Idx + 10, Server);
    if (Server <> '') then
    begin
      if (Pref > MaxPref) then
      begin
//        MaxPref := Pref;
        Result := Server;
        Break;
      end;
      Inc(Idx, Len + 12);
    end;
  until (Server = '');
end;

function GetMXServerFromEmail(const Email: string; Timeout: DWord): string;
const
  AttemptNumbers = 3;
var
  Socket: TEurekaClientSocket;
  Buff, Domain, MXQuery: string;
  DNSs: TSTringList;
  n: Integer;
  Step: DWord;
begin
  Result := '';
  Timeout := ((Timeout + 150) div AttemptNumbers);
  Domain := Copy(Email, Pos('@', Email) + 1, Length(Email));
  DNSs := GetDNSList;
  try
    n := 0;
    while (n <= DNSs.Count - 1) and (Result = '') do
    begin
      Step := 0;
      repeat
        Socket := TEurekaClientSocket.Create(DNSs[n], 53, False {UDP}, Timeout + Step * 100);
        try
          Socket.Open;
          MXQuery := CreateMXQuery(Domain);
          if (Socket.SendText(MXQuery) = Length(MXQuery)) then
          begin
            Buff := Socket.GetFullText;
            if (Buff <> '') then Result := GetMXBestRecord(Buff);
          end;
        finally
          Socket.Free;
        end;
        Inc(Step);
      until (Step = AttemptNumbers) or (Result <> '');
      Inc(n);
    end;
    if (Result = '') then
      raise EEurekaSocketError.CreateFmt(
        'Cannot resolve the "%s" MX record.', [Domain]);
  finally
    DNSs.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure Init;
begin
  InternalStartup;
end;

procedure Done;
begin
  InternalCleanup;
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'ESockets.Init');

finalization
  SafeExec(Done, 'ESockets.Done');

end.

