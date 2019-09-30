// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Memtreeeh.pas' rev: 11.00

#ifndef MemtreeehHPP
#define MemtreeehHPP

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
#include <Comctrls.hpp>	// Pascal unit
#include <Toolctrlseh.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Memtreeeh
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TNodeAttachModeEh { naAddEh, naAddFirstEh, naAddChildEh, naAddChildFirstEh, naInsertEh };
#pragma option pop

#pragma option push -b-
enum TAddModeEh { taAddFirstEh, taAddEh, taInsertEh };
#pragma option pop

class DELPHICLASS TBaseTreeNodeEh;
typedef int __fastcall (__closure *TCompareNodesEh)(TBaseTreeNodeEh* Node1, TBaseTreeNodeEh* Node2, System::TObject* ParamSort);

typedef void __fastcall (__closure *TTreeNodeNotifyEvent)(TBaseTreeNodeEh* Sender);

typedef bool __fastcall (__closure *TTreeNodeNotifyResultEvent)(TBaseTreeNodeEh* Sender);

class DELPHICLASS TTreeListEh;
typedef TMetaClass* TTreeNodeClassEh;

class PASCALIMPLEMENTATION TTreeListEh : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	TMetaClass* FItemClass;
	TTreeNodeNotifyEvent FOnExpandedChanged;
	TTreeNodeNotifyResultEvent FOnExpandedChanging;
	int FMaxLevel;
	
protected:
	TBaseTreeNodeEh* FRoot;
	bool __fastcall IsHasChildren(TBaseTreeNodeEh* Node = (TBaseTreeNodeEh*)(0x0));
	virtual bool __fastcall ExpandedChanging(TBaseTreeNodeEh* Node);
	virtual void __fastcall ExpandedChanged(TBaseTreeNodeEh* Node);
	void __fastcall QuickSort(int L, int R, TCompareNodesEh Compare);
	__property int MaxLevel = {read=FMaxLevel, write=FMaxLevel, default=1000};
	
public:
	__fastcall TTreeListEh(TMetaClass* ItemClass);
	__fastcall virtual ~TTreeListEh(void);
	TBaseTreeNodeEh* __fastcall AddChild(const AnsiString Text, TBaseTreeNodeEh* Parent, System::TObject* Data);
	virtual int __fastcall CompareTreeNodes(TBaseTreeNodeEh* Rec1, TBaseTreeNodeEh* Rec2, System::TObject* ParamSort);
	int __fastcall CountChildren(TBaseTreeNodeEh* Node = (TBaseTreeNodeEh*)(0x0));
	TBaseTreeNodeEh* __fastcall GetFirst(void);
	TBaseTreeNodeEh* __fastcall GetFirstChild(TBaseTreeNodeEh* Node);
	TBaseTreeNodeEh* __fastcall GetFirstVisible(void);
	TBaseTreeNodeEh* __fastcall GetLast(TBaseTreeNodeEh* Node = (TBaseTreeNodeEh*)(0x0));
	TBaseTreeNodeEh* __fastcall GetLastChild(TBaseTreeNodeEh* Node);
	TBaseTreeNodeEh* __fastcall GetNext(TBaseTreeNodeEh* Node);
	TBaseTreeNodeEh* __fastcall GetNextSibling(TBaseTreeNodeEh* Node);
	TBaseTreeNodeEh* __fastcall GetNextVisibleSibling(TBaseTreeNodeEh* Node);
	TBaseTreeNodeEh* __fastcall GetNextVisible(TBaseTreeNodeEh* Node, bool ConsiderCollapsed);
	TBaseTreeNodeEh* __fastcall GetNode(TBaseTreeNodeEh* StartNode, System::TObject* Data);
	TBaseTreeNodeEh* __fastcall GetParentAtLevel(TBaseTreeNodeEh* Node, int ParentLevel);
	TBaseTreeNodeEh* __fastcall GetParentVisible(TBaseTreeNodeEh* Node, bool ConsiderCollapsed);
	bool __fastcall GetPathVisible(TBaseTreeNodeEh* Node, bool ConsiderCollapsed);
	TBaseTreeNodeEh* __fastcall GetPrevious(TBaseTreeNodeEh* Node);
	TBaseTreeNodeEh* __fastcall GetPrevSibling(TBaseTreeNodeEh* Node);
	TBaseTreeNodeEh* __fastcall GetPrevVisibleSibling(TBaseTreeNodeEh* Node);
	void __fastcall AddNode(TBaseTreeNodeEh* Node, TBaseTreeNodeEh* Destination, TNodeAttachModeEh Mode, bool ReIndex);
	void __fastcall BuildChildrenIndex(TBaseTreeNodeEh* Node = (TBaseTreeNodeEh*)(0x0), bool Recurse = true);
	void __fastcall Clear(void);
	void __fastcall Collapse(TBaseTreeNodeEh* Node, bool Recurse);
	void __fastcall DeleteChildren(TBaseTreeNodeEh* Node);
	void __fastcall DeleteNode(TBaseTreeNodeEh* Node, bool ReIndex);
	void __fastcall Expand(TBaseTreeNodeEh* Node, bool Recurse);
	void __fastcall ExportToTreeView(Comctrls::TTreeView* TreeView, TBaseTreeNodeEh* Node, Comctrls::TTreeNode* NodeTree, bool AddChild);
	virtual void __fastcall MoveTo(TBaseTreeNodeEh* Node, TBaseTreeNodeEh* Destination, TNodeAttachModeEh Mode, bool ReIndex);
	virtual void __fastcall SortData(TCompareNodesEh CompareProg, System::TObject* ParamSort, bool ARecurse = true);
	__property TBaseTreeNodeEh* Root = {read=FRoot, write=FRoot};
	__property TTreeNodeNotifyEvent OnExpandedChanged = {read=FOnExpandedChanged, write=FOnExpandedChanged};
	__property TTreeNodeNotifyResultEvent OnExpandedChanging = {read=FOnExpandedChanging, write=FOnExpandedChanging};
};


class PASCALIMPLEMENTATION TBaseTreeNodeEh : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	TBaseTreeNodeEh* operator[](int Index) { return Items[Index]; }
	
private:
	TTreeListEh* FOwner;
	AnsiString FText;
	System::TObject* FData;
	bool FExpanded;
	bool FHasChildren;
	int FIndex;
	Classes::TList* FItems;
	Classes::TList* FVisibleItems;
	int FLevel;
	TBaseTreeNodeEh* FParent;
	bool FVisible;
	int FVisibleCount;
	int FVisibleIndex;
	void __fastcall SetExpanded(const bool Value);
	void __fastcall SetVisible(const bool Value);
	TBaseTreeNodeEh* __fastcall GetVisibleItem(const int Index);
	
protected:
	virtual bool __fastcall ExpandedChanging(void);
	int __fastcall GetCount(void);
	virtual TBaseTreeNodeEh* __fastcall GetItem(const int Index);
	int __fastcall GetVisibleCount(void);
	virtual bool __fastcall VisibleChanging(void);
	Classes::TList* __fastcall VisibleItems(void);
	int __fastcall Add(TBaseTreeNodeEh* Item);
	bool __fastcall HasParentOf(TBaseTreeNodeEh* Node);
	void __fastcall Delete(int Index);
	virtual void __fastcall Clear(void);
	void __fastcall Insert(int Index, TBaseTreeNodeEh* Item);
	virtual void __fastcall ChildVisibleChanged(TBaseTreeNodeEh* ChildNode);
	void __fastcall Exchange(int Index1, int Index2);
	virtual void __fastcall ExpandedChanged(void);
	void __fastcall QuickSort(int L, int R, TCompareNodesEh Compare, System::TObject* ParamSort);
	void __fastcall SetLevel(int ALevel);
	virtual void __fastcall VisibleChanged(void);
	virtual void __fastcall BuildVisibleItems(void);
	void __fastcall SortData(TCompareNodesEh CompareProg, System::TObject* ParamSort, bool ARecurse = true);
	__property int Count = {read=GetCount, nodefault};
	__property System::TObject* Data = {read=FData, write=FData};
	__property bool Expanded = {read=FExpanded, write=SetExpanded, nodefault};
	__property bool HasChildren = {read=FHasChildren, write=FHasChildren, nodefault};
	__property int Index = {read=FIndex, nodefault};
	__property TBaseTreeNodeEh* Items[int Index] = {read=GetItem/*, default*/};
	__property int Level = {read=FLevel, nodefault};
	__property TTreeListEh* Owner = {read=FOwner};
	__property TBaseTreeNodeEh* Parent = {read=FParent, write=FParent};
	__property AnsiString Text = {read=FText, write=FText};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int VisibleCount = {read=GetVisibleCount, nodefault};
	__property TBaseTreeNodeEh* VisibleItem[int Index] = {read=GetVisibleItem};
	__property int VisibleIndex = {read=FVisibleIndex, nodefault};
	
public:
	__fastcall virtual TBaseTreeNodeEh(void);
	__fastcall virtual ~TBaseTreeNodeEh(void);
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Memtreeeh */
using namespace Memtreeeh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Memtreeeh
