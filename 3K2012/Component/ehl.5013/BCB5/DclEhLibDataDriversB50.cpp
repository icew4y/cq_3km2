//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DclEhLibDataDriversB50.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("IBXDataDriverDesignEh.pas");
USEUNIT("BDEDataDriverDesignEh.pas");
USEUNIT("ADODataDriverDesignEh.pas");
USEPACKAGE("dcldb50.bpi");
USEPACKAGE("dclbde50.bpi");
USEPACKAGE("dclado50.bpi");
USEPACKAGE("VCLIB50.bpi");
USEPACKAGE("DclEhLibB50.bpi");
USEPACKAGE("EhLibDataDriversB50.bpi");
USEPACKAGE("EhLibB50.bpi");
USEPACKAGE("dclib50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("vclado50.bpi");
USEPACKAGE("VCLBDE50.bpi");
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
