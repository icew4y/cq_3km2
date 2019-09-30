//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("EhLibDataDriversB50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("IBXDataDriverEh.pas");
USEUNIT("BDEDataDriverEh.pas");
USEUNIT("ADODataDriverEh.pas");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("vclado50.bpi");
USEPACKAGE("Vclbde50.bpi");
USEPACKAGE("VCLIB50.bpi");
USEPACKAGE("EhLibB50.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
