//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("WinHTTPCB3.res");
USEPACKAGE("vcl35.bpi");
USEUNIT("_WinHTTPReg.pas");
USERES("_WinHTTPReg.dcr");
USELIB("inet.lib");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
    return 1;
}
//---------------------------------------------------------------------------
