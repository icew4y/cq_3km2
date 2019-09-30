// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sqleditframeeh.pas' rev: 11.00

#ifndef SqleditframeehHPP
#define SqleditframeehHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Dbgrideh.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Memtableeh.hpp>	// Pascal unit
#include <Datadrivereh.hpp>	// Pascal unit
#include <Gridseh.hpp>	// Pascal unit
#include <Memtabledataeh.hpp>	// Pascal unit
#include <Stdactns.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sqleditframeeh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TSQLEditFrame;
class PASCALIMPLEMENTATION TSQLEditFrame : public Forms::TFrame 
{
	typedef Forms::TFrame inherited;
	
__published:
	Extctrls::TPanel* Panel1;
	Extctrls::TSplitter* Splitter2;
	Extctrls::TPanel* Panel4;
	Comctrls::TRichEdit* RichEdit1;
	Extctrls::TPanel* Panel5;
	Stdctrls::TButton* Button3;
	Stdctrls::TButton* Check;
	Stdctrls::TButton* Button1;
	Extctrls::TPanel* Panel3;
	Dbgrideh::TDBGridEh* gridParams;
	Controls::TImageList* ImageList2;
	Extctrls::TPanel* Panel8;
	Buttons::TSpeedButton* SpeedButton2;
	Db::TDataSource* dsParams;
	Memtableeh::TMemTableEh* mtParams;
	Db::TStringField* mtParamsParName;
	Db::TStringField* mtParamsParType;
	Db::TStringField* mtParamsParValue;
	Actnlist::TActionList* ActionList1;
	Stdactns::TEditCut* EditCut1;
	Stdactns::TEditCopy* EditCopy1;
	Stdactns::TEditPaste* EditPaste1;
	Stdactns::TEditSelectAll* EditSelectAll1;
	Controls::TImageList* ImageList1;
	Buttons::TSpeedButton* spCut;
	Buttons::TSpeedButton* sbCopy;
	Buttons::TSpeedButton* spPaste;
	Buttons::TSpeedButton* sbSelectAll;
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall gridParamsColumns0UpdateData(System::TObject* Sender, AnsiString &Text, Variant &Value, bool &UseText, bool &Handled);
	
private:
	Datadrivereh::TBaseSQLCommandEh* FCommand;
	void __fastcall SetCommand(const Datadrivereh::TBaseSQLCommandEh* Value);
	
public:
	int Panel3Width;
	void __fastcall Created(void);
	void __fastcall RefreshFromCommand(void);
	void __fastcall PutToCommand(void);
	void __fastcall AssignToDesignControls(Datadrivereh::TCustomSQLCommandEh* Command);
	__property Datadrivereh::TBaseSQLCommandEh* Command = {read=FCommand, write=SetCommand};
public:
	#pragma option push -w-inl
	/* TCustomFrame.Create */ inline __fastcall virtual TSQLEditFrame(Classes::TComponent* AOwner) : Forms::TFrame(AOwner) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TSQLEditFrame(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TSQLEditFrame(HWND ParentWindow) : Forms::TFrame(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Sqleditframeeh */
using namespace Sqleditframeeh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Sqleditframeeh
