unit ObjRobot;  // liuzhigang 对象机器人？ 什么意思啊？

interface
uses
  Windows, Classes, SysUtils, DateUtils, ObjBase, Grobal2, SDK;
type
  TRobotObject = class(TPlayObject)
    m_sScriptFileName: string;
    m_AutoRunList: TList;
  private
    m_boRunOnWeek: Boolean; //是否已执行操作；
    procedure LoadScript();
    procedure ClearScript();
    procedure ProcessAutoRun();
    procedure AutoRun(AutoRunInfo: pTAutoRunInfo);
    procedure AutoRunOfOnWeek(AutoRunInfo: pTAutoRunInfo);
    procedure AutoRunOfOnDay(AutoRunInfo: pTAutoRunInfo);
    {procedure AutoRunOfOnHour(AutoRunInfo: pTAutoRunInfo);//20080818 注释
    procedure AutoRunOfOnMin(AutoRunInfo: pTAutoRunInfo);
    procedure AutoRunOfOnSec(AutoRunInfo: pTAutoRunInfo);}

  public
    constructor Create(); override;
    destructor Destroy; override;
    procedure SendSocket(DefMsg: pTDefaultMessage; sMsg: string); override;
    procedure ReloadScript();
    procedure Run(); override;
  end;
  TRobotManage = class
    RobotHumanList: TStringList;
  private
    procedure LoadRobot();
    procedure UnLoadRobot();
  public
    constructor Create();
    destructor Destroy; override;
    procedure RELOADROBOT();
    procedure Run;
  end;
implementation

uses M2Share, HUtil32;

{ TRobotObject }

procedure TRobotObject.AutoRun(AutoRunInfo: pTAutoRunInfo);
var
  nCode: byte;
begin
  nCode:= 0;
  try
    if (g_RobotNPC = nil) or (AutoRunInfo = nil) then Exit;
    nCode:= 1;
    if GetTickCount - AutoRunInfo.dwRunTick > AutoRunInfo.dwRunTimeLen then begin
      nCode:= 2;
      case AutoRunInfo.nRunCmd of //
        nRONPCLABLEJMP: begin
            nCode:= 21;
            case AutoRunInfo.nMoethod of //
              nRODAY: begin
                  if GetTickCount - AutoRunInfo.dwRunTick > 8640000{24 * 60 * 60 * 1000} * LongWord(AutoRunInfo.nParam1) then begin
                    nCode:= 3;
                    AutoRunInfo.dwRunTick := GetTickCount();
                    nCode:= 4;
                    g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False, False);
                  end;
                end;
              nROHOUR: begin
                  if GetTickCount - AutoRunInfo.dwRunTick > 3600000{60 * 60 * 1000 }* LongWord(AutoRunInfo.nParam1) then begin
                    nCode:= 5;
                    AutoRunInfo.dwRunTick := GetTickCount();
                    nCode:= 6;
                    g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False, False);
                  end;
                end;
              nROMIN: begin
                  if GetTickCount - AutoRunInfo.dwRunTick > 60000{60 * 1000} * LongWord(AutoRunInfo.nParam1) then begin
                    nCode:= 7;
                    AutoRunInfo.dwRunTick := GetTickCount();
                    nCode:= 8;
                    g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False, False);
                  end;
                end;
              nROSEC: begin
                  if GetTickCount - AutoRunInfo.dwRunTick > 1000 * LongWord(AutoRunInfo.nParam1) then begin
                    nCode:= 9;
                    AutoRunInfo.dwRunTick := GetTickCount();
                    nCode:= 10;
                    g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False, False);
                  end;
                end;
              nRUNONWEEK: begin
                nCode:= 11;
                AutoRunOfOnWeek(AutoRunInfo);
              end;
              nRUNONDAY: begin
                nCode:= 12;
                AutoRunOfOnDay(AutoRunInfo);
              end;
              {nRUNONHOUR: AutoRunOfOnHour(AutoRunInfo);//无过程  //20080818 注释
              nRUNONMIN: AutoRunOfOnMin(AutoRunInfo);//无过程
              nRUNONSEC: AutoRunOfOnSec(AutoRunInfo);//无过程 }
            end; // case
          end;
        {1: ;//20080818 注释
        2: ;
        3: ;}
      end; // case
    end;
    nCode:= 13;
    if m_boTimeGoto then begin
      if (GetTickCount > m_dwTimeGotoTick) then begin //执行 Delaygoto延时跳转 20090630
        m_boTimeGoto := False;
        nCode:= 14;
        if g_RobotNPC <> nil then g_RobotNPC.GotoLable(Self, m_sTimeGotoLable, False, False);
      end;
    end;
  except
    MainOutMessage(Format('{%s} TRobotObject.AutoRun Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

procedure TRobotObject.AutoRunOfOnDay(AutoRunInfo: pTAutoRunInfo);
var
  nMIN, nHOUR: Integer;
  wHour, wMin, wSec, wMSec: Word;
  sMIN, sHOUR: string;
  sLineText, sLabel: string;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if AutoRunInfo <> nil then begin//20091124 增加
      nCode:= 1;
      sLineText := AutoRunInfo.sParam1;
      sLineText := GetValidStr3(sLineText, sHOUR, [':']);
      sLineText := GetValidStr3(sLineText, sMIN, [':']);
      nCode:= 2;
      nHOUR := Str_ToInt(sHOUR, -1);
      nMIN := Str_ToInt(sMIN, -1);
      sLabel := AutoRunInfo.sParam2;
      DecodeTime(Time, wHour, wMin, wSec, wMSec);
      nCode:= 3;
      if (nHOUR in [0..24]) and (nMIN in [0..60]) then begin
        if (wHour = nHOUR) then begin
          if (wMin = nMIN) then begin
            nCode:= 4;
            if (not AutoRunInfo.boStatus) and (g_RobotNPC <> nil) then begin//20090408 增加 g_RobotNPC <> nil
              nCode:= 5;
              g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False, False);
              AutoRunInfo.boStatus := True;
            end;
          end else begin
            AutoRunInfo.boStatus := False;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TRobotObject.AutoRunOfOnDay Code:%d', [g_sExceptionVer, nCode]));
  end;
end;
{//20080818 注释
procedure TRobotObject.AutoRunOfOnHour(AutoRunInfo: pTAutoRunInfo);
begin

end;

procedure TRobotObject.AutoRunOfOnMin(AutoRunInfo: pTAutoRunInfo);
begin

end;

procedure TRobotObject.AutoRunOfOnSec(AutoRunInfo: pTAutoRunInfo);
begin

end; }

procedure TRobotObject.AutoRunOfOnWeek(AutoRunInfo: pTAutoRunInfo);
var
  nMIN, nHOUR, nWeek: Integer;
  wWeek, wHour, wMin, wSec, wMSec: Word;
  sMIN, sHOUR, sWeek: string;
  sLineText, sLabel: string;
  nCode: Byte;
begin
  nCode:= 0;
  try
    if AutoRunInfo <> nil then begin//20091124 增加
      sLineText := AutoRunInfo.sParam1;
      nCode:= 1;
      sLineText := GetValidStr3(sLineText, sWeek, [':']);
      nCode:= 2;
      sLineText := GetValidStr3(sLineText, sHOUR, [':']);
      nCode:= 3;
      sLineText := GetValidStr3(sLineText, sMIN, [':']);
      nCode:= 4;
      nWeek := Str_ToInt(sWeek, -1);
      nCode:= 5;
      nHOUR := Str_ToInt(sHOUR, -1);
      nCode:= 6;
      nMIN := Str_ToInt(sMIN, -1);
      nCode:= 7;
      sLabel := AutoRunInfo.sParam2;
      DecodeTime(Time, wHour, wMin, wSec, wMSec);
      nCode:= 8;
      wWeek := DayOfTheWeek(Now);
      if (nWeek in [1..7]) and (nHOUR in [0..24]) and (nMIN in [0..60]) then begin
        nCode:= 9;
        if (wWeek = nWeek) and (wHour = nHOUR) then begin
          nCode:= 10;
          if (wMin = nMIN) then begin
            nCode:= 11;
            if (not AutoRunInfo.boStatus) and (g_RobotNPC <> nil) then begin//20090408 增加 g_RobotNPC <> nil
              nCode:= 13;
              g_RobotNPC.GotoLable(Self, AutoRunInfo.sParam2, False, False);
              nCode:= 14;
              AutoRunInfo.boStatus := True;
            end;
          end else begin
            nCode:= 12;
            AutoRunInfo.boStatus := False;
          end;
        end;
      end;
    end;
  except
    MainOutMessage(Format('{%s} TRobotObject.AutoRunOfOnWeek Code:%d', [g_sExceptionVer, nCode]));
  end;
end;

procedure TRobotObject.ClearScript;
var
  I: Integer;
begin
  if m_AutoRunList.Count > 0 then begin//20080630
    for I := 0 to m_AutoRunList.Count - 1 do begin
      if pTAutoRunInfo(m_AutoRunList.Items[I]) <> nil then
        Dispose(pTAutoRunInfo(m_AutoRunList.Items[I]));
    end;
  end;
  m_AutoRunList.Clear;
end;

constructor TRobotObject.Create;
begin
  inherited;
  m_AutoRunList := TList.Create;
  m_boSuperMan := True;
  m_boRunOnWeek := False;
  m_boRunPlayRobotManage := False; //关闭个人机器人
  m_boRobotObject := True;//20090129
end;

destructor TRobotObject.Destroy;
begin
  ClearScript();
  m_AutoRunList.Free;
  inherited;
end;

procedure TRobotObject.LoadScript;
var
  I: Integer;
  LoadList: TStringList;
  sFileName, sLineText, sActionType, sRunCmd, sMoethod: string;
  sParam1, sParam2, sParam3, sParam4: string;
  AutoRunInfo: pTAutoRunInfo;
begin
  sFileName := g_Config.sEnvirDir + 'Robot_def\' + m_sScriptFileName + '.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := LoadList.Strings[I];
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText := GetValidStr3(sLineText, sActionType, [' ', '/', #9]);
          sLineText := GetValidStr3(sLineText, sRunCmd, [' ', '/', #9]);
          sLineText := GetValidStr3(sLineText, sMoethod, [' ', '/', #9]);
          sLineText := GetValidStr3(sLineText, sParam1, [' ', '/', #9]);
          sLineText := GetValidStr3(sLineText, sParam2, [' ', '/', #9]);
          sLineText := GetValidStr3(sLineText, sParam3, [' ', '/', #9]);
          sLineText := GetValidStr3(sLineText, sParam4, [' ', '/', #9]);
          if CompareText(sActionType, sROAUTORUN) = 0 then begin
            if CompareText(sRunCmd, sRONPCLABLEJMP) = 0 then begin
              New(AutoRunInfo);
              AutoRunInfo.dwRunTick := GetTickCount;
              AutoRunInfo.dwRunTimeLen := 0;
              AutoRunInfo.boStatus := False;
              AutoRunInfo.nRunCmd := nRONPCLABLEJMP;
              if CompareText(sMoethod, sRODAY) = 0 then AutoRunInfo.nMoethod := nRODAY;
              if CompareText(sMoethod, sROHOUR) = 0 then AutoRunInfo.nMoethod := nROHOUR;
              if CompareText(sMoethod, sROMIN) = 0 then AutoRunInfo.nMoethod := nROMIN;
              if CompareText(sMoethod, sROSEC) = 0 then AutoRunInfo.nMoethod := nROSEC;
              if CompareText(sMoethod, sRUNONWEEK) = 0 then AutoRunInfo.nMoethod := nRUNONWEEK;
              if CompareText(sMoethod, sRUNONDAY) = 0 then AutoRunInfo.nMoethod := nRUNONDAY;
             { if CompareText(sMoethod, sRUNONHOUR) = 0 then //20080818 注释
                AutoRunInfo.nMoethod := nRUNONHOUR;
              if CompareText(sMoethod, sRUNONMIN) = 0 then
                AutoRunInfo.nMoethod := nRUNONMIN;
              if CompareText(sMoethod, sRUNONSEC) = 0 then
                AutoRunInfo.nMoethod := nRUNONSEC;  }

              AutoRunInfo.sParam1 := sParam1;
              AutoRunInfo.sParam2 := sParam2;
              AutoRunInfo.sParam3 := sParam3;
              AutoRunInfo.sParam4 := sParam4;
              AutoRunInfo.nParam1 := Str_ToInt(sParam1, 1);
              m_AutoRunList.Add(AutoRunInfo);
            end;
          end;

        end;
      end;//for
    finally
      LoadList.Free;
    end;
  end;
end;

procedure TRobotObject.ProcessAutoRun;
var
  I: Integer;
  AutoRunInfo: pTAutoRunInfo;
begin
  if m_AutoRunList.Count > 0 then begin//20090325
    for I := 0 to m_AutoRunList.Count - 1 do begin
      AutoRunInfo := pTAutoRunInfo(m_AutoRunList.Items[I]);
      if AutoRunInfo <> nil then AutoRun(AutoRunInfo);
    end;
  end;
end;

procedure TRobotObject.ReloadScript;
begin
  ClearScript();
  LoadScript();
end;

procedure TRobotObject.Run;
begin
  ProcessAutoRun();
  //  inherited;
end;

procedure TRobotObject.SendSocket(DefMsg: pTDefaultMessage; sMsg: string);
begin

end;

{ TRobotManage }

constructor TRobotManage.Create;
begin
  RobotHumanList := TStringList.Create;
  LoadRobot();
end;

destructor TRobotManage.Destroy;
begin
  UnLoadRobot();
  RobotHumanList.Free;
  inherited;
end;

procedure TRobotManage.LoadRobot;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sRobotName: string;
  sScriptFileName: string;
  sRobotType: string;
  RobotHuman: TRobotObject;
begin
  sFileName := g_Config.sEnvirDir + 'Robot.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    try
      LoadList.LoadFromFile(sFileName);
      if LoadList.Count > 0 then begin//20091114 增加
        for I := 0 to LoadList.Count - 1 do begin
          sLineText := LoadList.Strings[I];
          if (sLineText <> '') and (sLineText[1] <> ';') then begin
            sLineText := GetValidStr3(sLineText, sRobotName, [' ', '/', #9]);
            sLineText := GetValidStr3(sLineText, sScriptFileName, [' ', '/', #9]);
            sLineText := GetValidStr3(sLineText, sRobotType, [' ', '/', #9]);
            if (sRobotName <> '') and (sScriptFileName <> '') and (sRobotType <> '1') then begin
              RobotHuman := TRobotObject.Create;
              RobotHuman.m_sCharName := sRobotName;
              RobotHuman.m_sScriptFileName := sScriptFileName;
              RobotHuman.LoadScript;
              RobotHumanList.AddObject(RobotHuman.m_sCharName, RobotHuman);
            end;
          end;
        end;//for
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

procedure TRobotManage.RELOADROBOT;
begin
  UnLoadRobot();
  LoadRobot();
end;

procedure TRobotManage.Run;
var
  I: Integer;
  RobotObject: TRobotObject;
begin
  for I := 0 to RobotHumanList.Count - 1 do begin
    RobotObject := TRobotObject(RobotHumanList.Objects[I]);
    if RobotObject <> nil then RobotObject.Run;
  end;
end;

procedure TRobotManage.UnLoadRobot;
var
  I: Integer;
begin
  if RobotHumanList.Count > 0 then begin//20080630
    for I := 0 to RobotHumanList.Count - 1 do begin
      TRobotObject(RobotHumanList.Objects[I]).Free;
    end;
    RobotHumanList.Clear;//20091114 移动位置
  end;
end;

end.
