{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{             Types Unit - ETypes                }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ETypes;

{$I Exceptions.inc}

interface

type
  // WARNING !!! Max 256 elements (see the TEurekaModuleOptions.SaveToStream method).
  TShowOption = (
    // Application
    soAppStartDate, soAppName, soAppVersionNumber, soAppParameters,
    soAppCompilationDate, soAppUpTime,
    // Exception
    soExcDate, soExcAddress, soExcModuleName, soExcModuleVersion, soExcType,
    soExcMessage, soExcID, soExcCount, soExcStatus, soExcNote,
    // User
    soUserID, soUserName, soUserEmail, soUserPrivileges, soUserCompany,
    // Active Controls
    soActCtlsFormClass, soActCtlsFormText, soActCtlsControlClass,
    soActCtlsControlText,
    // Computer
    soCmpName, soCmpTotalMemory, soCmpFreeMemory, soCmpTotalDisk,
    soCmpFreeDisk, soCmpSysUpTime, soCmpProcessor, soCmpDisplayMode,
    soCmpDisplayDPI, soCmpVideoCard, soCmpPrinter,
    // Operating System
    soOSType, soOSBuildN, soOSUpdate, soOSLanguage, soOSCharset,
    // Network
    soNetIP, soNetSubmask, soNetGateway, soNetDNS1, soNetDNS2, soNetDHCP,
    // Custom Data
    soCustomData);

  TMessageType = (
    // General Messages...
    mtInformationMsgCaption, mtQuestionMsgCaption, mtErrorMsgCaption,
    // Exception Dialog (EurekaLog style)...
    mtDialog_Caption, mtDialog_ErrorMsgCaption,
    mtDialog_GeneralCaption, mtDialog_GeneralHeader,
    mtDialog_CallStackCaption, mtDialog_CallStackHeader,
    mtDialog_ModulesCaption, mtDialog_ModulesHeader,
    mtDialog_ProcessesCaption, mtDialog_ProcessesHeader,
    mtDialog_AsmCaption, mtDialog_AsmHeader,    
    mtDialog_CPUCaption, mtDialog_CPUHeader,
    mtDialog_OKButtonCaption, mtDialog_TerminateButtonCaption,
    mtDialog_RestartButtonCaption, mtDialog_DetailsButtonCaption,
    mtDialog_CustomButtonCaption,  mtDialog_SendMessage,
    mtDialog_ScreenshotMessage, mtDialog_CopyMessage, mtDialog_SupportMessage,
    // Exception Dialog (MS style)...
    mtMSDialog_ErrorMsgCaption, mtMSDialog_RestartCaption,
    mtMSDialog_TerminateCaption, mtMSDialog_PleaseCaption,
    mtMSDialog_DescriptionCaption, mtMSDialog_SeeDetailsCaption,
    mtMSDialog_SeeClickCaption, mtMSDialog_HowToReproduceCaption,
    mtMSDialog_EmailCaption, mtMSDialog_SendButtonCaption,
    mtMSDialog_NoSendButtonCaption,
    // Log...
    mtLog_AppHeader, // Application...
    mtLog_AppStartDate, mtLog_AppName, mtLog_AppVersionNumber,
    mtLog_AppParameters, mtLog_AppCompilationDate, mtLog_AppUpTime,
    mtLog_ExcHeader, // Exception...
    mtLog_ExcDate, mtLog_ExcAddress, mtLog_ExcModuleName, mtLog_ExcModuleVersion,
    mtLog_ExcType, mtLog_ExcMessage, mtLog_ExcID, mtLog_ExcCount, mtLog_ExcStatus,
    mtLog_ExcNote,
    mtLog_UserHeader, // User...
    mtLog_UserID, mtLog_UserName, mtLog_UserEmail, mtLog_UserCompany,
    mtLog_UserPrivileges,
    mtLog_ActCtrlsHeader, // Active Controls...
    mtLog_ActCtrlsFormClass, mtLog_ActCtrlsFormText,
    mtLog_ActCtrlsControlClass, mtLog_ActCtrlsControlText,
    mtLog_CmpHeader, // Computer...
    mtLog_CmpName, mtLog_CmpTotalMemory, mtLog_CmpFreeMemory,
    mtLog_CmpTotalDisk, mtLog_CmpFreeDisk, mtLog_CmpSystemUpTime,
    mtLog_CmpProcessor, mtLog_CmpDisplayMode, mtLog_CmpDisplayDPI,
    mtLog_CmpVideoCard, mtLog_CmpPrinter,
    mtLog_OSHeader, // Operating System...
    mtLog_OSType, mtLog_OSBuildN, mtLog_OSUpdate,
    mtLog_OSLanguage, mtLog_OSCharset,
    mtLog_NetHeader, // Network...
    mtLog_NetIP, mtLog_NetSubmask, mtLog_NetGateway, mtLog_NetDNS1,
    mtLog_NetDNS2, mtLog_NetDHCP,
    mtLog_CustInfoHeader, // Custom Information...
    // Call Stack...
    mtCallStack_Address, mtCallStack_Name, mtCallStack_Unit,
    mtCallStack_Class, mtCallStack_Procedure, mtCallStack_Line,
    mtCallStack_MainThread, mtCallStack_ExceptionThread, mtCallStack_RunningThread,
    mtCallStack_CallingThread, mtCallStack_ThreadID, mtCallStack_ThreadPriority,
    mtCallStack_ThreadClass, mtCallStack_LeakCaption, mtCallStack_LeakData,
    mtCallStack_LeakType, mtCallStack_LeakSize, mtCallStack_LeakCount,
    // Send Dialog...
    mtSendDialog_Caption, mtSendDialog_Message, mtSendDialog_Resolving,
    mtSendDialog_Login, mtSendDialog_Connecting, mtSendDialog_Connected,
    mtSendDialog_Sending, mtSendDialog_Sent, mtSendDialog_SelectProject,
    mtSendDialog_Searching, mtSendDialog_Modifying, mtSendDialog_Disconnecting,
    mtSendDialog_Disconnected,
    // Reproduce Dialog...
    mtReproduceDialog_Caption, mtReproduceDialog_Request,
    mtReproduceDialog_OKButtonCaption,
    // Modules List...
    mtModules_Handle, mtModules_Name, mtModules_Description,
    mtModules_Version, mtModules_Size, mtModules_LastModified, mtModules_Path,
    // Processes List...
    mtProcesses_ID, mtProcesses_Name, mtProcesses_Description, mtProcesses_Version,
    mtProcesses_Memory, mtProcesses_Priority, mtProcesses_Threads, mtProcesses_Path,
    // CPU...
    mtCPU_Registers, mtCPU_Stack, mtCPU_MemoryDump,
    // Send Messages...
    mtSend_SuccessMsg, mtSend_FailureMsg, mtSend_BugClosedMsg, mtSend_UnknownErrorMsg,
    mtSend_InvalidLoginMsg, mtSend_InvalidSearchMsg, mtSend_InvalidSelectionMsg,
    mtSend_InvalidInsertMsg, mtSend_InvalidModifyMsg,
    // File Cracked Messages...
    mtFileCrackedMsg,
    // Exceptions...
    mtException_LeakMultiFree, mtException_LeakMemoryOverrun, mtException_AntiFreeze,
    // Others...
    mtInvalidEmailMsg);

implementation

end.


