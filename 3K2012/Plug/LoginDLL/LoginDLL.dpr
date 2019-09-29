library LoginDLL;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  Windows;

{$R *.res}
function Login3kFw(Ver: Integer; Wait: Boolean; IP: PChar; Port: Integer; ModId: Integer): DWORD; stdcall;
begin
  Result := MessageBox(0,'DllLogin3kFw', nil,0);
end;

exports Login3kFw;

begin
  MessageBox(0,'DllMain', nil,0);
end.
