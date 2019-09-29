unit Share;

interface
uses
  Windows, SysUtils, Classes, Controls;
type
  TInit = function(nSoftType: Integer; btStatus: Byte; wCount: Word; MaxDate: TDateTime; UserName: PChar): PChar; stdcall;
  TUnInit = procedure(); stdcall;
  TGetFunAddr = function(nIndex: Integer): Pointer; stdcall;

  TOpenDiaLog = procedure(); stdcall;
  TGetLicense = procedure(var UserMode: Byte; var wCount: Word; var ErrorInfo: Integer;var btStatus: Byte); stdcall;
  TMakeRegisterInfo = function(btUserMode: Byte; sRegisterName: PChar; wCount: Word; UserName: PChar): PChar; stdcall;
  TGetRegisterName = function(): Integer; stdcall;
  TGetRegisterCode = function(): Integer; stdcall;
var
  Init: TInit;
  UnInit: TUnInit;
  GetFunAddr: TGetFunAddr;

  OpenDiaLog: TOpenDiaLog;
  GetLicenseShare: TGetLicense;
  GetRegisterNameShare:TGetRegisterName;
  GetRegisterCodeShare:TGetRegisterCode;
  MakeRegisterInfo: TMakeRegisterInfo;

  nRegisterCode:Integer;
  boEnterKey: Boolean;
  Moudle: THandle;
  nCheckCode:Integer;
implementation

end.
