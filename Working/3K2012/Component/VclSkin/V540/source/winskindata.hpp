// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winskindata.pas' rev: 10.00

#ifndef WinskindataHPP
#define WinskindataHPP

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
#include <Inifiles.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Filectrl.hpp>	// Pascal unit
#include <Skinread.hpp>	// Pascal unit
#include <Winskinstore.hpp>	// Pascal unit
#include <Imgutil.hpp>	// Pascal unit
#include <Winskinini.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winskindata
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TWinContainer { xccForm, xccFrame, xccToolbar, xccCoolbar, xccControlbar, xccPanel, xccScrollBox, xccGroupBox, xccTabSheet, xccPageScroller };
#pragma option pop

typedef Set<TWinContainer, xccForm, xccPageScroller>  TWinContainers;

#pragma option push -b-
enum TSkinOption { xoMDIScrollbar, xoMenuMerge, xoTransparent, xoPreview, xoParentBackGround, xoNoFocusRect, xoToolbarBK, xoToolbarButton, xoMDIChildBorder, xoMenuBG, xoFormScrollbar };
#pragma option pop

typedef Set<TSkinOption, xoMDIScrollbar, xoFormScrollbar>  TSkinOptions;

#pragma option push -b-
enum TSkinControlType { xcMainMenu, xcPopupMenu, xcMenuItem, xcToolbar, xcControlbar, xcCombo, xcCheckBox, xcRadioButton, xcProgress, xcScrollbar, xcEdit, xcButton, xcBitBtn, xcSpeedButton, xcSpin, xcPanel, xcGroupBox, xcStatusBar, xcTab, xcTrackBar, xcSystemMenu, xcFastReport };
#pragma option pop

typedef Set<TSkinControlType, xcMainMenu, xcFastReport>  TSkinControlTypes;

#pragma option push -b-
enum TShemeColor { csText, csTitleTextActive, csTitleTextNoActive, csButtonFace, csButtonText, csButtonHilight, csButtonlight, csButtonShadow, csButtonDkshadow, csSelectText, csSelectBg, csHilightText, csHilight, csMenuBar, csMenuBarText, csMenuText, csMenubg, csCaption, csScrollbar, csTextDisable };
#pragma option pop

typedef Graphics::TColor TShemeColors[20];

#pragma option push -b-
enum TSkinFormType { sfMainform, sfOnlyThisForm, sfDialog, sfDLL };
#pragma option pop

typedef void __fastcall (__closure *TOnFormSkin)(System::TObject* Sender, AnsiString aName, bool &DoSkin);

typedef void __fastcall (__closure *TOnSkinForm)(System::TObject* Sender, HWND ahwnd, AnsiString aName);

class DELPHICLASS TSkinData;
typedef void __fastcall (__closure *TOnSkinControl)(Classes::TComponent* Sender, TSkinData* SkinData, Controls::TControl* Form, Controls::TControl* Control, AnsiString ControlClass, Classes::TComponent* &SkinnedControl);

typedef BOOL __stdcall (*TGetScrollBarInfo)(HWND hwnd, int idObject, tagSCROLLBARINFO &psbi);

typedef BOOL __stdcall (*FTrackMouseEvent)(tagTRACKMOUSEEVENT &EventTrack);

typedef BOOL __stdcall (*TGetComboBoxInfo)(HWND hwndCombo, tagCOMBOBOXINFO &pcbi);

typedef void __stdcall (*TDisableProcessWindowsGhosting)(void);

class DELPHICLASS TDataSkinObject;
class PASCALIMPLEMENTATION TDataSkinObject : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	#pragma pack(push,1)
	Types::TRect r;
	#pragma pack(pop)
	Graphics::TBitmap* Map;
	int trans;
	int Tile;
	AnsiString IDName;
	int frame;
	int style;
	int Normalcolor;
	int Overcolor;
	int Downcolor;
	Graphics::TColor Normalcolor2;
	Graphics::TColor Overcolor2;
	Graphics::TColor Downcolor2;
	__fastcall TDataSkinObject(AnsiString AIDName);
	__fastcall virtual ~TDataSkinObject(void);
};


class DELPHICLASS TDataSkinBorder;
class PASCALIMPLEMENTATION TDataSkinBorder : public TDataSkinObject 
{
	typedef TDataSkinObject inherited;
	
public:
	Graphics::TBitmap* MaskMap;
	__fastcall TDataSkinBorder(AnsiString AIDName);
	__fastcall virtual ~TDataSkinBorder(void);
};


class DELPHICLASS TDataSkinTitle;
class PASCALIMPLEMENTATION TDataSkinTitle : public TDataSkinObject 
{
	typedef TDataSkinObject inherited;
	
public:
	int Aligment;
	int BackGround;
	int FontHeight;
	int backleft;
	int backright;
	Graphics::TColor activetext;
	Graphics::TColor inactivetext;
public:
	#pragma option push -w-inl
	/* TDataSkinObject.Create */ inline __fastcall TDataSkinTitle(AnsiString AIDName) : TDataSkinObject(AIDName) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TDataSkinObject.Destroy */ inline __fastcall virtual ~TDataSkinTitle(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDataSkinButton;
class PASCALIMPLEMENTATION TDataSkinButton : public TDataSkinObject 
{
	typedef TDataSkinObject inherited;
	
public:
	Graphics::TBitmap* CheckMap;
	Graphics::TBitmap* RadioMap;
	int radioframe;
	int checkframe;
	bool newnormal;
	bool newover;
	bool newdown;
	__fastcall TDataSkinButton(AnsiString AIDName);
	__fastcall virtual ~TDataSkinButton(void);
};


class DELPHICLASS TDataSkinSysButton;
class PASCALIMPLEMENTATION TDataSkinSysButton : public TDataSkinObject 
{
	typedef TDataSkinObject inherited;
	
public:
	int Action;
	int Align;
	int XCoord;
	int YCoord;
	int CombineOp;
	int Visibility;
	int Visibility1;
public:
	#pragma option push -w-inl
	/* TDataSkinObject.Create */ inline __fastcall TDataSkinSysButton(AnsiString AIDName) : TDataSkinObject(AIDName) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TDataSkinObject.Destroy */ inline __fastcall virtual ~TDataSkinSysButton(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDataSkinBoxLabel;
class PASCALIMPLEMENTATION TDataSkinBoxLabel : public TDataSkinObject 
{
	typedef TDataSkinObject inherited;
	
public:
	int LeftShift;
	int RightShift;
	int Alignment;
public:
	#pragma option push -w-inl
	/* TDataSkinObject.Create */ inline __fastcall TDataSkinBoxLabel(AnsiString AIDName) : TDataSkinObject(AIDName) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TDataSkinObject.Destroy */ inline __fastcall virtual ~TDataSkinBoxLabel(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinControlList;
class PASCALIMPLEMENTATION TSkinControlList : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TStrings* Fedit;
	Classes::TStrings* fCheckbox;
	Classes::TStrings* fRadiobutton;
	Classes::TStrings* fcombobox;
	void __fastcall SetEdit(Classes::TStrings* Value);
	void __fastcall SetCheckbox(Classes::TStrings* Value);
	void __fastcall SetRadiobutton(Classes::TStrings* Value);
	void __fastcall Setcombobox(Classes::TStrings* Value);
	
public:
	__fastcall TSkinControlList(void);
	__fastcall virtual ~TSkinControlList(void);
	
__published:
	__property Classes::TStrings* Edit = {read=Fedit, write=SetEdit};
	__property Classes::TStrings* Checkbox = {read=fCheckbox, write=SetCheckbox};
	__property Classes::TStrings* Combobox = {read=fcombobox, write=Setcombobox};
	__property Classes::TStrings* Radiobutton = {read=fRadiobutton, write=SetRadiobutton};
};


typedef DynamicArray<Graphics::TColor >  WinSkinData__9;

typedef DynamicArray<TDataSkinSysButton* >  WinSkinData__01;

class PASCALIMPLEMENTATION TSkinData : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	AnsiString fskinfile;
	Winskinini::TQuickIni* ini;
	Graphics::TColor fMenuSideBar;
	Classes::TMemoryStream* ms;
	bool factive;
	int fdisableTag;
	TWinContainers FContainers;
	TSkinControlTypes FSkinControls;
	TSkinOptions fSkinOptions;
	TSkinFormType ftype;
	TOnFormSkin fOnFormSkin;
	TOnSkinForm fOnBeforeSkinForm;
	TOnSkinForm fOnAfterSkinForm;
	Classes::TNotifyEvent fOnSkinChanged;
	TOnSkinControl FOnSkinControl;
	bool FInDLL;
	Classes::TStrings* f3rdControls;
	bool fmenuauto;
	AnsiString fversion;
	bool fmenumerge;
	Controls::THintWindow* fhintwindow;
	bool hashint;
	void __fastcall ReadMenuBar(TDataSkinObject* &aobject, AnsiString aname);
	void __fastcall ReadProgress(TDataSkinObject* &aobject, AnsiString aname);
	void __fastcall ReadRGB(AnsiString Section, AnsiString aname, Graphics::TColor &value);
	Graphics::TColor __fastcall GetColor(const AnsiString s1, Graphics::TColor acolor);
	void __fastcall SetFrame(void);
	int __fastcall GetSectionNum(AnsiString asection, AnsiString aname);
	void __fastcall WriteData(Classes::TStream* Stream);
	void __fastcall ReadData(Classes::TStream* Stream);
	AnsiString __fastcall GetSkinStore();
	void __fastcall SetSkinStore(const AnsiString Value);
	void __fastcall CreateMdibtn(int n);
	void __fastcall SetActive(bool Value);
	void __fastcall SetVersion(AnsiString Value);
	void __fastcall InitControlList(void);
	void __fastcall SetControlList(Classes::TStrings* Value);
	void __fastcall ReadTrack(TDataSkinObject* &aobject, AnsiString aname);
	void __fastcall CreateLogo(void);
	void __fastcall CreateCaptionFont(void);
	void __fastcall CreateMinCaption(void);
	
protected:
	void __fastcall ReadObject(TDataSkinObject* &aobject, AnsiString aname);
	void __fastcall ReadObject2(TDataSkinBorder* &aobject, AnsiString aname, AnsiString image2);
	void __fastcall ReadButton(void);
	void __fastcall ReadSysButton(void);
	void __fastcall LoadFromIni(AnsiString filename);
	void __fastcall ReadBord(void);
	void __fastcall ReadColor(void);
	void __fastcall ReadColor2(TShemeColor item, AnsiString key, Graphics::TColor cdefault);
	void __fastcall ReadTitle(TDataSkinObject* aobject, AnsiString aname);
	void __fastcall ReadBoxLabel(TDataSkinBoxLabel* &aobject, AnsiString aname);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall RebuildToolbar(void);
	void __fastcall ReBuildCombobox(void);
	void __fastcall ReBuildComboxArrow(void);
	virtual void __fastcall Loaded(void);
	bool __fastcall LoadSkin(void);
	void __fastcall UpdateSkin(void);
	
public:
	Skinread::TSkinReader* reader;
	Classes::TMemoryStream* data;
	bool Empty;
	Graphics::TColor Colors[20];
	bool hasColors[20];
	DynamicArray<Graphics::TColor >  ColorPreset;
	Graphics::TBitmap* SysIcon;
	TDataSkinTitle* Title;
	DynamicArray<TDataSkinSysButton* >  SysBtn;
	TDataSkinButton* Button;
	TDataSkinBorder* tab;
	TDataSkinBorder* HSpin;
	TDataSkinBorder* VSpin;
	TDataSkinObject* Comboxborder;
	TDataSkinObject* ExtraImages;
	TDataSkinBorder* combox;
	TDataSkinObject* comboxarrow;
	TDataSkinObject* Box;
	TDataSkinObject* Toolbar;
	TDataSkinObject* Toolbarbtn;
	TDataSkinObject* progress;
	TDataSkinObject* progresschunk;
	TDataSkinBoxLabel* boxlabel;
	TDataSkinObject* StatusBar;
	TDataSkinObject* TabSheet;
	TDataSkinObject* Header;
	TDataSkinObject* Menubar;
	TDataSkinObject* MenuItem;
	TDataSkinObject* MenuitemBG;
	TDataSkinObject* SArrow;
	TDataSkinObject* HBar;
	TDataSkinObject* VBar;
	TDataSkinObject* HSlider;
	TDataSkinObject* VSlider;
	TDataSkinObject* TrackHorz;
	TDataSkinObject* TrackVert;
	TDataSkinObject* TrackBar;
	TDataSkinObject* TrackBarVert;
	TDataSkinObject* TrackLeft;
	TDataSkinObject* Trackright;
	TDataSkinObject* Tracktop;
	TDataSkinObject* Trackbottom;
	TDataSkinObject* MinCaption;
	TDataSkinBorder* border[4];
	Classes::TStringList* sectionlist;
	int PresetColors[10];
	HBRUSH BGBrush;
	bool MenuMsg;
	Controls::TImageList* bmpmenu;
	AnsiString SkinName;
	Classes::TStrings* DebugList;
	int cxMax;
	int cyMax;
	Graphics::TBitmap* logo;
	Graphics::TFont* CaptionFont;
	unsigned formhwnd;
	int hintcount;
	__fastcall virtual TSkinData(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinData(void);
	void __fastcall LoadFromFile(AnsiString value);
	void __fastcall LoadFromStream(Classes::TStream* Stream);
	void __fastcall LoadFromCollection(Winskinstore::TSkinStore* astore, int aindex);
	void __fastcall Readbmp(Graphics::TBitmap* bmp, AnsiString fname);
	bool __fastcall GetPrecolor(Graphics::TColor &acolor, int n);
	AnsiString __fastcall GetFileName(AnsiString s);
	void __fastcall Uninstall(void);
	void __fastcall Install(void);
	void __fastcall DoFormSkin(unsigned ahwnd, AnsiString aname, bool &Doskin);
	void __fastcall DoSkinChanged(void);
	void __fastcall AddNestForm(Controls::TWinControl* fParent, Controls::TWinControl* fNested);
	void __fastcall UpdateSkinControl(Forms::TForm* fParent, Controls::TWinControl* acontrol = (Controls::TWinControl*)(0x0));
	void __fastcall DeleteGraphicControl(Forms::TForm* fParent, Controls::TGraphicControl* acontrol);
	void __fastcall UpdateMenu(Forms::TForm* fParent);
	void __fastcall UpdateMainMenu(bool done);
	void __fastcall SkinForm(unsigned ahwnd);
	void __fastcall InstallThread(int aThreadID);
	void __fastcall UnInstallThread(int aThreadID);
	void __fastcall ChangeProperty(System::TObject* control, AnsiString aprop, AnsiString value);
	void __fastcall EnableSkin(bool b);
	Graphics::TColor __fastcall GetCaptionColor(void);
	bool __fastcall GetScrollBarInfo(HWND hwnd, int idObject, tagSCROLLBARINFO &psbi);
	void __fastcall DoDebug(AnsiString s);
	void __fastcall ChangeForm(Forms::TForm* aform);
	void __fastcall GetAppIcon(void);
	void __fastcall ActivateHint(const Types::TRect &aRect, const AnsiString AHint);
	void __fastcall HideHint(void);
	bool __fastcall IsHint(void);
	
__published:
	__property bool Active = {read=factive, write=SetActive, nodefault};
	__property int DisableTag = {read=fdisableTag, write=fdisableTag, nodefault};
	__property TSkinControlTypes SkinControls = {read=FSkinControls, write=FSkinControls, nodefault};
	__property TSkinOptions Options = {read=fSkinOptions, write=fSkinOptions, nodefault};
	__property Classes::TStrings* Skin3rd = {read=f3rdControls, write=SetControlList};
	__property AnsiString SkinFile = {read=fskinfile, write=LoadFromFile};
	__property AnsiString SkinStore = {read=GetSkinStore, write=SetSkinStore};
	__property TSkinFormType SkinFormtype = {read=ftype, write=ftype, nodefault};
	__property AnsiString Version = {read=fversion, write=SetVersion};
	__property bool MenuUpdate = {read=fmenuauto, write=fmenuauto, nodefault};
	__property bool MenuMerge = {read=fmenumerge, write=fmenumerge, nodefault};
	__property TOnFormSkin OnFormSkin = {read=fOnFormSkin, write=fOnFormSkin};
	__property Classes::TNotifyEvent OnSkinChanged = {read=fOnSkinChanged, write=fOnSkinChanged};
	__property TOnSkinControl OnSkinControl = {read=FOnSkinControl, write=FOnSkinControl};
	__property TOnSkinForm OnBeforeSkinForm = {read=fOnBeforeSkinForm, write=fOnBeforeSkinForm};
	__property TOnSkinForm OnAfterSkinForm = {read=fOnAfterSkinForm, write=fOnAfterSkinForm};
};


//-- var, const, procedure ---------------------------------------------------
static const Word CN_SkinChanged = 0x3401;
static const Word CN_CaptionBtnClick = 0x3514;
static const Word CN_CaptionBtnVisible = 0x3515;
static const Word CN_UPdateMainMenu = 0x3505;
static const Word CN_SkinEnabled = 0x3506;
static const Word CN_TabSheetClose = 0x3507;
static const Word CN_SkinNotify = 0x3508;
static const short NM_COOLSB_CUSTOMDRAW = -2815;
#define c_version "5.14.12.20"
static const Word c_skintag = 0x8235;
static const Word BE_ID = 0x41a2;
static const Word BE_BECLOSE = 0x3046;
static const Word BE_BASE = 0xbc4a;
static const Word CM_BEPAINT = 0xbc4a;
static const Word CM_BENCPAINT = 0xbc4b;
static const Word CM_BEFULLRENDER = 0xbc4c;
static const Word CM_BEWAIT = 0xbc4d;
static const Word CM_BERUN = 0xbc4e;
extern PACKAGE TSkinData* GSkinData;
extern PACKAGE bool Win32PlatformIsUnicode;
extern PACKAGE bool IsVista;
extern PACKAGE unsigned DefaultUserCodePage;
extern PACKAGE TGetScrollBarInfo pGetScrollBarInfo;
extern PACKAGE FTrackMouseEvent pTrackMouseEvent;
extern PACKAGE TGetComboBoxInfo pGetComboBoxInfo;
extern PACKAGE TDisableProcessWindowsGhosting pDisableProcessWindowsGhosting;
extern PACKAGE WideString __fastcall StrToWideStr(const AnsiString S);
extern PACKAGE AnsiString __fastcall WideStringToStringEx(const WideString WS);
extern PACKAGE WideString __fastcall _WStr(WideChar * lpString, int cchCount);
extern PACKAGE int __fastcall Tnt_DrawTextW(HDC hDC, WideString wString, Types::TRect &lpRect, unsigned uFormat);
extern PACKAGE Graphics::TColor __fastcall RGBToColor(Byte R, Byte G, Byte B);
extern PACKAGE Graphics::TColor __fastcall strcolor(AnsiString s);
extern PACKAGE Controls::TWinControl* __fastcall FindControlx(HWND Handle);
extern PACKAGE void __fastcall SkinDll(void * adata);
extern PACKAGE void __fastcall DoTrackMouse(unsigned ahwnd);

}	/* namespace Winskindata */
using namespace Winskindata;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winskindata
