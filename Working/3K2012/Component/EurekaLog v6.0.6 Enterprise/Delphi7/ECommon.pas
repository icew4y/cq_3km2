{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{         Common functions - ECommon             }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ECommon;

{$I Exceptions.inc}

interface

uses
  Windows, SysUtils, Classes;

{$I VersionStrings.inc}

const
  EIDEHookingErrorStr = 'Cannot hook the "%s" procedure into the IDE.';

type
  TIDEManager = class
  protected
    class function PathFromInternalFiles(var FileName: string): Boolean;
    class procedure SearchDir(Start: string; List: TStrings);
    class procedure InternalInstallNotifier(const FileName: string; Notifier: Pointer);
    class procedure InternalRemoveNotifier(const FileName: string);
    class function FindNotifier(const FileName: string): Pointer;
  public
    class procedure GetLibraryPath(List: TStrings);
    class procedure FromPathToList(const Path: string; List: TStrings);
    class function InstallNotifier(const FileName: string): Boolean; virtual;
    class function RemoveNotifier(const FileName: string): Boolean; virtual;
    class procedure MarkModified(const FileName: string); virtual;
    class function GetText(const FileName: string): string; virtual;
    class procedure InsertText(const FileName: string; StartPos: Integer; Text: PChar); virtual;
    class procedure DeleteText(const FileName: string; StartPos, EndPos: Integer); virtual;
    class function ShowFile(CompiledFile, UnitName, ProcName: string;
      Line, Offset: Integer; Compiled: TDateTime): Boolean; virtual;
    class procedure SetMenuState(Value: Boolean); virtual;
    class function CheckAndInstallNotify(FileName: string): Boolean; virtual;
    class procedure SaveAllModifiedFiles; virtual;
    class procedure CheckForConflicts; virtual;
    class procedure UnloadProjectsList; virtual;
  end;

  TIDEManagerClass = class of TIDEManager;

  TMenuEvents = class
    class procedure OnOptionsClick(Sender: TObject);
    class procedure OnViewLogClick(Sender: TObject);
    class procedure OnTutorialClick(Sender: TObject);
    class procedure OnAboutClick(Sender: TObject);
    class procedure OnIDEOptionsClick(Sender: TObject);
    class procedure OnHelpOptionsClick(Sender: TObject);
{$IFDEF EUREKALOG_DEMO}
    class procedure OnBuyClick(Sender: TObject);
{$ENDIF}
  end;

var
  IDEManager: TIDEManagerClass;

procedure HookApplicationOnException;
procedure UnHookApplicationOnException;
procedure AboutBox(Demo: Boolean);

implementation

uses
  ExtCtrls, Forms, ShellAPI, Messages,
  EConsts, ECore, EBaseModule, ExceptionLog, EOption, EIDEOPtions, EAbout,
  EHook, EDesign, EWebTools;

type
  EurekaException = class(Exception);
  EIDEModuleNotFound = class(EurekaException);

{$IFDEF PROFESSIONAL}
  TEurekaApp = class(TObject)
    class procedure ExceptionNotify(Sender: TObject; E: Exception);
  end;

  TMailSlotTimer = class(TTimer)
  public
    constructor Create(AOwner: TComponent); override;
    procedure TimerTick(Sender: TObject);
  end;

  TMailSlotMsg = packed record
    CompiledFile, UnitName, ClassName, ProcName: array[0..89] of Char;
    Line, Offset: DWord;
    Compiled: TDateTime;
  end;
{$ENDIF}

  TCheckUpdate = class(TThread)
  public
    procedure Execute; override;
  end;

var
{$IFDEF PROFESSIONAL}
  MailSlotSrv: THandle;
  MailSlotOK: Boolean;
  MailSlotTimer: TMailSlotTimer;
  MailSlotName: string;
  OldOnException: TExceptionEvent;
{$IFDEF Delphi4Up}
  OldLoadLibrary: function(lpLibFileName: PAnsiChar; hFile: THandle;
    dwFlags: DWORD): HMODULE; stdcall;
{$ENDIF}
{$ENDIF}
  OldCreateFile: function(lpFileName: PAnsiChar; dwDesiredAccess,
    dwShareMode: DWORD; lpSecurityAttributes: PSecurityAttributes;
    dwCreationDisposition, dwFlagsAndAttributes: DWORD;
    hTemplateFile: THandle): THandle; stdcall;
  LastOpenedOptionFile: string = '';
  NotifiersList: TStrings;
  UpdateThread: TCheckUpdate = nil;

//------------------------------------------------------------------------------

procedure HookApplicationOnException;
{$IFDEF PROFESSIONAL}
var
  Method: TExceptionEvent;
begin
  Method := TEurekaApp.ExceptionNotify;
  if (@Application.OnException <> @Method) then
  begin
    OldOnException := Application.OnException;
    Application.OnException := TEurekaApp.ExceptionNotify;
  end;
{$ELSE}
begin
{$ENDIF}
end;

procedure UnHookApplicationOnException;
{$IFDEF PROFESSIONAL}
var
  Method: TExceptionEvent;
begin
  Method := TEurekaApp.ExceptionNotify;
  if (@Application.OnException = @Method) then
  begin
    Application.OnException := OldOnException;
    OldOnException := nil;
  end;
{$ELSE}
begin
{$ENDIF}
end;

//------------------------------------------------------------------------------

{$IFDEF PROFESSIONAL}

{ TEurekaApp }

class procedure TEurekaApp.ExceptionNotify(Sender: TObject; E: Exception);
var
  LogName: string;

  function IDECatchEnabled: Boolean;
  begin
    Result := ECore.ReadBool(EurekaIni, 'IDE', 'Enabled', True);
    ECore.WriteBool(EurekaIni, 'IDE', 'Enabled', Result);
  end;

begin
  // Check for "probably internal BUG"...
  if (E is EurekaException) then
  begin
    if MessageBox(0, PChar(Format(EurekaBUGString, [E.Message])),
      EInternalBUG,
      MB_YESNO or MB_DEFBUTTON1 or MB_ICONERROR or MB_TASKMODAL) = ID_YES then
    begin
      LogName := ChangeFileExt(ParamStr(0), '.log');
      if (not EurekaLogSendEmail('support@eurekalog.com', EInternalBUGSubject,
        EInternalBUGBody, LogName)) then
      begin
        MessageBox(0, PChar(Format(ENoConnectWithEClient, [LogName])),
          EInformation, MB_OK or MB_ICONWARNING or MB_TASKMODAL);
      end;
    end;
  end
  else
  begin
    if (not Application.Terminated) and (IDECatchEnabled) then
      StandardEurekaNotify(E, ExceptAddr)
    else
      if Assigned(OldOnException) then OldOnException(Sender, E);
  end;
end;

//------------------------------------------------------------------------------

function MailSlotCreate(const Name: string; var MailSlot: THandle): Boolean;
var
  i: Integer;
begin
  for i := 0 to 3 do
  begin
    MailSlotName := ('\\.\mailslot\' + Name + IntToStr(i));
    MailSlot := CreateMailSlot(PChar(MailSlotName), 0, MAILSLOT_WAIT_FOREVER, nil);
    Result := (MailSlot <> INVALID_HANDLE_VALUE);
    if (Result) then Break;
  end;
end;

function MailSlotRead(MailSlot: THandle; var Msg: TMailSlotMsg): Boolean;
var
  BytesRead, Size: DWord;
  TmpMsg: TMailSlotMsg;
  i: Integer;
begin
  Result := (GetMailSlotInfo(MailSlot, nil, Size, nil, nil)) and
    (Size <> MAILSLOT_NO_MESSAGE) and
    (ReadFile(MailSlot, Msg, SizeOf(Msg), BytesRead, nil)) and
    (BytesRead = SizeOf(Msg));

  for i := 1 to 3 do
  begin
    if not ((GetMailSlotInfo(MailSlot, nil, Size, nil, nil)) and
    (Size <> MAILSLOT_NO_MESSAGE) and
    (ReadFile(MailSlot, TmpMsg, SizeOf(Msg), BytesRead, nil)) and
    (BytesRead = SizeOf(TmpMsg))) then Break;
  end;
end;
//------------------------------------------------------------------------------

{ TMailSlotTimer }

constructor TMailSlotTimer.Create(AOwner: TComponent);
begin
  inherited;
  OnTimer := TimerTick;
  Interval := 50;
  Enabled := True;
end;

procedure TMailSlotTimer.TimerTick(Sender: TObject);
var
  Msg: TMailSlotMsg;
  ClassName, ProcName, Dot: string;
begin
  Enabled := False;
  try
    if MailSlotRead(MailSlotSrv, Msg) then
    begin
      Classname := Msg.ClassName;
      ProcName := Msg.ProcName;
      if (CurrentPersonality.GetPersonality = ptDelphiWin32) then Dot := '.'
      else Dot := '::';
      if (Msg.ClassName <> '') then
        ProcName := (ClassName + Dot + ProcName);
      if IDEManager.ShowFile(Msg.CompiledFile, Msg.UnitName,
        ProcName, Msg.Line, Msg.Offset, Msg.Compiled) then
      begin
{$IFDEF Delphi4Down}
        Application.Restore;
        SetForegroundWindow(Application.MainForm.Handle);
        IDEManager.ShowFile(Msg.CompiledFile, Msg.UnitName,
          ProcName, Msg.Line, Msg.Offset, Msg.Compiled);
{$ENDIF}
      end;
    end;
  finally
    Enabled := True;
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

{ TIDEInstaller }

class procedure TIDEManager.FromPathToList(const Path: string; List: TStrings);
var
  n: Integer;
  s, Source: string;

  procedure Add(var s: string);
  begin
    if (s = '') then Exit;

    s := AdjustDir(s, False);
    if (s <> '') and (s[Length(s)] <> '\') then s := (s + '\');
    List.Add(s);
    s := '';
  end;

begin
  s := '';
  Source := Path;
  for n := 1 to Length(Source) do
  begin
    if (Source[n] <> ';') then s := (s + Source[n])
    else Add(s);
  end;
  Add(s);
end;

class procedure TIDEManager.GetLibraryPath(List: TStrings);
var
  SPath, LibName, Source: string;
begin
{$IFDEF Delphi3} // Delphi 3
  SPath := 'SearchPath';
  LibName := 'Library';
{$ELSE}
  {$IFDEF Delphi9Down} // All other Delphi and C++Builder
    SPath := 'Search Path';
    LibName := 'Library';
  {$ELSE}
    if (CurrentPersonality.GetPersonality = ptCppBuilderWin32) then
    begin
      SPath := 'SearchPath';
      LibName := 'CppPaths';
    end
    else
    begin
      SPath := 'Search Path';
      LibName := 'Library';
    end;
  {$ENDIF}
{$ENDIF}
  Source := ReadKey(HKEY_CURRENT_USER, RADRegistryKey + '\' + LibName, SPath);
  FromPathToList(Source, List);
end;

class function TIDEManager.PathFromInternalFiles(var FileName: string): Boolean;
var
  List: TStringList;
  n: Integer;

  procedure AddModulePath(Module: TBaseModule; var Folders: TStringList);
  begin
    if (Module.Name <> '') then Folders.Add(ExtractFilePath(Module.Name));
    Module.GetUnitDirs(Folders);
  end;

begin
  Result := False;
  List := TStringList.Create;
  try
    if (ModuleOptions.CurrentModule <> nil) then
    begin
      AddModulePath(ModuleOptions.CurrentModule, List);
      for n := 1 to (ModuleOptions.Count - 1) do
      begin
        if (ModuleOptions[n] <> ModuleOptions.CurrentModule) then
          AddModulePath(ModuleOptions[n], List);
      end;
    end;
    GetLibraryPath(List);
    SearchDir(RADDir + '\Source', List);
    for n := 0 to (List.Count - 1) do
    begin
      if (FileExists(List[n] + ExtractFileName(FileName))) then
      begin
        Result := True;
        FileName := (List[n] + ExtractFileName(FileName));
        Break;
      end;
    end;
  finally
    List.Free;
  end;
end;

class procedure TIDEManager.SearchDir(Start: string; List: TStrings);
var
  SRec: TSearchRec;
  Res: Integer;
begin
  if (Start <> '') and (Start[Length(Start)] <> '\') then Start := (Start + '\');
  Res := FindFirst(Start + '*.*', faAnyFile, SRec);
  while (Res = 0) do
  begin
    if ((SRec.Attr and faDirectory) <> 0) then
      if ((SRec.Name <> '.') and (SRec.Name <> '..')) then
      begin
        List.Add(Start + SRec.Name + '\');
        SearchDir(Start + SRec.Name + '\', List);
      end;
    Res := FindNext(SRec);
  end;
  FindClose(SRec);
end;

class procedure TIDEManager.InternalInstallNotifier(const FileName: string; Notifier: Pointer);
begin
  NotifiersList.AddObject(FileName, TObject(Notifier));
end;

class procedure TIDEManager.InternalRemoveNotifier(const FileName: string);
var
  Idx: Integer;
begin
  Idx := NotifiersList.IndexOf(FileName);
  if (Idx <> -1) then NotifiersList.Delete(Idx);
end;

class function TIDEManager.FindNotifier(const FileName: string): Pointer;
var
  Idx: Integer;
begin
  Result := nil;
  Idx := NotifiersList.IndexOf(FileName);
  if (Idx <> -1) then Result := NotifiersList.Objects[Idx];
end;

class function TIDEManager.CheckAndInstallNotify(FileName: string): Boolean;
var
  Idx: Integer;
begin
  Result := False;
  if (FileName = '') or (not IsAcceptableProject(FileName)) then Exit;

  Idx := ModuleOptions.FindByName(FileName);
  if (Idx = -1) then
  begin
    if (InstallNotifier(FileName)) then
    begin
      if (UpperCase(LastOpenedOptionFile) = UpperCase(DefaultOptionFile)) or
        (not IsEurekaLogOptionsFile(FileName)) then
        ModuleOptions.AddModule(TModule, FileName, ltLoadDefaultOptions)
      else
        ModuleOptions.AddModule(TModule, FileName, ltLoadModuleOptions);
      Result := True;
    end;
  end;
end;

class procedure TIDEManager.CheckForConflicts;
var
  List: TStrings;
  n: Integer;

  function EurekaLogPath: string;
  var
    Buff: array[0..MAX_PATH - 1] of Char;
  begin
    Result := Trim(ReadKey(HKEY_CURRENT_USER, 'Software\EurekaLog', 'AppDir'));
    if (Result <> '') then
      Result := UpperCase(Result + '\' + InstallDirName +
        Copy(Real_RADVersionString, 1, Pos('.', Real_RADVersionString) - 1) + '\')
    else
    begin
      GetModuleFileName(HInstance, Buff, SizeOf(Buff));
      Result := UpperCase(ExtractFilePath(Buff));
    end;
  end;

begin
  List := TStringList.Create;
  try
    GetLibraryPath(List);
    for n := 0 to (List.Count - 1) do
    begin
      if (FileExists(List[n] + 'ExceptionLog.pas')) and
        (UpperCase(List[n]) <> EurekaLogPath) then
      begin
        MessageBox(0, PChar(Format('Cannot activate EurekaLog.' + #13#10 +
          'The "%s" folder containing an old EurekaLog version.' + #13#10 +
          'Remove the old package from "Component\Install Packages" menu ' +
          'and deleting its folder.', [List[n]])), 'Conflict',
          MB_OK or MB_ICONWARNING or MB_TASKMODAL);
        Abort;
      end;
    end;
  finally
    List.Free;
  end;
end;

// Not abstract method to avoid the CBuilder conflict with abtract methods in iterface section.
class procedure TIDEManager.SaveAllModifiedFiles;
begin
  // Nothing...
end;

class procedure TIDEManager.DeleteText(const FileName: string; StartPos, EndPos: Integer);
begin
  // Nothing...
end;

class procedure TIDEManager.SetMenuState(Value: Boolean);
begin
  // Nothing...
end;

class function TIDEManager.GetText(const FileName: string): string;
begin
  Result := '';
end;

class procedure TIDEManager.InsertText(const FileName: string;
  StartPos: Integer; Text: PChar);
begin
  // Nothing...
end;

class function TIDEManager.InstallNotifier(const FileName: string): Boolean;
begin
  Result := False;
end;

class procedure TIDEManager.MarkModified(const FileName: string);
begin
  // Nothing...
end;

class function TIDEManager.RemoveNotifier(const FileName: string): Boolean;
begin
  Result := False;
end;

class procedure TIDEManager.UnloadProjectsList;
begin
  // Nothing...
end;

class function TIDEManager.ShowFile(CompiledFile, UnitName,
  ProcName: string; Line, Offset: Integer; Compiled: TDateTime): Boolean;
begin
  Result := False;
end;

//------------------------------------------------------------------------------

procedure AboutBox(Demo: Boolean);
var
  AboutForm: TAboutForm;
begin
  ActivateDelay := Demo;
  AboutForm := TAboutForm.Create(nil);
  with AboutForm do
  begin
    ShowModal;
    Free;
  end;
end;

{ TMenuEvents }

class procedure TMenuEvents.OnHelpOptionsClick(Sender: TObject);
begin
  ShowHelp('');
end;

class procedure TMenuEvents.OnIDEOptionsClick(Sender: TObject);
var
  IDEOptionsForm: TIDEOptionsForm;
begin
  IDEOptionsForm := TIDEOptionsForm.Create(nil);
  with IDEOptionsForm do
  begin
    ShowModal;
    Free;
  end;
end;

class procedure TMenuEvents.OnOptionsClick(Sender: TObject);
var
  OptionsForm: TOptionsForm;
begin
  OptionsForm := TOptionsForm.Create(nil);
  with OptionsForm do
  begin
    IDEManager.CheckAndInstallNotify(GetCurrentModuleNameProc);
    ShowModal;
    Free;
  end;
end;

class procedure TMenuEvents.OnViewLogClick(Sender: TObject);
begin
  if (ModuleOptions.CurrentModule <> nil) then
    ShowLog(ModuleOptions.CurrentModule.OutputLogFile(ModuleOptions.CurrentModule.CompiledFile))
  else
    MessageBox(0, ENoProjectSelected, EAttenction, MB_OK or MB_ICONWARNING or MB_TASKMODAL);
end;

class procedure TMenuEvents.OnTutorialClick(Sender: TObject);
begin
  ShowTutorial;
end;

class procedure TMenuEvents.OnAboutClick(Sender: TObject);
begin
  AboutBox(False);
end;

{$IFDEF EUREKALOG_DEMO}
class procedure TMenuEvents.OnBuyClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://www.eurekalog.com/buy.php',
    nil, nil, SW_SHOWMAXIMIZED);
end;
{$ENDIF}

//------------------------------------------------------------------------------

function InternalHookDllProcedureEx(ImportModule, ExportModule, ProcName: string;
  NewProc: Pointer): Pointer;
begin
  TryHookDllProcedureEx(ImportModule, ExportModule, ProcName, NewProc, Result, True);
end;

function NewCreateFile(lpFileName: PAnsiChar; dwDesiredAccess, dwShareMode: DWORD;
  lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition,
  dwFlagsAndAttributes: DWORD; hTemplateFile: THandle): THandle; stdcall;
var
  Ext, FileName: string;
begin
  FileName := string(lpFileName);
  Ext := LowerCase(ExtractFileExt(FileName));
  if (dwCreationDisposition = OPEN_EXISTING) and
    (CurrentPersonality.IsOptionEqual(Ext, otOptionFileExt, FileName)) or
    ((CurrentPersonality.GetPersonality = ptCppBuilderWin32) and (Ext = '.bpk')) then
    LastOpenedOptionFile := FileName;

  Result := OldCreateFile(lpFileName, dwDesiredAccess, dwShareMode,
    lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile);
end;

{$IFDEF PROFESSIONAL}
{$IFDEF Delphi4Up}
function NewLoadLibrary(lpLibFileName: PAnsiChar; hFile: THandle;
  dwFlags: DWORD): HMODULE; stdcall;
begin
  if (Compiled) and (FileExists(ChangeFileExt(lpLibFileName, '.map'))) then
  begin
    Compiled := False;
    if (Assigned(ModuleOptions.CurrentModule)) then ModuleOptions.CurrentModule.BuildMapFile;
  end;
  Result := OldLoadLibrary(lpLibFileName, hFile, dwFlags);
end;
{$ENDIF}
{$ENDIF}

//------------------------------------------------------------------------------

procedure Init;
begin
  IDEManager := nil;
  NotifiersList := TStringList.Create;

{$IFDEF PROFESSIONAL}
  MailSlotOK := MailSlotCreate('EurekaLog', MailSlotSrv);
  if MailSlotOK then MailSlotTimer := TMailSlotTimer.Create(nil);
  OldOnException := nil;

  HookApplicationOnException;
{$IFDEF Delphi4Up}
  OldLoadLibrary := InternalHookDllProcedureEx(LoadLibraryExA_Module, Kernel32,
    'LoadLibraryExA', @NewLoadLibrary);
{$ENDIF}
{$ENDIF}
  OldCreateFile := InternalHookDllProcedureEx(CreateFileA_Module, Kernel32,
    'CreateFileA', @NewCreateFile);

  // Check for the new version...
  UpdateThread := TCheckUpdate.Create(True);
  UpdateThread.Resume;
end;

procedure Done;
begin
  IDEManager := nil;
  NotifiersList.Free;
  NotifiersList := nil;
  TerminateThread(UpdateThread.Handle, 1);
  UpdateThread.Free;

{$IFDEF PROFESSIONAL}
  UnHookApplicationOnException;

  if MailSlotOK then
  begin
    CloseHandle(MailSlotSrv);
    MailSlotTimer.Free;
  end;
{$ENDIF}
end;

//------------------------------------------------------------------------------

{ TCheckUpdate }

procedure TCheckUpdate.Execute;
var
  Ver: string;
  LastCheck: TDateTime;
  CanCheck: Boolean;
  CheckPeriod: Integer;

  function IsGreaterVersion(NewVer: string): Boolean;
  var
    OldVer: string;

    function CompleteVersion(const Ver: string): string;
    var
      Idx, OldIdx, Count, n: Integer;
      S: string;

      function ZeroComplete(const Src: string): string;
      var
        n: Integer;
      begin
        Result := Src;
        for n := Length(Src) to 4 do Result := ('0' + Result);
      end;

    begin
      Count := 0;
      OldIdx := 1;
      repeat
        Idx := PosEx('.', Ver, OldIdx);
        if (Idx > 0) then S := Copy(Ver, OldIdx, (Idx - OldIdx))
        else
        begin
          n := PosEx(' ', Ver, OldIdx);
          if (n = 0) then S := Copy(Ver, OldIdx, MaxInt)
          else S := ZeroComplete(Copy(Ver, OldIdx, n - OldIdx)) +
            Copy(Ver, n, MaxInt);
        end;
        S := ZeroComplete(S);
        if (Count = 0) then Result := S
        else Result := (Result + '.' + S);
        OldIdx := (Idx + 1);
        Inc(Count);
      until (Idx = 0);
      for n := Count to 3 do Result := (Result + '.00000');
    end;

  begin
    Result := False;
    OldVer := CompleteVersion(EurekaLogVersion);
    NewVer := CompleteVersion(NewVer);
    if (NewVer = '') or (OldVer = '') then Exit;
    Result := (NewVer > OldVer);
  end;

  function IsValidVersionString(const Src: string): Boolean;
  var
    Lines: TStringList;
  begin
    Lines := TStringList.Create;
    try
      Lines.Text := Src;
      Result := ((Lines.Count = 1) and (Src <> '') and (Src[1] in ['0'..'9']));
    finally
       Lines.Free;
    end;
  end;

begin
  LastCheck := (ECore.ReadInteger(EurekaIni, 'IDE', 'LastUpdateCheck', 0) * 1000);
  CanCheck := ECore.ReadBool(EurekaIni, 'IDE', 'CanCheckUpdates', True);
  ECore.WriteBool(EurekaIni, 'IDE', 'CanCheckUpdates', CanCheck);
  CheckPeriod := ECore.ReadInteger(EurekaIni, 'IDE', 'UpdatesCheckPeriod', 7);
  ECore.WriteInteger(EurekaIni, 'IDE', 'UpdatesCheckPeriod', CheckPeriod);

  // One check every "CheckPeriod" days.
  CanCheck := (CanCheck) and (Round(Now - LastCheck) >= CheckPeriod);

  if (CanCheck) and (CheckInternetConnection) and
    (GetHTMLPage('http://www.eurekalog.com/lastversion.php', Ver)) and
    (IsValidVersionString(Ver)) then
  begin
    ECore.WriteInteger(EurekaIni, 'IDE', 'LastUpdateCheck', Round(Now * 1000));
    if (IsGreaterVersion(Ver)) then
    begin
      if (MessageBox(0, PChar('The new EurekaLog ' + Ver + ' version is available. ' +
        'Do you want go to the Web site?'), 'New EurekaLog version',
        MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON1 or MB_TASKMODAL or MB_TOPMOST) = ID_YES) then
        ShellExecute(0, 'open', 'http://www.eurekalog.com', nil, nil, SW_SHOWMAXIMIZED);
    end;
  end;
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'ECommon.Init');

finalization
  SafeExec(Done, 'ECommon.Done');

end.

