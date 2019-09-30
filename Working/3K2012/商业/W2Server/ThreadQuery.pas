unit ThreadQuery;

interface
uses Windows,DB, ADODB,Classes,Dialogs, SysUtils,Grobal2, Share, WinlicenseSDK,
     Messages, Controls;

type
  TQueryThread = class(TThread)//用户登陆线程
  private
    FQuery:TADOQuery;
  protected
    procedure Execute;override;
  public
    GateInfo: pTLoginGateInfo;
    SQLText:String;
    sLoginID:string;
    sPassword:string;
    UserInfo: pTM2UserInfo;
    constructor Create(AOwner:TComponent);
    destructor  Destroy;override;
  end;

  T176QueryThread = class(TThread)//1.76用户登陆线程
  private
    FQuery:TADOQuery;
  protected
    procedure Execute;override;
  public
    GateInfo: pTLoginGateInfo;
    SQLText:String;
    sLoginID:string;
    sPassword:string;
    UserInfo: pTM2UserInfo;
    constructor Create(AOwner:TComponent);
    destructor  Destroy;override;
  end;

  TM2QueryThread = class(TThread)//M2用户登陆线程
  private
    FQuery:TADOQuery;
  protected
    procedure Execute;override;
  public
    GateInfo: pTLoginGateInfo;
    SQLText:String;
    sLoginID:string;
    sPassword:string;
    UserInfo: pTM2UserInfo;
    constructor Create(AOwner:TComponent);
    destructor  Destroy;override;
  end;

  T176M2QueryThread = class(TThread)//1.76M2用户登陆线程
  private
    FQuery:TADOQuery;
  protected
    procedure Execute;override;
  public
    GateInfo: pTLoginGateInfo;
    SQLText:String;
    sLoginID:string;
    sPassword:string;
    UserInfo: pTM2UserInfo;
    constructor Create(AOwner:TComponent);
    destructor  Destroy;override;
  end;

  TDLUserLoginThread = class(TThread)//代理登陆
  private
    FQuery:TADOQuery;
  protected
    procedure Execute;override;
  public
    GateInfo: pTLoginGateInfo;
    SQLText:String;
    sLoginID:string;
    sPassword:string;
    UserInfo: pTM2UserInfo;
    constructor Create(AOwner:TComponent);
    destructor  Destroy;override;
  end;

  TUserMsgThread = class(TThread)//其它消息处理线程
  private
    nCode:Byte;//操作类型
    FQuery: TADOQuery;
    FADOCon: TADOConnection;
    procedure UpdateM2UserRegDate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//M2用户延期
    procedure AddUser(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//增加用户
    procedure AddM2User(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//增加M2用户
    procedure CheckAccount(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//代理检测用户是否存在
    procedure CheckM2Account(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//代理检测引擎用户是否存在
    procedure DLChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//代理修改密码
    //procedure ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//用户修改密码
    //procedure M2ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//M2用户修改密码
    procedure CheckMakeKeyAndDayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//验证密钥匙和今日生成次数
    procedure Check176MakeKeyAndDayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//验证密钥匙和今日生成次数
    procedure CheckM2DayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//验证M2今日生成次数
    procedure Check176M2DayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//验证1.76M2今日生成次数
    procedure MakeLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//生成登陆器
    procedure Make176Login(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//生成登陆器  1.76
    procedure MakeGate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//生成网关
    procedure Make176Gate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//生成网关  1.76
    
    procedure CheckUpdataM2RegData(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//检查用户修改次数
    procedure Check176UpdataM2RegData(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//检查1.76用户修改次数
    //procedure UPDataM2RegIP(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//修改用户IP信息
    procedure UPDataM2RegHARD(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//修改用户硬件信息
    procedure UPData176M2RegHARD(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//修改1.76用户硬件信息
    procedure MakeM2RegFile(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//生成M2注册文件
    procedure Make176M2RegFile(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);//生成1.76M2注册文件
  protected
    procedure Execute;override;
  public
    SQLText:String;
    UserInfo: pTM2UserInfo;
    Config: pTConfig;
    bois176: Boolean;
    constructor Create(AOwner:TComponent;Code:Byte);
    destructor  Destroy;override;
  end;

  TUpdateUserDayMakeNumThread = class(TThread)//修改生成次数线程
  private
    FQuery:TADOQuery;
    nCode:Byte;//操作类型
    procedure UpdateLoginAndGateDayMakeNum(UserInfo: pTM2UserInfo; sData: string);//更新登陆器和网关每日生成次数
    procedure UpdateM2DayMakeNum(UserInfo: pTM2UserInfo; sData: string);//更新M2每日生成次数
  protected
    procedure Execute;override;
  public
    bois176: Boolean;
    SQLText:string;
    sLoginID:string;
    UserInfo: pTM2UserInfo;
    DefMsg: TDefaultMessage;
    constructor Create(AOwner:TComponent; Code:Byte);
    destructor  Destroy;override;
  end;
  
var
  QueryThread: TQueryThread;
  L176QueryThread: T176QueryThread;
  M2QueryThread: TM2QueryThread;
  L176M2QueryThread: T176M2QueryThread;
  DLUserLoginThread: TDLUserLoginThread;
  //登陆器相关线程
  UserMsgThread0,UserMsgThread1,UserMsgThread2,UserMsgThread3,UserMsgThread4,UserMsgThread5,UserMsgThread6: TUserMsgThread;
  //M2相关线程
  UserMsgThread7, UserMsgThread8, UserMsgThread9, UserMsgThread10, UserMsgThread11,
    UserMsgThread12, UserMsgThread13, UserMsgThread14, UserMsgThread22: TUserMsgThread;
  //1.76登陆器相关
  UserMsgThread15, UserMsgThread16, UserMsgThread17: TUserMsgThread;
  //1.76引擎相关
  UserMsgThread18, UserMsgThread19, UserMsgThread20, UserMsgThread21: TUserMsgThread;
  UpdateUserDayMakeNum1, UpdateUserDayMakeNum2: TUpdateUserDayMakeNumThread;
implementation
uses DM, Main, EDcode, Common, EDcodeUnit, HUtil32, MD5EncodeStr;

//----------------------用户登陆---------------------------------------------
constructor TQueryThread.Create(AOwner:TComponent);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn;

  FreeOnTerminate:= True;
  inherited  Create(True);
end;   

destructor TQueryThread.Destroy;
begin
  FQuery.Free;
end;

procedure TQueryThread.Execute;
Var
  UserInfo1: TUserInfo;
  sSENDTEXT,sDest: string;
  sTimer:TDateTime;
  DefMsg: TDefaultMessage;
  nCode: Byte;
begin
  try
    if not UserInfo.boLogined then begin
      nCode:= 0;
      sDest := DecryptString(SQLText);
      sDest := GetValidStr3(sDest, sLoginID, ['/']);
      sDest := GetValidStr3(sDest, sPassword, ['/']);
      sPassword:=RivestStr(sPassword);//20080909
      if not UserLogined(sLoginID, GateInfo) then begin
        nCode:= 1;
        try
          with FQuery do begin
            nCode:= 2;
            Close;
            SQL.Clear;
            SQL.Add('Select * From UserInfo Where [User]=:a1 and Pass=:a2') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sLoginID);
             parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sPassword);
            Open;
            nCode:= 3;
            if RecordCount = 0 then begin
              nCode:= 4;
              DefMsg := MakeDefaultMsg(SM_USERLOGIN_FAIL, 0, 0, 0, 0);
              nCode:= 5;
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
              UserInfo.boKick := True;
              UserInfo.dwKickTick := GetTickCount + 5000;
            end else begin
              nCode:= 6;
              FillChar(UserInfo1, SizeOf(TUserInfo), 0);
              UserInfo1.sAccount := sLoginID;
              UserInfo1.sUserQQ := FieldByName('QQ').AsString;
              UserInfo1.nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
              UserInfo1.nMaxDayMakeNum := g_btMaxDayMakeNum;
              UserInfo1.sAddrs := FieldByName('IPAddress').AsString;
              UserInfo1.dTimer := FieldByName('Timer').AsDateTime;
              UserInfo1.sGateVersionNum := g_sGateVersionNum;
              UserInfo1.sLoginVersionNum := g_sLoginVersionNum;
              UserInfo1.LoginData.sGameListUrl := FieldByName('GameListUrl').AsString;
              UserInfo1.LoginData.sBakGameListUrl := FieldByName('BakGameListUrl').AsString;
              UserInfo1.LoginData.sPatchListUrl := FieldByName('PatchListUrl').AsString;
              UserInfo1.LoginData.sGameMonListUrl := FieldByName('GameMonListUrl').AsString;
              UserInfo1.LoginData.sGameESystemUrl := FieldByName('GameESystemUrl').AsString;
              UserInfo1.LoginData.sGatePass := FieldByName('GatePass').AsString;
              UserInfo.sAccount := sLoginID;
              UserInfo.sPassword := sPassword;
              UserInfo.boLogined := True;
              nCode:= 7;
              DefMsg := MakeDefaultMsg(SM_USERLOGIN_SUCCESS, 0, 0, 0, 0);
              sSENDTEXT := EncryptBuffer(@UserInfo1, SizeOf(TUserInfo));
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
              DefMsg := MakeDefaultMsg(SM_USERVERSION, 0, 0, 0, 0);
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + g_sLoginVersion);
              nCode:= 8;
              sTimer:= FieldByName('Timer').AsDateTime;
              if int(sTimer) <> int(Date()) then begin//日期不一致,则清0
                nCode:= 9;
                Close;
                SQL.Clear;
                SQL.Add('Update UserInfo set dayMakeNum=:a1,IPAddress=:a2,Timer=GetDate() Where [User]=:a4') ;
                parameters.ParamByName('a1').DataType:=FtInteger;
                parameters.ParamByName('a1').Value := 0;
                parameters.ParamByName('a2').DataType:=Ftstring;
                parameters.ParamByName('a2').Value := UserInfo.sUserIPaddr;
                parameters.ParamByName('a4').DataType :=Ftstring;
                parameters.ParamByName('a4').Value := Trim(sLoginID);
                nCode:= 10;
                ExecSQL;
              end else begin
                nCode:= 11;
                Close;
                SQL.Clear;
                SQL.Add('Update UserInfo set IPAddress=:a1,Timer=GetDate() Where [User]=:a3') ;
                parameters.ParamByName('a1').DataType:=Ftstring;
                parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
                parameters.ParamByName('a3').DataType :=Ftstring;
                parameters.ParamByName('a3').Value := Trim(sLoginID);
                nCode:= 12;
                ExecSQL;
              end;
            end;
          end;
        finally
          FrmDm.ADOconn.Close;
        end;
      end else begin
        DefMsg := MakeDefaultMsg(SM_USERLOGIN_FAIL, 1, 0, 0, 0);
        FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
        UserInfo.boKick := True;
        UserInfo.dwKickTick := GetTickCount;
      end;
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TQueryThread.Execute Code:'+IntToStr(nCode)+' '+E.Message);
    end;
  end;
end;

//-------------------------代理登陆---------------------------------------
constructor TDLUserLoginThread.Create(AOwner:TComponent);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn;

  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor TDLUserLoginThread.Destroy;
begin
  FQuery.Free;
end;

procedure TDLUserLoginThread.Execute;
Var
  DLUserInfo: TDLUserInfo;
  sSENDTEXT,sDest: string;
  DefMsg: TDefaultMessage;
  nCode: Byte;
  sVersion: string;
  sComputer: string;
  TempList:TstringList;
  I: Integer;
  bo123: Boolean;
begin
  try
    if not UserInfo.boLogined then begin
      nCode:= 0;
      sDest := DecryptString(SQLText);
      sDest := GetValidStr3(sDest, sLoginID, ['/']);
      sDest := GetValidStr3(sDest, sPassword, ['/']);
      sDest := GetValidStr3(sDest, sVersion, ['/']);
      sDest := GetValidStr3(sDest, sComputer, ['/']);
      if (sLoginID <> '') and (sPassword <> '') and (sVersion <> '') and (sComputer <> '') then begin
        //检查版本号
        if g_nW2Version > Str_ToInt(sVersion, 0) then begin
          DefMsg := MakeDefaultMsg(SM_LOGIN_FAIL, 2, 0, 0, 0);
          FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
          UserInfo.boKick := True;
          UserInfo.dwKickTick := GetTickCount + 5000;
          Exit;
        end;
        sPassword:=RivestStr(sPassword);//20080909     .
        if not UserLogined(sLoginID, GateInfo) then begin
          nCode:= 1;
          try
            with FQuery do begin
              Close;
              SQL.Clear;
              SQL.Add('Select * From DLUserInfo Where [User]=:a1 and Pass=:a2') ;
              parameters.ParamByName('a1').DataType:=Ftstring;
              parameters.ParamByName('a1').Value := Trim(sLoginID);
              parameters.ParamByName('a2').DataType :=Ftstring;
              parameters.ParamByName('a2').Value := Trim(sPassword);
              nCode:= 2;
              Open;
              if RecordCount = 0 then begin
                nCode:= 3;
                DefMsg := MakeDefaultMsg(SM_LOGIN_FAIL, 0, 0, 0, 0);
                nCode:= 4;
                FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
                UserInfo.boKick := True;
                UserInfo.dwKickTick := GetTickCount + 5000;
                nCode:= 5;
                Close;
              end else begin
                bo123 := False;
                TempList:= TstringList.Create;
                try
                  ExtractStrings(['|'], [], PChar(Trim(FieldByName('Computer').AsString)), TempList);
                  if TempList.Count > 0 then begin
                    for I:=0 to TempList.Count-1 do begin
                      if CompareText(TempList.Strings[I], sComputer) = 0 then begin
                        bo123 := True;
                        Break;
                      end;
                    end;
                  end else bo123 := True;
                finally
                  TempList.Free;
                end;
                if not bo123 then begin
                  DefMsg := MakeDefaultMsg(SM_LOGIN_FAIL, 3, 0, 0, 0);
                  FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
                  UserInfo.boKick := True;
                  UserInfo.dwKickTick := GetTickCount + 5000;
                  Exit;
                end;
                nCode:= 6;
                FillChar(DLUserInfo, SizeOf(TDLUserInfo), 0);
                DLUserInfo.sAccount := sLoginID;
                DLUserInfo.sUserQQ := FieldByName('QQ').AsString;
                DLUserInfo.sName := FieldByName('Name').AsString;
                DLUserInfo.CurYuE := FieldByName('YuE').AsCurrency;
                DLUserInfo.curXiaoShouE := FieldByName('XiaoShouE').AsCurrency;
                DLUserInfo.sAddrs := FieldByName('IPAddress').AsString;
                DLUserInfo.dTimer := FieldByName('Timer').AsDateTime;
                DLUserInfo.sPrice := sPrice;//登陆器价格
                DLUserInfo.sM2Price := sM2Price;//M2注册价格(包年)
                DLUserInfo.sM2PriceMonth:= sM2PriceMonth;//M2代理价格(包月) 20110712
                UserInfo.sAccount := sLoginID;
                UserInfo.sPassword := sPassword;
                UserInfo.boLogined := True;
                nCode:= 7;
                DefMsg := MakeDefaultMsg(SM_LOGIN_SUCCESS, g_nW2Version{代理配置器版本号}, 0, 0, 0);
                sSENDTEXT := EncryptBuffer(@DLUserInfo, SizeOf(TDLUserInfo));
                nCode:= 8;
                FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
                nCode:= 9;
                Close;
                SQL.Clear;
                SQL.Add('Update DLUserInfo set IPAddress=:a1,Timer=GetDate() Where [User]=:a3') ;
                parameters.ParamByName('a1').DataType:=Ftstring;
                parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
                parameters.ParamByName('a3').DataType :=Ftstring;
                parameters.ParamByName('a3').Value :=sLoginID;
                nCode:= 10;
                ExecSQL;
              end;
            end;
          finally
            FrmDm.ADOconn.Close;
          end;
        end else begin
          DefMsg := MakeDefaultMsg(SM_LOGIN_FAIL, 1, 0, 0, 0);
          FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
          UserInfo.boKick := True;
          UserInfo.dwKickTick := GetTickCount;
        end;
      end else begin
        UserInfo.boKick := True;
        UserInfo.dwKickTick := GetTickCount + 5000;
      end;
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TDLUserLoginThread.Execute Code:'+IntToStr(nCode)+'  '+E.Message);
    end;
  end;
end;

//-------------------------其它消息处理线程---------------------------------------
constructor TUserMsgThread.Create(AOwner:TComponent;Code:Byte);
begin
  FQuery := TADOQuery.Create(AOwner);
  FADOCon:=TADOConnection.Create(AOwner);
  FADOCon.ConnectionString:=FrmDm.ADOconn.ConnectionString;
  FADOCon.LoginPrompt:=False;
  FADOCon.Connected:=True;//是否考虑每个线程使用一个ADOCon连接，以解决“在异步运行时,操作不能被执行”20090708
  FQuery.Connection:= {FrmDm.ADOconn}FADOCon;
  nCode:= Code;
  FreeOnTerminate:= True;
  inherited  Create(True);
end;   

destructor TUserMsgThread.Destroy;
begin
  FQuery.Free;
  FADOCon.Free;
end;

//增加用户      btCheckCode 1-注册成功  2-未登陆 3-用户已存在 4,5-出现异常
procedure TUserMsgThread.AddUser(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
  //随机取密码
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //随机种子
      for i:=0 to 14 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
  //随机取密码
  function RandomGetKey():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ-=|';
      s1:='';
      Randomize(); //随机种子
      for i:=0 to 99 do begin
        i0:=random(38);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
var
  UserSession: TUserEntry1;
  YuE, XiaoShouE: Currency;
  btCheckCode: byte;
  sPass: string;
  sKey: string;
  DefMsg: TDefaultMessage;
  sSENDTEXT: string;
  I,ID: Integer;
  GateInfo: pTLoginGateInfo;
begin
  if UserInfo.boLogined then begin  //如果代理用户已经登陆
     YuE := 0;
     btCheckCode := 0;
     try
       with FQuery do begin
         Close;
         SQL.Clear;
         SQL.Add('Select YuE,XiaoShouE From DLUserInfo Where [User]=:a1 and Pass=:a2');
         Parameters.ParamByName('a1').DataType:=Ftstring;
         Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
         Parameters.ParamByName('a2').DataType :=Ftstring;
         Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
         Open();
         if RecordCount > 0 then begin
           YuE := FieldByName('YuE').AsCurrency;
           XiaoShouE := FieldByName('XiaoShouE').AsCurrency;
         end;
         Close;
       end;

       if YuE >= sPrice then btCheckCode := 1;
       if btCheckCode = 1 then begin
          FillChar(UserSession, SizeOf(TUserEntry1), #0);
          DecryptBuffer(sData, @UserSession, SizeOf(TUserEntry1));
          if (UserSession.sAccount <> '') and (UserSession.sGameListUrl <> '') and
            (UserSession.sBakGameListUrl <> '') and (UserSession.sPatchListUrl <> '')
            and (UserSession.sGameMonListUrl <> '') and (UserSession.sGatePass <> '') then begin
            if (not CheckUserExist('UserInfo',UserSession.sAccount)) and (not CheckUserExist('M2UserInfo',UserSession.sAccount)) and
               (not CheckUserExist('UserInfo176',UserSession.sAccount)) and (not CheckUserExist('M2UserInfo176',UserSession.sAccount)) then begin //如果帐号不存在
                if bois176 then begin
                  ID:= CheckMaXID(FQuery,'UserInfo176');
                end else ID:= CheckMaXID(FQuery,'UserInfo');
                with FQuery do begin
                  try
                    Close;
                    SQL.Clear;
                    if bois176 then begin
                      SQL.Add('Insert Into UserInfo176 (ID,[User],Pass,QQ,');
                    end else SQL.Add('Insert Into UserInfo (ID,[User],Pass,QQ,');
                    SQL.Add('GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass,MakeKey,Who,RegTimer,DayMakeNum)');
                    SQL.Add('  Values(:a13,:a0,:a1,:a2,:a3,:a4,:a5,:a6,:a7,:a8,:a9,:a10,:a11,:a12)');
                    Parameters.ParamByName('a13').DataType:=FtInteger;
                    Parameters.ParamByName('a13').Value := ID;
                    Parameters.ParamByName('a0').DataType:=Ftstring;
                    Parameters.ParamByName('a0').Value :=Trim(UserSession.sAccount);
                    Parameters.ParamByName('a1').DataType:=Ftstring;
                    sPass := RandomGetPass;
                    Parameters.ParamByName('a1').Value := RivestStr(sPass);//正常MD5
                    Parameters.ParamByName('a2').DataType:=FtString;
                    Parameters.ParamByName('a2').Value := Trim(UserSession.sUserQQ);
                    Parameters.ParamByName('a3').DataType:=FtString;
                    Parameters.ParamByName('a3').Value := Trim(UserSession.sGameListUrl);
                    Parameters.ParamByName('a4').DataType:=FtString;
                    Parameters.ParamByName('a4').Value := Trim(UserSession.sBakGameListUrl);
                    Parameters.ParamByName('a5').DataType:=FtString;
                    Parameters.ParamByName('a5').Value := Trim(UserSession.sPatchListUrl);
                    Parameters.ParamByName('a6').DataType:=FtString;
                    Parameters.ParamByName('a6').Value := Trim(UserSession.sGameMonListUrl);
                    Parameters.ParamByName('a7').DataType:=FtString;
                    Parameters.ParamByName('a7').Value := Trim(UserSession.sGameESystemUrl);
                    Parameters.ParamByName('a8').DataType:=FtString;
                    Parameters.ParamByName('a8').Value := Trim(UserSession.sGatePass);
                    Parameters.ParamByName('a9').DataType:=FtString;
                    sKey := RandomGetKey;
                    Parameters.ParamByName('a9').Value := sKey;
                    Parameters.ParamByName('a10').DataType:=FtString;
                    Parameters.ParamByName('a10').Value := Trim(Userinfo.sAccount);
                    Parameters.ParamByName('a11').DataType:=FtDateTime;
                    Parameters.ParamByName('a11').Value := Now();
                    Parameters.ParamByName('a12').DataType:=FtInteger;
                    Parameters.ParamByName('a12').Value := 0;
                    ExecSQL;
                    YuE := MaxCurr(0, YuE - sPrice);
                    XiaoShouE := XiaoShouE + sPrice;
                    try
                      Close;
                      SQL.Clear;
                      SQL.Add('Update DLUserInfo set YuE=:a1,XiaoShouE=:a2 Where [User]=:a3') ;
                      parameters.ParamByName('a1').DataType:=FtCurrency;
                      parameters.ParamByName('a1').Value := CurrToStr(YuE);
                      parameters.ParamByName('a2').DataType :=FtCurrency;
                      parameters.ParamByName('a2').Value := CurrToStr(XiaoShouE);
                      parameters.ParamByName('a3').DataType :=Ftstring;
                      parameters.ParamByName('a3').Value := Trim(UserInfo.sAccount);
                      ExecSQL;
                      Close;
                      if bois176 then begin
                        AddUserTips(Trim(UserInfo.sAccount),Trim(UserSession.sAccount),'2', sPrice);//添加日志
                      end else begin
                        AddUserTips(Trim(UserInfo.sAccount),Trim(UserSession.sAccount),'3', sPrice);//添加日志
                      end;
                    except
                      btCheckCode := 4;
                    end;
                  except
                    btCheckCode := 5;
                  end;
                end;
            end else btCheckCode := 3; //
          end;
       end;
     finally
     {FrmDm.ADOconn}FADOCon.Close;
     end;
  end else btCheckCode := 2;

  if btCheckCode = 1 then begin
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket <> nil then begin
        if GateInfo.Socket.RemotePort = UserInfo.Socket.RemotePort then begin
          Inc(GateInfo.nSuccesCount);//添加用户成功
          Break;
        end;
      end;
    end;
    DefMsg := MakeDefaultMsg(SM_ADDUSER_SUCCESS, btCheckCode, 0, 0, 0);
    sSENDTEXT := UserSession.sAccount+'/'+sPass+'/'+sKey+'/'+CurrToStr(YuE)+'/'+ CurrToStr(XiaoShouE);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + EncryptString(sSENDTEXT));
  end else begin
    for I := 0 to Config.GateList.Count - 1 do begin
      GateInfo := Config.GateList.Items[I];
      if GateInfo.Socket <> nil then begin
        if GateInfo.Socket.RemotePort = UserInfo.Socket.RemotePort then begin
          Inc(GateInfo.nFailCount);//添加用户失败
          Break;
        end;
      end;
    end;
    DefMsg := MakeDefaultMsg(SM_ADDUSER_FAIL, btCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;
//M2用户延期
procedure TUserMsgThread.UpdateM2UserRegDate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  YuE, XiaoShouE, NeedRMB: Currency;
  btCheckCode, nCode: byte;
  DefMsg: TDefaultMessage;
  sDest, sLoginID, sM2Type, sSENDTEXT: string;
  btDeco, UserTpye: Byte;
begin
  nCode:= 0;
  btDeco:= 0;
  try
    if UserInfo.boLogined then begin  //如果代理用户已经登陆
      sDest := DecryptString(sData);
      sDest := GetValidStr3(sDest, sLoginID, ['/']);//M2账号
      sDest := GetValidStr3(sDest, sM2Type, ['/']);//M2用户类型 1-包年 2-包月
      UserTpye:= Str_ToInt(sM2Type, 0);
      if bois176 then begin//检查M2用户是否存在
        if CheckUserExist1('M2UserInfo176', sLoginID, UserTpye) then btDeco := 1;
      end else begin
        if CheckUserExist1('M2UserInfo', sLoginID, UserTpye) then btDeco := 1;
      end;
      case UserTpye of
        1: NeedRMB:= sM2Price;//包年注册
        2: NeedRMB:= sM2PriceMonth;//包月注册
        else begin
          btCheckCode := 8;
          btDeco:= 2;
        end;
      end;
      if btDeco = 1 then begin//M2用户存在
        YuE := 0;
        btCheckCode := 0;
        nCode:= 1;
        try
          with FQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('Select YuE,XiaoShouE From DLUserInfo Where [User]=:a1 and Pass=:a2');
            Parameters.ParamByName('a1').DataType:=Ftstring;
            Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
            Parameters.ParamByName('a2').DataType :=Ftstring;
            Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
            nCode:= 2;
            Open();
            if RecordCount > 0 then begin
              YuE := FieldByName('YuE').AsCurrency;
              XiaoShouE := FieldByName('XiaoShouE').AsCurrency;
            end;
            Close;
          end;
          nCode:= 3;
          if YuE >= NeedRMB then btCheckCode := 1//检查代理的金额是否能达到单价
          else btCheckCode := 9;
          if btCheckCode = 1 then begin
            if (sLoginID <> '') and (UserTpye in [1,2]) then begin
              nCode:= 5;
              with FQuery do begin
                try
                  Close;
                  SQL.Clear;
                  if bois176 then begin
                    SQL.Add('UPDATE M2UserInfo176 ');
                  end else SQL.Add('UPDATE M2UserInfo ');
                  SQL.Add(' SET RegTimer=:a3,DayMakeNum=:a4,UpdataNum=:a5,Zt=:a6,UpType=:a7 Where [User]=:a1 and M2Type=:a2');
                  parameters.ParamByName('a1').DataType :=Ftstring;
                  parameters.ParamByName('a1').Value := Trim(sLoginID);
                  Parameters.ParamByName('a2').DataType:=FtInteger;
                  Parameters.ParamByName('a2').Value := UserTpye;
                  Parameters.ParamByName('a3').DataType:=FtDateTime;
                  Parameters.ParamByName('a3').Value := Now();//注册日期,用于计算M2到期日期
                  Parameters.ParamByName('a4').DataType:=FtInteger;
                  Parameters.ParamByName('a4').Value := 0;
                  case UserTpye of
                    1: begin//包年
                      Parameters.ParamByName('a5').DataType:=FtInteger;
                      Parameters.ParamByName('a5').Value := 0;
                      Parameters.ParamByName('a6').DataType:=FtString;
                      Parameters.ParamByName('a6').Value := 'T';
                      Parameters.ParamByName('a7').DataType:=FtInteger;
                      Parameters.ParamByName('a7').Value := 0;
                    end;
                    2: begin//包月
                      Parameters.ParamByName('a5').DataType:=FtInteger;
                      Parameters.ParamByName('a5').Value := 255;//即不能修改
                      Parameters.ParamByName('a6').DataType:=FtString;
                      Parameters.ParamByName('a6').Value := 'T';
                      Parameters.ParamByName('a7').DataType:=FtInteger;
                      Parameters.ParamByName('a7').Value := 3;
                    end;
                  end;
                  nCode:= 9;
                  ExecSQL;
                  YuE := MaxCurr(0, YuE - NeedRMB);
                  XiaoShouE := XiaoShouE + NeedRMB;
                  try
                    Close;
                    SQL.Clear;
                    SQL.Add('Update DLUserInfo set YuE=:a1,XiaoShouE=:a2 Where [User]=:a3') ;
                    parameters.ParamByName('a1').DataType:=FtCurrency;
                    parameters.ParamByName('a1').Value := CurrToStr(YuE);
                    parameters.ParamByName('a2').DataType :=FtCurrency;
                    parameters.ParamByName('a2').Value := CurrToStr(XiaoShouE);
                    parameters.ParamByName('a3').DataType :=Ftstring;
                    parameters.ParamByName('a3').Value := Trim(UserInfo.sAccount);
                    nCode:= 10;
                    ExecSQL;
                    Close;
                    nCode:= 11;
                    case UserTpye of
                      1: begin//包年
                        if bois176 then begin
                          AddUserTips(Trim(UserInfo.sAccount),Trim(sLoginID),'8', NeedRMB);//添加日志
                        end else begin
                          AddUserTips(Trim(UserInfo.sAccount),Trim(sLoginID),'7', NeedRMB);//添加日志
                        end;
                      end;
                      2: begin//包月
                        if bois176 then begin
                          AddUserTips(Trim(UserInfo.sAccount),Trim(sLoginID),'16', NeedRMB);//添加日志
                        end else begin
                          AddUserTips(Trim(UserInfo.sAccount),Trim(sLoginID),'15', NeedRMB);//添加日志
                        end;
                      end;
                    end;
                  except
                    btCheckCode := 4;
                  end;
                except
                  btCheckCode := 5;
                end;
              end;
            end else btCheckCode := 6;//用户名或类型错误
          end;
        finally
          FADOCon.Close;
        end;
      end else begin
        if btDeco = 0 then btCheckCode := 7;//用户不存在
      end;
    end else btCheckCode := 2;
    nCode:= 12;
    if btCheckCode = 1 then begin//修改成功
      sSENDTEXT := CurrToStr(YuE)+'/'+ CurrToStr(XiaoShouE);
      DefMsg := MakeDefaultMsg(SM_UPDATEM2USERREGDATE_SUCCESS, btCheckCode, 0, 0, 0);
      FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + EncryptString(sSENDTEXT));
    end else begin//修改失败
      DefMsg := MakeDefaultMsg(SM_UPDATEM2USERREGDATE_FAIL, btCheckCode, 0, 0, 0);
      FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TUserMsgThread.UpdateM2UserRegDate Code:'+IntToStr(nCode)+' '+E.Message);
    end;
  end;
end;
//增加M2用户      btCheckCode 1-注册成功  2-未登陆 3-用户已存在 4,5-出现异常
procedure TUserMsgThread.AddM2User(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
  //随机取密码
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
      s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
      s1:='';
      Randomize(); //随机种子
      for i:=0 to 14 do begin
        i0:=random(35);
        s1:=s1+copy(s,i0,1);
      end;
      Result := s1;
  end;
var
  UserSession: TM2UserEntry;
  YuE, XiaoShouE, NeedRMB: Currency;
  btCheckCode, nCode: byte;
  sPass, sSENDTEXT, sHardId: string;
  DefMsg: TDefaultMessage;
  I,ID: Integer;
  GateInfo: pTLoginGateInfo;
  pHardId: PAnsiChar;
begin
  nCode:= 0;
  try
    if UserInfo.boLogined then begin  //如果代理用户已经登陆
      FillChar(UserSession, SizeOf(TM2UserEntry), #0);
      DecryptBuffer(sData, @UserSession, SizeOf(TM2UserEntry));
      YuE := 0;
      btCheckCode := 0;
      NeedRMB:= sM2Price;
      nCode:= 1;
      try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('Select YuE,XiaoShouE From DLUserInfo Where [User]=:a1 and Pass=:a2');
          Parameters.ParamByName('a1').DataType:=Ftstring;
          Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
          Parameters.ParamByName('a2').DataType :=Ftstring;
          Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
          nCode:= 2;
          Open();
          if RecordCount > 0 then begin
            YuE := FieldByName('YuE').AsCurrency;
            XiaoShouE := FieldByName('XiaoShouE').AsCurrency;
          end;
          Close;
        end;
        nCode:= 3;
        case UserSession.sUserTpye of
          1: begin
            NeedRMB:= sM2Price;//包年注册
            if YuE >= NeedRMB then btCheckCode := 1;
          end;
          2: begin
            NeedRMB:= sM2PriceMonth;//包月注册
            if YuE >= NeedRMB then btCheckCode := 1;
          end;
        end;
        if btCheckCode = 1 then begin
          nCode:= 4;
          if (UserSession.sAccount <> '') and (UserSession.sGameListUrl <> '') and (UserSession.sBakGameListUrl <> '') and (UserSession.sPatchListUrl <> '') and (IsIPAddr(UserSession.sBakGameListUrl)) then begin
            sHardId:= UserSession.sPatchListUrl;
            pHardId:= PAnsiChar(sHardId);
            nCode:= 5;
            if WLHardwareCheckID(pHardId) then begin//检查硬件ID是否有效
              nCode:= 6;
              if (not CheckUserExist('UserInfo',UserSession.sAccount)) and (not CheckUserExist('M2UserInfo',UserSession.sAccount)) and
                 (not CheckUserExist('UserInfo176',UserSession.sAccount)) and (not CheckUserExist('M2UserInfo176',UserSession.sAccount)) then begin //如果帐号不存在
                nCode:= 7;
                if bois176 then begin
                  ID:= CheckMaXID(FQuery,'M2UserInfo176');
                end else ID:= CheckMaXID(FQuery,'M2UserInfo');
                nCode:= 8;
                with FQuery do begin
                  try
                    Close;
                    SQL.Clear;
                    if bois176 then begin
                      SQL.Add('Insert Into M2UserInfo176 (ID,[User],Pass,QQ,');
                    end else SQL.Add('Insert Into M2UserInfo (ID,[User],Pass,QQ,');
                    SQL.Add('GameListUrl,BakGameListUrl,PatchListUrl,Who,RegTimer,DayMakeNum,UpdataNum,Zt,UpType, M2Type)');
                    SQL.Add('  Values(:a13,:a0,:a1,:a2,:a3,:a4,:a5,:a10,:a11,:a12,:a15,:a14,:a16,:a17)');
                    Parameters.ParamByName('a13').DataType:=FtInteger;
                    Parameters.ParamByName('a13').Value := ID;
                    Parameters.ParamByName('a0').DataType:=Ftstring;
                    Parameters.ParamByName('a0').Value :=Trim(UserSession.sAccount);
                    Parameters.ParamByName('a1').DataType:=Ftstring;
                    sPass := RandomGetPass;
                    Parameters.ParamByName('a1').Value := RivestStr1(sPass);
                    Parameters.ParamByName('a2').DataType:=FtString;
                    Parameters.ParamByName('a2').Value := Trim(UserSession.sUserQQ);
                    Parameters.ParamByName('a3').DataType:=FtString;
                    Parameters.ParamByName('a3').Value := Trim(UserSession.sGameListUrl);
                    Parameters.ParamByName('a4').DataType:=FtString;
                    Parameters.ParamByName('a4').Value := Trim(UserSession.sBakGameListUrl);
                    Parameters.ParamByName('a5').DataType:=FtString;
                    Parameters.ParamByName('a5').Value := Trim(UserSession.sPatchListUrl);
                    Parameters.ParamByName('a10').DataType:=FtString;
                    Parameters.ParamByName('a10').Value := Trim(Userinfo.sAccount);
                    Parameters.ParamByName('a11').DataType:=FtDateTime;
                    Parameters.ParamByName('a11').Value := Now();//注册日期,用于计算M2到期日期
                    Parameters.ParamByName('a12').DataType:=FtInteger;
                    Parameters.ParamByName('a12').Value := 0;
                    case UserSession.sUserTpye of
                      1: begin//包年
                        Parameters.ParamByName('a15').DataType:=FtInteger;
                        Parameters.ParamByName('a15').Value := 0;
                        Parameters.ParamByName('a14').DataType:=FtString;
                        Parameters.ParamByName('a14').Value := 'T';
                        Parameters.ParamByName('a16').DataType:=FtInteger;
                        Parameters.ParamByName('a16').Value := 0;
                        Parameters.ParamByName('a17').DataType:=FtInteger;
                        Parameters.ParamByName('a17').Value := 1;
                      end;
                      2: begin//包月
                        Parameters.ParamByName('a15').DataType:=FtInteger;
                        Parameters.ParamByName('a15').Value := 255;//即不能修改
                        Parameters.ParamByName('a14').DataType:=FtString;
                        Parameters.ParamByName('a14').Value := 'T';
                        Parameters.ParamByName('a16').DataType:=FtInteger;
                        Parameters.ParamByName('a16').Value := 3;
                        Parameters.ParamByName('a17').DataType:=FtInteger;//M2注册类型：1-包年 2-包月
                        Parameters.ParamByName('a17').Value := 2;                        
                      end;
                    end;
                    nCode:= 9;
                    ExecSQL;
                    YuE := MaxCurr(0, YuE - NeedRMB);
                    XiaoShouE := XiaoShouE + NeedRMB;
                    try
                      Close;
                      SQL.Clear;
                      SQL.Add('Update DLUserInfo set YuE=:a1,XiaoShouE=:a2 Where [User]=:a3') ;
                      parameters.ParamByName('a1').DataType:=FtCurrency;
                      parameters.ParamByName('a1').Value := CurrToStr(YuE);
                      parameters.ParamByName('a2').DataType :=FtCurrency;
                      parameters.ParamByName('a2').Value := CurrToStr(XiaoShouE);
                      parameters.ParamByName('a3').DataType :=Ftstring;
                      parameters.ParamByName('a3').Value := Trim(UserInfo.sAccount);
                      nCode:= 10;
                      ExecSQL;
                      Close;
                      nCode:= 11;
                      case UserSession.sUserTpye of
                        1: begin//包年
                          if bois176 then begin
                            AddUserTips(Trim(UserInfo.sAccount),Trim(UserSession.sAccount),'8', NeedRMB);//添加日志
                          end else begin
                            AddUserTips(Trim(UserInfo.sAccount),Trim(UserSession.sAccount),'7', NeedRMB);//添加日志
                          end;
                        end;
                        2: begin//包月
                          if bois176 then begin
                            AddUserTips(Trim(UserInfo.sAccount),Trim(UserSession.sAccount),'16', NeedRMB);//添加日志
                          end else begin
                            AddUserTips(Trim(UserInfo.sAccount),Trim(UserSession.sAccount),'15', NeedRMB);//添加日志
                          end;
                        end;
                      end;
                    except
                      btCheckCode := 4;
                    end;
                  except
                    btCheckCode := 5;
                  end;
                end;
              end else btCheckCode := 3; //
            end else btCheckCode := 6; //
          end;
        end;
      finally
      {FrmDm.ADOconn}FADOCon.Close;
      end;
    end else btCheckCode := 2;
    nCode:= 12;
    if btCheckCode = 1 then begin
      for I := 0 to Config.GateList.Count - 1 do begin
        GateInfo := Config.GateList.Items[I];
        nCode:= 13;
        if GateInfo.Socket <> nil then begin
          nCode:= 14;
          if GateInfo.Socket.RemotePort = UserInfo.Socket.RemotePort then begin
            Inc(GateInfo.nSuccesCount);//添加用户成功
            Break;
          end;
        end;
      end;
      nCode:= 15;
      DefMsg := MakeDefaultMsg(SM_ADDM2USER_SUCCESS, btCheckCode, 0, 0, 0);
      sSENDTEXT := UserSession.sAccount+'/'+sPass+'/'+CurrToStr(YuE)+'/'+ CurrToStr(XiaoShouE);
      nCode:= 16;
      FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + EncryptString(sSENDTEXT));
    end else begin
      nCode:= 17;
      for I := 0 to Config.GateList.Count - 1 do begin
        GateInfo := Config.GateList.Items[I];
        nCode:= 18;
        if GateInfo.Socket <> nil then begin
          nCode:= 19;
          if GateInfo.Socket.RemotePort = UserInfo.Socket.RemotePort then begin
            Inc(GateInfo.nFailCount);//添加用户失败
            Break;
          end;
        end;
      end;
      DefMsg := MakeDefaultMsg(SM_ADDM2USER_FAIL, btCheckCode, 0, 0, 0);
      nCode:= 20;
      FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TUserMsgThread.AddM2User Code:'+IntToStr(nCode)+' '+E.Message);
    end;
  end;
end;

//代理检测用户是否存在
procedure TUserMsgThread.CheckAccount(Config: pTConfig; UserInfo: pTM2UserInfo;
  sData: string);
var
  sDest: string;
  btDeco: Byte;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin
    sDest := DecryptString(sData);
    if CheckUserExist('UserInfo',sDest) or CheckUserExist('M2UserInfo',sDest) or CheckUserExist('M2UserInfo176',sDest) or CheckUserExist('UserInfo176',sDest) then
      btDeco := 0
    else btDeco := 1;
    DefMsg := MakeDefaultMsg(SM_GETUSER_SUCCESS, btDeco, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//代理检测引擎用户是否存在
procedure TUserMsgThread.CheckM2Account(Config: pTConfig;
  UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  btDeco: Byte;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin
    sDest := DecryptString(sData);
    if CheckUserExist('UserInfo',sDest) or CheckUserExist('M2UserInfo',sDest) or
       CheckUserExist('UserInfo176',sDest) or CheckUserExist('M2UserInfo176',sDest) then //如果帐号不存在
      btDeco := 0
    else btDeco := 1;
    DefMsg := MakeDefaultMsg(SM_GETM2USER_SUCCESS, btDeco, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//代理修改密码
procedure TUserMsgThread.DLChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if RivestStr(Trim(sOldPass)) = UserInfo.sPassWord then begin
        try
          with FQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('Update DLUserInfo set Pass=:a1 Where [User]=:a2') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := RivestStr(Trim(sNewPass));//20080909//Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              AddUserTips(Trim(sLoginID),'','6', 0);//添加日志
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          {FrmDm.ADOconn}FADOCon.Close;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_CHANGEPASS_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_CHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

(*//用户修改密码
procedure TUserMsgThread.ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if RivestStr(Trim(sOldPass)) = UserInfo.sPassWord then begin
        try
          with FQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('Update UserInfo set [Pass]=:a1 Where [User]=:a2') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := RivestStr(Trim(sNewPass));//20080909//Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              AddUserTips('',Trim(sLoginID),'5', 0);//添加日志
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          {FrmDm.ADOconn}FADOCon.Close;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHANGEPASS_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;
//M2客户修改密码
procedure TUserMsgThread.M2ChangePass(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sLoginID: string;
  sOldPass: string;
  sNewPass: string;
  nCheckCode: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginID, ['/']);
    sDest := GetValidStr3(sDest, sOldPass, ['/']);
    sDest := GetValidStr3(sDest, sNewPass, ['/']);
    if sLoginID = UserInfo.sAccount then begin
      if RivestStr1(Trim(sOldPass)) = UserInfo.sPassWord then begin
        try
          with FQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('Update M2UserInfo set [Pass]=:a1 Where [User]=:a2') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := RivestStr1(Trim(sNewPass));//20080909//Trim(sNewPass);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);
            try
              ExecSQL;
              AddUserTips('',Trim(sLoginID),'9', 0);//添加日志
              nCheckCode := 1;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          {FrmDm.ADOconn}FADOCon.Close;
        end;
      end else nCheckCode := -3;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERM2CHANGEPASS_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERM2CHANGEPASS_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;   *)

//验证密钥匙和今日生成次数
procedure TUserMsgThread.CheckMakeKeyAndDayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  sUserKey: string;
  nDayMakeNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (Length(sKey) = 100) then begin
      try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('Select MakeKey,DayMakeNum From UserInfo');
          SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
          Parameters.ParamByName('a1').DataType:=Ftstring;
          Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
          Parameters.ParamByName('a2').DataType :=Ftstring;
          Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
          Open();
          if RecordCount > 0 then begin
            sUserKey := FieldByName('MakeKey').AsString;
            nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
          end;
          Close;
        end;
      finally
        {FrmDm.ADOconn}FADOCon.Close;
      end;
      if sUserKey = sKey then begin
        if nDayMakeNum < g_btMaxDayMakeNum then
          nCheckCode := 1
        else nCheckCode := -3;
      end else nCheckCode := -2;
    end else nCheckCode := -2;
  end else nCheckCode := -1;
  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//验证密钥匙和今日生成次数  1.76版本
procedure TUserMsgThread.Check176MakeKeyAndDayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  sUserKey: string;
  nDayMakeNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (Length(sKey) = 100) then begin
      try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('Select MakeKey,DayMakeNum From UserInfo176');
          SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
          Parameters.ParamByName('a1').DataType:=Ftstring;
          Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
          Parameters.ParamByName('a2').DataType :=Ftstring;
          Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
          Open();
          if RecordCount > 0 then begin
            sUserKey := FieldByName('MakeKey').AsString;
            nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
          end;
          Close;
        end;
      finally
        {FrmDm.ADOconn}FADOCon.Close;
      end;
      if sUserKey = sKey then begin
        if nDayMakeNum < g_btMaxDayMakeNum then
          nCheckCode := 1
        else nCheckCode := -3;
      end else nCheckCode := -2;
    end else nCheckCode := -2;
  end else nCheckCode := -1;
  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEKEYANDDAYMAKENUM_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//M2今日生成次数
procedure TUserMsgThread.CheckM2DayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  //sUserKey: string;
  nDayMakeNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (sKey = UserInfo.sAccount) then begin
      try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('Select DayMakeNum From M2UserInfo');
          SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
          Parameters.ParamByName('a1').DataType:=Ftstring;
          Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
          Parameters.ParamByName('a2').DataType :=Ftstring;
          Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
          Open();
          if RecordCount > 0 then begin
            nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
          end;
          Close;
        end;
      finally
        {FrmDm.ADOconn}FADOCon.Close;
      end;
      if nDayMakeNum < g_btMaxDayMakeNum then nCheckCode := 1
    end else nCheckCode := -2;
  end else nCheckCode := -1;
  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKM2DAYMAKENUM_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKM2DAYMAKENUM_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//1.76M2今日生成次数
procedure TUserMsgThread.Check176M2DayMakeNum(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  //sUserKey: string;
  nDayMakeNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (sKey = UserInfo.sAccount) then begin
      try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('Select DayMakeNum From M2UserInfo176');
          SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
          Parameters.ParamByName('a1').DataType:=Ftstring;
          Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
          Parameters.ParamByName('a2').DataType :=Ftstring;
          Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
          Open();
          if RecordCount > 0 then begin
            nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
          end;
          Close;
        end;
      finally
        {FrmDm.ADOconn}FADOCon.Close;
      end;
      if nDayMakeNum < g_btMaxDayMakeNum then nCheckCode := 1
    end else nCheckCode := -2;
  end else nCheckCode := -1;
  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKM2DAYMAKENUM_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKM2DAYMAKENUM_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//生成登陆器 1.76
procedure TUserMsgThread.Make176Login(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sGameListUrl: string;
  sBakGameListUrl: string;
  sPatchListUrl: string;
  sGameMonListUrl: string;
  sGameESystemUrl: string;
  sPass: string;
  sDest: string;
  sLoginName: string;
  sClientFileName: string;
  sboLoginMainImages: string;
  sboAssistantFilter: string;
  sboTzHintFile: string;
  sboPulsDesc: string;
  sSendData: string;
  sboUseFD : string;
  sLoginVerNo: string;
begin
  if UserInfo.boLogined then begin //如果已经登陆
    if not FrmMain.ClientSocket.Active then FrmMain.ClientSocket.Active:= True;//20091114 增加
    try
      with FQuery do begin
        Close;
        SQL.Clear;
        SQL.Add('Select GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass From UserInfo176');
        SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
          sGameListUrl := FieldByName('GameListUrl').AsString;
          sBakGameListUrl := FieldByName('BakGameListUrl').AsString;
          sPatchListUrl := FieldByName('PatchListUrl').AsString;
          sGameMonListUrl := FieldByName('GameMonListUrl').AsString;
          sGameESystemUrl := FieldByName('GameESystemUrl').AsString;
          sPass := FieldByName('GatePass').AsString;
        end;
        Close;
      end;
    finally
      {FrmDm.ADOconn}FADOCon.Close;
    end;

    sLoginName := '';
    sClientFileName := '';
    sboLoginMainImages := '';
    sboAssistantFilter := '';
    sboTzHintFile := '';
    sboPulsDesc := '';
    sLoginVerNo := '';
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginName, ['/']);
    sDest := GetValidStr3(sDest, sClientFileName, ['/']);
    sDest := GetValidStr3(sDest, sboLoginMainImages, ['/']);
    sDest := GetValidStr3(sDest, sboAssistantFilter, ['/']);
    sDest := GetValidStr3(sDest, sboTzHintFile, ['/']);
    sDest := GetValidStr3(sDest, sboUseFD, ['/']);
    sLoginVerNo := GetValidStr3(sDest, sboPulsDesc, ['/']);

    if (sLoginName <> '') and (sClientFileName <> '') and (sboLoginMainImages <> '') and (sboAssistantFilter <> '') and (sboTzHintFile <> '') and (sboPulsDesc <> '') then begin
      sSendData := UserInfo.sSockIndex + ',' +UserInfo.sAccount + ',' +
        sGameListUrl + ',' + sBakGameListUrl + ',' + sPatchListUrl + ',' + sGameMonListUrl + ',' +
        sGameESystemUrl + ',' + sPass + ',' + sLoginName + ',' + sClientFileName + ',' +
        sboLoginMainImages + ',' + sboAssistantFilter + ',' + sboTzHintFile + ',' + sboUseFD + ',' + sboPulsDesc + ',' + sLoginVerNo;
      FrmMain.ClientSocket.Socket.SendText('%I'+ EncryptString(sSendData) + '$');
    end;
  end;
end;

//生成登陆器
procedure TUserMsgThread.MakeLogin(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sGameListUrl: string;
  sBakGameListUrl: string;
  sPatchListUrl: string;
  sGameMonListUrl: string;
  sGameESystemUrl: string;
  sPass: string;
  sDest: string;
  sLoginName: string;
  sClientFileName: string;
  sboLoginMainImages: string;
  sboAssistantFilter: string;
  sboTzHintFile: string;
  sboPulsDesc: string;
  sSendData: string;
  sboUseFD : string;
  sLoginVerNo: string;
begin
  if UserInfo.boLogined then begin //如果已经登陆
    if not FrmMain.ClientSocket.Active then FrmMain.ClientSocket.Active:= True;//20091114 增加
    try
      with FQuery do begin
        Close;
        SQL.Clear;
        SQL.Add('Select GameListUrl,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,GatePass From UserInfo');
        SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
          sGameListUrl := FieldByName('GameListUrl').AsString;
          sBakGameListUrl := FieldByName('BakGameListUrl').AsString;
          sPatchListUrl := FieldByName('PatchListUrl').AsString;
          sGameMonListUrl := FieldByName('GameMonListUrl').AsString;
          sGameESystemUrl := FieldByName('GameESystemUrl').AsString;
          sPass := FieldByName('GatePass').AsString;
        end;
        Close;
      end;
    finally
      {FrmDm.ADOconn}FADOCon.Close;
    end;

    sLoginName := '';
    sClientFileName := '';
    sboLoginMainImages := '';
    sboAssistantFilter := '';
    sboTzHintFile := '';
    sboPulsDesc := '';
    sLoginVerNo := '';
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sLoginName, ['/']);
    sDest := GetValidStr3(sDest, sClientFileName, ['/']);
    sDest := GetValidStr3(sDest, sboLoginMainImages, ['/']);
    sDest := GetValidStr3(sDest, sboAssistantFilter, ['/']);
    sDest := GetValidStr3(sDest, sboTzHintFile, ['/']);
    sDest := GetValidStr3(sDest, sboUseFD, ['/']);
    sLoginVerNo := GetValidStr3(sDest, sboPulsDesc, ['/']);

    if (sLoginName <> '') and (sClientFileName <> '') and (sboLoginMainImages <> '') and (sboAssistantFilter <> '') and (sboTzHintFile <> '') and (sboPulsDesc <> '') then begin
      sSendData := UserInfo.sSockIndex + ',' +UserInfo.sAccount + ',' +
        sGameListUrl + ',' + sBakGameListUrl + ',' + sPatchListUrl + ',' + sGameMonListUrl + ',' +
        sGameESystemUrl + ',' + sPass + ',' + sLoginName + ',' + sClientFileName + ',' +
        sboLoginMainImages + ',' + sboAssistantFilter + ',' + sboTzHintFile + ',' + sboUseFD + ',' + sboPulsDesc + ',' + sLoginVerNo;
      FrmMain.ClientSocket.Socket.SendText('%L'+ EncryptString(sSendData) + '$');
      //AddUserTips('',Trim(UserInfo.sAccount),'8', 0);//添加日志 20090802 注释
    end;
  end;
end;

//生成网关 1.76
procedure TUserMsgThread.Make176Gate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sUserKeyPass: string;
  sKeyPass: string;
  sGatePass: string;
  sSendData: string;
  sLoginVerNo: string;
begin
  if UserInfo.boLogined then begin
    if not FrmMain.ClientSocket.Active then FrmMain.ClientSocket.Active:= True;//20091114 增加
    try
      with FQuery do begin
        Close;
        SQL.Clear;
        SQL.Add('Select MakeKey,GatePass From UserInfo176 Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
          sKeyPass := FieldByName('MakeKey').AsString;
          sGatePass := FieldByName('GatePass').AsString;
        end;
        Close;
      end;
    finally
      {FrmDm.ADOconn}FADOCon.Close;
    end;
    sLoginVerNo:= '';
    sDest := DecryptString(sData);
    sLoginVerNo := GetValidStr3(sDest, sUserKeyPass, ['/']);
    if (sUserKeyPass <> '') and (sGatePass <> '') and (Length(sGatePass) = 20) then begin
      if sUserKeyPass = sKeyPass then begin
        sSendData := UserInfo.sSockIndex + '/' + UserInfo.sAccount + '/' + sGatePass + '/' + sLoginVerNo;
        FrmMain.ClientSocket.Socket.SendText('%H'+ EncryptString(sSendData) + '$')
        //AddUserTips('',Trim(UserInfo.sAccount),'2', 0);//添加日志 200090802 注释
      end;
    end;
  end;
end;

//生成网关
procedure TUserMsgThread.MakeGate(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sUserKeyPass: string;
  sKeyPass: string;
  sGatePass: string;
  sSendData: string;
  sLoginVerNo: string;
begin
  if UserInfo.boLogined then begin
    if not FrmMain.ClientSocket.Active then FrmMain.ClientSocket.Active:= True;//20091114 增加
    try
      with FQuery do begin
        Close;
        SQL.Clear;
        SQL.Add('Select MakeKey,GatePass From UserInfo Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
          sKeyPass := FieldByName('MakeKey').AsString;
          sGatePass := FieldByName('GatePass').AsString;
        end;
        Close;
      end;
    finally
      {FrmDm.ADOconn}FADOCon.Close;
    end;
    sLoginVerNo:= '';
    sDest := DecryptString(sData);
    sLoginVerNo := GetValidStr3(sDest, sUserKeyPass, ['/']);
    if (sUserKeyPass <> '') and (sGatePass <> '') and (Length(sGatePass) = 20) then begin
      if sUserKeyPass = sKeyPass then begin
        sSendData := UserInfo.sSockIndex + '/' + UserInfo.sAccount + '/' + sGatePass + '/' + sLoginVerNo;
        FrmMain.ClientSocket.Socket.SendText('%G'+ EncryptString(sSendData) + '$')
        //AddUserTips('',Trim(UserInfo.sAccount),'2', 0);//添加日志 200090802 注释
      end;
    end;
  end;
end;

//检查用户修改次数
procedure TUserMsgThread.CheckUpdataM2RegData(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  //sUserKey: string;
  nUpdataNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (sKey = UserInfo.sAccount) then begin
      try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('Select UpdataNum From M2UserInfo');
          SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
          Parameters.ParamByName('a1').DataType:=Ftstring;
          Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
          Parameters.ParamByName('a2').DataType :=Ftstring;
          Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
          Open();
          if RecordCount > 0 then begin
            nUpdataNum := FieldByName('UpdataNum').AsInteger;
          end;
          Close;
        end;
      finally
        {FrmDm.ADOconn}FADOCon.Close;
      end;
      if nUpdataNum < 3 then nCheckCode := 1
    end else nCheckCode := -2;
  end else nCheckCode := -1;
  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEUPDATADATAUNM_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin             
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEUPDATADATAUNM_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

//检查1.76用户修改次数
procedure TUserMsgThread.Check176UpdataM2RegData(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKey: string;
  nCheckCode: Integer;
  //sUserKey: string;
  nUpdataNum: Integer;
  DefMsg: TDefaultMessage;
begin
  nCheckCode := -1;
  if UserInfo.boLogined then begin
    sKey := DecryptString(sData);
    if (sKey <> '') and (sKey = UserInfo.sAccount) then begin
      try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('Select UpdataNum From M2UserInfo176');
          SQL.Add(' Where [User]=:a1 and [Pass]=:a2');
          Parameters.ParamByName('a1').DataType:=Ftstring;
          Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
          Parameters.ParamByName('a2').DataType :=Ftstring;
          Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;
          Open();
          if RecordCount > 0 then begin
            nUpdataNum := FieldByName('UpdataNum').AsInteger;
          end;
          Close;
        end;
      finally
        {FrmDm.ADOconn}FADOCon.Close;
      end;
      if nUpdataNum < 3 then nCheckCode := 1
    end else nCheckCode := -2;
  end else nCheckCode := -1;
  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEUPDATADATAUNM_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end else begin             
    DefMsg := MakeDefaultMsg(SM_USERCHECKMAKEUPDATADATAUNM_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;
(*
procedure TUserMsgThread.UPDataM2RegIP(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sIP: string;
  sLoginID: string;
  nCheckCode, K: Integer;
  DefMsg: TDefaultMessage;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sIP, ['/']);//IP
    sDest := GetValidStr3(sDest, sLoginID, ['/']);//用户名
    if sLoginID = UserInfo.sAccount then begin
      try
        with FQuery do begin
          Close;
          SQL.Clear;
          SQL.Add('EXEC UpdateM2UpdataNumIP :a1,:a2,:a3,:a4');
          parameters.ParamByName('a1').DataType :=Ftstring;
          parameters.ParamByName('a1').Value := Trim(sIP);
          parameters.ParamByName('a2').DataType :=Ftstring;
          parameters.ParamByName('a2').Value := Trim(sLoginID);
          parameters.ParamByName('a3').DataType :=Ftstring;
          parameters.ParamByName('a3').Value := Trim(sDest);//硬件
          parameters.ParamByName('a4').DataType :=Ftinteger;
          parameters.ParamByName('a4').Value := 3;
          try
            open;
            K := FieldByName('num').AsInteger;
            if K = 1 then begin
              //AddUserTips('',Trim(sLoginID),'11', 0);//添加日志 200090803 注释
              nCheckCode := 1;
            end else nCheckCode := -3;
          except
            nCheckCode := -4;
          end;
        end;
      finally
        {FrmDm.ADOconn}FADOCon.Close;
      end;
    end else nCheckCode := -2;
  end else nCheckCode := -1;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERUPDATAM2REGDATAIP_SUCCESS, 0, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERUPDATAM2REGDATAIP_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end; *)

procedure TUserMsgThread.UPDataM2RegHARD(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sHARD: string;
  sLoginID: string;
  nCheckCode, K: Integer;
  DefMsg: TDefaultMessage;
  pHardId: PAnsiChar;
  sHardId: string;
  nUpdataNum: Byte;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sHARD, ['/']);//硬件
    sDest := GetValidStr3(sDest, sLoginID, ['/']);//用户名
    sHardId:= sHARD;
    pHardId:= PAnsiChar(sHardId);
    if WLHardwareCheckID(pHardId) then begin//检查硬件ID是否有效
      if sLoginID = UserInfo.sAccount then begin
        try
          with FQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('EXEC UpdateM2UpdataNumHard :a1,:a2,:a3,:a4');
            parameters.ParamByName('a1').DataType :=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sHARD);//硬件
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);//用户
            parameters.ParamByName('a3').DataType :=Ftstring;
            parameters.ParamByName('a3').Value := Trim(sDest);//IP
            parameters.ParamByName('a4').DataType :=Ftinteger;
            parameters.ParamByName('a4').Value := 3;
            try
              open;
              K := FieldByName('num').AsInteger;
              nUpdataNum := FieldByName('UpNum').AsInteger;
              if K = 1 then begin
                AddUserTips('',Trim(sLoginID),'12', 0);//添加日志
                nCheckCode := 1;
              end else nCheckCode := -3;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          {FrmDm.ADOconn}FADOCon.Close;
        end;
      end else nCheckCode := -2;
    end else nCheckCode := -1;
  end else  nCheckCode := -5;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERUPDATAM2REGDATAHARD_SUCCESS, nUpdataNum, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERUPDATAM2REGDATAHARD_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

procedure TUserMsgThread.UPData176M2RegHARD(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sDest: string;
  sHARD: string;
  sLoginID: string;
  nCheckCode, K: Integer;
  DefMsg: TDefaultMessage;
  pHardId: PAnsiChar;
  sHardId: string;
  nUpdataNum: Byte;
begin
  if UserInfo.boLogined then begin  //如果用户已经登陆
    sDest := DecryptString(sData);
    sDest := GetValidStr3(sDest, sHARD, ['/']);//硬件
    sDest := GetValidStr3(sDest, sLoginID, ['/']);//用户名
    sHardId:= sHARD;
    pHardId:= PAnsiChar(sHardId);
    if WLHardwareCheckID(pHardId) then begin//检查硬件ID是否有效
      if sLoginID = UserInfo.sAccount then begin
        try
          with FQuery do begin
            Close;
            SQL.Clear;
            SQL.Add('EXEC UpdateM2UpdataNumHard176 :a1,:a2,:a3,:a4');
            parameters.ParamByName('a1').DataType :=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sHARD);//硬件
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sLoginID);//用户
            parameters.ParamByName('a3').DataType :=Ftstring;
            parameters.ParamByName('a3').Value := Trim(sDest);//IP
            parameters.ParamByName('a4').DataType :=Ftinteger;
            parameters.ParamByName('a4').Value := 3;
            try
              open;
              K := FieldByName('num').AsInteger;
              nUpdataNum := FieldByName('UpNum').AsInteger;
              if K = 1 then begin
                AddUserTips('',Trim(sLoginID),'10', 0);//添加日志
                nCheckCode := 1;
              end else nCheckCode := -3;
            except
              nCheckCode := -4;
            end;
          end;
        finally
          {FrmDm.ADOconn}FADOCon.Close;
        end;
      end else nCheckCode := -2;
    end else nCheckCode := -1;
  end else  nCheckCode := -5;

  if nCheckCode = 1 then begin
    DefMsg := MakeDefaultMsg(SM_USERUPDATAM2REGDATAHARD_SUCCESS, nUpdataNum, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
  end else begin
    DefMsg := MakeDefaultMsg(SM_USERUPDATAM2REGDATAHARD_FAIL, nCheckCode, 0, 0, 0);
    FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + '');
  end;
end;

procedure TUserMsgThread.MakeM2RegFile(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKeyPass, sGatePass, sSendData, HardId, sRegDate: string;
  nM2Type: Byte;
  nDate: TDateTime;
begin
  if UserInfo.boLogined then begin
    if not FrmMain.ClientSocket.Active then FrmMain.ClientSocket.Active:= True;//20091114 增加
    try
      with FQuery do begin
        Close;
        SQL.Clear;
        SQL.Add('Select GameListUrl,BakGameListUrl,PatchListUrl,RegTimer,M2Type From M2UserInfo Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
          sKeyPass := FieldByName('GameListUrl').AsString;//公司
          sGatePass := FieldByName('BakGameListUrl').AsString;//IP地址
          HardId:= FieldByName('PatchListUrl').AsString;//硬件信息
          nM2Type:= FieldByName('M2Type').AsInteger;//M2注册类型 1-包年 2-包月
          case nM2Type of//根据M2注册类型计算到期日期 20110712
            1: begin//包年
              nDate:= FieldByName('RegTimer').AsDateTime + 365;
              sRegDate:= DateToStr(nDate);//注册日期
            end;
            2: begin//包月
              nDate:= FieldByName('RegTimer').AsDateTime + 31;
              sRegDate:= DateToStr(nDate);//注册日期
            end;
          end;
        end;
        Close;
      end;
    finally
      {FrmDm.ADOconn}FADOCon.Close;
    end;
    nCode:= 7;
    if (sKeyPass <> '') and (sGatePass <> '') and (HardId <> '') and (sRegDate <> '')
      and (UserInfo.sAccount <> '') then begin
      sSendData := UserInfo.sSockIndex + '/' + UserInfo.sAccount + '/' +sKeyPass + '/' + sGatePass + '/' + HardId + '/'+ sRegDate;
      FrmMain.ClientSocket.Socket.SendText('%M'+ EncryptString(sSendData) + '$');
      //AddUserTips('',Trim(UserInfo.sAccount),'10', 0);//添加日志 20090802 注释
    end;
  end;
end;

procedure TUserMsgThread.Make176M2RegFile(Config: pTConfig; UserInfo: pTM2UserInfo; sData: string);
var
  sKeyPass, sGatePass, sSendData, HardId, sRegDate: string;
  nM2Type: Byte;
  nDate: TDateTime;
begin
  if UserInfo.boLogined then begin
    if not FrmMain.ClientSocket.Active then FrmMain.ClientSocket.Active:= True;//20091114 增加
    try
      with FQuery do begin
        Close;
        SQL.Clear;
        SQL.Add('Select GameListUrl,BakGameListUrl,PatchListUrl,RegTimer,M2Type From M2UserInfo176 Where [User]=:a1 and [Pass]=:a2');
        Parameters.ParamByName('a1').DataType:=Ftstring;
        Parameters.ParamByName('a1').Value :=UserInfo.sAccount;
        Parameters.ParamByName('a2').DataType :=Ftstring;
        Parameters.ParamByName('a2').Value :=UserInfo.sPassWord;//20080909//UserInfo.sPassWord;
        Open();
        if RecordCount > 0 then begin
          sKeyPass := FieldByName('GameListUrl').AsString;//公司
          sGatePass := FieldByName('BakGameListUrl').AsString;//IP地址
          HardId:= FieldByName('PatchListUrl').AsString;//硬件信息
          nM2Type:= FieldByName('M2Type').AsInteger;//M2注册类型 1-包年 2-包月
          case nM2Type of//根据M2注册类型计算到期日期 20110712
            1: begin//包年
              nDate:= FieldByName('RegTimer').AsDateTime + 365;
              sRegDate:= DateToStr(nDate);//注册日期
            end;
            2: begin//包月
              nDate:= FieldByName('RegTimer').AsDateTime + 31;
              sRegDate:= DateToStr(nDate);//注册日期
            end;
          end;
        end;
        Close;
      end;
    finally
      {FrmDm.ADOconn}FADOCon.Close;
    end;
    if (sKeyPass <> '') and (sGatePass <> '') and (HardId <> '') and (sRegDate <> '') and (UserInfo.sAccount <> '') then begin
      sSendData := UserInfo.sSockIndex + '/' + UserInfo.sAccount + '/' +sKeyPass + '/' + sGatePass + '/' + HardId + '/'+ sRegDate;
      FrmMain.ClientSocket.Socket.SendText('%N'+ EncryptString(sSendData) + '$');
      //AddUserTips('',Trim(UserInfo.sAccount),'10', 0);//添加日志 20090802 注释
    end;
  end;
end;

procedure TUserMsgThread.Execute;
begin
  try
    case nCode of
      0: AddUser(Config, UserInfo, SQLText);//增加用户
      1: CheckAccount(Config, UserInfo, SQLText);//代理检测用户是否存在
      2: DLChangePass(Config, UserInfo, SQLText); //代理修改密码
      //3: ChangePass(Config, UserInfo, SQLText); //用户修改密码
      4: CheckMakeKeyAndDayMakeNum(Config, UserInfo, SQLText);//验证密钥匙和今日生成次数
      5: MakeLogin(Config, UserInfo, SQLText); //生成登陆器
      6: MakeGate(Config, UserInfo, SQLText); //生成网关
      7: CheckM2Account(Config, UserInfo, SQLText);//代理检测引擎用户是否存在
      8: AddM2User(Config, UserInfo, SQLText);//增加用户
      9: CheckUpdataM2RegData(Config, UserInfo, SQLText);//检查用户修改信息的次数
     //10: UPDataM2RegIP(Config, UserInfo, SQLText);//修改用户IP信息  20110712 注释
     11: UPDataM2RegHARD(Config, UserInfo, SQLText);//修改用户硬件信息
     12: MakeM2RegFile(Config, UserInfo, SQLText); //生成M2注册文件
     //13: M2ChangePass(Config, UserInfo, SQLText); //引擎用户修改密码
     14: CheckM2DayMakeNum(Config, UserInfo, SQLText);//验证M2今日生成次数
     15: Check176MakeKeyAndDayMakeNum(Config, UserInfo, SQLText);//验证密钥匙和今日生成次数  1.76版本
     16: Make176Login(Config, UserInfo, SQLText); //生成登陆器 1.76
     17: Make176Gate(Config, UserInfo, SQLText); //生成网关 1.76
     18: Check176UpdataM2RegData(Config, UserInfo, SQLText);//检查1.76用户修改信息的次数
     19: UPData176M2RegHARD(Config, UserInfo, SQLText);//1.76修改用户硬件信息
     20: Check176M2DayMakeNum(Config, UserInfo, SQLText);//验证1.76M2今日生成次数
     21: Make176M2RegFile(Config, UserInfo, SQLText); //生成1.76M2注册文件
     22: UpdateM2UserRegDate(Config, UserInfo, SQLText);//M2延期
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TUserMsgThread.Execute Code:'+inttostr(nCode)+' '+E.Message);
    end;
  end;
end;

//-------------------------- 修改生成次数线程------------------------------
constructor TUpdateUserDayMakeNumThread.Create(AOwner:TComponent; Code:Byte);
begin
  bois176 := False;
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn2;
  nCode := Code;
  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor TUpdateUserDayMakeNumThread.Destroy;
begin
  FQuery.Free;
end;

//更新登陆器和网关每日生成次数
procedure TUpdateUserDayMakeNumThread.UpdateLoginAndGateDayMakeNum(
  UserInfo: pTM2UserInfo; sData: string);
var
  sSocketMsg: string;
begin
  try
    //EnterCriticalSection(MyCs); //进入临界区
    try
      with FQuery do begin
         Close;
         SQL.Clear;
         if bois176 then begin
           SQL.Add('EXEC UpdateMakeNum176 :a1,:a2');
         end else begin
           SQL.Add('EXEC UpdateMakeNum :a1,:a2');
         end;
         parameters.ParamByName('a1').DataType :=Ftstring;
         parameters.ParamByName('a1').Value := Trim(sLoginID);
         parameters.ParamByName('a2').DataType :=Ftinteger;
         parameters.ParamByName('a2').Value := g_btMaxDayMakeNum;
         open;
         DefMsg.Recog := FieldByName('Num').AsInteger;
         Close;
         sSocketMsg := EncodeMessage(DefMsg) + SQLText;
         FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, sSocketMsg);
      end;
    finally
      //LeaveCriticalSection(MyCs); //离开临界区
      FrmDm.ADOconn2.Close;
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('TUpdateUserDayMakeNumThread.Execute '+E.Message);
    end;
  end;
end;

//更新M2每日生成次数
procedure TUpdateUserDayMakeNumThread.UpdateM2DayMakeNum(
  UserInfo: pTM2UserInfo; sData: string);
var
  sSocketMsg: string;
begin
try
  //EnterCriticalSection(MyCs); //进入临界区
  try
    with FQuery do begin
       Close;
       SQL.Clear;
       if bois176 then begin
         SQL.Add('EXEC UpdateM2MakeNum176 :a1,:a2');
       end else SQL.Add('EXEC UpdateM2MakeNum :a1,:a2');
       parameters.ParamByName('a1').DataType :=Ftstring;
       parameters.ParamByName('a1').Value := Trim(sLoginID);
       parameters.ParamByName('a2').DataType :=Ftinteger;
       parameters.ParamByName('a2').Value := g_btMaxDayMakeNum;
       open;
       DefMsg.Recog := FieldByName('Num').AsInteger;
       Close;
       sSocketMsg := EncodeMessage(DefMsg) + SQLText;
       FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, sSocketMsg);
    end;
  finally
    //LeaveCriticalSection(MyCs); //离开临界区
    FrmDm.ADOconn2.Close;
  end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('TUpdateUserDayMakeNumThread.Execute '+E.Message);
    end;
  end;
end;

procedure TUpdateUserDayMakeNumThread.Execute;
begin
  try
    case nCode of
      0: UpdateLoginAndGateDayMakeNum(UserInfo, SQLText);//更新登陆器和网关每日生成次数
      1: UpdateM2DayMakeNum(UserInfo, SQLText);//更新M2每日生成次数
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TUpdateUserDayMakeNumThread.Execute Code:'+inttostr(nCode)+' '+E.Message);
    end;
  end;
end;


{ TM2QueryThread }

constructor TM2QueryThread.Create(AOwner: TComponent);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn;
  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor TM2QueryThread.Destroy;
begin
  FQuery.Free;
end;

procedure TM2QueryThread.Execute;
Var
  UserInfo1: TM2UserInfo;
  sSENDTEXT,sDest: string;
  sTimer:TDateTime;
  DefMsg: TDefaultMessage;
  nCode: Byte;
begin
  try
    if not UserInfo.boLogined then begin
      nCode:= 0;
      sDest := DecryptString(SQLText);
      sDest := GetValidStr3(sDest, sLoginID, ['/']);
      sDest := GetValidStr3(sDest, sPassword, ['/']);
      sPassword:=RivestStr1(sPassword);//20080909
      if not UserLogined(sLoginID, GateInfo) then begin
        nCode:= 1;
        try
          with FQuery do begin
            nCode:= 2;
            Close;
            SQL.Clear;
            SQL.Add('Select * From M2UserInfo Where [User]=:a1 and Pass=:a2 and Zt=:a3') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sLoginID);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sPassword);
            parameters.ParamByName('a3').DataType :=Ftstring;
            parameters.ParamByName('a3').Value := 'T';
            Open;
            nCode:= 3;
            if RecordCount = 0 then begin
              nCode:= 4;
              DefMsg := MakeDefaultMsg(SM_USERM2LOGIN_FAIL, 0, 0, 0, 0);
              nCode:= 5;
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
              UserInfo.boKick := True;
              UserInfo.dwKickTick := GetTickCount + 5000;
            end else begin
              nCode:= 6;
              FillChar(UserInfo1, SizeOf(TM2UserInfo), 0);
              UserInfo1.sAccount := sLoginID;
              UserInfo1.sUserQQ := FieldByName('QQ').AsString;
              UserInfo1.nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
              UserInfo1.nMaxDayMakeNum := g_btMaxDayMakeNum;
              UserInfo1.sAddrs := FieldByName('IPAddress').AsString;
              UserInfo1.dTimer := FieldByName('Timer').AsDateTime;
              UserInfo1.sGameListUrl:= FieldByName('GameListUrl').AsString;//公司
              UserInfo1.sBakGameListUrl:= FieldByName('BakGameListUrl').AsString;//IP地址
              UserInfo1.sPatchListUrl:= FieldByName('PatchListUrl').AsString;//硬件信息
              UserInfo1.nUpType:= FieldByName('UpType').AsInteger;//修改资料类型
              UserInfo1.nUpDataNum:= FieldByName('UpdataNum').AsInteger;//修改资料次数
              UserInfo.sAccount := sLoginID;
              UserInfo.sPassword := sPassword;
              UserInfo.boLogined := True;
              nCode:= 7;
              DefMsg := MakeDefaultMsg(SM_USERM2LOGIN_SUCCESS, 0, 0, 0, 0);
              sSENDTEXT := EncryptBuffer(@UserInfo1, SizeOf(TM2UserInfo));
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
              DefMsg := MakeDefaultMsg(SM_M2USERVERSION, 0, 0, 0, 0);
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + g_sM2Version);
              nCode:= 8;
              sTimer:= FieldByName('Timer').AsDateTime;
              if int(sTimer) <> int(Date()) then begin//日期不一致,则清0
                nCode:= 9;
                Close;
                SQL.Clear;
                SQL.Add('Update M2UserInfo set dayMakeNum=:a1,IPAddress=:a2,Timer=GetDate() Where [User]=:a4') ;
                parameters.ParamByName('a1').DataType:=FtInteger;
                parameters.ParamByName('a1').Value := 0;
                parameters.ParamByName('a2').DataType:=Ftstring;
                parameters.ParamByName('a2').Value := UserInfo.sUserIPaddr;
                parameters.ParamByName('a4').DataType :=Ftstring;
                parameters.ParamByName('a4').Value := Trim(sLoginID);
                nCode:= 10;
                ExecSQL;
              end else begin
                nCode:= 11;
                Close;
                SQL.Clear;
                SQL.Add('Update M2UserInfo set IPAddress=:a1,Timer=GetDate() Where [User]=:a3') ;
                parameters.ParamByName('a1').DataType:=Ftstring;
                parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
                parameters.ParamByName('a3').DataType :=Ftstring;
                parameters.ParamByName('a3').Value := Trim(sLoginID);
                nCode:= 12;
                ExecSQL;
              end;
            end;
          end;
        finally
         FrmDm.ADOconn.Close;
        end;
      end else begin
        DefMsg := MakeDefaultMsg(SM_USERM2LOGIN_FAIL, 1, 0, 0, 0);
        FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
        UserInfo.boKick := True;
        UserInfo.dwKickTick := GetTickCount;
      end;
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] TQueryThread.Execute Code:'+IntToStr(nCode)+' '+E.Message);
    end;
  end;
end;

{ T176QueryThread }

constructor T176QueryThread.Create(AOwner: TComponent);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn;

  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor T176QueryThread.Destroy;
begin
  FQuery.Free;
end;

procedure T176QueryThread.Execute;
Var
  UserInfo1: TUserInfo;
  sSENDTEXT,sDest: string;
  sTimer:TDateTime;
  DefMsg: TDefaultMessage;
  nCode: Byte;
begin
  try
    if not UserInfo.boLogined then begin
      nCode:= 0;
      sDest := DecryptString(SQLText);
      sDest := GetValidStr3(sDest, sLoginID, ['/']);
      sDest := GetValidStr3(sDest, sPassword, ['/']);
      sPassword:=RivestStr(sPassword);//20080909
      if not UserLogined(sLoginID, GateInfo) then begin
       nCode:= 1;
        try
        with FQuery do begin
          nCode:= 2;
          Close;
          SQL.Clear;
          SQL.Add('Select * From UserInfo176 Where [User]=:a1 and Pass=:a2') ;
          parameters.ParamByName('a1').DataType:=Ftstring;
          parameters.ParamByName('a1').Value := Trim(sLoginID);
          parameters.ParamByName('a2').DataType :=Ftstring;
          parameters.ParamByName('a2').Value := Trim(sPassword);
          Open;
          nCode:= 3;
          if RecordCount = 0 then begin
            nCode:= 4;
            DefMsg := MakeDefaultMsg(SM_USERLOGIN_FAIL, 0, 0, 0, 0);
            nCode:= 5;
            FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
            UserInfo.boKick := True;
            UserInfo.dwKickTick := GetTickCount + 5000;
          end else begin
            nCode:= 6;
            FillChar(UserInfo1, SizeOf(TUserInfo), 0);
            UserInfo1.sAccount := sLoginID;
            UserInfo1.sUserQQ := FieldByName('QQ').AsString;
            UserInfo1.nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
            UserInfo1.nMaxDayMakeNum := g_btMaxDayMakeNum;
            UserInfo1.sAddrs := FieldByName('IPAddress').AsString;
            UserInfo1.dTimer := FieldByName('Timer').AsDateTime;
            UserInfo1.sGateVersionNum := g_s176GateVersionNum;
            UserInfo1.sLoginVersionNum := g_s176LoginVersionNum;
            UserInfo1.LoginData.sGameListUrl := FieldByName('GameListUrl').AsString;
            UserInfo1.LoginData.sBakGameListUrl := FieldByName('BakGameListUrl').AsString;
            UserInfo1.LoginData.sPatchListUrl := FieldByName('PatchListUrl').AsString;
            UserInfo1.LoginData.sGameMonListUrl := FieldByName('GameMonListUrl').AsString;
            UserInfo1.LoginData.sGameESystemUrl := FieldByName('GameESystemUrl').AsString;
            UserInfo1.LoginData.sGatePass := FieldByName('GatePass').AsString;
            UserInfo.sAccount := sLoginID;
            UserInfo.sPassword := sPassword;
            UserInfo.boLogined := True;
            nCode:= 7;
            DefMsg := MakeDefaultMsg(SM_USERLOGIN_SUCCESS, 0, 0, 0, 0);
            sSENDTEXT := EncryptBuffer(@UserInfo1, SizeOf(TUserInfo));
            FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
            DefMsg := MakeDefaultMsg(SM_USERVERSION, 0, 0, 0, 0);
            FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + g_s176LoginVersion);
            nCode:= 8;
            sTimer:= FieldByName('Timer').AsDateTime;
            if int(sTimer) <> int(Date()) then begin//日期不一致,则清0
              nCode:= 9;
              Close;
              SQL.Clear;
              SQL.Add('Update UserInfo176 set dayMakeNum=:a1,IPAddress=:a2,Timer=GetDate() Where [User]=:a4') ;
              parameters.ParamByName('a1').DataType:=FtInteger;
              parameters.ParamByName('a1').Value := 0;
              parameters.ParamByName('a2').DataType:=Ftstring;
              parameters.ParamByName('a2').Value := UserInfo.sUserIPaddr;
              parameters.ParamByName('a4').DataType :=Ftstring;
              parameters.ParamByName('a4').Value := Trim(sLoginID);
              nCode:= 10;
              ExecSQL;
            end else begin
              nCode:= 11;
              Close;
              SQL.Clear;
              SQL.Add('Update UserInfo176 set IPAddress=:a1,Timer=GetDate() Where [User]=:a3') ;
              parameters.ParamByName('a1').DataType:=Ftstring;
              parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
              parameters.ParamByName('a3').DataType :=Ftstring;
              parameters.ParamByName('a3').Value := Trim(sLoginID);
              nCode:= 12;
              ExecSQL;
            end;
          end;
        end;
        finally
          FrmDm.ADOconn.Close;
        end;
      end else begin
        DefMsg := MakeDefaultMsg(SM_USERLOGIN_FAIL, 1, 0, 0, 0);
        FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
        UserInfo.boKick := True;
        UserInfo.dwKickTick := GetTickCount;
      end;
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] T176QueryThread.Execute Code:'+IntToStr(nCode)+' '+E.Message);
    end;
  end;
end;

{ T176M2QueryThread }

constructor T176M2QueryThread.Create(AOwner: TComponent);
begin
  FQuery := TADOQuery.Create(AOwner);
  FQuery.Connection:= FrmDm.ADOconn;
  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor T176M2QueryThread.Destroy;
begin
  FQuery.Free;
end;

procedure T176M2QueryThread.Execute;
Var
  UserInfo1: TM2UserInfo;
  sSENDTEXT,sDest: string;
  sTimer:TDateTime;
  DefMsg: TDefaultMessage;
  nCode: Byte;
begin
  try
    if not UserInfo.boLogined then begin
      nCode:= 0;
      sDest := DecryptString(SQLText);
      sDest := GetValidStr3(sDest, sLoginID, ['/']);
      sDest := GetValidStr3(sDest, sPassword, ['/']);
      sPassword:=RivestStr1(sPassword);//20080909
      if not UserLogined(sLoginID, GateInfo) then begin
        nCode:= 1;
        try
          with FQuery do begin
            nCode:= 2;
            Close;
            SQL.Clear;
            SQL.Add('Select * From M2UserInfo176 Where [User]=:a1 and Pass=:a2 and Zt=:a3') ;
            parameters.ParamByName('a1').DataType:=Ftstring;
            parameters.ParamByName('a1').Value := Trim(sLoginID);
            parameters.ParamByName('a2').DataType :=Ftstring;
            parameters.ParamByName('a2').Value := Trim(sPassword);
            parameters.ParamByName('a3').DataType :=Ftstring;
            parameters.ParamByName('a3').Value := 'T';
            Open;
            nCode:= 3;
            if RecordCount = 0 then begin
              nCode:= 4;
              DefMsg := MakeDefaultMsg(SM_USERM2LOGIN_FAIL, 0, 0, 0, 0);
              nCode:= 5;
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
              UserInfo.boKick := True;
              UserInfo.dwKickTick := GetTickCount + 5000;
            end else begin
              nCode:= 6;
              FillChar(UserInfo1, SizeOf(TM2UserInfo), 0);
              UserInfo1.sAccount := sLoginID;
              UserInfo1.sUserQQ := FieldByName('QQ').AsString;
              UserInfo1.nDayMakeNum := FieldByName('DayMakeNum').AsInteger;
              UserInfo1.nMaxDayMakeNum := g_btMaxDayMakeNum;
              UserInfo1.sAddrs := FieldByName('IPAddress').AsString;
              UserInfo1.dTimer := FieldByName('Timer').AsDateTime;
              UserInfo1.sGameListUrl:= FieldByName('GameListUrl').AsString;//公司
              UserInfo1.sBakGameListUrl:= FieldByName('BakGameListUrl').AsString;//IP地址
              UserInfo1.sPatchListUrl:= FieldByName('PatchListUrl').AsString;//硬件信息
              UserInfo1.nUpType:= FieldByName('UpType').AsInteger;//修改资料类型
              UserInfo1.nUpDataNum:= FieldByName('UpdataNum').AsInteger;
              UserInfo.sAccount := sLoginID;
              UserInfo.sPassword := sPassword;
              UserInfo.boLogined := True;
              nCode:= 7;
              DefMsg := MakeDefaultMsg(SM_USERM2LOGIN_SUCCESS, 0, 0, 0, 0);
              sSENDTEXT := EncryptBuffer(@UserInfo1, SizeOf(TM2UserInfo));
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + sSENDTEXT);
              DefMsg := MakeDefaultMsg(SM_M2USERVERSION, 0, 0, 0, 0);
              FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg) + g_s176M2Version);
              nCode:= 8;
              sTimer:= FieldByName('Timer').AsDateTime;
              if int(sTimer) <> int(Date()) then begin//日期不一致,则清0
                nCode:= 9;
                Close;
                SQL.Clear;
                SQL.Add('Update M2UserInfo176 set dayMakeNum=:a1,IPAddress=:a2,Timer=GetDate() Where [User]=:a4') ;
                parameters.ParamByName('a1').DataType:=FtInteger;
                parameters.ParamByName('a1').Value := 0;
                parameters.ParamByName('a2').DataType:=Ftstring;
                parameters.ParamByName('a2').Value := UserInfo.sUserIPaddr;
                parameters.ParamByName('a4').DataType :=Ftstring;
                parameters.ParamByName('a4').Value := Trim(sLoginID);
                nCode:= 10;
                ExecSQL;
              end else begin
                nCode:= 11;
                Close;
                SQL.Clear;
                SQL.Add('Update M2UserInfo176 set IPAddress=:a1,Timer=GetDate() Where [User]=:a3') ;
                parameters.ParamByName('a1').DataType:=Ftstring;
                parameters.ParamByName('a1').Value := UserInfo.sUserIPaddr;
                parameters.ParamByName('a3').DataType :=Ftstring;
                parameters.ParamByName('a3').Value := Trim(sLoginID);
                nCode:= 12;
                ExecSQL;
              end;
            end;
          end;
        finally
         FrmDm.ADOconn.Close;
        end;
      end else begin
        DefMsg := MakeDefaultMsg(SM_USERM2LOGIN_FAIL, 1, 0, 0, 0);
        FrmMain.SendGateMsg(UserInfo.Socket, UserInfo.sSockIndex, EncodeMessage(DefMsg));
        UserInfo.boKick := True;
        UserInfo.dwKickTick := GetTickCount;
      end;
    end;
  except
    on E: Exception do begin
      FrmMain.MainOutMessage('[Exception] T176M2QueryThread.Execute Code:'+IntToStr(nCode)+' '+E.Message);
    end;
  end;
end;

end.
