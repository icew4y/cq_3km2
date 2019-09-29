// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Toolctrlseh.pas' rev: 11.00

#ifndef ToolctrlsehHPP
#define ToolctrlsehHPP

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
#include <Contnrs.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Toolctrlseh
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TLocateTextOptionEh { ltoCaseInsensitiveEh, ltoAllFieldsEh, ltoMatchFormatEh, ltoIgnoteCurrentPosEh, ltoStopOnEscape };
#pragma option pop

typedef Set<TLocateTextOptionEh, ltoCaseInsensitiveEh, ltoStopOnEscape>  TLocateTextOptionsEh;

#pragma option push -b-
enum TLocateTextDirectionEh { ltdUpEh, ltdDownEh, ltdAllEh };
#pragma option pop

#pragma option push -b-
enum TLocateTextMatchingEh { ltmAnyPartEh, ltmWholeEh, ltmFromBegingEh };
#pragma option pop

#pragma option push -b-
enum TLocateTextTreeFindRangeEh { lttInAllNodesEh, lttInExpandedNodesEh, lttInCurrentLevelEh, lttInCurrentNodeEh };
#pragma option pop

__interface IMemTableDataFieldValueListEh;
typedef System::DelphiInterface<IMemTableDataFieldValueListEh> _di_IMemTableDataFieldValueListEh;
__interface  INTERFACE_UUID("{28F8194C-5FF3-42C4-87A6-8B3E06210FA6}") IMemTableDataFieldValueListEh  : public IInterface 
{
	
public:
	virtual Classes::TStrings* __fastcall GetValues(void) = 0 ;
};

__interface IComboEditEh;
typedef System::DelphiInterface<IComboEditEh> _di_IComboEditEh;
__interface  INTERFACE_UUID("{B64255B5-386A-4524-8BC7-7F49DDB410F4}") IComboEditEh  : public IInterface 
{
	
public:
	virtual void __fastcall CloseUp(bool Accept) = 0 ;
};

typedef DynamicArray<Db::TField* >  TFieldsArrEh;

typedef void __fastcall (__closure *TButtonClickEventEh)(System::TObject* Sender, bool &Handled);

typedef void __fastcall (__closure *TButtonDownEventEh)(System::TObject* Sender, bool TopButton, bool &AutoRepeat, bool &Handled);

typedef void __fastcall (__closure *TCloseUpEventEh)(System::TObject* Sender, bool Accept);

typedef void __fastcall (__closure *TAcceptEventEh)(System::TObject* Sender, bool &Accept);

typedef void __fastcall (__closure *TNotInListEventEh)(System::TObject* Sender, AnsiString NewText, bool &RecheckInList);

typedef void __fastcall (__closure *TUpdateDataEventEh)(System::TObject* Sender, bool &Handled);

class DELPHICLASS TBMListEh;
typedef int __fastcall (*TBMListSortCompare)(TBMListEh* List, Db::TDataSet* DataSet, int Index1, int Index2);

class PASCALIMPLEMENTATION TBMListEh : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString operator[](int Index) { return Items[Index]; }
	
private:
	AnsiString FCache;
	bool FCacheFind;
	int FCacheIndex;
	bool FLinkActive;
	int __fastcall GetCount(void);
	bool __fastcall GetCurrentRowSelected(void);
	AnsiString __fastcall GetItem(int Index);
	void __fastcall QuickSort(Db::TDataSet* DataSet, int L, int R, TBMListSortCompare SCompare);
	void __fastcall SetItem(int Index, AnsiString Item);
	
protected:
	Classes::TStringList* FList;
	int __fastcall Compare(const AnsiString Item1, const AnsiString Item2);
	AnsiString __fastcall CurrentRow();
	virtual Db::TDataSet* __fastcall GetDataSet(void);
	virtual void __fastcall Invalidate(void);
	void __fastcall LinkActive(bool Value);
	virtual void __fastcall RaiseBMListError(const AnsiString S);
	virtual void __fastcall SetCurrentRowSelected(bool Value);
	virtual void __fastcall DataChanged(System::TObject* Sender);
	virtual void __fastcall UpdateState(void);
	
public:
	__fastcall TBMListEh(void);
	__fastcall virtual ~TBMListEh(void);
	bool __fastcall Find(const AnsiString Item, int &Index);
	int __fastcall IndexOf(const AnsiString Item);
	bool __fastcall Refresh(void);
	void __fastcall AppendItem(AnsiString Item);
	virtual void __fastcall Clear(void);
	virtual void __fastcall CustomSort(Db::TDataSet* DataSet, TBMListSortCompare Compare);
	void __fastcall Delete(void);
	void __fastcall DeleteItem(int Index);
	void __fastcall InsertItem(int Index, AnsiString Item);
	void __fastcall SelectAll(void);
	__property int Count = {read=GetCount, nodefault};
	__property bool CurrentRowSelected = {read=GetCurrentRowSelected, write=SetCurrentRowSelected, nodefault};
	__property Db::TDataSet* DataSet = {read=GetDataSet};
	__property AnsiString Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


__interface IMemTableEh;
typedef System::DelphiInterface<IMemTableEh> _di_IMemTableEh;
__interface  INTERFACE_UUID("{A8C3C87A-E556-4BDB-B8A7-5B33497D1624}") IMemTableEh  : public IInterface 
{
	
public:
	virtual int __fastcall FetchRecords(int Count) = 0 ;
	virtual int __fastcall GetInstantReadCurRowNum(void) = 0 ;
	virtual bool __fastcall GetTreeNodeExpanded(int RowNum) = 0 /* overload */;
	virtual bool __fastcall GetTreeNodeExpanded(void) = 0 /* overload */;
	virtual bool __fastcall GetTreeNodeHasChields(void) = 0 ;
	virtual int __fastcall GetTreeNodeLevel(void) = 0 ;
	virtual int __fastcall GetPrevVisibleTreeNodeLevel(void) = 0 ;
	virtual int __fastcall GetNextVisibleTreeNodeLevel(void) = 0 ;
	virtual System::TObject* __fastcall GetRecObject(void) = 0 ;
	virtual int __fastcall InstantReadIndexOfBookmark(AnsiString Bookmark) = 0 ;
	virtual int __fastcall InstantReadRowCount(void) = 0 ;
	virtual bool __fastcall MemTableIsTreeList(void) = 0 ;
	virtual bool __fastcall ParentHasNextSibling(int ParenLevel) = 0 ;
	virtual bool __fastcall SetToRec(System::TObject* Rec) = 0 ;
	virtual int __fastcall SetTreeNodeExpanded(int RowNum, bool Value) = 0 ;
	virtual _di_IMemTableDataFieldValueListEh __fastcall GetFieldValueList(AnsiString FieldName) = 0 ;
	virtual bool __fastcall MoveRecords(TBMListEh* BookmarkList, int ToRecNo, int TreeLevel, bool CheckOnly) = 0 ;
	virtual void __fastcall InstantReadEnter(int RowNum) = 0 ;
	virtual void __fastcall InstantReadLeave(void) = 0 ;
	virtual void __fastcall RegisterEventReceiver(Classes::TComponent* AComponent) = 0 ;
	virtual void __fastcall UnregisterEventReceiver(Classes::TComponent* AComponent) = 0 ;
	__property int InstantReadCurRowNum = {read=GetInstantReadCurRowNum};
};

#pragma option push -b-
enum TMTViewEventTypeEh { mtRowInsertedEh, mtRowChangedEh, mtRowDeletedEh, mtRowMovedEh, mtViewDataChangedEh };
#pragma option pop

__interface IMTEventReceiverEh;
typedef System::DelphiInterface<IMTEventReceiverEh> _di_IMTEventReceiverEh;
__interface  INTERFACE_UUID("{60C6C1A2-A817-4043-885A-BDDC750587BD}") IMTEventReceiverEh  : public IInterface 
{
	
public:
	virtual void __fastcall MTViewDataEvent(int RowNum, TMTViewEventTypeEh Event, int OldRowNum) = 0 ;
};

#pragma option push -b-
enum TEditButtonStyleEh { ebsDropDownEh, ebsEllipsisEh, ebsGlyphEh, ebsUpDownEh, ebsPlusEh, ebsMinusEh, ebsAltDropDownEh, ebsAltUpDownEh };
#pragma option pop

class DELPHICLASS TEditButtonControlEh;
class PASCALIMPLEMENTATION TEditButtonControlEh : public Buttons::TSpeedButton 
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	bool FActive;
	bool FAlwaysDown;
	int FButtonNum;
	bool FNoDoClick;
	TButtonDownEventEh FOnDown;
	TEditButtonStyleEh FStyle;
	Extctrls::TTimer* FTimer;
	Extctrls::TTimer* __fastcall GetTimer(void);
	void __fastcall ResetTimer(unsigned Interval);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetAlwaysDown(const bool Value);
	void __fastcall SetStyle(const TEditButtonStyleEh Value);
	void __fastcall TimerEvent(System::TObject* Sender);
	void __fastcall UpdateDownButtonNum(int X, int Y);
	
protected:
	void __fastcall DrawButtonText(Graphics::TCanvas* Canvas, const AnsiString Caption, const Types::TRect &TextBounds, Buttons::TButtonState State, int BiDiFlags);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	__property Extctrls::TTimer* Timer = {read=GetTimer};
	
public:
	DYNAMIC void __fastcall Click(void);
	void __fastcall EditButtonDown(bool TopButton, bool &AutoRepeat);
	void __fastcall SetState(Buttons::TButtonState NewState, bool IsActive, int ButtonNum);
	void __fastcall SetWidthNoNotify(int AWidth);
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property bool AlwaysDown = {read=FAlwaysDown, write=SetAlwaysDown, nodefault};
	__property TEditButtonStyleEh Style = {read=FStyle, write=SetStyle, default=0};
	__property TButtonDownEventEh OnDown = {read=FOnDown, write=FOnDown};
public:
	#pragma option push -w-inl
	/* TSpeedButton.Create */ inline __fastcall virtual TEditButtonControlEh(Classes::TComponent* AOwner) : Buttons::TSpeedButton(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TEditButtonControlEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSpeedButtonEh;
class PASCALIMPLEMENTATION TSpeedButtonEh : public TEditButtonControlEh 
{
	typedef TEditButtonControlEh inherited;
	
__published:
	__property Active ;
	__property Style  = {default=0};
public:
	#pragma option push -w-inl
	/* TSpeedButton.Create */ inline __fastcall virtual TSpeedButtonEh(Classes::TComponent* AOwner) : TEditButtonControlEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TSpeedButtonEh(void) { }
	#pragma option pop
	
};


struct TEditButtonControlLineRec
{
	
public:
	Extctrls::TShape* ButtonLine;
	TEditButtonControlEh* EditButtonControl;
} ;

typedef DynamicArray<TEditButtonControlLineRec >  TEditButtonControlList;

class DELPHICLASS TEditButtonActionLinkEh;
class DELPHICLASS TEditButtonEh;
typedef TMetaClass* TEditButtonActionLinkEhClass;

class PASCALIMPLEMENTATION TEditButtonEh : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TEditButtonActionLinkEh* FActionLink;
	Menus::TPopupMenu* FDropdownMenu;
	Controls::TWinControl* FEditControl;
	bool FEnabled;
	Graphics::TBitmap* FGlyph;
	AnsiString FHint;
	int FNumGlyphs;
	TButtonClickEventEh FOnButtonClick;
	TButtonDownEventEh FOnButtonDown;
	Classes::TNotifyEvent FOnChanged;
	Classes::TShortCut FShortCut;
	TEditButtonStyleEh FStyle;
	bool FVisible;
	int FWidth;
	Classes::TBasicAction* __fastcall GetAction(void);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	bool __fastcall IsEnabledStored(void);
	bool __fastcall IsHintStored(void);
	bool __fastcall IsShortCutStored(void);
	bool __fastcall IsVisibleStored(void);
	void __fastcall DoActionChange(System::TObject* Sender);
	void __fastcall SetAction(const Classes::TBasicAction* Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetHint(const AnsiString Value);
	void __fastcall SetNumGlyphs(int Value);
	void __fastcall SetStyle(const TEditButtonStyleEh Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	virtual TEditButtonControlEh* __fastcall CreateEditButtonControl(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	HIDESBASE void __fastcall Changed(void)/* overload */;
	__property TEditButtonActionLinkEh* ActionLink = {read=FActionLink, write=FActionLink};
	
public:
	__fastcall virtual TEditButtonEh(Classes::TCollection* Collection)/* overload */;
	__fastcall TEditButtonEh(Controls::TWinControl* EditControl)/* overload */;
	__fastcall virtual ~TEditButtonEh(void);
	DYNAMIC TMetaClass* __fastcall GetActionLinkClass(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Click(System::TObject* Sender, bool &Handled);
	virtual void __fastcall InitiateAction(void);
	__property Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=FOnChanged};
	
__published:
	__property Classes::TBasicAction* Action = {read=GetAction, write=SetAction};
	__property Menus::TPopupMenu* DropdownMenu = {read=FDropdownMenu, write=FDropdownMenu};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, stored=IsEnabledStored, default=1};
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property AnsiString Hint = {read=FHint, write=SetHint, stored=IsHintStored};
	__property int NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, default=1};
	__property Classes::TShortCut ShortCut = {read=FShortCut, write=FShortCut, stored=IsShortCutStored, default=0};
	__property TEditButtonStyleEh Style = {read=FStyle, write=SetStyle, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, stored=IsVisibleStored, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=0};
	__property TButtonClickEventEh OnClick = {read=FOnButtonClick, write=FOnButtonClick};
	__property TButtonDownEventEh OnDown = {read=FOnButtonDown, write=FOnButtonDown};
};


class PASCALIMPLEMENTATION TEditButtonActionLinkEh : public Actnlist::TActionLink 
{
	typedef Actnlist::TActionLink inherited;
	
protected:
	TEditButtonEh* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsEnabledLinked(void);
	virtual bool __fastcall IsHintLinked(void);
	virtual bool __fastcall IsShortCutLinked(void);
	virtual bool __fastcall IsVisibleLinked(void);
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall SetHint(const AnsiString Value);
	virtual void __fastcall SetShortCut(Classes::TShortCut Value);
	virtual void __fastcall SetVisible(bool Value);
public:
	#pragma option push -w-inl
	/* TBasicActionLink.Create */ inline __fastcall virtual TEditButtonActionLinkEh(System::TObject* AClient) : Actnlist::TActionLink(AClient) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TEditButtonActionLinkEh(void) { }
	#pragma option pop
	
};


typedef TMetaClass* TEditButtonEhClass;

class DELPHICLASS TDropDownEditButtonEh;
class PASCALIMPLEMENTATION TDropDownEditButtonEh : public TEditButtonEh 
{
	typedef TEditButtonEh inherited;
	
public:
	__fastcall virtual TDropDownEditButtonEh(Classes::TCollection* Collection)/* overload */;
	__fastcall TDropDownEditButtonEh(Controls::TWinControl* EditControl)/* overload */;
	
__published:
	__property ShortCut  = {default=32808};
public:
	#pragma option push -w-inl
	/* TEditButtonEh.Destroy */ inline __fastcall virtual ~TDropDownEditButtonEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TVisibleEditButtonEh;
class PASCALIMPLEMENTATION TVisibleEditButtonEh : public TEditButtonEh 
{
	typedef TEditButtonEh inherited;
	
public:
	__fastcall virtual TVisibleEditButtonEh(Classes::TCollection* Collection)/* overload */;
	__fastcall TVisibleEditButtonEh(Controls::TWinControl* EditControl)/* overload */;
	
__published:
	__property ShortCut  = {default=32808};
	__property Visible  = {default=1};
public:
	#pragma option push -w-inl
	/* TEditButtonEh.Destroy */ inline __fastcall virtual ~TVisibleEditButtonEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TEditButtonsEh;
class PASCALIMPLEMENTATION TEditButtonsEh : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TEditButtonEh* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TNotifyEvent FOnChanged;
	TEditButtonEh* __fastcall GetEditButton(int Index);
	void __fastcall SetEditButton(int Index, TEditButtonEh* Value);
	
protected:
	Classes::TPersistent* FOwner;
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TEditButtonsEh(Classes::TPersistent* Owner, TMetaClass* EditButtonClass);
	HIDESBASE TEditButtonEh* __fastcall Add(void);
	__property TEditButtonEh* Items[int Index] = {read=GetEditButton, write=SetEditButton/*, default*/};
	__property Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=FOnChanged};
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TEditButtonsEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TSpecRowEh;
class PASCALIMPLEMENTATION TSpecRowEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TStrings* FCellsStrings;
	AnsiString FCellsText;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChanged;
	Classes::TPersistent* FOwner;
	bool FSelected;
	Classes::TShortCut FShortCut;
	bool FShowIfNotInKeyList;
	int FUpdateCount;
	Variant FValue;
	bool FVisible;
	AnsiString __fastcall GetCellText(int Index);
	Graphics::TColor __fastcall GetColor(void);
	Graphics::TFont* __fastcall GetFont(void);
	bool __fastcall IsColorStored(void);
	bool __fastcall IsFontStored(void);
	bool __fastcall IsValueStored(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetCellsText(const AnsiString Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetShowIfNotInKeyList(const bool Value);
	void __fastcall SetValue(const Variant &Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	bool FColorAssigned;
	bool FFontAssigned;
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall Changed(void);
	
public:
	__fastcall TSpecRowEh(Classes::TPersistent* Owner);
	__fastcall virtual ~TSpecRowEh(void);
	Graphics::TColor __fastcall DefaultColor(void);
	Graphics::TFont* __fastcall DefaultFont(void);
	bool __fastcall LocateKey(const Variant &KeyValue);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property AnsiString CellText[int Index] = {read=GetCellText};
	__property bool Selected = {read=FSelected, write=FSelected, nodefault};
	__property int UpdateCount = {read=FUpdateCount, nodefault};
	__property Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=FOnChanged};
	
__published:
	__property AnsiString CellsText = {read=FCellsText, write=SetCellsText};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, stored=IsColorStored, nodefault};
	__property Graphics::TFont* Font = {read=GetFont, write=SetFont, stored=IsFontStored};
	__property Classes::TShortCut ShortCut = {read=FShortCut, write=FShortCut, default=32814};
	__property bool ShowIfNotInKeyList = {read=FShowIfNotInKeyList, write=SetShowIfNotInKeyList, default=1};
	__property Variant Value = {read=FValue, write=SetValue, stored=IsValueStored};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
};


#pragma option push -b-
enum TSizeGripPostion { sgpTopLeft, sgpTopRight, sgpBottomRight, sgpBottomLeft };
#pragma option pop

#pragma option push -b-
enum TSizeGripChangePosition { sgcpToLeft, sgcpToRight, sgcpToTop, sgcpToBottom };
#pragma option pop

class DELPHICLASS TSizeGripEh;
class PASCALIMPLEMENTATION TSizeGripEh : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	#pragma pack(push,1)
	Types::TPoint FInitScreenMousePos;
	#pragma pack(pop)
	bool FInternalMove;
	#pragma pack(push,1)
	Types::TPoint FOldMouseMovePos;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TRect FParentRect;
	#pragma pack(pop)
	Classes::TNotifyEvent FParentResized;
	TSizeGripPostion FPosition;
	bool FTriangleWindow;
	bool __fastcall GetVisible(void);
	void __fastcall SetPosition(const TSizeGripPostion Value);
	void __fastcall SetTriangleWindow(const bool Value);
	HIDESBASE void __fastcall SetVisible(const bool Value);
	HIDESBASE MESSAGE void __fastcall WMMove(Messages::TWMMove &Message);
	
protected:
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall ParentResized(void);
	
public:
	__fastcall virtual TSizeGripEh(Classes::TComponent* AOwner);
	void __fastcall ChangePosition(TSizeGripChangePosition NewPosition);
	void __fastcall UpdatePosition(void);
	void __fastcall UpdateWindowRegion(void);
	__property TSizeGripPostion Position = {read=FPosition, write=SetPosition, default=2};
	__property bool TriangleWindow = {read=FTriangleWindow, write=SetTriangleWindow, default=1};
	__property bool Visible = {read=GetVisible, write=SetVisible, nodefault};
	__property Classes::TNotifyEvent OnParentResized = {read=FParentResized, write=FParentResized};
public:
	#pragma option push -w-inl
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TSizeGripEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TSizeGripEh(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TPopupMonthCalendarEh;
class PASCALIMPLEMENTATION TPopupMonthCalendarEh : public Comctrls::TMonthCalendar 
{
	typedef Comctrls::TMonthCalendar inherited;
	
private:
	int FBorderWidth;
	MESSAGE void __fastcall CMCloseUpEh(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Message);
	
protected:
	int FDownViewType;
	virtual bool __fastcall CanAutoSize(int &NewWidth, int &NewHeight);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual bool __fastcall MsgSetDateTime(const _SYSTEMTIME &Value);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawBorder(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall PostCloseUp(bool Accept);
	void __fastcall UpdateBorderWidth(void);
	
public:
	__fastcall virtual TPopupMonthCalendarEh(Classes::TComponent* AOwner);
	__property Color  = {default=-16777211};
	__property Ctl3D ;
public:
	#pragma option push -w-inl
	/* TCommonCalendar.Destroy */ inline __fastcall virtual ~TPopupMonthCalendarEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TPopupMonthCalendarEh(HWND ParentWindow) : Comctrls::TMonthCalendar(ParentWindow) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TListGetImageIndexEventEh)(System::TObject* Sender, int ItemIndex, int &ImageIndex);

class DELPHICLASS TPopupListboxEh;
class PASCALIMPLEMENTATION TPopupListboxEh : public Stdctrls::TCustomListBox 
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	int FBorderWidth;
	Imglist::TCustomImageList* FImageList;
	#pragma pack(push,1)
	Types::TPoint FMousePos;
	#pragma pack(pop)
	int FRowCount;
	AnsiString FSearchText;
	int FSearchTickCount;
	TSizeGripEh* FSizeGrip;
	bool FSizeGripResized;
	TListGetImageIndexEventEh FOnGetImageIndex;
	Classes::TStrings* FExtItems;
	HIDESBASE bool __fastcall CheckNewSize(int &NewWidth, int &NewHeight);
	int __fastcall GetBorderSize(void);
	Classes::TStrings* __fastcall GetExtItems(void);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMSetSizeGripChangePosition(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	void __fastcall SetExtItems(Classes::TStrings* Value);
	void __fastcall SetImageList(const Imglist::TCustomImageList* Value);
	void __fastcall SetRowCount(int Value);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TWMNCPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Messages::TWMWindowPosMsg &Message);
	
protected:
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DrawBorder(void);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall UpdateBorderWidth(void);
	virtual void __fastcall SelfOnGetData(Controls::TWinControl* Control, int Index, AnsiString &Data);
	
public:
	__fastcall virtual TPopupListboxEh(Classes::TComponent* Owner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC bool __fastcall CanFocus(void);
	int __fastcall GetTextHeight(void);
	__property Color  = {default=-16777211};
	__property Ctl3D ;
	__property Font ;
	__property Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property IntegralHeight  = {default=0};
	__property ItemHeight ;
	__property int RowCount = {read=FRowCount, write=SetRowCount, nodefault};
	__property Classes::TStrings* ExtItems = {read=GetExtItems, write=SetExtItems};
	__property TSizeGripEh* SizeGrip = {read=FSizeGrip};
	__property bool SizeGripResized = {read=FSizeGripResized, write=FSizeGripResized, nodefault};
	__property OnMouseUp ;
	__property TListGetImageIndexEventEh OnGetImageIndex = {read=FOnGetImageIndex, write=FOnGetImageIndex};
public:
	#pragma option push -w-inl
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TPopupListboxEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TPopupListboxEh(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TFilterMRUItemEventEh)(System::TObject* Sender, bool &Accept);

typedef void __fastcall (__closure *TSetDropDownEventEh)(System::TObject* Sender);

typedef void __fastcall (__closure *TSetCloseUpEventEh)(System::TObject* Sender, bool Accept);

class DELPHICLASS TMRUListEh;
class PASCALIMPLEMENTATION TMRUListEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FActive;
	bool FAutoAdd;
	bool FCaseSensitive;
	Classes::TStrings* FItems;
	int FLimit;
	Classes::TNotifyEvent FOnActiveChanged;
	TFilterMRUItemEventEh FOnFilterItem;
	TSetCloseUpEventEh FOnSetCloseUpEvent;
	TSetDropDownEventEh FOnSetDropDown;
	Classes::TPersistent* FOwner;
	int FRows;
	int FWidth;
	bool FCancelIfKeyInQueue;
	void __fastcall SetActive(const bool Value);
	void __fastcall SetItems(const Classes::TStrings* Value);
	void __fastcall SetLimit(const int Value);
	void __fastcall SetRows(const int Value);
	
protected:
	bool FDroppedDown;
	void __fastcall UpdateLimit(void);
	
public:
	__fastcall TMRUListEh(Classes::TPersistent* AOwner);
	__fastcall virtual ~TMRUListEh(void);
	void __fastcall Add(AnsiString s);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall CloseUp(bool Accept);
	virtual void __fastcall DropDown(void);
	bool __fastcall FilterItemsTo(Classes::TStrings* FilteredItems, AnsiString MaskText);
	__property bool DroppedDown = {read=FDroppedDown, write=FDroppedDown, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property Classes::TNotifyEvent OnActiveChanged = {read=FOnActiveChanged, write=FOnActiveChanged};
	__property TSetCloseUpEventEh OnSetCloseUp = {read=FOnSetCloseUpEvent, write=FOnSetCloseUpEvent};
	__property TSetDropDownEventEh OnSetDropDown = {read=FOnSetDropDown, write=FOnSetDropDown};
	__property TFilterMRUItemEventEh OnFilterItem = {read=FOnFilterItem, write=FOnFilterItem};
	__property bool CancelIfKeyInQueue = {read=FCancelIfKeyInQueue, write=FCancelIfKeyInQueue, default=1};
	
__published:
	__property bool AutoAdd = {read=FAutoAdd, write=FAutoAdd, default=1};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property bool CaseSensitive = {read=FCaseSensitive, write=FCaseSensitive, default=0};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property int Limit = {read=FLimit, write=SetLimit, default=100};
	__property int Rows = {read=FRows, write=SetRows, default=7};
};


class DELPHICLASS TMRUListboxEh;
class PASCALIMPLEMENTATION TMRUListboxEh : public TPopupListboxEh 
{
	typedef TPopupListboxEh inherited;
	
private:
	Stdctrls::TScrollBar* FScrollBar;
	bool FScrollBarLockMove;
	HIDESBASE MESSAGE void __fastcall CMChanged(Controls::TCMChanged &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Controls::TCMMouseWheel &Message);
	HIDESBASE MESSAGE void __fastcall CMSetSizeGripChangePosition(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall ScrollBarScrolled(System::TObject* Sender, Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
	void __fastcall ScrollBarWindowProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TMRUListboxEh(Classes::TComponent* Owner);
	void __fastcall UpdateScrollBar(void);
	void __fastcall UpdateScrollBarPos(void);
	__property ParentCtl3D  = {default=1};
	__property Stdctrls::TScrollBar* ScrollBar = {read=FScrollBar};
	__property Sorted  = {default=0};
	__property OnMouseUp ;
public:
	#pragma option push -w-inl
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TMRUListboxEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TMRUListboxEh(HWND ParentWindow) : TPopupListboxEh(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TStringListEh;
class PASCALIMPLEMENTATION TStringListEh : public Classes::TStringList 
{
	typedef Classes::TStringList inherited;
	
public:
	#pragma option push -w-inl
	/* TStringList.Destroy */ inline __fastcall virtual ~TStringListEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TStringListEh(void) : Classes::TStringList() { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TDataEventEh)(Db::TDataEvent Event, int Info);

class DELPHICLASS TDataLinkEh;
class PASCALIMPLEMENTATION TDataLinkEh : public Db::TDataLink 
{
	typedef Db::TDataLink inherited;
	
private:
	TDataEventEh FOnDataEvent;
	
protected:
	virtual void __fastcall DataEvent(Db::TDataEvent Event, int Info);
	
public:
	__property TDataEventEh OnDataEvent = {read=FOnDataEvent, write=FOnDataEvent};
public:
	#pragma option push -w-inl
	/* TDataLink.Create */ inline __fastcall TDataLinkEh(void) : Db::TDataLink() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TDataLink.Destroy */ inline __fastcall virtual ~TDataLinkEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TDatasetFieldValueListEh;
class PASCALIMPLEMENTATION TDatasetFieldValueListEh : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
private:
	Classes::TStringList* FValues;
	bool FDataObsoleted;
	AnsiString FFieldName;
	TDataLinkEh* FDataLink;
	Db::TDataSource* FDataSource;
	Db::TDataSet* __fastcall GetDataSet(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	Classes::TStrings* __fastcall GetValues(void);
	void __fastcall SetDataSet(const Db::TDataSet* Value);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall SetFieldName(const AnsiString Value);
	
protected:
	void __fastcall RefreshValues(void);
	virtual void __fastcall DataSetEvent(Db::TDataEvent Event, int Info);
	
public:
	__fastcall TDatasetFieldValueListEh(void);
	__fastcall virtual ~TDatasetFieldValueListEh(void);
	__property AnsiString FieldName = {read=FFieldName, write=SetFieldName};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property Db::TDataSet* DataSet = {read=GetDataSet, write=SetDataSet};
	__property Classes::TStrings* Values = {read=GetValues};
private:
	void *__IMemTableDataFieldValueListEh;	/* Toolctrlseh::IMemTableDataFieldValueListEh */
	
public:
	operator IMemTableDataFieldValueListEh*(void) { return (IMemTableDataFieldValueListEh*)&__IMemTableDataFieldValueListEh; }
	
};


class DELPHICLASS TDesignControlerEh;
class PASCALIMPLEMENTATION TDesignControlerEh : public System::TInterfacedObject 
{
	typedef System::TInterfacedObject inherited;
	
public:
	virtual bool __fastcall IsDesignHitTest(Classes::TPersistent* Control, int X, int Y, Classes::TShiftState AShift) = 0 ;
	virtual bool __fastcall ControlIsObjInspSelected(Classes::TPersistent* Control) = 0 ;
	virtual Classes::TPersistent* __fastcall GetObjInspSelectedControl(Classes::TPersistent* BaseControl) = 0 ;
	virtual TMetaClass* __fastcall GetDesignInfoItemClass(void) = 0 ;
	virtual Graphics::TBitmap* __fastcall GetSelectComponentCornerImage(void) = 0 ;
	virtual void __fastcall DesignMouseDown(Classes::TPersistent* Control, int X, int Y, Classes::TShiftState AShift) = 0 ;
	virtual void __fastcall RegisterChangeSelectedNotification(Classes::TPersistent* Control) = 0 ;
	virtual void __fastcall UnregisterChangeSelectedNotification(Classes::TPersistent* Control) = 0 ;
	virtual void __fastcall KeyProperyModified(Controls::TControl* Control) = 0 ;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TDesignControlerEh(void) : System::TInterfacedObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDesignControlerEh(void) { }
	#pragma option pop
	
};


typedef bool __fastcall (__closure *TLocateTextEventEh)(System::TObject* Sender, const AnsiString FieldName, const AnsiString Text, TLocateTextOptionsEh Options, TLocateTextDirectionEh Direction, TLocateTextMatchingEh Matching, TLocateTextTreeFindRangeEh TreeFindRange);

#pragma option push -b-
enum TDrawButtonControlStyleEh { bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh, bcsCheckboxEh, bcsPlusEh, bcsMinusEh, bcsAltDropDownEh, bcsAltUpDownEh };
#pragma option pop

#pragma option push -b-
enum TTreeElementEh { tehMinusUpDown, tehMinusUp, tehMinusDown, tehMinus, tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus, tehCrossUpDown, tehCrossUp, tehCrossDown, tehVLine };
#pragma option pop

typedef Set<Db::TFieldType, ftUnknown, ftOraInterval>  TFieldTypes;

//-- var, const, procedure ---------------------------------------------------
static const Word CM_IGNOREEDITDOWN = 0x466;
extern PACKAGE AnsiString EhLibRegKey;
static const Word cm_SetSizeGripChangePosition = 0x464;
static const Word CM_CLOSEUPEH = 0x465;
extern PACKAGE int FlatButtonWidth;
extern PACKAGE TFieldTypes ftNumberFieldTypes;
extern PACKAGE bool UseButtonsBitmapCache;
extern PACKAGE int DefaultCheckBoxWidth;
extern PACKAGE int DefaultCheckBoxHeight;
extern PACKAGE void __fastcall BroadcastPerformMessageFor(Classes::TComponent* Owner, TMetaClass* ForClass, unsigned Msg, int WParam, int LParam);
extern PACKAGE bool __fastcall IsDoubleClickMessage(const Types::TPoint &OldPos, const Types::TPoint &NewPos, int Interval);
extern PACKAGE Types::TRect __fastcall AdjustCheckBoxRect(const Types::TRect &ClientRect, Classes::TAlignment Alignment, Stdctrls::TTextLayout Layout);
extern PACKAGE void __fastcall ClearButtonsBitmapCache(void);
extern PACKAGE void __fastcall PaintButtonControlEh(Graphics::TCanvas* Canvas, const Types::TRect &ARect, Graphics::TColor ParentColor, TDrawButtonControlStyleEh Style, int DownButton, bool Flat, bool Active, bool Enabled, Stdctrls::TCheckBoxState State);
extern PACKAGE int __fastcall GetDefaultFlatButtonWidth(void);
extern PACKAGE int __fastcall DefaultEditButtonHeight(int EditButtonWidth, bool Flat);
extern PACKAGE bool __fastcall VarEquals(const Variant &V1, const Variant &V2);
extern PACKAGE Variants::TVariantRelationship __fastcall DBVarCompareValue(const Variant &A, const Variant &B);
extern PACKAGE void __fastcall DrawImage(HDC DC, const Types::TRect &ARect, Imglist::TCustomImageList* Images, int ImageIndex, bool Selected);
extern PACKAGE Types::TPoint __fastcall AlignDropDownWindowRect(const Types::TRect &MasterAbsRect, Controls::TWinControl* DropDownWin, Dbctrls::TDropDownAlign Align);
extern PACKAGE Types::TPoint __fastcall AlignDropDownWindow(Controls::TWinControl* MasterWin, Controls::TWinControl* DropDownWin, Dbctrls::TDropDownAlign Align);
extern PACKAGE void __fastcall DrawTreeElement(Graphics::TCanvas* Canvas, const Types::TRect &ARect, TTreeElementEh TreeElement, bool BackDot, double ScaleX, double ScaleY, bool RightToLeft);
extern PACKAGE void __fastcall GetFieldsProperty(Classes::TList* List, Db::TDataSet* DataSet, Classes::TComponent* Control, const AnsiString FieldNames)/* overload */;
extern PACKAGE TFieldsArrEh __fastcall GetFieldsProperty(Db::TDataSet* DataSet, Classes::TComponent* Control, const AnsiString FieldNames)/* overload */;
extern PACKAGE void __fastcall DataSetSetFieldValues(Db::TDataSet* DataSet, AnsiString Fields, const Variant &Value);
extern PACKAGE bool __fastcall KillMouseUp(Controls::TControl* Control, const Types::TRect &Area)/* overload */;
extern PACKAGE bool __fastcall KillMouseUp(Controls::TControl* Control)/* overload */;
extern PACKAGE void __fastcall FillGradientEh(Graphics::TCanvas* Canvas, const Types::TRect &ARect, Graphics::TColor FromColor, Graphics::TColor ToColor)/* overload */;
extern PACKAGE void __fastcall FillGradientEh(Graphics::TCanvas* Canvas, const Types::TPoint &TopLeft, Types::TPoint * Points, const int Points_Size, Graphics::TColor FromColor, Graphics::TColor ToColor)/* overload */;
extern PACKAGE Graphics::TColor __fastcall ApproachToColorEh(Graphics::TColor FromColor, Graphics::TColor ToColor, int Percent);
extern PACKAGE bool __fastcall ThemesEnabled(void);

}	/* namespace Toolctrlseh */
using namespace Toolctrlseh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Toolctrlseh
