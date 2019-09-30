{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{            Consts Unit - EConsts               }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EConsts;

{$I Exceptions.inc}

interface

uses ETypes;

type
  EMsgsRec = record
    Msg: string;
    No: Integer;
  end;

const
  // Number used to check EurekaLog information presents.
  // Before the 6.0.4 version was: $000FAB10 (changed for backward compatibility).
  MagicNumber6 = $100FAB10;
  MagicNumber5 = $000FAB10;

  EurekaLogCurrentVersion: Word = 6006; // Version number - 6.0.6
  EurekaLogVersion = '6.0.6'; // String version number.

  EurekaLogViewerVersion = '3.0.3'; // EurekaLog Viewer string version number.

  ECopyrightCaption = 'Copyright (c) 2001-2008';
  EAuthorCaption = 'by 过客汉化';

  EurekaIni = 'EurekaLog.ini';

  // SafeCall consts...
  SafeCallExceptionHandled = '[SafeCall Exception]: ';

  UnassignedPointer: Pointer = Pointer(-1);

  // Dialog colors const...
  color_DialogBack = $00C8D0D4;

  color_BackColorActive = $00C29B82; // Caption color.
  color_BorderColorActive = $00404040;
  color_BorderBackActive = $00808080;

  color_BackColorInactive = $00979797; // Caption color.
  color_BorderColorInactive = $00303030;
  color_BorderBackInactive = $00606060;

  color_CaptionActive = $00FFFFFF;
  color_CaptionShadow = $00222222;
  color_CaptionInactive = $00E0E0E0;

  color_Text = $00000000;
  color_Back = $00FFFFFF;

{$IFDEF EUREKALOG_DEMO}
  EBuyItem = '购买 EurekaLog...';
  EurekaDemoString =
    'The "%s" program is compiled with EurekaLog ' + EurekaLogVersion +
    ' trial version.'#13#10 +
    'You can test this program for 30 days after its compilation.'#13#10 +
    'To buy the EurekaLog full version go to: http://www.eurekalog.com';

  EurekaTypeTRL = 'Trial';
{$ENDIF}
{$IFNDEF PROFESSIONAL}
  EurekaTypeSTD = 'Standard';
{$ELSE}
  EurekaTypePRO = 'Professional';
  EurekaTypeENT = 'Enterprise';
{$ENDIF}

  EurekaLogSection = 'Exception Log';

  EurekaLogFirstLine_XML = '<!-- EurekaLog First Line';
  EurekaLogLastLine_XML = 'EurekaLog Last Line -->';
  EurekaLogFirstLine_TXT = '';
  EurekaLogLastLine_TXT = '';

  EurekaNotRegisteredVersion = '没有注册版';
  EurekaGoToUpdatesPage = '去更新页';

  EurekaBUGString = '错误: ''%s'''#13#10#13#10'这是一个 ' +
    'EurekaLog bug.'#13#10 + '你想不想发出错误信息， ' +
    '至 EurekaLog 作者?';

  EurekaInternalBUGString = '错误: ''%s'''#13#10#13#10'这是一个内部 ' +
    'EurekaLog bug.'#13#10 + '你想不想发出错误信息， ' +
    '至 EurekaLog 作者?';

  EGeneralError = '一般误差.';
  EModule = '模块: ';
  EDebugInfoNotActive = '选择"调试信息"或"地图文件 = ' +
    '详尽的地图文件没有发现.'#13#10'地图文件: "%s".'#13#10 +
    'EurekaLog 将错误纳入这项工程. 错误代码: %d';

  ENotReadMapFile = '这是不可能的阅读地图文件.';
  ECorrupted = '败坏了地图文件或未知的文件格式.';

  EInsertEmail = '你必须选择一个有效的电子邮件地址.';
  EInsertURL = '你必须选择一个有效的URL.';
  EURLNoPrm = '你不能插入帐号/密码/端口参数的URL.';
  EURLProtConf = '你插入一个议定书的URL不同，从选定的协议类型.';
  EURLInvalidPort = '你必须选择一个有效的"网络端口" 值.';
  EInsertSMTPFrom = '你必须选择一个有效的 "SMTP-From" 电子邮件地址.';
  EInsertSMTPPort = '你必须选择一个有效"SMTP-Port" 值.';
  EInsertSMTPHost = '你必须选择一个有效 "SMTP-Host" 值.';
  EInvalidTrakerField = '你必须插入一个有效的 Web Bug-追踪 "%s".';
  EOptionsCaption = 'EurekaLog';
  EOptions = 'EurekaLog 选项...';
  EOptions2 = 'EurekaLog IDE 选项...';
  EOptions3 = 'EurekaLog 帮助';
  EViewItem = '查看异常日志...';
  EAboutItem = '关于 EurekaLog...';
  ETutorialItem = 'EurekaLog Tutorial...';
  EFormCaption = 'EurekaLog  选项';
  EActivateLog = '&激活 EurekaLog';
  EAttenction = '警告.';
  EInformation = '信息';
  EInternalBUG = '可能是内部缺陷';
  EInternalBUGSubject = '大概 EurekaLog ' + EurekaLogVersion + ' BUG.';
  EInternalCriticalBUGSubject = 'EurekaLog ' + EurekaLogVersion + ' 关键 BUG.';
  EInternalBUGBody = '见所附的日志.';
  ENoConnectWithEClient = '不能连接与您的电子邮件客户端软件.'#13#10 +
    '该手动发送 "%s" 文件至 support@eurekalog.com 电子邮件地址, ' +
    '之后点击OK按钮，关闭此对话框.';
  EOK = '&确定';
  ECancel = '&取消';
  EHelp = '&帮助';
  EExceptionToIgnore = '异常过滤';
  EDefault = '缺省';
  EAdd = '增加';
  ESub = '移除';
  ECapType = '类型';
  ELabel_OutputPath = '日志文件输出路径';
  EExceptionDialog = '异常对话框';
  ECapMsg = '消息';
  EExceptionsTab = '异常';
  ESendTab = '发送';
  ELogFileTab = '日志文件';
  EMessagesTab = '通知消息';
  EAdvancedTab = '高级';
  ESelectOutputPath = '选择输出路径...';
  EActivateHandle = '激活';
  ESaveLogFile = '保存日志文件';
  EErrorType = '错误类型';
  EAppendLogCaption = '增加日志，正文（无传档）';
  ESendEntireLog = '发送整个日志文件';
  ESendScreenshotCaption = '发送屏幕快照截图';
  EUseActiveWindow = '只使用活动的窗口';
  EAppendReproduceCaption = '增加 ''Reproduce Text''';
  ESMTPShowDialog = '显示发送对话框';
  ECommonSendOptions = '常见的发送选项';
  ECommonSaveOptions = '常见的保存选项';
  ETerminateGroup = '终止按钮';
  ETerminateOperation = '操作';
  ENone = '(无)';
  ETerminate = '终止';
  ERestart = '重新启动';
  EShowTerminateBtnLabel = '查看';
  ETerminateLabel = '查看';
  ELogShow = '查看';
  EOptionsListType = '类型';
  EOptionsListSubType = '子-类型';
  EMessagesLabel = '通知消息';
  ELookAndFeel = '使用 EurekaLog 默认的外观';
  EOptionsFiles = '选项档案';
  ELoadOptionsBtn = '&读取选项...';
  ESaveOptionsBtn = '&保存 current 选项...';
  EOpenLogBtn = '打开日志文件';
  EFreezeCaption = 'Anti-Freeze 选项';
  EFreezeActivate = '激活超时';
  EFreezeTimeout = '超时';
  EEmailSendOptions = 'Email 发送选项';
  ESendNo = '不发送';
  ESendEmailClient = '使用 Email 客户端';
  ESendSMTPClient = '使用 SMTP 客户端';
  ESendSMTPServer = '使用 SMTP 服务端';
  EEmailAddresses = '地址';
  EEmailObject = '主题';
  EEmailMessage = '消息';
  ESMTPFromCaption = '从';
  ESMTPHostCaption = 'Host';
  ESMTPPortCaption = 'Port';
  ESMTPUserIDCaption = 'UserID';
  ESMTPPasswordCaption = '密码';
  ELogSave = 'Saving Options';
  ELogNumberLog = 'Number of errors to save';
  ELogNotDuplicate = '不保存重复错误';
  EAreYouSure = '你肯定?';
  EShowExceptionDialog = '打开异常对话框';
  ELogNotFound = '异常日志文件不存在.';
  ENoProjectSelected = 'No one currently selected EurekaLog project.';
  EQuestion = 'Question.';
  EExtFileStr = 'EurekaLog options file (*.eof)|*.eof';
  EErrorCaption = 'Error.';
  EForegroundTitle = 'Foreground Tab';
  ERadioCPU = 'CPU';
  ERadioModulesList = 'Modules List';
  ERadioCallStack = 'Call Stack';
  ERadioGeneral = 'General';
  EInternalErrorCaption = 'WARNING';
  EInternalError = 'An exception has raised into the "%s" event.'#13#10
    + 'Please contact the assistance.';
  EInternalHookExceptionError = 'An internal error has occurred into the ' +
    '"ExceptNotify" procedure at line %d.'#13#10 +
    'Please contact the assistance.';

  EAboutCaption = '关于 EurekaLog';
  EExpireTime = 'Every project compiled with EurekaLog'#13#10'expires after 30 days.';
  EOrder = '&Buy now';
  EWhatIs = '&What is it?';
  EWaitingCaption = 'EurekaLog processing...';
  ECommonOptions = 'Common Options';
  ESendInThread = 'Sent in a separated thread';
  ESendHTML = 'Send last HTML page';
  ESaveFailure = 'Save only for failure sent';
  EWebSendOptions = 'Web Send Options';
  EWebPort = 'Port';
  EWebUser = 'User';
  EWebPassword = 'Password';
  EWebURL = 'URL';
  EWebUseFTP = 'FTP';
  EWebUseHTTP = 'HTTP';
  EWebUseHTTPS = 'HTTPS';  
  EWebNoSend = 'No send';
  EAttachedFiles = 'Attached files';
  ECopyLogInCaseOfError = '拷贝日志文字发送错误';
  ESaveFiles = '保存ZIP文件副本发送失败';
  EUseMainModuleOptions = '使用主模块选择';
  EAddDateInFileName = 'Add ''Date'' in sent file name';
  EAddComputerName = 'Add ''Computer name'' in Log file name';
  ESaveModulesAndProcessesSection = 'Save Modules and Processes Sections';
  ESaveAssemblerAndCPUSection = 'Save Assembler and CPU Sections';
  ESendXMLCopy = 'Send an XML Log''s copy';
  EDeleteLog = 'Delete the Log at version change';
  ECloseEveryDialog = 'Close every dialog after';
  ESeconds = 'seconds';
  ESupportURL = 'Support URL';
  EHTMLLayout = 'HTML Layout';
  EHTMLLayoutHELP = 'Help: use <%HTML_TAG%> tag';
  EShowDetailsButton = 'Show ''Details'' button';
  EShowInDetailedMode = 'Show dialog in ''Detailed'' mode';
  ESendEmailChecked = '''Send Error Report'' option checked';
  EAttachScreenshotChecked = '''Attach Screenshot'' option checked';
  EShowCopyToClipboard = 'Show ''Copy to clipboard'' option';
  EShowInTopMost = 'Show dialog in Top-Most mode';
  EEncryptPassword = 'Encryption password';
  EShowDlls = 'Show the DLLs functions';
  EShowBPLs = 'Show the BPLs functions';
  EShowBorladThreads = 'Show all Borland Threads call-stack';
  EShowWindowsThreads = 'Show all Windows Threads call-stack';
  EBehaviour = 'Behaviour Options';
  EAutoTerminateApplicationLabel1 = 'application after';
  EAutoTerminateApplicationLabel2 = '错误在';
  EAutoTerminateApplicationLabel3 = '分钟';
  EPauseBorlandThreads = '暂停所有Borland线程';
  EDoNotPauseMainThread = '不停止的主线程';
  EPauseWindowsthread = '暂停所有Windows线程';
  EActivateAutoTerminateApplication = '启动自动终止/重新启动';

  EMsgs: array[0..171] of EMsgsRec = (
    (Msg: '通知消息标题'; No: -1), // Items
    (Msg: '信息'; No: Integer(mtInformationMsgCaption)),
    (Msg: '问题'; No: Integer(mtQuestionMsgCaption)),
    (Msg: '错误'; No: Integer(mtErrorMsgCaption)),

    (Msg: '异常对话框(EurekaLog 类型)'; No: -1), // Items
    (Msg: '标题 (所有类型)'; No: Integer(mtDialog_Caption)),
    (Msg: '错误消息'; No: Integer(mtDialog_ErrorMsgCaption)),
    (Msg: '常规标题'; No: Integer(mtDialog_GeneralCaption)),
    (Msg: '常规报头'; No: Integer(mtDialog_GeneralHeader)),
    (Msg: '调用堆栈标题'; No: Integer(mtDialog_CallStackCaption)),
    (Msg: '调用堆栈报头'; No: Integer(mtDialog_CallStackHeader)),
    (Msg: '模块列表标题'; No: Integer(mtDialog_ModulesCaption)),
    (Msg: '模块列表报头'; No: Integer(mtDialog_ModulesHeader)),
    (Msg: '流程列表标题'; No: Integer(mtDialog_ProcessesCaption)),
    (Msg: '流程列表报头'; No: Integer(mtDialog_ProcessesHeader)),
    (Msg: 'Asembler 标题'; No: Integer(mtDialog_AsmCaption)),
    (Msg: 'Assembler 报头'; No: Integer(mtDialog_AsmHeader)),
    (Msg: 'CPU 标题'; No: Integer(mtDialog_CPUCaption)),
    (Msg: 'CPU 报头'; No: Integer(mtDialog_CPUHeader)),
    (Msg: '确定按键'; No: Integer(mtDialog_OKButtonCaption)),
    (Msg: '终止按键'; No: Integer(mtDialog_TerminateButtonCaption)),
    (Msg: '重新启动按键'; No: Integer(mtDialog_RestartButtonCaption)),
    (Msg: '缺省按键'; No: Integer(mtDialog_DetailsButtonCaption)),
    (Msg: '常规按键 (所有类型)'; No: Integer(mtDialog_CustomButtonCaption)),
    (Msg: '互联网消息'; No: Integer(mtDialog_SendMessage)),
    (Msg: '截图消息'; No: Integer(mtDialog_ScreenshotMessage)),
    (Msg: '复制消息'; No: Integer(mtDialog_CopyMessage)),
    (Msg: '支持消息'; No: Integer(mtDialog_SupportMessage)),

    (Msg: '异常对话框(微软经典)'; No: -1), // Items
    (Msg: '错误消息'; No: Integer(mtMSDialog_ErrorMsgCaption)),
    (Msg: '重新启动消息'; No: Integer(mtMSDialog_RestartCaption)),
    (Msg: '终止消息'; No: Integer(mtMSDialog_TerminateCaption)),
    (Msg: '"请..." 消息'; No: Integer(mtMSDialog_PleaseCaption)),
    (Msg: '详情消息'; No: Integer(mtMSDialog_DescriptionCaption)),
    (Msg: '"看看..." 消息'; No: Integer(mtMSDialog_SeeDetailsCaption)),
    (Msg: '"点这里" 消息'; No: Integer(mtMSDialog_SeeClickCaption)),
    (Msg: '"如何复制" 消息'; No: Integer(mtMSDialog_HowToReproduceCaption)),
    (Msg: '"Email 地址" 文本'; No: Integer(mtMSDialog_EmailCaption)),
    (Msg: '发送键'; No: Integer(mtMSDialog_SendButtonCaption)),
    (Msg: '不发送键'; No: Integer(mtMSDialog_NoSendButtonCaption)),

    (Msg: '发送对话框'; No: -1), // Item
    (Msg: '标题'; No: Integer(mtSendDialog_Caption)),
    (Msg: '消息'; No: Integer(mtSendDialog_Message)),
    (Msg: '解决消息'; No: Integer(mtSendDialog_Resolving)),
    (Msg: '登陆消息'; No: Integer(mtSendDialog_Login)),
    (Msg: '正在连接信息'; No: Integer(mtSendDialog_Connecting)),
    (Msg: '连接信息'; No: Integer(mtSendDialog_Connected)),
    (Msg: '正在发送信息'; No: Integer(mtSendDialog_Sending)),
    (Msg: '发送信息'; No: Integer(mtSendDialog_Sent)),
    (Msg: '选择项目信息'; No: Integer(mtSendDialog_SelectProject)),
    (Msg: '搜索信息'; No: Integer(mtSendDialog_Searching)),
    (Msg: '修改信息'; No: Integer(mtSendDialog_Modifying)),
    (Msg: '正在断开信息'; No: Integer(mtSendDialog_Disconnecting)),
    (Msg: '断开信息'; No: Integer(mtSendDialog_Disconnected)),

    (Msg: '复制对话框'; No: -1), // Item
    (Msg: '标题'; No: Integer(mtReproduceDialog_Caption)),
    (Msg: '请求消息'; No: Integer(mtReproduceDialog_Request)),
    (Msg: '确定'; No: Integer(mtReproduceDialog_OKButtonCaption)),

    (Msg: '常规数据'; No: -1), // Items
    (Msg: '应用头'; No: Integer(mtLog_AppHeader)),
    (Msg: '    起始日期'; No: Integer(mtLog_AppStartDate)),
    (Msg: '    名称/描述'; No: Integer(mtLog_AppName)),
    (Msg: '    版本号'; No: Integer(mtLog_AppVersionNumber)),
    (Msg: '    参数'; No: Integer(mtLog_AppParameters)),
    (Msg: '    编制日期'; No: Integer(mtLog_AppCompilationDate)),
    (Msg: '    访问时间'; No: Integer(mtLog_AppUpTime)),
    (Msg: '异常报头'; No: Integer(mtLog_ExcHeader)),
    (Msg: '    日期'; No: Integer(mtLog_ExcDate)),
    (Msg: '    地址'; No: Integer(mtLog_ExcAddress)),
    (Msg: '    模块名'; No: Integer(mtLog_ExcModuleName)),
    (Msg: '    模块版本'; No: Integer(mtLog_ExcModuleVersion)),
    (Msg: '    类型'; No: Integer(mtLog_ExcType)),
    (Msg: '    消息'; No: Integer(mtLog_ExcMessage)),
    (Msg: '    ID'; No: Integer(mtLog_ExcID)),
    (Msg: '    数量'; No: Integer(mtLog_ExcCount)),
    (Msg: '    状态'; No: Integer(mtLog_ExcStatus)),
    (Msg: '    备注'; No: Integer(mtLog_ExcNote)),
    (Msg: '用户标题'; No: Integer(mtLog_UserHeader)),
    (Msg: '    ID'; No: Integer(mtLog_UserID)),
    (Msg: '    名称'; No: Integer(mtLog_UserName)),
    (Msg: '    Email'; No: Integer(mtLog_UserEmail)),
    (Msg: '    公司'; No: Integer(mtLog_UserCompany)),
    (Msg: '    特权'; No: Integer(mtLog_UserPrivileges)),
    (Msg: '活动控制标题'; No: Integer(mtLog_ActCtrlsHeader)),
    (Msg: '    窗体类'; No: Integer(mtLog_ActCtrlsFormClass)),
    (Msg: '    窗体文本'; No: Integer(mtLog_ActCtrlsFormText)),
    (Msg: '    控制类'; No: Integer(mtLog_ActCtrlsControlClass)),
    (Msg: '    控制文本'; No: Integer(mtLog_ActCtrlsControlText)),
    (Msg: '电脑标题'; No: Integer(mtLog_CmpHeader)),
    (Msg: '    名称'; No: Integer(mtLog_CmpName)),
    (Msg: '    总记忆容量'; No: Integer(mtLog_CmpTotalMemory)),
    (Msg: '    内存'; No: Integer(mtLog_CmpFreeMemory)),
    (Msg: '    整个磁盘'; No: Integer(mtLog_CmpTotalDisk)),
    (Msg: '    空闲磁盘'; No: Integer(mtLog_CmpFreeDisk)),
    (Msg: '    系统时间'; No: Integer(mtLog_CmpSystemUpTime)),
    (Msg: '    处理器'; No: Integer(mtLog_CmpProcessor)),
    (Msg: '    显示模式'; No: Integer(mtLog_CmpDisplayMode)),
    (Msg: '    显示 DPI'; No: Integer(mtLog_CmpDisplayDPI)),
    (Msg: '    视频卡'; No: Integer(mtLog_CmpVideoCard)),
    (Msg: '    打印机'; No: Integer(mtLog_CmpPrinter)),
    (Msg: '操作系统标题'; No: Integer(mtLog_OSHeader)),
    (Msg: '    类型'; No: Integer(mtLog_OSType)),
    (Msg: '    Build #'; No: Integer(mtLog_OSBuildN)),
    (Msg: '    更新'; No: Integer(mtLog_OSUpdate)),
    (Msg: '    语种'; No: Integer(mtLog_OSLanguage)),
    (Msg: '    字符集'; No: Integer(mtLog_OSCharset)),
    (Msg: '网卡设置'; No: Integer(mtLog_NetHeader)),
    (Msg: '    IP地址'; No: Integer(mtLog_NetIP)),
    (Msg: '    Submask'; No: Integer(mtLog_NetSubmask)),
    (Msg: '    网关'; No: Integer(mtLog_NetGateway)),
    (Msg: '    DNS 1'; No: Integer(mtLog_NetDNS1)),
    (Msg: '    DNS 2'; No: Integer(mtLog_NetDNS2)),
    (Msg: '    DHCP'; No: Integer(mtLog_NetDHCP)),
    (Msg: '定制信息标题'; No: Integer(mtLog_CustInfoHeader)),

    (Msg: '调用堆栈'; No: -1), // Items
    (Msg: '地址'; No: Integer(mtCallStack_Address)),
    (Msg: '模块'; No: Integer(mtCallStack_Name)),
    (Msg: '单元'; No: Integer(mtCallStack_Unit)),
    (Msg: '类'; No: Integer(mtCallStack_Class)),
    (Msg: '程序/方法'; No: Integer(mtCallStack_Procedure)),
    (Msg: '线程'; No: Integer(mtCallStack_Line)),

    (Msg: '线程数据'; No: -1), // Items
    (Msg: '主线程'; No: Integer(mtCallStack_MainThread)),
    (Msg: '异常线程'; No: Integer(mtCallStack_ExceptionThread)),
    (Msg: '正运行的线程'; No: Integer(mtCallStack_RunningThread)),
    (Msg: '正调用的线程'; No: Integer(mtCallStack_CallingThread)),
    (Msg: '线程 ID'; No: Integer(mtCallStack_ThreadID)),
    (Msg: '线程 Priority'; No: Integer(mtCallStack_ThreadPriority)),
    (Msg: '线程类型'; No: Integer(mtCallStack_ThreadClass)),

    (Msg: '泄漏数据'; No: -1), // Items
    (Msg: '泄漏标题'; No: Integer(mtCallStack_LeakCaption)),
    (Msg: '泄漏 ''数据'''; No: Integer(mtCallStack_LeakData)),
    (Msg: '泄漏 类型'; No: Integer(mtCallStack_LeakType)),
    (Msg: '泄漏 大小'; No: Integer(mtCallStack_LeakSize)),
    (Msg: '泄漏 数量'; No: Integer(mtCallStack_LeakCount)),

    (Msg: '模块列表'; No: -1), // Items
    (Msg: '句柄'; No: Integer(mtModules_Handle)),
    (Msg: '名称'; No: Integer(mtModules_Name)),
    (Msg: '描述'; No: Integer(mtModules_Description)),
    (Msg: '版本'; No: Integer(mtModules_Version)),
    (Msg: '大小'; No: Integer(mtModules_Size)),
    (Msg: '最后修改 '; No: Integer(mtModules_LastModified)),
    (Msg: '路径'; No: Integer(mtModules_Path)),

    (Msg: '流程列表'; No: -1), // Items
    (Msg: 'ID'; No: Integer(mtProcesses_ID)),
    (Msg: '名称'; No: Integer(mtProcesses_Name)),
    (Msg: '描述'; No: Integer(mtProcesses_Description)),
    (Msg: '版本'; No: Integer(mtProcesses_Version)),
    (Msg: '内存'; No: Integer(mtProcesses_Memory)),
    (Msg: '优先'; No: Integer(mtProcesses_Priority)),
    (Msg: '线程'; No: Integer(mtProcesses_Threads)),
    (Msg: '路径'; No: Integer(mtProcesses_Path)),

    (Msg: 'CPU'; No: -1), // Items
    (Msg: 'Registers'; No: Integer(mtCPU_Registers)),
    (Msg: '栈'; No: Integer(mtCPU_Stack)),
    (Msg: '内存 Dump'; No: Integer(mtCPU_MemoryDump)),

    (Msg: '发送信信'; No: -1), // Items
    (Msg: '成功'; No: Integer(mtSend_SuccessMsg)),
    (Msg: '失败'; No: Integer(mtSend_FailureMsg)),
    (Msg: 'Bug关闭'; No: Integer(mtSend_BugClosedMsg)),
    (Msg: '未知错误'; No: Integer(mtSend_UnknownErrorMsg)),
    (Msg: '无效登录'; No: Integer(mtSend_InvalidLoginMsg)),
    (Msg: '无效搜索'; No: Integer(mtSend_InvalidSearchMsg)),
    (Msg: '无效的选择'; No: Integer(mtSend_InvalidSelectionMsg)),
    (Msg: '无效插入'; No: Integer(mtSend_InvalidInsertMsg)),
    (Msg: '无效修改'; No: Integer(mtSend_InvalidModifyMsg)),

    (Msg: '另外也有消息'; No: -1), // Items
    (Msg: '文件告破'; No: Integer(mtFileCrackedMsg)),
    (Msg: '多次释放异常'; No: Integer(mtException_LeakMultiFree)),
    (Msg: '内存超支异常'; No: Integer(mtException_LeakMemoryOverrun)),
    (Msg: 'Anti Freeze异常'; No: Integer(mtException_AntiFreeze)),
    (Msg: '无效电子邮件'; No: Integer(mtInvalidEmailMsg)));

  EText = '文本';

  EVals: array[TMessageType] of string =
  ('信息.', // mtInformationMsgCaption
    '问题.', // mtQuestionMsgCaption
    '错误.', // mtErrorMsgCaption

    '发生错误', // mtDialog_Caption
    '程序执行出现异常.'#13#10 + // mtDialog_ErrorMsgCaption
    '请阅读以下资料，以作进一步的详细资料.',
    '常规', // mtDialog_GeneralCaption
    '常规信息', // mtDialog_GeneralHeader
    '调用堆栈', // mtDialog_CallStackCaption
    '调用堆栈信息', // mtDialog_CallStackHeader
    '模块', // mtDialog_ModulesCaption
    '模块信息', // mtDialog_ModulesHeader
    '流程', // mtDialog_ProcessesCaption
    '流程信息', // mtDialog_ProcessesHeader
    '汇编', // mtDialog_AsmCaption
    '汇编信息', // mtDialog_AsmHeader
    'CPU', // mtDialog_CPUCaption
    'CPU I信息', // mtDialog_CPUHeader
    '确定', // mtDialog_OKButtonCaption
    '终止', // mtDialog_TerminateButtonCaption
    '重试', // mtDialog_RestartButtonCaption
    '缺省', // mtDialog_DetailsButtonCaption
    '帮助', // mtDialog_CustomButtonCaption
    '发送此错误至互联网', // mtDialog_SendMessage
    '附上截图', // mtDialog_ScreenshotMessage
    '复制到剪切板', // mtDialog_CopyMessage
    '去主页', // mtDialog_SupportMessage

    '应用中遇到的一个问题. ' +
      '我们对此表示遗憾，为不便.', // mtMSDialog_ErrorMsgCaption
    '重启程序.', // mtMSDialog_RestartCaption
    '终止程序.', // mtMSDialog_TerminateCaption
    '请您介绍一下这方面的问题.', // mtMSDialog_PleaseCaption
    '我们已经创造了一个错误报告，您可以发送给我们. ' +
      '我们将会把这份报告列为机密，而且是匿名.', // mtMSDialog_DescriptionCaption
    '  看看包含有什么数据错误报告 ,', // mtMSDialog_SeeDetailsCaption
    '点这里.', // mtMSDialog_SeeClickCaption
    '什么是你做的时候，问题发生（可选）?', // mtMSDialog_HowToReproduceCaption
    '电子邮箱地址（可选）:', // mtMSDialog_EmailCaption
    '发送错误报告', // mtMSDialog_SendButtonCaption
    '不发送错误报告', // mtMSDialog_NoSendButtonCaption

    '应用程序', // mtLog_AppHeader
    '起始日期', // mtLog_AppStartingTime
    '名称/描述', // mtLog_AppName
    '版本号', // mtLog_AppVersionNumber
    '参数', // mtLog_AppParameters
    '编制日期', // mtLog_AppCompilationDate
    '访问时间', // mtLog_AppUpTime

    '异常', // mtLog_ExcHeader
    '日期', // mtLog_ExcTime
    '地址', // mtLog_ExcAddress
    '模块名称', // mtLog_ExcModuleName
    '模块版本', // mtLog_ExcModuleVersion
    '类型', // mtLog_ExcType
    '消息', // mtLog_ExcMessage
    'ID', // mtLog_ExcID
    '数量', // mtLog_ExcCount
    '装状', // mtLog_ExcStatus
    '备注', // mtLog_ExcNote

    '用户', // mtLog_UserHeader
    'ID', // mtLog_UserID
    '名称', // mtLog_UserName
    '电子邮件', // mtLog_UserEmail
    '公司', // mtLog_UserCompany
    '特权', // mtLog_UserPrivileges

    '活动控制', // mtLog_ActCtrlsHeader
    '窗口类型', // mtLog_ActCtrlsFormClass
    '窗口文本', // mtLog_ActCtrlsFormText
    '控制类', // mtLog_ActCtrlsControlClass
    '控制文本', // mtLog_ActCtrlsControlText

    '计算机', // mtLog_CmpHeader
    '名称', // mtLog_CmpName
    '总记忆容量', // mtLog_CmpTotalMemory
    '内存', // mtLog_CmpFreeMemory
    '整个磁盘', // mtLog_CmpTotalDisk
    '空闲磁盘', // mtLog_CmpFreeDisk
    '系统时间', // mtLog_CmpSystemUpTime
    '处理器', // mtLog_CmpProcessor
    '显示模式', // mtLog_CmpDisplayMode
    '显示 DPI', // mtLog_CmpDisplayDPI
    '视频卡', // mtLog_CmpVideoCard
    '打印机', // mtLog_CmpPrinter

    '操作系统 ', // mtLog_OSHeader
    '类型', // mtLog_OSType
    'Build #', // mtLog_OSBuildN
    '更新', // mtLog_OSUpdate
    '语言', // mtLog_OSLanguage
    '字符集', // mtLog_OSCharset

    '网卡', // mtLog_NetHeader
    'IP地址', // mtLog_NetIP
    '掩码', // mtLog_NetSubmask
    '网关', // mtLog_NetGateway
    'DNS 1', // mtLog_NetDNS1
    'DNS 2', // mtLog_NetDNS2
    'DHCP', // mtLog_NetDHCP

    '定制信息', // mtLog_CustInfoHeader

    '地址', // mtCallStack_Address
    '模块', // mtCallStack_Name
    '单元', // mtCallStack_Unit
    '类', // mtCallStack_Class
    '程序/方法', // mtCallStack_Procedure
    '线', // mtCallStack_Line

    // Call Stack Thread Data...
    '主', // mtCallStack_MainThread
    '异常线程', // mtCallStack_ExceptionThread
    '正运行的线程', // mtCallStack_RunningThread
    '正调用的线程', // mtCallStack_CallingThread
    'ID', // mtCallStack_ThreadID
    '优先', // mtCallStack_ThreadPriority
    '类型', // mtCallStack_ThreadClass

    // Call Stack Leak Data...
    '内存泄漏', // mtCallStack_LeakCaption
    '数据', // mtCallStack_LeakData
    '类型', // mtCallStack_LeakType
    '总大小', // mtCallStack_LeakSize
    '数量', // mtCallStack_LeakCount

    '发送.', // mtSendDialog_Caption
    '消息', // mtSendDialog_Message
    '解决ing DNS...', // mtSendDialog_Resolving
    '登陆...', // mtSendDialog_Login
    '正在连接到服务器...', // mtSendDialog_Connecting
    '连接到服务器.', // mtSendDialog_Connected
    '正在发送消息...', // mtSendDialog_Sending
    '消息发送.', // mtSendDialog_Sent
    '选择项目...', // mtSendDialog_SelectProject,
    '正在搜寻...', // mtSendDialog_Searching,
    '正在修改...', // mtSendDialog_Modifying,
    '正在断开...', // mtSendDialog_Disconnecting,
    '断开.', // mtSendDialog_Disconnected,

    '要求', // mtReproduceDialog_Caption
    '请说明步骤，以复制错误:', // mtReproduceDialog_Request
    '确定', // mtReproduceDialog_OKButtonCaption

    '句柄', // mtModules_Handle
    '名称', // mtModules_Name
    '描述', // mtModules_Description
    '版本', // mtModules_Version
    '大小', // mtModules_Size
    '改性', // mtModules_DateModified
    '路径', // mtModules_Path

    'ID', // mtProcesses_ID
    '名称', // mtProcesses_Name
    '描述', // mtProcesses_Description
    '版本', // mtProcesses_Version
    '内存', // mtProcesses_Memory
    '优先', // mtProcesses_Priority
    '线程', // mtProcesses_Threads
    '路径', // mtProcesses_Path

    'Registers', // mtCPU_Registers
    '栈', // mtCPU_Stack
    '内存 Dump', // mtCPU_MemoryDump

    '该消息被送往成功.', // mtSend_SuccessMsg
    '对不起，发出信息，没有工作.', // mtSend_FailureMsg
    '这些bug是刚刚关闭.'+ #13#10 +
      '联络网站取得的最新情况.', // mtSend_BugClosedMsg
    '未知错误.', // mtSend_UnknownErrorMsg
    '无效登录请求.', // mtSend_InvalidLoginMsg
    '无效的搜索请求.', // mtSend_InvalidSearchMsg
    '无效的选择要求.', // mtSend_InvalidSelectionMsg
    '插入无效的请求.', // mtSend_InvalidInsertMsg
    '无效的修改要求.',  // mtSend_InvalidModifyMsg

    // Other messages
    '这个文件是破获.' + #13#10 +
      '截止申请日期.', // mtFileCrackedMsg
    '多重释放内存泄漏.', // mtException_LeakMultiFree
    '内存超支泄漏.', // mtExceptionLeakMemoryOverrun
    '应用程序似乎被冻结.', // mtExceptionLeakMemoryOverrun
    '无效电子邮件.'); // mtExceptionLeakMemoryOverrun

  EShowOptions: array[TShowOption] of string = (
    '应用程序|起始日期',
    '应用程序|名称',
    '应用程序|版本号',
    '应用程序|参数',
    '应用程序|编制日期',
    '应用程序|访问时间',

    '异常|日期',
    '异常|地址',
    '异常|模块名称',
    '异常|模块版本',
    '异常|类型',
    '异常|消息',
    '异常|ID',
    '异常|数量',
    '异常|状态',
    '异常|备注',

    '使用|ID',
    '使用|名称',
    '使用|Email',
    '使用|特权',
    '使用|公司',

    '活动控制|窗口类型',
    '活动控制|窗口文本',
    '活动控制|控制类型',
    '活动控制|控制文本',

    '计算机|名称',
    '计算机|总记忆容量',
    '计算机|内存',
    '计算机|整个磁盘',
    '计算机|空闲磁盘',
    '计算机|系统时间',
    '计算机|处理器',
    '计算机|显示模式',
    '计算机|显示 DPI',
    '计算机|视频卡',
    '计算机|打印机',

    '操作系统|类型',
    '操作系统|Build #',
    '操作系统|更新',
    '操作系统|语言',
    '操作系统|字符集',

    '网卡|IP 地址',
    '网卡|掩码',
    '网卡|网关',
    '网卡|DNS 1',
    '网卡|DNS 2',
    '网卡|DHCP',

    'Custom 数据|所有');

  EVariablesOptions: array[0..25] of string = (
    '_BugReport | 充分eurekalog bug报告',
    '_ExceptModuleDesc | 描述模块提出了最后一个异常',
    '_ExceptModuleName | 模块名称已经提出了最后一个异常',
    '_ExceptModuleVer | 版本的模块，提出了最后一个异常',
    '_ExceptMsg | 最后异常信息',
    '_LineBreak | 线程退出',
    '_MainModuleDesc | 描述当前运行模块',
    '_MainModuleName | 名称目前运行模块',
    '_MainModuleVer | 版本目前的运行模块',
    'AllUsersProfile | \Documents and Settings\All Users',
    'AppData | \Documents and Settings\{username}\Application Data',
    'CD | 当前目录其完整路径',
    'ComputerName | {computername}',
    'Date | 当前日期格式取决于操作系统',
    'HomeDrive | 驱动器含home目录',
    'HomePath | \Documents and Settings\{username}',
    'ProgramFiles | 目录含有程式档案',
    'SystemDrive | 驱动器含窗户根目录',
    'SystemRoot | 在Windows根目录',
    'Temp | 临时目录',
    'Time | 当前时间在格式取决于操作系统',
    'Tmp | 临时目录',
    'UserDomain | 当前用户域名',
    'UserName | {username}',
    'UserProfile | \Documents and Settings\{username}',
    'WinDir | Windows目录');

implementation

end.

