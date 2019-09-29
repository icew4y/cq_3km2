{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{       OpenTools API classes - EToolsAPI        }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EToolsAPI;

{$I Exceptions.inc}

interface

uses
  Windows, SysUtils, Classes;

{$I VersionStrings.inc}

procedure InitMenu;
procedure InitDelayedMenu;
procedure DoneMenu;
procedure InitNotifier;
procedure DoneNotifier;

implementation

uses
  ECore, ECommon, EBaseModule, EOption, EConsts, EParser, EDesign,
  ToolsApi, {$IFDEF Delphi6Up} DesignIntf, {$ENDIF} Menus, Graphics,
  Forms, Messages, Controls;

type
  TIDENewManager = class(TIDEManager)
  protected
    class function GetEditor(const FileName: string): IOTASourceEditor;
  public
    class function InstallNotifier(const FileName: string): Boolean; override;
    class function RemoveNotifier(const FileName: string): Boolean; override;
    class procedure MarkModified(const FileName: string); override;
    class function GetText(const FileName: string): string; override;
    class procedure InsertText(const FileName: string; StartPos: Integer; Text: PChar); override;
    class procedure DeleteText(const FileName: string; StartPos, EndPos: Integer); override;
    class procedure SetMenuState(Value: Boolean); override;
    class function ShowFile(CompiledFile, UnitName,
      ProcName: string; Line, Offset: Integer; Compiled: TDateTime): Boolean; override;
    class procedure SaveAllModifiedFiles; override;
    class procedure UnloadProjectsList; override;
  end;

  TIDENotifier = class(TInterfacedObject, IOTANotifier, IOTAIDENotifier50)
  private
    { Private declarations }
  protected
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    procedure FileNotification(NotifyCode: TOTAFileNotification;
      const FileName: string; var Cancel: Boolean);
    procedure BeforeCompile(const Project: IOTAProject; var Cancel: Boolean); overload;
    procedure AfterCompile(Succeeded: Boolean); overload;
    procedure BeforeCompile(const Project: IOTAProject; IsCodeInsight: Boolean;
      var Cancel: Boolean); overload;
    procedure AfterCompile(Succeeded: Boolean; IsCodeInsight: Boolean); overload;
  public
    { Public declarations }
  end;

  TModuleNotifier = class(TInterfacedObject, IOTANotifier, IOTAModuleNotifier)
  private
    { Private declarations }
    FModule: IOTAModule;
    FFileName: string;
    FIndex: Integer;
  protected
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    function CheckOverwrite: Boolean;
    procedure ModuleRenamed(const NewName: string);
  public
    { Public declarations }
    constructor Create(const AModule: IOTAModule);
    destructor Destroy; override;

    property Module: IOTAModule read FModule;
    property Index: Integer read FIndex write FIndex;
  end;

{$IFDEF Delphi6Up}
  TDesignNotifier = class(TNotifierObject, IDesignNotification)
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
  end;
{$ENDIF}

var
  SepItem: TMenuItem = nil;
  OptItem: TMenuItem = nil;
  OptView: TMenuItem = nil;
  OptItemBmp: TBitmap = nil;
  EurekaLogItem: TMenuItem = nil;
  IDE_Idx: Integer = -1;
{$IFDEF Delphi6Up}
  DesignNotifier: IDesignNotification;
  HookKey: HHook;
  SelectedComponent: string = '';
  HelpTime: DWord = 0;
{$ENDIF}

// -----------------------------------------------------------------------------

{ TIDENotifier }

procedure TIDENotifier.AfterSave;
begin
  // Nothing...
end;

procedure TIDENotifier.BeforeSave;
begin
  // Nothing...
end;

procedure TIDENotifier.Destroyed;
begin
  // Nothing...
end;

procedure TIDENotifier.Modified;
begin
  // Nothing...
end;

procedure TIDENotifier.BeforeCompile(const Project: IOTAProject; var Cancel: Boolean);
begin
  // Nothing...
end;

procedure TIDENotifier.AfterCompile(Succeeded: Boolean);
begin
  // Nothing...
end;

procedure TIDENotifier.BeforeCompile(const Project: IOTAProject; IsCodeInsight: Boolean;
  var Cancel: Boolean);
var
  Index, n: Integer;
  ModuleInfo: IOTAModuleInfo;
  RequiredFileName: string;

  function EurekaLogRequiredFileName: string;
  var
    Buff: array[0..MAX_PATH - 1] of Char;
    FileName: string;
  begin
    GetModuleFileName(HInstance, Buff, SizeOf(Buff));
    FileName := Buff;
    Result := ChangeFileExt(ExtractFileName(FileName),
      CurrentPersonality.GetOptionValue(otRequiredFileExt, FileName));
  end;

  function CanIncludeInPackage: Boolean;
  begin
    Result := ECore.ReadBool(EurekaIni, 'IDE', 'CanIncludeInPackage', False);
    ECore.WriteBool(EurekaIni, 'IDE', 'CanIncludeInPackage', Result);
  end;

begin
  if (IsCodeInsight) then Exit;

  CompilationProject := Project;
  if (not Assigned(Project)) then Exit;

  for n := 0 to Project.GetModuleCount - 1 do
  begin
    ModuleInfo := Project.GetModule(n);
    if ((Assigned(ModuleInfo)) and
      (CurrentPersonality.IsOptionEqual(ExtractFileExt(ModuleInfo.FileName),
      otRequiredFileExt, ModuleInfo.FileName))) then
    begin
      RequiredFileName := UpperCase(ExtractFileName(ModuleInfo.FileName));
      if ((RequiredFileName = UpperCase(EurekaLogRequiredFileName)) and
        (not CanIncludeInPackage)) then
      begin
        MessageBox(0, PChar(Format('You cannot use the EurekaLog package in other packages.'#13#10 +
          'Remove the "%s" file from the "%s" package and rebuild it.',
          [EurekaLogRequiredFileName, ExtractFileName(Project.FileName)])),
          'Error', MB_OK or MB_ICONERROR or MB_TASKMODAL);
        Cancel := True;
      end;
    end;
  end;

  IDEManager.CheckAndInstallNotify(CompilationProject.FileName);
  Index := ModuleOptions.FindByName(CompilationProject.FileName);
  if (Index <> -1) then ModuleOptions[Index].BeforeCompile;
end;

procedure TIDENotifier.AfterCompile(Succeeded: Boolean; IsCodeInsight: Boolean);
var
  Index: Integer;
begin
  if ((IsCodeInsight) or (not Assigned(CompilationProject))) then Exit;

  Index := ModuleOptions.FindByName(CompilationProject.FileName);
  if ((Index <> -1) and (FileExists(ModuleOptions[Index].CompiledFile))) then
    ModuleOptions[Index].AfterCompile;

  CompilationProject := nil;
end;

procedure TIDENotifier.FileNotification(NotifyCode: TOTAFileNotification;
  const FileName: string; var Cancel: Boolean);
var
  Ext: string;

{$IFDEF Delphi10Up}
  procedure MakeOldOptionsCompatibles(const OptionFile: string; var NotOpen: Boolean);
  var
    List: TStringList;
    n, StartIdx, IDEIdx, ProjectIdx: Integer;
    Line: string;

  function IsOptionFileWritable: Boolean;
  begin
    Result := (IsWritableFile(OptionFile));
    if (not Result) then
    begin
      MessageBox(0, PChar(Format('Before opening the "%s" project, is necessary ' +
        'to convert its EurekaLog section in a compatible format.'#13#10 +
        'Remove the read-only file attribute and retry.',
        [ExtractFileName(OptionFile)])), 'Error', MB_OK or MB_ICONERROR or MB_TASKMODAL);
      NotOpen := True;
    end;
  end;

  begin
    List := TStringList.Create;
    try
      StartIdx := -1;
      IDEIdx := -1;
      ProjectIdx := -1;
      List.LoadFromFile(OptionFile);
      n := 0;
      while (n <= List.Count - 1) do
      begin
        Line := Trim(List[n]);
        if (StartIdx = -1) then
        begin
          if (Pos(EurekaLogFirstLine(FileName), Line) > 0) then StartIdx := n
          else
            if (Line = '[' + EurekaLogSection + ']') then StartIdx := n;
        end;
        if (IDEIdx = -1) and (Line = '</IDEOPTIONS>') then IDEIdx := n;
        if (ProjectIdx = -1) and (Line = '</PROJECT>') then ProjectIdx := n;
        Inc(n);
      end;
      // Check for file without any EurekaLog options...
      if (StartIdx = -1)  then Exit;

      // Check for file valid format...
      if (IDEIdx = -1) or (ProjectIdx = -1) then
        raise Exception.CreateFmt('Invalid file format: "%s"', [OptionFile]);

      // Check for 5.x old file format...
      if (IDEIdx > StartIdx) then
      begin
        if (IsOptionFileWritable) then
        begin
          List.Delete(ProjectIdx);
          List.Delete(IDEIdx);
          List.Insert(StartIdx, '</IDEOPTIONS>');
          List.Insert(StartIdx + 1, '</PROJECT>');
          if (Pos(EurekaLogFirstLine(FileName), List[StartIdx + 2]) = 0) then
          begin // Must append the comments lines...
            List.Insert(StartIdx + 2, EurekaLogFirstLine(FileName));
            List.Append(EurekaLogLastLine(FileName));
          end;
          List.SaveToFile(OptionFile);
        end;
      end
      else
      begin // Check for 4.x old file format...
        if (Pos(EurekaLogFirstLine(FileName), List[StartIdx]) = 0) then
        begin
          if (IsOptionFileWritable) then
          begin
            // Must append the comments lines...
            List.Insert(StartIdx, EurekaLogFirstLine(FileName));
            List.Append(EurekaLogLastLine(FileName));
            List.SaveToFile(OptionFile);
          end;
        end;
      end;
    finally
      List.Free;
    end;
  end;
{$ENDIF}

begin
  HookApplicationOnException;

  Ext := LowerCase(ExtractFileExt(FileName));

{$IFDEF Delphi10Up}
  if (NotifyCode = ofnFileOpening) and ((Ext = '.bpr') or (Ext = '.bpk')) then
  begin
    MakeOldOptionsCompatibles(FileName, Cancel);
    if (Cancel) then Exit;
  end;
{$ENDIF}

  if (CurrentPersonality.IsOptionEqual(Ext, otProjectFileExt, FileName)) or
    (CurrentPersonality.IsOptionEqual(Ext, otPackageFileExt, FileName)) then
  begin
    if (NotifyCode = ofnFileOpened) then IDEManager.CheckAndInstallNotify(FileName)
{$IFDEF Delphi6Up}
    else
      if (NotifyCode = ofnActiveProjectChanged) then
        IDEManager.SetMenuState(IsAcceptableProject(FileName));
{$ENDIF}
  end;
end;

{ TModuleNotifier }

constructor TModuleNotifier.Create(const AModule: IOTAModule);
begin
  inherited Create;
  FModule := AModule;
  FFilename := AModule.FileName;
  FIndex := -1;
end;

destructor TModuleNotifier.Destroy;
begin
  Destroyed;
  inherited;
end;

procedure TModuleNotifier.Destroyed;
var
  Idx: Integer;
begin
  // Remove module...
  if (not Assigned(FModule)) then Exit;

  Idx := ModuleOptions.FindByName(FModule.FileName);
  if (Idx <> -1) then
  begin
    ModuleOptions.Delete(Idx);
    IDEManager.SetMenuState(True);
  end;

  // Remove notifier...
  if (FIndex <> -1) then
  begin
    FModule.RemoveNotifier(Findex);
    IDEManager.RemoveNotifier(FModule.FileName);
    FIndex := -1;
  end;
  FModule := nil;
end;

procedure TModuleNotifier.AfterSave;
var
  Idx: Integer;
begin
  if (not Assigned(FModule)) then Exit;

  Idx := ModuleOptions.FindByName(FModule.FileName);
  if (Idx <> -1) then ModuleOptions[Idx].SaveOptions;
end;

procedure TModuleNotifier.ModuleRenamed(const NewName: string);
var
  Idx: Integer;
begin
  if (not Assigned(FModule)) then Exit;

  Idx := ModuleOptions.FindByName(FFileName);
  if (Idx <> -1) then ModuleOptions[Idx].Name := NewName;
  FFileName := NewName;
end;

procedure TModuleNotifier.BeforeSave;
begin
  if (not Assigned(FModule)) then Exit;

  if (FModule.FileName <> FFileName) then ModuleRenamed(FModule.FileName);
end;

function TModuleNotifier.CheckOverwrite: Boolean;
begin
  Result := True;
end;

procedure TModuleNotifier.Modified;
begin
  // Nothing...
end;


{ TDesignNotifier }

{$IFDEF Delphi6Up}
procedure TDesignNotifier.DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
  // Nothing...
end;

procedure TDesignNotifier.DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
begin
  // Nothing...
end;

procedure TDesignNotifier.ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
begin
  // Nothing...
end;

procedure TDesignNotifier.ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
begin
  // Nothing...
end;

procedure TDesignNotifier.ItemsModified(const ADesigner: IDesigner);
begin
  // Nothing...
end;

procedure TDesignNotifier.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
begin
  if (not IsAcceptableProject(GetCurrentModuleNameProc)) then Exit;

  try // To avoid a ToolsAPI Delphi 2005 bug (only with VCL.net framework)!
    if (ADesigner <> nil) and (ASelection <> nil) and (ASelection.Count > 0) then
      SelectedComponent := UpperCase(ASelection.Items[0].ClassName);
  except
    SelectedComponent :=  '';
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------
// Menu management...
//------------------------------------------------------------------------------

function GetMainMenu: TMainMenu;
var
  Services: INTAServices;
begin
  Result := nil;
  if (not SupportsEx(BorlandIDEServices, INTAServices, Services)) then Exit;

  Result := Services.MainMenu;
end;

function GetCustomMenuIndex(const MenuName: string): Integer;
var
  MainMenu: TMainMenu;
  n: Integer;
begin
  Result := -1;

  MainMenu := GetMainMenu;
  n := 0;
  while (n <= MainMenu.Items.Count - 1) and (MainMenu.Items[n].Name <> MenuName) do Inc(n);
  if (n <= MainMenu.Items.Count - 1) then Result := n;
end;

function GetCustomMenu(const MenuName: string): TMenuItem;
var
  MainMenu: TMainMenu;
  Idx: Integer;
begin
  Result := nil;
  MainMenu := GetMainMenu;
  if (MainMenu <> nil) then
  begin
    Idx := GetCustomMenuIndex(MenuName);
    if (Idx <> -1) then Result := MainMenu.Items[Idx];
  end;
end;

function GetProjectMenu: TMenuItem;
begin
  Result := GetCustomMenu('ProjectMenu');
end;

procedure InitMenu;
var
  ProjectMenu: TMenuItem;
  Services: INTAServices;
  MainMenu: TMainMenu;
  ToolsMenuIdx: Integer;

  function AddMenuItem(const Caption, BitmapName: string; Event: TNotifyEvent): TMenuItem;
  var
    Bmp: TBitmap;
    BmpHandle: THandle;
    Services: INTAServices;
  begin
    Result := TMenuItem.Create(nil);
    Result.Caption := Caption;
    Result.OnClick := Event;

    EurekaLogItem.Add(Result);

    BmpHandle := LoadBitmap(HInstance, PChar(BitmapName));
    if (BmpHandle = 0) then Exit;

    Bmp := TBitmap.Create;
    Bmp.Handle := BmpHandle;

    if (SupportsEx(BorlandIDEServices, INTAServices, Services)) then
      Result.ImageIndex := Services.ImageList.AddMasked(Bmp, 1)
    else
      Result.ImageIndex := -1;
  end;

begin
  ProjectMenu := GetProjectMenu;
  if (ProjectMenu <> nil) then
  begin
    SepItem := TMenuItem.Create(ProjectMenu);
    SepItem.Caption := '-';

    OptItem := TMenuItem.Create(ProjectMenu);
    OptItem.Caption := EOptions;
    OptItem.OnClick := TMenuEvents.OnOptionsClick;

    OptItemBmp := TBitmap.Create;
    OptItemBmp.Handle := LoadBitmap(HInstance, 'OPTIONS_ICON');

    if (SupportsEx(BorlandIDEServices, INTAServices, Services)) then
      OptItem.ImageIndex := Services.ImageList.AddMasked(OptItemBmp, 1)
    else
      OptItem.ImageIndex := -1;

    ProjectMenu.Add(SepItem);
    ProjectMenu.Add(OptItem);
  end;

  MainMenu := GetMainMenu;
  if (MainMenu <> nil) then
  begin
    ToolsMenuIdx := GetCustomMenuIndex('ToolsMenu');
    if (ToolsMenuIdx <> -1) then
    begin
      EurekaLogItem := TMenuItem.Create(nil);
      EurekaLogItem.Caption := EOptionsCaption;
      EurekaLogItem.OnClick := nil;

      OptView := AddMenuItem(EViewItem, 'VIEWER_ICON', TMenuEvents.OnViewLogClick);
      AddMenuItem(EOptions2, 'IDE_ICON', TMenuEvents.OnIDEOptionsClick);
      AddMenuItem('-', '', nil);
      AddMenuItem(ETutorialItem, 'TUTORIAL_ICON', TMenuEvents.OnTutorialClick);
      AddMenuItem(EOptions3, 'HELP_ICON', TMenuEvents.OnHelpOptionsClick);
      AddMenuItem('-', '', nil);
{$IFDEF EUREKALOG_DEMO}
      AddMenuItem(EBuyItem, 'BUY_ICON', TMenuEvents.OnBuyClick);
{$ENDIF}
      AddMenuItem(EAboutItem, 'ABOUT_ICON', TMenuEvents.OnAboutClick);

      MainMenu.Items.Insert((ToolsMenuIdx + 1), EurekaLogItem);
    end;
  end;
end;

procedure InitDelayedMenu;
begin
end;

procedure DoneMenu;
var
  ProjectMenu: TMenuItem;

  procedure FreeItem(Menu: TMenuItem; var Item: TMenuItem);
  begin
    if (Assigned(Item)) then
    begin
      if (ProjectMenu.IndexOf(Item) <> -1) then ProjectMenu.Remove(Item);
      Item.Free;
      Item := nil;
    end;
  end;

begin
  if (Application.Terminated) then Exit;
  
  ProjectMenu := GetProjectMenu;
  if (Assigned(ProjectMenu)) then
  begin
    FreeItem(ProjectMenu, OptItem);
    if (OptItemBmp <> nil) then
    begin
      OptItemBmp.Free;
      OptItemBmp := nil;
    end;
    FreeItem(ProjectMenu, SepItem);
  end;

  EurekaLogItem.Free;
  EurekaLogItem := nil;
end;

procedure InitNotifier;
var
  OTAServices: IOTAServices;
  IDENotifier: IOTAIDENotifier50;
begin
  if (not SupportsEx(BorlandIDEServices, IOTAServices, OTAServices)) Then Exit;

  IDENotifier := TIDENotifier.Create;
  IDE_Idx := OTAServices.AddNotifier(IDENotifier);
  if (IDE_Idx < 0) then IDENotifier := nil;
end;

procedure DoneNotifier;
var
  OTAServices: IOTAServices;
begin
  if (not SupportsEx(BorlandIDEServices, IOTAServices, OTAServices)) Then Exit;

  if (IDE_Idx >= 0) then OTAServices.RemoveNotifier(IDE_Idx);
end;

//------------------------------------------------------------------------------

{ TIDENewManager }

class function TIDENewManager.GetEditor(const FileName: string): IOTASourceEditor;
var
  Module: IOTAModule;
  Intf: IOTAEditor;
  I: Integer;
  OTAModuleServices: IOTAModuleServices;
begin
  Result := nil;
  if (not SupportsEx(BorlandIDEServices, IOTAModuleServices, OTAModuleServices)) then Exit;

  Module := OTAModuleServices.FindModule(FileName);
  if (not Assigned(Module)) then Exit;

  for I := 0 to (Module.GetModuleFileCount - 1) do
  begin
    Intf := Module.GetModuleFileEditor(I);
    if (SupportsEx(Intf, IOTASourceEditor, Result)) then Break;
  end;
end;

class function TIDENewManager.InstallNotifier(const FileName: string): Boolean;
var
  Ext: string;
  Module: IOTAModule;
  Notifier: TModuleNotifier;
  OTAModuleServices: IOTAModuleServices;
  Idx: Integer;
begin
  Result := False;
  Ext := ExtractFileExt(FileName);
  if (CurrentPersonality.IsOptionEqual(Ext, otProjectFileExt, FileName)) or
    (CurrentPersonality.IsOptionEqual(Ext, otPackageFileExt, FileName)) then
  begin
    if (not SupportsEx(BorlandIDEServices, IOTAModuleServices, OTAModuleServices)) then Exit;

    Module := OTAModuleServices.FindModule(FileName);
    if Assigned(Module) then
    begin
      Notifier := TModuleNotifier.Create(Module);
      Idx := Module.AddNotifier(Notifier);
      if (Idx >= 0) then
      begin
        Notifier.Index := Idx;
        InternalInstallNotifier(FileName, Notifier);
        Result := True;
      end
      else Notifier.Free;
    end;
  end;
end;

class function TIDENewManager.RemoveNotifier(const FileName: string): Boolean;
var
  Module: IOTAModule;
  Notifier: TModuleNotifier;
begin
  Result := False;
  Notifier := FindNotifier(FileName);
  if (Assigned(Notifier)) then
  begin
    Module := Notifier.Module;
    if (Assigned(Module)) then
    begin
      Module.RemoveNotifier(Notifier.Index);
      InternalRemoveNotifier(FileName);
      Result := True;
    end;
  end;
end;

class procedure TIDENewManager.MarkModified(const FileName: string);
var
  Module: IOTAModule;
  ModuleServices: IOTAModuleServices;
begin
  if (not SupportsEx(BorlandIDEServices, IOTAModuleServices, ModuleServices)) then Exit;

  Module := ModuleServices.FindModule(FileName);
  if (Assigned(Module)) and (Module.GetModuleFileCount > 0) then
    Module.GetModuleFileEditor(0).MarkModified;
end;

class function TIDENewManager.GetText(const FileName: string): string;
var
  Editor: IOTASourceEditor;
  Reader: IOTAEditReader;
  Len: Integer;
  Text, TextBuffer: string;
begin
  Result := '';
  Editor := GetEditor(FileName);
  if (not Assigned(Editor)) then Exit;

  Reader := Editor.CreateReader;
  if (Assigned(Reader)) then
  try
    Text := '';
    repeat
      SetLength(TextBuffer, BuffSize);
      Len := Reader.GetText(Length(Text), PChar(TextBuffer), BuffSize);
      SetLength(TextBuffer, Len);
      Text := (Text + TextBuffer);
    until (Len = 0);
    Result := Text;
  finally
    Reader := nil;
  end;
end;

class procedure TIDENewManager.InsertText(const FileName: string; StartPos: Integer; Text: PChar);
var
  Editor: IOTASourceEditor;
  Writer: IOTAEditWriter;
begin
  Editor := GetEditor(FileName);
  if (not Assigned(Editor)) then Exit;

  Writer := Editor.CreateWriter;
  if (Assigned(Writer)) then
  try
    Writer.CopyTo(StartPos);
    Writer.Insert(Text);
  finally
    Writer := nil;
  end;
end;

class procedure TIDENewManager.DeleteText(const FileName: string; StartPos, EndPos: Integer);
var
  Editor: IOTASourceEditor;
  Writer: IOTAEditWriter;
begin
  Editor := GetEditor(FileName);
  if (not Assigned(Editor)) then Exit;

  Writer := Editor.CreateWriter;
  if (Assigned(Writer)) then
  try
    Writer.CopyTo(StartPos);
    Writer.DeleteTo(EndPos);
  finally
    Writer := nil;
  end;
end;

class procedure TIDENewManager.SetMenuState(Value: Boolean);
begin
  OptItem.Enabled := Value;
  OptView.Enabled := Value;
end;

class function TIDENewManager.ShowFile(CompiledFile, UnitName,
  ProcName: string; Line, Offset: Integer; Compiled: TDateTime): Boolean;
var
  ActionService: IOTAActionServices;
  Editor: IOTASourceEditor;
  View: IOTAEditView;
  CPos: TOTAEditPos;
  Modified: TDateTime;
  NewLine: Integer;

  function FindFullPath(var FileName: string): Boolean;
  var
    i: Integer;
    Project: IOTAProject;
    Info: IOTAModuleInfo;

    function RealProjectName: string;
    var
      Ext: string;
    begin
      if (CurrentPersonality.GetPersonality = ptDelphiWin32) then Ext := '.dpr'
      else Ext := '.bpr';
      Result := ChangeFileExt(Project.FileName, Ext);
    end;

    function CheckName(const ModuleFileName: string): Boolean;
    begin
      Result := False;
      if (UpperCase(ExtractFileName(FileName)) =
        UpperCase(ExtractFileName(ModuleFileName))) then
      begin
        FileName := ModuleFileName;
        Result := True;
      end;
    end;

  begin
    Result := False;
    if (UpperCase(ExtractFileName(FileName)) =
      UpperCase(ExtractFileName(GetCurrentModuleNameProc))) then
    begin
      FileName := GetCurrentModuleNameProc;
      Result := True;
    end
    else
    begin
      Project := GetCurrentProject;
      if (not Assigned(Project)) then Exit;
      Result := CheckName(RealProjectName);
      if (not Result) then
      begin
        for i := 0 to (Project.GetModuleCount - 1) do
        begin
          Info := Project.GetModule(i);
          if ((Assigned(Info)) and (Info.FileName <> '')) then
          begin
            Result := CheckName(Info.FileName);
            if (Result) then Break;
          end;
        end;
      end;
    end;
  end;

{$IFDEF Delphi9Up}
  function FindSimilarUnit(var UnitName: string; CompiledDate: TDateTime): Boolean;
  var
    sr: TSearchRec;
    FileAttrs: Integer;
    MinDelta, DeltaDate: Double;
    Name, Path: string;
  begin
    Result := False;

    Name := '';
    MinDelta := 1E300;
    FileAttrs := faArchive;
    Path := (ExtractFilePath(UnitName) + '__history\' +
      ExtractFileName(UnitName) + '.~*~');
    if (FindFirst(Path, FileAttrs, sr) = 0) then
    begin
      repeat
        DeltaDate := (CompiledDate - GetGMTDateTime(GetModifiedDate(sr.Name)));
        if (DeltaDate > 0) and (DeltaDate < MinDelta) then
        begin
          Name := sr.Name;
          MinDelta := DeltaDate;
        end;
      until (FindNext(sr) <> 0);
      FindClose(sr);

      if ((Name <> '') and (MessageBox(0,
        PChar(Format('The Unit sources has been modified.' + #13#10 +
        'Do you want open the backuped "history" unit version?', [])),
        'Confirm', MB_YESNO or MB_ICONQUESTION or
        MB_TASKMODAL or MB_DEFBUTTON1) = ID_YES)) then
      begin
        UnitName := (ExtractFilePath(Path) + Name);
        Result := True;
      end;
    end;
  end;
{$ENDIF}

begin
  Result := False;
  if (GetCurrentProject = nil) then Exit;

  if (CompiledFile <> '') then
  begin
    if (CompareText(ExtractFileName(ModuleOptions.CurrentModule.CompiledFile),
      ExtractFileName(CompiledFile)) <> 0) or
      (ModuleOptions.CurrentModule.CompiledDate <> Compiled) then Exit;
  end;
  if (not FindFullPath(UnitName)) and (not PathFromInternalFiles(UnitName)) then Exit;

{$IFDEF Delphi9Up}
  Modified := GetGMTDateTime(GetModifiedDate(UnitName));
  if (Modified > Compiled) then FindSimilarUnit(UnitName, Compiled);
{$ENDIF}

  Editor := GetEditor(UnitName);
  if (not Assigned(Editor)) then
  begin
    if (not SupportsEx(BorlandIDEServices, IOTAActionServices, ActionService)) then Exit;

    ActionService.OpenFile(UnitName);
    Editor := GetEditor(UnitName);
    if (not Assigned(Editor)) then Exit;
  end;

  Editor.Show;
  if (Editor.GetEditViewCount = 0) then Exit;

  if (Offset >= 0) then
  begin
    Modified := GetGMTDateTime(GetModifiedDate(UnitName));
    if (Modified > Compiled) then
    begin
      if (CurrentPersonality.GetPersonality = ptDelphiWin32) then
        NewLine := FindProcStartLineDelphi(GetText(UnitName), ProcName)
      else
        NewLine := FindProcStartLineCppBuilder(GetText(UnitName), ProcName);
      if (NewLine > 0) then Line := (NewLine + Offset);
    end;
  end;

  Application.Restore;
  SetForegroundWindow(Application.Handle);

  CPos.Col := 1;
  CPos.Line := Line;
  View := Editor.GetEditView(0);
  View.CursorPos := CPos;
  Dec(CPos.Line, View.GetViewSize.cy div 2);
  if (CPos.Line < 1) then CPos.Line := 1;
  View.TopPos := CPos;
  if ((View.GetEditWindow <> nil) and (View.GetEditWindow.Form <> nil)) then
  begin
    View.GetEditWindow.Form.Show;
    keybd_event(VK_ESCAPE, MapvirtualKey(VK_ESCAPE, 0), 0, 0) ;
    keybd_event(VK_ESCAPE, MapvirtualKey(VK_ESCAPE, 0), KEYEVENTF_KEYUP, 0) ;
    View.GetEditWindow.Form.Refresh;
  end;
  Result := True;
end;

class procedure TIDENewManager.SaveAllModifiedFiles;
var
  i, j: Integer;
  Module: IOTAModule;
  ModuleServices: IOTAModuleServices;
  Editor: IOTAEditor;
begin
  if (not SupportsEx(BorlandIDEServices, IOTAModuleServices, ModuleServices)) then Exit;

  for i := 0 to (ModuleServices.ModuleCount - 1) do
  begin
    Module := ModuleServices.Modules[i];
    for j := 0 to (Module.GetModuleFileCount - 1) do
    begin
      Editor := Module.GetModuleFileEditor(j);
      if ((Assigned(Editor)) and (Editor.Modified)) and
        (MessageBox(0,
        PChar(Format('File name: %s'#13#10#13#10'Do you want to save this file?',
        [Editor.FileName])), 'Confirm', MB_YESNO or MB_ICONQUESTION or
        MB_TASKMODAL or MB_DEFBUTTON1) = id_yes) then
        if (not Module.Save(False, True)) then
          MessageBox(0,
            PChar(Format('File name: %s'#13#10#13#10 +
            'An error is occurred during the saving.',
            [Editor.FileName])), 'Error', MB_OK or MB_ICONERROR or MB_TASKMODAL);
    end;
  end;
end;

class procedure TIDENewManager.UnloadProjectsList;
var
  n: Integer;
  Notifier: TModuleNotifier;
begin
  for n := (ModuleOptions.Count - 1) downto 0 do
  begin
    Notifier := FindNotifier(ModuleOptions[n].Name);
    if (Assigned(Notifier)) then Notifier._Release;
  end;
end;

//------------------------------------------------------------------------------

{$IFDEF Delphi6Up}
function MyKeyHook(nCode: Integer; wParam, lParam: Longint): Longint; stdcall;
var
  Msg: TMsg;
begin
  if (nCode >= 0) and (wParam = VK_F1) and (lParam and $40000000 = 0) and
  (SelectedComponent = 'TEUREKALOG') then
  begin
    if (GetTickCount - HelpTime > 500) then ShowHelp('Welcome'); // To avoid multiple open!
    HelpTime := GetTickCount;
    Result := 1;
    PeekMessage(Msg, 0, 0, 0, PM_REMOVE);
  end
  else Result := CallNextHookEx(HookKey, nCode, wParam, lParam);
end;

procedure StartKeyHook;
begin
  HookKey := SetWindowsHookEx(WH_KEYBOARD, @MyKeyHook, 0, MainThreadID);
end;

procedure EndKeyHook;
begin
  UnhookWindowsHookEx(HookKey);
end;
{$ENDIF}

//------------------------------------------------------------------------------

procedure Init;
begin
  IDEManager := TIDENewManager;
{$IFDEF Delphi9Up}
  SplashScreenServices.AddPluginBitmap(GetEurekaLogLabel,
    LoadBitmap(HInstance, 'SPLASH_ICON'),
{$IFDEF EUREKALOG_DEMO}
    True, 'Trial version'
{$ELSE}
    False, 'Registered version'
{$ENDIF});
{$ENDIF}

{$IFDEF Delphi6Up}
  DesignNotifier := TDesignNotifier.Create;
  RegisterDesignNotification(DesignNotifier);
  StartKeyHook;
{$ENDIF}
end;

procedure Done;
begin
{$IFDEF Delphi6Up}
  UnregisterDesignNotification(DesignNotifier);
  DesignNotifier := nil;
  EndKeyHook;
{$ENDIF}
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'EToolsAPI.Init');

finalization
  SafeExec(Done, 'EToolsAPI.Done');

end.
