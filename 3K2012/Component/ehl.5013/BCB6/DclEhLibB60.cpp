//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("RichEdEh.pas", Richedeh, RichStrEditDlgEh);
USEFORMNS("PropStorageEditEh.pas", Propstorageediteh, PropStorageEditEhForm);
USEFORMNS("MTCreateDataDriver.pas", Mtcreatedatadriver, fMTCreateDataDriver);
USEFORMNS("SelectFromListDialog.pas", Selectfromlistdialog, fSelectFromListDialog);
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
