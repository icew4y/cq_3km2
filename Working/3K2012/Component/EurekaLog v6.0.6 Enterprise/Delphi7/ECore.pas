{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{              Core Unit - ECore                 }
{                                                }
{  Copyright (c) 2001 - 2005 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ECore;

{$I Exceptions.inc}

interface

uses Windows, Classes, SysUtils, ETypes;

{$I VersionStrings.inc}

const
  VCL_Const = 'Forms.TApplication.HandleException';
  VCL_Const2 = 'Forms.TApplication.ShowException';
  CLX_Const = 'QForms.TApplication.HandleException';
  CLX_Const2 = 'QForms.TApplication.ShowException';
{$IFDEF Delphi5Down}
  ISAPI_Const = 'ISAPIApp.HandleServerException';
  CGI_Const = 'CGIApp.HandleServerException';
{$ELSE}
  ISAPI_Const = 'ISAPIApp.TISAPIApplication.ISAPIHandleException';
  CGI_Const = 'CGIApp.TCGIApplication.CGIHandleException';
{$ENDIF}
  IWebSrv_Const = 'IWServerControllerBase.TIWServerControllerBase.Create';
  IWebApp_Const = 'IWApplication.TIWApplication.ShowMessage';
  IWebRes_Const = 'InHTTPWebBrokerBridge.TInHTTPAppResponse.SendResponse';
  NTService_Const = 'SvcMgr.TService.LogMessage';
  IndyThread_Const = 'IdThread.TIdThread.DoException';

  ClassesInit_Const = 'Classes.Classes';
  ClassesFInit_Const = 'Classes.Finalization';
  VariantsFInit_Const = 'Variants.Finalization';
  SysUtilsInit_Const = 'SysUtils.SysUtils';
  SysUtilsFInit_Const = 'SysUtils.Finalization';
  SystemFInit_Const = 'System.Finalization';
  ELeaksFInit_Const = 'ELeaks.Finalization';
  ExceptionLogFInit_Const = 'ExceptionLog.Finalization';
  FastMM4FInit_Const = 'FastMM4.Finalization';

  VCL1_ID = 0;
  VCL2_ID = 1;
  CLX1_ID = 2;
  CLX2_ID = 3;
  ISAPI_ID = 4;
  CGI_ID = 5;
  IWebSrv_ID = 6;
  IWebApp_ID = 7;
  IWebRes_ID = 8;
  NTService_ID = 9;
  IndyThread_ID = 10;

  ClassesInit_ID = 11;
  ClassesFInit_ID = 12;
  VariantsFInit_ID = 13;
  SysUtilsInit_ID = 14;
  SysUtilsFInit_ID = 15;
  SystemFInit_ID = 16;
  ELeaksFInit_ID = 17;
  ExceptionLogFInit_ID = 18;
  FastMM4FInit_ID = 19;

  SymbolsCount = 20;

type
  EIgnoreException = class(Exception);

  TProc = procedure;

  TCharSet = set of Char;

  // WARNING !!! Max 256 elements (see the TEurekaModuleOptions.SaveToStream method).
  TForegroundType =
    (ftGeneral, ftCallStack, ftModules, ftProcesses, ftAssembler,  ftCPU);

  TLoadType = (ltLoadModuleOptions, ltLoadDefaultOptions);

  TShowOptions = set of TShowOption;

  TCustomizedTexts = array[TMessageType] of string;

  TLogOption = (loNoDuplicateErrors, loAppendReproduceText,
    loDeleteLogAtVersionChange, loAddComputerNameInLogFileName,
    loSaveModulesAndProcessesSections, loSaveAssemblerAndCPUSections);

  TLogOptions = set of TLogOption;

  TCommonSendOption = (sndShowSendDialog, sndShowSuccessFailureMsg, sndSendEntireLog,
    sndSendXMLLogCopy, sndSendScreenshot, sndUseOnlyActiveWindow, sndSendLastHTMLPage,
    sndSendInSeparatedThread, sndAddDateInFileName, sndAddComputerNameInFileName);

  TCommonSendOptions = set of TCommonSendOption;

  TExceptionDialogType = (edtNone, edtMessageBox, edtMSClassic, edtEurekaLog);

  TExceptionDialogOption = (edoSendErrorReportChecked, edoAttachScreenshotChecked,
    edoShowCopyToClipOption, edoShowDetailsButton, edoShowInDetailedMode,
    edoShowInTopMostMode, edoUseEurekaLogLookAndFeel, edoShowSendErrorReportOption,
    edoShowAttachScreenshotOption, edoShowCustomButton);

  TExceptionDialogOptions = set of TExceptionDialogOption;

  TCallStackOption = (csoShowDLLs, csoShowBPLs, csoShowBorlandThreads,
    csoShowWindowsThreads, csoDoNotStoreProcNames);

  TCallStackOptions = set of TCallStackOption;

  TBehaviourOption = (boPauseBorlandThreads, boDoNotPauseMainThread,
    boPauseWindowsThreads, boUseMainModuleOptions, boCopyLogInCaseOfError,
    boSaveCompressedCopyInCaseOfError, boHandleSafeCallExceptions,
    boCallRTLExceptionEvent, boCatchHandledExceptions);

  TBehaviourOptions = set of TBehaviourOption;

  TLeaksOption = (loCatchLeaks, loGroupsSonLeaks, loHideBorlandLeaks,
    loFreeAllLeaks, loCatchLeaksExceptions);

  TLeaksOptions = set of TLeaksOption;

  TCompiledFileOption = (cfoReduceFileSize, cfoCheckFileCorruption);

  TCompiledFileOptions = set of TCompiledFileOption;

  // WARNING !!! Max 256 elements (see the TEurekaModuleOptions.SaveToStream method).
  TEmailSendMode = (esmNoSend, esmEmailClient, esmSMTPClient, esmSMTPServer);
  TWebSendMode = (wsmNoSend, wsmHTTP, wsmHTTPS, wsmFTP,
    wsmBugZilla, wsmFogBugz, wsmMantis);

  TModuleType = (mtUnknown, mtProgram, mtPackage, mtLibrary);

  TTerminateBtnOperation = (tbNone, tbTerminate, tbRestart);

  TFilterDialogType = (fdtNone, fdtUnchanged, fdtMessageBox, fdtMSClassic, fdtEurekaLog);

  TFilterHandlerType = (fhtNone, fhtRTL, fhtEurekaLog);

  TFilterActionType = (fatNone, fatTerminate, fatRestart);

  TFilterExceptionType = (fetAll, fetHandled, fetUnhandled);

  TEurekaExceptionFilter = packed record
    Active: Boolean;
    ExceptionClassName, ExceptionMessage: string;
    ExceptionType: TFilterExceptionType;
    DialogType: TFilterDialogType;
    HandlerType: TFilterHandlerType;
    ActionType: TFilterActionType;
  end;
  PEurekaExceptionFilter = ^TEurekaExceptionFilter;

  TEurekaModuleOptions = class;

  TEurekaExceptionsFilters = class(TList)
  private
    function GetItem(Index: Integer): PEurekaExceptionFilter;
  protected
    FOwner: TEurekaModuleOptions;
  public
    constructor Create(const Owner: TEurekaModuleOptions);
    destructor Destroy; override;
    function Add(Item: Pointer): Integer;
    procedure Insert(Index: Integer; Item: Pointer);
    procedure Assign(const Source: TEurekaExceptionsFilters);
    procedure Delete(Index: Integer);
    procedure Clear;
{$IFDEF Delphi4Up} override;
{$ENDIF}
    property Items[Index: Integer]: PEurekaExceptionFilter read GetItem; default;
  end;

  TEurekaModuleOptions = class(TObject)
    function GetCustomizedTexts(Index: TMessageType): string;
    procedure SetCustomizedTexts(Index: TMessageType; Value: string);
  private
    FSaveSharedData: Boolean;
    procedure SetExceptionDialogType(const Value: TExceptionDialogType);
    procedure SetExceptionsFilters(const Value: TEurekaExceptionsFilters);
    procedure SetErrorsNumberToSave(const Value: Integer);
    procedure SetModuleName(const Value: string);
    procedure SetActivateHandle(const Value: boolean);
    procedure SetActivateLog(const Value: boolean);
    procedure SetAppendLogs(const Value: boolean);
    procedure SetEMailAddresses(const Value: string);
    procedure SetEMailMessage(const Value: string);
    procedure SetEMailSendMode(const Value: TEmailSendMode);
    procedure SetEMailSubject(const Value: string);
    procedure SetErrorsNumberToShowTerminateBtn(const Value: integer);
    procedure SetForegroundTab(const Value: TForegroundType);
    procedure SetFreezeTimeout(const Value: integer);
    procedure SetLogOptions(const Value: TLogOptions);
    procedure SetOutputPath(const Value: string);
    procedure SetSaveLogFile(const Value: boolean);
    procedure SetShowOptions(const Value: TShowOptions);
    procedure SetSMTPFrom(const Value: string);
    procedure SetSMTPHost(const Value: string);
    procedure SetSMTPPassword(const Value: string);
    procedure SetSMTPPort(const Value: Word);
    procedure SetSMTPUserID(const Value: string);
    procedure SetTerminateBtnOperation(const Value: TTerminateBtnOperation);
    procedure SaveToSharedData;
    procedure SetWebSendMode(const Value: TWebSendMode);
    procedure SetWebURL(const Value: string);
    procedure SetWebPassword(const Value: string);
    procedure SetWebPort(const Value: Integer);
    procedure SetWebUserID(const Value: string);
    procedure SetCommonSendOptions(const Value: TCommonSendOptions);
    procedure SetAttachedFiles(const Value: string);
    procedure SetExceptionDialogOptions(const Value: TExceptionDialogOptions);
    procedure SetAutoCloseDialogSecs(const Value: Integer);
    procedure SetAutoCrashMinutes(const Value: Integer);
    procedure SetAutoCrashNumber(const Value: Integer);
    procedure SetAutoCrashOperation(const Value: TTerminateBtnOperation);
    procedure SetHTMLLayout(const Value: string);
    procedure SetSupportURL(const Value: string);
    procedure SetBehaviourOptions(const Value: TBehaviourOptions);
    procedure SetCallStackOptions(const Value: TCallStackOptions);
    procedure SetCompiledFileOptions(const Value: TCompiledFileOptions);
    procedure SetPostFailureBuildEvent(const Value: string);
    procedure SetPostSuccessfulBuildEvent(const Value: string);
    procedure SetPreBuildEvent(const Value: string);
    procedure SetProxyPassword(const Value: string);
    procedure SetProxyPort(const Value: Word);
    procedure SetProxyURL(const Value: string);
    procedure SetProxyUserID(const Value: string);
    procedure SetTrakerAssignTo(const Value: string);
    procedure SetTrakerCategory(const Value: string);
    procedure SetTrakerPassword(const Value: string);
    procedure SetTrakerProject(const Value: string);
    procedure SetTrakerTrialID(const Value: string);
    procedure SetTrakerUserID(const Value: string);
    procedure SetZipPassword(const Value: string);
    procedure SetTextsCollection(const Value: string);
    function GetCustomizedExpandedTexts(Index: TMessageType): string;
  protected
    FSharedData: Integer;
    FSMTPFrom, FSMTPHost, FSMTPUserID, FSMTPPassword: string;
    FSMTPPort: Word;
    // 6.0 start...
    FProxyURL, FProxyUserID, FProxyPassword: string;
    FProxyPort: Word;
    FTrakerUserID, FTrakerPassword, FTrakerAssignTo, FTrakerProject,
      FTrakerCategory, FTrakerTrialID: string;
    FZipPassword: string;
    FPreBuildEvent, FPostSuccessfulBuildEvent, FPostFailureBuildEvent: string;
    FCompiledFileOptions: TCompiledFileOptions;
    // 6.0 end!
    FTerminateBtnOperation: TTerminateBtnOperation;
    FFreezeActivate: boolean;
    FFreezeTimeout: integer;
    FModuleName: string;
    FShowOptions: TShowOptions;
    FExceptionDialogType: TExceptionDialogType;
    FExceptionsFilters: TEurekaExceptionsFilters;
    FCustomizedTexts: TCustomizedTexts;
    FTextsCollection: string;
    FActivateLog, FActivateHandle, FAppendLogs, FSaveLogFile: boolean;
    FLogOptions: TLogOptions;
    FCommonSendOptions: TCommonSendOptions;
    FForegroundTab: TForegroundType;
    FErrorsNumberToSave, FErrorsNumberToShowTerminateBtn: Integer;
    FOutputPath: string;
    FEMailAddresses, FEMailSubject, FEMailMessage: string;
    FEMailSendMode: TEmailSendMode;
    FWebSendMode: TWebSendMode;
    FAttachedFiles: string;
    FExceptionDialogOptions: TExceptionDialogOptions;
    FAutoCloseDialogSecs: Integer;
    FSupportURL: string;
    FHTMLLayout: string;
    FAutoCrashOperation: TTerminateBtnOperation;
    FAutoCrashNumber: Integer;
    FAutoCrashMinutes: Integer;
    FCallStackOptions: TCallStackOptions;
    FBehaviourOptions: TBehaviourOptions;
    FLeaksOptions: TLeaksOptions;
    FWebURL: string;
    FWebPort: Integer;
    FWebPassword: string;
    FWebUserID: string;
    FActive: Boolean;
    procedure StoreSharedData; virtual;
    procedure SetActive(const Value: Boolean); virtual;
    procedure SetFreezeActivate(const Value: Boolean); virtual;
    procedure DisableSharedDataWrite;
    procedure EnableSharedDataWrite;

    property PreBuildEvent: string read FPreBuildEvent write SetPreBuildEvent;
    property PostSuccessfulBuildEvent: string read FPostSuccessfulBuildEvent
      write SetPostSuccessfulBuildEvent;
    property PostFailureBuildEvent: string read FPostFailureBuildEvent
      write SetPostFailureBuildEvent;
  public
    // Procedures...
    constructor Create(ModuleName: string; SaveSharedData: Boolean);
    destructor Destroy; override;
    procedure Assign(Source: TEurekaModuleOptions); virtual;
    procedure SetToDefaultOptions; virtual;
    procedure SaveToStream(Stream: TStream); virtual;
    procedure SaveToFile(const Filename: string); virtual;
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure LoadFromFile(const FileName: string); virtual;
    function OutputFile(FileName: string): string;
    function OutputLogFile(BaseFile: string): string;
    procedure SaveCustomizedTextsToFile(const FileName: string);
    procedure LoadCustomizedTextsFromFile(const FileName: string);
    // Properties...
    property ModuleName: string read FModuleName write SetModuleName;
    property SMTPFrom: string read FSMTPFrom write SetSMTPFrom;
    property SMTPHost: string read FSMTPHost write SetSMTPHost;
    property SMTPPort: Word read FSMTPPort write SetSMTPPort;
    property SMTPUserID: string read FSMTPUserID write SetSMTPUserID;
    property SMTPPassword: string read FSMTPPassword write SetSMTPPassword;
    property FreezeActivate: Boolean read FFreezeActivate write
      SetFreezeActivate;
    property FreezeTimeout: integer read FFreezeTimeout write SetFreezeTimeout;
    property ExceptionsFilters: TEurekaExceptionsFilters read FExceptionsFilters
      write SetExceptionsFilters;
    property CustomizedTexts[Index: TMessageType]: string read GetCustomizedTexts
      write SetCustomizedTexts;
    property TextsCollection: string read FTextsCollection write SetTextsCollection;
    property ActivateLog: boolean read FActivateLog write SetActivateLog;
    property SaveLogFile: boolean read FSaveLogFile write SetSaveLogFile;
    property ActivateHandle: boolean read FActivateHandle write SetActivateHandle;
    property ForegroundTab: TForegroundType read FForegroundTab write
      SetForegroundTab;
    property AppendLogs: boolean read FAppendLogs write SetAppendLogs;
    property TerminateBtnOperation: TTerminateBtnOperation
      read FTerminateBtnOperation write SetTerminateBtnOperation;
    property LogOptions: TLogOptions read FLogOptions write SetLogOptions;
    property ShowOptions: TShowOptions read FShowOptions write SetShowOptions;
    property ErrorsNumberToSave: Integer read FErrorsNumberToSave write
      SetErrorsNumberToSave;
    property ErrorsNumberToShowTerminateBtn: integer read
      FErrorsNumberToShowTerminateBtn
      write SetErrorsNumberToShowTerminateBtn;
    property OutputPath: string read FOutputPath write SetOutputPath;
    property EMailAddresses: string read FEMailAddresses write SetEMailAddresses;
    property EMailSubject: string read FEMailSubject write SetEMailSubject;
    property EMailMessage: string read FEMailMessage write SetEMailMessage;
    property EMailSendMode: TEmailSendMode read FEMailSendMode write SetEMailSendMode;
    property WebSendMode: TWebSendMode read FWebSendMode write
      SetWebSendMode;
    property WebURL: string read FWebURL write SetWebURL;
    property WebUserID: string read FWebUserID write SetWebUserID;
    property WebPassword: string read FWebPassword write SetWebPassword;
    property WebPort: Integer read FWebPort write SetWebPort;
    property CommonSendOptions: TCommonSendOptions read FCommonSendOptions
      write SetCommonSendOptions;
    property AttachedFiles: string read FAttachedFiles write SetAttachedFiles;
    property ExceptionDialogType: TExceptionDialogType
      read FExceptionDialogType write SetExceptionDialogType;
    property ExceptionDialogOptions: TExceptionDialogOptions
      read FExceptionDialogOptions write SetExceptionDialogOptions;
    property AutoCloseDialogSecs: Integer read FAutoCloseDialogSecs
      write SetAutoCloseDialogSecs;
    property SupportURL: string read FSupportURL write SetSupportURL;
    property HTMLLayout: string read FHTMLLayout write SetHTMLLayout;
    property AutoCrashOperation: TTerminateBtnOperation read FAutoCrashOperation
      write SetAutoCrashOperation;
    property AutoCrashNumber: Integer read FAutoCrashNumber
      write SetAutoCrashNumber;
    property AutoCrashMinutes: Integer read FAutoCrashMinutes
      write SetAutoCrashMinutes;
    property CallStackOptions: TCallStackOptions read FCallStackOptions
      write SetCallStackOptions;
    property BehaviourOptions: TBehaviourOptions read FBehaviourOptions
      write SetBehaviourOptions;
    // 6.0 start...
    property LeaksOptions: TLeaksOptions read FLeaksOptions;
    property ProxyURL: string read FProxyURL write SetProxyURL;
    property ProxyUserID: string read FProxyUserID write SetProxyUserID;
    property ProxyPassword: string read FProxyPassword write SetProxyPassword;
    property ProxyPort: Word read FProxyPort write SetProxyPort;
    property TrakerUserID: string read FTrakerUserID write SetTrakerUserID;
    property TrakerPassword: string read FTrakerPassword write SetTrakerPassword;
    property TrakerAssignTo: string read FTrakerAssignTo write SetTrakerAssignTo;
    property TrakerProject: string read FTrakerProject write SetTrakerProject;
    property TrakerCategory: string read FTrakerCategory write SetTrakerCategory;
    property TrakerTrialID: string read FTrakerTrialID write SetTrakerTrialID;
    property ZipPassword: string read FZipPassword write SetZipPassword;
    property CompiledFileOptions: TCompiledFileOptions read FCompiledFileOptions
      write SetCompiledFileOptions;

    property CustomizedExpandedTexts[Index: TMessageType]: string read GetCustomizedExpandedTexts;

    // 6.0 end!
    property Active: boolean read FActive write SetActive;
  end;

var
  LastEurekaVersion: Word;
  CriticalError: procedure (const Section: string) = nil;

function IntoIDE: Boolean;
function ReadKey(Root: HKey; Key, Str: string): string;
function RADRegistryKey: string;
function RADDir: string;
function GetGMT: Integer;
function GetGMTDateTime(DateTime: TDateTime): TDateTime;
function GetEurekaLogLabel: string;
function QuickStringReplace(const S, OldPattern, NewPattern: string): string;
function PosEx(const SubStr, S: string; Idx: Integer): Integer;
procedure ExtractStringsEx(Separators: TCharSet; Content: string; Strings: TStrings);
function GetModifiedDate(sFileName: string): TDateTime;
function GetLongNameFromShort(Path: string): string;
function IsValidBlockAddr(Address, Size: DWord): Boolean;
function ConvertAddress(Addr: DWord): DWord;
procedure SafeExec(Proc: TProc; Section: string);
function IsWritableFile(const FileName: string): Boolean;
function IsReadableFile(const FileName: string): Boolean;
function GetWorkingFile(var FileName: string; ProjectDir, ReadOnly: Boolean): Boolean;
function SupportsEx(const Instance: IUnknown; const Intf: TGUID; out Inst): Boolean;
function OneString(const s: string): string;

function ReadString(FileName: string; const Section, Ident, Default: string): string;
function ReadInteger(FileName: string; const Section, Ident: string; Default: Integer): Integer;
function ReadBool(FileName: string; const Section, Ident: string; Default: Boolean): Boolean;
procedure WriteString(FileName: string; const Section, Ident, Value: string);
procedure WriteInteger(FileName: string; const Section, Ident: string; Value: Integer);
procedure WriteBool(FileName: string; const Section, Ident: string; Value: Boolean);

procedure ReadRawStrings(const Cnf: string; Section, CountName, Prefix, Default: string;
  var Value: string);
procedure WriteRawStrings(Cnf: string; Section, CountName, Prefix: string; Value: string);
function ExpandEnvVar(const Value: string): string;

implementation

uses EConsts, TypInfo {$IFDEF DUNITPROJECT} {$IFDEF Delphi9Down} ,MemCheck {$ENDIF} {$ENDIF};

var
  InternalIntoIDE: Boolean;

//------------------------------------------------------------------------------

function ExpandEnvVar(const Value: string): string;
var
  Len, Idx: Integer;
  Buff: string;
begin
  Result := Value;
  SetLength(Buff, 1);
  Len := ExpandEnvironmentStrings(PChar(Value), PChar(Buff), 0);
  if (Len <> 0) then
  begin
    SetLength(Buff, Len);
    Len := ExpandEnvironmentStrings(PChar(Value), PChar(Buff), Len);
    if (Len <> 0) then
    begin
      SetString(Result, PChar(Buff), (Len - 1));
      Idx := Pos(#0, Result);
      if (Idx > 0) then Result := Copy(Result, 1, Idx - 1);
    end;
  end;
end;

function GetUserPath: string;

  function EnvironmentVariable(const Variable: string): string;
  var
    Res: array[0..1023] of Char;
  begin
    Res := #0;
    GetEnvironmentVariable(PChar(Variable), Res, SizeOf(Res));
    Result := Res;
  end;

  function GetProfileFolder: string;
  var
    SHGetFolderPath: function (hwnd: HWND; csidl: Integer; hToken: THandle;
      dwFlags: DWORD; pszPath: PChar): HResult; stdcall;
    Lib: THandle;
    Buffer: array[0..MAX_PATH] of Char;
  begin
    Result := '';

    Lib := LoadLibrary('shfolder.dll');
    if (Lib <> 0) then
    try
      @SHGetFolderPath := GetProcAddress(Lib, 'SHGetFolderPathA');
      if (Assigned(SHGetFolderPath)) then
      begin
        if (SHGetFolderPath(0, $0028 {CSIDL_PROFILE}, 0, 0, Buffer) = S_OK) then
          Result := Buffer;
      end;
    finally
      FreeLibrary(Lib);
    end;
  end;

begin
  Result := GetProfileFolder;
  if (Result = '') then Result := EnvironmentVariable('UserProfile');
  if (Result = '') then Result := '\'; // On Win9x, %UserProfile% is not defined
end;

function WindowsDir: string;
var
  Buff: array[0..255] of Char;
  I: DWord;
begin
  I := SizeOf(Buff);
  GetWindowsDirectory(Buff, I);
  Result := Buff;
end;

function IniDir: string;
begin
  if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) then Result := WindowsDir
  else Result := (GetUserPath + '\EurekaLog');
end;

function ReadString(FileName: string; const Section, Ident, Default: string): string;
var
  Buffer: array[0..2047] of Char;
begin
  Result := Default;
  if (ExtractFilePath(FileName) = '') then FileName := (IniDir + '\' + FileName);
  if (not GetWorkingFile(FileName, False, False)) then Exit;

  SetString(Result, Buffer, GetPrivateProfileString(PChar(Section),
    PChar(Ident), PChar(Default), Buffer, SizeOf(Buffer), PChar(FileName)));
end;

function ReadInteger(FileName: string; const Section, Ident: string; Default: Integer): Integer;
begin
  Result := StrToIntDef(ReadString(FileName, Section, Ident, IntToStr(Default)), Default);
end;

function ReadBool(FileName: string; const Section, Ident: string; Default: Boolean): Boolean;
begin
  Result := (ReadInteger(FileName, Section, Ident, Integer(Default)) = 1);
end;

procedure WriteString(FileName: string; const Section, Ident, Value: string);
begin
  if (ExtractFilePath(FileName) = '') then FileName := (IniDir + '\' + FileName);
  if (not GetWorkingFile(FileName, False, False)) then Exit;

  WritePrivateProfileString(PChar(Section), PChar(Ident), PChar(Value), PChar(FileName));
end;

procedure WriteInteger(FileName: string; const Section, Ident: string; Value: Integer);
begin
  WriteString(FileName, Section, Ident, IntToStr(Value));
end;

procedure WriteBool(FileName: string; const Section, Ident: string; Value: Boolean);
begin
  WriteInteger(FileName, Section, Ident, Integer(Value));
end;

function OneString(const s: string): string;
var
  i: integer;
  LastSpace: Boolean;
begin
  Result := '';
  if (s <> '') then
  begin
    LastSpace := False;
    for i := 1 to Length(s) do
      if (s[i] >= #32) then
      begin
        Result := (Result + s[i]);
        LastSpace := False;
      end
      else
        if (not LastSpace) then
        begin
          Result := (Result + ' ');
          LastSpace := True;
        end;
  end;
end;

function SupportsEx(const Instance: IUnknown; const Intf: TGUID; out Inst): Boolean;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(Intf, Inst) = 0) and (Pointer(Inst) <> nil);
end;

function GetReadableSize(Address, Size: DWord): DWord;
const
  ReadAttributes = [PAGE_READONLY, PAGE_READWRITE, PAGE_WRITECOPY, PAGE_EXECUTE,
    PAGE_EXECUTE_READ, PAGE_EXECUTE_READWRITE, PAGE_EXECUTE_WRITECOPY];
var
  MemInfo: TMemoryBasicInformation;
  Tmp: DWord;
begin
  Result := 0;
  if (VirtualQuery(Pointer(Address), MemInfo, SizeOf(MemInfo)) = SizeOf(MemInfo)) and
    (MemInfo.State = MEM_COMMIT) and (MemInfo.Protect in ReadAttributes) then
  begin
    Result := (MemInfo.RegionSize - (Address - DWord(MemInfo.BaseAddress)));
    if (Result < Size) then
    begin
      repeat
        Tmp := GetReadableSize((DWord(MemInfo.BaseAddress) + MemInfo.RegionSize), (Size - Result));
        if (Tmp > 0) then Inc(Result, Tmp)
        else Result := 0;
      until (Result >= Size) or (Tmp = 0);
    end;
  end;
end;

function IsValidBlockAddr(Address, Size: DWord): Boolean;
begin
  Result := (GetReadableSize(Address, Size) >= Size);
end;

function ConvertAddress(Addr: DWord): DWord;
type
  TJMPCode = packed record
    JMPOpCode: Word;
    JMPPtr: PDWord;
    MOVOpCode: Word;
  end;
  PJMPCode = ^TJMPCode;
var
  JMP: PJMPCode;
begin
  Result := Addr;
  if (IsValidBlockAddr(Addr, 8)) then
  begin
    JMP := PJMPCode(Addr);
    if (JMP^.JMPOpCode = $25FF) and (IsValidBlockAddr(DWord(JMP^.JMPPtr), 4)) then
      Result := JMP^.JMPPtr^;
  end;
end;

function GetModifiedDate(sFileName: string): TDateTime;
var
  ffd: TWin32FindData;
  dft: DWord;
  lft: TFileTime;
  h: THandle;
begin
  Result := 0;
  // Get file information
  h := Windows.FindFirstFile(PChar(sFileName), ffd);
  if (h <> INVALID_HANDLE_VALUE) then
  begin
    // We're looking for just one file, so close our "find"
    Windows.FindClose(h);
    // Convert the FILETIME to local FILETIME
    if FileTimeToLocalFileTime(ffd.ftLastWriteTime, lft) then
    begin
      // Convert FILETIME to DOS time
      if FileTimeToDosDateTime(lft, LongRec(dft).Hi, LongRec(dft).Lo) then
        Result := FileDateToDateTime(dft);
    end;
  end;
end;

function GetLongNameFromShort(Path: string): string;
var
  I: Integer;
  SearchHandle: THandle;
  FindData: TWin32FindData;
  IsBackSlash: Boolean;
begin
  Result := Path;
  if (Pos('~', Path) = 0) then Exit;

  Path := ExpandFileName(Path);
  Result := ExtractFileDrive(Path);
  I := Length(Result);
  if (Length(Path) <= I) then Exit; // only drive

  if (Path[I + 1] = '\') then
  begin
    Result := (Result + '\');
    Inc(I);
  end;
  Delete(Path, 1, I);
  repeat
    I := Pos('\', Path);
    IsBackSlash := (I > 0);
    if (not IsBackSlash) then I := (Length(Path) + 1);
    SearchHandle := FindFirstFile(PChar(Result + Copy(Path, 1, I - 1)), FindData);
    if (SearchHandle <> INVALID_HANDLE_VALUE) then
    begin
      try
        Result := (Result + FindData.cFileName);
        if IsBackSlash then Result := (Result + '\');
      finally
        Windows.FindClose(SearchHandle);
      end;
    end
    else
    begin
      Result := (Result + Path);
      Break;
    end;
    Delete(Path, 1, I);
  until (Length(Path) = 0);
end;

function PosEx(const SubStr, S: string; Idx: Integer): Integer;
var
  n, len1, len2: Integer;
begin
  Result := 0;
  len1 := Length(SubStr);
  len2 := Length(S);
  n := Idx;
  while (n <= (len2 - len1 + 1)) and (Copy(S, n, len1) <> SubStr) do inc(n);
  if (n <= (len2 - len1 + 1)) then Result := n;
end;

function QuickStringReplace(const S, OldPattern, NewPattern: string): string;
var
  ResultLen, CopyLen, TextLen, OldLen, NewLen: Integer;
  PSource, POld, PNew, Index, PLastS, PLastR: PChar;
begin
  TextLen := Length(S);
  OldLen := Length(OldPattern);
  NewLen := Length(NewPattern);
  if (OldLen < NewLen) then
    ResultLen := (((TextLen div OldLen) * NewLen) + (TextLen mod OldLen))
  else
    ResultLen := Length(S);
  SetLength(Result, ResultLen);
  PSource := PChar(S);
  POld := PChar(OldPattern);
  PNew := PChar(NewPattern);
  PLastS := PSource;
  PLastR := PChar(Result);
  Index := PSource;
  repeat
    Index := StrPos(Index, POld);
    if (Index <> nil) then
    begin // Found...
      CopyLen := (Index - PLastS);
      Move(PLastS^, PLastR^, CopyLen);
      PLastS := (Index + OldLen);
      Inc (PLastR, CopyLen);
      Move(PNew^, PLastR^, NewLen);
      Inc(PLastR, NewLen);
      Inc(Index, OldLen);
    end
    else
    begin // Not found...
      CopyLen := (PChar(S) + TextLen - PLastS);
      Move(PLastS^, PLastR^, CopyLen);
      Inc (PLastR, CopyLen);
    end;
  until (Index = nil);
  SetLength(Result, (PLastR - PChar(Result)));
end;

procedure ExtractStringsEx(Separators: TCharSet; Content: string; Strings: TStrings);
var
  i, old: integer;
  s: string;
begin
  i := 1;
  if (Content = '') then Exit;
  while (i <= length(Content)) and (Content[i] in Separators) do
    inc(i);
  old := i;
  while (i <= length(Content)) do
  begin
    if (Content[i] in Separators) then
    begin
      s := Trim(Copy(content, old, i - old));
      Strings.Add(s);
      old := i + 1;
    end;
    inc(i);
  end;
  s := trim(copy(content, old, i - old + 1));
  if s <> '' then Strings.Add(s);
end;

// This function read from the system's registry...
// -----------------------------------------------------------------------------
// WARNING !!!                                                                 -
// Don't use TRegistry.OpenKey before it open a key for Read/Write access,     -
// and in a machine when the user haven't the registry write permission failed -
// -----------------------------------------------------------------------------

function ReadKey(Root: HKey; Key, Str: string): string;
var
  Reg: HKey;
  Size: Integer;
  DataType: Integer;
begin
  Result := '';
  if (Key <> '') and (Key[1] = '\') then Delete(Key, 1, 1);
  if (RegOpenKeyEx(Root, PChar(Key), 0, KEY_READ, Reg) = ERROR_SUCCESS) then
  begin
    if RegQueryValueEx(Reg, PChar(Str), nil,
      @DataType, nil, @Size) = ERROR_SUCCESS then
    begin
      SetLength(Result, Size);
      RegQueryValueEx(Reg, PChar(Str), nil, @DataType, PByte(PChar(Result)), @Size);
      // Cut the last #0 char...
      Result := Copy(Result, 1, Length(Result) - 1);
    end
    else
      Result := '';
    RegCloseKey(Reg);
  end;
end;

function RADRegistryKey: string;

  function GetMultiConfigurationString: string;
  var
    n: Integer;
  begin
    Result := RADRegKeyName;
    if (not IntoIDE) then Exit;

    for n := 1 to ParamCount do
    begin
      if (UpperCase(Copy(ParamStr(n), 1, 2)) = '-R') then
      begin
        Result := Copy(ParamStr(n), 3, Length(ParamStr(n)));
        Break;
      end;
    end;
  end;

begin
  Result := ('SOFTWARE\Borland\' + GetMultiConfigurationString + '\' + RADVersionString);
end;

// Delphi/BCB installed dir...
function RADDir: string;
begin
  Result := ReadKey(HKEY_LOCAL_MACHINE, RADRegistryKey, 'RootDir');

  if Result = '' then // Check for an installation as single user...
    Result := ReadKey(HKEY_CURRENT_USER, RADRegistryKey, 'RootDir');

  if (Result <> '') and (Result[Length(Result)] = '\') then
    Delete(Result, Length(Result), 1);
end;

function GetGMT: Integer;
var
  GMTTime, LocalTime: TSystemTime;
begin
  GetSystemTime(GMTTime);
  GetLocalTime(LocalTime);
  Result := Round((SystemTimeToDateTime(LocalTime) - SystemTimeToDateTime(GMTTime)) * 24);
end;

function GetGMTDateTime(DateTime: TDateTime): TDateTime;
begin
  Result := (DateTime - (GetGMT / 24));
end;

function GetEurekaLogLabel: string;

  function EurekaLogType: string;
  begin
    Result := ReadKey(HKEY_CURRENT_USER, '\Software\EurekaLog', 'AppType');
{$IFDEF EUREKALOG_DEMO}
    if Result = 'TRL' then Result := EurekaTypeTRL
    else
{$ENDIF}
{$IFNDEF PROFESSIONAL}
      if Result = 'STD' then Result := EurekaTypeSTD;
{$ELSE}
      if Result = 'PRO' then Result := EurekaTypePRO
      else
        if Result = 'ENT' then Result := EurekaTypeENT;
{$ENDIF}
  end;

begin
  Result := 'EurekaLog ' + EurekaLogVersion + ' ' + EurekaLogType;
end;

function IntoIDE: Boolean;
begin
  Result := InternalIntoIDE;
end;

function CheckIntoIDE: boolean;
var
  Buff: array[0..MAX_PATH - 1] of Char;
  FileName: string;
begin
  if (GetModuleFileName(MainInstance, Buff, SizeOf(Buff)) > 0) then
    FileName := Buff
  else
    FileName := '';
  Result := UpperCase(ExtractFileName(FileName)) = RADExeName;
end;

function IsWritableFile(const FileName: string): Boolean;
var
  HFile: THandle;
  FExists: Boolean;
begin
  Result := False;
  FExists := FileExists(FileName);

  HFile := CreateFile(PChar(FileName), GENERIC_WRITE or GENERIC_READ,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
    OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile <> INVALID_HANDLE_VALUE) then
  begin
    Result := True;
    CloseHandle(HFile);
    if (not FExists) then DeleteFile(PChar(FileName));
  end;
end;

function IsReadableFile(const FileName: string): Boolean;
var
  HFile: THandle;
begin
  Result := False;

  HFile := CreateFile(PChar(FileName), GENERIC_READ,
    FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile <> INVALID_HANDLE_VALUE) then
  begin
    Result := True;
    CloseHandle(HFile);
  end;
end;

function GetWorkingFile(var FileName: string; ProjectDir, ReadOnly: Boolean): Boolean;
var
  NewFile, NewDir: string;

  function CheckDirectoryExists(const Directory: string): Boolean;
  var
    Code: Integer;
  begin
    Code := GetFileAttributes(PChar(Directory));
    Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
  end;

  function IsFileOK(const FileName: string): Boolean;
  begin
    if (not ReadOnly) then Result := IsWritableFile(FileName)
    else Result := IsReadableFile(FileName);
  end;

begin
  Result := True;
  if (IsFileOK(FileName)) then Exit;

  Result := False;
  NewDir := (GetUserPath + '\EurekaLog');
  if (not CheckDirectoryExists(NewDir)) and (not CreateDir(NewDir)) then Exit;

  if (ProjectDir) then
  begin
    NewDir := (NewDir + '\' + ChangeFileExt(ExtractFileName(ParamStr(0)), ''));
    if (not CheckDirectoryExists(NewDir)) and (not CreateDir(NewDir)) then Exit;
  end;

  NewFile := (NewDir + '\' + ExtractFileName(FileName));
  if (not IsFileOK(NewFile)) then Exit;
  FileName := NewFile;
  Result := True;
end;

{ TEurekaExceptionsFilters }

function TEurekaExceptionsFilters.Add(Item: Pointer): Integer;
begin
  Result := inherited Add(Item);
  FOwner.SaveToSharedData;
end;

procedure TEurekaExceptionsFilters.Assign(const Source: TEurekaExceptionsFilters);
var
  n: Integer;
  Filter: PEurekaExceptionFilter;
begin
  Clear;
  for n := 0 to (Source.Count - 1) do
  begin
    New(Filter);
    Filter^.Active := Source[n]^.Active;
    Filter^.ExceptionClassName := Source[n]^.ExceptionClassName;
    Filter^.ExceptionMessage := Source[n]^.ExceptionMessage;
    Filter^.ExceptionType := Source[n]^.ExceptionType;
    Filter^.DialogType := Source[n]^.DialogType;
    Filter^.HandlerType := Source[n]^.HandlerType;
    Filter^.ActionType := Source[n]^.ActionType;
    Add(Filter);
  end;
end;

procedure TEurekaExceptionsFilters.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do Delete(0);
  inherited;
  FOwner.SaveToSharedData;
end;

constructor TEurekaExceptionsFilters.Create(const Owner: TEurekaModuleOptions);
begin
  FOwner := Owner;
  inherited Create;
end;

procedure TEurekaExceptionsFilters.Delete(Index: Integer);
begin
  Dispose(Items[Index]);
  inherited;
  FOwner.SaveToSharedData;
end;

destructor TEurekaExceptionsFilters.Destroy;
begin
  Clear;
  inherited;
end;

function TEurekaExceptionsFilters.GetItem(Index: Integer): PEurekaExceptionFilter;
begin
  Result := PEurekaExceptionFilter(TList(Self).Items[Index]);
end;

procedure TEurekaExceptionsFilters.Insert(Index: Integer; Item: Pointer);
begin
  inherited;
  FOwner.SaveToSharedData;
end;

{ TEurekaModuleOptions }

constructor TEurekaModuleOptions.Create(ModuleName: string; SaveSharedData: Boolean);
begin
  inherited Create;
  FSaveSharedData := SaveSharedData;
  FModuleName := ModuleName;
  FExceptionsFilters := TEurekaExceptionsFilters.Create(Self);
  SetToDefaultOptions;
  FSharedData := 0;
end;

destructor TEurekaModuleOptions.Destroy;
begin
  DisableSharedDataWrite;
  FExceptionsFilters.Free;
  inherited;
end;

procedure TEurekaModuleOptions.Assign(Source: TEurekaModuleOptions);
var
  i: TMessageType;
begin
  if (Source <> nil) then
  begin
    if (Source <> Self) then
    begin
      DisableSharedDataWrite;
      try
        ExceptionsFilters.Assign(Source.FExceptionsFilters);
        for i := low(TMessageType) to high(TMessageType) do
          FCustomizedTexts[i] := Source.FCustomizedTexts[i];
        TextsCollection := Source.FTextsCollection;
        ActivateLog := Source.FActivateLog;
        SaveLogFile := Source.FSaveLogFile;
        FreezeActivate := Source.FFreezeActivate;
        FreezeTimeout := Source.FFreezeTimeout;
        SMTPFrom := Source.FSMTPFrom;
        SMTPHost := Source.FSMTPHost;
        SMTPPort := Source.FSMTPPort;
        SMTPUserID := Source.FSMTPUserID;
        SMTPPassword := Source.FSMTPPassword;
        ForegroundTab := Source.FForegroundTab;
        ActivateHandle := Source.FActivateHandle;
        AppendLogs := Source.FAppendLogs;
        TerminateBtnOperation := Source.FTerminateBtnOperation;
        LogOptions := Source.FLogOptions;
        ErrorsNumberToSave := Source.FErrorsNumberToSave;
        ErrorsNumberToShowTerminateBtn := Source.FErrorsNumberToShowTerminateBtn;
        OutputPath := Source.FOutputPath;
        EMailAddresses := Source.FEMailAddresses;
        EMailSubject := Source.FEMailSubject;
        EMailMessage := Source.FEMailMessage;
        EMailSendMode := Source.FEMailSendMode;
        ShowOptions := Source.FShowOptions;

        WebSendMode := Source.WebSendMode;
        WebURL := Source.WebURL;
        WebUserID := Source.WebUserID;
        WebPassword := Source.WebPassword;
        WebPort := Source.WebPort;
        CommonSendOptions := Source.CommonSendOptions;
        AttachedFiles := Source.AttachedFiles;

        ExceptionDialogOptions := Source.ExceptionDialogOptions;
        AutoCloseDialogSecs := Source.AutoCloseDialogSecs;
        SupportURL := Source.SupportURL;
        HTMLLayout := Source.HTMLLayout;

        CallStackOptions := Source.CallStackOptions;
        BehaviourOptions := Source.BehaviourOptions;
        AutoCrashOperation := Source.AutoCrashOperation;
        AutoCrashNumber := Source.AutoCrashNumber;
        AutoCrashMinutes := Source.AutoCrashMinutes;

        ProxyURL := Source.ProxyURL;
        ProxyUserID := Source.ProxyUserID;
        ProxyPassword := Source.ProxyPassword;
        ProxyPort := Source.ProxyPort;
        TrakerUserID := Source.TrakerUserID;
        TrakerPassword := Source.TrakerPassword;
        TrakerAssignTo := Source.TrakerAssignTo;
        TrakerProject := Source.TrakerProject;
        TrakerCategory := Source.TrakerCategory;
        TrakerTrialID := Source.TrakerTrialID;
        ZipPassword := Source.ZipPassword;
        PreBuildEvent := Source.PreBuildEvent;
        PostSuccessfulBuildEvent := Source.PostSuccessfulBuildEvent;
        PostFailureBuildEvent := Source.PostFailureBuildEvent;
        CompiledFileOptions := Source.CompiledFileOptions;
        ExceptionDialogType := Source.ExceptionDialogType;
        FLeaksOptions := Source.FLeaksOptions;

      finally
        EnableSharedDataWrite;
        SaveToSharedData;
      end;
    end;
  end
  else
    raise
      EConvertError.Create('Impossible to assign nil as TEurekaModuleOptions.');
end;

function TEurekaModuleOptions.GetCustomizedTexts(Index: TMessageType): string;
begin
  Result := FCustomizedTexts[Index];
end;

function TEurekaModuleOptions.GetCustomizedExpandedTexts(Index: TMessageType): string;
begin
  Result := ExpandEnvVar(FCustomizedTexts[Index]);
end;

procedure TEurekaModuleOptions.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TEurekaModuleOptions.SaveToStream(Stream: TStream);
var
  d, i: integer;
  t: TMessageType;

  procedure WriteString(St: TStream; s: string);
  var
    i: integer;
  begin
    // If "s" is a single line, then delete the last #13#10 chars...
    if (length(s) > 1) and (pos(#13#10, s) = length(s) - 1) then
      s := copy(s, 1, length(s) - 2);

    // $62 increase the compression rate (~2.5%)
    for i := 1 to length(s) do
      s[i] := Char(Integer(s[i]) xor $62);

    i := length(s);
    St.write(i, 4);
    if (i > 0) then
      St.write(s[1], i);
  end;

begin
  with Stream do
  begin
    write(FActivateLog, 1);
    write(FActivateHandle, 1);
    write(FLogOptions, 1);
    write(FAppendLogs, 1);
    write(FSaveLogFile, 1);
    write(FForegroundTab, 1);
    write(FFreezeActivate, 1);
    write(FFreezeTimeout, 4);
    WriteString(Stream, FSMTPFrom);
    WriteString(Stream, FSMTPHost);
    write(FSMTPPort, 2);
    WriteString(Stream, FSMTPUserID);
    WriteString(Stream, FSMTPPassword);
    write(FTerminateBtnOperation, 1);
    write(FErrorsNumberToSave, 4);
    write(FErrorsNumberToShowTerminateBtn, 4);
    WriteString(Stream, FEMailAddresses);
    WriteString(Stream, FEMailSubject);
    write(FEMailSendMode, 1);
    write(FShowOptions, 6);
    WriteString(Stream, FOutputPath);

    write(FWebSendMode, 1);
    WriteString(Stream, FWebURL);
    WriteString(Stream, FWebUserID);
    WriteString(Stream, FWebPassword);
    write(FWebPort, 4);
    WriteString(Stream, FAttachedFiles);
    write(FCommonSendOptions, 2);

    write(FExceptionDialogOptions, 2); // Size 1 -> 2 in EurekaLog 6.0
    write(FAutoCloseDialogSecs, 4);
    WriteString(Stream, FSupportURL);
    WriteString(Stream, FHTMLLayout);

    write(FCallStackOptions, 1);
    write(FBehaviourOptions, 2); // Size 1 -> 2 in EurekaLog 6.0
    write(FLeaksOptions, 1);
    write(FAutoCrashOperation, 1);
    write(FAutoCrashNumber, 4);
    write(FAutoCrashMinutes, 4);
    write(FCompiledFileOptions, 1);
    write(FExceptionDialogType, 1);
    WriteString(Stream, FProxyURL);
    WriteString(Stream, FProxyUserID);
    WriteString(Stream, FProxyPassword);
    write(FProxyPort, 2);
    WriteString(Stream, FTrakerUserID);
    WriteString(Stream, FTrakerPassword);
    WriteString(Stream, FTrakerAssignTo);
    WriteString(Stream, FTrakerProject);
    WriteString(Stream, FTrakerCategory);
    WriteString(Stream, FTrakerTrialID);
    WriteString(Stream, FZipPassword);

    d := FExceptionsFilters.Count;
    write(d, 4);
    for i := 0 to d - 1 do
    begin
      Write(FExceptionsFilters[i]^.Active, 1);
      WriteString(Stream, FExceptionsFilters[i]^.ExceptionClassName);
      WriteString(Stream, FExceptionsFilters[i]^.ExceptionMessage);
      Write(FExceptionsFilters[i]^.ExceptionType, 1);
      Write(FExceptionsFilters[i]^.DialogType, 1);
      Write(FExceptionsFilters[i]^.HandlerType, 1);
      Write(FExceptionsFilters[i]^.ActionType, 1);
    end;
    WriteString(Stream, FEMailMessage);
    for t := low(TMessageType) to high(TMessageType) do
      WriteString(Stream, FCustomizedTexts[t]);
    WriteString(Stream, FTextsCollection);
  end;
end;

procedure ReadRawStrings(const Cnf: string; Section, CountName, Prefix, Default: string;
  var Value: string);
var
  I, C: Integer;
  Tmp: TStringList;
  s: string;
begin
  Tmp := TStringList.Create;
  C := StrToIntDef(ReadString(Cnf, Section, CountName, '0'), 0);
  if (C > 0) then
    for I := 0 to (C - 1) do
    begin
      s := ReadString(Cnf, Section, Prefix + IntToStr(I), Default);
      if (Length(s) > 1) and (s[1] = '"') and (s[Length(s)] = '"') then
        s := Copy(s, 2, Length(s) - 2);
      Tmp.Add(s);
    end
  else
    Tmp.Add(Default);
  Value := Tmp.Text;
  if (Length(Value) > 1) and (Copy(Value, length(Value) - 1, 2) = #13#10) then
    Delete(Value, Length(Value) - 1, 2);
  Tmp.Free;
end;

procedure WriteRawStrings(Cnf: string; Section, CountName, Prefix: string; Value: string);
var
  I: Integer;
  Tmp: TStringList;
begin
  Tmp := TStringList.Create;
  Tmp.Text := Value;
  WriteString(Cnf, Section, CountName, IntToStr(Tmp.Count));
  for I := 0 to Tmp.Count - 1 do
    WriteString(Cnf, Section, Prefix + IntToStr(I), '"' + Tmp[I] + '"');
  Tmp.Free;
end;

procedure TEurekaModuleOptions.LoadCustomizedTextsFromFile(const FileName: string);
var
  t: TMessageType;
  EnumName: string;
begin
  for t := low(TMessageType) to high(TMessageType) do
  begin
    EnumName := GetEnumName(TypeInfo(TMessageType), Ord(t));
    ReadRawStrings(FileName, EurekaLogSection, 'Count ' + EnumName, EnumName,
      CustomizedTexts[t], FCustomizedTexts[t]);
  end;
  FTextsCollection := ChangeFileExt(FileName, '');
end;

procedure TEurekaModuleOptions.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TEurekaModuleOptions.LoadFromStream(Stream: TStream);
type
  TSetArray = array[0..5] of Byte;
var
  d, i: integer;
  t: TMessageType;
  s: string;
  Filter: PEurekaExceptionFilter;
  tmp: Byte;
  BoolTmp: Boolean;
  StrTmp, FreezeMessage: string;

  function BinToStr(bin: TSetArray): string;
  var
    n, b: DWord;
  begin
    Result := '';
    b := 1;
    for n := 0 to (SizeOf(bin) * 8 - 1) do
    begin
      Result := Result + IntToStr(Integer(bin[n div 8] and b <> 0));
      b := (b shl 1);
      if (b = 256) then b := 1;
    end;
  end;

  function StrToBin(const st: string): TSetArray;
  var
    n, b, idx: DWord;
  begin
    FillChar(Result, SizeOf(Result), #0);
    b := 1;
    for n := 1 to (SizeOf(TSetArray) * 8) do
    begin
      idx := ((n - 1) div 8);
      Result[idx] := (Result[idx] or (Byte(StrToInt(st[n])) * b));
      b := (b shl 1);
      if (b = 256) then b := 1;
    end;
  end;

  function ReadString(St: TStream): string;
  var
    i: integer;
  begin
    St.read(i, 4);
    SetLength(Result, i);
    if (i > 0) then
      St.read(Result[1], i);

    // $62 increase the compression rate (~2.5%)
    for i := 1 to length(Result) do
      Result[i] := Char(Integer(Result[i]) xor $62);
  end;

begin
  FreezeMessage := '';

  DisableSharedDataWrite;
  try
    with Stream do
    begin
      read(FActivateLog, 1);
      read(FActivateHandle, 1);
      read(FLogOptions, 1);

      if (LastEurekaVersion < 500) then
      begin
        read(BoolTmp, 1);
        if (LastEurekaVersion < 450) then BoolTmp := not BoolTmp;
        if (not BoolTmp) then ExceptionDialogType := edtNone;
      end;

      read(FAppendLogs, 1);

      // From EurekaLog 4.5.0 to <5.0.0
      if (LastEurekaVersion >= 450) and (LastEurekaVersion < 500) then
      begin
        read(BoolTmp, 1);
        if (BoolTmp) then CommonSendOptions := CommonSendOptions + [sndSendEntireLog]
        else CommonSendOptions := CommonSendOptions - [sndSendEntireLog];
        read(BoolTmp, 1);
        if (BoolTmp) then CommonSendOptions := CommonSendOptions + [sndSendScreenshot]
        else CommonSendOptions := CommonSendOptions - [sndSendScreenshot];
        read(BoolTmp, 1);
        if (BoolTmp) then CommonSendOptions := CommonSendOptions + [sndShowSendDialog]
        else CommonSendOptions := CommonSendOptions - [sndShowSendDialog];
      end;

      // From EurekaLog 4.0.1
      if (LastEurekaVersion >= 401) then
      begin
        read(FSaveLogFile, 1);
        read(FForegroundTab, 1);
        if (LastEurekaVersion < 6000) then
        begin
          if (FForegroundTab = ftProcesses) then FForegroundTab := ftCPU;
        end;
      end;

      // From EurekaLog 4.0.3 to <5.0.0
      if (LastEurekaVersion >= 403) and (LastEurekaVersion < 500) then
      begin
        read(BoolTmp, 1);
        if (BoolTmp) then ExceptionDialogOptions := ExceptionDialogOptions + [edoUseEurekaLogLookAndFeel]
        else ExceptionDialogOptions := ExceptionDialogOptions - [edoUseEurekaLogLookAndFeel];
      end;

      // From EurekaLog 4.2
      if (LastEurekaVersion >= 420) then
      begin
        read(FFreezeActivate, 1);
        read(FFreezeTimeout, 4);
        if (LastEurekaVersion < 422) then
          FFreezeTimeout := FFreezeTimeout div 1000;
        if (LastEurekaVersion < 6000) then
          FreezeMessage := ReadString(Stream);
        // From EurekaLog 4.5.0
        if (LastEurekaVersion >= 450) then FSMTPFrom := ReadString(Stream);
        FSMTPHost := ReadString(Stream);
      end;

      // From EurekaLog 4.5.0
      if (LastEurekaVersion >= 450) then read(FSMTPPort, 2);

      // From EurekaLog 4.2.1
      if (LastEurekaVersion >= 421) then
      begin
        FSMTPUserID := ReadString(Stream);
        FSMTPPassword := ReadString(Stream);
        read(FTerminateBtnOperation, 1);
      end;

      if (LastEurekaVersion < 6000) then
      begin
        read(BoolTmp, 1);
        if (not BoolTmp) then TerminateBtnOperation := tbNone;
      end;

      read(FErrorsNumberToSave, 4);
      read(FErrorsNumberToShowTerminateBtn, 4);
      FEMailAddresses := ReadString(Stream);
      FEMailSubject := ReadString(Stream);
      read(FEMailSendMode, 1);
      if (LastEurekaVersion < 450) and (FEMailSendMode <> esmNoSend) then
      begin
        if (FSMTPHost <> '') then
          FEMailSendMode := esmSMTPClient
        else
          FEMailSendMode := esmEmailClient;
      end;

      FShowOptions := [];
      if (LastEurekaVersion < 500) then
      begin
        read(FShowOptions, 4);
        StrTmp := BinToStr(TSetArray(FShowOptions));
        Insert('11', StrTmp, 5);  //  Insert: AppCompilationDate, AppUpTime
        Insert('1', StrTmp, 10); // Insert: ExcModuleVersion
        Insert('1111', StrTmp, 13); // Insert: ExcID, ExcCount, ExcStatus, ExcNote
        Insert('1111', StrTmp, 23); // Insert: CmpUserName, CmpUserEmail, CmpUserPrivileges, CmpCompanyName
        Insert('111111', StrTmp, 31); // Insert: soCmpSysUpTime, soCmpProcessor, soCmpDisplayMode, soCmpDisplayDPI, soCmpVideoCard, soCmpPrinter
        Insert('1111111', StrTmp, 42); // Insert: soNetIP, soNetSubmask, soNetGateway, soNetDNS1, soNetDNS2, soNetDHCP, soCustomData
        FShowOptions := TShowOptions(StrToBin(StrTmp));
      end
      else
        if (LastEurekaVersion < 6000) then
        begin
          read(FShowOptions, 5);
          StrTmp := BinToStr(TSetArray(FShowOptions));
          Insert('1', StrTmp, 6);  //  Insert: AppUpTime
          Insert('1', StrTmp, 10); // Insert: ExcModuleVersion
          Insert('1111', StrTmp, 13); // Insert: ExcID, ExcCount, ExcStatus, ExcNote
          Insert('1111', StrTmp, 23); // Insert: CmpUserName, CmpUserEmail, CmpUserPrivileges, CmpCompanyName
          Insert('111', StrTmp, 34); // Insert: CmpDisplayDPI, CmpVideoCard, CmpPrinter
          Insert('1', StrTmp, 41); // Insert: OSCharset
          Insert('1', StrTmp, 48); // Insert: CustomData
          FShowOptions := TShowOptions(StrToBin(StrTmp));
        end
        else read(FShowOptions, 6);

      if (LastEurekaVersion < 450) then read(tmp, 1); // Old EmailSendConfirm prop.

      FOutputPath := ReadString(Stream);

      if (LastEurekaVersion >= 500) then
      begin
        read(FWebSendMode, 1);
        FWebURL := ReadString(Stream);
        FWebUserID := ReadString(Stream);
        FWebPassword := ReadString(Stream);
        read(FWebPort, 4);
        FAttachedFiles := ReadString(Stream);
        read(FCommonSendOptions, 2);
        if (LastEurekaVersion < 6000) then
          FCommonSendOptions := (FCommonSendOptions - [sndAddComputerNameInFileName]);

        if (LastEurekaVersion >= 6000) then read(FExceptionDialogOptions, 2)
        else
        begin
          FExceptionDialogOptions := [];
          read(FExceptionDialogOptions, 1);
        end;
        read(FAutoCloseDialogSecs, 4);
        FSupportURL := ReadString(Stream);
        FHTMLLayout := ReadString(Stream);

        read(FCallStackOptions, 1);
        if (LastEurekaVersion < 6000) then
          FCallStackOptions := (FCallStackOptions + [csoDoNotStoreProcNames]);

        if (LastEurekaVersion >= 6000) then
        begin
          read(FBehaviourOptions, 2);
          read(FLeaksOptions, 1);
        end
        else
        begin
          FBehaviourOptions := [];
          read(FBehaviourOptions, 1);
        end;
        read(FAutoCrashOperation, 1);
        read(FAutoCrashNumber, 4);
        read(FAutoCrashMinutes, 4);
        if (LastEurekaVersion >= 6000) then
        begin
          read(FCompiledFileOptions, 1);
          read(FExceptionDialogType, 1);
          FProxyURL := ReadString(Stream);
          FProxyUserID := ReadString(Stream);
          FProxyPassword := ReadString(Stream);
          read(FProxyPort, 2);
          FTrakerUserID := ReadString(Stream);
          FTrakerPassword := ReadString(Stream);
          FTrakerAssignTo := ReadString(Stream);
          FTrakerProject := ReadString(Stream);
          FTrakerCategory := ReadString(Stream);
          FTrakerTrialID := ReadString(Stream);
          FZipPassword := ReadString(Stream);
        end;
      end;

      FExceptionsFilters.Clear;
      read(d, 4);
      for i := 0 to d - 1 do
      begin
        New(Filter);
        if (LastEurekaVersion >= 6000) then Read(Filter^.Active, 1)
        else Filter^.Active := True;

        s := ReadString(Stream);
        Filter^.ExceptionClassName := s;
        s := ReadString(Stream);
        Filter^.ExceptionMessage := s;
        if (LastEurekaVersion >= 6000) then
        begin
          Read(Filter^.ExceptionType, 1);
          Read(Filter^.DialogType, 1);
          Read(Filter^.HandlerType, 1);
          Read(Filter^.ActionType, 1);
        end
        else
        begin
          if (Filter.ExceptionMessage = '') then
          begin
            Filter^.ExceptionType := fetUnhandled;
            Filter^.DialogType := fdtNone;
            Filter^.HandlerType := fhtNone;
            Filter^.ActionType := fatNone;
          end
          else
          begin
            Filter^.ExceptionType := fetUnhandled;
            Filter^.DialogType := fdtMessageBox;
            Filter^.HandlerType := fhtNone;
            Filter^.ActionType := fatNone;
          end;
        end;
        FExceptionsFilters.Add(Filter);
      end;

      FEMailMessage := ReadString(Stream);
      for t := low(TMessageType) to high(TMessageType) do
      begin
        // Convert old mtLog_CmpUser in the new mtLog_UserName...
        if ((Integer(t) in [68] {moved option}) and (LastEurekaVersion < 6000)) then
          s := ReadString(Stream);

        if not (((t = mtDialog_DetailsButtonCaption) and (LastEurekaVersion < 420)) or
          ((t = mtDialog_RestartButtonCaption) and (LastEurekaVersion < 421)) or
          ((t in [mtDialog_ModulesCaption, mtDialog_ModulesHeader,
          mtDialog_CPUCaption, mtDialog_CPUHeader, mtDialog_SendMessage,
            mtDialog_ScreenshotMessage, mtDialog_CopyMessage, mtLog_AppParameters,
            mtLog_CmpTotalMemory, mtLog_OSUpdate]) and (LastEurekaVersion < 450)) or
            ((t >= mtSendDialog_Caption) and (LastEurekaVersion < 450)) or
          ((Integer(t) in [47, 48] {removed opt}) and (LastEurekaVersion < 450)) or
          ((t in [mtDialog_SupportMessage, mtLog_AppCompilationDate, mtLog_CmpSystemUpTime,
          mtLog_CmpProcessor, mtLog_CmpDisplayMode, mtLog_NetHeader..mtLog_NetDHCP,
          mtLog_CustInfoHeader, mtModules_LastModified, mtSend_SuccessMsg,
          mtSend_FailureMsg, mtCallStack_MainThread..mtCallStack_ThreadClass,
          mtLog_CmpDisplayDPI..mtLog_CmpPrinter]) and (LastEurekaVersion < 500)) or
          ((Integer(t) in [41] {removed opt}) and (LastEurekaVersion < 6000)) or
          ((t in [mtDialog_OKButtonCaption, mtDialog_TerminateButtonCaption]) and
          (LastEurekaVersion >= 500) and (LastEurekaVersion < 6000)) or
          ((t in [mtErrorMsgCaption, mtDialog_CustomButtonCaption, mtSendDialog_Login,
          mtSendDialog_Sent..mtSendDialog_Disconnected,
          mtMSDialog_ErrorMsgCaption..mtMSDialog_NoSendButtonCaption,
          mtSend_BugClosedMsg..mtSend_InvalidModifyMsg, mtFileCrackedMsg,
          mtCallStack_LeakCaption..mtCallStack_LeakCount,
          mtException_LeakMultiFree..mtException_AntiFreeze, mtInvalidEmailMsg,
          mtLog_AppUpTime, mtLog_ExcID..mtLog_ExcNote,
          mtLog_UserHeader..mtLog_UserPrivileges, mtLog_OSCharset,
          mtLog_UserID..mtLog_UserCompany, mtDialog_ProcessesCaption,
          mtDialog_ProcessesHeader, mtProcesses_ID..mtProcesses_Path,
          mtDialog_AsmCaption, mtDialog_AsmHeader]) and
          (LastEurekaVersion < 6000)))
          then FCustomizedTexts[t] := ReadString(Stream);
      end;
      if (LastEurekaVersion >= 6000) then FTextsCollection := ReadString(Stream);
      if (FreezeMessage <> '') then
        CustomizedTexts[mtException_AntiFreeze] := FreezeMessage;
    end;
  finally
    EnableSharedDataWrite;
    SaveToSharedData;
  end;
end;

// Shared data...
// -----------------------------------------------------------------------------

procedure TEurekaModuleOptions.StoreSharedData;
begin
  // ...
end;

procedure TEurekaModuleOptions.DisableSharedDataWrite;
begin
  inc(FSharedData);
end;

procedure TEurekaModuleOptions.EnableSharedDataWrite;
begin
  dec(FSharedData);
end;

procedure TEurekaModuleOptions.SaveCustomizedTextsToFile(const FileName: string);
var
  t: TMessageType;
begin
  for t := low(TMessageType) to high(TMessageType) do
  begin
    WriteRawStrings(FileName, EurekaLogSection, 'Count ' +
      GetEnumName(TypeInfo(TMessageType), Ord(t)),
      GetEnumName(TypeInfo(TMessageType), Ord(t)), FCustomizedTexts[t]);
  end;
  FTextsCollection := ChangeFileExt(FileName, '');
end;

procedure TEurekaModuleOptions.SaveToSharedData;
begin
  if (FSharedData <= 0) and (FSaveSharedData) and
    (GetModuleHandle(PChar(ModuleName)) = HInstance) then StoreSharedData;
end;

procedure TEurekaModuleOptions.SetToDefaultOptions;
var
  Msg: TMessageType;
begin
  DisableSharedDataWrite;
  try
    for Msg := low(TMessageType) to high(TMessageType) do
      FCustomizedTexts[Msg] := EVals[Msg];
    FTextsCollection := 'English';
    FFreezeActivate := False;
    FFreezeTimeout := 60;
    FSMTPFrom := 'eurekalog@email.com';
    FSMTPHost := '';
    FSMTPPort := 25;
    FSMTPUserID := '';
    FSMTPPassword := '';
    FActivateLog := False; // Set EurekaLog disabled by default on all projects.
    FSaveLogFile := True;
    FForegroundTab := ftGeneral;
    FActivateHandle := True;
    FAppendLogs := False;
    FTerminateBtnOperation := tbRestart;
    FLogOptions := [loSaveModulesAndProcessesSections, loSaveAssemblerAndCPUSections];
    FillChar(FShowOptions, SizeOf(FShowOptions), #255);
    FErrorsNumberToSave := 32;
    FErrorsNumberToShowTerminateBtn := 3;
    FOutputPath := '';
    FEMailAddresses := '';
    FEMailSubject := '';
    FEMailMessage := '';
    FEMailSendMode := esmNoSend;

    FWebSendMode := wsmNoSend;
    FWebURL := '';
    FWebUserID := '';
    FWebPassword := '';
    FWebPort := 0;
    FAttachedFiles := '';
    FCommonSendOptions := [sndShowSendDialog, sndSendScreenshot, sndSendLastHTMLPage];

    FExceptionDialogOptions := [edoShowDetailsButton, edoSendErrorReportChecked,
      edoAttachScreenshotChecked, edoShowCopyToClipOption,
      edoShowSendErrorReportOption, edoShowAttachScreenshotOption];
    FAutoCloseDialogSecs := 0;
    FSupportURL := '';
    FHTMLLayout := '<html>'#13#10'  <head>'#13#10'  </head>'#13#10 +
      '  <body TopMargin=10 LeftMargin=10>'#13#10'    <table width="100%" border="0">'#13#10 +
      '      <tr>'#13#10'        <td nowrap>'#13#10 +
      '          <font face="Lucida Console, Courier" size="2">'#13#10'            <%HTML_TAG%>'#13#10 +
      '          </font>'#13#10'        </td>'#13#10'      </tr>'#13#10'    </table>'#13#10 +
      '  </body>'#13#10'</html>';

    FCallStackOptions := [csoShowDLLs, csoShowBPLs, csoShowBorlandThreads,
      csoShowWindowsThreads];
    FBehaviourOptions := [boCopyLogInCaseOfError, boUseMainModuleOptions,
      boHandleSafeCallExceptions];
    FLeaksOptions := [loGroupsSonLeaks, loHideBorlandLeaks, loHideBorlandLeaks,
      loFreeAllLeaks, loCatchLeaksExceptions];
    FAutoCrashOperation := tbRestart;
    FAutoCrashNumber := 10;
    FAutoCrashMinutes := 1;

    FProxyURL := '';
    FProxyUserID := '';
    FProxyPassword := '';
    FProxyPort := 8080;
    FTrakerUserID := '';
    FTrakerPassword := '';
    FTrakerAssignTo := '';
    FTrakerProject := '';
    FTrakerCategory := '';
    FTrakerTrialID := '';
    FZipPassword := '';
    FPreBuildEvent := '';
    FPostSuccessfulBuildEvent := '';
    FPostFailureBuildEvent := '';
    FCompiledFileOptions := [cfoReduceFileSize];
    FExceptionDialogType := edtMSCLassic;
    FExceptionsFilters.Clear;

    FActive := True;
  finally
    EnableSharedDataWrite;
    SaveToSharedData;
  end;
end;

procedure TEurekaModuleOptions.SetTrakerAssignTo(const Value: string);
begin
  FTrakerAssignTo := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTrakerCategory(const Value: string);
begin
  FTrakerCategory := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTrakerPassword(const Value: string);
begin
  FTrakerPassword := Value;
  SaveToSharedData;  
end;

procedure TEurekaModuleOptions.SetTrakerProject(const Value: string);
begin
  FTrakerProject := Value;
  SaveToSharedData;  
end;

procedure TEurekaModuleOptions.SetTrakerTrialID(const Value: string);
begin
  FTrakerTrialID := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTrakerUserID(const Value: string);
begin
  FTrakerUserID := Value;
  SaveToSharedData;  
end;

procedure TEurekaModuleOptions.SetCustomizedTexts(Index: TMessageType; Value: string);
begin
  FCustomizedTexts[Index] := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetActive(const Value: Boolean);
begin
  FActive := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetFreezeActivate(const Value: Boolean);
begin
  FFreezeActivate := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetErrorsNumberToSave(const Value: Integer);
begin
  if (Value = 0) then
    FErrorsNumberToSave := 1
  else
    FErrorsNumberToSave := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetModuleName(const Value: string);
begin
  FModuleName := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetActivateHandle(const Value: boolean);
begin
  FActivateHandle := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetActivateLog(const Value: boolean);
begin
  FActivateLog := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAppendLogs(const Value: boolean);
begin
  FAppendLogs := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetEMailAddresses(const Value: string);
begin
  FEMailAddresses := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetEMailMessage(const Value: string);
begin
  FEMailMessage := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetEMailSendMode(const Value: TEmailSendMode);
begin
  FEMailSendMode := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetEMailSubject(const Value: string);
begin
  FEMailSubject := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetErrorsNumberToShowTerminateBtn(const Value: integer);
begin
  FErrorsNumberToShowTerminateBtn := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetExceptionsFilters(const Value: TEurekaExceptionsFilters);
begin
  FExceptionsFilters := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetForegroundTab(const Value: TForegroundType);
begin
  FForegroundTab := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetFreezeTimeout(const Value: integer);
begin
  FFreezeTimeout := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetLogOptions(const Value: TLogOptions);
begin
  FLogOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetOutputPath(const Value: string);
begin
  FOutputPath := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetPostFailureBuildEvent(const Value: string);
begin
  FPostFailureBuildEvent := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetPostSuccessfulBuildEvent(const Value: string);
begin
  FPostSuccessfulBuildEvent := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetPreBuildEvent(const Value: string);
begin
  FPreBuildEvent := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetProxyPassword(const Value: string);
begin
  FProxyPassword := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetProxyPort(const Value: Word);
begin
  FProxyPort := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetProxyURL(const Value: string);
begin
  FProxyURL := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetProxyUserID(const Value: string);
begin
  FProxyUserID := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSaveLogFile(const Value: boolean);
begin
  FSaveLogFile := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetShowOptions(const Value: TShowOptions);
begin
  FShowOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPFrom(const Value: string);
begin
  FSMTPFrom := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPHost(const Value: string);
begin
  FSMTPHost := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPPassword(const Value: string);
begin
  FSMTPPassword := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPPort(const Value: Word);
begin
  FSMTPPort := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSMTPUserID(const Value: string);
begin
  FSMTPUserID := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTerminateBtnOperation(
  const Value: TTerminateBtnOperation);
begin
  FTerminateBtnOperation := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetTextsCollection(const Value: string);
begin
  FTextsCollection := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebSendMode(const Value: TWebSendMode);
begin
  FWebSendMode := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebURL(const Value: string);
begin
  FWebURL := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebPassword(const Value: string);
begin
  FWebPassword := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebPort(const Value: Integer);
begin
  FWebPort := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetWebUserID(const Value: string);
begin
  FWebUserID := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetZipPassword(const Value: string);
begin
  FZipPassword := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetCommonSendOptions(const Value: TCommonSendOptions);
begin
  FCommonSendOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetCompiledFileOptions(const Value: TCompiledFileOptions);
begin
  FCompiledFileOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAttachedFiles(const Value: string);
begin
  FAttachedFiles := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetExceptionDialogOptions(const Value: TExceptionDialogOptions);
begin
  FExceptionDialogOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetExceptionDialogType(const Value: TExceptionDialogType);
begin
  FExceptionDialogType := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAutoCloseDialogSecs(
  const Value: Integer);
begin
  FAutoCloseDialogSecs := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAutoCrashMinutes(const Value: Integer);
begin
  FAutoCrashMinutes := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAutoCrashNumber(const Value: Integer);
begin
  FAutoCrashNumber := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetAutoCrashOperation(const Value: TTerminateBtnOperation);
begin
  FAutoCrashOperation := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetHTMLLayout(const Value: string);
begin
  FHTMLLayout := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetSupportURL(const Value: string);
begin
  FSupportURL := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetBehaviourOptions(const Value: TBehaviourOptions);
begin
  FBehaviourOptions := Value;
  SaveToSharedData;
end;

procedure TEurekaModuleOptions.SetCallStackOptions(const Value: TCallStackOptions);
begin
  FCallStackOptions := Value;
  SaveToSharedData;
end;

// -----------------------------------------------------------------------------

function TEurekaModuleOptions.OutputFile(FileName: string): string;

  function IncludeLastBackslash(Source: string): string;
  begin
    if Source = '' then Result := '\'
    else
    begin
      Result := Source;
      if Copy(Source, length(Source), 1) <> '\' then Result := (Result + '\');
    end;
  end;

  function IsWinVista: Boolean;
  begin
    Result := ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 6));
  end;

begin
  if (LowerCase(ExtractFileExt(FOutputPath)) = '.elf') then Result := FOutputPath
  else
  begin
    if (FOutputPath <> '') then
      Result := IncludeLastBackslash(FOutputPath)
    else
    begin
      if (IsWinVista) then
        Result := IncludeLastBackslash(GetUserPath + '\EurekaLog')
      else
        Result := IncludeLastBackslash(ExtractFilePath(FileName));
    end;
    Result := (Result + ExtractFileName(FileName))
  end;
end;

function TEurekaModuleOptions.OutputLogFile(BaseFile: string): string;

  function ComputerName: string;
  const
    NoChars: set of char = ['\', '/', '*', '<', '>', '?', '|', ':', '"'];
  var
    Comp: array[0..255] of Char;
    I: DWord;
  begin
    I := (MAX_COMPUTERNAME_LENGTH + 1);
    GetComputerName(Comp, I);
    Result := Comp;
    for I := 1 to Length(Result) do
      if (Result[I] in NoChars) then Result[I] := '_';
  end;

begin
  if (BaseFile = '') then BaseFile := ModuleName;
  Result := OutputFile(ChangeFileExt(BaseFile, '.elf'));
  if (loAddComputerNameInLogFileName in LogOptions) then
  begin
    Result := (ChangeFileExt(Result, '') + '_' +
      ComputerName + ExtractFileExt(Result));
  end;
end;

procedure SafeExec(Proc: TProc; Section: string);
var
  Error: string;
begin
  try
    Proc;
  except
    on Err: TObject do
    begin
      if (Err is EIgnoreException) then raise;

      if (@CriticalError <> nil) then
      begin
        CriticalError(Format('%s (Address: %s)', [Section, IntToHex(DWord(@Proc), 8)]));
        Abort;
      end
      else
      begin
        if (ExceptObject is Exception) then Error := Exception(ExceptObject).Message
        else Error := 'General internal error.';
        raise Exception.CreateFmt('Critical error at: "%s"'#13#10'Error: "%s".', [Section, Error]);
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure Init;
{$IFDEF DUNITPROJECT}
const
  MsgBoxFlags = (MB_YESNO or MB_DEFBUTTON1 or MB_ICONQUESTION or MB_TASKMODAL);
{$ENDIF}
begin
  InternalIntoIDE := CheckIntoIDE;
{$IFDEF DUNITPROJECT}
{$IFDEF Delphi9Down}
  if ((not IntoIDE) and
    (MessageBox(0, 'Do you want to load the MemCheck memory leaks detector?',
    'Question.', MsgBoxFlags) = ID_YES)) then MemChk;
{$ELSE}
  if ((not IntoIDE) and
    (MessageBox(0, 'Do you want to activate the memory leaks detector?',
    'Question.', MsgBoxFlags) = ID_YES)) then ReportMemoryLeaksOnShutdown := True;
{$ENDIF}
{$ENDIF}
end;

procedure Done;
begin
end;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'ECore.Init');

finalization
  SafeExec(Done, 'ECore.Done');

end.

