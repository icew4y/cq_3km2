// Borland C++ Builder
// Copyright (c) 1995, 2005 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Winsubclass.pas' rev: 10.00

#ifndef WinsubclassHPP
#define WinsubclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Winskindata.hpp>	// Pascal unit
#include <Tabs.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Winsubclass
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSkinControlState { scMouseIn, scDown };
#pragma option pop

class DELPHICLASS TAcControl;
class PASCALIMPLEMENTATION TAcControl : public Controls::TControl 
{
	typedef Controls::TControl inherited;
	
public:
	#pragma option push -w-inl
	/* TControl.Create */ inline __fastcall virtual TAcControl(Classes::TComponent* AOwner) : Controls::TControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TControl.Destroy */ inline __fastcall virtual ~TAcControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TAcWinControl;
class PASCALIMPLEMENTATION TAcWinControl : public Controls::TWinControl 
{
	typedef Controls::TWinControl inherited;
	
public:
	#pragma option push -w-inl
	/* TWinControl.Create */ inline __fastcall virtual TAcWinControl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TAcWinControl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TAcWinControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TAcGraphicControl;
class PASCALIMPLEMENTATION TAcGraphicControl : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
public:
	#pragma option push -w-inl
	/* TGraphicControl.Create */ inline __fastcall virtual TAcGraphicControl(Classes::TComponent* AOwner) : Controls::TGraphicControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TAcGraphicControl(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinAcListView;
class PASCALIMPLEMENTATION TSkinAcListView : public Comctrls::TCustomListView 
{
	typedef Comctrls::TCustomListView inherited;
	
public:
	#pragma option push -w-inl
	/* TCustomListView.Create */ inline __fastcall virtual TSkinAcListView(Classes::TComponent* AOwner) : Comctrls::TCustomListView(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomListView.Destroy */ inline __fastcall virtual ~TSkinAcListView(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TSkinAcListView(HWND ParentWindow) : Comctrls::TCustomListView(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinControl;
class PASCALIMPLEMENTATION TSkinControl : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
protected:
	Set<TSkinControlState, scMouseIn, scDown>  state;
	Graphics::TCanvas* fCanvas;
	bool done;
	bool isdraw;
	bool enabled;
	bool focused;
	WideString caption;
	void *FObjectInst;
	void *FPrevWndProc;
	bool skinned;
	bool isunicode;
	void __fastcall FillBG(HDC dc, const Types::TRect &rc);
	void __fastcall FillParentBG(HDC dc, const Types::TRect &rc);
	void __fastcall doLogMsg(AnsiString aid, const Messages::TMessage &msg);
	void __fastcall Default(Messages::TMessage &Msg);
	void __fastcall Invalidate(void);
	void __fastcall WMPaint(const Messages::TMessage &message);
	void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	int __fastcall GetWindowLongEx(HWND ahWnd, int nIndex);
	void __fastcall SetParentBK(bool value);
	void __fastcall DrawFocus(HDC hDC, WideString wString, const Types::TRect &rc, unsigned uFormat);
	
public:
	Winskindata::TSkinData* fsd;
	HWND hwnd;
	Classes::TWndMethod OldWndProc;
	Controls::TWinControl* control;
	#pragma pack(push,1)
	Types::TRect boundsrect;
	#pragma pack(pop)
	Controls::TGraphicControl* GControl;
	bool newColor;
	Graphics::TColor oldcolor;
	bool Inited;
	int skinstate;
	Classes::TComponent* skinform;
	int kind;
	bool sizing;
	bool parentbk;
	__fastcall virtual TSkinControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinControl(void);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual void __fastcall Inithwnd(unsigned ahwnd, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, Classes::TComponent* sf);
	void __fastcall MouseLeave(void);
	virtual void __fastcall Unsubclass(void);
	void __fastcall NewWndProc(Messages::TMessage &Message);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual void __fastcall PaintControl(HDC adc = (HDC)(0x0));
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	virtual void __fastcall SkinChange(void);
	virtual int __fastcall GetState(void);
	void __fastcall SetColor(void);
	void __fastcall RestoreColor(void);
	void __fastcall DrawBMPSkin(Graphics::TBitmap* abmp, const Types::TRect &rc, Winskindata::TDataSkinObject* aObject, int I, int N, int trans);
	void __fastcall DrawSkinMap(HDC dc, const Types::TRect &rc, Winskindata::TDataSkinObject* aObject, int I, int N);
	void __fastcall DrawSkinMap1(HDC dc, const Types::TRect &rc, Graphics::TBitmap* bmp, int I, int N);
	void __fastcall DrawSkinMap2(HDC dc, const Types::TRect &rc, Graphics::TBitmap* bmp, int I, int N);
	void __fastcall DrawSkin(const Types::TRect &rc, Winskindata::TDataSkinObject* aObject, int I, int N, int trans);
	void __fastcall DrawSkinMap3(Graphics::TCanvas* acanvas, const Types::TRect &rc, Graphics::TBitmap* bmp, int I, int N);
	void __fastcall DrawBuf(HDC dc, const Types::TRect &rc);
	void __fastcall DrawCaption(Graphics::TCanvas* acanvas, const Types::TRect &rc, WideString text, bool enabled, bool defaulted, Word Alignment = (Word)(0x1));
	void __fastcall DrawImgCaption(Graphics::TCanvas* acanvas, const Types::TRect &rc, unsigned ImgList, int imgIndex, WideString text, int talign = 0x1);
	int __fastcall TextHeight(HDC dc, const AnsiString s);
	Graphics::TColor __fastcall GetParentColor(Graphics::TColor acolor);
	unsigned __fastcall CheckBiDi(unsigned dw);
};


class DELPHICLASS TArrowButton;
class PASCALIMPLEMENTATION TArrowButton : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TMessage &aMsg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUP(Messages::TMessage &aMsg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &aMsg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &aMsg);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	int cw;
	Controls::TWinControl* control;
	TSkinControl* obj;
	unsigned hwnd;
	Set<TSkinControlState, scMouseIn, scDown>  state;
	__fastcall virtual TArrowButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TArrowButton(void);
	void __fastcall Attach(TSkinControl* aobj, Controls::TWinControl* acontrol);
	void __fastcall MoveArrow(const Types::TRect &r);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TArrowButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinDateTime;
class PASCALIMPLEMENTATION TSkinDateTime : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	TArrowButton* arrow;
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	
public:
	__fastcall virtual ~TSkinDateTime(void);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinDateTime(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	
};


class DELPHICLASS TWScrollbar;
class PASCALIMPLEMENTATION TWScrollbar : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TMessage &aMsg);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Messages::TMessage &aMsg);
	MESSAGE void __fastcall WMMouseLeave(Messages::TMessage &aMsg);
	MESSAGE void __fastcall WMLButtonDBClick(Messages::TMessage &aMsg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TMessage &aMsg);
	HIDESBASE MESSAGE void __fastcall WMERASEBKGND(Messages::TMessage &Msg);
	
protected:
	int Len;
	int thumbTop;
	int thumbbottom;
	#pragma pack(push,1)
	Types::TPoint OffsetSC;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint trackp;
	#pragma pack(pop)
	int trackthumb;
	bool fdown;
	int sbDir;
	bool ERASEBKGND;
	int scrollpos;
	virtual void __fastcall Paint(void);
	void __fastcall GetThumb(const Types::TRect &rc);
	int __fastcall GetScrollPos(const Types::TPoint &p);
	bool __fastcall GetControlInfo(tagSCROLLBARINFO &info);
	bool __fastcall GetControlInfo2(tagSCROLLBARINFO &info);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	int CW;
	unsigned hwnd;
	Controls::TWinControl* control;
	TSkinControl* obj;
	Byte sbType;
	#pragma pack(push,1)
	Types::TRect sbRect;
	#pragma pack(pop)
	bool sbVisible;
	__fastcall virtual TWScrollbar(Classes::TComponent* AOwner);
	__fastcall virtual ~TWScrollbar(void);
	void __fastcall Attach(TSkinControl* aobj, Controls::TWinControl* aControl, Byte aType);
	void __fastcall AttachHwnd(TSkinControl* aobj, unsigned ahwnd, Byte aType);
	void __fastcall SetPosition(unsigned ahwnd);
	void __fastcall ButtonUp(void);
	void __fastcall HideScrollbar(void);
	void __fastcall DoLog(const Messages::TMessage &Message);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TWScrollbar(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinButton;
class PASCALIMPLEMENTATION TSkinButton : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	Graphics::TBitmap* btemp;
	bool MultiLine;
	bool trans;
	bool redraw;
	bool isdefault;
	void __fastcall DrawBtnText(Graphics::TCanvas* acanvas, const Types::TRect &rc, AnsiString text, Word Alignment = (Word)(0x1));
	void __fastcall DoMouseDown(Messages::TWMMouse &Message);
	void __fastcall WMEnable(Messages::TMessage &Message);
	void __fastcall SetRedraw(bool b);
	bool __fastcall GetFontColor(Graphics::TColor &acolor);
	
public:
	__fastcall virtual TSkinButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinButton(void);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
};


class DELPHICLASS TSkinBitButton;
class PASCALIMPLEMENTATION TSkinBitButton : public TSkinButton 
{
	typedef TSkinButton inherited;
	
protected:
	void __fastcall DrawGlyph(Graphics::TCanvas* acanvas, const Types::TRect &rc, Graphics::TBitmap* bmp, int I, int N);
	void __fastcall DrawPicControl(HDC dc, const Types::TRect &rc);
	
public:
	bool isPicture;
	AnsiString PicField;
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinButton.Create */ inline __fastcall virtual TSkinBitButton(Classes::TComponent* AOwner) : TSkinButton(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinButton.Destroy */ inline __fastcall virtual ~TSkinBitButton(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TMPBtnType { btPlay, btPause, btStop, btNext, btPrev, btStep, btBack, btRecord, btEject };
#pragma option pop

typedef Set<TMPBtnType, btPlay, btEject>  TButtonSet;

#pragma option push -b-
enum TMPGlyph { mgEnabled, mgDisabled, mgColored };
#pragma option pop

struct TMPButton
{
	
public:
	bool Visible;
	bool Enabled;
	bool Colored;
	bool Auto;
	Graphics::TBitmap* Bitmaps[3];
} ;

class DELPHICLASS TWMediaPlayer;
class PASCALIMPLEMENTATION TWMediaPlayer : public Extctrls::TCustomPanel 
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TMessage &aMsg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TMessage &aMsg);
	void __fastcall LoadBitmaps(void);
	void __fastcall DestroyBitmaps(void);
	void __fastcall CheckButtons(void);
	void __fastcall FindButton(int XPos, int YPos);
	
protected:
	TMPButton Buttons[9];
	int count;
	Winskindata::TSkinData* fsd;
	bool IsDown;
	TMPBtnType BtnClick;
	TMPBtnType BtnFocuse;
	int BtnWidth;
	virtual void __fastcall Paint(void);
	void __fastcall DrawButton(Graphics::TCanvas* acanvas, TMPBtnType Btn, const Types::TRect &R);
	
public:
	Controls::TWinControl* obj;
	TSkinControl* skincontrol;
	__fastcall virtual TWMediaPlayer(Classes::TComponent* AOwner);
	__fastcall virtual ~TWMediaPlayer(void);
	void __fastcall Attach(TSkinControl* askin, Controls::TWinControl* aObj);
	void __fastcall SetPosition(Controls::TWinControl* aObj);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TWMediaPlayer(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinMP;
class PASCALIMPLEMENTATION TSkinMP : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	TWMediaPlayer* mp;
	virtual void __fastcall Unsubclass(void);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	
public:
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinMP(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinMP(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinMenuButton;
class PASCALIMPLEMENTATION TSkinMenuButton : public TSkinButton 
{
	typedef TSkinButton inherited;
	
protected:
	void __fastcall DrawGlyph(Graphics::TCanvas* acanvas, const Types::TRect &rc, Graphics::TBitmap* bmp, int I, int N);
	
public:
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinButton.Create */ inline __fastcall virtual TSkinMenuButton(Classes::TComponent* AOwner) : TSkinButton(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinButton.Destroy */ inline __fastcall virtual ~TSkinMenuButton(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinSpeedButton;
class PASCALIMPLEMENTATION TSkinSpeedButton : public TSkinBitButton 
{
	typedef TSkinBitButton inherited;
	
protected:
	bool FReentr;
	void __fastcall DrawPicbtn(Graphics::TCanvas* acanvas, const Types::TRect &rc);
	
public:
	AnsiString PicField;
	Graphics::TCanvas* gcanvas;
	__fastcall virtual TSkinSpeedButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinSpeedButton(void);
	void __fastcall DrawSpeedbtn(Graphics::TCanvas* acanvas, const Types::TRect &rc);
	void __fastcall InitGraphicControl(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall PaintControl(HDC adc = (HDC)(0x0));
	void __fastcall WMPaintSpeed(Messages::TMessage &Message);
};


class DELPHICLASS TSkinCheckBox;
class PASCALIMPLEMENTATION TSkinCheckBox : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	int state;
	bool trans;
	
public:
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinCheckBox(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinCheckBox(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinComBox;
class DELPHICLASS TSkinScrollbarH;
class PASCALIMPLEMENTATION TSkinScrollbarH : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	void __fastcall SetScrollbarPos(const Messages::TMessage &message);
	virtual void __fastcall Unsubclass(void);
	
public:
	TWScrollbar* hb;
	TWScrollbar* vb;
	int postype;
	__fastcall virtual TSkinScrollbarH(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinScrollbarH(void);
	virtual void __fastcall Inithwnd(unsigned ahwnd, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, Classes::TComponent* sf);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
};


class DELPHICLASS TComboxScrollBar;
class PASCALIMPLEMENTATION TComboxScrollBar : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	bool nobe;
	int cw;
	int len;
	int scrollpos;
	int thumbtop;
	int thumbBottom;
	#pragma pack(push,1)
	Types::TPoint OffsetSC;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint trackp;
	#pragma pack(pop)
	int trackthumb;
	bool fdown;
	int sbDir;
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	void __fastcall PaintScrollbar(HDC dc, const Types::TRect &rc, int sbtype);
	virtual void __fastcall Unsubclass(void);
	void __fastcall GetThumb(const Types::TRect &rc);
	bool __fastcall WMNCPaint(Messages::TMessage &message);
	bool __fastcall NCLButtonDown(Messages::TMessage &Message);
	
public:
	int postype;
	bool painted;
	bool border;
	__fastcall virtual TComboxScrollBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TComboxScrollBar(void);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
};


class PASCALIMPLEMENTATION TSkinComBox : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	unsigned dwStyle;
	unsigned ExStyle;
	unsigned hlist;
	unsigned hbtn;
	bool isDrop;
	void *FBtnObjectInst;
	void *FBtnPrevWndProc;
	TSkinScrollbarH* vb;
	TComboxScrollBar* db;
	#pragma pack(push,1)
	tagCOMBOBOXINFO info;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect rBtn;
	#pragma pack(pop)
	void __fastcall FindBtn(void);
	HIDESBASE void __fastcall DrawSkinMap3(HDC dc, const Types::TRect &rc, Graphics::TBitmap* bmp, int I, int N);
	void __fastcall DrawControl1(HDC dc, const Types::TRect &rc);
	void __fastcall ButtonProc(Messages::TMessage &Message);
	void __fastcall CNCommand(Messages::TWMCommand &Message);
	virtual void __fastcall Unsubclass(void);
	void __fastcall DrawEdit(HDC dc, const Types::TRect &rc);
	void __fastcall SkinDropList(void);
	void __fastcall DeleteDropList(void);
	void __fastcall DrawBorder(HDC dc, const Types::TRect &rc);
	void __fastcall DrawArrow(HDC dc, const Types::TRect &rc, int i);
	
public:
	bool HasButton;
	__fastcall virtual TSkinComBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinComBox(void);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual void __fastcall Inithwnd(unsigned ahwnd, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, Classes::TComponent* sf);
};


class DELPHICLASS TSkinRadioButton;
class PASCALIMPLEMENTATION TSkinRadioButton : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	bool trans;
	
public:
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinRadioButton(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinRadioButton(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinStatusBar;
class PASCALIMPLEMENTATION TSkinStatusBar : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	void __fastcall Defaultpaint(Graphics::TCanvas* acanvas, const Types::TRect &rc, int I, WideString text = L"", Classes::TAlignment Align = (Classes::TAlignment)(0x0));
	void __fastcall drawitem(HDC dc, const Types::TRect &rc, int I, WideString text = L"", Classes::TAlignment Align = (Classes::TAlignment)(0x0));
	
public:
	bool SizeGrip;
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinStatusBar(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinStatusBar(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinBox;
class PASCALIMPLEMENTATION TSkinBox : public TSkinControl 
{
	typedef TSkinControl inherited;
	
public:
	int border;
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual void __fastcall Unsubclass(void);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinBox(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinBox(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinGroupBox;
class PASCALIMPLEMENTATION TSkinGroupBox : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	void __fastcall DefaultDraw(HDC dc, const Types::TRect &rc);
	
public:
	int border;
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinGroupBox(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinGroupBox(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinUpDown;
class PASCALIMPLEMENTATION TSkinUpDown : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	void __fastcall DrawButton(Graphics::TCanvas* acanvas, const Types::TRect &rc, int n, int ar);
	void __fastcall DrawSkinButton(HDC dc, const Types::TRect &rc, int n, int ar);
	void __fastcall DrawBackGround(const Messages::TMessage &msg);
	
public:
	bool inedit;
	int dir;
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinUpDown(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinUpDown(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSkinTabPosition { StTop, Stbottom, Stleft, Stright };
#pragma option pop

typedef DynamicArray<Types::TRect >  WinSubClass__32;

class DELPHICLASS TSkinTab;
class PASCALIMPLEMENTATION TSkinTab : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	DynamicArray<Types::TRect >  CloseRect;
	TSkinTabPosition Position;
	bool unicode;
	void __fastcall Drawitem(HDC dc, const Types::TRect &rc, int I);
	void __fastcall ERASEBKGND(HDC dc);
	void __fastcall GetPosition(void);
	void __fastcall ClipUpdown(HDC dc, const Types::TRect &rc);
	bool __fastcall FindScroll(void);
	void __fastcall DrawTabBorder(HDC adc);
	void __fastcall drawCloseBtn(const Types::TRect &rc, int i);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	bool __fastcall ClickClose(Messages::TMessage &Message);
	
public:
	Graphics::TBitmap* tabbmp;
	Graphics::TBitmap* borderbmp;
	Graphics::TBitmap* Drawtemp;
	TSkinUpDown* updown;
	bool showclose;
	__fastcall virtual TSkinTab(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinTab(void);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual void __fastcall Inithwnd(unsigned ahwnd, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, Classes::TComponent* sf);
	void __fastcall inittab(void);
	virtual void __fastcall SkinChange(void);
};


class DELPHICLASS TSkinTab31;
class PASCALIMPLEMENTATION TSkinTab31 : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	Graphics::TBitmap* tabbmp;
	TSkinUpDown* updown;
	Controls::TWinControl* scroller;
	
public:
	__fastcall virtual TSkinTab31(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinTab31(void);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	void __fastcall inittab(void);
	virtual void __fastcall SkinChange(void);
};


class DELPHICLASS TSkinTabBtn;
class PASCALIMPLEMENTATION TSkinTabBtn : public TSkinControl 
{
	typedef TSkinControl inherited;
	
public:
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinTabBtn(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinTabBtn(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinTransObj;
class PASCALIMPLEMENTATION TSkinTransObj : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	void __fastcall ERASEBKGND(HDC dc);
	
public:
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinTransObj(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinTransObj(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinProgress;
class PASCALIMPLEMENTATION TSkinProgress : public TSkinControl 
{
	typedef TSkinControl inherited;
	
public:
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	void __fastcall DrawControl1(HDC dc, const Types::TRect &rc);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinProgress(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinProgress(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinTrackBar;
class PASCALIMPLEMENTATION TSkinTrackBar : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	void __fastcall Drawthumb(Commctrl::PNMCustomDraw PDraw);
	int __fastcall CustomDraw(Commctrl::PNMCustomDraw PDraw);
	void __fastcall DrawTrack(Commctrl::PNMCustomDraw PDraw);
	
public:
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual void __fastcall SkinChange(void);
	virtual void __fastcall Unsubclass(void);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinTrackBar(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinTrackBar(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinToolbar;
class PASCALIMPLEMENTATION TSkinToolbar : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	int gradCol1;
	int gradCol2;
	void __fastcall ERASEBKGND(const Messages::TMessage &msg);
	
public:
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinToolbar(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinToolbar(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinEdit;
class PASCALIMPLEMENTATION TSkinEdit : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	void __fastcall FindUPDown(unsigned ahwnd, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas);
	void __fastcall DrawControl1(HDC dc, const Types::TRect &rc);
	void __fastcall PaintControl1(HDC adc = (HDC)(0x0));
	
public:
	TSkinUpDown* updown;
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinEdit(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinEdit(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinSizer;
class PASCALIMPLEMENTATION TSkinSizer : public TSkinControl 
{
	typedef TSkinControl inherited;
	
public:
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinSizer(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinSizer(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinBoxH;
class PASCALIMPLEMENTATION TSkinBoxH : public TSkinControl 
{
	typedef TSkinControl inherited;
	
public:
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinBoxH(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinBoxH(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinTabSheet;
class PASCALIMPLEMENTATION TSkinTabSheet : public TSkinControl 
{
	typedef TSkinControl inherited;
	
public:
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinTabSheet(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinTabSheet(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinObjImage;
class PASCALIMPLEMENTATION TSkinObjImage : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	void __fastcall ChangeImage(void);
	void __fastcall SetRzImage(void);
	void __fastcall SetRzRadio(void);
	void __fastcall SetDevCheck(void);
	
public:
	int kind;
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual void __fastcall SkinChange(void);
	virtual void __fastcall Unsubclass(void);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinObjImage(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinObjImage(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinAdvPage;
class PASCALIMPLEMENTATION TSkinAdvPage : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	TSkinUpDown* updown;
	void __fastcall ChangeImage(void);
	void __fastcall SetAdvPage(void);
	bool __fastcall FindScroll(void);
	
public:
	int kind;
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual void __fastcall SkinChange(void);
	virtual void __fastcall Unsubclass(void);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinAdvPage(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinControl.Destroy */ inline __fastcall virtual ~TSkinAdvPage(void) { }
	#pragma option pop
	
};


struct TScrollBarPos
{
	
public:
	int Btn;
	int ScrollArea;
	int Thumb;
	int ThumbPos;
	int MsgID;
} ;

#pragma option push -b-
enum TSkinScroll { HB, VB };
#pragma option pop

class DELPHICLASS TSkinScrollbar;
class PASCALIMPLEMENTATION TSkinScrollbar : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	bool nobe;
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	void __fastcall SetScrollbarPos(const Messages::TMessage &message);
	virtual void __fastcall Unsubclass(void);
	void __fastcall DrawBorder(HDC dc, const Types::TRect &rc);
	void __fastcall BENCPAINT(HDC adc);
	
public:
	TWScrollbar* hb;
	TWScrollbar* vb;
	int postype;
	bool painted;
	bool border;
	__fastcall virtual TSkinScrollbar(Classes::TComponent* AOwner);
	__fastcall virtual ~TSkinScrollbar(void);
	virtual void __fastcall InitScrollbar(Controls::TWinControl* acontrol, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, Classes::TComponent* sf);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	virtual void __fastcall SkinChange(void);
};


class DELPHICLASS TSkinScControl;
class PASCALIMPLEMENTATION TSkinScControl : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	int downBtn;
	TScrollBarPos SP;
	TWScrollbar* sb;
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	
public:
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
	void __fastcall InitScrollbar(Controls::TWinControl* acontrol, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, Classes::TComponent* sf);
	virtual void __fastcall Unsubclass(void);
	__fastcall virtual ~TSkinScControl(void);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinScControl(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	
};


typedef DynamicArray<Types::TRect >  WinSubClass__14;

class DELPHICLASS TSkinHeader;
class PASCALIMPLEMENTATION TSkinHeader : public TSkinControl 
{
	typedef TSkinControl inherited;
	
protected:
	DynamicArray<Types::TRect >  Items;
	int indexitem;
	void __fastcall WMMouseMove(Messages::TMessage &Message);
	void __fastcall DrawItem(unsigned ImgList, Graphics::TCanvas* acanvas, const Types::TRect &rc, int index);
	void __fastcall DrawItemImgCaption(Graphics::TCanvas* acanvas, const Types::TRect &rc, unsigned ImgList, int imgIndex, WideString text, int talign = 0x1);
	
public:
	__fastcall virtual ~TSkinHeader(void);
	virtual void __fastcall Inithwnd(unsigned ahwnd, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, Classes::TComponent* sf);
	virtual void __fastcall Init(Classes::TComponent* sf, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, bool acolor = false);
	virtual bool __fastcall BeforeProc(Messages::TMessage &Message);
	virtual void __fastcall AfterProc(Messages::TMessage &Message);
	virtual void __fastcall DrawControl(HDC dc, const Types::TRect &rc);
public:
	#pragma option push -w-inl
	/* TSkinControl.Create */ inline __fastcall virtual TSkinHeader(Classes::TComponent* AOwner) : TSkinControl(AOwner) { }
	#pragma option pop
	
};


class DELPHICLASS TSkinListView;
class PASCALIMPLEMENTATION TSkinListView : public TSkinScrollbar 
{
	typedef TSkinScrollbar inherited;
	
protected:
	void *FHeaderInstance;
	void *FDefHeaderProc;
	unsigned hHwnd;
	TSkinHeader* header;
	void __fastcall SetHeaderOwnerDraw(void);
	void __fastcall DrawHeaderItem(const tagDRAWITEMSTRUCT &DrawItemStruct);
	void __fastcall Drawheader(void);
	void __fastcall drawitem(HDC dc, const Types::TRect &rc, Comctrls::TListColumn* acolumn);
	void __fastcall WMNotify(Messages::TWMNotify &Message);
	
public:
	virtual void __fastcall InitScrollbar(Controls::TWinControl* acontrol, Winskindata::TSkinData* sd, Graphics::TCanvas* acanvas, Classes::TComponent* sf);
	void __fastcall HeaderProc(Messages::TMessage &Message);
public:
	#pragma option push -w-inl
	/* TSkinScrollbar.Create */ inline __fastcall virtual TSkinListView(Classes::TComponent* AOwner) : TSkinScrollbar(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSkinScrollbar.Destroy */ inline __fastcall virtual ~TSkinListView(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
static const Byte CM_Scroll1 = 0xa1;
static const Word CM_Scroll2 = 0x201;
static const Byte CM_Scroll3 = 0xa2;
static const Word CM_Scroll4 = 0x202;
static const Shortint C_Paramv = 0x7;
static const Shortint C_Paramh = 0x6;
static const Shortint c_paramB = 0x1;
static const Byte SBM_GETSCROLLBARINFO = 0xeb;
extern PACKAGE void __fastcall CopyBMP(Graphics::TBitmap* src, Graphics::TBitmap* &dst);
extern PACKAGE void __fastcall FillColor(HDC dc, const Types::TRect &rc, Graphics::TColor acolor);
extern PACKAGE AnsiString __fastcall GetProperty(System::TObject* control, AnsiString aprop);
extern PACKAGE int __fastcall GetIntProperty(System::TObject* control, AnsiString aprop);
extern PACKAGE AnsiString __fastcall GetEnumProperty(System::TObject* control, AnsiString aprop);
extern PACKAGE WideString __fastcall GetStringProp(System::TObject* control, AnsiString aprop);
extern PACKAGE System::TMethod __fastcall GetObjMethod(System::TObject* control, AnsiString aprop);
extern PACKAGE System::TObject* __fastcall GetObjProp(System::TObject* control, AnsiString aprop, TMetaClass* MinClass);
extern PACKAGE void __fastcall SetProperty(System::TObject* control, AnsiString aprop, AnsiString value);
extern PACKAGE WideString __fastcall StringReplaceW(WideString s, WideString s1, WideString s2);
extern PACKAGE void __fastcall MyDrawCaption(Graphics::TCanvas* acanvas, const Types::TRect &rc, WideString text, bool enabled, bool defaulted, Classes::TAlignment Alignment = (Classes::TAlignment)(0x2));
extern PACKAGE void __fastcall DrawArrow(Graphics::TCanvas* ACanvas, int X, int Y, int Orientation);
extern PACKAGE void __fastcall MyDrawImgCaption(Graphics::TCanvas* acanvas, const Types::TRect &rc, Imglist::TCustomImageList* ImgList, int imgIndex, AnsiString text, bool enabled, bool defaulted, Classes::TAlignment Alignment = (Classes::TAlignment)(0x2));
extern PACKAGE Graphics::TBitmap* __fastcall GetDisableImg(Graphics::TBitmap* FOriginal);

}	/* namespace Winsubclass */
using namespace Winsubclass;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Winsubclass
