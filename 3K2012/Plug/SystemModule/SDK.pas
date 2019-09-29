unit SDK;

interface
uses
  Windows, SysUtils,Controls, Forms, SystemManage, {IdTCPClient, IdHTTP, HttpProt,}
  ShellApi, ExtCtrls, Classes, uFileUnit, Clipbrd;
var
  boSetLicenseInfo, boSetUserLicense, boTodayDate: Boolean;
  TodayDate: TDate;
  m_btUserMode: Byte;
  m_wCount: Word;
  m_wPersonCount: Word;
  m_nErrorInfo: Integer;
  m_btStatus: Byte;
  m_dwSearchTick: Longword;
  m_dwSearchTime: Longword = 1000 * 60 * 60 * 6; //6个小时重新读取注册信息
type
  TMyTimer = class(TObject) //去掉新版提示功能
    Timer: TTimer;
    procedure OnTimer(Sender: TObject);
  end;
  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
  TFindProc = function(ProcName: PChar; nNameLen: Integer): Pointer; stdcall;
  TSetProc = function(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean; stdcall;
  TFindObj = function(ObjName: PChar; nNameLen: Integer): TObject; stdcall;

  TGetFunAddr = function(nIndex: Integer): Pointer; stdcall;
  TFindOBjTable_ = function(ObjName: PChar; nNameLen, nCode: Integer): TObject; stdcall;
  TSetProcCode_ = function(ProcName: PChar; nNameLen, nCode: Integer): Boolean; stdcall;
  TSetProcTable_ = function(ProcAddr: Pointer; ProcName: PChar; nNameLen, nCode: Integer): Boolean; stdcall;
  TFindProcCode_ = function(ProcName: PChar; nNameLen: Integer): Integer; stdcall;
  TFindProcTable_ = function(ProcName: PChar; nNameLen, nCode: Integer): Pointer; stdcall;
  TStartPlug = function(): Boolean; stdcall;
  TSetStartPlug = function(StartPlug: TStartPlug): Boolean; stdcall;
  TChangeCaptionText = procedure(Msg: PChar; nLen: Integer); stdcall; //20080404
  TSetUserLicense = procedure(nDay, nUserCout: Integer); stdcall;
  TFrmMain_ChangeGateSocket = procedure(boOpenGateSocket: Boolean; nCRCA: Integer); stdcall;

function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
procedure UnInit(); stdcall;
procedure StartModule(); stdcall;
function GetLicenseInfo(var nSearchMode: Integer; var nDay: Integer; var nPersonCount: Integer): Integer; stdcall; //20071229
function RegisterName: PChar; stdcall;
function RegisterLicense(sRegisterInfo, sUserName: PChar): Integer; stdcall;
function GetUserVersion: Boolean;
function GetUserName: Boolean;//检查是否为3KM2 20081203
function GetUserNameInit: Boolean;//检查M2是否注册 20090708
function GetUserNameInit1: Boolean;//检查M2的剩余天数 20090720
//function Start(): Boolean; stdcall; 20080330 去掉新版提示功能
//function GetProductVersion: Boolean; stdcall; 20080330 去掉新版提示功能
//function GetVersionNumber: Integer;20080330 去掉新版提示功能
procedure InitTimer(); //20080330 去掉新版提示功能
procedure UnInitTimer(); //20080330 去掉新版提示功能   
procedure GetDateIP(Src: PChar; Dest: PChar); stdcall;  //DLL输出加解函数过程 20080217
function GetSysDate(Dest: PChar): Boolean; stdcall;//输出插件标识，以判断是否3K自己的系统插件 20081203
procedure GetDLLUers;//DLL判断是哪个EXE加载
function GetProductAddress(Src0: PChar): Boolean; stdcall;//访问指定网站文本,如果为特殊指令,则在M2关于上显示相关信息(输出由M2调用)
function GetHintInfAddress(Src0: PChar): Boolean; stdcall;//访问指定网站文本,取广告
implementation
uses Module, EncryptUnit, EDcode, DESTRING, SystemShare;
var
  MyTimer: TMyTimer;//20080330 去掉新版提示功能
  ExetModuleHandle : HMODULE;
  //sHomePage: string;
const
  ProductVersion = 20100826;//版本号,要与M2 Common.pas 中的nProductVersion
  SuperUser = 927746880; //飘飘网络  此处要与M2相关的(M2Share.pas)Version变量相同
  Version = SuperUser;

//\M2Engine2\M2字符加解密\M2加密解密 下的加解密工具处理
  s001 = 'U3RhcnRNb2R1bGU='; //StartModule
  s002 = 'R2V0TGljZW5zZUluZm8='; //GetLicenseInfo
  s003 = 'R2V0UmVnaXN0ZXJOYW1l'; //GetRegisterName
  s004 = 'UmVnaXN0ZXJMaWNlbnNl'; //RegisterLicense
  s005 = 'U2V0VXNlckxpY2Vuc2U='; //SetUserLicense
  s006 = 'Q2hhbmdlR2F0ZVNvY2tldA=='; //ChangeGateSocket
  s007 = 'R2V0RGF0ZUlQ';//GetDateIP 20080217
  s008 = 'R2V0UHJvZHVjdEFkZHJlc3M=';//GetProductAddress 20081018
  s009 = 'R2V0U3lzRGF0ZQ==';//GetSysDate 20081203
  sFunc002 = 'RGVjb2RlUmVnaXN0ZXJDb2Rl';//DecodeRegisterCode
  s010 = 'R2V0SGludEluZkFkZHJlc3M=';//GetHintInfAddress

//\Plug\SystemModule\EDoceInfo.exe
  sSellInfo = '96pstSUvFYLy8PSepnmBhjvDvCSXEsyDFd19J+nnUHaZLyrv2vE6TS4sy7DxCJXi6rYqZt6eyCALKUj7B9v1g4ZG4BU='; //本软件还没有注册，注册使用请联系我们销售人员。
{$IF Version = SuperUser}
  s107 = '0XPH8qlzCNQ='; //200 未注册时的使用人数
  _sHomePage = '/Wlf60j2Z4CQufeEBVkfuGD4Sfab8JcnCzI2G7VZsF0='; //http://www.92m2.com  升级网站地址  20080309
  _sRemoteAddress = '/Wlf60j2Z4CQufeEBVkfuGD4Sfab8JcnCyPXNlnWKRNW4zKX8kO6TtvvJfkvHdnihKDGSyABAQ8='; //http://www.92m2.com.cn/m2/Version.txt  网站上的版本号
{$IFEND}
  s101 = '4FpI8JssNk/WYWymDpQ6SYvMdDBprVcY'; //正在初始化...
  {$IF UserMode1 = 1}
  s109 ='96pvZ8Kiz7GMENhj85yRC0dPr/YD3bUEvMJ9C5zZDTfd5gQWsHXiJJodldtNT1aG0HzxOu3nVNC1TmhqTZFHn15Z/w9hMBiPfSPfZ8Am916Q6VMRr9S3Iqyq49nZkwzl';//本程序已被非法修改，查看你机器是否已经中毒，建议你重装WINDOWS系统！ 20080806
  s110 ='0TfMYquvydSEf2/T';//3K软件 20100317
  s111 ='ql6YtXTr6Jr8YbpD9xV6yDrEAGyCe2G6IeG1B0OPuBFb/Og+lqavCuJldr5RO2sqQxUPnXhBqQV45/G1jC66QFDMNCHVuO6DiLUG2xoyQ60=';//如系统没毒出现这种情况，请查看 说明书→疑问解答→第17条。 20080806
  s112 ='6WL+CiqqEfx9hROmEbprtEgOKV/r+PUMmrYTCv+BERcPvg8PB2COn7llDfg=';//官方网站 http://www.3KM2.com 20100317
  sFunc001 = 'Q2hhbmdlQ2FwdGlvblRleHQ=';//ChangeCaptionText  //\M2Engine2\M2字符加解密\M2加密解密 下的加解密工具处理
  s102 = 'wtrWQEI2E525hAdz2Qv74mj2Oeg=';//www.3KM2.com
  s103 = '4DdISVTdY8TsgQG//7LeVCXx3ZWkIy7GOa+Iu4Q1hB19AMu7g1c8M5F+X4AQb1ePX6j7dg==';//注册人数:%d 剩余天数:%d www.3KM2.com
  s104 = 'q6yCY4VADVkMHX12zwFhQnPIIST7u0+nkowr42XaC5zCOVK8b+iTtwizEeyJA4w+APqpktxyQCU=';//无限用户模式 剩余天数:%d www.3KM2.com
  s105 = 'q6yCY4VADVkMHX12zwFhQnPIIST7u0wxjLpPTXureIboYi2OE/HATIHylpF2xyF+eA1aiqNk8E0=';//无限用户模式 剩余次数:%d www.3KM2.com
  s106 = 'q6yCY4VADVkMHX12zwFhQnP7Wp/lJ7GZm+8Hlf4ObLup4brtkctEWA==';//无限用户模式 www.3KM2.com
  sFunc003 = 'd3d3LklHRU0yLmNvbQ=='{www.IGEM2.com};//系统插件标识 20100317 (\M2Engine2\M2字符加解密\M2加密解密\Project1.exe)
  {$ELSE}
  s102 = '4DdISVTdY8TsgQG//7LeVCXx3ZWkIy7GOa+Iu4Q1hB19AMu7g1c8M5F+X4AQb1ePX6j7dg==';//注册人数:%d 剩余天数:%d www.3KM2.com
  sFunc003 = 'd3d3LjNLTTIuY29tXS5uZXQ='{www.3KM2.com].net};//系统插件标识 20100317 (\M2Engine2\M2字符加解密\M2加密解密\Project1.exe)
  {$IFEND}
  //sFunc0031 = 'd3d3LjNLTTIuY29t'{www.3KM2.com};//系统插件标识 20100317  (\M2Engine2\M2字符加解密\M2加密解密\Project1.exe)
  sFunc0031 = '{{{"?GA>"oca'{www.3KM2.com};//系统插件标识 20100428 使用 SetData加密     
 //sFunc003 = 'MjAwODEyMDM='{一统的内功版 20081203};
  
  //_sProductAddress ='8sXyOcaAm+IWwL4knG2txYfJf/MkuhQrQPmEKHA0m2VjrIXWJqfclPm8muY=';//http://www.66h6.net/ver.txt 放特殊指令的文本
  //_sProductAddress1 ='{{{"5>a>"oca"ob';//www.92m2.com.cn //改版权指令(文本里需加密),即网站文本第一行内容
(*文本内容
{{{"5>a>"oca"ob
XXXX反外挂防攻击数据引擎|XX科技|http://www.XXm2.com(官网站)|http://www.XXX.com.cn(程序站)|欢迎使用XX科技系列软件:|联系(QQ):888888 电话:8888888|
*)

  s_sProductUrl ='/Wlf60j2Z4CQtSYfzKi0xfy42mjz1ayRENDUtqbIIHqPyJPF';//http://127.0.0.1/ver.txt

 //判断一个字符串是否为数字{填充垃圾代码}
function IsNum(str: string):boolean;
var
  i:integer;
begin
  for i:=1 to length(str) do
    if not (str[i] in ['0'..'9']) then begin
      Result:=false;
      exit;
    end;
  Result:=true;
end;

//取许可信息
function GetLicenseInfo(var nSearchMode: Integer; var nDay: Integer; var nPersonCount: Integer): Integer; //20071229
{$IF UserMode1 = 1}
var
  UserMode, btStatus: Byte;
  wCount, wPersonCount: Word;
  ErrorInfo, nCheckCode, nCount: Integer;
  boUserVersion: Boolean;
  s11, s12, s13, s14, s15, s16, s17, s18, sTemp: string;
  fs:TFormatSettings;
{$IFEND}
begin
{$IF Mode1= 1}
  Result := 0;
Try
{$IF UserMode1 = 1}
  if not GetUserName then Exit;//检查是否为3K版M2 20081203
  boUserVersion := GetUserVersion; //取M2版本号
  nCheckCode := Integer(boUserVersion);
  UserMode := 0;
  wCount := 0;
  wPersonCount := 0;
  ErrorInfo := 0;
  btStatus := 0;
  nDay := 0;
  nPersonCount := 0;
  if not boUserVersion then Exit;
  if (TodayDate <> Date) or (GetTickCount - m_dwSearchTick >= m_dwSearchTime) or (nSearchMode = 1) then begin
{$IF TESTMODE = 1}
    MainOutMessasge('SystemModule GetLicenseInfo', 0);
{$IFEND}
    TodayDate := Date;
    m_dwSearchTick := GetTickCount;
    s11 := DecodeInfo(s101);
    LaJiDaiMa;
    s12 := DecodeInfo(s102);
    s13 := DecodeInfo(s103);
    LaJiDaiMa;
    s14 := DecodeInfo(s104);
    LaJiDaiMa;
    s15 := DecodeInfo(s105);
    s16 := DecodeInfo(s106);
    s17 := DecodeInfo(s107);
    s18 := DecodeInfo(s108);
    InitLicense(Version * nCheckCode, 0, 0, 0, Date, PChar(IntToStr(Version)));
    LaJiDaiMa;
    GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
    LaJiDaiMa;
    if (wCount = 0) and (btStatus = 0) and (ErrorInfo = 0) then begin //进入免费试用模式
      if ClearRegisterInfo then begin
        nCount := Str_ToInt(s17, 0);
        LaJiDaiMa;
        //InitLicense(Version * nCheckCode, 1, High(Word), nCount, Date, PChar(IntToStr(Version)));
{$IF UserMode1 = 1}
        fs.ShortDateFormat:='yyyy-mm-dd';
        fs.DateSeparator:='-';
        LaJiDaiMa;
        InitLicense(Version * nCheckCode, 2, High(Word), nCount, StrToDate(s18, Fs), PChar(IntToStr(Version)));//限制使用日期 20080701
        GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
        LaJiDaiMa;
        UnInitLicense();
{$IFEND}
      end;
    end;
    UnInitLicense();
{$IF TESTMODE = 1}
    MainOutMessasge('SystemModule GetLicenseInfo nSearchMode: ' + IntToStr(nSearchMode), 0);
    MainOutMessasge('SystemModule GetLicenseInfo UserMode: ' + IntToStr(UserMode), 0);
    MainOutMessasge('SystemModule GetLicenseInfo wCount: ' + IntToStr(wCount), 0);
    MainOutMessasge('SystemModule GetLicenseInfo wPersonCount: ' + IntToStr(wPersonCount), 0);
    MainOutMessasge('SystemModule GetLicenseInfo ErrorInfo: ' + IntToStr(ErrorInfo), 0);
    MainOutMessasge('SystemModule GetLicenseInfo btStatus: ' + IntToStr(btStatus), 0);
{$IFEND}
    if ErrorInfo = 0 then begin
      case UserMode of
        0: Exit;
        1: begin
            if btStatus = 0 then
              sTemp := Format(s15, [wCount])
            else sTemp := Format(s13, [wPersonCount, wCount]);
            ChangeCaptionText(PChar(sTemp), Length(sTemp));  //20080210
            LaJiDaiMa;
            if Assigned(SetUserLicense) then begin
              SetUserLicense(wCount, wPersonCount);
              LaJiDaiMa;
            end;
          end;
        2: begin
            if btStatus = 0 then
              sTemp := Format(s14, [wCount])
            else begin
              {$IF UserMode1 = 1}
                sTemp := Format(s12, [wCount]);
              {$ELSE}
                sTemp := Format(s12, [wPersonCount, wCount]);
              {$IFEND}
              LaJiDaiMa;
            end;
            ChangeCaptionText(PChar(sTemp), Length(sTemp)); //20080210
            if Assigned(SetUserLicense) then begin
              SetUserLicense(wCount, wPersonCount);
              LaJiDaiMa;
            end;
          end;
        3: begin
            ChangeCaptionText(PChar(s16), Length(s16));  //20080210
            if Assigned(SetUserLicense) then begin
              SetUserLicense(wCount, wPersonCount);
              LaJiDaiMa;
            end;
          end;
      end;
    end;
    m_btUserMode := UserMode;
    m_wCount := wCount;
    m_wPersonCount := wPersonCount;
    m_nErrorInfo := ErrorInfo;
    m_btStatus := btStatus;
  end;
  if (m_nErrorInfo = 0) and (m_btUserMode > 0) then begin
    nDay := m_wCount div nCheckCode;
    LaJiDaiMa;
    nPersonCount := m_wPersonCount div nCheckCode;
    Result := nCode div nCheckCode;
    LaJiDaiMa;
  end else begin
    nDay := 0;
    nPersonCount := 0;
    Result := 0;
  end;
  nSearchMode:=ProductVersion;//20071229 增加
{$IFEND}
  except
    MainOutMessasge('[异常] SystemModule:GetLicenseInfo',0);
  end;
{$IFEND}
end;

function RegisterName: PChar;
begin
{$IF Mode1= 1}
  Try
  InitLicense(Version, 0, 0, 0, Date, PChar(IntToStr(Version)));
  Result := PChar(GetRegisterName());
  UnInitLicense();
  except
    MainOutMessasge('[异常] SystemModule:RegisterName',0);
  end;
{$IFEND}
end;

function RegisterLicense(sRegisterInfo, sUserName: PChar): Integer;
begin
{$IF Mode1= 1}
  Result := 0;
  Try
  InitLicense(Version, 0, 0, 0, Date, PChar(IntToStr(Version)));
  Result := StartRegister(sRegisterInfo, sUserName);
  UnInitLicense();
  except
    MainOutMessasge('[异常] SystemModule:RegisterLicense',0);
  end;
{$IFEND}
end;

function GetUserVersion: Boolean;
var
  TPlugOfEngine_GetUserVersion: function(): Integer; stdcall;
  nEngineVersion: Integer;
  sFunctionName: string;
const
  _sFunctionName = 'yjFY8Gs4+t6Flr9aDSBsMraPVCmnauXafWelDD4yj5kQ4E8SBkk3prp8k/o='; //TPlugOfEngine_GetUserVersion
begin
  Result := False;
{$IF Mode2= 1}
  Try
    sFunctionName := DecodeInfo(_sFunctionName);
    if sFunctionName = '' then Exit;
    @TPlugOfEngine_GetUserVersion := GetProcAddress(ExetModuleHandle, PChar(sFunctionName));
    if Assigned(TPlugOfEngine_GetUserVersion) then begin
      nEngineVersion := TPlugOfEngine_GetUserVersion();
      LaJiDaiMa;
      if nEngineVersion <= 0 then Exit;
      if nEngineVersion = Version then Result := True;
    end;
  except
    MainOutMessasge('[异常] SystemModule:GetUserVersion',0);
  end;
{$IFEND}
end;

//------------------------------------------------------------------------------
//字符串加解密函数 20080217
Function SetDate(Text: String): String;
Var
 I: Word;
 C: Word;
Begin
  Result := '';
  {$IF Mode2= 1}
  For I := 1 To Length(Text) Do Begin
    C := Ord(Text[I]);
    Result := Result + Chr((C Xor 12));
  End;
  {$IFEND}
End;

//检查M2的标题，是否与插件设置的标识一致 20081203
function GetUserName: Boolean;
var
  _GetUserName: function(): PChar; stdcall;
  _GetUserVersion: function(): Integer; stdcall;//检查与M2的使用模式是否一致 UserMode1
  sEngineVersion: PChar;
  sFunctionName: string;
  nCode: Byte;
const
  _sFunctionName = 'yjFY8Gs4+t6Flr9aDSBsMraPVCmnauXafWelDCTsTRrUanXNBVPLVg=='; //TPlugOfEngine_GetUserName
  _sFunctionName2 ='yjFY8Gs4+t6Flr9aDSBsMraPVCmnauXafWelDCSNGs9IHKHmrc9BPw==';//TPlugOfEngine_GetUserMode
  //sFunc0031 = 'd3d3LjNLTTIuY29t'{www.3KM2.com}; //一统内功版
begin
  Result := False;
 {$IF Mode2= 1}
  nCode:= 0;
  Try
    sFunctionName := DecodeInfo(_sFunctionName);
    nCode:= 1;
    if sFunctionName = '' then Exit;
    nCode:= 2;
    @_GetUserName := GetProcAddress(ExetModuleHandle, PChar(sFunctionName));
    sEngineVersion := nil;
    LaJiDaiMa;
    if Assigned(_GetUserName) then begin
      nCode:= 3;
      sEngineVersion := _GetUserName();
      if sEngineVersion <> '' then begin
        nCode:= 4;
        //if Pos(Base64DecodeStr(sFunc0031), sEngineVersion) > 0 then Result := True;
        if Pos(SetDate(sFunc0031), sEngineVersion) > 0 then Result := True;//20100428 更换算法
      end;
      {$IF TESTMODE = 1}
      //MainOutMessasge('A Result:'+booltostr(Result)+' sEngineVersion:'+sEngineVersion+'  sFunc0031:'+SetDate(sFunc0031),0);
      {$IFEND}
      //if Pos(Base64DecodeStr(sFunc0031), sEngineVersion) > 0 then  Result := True;//一统内功版
    end;
    nCode:= 5;
    //检查M2的使用模式是否一致
    if Result then begin
      nCode:= 6;
      sFunctionName := DecodeInfo(_sFunctionName2);
      LaJiDaiMa;
      if sFunctionName = '' then Exit;
      nCode:= 7;
      @_GetUserVersion := GetProcAddress(ExetModuleHandle, PChar(sFunctionName));
      if Assigned(_GetUserVersion) then begin
        nCode:= 8;
        if _GetUserVersion() <> UserMode1 then  Result := False;
        {$IF TESTMODE = 1}
        //MainOutMessasge('B Result:'+booltostr(Result)+'  '+inttostr(UserMode1),0);
        {$IFEND}
      end;
    end;
  except
    MainOutMessasge('[异常] SystemModule:GetUserName Code:'+inttostr(nCode),0);
  end;
   {$IFEND}
end;
//检查M2是否注册 1表示已注册 20090708
function GetUserNameInit: Boolean;
var
  _GetUserNameInit: function(): Integer; stdcall;
  sEngineVersion: Integer;
  sFunctionName: string;
const
  _sFunctionName = 'yjFY8Gs4+t6Flr9aDSBsMraPVCmnauXafWelDCTsTRrUJa2CpkINGoIUp6A='; //TPlugOfEngine_GetUserNameInit
begin
  Result := False;
  {$IF Mode2= 1}
  Try
    sFunctionName := DecodeInfo(_sFunctionName);
    LaJiDaiMa;
    if sFunctionName = '' then Exit;
    @_GetUserNameInit := GetProcAddress(ExetModuleHandle, PChar(sFunctionName));
    if Assigned(_GetUserNameInit) then begin
      sEngineVersion := _GetUserNameInit();
      if sEngineVersion = 0 then Result := True;
      {$IF TESTMODE = 1}
       MainOutMessasge('sEngineVersion:'+inttostr(sEngineVersion), 0);
      {$IFEND}
    end;
  except
    MainOutMessasge('[异常] SystemModule:GetUserNameInit',0);
  end;
   {$IFEND}
end;
//检查M2的剩余天数 20090720
function GetUserNameInit1: Boolean;
var
  _GetUserNameInit: function(): Integer; stdcall;
  sEngineVersion: Integer;
  sFunctionName: string;
const
  _sFunctionName ='yjFY8Gs4+t6Flr9aDSBsMraPVB43khzpdZgH1oPagmpssXH0b8bhSeZwMZbLG1vj';//TPlugOfEngine_HealthSpellChanged1
begin
  Result := False;
  {$IF Mode2= 1}
  Try
    sFunctionName := DecodeInfo(_sFunctionName);
    if sFunctionName = '' then Exit;
    @_GetUserNameInit := GetProcAddress(ExetModuleHandle, PChar(sFunctionName));
    if Assigned(_GetUserNameInit) then begin
      sEngineVersion := _GetUserNameInit();
      if sEngineVersion > 0 then Result := True;
      {$IF TESTMODE = 1}
       MainOutMessasge('Daye sEngineVersion:'+inttostr(sEngineVersion), 0);
      {$IFEND}
    end;
  except
    MainOutMessasge('[异常] SystemModule:GetUserNameInit1',0);
  end;
   {$IFEND}
end;

{=================================================================
  功  能: DLL判断是哪个EXE加载
  说  明：uses Windows;
  参  数:
  返回值:  加载EXE程序的文件名
=================================================================} 
procedure GetDLLUers;
var 
  CArr:Array[0..256] of char;
  FileName: string;
begin
{$IF Mode2= 1}
  Try
  ZeroMemory(@CArr,sizeof(CArr));
  GetModuleFileName(GetModuleHandle(nil),CArr,sizeof(CArr));
  FileName:=ExtractFileName(CArr);//CArr--EXE的全路径
  if CompareText(FileName, SetDate('A>_i~zi~"iti')) <> 0 then begin //如果不是 M2Server.exe加载则关机
    ShellExecute( 0,'open','shutdown.exe', ' -s -t 0',nil,SW_HIDE);//uses ShellApi; 关机
  end;
  except
  end;
 {$IFEND}
end;
//DLL输出加解函数过程 20080217
procedure GetDateIP(Src: PChar; Dest: PChar);
var
  sEncode: string;
  sDecode: string;
begin
{$IF Mode3= 1}
  try
    SetLength(sEncode, Length(Src));
    Move(Src^, sEncode[1], Length(Src));
    sDecode := SetDate(sEncode);
    Move(sDecode[1], Dest^, Length(sDecode));
  except
  end;
{$IFEND}
end;

//输出插件标识，以判断是否3K自己的系统插件 20081203
function GetSysDate(Dest: PChar): Boolean;
var
  Str{,Str1}: string;
begin
  Result := False;
  {$IF Mode3= 1}
  try
    Str:= Base64DecodeStr(sFunc003);
    {$IF TESTMODE = 1}
     MainOutMessasge('Str:'+Str+'  Dest:'+Dest,0);
    {$IFEND}
    Result := Str = Dest;
  except
  end;
  {$IFEND}
end;
//------------------------------------------------------------------------------
procedure StartModule();
var
  UserMode, btStatus, m_nCode: Byte;
  wCount, wPersonCount: Word;
  ErrorInfo, nPersonCount, nCheckCode: Integer;
  boUserVersion: Boolean;
  sTemp, s2, s3, s4, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20: string;
  fs:TFormatSettings;
begin
  m_nCode:= 0;
  try
    GetDLLUers;//DLL判断是哪个EXE加载
    boUserVersion := GetUserVersion;
    m_nCode:= 1;
    nCheckCode := Integer(boUserVersion);
    if not boUserVersion then Exit;
    UserMode := 0;
    wCount := 0;
    wPersonCount := 0;
    ErrorInfo := 0;
    btStatus := 0;
    m_nCode:= 3;
    if not GetUserName then Exit;//检查是否为3K版M2 20081203
{$IF UserMode1 = 0}
    m_nCode:= 2;
    if Assigned(ChangeGateSocket) then begin
      ChangeGateSocket(True, nCode);//设置Socket连接属性,让M2连接上游戏网关
      Exit;
    end;
{$ELSEIF UserMode1 = 2}
    m_nCode:= 20;
    if Assigned(ChangeGateSocket) then begin
      ChangeGateSocket(True, nCode);//设置Socket连接属性,让M2连接上游戏网关
      InitTimer;//安装定时器，定时检查M2是否注册 20090708
      Exit;
    end;
{$ELSEIF UserMode1 = 1}
    m_nCode:= 4;
    s11 := DecodeInfo(s101);
    s12 := DecodeInfo(s102);
    s13 := DecodeInfo(s103);
    s14 := DecodeInfo(s104);
    s15 := DecodeInfo(s105);
    s16 := DecodeInfo(s106);
    s17 := DecodeInfo(s107);
    s18 := DecodeInfo(s108);
{$IFEND}
    m_nCode:= 5;
    if s11 = '' then Exit;
    if s12 = '' then Exit;
    if s13 = '' then Exit;
    if s14 = '' then Exit;
    if s15 = '' then Exit;
    if s16 = '' then Exit;
    if s17 = '' then Exit;
    m_nCode:= 6;
    if Assigned(ChangeCaptionText) then begin
      ChangeCaptionText(PChar(s11), Length(s11)); //20080210
    end else Exit;
    nPersonCount := Str_ToInt(s17, 0);
    //InitLicense(Version * nCheckCode, 1, High(Word), nPersonCount, Date, PChar(IntToStr(Version)));//限制 200人,使用次数
    {$IF UserMode1 = 1}
    fs.ShortDateFormat:='yyyy-mm-dd';
    fs.DateSeparator:='-';
    m_nCode:= 7;
    InitLicense(Version * nCheckCode, 2, High(Word), nPersonCount, StrToDate(s18,fs), PChar(IntToStr(Version)));//限制使用日期 20080701
    //m_nCode:= 71;
    GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
    m_nCode:= 72;
    UnInitLicense();
    {$IFEND}

    m_nCode:= 8;
    if not boSetLicenseInfo then begin
      s2 := Base64DecodeStr(s002);
      s3 := Base64DecodeStr(s003);
      s4 := Base64DecodeStr(s004);
      if (GetProcCode(s2) = 2) and (GetProcCode(s3) = 3) and (GetProcCode(s4) = 4) then begin
        if {$IF Mode42= 1}SetProcAddr(@GetLicenseInfo, s2, 2) and{$IFEND} SetProcAddr(@RegisterName, s3, 3)
          and SetProcAddr(@RegisterLicense, s4, 4) then begin
          boSetLicenseInfo := True;
        end;
      end;
    end;  
    {$IF TESTMODE = 1}
    MainOutMessasge('Error:' + IntToStr(ErrorInfo)+' Mode:'+IntToStr(UserMode)+' Count:'+inttostr(wCount)+' PersonCount:'+IntToStr(wPersonCount)+' Info:'+booltostr(boSetLicenseInfo), 0);
    {$IFEND}

    m_nCode:= 9;
    if (boSetLicenseInfo) and (ErrorInfo = 0) and (UserMode > 0) then begin
      if (wCount = 0) and (btStatus = 0) then begin
        InitLicense(Version * nCheckCode, 0, 0, 0, Date, PChar(IntToStr(Version)));
        if ClearRegisterInfo then begin
          UnInitLicense();
          //InitLicense(Version * nCheckCode, 1, High(Word), nPersonCount, Date, PChar(IntToStr(Version)));
          {$IF UserMode1 = 1}
          fs.ShortDateFormat:='yyyy-mm-dd';
          fs.DateSeparator:='-';
          m_nCode:= 10;
          InitLicense(Version * nCheckCode, 2, High(Word), nPersonCount, StrToDate(s18,Fs), PChar(IntToStr(Version)));//限制使用日期 20080701
          GetLicense(UserMode, wCount, wPersonCount, ErrorInfo, btStatus);
          UnInitLicense();
          {$IFEND}
        end else UnInitLicense();
      end;
      m_nCode:= 11;
      case UserMode of
         0: Exit;
         1: begin
            if Assigned(ChangeGateSocket) then begin
              {$IF UserMode1 = 1}
              if wCount > 0 then ChangeGateSocket(True, nCode);
              {$ELSE}
               ChangeGateSocket(True, nCode);//设置Socket连接属性,让M2连接上游戏网关
              {$IFEND}
              if btStatus <= 0 then begin
                sTemp := Format(s15, [wCount])
              end else begin
                sTemp := Format(s13, [wPersonCount, wCount]);
                MainOutMessasge(DecodeInfo(sSellInfo), 0);//本软件还没有注册，注册使用请联系我们销售人员。 20080210
              end;
              ChangeCaptionText(PChar(sTemp), Length(sTemp)); //20080210
              if Assigned(SetUserLicense) then begin
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
        2: begin
            m_nCode:= 12;
            if Assigned(ChangeGateSocket) then begin
              {$IF UserMode1 = 1}
              m_nCode:= 13;
              if wCount > 0 then ChangeGateSocket(True, nCode);
              {$ELSE}
              m_nCode:= 14;
               ChangeGateSocket(True, nCode);
              {$IFEND}
              if btStatus = 0 then begin
                sTemp := Format(s14, [wCount])
              end else begin
              {$IF UserMode1 = 1}
                sTemp := Format(s12, [wCount]);
              {$ELSE}
                sTemp := Format(s12, [wPersonCount, wCount]);
                MainOutMessasge(DecodeInfo(sSellInfo), 0);//本软件还没有注册，注册使用请联系我们销售人员。20080210
              {$IFEND}
              end;
              m_nCode:= 15;
              ChangeCaptionText(PChar(sTemp), Length(sTemp));  //20080210
              m_nCode:= 16;
              if Assigned(SetUserLicense) then begin
                m_nCode:= 17;
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
        3: begin
            if Assigned(ChangeGateSocket) then begin
              ChangeGateSocket(True, nCode);
              ChangeCaptionText(PChar(s16), Length(s16)); //20080210
              if Assigned(SetUserLicense) then begin
                SetUserLicense(wCount div nCheckCode, wPersonCount div nCheckCode);
              end;
            end;
          end;
      end;
    end else begin
      {$IF UserMode1 = 1}
      m_nCode:= 18;
      s16 := DecodeInfo(s109);//20080806
      s17 := DecodeInfo(s110);
      s19 := DecodeInfo(s111); //20080806
      s20 := DecodeInfo(s112); //20080806
      m_nCode:= 19;
      Application.MessageBox(PChar(s16
      + #13#10#13#10 +
      s19
      + #13#10#13#10 +
      s20
      ), PChar(s17), MB_OK +
        MB_ICONSTOP);
      asm
        MOV FS:[0],0;
        MOV DS:[0],EAX;
      end;
      {$IFEND}
    end;
  except
    on E: Exception do MainOutMessasge('[异常] SystemModule:StartModule Code:'+inttostr(m_nCode)+ E.Message,0);
  end;
end;

//20080330 去掉新版提示功能
procedure TMyTimer.OnTimer(Sender: TObject);
begin
{  MyTimer.Timer.Enabled := False;
  if Application.MessageBox('发现新的引擎版本，是否下载？？？',
    '提示信息',
    MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    ShellExecute(0, 'open', PChar(sHomePage), nil, nil, SW_SHOWNORMAL);
  end;  }
{$I CodeReplace_Start.inc}//虚拟机标识
  if not GetUserNameInit then begin
    {$IF TESTMODE = 1}
     MainOutMessasge('SystemModule GetUserNameInit', 0);
    {$IFEND}
    if Assigned(SetUserLicense) then SetUserLicense(10, 10);
    //else if Assigned(ChangeGateSocket) then ChangeGateSocket(False, nCode);
  end;
  if not GetUserNameInit1 then begin
    {$IF TESTMODE = 1}
     MainOutMessasge('SystemModule GetUserNameInit1', 0);
    {$IFEND}
    if Assigned(SetUserLicense) then SetUserLicense(10, 10);
  end;
{$I CodeReplace_End.inc}
end;

procedure InitTimer();
begin
{$IF Mode5= 1}
  MyTimer := TMyTimer.Create;
  MyTimer.Timer := TTimer.Create(nil);
  MyTimer.Timer.Enabled := False;
  MyTimer.Timer.Interval := 300000;//5分钟执行一次
  MyTimer.Timer.OnTimer := MyTimer.OnTimer;
  MyTimer.Timer.Enabled := True;
{$IFEND}
end;

procedure UnInitTimer();
begin
{$IF Mode5= 1}
  try
    if MyTimer <> nil then begin
      if MyTimer.Timer <> nil then begin
        MyTimer.Timer.Enabled := False;//使用这两句,M2关闭出现异常  20080303
        MyTimer.Timer.Free;//使用这两句,M2关闭出现异常  20080303
      end;
      MyTimer.Free;
    end;
  except
  end;
{$IFEND}
end;

(*
function Start(): Boolean;
begin
  Result := True;
  GetProductVersion();//检查是否有新版本可下载  20080330 去掉新版提示功能
end;

//通过函数接口(TPlugOfEngine_GetProductVersion)取版本号码
function GetVersionNumber: Integer;
const
  _sFunctionName: string = 'sy9Tx6SlLAQ51ABF58beo2L7khJByhfnULaBAOEA5Qax9qBTBeWQ/auCD+TKnBub+zNo+A=='; //TPlugOfEngine_GetProductVersion
var
  TPlugOfEngine_GetProductVersion: function(): Integer; stdcall;
  sFunctionName: string;
begin
  Result := 0;
  sFunctionName := DecodeInfo(_sFunctionName);
  if sFunctionName = '' then Exit;
  @TPlugOfEngine_GetProductVersion := GetProcAddress(GetModuleHandle(PChar(Application.Exename)), PChar(sFunctionName));
  if Assigned(TPlugOfEngine_GetProductVersion) then begin
    Result := TPlugOfEngine_GetProductVersion;
  end;
end;
//检查网站上是否有新的M2提供下载    20080330 去掉新版提示功能
function GetProductVersion: Boolean;
var
  sRemoteAddress: string;
  nEngineVersion: Integer;
  IdHTTP: TIdHTTP;
  s: TStringlist;
  sEngineVersion: string;
  nRemoteVersion: Integer;
begin
  Result := False;
  sRemoteAddress := DecodeInfo(_sRemoteAddress);//指定网站上的版本文件
  sHomePage := DecodeInfo(_sHomePage);
  if sRemoteAddress = '' then Exit;
  if sHomePage = '' then Exit;
  nEngineVersion := GetVersionNumber; //取M2版本号, nEngineVersion :=20080306
  if nEngineVersion > 0 then begin
    {$IF Version = SuperUser}
    try
      IdHTTP := TIdHTTP.Create(nil);
      IdHTTP.ReadTimeout := 1500;
      s := TStringlist.Create;
      s.Text := IdHTTP.Get(sRemoteAddress);
      sEngineVersion := Trim(s.Text);
      s.Free;
      IdHTTP.Free;
      try
       // sEngineVersion := DecryStrHex(sEngineVersion, IntToStr(nEngineVersion)); //20080309 注释,服务器上的文件内容不加密
        nRemoteVersion := Str_ToInt(sEngineVersion, 0);
      except
        nRemoteVersion := 0;
      end;
      if nRemoteVersion {<}> nEngineVersion then begin//网站上的版本号大于当前M2的版本时,提示下载 20080319
        InitTimer();
      end;
    except
    end;
    {$IFEND}
    Result := True;
  end;
end;    *)

function CalcFileCRC(sFileName: string): Integer;
var
  i: Integer;
  nFileHandle: Integer;
  nFileSize, nBuffSize: Integer;
  Buffer: PChar;
  INT: ^Integer;
  nCrc: Integer;
begin
  Result := 0;
  {$IF Mode5= 1}
  Try
    if not FileExists(sFileName) then Exit;
    GetDLLUers;//DLL判断是哪个EXE加载
    LaJiDaiMa;
    nFileHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if nFileHandle = 0 then Exit;
    LaJiDaiMa;
    nFileSize := FileSeek(nFileHandle, 0, 2);
    nBuffSize := (nFileSize div 4) * 4;
    LaJiDaiMa;
    GetMem(Buffer, nBuffSize);
    LaJiDaiMa;
    FillChar(Buffer^, nBuffSize, 0);
    FileSeek(nFileHandle, 0, 0);
    LaJiDaiMa;
    FileRead(nFileHandle, Buffer^, nBuffSize);
    LaJiDaiMa;
    FileClose(nFileHandle);
    INT := Pointer(Buffer);
    nCrc := 0;
   // Exception.Create(IntToStr(SizeOf(Integer)));  //20080309 去掉
    for i := 0 to nBuffSize div 4 - 1 do begin
      nCrc := nCrc xor INT^;
      INT := Pointer(Integer(INT) + 4);
    end;
    FreeMem(Buffer);
    Result := nCrc;
  except
    MainOutMessasge('[异常] SystemModule:CalcFileCRC',0);
  end;
  {$IFEND}
end;

function Init(AppHandle: HWnd; MsgProc: TMsgProc; FindProc: TFindProc; SetProc: TSetProc; GetFunAddr: TGetFunAddr): PChar; stdcall;
var
  s01, s05, sFunc01, s06, s07, s08, s09, s10: string;
//  SetStartPlug: TSetStartPlug; 20080330 去掉新版提示功能
begin
  boSetLicenseInfo := False;
  TodayDate := 0;
  m_btUserMode := 0;
  m_wCount := 0;
  m_wPersonCount := 0;
  m_nErrorInfo := 0;
  m_btStatus := 0;
  m_dwSearchTick := 0;
  GetDLLUers;//DLL判断是哪个EXE加载
  s01 := Base64DecodeStr(s001); //StartModule
  s06 := Base64DecodeStr(s006); //ChangeGateSocket
  LaJiDaiMa;
  s07 := Base64DecodeStr(s007); //GetDateIP  20080217
  s08 := Base64DecodeStr(s008);//GetProductAddress 20081018
  LaJiDaiMa;
  s09 := Base64DecodeStr(s009);//GetSysDate 20081203
  s10 := Base64DecodeStr(s010);//GetHintInfAddress
{$IF UserMode1 = 1}
  s05 := Base64DecodeStr(s005); //SetUserLicense //20080404
  sFunc01 := Base64DecodeStr(sFunc001);//20080404
{$IFEND}
  OutMessage := MsgProc;
  FindProcCode_ := GetFunAddr(0);
  FindProcTable_ := GetFunAddr(1);
  LaJiDaiMa;
  SetProcTable_ := GetFunAddr(2);
  SetProcCode_ := GetFunAddr(3);
  FindOBjTable_ := GetFunAddr(4);
  //SetStartPlug := GetFunAddr(8); 20080330 去掉新版提示功能
  //SetStartPlug(Start);//20080330 去掉新版提示功能
  ChangeGateSocket := GetProcAddr(s06, 6);
{$IF UserMode1 = 1}
  SetUserLicense := GetProcAddr(s05, 5);//20080404
  ChangeCaptionText := GetProcAddr(sFunc01, 0); //20080404
{$IFEND}
  if GetProcCode(s01) = 1 then SetProcAddr(@StartModule, s01, 1);
  SetProcAddr(@GetSysDate, s09, 9{此数字对应M2里的数字});//输出插件标识，以判断是否3K自己的系统插件 20081203
  SetProcAddr(@GetDateIP, s07, 6{此数字对应M2里的数字}); //20080217 脚本加解密函数
  LaJiDaiMa;
  SetProcAddr(@GetProductAddress, s08, 8{此数字对应M2里的数字});//20081018 判断指令函数
  LaJiDaiMa;
  SetProcAddr(@GetHintInfAddress, s10, 10{此数字对应M2里的数字});
  MainOutMessasge(sLoadPlug, 0);
  LaJiDaiMa;
  Result := PChar(sPlugName);
  Application.Handle := AppHandle;
  ExetModuleHandle := GetModuleHandle(PChar(Application.ExeName));
  //MainOutMessasge(EncodeInfo('http://127.0.0.1/ver.txt'),0);
  {$IF TESTMODE = 1}
  s10 := inttostr(CalcFileCRC(Application.Exename));
  MainOutMessasge('M2 CRC:' + s10, 0);//取M2 CRC值
  Clipboard.AsText := s10;
  TerminateProcess(GetCurrentProcess, 0);
  {$IFEND}
end;

procedure UnInit(); stdcall;
begin
(*  {$IF Version = SuperUser}
  //UnInitTimer();//20080330 去掉新版提示功能
  {$IFEND}  *)
  {$IF UserMode1 = 2}
  UnInitTimer();
  {$IFEND}
  MainOutMessasge(sUnLoadPlug, 0);   Clipboard.AsText := inttostr(CalcFileCRC(Application.Exename));
end;

//访问指定网站文本,如果为特殊指令,则在M2上显示相关信息 20081018
function GetProductAddress(Src0: PChar): Boolean;
{var
  sRemoteAddress: string;
  IdHTTP: TIdHTTP;
  s: TStringlist;
  sEngineVersion, str0, Str1: string;}
begin
  Result := False;
(*  sRemoteAddress := DecodeInfo(_sProductAddress);//指定网站上的文件
  if sRemoteAddress = '' then Exit;
  Try
    IdHTTP := TIdHTTP.Create(nil);
    IdHTTP.ReadTimeout := 1400;//20081108
    S := TStringlist.Create;
    Try
      S.Text := IdHTTP.Get(sRemoteAddress);
      sEngineVersion := SetDate(Trim(S.Strings[0]));//取第一行的指令
      Str1:= SetDate(_sProductAddress1);
      str0:= Trim(S.Strings[1]);
    finally
      S.Free;
      IdHTTP.Free;
    end;
    if CompareText(sEngineVersion, Str1) = 0  then begin//判断是否为指定的指令(www.92m2.com.cn)
      try
        Move(str0[1], Src0^, Length(str0));
      except
      end; 
      Result := True;
    end;
  except
    //MainOutMessasge('{异常} GetProductAddress', 0);
  end;*)
end;
//字符串截取
function GetStr(StrSource, StrBegin, StrEnd: string): string;
var
  in_star,in_end:integer;
begin
  in_star:=AnsiPos(strbegin,strsource)+length(strbegin);
  in_end:=AnsiPos(strend,strsource);
  result:=copy(strsource,in_star,in_end-in_star);
end;

//访问指定网站文本,取广告
function GetHintInfAddress(Src0: PChar): Boolean;
{var
  sRemoteAddress, str0, Str1, Str2: string;
  IdHTTP: TIdHTTP;
  str, Source:TMemoryStream;
  //IdHTTPDownLoad: THttpCli;
  Size:Integer; }
begin
  Result := False;
(*  sRemoteAddress := DecodeInfo(_sProductUrl);//指定网站上的文件
  if sRemoteAddress = '' then Exit;
  Try
    IdHTTP := TIdHTTP.Create(nil);
    IdHTTP.ReadTimeout := 1400;
    str:= TMemoryStream.Create;
    Try
      IdHTTP.Get(sRemoteAddress, str);
      if str.Size > 0 then begin
        if DecryptToStream(str, 'cdvtfed20110511') then begin//流解密
          SetLength(str0, str.Size);
          str.Read(str0[1], str.Size);
        end;
      end;
    finally
      str.Free;
      IdHTTP.Free;
    end;
    if str0 <> '' then begin
      try
        Move(str0[1], Src0^, Length(str0));
        Result := True;
      except
        Result := False;
      end;
    end;
  except
    Result := False;
    //MainOutMessasge('{异常} GetHintInfAddress', 0);
  end;  *)


  //sRemoteAddress := 'http://hiphotos.baidu.com/cometo2011/pic/item/c6e364b33e48236b18d81f96.jpg';//指定网站上的文件
(*  Try
    sRemoteAddress :='http://hi.baidu.com/cometo2011/blog';
    IdHTTP := TIdHTTP.Create(nil);
    IdHTTP.ReadTimeout := 1400;
    Str:= TMemoryStream.Create;
    Source:= TMemoryStream.Create;
    Try
      if sRemoteAddress <> '' then begin
        Str1:= IdHTTP.Get(sRemoteAddress);
        if Str1 <> '' then begin
          Str1:= GetStr(Str1,'$BEGIN','$END');
          sRemoteAddress := Format('http://hiphotos.baidu.com/cometo2011/pic/item/%s.jpg',[Str1]);
          IdHTTP.Get(sRemoteAddress, Str);
          if Str.Size > 0 then begin
            Str.Position:= 54;
            Source.CopyFrom(Str, Str.Size - 54);//去掉BMP头结构，取出Ver.txt内容
            if Source.Size > 0 then begin
              if DecryptToStream(Source, 'cdvtfed20110511') then begin//流解密
                SetLength(str0, Source.Size);
                Source.Read(str0[1], Source.Size);
              end;
            end;
          end;
        end;
      end;
      if str0 <> '' then begin
        try
          Move(str0[1], Src0^, Length(str0));
          Result := True;
        except
          Result := False;
        end;
      end else begin//当百度图片读不到，则读网站的文本
        sRemoteAddress := DecodeInfo(_sProductUrl);//指定网站上的文件
        if sRemoteAddress <> '' then begin
          IdHTTP.Get(sRemoteAddress, Str);
          if Str.Size > 0 then begin
            if DecryptToStream(Str, 'cdvtfed20110511') then begin//流解密
              SetLength(str0, Str.Size);
              Str.Read(str0[1], Str.Size);
            end;
          end;
          if str0 <> '' then begin
            try
              Move(str0[1], Src0^, Length(str0));
              Result := True;
            except
              Result := False;
            end;
          end;
        end;
      end;
    finally
      Source.free;
      Str.Free;
      IdHTTP.Free;
    end;
  except
    Result := False;
    //MainOutMessasge('{异常} GetHintInfAddress', 0);
  end;  *)

(*  //THttpCli
  Try
    sRemoteAddress := DecodeInfo('04vhRzsoTd639e7QDi9gQl6cIqB7WBOCxUnmKoOKIuBUI3mudjojAoZVcbcwqsjqch/mp4mef90=');{'http://hi.baidu.com/cometo2011/blog'};
    IdHTTPDownLoad := THttpCli.Create(nil);
    IdHTTPDownLoad.ProxyPort := '80';
    IdHTTPDownLoad.LocationChangeMaxCount := 5;
    IdHTTPDownLoad.SocksLevel := '5';
    Str:= TMemoryStream.Create;
    Source:= TMemoryStream.Create;
    Try
      if sRemoteAddress <> '' then begin
        IdHTTPDownLoad.URL := sRemoteAddress;
        IdHTTPDownLoad.ContentRangeBegin := ''; //下载的开始字节
        IdHTTPDownLoad.ContentRangeEnd := ''; //下载到文件结束
        IdHTTPDownLoad.RcvdStream := Str;
        IdHTTPDownLoad.Get;
        Str.Position:= 0;
        if Str.Size > 0 then begin
          SetLength(Str1, Str.Size);
          Str.Read(Str1[1], Str.Size);
          Str1:= GetStr(Str1,'$BEGIN','$END');
          Str.Clear;
          IdHTTPDownLoad.Close;
          Str2:= DecodeInfo('1xXDFh8MNMe6HjzHnZA/4CFKOSoJ9CmPqxIWEoEjEMT9NdMrNIR0nXEmNo3OeiBsFis2etMSreIukqlu37srdDJU42MQuGfLWzmvTy8PLwvA');//'http://hiphotos.baidu.com/cometo2011/pic/item/%s.jpg'
          IdHTTPDownLoad.URL := Format(Str2,[Str1]);
          IdHTTPDownLoad.ContentRangeBegin := ''; //下载的开始字节
          IdHTTPDownLoad.ContentRangeEnd := ''; //下载到文件结束
          IdHTTPDownLoad.RcvdStream := Str;
          IdHTTPDownLoad.Get;
          if Str.Size > 0 then begin
            Str.Seek(-Sizeof(Size),soFromEnd);
            Str.ReadBuffer(Size,SizeOf(Size));
            if Str.Size > Size then begin
              Str.Seek(-Size,soFromEnd);
              Source.CopyFrom(Str,Size - SizeOf(Size));
              if Source.Size > 0 then begin
                if DecryptToStream(Source, 'cdvtfed20110511') then begin//流解密
                  SetLength(str0, Source.Size);
                  Source.Read(str0[1], Source.Size);
                end;
              end;
            end;
          end;
        end;
      end;
      if str0 <> '' then begin
        try
          Move(str0[1], Src0^, Length(str0));
          Result := True;
        except
          Result := False;
        end;
      end else begin//当百度图片读不到，则读网站的文本
        sRemoteAddress := DecodeInfo(_sProductUrl);//指定网站上的文件
        if sRemoteAddress <> '' then begin
          Str.Clear;
          IdHTTPDownLoad.Close;
          IdHTTPDownLoad.URL := sRemoteAddress;
          IdHTTPDownLoad.ContentRangeBegin := ''; //下载的开始字节
          IdHTTPDownLoad.ContentRangeEnd := ''; //下载到文件结束
          IdHTTPDownLoad.RcvdStream := Str;
          IdHTTPDownLoad.Get;
          if Str.Size > 0 then begin
            if DecryptToStream(Str, 'cdvtfed20110511') then begin//流解密
              SetLength(str0, Str.Size);
              Str.Read(str0[1], Str.Size);
            end;
          end;
          if str0 <> '' then begin
            try
              Move(str0[1], Src0^, Length(str0));
              Result := True;
            except
              Result := False;
            end;
          end;
        end;
      end;
    finally
      Source.free;
      Str.Free;
      IdHTTPDownLoad.Free;
    end;
  except
    Result := False;
    //MainOutMessasge('{异常} GetHintInfAddress', 0);
  end;   *)
end;

end.

