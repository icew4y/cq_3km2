unit Main;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,Messages,
  Menus, ComCtrls, StdCtrls, ExtCtrls, JSocket, SyncObjs, Grobal2, Share,
  EDcode, Common, IniFiles,Dialogs, jpeg, EDcodeUnit, RSA;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    LbTransCount: TLabel;
    Label2: TLabel;
    MemoLog: TMemo;
    Panel2: TPanel;
    ListView: TListView;
    DecodeTimer: TTimer;
    ServerSocket: TServerSocket;
    MainMenu: TMainMenu;
    T2: TMenuItem;
    MENU_CONTROL_START: TMenuItem;
    MENU_CONTROL_STOP: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    MENU_OPTION: TMenuItem;
    N8: TMenuItem;
    N6: TMenuItem;
    Timer1: TTimer;
    A1: TMenuItem;
    Timer2: TTimer;
    N1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    Label4: TLabel;
    Label5: TLabel;
    N10: TMenuItem;
    M1: TMenuItem;
    M11: TMenuItem;
    RSA1: TRSA;
    Shell1: TMenuItem;
    Sign: TMenuItem;
    procedure N8Click(Sender: TObject);
    procedure DecodeTimerTimer(Sender: TObject);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure MENU_CONTROL_STARTClick(Sender: TObject);
    procedure MENU_CONTROL_STOPClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N10Click(Sender: TObject);
    procedure M1Click(Sender: TObject);
    procedure M11Click(Sender: TObject);
    procedure Shell1Click(Sender: TObject);
    procedure SignClick(Sender: TObject);
  private
    n334: Integer;
    m_boRemoteClose: Boolean;
    g_Socket: TCustomWinSocket;
    procedure StartService;
    procedure StopService;
    procedure LoadConfig;
    procedure SendUserSocket(Socket: TCustomWinSocket; sSessionID, sSendMsg: string);
  public
    procedure MyMessage(var MsgData: TWmCopyData); message WM_COPYDATA;
    procedure MakeLogin(sData: string; is176: Boolean);
    procedure MakeGate(sData: string; is176: Boolean);
    procedure MakeM2FileKey(sData: string);//Éú³ÉM2×¢²áÎÄ¼þ
    procedure MakeM2FileKey_176(sData: string);//Éú³ÉM2(176)×¢²áÎÄ¼þ
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  boStarted: Boolean;
  MakeCS: TRTLCriticalSection;
  MakeGameLogin: TRTLCriticalSection;
implementation

uses BasicSet, HUtil32, MakeThread,Clipbrd, winsock, DateUtils, uFileUnit, uRes;

{$R *.dfm}                                     `

procedure TFrmMain.Timer2Timer(Sender: TObject);
begin
  if n334 > 7 then
    n334 := 0
  else Inc(n334);
  case n334 of
    0: Label3.Caption := '|';
    1: Label3.Caption := '/';
    2: Label3.Caption := '--';
    3: Label3.Caption := '\';
    4: Label3.Caption := '|';
    5: Label3.Caption := '/';
    6: Label3.Caption := '--';
    7: Label3.Caption := '\';
  end;
end;

{-----------¶ÁÈ¡iniÅäÖÃÎÄ¼þ-----------}
procedure TFrmMain.LoadConfig;
var
  Conf: TIniFile;
  sConfigFileName, LoadString: string;
begin
  sConfigFileName := ExtractFilePath(ParamStr(0)) + 'Config.ini';
  Conf := TIniFile.Create(sConfigFileName);

  g_LoginSkinFile := Conf.ReadString(MakeClass, '3KSkinFile', g_LoginSkinFile);
  g_176LoginSkinFile := Conf.ReadString(MakeClass, '1763KSkinFile', g_176LoginSkinFile);
  g_LoginExe := Conf.ReadString(MakeClass, 'LoginExe', g_LoginExe);
  g_GateExe := Conf.ReadString(MakeClass, 'GateExe', g_GateExe);
  g_176LoginExe := Conf.ReadString(MakeClass, '176LoginExe', g_176LoginExe);
  g_176GateExe := Conf.ReadString(MakeClass, '176GateExe', g_176GateExe);


  g_nMakeLoginAddSign := Conf.ReadInteger(MakeClass, 'MakeLoginAddSign', g_nMakeLoginAddSign);
  g_nMakeLoginUsesShell := Conf.ReadInteger(MakeClass, 'MakeLoginUsesShell', g_nMakeLoginUsesShell);


  g_0627LoginExe := Conf.ReadString(MakeClass, '0627LoginExe', g_0627LoginExe);
  g_0627GateExe := Conf.ReadString(MakeClass, '0627GateExe', g_0627GateExe);
////////////////////////////////////////////////////////////////////////////////////////////
//Á¬»÷µÇÂ½Æ÷
//Ô¤Áô°æ±¾1
  LoadString := Conf.ReadString(MakeClass, 'Unknown1LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown1LoginExe', g_Unknown1LoginExe)
  else g_Unknown1LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, 'Unknown1GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown1GateExe', g_Unknown1GateExe)
  else g_Unknown1GateExe := LoadString;
//Ô¤Áô°æ±¾2
  LoadString := Conf.ReadString(MakeClass, 'Unknown2LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown2LoginExe', g_Unknown2LoginExe)
  else g_Unknown2LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, 'Unknown2GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown2GateExe', g_Unknown2GateExe)
  else g_Unknown2GateExe := LoadString;
//Ô¤Áô°æ±¾3
  LoadString := Conf.ReadString(MakeClass, 'Unknown3LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown3LoginExe', g_Unknown3LoginExe)
  else g_Unknown3LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, 'Unknown3GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown3GateExe', g_Unknown3GateExe)
  else g_Unknown3GateExe := LoadString;
//Ô¤Áô°æ±¾4
  LoadString := Conf.ReadString(MakeClass, 'Unknown4LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown4LoginExe', g_Unknown4LoginExe)
  else g_Unknown4LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, 'Unknown4GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown4GateExe', g_Unknown4GateExe)
  else g_Unknown4GateExe := LoadString;
//Ô¤Áô°æ±¾5
  LoadString := Conf.ReadString(MakeClass, 'Unknown5LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown5LoginExe', g_Unknown5LoginExe)
  else g_Unknown5LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, 'Unknown5GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown5GateExe', g_Unknown5GateExe)
  else g_Unknown5GateExe := LoadString;
//Ô¤Áô°æ±¾6
  LoadString := Conf.ReadString(MakeClass, 'Unknown6LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown6LoginExe', g_Unknown6LoginExe)
  else g_Unknown6LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, 'Unknown6GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown6GateExe', g_Unknown6GateExe)
  else g_Unknown6GateExe := LoadString;
//Ô¤Áô°æ±¾7
  LoadString := Conf.ReadString(MakeClass, 'Unknown7LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown7LoginExe', g_Unknown7LoginExe)
  else g_Unknown7LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, 'Unknown7GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown7GateExe', g_Unknown7GateExe)
  else g_Unknown7GateExe := LoadString;
//Ô¤Áô°æ±¾8
  LoadString := Conf.ReadString(MakeClass, 'Unknown8LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown8LoginExe', g_Unknown8LoginExe)
  else g_Unknown8LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, 'Unknown8GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, 'Unknown8GateExe', g_Unknown8GateExe)
  else g_Unknown8GateExe := LoadString;
////////////////////////////////////////////////////////////////////////////////////////////
//1.76µÇÂ½Æ÷
//Ô¤Áô°æ±¾1
  LoadString := Conf.ReadString(MakeClass, '176Unknown1LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown1LoginExe', g_176Unknown1LoginExe)
  else g_176Unknown1LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown1GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown1GateExe', g_176Unknown1GateExe)
  else g_176Unknown1GateExe := LoadString;
//Ô¤Áô°æ±¾2
  LoadString := Conf.ReadString(MakeClass, '176Unknown2LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown2LoginExe', g_176Unknown2LoginExe)
  else g_176Unknown2LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown2GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown2GateExe', g_176Unknown2GateExe)
  else g_176Unknown2GateExe := LoadString;
//Ô¤Áô°æ±¾3
  LoadString := Conf.ReadString(MakeClass, '176Unknown3LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown3LoginExe', g_176Unknown3LoginExe)
  else g_176Unknown3LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown3GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown3GateExe', g_176Unknown3GateExe)
  else g_176Unknown3GateExe := LoadString;
//Ô¤Áô°æ±¾4
  LoadString := Conf.ReadString(MakeClass, '176Unknown4LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown4LoginExe', g_176Unknown4LoginExe)
  else g_176Unknown4LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown4GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown4GateExe', g_176Unknown4GateExe)
  else g_176Unknown4GateExe := LoadString;
//Ô¤Áô°æ±¾5
  LoadString := Conf.ReadString(MakeClass, '176Unknown5LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown5LoginExe', g_176Unknown5LoginExe)
  else g_176Unknown5LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown5GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown5GateExe', g_176Unknown5GateExe)
  else g_176Unknown5GateExe := LoadString;
//Ô¤Áô°æ±¾6
  LoadString := Conf.ReadString(MakeClass, '176Unknown6LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown6LoginExe', g_176Unknown6LoginExe)
  else g_176Unknown6LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown6GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown6GateExe', g_176Unknown6GateExe)
  else g_176Unknown6GateExe := LoadString;
//Ô¤Áô°æ±¾7
  LoadString := Conf.ReadString(MakeClass, '176Unknown7LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown7LoginExe', g_176Unknown7LoginExe)
  else g_176Unknown7LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown7GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown7GateExe', g_176Unknown7GateExe)
  else g_176Unknown7GateExe := LoadString;
//Ô¤Áô°æ±¾8
  LoadString := Conf.ReadString(MakeClass, '176Unknown8LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown8LoginExe', g_176Unknown8LoginExe)
  else g_176Unknown8LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown8GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown8GateExe', g_176Unknown8GateExe)
  else g_176Unknown8GateExe := LoadString;
//Ô¤Áô°æ±¾9
  LoadString := Conf.ReadString(MakeClass, '176Unknown9LoginExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown9LoginExe', g_176Unknown9LoginExe)
  else g_176Unknown9LoginExe := LoadString;

  LoadString := Conf.ReadString(MakeClass, '176Unknown9GateExe', '');
  if LoadString = '' then
    Conf.WriteString(MakeClass, '176Unknown9GateExe', g_176Unknown9GateExe)
  else g_176Unknown9GateExe := LoadString;
////////////////////////////////////////////////////////////////////////////////////////////
  g_Http := Conf.ReadString(MakeClass, 'Http', g_Http);
  if Conf.ReadString(MakeClass, 'TestMakeLoginData', '') = '' then
    Conf.WriteString(MakeClass, 'TestMakeLoginData', g_sTestMakeLoginData)
  else
    g_sTestMakeLoginData := Conf.ReadString(MakeClass, 'TestMakeLoginData', g_sTestMakeLoginData);
  g_MakeDir := Conf.ReadString(MakeClass, 'MakeDir', g_MakeDir);
  g_UpFileDir := Conf.ReadString(MakeClass, 'UpFileDir', g_UpFileDir);
  g_nUserOneTimeMake := Conf.ReadInteger(MakeClass, 'UserOneTimeMake', g_nUserOneTimeMake);
  g_ClientServer := Conf.ReadString(MakeClass, 'ClientServer', g_ClientServer);
  if Conf.ReadString(MakeClass, 'Cmds', '') = '' then
    Conf.WriteString(MakeClass, 'Cmds', Cmds)
  else
    Cmds  := Conf.ReadString(MakeClass, 'Cmds', Cmds);
  TimeOut  := Conf.ReadInteger(MakeClass, 'TimeOut', TimeOut);
  if Conf.ReadInteger(MakeClass, 'LockMakeGameLogin', -1) < 0 then
    Conf.WriteBool(MakeClass, 'LockMakeGameLogin', g_boLockMakeGameLogin)
  else
    g_boLockMakeGameLogin := Conf.ReadBool(MakeClass, 'LockMakeGameLogin', g_boLockMakeGameLogin);
  Conf.Free;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
  function GetModule(nPort: Integer): Boolean;
  var
    i: Integer;
    Items: TListItem;
  begin
    Result := False;
    ListView.Items.BeginUpdate;
    try
      for i := 0 to ListView.Items.Count - 1 do begin
        Items := ListView.Items.Item[i];
        if Items.Data <> nil then begin
          if Integer(Items.Data) = nPort then begin
            Result := True;
            Break;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure DelModule(nPort: Integer);
  var
    i: Integer;
    DelItems: TListItem;
  begin
    ListView.Items.BeginUpdate;
    try
      for i := ListView.Items.Count - 1 downto 0 do begin
        DelItems := ListView.Items.Item[i];
        if DelItems.Data <> nil then begin
          if Integer(DelItems.Data) = nPort then begin
            ListView.Items.Delete(i);
            Break;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure UpDateModule(nPort: Integer; sName, sAddr, sTimeTick: string);
  var
    UpDateItems: TListItem;
    i: Integer;
  begin
    ListView.Items.BeginUpdate;
    try
      if sTimeTick <> '' then begin
        for i := 0 to ListView.Items.Count - 1 do begin
          UpDateItems := ListView.Items.Item[i];
          if UpDateItems.Data <> nil then begin
            if Integer(UpDateItems.Data) = nPort then begin
              // UpDateItems.Caption := sName;
               //UpDateItems.SubItems[0] := sAddr;
              UpDateItems.SubItems[1] := sTimeTick;
              Break;
            end;
          end;
        end;
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;

  procedure AddModule(nPort: Integer; sName, sAddr, sTimeTick: string);
  var
    AddItems: TListItem;
  begin
    ListView.Items.BeginUpdate;
    try
      if (nPort > 0) and (sName <> '') and (sAddr <> '') then begin
        AddItems := ListView.Items.Add;
        AddItems.Data := TObject(nPort);
        AddItems.Caption := sName;
        AddItems.SubItems.Add(sAddr);
        AddItems.SubItems.Add(sTimeTick);
      end;
    finally
      ListView.Items.EndUpdate;
    end;
  end;
begin
  if boConnectServer then begin
    Label1.Caption := 'ÒÑÁ¬½Ó!!!';
    if GetModule(g_nServerPort) then
      //UpDateModule(g_nServerPort, '·þÎñÆ÷', User_sRemoteAddress + ':' + IntToStr(User_nRemotePort) + ' ¡ú ' + User_sRemoteAddress + ':' + IntToStr(g_nServerPort), 'Õý³£')
      UpDateModule(g_nServerPort, 'Êý¾ÝÁ¬½Ó', IntToStr(User_nRemotePort) + ' ¡ú127.0.0.1:' + IntToStr(g_nServerPort), 'Õý³£')
    //else AddModule(g_nServerPort, '·þÎñÆ÷', User_sRemoteAddress + ':' + IntToStr(User_nRemotePort) + ' ¡ú ' + User_sRemoteAddress + ':' + IntToStr(g_nServerPort), 'Õý³£');
    else AddModule(g_nServerPort, 'Êý¾ÝÁ¬½Ó', IntToStr(User_nRemotePort) + ' ¡ú127.0.0.1:' + IntToStr(g_nServerPort), 'Õý³£');
  end else begin
    Label1.Caption := 'Î´Á¬½Ó!!!';
    if GetModule(g_nServerPort) then DelModule(g_nServerPort);
    if ((GetTickCount - dwReConnetServerTick) > 5000) and boStarted then begin//Èç¹ûÆô¶¯·þÎñ£¬¶Ï¿ªÁ¬½Ó£¬Ã¿¸ô5ÃëÍ¨ÖªÆô¶¯Æ÷ÈÃW2ÖØÐÂÁ¬½Ó 20100102
      dwReConnetServerTick:= GetTickCount();
      SendGameCenterMsg(SG_RECONMAKE, IntToStr(Self.Handle));
    end;
  end;
  Label2.Caption := 'Éú³ÉL:' + IntToStr(g_nMakeLoginNum);
  LbTransCount.Caption := 'Éú³ÉG:' + IntToStr(g_nMakeGateNum);
  Label4.Caption := 'ÕýÔÚÍ¬Ê±Éú³É:' + IntToStr(g_nNowMakeUserNum);
  Label5.Caption := 'Éú³ÉM:' + IntToStr(g_nMakeM2RegNum);
end;


procedure TFrmMain.N8Click(Sender: TObject);
begin
  FrmBasicSet := TFrmBasicSet.Create(Owner);
  FrmBasicSet.Open();
  FrmBasicSet.Free;
end;

procedure TFrmMain.DecodeTimerTimer(Sender: TObject);
var
  I: Integer;
  str: string;
  sMsg: string;
  Code: Char;
  sSocketIndex: string;
  sStr: string;
begin

  try
    EnterCriticalSection(MakeCS);
    try
      I:=0;
      while (True) do begin
        if (MakeMsgList.Count <= I) or (not DecodeTimer.Enabled) then Break;
        str := MakeMsgList.Strings[0];
        if Pos('$', str) <= 0 then Continue;
        str := ArrestStringEx(str, '%', '$', sMsg);
        if sMsg <> '' then begin
          Code := sMsg[1];
          sMsg := Copy(sMsg, 2, Length(sMsg) - 1);
          case Code of
            'I': begin //Éú³É1.76µÇÂ½Æ÷
              if g_nNowMakeUserNum < g_nUserOneTimeMake then begin
                MakeLoginThread:= TMakeLoginThread.Create(sMsg);
                MakeLoginThread.bois176 := True;
              end else begin
                sStr := DecryptString(sMsg);
                sStr := GetValidStr3(sStr, sSocketIndex, [',']);
                SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKEONETIME_FAIL, 0, 0, 0, 0)));
              end;
            end;
            'L': begin //Éú³ÉµÇÂ½Æ÷
              if g_nNowMakeUserNum < g_nUserOneTimeMake then begin
                MakeLoginThread:= TMakeLoginThread.Create(sMsg);
              end else begin
                sStr := DecryptString(sMsg);
                sStr := GetValidStr3(sStr, sSocketIndex, [',']);
                SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKEONETIME_FAIL, 0, 0, 0, 0)));
              end;
            end;
            'H': begin
              if g_nNowMakeUserNum < g_nUserOneTimeMake then begin
                MakeGateThread:= TMakeGateThread.Create(sMsg);
                MakeGateThread.bois176 := True;
              end else begin
                sStr := DecryptString(sMsg);
                sStr := GetValidStr3(sStr, sSocketIndex, ['/']);
                SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKEONETIME_FAIL, 0, 0, 0, 0)));
              end;
            end;
            'G': begin //Éú³ÉÍø¹Ø
              if g_nNowMakeUserNum < g_nUserOneTimeMake then begin
                MakeGateThread:= TMakeGateThread.Create(sMsg);
              end else begin
                sStr := DecryptString(sMsg);
                sStr := GetValidStr3(sStr, sSocketIndex, ['/']);
                SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKEONETIME_FAIL, 0, 0, 0, 0)));
              end;
            end;
            'N': begin //Éú³É1.76M2×¢²áÎÄ¼þ
              if g_nNowMakeUserNum < g_nUserOneTimeMake then begin
                MakeM2RegThread_176:= TMakeM2RegThread_176.Create(sMsg);
              end else begin
                sStr := DecryptString(sMsg);
                sStr := GetValidStr3(sStr, sSocketIndex, ['/']);
                SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKEONETIME_FAIL, 0, 0, 0, 0)));
              end; 
            end;
            'M': begin//Éú³ÉM2×¢²áÎÄ¼þ
              if g_nNowMakeUserNum < g_nUserOneTimeMake then begin
                MakeM2RegThread:= TMakeM2RegThread.Create(sMsg);
              end else begin
                sStr := DecryptString(sMsg);
                sStr := GetValidStr3(sStr, sSocketIndex, ['/']);
                SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKEONETIME_FAIL, 0, 0, 0, 0)));
              end;
            end;
            {'C': begin//Êý¾Ý·þÎñÆ÷·¢ËÍµÄ¼ì²éÁ¬½Ó°ü 20091107
              SendUserSocket(g_Socket, '0','89M2');
            end;}
          end;
          MakeMsgList.Delete(0);
          Inc(I);
        end else Continue;
      end;
    except
      MainOutMessage('{Òì³£}TFrmMain.DecodeTimerTimer');
    end;
  finally
    LeaveCriticalSection(MakeCS);
  end;
  EnterCriticalSection(g_OutMessageCS);
  try
    for i := 0 to g_MainMsgList.Count - 1 do begin
      MemoLog.Lines.Add('[' + DateTimeToStr(Now) + '] ' + g_MainMsgList.Strings[i]);
    end;
    g_MainMsgList.Clear;
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
  if MemoLog.Lines.Count > 200 then MemoLog.Lines.Clear;
end;


procedure TFrmMain.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
  function HostToIP(Name: string): String;
  var
    wsdata : TWSAData;
    hostName : array [0..255] of char;
    hostEnt : PHostEnt;
    addr : PChar;
  begin
    Result := '';
    WSAStartup ($0101, wsdata);
    try
      gethostname (hostName, sizeof (hostName));
      StrPCopy(hostName, Name);
      hostEnt := gethostbyname (hostName);
      if Assigned (hostEnt) then
        if Assigned (hostEnt^.h_addr_list) then begin
          addr := hostEnt^.h_addr_list^;
          if Assigned (addr) then begin
            Result := Format ('%d.%d.%d.%d', [byte(addr [0]),byte(addr [1]), byte(addr [2]),byte(addr [3])]);
          end;
      end;
    finally
      WSACleanup;
    end
  end;
  //¼ì²éIPµØÖ·¸ñÊ½
  function CheckIsIpAddr(Name: string): Boolean;
  var
    PStr: char;
    Temp: PChar;
    I: integer;
  begin
    Result := True;
    if Length(Name) <= 15 then begin
      for I := 0 to Length(Name) do begin
        Temp := PChar(copy(Name, I, 1));
        PStr := Temp^;
        if not (PStr in ['0'..'9', '.']) then begin
          Result := False;
          break
        end;
      end;
    end else Result := False;
  end;
var
  sIPaddr: string;
  ClientAddr: string;
//  I: Integer;
begin
  if CheckIsIpAddr(g_ClientServer) then begin
    ClientAddr := g_ClientServer;
  end else begin
    ClientAddr := HostToIP(g_ClientServer);
  end;
  sIPaddr := Socket.RemoteAddress;
  if sIPaddr <> ClientAddr then begin
    MainOutMessage('·Ç·¨·þÎñÆ÷Á¬½Ó: ' + sIPaddr+'  '+ClientAddr);
    Socket.Close;
    Exit;
  end;
  g_Socket := Socket;
  boConnectServer := True;
  User_sRemoteAddress := sIPaddr;
  User_nRemotePort := Socket.RemotePort;
  MainOutMessage('·þÎñÆ÷Á¬½Ó³É¹¦...');
end;

procedure TFrmMain.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  g_nNowMakeUserNum:= 0;
  MainOutMessage('·þÎñÆ÷¶Ï¿ªÁ¬½Ó...');
  boConnectServer := False;
end;

procedure TFrmMain.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Socket.Close;
  User_sRemoteAddress := '';
  User_nRemotePort := 0;
end;

procedure TFrmMain.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
{var
  sIPaddr: string; }
begin
  {sIPaddr := Socket.RemoteAddress;
  if sIPaddr <> g_ClientServer then begin
    MainOutMessage('·Ç·¨·þÎñÆ÷Á¬½Ó: ' + sIPaddr);
    Socket.Close;
    Exit;
  end; }
  MakeMsgList.Add(Socket.ReceiveText);
end;

procedure TFrmMain.Shell1Click(Sender: TObject);
begin
  Shell1.Checked := not Shell1.Checked;
  Windows.InterlockedExchange(g_nMakeLoginUsesShell, Integer(Shell1.Checked));
end;

procedure TFrmMain.SignClick(Sender: TObject);
begin
  Sign.Checked := not Sign.Checked;
  Windows.InterlockedExchange(g_nMakeLoginAddSign, Integer(Sign.Checked));
end;

procedure TFrmMain.StartService;
begin
  if boStarted then Exit;
  MainOutMessage('ÕýÔÚÆô¶¯·þÎñ...');
  g_nMakeLoginNum := 0;
  g_nMakeGateNum := 0;
  g_nMakeM2RegNum:= 0;
  g_nNowMakeUserNum := 0;
  ServerSocket.Port := g_nServerPort;
  ServerSocket.Address := g_sServerAddr;
  ServerSocket.Active := True;
  LoadConfig();
  boStarted := True;
  MainOutMessage('Æô¶¯·þÎñÍê³É...');
  SendGameCenterMsg(SG_STARTOK, 'Éú³É·þÎñÆ÷Æô¶¯Íê³É...');
end;

procedure TFrmMain.StopService;
begin
  MainOutMessage('ÕýÔÚÍ£Ö¹·þÎñ...');
  boConnectServer := False;
  ServerSocket.Active := False;
  boStarted := False;
  MainOutMessage('Í£Ö¹·þÎñÍê³É...');
end;

procedure TFrmMain.FormCreate(Sender: TObject);
{var
  nX, nY: Integer;
  ClStr, s1:string;
  MachineId: array [0..100] of AnsiChar;  }
begin
{  nY:= WLRegGetStatus(nX);
  if nY = 0 then begin//¼ì²é³ÌÐòÊÇ·ñ×¢²á Ã»ÓÐ×¢²áÔòÌáÊ¾
    WLHardwareGetID(MachineId);//È¡Ó²¼þID
    Clipbrd.Clipboard.AsText := MachineId;//¸´ÖÆµ½¼ôÇÐ°åÉÏ
    //Ê¹ÓÃÆÕÍ¨³ÌÐò¼ÓÃÜº¯Êý
    Decode('243F2F9136D9C6465A54A4BA779F619B5EEED0F138F326D167474A5D5AC935FD77CC253F46D9021D', s1); //Çë²»ÒªÐÞ¸Ä¼ÆËã»úÈÕÆÚ£¬×¢²áÈí¼þ£º
    ClStr:= s1+#13+#13;
    Decode('E7FEAF3C7D9F4C29DF69FE5E0BEF3653', s1);//»úÆ÷ÐÅÏ¢£º
    ClStr:= ClStr+s1+MachineId;
    Decode('B9B2632DEB84397FAFDE8D682EA091AD5FAA03D94A1BF6F00C0A5107E9403F47A2BC5969E19AE0CB1A29E429FB8F49DBD98426EBF1E52A1A67EA7DE7FA7F9A21CEAAB2BD7DD2FFA393A20D59FE57B489', s1);// (Ctrl+vÕ³Ìùµ½ÎÄ±¾) ºÍ µ±Ç°IPµØÖ·Ò»²¢·¢ËÍ¸ø¿Í·þQQ:228589790 ½øÐÐ×¢²á
    ClStr:= ClStr+s1+#13+#13;;
    Decode('83D7FD6174C8CE82AF03259A39C78ECEFA458CECC1AEA7EC6CC672654BD08339731B1AA6B4096EBA', s1);//¹Ù·½ÍøÕ¾£ºhttp://www.89m2.com
    ClStr:= ClStr+s1;
    Decode('AA50D0C4F4B48B0814577F81CCE3A3BD', s1);//IGEÈí¼þ
    Application.MessageBox(PChar(ClStr) ,PChar(s1),MB_IConERROR+MB_OK);
    asm //¹Ø±Õ³ÌÐò
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end else
  if nY = wlIsRegistered then begin//ÒÑ×¢²áµÄ£¬È¡IPÐÅÏ¢
  end else begin
    asm //¹Ø±Õ³ÌÐò
      MOV FS:[0],0;
      MOV DS:[0],EAX;
    end;
  end;  }

  g_dwGameCenterHandle := Str_ToInt(ParamStr(1), 0);
  m_boRemoteClose := False;
  SendGameCenterMsg(SG_FORMHANDLE, IntToStr(Self.Handle));
  SendGameCenterMsg(SG_STARTNOW, 'ÕýÔÚÉú³É·þÎñÆ÷...');
  StartService;
end;

procedure TFrmMain.MakeLogin(sData: string; is176: Boolean);
  function Check3KSkin(FileName: string):Boolean;
  var
    FS: TFileStream;
    FileHeader: TSkinFileHeader;
  begin
    Result := False;
    if FileExists(FileName) then begin                 //¹²ÏíÄ£Ê½´ò¿ªBy TasNat at: 2012-10-29 20:52:37
      FS := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
      try

        Result := (FS.Read(FileHeader, SizeOf(TSkinFileHeader)) = SizeOf(TSkinFileHeader)) and (FileHeader.sDesc = sSkinHeaderDesc);

      finally
        FS.Free;
      end;
    end;
  end;
  //¼ì²éÎÄ¼þ´óÐ¡
  function GetFileSize(const FileName: String; nCount: Int64): Boolean;
  var SearchRec: TSearchRec;
  begin
    Result:= False;
    if FileExists(FileName) then begin
      if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then begin
        if SearchRec.Size <= nCount then Result := True;
      end;
    end;
  end;
var
  sStr, sAccount, sSocketIndex, sGameListUrl, sBakGameListUrl, sPatchListUrl: string;
  sGameMonListUrl, sGameESystemUrl, sPass, sLoginName, sClientFileName: string;
  sboLoginMainImages, sboAssistantFilter, sboTzHintFile, sboUseAuto, sboPulsDesc, sboLoginVerNo, sboUseFd: string;
  sSourceFile, sTangeFile, {s,} sSkinFile: string;
  MyRecInfo: TRecinfo;
  nSourceFileSize: Int64;
  Target,Pic_Memo, TzHint, PulsDescFile, GameSdoFilterFile, FDDllMem: TMemoryStream;//Ïà¹ØÎÄ¼þÁ÷
  Dest_Memo, Stream: TMemoryStream;
  nCheckCode, CLoginVerNo, RecInfoStreamSize: Integer;
  //AssistantFilterList: TStringList;
  nCode: Byte;
begin
  nCode:= 0;
  nCheckCode := -1;
  try

    try
      if g_boLockMakeGameLogin then EnterCriticalSection(MakeGameLogin);//Ò»´ÎÖ»ÊÜÀíÒ»¸ö
    sStr := DecryptString(sData);
    //MainOutMessage(sStr);
    sStr := GetValidStr3(sStr, sSocketIndex, [',']);
    sStr := GetValidStr3(sStr, sAccount, [',']);
    sStr := GetValidStr3(sStr, sGameListUrl, [',']);
    sStr := GetValidStr3(sStr, sBakGameListUrl, [',']);
    sStr := GetValidStr3(sStr, sPatchListUrl, [',']);
    sStr := GetValidStr3(sStr, sGameMonListUrl, [',']);
    sStr := GetValidStr3(sStr, sGameESystemUrl, [',']);
    sStr := GetValidStr3(sStr, sPass, [',']);
    sStr := GetValidStr3(sStr, sLoginName, [',']);
    sStr := GetValidStr3(sStr, sClientFileName, [',']);
    sStr := GetValidStr3(sStr, sboLoginMainImages, [',']);
    sStr := GetValidStr3(sStr, sboAssistantFilter, [',']);
    sStr := GetValidStr3(sStr, sboTzHintFile, [',']);
    sboUseAuto := '0';
    if Length(sboTzHintFile) > 1 then begin
      if Length(sboTzHintFile) > 2 then
        sboUseAuto := sboTzHintFile[3];
      sboUseFd := sboTzHintFile[2];
      sboTzHintFile := sboTzHintFile[1];

    end else sboUseFd := '0';
    //sStr := GetValidStr3(sStr, sboUseFd, [',']);
    sboLoginVerNo := GetValidStr3(sStr, sboPulsDesc, [',']);
    nCode:= 1;
    if (sAccount <> '') and (sboLoginMainImages <> '') and
       (sboAssistantFilter <> '') and (sboTzHintFile <> '') and (sboPulsDesc <> '') and
       (sGameListUrl <> '') and (sBakGameListUrl <> '') and (sPatchListUrl <> '') and
       (sGameMonListUrl <> '') and (sGameESystemUrl <> '') and (sPass <> '') and (sboLoginVerNo <> '') then begin
      CLoginVerNo:= Str_ToInt(sboLoginVerNo, 0);
      nCode:= 2;
      if is176 then begin
        case CLoginVerNo of//µÇÂ½Æ÷°æ±¾
          0: sSourceFile := g_176LoginExe;//×îÐÂ°æ±¾
          1: sSourceFile := g_176Unknown1LoginExe;//Ô¤Áô°æ±¾1
          2: sSourceFile := g_176Unknown2LoginExe;//Ô¤Áô°æ±¾2
          3: sSourceFile := g_176Unknown3LoginExe;//Ô¤Áô°æ±¾3
          4: sSourceFile := g_176Unknown4LoginExe;//Ô¤Áô°æ±¾4
          5: sSourceFile := g_176Unknown5LoginExe;//Ô¤Áô°æ±¾5
          6: sSourceFile := g_176Unknown6LoginExe;//Ô¤Áô°æ±¾6
          7: sSourceFile := g_176Unknown7LoginExe;//Ô¤Áô°æ±¾7
          8: sSourceFile := g_176Unknown8LoginExe;//Ô¤Áô°æ±¾8
          9: sSourceFile := g_176Unknown9LoginExe;//Ô¤Áô°æ±¾9
          else sSourceFile := g_176LoginExe;//×îÐÂ°æ±¾ 20091220 Ôö¼Ó
        end;
        sSkinFile := g_176LoginSkinFile;
      end else begin
        case CLoginVerNo of//µÇÂ½Æ÷°æ±¾
          0: sSourceFile := g_LoginExe;//×îÐÂ°æ±¾
          1: sSourceFile := g_0627LoginExe; //0627°æ±¾
          2: sSourceFile := g_Unknown1LoginExe;//Ô¤Áô°æ±¾1
          3: sSourceFile := g_Unknown2LoginExe;//Ô¤Áô°æ±¾2
          4: sSourceFile := g_Unknown3LoginExe;//Ô¤Áô°æ±¾3
          5: sSourceFile := g_Unknown4LoginExe;//Ô¤Áô°æ±¾4
          6: sSourceFile := g_Unknown5LoginExe;//Ô¤Áô°æ±¾5
          7: sSourceFile := g_Unknown6LoginExe;//Ô¤Áô°æ±¾6
          8: sSourceFile := g_Unknown7LoginExe;//Ô¤Áô°æ±¾7
          9: sSourceFile := g_Unknown8LoginExe;//Ô¤Áô°æ±¾8
          else sSourceFile := g_LoginExe;//×îÐÂ°æ±¾ 20091220 Ôö¼Ó
        end;
        sSkinFile := g_LoginSkinFile;
      end;
      nCode:= 4;
      if sboLoginMainImages = '1' then sSkinFile := g_UpFileDir+'\'+sAccount+'_LoginMain.3KSkin';
      nCode:= 5;
      if FileExists(sSourceFile) then begin
        if FileExists(sSkinFile) then begin
          if GetFileSize(sSkinFile, 1048576) then begin
            nCode:= 6;
            sTangeFile := Encrypt(sAccount+FormatDateTime('yyyymmddhhmmss',Now)+'_Login', CertKey('?-W®ê')) + '.Exe';
            nCode:= 7;
            if Check3KSkin(PChar(sSkinFile)) then begin
              nCode:= 8;
              Pic_Memo:= TMemoryStream.Create;
              Target:=TMemoryStream.Create;
              Dest_Memo:=TMemoryStream.Create;
              Stream:=TMemoryStream.Create;
              try
                nCode:= 9;
                Pic_Memo.LoadFromFile(PChar(sSkinFile));
                EncDecToStream(Pic_Memo, TDiyDecEncAlg(1), 'dfgt542');//¼ÓÃÜÁ÷ 20101204
                EnCompressStream(Pic_Memo);//Ñ¹ËõÁ÷
                Pic_Memo.Position:=0;
                nCode:= 10;
                {Target.LoadFromFile(PChar(sSourceFile));
                Target.Position:=0;
                nCode:= 101;
                nSourceFileSize := Target.Size;
                nCode:= 102;
                Dest_Memo.SetSize(Target.Size+Pic_Memo.size);
                Dest_Memo.Position:=0;
                nCode:= 103;
                Dest_Memo.CopyFrom(Target,Target.Size); }
                nSourceFileSize := 0;//¿ªÉÏÃæµÄ×¢ÊÍÕâ¾ÍÒª×¢ÊÍ By TasNat at: 2012-05-09 17:01:25 
                nCode:= 104;
                Dest_Memo.CopyFrom(Pic_Memo,Pic_Memo.Size);
                MyRecInfo.MainImagesFileSize:= Pic_Memo.Size;//Í¼Æ¬´óÐ¡
                asm
                  db $EB,$10,'VMProtect begin',0
                end;
                nCode:= 12;
                MyRecInfo.lnkName := sLoginName;
                nCode:= 13;
                MyRecInfo.GameListURL := RSA1.EncryptStr(sGameListUrl);
                MyRecInfo.BakGameListURL := RSA1.EncryptStr(sBakGameListUrl);
                MyRecInfo.boAutoUpData := sboUseAuto = '1';
                nCode:= 14;
                MyRecInfo.GameMonListURL := RSA1.EncryptStr(sGameMonListUrl);
                MyRecInfo.PatchListURL := RSA1.EncryptStr(sPatchListUrl);
                MyRecInfo.GameESystemUrl := RSA1.EncryptStr(sGameESystemUrl);
                MyRecInfo.ClientFileName := sClientFileName;
                if sboTzHintFile = '1' then begin//Ì××°ÎÄ¼þ 20110305
                  nCode:= 18;
                  TzHint:= TMemoryStream.Create;
                  try
                    TzHint.LoadFromFile(PChar(g_UpFileDir+'\'+sAccount+'_TzHintList.txt'));
                    if TzHint.Size <= 1024 * 500 then begin//ÏÞÖÆÌ××°ÎÄ¼þ´óÐ¡
                      EnCompressStream(TzHint);//Ñ¹ËõÁ÷
                      nCode:= 19;
                      Dest_Memo.Seek(0,soFromEnd);//ÒÆ¶¯µ½Á÷Î²²¿
                      nCode:= 20;
                      Dest_Memo.CopyFrom(TzHint, TzHint.Size);//Ð´ÈëÌ××°ÎÄ¼þÁ÷
                      MyRecInfo.TzHintListFileSize:= TzHint.Size;//¼ÇÂ¼Ì××°ÎÄ¼þ´óÐ¡
                    end else nCheckCode := -8;
                  finally
                    TzHint.Free;
                  end;
                  {nCode:= 18;
                  if GetFileSize(g_UpFileDir+'\'+sAccount+'_TzHintList.txt', Length(MyRecInfo.TzHintFile)) then begin
                    AssistantFilterList := TStringList.Create();
                    try
                      nCode:= 19;
                      AssistantFilterList.LoadFromFile(PChar(g_UpFileDir+'\'+sAccount+'_TzHintList.txt'));
                      S:= AssistantFilterList.Text;
                      nCode:= 20;
                      Strpcopy(pchar(@MyRecInfo.TzHintFile),s); //½«S  ¸³¸øMyRecInfo.GameSdoFilterÊý×é   ÔõÃ´ÏÔÊ¾³öÀ´²Î¿¼µÇÂ½Æ÷
                    finally
                      FreeAndNil(AssistantFilterList);
                    end;
                  end else nCheckCode := -8;}
                end else begin
                   MyRecInfo.TzHintListFileSize:= 0;
                end;
                if sboPulsDesc = '1' then begin
                  nCode:= 21;
                  PulsDescFile:= TMemoryStream.Create;
                  try
                    PulsDescFile.LoadFromFile(PChar(g_UpFileDir+'\'+sAccount+'_PulsDesc.txt'));
                    if PulsDescFile.Size <= 1024*1024 then begin//ÏÞÖÆÎÄ¼þ´óÐ¡
                      nCode:= 22;
                      EnCompressStream(PulsDescFile);//Ñ¹ËõÁ÷
                      Dest_Memo.Seek(0,soFromEnd);//ÒÆ¶¯µ½Á÷Î²²¿
                      nCode:= 23;
                      Dest_Memo.CopyFrom(PulsDescFile, PulsDescFile.Size);//Ð´Èë¾­ÂçÎÄ¼þÁ÷
                      MyRecInfo.PulsDescFileSize:= PulsDescFile.Size;//¼ÇÂ¼¾­ÂçÎÄ¼þ´óÐ¡
                    end else nCheckCode := -9;
                  finally
                    PulsDescFile.Free;
                  end;
                 { nCode:= 21;
                  if GetFileSize(g_UpFileDir+'\'+sAccount+'_PulsDesc.txt', Length(MyRecInfo.PulsDesc)) then begin
                    AssistantFilterList := TStringList.Create();
                    try
                      nCode:= 22;
                      AssistantFilterList.LoadFromFile(PChar(g_UpFileDir+'\'+sAccount+'_PulsDesc.txt'));
                      S:= AssistantFilterList.Text;
                      nCode:= 23;
                      Strpcopy(pchar(@MyRecInfo.PulsDesc),s); //½«S  ¸³¸øMyRecInfo.GameSdoFilterÊý×é   ÔõÃ´ÏÔÊ¾³öÀ´²Î¿¼µÇÂ½Æ÷
                    finally
                      FreeAndNil(AssistantFilterList);
                    end;
                  end else nCheckCode := -9; }
                end else begin
                  MyRecInfo.PulsDescFileSize := 0;
                end;
                if sboAssistantFilter = '1' then begin
                  GameSdoFilterFile:= TMemoryStream.Create;
                  try
                    GameSdoFilterFile.LoadFromFile(PChar(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt'));
                    if GameSdoFilterFile.Size <= 500*1024 then begin//ÏÞÖÆÎÄ¼þ´óÐ¡
                      EnCompressStream(GameSdoFilterFile);//Ñ¹ËõÁ÷
                      Dest_Memo.Seek(0,soFromEnd);//ÒÆ¶¯µ½Á÷Î²²¿
                      Dest_Memo.CopyFrom(GameSdoFilterFile, GameSdoFilterFile.Size);//Ð´ÈëÎÄ¼þÁ÷
                      MyRecInfo.GameSdoFilterFileSize:= GameSdoFilterFile.Size;//¼ÇÂ¼ÎÄ¼þ´óÐ¡
                    end else nCheckCode := -5;
                  finally
                    GameSdoFilterFile.Free;
                  end;
                  {nCode:= 15;
                  if GetFileSize(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt', Length(MyRecInfo.GameSdoFilter)) then begin
                    AssistantFilterList := TStringList.Create();
                    try
                      nCode:= 16;
                      AssistantFilterList.LoadFromFile(PChar(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt'));
                      S:= AssistantFilterList.Text;
                      nCode:= 17;
                      Strpcopy(pchar(@MyRecInfo.GameSdoFilter),s); //½«S  ¸³¸øMyRecInfo.GameSdoFilterÊý×é   ÔõÃ´ÏÔÊ¾³öÀ´²Î¿¼µÇÂ½Æ÷
                    finally
                      FreeAndNil(AssistantFilterList);
                    end;
                  end else nCheckCode := -5; }
                end else begin
                  MyRecInfo.GameSdoFilterFileSize := 0;
                end;
                if sboUseFd = '1' then begin
                  FDDllMem:= TMemoryStream.Create;
                  try
                    if FileExists('LoginDLL.dll') then
                      FDDllMem.LoadFromFile('LoginDLL.dll');
                    //if FDDllMem.Size <= 50000 then begin//ÏÞÖÆÎÄ¼þ´óÐ¡
                      EnCompressStream(FDDllMem);//Ñ¹ËõÁ÷
                      Dest_Memo.Seek(0,soFromEnd);//ÒÆ¶¯µ½Á÷Î²²¿
                      Dest_Memo.CopyFrom(FDDllMem, FDDllMem.Size);//Ð´ÈëÎÄ¼þÁ÷
                      MyRecInfo.FDDllFileSize:= FDDllMem.Size;//¼ÇÂ¼ÎÄ¼þ´óÐ¡
                    //end else nCheckCode := -5;
                  finally
                    FDDllMem.Free;
                  end;
                  {nCode:= 15;
                  if GetFileSize(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt', Length(MyRecInfo.GameSdoFilter)) then begin
                    AssistantFilterList := TStringList.Create();
                    try
                      nCode:= 16;
                      AssistantFilterList.LoadFromFile(PChar(g_UpFileDir+'\'+sAccount+'_FilterItemList.txt'));
                      S:= AssistantFilterList.Text;
                      nCode:= 17;
                      Strpcopy(pchar(@MyRecInfo.GameSdoFilter),s); //½«S  ¸³¸øMyRecInfo.GameSdoFilterÊý×é   ÔõÃ´ÏÔÊ¾³öÀ´²Î¿¼µÇÂ½Æ÷
                    finally
                      FreeAndNil(AssistantFilterList);
                    end;
                  end else nCheckCode := -5; }
                end else begin
                  MyRecInfo.FDDllFileSize := 0;
                end;
                nCode:= 24;
                MyRecInfo.GatePass := RSA1.EncryptStr(sPass);
                asm
                  db $EB,$0E,'VMProtect end',0
                end;
                MyRecInfo.SourceFileSize := nSourceFileSize;
                nCode:= 26;
                if nCheckCode = -1 then begin//20101204 ÐÞ¸Ä
                  Stream.Position:= 0;
                  Stream.WriteBuffer(MyRecInfo, RecInfoSize);
                  Stream.Position:= 0;
                  EncDecToStream(Stream, TDiyDecEncAlg(0), 'dfgt542');//¼ÓÃÜÁ÷
                  EnCompressStream(Stream);//Ñ¹ËõÁ÷
                  Dest_Memo.Seek(0,soFromEnd);
                  Dest_Memo.CopyFrom(Stream, 0);

                  Dest_Memo.Seek(0,soFromEnd);
                  RecInfoStreamSize:= Stream.Size;//½á¹¹Á÷µÄ´óÐ¡,Ð´ÈëÎÄ¼þ×îºó
                  Dest_Memo.WriteBuffer(RecInfoStreamSize, Sizeof(RecInfoStreamSize));
                  //Dest_Memo.SaveToFile('D:\2.txt');
                  //Dest_Memo.SaveToFile(g_MakeDir + '\' + sTangeFile);
                  //nCheckCode := 1;
                  //Ð´Èëµ½×ÊÔ´ÎÄ¼þÀï By TasNat at: 2012-05-09 13:47:25
                  if SaveRes(sSourceFile, g_MakeDir + '\' + sTangeFile, PChar(Dest_Memo.Memory), Dest_Memo.Size) then begin
                    if (g_nMakeLoginUsesShell <> 0) and not SaveToShell(g_MakeDir + '\' + sTangeFile, MyRecInfo.lnkName)  then
                      nCheckCode := -992
                    else
                    if (g_nMakeLoginAddSign <> 0) and not AddSign(g_MakeDir + '\' + sTangeFile)  then
                      nCheckCode := -991
                    else
                     nCheckCode := 1;
                  end
                  else
                    nCheckCode := -990;
                  {if WriteInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then begin
                    nCheckCode := 1;
                  end else nCheckCode := -3;}
                end;
                //Dest_Memo.SaveToFile(g_MakeDir + '\' + sTangeFile);
              finally
                Dest_Memo.free;
                Target.Free;
                Pic_Memo.Free;
                Stream.Free;
              end;
            end else nCheckCode := -7;
          end else nCheckCode := -6;
        end else nCheckCode := -11;
      end else nCheckCode := -10;
    end else nCheckCode := -4;
    nCode:= 27;
    if nCheckCode = 1 then begin
        Inc(g_nMakeLoginNum); //Éú³ÉµÇÂ½Æ÷´ÎÊý
        if is176 then begin
          SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_176USERMAKELOGIN_SUCCESS, 0, 0, 0, 0))+ EncryptString(g_Http+sTangeFile));
        end else begin
          SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKELOGIN_SUCCESS, 0, 0, 0, 0))+ EncryptString(g_Http+sTangeFile));
        end;
    //end else if sSocketIndex = '*' then begin
    //  MainOutMessage('{Ê§°Ü}TFrmMain.MakeLogin Code:' + IntToStr(nCheckCode));
    end else
      SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKELOGIN_FAIL, nCheckCode, 0, 0, 0)) + (sData));
    finally
      if g_boLockMakeGameLogin then LeaveCriticalSection(MakeGameLogin);
    end;
    MainOutMessage('MakeLogin Result:' + IntToStr(nCheckCode)+' VerN:'+sboLoginVerNo);
  except
    MainOutMessage('{Òì³£}TFrmMain.MakeLogin Code:' + IntToStr(nCode)+' VerN:'+sboLoginVerNo);
    SendUserSocket(g_Socket, sSocketIndex, EncodeMessage(MakeDefaultMsg(SM_USERMAKELOGIN_FAIL, nCheckCode, 0, 0, 0)));
  end;

end;

procedure TFrmMain.MakeGate(sData: string; is176: Boolean);
var
  sStr, sSocketIndex, sAccount, sGatePass, sTangeFile, sboLoginVerNo: string;
  MyRecInfo: TRecGateinfo;
  nCheckCode, CLoginVerNo: Integer;
  nCode: Byte;
begin
  nCode:= 0;
  try
    nCheckCode := -1;
    sStr := DecryptString(sData);
    sStr := GetValidStr3(sStr, sSocketIndex, ['/']);
    sStr := GetValidStr3(sStr, sAccount, ['/']);
    sboLoginVerNo := GetValidStr3(sStr, sGatePass, ['/']);
    nCode:= 1;
    if (sAccount <> '') and (sGatePass <> '') and (sSocketIndex <> '') and (sboLoginVerNo <> '') then begin
      nCode:= 2;
      sTangeFile := Encrypt(sAccount+FormatDateTime('yyyymmddhhmmss',Now)+'_Gate', CertKey('?-W®ê')) + '.Exe';
      CLoginVerNo:= Str_ToInt(sboLoginVerNo, 0);
      nCode:= 3;
      if is176 then begin
        case CLoginVerNo of//Íø¹Ø°æ±¾
          0: begin//×îÐÂ°æ±¾
              nCode:= 4;
              if CopyFile(PChar(g_176GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 5;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 6;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           1: begin//Ô¤Áô°æ±¾1
              nCode:= 10;
              if CopyFile(PChar(g_176Unknown1GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 11;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 12;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           2: begin//Ô¤Áô°æ±¾2
              nCode:= 13;
              if CopyFile(PChar(g_176Unknown2GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 14;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 15;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           3: begin//Ô¤Áô°æ±¾3
              nCode:= 16;
              if CopyFile(PChar(g_176Unknown3GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 17;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 18;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           4: begin//Ô¤Áô°æ±¾4
              nCode:= 19;
              if CopyFile(PChar(g_176Unknown4GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 20;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 21;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           5: begin//Ô¤Áô°æ±¾5
              nCode:= 22;
              if CopyFile(PChar(g_176Unknown5GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 23;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 24;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           6: begin//Ô¤Áô°æ±¾6
              nCode:= 25;
              if CopyFile(PChar(g_176Unknown6GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 26;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 27;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           7: begin//Ô¤Áô°æ±¾7
              nCode:= 28;
              if CopyFile(PChar(g_176Unknown7GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 29;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 30;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           8: begin//Ô¤Áô°æ±¾8
              nCode:= 31;
              if CopyFile(PChar(g_176Unknown8GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 32;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 33;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           9: begin
             nCode := 34;
             if CopyFile(PChar(g_176Unknown9GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 35;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 36;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
             end else nCheckCode := -4;
           end;
        end;
      end else begin
        case CLoginVerNo of//Íø¹Ø°æ±¾
          0: begin//×îÐÂ°æ±¾
              nCode:= 37;
              if CopyFile(PChar(g_GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 38;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 39;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
          1: begin//0627Íø¹Ø
              nCode:= 40;
              if CopyFile(PChar(g_0627GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 41;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 42;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           2: begin//Ô¤Áô°æ±¾1
              nCode:= 43;
              if CopyFile(PChar(g_Unknown1GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 44;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 45;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           3: begin//Ô¤Áô°æ±¾2
              nCode:= 46;
              if CopyFile(PChar(g_Unknown2GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 47;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 48;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           4: begin//Ô¤Áô°æ±¾3
              nCode:= 49;
              if CopyFile(PChar(g_Unknown3GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 50;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 51;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           5: begin//Ô¤Áô°æ±¾4
              nCode:= 52;
              if CopyFile(PChar(g_Unknown4GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 53;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 54;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           6: begin//Ô¤Áô°æ±¾5
              nCode:= 55;
              if CopyFile(PChar(g_Unknown5GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 56;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 57;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           7: begin//Ô¤Áô°æ±¾6
              nCode:= 58;
              if CopyFile(PChar(g_Unknown6GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 59;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 60;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           8: begin//Ô¤Áô°æ±¾7
              nCode:= 61;
              if CopyFile(PChar(g_Unknown7GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 62;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 63;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
           9: begin//Ô¤Áô°æ±¾8
              nCode:= 64;
              if CopyFile(PChar(g_Unknown8GateExe), PChar(g_MakeDir + '\' + sTangeFile), False) then begin
                nCode:= 65;
                MyRecInfo.GatePass := RSA1.EncryptStr(sGatePass);
                nCode:= 66;
                if WriteGateInfo(g_MakeDir + '\' + sTangeFile, MyRecInfo) then nCheckCode := 1
                else nCheckCode := -3;
              end else nCheckCode := -4;
           end;
        end;
      end;
    end else nCheckCode := -2;
    nCode:= 67;
    if nCheckCode = 1 then begin
      Inc(g_nMakeGateNum); //Ôö¼ÓÉú³ÉÍø¹Ø´ÎÊý
      if is176 then begin
        SendUserSocket(g_Socket, sSocketIndex,
                              EncodeMessage(MakeDefaultMsg(SM_176USERMAKEGATE_SUCCESS, 0, 0, 0, 0))+ EncryptString(g_Http+sTangeFile));
      end else begin
        SendUserSocket(g_Socket, sSocketIndex,
                              EncodeMessage(MakeDefaultMsg(SM_USERMAKEGATE_SUCCESS, 0, 0, 0, 0))+ EncryptString(g_Http+sTangeFile));
      end;
    end else begin
      SendUserSocket(g_Socket, sSocketIndex,
                              EncodeMessage(MakeDefaultMsg(SM_USERMAKEGATE_FAIL, nCheckCode, 0, 0, 0)));
    end;
  except
    MainOutMessage('{Òì³£}TFrmMain.MakeGate Code:' + IntToStr(nCode));
    SendUserSocket(g_Socket, sSocketIndex, EncodeMessage(MakeDefaultMsg(SM_USERMAKEGATE_FAIL, 0, 0, 0, 0)));
  end;
end;

procedure TFrmMain.SendUserSocket(Socket: TCustomWinSocket; sSessionID,
  sSendMsg: string);
begin
  if sSessionID <> '*' then
  Socket.SendText('%' + sSessionID + '/#' + sSendMsg + '!$');
end;

procedure TFrmMain.MENU_CONTROL_STARTClick(Sender: TObject);
begin
  StartService();
end;

procedure TFrmMain.MENU_CONTROL_STOPClick(Sender: TObject);
begin
  if Application.MessageBox('ÊÇ·ñÈ·ÈÏÍ£Ö¹·þÎñ£¿', 'È·ÈÏÐÅÏ¢', MB_YESNO + MB_ICONQUESTION) = IDYES then
    StopService();
end;

procedure TFrmMain.N4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.N2Click(Sender: TObject);
begin
  //MakeLogin(EncryptString(g_sTestMakeLoginData), True);
  MakeLoginThread:= TMakeLoginThread.Create(EncryptString(g_sTestMakeLoginData));
  MakeLoginThread.bois176 := True;
end;

procedure TFrmMain.N5Click(Sender: TObject);
var
  sData: string;
begin      //sSocketIndex,sAccount,sGatePass,sboLoginVerNo
  sData := '*/Account/Pass/0';
  MakeGate(EncryptString(sData), False);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
{  if MakeLoginThread <> nil then begin
    MakeLoginThread.Terminate ;
    MakeLoginThread.free;
  end;
  if MakeGateThread <> nil then begin
    MakeGateThread.Terminate;
    MakeGateThread.Free;
  end;      }
end;
//ÓÉÓÚ´Ë¹ý³Ì£¬ÐèÒª´øWinlicenseSDK.dllÎÄ¼þ
procedure TFrmMain.MakeM2FileKey(sData: string);
var
 { ExpDateSysTime: SYSTEMTIME;
  LicenseKeyBuff: array[0..1000] of AnsiChar;
  SizeKey, i: integer;
  pName: PAnsiChar;
  pOrg: PAnsiChar;
  pCustom: PAnsiChar;
  pHardId: PAnsiChar;
  pExpDateSysTime: ^SYSTEMTIME;
  NumDays, NumExec: integer;
  KeyFile: file of AnsiChar;
  str: PAnsiChar;
  RegExpDate: TDate;}

  sStr: string;
  sSocketIndex: string;
  sAccount: string;
  sGatePass: string;
  sKeyPass: string;
  sHardId: string;
  sRegDate: String;
  nCheckCode, nCheckCode1: Integer;

  nCode: Byte;
begin
  nCode:= 0;
  try
    //UserInfo.sSockIndex + '/' + UserInfo.sAccount + '/' +sKeyPass + '/' + sGatePass + '/' + HardId + '/'+ sRegDate;
    nCheckCode := -1;
    sStr := DecryptString(sData);
    sStr := GetValidStr3(sStr, sSocketIndex, ['/']);//
    sStr := GetValidStr3(sStr, sAccount, ['/']);
    sStr := GetValidStr3(sStr, sKeyPass, ['/']);
    sStr := GetValidStr3(sStr, sGatePass, ['/']);
    sRegDate := GetValidStr3(sStr, sHardId, ['/']);
    nCode:= 1;
    if (sAccount <> '') and (sKeyPass <> '') and (sSocketIndex <> '') and (sGatePass <>'') and (sHardId <> '') and (sRegDate <> '') then begin
      nCode:= 2;
      if not DirectoryExists(g_MakeDir + '\' + sAccount) then ForceDirectories(g_MakeDir + '\' + sAccount); //Ä¿Â¼²»´æÔÚ,Ôò´´½¨
      nCode:= 3;
      if FileExists(g_MakeDir + '\' + sAccount +'\IGEM2key.dat') then DeleteFile(g_MakeDir + '\' + sAccount +'\IGEM2key.dat');
      nCode:= 4;
      (*pName := PAnsiChar(sAccount);//ÓÃ»§Ãû
      pOrg := PAnsiChar(sKeyPass);//¹«Ë¾ÐÅÏ¢
      pCustom := PAnsiChar(sGatePass);//IPÐÅÏ¢
      pHardId := PAnsiChar(Trim(sHardId));//Ó²¼þID

      NumExec := 0;//ÏÞÖÆÔËÐÐ´ÎÊý£¬0ÖµÔò²»¿ØÖÆÔËÐÐ´ÎÊý
      nCode:= 5;
      RegExpDate:= StrToDate(sRegDate) + 365;
      DateTimeToSystemTime(RegExpDate, ExpDateSysTime);
      pExpDateSysTime := addr(ExpDateSysTime){nil};//µ½ÆÚÈÕÆÚ-
      nCode:= 6;
      if (Date() <= RegExpDate) then begin//µ½ÆÚÈÕÆÚ´óÓÚ»òµÈÓÚµ±Ç°µÄÈÕÆÚ 20090825 ÐÞ¸Ä
        NumDays:= DaysBetween(Date(),RegExpDate);//È¡Á½ÈÕÆÚµÄÊý
      end else NumDays:= 0;

      nCode:= 7;
      str:= PAnsiChar(DeCodeString(CodeString));//M2¹þÏ£Öµ
      nCode:= 8;
      SizeKey := WLGenLicenseFileKey({LicenseHash}str, pName, pOrg, pCustom, pHardId, NumDays, NumExec, pExpDateSysTime, 0, 0, 0, LicenseKeyBuff) ;
      nCode:= 9;
      //±£´æ×¢²áÎÄ¼þ
      AssignFile(KeyFile, g_MakeDir + '\' + sAccount +'\IGEM2key.dat');
      nCode:= 10;
      Rewrite(KeyFile);
      nCode:= 11;
      for i:= 0 to SizeKey-1 do Write(KeyFile, LicenseKeyBuff[i]);
      CloseFile(KeyFile);
      if SizeKey > 0 then nCheckCode := 1;  *)

      nCheckCode1:= RunApp('', g_MakeDir, sData, 'A');//Ö´ÐÐÄÚºËEXEÉú³É×¢²áÎÄ¼þ
      if nCheckCode1 <> 0 then nCheckCode := 1;
    end else nCheckCode := -2;
    nCode:= 13;
    if nCheckCode = 1 then begin
      Inc(g_nMakeM2RegNum); //Ôö¼ÓÉú³ÉÍø¹Ø´ÎÊý
      SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_USERMAKEM2REG_SUCCESS, 0, 0, 0, 0))+ EncryptString(g_Http + sAccount +'/IGEM2key.dat'));
    end else begin
      SendUserSocket(g_Socket, sSocketIndex,
                              EncodeMessage(MakeDefaultMsg(SM_USERMAKEM2REG_FAIL, 0, 0, 0, 0)));
    end;
  except
    MainOutMessage('{Òì³£}TFrmMain.MakeM2FileKey Code:' + IntToStr(nCode));
    SendUserSocket(g_Socket, sSocketIndex, EncodeMessage(MakeDefaultMsg(SM_USERMAKEM2REG_FAIL, 0, 0, 0, 0)));
  end;
end;
//Éú³ÉM2(176)×¢²áÎÄ¼þ
procedure TFrmMain.MakeM2FileKey_176(sData: string);
var
  {ExpDateSysTime: SYSTEMTIME;
  LicenseKeyBuff: array[0..1000] of AnsiChar;
  SizeKey, i: integer;
  pName: PAnsiChar;
  pOrg: PAnsiChar;
  pCustom: PAnsiChar;
  pHardId: PAnsiChar;
  pExpDateSysTime: ^SYSTEMTIME;
  NumDays, NumExec: integer;
  KeyFile: file of AnsiChar;
  str: PAnsiChar;
  RegExpDate: TDate;}

  sStr: string;
  sSocketIndex: string;
  sAccount: string;
  sGatePass: string;
  sKeyPass: string;
  sHardId: string;
  sRegDate: String;
  nCheckCode, nCheckCode1: Integer;


  nCode: Byte;
begin
  nCode:= 0;
  try
    nCheckCode := -1;
    sStr := DecryptString(sData);
    sStr := GetValidStr3(sStr, sSocketIndex, ['/']);//
    sStr := GetValidStr3(sStr, sAccount, ['/']);
    sStr := GetValidStr3(sStr, sKeyPass, ['/']);
    sStr := GetValidStr3(sStr, sGatePass, ['/']);
    sRegDate := GetValidStr3(sStr, sHardId, ['/']);
    nCode:= 1;
    if (sAccount <> '') and (sKeyPass <> '') and (sSocketIndex <> '') and (sGatePass <>'') and (sHardId <> '') and (sRegDate <> '') then begin
      nCode:= 2;
      if not DirectoryExists(g_MakeDir + '\' + sAccount) then ForceDirectories(g_MakeDir + '\' + sAccount); //Ä¿Â¼²»´æÔÚ,Ôò´´½¨
      nCode:= 3;
      if FileExists(g_MakeDir + '\' + sAccount +'\IGEM2key.dat') then DeleteFile(g_MakeDir + '\' + sAccount +'\IGEM2key.dat');
      nCode:= 4;
      (*pName := PAnsiChar(sAccount);//ÓÃ»§Ãû
      pOrg := PAnsiChar(sKeyPass);//¹«Ë¾ÐÅÏ¢
      pCustom := PAnsiChar(sGatePass);//IPÐÅÏ¢
      pHardId := PAnsiChar(Trim(sHardId));//Ó²¼þID

      NumExec := 0;//ÏÞÖÆÔËÐÐ´ÎÊý£¬0ÖµÔò²»¿ØÖÆÔËÐÐ´ÎÊý
      nCode:= 5;
      RegExpDate:= StrToDate(sRegDate) + 365;
      DateTimeToSystemTime(RegExpDate, ExpDateSysTime);
      pExpDateSysTime := addr(ExpDateSysTime){nil};//µ½ÆÚÈÕÆÚ-
      nCode:= 6;
      if (Date() <= RegExpDate) then begin//µ½ÆÚÈÕÆÚ´óÓÚ»òµÈÓÚµ±Ç°µÄÈÕÆÚ 20090825 ÐÞ¸Ä
        NumDays:= DaysBetween(Date(),RegExpDate);//È¡Á½ÈÕÆÚµÄÊý
      end else NumDays:= 0;

      nCode:= 7;
      str:= PAnsiChar(DeCodeString(s176CodeString));//1.76M2¹þÏ£Öµ 20090718
      nCode:= 8;
      SizeKey := WLGenLicenseFileKey(str, pName, pOrg, pCustom, pHardId, NumDays, NumExec, pExpDateSysTime, 0, 0, 0, LicenseKeyBuff) ;
      nCode:= 9;
      //±£´æ×¢²áÎÄ¼þ
      AssignFile(KeyFile, g_MakeDir + '\' + sAccount +'\IGEM2key.dat');
      nCode:= 10;
      Rewrite(KeyFile);
      nCode:= 11;
      for i:= 0 to SizeKey-1 do Write(KeyFile, LicenseKeyBuff[i]);
      CloseFile(KeyFile);
      if SizeKey > 0 then nCheckCode := 1; *)
      nCheckCode1:= RunApp('', g_MakeDir, sData, 'B');//Ö´ÐÐÄÚºËEXEÉú³É×¢²áÎÄ¼þ
      if nCheckCode1 <> 0 then nCheckCode := 1;
    end else nCheckCode := -2;
    nCode:= 13;
    if nCheckCode = 1 then begin
      Inc(g_nMakeM2RegNum); //Ôö¼ÓÉú³ÉÍø¹Ø´ÎÊý
      SendUserSocket(g_Socket, sSocketIndex,
                             EncodeMessage(MakeDefaultMsg(SM_176USERMAKEM2REG_SUCCESS, 0, 0, 0, 0))+ EncryptString(g_Http + sAccount +'/IGEM2key.dat'));
    end else begin
      SendUserSocket(g_Socket, sSocketIndex,
                              EncodeMessage(MakeDefaultMsg(SM_USERMAKEM2REG_FAIL, 0, 0, 0, 0)));
    end;
  except
    MainOutMessage('{Òì³£}TFrmMain.MakeM2FileKey_176 Code:' + IntToStr(nCode));
    SendUserSocket(g_Socket, sSocketIndex, EncodeMessage(MakeDefaultMsg(SM_USERMAKEM2REG_FAIL, 0, 0, 0, 0)));
  end;
end;

procedure TFrmMain.MyMessage(var MsgData: TWmCopyData);
var
  sData: String;
  wIdent: Word;
begin
  wIdent := HiWord(MsgData.From);
  sData := StrPas(MsgData.CopyDataStruct^.lpData);
  case wIdent of //
    GS_QUIT: begin
        DecodeTimer.Enabled:= False;
        m_boRemoteClose := True;
        Close();
      end;
    1: ;
    2: ;
    3: ;
  end; // case
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if m_boRemoteClose then exit;
  if Application.MessageBox('ÊÇ·ñÈ·ÈÏÍË³ö·þÎñÆ÷£¿',
    'ÌáÊ¾ÐÅÏ¢',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    DecodeTimer.Enabled:= False;
  end else CanClose := False;
end;

procedure TFrmMain.N10Click(Sender: TObject);
begin
  if Application.MessageBox('ÊÇ·ñÈ·ÈÏÇå³ýÏÔÊ¾µÄÈÕÖ¾ÐÅÏ¢£¿',
    'È·ÈÏÐÅÏ¢',
    MB_OKCANCEL + MB_ICONQUESTION
    ) <> IDOK then Exit;
  MemoLog.Clear;
end;
//µ÷ÓÃ¹ý³ÌÉú³ÉM2×¢²áÎÄ¼þ
procedure TFrmMain.M1Click(Sender: TObject);
var
  sData: string;
begin
  sData := EncryptString('384/guoke/IGE¿Æ¼¼1/10.10.10.11/105A-F257-16AB-DC8E-9FD2-097C-6021-5FC3/2010-08-01');
  if not DirectoryExists(g_MakeDir + '\guoke') then ForceDirectories(g_MakeDir + '\guoke'); //Ä¿Â¼²»´æÔÚ,Ôò´´½¨
  if FileExists(g_MakeDir + '\guoke\IGEM2key.dat') then DeleteFile(g_MakeDir + '\guoke\IGEM2key.dat');
  RunApp('', g_MakeDir, sData, 'A');
end;
//µ¥»ú²âÊÔÓÃ(×¢²á»ú´úÂë)
procedure TFrmMain.M11Click(Sender: TObject);
{var
  sData: string;
  sStr: string;
  sSocketIndex: string;
  sAccount: string;
  sGatePass: string;
  sKeyPass: string;
  sHardId: string;
  sRegDate: String;
  RegExpDate: TDate;

  ExpDateSysTime: SYSTEMTIME;
  LicenseKeyBuff: array[0..1000] of AnsiChar;
  SizeKey, i: integer;
  pName: PAnsiChar;
  pOrg: PAnsiChar;
  pCustom: PAnsiChar;
  pHardId: PAnsiChar;
  pExpDateSysTime: ^SYSTEMTIME;
  NumDays, NumExec: integer;
  KeyFile: file of AnsiChar;
  str:pAnsiChar; }
begin
(*  sData := '384/guoke/IGE¿Æ¼¼1/10.10.10.11/105A-F257-16AB-DC8E-9FD2-097C-6021-5FC3/2010-08-01';
  sStr := GetValidStr3(sData, sSocketIndex, ['/']);
  sStr := GetValidStr3(sStr, sAccount, ['/']);
  sStr := GetValidStr3(sStr, sKeyPass, ['/']);
  sStr := GetValidStr3(sStr, sGatePass, ['/']);
  sRegDate := GetValidStr3(sStr, sHardId, ['/']);
  if (sAccount <> '') and (sKeyPass <> '') and (sSocketIndex <> '') and (sGatePass <>'') and (sHardId <> '') and (sRegDate <> '') then begin
    if not DirectoryExists(g_MakeDir + '\' + sAccount) then ForceDirectories(g_MakeDir + '\' + sAccount); //Ä¿Â¼²»´æÔÚ,Ôò´´½¨
    if FileExists(g_MakeDir + '\' + sAccount +'\IGEM2key.dat') then DeleteFile(g_MakeDir + '\' + sAccount +'\IGEM2key.dat');
    pName := PAnsiChar(sAccount);//ÓÃ»§Ãû
    pOrg := PAnsiChar(sKeyPass);//¹«Ë¾Ãû
    pCustom := PAnsiChar(sGatePass);//IPÐÅÏ¢
    pHardId := PAnsiChar(Trim(sHardId));//Ó²¼þID
    NumExec := 0;//ÔËÐÐ´ÎÊý

    RegExpDate:= StrToDate(sRegDate) + 365;
    DateTimeToSystemTime(RegExpDate, ExpDateSysTime);
    pExpDateSysTime := addr(ExpDateSysTime);//µ½ÆÚÈÕÆÚ-
    if (Date() <= RegExpDate) then begin//µ½ÆÚÈÕÆÚ´óÓÚ»òµÈÓÚµ±Ç°µÄÈÕÆÚ 20090825 ÐÞ¸Ä
      NumDays:= DaysBetween(Date(),RegExpDate);//È¡Á½ÈÕÆÚµÄÊý,Ê¹ÓÃÌìÊý
    end else NumDays:= 0;

    str:= PAnsiChar(DeCodeString(CodeString));//M2¹þÏ£Öµ
    SizeKey := WLGenLicenseFileKey({LicenseHash}str, pName, pOrg, pCustom, pHardId, NumDays, NumExec, pExpDateSysTime, 0, 0, 0, LicenseKeyBuff) ;
    //±£´æ×¢²áÎÄ¼þ
    AssignFile(KeyFile, g_MakeDir + '\' + sAccount +'\IGEM2key.dat');
    Rewrite(KeyFile);
    for i:= 0 to SizeKey-1 do Write(KeyFile, LicenseKeyBuff[i]);
    CloseFile(KeyFile);
  end;*)
end;

initialization
begin
  InitializeCriticalSection(MakeCS);
  InitializeCriticalSection(MakeGameLogin);

end;
finalization
begin
  DeleteCriticalSection(MakeCS);
  DeleteCriticalSection(MakeGameLogin);
end;

end.
