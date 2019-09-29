{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{         Command-line Unit - ECmdLine           }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ECmdLine;

{$I Exceptions.inc}

interface

function Execute: Integer;

implementation

uses
  SysUtils,
  Windows,
  EBaseModule,
  ECore, Classes;

const
  EL_OPT_CFG = '--el_config';
  EL_OPT_EXE = '--el_alter_exe';

procedure WriteLine(Msg: string);
var
  Dummy: DWord;
begin
  msg := (Msg + #13#10);
  WriteFile(GetStdHandle(STD_OUTPUT_HANDLE), Msg[1], Length(Msg), Dummy, nil);
end;

procedure ErrorFmt(const Msg: string; const Args: array of const);
begin
  WriteLine(Format(Msg, Args));
  Halt(1);
end;

function ExecWait(const Prog, Params: string): Integer;
var
  ProcInfo: TProcessInformation;
  hProcess: THandle;
  StartInfo: TStartupInfo;
  Cmd: string;
begin
  Result := 1;
  if (not FileExists(Prog)) then
    ErrorFmt('File not found: "%s"', [Prog]);
  Cmd := Prog + ' ' + Params;
  FillChar(StartInfo, SizeOf(StartInfo), 0);
  if not CreateProcess(nil, PChar(Cmd), nil, nil, False,
    CREATE_DEFAULT_ERROR_MODE + NORMAL_PRIORITY_CLASS, nil, nil,
    StartInfo, ProcInfo) then
    ErrorFmt('Cannot execute the "%s" command.', [Cmd]);
  hProcess := ProcInfo.hProcess; // Save the process handle.

  //Close the thread handle as soon as it is no longer needed.
  CloseHandle(ProcInfo.hThread);
  WaitForSingleObject(hProcess, INFINITE);
  GetExitCodeProcess(hProcess, DWord(Result));
  CloseHandle(hProcess);
end;

function ProjectExists(ProjectName: string): Boolean;
begin
  ProjectName := Trim(ProjectName);
  Result := FileExists(ProjectName);
  if not Result then
  begin
    if (ProjectName <> '') and (ProjectName[length(ProjectName)] <> '.') then
      Result := FileExists(ProjectName + CurrentPersonality.GetOptionValue(otCmdLineProjectExt, ''));
  end;
end;

function ExpandProjectName(ProjectName: string): string;
begin
  ProjectName := Trim(ProjectName);
  if (not FileExists(ProjectName)) then
    ProjectName := (ProjectName + CurrentPersonality.GetOptionValue(otCmdLineProjectExt, ''));
  Result := ExpandFileName(ProjectName);
  if (not FileExists(Result)) then Result := '';
end;

function Execute: Integer;
var
  Params, Project, S, Compiler: string;
  I: Integer;
  ParamsList: TStringList;
  OnlyAlterEXE: Boolean;
{$IFNDEF CBuilder}
  AppDir, CurrDelphiVer: string;
{$ELSE}
  NextIsProject: Boolean;
{$ENDIF}

  function FindCompiler(Cmp: string): string;
  var
    ExtCmp: string;
  begin
    ExtCmp := ExtractFilePath(ParamStr(0)) + Cmp;
    if (FileExists(ExtCmp)) then Result := ExtCmp
    else
      Result := RADDir + '\Bin\' + Cmp;
  end;

{$IFDEF CBuilder}
  procedure SetCBuilderProject(const S: string);
  var
    Bpr, {$IFDEF Delphi9Down} Bpk, {$ENDIF} PName: string;
  begin
    if (not ProjectExists(S)) then Exit;

    PName := GetCppFileOptionValue(ExpandProjectName(S), 'MAINSOURCE');
    if (PName = '') then PName := ChangeFileExt(S, '.cpp');
        
    if (ExtractFilePath(PName) = '') and (ExtractFilePath(S) <> '') then
      PName := ExtractFilePath(S) + PName;
    if (PName <> '') then
    begin
{$IFDEF Delphi10Up}
      Bpr := ExpandProjectName(ChangeFileExt(PName, '.bdsproj'));
      if (Bpr <> '') then Project := Bpr
{$ELSE}
      Bpr := ExpandProjectName(ChangeFileExt(PName, '.bpr'));
      Bpk := ExpandProjectName(ChangeFileExt(PName, '.bpk'));
      if ((Bpr <> '') and (Bpk <> '')) then
        raise Exception.CreateFmt('Duplicate file: "%s" - "%s"', [Bpr, Bpk])
      else
      begin
        if (Bpr <> '') then Project := Bpr
        else
          if (Bpk <> '') then Project := Bpk;
      end;
{$ENDIF}
    end;
  end;
{$ENDIF}

begin
  try
    OnlyAlterEXE := False;
{$IFNDEF CBuilder}
    // Current Delphi version...
    CurrDelphiVer := Copy(Real_RADVersionString, 1, Length(Real_RADVersionString) - 2);

    // EurekaLog installed dir + other search dirs...
    AppDir := (ReadKey(HKEY_CURRENT_USER, 'Software\EurekaLog', 'AppDir') +
      '\Delphi' + CurrDelphiVer);

    Params := '"-U' + AppDir + '" -GD -$D+'; // (Map File = Detailed) + (Debug Info)

    Compiler := FindCompiler('dcc32.exe');
{$ELSE}
    Params := '';
    Compiler := FindCompiler('make.exe');
    NextIsProject := False;
{$ENDIF}

    Project := '';
    ParamsList := TStringList.Create;
    try
      for I := 1 to ParamCount do
      begin
        if (Copy(LowerCase(ParamStr(I)), 1, Length(EL_OPT_EXE)) = EL_OPT_EXE) then
        begin
          OnlyAlterEXE := True;
          Project := Copy(ParamStr(I), Length(EL_OPT_EXE) + 1, Length(ParamStr(I)));
{$IFDEF CBuilder}
          Project := ExpandProjectName(Project);
          SetCBuilderProject(Project);
{$ENDIF}
          if (not FileExists(Project)) then
            raise Exception.CreateFmt('Project file "%s" not found.', [Project]);
        end
        else
          if (Copy(LowerCase(ParamStr(I)), 1, Length(EL_OPT_CFG)) <> EL_OPT_CFG) then
            ParamsList.Add(ParamStr(I))
          else
          begin
            MasterOptionsFile :=
              Copy(ParamStr(I), Length(EL_OPT_CFG) + 1, Length(ParamStr(I)));
            if (not FileExists(MasterOptionsFile)) then
              raise Exception.CreateFmt('Options file "%s" not found.', [MasterOptionsFile]);
          end;
      end;

      if (Project = '') then
        for I := 0 to (ParamsList.Count - 1) do
        begin
{$IFNDEF CBuilder}
          if ((not (ParamsList[I][1] in ['/', '-'])) and ProjectExists(ParamsList[I])) then
            Project := ExpandProjectName(ParamsList[I]);
{$ELSE}
          if (Copy(ParamsList[I], 1, 2) = '-f') then
          begin
            S := Trim(Copy(ParamsList[I], 3, Length(ParamsList[I])));
            if (S = '') then NextIsProject := True
            else SetCBuilderProject(S);
          end
          else
            if (NextIsProject) then
            begin
              NextIsProject := False;
              SetCBuilderProject(ParamsList[I]);
            end;
{$ENDIF}
          S := ParamsList[I];
          if (Pos(' ', S) > 0) and (Pos('"', S) <> 1) then S := '"' + S + '"';
          Params := (Params + ' ' + S);
        end;
    finally
      ParamsList.Free;
    end;

    if (Project <> '') then
    begin
      if (not OnlyAlterEXE) then
      begin
        ModuleOptions.AddModule(TBaseModule, Project, ltLoadModuleOptions);
        ModuleOptions.CurrentModule.BeforeCompile;
        ExitCode := ExecWait(Compiler, Params);
        if (ExitCode = 0) then
          ModuleOptions.CurrentModule.AfterCompile;
        Result := ExitCode;
      end
      else
      begin
        EBaseModule.Compiled := True;
        ModuleOptions.AddModule(TBaseModule, Project, ltLoadModuleOptions);
        if (not FileExists(ModuleOptions.CurrentModule.CompiledFile)) then
          raise Exception.CreateFmt('Compiled file ''%s'' not found.',
            [ModuleOptions.CurrentModule.CompiledFile]);
        if (not FileExists(ModuleOptions.CurrentModule.MapFile)) then
          raise Exception.CreateFmt('Map file ''%s'' not found.',
            [ModuleOptions.CurrentModule.MapFile]);
        ModuleOptions.CurrentModule.AfterCompile;
        WriteLine('OK.' + #13#10);
        Result := 0;
      end;
    end
    else Result := -1;
  except
    on E: Exception do
    begin
      WriteLine('ERROR: ' + E.Message + #13#10);
      Result := -1;
    end;
  end;
end;

end.

