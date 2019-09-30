// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gridseh.pas' rev: 11.00

#ifndef GridsehHPP
#define GridsehHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gridseh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EInvalidGridOperationEh;
class PASCALIMPLEMENTATION EInvalidGridOperationEh : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EInvalidGridOperationEh(const AnsiString Msg) : Sysutils::Exception(Msg) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EInvalidGridOperationEh(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EInvalidGridOperationEh(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EInvalidGridOperationEh(int Ident, System::TVarRec const * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EInvalidGridOperationEh(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EInvalidGridOperationEh(const AnsiString Msg, System::TVarRec const * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EInvalidGridOperationEh(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EInvalidGridOperationEh(System::PResStringRec ResStringRec, System::TVarRec const * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EInvalidGridOperationEh(void) { }
	#pragma option pop
	
};


typedef DynamicArray<int >  TIntegerArray;

typedef DynamicArray<Types::TPoint >  TPointArray;

typedef DynamicArray<unsigned >  TDWORDArray;

typedef int __fastcall (__closure *TGetExtentsFuncEh)(int Index);

struct TGridAxisDrawInfoEh
{
	
public:
	int EffectiveLineWidth;
	int FixedBoundary;
	int GridBoundary;
	int GridExtent;
	int LastFullVisibleCell;
	int FullVisBoundary;
	int FixedCellCount;
	int FirstGridCell;
	int GridCellCount;
	TGetExtentsFuncEh GetExtent;
	int NoFrozenBoundary;
	int FrozenCelCount;
	int ContraCelCount;
	int ContraExtent;
	int FullGridExtent;
	int FullGridBoundary;
	int FullGridCellCount;
	int DataOffset;
	int OutViewVisCellStart;
	int VirtualGridBoundary;
} ;

struct TGridDrawInfoEh
{
	
public:
	TGridAxisDrawInfoEh Horz;
	TGridAxisDrawInfoEh Vert;
} ;

#pragma pack(push,4)
struct TDrawLinesInfoEh
{
	
public:
	DynamicArray<Types::TPoint >  PointsList;
	DynamicArray<unsigned >  StrokeList;
	int MaxStroke;
	int LastCol;
	int LastRow;
	Graphics::TColor VertColor;
	Graphics::TColor HorzColor;
} ;
#pragma pack(pop)

#pragma option push -b-
enum TGridState { gsNormal, gsSelecting, gsRowSizing, gsColSizing, gsRowMoving, gsColMoving };
#pragma option pop

typedef TGridState TGridMovement;

#pragma pack(push,4)
struct TRCRRec
{
	
public:
	int Result;
	HRGN RectRgn;
} ;
#pragma pack(pop)

class DELPHICLASS TInplaceEdit;
class DELPHICLASS TCustomGridEh;
#pragma pack(push,4)
struct TGridCoord
{
	
public:
	int X;
	int Y;
} ;
#pragma pack(pop)

class DELPHICLASS TGridLineColorsEh;
class PASCALIMPLEMENTATION TGridLineColorsEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomGridEh* FGrid;
	Graphics::TColor FBrightColor;
	Graphics::TColor FDarkColor;
	Graphics::TColor FDataHorzColor;
	Graphics::TColor FDataVertColor;
	Graphics::TColor FFixedHorzColor;
	Graphics::TColor FFixedVertColor;
	Graphics::TColor FHorzAreaContraBorderColor;
	Graphics::TColor FHorzAreaContraHorzColor;
	Graphics::TColor FHorzAreaContraVertColor;
	Graphics::TColor FHorzAreaFrozenBorderColor;
	Graphics::TColor FHorzAreaFrozenHorzColor;
	Graphics::TColor FHorzAreaFrozenVertColor;
	Graphics::TColor FVertAreaContraBorderColor;
	Graphics::TColor FVertAreaContraHorzColor;
	Graphics::TColor FVertAreaContraVertColor;
	Graphics::TColor FVertAreaFrozenBorderColor;
	Graphics::TColor FVertAreaFrozenHorzColor;
	Graphics::TColor FVertAreaFrozenVertColor;
	
protected:
	__property TCustomGridEh* Grid = {read=FGrid};
	
public:
	__fastcall TGridLineColorsEh(TCustomGridEh* AGrid);
	virtual Graphics::TColor __fastcall GetDarkColor(void);
	virtual Graphics::TColor __fastcall GetBrightColor(void);
	virtual Graphics::TColor __fastcall GetCellColor(int ACol, int ARow);
	virtual Graphics::TColor __fastcall GetLeftBorderCellColor(int ACol, int ARow);
	virtual Graphics::TColor __fastcall GetTopBorderCellColor(int ACol, int ARow);
	virtual Graphics::TColor __fastcall GetRightBorderCellColor(int ACol, int ARow);
	virtual Graphics::TColor __fastcall GetDownBorderCellColor(int ACol, int ARow);
	virtual Graphics::TColor __fastcall GetFixedVertColor(void);
	virtual Graphics::TColor __fastcall GetFixedHorzColor(void);
	virtual Graphics::TColor __fastcall GetVertAreaFrozenVertColor(void);
	virtual Graphics::TColor __fastcall GetVertAreaFrozenHorzColor(void);
	virtual Graphics::TColor __fastcall GetHorzAreaFrozenVertColor(void);
	virtual Graphics::TColor __fastcall GetHorzAreaFrozenHorzColor(void);
	virtual Graphics::TColor __fastcall GetVertAreaFrozenBorderColor(void);
	virtual Graphics::TColor __fastcall GetHorzAreaFrozenBorderColor(void);
	virtual Graphics::TColor __fastcall GetDataVertColor(void);
	virtual Graphics::TColor __fastcall GetDataHorzColor(void);
	virtual Graphics::TColor __fastcall GetVertAreaContraVertColor(void);
	virtual Graphics::TColor __fastcall GetVertAreaContraHorzColor(void);
	virtual Graphics::TColor __fastcall GetHorzAreaContraVertColor(void);
	virtual Graphics::TColor __fastcall GetHorzAreaContraHorzColor(void);
	virtual Graphics::TColor __fastcall GetVertAreaContraBorderColor(void);
	virtual Graphics::TColor __fastcall GetHorzAreaContraBorderColor(void);
	__property Graphics::TColor DarkColor = {read=FDarkColor, write=FDarkColor, default=536870912};
	__property Graphics::TColor BrightColor = {read=FBrightColor, write=FBrightColor, default=536870912};
	__property Graphics::TColor FixedVertColor = {read=FFixedVertColor, write=FFixedVertColor, default=536870912};
	__property Graphics::TColor FixedHorzColor = {read=FFixedHorzColor, write=FFixedHorzColor, default=536870912};
	__property Graphics::TColor VertAreaFrozenVertColor = {read=FVertAreaFrozenVertColor, write=FVertAreaFrozenVertColor, default=536870912};
	__property Graphics::TColor VertAreaFrozenHorzColor = {read=FVertAreaFrozenHorzColor, write=FVertAreaFrozenHorzColor, default=536870912};
	__property Graphics::TColor HorzAreaFrozenVertColor = {read=FHorzAreaFrozenVertColor, write=FHorzAreaFrozenVertColor, default=536870912};
	__property Graphics::TColor HorzAreaFrozenHorzColor = {read=FHorzAreaFrozenHorzColor, write=FHorzAreaFrozenHorzColor, default=536870912};
	__property Graphics::TColor VertAreaFrozenBorderColor = {read=FVertAreaFrozenBorderColor, write=FVertAreaFrozenBorderColor, default=536870912};
	__property Graphics::TColor HorzAreaFrozenBorderColor = {read=FHorzAreaFrozenBorderColor, write=FHorzAreaFrozenBorderColor, default=536870912};
	__property Graphics::TColor DataVertColor = {read=FDataVertColor, write=FDataVertColor, default=536870912};
	__property Graphics::TColor DataHorzColor = {read=FDataHorzColor, write=FDataHorzColor, default=536870912};
	__property Graphics::TColor VertAreaContraVertColor = {read=FVertAreaContraVertColor, write=FVertAreaContraVertColor, default=536870912};
	__property Graphics::TColor VertAreaContraHorzColor = {read=FVertAreaContraHorzColor, write=FVertAreaContraHorzColor, default=536870912};
	__property Graphics::TColor HorzAreaContraVertColor = {read=FHorzAreaContraVertColor, write=FHorzAreaContraVertColor, default=536870912};
	__property Graphics::TColor HorzAreaContraHorzColor = {read=FHorzAreaContraHorzColor, write=FHorzAreaContraHorzColor, default=536870912};
	__property Graphics::TColor VertAreaContraBorderColor = {read=FVertAreaContraBorderColor, write=FVertAreaContraBorderColor, default=536870912};
	__property Graphics::TColor HorzAreaContraBorderColor = {read=FHorzAreaContraBorderColor, write=FHorzAreaContraBorderColor, default=536870912};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGridLineColorsEh(void) { }
	#pragma option pop
	
};


typedef void __fastcall (__closure *TGridEhCellMouseEvent)(TCustomGridEh* Grid, const TGridCoord &Cell, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);

#pragma option push -b-
enum TGridOption { goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving, goColMoving, goEditing, goTabs, goRowSelect, goAlwaysShowEditor, goThumbTracking, goExtendVertLines };
#pragma option pop

typedef Set<TGridOption, goFixedVertLine, goExtendVertLines>  TGridOptions;

#pragma option push -b-
enum TEditStyle { esSimple, esEllipsis, esPickList };
#pragma option pop

#pragma option push -b-
enum GridsEh__4 { gdSelected, gdFocused, gdFixed, gdHotTrack, gdCurrent };
#pragma option pop

typedef Set<GridsEh__4, gdSelected, gdCurrent>  TGridDrawState;

#pragma option push -b-
enum GridsEh__5 { sdLeft, sdRight, sdUp, sdDown };
#pragma option pop

typedef Set<GridsEh__5, sdLeft, sdDown>  TGridScrollDirection;

class PASCALIMPLEMENTATION TCustomGridEh : public Controls::TCustomControl 
{
	typedef Controls::TCustomControl inherited;
	
private:
	TGridCoord FAnchor;
	Forms::TFormBorderStyle FBorderStyle;
	bool FCanEditModify;
	int FColCount;
	int FColOffset;
	DynamicArray<int >  FColWidths;
	int FContraColCount;
	int FContraRowCount;
	TGridCoord FCurrent;
	int FDefaultColWidth;
	bool FDefaultDrawing;
	int FDefaultRowHeight;
	bool FEditorMode;
	Graphics::TColor FFixedColor;
	int FFixedCols;
	int FFixedRows;
	bool FFlat;
	int FFrozenColCount;
	int FFrozenRowCount;
	TGridLineColorsEh* FGridLineColors;
	int FGridLineWidth;
	#pragma pack(push,1)
	Types::TPoint FHitTest;
	#pragma pack(pop)
	int FInplaceCol;
	int FInplaceRow;
	TInplaceEdit* FInplaceEdit;
	int FMoveIndex;
	int FMovePos;
	TGridEhCellMouseEvent FOnCellMouseClick;
	TGridOptions FOptions;
	int FRowCount;
	DynamicArray<int >  FRowHeights;
	Stdctrls::TScrollStyle FScrollBars;
	DynamicArray<int >  FTabStops;
	TGridCoord FTopLeft;
	TGridCoord __fastcall CalcMaxTopLeft(const TGridCoord &Coord, const TGridDrawInfoEh &DrawInfo);
	tagSIZE __fastcall CalcMinLeftTopNonVisiblePart(const TGridCoord &MaxCell, const TGridDrawInfoEh &DrawInfo);
	int __fastcall GetColWidths(int Index);
	int __fastcall GetFullColCount(void);
	int __fastcall GetFullRowCount(void);
	int __fastcall GetRowHeights(int Index);
	Types::TRect __fastcall GetSelection();
	bool __fastcall GetTabStops(int Index);
	int __fastcall GetVisibleColCount(void);
	int __fastcall GetVisibleRowCount(void);
	void __fastcall CalcDrawInfoXY(TGridDrawInfoEh &DrawInfo, int UseWidth, int UseHeight);
	void __fastcall CancelMode(void);
	void __fastcall ChangeSize(int NewColCount, int NewRowCount);
	void __fastcall ClampInView(const TGridCoord &Coord, bool CheckX, bool CheckY);
	MESSAGE void __fastcall CMCancelMode(Controls::TCMCancelMode &Msg);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	void __fastcall DrawMove(const TGridDrawInfoEh &DrawInfo);
	virtual void __fastcall HideMove(void);
	void __fastcall GridRectToScreenRect(const Types::TRect &GridRect, Types::TRect &ScreenRect, bool IncludeLine);
	void __fastcall Initialize(void);
	void __fastcall InvalidateRect(const Types::TRect &ARect);
	void __fastcall ModifyScrollBar(unsigned ScrollBar, unsigned ScrollCode, unsigned Pos, bool UseRightToLeft);
	void __fastcall MoveAdjust(int &CellPos, int FromIndex, int ToIndex);
	void __fastcall MoveAnchor(const TGridCoord &NewAnchor, bool Show);
	void __fastcall MoveAndScroll(int Mouse, int CellHit, TGridDrawInfoEh &DrawInfo, TGridAxisDrawInfoEh &Axis, int Scrollbar, const Types::TPoint &MousePt);
	void __fastcall MoveCurrent(int ACol, int ARow, bool MoveAnchor, bool Show);
	void __fastcall MoveTopLeft(int ALeft, int ATop);
	void __fastcall ReadColWidths(Classes::TReader* Reader);
	void __fastcall ReadRowHeights(Classes::TReader* Reader);
	void __fastcall ResizeCol(int Index, int OldSize, int NewSize);
	void __fastcall ResizeRow(int Index, int OldSize, int NewSize);
	void __fastcall ScrollDataInfo(int DX, int DY, TGridDrawInfoEh &DrawInfo);
	void __fastcall SelectionMoved(const Types::TRect &OldSel);
	void __fastcall SetBorderStyle(Forms::TBorderStyle Value);
	void __fastcall SetCol(int Value);
	void __fastcall SetColCount(int Value);
	void __fastcall SetColWidths(int Index, int Value);
	void __fastcall SetContraColCount(const int Value);
	void __fastcall SetContraRowCount(const int Value);
	void __fastcall SetDefaultColWidth(int Value);
	void __fastcall SetDefaultRowHeight(int Value);
	void __fastcall SetEditorMode(bool Value);
	void __fastcall SetFixedColor(Graphics::TColor Value);
	void __fastcall SetFixedCols(int Value);
	void __fastcall SetFixedRows(int Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetFrozenColCount(const int Value);
	void __fastcall SetFrozenRowCount(const int Value);
	void __fastcall SetGridLineWidth(int Value);
	void __fastcall SetLeftCol(int Value);
	void __fastcall SetOptions(TGridOptions Value);
	void __fastcall SetRow(int Value);
	void __fastcall SetRowCount(int Value);
	void __fastcall SetRowHeights(int Index, int Value);
	void __fastcall SetScrollBars(Stdctrls::TScrollStyle Value);
	void __fastcall SetSelection(const Types::TRect &Value);
	void __fastcall SetTabStops(int Index, bool Value);
	void __fastcall SetTopRow(int Value);
	void __fastcall TopLeftMoved(const TGridCoord &OldTopLeft, const tagSIZE &OldDataOffset);
	void __fastcall UpdateScrollPos(void);
	HIDESBASE MESSAGE void __fastcall WMCancelMode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMCommand(Messages::TWMCommand &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Msg);
	void __fastcall WriteColWidths(Classes::TWriter* Writer);
	void __fastcall WriteRowHeights(Classes::TWriter* Writer);
	
protected:
	TGridOptions DesignOptionsBoost;
	#pragma pack(push,1)
	tagSIZE FDataOffset;
	#pragma pack(pop)
	#pragma pack(push,1)
	tagSIZE FDataPageSize;
	#pragma pack(pop)
	#pragma pack(push,1)
	tagSIZE FGridDataSize;
	#pragma pack(pop)
	#pragma pack(push,1)
	Types::TPoint FSmoothPos;
	#pragma pack(pop)
	Graphics::TColor FFixedLineColor;
	TGridState FGridState;
	int FLockPaint;
	TGridCoord FMouseDownCell;
	bool FSaveCellExtents;
	bool VirtualView;
	int FSizingIndex;
	int FSizingPos;
	int FSizingOfs;
	TGridCoord FHotTrackCell;
	bool __fastcall IsActiveControl(void);
	virtual bool __fastcall BeginColumnDrag(int &Origin, int &Destination, const Types::TPoint &MousePt);
	virtual bool __fastcall BeginRowDrag(int &Origin, int &Destination, const Types::TPoint &MousePt);
	Types::TRect __fastcall BoxRect(int ALeft, int ATop, int ARight, int ABottom);
	TGridCoord __fastcall CalcCoordFromPoint(int X, int Y, const TGridDrawInfoEh &DrawInfo);
	virtual bool __fastcall CanEditAcceptKey(char Key);
	virtual bool __fastcall CanEditModify(void);
	virtual bool __fastcall CanEditShow(void);
	virtual bool __fastcall CanGridAcceptKey(Word Key, Classes::TShiftState Shift);
	Types::TRect __fastcall CellRect(int ACol, int ARow);
	virtual Types::TRect __fastcall CellEditRect(int ACol, int ARow);
	virtual bool __fastcall CheckCellMouseClick(Messages::TWMMouse &Message);
	virtual bool __fastcall CheckColumnDrag(int &Origin, int &Destination, const Types::TPoint &MousePt);
	virtual bool __fastcall CheckRowDrag(int &Origin, int &Destination, const Types::TPoint &MousePt);
	virtual TInplaceEdit* __fastcall CreateEditor(void);
	virtual TGridLineColorsEh* __fastcall CreateGridLineColors(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	int __fastcall DrawMoveLine(int FromPos, int Smooth, bool WithDelay);
	virtual bool __fastcall EndColumnDrag(int &Origin, int &Destination, const Types::TPoint &MousePt);
	virtual bool __fastcall EndRowDrag(int &Origin, int &Destination, const Types::TPoint &MousePt);
	bool __fastcall EnsureInplaceEditCreated(void);
	virtual int __fastcall GetEditLimit(void);
	virtual AnsiString __fastcall GetEditMask(int ACol, int ARow);
	virtual TEditStyle __fastcall GetEditStyle(int ACol, int ARow);
	virtual AnsiString __fastcall GetEditText(int ACol, int ARow);
	int __fastcall GetGridHeight(void);
	int __fastcall GetGridWidth(void);
	virtual int __fastcall GetHorzScrollStep(void);
	virtual int __fastcall GetVertScrollStep(void);
	virtual bool __fastcall IsSmoothHorzScroll(void);
	virtual bool __fastcall IsSmoothVertScroll(void);
	virtual bool __fastcall CanHotTackCell(int X, int Y);
	bool __fastcall PaintLocked(void);
	int __fastcall ResizeLine(const TGridAxisDrawInfoEh &AxisInfo);
	TRCRRec __fastcall RestrictClipRegionAlignment(Graphics::TCanvas* Canvas, const Types::TRect &Rect);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	bool __fastcall Sizing(int X, int Y);
	__int64 __fastcall GetChangingGridDataExtend(int Index, int Amount, bool Rows);
	__int64 __fastcall GetChangingGridDataExtendForFixedData(int Amount, bool Rows);
	__int64 __fastcall GetChangingGridDataExtendForContraData(int Amount, bool Rows);
	__int64 __fastcall GetChangingGridDataExtendForColWidth(int ColRowNum, int Amount, bool Rows);
	HIDESBASE virtual void __fastcall AdjustSize(int Index, int Amount, bool Rows);
	void __fastcall CalcContraInfo(TGridDrawInfoEh &DrawInfo, int UseWidth, int UseHeight);
	void __fastcall CalcDrawInfo(TGridDrawInfoEh &DrawInfo);
	void __fastcall CalcFixedInfo(TGridDrawInfoEh &DrawInfo);
	virtual void __fastcall CalcSizingState(int X, int Y, TGridState &State, int &Index, int &SizingPos, int &SizingOfs, TGridDrawInfoEh &FixedInfo);
	virtual void __fastcall CellMouseClick(const TGridCoord &Cell, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ChangeGridOrientation(bool RightToLeftOrientation);
	virtual void __fastcall ColumnMoved(int FromIndex, int ToIndex);
	virtual void __fastcall ColWidthsChanged(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall GetDrawSizingLineBound(const TGridDrawInfoEh &DrawInfo, int &StartPos, int &FinishPos);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	virtual void __fastcall DeleteColumn(int ACol);
	virtual void __fastcall DeleteRow(int ARow);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, TGridDrawState AState) = 0 ;
	void __fastcall DrawContraInfo(const TGridDrawInfoEh &DrawInfo);
	void __fastcall DrawEdgeEh(Graphics::TCanvas* ACanvas, const Types::TRect &qrc, bool IsDown, bool IsSelected, bool NeedLeft, bool NeedRight);
	void __fastcall DrawLines(const TGridDrawInfoEh &DrawInfo, bool DoHorz, bool DoVert, int Col, int Row, int const * CellBounds, const int CellBounds_Size, Graphics::TColor OnColor, Graphics::TColor OffColor, Graphics::TCanvas* Canvas, const TDrawLinesInfoEh &DrawLinesInfo);
	void __fastcall DrawGradientUnderDataLines(const TGridDrawInfoEh &DrawInfo, int AFrom, int ATo);
	void __fastcall DrawPolyline(Types::TPoint * Points, const int Points_Size);
	void __fastcall DrawPolyPolyline(TPointArray PointsList, TDWORDArray StrokeList, int VCount);
	virtual void __fastcall DrawSizingLine(const TGridDrawInfoEh &DrawInfo);
	virtual void __fastcall FlatChanged(void);
	void __fastcall FocusCell(int ACol, int ARow, bool MoveAnchor);
	void __fastcall HideEdit(void);
	virtual void __fastcall HideEditor(void);
	void __fastcall InvalidateCell(int ACol, int ARow);
	void __fastcall InvalidateCol(int ACol);
	void __fastcall InvalidateEditor(void);
	void __fastcall InvalidateGrid(void);
	void __fastcall InvalidateRow(int ARow);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	void __fastcall LockPaint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall MoveColRow(int ACol, int ARow, bool MoveAnchor, bool Show);
	void __fastcall MoveColumn(int FromIndex, int ToIndex);
	void __fastcall MoveRow(int FromIndex, int ToIndex);
	virtual void __fastcall Paint(void);
	virtual void __fastcall RowHeightsChanged(void);
	virtual void __fastcall RowMoved(int FromIndex, int ToIndex);
	virtual void __fastcall ScrollData(int DX, int DY);
	virtual void __fastcall SetContraSize(int NewContraColCount, int NewContraRowCount);
	virtual void __fastcall SetEditText(int ACol, int ARow, const AnsiString Value);
	void __fastcall SetGridScrollInfo(int BarFlag, int Min, int Max, int PageSize, int Pos);
	virtual void __fastcall ShowEditor(void);
	void __fastcall ShowEditorChar(char Ch);
	virtual void __fastcall SizeChanged(int OldColCount, int OldRowCount);
	void __fastcall SmoothScrollData(int DX, int DY);
	void __fastcall SafeSmoothScrollData(int DX, int DY);
	virtual void __fastcall TimedScroll(TGridScrollDirection Direction);
	virtual void __fastcall TopLeftChanged(void);
	void __fastcall UnlockPaint(void);
	void __fastcall UpdateDesigner(void);
	virtual void __fastcall UpdateFixedLineColor(void);
	void __fastcall UpdateGridDataWidth(void);
	void __fastcall UpdateGridDataHeight(void);
	virtual void __fastcall UpdateEdit(void);
	virtual void __fastcall UpdateText(void);
	void __fastcall UpdateScrollRange(void);
	virtual void __fastcall UpdateHotTackInfo(int X, int Y);
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property int Col = {read=FCurrent.X, write=SetCol, nodefault};
	__property int ColCount = {read=FColCount, write=SetColCount, default=5};
	__property Color  = {default=-16777211};
	__property int ColWidths[int Index] = {read=GetColWidths, write=SetColWidths};
	__property int ContraColCount = {read=FContraColCount, write=SetContraColCount, default=0};
	__property int ContraRowCount = {read=FContraRowCount, write=SetContraRowCount, default=0};
	__property int DefaultColWidth = {read=FDefaultColWidth, write=SetDefaultColWidth, default=64};
	__property bool DefaultDrawing = {read=FDefaultDrawing, write=FDefaultDrawing, default=1};
	__property int DefaultRowHeight = {read=FDefaultRowHeight, write=SetDefaultRowHeight, default=24};
	__property bool EditorMode = {read=FEditorMode, write=SetEditorMode, nodefault};
	__property Graphics::TColor FixedColor = {read=FFixedColor, write=SetFixedColor, default=-16777201};
	__property int FixedCols = {read=FFixedCols, write=SetFixedCols, default=1};
	__property int FixedRows = {read=FFixedRows, write=SetFixedRows, default=1};
	__property int FrozenColCount = {read=FFrozenColCount, write=SetFrozenColCount, nodefault};
	__property int FrozenRowCount = {read=FFrozenRowCount, write=SetFrozenRowCount, nodefault};
	__property int FullColCount = {read=GetFullColCount, nodefault};
	__property int FullRowCount = {read=GetFullRowCount, nodefault};
	__property int GridHeight = {read=GetGridHeight, nodefault};
	__property TGridLineColorsEh* GridLineColors = {read=FGridLineColors};
	__property int GridLineWidth = {read=FGridLineWidth, write=SetGridLineWidth, default=1};
	__property int GridWidth = {read=GetGridWidth, nodefault};
	__property Types::TPoint HitTest = {read=FHitTest};
	__property TInplaceEdit* InplaceEditor = {read=FInplaceEdit};
	__property int LeftCol = {read=FTopLeft.X, write=SetLeftCol, nodefault};
	__property TGridEhCellMouseEvent OnCellMouseClick = {read=FOnCellMouseClick, write=FOnCellMouseClick};
	__property TGridOptions Options = {read=FOptions, write=SetOptions, default=31};
	__property ParentColor  = {default=0};
	__property int Row = {read=FCurrent.Y, write=SetRow, nodefault};
	__property int RowCount = {read=FRowCount, write=SetRowCount, default=5};
	__property int RowHeights[int Index] = {read=GetRowHeights, write=SetRowHeights};
	__property Stdctrls::TScrollStyle ScrollBars = {read=FScrollBars, write=SetScrollBars, default=3};
	__property Types::TRect Selection = {read=GetSelection, write=SetSelection};
	__property bool TabStops[int Index] = {read=GetTabStops, write=SetTabStops};
	__property int TopRow = {read=FTopLeft.Y, write=SetTopRow, nodefault};
	__property int VisibleColCount = {read=GetVisibleColCount, nodefault};
	__property int VisibleRowCount = {read=GetVisibleRowCount, nodefault};
	
public:
	__fastcall virtual TCustomGridEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomGridEh(void);
	TGridCoord __fastcall MouseCoord(int X, int Y);
	virtual void __fastcall DefaultCellMouseClick(const TGridCoord &Cell, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	
__published:
	__property TabStop  = {default=1};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCustomGridEh(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TInplaceEdit : public Mask::TCustomMaskEdit 
{
	typedef Mask::TCustomMaskEdit inherited;
	
private:
	TCustomGridEh* FGrid;
	int FClickTime;
	void __fastcall InternalMove(const Types::TRect &Loc, bool Redraw);
	void __fastcall SetGrid(TCustomGridEh* Value);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMClear(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC bool __fastcall DoMouseWheel(Classes::TShiftState Shift, int WheelDelta, const Types::TPoint &MousePos);
	virtual bool __fastcall EditCanModify(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall BoundsChanged(void);
	virtual void __fastcall UpdateContents(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	__property TCustomGridEh* Grid = {read=FGrid};
	
public:
	__fastcall virtual TInplaceEdit(Classes::TComponent* AOwner);
	void __fastcall Deselect(void);
	HIDESBASE void __fastcall Hide(void);
	virtual void __fastcall Invalidate(void);
	void __fastcall Move(const Types::TRect &Loc);
	bool __fastcall PosEqual(const Types::TRect &Rect);
	HIDESBASE void __fastcall SetFocus(void);
	void __fastcall UpdateLoc(const Types::TRect &Loc);
	HIDESBASE bool __fastcall Visible(void);
	__property MaxLength  = {default=0};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TInplaceEdit(HWND ParentWindow) : Mask::TCustomMaskEdit(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TInplaceEdit(void) { }
	#pragma option pop
	
};


typedef Types::TRect  TGridRect;

typedef void __fastcall (__closure *TSelectCellEvent)(System::TObject* Sender, int ACol, int ARow, bool &CanSelect);

typedef void __fastcall (__closure *TDrawCellEvent)(System::TObject* Sender, int ACol, int ARow, const Types::TRect &Rect, TGridDrawState State);

typedef void __fastcall (__closure *TGetEditEvent)(System::TObject* Sender, int ACol, int ARow, AnsiString &Value);

typedef void __fastcall (__closure *TSetEditEvent)(System::TObject* Sender, int ACol, int ARow, const AnsiString Value);

typedef void __fastcall (__closure *TMovedEvent)(System::TObject* Sender, int FromIndex, int ToIndex);

class DELPHICLASS TCustomDrawGridEh;
class PASCALIMPLEMENTATION TCustomDrawGridEh : public TCustomGridEh 
{
	typedef TCustomGridEh inherited;
	
private:
	TMovedEvent FOnColumnMoved;
	TDrawCellEvent FOnDrawCell;
	TGetEditEvent FOnGetEditMask;
	TGetEditEvent FOnGetEditText;
	TMovedEvent FOnRowMoved;
	TSelectCellEvent FOnSelectCell;
	TSetEditEvent FOnSetEditText;
	Classes::TNotifyEvent FOnTopLeftChanged;
	
protected:
	virtual void __fastcall ColumnMoved(int FromIndex, int ToIndex);
	virtual void __fastcall DrawCell(int ACol, int ARow, const Types::TRect &ARect, TGridDrawState AState);
	virtual AnsiString __fastcall GetEditMask(int ACol, int ARow);
	virtual AnsiString __fastcall GetEditText(int ACol, int ARow);
	virtual void __fastcall RowMoved(int FromIndex, int ToIndex);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual void __fastcall SetEditText(int ACol, int ARow, const AnsiString Value);
	virtual void __fastcall TopLeftChanged(void);
	__property TMovedEvent OnColumnMoved = {read=FOnColumnMoved, write=FOnColumnMoved};
	__property TDrawCellEvent OnDrawCell = {read=FOnDrawCell, write=FOnDrawCell};
	__property TGetEditEvent OnGetEditMask = {read=FOnGetEditMask, write=FOnGetEditMask};
	__property TGetEditEvent OnGetEditText = {read=FOnGetEditText, write=FOnGetEditText};
	__property TMovedEvent OnRowMoved = {read=FOnRowMoved, write=FOnRowMoved};
	__property TSelectCellEvent OnSelectCell = {read=FOnSelectCell, write=FOnSelectCell};
	__property TSetEditEvent OnSetEditText = {read=FOnSetEditText, write=FOnSetEditText};
	__property Classes::TNotifyEvent OnTopLeftChanged = {read=FOnTopLeftChanged, write=FOnTopLeftChanged};
	
public:
	HIDESBASE Types::TRect __fastcall CellRect(int ACol, int ARow);
	void __fastcall MouseToCell(int X, int Y, int &ACol, int &ARow);
	__property Canvas ;
	__property Col ;
	__property ColWidths ;
	__property EditorMode ;
	__property GridHeight ;
	__property GridWidth ;
	__property LeftCol ;
	__property Selection ;
	__property Row ;
	__property RowHeights ;
	__property TabStops ;
	__property TopRow ;
	__property ContraRowCount  = {default=0};
	__property ContraColCount  = {default=0};
	__property FullRowCount ;
	__property FullColCount ;
	__property FrozenColCount ;
	__property FrozenRowCount ;
	__property Flat ;
public:
	#pragma option push -w-inl
	/* TCustomGridEh.Create */ inline __fastcall virtual TCustomDrawGridEh(Classes::TComponent* AOwner) : TCustomGridEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomGridEh.Destroy */ inline __fastcall virtual ~TCustomDrawGridEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TCustomDrawGridEh(HWND ParentWindow) : TCustomGridEh(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TDrawGridEh;
class PASCALIMPLEMENTATION TDrawGridEh : public TCustomDrawGridEh 
{
	typedef TCustomDrawGridEh inherited;
	
__published:
	__property Align  = {default=0};
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property BorderStyle  = {default=1};
	__property Color  = {default=-16777211};
	__property ColCount  = {default=5};
	__property Constraints ;
	__property Ctl3D ;
	__property DefaultColWidth  = {default=64};
	__property DefaultRowHeight  = {default=24};
	__property DefaultDrawing  = {default=1};
	__property DragCursor  = {default=-12};
	__property DragKind  = {default=0};
	__property DragMode  = {default=0};
	__property Enabled  = {default=1};
	__property FixedColor  = {default=-16777201};
	__property FixedCols  = {default=1};
	__property RowCount  = {default=5};
	__property FixedRows  = {default=1};
	__property Font ;
	__property GridLineWidth  = {default=1};
	__property Options  = {default=31};
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentCtl3D  = {default=1};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ScrollBars  = {default=3};
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property Visible  = {default=1};
	__property VisibleColCount ;
	__property VisibleRowCount ;
	__property OnClick ;
	__property OnColumnMoved ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnDrawCell ;
	__property OnEndDock ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnGetEditMask ;
	__property OnGetEditText ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseDown ;
	__property OnMouseMove ;
	__property OnMouseUp ;
	__property OnMouseWheelDown ;
	__property OnMouseWheelUp ;
	__property OnRowMoved ;
	__property OnSelectCell ;
	__property OnSetEditText ;
	__property OnStartDock ;
	__property OnStartDrag ;
	__property OnTopLeftChanged ;
public:
	#pragma option push -w-inl
	/* TCustomGridEh.Create */ inline __fastcall virtual TDrawGridEh(Classes::TComponent* AOwner) : TCustomDrawGridEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCustomGridEh.Destroy */ inline __fastcall virtual ~TDrawGridEh(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TDrawGridEh(HWND ParentWindow) : TCustomDrawGridEh(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TGridDragWinEh;
class PASCALIMPLEMENTATION TGridDragWinEh : public Controls::TWinControl 
{
	typedef Controls::TWinControl inherited;
	
private:
	Byte FAlphaBlendValue;
	Graphics::TColor FTransparentColorValue;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWindowHandle(const Controls::TCreateParams &Params);
	void __fastcall SetLayeredAttribs(void);
	
public:
	__fastcall virtual TGridDragWinEh(Classes::TComponent* AOwner);
	HIDESBASE bool __fastcall Visible(void);
	HIDESBASE void __fastcall Show(void);
	virtual void __fastcall MoveToFor(Controls::TControl* Control, const Types::TPoint &NewPos)/* overload */;
	virtual void __fastcall MoveToFor(Controls::TControl* Control, const Types::TPoint &NewPos, int NewWidth, int NewHeight)/* overload */;
	virtual void __fastcall StartShow(Controls::TControl* Control, const Types::TPoint &Pos, int Width, int Height)/* overload */;
	virtual void __fastcall StartShow(Controls::TControl* Control, const Types::TPoint &Pos, int Height)/* overload */;
	void __fastcall TemporaryHide(void);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TGridDragWinEh(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TGridDragWinEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TGridDragBoxEh;
class PASCALIMPLEMENTATION TGridDragBoxEh : public TGridDragWinEh 
{
	typedef TGridDragWinEh inherited;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TGridDragBoxEh(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TGridDragBoxEh(HWND ParentWindow) : TGridDragWinEh(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TGridDragBoxEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TGridMoveLineEh;
class PASCALIMPLEMENTATION TGridMoveLineEh : public TGridDragWinEh 
{
	typedef TGridDragWinEh inherited;
	
protected:
	Extctrls::TShape* sHigh7;
	Extctrls::TShape* sHigh5;
	Extctrls::TShape* sHigh3;
	Extctrls::TShape* sLine;
	Extctrls::TShape* sLow3;
	Extctrls::TShape* sLow5;
	Extctrls::TShape* sLow7;
	Extctrls::TShape* hLeft7;
	Extctrls::TShape* hLeft5;
	Extctrls::TShape* hLeft3;
	Extctrls::TShape* hLine;
	Extctrls::TShape* hRight3;
	Extctrls::TShape* hRight5;
	Extctrls::TShape* hRight7;
	bool FIsVert;
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TGridMoveLineEh(Classes::TComponent* AOwner);
	HIDESBASE virtual void __fastcall StartShow(Controls::TControl* Control, const Types::TPoint &Pos, bool AIsVert, int Size);
	virtual void __fastcall MoveToFor(Controls::TControl* Control, const Types::TPoint &NewPos)/* overload */;
	void __fastcall UpdateOrientationData(void);
	__property bool IsVert = {read=FIsVert, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TGridMoveLineEh(HWND ParentWindow) : TGridDragWinEh(ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TGridMoveLineEh(void) { }
	#pragma option pop
	
	
/* Hoisted overloads: */
	
public:
	inline void __fastcall  MoveToFor(Controls::TControl* Control, const Types::TPoint &NewPos, int NewWidth, int NewHeight){ TGridDragWinEh::MoveToFor(Control, NewPos, NewWidth, NewHeight); }
	
};


//-- var, const, procedure ---------------------------------------------------
static const int MaxCustomExtentsEh = 0x7ffffff;
static const Shortint MaxShortIntEh = 127;
extern PACKAGE TGridCoord __fastcall GridCoord(int X, int Y);
extern PACKAGE TGridDragWinEh* __fastcall GetDragBoxEh(void);
extern PACKAGE TGridMoveLineEh* __fastcall GetMoveLineEh(void);

}	/* namespace Gridseh */
using namespace Gridseh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Gridseh
