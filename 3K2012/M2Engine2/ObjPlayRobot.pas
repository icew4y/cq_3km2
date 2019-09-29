unit ObjPlayRobot;

interface
uses
  Windows, Classes, SysUtils, DateUtils, SDK;
type
  TPlayRobotObject = class
    m_sCharName: string;
    m_sScriptFileName: string;
    m_AutoRunList: TList;
  private
    m_boRunOnWeek: Boolean; //是否已执行操作；
    procedure LoadScript();
    procedure ClearScript();
    //procedure ProcessAutoRun();//20080818 注释
    procedure AutoRun(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);
    procedure AutoRunOfOnWeek(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);//星期几运行
    procedure AutoRunOfOnDay(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);//每天运行
    {procedure AutoRunOfOnHour(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);//隔小时运行  //20080818 注释
    procedure AutoRunOfOnMin(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);//隔分钟运行
    procedure AutoRunOfOnSec(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);//隔秒钟运行   }
  public
    constructor Create();
    destructor Destroy; override;
    procedure ReloadScript();
    procedure Run(PlayObject: TObject);
  end;

  TPlayRobotManage = class
    RobotHumanList: TStringList;
    PlayObject: TObject;
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
uses M2Share, HUtil32, ObjBase;

//===========================人物个人机器人=====================================
{ TPlayRobotObject }

procedure TPlayRobotObject.AutoRun(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);
begin
  if GetTickCount - AutoRunInfo.dwRunTick > AutoRunInfo.dwRunTimeLen then begin
    case AutoRunInfo.nRunCmd of
      nRONPCLABLEJMP: begin
          case AutoRunInfo.nMoethod of
            nRODAY: begin
                if GetTickCount - AutoRunInfo.dwRunTick > 86400000{24 * 60 * 60 * 1000} * LongWord(AutoRunInfo.nParam1) then begin
                  AutoRunInfo.dwRunTick := GetTickCount();
                  g_RobotNPC.GotoLable(TPlayObject(PlayObject), AutoRunInfo.sParam2, False, False);
                end;
              end;
            nROHOUR: begin
                if GetTickCount - AutoRunInfo.dwRunTick > 3600000{60 * 60 * 1000} * LongWord(AutoRunInfo.nParam1) then begin
                  AutoRunInfo.dwRunTick := GetTickCount();
                  g_RobotNPC.GotoLable(TPlayObject(PlayObject), AutoRunInfo.sParam2, False, False);
                end;
              end;
            nROMIN: begin
                if GetTickCount - AutoRunInfo.dwRunTick > 60000{60 * 1000} * LongWord(AutoRunInfo.nParam1) then begin
                  AutoRunInfo.dwRunTick := GetTickCount();
                  g_RobotNPC.GotoLable(TPlayObject(PlayObject), AutoRunInfo.sParam2, False, False);
                end;
              end;
            nROSEC: begin
                if GetTickCount - AutoRunInfo.dwRunTick > 1000 * LongWord(AutoRunInfo.nParam1) then begin
                  AutoRunInfo.dwRunTick := GetTickCount();
                  g_RobotNPC.GotoLable(TPlayObject(PlayObject), AutoRunInfo.sParam2, False, False);
                end;
              end;
            nRUNONWEEK: AutoRunOfOnWeek(AutoRunInfo, PlayObject);
            nRUNONDAY: AutoRunOfOnDay(AutoRunInfo, PlayObject);
            {nRUNONHOUR: AutoRunOfOnHour(AutoRunInfo, PlayObject);//20080818 注释
            nRUNONMIN: AutoRunOfOnMin(AutoRunInfo, PlayObject);
            nRUNONSEC: AutoRunOfOnSec(AutoRunInfo, PlayObject);}
          end; // case
        end;
     { 1: ; //20080818 注释
      2: ;
      3: ; }
    end; // case
  end;
end;

procedure TPlayRobotObject.AutoRunOfOnDay(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);
var
  nMIN, nHOUR: Integer;
  wHour, wMin, wSec, wMSec: Word;
  sMIN, sHOUR: string;
  sLineText, sLabel: string;
begin
  sLineText := AutoRunInfo.sParam1;
  sLineText := GetValidStr3(sLineText, sHOUR, [':']);
  sLineText := GetValidStr3(sLineText, sMIN, [':']);
  nHOUR := Str_ToInt(sHOUR, -1);
  nMIN := Str_ToInt(sMIN, -1);
  sLabel := AutoRunInfo.sParam2;
  DecodeTime(Time, wHour, wMin, wSec, wMSec);
  if (nHOUR in [0..24]) and (nMIN in [0..60]) then begin
    if (wHour = nHOUR) then begin
      if (wMin = nMIN) then begin
        if not AutoRunInfo.boStatus then begin
          g_RobotNPC.GotoLable(TPlayObject(PlayObject), AutoRunInfo.sParam2, False, False);
          AutoRunInfo.boStatus := True;
        end;
      end else begin
        AutoRunInfo.boStatus := False;
      end;
    end;
  end;
end;
{//20080818 注释
procedure TPlayRobotObject.AutoRunOfOnHour(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);
begin

end;

procedure TPlayRobotObject.AutoRunOfOnMin(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);
begin

end;

procedure TPlayRobotObject.AutoRunOfOnSec(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);
begin

end; }

procedure TPlayRobotObject.AutoRunOfOnWeek(AutoRunInfo: pTAutoRunInfo; PlayObject: TObject);
var
  nMIN, nHOUR, nWeek: Integer;
  wWeek, wHour, wMin, wSec, wMSec: Word;
  sMIN, sHOUR, sWeek: string;
  sLineText, sLabel: string;
begin
  sLineText := AutoRunInfo.sParam1;
  sLineText := GetValidStr3(sLineText, sWeek, [':']);
  sLineText := GetValidStr3(sLineText, sHOUR, [':']);
  sLineText := GetValidStr3(sLineText, sMIN, [':']);
  nWeek := Str_ToInt(sWeek, -1);
  nHOUR := Str_ToInt(sHOUR, -1);
  nMIN := Str_ToInt(sMIN, -1);
  sLabel := AutoRunInfo.sParam2;
  DecodeTime(Time, wHour, wMin, wSec, wMSec);
  wWeek := DayOfTheWeek(Now);
  if (nWeek in [1..7]) and (nHOUR in [0..24]) and (nMIN in [0..60]) then begin
    if (wWeek = nWeek) and (wHour = nHOUR) then begin
      if (wMin = nMIN) then begin
        if not AutoRunInfo.boStatus then begin
          g_RobotNPC.GotoLable(TPlayObject(PlayObject), AutoRunInfo.sParam2, False, False);
          AutoRunInfo.boStatus := True;
        end;
      end else begin
        AutoRunInfo.boStatus := False;
      end;
    end;
  end;
end;

procedure TPlayRobotObject.ClearScript;
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

constructor TPlayRobotObject.Create;
begin
  m_AutoRunList := TList.Create;
  m_boRunOnWeek := False;
end;

destructor TPlayRobotObject.Destroy;
begin
  ClearScript();
  m_AutoRunList.Free;
end;

procedure TPlayRobotObject.LoadScript;
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
    LoadList.LoadFromFile(sFileName);
    if LoadList.Count > 0 then begin//20080630
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
             { if CompareText(sMoethod, sRUNONHOUR) = 0 then  //20080818 注释
                AutoRunInfo.nMoethod := nRUNONHOUR;
              if CompareText(sMoethod, sRUNONMIN) = 0 then
                AutoRunInfo.nMoethod := nRUNONMIN;
              if CompareText(sMoethod, sRUNONSEC) = 0 then
                AutoRunInfo.nMoethod := nRUNONSEC;    }
              AutoRunInfo.sParam1 := sParam1;
              AutoRunInfo.sParam2 := sParam2;
              AutoRunInfo.sParam3 := sParam3;
              AutoRunInfo.sParam4 := sParam4;
              AutoRunInfo.nParam1 := Str_ToInt(sParam1, 1);
              m_AutoRunList.Add(AutoRunInfo);
            end;
          end;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;
{//20080818 注释
procedure TPlayRobotObject.ProcessAutoRun;
begin

end; }

procedure TPlayRobotObject.ReloadScript;
begin
  ClearScript();
  LoadScript();
end;

procedure TPlayRobotObject.Run(PlayObject: TObject);
var
  I: Integer;
  AutoRunInfo: pTAutoRunInfo;
begin
  if m_AutoRunList.Count > 0 then begin//20080630
    for I := 0 to m_AutoRunList.Count - 1 do begin
      AutoRunInfo := pTAutoRunInfo(m_AutoRunList.Items[I]);
      if AutoRunInfo <> nil then AutoRun(AutoRunInfo, PlayObject);
    end;
  end;
end;

{ TPlayRobotManage }

constructor TPlayRobotManage.Create;
begin
  PlayObject := nil;
  RobotHumanList := TStringList.Create;
  LoadRobot();
end;

destructor TPlayRobotManage.Destroy;
begin
  UnLoadRobot();
  RobotHumanList.Free;
end;

procedure TPlayRobotManage.LoadRobot;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sRobotName: string;
  sScriptFileName: string;
  sRobotType: string;
  RobotHuman: TPlayRobotObject;
begin
  sFileName := g_Config.sEnvirDir + 'Robot.txt';
  if FileExists(sFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sFileName);
    if LoadList.Count > 0 then begin//20080630
      for I := 0 to LoadList.Count - 1 do begin
        sLineText := LoadList.Strings[I];
        if (sLineText <> '') and (sLineText[1] <> ';') then begin
          sLineText := GetValidStr3(sLineText, sRobotName, [' ', '/', #9]);
          sLineText := GetValidStr3(sLineText, sScriptFileName, [' ', '/', #9]);
          sLineText := GetValidStr3(sLineText, sRobotType, [' ', '/', #9]);
          if (sRobotName <> '') and (sScriptFileName <> '') and (sRobotType = '1') then begin
            RobotHuman := TPlayRobotObject.Create;
            RobotHuman.m_sCharName := sRobotName;
            RobotHuman.m_sScriptFileName := sScriptFileName;
            RobotHuman.LoadScript;
            RobotHumanList.AddObject(RobotHuman.m_sCharName, RobotHuman);
          end;
        end;
      end;
    end;
    LoadList.Free;
  end;
end;

procedure TPlayRobotManage.RELOADROBOT;
begin
  UnLoadRobot();
  LoadRobot();
end;

procedure TPlayRobotManage.Run;
var
  I: Integer;
  nCode: Byte;//20091125
begin
  nCode:= 0;
  try
    if PlayObject <> nil then begin
      nCode:= 1;
      if RobotHumanList.Count > 0 then begin//20080630
        nCode:= 2;
        for I := 0 to RobotHumanList.Count - 1 do begin
          nCode:= 3;
          TPlayRobotObject(RobotHumanList.Objects[I]).Run(PlayObject);
        end;
      end;
    end;
  except
    on E: Exception do begin
      MainOutMessage(Format('{%s} TPlayRobotManage::Run Code:%d',[g_sExceptionVer, nCode]));
    end;
  end;
end;

procedure TPlayRobotManage.UnLoadRobot;
var
  I: Integer;
begin
  if RobotHumanList.Count > 0 then begin//20080630
    for I := 0 to RobotHumanList.Count - 1 do begin
      TPlayRobotObject(RobotHumanList.Objects[I]).Free;
    end;
  end;
  RobotHumanList.Clear;
end;

end.
