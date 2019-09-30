unit NetComs;
//---------------------------------------------------------------------------
// NetComs.pas                                          Modified: 25-May-2008
// Improved Network UDP Communication                            Version 1.01
//---------------------------------------------------------------------------
// Important Notice:
//
// If you modify/use this code or one of its parts either in original or
// modified form, you must comply with Mozilla Public License v1.1,
// specifically section 3, "Distribution Obligations". Failure to do so will
// result in the license breach, which will be resolved in the court.
// Remember that violating author's rights is considered a serious crime in
// many countries. Thank you!
//
// !! Please *read* Mozilla Public License 1.1 document located at:
//  http://www.mozilla.org/MPL/
//---------------------------------------------------------------------------
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//
// The Original Code is NetComs.pas.
//
// The Initial Developer of the Original Code is Yuriy Kotsarenko.
// Portions created by Yuriy Kotsarenko are Copyright (C) 2005 - 2008,
// Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, WinSock, Classes, SysUtils, Math, Messages, Forms, ExtCtrls,
 AsphyreData, PackedNums, NetBufs, NetLinks;

//---------------------------------------------------------------------------
const
 WM_SOCKET = WM_USER + 427;

//---------------------------------------------------------------------------
type
 TWSEvent = record
  Msg     : Longword;
  hSocket : THandle;
  sEvent  : Word;
  sError  : Word;
  Reserved: Longword;
 end;

//---------------------------------------------------------------------------
// Message header added to all packets
//---------------------------------------------------------------------------
 PPacketMsg = ^TPacketMsg;
 TPacketMsg = record
  swSize    : Integer;  // packet size
  swDataSize: Integer;  // data size (original, unpacked)
  dwChecksum: Longword; // checksum (of the packed data)
  dwMsgID   : Longword; // message ID
  dwFlags   : Longword; // specific flags
  dpData    : Longword; // message body points to this location
 end;

//---------------------------------------------------------------------------
 TReceiveEvent = procedure(Sender: TObject; const Host: string; Port: Integer;
  Data: Pointer; Size: Integer) of object;

//---------------------------------------------------------------------------
 TNetCom = class
 private
  hWindow : THandle;
  wSession: TWSAdata;
  hSocket : TSocket;

  FInitialized: Boolean;
  FLocalPort  : Integer;
  FOnReceive  : TReceiveEvent;

  StringBuf   : array[0..511] of Char; // null-terminated string buffer
  PacketMsg   : PPacketMsg;
  PacketBody  : Pointer;
  FBufferSize : Integer;
  MaxBodySize : Integer;
  DecodeBody  : Pointer;

  // [Guaranteed Packet Delivery] vars
  Links  : TLinks;
  Packets: TNetBufs;
  Timer  : TTimer;

  FResendFreq   : Integer;
  FResendCount  : Integer;
  FBytesReceived: Integer;
  FBytesPerSec  : Integer;
  FBytesSent    : Integer;
  BytesTransf   : Integer;
  TimerTicks    : Integer;
  FLinkTimeout  : Integer;

  function InitSock(): Boolean;
  procedure DoneSock();
  procedure SetLocalPort(const Value: Integer);
  procedure WindowEvent(var Msg: TMessage);
  procedure SocketEvent(var Msg: TWSEvent); message WM_SOCKET;
  function DWtoIP(const Address: Longword): string;
  procedure SockReceive();

  procedure EncodePacket(Data: Pointer; Size: Integer);
  function DecodePacket(out Data: Pointer; out Size: Integer): Boolean;
  procedure SetBufferSize(const Value: Integer);
  procedure AnalyzePacket(Host: string; Port: Integer);
  procedure SendConfirm(Host: string; Port: Integer; MsgID: Cardinal);
  function GetLinkDesc(): string;
  procedure TimerEvent(Sender: TObject);
  procedure SetResendProp(const Index, Value: Integer);
  procedure Resend(Index: Integer);
  procedure SetLinkTimeout(const Value: Integer);
 public
  property Initialized: Boolean read FInitialized;

  // The description string of currently active links.
  property LinkDesc: string read GetLinkDesc;

  // How many bytes have been received.
  property BytesReceived: Integer read FBytesReceived;

  // How many bytes have been sent.
  property BytesSent: Integer read FBytesSent;

  // How many bytes per second are transmitted.
  property BytesPerSec: Integer read FBytesPerSec;

  // the maximum size of packets that can be sent.
  property BufferSize: Integer read FBufferSize write SetBufferSize;

  // The local port to listen to.
  property LocalPort: Integer read FLocalPort write SetLocalPort;

  // The time to wait before resending guaranteed packets in milliseconds.
  property ResendFreq: Integer index 0 read FResendFreq write SetResendProp;

  // How many times to resend guaranteed packets before they are forfeit.
  property ResendCount: Integer index 1 read FResendCount write SetResendProp;

  // Number of milliseconds to wait before purging links. That is, the time it
  // takes for an idle client to be considered disconnected.
  property LinkTimeout: Integer read FLinkTimeout write SetLinkTimeout;

  // This event occurs when new data has been received.
  property OnReceive: TReceiveEvent read FOnReceive write FOnReceive;

  constructor Create();
  destructor Destroy(); override;

  function Initialize(): Boolean;
  procedure Finalize();

  function Send(Host: string; Port: Integer; Data: Pointer; Size: Integer;
   Guaranteed: Boolean): Boolean;

  function HostToDW(const Host: string): Longword;
  function HostToIP(const Host: string): string;
  function ResolveIP(const IPaddr: string): string;
  function GetLocalIP(): string;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
const
 WSAVerRequisite = $101;
 HeaderSize      = SizeOf(TPacketMsg) - 4;
 flagsGuaranteed = $00001010;
 flagsConfirm    = $00002020;

//---------------------------------------------------------------------------
constructor TNetCom.Create();
begin
 inherited;

 FInitialized:= False;
 FLocalPort  := 8876;
 hSocket     := INVALID_SOCKET;
 PacketMsg   := nil;
 FBufferSize := 4096 + HeaderSize;
 DecodeBody  := nil;
 FResendFreq := 2000;
 FResendCount:= 16;
 FLinkTimeout:= 30;

 // create a window handle that will receive network events
 hWindow:= Classes.AllocateHWND(WindowEvent);

 // guaranteed packet storage
 Packets:= TNetBufs.Create();
 Packets.BufferSize:= FBufferSize;

 // network connections
 Links:= TLinks.Create();

 // packet processing timer
 Timer:= TTimer.Create(nil);
 Timer.Enabled := False;
 Timer.Interval:= 500;
 Timer.OnTimer := TimerEvent;
end;

//---------------------------------------------------------------------------
destructor TNetCom.Destroy();
begin
 // terminate network activity
 if (FInitialized) then Finalize();

 FreeAndNil(Timer);

 // close the window handle
 Classes.DeallocateHWnd(hWindow);

 FreeAndNil(Packets);
 FreeAndNil(Links);

 inherited;
end;

//---------------------------------------------------------------------------
procedure TNetCom.SetLocalPort(const Value: Integer);
begin
 if (not FInitialized) then
  begin
   FLocalPort:= Value;
   if (FLocalPort < 0) then FLocalPort:= 0;
  end;
end;

//---------------------------------------------------------------------------
procedure TNetCom.SetBufferSize(const Value: Integer);
begin
 if (not FInitialized) then
  begin
   FBufferSize:= Value + HeaderSize;
   if (FBufferSize < 512) then FBufferSize:= 512;
   Packets.BufferSize:= FBufferSize;
  end;
end;

//---------------------------------------------------------------------------
function TNetCom.InitSock(): Boolean;
var
 Res: Integer;
 SockAddr: TSockAddrIn;
 dwOpt   : Longword;
begin
 // initialize the use of "WS2_32.DLL"
 Res:= WSAStartup(WSAVerRequisite, wSession);
 if (Res <> 0) then
  begin
   Result:= False;
   Exit;
  end;

 hSocket := Socket(PF_INET, SOCK_DGRAM, 0);
 if (hSocket = INVALID_SOCKET) then
  begin
   // release WinSock since we won't be needing it anymore
   WSACleanup();
   Result:= False;
   Exit;
  end;

 // allow broadcasting
 dwOpt:= Longword(True);
 SetSockOpt(hSocket, SOL_SOCKET, SO_BROADCAST, @dwOpt, SizeOf(dwOpt));

 // bind socket to the specified port
 FillChar(SockAddr, SizeOf(TSockAddrIn), 0);
 SockAddr.sin_port  := FLocalPort;
 SockAddr.sin_family:= AF_INET;
 Res:= Bind(hSocket, SockAddr, SizeOf(SockAddr));
 if (Res <> 0) then
  begin
   // close the opened socket and release WinSock
   CloseSocket(hSocket);
   WSACleanup();
   Result:= False;
   Exit;
  end;

 // retreive local port
 dwOpt:= SizeOf(SockAddr);
 GetSockName(hSocket, SockAddr, Integer(dwOpt));
 FLocalPort:= SockAddr.sin_port;

 // configure async mode
 Res:= WSAAsyncSelect(hSocket, hWindow, WM_SOCKET, FD_READ or FD_CLOSE);
 if (Res <> 0) then
  begin
   // close the opened socket and release WinSock
   CloseSocket(hSocket);
   WSACleanup();
   Result:= False;
   Exit;
  end;

 Result:= True;
end;

//---------------------------------------------------------------------------
procedure TNetCom.DoneSock();
begin
 // close the opened socket
 if (hSocket <> INVALID_SOCKET) then CloseSocket(hSocket);

 // release WinSock
 WSACleanup();
end;

//---------------------------------------------------------------------------
function TNetCom.Initialize(): Boolean;
begin
 // verify if already initialized
 if (FInitialized) then
  begin
   Result:= False;
   Exit;
  end;

 // initialize UDP socket
 Result:= InitSock();
 if (not Result) then Exit;

 // allocate message buffer
 PacketMsg  := AllocMem(FBufferSize);
 PacketBody := @PacketMsg.dpData;
 MaxBodySize:= FBufferSize - HeaderSize;
 DecodeBody := AllocMem(FBufferSize);

 Packets.Clear();
 Links.Clear();

 Timer.Enabled:= True;
 TimerTicks   := 0;

 FBytesPerSec  := 0;
 FBytesReceived:= 0;
 FBytesSent    := 0;
 BytesTransf   := 0;

 FInitialized:= True;
end;

//---------------------------------------------------------------------------
procedure TNetCom.Finalize();
begin
 if (FInitialized) then
  begin
   Timer.Enabled:= False;

   DoneSock();

   // release message buffer
   if (PacketMsg <> nil) then
    begin
     FreeMem(PacketMsg);
     PacketMsg  := nil;
     PacketBody := nil;
     MaxBodySize:= 0;
    end;

   if (DecodeBody <> nil) then
    begin
     FreeMem(DecodeBody);
     DecodeBody:= nil;
    end;

   Packets.Clear();
   Links.Clear();

   FInitialized:= False;
  end;
end;

//---------------------------------------------------------------------------
procedure TNetCom.WindowEvent(var Msg: TMessage);
begin
 if (Msg.Msg <> WM_SOCKET) then Exit;

 try
  Dispatch(Msg);
 except
  Application.HandleException(Self);
 end;
end;

//---------------------------------------------------------------------------
function TNetCom.HostToDW(const Host: string): Longword;
var
 Addr: Longword;
 HostEnt: PHostEnt;
begin
 StrPCopy(@StringBuf, Host);

 // check if the host is an IP address
 Addr:= inet_addr(StringBuf);
 if (Addr = Longword(INADDR_NONE)) then
  begin // not an IP, assume it's a DNS name
   HostEnt:= GetHostByName(StringBuf);
   if (HostEnt <> nil) then
    begin
     Result:= PLongword(HostEnt.h_addr_list^)^;
    end else Result:= Longword(INADDR_NONE);
  end else Result:= Addr;
end;

//---------------------------------------------------------------------------
function TNetCom.DWtoIP(const Address: Longword): string;
var
 s: string;
 pb: PByte;
begin
 pb:= @Address;
 s:= IntToStr(pb^) + '.';
 Inc(pb);
 s:= s + IntToStr(pb^) + '.';
 Inc(pb);
 s:= s + IntToStr(pb^) + '.';
 Inc(pb);
 s:= s + IntToStr(pb^);

 Result:= s;
end;

//---------------------------------------------------------------------------
function TNetCom.HostToIP(const Host: string): string;
var
 Addr: Longword;
begin
 Addr  := HostToDW(Host);
 Result:= DWtoIP(Addr);
end;

//---------------------------------------------------------------------------
function TNetCom.ResolveIP(const IPaddr: string): string;
var
 HostEnt: PHostEnt;
 Addr   : Longword;
begin
 Addr:= HostToDW(IPaddr);
 HostEnt:= GetHostByAddr(@Addr, 4, AF_INET);
 if (HostEnt <> nil) then Result:= HostEnt.h_name
  else Result:= DWtoIP(Longword(INADDR_NONE));
end;

//---------------------------------------------------------------------------
function TNetCom.Send(Host: string; Port: Integer; Data: Pointer;
 Size: Integer; Guaranteed: Boolean): Boolean;
var
 SockAddr: TSockAddrIn;
 Res, pIndex: Integer;
 pBody: Pointer;
begin
 // encode the incoming packet
 EncodePacket(Data, Size);

 // update links
 Links.Update(Host, Port);
 if (Guaranteed) then
  begin
   PacketMsg.dwMsgID:= Links.GetSendID(Host, Port);
   PacketMsg.dwFlags:= flagsGuaranteed;

   // add new packet to queque
   pIndex:= Packets.Add();

   // copy message body
   pBody:= @Packets[pIndex].Packet;
   Move(PacketMsg^, pBody^, PacketMsg.swSize);

   // packet parameters
   Packets[pIndex].Host     := Host;
   Packets[pIndex].Port     := Port;
   Packets[pIndex].MsgID    := PacketMsg.dwMsgID;
   Packets[pIndex].SendCount:= 0;
   Packets[pIndex].SendTime := GetTickCount();
  end else
  begin
   PacketMsg.dwMsgID:= Cardinal(-1);
   PacketMsg.dwFlags:= 0;
  end;

 // prepare datagram info
 FillChar(SockAddr, SizeOf(TSockAddrIn), 0);
 SockAddr.sin_family:= AF_INET;
 SockAddr.sin_addr.S_addr:= HostToDW(Host);
 SockAddr.sin_port:= Port;

 // send datagram
 Res:= SendTo(hSocket, PacketMsg^, PacketMsg.swSize, 0, SockAddr, SizeOf(TSockAddrIn));
 Result:= (Res = 0);

 Inc(FBytesSent, PacketMsg.swSize);
 Inc(BytesTransf, PacketMsg.swSize);
end;

//---------------------------------------------------------------------------
procedure TNetCom.Resend(Index: Integer);
var
 SockAddr: TSockAddrIn;
 pMsg: PPacketMsg;
begin
 pMsg:= @Packets[Index].Packet;
 Move(pMsg^, PacketMsg^, pMsg.swSize);

 // prepare datagram info
 FillChar(SockAddr, SizeOf(TSockAddrIn), 0);
 SockAddr.sin_family:= AF_INET;
 SockAddr.sin_addr.S_addr:= HostToDW(Packets[Index].Host);
 SockAddr.sin_port:= Packets[Index].Port;

 // send datagram
 SendTo(hSocket, PacketMsg^, PacketMsg.swSize, 0, SockAddr, SizeOf(TSockAddrIn));

 Links.Update(Packets[Index].Host, Packets[Index].Port);

 Inc(FBytesSent, PacketMsg.swSize);
 Inc(BytesTransf, PacketMsg.swSize);
end;

//---------------------------------------------------------------------------
procedure TNetCom.SendConfirm(Host: string; Port: Integer; MsgID: Cardinal);
var
 SockAddr: TSockAddrIn;
begin
 PacketMsg.dwMsgID:= MsgID;
 PacketMsg.dwFlags:= flagsConfirm;
 PacketMsg.swSize := HeaderSize;
 PacketMsg.swDataSize:= 0;

 // prepare datagram info
 FillChar(SockAddr, SizeOf(TSockAddrIn), 0);
 SockAddr.sin_family:= AF_INET;
 SockAddr.sin_addr.S_addr:= HostToDW(Host);
 SockAddr.sin_port:= Port;

 // send datagram
 SendTo(hSocket, PacketMsg^, PacketMsg.swSize, 0, SockAddr, SizeOf(TSockAddrIn));

 Inc(FBytesSent, PacketMsg.swSize);
 Inc(BytesTransf, PacketMsg.swSize);
end;

//---------------------------------------------------------------------------
procedure TNetCom.SocketEvent(var Msg: TWSEvent);
begin
 if (Msg.sError <> 0) then Exit;

 case Msg.sEvent of
  FD_READ : SockReceive();
  FD_CLOSE: if (FInitialized) then Finalize();
 end;
end;

//---------------------------------------------------------------------------
procedure TNetCom.SockReceive();
var
 SockAddr: TSockAddrIn;
 rBytes, AddrLen, FromPort: Integer;
 FromIP: string;
begin
 AddrLen:= SizeOf(TSockAddrIn);
 FillChar(SockAddr, AddrLen, 0);
 SockAddr.sin_family:= AF_INET;
 SockAddr.sin_port  := FLocalPort;

 // read the entire buffer
 rBytes:= RecvFrom(hSocket, PacketMsg^, FBufferSize, 0, SockAddr, AddrLen);
 if (rBytes <> PacketMsg.swSize) then Exit;

 Inc(FBytesReceived, rBytes);
 Inc(BytesTransf, rBytes);

 // get sender information
 FromPort:= SockAddr.sin_port;
 FromIP  := DWtoIP(SockAddr.sin_addr.S_addr);

 // determine what to do with this packet
 AnalyzePacket(FromIP, FromPort);
end;

//---------------------------------------------------------------------------
function TNetCom.GetLocalIP(): string;
type
 PInAddrs = ^TInAddrs;
 TInAddrs = array[WORD] of PInAddr;
var
 HostEnt: PHostEnt;
 Index  : Integer;
 InAddp : PInAddrs;
begin
 Result:= '127.0.0.1';

 GetHostName(StringBuf, SizeOf(StringBuf));
 HostEnt:= GetHostByName(StringBuf);
 if (HostEnt = nil) then Exit;

 Index:= 0;
 InAddp:= PInAddrs(HostEnt.h_addr_list);
 while (InAddp[Index] <> nil) do
  begin
   Result:= DWtoIP(InAddp[Index].S_addr);
   Inc(Index);
  end;
end;

//---------------------------------------------------------------------------
procedure TNetCom.EncodePacket(Data: Pointer; Size: Integer);
begin
 PacketMsg.swDataSize:= Size;
 PacketMsg.swSize:= CompressData(Data, PacketBody, Size, MaxBodySize,
  clLowest) + HeaderSize;
 PacketMsg.dwChecksum:= DataChecksum(PacketBody, PacketMsg.swSize - HeaderSize);
end;

//---------------------------------------------------------------------------
function TNetCom.DecodePacket(out Data: Pointer; out Size: Integer): Boolean;
var
 Checksum: Longword;
 OrigSize: Integer;
begin
 OrigSize:= PacketMsg.swSize - HeaderSize;

 // verify packet's checkum
 Checksum:= DataChecksum(PacketBody, OrigSize);
 Result:= (Checksum = PacketMsg.dwChecksum);

 DecompressData(PacketBody, DecodeBody, OrigSize, PacketMsg.swDataSize);
 Size:= PacketMsg.swDataSize;
 Data:= DecodeBody;
end;

//---------------------------------------------------------------------------
procedure TNetCom.AnalyzePacket(Host: string; Port: Integer);
var
 MayReceive: Boolean;
 Data: Pointer;
 Size: Integer;
begin
 // update the time of the host
 Links.Update(Host, Port);
 MayReceive:= True;

 // CONFIRM: remove the packet from queque
 if (PacketMsg.dwFlags = flagsConfirm) then
  begin
   Packets.RemoveID(PacketMsg.dwMsgID);
   Exit;
  end;

 // -> check if the packet is guaranteed and arrived twice
 if (PacketMsg.dwFlags = flagsGuaranteed) then
  if (Links.Confirmed(Host, Port, PacketMsg.dwMsgID)) then MayReceive:= False;

 // RECEIVE
 if (MayReceive) then
  begin
   // decode the packet
   if (DecodePacket(Data, Size))and(Assigned(FOnReceive)) then
    FOnReceive(Self, Host, Port, Data, Size);
  end;

 // GUARANTEED: confirm the packet
 if (PacketMsg.dwFlags = flagsGuaranteed) then
  SendConfirm(Host, Port, PacketMsg.dwMsgID);
end;

//---------------------------------------------------------------------------
function TNetCom.GetLinkDesc(): string;
begin
 Result:= Links.Desc;
end;

//---------------------------------------------------------------------------
procedure TNetCom.SetResendProp(const Index, Value: Integer);
begin
 if (FInitialized) then Exit;

 case Index of
  0: FResendFreq := Value;
  1: FResendCount:= Value;
 end;
end;

//---------------------------------------------------------------------------
procedure TNetCom.TimerEvent(Sender: TObject);
var
 i: Integer;
 CurTime: Cardinal;
begin
 CurTime := GetTickCount();

 for i:= Packets.Count - 1 downto 0 do
  if ((CurTime - Packets[i].SendTime) > Cardinal(FResendFreq)) then
   begin
    // resend the packet
    Resend(i);

    Packets[i].SendTime:= CurTime;
    Inc(Packets[i].SendCount);
    if (Packets[i].SendCount > FResendCount) then Packets.Remove(i);
   end;

 Links.Timeout(FLinkTimeout);

 Inc(TimerTicks);
 if (TimerTicks > 3) then
  begin
   FBytesPerSec:= BytesTransf div 2;
   BytesTransf:= 0;
  end; 
end;

//---------------------------------------------------------------------------
procedure TNetCom.SetLinkTimeout(const Value: Integer);
begin
 if (not FInitialized) then FLinkTimeout:= Value;
end;

//---------------------------------------------------------------------------
end.
