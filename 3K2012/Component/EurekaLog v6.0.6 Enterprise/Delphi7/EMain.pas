{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{         Main DesignTime Unit - EMain           }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EMain;

{$I Exceptions.inc}

interface

uses
  Windows, SysUtils;

{$I VersionStrings.inc}

procedure Register;

implementation

uses
  Classes, ExtCtrls, ECore, EBaseModule, ECommon, ExceptionLog, EDesign,
{$IFDEF Delphi5Up} EToolsAPI {$ELSE} EToolServices, IniFiles {$ENDIF}
{$IFDEF Delphi9Up} ,DesignIntf {$ENDIF}
{$IFDEF EUREKALOG_DEMO} ,ENagScreen {$ENDIF};

{$R EurekaLog.res}

type
  TStartTimer = class(TTimer)
  public
    procedure EventTimer(Sender: TObject);
  end;
var
  StartTimer: TStartTimer;

//------------------------------------------------------------------------------

procedure SetDefaultOptions;
{$IFDEF Delphi4Down}
var
  Opt: TIniFile;
begin
  Opt := TIniFile.Create(DefaultOptionFile);
  try
    if (Opt.ReadString('Compiler', 'D', '0') <> '1') then
      Opt.WriteString('Compiler', 'D', '1');
    if (Opt.ReadString('Linker', 'MapFile', '0') <> '3') then
      Opt.WriteString('Linker', 'MapFile', '3');
  finally
    Opt.Free;
  end;
{$ELSE}
begin
{$ENDIF}
end;

{$IFDEF Delphi4Up}
procedure InternalActionNotify(EurekaExceptionRecord: TEurekaExceptionRecord;
  EurekaAction: TEurekaActionType; var Execute: Boolean);
begin
  if EurekaAction = atTerminating then
  begin
    Execute := MessageBox(0, '你想终止您的 ' + RADRegKeyName +
      ' 会话?', '确认', MB_YESNO or MB_ICONQUESTION or MB_TASKMODAL or
      MB_TOPMOST or MB_DEFBUTTON2) = ID_Yes;
    if Execute then IDEManager.SaveAllModifiedFiles;
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

{ TStartTimer }

procedure TStartTimer.EventTimer(Sender: TObject);
{$IFDEF EUREKALOG_DEMO}
var
  LastShow: TDateTime;
  IniFile: string;
{$ENDIF}
Begin
  Enabled := False;

  InitDelayedMenu;

{$IFDEF EUREKALOG_DEMO}
  IniFile := (BaseDir + 'ELDemo.ini');
  LastShow := ECore.ReadInteger(IniFile, 'Main', 'LastNagScreenShow', 0);
  ECore.WriteInteger(IniFile, 'Main', 'LastNagScreenShow', Round(Date));

  // Show the NagScreen only one time for day!
  if (LastShow <> Date) then ShowNagScreen;
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure Register;
begin
{$IFDEF Delphi9Up}
  ForceDemandLoadState(dlDisable);
{$ENDIF}
  RegisterComponents('EurekaLog', [TEurekaLog]);
end;

procedure Init;
begin
  IDEManager.CheckForConflicts;
  SetDefaultOptions; // Delphi4Down
  InitMenu;
  InitNotifier;

{$IFDEF Delphi4Up}
  ExceptionActionNotify := InternalActionNotify;
{$ENDIF}

  StartTimer := TStartTimer.Create(nil);
  StartTimer.Interval := 1000;
  StartTimer.Enabled := True;
  StartTimer.OnTimer := StartTimer.EventTimer;
end;

procedure Done;
begin
  IDEManager.UnloadProjectsList;
  DoneNotifier;
  DoneMenu;
  
  StartTimer.Free;
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'EMain.Init');

finalization
  SafeExec(Done, 'EMain.Done');

end.

