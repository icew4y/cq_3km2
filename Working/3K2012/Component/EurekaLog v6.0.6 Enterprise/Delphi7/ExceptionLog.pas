{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{           Main Unit - ExceptionLog             }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ExceptionLog;

{$I Exceptions.inc}

{$D+}

interface

uses {$IFNDEF CBuilder}ELeaks, {$ENDIF} Windows, SysUtils, Messages,
  Classes, ECore, EDebug;

{$I VersionStrings.inc}

const
  MAX_MODULE_NAME32 = 255;

type
{$IFDEF Delphi3}
  THandle = DWord;
{$ENDIF}

  TEurekaDebugDetail = (ddNone, ddModule, ddProcedure,
    ddUnitAndProcedure, ddSourceCode);

  TEurekaDebugDetails = set of TEurekaDebugDetail;

  TEurekaModuleType = (mtUnknown, mtMainModule, mtBorlandPackage, mtOSLibrary);

  TEurekaFunctionsList = class;

  TEurekaExtraInformation = packed record
    EurekaVersion: Word;
    CompilationDate: TDateTime;
    Options: TEurekaModuleOptions;
    DebugInformation: TMemoryStream;
  end;

  TEurekaModuleInfo = packed record
    Handle: THandle;
    Name, Description, Version: string;
    Size: DWord;
    FunctionsList: TEurekaFunctionsList;
    ModuleType: TEurekaModuleType;
    ExtraInformation: TEurekaExtraInformation;
    OtherDebugData: TELDebugInfoSource;
    LastModified: TDateTime;
    EncryptPassword: string;
    IsValidEncryptPassword: Boolean;
  end;
  PEurekaModuleInfo = ^TEurekaModuleInfo;

  TEurekaProcessInfo = packed record
    ProcessID: DWord;
    Name, Description, Version: string;
    Priority, Memory, Threads: DWord;
  end;
  PEurekaProcessInfo = ^TEurekaProcessInfo;


  TBeginThreadFunc = function(Parameter: Pointer): Integer;
  TCreateThreadFunc = function(Parameter: Pointer): Integer; stdcall;

  TEurekaThreadInfo = packed record
    ID, Handle, CallerID: THandle;
    Priority: Integer;
    Thread: TThread;
    // Only for internal use...
    TopOfStack: DWord;
    ExecuteMethod: procedure(Thread: TThread);
    BeginThreadFunction: TBeginThreadFunc;
    CreateThreadFunction: TCreateThreadFunc;
    Parameter: Pointer;
    CallerStackSize: DWord;
    CallerStackDump: Pointer;
    IsACopy, ExceptionHandled: Boolean;
  end;
  PEurekaThreadInfo = ^TEurekaThreadInfo;

  TEurekaDebugInfo = packed record
    DebugDetail: TEurekaDebugDetail;
    ModuleInfo: PEurekaModuleInfo;
    ThreadID: DWord;
    RunningThread, ErrorLine, IsALeak: Boolean;
    LeakType: string[64];
    LeakSize, LeakCount: DWord;
    Addr: DWord;
    UnitName, ClassName, ProcedureName: string[64];
    Line, ProcOffsetLine: DWord;
  end;
  PEurekaDebugInfo = ^TEurekaDebugInfo;

  TEurekaFunctionInfo = packed record
    Name: string;
    Addr, Size: DWord;
  end;
  PEurekaFunctionInfo = ^TEurekaFunctionInfo;

  TEurekaStackList = class(TList)
  private
    function GetItem(Index: Integer): PEurekaDebugInfo;
  protected
  public
    destructor Destroy; override;
    procedure Delete(Index: Integer);
    procedure Clear;
{$IFDEF Delphi4Up} override;
{$ENDIF}
    procedure AddFrom(Source: PEurekaDebugInfo);
    property Items[Index: Integer]: PEurekaDebugInfo read GetItem; default;
  end;

  TEurekaModulesList = class(TList)
  private
    function GetItem(Index: Integer): PEurekaModuleInfo;
  protected
  public
    destructor Destroy; override;
    procedure Delete(Index: Integer);
    procedure Clear;
{$IFDEF Delphi4Up} override;
{$ENDIF}
    property Items[Index: Integer]: PEurekaModuleInfo read GetItem; default;
  end;

  TEurekaProcessesList = class(TList)
  private
    function GetItem(Index: Integer): PEurekaProcessInfo;
  protected
  public
    destructor Destroy; override;
    procedure Delete(Index: Integer);
    procedure Clear;
{$IFDEF Delphi4Up} override;
{$ENDIF}
    property Items[Index: Integer]: PEurekaProcessInfo read GetItem; default;
  end;

  TEurekaFunctionsList = class(TList)
  private
    function GetItem(Index: Integer): PEurekaFunctionInfo;
  protected
  public
    destructor Destroy; override;
    procedure Delete(Index: Integer);
    procedure Clear;
{$IFDEF Delphi4Up} override;
{$ENDIF}
    property Items[Index: Integer]: PEurekaFunctionInfo read GetItem; default;
  end;

  TEurekaExceptionRecord = packed record
    ExceptionObject: TObject;
    ExceptionAddress: Pointer;
    ExceptionThreadID: DWord;
    LogText: string;
    ModulesList: TEurekaModulesList;
    CallStack: TEurekaStackList;
    CurrentModuleOptions: TEurekaModuleOptions;
  end;

  TModuleInfo = packed record
    dwSize: DWORD;
    th32ModuleID: DWORD;  // This module
    th32ProcessID: DWORD; // owning process
    GlblcntUsage: DWORD;  // Global usage count on the module
    ProccntUsage: DWORD;  // Module usage count in th32ProcessID's context
    modBaseAddr: DWORD;   // Base address of module in th32ProcessID's context
    modBaseSize: DWORD;   // Size in bytes of module starting at modBaseAddr
    hModule: HMODULE;     // The hModule of this module in th32ProcessID's context
    szModule: array[0..MAX_MODULE_NAME32] of Char;
    szExePath: array[0..MAX_PATH - 1] of Char;
  end;

  TExceptionNotifyProc =
    procedure(EurekaExceptionRecord: TEurekaExceptionRecord; var Handled: Boolean);

  TEurekaActionType = (atShowingExceptionInfo, atShowedExceptionInfo,
    atSavingLogFile, atSavedLogFile, atSendingEmail, atSentEmail,
    atSendingWebMessage, atSentWebMessage, atTerminating);

  TExceptionActionProc = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    EurekaAction: TEurekaActionType; var Execute: Boolean);

  TExceptionErrorProc = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    EurekaAction: TEurekaActionType; var Retry: Boolean);

  TPasswordRequestProc = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    var Password: string);

  TCustomDataRequestProc = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    DataFields: TStrings);

  TAttachedFilesRequestProc = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    AttachedFiles: TStrings);

  TCustomWebFieldsRequestProc = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    WebFields: TStrings);

  TCustomButtonClickProc = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    var CloseDialog: Boolean);

  EFrozenApplication = class(Exception);
  EMemoryLeak = class(Exception);
  EMemoryOverrun = class(EMemoryLeak);
  EMultiFree = class(EMemoryLeak);
  EEurekaLogGeneralError = class(Exception);

  TEurekaLogErrorCode = (eeNone, eeShowError, eeLogError, eeEmailMAPIError,
    eeEmailShellError, eeEmailSMTPError, eeWebHTTPError, eeWebHTTPSError,
    eeWebFTPError, eeWebTrakerError);

  TExceptionNotify =
    procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    var Handled: Boolean) of object;

  TExceptionActionNotify = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    EurekaAction: TEurekaActionType; var Execute: Boolean) of object;

  TExceptionErrorNotify = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    EurekaAction: TEurekaActionType; var Retry: Boolean) of object;

  TPasswordRequestNotify = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    var Password: string) of object;

  TCustomDataRequestNotify = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    DataFields: TStrings) of object;

  TAttachedFilesRequestNotify = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    AttachedFiles: TStrings) of object;

  TCustomWebFieldsRequestNotify = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    WebFields: TStrings) of object;

  TCustomButtonClickNotify = procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    var CloseDialog: Boolean) of object;

  TEurekaLog = class(TComponent)
  private
    FExceptionNotify, FHandledExceptionNotify: TExceptionNotify;
    FExceptionActionNotify: TExceptionActionNotify;
    FExceptionErrorNotify: TExceptionErrorNotify;
    FPasswordRequest: TPasswordRequestNotify;
    FCustomDataRequest: TCustomDataRequestNotify;
    FAttachedFilesRequest: TAttachedFilesRequestNotify;
    FCustomWebFieldsRequest: TCustomWebFieldsRequestNotify;
    FCustomButtonClickNotify: TCustomButtonClickNotify;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnExceptionNotify: TExceptionNotify
      read FExceptionNotify write FExceptionNotify;
    property OnHandledExceptionNotify: TExceptionNotify
      read FHandledExceptionNotify write FHandledExceptionNotify;
    property OnExceptionActionNotify: TExceptionActionNotify
      read FExceptionActionNotify write FExceptionActionNotify;
    property OnExceptionErrorNotify: TExceptionErrorNotify
      read FExceptionErrorNotify write FExceptionErrorNotify;
    property OnPasswordRequest: TPasswordRequestNotify
      read FPasswordRequest write FPasswordRequest;
    property OnCustomDataRequest: TCustomDataRequestNotify
      read FCustomDataRequest write FCustomDataRequest;
    property OnAttachedFilesRequest: TAttachedFilesRequestNotify
      read FAttachedFilesRequest write FAttachedFilesRequest;
    property OnCustomWebFieldsRequest: TCustomWebFieldsRequestNotify
      read FCustomWebFieldsRequest write FCustomWebFieldsRequest;
    property OnCustomButtonClickNotify: TCustomButtonClickNotify
      read FCustomButtonClickNotify write FCustomButtonClickNotify;
  end;

  EurekaLogNotPresents = class(Exception);

{$IFDEF DUNIT}
  TRaiserType = (rtUnknown, rtLocal, rtWeb);
  TAsynchronousException = (aeNone, aeSafeCall, aeSynchronize);
{$ELSE}
{$IFDEF CBuilder}
  TRaiserType = (rtUnknown, rtLocal, rtWeb);
{$ENDIF}
{$ENDIF}
  PCardinal = ^Cardinal;

var
  ExceptionNotify: TExceptionNotifyProc;
  HandledExceptionNotify: TExceptionNotifyProc;
  ExceptionActionNotify: TExceptionActionProc;
  ExceptionErrorNotify: TExceptionErrorProc;
  PasswordRequest: TPasswordRequestProc;
  CustomDataRequest: TCustomDataRequestProc;
  AttachedFilesRequest: TAttachedFilesRequestProc;
  CustomWebFieldsRequest: TCustomWebFieldsRequestProc;
  CustomButtonClickNotify: TCustomButtonClickProc;
  ShowEurekaLogUnits: Boolean = False;

procedure StartAntiFreeze;
procedure EndAntiFreeze;
procedure SetEurekaLogState(Activate: Boolean);
procedure SetEurekaLogInThread(ThreadID: DWord; Activate: Boolean);
function GetCompilationDate(HModule: THandle; LocalTime: Boolean; var Date: TDateTime): Boolean;
function IsEurekaLogActive: Boolean;
function IsEurekaLogActiveInThread(ThreadID: DWord): Boolean;
function IsEurekaLogInstalled: Boolean;
function CurrentEurekaLogOptions: TEurekaModuleOptions;
function StandardEurekaNotify(Obj: TObject; Addr: pointer): Boolean;
procedure ShowLastExceptionData;
function GetLastExceptionAddress: Pointer;
function GetLastExceptionObject: TObject;
function StandardEurekaError(const Error: string): Boolean;
function ForceApplicationTermination(TrmType: TTerminateBtnOperation): Boolean;
function GetLastEurekaLogErrorCode: TEurekaLogErrorCode;
function GetLastEurekaLogErrorMsg: string;
function GetCurrentCallStack: TEurekaStackList;
function GetLastExceptionCallStack: TEurekaStackList;
function GetCallStackByLevels(StartLevel, LevelsNumber: Integer): TEurekaStackList;
procedure CallStackToStrings(CallStack: TEurekaStackList; Strings: TStrings);
function IsEurekaLogModule(HModule: THandle): Boolean;
function GetEurekaLogModuleVersion(HModule: THandle): Word;
procedure SetCustomErrorMessage(const Value: string);
procedure CallEurekaLogFromActiveX(ExceptionType, ExceptionMessage, CallStack: string);
{$IFDEF PROFESSIONAL}
function EurekaLogSendEmail(const AMailTo, ASubject, ABody, AAttachments: string): Boolean;
procedure SaveScreenshot(const Filename: string);
procedure SaveScreenshotToStream(Stream: TStream);
function GenerateHTML(const Text: string; AddOKButton: Boolean): string;
{$ENDIF}
// Warning!!! - Don't remove this declarations (used to store SymbolInfo)...
procedure HookedRaise;
procedure HookedRtlUnwind;
function HookedWriteFile(hFile: Integer; const Buffer; nNumberOfBytesToWrite: Cardinal;
  var lpNumberOfBytesWritten: Cardinal; lpOverlapped: Pointer): Integer; stdcall;
function HookedCreateThread(lpThreadAttributes: Pointer; dwStackSize: DWORD;
  lpStartAddress: TFNThreadStartRoutine; lpParameter: Pointer;
  dwCreationFlags: DWORD; lpThreadId: PDWord): DWord; stdcall;
function HookedResumeThread(hThread: DWord): DWORD; stdcall;
procedure HookedExitThread(dwExitCode: DWORD); stdcall;
{$IFDEF CBuilder}
function HookedUnhandledExceptionFilter(ExceptionPointers: Pointer): DWord; stdcall;
procedure EurekaLog_CallCreateThread(PData: PEurekaThreadInfo);
procedure EurekaLog_CallResumeThread(hThread: DWord; PData: PEurekaThreadInfo);
procedure EurekaLog_CallExitThread;
function EurekaLog_CallExceptObject(P: PExceptionRecord; C: PContext;
  CallGoNotify: Boolean): Exception;
procedure EurekaLog_CallGeneralRaise(Code, Flags, NArgs: DWord; Args: Pointer; Stack: DWord);
function ExceptionManager(Obj: TObject; Addr: Pointer;
  RaiserType: TRaiserType; ModuleHandle: THandle): Boolean;
procedure EurekaLog_PasswordRequestEvent(var Pwd: ShortString);
procedure EurekaLog_PasswordRequestEventEx(EurekaExceptionRecord: TEurekaExceptionRecord;
  var Pwd: ShortString);
procedure EurekaLog_ExceptionNotifyEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  var Handled: Boolean);
  procedure EurekaLog_HandledExceptionNotifyEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  var Handled: Boolean);
procedure EurekaLog_ExceptionActionNotifyEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  EurekaAction: TEurekaActionType; var Execute: Boolean);
procedure EurekaLog_ExceptionErrorNotifyEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  EurekaAction: TEurekaActionType; var Retry: Boolean);
procedure EurekaLog_CustomDataRequestEventEx(EurekaExceptionRecord: TEurekaExceptionRecord;
  DataFields: TStrings);
procedure EurekaLog_AttachedFilesRequestEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  AttachedFiles: TStrings);
procedure EurekaLog_CustomWebFieldsRequestEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  WebFields: TStrings);
procedure EurekaLog_CustomButtonClickEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  var CloseDialog: Boolean);
{$ENDIF}
{$IFDEF DUNIT}
function ExceptNotify(Obj: TObject; Addr: Pointer;
  DelphiException: Boolean; TopOfStack, StackPoint: DWord;
  Context: PContext; RaiserType: TRaiserType; ModuleHandle: DWord;
  AsynchronousException: TAsynchronousException; Handled: Boolean;
  CallStack: TEurekaStackList): Boolean;
{$ENDIF}
function FastMM_LogStackTrace(AReturnAddresses: PCardinal; AMaxDepth: Cardinal;
  ABuffer: PChar; ShowDLLsFunctions, ShowBPLsFunctions, ShowProcLineOffset: Boolean): PChar;

implementation

uses
  {$IFDEF Delphi4Up} SysConst, {$ENDIF} ShellAPI, WinSock, TypInfo, EConsts,
  ETypes, EHook, ELang, ESockets, EZLib, EEncrypt, EBase64, EZip, EWebTools,
  ELogManager, EListView, EHash, EDisAsm, WinSpool;

{$R DIALOG.RES}

const
  MaxCallStackSize = (1024 * 100); // 100Kb of max call stack analysis

  MaxCompressedCopies = 10;

  TH32CS_SNAPHEAPLIST = $00000001;
  TH32CS_SNAPPROCESS  = $00000002;
  TH32CS_SNAPTHREAD   = $00000004;
  TH32CS_SNAPMODULE   = $00000008;

  THREAD_SUSPEND_RESUME = $0002;
  THREAD_GET_CONTEXT = $0008;
  THREAD_QUERY_INFORMATION =$0040;
  THREAD_MY_ACCESS = THREAD_SUSPEND_RESUME or THREAD_GET_CONTEXT or THREAD_QUERY_INFORMATION;
  THREAD_PRIORITY_UNDEFINED = Low(Integer);

  cContinuable        = 0;
  cNonContinuable     = 1;
  cUnwinding          = 2;
  cExceptionCode0     = $C0000005;
  cExceptionCode1     = $C000013A;
  cDelphiException    = $0EEDFADE;
  cNonDelphiException = $0EEDFAE4;

{$IFDEF CBuilder}
  cBCBExceptionFlag = $C0000025;
{$ENDIF}

  // OLE objects messages.
  //------------------------
  EVENT_OBJECT_SHOW = $8002;
  EVENT_OBJECT_HIDE = $8003;
  //------------------------

  // Controls Messages.
  //------------------------
  CM_BASE = $B000;
  CM_RELEASE = CM_BASE + 33;
  //------------------------

  MessageBoxFlags = (MB_TOPMOST or MB_TASKMODAL or MB_SERVICE_NOTIFICATION);

  JavaScriptOKButton = '<br><input type=button value="Ok" OnClick="history.go(-1)" ' +
    'style="width:75;height:25;z-index:100;font-style:normal;font-size:10pt;text-decoration:none;">';

  // ---------------------------------------------------------------------------
  // - EurekaLog Dialog consts...                                              -
  // ---------------------------------------------------------------------------
  ID_ICON = 100; //                 Icon ID.
  ID_TEXT = 101; //                 'Text' (Up) Label ID.
  ID_INFORMATION = 102; //          'Information' (Down) Label ID.
  ID_LISTMEMO = 103; //             Memo ID.
  ID_BUTTON = 2; //                 'OK' Button ID.
  ID_TERMINATE = 3; //              'Terminate' Button ID.
  ID_DETAILS = 4; //                'Terminate' Button ID.
  ID_CUSTOM = 5; //                 'Custom' Button ID.
  ID_PAGE = 1000; //                PageControl ID.
  ID_LINE = 2000; //                Line separator ID
  ID_EMAIL = 3000; //               Email check box ID
  ID_SCREEN = 4000; //              Email screenshot ID
  ID_COPY = 5000; //                Copy to clipboard ID
  DialogName = 'EL_Dialog'; //      Dialog's Resource name (into .RES file).

  ID_MS_Label = 102;
  ID_MS_Error = 103;
  ID_MS_Restart = 104;
  ID_MS_Please = 105;
  ID_MS_Created = 106;
  ID_MS_SeeReport = 107;
  ID_MS_ReproduceLabel = 108;
  ID_MS_ReproduceMemo = 109;
  ID_MS_EmailLabel = 110;
  ID_MS_EmailEdit = 111;
  ID_MS_SendBtn = 1000;
  ID_MS_NoSendBtn = 1001;
  ID_MS_CustomBtn = 1002;
  ID_MS_ErrorBmp = 50;
  DialogMSName = 'EL_MS_Dialog'; // Dialog's Resource name (into .RES file).
  
  ServerDialogName = 'EL_Server'; // Server Dialog's Resource name (into .RES file).
  ID_ServerLabel = 100; //           Server Label ID.
  ID_ServerBar = 101; //             Server Bar ID.
  ID_ServerButton = 102; //          Server Button ID.

  RequestDialogName = 'EL_Request'; // Request Dialog's Resource name (into .RES file).
  ID_RequestLabel = 100; //            Request Label ID.
  ID_RequestMemo = 101; //             Request Memo ID.
  ID_RequestBtn = 2; //                Request OK Button ID.

  ID_Error = 'EL_Error';
  ID_Send = 'EL_Send';
  ID_TabGeneral = 'EL_TAB_GENERAL';
  ID_TabCallStack = 'EL_TAB_CALLSTACK';
  ID_TabModulesList = 'EL_TAB_MODULESLIST';
  ID_TabProcessesList = 'EL_TAB_PROCESSESLIST';
  ID_TabAssembler = 'EL_TAB_ASSEMBLER';
  ID_TabCPU = 'EL_TAB_CPU';

  // ---------------------------------------------------------------------------

  // Dialog API consts...
  TCIF_TEXT = $0001;
  TCM_FIRST = $1300; { Tab control messages }
  TCM_INSERTITEM = TCM_FIRST + 7;
  TCM_GETCURSEL = TCM_FIRST + 11;
  TCM_SETCURSEL = TCM_FIRST + 12;
  TCM_ADJUSTRECT = TCM_FIRST + 40;
  TCN_FIRST = 0 - 550; { tab control }
  TCN_SELCHANGE = TCN_FIRST - 1;
  LVS_EX_FULLROWSELECT = $00000020; // applies to report mode only
  LVNI_ALL = $0000;
  LVNI_SELECTED = $0002;
  PBM_SETPOS = WM_USER + 2;
  MY_CLOSE = WM_USER + 1234;

  NM_AFTERCLICK = Integer($FFFFFFFE);
  NM_DBLCLK = Integer($FFFFFF8E);

  // To prevent to assign the MessageBox child dialog...
  // to an potentially unstable Window parent.
  MsgBoxhWnd = 0;

  RTFHeader =
    '{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fmodern\fprq1\fcharset%d %s;}}'#13#10+
    '{\colortbl ;\red0\green100\blue100;\red0\green0\blue0;\red40\green40\blue40;' +
    '\red0\green0\blue160;\red160\green0\blue0;\red80\green80\blue80;' +
    '\red0\green100\blue0;}'#13#10;
  RTFFooter = '}';

  // WARNING!!!
  // ----------
  // Must use ShortStrings because the AnsiStrings are automatically freeded
  // before the Leaks handling (cause the finalizations calling).
  EurekaLogUnits: array[0..37] of string[32] =
    ('EAbout.pas', 'EBase64.pas', 'EBaseModule.pas', 'EBorlandDebug.pas',
    'ECheck.pas', 'ECmdLine.pas', 'ECommon.pas', 'EConsts.pas', 'ECore.pas',
    'ECrc32.pas', 'EDebug.pas', 'EDesign.pas', 'EDisAsm.pas', 'EEncrypt.pas',
    'EHash.pas', 'EHook.pas', 'EIDEOptions.pas', 'ELang.pas', 'ELeaks.pas',
    'EListView.pas', 'ELogManager.pas', 'EMain.pas', 'EMessages.pas',
    'ENagScreen.pas', 'EOption.pas', 'EParser.pas', 'EResource.pas',
    'ESockets.pas', 'EToolsAPI.pas', 'EToolServices.pas', 'ETypes.pas',
    'EVariables.pas', 'EWait.pas', 'EWebTools.pas', 'ExceptionLog.pas',
    'EXMLBuilder.pas', 'EZip.pas', 'EZlib.pas');

  ReadError = $0001;
  EM_STREAMIN = WM_USER + 73;
  EM_SETBKGNDCOLOR = WM_USER + 67;
  SF_RTF = $0002;

  HandledCacheSize = 10; // Handled exceptions cache size.

type
{$IFNDEF DUNIT}
{$IFNDEF CBuilder}
  TRaiserType = (rtUnknown, rtLocal, rtWeb);
{$ENDIF}
  TAsynchronousException = (aeNone, aeSafeCall, aeSynchronize);
{$ENDIF}

  TShowType = (stGUI, stConsole, stWeb);

  TInternalProc = procedure;

  TEditStream = packed record
    dwCookie, dwError: Integer;
    pfnCallback: Pointer;
  end;

  TGetServerVariableProc = function(hConn: THandle;
    VariableName: PChar;
    Buffer: Pointer;
    var Size: DWORD): BOOL; stdcall;

  TWriteClientProc = function(ConnID: THandle;
    Buffer: Pointer;
    var Bytes: DWORD;
    dwReserved: DWORD): BOOL; stdcall;

  TReadClientProc = function(ConnID: THandle;
    Buffer: Pointer;
    var Size: DWORD): BOOL; stdcall;

  TServerSupportFunctionProc = function(hConn: THandle;
    HSERRequest: DWORD;
    Buffer: Pointer;
    Size: LPDWORD;
    DataType: LPDWORD): BOOL; stdcall;

  PEXTENSION_CONTROL_BLOCK = ^TEXTENSION_CONTROL_BLOCK;
  TEXTENSION_CONTROL_BLOCK = packed record
    cbSize: DWORD; // size of this struct.
    dwVersion: DWORD; // version info of this spec
    ConnID: THandle; // Context number not to be modified!
    dwHttpStatusCode: DWORD; // HTTP Status code
    // null terminated log info specific to this Extension DLL
    lpszLogData: array[0..79] of Char;
    lpszMethod: PChar; // REQUEST_METHOD
    lpszQueryString: PChar; // QUERY_STRING
    lpszPathInfo: PChar; // PATH_INFO
    lpszPathTranslated: PChar; // PATH_TRANSLATED
    cbTotalBytes: DWORD; // Total bytes indicated from client
    cbAvailable: DWORD; // Available number of bytes
    lpbData: Pointer; // pointer to cbAvailable bytes
    lpszContentType: PChar; // Content type of client data

    GetServerVariable: TGetServerVariableProc;
    WriteClient: TWriteClientProc;
    ReadClient: TReadClientProc;
    ServerSupportFunction: TServerSupportFunctionProc;
  end;

  TStackFrame = packed record
    Push: Byte;
    Mov: Word;
  end;
  PStackFrame = ^TStackFrame;

  TExceptObjProc = function(P: PExceptionRecord): Exception;

  TExceptProc = procedure(ExceptObject: TObject; ExceptAddr: Pointer);

  TExceptionType = (etUnknown, etHandleAnyException, etHandleOnException,
    etHandleAutoException);

  TExceptionTypes = set of TExceptionType;

  THModuleStream = class(TMemoryStream)
  public
    constructor Create(HModule: THandle);
    destructor Destroy; override;
    function SecureRead(var Buffer; Count: Integer): Boolean;
  end;

  // Used to can access to the protected data...
  TInternalThread = class(TThread)
  end;

{$IFDEF Delphi3}
  TAsymmetricCriticalSection = class
  private
    FLock: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginRead;
    procedure EndRead;
    procedure BeginWrite;
    procedure EndWrite;
  end;
{$ELSE}
  TAsymmetricCriticalSection = TMultiReadExclusiveWriteSynchronizer;
{$ENDIF}

  TEurekaThreadsList = class(TList)
  private
    FLock: TAsymmetricCriticalSection;
    FSimpleCopy: Boolean;
    function GetItem(Index: Integer): PEurekaThreadInfo;
  protected
  public
    constructor Create(CopyList: TEurekaThreadsList);
    destructor Destroy; override;
    procedure RemoveCurrentThread;
    procedure BeginRead;
    procedure EndRead;
    procedure BeginWrite;
    procedure EndWrite;
    procedure Delete(Index: Integer);
    procedure Clear; {$IFDEF Delphi4Up} override; {$ENDIF}
    procedure PurgeList;
    function FindByThreadID(ThreadID: THandle): Integer;
    function FindByThreadHandle(Handle: THandle): Integer;
    function FindByThreadObject(Thread: TThread): Integer;
    function NewItem(AddNow: Boolean): PEurekaThreadInfo;
    function CallUnhandledException: Boolean;
    procedure SetExceptionType(ThreadID: THandle; Handled: Boolean);

    property Items[Index: Integer]: PEurekaThreadInfo read GetItem; default;
  end;

  TSafeObject = class(TObject)
    function GetSafeCall: DWord; safecall;
  end;

  TExceptNotifyParams = packed record
    Handled: Boolean;
    Context: PContext;
    CallStack: TEurekaStackList;
    TopOfStack, StackPoint, ThreadID: DWord;
    ActiveControlClass, ActiveControlText: string;
  end;

  TExceptionThread = class(TThread)
  protected
    FExecuting: Boolean;
    FResult: Boolean;
    FObj: TObject;
    FAddr: Pointer;
    FDelphiException: Boolean;
    FParams: TExceptNotifyParams;
    FRaiserType: TRaiserType;
    FModuleHandle: THandle;
    FAsynchronousException: TAsynchronousException;
  public
    constructor Create(Obj: TObject; Addr: Pointer; DelphiException: Boolean;
      Params: TExceptNotifyParams; RaiserType: TRaiserType; ModuleHandle: THandle;
      AsynchronousException: TAsynchronousException);
    procedure Execute; override;

    property Result: Boolean read FResult;
    property Executing: Boolean read FExecuting;
  end;

  TFreezeThread = class(TThread)
  public
    constructor Create; virtual;
    procedure Execute; override;
  end;

  TEurekaModuleOptionsEx = class(TEurekaModuleOptions)
  protected
    procedure SetActive(const Value: Boolean); override;
    procedure SetFreezeActivate(const Value: Boolean); override;
    procedure StoreSharedData; override;
  end;

  ImageSectionHeader = record
    Name: array[0..7] of Char;
    VirtualSize: Integer;
    VirtualAddress: Integer;
    SizeOfRawData: Integer;
    PointerToRawData: Integer;
    UnUsed: array[0..15] of byte; // UnUsed information...
  end;

  PEExportImage = record
    Characteristics: Integer;
    UnUsed: array[0..7] of byte; // UnUsed information...
    Name: Integer;
    Base: Integer;
    NumberofFunctions: Integer;
    NumberofNames: Integer;
    AddressOfFunctions: Integer;
    AddressOfNames: Integer;
    AddressOfNameOrdinals: Integer;
  end;

  PThreadRec = ^TThreadRec;
  TThreadRec = record
    Func: TThreadFunc;
    Parameter: Pointer;
  end;

  TCallRec = packed record
    OpCode: Byte;
    Distance: DWord;
  end;
  PCallRec = ^TCallRec;

  TRedirectOpCodes = packed record
    Push: byte;
    Index: DWord;
    JMPOpCode: byte;
    JMPDistance: DWord;
  end;

  PExcArgs = ^TExcArgs;
  TExcArgs = packed record
    Addr: Pointer; // EDX
    Obj: TObject; // EAX
    EBX, ESI, EDI, EBP, ESP: DWord; // Registers.
  end;

  PExceptionPointers = ^TExceptionPointers;
  TExceptionPointers = packed record
    ExceptionRecord: PExceptionRecord;
    Context: PContext;
  end;

  PExcFrame = ^TExcFrame;
  TExcFrame = record
    next: PExcFrame;
    desc: Pointer;
    hEBP: Pointer;
    case Integer of
    0:  ( );
    1:  ( ConstructedObject: Pointer );
    2:  ( SelfOfMethod: Pointer );
  end;

  PRaiseFrame = ^TRaiseFrame;
  TRaiseFrame = packed record
    NextRaise: PRaiseFrame;
    ExceptAddr: Pointer;
    ExceptObject: TObject;
    ExceptionRecord: PExceptionRecord;
  end;

  PPointer = ^Pointer;
  PBoolean = ^Boolean;

  TFinalizationsArray = array[0..9999999] of pointer;
  PFinalizationsArray = ^TFinalizationsArray;

  PMapiFileDesc = ^TMapiFileDesc;
  MapiFileDesc = packed record
    ulReserved: Cardinal; { Reserved for future use (must be 0)     }
    flFlags: Cardinal; { Flags                                   }
    nPosition: Cardinal; { character in text to be replaced by attachment }
    lpszPathName: LPSTR; { Full path name of attachment file       }
    lpszFileName: LPSTR; { Original file name (optional)           }
    lpFileType: Pointer; { Attachment file type (can be lpMapiFileTagExt) }
  end;
  TMapiFileDesc = MapiFileDesc;

  PMapiRecipDesc = ^TMapiRecipDesc;
  MapiRecipDesc = packed record
    ulReserved: Cardinal; { Reserved for future use                  }
    ulRecipClass: Cardinal; { Recipient class                          }
    { MAPI_TO, MAPI_CC, MAPI_BCC, MAPI_ORIG    }
    lpszName: LPSTR; { Recipient name                           }
    lpszAddress: LPSTR; { Recipient address (optional)             }
    ulEIDSize: Cardinal; { Count in bytes of size of pEntryID       }
    lpEntryID: Pointer; { System-specific recipient reference      }
  end;
  TMapiRecipDesc = MapiRecipDesc;

  PMapiMessage = ^TMapiMessage;
  MapiMessage = packed record
    ulReserved: Cardinal; { Reserved for future use (M.B. 0)       }
    lpszSubject: LPSTR; { Message Subject                        }
    lpszNoteText: LPSTR; { Message Text                           }
    lpszMessageType: LPSTR; { Message Class                          }
    lpszDateReceived: LPSTR; { in YYYY/MM/DD HH:MM format             }
    lpszConversationID: LPSTR; { conversation thread ID                 }
    flFlags: Cardinal; { unread,return receipt                  }
    lpOriginator: PMapiRecipDesc; { Originator descriptor                  }
    nRecipCount: Cardinal; { Number of recipients                   }
    lpRecips: PMapiRecipDesc; { Recipient descriptors                  }
    nFileCount: Cardinal; { # of file attachments                  }
    lpFiles: PMapiFileDesc; { Attachment descriptors                 }
  end;
  TMapiMessage = MapiMessage;

  TFNMapiLogOn = function(ulUIParam: Cardinal; lpszProfileName: LPSTR;
    lpszPassword: LPSTR; flFlags: Cardinal; ulReserved: Cardinal;
    lplhSession: Pointer): Cardinal; stdcall;

  TFNMapiLogOff = function(lhSession: Cardinal; ulUIParam: Cardinal;
    flFlags: Cardinal; ulReserved: Cardinal): Cardinal; stdcall;

  TFNMapiSendMail = function(lhSession: Cardinal; ulUIParam: Cardinal;
    var lpMessage: TMapiMessage; flFlags: Cardinal;
    ulReserved: Cardinal): Cardinal; stdcall;

  // IntraWeb ShowMessage type...
  TIWShowMessageType = (smAlert, smNewWindow, smSameWindow, smSameWindowFrame);

{$IFDEF PROFESSIONAL}
  TSendDialogThread = class(TThread)
  private
    FModal: Boolean;
  public
    constructor Create(Modal: Boolean);
    procedure Execute; override;
  end;

  TSendObject = class
    class procedure OnSent(Sender: TObject; BytesSent, TotalBytes: Integer);
  end;

  TSendRecord = packed record
    Dialog: THandle;
    Showed: Boolean;
    SendDialogThread: TSendDialogThread;
    MsgNum, MsgTot, TotalBytes: Integer;
  end;

  TSendThread = class(TThread)
  public
    procedure Execute; override;
  end;
{$ENDIF}

  PHeaderData = ^THeaderData;
  THeaderData = packed record
    Width, Height: DWord;
    BitDepth,
    ColorType,
    CompressionMethod,
    FilterMethod,
    InterlaceMethod: Byte;
  end;

  TZStreamRec2 = packed record
    ZLIB: TZStreamRec;
    Data: Pointer;
    fStream: TStream;
  end;

  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;

  TEurekaLogList = class(TList)
  private
    function GetItem(Index: Integer): TEurekaLog;
  protected
  public
    property Items[Index: Integer]: TEurekaLog read GetItem; default;
  end;

  TInHTTPResponseInfo = class
  protected
    FUnUsed: array[0..31] of Byte;
    FContentType: string;
    //...
  end;

  TInHTTPAppResponse = class(TObject)
  protected
    FContentStream: TStream;
    FCookies: TObject;
    FCustomHeaders: TStrings;
    FHTTPRequest: TObject;
    FContent: String;
    FRequestInfo: TObject;
    FResponseInfo: TInHTTPResponseInfo;
    FSent: Boolean;
    FThread: TThread;
  end;

  TIdThreadStopMode = (smTerminate, smSuspend);

  TIdExceptionEvent = procedure(Sender: TObject; E: Exception) of object;

  TIdThread = class(TThread)
  protected
    FData: TObject;
    FStopMode: TIdThreadStopMode;
    FStopped: Boolean;
    FTerminatingException: string;
    FOnException: TIdExceptionEvent;
  public
    class procedure HandledException(Sender: TObject; E: Exception);
  end;

  THandledCacheItem = record
    // Input fields...
    ObjClass: TClass;
    Address: Pointer;
    ExceptionFrames: Pointer;
    // Output fields...
    Handled: Boolean;
    FrameCount: Integer;
    AsynchronousException: TAsynchronousException;
    FirstExceptionType: TExceptionType;
  end;

  THandledCache = array [0..HandledCacheSize - 1] of THandledCacheItem;

  THTTPConnection = class(THTTPConnectionBase)
  public
    procedure SetSendState(ASendState: TSendState; APercent: Integer); override;
  end;

  TActiveXException = class(Exception)
  private
    FExceptionType: string;
  public
    constructor Create(const ExceptionType, ExceptionMessage: string);
  property
    ExceptionType: string read FExceptionType;
  end;

const
{$IFDEF PROFESSIONAL}
  UnAttachableThreads: array [0..3] of TClass =
    (TExceptionThread, TFreezeThread, TSendDialogThread, TSendThread);
{$ELSE}
  UnAttachableThreads: array [0..1] of TClass =
    (TExceptionThread, TFreezeThread);
{$ENDIF}
  CannotProcessMessagesExceptions: array [0..0] of TClass = (EStackOverflow);

var
{$IFDEF CBuilder}
  Kernel_UnhandledExceptionFilter:
  function(ExceptionPointers: PExceptionPointers): DWord; stdcall;
{$ENDIF}
  Kernel_RaiseException: procedure(dwExceptionCode, dwExceptionFlags,
    nNumberOfArguments: DWORD; lpArguments: PDWORD); stdcall;
  Kernel_RtlUnwind: procedure;
  Kernel_CreateThread: function(lpThreadAttributes: Pointer; dwStackSize: DWORD;
    lpStartAddress: TFNThreadStartRoutine; lpParameter: Pointer;
    dwCreationFlags: DWORD; lpThreadId: PDWord): THandle; stdcall;
  Kernel_ResumeThread: function(hThread: THandle): DWORD; stdcall;
  Kernel_ExitThread: procedure(dwExitCode: DWORD); stdcall;
  Kernel_WriteFile: function(hFile: Integer; const Buffer; nNumberOfBytesToWrite: Cardinal;
    var lpNumberOfBytesWritten: Cardinal; lpOverlapped: Pointer): Integer; stdcall;
  ISAPI_HttpExtensionProc: function(var ECB: PEXTENSION_CONTROL_BLOCK): DWORD; stdcall;
  ISAPI_WriteClientProc: TWriteClientProc;
  ISAPI_Proc: Pointer;
  ServerECB: PEXTENSION_CONTROL_BLOCK;
  ISAPI_SendError: Boolean = False;
  ExceptionCriticalSection: TRTLCriticalSection;
  ModulesList: TEurekaModulesList = nil;
  ProcessesList: TEurekaProcessesList = nil;
  OldExceptProc: procedure;
  CurrentStackList: TEurekaStackList = nil;
  LeaksStackList: TEurekaStackList = nil;
  ThreadsList: TEurekaThreadsList;
  StartingDate: TDateTime;
  Initialized: Boolean = False;
  OldExceptObjProc: TExceptObjProc;
  CurrentOptions: TEurekaModuleOptions;
  CGIOutputFile, LanguageStr: string;
  ExceptionNumber: integer;
  HandleAnyExceptionAddr_Variable, HandleOnExceptionAddr_Variable,
    HandleAutoExceptionAddr_Variable: DWord;
  TerminateApplication: Boolean;
{$IFNDEF CBuilder}
  LastInitializationPtr, LastFinalizationPtr: procedure;
{$ENDIF}
  IntraWeb_CreateServer: function(Self, Owner: TObject): TObject;
  IntraWeb_OnException_Old: procedure(Self, AApplication: TObject; AException: Exception);
  IntraWeb_OnException_New: procedure(Self, AApplication: TObject; AException: Exception;
    Var Handled: Boolean);
  Indy_OnException: TIdExceptionEvent;
  IntraWeb_ShowMessage: procedure(Self: TObject; AMsg: string;
    const AType: TIWShowMessageType; ATemplate: string);
  IntraWeb_SendResponse: procedure(Self: TInHTTPAppResponse);
  VCLHandleException: procedure(Self, Sender: TObject);
  VCLShowException: procedure(Self: TObject; Error: Exception);
  NTService_LogMessage: procedure(Self: TObject; Message: string; EventType: DWord;
    Category: Integer; ID: Integer);
  IndyThread_HandleException: procedure(Self: TObject; AException: Exception);
  DoneExcept: procedure;
{$IFDEF Delphi5Down}
  ISAPIHandleException_D5Down:
  procedure(E: TObject; var ECB: TEXTENSION_CONTROL_BLOCK);
  CGIHandleException_D5Down: procedure(E: TObject; const OutputFile: string);
{$ELSE}
  CGIHandleException, ISAPIHandleException: procedure(Self, Sender: TObject);
  CLXHandleException: procedure(Self, Sender: TObject);
  CLXShowException: procedure(Self: TObject; Error: Exception);
{$ENDIF}
  LastHTMLPage: string;
  LastInitPointer: PPointer;
  IntoInitialization, IntoFinalization: boolean;
  OriginalThreadProc: TThreadFunc;
  IntraWebApplication, IntraWebServerController: TObject;
  IntraWebCompressedPage: Boolean;
  IntraWeb_Version: string;
  IntraWeb_NewEvent: Boolean;
  CurrentAsmErrorLine: string;
  CurrentGeneralErrorText, CurrentAsmErrorText, CurrentCPUErrorText: string;
  OnlySafeCallExceptions, CanHookLibraries: Boolean;
  FreezeThread: TFreezeThread;
  MainThreadHandle: THandle;
  MainThreadTopOfStack: DWord;
  LastExceptionAddress: Pointer = nil;
  LastExceptionObject: TObject = nil;
  CriticalExceptObject: TObject = nil;
  LastExceptAddr, RaisedExceptAddr: Pointer;
  LastExceptThreadID: DWord;
  LastExceptObject: TObject;
  LastDelphiException: Boolean;
  LastExceptMessage, CustomExceptMessage: string;
  LastExceptionRecord: ^TEurekaExceptionRecord;
  LastExceptionLog: string;
  LastLog: string;
  CanSendError_Show, CanAttachScreenshot_Show, CanCopy_Show, CanSupport_Show,
    CanSendMessage, CanAttachScreenshot, CanCopy: Boolean;
  DuplicatedException: Boolean;
  StartDir: string;
  SynchronizeExcept, SynchronizeRaise: DWord;
  ThreadWrapperAddr: Pointer;
  InternalErrorCode: TEurekaLogErrorCode;
  InternalErrorMsg: string;
  EurekaLogList: TEurekaLogList;
  CurrentRequestValue: string;
  UserEmail: string;
  ThreadsCriticalSection: TRTLCriticalSection;
  InactiveThreads: TList;
  EurekaLogUnitsList: TStringList;
  ActivateEurekaLog: Boolean;
  NotLoadDebugInfo: Boolean; // Use to speed the Modules List creation.
  ModuleInfoHandle: THandle = 0;
  ModuleInfoData: Pointer;
  AutoCloseTimer: Integer;
  CurrentDialog: THandle;
  UseTopMost: Boolean;
  ExceptionsTime: TStringList;
  ExceptionTime: TDateTime;
  DbgSection: Integer; // For internal loging system.
  CurrentProcessWindowsList: TList;
  IndyHooked: Boolean;
  LastDumpCriticalSection: TRTLCriticalSection;
  LastExceptionThreadID: DWord;
  LastExceptionCallStackAddress: Pointer;
  LastExceptionCallStackSize: DWord;
  LastExceptionCallStackDump: Pointer;
  HandledCacheCount: Integer;
  HandledCache: THandledCache;
  HandledCacheCriticalSection: TRTLCriticalSection;
  DebugHook_Assigned: Boolean;
  LastExceptionType, LastExceptionMessage, LastBugID: string;
  DialogType: TExceptionDialogType;
  IsFilterDialog: Boolean;
  LeakTotalSize, LeakTotalCount: DWord;
  LeakAddr: Pointer;
  ManualAntiFreeze: Boolean;
  IDC_CURSOR: PAnsiChar;
  CannotUseThread: Boolean;
  NoSynchronizeEvent: Boolean;
  OutOfMemoryCache: Pointer;

  MultiFreeExceptionText: string = 'Multi Free memory leak';
  MemoryOverrunExceptionText: string = 'Memory Overrun leak';

  // The Global_xxx variables are used to call the "SynchronizeEvent" procedure.
  Global_Execute, Global_Handled, Global_Retry, Global_CloseDialog: Boolean;
  OldGlobal_ExceptionRecord, Global_ExceptionRecord: TEurekaExceptionRecord;
  MustFreeGlobalMappedObject: Boolean;
  Global_CurrentEvent: Pointer; // 4 bytes = ThreadSafe
  Global_IntoHandleException: LongBool = False; // 4 bytes = ThreadSafe
  Global_Password, Global_LastInitPassword: string;
  Global_AttachedFiles, Global_WebFields, Global_DataFields: TStrings;
  Global_Module: THandle;

  // Global variables...
  Global_IntraWebText, Global_WebTextID: string;
  Cached_LogFile: TLogFile;
  Opened_LogFile_Name: string = '';

  // Dialog variables...
  fDlgBack, fMemoBack: HBrush;
  fActive: Boolean;
  fCaptionFont, fVariableFont, fFixedFont1, fFixedFont2, fLinkFont,
    fLinkFont2, fBigFont: HFont;
  FixedFontSize: Integer;
  CaptionFontName, FixedFontName1, FixedFontName2: string;
  NonClientMetrics: TNonClientMetrics;
  fMonitor, fSendBmp: THandle;
  fActivePage: THandle = 0;
  fMonitorInfo: TBitmap;
  fListViewItems: TListViewItems;
  rSupport, rClick: TRect;
  SupportLinkActive, ClickLinkActive: Boolean;
  OriginalWidth, OriginalHeight,
    RealLeft, RealTop, RealWidth, RealHeight,
    ListWidth, ListHeight,
    TextWidth, LeftButton, TopButton, WindowState: Integer;
  ColWidths: array[0..15] of Integer; // Max 16 elements.
  DetailsActive, ShowInDetailsMode: Boolean;
  MainDialog: THandle;
  IsDialogShowed: Boolean;
  DialogHeight: Integer;
  CAPTION_HEIGHT: DWord;
{$IFNDEF CBuilder}
  // WARNING!!!
  // Use a fixed array instead of a string to avoid the
  // GetMem used after the last Finalization!
  FixedTmpOptionsFile: array [0..1023] of char;
{$ENDIF}

{$IFDEF PROFESSIONAL}
  GlobalSendValues: TSendRecord;
  SavedLastHTMLPage: string;

  // PNG & ScreenShot variables...
  PNG_ColoursCount, PNG_RowBytes, PNG_DataSize: DWord;
  PNG_ImgData, PNG_Data: Pointer;
  PNG_HeaderData: THeaderData;
  PNG_Encode_Filter, PNG_Encode_Data: PByteArray;
  PNG_CRCList: array[0..255] of DWord;
  PNG_CRCListed: Boolean = False;
  PNG_pal: hPalette;
  PNG_UsePal: Boolean;
  PNG_HWindow, PNG_FocusWnd, PNG_Cursor: HWnd;
  PNG_DCScreen, PNG_DCCompatible: HDC;
  PNG_Bitmap: HBitmap;
  PNG_Width, PNG_Height: DWord;
{$ENDIF}

// -----------------------------
// INTERNAL PROFILER VARIABLES |
// -----------------------------
{.$DEFINE EUREKALOG_PROFILER} // Use to show the internal execution time.
{$IFDEF EUREKALOG_PROFILER}
  mSecBefore, mSecCallStack, mSecModulesList, mSecOpenLog,
    mSecSaveLog, mSecCreateLog, mSecGetModuleInfo, mSecCalcDuplicatedTemp,
    mSecCalcDuplicated, mSecScreenShot, mSecEventTemp, mSecEvents: DWord;
{$ENDIF}

threadvar
  CurrentStackPointer: DWord;
  LastStackPointer: DWord;
  LastECX: DWord;
  CurrentContext: TContext;
  InUnhandledException: Boolean;
  NotCatchCallerThread: Boolean;
  RecursiveException: Boolean;
{$IFDEF CBuilder}
  LastObj: TObject;
  LastAddr, LastExceptionPointers: Pointer;
{$ENDIF}

//------------------------------------------------------------------------------

{ TActiveXException }

constructor TActiveXException.Create(const ExceptionType, ExceptionMessage: string);
begin
  inherited create(ExceptionMessage);
  FExceptionType := ExceptionType;
end;

//------------------------------------------------------------------------------

function CheckMagicCode(Code: DWord): Boolean;
begin
  Result := ((Code = MagicNumber6) or (Code = MagicNumber5));
end;

//------------------------------------------------------------------------------

function FindHandled(Obj: TObject; Address: Pointer; ExceptionFrames: Pointer;
  var Handled: Boolean; var FrameCount: Integer;
  var AsynchronousException: TAsynchronousException;
  var FirstExceptionType: TExceptionType): Boolean;
var
  i: Integer;
  ObjClass: TClass;
begin
  Result := False;

  try
    if (Obj <> nil) then ObjClass := Obj.ClassType else ObjClass := nil;
  except
    Exit;
  end;

  EnterCriticalSection(HandledCacheCriticalSection);
  try
    try
      for i := 0 to (HandledCacheCount - 1) do
      begin
        if (HandledCache[i].Address = Address) and
          (HandledCache[i].ObjClass = ObjClass) and
          (HandledCache[i].ExceptionFrames = ExceptionFrames) then
        begin
          Handled := HandledCache[i].Handled;
          FrameCount := HandledCache[i].FrameCount;
          AsynchronousException := HandledCache[i].AsynchronousException;
          FirstExceptionType := HandledCache[i].FirstExceptionType;
          Result := True;
          Break;
        end;
      end;
    except
      Result := False;
    end;
  finally
    LeaveCriticalSection(HandledCacheCriticalSection);
  end;
end;

procedure InsertHandled(Obj: TObject; Address: Pointer; ExceptionFrames: Pointer;
  Handled: Boolean; FrameCount: Integer; AsynchronousException: TAsynchronousException;
  FirstExceptionType: TExceptionType);
var
  ObjClass: TClass;

  procedure SetItem(ItemNo: Integer);
  begin
    HandledCache[ItemNo].ObjClass := ObjClass;
    HandledCache[ItemNo].Address := Address;
    HandledCache[ItemNo].ExceptionFrames := ExceptionFrames;
    HandledCache[ItemNo].Handled := Handled;
    HandledCache[ItemNo].FrameCount := FrameCount;
    HandledCache[ItemNo].AsynchronousException := AsynchronousException;
    HandledCache[ItemNo].FirstExceptionType := FirstExceptionType;
  end;

begin
  try
    if (Obj <> nil) then ObjClass := Obj.ClassType else ObjClass := nil;
  except
    Exit;
  end;

  EnterCriticalSection(HandledCacheCriticalSection);
  try
    try
      if (HandledCacheCount = HandledCacheSize) then
      begin
        Move(HandledCache[1], HandledCache[0], (SizeOf(HandledCache) - SizeOf(HandledCache[0])));
        SetItem(HandledCacheCount - 1);
      end
      else
      begin
        SetItem(HandledCacheCount);
        Inc(HandledCacheCount);
      end;
    except
      // Reset the cache...
      HandledCacheCount := 0;
    end;
  finally
    LeaveCriticalSection(HandledCacheCriticalSection);
  end;
end;

//------------------------------------------------------------------------------

procedure GetOutOfMemoryCache;
begin
  OutOfMemoryCache := VirtualAlloc(nil, 1024 * 1024 * 16, MEM_RESERVE, PAGE_NOACCESS);
end;

procedure FreeOutOfMemoryCache;
begin
  VirtualFree(OutOfMemoryCache, 0, MEM_RELEASE);
  OutOfMemoryCache := nil;
end;

//------------------------------------------------------------------------------

function ModuleFileName(HModule: THandle): string;
var
  Buff: array[0..MAX_PATH - 1] of Char;
  Idx: Integer;
begin
  if (GetModuleFileName(HModule, Buff, SizeOf(Buff)) > 0) then
  begin
    Result := Buff;
    Idx := Pos('?', Result);
    if (Idx > 0) then // Found the UNC prefix.
    begin
      Inc(Idx);
      while (Idx <= Length(Result)) and (Result[Idx] <> ':') do
        Inc(Idx);
      if (Idx <= Length(Result)) then // Remove the UNC prefix.
        Result := Copy(Result, Idx - 1, Length(Result));
    end;
    Result := GetLongNameFromShort(Result);
  end
  else
    Result := '';
end;

function IsValidModule(HModule: THandle): boolean;
begin
  Result := ModuleFileName(HModule) <> '';
end;
{$IFDEF Delphi3}

{ TAsymmetricCriticalSection }

constructor TAsymmetricCriticalSection.Create;
begin
  inherited;
  InitializeCriticalSection(FLock);
end;

destructor TAsymmetricCriticalSection.Destroy;
begin
  DeleteCriticalSection(FLock);
  inherited;
end;

procedure TAsymmetricCriticalSection.BeginRead;
begin
  EnterCriticalSection(FLock);
end;

procedure TAsymmetricCriticalSection.BeginWrite;
begin
  EnterCriticalSection(FLock);
end;

procedure TAsymmetricCriticalSection.EndRead;
begin
  LeaveCriticalSection(FLock);
end;

procedure TAsymmetricCriticalSection.EndWrite;
begin
  LeaveCriticalSection(FLock);
end;
{$ENDIF}

{ TEurekaLogList }

function TEurekaLogList.GetItem(Index: Integer): TEurekaLog;
begin
  Result := TEurekaLog(TList(Self).Items[Index]);
end;

{ TEurekaLog }

constructor TEurekaLog.Create(AOwner: TComponent);
const
  EError =
    #13#10 +
    'Cannot use a ''TEurekaLog'' component in module "%s", without activate EurekaLog.'#13#10 +
    'To activate EurekaLog use the new IDE "Project/EurekaLog Options..." menu.';
begin
  inherited;
  if (EurekaLogList <> nil) then
    EurekaLogList.Add(Self);
  if (not Initialized) then
    raise EurekaLogNotPresents.CreateFmt(EError, [ExtractFileName(ModuleFileName(HInstance))]);
end;

destructor TEurekaLog.Destroy;
var
  Idx: Integer;
begin
  if (EurekaLogList <> nil) then
  begin
    Idx := EurekaLogList.IndexOf(Self);
    if (Idx <> -1) then EurekaLogList.Delete(Idx);
  end;
  inherited;
end;

//------------------------------------------------------------------------------

function ifelseStr(ok: boolean; s1, s2: string): string;
begin
  if ok then
    Result := s1
  else
    Result := s2;
end;

function ifStr(ok: boolean; s: string): string;
begin
  Result := ifelsestr(ok, s, '');
end;

function TempPath: string;
var
  Buff: array[0..MAX_PATH - 1] of char;
begin
  GetTempPath(MAX_PATH, Buff);
  Result := Buff;
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

function CompleteStr(const s: string; len: integer): string;
var
  i: Integer;
begin
  Result := s;
  for i := Length(s) + 1 to len do
    Result := Result + ' ';
end;

function GetCompleteTimeStr(Days: Double): string;
var
  Hours, Minutes, Seconds: Double;

  function SimpleWord(const WordStr:string; Value: Double): string;
  begin
    Result := WordStr;
    if (Trunc(Value) > 1) then Result := (Result + 's');
  end;

begin
  Result := '';
  Hours := ((Days - Trunc(Days)) * 24);
  Minutes := ((Hours - Trunc(Hours)) * 60);
  Seconds := ((Minutes - Trunc(Minutes)) * 60);
  if (Trunc(Days) > 0) then Result := (Result + Format('%d %s, ', [Trunc(Days), SimpleWord('day', Days)]));
  if (Trunc(Hours) > 0) then Result := (Result + Format('%d %s, ', [Trunc(Hours), SimpleWord('hour', Hours)]));
  if (Trunc(Minutes) > 0) then Result := (Result + Format('%d %s, ', [Trunc(Minutes), SimpleWord('minute', Minutes)]));
  Result := (Result + Format('%d %s', [Trunc(Seconds), SimpleWord('second', Seconds)]));
end;

procedure RTF_LoadFromStream(RichHandle: THandle; Stream: TStream);
var
  EditStream: TEditStream;

  function Load(Stream: TStream; Buff: PByte; c: Integer; var pc: Integer): Integer; stdcall;
  begin
    Result := NoError;
    try
      pc := Stream.Read(Buff^, c);
    except
      Result := ReadError;
    end;
  end;

begin
  with EditStream do
  begin
    dwCookie := Integer(Stream);
    pfnCallBack := @Load;
    dwError := 0;
  end;
  SendMessage(RichHandle, EM_STREAMIN, SF_RTF, Integer(@EditStream));
end;

procedure RTF_LoadFromText(RichHandle: THandle; Text: string);
var
  Data: TMemoryStream;
begin
  Data := TMemoryStream.Create;
  try
    Data.Write(PChar(Text)^, Length(Text));
    Data.Position := 0;
    RTF_LoadFromStream(RichHandle, Data);
  finally
    Data.Free;
  end;
end;

procedure SetRTFBackColor(RichHandle: THandle; Color: Integer);
begin
  if (Color < 0) then Color := GetSysColor(Color and $000000FF);
  SendMessage(RichHandle, EM_SETBKGNDCOLOR, 0, Color);
end;

function TextToRTF(const Txt: string): string;
begin
  Result := QuickStringReplace(Txt, '\', '\\');
  Result := QuickStringReplace(Result, '{', '\{');
  Result := QuickStringReplace(Result, '}', '\}');
  Result := QuickStringReplace(Result, #13#10, '\par'#13#10);
end;

function GeneralToRTF(const Txt: string): string;
var
  n, Idx, SpaceIdx: Integer;
  Lines: TStrings;
  RTFText, Line: string;
begin
  Lines := TStringList.Create;
  try
    Lines.Text := TextToRTF(Txt);
    Lines[0] := ('\cf1\b ' + Lines[0] + '\b0');
    for n := 1 to (Lines.Count - 1) do
    begin
      Line := Lines[n];
      Idx := Pos(':', Line);
      if (Idx = Length(Line) - 4) then Line := ('\cf3\b ' + Line + '\b0')
      else
        if (Line[1] = '-') then  Line := ('\cf3 ' + Line)
        else
        begin
          Idx := Pos(': ', Line);
          if (Idx > 0) then
          begin
            SpaceIdx := Pos(' ', Copy(Line, 3, MaxInt));
            Line := ('\cf5 ' + Copy(Line, 1, Idx) +
              '\cf4 ' + Copy(Line, Idx + 1, Length(Line)));
            Insert('\cf2 ', Line, (SpaceIdx + 7));
          end;
        end;
      Lines[n] := Line;
    end;
    RTFText := Lines.Text;
    RTFText := ('\f0\fs' + IntToStr(FixedFontSize * 2) + #13#10 {Font} + RTFText);
  finally
    Lines.Free;
  end;
  Result := (Format(RTFHeader, [UserCharSet, FixedFontName1]) + RTFText + RTFFooter);
end;

function AssemblerToRTF(const Txt: string): string;
var
  n, Idx: Integer;
  Lines: TStrings;
  RTFText, Line: string;
begin
  Lines := TStringList.Create;
  try
    Lines.Text := TextToRTF(Txt);
    for n := 0 to (Lines.Count - 1) do
    begin
      Line := Lines[n];
      if (Copy(Line, 1, 1) <> ';') then
      begin
        Line := ('\cf5 ' + Line);
        Insert('\cf4\b ', Line, 15);
        Idx := PosEx(' ', Line, 23);
        if (Idx > 0) then Insert('\b0\cf7 ', Line, Idx)
        else Line := (Line + '\b0');
      end;
      Idx := Pos(';', Line);
      if (Idx > 0) then Insert('\cf6 ', Line, Idx);
      Lines[n] := Line;
    end;
    RTFText := Lines.Text;
    RTFText := ('\f0\fs' + IntToStr(FixedFontSize * 2) + #13#10 {Font} + RTFText);
  finally
    Lines.Free;
  end;
  Result := (Format(RTFHeader, [UserCharSet, FixedFontName1]) + RTFText + RTFFooter);
end;

function CPUToRTF(const Txt: string): string;
const
  Line = '---------------------';
var
  n: Integer;
  Lines: TStrings;
  RTFText: string;
  S: string;
  DC: HDC;
  Size: TSize;
begin
  DC := GetDC(0);
  try
    SelectObject(DC, fFixedFont1);
    GetTextExtentPoint32(DC, Line, Length(Line), Size);
  finally
    ReleaseDC(0, DC);
  end;
  Lines := TStringList.Create;
  try
    Lines.Text := TextToRTF(Txt);
    Lines[0] := ('\cf3\b ' + Lines[0] + '\cf2\b0');
    Lines[1] := ('\cf3 ' + Lines[1] + '\cf2');
    for n := 2 to 5 do
    begin
      S := Lines[n];
      Insert('\cf4 ', S, 6);
      Insert('\cf2 ', S, 19);
      Insert('\cf4 ', S, 32);
      Insert('\cf2 ', S, 45);
      Lines[n] := S;
    end;
    S := Lines[7];
    S := Trim(Copy(S, 1, 21)) + '\tab ' + Trim(Copy(S, 22, Length(S)));
    Lines[7] := ('\pard\tx' + IntToStr(Size.cx * 15) + '\cf3\b ' + S + '\cf2\b0');
    S := Lines[8];
    Delete(S, 19, 3);
    Insert('\tab ', S, 19);
    Lines[8] := ('\cf3 ' + S + '\cf2');
    for n := 9 to (Lines.Count - 1) do
    begin
      S := Lines[n];
      Insert('\cf4 ', S, 11);
      Insert('\cf2 ', S, 24);
      Delete(S, 29, 3);
      Insert('\tab ', S, 29);
      Insert('\cf4 ', S, 44);
      Insert('\cf5 ', S, 96);
      s := (s + '\cf2 ');
      Lines[n] := S;
    end;
    RTFText := Lines.Text;
    RTFText := ('\f0\fs' + IntToStr(FixedFontSize * 2) + #13#10 {Font} + RTFText);
  finally
    Lines.Free;
  end;
  Result := (Format(RTFHeader, [UserCharSet, FixedFontName1]) + RTFText + RTFFooter);
end;

//------------------------------------------------------------------------------

function ComputerName: string;
var
  Comp: array[0..255] of Char;
  I: DWord;
begin
  I := MAX_COMPUTERNAME_LENGTH + 1;
  GetComputerName(Comp, I);
  Result := Comp;
end;

function UserName: string;
var
  User: array[0..255] of Char;
  I: DWord;
begin
  I := SizeOf(User);
  GetUserName(User, I);
  Result := User;
end;

function UserFullName: string;
begin
  Result :=
    ReadKey(HKEY_LOCAL_MACHINE, '\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION',
    'RegisteredOwner');
  if (Result = '') then
    Result := ReadKey(HKEY_LOCAL_MACHINE, '\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION',
    'RegisteredOwner');
  if (Result = '') then
    Result := ReadKey(HKEY_LOCAL_MACHINE, '\SOFTWARE\MICROSOFT\MS SETUP (ACME)\USER INFO',
    'DefName');
end;

function CreateVirtualFile(HModule: THandle; const Name: string; Size: DWord;
  var Data: Pointer): THandle;
begin
  Data := nil;
  Inc(Size, 4); // To store the size data.
  Result := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, Size,
    PChar(IntToHex(GetCurrentProcessID, 8) + IntToHex(HModule, 8) + Name));
  if (Result <> 0) then
  begin
    if (GetLastError <> ERROR_ALREADY_EXISTS) and (Size = 4) then
    begin
      CloseHandle(Result);
      Result := 0;
    end
    else
    begin
      // Check if just exists.
      if (GetLastError = ERROR_ALREADY_EXISTS) then
      begin
        Data := MapViewOfFile(Result, FILE_MAP_ALL_ACCESS, 0, 0, 0);
        Size := PDWord(Data)^; // Read the size.
        UnmapViewOfFile(Data);
        CloseHandle(Result);
        Result := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, Size,
          PChar(IntToHex(GetCurrentProcessID, 8) + IntToHex(HModule, 8) + Name));
      end;
      Data := MapViewOfFile(Result, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      PDWord(Data)^ := Size; // Store the size data.
      Data := Pointer(DWOrd(Data) + 4); // To skip the size data.
    end;
  end;
end;

procedure DeleteVirtualFile(var Handle: THandle; var Data: Pointer);
begin
  if (Handle <> 0) then
  begin
    Data := Pointer(DWord(Data) - 4); // To obtain the original size.
    UnmapViewOfFile(Data);
    Data := nil;
    CloseHandle(Handle);
    Handle := 0;
  end;
end;

//------------------------------------------------------------------------------

function TextToHtml(const Src: string): string;
begin
  Result := Src;
  Result := QuickStringReplace(Result, '&', '&amp;'); // HTML & char.
  Result := QuickStringReplace(Result, '"', '&quot;'); // HTML " char.
  Result := QuickStringReplace(Result, '''', '&#039;'); // HTML ' char.
  Result := QuickStringReplace(Result, '<', '&lt;'); // HTML < char.
  Result := QuickStringReplace(Result, '>', '&gt;'); // HTML > char.
  Result := QuickStringReplace(Result, '  ', '&nbsp;&nbsp;'); // HTML spaces.
  Result := QuickStringReplace(Result, #13#10, '<br>'#13#10); // HTML line break.
end;

procedure SetEventAddr(Obj: TObject; const EventName: string;
  ProcAddr: Pointer; var OldProc: Pointer);
var
  Method: TMethod;
  PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(Obj.ClassInfo, EventName);
  if (PropInfo = nil) then Exit;

  Method := GetMethodProp(Obj, PropInfo);
  if (Method.Code = ProcAddr) then Exit;

  OldProc := Method.Code;
  Method.Code := ProcAddr;
  SetMethodProp(Obj, PropInfo, Method);
end;

function IsDebugged: Boolean;
var
  IsDebuggerPresent: function: Boolean; stdcall;
  KernelHandle: THandle;
  P: Pointer;
begin
  KernelHandle := GetModuleHandle(kernel32);
  @IsDebuggerPresent := GetProcAddress(KernelHandle, 'IsDebuggerPresent');
  if Assigned(IsDebuggerPresent) then // Win98+/NT4+ only
    Result := IsDebuggerPresent
  else
  begin // Win9x uses thunk pointer outside the module when under a debugger
    P := GetProcAddress(KernelHandle, 'GetProcAddress');
    Result := (DWORD(P) < KernelHandle);
  end;
end;

function IsValidHandle(Handle: THandle): Boolean;
var
  F: DWord;
  DupH: THandle;
begin
  if (Win32Platform = VER_PLATFORM_WIN32_NT) then // NT platform...
    Result := GetHandleInformation(Handle, F)
  else
    Result := False;
  if (not Result) then
  begin
    // Check for other controls...
    Result := DuplicateHandle(GetCurrentProcess, Handle, GetCurrentProcess, @DupH,
      0, False, DUPLICATE_SAME_ACCESS);
    if Result then Result := CloseHandle(DupH);
  end;
end;

function IsValidRunningThread(Handle: THandle): Boolean;
var
  ExitCode: DWord;
begin
  Result := IsValidHandle(Handle);
  if (Result) then
  begin
    if GetExitCodeThread(Handle, ExitCode) then
      Result := (ExitCode = STILL_ACTIVE);
  end;
end;

function CloneObject(const Obj: TObject): TObject;
var
  Size: Integer;
begin
  Result := nil;
  if (Obj = nil) then Exit;

  // Save Obj size...
  Size := Obj.InstanceSize;
  // Create new Result Object...
  GetMem(Pointer(Result), Size);
  // Copy Obj data...
  Move(Pointer(Obj)^, Pointer(Result)^, Size);
end;

procedure FreeClonedObject(var Obj: TObject);
begin
  if (Obj = nil) then Exit;

  FreeMem(Pointer(Obj), Obj.InstanceSize);
  Obj := nil;
end;

// Return Top Of current Stack...

function GetCurrentTopOfStack: DWord;
asm
  MOV EAX, FS:[4]
end;

function IsValidClass(ClassType: TClass): Boolean;
begin
  Result :=
    // Valid pointer...
    (ClassType <> nil) and
    // Valid ClassName pointer...
    (IsValidBlockAddr(DWord(ClassType), 4)) and
    // Readable ClassName pointer...
    (IsValidBlockAddr(DWord(Integer(ClassType) + vmtClassName), 4)) and
    // Readable ClassName size...
    (IsValidBlockAddr(PDWord(Integer(ClassType) + vmtClassName)^, 1)) and
    // Valid ClassName value...
    (IsValidBlockAddr(PDWord(Integer(ClassType) + vmtClassName)^ + 1,
      PByte(Integer(ClassType) + vmtClassName)^));
end;

function IsValidObject(Obj: TObject): Boolean;
begin
  Result :=
    // Valid pointer...
    (Obj <> nil) and (IsValidBlockAddr(DWord(Obj), 4)) and
    // Valid Class pointer...
    (IsValidClass(TClass(PDWord(Obj)^)));
end;

//------------------------------------------------------------------------------

function IsAParentClassStr(ClassPtr: TClass; const Parent: string): Boolean;
begin
  Result := False;
  while (ClassPtr <> nil) and (not Result) do
  begin
    if (not IsValidClass(ClassPtr)) then Exit;

    Result := (UpperCase(ClassPtr.ClassName) = UpperCase(Trim(Parent)));
    if (not Result) then ClassPtr := ClassPtr.ClassParent;
  end;
end;

function IsAParentStr(Obj: TObject; const Parent: string): Boolean;
var
  Item: TClass;
begin
  if IsValidObject(Obj) then Item := Obj.ClassType
  else Item := nil;
  Result := IsAParentClassStr(Item, Parent);
end;

function IsAParent(Obj: TObject; Parent: TClass): Boolean;
begin
  Result := IsAParentStr(Obj, Parent.ClassName);
end;

function IsAParents(Obj: TObject; Parents: array of TClass): Boolean;
var
  n: Integer;
begin
  Result := False;
  for n := Low(Parents) to High(Parents) do
    Result := (Result or (IsAParent(Obj, Parents[n])));
end;

{function IsAParentsStr(Obj: TObject; Parents: array of string): Boolean;
var
  n: Integer;
begin
  Result := False;
  for n := Low(Parents) to High(Parents) do
    Result := (Result or (IsAParentStr(Obj, Parents[n])));
end;}

function IsAParentClassStr_Unsafe(ClassPtr: TClass; const Parent: string): Boolean;
begin
  Result := False;
  while (ClassPtr <> nil) and (not Result) do
  begin
    Result := (UpperCase(ClassPtr.ClassName) = UpperCase(Trim(Parent)));
    if (not Result) then ClassPtr := ClassPtr.ClassParent;
  end;
end;

function IsAParentStr_Unsafe(Obj: TObject; const Parent: string): Boolean;
var
  Item: TClass;
begin
  if (Obj <> nil) then Item := Obj.ClassType
  else Item := nil;
  Result := IsAParentClassStr_Unsafe(Item, Parent);
end;


//------------------------------------------------------------------------------

function IsManageableObject(Obj: TObject): Boolean;
begin
  Result := (IsValidObject(Obj)) and (not IsAParentStr_Unsafe(Obj, 'EAbort'));
end;

function IsWin95: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
    (Win32MinorVersion in [0..9]);
end;

function IsWinNT: Boolean;
begin
  Result := (Win32Platform = VER_PLATFORM_WIN32_NT) and
    (Win32MajorVersion = 4);
end;

function GetOSType: string;
begin
  Result := 'Microsoft Windows ';
  case Win32Platform of
    VER_PLATFORM_WIN32_WINDOWS:
      case Win32MinorVersion of
        0..9:
          if Trim(Win32CSDVersion) = 'B' then
            Result := Result + '95 OSR 2'
          else
            Result := Result + '95';
        10..89:
          if Trim(Win32CSDVersion) = 'A' then
            Result := Result + '98 SE'
          else
            Result := Result + '98';
        90: Result := Result + 'ME';
      end;
    VER_PLATFORM_WIN32_NT:
      case Win32MajorVersion of
        4: Result := Result + 'NT 4.0';
        5: case Win32MinorVersion of
            0:
              Result := Result + '2000';
            1:
              Result := Result + 'XP';
            2:
              Result := Result + '2003';
          end;
        6: Result := Result + 'Vista';
      end;
  end;
end;

function RFCDate(Value: TDateTime): string;
var
  GMT: string;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
  Months: array[1..12] of string;
  Days: array[1..7] of string;
begin
  // ---------------------------------------------------------------------------
  // WARNING!!!
  // Not convert the following run-time assignment into consts, otherwise
  // the values will be free during the memory-leak reporting (system free them)
  // ---------------------------------------------------------------------------
  Months[1]  := 'Jan';
  Months[2]  := 'Feb';
  Months[3]  := 'Mar';
  Months[4]  := 'Apr';
  Months[5]  := 'May';
  Months[6]  := 'Jun';
  Months[7]  := 'Jul';
  Months[8]  := 'Aug';
  Months[9]  := 'Sep';
  Months[10] := 'Oct';
  Months[11] := 'Nov';
  Months[12] := 'Dec';
  Days[1] := 'Sun';
  Days[2] := 'Mon';
  Days[3] := 'Tue';
  Days[4] := 'Wed';
  Days[5] := 'Thu';
  Days[6] := 'Fri';
  Days[7] := 'Sat';
  // ---------------------------------------------------------------------------
  GMT := IntToStr(GetGMT);
  if (GMT[1] <> '-') then GMT := '+' + GMT;
  if (Length(GMT) = 2) then Insert('0', GMT, 2);
  GMT := GMT + '00';
  DecodeDate(Value, Year, Month, Day);
  DecodeTime(Value, Hour, Min, Sec, MSec);
  Result := Format('%s, %d %s %d %0.2d:%0.2d:%0.2d %s',
    [Days[DayOfWeek(Value)], Day, Months[Month], Year, Hour, Min, Sec, GMT]);
end;

// -----------------------------------------------------------------------------

function IsDelphiException(Obj: TObject): Boolean;
begin
{$IFDEF Delphi4Up}
  Result := (not IsAParent(Obj, EExternal));
{$ELSE}
  Result := False;
{$ENDIF}
end;

// -----------------------------------------------------------------------------

procedure CallStackByAddresses(StackList: TEurekaStackList; FirstAddr: Pointer;
  StackPointer, TopOfStack, ThreadID: DWord; RunningThread, GetDebugInfo,
  ShowBeginCalls: Boolean; StartLevel, LevelsNumber: Integer;
  DebugDetails: TEurekaDebugDetails); forward;

procedure GetDebugInfosByAddr(Addr, ThreadID: DWord; DebugInfo: PEurekaDebugInfo;
  RunningThread, ErrorLine: Boolean); forward;

procedure InternalCriticalError(const Section: string);
const
  MemDumpSize = 32;
var
  LastExcept, ExcType, LogName, LogStr, Error, MemDump: string;
  n: DWord;
  ExcAddr: Pointer;

  function GetCallStackDump: string;
  var
    StackList: TEurekaStackList;
    n: Integer;
    Stack: DWord;
    Other: string;

    function GetESP: DWord;
    asm
      MOV  EAX, ESP
      ADD  EAX, 4
    end;

    function GetTopOfStack: DWord;
    asm
      MOV EAX, FS:[4]
    end;

  begin
    Result := '';
    StackList := TEurekaStackList.Create;
    try
      if (IntoIDE) then Stack := GetESP
      else Stack := CurrentStackPointer;
      try
        // Try to obtain a full Call Stack...
        CallStackByAddresses(StackList, nil, Stack, GetTopOfStack, 0,
          True, True, True, -1, -1, [ddNone..ddSourceCode]);
      except
        // Try to obtain a reduced Call Stack...
        CallStackByAddresses(StackList, nil, Stack, GetTopOfStack, 0,
          True, False, True, -1, -1, [ddNone..ddSourceCode]);
      end;
      for n := 0 to (StackList.Count - 1) do
      begin
        if (n > 0) then Result := (Result + '            ');
        if (StackList[n]^.Line <> 0) then
        begin
          Other := Format('- %s - %s - %s - %s[%s]',
            [StackList[n]^.UnitName, StackList[n]^.ClassName,
            StackList[n]^.ProcedureName, IntToStr(StackList[n]^.Line),
            IntToStr(StackList[n]^.ProcOffsetLine)]);
        end
        else Other := '';
        Result := (Result + Format('%s $%8.8x - [%8.8x] %s %s'#13#10, [IntToHex(n, 2),
          StackList[n]^.Addr, StackList[n]^.ModuleInfo^.Handle,
          ExtractFileName(StackList[n]^.ModuleInfo^.Name), Other]));
      end;
    finally
      StackList.Free;
    end;
  end;

  function ExceptionLine(Addr: Pointer): string;
  var
    DebugInfo: PEurekaDebugInfo;
  begin
    New(DebugInfo);
    try
      GetDebugInfosByAddr(DWord(Addr), GetCurrentThreadID, DebugInfo, True, True);
      Result := (Format('$%8.8x - [%8.8x] %s - %s - %s - %s - %s[%s]',
        [DWord(Addr), DebugInfo^.ModuleInfo^.Handle,
        ExtractFileName(DebugInfo^.ModuleInfo^.Name),
        DebugInfo^.UnitName, DebugInfo^.ClassName, DebugInfo^.ProcedureName,
        IntToStr(DebugInfo^.Line), IntToStr(DebugInfo^.ProcOffsetLine)]));
    finally
      Dispose(DebugInfo);
    end;
  end;

begin
  ShowEurekaLogUnits := True;
  try
    if (IsAParents(ExceptObject, [EAbort, EEurekaSocketError])) then Exit;
  {$IFNDEF DUNITPROJECT}
    if (not IntoIDE) and (not IsDebugged) then Exit;
  {$ENDIF}

    ExcAddr := ExceptAddr;
    if (ExceptObject is Exception) then
    begin
      if IsDelphiException(ExceptObject) and (ExcAddr <> nil) then // Decrease of 5
        ExcAddr := Pointer(Integer(ExcAddr) - 5);

      Error := Exception(ExceptObject).Message;
      ExcType := Exception(ExceptObject).ClassName;
    end
    else
    begin
      Error := 'General internal error.';
      ExcType := '';
    end;
    if (IsValidObject(CriticalExceptObject)) then
      LastExcept := CriticalExceptObject.ClassName
    else
      LastExcept := '';
    LogStr := Format('[ERROR] - Section: %s - Address: %s - Message: "%s"',
      [Section, IntToHex(DWord(ExcAddr), 8), Error]);
    OutputDebugString(PChar(LogStr));

    MemDump := '';
    if (IsValidBlockAddr(DWord(ExcAddr), MemDumpSize)) then
      for n := DWord(ExcAddr) to (DWord(ExcAddr) + MemDumpSize - 1) do
      begin
        MemDump := MemDump + '$' + IntToHex(PByte(n)^, 2) + ' ';
      end;

    LogStr := Format('Version   : %s'#13#10'Date      : %s'#13#10'OS        : %s'#13#10 +
      'RAD       : %s'#13#10'Dump      : %s'#13#10 +
      'Section   : %s'#13#10'LastExcept: %s'#13#10'Address   : %s'#13#10 +
      'Exception : %s'#13#10'Message   : %s'#13#10'Call Stack: %s',
      [EurekaLogVersion, RFCDate(Now), GetOSType, RADRegKeyName + ' ' + RADVersionString,
      MemDump, Section, LastExcept, ExceptionLine(ExcAddr), ExcType,
      Error, GetCallStackDump]);
    LogName := ChangeFileExt(ParamStr(0), '.log');
    if (not GetWorkingFile(LogName, True, False)) then Exit;

    with TStringList.Create do
    begin
      Text := LogStr;
      SaveToFile(LogName);
      Free;
    end;

    if (MessageBox(MsgBoxhWnd, PChar(Format(EurekaInternalBUGString, [Error])),
      EInternalBUG, MB_YESNO or MB_DEFBUTTON1 or MB_ICONERROR or MessageBoxFlags) = ID_YES) then
    begin
      LogName := ChangeFileExt(ParamStr(0), '.log');
  {$IFDEF PROFESSIONAL}
      if (not EurekaLogSendEmail('support@eurekalog.com', EInternalCriticalBUGSubject,
        EInternalCriticalBUGSubject, LogName)) then
      begin
        MessageBox(MsgBoxhWnd, PChar(Format(ENoConnectWithEClient, [LogName])),
          EInformation, MB_OK or MB_ICONWARNING or MessageBoxFlags);
      end;
  {$ENDIF}
    end;
  finally
    ShowEurekaLogUnits := True;
  end;
end;

procedure SetInternalError(Code: TEurekaLogErrorCode; const Msg: string);
var
  LogStr: string;
begin
  InternalErrorCode := Code;
  InternalErrorMsg := Msg;
  LogStr := Format('[WARNING] - Code: %s - Address: %s - Message: "%s"',
    [GetEnumName(TypeInfo(TEurekaLogErrorCode), Ord(Code)),
    IntToHex(DWord(ExceptAddr), 8), Msg]);
  OutputDebugString(PChar(LogStr));
{$IFDEF PROFESSIONAL}
  if (GlobalSendValues.Dialog <> 0) and (Code in [eeEmailSMTPError..eeWebTrakerError]) then
    MessageBox(MsgBoxhWnd, PChar(Msg), EErrorCaption,
      MB_OK or MB_ICONERROR or MessageBoxFlags);
{$ENDIF}
end;

procedure ClearInternalError;
begin
  InternalErrorCode := eeNone;
  InternalErrorMsg := '';
end;

procedure SetErrorType(ErrorType: TEurekaLogErrorCode; TypeStr: string);
begin
  if (ExceptObject is Exception) then
    SetInternalError(ErrorType, Format('[%s] %s', [TypeStr,
      Exception(ExceptObject).Message]))
  else
    SetInternalError(ErrorType, Format('General ''%s'' error.', [TypeStr]));
{$IFDEF DUNIT}
  InternalCriticalError(TypeStr);
{$ENDIF}
end;

function IsMainWindow(Wnd: THandle): Boolean;
var
  Parent: THandle;
  Ex: DWord;

  function HasWindowASize(Wnd: THandle): Boolean;
  var
    Rect: TRect;
    Width, Height: Integer;
  begin
    Result := False;
    if (GetWindowRect(Wnd, Rect)) then
    begin
      Width := (Rect.Right - Rect.Left);
      Height := (Rect.Bottom - Rect.Top);
      Result := ((Width > 0) and (Height > 0));
    end;
  end;

begin
  Result := (IsWindowVisible(Wnd) and (HasWindowASize(Wnd)));
  if Result then
  begin
    Parent := GetWindowLong(Wnd, GWL_HWNDPARENT);
    if ((Parent <> 0) and (Parent <> GetDesktopWindow)) then
    begin
      Ex := GetWindowLong(Parent, GWL_EXSTYLE);
      if (Ex and WS_EX_TOOLWINDOW <> 0) then
        Parent := GetWindowLong(Parent, GWL_HWNDPARENT);
    end;
    Ex := GetWindowLong(Wnd, GWL_EXSTYLE);
    Result := ((Parent = 0) or (Parent = GetDesktopWindow)) and
      ((Ex and WS_EX_TOOLWINDOW = 0) or (Ex and WS_EX_APPWINDOW <> 0));
  end;
end;

function GetMainWindow(ProcID: DWord): THandle;
type
  PRec = ^TRec;
  TRec = packed record
    ProcID: DWord;
    Wnd: THandle;
  end;
var
  Rec: TRec;

  function EnumWindowsProc(Wnd: THandle; Rec: PRec): Boolean; stdcall;
  var
    PID: DWord;
  begin
    GetWindowThreadProcessId(Wnd, @PID);
    if (PID = Rec^.ProcID) and IsMainWindow(Wnd) then
    begin
      Rec^.Wnd := Wnd;
      Result := False;
    end
    else
      Result := True;
  end;

begin
  Rec.ProcID := ProcID;
  Rec.Wnd := 0; // If don't find any main window.
  EnumWindows(@EnumWindowsProc, Integer(@Rec));
  Result := Rec.Wnd;
end;

{function GetFirstWindow(ProcID: DWord): THandle;
type
  PRec = ^TRec;
  TRec = packed record
    ProcID: DWord;
    Wnd: THandle;
  end;
var
  Rec: TRec;

  function EnumWindowsProc(Wnd: THandle; Rec: PRec): Boolean; stdcall;
  var
    PID: DWord;
  begin
    GetWindowThreadProcessId(Wnd, @PID);
    if (PID = Rec^.ProcID) then
    begin
      Rec^.Wnd := Wnd;
      Result := False;
    end
    else
      Result := True;
  end;

begin
  Rec.ProcID := ProcID;
  Rec.Wnd := 0; // If don't find any main window.
  EnumWindows(@EnumWindowsProc, Integer(@Rec));
  Result := Rec.Wnd;
end;}

function GetApplicationRect(ProcID: DWord): TRect;
type
  PRec = ^TRec;
  TRec = packed record
    ProcID: DWord;
    Rect: TRect;
  end;
var
  Rec: TRec;

  function EnumWindowsProc(Wnd: THandle; Rec: PRec): Boolean; stdcall;
  var
    PID: DWord;
    Rc: TRect;
  begin
    GetWindowThreadProcessId(Wnd, @PID);
    if (PID = Rec^.ProcID) and (IsWindowVisible(Wnd)) then
    begin
      if (GetWindowRect(Wnd, Rc) and (Rc.Right - Rc.Left > 0)) then
      begin
        if (Rc.Left < Rec^.Rect.Left) then Rec^.Rect.Left := Rc.Left;
        if (Rc.Top < Rec^.Rect.Top) then Rec^.Rect.Top := Rc.Top;
        if (Rc.Right > Rec^.Rect.Right) then Rec^.Rect.Right := Rc.Right;
        if (Rc.Bottom > Rec^.Rect.Bottom) then Rec^.Rect.Bottom := Rc.Bottom;
      end;
    end;
    Result := True;
  end;

begin
  Rec.ProcID := ProcID;
  Rec.Rect := Rect(MaxInt, MaxInt, 0, 0); // If don't find any main window.
  EnumWindows(@EnumWindowsProc, Integer(@Rec));
  Result := Rec.Rect;
  if (Result.Left = MaxInt) then Result := Rect(-1, -1, -1, -1);
end;

function IsCurrentProcessWindow(Wnd: THandle): Boolean;
var
  PID: DWord;
begin
  GetWindowThreadProcessId(Wnd, @PID);
  Result := (PID = GetCurrentProcessId);
end;

function IsANewProcessWindow(Wnd: THandle): Boolean;
begin
  Result := (CurrentProcessWindowsList.IndexOf(Pointer(Wnd)) = -1);
end;

procedure PopulateCurrentProcessWindows;

  function EnumWindowsProc(Wnd: THandle; List: TList): Boolean; stdcall;
  var
    PID: DWord;
  begin
    GetWindowThreadProcessId(Wnd, @PID);
    if (PID = GetCurrentProcessId) then List.Add(Pointer(Wnd));
    Result := True;
  end;

begin
  CurrentProcessWindowsList.Clear;
  EnumWindows(@EnumWindowsProc, Integer(CurrentProcessWindowsList));
end;


procedure SetClipboardText(const Text: string);
var
  Data: THandle;
  DataPtr: Pointer;
  Size: DWord;
begin
  if (Text = '') then Exit;
  
  Size := Length(Text) + 1;
  OpenClipboard(0);
  try
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, Size);
    try
      DataPtr := GlobalLock(Data);
      try
        Move(Text[1], DataPtr^, Size);
        EmptyClipboard;
        SetClipboardData(CF_TEXT, Data);
      finally
        GlobalUnlock(DWord(DataPtr));
      end;
    finally
      GlobalFree(Data);
    end;
  finally
    CloseClipboard;
  end;
end;

procedure KillApplication(Restart: boolean);
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
begin
  if Restart then
  begin
    GetStartupInfo(StartInfo);
    FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
    CreateProcess(nil, GetCommandLine, nil, nil, False,
      CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil,
      PChar(StartDir), StartInfo, ProcInfo);
  end;
  // TODO: call all the "finalization" sections, with a timeout.
  TerminateProcess(GetCurrentProcess, 1);
end;

//------------------------------------------------------------------------------
// THModuleStream...
//------------------------------------------------------------------------------

constructor THModuleStream.Create(HModule: THandle);
begin
  inherited Create;
  SetPointer(Pointer(HModule), MaxInt);
end;

destructor THModuleStream.Destroy;
begin
  SetPointer(nil, 0);
  inherited;
end;

function THModuleStream.SecureRead(var Buffer; Count: Integer): Boolean;
begin
  Result := False;
  if IsValidBlockAddr((DWord(Memory) + DWord(Position)), DWord(Count)) then
    Result := (Read(Buffer, Count) = Count);
end;

{$IFNDEF CBuilder}
function ExceptionManager(Obj: TObject; Addr: Pointer;
  RaiserType: TRaiserType; ModuleHandle: THandle): Boolean; forward;
{$ENDIF}

//------------------------------------------------------------------------------
// Generic Module functions/procedures...
//------------------------------------------------------------------------------
// This function return the ModuleFileName...


    // The path can have the UNC prefix "\\?\",
    // depending on how the module was loaded.


// This function return if a selected handle is a valid module
// for the current process...


function AddModule(HModule: THandle): Boolean; forward;

// This function return the ModuleInfo by HModule Handle,
// if not dound it then add it to the ModulesList.

function ModuleInfoByHandle(HModule: THandle): PEurekaModuleInfo;
var
  i: integer;
begin
{$IFNDEF PROFESSIONAL}
  if (HModule <> MainInstance) and (not IntoIDE) then
  begin
    Result := nil;
    Exit;
  end;
{$ENDIF}
  Result := nil;
  if ((HModule <> 0) and (ModulesList <> nil)) then
  begin
    i := 0;
    while (i <= ModulesList.Count - 1) and
      (ModulesList[i]^.Handle <> HModule) do Inc(i);
    if (i <= ModulesList.Count - 1) then // Module found.
    begin
      if (ModulesList[i]^.ModuleType <> mtUnknown) or (NotLoadDebugInfo) then
        Result := ModulesList[i]
      else
      begin
        ModulesList.Delete(i); // Remove inclomplete module.
        if AddModule(HModule) then
          Result := ModulesList[ModulesList.Count - 1];
      end;
    end
    else // Module not found.
      if (AddModule(HModule)) then
        Result := ModulesList[ModulesList.Count - 1];
  end;
end;

// This function return the ModuleInfo by Address...

function ModuleInfoByAddr(Addr: DWord): PEurekaModuleInfo;
begin
  Result := ModuleInfoByHandle(FindHInstance(Pointer(Addr)));
end;

function IsModuleLibrary(HModule: THandle): Boolean;
var
  EXETag: Word;
  PEHOffset, PESig: DWord;
  PEHeaderImage: TImageFileHeader;
  HStream: THModuleStream;
begin
  Result := IsLibrary;
  HStream := THModuleStream.Create(HModule);
  try
    if (HStream.SecureRead(EXETag, SizeOf(EXETag))) and (EXETag = $5A4D) then // 'MZ'
    begin
      HStream.Position := $3C;
      if (HStream.SecureRead(PEHOffset, SizeOf(PEHOffset))) and (PEHOffset <> 0) then
      begin
        HStream.Position := PEHOffset;
        if (HStream.SecureRead(PESig, SizeOf(PESig))) and ((PESig = $00004550)) and // 'PE'#0#0
          (HStream.SecureRead(PEHeaderImage, SizeOf(PEHeaderImage))) then
          Result := (PEHeaderImage.Characteristics and IMAGE_FILE_DLL <> 0);
      end;
    end;
  finally
    HStream.Free;
  end;
end;

function FindModuleType(HModule: THandle): TEurekaModuleType;
var
  EXETag: Word;
  PEHOffset, PESig: DWord;
  PEHeaderImage: TImageFileHeader;
  HStream: THModuleStream;
  NewHModule: Thandle;
begin
  Result := mtUnknown;
  HStream := THModuleStream.Create(HModule);
  try
    if (HStream.SecureRead(EXETag, SizeOf(EXETag))) and (EXETag = $5A4D) then // 'MZ'
    begin
      HStream.Position := $3C;
      if (HStream.SecureRead(PEHOffset, SizeOf(PEHOffset))) and (PEHOffset <> 0) then
      begin
        HStream.Position := PEHOffset;
        if (HStream.SecureRead(PESig, SizeOf(PESig))) and (PESig = $00004550) then // 'PE'#0#0
        begin
          if (HStream.SecureRead(PEHeaderImage, SizeOf(PEHeaderImage))) and
            (PEHeaderImage.Characteristics and IMAGE_FILE_DLL <> 0) then
          begin
            NewHModule := LoadLibraryEx(PChar(ModuleFileName(HModule)), 0,
              LOAD_LIBRARY_AS_DATAFILE);
            try
              if (FindResource(NewHModule, 'PACKAGEINFO', RT_RCDATA) <> 0) and
                (FindResource(NewHModule, 'PACKAGEOPTIONS', RT_RCDATA) <> 0) then
                Result := mtBorlandPackage
              else
              begin
                Result := mtOSLibrary;
              end;
            finally
              FreeLibrary(NewHModule);
            end;
          end
          else
            Result := mtMainModule
        end;
      end;
    end;
  finally
    HStream.Free;
  end;
end;

function GetModulePath(const ModuleName: string): string;
begin
  Result := ExtractFilePath(ModuleName);
  if (Copy(Result, Length(Result) - 1, 1) <> ':') then
    Delete(Result, Length(Result), 1);
  if (Copy(Result, 1, 4) = '\??\') then Delete(Result, 1, 4);
end;

function GetModuleSize(ModuleSize: DWord): string;
begin
  if (ModuleSize = 0) then Result := ''
  else Result := IntToStr(Round(ModuleSize / 1024)) + ' Kb';
end;

function GetModuleVer(const ModuleVersion: string): string;
var
  n, c: integer;
begin
  Result := ModuleVersion;
  n := 1;
  c := 0;
  while (n <= Length(Result)) and (c < 2) do
  begin
    if (Result[n] = '.') then Inc(c);
    inc(n);
  end;
  if (c = 2) then Result := Copy(Result, 1, n - 1) + 'x';
end;

procedure GetModuleDescriptionAndVersion(const ModuleName: string; var Desc, Ver: string);
type
  Rec = packed record
    ID: Word;
    Code: Word;
  end;
  TLanguageIDs = array[0..255] of Rec;
  PLanguageIDs = ^TLanguageIDs;
var
  dwSize, Size, Len: DWord;
  Major, Minor, Release, Build: Word;
  VerData, VerInfo: Pointer;
  st: string;
begin
  Desc := '';
  Ver := '';
  Len := 0;
  dwSize := GetFileVersionInfoSize(PChar(ModuleName), Size);
  if (dwSize > 0) then
  begin
    GetMem(VerData, dwSize);
    try
      if (GetFileVersionInfo(PChar(ModuleName), 0, dwSize, VerData)) then
      begin
        if (VerQueryValue(VerData, '\VarFileInfo\Translation', VerInfo, Len)) then
        begin
          st := '\\StringFileInfo\\' +
            IntToHex(PLanguageIDs(VerInfo)^[0].ID, 4) +
            IntToHex(PLanguageIDs(VerInfo)^[0].Code, 4) +
            '\\FileDescription';
          Len := 0;
          if (VerQueryValue(VerData, PChar(St), VerInfo, Len)) and (Len > 1) then
            SetString(Desc, PChar(VerInfo), StrLen(VerInfo));
        end;
        if (VerQueryValue(VerData, '\', VerInfo, Len)) then
        begin
          Major := Hiword(((TVSFixedFileInfo(VerInfo^)).dwFileVersionMS));
          Minor := Loword(((TVSFixedFileInfo(VerInfo^)).dwFileVersionMS));
          Release := Hiword(((TVSFixedFileInfo(VerInfo^)).dwFileVersionLS));
          Build := Loword(((TVSFixedFileInfo(VerInfo^)).dwFileVersionLS));
          Ver := IntToStr(Major) + '.' + IntToStr(Minor) + '.' +
            IntToStr(Release) + '.' + IntToStr(Build);
          if (Ver = '0.0.0.0') then Ver := '';
        end;
      end;
    finally
      FreeMem(VerData, dwSize);
    end;
  end;
end;

function PriorityToString(Priority: DWord): string;
begin
  Result := '';

  case Priority of
    $40: Result := 'Low';
    $20: Result := 'Normal';
    $4000: Result := 'Below-Normal';
    $8000: Result := 'Above-Normal';
    $80: Result := 'High';
    $100: Result := 'Real-Time';
  end;
end;

function GetProcessThreads(Threads: DWord): string;
begin
  if (Threads = 0) then Result := '??'
  else Result := IntToStr(Threads);
end;

function GetVersionNumber: string;
var
  Tmp: string;
begin
  GetModuleDescriptionAndVersion(ModuleFileName(MainInstance), Tmp, Result)
end;

function GetFileSize(const FileName: string): DWord;
var
  FFD: TWIN32FindData;
begin
  if Windows.FindClose(Windows.FindFirstFile(PChar(FileName), FFD)) then
    Result := FFD.nFileSizeLow
  else Result := 0;
end;

function CompareModulesFunctions(Item1, Item2: Pointer): Integer;
begin
  Result := PEurekaModuleInfo(Item1)^.Handle - PEurekaModuleInfo(Item2)^.Handle;
end;

// This function return the Modules List of current process...

procedure GetModulesList;
var
  n: Integer;

  procedure GetModulesWinNT;
  type
    ModulesArray = array[0..0] of THandle;
  var
    LibHdl, ProcHdl: THandle;
    n, Size: DWord;
    ModList: ^ModulesArray;
    EnumProcessModules: function(hProc: THandle; ModulePtr: PDWord; cb: DWord;
      var LenPtr: DWord): LongBool; stdcall;
  begin
    LibHdl := LoadLibrary('PSAPI.DLL');
    if (LibHdl <> 0) then
    try
      EnumProcessModules := GetProcAddress(LibHdl, 'EnumProcessModules');
      if (Assigned(EnumProcessModules)) then
      begin
        ProcHdl := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,
          False, GetCurrentProcessID);
        if (ProcHdl <> 0) then
        try
          if (EnumProcessModules(ProcHdl, nil, 0, Size)) then
          begin
            GetMem(ModList, Size);
            try
              if EnumProcessModules(ProcHdl, @ModList^[0], Size, Size) then
                for n := 0 to ((Size div 4) - 1) do
                  if (ModuleInfoByHandle(ModList[n]) = nil) then
                    AddModule(ModList[n]);
            finally
              FreeMem(ModList, Size);
            end;
          end;
        finally
          CloseHandle(ProcHdl);
        end;
      end;
    finally
      FreeLibrary(LibHdl);
    end;
  end;

  procedure GetModulesWin9X;
  var
    LibHdl, Hdl: THandle;
    ModuleInfo: TModuleInfo;
    NextModule: Boolean;
    CreateToolhelp32Snapshot: function(Flags, ProcessID: DWord): THandle; stdcall;
    Module32First: function(Hdl: THandle; var Info: TModuleInfo): LongBool; stdcall;
    Module32Next: function(Hdl: THandle; var Info: TModuleInfo): LongBool; stdcall;
  begin
    LibHdl := LoadLibrary(Kernel32);
    if (LibHdl <> 0) then
    try
      CreateToolhelp32Snapshot := GetProcAddress(LibHdl, 'CreateToolhelp32Snapshot');
      Module32First := GetProcAddress(LibHdl, 'Module32First');
      Module32Next := GetProcAddress(LibHdl, 'Module32Next');
      if (Assigned(CreateToolhelp32Snapshot)) and
        (Assigned(Module32First)) and (Assigned(Module32Next)) then
      begin
        Hdl := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, GetCurrentProcessID);
        if (Hdl <> INVALID_HANDLE_VALUE) then
        try
          FillChar(ModuleInfo, SizeOf(ModuleInfo), #0);
          ModuleInfo.dwSize := SizeOf(ModuleInfo); // Needed information.
          NextModule := Module32First(Hdl, ModuleInfo);
          while (NextModule) do
          begin
            if (ModuleInfoByHandle(ModuleInfo.hModule) = nil) then
              AddModule(ModuleInfo.hModule);
            NextModule := Module32Next(Hdl, ModuleInfo);
          end;
        finally
          CloseHandle(Hdl);
        end;
      end;
    finally
      FreeLibrary(LibHdl);
    end;
  end;

begin
  n := 0;
  while (n <= ModulesList.Count - 1) do
    if (IsValidModule(ModulesList[n]^.Handle)) then Inc(n)
    else ModulesList.Delete(n);

  NotLoadDebugInfo := True;
  try
    if (Win32Platform = VER_PLATFORM_WIN32_NT) then
      GetModulesWinNT // Win NT
    else
      GetModulesWin9X; // Win9X
    ModulesList.Sort(@CompareModulesFunctions);
  finally
    NotLoadDebugInfo := False;
  end;
end;

function CompareProcessesFunctions(Item1, Item2: Pointer): Integer;
begin
  Result := (PEurekaProcessInfo(Item1)^.ProcessID - PEurekaProcessInfo(Item2)^.ProcessID);
end;

// This function return the running Processes List...

procedure GetProcessesList;
type
  PROCESS_MEMORY_COUNTERS = packed record
    cb: DWORD;
    PageFaultCount: DWORD;
    PeakWorkingSetSize: DWORD;
    WorkingSetSize: DWORD;
    QuotaPeakPagedPoolUsage: DWORD;
    QuotaPagedPoolUsage: DWORD;
    QuotaPeakNonPagedPoolUsage: DWORD;
    QuotaNonPagedPoolUsage: DWORD;
    PagefileUsage: DWORD;
    PeakPagefileUsage: DWORD;
  end;
  PPROCESS_MEMORY_COUNTERS = ^ PROCESS_MEMORY_COUNTERS;

  TThreadEntry32 = packed record
    dwSize: DWORD;
    cntUsage: DWORD;
    th32ThreadID: DWORD;       // this thread
    th32OwnerProcessID: DWORD; // Process this thread is associated with
    tpBasePri: Longint;
    tpDeltaPri: Longint;
    dwFlags: DWORD;
  end;

  TProcessEntry32 = packed record
    dwSize: DWORD;
    cntUsage: DWORD;
    th32ProcessID: DWORD;       // this process
    th32DefaultHeapID: DWORD;
    th32ModuleID: DWORD;        // associated exe
    cntThreads: DWORD;
    th32ParentProcessID: DWORD; // this process's parent process
    pcPriClassBase: Longint;    // Base priority of process's threads
    dwFlags: DWORD;
    szExeFile: array[0..MAX_PATH - 1] of Char;// Path
  end;

  TGetProcessMemoryInfo = function (Process: THandle;
    ppsmemCounters: PPROCESS_MEMORY_COUNTERS; cb: DWORD): BOOL; stdcall;

  TGetModuleFileNameEx = function (hProcess: THandle; hModule: HMODULE;
    lpFilename: PAnsiChar; nSize: DWORD): DWORD; stdcall;

  TEnumProcesses =
    function (lpidProcess: LPDWORD; cb: DWORD; var cbNeeded: DWORD): BOOL; stdcall;

  TCreateToolhelp32Snapshot =
    function (dwFlags, th32ProcessID: DWORD): THandle; stdcall;

  TThread32First =
    function (hSnapshot: THandle; var lpte: TThreadEntry32): BOOL; stdcall;

  TThread32Next =
    function (hSnapshot: THandle; var lpte: TThreadENtry32): BOOL; stdcall;

  TProcess32First =
    function (hSnapshot: THandle; var lppe: TProcessEntry32): BOOL; stdcall;
  TProcess32Next =
    function (hSnapshot: THandle; var lppe: TProcessEntry32): BOOL; stdcall;

var
  ThreadsCounted: Boolean;
  PsLib, KernelLib: THandle;
  GetProcessMemoryInfo: TGetProcessMemoryInfo;
  GetModuleFileNameEx: TGetModuleFileNameEx;
  EnumProcesses: TEnumProcesses;
  CreateToolhelp32Snapshot: TCreateToolhelp32Snapshot;
  Thread32First: TThread32First;
  Thread32Next: TThread32Next;
  Process32First: TProcess32First;
  Process32Next: TProcess32Next;

  function IsWinNT4: Boolean;
  begin
    Result := ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion <= 4));
  end;

  function IsWinVista: Boolean;
  begin
    Result := ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 6));
  end;

  function FindProcess(PID: DWord): Integer;
  var
    LowIdx, HighIdx, Idx: Integer;
  begin
    Result := -1;

    LowIdx := 0;
    HighIdx := (ProcessesList.Count - 1);

    while (LowIdx <= HighIdx) do
    begin
      Idx := ((LowIdx + HighIdx) shr 1);
      if (PID > ProcessesList[Idx]^.ProcessID) then LowIdx := (Idx + 1)
      else
        if (PID < ProcessesList[Idx]^.ProcessID) then HighIdx := (Idx - 1)
        else
          if (PID = ProcessesList[Idx]^.ProcessID) then
          begin
            Result := Idx;
            Exit;
          end;
    end;
  end;

  function GetAllocatedMemory(Process: THandle): Integer;
  var
    PMC: PROCESS_MEMORY_COUNTERS;
  begin
    Result := 0;
    if (not Assigned(GetProcessMemoryInfo)) then Exit;

    if GetProcessMemoryInfo(Process, @PMC, SizeOf(PMC)) then
      Result := PMC.WorkingSetSize;
  end;

  procedure FillThreadsCount;
  var
    SnapProcHandle: THandle;
    ThreadEntry: TThreadEntry32;
    Next: Boolean;
    Idx: Integer;
  begin
    if (not Assigned(CreateToolhelp32Snapshot)) or
      (not Assigned(Thread32First)) or (not Assigned(Thread32Next)) then Exit;

    if (ProcessesList.Count = 0) then Exit;

    Idx := 0;
    SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
    if (SnapProcHandle <> THandle(-1)) then
    begin
      FillChar(ThreadEntry, SizeOf(ThreadEntry), #0);
      ThreadEntry.dwSize := Sizeof(ThreadEntry);
      Next := Thread32First(SnapProcHandle, ThreadEntry);
      while Next do
      begin
        if (Idx <> -1) and
          (ProcessesList[Idx]^.ProcessID = ThreadEntry.th32OwnerProcessID) then
          Inc(ProcessesList[Idx]^.Threads)
        else
        begin
          Idx := FindProcess(ThreadEntry.th32OwnerProcessID);
          if (Idx <> -1) then Inc(ProcessesList[Idx]^.Threads);
        end;
        Next := Thread32Next(SnapProcHandle, ThreadEntry);
      end;
      CloseHandle(SnapProcHandle);
    end;
  end;

  procedure FillHeapsCount;
  var
    SnapProcHandle: THandle;
    ThreadEntry: TThreadEntry32;
    Next: Boolean;
    Idx: Integer;
  begin
    if (not Assigned(CreateToolhelp32Snapshot)) or
      (not Assigned(Thread32First)) or (not Assigned(Thread32Next)) then Exit;

    if (ProcessesList.Count = 0) then Exit;

    Idx := 0;
    SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0);
    if (SnapProcHandle <> THandle(-1)) then
    begin
      FillChar(ThreadEntry, SizeOf(ThreadEntry), #0);
      ThreadEntry.dwSize := Sizeof(ThreadEntry);
      Next := Thread32First(SnapProcHandle, ThreadEntry);
      while Next do
      begin
        if (Idx <> -1) and
          (ProcessesList[Idx]^.ProcessID = ThreadEntry.th32OwnerProcessID) then
          Inc(ProcessesList[Idx]^.Threads)
        else
        begin
          Idx := FindProcess(ThreadEntry.th32OwnerProcessID);
          if (Idx <> -1) then Inc(ProcessesList[Idx]^.Threads);
        end;
        Next := Thread32Next(SnapProcHandle, ThreadEntry);
      end;
      CloseHandle(SnapProcHandle);
    end;
  end;

  procedure AddNewProcess(PID: DWord; const ExeName: string);
  var
    Handle: THandle;
    Len: DWord;
    ProcessInfo: PEurekaProcessInfo;
    Name: string;
  begin
    Handle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, PID);

    if (Handle <> 0) then
    try
      // Get process Name...
      Name := '';
      if (Assigned(GetModuleFileNameEx)) then
      begin
        SetLength(Name, MAX_PATH);
        Len := GetModuleFileNameEx(Handle, 0, PChar(Name), MAX_PATH);
        if (Len > 0) then SetLength(Name, Len)
        else Name := '';
      end;
      if (Name = '') then Name := ExeName;

      Name := Trim(Name);

      if (Name = '') then Exit;

      New(ProcessInfo);
      ProcessInfo^.Name := Name;

      // Get process Description and Version...
      GetModuleDescriptionAndVersion(ProcessInfo^.Name,
        ProcessInfo^.Description, ProcessInfo^.Version);

      // Get other process Data...
      ProcessInfo^.ProcessID := PID;
      ProcessInfo^.Priority := GetPriorityClass(Handle);
      ProcessInfo^.Memory := GetAllocatedMemory(Handle);
      ProcessInfo^.Threads := 0;

      ProcessesList.Add(ProcessInfo);
    finally
      CloseHandle(Handle);
    end;
  end;

  procedure AddNewProcessEx(ProcessEntry: TProcessEntry32);
  var
    ProcessInfo: PEurekaProcessInfo;
    Name: string;

    function RealPriority(Priority: DWord): DWord;
    begin
      if (Priority = 0) then Result := 0
      else
        if (Priority < 6) then Result := $40
        else
          if (Priority < 8) then Result := $4000
          else
            if (Priority < 10) then Result := $20
            else
              if (Priority < 13) then Result := $8000
              else
                if (Priority < 24) then Result := $80
                else Result := $100;
    end;

    function FindFullPath(const ModuleName: string; ProcessID: DWord): string;
    var
      Module32First: function(Hdl: THandle; var Info: TModuleInfo): LongBool; stdcall;
      Module32Next: function(Hdl: THandle; var Info: TModuleInfo): LongBool; stdcall;
      MName: string;
      LibHdl, Hdl: THandle;
      ModuleInfo: TModuleInfo;
      NextModule: Boolean;
    begin
      Result := ModuleName;

      LibHdl := LoadLibrary(Kernel32);
      if (LibHdl <> 0) then
      try
        CreateToolhelp32Snapshot := GetProcAddress(LibHdl, 'CreateToolhelp32Snapshot');
        Module32First := GetProcAddress(LibHdl, 'Module32First');
        Module32Next := GetProcAddress(LibHdl, 'Module32Next');
        if (Assigned(CreateToolhelp32Snapshot)) and
          (Assigned(Module32First)) and (Assigned(Module32Next)) then
        begin
          Hdl := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, ProcessID);
          if (Hdl <> INVALID_HANDLE_VALUE) then
          try
            FillChar(ModuleInfo, SizeOf(ModuleInfo), #0);
            ModuleInfo.dwSize := SizeOf(ModuleInfo); // Needed information.
            NextModule := Module32First(Hdl, ModuleInfo);
            while (NextModule) do
            begin
              MName := ModuleInfo.szModule;
              if (CompareText(MName, ModuleName) = 0) then
              begin
                Result := ModuleInfo.szExePath;
                Exit;
              end;
              NextModule := Module32Next(Hdl, ModuleInfo);
            end;
          finally
            CloseHandle(Hdl);
          end;
        end;
      finally
        FreeLibrary(LibHdl);
      end;
    end;

{    function GetProcessMemorySize(ProcessID: DWord): DWord;
    var
      GetProcessHandleFromHwnd: function(Wnd: HWnd): THandle;
      HLib, HProc, HWnd, DupH: THandle;
    begin
      Result := 0;

      HLib := LoadLibrary('Oleacc.dll');
      if (HLib <> 0) then
      try
        GetProcessHandleFromHwnd := GetProcAddress(HLib, 'GetProcessHandleFromHwnd');
        if (Assigned(GetProcessHandleFromHwnd)) then
        begin
          HWnd := GetFirstWindow(ProcessID);
          if (HWnd <> 0) then
          begin
            HProc := GetProcessHandleFromHwnd(HWnd);
            if (HProc <> 0) then
            try
              if (DuplicateHandle(GetCurrentProcess, HProc, GetCurrentProcess, @DupH,
                PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, 0)) then
              begin
                Result := GetAllocatedMemory(DupH);
                CloseHandle(DupH);
              end;
            finally
//              CloseHandle(HProc);
            end;
          end;
        end;
      finally
        FreeLibrary(HLib);
      end;
    end;}

  begin
    Name := ProcessEntry.szExeFile;

    if (Name = '') then Exit;

    if (ExtractFileExt(Name) <> '') then
      Name := Trim(FindFullPath(Name, ProcessEntry.th32ProcessID));

    New(ProcessInfo);
    ProcessInfo^.Name := Name;

    // Get process Description and Version...
    if (ExtractFileExt(Name) <> '') then
      GetModuleDescriptionAndVersion(ProcessInfo^.Name,
        ProcessInfo^.Description, ProcessInfo^.Version);

    // Get other process Data...
    ProcessInfo^.ProcessID := ProcessEntry.th32ProcessID;
    ProcessInfo^.Priority := RealPriority(ProcessEntry.pcPriClassBase);
    ProcessInfo^.Memory := 0; // GetProcessMemorySize(ProcessEntry.th32ProcessID);
    ProcessInfo^.Threads := ProcessEntry.cntThreads;
    ThreadsCounted := True;

    ProcessesList.Add(ProcessInfo);
  end;

  procedure BuildListTH;
  var
    SnapProcHandle: THandle;
    ProcEntry: TProcessEntry32;
    NextProc: Boolean;
  begin
    if (not Assigned(CreateToolhelp32Snapshot)) or
      (not Assigned(Process32First)) or (not Assigned(Process32Next)) then Exit;

    SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (SnapProcHandle <> INVALID_HANDLE_VALUE) then
    try
      ProcEntry.dwSize := SizeOf(ProcEntry);
      NextProc := Process32First(SnapProcHandle, ProcEntry);
      while NextProc do
      begin
        if (IsWinVista) then AddNewProcessEx(ProcEntry)
        else AddNewProcess(ProcEntry.th32ProcessID, ProcEntry.szExeFile);
        NextProc := Process32Next(SnapProcHandle, ProcEntry);
      end;
    finally
      CloseHandle(SnapProcHandle);
    end;
  end;

  procedure BuildListPS;
  var
    PIDs: array [0..1024] of DWord;
    Needed: DWord;
    I: Integer;
  begin
    if (not Assigned(EnumProcesses)) then Exit;

    if (EnumProcesses(@PIDs, SizeOf(PIDs), Needed)) then
    begin
      for I := 0 to (Needed div 4 - 1) do
      begin
        AddNewProcess(PIDs[I], '');
      end;
    end;
  end;

begin
  ThreadsCounted := False;

  ProcessesList.Clear;

  PsLib := LoadLibrary('PSAPI.dll');
  KernelLib := GetModuleHandle('Kernel32.dll');
  try
    //PaAPI ...
    @GetProcessMemoryInfo := GetProcAddress(PsLib, 'GetProcessMemoryInfo');
    @GetModuleFileNameEx := GetProcAddress(PsLib, 'GetModuleFileNameExA');
    @EnumProcesses := GetProcAddress(PsLib, 'EnumProcesses');

    // Kernel32 ...
    @CreateToolhelp32Snapshot := GetProcAddress(KernelLib, 'CreateToolhelp32Snapshot');
    @Thread32First := GetProcAddress(KernelLib, 'Thread32First');
    @Thread32Next := GetProcAddress(KernelLib, 'Thread32Next');
    @Process32First := GetProcAddress(KernelLib, 'Process32First');
    @Process32Next := GetProcAddress(KernelLib, 'Process32Next');

    if IsWinNT4 then BuildListPS
    else BuildListTH;

    ProcessesList.Sort(@CompareProcessesFunctions);
    if (not ThreadsCounted) then FillThreadsCount;

  finally
    if (PsLib <> 0) then FreeLibrary(PsLib);
  end;
end;

// This function return the InitTable...

function ModuleInitTable: PackageInfo;
begin
{$IFDEF Delphi6Down}
  Result := PPointer(DWord(@AllocMemSize) + $84)^;
{$ELSE}
  {$IFDEF Delphi9Down}
    Result := PInitContext(DWord(@AllocMemSize) + $80).InitTable;
  {$ELSE}
    Result := PInitContext(DWord(@AllocMemSize) + $2218).InitTable
  {$ENDIF}
{$ENDIF}
end;

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Generic functions...
//------------------------------------------------------------------------------

// Convert a Logical address to Phisical address...
function LogicToPhysicAddr(HModule: THandle; Addr: DWord): DWord;
begin
  Result := (HModule + $1000 + Addr);
end;

//------------------------------------------------------------------------------

// Check for Console CGI Application...

function IsCGI: boolean;
begin
  Result := (IsConsole) and (GetEnvironmentVariable('REQUEST_METHOD', nil, 0) > 0);
end;

// Check for Windows CGI Application...

function IsWinCGI: boolean;

  function InternalFileExists(const FileName: string): Boolean;
  var
    HFile: Integer;
  begin
    Result := (Pos('*', FileName) = 0) and (Pos('?', FileName) = 0) and
      (FileExists(FileName));
    if (Result) then
    begin
      HFile := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
      Result := (HFile >= 0);
      if (Result) then FileClose(HFile);
    end;
  end;

begin
  Result := False;
  if (not IsConsole) and (InternalFileExists(ParamStr(1))) and
    (GetFileSize(ParamStr(1)) <= 102400 {100 Kb}) then
  begin
    if (ReadString(ParamStr(1), 'CGI', 'Request Method', '') <> '') then
    begin
      CGIOutputFile := ParamStr(3);
      if (CGIOutputFile = '') then
        CGIOutputFile := ReadString(ParamStr(1), 'System', 'Output File', '');
      Result := (FileExists(CGIOutputFile));
    end;
  end;
end;

// Check for ISAPI Application...

function IsISAPI: boolean;
begin
  Result := (IsModuleLibrary(HInstance)) and
    (GetProcAddress(HInstance, 'HttpExtensionProc') <> nil);
  //  Result := (ServerECB <> nil);
end;

// Check for IntraWeb Application...

function IsIntraWeb: boolean;
begin
  Result := (@IntraWeb_CreateServer <> nil);
end;

// Check is the Application is a WEB-Application...

function IsWeb: boolean;
begin
  Result := (IsISAPI) or (IsCGI) or (IsWinCGI) or (IsIntraWeb);
end;

// Check for GUI Application...

function IsGUI: boolean;
begin
  Result := (not ((IsWeb) or (IsConsole)));
end;
{
function IsGUI: boolean;
var
  TmpClass: TWndClass;
begin
  Result := (not IsWeb) and (not IsConsole) and
    (GetClassInfo(HInstance, 'TApplication', TmpClass));
end;}

function WriteHTMLToWeb(Txt: string): Boolean;
const
  HTTPCode = 200; // HTTP result code (200 = OK  -  500 = Internal Server Error)
var
  ResultHeaders: string;
  Size: DWORD;
  OutFile: TStream;
begin
  Result := True;
  ResultHeaders := Format(
    ifStr(IsCGI or IsWinCGI, 'Status: ' + IntToStr(HTTPCode) + ' Error'#13#10) +
    'Content-Type: text/html'#13#10 +
    'Content-Length: %d'#13#10 +
    'Content:'#13#10#13#10, [Length(Txt)]);

  if (IsISAPI) then // ISAPI...
  begin
    if (ServerECB <> nil) then // Check to Initialization exceptions...
    begin
      ISAPI_SendError := True;
      try
        ServerECB.dwHTTPStatusCode := HTTPCode;
        ServerECB.ServerSupportFunction(ServerECB.ConnID, 3,
          PChar(IntToStr(HTTPCode) + ' Error'), @Size, LPDWORD(ResultHeaders));
        Size := Length(Txt);
        ServerECB.WriteClient(ServerECB.ConnID, Pointer(Txt), Size, 0);
      finally
        ISAPI_SendError := False;
      end;
    end
    else
    begin
      Result := False;
      SetInternalError(eeShowError, 'ISAPI: ServerECB = nil');
    end;
  end
  else
    if (IsCGI) then // Console CGI...
    begin
      Result := (FileWrite(TTextRec(Output).Handle,
        Pointer(ResultHeaders)^, Length(ResultHeaders))) <> -1;
      if Result then
        FileWrite(TTextRec(Output).Handle, Pointer(Txt)^, Length(Txt))
      else
      begin
        SetInternalError(eeShowError, 'CGI: Cannot write in the ouput file.');
      end;
    end
    else
      if (IsWinCGI) then // Windows CGI...
      begin
        try
          if FileExists(CGIOutputFile) then
            OutFile := TFileStream.Create(CGIOutputFile,
              fmOpenWrite or fmShareDenyNone)
          else
            OutFile := TFileStream.Create(CGIOutputFile, fmCreate);
          try
            OutFile.Write(Pointer(ResultHeaders)^, Length(ResultHeaders));
            OutFile.Write(Pointer(Txt)^, Length(Txt));
          finally
            OutFile.Free;
          end;
        except
          Result := False;
          SetErrorType(eeShowError, 'WinCGI');
        end;
      end
end;

function CreateHTMLByLayout(const Text: string): string;
const
  HTML_TAG = '<%HTML_TAG%>';
var
  Idx0, Idx1: Integer;
  Layout: string;
  EurekaModuleOptions: TEurekaModuleOptions;
begin
  Result := '';
  if (Trim(OneString(CurrentOptions.HTMLLayout)) <> '') then
    Layout := CurrentOptions.HTMLLayout
  else
  begin
    EurekaModuleOptions := TEurekaModuleOptions.Create('', False);
    try
      Layout := EurekaModuleOptions.HTMLLayout; // Set to default data.
    finally
      EurekaModuleOptions.Free;
    end;
  end;

  // Convert the HTML_TAG in UpperCase...
  Idx0 := Pos(LowerCase(HTML_TAG), LowerCase(Layout));
  if (Idx0 > 0) then
  begin
    Delete(Layout, Idx0, Length(HTML_TAG));
    Insert(HTML_TAG, Layout, Idx0);
  end;

  // Check for a "title"...
  Idx0 := Pos('<title>', LowerCase(Layout));
  Idx1 := Pos('</title>', LowerCase(Layout));
  if ((Idx0 <= 0) or (Idx1 < Idx0)) then
    Layout := (Format('<title>%s</title>',
      [CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]]) + Layout);

  Global_WebTextID := Format('<!-- EurekaLog ID: %s -->', [IntToHex(Random(Integer($FFFFFFFF)), 8)]);

  // Replace the HTML_TAG with the relative Text...
  Result := QuickStringReplace(Layout, HTML_TAG, Text) + Global_WebTextID;
end;

function GenerateHTML(const Text: string; AddOKButton: Boolean): string;
begin
  if (AddOKButton) then
    Result := CreateHTMLByLayout(TextToHTML(Text) + JavaScriptOKButton)
  else
    Result := CreateHTMLByLayout(TextToHTML(Text));
end;

function WriteTextToIntraWeb: Boolean;
const
  IWShowMessageButton_TAG = '{%butnOk%}';
  IWShowMessage_TAG = ('<br>' + IWShowMessageButton_TAG);
  TemplateName = 'EurekaLog_IWShowMessage.html';
var
  HTML, TemplateDir, NewDir, TemplateFile: string;
  TemplateCreated: Boolean;

  function DirectoryExists(const Directory: string): Boolean;
  var
    Code: Integer;
  begin
    Code := GetFileAttributes(PChar(Directory));
    Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
  end;

  function CreateTemplateFile(const HTMLCode, TemplateFileName: string): Boolean;
  var
    FilePath: string;
    Handle: Integer;
  begin
    FilePath := ExtractFilePath(TemplateFileName);
    Result := (DirectoryExists(FilePath) or CreateDir(FilePath));
    if (Result) then
    begin
      Handle := FileCreate(TemplateFileName);
      Result := (Handle >= 0);
      if (Result) then
      begin
        Result := (FileWrite(Handle, Pointer(HTMLCode)^, Length(HTMLCode)) = Length(HTMLCode));
        FileClose(Handle);
      end;
    end;
  end;

begin
  Result := False;
  if (IntraWebApplication <> nil) and (IntraWebServerController <> nil) then
  begin
    try
      Global_IntraWebText := TextToHtml(Global_IntraWebText);

      HTML := CreateHTMLByLayout(Global_IntraWebText + IWShowMessage_TAG);

      if (Pos(LowerCase(IWShowMessageButton_TAG), LowerCase(HTML)) = 0) then
        HTML := (HTML + IWShowMessageButton_TAG);

      TemplateDir := Trim(GetStrProp(IntraWebServerController,
        GetPropInfo(IntraWebServerController.ClassInfo, 'TemplateDir')));
      NewDir := TempPath;

      if (LowerCase(ExtractFileDrive(NewDir)) = LowerCase(ExtractFileDrive(TemplateDir))) then
        TemplateCreated := CreateTemplateFile(HTML, NewDir + TemplateName)
      else TemplateCreated := False;

      if (not TemplateCreated) then
      begin
        NewDir := (ExtractFileDrive(TemplateDir) + '\Temp\');
        TemplateCreated := CreateTemplateFile(HTML, NewDir + TemplateName);
      end;
      if (not TemplateCreated) then
      begin
        NewDir := TemplateDir;
        TemplateCreated := CreateTemplateFile(HTML, NewDir + TemplateName);
      end;

      if (TemplateCreated) then
        TemplateFile := ExtractRelativePath(TemplateDir, NewDir + TemplateName)
      else TemplateFile := '';

      try
        IntraWeb_ShowMessage(IntraWebApplication, Global_IntraWebText,
          smSameWindow, TemplateFile);
      except
        SetInternalError(eeShowError, 'IntraWeb: Cannot show the error page.');
      end;
      if (not TemplateCreated) then
        SetInternalError(eeShowError,
          Format('IntraWeb: Cannot create the "%s" template.', [NewDir + TemplateName]));
      Result := True;
    except
      SetErrorType(eeShowError, 'IntraWeb');
    end;
  end
  else
    SetInternalError(eeShowError, 'IntraWeb: IntraWebApplication e/o ' +
      'IntraWebServerController are set to nil.');
end;

// A WORKAROUND about a "6.0, 6.0.1, 6.0.2 RC 1" bug on version saving...
procedure VersionWorkAround(var Version: Word);
begin
  if ((Version >= 600) and (Version <= 602)) then
    Version := (6000 + Version mod 600);
end;

function IsLocalStorageProc(Addr: Pointer): Boolean;
begin
  Result := (IsValidBlockAddr(DWord(Addr), 1)) and (PByte(Addr)^ = $53);
end;

function IsStackFramesProc(Addr: Pointer): Boolean;
var
  Ptr: PStackFrame;
begin
  Ptr := PStackFrame(Addr);
  Result := (IsValidBlockAddr(DWord(Addr), 3)) and
    (Ptr^.Push = $55) and (Ptr^.Mov = $EC8B);
end;

function IsRTLCompiledWithStackFrames: Boolean;
begin
{$IFDEF Delphi10Up}
  Result := IsStackFramesProc(@System.AllocMem);
{$ELSE}
  Result := IsStackFramesProc(@SysUtils.AllocMem);
{$ENDIF}
end;

function IsCompiledWithPackages: Boolean;
begin
  Result := (DWord(FindClassHInstance(System.TObject)) <> DWord(HInstance));
end;

function ExceptionTypeByAddr(Addr: DWord): TExceptionType;
var
  GoAddr: DWord;
begin
  Result := etUnknown;
  Inc(Addr);
  if IsValidBlockAddr(Addr, SizeOf(Addr)) then
  begin
    GoAddr := ConvertAddress(Addr + PDWord(Addr)^ + 4);
    if (GoAddr = HandleAnyExceptionAddr_Variable) then
      Result := etHandleAnyException
    else
      if (GoAddr = HandleOnExceptionAddr_Variable) then
        Result := etHandleOnException
      else
        if (GoAddr = HandleAutoExceptionAddr_Variable) then
          Result := etHandleAutoException;
  end;
end;

function Is_HandleOnException_Handled(Obj: TObject;
  HandleOnException_Table: Pointer; var StartExceptionBlock: DWord): boolean;
var
  n, i: DWord;
  ClassType: TClass;
  Addr: PDWord;
begin
  Addr := HandleOnException_Table;
  // Read the number of "On 'exception type' Do ..." phrases...
  n := Addr^;
  // Move to the first pointer to TClass type...
  inc(Addr);
  i := 0;
  repeat
    // Read the ClassType of 'i'th 'On ... do ...' phrase...
    if IsCompiledWithPackages then
    begin
      if ((IsValidBlockAddr(DWord(Addr), 4)) and
        (IsValidBlockAddr(DWord(Addr^), 4))) then
        ClassType := TClass(PPointer(Addr^)^)
      else
        ClassType := nil;
    end
    else
    begin
      ClassType := TClass(PDWord(Addr^));
      if ClassType <> nil then
        Inc(Integer(ClassType), -vmtSelfPtr);
    end;
    Inc(Addr);
    StartExceptionBlock := Addr^;
    // Skip Address code to execute where Exception type is ClassType...
    Inc(Addr);
    Inc(i);
  until (i = n) or (ClassType = nil) or (IsAParent(Obj, ClassType));
  Result := (ClassType = nil) or (IsAParent(Obj, ClassType));
end;

function GetResourceData(Module: THandle; ResName,
  ResType: PChar; var Size: DWord): Pointer;
var
  InfoBlock: HRSRC;
  GlobalMemoryBlock: HGLOBAL;
begin
  Result := nil;
  InfoBlock := FindResource(Module, ResName, ResType);
  if (InfoBlock <> 0) then
  begin
    Size := SizeofResource(Module, InfoBlock);
    GlobalMemoryBlock := LoadResource(Module, InfoBlock);
    if (GlobalMemoryBlock <> 0) then Result := LockResource(GlobalMemoryBlock);
  end;
end;

// This function Decrypt the string...
function ReadEncodeString(ModuleInfo: PEurekaModuleInfo; Infos: TStream): ShortString;
var
  i: integer;
  b: byte;
  ClassAndProcEncode: Boolean;
begin
  ClassAndProcEncode := False;
  Infos.Read(b, 1);
  if (ModuleInfo^.ExtraInformation.EurekaVersion >= 502) then
  begin
    if (b >= $80) then // ClassName + ProcName encoding...
    begin
      b := (b and $7F);
      ClassAndProcEncode := True;
    end;
  end;
  SetLength(Result, b);
  Infos.Read(Result[1], b);

  if (ModuleInfo^.ExtraInformation.EurekaVersion >= 500) then
  begin
    if (ModuleInfo^.IsValidEncryptPassword) then
    begin
      if (Global_LastInitPassword <> ModuleInfo^.EncryptPassword) then
      begin
        InitKey(ModuleInfo^.EncryptPassword);
        Global_LastInitPassword := ModuleInfo^.EncryptPassword;
      end;
      Decrypt(Result[1], Result[1], Length(Result));
    end
    else
      if (Result <> '') then Result := '?' + Base64EncodeString(Result);
    if (ClassAndProcEncode) then
      Result := (Result + '.' + ReadEncodeString(ModuleInfo, Infos));
  end
  else
  begin
    // $62 increase the compression rate (~2.5%)
    for i := 1 to Length(Result) do
      Result[i] := Char(Integer(Result[i]) xor $62)
  end;
end;

function GetSourceInfoByAddr(Addr: DWord; DebugInfo: PEurekaDebugInfo): Boolean;
var
  ModuleInfo: PEurekaModuleInfo;
  Infos: TMemoryStream;
  UnitName, ProcedureName, LastProcName, ClassName,
    LastValidClass, LastProcedureClass: ShortString;
  LastLine, FirstLine, StartAddr, LastAddr, LineAddr,
    UnitSize, NextUnit, AddrDiff: DWord;
  LineDiff: SmallInt;
  LineNo: Integer;
  LastProcLineNo, ProcedureLineNo: DWord;
  LastProcAddr, ProcAddr: Pointer;
  UnitsNumber, SymbolSize: Integer;
  b: Byte;
  w: Word;
  d: DWord;
  LastProcOK, ProcedureOK: Boolean;
  i, SepIdx: Integer;
  Ver, Idx: Integer;

  function CheckForResult(HModule: THandle; Addr, StartAddr, EndAddr,
    LineNo: DWord; var Info: PEurekaDebugInfo): boolean;
  var
    Offset: Integer;
  begin
    Result := (Addr >= LogicToPhysicAddr(HModule, StartAddr)) and
      (Addr <= LogicToPhysicAddr(HModule, EndAddr));
    if Result then
    begin
      Info^.DebugDetail := ddSourceCode;
      Info^.Addr := Addr;
      Info^.UnitName := UnitName;
      Info^.ClassName := LastProcedureClass;
      Info^.ProcedureName := LastProcName;
      Info^.Line := LineNo;
      if (ProcAddr <> nil) then
      begin
        if (LastProcName = 'Finalization') or
          ((LastProcName <> 'Initialization') and (not IsStackFramesProc(LastProcAddr)) and
            (not IsLocalStorageProc(LastProcAddr))) then Dec(LastProcLineNo);
        Offset := (Integer(LineNo) - Integer(LastProcLineNo));
      end
      else Offset := 0;
      if (Offset >= 0) then Info^.ProcOffsetLine := DWord(Offset)
      else Info^.ProcOffsetLine := 0;
    end;
  end;

begin
  Result := False;
  ModuleInfo := ModuleInfoByAddr(Addr);

  // Check if module is in memory (ModuleInfo <> nil) ...
  // Check if module have Debug Information (ModuleInfo^.DebugInformation <> nil) ...
  if (ModuleInfo <> nil) and
    (ModuleInfo^.ExtraInformation.DebugInformation <> nil) then
  begin
    Infos := ModuleInfo^.ExtraInformation.DebugInformation;
    Infos.Position := 0;

    Ver := ModuleInfo^.ExtraInformation.EurekaVersion;

    // Skip Symbols info (from EurekaLog 4.0.5 to < 5.0)...
    if (Ver >= 405) and (Ver < 500) then
    begin
      // Read the Symbols size...
      Infos.Read(SymbolSize, 4);
      Infos.Position := Infos.Position + SymbolSize;
    end;

    // Read the DEBUG infos (details)...
    Infos.Read(UnitsNumber, 4);
    i := 0;
    while (i <= UnitsNumber - 1) and (not Result) do
    begin
      ProcedureLineNo := 0;
      LastProcLineNo := 0;
      ProcAddr := nil;
      LastProcAddr := nil;
      UnitName := ReadEncodeString(ModuleInfo, Infos);
      if (not ModuleInfo^.IsValidEncryptPassword) then
        Insert({$IFNDEF CBuilder} 'p' {$ELSE} 'c' {$ENDIF}, UnitName, 2);
      if ((Pos('.', UnitName) = 0) and (ModuleInfo^.IsValidEncryptPassword)) then
        UnitName := UnitName + DefaultSourceExt;
      Infos.Read(FirstLine, 4);
      Infos.Read(StartAddr, 4);
      Infos.Read(UnitSize, 4);
      Infos.Read(NextUnit, 4);
      NextUnit := NextUnit + DWord(Infos.Position);
      LastLine := FirstLine;
      LastAddr := StartAddr;
      ProcedureName := '';
      LastProcName := '';
      ClassName := '';
      LastValidClass := '';
      LastProcedureClass := '';
      ProcedureOK := False;
      if (Addr >= LogicToPhysicAddr(ModuleInfo^.Handle, StartAddr)) and
        (Addr <= LogicToPhysicAddr(ModuleInfo^.Handle, StartAddr + UnitSize - 1)) then
      begin
        repeat
          LastProcOK := ProcedureOK;
          if LastProcOK then
          begin
            LastProcLineNo := ProcedureLineNo;
            LastProcAddr := ProcAddr;
          end;
          Infos.Read(b, 1);
          // 1 byte (2 bits Line, 5 bits Addr - w/o ProcName)
          if (b and 1 = 0) then
          begin
            b := b shr 1; // Shift to right for 1 bit.
            ProcedureOK := False;
            LineDiff := (b shr 5) + 1;
            AddrDiff := (b and 31) + 1;
          end
          else
          begin
            // 1 byte (3 bits Line, 3 bits Addr - with ProcName)
            if (b and 2 = 0) then
            begin
              b := b shr 2; // Shift to right for 2 bits.
              ProcedureOK := True;
              LineDiff := (b shr 3) + 1;
              AddrDiff := (b and 7) + 1;
            end
            else
            begin
              ProcedureOK := (b and 4 <> 0);
              if (b and 8 = 0) then
              begin // 2 bytes (5 bits Line, 7 bits Addr)
                Infos.Position := Infos.Position - 1;
                Infos.Read(w, 2);
                w := w shr 4; // Shift to right for 4 bits.
                LineDiff := (w shr 7) + 1;
                AddrDiff := (w and $7F) + 1;
              end
              else
              begin // 4 bytes (12 bits Addr, 16 bits Line as SmallInt)
                Infos.Position := Infos.Position - 1;
                Infos.Read(d, 4);
                d := d shr 4; // Shift to right for 4 bits.
                if (D <> $0FFEFFFE) or (Ver < 423) then
                begin
                  LineDiff := (d and $FFFF) + 1;
                  AddrDiff := (d shr 16);
                  if AddrDiff = $FFF then AddrDiff := 0 // $FFF = Overflowed -1
                  else Inc(AddrDiff);
                end
                else
                begin // other 8 bytes
                  Infos.Read(LineDiff, 2);
                  Inc(LineDiff);
                  Infos.Read(W, 2);
                  AddrDiff := W + 1;
                end;
              end;
            end;
          end;
          LineNo := Integer(LastLine) + LineDiff;
          LineAddr := LastAddr + AddrDiff;
          if ProcedureOK then
          begin
            ProcedureLineNo := LineNo;
            ProcAddr := Pointer(LogicToPhysicAddr(ModuleInfo^.Handle, LineAddr));
            ProcedureName := ReadEncodeString(ModuleInfo, Infos);
            if (ProcedureName[1] <> '.') then
            begin
              SepIdx := Pos('.', ProcedureName);
              if SepIdx <> 0 then
              begin
                ClassName := Copy(ProcedureName, 1, SepIdx - 1);
                ProcedureName := Copy(ProcedureName, SepIdx + 1, 255);
              end
              else ClassName := '';
            end
            else
            begin
              ClassName := LastValidClass;
              ProcedureName := Copy(ProcedureName, 2, 255);
            end;
            if (ProcedureName <> '') and (ProcedureName[1] = '@') then
              ProcedureName[1] := '_';
            if (ClassName <> '') then LastValidClass := ClassName;
            if (LastProcName = '') then
              LastProcName := ProcedureName;
          end;
          Result := CheckForResult(ModuleInfo^.Handle, Addr,
            LastAddr, LineAddr - 1, LastLine, DebugInfo);
          LastProcName := ProcedureName;
          LastProcedureClass := ClassName;
          LastLine := LineNo;
          LastAddr := LineAddr;
        until (Infos.Position = Integer(NextUnit)) or
          (Result) or (LastAddr > Addr);
        if (not Result) and (Infos.Position = Integer(NextUnit)) then
          Result := CheckForResult(ModuleInfo^.Handle, Addr, LastAddr,
            StartAddr + UnitSize - 1, LineNo, DebugInfo);
      end
      else
        Infos.Position := Integer(NextUnit);
      Inc(i);
    end;
    if ((Result) and (not ShowEurekaLogUnits)) then
    begin
      // Remove EurekaLog units from the call-stack results...
      if (EurekaLogUnitsList.Find(DebugInfo^.UnitName, Idx)) then
      begin
        DebugInfo^.DebugDetail := ddModule;
        DebugInfo^.UnitName := '';
        DebugInfo^.ClassName := '';
        DebugInfo^.ProcedureName := '';
        DebugInfo^.ProcOffsetLine := 0;
        DebugInfo^.Line := 0;
        Result := False;
      end;
    end;
  end;
end;

function GetSymbolAddr(ID: Byte): Pointer;
var
  ResStream: TStream;
  SymbolsSize, LastPos: Integer;
  SymbolID: Byte;
  SymbolAddress, SymbolSize, MagicWord, ResSize: DWord;
  Ver: Word;
  CompilationDate: TDateTime;
  ResData: Pointer;
  UseMemoryLeaksCheck, UseMainModuleOptions: Boolean;
begin
  Result := nil;
  ResData := GetResourceData(HInstance, 'ELDATA', RT_RCDATA, ResSize);
  if (ResData <> nil) then
  begin
    ResStream := THModuleStream.Create(DWord(ResData));
    try
      // Read the EurekaLog MagicNumber
      ResStream.Read(MagicWord, 4);

      if (CheckMagicCode(MagicWord)) then
      begin
        // Read the EurekaLog version...
        ResStream.Read(Ver, 2);

        VersionWorkAround(Ver);

        // Read the Compilation Date...
        ResStream.Read(CompilationDate, 8);

        ResStream.Read(UseMemoryLeaksCheck, 1);

        ResStream.Read(UseMainModuleOptions, 1);

        // Read the Symbols info...
        ResStream.Read(SymbolsSize, 4);
        LastPos := (ResStream.Position + SymbolsSize);
        SymbolID := 255;
        while (ResStream.Position < LastPos) and (SymbolID <> ID) do
        begin
          ResStream.Read(SymbolID, 1);
          ResStream.Read(SymbolAddress, 4);
          ResStream.Read(SymbolSize, 4);
        end;
        if (SymbolID = ID) then
          Result := Pointer(LogicToPhysicAddr(HInstance, SymbolAddress));
      end;

    finally
      ResStream.Free;
    end;
  end;
end;

//------------------------------------------------------------------------------
//
// if (1?char = @) then (BPL)
//   if (2?char <> $) then
//
//     1)...delete all chars from $ char
//     if (last char <> @) then
//
//       1)...delete 1?char
//       2)...replace all @ with . (the @@ chars replace with .@)
//       3)...if found 2 or 3 words separated with . then
//
//         1)...3 workd --> unit, class, method
//         2)...2 words --> unit, procedure
//
// else
//
//   if (found . char) then (DPL)
//     if (not found .. chars) then
//
//       1)...delete all chars from @ char (starting from 2?position after . char)
//       2)...if found 2 or 3 words separated with . then
//
//         1)...3 workd --> unit, class, method
//         2)...2 words --> unit, procedure
//
//   else (DLL)
//
//     only one word --> procedure
//
//------------------------------------------------------------------------------

function GetDebugPartialInfo(LineStr: string; DebugInfo: PEurekaDebugInfo): Boolean;
var
  i: integer;

  procedure ExtractStr;
  var
    p, i: integer;
    List: TStringList;
  begin
    List := TStringList.Create;
    i := 1;
    p := i;
    repeat
      while (i <= length(LineStr)) and (LineStr[i] <> '.') do
        Inc(i);
      List.Add(Copy(LineStr, p, i - p));
      inc(i);
      p := i;
    until (i > length(LineStr));
    case List.Count of
      2:
        begin
          DebugInfo^.UnitName := List[0] + '.pas';
          DebugInfo^.ClassName := '';
          DebugInfo^.ProcedureName := List[1];
          DebugInfo^.DebugDetail := ddUnitAndProcedure;
          Result := True;
        end;
      3:
        begin
          DebugInfo^.UnitName := List[0] + '.pas';
          DebugInfo^.ClassName := List[1];
          DebugInfo^.ProcedureName := List[2];
          DebugInfo^.DebugDetail := ddUnitAndProcedure;
          Result := True;
        end;
    end;
    List.Free;
  end;

begin
  Result := False;
  if (LineStr <> '') then
  begin
    if (LineStr[1] = '@') then // BPL
    begin
      if (length(LineStr) > 1) and (LineStr[2] <> '$') then
      begin
        i := Pos('$', LineStr);
        if i <> 0 then
        begin
          LineStr := Copy(LineStr, 1, i - 1);
          if (LineStr <> '') and (LineStr[length(LineStr)] = '@') then
            Delete(LineStr, length(LineStr), 1);
          if (LineStr <> '') then
          begin
            Delete(LineStr, 1, 1);
            i := Pos('@@', LineStr);
            if i > 0 then LineStr[i + 1] := '_'; // System '@' --> '_'
            i := 1;
            while (i <= length(LineStr)) do
            begin
              if (LineStr[i] = '@') then
              begin
                LineStr[i] := '.';
                inc(i); // Skip the second '@' char
              end;
              inc(i);
            end;
            ExtractStr;
          end;
        end;
      end;
    end
    else
      if (Pos('.', LineStr) <> 0) then // DPL
      begin
        i := Pos('@', LineStr);
        if i <> 0 then
          LineStr := Copy(LineStr, 1, i - 1);
        ExtractStr;
      end
      else // DLL
      begin
        if LineStr[1] <> '?' then
        begin
          DebugInfo^.UnitName := '';
          DebugInfo^.ClassName := '';
          DebugInfo^.ProcedureName := LineStr;
          DebugInfo^.DebugDetail := ddProcedure;
          Result := True;
        end;
      end;
  end;
  if (length(DebugInfo^.ProcedureName) > 0) and
    (DebugInfo^.ProcedureName[1] = '@') then
    DebugInfo^.ProcedureName[1] := '_';
end;
//------------------------------------------------------------------------------

// This function return the Function name by memory Address...

procedure GetDebugInfosByAddr(Addr, ThreadID: DWord; DebugInfo: PEurekaDebugInfo;
  RunningThread, ErrorLine: Boolean);
var
  Idx: Integer;

  function FindFunction(Addr: DWord; var Index: Integer; ModuleInfo: PEurekaModuleInfo): Boolean;
  var
    L, H, I, C: Integer;
  begin
    Result := False;
    L := 0;
    H := (ModuleInfo^.FunctionsList.Count - 1);
    while L <= H do
    begin
      I := ((L + H) shr 1);
      if (Addr >= ModuleInfo^.FunctionsList[I]^.Addr) and
        (Addr <= ModuleInfo^.FunctionsList[I]^.Addr +
        ModuleInfo^.FunctionsList[I]^.Size) then C := 0
      else C := (ModuleInfo^.FunctionsList[I]^.Addr - Addr);
      if (C < 0) then L := (I + 1)
      else
      begin
        H := (I - 1);
        if (C = 0) then Result := True;
      end;
    end;
    Index := L;
  end;

  function ExtractDebugData(Addr: Pointer; DebugInfo: PEurekaDebugInfo): Boolean;
  var
    Str1, Str2, Str3: string;
    ELInfo: TELLocationInfo;
  begin
    Result := False;
    if (DebugInfo^.ModuleInfo = nil) or
      (DebugInfo^.ModuleInfo^.OtherDebugData = nil) or
      (not DebugInfo^.ModuleInfo^.OtherDebugData.GetLocationInfo(Addr, ELInfo)) or
      (ELInfo.ProcedureName = '') then Exit;

    DebugInfo^.DebugDetail := ddSourceCode;
    DebugInfo^.Addr := DWord(ELInfo.Address);
    if (ELInfo.UnitName <> '') then
      DebugInfo^.UnitName := ExtractFileName(ELInfo.UnitName)
    else
      DebugInfo^.UnitName := ExtractFileName(ELInfo.SourceName);
    Str1 := ELInfo.ProcedureName;
    Str2 := '';
    Str3 := '';
    Idx := Pos('.', Str1);
    if (Idx > 0) then
    begin
      Str2 := Copy(Str1, (Idx + 1), MaxInt);
      Str1 := Copy(Str1, 1, (Idx - 1));
      Idx := Pos('.', Str2);
      if (Idx > 0) then
      begin
        Str3 := Copy(Str2, (Idx + 1), MaxInt);
        Str2 := Copy(Str2, 1, (Idx - 1));
      end;
    end;
    if (Str1 <> '') and (Str2 <> '') and (Str3 <> '') then
    begin
      DebugInfo^.ClassName := Str2;
      DebugInfo^.ProcedureName := Str3;
    end
    else
    if (Str1 <> '') and (Str2 <> '') then
    begin
      if (CompareText(ChangeFileExt(DebugInfo^.UnitName, ''), Str1) = 0) then
      begin
        DebugInfo^.ClassName := '';
        DebugInfo^.ProcedureName := Str2;
      end
      else
      begin
        DebugInfo^.ClassName := Str1;
        DebugInfo^.ProcedureName := Str2;
      end;
    end
    else
    begin
      DebugInfo^.ClassName := '';
      DebugInfo^.ProcedureName := Str1;
    end;
    if (DebugInfo^.ProcedureName <> '') and (DebugInfo^.ProcedureName[1] = '@') then
      DebugInfo^.ProcedureName[1] := '_';
    DebugInfo^.Line := ELInfo.LineNumber;
    DebugInfo^.ProcOffsetLine := ELInfo.ProcOffsetLine;
    if (DebugInfo^.Line <> 0) then DebugInfo^.DebugDetail := ddSourceCode
    else
      if (DebugInfo^.UnitName <> '') then DebugInfo^.DebugDetail := ddUnitAndProcedure
      else
        if (DebugInfo^.ProcedureName <> '') then DebugInfo^.DebugDetail := ddProcedure
        else
        if (DebugInfo^.ModuleInfo <> nil) then DebugInfo^.DebugDetail := ddModule
        else DebugInfo^.DebugDetail := ddNone;
    Result := True;
  end;

begin
  FillChar(DebugInfo^, SizeOf(DebugInfo^), #0);
  DebugInfo^.ModuleInfo := ModuleInfoByAddr(Addr);
  DebugInfo^.RunningThread := RunningThread;
  DebugInfo^.ErrorLine := ErrorLine;
  DebugInfo^.IsALeak := False;
  DebugInfo^.ThreadID := ThreadID;
  if (not GetSourceInfoByAddr(Addr, DebugInfo)) and
    (not ExtractDebugData(Pointer(Addr), DebugInfo)) then
  begin
    DebugInfo^.DebugDetail := ddNone;
    DebugInfo^.Addr := Addr;
    DebugInfo^.Line := 0;
    if (DebugInfo^.ModuleInfo <> nil) then
    begin
      DebugInfo^.DebugDetail := ddModule;
      if (DebugInfo^.ModuleInfo^.FunctionsList.Count > 0) then
      begin
        if FindFunction(Addr, Idx, DebugInfo^.ModuleInfo) then
          GetDebugPartialInfo(DebugInfo^.ModuleInfo^.FunctionsList[Idx]^.Name, DebugInfo);
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure OpenLogFile;
begin
  if (Opened_LogFile_Name <> ExpandEnvVar(CurrentOptions.OutputLogFile(''))) and
    (Cached_LogFile <> nil) then
  begin
    Cached_LogFile.Free;
    Cached_LogFile := nil;
  end;

  if (Cached_LogFile = nil) then
  begin
    Opened_LogFile_Name := ExpandEnvVar(CurrentOptions.OutputLogFile(''));
    Cached_LogFile := TLogFile.Create(Opened_LogFile_Name, False);
  end;
end;

procedure CloseLogFile;
begin
  if (Cached_LogFile <> nil) then
  begin
    Cached_LogFile.Free;
    Cached_LogFile := nil;
  end;
end;

procedure CalcDuplicatedException(IncCounter: Boolean);
var
  Idx: Integer;
  CountStr: string;
begin
{$IFDEF EUREKALOG_PROFILER}
  mSecCalcDuplicatedTemp := GetTickCount;
{$ENDIF}
  if (CurrentOptions = nil) then Exit;

  if (loNoDuplicateErrors in CurrentOptions.LogOptions) then
  begin
    OpenLogFile;
    try
      Idx := Cached_LogFile.FindItem(['2.7'], [LastBugID]);
      DuplicatedException := (Idx <> -1);

      if ((DuplicatedException) and (IncCounter)) then
      begin
        CountStr := IntToStr(StrToIntDef(Cached_LogFile.GetItemValue('2.8', Idx), 1) + 1);
        Cached_LogFile.SetItemValue('2.8', CountStr, 'Count', Idx);
        Cached_LogFile.Save;
      end;
    finally
      CloseLogFile;
    end;
  end
  else
    DuplicatedException := False;
{$IFDEF EUREKALOG_PROFILER}
  mSecCalcDuplicatedTemp := (GetTickCount - mSecCalcDuplicatedTemp);
  Inc(mSecCalcDuplicated, mSecCalcDuplicatedTemp);
{$ENDIF}
end;

//------------------------------------------------------------------------------

{$IFDEF PROFESSIONAL}
procedure ExtractList(Source: string; List: TStrings; Separators: TCharSet);
var
  i, old: integer;
  s: string;
begin
  old := 1;
  Source := Trim(Source);
  for i := 1 to Length(Source) do
  begin
    if (Source[i] in Separators) then
    begin
      s := Trim(Copy(Source, old, i - old));
      if (s <> '') then List.Add(s);
      old := i + 1;
    end;
  end;
  s := Trim(Copy(Source, old, Length(Source) - old + 1));
  if (s <> '') then List.Add(s);
end;

function GetRealFileName(const FileName: string): string;
begin
  Result := ExtractFileName(FileName);
  if (sndAddComputerNameInFileName  in CurrentOptions.CommonSendOptions) then
    Result := (ChangeFileExt(Result, '') + '__' +
      ComputerName + ExtractFileExt(Result));
  if (sndAddDateInFileName in CurrentOptions.CommonSendOptions) then
    Result := (ChangeFileExt(Result, '') + '__' +
      FormatDateTime('yyyymmddhhnnss', ExceptionTime) + ExtractFileExt(Result));
end;

function SavedScreenshot: string;
begin
  if (sndSendScreenshot in CurrentOptions.CommonSendOptions) then
    Result := TempPath + 'Screenshot.png'
  else
    Result := '';
end;

function TmpScreenshot: string;
begin
  if (CanAttachScreenshot) then Result := SavedScreenshot
  else Result := '';
end;

function TmpLogFileName: string;
begin
  Result := (TempPath + ExtractFileName(ExpandEnvVar(CurrentOptions.OutputLogFile(''))));
end;

function TmpZIPFileName: string;
begin
  Result := TempPath + 'BugReport.zip';
end;

{$IFNDEF CBuilder}

function TmpOptionsFileName: string;
begin
  Result :=
    (TempPath + IntToHex(GetCurrentProcessID, 8) + IntToHex(HInstance, 8) + '.bin');
end;

{$ENDIF}

function RealTmpLastHTMLPage: string;
begin
  if (sndSendLastHTMLPage in CurrentOptions.CommonSendOptions) then
    Result := TempPath + 'LastHTMLPage.html'
  else
    Result := '';
end;

function TmpLastHTMLPage: string;
begin
  if (SavedLastHTMLPage <> '') then Result := RealTmpLastHTMLPage
  else Result := '';
end;

function TmpXMLLogCopy: string;
begin
  if (sndSendXMLLogCopy in CurrentOptions.CommonSendOptions) then
    Result := TempPath + ChangeFileExt(ExtractFileName(ExpandEnvVar(CurrentOptions.OutputLogFile(''))), '.xml')
  else
    Result := '';
end;

procedure CreateHTMLFile(const HTML: string);
var
  S: TStringList;
begin
  if (RealTmpLastHTMLPage = '') then Exit;

  S := TStringList.Create;
  try
    S.Text := HTML;
    try
      S.SaveToFile(RealTmpLastHTMLPage);
    except
      // Nothing...
    end;
  finally
    S.Free;
  end;
end;

procedure CreateXMLLogCopy;
var
  XMLLog: TLogFile;
begin
  if (TmpXMLLogCopy = '') then Exit;

  if (TmpLogFileName <> '') then XMLLog := TLogFile.Create(TmpLogFileName, True)
  else
  begin
    XMLLog := TLogFile.Create('', False);
    XMLLog.Append(LastLog, 1);
  end;
  try
    XMLLog.Password := Global_Password;
    XMLLog.SaveXMLCopy(TmpXMLLogCopy);
  finally
    XMLLog.Free;
  end;
end;

function LoadTextFile(const FileName: string): string;
var
  S: TStringList;
begin
  Result := '';
  if (FileName = '') or (not FileExists(FileName)) then Exit;

  S := TStringList.Create;
  try
    try
      S.LoadFromFile(FileName);
      Result := S.Text;
    except
      // Nothing...
    end;
  finally
    S.Free;
  end;
end;

procedure FillAttachedList(EmailSend: Boolean; List: TStrings);
begin
  List.Clear;
  ExtractList(CurrentOptions.AttachedFiles, List, [';']);
  if (not EmailSend) or (not CurrentOptions.AppendLogs) and (TmpLogFileName <> '') then
    List.Add(TmpLogFileName);
  if (TmpScreenshot <> '') then List.Add(TmpScreenshot);
  if (TmpLastHTMLPage <> '') then List.Add(TmpLastHTMLPage);
  if (TmpXMLLogCopy <> '') then List.Add(TmpXMLLogCopy);
end;
{$ENDIF}

//------------------------------------------------------------------------------

function GetLastExceptionAddress: Pointer;
begin
  Result := LastExceptionAddress;
end;

function GetLastExceptionObject: TObject;
begin
  if (IsValidObject(LastExceptionObject)) then Result := LastExceptionObject
  else Result := nil;
end;

procedure SetLastExceptionObject(Obj: TObject);
begin
  LastExceptionObject := Obj;
end;

//------------------------------------------------------------------------------

procedure CallModule_ExceptionNotify;
var
  Proc: procedure(EurekaExceptionRecord: TEurekaExceptionRecord; var Handled: Boolean);
  HModule: THandle;
begin
  if (Global_ExceptionRecord.ExceptionAddress = nil) then Exit;
  HModule := FindHInstance(Global_ExceptionRecord.ExceptionAddress);
  if (HModule = HInstance) then Exit;

  @Proc := GetProcAddress(HModule, 'EurekaLog_ExceptionNotifyEvent');
  if (Assigned(Proc)) then
    Proc(Global_ExceptionRecord, Global_Handled);
end;

procedure CallExceptionNotify;
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnExceptionNotify)) then
        EurekaLogList[n].OnExceptionNotify(Global_ExceptionRecord, Global_Handled);
  if (Assigned(ExceptionNotify)) then
    ExceptionNotify(Global_ExceptionRecord, Global_Handled);
end;

procedure CallExceptionNotifyEvents;
begin
  CallModule_ExceptionNotify;
  CallExceptionNotify;
end;

procedure CallModule_HandledExceptionNotify;
var
  Proc: procedure(EurekaExceptionRecord: TEurekaExceptionRecord; var Handled: Boolean);
  HModule: THandle;
begin
  if (Global_ExceptionRecord.ExceptionAddress = nil) then Exit;
  HModule := FindHInstance(Global_ExceptionRecord.ExceptionAddress);
  if (HModule = HInstance) then Exit;

  @Proc := GetProcAddress(HModule, 'EurekaLog_HandledExceptionNotifyEvent');
  if (Assigned(Proc)) then
    Proc(Global_ExceptionRecord, Global_Handled);
end;

procedure CallHandledExceptionNotify;
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnHandledExceptionNotify)) then
        EurekaLogList[n].OnHandledExceptionNotify(Global_ExceptionRecord, Global_Handled);
  if (Assigned(HandledExceptionNotify)) then
    HandledExceptionNotify(Global_ExceptionRecord, Global_Handled);
end;

procedure CallHandledExceptionNotifyEvents;
begin
  CallModule_HandledExceptionNotify;
  CallHandledExceptionNotify;
end;

procedure CallModuleEvent_ExceptionActionNotify(
  EurekaExceptionRecord: TEurekaExceptionRecord; EurekaAction: TEurekaActionType;
  var Execute: Boolean);
var
  Proc: procedure(ExceptionRecord: TEurekaExceptionRecord;
    EurekaAction: TEurekaActionType; var Execute: Boolean);
  HModule: THandle;
begin
  HModule := FindHInstance(EurekaExceptionRecord.ExceptionAddress);
  if (HModule = HInstance) then Exit;

  @Proc := GetProcAddress(HModule, 'EurekaLog_ExceptionActionNotifyEvent');
  if (Assigned(Proc)) then
    Proc(EurekaExceptionRecord, EurekaAction, Execute);
end;

procedure CallExceptionActionNotify(EurekaExceptionRecord: TEurekaExceptionRecord;
  EurekaAction: TEurekaActionType; var Execute: Boolean);
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnExceptionActionNotify)) then
        EurekaLogList[n].OnExceptionActionNotify(EurekaExceptionRecord,
          EurekaAction, Execute);
  if (Assigned(ExceptionActionNotify)) then
    ExceptionActionNotify(EurekaExceptionRecord, EurekaAction, Execute);
end;

procedure CallModuleEvent_ExceptionErrorNotify(
  EurekaExceptionRecord: TEurekaExceptionRecord; EurekaAction: TEurekaActionType;
  var Retry: Boolean);
var
  Proc: procedure(ExceptionRecord: TEurekaExceptionRecord;
    EurekaAction: TEurekaActionType; var Retry: Boolean);
  HModule: THandle;
begin
  HModule :=FindHInstance(EurekaExceptionRecord.ExceptionAddress);
  if (HModule = HInstance) then Exit;

  @Proc := GetProcAddress(HModule, 'EurekaLog_ExceptionErrorNotifyEvent');
  if (Assigned(Proc)) then
    Proc(EurekaExceptionRecord, EurekaAction, Retry);
end;

procedure CallExceptionErrorNotify(EurekaExceptionRecord: TEurekaExceptionRecord;
  EurekaAction: TEurekaActionType; var Retry: Boolean);
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnExceptionErrorNotify)) then
        EurekaLogList[n].OnExceptionErrorNotify(EurekaExceptionRecord,
          EurekaAction, Retry);
  if (Assigned(ExceptionErrorNotify)) then
    ExceptionErrorNotify(EurekaExceptionRecord, EurekaAction, Retry);
end;

procedure CallPasswordRequest;
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnPasswordRequest)) then
        EurekaLogList[n].OnPasswordRequest(Global_ExceptionRecord, Global_Password);
  if (Assigned(PasswordRequest)) then PasswordRequest(Global_ExceptionRecord, Global_Password);
end;

procedure CallModule_CustomDataRequest;
var
  Proc: procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    DataFields: TStrings);
  HModule: THandle;
begin
  if (Global_ExceptionRecord.ExceptionAddress = nil) then Exit;
  HModule := FindHInstance(Global_ExceptionRecord.ExceptionAddress);
  if (HModule = HInstance) then Exit;

  @Proc := GetProcAddress(HModule, 'EurekaLog_CustomDataRequestEventEx');
  if (Assigned(Proc)) then
    Proc(Global_ExceptionRecord, Global_DataFields);
end;

procedure CallCustomDataRequest;
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnCustomDataRequest)) then
        EurekaLogList[n].OnCustomDataRequest(Global_ExceptionRecord, Global_DataFields);
  if (Assigned(CustomDataRequest)) then
    CustomDataRequest(Global_ExceptionRecord, Global_DataFields);
end;

procedure CallCustomDataRequestEvents;
begin
  CallModule_CustomDataRequest;
  CallCustomDataRequest;
end;

{$IFDEF PROFESSIONAL}
procedure CallModule_AttachedFilesRequest;
var
  Proc: procedure(EurekaExceptionRecord: TEurekaExceptionRecord; AttachedFiles: TStrings);
  HModule: THandle;
begin
  if (Global_ExceptionRecord.ExceptionAddress = nil) then Exit;
  HModule := FindHInstance(Global_ExceptionRecord.ExceptionAddress);
  if (HModule = HInstance) then Exit;

  @Proc := GetProcAddress(HModule, 'EurekaLog_AttachedFilesRequestEvent');
  if (Assigned(Proc)) then
    Proc(Global_ExceptionRecord, Global_AttachedFiles);
end;

procedure CallAttachedFilesRequest;
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnAttachedFilesRequest)) then
        EurekaLogList[n].OnAttachedFilesRequest(Global_ExceptionRecord, Global_AttachedFiles);
  if (Assigned(AttachedFilesRequest)) then
    AttachedFilesRequest(Global_ExceptionRecord, Global_AttachedFiles);
end;

procedure CallAttachedFilesRequestEvents;
begin
  CallModule_AttachedFilesRequest;
  CallAttachedFilesRequest;
end;

procedure CallModule_CustomWebFieldsRequest;
var
  Proc: procedure(EurekaExceptionRecord: TEurekaExceptionRecord; WebFields: TStrings);
  HModule: THandle;
begin
  if (Global_ExceptionRecord.ExceptionAddress = nil) then Exit;
  HModule := FindHInstance(Global_ExceptionRecord.ExceptionAddress);
  if (HModule = HInstance) then Exit;

  @Proc := GetProcAddress(HModule, 'EurekaLog_CustomWebFieldsRequestEvent');
  if (Assigned(Proc)) then
    Proc(Global_ExceptionRecord, Global_WebFields);
end;

procedure CallCustomWebFieldsRequest;
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnCustomWebFieldsRequest)) then
        EurekaLogList[n].OnCustomWebFieldsRequest(Global_ExceptionRecord,
          Global_WebFields);
  if (Assigned(CustomWebFieldsRequest)) then
    CustomWebFieldsRequest(Global_ExceptionRecord, Global_WebFields);
end;

procedure CallCustomWebFieldsRequestEvents;
begin
  CallModule_CustomWebFieldsRequest;
  CallCustomWebFieldsRequest;
end;

procedure CallModule_CustomButtonClickNotify;
var
  Proc: procedure(EurekaExceptionRecord: TEurekaExceptionRecord;
    var CloseDialog: Boolean);
  HModule: THandle;
begin
  if (Global_ExceptionRecord.ExceptionAddress = nil) then Exit;
  HModule := FindHInstance(Global_ExceptionRecord.ExceptionAddress);
  if (HModule = HInstance) then Exit;

  @Proc := GetProcAddress(HModule, 'EurekaLog_CustomButtonClickEvent');
  if (Assigned(Proc)) then
    Proc(Global_ExceptionRecord, Global_CloseDialog);
end;

procedure CallCustomButtonClickEvent;
var
  n: Integer;
begin
  if (EurekaLogList <> nil) then
    for n := EurekaLogList.Count - 1 downto 0 do
      if (Assigned(EurekaLogList[n].OnCustomButtonClickNotify)) then
        EurekaLogList[n].OnCustomButtonClickNotify(Global_ExceptionRecord,
          Global_CloseDialog);
  if (Assigned(CustomButtonClickNotify)) then
    CustomButtonClickNotify(Global_ExceptionRecord, Global_CloseDialog);
end;

procedure CallCustomButtonClickEvents;
begin
  CallModule_CustomButtonClickNotify;
  CallCustomButtonClickEvent;
end;

{$ENDIF}

procedure CallModule_PasswordRequestEvent;
var
  Proc: procedure(var Pwd: ShortString);
  ProcEx: procedure(ExceptionRecord: TEurekaExceptionRecord; var Pwd: ShortString);
  st: ShortString;
begin
  @ProcEx := GetProcAddress(Global_Module, 'EurekaLog_PasswordRequestEventEx');
  if (Assigned(ProcEx)) then
  begin
    st := Global_Password;
    ProcEx(Global_ExceptionRecord, st);
    Global_Password := st;
  end
  else
  begin
    @Proc := GetProcAddress(Global_Module, 'EurekaLog_PasswordRequestEvent');
    if (Assigned(Proc)) then
    begin
      st := Global_Password;
      Proc(st);
      Global_Password := st;
    end;
  end;
end;

procedure SaveGlobalExceptionRecord(ExceptionRecord: TEurekaExceptionRecord);

  function MappedExceptionObject(Error: TObject; var MustFree: Boolean): TObject;
  {$IFDEF Delphi4Up}
  var
    Win32Exception: EExternal;
  {$ENDIF}
  begin
    MustFree := False;
    Result := Error;
    if (not IsValidObject(Error)) or
      (DWord(FindClassHInstance(Error.ClassType)) <> DWord(HInstance)) then
    begin
      Result := GetLastExceptionObject;
      {$IFDEF Delphi4Up}
      if (Result = nil) and (IsAParent(Error, EExternal)) then
      begin
        Win32Exception := EExternal(Error);
        if (Assigned(OldExceptObjProc)) then
          Result := OldExceptObjProc(Win32Exception.ExceptionRecord)
        else
          if (Assigned(ExceptObjProc)) then
            Result := TExceptObjProc(ExceptObjProc)(Win32Exception.ExceptionRecord);
        SetLastExceptionObject(Result);
        MustFree := True;
      end;
      {$ENDIF}
    end;
  end;

begin
  OldGlobal_ExceptionRecord := Global_ExceptionRecord;
  Global_ExceptionRecord := ExceptionRecord;
  // To obtain a DLL local string copy!
  UniqueString(Global_ExceptionRecord.LogText);
  Global_ExceptionRecord.ExceptionObject :=
    MappedExceptionObject(Global_ExceptionRecord.ExceptionObject, MustFreeGlobalMappedObject);
end;

procedure RestoreGlobalExceptionRecord(ExceptionRecord: TEurekaExceptionRecord);
begin
  if MustFreeGlobalMappedObject then
  begin
    Global_ExceptionRecord.ExceptionObject.Free;
    SetLastExceptionObject(nil);
  end;
  Global_ExceptionRecord := OldGlobal_ExceptionRecord;
end;

// Procedure used to obtain a DLL local TStrings copy!!!
procedure CopyStrings(Src, Dest: TStrings);
var
  n: Integer;
  s: string;
begin
  Dest.Clear;
  for n := 0 to (Src.Count - 1) do
  begin
    s := Src[n];
    UniqueString(s);
    Dest.Add(s);
  end;
end;

procedure EurekaLog_PasswordRequestEvent(var Pwd: ShortString);
begin
  Global_Password := Pwd;

  CallPasswordRequest;

  Pwd := Global_Password;
end;

procedure EurekaLog_PasswordRequestEventEx(EurekaExceptionRecord: TEurekaExceptionRecord;
  var Pwd: ShortString);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    Global_Password := Pwd;
    CallPasswordRequest;
    Pwd := Global_Password;
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

procedure EurekaLog_ExceptionNotifyEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  var Handled: Boolean);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    Global_Handled := Handled;
    CallExceptionNotify;
    Handled := Global_Handled;
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

procedure EurekaLog_HandledExceptionNotifyEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  var Handled: Boolean);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    Global_Handled := Handled;
    CallHandledExceptionNotify;
    Handled := Global_Handled;
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

procedure EurekaLog_ExceptionActionNotifyEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  EurekaAction: TEurekaActionType; var Execute: Boolean);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    CallExceptionActionNotify(Global_ExceptionRecord, EurekaAction, Execute);
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

procedure EurekaLog_ExceptionErrorNotifyEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  EurekaAction: TEurekaActionType; var Retry: Boolean);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    CallExceptionErrorNotify(Global_ExceptionRecord, EurekaAction, Retry);
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

procedure EurekaLog_CustomDataRequestEventEx(EurekaExceptionRecord: TEurekaExceptionRecord;
  DataFields: TStrings);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    CopyStrings(DataFields, Global_DataFields);
    CallCustomDataRequest;
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

procedure EurekaLog_AttachedFilesRequestEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  AttachedFiles: TStrings);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    CopyStrings(AttachedFiles, Global_AttachedFiles);
    CallAttachedFilesRequest;
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

procedure EurekaLog_CustomWebFieldsRequestEvent(
  EurekaExceptionRecord: TEurekaExceptionRecord; WebFields: TStrings);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    CopyStrings(WebFields, Global_WebFields);
    CallCustomWebFieldsRequest;
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

procedure EurekaLog_CustomButtonClickEvent(EurekaExceptionRecord: TEurekaExceptionRecord;
  var CloseDialog: Boolean);
begin
  SaveGlobalExceptionRecord(EurekaExceptionRecord);
  try
    Global_CloseDialog := CloseDialog;
    CallCustomButtonClickEvent;
    CloseDialog := Global_CloseDialog;
  finally
    RestoreGlobalExceptionRecord(EurekaExceptionRecord);
  end;
end;

//------------------------------------------------------------------------------
// WARNING! - The "Proc" procedure must use ONLY GLOBAL VARIABLES (not local),
// because the local variables are stored into the Stack of local procedure but
// "SynchronizeEvent" procedure is called as Global Procedure so it did not see
// the local variables.
//------------------------------------------------------------------------------

procedure SynchronizeEvent(const Proc: TInternalProc);

  function CanExit: Boolean;
  begin
    Result := (Global_CurrentEvent = nil);
  end;

begin
  if (NoSynchronizeEvent) then Exit;

  if (LastExceptionRecord <> nil) and
    (LastExceptionRecord^.ExceptionThreadID <> GetCurrentThreadId) then
  begin
{$IFDEF EUREKALOG_PROFILER}
    mSecEventTemp := GetTickCount;
{$ENDIF}
    TInternalProc(Global_CurrentEvent) := Proc;
{$IFDEF EUREKALOG_PROFILER}
    mSecEventTemp := (GetTickCount - mSecEventTemp);
    Inc(mSecEvents, mSecEventTemp);
{$ENDIF}
    repeat
      Sleep(10);
    until (CanExit);
  end
  else
  begin
    try
      Global_CurrentEvent := Pointer(1);
      try
        Proc;
      finally
        Global_CurrentEvent := nil;
      end;
    except
      // ...
    end;
  end;
  CalcDuplicatedException(False);
end;

//------------------------------------------------------------------------------

// Used to make sure to identify the internal Borland hide functions in not
// updated or modified libraries versions.

function RoundMatch(v1, v2: DWord): Boolean;
var Diff: Integer;
begin
  Diff := Abs(Integer(v1) - Integer(v2));
  Result := (Diff <= $40);
end;

function RoundMatchPtr(v1, v2: Pointer): Boolean;
begin
  Result := RoundMatch(DWord(v1), DWord(v2));
end;

//------------------------------------------------------------------------------

function HookSymbolProcedure(SymbolID: Byte; NewAddr: Pointer): Pointer;
var
  ProcAddr: Pointer;
begin
  Result := nil;
  ProcAddr := GetSymbolAddr(SymbolID);
  if (ProcAddr <> nil) then // Found into this module...
    Result := HookProcedureEx(ProcAddr, NewAddr, 'SymbolID = ' + IntToStr(SymbolID));
end;

function HookBPLProcedureByAddr(ProcAddr: Pointer; const BplModuleName, BplProcName: string;
  NewAddr: Pointer): Pointer;
var
  BPLHandle: THandle;
begin
  Result := nil;

  // Try to find the procedure in the BPL module...
  if ((ProcAddr = nil) and (BplModuleName <> '') and (BplProcName <> '')) then
  begin
    BPLHandle := GetModuleHandle(PChar(BplModuleName));
    if (BPLHandle <> 0) then
      ProcAddr := GetProcAddress(BPLHandle, PChar(BplProcName));
  end;

  if (NewAddr <> nil) then
  begin
    if (ProcAddr <> nil) then
      Result := HookProcedureEx(ProcAddr, NewAddr, BplProcName);
  end
  else
    Result := ProcAddr;
end;

function HookBPLProcedureBySymbol(SymbolID: Byte; const BplModuleName,
  BplProcName: string; NewAddr: Pointer): Pointer;
begin
  Result := HookBPLProcedureByAddr(GetSymbolAddr(SymbolID), BplModuleName,
    BplProcName, NewAddr);
end;

function IsExceptionHandled(Obj: TObject; Addr: Pointer; OnlySafeCall: Boolean;
  var AsynchronousException: TAsynchronousException): Boolean;
type
  CallInstruction = array[0..9] of byte;
var
  FoundInCache: Boolean;
  EF: PExcFrame;
  HandleOnException_Table: Pointer;
  ReturnAddr, Except_Address, Except_Start: DWord;
  FirstExceptionType, ExceptionType: TExceptionType;
  FrameCount: Integer;

  function GetEF: Pointer;
  asm
    MOV EAX, FS:[0]
  end;

  function ASMAssigned(Value: Pointer): boolean;
  begin
    Result := (DWord(Value) <> $FFFFFFFF);
  end;

begin
  Result := False;
  EF := GetEF;

  FoundInCache := FindHandled(Obj, Addr, EF, Result, FrameCount,
    AsynchronousException, FirstExceptionType);

  if (not FoundInCache) then
  begin
    AsynchronousException := aeNone;
    FirstExceptionType := etUnknown;
    FrameCount := 0;

    Except_Address := 0;
    while IsValidBlockAddr(DWord(EF), SizeOf(EF)) and (ASMAssigned(EF)) do
    begin
      ReturnAddr := PDWord(@EF^.desc)^;
      ExceptionType := ExceptionTypeByAddr(ReturnAddr);

      // @HandleAnyException & @HandleAutoException
      if (ExceptionType in [etHandleAnyException, etHandleAutoException]) then
      begin
        Except_Start := ReturnAddr + 5;
        if ((FrameCount = 0) and (RoundMatch(SynchronizeExcept, Except_Start))) then
        begin
          AsynchronousException := aeSynchronize;
          Result := False;
          Break;
        end;
        if (Except_Address = 0) then Except_Address := Except_Start;
        if (FirstExceptionType = etUnknown) then FirstExceptionType := ExceptionType;
        Result := True;
        Inc(FrameCount);
      end

      // @HandleOnException
      else
        if (ExceptionType = etHandleOnException) then
        begin
          HandleOnException_Table := PDWord(DWord(@EF^.desc^) + 5);
          if (Is_HandleOnException_Handled(Obj,
            HandleOnException_Table, Except_Start)) then
          begin
            if (Except_Address = 0) then Except_Address := Except_Start;
            if (FirstExceptionType = etUnknown) then FirstExceptionType := ExceptionType;
            Result := True;
            Inc(FrameCount);
          end;
        end;
      EF := EF^.next;
    end;
    InsertHandled(Obj, Addr, GetEF, Result, FrameCount,
      AsynchronousException, FirstExceptionType);
  end;

  if ((IntoInitialization) or (IntoFinalization)) and (FrameCount = 1) then
  begin
    Result := False;
  end;

  if OnlySafeCallExceptions then Result := True;

  if OnlySafeCall then Result := True;

  if (FirstExceptionType = etHandleAutoException) then
  begin
    Result := False;
    AsynchronousException := aeSafeCall;
  end;

  if (not DebugHook_Assigned) then
  begin
    if (not IsWeb) and (IsConsole) and (not IsDebugged) then DebugHook := 0;
    DebugHook_Assigned := True;
  end;
end;

function CompareEurekaFunctions(Item1, Item2: Pointer): Integer;
begin
  Result := PEurekaFunctionInfo(Item1)^.Addr - PEurekaFunctionInfo(Item2)^.Addr;
end;

// This function return the complete list of exported function of HModule...

function ExportedFunctions(HModule: THandle; FunctionsList:
  TEurekaFunctionsList): boolean;
var
  HeadPos: DWord;
  Stream: TStream;
  SectionHeader: ImageSectionHeader;
  NameAddress: Integer;
  Buffer: array[0..255] of Char;
  j: Integer;
  FSectionStart: integer;
  FNumberofSections: smallint;
  MaxExports: Integer;
  ExportVA: Integer;
  ExportInfo: PEExportImage;
  EurekaFunctionInfo: PEurekaFunctionInfo;
  StartOfCode, MaxSize: DWord;

  function MaxReadableSize: DWord;
  type
    PHeader = ^THeader;
    THeader = packed record
      Unused: array[0..59] of Byte; // unused information.
      Offset: DWord;
    end;
  var
    Header32: PImageNTHeaders;
  begin
    Result := 0;
    Header32 := PImageNtHeaders(HModule + PHeader(HModule).Offset);
    if IsValidBlockAddr(DWord(Header32), SizeOf(TImageNtHeaders)) then
    begin
      StartOfCode := HModule + Header32^.OptionalHeader.BaseOfCode;
      Result := StartOfCode + Header32^.OptionalHeader.SizeOfCode - 1;
      if (not IsValidBlockAddr(StartOfCode, Header32^.OptionalHeader.SizeOfCode)) then
        Result := 0;
    end;
  end;

  function ReadAddr(Addr: DWord): DWord;
  type
    PWin9XDLLCall = ^TWin9XDLLCall;
    TWin9XDLLCall = packed record
      PUSH: Byte; //  $68
      Addr: DWord; // DLL Procedure Address.
      JMP: Byte; //   $E9
      Distance: Integer;
    end;
  var
    Pt: PWin9XDLLCall;
  begin
    Result := Addr;
    Pt := PWin9XDLLCall(Addr);
    if (Win32Platform <> VER_PLATFORM_WIN32_NT) and
      (Pt^.PUSH = $68) and (Pt^.JMP = $E9) then Result := Pt^.Addr;
  end;

begin
  Result := False;
  if (not IsValidModule(HModule)) then Exit;
  if (not IsValidBlockAddr(HModule, 64)) then Exit;

  MaxSize := MaxReadableSize;
  if (MaxSize = 0) then Exit;

  Stream := THModuleStream.Create(HModule);
  try
    Stream.Position := 60; // Skip unused informations.
    Stream.Read(HeadPos, 4);
    // Read the "File address of new exe header" position.
    Stream.Position := HeadPos;
    // Seek at the "File address of new exe header" position.
    Stream.Position := Stream.Position + 6; // Skip unused informations.
    Stream.Read(FNumberofSections, 2);
    // Read the "File address of new exe header" position.
    Stream.Position := Stream.Position + 112; // Skip unused informations.
    Stream.Read(ExportVA, 4);
    Stream.Position := Stream.Position + 124; // Skip unused informations.
    FSectionStart := Stream.Position;

    // Search the "Exported function" section...
    j := 0;
    repeat
      Stream.Position := FSectionStart + SizeOf(SectionHeader) * j;
      Stream.Read(SectionHeader, SizeOf(SectionHeader));
      inc(j);
    until (j = FNumberOfSections) or
      ((ExportVA >= SectionHeader.VirtualAddress) and
      (ExportVA < SectionHeader.VirtualAddress +
      SectionHeader.VirtualSize));

    // If found the "Export function" section...
    if j < FNumberOfSections then
    begin
      Stream.Position := Longint(ExportVA); // Seek to Export section.
      Stream.Read(ExportInfo, SizeOf(ExportInfo)); // Read Export section.
      if ExportInfo.Characteristics = 0 then
      begin
        with ExportInfo do
        begin
          MaxExports := NumberOfFunctions;
          if NumberOfNames < MaxExports then
            MaxExports := NumberOfNames;
        end;
        Stream.Position := LongInt(ExportInfo.AddressOfNameOrdinals) +
          (MaxExports * 2);
        // Now read the names and addresses.
        for j := 0 to MaxExports - 1 do
        begin
          Stream.Position := (LongInt(ExportInfo.AddressOfNames)) +
            (j * SizeOf(NameAddress));
          Stream.ReadBuffer(NameAddress, SizeOf(NameAddress));
          Stream.Position := NameAddress;
          Stream.Read(Buffer, SizeOf(Buffer));
          New(EurekaFunctionInfo);
          EurekaFunctionInfo^.Name := Buffer;
          EurekaFunctionInfo^.Addr := 0;
          EurekaFunctionInfo^.Addr := ReadAddr(DWord(GetProcAddress(Hmodule, Buffer)));
          if IntoIDE then
            EurekaFunctionInfo^.Size := 1
          else
          begin
            if (EurekaFunctionInfo^.Addr >= StartOfCode) then
              EurekaFunctionInfo^.Size :=
                GetFunctionSize(EurekaFunctionInfo^.Addr, MaxSize)
            else
              EurekaFunctionInfo^.Size := 1;
          end;
          FunctionsList.Add(EurekaFunctionInfo);
          Result := True;
        end;
        FunctionsList.Sort(@CompareEurekaFunctions);
      end;
    end;
  finally
    Stream.Free;
  end;
end;

function IsEurekaLogModule_Old(HModule: THandle): Boolean;
var
  MapFile: TStream;
  MagicWord: DWord;
  FileName: string;
  HFile: THandle;
begin
  Result := False;
  FileName := ModuleFileName(HModule);
  HFile := CreateFile(PChar(FileName), 0, FILE_SHARE_READ or FILE_SHARE_WRITE,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile <> INVALID_HANDLE_VALUE) then
  try
    MapFile := THandleStream.Create(HFile);
    try
      // Skip to EOF...
      MapFile.Position := (MapFile.Size - 4);
      // Read MagicNumber word (to verify if debug infos exists)...
      MapFile.Read(MagicWord, 4);
      Result := CheckMagicCode(MagicWord);
    finally
      MapFile.Free;
    end;
  finally
    CloseHandle(HFile);
  end;
end;

function IsEurekaLogModule_New(HModule: THandle): Boolean;
var
  ResStream: TStream;
  MagicWord, Size: DWord;
  Data: Pointer;
begin
  Data := GetResourceData(HModule, 'ELDATA', RT_RCDATA, Size);
  Result := (Data <> nil);
  if (Result) then
  begin
    ResStream := THModuleStream.Create(DWord(Data));
    try
      ResStream.Read(MagicWord, 4); // Read the EurekaLog MagicNumber.
      Result := CheckMagicCode(MagicWord);
    finally
      ResStream.Free;
    end;
  end;
end;

function IsEurekaLogModule(HModule: {$IFDEF Delphi3}DWord{$ELSE}THandle{$ENDIF}): Boolean;
begin
  Result := ((IsEurekaLogModule_New(HModule)) or
    (IsEurekaLogModule_Old(HModule)));
end;

function IsEurekaLogCompatibleModule(HModule: {$IFDEF Delphi3}DWord{$ELSE}THandle{$ENDIF}): Boolean;
begin
  Result :=
    ((IsEurekaLogModule_New(HModule)) or (IsEurekaLogModule_Old(HModule))) and
    (GetEurekaLogModuleVersion(HModule) >= EurekaLogCurrentVersion);
end;

function GetEurekaLogModuleVersion(HModule: THandle): Word;
var
  ResStream: TStream;
  MapFile: TStream;
  Size: DWord;
  Data: Pointer;
  FileName: string;
  HFile: THandle;
  Dim: Integer;
begin
  Result := 0;
  if (not IsEurekaLogModule(HModule)) then Exit;

  if (IsEurekaLogModule_New(HModule)) then
  begin
    Data := GetResourceData(HModule, 'ELDATA', RT_RCDATA, Size);
    if (Data <> nil) then
    begin
      ResStream := THModuleStream.Create(DWord(Data));
      try
        ResStream.Position := 4;
        ResStream.Read(Result, 2);
      finally
        ResStream.Free;
      end;
    end;
  end
  else
  begin
    FileName := ModuleFileName(HModule);
    HFile := CreateFile(PChar(FileName), 0, FILE_SHARE_READ or FILE_SHARE_WRITE,
      nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if (HFile <> INVALID_HANDLE_VALUE) then
    try
      MapFile := THandleStream.Create(HFile);
      try
        // Skip to the start "Plus" information...
        MapFile.Position := (MapFile.Size - 8); // 4 bytes Magic - 4 bytes Dim
        MapFile.Read(Dim, 4);
        MapFile.Position := (MapFile.Position - Dim - 4);

        // Read the EurekaLog version
        MapFile.Read(Result, 2);
      finally
        MapFile.Free;
      end;
    finally
      CloseHandle(HFile);
    end;
  end;
end;

function LoadDebugInformation(ModuleInfo: PEurekaModuleInfo): Boolean;
var
  DLLModuleHandle: THandle;
  DLLModuleData: Pointer;
  Stream: TStream;

  procedure LoadData_Old;
  var
    MapFile: TFileStream;
    Dim, DebugSize: Integer;
  begin
    try
      MapFile := TFileStream.Create(ModuleInfo^.Name, fmOpenRead or
        fmShareDenyNone);
      try
        // Skip to the start "Plus" information...
        MapFile.Position := (MapFile.Size - 8); // 4 bytes Magic - 4 bytes Dim
        MapFile.Read(Dim, 4);
        MapFile.Position := (MapFile.Position - Dim - 4);

        // Read the EurekaLog version
        MapFile.Read(LastEurekaVersion, 2);
        ModuleInfo^.ExtraInformation.EurekaVersion := LastEurekaVersion;

        // Read the Compiled Date
        MapFile.Read(ModuleInfo^.ExtraInformation.CompilationDate, 8);

        // Read Module options...
        ModuleInfo^.ExtraInformation.Options.LoadFromStream(MapFile);

        // Read the Debug information...
        if (not NotLoadDebugInfo) then
        begin
          MapFile.Read(DebugSize, 4);
          ModuleInfo^.ExtraInformation.DebugInformation := TMemoryStream.Create;
          ModuleInfo^.ExtraInformation.DebugInformation.CopyFrom(MapFile, DebugSize);
        end
        else ModuleInfo^.ExtraInformation.DebugInformation := nil;

        Result := True;
      finally
        MapFile.Free;
      end;
    except
      // To catches wrong EurekaLog data formats (beta versions, etc...)
      Result := False;
    end;
  end;

  procedure LoadData;
  var
    ResStream, OptionsStream: TStream;
    DebugSize, VariableSize: integer;
    MagicWord, Size, DataSize, SymbolsSize, OptionsSize: DWord;
    Data, ZStream, DataPtr, CompressedData: Pointer;
    ZSize: Integer;
    UseMemoryLeaksCheck, UseMainModuleOptions: Boolean;

    procedure GetPassword(EventProc: TInternalProc);
    begin
      Global_Password := '';

      SynchronizeEvent(EventProc);

      ModuleInfo^.EncryptPassword := Global_Password;
      InitKey(Global_Password);
      Global_LastInitPassword := Global_Password;
      Inc(DWord(DataPtr), VariableSize);
      Dec(DataSize, VariableSize);
      Decrypt(DataPtr^, MagicWord, 4);
      // Password checking.
      ModuleInfo^.IsValidEncryptPassword := CheckMagicCode(MagicWord);
    end;

  begin
    try
      Data := GetResourceData(ModuleInfo^.Handle, 'ELDATA', RT_RCDATA, Size);
      Result := (Data <> nil);
      if (Result) then
      begin
        ResStream := THModuleStream.Create(DWord(Data));
        try
          // Read the EurekaLog MagicNumber
          ResStream.Read(MagicWord, 4);

          // Read the EurekaLog version
          ResStream.Read(LastEurekaVersion, 2);

          VersionWorkAround(LastEurekaVersion);

          if (LastEurekaVersion > EurekaLogCurrentVersion) then
          begin
            Result := False;
            Exit;
          end;

          ModuleInfo^.ExtraInformation.EurekaVersion := LastEurekaVersion;

          // Read the Compiled Date
          ResStream.Read(ModuleInfo^.ExtraInformation.CompilationDate, 8);

          if (LastEurekaVersion >= 6000) then
          begin
            ResStream.Read(UseMemoryLeaksCheck, 1);
            ResStream.Read(UseMainModuleOptions, 1);
            DataPtr := Pointer(DWord(Data) + 16);
            DataSize := (Size - 16);
          end
          else
          begin
            DataPtr := Pointer(DWord(Data) + 14);
            DataSize := (Size - 14);
          end;

          if (LastEurekaVersion >= 500) then
          begin
            VariableSize := ResStream.Position;

            // Skip the Symbols info...
            ResStream.Read(SymbolsSize, 4);
            ResStream.Position := (ResStream.Position + Integer(SymbolsSize));

            // Read Module options...
            ResStream.Read(OptionsSize, 4);
            ZStream := nil;
            ZSize := 0;
            ZDecompress(Pointer(DWord(DataPtr) + SymbolsSize + 8), OptionsSize, ZStream, ZSize);
            if (ZStream = nil) or (ZSize = 0) then // Wrong compressed data...
            begin
              Result := False;
              Exit;
            end;
            try
              OptionsStream := THModuleStream.Create(DWord(ZStream));
              try
                ModuleInfo^.ExtraInformation.Options.LoadFromStream(OptionsStream);
              finally
                OptionsStream.Free;
              end;
            finally
              Freemem(ZStream, ZSize);
            end;

            if (not NotLoadDebugInfo) then
            begin
              VariableSize := (ResStream.Position - VariableSize + Integer(OptionsSize));
              Global_Module := ModuleInfo^.Handle;

              GetPassword(@CallModule_PasswordRequestEvent);

              // Is the password is invalid and the module is a library
              // then try to call the OnPasswordRequest MainModule event...
              if (not ModuleInfo^.IsValidEncryptPassword) and (Global_Module <> HInstance) then
              begin
                // Reset old values (changed by last GetPassword calling)...
                Dec(DWord(DataPtr), VariableSize);
                Inc(DataSize, VariableSize);

                GetPassword(@CallPasswordRequest);
              end;

              Inc(DWord(DataPtr), 4);
              Dec(DataSize, 4);
            end;
          end;
          CompressedData := DataPtr;

          if (Result) then
          begin
            // Compressed stream...
            if (LastEurekaVersion >= 450) and
              ((LastEurekaVersion < 500) or (not NotLoadDebugInfo)) then
            begin
              ZStream := nil;
              ZSize := 0;
              ZDecompress(CompressedData, DataSize, ZStream, ZSize);
              if (ZStream = nil) or (ZSize = 0) then // Wrong compresed data...
              begin
                Result := False;
                Exit;
              end;
              ResStream.Free;
              ResStream := THModuleStream.Create(DWord(ZStream));
            end
            else ZStream := nil;

            // Read Module options...
            if (LastEurekaVersion < 500) then
              ModuleInfo^.ExtraInformation.Options.LoadFromStream(ResStream);

            // Read the Debug information...
            if (not NotLoadDebugInfo) then
            begin
              ResStream.Read(DebugSize, 4);
              ModuleInfo^.ExtraInformation.DebugInformation := TMemoryStream.Create;
              ModuleInfo^.ExtraInformation.DebugInformation.CopyFrom(ResStream, DebugSize);
            end
            else ModuleInfo^.ExtraInformation.DebugInformation := nil;

            // Free the decompressed data...
            if (ZStream <> nil) then FreeMem(ZStream, ZSize);
          end;
        finally
          ResStream.Free;
        end;
      end;
    except
      // To catches wrong EurekaLog data formats (beta versions, etc...)
      Result := False;
    end;
  end;

begin
  Result := False;
  if (IsEurekaLogModule_New(ModuleInfo^.Handle)) then LoadData
  else
    if (IsEurekaLogModule_Old(ModuleInfo^.Handle)) then LoadData_Old;

  if (Result) and (ModuleInfo^.Handle <> HInstance) then
  begin
    DLLModuleHandle := CreateVirtualFile(ModuleInfo^.Handle, 'MODULE', 0, DLLModuleData);
    if (DLLModuleHandle <> 0) then
    begin
      if (PBoolean(DLLModuleData)^) then // Unable information.
      begin
        Stream := THModuleStream.Create(DWord(DLLModuleData) + 1);
        try
          ModuleInfo^.ExtraInformation.Options.LoadFromStream(Stream);
        finally
          Stream.Free;
        end;
      end;
      DeleteVirtualFile(DLLModuleHandle, DLLModuleData);
    end;
  end;
end;

function AddModule(HModule: THandle): Boolean;
var
  ModuleInfo: PEurekaModuleInfo;
begin
  Result := False;
  if IsValidModule(HModule) then
  begin
    New(ModuleInfo);
    ModuleInfo^.Handle := HModule;
    ModuleInfo^.Name := ModuleFileName(HModule);
    ModuleInfo^.EncryptPassword := '';
    ModuleInfo^.IsValidEncryptPassword := True;
    ModuleInfo^.LastModified := GetModifiedDate(ModuleInfo^.Name);
    GetModuleDescriptionAndVersion(ModuleInfo^.Name, ModuleInfo^.Description,
      ModuleInfo^.Version);
    ModuleInfo^.Size := GetFileSize(ModuleInfo^.Name);
    ModuleInfo^.FunctionsList := TEurekaFunctionsList.Create;
    if (not NotLoadDebugInfo) then
    begin
      if (HModule <> MainInstance) then
        ExportedFunctions(ModuleInfo^.Handle, ModuleInfo^.FunctionsList);
      ModuleInfo^.ModuleType := FindModuleType(ModuleInfo^.Handle);
    end
    else ModuleInfo^.ModuleType := mtUnknown;
    ModuleInfo^.OtherDebugData := nil;
    ModuleInfo^.ExtraInformation.Options :=
      TEurekaModuleOptionsEx.Create(ModuleInfo^.Name, True);
    if (not LoadDebugInformation(ModuleInfo)) then
    begin
      ModuleInfo^.ExtraInformation.EurekaVersion := EurekaLogCurrentVersion;
      ModuleInfo^.ExtraInformation.CompilationDate := 0;
      ModuleInfo^.ExtraInformation.DebugInformation := nil;
      if (not NotLoadDebugInfo) then
        AssignValidDebugInfo(HModule, ModuleInfo^.OtherDebugData);
    end;
    ModulesList.Add(ModuleInfo);
    Result := True;
  end;
end;

function GetDebugDetail(Options: TEurekaModuleOptions): TEurekaDebugDetails;
begin
  Result := [ddSourceCode];
  if (csoShowDLLs in Options.CallStackOptions) then Result := (Result + [ddProcedure]);
  if (csoShowBPLs in Options.CallStackOptions) then Result := (Result + [ddUnitAndProcedure]);
end;

procedure CallStackByAddresses(StackList: TEurekaStackList; FirstAddr: Pointer;
  StackPointer, TopOfStack, ThreadID: DWord; RunningThread, GetDebugInfo,
  ShowBeginCalls: Boolean; StartLevel, LevelsNumber: Integer;
  DebugDetails: TEurekaDebugDetails);
type
  Codes = array[0..6] of byte;
  PCodes = ^Codes;

var
  // Levels...
  ItemIdx, ItemsCount: Integer;

  // StackList items number (at first iteraction)...
  FirstIdx: Integer;

  // Address of ASM "CALL" return...
  ReturnAddr: DWord;

  // Pointer of first intruction's code to disassembler...
  PointAddr: DWord;

  // Address pointer to ASM "CALL" instruction...
  CalledAddr: DWord;

  // Relative jump size for ASM "CALL" instruction...
  RelativeJump: Integer;

  // Array of instruction's codes...
  Code: PCodes;

  // Length of consecutives readable memory addresses...
  OKLen: integer;

  procedure AddToStack(Addr: DWord; ErrorLine: Boolean);
  var
    DebugInfo: PEurekaDebugInfo;
  begin
    New(DebugInfo);
    if (GetDebugInfo) then
      GetDebugInfosByAddr(Addr, ThreadID, DebugInfo, RunningThread, ErrorLine)
    else
    begin
      FillChar(DebugInfo^, SizeOf(DebugInfo^), #0);
      DebugInfo^.DebugDetail := ddModule;
      DebugInfo^.RunningThread := RunningThread;
      DebugInfo^.ErrorLine := ErrorLine;
      DebugInfo^.IsALeak := False;
      DebugInfo^.ThreadID := ThreadID;
      DebugInfo^.Addr := Addr;
      New(DebugInfo^.ModuleInfo);
      FillChar(DebugInfo^.ModuleInfo^, SizeOf(DebugInfo^.ModuleInfo^), #0);
      DebugInfo^.ModuleInfo^.Handle := FindHInstance(Pointer(Addr));
      DebugInfo^.ModuleInfo^.Name := ModuleFileName(DebugInfo^.ModuleInfo^.Handle);
    end;
    if (not (DebugInfo^.DebugDetail in DebugDetails)) then Dispose(DebugInfo)
    else
    begin
      if (StartLevel = -1) or
        ((ItemIdx >= StartLevel) and (ItemsCount < LevelsNumber)) then
      begin
        StackList.Add(DebugInfo);
        Inc(ItemsCount);
      end;
      Inc(ItemIdx);
    end;
  end;

  procedure PurgeCallStack(StartIdx: Integer);
  var
    n, next1, next2: Integer;

    function NextItem(Current: Integer): Integer;
    var
      n: Integer;
      Hdl: THandle;
    begin
      if (Current = -1) then
      begin
        Result := -1;
        Exit;
      end;

      Hdl := StackList[Current]^.ModuleInfo^.Handle;
      n := (Current + 1);
      while (n <= (StackList.Count - 1)) and
        ((not (StackList[n]^.DebugDetail in [ddProcedure..ddSourceCode])) or
        ((StackList[n]^.ModuleInfo^.Handle <> Hdl))) do Inc(n);
      if (n <= (StackList.Count - 1)) then Result := n
      else Result := -1;
    end;

  {  function GetHInstance: THandle;
    begin
      if (DWord(FindHInstance(FirstAddr)) = HInstance) then Result := 0
      else Result := HInstance;
    end;}

  begin
    if (IntoIDE and GetDebugInfo) then
    begin
      n := StartIdx;
      while (n <= (StackList.Count - 1)) do
      begin
        if (not (StackList[n]^.DebugDetail in [ddProcedure..ddSourceCode])) or
//          (StackList[n]^.ModuleInfo^.Handle = GetHInstance) or
          (Pos('HandleException', StackList[n]^.ProcedureName) > 0) then StackList.Delete(n)
        else Inc(n);
      end;
    end;

    n := (StackList.Count - 2);
    while (n >= StartIdx) do
    begin
      if (StackList[n]^.DebugDetail in [ddProcedure..ddSourceCode]) then
      begin
        next1 := NextItem(n);
        if (next1 <> -1) and (StackList[n]^.Addr = StackList[next1]^.Addr) then
          StackList[n]^.DebugDetail := ddNone
        else
        begin
          next2 := NextItem(next1);
          if (next2 <> -1) and (StackList[n]^.Addr = StackList[next2]^.Addr) then
            StackList[n]^.DebugDetail := ddNone;
        end;
      end;
      Dec(n);
    end;
  end;

begin
  ItemIdx := 0;
  ItemsCount := 0;
  FirstIdx := StackList.Count;

  if (FirstAddr <> nil) then AddToStack(DWord(FirstAddr), True);

  OKLen := 0;

  // To elaborate max "MaxCallStackSize" bytes of CallStack...
  if ((StackPointer < TopOfStack) and (TopOfStack - StackPointer > MaxCallStackSize)) then
    TopOfStack := (StackPointer + MaxCallStackSize);

  while (StackPointer <= TopOfStack) do
  begin

    if (OKLen <= 0) then
    begin
      if (IsValidBlockAddr(StackPointer, 400)) then OKLen := 400
      else
        if (IsValidBlockAddr(StackPointer, 4)) then OKLen := 4
        else OKLen := 0;
    end;

    try
      if (OKLen > 0) then
      begin
        ReturnAddr := PDWord(StackPointer)^;
        PointAddr := ReturnAddr - SizeOf(Codes);
        if IsValidBlockAddr(PointAddr, SizeOf(Codes)) then
        begin
          Code := PCodes(PointAddr);

          // CALL ????????
          // E8 XX XX XX XX
          // Relative jump (+-32bit)
          if Code^[2] = $E8 then
          begin
            Move(Code^[3], RelativeJump, 4);
            CalledAddr := Round(PointAddr + 2) + RelativeJump + 5;
            if IsValidBlockAddr(CalledAddr, 1) then
            begin
              if (ShowBeginCalls) then
              begin
                CalledAddr := ConvertAddress(CalledAddr);
                if (IsValidBlockAddr(CalledAddr, 5)) and (PByte(CalledAddr)^ <> $E8) then
                  AddToStack(CalledAddr, False);
              end;
              AddToStack(PointAddr + 2, False);
            end;
          end
          else
            if (Code^[5] = $FF) and
              (Code^[6] >= $D0) and (Code^[6] <= $D7) then
            begin
              AddToStack(PointAddr + 5, False);
            end
            else
              if (Code^[5] = $FF) and
                (Code^[6] in [$10, $11, $12, $13, $16, $17]) then
              begin
                AddToStack(PointAddr + 5, False);
              end
              else
                if (Code^[4] = $FF) and
                  (Code^[5] in [$50, $51, $52, $53, $55, $56, $57]) then
                begin
                  AddToStack(PointAddr + 4, False);
                end
                else
                  if (Code^[1] = $FF) and
                    (Code^[2] in [$90, $91, $92, $93, $95, $96, $97]) then
                  begin
                    AddToStack(PointAddr + 1, False);
                  end
                  else
                    if (Code^[4] = $FF) and
                      (Code^[5] = $14) and (Code^[6] = $24) then
                    begin
                      AddToStack(PointAddr + 4, False);
                    end
                    else
                      if
                        (Code^[3] = $FF) and
                        (Code^[4] = $54) and (Code^[5] = $24) then
                      begin
                        AddToStack(PointAddr + 3, False);
                      end
                      else
                        if
                          (Code^[0] = $FF) and
                          (Code^[1] = $94) and (Code^[2] = $24) then
                        begin
                          AddToStack(PointAddr, False);
                        end
                        else
                          if (Code^[1] = $FF) and (Code^[2] = $15) then
                          begin
                            Move(Code^[3], RelativeJump, 4);
                            if IsValidBlockAddr(RelativeJump, 4) then
                              AddToStack(PointAddr + 1, False);
                          end;
        end;
      end;
      Dec(OKLen, 4);
    except
      OKLen := 0;
    end;
    Inc(StackPointer, 4);
  end;

  PurgeCallStack(FirstIdx);
end;

// This function return the complete Stack List (from customize Stack)...
function GetCallStackByAddresses(FirstAddr: Pointer; StackPointer,
  TopOfStack, ThreadID: DWord; RunningThread, ShowBeginCalls: Boolean;
  StartLevel, LevelsNumber: Integer; DebugDetails: TEurekaDebugDetails): TEurekaStackList;
begin
  Result := TEurekaStackList.Create;
  CallStackByAddresses(Result, FirstAddr, StackPointer, TopOfStack, ThreadID,
    RunningThread, True, ShowBeginCalls, StartLevel, LevelsNumber, DebugDetails);
end;

{$IFDEF PROFESSIONAL}

procedure ProcessMessage;
var
  Msg: TMsg;
begin
  try
    if (PeekMessage(Msg, 0, 0, 0, PM_REMOVE)) then
    begin
      if (Msg.message <> WM_QUIT) then
      begin
        TranslateMessage(Msg);
        DispatchMessage(Msg);
      end;
    end;
  except
    // ...
  end;
end;

procedure ApplicationRestore;
var
  AppHandle: THandle;
  Wnd: THandle;
begin
  AppHandle := GetMainWindow(GetCurrentProcessId);
  if (AppHandle = 0) then Exit;

  if IsIconic(AppHandle) then
  begin
    PostMessage(AppHandle, WM_SYSCOMMAND, SC_RESTORE, 0);
    ProcessMessage;
    ShowWindow(AppHandle, SW_SHOWNORMAL);
    SetForegroundWindow(AppHandle);
  end
  else
  begin
    Wnd := GetLastActivePopup(AppHandle);
    if (GetForegroundWindow <> Wnd) then SetForegroundWindow(Wnd);
  end;
end;
{$ENDIF}

procedure SetLastExceptionData(Obj: TObject; Addr: Pointer; DelphiException: Boolean);
begin
  if (Addr <> nil) then LastExceptionAddress := Addr;
  if (Obj <> nil) then LastExceptionObject := Obj;
  LastExceptAddr := Addr;
  LastExceptObject := Obj;
  LastDelphiException := DelphiException;
end;

procedure SetLastException(Obj: TObject; Addr: Pointer; DelphiException: Boolean);
begin
  SetLastExceptionData(Obj, Addr, DelphiException);
end;

//------------------------------------------------------------------------------

procedure SetCustomErrorMessage(const Value: string);
begin
  CustomExceptMessage := Value;
end;

function GetExceptMessage: string;
begin
  if (CustomExceptMessage = '') then Result := LastExceptMessage
  else Result := CustomExceptMessage;
end;

function DlgTemplate(Msg, WParam, LParam: DWord; Dialog: THandle;
  const DlgCaption: string): Boolean;
var
  Hdl: THandle;
  BackColor, BorderColor, BorderBack: COLORREF;
  Red, Green, Blue: Integer;
  i: Integer;
  b: HBrush;
  TextSize: TSize;
  rExt, rInt, rTit, rTit2, rCpt: TRect;
  BordW, BordH: integer;

  procedure SetRectangles(Dialog: THandle);
  begin
    // Set rExt
    GetWindowRect(Dialog, rExt);
    OffsetRect(rExt, -rExt.Left, -rExt.Top);

    // Set Border dimension...
    BordW := GetSystemMetrics(SM_CXFRAME) - 1;
    BordH := GetSystemMetrics(SM_CYFRAME) - 1;

    // Set rInt
    CopyRect(rInt, rExt);
    Inc(rInt.Left, BordW);
    Inc(rInt.Top, BordH);
    Dec(rInt.Right, BordW);
    Dec(rInt.Bottom, BordH);

    // Set rTit
    CopyRect(rTit, rExt);
    inc(rTit.Top, BordH + 1);
    inc(rTit.Left, BordW + 1);
    Dec(rTit.Right, BordW + 1);
    rTit.Bottom := rTit.Top + GetSystemMetrics(CAPTION_HEIGHT) - 1;

    // Set rTit2
    CopyRect(rTit2, rInt);
    rTit2.Bottom := rTit.Bottom + 1;
  end;

begin
  Result := False;

  if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
  begin
    hdl := GetWindowDC(Dialog);

    SetRectangles(Dialog);

    if msg = WM_NCACTIVATE then
      fActive := (wparam <> 0);

    if fActive then
    begin
      BackColor := color_BackColorActive;
      BorderColor := color_BorderColorActive;
      BorderBack := color_BorderBackActive;
    end
    else
    begin
      BackColor := color_BackColorInactive;
      BorderColor := color_BorderColorInactive;
      BorderBack := color_BorderBackInactive;
    end;

    CopyRect(rCpt, rTit);

    for i := 1 to ((rCpt.Bottom - rCpt.Top) div 5) do
    begin
      Red := Round(GetRValue(BackColor) * 0.96);
      if Red > 255 then Red := 255;
      Green := Round(GetGValue(BackColor) * 0.96);
      if Green > 255 then Green := 255;
      Blue := Round(GetBValue(BackColor) * 0.96);
      if Blue > 255 then Blue := 255;
      BackColor := RGB(Red, Green, Blue);
      b := CreateSolidBrush(BackColor);
      FillRect(hdl, rCpt, b);
      Inc(rCpt.Top, 2);
      Dec(rCpt.Bottom, 2);
      DeleteObject(b);
    end;

    b := CreateSolidBrush(BorderColor);
    FrameRect(hdl, rExt, b);
    if DetailsActive then
    begin
      FrameRect(hdl, rTit2, b);
      FrameRect(hdl, rInt, b);
    end
    else
    begin
      Dec(rTit2.Bottom);
      FrameRect(hdl, rTit2, b);
      inc(rTit2.Bottom);
    end;
    DeleteObject(b);

    b := CreateSolidBrush(BorderBack);
    FillRect(hdl,
      Rect(rExt.Left + 1, rExt.Top + 1, rInt.Left, rExt.Bottom - 1), b);
    FillRect(hdl,
      Rect(rExt.Left + 1, rExt.Top + 1, rExt.Right - 1, rInt.Top), b);
    FillRect(hdl,
      Rect(rExt.Left + 1, rInt.Bottom, rExt.Right - 1, rExt.Bottom - 1), b);
    FillRect(hdl,
      Rect(rInt.Right, rExt.Top + 1, rExt.Right - 1, rExt.Bottom - 1), b);
    DeleteObject(b);

    SetBkMode(hdl, TRANSPARENT);
    SelectObject(hdl, fCaptionFont);

    GetTextExtentPoint32(Hdl, PChar(DlgCaption), Length(DlgCaption), TextSize);

    Dec(rTit.Top);

    if fActive then
    begin // Text caption shadow...
      SetTextColor(hdl, color_CaptionShadow);
      TextOut(hdl, rTit.Left + 5,
        rTit.Top + ((rTit.Bottom - rTit.Top) - TextSize.cy) div 2,
        PChar(DlgCaption), Length(DlgCaption));
      SetTextColor(hdl, color_CaptionActive)
    end
    else
      SetTextColor(hdl, color_CaptionInactive);

    TextOut(hdl, rTit.Left + 4,
      rTit.Top + ((rTit.Bottom - rTit.Top) - TextSize.cy) div 2,
      PChar(DlgCaption), Length(DlgCaption));

    ReleaseDC(Dialog, hdl);
    Result := true;
  end;
end;

procedure CreateDialogFonts(Dialog: HWnd);
var
  hdl: HDC;
begin
  hdl := GetWindowDC(Dialog);

  // Unicode support...
  if (UserCharSet = ANSI_CHARSET) then
  begin
    FixedFontSize := 8;
    CaptionFontName := 'Verdana';
    FixedFontName1 := 'Lucida Console';
    FixedFontName2 := 'Tahoma';
  end
  else
  begin
    FixedFontSize := 10;
    CaptionFontName := 'MS Sans Serif';
    FixedFontName1 := 'Courier New';
    FixedFontName2 := 'Courier New';
  end;

  NonClientMetrics.cbSize := SizeOf(TNonClientMetrics);
  SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0);

  fCaptionFont := CreateFont(NonClientMetrics.lfCaptionFont.lfHeight,
    0, 0, 0, FW_BOLD, 0, 0, 0, DEFAULT_CHARSET,
    OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, DRAFT_QUALITY,
    VARIABLE_PITCH or FF_ROMAN, PChar(CaptionFontName));

  fVariableFont := CreateFontIndirect(NonClientMetrics.lfMessageFont);

  NonClientMetrics.lfMessageFont.lfUnderline := 1;
  NonClientMetrics.lfMessageFont.lfWeight := FW_BOLD;
  fLinkFont := CreateFontIndirect(NonClientMetrics.lfMessageFont);

  NonClientMetrics.lfMessageFont.lfUnderline := 1;
  NonClientMetrics.lfMessageFont.lfWeight := 0;
  fLinkFont2 := CreateFontIndirect(NonClientMetrics.lfMessageFont);

  NonClientMetrics.lfMessageFont.lfUnderline := 0;
  NonClientMetrics.lfMessageFont.lfWeight := FW_BOLD;
  fBigFont := CreateFontIndirect(NonClientMetrics.lfMessageFont);

  fFixedFont1 := CreateFont(-MulDiv(FixedFontSize, GetDeviceCaps(hdl,
    LOGPIXELSY), 72), 0, 0, 0, FW_NORMAL, 0, 0, 0, DEFAULT_CHARSET,
    OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, DRAFT_QUALITY,
    FIXED_PITCH or FF_MODERN, PChar(FixedFontName1));

  fFixedFont2 := CreateFont(-MulDiv(FixedFontSize, GetDeviceCaps(hdl,
    LOGPIXELSY), 72), 0, 0, 0, FW_NORMAL, 0, 0, 0, DEFAULT_CHARSET,
    OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS, DRAFT_QUALITY,
    FIXED_PITCH or FF_MODERN, PChar(FixedFontName2));

  ReleaseDC(Dialog, hdl);
end;

procedure DestroyDialogFonts;
begin
  DeleteObject(fCaptionFont);
  DeleteObject(fVariableFont);
  DeleteObject(fLinkFont);
  DeleteObject(fLinkFont2);  
  DeleteObject(fBigFont);
  DeleteObject(fFixedFont1);
  DeleteObject(fFixedFont2);
end;

procedure SetInitDialog(Dialog: HWnd; ForceToolsWindow: Boolean);
var
  P: PRect;
begin
  fActive := True;
  if (((not (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions)) or
    (DialogType = edtMSClassic)) and (not ForceToolsWindow)) then
  begin
    SetWindowLong(Dialog, GWL_EXSTYLE, (GetWindowLong(Dialog, GWL_EXSTYLE)) - WS_EX_TOOLWINDOW);
    CAPTION_HEIGHT := SM_CYCAPTION;
  end
  else CAPTION_HEIGHT := SM_CYSMCAPTION;
  UseTopMost := (edoShowInTopMostMode in CurrentOptions.ExceptionDialogOptions);
  if (UseTopMost) then
    SetWindowPos(Dialog, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);

  New(P);
  GetWindowRect(Dialog, P^);
  MoveWindow(Dialog, P^.Left, P^.Top, P^.Right - P^.Left, P^.Bottom - P^.Top - 18 +
    GetSystemMetrics(CAPTION_HEIGHT), True);
  Dispose(P);
end;

procedure AutoCloseTimerProc(HWnd: THandle; uMsg, idEvent, dwTine: DWord); stdcall;
begin
  Inc(AutoCloseTimer);
  if (AutoCloseTimer >= CurrentOptions.AutoCloseDialogSecs) then
    SendMessage(HWnd, WM_CLOSE, 0, 0);
end;

procedure SetAutoCloseTimer(Dialog: THandle);
begin
  if (CurrentOptions.AutoCloseDialogSecs > 0) then
  begin
    AutoCloseTimer := 0;
    SetTimer(Dialog, 2, 1000, @AutoCloseTimerProc);
  end;
end;

procedure UnsetAutoCloseTimer(Dialog: THandle);
begin
  if (CurrentOptions.AutoCloseDialogSecs > 0) then KillTimer(Dialog, 2);
end;

procedure ResetAutoCloseTimer;
begin
  AutoCloseTimer := 0;
end;

procedure TopMostTimerProc(HWnd: THandle; uMsg, idEvent, dwTine: DWord); stdcall;
var
  ForegroundWnd: THandle;
begin
  ForegroundWnd := GetForegroundWindow;
  if (not UseTopMost) and (ForegroundWnd <> CurrentDialog) and
    (IsCurrentProcessWindow(ForegroundWnd)) and
    (not IsANewProcessWindow(ForegroundWnd)) then SetForegroundWindow(CurrentDialog);
end;

procedure SetAutoTopMost(Dialog: THandle);
begin
  PopulateCurrentProcessWindows;
  CurrentDialog := Dialog;
  SetTimer(Dialog, 3, 10, @TopMostTimerProc);
end;

procedure UnsetAutoTopMost(Dialog: THandle);
begin
  KillTimer(Dialog, 3);
  CurrentDialog := 0;
end;

function ISODateTime(Date: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', Date);
end;

procedure AddCustomHeaderToLog(HeaderIndex: Integer; HeaderCaption, HeaderValue: string);
var
  Item: TLogItem;
  ItemValue: string;
  PosIdx: Integer;
begin
  if (HeaderValue = '') then Exit;

  Item := TLogItem.Create(HeaderIndex);
  try
    Item.AddHeader(HeaderCaption);
    Item.AddItem('', HeaderValue, True);
    ItemValue := (Item.Value + #13#10);
    PosIdx := (Length(CurrentGeneralErrorText) + 3);
    Insert(ItemValue, LastExceptionLog, PosIdx);
    Insert(ItemValue, Global_ExceptionRecord.LogText, PosIdx);
    LastLog := LastExceptionLog;
    CurrentGeneralErrorText :=
      Copy(LastExceptionLog, 1, Length(CurrentGeneralErrorText) + Length(ItemValue));
  finally
    Item.Free;
  end;
end;

procedure AddCustomHeadersToLog(HeaderIndex: Integer; HeaderCaption: string;
  Fields: TStrings);
var
  Item: TLogItem;
  ItemValue: string;
  PosIdx, n: Integer;
begin
  if (Fields = nil) or (Fields.Count = 0) then Exit;

  Item := TLogItem.Create(HeaderIndex);
  try
    Item.AddHeader(HeaderCaption);
    for n := 0 to (Fields.Count - 1) do
      Item.AddItem(Trim(Fields.Names[n]), Trim(Fields.Values[Fields.Names[n]]), True);
    ItemValue := (Item.Value + #13#10);
    PosIdx := (Length(CurrentGeneralErrorText) + 3);
    Insert(ItemValue, LastExceptionLog, PosIdx);
    Insert(ItemValue, Global_ExceptionRecord.LogText, PosIdx);
    LastLog := LastExceptionLog;
    CurrentGeneralErrorText :=
      Copy(LastExceptionLog, 1, Length(CurrentGeneralErrorText) + Length(ItemValue));
  finally
    Item.Free;
  end;
end;

function GetTextHeight(Dlg, Font: THandle; const Text: string; TextWidth: Integer): Integer;
var
  Size: TSize;
  DC: HDC;
  n, i: Integer;
  List: TStringList;
begin
  Result := 0;
  List := TStringList.Create;
  DC := GetDC(Dlg);
  SelectObject(DC, Font);
  try
    List.Text := Text;
    for n := 0 to (List.Count - 1) do
    begin
      if (List[n] = '') then List[n] := ' ';
      GetTextExtentPoint32(DC, PChar(List[n]), Length(List[n]), Size);
      for i := 0 to ((Size.cx - 1) Div TextWidth) do Inc(Result, Size.cy);
    end;
  finally
    ReleaseDC(Dlg, DC);
    List.Free;
  end;
end;

function GetTextWidth(Dlg, Font: THandle; const Text: string): Integer;
var
  Size: TSize;
  DC: HDC;
begin
  DC := GetDC(Dlg);
  SelectObject(DC, Font);
  try
    GetTextExtentPoint32(DC, PChar(Text), Length(Text), Size);
    Result := Size.cx;
  finally
    ReleaseDC(Dlg, DC);
  end;
end;

procedure ShowRequestDialog;

  function NewDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
    LParam: Integer): Longbool; stdcall;
  var
    Len: DWord;
    MemoWidth, MemoHeight, TxtHeight: Integer;
    Rec: TRect;

    procedure ShiftWndBottom(Wnd: THandle; Delta: Integer);
    var
      Rt: TRect;
    begin
      GetWindowRect(Wnd, Rt);
      Inc(Rt.Bottom, Delta);
      SetWindowPos(Wnd, 0, Rt.Left, Rt.Top, Rt.Right - Rt.Left, Rt.Bottom - Rt.Top, 0);
    end;

  begin
    Result := False;
    case Msg of
      WM_INITDIALOG:
        begin
          SetInitDialog(Dialog, False);
          CreateDialogFonts(Dialog);
          SendMessage(Dialog, WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtReproduceDialog_Caption])));
          SendMessage(GetDlgItem(Dialog, ID_RequestLabel), WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtReproduceDialog_Request])));
          SendMessage(GetDlgItem(Dialog, ID_RequestBtn), WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtReproduceDialog_OKButtonCaption])));
          SendMessage(GetDlgItem(Dialog, ID_RequestLabel), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_RequestBtn), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_RequestMemo), WM_SETFONT, fFixedFont1, 1);
          GetWindowRect(Dialog, Rec);
          MemoWidth := (Rec.Right - Rec.Left - 27);
          TxtHeight := GetTextHeight(Dialog, fVariableFont,
            CurrentOptions.CustomizedExpandedTexts[mtReproduceDialog_Request], MemoWidth);
          MemoHeight := (Rec.Bottom - Rec.Top - 83 - TxtHeight);
          ShiftWndBottom(Dialog, TxtHeight - 10);
          SetWindowPos(GetDlgItem(Dialog, ID_RequestLabel), 0, 10, 10, MemoWidth, TxtHeight, 0);
          SetWindowPos(GetDlgItem(Dialog, ID_RequestMemo), 0, 10, 14 + TxtHeight, MemoWidth, MemoHeight, 0);
          SetWindowPos(GetDlgItem(Dialog, ID_RequestBtn), 0, MemoWidth - 65, 20 + TxtHeight + MemoHeight, 75, 23, 0);
          SetAutoCloseTimer(Dialog);
          SetAutoTopMost(Dialog);
        end;
      WM_DESTROY:
        begin
          UnsetAutoCloseTimer(Dialog);
          UnsetAutoTopMost(Dialog);
          DestroyDialogFonts;
        end;
      WM_KEYDOWN, WM_MOUSEWHEEL, WM_NOTIFY, WM_LBUTTONDBLCLK,
        WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN,
        WM_MBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
        WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
      WM_COMMAND:
        begin
          ResetAutoCloseTimer;
          case WParam of
            ID_RequestBtn:
              begin
                Len := SendMessage(GetDlgItem(Dialog, ID_RequestMemo),
                  WM_GETTEXTLENGTH, 0, 0) + 1;
                SetLength(CurrentRequestValue, Len);
                SendMessage(GetDlgItem(Dialog, ID_RequestMemo),
                  WM_GETTEXT, Len, DWord(@CurrentRequestValue[1]));
                Delete(CurrentRequestValue, Length(CurrentRequestValue), 1);
                CurrentRequestValue := Trim(CurrentRequestValue);

                AddCustomHeaderToLog(
                  7, CurrentOptions.CustomizedExpandedTexts[mtReproduceDialog_Caption],
                  CurrentRequestValue);

                EndDialog(Dialog, 0);
              end;
          end;
        end;
      WM_NCPAINT, WM_NCACTIVATE:
        Result := DlgTemplate(Msg, WParam, LParam, Dialog,
          CurrentOptions.CustomizedExpandedTexts[mtReproduceDialog_Caption]);
      WM_PAINT:
        begin
          IsDialogShowed := True;
        end;
    end;
  end;

begin
  if (not (loAppendReproduceText in CurrentOptions.LogOptions)) or
    (not IsGUI) or (DuplicatedException) or
    ((not CanSendMessage) and
    (not CurrentOptions.SaveLogFile)) then Exit;

  IsDialogShowed := False;
  try
    DialogBoxParam(hInstance, RequestDialogName, 0, @NewDialogProc, 0);
  finally
    IsDialogShowed := False;
  end;
end;

function CreateThreadStr(Index: Integer; StackData: PEurekaDebugInfo; TextLog: Boolean): string;
var
  Priority, ClassName: string;
  Idx: Integer;
  ThreadInfo: PEurekaThreadInfo;

  procedure AssignPriority;
  begin
    ThreadsList.BeginWrite;
    try
      Idx := ThreadsList.FindByThreadID(StackData^.ThreadID);
      if (Idx <> -1) then
      begin
        ThreadsList[Idx]^.Priority := GetThreadPriority(ThreadsList[Idx]^.Handle);
        Priority := IntToStr(ThreadsList[Idx]^.Priority);
      end;
    finally
      ThreadsList.EndWrite;
    end;
  end;

  function ExtractThreadByList: PEurekaThreadInfo;
  begin
    Result := nil;
    ThreadsList.BeginRead;
    try
      Idx := ThreadsList.FindByThreadID(StackData^.ThreadID);
      if (Idx <> -1) then
      begin
        New(Result);
        Result^ := ThreadsList[Idx]^;
      end;
    finally
      ThreadsList.EndRead;
    end;
  end;

  procedure GetThreadData(var AMustAssignPriority: Boolean);
  begin
    AMustAssignPriority := False;
    if (ThreadInfo <> nil) then
    try
      if (ThreadInfo^.Priority <> THREAD_PRIORITY_UNDEFINED) then
        Priority := IntToStr(ThreadInfo^.Priority)
      else
      begin
        AMustAssignPriority := True;
        Priority := '??';
      end;
      if (IsValidObject(ThreadInfo^.Thread)) then
        ClassName := ThreadInfo^.Thread.ClassName
      else
        ClassName := '';
    finally
      Dispose(ThreadInfo);
    end
    else
    begin
      Priority := '??';
      ClassName := '';
    end;
  end;

  procedure CreateExceptionReport;
  var
    Gap: string;
    MustAssignPriority: Boolean;
  begin
    if (StackData^.RunningThread) then
      if (StackData^.ErrorLine) then
      begin
        if (TextLog) then Gap := '*' else Gap := '';
        Result := (Gap + CurrentOptions.CustomizedExpandedTexts[mtCallStack_ExceptionThread] + ': ')
      end
      else
        Result := (CurrentOptions.CustomizedExpandedTexts[mtCallStack_RunningThread] + ': ')
    else
      Result := (CurrentOptions.CustomizedExpandedTexts[mtCallStack_CallingThread] + ': ');

    ThreadInfo := ExtractThreadByList;
    GetThreadData(MustAssignPriority);
    if (MustAssignPriority) then AssignPriority;

    Result := Result + Format('%s=%d; %s=%s',
      [CurrentOptions.CustomizedExpandedTexts[mtCallStack_ThreadID], StackData^.ThreadID,
      CurrentOptions.CustomizedExpandedTexts[mtCallStack_ThreadPriority], Priority]);
    if ((TextLog) or (ClassName <> '')) then
      Result := (Result + Format('; %s=%s',
        [CurrentOptions.CustomizedExpandedTexts[mtCallStack_ThreadClass], ClassName]));
    if (StackData^.ThreadID = MainThreadID) then
      Result := (Result + '; [' + CurrentOptions.CustomizedExpandedTexts[mtCallStack_MainThread]) + ']';
  end;

  procedure CreateLeakReport;
  var
    Gap, TypeStr: string;
  begin
    TypeStr := StackData^.LeakType;
    if (TypeStr = 'Data') then
      TypeStr := CurrentOptions.CustomizedExpandedTexts[mtCallStack_LeakData];
    if (TextLog) then Gap := '+' else Gap := '';
    Result := (Gap + Format('%s: %s=%s; %s=%d; %s=%d',
      [CurrentOptions.CustomizedExpandedTexts[mtCallStack_LeakCaption],
      CurrentOptions.CustomizedExpandedTexts[mtCallStack_LeakType], TypeStr,
      CurrentOptions.CustomizedExpandedTexts[mtCallStack_LeakSize], StackData^.LeakSize,
      CurrentOptions.CustomizedExpandedTexts[mtCallStack_LeakCount], StackData^.LeakCount]));
  end;

begin
  if (StackData^.IsALeak) then CreateLeakReport
  else CreateExceptionReport;
end;

// -----------------------------------------------------------------------------
// MultiMonitor support...
// -----------------------------------------------------------------------------

function GetActiveMonitorData(var Rect: TRect): Boolean;
type
  TMonitorInfo = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
  end;
  PMonitorInfo = ^ TMonitorInfo;
var
  Lib, MonitorMin, MonitorMax: THandle;
  RcMin, RcMax: TRect;
  MonInfo: TMonitorInfo;
  MonitorFromWindow: function(hWnd: HWND; dwFlags: DWORD): THandle; stdcall;
  MonitorFromPoint: function (ptScreenCoords: TPoint; dwFlags: DWORD): THandle; stdcall;
  GetMonitorInfo: function(hMonitor: THandle; lpMonitorInfo: PMonitorInfo): Boolean; stdcall;
begin
  Result := False;
  Lib := LoadLibrary('user32.dll');
  if (Lib <> 0) then
  try
    @GetMonitorInfo := GetProcAddress(Lib, 'GetMonitorInfoA');
    @MonitorFromWindow := GetProcAddress(Lib, 'MonitorFromWindow');
    @MonitorFromPoint := GetProcAddress(Lib, 'MonitorFromPoint');
    if (Assigned(GetMonitorInfo)) and (Assigned(MonitorFromPoint)) then
    begin
      MonitorMin := MonitorFromPoint(Rect.TopLeft, 2 {MONITOR_DEFAULTTONEAREST});
      MonitorMax := MonitorFromPoint(Rect.BottomRight, 2 {MONITOR_DEFAULTTONEAREST});
      if (MonitorMin <> 0) and (MonitorMax <> 0) then
      begin
        MonInfo.cbSize := SizeOf(MonInfo);
        if GetMonitorInfo(MonitorMin, @MonInfo) then
        begin
          RcMin := MonInfo.rcMonitor;
          if GetMonitorInfo(MonitorMax, @MonInfo) then
          begin
            RcMax := MonInfo.rcMonitor;
            Rect.TopLeft := RcMin.TopLeft;
            Rect.BottomRight := RcMax.BottomRight;
            Result := True;
          end;
        end;
      end;
    end;
  finally
    FreeLibrary(Lib);
  end;
end;

function GetMonitorWorkAreaFromWndEx(Wnd: THandle; var Rect: TRect): Boolean;
type
  TMonitorInfo = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFlags: DWORD;
  end;
  PMonitorInfo = ^ TMonitorInfo;
var
  Lib, Monitor: THandle;
  MonInfo: TMonitorInfo;
  MonitorFromWindow: function(hWnd: HWND; dwFlags: DWORD): THandle; stdcall;
  GetMonitorInfo: function(hMonitor: THandle; lpMonitorInfo: PMonitorInfo): Boolean; stdcall;
begin
  Result := False;

  Lib := LoadLibrary('user32.dll');
  if (Lib <> 0) then
  try
    @GetMonitorInfo := GetProcAddress(Lib, 'GetMonitorInfoA');
    @MonitorFromWindow := GetProcAddress(Lib, 'MonitorFromWindow');
    if ((Assigned(MonitorFromWindow)) and (Assigned(GetMonitorInfo))) then
    begin
      Monitor := MonitorFromWindow(Wnd, 2 {MONITOR_DEFAULTTONEAREST});
      if (Monitor <> 0) then
      begin
        MonInfo.cbSize := SizeOf(MonInfo);
        if GetMonitorInfo(Monitor, @MonInfo) then
        begin
          Rect := MonInfo.rcWork;
          Result := True;
        end;
      end;
    end;
  finally
    FreeLibrary(Lib);
  end;
end;

function GetMonitorWorkAreaFromWnd(Wnd: THandle): TRect;
begin
  if (not GetMonitorWorkAreaFromWndEx(Wnd, Result)) then
    SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
end;

function GetMonitorWorkAreaFromActiveWnd: TRect;
var
  Wnd: THandle;
begin
  Wnd := GetForegroundWindow;
  if (Wnd = 0) then Wnd := GetDesktopWindow;
  Result := GetMonitorWorkAreaFromWnd(Wnd);
end;

procedure CenterOnActiveWndMonitor(Wnd: THandle; Width, Height: Integer);
var
  MonitorRect: TRect;
begin
  MonitorRect := GetMonitorWorkAreaFromActiveWnd;
  SetWindowPos(Wnd, 0,
    (MonitorRect.Left + ((MonitorRect.Right - MonitorRect.Left - Width) div 2)),
    (MonitorRect.Top + ((MonitorRect.Bottom - MonitorRect.Top - Height) div 2)),
    Width, Height, 0);
end;

//------------------------------------------------------------------------------

procedure ShowDialog(PlaySound: Boolean);
var
  OldForegroundWnd, RichLib: THandle;
  CanExit: Boolean;

  function NewDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
    LParam: DWord): Longbool; stdcall;
  var
    PS: TPaintStruct;
    TextSize: TSize;
    Hdl: THandle;
    rExt, rInt, rTit, rTit2, rCpt: TRect;
    b: HBrush;
    DC: HDC;
    BackColor, BorderColor, BorderBack: COLORREF;
    Red, Green, Blue: Integer;
    BordW, BordH: integer;
    HelpX, fW, fH, Width, Height, Left, Top,
      ScreenWidth, ScreenHeight, ButtonWidth: Integer;
    ScreenRect: TRect;
    P: PRect;
    Region, InternalRegion: HRGN;
    Tab: tagTCITEMA;
    i, TerminateVisibleState: integer;
    Pt: TPoint;

    procedure InsertColumn(hList: THandle; ColNo, ColWidth, ColAlign: integer;
      ColText: string);
    var
      Column: tagLVCOLUMNA;
    begin
      with Column do
      begin
        mask := LVCF_FMT or LVCF_WIDTH or LVCF_TEXT or LVCF_SUBITEM;
        iSubItem := ColNo;
        fmt := ColALign;
        cx := COlWidth;
        pszText := PChar(ColText);
        SendMessage(hList, LVM_INSERTCOLUMN, ColNo, Longint(@Column));
      end;
    end;

    procedure SetDialogRect(Value: TRect);
    var
      Placement: TWindowPlacement;
    begin
      Placement.length := SizeOf(TWindowPlacement);
      GetWindowPlacement(Dialog, @Placement);
      Placement.rcNormalPosition := Value;
      SetWindowPlacement(Dialog, @Placement);
    end;

    procedure ReadState;
    begin
      ScreenRect := GetMonitorWorkAreaFromActiveWnd;
      ScreenWidth := (ScreenRect.Right - ScreenRect.Left);
      ScreenHeight := (ScreenRect.Bottom - ScreenRect.Top);

      Width := StrToInt(ReadString(EurekaIni, 'Coordinates', 'Width', '745'));
      Height := StrToInt(ReadString(EurekaIni, 'Coordinates', 'Height', '468'));
      Left := StrToInt(ReadString(EurekaIni, 'Coordinates', 'Left',
        IntToStr(ScreenRect.Left + (ScreenWidth - Width) div 2)));
      Top := StrToInt(ReadString(EurekaIni, 'Coordinates', 'Top',
        IntToStr(ScreenRect.Top + (ScreenHeight - (Height + DialogHeight)) div 2)));
      WindowState := StrToInt(ReadString(EurekaIni, 'Coordinates',
        'WindowsState', IntToStr(SW_SHOWNORMAL)));
      if (Top + Height > ScreenRect.Bottom) then
        Top := ScreenRect.Bottom - (Height + DialogHeight);
      if (Left + Width > ScreenRect.Right) then
        Left := ScreenRect.Right - Width;
      if (Top < ScreenRect.Top) then Top := ScreenRect.Top;
      if (Left < ScreenRect.Left) then Left := ScreenRect.Left;
    end;

    procedure SaveState;
    begin
      if (RealWidth <> 0) then
      begin
        if (WindowState = SW_SHOWNORMAL) then
        begin
          WriteString(EurekaIni, 'Coordinates', 'Width', IntToStr(RealWidth));
          WriteString(EurekaIni, 'Coordinates', 'Height', IntToStr(RealHeight - DialogHeight));
          WriteString(EurekaIni, 'Coordinates', 'Left', IntToStr(RealLeft));
          WriteString(EurekaIni, 'Coordinates', 'Top', IntToStr(RealTop));
        end;
        WriteString(EurekaIni, 'Coordinates', 'WindowsState', IntToStr(WindowState));
      end;
    end;

    procedure SetDialogState(Value: Cardinal);
    var
      Placement: TWindowPlacement;
    begin
      Placement.length := SizeOf(TWindowPlacement);
      GetWindowPlacement(Dialog, @Placement);
      Placement.showCmd := Value;
      SetWindowPlacement(Dialog, @Placement);
    end;

    procedure DetailsState(Value: boolean);
    var
      DStyle, Base: DWord;
      NewWidth: integer;
      Size: TSize;
      Hdc: THandle;
      Bx, n, MaxWidth, MaxHeight: Integer;
      DetailsTxt: string;
      Lines: TStringList;

      procedure AdjustFlatStyle(BtnID: Integer);
      var
        BStyle: DWord;
        BtnHnd: THandle;
      begin
        if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then Exit;

        BtnHnd := GetDlgItem(Dialog, BtnID);
        BStyle := GetWindowLong(BtnHnd, GWL_STYLE);
        BStyle := BStyle and ($FFFFFFFF - BS_FLAT);
        SetWindowLong(BtnHnd, GWL_STYLE, BStyle);
      end;

    begin
      if (not Value) then ShowWindow(Dialog, SW_SHOWNORMAL);
      AdjustFlatStyle(ID_BUTTON);
      AdjustFlatStyle(ID_TERMINATE);
      AdjustFlatStyle(ID_DETAILS);
      AdjustFlatStyle(ID_CUSTOM);      
      AdjustFlatStyle(ID_EMAIL);
      AdjustFlatStyle(ID_SCREEN);
      AdjustFlatStyle(ID_COPY);
      DStyle := GetWindowLong(Dialog, GWL_STYLE);
      Base := WS_THICKFRAME or WS_MAXIMIZEBOX;
      if (not (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions)) then
        Base := Base or WS_SYSMENU;
      if Value then
        DStyle := DStyle or Base
      else
        DStyle := DStyle and ($FFFFFFFF - Base);
      SetWindowLong(Dialog, GWL_STYLE, DStyle);
      DetailsTxt :=
        CurrentOptions.CustomizedExpandedTexts[mtDialog_DetailsButtonCaption];
      if Value then
      begin
        DetailsTxt := '<< ' + DetailsTxt;
        SendMessage(GetDlgItem(Dialog, ID_TEXT), WM_SETTEXT, 0,
          Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_ErrorMsgCaption])));
        ReadState;
        SetDialogState(WindowState);
        ShowWindow(GetDlgItem(Dialog, ID_PAGE), SW_SHOWNA);
        SetDialogRect(Rect(Left, Top, Left + Width, Top + Height + DialogHeight));
      end
      else
      begin
        DetailsTxt := DetailsTxt + ' >>';
        SendMessage(GetDlgItem(Dialog, ID_TEXT), WM_SETTEXT, 0,
          Integer(PChar(GetExceptMessage)));
        Hdc := GetWindowDC(Dialog);
        SelectObject(Hdc, fVariableFont);
        MaxWidth := 0;
        MaxHeight := 0;
        Bx := 60 + (GetSystemMetrics(SM_CXFRAME) - 1) * 2;
        Lines := TStringList.Create;
        try
          Lines.Text := GetExceptMessage;
          Lines.Add(CurrentOptions.CustomizedExpandedTexts[mtDialog_SendMessage] +
            '    ' + CurrentOptions.CustomizedExpandedTexts[mtDialog_CopyMessage]);
          for n := 0 to Lines.Count - 1 do
          begin
            if (Lines[n] = '') then Lines[n] := ' ';
            GetTextExtentPoint32(Hdc, PChar(Lines[n]), Length(Lines[n]), Size);
            if (Size.cx > MaxWidth) then
            begin
              MaxWidth := (Size.cx + 16);
              if (MaxWidth > 640 - Bx) then
              begin
                inc(MaxHeight, ((MaxWidth - (640 - Bx))
                  div (640 - Bx) + 1) * Size.cy);
                MaxWidth := (640 - BX);
              end;
            end;
            inc(MaxHeight, Size.cy);
          end;
        finally
          Lines.Free;
        end;
        ReleaseDC(Dialog, Hdc);
        Width := MaxWidth + Bx;
        if (Width < 340) then Width := 340;
        NewWidth := (Width - Bx);

        SetWindowPos(GetDlgItem(Dialog, ID_TEXT), 0, 48, 8,
          NewWidth, MaxHeight, SWP_NOZORDER + SWP_NOACTIVATE);
        InvalidateRect(GetDlgItem(Dialog, ID_TEXT), nil, True);


        ScreenRect := GetMonitorWorkAreaFromActiveWnd;
        ScreenWidth := (ScreenRect.Right - ScreenRect.Left);
        ScreenHeight := (ScreenRect.Bottom - ScreenRect.Top);

        if (MaxHeight <= 39) then MaxHeight := 0
        else Dec(MaxHeight, 39);

        Height := 88 + MaxHeight + (GetSystemMetrics(SM_CYFRAME) - 1) * 2 +
          GetSystemMetrics(CAPTION_HEIGHT);
        Left := (ScreenRect.Left + (ScreenWidth - Width) div 2);
        Top := (ScreenRect.Top + (ScreenHeight - Height) div 2);
        ShowWindow(GetDlgItem(Dialog, ID_PAGE), SW_HIDE);
        SetDialogRect(Rect(Left, Top, Left + Width, Top + Height + DialogHeight));
      end;

      SendMessage(GetDlgItem(Dialog, ID_DETAILS), WM_SETTEXT, 0,
        Integer(PChar(DetailsTxt)));
    end;

    function ModulesListDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
      LParam: DWord): Longbool; stdcall;
    const
      ColIdx: array [0..6] of Byte = (0, 1, 2, 3, 4, 6, 5);
    var
      n: Integer;

      function ModuleBmp(Module: TEurekaModuleInfo): Integer;
      var
        Ext: string;
      begin
        Result := 0;
        Ext := UpperCase(ExtractFileExt(Module.Name));
        if (Ext = '.BPL') or (Ext = '.DPL') then Result := 1
        else
          if (Ext = '.EXE') then Result := 2;
      end;

    begin
      Result := False;
      case Msg of
        WM_INITDIALOG:
          begin
            fListViewItems := TListViewItems.Create(GetDlgItem(Dialog, ID_LISTMEMO));
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), WM_SETFONT, fFixedFont2, 1);

            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_ModulesHeader])));
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETFONT, fVariableFont, 1);

            ColWidths[0] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColMod0', '80'));
            ColWidths[1] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColMod1', '96'));
            ColWidths[2] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColMod2', '175'));
            ColWidths[3] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColMod3', '50'));
            ColWidths[4] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColMod4', '54'));
            ColWidths[5] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColMod5', '712'));
            ColWidths[6] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColMod6', '80'));

            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 0, ColWidths[0],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtModules_Handle]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 1, ColWidths[1],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtModules_Name]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 2, ColWidths[2],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtModules_Description]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 3, ColWidths[3],
              LVCFMT_RIGHT,
              CurrentOptions.CustomizedExpandedTexts[mtModules_Version]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 4, ColWidths[4],
              LVCFMT_RIGHT,
              CurrentOptions.CustomizedExpandedTexts[mtModules_Size]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 5, ColWidths[6],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtModules_LastModified]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 6, ColWidths[5],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtModules_Path]);

            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETTEXTBKCOLOR, 0, color_Back);
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETBKCOLOR, 0, color_Back);
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETTEXTCOLOR, 0, color_Text);
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO),
              LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT);
            for n := 0 to ModulesList.Count - 1 do
              fListViewItems.AddRow(
                [IntToHex(ModulesList[n].Handle, 8),
                ExtractFileName(ModulesList[n]^.Name),
                  ModulesList[n]^.Description,
                  GetModuleVer(ModulesList[n]^.Version),
                  GetModuleSize(ModulesList[n]^.Size),
                  ISODateTime(ModulesList[n]^.LastModified),
                  GetModulePath(ModulesList[n]^.Name)],
                  ModuleBmp(ModulesList[n]^), nil, False, '');
          end;
        WM_DESTROY:
          begin
            fListViewItems.Free;
            for n := 0 to 6 do
            begin
              WriteString(EurekaIni, 'Coordinates', 'ColMod' + IntToStr(ColIdx[n]),
                IntToStr(Integer(SendMessage(GetDlgItem(Dialog, ID_LISTMEMO),
                LVM_GETCOLUMNWIDTH, n, 0))));
            end;
          end;
        WM_CTLCOLORDLG:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
              Result := longbool(fDlgBack);
          end;
        WM_CTLCOLORSTATIC:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
            begin
              SetBkMode(WParam, TRANSPARENT);
              SetTextColor(WParam, color_Text);
              Result := longbool(fDlgBack);
            end;
          end;
        WM_KEYDOWN, WM_MOUSEWHEEL, WM_NOTIFY, WM_COMMAND, WM_LBUTTONDBLCLK,
          WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN,
          WM_MBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
          WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
        WM_DRAWITEM:
          begin
            Result := fListViewItems.DrawList(lParam);
          end;
      end;
    end;

    function ProcessesListDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
      LParam: DWord): Longbool; stdcall;
    var
      n: Integer;

      function ModuleBmp(Module: TEurekaModuleInfo): Integer;
      var
        Ext: string;
      begin
        Result := 0;
        Ext := UpperCase(ExtractFileExt(Module.Name));
        if (Ext = '.BPL') or (Ext = '.DPL') then Result := 1
        else
          if (Ext = '.EXE') then Result := 2;
      end;

      function ModuleSize(Module: TEurekaModuleInfo): string;
      begin
        Result := IntToStr(Round(Module.Size / 1024)) + ' Kb';
      end;

      function ModuleVer(Module: TEurekaModuleInfo): string;
      var
        n, c: integer;
      begin
        Result := Module.Version;
        n := 1;
        c := 0;
        while (n <= Length(Result)) and (c < 2) do
        begin
          if (Result[n] = '.') then Inc(c);
          inc(n);
        end;
        if (c = 2) then Result := Copy(Result, 1, n - 1) + 'x';
      end;

    begin
      Result := False;
      case Msg of
        WM_INITDIALOG:
          begin
            fListViewItems := TListViewItems.Create(GetDlgItem(Dialog, ID_LISTMEMO));
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), WM_SETFONT, fFixedFont2, 1);

            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_ProcessesHeader])));
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETFONT, fVariableFont, 1);

            ColWidths[0] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColPro0', '48'));
            ColWidths[1] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColPro1', '134'));
            ColWidths[2] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColPro2', '232'));
            ColWidths[3] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColPro3', '56'));
            ColWidths[4] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColPro4', '57'));
            ColWidths[5] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColPro5', '47'));
            ColWidths[6] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColPro6', '52'));
            ColWidths[7] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'ColPro7', '330'));

            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 0, ColWidths[0],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtProcesses_ID]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 1, ColWidths[1],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtProcesses_Name]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 2, ColWidths[2],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtProcesses_Description]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 3, ColWidths[3],
              LVCFMT_RIGHT,
              CurrentOptions.CustomizedExpandedTexts[mtProcesses_Version]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 4, ColWidths[4],
              LVCFMT_RIGHT,
              CurrentOptions.CustomizedExpandedTexts[mtProcesses_Memory]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 5, ColWidths[5],
              LVCFMT_RIGHT,
              CurrentOptions.CustomizedExpandedTexts[mtProcesses_Priority]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 6, ColWidths[6],
              LVCFMT_RIGHT,
              CurrentOptions.CustomizedExpandedTexts[mtProcesses_Threads]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 7, ColWidths[7],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtProcesses_Path]);

            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETTEXTBKCOLOR, 0, color_Back);
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETBKCOLOR, 0, color_Back);
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETTEXTCOLOR, 0, color_Text);
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO),
              LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT);
            for n := 0 to ProcessesList.Count - 1 do
              fListViewItems.AddRow(
                [IntToStr(ProcessesList[n].ProcessID),
                ExtractFileName(ProcessesList[n]^.Name),
                  ProcessesList[n]^.Description,
                  GetModuleVer(ProcessesList[n]^.Version),
                  GetModuleSize(ProcessesList[n]^.Memory),
                  PriorityToString(ProcessesList[n]^.Priority),
                  GetProcessThreads(ProcessesList[n]^.Threads),
                  GetModulePath(ExtractFilePath(ProcessesList[n]^.Name))],
                  2, nil, False, '');
          end;
        WM_DESTROY:
          begin
            fListViewItems.Free;
            for n := 0 to 7 do
            begin
              WriteString(EurekaIni, 'Coordinates', 'ColPro' + IntToStr(n),
                IntToStr(Integer(SendMessage(GetDlgItem(Dialog, ID_LISTMEMO),
                LVM_GETCOLUMNWIDTH, n, 0))));
            end;
          end;
        WM_CTLCOLORDLG:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
              Result := longbool(fDlgBack);
          end;
        WM_CTLCOLORSTATIC:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
            begin
              SetBkMode(WParam, TRANSPARENT);
              SetTextColor(WParam, color_Text);
              Result := longbool(fDlgBack);
            end;
          end;
        WM_KEYDOWN, WM_MOUSEWHEEL, WM_NOTIFY, WM_COMMAND, WM_LBUTTONDBLCLK,
          WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN,
          WM_MBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
          WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
        WM_DRAWITEM:
          begin
            Result := fListViewItems.DrawList(lParam);
          end;
      end;
    end;

    function AssemblerDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
      LParam: DWord): Longbool; stdcall;
    begin
      Result := False;
      case Msg of
        WM_INITDIALOG:
          begin
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), WM_SETFONT, fFixedFont1, 1);
            RTF_LoadFromText(GetDlgItem(Dialog, ID_LISTMEMO),
              AssemblerToRTF(CurrentAsmErrorText));
            SetRTFBackColor(GetDlgItem(Dialog, ID_LISTMEMO), color_Back);
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_AsmHeader])));
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETFONT, fVariableFont, 1);
          end;
        WM_DESTROY:
          begin
          end;
        WM_KEYDOWN, WM_MOUSEWHEEL, WM_NOTIFY, WM_COMMAND, WM_LBUTTONDBLCLK,
          WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN,
          WM_MBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
          WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
        WM_SIZE:
          begin
          end;
        WM_CTLCOLORDLG:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
              Result := longbool(fDlgBack);
          end;
        WM_CTLCOLORSTATIC:
          begin
            if THandle(LParam) <> GetDlgItem(Dialog, ID_LISTMEMO) then
            begin
              SetBkMode(WParam, TRANSPARENT);
              SetTextColor(WParam, color_Text);
              if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
                Result := longbool(fDlgBack);
            end
            else
            begin
              SetBkMode(WParam, OPAQUE);
              SetTextColor(WParam, color_Text);
              result := longbool(fMemoBack);
            end;
          end;
      end;
    end;

    function CallStackDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
      LParam: DWord): Longbool; stdcall;
    var
      i, n: Integer;
      ln, ModName: string;
      LastUsedThreadID: DWord;
      RunningThread, FirstLine: Boolean;
    {$IFDEF PROFESSIONAL}
      ModInfo: PEurekaModuleInfo;
      Address, Line, Offset, UnitName, Classname, ProcName: string;
      Compiled: TDateTime;
      Index: Integer;
      Pt: TPoint;

      procedure OpenIDEEditor(LineStr, UnitStr, ClassStr, ProcStr, OffsetStr: string;
        Compiled: TDateTime);
      type
        TMailSlotMsg = packed record
          CompiledFile, UnitName, ClassName, ProcName: array[0..89] of Char;
          Line, Offset: DWord;
          Compiled: TDateTime;
        end;

      var
        MailSlotMsg: TMailSlotMsg;

        procedure MailSlotSend(const Name: string; Msg: TMailSlotMsg);
        var
          MailSlot: THandle;
          BytesWritten: DWord;
          i: Integer;
        begin
          for i := 0 to 3 do
          begin
            MailSlot := CreateFile(PChar('\\.\mailslot\' + Name + IntToStr(i)),
              GENERIC_WRITE, FILE_SHARE_READ, nil,
              OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
            if (MailSlot <> INVALID_HANDLE_VALUE) then
            begin
              WriteFile(MailSlot, Msg, SizeOf(Msg), BytesWritten, nil);
              CloseHandle(MailSlot);
            end;
          end;
        end;

      begin
        if (LineStr <> '') then
        begin
          if (OffsetStr = '') then OffsetStr := '-1';
          StrPCopy(MailSlotMsg.CompiledFile, '');
          StrPCopy(MailSlotMsg.UnitName, UnitStr);
          StrPCopy(MailSlotMsg.ClassName, ClassStr);
          StrPCopy(MailSlotMsg.ProcName, ProcStr);
          MailSlotMsg.Offset := StrToInt(Trim(OffsetStr));
          MailSlotMsg.Line := StrToInt(Trim(LineStr));
          MailSlotMsg.Compiled := Compiled;
          SetForegroundWindow(FindWindow('TAppBuilder', nil));
          MailSlotSend('EurekaLog', MailSlotMsg);
        end;
      end;


      function GetItemText(hwndLV: HWND; i, iSubItem: Integer): string;
      var
        Buffer: array[0..255] of byte;
        Item: tagLVITEMA;
      begin
        Item.iSubItem := iSubItem;
        Item.cchTextMax := SizeOf(Buffer);
        Item.pszText := @Buffer;
        SendMessage(hwndLV, LVM_GETITEMTEXT, i, Longint(@Item));
        Result := Item.pszText;
      end;
    {$ENDIF}

    begin
      Result := False;
      case Msg of
        WM_INITDIALOG:
          begin
            fListViewItems := TListViewItems.Create(GetDlgItem(Dialog, ID_LISTMEMO));
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), WM_SETFONT, fFixedFont2, 1);

            ColWidths[0] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'Col0', '89'));
            ColWidths[1] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'Col1', '92'));
            ColWidths[2] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'Col2', '126'));
            ColWidths[3] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'Col3', '126'));
            ColWidths[4] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'Col4', '200'));
            ColWidths[5] :=
              StrToInt(ReadString(EurekaIni, 'Coordinates', 'Col5', '61'));

            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETTEXTBKCOLOR, 0, color_Back);
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETBKCOLOR, 0, color_Back);
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), LVM_SETTEXTCOLOR, 0, color_Text);

            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 0, ColWidths[0],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtCallStack_Address]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 1, ColWidths[1],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtCallStack_Name]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 2, ColWidths[2],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtCallStack_Unit]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 3, ColWidths[3],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtCallStack_Class]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 4, ColWidths[4],
              LVCFMT_LEFT,
              CurrentOptions.CustomizedExpandedTexts[mtCallStack_Procedure]);
            InsertColumn(GetDlgItem(Dialog, ID_LISTMEMO), 5, ColWidths[5],
              LVCFMT_RIGHT,
              CurrentOptions.CustomizedExpandedTexts[mtCallStack_Line]);

            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO),
              LVM_SETEXTENDEDLISTVIEWSTYLE, 0, LVS_EX_FULLROWSELECT);

            LastUsedThreadID := 0;
            RunningThread := False;
            FirstLine := True;
            for i := 0 to CurrentStackList.Count - 1 do
              if (CurrentStackList[i]^.DebugDetail in GetDebugDetail(CurrentOptions)) and not
                ((CurrentStackList[i]^.ModuleInfo^.ModuleType = mtMainModule) and
                (CurrentStackList[i]^.DebugDetail = ddUnitAndProcedure)) then
              begin
                if ((LastUsedThreadID <> CurrentStackList[i]^.ThreadID) or (FirstLine) or
                  (RunningThread <> CurrentStackList[i]^.RunningThread) or
                  (CurrentStackList[i]^.ErrorLine = True)) then
                begin
                  if ((CurrentStackList[i]^.RunningThread) and (not FirstLine)) then
                    fListViewItems.AddRow(
                      ['', '', '', '', '', ''], -1, nil, False, '');
                  fListViewItems.AddRow(
                    ['', '', '', '', '', ''], -1,
                    Pointer(Byte(CurrentStackList[i]^.RunningThread) or
                      (Byte(CurrentStackList[i]^.ErrorLine) shl 1)),
                    True, CreateThreadStr(i, CurrentStackList[i], False));
                end;
                ln := IntToStr(CurrentStackList[i]^.Line);
                if (ln = '0') then ln := ''
                else
                begin
                  ln := ln + '[' + (IntToStr(CurrentStackList[i]^.ProcOffsetLine)) + ']';
                end;
                n := 3;
                if (CurrentStackList[i]^.DebugDetail <> ddSourceCode) then
                  case CurrentStackList[i]^.ModuleInfo^.ModuleType of
                    mtMainModule: n := 2;
                    mtBorlandPackage: n := 1;
                    mtOSLibrary, mtUnknown: n := 0;
                  end;
                if (CurrentStackList[i]^.DebugDetail <> ddNone) then
                  ModName := ExtractFileName(CurrentStackList[i]^.ModuleInfo^.Name)
                else ModName := '';
                fListViewItems.AddRow(
                  [IntToHex(CurrentStackList[i]^.Addr, 8),
                  ModName, CurrentStackList[i]^.UnitName,
                    CurrentStackList[i]^.ClassName,
                    CurrentStackList[i]^.ProcedureName, ln], n, nil, False, '');
                LastUsedThreadID := CurrentStackList[i]^.ThreadID;
                RunningThread := CurrentStackList[i]^.RunningThread;
                FirstLine := False;
              end;

            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_CallStackHeader])));
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETFONT, fVariableFont, 1);

//            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), WM_KEYDOWN, VK_DOWN, 1);
          end;
        WM_DESTROY:
          begin
            fListViewItems.Free;
            for i := 0 to 5 do
            begin
              WriteString(EurekaIni, 'Coordinates', 'Col' + IntToStr(i),
                IntToStr(Integer(SendMessage(GetDlgItem(Dialog, ID_LISTMEMO),
                LVM_GETCOLUMNWIDTH, i, 0))));
            end;
          end;
        WM_KEYDOWN, WM_MOUSEWHEEL, WM_COMMAND, WM_LBUTTONDBLCLK,
          WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN,
          WM_MBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
          WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
        WM_SIZE:
          begin
          end;
        WM_CTLCOLORDLG:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
              Result := longbool(fDlgBack);
          end;
        WM_CTLCOLORSTATIC:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
            begin
              SetBkMode(WParam, TRANSPARENT);
              SetTextColor(WParam, color_Text);
              Result := longbool(fDlgBack);
            end;
          end;
        WM_DRAWITEM:
          begin
            Result := fListViewItems.DrawList(lParam);
          end;
  {$IFDEF PROFESSIONAL}
        WM_NOTIFY:
          begin
            ResetAutoCloseTimer;
            if (PNMHdr(LParam)^.code = NM_AFTERCLICK) and
              (PNMHdr(LParam)^.hwndFrom = GetDlgItem(Dialog, ID_LISTMEMO)) then
            begin
              Index := SendMessage(GetDlgItem(Dialog, ID_LISTMEMO),
                LVM_GETNEXTITEM, -1, MakeLong(LVNI_SELECTED or LVNI_ALL, 0));
              if (Index <> -1) then
              begin
                GetCursorPos(Pt);
                ScreenToClient(GetDlgItem(Dialog, ID_LISTMEMO), Pt);
                fListViewItems.ClickOnItem(Index, Pt, True);
              end;
            end;
            if (PNMHdr(LParam)^.code = NM_DBLCLK) and
              (PNMHdr(LParam)^.hwndFrom = GetDlgItem(Dialog, ID_LISTMEMO)) then
            begin
              Index := SendMessage(GetDlgItem(Dialog, ID_LISTMEMO),
                LVM_GETNEXTITEM, -1, MakeLong(LVNI_SELECTED or LVNI_ALL, 0));
              Address := ('$' + Trim(GetItemText(GetDlgItem(Dialog, ID_LISTMEMO), Index, 0)));
              UnitName := Trim(GetItemText(GetDlgItem(Dialog, ID_LISTMEMO), Index, 2));
              ClassName := Trim(GetItemText(GetDlgItem(Dialog, ID_LISTMEMO), Index, 3));
              ProcName := Trim(GetItemText(GetDlgItem(Dialog, ID_LISTMEMO), Index, 4));
              Line := Trim(GetItemText(GetDlgItem(Dialog, ID_LISTMEMO), Index, 5));
              if (Line <> '') then
              begin
                Offset := '-1';
                Index := Pos('[', Line);
                if (Index > 0) then
                begin
                  for n := (Index + 1) to Length(Line) do
                  begin
                    if (Line[n] < '0') or (Line[n] > '9') then
                    begin
                      Offset := Copy(Line, (Index + 1), (n - Index - 1));
                      Break;
                    end;
                  end;
                end;
                for n := 1 to Length(Line) do
                begin
                  if (Line[n] < '0') or (Line[n] > '9') then
                  begin
                    Line := Copy(Line, 1, n - 1);
                    Break;
                  end;
                end;
                ModInfo := ModuleInfoByAddr(StrToInt(Address));
                if (ModInfo <> nil) then
                  Compiled := ModInfo^.ExtraInformation.CompilationDate
                else
                  Compiled := 0;
                OpenIDEEditor(Line, UnitName, ClassName, ProcName, Offset, Compiled);
              end
              else
              begin
                GetCursorPos(Pt);
                ScreenToClient(GetDlgItem(Dialog, ID_LISTMEMO), Pt);
                fListViewItems.ClickOnItem(Index, Pt, False);
              end;
            end;
          end;
  {$ENDIF}
      end;
    end;

    function GeneralDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
      LParam: DWord): Longbool; stdcall;
    begin
      Result := False;
      case Msg of
        WM_INITDIALOG:
          begin
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), WM_SETFONT, fFixedFont1, 1);
            RTF_LoadFromText(GetDlgItem(Dialog, ID_LISTMEMO),
              GeneralToRTF(CurrentGeneralErrorText));
            SetRTFBackColor(GetDlgItem(Dialog, ID_LISTMEMO), color_Back);
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_GeneralHeader])));
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETFONT, fVariableFont, 1);
          end;
        WM_DESTROY:
          begin
          end;
        WM_KEYDOWN, WM_MOUSEWHEEL, WM_NOTIFY, WM_COMMAND, WM_LBUTTONDBLCLK,
          WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN,
          WM_MBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
          WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
        WM_SIZE:
          begin
          end;
        WM_CTLCOLORDLG:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
              Result := longbool(fDlgBack);
          end;
        WM_CTLCOLORSTATIC:
          begin
            if THandle(LParam) <> GetDlgItem(Dialog, ID_LISTMEMO) then
            begin
              SetBkMode(WParam, TRANSPARENT);
              SetTextColor(WParam, color_Text);
              if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
                Result := longbool(fDlgBack);
            end
            else
            begin
              SetBkMode(WParam, OPAQUE);
              SetTextColor(WParam, color_Text);
              result := longbool(fMemoBack);
            end;
          end;
      end;
    end;

    function CPUDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
      LParam: DWord): Longbool; stdcall;
    begin
      Result := False;
      case Msg of
        WM_INITDIALOG:
          begin
            SendMessage(GetDlgItem(Dialog, ID_LISTMEMO), WM_SETFONT, fFixedFont1, 1);
            RTF_LoadFromText(GetDlgItem(Dialog, ID_LISTMEMO), CPUToRTF(CurrentCPUErrorText));
            SetRTFBackColor(GetDlgItem(Dialog, ID_LISTMEMO), color_Back);
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_CPUHeader])));
            SendMessage(GetDlgItem(Dialog, ID_INFORMATION), WM_SETFONT, fVariableFont, 1);
          end;
        WM_KEYDOWN, WM_MOUSEWHEEL, WM_NOTIFY, WM_COMMAND, WM_LBUTTONDBLCLK,
          WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN,
          WM_MBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
          WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
        WM_DESTROY:
          begin
          end;
        WM_SIZE:
          begin
          end;
        WM_CTLCOLORDLG:
          begin
            if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
              Result := longbool(fDlgBack);
          end;
        WM_CTLCOLORSTATIC:
          begin
            if THandle(LParam) <> GetDlgItem(Dialog, ID_LISTMEMO) then
            begin
              SetBkMode(WParam, TRANSPARENT);
              SetTextColor(WParam, color_Text);
              if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
                result := longbool(fDlgBack);
            end
            else
            begin
              SetBkMode(WParam, OPAQUE);
              SetTextColor(WParam, color_Text);
              result := longbool(fMemoBack);
            end;
          end;
      end;
    end;

    function GetDialogState: Cardinal;
    var
      Placement: TWindowPlacement;
    begin
      Placement.length := SizeOf(TWindowPlacement);
      GetWindowPlacement(Dialog, @Placement);
      Result := Placement.showCmd;
    end;

    function GetDialogRect: TRect;
    var
      Placement: TWindowPlacement;
    begin
      Placement.length := SizeOf(TWindowPlacement);
      GetWindowPlacement(Dialog, @Placement);
      Result := Placement.rcNormalPosition;
    end;

    procedure AdjustDialog;
    var
      r: TRect;
    begin
      GetWindowRect(GetDlgItem(Dialog, ID_PAGE), r);
      OffsetRect(r, -r.Left, -r.Top);
      SendMessage(GetDlgItem(Dialog, ID_PAGE), TCM_ADJUSTRECT, 0, Integer(@r));
      dec(r.Left, 3);
      dec(r.Top);
      MoveWindow(fActivePage, r.left, r.top,
        r.right - r.left, r.bottom - r.top, True);
      MoveWindow(GetDlgItem(fActivePage, ID_LISTMEMO), r.left + 3, 20,
        r.right - r.left - 8, r.bottom - r.top - 24, True);
    end;

    procedure ActicatePage(n: integer);
    var
      Tabs: array [0..5] of string;
      Procs: array [0..5] of Pointer;
      Idx: Integer;
    begin
      ResetAutoCloseTimer;
      Procs[0] := @GeneralDialogProc;
      Procs[1] := @CallStackDialogProc;
      Procs[2] := @ModulesListDialogProc;
      Procs[3] := @ProcessesListDialogProc;
      Procs[4] := @AssemblerDialogProc;
      Procs[5] := @CPUDialogProc;
      Tabs[0] := ID_TabGeneral;
      Tabs[1] := ID_TabCallStack;
      Tabs[2] := ID_TabModulesList;
      Tabs[3] := ID_TabProcessesList;
      Tabs[4] := ID_TabAssembler;
      Tabs[5] := ID_TabCPU;
      if (n > 0) then
      begin
        Idx := n;
        if (Idx > 1) then // 0 = General Tab; 1 = CallStack Tab.
        begin
          if (not (loSaveModulesAndProcessesSections in CurrentOptions.LogOptions)) and
            (Idx in [2, 3]) then Inc(Idx, 2);
          if (not (loSaveAssemblerAndCPUSections in CurrentOptions.LogOptions)) and
            (Idx in [4, 5]) then Inc(Idx, 2);
        end;
      end
      else Idx := Abs(n);
      if (fActivePage <> 0) then DestroyWindow(fActivePage);
      fActivePage := CreateDialog(HInstance, PChar(Tabs[Idx]),
        GetDlgItem(Dialog, ID_PAGE), Procs[Idx]);
      AdjustDialog;
    end;

    procedure SetRectangles;
    begin
      // Set rExt
      GetWindowRect(Dialog, rExt);
      OffsetRect(rExt, -rExt.Left, -rExt.Top);

      // Set Border dimension...
      BordW := GetSystemMetrics(SM_CXFRAME) - 1;
      BordH := GetSystemMetrics(SM_CYFRAME) - 1;

      // Set rInt
      CopyRect(rInt, rExt);
      Inc(rInt.Left, BordW);
      Inc(rInt.Top, BordH);
      Dec(rInt.Right, BordW);
      Dec(rInt.Bottom, BordH);

      // Set rTit
      CopyRect(rTit, rExt);
      inc(rTit.Top, BordH + 1);
      inc(rTit.Left, BordW + 1);
      Dec(rTit.Right, BordW + 1);
      rTit.Bottom := rTit.Top + GetSystemMetrics(CAPTION_HEIGHT) - 1;

      // Set rTit2
      CopyRect(rTit2, rInt);
      rTit2.Bottom := rTit.Bottom + 1;
    end;

    procedure DrawSupportLink(hdl: HDC);
    begin
      if (CanSupport_Show) then
      begin
        SelectObject(hdl, fLinkFont);
        SetTextColor(hdl, RGB(0, 0, 128));
        if (SupportLinkActive) then SetCursor(LoadCursor(0, IDC_CURSOR));
        SetBkMode(hdl, TRANSPARENT);
        FillRect(hdl, rSupport, fDlgBack);
        DrawText(hdl, PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_SupportMessage]),
          Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_SupportMessage]), rSupport, 0);
      end;
    end;

  begin
    Result := False;
    case Msg of
      WM_COMMAND:
        begin
          ResetAutoCloseTimer;
          case WParam of
            ID_EMAIL:
              begin
                EnableWindow(GetDlgItem(Dialog, ID_SCREEN),
                  Boolean(SendMessage(GetDlgItem(Dialog, ID_EMAIL), BM_GETCHECK, 0, 0)));
              end;
            ID_BUTTON:
              begin
                DialogType := edtNone;
                EndDialog(Dialog, 0);
              end;
            ID_TERMINATE:
              begin
                DialogType := edtNone;
                TerminateApplication := True;
                EndDialog(Dialog, 0);
              end;
            ID_DETAILS:
              begin
                if DetailsActive then SaveState;
                DetailsActive := not DetailsActive;
                InvalidateRect(Dialog, nil, True);
                DetailsState(DetailsActive);
              end;
            ID_CUSTOM:
              begin
                Global_CloseDialog := False;
                SynchronizeEvent(@CallCustomButtonClickEvents);
                if (Global_CloseDialog) then
                begin
                  DialogType := edtNone;
                  EndDialog(Dialog, 0);
                end;
              end;
          end;
        end;
      WM_LBUTTONUP:
        begin
          if (SupportLinkActive) then
          begin
            UseTopMost := False;
            SetWindowPos(Dialog, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
            ShellExecute(0, 'open', PChar(CurrentOptions.SupportURL),
              nil, nil, SW_SHOWMAXIMIZED);
          end;
        end;
      WM_PAINT:
        begin
          IsDialogShowed := True;
          if (WParam <> 0) then hdl := WParam
          else hdl := BeginPaint(Dialog, PS);
          try
            DrawBmp(hdl, fMonitor, 8, 8, fMonitorInfo.bmWidth, fMonitorInfo.bmHeight);
            DrawSupportLink(hdl);
          finally
            if (WParam = 0) then EndPaint(Dialog, PS);
          end;
        end;
      WM_NCPAINT, WM_NCACTIVATE:
        begin
          if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
          begin
            hdl := GetWindowDC(Dialog);

            SetRectangles;

            if (msg = WM_NCACTIVATE) then fActive := (wparam <> 0);

            if fActive then
            begin
              BackColor := color_BackColorActive;
              BorderColor := color_BorderColorActive;
              BorderBack := color_BorderBackActive;
            end
            else
            begin
              BackColor := color_BackColorInactive;
              BorderColor := color_BorderColorInactive;
              BorderBack := color_BorderBackInactive;
            end;

            CopyRect(rCpt, rTit);

            for i := 1 to ((rCpt.Bottom - rCpt.Top) div 5) do
            begin
              Red := Round(GetRValue(BackColor) * 0.96);
              if Red > 255 then Red := 255;
              Green := Round(GetGValue(BackColor) * 0.96);
              if Green > 255 then Green := 255;
              Blue := Round(GetBValue(BackColor) * 0.96);
              if Blue > 255 then Blue := 255;
              BackColor := RGB(Red, Green, Blue);
              b := CreateSolidBrush(BackColor);
              FillRect(hdl, rCpt, b);
              Inc(rCpt.Top, 2);
              Dec(rCpt.Bottom, 2);
              DeleteObject(b);
            end;

            b := CreateSolidBrush(BorderColor);
            FrameRect(hdl, rExt, b);
            if DetailsActive then
            begin
              FrameRect(hdl, rTit2, b);
              FrameRect(hdl, rInt, b);
            end
            else
            begin
              Dec(rTit2.Bottom);
              FrameRect(hdl, rTit2, b);
              inc(rTit2.Bottom);
            end;
            DeleteObject(b);

            b := CreateSolidBrush(BorderBack);
            FillRect(hdl,
              Rect(rExt.Left + 1, rExt.Top + 1, rInt.Left, rExt.Bottom - 1), b);
            FillRect(hdl,
              Rect(rExt.Left + 1, rExt.Top + 1, rExt.Right - 1, rInt.Top), b);
            FillRect(hdl,
              Rect(rExt.Left + 1, rInt.Bottom, rExt.Right - 1, rExt.Bottom - 1), b);
            FillRect(hdl,
              Rect(rInt.Right, rExt.Top + 1, rExt.Right - 1, rExt.Bottom - 1), b);
            DeleteObject(b);

            SetBkMode(hdl, TRANSPARENT);
            SelectObject(hdl, fCaptionFont);

            GetTextExtentPoint32(Hdl,
              PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]),
              Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]), TextSize);

            if not DetailsActive then Dec(rTit.Top);

            if fActive then
            begin // Text caption shadow...
              SetTextColor(hdl, color_CaptionShadow);
              TextOut(hdl, rTit.Left + 5,
                rTit.Top + ((rTit.Bottom - rTit.Top) - TextSize.cy) div 2,
                PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]),
                length(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]));
              SetTextColor(hdl, color_CaptionActive)
            end
            else
              SetTextColor(hdl, color_CaptionInactive);

            TextOut(hdl, rTit.Left + 4,
              rTit.Top + ((rTit.Bottom - rTit.Top) - TextSize.cy) div 2,
              PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]),
              length(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]));

            ReleaseDC(Dialog, hdl);
            Result := True;
          end;
        end;
      WM_INITDIALOG:
        begin
          CurrentDialog := Dialog;
          SetWindowPos(Dialog, 0, 0, 0, 0, 0,
            SWP_NOSENDCHANGING or SWP_NOACTIVATE or SWP_NOREDRAW);
          UseTopMost := (edoShowInTopMostMode in CurrentOptions.ExceptionDialogOptions);
          if (not (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions)) then
          begin
            SetWindowLong(Dialog, GWL_EXSTYLE,
              (GetWindowLong(Dialog, GWL_EXSTYLE)) - WS_EX_TOOLWINDOW);
            CAPTION_HEIGHT := SM_CYCAPTION;
          end
          else CAPTION_HEIGHT := SM_CYSMCAPTION;
          if (UseTopMost) then
            SetWindowPos(Dialog, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);

          CanSendError_Show := ((CurrentOptions.EmailSendMode <> esmNoSend) or
            (CurrentOptions.WebSendMode <> wsmNoSend)) and (not DuplicatedException) and
            (edoShowSendErrorReportOption in CurrentOptions.ExceptionDialogOptions);
          CanAttachScreenshot_Show := (sndSendScreenshot in CurrentOptions.CommonSendOptions) and
            (CanSendError_Show) and
            (edoShowAttachScreenshotOption in CurrentOptions.ExceptionDialogOptions);
          CanCopy_Show := (edoShowCopyToClipOption in CurrentOptions.ExceptionDialogOptions);
          CanSupport_Show := (Trim(CurrentOptions.SupportURL) <> '');
          if (not CanSendError_Show) and (not CanAttachScreenshot_Show) and
            (not CanCopy_Show) and (not CanSupport_Show) then DialogHeight := 0
          else
            if ((CanSendError_Show) and (CanAttachScreenshot_Show)) or
              ((CanCopy_Show) and (CanSupport_Show)) then DialogHeight := 34
            else DialogHeight := 20;
          MainDialog := Dialog;
          SetForegroundWindow(Dialog);
          DetailsActive := (ShowInDetailsMode) or
            (edoShowInDetailedMode in CurrentOptions.ExceptionDialogOptions);

          fMonitor := LoadBitmap(HInstance, ID_Error);

          GetObject(fMonitor, SizeOf(fMonitorInfo), @fMonitorInfo);
          if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
            fDlgBack := CreateSolidBrush(color_DialogBack)
          else
            fDlgBack := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
          fMemoBack := CreateSolidBrush(color_Back);

          CreateDialogFonts(Dialog);

          ListWidth := 451;
          ListHeight := 131;
          TextWidth := 410;
          LeftButton := 191;
          TopButton := 192;
          OriginalWidth := 466;
          OriginalHeight := 252;

          SendMessage(GetDlgItem(Dialog, ID_TEXT), WM_SETFONT, fVariableFont, 1);

          SendMessage(GetDlgItem(Dialog, ID_BUTTON), WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_OKButtonCaption])));
          SendMessage(GetDlgItem(Dialog, ID_BUTTON), WM_SETFONT, fVariableFont, 1);

          if CurrentOptions.TerminateBtnOperation = tbTerminate then
            SendMessage(GetDlgItem(Dialog, ID_TERMINATE), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[
              mtDialog_TerminateButtonCaption])))
          else
            SendMessage(GetDlgItem(Dialog, ID_TERMINATE), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[
              mtDialog_RestartButtonCaption])));

          if (edoShowCustomButton in CurrentOptions.ExceptionDialogOptions) then
            SendMessage(GetDlgItem(Dialog, ID_CUSTOM), WM_SETTEXT, 0,
              Integer(PChar(CurrentOptions.CustomizedExpandedTexts[
              mtDialog_CustomButtonCaption])))
          else
            ShowWindow(GetDlgItem(Dialog, ID_CUSTOM), SW_HIDE);

          SendMessage(GetDlgItem(Dialog, ID_TERMINATE), WM_SETFONT, fVariableFont, 1);

          SendMessage(GetDlgItem(Dialog, ID_DETAILS), WM_SETFONT, fVariableFont, 1);

          SendMessage(GetDlgItem(Dialog, ID_CUSTOM), WM_SETFONT, fVariableFont, 1);

          SendMessage(GetDlgItem(Dialog, ID_EMAIL), BM_SETCHECK, Integer((CanSendMessage) and
            (edoSendErrorReportChecked in CurrentOptions.ExceptionDialogOptions)), 0);
          EnableWindow(GetDlgItem(Dialog, ID_SCREEN),
            Boolean(SendMessage(GetDlgItem(Dialog, ID_EMAIL), BM_GETCHECK, 0, 0)));

          if (not CanSendError_Show) then
          begin
            ShowWindow(GetDlgItem(Dialog, ID_EMAIL), SW_HIDE);
            ShowWindow(GetDlgItem(Dialog, ID_SCREEN), SW_HIDE);
          end;
          if (not CanAttachScreenshot_Show) then
          begin
            ShowWindow(GetDlgItem(Dialog, ID_SCREEN), SW_HIDE);
          end;
          SendMessage(GetDlgItem(Dialog, ID_SCREEN), BM_SETCHECK, Integer((CanAttachScreenshot) and
            (edoAttachScreenshotChecked in CurrentOptions.ExceptionDialogOptions)), 0);
          SendMessage(GetDlgItem(Dialog, ID_COPY), BM_SETCHECK, 0, 0);
          if (not CanCopy_Show) then
          begin
            ShowWindow(GetDlgItem(Dialog, ID_COPY), SW_HIDE);
          end;

          SendMessage(Dialog, WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption])));

          Tab.mask := TCIF_TEXT;
          Tab.iImage := -1;
          Tab.pszText := PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_GeneralCaption]);
          SendMessage(GetDlgItem(Dialog, ID_PAGE), TCM_INSERTITEM, 0, Longint(@Tab));
          SendMessage(GetDlgItem(Dialog, ID_PAGE), WM_SETFONT, fVariableFont, 1);

          Tab.pszText := PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_CallStackCaption]);
          SendMessage(GetDlgItem(Dialog, ID_PAGE), TCM_INSERTITEM, 1, Longint(@Tab));
          SendMessage(GetDlgItem(Dialog, ID_PAGE), WM_SETFONT, fVariableFont, 1);

          if (loSaveModulesAndProcessesSections in CurrentOptions.LogOptions) then
          begin
            Tab.pszText := PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_ModulesCaption]);
            SendMessage(GetDlgItem(Dialog, ID_PAGE), TCM_INSERTITEM, 2, Longint(@Tab));
            SendMessage(GetDlgItem(Dialog, ID_PAGE), WM_SETFONT, fVariableFont, 1);

            Tab.pszText := PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_ProcessesCaption]);
            SendMessage(GetDlgItem(Dialog, ID_PAGE), TCM_INSERTITEM, 3, Longint(@Tab));
            SendMessage(GetDlgItem(Dialog, ID_PAGE), WM_SETFONT, fVariableFont, 1);
          end;

          if (loSaveAssemblerAndCPUSections in CurrentOptions.LogOptions) then
          begin
            Tab.pszText := PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_AsmCaption]);
            SendMessage(GetDlgItem(Dialog, ID_PAGE), TCM_INSERTITEM, 4, Longint(@Tab));
            SendMessage(GetDlgItem(Dialog, ID_PAGE), WM_SETFONT, fVariableFont, 1);

            Tab.pszText := PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_CPUCaption]);
            SendMessage(GetDlgItem(Dialog, ID_PAGE), TCM_INSERTITEM, 5, Longint(@Tab));
            SendMessage(GetDlgItem(Dialog, ID_PAGE), WM_SETFONT, fVariableFont, 1);
          end;

          i := Integer(CurrentOptions.ForegroundTab);
          if (i > 1) then // 0 = General Tab; 1 = CallStack Tab.
          begin
            if ((not (loSaveModulesAndProcessesSections in CurrentOptions.LogOptions)) and (i in [2, 3])) or
            ((not (loSaveAssemblerAndCPUSections in CurrentOptions.LogOptions)) and (i in [4, 5])) then i := 0;
          end;

          SetFocus(GetDlgItem(Dialog, ID_BUTTON));
          ActicatePage(-i);
          SendMessage(GetDlgItem(Dialog, ID_PAGE), TCM_SETCURSEL, i, 0);
          DetailsState(DetailsActive);
          SetTimer(Dialog, 1, 1, nil);
          SetAutoCloseTimer(Dialog);
          SetAutoTopMost(Dialog);
        end;
      WM_DESTROY:
        begin
          KillTimer(Dialog, 1);
          UnsetAutoCloseTimer(Dialog);
          UnsetAutoTopMost(Dialog);
          CanSendMessage :=
            Boolean(SendMessage(GetDlgItem(Dialog, ID_EMAIL), BM_GETCHECK, 0, 0));
          CanAttachScreenshot :=
            Boolean(SendMessage(GetDlgItem(Dialog, ID_SCREEN), BM_GETCHECK, 0, 0));
          CanCopy :=
            Boolean(SendMessage(GetDlgItem(Dialog, ID_COPY), BM_GETCHECK, 0, 0));
          DestroyDialogFonts;
          DeleteObject(fDlgBack);
          DeleteObject(fMemoBack);
          DeleteObject(fMonitor);
          if fActivePage <> 0 then
            DestroyWindow(fActivePage);
          if DetailsActive then SaveState;
        end;
      WM_KEYDOWN, WM_MOUSEWHEEL, WM_LBUTTONDBLCLK, WM_RBUTTONDBLCLK,
        WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN,
        WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
        WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
      WM_TIMER:
        begin
          KillTimer(Dialog, 1);
          if (not IsDialogShowed) then
          begin
            DialogType := edtNone;
            EndDialog(Dialog, 0);
          end;
        end;
      WM_NOTIFY:
        begin
          ResetAutoCloseTimer;
          if PNMHdr(LParam)^.code = TCN_SELCHANGE then
          begin
            ActicatePage(
              SendMessage(PNMHdr(LParam)^.hwndFrom, TCM_GETCURSEL, 0, 0));
          end;
        end;
      WM_MOUSEMOVE:
        begin
          Pt.X := LoWord(LParam);
          Pt.Y := HiWord(LParam);
          SupportLinkActive := (PtInRect(rSupport, Pt));
          if (SupportLinkActive) then
            InvalidateRect(Dialog, @rSupport, True);
        end;
      WM_SIZE:
        begin
          if (CurrentDialog = 0) then Exit;
          New(P);
          P^ := Rect(0, 0, LoWord(LParam), HiWord(LParam));
          fW := LoWord(LParam) - OriginalWidth;
          fH := HiWord(LParam) - OriginalHeight;
          SetWindowPos(GetDlgItem(Dialog, ID_PAGE), 0, 4, 52,
            (ListWidth + fW) + 7, (ListHeight + fH) + 31 - DialogHeight,
            SWP_NOZORDER + SWP_NOACTIVATE + SWP_NOREDRAW);
          Region := CreateRectRgnIndirect(P^);
          InternalRegion := CreateRectRgn(6, 80, (ListWidth + fW) + 5,
            (ListHeight + fH) + 31 - DialogHeight + 38);
          try
            CombineRgn(Region, Region, InternalRegion, RGN_DIFF);
            InvalidateRgn(Dialog, Region, False);
          finally
            DeleteObject(Region);
            DeleteObject(InternalRegion);
          end;
          if DetailsActive then
          begin
            SetWindowPos(GetDlgItem(Dialog, ID_TEXT), 0, 48, 8,
              (TextWidth + fW), 42, SWP_NOZORDER + SWP_NOACTIVATE);
            InvalidateRect(GetDlgItem(Dialog, ID_TEXT), P, False);
          end;

          ButtonWidth := 75;

          DC := GetDC(0);
          SelectObject(DC, fVariableFont);
          GetTextExtentPoint32(DC, PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_OKButtonCaption] + 'O'),
            Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_OKButtonCaption]) + 1, TextSize);
          if (TextSize.cx > ButtonWidth) then ButtonWidth := TextSize.cx;
          GetTextExtentPoint32(DC, PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_TerminateButtonCaption] + 'O'),
            Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_TerminateButtonCaption]) + 1, TextSize);
          if (TextSize.cx > ButtonWidth) then ButtonWidth := TextSize.cx;
          GetTextExtentPoint32(DC, PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_RestartButtonCaption] + 'O'),
            Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_RestartButtonCaption]) + 1, TextSize);
          if (TextSize.cx > ButtonWidth) then ButtonWidth := TextSize.cx;
          GetTextExtentPoint32(DC, PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_DetailsButtonCaption] + 'O'),
            Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_DetailsButtonCaption]) + 1, TextSize);
          GetTextExtentPoint32(DC, PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_CustomButtonCaption] + 'O'),
            Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_CustomButtonCaption]) + 1, TextSize);
          if (TextSize.cx > ButtonWidth) then ButtonWidth := TextSize.cx;
          ReleaseDC(0, DC);

          fW := (LoWord(LParam) - ButtonWidth) div 2;
          fH := (HiWord(LParam) - 32) - DialogHeight;
          if (CurrentOptions.TerminateBtnOperation <> tbNone) and
            (ExceptionNumber > CurrentOptions.ErrorsNumberToShowTerminateBtn) then
            TerminateVisibleState := SWP_SHOWWINDOW
          else
            TerminateVisibleState := SWP_HIDEWINDOW;
          SetWindowPos(GetDlgItem(Dialog, ID_TERMINATE), 0, 5,
            fH, ButtonWidth, 25,
            SWP_NOZORDER + SWP_NOACTIVATE + TerminateVisibleState);
          InvalidateRect(GetDlgItem(Dialog, ID_TERMINATE), P, False);
          if (TerminateVisibleState = SWP_SHOWWINDOW) then HelpX := (ButtonWidth + 13)
          else HelpX := 5;
          if ((edoShowCustomButton in CurrentOptions.ExceptionDialogOptions) and
            (fW <= (HelpX + ButtonWidth))) then fW := (HelpX + ButtonWidth + 8);
          SetWindowPos(GetDlgItem(Dialog, ID_CUSTOM), 0, HelpX,
            fH, ButtonWidth, 25,
            SWP_NOZORDER + SWP_NOACTIVATE);
          InvalidateRect(GetDlgItem(Dialog, ID_CUSTOM), P, False);
          SetWindowPos(GetDlgItem(Dialog, ID_BUTTON), 0, fW, fH,
            ButtonWidth, 25, SWP_NOZORDER + SWP_NOACTIVATE);
          InvalidateRect(GetDlgItem(Dialog, ID_BUTTON), P, False);

          fW := (LoWord(LParam));

          ShowWindow(GetDlgItem(Dialog, ID_LINE), SW_HIDE);

          SetWindowPos(GetDlgItem(Dialog, ID_EMAIL), 0, 4, fH + 34,
            (fW - 8) div 2, 16, SWP_NOZORDER + SWP_NOACTIVATE);
          InvalidateRect(GetDlgItem(Dialog, ID_EMAIL), P, False);
          SendMessage(GetDlgItem(Dialog, ID_EMAIL), WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_SendMessage])));
          SendMessage(GetDlgItem(Dialog, ID_EMAIL), WM_SETFONT, fVariableFont, 1);

          SetWindowPos(GetDlgItem(Dialog, ID_COPY), 0, fW - (fW - 8) div 2 - 4,
            fH + 34, (fW - 8) div 2, 16, SWP_NOZORDER + SWP_NOACTIVATE);
          InvalidateRect(GetDlgItem(Dialog, ID_COPY), P, False);
          SendMessage(GetDlgItem(Dialog, ID_COPY), WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_CopyMessage])));
          SendMessage(GetDlgItem(Dialog, ID_COPY), WM_SETFONT, fVariableFont, 1);

          // Calcolate rSupport coordinates...
          DC := GetDC(0);
          try
            SelectObject(DC, fLinkFont);
            GetTextExtentPoint32(DC, PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_SupportMessage]),
              Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_SupportMessage]), TextSize);
          finally
            ReleaseDC(0, DC);
          end;
          rSupport.Left := (fW - (fW - 8) div 2 - 4 + (((fW - 8) div 2) - (TextSize.cx)));
          rSupport.Top := (fH + 34 + (16 * Integer(CanCopy_Show)));
          rSupport.Right := (rSupport.Left + TextSize.cx);
          rSupport.Bottom := (rSupport.Top + 13);
          SupportLinkActive := False;

          SetWindowPos(GetDlgItem(Dialog, ID_SCREEN), 0, 23, fH + 50,
            (fW div 2), 16, SWP_NOZORDER + SWP_NOACTIVATE);
          InvalidateRect(GetDlgItem(Dialog, ID_SCREEN), P, False);
          SendMessage(GetDlgItem(Dialog, ID_SCREEN), WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_ScreenshotMessage])));
          SendMessage(GetDlgItem(Dialog, ID_SCREEN), WM_SETFONT, fVariableFont, 1);

          GetWindowRect(GetDlgItem(Dialog, ID_PAGE), rInt);
          OffsetRect(rInt, -rInt.Left, -rInt.Top);

          if ((edoShowDetailsButton in CurrentOptions.ExceptionDialogOptions) and
           (not ShowInDetailsMode)) then
          begin
            SetWindowPos(GetDlgItem(Dialog, ID_DETAILS), 0, LoWord(LParam) -
              ButtonWidth - 5, fH, ButtonWidth, 25,
              SWP_NOZORDER + SWP_NOACTIVATE + SWP_SHOWWINDOW);
            InvalidateRect(GetDlgItem(Dialog, ID_DETAILS), P, False);
          end
          else ShowWindow(GetDlgItem(Dialog, ID_DETAILS), SW_HIDE);

          if WParam = SIZE_MAXIMIZED then WindowState := SW_MAXIMIZE
          else
            if WParam = SIZE_MINIMIZED then WindowState := SW_MINIMIZE
            else
              if (DetailsActive) then
              begin
                WindowState := SW_SHOWNORMAL;
                GetWindowRect(Dialog, P^);
                RealWidth := ABS(P^.Right - P^.Left);
                RealHeight := ABS(P^.Bottom - P^.Top);
              end;
          Dispose(P);
          AdjustDialog;
        end;
      WM_MOVE:
        begin
          if (GetDialogState <> SW_MAXIMIZE) and (DetailsActive) then
          begin
            New(P);
            GetWindowRect(Dialog, P^);
            RealLeft := P^.Left;
            RealTop := P^.Top;
            Dispose(P);
          end;
        end;
      WM_CTLCOLORDLG:
        begin
          if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
            Result := longbool(fDlgBack);
        end;
      WM_CTLCOLORSTATIC:
        begin
          if (edoUseEurekaLogLookAndFeel in CurrentOptions.ExceptionDialogOptions) then
          begin
            SetBkMode(WParam, TRANSPARENT);
            SetTextColor(WParam, color_Text);
            result := longbool(fDlgBack);
          end;
        end;
    end;
  end;

  function NewMSDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
    LParam: Integer): Longbool; stdcall;
  var
    PT: TPoint;
    DC: HDC;
    PS: TPaintStruct;
    Top, BottonHeight, BottonWidth, MemoHeight,
      TextHeight, TextWidth, NoSendLeft: Integer;
    TerminateStr: string;

  procedure DrawControl(Left: Integer; var Top: Integer; Font: THandle;
    Width, ControlID: Integer; const Text: string; IncrementTop: Boolean);
  var
    Height: Integer;
  begin
    Height := GetTextHeight(Dialog, Font, Text, Width);
    SendMessage(GetDlgItem(Dialog, ControlID), WM_SETTEXT, 0, Integer(PChar(Text)));
    SetWindowPos(GetDlgItem(Dialog, ControlID), 0, Left, Top, Width, Height, SWP_NOZORDER);
    if (IncrementTop) then Inc(Top, Height);
  end;

  procedure DrawClickHere(DC: HDC);
  begin
    if (not (edoShowDetailsButton in CurrentOptions.ExceptionDialogOptions)) then Exit;

    SelectObject(DC, fLinkFont2);
    SetTextColor(DC, RGB(0, 0, 255));
    if (ClickLinkActive) then SetCursor(LoadCursor(0, IDC_CURSOR));
    SetBkMode(DC, TRANSPARENT);
    FillRect(DC, rClick, fDlgBack);

    DrawText(DC,
      PChar(CurrentOptions.CustomizedExpandedTexts[mtMSDialog_SeeClickCaption]),
      Length(CurrentOptions.CustomizedExpandedTexts[mtMSDialog_SeeClickCaption]),
      rClick, 0);
  end;

  function GetBottonWidth(const Text: string): Integer;
  begin
    Result := (GetTextWidth(Dialog, fVariableFont, QuickStringReplace(Text, '&', '')) +
      16 + GetSystemMetrics(SM_CYBORDER) * 4);
    if (Result < 75) then Result := 75;
  end;

  procedure DrawButton(ButtonID, Left, Top, Height: Integer; const Text: string);
  begin
    SetWindowPos(GetDlgItem(Dialog, ButtonID), 0, Left, Top,
      GetBottonWidth(Text), Height, SWP_NOZORDER);
    SendMessage(GetDlgItem(Dialog, ButtonID), WM_SETTEXT, 0, Integer(PChar(Text)));
  end;

  function GetEditText(EditID: integer): string;
  var
    Len: integer;
  begin
    Len := (SendMessage(GetDlgItem(Dialog, EditID), WM_GETTEXTLENGTH, 0, 0) + 1);
    SetLength(Result, Len);
    SendMessage(GetDlgItem(Dialog, EditID), WM_GETTEXT, Len, DWord(@Result[1]));
    Delete(Result, Length(Result), 1);
  end;

  procedure AssignRequestData;
  var
    Len: Integer;
  begin
    Len := SendMessage(GetDlgItem(Dialog, ID_MS_ReproduceMemo),
      WM_GETTEXTLENGTH, 0, 0) + 1;
    SetLength(CurrentRequestValue, Len);
    SendMessage(GetDlgItem(Dialog, ID_MS_ReproduceMemo),
      WM_GETTEXT, Len, DWord(@CurrentRequestValue[1]));
    Delete(CurrentRequestValue, Length(CurrentRequestValue), 1);
    CurrentRequestValue := Trim(CurrentRequestValue);

    AddCustomHeaderToLog(
      7, CurrentOptions.CustomizedExpandedTexts[mtReproduceDialog_Caption],
      CurrentRequestValue);
  end;

  function IsValidEmail(const Addr: string): Boolean;
  begin
    Result := ((Pos('@', Addr) > 0) and (Pos('.', Addr) > 0));
  end;

  procedure AssignOnCloseData;

    procedure ChangeLogUserEmail(var Log:string; const NewEmail: string);
    var
      StartIdx, EndIdx, Idx: Integer;
    begin
      Idx := Pos(#13#10'  3.3 ', Log);
      if (Idx > 0) then
      begin
        Idx := PosEx(': ', Log, Idx);
        if (Idx > 0) then
        begin
          StartIdx := (Idx + 2);
          EndIdx := PosEx(#13#10, Log, StartIdx);
          if (EndIdx >= StartIdx) then
          begin
            Delete(Log, StartIdx, (EndIdx - StartIdx));
            Insert(NewEmail, Log, StartIdx);
          end;
        end;
      end;
    end;

  begin
    UserEmail := Trim(GetEditText(ID_MS_EmailEdit));
    if (IsValidEmail(UserEmail)) then
    begin
      CurrentOptions.SMTPFrom := UserEmail;
      ChangeLogUserEmail(CurrentGeneralErrorText, UserEmail);
      ChangeLogUserEmail(LastExceptionLog, UserEmail);
      ChangeLogUserEmail(Global_ExceptionRecord.LogText, UserEmail);
      LastLog := LastExceptionLog;
      WriteString(EurekaIni, 'User', 'Email', UserEmail);
    end
    else
      if (UserEmail <> '' ) then
      begin
        MessageBox(MsgBoxhWnd,
          PChar(CurrentOptions.CustomizedExpandedTexts[mtInvalidEmailMsg]),
          PChar(CurrentOptions.CustomizedExpandedTexts[mtErrorMsgCaption]),
          MB_OK or MB_ICONERROR or MessageBoxFlags);
        Exit;
      end;

    CurrentRequestValue := Trim(GetEditText(ID_MS_ReproduceMemo));

    AddCustomHeaderToLog(
      7, CurrentOptions.CustomizedExpandedTexts[mtReproduceDialog_Caption],
      CurrentRequestValue);

    TerminateApplication := (TerminateApplication) or
      (Boolean(SendMessage(GetDlgItem(Dialog, ID_MS_Restart), BM_GETCHECK, 0, 0)));
    AssignRequestData;
    EndDialog(Dialog, 0);
  end;

  begin
    Result := False;
    case Msg of
      WM_INITDIALOG:
        begin
          SetInitDialog(Dialog, False);
          CreateDialogFonts(Dialog);
          fMonitor := LoadBitmap(HInstance, ID_Error);
          SendMessage(GetDlgItem(Dialog, ID_MS_Label), WM_SETFONT, fBigFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_Please), WM_SETFONT, fBigFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_Error), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_Restart), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_Created), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_SeeReport), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_ReproduceLabel), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_ReproduceMemo), WM_SETFONT, fFixedFont1, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_EmailLabel), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_EmailEdit), WM_SETFONT, fVariableFont, 1);

          SendMessage(GetDlgItem(Dialog, ID_MS_EmailEdit), WM_SETTEXT, 0,
            Integer(PChar(ReadString(EurekaIni, 'User', 'Email', ''))));

          SendMessage(GetDlgItem(Dialog, ID_MS_SendBtn), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_NoSendBtn), WM_SETFONT, fVariableFont, 1);
          SendMessage(GetDlgItem(Dialog, ID_MS_CustomBtn), WM_SETFONT, fVariableFont, 1);
          SendMessage(Dialog, WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption])));
          CanSendError_Show := ((CurrentOptions.EmailSendMode <> esmNoSend) or
            (CurrentOptions.WebSendMode <> wsmNoSend)) and (not DuplicatedException) and
            (edoShowSendErrorReportOption in CurrentOptions.ExceptionDialogOptions);
          if (not CanSendError_Show) then
          begin
            ShowWindow(GetDlgItem(Dialog, ID_MS_SendBtn), SW_HIDE);
            EnableWindow(GetDlgItem(Dialog, ID_MS_SendBtn), False);
            SendMessage(GetDlgItem(Dialog, ID_MS_SendBtn), BM_SETSTYLE, $50010000, 1);
            SendMessage(GetDlgItem(Dialog, ID_MS_NoSendBtn), BM_SETSTYLE, $50010001, 1);
            SetFocus(GetDlgItem(Dialog, ID_MS_NoSendBtn));
          end;
          TextHeight :=
            GetTextHeight(Dialog, fBigFont,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_ErrorMsgCaption], 356);
            Top := (51 - TextHeight) div 2;
          DrawControl(8, Top, fBigFont, 356, ID_MS_Label,
            CurrentOptions.CustomizedExpandedTexts[mtMSDialog_ErrorMsgCaption], False);
          Top := 59;
          DrawControl(8, Top, fVariableFont, 397, ID_MS_Error, GetExceptMessage, True);
          if (CurrentOptions.TerminateBtnOperation <> tbNone) and
            (ExceptionNumber > CurrentOptions.ErrorsNumberToShowTerminateBtn) then
          begin
            Inc(Top, 10);
            if (CurrentOptions.TerminateBtnOperation = tbTerminate) then
              TerminateStr := CurrentOptions.CustomizedExpandedTexts[mtMSDialog_TerminateCaption]
            else
              TerminateStr := CurrentOptions.CustomizedExpandedTexts[mtMSDialog_RestartCaption];
            DrawControl(8, Top, fVariableFont, 397, ID_MS_Restart, TerminateStr, True);
          end
          else ShowWindow(GetDlgItem(Dialog, ID_MS_Restart), SW_HIDE);
          if (CanSendError_Show) then
          begin
            Inc(Top, 10);
            DrawControl(8, Top, fBigFont, 397, ID_MS_Please,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_PleaseCaption], True);
            Inc(Top, 2);
            DrawControl(8, Top, fVariableFont, 397, ID_MS_Created,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_DescriptionCaption], True);
          end
          else
          begin
            ShowWindow(GetDlgItem(Dialog, ID_MS_Please), SW_HIDE);
            ShowWindow(GetDlgItem(Dialog, ID_MS_Created), SW_HIDE);
          end;
          if (edoShowDetailsButton in CurrentOptions.ExceptionDialogOptions) then
          begin
            Inc(Top, 12);
            TextWidth := GetTextWidth(Dialog, fVariableFont,
              Trim(CurrentOptions.CustomizedExpandedTexts[mtMSDialog_SeeDetailsCaption]) + ' ');
            rClick.Left := (8 + TextWidth);
            rClick.Top := Top;
            DrawControl(8, Top, fVariableFont, TextWidth, ID_MS_SeeReport,
              Trim(CurrentOptions.CustomizedExpandedTexts[mtMSDialog_SeeDetailsCaption]) + ' ',
              True);
            TextWidth := GetTextWidth(Dialog, fLinkFont2,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_SeeClickCaption]);
            TextHeight := GetTextHeight(Dialog, fLinkFont2,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_SeeClickCaption], 356);
            rClick.Right := (rClick.Left + TextWidth);
            rClick.Bottom := (rClick.Top + TextHeight);
          end
          else ShowWindow(GetDlgItem(Dialog, ID_MS_SeeReport), SW_HIDE);
          TextHeight := GetTextHeight(Dialog, fVariableFont, 'O', 356);
          if (loAppendReproduceText in CurrentOptions.LogOptions) then
          begin
            Inc(Top, 12);
            DrawControl(8, Top, fVariableFont, 397, ID_MS_ReproduceLabel,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_HowToReproduceCaption], True);
            Inc(Top, 2);
            TextHeight := GetTextHeight(Dialog, fFixedFont1, 'O', 356);
            MemoHeight := (TextHeight * 4 + GetSystemMetrics(SM_CYBORDER) * 8);
            SetWindowPos(GetDlgItem(Dialog, ID_MS_ReproduceMemo), 0, 8,
              Top, 397, MemoHeight, SWP_NOZORDER);
            Inc(Top, MemoHeight - 4);
          end
          else
          begin
            ShowWindow(GetDlgItem(Dialog, ID_MS_ReproduceLabel), SW_HIDE);
            ShowWindow(GetDlgItem(Dialog, ID_MS_ReproduceMemo), SW_HIDE);
          end;
          if (CanSendError_Show) then
          begin
            Inc(Top, 12);
            TextWidth := GetTextWidth(Dialog, fVariableFont,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_EmailCaption] + ' ');
            TextHeight := GetTextHeight(Dialog, fVariableFont, 'O', 356);
            MemoHeight := (TextHeight + GetSystemMetrics(SM_CYBORDER) * 8);
            SetWindowPos(GetDlgItem(Dialog, ID_MS_EmailEdit), 0, (8 + TextWidth),
              Top, (397 - TextWidth), MemoHeight, SWP_NOZORDER);
            Inc (Top, (MemoHeight - TextHeight) div 2);
            DrawControl(8, Top, fVariableFont, TextWidth, ID_MS_EmailLabel,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_EmailCaption] + ' ', True);
          end
          else
          begin
            ShowWindow(GetDlgItem(Dialog, ID_MS_EmailLabel), SW_HIDE);
            ShowWindow(GetDlgItem(Dialog, ID_MS_EmailEdit), SW_HIDE);
          end;
          Inc(Top, 12);
          BottonHeight := (TextHeight + 6 + GetSystemMetrics(SM_CYBORDER) * 4);
          DrawButton(ID_MS_CustomBtn, 8, Top, BottonHeight,
            CurrentOptions.CustomizedExpandedTexts[mtDialog_CustomButtonCaption]);
          if (not (edoShowCustomButton in CurrentOptions.ExceptionDialogOptions)) then
            ShowWindow(GetDlgItem(Dialog, ID_MS_CustomBtn), SW_HIDE);
          BottonWidth := GetBottonWidth(
            CurrentOptions.CustomizedExpandedTexts[mtMSDialog_NoSendButtonCaption]);
          NoSendLeft := (405 - BottonWidth);
          if (not CanSendMessage) or (not CanSendError_Show) then
            DrawButton(ID_MS_NoSendBtn, NoSendLeft, Top, BottonHeight,
              CurrentOptions.CustomizedExpandedTexts[mtDialog_OKButtonCaption])
          else
            DrawButton(ID_MS_NoSendBtn, NoSendLeft, Top, BottonHeight,
              CurrentOptions.CustomizedExpandedTexts[mtMSDialog_NoSendButtonCaption]);
          BottonWidth := GetBottonWidth(
            CurrentOptions.CustomizedExpandedTexts[mtMSDialog_SendButtonCaption]);
          DrawButton(ID_MS_SendBtn, (NoSendLeft - 8 - BottonWidth), Top, BottonHeight,
            CurrentOptions.CustomizedExpandedTexts[mtMSDialog_SendButtonCaption]);
          Inc(Top, (BottonHeight + 10 + GetSystemMetrics(SM_CYFRAME) +
            GetSystemMetrics(SM_CYCAPTION)));
          CenterOnActiveWndMonitor(Dialog, 419, Top);
          fDlgBack := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
          ClickLinkActive := False;
          SetTimer(Dialog, 1, 1, nil);
          SetAutoCloseTimer(Dialog);
          SetAutoTopMost(Dialog);
        end;
      WM_MOUSEWHEEL, WM_NOTIFY, WM_LBUTTONDBLCLK,
        WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK, WM_LBUTTONDOWN, WM_RBUTTONDOWN,
        WM_MBUTTONDOWN, WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK,
        WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN: ResetAutoCloseTimer;
      WM_DESTROY:
        begin
          UnsetAutoCloseTimer(Dialog);
          UnsetAutoTopMost(Dialog);
          DestroyDialogFonts;
          DeleteObject(fMonitor);
          DeleteObject(fDlgBack);
        end;
      WM_MOUSEMOVE:
        begin
          Pt.X := LoWord(LParam);
          Pt.Y := HiWord(LParam);
          ClickLinkActive := (PtInRect(rClick, Pt));
          if (ClickLinkActive) then
            InvalidateRect(Dialog, @rClick, True);
        end;
      WM_LBUTTONUP:
        begin
          if (ClickLinkActive) then
          begin
            DialogType := edtEurekaLog;
            AssignOnCloseData;
          end;
        end;
      WM_TIMER:
        begin
          KillTimer(Dialog, 1);
          if (not IsDialogShowed) then
          begin
            DialogType := edtNone;
            AssignOnCloseData;
          end;
        end;
      WM_CLOSE:
      begin
        DialogType := edtNone;
        AssignOnCloseData;
      end;
      WM_COMMAND:
        begin
          ResetAutoCloseTimer;
          case WParam of
            2: // ESC Key...
              begin
                SendMessage(Dialog, WM_CLOSE, 0, 0);
              end;
            ID_MS_SendBtn:
              begin
                CanSendMessage := True;
                DialogType := edtNone;

                AssignOnCloseData;
              end;
            ID_MS_NoSendBtn:
              begin
                CanSendMessage := (CanSendMessage) and (not CanSendError_Show);
                DialogType := edtNone;

                AssignOnCloseData;
              end;
            ID_MS_CustomBtn:
              begin
                Global_CloseDialog := False;
                SynchronizeEvent(@CallCustomButtonClickEvents);
                if (Global_CloseDialog) then
                begin
                  DialogType := edtNone;
                  AssignOnCloseData;
                end;
              end;
          end;
        end;
      WM_PAINT:
        begin
          IsDialogShowed := True;
          if (WParam <> 0) then DC := WParam
          else DC := BeginPaint(Dialog, PS);
          try
            FillRect(DC, Rect(0, 0, 413, 51), GetStockObject(WHITE_BRUSH));
            FrameRect(DC, Rect(0, 0, 413, 51), GetStockObject(BLACK_BRUSH));
            DrawBmp(DC, fMonitor, 372, 9, 32, 32);
            DrawClickHere(DC);
          finally
            if (WParam = 0) then EndPaint(Dialog, PS);
          end;
        end;
      WM_CTLCOLORSTATIC:
        begin
          if (THandle(LParam) = GetDlgItem(Dialog, ID_MS_Label)) then
          begin
            SetBkMode(WParam, TRANSPARENT);
            Result := LongBool(GetStockObject(WHITE_BRUSH));
          end;
        end;
    end;
  end;

  procedure CallExceptionActionNotify_atTerminating;
  begin
    CallModuleEvent_ExceptionActionNotify(
      LastExceptionRecord^, atTerminating, TerminateApplication);
    CallExceptionActionNotify(
      LastExceptionRecord^, atTerminating, TerminateApplication);
  end;

begin // ShowDialog
  RichLib := LoadLibrary('RICHED32.DLL');
  try
    OldForegroundWnd := GetForegroundWindow;
    CurrentDialog := 0;
    if ((PlaySound) and (DialogType <> edtMessageBox)) then MessageBeep(MB_ICONERROR);
    repeat
      CanExit := True;
      IsDialogShowed := False;
      if (DialogType = edtEurekaLog) then
        DialogBoxParam(hInstance, DialogName, 0, @NewDialogProc, 0)
      else
        if (DialogType = edtMSCLassic) then
          DialogBoxParam(hInstance, DialogMSName, 0, @NewMSDialogProc, 0)
        else
          if (DialogType = edtMessageBox) then
          begin
            IsDialogShowed := True;
            MessageBox(MsgBoxhWnd, PChar(GetExceptMessage),
              PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]),
              MB_ICONERROR or MB_OK or MessageBoxFlags);
            DialogType := edtNone;
          end
          else IsDialogShowed := True;

      if (not IsDialogShowed) and (Win32Platform = VER_PLATFORM_WIN32_NT) then
        MessageBox(MsgBoxhWnd, PChar(GetExceptMessage),
          PChar(CurrentOptions.CustomizedExpandedTexts[mtDialog_Caption]),
          MB_ICONERROR or MB_OK or MessageBoxFlags);

      if (TerminateApplication) then
      begin
        ClearInternalError;
        SynchronizeEvent(@CallExceptionActionNotify_atTerminating);
        CanExit := TerminateApplication;
      end;
      if (not IsDialogShowed) then
        SetInternalError(eeShowError, 'Cannot show the DialogBox window.');
    until CanExit;
  finally
    IsDialogShowed := False;
    FreeLibrary(RichLib);
  end;
  SetForegroundWindow(OldForegroundWnd);
end;

//------------------------------------------------------------------------------

{$IFDEF PROFESSIONAL}

procedure ShowSendDialogThread(Modal: Boolean);

  function NewDialogProc(Dialog: HWnd; Msg: DWord; WParam: DWord;
    LParam: Integer): Longbool; stdcall;
  var
    PS: TPaintStruct;
    DC: HDC;
    rInt, rTit: TRect;
    Left, Top: Integer;

  procedure CalsCoordinates(var Left, Top: Integer);
  var
    rExt, rDesk: TRect;
  begin
    // Set rExt
    GetWindowRect(Dialog, rExt);
    OffsetRect(rExt, -rExt.Left, -rExt.Top);

    rDesk := GetMonitorWorkAreaFromActiveWnd;

    Left := (rDesk.Right - rExt.Right);
    Top := (rDesk.Bottom - rExt.Bottom);
  end;

  procedure SetRectangles(Dialog: THandle);
  var
    rExt: TRect;
    BordW, BordH: Integer;
  begin
    // Set rExt
    GetWindowRect(Dialog, rExt);
    OffsetRect(rExt, -rExt.Left, -rExt.Top);

    // Set Border dimension...
    BordW := GetSystemMetrics(SM_CXFRAME) - 1;
    BordH := GetSystemMetrics(SM_CYFRAME) - 1;

    // Set rInt
    CopyRect(rInt, rExt);
    Inc(rInt.Left, BordW);
    Inc(rInt.Top, BordH);
    Dec(rInt.Right, BordW);
    Dec(rInt.Bottom, BordH);

    // Set rTit
    CopyRect(rTit, rExt);
    inc(rTit.Top, BordH + 1);
    inc(rTit.Left, BordW + 1);
    Dec(rTit.Right, BordW + 1);
    rTit.Bottom := rTit.Top + GetSystemMetrics(CAPTION_HEIGHT) - 1;
  end;

  begin
    Result := False;
    case Msg of
      WM_INITDIALOG:
        begin
          SetInitDialog(Dialog, not Boolean(LParam));
          CreateDialogFonts(Dialog);
          GlobalSendValues.Dialog := Dialog;
          SendMessage(Dialog, WM_SETTEXT, 0,
            Integer(PChar(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Caption])));
          SendMessage(GetDlgItem(Dialog, ID_ServerLabel), WM_SETFONT, fVariableFont, 1);
          fSendBmp := LoadBitmap(HInstance, ID_Send);
          if (Boolean(LParam)) then SetAutoTopMost(Dialog)
          else
          begin
            CalsCoordinates(Left, Top);
            SetWindowPos(Dialog, 0, Left, Top, 0, 0, SWP_NOSIZE);
          end;
        end;
      WM_DESTROY:
        begin
          if (Boolean(LParam)) then UnsetAutoTopMost(Dialog);
          DestroyDialogFonts;
          DeleteObject(fSendBmp);
        end;
      WM_SETFOCUS:
        begin
          GlobalSendValues.Showed := True;
        end;
      WM_PAINT:
      begin
        IsDialogShowed := True;
        SetRectangles(Dialog);
        if (WParam <> 0) then DC := WParam
        else DC := BeginPaint(Dialog, PS);
        try
          DrawBmp(DC, fSendBmp, 8, 8, 32, 32);
        finally
          if (WParam = 0) then EndPaint(Dialog, PS);
        end;
      end;
      MY_CLOSE:
        begin
          EndDialog(Dialog, 0);
        end;
      WM_NCPAINT, WM_NCACTIVATE:
        Result := DlgTemplate(Msg, WParam, LParam, Dialog,
          CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Caption]);
    end;
  end;

begin
  IsDialogShowed := False;
  try
    if (CannotUseThread) then
      CreateDialogParam(hInstance, ServerDialogName, 0, @NewDialogProc, Integer(Modal))
    else
      DialogBoxParam(hInstance, ServerDialogName, 0, @NewDialogProc, Integer(Modal));
  finally
    IsDialogShowed := False;
  end;
end;

procedure ShowSendDialog(Modal: Boolean);
begin
  FillChar(GlobalSendValues, SizeOf(GlobalSendValues), #0);

  if (not (sndShowSendDialog in CurrentOptions.CommonSendOptions)) or
    ((CurrentOptions.EmailSendMode = esmNoSend) and
    (CurrentOptions.WebSendMode = wsmNoSend)) or (not IsGUI) then
  begin
    IsDialogShowed := True;
    Exit;
  end;

  with GlobalSendValues do
  begin
    if (CannotUseThread) then ShowSendDialogThread(Modal)
    else
    begin
      SendDialogThread :=
        TSendDialogThread.Create(Modal);
      SendDialogThread.FreeOnTerminate := True;
      SendDialogThread.Priority := tpHighest;
      SendDialogThread.Resume;
    end;
    repeat
      Sleep(50);
    until (Showed);
  end;
end;

// -----------------------------------------------------------------------------
// PNG support...
// -----------------------------------------------------------------------------

const
  BUFFER_SIZE = $0003FFFF; // 256 Kb.

function BytesSwap(A: DWord): DWord;
type
  TSwapRec = packed record
    A1, A2, A3, A4: Byte;
  end;
var
  B: TSwapRec;
begin
  B := TSwapRec(A);
  TSwapRec(A).A1 := B.A4;
  TSwapRec(A).A2 := B.A3;
  TSwapRec(A).A3 := B.A2;
  TSwapRec(A).A4 := B.A1;
  Result := A;
end;

function CalcCRC(CRC: DWord; Buffer: PByteArray; Len: Integer): DWord;
var
  c1, c2: DWord;
  n, k: Integer;
begin
  c1 := CRC;
  if (not PNG_CRCListed) then
  begin
    for n := 0 to 255 do
    begin
      c2 := DWord(n);
      for k := 0 to 7 do
      begin
        if (c2 and 1 <> 0) then
          c2 := ($EDB88320 xor (c2 shr 1))
        else
          c2 := (c2 shr 1);
      end;
      PNG_CRCList[n] := c2;
    end;
    PNG_CRCListed := True;
  end;
  for n := 0 to len - 1 do
    c1 := (PNG_CRCList[(c1 xor buffer^[n]) and $FF] xor (c1 shr 8));
  Result := c1;
end;

function InitDeflate(Stream: TStream; Level: Byte; Size: DWord): TZStreamRec2;
begin
  Fillchar(Result, SizeOf(Result), #0);
  GetMem(Result.Data, Size);
  Result.fStream := Stream;
  Result.ZLIB.next_out := Result.Data;
  Result.ZLIB.avail_out := Size;
  deflateInit_(Result.zlib, Level, zlib_version, SizeOf(TZStreamRec));
end;

procedure Encode(Stream: TStream; var ZLIBStream: TZStreamRec2);
var
  n: DWord;
  CharData: PChar;
  Filter: Byte;

  procedure WriteIDAT(Data: Pointer; Length: DWord);
  const
    IDATHeader: array[0..3] of char = ('I', 'D', 'A', 'T');
  var
    Len, CRC: DWord;
  begin
    Len := BytesSwap(Length);
    Stream.Write(Len, 4);
    Stream.Write('IDAT', 4);
    Stream.Write(Data^, Length);
    CRC := CalcCRC($FFFFFFFF, @IDATHeader[0], 4);
    CRC := BytesSwap(CalcCRC(CRC, Data, Length) xor $FFFFFFFF);
    Stream.Write(CRC, 4);
  end;

  procedure IDATWrite(Buffer: Pointer; Length: DWord);
  begin
    ZLIBStream.ZLIB.next_in := Buffer;
    ZLIBStream.ZLIB.avail_in := Length;
    while (ZLIBStream.ZLIB.avail_in > 0) do
    begin
      deflate(ZLIBStream.ZLIB, Z_NO_FLUSH);
      if (ZLIBStream.ZLIB.avail_out = 0) then
      begin
        WriteIDAT(ZLIBStream.Data, BUFFER_SIZE);
        ZLIBStream.ZLIB.next_out := ZLIBStream.Data;
        ZLIBStream.ZLIB.avail_out := BUFFER_SIZE;
      end;
    end;
  end;

begin
  DWord(CharData) := DWord(PNG_ImgData) + PNG_RowBytes * (PNG_HeaderData.Height - 1);
  for n := 0 to PNG_HeaderData.Height - 1 do
  begin
    CopyMemory(@PNG_Encode_Data^[0], CharData, PNG_HeaderData.Width);
    CopyMemory(@PNG_Encode_Filter^[0], @PNG_Encode_Data^[0], PNG_HeaderData.Width);
    Filter := 0;
    IDATWrite(@Filter, 1);
    IDATWrite(@PNG_Encode_Filter^[0], PNG_HeaderData.Width);
    Dec(CharData, PNG_RowBytes);
  end;
  // Flush the data...
  while (deflate(ZLIBStream.ZLIB, Z_FINISH) <> Z_STREAM_END) do
  begin
    WriteIDAT(CharData, BUFFER_SIZE - ZLIBStream.ZLIB.avail_out);
    ZLIBStream.ZLIB.next_out := CharData;
    ZLIBStream.ZLIB.avail_out := BUFFER_SIZE;
  end;
  if (ZLIBStream.ZLIB.avail_out < BUFFER_SIZE) then
    WriteIDAT(ZLIBStream.Data, BUFFER_SIZE - ZLIBStream.ZLIB.avail_out);
end;

function Create8bitBitmap(BmpSrc: THandle): THandle;
type
  TRGBQuadArray = array[0..255] of TRGBQuad;
var
  DIB: TDIBSection;
  RGBQuadArray: TRGBQuadArray;
  HBitmap, HCanvas, HSourceCanvas: THandle;
  BI: TBitmapInfo;
  BitsMem: Pointer;

  procedure GetOptimizedPalette(const Handle: THandle; var RGBQuadArray: TRGBQuadArray);
  type
    pRGBArray = ^TRGBArray;
    TRGBArray = array[0..0] of TRGBTriple;

    POctreeNode = ^ TOctreeNode;
    TReducibleNodes = array[0..7] of POctreeNode;

    TOctreeNode = record
      IsLeaf: Boolean;
      PixelCount: Integer;
      RedSum: Integer;
      GreenSum: Integer;
      BlueSum: Integer;
      Next: POctreeNode;
      Child: TReducibleNodes;
    end;
  var
    DIB: TDIBSection;
    Index: Integer;
    FTree: POctreeNode;
    FLeafCount: Integer;
    FReducibleNodes: TReducibleNodes;

    procedure DeleteTree(var Node: POctreeNode);
    var
      i: Integer;
    begin
      for i := Low(TReducibleNodes) to High(TReducibleNodes) do
        if (Node.Child[i] <> nil) then DeleteTree(Node.Child[i]);
      Dispose(Node);
      Node := nil;
    end;

    procedure GetPaletteColors(const Node: POctreeNode;
      var RGBQuadArray: TRGBQuadArray; var Index: Integer);
    var
      i: Integer;
    begin
      if (Node.IsLeaf) then
      begin
        with RGBQuadArray[Index] do
        begin
          try
            rgbRed := Byte(Node.RedSum div Node.PixelCount);
            rgbGreen := Byte(Node.GreenSum div Node.PixelCount);
            rgbBlue := Byte(Node.BlueSum div Node.PixelCount);
          except
            rgbRed := 0;
            rgbGreen := 0;
            rgbBlue := 0
          end;
          rgbReserved := 0
        end;
        Inc(Index);
      end
      else
      begin
        for i := Low(Node.Child) to High(Node.Child) do
        begin
          if (Node.Child[i] <> nil) then
            GetPaletteColors(Node.Child[i], RGBQuadArray, Index);
        end
      end
    end;

    procedure AddColor(var Node: POctreeNode; const r, g, b: Byte;
      const Level: Integer; var LeafCount: Integer;
      var ReducibleNodes: TReducibleNodes);
    const
      Mask: array[0..7] of Byte = ($80, $40, $20, $10, $08, $04, $02, $01);
    var
      Index, Shift: Integer;

      function CreateOctreeNode(const Level: Integer; var LeafCount: Integer;
        var ReducibleNodes: TReducibleNodes): POctreeNode;
      var
        i: Integer;
      begin
        New(Result);
        Result^.PixelCount := 0;
        Result^.RedSum := 0;
        Result^.GreenSum := 0;
        Result^.BlueSum := 0;
        for i := Low(TReducibleNodes) to High(TReducibleNodes) do Result^.Child[i] := nil;
        Result^.IsLeaf := (Level = 8);
        if (Result^.IsLeaf) then
        begin
          Result^.Next := nil;
          Inc(LeafCount);
        end
        else
        begin
          Result^.Next := ReducibleNodes[Level];
          ReducibleNodes[Level] := Result;
        end
      end;

    begin
      // If the node doesn't exist, create it.
      if (Node = nil) then
        Node := CreateOctreeNode(Level, LeafCount, ReducibleNodes);

      if (Node.IsLeaf) then
      begin
        Inc(Node.PixelCount);
        Inc(Node.RedSum, r);
        Inc(Node.GreenSum, g);
        Inc(Node.BlueSum, b)
      end
      else
      begin
        // Recurse a level deeper if the node is not a leaf.
        Shift := (7 - Level);
        Index := (((r and mask[Level]) shr Shift) shl 2) or
          (((g and mask[Level]) shr Shift) shl 1) or
          ((b and mask[Level]) shr Shift);
        AddColor(Node.Child[Index], r, g, b, (Level + 1),
          LeafCount, ReducibleNodes);
      end;
    end;

    procedure ReduceTree(var LeafCount: Integer; var ReducibleNodes: TReducibleNodes);
    var
      i, RedSum, BlueSum, Children, GreenSum: Integer;
      Node: POctreeNode;
    begin
      // Find the deepest level containing at least one reducible node
      i := 7;
      while (i > 0) and (ReducibleNodes[i] = nil) do Dec(i);

      // Reduce the node most recently added to the list at level i.
      Node := ReducibleNodes[i];
      ReducibleNodes[i] := Node.Next;

      RedSum := 0;
      GreenSum := 0;
      BlueSum := 0;
      Children := 0;

      for i := Low(ReducibleNodes) to High(ReducibleNodes) do
      begin
        if (Node.Child[i] <> nil) then
        begin
          Inc(RedSum, Node.Child[i].RedSum);
          Inc(GreenSum, Node.Child[i].GreenSum);
          Inc(BlueSum, Node.Child[i].BlueSum);
          Inc(Node.PixelCount, Node.Child[i].PixelCount);
          DeleteTree(Node.Child[i]);
          Node.Child[i] := nil;
          Inc(Children)
        end
      end;

      Node.IsLeaf := True;
      Node.RedSum := RedSum;
      Node.GreenSum := GreenSum;
      Node.BlueSum := BlueSum;
      Dec(LeafCount, Children - 1)
    end;

    procedure ProcessImage;
    var
      BitmapInfo: TBitmapInfo;
      DeviceContext: hDC;
      i, j, Row, WidthBytes: Integer;
      ScanLine: pRGBArray;

      function BytesPerScanline(PixelsPerScanline: Longint): Longint;
      var
        Alignment, BitsPerPixel: Longint;
      begin
        Alignment := 32;
        BitsPerPixel := 24;
        Dec(Alignment);
        Result := ((PixelsPerScanline * BitsPerPixel) + Alignment) and not Alignment;
        Result := Result div 8;
      end;

    begin
      WidthBytes := BytesPerScanline(DIB.dsBm.bmWidth);
      GetMem(ScanLine, WidthBytes);
      try
        ZeroMemory(@BitmapInfo, SizeOf(BitmapInfo));
        with BitmapInfo do
        begin
          bmiHeader.biSize := SizeOf(TBitmapInfo);
          bmiHeader.biWidth := DIB.dsBm.bmWidth;
          bmiHeader.biHeight := DIB.dsBm.bmHeight;
          bmiHeader.biPlanes := 1;
          bmiHeader.biBitCount := 24;
          bmiHeader.biCompression := BI_RGB;
        end;

        DeviceContext := GetDC(0);
        try
          for j := 0 to (DIB.dsBm.bmHeight - 1) do
          begin
            if (DIB.dsBm.bmHeight > 0) then Row := (DIB.dsBm.bmHeight - j - 1)
            else Row := j;
            GetDIBits(DeviceContext, Handle, Row, 1, ScanLine, BitmapInfo, DIB_RGB_COLORS);
            for i := 0 to (DIB.dsBm.bmWidth - 1) do
            begin
              with Scanline[i] do
                AddColor(FTree, rgbtRed, rgbtGreen, rgbtBlue, 0, FLeafCount, FReducibleNodes);
              while (FLeafCount > 256) do ReduceTree(FLeafCount, FReducibleNodes);
            end;
          end;
        finally
          ReleaseDC(0, DeviceContext);
        end;
      finally
        FreeMem(ScanLine);
      end;
    end;
  begin
    FTree := nil;
    FLeafCount := 0;
    FillChar(FReducibleNodes, SizeOf(FReducibleNodes), #0);

    GetObject(Handle, SizeOF(DIB), @DIB);
    ProcessImage;
    Index := 0;
    GetPaletteColors(FTree, RGBQuadArray, Index);

    if (FTree <> nil) then DeleteTree(FTree);
  end;

begin
  GetObject(BmpSrc, SizeOF(DIB), @DIB);
  HCanvas := CreateCompatibleDC(0);
  try
    FillChar(BI, SizeOf(BI), #0);
    with BI.bmiHeader do
    begin
      biSize := SizeOf(BI.bmiHeader);
      biWidth := DIB.dsBm.bmWidth;
      biHeight := DIB.dsBm.bmHeight;
      biPlanes := 1;
      biBitCount := 8;
    end;
    HBitmap := CreateDIBSection(HCanvas, BI, DIB_RGB_COLORS, BitsMem, 0, 0);
    SelectObject(HCanvas, HBitmap);
    GetOptimizedPalette(BmpSrc, RGBQuadArray);
    SetDIBColorTable(HCanvas, 0, 256, RGBQuadArray);
    HSourceCanvas := CreateCompatibleDC(0);
    try
      SelectObject(HSourceCanvas, BmpSrc);
      BitBlt(HCanvas, 0, 0, DIB.dsBm.bmWidth, DIB.dsBm.bmHeight,
        HSourceCanvas, 0, 0, SRCCOPY);
    finally
      DeleteDC(HSourceCanvas);
    end;
  finally
    DeleteDC(HCanvas);
  end;
  Result := HBitmap;
end;

// Capture the screen into a simple bitmap (FAST).

procedure InitScreenshot;
var
  SourcePt, StartPt, Pt: TPoint;
  pPal: PLogPalette;
  Rect: TRect;
  Brush: HBrush;
  OldObj: THandle;
  IconInfo: TIconInfo;
  Options: TEurekaModuleOptions;
begin
  if (LastExceptionRecord = nil) then Options := CurrentEurekaLogOptions
  else Options := CurrentOptions;

  if (sndUseOnlyActiveWindow in Options.CommonSendOptions) then
  begin
    PNG_HWindow := GetForegroundWindow;
    GetWindowRect(PNG_HWindow, Rect);
    SourcePt.X := 0;
    SourcePt.Y := 0;
  end
  else
  begin
    PNG_HWindow := GetDesktopWindow;
    Rect := GetApplicationRect(GetCurrentProcessId);
    if ((Rect.Left = -1) and (Rect.Top = -1) and
      (Rect.Right = -1) and (Rect.Bottom = -1)) or
      (not GetActiveMonitorData(Rect)) then GetWindowRect(PNG_HWindow, Rect);
    SourcePt.X := Rect.Left;
    SourcePt.Y := Rect.Top;
  end;
  PNG_DCScreen := GetWindowDC(PNG_HWindow);
  PNG_DCCompatible := CreateCompatibleDC(PNG_DCScreen);
  StartPt.X := Rect.Left;
  StartPt.Y := Rect.Top;
  PNG_Width := (Rect.Right - Rect.Left);
  PNG_Height := (Rect.Bottom - Rect.Top);
  if (PNG_Width = 0) then PNG_Width := 1;
  if (PNG_Height = 0) then PNG_Height := 1;
  PNG_RowBytes := (((PNG_Width * 8)+ 31) and not 31) div 8;
  PNG_Bitmap := CreateCompatibleBitmap(PNG_DCScreen, PNG_RowBytes, PNG_Height);
  OldObj := SelectObject(PNG_DCCompatible, PNG_Bitmap);
  try
    PNG_UsePal := False;
    PNG_pal := 0;
    if (GetDeviceCaps(PNG_DCScreen, RASTERCAPS) and RC_PALETTE <> 0) then
    begin
      GetMem(pPal, sizeof(TLOGPALETTE) + (255 * sizeof(TPALETTEENTRY)));
      FillChar(pPal^, sizeof(TLOGPALETTE) + (255 * sizeof(TPALETTEENTRY)), #0);
      pPal^.palVersion := $300;
      pPal^.palNumEntries :=
        GetSystemPaletteEntries(PNG_DCScreen, 0, 256, pPal^.palPalEntry);
      if (pPal^.PalNumEntries <> 0) then
      begin
        PNG_pal := CreatePalette(pPal^);
        SelectPalette(PNG_DCCompatible, PNG_Pal, False);
        PNG_UsePal := True;
      end
      else
        FreeMem(pPal, SizeOf(TLOGPALETTE) + (255 * SizeOf(TPALETTEENTRY)));
    end;

    BitBlt(PNG_DCCompatible, 0, 0, PNG_Width, PNG_Height, PNG_DCScreen,
      SourcePt.X, SourcePt.Y, SRCCOPY);
    if GetWindowRect(PNG_FocusWnd, Rect) then
    begin
      OffsetRect(Rect, -StartPt.X, -StartPt.Y);
      Brush := CreateSolidBrush($0000FF);
      try
        FrameRect(PNG_DCCompatible, Rect, Brush);
        Inc(Rect.Left);
        Inc(Rect.Top);
        Dec(Rect.Right);
        Dec(Rect.Bottom);
        FrameRect(PNG_DCCompatible, Rect, Brush);
      finally
        DeleteObject(Brush);
      end;
    end;
    GetCursorPos(Pt);
    Dec(Pt.X, StartPt.X);
    Dec(Pt.Y, StartPt.Y);
    GetIconInfo(PNG_Cursor, IconInfo);
    try
      Dec(Pt.X, IconInfo.xHotspot);
      Dec(Pt.Y, IconInfo.yHotspot);
    finally
      DeleteObject(IconInfo.hbmMask);
      DeleteObject(IconInfo.hbmColor);
    end;
    DrawIconEx(PNG_DCCompatible, Pt.X, Pt.Y, PNG_Cursor, 32, 32, 0, 0, DI_NORMAL);
  finally
    SelectObject(PNG_DCCompatible, OldObj);
  end;
end;

// Convert the bitmap into a PNG image (SLOW).
procedure AfterScreenshotToStream(Stream: TStream);//const Filename: string);
type
  T8BitPalette = array[0..255] of TRGBQuad;
  P8BitBitmap = ^T8BitBitmap;
  T8BitBitmap = packed record
    FileHead: TBitmapFileHeader;
    InfoHead: TBitmapInfoHeader;
    Pal: T8BitPalette;
  end;
var
  n: DWord;
  OldBmp: THandle;
  DataPtr: PByte;
  ZLIBStream: TZStreamRec2;
  Bmp: T8BitBitmap;

  procedure CommonSaveToStream(const Name: string);
  var
    Size, CRC: DWord;
    CharName: array[0..3] of Char;
  begin
    CopyMemory(@CharName[0], @Name[1], 4);
    Size := BytesSwap(PNG_DataSize);
    Stream.Write(Size, 4);
    Stream.Write(CharName, 4);
    if (PNG_DataSize > 0) then Stream.Write(PNG_Data^, PNG_DataSize);
    CRC := CalcCRC($FFFFFFFF, @CharName[0], 4);
    CRC := BytesSwap(CalcCRC(CRC, PNG_Data, PNG_DataSize) xor $FFFFFFFF);
    Stream.Write(CRC, 4);
  end;

begin
  OldBmp := PNG_Bitmap;
  PNG_Bitmap := Create8bitBitmap(PNG_Bitmap);
  if (PNG_Bitmap <> 0) then DeleteObject(OldBmp)
  else PNG_Bitmap := OldBmp;
  SelectObject(PNG_DCCompatible, PNG_Bitmap);

  FillChar(Bmp, SizeOf(Bmp), #0);

  // TBitmapInfoHeader
  with Bmp.InfoHead do
  begin
    biSize := SizeOf(TBitmapInfoHeader);
    biWidth := PNG_RowBytes;
    biHeight := PNG_Height;
    biPlanes := 1; // Must set to 1.
    biBitCount := 8; // 256 colours.
    biCompression := BI_RGB;
    biSizeImage := (PNG_RowBytes * PNG_Height);
  end;

  // Bitmap data and palette
  DWord(PNG_ImgData) := GlobalAlloc(GMEM_FIXED, (PNG_RowBytes * PNG_Height));
  try
    GetDIBits(PNG_DCCompatible, PNG_Bitmap, 0, PNG_Height, PNG_ImgData,
      PBitmapInfo(@Bmp.InfoHead)^, DIB_RGB_COLORS);
    GetMem(PNG_Data, 769);
    try
      PNG_HeaderData.Width := PNG_Width;
      PNG_HeaderData.Height := PNG_Height;
      PNG_HeaderData.BitDepth := 8;
      PNG_HeaderData.ColorType := 3;
      PNG_ColoursCount := 256;
      Stream.Write(#137#80#78#71#13#10#26#10, 8);
      // Write IHDR data...
      PNG_DataSize := 13;
      PHeaderData(PNG_Data)^ := PNG_HeaderData;
      with PHeaderData(PNG_Data)^ do
      begin
        Width := BytesSwap(Width);
        Height := BytesSwap(Height);
        InterlaceMethod := 0;
      end;
      CommonSaveToStream('IHDR');
      // Write PLTE data...
      PNG_DataSize := (PNG_ColoursCount * 3);
      DataPtr := PNG_Data;
      for n := 0 to PNG_ColoursCount - 1 do
      begin
        DataPtr^ := Bmp.Pal[n].rgbRed;
        inc(DataPtr);
        DataPtr^ := Bmp.Pal[n].rgbGreen;
        inc(DataPtr);
        DataPtr^ := Bmp.Pal[n].rgbBlue;
        inc(DataPtr);
      end;
      CommonSaveToStream('PLTE');
      // Write IDAT data...
      GetMem(PNG_Encode_Data, PNG_RowBytes);
      ZeroMemory(PNG_Encode_Data, PNG_RowBytes);
      GetMem(PNG_Encode_Filter, PNG_RowBytes);
      ZeroMemory(PNG_Encode_Filter, PNG_RowBytes);
      ZLIBStream := InitDeflate(Stream, 9, BUFFER_SIZE);
      Encode(Stream, ZLIBStream);
      DeflateEnd(ZLIBStream.ZLIB);
      PNG_DataSize := 0;
      CommonSaveToStream('IEND');
      FreeMem(ZLIBStream.Data, BUFFER_SIZE);
      FreeMem(PNG_Encode_Data, PNG_RowBytes);
      FreeMem(PNG_Encode_Filter, PNG_RowBytes);
    finally
      FreeMem(PNG_Data, 769);
    end;
  finally
    GlobalFree(DWord(PNG_ImgData));
  end;
end;

procedure AfterScreenshot(const Filename: string);
var
  FileStream: TMemoryStream;
begin
  if (FileName = '') then Exit;

  FileStream := TMemoryStream.Create;
  try
    AfterScreenshotToStream(FileStream);
    try
      FileStream.SaveToFile(Filename);
    except
      Exit;
    end;
  finally
    FileStream.Free;
  end;
end;

procedure FreeScreenshot;
begin
  if (PNG_UsePal) then DeleteObject(PNG_pal);
  DeleteObject(PNG_Bitmap);
  DeleteDC(PNG_DCCompatible);
  ReleaseDC(PNG_HWindow, PNG_DCScreen);
end;

procedure SaveScreenshot(const Filename: string);
begin
  InitScreenshot;
  AfterScreenshot(Filename);
  FreeScreenshot;
end;

procedure SaveScreenshotToStream(Stream: TStream);
begin
  InitScreenshot;
  AfterScreenshotToStream(Stream);
  FreeScreenshot;
end;
// -----------------------------------------------------------------------------

function InternalSendMail(AMailTo, ASubject, ABody: string;
  AAttachments: array of string; ACustomAttachments: TStrings): Boolean;
type
  TRecips = array[0..1023] of TMapiRecipDesc;
  PRecips = ^TRecips;
  TRecipRec = packed record
    Name, Address: array[0..256] of Char;
  end;
  TRecNames = array[0..1023] of TRecipRec;
  PRecNames = ^TRecNames;
var
  Attach: array[0..31] of TMapiFileDesc; // Max 32 attachments.
  Recips: PRecips;
  RecNames: PRecNames;
  MapiMessage: TMapiMessage;
  Res, Flags: DWord;
  FClientLibHandle: THandle;
  hSession: Cardinal;
  ClientKey: string;
  FClientDLL: string;
  FileName: string;
  FMapiLogOn: TFNMapiLogOn;
  FMapiLogOff: TFNMapiLogOff;
  FMapiSendMail: TFNMapiSendMail;
  Addresses: TStringList;
  AttachCount: DWord;
  ShortAttachs, LongAttachs: TStringList;
  i: integer;
  AttachmentsList: TStringList;
  ParentWnd: THandle;
  Options: TEurekaModuleOptions;  

  procedure Error(const Msg: string);
  begin
    SetInternalError(eeEmailMAPIError, Msg);
  end;

begin
  Result := False;

  if (LastExceptionRecord = nil) then Options := CurrentEurekaLogOptions
  else Options := CurrentOptions;

  ASubject := ExpandEnvVar(ASubject);
  ABody := ExpandEnvVar(ABody);
  Addresses := TStringList.Create;
  try
    ExtractList(AMailTo, Addresses, [',', ';']);
    // Read the MAPI data...
    ClientKey := 'SOFTWARE\Clients\Mail\' +
      ReadKey(HKEY_CURRENT_USER, 'SOFTWARE\Clients\Mail', '');
    FClientDLL := ReadKey(HKEY_CURRENT_USER, ClientKey, 'DLLPath');
    if (FClientDLL = '') then
    begin
      ClientKey := 'SOFTWARE\Clients\Mail\' +
        ReadKey(HKEY_LOCAL_MACHINE, 'SOFTWARE\Clients\Mail', '');
      FClientDLL := ReadKey(HKEY_LOCAL_MACHINE, ClientKey, 'DLLPath');
    end;
    FClientDLL := ExpandEnvVar(FClientDLL);

    // Load MAPI client library...
    FClientLibHandle := LoadLibrary(PChar(FClientDLL));
    // If not found the Direct access try with MAPI...
    if (FClientLibHandle = 0) then
      FClientLibHandle := LoadLibrary('mapi32.dll');
    if (FClientLibHandle <> 0) then
    begin
      @FMapiLogOn := GetProcAddress(FClientLibHandle, 'MAPILogon');
      @FMapiLogOff := GetProcAddress(FClientLibHandle, 'MAPILogoff');
      @FMapiSendMail := GetProcAddress(FClientLibHandle, 'MAPISendMail');
      if (@FMapiLogOn <> nil) and (@FMapiLogOff <> nil) and
        (@FMapiSendMail <> nil) then
      begin
        if (GetCurrentThreadId = MainThreadID) then
          ParentWnd := GetMainWindow(GetCurrentProcessId)
        else
          ParentWnd := 0;
          
        // LogOn...
        Result := (FMapiLogon(ParentWnd, nil, nil, 1 (*MAPI_LOGON_UI*), 0, @hSession) = 0);
        if (Result) then
        begin
          ShortAttachs := TStringList.Create;
          LongAttachs := TStringList.Create;
          try
            // Attachments...
            AttachCount := 0;
            AttachmentsList := TStringList.Create;
            try
              for i := 0 to High(AAttachments) do
                AttachmentsList.Add(AAttachments[i]);
              if (ACustomAttachments <> nil) then
              begin
                for i := 0 to (ACustomAttachments.Count - 1) do
                  AttachmentsList.Add(ACustomAttachments[i]);
              end;
              for i := 0 to (AttachmentsList.Count - 1) do
                if (AttachmentsList[i] <> '') and (FileExists(AttachmentsList[i])) then
                begin
                  FileName := GetRealFileName(AttachmentsList[i]);
                  ShortAttachs.Add(FileName);
                  LongAttachs.Add(ExpandFileName(AttachmentsList[i]));
                  FillChar(Attach[AttachCount], SizeOf(TMapiFileDesc), #0);
                  Attach[AttachCount].nPosition := Cardinal($FFFFFFFF);
                  Attach[AttachCount].lpszFileName := PChar(ShortAttachs[AttachCount]);
                  Attach[AttachCount].lpszPathName := PChar(LongAttachs[AttachCount]);
                  Inc(AttachCount);
                end;
            finally
              AttachmentsList.Free;
            end;
            // Recipient...
            GetMem(Recips, SizeOf(TMapiRecipDesc) * Addresses.Count);
            GetMem(RecNames, SizeOf(TRecipRec) * Addresses.Count);
            try
              FillChar(Recips^, SizeOf(TMapiRecipDesc) * Addresses.Count, #0);
              for i := 0 to (Addresses.Count - 1) do
              begin
                with Recips^[i] do
                begin
                  ulRecipClass := 1; // MAIL_TO
                  lpszName := StrCopy(RecNames^[i].Name, PChar(Addresses[i]));
                  lpszAddress := StrCopy(RecNames^[i].Address, PChar('SMTP:' + Addresses[i]));
                end;
              end;
              // Fill MapiMessage structure...
              FillChar(MapiMessage, SizeOf(MapiMessage), #0);
              MapiMessage.lpszSubject := PChar(OneString(ASubject));
              MapiMessage.lpszNoteText := PChar(ABody);
              MapiMessage.lpRecips := PMapiRecipDesc(Recips);
              MapiMessage.nRecipCount := Addresses.Count;
              if (AttachCount > 0) then
                MapiMessage.lpFiles := PMapiFileDesc(@Attach[0])
              else
                MapiMessage.lpFiles := nil;
              MapiMessage.nFileCount := AttachCount;

              Flags := 1; // MAPI_LOGON_UI
              if (sndShowSendDialog in Options.CommonSendOptions) then
                Flags := (Flags or 8); // MAPI_DIALOG
              Res := FMapiSendMail(hSession, ParentWnd, MapiMessage, Flags, 0);
              Result := ((Res = 0) or (Res = 1)); // SUCCESS_SUCCESS or MAPI_USER_ABORT
              if (not Result) then Error('Cannot send the MAPI message.');
            finally
              FreeMem(RecNames, SizeOf(TRecipRec) * Addresses.Count);
              FreeMem(Recips, SizeOf(TMapiRecipDesc) * Addresses.Count);
            end;
          finally
            ShortAttachs.Free;
            LongAttachs.Free;
            // LogOff...
            FMapiLogoff(hSession, ParentWnd, 0, 0);
            // UnLoad the library...
            FreeLibrary(FClientLibHandle);
          end;
        end
        else
          Error('Cannot LogOn into the MAPI service.');
      end
      else
        Error('Cannot found the MAPI functions.');
    end
    else
      Error('Cannot open the MAPI dll.');
  finally
    Addresses.Free;
  end;
end;

function EurekaLogSendEmail(const AMailTo, ASubject, ABody, AAttachments: string): Boolean;
var
  AttachmentsList: TStringList;
begin
  AttachmentsList := TStringList.Create;
  try
    ExtractList(AAttachments, AttachmentsList, [',', ';']);
    Result := InternalSendMail(AMailTo, ASubject, ABody, [''], AttachmentsList);
  finally
    AttachmentsList.Free;
  end;
end;

function Base64EncodeFromFile(const FileName: string): string;
const
  LineSize = 80;
var
  Buff: TMemoryStream;
  Coded: string;
  n, NewSize, CRNum, Other: Integer;
  PCoded, PResult: PChar;
begin
  if (Trim(FileName) = '') or (not FileExists(FileName)) then
  begin
    Result := '';
    Exit;
  end;
  Buff := TMemoryStream.Create;
  try
    Buff.LoadFromFile(FileName);
    Coded := Base64EncodeToString(Buff.Memory, Buff.Size);
    CRNum := (Length(Coded) div LineSize);
    Other := (Length(Coded) mod LineSize);
    NewSize := (Length(Coded) + CRNum * 2);
    SetLength(Result, NewSize);
    PCoded := PChar(Coded);
    PResult := PChar(Result);
    FillChar(PResult^, NewSize, #0);
    for n := 1 to CRNum do
    begin
      Move(PCoded^, PResult^, LineSize);
      Inc(PResult, LineSize);
      Move(#13#10, PResult^, 2);
      Inc(PResult, 2);
      Inc(PCoded, LineSize);
    end;
    if (Other > 0) then Move(PCoded^, PResult^, Other);
  finally
    Buff.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure ProcessDialogMessages;
var
  Msg: TMsg;
begin
  if (CannotUseThread) then
  begin
    try
      while (PeekMessage(Msg, 0, 0, 0, PM_REMOVE)) do
      begin
        if (Msg.message <> WM_QUIT) then
        begin
          TranslateMessage(Msg);
          DispatchMessage(Msg);
        end;
      end;
    except
      // ...
    end;
  end;
end;

procedure SetSendDialogLabel(Value: string);
begin
  if (GlobalSendValues.Dialog <> 0) then
  begin
    ProcessDialogMessages;
    Value := Format('%s %d/%d: ',
      [CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Message],
      GlobalSendValues.MsgNum, GlobalSendValues.MsgTot]) + Value;
    SendMessage(GetDlgItem(GlobalSendValues.Dialog, ID_ServerLabel),
      WM_SETTEXT, 0, Integer(PChar(Value)));
    ProcessDialogMessages;
  end;
end;

procedure SetSendDialogSingleLabel(const Value: string);
begin
  if (GlobalSendValues.Dialog <> 0) then
  begin
    ProcessDialogMessages;
    SendMessage(GetDlgItem(GlobalSendValues.Dialog, ID_ServerLabel),
      WM_SETTEXT, 0, Integer(PChar(Value)));
    ProcessDialogMessages;
  end;
end;

procedure SetSendDialogBar(Value: Integer);
begin
  if (GlobalSendValues.Dialog <> 0) then
  begin
    ProcessDialogMessages;
    SendMessage(GetDlgItem(GlobalSendValues.Dialog, ID_ServerBar), PBM_SETPOS, Value, 0);
    ProcessDialogMessages;
  end;
end;

procedure CloseSendDialog;
begin
  if (GlobalSendValues.Dialog <> 0) then
  begin
    ProcessDialogMessages;
    SendMessage(GlobalSendValues.Dialog, MY_CLOSE, 0, 0);
    ProcessDialogMessages;
  end;
end;

{TSendObject}

class procedure TSendObject.OnSent(Sender: TObject; BytesSent, TotalBytes: Integer);
begin
  SetSendDialogBar((BytesSent * 100) div TotalBytes);
end;

//------------------------------------------------------------------------------

function SMTPSendSingleEmail(AsServer: Boolean; AFrom, AHost: string; APort: Word;
  AUserID, APassword, AMailTo, ASubject, ABody: string;
  AAttachments: array of string; ACustomAttachments: TStrings): Boolean;
const
  Boundary = '=_xcjvnxkbhvfkxzhfdbvzldjhfv';
var
  ClientSMTP: TEurekaClientSMTP;
  CommandText, DataText, FromStr, MailFrom, ToStr, ContentType: string;
  Idx: Integer;

  function HostName: string;
  begin
    SetLength(Result, 250);
    GetHostName(PChar(Result), Length(Result));
    Result := string(PChar(Result));
  end;

  function LoggedUserName: string;
  begin
    Result := UserFullName;
    if (Result = '') then Result := UserName;
  end;

  procedure SetCounting;
  begin
    if (GlobalSendValues.Dialog <> 0) then
      ClientSMTP.OnSent := TSendObject.OnSent;
  end;

  procedure ResetCounting;
  begin
    if ((GlobalSendValues.Dialog <> 0) and (CannotUseThread)) then
      DestroyWindow(GlobalSendValues.Dialog);
    ClientSMTP.OnSent := nil;
  end;

  function AttachedFile(const FileName: string): string;
  var
    AttachType, RealFile: string;
  begin
    if (Trim(FileName) = '') or (not FileExists(FileName)) then
    begin
      Result := '';
      Exit;
    end;

    RealFile := GetRealFileName(FileName);
    if (UpperCase(ExtractFileExt(FileName)) = '.PNG') then AttachType := 'image/png'
    else AttachType := 'application/octet-stream';

    Result := #13#10 +
      '--' + Boundary + #13#10 +
      'Content-Type: ' + AttachType + ';' + #13#10 +
      '        name="' + RealFile + '"' + #13#10 +
      'Content-Transfer-Encoding: base64' + #13#10 +
      'Content-Disposition: attachment;' + #13#10 +
      '        filename="' + RealFile + '"' + #13#10 +
      #13#10 + Base64EncodeFromFile(FileName) + #13#10;
  end;

  function AttachedFiles: string;
  var
    n: Integer;
    AttachmentsList: TStringList;
  begin
    Result := '';
    AttachmentsList := TStringList.Create;
    try
      if (ACustomAttachments <> nil) then
      begin
        for n := 0 to (ACustomAttachments.Count - 1) do
          AttachmentsList.Add(ACustomAttachments[n]);
      end;
      for n := 0 to High(AAttachments) do
        AttachmentsList.Add(AAttachments[n]);
      for n := 0 to (AttachmentsList.Count - 1) do
        Result := Result + AttachedFile(AttachmentsList[n]);
    finally
      AttachmentsList.Free;
    end;
  end;

  function SendCommandEx(Command: string; Codes: array of Word): Boolean;
  begin
    ProcessDialogMessages;
    Result := ClientSMTP.SendCommand(Command, Codes);
    ProcessDialogMessages;
  end;

begin
  with GlobalSendValues do
  try
    SetSendDialogLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Connecting]);
    ClientSMTP := TEurekaClientSMTP.Create(AHost, APort, True, 30000);
    try
      ProcessDialogMessages;
      ClientSMTP.Open;
      ProcessDialogMessages;
      ToStr := AMailTo;
      if ((Pos('"', AFrom) = 0) and (Pos('<', AFrom) = 0)) then
        FromStr := ('"' + LoggedUserName + '" <' + OneString(AFrom) + '>')
      else
        FromStr := OneString(AFrom);
      MailFrom := FromStr;
      Idx := Pos('" <', MailFrom);
      if (Idx > 0) then
        MailFrom := Copy(MailFrom, (Idx + 3), Length(MailFrom) - (Idx + 3));
      ContentType := 'Content-Type: multipart/mixed; ' +
        'boundary="' + Boundary + '";' + #13#10 +
        'MIME-Version: 1.0';
      DataText :=
        'This is a multi-part message in MIME format' + #13#10 +
        #13#10 +
        '--' + Boundary + #13#10 +
        'Content-Type: text/plain' + #13#10 +
        'Content-Transfer-Encoding: 7bit' + #13#10 +
        #13#10 +
        ABody + #13#10 +
        AttachedFiles +
        '--' + Boundary + '--' + #13#10;
      if (AUserID = '') and (APassword = '') then // Normal SMTP...
      begin
        SetSendDialogLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Connected]);
        Result := (SendCommandEx('HELO ' + HostName, [250])) and
          (SendCommandEx('RSET', [250])) and
          (SendCommandEx('MAIL FROM:<' + MailFrom + '>', [250]))
      end
      else // SMTP with log-in...
      begin
        SetSendDialogLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Connected]);
        Result := (SendCommandEx('EHLO ' + HostName, [250])) and
          (SendCommandEx('RSET', [250])) and
          (SendCommandEx('AUTH LOGIN', [334])) and
          (SendCommandEx(Base64EncodeString(AUserId), [334])) and
          (SendCommandEx(Base64EncodeString(APassword), [235])) and
          (SendCommandEx('MAIL FROM:<' + MailFrom + '>', [250]));
      end;
      SetSendDialogLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Sending]);
      CommandText :=
        'Date: ' + RFCDate(Now) + #13#10 +
        'From: ' + FromStr + #13#10 +
        'Subject: ' + OneString(ASubject) + #13#10 +
        'To: <' + OneString(ToStr) + '>' + #13#10 +
        ContentType + #13#10 +
        'Message-ID: <' + IntToStr(GetTickCount) + '@localhost.com>' + #13#10 +
        #13#10 +
        DataText + '.';
      Result := (Result) and
        (SendCommandEx('RCPT TO:<' + AMailTo + '>', [250, 251])) and
        (SendCommandEx('DATA', [354]));
      SetCounting;
      Result := (Result) and (SendCommandEx(CommandText, [250]));
      ResetCounting;
    finally
      ClientSMTP.Free;
    end;
  except
    Result := False;
    SetErrorType(eeEmailSMTPError, 'SMTP');
  end;
end;

function SMTPSendEmail(AsServer: Boolean; AFrom, AHost: string; APort: Word;
  AUserID, APassword, AMailTo, ASubject, ABody: string;
  AAttachments: array of string; ACustomAttachments: TStrings): Boolean;
var
  Addresses: TStringList;
  n: integer;
begin
  Result := False;
  ASubject := ExpandEnvVar(ASubject);
  ABody := ExpandEnvVar(ABody);
  Addresses := TStringList.Create;
  try
    try
      with GlobalSendValues do
      begin
        ExtractList(AMailTo, Addresses, [',', ';']);
        MsgTot := Addresses.Count;
        for n := 0 to Addresses.Count - 1 do
        begin
          SetSendDialogBar(0);
          MsgNum := (n + 1);
          if (AsServer) then
          begin
            SetSendDialogLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Resolving]);
            AHost := GetMXServerFromEmail(Addresses[n], 30000 {TimeOut in mSec});
            AUserID := '';
            APassword := '';
          end;
          AMailTo := Addresses[n];
          Result := SMTPSendSingleEmail(AsServer, AFrom, AHost, APort, AUserID,
            APassword, AMailTo, ASubject, ABody, AAttachments, ACustomAttachments) or
            (Result);
        end;
      end;
    except
      Result := False;
      SetErrorType(eeEmailSMTPError, 'SMTP');
    end;
  finally
    Addresses.Free;
  end;
  CloseSendDialog;
end;

{ TSendDialogThread }

constructor TSendDialogThread.Create(Modal: Boolean);
begin
  inherited Create(True);
  FModal := Modal;
end;

procedure TSendDialogThread.Execute;
begin
  ShowSendDialogThread(FModal);
end;

//------------------------------------------------------------------------------

procedure WebCallBackProc(ConnectionType: TConnectionType; TotalSize, BytesSent: DWord);
begin
  case ConnectionType of
    ctConnection:
    begin
      SetSendDialogBar(0);
      SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Connecting]);
    end;
    ctConnected: SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Connected]);
    ctSending:
    begin
      SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Sending]);
      SetSendDialogBar(Round(BytesSent / TotalSize * 100));
    end;
  end;
end;

procedure BlockingSendInternetMessage;
var
  EmailAddresses, EmailObject, EmailMessage: string;
  Executed, ShowedBugClosedMsg: Boolean;

  procedure CreateTmpLogFile;
  const
    ELF_End = #13#10#13#10#13#10;
  var
    S: TStringList;

    function FindEOFLine(const Log: string): Boolean;
    var
      Len: Integer;
    begin
      Len := Length(ELF_End);
      Result := (Copy(LastLog, (Length(LastLog) - Len + 1), Len) = ELF_End);
    end;

  begin
    if (TmpLogFileName = '') then Exit;

    S := TStringList.Create;
    try
      if (not FindEOFLine(LastLog)) then S.Text := (LastLog + ELF_End)
      else S.Text := LastLog;
      try
        S.SaveToFile(TmpLogFileName);
      except
        // Nothing...
      end;
    finally
      S.Free;
    end;
  end;

  function LogFileMessage: string;
  begin
    if (CurrentOptions.AppendLogs) then
      Result := (#13#10 + #13#10 + #13#10 + LastLog)
    else
      Result := '';
  end;

  function SMTPSend: Boolean;
  begin
    Result := (CurrentOptions.EmailSendMode in [esmSMTPClient, esmSMTPServer]);
  end;

  function ShellSendMail(MailToAddress, Subject, MessageText: string): Boolean;
  var
    StartInfo: TStartupInfo;
    ProcInfo: TProcessInformation;
    FmtStr, MailTo, CommandStr, LogString: string;
    hWnd: THandle;
    hProcess: THandle;
    WaitCode, ExitCode: DWord;

    function EncodeURL(source: string): string;
    var
      n: integer;
    begin
      Result := '';
      for n := 1 to Length(source) do
        if (source[n] in ['a'..'z', 'A'..'Z', '0'..'9', '-', #$80..#$FF]) then
          Result := (Result + source[n])
        else
          Result := (Result + '%' + IntToHex(Ord(source[n]), 2));
    end;

  begin
    Subject := ExpandEnvVar(Subject);
    MessageText := ExpandEnvVar(MessageText);
    MailTo := ReadKey(HKEY_CLASSES_ROOT, '\mailto\shell\open\command', '');
    MailTo := ExpandEnvVar(MailTo);
    FillChar(StartInfo, SizeOf(TStartupInfo), #0);
    FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
    StartInfo.cb := SizeOf(TStartupInfo);
    StartInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartInfo.wShowWindow := SW_SHOWMAXIMIZED;
    LogString := (#13#10 + #13#10 + #13#10 + LastExceptionLog);
    FmtStr := 'mailto:' + MailToAddress + '?Subject=' + EncodeURL(Subject) +
      '&Body=' + EncodeURL(MessageText + LogString);
    CommandStr := QuickStringReplace(MailTo, '%1', FmtStr);
    Result := CreateProcess(nil, PChar(CommandStr), nil, nil, False,
      CREATE_DEFAULT_ERROR_MODE + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo,
      ProcInfo);
    if Result then
    begin
      Result := False;
      hProcess := ProcInfo.hProcess;
      WaitForInputIdle(ProcInfo.hProcess, 10000);
      Sleep(2000);
      hWnd := GetMainWindow(ProcInfo.dwProcessId);
      if (hWnd <> 0) then
        SetWindowPos(hWnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
      WaitCode := WaitforSingleObject(hProcess, INFINITE);
      if (WaitCode <> WAIT_FAILED) then
        Result := (GetExitCodeProcess(hProcess, ExitCode));
      CloseHandle(ProcInfo.hThread);
      CloseHandle(ProcInfo.hProcess);
    end
    else
      SetInternalError(eeEmailShellError, SysErrorMessage(GetLastError));
  end;

  procedure CallExceptionActionNotify_atSendingEmail;
  begin
    CallModuleEvent_ExceptionActionNotify(
      Global_ExceptionRecord, atSendingEmail, Global_Execute);
    CallExceptionActionNotify(
      Global_ExceptionRecord, atSendingEmail, Global_Execute);
  end;

  procedure CallExceptionActionNotify_atSentEmail;
  begin
    CallModuleEvent_ExceptionActionNotify(
      Global_ExceptionRecord, atSentEmail, Global_Execute);
    CallExceptionActionNotify(
      Global_ExceptionRecord, atSentEmail, Global_Execute);
  end;

  procedure CallExceptionActionNotify_atSendingWebMessage;
  begin
    CallModuleEvent_ExceptionActionNotify(
      Global_ExceptionRecord, atSendingWebMessage, Global_Execute);
    CallExceptionActionNotify(
      Global_ExceptionRecord, atSendingWebMessage, Global_Execute);
  end;

  procedure CallExceptionActionNotify_atSentWebMessage;
  begin
    CallModuleEvent_ExceptionActionNotify(
      Global_ExceptionRecord, atSentWebMessage, Global_Execute);
    CallExceptionActionNotify(
      Global_ExceptionRecord, atSentWebMessage, Global_Execute);
  end;

  procedure CallExceptionErrorNotify_atSentEmail;
  begin
    CallModuleEvent_ExceptionErrorNotify(
      Global_ExceptionRecord, atSentEmail, Global_Retry);
    CallExceptionErrorNotify(
      Global_ExceptionRecord, atSentEmail, Global_Retry);
  end;

  procedure CallExceptionErrorNotify_atSentWebMessage;
  begin
    CallModuleEvent_ExceptionErrorNotify(
      Global_ExceptionRecord, atSentWebMessage, Global_Retry);
    CallExceptionErrorNotify(
      Global_ExceptionRecord, atSentWebMessage, Global_Retry);
  end;

  procedure CreateZIPFile(const FileName, Password: string; List: TStrings);
  var
    ZIP: TZIPWriter;
    i: Integer;
  begin
    if (List.Count = 0) then Exit;

    ZIP := TZIPWriter.Create(FileName, Password);
    try
      for i := 0 to (List.Count - 1) do
        ZIP.AddFile(List[i], ExtractFileName(List[i]));
    finally
      ZIP.Free;
    end;
  end;

  function TmpCompressedFileName: string;
  begin
    Result := (ExtractFilePath(CurrentOptions.OutputFile(ParamStr(0))) +
      GetRealFileName(TmpZIPFileName));
  end;

  procedure DeleteExtraFiles(const Dir: string);
  var
    sr: TSearchRec;
    FileAttrs: Integer;
    List: TStringList;
    n: Integer;
  begin
    List := TStringList.Create;
    try
      List.Sorted := True;
      FileAttrs := faArchive;
      if (FindFirst(Dir + '\*.zip', FileAttrs, sr) = 0) then
      begin
        repeat
          List.Add(sr.Name);
        until (FindNext(sr) <> 0);
        FindClose(sr);
      end;
      if (List.Count > MaxCompressedCopies) then
        for n := 0 to (List.Count - MaxCompressedCopies - 1) do DeleteFile(PChar(List[n]));
    finally
      List.Free;
    end;
  end;

  function SendEmailMessage: Boolean;
  begin
    Result := False;
    Global_Execute := True;

    SynchronizeEvent(@CallExceptionActionNotify_atSendingEmail);

    if Global_Execute then
    begin
      repeat
        Global_Execute := False;
        EmailAddresses := CurrentOptions.EmailAddresses;
        EmailObject := CurrentOptions.EmailSubject;
        EmailMessage := CurrentOptions.EmailMessage;
        if (not SMTPSend) then
          Global_Execute := InternalSendMail(EmailAddresses, EmailObject,
            EmailMessage + LogFileMessage, [''], Global_AttachedFiles)
        else
        begin
          ShowSendDialog(not (sndSendInSeparatedThread in CurrentOptions.CommonSendOptions));
          Global_Execute := SMTPSendEmail(
            (CurrentOptions.EmailSendMode = esmSMTPServer),
            CurrentOptions.SMTPFrom, CurrentOptions.SMTPHost,
            CurrentOptions.SMTPPort, CurrentOptions.SMTPUserID,
            CurrentOptions.SMTPPassword, EmailAddresses, EmailObject,
            EmailMessage + LogFileMessage, [''], Global_AttachedFiles);
        end;

        // Try to send with shell...
        if (not Global_Execute) and (not SMTPSend) then
          Global_Execute := ShellSendMail(EmailAddresses,
            EmailObject, EmailMessage);

        Global_Retry := False;
        if (not Global_Execute) then
          SynchronizeEvent(@CallExceptionErrorNotify_atSentEmail);
      until (not Global_Retry);

      Result := Global_Execute;

      SynchronizeEvent(@CallExceptionActionNotify_atSentEmail);
    end;
  end;

  function SendWebMessage: Boolean;
  var
    Protocol, UserID, Password, Host, Path, WebMsg: string;
    Port: Word;

    procedure SetError(ErrorType: TEurekaLogErrorCode; SendType: string; ErrorCode: Integer);
    var
      Msg: string;
    begin
      if (ErrorCode <> 0) then
      begin
        if (ErrorCode = Error_NetLibNotFound) then
          Msg := Format(' - Cannot find the "%s" library.', [WinInetLib])
        else
        begin
          if (WebMsg <> '') then Msg := (' (' + WebMsg + ')')
          else Msg := '';
        end;
        SetInternalError(ErrorType, Format('%s error code: %d%s', [SendType, ErrorCode, Msg]))
      end
      else Global_Execute := True;
    end;

    function UploadHTTPFiles: Boolean;
    var
      HTTPS: Boolean;
      RealFiles: TStringList;
      Error, n: Integer;
      ErrorType: TEurekaLogErrorCode;
      SendType: string;
    begin
      SynchronizeEvent(@CallCustomWebFieldsRequestEvents);

      SetProxyServer(CurrentOptions.ProxyURL, CurrentOptions.ProxyPort);
      SetProxyAuthenticationData(
        CurrentOptions.ProxyUserID, CurrentOptions.ProxyPassword);

      HTTPS := (CurrentOptions.WebSendMode = wsmHTTPS);
      if (HTTPS) then
      begin
        ErrorType := eeWebHTTPSError;
        SendType := 'HTTPS';
      end
      else
      begin
        ErrorType := eeWebHTTPError;
        SendType := 'HTTP';
      end;
      RealFiles := TStringList.Create;
      try
        for n := 0 to (Global_AttachedFiles.Count - 1) do
          RealFiles.Add(GetRealFileName(Global_AttachedFiles[n]));
        if (Global_AttachedFiles.Count > 0) then
          Error := HTTPUploadFiles(Host, Path, UserID, Password, Port, HTTPS,
            Global_AttachedFiles, RealFiles, Global_WebFields, WebCallBackProc,
            WebMsg)
        else
        begin
          Error := 0;
          WebMsg := '';
        end;
      finally
        RealFiles.Free;
      end;
      CloseSendDialog;
      SetError(ErrorType, SendType, Error);
      Result := (Error = 0);
    end;

    function UploadFTPFiles: Boolean;
    var
      RealFiles: TStringList;
      Error, n: Integer;
    begin
      SetProxyServer(CurrentOptions.ProxyURL, CurrentOptions.ProxyPort);
      SetProxyAuthenticationData(
        CurrentOptions.ProxyUserID, CurrentOptions.ProxyPassword);
      RealFiles := TStringList.Create;
      try
        for n := 0 to (Global_AttachedFiles.Count - 1) do
          RealFiles.Add(GetRealFileName(Global_AttachedFiles[n]));
        Error := FTPUploadFiles(Host, Path, UserID, Password, Port,
          Global_AttachedFiles, RealFiles, WebCallBackProc, WebMsg);
      finally
        RealFiles.Free;
      end;
      CloseSendDialog;
      SetError(eeWebFTPError, 'FTP', Error);
      Result := (Error = 0);
    end;

    function UploadBugTrakerFiles: Boolean;
    var
      WebTrakerClass: THTTPSendReportClass;
      AppVersion, BugType, BugMessage, BugID, BaseURL, ProxyURL, FileToSend: string;
      SendResult: TSendResult;

      function SetFullURL(const URL, User, Password, Port: string): string;
      var
        RealPort: Word;
      begin
        Result := URL;
        if (Port <> '') then RealPort := StrToInt(Port)
        else RealPort := 0;
        AddAuthenticationToURL(Result, User, Password, RealPort);
      end;

      procedure SetWebTrakerError(ErrorCode: TSendResult);
      var
        Msg: string;
      begin
        if (not (ErrorCode in [srOK, srBugClosed])) then
        begin
          case ErrorCode of
            srUnknownError: Msg := CurrentOptions.CustomizedExpandedTexts[mtSend_UnknownErrorMsg];
            srInvalidLogin: Msg := CurrentOptions.CustomizedExpandedTexts[mtSend_InvalidLoginMsg];
            srInvalidSearch: Msg := CurrentOptions.CustomizedExpandedTexts[mtSend_InvalidSearchMsg];
            srInvalidSelection: Msg := CurrentOptions.CustomizedExpandedTexts[mtSend_InvalidSelectionMsg];
            srInvalidInsert: Msg := CurrentOptions.CustomizedExpandedTexts[mtSend_InvalidInsertMsg];
            srInvalidModify: Msg := CurrentOptions.CustomizedExpandedTexts[mtSend_InvalidModifyMsg];
          end;
          SetInternalError(eeWebTrakerError, Msg);
        end
        else Global_Execute := True;
      end;

    begin
      WebTrakerClass := nil;
      if (Global_AttachedFiles.Count > 0) then FileToSend := Global_AttachedFiles[0]
      else FileToSend := '';

      BugID := LastBugID;
      BugType := LastExceptionType;
      BugMessage := LastExceptionMessage;
      AppVersion := GetVersionNumber;
      BaseURL := SetFullURL(CurrentOptions.WebURL, CurrentOptions.WebUserID,
        CurrentOptions.WebPassword, IntToStr(CurrentOptions.WebPort));
      ProxyURL := SetFullURL(CurrentOptions.ProxyURL, CurrentOptions.ProxyUserID,
        CurrentOptions.ProxyPassword, IntToStr(CurrentOptions.ProxyPort));

      Case CurrentOptions.WebSendMode of
        wsmBugZilla: WebTrakerClass := THTTPBugzillaSendReport;
        wsmFogBugz: WebTrakerClass := THTTPFogBugzSendReport;
        wsmMantis: WebTrakerClass := THTTPMantisSendReport;
      end;

      SendResult := SendWebTrakerReport(THTTPConnection, WebTrakerClass,
        AppVersion, BugType, BugMessage, BugID, BaseURL, ProxyURL,
        CurrentOptions.TrakerUserID, CurrentOptions.TrakerPassword,
        CurrentOptions.TrakerProject, CurrentOptions.TrakerCategory,
        CurrentOptions.TrakerAssignTo, FileToSend,
        ifelseStr(CurrentOptions.TrakerTrialID = '', '',
        'ID=' + CurrentOptions.TrakerTrialID));
      CloseSendDialog;
      if (SendResult = srBugClosed) and (GlobalSendValues.Dialog <> 0) then
      begin
        MessageBox(MsgBoxhWnd, PChar(CurrentOptions.CustomizedExpandedTexts[mtSend_BugClosedMsg]),
          PChar(CurrentOptions.CustomizedExpandedTexts[mtInformationMsgCaption]),
          MB_OK or MB_ICONINFORMATION or MessageBoxFlags);
        ShowedBugClosedMsg := True;
      end;
      SetWebTrakerError(SendResult);
      Result := (SendResult in [srOK, srBugClosed]);
    end;

  begin
    Result := False;
    Global_Execute := True;

    SynchronizeEvent(@CallExceptionActionNotify_atSendingWebMessage);

    if Global_Execute then
    begin
      Result := True;
      repeat
        Global_Execute := False;
        ShowSendDialog(not (sndSendInSeparatedThread in CurrentOptions.CommonSendOptions));
        ElaborateURL(CurrentOptions.WebURL, Protocol, UserID, Password, Host, Path, Port);
        Port := CurrentOptions.WebPort;
        UserID := CurrentOptions.WebUserID;
        Password := CurrentOptions.WebPassword;
        if (CurrentOptions.WebSendMode in [wsmHTTP..wsmHTTPS]) then Result := UploadHTTPFiles
        else
          if (CurrentOptions.WebSendMode in [wsmFTP]) then Result := UploadFTPFiles
          else
            if (CurrentOptions.WebSendMode in [wsmBugZilla..wsmMantis]) then
              Result := UploadBugTrakerFiles;

        Global_Retry := False;
        if (not Global_Execute) then
          SynchronizeEvent(@CallExceptionErrorNotify_atSentWebMessage);
      until (not Global_Retry);

      SynchronizeEvent(@CallExceptionActionNotify_atSentWebMessage);
    end;
  end;

  procedure PrepareFilesToSend(EmailSend: Boolean);
  var
    n: Integer;
  begin
    FillAttachedList(EmailSend, Global_AttachedFiles);

    SynchronizeEvent(@CallAttachedFilesRequestEvents);

    n := 0; // Check if the Attached Files exists...
    while (n <= Global_AttachedFiles.Count - 1) do
    begin
      if (not FileExists(Global_AttachedFiles[n])) then Global_AttachedFiles.Delete(n)
      else Inc(n);
    end;

    CreateZIPFile(TmpZIPFileName, CurrentOptions.ZipPassword, Global_AttachedFiles);
    Global_AttachedFiles.Text := TmpZIPFileName;
  end;

begin // BlockingSendInternetMessage
  ShowedBugClosedMsg := False;
  Global_Execute := True;
  Global_AttachedFiles.Clear;
  Global_WebFields.Clear;
  ClearInternalError;
  CreateTmpLogFile;
  try
    CreateHTMLFile(SavedLastHTMLPage);
    try
      CreateXMLLogCopy;
      try
        Executed := True;

        if (CurrentOptions.EmailSendMode <> esmNoSend) then
        begin
          PrepareFilesToSend(True);
          if (CurrentOptions.EmailSendMode <> esmNoSend) then
            Executed := (SendEmailMessage and Executed);
        end;

        if (CurrentOptions.WebSendMode <> wsmNoSend) then
        begin
          if (CurrentOptions.EmailSendMode = esmNoSend) or (CurrentOptions.AppendLogs) then
            PrepareFilesToSend(False);
          if (CurrentOptions.WebSendMode <> wsmNoSend) then
            Executed := (SendWebMessage and Executed);
        end;

        if (not Executed) and
          (boCopyLogInCaseOfError in CurrentOptions.BehaviourOptions) then
          SetClipboardText(LastExceptionLog);

        if (sndShowSuccessFailureMsg in CurrentOptions.CommonSendOptions) and
          (not ShowedBugClosedMsg) then
        begin
          if (Executed) then MessageBox(MsgBoxhWnd,
            PChar(CurrentOptions.CustomizedExpandedTexts[mtSend_SuccessMsg]),
            PChar(CurrentOptions.CustomizedExpandedTexts[mtInformationMsgCaption]),
            MB_ICONINFORMATION or MB_OK or MessageBoxFlags)
          else MessageBox(MsgBoxhWnd,
            PChar(CurrentOptions.CustomizedExpandedTexts[mtSend_FailureMsg]),
            PChar(CurrentOptions.CustomizedExpandedTexts[mtInformationMsgCaption]),
            MB_ICONERROR or MB_OK or MessageBoxFlags)
        end;

        if (boSaveCompressedCopyInCaseOfError in CurrentOptions.BehaviourOptions)
          and (not Executed) then
        begin
          MoveFile(PChar(TmpZIPFileName), PChar(TmpCompressedFileName));
          DeleteExtraFiles(ExtractFilePath(TmpCompressedFileName));
        end;

        DeleteFile(TmpZIPFileName);
      finally
        DeleteFile(TmpXMLLogCopy);
      end;
    finally
      if (not IsCGI) then DeleteFile(TmpLastHTMLPage);
    end;
  finally
    DeleteFile(TmpLogFileName);
  end;
end;

procedure SendInternetMessage;
var
  SendThread: TSendThread;
begin
  if ((not CannotUseThread) and
    (sndSendInSeparatedThread in CurrentOptions.CommonSendOptions)) then
  begin
    Global_ExceptionRecord.ExceptionObject :=
      CloneObject(Global_ExceptionRecord.ExceptionObject);  
    SendThread := TSendThread.Create(True);
    SendThread.FreeOnTerminate := True;
    SendThread.Priority := tpHighest;
    SendThread.Resume;
  end
  else BlockingSendInternetMessage;
end;
{$ELSE}

procedure SendInternetMessage;
begin
end;
{$ENDIF}

procedure ExceptNotifyAfter1;
begin
{$IFDEF PROFESSIONAL}
  DeleteFile(SavedScreenshot);
{$ENDIF}
  if ((not IntoIDE) and (CurrentOptions.AutoCrashOperation <> tbNone)) then
  begin
    if ((ExceptionsTime.Count = CurrentOptions.AutoCrashNumber) and
    (StrToDateTime(ExceptionsTime[ExceptionsTime.Count - 1]) -
    StrTodateTime(ExceptionsTime[0]) <= (CurrentOptions.AutoCrashMinutes / 1440))) then
    ForceApplicationTermination(CurrentOptions.AutoCrashOperation);
  end;
end;

procedure ExceptNotifyAfter2;
begin
  CurrentStackList.Free;
  CurrentStackList := nil;
end;

procedure ExceptNotifyAfter3;
begin
  if TerminateApplication then
    KillApplication(CurrentOptions.TerminateBtnOperation = tbRestart);

{$IFDEF CBuilder}
  if (IsConsole) and (LastExceptThreadID = MainThreadID) then
    TerminateProcess(GetCurrentProcess, 1);
{$ENDIF}
end;

{$IFDEF PROFESSIONAL}

{ TSendThread }

procedure TSendThread.Execute;
begin
  EnterCriticalSection(ExceptionCriticalSection);
  try
    BlockingSendInternetMessage;
    ExceptNotifyAfter1;
    ExceptNotifyAfter2;
    ExceptNotifyAfter3;
    FreeClonedObject(Global_ExceptionRecord.ExceptionObject);
  finally
    LeaveCriticalSection(ExceptionCriticalSection);
  end;
end;
{$ENDIF}

// Return Asm text from a function address.

function DebugToStr(const DebugInfo: TEurekaDebugInfo): string;

  procedure AddStr(const Src: string);
  begin
    if (Src = '') then Exit;

    if (Result <> '') then Result := (Result + '.');
    Result := (Result + Src);
  end;

begin
  Result := '';
  AddStr(ChangeFileExt(DebugInfo.UnitName, ''));
  AddStr(DebugInfo.ClassName);
  AddStr(DebugInfo.ProcedureName);
end;

procedure GetDebugInfoEx(Addr: DWord; var DebugInfo: TEurekaDebugInfo);
var
  ModuleInfo: PEurekaModuleInfo;
begin
  GetDebugInfosByAddr(Addr, 0, @DebugInfo, True, False);
  if (DebugInfo.DebugDetail in [ddNone..ddModule]) then
  begin
    ModuleInfo := ModuleInfoByAddr(Addr);
    if (ModuleInfo <> nil) then
    begin
      if (ModuleInfo^.OtherDebugData = nil) and
        (AssignValidDebugInfo(ModuleInfo^.Handle, ModuleInfo^.OtherDebugData)) then
        GetDebugInfosByAddr(Addr, 0, @DebugInfo, True, False);
    end;
  end;
end;

procedure OnCallInstr(Param: Pointer; ValueAddress, CallAddress: PChar; var Result: string);
var
  DebugInfo: TEurekaDebugInfo;
  Addr: DWord;
  Obj: TObject;
  Res: string;
begin
  Addr := ConvertAddress(DWord(CallAddress));
  GetDebugInfoEx(Addr, DebugInfo);
  if (DebugInfo.DebugDetail in [ddProcedure..ddSourceCode]) then
  begin
    Res := DebugToStr(DebugInfo);
    if (DebugInfo.ProcOffsetLine > 1) then
      Res := (Res + ' (Line=' + IntToStr(DebugInfo.Line) + ')');
  end
  else
  begin
    Obj := TObject(CallAddress);
    if IsValidObject(Obj) then Res := Obj.ClassName;
  end;
  if (Res <> '') then Result := Res;
end;

procedure OnRefProc(Param: Pointer; Ref: TdaRef; RefSize: Integer; var Result: string);
begin
  // ...
end;

procedure ImmidiateDataProc(Param: Pointer; ValueAddress: PChar;
  OperandSize: Integer; Sigend: Boolean; var Result: string);
var
  V, C, n: DWord;
  Ptr: PChar;
  St: string;
  Ch: Char;
  EndStr: Boolean;
begin
  if ((OperandSize = 4) and (Sigend = False)) then
  begin
    Val(Result, V, C);
    if (C = 0) then
    begin
      St := '';
      Ptr := PChar(V);
      EndStr := False;
      for n := 0 to 31 do
      begin
        if (IsValidBlockAddr(DWord(Ptr), 1)) then
        begin
          Ch := Ptr^;
          if (Ch = #0) then
          begin
            EndStr := True;
            Break;
          end;
          if (Ch < #32) then Ch := '.';
          St := (St + Ch);
          Inc(Ptr);
        end
        else Break;
      end;
      Result := (Result + '  ; ''' + St + '''');
      if (not EndStr) then Result := (Result + '...');
    end;
  end;
end;

function GetFunctionAsm(Addr: PChar): string;
var
  LowAddr, Ptr, HighAddr: PChar;
  Size, Count, Diff: Byte;
  AsmSize, MaxAsmLen, n, Idx, LastIdx: Integer;
  AsmText: TStringList;
  DisAsm: TDisAsm;
  AsmCode, LittleCode, Source, Line, OldSource, OldLine, Comment, DotLine: string;
  DebugInfo: TEurekaDebugInfo;
  CommentOn: Boolean;

  procedure StartComment;
  begin
    if (not CommentOn) then
    begin
      AsmCode := (AsmCode + '  ; ');
      CommentOn := True;
    end;
  end;

begin
  Result := '';

  if (IsValidBlockAddr(DWord(Addr), 4)) then
  begin
    // Calculate the LowAddr value...
    LowAddr := (Addr - 70);
    while (not IsValidBlockAddr(DWord(LowAddr), 1)) do Inc(LowAddr);
    Dec(LowAddr);
    repeat
      Count := 0;
      Inc(LowAddr);
      Ptr := LowAddr;
      while (Ptr < Addr) do
      begin
        if GetAsmSize(Ptr, Size) then
        begin
          Inc(Ptr, Size);
          Inc(Count);
        end
        else Inc(Ptr);
      end;
    until (Ptr = Addr);

    // Move the LowAddr to the previous 10 ASM instructions (not more)...
    if (Count > 10) then
    begin
      Diff := (Count - 10);
      while (Diff > 0) do
      begin
        if GetAsmSize(LowAddr, Size) then
        begin
          Inc(LowAddr, Size);
          Dec(Diff);
        end
        else Inc(LowAddr);
      end;
    end;

    // Calculate the HighAddr value...
    HighAddr := (Addr + 70);
    while (not IsValidBlockAddr(DWord(HighAddr), 1)) do Dec(HighAddr);

    // Generate the ASM instructions...
    OldSource := '';
    OldLine := '';
    MaxAsmLen := 0;
    LastIdx := 0;
    AsmText := TStringList.Create;
    DisAsm := TDisAsm.Create;
    DisAsm.OnCallInstr := OnCallInstr;
    DisAsm.OnJumpInstr := OnCallInstr;
    DisAsm.OnAddressRef := OnCallInstr;
    DisAsm.OnRef := OnRefProc;
    DisAsm.OnImmidiateData := ImmidiateDataProc;
    try
      Count := 0;
      Ptr := LowAddr;
      while (Ptr <= HighAddr) do
      begin
        Comment := '';
        if (Ptr > Addr) then Inc(Count);
        CommentOn := False;
        AsmCode := (IntToHex(DWord(Ptr), 8) + '  ' + DisAsm.GetInstruction(Ptr, AsmSize));
        Idx := Pos(';', AsmCode);
        if (Idx > 0) then LittleCode := Trim(Copy(AsmCode, 1, Idx - 1))
        else LittleCode := AsmCode;
        if (Length(LittleCode) > MaxAsmLen) then MaxAsmLen := Length(LittleCode);
        if (Ptr = Addr) then
        begin
          StartComment;
          AsmCode := (AsmCode + '<-- EXCEPTION');
        end;
        GetDebugInfoEx(DWord(Ptr), DebugInfo);
        if (DebugInfo.DebugDetail in [ddProcedure..ddSourceCode]) then
        begin
          Source := (DebugToStr(DebugInfo) + ' ');
          Line := ('Line=' + IntToStr(DebugInfo.Line) +
            ' - Offset=' + IntToStr(DebugInfo.ProcOffsetLine));
          if (Source <> OldSource) then
          begin
            OldSource := Source;
            Comment := (Comment + Source);
            if (Ptr <= Addr) then LastIdx := AsmText.Count;
          end;
          if (Line <> OldLine) then
          begin
            OldLine := Line;
            if (Comment <> '') then Comment := (Comment + '(' + Line + ')')
            else Comment := (Comment + Line);
          end;
        end;

        if (Comment <> '') then
        begin
          DotLine := '';
          for n := 1 to Length(Comment) do DotLine := (DotLine + '-');
          if (AsmText.Count > 0) then AsmText.Add(';');
          AsmText.Add('; ' + Comment);
          AsmText.Add('; ' + DotLine);
        end;
        AsmText.Add(AsmCode);

        // Check for 10 istructions after the Exception Addr...
        if (Count = 10) then Break;

        // Check for 'RET' istruction...
        if ((Ptr > Addr) and (PByte(Ptr)^ in [$C2, $C3..$CA, $CB])) then Break;
        Inc(Ptr, AsmSize);
      end;

      // Remove unused Asm instructions...
      for n := 0 to (LastIdx - 1) do AsmText.Delete(0);

      // Remove first ';' empty commented line...
      if (AsmText.Count > 0) and (AsmText[0] = ';') then AsmText.Delete(0);

      // Normalize ASM comments...
      Inc(MaxAsmLen, 2);
      for n := 0 to (AsmText.Count - 1) do
      begin
        Idx := Pos(';', AsmText[n]);
        if (Idx > 1) and (Idx < MaxAsmLen) then
        begin
          AsmCode := CompleteStr(Copy(AsmText[n], 1, Idx - 1), MaxAsmLen);
          Comment := Copy(AsmText[n], Idx, MaxInt);
          AsmText[n] := (AsmCode + Comment);
        end;
      end;

      MaxAsmLen := (Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_AsmHeader]) + 1);
      for n := 0 to (AsmText.Count - 1) do
        if (Length(AsmText[n]) > MaxAsmLen) then MaxAsmLen := Length(AsmText[n]);

      CurrentAsmErrorLine :=
        (CurrentOptions.CustomizedExpandedTexts[mtDialog_AsmHeader] + ':' + #13#10);
      for n := 1 to MaxAsmLen do CurrentAsmErrorLine := (CurrentAsmErrorLine + '-');

      Result := AsmText.Text;
    finally
      DisAsm.Free;
      AsmText.Free;
    end;
  end;
end;

function InternalExceptNotify(Obj: TObject; Addr: Pointer; DelphiException: Boolean;
  Params: TExceptNotifyParams; RaiserType: TRaiserType; ModuleHandle: THandle;
  AsynchronousException: TAsynchronousException): Boolean;
var
  MustSendInternetMessage: Boolean;
  LastUsedThreadID: DWord;
  CanShowHowToRequest, PlaySound, RunningThread, ErrorLine, FirstLine: Boolean;
  i: Integer;
  HandlerType: TFilterHandlerType;
  ActionType: TFilterActionType;
  LocalThreadsList: TEurekaThreadsList;
  ThreadData: PEurekaThreadInfo;
  Context: TContext;
  ResultText, ln, ModName, DetailErrorText, LineStr, HeaderText, BugID: string;
  ModuleInfo, OldModuleInfo: PEurekaModuleInfo;
  RealMainInstance: THandle;
  MaxAddr, MaxModule, MaxUnit, MaxClass, MaxProc, MaxLine: integer;
  MaxModHandle, MaxModName, MaxModDesc, MaxModVer, MaxModSize,
    MaxModPath, MaxModModified: Integer;
  MaxProID, MaxProName, MaxProDesc, MaxProVer, MaxProMemory,
    MaxProPriority, MaxProThreads, MaxProPath: Integer;
  LineSize, LogIdx: Integer; // For internal loging system.
  LogStr, ThreadStr, ThreadLineStr, LastVersionStr: string;

  function PurgeString(s: string): string;
  var
    i: integer;
  begin
    Result := '';
    if length(s) > 0 then
    begin
      for i := 1 to length(s) do
        if (s[i] >= #32) or (s[i] in [#10, #13]) then
          Result := Result + s[i]
        else
          Result := Result + ' ';
    end;
  end;

  function GetParameters: string;
  var
    n: integer;
  begin
    Result := '';
    for n := 1 to ParamCount do
    begin
      if (n > 1) then Result := Result + ' ';
      Result := Result + '"' + ParamStr(n) + '"';
    end;
  end;

  function GetCompilationDate: string;
  var
    ModInfo: PEurekaModuleInfo;
  begin
    Result := '';
    ModInfo := ModuleInfoByHandle(HInstance);
    if (ModInfo <> nil) and (ModInfo^.ExtraInformation.CompilationDate <> 0) then
      Result := RFCDate(ModInfo^.ExtraInformation.CompilationDate + (GetGMT / 24));
  end;

  function GetApplicationUpTime: string;
  begin
    Result := GetCompleteTimeStr(ExceptionTime - StartingDate);
  end;

  function GetActiveFormClass: string;
  var
    Buff: array[0..255] of Char;
    I: DWord;
  begin
    I := SizeOf(Buff);
    if GetClassName(GetForegroundWindow(), Buff, I) > 0 then
      Result := Buff
    else
      Result := '';
  end;

  function GetActiveFormText: string;
  var
    Buff: array[0..255] of Char;
    I: DWord;
  begin
    I := SizeOf(Buff);
    if DefWindowProc(GetForegroundWindow, WM_GETTEXT, I, DWord(@Buff)) > 0 then
      Result := OneString(Buff)
    else
      Result := '';
  end;

  function GetActiveControlClass: string;
  begin
    Result := Params.ActiveControlClass
  end;

  function GetActiveControlText: string;
  begin
    Result := OneString(Params.ActiveControlText)
  end;

  function GetOSBuild: string;
  begin
    if Win32Platform = VER_PLATFORM_WIN32_NT then
      Result := IntToStr(Win32BuildNumber)
    else
      Result := IntToStr((Win32BuildNumber and $0000FFFF));
  end;

  function GetOSUpdate: string;
  begin
    Result := Trim(Win32CSDVersion);
  end;

  function GetOSLanguage: string;

    function GetLanguageString: string;

      { Called for each supported locale. }

      function LocalesCallback(LocaleID: PChar): Integer; stdcall;
      var
        AID: LCID;
        ShortLangName, Name: string;
        GetLocaleDataProc: function(ID: LCID; Flag: DWORD): string;

        { Query the OS for information for a specified locale. Unicode version.
          Works correctly on Asian WinNT. }

        function GetLocaleDataW(ID: LCID; Flag: DWORD): string;
        var
          Buffer: array[0..1023] of WideChar;
        begin
          Buffer[0] := #0;
          GetLocaleInfoW(ID, Flag, Buffer, SizeOf(Buffer) div 2);
          Result := Buffer;
        end;

        { Query the OS for information for a specified locale. ANSI Version.
          Works correctly on Asian Win95. }

        function GetLocaleDataA(ID: LCID; Flag: DWORD): string;
        var
          Buffer: array[0..1023] of Char;
        begin
          Buffer[0] := #0;
          SetString(Result, Buffer, GetLocaleInfoA(ID, Flag, Buffer,
            SizeOf(Buffer)) - 1);
        end;

      begin
        Result := 1;
        if Win32Platform = VER_PLATFORM_WIN32_NT then
          GetLocaleDataProc := @GetLocaleDataW
        else
          GetLocaleDataProc := @GetLocaleDataA;
        AID := StrToInt('$' + Copy(LocaleID, 5, 4));
        ShortLangName := GetLocaleDataProc(AID, LOCALE_SABBREVLANGNAME);
        if ShortLangName <> '' then
        begin
          Name := GetLocaleDataProc(AID, LOCALE_SENGLANGUAGE);
          if GetSystemDefaultLangID = AID then
          begin
            LanguageStr := Name;
            Result := 0;
          end;
        end;
      end;

    begin
      LanguageStr := '';
      EnumSystemLocales(@LocalesCallback, LCID_INSTALLED);
      Result := LanguageStr;
    end;

  begin
    Result := GetLanguageString;
  end;

  function GetOSCharset: string;
  begin
    Result := IntToStr(UserCharSet);
  end;

  function GetExceptionDate: string;
  begin
    Result := RFCDate(ExceptionTime);
  end;

  function GetExceptionAddress: string;
  begin
    if (Addr <> nil) then
      Result := IntToHex(DWord(Addr), 8)
    else
      Result := '';
  end;

  function GetExceptionModuleName: string;
  var
    Description, Tmp: string;
  begin
    Result := ExtractFileName(ModuleFileName(FindHInstance(Pointer(Addr))));
    GetModuleDescriptionAndVersion(ModuleFileName(FindHInstance(Pointer(Addr))), Description, Tmp);
    if (Description <> '') then Result := (Result + ' - (' + Description + ')');
  end;

  function GetExceptionModuleVersion: string;
  var
    Tmp: string;
  begin
    GetModuleDescriptionAndVersion(ModuleFileName(FindHInstance(Pointer(Addr))), Tmp, Result)
  end;

  function GetExceptionType: string;
  begin
    if (IsValidObject(Obj)) then
    begin
      if (IsAParent(Obj, TActiveXException)) then
        Result := TActiveXException(Obj).ExceptionType
      else
        Result := Obj.ClassName;
    end
    else Result := 'Unknown exception type';
    LastExceptionType := Result;
  end;

  function GetExceptionMessage: string;

{$IFDEF Delphi4Up}
    function AccessViolationModuleInLongFormat(Error: Exception): string;
    var
      AccessOp: string;
      AccessAddress: Pointer;
      MemInfo: TMemoryBasicInformation;
      ModName: array[0..MAX_PATH] of Char;
      AV: EAccessViolation;
    begin
      Result := Error.Message;
      if (not IsAParent(Obj, EAccessViolation)) then Exit;

      AV := EAccessViolation(Error);
      if (not IsValidBlockAddr(DWord(AV.ExceptionRecord), SizeOf(AV.ExceptionRecord))) then Exit;

      with AV.ExceptionRecord^ do
      begin
        if ExceptionInformation[0] = 0 then AccessOp := SReadAccess
        else AccessOp := SWriteAccess;
        AccessAddress := Pointer(ExceptionInformation[1]);
        VirtualQuery(ExceptionAddress, MemInfo, SizeOf(MemInfo));
        if (MemInfo.State = MEM_COMMIT) and
          (GetModuleFileName(THandle(MemInfo.AllocationBase), ModName, SizeOf(ModName)) <> 0) then
        begin
          Result := Format(sModuleAccessViolation,
            [ExceptionAddress, ExtractFileName(ModName), AccessOp, AccessAddress]);

          // If Access Violation is generated by RTL fix its Module name...
          if (Error.Message = Result) then
            Result := Format(sModuleAccessViolation,
              [ExceptionAddress, ExtractFileName(GetLongNameFromShort(ModName)),
              AccessOp, AccessAddress]);
        end
        else
          Result := Format(
            {$IFDEF Delphi7Up} SAccessViolationArg3 {$ELSE} SAccessViolation {$ENDIF}
            ,[ExceptionAddress, AccessOp, AccessAddress]);
      end;
    end;
{$ENDIF}

  begin
    if (IsAParent(Obj, Exception)) then
{$IFDEF Delphi4Up}
      Result := AccessViolationModuleInLongFormat(Exception(Obj))
{$ELSE}
      Result := Exception(Obj).Message
{$ENDIF}
    else Result := 'Unknown error message.';
    if (Result <> '') and (Result[length(Result)] <> '.') then Result := Result + '.';
    LastExceptionMessage := Result;
  end;

  function GetTotalMemory: string;
  var
    Mem: TMemoryStatus;
  begin
    Mem.dwLength := SizeOf(Mem);
    GlobalMemoryStatus(Mem);
    Result := IntToStr(Round(Mem.dwTotalPhys / (1024 * 1024))) + ' Mb';
  end;

  function GetFreeMemory: string;
  var
    Mem: TMemoryStatus;
  begin
    Mem.dwLength := SizeOf(Mem);
    GlobalMemoryStatus(Mem);
    Result := IntToStr(Round(Mem.dwAvailPhys / (1024 * 1024))) + ' Mb';
  end;

  function GetDiskInfo(var TotalDisk, FreeDisk: Comp): boolean;
  var
    GetDiskFree: function(Directory: PChar; var FreeAvailable,
      TotalSpace; TotalFree: Pointer): Bool stdcall;
    Kernel: THandle;
    Disk: string;
  begin
    Result := False;
    Kernel := GetModuleHandle(Windows.Kernel32);
    if Kernel <> 0 then
    begin
      @GetDiskFree := GetProcAddress(Kernel, 'GetDiskFreeSpaceExA');
      if Assigned(GetDiskFree) then
      begin
        Disk := ExtractFileDrive(ModuleFileName(HInstance)) + '\';
        Result := GetDiskFree(PChar(Disk), FreeDisk, TotalDisk, nil);
      end;
    end;
  end;

  function GetFreeDisk: string;
  var
    TotalDisk, FreeDisk: Comp;
  begin
    Result := '';
    if GetDiskInfo(TotalDisk, FreeDisk) then
      Result := FormatFloat('0.##', FreeDisk / (1024 * 1024 * 1024)) + ' Gb';
  end;

  function GetTotalDisk: string;
  var
    TotalDisk, FreeDisk: Comp;
  begin
    Result := '';
    if GetDiskInfo(TotalDisk, FreeDisk) then
      Result := FormatFloat('0.##', TotalDisk / (1024 * 1024 * 1024)) + ' Gb';
  end;

  function GetStartDate: string;
  begin
    Result := RFCDate(StartingDate);
  end;

  function GetApplicationName: string;
  var
    Description, Tmp: string;
  begin
    Result := ExtractFileName(ModuleFileName(MainInstance));
    GetModuleDescriptionAndVersion(ModuleFileName(MainInstance), Description, Tmp);
    if (Description <> '') then Result := (Result + ' - (' + Description + ')');
  end;

  function GetProcessor: string;
  var
    Vendor, ID: string;
  begin
    Result := Trim(ReadKey(HKEY_LOCAL_MACHINE,
      '\HARDWARE\DESCRIPTION\System\CentralProcessor\0', 'ProcessorNameString'));
    if (Result = '') then
    begin
      Vendor := Trim(ReadKey(HKEY_LOCAL_MACHINE,
        '\HARDWARE\DESCRIPTION\System\CentralProcessor\0', 'VendorIdentifier'));
      ID := Trim(ReadKey(HKEY_LOCAL_MACHINE,
        '\HARDWARE\DESCRIPTION\System\CentralProcessor\0', 'Identifier'));
      if (Vendor <> '') then Result := Vendor;
      if (ID <> '') then
        if (Result <> '') then Result := (Result + ' - ' + ID);
      if (Result = '') then Result := 'Unknown processor';
    end;
  end;

  function GetSystemUpTime: string;
  var
    Days: Double;
  begin
    Days := (GetTickCount / 86400000);
    Result := GetCompleteTimeStr(Days);
  end;

  function GetDisplayMode: string;
  var
    DeviceContext: hDC;
  begin
    DeviceContext := GetDC(0);
    try
      Result := Format('%d x %d, %d bit', [GetSystemMetrics(SM_CXSCREEN),
        GetSystemMetrics(SM_CYSCREEN), GetDeviceCaps(DeviceContext, BITSPIXEL)]);
    finally
      ReleaseDC(0, DeviceContext);
    end;
  end;

  procedure GetNetworkData(var IP, Submask, Gateway, DNS1, DNS2, DHCP: string);
  type
    IP_ADDRESS_STRING = record
      S: array[0..15] of Char;
    end;

    PIP_ADDR_STRING = ^IP_ADDR_STRING;
    IP_ADDR_STRING = record
      Next: PIP_ADDR_STRING;
      IpAddress: IP_ADDRESS_STRING;
      IpMask: IP_ADDRESS_STRING;
      Context: DWord;
    end;

    PIP_ADAPTER_INFO = ^IP_ADAPTER_INFO;
    IP_ADAPTER_INFO = record
      Next: PIP_ADAPTER_INFO;
      Unused0: array[0..407] of Byte;
      Index: DWord;
      Type_: DWord;
      DhcpEnabled: DWord;
      CurrentIpAddress: PIP_ADDR_STRING;
      IpAddressList: IP_ADDR_STRING;
      GatewayList: IP_ADDR_STRING;
      DhcpServer: IP_ADDR_STRING;
      Unused1: array[0..19] of Byte;
    end;

    PIP_PER_ADAPTER_INFO = ^IP_PER_ADAPTER_INFO;
    IP_PER_ADAPTER_INFO = record
      Unused: array[0..7] of Byte;
      CurrentDnsServer: PIP_ADDR_STRING;
      DnsServerList: IP_ADDR_STRING;
    end;

  var
    GetAdaptersInfo: function(pAdapterInfo: PIP_ADAPTER_INFO;
      var pOutBufLen: DWord): DWord; stdcall; //external 'iphlpapi.dll';
    GetPerAdapterInfo: function(IfIndex: DWord; pPerAdapterInfo: PIP_PER_ADAPTER_INFO;
      var pOutBufLen: DWord): DWord; stdcall; //external '';
    Adapters, Adapters_Start: PIP_ADAPTER_INFO;
    DLL: THandle;
    Size: DWord;

    procedure GetAdapterInfo(Adapter: PIP_ADAPTER_INFO);
    var
      IpAddrString: PIp_Addr_String;
      GatewayString: PIp_Addr_String;
      DnsServerString: PIp_Addr_String;
      pPerAdapterInfo: PIP_PER_ADAPTER_INFO;
      n: Integer;
      Size2: DWord;

      function CompleteIP(IPAddr: string): string;
      var
        Idx, n: Integer;
        Num: string;
      begin
        if (IPAddr = '') then
        begin
          Result := '000.000.000.000';
          Exit;
        end;

        Result := '';
        IPAddr := (IPAddr + '.');
        repeat
          Idx := Pos('.', IPAddr);
          if (Idx <> 0) then
          begin
            Num := Copy(IPAddr, 1, Idx - 1);
            Delete(IPAddr, 1, Idx);
            for n := Length(Num) + 1 to 3 do Num := ('0' + Num);
            Result := (Result + Num + '.');
          end;
        until (Idx = 0);

        Result := Copy(Result, 1, Length(Result) - 1); // Remove last '.'
      end;

    begin
      if (Adapter^.DhcpEnabled = 1) then
        DHCP := (DHCP + 'ON              - ')
      else
        DHCP := (DHCP + 'OFF             - ');

      IpAddrString := @Adapter^.IpAddressList;
      if (IpAddrString <> nil) then
      begin
        IP := (IP + CompleteIP(IpAddrString^.IpAddress.S) + ' - ');
        Submask := (Submask + CompleteIP(IpAddrString^.IpMask.S) + ' - ');
      end;

      GatewayString := @Adapter^.GatewayList;
      if (GatewayString <> nil) then
        Gateway := (Gateway + CompleteIP(GatewayString^.IpAddress.S) + ' - ');

      Size2 := 0;
      if (GetPerAdapterInfo(Adapter^.Index, nil, Size2) = ERROR_BUFFER_OVERFLOW) then
      begin
        pPerAdapterInfo := AllocMem(Size2);
        try
          GetPerAdapterInfo(Adapter^.Index, pPerAdapterInfo, Size2);

          n := 1;
          DnsServerString := @pPerAdapterInfo^.DnsServerList;
          while ((DnsServerString <> nil) and (n <= 2)) do
          begin
            if (n = 1) then DNS1 := (DNS1 + CompleteIP(DnsServerString^.IpAddress.S) + ' - ')
            else DNS2 := (DNS2 + CompleteIP(DnsServerString^.IpAddress.S) + ' - ');
            Inc(n);
            DnsServerString := DnsServerString^.Next;
          end;
          if (n = 2) then DNS2 := (DNS2 + CompleteIP('') + ' - ');
        finally
          FreeMem(pPerAdapterInfo);
        end;
      end;
    end;

    procedure RemoveLastSeparator(var Src: string);
    var
      Idx: Integer;
    begin
      Idx := (Length(Src) - 2);
      if (Copy(Src, Idx, 3) = ' - ') then Delete(Src, Idx, 3);
    end;

  begin
    IP := '';
    Submask := '';
    Gateway := '';
    DNS1 := '';
    DNS2 := '';
    Dhcp := '';

    DLL := LoadLibrary('iphlpapi.dll');
    if (DLL <> 0) then
    try
      @GetAdaptersInfo := GetProcAddress(DLL, 'GetAdaptersInfo');
      @GetPerAdapterInfo := GetProcAddress(DLL, 'GetPerAdapterInfo');
      if (Assigned(GetAdaptersInfo)) and (Assigned(GetPerAdapterInfo)) then
      begin
        Size := 0;
        if (GetAdaptersInfo(nil, Size) = ERROR_BUFFER_OVERFLOW) then
        begin
          Adapters_Start := AllocMem(Size);
          Adapters := Adapters_Start;
          try
            if (GetAdaptersInfo(Adapters, Size) = NO_ERROR) then
            begin
              while (Adapters <> nil) do
              begin
                GetAdapterInfo(Adapters);
                Adapters := (Adapters^.Next);
              end;
            end;
          finally
            FreeMem(Adapters_Start);
          end;
        end;
      end;
    finally
      FreeLibrary(DLL);
    end;
    RemoveLastSeparator(IP);
    RemoveLastSeparator(Submask);
    RemoveLastSeparator(Gateway);
    RemoveLastSeparator(DNS1);
    RemoveLastSeparator(DNS2);
    RemoveLastSeparator(DHCP);
  end;

  function GetFileVersionEx(const FileName: string): string;
  type
    Rec = packed record
      ID: Word;
      Code: Word;
    end;
    TLanguageIDs = array[0..255] of Rec;
    PLanguageIDs = ^TLanguageIDs;
  var
    dwSize, Size, Len: DWord;
    VerData, VerInfo: Pointer;
    st: string;
  begin
    Result := '';
    Len := 0;
    dwSize := GetFileVersionInfoSize(PChar(FileName), Size);
    if (dwSize > 0) then
    begin
      GetMem(VerData, dwSize);
      try
        if (GetFileVersionInfo(PChar(FileName), 0, dwSize, VerData)) then
        begin
          if (VerQueryValue(VerData, '\VarFileInfo\Translation', VerInfo, Len)) then
          begin
            st := '\\StringFileInfo\\' +
              IntToHex(PLanguageIDs(VerInfo)^[0].ID, 4) +
              IntToHex(PLanguageIDs(VerInfo)^[0].Code, 4) +
              '\\ProductVersion';
            Len := 0;
            if (VerQueryValue(VerData, PChar(St), VerInfo, Len)) and (Len > 1) then
              SetString(Result, PChar(VerInfo), StrLen(VerInfo));
          end;
        end;
      finally
        FreeMem(VerData, dwSize);
      end;
    end;
  end;

  function GetVideoCardStr: string;
  type
    TDisplayDevice2 = packed record
      cb: DWord;
      DeviceName: array[0..31] of AnsiChar;
      DeviceString: array[0..127] of AnsiChar;
      StateFlags: DWord;
      DeviceID, DeviceKey: array[0..127] of AnsiChar;
    end;
    PDisplayDevice2 = ^TDisplayDevice2;

    EnumDisplayDevicesFunc = function(Unused: Pointer; iDevNum: DWord;
      var lpDisplayDevice: TDisplayDevice2; dwFlags: DWord): Bool; stdcall;

    function OSSupportDisplayAPI: Boolean;
    begin
      Result := True;
      case Win32Platform of
        VER_PLATFORM_WIN32_WINDOWS:
          case Win32MinorVersion of
            0..9: Result := False;
          end;
        VER_PLATFORM_WIN32_NT:
          case Win32MajorVersion of
            0..4: Result := False;
          end;
      end;
    end;

    function GetIndexKeyName(Root: HKey; Key: string; Index: Integer): string;
    var
      Reg: HKey;
      Size: DWord;
    begin
      Result := '';
      if (Key <> '') and (Key[1] = '\') then Delete(Key, 1, 1);
      if (RegOpenKeyEx(Root, PChar(Key), 0, KEY_READ, Reg) = ERROR_SUCCESS) then
      begin
        SetLength(Result, 1024); // Good max size.
        Size := Length(Result);
        if (RegEnumKeyEx(Reg, Index, PChar(Result), Size, nil, nil, nil, nil) = ERROR_SUCCESS) then
          SetLength(Result, Size)
        else
          Result := '';
        RegCloseKey(Reg);
      end;
    end;

    function ReadDWordKey(Root: HKey; Key, Str: string): DWord;
    var
      Reg: HKey;
      Size: Integer;
      DataType: Integer;
    begin
      Result := 0;
      if (Key <> '') and (Key[1] = '\') then Delete(Key, 1, 1);
      if (RegOpenKeyEx(Root, PChar(Key), 0, KEY_READ, Reg) = ERROR_SUCCESS) then
      begin
        if (RegQueryValueEx(Reg, PChar(Str), nil, @DataType, nil, @Size) = 0) and (Size = 4) then
          RegQueryValueEx(Reg, PChar(Str), nil, @DataType, @Result, @Size);
        RegCloseKey(Reg);
      end;
    end;

  var
    hLib: HModule;
    EnumDisplayDevices: EnumDisplayDevicesFunc;
    DisplayDevice: TDisplayDevice2;
    RegKey, RegKey2, CurrKey, VideoID, DeviceName, DriverVersion: string;
    RAMVideo: DWord;
    Idx: Integer;
  begin
    hLib := LoadLibrary(user32);
    try
      EnumDisplayDevices := GetProcAddress(hLib, 'EnumDisplayDevicesA');
      if (@EnumDisplayDevices = nil) or (not OSSupportDisplayAPI) then // Win 95 or NT
      begin
        if (Win32Platform = VER_PLATFORM_WIN32_NT) then
        begin // Win NT
          RegKey := ReadKey(HKEY_LOCAL_MACHINE, 'Hardware\Devicemap\Video\', '\Device\Video0');
          RegKey := Copy(RegKey, Pos('\SYSTEM', UpperCase(RegKey)), Length(RegKey));
          RAMVideo := ReadDWordKey(HKEY_LOCAL_MACHINE, RegKey, 'HardwareInformation.MemorySize');
          DeviceName := ReadKey(HKEY_LOCAL_MACHINE, RegKey, 'HardwareInformation.AdapterString');
          Idx := 1; // Convert WideString to AnsiString...
          while (Idx <= Length(DeviceName)) do
          begin
            if (DeviceName[Idx] = #0) then Delete(DeviceName, Idx, 1)
            else Inc(Idx);
          end;
          RegKey := ExtractFilePath(RegKey);
          DriverVersion := GetFileVersionEx(ReadKey(HKEY_LOCAL_MACHINE, RegKey, 'ImagePath'));
        end
        else
        begin // Win 95
          RegKey2 := '0000';
          RegKey := 'System\CurrentControlSet\Services\Class\Display\';
          Idx := 0;
          repeat
            CurrKey := GetIndexKeyName(HKEY_LOCAL_MACHINE, RegKey, Idx);
            if (CurrKey <> '') then // Search the last SubKey...
            begin
              RegKey2 := CurrKey;
              Inc(Idx);
            end;
          until (CurrKey = '');
          RegKey := (RegKey + RegKey2);
          DeviceName := ReadKey(HKEY_LOCAL_MACHINE, RegKey, 'DriverDesc');
          DriverVersion := ReadKey(HKEY_LOCAL_MACHINE, RegKey, 'Ver');
          RAMVideo := ReadDWordKey(HKEY_LOCAL_MACHINE, RegKey + '\INFO', 'VideoMemory');
        end;
      end
      else
      begin
        FillChar(DisplayDevice, SizeOf(DisplayDevice), 0);
        DisplayDevice.cb := SizeOf(DisplayDevice);
        EnumDisplayDevices(nil, 0, PDisplayDevice2(@DisplayDevice)^, 0);
        DeviceName := DisplayDevice.DeviceString;
        if (Win32Platform = VER_PLATFORM_WIN32_NT) then
        begin // Win NT
          RegKey := ('System\CurrentControlSet\Enum\' + DisplayDevice.DeviceID);
          RegKey := (RegKey + '\' + GetIndexKeyName(HKEY_LOCAL_MACHINE, RegKey, 0));
          VideoID := ReadKey(HKEY_LOCAL_MACHINE, RegKey + '\Device Parameters', 'VideoID');
          if (VideoID <> '') then
          begin
            RegKey2 := ('System\CurrentControlSet\Control\Video\' + VideoID + '\0000');
            RAMVideo := ReadDWordKey(HKEY_LOCAL_MACHINE, RegKey2, 'HardwareInformation.MemorySize');
          end
          else
          begin
            RegKey2 := ReadKey(HKEY_LOCAL_MACHINE, 'Hardware\Devicemap\Video\', '\Device\Video0');
            RegKey2 := Copy(RegKey2, Pos('\SYSTEM', UpperCase(RegKey2)), Length(RegKey2));
            RAMVideo := ReadDWordKey(HKEY_LOCAL_MACHINE, RegKey2, 'HardwareInformation.MemorySize');
          end;
          RegKey := ('System\CurrentControlSet\Control\Class\' +
            ReadKey(HKEY_LOCAL_MACHINE, RegKey, 'Driver'));
          DriverVersion := ReadKey(HKEY_LOCAL_MACHINE, RegKey, 'DriverVersion');
        end
        else // Win 9X
        begin
          DriverVersion := ReadKey(HKEY_LOCAL_MACHINE, DisplayDevice.DeviceKey, 'Ver');
          RAMVideo := ReadDWordKey(HKEY_LOCAL_MACHINE, DisplayDevice.DeviceKey + '\INFO',
            'VideoMemory');
        end;
      end;
      Result := (Trim(DeviceName) + ' (driver ' + DriverVersion + ' - RAM ' +
        IntToStr(RAMVideo div (1024 * 1024)) + ' MB)');
    finally
      FreeLibrary(hLib);
    end;
  end;

  function GetDisplayDPI: string;
  var
    DC: HDC;
  begin
    DC := GetDC(0);
    try
      Result := IntToStr(GetDeviceCaps(DC, LOGPIXELSY));
    finally
      ReleaseDC(0, DC);
    end;
  end;

  function GetCurrentUserPrivileges: string;
  type
    TPrivilegesArray = array[0..1024] of TLuidAndAttributes;
    PPrivilegesArray = ^TPrivilegesArray;
  var
    TokenHandle: THandle;
    Size: DWord;
    Privileges: PTokenPrivileges;
    I: Integer;
    Luid: TLargeInteger;
    Name: string;
    Attr: DWord;

    function AttrToString: string;
    begin
      Result := '';
      if (Attr and SE_PRIVILEGE_ENABLED) <> 0 then
        Result := Result + ' - ON'
      else
        Result := Result + ' - OFF';
    end;

    function CompleteString(const Src: string; Len: Integer): string;
    var
      n: Integer;
    begin
      Result := Src;
      for n := Length(Src) + 1 to Len do
        Result := (Result + ' ');
    end;

  begin
    Result := '';
    if (OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, TokenHandle)) then
    try
      GetTokenInformation(TokenHandle, TokenPrivileges, nil, 0, Size);
      GetMem(Privileges, Size);
      try
        if (GetTokenInformation(TokenHandle, TokenPrivileges, Privileges, Size, Size)) then
        begin
          for I := 0 to Privileges.PrivilegeCount - 1 do
          begin
            Luid := PPrivilegesArray(@Privileges^.Privileges)^[I].Luid;
            Attr := PPrivilegesArray(@Privileges^.Privileges)^[I].Attributes;
            Size := 0;
            LookupPrivilegeName(nil, Luid, nil, Size);
            SetLength(Name, Size); // Get the required size (included the #0 final char).
            LookupPrivilegeName(nil, Luid, PChar(Name), Size);
            SetLength(Name, Size); // Set the real size (without the final #0 char).
            Result := (Result + CompleteString(Name, 31) + AttrToString + #13#10);
          end;
        end;
      finally
        FreeMem(Privileges);
      end;
    finally
      CloseHandle(TokenHandle);
    end;
  end;

  function GetUserEmail: string;
  begin
    Result := UserEmail;
  end;

  function GetCompanyName: string;
  begin
    Result := ReadKey(HKEY_LOCAL_MACHINE, '\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION',
      'RegisteredOrganization');
    if (Result = '') then
      Result := ReadKey(HKEY_LOCAL_MACHINE, '\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION',
        'RegisteredOrganization');
    if (Result = '') then
      Result := ReadKey(HKEY_LOCAL_MACHINE, '\SOFTWARE\MICROSOFT\MS SETUP (ACME)\USER INFO',
        'DefCompany');
  end;

  function GetPrinterStr: string;
  const
    iLevel: Integer = 2;
  var
    lpDriverInfo: ^TDriverInfo2;
    i: DWord;
    hPrn: THandle;

    function GetCurrentPrinterHandle: THandle;
    var
      PrinterDevice: string;

      function GetDefaultPrinter: string;
      var
        ByteCnt, StructCnt: DWord;
        DefaultPrinter: array[0..1023] of Char;
        Cur: PChar;
        PrinterInfo: PPrinterInfo5;

        function FetchStr(var Str: PChar): PChar;
        var
          P: PChar;
        begin
          Result := Str;
          if Str = nil then Exit;
          P := Str;
          while P^ = ' ' do
            Inc(P);
          Result := P;
          while (P^ <> #0) and (P^ <> ',') do
            Inc(P);
          if P^ = ',' then
          begin
            P^ := #0;
            Inc(P);
          end;
          Str := P;
        end;

      begin
        Result := '';
        ByteCnt := 0;
        StructCnt := 0;
        if (not EnumPrinters(PRINTER_ENUM_DEFAULT, nil, 5, nil, 0, ByteCnt,
          StructCnt) and (GetLastError <> ERROR_INSUFFICIENT_BUFFER)) then Exit;

        PrinterInfo := AllocMem(ByteCnt);
        try
          EnumPrinters(PRINTER_ENUM_DEFAULT, nil, 5, PrinterInfo, ByteCnt,
            ByteCnt, StructCnt);
          if (StructCnt > 0) then
            Result := PrinterInfo.pPrinterName
          else
          begin
            GetProfileString('windows', 'device', '', DefaultPrinter,
              SizeOf(DefaultPrinter) - 1);
            Cur := DefaultPrinter;
            Result := FetchStr(Cur);
          end;
        finally
          FreeMem(PrinterInfo);
        end;
      end;

    begin
      Result := 0;
      PrinterDevice := GetDefaultPrinter;
      if (PrinterDevice <> '') then OpenPrinter(PChar(PrinterDevice), Result, nil);
    end;

  begin
    Result := '';
    hPrn := GetCurrentPrinterHandle;
    if (hPrn = 0) then Exit;

    i := 0;
    try
      GetPrinterDriver(hPrn, nil, iLevel, nil, 0, i);
      lpDriverInfo := AllocMem(i);
      try
        if GetPrinterDriver(hPrn, nil, iLevel, lpDriverInfo, i, i) then
          Result := (lpDriverInfo^.pName + ' (driver ' +
            GetFileVersionEx(lpDriverInfo^.pDriverPath) + ')');
      finally
        FreeMem(lpDriverInfo);
      end;
    finally
      ClosePrinter(hPrn);
    end;
  end;

  function MaxLen(const Data: array of string): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := Low(Data) + 1 to High(Data) do
      if Result < length(Data[I]) then
        Result := length(Data[I]);
  end;

  procedure FormatComplete(var Log: string; var Idx: Integer;
    const StrArgs: array of string; const LenArgs: array of integer);
  var
    n, i: Integer;
  begin
    for n := Low(StrArgs) to High(StrArgs) do
    begin
      Log[Idx] := '|';
      Inc(Idx);
      for i := 0 to Length(StrArgs[n]) - 1 do
        Log[Idx + i] := StrArgs[n][i + 1];
      Inc(Idx, LenArgs[n]);
    end;
    Log[Idx] := '|';
    Log[Idx + 1] := #13;
    Log[Idx + 2] := #10;
    Inc(Idx, 3);
  end;

  procedure SaveLogFile;

    procedure CallExceptionActionNotify_atSavingLogFile;
    begin
      CallModuleEvent_ExceptionActionNotify(
        Global_ExceptionRecord, atSavingLogFile, Global_Execute);
      CallExceptionActionNotify(
        Global_ExceptionRecord, atSavingLogFile, Global_Execute);
    end;

    procedure CallExceptionActionNotify_atSavedLogFile;
    begin
      CallModuleEvent_ExceptionActionNotify(
        Global_ExceptionRecord, atSavedLogFile, Global_Execute);
      CallExceptionActionNotify(
        Global_ExceptionRecord, atSavedLogFile, Global_Execute);
    end;

    procedure CallExceptionErrorNotify_atSavedLogFile;
    begin
      CallModuleEvent_ExceptionErrorNotify(
        Global_ExceptionRecord, atSavedLogFile, Global_Retry);
      CallExceptionErrorNotify(
        Global_ExceptionRecord, atSavedLogFile, Global_Retry);
    end;

  begin // SaveLogFile
    Global_Execute := True;
    ClearInternalError;

    if (CurrentOptions.SaveLogFile) then
      SynchronizeEvent(@CallExceptionActionNotify_atSavingLogFile);

    repeat
      ClearInternalError;
      try
{$IFDEF EUREKALOG_PROFILER}
        mSecOpenLog := GetTickCount;
{$ENDIF}
        OpenLogFile;
{$IFDEF EUREKALOG_PROFILER}
        mSecOpenLog := (GetTickCount - mSecOpenLog);
{$ENDIF}
        if (not DuplicatedException) then
        begin
{$IFDEF EUREKALOG_PROFILER}
          mSecSaveLog := GetTickCount;
{$ENDIF}
          Cached_LogFile.Append(LastExceptionLog, CurrentOptions.ErrorsNumberToSave);
          if (sndSendEntireLog in CurrentOptions.CommonSendOptions) then
            LastLog := Cached_LogFile.Text;
          if (Global_Execute) and
            (CurrentOptions.SaveLogFile) then Cached_LogFile.Save;
{$IFDEF EUREKALOG_PROFILER}
          mSecSaveLog := (GetTickCount - mSecSaveLog);
{$ENDIF}
        end;
      except
        SetErrorType(eeLogError, 'Log');
        Global_Execute := False;
      end;

      Global_Retry := False;
      if (CurrentOptions.SaveLogFile) and (not Global_Execute) then
        SynchronizeEvent(@CallExceptionErrorNotify_atSavedLogFile);

    until (not Global_Retry);

    CloseLogFile;

    if (CurrentOptions.SaveLogFile) then
      SynchronizeEvent(@CallExceptionActionNotify_atSavedLogFile);
  end;

  function FindException: integer;
  var
    n: integer;

    function IsCompatibleException: Boolean;
    begin
      Result := ((CurrentOptions.ExceptionsFilters[n]^.ExceptionType = fetAll) or
        ((CurrentOptions.ExceptionsFilters[n]^.ExceptionType = fetHandled) and (Params.Handled)) or
        ((CurrentOptions.ExceptionsFilters[n]^.ExceptionType = fetUnhandled) and (not Params.Handled)))
        and (IsAParentStr(Obj, CurrentOptions.ExceptionsFilters[n]^.ExceptionClassName));
    end;

  begin
    Result := -1;
    for n := 0 to (CurrentOptions.ExceptionsFilters.Count - 1) do
    begin
      if ((CurrentOptions.ExceptionsFilters[n]^.Active) and (IsCompatibleException)) then
      begin
        Result := n;
        Break;
      end;
    end;
  end;

  procedure CallExceptionActionNotify_atShowingExceptionInfo;
  begin
    CallModuleEvent_ExceptionActionNotify(
      Global_ExceptionRecord, atShowingExceptionInfo, Global_Execute);
    CallExceptionActionNotify(
      Global_ExceptionRecord, atShowingExceptionInfo, Global_Execute);
  end;

  procedure CallExceptionActionNotify_atShowedExceptionInfo;
  begin
    CallModuleEvent_ExceptionActionNotify(
      Global_ExceptionRecord, atShowedExceptionInfo, Global_Execute);
    CallExceptionActionNotify(
      Global_ExceptionRecord, atShowedExceptionInfo, Global_Execute);
  end;

  procedure CallWriteIntraWebText;
  begin
    Global_Execute := WriteTextToIntraWeb;
  end;

  procedure CreateGeneralText;
  var
    Item: TLogItem;
    IP, Submask, Gateway, DNS1, DNS2, DHCP: string;
  begin
    GetNetworkData(IP, Submask, Gateway, DNS1, DNS2, DHCP);
    DbgSection := 702200;
    with CurrentOptions do
    begin
      Item := TLogItem.Create(0);
      try
        Item.AddHeader(CustomizedExpandedTexts[mtLog_AppHeader]);
        DbgSection := 7022000;
        Item.AddItem(CustomizedExpandedTexts[mtLog_AppStartDate], GetStartDate,
          (soAppStartDate in CurrentOptions.ShowOptions));
        DbgSection := 702201;
        Item.AddItem(CustomizedExpandedTexts[mtLog_AppName], GetApplicationName,
          (soAppName in CurrentOptions.ShowOptions));
        DbgSection := 702202;
        Item.AddItem(CustomizedExpandedTexts[mtLog_AppVersionNumber], GetVersionNumber,
          (soAppVersionNumber in CurrentOptions.ShowOptions));
        DbgSection := 702203;
        Item.AddItem(CustomizedExpandedTexts[mtLog_AppParameters], GetParameters,
          (soAppParameters in CurrentOptions.ShowOptions));
        DbgSection := 702204;
        Item.AddItem(CustomizedExpandedTexts[mtLog_AppCompilationDate], GetCompilationDate,
          (soAppCompilationDate in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_AppUpTime], GetApplicationUpTime,
          (soAppUpTime in CurrentOptions.ShowOptions));
        DbgSection := 702205;
        Item.AddHeader(CustomizedExpandedTexts[mtLog_ExcHeader]);
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcDate], GetExceptionDate,
          (soExcDate in CurrentOptions.ShowOptions));
        DbgSection := 702206;
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcAddress], GetExceptionAddress,
          (soExcAddress in CurrentOptions.ShowOptions));
        DbgSection := 702207;
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcModuleName], GetExceptionModuleName,
          (soExcModuleName in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcModuleVersion], GetExceptionModuleVersion,
          (soExcModuleVersion in CurrentOptions.ShowOptions));
        DbgSection := 702208;
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcType], GetExceptionType,
          (soExcType in CurrentOptions.ShowOptions));
        DbgSection := 702209;
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcMessage], GetExceptionMessage,
          (soExcMessage in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcID], LastBugID,
          (soExcID in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcCount], '1',
          (soExcCount in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcStatus], 'New',
          (soExcStatus in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_ExcNote], '',
          (soExcNote in CurrentOptions.ShowOptions));

        Item.AddHeader(CustomizedExpandedTexts[mtLog_UserHeader]);
        Item.AddItem(CustomizedExpandedTexts[mtLog_UserID], UserName,
          (soUserID in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_UserName], UserFullName,
          (soUserName in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_UserEmail], GetUserEmail,
          (soUserEmail in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_UserCompany], GetCompanyName,
          (soUserCompany in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_UserPrivileges], GetCurrentUserPrivileges,
          (soUserPrivileges in CurrentOptions.ShowOptions));

        DbgSection := 7022091;
        Item.AddHeader(CustomizedExpandedTexts[mtLog_ActCtrlsHeader]);
        Item.AddItem(CustomizedExpandedTexts[mtLog_ActCtrlsFormClass],
          GetActiveFormClass,
          (soActCtlsFormClass in CurrentOptions.ShowOptions) and
          not ((IsWeb) or (IsConsole)));
        DbgSection := 702210;
        Item.AddItem(CustomizedExpandedTexts[mtLog_ActCtrlsFormText], GetActiveFormText,
          (soActCtlsFormText in CurrentOptions.ShowOptions) and
          not ((IsWeb) or (IsConsole)));
        DbgSection := 702211;
        Item.AddItem(CustomizedExpandedTexts[mtLog_ActCtrlsControlClass],
          GetActiveControlClass,
          (soActCtlsControlClass in CurrentOptions.ShowOptions) and
          not ((IsWeb) or (IsConsole)));
        DbgSection := 702212;
        Item.AddItem(CustomizedExpandedTexts[mtLog_ActCtrlsControlText],
          GetActiveControlText,
          (soActCtlsControlText in CurrentOptions.ShowOptions) and
          not ((IsWeb) or (IsConsole)));
        DbgSection := 702213;
        Item.AddHeader(CustomizedExpandedTexts[mtLog_CmpHeader]);
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpName], ComputerName,
          (soCmpName in CurrentOptions.ShowOptions));
        DbgSection := 702214;
        DbgSection := 702215;
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpTotalMemory], GetTotalMemory,
          (soCmpTotalMemory in CurrentOptions.ShowOptions));
        DbgSection := 702216;
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpFreeMemory], GetFreeMemory,
          (soCmpFreeMemory in CurrentOptions.ShowOptions));
        DbgSection := 702217;
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpTotalDisk], GetTotalDisk,
          (soCmpTotalDisk in CurrentOptions.ShowOptions));
        DbgSection := 702218;
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpFreeDisk], GetFreeDisk,
          (soCmpFreeDisk in CurrentOptions.ShowOptions));
        DbgSection := 702219;
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpSystemUpTime], GetSystemUpTime,
          (soCmpSysUpTime in CurrentOptions.ShowOptions));
        DbgSection := 702220;
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpProcessor], GetProcessor,
          (soCmpProcessor in CurrentOptions.ShowOptions));
        DbgSection := 702221;
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpDisplayMode], GetDisplayMode,
          (soCmpDisplayMode in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpDisplayDPI], GetDisplayDPI,
          (soCmpDisplayDPI in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpVideoCard], GetVideoCardStr,
          (soCmpVideoCard in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_CmpPrinter], GetPrinterStr,
          (soCmpPrinter in CurrentOptions.ShowOptions));
        DbgSection := 702222;
        Item.AddHeader(CustomizedExpandedTexts[mtLog_OSHeader]);
        Item.AddItem(CustomizedExpandedTexts[mtLog_OSType], GetOSType,
          (soOSType in CurrentOptions.ShowOptions));
        DbgSection := 702223;
        Item.AddItem(CustomizedExpandedTexts[mtLog_OSBuildN], GetOSBuild,
          (soOSBuildN in CurrentOptions.ShowOptions));
        DbgSection := 702224;
        Item.AddItem(CustomizedExpandedTexts[mtLog_OSUpdate], GetOSUpdate,
          (soOSUpdate in CurrentOptions.ShowOptions));
        DbgSection := 702225;
        Item.AddItem(CustomizedExpandedTexts[mtLog_OSLanguage], GetOSLanguage,
          (soOSLanguage in CurrentOptions.ShowOptions));
        Item.AddItem(CustomizedExpandedTexts[mtLog_OSCharset], GetOSCharset,
          (soOSCharset in CurrentOptions.ShowOptions));
        DbgSection := 702226;
        Item.AddHeader(CustomizedExpandedTexts[mtLog_NetHeader]);
        Item.AddItem(CustomizedExpandedTexts[mtLog_NetIP], IP,
          (soNetIP in CurrentOptions.ShowOptions));
        DbgSection := 702227;
        Item.AddItem(CustomizedExpandedTexts[mtLog_NetSubmask], Submask,
          (soNetSubmask in CurrentOptions.ShowOptions));
        DbgSection := 702228;
        Item.AddItem(CustomizedExpandedTexts[mtLog_NetGateway], Gateway,
          (soNetGateway in CurrentOptions.ShowOptions));
        DbgSection := 702229;
        Item.AddItem(CustomizedExpandedTexts[mtLog_NetDNS1], DNS1,
          (soNetDNS1 in CurrentOptions.ShowOptions));
        DbgSection := 702230;
        Item.AddItem(CustomizedExpandedTexts[mtLog_NetDNS2], DNS2,
          (soNetDNS2 in CurrentOptions.ShowOptions));
        DbgSection := 702231;
        Item.AddItem(CustomizedExpandedTexts[mtLog_NetDHCP], DHCP,
          (soNetDHCP in CurrentOptions.ShowOptions));
        DbgSection := 702232;
        CurrentGeneralErrorText := 'EurekaLog ' + EurekaLogVersion +
          #13#10#13#10 + Item.Value;
        DbgSection := 702233;
      finally
        Item.Free;
      end;
    end;
  end;

  procedure CreateLogText;
  const
    NoRegValue = '????    ';
  var
    i: Integer;

    function GetEAX: string;
    begin
      if (Params.Context <> nil) then
        Result := IntToHex(Params.Context.Eax, 8)
      else
        Result := NoRegValue;
    end;

    function GetEBX: string;
    begin
      if (Params.Context <> nil) then
        Result := IntToHex(Params.Context.Ebx, 8)
      else
        Result := NoRegValue;
    end;

    function GetECX: string;
    begin
      if (Params.Context <> nil) then
        Result := IntToHex(Params.Context.Ecx, 8)
      else
        Result := NoRegValue;
    end;

    function GetEDX: string;
    begin
      if (Params.Context <> nil) then
        Result := IntToHex(Params.Context.Edx, 8)
      else
        Result := NoRegValue;
    end;

    function GetESI: string;
    begin
      if (Params.Context <> nil) then
        Result := IntToHex(Params.Context.Esi, 8)
      else
        Result := NoRegValue;
    end;

    function GetEDI: string;
    begin
      if (Params.Context <> nil) then
        Result := IntToHex(Params.Context.Edi, 8)
      else
        Result := NoRegValue;
    end;

    function GetESP: string;
    begin
      if (Params.Context <> nil) then
        Result := IntToHex(Params.Context.Esp, 8)
      else
        Result := NoRegValue;
    end;

    function GetEIP: string;
    begin
      if (Params.Context <> nil) then
        Result := IntToHex(Params.Context.Eip, 8)
      else
        Result := NoRegValue;
    end;

    function GetDump: string;
    var
      row, col: integer;
      Stack: PDWord;
      Mem: PByte;
      c: Char;
    begin
      Stack := PDWord(Params.StackPoint);
      Mem := PByte(Addr);
      Result := '';
      if (not IsValidBlockAddr(DWord(Stack), 4 * 16)) or
        (not IsValidBlockAddr(DWord(Mem), 256)) then Exit;

      for row := 0 to 15 do
      begin
        Result := Result + Format(
          '%s: %s   %s: ', [IntToHex(DWord(Stack), 8),
          IntToHex(Stack^, 8), IntToHex(DWord(Mem), 8)]);
        Inc(Stack);
        for col := 0 to 15 do
        begin
          Result := Result + IntToHex(Mem^, 2) + ' ';
          Inc(Mem);
        end;
        Result := Result + ' ';
        Dec(Mem, 16);
        for col := 0 to 15 do
        begin
          if ((Mem^ >= 32) and (Mem^ <= 126)) then
            c := chr(Mem^)
          else
            c := '.';
          Result := Result + c;
          Inc(Mem);
        end;
        Result := Result + #13#10;
      end;
    end;

    function GetStack: string;
    var
      n: integer;
    begin
      Result := CurrentOptions.CustomizedExpandedTexts[mtCPU_Stack] + ':';
      for n := length(Result) to 20 do
        Result := Result + ' ';
    end;

    function GetEmptySection(const Value: string): string;
    var
      Line: string;
      n: Integer;
    begin
      Line := '';
      for n := 1 to Length(Value) + 1 do Line := (Line + '-');
      Result := Value + ':'#13#10 + Line + #13#10#13#10;
    end;

  begin
{$IFDEF EUREKALOG_PROFILER}
    mSecCreateLog := GetTickCount;
{$ENDIF}
    DbgSection := 7021;
    HeaderText := CurrentOptions.CustomizedExpandedTexts[mtDialog_ErrorMsgCaption] +
      #13#10#13#10;
    CurrentGeneralErrorText := '';
    DetailErrorText := '';
    CurrentCPUErrorText := '';
    CurrentAsmErrorText := '';
    CurrentAsmErrorLine := '';

    DbgSection := 7022;
    CreateGeneralText;

    if (loSaveAssemblerAndCPUSections in CurrentOptions.LogOptions) then
    begin
      CurrentAsmErrorText := GetFunctionAsm(Addr);

      CurrentCPUErrorText :=
        Format(
        '%s:'#13#10 +
        '-----------------------------'#13#10 +
        'EAX: %s   EDI: %s'#13#10 +
        'EBX: %s   ESI: %s'#13#10 +
        'ECX: %s   ESP: %s'#13#10 +
        'EDX: %s   EIP: %s'#13#10 +
        ''#13#10 +
        '%s%s:'#13#10 +
        '------------------   --------------------------------' +
        '-------------------------------------------'#13#10'%s',
        [CurrentOptions.CustomizedExpandedTexts[mtCPU_Registers], GetEAX, GetEDI,
        GetEBX, GetESI, GetECX, GetESP, GetEDX, GetEIP, GetStack,
          CurrentOptions.CustomizedExpandedTexts[mtCPU_MemoryDump], GetDump]);
    end
    else
    begin
      CurrentAsmErrorLine :=
        (CurrentOptions.CustomizedExpandedTexts[mtDialog_AsmHeader] + ':' + #13#10);
      for i := 1 to (Length(CurrentOptions.CustomizedExpandedTexts[mtDialog_AsmHeader]) + 1) do
        CurrentAsmErrorLine := (CurrentAsmErrorLine + '-');

      CurrentCPUErrorText := GetEmptySection(CurrentOptions.CustomizedExpandedTexts[mtCPU_Registers]);
    end;

    MaxAddr := Length(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Address]);
    if (MaxAddr < 8) then MaxAddr := 8;
    MaxModule := length(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Name]);
    MaxUnit := length(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Unit]);
    MaxClass := length(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Class]);
    MaxProc := length(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Procedure]);
    MaxLine := length(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Line]);

    if (CurrentStackList <> nil) then
      for i := 0 to CurrentStackList.Count - 1 do
        if (CurrentStackList[i]^.DebugDetail in GetDebugDetail(CurrentOptions)) then
        begin
          ln := IntToStr(CurrentStackList[i]^.Line);
          if (ln = '0') then ln := ''
          else
          begin
            ln := ln + '[' + (IntToStr(CurrentStackList[i]^.ProcOffsetLine)) + ']';
          end;
          if (CurrentStackList[i]^.DebugDetail <> ddNone) then
            ModName := ExtractFileName(CurrentStackList[i]^.ModuleInfo^.Name)
          else
            ModName := '';
          if (length(ModName) > MaxModule) then
            MaxModule := length(ModName);
          if (length(CurrentStackList[i]^.UnitName) > MaxUnit) then
            MaxUnit := length(CurrentStackList[i]^.UnitName);
          if (length(CurrentStackList[i]^.ClassName) > MaxClass) then
            MaxClass := length(CurrentStackList[i]^.ClassName);
          if (length(CurrentStackList[i]^.ProcedureName) > MaxProc) then
            MaxProc := length(CurrentStackList[i]^.ProcedureName);
          if (length(ln) > MaxLine) then
            MaxLine := length(ln);
        end;

    DbgSection := 7027;
    LineStr := '';
    for i := 1 to (MaxAddr + MaxModule + MaxUnit + MaxClass + MaxProc + MaxLine + 7) do
      LineStr := LineStr + '-';

    DbgSection := 7028;
    DetailErrorText :=
      CurrentOptions.CustomizedExpandedTexts[mtDialog_CallStackHeader] + ':' + #13#10 +
      LineStr + #13#10 + Format('|%s|%s|%s|%s|%s|%s|',
      [CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Address], MaxAddr),
      CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Name], MaxModule),
        CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Unit], MaxUnit),
        CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Class], MaxClass),
        CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Procedure], MaxProc),
        CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtCallStack_Line], MaxLine)]) +
      #13#10 + LineStr;

    DbgSection := 7029;
    if (CurrentStackList <> nil) then
    begin
      LineSize := (MaxAddr + MaxModule + MaxUnit + MaxClass + MaxProc + MaxLine + 9);
      ThreadLineStr := '';
      for i := 1 to (LineSize - 4) do ThreadLineStr := (ThreadLineStr + '-');

      SetLength(LogStr, ((CurrentStackList.Count * LineSize) +
        (LocalThreadsList.Count * LineSize * 7)));
      DbgSection := 7030;
      FillChar(Pointer(LogStr)^, Length(LogStr), #32);
      LogIdx := 1;
      LastUsedThreadID := 0;
      RunningThread := False;
      ErrorLine := False;
      FirstLine := True;
      DbgSection := 7031;
      for i := 0 to CurrentStackList.Count - 1 do
        if (CurrentStackList[i]^.DebugDetail in GetDebugDetail(CurrentOptions)) then
        begin
          DbgSection := 7032;
          if ((LastUsedThreadID <> CurrentStackList[i]^.ThreadID) or (FirstLine) or
            (RunningThread <> CurrentStackList[i]^.RunningThread)) or
            (CurrentStackList[i]^.ErrorLine = True) then
          begin
            DbgSection := 7033;
            if ((CurrentStackList[i]^.RunningThread) and (not FirstLine)) then
            begin
              FormatComplete(LogStr, LogIdx, [ThreadLineStr], [Length(ThreadLineStr)]);
              FormatComplete(LogStr, LogIdx, [''], [LineSize - 4]);
            end
            else
              if (not FirstLine) then
                FormatComplete(LogStr, LogIdx, [ThreadLineStr], [Length(ThreadLineStr)]);
            DbgSection := 7034;
            ThreadStr := CreateThreadStr(i, CurrentStackList[i], True);
            DbgSection := 7035;
            FormatComplete(LogStr, LogIdx, [ThreadStr], [LineSize - 4]);
            FormatComplete(LogStr, LogIdx, [ThreadLineStr], [Length(ThreadLineStr)]);
            DbgSection := 7036;
          end;
          LastUsedThreadID := CurrentStackList[i]^.ThreadID;
          RunningThread := CurrentStackList[i]^.RunningThread;
          ErrorLine := CurrentStackList[i]^.ErrorLine;
          ln := IntToStr(CurrentStackList[i]^.Line);
          if (ln = '0') then ln := ''
          else
          begin
            ln := ln + '[' + (IntToStr(CurrentStackList[i]^.ProcOffsetLine)) + ']';
          end;
          DbgSection := 7037;
          if (CurrentStackList[i]^.DebugDetail <> ddNone) then
            ModName := ExtractFileName(CurrentStackList[i]^.ModuleInfo^.Name)
          else
            ModName := '';
          DbgSection := 7038;
          FormatComplete(LogStr, LogIdx,
            [IntToHex(CurrentStackList[i]^.Addr, 8), ModName,
            CurrentStackList[i]^.UnitName, CurrentStackList[i]^.ClassName,
              CurrentStackList[i]^.ProcedureName, ln],
              [MaxAddr, MaxModule, MaxUnit, MaxClass, MaxProc, MaxLine]);
          FirstLine := False;
          DbgSection := 7039;
        end;
      SetLength(LogStr, LogIdx - 1);
      DetailErrorText := (DetailErrorText + #13#10 + LogStr);
      DbgSection := 7040;
    end;

    DetailErrorText := (DetailErrorText + LineStr + #13#10 + #13#10);

    if (loSaveModulesAndProcessesSections in CurrentOptions.LogOptions) then
    begin
      // Modules List...
      DetailErrorText := (DetailErrorText +
        CurrentOptions.CustomizedExpandedTexts[mtDialog_ModulesHeader] + ':' + #13#10);

      MaxModHandle := length(CurrentOptions.CustomizedExpandedTexts[mtModules_Handle]);
      if (MaxModHandle < 8) then MaxModHandle := 8;
      MaxModName := length(CurrentOptions.CustomizedExpandedTexts[mtModules_Name]);
      MaxModDesc := length(CurrentOptions.CustomizedExpandedTexts[mtModules_Description]);
      MaxModVer := length(CurrentOptions.CustomizedExpandedTexts[mtModules_Version]);
      MaxModSize := length(CurrentOptions.CustomizedExpandedTexts[mtModules_Size]);
      MaxModPath := length(CurrentOptions.CustomizedExpandedTexts[mtModules_Path]);
      MaxModModified := length(CurrentOptions.CustomizedExpandedTexts[mtModules_LastModified]);

      for i := 0 to ModulesList.Count - 1 do
      begin
        if (length(ExtractFileName(ModulesList[i]^.Name)) > MaxModName) then
          MaxModName := length(ExtractFileName(ModulesList[i]^.Name));
        if (length(ModulesList[i]^.Description) > MaxModDesc) then
          MaxModDesc := length(ModulesList[i]^.Description);
        if (length(ModulesList[i]^.Version) > MaxModVer) then
          MaxModVer := length(ModulesList[i]^.Version);
        if (length(IntToStr(ModulesList[i]^.Size)) > MaxModSize) then
          MaxModSize := length(IntToStr(ModulesList[i]^.Size));
        if (length(GetModulePath(ModulesList[i]^.Name)) > MaxModPath) then
          MaxModPath := length(GetModulePath(ModulesList[i]^.Name));
        if (length(ISODateTime(ModulesList[i]^.LastModified)) > MaxModModified) then
          MaxModModified := length(ISODateTime(ModulesList[i]^.LastModified));
      end;

      LineStr := '';
      for i := 1 to (MaxModHandle + MaxModName + MaxModDesc + MaxModVer +
        MaxModSize + MaxModPath + MaxModModified + 8) do LineStr := LineStr + '-';

      DetailErrorText := DetailErrorText +
        LineStr + #13#10 + Format('|%s|%s|%s|%s|%s|%s|%s|',
        [CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtModules_Handle], MaxModHandle),
        CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtModules_Name], MaxModName),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtModules_Description],
          MaxModDesc),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtModules_Version],
          MaxModVer),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtModules_Size], MaxModSize),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtModules_LastModified],
          MaxModModified),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtModules_Path], MaxModPath)]) +
        #13#10 + LineStr;

      LineSize := (MaxModHandle + MaxModName + MaxModDesc +
        MaxModVer + MaxModSize + MaxModPath + MaxModModified + 10);
      SetLength(LogStr, ModulesList.Count * LineSize);
      FillChar(Pointer(LogStr)^, Length(LogStr), #32);
      LogIdx := 1;
      for i := 0 to ModulesList.Count - 1 do
      begin
        FormatComplete(LogStr, LogIdx,
          [IntToHex(ModulesList[i]^.Handle, MaxModHandle),
          ExtractFileName(ModulesList[i]^.Name),
            ModulesList[i]^.Description, ModulesList[i]^.Version,
            IntToStr(ModulesList[i]^.Size),
            ISODateTime(ModulesList[i]^.LastModified),
            GetModulePath(ModulesList[i]^.Name)],
            [MaxModHandle, MaxModName, MaxModDesc, MaxModVer,
          MaxModSize, MaxModModified, MaxModPath]);
      end;
      SetLength(LogStr, LogIdx - 1);
      DetailErrorText := DetailErrorText + #13#10 + LogStr + LineStr + #13#10#13#10;

      // Processes List...
      DetailErrorText := (DetailErrorText +
        CurrentOptions.CustomizedExpandedTexts[mtDialog_ProcessesHeader] + ':' + #13#10);

      MaxProID := length(CurrentOptions.CustomizedExpandedTexts[mtProcesses_ID]);
      MaxProName := length(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Name]);
      MaxProDesc := length(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Description]);
      MaxProVer := length(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Version]);
      MaxProMemory := length(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Memory]);
      MaxProPriority := length(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Priority]);
      MaxProThreads := length(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Threads]);
      MaxProPath := length(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Path]);

      for i := 0 to ProcessesList.Count - 1 do
      begin
        if (length(IntToStr(ProcessesList[i]^.ProcessID)) > MaxProID) then
          MaxProID := length(IntToStr(ProcessesList[i]^.ProcessID));
        if (length(ExtractFileName(ProcessesList[i]^.Name)) > MaxProName) then
          MaxProName := length(ExtractFileName(ProcessesList[i]^.Name));
        if (length(ProcessesList[i]^.Description) > MaxProDesc) then
          MaxProDesc := length(ProcessesList[i]^.Description);
        if (length(ProcessesList[i]^.Version) > MaxProVer) then
          MaxProVer := length(ProcessesList[i]^.Version);
        if (length(IntToStr(ProcessesList[i]^.Memory)) > MaxProMemory) then
          MaxProMemory := length(IntToStr(ProcessesList[i]^.Memory));
        if (length(PriorityToString(ProcessesList[i]^.Priority)) > MaxProPriority) then
          MaxProPriority := length(PriorityToString(ProcessesList[i]^.Priority));
        if (length(GetProcessThreads(ProcessesList[i]^.Threads)) > MaxProThreads) then
          MaxProThreads := length(GetProcessThreads(ProcessesList[i]^.Threads));
        if (length(GetModulePath(ProcessesList[i]^.Name)) > MaxProPath) then
          MaxProPath := length(GetModulePath(ProcessesList[i]^.Name));
      end;

      LineStr := '';
      for i := 1 to (MaxProID + MaxProName + MaxProDesc + MaxProVer +
        MaxProMemory + MaxProPriority + MaxProThreads + MaxProPath + 9) do LineStr := LineStr + '-';

      DetailErrorText := DetailErrorText +
        LineStr + #13#10 + Format('|%s|%s|%s|%s|%s|%s|%s|%s|',
        [CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtProcesses_ID], MaxProID),
        CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Name], MaxProName),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Description], MaxProDesc),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Version], MaxProVer),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Memory], MaxProMemory),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Priority], MaxProPriority),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Threads], MaxProThreads),
          CompleteStr(CurrentOptions.CustomizedExpandedTexts[mtProcesses_Path], MaxProPath)]) +
        #13#10 + LineStr;

      LineSize := (MaxProID + MaxProName + MaxProDesc + MaxProVer + MaxProMemory + 
        MaxProPriority + MaxProThreads + MaxProPath + 11);
      SetLength(LogStr, ProcessesList.Count * LineSize);
      FillChar(Pointer(LogStr)^, Length(LogStr), #32);
      LogIdx := 1;
      for i := 0 to ProcessesList.Count - 1 do
      begin
        FormatComplete(LogStr, LogIdx,
          [IntToStr(ProcessesList[i]^.ProcessID),
          ExtractFileName(ProcessesList[i]^.Name),
            ProcessesList[i]^.Description, ProcessesList[i]^.Version,
            IntToStr(ProcessesList[i]^.Memory),
            PriorityToString(ProcessesList[i]^.Priority),
            GetProcessThreads(ProcessesList[i]^.Threads),
            GetModulePath(ProcessesList[i]^.Name)],
            [MaxProID, MaxProName, MaxProDesc, MaxProVer, MaxProMemory, MaxProPriority, 
              MaxProThreads, MaxProPath]);
      end;
      SetLength(LogStr, LogIdx - 1);
      DetailErrorText := DetailErrorText + #13#10 + LogStr + LineStr + #13#10#13#10;
    end
    else
    begin
      DetailErrorText := (DetailErrorText +
        GetEmptySection(CurrentOptions.CustomizedExpandedTexts[mtDialog_ModulesHeader]));
      DetailErrorText := (DetailErrorText +
        GetEmptySection(CurrentOptions.CustomizedExpandedTexts[mtDialog_ProcessesHeader]));
    end;

    HeaderText := CurrentOptions.CustomizedExpandedTexts[mtDialog_ErrorMsgCaption] +
      #13#10#13#10;
    LastExceptionLog := (CurrentGeneralErrorText + #13#10 + DetailErrorText +
      CurrentAsmErrorLine + #13#10 + CurrentAsmErrorText + #13#10 + CurrentCPUErrorText);
    LastLog := LastExceptionLog;
{$IFDEF EUREKALOG_PROFILER}
    mSecCreateLog := (GetTickCount - mSecCreateLog);
{$ENDIF}
  end;

  procedure WriteToWeb(const Msg: string);
  begin
    if IsIntraWeb then // IntraWeb
    begin
      Global_IntraWebText := HeaderText + Msg;
      SynchronizeEvent(@CallWriteIntraWebText);
    end
    else
      if IsWeb then // (not IntraWeb)
      begin
        ResultText := GenerateHTML(HeaderText + Msg, True);
        if (Pos(LowerCase(JavaScriptOKButton), LowerCase(ResultText)) = 0) then
          ResultText := (ResultText + JavaScriptOKButton);

        Global_Execute := WriteHTMLToWeb(ResultText);
      end;
  end;

  function MustSendMessage: Boolean;
  begin
    with CurrentOptions do
      Result := ((EmailSendMode <> esmNoSend) or (WebSendMode <> wsmNoSend)) and
        (not DuplicatedException) and
        ((CanSendMessage) or (ExceptionDialogType = edtNone));
  end;

{$IFDEF PROFESSIONAL}
  function MustRestoreApplication: Boolean;
  begin
    with CurrentOptions do
      Result := ((RaiserType = rtLocal) or ((RaiserType = rtUnknown) and (IsGUI))) and
        (((MustSendMessage) and
        ((sndShowSendDialog in CommonSendOptions) or (sndSendScreenshot in CommonSendOptions))) or
        (ExceptionDialogType <> edtNone));
  end;
{$ENDIF}

  procedure PurgeModulesList;
  var
    n: Integer;
  begin
    n := 0;
    while (n <= (ModulesList.Count - 1)) do
    begin
      if (ModulesList[n]^.LastModified <> GetModifiedDate(ModulesList[n]^.Name)) then
        ModulesList.Delete(n)
      else Inc(n);
    end;
  end;

  function ShowType(RaiserType: TRaiserType): TShowType;
  begin
    Result := stGUI;
    case RaiserType of
      rtUnknown:
        begin
          if IsWeb then Result := stWeb
          else
            if IsConsole then Result := stConsole
            else Result := stGUI;
        end;
      rtLocal:
        begin
          if IsConsole then Result := stConsole
          else Result := stGUI;
        end;
      rtWeb: Result := stWeb;
    end;
  end;

  procedure AddCallerCallStack(ThreadData: PEurekaThreadInfo);
  begin
    if (ThreadData^.CallerStackDump <> nil) then
    begin
      CallStackByAddresses(CurrentStackList, nil,
        DWord(ThreadData^.CallerStackDump),
        DWord(ThreadData^.CallerStackDump) + (ThreadData^.CallerStackSize - 1),
        ThreadData^.CallerID, False, True, True, -1, -1, [ddNone..ddSourceCode]);
    end;
  end;

  function IsMainThread(ThreadInfo: PEurekaThreadInfo): Boolean;
  begin
    Result := (ThreadInfo^.ID = MainThreadID);
  end;

  function IsBorlandThread(ThreadInfo: PEurekaThreadInfo): Boolean;
  begin
    Result := ((IsMainThread(ThreadInfo)) or (ThreadInfo^.Thread <> nil));
  end;

  function IsWindowsThread(ThreadInfo: PEurekaThreadInfo): Boolean;
  begin
    Result := not IsBorlandThread(ThreadInfo);
  end;

  function CanPauseThisThread(ThreadInfo: PEurekaThreadInfo): Boolean;
  begin
    Result :=
      ((IsWindowsThread(ThreadInfo)) and (csoShowWindowsThreads in CurrentOptions.CallStackOptions)) or
      ((IsBorlandThread(ThreadInfo)) and (csoShowBorlandThreads in CurrentOptions.CallStackOptions));
  end;

  function MustPauseThisThread(ThreadInfo: PEurekaThreadInfo): Boolean;
  begin
    Result :=
      (IsWindowsThread(ThreadInfo) and (boPauseWindowsThreads in CurrentOptions.BehaviourOptions)) or
      (IsBorlandThread(ThreadInfo) and (boPauseBorlandThreads in CurrentOptions.BehaviourOptions) and
      (not (boDoNotPauseMainThread in CurrentOptions.BehaviourOptions) or (not IsMainThread(ThreadInfo))));
  end;

  procedure SetHandledWithEurekaLog(Obj: TObject);
  begin
    if ((IsValidObject(Obj)) and (IsAParent(Obj, Exception)) and
      (Pos(SafeCallExceptionHandled, Exception(Obj).Message) = 0)) then
      Exception(Obj).Message := (SafeCallExceptionHandled + Exception(Obj).Message);
  end;

  procedure SetEnvVariables;
  var
    Module: PEurekaModuleInfo;
  begin
    Module := ModuleInfoByHandle(MainInstance);
    if (Module <> nil) then
    begin
      SetEnvironmentVariable('_MainModuleName', PChar(ExtractFileName(Module^.Name)));
      SetEnvironmentVariable('_MainModuleDesc', PChar(Module^.Description));
      SetEnvironmentVariable('_MainModuleVer', PChar(Module^.Version));
    end;
    Module := ModuleInfoByAddr(DWord(Addr));
    if (Module <> nil) then
    begin
      SetEnvironmentVariable('_ExceptModuleName', PChar(ExtractFileName(Module^.Name)));
      SetEnvironmentVariable('_ExceptModuleDesc', PChar(Module^.Description));
      SetEnvironmentVariable('_ExceptModuleVer', PChar(Module^.Version));
    end;
    SetEnvironmentVariable('_ExceptMsg', PChar(GetExceptionMessage));
    SetEnvironmentVariable('_BugReport', PChar(LastExceptionLog));
    SetEnvironmentVariable('_LineBreak', PChar(#13#10));
  end;

begin // InternalExceptNotify

  // Check to avoid an IntraWeb 7.x exception bug!!!
  if (IsIntraWeb) and (IntraWebCompressedPage) and
    (IntraWebApplication = nil) and (Params.ThreadID = MainThreadID) then
  begin
    Result := True;
    Exit;
  end;

{$IFDEF EUREKALOG_PROFILER}
  mSecBefore := GetTickCount;
  mSecCallStack := 0;
  mSecModulesList := 0;
  mSecOpenLog := 0;
  mSecSaveLog := 0;
  mSecCreateLog := 0;
  mSecGetModuleInfo := 0;
  mSecCalcDuplicated := 0;
  mSecScreenShot := 0;
  mSecEventTemp := 0;
  mSecEvents := 0;
{$ENDIF}

  Result := False;
  ExceptionTime := Now;

  CriticalExceptObject := Obj;

  CurrentRequestValue := '';

  DbgSection := 1;
  try
    NotCatchCallerThread := True;
    LocalThreadsList := TEurekaThreadsList.Create(ThreadsList);
    try
      // Save the Address of the last Unhandled Exception.
      if (Addr <> nil) then RaisedExceptAddr := Addr;

      // call @RaiseExcept <--- (1)
      // ExceptAddr <--- (2)
      if (DelphiException) and (Addr <> nil) then // Decrease of 5 to point to (1)
        Addr := Pointer(Integer(Addr) - 5);

{$IFDEF EUREKALOG_PROFILER}
      mSecGetModuleInfo := GetTickCount;
{$ENDIF}
      PurgeModulesList;
      if (HInstance <> ModuleHandle) then RealMainInstance := HInstance
      else RealMainInstance := MainInstance;

      // Assign base parameters for OnPasswordRequest event...
      Global_ExceptionRecord.ExceptionAddress := Addr;
      Global_ExceptionRecord.ExceptionObject := Obj;
      Global_ExceptionRecord.ExceptionThreadID := Params.ThreadID;

      // Set the exception type (handled or unhandled)...
      ThreadsList.SetExceptionType(Params.ThreadID, True);

      ModuleInfo := nil;
      if (Addr <> nil) then
      begin
        DbgSection := 101;
        ModuleInfo := ModuleInfoByAddr(DWord(Addr));
      end;
      if (ModuleInfo = nil) or
        (ModuleInfo^.ExtraInformation.DebugInformation = nil) then
      begin
        DbgSection := 102;
        ModuleInfo := ModuleInfoByHandle(ModuleHandle);
        DbgSection := 103;
        if (ModuleInfo = nil) or
          (ModuleInfo^.ExtraInformation.DebugInformation = nil) and
          (RealMainInstance <> 0) then
          ModuleInfo := ModuleInfoByHandle(RealMainInstance);
      end;
      CurrentOptions.Assign(ModuleInfo^.ExtraInformation.Options);
      if (boUseMainModuleOptions in CurrentOptions.BehaviourOptions) and
        (RealMainInstance <> 0) then
      begin
        OldModuleInfo := ModuleInfo;
        ModuleInfo := ModuleInfoByHandle(RealMainInstance);
        if (ModuleInfo = nil) or
          (ModuleInfo^.ExtraInformation.DebugInformation = nil) then
          ModuleInfo := OldModuleInfo
        else
          CurrentOptions.Assign(ModuleInfo^.ExtraInformation.Options);
      end;

      {$IFNDEF CBuilder}
      // Leaks custom texts...
      MultiFreeExceptionText :=
        CurrentOptions.CustomizedExpandedTexts[mtException_LeakMultiFree];
      MemoryOverrunExceptionText :=
        CurrentOptions.CustomizedExpandedTexts[mtException_LeakMemoryOverrun];
      {$ENDIF}

      DbgSection := 104;
      if (IntoIDE) then
      begin
        CurrentOptions.ExceptionDialogOptions :=
          CurrentOptions.ExceptionDialogOptions - [edoUseEurekaLogLookAndFeel];
        CurrentOptions.CustomizedTexts[mtMSDialog_ErrorMsgCaption] :=
        'The IDE has raised an exception.'#13#10' ';
        CurrentOptions.CustomizedTexts[mtMSDialog_RestartCaption] :=
        'Restart the IDE';
      end;
      CurrentOptions.ModuleName := ModuleInfo^.Name;
{$IFDEF EUREKALOG_PROFILER}
      mSecGetModuleInfo := (GetTickCount - mSecGetModuleInfo);
{$ENDIF}
      DbgSection := 2;
      SetCustomErrorMessage('');
      HandlerType := fhtEurekaLog;
      ActionType := fatNone;
      DialogType := CurrentOptions.ExceptionDialogType;
      IsFilterDialog := False;
      if (AsynchronousException <> aeSynchronize) and
        (CurrentOptions.ActivateHandle) then
      begin
        i := FindException;
        DbgSection := 201;
        if (i <> -1) then
        begin
          ActionType := CurrentOptions.ExceptionsFilters[i]^.ActionType;
          HandlerType := CurrentOptions.ExceptionsFilters[i]^.HandlerType;
          case CurrentOptions.ExceptionsFilters[i]^.DialogType of
            fdtNone: DialogType := edtNone;
            fdtUnchanged: DialogType := CurrentOptions.ExceptionDialogType;
            fdtMessageBox: DialogType := edtMessageBox;
            fdtMSClassic: DialogType := edtMSClassic;
            fdtEurekaLog: DialogType := edtEurekaLog;
          end;
          IsFilterDialog := True;
          if (ExpandEnvVar(CurrentOptions.ExceptionsFilters[i]^.ExceptionMessage) <> '') then
            SetCustomErrorMessage(ExpandEnvVar(CurrentOptions.ExceptionsFilters[i]^.ExceptionMessage));
        end;
      end;

      MustSendInternetMessage := MustSendMessage;

      DbgSection := 3;
      if (HandlerType = fhtEurekaLog) then
      begin
        if (Params.TopOfStack = 0) then
          Params.TopOfStack := GetCurrentTopOfStack;
        if (Params.StackPoint = 0) then
          Params.StackPoint := CurrentStackPointer;
        if (Params.Context = nil) and (CurrentContext.ContextFlags <> 0) then
          Params.Context := PContext(@CurrentContext);
        if (not (IsValidBlockAddr(DWord(Params.Context), SizeOf(TContext)))) then
          Params.Context := nil;
        LastExceptThreadID := Params.ThreadID;

{$IFDEF EUREKALOG_PROFILER}
        mSecCallStack := GetTickCount;
{$ENDIF}

        DbgSection := 4;
        // Check Synchronize raise...
        if (SynchronizeRaise = 0) or
          (not RoundMatch(SynchronizeRaise, DWord(Addr) + 5)) then
        begin
          if (CurrentStackList <> nil) then CurrentStackList.Free;
          if (Params.CallStack = nil) then
            CurrentStackList :=
              GetCallStackByAddresses(Addr, Params.StackPoint, Params.TopOfStack,
                Params.ThreadID, True, True, -1, -1, [ddNone..ddSourceCode])
          else CurrentStackList := Params.CallStack;

          // Calculate BugID...
          BugID := GetExceptionType;
          for i := 0 to (CurrentStackList.Count - 1) do
          begin
            if (CurrentStackList[i]^.DebugDetail = ddSourceCode) and
            (CurrentStackList[i]^.ThreadID = CurrentStackList[0]^.ThreadID) then
              BugID := (BugID + CurrentStackList[i]^.UnitName +
                CurrentStackList[i]^.ClassName + CurrentStackList[i]^.ProcedureName +
                IntToStr(CurrentStackList[i]^.ProcOffsetLine));
          end;
          BugID := IntToHex(GetCrc16(BugID), 4);
          LastBugID := BugID;

          i := LocalThreadsList.FindByThreadID(Params.ThreadID);
          if (i <> -1) then AddCallerCallStack(LocalThreadsList[i]);

          // Suspend all Threads...
          for i := 0 to (LocalThreadsList.Count - 1) do
            if ((LocalThreadsList[i]^.ID <> Params.ThreadID) and
              (CanPauseThisThread(LocalThreadsList[i]))) then
              begin
                ThreadsList.BeginWrite;
                try
                  SuspendThread(LocalThreadsList[i]^.Handle);
                finally
                  ThreadsList.EndWrite;
                end;
              end;

          try // Get all Threads Call-Stack...
            for i := 0 to (LocalThreadsList.Count - 1) do
              if ((LocalThreadsList[i]^.ID <> Params.ThreadID) and
                (CanPauseThisThread(LocalThreadsList[i]))) then
              begin
                ThreadData := LocalThreadsList[i];
                FillChar(Context, SizeOf(Context), #0);
                Context.ContextFlags := CONTEXT_FULL;
                if (GetThreadContext(ThreadData^.Handle, Context)) and
                  (Context.EIP <> 0) and (Context.ESP <> 0) then
                begin
                  CallStackByAddresses(CurrentStackList, nil, Context.Esp,
                    ThreadData^.TopOfStack, ThreadData^.ID, True, True, True,
                    -1, -1, [ddNone..ddSourceCode]);
                  AddCallerCallStack(ThreadData);
                end;
              end;

          finally // Resume all Threads...
            for i := 0 to (LocalThreadsList.Count - 1) do
              if ((LocalThreadsList[i]^.ID <> Params.ThreadID) and
                (CanPauseThisThread(LocalThreadsList[i]))) then
                ResumeThread(LocalThreadsList[i]^.Handle);
          end;
        end;

        DbgSection := 5;

        if (AsynchronousException <> aeSynchronize) then
        begin
          // Suspend all Threads...
          for i := 0 to (LocalThreadsList.Count - 1) do
            if ((LocalThreadsList[i]^.ID <> GetCurrentThreadID) and
              (LocalThreadsList[i]^.ID <> Params.ThreadID) and
              (MustPauseThisThread(LocalThreadsList[i]))) then
              begin
                ThreadsList.BeginWrite;
                try
                  SuspendThread(LocalThreadsList[i]^.Handle);
                finally
                  ThreadsList.EndWrite;
                end;
              end;
          try
    {$IFDEF EUREKALOG_PROFILER}
            mSecCallStack := (GetTickCount - mSecCallStack);
    {$ENDIF}

            DbgSection := 6;
            Global_Handled := True;

    {$IFDEF EUREKALOG_PROFILER}
            mSecModulesList := GetTickCount;
    {$ENDIF}
            if (loSaveModulesAndProcessesSections in CurrentOptions.LogOptions) then
            begin
              GetModulesList;
              GetProcessesList;
            end;
    {$IFDEF EUREKALOG_PROFILER}
            mSecModulesList := (GetTickCount - mSecModulesList);
    {$ENDIF}

            DbgSection := 7;
            Global_ExceptionRecord.CallStack := CurrentStackList;
            Global_ExceptionRecord.CurrentModuleOptions := CurrentOptions;
{            DbgSection := 701;
            Global_ExceptionRecord.ExceptionAddress := Addr;
            Global_ExceptionRecord.ExceptionObject := Obj;
            Global_ExceptionRecord.ExceptionThreadID := Params.ThreadID;}
            DbgSection := 702;
            CreateLogText;
            Global_ExceptionRecord.LogText := LastExceptionLog;
            DbgSection := 703;
            Global_ExceptionRecord.ModulesList := ModulesList;
            DbgSection := 704;
            LastExceptionRecord := @Global_ExceptionRecord;
            CalcDuplicatedException(True);
            DbgSection := 705;
            ClearInternalError;
            DbgSection := 706;

            SetEnvVariables;

    {$IFDEF PROFESSIONAL}
            if (IsCGI) then LastHTMLPage := LoadTextFile(RealTmpLastHTMLPage);
            SavedLastHTMLPage := LastHTMLPage;

            if (MustRestoreApplication) then SynchronizeEvent(@ApplicationRestore);
    {$ENDIF}

            if (not Params.Handled) then SynchronizeEvent(@CallExceptionNotifyEvents)
            else SynchronizeEvent(@CallHandledExceptionNotifyEvents);

    {$IFDEF PROFESSIONAL}
    {$IFDEF EUREKALOG_PROFILER}
            mSecScreenShot := GetTickCount;
    {$ENDIF}
            InitScreenshot;
    {$IFDEF EUREKALOG_PROFILER}
            mSecScreenShot := (GetTickCount - mSecScreenShot);
    {$ENDIF}
    {$ENDIF}

            DbgSection := 8;
            if Global_Handled then
            begin
              if (CurrentOptions.AutoCrashOperation <> tbNone) then
              begin
                ExceptionsTime.Add(DateTimeToStr(Now));
                if (ExceptionsTime.Count > CurrentOptions.AutoCrashNumber) then
                  ExceptionsTime.Delete(0);
              end;

              Global_DataFields.Clear;
              SynchronizeEvent(@CallCustomDataRequestEvents);
              if (Global_DataFields.Count <> 0) and
                (soCustomData in CurrentOptions.ShowOptions) then
                AddCustomHeadersToLog(
                  7, CurrentOptions.CustomizedExpandedTexts[mtLog_CustInfoHeader],
                  Global_DataFields);

              DbgSection := 9;
              Inc(ExceptionNumber);

              DbgSection := 10;
              LastExceptMessage := PurgeString(GetExceptionMessage);

    {$IFDEF EUREKALOG_PROFILER}
              mSecBefore := (GetTickCount - mSecBefore);
    {$ENDIF}
              CanShowHowToRequest := False;

              DbgSection := 11;
              if (not IsFilterDialog) then
                DialogType := CurrentOptions.ExceptionDialogType;
              if (DialogType <> edtNone) then
              begin
                DbgSection := 12;
                Global_Execute := True;
                ClearInternalError;
                SynchronizeEvent(@CallExceptionActionNotify_atShowingExceptionInfo);

                CanSendMessage := (CurrentOptions.EmailSendMode <> esmNoSend) or
                  (CurrentOptions.WebSendMode <> wsmNoSend);
                CanAttachScreenshot := (sndSendScreenshot in CurrentOptions.CommonSendOptions);

                if (Global_Execute) then
                begin
                  DbgSection := 13;
                  case ShowType(RaiserType) of
                    stWeb: WriteToWeb(LastExceptionLog);
                    stConsole:
                      begin
                        try
                          WriteLn(HeaderText + LastExceptionLog);
                          Global_Execute := True;
                        except
                          Global_Execute := False;
                          SetErrorType(eeShowError, 'Console');
                        end;
                      end;
                    stGUI:
                      begin
                        try
                          CanShowHowToRequest := (DialogType = edtEurekaLog);
                          ShowInDetailsMode := False;
                          PlaySound := (DialogType <> edtNone);
                          repeat
                            ShowDialog(PlaySound); // GUI
                            PlaySound := False;
                            if (DialogType <> edtNone) then ShowInDetailsMode := True;
                          until (DialogType = edtNone);
                          Global_Execute := True;
                        except
                          Global_Execute := False;
                          SetErrorType(eeShowError, 'GUI');
                        end;
                      end;
                  end;

                  DbgSection := 14;
                  SynchronizeEvent(@CallExceptionActionNotify_atShowedExceptionInfo);
                end;
              end
              else
              begin
                CanSendMessage := (CurrentOptions.EmailSendMode <> esmNoSend) or
                  (CurrentOptions.WebSendMode <> wsmNoSend);
                CanAttachScreenshot := (sndSendScreenshot in CurrentOptions.CommonSendOptions);

                if (IsWeb) then WriteToWeb(GetExceptMessage);
              end;

              if (CanShowHowToRequest) then ShowRequestDialog;

    {$IFDEF PROFESSIONAL}
    {$IFDEF EUREKALOG_PROFILER}
              mSecScreenShot := (GetTickCount - mSecScreenShot);
    {$ENDIF}
              if (MustSendMessage) then AfterScreenshot(SavedScreenshot);
              FreeScreenshot;
    {$IFDEF EUREKALOG_PROFILER}
              mSecScreenShot := (GetTickCount - mSecScreenShot);
    {$ENDIF}
    {$ENDIF}

              DbgSection := 15;
              if (loDeleteLogAtVersionChange in CurrentOptions.LogOptions) then
              begin
                OpenLogFile;
                try
                  LastVersionStr :=
                    Cached_LogFile.GetItemValue('1.3', Cached_LogFile.Count - 1);
                finally
                  CloseLogFile;
                end;
                if (LastVersionStr <> '') and (LastVersionStr <> GetVersionNumber) then
                  DeleteFile(ExpandEnvVar(CurrentOptions.OutputLogFile('')));
              end;

              MustSendInternetMessage := MustSendMessage;
              if (CurrentOptions.SaveLogFile) then SaveLogFile;

              if (CanCopy) then SetClipboardText(LastExceptionLog);

              DbgSection := 16;
              if (MustSendInternetMessage) then SendInternetMessage;

              if (not MustSendInternetMessage) or
                (not (sndSendInSeparatedThread in CurrentOptions.CommonSendOptions)) then
                ExceptNotifyAfter1;
            end
            else Result := True;
          finally
            // Resume all Threads...
            for i := 0 to (LocalThreadsList.Count - 1) do
              if ((LocalThreadsList[i]^.ID <> GetCurrentThreadID) and
                (LocalThreadsList[i]^.ID <> Params.ThreadID) and
                (MustPauseThisThread(LocalThreadsList[i]))) then
                ResumeThread(LocalThreadsList[i]^.Handle);
          end;

          DbgSection := 17;
          if (not MustSendInternetMessage) or
            (not (sndSendInSeparatedThread in CurrentOptions.CommonSendOptions)) then
            ExceptNotifyAfter2;

          if ((not TerminateApplication) and (ActionType <> fatNone)) then
          begin
            case ActionType of
              fatTerminate: ForceApplicationTermination(tbTerminate);
              fatRestart: ForceApplicationTermination(tbRestart);
            end;
          end;
        end;

        if (boCallRTLExceptionEvent in CurrentOptions.BehaviourOptions) then Result := True;
      end
      else if (HandlerType = fhtRTL) then Result := True;

      DbgSection := 18;
      if (AsynchronousException <> aeSynchronize) and
         ((not MustSendInternetMessage) or
         (not (sndSendInSeparatedThread in CurrentOptions.CommonSendOptions))) then
        ExceptNotifyAfter3;
  finally
    LocalThreadsList.Free;
    NotCatchCallerThread := False;
  end;

  except
    InternalCriticalError(IntToStr(DbgSection));
  end;

{$IFDEF EUREKALOG_PROFILER}
  MessageBox(0, PChar(Format('Before show: %d'#13#10 +
    '----------'#13#10 + 'CallStack: %d'#13#10'ModulesList: %d'#13#10 +
    'Create log: %d'#13#10'Open log: %d'#13#10'Save log: %d'#13#10 +
    'Get Module Info: %d'#13#10'Calc duplicated: %d'#13#10 +
    'Save ScreenShot: %d'#13#10'Events: %d',
    [mSecBefore, mSecCallStack, mSecModulesList, mSecCreateLog,
    mSecOpenLog, mSecSaveLog, mSecGetModuleInfo,
      mSecCalcDuplicated, mSecScreenShot, mSecEvents])),
      'Times (ms)', MB_OK or MB_ICONINFORMATION or MB_TASKMODAL);
{$ENDIF}
end;

function GetControlClass: string;
var
  Buff: array[0..255] of Char;
  I: DWord;
begin
{$IFDEF PROFESSIONAL}
  PNG_FocusWnd := GetFocus;
  PNG_Cursor := GetCursor;
{$ENDIF}
  I := SizeOf(Buff);
  if GetClassName(GetFocus(), Buff, I) > 0 then
    Result := Buff
  else
    Result := '';
end;

function GetControlText: string;
var
  Buff: array[0..255] of Char;
  I: DWord;
  ClassName: string;
begin
  I := SizeOf(Buff);
  if GetWindowText(GetFocus(), Buff, I) > 0 then
  begin
    Result := Buff;
    ClassName := Trim(UpperCase(GetControlClass));
    if (Pos('EDIT', ClassName) > 0) then
    begin
      if (GetWindowLong(GetFocus(), GWL_STYLE) and ES_PASSWORD <> 0) then
        for I := 1 to length(Result) do Result[I] := '*';
    end;
  end
  else
    Result := '';
end;

{ TExceptionThread }

constructor TExceptionThread.Create(Obj: TObject; Addr: Pointer;
  DelphiException: Boolean; Params: TExceptNotifyParams; RaiserType: TRaiserType;
  ModuleHandle: THandle; AsynchronousException: TAsynchronousException);
begin
  inherited Create(True); // Create suspended.
  FResult := False;
  FObj := Obj;
  FAddr := Addr;
  FDelphiException := DelphiException;
  FParams.Handled := Params.Handled;
  FParams.CallStack := Params.CallStack;
  if Params.TopOfStack = 0 then
    FParams.TopOfStack := GetCurrentTopOfStack
  else
    FParams.TopOfStack := Params.TopOfStack;
  if Params.StackPoint = 0 then
    FParams.StackPoint := CurrentStackPointer
  else
    FParams.StackPoint := Params.StackPoint;
  FParams.ThreadID := Params.ThreadID;
  FParams.ActiveControlClass := Params.ActiveControlClass;
  FParams.ActiveControlText := Params.ActiveControlText;
  if (Params.Context = nil) then
    FParams.Context := PContext(@CurrentContext)
  else
    FParams.Context := Params.Context;
  FRaiserType := RaiserType;
  FModuleHandle := ModuleHandle;
  FAsynchronousException := AsynchronousException;
  FExecuting := True;
  Priority := tpHighest;
  Resume;
end;

procedure TExceptionThread.Execute;
begin
  try
    FResult := InternalExceptNotify(FObj, FAddr, FDelphiException,
      FParams, FRaiserType, FModuleHandle, FAsynchronousException);
  finally
    FExecuting := False;
  end;
end;

function ExceptNotify(Obj: TObject; Addr: Pointer;
  DelphiException: Boolean; TopOfStack, StackPoint: DWord;
  Context: PContext; RaiserType: TRaiserType; ModuleHandle: DWord;
  AsynchronousException: TAsynchronousException; Handled: Boolean;
  CallStack: TEurekaStackList): Boolean;
var
  Thread: TExceptionThread;
  Params: TExceptNotifyParams;
  CanCallProcessMessages: Boolean;

  procedure ResetGlobalVars;
  begin
    SetLastExceptionData(nil, nil, False);
    CurrentStackPointer := 0;
    CurrentContext.ContextFlags := 0;
    LastExceptionRecord := nil;
  end;

  procedure ProcessMessages;
  var
    Msg: TMsg;
    n: integer;
  begin
    n := 0;
    try
      while (n <= 10) and (PeekMessage(Msg, 0, 0, 0, PM_REMOVE)) do
      begin
        case Msg.message of
          // Keyboard messages...
          WM_CHAR, WM_KEYDOWN, WM_KEYUP,
          WM_SYSCHAR, WM_SYSKEYDOWN, WM_SYSKEYUP,
          // Mouse messages (client area)...
          WM_LBUTTONDOWN, WM_RBUTTONDOWN, WM_MBUTTONDOWN,
          WM_LBUTTONUP, WM_RBUTTONUP, WM_MBUTTONUP,
          WM_LBUTTONDBLCLK, WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK,
          // Mouse messages (not client area)...
          WM_NCLBUTTONDOWN, WM_NCRBUTTONDOWN, WM_NCMBUTTONDOWN,
          WM_NCLBUTTONUP, WM_NCRBUTTONUP, WM_NCMBUTTONUP,
          WM_NCLBUTTONDBLCLK, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK:
            begin
              Beep; // To simulate the ShowModal...
            end;
          else
            if (Msg.message <> WM_QUIT) then
            begin
              TranslateMessage(Msg);
              DispatchMessage(Msg);
            end;
        end;
        Inc(n);
      end;
    except
      CanCallProcessMessages := False;
{$IFDEF DUNITPROJECT}
      if (IsValidObject(ExceptObject)) then
        MessageBox(0, PChar(String(ExceptObject.ClassName)),
        'ProcessMessages Error.', MB_OK or MB_ICONERROR or MessageBoxFlags);
{$ENDIF}
    end;
  end;

  procedure SetHandledWithEurekaLog(Obj: TObject);
  begin
    if ((IsValidObject(Obj)) and (IsAParent(Obj, Exception)) and
      (Pos(SafeCallExceptionHandled, Exception(Obj).Message) = 0)) then
      Exception(Obj).Message := (SafeCallExceptionHandled + Exception(Obj).Message);
  end;

  function IsHandledSafeCallException(Obj: TObject): Boolean;
  var
    Behaviour: TBehaviourOptions;
     HandleSafeCall: Boolean;
  begin
    Behaviour := CurrentEurekaLogOptions.BehaviourOptions;
    HandleSafeCall := (boHandleSafeCallExceptions in Behaviour);
    Result :=
      (not HandleSafeCall) and
      ((IsValidObject(Obj)) and (IsAParent(Obj, Exception) and
      (Pos(SafeCallExceptionHandled, Exception(Obj).Message) = 1)));
  end;

begin
  Result := True;
  if ((not Initialized) or (IsAParent(Obj, EAbort))) then Exit;

  FreeOutOfMemoryCache;
  CanCallProcessMessages := (not IsAParents(Obj, CannotProcessMessagesExceptions));
  EnterCriticalSection(ExceptionCriticalSection);
  try
    if (InUnhandledException = False) then
    begin
      InUnhandledException := True;
      try
        if (not IsHandledSafeCallException(Obj)) then
        begin
          if (CurrentEurekaLogOptions.Active) then
          begin
            Params.Handled := Handled;
            Params.Context := Context;
            Params.CallStack := CallStack;
            Params.TopOfStack := TopOfStack;
            Params.StackPoint := StackPoint;
            if ((FreezeThread <> nil) and (FreezeThread.ThreadID = GetCurrentThreadID)) then
              Params.ThreadID := MainThreadID
            else
              Params.ThreadID := GetCurrentThreadID;
            Params.ActiveControlClass := GetControlClass;
            Params.ActiveControlText := GetControlText;

            // During process DLL initialization/finalization routines,
            // new threads can be created, but they do not begin execution
            // until DLL initialization/finalization is done for the process.
            // --------------------------------------------------------------
            // From Microsoft "Win32 Developer's References" (CreateThread remarks).
            if ((IsModuleLibrary(HInstance)) and ((IntoInitialization) or (IntoFinalization))) then
            begin
              CannotUseThread := True;
              Result := InternalExceptNotify(Obj, Addr, DelphiException,
                Params, RaiserType, ModuleHandle, AsynchronousException);
              ResetGlobalVars;
            end
            else
            begin
              CannotUseThread := False;
              Thread := TExceptionThread.Create(Obj, Addr, DelphiException,
                Params, RaiserType, ModuleHandle, AsynchronousException);
              try
                repeat
                  if (GetCurrentThreadId = MainThreadID)
                    and (CanCallProcessMessages) and (IsDialogShowed) then ProcessMessages;

                  if (Global_CurrentEvent <> nil) then
                  begin
                    try
{$IFDEF EUREKALOG_PROFILER}
                      mSecEventTemp := GetTickCount;
{$ENDIF}
                      try
                        TInternalProc(Global_CurrentEvent); // Call the event.
                      finally
                        Global_CurrentEvent := nil;
                      end;
{$IFDEF EUREKALOG_PROFILER}
                      mSecEventTemp := (GetTickCount - mSecEventTemp);
{$ENDIF}
                    except
                      // ...
                    end;
                  end;

                  Sleep(10);
                until (not Thread.Executing);
                WaitForSingleObject(Thread.Handle, INFINITE);
                Result := Thread.Result;
              finally
                Thread.Free;
                ResetGlobalVars;
              end;
            end;
            if (AsynchronousException = aeSafeCall) then SetHandledWithEurekaLog(Obj);
          end;
        end
        else Result := False;
      finally
        InUnhandledException := False;
      end;
    end
    else Result := False;
  finally
    LeaveCriticalSection(ExceptionCriticalSection);
    GetOutOfMemoryCache;
  end;
end;

//------------------------------------------------------------------------------

procedure GetThreadParams;
const
{$IFDEF Delphi3}
  Step1 = 383;   //
  Step2 = -54;   // <-- WITHOUT Stack Frames
  Step3 = 52;    //

  StepSF1 = 395; //
  StepSF2 = -54; // <-- WITH Stack Frames
  StepSF3 = 56;  //
{$ENDIF}
{$IFDEF Delphi4}
  Step1 = 363;    //
  Step2 = -54;    // <-- WITHOUT Stack Frames
  Step3 = 52;     //

  StepSF1 = 375;  //
  StepSF2 = -54;  // <-- WITH Stack Frames
  StepSF3 = 56;   //
{$ENDIF}
{$IFDEF Delphi5}
  Step1 = 592;    //
  Step2 = -54;    // <-- WITHOUT Stack Frames
  Step3 = 104;    //

  StepSF1 = 592;  //
  StepSF2 = -54;  // <-- WITH Stack Frames
  StepSF3 = 104;  //
{$ENDIF}
{$IFDEF Delphi6}
  Step1 = 254;    //
  Step2 = -307;   // <-- WITHOUT Stack Frames
  Step3 = 160;    //

  StepSF1 = 270;  //
  StepSF2 = -310; // <-- WITH Stack Frames
  StepSF3 = 176;  //
{$ENDIF}
{$IFDEF Delphi7}
  Step1 = 313;    //
  Step2 = 46;     // <-- WITHOUT Stack Frames
  Step3 = 168;    //

  StepSF1 = 325;  //
  StepSF2 = 68;   // <-- WITH Stack Frames
  StepSF3 = 180;  //
{$ENDIF}
{$IFDEF Delphi9}
  Step1 = 369;    //
  Step2 = 40;     // <-- WITHOUT Stack Frames
  Step3 = 168;    //

  StepSF1 = 381;  //
  StepSF2 = 65;   // <-- WITH Stack Frames
  StepSF3 = 180;  //
{$ENDIF}
{$IFDEF Delphi10}
  Step1 = 369;    //
  Step2 = 40;     // <-- WITHOUT Stack Frames
  Step3 = 168;    //

  StepSF1 = 381;  //
  StepSF2 = 65;   // <-- WITH Stack Frames
  StepSF3 = 180;  //
{$ENDIF}
{$IFDEF Delphi11}
  Step1 = 369;    //
  Step2 = 40;     // <-- WITHOUT Stack Frames
  Step3 = 168;    //

  StepSF1 = 381;  //
  StepSF2 = 65;   // <-- WITH Stack Frames
  StepSF3 = 180;  //
{$ENDIF}
var
  S1, S2, S3: Integer;
begin
  if (not IsRTLCompiledWithStackFrames) then
  begin
    S1 := Step1;
    S2 := Step2;
    S3 := Step3;
  end
  else
  begin
    S1 := StepSF1;
    S2 := StepSF2;
    S3 := StepSF3;
  end;
  SynchronizeExcept := (Integer(ConvertAddress(Integer(@TThread.Create))) - S1);
  SynchronizeRaise := (Integer(ConvertAddress(Integer(@TInternalThread.Synchronize))) - S2);
  OriginalThreadProc := Pointer(Integer(ConvertAddress(Integer(@TThread.Create))) - S3);
  ThreadWrapperAddr := Pointer(ConvertAddress(DWord(@BeginThread)) - $38);
end;

procedure IntraWeb_OnExceptionEvent_Old(Self, AApplication: TObject; AException: Exception);

  function GetIntraWebExceptionType: TIWShowMessageType;
  var
    PropInfo: PPropInfo;
  begin
    Result := smAlert;
    if (IntraWebServerController = nil) then Exit;
    PropInfo := GetPropInfo(IntraWebServerController.ClassInfo, 'ExceptionDisplayMode');
    if (PropInfo <> nil) then
      Result := TIWShowMessageType(GetOrdProp(IntraWebServerController, PropInfo));
  end;

begin
  IntraWebApplication := AApplication;
  try
    if ExceptionManager(AException, ExceptAddr, rtWeb, HInstance) then
      if (Assigned(IntraWeb_OnException_Old)) then
        IntraWeb_OnException_Old(Self, AApplication, AException)
      else
        IntraWeb_ShowMessage(AApplication, AException.Message, GetIntraWebExceptionType, '');
  finally
    IntraWebApplication := nil;
  end;
end;

procedure IntraWeb_OnExceptionEvent_New(Self, AApplication: TObject;
  AException: Exception; var Handled: Boolean);
begin
  IntraWebApplication := AApplication;
  try
    if ExceptionManager(AException, ExceptAddr, rtWeb, HInstance) then
      begin
        if (Assigned(IntraWeb_OnException_New)) then
          IntraWeb_OnException_New(Self, AApplication, AException, Handled)
      end
    else Handled := True;
  finally
    IntraWebApplication := nil;
  end;
end;

procedure IntraWeb_OnExceptionEvent(Self, AApplication: TObject; AException: Exception);
asm
  CMP  IntraWeb_NewEvent, True
  JNE  IntraWeb_OnExceptionEvent_Old
  JMP  IntraWeb_OnExceptionEvent_New
end;

procedure SetIntraWebEvent;
begin
  if (IntraWebServerController = nil) then Exit;

  SetEventAddr(IntraWebServerController, 'OnException',
    @IntraWeb_OnExceptionEvent, @IntraWeb_OnException_Old);
  @IntraWeb_OnException_New := @IntraWeb_OnException_Old;
end;

procedure GoNotify(Obj: TObject; Addr: Pointer; DelphiException, OnlySafeCall: Boolean);
var
  Handled: Boolean;
  AsynchronousException: TAsynchronousException;
  LastErrorCode: Integer;

  procedure SetLastExceptStack;
  var
    ESP, TOP: DWord;

    function GetBaseOfStack: DWord;
    asm
      MOV  EAX, FS:[8]
    end;

    function GetCurrentStackPointer: DWord;
    asm
      MOV  EAX, EBP
      ADD  EAX, 4
    end;

  begin
    EnterCriticalSection(LastDumpCriticalSection);
    try
      try
        ESP := CurrentContext.Esp;
        TOP := GetCurrentTopOfStack;
        if (ESP < GetBaseOfStack) or (ESP > TOP) then ESP := GetCurrentStackPointer;
        LastExceptionCallStackSize := (TOP - ESP);
        if (LastExceptionCallStackSize > MaxCallStackSize) then
          LastExceptionCallStackSize := MaxCallStackSize;

        LastExceptionThreadID := GetCurrentThreadId;
        LastExceptionCallStackAddress := Addr;
        if (DelphiException) and (Addr <> nil) then // Decrease of 5 to point to (1)
          LastExceptionCallStackAddress := Pointer(Integer(LastExceptionCallStackAddress) - 5);
        Move(PDWord(ESP)^, LastExceptionCallStackDump^, LastExceptionCallStackSize);
      except
        LastExceptionCallStackSize := 0;
      end;
    finally
      LeaveCriticalSection(LastDumpCriticalSection);
    end;
  end;

  function LockCheck(var Variable: Boolean): Boolean;
  asm
    MOV  ECX, EAX // EAX = @Variable
    MOV  AL,  False
    MOV  DL,  True
{$IFDEF Delphi4Up}
    LOCK CMPXCHG [ECX], DL
{$ELSE} // Fix a Delphi 3 ASM Compiler bug...
    DB   $F0, $0F, $B0, $11
{$ENDIF}
  end;

begin
  if (not LockCheck(RecursiveException)) then
  begin
    try
      LastErrorCode := GetLastError;

      if (not OnlySafeCall) or (LastExceptionAddress = nil) then
        SetLastException(Obj, Addr, DelphiException);

      if (IsEurekaLogActive) and (IsEurekaLogActiveInThread(GetCurrentThreadID)) and
        (IsManageableObject(Obj)) then
      begin
    {$IFNDEF PROFESSIONAL}
        if (DWord(FindHInstance(Addr)) <> MainInstance) or
          (IsCompiledWithPackages) or (IsWeb) then Exit;
    {$ENDIF}

        SetLastExceptStack;

        SetIntraWebEvent;

        // Set the exception type (handled or unhandled)...
        ThreadsList.SetExceptionType(GetCurrentThreadID, False);

        if ((OnlySafeCall) and (not OnlySafeCallExceptions) and (GetCurrentThreadID = MainThreadID)) then
          OnlySafeCall :=
            (not (boHandleSafeCallExceptions in CurrentEurekaLogOptions.BehaviourOptions));
        Handled := IsExceptionHandled(Obj, Addr, OnlySafeCall, AsynchronousException);
        if (not Handled) then
        begin
          if (CurrentStackPointer = 0) then CurrentStackPointer := LastStackPointer;
          ExceptNotify(Obj, Addr, DelphiException, 0, 0, nil, rtUnknown,
            HInstance, AsynchronousException, False, nil);
        end;
      end;

      SetLastError(LastErrorCode);
    finally
      RecursiveException := False;
    end;
  end;
end;

procedure GeneralRaise(Code, Flags, NArgs: DWord; Args: PExcArgs; CallGoNotify: Boolean);
var
  Addr: Pointer;
  Obj: TObject;
  MainGeneralRaise: procedure (Code, Flags, NArgs: DWORD; Args: Pointer; Stack: DWord);
begin
  if (Code = cDelphiException) then
  begin
    if (Flags = cNonContinuable) and (NArgs = 7) then // Delphi exception...
    begin
      Obj := Args^.Obj;
      Addr := Args^.Addr;
      CurrentStackPointer := LastStackPointer;
      CurrentContext.Eax := DWord(Args^.Obj);
      CurrentContext.Ebx := Args^.EBX;
      CurrentContext.Ecx := LastECX;
      CurrentContext.Edx := DWord(Args^.Addr);
      CurrentContext.Esi := Args^.ESI;
      CurrentContext.Edi := Args^.EDI;
      CurrentContext.Ebp := Args^.EBP;
      CurrentContext.Esp := LastStackPointer;
      CurrentContext.Eip := DWord(Args^.Addr) - 5;
      CurrentContext.ContextFlags := CONTEXT_FULL;
{$IFNDEF CBuilder}
      if (CallGoNotify) then GoNotify(Obj, Addr, True, False);
{$ELSE}
      SetLastException(Obj, Addr, True);
      LastObj := Obj;
      LastAddr := Addr;
      if ((CurrentStackList = nil) and (GetCurrentThreadID = MainThreadID)) then
        CurrentStackList := GetCallStackByAddresses(Addr, CurrentStackPointer,
          GetCurrentTopOfStack, GetCurrentThreadID, True, True,
          -1, -1, [ddNone..ddSourceCode]);
{$ENDIF}
    end
{$IFDEF CBuilder}
    else
      if (Flags = cBCBExceptionFlag) and (NArgs = 8) then
      // CBuilder exception...
      begin
        LastObj := Args^.Obj;
        LastAddr := Pointer(DWord(Args^.Addr) + 4);
        CurrentStackPointer := LastStackPointer;
        CurrentContext.Eax := DWord(Args^.Obj);
        CurrentContext.Ebx := Args^.EBX;
        CurrentContext.Ecx := LastECX;
        CurrentContext.Edx := DWord(Args^.Addr);
        CurrentContext.Esi := Args^.ESI;
        CurrentContext.Edi := Args^.EDI;
        CurrentContext.Ebp := Args^.EBP;
        CurrentContext.Esp := LastStackPointer;
        CurrentContext.Eip := DWord(Args^.Addr) - 5;
        CurrentContext.ContextFlags := CONTEXT_FULL;
        if ((CurrentStackList = nil) and (GetCurrentThreadID = MainThreadID)) then
          CurrentStackList := GetCallStackByAddresses(LastAddr, CurrentStackPointer,
            GetCurrentTopOfStack, GetCurrentThreadID, True, True,
            -1, -1, [ddNone..ddSourceCode]);
        if (GetCurrentThreadID <> MainThreadID) or (IsConsole) then
          GoNotify(LastObj, LastAddr, True, False)
        else
          SetLastException(LastObj, LastAddr, True)
      end
{$ENDIF};
  end;
  if (OnlySafeCallExceptions) then
  begin
    @MainGeneralRaise := GetProcAddress(MainInstance, 'EurekaLog_CallGeneralRaise');
    if (Assigned(MainGeneralRaise)) then
      MainGeneralRaise(Code, Flags, NArgs, Args, LastStackPointer);
  end;
end;

procedure EurekaLog_CallGeneralRaise(Code, Flags, NArgs: DWord; Args: Pointer; Stack: DWord);
begin
  LastStackPointer := Stack;
  GeneralRaise(Code, Flags, NArgs, Args, False);
end;

procedure Call_HookedRaise(Code, Flags, NArgs: DWORD; Args: PExcArgs); stdcall;
var
  P: PExceptionRecord;
begin
  if (Code = cNonDelphiException) and
    (Flags = cContinuable) and (NArgs = 2) then
  begin
    P := PExceptionRecord(Args^.Addr);
    if ((IsValidBlockAddr(DWord(P), SizeOf(P^))) and
      (P^.ExceptionCode = $0001003F) and (not IsDebugged)) then Exit;
  end;

  if (not Assigned(Kernel_RaiseException)) then
    Kernel_RaiseException :=
      GetProcAddress(GetModuleHandle(PChar(Kernel32)), 'RaiseException');

  if (Initialized) then GeneralRaise(Code, Flags, NArgs, Args, True);

  Kernel_RaiseException(Code, Flags, NArgs, PDWord(Args));
end;

// Use this procedure to assign the "LastStackPointer" thread-safe variable
// from an assembler procedure...

procedure SetLastStackPointer(Value: DWord);
begin
  LastStackPointer := Value;
end;

procedure SetLastECX(Value: DWord);
begin
  LastECX := Value;
end;

procedure HookedRaise;
asm
  PUSH EAX
  PUSH EDX
  PUSH ECX
  MOV  EAX, ESP
  ADD  EAX, 60
  CALL SetLastStackPointer
  MOV  EAX, ECX
  CALL SetLastECX
  POP  ECX
  POP  EDX
  POP  EAX
  JMP  Call_HookedRaise // JMP preserve the Stack parameters.
  // Nothing...
end;

function EurekaLog_CallExceptObject(P: PExceptionRecord; C: PContext;
  CallGoNotify: Boolean): Exception;
var
  MainCallExceptObject:
    function (P: PExceptionRecord; C: PContext; CallGoNotify: Boolean): Exception;
begin
  Result := OldExceptObjProc(P);
  CurrentStackPointer := C^.ESP;
  CurrentContext := C^;
  CurrentContext.ContextFlags := CONTEXT_FULL;
  if ((CurrentStackList = nil) and (GetCurrentThreadID = MainThreadID)) then
    CurrentStackList := GetCallStackByAddresses(P^.ExceptionAddress,
      CurrentStackPointer, GetCurrentTopOfStack, GetCurrentThreadID, True, True,
      -1, -1, [ddNone..ddSourceCode]);
  if (GetCurrentThreadID <> MainThreadID) then
  begin
    if (CallGoNotify) then GoNotify(Result, P^.ExceptionAddress, False, False);
  end
  else SetLastException(Result, P^.ExceptionAddress, False);
  if (OnlySafeCallExceptions) then
  begin
    @MainCallExceptObject := GetProcAddress(MainInstance, 'EurekaLog_CallExceptObject');
    if (Assigned(MainCallExceptObject)) then MainCallExceptObject(P, C, False);
  end;
end;

function Call_HookedExceptionObject(P: PExceptionRecord; C: PContext): Exception;
begin
  Result := EurekaLog_CallExceptObject(P, C, True);
{$IFDEF CBuilder}
{$ENDIF}
end;

function HookedExceptionObject(PExcRec: PExceptionRecord): Exception; register;
asm // Get the PContext record pointer (EAX = PExcRec) ...
  MOV  EDX, ESP
  ADD  EDX, 8
  CMP  EAX, [EDX]               // Check for the type of caller procedure...
  JNE  @Label_HandleOnException // Caller procedure is System.HandleOnException

  MOV  EDX, ESP                 // Caller procedure is System.HandleAnyException
  ADD  EDX, 16
  MOV  EDX, [EDX]
  CALL Call_HookedExceptionObject
  JMP  @Label_End

@Label_HandleOnException:
  MOV  EDX, ESP
  ADD  EDX, 32
  MOV  EDX, [EDX]
  CALL Call_HookedExceptionObject

@Label_End:
end;

procedure Call_HookedRtlUnwind(TargetFrame, TargetIp: Pointer;
  ExceptionRecord: PExceptionRecord);
var
  Obj: Exception;
  Addr: Pointer;
begin
  if (not Assigned(Kernel_RtlUnwind)) then
    Kernel_RtlUnwind := GetProcAddress(GetModuleHandle(PChar(Kernel32)), 'RtlUnwind');

  // Check to avoid an IntraWeb 7.x exception bug!!!
  if ((IsIntraWeb) and (IntraWebCompressedPage) and (IntraWebApplication = nil)) and
    ((ExceptionRecord^.ExceptionCode = cDelphiException) and
    (ExceptionRecord^.ExceptionFlags = 3) and
    (ExceptionRecord^.NumberParameters = 7)) and
    (not IsDebugged) then DebugHook := 1;

  if (Initialized) then
  begin
    if (ExceptionRecord.ExceptionCode >= cExceptionCode0) and
    (ExceptionRecord.ExceptionCode <= cExceptionCode1) and
    (ExceptionRecord.ExceptionFlags = cUnwinding) then
    begin
      Addr := ExceptionRecord.ExceptionAddress;
      Obj := OldExceptObjProc(ExceptionRecord);
      try
        GoNotify(Obj, Addr, False, True);
      finally
        Obj.Free;
      end;
    end;
  end;
end;

procedure HookedRtlUnwind; assembler;
asm
  PUSH EAX
  MOV  EAX, ESP
  ADD  EAX, 8
  PUSH EDX
  PUSH ECX
  CALL SetLastStackPointer
  MOV  EAX, [ESP + $10]      // TargetFrame     : Pointer
  MOV  EDX, [ESP + $14]      // TargetIp        : Pointer
  MOV  ECX, [ESP + $18]      // ExceptionRecord : PExceptionRecord
  CALL Call_HookedRtlUnwind
  POP  ECX
  POP  EDX
  POP  EAX
  JMP  Kernel_RtlUnwind
end;

function HookedWriteFile(hFile: Integer; const Buffer; nNumberOfBytesToWrite: Cardinal;
  var lpNumberOfBytesWritten: Cardinal; lpOverlapped: Pointer): Integer; stdcall;
begin
  if (not Assigned(Kernel_WriteFile)) then
    Kernel_WriteFile := GetProcAddress(GetModuleHandle(PChar(Kernel32)), 'WriteFile');

{$IFDEF PROFESSIONAL}
  if (hFile = TTextRec(Output).Handle) and (IsCGI) then
  begin
    SetString(LastHTMLPage, PChar(@Buffer), nNumberOfBytesToWrite);
    CreateHTMLFile(LastHTMLPage);
  end;
{$ENDIF}

  Result := Kernel_WriteFile(hFile, Buffer, nNumberOfBytesToWrite,
    lpNumberOfBytesWritten, lpOverlapped);
end;

{$IFDEF CBuilder}

procedure GeneralUnhandledExceptionFilter(ExceptionPointers: PExceptionPointers);
var
  Obj: TObject;
  Addr: Pointer;
begin
  if (ExceptionPointers <> LastExceptionPointers) then
  begin
    Obj := OldExceptObjProc(ExceptionPointers^.ExceptionRecord);
    try
      if not (IsAParent(Obj, EExternalException)) then
      begin
        Addr := ExceptionPointers^.ExceptionRecord^.ExceptionAddress;
        CurrentStackPointer := ExceptionPointers^.Context^.ESP;
        CurrentContext := ExceptionPointers^.Context^;
        CurrentContext.ContextFlags := CONTEXT_FULL;
        GoNotify(Obj, Addr, False, False);
      end
      else
        if (LastAddr <> nil) then
        begin
          GoNotify(LastObj, LastAddr, True, False);
          LastObj := nil;
          LastAddr := nil;
        end;
      LastExceptionPointers := ExceptionPointers;
    finally
      Obj.Free;
    end;
  end;
end;
{$ENDIF}

{$IFDEF CBuilder}

function HookedUnhandledExceptionFilter(ExceptionPointers: Pointer): DWord; stdcall;
begin

  if (not Assigned(Kernel_UnhandledExceptionFilter)) then
    Kernel_UnhandledExceptionFilter :=
      GetProcAddress(GetModuleHandle(PChar(Kernel32)),
      'UnhandledExceptionFilter');

  if (Initialized) then
    GeneralUnhandledExceptionFilter(PExceptionPointers(ExceptionPointers));

  Result := Kernel_UnhandledExceptionFilter(ExceptionPointers);

end;
{$ENDIF}

procedure HookedExceptProc(ExceptionObject: TObject; ExceptionAddr: Pointer);
begin
  if (RaisedExceptAddr <> ExceptionAddr) then
  begin
    GoNotify(ExceptionObject, ExceptionAddr,
      IsDelphiException(ExceptionObject), False);
  end;

  if GetCurrentThreadID = MainThreadID then Halt(1)
  else ExitThread(1);
end;

{ TIdThread }

class procedure TIdThread.HandledException(Sender: TObject; E: Exception);
begin
  if ExceptionManager(E, ExceptAddr, rtUnknown, HInstance) then
  begin
    if (Assigned(Indy_OnException)) then Indy_OnException(Sender, E);
  end;
end;

//------------------------------------------------------------------------------

procedure HookedThreadExecute(Thread: TThread); // TThread.Execute
var
  ThreadData: TEurekaThreadInfo;
  Idx: Integer;

  procedure SetIndyEvent;
  var
    OldEvent: TIdExceptionEvent;
  begin
    OldEvent := TIdThread(Thread).FOnException;
    if (@OldEvent = @TIdThread.HandledException) then Exit;

    TIdThread(Thread).FOnException := TIdThread.HandledException;
    @Indy_OnException := @OldEvent;
  end;

begin
  if (not IndyHooked) and (IsAParentStr(Thread, 'TIdThread')) then SetIndyEvent;

  ThreadData.Thread := nil;
  if (Assigned(ThreadsList)) then
  begin
    ThreadsList.BeginWrite;
    try
      Idx := ThreadsList.FindByThreadObject(Thread);
      if (Idx <> -1) then
      begin
        ThreadsList[Idx]^.TopOfStack := GetCurrentTopOfStack;
        ThreadData := ThreadsList[Idx]^;
      end;
    finally
      ThreadsList.EndWrite;
    end;
  end;

  if (Assigned(ThreadData.Thread)) then
  try
    ThreadData.ExecuteMethod(Thread);
  except
    on Error: TObject do
    begin
{$IFDEF Delphi4Up}
      // To avoid the exception handling for the SetThreadName calling...
      if not ((Error is EExternal) and (EExternal(Error).ExceptionRecord <> nil) and
        (EExternal(Error).ExceptionRecord^.ExceptionCode = $406D1388)) then
{$ENDIF}
      if (ThreadData.ID = GetCurrentThreadID) then
        ExceptionManager(Error, ExceptAddr, rtUnknown, HInstance);
      raise;
    end;
  end;
end;

function HookedRTLThreadProc(Parameter: Pointer): Integer; // BeginThread
var
  ThreadData: TEurekaThreadInfo;
  Idx: Integer;
begin
  Result := -1;

  ThreadData.BeginThreadFunction := nil;
  if (Assigned(ThreadsList)) then
  begin
    ThreadsList.BeginWrite;
    try
      Idx := ThreadsList.FindByThreadID(GetCurrentThreadID);
      if (Idx <> -1) then
      begin
        ThreadsList[Idx]^.TopOfStack := GetCurrentTopOfStack;
        ThreadData := ThreadsList[Idx]^;
      end;
    finally
      ThreadsList.EndWrite;
    end;
  end;

  if (Assigned(ThreadData.BeginThreadFunction)) then
  try
    Result := ThreadData.BeginThreadFunction(ThreadData.Parameter);
  except
    on Error: TObject do
    begin
{$IFDEF Delphi4Up}
      // To avoid the exception handling for the SetThreadName calling...
      if not ((Error is EExternal) and (EExternal(Error).ExceptionRecord <> nil) and
        (EExternal(Error).ExceptionRecord^.ExceptionCode = $406D1388)) then
{$ENDIF}
      if (ThreadData.ID = GetCurrentThreadID) then
        ExceptionManager(Error, ExceptAddr, rtUnknown, HInstance);
      // raise; // WARNING! Do not reraise exception to avoid the process crash!
    end;
  end;
end;

function HookedThreadProc(Parameter: Pointer): Integer; stdcall; // CreateThread
var
  ThreadData: TEurekaThreadInfo;
  Idx: Integer;
begin
  Result := -1;

  ThreadData.CreateThreadFunction := nil;
  if (Assigned(ThreadsList)) then
  begin
    ThreadsList.BeginWrite;
    try
      Idx := ThreadsList.FindByThreadID(GetCurrentThreadID);
      if (Idx <> -1) then
      begin
        ThreadsList[Idx]^.TopOfStack := GetCurrentTopOfStack;
        ThreadData := ThreadsList[Idx]^;
      end;
    finally
      ThreadsList.EndWrite;
    end;
  end;

  if (Assigned(ThreadData.CreateThreadFunction)) then
  try
    Result := ThreadData.CreateThreadFunction(ThreadData.Parameter);
  except
    on Error: TObject do
    begin
{$IFDEF Delphi4Up}
      // To avoid the exception handling for the SetThreadName calling...
      if not ((Error is EExternal) and (EExternal(Error).ExceptionRecord <> nil) and
        (EExternal(Error).ExceptionRecord^.ExceptionCode = $406D1388)) then
{$ENDIF}
      if (ThreadData.ID = GetCurrentThreadID) then
        ExceptionManager(Error, ExceptAddr, rtUnknown, HInstance);
      // raise; // WARNING! Do not reraise exception to avoid the process crash!
    end;
  end;
end;

procedure EurekaLog_CallCreateThread(PData: PEurekaThreadInfo);
var
  ThreadData: PEurekaThreadInfo;
begin
  if ((not Initialized) or (ThreadsList = nil)) then Exit;
  if (not Assigned(OriginalThreadProc)) then GetThreadParams;
  ThreadsList.PurgeList;
  ThreadData := ThreadsList.NewItem(False);
  ThreadData^ := PData^;
  ThreadsList.BeginWrite;
  try
    ThreadsList.Add(ThreadData);
  finally
    ThreadsList.EndWrite;
  end;
end;
procedure EurekaLog_CallResumeThread(hThread: DWord; PData: PEurekaThreadInfo);
var
  i: Integer;
begin
  if ((Initialized = True) and (NotCatchCallerThread = False) and (ThreadsList <> nil)) then
  begin
    ThreadsList.BeginWrite;
    try
      i := ThreadsList.FindByThreadHandle(hThread);
      if (i <> -1) then
      begin
        ThreadsList[i]^ := PData^;
        ThreadsList[i]^.IsACopy := True;
      end;
    finally
      ThreadsList.EndWrite;
    end;
  end;
end;

procedure EurekaLog_CallExitThread;
begin
  if ((not Initialized) or (ThreadsList = nil)) then Exit;
  ThreadsList.RemoveCurrentThread;
end;

function HookedCreateThread(lpThreadAttributes: Pointer; dwStackSize: DWORD;
  lpStartAddress: TFNThreadStartRoutine; lpParameter: Pointer;
  dwCreationFlags: DWORD; lpThreadId: PDWord): DWord; stdcall;
var
  ThreadData: PEurekaThreadInfo;
  P: PThreadRec;
  MainCreateThread: procedure(PData: PEurekaThreadInfo);
  tmpThreadId: DWord;
begin
  if (not Assigned(Kernel_CreateThread)) then
    Kernel_CreateThread :=
      GetProcAddress(GetModuleHandle(PChar(Kernel32)), 'CreateThread');

  if (not Assigned(OriginalThreadProc)) then GetThreadParams;

  if (Initialized) then
  begin
    // Purge the ThreadsList...
    ThreadsList.PurgeList;

    // Create a local ThreadInto variable...
    ThreadData := ThreadsList.NewItem(False);
    ThreadData^.Parameter := lpParameter;

    if (lpThreadId = nil) then
    begin
      tmpThreadId := 0;
      lpThreadId := @tmpThreadId;
    end;

    // Check for TThread or Windows Thread...
    if (RoundMatchPtr(lpStartAddress, ThreadWrapperAddr)) then
    begin // RTL TThread...
      if (RoundMatchPtr(@PThreadRec(lpParameter)^.Func, @OriginalThreadProc)) then
      begin
        P := PThreadRec(lpParameter);
        ThreadData^.BeginThreadFunction := P^.Func;
        ThreadData^.Parameter := P^.Parameter;
        ThreadData^.Thread := TThread(P.Parameter);
        if (not IsAParents(ThreadData^.Thread, UnAttachableThreads)) then
          ThreadData^.ExecuteMethod :=
            HookVirtualMethod(ThreadData^.Thread.ClassType, 1, @HookedThreadExecute);
        Result := Kernel_CreateThread(lpThreadAttributes, dwStackSize,
          lpStartAddress, lpParameter, CREATE_SUSPENDED, lpThreadId);
      end
      else
      begin // BeginThread...
        P := PThreadRec(lpParameter);
        ThreadData^.BeginThreadFunction := P^.Func;
        ThreadData^.Parameter := P^.Parameter;
        P^.Func := @HookedRTLThreadProc;
        Result := Kernel_CreateThread(lpThreadAttributes, dwStackSize,
          lpStartAddress, lpParameter, CREATE_SUSPENDED, lpThreadId);
      end;
    end
    else
    begin // Windows Thread...
      ThreadData^.CreateThreadFunction := lpStartAddress;
      Result := Kernel_CreateThread(lpThreadAttributes, dwStackSize,
        @HookedThreadProc, lpParameter, CREATE_SUSPENDED, lpThreadId);
    end;

    // Fill then ThreadData...
    if ((Result <> 0) and (not IsAParents(ThreadData^.Thread, UnAttachableThreads))) then
    begin
      ThreadData^.ID := lpThreadId^;
      ThreadData^.Handle := Result;
      ThreadsList.BeginWrite;
      try
        ThreadsList.Add(ThreadData);
        if (OnlySafeCallExceptions) then
        begin
          @MainCreateThread := GetProcAddress(MainInstance, 'EurekaLog_CallCreateThread');
          if (Assigned(MainCreateThread)) then MainCreateThread(ThreadData);
        end;
      finally
        ThreadsList.EndWrite;
      end;
    end
    else
      Dispose(ThreadData);

    if (dwCreationFlags = 0) then ResumeThread(Result);
  end
  else
    Result := Kernel_CreateThread(lpThreadAttributes, dwStackSize,
      lpStartAddress, lpParameter, dwCreationFlags, lpThreadId);
end;

function HookedResumeThread(hThread: DWord): DWORD; stdcall;
var
  i: integer;
  StackPointer: DWord;
  MainResumeThread: procedure (hThread: DWord; PData: PEurekaThreadInfo);
begin
  asm
    MOV  StackPointer, EBP
    ADD  StackPointer, 4
  end;

  if (not Assigned(Kernel_ResumeThread)) then
    Kernel_ResumeThread :=
      GetProcAddress(GetModuleHandle(PChar(Kernel32)), 'ResumeThread');

  if ((Initialized = True) and (NotCatchCallerThread = False)) then
  begin
    ThreadsList.BeginWrite;
    try
      i := ThreadsList.FindByThreadHandle(hThread);
      if (i <> -1) then
      begin
        ThreadsList[i]^.CallerID := GetCurrentThreadID;
        if (ThreadsList[i]^.CallerStackDump <> nil) then
        begin
          FreeMem(ThreadsList[i]^.CallerStackDump, ThreadsList[i]^.CallerStackSize);
          ThreadsList[i]^.CallerStackSize := 0;
          ThreadsList[i]^.CallerStackDump := nil;
        end;
        ThreadsList[i]^.CallerStackSize := (GetCurrentTopOfStack - StackPointer);
        if IsValidBlockAddr(StackPointer, ThreadsList[i]^.CallerStackSize) then
        begin
          GetMem(ThreadsList[i]^.CallerStackDump, ThreadsList[i]^.CallerStackSize);
          Move(PDWord(StackPointer)^, ThreadsList[i]^.CallerStackDump^,
            ThreadsList[i]^.CallerStackSize);
        end;
      end;
      if (OnlySafeCallExceptions) and (i <> -1) then
      begin
        @MainResumeThread := GetProcAddress(MainInstance, 'EurekaLog_CallResumeThread');
        if (Assigned(MainResumeThread)) then MainResumeThread(hThread, ThreadsList[i]);
      end;
    finally
      ThreadsList.EndWrite;
    end;
  end;
  Result := Kernel_ResumeThread(hThread);
end;

procedure HookedExitThread(dwExitCode: DWORD); stdcall;
var
  MainExitThread: procedure;
begin
  if (not Assigned(Kernel_ExitThread)) then
    Kernel_ExitThread := GetProcAddress(GetModuleHandle(PChar(Kernel32)), 'ExitThread');

  if (Initialized) and (Assigned(ThreadsList)) then
  begin
    ThreadsList.RemoveCurrentThread;
    if (OnlySafeCallExceptions) then
    begin
      @MainExitThread := GetProcAddress(MainInstance, 'EurekaLog_CallExitThread');
      if (Assigned(MainExitThread)) then MainExitThread;
    end;
  end;

  Kernel_ExitThread(dwExitCode);
end;

function HookedWriteClientProc(ConnID: THandle; Buffer: Pointer;
  var Bytes: DWORD; dwReserved: DWORD): BOOL stdcall;
begin
  if (not ISAPI_SendError) then LastHTMLPage := PChar(Buffer);
  Result := ISAPI_WriteClientProc(ConnID, Buffer, Bytes, dwReserved);
end;

function HookedHttpExtensionProc(var ECB: PEXTENSION_CONTROL_BLOCK): DWORD; stdcall;
begin
  ServerECB := @ECB;
  ISAPI_WriteClientProc := ServerECB^.WriteClient;
  ServerECB^.WriteClient := @HookedWriteClientProc;
  Result := ISAPI_HttpExtensionProc(ECB);
end;

{ TEurekaStackList }

procedure TEurekaStackList.AddFrom(Source: PEurekaDebugInfo);
var
  DebugInfo: PEurekaDebugInfo;
begin
  New(DebugInfo);
  DebugInfo^.DebugDetail := Source^.DebugDetail;
  DebugInfo^.ModuleInfo := Source^.ModuleInfo;
  DebugInfo^.Addr := Source^.Addr;
  DebugInfo^.UnitName := Source^.UnitName;
  DebugInfo^.ClassName := Source^.ClassName;
  DebugInfo^.ProcedureName := Source^.ProcedureName;
  DebugInfo^.Line := Source^.Line;
  Add(DebugInfo);
end;

procedure TEurekaStackList.Clear;
var
  i: integer;
begin
  for i := 0 to (Count - 1) do Delete(0);
  inherited;
end;

procedure TEurekaStackList.Delete(Index: Integer);
var
  DebugInfo: PEurekaDebugInfo;
  Ptr: Pointer;
begin
  Ptr := Items[Index];
  DebugInfo := PEurekaDebugInfo(Ptr);
  Dispose(DebugInfo);
  inherited;
end;

destructor TEurekaStackList.Destroy;
begin
  Clear;
  inherited;
end;

function TEurekaStackList.GetItem(Index: Integer): PEurekaDebugInfo;
begin
  Result := PEurekaDebugInfo(TList(Self).Items[Index]);
end;

{ TEurekaModulesList }

procedure TEurekaModulesList.Clear;
var
  i: integer;
begin
  for i := 0 to (Count - 1) do Delete(0);
  inherited;
end;

procedure TEurekaModulesList.Delete(Index: Integer);
var
  ModuleInfo: PEurekaModuleInfo;
  Ptr: pointer;
begin
  Ptr := Items[Index];
  ModuleInfo := PEurekaModuleInfo(Ptr);
  ModuleInfo^.FunctionsList.Free;
  ModuleInfo^.ExtraInformation.Options.Free;
  if (ModuleInfo^.OtherDebugData <> nil) then
    ModuleInfo^.OtherDebugData.Free;
  if (ModuleInfo^.ExtraInformation.DebugInformation <> nil) then
    ModuleInfo^.ExtraInformation.DebugInformation.Free;
  Dispose(ModuleInfo);
  inherited;
end;

destructor TEurekaModulesList.Destroy;
begin
  Clear;
  inherited;
end;

function TEurekaModulesList.GetItem(Index: Integer): PEurekaModuleInfo;
begin
  Result := PEurekaModuleInfo(TList(Self).Items[Index]);
end;

{ TEurekaProcessesList }

procedure TEurekaProcessesList.Clear;
var
  i: integer;
begin
  for i := 0 to (Count - 1) do Delete(0);
  inherited;
end;

procedure TEurekaProcessesList.Delete(Index: Integer);
var
  ProcessInfo: PEurekaProcessInfo;
  Ptr: pointer;
begin
  Ptr := Items[Index];
  ProcessInfo := PEurekaProcessInfo(Ptr);
  Dispose(ProcessInfo);
  inherited;
end;

destructor TEurekaProcessesList.Destroy;
begin
  Clear;
  inherited;
end;

function TEurekaProcessesList.GetItem(Index: Integer): PEurekaProcessInfo;
begin
  Result := PEurekaProcessInfo(TList(Self).Items[Index]);
end;

{ TEurekaThreadsList }

constructor TEurekaThreadsList.Create(CopyList: TEurekaThreadsList);
var
  ThreadData: PEurekaThreadInfo;
  n: Integer;
begin
  inherited Create;
  FSimpleCopy := (CopyList <> nil);
  if (not FSimpleCopy) then FLock := TAsymmetricCriticalSection.Create
  else
  begin // Create a simple copy...
    CopyList.BeginRead;
    try
      for n := 0 to (CopyList.Count - 1) do
      begin
        New(ThreadData);
        ThreadData^ := CopyList[n]^;
        Add(ThreadData);
      end;
    finally
      CopyList.EndRead;
    end;
  end;
end;

destructor TEurekaThreadsList.Destroy;
begin
  Clear;
  if (not FSimpleCopy) then FLock.Free;
  inherited;
end;

procedure TEurekaThreadsList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do Delete(0);
  inherited;
end;

procedure TEurekaThreadsList.Delete(Index: Integer);
var
  ThreadData: PEurekaThreadInfo;
  Ptr: Pointer;
begin
  Ptr := Items[Index];
  ThreadData := PEurekaThreadInfo(Ptr);
  if ((not FSimpleCopy) and (not ThreadData^.IsACopy)) then
    FreeMem(ThreadData^.CallerStackDump, ThreadData^.CallerStackSize);
  Dispose(ThreadData);
  inherited;
end;

procedure TEurekaThreadsList.RemoveCurrentThread;
var
  Idx: Integer;
begin
  BeginWrite;
  try
    Idx := FindByThreadID(GetCurrentThreadID);
    if (Idx <> -1) then Delete(Idx);
  finally
    EndWrite;
  end;
end;

function TEurekaThreadsList.FindByThreadHandle(Handle: THandle): Integer;
var
  i: Integer;
begin
  // WARNING!!! No not change the down count order!
  // The last created thread my be checked as first (to guarantee the execution OS priority)!
  i := (Count - 1);
  while (i >= 0) and (Items[i]^.Handle <> Handle) do Dec(i);
  if (i >= 0) then Result := i
  else Result := -1;
end;

function TEurekaThreadsList.FindByThreadObject(Thread: TThread): Integer;
var
  i: Integer;
begin
  // WARNING!!! No not change the down count order!
  // The last created thread my be checked as first (to guarantee the execution OS priority)!
  i := (Count - 1);
  while (i >= 0) and (Items[i]^.Thread <> Thread) do Dec(i);
  if (i >= 0) then Result := i
  else Result := -1;
end;

function TEurekaThreadsList.FindByThreadID(ThreadID: THandle): Integer;
var
  i: Integer;
begin
  // WARNING!!! No not change the down count order!
  // The last created thread my be checked as first (to guarantee the execution OS priority)!
  i := (Count - 1);
  while (i >= 0) and (Items[i]^.ID <> ThreadID) do Dec(i);
  if (i >= 0) then Result := i
  else Result := -1;
end;

function TEurekaThreadsList.GetItem(Index: Integer): PEurekaThreadInfo;
begin
  Result := PEurekaThreadInfo(TList(Self).Items[Index]);
end;

procedure TEurekaThreadsList.BeginRead;
begin
  FLock.BeginRead;
end;

procedure TEurekaThreadsList.EndRead;
begin
  FLock.EndRead;
end;

procedure TEurekaThreadsList.BeginWrite;
begin
  FLock.BeginWrite;
end;

procedure TEurekaThreadsList.EndWrite;
begin
  FLock.EndWrite;
end;

function TEurekaThreadsList.NewItem(AddNow: Boolean): PEurekaThreadInfo;
begin
  New(Result);
  FillChar(Result^, SizeOf(Result^), #0);
  Result^.Priority := THREAD_PRIORITY_UNDEFINED;
  if (AddNow) then Add(Result);
end;

procedure TEurekaThreadsList.PurgeList;
var
  i: Integer;
begin
  BeginWrite;
  try
    // WARNING!!! No not change the down count order!
    // The last created thread my be checked as first (to guarantee the execution OS priority)!
    i := (Count - 1);
    while (i >= 0) do
    begin
      if (not IsValidRunningThread(Items[i]^.Handle)) then
      begin
        Delete(i);
        Dec(i);
      end;
      Dec(i);
    end;
  finally
    EndWrite;
  end;
end;

function TEurekaThreadsList.CallUnhandledException: Boolean;
var i: Integer;
begin
  Result := False;
  FLock.BeginRead;
  try
    i := FindByThreadID(GetCurrentThreadID);
    if (i <> -1) then Result := (not Items[i]^.ExceptionHandled);
  finally
   FLock.EndRead;
  end;
end;

function CanCallUnhandledException: Boolean;
begin
  Result := (boCatchHandledExceptions in CurrentEurekaLogOptions.BehaviourOptions)
    and (ThreadsList.CallUnhandledException);
  if (Result) then ThreadsList.SetExceptionType(GetCurrentThreadId, True);
end;

procedure TEurekaThreadsList.SetExceptionType(ThreadID: THandle; Handled: Boolean);
var i: Integer;
begin
  FLock.BeginWrite;
  try
    i := FindByThreadID(ThreadID);
    if (i <> -1) then Items[i]^.ExceptionHandled := Handled;
  finally
   FLock.EndWrite;
  end;
end;

{ TEurekaFunctionsList }

procedure TEurekaFunctionsList.Clear;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    Delete(0);
  inherited;
end;

procedure TEurekaFunctionsList.Delete(Index: Integer);
var
  FunctionInfo: PEurekaFunctionInfo;
  Ptr: pointer;
begin
  Ptr := Items[Index];
  FunctionInfo := PEurekaFunctionInfo(Ptr);
  Dispose(FunctionInfo);
  inherited;
end;

destructor TEurekaFunctionsList.Destroy;
begin
  Clear;
  inherited;
end;

function TEurekaFunctionsList.GetItem(Index: Integer): PEurekaFunctionInfo;
begin
  Result := PEurekaFunctionInfo(TList(Self).Items[Index]);
end;

{ TSafeObject }

function TSafeObject.GetSafeCall: DWord;
var
  Addr: PDWord;

  procedure CalcAddr;
  begin
    Result := ConvertAddress((DWord(Addr) + 4) + Addr^);
  end;

begin
  asm
    Call @Next
  @Next:
    Pop  EAX
    Add  EAX, $1C
    Mov  Addr, EAX
  end;
  CalcAddr;
end;

// -----------------------------------------------------------------------------

function IsEurekaLogInstalled: Boolean;
begin
  Result := Initialized;
end;

function CurrentEurekaLogOptions: TEurekaModuleOptions;
const
  EError =
    #13#10 +
    'Cannot use ''CurrentEurekaLogOptions'' function without activate EurekaLog.'#13#10 +
    'To activate EurekaLog use the new IDE "Project/EurekaLog Options..." menu.';
var
  ModuleInfo: PEurekaModuleInfo;
begin
  Assert(ModulesList <> nil, EError);
  ModuleInfo := ModuleInfoByHandle(HInstance);
  Assert(ModuleInfo <> nil, EError);
  Result := ModuleInfo^.ExtraInformation.Options;
end;

// -----------------------------------------------------------------------------

// Use this procedure to assign the "CurrentStackPointer" thread-safe variable
// from an assembler procedure...

procedure SetCurrentStackPointer(Value: DWord);
begin
  if (CurrentStackPointer = 0) then
  begin
    CurrentStackPointer := Value;
    CurrentContext.ContextFlags := 0;
  end;
end;

function StandardEurekaNotify(Obj: TObject; Addr: Pointer): Boolean;
asm
  CMP  Initialized, True
  JNE  @SetFalse

  PUSH EDX                      // Save Addr
  PUSH EAX                      // Save Obj
  MOV  EAX, ESP
  ADD  EAX, 12
  CALL SetCurrentStackPointer
  POP  EAX                      // Restore Obj
  PUSH EAX                      // Save Obj
  CALL IsDelphiException
  MOV  ECX, EAX                 // ECX = IsDelphiException
  POP  EAX                      // Restore Obj
  POP  EDX                      // Restore Addr
  PUSH 0
  PUSH 0
  PUSH 0
  PUSH 0
  PUSH HInstance
  PUSH 0
  PUSH False                    // Handled
  PUSH 0                        // CallStack
  CALL ExceptNotify
  MOV  EAX, True                // Result := True;
  JMP  @Finish

@SetFalse:
  MOV  EAX, False               // Result := False;

@Finish:
end;

procedure ShowLastExceptionData;

  function GetCurrentStackPointer: DWord;
  asm
    MOV  EAX, EBP
    ADD  EAX, 4
  end;

begin
  CurrentStackPointer := GetCurrentStackPointer;
  StandardEurekaNotify(GetLastExceptionObject, GetLastExceptionAddress);
end;

function StandardEurekaError(const Error: string): Boolean;
var
  E: Exception;
begin
  E := EEurekaLogGeneralError.Create(Error);
  try
    Result := StandardEurekaNotify(E, nil);
  finally
    E.Free;
  end;
end;

procedure CallEurekaLogFromActiveX(ExceptionType, ExceptionMessage, CallStack: string);
var
  Stack: TEurekaStackList;
  List: TStringList;
  Error: TActiveXException;
begin
  List := TStringList.Create;
  try
    List.Text := CallStack;
    List.SaveToFile('C:\Stack.txt');
  finally
    List.Free;
  end;
  Stack := TEurekaStackList.Create;
  Error := TActiveXException.Create(ExceptionType, ExceptionMessage);
  try
    ExceptNotify(Error, nil, False, 0, 0, nil, rtUnknown, 0, aeNone, False, Stack);
  finally
    Error.Free;
  end;
end;

function ForceApplicationTermination(TrmType: TTerminateBtnOperation): Boolean;
begin
  Result := IsEurekaLogInstalled;
  if Result then
  begin
    TerminateApplication := True;
    if (LastExceptionRecord = nil) then
      CurrentEurekaLogOptions.TerminateBtnOperation := TrmType
    else
      CurrentOptions.TerminateBtnOperation := TrmType;
  end;
end;

function GetLastEurekaLogErrorCode: TEurekaLogErrorCode;
begin
  Result := InternalErrorCode;
end;

function GetLastEurekaLogErrorMsg: string;
begin
  Result := InternalErrorMsg;
end;

function GetCurrentCallStack: TEurekaStackList;
asm
  CALL GetCurrentThreadID
  PUSH EAX                     // EAX = CurrentThreadID
  PUSH True
  PUSH True
  PUSH -1
  PUSH -1
  PUSH $1F
  CALL GetCurrentTopOfStack
  MOV  ECX, EAX                // ECX = TopOfStack
  MOV  EDX, ESP
  ADD  EDX, 4                  // EDX = StackPointer
  MOV  EAX, 0                  // EAX = nil
  CALL GetCallStackByAddresses
end;

function GetLastExceptionCallStack: TEurekaStackList;
begin
  Result := nil;
  if (LastExceptionCallStackSize = 0) then Exit;

  EnterCriticalSection(LastDumpCriticalSection);
  try
    Result := GetCallStackByAddresses(
      LastExceptionCallStackAddress, DWord(LastExceptionCallStackDump),
      DWord(LastExceptionCallStackDump) + LastExceptionCallStackSize - 1,
      LastExceptionThreadID, True, True, -1, -1, [ddNone..ddSourceCode]);
  finally
    LeaveCriticalSection(LastDumpCriticalSection);
  end;
end;

function GetCallStackByLevels(StartLevel, LevelsNumber: Integer): TEurekaStackList;
var
  DebugDetails: TEurekaDebugDetails;
  GetESP: DWord;
  Options: TEurekaModuleOptions;
begin
  asm
    MOV  EAX, EBP
    ADD  EAX, 4
    MOV  GetESP, EAX
  end;

  Result := nil;
  Options := CurrentEurekaLogOptions;
  if (Options = nil) then Exit;

  DebugDetails := GetDebugDetail(Options);
  Result := GetCallStackByAddresses(nil, GetESP, GetCurrentTopOfStack,
    GetCurrentThreadID, True, False, StartLevel, LevelsNumber, DebugDetails);
end;

procedure CallStackToStrings(CallStack: TEurekaStackList; Strings: TStrings);
var
  i, MaxAddress, MaxModule, MaxUnit, MaxClass, MaxProc, MaxLine, LineLen: Integer;
  s, l, LineStr: string;
  Empty: Boolean;
  Options: TEurekaModuleOptions;
begin
  if (CallStack = nil) then Exit;

  Options := CurrentEurekaLogOptions;
  if (Options = nil) then Exit;

  Empty := True;
  MaxAddress := 8;
  MaxModule := 0;
  MaxUnit := 0;
  MaxClass := 0;
  MaxProc := 0;
  MaxLine := 0;
  for i := 0 to (CallStack.Count - 1) do
  begin
    if (CallStack[i]^.DebugDetail in [ddProcedure..ddSourceCode]) then
    begin
      s := ExtractFileName(CallStack[i]^.ModuleInfo^.Name);
      if (Length(s) > MaxModule) then MaxModule := Length(s);
      if (Length(CallStack[i]^.UnitName) > MaxUnit) then
        MaxUnit := Length(CallStack[i]^.UnitName);
      if (Length(CallStack[i]^.ClassName) > MaxClass) then
        MaxClass := Length(CallStack[i]^.ClassName);
      if (Length(CallStack[i]^.ProcedureName) > MaxProc) then
        MaxProc := Length(CallStack[i]^.ProcedureName);
      s := IntToStr(CallStack[i]^.Line);
      s := (s + '[' + IntToStr(CallStack[i]^.ProcOffsetLine) + ']');
      if (Length(s) > MaxLine) then MaxLine := Length(s);
    end;
  end;

  if (Length(Options.CustomizedExpandedTexts[mtCallStack_Address]) > MaxAddress) then
    MaxAddress := Length(Options.CustomizedExpandedTexts[mtCallStack_Address]);
  if (Length(Options.CustomizedExpandedTexts[mtCallStack_Name]) > MaxModule) then
    MaxModule := Length(Options.CustomizedExpandedTexts[mtCallStack_Name]);
  if (Length(Options.CustomizedExpandedTexts[mtCallStack_Unit]) > MaxUnit) then
    MaxUnit := Length(Options.CustomizedExpandedTexts[mtCallStack_Unit]);
  if (Length(Options.CustomizedExpandedTexts[mtCallStack_Class]) > MaxClass) then
    MaxClass := Length(Options.CustomizedExpandedTexts[mtCallStack_Class]);
  if (Length(Options.CustomizedExpandedTexts[mtCallStack_Procedure]) > MaxProc) then
    MaxProc := Length(Options.CustomizedExpandedTexts[mtCallStack_Procedure]);
  if (Length(Options.CustomizedExpandedTexts[mtCallStack_Line]) > MaxLine) then
    MaxLine := Length(Options.CustomizedExpandedTexts[mtCallStack_Line]);

  LineLen := (MaxAddress + MaxModule + MaxUnit + MaxClass + MaxProc + MaxLine + 7);
  SetLength(LineStr, LineLen);
  FillChar(LineStr[1], LineLen, '-');

  for i := 0 to (CallStack.Count - 1) do
  begin
    if (CallStack[i]^.DebugDetail in [ddProcedure..ddSourceCode]) then
    begin
      if (Empty) then
      begin
        s := Format('|%s|%s|%s|%s|%s|%s|',
          [CompleteStr(Options.CustomizedExpandedTexts[mtCallStack_Address], MaxAddress),
          CompleteStr(Options.CustomizedExpandedTexts[mtCallStack_Name], MaxModule),
          CompleteStr(Options.CustomizedExpandedTexts[mtCallStack_Unit], MaxUnit),
          CompleteStr(Options.CustomizedExpandedTexts[mtCallStack_Class], MaxClass),
          CompleteStr(Options.CustomizedExpandedTexts[mtCallStack_Procedure], MaxProc),
          CompleteStr(Options.CustomizedExpandedTexts[mtCallStack_Line], MaxLine)]);
        Strings.Add(LineStr);
        Strings.Add(s);
        Strings.Add(LineStr);
      end;
      l := IntToStr(CallStack[i]^.Line);
      if (l <> '0') then
      begin
        l := (l + '[' + IntToStr(CallStack[i]^.ProcOffsetLine) + ']');
      end
      else l := '';
      s := Format('|%s|%s|%s|%s|%s|%s|',
        [IntToHex(CallStack[i]^.Addr, 8),
        CompleteStr(ExtractFileName(CallStack[i]^.ModuleInfo^.Name), MaxModule),
        CompleteStr(CallStack[i]^.UnitName, MaxUnit),
        CompleteStr(CallStack[i]^.ClassName, MaxClass),
        CompleteStr(CallStack[i]^.ProcedureName, MaxProc),
        CompleteStr(l, MaxLine)]);
      Strings.Add(s);
      Empty := False;
    end;
  end;
  if (not Empty) then Strings.Add(LineStr);
end;

function IsEurekaLogActiveInThread(ThreadID: DWord): Boolean;
begin
  EnterCriticalSection(ThreadsCriticalSection);
  try
    Result := (InactiveThreads.IndexOf(Pointer(ThreadID)) = -1);
  finally
    LeaveCriticalSection(ThreadsCriticalSection);
  end;
end;

procedure SetEurekaLogInThread(ThreadID: DWord; Activate: Boolean);
var
  Idx: Integer;
begin
  EnterCriticalSection(ThreadsCriticalSection);
  try
    Idx := InactiveThreads.IndexOf(Pointer(ThreadID));
    if (Activate) and (Idx <> -1) then
      InactiveThreads.Delete(Idx)
    else
      if (not Activate) and (Idx = -1) then
        InactiveThreads.Add(Pointer(ThreadID));
  finally
    LeaveCriticalSection(ThreadsCriticalSection);
  end;
end;

procedure SetEurekaLogState(Activate: Boolean);
begin
  ActivateEurekaLog := Activate;
end;

function IsEurekaLogActive: Boolean;
begin
  Result := ActivateEurekaLog;
end;

procedure StartAntiFreeze;
begin
  ManualAntiFreeze := True;
end;

procedure EndAntiFreeze;
begin
  ManualAntiFreeze := False;
end;

function GetCompilationDate(HModule: THandle; LocalTime: Boolean; var Date: TDateTime): Boolean;
var
  ModuleInfo: PEurekaModuleInfo;
begin
  Result := False;
  ModuleInfo := ModuleInfoByHandle(HModule);
  if (ModuleInfo <> nil) then
  begin
    Date := ModuleInfo^.ExtraInformation.CompilationDate;
    if (LocalTime) then Date := (Date + (GetGMT / 24));
    Result := True;
  end;
end;

// -----------------------------------------------------------------------------

function ExceptionManager(Obj: TObject; Addr: Pointer;
  RaiserType: TRaiserType; ModuleHandle: THandle): Boolean;
var
  MainExceptionManager: function(Obj: TObject; Addr: Pointer;
    RaiserType: TRaiserType; ModuleHandle: THandle): Boolean;

  function GetCurrentStackPointer: DWord;
  asm
    MOV  EAX, EBP
    ADD  EAX, 4
  end;

begin
  EnterCriticalSection(ExceptionCriticalSection);
  try
    if (OnlySafeCallExceptions) then
    begin
      @MainExceptionManager := GetProcAddress(MainInstance, 'ExceptionManager');
      if (Assigned(MainExceptionManager)) then
      begin
        Result := MainExceptionManager(Obj, Addr, RaiserType, HInstance);
        Exit;
      end;
    end;

    Result := True;

    if (IsEurekaLogActive) and (IsEurekaLogActiveInThread(GetCurrentThreadID)) and
      (IsManageableObject(Obj) or IsManageableObject(LastExceptObject)) then
    begin
{$IFNDEF PROFESSIONAL}
      if (DWord(FindHInstance(Addr)) <> MainInstance) or
        (IsCompiledWithPackages) or (IsWeb) then Exit;
{$ENDIF}
      if (not IsValidObject(Obj)) then
      begin
        Obj := LastExceptObject;
        Addr := LastExceptionAddress;
      end;
      if (CurrentStackPointer = 0) then CurrentStackPointer := GetCurrentStackPointer;
      Result := ExceptNotify(Obj, Addr, LastDelphiException, 0, 0, nil,
        RaiserType, ModuleHandle, aeNone, False, nil);
    end;
  finally
    LeaveCriticalSection(ExceptionCriticalSection);
  end;
end;

{$IFDEF Delphi5Down}

// CGI Applications...

procedure Hooked_CGIHandleServerException_D5Down(E: TObject;
  const OutputFile: string);
begin
  if ExceptionManager(ExceptObject, ExceptAddr, rtWeb, HInstance) then
    CGIHandleException_D5Down(E, OutputFile);
end;

// ISAPI Applications...

procedure Hooked_ISAPIHandleServerException_D5Down(E: TObject;
  var ECB: TEXTENSION_CONTROL_BLOCK);
begin
  if ExceptionManager(ExceptObject, ExceptAddr, rtWeb, HInstance) then
    ISAPIHandleException_D5Down(E, ECB);
end;
{$ELSE}

// CGI Applications...

procedure Hooked_CGIHandleServerException(Self, Sender: TObject);
begin
  if ExceptionManager(ExceptObject, ExceptAddr, rtWeb, HInstance) then
    CGIHandleException(Self, Sender);
end;

// ISAPI Applications...

procedure Hooked_ISAPIHandleServerException(Self, Sender: TObject);
begin
  if ExceptionManager(ExceptObject, ExceptAddr, rtWeb, HInstance) then
    ISAPIHandleException(Self, Sender);
end;
{$ENDIF}

// GUI Applications...

procedure Hooked_VCLHandleException(Self, Sender: TObject);
begin
  if (Global_CurrentEvent <> nil) or
    (ExceptionManager(ExceptObject, ExceptAddr, rtLocal, HInstance)) then
  begin
    Global_IntoHandleException := True;
    try
      VCLHandleException(Self, Sender);
    finally
      Global_IntoHandleException := False;
    end;
  end;
end;

procedure Hooked_VCLShowException(Self, Error: Exception);
begin
  if (Global_CurrentEvent <> nil) or (Global_IntoHandleException) or
    ExceptionManager(Error, ExceptAddr, rtLocal, HInstance) then
    VCLShowException(Self, Error);
end;

{$IFDEF Delphi6Up}

procedure Hooked_CLXHandleException(Self, Sender: TObject);
begin
  if ExceptionManager(ExceptObject, ExceptAddr, rtLocal, HInstance) then
    CLXHandleException(Self, Sender);
end;

procedure Hooked_CLXShowException(Self, Error: Exception);
begin
  if (IsEurekaLogActive) and (IsEurekaLogActiveInThread(GetCurrentThreadID)) then
  begin
    if ExceptionManager(Error, ExceptAddr, rtLocal, HInstance) then
      CLXShowException(Self, Error);
  end
  else CLXHandleException(Self, Error);
end;
{$ENDIF}

// IntraWeb Applications...

function Hooked_IntraWebCreateServer(Self, Owner: TObject): TObject;
var
  PropInfo: PPropInfo;
  Addr: DWord;
begin
  Result := IntraWeb_CreateServer(Self, Owner);
  IntraWebServerController := Result;

  PropInfo := GetPropInfo(IntraWebServerController.ClassInfo, 'Compression');
  if (PropInfo <> nil) then
  begin
    Addr := (GetOrdProp(IntraWebServerController, PropInfo) + 4);
    if (IsValidBlockAddr(Addr, 1)) then IntraWebCompressedPage := PBoolean(Addr)^;
  end;

  PropInfo := GetPropInfo(IntraWebServerController.ClassInfo, 'Version');
  if (PropInfo <> nil) then
    IntraWeb_Version := GetStrProp(IntraWebServerController, PropInfo)
  else
    IntraWeb_Version := '5.0.0';
  IntraWeb_NewEvent := (IntraWeb_Version >= '7.2.32');
  SetIntraWebEvent;
end;

// IntraWeb SendResponse...

procedure Hooked_IntraWebSendResponse(Self: TInHTTPAppResponse);
var
  Mem, GZipIn, GZipOut: TMemoryStream;
  OldPos: Integer;
  HTML: string;

  function IsHTMLPage: Boolean;
  begin
    Result := (Self.FContentStream <> nil) and
      (LowerCase(Self.FResponseInfo.FContentType) = 'text/html');
  end;

  procedure ExtractGZipStream(const InStream, OutStream: TMemoryStream);
  type
    TGZipHeader = packed record
      ID1, ID2, CM, FLG: Byte;
      MTime: DWord;
      XFL, OS: Byte;
    end;
  var
    Name: string;
    ZData, Data: Pointer;
    ZSize, Size: Integer;
    Header: TGZipHeader;
  begin
    InStream.Read(Header, SizeOf(Header));
    if (Header.FLG and $08 <> 0) then
    begin
      Name := PChar(DWord(InStream.Memory) + SizeOf(TGZipHeader));
      InStream.Position := (SizeOf(TGZipHeader) + Length(Name) + 1);
    end;
    ZSize := (InStream.Size - InStream.Position - 8) + 6;
    GetMem (ZData, ZSize);
    try
      InStream.Read(Pointer(DWord(ZData) + 2)^, (ZSize - 6));
      PWord(ZData)^ := $DA78; // ZLib header
      PDWord(Integer(ZData) + ZSize - 4)^ := 1; // Adler32

      ZDecompress(ZData, ZSize, Data, Size);
      try
        OutStream.Write(Data^, Size);
      finally
        Freemem(Data, Size);
      end;
    finally
      FreeMem(ZData, ZSize);
    end;
  end;

begin
  if (IsHTMLPage) then
  begin
    Mem := TMemoryStream.Create;
    try
      OldPos := Self.FContentStream.Position;
      try
        Self.FContentStream.Position := 0;
        Mem.CopyFrom(Self.FContentStream, Self.FContentStream.Size);
        SetString(HTML, PChar(Mem.Memory), Mem.Size);
        if (Global_WebTextID = '') or (Pos(Global_WebTextID, HTML) = 0) then
        begin
          // Check for GZip compression...
          IntraWebCompressedPage := (Copy(HTML, 1, 2) = #$1F#$8B {GZip header});
          if (IntraWebCompressedPage) then
          begin
            GZipIn := TMemoryStream.Create;
            try
              GZipIn.Write(HTML[1], Length(HTML));
              GZipIn.Position := 0;
              GZipOut := TMemoryStream.Create;
              try
                ExtractGZipStream(GZipIn, GZipOut);
                GZipOut.Position := 0;
                SetLength(HTML, GZipOut.Size);
                GZipOut.Read(HTML[1], GZipOut.Size);
              finally
                GZipOut.Free;
              end;
            finally
              GZipIn.Free;
            end;
          end;
          LastHTMLPage := HTML;
        end;
      finally
        Self.FContentStream.Position := OldPos;
      end;
    finally
      Mem.Free;
    end;
  end;
  IntraWeb_SendResponse(Self);
end;

// NT Services...

procedure Hooked_NTServiceLogMessage(Self: TObject; Message: string;
  EventType: DWord; Category: Integer; ID: Integer);
var
  CallServiceLog: Boolean;
begin
  CallServiceLog := (Global_CurrentEvent <> nil) or (Global_IntoHandleException) or
    (ExceptObject = nil);

  if (CallServiceLog) then
    NTService_LogMessage(Self, Message, EventType, Category, ID)
  else
  begin
    ExceptionManager(ExceptObject, ExceptAddr, rtUnknown, HInstance);
    NTService_LogMessage(Self, Message, EventType, Category, ID);
  end;
end;

// Indy Threads...

procedure Hooked_IndyThreadHandleException(Self: TObject; AException: Exception);
begin
  if (ExceptionManager(AException, ExceptAddr, rtUnknown, HInstance)) then
    IndyThread_HandleException(Self, AException);
end;

// DoneExcept...

procedure Hooked_DoneExcept;
asm
  CMP  Initialized, True
  JNE  @Finish

  CALL CanCallUnhandledException
  CMP  AL, True
  JNE  @Finish

  MOV  EAX, LastExceptionCallStackDump
  ADD  EAX, (LastExceptionCallStackSize - 1)
  PUSH EAX                                   // TopOfStack
  PUSH LastExceptionCallStackDump            // StackPoint
  PUSH 0                                     // Context
  PUSH 0                                     // RaiserType
  PUSH HInstance                             // ModuleHandle
  PUSH 0                                     // AsynchronousException
  PUSH True                                  // Handled
  PUSH 0                                     // CallStack
  CALL IsDelphiException
  MOV  ECX, EAX                              // ECX = IsDelphiException
  CALL ExceptAddr                            // EDX = Exception Addr
  MOV  EDX, EAX
  PUSH EDX
  CALL ExceptObject                          // EAX = Exception Object
  POP  EDX
  CALL ExceptNotify

@Finish:
  JMP  DoneExcept
end;

{ TFreezeThread }

constructor TFreezeThread.Create;
begin
  inherited Create(True);
end;

procedure TFreezeThread.Execute;
const
  TimeBit = 50; // Dont decrease less of 25 mSec (for old PC).
var
  WResult, hWnd: DWord;
  Frozen: Boolean;
  Context: TContext;
  E: Exception;
  Step, N: Integer;
begin
  hWnd := 0;

  if (not ManualAntiFreeze) then
  begin
    repeat // Check for a valid MainWindow...
      hWnd := GetMainWindow(GetCurrentProcessID);
      if hWnd = 0 then Sleep(TimeBit);
    until (Terminated) or (hWnd <> 0);
  end;

  repeat
    Step := 0;
    repeat
      if (not ManualAntiFreeze) then
        Frozen := (SendMessageTimeout(hWnd, WM_NULL, 0, 0,
          SMTO_BLOCK, TimeBit, WResult) = 0) and (IsWindow(hWnd))
      else
      begin
        Sleep(TimeBit);
        Frozen := ManualAntiFreeze;
      end;
      if (Frozen) then Inc(Step, TimeBit)
      else
      begin
        N := 0;
        repeat
          Sleep(TimeBit);
          Inc(N);
        until (Terminated) or (N = 5); // Increase "5" to reduce the CPU usage.
        Step := 0;
      end;
    until (Terminated) or (Step >= CurrentEurekaLogOptions.FreezeTimeout * 1000);
    Frozen := (not Terminated) and (Step >= CurrentEurekaLogOptions.FreezeTimeout * 1000);
    if (Frozen) then
    begin
      SuspendThread(MainThreadHandle);
      NotCatchCallerThread := True;
      try
        FillChar(Context, SizeOf(Context), #0);
        Context.ContextFlags := CONTEXT_FULL;
        if (GetThreadContext(MainThreadHandle, Context)) and
          (Context.EIP <> 0) and (Context.ESP <> 0) then
        begin
          E := EFrozenApplication.Create(
            CurrentEurekaLogOptions.CustomizedExpandedTexts[mtException_AntiFreeze]);
          try
            ExceptNotify(E, Pointer(Context.EIP), False,
              MainThreadTopOfStack, Context.ESP, @Context, rtUnknown,
              HInstance, aeNone, False, nil);
          finally
            E.Free;
          end;
        end;
      finally
        ResumeThread(MainThreadHandle);
        NotCatchCallerThread := False;
      end;
    end;
  until (Terminated);
end;

//------------------------------------------------------------------------------

procedure InitCheckFreeze;
begin
  if (OnlySafeCallExceptions) and
    (boUseMainModuleOptions in CurrentEurekaLogOptions.BehaviourOptions) then Exit;

  NotLoadDebugInfo := True;
  try
    if (IntoIDE) or (FreezeThread <> nil) or
      (not CurrentEurekaLogOptions.FreezeActivate) then Exit;

    FreezeThread := TFreezeThread.Create;
    FreezeThread.FreeOnTerminate := False;
    FreezeThread.Priority := tpNormal;
    FreezeThread.Resume;

    ManualAntiFreeze := False;
  finally
    NotLoadDebugInfo := False;
  end;
end;

procedure DoneCheckFreeze;
begin
  if (IntoIDE) or (FreezeThread = nil) then Exit;

  FreezeThread.Terminate;
  if (not IsModuleLibrary(HInstance)) then
    WaitForSingleObject(FreezeThread.Handle, INFINITE)
  else
    TerminateThread(FreezeThread.Handle, 1);
  FreezeThread.Free;
  FreezeThread := nil;
end;

//------------------------------------------------------------------------------

{ TEurekaModuleOptionsEx }

procedure TEurekaModuleOptionsEx.SetActive(const Value: Boolean);
begin
  if (Self = CurrentEurekaLogOptions) then
  begin
    if (Active <> Value) then
    begin
      inherited;
      if (Value) and (FreezeActivate) then
        InitCheckFreeze
      else
        DoneCheckFreeze;
    end;
  end
  else
    inherited;
end;

procedure TEurekaModuleOptionsEx.SetFreezeActivate(const Value: Boolean);
begin
  if (Self = CurrentEurekaLogOptions) then
  begin
    if (FreezeActivate <> Value) then
    begin
      inherited;
      if (Value) and (Active) then
        InitCheckFreeze
      else
        DoneCheckFreeze;
    end
  end
  else
    inherited;
end;

procedure TEurekaModuleOptionsEx.StoreSharedData;
var
  MemStream: TMemoryStream;
  OK: Boolean;
begin
  inherited;
  MemStream := TMemoryStream.Create;
  try
    OK := True; // Information usable.
    MemStream.Write(OK, 1);
    SaveToStream(MemStream);
    DeleteVirtualFile(ModuleInfoHandle, ModuleInfoData);
    ModuleInfoHandle := CreateVirtualFile(HInstance, 'MODULE',
      MemStream.Size, ModuleInfoData);
    // Copy the shared data...
    Move(MemStream.Memory^, ModuleInfoData^, MemStream.Size);
  finally
    MemStream.Free;
  end;
end;

//------------------------------------------------------------------------------

{ THTTPConnection }

procedure THTTPConnection.SetSendState(ASendState: TSendState; APercent: Integer);
begin
  case ASendState of
    ssConnecting:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Connecting]);
        SetSendDialogBar(5);
      end;
    ssConnected:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Connected]);
        SetSendDialogBar(10);
      end;
    ssLogin:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Login]);
        SetSendDialogBar(15);
      end;
    ssSelectProject:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_SelectProject]);
        SetSendDialogBar(20);
      end;
    ssSearching:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Searching]);
        SetSendDialogBar(25);
      end;
    ssModifying:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Modifying]);
        SetSendDialogBar(25 + Round(75 / (APercent + 1)* 100));
      end;
    ssSending:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Sending]);
        SetSendDialogBar(25 + Round(75 / (APercent + 1) * 100));
      end;
    ssSent:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Sent]);
      end;
    ssDisconnecting:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Disconnecting]);
      end;
    ssDisconnected:
      begin
        SetSendDialogSingleLabel(CurrentOptions.CustomizedExpandedTexts[mtSendDialog_Disconnected]);
      end;
  end;
end;

//------------------------------------------------------------------------------

function FastMM_LogStackTrace(AReturnAddresses: PCardinal; AMaxDepth: Cardinal;
  ABuffer: PChar; ShowDLLsFunctions, ShowBPLsFunctions, ShowProcLineOffset: Boolean): PChar;
var
  LInd, LAddress: Cardinal;
  LastReturnAddresses: PCardinal;
  LNumChars, ItemsOk: Cardinal;
  LInfo: TEurekaDebugInfo;
  LTempStr, ModuleName, ProcName, LineStr: string;
  Addr, ThreadID: DWord;

  function IsOKDebugInfo(DebugInfo: TEurekaDebugInfo): Boolean;
  begin
    Result :=
      (ShowDLLsFunctions and (DebugInfo.DebugDetail in [ddProcedure..ddSourceCode])) or
      (ShowBPLsFunctions and (DebugInfo.DebugDetail in [ddUnitAndProcedure..ddSourceCode])) or
      (DebugInfo.DebugDetail = ddSourceCode) or
      ((ShowDLLsFunctions) and (ShowBPLsFunctions));
  end;

begin
  Result := ABuffer;
  if (not Initialized) then
  begin
    LTempStr := Format(#13#10'You must activate EurekaLog in the "%s" module.',
      [ExtractFileName(ModuleFileName(Hinstance))]);
    LNumChars := Length(LTempStr);
    StrLCopy(Result, PChar(LTempStr), LNumChars);
    Inc(Result, LNumChars);
    Exit;
  end;

  ItemsOk := 0;
  ThreadID := GetCurrentThreadId;
  LastReturnAddresses := AReturnAddresses;
  LInd := 0;
  while (LInd <= AMaxDepth - 1) do
  begin
    LAddress := AReturnAddresses^;

    if (not IsValidBlockAddr(LAddress, 4)) then Break;

    Addr := (DWord(LAddress) - 1);
    GetDebugInfosByAddr(Addr, ThreadID, @LInfo, True, False);
    if (IsOKDebugInfo(Linfo)) then
    begin
      Inc(ItemsOk);
      LastReturnAddresses := PCardinal((DWord(AReturnAddresses) + 4));
      LTempStr := (' ' + IntToHex(LAddress, 8) + ' ');
      Result^ := #13;
      Inc(Result);
      Result^ := #10;
      Inc(Result);
      if (LInfo.ModuleInfo <> nil) then
        ModuleName := ExtractFileName(LInfo.ModuleInfo^.Name)
      else
        ModuleName := '';

      if (ModuleName <> '') then
        LTempStr := (LTempStr + '[' + ModuleName + '] ');
      if (LInfo.UnitName <> '') then
        LTempStr := (LTempStr + LInfo.UnitName + ' ');
      if (LInfo.ProcedureName <> '') then
      begin
        ProcName := LInfo.ProcedureName;
        if (LInfo.ClassName <> '') then ProcName := (LInfo.ClassName + '.' + ProcName);
        LTempStr := (LTempStr + '- ' + ProcName + ' ');
      end;
      if (LInfo.Line <> 0) then
      begin
        LineStr := IntToStr(LInfo.Line);
        if (ShowProcLineOffset) then
          LineStr := (LineStr + '[' + IntToStr(LInfo.ProcOffsetLine) + ']');
        LTempStr := (LTempStr + '(Line: ' + LineStr + ')');
      end;

      if Length(LTempStr) < 256 then LNumChars := Length(LTempStr)
      else LNumChars := 255;

      StrLCopy(Result, PChar(LTempStr), LNumChars);
      Inc(Result, LNumChars);
      Inc(LInd);
    end;
    {Next address}
    Inc(AReturnAddresses);
  end;
  if (ItemsOk < AMaxDepth) and ((not ShowDLLsFunctions) or (not ShowBPLsFunctions)) then
  begin
    if (not ShowBPLsFunctions) then ShowBPLsFunctions := True
    else
      if (not ShowDLLsFunctions) then ShowDLLsFunctions := True;
    Result := FastMM_LogStackTrace(LastReturnAddresses, (AMaxDepth - ItemsOk),
      Result, ShowDLLsFunctions, ShowBPLsFunctions, ShowProcLineOffset);
  end;
end;
//------------------------------------------------------------------------------

procedure Create_EurekaLogUnitsList;
var
  n: Integer;
begin
  EurekaLogUnitsList := TStringList.Create;
  EurekaLogUnitsList.Sorted := True;
  for n := low(EurekaLogUnits) to high(EurekaLogUnits) do
  begin
    EurekaLogUnitsList.Add(EurekaLogUnits[n]);
  end;
end;

{$IFNDEF CBuilder}

procedure Internal_ResetLeaks;
var
  ClassesInitialization, SysUtilsInitialization: procedure;
{$IFNDEF CBuilder}
  ModuleInfo: PEurekaModuleInfo;
{$ENDIF}
begin
  if (not IsEurekaLogActive) then Exit;

  try
    // Call BASIC Units Initializations...
    SysUtilsInitialization := GetSymbolAddr(SysUtilsInit_ID);
    if (Assigned(SysUtilsInitialization)) then SysUtilsInitialization;
  except
    MessageBox(MsgBoxhWnd, 'Error in SysUtils Initialization.',
      'Error', MB_OK or MB_ICONWARNING or MessageBoxFlags);
  end;

  try
    ClassesInitialization := GetSymbolAddr(ClassesInit_ID);
    if (Assigned(ClassesInitialization)) then ClassesInitialization;
  except
    MessageBox(MsgBoxhWnd, 'Error in Classes Initialization.',
      'Error', MB_OK or MB_ICONWARNING or MessageBoxFlags);
  end;

  try
    LeakTotalSize := 0;
    LeakTotalCount := 0;
    LeakAddr := UnassignedPointer;

    Initialized := True;
    LeaksStackList := TEurekaStackList.Create;

    ModuleInfoHandle := CreateVirtualFile(HInstance, 'MODULE', 1, ModuleInfoData);
    PBoolean(ModuleInfoData)^ := False; // Information unusable.

    ModulesList := TEurekaModulesList.Create;
  {$IFNDEF CBuilder}
    // Load CurrentModule EurekaLog options...
    ModuleInfo := ModuleInfoByHandle(HInstance);
    if (ModuleInfo <> nil) and (ModuleInfo.ExtraInformation.Options <> nil) and
      (FileExists(TmpOptionsFileName)) then
      ModuleInfo.ExtraInformation.Options.LoadFromFile(TmpOptionsFileName);
  {$ENDIF}
    ProcessesList := TEurekaProcessesList.Create;
    ThreadsList := TEurekaThreadsList.Create(nil);
    CurrentOptions := TEurekaModuleOptionsEx.Create('', False);
    CurrentOptions.Assign(CurrentEurekaLogOptions);
    InitializeCriticalSection(ThreadsCriticalSection);
    InitializeCriticalSection(LastDumpCriticalSection);
    InitializeCriticalSection(ExceptionCriticalSection);
    InitializeCriticalSection(HandledCacheCriticalSection);
    GetMem(LastExceptionCallStackDump, MaxCallStackSize);
    MainThreadHandle := 0;
    DuplicateHandle(GetCurrentProcess, GetCurrentThread, GetCurrentProcess,
      @MainThreadHandle, THREAD_MY_ACCESS, False, 0);
    with ThreadsList.NewItem(True)^ do
    begin
      ID := MainThreadID;
      Handle := MainThreadHandle;
      TopOfStack := GetCurrentTopOfStack;
    end;
    ExceptionsTime := TStringList.Create;
    CurrentProcessWindowsList := TList.Create;
    InactiveThreads := TList.Create;
    Create_EurekaLogUnitsList;
    Global_AttachedFiles := TStringList.Create;
    Global_WebFields := TStringList.Create;
    Global_DataFields := TStringList.Create;
    GetOutOfMemoryCache;
  except
    InternalCriticalError('Internal_ResetLeaks');
  end;
end;

procedure Internal_AddLeak(const LeakType: string; LeakSize, LeakCount: DWord;
  LeakCallStack: TRawCallStack);
var
  n: Integer;
  DebugInfo: PEurekaDebugInfo;
  First: Boolean;
begin
  if (not IsEurekaLogActive) then Exit;

  First := False;
  try
    for n := 0 to (RawCallStackLength - 1) do
    begin
      New(DebugInfo);
      GetDebugInfosByAddr(LeakCallStack[n], 0, DebugInfo, True, (n = 0));
      if not (DebugInfo^.DebugDetail in [ddProcedure..ddSourceCode]) then Dispose(DebugInfo)
      else
      begin
        if (not First) then
        begin
          First := True;
          if not (DebugInfo^.DebugDetail in [ddSourceCode]) then
          begin
            Dispose(DebugInfo);
            Exit;
          end;
        end;
        DebugInfo^.IsALeak := True;
        DebugInfo^.LeakType := LeakType;
        DebugInfo^.LeakSize := LeakSize;
        DebugInfo^.LeakCount := LeakCount;
        LeaksStackList.Add(DebugInfo);
      end;
    end;

    Inc(LeakTotalSize, LeakSize);
    Inc(LeakTotalCount, LeakCount);
    if (LeakAddr = UnassignedPointer) then LeakAddr := Pointer(LeakCallStack[0])
    else
      if (Pointer(LeakCallStack[0]) <> LeakAddr) then LeakAddr := nil;
  except
    InternalCriticalError('Internal_AddLeak');
  end;
end;

procedure Internal_ShowLeaks;
var
  Error: Exception;
  ClassesFinalization, SysUtilsFinalization: procedure;
begin
  if (not IsEurekaLogActive) then Exit;

  if (LeakTotalSize > 0) then
  begin
    try
      // Activate the Leaks Detection Limits...
      // ---------------------------------------------------------------------------
      // Disable EurekaLog events...
      NoSynchronizeEvent := True;
      // Disable the Assembler/CPU sections...
      CurrentEurekaLogOptions.LogOptions :=
        (CurrentEurekaLogOptions.LogOptions - [loSaveAssemblerAndCPUSections]);

      Error := EMemoryLeak.CreateFmt('%s: %s=%d - %s=%d',
        [CurrentOptions.CustomizedExpandedTexts[mtCallStack_LeakCaption],
        CurrentOptions.CustomizedExpandedTexts[mtCallStack_LeakSize], LeakTotalSize,
        CurrentOptions.CustomizedExpandedTexts[mtCallStack_LeakCount], LeakTotalCount]);
      try
        ExceptNotify(Error, LeakAddr, False, 0, 0, nil,
            rtUnknown, HInstance, aeNone, False, LeaksStackList);
      finally
        Error.Free;
      end;
    except
      InternalCriticalError('Internal_ShowLeaks');
    end;
  end
  else
  begin
    LeaksStackList.Free;
    LeaksStackList := nil;
  end;

  try
    Initialized := False;
    ModulesList.Free;
    ModulesList := nil;
    ProcessesList.Free;
    ProcessesList := nil;
    CurrentOptions.Free;
    CurrentOptions := nil;
    DeleteCriticalSection(ExceptionCriticalSection);
    DeleteCriticalSection(ThreadsCriticalSection);
    DeleteCriticalSection(LastDumpCriticalSection);
    DeleteCriticalSection(HandledCacheCriticalSection);
    FreeMem(LastExceptionCallStackDump, MaxCallStackSize);
    LastExceptionCallStackDump := nil;
    ThreadsList.Free;
    ThreadsList := nil;
    ExceptionsTime.Free;
    ExceptionsTime := nil;
    CurrentProcessWindowsList.Free;
    CurrentProcessWindowsList := nil;
    InactiveThreads.Free;
    InactiveThreads := nil;
    EurekaLogUnitsList.Free;
    EurekaLogUnitsList := nil;
    Global_AttachedFiles.Free;
    Global_AttachedFiles := nil;
    Global_WebFields.Free;
    Global_WebFields := nil;
    Global_DataFields.Free;
    Global_DataFields := nil;
    CloseHandle(MainThreadHandle);
    DeleteVirtualFile(ModuleInfoHandle, ModuleInfoData);
    CloseLogFile;

    // Free all used strings...
    CGIOutputFile := '';
    LanguageStr := '';
    LastHTMLPage := '';
    IntraWeb_Version := '';
    CurrentAsmErrorLine := '';
    CurrentGeneralErrorText := '';
    CurrentAsmErrorText := '';
    CurrentCPUErrorText := '';
    LastExceptMessage := '';
    CustomExceptMessage := '';
    LastLog := '';
    LastExceptionLog := '';
    StartDir := '';
    InternalErrorMsg := '';
    CurrentRequestValue := '';
    UserEmail := '';
    LastExceptionType := '';
    LastExceptionMessage := '';
    LastBugID := '';
    MultiFreeExceptionText := '';
    MemoryOverrunExceptionText := '';
    Global_Password := '';
    Global_LastInitPassword := '';
    Global_IntraWebText := '';
    Global_WebTextID := '';
    Opened_LogFile_Name := '';
    CaptionFontName := '';
    FixedFontName1 := '';
    FixedFontName2 := '';
    OldGlobal_ExceptionRecord.LogText := '';
    Global_ExceptionRecord.LogText := '';
    FreeOutOfMemoryCache;
  {$IFDEF PROFESSIONAL}
    SavedLastHTMLPage := '';
  {$ENDIF}
  except
    MessageBox(MsgBoxhWnd, 'Error in Internal_ShowLeaks Finalization.',
      'Error', MB_OK or MB_ICONWARNING or MessageBoxFlags);
  end;

  try
    // Call BASIC Units Finalizations...
    ClassesFinalization := GetSymbolAddr(ClassesFInit_ID);
    if (Assigned(ClassesFinalization)) then ClassesFinalization;
  except
    MessageBox(MsgBoxhWnd, 'Error in Classes Finalization.',
      'Error', MB_OK or MB_ICONWARNING or MessageBoxFlags);
  end;

  try
    SysUtilsFinalization := GetSymbolAddr(SysUtilsFInit_ID);
    if (Assigned(SysUtilsFinalization)) then SysUtilsFinalization;
  except
    MessageBox(MsgBoxhWnd, 'Error in SysUtils Finalization.',
      'Error', MB_OK or MB_ICONWARNING or MessageBoxFlags);
  end;
end;

procedure Internal_OverrunProc;
begin
  raise EMemoryOverrun.Create(MemoryOverrunExceptionText);
end;

procedure Internal_MultiFreeProc;
begin
  raise EMultiFree.Create(MultiFreeExceptionText);
end;

procedure Internal_Finalization;
begin
  // Absure to use the Windows.DeleteFile routines instead of the
  // SysUtils.DeleteFile routine to avoid the use of GetMem after the last
  // Finalization.
  Windows.DeleteFile(FixedTmpOptionsFile);
end;

procedure CheckForMemoryLeaks;
begin
  // Leaks Internal routines...
  ResetLeaks := Internal_ResetLeaks;
  AddLeak := Internal_AddLeak;
  ShowLeaks := Internal_ShowLeaks;

  // Leaks exceptions internal routines...
  OverrunProc := Internal_OverrunProc;
  MultiFreeProc := Internal_MultiFreeProc;

  // Finalization section...
  StrCopy(FixedTmpOptionsFile, PChar(TmpOptionsFileName));
  FinalizationProc := Internal_Finalization;
end;

{$ENDIF}

//------------------------------------------------------------------------------

procedure Init;
{$IFDEF EUREKALOG_DEMO}
var
  ModuleInfo: PEurekaModuleInfo;
  NowTime: TDateTime;
  TrialExpired: Boolean;
{$ENDIF}

  function RealAddr(const Addr): Pointer;
  begin
    Result := @Addr;
  end;

  procedure SetMainThreadTopOfStack;
  asm
    Mov EAX, FS:[4]
    Mov MainThreadTopOfStack, EAX
  end;

  function HandleAnyExceptionAddr: DWord;
  var
    Addr: PDWord;
  begin
    try
    except
    end;
    asm
      Call @One
  @One:
      Pop  EAX
      Sub  EAX, $E
      Mov  Addr, EAX
    end;
    Result := ConvertAddress((DWord(Addr) + 4) + Addr^);
  end;

  function HandleOnExceptionAddr: DWord;
  var
    Addr: PDWord;
  begin
    try
    except
      on TObject do
    end;
    asm
      Call @One
  @One:
      Pop  EAX
      Sub  EAX, $1A
      Mov  Addr, EAX
    end;
    Result := ConvertAddress((DWord(Addr) + 4) + Addr^);
  end;

  function HandleAutoExceptionAddr: DWord;
  var
    Obj: TSafeObject;
  begin
    Obj := TSafeObject.Create;
    try
      Result := Obj.GetSafeCall;
    finally
      Obj.Free;
    end;
  end;

  function DoneExceptAddr: DWord;
  var
    Addr: PDWord;
  begin
    try
    except
    end;
    asm
      Call @One
  @One:
      Pop  EAX
      Sub  EAX, $9
      Mov  Addr, EAX
    end;
    Result := ConvertAddress((DWord(Addr) + 4) + Addr^);
  end;

{$IFNDEF CBuilder}

  // To fix a Compiler bug that sometimes change the units finalization order...
  procedure ChangeFinalizationOrder;
  var
    InfoTable: PackageInfo;
    i: integer;
    OldProtectionCode: DWord;
    NewFInitList: TList;
    CurrentFInit, FastMM4FInit, ELeaksFInit, SystemFInit: Pointer;
  begin
    InfoTable := ModuleInitTable;

    // Change the Finalization order...
    NewFInitList := TList.Create;
    try
      SystemFInit := GetSymbolAddr(SystemFInit_ID);
      if (not Assigned(SystemFInit)) then SystemFInit := Pointer(1)
      else NewFInitList.Add(SystemFInit);

      FastMM4FInit := GetSymbolAddr(FastMM4FInit_ID);
      if (not Assigned(FastMM4FInit)) then FastMM4FInit := Pointer(1)
      else NewFInitList.Add(FastMM4FInit);

      ELeaksFInit := GetSymbolAddr(ELeaksFInit_ID);
      if (not Assigned(ELeaksFInit)) then ELeaksFInit := Pointer(1)
      else NewFInitList.Add(ELeaksFInit);

      for i := 0 to (InfoTable^.UnitCount - 1) do
      begin
  {$IFDEF Delphi6Up}
        CurrentFInit := InfoTable^.UnitInfo^[i].FInit;
  {$ELSE}
        CurrentFInit := @InfoTable^.UnitInfo^[i].FInit;
  {$ENDIF}
        if (CurrentFInit <> ELeaksFInit) and (CurrentFInit <> FastMM4FInit) and
          (CurrentFInit <> SystemFInit) then NewFInitList.Add(CurrentFInit);
      end;

      for i := 0 to (InfoTable^.UnitCount - 1) do
      begin
        VirtualProtect(RealAddr(InfoTable^.UnitInfo^[i].FInit), 4,
          PAGE_EXECUTE_READWRITE, @oldProtectionCode);
        InfoTable^.UnitInfo^[i].FInit := NewFInitList[i];
      end;
    finally
      NewFInitList.Free;
    end;
  end;


  procedure Hook_InitializationAndFinalization;
  var
    InfoTable: PackageInfo;
    i: integer;
    OldProtectionCode: DWord;

    procedure HookLastInit;
    begin
      asm
        CALL LastInitializationPtr
        MOV  IntoInitialization, False
      end;
{$IFDEF Delphi6Up} // To avoid random AV...
      if (not IsValidBlockAddr(DWord(LastInitPointer), 4)) then
      begin
        VirtualProtect(LastInitPointer, 4, PAGE_EXECUTE_READWRITE, @OldProtectionCode);
        LastInitPointer^ := Addr(LastInitializationPtr);
        VirtualProtect(LastInitPointer, 4, OldProtectionCode, @OldProtectionCode);
        FlushInstructionCache(GetCurrentProcess, LastInitPointer, 4);
      end
      else
{$ENDIF}
      LastInitPointer^ := Addr(LastInitializationPtr);
    end;

    procedure HookLastFInit;
    asm
      MOV  IntoFinalization, True
      CALL LastFinalizationPtr
    end;

  begin
    InfoTable := ModuleInitTable;

    i := InfoTable^.UnitCount - 1;
    while (i >= 0) and (not Assigned(InfoTable^.UnitInfo^[i].Init)) do Dec(i);
    if Assigned(InfoTable^.UnitInfo^[i].Init) then
    begin
      LastInitializationPtr := InfoTable^.UnitInfo^[i].Init;
      VirtualProtect(RealAddr(InfoTable^.UnitInfo^[i].Init), 4,
        PAGE_EXECUTE_READWRITE, @oldProtectionCode);
      LastInitPointer := RealAddr(InfoTable^.UnitInfo^[i].Init);
      LastInitPointer^ := Addr(HookLastInit);
    end;
    i := InfoTable^.UnitCount - 1;
    while (i >= 0) and (not Assigned(InfoTable^.UnitInfo^[i].FInit)) do Dec(i);
    if Assigned(InfoTable^.UnitInfo^[i].FInit) then
    begin
      LastFinalizationPtr := InfoTable^.UnitInfo^[i].FInit;
      VirtualProtect(RealAddr(InfoTable^.UnitInfo^[i].FInit), 4,
        PAGE_EXECUTE_READWRITE, @oldProtectionCode);
      InfoTable^.UnitInfo^[i].FInit := Addr(HookLastFInit);
    end;
  end;
{$ENDIF}

  procedure Hook_OnExceptionEvents;
  var
    i: integer;

    function IntraWeb_BPL(ver: integer): string;
    var
      s: string;
    begin
      s := Real_RADVersionString;
      Delete(s, Pos('.', s), 1);
      Result := 'Intraweb_' + IntToStr(ver) + '_' + s + '.bpl';
    end;

  begin
    // Hook VCL TApplication.HandleException...
    VCLHandleException := HookBPLProcedureBySymbol(VCL1_ID,
{$IFDEF Delphi4Up}
      VCL,
      '@Forms@TApplication@HandleException$qqrp14System@TObject',
{$ELSE}
      'VCL30.DPL',
      'Forms.TApplication.HandleException@23EDC2EF',
{$ENDIF}
      @Hooked_VCLHandleException);

    // Hook VCL TApplication.ShowException...
    VCLShowException := HookBPLProcedureBySymbol(VCL2_ID,
{$IFDEF Delphi4Up}
      VCL,
      '@Forms@TApplication@ShowException$qqrp18Sysutils@Exception',
{$ELSE}
      'VCL30.DPL',
      'Forms.TApplication.ShowException@23EDC2EF',
{$ENDIF}
      @Hooked_VCLShowException);

    if (IntoIDE) then Exit; // To avoid the IDE crash on exit.

{$IFDEF Delphi5Down}
    CGIHandleException_D5Down := HookSymbolProcedure(
      CGI_ID,
      @Hooked_CGIHandleServerException_D5Down);
    ISAPIHandleException_D5Down := HookSymbolProcedure(
      ISAPI_ID,
      @Hooked_ISAPIHandleServerException_D5Down);
{$ELSE}
    CGIHandleException := HookSymbolProcedure(
      CGI_ID,
      @Hooked_CGIHandleServerException);
    ISAPIHandleException := HookSymbolProcedure(
      ISAPI_ID,
      @Hooked_ISAPIHandleServerException);
{$ENDIF}

{$IFDEF Delphi6Up}
    // Hook CLX TApplication.HandleException...
    CLXHandleException :=
      HookBPLProcedureBySymbol(CLX1_ID, CLX,
      '@Qforms@TApplication@HandleException$qqrp14System@TObject',
      @Hooked_CLXHandleException);
    CLXShowException :=
      HookBPLProcedureBySymbol(CLX2_ID, CLX,
      '@Qforms@TApplication@ShowException$qqrp18Sysutils@Exception',
      @Hooked_CLXShowException);
{$ENDIF}

    i := 10;
    repeat
      // Hook IntraWeb...
      IntraWeb_CreateServer :=
        HookBPLProcedureBySymbol(IWebSrv_ID, IntraWeb_BPL(i),
        '@Iwservercontrollerbase@TIWServerControllerBase@$bctr$qqrp18Classes@TComponent',
        @Hooked_IntraWebCreateServer);
      IntraWeb_ShowMessage := HookBPLProcedureBySymbol(IWebApp_ID, IntraWeb_BPL(i),
        '@Iwapplication@TIWApplication@ShowMessage$' +
        'qqr17System@AnsiStringx26Iwtypes@TIWShowMessageTypet1', nil);
      Inc(i);
    until (@IntraWeb_CreateServer <> nil) or (i >= 99);

    IntraWeb_SendResponse :=
      HookBPLProcedureBySymbol(IWebRes_ID, IntraWeb_BPL(i),
      '',
      @Hooked_IntraWebSendResponse);

    NTService_LogMessage :=
      HookBPLProcedureBySymbol(NTService_ID, VCL,
      '@Svcmgr@TService@LogMessage$qqr17System@AnsiStringuiii',
      @Hooked_NTServiceLogMessage);

    IndyThread_HandleException :=
      HookBPLProcedureBySymbol(IndyThread_ID, INDY,
      '@Idthread@TIdThread@DoException$qqrp18Sysutils@Exception',
      @Hooked_IndyThreadHandleException);

    IndyHooked := Assigned(IndyThread_HandleException);

    DoneExcept := HookBPLProcedureByAddr(Pointer(DoneExceptAddr), '',
      'DoneExcept',
      @Hooked_DoneExcept);
  end;

  procedure SetDebugHook;
  begin
    if (not IsWeb) and (IsConsole) then DebugHook := 1;
  end;

  function HookingModuleName: string;
  begin
    Result := ModuleFileName(FindClassHInstance(System.TObject));
  end;

  function InstanceModuleName: string;
  begin
{$IFDEF CBuilder}
    Result := ModuleFileName(HInstance);
{$ELSE}
    Result := '';
{$ENDIF}
  end;

  function HookingRTLModuleName: string;
  {$IFDEF CBuilder}
  var
    HModule: THandle;
    ver: string;
  begin
    ver := CppBuilderRTLVer;
    // CBuilder RTL single thread...
    HModule := GetModuleHandle(PChar('CC32' + ver + '.DLL'));
    if (HModule = 0) then // CBuilder RTL multi threads...
      HModule := GetModuleHandle(PChar('CC32' + ver + 'MT.DLL'));
    Result := ModuleFileName(HModule);
  {$ELSE}
  begin
    Result := ''; // Delphi haven't RTL...
{$ENDIF}
  end;

  procedure FindMainInstance;
  var
    n: Integer;
  begin
    if (MainInstance <> 0) or (ModulesList = nil) then Exit;

    GetModulesList;
    for n := 0 to (ModulesList.Count - 1) do
    begin
      if (not IsModuleLibrary(ModulesList[n]^.Handle)) and
      (IsEurekaLogModule(ModulesList[n]^.Handle)) then
      begin
        MainInstance := ModulesList[n]^.Handle;
        Exit;
      end;
    end;
  end;

  function CheckCrc32: Boolean;
  var
    OptHeader: PImageOptionalHeader;
    Data: TMemoryStream;
    OldCheckSum, NewCheckSum: DWord;

    procedure LoadFromFile(MemStream: TMemoryStream; const FileName: string);
    var
      Stream: TStream;
    begin
      Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
      try
        MemStream.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
    end;

  begin
    Result := True;
    if (not FileExists(ModuleFileName(HInstance))) then Exit;

    Data := TMemoryStream.Create;
    try
      LoadFromFile(Data, ModuleFileName(HInstance));
      if (PWord(Data.Memory)^ <> $5A4D {MZ}) then Exit;

      OptHeader := PImageOptionalHeader(DWord(Data.Memory) + PDWord(DWord(Data.Memory) + $3C)^ + $18);
      OldCheckSum := OptHeader^.CheckSum;
      OptHeader^.CheckSum := 0;
      NewCheckSum := GetCRC32(Data.Memory, Data.Size);
      Result := (OldCheckSum = NewCheckSum);
    finally
      Data.Free;
    end;
  end;

begin
  if (not (IsWin95 or IsWinNT)) then IDC_CURSOR := MakeIntResource(32649)
  else IDC_CURSOR := MakeIntResource(32512);

  @CriticalError := @InternalCriticalError;

  OnlySafeCallExceptions :=
    ((HInstance <> MainInstance) and (IsEurekaLogCompatibleModule(MainInstance)));

  CanHookLibraries :=
    ((not OnlySafeCallExceptions) or (not IsCompiledWithPackages));

  Initialized := True;
  NoSynchronizeEvent := False;
  CannotUseThread := False;
  IsDialogShowed := False;
  StartDir := GetCurrentDir;
  IntoInitialization := True;
  IntoFinalization := False;
  SynchronizeExcept := 0;
  SynchronizeRaise := 0;
  OriginalThreadProc := nil;
  ExceptionNotify := nil;
  ExceptionActionNotify := nil;
  ExceptionErrorNotify := nil;
  Cached_LogFile := nil;
  CurrentContext.ContextFlags := 0;
  AutoCloseTimer := 0;
  Global_WebTextID := '';
  LastExceptionCallStackSize := 0;
  GetMem(LastExceptionCallStackDump, MaxCallStackSize);
  HandledCacheCount := 0;
  FillChar(HandledCache, SizeOf(HandledCache), #0);
  InitializeCriticalSection(HandledCacheCriticalSection);
  DebugHook_Assigned := False;

  HandleAnyExceptionAddr_Variable := HandleAnyExceptionAddr;
  HandleOnExceptionAddr_Variable := HandleOnExceptionAddr;
  HandleAutoExceptionAddr_Variable := HandleAutoExceptionAddr;

  SetDebugHook;

  if not IntoIDE then
  begin
{$IFNDEF CBuilder}
    Hook_InitializationAndFinalization;
{$ENDIF}

    if (not IsEurekaLogModule(HInstance)) then
    begin
      Initialized := False;
      Exit;
    end;
  end;

  ModulesList := TEurekaModulesList.Create;
  ProcessesList := TEurekaProcessesList.Create;

  ModuleInfoHandle := CreateVirtualFile(HInstance, 'MODULE', 1, ModuleInfoData);
  PBoolean(ModuleInfoData)^ := False; // Information unusable.

  CurrentOptions := TEurekaModuleOptionsEx.Create('', False);

{$IFDEF EUREKALOG_DEMO}
  if not IntoIDE then
  begin
    NowTime := (Now - (GetGMT / 24)); // GMT normalized.
    ModuleInfo := ModuleInfoByHandle(HInstance);
    TrialExpired := (not IntoIDE) and
      ((NowTime - ModuleInfo^.ExtraInformation.CompilationDate < -1) or
      // for different time zones
      (NowTime - ModuleInfo^.ExtraInformation.CompilationDate > 30));
    if (TrialExpired) then
    begin
      if (IsConsole) then
        WriteLn(EurekaDemoString)
      else
        if (not IsWeb) then
          MessageBox(MsgBoxhWnd, PChar(Format(EurekaDemoString,
            [ExtractFileName(ModuleFileName(HInstance))])),
            EErrorCaption, MB_OK or MB_ICONERROR or MessageBoxFlags);
      ModulesList.Free;
      ProcessesList.Free;
      CurrentOptions.Free;
      KillApplication(False);
    end;
    ModulesList.Clear;
  end;
{$ENDIF}

  SetMainThreadTopOfStack;

  EurekaLogList := TEurekaLogList.Create;
  Global_AttachedFiles := TStringList.Create;
  Global_WebFields := TStringList.Create;
  Global_DataFields := TStringList.Create;
  CurrentProcessWindowsList := TList.Create;

  TerminateApplication := False;
  StartingDate := Now;
  ExceptionNotify := nil;
  ExceptionNumber := 0;
  CGIOutputFile := '';
  ServerECB := nil;
  MainThreadHandle := 0;
  DuplicateHandle(GetCurrentProcess, GetCurrentThread, GetCurrentProcess,
    @MainThreadHandle, THREAD_MY_ACCESS, False, 0);

  ThreadsList := TEurekaThreadsList.Create(nil);
  with ThreadsList.NewItem(True)^ do
  begin
    ID := MainThreadID;
    Handle := MainThreadHandle;
    TopOfStack := GetCurrentTopOfStack;
  end;

  ClearInternalError;
  InitializeCriticalSection(ThreadsCriticalSection);
  InitializeCriticalSection(LastDumpCriticalSection);
  ExceptionsTime := TStringList.Create;

  InactiveThreads := TList.Create;
  Create_EurekaLogUnitsList;
  Global_CurrentEvent := nil;
  CurrentRequestValue := '';
  UserEmail := '';
  IsDialogShowed := False;
  ActivateEurekaLog := True;
  NotLoadDebugInfo := False;
  DuplicatedException := False;
  LastExceptObject := nil;
  RaisedExceptAddr := nil;

  IntraWebApplication := nil;
  IntraWebServerController := nil;
  IntraWebCompressedPage := False;

  FreezeThread := nil;
{$IFDEF Delphi5Up}
  NoErrMsg := True;
{$ENDIF}

  InitializeCriticalSection(ExceptionCriticalSection);

  if (not IntoIDE) and (CanHookLibraries) then // To avoid the IDE crash on exit.
  begin
    @OldExceptProc := ExceptProc;
    ExceptProc := @HookedExceptProc;
    @OldExceptObjProc := ExceptObjProc;
    ExceptObjProc := @HookedExceptionObject;

    Hook_OnExceptionEvents;

    // Hooked "RaiseException" Windows API...
    TryHookDllProcedureEx(
      [InstanceModuleName, HookingModuleName, HookingRTLModuleName],
      kernel32, 'RaiseException',
      @HookedRaise, @Kernel_RaiseException, True);

    // Hooked "RtlUnwind" Windows API...
    TryHookDllProcedureEx(
      [InstanceModuleName, HookingModuleName, HookingRTLModuleName],
      kernel32, 'RtlUnwind',
      @HookedRtlUnwind, @Kernel_RtlUnwind, True);

    // Hooked "WriteFile" Windows API...
    TryHookDllProcedureEx(
      [InstanceModuleName, HookingModuleName, HookingRTLModuleName],
      kernel32, 'WriteFile',
      @HookedWriteFile, @Kernel_WriteFile, True);

    // Hooked "HttpExtensionProc" ISAPI API...
    ISAPI_Proc := GetProcAddress(HInstance, 'HttpExtensionProc');
    if (ISAPI_Proc <> nil) then
    begin
      ISAPI_HttpExtensionProc :=
        HookProcedureEx(ISAPI_Proc, @HookedHttpExtensionProc,
        'HttpExtensionProc');
    end;

{$IFDEF CBuilder}
    // Hooked "UnhandledExceptionFilter" Windows API...
    TryHookDllProcedureEx(
      [InstanceModuleName, HookingModuleName, HookingRTLModuleName],
      kernel32, 'UnhandledExceptionFilter',
      @HookedUnhandledExceptionFilter, @Kernel_UnhandledExceptionFilter, True);
{$ENDIF}

    // Hooked "CreateThread" Windows API...
    TryHookDllProcedureEx(
      [InstanceModuleName, HookingModuleName, HookingRTLModuleName],
      kernel32, 'CreateThread',
      @HookedCreateThread, @Kernel_CreateThread, True);

    // Hooked "ResumeThread" Windows API...
    TryHookDllProcedureEx(
      [InstanceModuleName, HookingModuleName, HookingRTLModuleName],
      kernel32, 'ResumeThread',
      @HookedResumeThread, @Kernel_ResumeThread, True);

    // Hooked "ExitThread" Windows API...
    TryHookDllProcedureEx(
      [InstanceModuleName, HookingModuleName, HookingRTLModuleName],
      kernel32, 'ExitThread',
      @HookedExitThread, @Kernel_ExitThread, True);
  end;

  if (not IntoIDE) then InitCheckFreeze;

  if (IntoIDE) then GetModulesList;

  if (IsModuleLibrary(Hinstance)) then
  begin
    FindMainInstance;
    OnlySafeCallExceptions :=
      ((HInstance <> MainInstance) and (IsEurekaLogCompatibleModule(MainInstance)));
  end;

  if (not IntoIDE) then
  begin
    if (cfoCheckFileCorruption in CurrentEurekaLogOptions.CompiledFileOptions) and
      (not CheckCrc32) then
    begin
      if IsConsole then WriteLn(CurrentEurekaLogOptions.CustomizedExpandedTexts[mtFileCrackedMsg])
      else MessageBox(MsgBoxhWnd,
        PChar(CurrentEurekaLogOptions.CustomizedExpandedTexts[mtFileCrackedMsg]),
        PChar(CurrentEurekaLogOptions.CustomizedExpandedTexts[mtErrorMsgCaption]),
        MB_OK or MB_ICONERROR or MessageBoxFlags);
      KillApplication(False);
    end;

{$IFNDEF CBuilder}
    CheckForMemoryLeaks;
    ChangeFinalizationOrder;
{$ENDIF}
  end;
end;

procedure Done;
{$IFNDEF CBuilder}
var
  ModuleInfo: PEurekaModuleInfo;
{$ENDIF}
begin
  try
    if (not Initialized) then Exit;

    EnterCriticalSection(ExceptionCriticalSection);
    LeaveCriticalSection(ExceptionCriticalSection);

    if (CurrentStackList <> nil) then CurrentStackList.Free;
    CurrentStackList := nil;

    EurekaLogList.Free;
    EurekaLogList := nil;
    Global_AttachedFiles.Free;
    Global_AttachedFiles := nil;
    Global_WebFields.Free;
    Global_WebFields := nil;
    Global_DataFields.Free;
    Global_DataFields := nil;
    CurrentProcessWindowsList.Free;
    CurrentProcessWindowsList := nil;

    DoneCheckFreeze;
    CloseHandle(MainThreadHandle);

    if (not IntoIDE) and (CanHookLibraries) then
    begin
      ExceptProc := @OldExceptProc;
      ExceptObjProc := @OldExceptObjProc;
    end;

    if (IsEurekaLogActive) then
      SetEurekaLogState(IsEurekaLogActiveInThread(GetCurrentThreadID));

    InactiveThreads.Free;
    InactiveThreads := nil;
    EurekaLogUnitsList.Free;
    EurekaLogUnitsList := nil;
    ExceptionsTime.Free;
    ExceptionsTime := nil;

    DeleteCriticalSection(ThreadsCriticalSection);
    DeleteCriticalSection(LastDumpCriticalSection);
    DeleteCriticalSection(ExceptionCriticalSection);
    ThreadsList.Free;
    ThreadsList := nil;
  {$IFNDEF CBuilder}
    // Store CurrentModule EurekaLog options...
    if (not IntoIDE) then
    begin
      ModuleInfo := ModuleInfoByHandle(HInstance);
      if (ModuleInfo <> nil) and (ModuleInfo.ExtraInformation.Options <> nil) then
        ModuleInfo.ExtraInformation.Options.SaveToFile(TmpOptionsFileName);
    end;
  {$ENDIF}
    ModulesList.Free;
    ModulesList := nil;
    ProcessesList.Free;
    ProcessesList := nil;
    CurrentOptions.Free;
    CurrentOptions := nil;

    DeleteVirtualFile(ModuleInfoHandle, ModuleInfoData);
    ModuleInfoHandle := 0;

    CloseLogFile;
    Initialized := False;
  finally
    FreeMem(LastExceptionCallStackDump, MaxCallStackSize);
    LastExceptionCallStackDump := nil;
    DeleteCriticalSection(HandledCacheCriticalSection);
  end;
end;

exports
  EurekaLog_CallCreateThread,
  EurekaLog_CallResumeThread,
  EurekaLog_CallExitThread,
  EurekaLog_CallExceptObject,
  EurekaLog_CallGeneralRaise,
  ExceptionManager,
  EurekaLog_PasswordRequestEvent,
  EurekaLog_PasswordRequestEventEx,
  EurekaLog_ExceptionNotifyEvent,
  EurekaLog_HandledExceptionNotifyEvent,
  EurekaLog_ExceptionActionNotifyEvent,
  EurekaLog_ExceptionErrorNotifyEvent,
  EurekaLog_CustomDataRequestEventEx,
  EurekaLog_AttachedFilesRequestEvent,
  EurekaLog_CustomWebFieldsRequestEvent,
  EurekaLog_CustomButtonClickEvent;

//------------------------------------------------------------------------------

initialization
  SafeExec(Init, 'ExceptionLog.Init');
  GetOutOfMemoryCache;

finalization
  SafeExec(Done, 'ExceptionLog.Done');
  FreeOutOfMemoryCache;

end.

