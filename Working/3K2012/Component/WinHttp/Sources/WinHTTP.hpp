// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winhttp.pas' rev: 11.00

#ifndef WinhttpHPP
#define WinhttpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Wininet.hpp>	// Pascal unit
#include <Winthread.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winhttp
{
//-- type declarations -------------------------------------------------------
typedef Set<char, 0, 255>  SetOfChar;

class DELPHICLASS TWinLoginComponent;
class PASCALIMPLEMENTATION TWinLoginComponent : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	void __fastcall ReadData(Classes::TStream* Stream);
	void __fastcall WriteData(Classes::TStream* Stream);
	
protected:
	AnsiString FLoginUsername;
	AnsiString FLoginPassword;
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TWinLoginComponent(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TWinLoginComponent(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TWinHTTPProgressEvent)(System::TObject* Sender, const AnsiString ContentType, int DataSize, int BytesRead, int ElapsedTime, int EstimatedTimeLeft, Byte PercentsDone, float TransferRate, Classes::TStream* Stream);

typedef void __fastcall (__closure *TWinHTTPUploadProgressEvent)(System::TObject* Sender, int DataSize, int BytesTransferred, int ElapsedTime, int EstimatedTimeLeft, Byte PercentsDone, float TransferRate);

typedef void __fastcall (__closure *TWinHTTPUploadFieldRequest)(System::TObject* Sender, Word FileIndex, Classes::TMemoryStream* UploadStream, AnsiString &FieldName, AnsiString &FileName);

typedef void __fastcall (__closure *TWinHTTPHeaderInfoEvent)(System::TObject* Sender, int ErrorCode, const AnsiString RawHeadersCRLF, const AnsiString ContentType, const AnsiString ContentLanguage, const AnsiString ContentEncoding, int ContentLength, const AnsiString Location, const System::TDateTime Date, const System::TDateTime LastModified, const System::TDateTime Expires, const AnsiString ETag, bool &ContinueDownload);

typedef void __fastcall (__closure *TWinHTTPStatusChanged)(System::TObject* Sender, unsigned StatusID, const AnsiString StatusStr);

typedef void __fastcall (__closure *TWinHTTPRedirected)(System::TObject* Sender, const AnsiString NewURL);

typedef void __fastcall (__closure *TWinHTTPDoneEvent)(System::TObject* Sender, const AnsiString ContentType, int FileSize, Classes::TStream* Stream);

typedef void __fastcall (__closure *TWinHTTPConnLostEvent)(System::TObject* Sender, const AnsiString ContentType, int FileSize, int BytesRead, Classes::TStream* Stream);

typedef void __fastcall (__closure *TWinHTTPErrorEvent)(System::TObject* Sender, int ErrorCode, Classes::TStream* Stream);

typedef void __fastcall (__closure *TWinHTTPPasswordRequestEvent)(System::TObject* Sender, const AnsiString Realm, bool &TryAgain);

typedef void __fastcall (__closure *TWinHTTPProxyAuthenticationEvent)(System::TObject* Sender, AnsiString &ProxyUsername, AnsiString &ProxyPassword, bool &TryAgain);

typedef void __fastcall (__closure *TWinHTTPBeforeSendRequest)(System::TObject* Sender, void * hRequest);

#pragma option push -b-
enum TWinHTTPPOSTMethod { pmFormURLEncoded, pmMultipartFormData };
#pragma option pop

#pragma option push -b-
enum TWinHTTPRequestMethod { rmAutoDetect, rmGET, rmPOST };
#pragma option pop

#pragma option push -b-
enum TWinHTTPAccessType { atPreconfig, atDirect, atUseProxy };
#pragma option pop

class DELPHICLASS TWinHTTPProxy;
class PASCALIMPLEMENTATION TWinHTTPProxy : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TWinHTTPAccessType FAccessType;
	int FProxyPort;
	AnsiString FProxyServer;
	AnsiString FProxyBypass;
	AnsiString FProxyUsername;
	AnsiString FProxyPassword;
	bool __fastcall IsUseProxy(void);
	
public:
	__fastcall TWinHTTPProxy(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TWinHTTPAccessType AccessType = {read=FAccessType, write=FAccessType, default=0};
	__property int ProxyPort = {read=FProxyPort, write=FProxyPort, default=8080};
	__property AnsiString ProxyServer = {read=FProxyServer, write=FProxyServer, stored=IsUseProxy};
	__property AnsiString ProxyBypass = {read=FProxyBypass, write=FProxyBypass, stored=IsUseProxy};
	__property AnsiString ProxyUsername = {read=FProxyUsername, write=FProxyUsername};
	__property AnsiString ProxyPassword = {read=FProxyPassword, write=FProxyPassword};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWinHTTPProxy(void) { }
	#pragma option pop
	
};


class DELPHICLASS TWinHTTPRange;
class PASCALIMPLEMENTATION TWinHTTPRange : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	unsigned FStartRange;
	unsigned FEndRange;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property unsigned StartRange = {read=FStartRange, write=FStartRange, default=0};
	__property unsigned EndRange = {read=FEndRange, write=FEndRange, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWinHTTPRange(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TWinHTTPRange(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TWinHTTPTimeouts;
class PASCALIMPLEMENTATION TWinHTTPTimeouts : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	unsigned FConnectTimeout;
	unsigned FReceiveTimeout;
	unsigned FSendTimeout;
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property unsigned ConnectTimeout = {read=FConnectTimeout, write=FConnectTimeout, default=0};
	__property unsigned ReceiveTimeout = {read=FReceiveTimeout, write=FReceiveTimeout, default=0};
	__property unsigned SendTimeout = {read=FSendTimeout, write=FSendTimeout, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWinHTTPTimeouts(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TWinHTTPTimeouts(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


#pragma option push -b-
enum TWinHTTPFileAttribute { atrArchive, atrHidden, atrReadOnly, atrSystem, atrTemporary, atrOffline };
#pragma option pop

typedef Set<TWinHTTPFileAttribute, atrArchive, atrOffline>  TWinHTTPFileAttributes;

class DELPHICLASS TWinHTTPOutputFileAttributes;
class PASCALIMPLEMENTATION TWinHTTPOutputFileAttributes : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TWinHTTPFileAttributes FComplete;
	TWinHTTPFileAttributes FIncomplete;
	void __fastcall SetComplete(const TWinHTTPFileAttributes Value);
	void __fastcall SetIncomplete(const TWinHTTPFileAttributes Value);
	
protected:
	DYNAMIC void __fastcall AttributesChanged(void);
	
public:
	__fastcall TWinHTTPOutputFileAttributes(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TWinHTTPFileAttributes Complete = {read=FComplete, write=SetComplete, default=1};
	__property TWinHTTPFileAttributes Incomplete = {read=FIncomplete, write=SetIncomplete, default=17};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TWinHTTPOutputFileAttributes(void) { }
	#pragma option pop
	
};


class DELPHICLASS TWinHTTPFileStream;
class PASCALIMPLEMENTATION TWinHTTPFileStream : public Classes::THandleStream 
{
	typedef Classes::THandleStream inherited;
	
public:
	__fastcall TWinHTTPFileStream(const AnsiString FileName, bool CreateNew);
	__fastcall virtual ~TWinHTTPFileStream(void);
};


typedef int TBufferSize;

#pragma option push -b-
enum TInternetOption { ioIgnoreCertificateInvalid, ioIgnoreCertificateDateInvalid, ioIgnoreUnknownCertificateAuthority, ioIgnoreRedirectToHTTP, ioIgnoreRedirectToHTTPS, ioKeepConnection, ioNoAuthentication, ioNoAutoRedirect, ioNoCookies };
#pragma option pop

typedef Set<TInternetOption, ioIgnoreCertificateInvalid, ioNoCookies>  TInternetOptions;

#pragma option push -b-
enum TCacheOption { coAlwaysReload, coReloadIfNoExpireInformation, coReloadUpdatedObjects, coPragmaNoCache, coNoCacheWrite, coCreateTempFilesIfCantCache, coUseCacheIfNetFail };
#pragma option pop

typedef Set<TCacheOption, coAlwaysReload, coUseCacheIfNetFail>  TCacheOptions;

class DELPHICLASS TCustomWinHTTP;
class PASCALIMPLEMENTATION TCustomWinHTTP : public TWinLoginComponent 
{
	typedef TWinLoginComponent inherited;
	
private:
	Classes::TStrings* FAddHeaders;
	AnsiString FAcceptTypes;
	AnsiString FAgent;
	AnsiString FOutputFileName;
	TWinHTTPOutputFileAttributes* FOutputFileAttributes;
	AnsiString FURL;
	AnsiString FPostData;
	AnsiString FReferer;
	TCacheOptions FCacheOptions;
	TInternetOptions FInternetOptions;
	TWinHTTPRange* FRange;
	TWinHTTPTimeouts* FTimeouts;
	TBufferSize FTransferBufferSize;
	bool HTTPUploadFailed;
	TWinHTTPPOSTMethod FPOSTMethod;
	TWinHTTPRequestMethod FRequestMethod;
	TWinHTTPProxy* FProxy;
	bool FShowGoOnlineMessage;
	bool FWorkOffline;
	void *FData;
	TWinHTTPBeforeSendRequest FOnBeforeSendRequest;
	TWinHTTPHeaderInfoEvent FOnHeaderInfo;
	TWinHTTPDoneEvent FOnDone;
	Classes::TNotifyEvent FOnDoneInterrupted;
	TWinHTTPProgressEvent FOnProgress;
	TWinHTTPStatusChanged FOnStatusChanged;
	TWinHTTPRedirected FOnRedirected;
	TWinHTTPUploadProgressEvent FOnUploadProgress;
	TWinHTTPUploadFieldRequest FOnUploadFieldRequest;
	Classes::TNotifyEvent FOnUploadCGITimeoutFailed;
	Classes::TNotifyEvent FOnAnyError;
	Classes::TNotifyEvent FOnAborted;
	TWinHTTPConnLostEvent FOnConnLost;
	Classes::TNotifyEvent FOnHostUnreachable;
	TWinHTTPErrorEvent FOnHTTPError;
	Classes::TNotifyEvent FOnOutputFileError;
	TWinHTTPPasswordRequestEvent FOnPasswordRequest;
	TWinHTTPProxyAuthenticationEvent FOnProxyAuthenticationRequest;
	Winthread::TWinThreadWaitTimeoutExpired FOnWaitTimeoutExpired;
	bool FBusy;
	bool FRealBusy;
	Winthread::TCustomWinThread* FThread;
	Classes::TStream* HTTPStream;
	bool HTTPSuccess;
	bool HTTPTryAgain;
	bool HTTPOutputToFile;
	bool HTTPContinueDownload;
	bool HTTPDeleteOutputFileOnAbort;
	void *HTTPData;
	unsigned HTTPFileSize;
	unsigned HTTPBytesTransferred;
	unsigned HTTPStartTime;
	unsigned HTTPInitStartRange;
	unsigned HTTPInitEndRange;
	AnsiString HTTPUploadRequestHeader;
	void *hSession;
	void *hConnect;
	void *hRequest;
	unsigned hFile;
	void __fastcall SetAddHeaders(Classes::TStrings* Value);
	bool __fastcall GetSuspended(void);
	void __fastcall SetSuspended(bool Value);
	Classes::TThreadPriority __fastcall GetThreadPriority(void);
	void __fastcall SetThreadPriority(Classes::TThreadPriority Value);
	bool __fastcall GetWaitThread(void);
	void __fastcall SetWaitThread(bool Value);
	int __fastcall GetWaitTimeout(void);
	void __fastcall SetWaitTimeout(int Value);
	bool __fastcall GetThreadBusy(void);
	bool __fastcall GetFreeOnTerminate(void);
	void __fastcall SetFreeOnTerminate(bool Value);
	AnsiString __fastcall GetFileName();
	AnsiString __fastcall GetHostName();
	bool __fastcall IsNotDefaultAcceptTypes(void);
	void __fastcall PrepareProgressParams(void);
	void __fastcall CloseHTTPHandles(void);
	void __fastcall AbortAndReleaseStreams(void);
	void __fastcall ThreadExecute(System::TObject* Sender);
	void __fastcall ThreadException(System::TObject* Sender);
	void __fastcall ThreadDone(System::TObject* Sender);
	void __fastcall ThreadWaitTimeoutExpired(System::TObject* Sender, bool &TerminateThread);
	void __fastcall CallAborted(void);
	void __fastcall CallHeaderInfo(void);
	void __fastcall CallProgress(void);
	void __fastcall CallUploadProgress(void);
	void __fastcall CallPasswordRequest(void);
	void __fastcall CallProxyAuthenticationRequest(void);
	
protected:
	AnsiString HTTPRawHeadersCRLF;
	AnsiString HTTPContentType;
	AnsiString HTTPContentLanguage;
	AnsiString HTTPContentEncoding;
	AnsiString HTTPLocation;
	AnsiString HTTPETag;
	System::TDateTime HTTPDate;
	System::TDateTime HTTPLastModified;
	System::TDateTime HTTPExpires;
	Byte ProgressPercentsDone;
	unsigned ProgressElapsedTime;
	unsigned ProgressEstimatedTime;
	float ProgressTransferRate;
	void __fastcall DoAnyError(void);
	void __fastcall ReleaseHTTPStream(void);
	
public:
	int HTTPErrorCode;
	__fastcall virtual TCustomWinHTTP(Classes::TComponent* aOwner);
	__fastcall virtual ~TCustomWinHTTP(void);
	bool __fastcall Read(bool ForceWaitThread = false);
	bool __fastcall ReadRange(unsigned StartRange, unsigned EndRange = (unsigned)(0x0), bool ForceWaitThread = false);
	bool __fastcall Upload(Word NumberOfFields);
	bool __fastcall BeginPrepareUpload(void);
	void __fastcall UploadStream(const AnsiString FieldName, Classes::TStream* UploadStream, const AnsiString FileName = "");
	void __fastcall UploadString(const AnsiString FieldName, const AnsiString StrValue);
	void __fastcall UploadInteger(const AnsiString FieldName, int IntValue);
	void __fastcall UploadBoolean(const AnsiString FieldName, bool BoolValue);
	void __fastcall UploadPicture(const AnsiString FieldName, Graphics::TPicture* Picture, const AnsiString FileName = "pic");
	void __fastcall EndPrepareUpload(void);
	void __fastcall Abort(bool DeleteOutputFile = false, bool HardTerminate = false);
	void __fastcall Pause(void);
	bool __fastcall Resume(void);
	bool __fastcall IsGlobalOffline(void);
	__property AnsiString Username = {read=FLoginUsername, write=FLoginUsername, stored=false};
	__property AnsiString Password = {read=FLoginPassword, write=FLoginPassword, stored=false};
	__property bool Busy = {read=FBusy, nodefault};
	__property bool ThreadBusy = {read=GetThreadBusy, nodefault};
	__property bool FreeOnTerminate = {read=GetFreeOnTerminate, write=SetFreeOnTerminate, nodefault};
	__property AnsiString FileName = {read=GetFileName};
	__property AnsiString HostName = {read=GetHostName};
	__property Winthread::TCustomWinThread* Thread = {read=FThread};
	__property AnsiString AcceptTypes = {read=FAcceptTypes, write=FAcceptTypes, stored=IsNotDefaultAcceptTypes};
	__property Classes::TStrings* AddHeaders = {read=FAddHeaders, write=SetAddHeaders};
	__property AnsiString Agent = {read=FAgent, write=FAgent};
	__property TWinHTTPProxy* Proxy = {read=FProxy, write=FProxy};
	__property bool ShowGoOnlineMessage = {read=FShowGoOnlineMessage, write=FShowGoOnlineMessage, default=0};
	__property TCacheOptions CacheOptions = {read=FCacheOptions, write=FCacheOptions, default=38};
	__property TInternetOptions InternetOptions = {read=FInternetOptions, write=FInternetOptions, default=32};
	__property AnsiString OutputFileName = {read=FOutputFileName, write=FOutputFileName};
	__property TWinHTTPOutputFileAttributes* OutputFileAttributes = {read=FOutputFileAttributes, write=FOutputFileAttributes};
	__property AnsiString URL = {read=FURL, write=FURL};
	__property AnsiString POSTData = {read=FPostData, write=FPostData};
	__property TWinHTTPRange* Range = {read=FRange, write=FRange};
	__property AnsiString Referer = {read=FReferer, write=FReferer};
	__property TWinHTTPRequestMethod RequestMethod = {read=FRequestMethod, write=FRequestMethod, default=0};
	__property TWinHTTPTimeouts* Timeouts = {read=FTimeouts, write=FTimeouts};
	__property TBufferSize TransferBufferSize = {read=FTransferBufferSize, write=FTransferBufferSize, default=4096};
	__property bool WorkOffline = {read=FWorkOffline, write=FWorkOffline, default=0};
	__property void * Data = {read=FData, write=FData, stored=false};
	__property bool Suspended = {read=GetSuspended, write=SetSuspended, nodefault};
	__property Classes::TThreadPriority ThreadPriority = {read=GetThreadPriority, write=SetThreadPriority, default=3};
	__property bool WaitThread = {read=GetWaitThread, write=SetWaitThread, default=0};
	__property int WaitTimeout = {read=GetWaitTimeout, write=SetWaitTimeout, default=0};
	__property TWinHTTPBeforeSendRequest OnBeforeSendRequest = {read=FOnBeforeSendRequest, write=FOnBeforeSendRequest};
	__property TWinHTTPHeaderInfoEvent OnHeaderInfo = {read=FOnHeaderInfo, write=FOnHeaderInfo};
	__property TWinHTTPDoneEvent OnDone = {read=FOnDone, write=FOnDone};
	__property TWinHTTPProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TWinHTTPStatusChanged OnStatusChanged = {read=FOnStatusChanged, write=FOnStatusChanged};
	__property TWinHTTPRedirected OnRedirected = {read=FOnRedirected, write=FOnRedirected};
	__property TWinHTTPUploadProgressEvent OnUploadProgress = {read=FOnUploadProgress, write=FOnUploadProgress};
	__property TWinHTTPUploadFieldRequest OnUploadFieldRequest = {read=FOnUploadFieldRequest, write=FOnUploadFieldRequest};
	__property Classes::TNotifyEvent OnUploadCGITimeoutFailed = {read=FOnUploadCGITimeoutFailed, write=FOnUploadCGITimeoutFailed};
	__property Classes::TNotifyEvent OnAnyError = {read=FOnAnyError, write=FOnAnyError};
	__property Classes::TNotifyEvent OnAborted = {read=FOnAborted, write=FOnAborted};
	__property TWinHTTPConnLostEvent OnConnLost = {read=FOnConnLost, write=FOnConnLost};
	__property Classes::TNotifyEvent OnDoneInterrupted = {read=FOnDoneInterrupted, write=FOnDoneInterrupted};
	__property Classes::TNotifyEvent OnOutputFileError = {read=FOnOutputFileError, write=FOnOutputFileError};
	__property TWinHTTPPasswordRequestEvent OnPasswordRequest = {read=FOnPasswordRequest, write=FOnPasswordRequest};
	__property TWinHTTPProxyAuthenticationEvent OnProxyAuthenticationRequest = {read=FOnProxyAuthenticationRequest, write=FOnProxyAuthenticationRequest};
	__property Classes::TNotifyEvent OnHostUnreachable = {read=FOnHostUnreachable, write=FOnHostUnreachable};
	__property TWinHTTPErrorEvent OnHTTPError = {read=FOnHTTPError, write=FOnHTTPError};
	__property Winthread::TWinThreadWaitTimeoutExpired OnWaitTimeoutExpired = {read=FOnWaitTimeoutExpired, write=FOnWaitTimeoutExpired};
};


class DELPHICLASS TWinHTTPPragmaNoCache;
class PASCALIMPLEMENTATION TWinHTTPPragmaNoCache : public TCustomWinHTTP 
{
	typedef TCustomWinHTTP inherited;
	
public:
	__fastcall virtual TWinHTTPPragmaNoCache(Classes::TComponent* aOwner);
	__property CacheOptions  = {default=14};
public:
	#pragma option push -w-inl
	/* TCustomWinHTTP.Destroy */ inline __fastcall virtual ~TWinHTTPPragmaNoCache(void) { }
	#pragma option pop
	
};


class DELPHICLASS TWinHTTP;
class PASCALIMPLEMENTATION TWinHTTP : public TCustomWinHTTP 
{
	typedef TCustomWinHTTP inherited;
	
__published:
	__property AcceptTypes ;
	__property AddHeaders ;
	__property Agent ;
	__property Proxy ;
	__property URL ;
	__property Username ;
	__property CacheOptions  = {default=38};
	__property InternetOptions  = {default=32};
	__property OutputFileName ;
	__property OutputFileAttributes ;
	__property Password ;
	__property POSTData ;
	__property Range ;
	__property Referer ;
	__property ShowGoOnlineMessage  = {default=0};
	__property RequestMethod  = {default=0};
	__property Timeouts ;
	__property ThreadPriority  = {default=3};
	__property TransferBufferSize  = {default=4096};
	__property WaitThread  = {default=0};
	__property WaitTimeout  = {default=0};
	__property WorkOffline  = {default=0};
	__property OnBeforeSendRequest ;
	__property OnHeaderInfo ;
	__property OnDone ;
	__property OnDoneInterrupted ;
	__property OnOutputFileError ;
	__property OnProgress ;
	__property OnRedirected ;
	__property OnUploadProgress ;
	__property OnUploadFieldRequest ;
	__property OnUploadCGITimeoutFailed ;
	__property OnAnyError ;
	__property OnAborted ;
	__property OnConnLost ;
	__property OnHTTPError ;
	__property OnHostUnreachable ;
	__property OnPasswordRequest ;
	__property OnProxyAuthenticationRequest ;
	__property OnWaitTimeoutExpired ;
public:
	#pragma option push -w-inl
	/* TCustomWinHTTP.Create */ inline __fastcall virtual TWinHTTP(Classes::TComponent* aOwner) : TCustomWinHTTP(aOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomWinHTTP.Destroy */ inline __fastcall virtual ~TWinHTTP(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word DefaultProxyPort = 0x1f90;
#define DefaultProxyBypass "127.0.0.1;"
static const Word DEF_TRANSFERBUFFERSIZE = 0x1000;
#define TEXTHTML "text/html"
#define DEF_ACCEPT_TYPES "text/html, */*"
#define S_PIC "pic"
static const Word HTTP_STATUS_RANGE_NOT_SATISFIABLE = 0x1a0;
extern PACKAGE AnsiString __fastcall IncludeLeadingChar(const AnsiString St, char Ch = '\x5c');
extern PACKAGE AnsiString __fastcall ExcludeLeadingChar(const AnsiString St, char Ch = '\x5c');
extern PACKAGE void __fastcall ReplaceChars(AnsiString &Str, char Replacer, const SetOfChar &Replaced);
extern PACKAGE AnsiString __fastcall RegReadStr(const AnsiString KeyName, const AnsiString ValueName, HKEY RootKey = (HKEY)(0x80000001));
extern PACKAGE AnsiString __fastcall StreamToString(Classes::TStream* Stream, bool FromBeginning = false);
extern PACKAGE AnsiString __fastcall URLEncode(const AnsiString Str);
extern PACKAGE AnsiString __fastcall URLDecode(AnsiString Str);
extern PACKAGE bool __fastcall ParseURL(AnsiString URL, AnsiString &Protocol, AnsiString &HostName, AnsiString &URLPath, AnsiString &Username, AnsiString &Password, AnsiString &ExtraInfo, Word &Port);
extern PACKAGE AnsiString __fastcall URLToHostName(const AnsiString URL);
extern PACKAGE AnsiString __fastcall URLToFileName(const AnsiString URL);
extern PACKAGE AnsiString __fastcall URLToPathFileName(const AnsiString URL, bool PathAsFolder = false);
extern PACKAGE AnsiString __fastcall HTTPErrorToStr(int ErrorCode);
extern PACKAGE AnsiString __fastcall HTTPReadString(const AnsiString URL, int Timeout = 0x0);
extern PACKAGE System::TDateTime __fastcall GMTToLocalTime(const System::TDateTime GMTTime);
extern PACKAGE System::TDateTime __fastcall InternetTimeToDateTime(AnsiString InternetTime);
extern PACKAGE bool __fastcall SetFileAttr(const AnsiString FileName, const TWinHTTPFileAttributes FileAttr);
extern PACKAGE bool __fastcall GetFileAttr(const AnsiString FileName, TWinHTTPFileAttributes &FileAttr);

}	/* namespace Winhttp */
using namespace Winhttp;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winhttp
