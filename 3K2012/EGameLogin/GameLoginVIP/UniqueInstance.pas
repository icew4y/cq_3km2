{ unit UniqueInstance;                                                         }
{                                                                              }
{ Check if previous application instance exists, if yes, the previous          }
{ instance will be active, and current instance will be terminate.             }
{                                                                              }
{ written by savetime, http://savetime.delphibbs.com 2004/6/27                 }
{                                                                              }
{ Usage:                                                                       }
{   Include this unit to your delphi project, no more job to do.               }
{                                                                              }
{ Important:                                                                   }
{   You must NOT remove the project line: Application.Initialize;              }
{                                                                              }
{ Notes:                                                                       }
{   This unit identify an application by it's EXE file name. So, if you want   }
{   to specify another unique application name, you must change the value      }
{   UniqueApplicationName in CheckPriviousInstance procedure.                  }
{                                                                              }

unit UniqueInstance;

interface

uses Classes, SysUtils, Windows, Forms;

implementation

var
  UniqueMessageID: UINT;
  UniqueMutexHandle: THandle;
  PreviousWndProc: TFNWndProc;
  NextInitProc: Pointer;

function ApplicationWndProc(hWnd: HWND; uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LResult; stdcall;
begin
  // Note: Use "<>" may boost application speed.
  if uMsg <> UniqueMessageID then
    Result := CallWindowProc(PreviousWndProc, hWnd, uMsg, wParam, lParam)
  else begin
    if IsIconic(Application.Handle) then Application.Restore;
    SetForegroundWindow(Application.Handle);
    Result := 0;
  end;
end;

procedure BringPreiviousInstanceForeground;
const
  BSMRecipients: DWORD = BSM_APPLICATIONS;
begin
  BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
    @BSMRecipients, UniqueMessageID, 0, 0);
  Halt;
end;

procedure SubClassApplication;
begin
  PreviousWndProc := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC,
    Integer(@ApplicationWndProc)));
end;

procedure CheckPreviousInstance;
var
  UniqueApplicationName: PChar;
begin
  // Unique application name, default set to EXE file name,
  // you can change it to yourself.
  UniqueApplicationName := PChar(ExtractFileName(Application.ExeName));

  // Register unique message id
  UniqueMessageID := RegisterWindowMessage(UniqueApplicationName);

  // Create mutex object
  UniqueMutexHandle := CreateMutex(nil, False, UniqueApplicationName);

  // Create mutex failed, terminate application
  if UniqueMutexHandle = 0 then
    Halt
  // The same named mutex exists, show previous instance
  else if GetLastError = ERROR_ALREADY_EXISTS then
    BringPreiviousInstanceForeground
  // No previous instance, subclass application window
  else
    SubClassApplication;

  // Call next InitProc
  if NextInitProc <> nil then TProcedure(NextInitProc);
end;

initialization
  // Must use InitProc to check privious instance,
  // as the reason of Application hasn't been created!
  NextInitProc := InitProc;
  InitProc := @CheckPreviousInstance;

finalization
  // Close the mutex handle
  if UniqueMutexHandle <> 0 then CloseHandle(UniqueMutexHandle);

end. 


