// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winthread.pas' rev: 11.00

#ifndef WinthreadHPP
#define WinthreadHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winthread
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TEventWinThread;
class DELPHICLASS TCustomWinThread;
typedef void __fastcall (__closure *TWinThreadWaitTimeoutExpired)(System::TObject* Sender, bool &TerminateThread);

class PASCALIMPLEMENTATION TCustomWinThread : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TEventWinThread* FThread;
	bool FDesignSuspended;
	bool FHandleExceptions;
	bool FFreeOwnerOnTerminate;
	bool FWaitThread;
	unsigned FWaitTimeout;
	TWinThreadWaitTimeoutExpired FOnWaitTimeoutExpired;
	Classes::TNotifyEvent FSyncMethod;
	void *FSyncParams;
	void __fastcall InternalSynchronization(void);
	Classes::TThreadPriority __fastcall GetPriority(void);
	void __fastcall SetPriority(Classes::TThreadPriority Value);
	bool __fastcall GetSuspended(void);
	void __fastcall SetSuspended(bool Value);
	bool __fastcall GetTerminated(void);
	unsigned __fastcall GetThreadID(void);
	Classes::TNotifyEvent __fastcall GetOnException();
	void __fastcall SetOnException(Classes::TNotifyEvent Value);
	Classes::TNotifyEvent __fastcall GetOnExecute();
	void __fastcall SetOnExecute(Classes::TNotifyEvent Value);
	Classes::TNotifyEvent __fastcall GetOnTerminate();
	void __fastcall SetOnTerminate(Classes::TNotifyEvent Value);
	int __fastcall GetReturnValue(void);
	void __fastcall SetReturnValue(int Value);
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall DoWaitTimeoutExpired(bool &TerminateThread);
	
public:
	__fastcall virtual TCustomWinThread(Classes::TComponent* aOwner);
	__fastcall virtual ~TCustomWinThread(void);
	bool __fastcall Execute(void);
	bool __fastcall ExecuteAndWaitForEvent(unsigned &WaitHandle, unsigned Timeout = (unsigned)(0x0));
	void __fastcall Synchronize(Classes::TThreadMethod Method);
	void __fastcall SynchronizeEx(Classes::TNotifyEvent Method, void * Params);
	void __fastcall Suspend(void);
	void __fastcall Resume(void);
	void __fastcall Terminate(bool Imediately);
	unsigned __fastcall WaitFor(void);
	bool __fastcall WaitForEvent(unsigned &WaitHandle, unsigned Timeout = (unsigned)(0x0));
	unsigned __fastcall Handle(void);
	bool __fastcall Running(void);
	bool __fastcall RunningAndNotSuspended(void);
	__property bool Terminated = {read=GetTerminated, nodefault};
	__property unsigned ThreadID = {read=GetThreadID, nodefault};
	__property int ReturnValue = {read=GetReturnValue, write=SetReturnValue, nodefault};
	__property bool FreeOwnerOnTerminate = {read=FFreeOwnerOnTerminate, write=FFreeOwnerOnTerminate, default=0};
	__property bool HandleExceptions = {read=FHandleExceptions, write=FHandleExceptions, default=1};
	__property Classes::TThreadPriority Priority = {read=GetPriority, write=SetPriority, default=3};
	__property bool Suspended = {read=GetSuspended, write=SetSuspended, default=1};
	__property bool WaitThread = {read=FWaitThread, write=FWaitThread, default=0};
	__property unsigned WaitTimeout = {read=FWaitTimeout, write=FWaitTimeout, default=0};
	__property Classes::TNotifyEvent OnException = {read=GetOnException, write=SetOnException};
	__property Classes::TNotifyEvent OnExecute = {read=GetOnExecute, write=SetOnExecute};
	__property Classes::TNotifyEvent OnTerminate = {read=GetOnTerminate, write=SetOnTerminate};
	__property TWinThreadWaitTimeoutExpired OnWaitTimeoutExpired = {read=FOnWaitTimeoutExpired, write=FOnWaitTimeoutExpired};
};


class PASCALIMPLEMENTATION TEventWinThread : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	unsigned FHandle;
	unsigned FThreadID;
	bool FTerminated;
	bool FSuspended;
	bool FFreeOnTerminate;
	int FReturnValue;
	bool FRunning;
	Classes::TThreadMethod FMethod;
	System::TObject* FSynchronizeException;
	Classes::TNotifyEvent FOnExecute;
	Classes::TNotifyEvent FOnException;
	Classes::TNotifyEvent FOnTerminate;
	TCustomWinThread* Owner;
	Classes::TThreadPriority __fastcall GetPriority(void);
	void __fastcall SetPriority(Classes::TThreadPriority Value);
	void __fastcall SetSuspended(bool Value);
	void __fastcall CallTerminate(void);
	void __fastcall CallException(void);
	
protected:
	void __fastcall DoTerminate(void);
	void __fastcall Execute(void);
	void __fastcall Synchronize(Classes::TThreadMethod Method);
	__property int ReturnValue = {read=FReturnValue, write=FReturnValue, nodefault};
	__property bool Terminated = {read=FTerminated, nodefault};
	TEventWinThread* __fastcall CreateThread(void);
	TEventWinThread* __fastcall RecreateThread(void);
	
public:
	__fastcall TEventWinThread(TCustomWinThread* aOwner);
	__fastcall virtual ~TEventWinThread(void);
	void __fastcall Resume(void);
	void __fastcall Suspend(void);
	void __fastcall Terminate(void);
	unsigned __fastcall WaitFor(void);
	__property bool FreeOnTerminate = {read=FFreeOnTerminate, write=FFreeOnTerminate, nodefault};
	__property unsigned Handle = {read=FHandle, nodefault};
	__property Classes::TThreadPriority Priority = {read=GetPriority, write=SetPriority, nodefault};
	__property bool Suspended = {read=FSuspended, write=SetSuspended, nodefault};
	__property unsigned ThreadID = {read=FThreadID, nodefault};
	__property Classes::TNotifyEvent OnExecute = {read=FOnExecute, write=FOnExecute};
	__property Classes::TNotifyEvent OnException = {read=FOnException, write=FOnException};
	__property Classes::TNotifyEvent OnTerminate = {read=FOnTerminate, write=FOnTerminate};
};


class DELPHICLASS TWinThread;
class PASCALIMPLEMENTATION TWinThread : public TCustomWinThread 
{
	typedef TCustomWinThread inherited;
	
__published:
	__property HandleExceptions  = {default=1};
	__property Priority  = {default=3};
	__property Suspended  = {default=1};
	__property WaitThread  = {default=0};
	__property WaitTimeout  = {default=0};
	__property OnException ;
	__property OnExecute ;
	__property OnTerminate ;
	__property OnWaitTimeoutExpired ;
public:
	#pragma option push -w-inl
	/* TCustomWinThread.Create */ inline __fastcall virtual TWinThread(Classes::TComponent* aOwner) : TCustomWinThread(aOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomWinThread.Destroy */ inline __fastcall virtual ~TWinThread(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Winthread */
using namespace Winthread;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winthread
