unit WinlicenseSDK;

{$ALIGN ON}
{$MINENUMSIZE 4}

interface

uses
  Windows;

type  
sLicenseFeatures = record 

     cb: LongWord; 
     NumDays: LongWord; 
     NumExec: LongWord; 
     ExpDate: SYSTEMTIME; 
     CountryId: LongWord; 
     Runtime: LongWord; 
     GlobalMinutes: LongWord; 
     InstallDate: SYSTEMTIME; 
     NetInstances: LongWord; 
     EmbedLicenseInfoInKey: LongWord; 
     EmbedCreationDate: LongWord 

end; 
 

const 

wlNoTrialExt                = 0;
wlAppExtended               = 1;
wlInvalidTrialExt           = 2;
wlNoMoreExt                 = 3;
wlTrialOk                   = 0;
wlTrialDaysExpired          = 1;
wlTrialExecExpired          = 2;
wlTrialDateExpired          = 3;
wlTrialRuntimExpired        = 4;
wlTrialGlobalExpired        = 5;
wlTrialInvalidCountry       = 6;
wlTrialManipulated          = 7;
wlMarkStolenKey             = 0;
wlMarkInvalidKey            = 1;
wlLicenseDaysExpired        = 1;
wlLicenseExecExpired        = 2;
wlLicenseDateExpired        = 3;
wlLicenseGlobalExpired      = 4;
wlLicenseRuntimeExpired     = 5;
wlLicenseActivationExpired  = 6;
wlIsTrial                   = 0;
wlIsRegistered              = 1;
wlInvalidLicense            = 2;
wlInvalidHardwareLicense    = 3;
wlNoMoreHwdChanges          = 4;
wlLicenseExpired            = 5;
wlInvalidCountryLicense     = 6;
wlLicenseStolen             = 7;
wlWrongLicenseExp           = 8;
wlWrongLicenseHardware      = 9;
wlIsRegisteredAndActivated  = wlIsRegistered;
wlIsRegisteredNotActivated  = 10;
wlNoMoreInstancesAllowed    = 12;
wlNetworkNoServerRunning    = 13;
wlInstallLicenseDateExpired = 14;
wlLicenseDisabledInInstance = 15;
wlTrialModeNotSupported     = 16;


wlPermKey                = -1;
wlNoKey                  = -2;
wlNoTrialDate            = -1;
wlInvalidCounter         = -1;


// License restrictions 

wlRegRestrictionDays          = 1 shl 0;
wlRegRestrictionExec          = 1 shl 1;
wlRegRestrictionDate          = 1 shl 2;
wlRegRestrictionRuntime       = 1 shl 3;
wlRegRestrictionGlobalTime    = 1 shl 4;
wlRegRestrictionCountry       = 1 shl 5;
wlRegRestrictionHardwareId    = 1 shl 6;
wlRegRestrictionNetwork       = 1 shl 7;
wlRegRestrictionInstallDate   = 1 shl 8;
wlRegRestrictionCreationDate  = 1 shl 9;
wlRegRestrictionEmbedUserInfo = 1 shl 10;


// Trial restrictions 

wlTrialRestrictionUnlimited   =       0;
wlTrialRestrictionDays        = 1 shl 0;
wlTrialRestrictionExec        = 1 shl 1;
wlTrialRestrictionDate        = 1 shl 2;
wlTrialRestrictionRuntime     = 1 shl 3;
wlTrialRestrictionGlobalTime  = 1 shl 4;
wlTrialRestrictionCountry     = 1 shl 5;


function WLGenTrialExtensionFileKey(TrialHash:PAnsiChar; Level:Integer; NumDays:Integer; NumExec:Integer; var NewDate:SYSTEMTIME; NumMinutes:Integer; TimeRuntime:Integer; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenTrialExtensionRegistryKey(TrialHash:PAnsiChar; Level:Integer; NumDays:Integer; NumExec:Integer; var NewDate:SYSTEMTIME; NumMinutes:Integer; TimeRuntime:Integer; pKeyName:PAnsiChar; pKeyValueName:PAnsiChar; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenPassword(PasswordHash:PAnsiChar; Name:PAnsiChar; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseFileKey(LicenseHash:PAnsiChar; UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; MachineID:PAnsiChar; NumDays:Integer; NumExec:Integer; var ExpDate:SYSTEMTIME; CountryId:Integer; Runtime:Integer; GlobalMinutes:Integer; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseFileKeyW(LicenseHash:PWideChar; UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; MachineID:PWideChar; NumDays:Integer; NumExec:Integer; var ExpDate:SYSTEMTIME; CountryId:Integer; Runtime:Integer; GlobalMinutes:Integer; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseFileKeyEx(LicenseHash:PAnsiChar; UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; MachineID:PAnsiChar; var LicenseFeatures: sLicenseFeatures; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseFileKeyExW(LicenseHash:PWideChar; UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; MachineID:PWideChar; var LicenseFeatures: sLicenseFeatures; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseRegistryKey(LicenseHash:PAnsiChar; UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; MachineID:PAnsiChar; NumDays:Integer; NumExec:Integer; var ExpDate:SYSTEMTIME; CountryId:Integer; Runtime:Integer; GlobalMinutes:Integer; KeyName:PAnsiChar; KeyValueName:PAnsiChar; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseRegistryKeyW(LicenseHash:PWideChar; UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; MachineID:PWideChar; NumDays:Integer; NumExec:Integer; var ExpDate:SYSTEMTIME; CountryId:Integer; Runtime:Integer; GlobalMinutes:Integer; KeyName:PWideChar; KeyValueName:PWideChar; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseRegistryKeyEx(LicenseHash:PAnsiChar; UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; MachineID:PAnsiChar; var LicenseFeatures: sLicenseFeatures; KeyName:PAnsiChar; KeyValueName:PAnsiChar; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseRegistryKeyExW(LicenseHash:PWideChar; UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; MachineID:PWideChar; var LicenseFeatures: sLicenseFeatures; KeyName:PWideChar; KeyValueName:PWideChar; BufferOut:PWideChar):Integer; stdcall;
function WLGenLicenseTextKeyW(LicenseHash:PWideChar; UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; MachineID:PWideChar; NumDays:Integer; NumExec:Integer; var ExpDate:SYSTEMTIME; CountryId:Integer; Runtime:Integer; GlobalMinutes:Integer; BufferOut:PWideChar):Integer; stdcall;
function WLGenLicenseTextKey(LicenseHash:PAnsiChar; UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; MachineID:PAnsiChar; NumDays:Integer; NumExec:Integer; var ExpDate:SYSTEMTIME; CountryId:Integer; Runtime:Integer; GlobalMinutes:Integer; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseTextKeyEx(LicenseHash:PAnsiChar; UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; MachineID:PAnsiChar; var LicenseFeatures: sLicenseFeatures; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseTextKeyExW(LicenseHash:PWideChar; UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; MachineID:PWideChar; var LicenseFeatures: sLicenseFeatures; BufferOut:PWideChar):Integer; stdcall;
function WLGenLicenseSmartKey(LicenseHash:PAnsiChar; UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; MachineID:PAnsiChar; NumDays:Integer; NumExec:Integer; var ExpDate:SYSTEMTIME; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseSmartKeyW(LicenseHash:PWideChar; UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; MachineID:PWideChar; NumDays:Integer; NumExec:Integer; var ExpDate:SYSTEMTIME; BufferOut:PWideChar):Integer; stdcall;
function WLGenLicenseDynSmartKey(LicenseHash:PAnsiChar; UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; MachineID:PAnsiChar; var LicenseFeatures: sLicenseFeatures; BufferOut:PAnsiChar):Integer; stdcall;
function WLGenLicenseDynSmartKeyW(LicenseHash:PWideChar; UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; MachineID:PWideChar; var LicenseFeatures: sLicenseFeatures; BufferOut:PWideChar):Integer; stdcall;
function WLRegGetStatus(var ExtendedInfo:Integer):Integer; stdcall;
function WLTrialGetStatus(var ExtendedInfo:Integer):Integer; stdcall;
function WLTrialExtGetStatus:Integer; stdcall;
function WLRegGetLicenseInfo(UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar):Boolean; stdcall;
function WLRegGetLicenseInfoW(UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar):Boolean; stdcall;
function WLTrialTotalDays:Integer; stdcall;
function WLTrialTotalExecutions:Integer; stdcall;
function WLTrialDaysLeft:Integer; stdcall;
function WLTrialExecutionsLeft:Integer; stdcall;
function WLTrialExpirationDate(var pExpDate:SYSTEMTIME):Integer; stdcall;
function WLTrialGlobalTimeLeft:Integer; stdcall;
function WLTrialRuntimeLeft:Integer; stdcall;
function WLTrialLockedCountry:Integer; stdcall;
function WLRegDaysLeft:Integer; stdcall;
function WLRegExecutionsLeft:Integer; stdcall;
function WLRegExpirationDate(var pExpDate:SYSTEMTIME):Integer; stdcall;
function WLRegLicenseCreationDate(var CreationDate:SYSTEMTIME):Boolean; stdcall;
function WLRegTotalExecutions:Integer; stdcall;
function WLRegTotalDays:Integer; stdcall;
function WLHardwareGetID(pHardId:PAnsiChar):Boolean; stdcall;
function WLHardwareCheckID(pHardId:PAnsiChar):Boolean; stdcall;
function WLRegSmartKeyCheck(UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; AsciiKey:PAnsiChar):Boolean; stdcall;
function WLRegSmartKeyCheckW(UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; SmartKey:PWideChar):Boolean; stdcall;
function WLRegNormalKeyCheck(AsciiKey:PAnsiChar):Boolean; stdcall;
function WLRegNormalKeyCheckW(UnicodeKey:PWideChar):Boolean; stdcall;
function WLRegNormalKeyInstallToFile(AsciiKey:PAnsiChar):Boolean; stdcall;
function WLRegNormalKeyInstallToFileW(UnicodeKey:PWideChar):Boolean; stdcall;
function WLRegNormalKeyInstallToRegistry(AsciiKey:PAnsiChar):Boolean; stdcall;
function WLRegNormalKeyInstallToRegistryW(UnicodeKey:PWideChar):Boolean; stdcall;
function WLRegSmartKeyInstallToFile(UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; AsciiKey:PAnsiChar):Boolean; stdcall;
function WLRegSmartKeyInstallToFileW(UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; SmartKeyKey:PWideChar):Boolean; stdcall;
function WLRegSmartKeyInstallToRegistry(UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; AsciiKey:PAnsiChar):Boolean; stdcall;
function WLRegSmartKeyInstallToRegistryW(UserName:PWideChar; Organization:PWideChar; CustomData:PWideChar; SmartKeyKey:PWideChar):Boolean; stdcall;
function WLTrialCustomCounterInc(Value:Integer; CounterID:Integer):Integer; stdcall;
function WLTrialCustomCounterDec(Value:Integer; CounterID:Integer):Integer; stdcall;
function WLTrialCustomCounterSet(Value:Integer; CounterID:Integer):Integer; stdcall;
function WLTrialCustomCounter(CounterID:Integer):Integer; stdcall;
function WLRestartApplication:Boolean; stdcall;
function WLRegLockedCountry:Integer; stdcall;
function WLRegRuntimeLeft:Integer; stdcall;
function WLRegGlobalTimeLeft:Integer; stdcall;
function WLRegRemoveCurrentKey:Boolean; stdcall;
function WLHardwareGetFormattedID(CharBlockSize:Integer; Uppercase:Integer; Buffer:PAnsiChar):Boolean; stdcall;
function WLPasswordCheck(UserName:PAnsiChar; Password:PAnsiChar):Boolean; stdcall;
function WLTrialExpireTrial:Boolean; stdcall;
function WLStringDecrypt(pString:PAnsiChar):PAnsiChar; stdcall;
function WLStringDecryptW(pString:PWideChar):PWideChar; stdcall;
function GenUniqueLicenseHash(p1:PAnsiChar; p2:PAnsiChar; p3:PAnsiChar; p4:PAnsiChar; p5:PAnsiChar):Boolean;stdcall;  // internal use
function ECCGenerateKeys(p1:PAnsiChar; p2:PAnsiChar; p3: PAnsiChar; p4:PAnsiChar):Boolean;stdcall;                    // internal use
procedure WLRegLicenseName(FileKeyName:PAnsiChar; RegKeyName:PAnsiChar; RegKeyValueName:PAnsiChar);stdcall;
function WLRestartApplicationArgs(pArgs:PAnsiChar):Boolean; stdcall;
function WLActGetInfo(var Custom1:Integer; var Custom2:Integer; var Custom3:Integer):Boolean; stdcall;
function WLActCheck(ActivationCode:PAnsiChar):Boolean; stdcall;
function WLActInstall(ActivationCode:PAnsiChar):Boolean; stdcall;
function WLActExpirationDate(var pExpDate:SYSTEMTIME):Boolean; stdcall;
function WLActDaysToActivate:Integer; stdcall;
function WLActUninstall:Boolean; stdcall;
function WLGetCurrentCountry:Integer; stdcall;
function WLRegGetLicenseHardwareID(pHardId:PAnsiChar):Boolean; stdcall;
function WLTrialExtGetLevel:Integer; stdcall;
function WLProtectCheckDebugger:Boolean; stdcall;
function WLTrialExtendExpiration(NumDays:Integer; NumExec:Integer; var NewDate:SYSTEMTIME; NumMinutes:Integer; TimeRuntime:Integer):Boolean; stdcall;
function WLTrialFirstRun:Boolean; stdcall;
function WLRegFirstRun:Boolean; stdcall;
function WLRegCheckMachineLocked:Boolean; stdcall;
function WLRegDisableCurrentKey(DisableFlags:Integer):Boolean; stdcall;
procedure WLSplashHide;stdcall;
procedure WLBufferCrypt(StartBuffer:Pointer; LengthBuffer:Integer; Password:PAnsiChar); stdcall;
procedure WLBufferDecrypt(StartBuffer:Pointer; LengthBuffer:Integer; Password:PAnsiChar); stdcall;
function WLRegSmartKeyInstallToFileInFolder(UserName:PAnsiChar; Organization:PAnsiChar; CustomData:PAnsiChar; AsciiKey:PAnsiChar; FilePath:PAnsiChar):Boolean; stdcall;
function WLTrialDateDaysLeft:Integer; stdcall;
function WLRegDateDaysLeft:Integer; stdcall;
function WLRegGetDynSmartKey(SmartKey:PAnsiChar):Boolean; stdcall;
function WLRegDisableKeyCurrentInstance:Boolean;stdcall;
function WLHardwareRuntimeCheckU3:Boolean; stdcall;
procedure WLGetVersion(Buffer:PAnsiChar); stdcall;
function WLRegNetInstancesGet:Integer; stdcall;
function WLRegNetInstancesMax:Integer; stdcall;
procedure WLGetProtectionDate(var pProtectionDate:SYSTEMTIME); stdcall;
function WLProtectCheckCodeIntegrity:Boolean; stdcall;
function WLHardwareGetIdType:Integer; stdcall;
function WLTrialStringRead(StringName:PAnsiChar; StringValue:PAnsiChar):Boolean; stdcall;
function WLTrialStringWrite(StringName:PAnsiChar; StringValue:PAnsiChar):Boolean; stdcall;
function WLTrialStringReadW(StringName:PWideChar; StringValue:PWideChar):Boolean; stdcall;
function WLTrialStringWriteW(StringName:PWideChar; StringValue:PWideChar):Boolean; stdcall;
function WLTrialDebugCheck:Boolean; stdcall;
function WLRegExpirationTimestamp(var lpFileTime:FILETIME):Boolean; stdcall;
function WLTrialExpirationTimestamp(var lpFileTime:FILETIME):Boolean; stdcall;
function WLRegGetLicenseRestrictions:Integer; stdcall;
function WLRegGetLicenseType:Integer; stdcall;
function WLCheckVirtualPC:Boolean; stdcall;
function WLHardwareGetIDW(pHardId:PWideChar):Boolean; stdcall;
function WLTrialGetTrialRestrictions:Integer; stdcall;


implementation

const
  WinlicenseDLL = 'WinlicenseSDK.DLL';

function WLStringDecrypt; external WinlicenseDLL name 'WLStringDecrypt';
function WLStringDecryptW; external WinlicenseDLL name 'WLStringDecryptW';
function WLGenTrialExtensionFileKey; external WinlicenseDLL name 'WLGenTrialExtensionFileKey';
function WLGenTrialExtensionRegistryKey; external WinlicenseDLL name 'WLGenTrialExtensionRegistryKey';
function WLGenPassword; external WinlicenseDLL name 'WLGenPassword';
function WLGenLicenseFileKey; external WinlicenseDLL name 'WLGenLicenseFileKey';
function WLGenLicenseFileKeyW; external WinlicenseDLL name 'WLGenLicenseFileKeyW';
function WLGenLicenseFileKeyEx; external WinlicenseDLL name 'WLGenLicenseFileKeyEx';
function WLGenLicenseRegistryKeyEx; external WinlicenseDLL name 'WLGenLicenseRegistryKeyEx';
function WLGenLicenseTextKeyEx; external WinlicenseDLL name 'WLGenLicenseTextKeyEx';
function WLGenLicenseRegistryKey; external WinlicenseDLL name 'WLGenLicenseRegistryKey';
function WLGenLicenseRegistryKeyW; external WinlicenseDLL name 'WLGenLicenseRegistryKeyW';
function WLGenLicenseTextKey; external WinlicenseDLL name 'WLGenLicenseTextKey';
function WLGenLicenseTextKeyW; external WinlicenseDLL name 'WLGenLicenseTextKey';
function WLGenLicenseSmartKey; external WinlicenseDLL name 'WLGenLicenseSmartKey';
function WLGenLicenseSmartKeyW; external WinlicenseDLL name 'WLGenLicenseSmartKeyW';
function WLRegGetStatus; external WinlicenseDLL name 'WLRegGetStatus';
function WLTrialGetStatus; external WinlicenseDLL name 'WLTrialGetStatus';
function WLTrialExtGetStatus; external WinlicenseDLL name 'WLTrialExtGetStatus';
function WLRegGetLicenseInfo; external WinlicenseDLL name 'WLRegGetLicenseInfo';
function WLRegGetLicenseInfoW; external WinlicenseDLL name 'WLRegGetLicenseInfoW';
function WLTrialTotalDays; external WinlicenseDLL name 'WLTrialTotalDays';
function WLTrialTotalExecutions; external WinlicenseDLL name 'WLTrialTotalExecutions';
function WLTrialDaysLeft; external WinlicenseDLL name 'WLTrialDaysLeft';
function WLTrialExecutionsLeft; external WinlicenseDLL name 'WLTrialExecutionsLeft';
function WLTrialExpirationDate; external WinlicenseDLL name 'WLTrialExpirationDate';
function WLTrialGlobalTimeLeft; external WinlicenseDLL name 'WLTrialGlobalTimeLeft';
function WLTrialRuntimeLeft; external WinlicenseDLL name 'WLTrialRuntimeLeft';
function WLTrialLockedCountry; external WinlicenseDLL name 'WLTrialLockedCountry';
function WLRegDaysLeft; external WinlicenseDLL name 'WLRegDaysLeft';
function WLRegExecutionsLeft; external WinlicenseDLL name 'WLRegExecutionsLeft';
function WLRegExpirationDate; external WinlicenseDLL name 'WLRegExpirationDate';
function WLRegLicenseCreationDate; external WinlicenseDLL name 'WLRegLicenseCreationDate';
function WLRegTotalExecutions; external WinlicenseDLL name 'WLRegTotalExecutions';
function WLRegTotalDays; external WinlicenseDLL name 'WLRegTotalDays';
function WLHardwareGetID; external WinlicenseDLL name 'WLHardwareGetID';
function WLHardwareCheckID; external WinlicenseDLL name 'WLHardwareCheckID';
function WLRegSmartKeyCheck; external WinlicenseDLL name 'WLRegSmartKeyCheck';
function WLRegSmartKeyCheckW; external WinlicenseDLL name 'WLRegSmartKeyCheckW';
function WLRegNormalKeyCheck; external WinlicenseDLL name 'WLRegNormalKeyCheck';
function WLRegNormalKeyCheckW; external WinlicenseDLL name 'WLRegNormalKeyCheckW';
function WLRegNormalKeyInstallToFile; external WinlicenseDLL name 'WLRegNormalKeyInstallToFile';
function WLRegNormalKeyInstallToFileW; external WinlicenseDLL name 'WLRegNormalKeyInstallToFileW';
function WLRegNormalKeyInstallToRegistry; external WinlicenseDLL name 'WLRegNormalKeyInstallToRegistry';
function WLRegNormalKeyInstallToRegistryW; external WinlicenseDLL name 'WLRegNormalKeyInstallToRegistryW';
function WLRegSmartKeyInstallToFile; external WinlicenseDLL name 'WLRegSmartKeyInstallToFile';
function WLRegSmartKeyInstallToFileInFolder; external WinlicenseDLL name 'WLRegSmartKeyInstallToFileInFolder';
function WLRegSmartKeyInstallToFileW; external WinlicenseDLL name 'WLRegSmartKeyInstallToFileW';
function WLRegSmartKeyInstallToRegistry; external WinlicenseDLL name 'WLRegSmartKeyInstallToRegistry';
function WLRegSmartKeyInstallToRegistryW; external WinlicenseDLL name 'WLRegSmartKeyInstallToRegistryW';
function WLTrialCustomCounterInc; external WinlicenseDLL name 'WLTrialCustomCounterInc';
function WLTrialCustomCounterDec; external WinlicenseDLL name 'WLTrialCustomCounterDec';
function WLTrialCustomCounterSet; external WinlicenseDLL name 'WLTrialCustomCounterSet';
function WLTrialCustomCounter; external WinlicenseDLL name 'WLTrialCustomCounter';
function WLRestartApplication; external WinlicenseDLL name 'WLRestartApplication';
function WLRegLockedCountry; external WinlicenseDLL name 'WLRegLockedCountry';
function WLRegRuntimeLeft; external WinlicenseDLL name 'WLRegRuntimeLeft';
function WLRegGlobalTimeLeft; external WinlicenseDLL name 'WLRegGlobalTimeLeft';
function WLRegRemoveCurrentKey; external WinlicenseDLL name 'WLRegRemoveCurrentKey';
function WLHardwareGetFormattedID; external WinlicenseDLL name 'WLHardwareGetFormattedID';
function WLPasswordCheck; external WinlicenseDLL name 'WLPasswordCheck';
function WLTrialExpireTrial; external WinlicenseDLL name 'WLTrialExpireTrial';
function GenUniqueLicenseHash; external WinlicenseDLL name 'GenUniqueLicenseHash';
function ECCGenerateKeys; external WinlicenseDLL name 'ECCGenerateKeys';
procedure WLRegLicenseName; external WinlicenseDLL name 'WLRegLicenseName';
function WLRestartApplicationArgs; external WinlicenseDLL name 'WLRestartApplicationArgs';
function WLActGetInfo; external WinlicenseDLL name 'WLActGetInfo';
function WLActCheck; external WinlicenseDLL name 'WLActCheck';
function WLActInstall; external WinlicenseDLL name 'WLActInstall';
function WLActExpirationDate; external WinlicenseDLL name 'WLActExpirationDate';
function WLActDaysToActivate; external WinlicenseDLL name 'WLActDaysToActivate';
function WLActUninstall; external WinlicenseDLL name 'WLActUninstall';
function WLGetCurrentCountry; external WinlicenseDLL name 'WLGetCurrentCountry';
function WLRegGetLicenseHardwareID; external WinlicenseDLL name 'WLRegGetLicenseHardwareID';
function WLTrialExtGetLevel; external WinlicenseDLL name 'WLTrialExtGetLevel';
function WLProtectCheckDebugger; external WinlicenseDLL name 'WLProtectCheckDebugger';
function WLTrialExtendExpiration; external WinlicenseDLL name 'WLTrialExtendExpiration';
function WLTrialFirstRun; external WinlicenseDLL name 'WLTrialFirstRun';
function WLRegFirstRun; external WinlicenseDLL name 'WLRegFirstRun';
function WLRegCheckMachineLocked; external WinlicenseDLL name 'WLRegCheckMachineLocked';
function WLRegDisableCurrentKey; external WinlicenseDLL name 'WLRegDisableCurrentKey';
procedure WLSplashHide; external WinlicenseDLL name 'WLSplashHide';
procedure WLBufferCrypt; external WinlicenseDLL name 'WLBufferCrypt';
procedure WLBufferDecrypt; external WinlicenseDLL name 'WLBufferDecrypt';
function WLTrialDateDaysLeft; external WinlicenseDLL name 'WLTrialDateDaysLeft';
function WLRegDateDaysLeft; external WinlicenseDLL name 'WLRegDateDaysLeft';
function WLGenLicenseFileKeyExW; external WinlicenseDLL name 'WLGenLicenseFileKeyExW';
function WLGenLicenseRegistryKeyExW; external WinlicenseDLL name 'WLGenLicenseRegistryKeyExW';
function WLGenLicenseTextKeyExW; external WinlicenseDLL name 'WLGenLicenseTextKeyExW';
function WLGenLicenseDynSmartKey; external WinlicenseDLL name 'WLGenLicenseDynSmartKey';
function WLGenLicenseDynSmartKeyW; external WinlicenseDLL name 'WLGenLicenseDynSmartKeyW';
function WLRegGetDynSmartKey; external WinlicenseDLL name 'WLRegGetDynSmartKey';
function WLRegDisableKeyCurrentInstance; external WinlicenseDLL name 'WLRegDisableKeyCurrentInstance';
function WLHardwareRuntimeCheckU3; external WinlicenseDLL name 'WLHardwareRuntimeCheckU3';
procedure WLGetVersion; external WinlicenseDLL name 'WLGetVersion';
function WLRegNetInstancesGet; external WinlicenseDLL name 'WLRegNetInstancesGet';
function WLRegNetInstancesMax; external WinlicenseDLL name 'WLRegNetInstancesMax';
procedure WLGetProtectionDate; external WinlicenseDLL name 'WLGetProtectionDate';
function WLProtectCheckCodeIntegrity; external WinlicenseDLL name 'WLProtectCheckCodeIntegrity';
function WLHardwareGetIdType; external WinlicenseDLL name 'WLHardwareGetIdType';
function WLTrialStringRead; external WinlicenseDLL name 'WLTrialStringRead';
function WLTrialStringReadW; external WinlicenseDLL name 'WLTrialStringReadW';
function WLTrialStringWrite; external WinlicenseDLL name 'WLTrialStringWrite';
function WLTrialStringWriteW; external WinlicenseDLL name 'WLTrialStringWriteW';
function WLTrialDebugCheck; external WinlicenseDLL name 'WLTrialDebugCheck';
function WLRegExpirationTimestamp; external WinlicenseDLL name 'WLRegExpirationTimestamp';
function WLTrialExpirationTimestamp; external WinlicenseDLL name 'WLTrialExpirationTimestamp';
function WLRegGetLicenseRestrictions; external WinlicenseDLL name 'WLRegGetLicenseRestrictions';
function WLRegGetLicenseType; external WinlicenseDLL name 'WLRegGetLicenseType';
function WLCheckVirtualPC; external WinlicenseDLL name 'WLCheckVirtualPC';
function WLHardwareGetIDW; external WinlicenseDLL name 'WLHardwareGetIDW';
function WLTrialGetTrialRestrictions; external WinlicenseDLL name 'WLTrialGetTrialRestrictions';

end.

