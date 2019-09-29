{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{            Options Unit - EOption              }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EOption;

{$I Exceptions.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Grids,
  ShellApi, FileCtrl, Registry, ExceptionLog,  ECore, EBaseModule,
  {$IFDEF Delphi4Up} ImgList, ToolsApi {$ELSE} EditIntf, ExptIntf, IniFiles {$ENDIF};

const
  DialogValues: array[TFilterDialogType] of string =
    ('(无)', '无变化', '标准对话框', '微软经典', 'EurekaLog');
  HandleValues: array[TFilterHandlerType] of string = ('(无)', 'RTL', 'EurekaLog');
  ActionValues: array[TFilterActionType] of string = ('(无)', '终止', '重新启动');
  TypeValues: array[TFilterExceptionType] of string = ('所有', '句柄', '无句柄');

type
  TModule = class(TBaseModule)
  protected
    class function GetText(const FileName: string): string; override;
    function GetOutputDir: string; override;
    procedure SetDebugOptions(Active: Boolean); override;
    procedure InsertText(const FileName: string; StartPos: Integer; Text: PChar); override;
    procedure DeleteText(const FileName: string; StartPos, EndPos: Integer); override;
    procedure GetModuleInfo(var MType: TModuleType; var ext: string); override;

    procedure ErrorMessage(const Msg: string); override;
    function GetRealFileName(FileName: string; Compiled: Boolean): string; override;
  public
    procedure GetUnitDirs(List: TStrings); override;
    procedure MakeLine(Active: Boolean); override;
    function BuildMapFile: Boolean; override;
  end;

  TOptionsForm = class(TForm)
    OpenDialog: TOpenDialog;
    ButtonsPanel: TPanel;
    HelpBtn: TBitBtn;
    CancelBtn: TBitBtn;
    OKBtn: TBitBtn;
    Default: TCheckBox;
    Activate: TCheckBox;
    MenuPanel: TPanel;
    MenuImage: TImage;
    OptionsPanel: TPanel;
    Big: TPageControl;
    Tab1: TTabSheet;
    Panel4: TPanel;
    Tab3: TTabSheet;
    Tab4: TTabSheet;
    Tab5: TTabSheet;
    Tab6: TTabSheet;
    Tab2: TTabSheet;
    Shape1: TShape;
    Shape: TShape;
    EmailSendOptionsPanel: TPanel;
    MessageLabel: TLabel;
    AddressesLabel: TLabel;
    SubjectLabel: TLabel;
    Label2: TLabel;
    AppendTheLog: TCheckBox;
    Msg: TMemo;
    Addresses: TEdit;
    Obj: TEdit;
    SMTPSettingsPanel: TPanel;
    SMTPFromLabel: TLabel;
    SMTPHostLabel: TLabel;
    SMTPPortLabel: TLabel;
    SMTPPasswordLabel: TLabel;
    SMTPUserIDLabel: TLabel;
    SMTPFromEdt: TEdit;
    SMTPHostEdt: TEdit;
    SMTPPortEdt: TEdit;
    SMTPPasswordEdt: TEdit;
    SMTPUserIDEdt: TEdit;
    Panel: TPanel;
    EmailSendModeEdit: TComboBox;
    EmailSendOptionsTitle: TPanel;
    Shape2: TShape;
    Shape3: TShape;
    WebSendOptionsPanel: TPanel;
    WebPortLabel: TLabel;
    WebUserLabel: TLabel;
    WebPasswordLabel: TLabel;
    WebURLLabel: TLabel;
    Label1: TLabel;
    WebPortEdit: TEdit;
    WebUserEdit: TEdit;
    WebPasswordEdit: TEdit;
    WebURLEdit: TEdit;
    ProxyOptionsPanel: TPanel;
    ProxyURLLabel: TLabel;
    ProxyUserLabel: TLabel;
    ProxyPasswordLabel: TLabel;
    ProxyPortLabel: TLabel;
    ProxyURLEdt: TEdit;
    ProxyUserEdt: TEdit;
    ProxyPasswordEdt: TEdit;
    ProxyPortEdt: TEdit;
    Panel6: TPanel;
    WebSendModeEdit: TComboBox;
    TrakerOptionsPanel: TPanel;
    TrakerUserLabel: TLabel;
    TrakerPasswordLabel: TLabel;
    TrakerAssignToLabel: TLabel;
    TrakerTrialIDLabel: TLabel;
    TrakerProjectLabel: TLabel;
    TrakerCategoryLabel: TLabel;
    TrakerUserEdt: TEdit;
    TrakerPasswordEdt: TEdit;
    TrakerAssignToEdt: TEdit;
    TrakerTrialIDEdt: TEdit;
    TrakerProjectEdt: TEdit;
    TrakerCategoryEdt: TEdit;
    Panel7: TPanel;
    Panel5: TPanel;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Panel8: TPanel;
    Image3: TImage;
    Panel9: TPanel;
    Shape7: TShape;
    HelpText: TLabel;
    Shape8: TShape;
    Image1: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Panel10: TPanel;
    Shape10: TShape;
    Label4: TLabel;
    Panel12: TPanel;
    Image8: TImage;
    Shape11: TShape;
    Panel13: TPanel;
    SendOptionsPanel: TPanel;
    Shape9: TShape;
    AttachedFilesLabel: TLabel;
    Panel14: TPanel;
    Image9: TImage;
    ShowTheSendDialog: TCheckBox;
    AddComputerInFileName: TCheckBox;
    ResultMessage: TCheckBox;
    SendTheEntireLog: TCheckBox;
    AttachedFilesEdit: TEdit;
    SendScreen: TCheckBox;
    AddDateInFileName: TCheckBox;
    SendXMLCopy: TCheckBox;
    SendHTML: TCheckBox;
    SendInThread: TCheckBox;
    Shape12: TShape;
    Panel15: TPanel;
    Shape13: TShape;
    ExceptionsFiltersPanel: TPanel;
    Panel17: TPanel;
    Image10: TImage;
    Shape14: TShape;
    Activate_Handle: TCheckBox;
    ExceptionsFiltersList: TListView;
    AddBtn: TSpeedButton;
    SubBtn: TSpeedButton;
    Panel18: TPanel;
    Shape15: TShape;
    Label10: TLabel;
    Panel19: TPanel;
    Image11: TImage;
    Shape16: TShape;
    Panel20: TPanel;
    Shape17: TShape;
    Panel31: TPanel;
    Shape23: TShape;
    Label39: TLabel;
    Panel32: TPanel;
    Image17: TImage;
    Shape24: TShape;
    LogFileOptionsPanel: TPanel;
    Shape18: TShape;
    Panel22: TPanel;
    Image12: TImage;
    LogNumbers: TLabel;
    OutputPathLabel: TLabel;
    OutputBtn: TSpeedButton;
    ErrorsNumber: TEdit;
    UpDown: TUpDown;
    LogSaveLogFile: TCheckBox;
    OutputPathEdit: TEdit;
    DoNotSaveDuplicate: TCheckBox;
    AppendReproduceText: TCheckBox;
    SaveModulesSection: TCheckBox;
    SaveCPUSection: TCheckBox;
    DeleteLog: TCheckBox;
    AddComputerNameInLogFile: TCheckBox;
    ShowOptionsPanel: TPanel;
    Shape19: TShape;
    Panel24: TPanel;
    Image13: TImage;
    OptionsList: TListView;
    Panel27: TPanel;
    Shape20: TShape;
    MessagesPanel: TPanel;
    Shape21: TShape;
    Panel29: TPanel;
    Image14: TImage;
    Panel34: TPanel;
    Shape25: TShape;
    Label14: TLabel;
    Panel35: TPanel;
    Image16: TImage;
    Shape26: TShape;
    MessagesList: TListView;
    Label11: TLabel;
    TextLabel: TLabel;
    TextMemo: TMemo;
    Panel30: TPanel;
    Shape22: TShape;
    Panel33: TPanel;
    ExceptionDialogOptionsPanel: TShape;
    Panel36: TPanel;
    Image15: TImage;
    Panel37: TPanel;
    Shape28: TShape;
    Label15: TLabel;
    Panel38: TPanel;
    Image18: TImage;
    Shape29: TShape;
    CloseDialogLabel1: TLabel;
    CloseDialogLabel2: TLabel;
    SupportURLLabel: TLabel;
    HTMLLayoutLabel: TLabel;
    HTMLLayoutHELP: TLabel;
    ShowCustomHelpBtn: TCheckBox;
    ShowDetailsButton: TCheckBox;
    ShowInDetailedMode: TCheckBox;
    SendErrorChecked: TCheckBox;
    ShowAttachScreenshot: TCheckBox;
    ShowCopyToClip: TCheckBox;
    ShowInTopMost: TCheckBox;
    CloseDialogEdit: TEdit;
    CloseDialogUpDown: TUpDown;
    SupportURLEdit: TEdit;
    HTMLLayoutMemo: TMemo;
    ShowSendErrorReport: TCheckBox;
    AttachScreenshotChecked: TCheckBox;
    Error_Label: TLabel;
    TerminateUpDown: TUpDown;
    Terminate_Edit: TEdit;
    Option_Label: TLabel;
    TerminateOperationEdt: TComboBox;
    Label_Terminate: TLabel;
    Foreground_Label: TLabel;
    ForegroundTabEdt: TComboBox;
    Label23: TLabel;
    DialogTypeCmb: TComboBox;
    LookAndFeel: TCheckBox;
    Tab7: TTabSheet;
    Panel39: TPanel;
    Shape30: TShape;
    Panel42: TPanel;
    Shape32: TShape;
    Label16: TLabel;
    Panel43: TPanel;
    Image20: TImage;
    Shape33: TShape;
    CallStackOptionsPanel: TPanel;
    Shape34: TShape;
    EncryptPasswordLabel: TLabel;
    ShowDLLs: TCheckBox;
    ShowBPLs: TCheckBox;
    ShowBorlandThreads: TCheckBox;
    ShowWindowsThreads: TCheckBox;
    EncryptPasswordEdit: TEdit;
    Panel44: TPanel;
    Image21: TImage;
    DoNotStoreProcNames: TCheckBox;
    FrmFreezePanel: TPanel;
    Shape35: TShape;
    FreezeActivateChkBox: TCheckBox;
    Panel45: TPanel;
    Image22: TImage;
    BehaviourPanel: TPanel;
    Shape36: TShape;
    AutoTerminateLabel1: TLabel;
    AutoTerminateLabel2: TLabel;
    AutoTerminateLabel3: TLabel;
    AutoTerminationOperation: TComboBox;
    AutoTerminateCrachesEdit: TEdit;
    AutoTerminateCrachedUpDown: TUpDown;
    AutoTerminateMinutesEdit: TEdit;
    AutoTerminateMinutesUpDown: TUpDown;
    PauseBorlandThreads: TCheckBox;
    DoNotPauseMainThread: TCheckBox;
    PauseWindowsThreads: TCheckBox;
    CopyLogInCaseOfError: TCheckBox;
    UseMainModuleOptions: TCheckBox;
    SaveCompressedFilesCopy: TCheckBox;
    Panel46: TPanel;
    Image23: TImage;
    CallRTLExceptionEvent: TCheckBox;
    CatchHandledExceptions: TCheckBox;
    Label25: TLabel;
    CollectionsList: TComboBox;
    DeleteCollectionBtn: TSpeedButton;
    SaveCollectionBtn: TSpeedButton;
    Tab8: TTabSheet;
    Panel40: TPanel;
    Shape31: TShape;
    Label26: TLabel;
    Panel48: TPanel;
    Image24: TImage;
    Shape38: TShape;
    Panel49: TPanel;
    Shape39: TShape;
    BuildPanel: TPanel;
    PreBuildLabel: TLabel;
    Panel51: TPanel;
    Image25: TImage;
    PreBuildEventEdt: TEdit;
    Shape40: TShape;
    PostBuildSuccessLabel: TLabel;
    PostSuccessfulBuildEventEdt: TEdit;
    PostBuildFailureLabel: TLabel;
    PostFailureBuildEventEdt: TEdit;
    SaveDialog: TSaveDialog;
    MenuTitle: TLabel;
    Border1: TShape;
    Border2: TShape;
    Border3: TShape;
    Border4: TShape;
    Border5: TShape;
    Border6: TShape;
    Border7: TShape;
    Border8: TShape;
    Option1: TPanel;
    Option2: TPanel;
    Option3: TPanel;
    Option4: TPanel;
    Option5: TPanel;
    Option6: TPanel;
    Option7: TPanel;
    Option8: TPanel;
    ZipLabel: TLabel;
    ZipPasswordEdt: TEdit;
    UseActiveWindow: TCheckBox;
    FlatTimer: TTimer;
    Shadow: TImage;
    PreBuildBtn: TSpeedButton;
    PostSuccBtn: TSpeedButton;
    PostFailBtn: TSpeedButton;
    OpenBuildDialog: TOpenDialog;
    MemoryLeaksPanel: TPanel;
    Shape27: TShape;
    CatchLeaks: TCheckBox;
    Panel2: TPanel;
    Image2: TImage;
    GroupLeaks: TCheckBox;
    HideBorlandLeaks: TCheckBox;
    FreeLeaks: TCheckBox;
    CompiledFilePanel: TPanel;
    Shape37: TShape;
    ReduceFileSize: TCheckBox;
    Panel47: TPanel;
    Image19: TImage;
    CheckFileCorruption: TCheckBox;
    CatchLeaksErrors: TCheckBox;
    FreezeTimeoutEdit: TEdit;
    FreezeTimeoutUpDown: TUpDown;
    FreezeTimeOutLabel: TLabel;
    VariableBtn: TBitBtn;
    Panel1: TPanel;
    SaveBtn: TBitBtn;
    LoadBtn: TBitBtn;
    OrderBtn: TBitBtn;
    HandleSafeCall: TCheckBox;
    LeaksLimits: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    procedure AddBtnClick(Sender: TObject);
    procedure SubBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RewriteLogClick(Sender: TObject);
    procedure ErrorsNumberKeyPress(Sender: TObject; var Key: Char);
    procedure SendOptionsClick(Sender: TObject);
    procedure OutputBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure HelpBtnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LogSaveLogFileClick(Sender: TObject);
    procedure FreezeActivateChkBoxClick(Sender: TObject);
    procedure ActivateClick(Sender: TObject);
    procedure ActivateAutoTerminationClick(Sender: TObject);
    procedure PauseBorlandThreadsClick(Sender: TObject);
    procedure WebOptClick(Sender: TObject);
    procedure SendScreenClick(Sender: TObject);
    procedure Option1Click(Sender: TObject);
    procedure TextMemoExit(Sender: TObject);
    procedure ExceptionsFiltersListDblClick(Sender: TObject);
    procedure Activate_HandleClick(Sender: TObject);
    procedure SaveCollectionBtnClick(Sender: TObject);
    procedure DeleteCollectionBtnClick(Sender: TObject);
    procedure TextMemoChange(Sender: TObject);
    procedure Option1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FlatTimerTimer(Sender: TObject);
    procedure ExceptionsFiltersListDeletion(Sender: TObject; Item: TListItem);
    procedure ExceptionsFiltersListInsert(Sender: TObject; Item: TListItem);
    procedure CollectionsListClick(Sender: TObject);
    procedure MessagesListClick(Sender: TObject);
    procedure MessagesListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PreBuildBtnClick(Sender: TObject);
    procedure PostSuccBtnClick(Sender: TObject);
    procedure PostFailBtnClick(Sender: TObject);
    procedure CatchLeaksClick(Sender: TObject);
    procedure Panel49Resize(Sender: TObject);
    procedure VariableBtnClick(Sender: TObject);
    procedure DialogTypeCmbChange(Sender: TObject);
    procedure TerminateOperationEdtChange(Sender: TObject);
    procedure AutoTerminationOperationChange(Sender: TObject);
    procedure LeaksLimitsClick(Sender: TObject);
    procedure CheckFileCorruptionClick(Sender: TObject);
  private
    { Private declarations }
    OldModule: TModule; // Used to stored TEMP Options data (saved on OK click)
    function GetEmailSendType: TEmailSendMode;
    procedure SetEmailSendType(Value: TEmailSendMode);
    function GetWebSendType: TWebSendMode;
    procedure SetWebSendType(Value: TWebSendMode);
    procedure SaveModuleToForm(Module: TBaseModule);
    procedure LoadModuleFromForm(Module: TBaseModule);
    procedure ChangeMessageText(Item: TListItem);
{$IFDEF Delphi4Up}
    procedure MessagesTextCustomDraw(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
{$ENDIF}
  public
    { Public declarations }
  end;

  TEditorOperation = (eoAddUnit, eoRemoveUnit, eoCheck);

{$IFDEF Delphi4Up}
var
  CompilationProject: IOTAProject = nil;

function GetCurrentProject: IOTAProject;

function GetCurrentProjectName: string;
{$ENDIF}

implementation

uses EWait, EMessages, EVariables, EConsts, ETypes, EDesign, TypInfo, ToolIntf,
     ECommon {$IFDEF Delphi9Up} ,CommCtrl {$ENDIF} ,EWebTools;

{$R *.DFM}

const
  CollectionNone = '(无)';
  SelectedOptionColor = $F5D1AF;
  FlatOptionColor = $B9FEFF;
  UnselectedOptionColor = $EBEBEB;
  SelectedFontColor = $383838;
  UnselectedFontColor = $4E4E4E;
  ShapeSelectedColor = $C18043;
  ShapeUnselectedColor = $A8A8A8;

var
  LastItem: TListItem;
  LastOption: TPanel;
  OldActiveOption: string = '';
  LastActiveOption: string = '选项';
  LastActiveProject: string = '';

procedure FullEnaled(Cnt: TControl; Enabled: Boolean);
var
  i: Integer;
  WCnt: TWinControl;
begin
  Cnt.Enabled := Enabled;
  if (Cnt is TWinControl) then
  begin
    WCnt := TWinControl(Cnt);
    for i := 0 to WCnt.ControlCount - 1 do
      FullEnaled(WCnt.Controls[i], Enabled);
  end;
end;

procedure ListAllCollections(Dir: string; List: TStrings);
var
  sr: TSearchRec;
  FileAttrs: Integer;
begin
  if (Copy(Dir, Length(Dir), 1) <> '\') then Dir := (Dir + '\');
  Dir := (Dir + 'X'); // "GetWorkingFile" works only with files (not dir)...
  if (not GetWorkingFile(Dir, False, False)) then Exit;

  Delete(Dir, Length(Dir), 1); // Removed "X" char.

  List.Clear;
  FileAttrs := faArchive;
  if (FindFirst(Dir + '*.etf', FileAttrs, sr) = 0) then
  begin
    repeat
      List.Add(ChangeFileExt(sr.Name, ''));
    until (FindNext(sr) <> 0);
    FindClose(sr);
  end;
end;

{$IFDEF Delphi4Up}

function GetCurrentProject: IOTAProject;
var
  ProjectGroup: IOTAProjectGroup;

  function FindModuleInterface(AInterface: TGUID): IUnknown;
  var
    I: Integer;
    ModuleServices: IOTAModuleServices;
  begin
    Result := nil;
    if (not SupportsEx(BorlandIDEServices, IOTAModuleServices, ModuleServices)) then Exit;

    for I := 0 to (ModuleServices.ModuleCount - 1) do
      if (SupportsEx(ModuleServices.Modules[I], AInterface, Result)) then Break;
  end;

begin
  Result := nil;
  if (Application.Terminated) then Exit;

  if (CompilationProject <> nil) then Result := CompilationProject
  else
  try
    ProjectGroup := FindModuleInterface(IOTAProjectGroup) as IOTAProjectGroup;
    if Assigned(ProjectGroup) then Result := ProjectGroup.ActiveProject
    else Result := FindModuleInterface(IOTAProject) as IOTAProject;
  except
    // Sometimes a 3th party "IDE hook" can returns invalid interfaces...
  end;
end;

function GetCurrentProjectName: string;
var
  Project: IOTAProject;
begin
  Result := '';
  Project := GetCurrentProject;
  if (Project <> nil) then Result := ExtractFileName(Project.FileName);
end;
{$ENDIF}

{$IFDEF Delphi5Up}
type
  TKeyThread = class(TThread)
  public
    procedure Execute; override;
    constructor Create;
  end;

constructor TKeyThread.Create;
begin
  inherited Create(True);
  FreeOnTerminate := True;
  Resume;
end;

procedure TKeyThread.Execute;
var
  Wnd: THandle;

  function GetActiveFormClass(hWnd: Thandle): string;
  var
    Buff: array[0..255] of Char;
    I: DWord;
  begin
    I := SizeOf(Buff);
    if GetClassName(hWnd, Buff, I) > 0 then Result := Buff
    else Result := '';
  end;

begin
  repeat
    Wnd := GetForegroundWindow;
  until (GetActiveFormClass(Wnd) = 'TMessageForm');
  PostMessage(Wnd, WM_KEYDOWN, 13, MakeLong(0, MapVirtualKey(13, 0)));
  PostMessage(Wnd, WM_KEYUP, 13, MakeLong(0, MapVirtualKey(13, 0) or $C000));
end;
{$ENDIF}

procedure TOptionsForm.AddBtnClick(Sender: TObject);
begin
  MessageForm := TMessageForm.Create(nil);
  with MessageForm do
  begin
    if ShowModal = mrOK then
      with OldModule do
      begin
        with ExceptionsFiltersList.Items.Add do
        begin
          Checked := True;
          Caption := ExceptionClassEdit.Text;
          SubItems.Add(HandlerTypeCmb.Text);
          SubItems.Add(ExceptionTypeCmb.Text);
          SubItems.Add(ExceptionMessageText.Lines.Text);
          SubItems.Add(DialogTypeCmb.Text);
          SubItems.Add(ActionTypeCmb.Text);
        end;
      end;
    Free;
  end;
end;

procedure TOptionsForm.AutoTerminationOperationChange(Sender: TObject);
var
  State: Boolean;
begin
  State := (Activate.Checked) and (AutoTerminationOperation.ItemIndex > 0);
  AutoTerminateLabel1.Enabled := State;
  AutoTerminateCrachesEdit.Enabled := State;
  AutoTerminateCrachedUpDown.Enabled := State;
  AutoTerminateLabel2.Enabled := State;
  AutoTerminateMinutesEdit.Enabled := State;
  AutoTerminateMinutesUpDown.Enabled := State;
  AutoTerminateLabel3.Enabled := State;
end;

procedure TOptionsForm.CollectionsListClick(Sender: TObject);
var
  FileName: string;
  Item: TListItem;

  procedure LoadTextsFromFile(const FileName: string);
  var
    n: Integer;
    Text: string;
  begin
    for n := 0 to (MessagesList.Items.Count - 1) do
    begin
      if (MessagesList.Items[n].Data <> Pointer(-1)) then
      begin
        ReadRawStrings(FileName, EurekaLogSection, 'Count ' +
          GetEnumName(TypeInfo(TMessageType), Integer(MessagesList.Items[n].Data)),
          GetEnumName(TypeInfo(TMessageType), Integer(MessagesList.Items[n].Data)),
          '', Text);
        MessagesList.Items[n].SubItems[0] := Text;
      end;
    end;
  end;

begin
  if (CollectionsList.Text = CollectionNone) or (CollectionsList.ItemIndex = -1) then Exit;

  FileName := CollectionsList.Text;
  LoadTextsFromFile(BaseDir + 'Texts\' + ChangeFileExt(FileName, '.etf'));
  ListAllCollections(BaseDir + 'Texts', CollectionsList.Items);
  CollectionsList.ItemIndex := CollectionsList.Items.IndexOf(FileName);
  Item := MessagesList.Selected;
  if (Item <> nil) and (Item.Data <> Pointer(-1)) then
    TextMemo.Lines.Text := Item.SubItems[0];
  DeleteCollectionBtn.Enabled := True;
end;

procedure TOptionsForm.DeleteCollectionBtnClick(Sender: TObject);
var
  FileName: string;
begin
  TextMemoExit(nil);
  if (MessageBox(0, EAreYouSure, EAttenction,
    MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2 or MB_TASKMODAL) = ID_Yes) then
  begin
    FileName := (BaseDir + 'Texts\' + ChangeFileExt(CollectionsList.Text, '.etf'));
    if (not GetWorkingFile(FileName, False, False)) then Exit;

    if (CollectionsList.Text <> CollectionNone) then DeleteFile(PChar(FileName));
    CollectionsList.Items.Delete(CollectionsList.ItemIndex);
    if (CollectionsList.Items.Count > 0) then
    begin
      CollectionsList.ItemIndex := 0;
      CollectionsListClick(nil);
    end
    else
    begin
      CollectionsList.Items.Add(CollectionNone);
      CollectionsList.ItemIndex := 0;
      DeleteCollectionBtn.Enabled := False;
    end;
    CollectionsList.Refresh;
  end;
end;

procedure TOptionsForm.DialogTypeCmbChange(Sender: TObject);
var
  State, StateMS, StateEL: Boolean;
begin
  State := (DialogTypeCmb.ItemIndex > 0) and (Activate.Checked);
  StateMS := (DialogTypeCmb.ItemIndex = 2) and (Activate.Checked);
  StateEL := (DialogTypeCmb.ItemIndex = 3) and (Activate.Checked);
  Label_Terminate.Enabled := (StateMS or StateEL);
  TerminateOperationEdt.Enabled := (StateMS or StateEL);
  Option_Label.Enabled := (StateMS or StateEL);
  Terminate_Edit.Enabled := (StateMS or StateEL);
  TerminateUpDown.Enabled := (StateMS or StateEL);
  Error_Label.Enabled := (StateMS or StateEL);
  CloseDialogLabel1.Enabled := (StateMS or StateEL);
  CloseDialogLabel2.Enabled := (StateMS or StateEL);
  CloseDialogEdit.Enabled := (StateMS or StateEL);
  CloseDialogUpDown.Enabled := (StateMS or StateEL);
  HTMLLayoutLabel.Enabled := State;
  HTMLLayoutHELP.Enabled := State;
  HTMLLayoutMemo.Enabled := State;
  SupportURLLabel.Enabled := StateEL;
  Foreground_Label.Enabled := StateEL;
  ShowCustomHelpBtn.Enabled := (StateMS or StateEL);
  ShowDetailsButton.Enabled := (StateMS or StateEL);
  ShowInDetailedMode.Enabled := StateEL;
  SendErrorChecked.Enabled := StateEL;
  ShowAttachScreenshot.Enabled := StateEL;
  ShowCopyToClip.Enabled := StateEL;
  ShowInTopMost.Enabled := (StateMS or StateEL);
  SupportURLEdit.Enabled := StateEL;
  ShowSendErrorReport.Enabled := (StateMS or StateEL);
  AttachScreenshotChecked.Enabled := StateEL;
  ForegroundTabEdt.Enabled := StateEL;
  LookAndFeel.Enabled := StateEL;
end;

procedure TOptionsForm.SubBtnClick(Sender: TObject);
begin
  with OldModule do
  begin
    if (ExceptionsFiltersList.Selected <> nil) and
      (MessageBox(0, EAreYouSure, EAttenction,
      MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2 or MB_TASKMODAL) = ID_Yes) then
      ExceptionsFiltersList.Items.Delete(ExceptionsFiltersList.Selected.Index);
  end;
end;

procedure TOptionsForm.TerminateOperationEdtChange(Sender: TObject);
var
  State: Boolean;
begin
  State := (TerminateOperationEdt.ItemIndex > 0) and (Activate.Checked);
  Option_Label.Enabled := State;
  Terminate_Edit.Enabled := State;
  TerminateUpDown.Enabled := State;
  Error_Label.Enabled := State;
end;

procedure TOptionsForm.TextMemoChange(Sender: TObject);
var
  Item: TListItem;
begin
  Item := MessagesList.Selected;
  if (Item <> nil) and (Item.Data <> Pointer(-1)) and
    (TextMemo.Lines.Text <> Item.SubItems[0]) and
    (CollectionsList.Items.IndexOf(CollectionNone) = -1) then
  begin
    CollectionsList.Items.Add(CollectionNone);
    CollectionsList.ItemIndex := CollectionsList.Items.IndexOf(CollectionNone);
  end;
end;

procedure TOptionsForm.TextMemoExit(Sender: TObject);
begin
  ChangeMessageText(nil);
end;

procedure TOptionsForm.VariableBtnClick(Sender: TObject);
var
  VariableForm: TVariableForm;
begin
  VariableForm := TVariableForm.Create(nil);
  with VariableForm do
  begin
    if ShowModal = mrOK then
    begin

    end;
    Free;
  end;
end;

procedure TOptionsForm.FormShow(Sender: TObject);
var
  Opened: Integer;
begin
  Opened := ECore.ReadInteger((BaseDir + EurekaIni), 'Design', 'Opened', 0) + 1;
  ECore.WriteInteger((BaseDir + EurekaIni), 'Design', 'Opened', Opened);

  if (Assigned(ModuleOptions.CurrentModule)) then
  begin
    Default.Checked := False;
    Default.Enabled := True;
    SaveModuleToForm(ModuleOptions.CurrentModule);
    if (not IsAcceptableProject(ModuleOptions.CurrentModule.Name)) then
    begin
      Activate.Checked := False;
      Activate.Enabled := False;
      Default.Enabled := False;
      OKBtn.Enabled := False;
    end
    else
    begin
      Activate.Enabled := True;
      Default.Enabled := True;
      OKBtn.Enabled := True;
    end;
  end
  else
  begin
    Default.Checked := True;
    Default.Enabled := False;
    OldModule.LoadOptionsFromDefaultOptionFile;
    SaveModuleToForm(OldModule);
  end;
  MessagesList.Selected := MessagesList.Items[1]; // To bypass a Delphi 2005 BUG!!!
  MessagesList.Items[1].Selected := True;
  ChangeMessageText(MessagesList.Selected);

{$IFNDEF PROFESSIONAL}
  SendTab.TabVisible := False;
  Big.ActivePage := LogFileTab;
{$ENDIF}

  CollectionsListClick(nil);
  ActivateClick(nil);
end;

procedure TOptionsForm.OKBtnClick(Sender: TObject);

  function IsValidEmail(const Addr: string): Boolean;
  begin
    Result := ((Pos('@', Addr) > 0) and (Pos('.', Addr) > 0));
  end;

  procedure Error(const Msg: string);
  begin
    MessageBox(0, PChar(Msg), EErrorCaption,
      MB_OK or MB_ICONERROR or MB_TASKMODAL);
    Big.ActivePage := Tab1;
    Abort;
  end;

  procedure CheckValidURL(const URL: string);
  var
    Protocol, UserID, Password, Host, Path: string;
    Port: Word;
  begin
    if not (ElaborateURL(URL, Protocol, UserID, Password, Host, Path, Port) and
      (Host <> '')) then Error(EInsertURL);

    if (Port <> 0) or (UserID <> '') or (Password <> '') then Error(EURLNoPrm);

    Protocol := UpperCase(Protocol);
    if ((WebSendModeEdit.ItemIndex = 1) and ((Protocol <> '') and (Protocol <> 'HTTP'))) or
      ((WebSendModeEdit.ItemIndex = 2) and ((Protocol <> '') and (Protocol <> 'HTTPS'))) or
      ((WebSendModeEdit.ItemIndex = 3) and ((Protocol <> '') and (Protocol <> 'FTP'))) then Error(EURLProtConf);

    if (Trim(WebPortEdit.Text) = '') then Error(EURLInvalidPort);
  end;

  procedure CheckWebTrakerData;
  begin
    if (WebSendModeEdit.ItemIndex < 4) then Exit;

    if (TrakerUserEdt.Text = '') then Error(Format(EInvalidTrakerField, ['UserID']));
    if (TrakerPasswordEdt.Text = '') then Error(Format(EInvalidTrakerField, ['Project Name']));

    // FogBugz
    if (WebSendModeEdit.ItemIndex = 5) then
    begin
//      if (TrakerAssignToEdt.Text = '') then Error(Format(EInvalidTrakerField, ['Assign To']));
      if (TrakerCategoryEdt.Text = '') then Error(Format(EInvalidTrakerField, ['Area']));
    end
    else
      // Mantis
      if (WebSendModeEdit.ItemIndex = 6) then
      begin
        if (TrakerCategoryEdt.Text = '') then Error(Format(EInvalidTrakerField, ['Category']));
      end;
  end;

begin
  ChangeMessageText(nil);

  LastActiveOption := OldActiveOption;

  if (GetEmailSendType <> esmNoSend) and
    (not IsValidEmail(Addresses.Text)) then Error(EInsertEmail);

  if (GetWebSendType <> wsmNoSend) then CheckValidURL(WebURLEdit.Text);

  CheckWebTrakerData;

  if (GetEmailSendType in [esmSMTPClient, esmSMTPServer]) and
    (not IsValidEmail(SMTPFromEdt.Text)) then Error(EInsertSMTPFrom);

  if (GetEmailSendType = esmSMTPClient) then
  begin
    if (Trim(SMTPHostEdt.Text) = '') then Error(EInsertSMTPHost)
    else
      if (SMTPPortEdt.Text = '') then Error(EInsertSMTPPort);
  end;

  if (Assigned(ModuleOptions.CurrentModule)) then
  begin
    LoadModuleFromForm(ModuleOptions.CurrentModule);
    IDEManager.MarkModified(ModuleOptions.CurrentModule.Name);
    if (Default.Checked) then ModuleOptions.CurrentModule.SaveOptionsToDefaultOptionFile;
  end
  else
    if Default.Checked then
    begin
      LoadModuleFromForm(OldModule);
      OldModule.SaveOptionsToDefaultOptionFile;
    end;
  ModalResult := mrOk;
end;

procedure TOptionsForm.Option1Click(Sender: TObject);
var
  OptionNo, OptionName, ActiveTab: string;
  Panel: TPanel;
  Shape: TShape;
  Tab: TTabSheet;
  n: Integer;
begin
  if (Sender is TPanel) then
  begin
    Panel := TPanel(Sender);
    OldActiveOption := Panel.Name;
    OptionNo := QuickStringReplace(Panel.Name, 'Option', '');
    for n := 1 to 8 do
    begin
      if (IntToStr(n) <> OptionNo) then
      begin
        Panel := TPanel(FindComponent('Option' + IntToStr(n)));
        if (Panel <> nil) then
        begin
          Panel.Color := UnselectedOptionColor;
          Panel.Font.Color := UnselectedFontColor;
          Panel.Font.Style := (Panel.Font.Style - [fsUnderline]);
        end;
        Shape := TShape(FindComponent('Border' + IntToStr(n)));
        if (Shape <> nil) then Shape.Pen.Color := ShapeUnselectedColor;
      end;
    end;
    Panel := TPanel(Sender);
    OptionName := Panel.Name;
    Shape := TShape(FindComponent('Border' + OptionNo));
    if (Shape <> nil) then Shape.Pen.Color := ShapeSelectedColor;
    Panel.Color := SelectedOptionColor;
    Panel.Font.Color := SelectedFontColor;
    Panel.Font.Style := (Panel.Font.Style + [fsUnderline]);
    ActiveTab := QuickStringReplace(OptionName, 'Option', 'Tab');
    if (ActiveTab <> OptionName) then
    begin
      Tab := TTabSheet(FindComponent(ActiveTab));
      if (Tab <> nil) then Big.ActivePage := Tab;
    end;
  end;
end;

procedure TOptionsForm.Option1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (Sender <> nil) and (Sender is TPanel) then LastOption := TPanel(Sender);
end;

procedure TOptionsForm.FlatTimerTimer(Sender: TObject);
var
  n: Integer;
  pt: TPoint;
  rc: TRect;
  Painted: Boolean;
begin
  GetCursorPos(Pt);
  Windows.ScreenToClient(LeaksLimits.Parent.Handle, Pt);
  rc := Rect(LeaksLimits.Left, LeaksLimits.Top,
    LeaksLimits.Left + LeaksLimits.Width, LeaksLimits.Top + LeaksLimits.Height);
  if (PtInRect(rc, Pt)) then
  begin
    LeaksLimits.Font.Color := clMaroon;
  end
  else
  begin
    LeaksLimits.Font.Color := clBlue;
  end;
  for n := 1 to 8 do
  begin
    Panel := TPanel(FindComponent('Option' + IntToStr(n)));
    if (Panel <> nil) then
    begin
      if (Panel.Color <> SelectedOptionColor) then
      begin
        Painted := False;
        if (LastOption = Panel) then
        begin
          GetCursorPos(Pt);
          Windows.ScreenToClient(LastOption.Parent.Handle, Pt);
          rc := Rect(LastOption.Left, LastOption.Top,
            LastOption.Left + LastOption.Width, LastOption.Top + LastOption.Height);
          if (PtInRect(rc, Pt)) then
          begin
            Panel.Color := FlatOptionColor;
            Painted := True;
          end;
        end;
        if (not Painted) then Panel.Color := UnselectedOptionColor;
      end;
    end;
  end;
end;

type
  TMyPanel=class(TPanel);

procedure TOptionsForm.FormCreate(Sender: TObject);
var
  i: Integer;
  o: TShowOption;
  LastStr, CurrentStr, TypeStr, SubTypeStr: string;
begin
  LastOption := Option1;
  LastItem := nil;

{$IFDEF Delphi4Up}
  if (CompareText(LastActiveProject, GetCurrentProjectName) <> 0) then
    LastActiveOption := 'Option1';
  LastActiveProject := GetCurrentProjectName;
{$ENDIF}

  Option1Click(FindComponent(LastActiveOption));
  ClientHeight := (Panel4.Top + Panel4.Height + 8 + ButtonsPanel.Height);

  if (Assigned(ModuleOptions.CurrentModule)) then
  begin
    Caption := EFormCaption + ' (' +
      ExtractFileName(ModuleOptions.CurrentModule.Name) + ')';
  end
  else Caption := EFormCaption + ' (缺省)';

{$IFDEF EUREKALOG_DEMO}
 // OrderBtn.Visible := True;
{$ENDIF}
{  LookAndFeel.Caption := ELookAndFeel;
  LogSaveLogFile.Caption := ESaveLogFile;
  Activate.Caption := EActivateLog;
  Default.Caption := EDefault;
  OKBtn.Caption := EOK;
  CancelBtn.Caption := ECancel;
  OpenDialog.Filter := EExtFileStr;
  SaveDialog.Filter := EExtFileStr;
  HelpBtn.Caption := EHelp;
  OrderBtn.Caption := EOrder;
  AddBtn.Caption := EAdd;
  SubBtn.Caption := ESub;
  Tab6.Caption := EExceptionsTab;
  Tab1.Caption := ESendTab;
  Tab3.Caption := ELogFileTab;
  Tab5.Caption := EMessagesTab;
  Label_Terminate.Caption := ETerminateLabel;
  Activate_Handle.Caption := EActivateHandle;
  AddressesLabel.Caption := EEmailAddresses;
  SubjectLabel.Caption := EEmailObject;
  MessageLabel.Caption := EEmailMessage;
  AppendTheLog.Caption := EAppendLogCaption;
  SendScreen.Caption := ESendScreenshotCaption;
  AppendReproduceText.Caption := EAppendReproduceCaption;
  SendTheEntireLog.Caption := ESendEntireLog;
  ShowTheSendDialog.Caption := ESMTPShowDialog;
  SMTPFromLabel.Caption := ESMTPFromCaption;
  SMTPHostLabel.Caption := ESMTPHostCaption;
  SMTPPortLabel.Caption := ESMTPPortCaption;
  SMTPUserIDLabel.Caption := ESMTPUserIDCaption;
  SMTPPasswordLabel.Caption := ESMTPPasswordCaption;
  LogNumbers.Caption := ELogNumberLog;
  DoNotSaveDuplicate.Caption := ELogNotDuplicate;
  OutputPathLabel.Caption := ELabel_OutputPath;
  Tab4.Caption := EExceptionDialog;
  FreezeActivateChkBox.Caption := EFreezeActivate;  }
  AutoTerminationOperation.Items[0] := ENone;
  AutoTerminationOperation.Items[1] := ETerminate;
  AutoTerminationOperation.Items[2] := ERestart;
  AutoTerminationOperation.ItemIndex := 1;

 { SendInthread.Caption := ESendInThread;
  SendHTML.Caption := ESendHTML;
  SaveCompressedFilesCopy.Caption := ESaveFiles;
  WebPortLabel.Caption := EWebPort;
  WebUserLabel.Caption := EWebUser;
  WebPasswordLabel.Caption := EWebPassword;
  WebURLLabel.Caption := EWebURL;
  AttachedFilesLabel.Caption := EAttachedFiles;
  CopyLogInCaseOfError.Caption := ECopyLogInCaseOfError;
  UseMainModuleOptions.Caption := EUseMainModuleOptions;
  AddDateInFileName.Caption := EAddDateInFileName;
  AddComputerNameInLogFile.Caption := EAddComputerName;
  SaveModulesSection.Caption := ESaveModulesAndProcessesSection;
  SaveCPUSection.Caption := ESaveAssemblerAndCPUSection;
  SendXMLCopy.Caption := ESendXMLCopy;
  DeleteLog.Caption := EDeleteLog;
  CloseDialogLabel1.Caption := ECloseEveryDialog;
  CloseDialogLabel2.Caption := ESeconds;
  SupportURLLabel.Caption := ESupportURL;
  HTMLLayoutLabel.Caption := EHTMLLayout;
  HTMLLayoutHELP.Caption := EHTMLLayoutHELP;
  ShowDetailsButton.Caption := EShowDetailsButton;
  ShowInDetailedMode.Caption := EShowInDetailedMode;
  SendErrorChecked.Caption := ESendEmailChecked;
  AttachScreenshotChecked.Caption := EAttachScreenshotChecked;
  ShowCopyToClip.Caption := EShowCopyToClipboard;
  ShowInTopMost.Caption := EShowInTopMost;
  EncryptPasswordLabel.Caption := EEncryptPassword;
  ShowDLLs.Caption := EShowDlls;
  ShowBPLs.Caption := EShowBPLs;
  ShowBorlandThreads.Caption := EShowBorladThreads;
  ShowWindowsThreads.Caption := EShowWindowsThreads;
  AutoTerminateLabel1.Caption := EAutoTerminateApplicationLabel1;
  AutoTerminateLabel2.Caption := EAutoTerminateApplicationLabel2;
  AutoTerminateLabel3.Caption := EAutoTerminateApplicationLabel3;
  PauseBorlandThreads.Caption := EPauseBorlandThreads;
  DoNotPauseMainThread.Caption := EDoNotPauseMainThread;
  PauseWindowsThreads.Caption := EPauseWindowsthread;   }

  MessagesList.Items.Clear;
  LastStr := '';
  for I := low(EMsgs) to high(EMsgs) do
  begin
    with MessagesList.Items.Add do
    begin
      CurrentStr := EMsgs[I].Msg;
      if (EMsgs[I].No = -1) then
      begin
        Caption := CurrentStr;
        Data := Pointer(-1);
      end
      else
      begin
        Caption := '    ' + CurrentStr;
        SubItems.Add(EVals[TMessageType(EMsgs[I].No)]);
        Data := Pointer(EMsgs[I].No);
      end;
    end;
  end;

{$IFDEF Delphi4Up}
  MessagesList.OnCustomDrawItem := MessagesTextCustomDraw;
{$ENDIF}

  OptionsList.Items.Clear;
  for o := low(TShowOption) to high(TShowOption) do
  begin
    TypeStr := Copy(EShowOptions[o], 1, Pos('|', EShowOptions[o]) - 1);
    SubTypeStr := Copy(EShowOptions[o], Pos('|', EShowOptions[o]) + 1, 255);
    with OptionsList.Items.Add do
    begin
      Caption := TypeStr;
      SubItems.Add(SubTypeStr);
    end;
  end;

  ListAllCollections(BaseDir + 'Texts', CollectionsList.Items);

  OldModule := TModule.Create('');
  AdjustFontLanguage(Self);
end;

procedure TOptionsForm.RewriteLogClick(Sender: TObject);
begin
  LogNumbers.Enabled := LogSaveLogFile.Checked;
  ErrorsNumber.Enabled := LogSaveLogFile.Checked;
  UpDown.Enabled := LogSaveLogFile.Checked;
  OutputPathLabel.Enabled := LogSaveLogFile.Checked;
  OutputPathEdit.Enabled := LogSaveLogFile.Checked;
  OutputBtn.Enabled := LogSaveLogFile.Checked;
end;

procedure TOptionsForm.ErrorsNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key < '0') or (Key > '9')) and (Key <> #8) then Key := #0;
end;

procedure TOptionsForm.ExceptionsFiltersListDblClick(Sender: TObject);
var
  Item: TListItem;
begin
  Item := ExceptionsFiltersList.Selected;
  if (Item <> nil) then
  begin
    MessageForm := TMessageForm.Create(nil);
    with MessageForm do
    begin
      ExceptionClassEdit.Text := Item.Caption;
      HandlerTypeCmb.ItemIndex := HandlerTypeCmb.Items.IndexOf(Item.SubItems[0]);
      ExceptionTypeCmb.ItemIndex := ExceptionTypeCmb.Items.IndexOf(Item.SubItems[1]);
      ExceptionMessageText.Lines.Text := Item.SubItems[2];
      DialogTypeCmb.ItemIndex := DialogTypeCmb.Items.IndexOf(Item.SubItems[3]);
      ActionTypeCmb.ItemIndex := ActionTypeCmb.Items.IndexOf(Item.SubItems[4]);
      if ShowModal = mrOK then
        with OldModule do
        begin
          Item.Caption := ExceptionClassEdit.Text;
          Item.SubItems[0] := HandlerTypeCmb.Text;
          Item.SubItems[1] := ExceptionTypeCmb.Text;
          Item.SubItems[2] := (ExceptionMessageText.Lines.Text);
          Item.SubItems[3] := DialogTypeCmb.Text;
          Item.SubItems[4] := ActionTypeCmb.Text;
        end;
      Free;
    end;
  end;
end;

procedure TOptionsForm.ExceptionsFiltersListDeletion(Sender: TObject;
  Item: TListItem);
begin
  SubBtn.Enabled := (ExceptionsFiltersList.Items.Count > 1);
end;

procedure TOptionsForm.ExceptionsFiltersListInsert(Sender: TObject;
  Item: TListItem);
begin
  SubBtn.Enabled := (ExceptionsFiltersList.Items.Count > 0);
end;

procedure TOptionsForm.SendOptionsClick(Sender: TObject);
var
  State, EmailState, WebState, TrakerState, SMTPState, FogBugz, Mantis: Boolean;
begin
  EmailState := (GetEmailSendType <> esmNoSend) and (Activate.Checked);
  WebState := (GetWebSendType <> wsmNoSend) and (Activate.Checked);
  TrakerState := (WebState) and (WebSendModeEdit.ItemIndex >= 4);
  FogBugz := (TrakerState) and (WebSendModeEdit.ItemIndex = 5);
  Mantis := (TrakerState) and (WebSendModeEdit.ItemIndex = 6);
  State := (EmailState or WebState);

  AddressesLabel.Enabled := EmailState;
  Addresses.Enabled := EmailState;
  SubjectLabel.Enabled := EmailState;
  Obj.Enabled := EmailState;
  MessageLabel.Enabled := EmailState;
  Msg.Enabled := EmailState;
  AppendTheLog.Enabled := EmailState;

  ShowTheSendDialog.Enabled := State;
  ResultMessage.Enabled := State;
  SendInThread.Enabled := State;
  SendScreen.Enabled := State;
  UseActiveWindow.Enabled := (State and SendScreen.Checked);
  SendHTML.Enabled := State;
  AddComputerInFileName.Enabled := State;
  ZipPasswordEdt.Enabled := State;
  ZipLabel.Enabled := State;
  SendTheEntireLog.Enabled := State;
  SendXMLCopy.Enabled := State;
  AddDateInFileName.Enabled := State;
  AttachedFilesLabel.Enabled := State;
  AttachedFilesEdit.Enabled := State;

  WebURLLabel.Enabled := WebState;
  WebURLEdit.Enabled := WebState;
  WebUserLabel.Enabled := WebState;
  WebUserEdit.Enabled := WebState;
  WebPasswordLabel.Enabled := WebState;
  WebPasswordEdit.Enabled := WebState;
  WebPortLabel.Enabled := WebState;
  WebPortEdit.Enabled := WebState;

  ProxyURLLabel.Enabled := WebState;
  ProxyURLEdt.Enabled := WebState;
  ProxyUserLabel.Enabled := WebState;
  ProxyUserEdt.Enabled := WebState;
  ProxyPasswordLabel.Enabled := WebState;
  ProxyPasswordEdt.Enabled := WebState;
  ProxyPortLabel.Enabled := WebState;
  ProxyPortEdt.Enabled := WebState;

  TrakerUserLabel.Enabled := TrakerState;
  TrakerUserEdt.Enabled := TrakerState;
  TrakerPasswordLabel.Enabled := TrakerState;
  TrakerPasswordEdt.Enabled := TrakerState;
  TrakerUserLabel.Enabled := TrakerState;
  TrakerUserEdt.Enabled := TrakerState;
  TrakerProjectLabel.Enabled := TrakerState;
  TrakerProjectEdt.Enabled := TrakerState;
  if (FogBugz) then TrakerCategoryLabel.Caption := 'Area'
  else TrakerCategoryLabel.Caption := '类别'{'Category'};
  TrakerCategoryLabel.Enabled := (FogBugz or Mantis);
  TrakerCategoryEdt.Enabled := (FogBugz or Mantis);
  TrakerAssignToLabel.Enabled := TrakerState;
  TrakerAssignToEdt.Enabled := TrakerState;
  TrakerTrialIDLabel.Enabled := FogBugz;
  TrakerTrialIDEdt.Enabled := FogBugz;

  SMTPState := (GetEmailSendType = esmSMTPClient) and (Activate.Checked);
  SMTPFromLabel.Enabled := (Activate.Checked) and
    (GetEmailSendType in [esmSMTPClient, esmSMTPServer]);
  SMTPHostLabel.Enabled := SMTPState;
  SMTPPortLabel.Enabled := SMTPState;
  SMTPUserIDLabel.Enabled := SMTPState;
  SMTPPasswordLabel.Enabled := SMTPState;
  SMTPFromEdt.Enabled := (Activate.Checked) and
    (GetEmailSendType in [esmSMTPClient, esmSMTPServer]);
  SMTPHostEdt.Enabled := SMTPState;
  SMTPPortEdt.Enabled := SMTPState;
  SMTPUserIDEdt.Enabled := SMTPState;
  SMTPPasswordEdt.Enabled := SMTPState;
  LogSaveLogFileClick(nil);
end;

procedure TOptionsForm.OutputBtnClick(Sender: TObject);
var
  S: string;
begin
{$IFDEF Delphi3Down}
  S := 'Desktop';
  if SelectDirectory(S, [], 0) then
    OutputPathEdit.Text := S;
{$ELSE}
  if SelectDirectory(ESelectOutputPath, 'Desktop', S) then
    OutputPathEdit.Text := S;
{$ENDIF}
end;

procedure TOptionsForm.HelpBtnClick(Sender: TObject);
var
  Topic: string;
begin
  if Big.ActivePage = Tab1 then Topic := 'SendTab'
  else
    if Big.ActivePage = Tab2 then Topic := 'SendTab2'
    else
      if Big.ActivePage = Tab3 then Topic := 'LogFileTab'
      else
        if Big.ActivePage = Tab4 then Topic := 'ExceptionDialogTab'
        else
          if Big.ActivePage = Tab5 then Topic := 'MessagesTab'
          else
            if Big.ActivePage = Tab6 then Topic := 'ExceptionsTab'
              else
                if Big.ActivePage = Tab7 then Topic := 'AdvancedTab'
                else
                  if Big.ActivePage = Tab8 then Topic := 'BuildTab'
                  else Topic := '';
  ShowHelp(Topic);
end;

procedure TOptionsForm.FormDestroy(Sender: TObject);
begin
  OldModule.Free;
  LastItem := nil;
end;

procedure TOptionsForm.LeaksLimitsClick(Sender: TObject);
begin
  ShowHelp('MemoryLeaksLimits');
end;

procedure TOptionsForm.LoadBtnClick(Sender: TObject);
var
  F: string;
begin
  if OpenDialog.Execute then
  begin
    F := OpenDialog.FileName;
    if (pos('.', F) = 0) then
      F := ChangeFileExt(F, '.eof');
    OldModule.LoadOptionsFromFile(F);
    SaveModuleToForm(OldModule); // Save the new module into form
  end;
end;

procedure TOptionsForm.SaveBtnClick(Sender: TObject);
var
  F: string;
begin
  if SaveDialog.Execute then
  begin
    F := SaveDialog.FileName;
    if (pos('.', F) = 0) then
      F := ChangeFileExt(F, '.eof');
    LoadModuleFromForm(OldModule); // Load the new module from form (Refresh)
    OldModule.SaveOptionsToFile(F);
  end;
end;

procedure TOptionsForm.SaveCollectionBtnClick(Sender: TObject);
var
  FileName: string;

  procedure SaveTextsToFile(const FileName: string);
  var
    n: Integer;
  begin
    for n := 0 to (MessagesList.Items.Count - 1) do
    begin
      if (MessagesList.Items[n].Data <> Pointer(-1)) then
      begin
        WriteRawStrings(FileName, EurekaLogSection, 'Count ' +
          GetEnumName(TypeInfo(TMessageType), Integer(MessagesList.Items[n].Data)),
          GetEnumName(TypeInfo(TMessageType), Integer(MessagesList.Items[n].Data)),
          MessagesList.Items[n].SubItems[0]);
      end;
    end;
  end;

begin
  TextMemoExit(nil);
  if (InputQuery('保存的文件名称', '文件名称', FileName)) then
  begin
    FileName := Trim(FileName);
    if (FileName = '') then
    begin
      MessageBox(0, '不能插入一个空的名字!', EAttenction,
        MB_OK or MB_ICONWARNING or MB_TASKMODAL);
      Exit;
    end;

    SaveTextsToFile(BaseDir + 'Texts\' + ChangeFileExt(FileName, '.etf'));
    ListAllCollections(BaseDir + 'Texts', CollectionsList.Items);
    CollectionsList.ItemIndex := CollectionsList.Items.IndexOf(FileName);
    DeleteCollectionBtn.Enabled := True;
  end;
end;

function TOptionsForm.GetEmailSendType: TEmailSendMode;
begin
  Result := TEmailSendMode(EmailSendModeEdit.ItemIndex);
end;

procedure TOptionsForm.SetEmailSendType(Value: TEmailSendMode);
begin
  EmailSendModeEdit.ItemIndex := Integer(Value);
end;

function TOptionsForm.GetWebSendType: TWebSendMode;
begin
  Result := TWebSendMode(WebSendModeEdit.ItemIndex);
end;

procedure TOptionsForm.SetWebSendType(Value: TWebSendMode);
begin
  WebSendModeEdit.ItemIndex := Integer(Value);
end;

type
  TInternalModule = class(TBaseModule);

procedure TOptionsForm.LoadModuleFromForm(Module: TBaseModule);
var
  Opt: TShowOption;
  i: Integer;
  Dn: TFilterDialogType;
  Hn: TFilterHandlerType;
  An: TFilterActionType;
  Tn: TFilterExceptionType;
  Filter: PEurekaExceptionFilter;
  TypeList, DialogList, HandleList, ActionList: TStringList;

  procedure SetEnum(SetPtr: Pointer; Item: DWord; Value: Boolean);
  var
    n, b: Byte;
  begin
    while (Item > 7) do
    begin
      Inc(DWord(SetPtr), 1);
      Dec(Item, 8);
    end;
    b := 1;
    for n := 1 to Byte(Item) do b := (b shl 1);
    if (Value) then PByte(SetPtr)^ := (PByte(SetPtr)^ or b)
    else PByte(SetPtr)^ := (PByte(SetPtr)^ and (255 - b));
  end;

begin
  if (Assigned(ModuleOptions.CurrentModule)) then Module.MakeLine(Activate.Checked);

  Module.Assign(OldModule);
  with Module do
  begin
    EmailMessage := Msg.Lines.Text;
    FreezeActivate := FreezeActivateChkBox.Checked;
    FreezeTimeout := FreezeTimeoutUpDown.Position;
    SMTPFrom := SMTPFromEdt.Text;
    SMTPHost := SMTPHostEdt.Text;
    SMTPPort := StrToIntDef(SMTPPortEdt.Text, 0);
    SMTPUserID := SMTPUserIDEdt.Text;
    SMTPPassword := SMTPPasswordEdt.Text;
    ActivateLog := Activate.Checked;
    SaveLogFile := LogSaveLogFile.Checked;
    ActivateHandle := Activate_Handle.Checked;
    EmailAddresses := Addresses.Text;
    EmailSubject := Obj.Text;
    ProxyURL := ProxyURLEdt.Text;
    ProxyUserID := ProxyUserEdt.Text;
    ProxyPassword := ProxyPasswordEdt.Text;
    ProxyPort := StrToIntDef(ProxyPortEdt.Text, 0);
    TrakerUserID := TrakerUserEdt.Text;
    TrakerPassword := TrakerPasswordEdt.Text;
    TrakerAssignTo := TrakerAssignToEdt.Text;
    TrakerProject := TrakerProjectEdt.Text;
    TrakerCategory := TrakerCategoryEdt.Text;
    TrakerTrialID := TrakerTrialIDEdt.Text;
    ZipPassword := ZipPasswordEdt.Text;
    OutputPath := OutputPathEdit.Text;
    ExceptionDialogType := TExceptionDialogType(DialogTypeCmb.ItemIndex);
    WebSendMode := GetWebSendType;
    WebURL := WebURLEdit.Text;
    WebUserID := WebUserEdit.Text;
    WebPassword := WebPasswordEdit.Text;
    WebPort := StrToIntDef(WebPortEdit.Text, 0);
    SetEnum(@CommonSendOptions, DWord(sndShowSendDialog), ShowTheSendDialog.Checked);
    SetEnum(@CommonSendOptions, DWord(sndShowSuccessFailureMsg), ResultMessage.Checked);
    SetEnum(@CommonSendOptions, DWord(sndSendInSeparatedThread), SendInThread.Checked);
    SetEnum(@CommonSendOptions, DWord(sndSendScreenshot), SendScreen.Checked);
    SetEnum(@CommonSendOptions, DWord(sndUseOnlyActiveWindow), UseActiveWindow.Checked);
    SetEnum(@CommonSendOptions, DWord(sndSendLastHTMLPage), SendHTML.Checked);
    SetEnum(@CommonSendOptions, DWord(sndSendEntireLog), SendTheEntireLog.Checked);
    SetEnum(@CommonSendOptions, DWord(sndSendXMLLogCopy), SendXMLCopy.Checked);
    SetEnum(@CommonSendOptions, DWord(sndAddDateInFileName), AddDateInFileName.Checked);
    SetEnum(@CommonSendOptions, DWord(sndAddComputerNameInFileName), AddComputerInFileName.Checked);
    AttachedFiles := AttachedFilesEdit.Text;

    SetEnum(@LogOptions, DWord(loNoDuplicateErrors), DoNotSaveDuplicate.Checked);
    SetEnum(@LogOptions, DWord(loAppendReproduceText), AppendReproduceText.Checked);
    SetEnum(@LogOptions, DWord(loSaveModulesAndProcessesSections), SaveModulesSection.Checked);
    SetEnum(@LogOptions, DWord(loAddComputernameInLogFileName), AddComputerNameInLogFile.Checked);
    SetEnum(@LogOptions, DWord(loSaveAssemblerAndCPUSections), SaveCPUSection.Checked);
    SetEnum(@LogOptions, DWord(loDeleteLogAtVersionChange), DeleteLog.Checked);

    SetEnum(@ExceptionDialogOptions, DWord(edoUseEurekaLogLookAndFeel), LookAndFeel.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoShowDetailsButton), ShowDetailsButton.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoShowInDetailedMode), ShowInDetailedMode.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoSendErrorReportChecked), SendErrorChecked.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoAttachScreenshotChecked), AttachScreenshotChecked.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoShowCopyToClipOption), ShowCopyToClip.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoShowInTopMostMode), ShowInTopMost.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoShowSendErrorReportOption), ShowSendErrorReport.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoShowAttachScreenshotOption), ShowAttachScreenshot.Checked);
    SetEnum(@ExceptionDialogOptions, DWord(edoShowCustomButton), ShowCustomHelpBtn.Checked);
    AutoCloseDialogSecs := CloseDialogUpDown.Position;
    SupportURL := SupportURLEdit.Text;
    HTMLLayout := HTMLLayoutMemo.Lines.Text;

    SetEnum(@CallStackOptions, DWord(csoShowDLLs), ShowDLLs.Checked);
    SetEnum(@CallStackOptions, DWord(csoShowBPLs), ShowBPLs.Checked);
    SetEnum(@CallStackOptions, DWord(csoShowBorlandThreads), ShowBorlandThreads.Checked);
    SetEnum(@CallStackOptions, DWord(csoShowWindowsThreads), ShowWindowsThreads.Checked);
    SetEnum(@CallStackOptions, DWord(csoDoNotStoreProcNames), DoNotStoreProcNames.Checked);
    EncryptPassword := EncryptPasswordEdit.Text;

    SetEnum(@BehaviourOptions, DWord(boPauseBorlandThreads), PauseBorlandThreads.Checked);
    SetEnum(@BehaviourOptions, DWord(boDoNotPauseMainThread), DoNotPauseMainThread.Checked);
    SetEnum(@BehaviourOptions, DWord(boPauseWindowsThreads), PauseWindowsThreads.Checked);
    SetEnum(@BehaviourOptions, DWord(boSaveCompressedCopyInCaseOfError), SaveCompressedFilesCopy.Checked);
    SetEnum(@BehaviourOptions, DWord(boCopyLogInCaseOfError), CopyLogInCaseOfError.Checked);
    SetEnum(@BehaviourOptions, DWord(boUseMainModuleOptions), UseMainModuleOptions.Checked);
    SetEnum(@BehaviourOptions, DWord(boHandleSafeCallExceptions), HandleSafeCall.Checked);
    SetEnum(@BehaviourOptions, DWord(boCallRTLExceptionEvent), CallRTLExceptionEvent.Checked);
    SetEnum(@BehaviourOptions, DWord(boCatchHandledExceptions), CatchHandledExceptions.Checked);

    SetEnum(@LeaksOptions, DWord(loCatchLeaks), CatchLeaks.Checked);
    SetEnum(@LeaksOptions, DWord(loGroupsSonLeaks), GroupLeaks.Checked);
    SetEnum(@LeaksOptions, DWord(loHideBorlandLeaks), HideBorlandLeaks.Checked);
    SetEnum(@LeaksOptions, DWord(loFreeAllLeaks), FreeLeaks.Checked);
    SetEnum(@LeaksOptions, DWord(loCatchLeaksExceptions), CatchLeaksErrors.Checked);

    AutoCrashOperation := TTerminateBtnOperation(AutoTerminationOperation.ItemIndex);
    AutoCrashNumber := AutoTerminateCrachedUpDown.Position;
    AutoCrashMinutes := AutoTerminateMinutesUpDown.Position;

    SetEnum(@CompiledFileOptions, DWord(cfoReduceFileSize), ReduceFileSize.Checked);
    SetEnum(@CompiledFileOptions, DWord(cfoCheckFileCorruption), CheckFileCorruption.Checked);

    TInternalModule(Module).PreBuildEvent := PreBuildEventEdt.Text;
    TInternalModule(Module).PostSuccessfulBuildEvent := PostSuccessfulBuildEventEdt.Text;
    TInternalModule(Module).PostFailureBuildEvent := PostFailureBuildEventEdt.Text;

    AppendLogs := AppendTheLog.Checked;
    ErrorsNumberToSave := UpDown.Position;
    EmailSendMode := GetEmailSendType;

    TypeList := TStringList.Create;
    for Tn := low(TypeValues) to high(TypeValues) do TypeList.Add(TypeValues[Tn]);
    DialogList := TStringList.Create;
    for Dn := low(DialogValues) to high(DialogValues) do DialogList.Add(DialogValues[Dn]);
    HandleList := TStringList.Create;
    for Hn := low(HandleValues) to high(HandleValues) do HandleList.Add(HandleValues[Hn]);
    ActionList := TStringList.Create;
    for An := low(ActionValues) to high(ActionValues) do ActionList.Add(ActionValues[An]);
    ExceptionsFilters.Clear;
    try
      for i := 0 to (ExceptionsFiltersList.Items.Count - 1) do
      begin
        New(Filter);
        Filter^.Active := ExceptionsFiltersList.Items[i].Checked;
        Filter^.ExceptionClassName := ExceptionsFiltersList.Items[i].Caption;
        Filter^.HandlerType :=
          TFilterHandlerType(HandleList.IndexOf(ExceptionsFiltersList.Items[i].SubItems[0]));
        Filter^.ExceptionType :=
          TFilterExceptionType(TypeList.IndexOf(ExceptionsFiltersList.Items[i].SubItems[1]));
        Filter^.ExceptionMessage := ExceptionsFiltersList.Items[i].SubItems[2];
        Filter^.DialogType :=
          TFilterDialogType(DialogList.IndexOf(ExceptionsFiltersList.Items[i].SubItems[3]));
        Filter^.ActionType :=
          TFilterActionType(ActionList.IndexOf(ExceptionsFiltersList.Items[i].SubItems[4]));
        ExceptionsFilters.Add(Filter);
      end;
    finally
      DialogList.Free;
      HandleList.Free;
      ActionList.Free;
    end;
    ShowOptions := [];
    for Opt := low(TShowOption) to high(TShowOption) do
    begin
{$IFDEF Delphi9Up} // To fix a Delphi 2005 TListView bug.
      if (ListView_GetCheckState(OptionsList.Handle, Integer(Opt)) <> 0) then
{$ELSE}
      if OptionsList.Items.Item[Integer(Opt)].Checked then
{$ENDIF}
        ShowOptions := ShowOptions + [Opt];
    end;
    TerminateBtnOperation :=
      TTerminateBtnOperation(TerminateOperationEdt.ItemIndex);
    ErrorsNumberToShowTerminateBtn := TerminateUpDown.Position;
    ForegroundTab := TForegroundType(ForegroundTabEdt.ItemIndex);

    for i := 0 to (MessagesList.Items.Count - 1) do
    begin
      if (MessagesList.Items[i].Data <> Pointer(-1)) then
        CustomizedTexts[TMessageType(MessagesList.Items[i].Data)] :=
          MessagesList.Items[i].SubItems[0];
    end;
    TextsCollection := CollectionsList.Text;
    if (TextsCollection = CollectionNone) then TextsCollection := '';
  end;
end;

procedure TOptionsForm.SaveModuleToForm(Module: TBaseModule);
var
  Opt: TShowOption;
  n: Integer;
begin
  OldModule.Assign(Module);
  with OldModule do
  begin
    Msg.Lines.Text := EmailMessage;
    Activate.Checked := ActivateLog;
    Activate_Handle.Checked := ActivateHandle;
    Addresses.Text := EmailAddresses;
    LogSaveLogFile.Checked := SaveLogFile;
    Obj.Text := EmailSubject;
    OutputPathEdit.Text := OutputPath;
    AppendTheLog.Checked := AppendLogs;

    SetWebSendType(WebSendMode);
    WebURLEdit.Text := WebURL;
    WebUserEdit.Text := WebUserID;
    WebPasswordEdit.Text := WebPassword;
    WebPortEdit.Text := IntToStr(WebPort);
    SendTheEntireLog.Checked := (sndSendEntireLog in CommonSendOptions);
    SendXMLCopy.Checked := (sndSendXMLLogCopy in CommonSendOptions);
    SendScreen.Checked := (sndSendScreenshot in CommonSendOptions);
    UseActiveWindow.Checked := (sndUseOnlyActiveWindow in CommonSendOptions);
    SendHTML.Checked := (sndSendLastHTMLPage in CommonSendOptions);
    AddDateInFileName.Checked := (sndAddDateInFileName in CommonSendOptions);
    AddComputerInFileName.Checked := (sndAddComputerNameInFileName in CommonSendOptions);
    ShowTheSendDialog.Checked := (sndShowSendDialog in CommonSendOptions);
    ResultMessage.Checked := (sndShowSuccessFailureMsg in CommonSendOptions);
    SendInThread.Checked := (sndSendInSeparatedThread in CommonSendOptions);
    AttachedFilesEdit.Text := AttachedFiles;

    ProxyURLEdt.Text := ProxyURL;
    ProxyUserEdt.Text := ProxyUserID;
    ProxyPasswordEdt.Text := ProxyPassword;
    ProxyPortEdt.Text := IntToStr(ProxyPort);
    TrakerUserEdt.Text := TrakerUserID;
    TrakerPasswordEdt.Text := TrakerPassword;
    TrakerAssignToEdt.Text := TrakerAssignTo;
    TrakerProjectEdt.Text := TrakerProject;
    TrakerCategoryEdt.Text := TrakerCategory;
    TrakerTrialIDEdt.Text := TrakerTrialID;
    ZipPasswordEdt.Text := ZipPassword;

    PreBuildEventEdt.Text := PreBuildEvent;
    PostSuccessfulBuildEventEdt.Text := PostSuccessfulBuildEvent;
    PostFailureBuildEventEdt.Text := PostFailureBuildEvent;

    DoNotSaveDuplicate.Checked := (loNoDuplicateErrors in LogOptions);
    AppendReproduceText.Checked := (loAppendReproduceText in LogOptions);
    AddComputerNameInLogFile.Checked := (loAddComputernameInLogFileName in LogOptions);
    SaveModulesSection.Checked := (loSaveModulesAndProcessesSections in LogOptions);
    SaveCPUSection.Checked := (loSaveAssemblerAndCPUSections in LogOptions);
    DeleteLog.Checked := (loDeleteLogAtVersionChange in LogOptions);

    LookAndFeel.Checked := (edoUseEurekaLogLookAndFeel in ExceptionDialogOptions);
    ShowDetailsButton.Checked := (edoShowDetailsButton in ExceptionDialogOptions);
    ShowInDetailedMode.Checked := (edoShowInDetailedMode in ExceptionDialogOptions);
    ShowSendErrorReport.Checked := (edoShowSendErrorReportOption in ExceptionDialogOptions);
    SendErrorChecked.Checked := (edoSendErrorReportChecked in ExceptionDialogOptions);
    ShowAttachScreenshot.Checked := (edoShowAttachScreenshotOption in ExceptionDialogOptions);
    AttachScreenshotChecked.Checked := (edoAttachScreenshotChecked in ExceptionDialogOptions);
    ShowCopyToClip.Checked := (edoShowCopyToClipOption in ExceptionDialogOptions);
    ShowInTopMost.Checked := (edoShowInTopMostMode in ExceptionDialogOptions);
    ShowCustomHelpBtn.Checked := (edoShowCustomButton in ExceptionDialogOptions);
    CloseDialogUpDown.Position := AutoCloseDialogSecs;
    SupportURLEdit.Text := SupportURL;
    HTMLLayoutMemo.Lines.Text := HTMLLayout;

    ShowDLLs.Checked := (csoShowDLLs in CallStackOptions);
    ShowBPLs.Checked := (csoShowBPLs in CallStackOptions);
    ShowBorlandThreads.Checked := (csoShowBorlandThreads in CallStackOptions);
    ShowWindowsThreads.Checked := (csoShowWindowsThreads in CallStackOptions);
    DoNotStoreProcNames.Checked := (csoDoNotStoreProcNames in CallStackOptions);
    EncryptPasswordEdit.Text := EncryptPassword;

    PauseBorlandThreads.Checked := (boPauseBorlandThreads in BehaviourOptions);
    DoNotPauseMainThread.Checked := (boDoNotPauseMainThread in BehaviourOptions);
    PauseWindowsThreads.Checked := (boPauseWindowsThreads in BehaviourOptions);
    SaveCompressedFilesCopy.Checked := (boSaveCompressedCopyInCaseOfError in BehaviourOptions);
    CopyLogInCaseOfError.Checked := (boCopyLogInCaseOfError in BehaviourOptions);
    UseMainModuleOptions.Checked := (boUseMainModuleOptions in BehaviourOptions);
    HandleSafeCall.Checked := (boHandleSafeCallExceptions in BehaviourOptions);
    CallRTLExceptionEvent.Checked := (boCallRTLExceptionEvent in BehaviourOptions);
    CatchHandledExceptions.Checked := (boCatchHandledExceptions in BehaviourOptions);

    CatchLeaks.Checked := (loCatchLeaks in LeaksOptions);
    GroupLeaks.Checked := (loGroupsSonLeaks in LeaksOptions);
    HideBorlandLeaks.Checked := (loHideBorlandLeaks in LeaksOptions);
    FreeLeaks.Checked := (loFreeAllLeaks in LeaksOptions);
    CatchLeaksErrors.Checked := (loCatchLeaksExceptions in LeaksOptions);

    ReduceFileSize.Checked := (cfoReduceFileSize in CompiledFileOptions);
    CheckFileCorruption.Checked := (cfoCheckFileCorruption in CompiledFileOptions);

    DialogTypeCmb.ItemIndex := Integer(ExceptionDialogType);

    AutoTerminationOperation.ItemIndex := Integer(AutoCrashOperation);
    AutoTerminateCrachedUpDown.Position := AutoCrashNumber;
    AutoTerminateMinutesUpDown.Position := AutoCrashMinutes;

    FreezeActivateChkBox.Checked := FreezeActivate;
    FreezeTimeoutUpDown.Position := FreezeTimeout;
    SMTPFromEdt.Text := SMTPFrom;
    SMTPHostEdt.Text := SMTPHost;
    SMTPPortEdt.Text := IntToStr(SMTPPort);
    SMTPUserIDEdt.Text := SMTPUserID;
    SMTPPasswordEdt.Text := SMTPPassword;
    ForegroundTabEdt.ItemIndex := Integer(ForegroundTab);
    TerminateOperationEdt.ItemIndex := Integer(OldModule.TerminateBtnOperation);
    TerminateUpDown.Position := ErrorsNumberToShowTerminateBtn;
    UpDown.Position := ErrorsNumberToSave;
    SetEmailSendType(EmailSendMode);

    ExceptionsFiltersList.Items.Clear;
    for n := 0 to (ExceptionsFilters.Count - 1) do
    begin
      with ExceptionsFiltersList.Items.Add do
      begin
        Checked := ExceptionsFilters[n]^.Active;
        Caption := ExceptionsFilters[n]^.ExceptionClassName;
        SubItems.Add(HandleValues[ExceptionsFilters[n]^.HandlerType]);
        SubItems.Add(TypeValues[ExceptionsFilters[n]^.ExceptionType]);
        SubItems.Add(ExceptionsFilters[n]^.ExceptionMessage);
        SubItems.Add(DialogValues[ExceptionsFilters[n]^.DialogType]);
        SubItems.Add(ActionValues[ExceptionsFilters[n]^.ActionType]);
      end;
    end;

    for Opt := low(TShowOption) to high(TShowOption) do
    begin
{$IFDEF Delphi9Up} // To fix a Delphi 2005 TListView bug.
      ListView_SetCheckState(OptionsList.Handle, Integer(Opt), (Opt in ShowOptions));
{$ELSE}
      OptionsList.Items.Item[Integer(Opt)].Checked := (Opt in ShowOptions);
{$ENDIF}
    end;

    for n := 0 to (MessagesList.Items.Count - 1) do
    begin
      if (MessagesList.Items[n].Data <> Pointer(-1)) then
        MessagesList.Items[n].SubItems[0] := CustomizedTexts[TMessageType(MessagesList.Items[n].Data)];
    end;
    CollectionsList.ItemIndex := CollectionsList.Items.IndexOf(TextsCollection);
    if (CollectionsList.ItemIndex = -1) then
    begin
      CollectionsList.Items.Add(CollectionNone);
      CollectionsList.ItemIndex := CollectionsList.Items.IndexOf(CollectionNone);
      DeleteCollectionBtn.Enabled := False;
    end;
  end;
  SendOptionsClick(nil);
  RewriteLogClick(nil);
  LogSaveLogFileClick(nil);
end;

procedure TOptionsForm.HelpBtnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then HelpBtnClick(nil);
end;

procedure TOptionsForm.LogSaveLogFileClick(Sender: TObject);
var
  State, SendLogState: Boolean;
begin
  State := (LogSaveLogFile.Checked) and (Activate.Checked);
  LogNumbers.Enabled := State;
  ErrorsNumber.Enabled := State;
  UpDown.Enabled := State;
  OutputPathLabel.Enabled := State;
  OutputPathEdit.Enabled := State;
  OutputBtn.Enabled := State;
  OptionsList.Enabled := State;

  SendLogState := (Activate.Checked) and
    ((LogSaveLogFile.Checked) or (EmailSendModeEdit.ItemIndex <> 0) or (WebSendModeEdit.ItemIndex <> 0));
  DoNotSaveDuplicate.Enabled := SendLogState;
  AppendReproduceText.Enabled := SendLogState;
  AddComputerNameInLogFile.Enabled := SendLogState;
  SaveModulesSection.Enabled := SendLogState;
  SaveCPUSection.Enabled := SendLogState;
  DeleteLog.Enabled := SendLogState;
end;

procedure TOptionsForm.CatchLeaksClick(Sender: TObject);
var
  State: Boolean;
begin
  State := (Activate.Checked) and (CatchLeaks.Checked);
  CatchLeaks.Enabled := Activate.Checked;
  GroupLeaks.Enabled := State;
  HideBorlandLeaks.Enabled := State;
  FreeLeaks.Enabled := State;
  CatchLeaksErrors.Enabled := State;
end;

procedure TOptionsForm.ChangeMessageText(Item: TListItem);
begin
  if (LastItem <> nil) and (LastItem <> Item) then
    LastItem.SubItems[0] := TextMemo.Lines.Text;
  if (Item <> nil)  then
  begin
    TextMemo.Enabled := (Item.Data <> Pointer(-1));
    TextLabel.Enabled := (Item.Data <> Pointer(-1));
    if (Item.Data <> Pointer(-1)) then
    begin
      TextMemo.Lines.Text := Item.SubItems[0];
      LastItem := Item;
    end
    else
    begin
      TextMemo.Lines.Clear;
      LastItem := nil;
    end;
  end;
end;

procedure TOptionsForm.MessagesListClick(Sender: TObject);
begin
  ChangeMessageText(MessagesList.Selected);
end;

procedure TOptionsForm.MessagesListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then MessagesListClick(Sender);
end;

{$IFDEF Delphi4Up}
procedure TOptionsForm.MessagesTextCustomDraw(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  rc: TRect;
begin
  if (Item.Data = Pointer(-1)) then
  begin
    rc := Item.DisplayRect(drLabel);
    if (Item.Selected) then
    begin
      Sender.Canvas.Brush.Color := Clhighlight;
      Sender.Canvas.Font.Color  := clHighlightText;
    end;
    Sender.Canvas.FillRect(rc);
    Sender.Canvas.Font.Style := (Sender.Canvas.Font.Style + [fsBold, fsUnderline]);
    Sender.Canvas.TextRect(rc, rc.Left, rc.Top, Item.Caption);
    Sender.Canvas.Font.Style := (Sender.Canvas.Font.Style - [fsBold, fsUnderline]);
    DefaultDraw := False;
  end;
end;
{$ENDIF}

{ TModule }

{$IFDEF Delphi6Up}

function TModule.GetRealFileName(FileName: string; Compiled: Boolean): string;
var
  P: IOTAProject;
  Prefix, Suffix, Version: string;
begin
  Result := FileName;
  P := GetCurrentProject;
  if (not Assigned(P)) then Exit;

  if (CurrentPersonality = TDelphiWin32Personality) then
  begin
    Prefix := P.ProjectOptions.Values['SOPrefix'];
    Suffix := P.ProjectOptions.Values['SOSuffix'];
    Version := P.ProjectOptions.Values['SOVersion'];
  end
  else
  begin
{$IFDEF Delphi10Down}
    Prefix := P.ProjectOptions.Values['SOPrefix'];
    Suffix := P.ProjectOptions.Values['SOSuffix'];
    Version := P.ProjectOptions.Values['SOVersion'];
{$ELSE}
    // TODO: C++Builer 2007 FieldTest 11-May-2007 BUG WorkAround.
    Prefix := '';
    Suffix := '';
    Version := '';
{$ENDIF}
  end;
  if (Compiled) then
  begin
    FileName := ExtractFilePath(FileName) + Prefix +
      ChangeFileExt(ExtractFileName(FileName), '') + Suffix +
      ExtractFileExt(FileName);
    if (Version <> '') then FileName := FileName + '.' + Version;
  end
  else
  begin
    FileName := ChangeFileExt(FileName, '.map');
  end;
  Result := FileName;
end;
{$ELSE}

function TModule.GetRealFileName(FileName: string; Compiled: Boolean): string;
begin
  if (not Compiled) then Result := ChangeFileExt(FileName, '.map')
  else Result := FileName;
end;
{$ENDIF}

procedure TModule.SetDebugOptions(Active: Boolean);
{$IFDEF Delphi4Up}
const
  EurekaLogDefine = 'EUREKALOG';
  EurekaLogDefine_V5 = 'EUREKALOG_VER5';
  EurekaLogDefine_V6 = 'EUREKALOG_VER6';
var
  P: IOTAProject;

  procedure SetDefine(Project: IOTAProject; const Define: string; Add: Boolean);
  var
    i: integer;
    DefinesStr, DefinesOptionName: string;
  begin
    if (CurrentPersonality.GetPersonality = ptDelphiWin32) then
      DefinesOptionName := 'Defines'
    else
{$IFDEF Delphi10Up}
  {$IFDEF Delphi11Up}
      DefinesOptionName := 'BCC_Defines';
  {$ELSE}
      DefinesOptionName := 'bcc32.D.value';
  {$ENDIF}
{$ELSE}
      DefinesOptionName := 'Defines';
{$ENDIF}

// Internal Debug ONLY...
// ----------------------
{  List := TStringList.Create;
  try
    for i := 0 to Length(P.ProjectOptions.GetOptionNames) - 1 do
    begin
      List.add(P.ProjectOptions.GetOptionNames[i].Name + ' = ' +
        VarToStr(Project.ProjectOptions.Values[P.ProjectOptions.GetOptionNames[i].Name]));
    end;
    List.SaveToFile('C:\Options.txt');
  finally
    List.Free;
  end;}

    DefinesStr := Project.ProjectOptions.Values[DefinesOptionName];
    i := Pos(Define, DefinesStr);
    if (i > 0) and (not Add) then
    begin
      Delete(DefinesStr, i, length(Define));
      if (DefinesStr <> '') and (DefinesStr[i] = ';') then Delete(DefinesStr, i, 1);
      Project.ProjectOptions.Values[DefinesOptionName] := DefinesStr;
    end
    else
      if (i = 0) and (Add) then
      begin
        if (DefinesStr <> '') and (DefinesStr[length(DefinesStr)] <> ';') then
          DefinesStr := (DefinesStr + ';');
        DefinesStr := (DefinesStr + Define);
        Project.ProjectOptions.Values[DefinesOptionName] := DefinesStr;
      end;
  end;

{$ENDIF}
begin
{$IFDEF Delphi4Up}
  P := GetCurrentProject;
  if (not Assigned(P)) then Exit;

  if Active then
  begin
    if (CurrentPersonality.GetPersonality = ptDelphiWin32) then
    begin
      if P.ProjectOptions.Values['MapFile'] <> 3 then
        P.ProjectOptions.Values['MapFile'] := 3;
      if P.ProjectOptions.Values['UnitDebugInfo'] <> 1 then
        P.ProjectOptions.Values['UnitDebugInfo'] := 1;
{$IFNDEF CBuilder}
      if (loCatchLeaks in LeaksOptions) then
      begin
        if P.ProjectOptions.Values['StackFrames'] <> 1 then
          P.ProjectOptions.Values['StackFrames'] := 1;
      end;
{$ENDIF}
    end
    else
    begin
{$IFDEF Delphi10Up}
  {$IFDEF Delphi11Up}
      if P.ProjectOptions.Values['ILINK_MapFileType'] <> 'Segments' then
        P.ProjectOptions.Values['ILINK_MapFileType'] := 'Segments';
      if P.ProjectOptions.Values['BCC_SourceDebuggingOn'] <> True then
        P.ProjectOptions.Values['BCC_SourceDebuggingOn'] := True;
      if P.ProjectOptions.Values['BCC_DebugLineNumbers'] <> True then
        P.ProjectOptions.Values['BCC_DebugLineNumbers'] := True;
  {$ELSE}
      // Set MapFile Details On...
      if P.ProjectOptions.Values['bcc32.y.enabled'] <> True then
        P.ProjectOptions.Values['bcc32.y.enabled'] := True;
      if P.ProjectOptions.Values['ilink32.v.enabled'] <> True then
        P.ProjectOptions.Values['ilink32.v.enabled'] := True;
{      if P.ProjectOptions.Values['ilink32.s.enabled'] <> True then
        P.ProjectOptions.Values['ilink32.s.enabled'] := True;
      if P.ProjectOptions.Values['ilink32.x.enabled'] <> False then
        P.ProjectOptions.Values['ilink32.x.enabled'] := False;
      if P.ProjectOptions.Values['ilink32.m.enabled'] <> False then
        P.ProjectOptions.Values['ilink32.m.enabled'] := False;
      if P.ProjectOptions.Values['ilink32.map_segments.enabled'] <> False then
        P.ProjectOptions.Values['ilink32.map_segments.enabled'] := False;}
      if P.ProjectOptions.Values['ilink32.s.enabled'] <> False then
        P.ProjectOptions.Values['ilink32.s.enabled'] := False;
      if P.ProjectOptions.Values['ilink32.x.enabled'] <> False then
        P.ProjectOptions.Values['ilink32.x.enabled'] := False;
      if P.ProjectOptions.Values['ilink32.m.enabled'] <> False then
        P.ProjectOptions.Values['ilink32.m.enabled'] := False;
      if P.ProjectOptions.Values['ilink32.map_segments.enabled'] <> True then
        P.ProjectOptions.Values['ilink32.map_segments.enabled'] := True;
  {$ENDIF}
{$ELSE}
{      if P.ProjectOptions.Values['MapFile'] <> 3 then
        P.ProjectOptions.Values['MapFile'] := 3;}
      if P.ProjectOptions.Values['MapFile'] <> 1 then
        P.ProjectOptions.Values['MapFile'] := 1;
      if P.ProjectOptions.Values['UnitDebugInfo'] <> 1 then
        P.ProjectOptions.Values['UnitDebugInfo'] := 1;
      if P.ProjectOptions.Values['DebugInfo'] <> True then
        P.ProjectOptions.Values['DebugInfo'] := True;
      if P.ProjectOptions.Values['CppDebugInfo'] <> True then
        P.ProjectOptions.Values['CppDebugInfo'] := True;
{$ENDIF}
    end;
  end;
  if (ModuleType = mtPackage) then Exit;

  SetDefine(P, EurekaLogDefine, Active);
  SetDefine(P, EurekaLogDefine_V5, False);
  SetDefine(P, EurekaLogDefine_V6, Active);
{$ENDIF}
end;

class function TModule.GetText(const FileName: string): string;
begin
  Result := IDEManager.GetText(FileName);
end;

procedure TModule.InsertText(const FileName: string; StartPos: Integer; Text: PChar);
begin
  IDEManager.InsertText(FileName, StartPos, Text);
end;

procedure TModule.DeleteText(const FileName: string; StartPos, EndPos: Integer);
begin
  IDEManager.DeleteText(FileName, StartPos, EndPos);
end;

procedure TModule.GetModuleInfo(var MType: TModuleType; var ext: string);
{$IFDEF Delphi4Up}
var
  P: IOTAProject;
begin
  if (CurrentPersonality.GetPersonality = ptCppBuilderWin32) then
  begin
    P := GetCurrentProject;
    MType := mtUnknown;
    ext := '';

    if (not Assigned(P)) then Exit;

    ext := '.' + LowerCase(P.ProjectOptions.Values['AppFileExt']);

{$IFDEF Delphi10Up}
  {$IFDEF Delphi11Up}
    if (Pos('Application', P.ProjectOptions.Values['ProjectType']) > 0) then MType := mtProgram
    else
      if (Pos('Package', P.ProjectOptions.Values['ProjectType']) > 0) then MType := mtPackage
      else
        if (Pos('Library', P.ProjectOptions.Values['ProjectType']) > 0) then MType := mtLibrary
        else MType := mtUnknown;
  {$ELSE}
    if (P.ProjectOptions.Values['ilink32.Gl.enabled'] = False) and
      (P.ProjectOptions.Values['ilink32.Gi.enabled'] = False) then MType := mtProgram
    else
      if (P.ProjectOptions.Values['ilink32.Gl.enabled'] = True) and
        (P.ProjectOptions.Values['ilink32.Gi.enabled'] = True) then MType := mtPackage
      else
        if (P.ProjectOptions.Values['ilink32.Gl.enabled'] = False) and
          (P.ProjectOptions.Values['ilink32.Gi.enabled'] = True) then MType := mtLibrary
        else MType := mtUnknown;
  {$ENDIF}
{$ELSE}
    if P.ProjectOptions.Values['GenDll'] then MType := mtLibrary
    else
      if P.ProjectOptions.Values['GenPackage'] then MType := mtPackage
      else
        if (not P.ProjectOptions.Values['GenStaticLibrary']) then MType := mtProgram
        else MType := mtUnknown;
{$ENDIF}
  end
  else inherited;
{$ELSE}
begin
  inherited;
{$ENDIF}
end;

procedure TModule.ErrorMessage(const Msg: string);
begin
  MessageBox(0, PChar(Msg), EErrorCaption, MB_OK or MB_ICONERROR or MB_TASKMODAL);
  Abort;
end;

procedure TModule.MakeLine;
{$IFDEF Delphi5Up}
var
  P: IOTAProject;

  // Returns the ExceptionLog.pas full-path.
  function EurekaUnitFullPath: string;
  var
    Buff: array[0..MAX_PATH - 1] of Char;
  begin
    GetModuleFileName(HInstance, Buff, SizeOf(Buff));
    Result := ExtractFilePath(Buff) + 'ExceptionLog.pas';
  end;

  // Into CBuilder tell if ExceptionLog.pas unit exists.
  function EurekaUnitExists: boolean;
  var
    i: integer;
    P: IOTAProject;
  begin
    Result := False;
    P := GetCurrentProject;
    if (not Assigned(P)) then Exit;

    for i := 0 to P.GetModuleCount - 1 do
    begin
      if LowerCase(ChangeFileExt(ExtractFileName(P.GetModule(i).Name), '')) =
        LowerCase(ChangeFileExt(ExtractFileName(EurekaUnitFullPath), '')) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

  // Remove the EurekaUnit simulating the "Enter" key-press on the request dialog-box.
  procedure RemoveEurekaUnit;
  var
    P: IOTAProject;
  begin
    P := GetCurrentProject;
    if (not Assigned(P)) then Exit;

    TKeyThread.Create;
    P.RemoveFile(EurekaUnitFullPath);
  end;

begin
  if (CurrentPersonality.GetPersonality = ptCppBuilderWin32) then
  begin
    // Set the Map-File and UnitDebugInfo options.
    SetDebugOptions(Active);

    if (ModuleType in [mtUnknown, mtPackage]) then Exit;

    if (Active) and (not EurekaUnitExists) then
    begin
      P := GetCurrentProject;
      if (Assigned(P)) then P.AddFile(EurekaUnitFullPath, False)
    end
    else
      if (not Active) and (EurekaUnitExists) then RemoveEurekaUnit;
  end
  else inherited;
{$ELSE}
begin
  inherited;
{$ENDIF}
end;

function TModule.BuildMapFile: Boolean;
var
  WaitForm: TWaitForm;
  hWnd: THandle;

  function ShowCompilerProgress: Boolean;
  const
  {$IFNDEF Delphi3}
    KeyVal = 'Show Compiler Progress';
  {$ELSE}
    KeyVal = 'ShowCompilerProgress';
  {$ENDIF}
  var
    S: string;
  begin
    S := UpperCase(ReadKey(HKEY_CURRENT_USER, RADRegistryKey + '\Compiling', KeyVal));
    Result := ((S <> '0') and (S <> 'FALSE'));
  end;

begin
  if (ShowCompilerProgress) then
  begin
    hWnd := GetForegroundWindow;
    Application.ProcessMessages;
    WaitForm := TWaitForm.Create(nil);
    WaitForm.Show;
    Application.ProcessMessages;
    try
      Result := inherited BuildMapFile;
    finally
      WaitForm.Close;
      WaitForm.Free;
      Application.ProcessMessages;
    end;
    SetForegroundWindow(hWnd);
  end
  else Result := inherited BuildMapFile;
end;

function TModule.GetOutputDir: string;
var
{$IFDEF Delphi4Up}
  Project: IOTAProject;
  St: string;
{$ELSE}
  Opt: TIniFile;
{$ENDIF}
begin
{$IFDEF Delphi4Up}
  Project := GetCurrentProject;
  if (not Assigned(Project)) then Exit;

{$IFDEF Delphi9Up}
  Result := ExpandFileName(AdjustDir(ExtractFilePath(Project.ProjectOptions.TargetName), False));
  Exit;
{$ENDIF}

  if (CurrentPersonality.GetPersonality = ptDelphiWin32) then
  begin
    if ModuleType = mtPackage then St := 'PkgDllDir'
    else St := 'OutputDir';
  end
  else St := 'OutputDir';

  Result := ExpandFileName(AdjustDir(Project.ProjectOptions.Values[St], False));

// -----------------------------------------------------------------------------
// Decomment only for internal tests...
// -----------------------------------------------------------------------------
{  for n := 0 to Length(Project.ProjectOptions.GetOptionNames) - 1 do
  begin
    St := Project.ProjectOptions.GetOptionNames[n].Name;
    if (VarToStr(Project.ProjectOptions.Values[St]) = *SEARCHED VALUE*) then
      MessageBox(0, PChar(St), '', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
  end;}
// -----------------------------------------------------------------------------

{$ELSE}
  Opt := TIniFile.Create(OptionFile);
  Result := Opt.ReadString('Directories', 'OutputDir', '');
  Opt.Free;
  Result := ExpandFileName(AdjustDir(Result, False));
{$ENDIF}
end;

procedure TModule.GetUnitDirs(List: TStrings);
var
  Source: string;
{$IFDEF Delphi4Up}
  Project: IOTAProject;
{$ELSE}
  Opt: TIniFile;
{$ENDIF}
begin
{$IFDEF Delphi4Up}
  Project := GetCurrentProject;
  if (not Assigned(Project)) then Exit;

  Source := Project.ProjectOptions.Values['UNITDIR'];
{$ELSE}
  Opt := TIniFile.Create(OptionFile);
  Source := Opt.ReadString('Directories', 'SearchPath', '');
  Opt.Free;
{$ENDIF}
  IDEManager.FromPathToList(Source, List);
end;

function GetCurrentModuleName: string;

{$IFDEF Delphi4Up}
  function GetActiveProjectFileName: string;
  var
    Project: IOTAProject;
  begin
    Result := '';
    Project := GetCurrentProject;
    if Assigned(Project) then Result := Project.FileName;
  end;
{$ELSE}
  function GetActiveProjectFileName: string;
  begin
    Result := ToolServices.GetCurrentFile;
    if (not CurrentPersonality.IsOptionEqual(ExtractFileExt(Result), otPackageFileExt, '')) then
      Result := ToolServices.GetProjectName
    else Result := '';
  end;
{$ENDIF}

begin
  Result := GetActiveProjectFileName;
end;

procedure TOptionsForm.FreezeActivateChkBoxClick(Sender: TObject);
var
  State: Boolean;
begin
  State := (Activate.Checked) and (FreezeActivateChkBox.Checked);
  FreezeTimeoutEdit.Enabled := State;
  FreezeTimeOutUpDown.Enabled := State;
  FreezeTimeOutLabel.Enabled := State;
end;

procedure TOptionsForm.ActivateClick(Sender: TObject);
begin
  Shadow.Visible := (not Activate.Checked);
  FullEnaled(MenuPanel, Activate.Checked);
  FullEnaled(Big, Activate.Checked);
  ActivateAutoTerminationClick(nil);
  PauseBorlandThreadsClick(nil);
  TerminateOperationEdtChange(nil);
  AutoTerminationOperationChange(nil);
  FreezeActivateChkBoxClick(nil);
  SendOptionsClick(nil);
  Activate_HandleClick(nil);
  DialogTypeCmbChange(nil);
  LoadBtn.Enabled := Activate.Checked;
  SaveBtn.Enabled := Activate.Checked;
  VariableBtn.Enabled := Activate.Checked;
  DeleteCollectionBtn.Enabled := (CollectionsList.Text <> CollectionNone);
  FullEnaled(MemoryLeaksPanel, CurrentPersonality.GetPersonality = ptDelphiWin32);
  if CurrentPersonality.GetPersonality = ptDelphiWin32 then CatchLeaksClick(nil);
end;

procedure TOptionsForm.Activate_HandleClick(Sender: TObject);
var
  State: Boolean;
begin
  State := (activate.Checked) and (Activate_Handle.Checked);
  ExceptionsFiltersList.Enabled := State;
  AddBtn.Enabled := State;
  SubBtn.Enabled := (State) and (ExceptionsFiltersList.Items.Count > 0);
end;

procedure TOptionsForm.ActivateAutoTerminationClick(Sender: TObject);
var
  State: Boolean;
begin
  State := Activate.Checked;
  AutoTerminationOperation.Enabled := State;
  AutoTerminateLabel1.Enabled := State;
  AutoTerminateCrachesEdit.Enabled := State;
  AutoTerminateCrachedUpDown.Enabled := State;
  AutoTerminateLabel2.Enabled := State;
  AutoTerminateMinutesEdit.Enabled := State;
  AutoTerminateMinutesUpDown.Enabled := State;
  AutoTerminateLabel3.Enabled := State;
end;

procedure TOptionsForm.PauseBorlandThreadsClick(Sender: TObject);
var
  State: Boolean;
begin
  State := ((Activate.Checked) and (PauseBorlandThreads.Checked));
  DoNotPauseMainThread.Enabled := State;
end;

procedure TOptionsForm.PostFailBtnClick(Sender: TObject);
begin
  if OpenBuildDialog.Execute then
    PostFailureBuildEventEdt.Text := OpenBuildDialog.FileName;
end;

procedure TOptionsForm.PostSuccBtnClick(Sender: TObject);
begin
  if OpenBuildDialog.Execute then
    PostSuccessfulBuildEventEdt.Text := OpenBuildDialog.FileName;
end;

procedure TOptionsForm.PreBuildBtnClick(Sender: TObject);
begin
  if OpenBuildDialog.Execute then
    PreBuildEventEdt.Text := OpenBuildDialog.FileName;
end;

procedure TOptionsForm.WebOptClick(Sender: TObject);
begin
  if (WebSendModeEdit.ItemIndex = 0) then WebPortEdit.Text := ''
  else
    if (WebSendModeEdit.ItemIndex = 1) then WebPortEdit.Text := '80'
    else
      if (WebSendModeEdit.ItemIndex = 2) then WebPortEdit.Text := '443'
      else
        if (WebSendModeEdit.ItemIndex = 3) then WebPortEdit.Text := '21'
        else WebPortEdit.Text := '80';
  SendOptionsClick(nil);
end;

procedure TOptionsForm.SendScreenClick(Sender: TObject);
begin
  SendOptionsClick(nil);
end;

function InternalIsAcceptableProject(const FileName: string): Boolean;
const
  DLLResWizard = '// Do not edit. This file is machine generated by the Resource DLL Wizard.';
var
  St: TStringList;
{$IFDEF Delphi9Up}
  Project: IOTAProject;
{$ENDIF}
begin
  Result := (not IsEurekaLogPackage(FileName));
  if (not Result) then Exit;

  St := TStringList.Create;
  try
    St.Text := IDEManager.GetText(FileName);
    Result := (St.Count = 0) or (St[0] <> DLLResWizard);
  finally
    St.Free;
  end;
{$IFDEF Delphi9Up}
  if (not Result) then Exit;

  Result := True;
  Project := GetCurrentProject;
  if (Assigned(Project)) then
    Result := (Project.Personality = sDelphiPersonality) or
      (Project.Personality = sCBuilderPersonality) or (Project.FileName <> FileName);
{$ENDIF}
end;

function InternalGetCurrentPersonality: TPersonalityClass;
{$IFDEF Delphi9Up}
var
  Project: IOTAProject;
begin
  Result := TDelphiWin32Personality; // Default personality;

  Project := GetCurrentProject;
  if (Assigned(Project)) then
  begin
    if (Project.Personality = sDelphiPersonality) then Result := TDelphiWin32Personality
    else
      if (Project.Personality = sCBuilderPersonality) then Result := TCppBuilderWin32Personality;
  end;
{$ELSE}
begin
  {$IFDEF CBuilder}
    Result := TCppBuilderWin32Personality;
  {$ELSE}
    Result := TDelphiWin32Personality;
  {$ENDIF}
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure Init;
begin
  GetCurrentModuleNameProc := GetCurrentModuleName;
  IsAcceptableProject := InternalIsAcceptableProject;
  CurrentPersonality := InternalGetCurrentPersonality;
end;

procedure Done;
begin
end;

//------------------------------------------------------------------------------

procedure TOptionsForm.Panel49Resize(Sender: TObject);
begin
{$IFDEF Delphi4Down}
  FullEnaled(BuildPanel, False);
{$ENDIF}
end;

procedure TOptionsForm.CheckFileCorruptionClick(Sender: TObject);
begin
  if (CheckFileCorruption.Checked) then
    MessageBox(0,
      '使用此选项与可执行文件压缩/保护 文件一起检测!',
      EInformation, MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
end;

initialization
  SafeExec(Init, 'EOption.Init');

finalization
  SafeExec(Done, 'EOption.Done');

end.
