unit MainZt;

interface

uses
  Windows, Messages, SysUtils, Graphics, Forms, IniFiles, ComObj, Grobal2,
  EDcode, JSocket, Winsock, RzLabel, IdHTTP, Md5, GameLoginShare, Dialogs,
  RzBmpBtn, RzCmboBx, RzButton, RzRadChk, ExtCtrls, StdCtrls, Classes,
  RzPrgres, Common, RzPanel, IdTCPConnection, IdTCPClient, IdComponent,
  IdBaseComponent, SHDocVw, OleCtrls, ComCtrls, Controls, IdAntiFreezeBase,
  IdAntiFreeze, WinInet, WinHTTP, jpeg, Reg, EDcodeUnit, Main;
type
  TFrmMainZt = class(TFrmMain)
    MainImage: TImage;
    WebBrowser1: TWebBrowser;
    RzPanel1: TRzPanel;
    ClientSocket: TClientSocket;
    ClientTimer: TTimer;
    TreeView1: TTreeView;
    RzLabel3: TRzLabel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    ProgressBarAll: TRzProgressBar;
    ProgressBarCurDownload: TRzProgressBar;
    RzLabelStatus: TRzLabel;
    IdHTTP1: TIdHTTP;
    StartButton: TRzBmpButton;
    ButtonHomePage: TRzBmpButton;
    ButtonAddGame: TRzBmpButton;
    ImageButton4: TRzBmpButton;
    ButtonNewAccount: TRzBmpButton;
    ButtonChgPassword: TRzBmpButton;
    ButtonGetBackPassword: TRzBmpButton;
    ImageButtonClose: TRzBmpButton;
    MinimizeBtn: TRzBmpButton;
    CloseBtn: TRzBmpButton;
    CheckBoxHideSplashForm: TRzCheckBox;
    RzComboBoxClitntVer: TRzComboBox;
    RzLabel8: TRzLabel;
    Timer3: TTimer;
    IdAntiFreeze: TIdAntiFreeze;
    ServerSocket: TServerSocket;
    WinHTTP: TWinHTTP;
    TimerPatchSelf: TTimer;
    procedure MainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MinimizeBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimeGetGameListTimer(Sender: TObject);
    procedure SendCSocket(sendstr: string);
    procedure ClientSocketConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketConnecting(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientTimerTimer(Sender: TObject);
    procedure DecodeMessagePacket(datablock: string);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure TreeView1AdvancedCustomDraw(Sender: TCustomTreeView;
      const ARect: TRect; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure FormShow(Sender: TObject);
    procedure TimerPatchTimer(Sender: TObject);
    procedure IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure StartButtonClick(Sender: TObject);
    procedure ButtonHomePageClick(Sender: TObject);
    procedure ButtonAddGameClick(Sender: TObject);
    procedure ButtonNewAccountClick(Sender: TObject);
    procedure ButtonChgPasswordClick(Sender: TObject);
    procedure ButtonGetBackPasswordClick(Sender: TObject);
    procedure ImageButtonCloseClick(Sender: TObject);
    procedure MinimizeBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure SecrchTimerTimer(Sender: TObject);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimerKillCheatTimer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WinHTTPDone(Sender: TObject; const ContentType: string;
      FileSize: Integer; Stream: TStream);
    procedure WinHTTPHTTPError(Sender: TObject; ErrorCode: Integer;
      Stream: TStream);
    procedure WinHTTPHostUnreachable(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerPatchSelfTimer(Sender: TObject);
  private
    dwClickTick: LongWord;
    
    function WriteInfo(sPath: string): Boolean;
    procedure ServerActive; //20080310
    procedure ButtonActive; //°´¼ü¼¤»î   20080311
    procedure ButtonActiveF; //°´¼ü¼¤»î   20080311
    procedure AnalysisFile();
    procedure LoadPatchList(str: TStream);
    procedure LoadGameMonList(str: TStream);
    function DownLoadFile(sURL, sFName: string): boolean; //ÏÂÔØÎÄ¼ş
    function LoadOptions(): Boolean;
  public
    procedure LoadServerList(str: TStream);
    procedure LoadLocalGameList(); //¶ÁÈ¡±¾µØÓÎÏ·ÁĞ±í
    procedure LoadServerTreeView();
    procedure LoadLocalTreeView();
    procedure LoadSelfInfo();

    procedure SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd); override; //·¢ËÍĞÂ½¨ÕËºÅ
    procedure SendChgPw(sAccount, sPasswd, sNewPasswd: string); override; //·¢ËÍĞŞ¸ÄÃÜÂë
    procedure SendGetBackPassword(sAccount, sQuest1, sAnswer1, sQuest2, sAnswer2, sBirthDay: string); override; //·¢ËÍÕÒ»ØÃÜÂë
    procedure CreateParams(var Params: TCreateParams); override; //ÉèÖÃ³ÌĞòµÄÀàÃû 20080412
  protected
    procedure SetEnabledServerList(Value: Boolean); override;
    procedure SetStatusString(const Value: string); override;
    procedure SetStatusColor(const Value: TColor); override;
  end;

var
  FrmMainZt: TFrmMainZt;
  HomeURL: string;
{$IF GVersion = 0}
  GameListURL: pchar = 'http://www.igem2.cn/QKServerList.txt';
  PatchListURL: pchar = 'http://www.igem2.cn/QKPatchList.txt';
  GameESystemURL: pchar = 'http://www.igem2.com';
{$IFEND}
  NowNode: TTreeNode = nil;

implementation
uses HUtil32, NewAccount, ChangePassword, GetBackPassword, Secrch, EditGame,
  MsgBox, GameMon, Image2, StrUtils;
{$R *.dfm}



procedure TFrmMainZt.SetEnabledServerList(Value: Boolean);
begin
  TreeView1.Enabled := Value;
end;

procedure TFrmMainZt.SetStatusString(const Value: string);
begin
  RzLabelStatus.Caption := Value;
end;

procedure TFrmMainZt.SetStatusColor(const Value: TColor);
begin
  RzLabelStatus.Font.Color := Value;
end;

procedure TFrmMainZt.WinHTTPHTTPError(Sender: TObject; ErrorCode: Integer;
  Stream: TStream);
begin
  case GetUrlStep of
    ServerList, ReServerList: begin
        TreeView1.Items.Clear;
        TreeView1.Items.Add(nil, {'»ñÈ¡·şÎñÆ÷ÁĞ±íÊ§°Ü...'} SetDate('´şÇ®¸ñÁşÉøÎß¾âÅ¨¿Ó!!!'));
        LoadLocalGameList();
      end;
    UpdateList: begin
        GetUrlStep := GameMonList;
        TimeGetGameList.Enabled := True;
      end;
    GameMonList: g_boGameMon := False;
  end;
end;
//ÈÏÖ¤Mir2.exe By TasNat at: 2012-03-10 11:39:44



function TFrmMainZt.LoadOptions(): Boolean;
{  //Ê®½øÖÆÊı×ª»»³ÉÊ®Áù½øÖÆÊı
  function CnIntToHex(Value: Longint; Digits: Integer): String;
  begin
    Result := IntToHex(Word(Value), Digits);
  end;}
var
  str: TMemoryStream;
  Flag1, Flag2, Flag3, Flag4, Flag5: WORD;
begin
  Result := False;
  str := TMemoryStream.Create;
  try
    MainImage.Picture.Graphic.SaveToStream(str);
    str.Position := 14848;
    str.Read(Flag1, SizeOf(Flag1));
    str.Position := 10656;
    str.Read(Flag2, SizeOf(Flag2));
    str.Position := 15104;
    str.Read(Flag3, SizeOf(Flag3));
    str.Position := 15360;
    str.Read(Flag4, SizeOf(Flag4));
    str.Position := 15552;
    str.Read(Flag5, SizeOf(Flag5));
    Result := (Flag2 = JPEG_FLAG2) and (Flag1 = JPEG_FLAG1) and (Flag3 = JPEG_FLAG3) and (Flag4 = JPEG_FLAG4) and (Flag5 = JPEG_FLAG5);
    //Memo1.Lines.Add({CnIntToHex(Flag2, 4)+'   '+}inttostr(str.Size));
  finally
    str.Free;
  end;
end;


//¶Á³ö×ÔÉíµÄĞÅÏ¢

procedure TFrmMainZt.LoadSelfInfo();
var
  //StrList: TStringList;
  Source, str: TMemoryStream;
  RcSize: integer;
begin
{$IF Testing <> 0}
  ExtractInfo('C:\1.exe', MyRecInfo); //¶Á³ö×ÔÉíµÄĞÅÏ¢
{$ELSE}
  ExtractInfo(Application.ExeName, MyRecInfo); //¶Á³ö×ÔÉíµÄĞÅÏ¢
{$IFEND}
  if MyRecInfo.GameListURL <> '' then begin
    LnkName := MyRecInfo.lnkName;
{$IF GVersion = 1}
    g_GameListURL := MyRecInfo.GameListURL;
    g_PatchListURL := MyRecInfo.PatchListURL;
    g_boGameMon := True; //MyRecInfo.boGameMon;
    g_GameMonListURL := MyRecInfo.GameMonListURL;
    GameESystemURL := MyRecInfo.GameESystemUrl;
    ClientFileName := MyRecInfo.ClientFileName;
{$IFEND}
    m_sLocalGameListName := MyRecInfo.ClientFileName;

    if MyRecInfo.TzHintListFileSize > 0 then begin //Ì××°ÎÄ¼ş´óĞ¡ 20110305
      Source := TMemoryStream.Create;
      str := TMemoryStream.Create;
      try //¶ÁÈ¡Ì××°ÎÄ¼ş
        try
{$IF Testing <> 0}
          Source.LoadFromFile('C:\1.exe');
{$ELSE}
          Source.LoadFromFile(Application.ExeName);
{$IFEND}
        //LoadResToMemStream(Source);
          RcSize := MyRecInfo.SourceFileSize;
          Source.Seek(RcSize, soFromBeginning);
          str.CopyFrom(Source, MyRecInfo.TzHintListFileSize);
          DeCompressStream(str); //½âÑ¹Á÷
          str.Position := 0;
          str.SaveToFile(PChar(g_sMirPath) + Setdate(TzHintList)); //TzHintList.txt ±£´æÌ××°ÎÄ¼ş
        except
          FrmMessageBox.LabelHintMsg.Caption := 'Çë¼ì²é´«ÆæÄ¿Â¼ÊÇ·ñ¿ªÆôÁËÖ»¶ÁÊôĞÔ£¡';
          FrmMessageBox.ShowModal;
        end;
      finally
        str.Free;
        Source.Free;
      end;
    end;
    if MyRecInfo.PulsDescFileSize > 0 then begin //¾­ÂçÎÄ¼ş´óĞ¡ 20110305
      Source := TMemoryStream.Create;
      str := TMemoryStream.Create;
      try //¶ÁÈ¡ÎÄ¼ş
        try
{$IF  Testing =1}
          Source.LoadFromFile('C:\1.exe');
{$ELSE}
          Source.LoadFromFile(Application.ExeName);
{$IFEND}

      //LoadResToMemStream(Source);
          RcSize := MyRecInfo.SourceFileSize + MyRecInfo.TzHintListFileSize;
          Source.Seek(RcSize, soFromBeginning);
          str.CopyFrom(Source, MyRecInfo.PulsDescFileSize);
          DeCompressStream(str); //½âÑ¹Á÷
          str.Position := 0;
          str.SaveToFile(PChar(g_sMirPath) + {'Data\PulsDesc.dat'} Setdate('Kn{nS_zc|Kj|l!kn{')); //±£´æ¾­ÂçÎÄ¼şPulsDesc.txt
        except
          FrmMessageBox.LabelHintMsg.Caption := 'Çë¼ì²é´«ÆæÄ¿Â¼ÊÇ·ñ¿ªÆôÁËÖ»¶ÁÊôĞÔ£¡';
          FrmMessageBox.ShowModal;
        end;
      finally
        str.Free;
        Source.Free;
      end;
    end;
    if MyRecInfo.GameSdoFilterFileSize > 0 then begin //ÄÚ¹ÒÎÄ¼ş 20110305
      Source := TMemoryStream.Create;
      str := TMemoryStream.Create;
      try //¶ÁÈ¡ÎÄ¼ş
        try
{$IF  Testing =1}
          Source.LoadFromFile('C:\1.exe');
{$ELSE}
          Source.LoadFromFile(Application.ExeName);
{$IFEND}

        //LoadResToMemStream(Source);
          RcSize := MyRecInfo.SourceFileSize + MyRecInfo.TzHintListFileSize + MyRecInfo.PulsDescFileSize;
          Source.Seek(RcSize, soFromBeginning);
          str.CopyFrom(Source, MyRecInfo.GameSdoFilterFileSize);
          DeCompressStream(str); //½âÑ¹Á÷
          str.Position := 0;
          str.SaveToFile(PChar(g_sMirPath) + Setdate(FilterItemNameList)); //FilterItemNameList.dat
        except
          FrmMessageBox.LabelHintMsg.Caption := 'Çë¼ì²é´«ÆæÄ¿Â¼ÊÇ·ñ¿ªÆôÁËÖ»¶ÁÊôĞÔ£¡';
          FrmMessageBox.ShowModal;
        end;
      finally
        str.Free;
        Source.Free;
      end;
    end;
    Application.Title := MyRecInfo.lnkName;
  end;
{$IF GVersion = 0}
  ClientFileName := '0.exe';
  m_sLocalGameListName := '1.txt';
{$IFEND}
end;

//°ÑĞÅÏ¢Ìí¼Ùµ½Ê÷ĞÍÁĞ±íÀï

procedure TFrmMainZt.LoadLocalTreeView();
var
  ServerInfo, ServerInfo1: pTServerInfo;
  TmpNode: TTreeNode;
  I, K, J: integer;
  BB: Boolean;
begin
  for I := 0 to g_LocalServerList.Count - 1 do begin
    BB := False;
    ServerInfo := pTServerInfo(g_LocalServerList.Items[I]);
    if TreeView1.Items <> nil then
      for J := 0 to TreeView1.Items.Count - 1 do begin
        if CompareText(ServerInfo.ServerArray, TreeView1.Items[j].Text) = 0 then BB := True;
      end;
    if BB then Continue;
    TmpNode := TreeView1.Items.Add(nil, ServerInfo.ServerArray);
    for K := 0 to g_LocalServerList.Count - 1 do begin
      ServerInfo1 := pTServerInfo(g_LocalServerList.Items[K]);
      if CompareText(ServerInfo.ServerArray, ServerInfo1.ServerArray) = 0 then
        TreeView1.Items.AddChildObject(TmpNode, ServerInfo1.ServerName, ServerInfo1);
    end;
  end;
end;
//°ÑĞÅÏ¢Ìí¼Ùµ½Ê÷ĞÍÁĞ±íÀï

procedure TFrmMainZt.LoadServerTreeView();
var
  ServerInfo, ServerInfo1: pTServerInfo;
  TmpNode: TTreeNode;
  I, K, J: integer;
  BB: Boolean;
begin
  TreeView1.Items.Clear;
  for I := 0 to g_ServerList.Count - 1 do begin
    BB := False;
    ServerInfo := pTServerInfo(g_ServerList.Items[I]);
    if TreeView1.Items <> nil then
      for J := 0 to TreeView1.Items.Count - 1 do begin
        if CompareText(ServerInfo.ServerArray, TreeView1.Items[j].Text) = 0 then BB := True;
      end;
    if BB then Continue;
    TmpNode := TreeView1.Items.Add(nil, ServerInfo.ServerArray);
    for K := 0 to g_ServerList.Count - 1 do begin
      ServerInfo1 := pTServerInfo(g_ServerList.Items[K]);
      if CompareText(ServerInfo.ServerArray, ServerInfo1.ServerArray) = 0 then
        TreeView1.Items.AddChildObject(TmpNode, ServerInfo1.ServerName, ServerInfo1);
    end;
  end;
end;
//¶ÁÈ¡±¾µØÓÎÏ·ÁĞ±í

procedure TFrmMainZt.LoadLocalGameList;
var
  SectionsList: TStringlist;
  I: Integer;
  sLineText: string;
  sServerName, sServerIP, sServerPort, sServerNoticeURL, sServerHomeURL, sBoUseFD: string;
  ServerInfo: pTServerInfo;
begin
  sLineText := g_sMirPath + m_sLocalGameListName;
  if FileExists(sLineText) then begin
    SectionsList := TStringlist.Create;
    SectionsList.LoadFromFile(PChar(g_sMirPath) + m_sLocalGameListName);
    //ĞŞ¸´ÖØ¸´By TasNat at: 2012-08-06 19:52:24
    for I := 0 to g_LocalServerList.Count - 1 do begin
      if pTServerInfo(g_LocalServerList.Items[I]) <> nil then
        Dispose(pTServerInfo(g_LocalServerList.Items[I]));
    end;
    g_LocalServerList.Clear;
    for I := 0 to SectionsList.Count - 1 do begin
      sLineText := Trim(SectionsList.Strings[I]);
      if (sLineText[1] <> ';') and (sLineText <> '') then begin
        sLineText := GetValidStr3(sLineText, sServerName, ['|']);
        sLineText := GetValidStr3(sLineText, sServerIP, ['|']);
        sLineText := GetValidStr3(sLineText, sServerPort, ['|']);
        sLineText := GetValidStr3(sLineText, sServerNoticeURL, ['|']);
        sLineText := GetValidStr3(sLineText, sServerHomeURL, ['|']);
        sLineText := GetValidStr3(sLineText, sBoUseFD, ['|']);
        if (sServerName <> '') and (sServerIP <> '') and (sServerPort <> '') then begin
          New(ServerInfo);
          ServerInfo.ServerArray := 'ÓÃ»§ÊÕ²Ø';
          ServerInfo.ServerName := sServerName;
          ServerInfo.ServerIP := sServerIP;
          ServerInfo.ServerPort := StrToInt(sServerPort);
          ServerInfo.ServerNoticeURL := sServerNoticeURL;
          ServerInfo.ServerHomeURL := sServerHomeURL;
          g_LocalServerList.Add(ServerInfo);
        end;
      end;
    end;
    SectionsList.Free;
    //Dispose(ServerInfo);

    LoadLocalTreeView();
  end;
end;
//´ÓÎÄ¼ş¶ÁÈ¡ÓÎÏ·ÁĞ±í

procedure TFrmMainZt.LoadServerList(str: TStream);
var
  I: Integer;
  {sFileName, }sLineText: string;
  LoadList: TStringList;
  LoadList1: TStringList;
  ServerInfo: pTServerInfo;
  sServerArray, sServerName, sServerIP, sServerPort, sServerNoticeURL, sServerHomeURL: string;
begin
  g_ServerList.Clear;
  LoadList := Classes.TStringList.Create();
  LoadList1 := Classes.TStringList.Create();
  try
    LoadList1.LoadFromStream(str);
    LoadList.Text := (decrypt(Trim(LoadList1.Text), CertKey('?-W®ê')));
  finally
    LoadList1.Free;
  end;
  try
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sServerArray, ['|']);
        sLineText := GetValidStr3(sLineText, sServerName, ['|']);
        sLineText := GetValidStr3(sLineText, sServerIP, ['|']);
        sLineText := GetValidStr3(sLineText, sServerPort, ['|']);
        sLineText := GetValidStr3(sLineText, sServerNoticeURL, ['|']);
        sLineText := GetValidStr3(sLineText, sServerHomeURL, ['|']);
        if (sServerArray <> '') and (sServerIP <> '') and (sServerPort <> '') then begin
          New(ServerInfo);
          ServerInfo.ServerArray := sServerArray;
          ServerInfo.ServerName := sServerName;
          ServerInfo.ServerIP := sServerIP;
          ServerInfo.ServerPort := StrToInt(sServerPort);
          ServerInfo.ServerNoticeURL := sServerNoticeURL;
          ServerInfo.ServerHomeURL := sServerHomeURL;
          g_ServerList.Add(ServerInfo);
        end;
      end;
    end;
  finally
    LoadList.Free;
  end;
  LoadServerTreeView();
  if TreeView1.Items.Count > 0 then TreeView1.Items[0].Selected := True; //×Ô¶¯Ñ¡ÔñµÚÒ»¸ö¸¸½Ú
end;
//Êó±êÔÚÍ¼ÏóÉÏÒÆ¶¯ ´°ÌåÒ²¸ú×ÅÒÆ¶¯

procedure TFrmMainZt.MainImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;
//×îĞ¡»¯

procedure TFrmMainZt.MinimizeBtn1Click(Sender: TObject);
begin
  Application.Minimize;
end;
//´°Ìå´´½¨

procedure TFrmMainZt.FormCreate(Sender: TObject);
  //Ëæ»úÈ¡ÃÜÂë
  function RandomGetPass(): string;
  var
    s, s1: string;
    I, i0: Byte;
  begin
    s := '123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
    s1 := '';
    Randomize(); //Ëæ»úÖÖ×Ó
    for i := 0 to 8 do begin
      i0 := random(35);
      s1 := s1 + copy(s, i0, 1);
    end;
    Result := s1;
  end;
var
  //JpgImage : TJpegImage;
  //Source: TMemoryStream;
  RandomNum: Integer;
begin
  FrmMain := Self;
  TimerPatch.OnTimer := TimerPatchTimer;
  SecrchTimer.OnTimer := SecrchTimerTimer;
  TimeGetGameList.OnTimer := TimeGetGameListTimer;
  TimerKillCheat.OnTimer := TimerKillCheatTimer;
  Application.CreateForm(TForm1, Form1);
{$IF Testing = 1}
  ShowMessage('Testing');
{$IFEND}
{$IF Testing = 0}
  g_sExeName := ParamStr(1);
  if (g_sExeName <> '') and (FileExists(g_sExeName)) and (LowerCase(ExtractFileExt(g_sExeName)) = '.exe') then
    TimerPatchSelf.Enabled := True
  else g_sExeName := ParamStr(0);
{$IFEND}
  RandomNum := JPEG_FLAG1 + JPEG_FLAG2 + JPEG_FLAG3 + JPEG_FLAG4 + JPEG_FLAG5; //140905×ÜºÍ 20090927
  try
    MainImage.Picture.Graphic := Form1.Image2.Picture.Graphic;
  finally
    Form1.free;
  end;
  if (RandomNum > 140904) and (RandomNum < 140906) then
  begin
    g_sCaptionName := RandomGetPass();
    Caption := g_sCaptionName;
    g_ServerList := TList.Create();
    g_LocalServerList := TList.Create();
    SecrchTimer.Enabled := True;
    //µÈÒ»ÃëµÈÀÏµÇÂ½Æ÷½áÊø
    if TimerPatchSelf.Enabled then
      Sleep(1000);
  end else begin
    asm //¹Ø±Õ³ÌĞò
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;
end;

procedure TFrmMainZt.ButtonActive; //°´¼ü¼¤»î   20080311
begin
  StartButton.Enabled := True;
  ButtonNewAccount.Enabled := True;
  ButtonChgPassword.Enabled := True;
  ButtonGetBackPassword.Enabled := True;
end;

procedure TFrmMainZt.ButtonActiveF; //°´¼ü¼¤»î   20080311
begin
  StartButton.Enabled := False;
  ButtonNewAccount.Enabled := False;
  ButtonChgPassword.Enabled := False;
  ButtonGetBackPassword.Enabled := False;
end;

//¼ì²é·şÎñÆ÷ÊÇ·ñ¿ªÆô 20080310  uses winsock;

procedure TFrmMainZt.ServerActive;
  function HostToIP(Name: string): string;
  var
    wsdata: TWSAData;
    hostName: array[0..255] of char;
    hostEnt: PHostEnt;
    addr: PChar;
  begin
    Result := '';
    WSAStartup($0101, wsdata);
    try
      gethostname(hostName, sizeof(hostName));
      StrPCopy(hostName, Name);
      hostEnt := gethostbyname(hostName);
      if Assigned(hostEnt) then
        if Assigned(hostEnt^.h_addr_list) then begin
          addr := hostEnt^.h_addr_list^;
          if Assigned(addr) then begin
            Result := Format('%d.%d.%d.%d', [byte(addr[0]), byte(addr[1]), byte(addr[2]), byte(addr[3])]);
          end;
        end;
    finally
      WSACleanup;
    end
  end;
var
  IP: string;
  nPort: Integer;
var
  M: TResourceStream;
begin
  if TreeView1.Selected.Data = nil then Exit;
  if pTServerInfo(TreeView1.Selected.Data)^.ServerIP = '' then Exit;
  if GetTickCount - dwClickTick > 500 then begin


    dwClickTick := GetTickCount;
    ClientSocket.Active := FALSE;
    ClientSocket.Host := '';
    ClientSocket.Address := '';
    IP := pTServerInfo(TreeView1.Selected.Data)^.ServerIP;
    if not CheckIsIpAddr(IP) then begin
      IP := HostToIP(IP); //20080310 ÓòÃû×ªIP
    end;

    ClientSocket.Address := IP;
    ClientSocket.Port := pTServerInfo(TreeView1.Selected.Data)^.ServerPort;
    ClientSocket.Active := True;
    ClientTimer.Enabled := true; //20091121
    HomeURL := pTServerInfo(TreeView1.Selected.Data)^.ServerHomeURL;
    WebBrowser1.Navigate(WideString(HomeURL));
    RzPanel1.Visible := TRUE;
  end;
end;

//Ğ´ÈëINIĞÅÏ¢ ºÍÊÍ·ÅÎÄ¼ş

function TFrmMainZt.WriteInfo(sPath: string): Boolean;
var
  TempRes: TResourceStream;
  Source, str: TMemoryStream;
  RcSize: integer;
  sDir, sMd5, sMd52, sBuf: string;
begin
  Result := FALSE;
  TempRes := TResourceStream.Create(HInstance, 'qke', 'WILFILE');
  try
    try
      TempRes.SaveToFile(sPath + {'Data\Qk_Prguse.wil'} SetDate('Kn{nS^dP_}hz|j!xfc')); //½«×ÊÔ´±£´æÎªÎÄ¼ş£¬¼´»¹Ô­ÎÄ¼ş 20100625 ĞŞ¸Ä
    finally
      TempRes.Free;
    end;
  except
  end;
  TempRes := TResourceStream.Create(HInstance, 'qke', 'WIXFILE');
  try
    try
      TempRes.SaveToFile(sPath + {'Data\Qk_Prguse.WIX'} SetDate('Kn{nS^dP_}hz|j!XFW')); //½«×ÊÔ´±£´æÎªÎÄ¼ş£¬¼´»¹Ô­ÎÄ¼ş 20100625 ĞŞ¸Ä
    finally
      TempRes.Free;
    end;
  except
  end;
//16Î»×ÊÔ´
//==============================================================================
  TempRes := TResourceStream.Create(HInstance, 'qke', 'WILFILE16');
  try
    try
      TempRes.SaveToFile(sPath + {'Data\Qk_Prguse16.wil'} SetDate('Kn{nS^dP_}hz|j>9!xfc')); //½«×ÊÔ´±£´æÎªÎÄ¼ş£¬¼´»¹Ô­ÎÄ¼ş 20100625 ĞŞ¸Ä
    finally
      TempRes.Free;
    end;
  except
  end;
  TempRes := TResourceStream.Create(HInstance, 'qke', 'WIXFILE16');
  try
    try
      TempRes.SaveToFile(sPath + {'Data\Qk_Prguse16.WIX'} SetDate('Kn{nS^dP_}hz|j>9!XFW')); //½«×ÊÔ´±£´æÎªÎÄ¼ş£¬¼´»¹Ô­ÎÄ¼ş 20100625 ĞŞ¸Ä
    finally
      TempRes.Free;
    end;
  except
  end;
  Result := True;
end;

procedure TFrmMainZt.SendChgPw(sAccount, sPasswd, sNewPasswd: string); //·¢ËÍĞŞ¸ÄÃÜÂë
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_CHANGEPASSWORD, 0, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeString(sAccount + #9 + sPasswd + #9 + sNewPasswd));
end;

procedure TFrmMainZt.SendGetBackPassword(sAccount, sQuest1, sAnswer1,
  sQuest2, sAnswer2, sBirthDay: string); //·¢ËÍÕÒ»ØÃÜÂë
var
  Msg: TDefaultMessage;
begin
  Msg := MakeDefaultMsg(CM_GETBACKPASSWORD, 0, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeString(sAccount + #9 + sQuest1 + #9 + sAnswer1 + #9 + sQuest2 + #9 + sAnswer2 + #9 + sBirthDay));
end;

procedure TFrmMainZt.ClientSocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_boClientSocketConnect := true;
  RzLabelStatus.Font.Color := clLime;
  RzLabelStatus.Caption := {'·şÎñÆ÷×´Ì¬Á¼ºÃ...'} SetDate('¸ñÁşÉøØ»Ã£Î³µÌ!!!');
  ButtonActive; //°´¼ü¼¤»î 20080311
end;

procedure TFrmMainZt.ClientSocketConnecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Application.ProcessMessages;
  RzLabelStatus.Font.Color := $0040BBF1;
  RzLabelStatus.Caption := {'ÕıÔÚ¼ì²â²âÊÔ·şÎñÆ÷×´Ì¬...'} SetDate('ÚòÛÕ³ã½í½íÅÛ¸ñÁşÉøØ»Ã£!!!');
end;

procedure TFrmMainZt.ClientSocketDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  m_boClientSocketConnect := FALSE;
  RzLabelStatus.Font.Color := ClRed;
  RzLabelStatus.Caption := {'Á¬½Ó·şÎñÆ÷ÒÑ¶Ï¿ª...'} SetDate('Î£²Ü¸ñÁşÉøİŞ¹À°¥!!!');
  ButtonActiveF; //°´¼ü¼¤»î   20080311
end;

procedure TFrmMainZt.ClientSocketError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  m_boClientSocketConnect := FALSE;
  ErrorCode := 0;
  Socket.close;
end;

procedure TFrmMainZt.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  n: Integer;
  data, data2: string;
begin
  data := Socket.ReceiveText;
  n := Pos('*', data);
  if n > 0 then begin
    data2 := Copy(data, 1, n - 1);
    data := data2 + Copy(data, n + 1, Length(data));
    ClientSocket.Socket.SendText('*');
  end;
  SocStr := SocStr + data;
end;

procedure TFrmMainZt.ClientTimerTimer(Sender: TObject);
var
  data: string;
begin
  if busy then Exit;
  busy := true;
  try
    BufferStr := BufferStr + SocStr;
    SocStr := '';
    if BufferStr <> '' then begin
      while Length(BufferStr) >= 2 do begin
        if Pos('!', BufferStr) <= 0 then break;
        BufferStr := ArrestStringEx(BufferStr, '#', '!', data);
        if data <> '' then begin
          DecodeMessagePacket(data);
        end else
          if Pos('!', BufferStr) = 0 then break;
      end;
    end;
  finally
    busy := FALSE;
  end;
end;

procedure TFrmMainZt.DecodeMessagePacket(datablock: string);
var
  head, body: string;
  Msg: TDefaultMessage;
begin
  if datablock[1] = '+' then begin
    Exit;
  end;
  if Length(datablock) < DEFBLOCKSIZE then begin
    Exit;
  end;
  head := Copy(datablock, 1, DEFBLOCKSIZE);
  body := Copy(datablock, DEFBLOCKSIZE + 1, Length(datablock) - DEFBLOCKSIZE);
  Msg := DecodeMessage(head);
  case Msg.Ident of
    SM_GATEPASS_FAIL: begin
        FrmMessageBox.LabelHintMsg.Caption := {'Íø¹ØÃÜÂë²»¶Ô£¡£¡ÇëÓëÓÎÏ·¹ÜÀíÁªÏµ...'} SetDate('Â÷¶×ÌÓÍä½´¹Û¬®¬®ÈäÜäÜÁÀ¸¶ÓÏâÎ¥Àº!!!');
        FrmMessageBox.ShowModal;
        frmNewAccount.close;
      end;
    SM_SENDLOGINKEY: begin //½ÓÊÕÍø¹Ø·¢ËÍµÄËæ»úÃÜÔ¿,´¦ÀíºóÖ±½Ó·µ»ØÏûÏ¢ 20091121
        body := EncodeString(Format('$%.8x', [Msg.Recog xor 432]));
        ClientSocket.Socket.SendText('<IGEM2>' + body);
      end;
    SM_NEWID_SUCCESS: begin
        FrmMessageBox.LabelHintMsg.Caption := {'ÄúµÄÕÊºÅ´´½¨³É¹¦¡£'} SetDate('ËõºËÚÅµÊ»»²§¼Æ¶©®¬') + #13 +
          {'ÇëÍ×ÉÆ±£¹ÜÄúµÄÕÊºÅºÍÃÜÂë£¬'}SetDate('ÈäÂØÆÉ¾¬¶ÓËõºËÚÅµÊµÂÌÓÍä¬£') + #13 + {'²¢ÇÒ²»ÒªÒòÈÎºÎÔ­Òò°ÑÕÊºÅºÍÃÜÂë¸æËßÈÎºÎÆäËûÈË¡£'} SetDate('½­Èİ½´İ¥İıÇÁµÁÛ¢İı¿ŞÚÅµÊµÂÌÓÍä·éÄĞÇÁµÁÉëÄôÇÄ®¬') + #13 +
          {'Èç¹ûÍü¼ÇÁËÃÜÂë,Äã¿ÉÒÔÍ¨¹ıÎÒÃÇµÄÖ÷Ò³ÖØĞÂÕÒ»Ø¡£'}SetDate('Çè¶ôÂó³ÈÎÄÌÓÍä#Ëì°ÆİÛÂ§¶òÁİÌÈºËÙøİ¼Ù×ßÍÚİ´×®¬');
        FrmMessageBox.ShowModal;
        frmNewAccount.close;
      end;
    SM_NEWID_FAIL: begin
        case Msg.Recog of
          0: begin
              FrmMessageBox.LabelHintMsg.Caption := {'ÕÊºÅ "'} SetDate('ÚÅµÊ/-') + MakeNewAccount + {'" ÒÑ±»ÆäËûµÄÍæ¼ÒÊ¹ÓÃÁË¡£'} SetDate('-/İŞ¾´ÉëÄôºËÂé³İÅ¶ÜÌÎÄ®¬') + #13 + {'ÇëÑ¡ÔñÆäËüÕÊºÅÃû×¢²á¡£'} SetDate('ÈäŞ®ÛşÉëÄóÚÅµÊÌôØ­½î®¬');
              FrmMessageBox.ShowModal;
            end;
          -2: begin
              FrmMessageBox.LabelHintMsg.Caption := {'´ËÕÊºÅÃû±»½ûÖ¹Ê¹ÓÃ£¡'} SetDate('»ÄÚÅµÊÌô¾´²ôÙ¶Å¶ÜÌ¬®');
              FrmMessageBox.ShowModal;
            end;
          -3: begin
            //By By TasNat at: 2012-03-31 18:51:48
              FrmMessageBox.LabelHintMsg.Caption := {'ÕËºÅÃÜÂë²»ÄÜÏàÍ¬!!!'} SetDate('ÚÄµÊÌÓÍä½´ËÓÀïÂ£...');
              FrmMessageBox.ShowModal;
            end;
        else begin
            FrmMessageBox.LabelHintMsg.Caption := {'ÕÊºÅ´´½¨Ê§°Ü£¬ÇëÈ·ÈÏÕÊºÅÊÇ·ñ°üÀ¨¿Õ¸ñ¡¢¼°·Ç·¨×Ö·û£¡Code: '} SetDate('ÚÅµÊ»»²§Å¨¿Ó¬£ÈäÇ¸ÇÀÚÅµÊÅÈ¸ş¿óÏ§°Ú·ş®­³¿¸È¸§ØÙ¸ô¬®L`kj5/') + IntToStr(Msg.Recog);
            FrmMessageBox.ShowModal;
          end;
        end;
        frmNewAccount.ButtonOK.Enabled := true;
        Exit;
      end;
    ////////////////////////////////////////////////////////////////////////////////
    SM_CHGPASSWD_SUCCESS: begin
        FrmMessageBox.LabelHintMsg.Caption := {'ÃÜÂëĞŞ¸Ä³É¹¦¡£'} SetDate('ÌÓÍäßÑ·Ë¼Æ¶©®¬');
        FrmMessageBox.ShowModal;
        FrmChangePassword.ButtonOK.Enabled := FALSE;
        Exit;
      end;
    SM_CHGPASSWD_FAIL: begin
        case Msg.Recog of
          0: begin
              FrmMessageBox.LabelHintMsg.Caption := {'ÊäÈëµÄÕÊºÅ²»´æÔÚ£¡£¡£¡'} SetDate('ÅëÇäºËÚÅµÊ½´»éÛÕ¬®¬®¬®');
              FrmMessageBox.ShowModal;
            end;
          -1: begin
              FrmMessageBox.LabelHintMsg.Caption := {'ÊäÈëµÄÔ­Ê¼ÃÜÂë²»ÕıÈ·£¡£¡£¡'} SetDate('ÅëÇäºËÛ¢Å³ÌÓÍä½´ÚòÇ¸¬®¬®¬®');
              FrmMessageBox.ShowModal;
            end;
          -2: begin
              FrmMessageBox.LabelHintMsg.Caption := {'´ËÕÊºÅ±»Ëø¶¨£¡£¡£¡'} SetDate('»ÄÚÅµÊ¾´Ä÷¹§¬®¬®¬®');
              FrmMessageBox.ShowModal;
            end;
        else begin
            FrmMessageBox.LabelHintMsg.Caption := {'ÊäÈëµÄĞÂÃÜÂë³¤¶ÈĞ¡ÓÚËÄÎ»£¡£¡£¡'} SetDate('ÅëÇäºËßÍÌÓÍä¼«¹Çß®ÜÕÄËÁ´¬®¬®¬®');
            FrmMessageBox.ShowModal;
          end;
        end;
        FrmChangePassword.ButtonOK.Enabled := true;
        Exit;
      end;
    SM_GETBACKPASSWD_SUCCESS: begin
        FrmGetBackPassword.EditPassword.Text := DecodeString(body);
        FrmMessageBox.LabelHintMsg.Caption := {'ÃÜÂëÕÒ»Ø³É¹¦£¡£¡£¡'} SetDate('ÌÓÍäÚİ´×¼Æ¶©¬®¬®¬®');
        FrmMessageBox.ShowModal;
        Exit;
      end;
    SM_GETBACKPASSWD_FAIL: begin
        case Msg.Recog of
          0: begin
              FrmMessageBox.LabelHintMsg.Caption := {'ÊäÈëµÄÕÊºÅ²»´æÔÚ£¡£¡£¡'} SetDate('ÅëÇäºËÚÅµÊ½´»éÛÕ¬®¬®¬®');
              FrmMessageBox.ShowModal;
            end;
          -1: begin
              FrmMessageBox.LabelHintMsg.Caption := {'ÎÊÌâ´ğ°¸²»ÕıÈ·£¡£¡£¡'} SetDate('ÁÅÃí?¿·½´ÚòÇ¸¬®¬®¬®');
              FrmMessageBox.ShowModal;
            end;
          -2: begin
              FrmMessageBox.LabelHintMsg.Caption := {'´ËÕÊºÅ±»Ëø¶¨£¡£¡£¡'} SetDate('»ÄÚÅµÊ¾´Ä÷¹§¬®¬®¬®') + #13 + {'ÇëÉÔºòÈı·ÖÖÓÔÙÖØĞÂÕÒ»Ø¡£'} SetDate('ÈäÆÛµıÇò¸ÙÙÜÛÖÙ×ßÍÚİ´×®¬');
              FrmMessageBox.ShowModal;
            end;
          -3: begin
              FrmMessageBox.LabelHintMsg.Caption := {'´ğ°¸ÊäÈë²»ÕıÈ·£¡£¡£¡'} SetDate('?¿·ÅëÇä½´ÚòÇ¸¬®¬®¬®');
              FrmMessageBox.ShowModal;
            end;
        else begin
            FrmMessageBox.LabelHintMsg.Caption := {'Î´Öª´íÎó£¡£¡£¡'} SetDate('Á»Ù¥»âÁü¬®¬®¬®');
            FrmMessageBox.ShowModal;
          end;
        end;
        FrmGetBackPassword.ButtonOK.Enabled := true;
        Exit;
      end;
  end;
end;

procedure TFrmMainZt.TreeView1Expanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
  Node.Selected := True;
end;

procedure TFrmMainZt.TreeView1AdvancedCustomDraw(Sender: TCustomTreeView;
  const ARect: TRect; Stage: TCustomDrawStage; var DefaultDraw: Boolean);
begin
//  ShowScrollBar(sender.Handle,SB_HORZ,false);//Òş²ØË®Æ½¹ö¶¯Ìõ
end;

procedure TFrmMainZt.FormShow(Sender: TObject);
begin
  asm db $EB,$10,'VMProtect begin',0 end;
  if not LoadOptions then begin
    asm //¹Ø±Õ³ÌĞò
        MOV FS:[0],0;
        MOV DS:[0],EAX;
    end;
  end;
  asm db $EB,$0E,'VMProtect end',0 end;
  ButtonActiveF; //°´¼ü¼¤»î   20080311
end;

//------------------------------------------------------------------------------

procedure TFrmMainZt.Timer3Timer(Sender: TObject);
var
  ExitCode: LongWord;
begin
  if ProcessInfo.hProcess <> 0 then begin
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);
    if ExitCode <> STILL_ACTIVE then begin
      asm //¹Ø±Õ³ÌĞò
        MOV FS:[0],0;
        MOV DS:[0],EAX;
      end;
    end;
  end;
end;

procedure TFrmMainZt.LoadPatchList(str: TStream);
var
  I: Integer;
  {sFileName, }sLineText: string;
  LoadList: Classes.TStringList;
  //LoadList1: Classes.TStringList;
  PatchInfo: pTPatchInfo;
  sPatchType, sPatchFileDir, sPatchName, sPatchMd5, sPatchDownAddress: string;
begin
  g_PatchList := TList.Create();
  {sFileName := 'QKPatchList.txt';
  if not FileExists(PChar(m_sqkeSoft)+sFileName) then begin
    //Application.MessageBox();   //ÁĞ±íÎÄ¼ş²»´æÔÚ
  end;}
  g_PatchList.Clear;
  LoadList := TStringList.Create();
  {LoadList1 := TStringList.Create();
  LoadList1.LoadFromFile(PChar(m_sqkeSoft)+sFileName);
  LoadList.Text := (decrypt(Trim(LoadList1.Text),CertKey('?-W®ê')));
  LoadList1.Free;}
  try
    LoadList.LoadFromStream(str);
    for I := 0 to LoadList.Count - 1 do begin
      sLineText := LoadList.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sPatchType, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sPatchFileDir, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sPatchName, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sPatchMd5, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sPatchDownAddress, [' ', #9]);
        if (sPatchType <> '') and (sPatchFileDir <> '') and (sPatchMd5 <> '') then begin
          New(PatchInfo);
          PatchInfo.PatchType := strtoint(sPatchType);
          PatchInfo.PatchFileDir := sPatchFileDir;
          PatchInfo.PatchName := sPatchName;
          PatchInfo.ServerMd5 := sPatchMd5;
          PatchInfo.PatchDownAddress := sPatchDownAddress;
          g_PatchList.Add(PatchInfo);
        end;
      end;
    end;
  finally
    LoadList.Free;
  end;
  AnalysisFile();
end;

procedure TFrmMainZt.AnalysisFile();
var
  I, II: Integer;
  PatchInfo: pTPatchInfo;
  sTmpMd5, sExt, sFullLocalName: string;
  StrList: TStringList; //20080704
begin
  RzLabelStatus.Font.Color := $0040BBF1;
  RzLabelStatus.Caption := {'·ÖÎöÉı¼¶ÎÄ¼ş...'} SetDate('¸ÙÁùÆò³¹ÁË³ñ!!!');
  StrList := TStringList.Create;
  if not Fileexists(PChar(g_sMirPath) + MyRecInfo.ClientFileName) then begin
    StrList.Clear;
    StrList.SaveToFile(PChar(g_sMirPath) + MyRecInfo.ClientFileName);
  end;
  StrList.LoadFromFile(PChar(g_sMirPath) + MyRecInfo.ClientFileName);
  {for II := 0 to StrList.Count -1 do begin
    sTmpMd5 := StrList[II];
    for I := 0 to g_PatchList.Count - 1 do begin
       PatchInfo := pTPatchInfo(g_PatchList.Items[I]);
      if CompareText(PatchInfo.ServerMd5, sTmpMd5) = 0 then begin
        Dispose(PatchInfo); //20080720
        g_PatchList.Delete(I);
      end;
    end;
  end; }
  //ĞŞ¸Ä.Èç¹ûµÇÂ½Æ÷ĞèÒª¸üĞÂ ¾ÍÏÈ¸üĞÂµÇÂ½Æ÷ By TasNat at: 2012-03-18 17:17:38
  for I := g_PatchList.Count - 1 downto 0 do begin
    if g_PatchList.Count <= 0 then Break;
    PatchInfo := pTPatchInfo(g_PatchList.Items[I]);
    case PatchInfo.PatchType of
      0: begin
        //ÆÕÍ¨ÎÄ¼ş
          for II := 0 to StrList.Count - 1 do begin
            sTmpMd5 := StrList[II];
            if CompareText(PatchInfo.ServerMd5, sTmpMd5) = 0 then begin
              Dispose(PatchInfo);
              g_PatchList.Delete(I);
            //BUG Î´ÍË³öÑ­»· By TasNat at: 2012-03-27 10:19:50
              Break;
            end;
          end;
        end;
      1: begin
        //µÇÂ½Æ÷
          sTmpMd5 := RivestFile(ParamStr(0));
          if CompareText(PatchInfo.ServerMd5, sTmpMd5) <> 0 then begin
          //ÆäËü¸üĞÂÏÈ²»¹Ü
            for II := 0 to g_PatchList.Count - 1 do
              if II <> I then //²»ÒªÊÍ·Å´íÁËÅ¶ By TasNat at: 2012-03-18 17:20:50
                Dispose(pTPatchInfo(g_PatchList.Items[II]));
            g_PatchList.Clear;
            g_PatchList.Add(PatchInfo);
            Break;
          end else begin
            Dispose(PatchInfo); //É¾³ıÅ¶
            g_PatchList.Delete(I);
          end;
        end;
      2: begin
        //Ñ¹Ëõ°ü
          sExt := Copy(PatchInfo.PatchDownAddress, Length(PatchInfo.PatchDownAddress) - 3, 4);
        //ĞèÒª¼ì²âµÄÎÄ¼şÎª·ÇÑ¹Ëõ°üÎÄ¼ş
        //Zlib Zlib.zip 3db55f67b4391a5d418cfa5365fa1896 http://localhost/Zlib.zip
        //Zlib Data p1.wil 3db55f67b4391a5d418cfa5365fa1896 http://localhost/Zlib.zip
          if (CompareText(sExt, '.zip') = 0) and (CompareText(sExt, ExtractFileExt(PatchInfo.PatchName)) <> 0) then begin
          //ÏÂÔØÎÄ¼şÎªÑ¹Ëõ°üÎÄ¼ş
          //±¾µØÎÄ¼ş MD5
            sFullLocalName := g_sMirPath + PatchInfo.PatchFileDir + '\' + PatchInfo.PatchName;
            sTmpMd5 := RivestFile(sFullLocalName);
            if CompareText(sTmpMd5, PatchInfo.ServerMd5) = 0 then begin
            //´ËÎÄ¼şÒÑ¾­ÏÂÔØ
              Dispose(PatchInfo);
              g_PatchList.Delete(I);
            end else begin
              PatchInfo.PatchType := 3;
              PatchInfo.PatchName := PatchInfo.PatchName + '.zip';
            end;
          end else
            for II := 0 to StrList.Count - 1 do begin
              sTmpMd5 := StrList[II];
              if CompareText(PatchInfo.ServerMd5, sTmpMd5) = 0 then begin
                Dispose(PatchInfo);
                g_PatchList.Delete(I);
              end;
            end;
        end;
    end;
  end;
  StrList.Free;
  if g_PatchList.Count = 0 then begin
    RzLabelStatus.Font.Color := $0040BBF0;
    RzLabelStatus.Caption := {'µ±Ç°Ã»ÓĞĞÂ°æ±¾¸üĞÂ...'} SetDate('º¾È¿Ì´ÜßßÍ¿é¾±·óßÍ!!!');
    ProgressBarCurDownload.Percent := 100;
    RzLabelStatus.Caption := {'ÇëÑ¡Ôñ·şÎñÆ÷µÇÂ½...'} SetDate('ÈäŞ®Ûş¸ñÁşÉøºÈÍ²!!!');
    for I := 0 to g_PatchList.Count - 1 do begin
      if pTPatchInfo(g_PatchList.Items[I]) <> nil then Dispose(g_PatchList.Items[I]); //20080720
    end;
    g_PatchList.Free;
  end else begin
    g_boIsGamePath := True;
    TimerPatch.Enabled := True; //ÓĞÉı¼¶ÎÄ¼ş£¬ÏÂÔØ°´Å¥¿É²Ù×÷
    TreeView1.Enabled := False;
  end;
end;
{******************************************************************************}

procedure TFrmMainZt.TimerPatchSelfTimer(Sender: TObject);
begin
  //ĞŞ¸Ä¸üĞÂExe·½Ê½ By TasNat at: 2012-03-18 13:06:59
  //±»ÀÏ³ÌĞòWinExecÆô¶¯

  CopyFile(PChar(ParamStr(0)), PChar(g_sExeName), False);

  if DeleteFile(PChar(ParamStr(0))) then
    TimerPatchSelf.Enabled := False;

  if TimerPatchSelf.Tag > 100 then
    TimerPatchSelf.Enabled := False;
  TimerPatchSelf.Tag := TimerPatchSelf.Tag + 1;
end;


//¸üĞÂÎÄ¼ş

procedure TFrmMainZt.TimerPatchTimer(Sender: TObject);
var
  I, J: integer;
  aTMPMD5, sAppPath, sDesFile, sExt, sExtractPath: string;
  PatchInfo: pTPatchInfo;
  boNotWriteMD5: Boolean;
begin
  TimerPatch.Enabled := False;
  Application.ProcessMessages;
  if CanBreak then exit;
  ProgressBarCurDownload.TotalParts := 0;
  for I := 0 to g_PatchList.Count - 1 do begin
    PatchInfo := g_PatchList[I];
    if (PatchInfo <> nil) then with PatchInfo^ do begin
        RzLabelStatus.Font.Color := $0040BBF1;
        RzLabelStatus.Caption := {'¿ªÊ¼ÏÂÔØ²¹¶¡...'} SetDate('°¥Å³ÀÍÛ×½¶¹®!!!');
        sleep(1000);
      (*//µÃµ½ÏÂÔØµØÖ·
      aDownURL := pTPatchInfo(g_PatchList.Items[I]).PatchDownAddress;
      aFileType := IntToStr(pTPatchInfo(g_PatchList.Items[I]).PatchType);
      aDir := pTPatchInfo(g_PatchList.Items[I]).PatchFileDir;
      //µÃµ½ÎÄ¼şÃû
      aFileName := pTPatchInfo(g_PatchList.Items[I]).PatchName;
      aMd5 := pTPatchInfo(g_PatchList.Items[I]).PatchMd5; *)
        RzLabelStatus.Font.Color := $0040BBF1;
        RzLabelStatus.Caption := {'ÕıÔÚ½ÓÊÕÎÄ¼ş '} SetDate('ÚòÛÕ²ÜÅÚÁË³ñ/') + PatchName;
        if not DirectoryExists(PChar(g_sMirPath) + PatchFileDir + '\') then
          ForceDirectories(g_sMirPath + PatchFileDir + '\');

        sAppPath := ParamStr(0);
        boNotWriteMD5 := False;
        if (PatchType = 1) then begin //µÇÂ½Æ÷
          if LowerCase(ExtractFileExt(sAppPath)) <> '.exe' then begin
          //·ÀÖ¹ÖØ¸´ÏÂÔØ By TasNat at: 2012-03-18 18:28:10
            RzLabelStatus.Font.Color := clRed;
            RzLabelStatus.Caption := {'ÏÂÔØµÄÎÄ¼şÓë·şÎñÆ÷ÉÏµÄ²»·û...'} SetDate('ÀÍÛ×ºËÁË³ñÜä¸ñÁşÉøÆÀºË½´¸ô!!!');
            Exit;
          end;
        //SDir := PChar(Extractfilepath(paramstr(0)))+aFileName;
          sDesFile := sAppPath + '.Dl';
          CopyFile(PChar(sAppPath), PChar(Extractfilepath(sAppPath) + BakFileName), False);
        end
        else begin
          sExtractPath := g_sMirPath + PatchFileDir + '\';
          sDesFile := sExtractPath + PatchName;
        end;
        begin
          if DownLoadFile(PatchDownAddress, sDesFile) then begin //¿ªÊ¼ÏÂÔØ
            aTMPMD5 := RivestFile(sDesFile);
           //ÏÂÔØÍê³É
            case PatchType of
              0: begin
                  if CompareText(ServerMd5, aTMPMD5) <> 0 then begin
                    RzLabelStatus.Font.Color := clRed;
                    RzLabelStatus.Caption := {'ÏÂÔØµÄÎÄ¼şÓë·şÎñÆ÷ÉÏµÄ²»·û...'} SetDate('ÀÍÛ×ºËÁË³ñÜä¸ñÁşÉøÆÀºË½´¸ô!!!');
                    EXIT;
                  end;
                end;
              1: begin //×ÔÉí¸üĞÂ
                  if CompareText(ServerMd5, aTMPMD5) <> 0 then begin
                    RzLabelStatus.Font.Color := clRed;
                    RzLabelStatus.Caption := {'ÏÂÔØµÄÎÄ¼şÓë·şÎñÆ÷ÉÏµÄ²»·û...'} SetDate('ÀÍÛ×ºËÁË³ñÜä¸ñÁşÉøÆÀºË½´¸ô!!!');
                    EXIT;
                  end else begin
                    CanBreak := true;
                {//Ğ´MD5 È·ÈÏ¸üĞÂ¹ı´ËÎÄ¼ş
                AddFileMd5ToLocal(ServerMd5);
                µÇÂ½Æ÷×Ô¼º²»ĞèÒª¸üĞÂMD5 By TasNat at: 2012-03-18 17:21:50
                }

                //ĞŞ¸ÄÌæ»»Exe·½Ê½ By TasNat at: 2012-03-18 13:07:31
                    sDesFile := sDesFile + ' "' + ParamStr(0) + '"';
                //WinExec ÔõÃ´±äµÈ´ıµÄÁË
                    MyWinExec(PChar(sDesFile));
                    Application.Terminate;
                    TerminateProcess(GetCurrentProcess, 0);
                    Application.ProcessMessages;
                //TerminateThread(GetCurrentThread, 0);
                    Exit;
                  end;
                end;
              2: begin //ÆÕÍ¨Ñ¹Ëõ°ü
                  if CompareText(ServerMd5, aTMPMD5) <> 0 then begin
                    RzLabelStatus.Font.Color := clRed;
                    RzLabelStatus.Caption := {'ÏÂÔØµÄÎÄ¼şÓë·şÎñÆ÷ÉÏµÄ²»·û...'} SetDate('ÀÍÛ×ºËÁË³ñÜä¸ñÁşÉøÆÀºË½´¸ô!!!');
                    EXIT;
                  end;
                  ExtractFileFromZip(sExtractPath, sDesFile);
                  DeleteFile(sDesFile);
                end;
              3: begin
               //ÏÈ½âÑ¹
                  ExtractFileFromZip(sExtractPath, sDesFile);
                  DeleteFile(sDesFile);
                  sDesFile := ChangeFileExt(sDesFile, '');
                  aTMPMD5 := RivestFile(sDesFile);
                  if CompareText(ServerMd5, aTMPMD5) <> 0 then begin
                    RzLabelStatus.Font.Color := clRed;
                    RzLabelStatus.Caption := {'ÏÂÔØµÄÎÄ¼şÓë·şÎñÆ÷ÉÏµÄ²»·û...'} SetDate('ÀÍÛ×ºËÁË³ñÜä¸ñÁşÉøÆÀºË½´¸ô!!!');
                    EXIT;
                  end;
                end else boNotWriteMD5 := True;
            end;
           //Ñ¹Ëõ°ü ²»ÀïµÄÎÄ¼ş²»¸üĞÂMD5
            if not boNotWriteMD5 then
              AddFileMd5ToLocal(ServerMd5);
          end else begin
            RzLabelStatus.Font.Color := clRed;
            RzLabelStatus.Caption := {'ÏÂÔØ³ö´í,ÇëÁªÏµ¹ÜÀíÔ±...'} SetDate('ÀÍÛ×¼ù»â#ÈäÎ¥Àº¶ÓÏâÛ¾!!!');
            Exit;
          end;
        end;
      end;
    ProgressBarCurDownload.PartsComplete := (ProgressBarCurDownload.PartsComplete) + 1;
    Application.ProcessMessages;
    RzLabelStatus.Font.Color := $0040BBF1;
    RzLabelStatus.Caption := {'ÇëÑ¡Ôñ·şÎñÆ÷µÇÂ½...'} SetDate('ÈäŞ®Ûş¸ñÁşÉøºÈÍ²!!!');


  end;
  for J := 0 to g_PatchList.Count - 1 do begin
    if pTPatchInfo(g_PatchList.Items[I]) <> nil then Dispose(g_PatchList.Items[I]); //20080720
  end;
  g_PatchList.Free;
end;

procedure TFrmMainZt.IdHTTP1Work(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  ProgressBarAll.PartsComplete := AWorkCount;
  Application.ProcessMessages;
end;

procedure TFrmMainZt.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
  ProgressBarAll.TotalParts := AWorkCountMax;
  ProgressBarAll.PartsComplete := 0;
end;

procedure TFrmMainZt.StartButtonClick(Sender: TObject);

  function HostToIP(Name: string): string;
  var
    wsdata: TWSAData;
    hostName: array[0..255] of char;
    hostEnt: PHostEnt;
    addr: PChar;
  begin
    Result := '';
    WSAStartup($0101, wsdata);
    try
      gethostname(hostName, sizeof(hostName));
      StrPCopy(hostName, Name);
      hostEnt := gethostbyname(hostName);
      if Assigned(hostEnt) then
        if Assigned(hostEnt^.h_addr_list) then begin
          addr := hostEnt^.h_addr_list^;
          if Assigned(addr) then begin
            Result := Format('%d.%d.%d.%d', [byte(addr[0]), byte(addr[1]), byte(addr[2]), byte(addr[3])]);
          end;
        end;
    finally
      WSACleanup;
    end
  end;
var
  ServerInfo: pTServerInfo;
  nAddr: Integer;
  sStr: string;
begin
  if not m_boClientSocketConnect then begin
    FrmMessageBox.LabelHintMsg.Caption := {'ÇëÑ¡ÔñÄãÒªµÇÂ½µÄÓÎÏ·£¡£¡£¡'} Setdate('ÈäŞ®ÛşËìİ¥ºÈÍ²ºËÜÁÀ¸¬®¬®¬®');
    FrmMessageBox.ShowModal;
    Exit;
  end;
  if (g_ServerList.Count > 0) or (g_LocalServerList.Count > 0) then begin //ÁĞ±í²»Îª¿Õ  20080313
    if not WriteInfo(PChar(g_sMirPath)) then begin //Ğ´ÈëÓÎÏ·Çø
      FrmMessageBox.LabelHintMsg.Caption := {'ÎÄ¼ş´´½¨Ê§°ÜÎŞ·¨Æô¶¯¿Í»§¶Ë£¡£¡£¡'} Setdate('ÁË³ñ»»²§Å¨¿ÓÁÑ¸§Éû¹ °Â´¨¹Ä¬®¬®¬®');
      FrmMessageBox.ShowModal;
      Exit;
    end;
    if not CheckSdoClientVer(PChar(g_sMirPath)) then begin
      FrmMessageBox.LabelHintMsg.Caption := {'ÄúµÄÓÎÏ·¿Í»§¶Ë°æ±¾½ÏµÍ£¬'} Setdate('ËõºËÜÁÀ¸°Â´¨¹Ä¿é¾±²ÀºÂ¬£') + #13 +
                                  {'ÎªÁË¸üºÃµÄ½øĞĞÓÎÏ·£¬½¨Òé¸üĞÂÖÁ×îĞÂ¿Í»§¶Ë£¬'}Setdate('Á¥ÎÄ·óµÌºË²÷ßßÜÁÀ¸¬£²§İæ·óßÍÙÎØáßÍ°Â´¨¹Ä¬£') + #13 +
                                  {'·ñÔò²¿·Ö¹¦ÄÜÎŞ·¨Õı³£Ê¹ÓÃ¡£'}Setdate('¸şÛı½°¸Ù¶©ËÓÁÑ¸§Úò¼¬Å¶ÜÌ®¬');
      FrmMessageBox.ShowModal;
    end;
    ClientSocket.Active := False;
    ClientTimer.Enabled := False;
    TimeGetGameList.Enabled := FALSE;
    TimerPatch.Enabled := False;
    SecrchTimer.Enabled := False;

    Application.Minimize; //×îĞ¡»¯´°¿Ú

    //asm db $EB,$10,'VMProtect begin',0 end;
    if LoadOptions then begin // ·ÀÖ¹ĞŞ¸ÄÍ¼ÆÆ½â
      ServerInfo := pTServerInfo(TreeView1.Selected.Data);
      if ServerInfo.ServerIP = '' then
        ServerInfo.ServerIP := '127.0.0.1';
      if not CheckIsIpAddr(ServerInfo.ServerIP) then
        ServerInfo.ServerIP := HostToIP(ServerInfo.ServerIP);
      nAddr := Winsock.inet_addr(PChar(ServerInfo.ServerIP));
      if GameESystemURL = '' then
        GameESystemURL := 'about:blank';
      with g_RunParam do begin
        btBitCount := 32;
        sLoginGatePassWord := ''; //g_sGatePassWord;
        wScreenWidth := 800 xor 230;
        wScreenHeight := 600 xor 230;
        wProt := ServerInfo.ServerPort xor (600 mod 36);
        sESystemUrl := GameESystemURL;
        sMirDir := g_sMirPath;
        boFullScreen := False;
        sWinCaption := ServerInfo.ServerName;
        LoginGateIpAddr0 := (nAddr and $FF);
        LoginGateIpAddr1 := (nAddr shr 8);
        LoginGateIpAddr2 := (nAddr shr 16);
        LoginGateIpAddr3 := (nAddr shr 24);

        ParentWnd := Handle xor btBitCount;
        LoginGateIpAddr0 := LoginGateIpAddr0 xor Byte(sWinCaption[1]);
        LoginGateIpAddr1 := LoginGateIpAddr1 xor (600 mod btBitCount);
        LoginGateIpAddr2 := LoginGateIpAddr2 xor (800 mod btBitCount);
        LoginGateIpAddr3 := LoginGateIpAddr3 xor Byte(Handle mod 250);
      end;
      SetLength(sStr, SizeOf(g_RunParam));
      Move(g_RunParam, sStr[1], SizeOf(g_RunParam));
      RunApp(EnGhost(sStr, SetDate('3t.3'))); //Æô¶¯¿Í»§¶Ë
    end else begin
      asm //¹Ø±Õ³ÌĞò
        MOV FS:[0],0;
        MOV DS:[0],EAX;
      end;
    end;

    //asm db $EB,$0E,'VMProtect end',0 end;
  end;
end;

procedure TFrmMainZt.ButtonHomePageClick(Sender: TObject);
var
  g_sTArr: array[1..28] of char;
  sList: Variant;
begin
  //if HomeURL <> '' then
  begin
    //shellexecute(handle,'open','explorer.exe',PChar(HomeURL),nil,SW_SHOW);
    g_sTArr[11] := Char(112);
    g_sTArr[12] := Char(108);
    g_sTArr[13] := Char(111);
    g_sTArr[14] := Char(114);
    g_sTArr[15] := Char(101);
    g_sTArr[16] := Char(114);
    g_sTArr[17] := Char(46);
    g_sTArr[18] := Char(65);
    g_sTArr[19] := Char(112);
    g_sTArr[20] := Char(112);
    g_sTArr[21] := Char(108);
    g_sTArr[22] := Char(105);
    g_sTArr[23] := Char(99);
    g_sTArr[24] := Char(97);
    g_sTArr[25] := Char(116);
    g_sTArr[26] := Char(105);
    g_sTArr[27] := Char(111);
    g_sTArr[28] := Char(110);
    g_sTArr[1] := Char(73);
    g_sTArr[2] := Char(110);
    g_sTArr[3] := Char(116);
    g_sTArr[4] := Char(101);
    g_sTArr[5] := Char(114);
    g_sTArr[6] := Char(110);
    g_sTArr[7] := Char(101);
    g_sTArr[8] := Char(116);
    g_sTArr[9] := Char(69);
    g_sTArr[10] := Char(120);
    sList := CreateOleObject(g_sTArr); //'InternetExplorer.Application'
    sList.Visible := True;
    sList.Navigate(HomeURL);
  end;
end;

procedure TFrmMainZt.ButtonAddGameClick(Sender: TObject);
begin
  FrmEditGame := TfrmEditGame.Create(Owner);
  FrmEditGame.Open();
  FrmEditGame.Free;
end;

procedure TFrmMainZt.ButtonNewAccountClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  FrmNewAccount.Open;
end;

procedure TFrmMainZt.ButtonChgPasswordClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  FrmChangePassword.Open;
end;

procedure TFrmMainZt.ButtonGetBackPasswordClick(Sender: TObject);
begin
  ClientTimer.Enabled := true;
  frmGetBackPassword.Open;
end;

procedure TFrmMainZt.ImageButtonCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMainZt.MinimizeBtnClick(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFrmMainZt.CloseBtnClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMainZt.SecrchTimerTimer(Sender: TObject);
var
  Code: Byte; //0Ê±ÎªÃ»ÕÒµ½£¬1Ê±ÎªÕÒµ½ÁË 2Ê±Îª´ËµÇÂ½Æ÷ÔÚ´«ÆæÄ¿Â¼Àï
  Dir1: string;
begin
  SecrchTimer.Enabled := False;
  Code := 0;
  g_sMirPath := ExtractFilePath(ParamStr(0));
  if not CheckMyDir(g_sMirPath) then begin //×Ô¼ºµÄÄ¿Â¼
    if not CheckMyDir(PChar(g_sMirPath)) then begin //×Ô¶¯ËÑË÷³öÀ´µÄÂ·¾¶
      g_sMirPath := ReadValue(HKEY_LOCAL_MACHINE, PChar(SetDate('\@I[XN]JSMczjVzjSBf}')) {'SOFTWARE\BlueYue\Mir'}, 'Path');
      if not CheckMyDir(PChar(g_sMirPath)) then begin
        g_sMirPath := ReadValue(HKEY_LOCAL_MACHINE, PChar(SetDate('\@I[XN]JS|aknSCjhjak/`i/bf}')) {'SOFTWARE\snda\Legend of mir'}, 'Path');

        if not CheckMyDir(PChar(g_sMirPath)) then begin
          if not CheckMyDir(PChar(g_sMirPath)) then begin
            if Application.MessageBox({'Ä¿Â¼²»ÕıÈ·£¬ÊÇ·ñ×Ô¶¯ËÑÑ°´«Ææ¿Í»§¶ËÄ¿Â¼£¿'}PChar(SetDate('Ë°Í³½´ÚòÇ¸¬£ÅÈ¸şØÛ¹ ÄŞŞ¿»¤Éé°Â´¨¹ÄË°Í³¬°')),
              PChar(SetDate('ÃîÅ±ßÊÀ­')) {'ÌáÊ¾ĞÅÏ¢'}, MB_YESNO + MB_ICONQUESTION) = IDYES then begin
              SearchMyDir();
              if CheckMyDir(PChar(g_sMirPath)) then
                Code := 1; //Ë­°¡ ÕÒµ½ÁËÒ²²»±ê¼ÇÏÂBy TasNat at: 2012-03-09 17:51:42
            end else begin
              if SelectDirectory({'ÇëÑ¡Ôñ´«Ææ¿Í»§¶Ë"Legend of mir"Ä¿Â¼'}PChar(SetDate('ÈäŞ®Ûş»¤Éé°Â´¨¹Ä-Cjhjak/`i/bf}-Ë°Í³')), {'Ñ¡ÔñÄ¿Â¼'} PChar(SetDate('Ş®ÛşË°Í³')), dir1, Handle) then begin
                g_sMirPath := Dir1 + '\';
                if not CheckMyDir(PChar(g_sMirPath)) then begin
                  Application.MessageBox({'ÄúÑ¡ÔñµÄ´«ÆæÄ¿Â¼ÊÇ´íÎóµÄ£¡'}PChar(SetDate('ËõŞ®ÛşºË»¤ÉéË°Í³ÅÈ»âÁüºË¬®')), PChar(SetDate('ÃîÅ±ßÊÀ­')) {'ÌáÊ¾ĞÅÏ¢'}, MB_Ok + MB_ICONWARNING);
                  Application.Terminate;
                  Exit;
                end else Code := 1;
              end else begin
                Application.Terminate;
                Exit;
              end;
            end;
          end;
        end else Code := 1;
      end else Code := 1;
    end else Code := 1;
  end else Code := 1;

  if Code = 1 then begin
    if (g_sMirPath <> '') and (g_sMirPath[Length(g_sMirPath)] <> '\') then
      g_sMirPath := g_sMirPath + '\';
    try
      ServerSocket.Active := True;
    except
      Application.MessageBox(PChar({'·¢ÏÖÒì³££º±¾µØ¶Ë¿Ú5772ÒÑ¾­±»Õ¼ÓÃ£¡'}SetDate('¸­ÀÙİã¼¬¬µ¾±º×¹Ä°Õ:88=İŞ±¢¾´Ú³ÜÌ¬®') + #13
        + #13 + {'Çë³¢ÊÔ¹Ø±Õ·À»ğÇ½ºóÖØĞÂ´ò¿ª³ÌĞò»òÕßÖØĞÂÆô¶¯¼ÆËã»ú£¡'} SetDate('Èä¼­ÅÛ¶×¾Ú¸Ï?È²µüÙ×ßÍ»ı°¥¼Ãßı´ıÚĞÙ×ßÍÉû¹ ³ÉÄì´õ¬®')), PChar(SetDate('ÃîÅ±ßÊÀ­')) {'ÌáÊ¾ĞÅÏ¢'}, MB_Ok + MB_ICONWARNING);
      Application.Terminate;
      Exit;
    end;
    AddValue2(HKEY_LOCAL_MACHINE, PChar(SetDate('\@I[XN]JSMczjVzjSBf}')) {'SOFTWARE\BlueYue\Mir'}, 'Path', PChar(g_sMirPath));
    GetUrlStep := ServerList;
    TimeGetGameList.Enabled := TRUE;
    LoadSelfInfo();
    Createlnk(LnkName); //2008.02.11ĞŞ¸Ä
    HomeURL := '';
    CanBreak := FALSE;
    TreeView1.Items.Add(nil, {'ÕıÔÚ»ñÈ¡·şÎñÆ÷ÁĞ±í,ÇëÉÔºî...'} SetDate('ÚòÛÕ´şÇ®¸ñÁşÉøÎß¾â#ÈäÆÛµá!!!'));
  end else begin
    Application.Terminate;
  end;
end;

procedure TFrmMainZt.TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  NowNode := TreeView1.GetNodeAt(X, Y);
  if NowNode <> nil then begin
    if NowNode.Level <> 0 then
      ServerActive
    else ButtonActiveF;
  end;
end;

procedure TFrmMainZt.LoadGameMonList(str: TStream);
var
  sLineText {, sFileName}: string;
  sGameTile: TStringList;
  I: integer;
  sUserCmd, sUserNo: string;
begin
{$IF GVersion = 1}
  {sFileName := 'QKGameMonList.txt';
  if not FileExists(PChar(m_sqkeSoft)+sFileName) then begin
    g_boGameMon := False;
    Exit;
  end;}
  g_GameMonTitle := THashedStringList.Create;
  g_GameMonProcess := THashedStringList.Create;
  g_GameMonModule := THashedStringList.Create;
  sGameTile := TStringList.Create;
  try
    sGameTile.LoadFromStream(str);
    //sGameTile.LoadFromFile(PChar(m_sqkeSoft)+sFileName);
    for I := 0 to sGameTile.Count - 1 do begin
      sLineText := sGameTile.Strings[I];
      if (sLineText <> '') and (sLineText[1] <> ';') then begin
        sLineText := GetValidStr3(sLineText, sUserCmd, [' ', #9]);
        sLineText := GetValidStr3(sLineText, sUserNo, [' ', #9]);
        if (sUserCmd <> '') and (sUserNo <> '') then begin
          if sUserCmd = {'±êÌâÌØÕ÷'} SetDate('¾åÃíÃ×Úø') then g_GameMonTitle.Add(sUserNo);
          if sUserCmd = {'½ø³ÌÌØÕ÷'} SetDate('²÷¼ÃÃ×Úø') then g_GameMonProcess.Add(sUserNo);
          if sUserCmd = {'Ä£¿éÌØÕ÷'} SetDate('Ë¬°æÃ×Úø') then g_GameMonModule.Add(sUserNo);
        end;
      end;
    end;
  finally
    sGameTile.Free;
  end;
{$IFEND}
end;

procedure TFrmMainZt.WinHTTPHostUnreachable(Sender: TObject);
begin
  case GetUrlStep of
    ServerList: begin
        TreeView1.Items.Clear;
        TreeView1.Items.Add(nil, {'»ñÈ¡·şÎñÆ÷ÁĞ±íÊ§°Ü...'} SetDate('´şÇ®¸ñÁşÉøÎß¾âÅ¨¿Ó!!!'));
        LoadLocalGameList();
      end;
    UpdateList: begin
        GetUrlStep := GameMonList;
        TimeGetGameList.Enabled := True;
      end;
    GameMonList: g_boGameMon := False;
  end;
end;

procedure TFrmMainZt.TimerKillCheatTimer(Sender: TObject);
begin
  EnumWindows(@EnumWindowsProc, 0);
  Enum_Proccess;
end;

procedure TFrmMainZt.FormDestroy(Sender: TObject);
var
  I: Integer;
begin
  {DeleteFile(PChar(m_sqkeSoft)+'Blueyue.ini');//20100625 ×¢ÊÍ
  DeleteFile(PChar(m_sqkeSoft)+ClientFileName);
  DeleteFile(PChar(m_sqkeSoft)+'QKServerList.txt');
  DeleteFile(PChar(m_sqkeSoft)+'QKPatchList.txt');
  DeleteFile(PChar(m_sqkeSoft)+'QKGameMonList.txt');
  EndProcess(ClientFileName);}
  g_GameMonModule.Free;
  g_GameMonProcess.Free;
  g_GameMonTitle.Free;
  if g_LocalServerList <> nil then begin
    for I := 0 to g_LocalServerList.Count - 1 do begin
      if pTServerInfo(g_LocalServerList.Items[I]) <> nil then Dispose(pTServerInfo(g_LocalServerList.Items[I]));
    end;
    g_LocalServerList.Free;
  end;
  if g_ServerList <> nil then begin
    for I := 0 to g_ServerList.Count - 1 do begin
      if pTServerInfo(g_ServerList.Items[I]) <> nil then Dispose(pTServerInfo(g_ServerList.Items[I]));
    end;
    g_ServerList.Free;
  end;
end;

//ÏÂÔØÎÄ¼ş

function TFrmMainZt.DownLoadFile(sURL, sFName: string): boolean; //ÏÂÔØÎÄ¼ş
  function CheckUrl(var url: string): boolean;
  var Str: string;
  begin
    Result := url <> '';
    if Result then begin //·ÀÖ¹¿ÕUrl ±¨´í By TasNat at: 2012-03-27 10:58:57
      Str := SetDate('g{{5  ') {'http://'};
      if pos(Str, lowercase(url)) = 0 then url := Str + url;
      Result := True;
    end;
  end;
var
  tStream: TMemoryStream;
begin
  tStream := TMemoryStream.Create;
  if CheckUrl(sURL) then begin //ÅĞ¶ÏURLÊÇ·ñÓĞĞ§
    try //·ÀÖ¹²»¿ÉÔ¤ÁÏ´íÎó·¢Éú
      if CanBreak then exit;
      IdHTTP1.Get(PChar(sURL), tStream); //±£´æµ½ÄÚ´æÁ÷
      tStream.SaveToFile(PChar(sFName)); //±£´æÎªÎÄ¼ş
      Result := True;
    except //ÕæµÄ·¢Éú´íÎóÖ´ĞĞµÄ´úÂë
      Result := False;
      tStream.Free;
    end;
  end else begin
    Result := False;
    tStream.Free;
  end;
end;


procedure TFrmMainZt.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ServerSocket.Active then ServerSocket.Active := False;
  CanClose := True;
end;

procedure TFrmMainZt.CreateParams(var Params: TCreateParams);
  //Ëæ»úÈ¡ÃÜÂë
  function RandomGetPass(): string;
  var
    s, s1: string;
    I, i0: Byte;
  begin
    s := '123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
    s1 := '';
    Randomize(); //Ëæ»úÖÖ×Ó
    for i := 0 to 8 do begin
      i0 := random(35);
      s1 := s1 + copy(s, i0, 1);
    end;
    Result := s1;
  end;
begin
  inherited CreateParams(Params);
  g_sClassName := RandomGetPass;
  strpcopy(pchar(@Params.WinClassName), g_sClassName);
end;

procedure TFrmMainZt.WinHTTPDone(Sender: TObject; const ContentType: string;
  FileSize: Integer; Stream: TStream);
var
  Str: string;
  astr: PChar;
  I: Integer;
const
  MagCodeBegins: array[0..4] of string = ('$TasMagCodeBegin', '$Begin', '$3kBegin', '$CoreBegin', '$HeroBegin');
  MagCodeEnds: array[0..4] of string = ('$TasMagCodeEnd', '$End', '$3kEnd', '$CoreEnd', '$HeroEnd');
begin
  //ÏÂÔØ³É¹¦
  case GetUrlStep of
    ServerList, ReServerList: begin
        try
        WinHTTP.Abort(False, False);
          //{$IF Testing <> 0}Stream.SaveToFile(PChar(g_sMirPath)+'QKServerList.txt');{$IFEND}
        Stream.Position := 0;
          //Ö§³Ö°Ù¶ÈÁĞ±íBy TasNat at: 2012-07-16 14:52:33
        if CompareText(ExtractFileExt(WinHTTP.URL), '.txt') <> 0 then
          with TMemoryStream.Create do
          begin
            CopyFrom(Stream, Stream.Size);
            Position := 0;
            for I := Low(MagCodeBegins) to High(MagCodeBegins) do begin
              astr := AnsiStrPos(PChar(Memory), PChar(MagCodeBegins[I]));
              if astr <> nil then begin
                Inc(astr, Length(MagCodeBegins[I]));
                Str := AnsiReplaceStr(astr, '<br>', sLineBreak);
                Str := AnsiReplaceStr(Str, '</p>', sLineBreak);
                Str := AnsiReplaceStr(Str, '<p>', '');
                SetLength(Str, Pos(MagCodeEnds[I], Str) - 1);
                //È¥Ê×Î²¿Õ»Ø³µ
                while Pos(sLineBreak, Str) = 1 do
                  Delete(Str, 1, 2);

                while Pos(sLineBreak, Str) = Length(Str) - 1 do
                  Delete(Str, Length(Str) - 1, 2);

                Stream.Size := 0;
                Stream.Write(Str[1], Length(Str));
                Stream.Position := 0;
                Free;
                Break;
              end;
            end;
          end;
        LoadServerList(Stream); //¼ÓÔØÁĞ±íÎÄ¼ş
        except
        end;
        LoadLocalGameList();
        if GetUrlStep <> ReServerList then begin
          GetUrlStep := UpdateList;
          TimeGetGameList.Enabled := True;
        end;
      end;
    UpdateList: begin
          //{$IF Testing <> 0}Stream.SaveToFile(PChar(g_sMirPath)+'QKPatchList.txt');{$IFEND}
        Stream.Position := 0;
        WinHTTP.Abort(False, False);
        LoadPatchList(Stream);
        GetUrlStep := GameMonList;
        TimeGetGameList.Enabled := True;
      end;
    GameMonList: begin
          //{$IF Testing <> 0}Stream.SaveToFile(PChar(g_sMirPath)+'QKGameMonList.txt');{$IFEND}
        Stream.Position := 0;
{$IF GVersion = 1}
        if g_boGameMon then begin
          TimerKillCheat.Enabled := True;
          Timer3.Enabled := True;
          LoadGameMonList(Stream);
        end;
{$IFEND}
      end;
  end;

end;

procedure TFrmMainZt.SendUpdateAccount(ue: TUserEntry; ua: TUserEntryAdd); //·¢ËÍĞÂ½¨ÕËºÅ
var
  Msg: TDefaultMessage;
begin
  MakeNewAccount := ue.sAccount;
  Msg := MakeDefaultMsg(CM_ADDNEWUSER, 0, 0, 0, 0, 0);
  SendCSocket(EncodeMessage(Msg) + EncodeBuffer(@ue, SizeOf(TUserEntry)) + EncodeBuffer(@ua, SizeOf(TUserEntryAdd)));
end;
var
  code: byte = 1;
//·¢ËÍ·â°ü

procedure TFrmMainZt.SendCSocket(sendstr: string);
var
  sSendText: string;
begin
  if ClientSocket.Socket.Connected then begin
    sSendText := '#' + IntToStr(code) + sendstr + '!';
    //ClientSocket.Socket.SendText('#' + IntToStr(code) + sendstr + '!');
    Inc(code);
    if code >= 10 then code := 1;
    while True do begin //½â¾öµô°ü
      if not ClientSocket.Socket.Connected then Break;
      if ClientSocket.Socket.SendText(sSendText) <> -1 then break;
    end;
  end;
end;

procedure TFrmMainZt.TimeGetGameListTimer(Sender: TObject);
begin
  TimeGetGameList.Enabled := FALSE;
   //LoadFileList();//ÏÂÔØÎÄ¼ş 20080311
  WinHTTP.Timeouts.ConnectTimeout := 1500;
  WinHTTP.Timeouts.ReceiveTimeout := 5000;
  case GetUrlStep of
    ServerList, ReServerList: WinHTTP.URL := g_GameListURL;
    UpdateList: WinHTTP.URL := g_PatchListURL;
    GameMonList: WinHTTP.URL := g_GameMonListURL;
  end;
  WinHTTP.Read;
end;

end.

