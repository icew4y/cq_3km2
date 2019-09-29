//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("BSFCB5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("BusinessSkinForm.pas");
USEUNIT("bsdbgrids.pas");
USEUNIT("bsReg.pas");
USERES("bsReg.dcr");
USEUNIT("bsSkinBoxCtrls.pas");
USEUNIT("bsSkinCtrls.pas");
USEUNIT("bsSkinData.pas");
USEUNIT("bsSkinGrids.pas");
USEUNIT("bsSkinHint.pas");
USEUNIT("bsSkinMenus.pas");
USEUNIT("bsSkinTabs.pas");
USEUNIT("bsTrayIcon.pas");
USEUNIT("bsUtils.pas");
USEUNIT("bsdbctrls.pas");
USEPACKAGE("VCLDB50.bpi");
USEUNIT("bscalc.pas");
USEUNIT("bsSkinZip.pas");
USEUNIT("bsSkinUnZip.pas");
USEUNIT("bsMessages.pas");
USEUNIT("bsfilectrl.pas");
USEUNIT("bsSkinShellCtrls.pas");
USEUNIT("bsEffects.pas");
USEUNIT("bszlib.pas");
USEFORMNS("NBPagesEditor.pas", Nbpageseditor, NBPagesForm);
USEUNIT("bscalendar.pas");
USEUNIT("bsColorCtrls.pas");
USEPACKAGE("dsnide50.bpi");
USEUNIT("bsDialogs.pas");
USEUNIT("bszlibcompress.pas");
USEPACKAGE("bcbsmp50.bpi");
USEUNIT("bsconst.pas");
USEFORMNS("bsRootEdit.pas", Bsrootedit, bsRootPathEditDlg);
USEUNIT("bsSkinPrinter.pas");
USEUNIT("bscategorybuttons.pas");
USEUNIT("bsButtonGroup.pas");
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
