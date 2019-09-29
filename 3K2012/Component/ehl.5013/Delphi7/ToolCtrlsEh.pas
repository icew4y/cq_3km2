{*******************************************************}
{                                                       }
{                      EhLib v5.0                       }
{                     Tool controls                     }
{                    (Build 5.0.00)                     }
{                                                       }
{      Copyright (c) 2001-2009 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit ToolCtrlsEh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF EH_LIB_5} Contnrs, ActnList, {$ENDIF}
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  StdCtrls, Mask, Db, DBCtrls, Buttons, ExtCtrls, Menus, ComCtrls, CommCtrl,
  Imglist;

const
  CM_IGNOREEDITDOWN = WM_USER + 102;
  
var
  EhLibRegKey: String = 'EhLib';

type

  TLocateTextOptionEh = (ltoCaseInsensitiveEh, ltoAllFieldsEh, ltoMatchFormatEh,
    ltoIgnoteCurrentPosEh, ltoStopOnEscape);
  TLocateTextOptionsEh = set of TLocateTextOptionEh;
  TLocateTextDirectionEh = (ltdUpEh, ltdDownEh, ltdAllEh);
  TLocateTextMatchingEh = (ltmAnyPartEh, ltmWholeEh, ltmFromBegingEh);
  TLocateTextTreeFindRangeEh = (lttInAllNodesEh, lttInExpandedNodesEh,
    lttInCurrentLevelEh, lttInCurrentNodeEh);

  IMemTableDataFieldValueListEh = interface
    ['{28F8194C-5FF3-42C4-87A6-8B3E06210FA6}']
    function GetValues: TStrings;
  end;

  IComboEditEh = interface
    ['{B64255B5-386A-4524-8BC7-7F49DDB410F4}']
    procedure CloseUp(Accept: Boolean);
  end;

  TFieldsArrEh = array of TField;

{ Standard events }

  TButtonClickEventEh = procedure(Sender: TObject; var Handled: Boolean) of object;
  TButtonDownEventEh = procedure(Sender: TObject; TopButton: Boolean;
    var AutoRepeat: Boolean; var Handled: Boolean) of object;
  TCloseUpEventEh = procedure(Sender: TObject; Accept: Boolean) of object;
  TAcceptEventEh = procedure(Sender: TObject; var Accept: Boolean) of object;
  TNotInListEventEh = procedure(Sender: TObject; NewText: String;
    var RecheckInList: Boolean) of object;
  TUpdateDataEventEh = procedure(Sender: TObject; var Handled: Boolean) of object;

{ TBMListEh }

  TBMListEh = class;

  TBMListSortCompare = function(List: TBMListEh; DataSet: TDataSet; Index1, Index2: Integer): Integer;

  TBMListEh = class
  private
    FCache: TUniBookmarkEh;
    FCacheFind: Boolean;
    FCacheIndex: Integer;
    FLinkActive: Boolean;
    function GetCount: Integer;
    function GetCurrentRowSelected: Boolean;
    function GetItem(Index: Integer): TUniBookmarkEh;
    procedure QuickSort(DataSet: TDataSet; L, R: Integer; SCompare: TBMListSortCompare);
    procedure SetItem(Index: Integer; Item: TUniBookmarkEh);
  protected
{$IFDEF EH_LIB_12}
    FList: array of TBookmark;
{$ELSE}
    FList: TStringList;
{$ENDIF}
    function Compare(const Item1, Item2: TUniBookmarkEh): Integer;
    function CurrentRow: TUniBookmarkEh;
    function GetDataSet: TDataSet; virtual;
    procedure Invalidate; virtual;
    procedure LinkActive(Value: Boolean);
    procedure RaiseBMListError(const S: string); virtual;
    procedure SetCurrentRowSelected(Value: Boolean); virtual;
    procedure DataChanged(Sender: TObject); virtual;
    procedure UpdateState; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function Find(const Item: TUniBookmarkEh; var Index: Integer): Boolean;
    function IndexOf(const Item: TUniBookmarkEh): Integer;
    function Refresh: Boolean;
    procedure AppendItem(Item: TUniBookmarkEh);
    procedure Clear; virtual;
    procedure CustomSort(DataSet: TDataSet; Compare: TBMListSortCompare); virtual;
    procedure Delete;
    procedure DeleteItem(Index: Integer);
    procedure InsertItem(Index: Integer; Item: TUniBookmarkEh);
    procedure SelectAll;
    property Count: Integer read GetCount;
    property CurrentRowSelected: Boolean read GetCurrentRowSelected write SetCurrentRowSelected;
    property DataSet: TDataSet read GetDataSet;
    property Items[Index: Integer]: TUniBookmarkEh read GetItem write SetItem; default;
  end;

  IMemTableEh = interface
    ['{A8C3C87A-E556-4BDB-B8A7-5B33497D1624}']
//    property TreeViewMode: Boolean read GetTreeViewMode write SetTreeViewMode;
    function FetchRecords(Count: Integer): Integer;
    function GetInstantReadCurRowNum: Integer;
    function GetTreeNodeExpanded(RowNum: Integer): Boolean; overload;
    function GetTreeNodeExpanded: Boolean; overload;
    function GetTreeNodeHasChields: Boolean;
    function GetTreeNodeLevel: Integer;
    function GetPrevVisibleTreeNodeLevel: Integer;
    function GetNextVisibleTreeNodeLevel: Integer;
    function GetRecObject: TObject;
    function InstantReadIndexOfBookmark(Bookmark: TUniBookmarkEh): Integer;
    function InstantReadRowCount: Integer;
    function MemTableIsTreeList: Boolean;
    function ParentHasNextSibling(ParenLevel: Integer): Boolean;
    function SetToRec(Rec: TObject): Boolean;
    function SetTreeNodeExpanded(RowNum: Integer; Value: Boolean): Integer;
    function GetFieldValueList(FieldName: String): IMemTableDataFieldValueListEh;
    function MoveRecords(BookmarkList: TBMListEh; ToRecNo: Longint; TreeLevel: Integer; CheckOnly: Boolean): Boolean;
    procedure InstantReadEnter(RowNum: Integer);
    procedure InstantReadLeave;
    procedure RegisterEventReceiver(AComponent: TComponent);
    procedure UnregisterEventReceiver(AComponent: TComponent);
    property InstantReadCurRowNum: Integer read GetInstantReadCurRowNum;
//    property TreeNodeCollapsed: Boolean read GetTreeNodeCollapsed write SetTreeNodeCollapsed;
  end;

  TMTViewEventTypeEh = (mtRowInsertedEh, mtRowChangedEh, mtRowDeletedEh,
    mtRowMovedEh, mtViewDataChangedEh);

  IMTEventReceiverEh = interface
    ['{60C6C1A2-A817-4043-885A-BDDC750587BD}']
    procedure MTViewDataEvent(RowNum: Integer;
      Event: TMTViewEventTypeEh; OldRowNum: Integer);
  end;

{ TEditButtonControlEh }

  TEditButtonStyleEh = (ebsDropDownEh, ebsEllipsisEh, ebsGlyphEh, ebsUpDownEh,
    ebsPlusEh, ebsMinusEh, ebsAltDropDownEh, ebsAltUpDownEh);

  TEditButtonControlEh = class(TSpeedButton)
  private
    FActive: Boolean;
    FAlwaysDown: Boolean;
    FButtonNum: Integer;
    FNoDoClick: Boolean;
    FOnDown: TButtonDownEventEh;
    FStyle: TEditButtonStyleEh;
    FTimer: TTimer;
    function GetTimer: TTimer;
    procedure ResetTimer(Interval: Cardinal);
    procedure SetActive(const Value: Boolean);
    procedure SetAlwaysDown(const Value: Boolean);
    procedure SetStyle(const Value: TEditButtonStyleEh);
    procedure TimerEvent(Sender: TObject);
    procedure UpdateDownButtonNum(X, Y: Integer);
  protected
    procedure DrawButtonText(Canvas: TCanvas; const Caption: string;
      TextBounds: TRect; State: TButtonState; BiDiFlags: Longint);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    property Timer: TTimer read GetTimer;
  public
    procedure Click; override;
    procedure EditButtonDown(TopButton: Boolean; var AutoRepeat: Boolean);
    procedure SetState(NewState: TButtonState; IsActive: Boolean; ButtonNum: Integer);
    procedure SetWidthNoNotify(AWidth: Integer);
    property Active: Boolean read FActive write SetActive;
    property AlwaysDown: Boolean read FAlwaysDown write SetAlwaysDown;
    property Style: TEditButtonStyleEh read FStyle write SetStyle default ebsDropDownEh;
    property OnDown: TButtonDownEventEh read FOnDown write FOnDown;
  end;

  TSpeedButtonEh = class(TEditButtonControlEh)
  published
    property Active;
    property Style;
  end;

  TEditButtonControlLineRec = record
    ButtonLine: TShape;
    EditButtonControl: TEditButtonControlEh;
  end;

  TEditButtonControlList = array of TEditButtonControlLineRec;

  TEditButtonEh = class;

  TEditButtonActionLinkEh = class(TActionLink)
  protected
    FClient: TEditButtonEh;
    procedure AssignClient(AClient: TObject); override;
    function IsEnabledLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsShortCutLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetHint(const Value: string); override;
    procedure SetShortCut(Value: TShortCut); override;
    procedure SetVisible(Value: Boolean); override;
  end;

  TEditButtonActionLinkEhClass = class of TEditButtonActionLinkEh;

{ TEditButtonEh }

  TEditButtonEh = class(TCollectionItem)
  private
    FActionLink: TEditButtonActionLinkEh;
    FDropdownMenu: TPopupMenu;
    FEditControl: TWinControl;
    FEnabled: Boolean;
    FGlyph: TBitmap;
    FHint: String;
    FNumGlyphs: Integer;
    FOnButtonClick: TButtonClickEventEh;
    FOnButtonDown: TButtonDownEventEh;
    FOnChanged: TNotifyEvent;
    FShortCut: TShortCut;
    FStyle: TEditButtonStyleEh;
    FVisible: Boolean;
    FWidth: Integer;
    function GetAction: TBasicAction;
    function GetGlyph: TBitmap;
    function IsEnabledStored: Boolean;
    function IsHintStored: Boolean;
    function IsShortCutStored: Boolean;
    function IsVisibleStored: Boolean;
    procedure DoActionChange(Sender: TObject);
    procedure SetAction(const Value: TBasicAction);
    procedure SetEnabled(const Value: Boolean);
    procedure SetGlyph(const Value: TBitmap);
    procedure SetHint(const Value: String);
    procedure SetNumGlyphs(Value: Integer);
    procedure SetStyle(const Value: TEditButtonStyleEh);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
  protected
    function CreateEditButtonControl: TEditButtonControlEh; virtual;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); dynamic;
    procedure Changed; overload;
    property ActionLink: TEditButtonActionLinkEh read FActionLink write FActionLink;
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(EditControl: TWinControl); reintroduce; overload;
    destructor Destroy; override;
    function GetActionLinkClass: TEditButtonActionLinkEhClass; dynamic;
    procedure Assign(Source: TPersistent); override;
    procedure Click(Sender: TObject; var Handled: Boolean); virtual;
    procedure InitiateAction; virtual;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property DropdownMenu: TPopupMenu read FDropdownMenu write FDropdownMenu;
    property Enabled: Boolean read FEnabled write SetEnabled stored IsEnabledStored default True;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Hint: String read FHint write SetHint stored IsHintStored;
    property NumGlyphs: Integer read FNumGlyphs write SetNumGlyphs default 1;
    property ShortCut: TShortCut read FShortCut write FShortCut stored IsShortCutStored default scNone;
    //property ShortCut: TShortCut read FShortCut write FShortCut default 32808; //Menus.ShortCut(VK_DOWN, [ssAlt]);
    property Style: TEditButtonStyleEh read FStyle write SetStyle default ebsDropDownEh;
    property Visible: Boolean read FVisible write SetVisible stored IsVisibleStored default False;
    property Width: Integer read FWidth write SetWidth default 0;
    property OnClick: TButtonClickEventEh read FOnButtonClick write FOnButtonClick;
    property OnDown: TButtonDownEventEh read FOnButtonDown write FOnButtonDown;
  end;

  TEditButtonEhClass = class of TEditButtonEh;

{ TDropDownEditButtonEh }

  TDropDownEditButtonEh = class(TEditButtonEh)
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(EditControl: TWinControl); overload;
  published
    property ShortCut default 32808; //Menus.ShortCut(VK_DOWN, [ssAlt]);
  end;


{ TVisibleEditButtonEh }

  TVisibleEditButtonEh = class(TEditButtonEh)
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(EditControl: TWinControl); overload;
  published
    property ShortCut default 32808; //Menus.ShortCut(VK_DOWN, [ssAlt]);
    property Visible default True;
  end;

{ TEditButtonsEh }

  TEditButtonsEh = class(TCollection)
  private
    FOnChanged: TNotifyEvent;
    function GetEditButton(Index: Integer): TEditButtonEh;
    procedure SetEditButton(Index: Integer; Value: TEditButtonEh);
  protected
    FOwner: TPersistent;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner: TPersistent; EditButtonClass: TEditButtonEhClass);
    function Add: TEditButtonEh;
    property Items[Index: Integer]: TEditButtonEh read GetEditButton write SetEditButton; default;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  end;

{ TSpecRowEh }

  TSpecRowEh = class(TPersistent)
  private
    FCellsStrings: TStrings;
    FCellsText: String;
    FColor: TColor;
    FFont: TFont;
    FOnChanged: TNotifyEvent;
    FOwner: TPersistent;
    FSelected: Boolean;
    FShortCut: TShortCut;
    FShowIfNotInKeyList: Boolean;
    FUpdateCount: Integer;
    FValue: Variant;
    FVisible: Boolean;
    function GetCellText(Index: Integer): String;
    function GetColor: TColor;
    function GetFont: TFont;
    function IsColorStored: Boolean;
    function IsFontStored: Boolean;
    function IsValueStored: Boolean;
    procedure FontChanged(Sender: TObject);
    procedure SetCellsText(const Value: String);
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetShowIfNotInKeyList(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetVisible(const Value: Boolean);
  protected
    FColorAssigned: Boolean;
    FFontAssigned: Boolean;
    function GetOwner: TPersistent; override;
    procedure Changed;
  public
    constructor Create(Owner: TPersistent);
    destructor Destroy; override;
    function DefaultColor: TColor;
    function DefaultFont: TFont;
    function LocateKey(KeyValue: Variant): Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    property CellText[Index: Integer]: String read GetCellText;
    property Selected: Boolean read FSelected write FSelected;
    property UpdateCount: Integer read FUpdateCount;
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published
    property CellsText: String read FCellsText write SetCellsText;
    property Color: TColor read GetColor write SetColor stored IsColorStored;
    property Font: TFont read GetFont write SetFont stored IsFontStored;
    property ShortCut: TShortCut read FShortCut write FShortCut default 32814; //Menus.ShortCut(VK_DOWN, [ssAlt]);
    property ShowIfNotInKeyList: Boolean read FShowIfNotInKeyList write SetShowIfNotInKeyList default True;
    property Value: Variant read FValue write SetValue stored IsValueStored;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

{ TSizeGripEh }

  TSizeGripPostion = (sgpTopLeft, sgpTopRight, sgpBottomRight, sgpBottomLeft);
  TSizeGripChangePosition = (sgcpToLeft, sgcpToRight, sgcpToTop, sgcpToBottom);

  TSizeGripEh = class(TCustomControl)
  private
    FInitScreenMousePos: TPoint;
    FInternalMove: Boolean;
    FOldMouseMovePos: TPoint;
    FParentRect: TRect;
    FParentResized: TNotifyEvent;
    FPosition: TSizeGripPostion;
    FTriangleWindow: Boolean;
    function GetVisible: Boolean;
    procedure SetPosition(const Value: TSizeGripPostion);
    procedure SetTriangleWindow(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
  protected
    procedure CreateWnd; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    procedure ParentResized; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ChangePosition(NewPosition: TSizeGripChangePosition);
    procedure UpdatePosition;
    procedure UpdateWindowRegion;
    property Position: TSizeGripPostion read FPosition write SetPosition default sgpBottomRight;
    property TriangleWindow: Boolean read FTriangleWindow write SetTriangleWindow default True;
    property Visible: Boolean read GetVisible write SetVisible;
    property OnParentResized: TNotifyEvent read FParentResized write FParentResized;
  end;

const
  cm_SetSizeGripChangePosition = WM_USER + 100;

{ TPopupMonthCalendarEh }

const
  CM_CLOSEUPEH = WM_USER + 101;

type

  TPopupMonthCalendarEh = class(TMonthCalendar)
  private
    FBorderWidth: Integer;
    procedure CMCloseUpEh(var Message: TMessage); message CM_CLOSEUPEH;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
  protected
    FDownViewType: Integer;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function MsgSetDateTime(Value: TSystemTime): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawBorder; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure PostCloseUp(Accept: Boolean);
    procedure UpdateBorderWidth;
  public
    constructor Create(AOwner: TComponent); override;
    property Color;
    property Ctl3D;
  end;

  TListGetImageIndexEventEh = procedure(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer) of object;

{ TPopupListboxEh }

  TPopupListboxEh = class(TCustomListbox)
  private
    FBorderWidth: Integer;
    FImageList: TCustomImageList;
    FMousePos: TPoint;
    FRowCount: Integer;
    FSearchText: String;
    FSearchTickCount: Longint;
    FSizeGrip: TSizeGripEh;
    FSizeGripResized: Boolean;
    FOnGetImageIndex: TListGetImageIndexEventEh;
    FExtItems: TStrings;
    function CheckNewSize(var NewWidth, NewHeight: Integer): Boolean;
    function GetBorderSize: Integer;
    function GetExtItems: TStrings;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMSetSizeGripChangePosition(var Message: TMessage); message cm_SetSizeGripChangePosition;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure SetExtItems(Value: TStrings);
    procedure SetImageList(const Value: TCustomImageList);
    procedure SetRowCount(Value: Integer);
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
  protected
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawBorder; virtual;
    procedure DrawItem(Index: Integer; ARect: TRect; State: TOwnerDrawState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure UpdateBorderWidth;
    procedure SelfOnGetData(Control: TWinControl; Index: Integer; var Data: string); virtual;
  public
    constructor Create(Owner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function CanFocus: Boolean; {$IFDEF EH_LIB_5} override; {$ENDIF}
    function GetTextHeight: Integer;
    property Color;
    property Ctl3D;
    property Font;
    property ImageList: TCustomImageList read FImageList write SetImageList;
    property IntegralHeight;
    property ItemHeight;
    property RowCount: Integer read FRowCount write SetRowCount;
    property ExtItems: TStrings read GetExtItems write SetExtItems;
    property SizeGrip: TSizeGripEh read FSizeGrip;
    property SizeGripResized: Boolean read FSizeGripResized write FSizeGripResized;
    property OnMouseUp;
    property OnGetImageIndex: TListGetImageIndexEventEh read FOnGetImageIndex write FOnGetImageIndex;
  end;

{ TMRUList }
  TFilterMRUItemEventEh = procedure (Sender: TObject; var Accept: Boolean) of object;
  TSetDropDownEventEh = procedure (Sender: TObject) of object;
  TSetCloseUpEventEh = procedure (Sender: TObject; Accept: Boolean) of object;

  TMRUListEh = class(TPersistent)
  private
    FActive: Boolean;
    FAutoAdd: Boolean;
    FCaseSensitive: Boolean;
    FItems: TStrings;
    FLimit: Integer;
    FOnActiveChanged: TNotifyEvent;
    FOnFilterItem: TFilterMRUItemEventEh;
    FOnSetCloseUpEvent: TSetCloseUpEventEh;
    FOnSetDropDown: TSetDropDownEventEh;
    FOwner: TPersistent;
    FRows: Integer;
    FWidth: Integer;
    FCancelIfKeyInQueue: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetItems(const Value: TStrings);
    procedure SetLimit(const Value: Integer);
    procedure SetRows(const Value: Integer);
  protected
    FDroppedDown: Boolean;
    procedure UpdateLimit;
  public
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    procedure Add(s: String);
    procedure Assign(Source: TPersistent); override;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DropDown; virtual;
    function FilterItemsTo(FilteredItems: TStrings; MaskText: String): Boolean;
    property DroppedDown: Boolean read FDroppedDown write FDroppedDown;
    property Width: Integer read FWidth write FWidth;
    property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnSetCloseUp: TSetCloseUpEventEh read FOnSetCloseUpEvent write FOnSetCloseUpEvent;
    property OnSetDropDown: TSetDropDownEventEh read FOnSetDropDown write FOnSetDropDown;
    property OnFilterItem: TFilterMRUItemEventEh read FOnFilterItem write FOnFilterItem;
    property CancelIfKeyInQueue: Boolean read FCancelIfKeyInQueue write FCancelIfKeyInQueue default True;
  published
    property AutoAdd: Boolean read FAutoAdd write FAutoAdd default True;
    property Active: Boolean read FActive write SetActive default False;
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive default False;
    property Items: TStrings read FItems write SetItems;
    property Limit: Integer read FLimit write SetLimit default 100;
    property Rows: Integer read FRows write SetRows default 7;
  end;

{ TMRUListboxEh }

  TMRUListboxEh = class(TPopupListboxEh)
  private
    FScrollBar: TScrollBar;
    FScrollBarLockMove: Boolean;
    procedure CMChanged(var Message: TCMChanged); message CM_CHANGED;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMSetSizeGripChangePosition(var Message: TMessage); message cm_SetSizeGripChangePosition;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ScrollBarScrolled(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarWindowProc(var Message: TMessage);
  public
    constructor Create(Owner: TComponent); override;
    procedure UpdateScrollBar;
    procedure UpdateScrollBarPos;
    property ParentCtl3D;
    property ScrollBar: TScrollBar read FScrollBar;
    property Sorted;
    property OnMouseUp;
  end;

{$IFNDEF EH_LIB_5} // Delphi 4 doesn't have TObjectList but Delphi 8 required

{ TObjectList class }

  TObjectList = class(TList)
  private
    FOwnsObjects: Boolean;
  protected
    function GetItem(Index: Integer): TObject;
    procedure SetItem(Index: Integer; AObject: TObject);
  public
    constructor Create; overload;
    constructor Create(AOwnsObjects: Boolean); overload;

    function Add(AObject: TObject): Integer;
    function Remove(AObject: TObject): Integer;
    function IndexOf(AObject: TObject): Integer;
    function FindInstanceOf(AClass: TClass; AExact: Boolean = True; AStartAt: Integer = 0): Integer;
    procedure Insert(Index: Integer; AObject: TObject);
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
    property Items[Index: Integer]: TObject read GetItem write SetItem; default;
  end;

{$ENDIF}

{$IFNDEF EH_LIB_5}
  TStringListSortCompare = function(List: TStringList; Index1, Index2: Integer): Integer;
{$ENDIF}

   TStringListEh = class(TStringList)
{$IFNDEF EH_LIB_6}
  private
    FCaseSensitive: Boolean;
    function CompareStrings(const S1, S2: string): Integer;
    procedure SetCaseSensitive(const Value: Boolean);
  public
{$IFNDEF EH_LIB_5}
    procedure CustomSort(Compare: TStringListSortCompare);
    procedure QuickSort(L, R: Integer; SCompare: TStringListSortCompare);
{$ENDIF}
    procedure Sort; override;
    property CaseSensitive: Boolean read FCaseSensitive write SetCaseSensitive;
{$ENDIF}
   end;
{ TDataLinkEh }

{$IFDEF CIL}
  TDataEventEh = procedure (Event: TDataEvent; Info: TObject) of object;
{$ELSE}
  TDataEventEh = procedure (Event: TDataEvent; Info: Longint) of object;
{$ENDIF}

  TDataLinkEh = class(TDataLink)
  private
    FOnDataEvent: TDataEventEh;
  protected
{$IFDEF CIL}
    procedure DataEvent(Event: TDataEvent; Info: TObject); virtual;
{$ELSE}
    procedure DataEvent(Event: TDataEvent; Info: Integer); override;
{$ENDIF}
  public
    property OnDataEvent: TDataEventEh read FOnDataEvent write FOnDataEvent;
  end;

{ TDatasetFieldValueListEh }

  TDatasetFieldValueListEh = class(TInterfacedObject, IMemTableDataFieldValueListEh)
  private
    FValues: TStringList;
    FDataObsoleted: Boolean;
    FFieldName: String;
    FDataLink: TDataLinkEh;
    FDataSource: TDataSource;
    function GetDataSet: TDataSet;
    function GetDataSource: TDataSource;
    function GetValues: TStrings;
    procedure SetDataSet(const Value: TDataSet);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetFieldName(const Value: String);
  protected
    procedure RefreshValues;
{$IFDEF CIL}
    procedure DataSetEvent(Event: TDataEvent; Info: TObject); virtual;
{$ELSE}
    procedure DataSetEvent(Event: TDataEvent; Info: Integer); virtual;
{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    property FieldName: String read FFieldName write SetFieldName;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataSet: TDataSet read GetDataSet write SetDataSet;
    property Values: TStrings read GetValues;
  end;

{ TDesignControlerEh }

  TDesignControlerEh = class(TInterfacedObject)
  public
    function IsDesignHitTest(Control: TPersistent; X, Y: Integer; AShift: TShiftState): Boolean; virtual; abstract;
    function ControlIsObjInspSelected(Control: TPersistent): Boolean; virtual; abstract;
    function GetObjInspSelectedControl(BaseControl: TPersistent): TPersistent; virtual; abstract;
    function GetDesignInfoItemClass: TCollectionItemClass; virtual; abstract;
    function GetSelectComponentCornerImage: TBitmap; virtual; abstract;
    procedure DesignMouseDown(Control: TPersistent; X, Y: Integer; AShift: TShiftState); virtual; abstract;
    procedure RegisterChangeSelectedNotification(Control: TPersistent); virtual; abstract;
    procedure UnregisterChangeSelectedNotification(Control: TPersistent); virtual; abstract;
    procedure KeyProperyModified(Control: TControl); virtual; abstract;
  end;

  TLocateTextEventEh = function (Sender: TObject;
    const FieldName: string; const Text: String; Options: TLocateTextOptionsEh;
    Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
    TreeFindRange: TLocateTextTreeFindRangeEh): Boolean of object;

  TDrawButtonControlStyleEh = (bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh,
    bcsCheckboxEh, bcsPlusEh, bcsMinusEh, bcsAltDropDownEh, bcsAltUpDownEh);
  TTreeElementEh = (tehMinusUpDown, tehMinusUp, tehMinusDown, tehMinus,
                   tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus,
                   tehCrossUpDown, tehCrossUp, tehCrossDown,
                   tehVLine);


procedure PaintButtonControlEh(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Style: TDrawButtonControlStyleEh; DownButton: Integer;
  Flat, Active, Enabled: Boolean; State: TCheckBoxState);

function GetDefaultFlatButtonWidth: Integer;

var
  FlatButtonWidth: Integer;

type
 TFieldTypes = set of TFieldType;

const
  ftNumberFieldTypes: TFieldTypes = [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency,
    ftBCD{$IFDEF EH_LIB_6}, ftFMTBcd{$ENDIF}];

procedure GetFieldsProperty(List: TList; DataSet: TDataSet;
  Control: TComponent; const FieldNames: String); overload;

function GetFieldsProperty(DataSet: TDataSet; Control: TComponent;
  const FieldNames: String): TFieldsArrEh; overload;

procedure DataSetSetFieldValues(DataSet: TDataSet; Fields: String; Value: Variant);

function VarEquals(const V1, V2: Variant): Boolean;

{$IFNDEF EH_LIB_6}
type
  TVariantRelationship = (vrEqual, vrLessThan, vrGreaterThan, vrNotEqual);
{$ENDIF}

function DBVarCompareValue(const A, B: Variant): TVariantRelationship;

var UseButtonsBitmapCache: Boolean = True;

procedure ClearButtonsBitmapCache;

procedure DrawImage(DC: HDC; ARect: TRect; Images: TCustomImageList;
  ImageIndex: Integer; Selected: Boolean);
procedure DrawTreeElement(Canvas: TCanvas; ARect: TRect;
  TreeElement: TTreeElementEh; BackDot: Boolean; ScaleX, ScaleY: Double;
  RightToLeft: Boolean);

function AlignDropDownWindowRect(MasterAbsRect: TRect; DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
function AlignDropDownWindow(MasterWin, DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;

{$IFNDEF EH_LIB_5}
function Supports(const Instance: IUnknown; const IID: TGUID; out Intf): Boolean; overload;
function Supports(const Instance: TObject; const IID: TGUID; out Intf): Boolean; overload;
{$ENDIF}

var
  DefaultCheckBoxWidth, DefaultCheckBoxHeight: Integer;

function AdjustCheckBoxRect(ClientRect: TRect;  Alignment: TAlignment; Layout: TTextLayout): TRect;

function IsDoubleClickMessage(OldPos, NewPos: TPoint; Interval: Longint): Boolean;
function DefaultEditButtonHeight(EditButtonWidth: Integer; Flat: Boolean): Integer;

function KillMouseUp(Control: TControl): Boolean; overload;
function KillMouseUp(Control: TControl; Area: TRect): Boolean; overload;

procedure FillGradientEh(Canvas: TCanvas; ARect: Trect; FromColor, ToColor: TColor); overload;
procedure FillGradientEh(Canvas: TCanvas; TopLeft: TPoint; Points: array of TPoint; FromColor, ToColor: TColor); overload;
function ApproachToColorEh(FromColor, ToColor: TColor; Percent: Integer): TColor;
function ThemesEnabled: Boolean;

procedure BroadcastPerformMessageFor(Owner: TComponent; ForClass: TControlClass;
  Msg: Cardinal; WParam, LParam: Longint);

{$IFNDEF EH_LIB_8}

(*
{ GradientFill in AGradientDirection using the given colors in the given rect.
  GradientFill requires Windows 98, NT4 or better. }
type
  TGradientDirection = (gdHorizontal, gdVertical);

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);
*)

{$ENDIF}

implementation

uses DBConsts, Math,
  {$IFDEF EH_LIB_6} VDBConsts, Types, {$ENDIF}
  {$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
  {$IFDEF EH_LIB_12} RTLConsts, {$ENDIF}
  MultiMon;

type
  TWinControlCracker = class(TWinControl) end;
  TControlCracker = class(TControl) end;

procedure BroadcastPerformMessageFor(Owner: TComponent; ForClass: TControlClass;
  Msg: Cardinal; WParam, LParam: Longint);
var
  i: Integer;
begin
  for i := 0 to Owner.ComponentCount-1 do
  begin
    if Owner.Components[i] is ForClass then
    begin
      TControl(Owner.Components[i]).Perform(Msg, WParam, LParam);
    end;
    BroadcastPerformMessageFor(Owner.Components[i], ForClass, Msg, WParam, LParam);
  end;
end;

{$IFNDEF EH_LIB_5}

function Supports(const Instance: IUnknown; const IID: TGUID; out Intf): Boolean; overload;
begin
  Result := (Instance <> nil) and (Instance.QueryInterface(IID, Intf) = 0);
end;

function Supports(const Instance: TObject; const IID: TGUID; out Intf): Boolean; overload;
var
  LUnknown: IUnknown;
begin
  Result := (Instance <> nil) and
    ((Instance.GetInterface(IUnknown, LUnknown) and Supports(LUnknown, IID, Intf)) or
    Instance.GetInterface(IID, Intf));
end;

{$ENDIF}

function IsDoubleClickMessage(OldPos, NewPos: TPoint; Interval: Longint): Boolean;
begin
  Result := (Interval <= Longint(GetDoubleClickTime)) and
            (Abs(OldPos.X - NewPos.X) <= GetSystemMetrics(SM_CXDOUBLECLK)) and
            (Abs(OldPos.Y - NewPos.Y) <= GetSystemMetrics(SM_CYDOUBLECLK));
end;

procedure GetCheckSize;
begin
  with TBitmap.Create do
    try
      Handle := LoadBitmapEh(0, OBM_CHECKBOXES);
      DefaultCheckBoxWidth := Width div 4;
      DefaultCheckBoxHeight := Height div 3;
    finally
      Free;
    end;
end;

function AdjustCheckBoxRect(ClientRect: TRect;  Alignment: TAlignment; Layout: TTextLayout): TRect;
var
  CheckWidth, CheckHeight: Integer;
begin
  if (ClientRect.Right - ClientRect.Left) > DefaultCheckBoxWidth
    then CheckWidth := DefaultCheckBoxWidth
    else CheckWidth := ClientRect.Right - ClientRect.Left;

  if (ClientRect.Bottom - ClientRect.Top) > DefaultCheckBoxHeight
    then CheckHeight := DefaultCheckBoxHeight
    else CheckHeight := ClientRect.Bottom - ClientRect.Top;


  Result := ClientRect;

  if (ClientRect.Right - ClientRect.Left) > DefaultCheckBoxWidth then
    case Alignment of
      taRightJustify: Result.Left := Result.Right - CheckWidth;
      taCenter: Result.Left := Result.Left + (ClientRect.Right - ClientRect.Left) shr 1 - CheckWidth shr 1;
    end;
  Result.Right := Result.Left + CheckWidth;

  if (ClientRect.Bottom - ClientRect.Top) > DefaultCheckBoxHeight then
    case Layout of
      tlBottom: Result.Top := Result.Bottom - CheckWidth;
      tlCenter: Result.Top := Result.Top + (ClientRect.Bottom - ClientRect.Top) shr 1 - CheckHeight shr 1;
    end;
  Result.Bottom := Result.Top + CheckHeight;
end;

procedure DrawCheck(DC: HDC; R: TRect; AState: TCheckBoxState; AEnabled, AFlat, ADown, AActive: Boolean);
var
  DrawState, oldRgn: Integer;
  DrawRect: TRect;
//  OldBrushColor: TColor;
//  OldBrushStyle: TBrushStyle;
//  OldPenColor: TColor;
  Rgn, SaveRgn: HRgn;
{$IFDEF EH_LIB_7}
  ElementDetails: TThemedElementDetails;
{$ENDIF}
//  Brush,SaveBrush: HBRUSH;
begin
  SaveRgn := 0;
  oldRgn := 0;
  DrawRect := R;
  with DrawRect do
    if (Right - Left) > (Bottom - Top) then
    begin
      Left := Left + ((Right - Left) - (Bottom - Top)) div 2;
      Right := Left + (Bottom - Top);
    end else if (Right - Left) < (Bottom - Top) then
    begin
      Top := Top + ((Bottom - Top) - (Right - Left)) div 2;
      Bottom := Top + (Right - Left);
    end;
  case AState of
    cbChecked:
      DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
    cbUnchecked:
      DrawState := DFCS_BUTTONCHECK;
  else // cbGrayed
    DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
  end;
  if not AEnabled then
    DrawState := DrawState or DFCS_INACTIVE;
  if ADown then
    DrawState := DrawState or DFCS_PUSHED;
//  with Canvas do
//  begin
  if AFlat then
  begin
      { Remember current clipping region }
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    oldRgn := GetClipRgn(DC, SaveRgn);
      { Clip 3d-style checkbox to prevent flicker }
    with DrawRect do
      Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
    SelectClipRgn(DC, Rgn);
    DeleteObject(Rgn);
  end;
  if AFlat then InflateRect(DrawRect, 1, 1);

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    case AState of
      cbChecked:
        if AEnabled then
          ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxCheckedNormal)
        else
          ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxCheckedDisabled);
      cbUnchecked:
        if AEnabled then
          ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxUncheckedNormal)
        else
          ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxUncheckedDisabled)
      else // cbGrayed
        if AEnabled then
          ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxMixedNormal)
        else
          ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxMixedDisabled);
    end;
    ThemeServices.DrawElement(DC, ElementDetails, R);
  end
  else
{$ENDIF}
    DrawFrameControl(DC, DrawRect, DFC_BUTTON, DrawState);

  if AFlat then
  begin
      //SelectClipRgn(Handle, SaveRgn);
    if oldRgn = 0 then
      SelectClipRgn(DC, 0)
    else
      SelectClipRgn(DC, SaveRgn);
    DeleteObject(SaveRgn);
      { Draw flat rectangle in-place of clipped 3d checkbox above }
    InflateRect(DrawRect, -1, -1);
    if AActive
      then FrameRect(DC, DrawRect, GetSysColorBrush(COLOR_BTNFACE))
      else FrameRect(DC, DrawRect, GetSysColorBrush(COLOR_BTNSHADOW));

    { Caller drow in flat mode
    InflateRect(DrawRect, 1, 1);
    if AActive
      then DrawEdge(DC, DrawRect, BDR_SUNKENOUTER, BF_RECT)
      else FrameRect(DC, DrawRect, GetCurrentObject(DC, OBJ_BRUSH));}
  end;
//  end;
end;

const
  DownFlags: array[Boolean] of Integer = (0, DFCS_PUSHED {? or DFCS_FLAT});
  FlatFlags: array[Boolean] of Integer = (0, DFCS_FLAT);
  EnabledFlags: array[Boolean] of Integer = (DFCS_INACTIVE, 0);
  IsDownFlags: array[Boolean] of Integer = (DFCS_SCROLLUP, DFCS_SCROLLDOWN);
  PressedFlags: array[Boolean] of Integer = (EDGE_RAISED, EDGE_SUNKEN);

procedure DrawEllipsisButton(Canvas: TCanvas; ARect: TRect; Enabled, Active, Flat, Pressed: Boolean);
var
  InterP, PWid, W, H: Integer;
  ElRect: TRect;
  Brush, SaveBrush: HBRUSH;
{$IFDEF EH_LIB_7}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
  FromColor, ToColor: TColor;
  Points: array of TPoint;
  i: Integer;
begin
  ElRect := ARect;

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if Pressed then
        Button := tbPushButtonPressed
      else
        if Active
          then Button := tbPushButtonHot
          else Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
//          Toolbutton := ttbButtonNormal;
//          Toolbutton := ttbButtonChecked;
          Toolbutton := ttbButtonHot;
      end;
    end;

    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);

      InflateRect(ElRect, -2, -2);
    end else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      InflateRect(ElRect, -1, -1)
      InflateRect(ElRect, -2, -2);
    end;
  end else
{$ENDIF}
  begin
    Brush := GetSysColorBrush(COLOR_BTNFACE);
    if Flat then
    begin
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
      //Windows.FillRect(DC, ElRect, Brush);
    end;
  end;

  InterP := 2;
  PWid := 2;
  W := ElRect.Right - ElRect.Left; //+ Ord(not Active and Flat);
  if W < 12 then InterP := 1;
  if W < 8 then PWid := 1;
  W := ElRect.Left + W div 2 - PWid div 2 + Ord(Pressed); //- Ord(not Active and Flat);
  H := ElRect.Top + (ElRect.Bottom - ElRect.Top) div 2 - PWid div 2 + Ord(Pressed);

  if not Enabled then
  begin
    Inc(W); Inc(H);
    Brush := GetSysColorBrush(COLOR_BTNHILIGHT);
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W - InterP - PWid, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W + InterP + PWid, H, PWid, PWid, PATCOPY);
    Dec(W); Dec(H);
    SelectObject(Canvas.Handle, SaveBrush);
    Brush := GetSysColorBrush(COLOR_BTNSHADOW);
  end else
    Brush := GetSysColorBrush(COLOR_BTNTEXT);

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    SetLength(Points, PWid*2);
    for i := 0 to PWid-1 do
    begin
      Points[i*2] := Point(0,i);
      Points[i*2+1] := Point(PWid,i);
    end;
    FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
    FillGradientEh(Canvas, Point(W - InterP - PWid, H), Points, FromColor, ToColor);
    FillGradientEh(Canvas, Point(W + InterP + PWid, H), Points, FromColor, ToColor);
  end else
  begin
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W - InterP - PWid, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W + InterP + PWid, H, PWid, PWid, PATCOPY);
    SelectObject(Canvas.Handle, SaveBrush);
  end;
end;

procedure DrawPlusMinusButton(Canvas: TCanvas; ARect: TRect; Enabled, Active, Flat, Pressed, Plus: Boolean);
var PWid, PHet, W, H, PlusInd, MinWH: Integer;
  ElRect: TRect;
  Brush, SaveBrush: HBRUSH;
{$IFDEF EH_LIB_7}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
  FromColor, ToColor: TColor;
  Points: array of TPoint;
  i,iv: Integer;
begin
  ElRect := ARect;

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if Pressed then
        Button := tbPushButtonPressed
      else
        if Active
          then Button := tbPushButtonHot
          else Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
//          Toolbutton := ttbButtonNormal;
//          Toolbutton := ttbButtonChecked;
          Toolbutton := ttbButtonHot;
      end;
    end;

    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      ARect := ThemeServices.ContentRect(DC, Details, ARect);
      InflateRect(ElRect, -2, -2);
    end else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      InflateRect(ElRect, -1, -1)
      InflateRect(ElRect, -2, -2);
//      ARect := ThemeServices.ContentRect(DC, Details, ARect);
    end;
  end else
{$ENDIF}
  begin
    Brush := GetSysColorBrush(COLOR_BTNFACE);
    if Flat then
    begin
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
    end;
  end;

  MinWH := ElRect.Right - ElRect.Left; //+ Ord(not Active and Flat);
  if ElRect.Bottom - ElRect.Top < MinWH then
    MinWH := ElRect.Bottom - ElRect.Top;
  PWid := MinWH * 4 div 7;
  if PWid = 0 then PWid := 1;
  PHet := PWid div 3;
  if PHet = 0 then PHet := 1;
  if Flat then Dec(PWid);
  if PWid mod 2 <> MinWH mod 2 then Inc(PWid);
  if Plus and (PWid mod 2 <> PHet mod 2) then
    if (MinWH < 12) then Inc(PWid) else Dec(PWid);
  PlusInd := PWid div 2 - PHet div 2;

  W := ElRect.Left + (ElRect.Right - ElRect.Left - PWid) div 2; //- Ord(not Active and Flat);
  //if W * 2 + PWid > (ElRect.Right - ElRect.Left) then Dec(W);
  Inc(W, Ord(Pressed));
  H := ElRect.Top + (ElRect.Bottom - ElRect.Top - PHet) div 2 + Ord(Pressed);

  if not Enabled then
  begin
    Inc(W); Inc(H);
    Brush := GetSysColorBrush(COLOR_BTNHILIGHT);
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PHet, PATCOPY);
    if Plus then PatBlt(Canvas.Handle, W + PlusInd, H - PlusInd, PHet, PWid, PATCOPY);
    Dec(W); Dec(H);
    SelectObject(Canvas.Handle, SaveBrush);
    Brush := GetSysColorBrush(COLOR_BTNSHADOW);
  end else
    Brush := GetSysColorBrush(COLOR_BTNTEXT);

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    if Plus
      then SetLength(Points, PHet*2+PlusInd*2+PlusInd*2)
      else SetLength(Points, PHet*2);
    iv := -1;
    if Plus then
      for i := 0 to PHet-1 do
      begin
        Points[i*2] := Point(PlusInd, i);
        Points[i*2+1] := Point(PlusInd+PHet, i);
        iv := i;
      end;
    for i := iv+1 to iv+PHet do
    begin
      Points[i*2] := Point(0,i);
      Points[i*2+1] := Point(PWid, i);
      iv := i;
    end;
    if Plus then
      for i := iv+1 to iv+PHet do
      begin
        Points[i*2] := Point(PlusInd,i);
        Points[i*2+1] := Point(PlusInd+PHet, i);
      end;
    if Plus then
      FillGradientEh(Canvas, Point(W, H-PlusInd), Points, FromColor, ToColor)
    else
      FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
  end else
  begin
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PHet, PATCOPY);
    if Plus then PatBlt(Canvas.Handle, W + PlusInd, H - PlusInd, PHet, PWid, PATCOPY);
    SelectObject(Canvas.Handle, SaveBrush);
  end;
end;

procedure DrawOneCustomButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Active, Flat, Pressed: Boolean; DownDirection: Boolean);
var
  {InterP,} PWid, W, H: Integer;
  AWidth, AHeight, ASize: Integer;
  ElRect: TRect;
  Brush{, SaveBrush}: HBRUSH;
{$IFDEF EH_LIB_7}
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
{$ENDIF}
  FromColor, ToColor, TmpColor: TColor;
  Points: array of TPoint;
  i: Integer;
begin
  if (Style = bcsAltUpDownEh) and ThemesEnabled then
    if DownDirection
      then Dec(ARect.Top)
      else Inc(ARect.Bottom);
  ElRect := ARect;

{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if Pressed then
        Button := tbPushButtonPressed
      else
        if Active
          then Button := tbPushButtonHot
          else Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if Flat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
//          Toolbutton := ttbButtonNormal;
//          Toolbutton := ttbButtonChecked;
          Toolbutton := ttbButtonHot;
      end;
    end;

    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);

//      ARect := ThemeServices.ContentRect(DC, Details, ARect);
      InflateRect(ElRect, -2, -2);
    end else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
//      InflateRect(ElRect, -1, -1)
      InflateRect(ElRect, -2, -2);
//      ARect := ThemeServices.ContentRect(DC, Details, ARect);
    end;
  end else
{$ENDIF}
  begin
    Brush := GetSysColorBrush(COLOR_BTNFACE);
    if Flat then
    begin
      Windows.FillRect(Canvas.Handle, ElRect, Brush);
      InflateRect(ElRect, -1, -1)
    end else
    begin
      DrawEdge(Canvas.Handle, ElRect, PressedFlags[Pressed], BF_RECT or BF_MIDDLE);
      InflateRect(ElRect, -2, -2);
      //Windows.FillRect(DC, ElRect, Brush);
    end;
  end;

//  InterP := 2;
//  PWid := 2;
//  W := ElRect.Right - ElRect.Left; //+ Ord(not Active and Flat);
//  if W < 12 then InterP := 1;
//  if W < 8 then PWid := 1;
//  W := ElRect.Left + W div 2 - PWid div 2 + Ord(Pressed); //- Ord(not Active and Flat);
//  H := ElRect.Top + (ElRect.Bottom - ElRect.Top) div 2 - PWid div 2 + Ord(Pressed);

{  if not Enabled then
  begin
    Inc(W); Inc(H);
    Brush := GetSysColorBrush(COLOR_BTNHILIGHT);
    SaveBrush := SelectObject(Canvas.Handle, Brush);
    PatBlt(Canvas.Handle, W, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W - InterP - PWid, H, PWid, PWid, PATCOPY);
    PatBlt(Canvas.Handle, W + InterP + PWid, H, PWid, PWid, PATCOPY);
    Dec(W); Dec(H);
    SelectObject(Canvas.Handle, SaveBrush);
    Brush := GetSysColorBrush(COLOR_BTNSHADOW);
  end else
    Brush := GetSysColorBrush(COLOR_BTNTEXT);}

  if ThemesEnabled then
  begin
    if Enabled then
    begin
      FromColor := ApproachToColorEh(cl3DDkShadow, clBlack, 30);
      ToColor := ApproachToColorEh(cl3DDkShadow, clWhite, 00);
    end else
    begin
      FromColor := ApproachToColorEh(clGrayText, clWhite, 00);
      ToColor := ApproachToColorEh(clGrayText, clWhite, 30);
    end;
    if not DownDirection then
    begin
      TmpColor := FromColor;
      FromColor := ToColor;
      ToColor := TmpColor;
    end;
  end else
  begin
    if Enabled then
    begin
      FromColor := clWindowText;
      ToColor := clWindowText;
    end else
    begin
      FromColor := clGrayText;
      ToColor := clGrayText;
    end
  end;

//  if Style = bcsAltDropDownEh then
  begin
    AWidth := ARect.Right-ARect.Left;
    AHeight := ARect.Bottom-ARect.Top;
    if AHeight < AWidth
      then ASize := AHeight
      else ASize := AWidth;
    if ASize >= 19 then
      PWid := 9
    else if ASize >= 16 then
      PWid := 7
    else if ASize >= 12 then
      PWid := 5
    else if not ThemesEnabled then
      PWid := 3
    else
      PWid := 5;

    SetLength(Points, (PWid div 2 + 1)*2);
    for i := 0 to PWid div 2 do
      if DownDirection then
      begin
        Points[i*2] := Point(i,i);
        Points[i*2+1] := Point(PWid-i,i);
      end else
      begin
        Points[i*2] := Point(PWid div 2 - i, i);
        Points[i*2+1] := Point(PWid div 2 + i + 1, i);
      end;
    W := (ARect.Right + ARect.Left - PWid) shr 1;
    H := (ARect.Top + ARect.Bottom - (PWid div 2 + 1)) shr 1;
  end;
  if Pressed then
  begin
    Inc(W); Inc(H);
  end;
  FillGradientEh(Canvas, Point(W, H), Points, FromColor, ToColor);
end;

procedure DrawCustomButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Active, Flat, Pressed, DownDirection: Boolean);
var
  ButtonRect1, ButtonRect2: TRect;
begin
  if Style = bcsAltDropDownEh then
    DrawOneCustomButton(Canvas, Style, ARect, Enabled, Active, Flat, Pressed, True)
  else if Style = bcsAltUpDownEh then
  begin
    ButtonRect1 := ARect;
    ButtonRect1.Bottom := (ARect.Bottom + ARect.Top) div 2;
    if ThemesEnabled then
      Inc(ButtonRect1.Bottom);
    DrawOneCustomButton(Canvas, Style, ButtonRect1, Enabled, Active, Flat, Pressed and not DownDirection, False);
    ButtonRect2 := ARect;
    ButtonRect2.Top := (ARect.Bottom + ARect.Top) div 2 + 1;
    if ThemesEnabled then
      Dec(ButtonRect2.Top);
    DrawOneCustomButton(Canvas, Style, ButtonRect2, Enabled, Active, Flat, Pressed and DownDirection, True);
  end;
end;

procedure DrawDropDownButton(DC: HDC; ARect: TRect; Enabled, Flat, Active, Down: Boolean);
var
  Flags: Integer;
{$IFDEF EH_LIB_7}
  Details: TThemedElementDetails;
{$ENDIF}
//  Rgn, SaveRgn: HRGN;
//  r: Integer;
//  IsClip: Boolean;
begin
{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if not Enabled then
      Details := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
    else
      if Down then
        Details := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
      else
        if Active
          then Details := ThemeServices.GetElementDetails(tcDropDownButtonHot)
          else Details := ThemeServices.GetElementDetails(tcDropDownButtonNormal);

{      with Details do
        GetThemeBackgroundRegion(ThemeServices.Theme[Element], DC, Part, State, ARect, Rgn);
      IsClip := False;
      SaveRgn := 0;
      r := 0;
      if Rgn <> 0 then
      begin
        IsClip := True;
        SaveRgn := CreateRectRgn(0, 0, 0, 0);
        r := GetClipRgn(DC, SaveRgn);
        SelectClipRgn(DC, Rgn);
        DeleteObject(Rgn);
      end;}

    ThemeServices.DrawElement(DC, Details, ARect);

{      if IsClip = True then
      begin
        if r = 0
          then SelectClipRgn(DC, 0)
          else SelectClipRgn(DC, SaveRgn);
        DeleteObject(SaveRgn);
      end;}

  end else
{$ENDIF}
  begin
    Flags := DownFlags[Down] or FlatFlags[Flat] or EnabledFlags[Enabled];
    DrawFrameControl(DC, ARect, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
  end;
end;

procedure DrawUpDownButton(Canvas: TCanvas; ARect: TRect; Enabled, Flat, Active, Down, DownDirection: Boolean);
var
  Flags: Integer;
{$IFDEF EH_LIB_7}
  Details: TThemedElementDetails;
{$ENDIF}
begin
{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled then
  begin
    if DownDirection then
      if not Enabled then
        Details := ThemeServices.GetElementDetails(tsDownDisabled)
      else
        if Down then
          Details := ThemeServices.GetElementDetails(tsDownPressed)
        else
          if Active
            then Details := ThemeServices.GetElementDetails(tsDownHot)
            else Details := ThemeServices.GetElementDetails(tsDownNormal)
    else
      if not Enabled then
        Details := ThemeServices.GetElementDetails(tsUpDisabled)
      else
        if Down then
          Details := ThemeServices.GetElementDetails(tsUpPressed)
        else
          if Active
            then Details := ThemeServices.GetElementDetails(tsUpHot)
            else Details := ThemeServices.GetElementDetails(tsUpNormal);
    ThemeServices.DrawElement(Canvas.Handle, Details, ARect);
  end else
{$ENDIF}
  begin
    Flags := DownFlags[Down] or FlatFlags[Flat] or EnabledFlags[Enabled];
    DrawFrameControl(Canvas.Handle, ARect, DFC_SCROLL, Flags or IsDownFlags[DownDirection]);
  end;
end;

procedure DrawOneButton(Canvas: TCanvas; Style: TDrawButtonControlStyleEh;
  ARect: TRect; Enabled, Flat, Active, Down, DownDirection: Boolean);
var
  Rgn, SaveRgn: HRgn;
  r: Integer;
  IsClipRgn: Boolean;
  DRect: TRect;
//    Brush: HBRUSH;
begin
  DRect := ARect;
//  LPtoDP(DC, DRect, 2);
  WindowsLPtoDP(Canvas.Handle, DRect);

{$IFDEF EH_LIB_7}
  IsClipRgn := Flat and Active and not ThemeServices.ThemesEnabled;
{$ELSE}
  IsClipRgn := Flat and Active;
{$ENDIF}
  r := 0; SaveRgn := 0;
  if IsClipRgn then
  begin
    SaveRgn := CreateRectRgn(0, 0, 0, 0);
    r := GetClipRgn(Canvas.Handle, SaveRgn);
    with DRect do
      Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
    SelectClipRgn(Canvas.Handle, Rgn);
    DeleteObject(Rgn);
  end;

  if Flat {$IFDEF EH_LIB_7} and not ThemeServices.ThemesEnabled {$ENDIF} then
    if not Active {and not (Style=bcsUpDownEh)}
      then InflateRect(ARect, 2, 2)
      else InflateRect(ARect, 1, 1);
  case Style of
    bcsDropDownEh: DrawDropDownButton(Canvas.Handle, ARect, Enabled, Flat, Active, Down);
    bcsEllipsisEh: DrawEllipsisButton(Canvas, ARect, Enabled, Active, Flat, Down);
    bcsUpDownEh: DrawUpDownButton(Canvas, ARect, Enabled, Flat, Active, Down, DownDirection);
    bcsMinusEh, bcsPlusEh: DrawPlusMinusButton(Canvas, ARect, Enabled, Active, Flat, Down, bcsPlusEh = Style);
    bcsAltDropDownEh: DrawCustomButton(Canvas, Style, ARect, Enabled, Active, Flat, Down, False);
    bcsAltUpDownEh: DrawOneCustomButton(Canvas, Style, ARect, Enabled, Active, Flat, Down, DownDirection);
  end;
  if Flat then
    if not Active {and not (Style=bcsUpDownEh)}
      then InflateRect(ARect, -2, -2)
      else InflateRect(ARect, -1, -1);

  if IsClipRgn then
  begin
    if r = 0
      then SelectClipRgn(Canvas.Handle, 0)
      else SelectClipRgn(Canvas.Handle, SaveRgn);
    DeleteObject(SaveRgn);
    if Down
      then DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
      else DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_RECT)
  end;
end;

type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;

  TButtonBitmapInfoEh = record
    Size: TPoint;
    BitmapType: TDrawButtonControlStyleEh;
    Flat: Boolean;
    Pressed: Boolean;
    Active: Boolean;
    Enabled: Boolean;
    DownDirect: Boolean;
    CheckState: TCheckBoxState;
  end;

  function CompareButtonBitmapInfo(Info1, Info2: TButtonBitmapInfoEh): Boolean;
  begin
    Result := (Info1.Size.X = Info2.Size.X) and (Info1.Size.Y = Info2.Size.Y)
      and (Info1.BitmapType = Info2.BitmapType)
      and (Info1.Flat = Info2.Flat)
      and (Info1.Pressed = Info2.Pressed)
      and (Info1.Active = Info2.Active)
      and (Info1.Enabled = Info2.Enabled)
      and (Info1.DownDirect = Info2.DownDirect)
      and (Info1.CheckState = Info2.CheckState);
  end;

type

  { TButtonsBitmapCache }

  TButtonBitmapInfoBitmapEh = class(TObject)
  public
    BitmapInfo: TButtonBitmapInfoEh;
    Bitmap: TBitmap;
  end;

//  PButtonBitmapInfoBitmapEh = ^TButtonBitmapInfoBitmapEh;

  TButtonsBitmapCache = class(TObjectList)
  private
    function Get(Index: Integer): TButtonBitmapInfoBitmapEh;
//    procedure Put(Index: Integer; const Value: PButtonBitmapInfoBitmapEh);
  public
    constructor Create; overload;
    procedure Clear; override;
    function GetButtonBitmap(ButtonBitmapInfo: TButtonBitmapInfoEh): TBitmap;
    property Items[Index: Integer]: TButtonBitmapInfoBitmapEh read Get {write Put}; default;
  end;

var ButtonsBitmapCache: TButtonsBitmapCache;

procedure ClearButtonsBitmapCache;
begin
  ButtonsBitmapCache.Clear;
end;

function RectSize(ARect: TRect): TSize;
begin
  Result.cx := ARect.Right - ARect.Left;
  Result.cy := ARect.Bottom - ARect.Top;
end;

procedure PaintButtonControlEh(Canvas: TCanvas; ARect: TRect; ParentColor: TColor;
  Style: TDrawButtonControlStyleEh; DownButton: Integer;
  Flat, Active, Enabled: Boolean; State: TCheckBoxState);
var
  Rgn, SaveRgn: HRgn;
  HalfRect, DRect: TRect;
  ASize: TSize;
  r: Integer;
  Brush: HBRUSH;
  IsClipRgn: Boolean;
  BitmapInfo: TButtonBitmapInfoEh;
  Bitmap: TBitmap;
begin
  SaveRgn := 0; r := 0;
{$IFDEF EH_LIB_7}
  if (Style = bcsCheckboxEh) and ThemeServices.ThemesEnabled then
    Flat := False;
{$ENDIF}
//  FillChar(BitmapInfo, Sizeof(BitmapInfo), #0);
  BitmapInfo.BitmapType := Style;
  BitmapInfo.Flat := Flat;

  if Style = bcsCheckboxEh then
  begin
    ASize := RectSize(ARect);
    if ASize.cx < ASize.cy then
    begin
      ARect.Top := ARect.Top + (ASize.cy - ASize.cx) div 2;
      ARect.Bottom := ARect.Bottom - (ASize.cy - ASize.cx) div 2 - (ASize.cy - ASize.cx) mod 2;
    end else if ASize.cx > ASize.cy then
    begin
      ARect.Left := ARect.Left + (ASize.cx - ASize.cy) div 2;
      ARect.Right := ARect.Right - (ASize.cx - ASize.cy) div 2 - (ASize.cx - ASize.cy) mod 2;
    end;

    if Flat then InflateRect(ARect, -1, -1);
    if UseButtonsBitmapCache then
    begin
      BitmapInfo.Size := Point(ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      BitmapInfo.CheckState := State;
      BitmapInfo.Pressed := DownButton <> 0;
      BitmapInfo.Active := Active;
      BitmapInfo.Enabled := Enabled;
      Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);

      StretchBlt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left,
        ARect.Bottom - ARect.Top, Bitmap.Canvas.Handle, 0, 0,
        Bitmap.Width, Bitmap.Height, cmSrcCopy);
    end else
      DrawCheck(Canvas.Handle, ARect, State, Enabled, Flat, DownButton <> 0, Active);

    if Flat then
    begin
      InflateRect(ARect, 1, 1);
      if Active then
        DrawEdge(Canvas.Handle, ARect, BDR_SUNKENOUTER, BF_RECT)
      else
      begin
//        FrameRect(DC, ARect, GetCurrentObject(DC, OBJ_BRUSH));
        Brush := CreateSolidBrush(ColorToRGB(ParentColor));
        FrameRect(Canvas.Handle, ARect, Brush);
        DeleteObject(Brush);
      end;
    end;
  end else
  begin
    BitmapInfo.Active := Active;
    BitmapInfo.Enabled := Enabled;

{$IFDEF EH_LIB_7}
    IsClipRgn := Flat and not Active and not ThemeServices.ThemesEnabled;
{$ELSE}
    IsClipRgn := Flat and not Active;
{$ENDIF}
    if IsClipRgn then
    begin
      DRect := ARect;
      WindowsLPtoDP(Canvas.Handle, DRect);
      InflateRect(ARect, -1, -1);
      if not UseButtonsBitmapCache then
      begin
        SaveRgn := CreateRectRgn(0, 0, 0, 0);
        r := GetClipRgn(Canvas.Handle, SaveRgn);
        with DRect do
          Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
        SelectClipRgn(Canvas.Handle, Rgn);
        DeleteObject(Rgn);
      end;
    end;

    if Style in [bcsUpDownEh, bcsAltUpDownEh] then
    begin
      if IsClipRgn then InflateRect(ARect, 1, 1);
      HalfRect := ARect;
      with HalfRect do
        Bottom := Top + (Bottom - Top) div 2;
      if IsClipRgn then InflateRect(HalfRect, -1, -1);
      if UseButtonsBitmapCache then
      begin
        BitmapInfo.Size := Point(HalfRect.Right - HalfRect.Left, HalfRect.Bottom - HalfRect.Top);
        BitmapInfo.Pressed := DownButton = 1;
        BitmapInfo.DownDirect := False;
        Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
        StretchBlt(Canvas.Handle, HalfRect.Left, HalfRect.Top, HalfRect.Right - HalfRect.Left,
          HalfRect.Bottom - HalfRect.Top, Bitmap.Canvas.Handle, 0, 0,
          Bitmap.Width, Bitmap.Height, cmSrcCopy);
      end else
        DrawOneButton(Canvas, Style, HalfRect, Enabled, Flat, Active, DownButton = 1, False);
      if IsClipRgn then InflateRect(HalfRect, 1, 1);
      HalfRect.Bottom := ARect.Bottom;
      with HalfRect do
        Top := Bottom - (Bottom - Top) div 2;
      if IsClipRgn then InflateRect(HalfRect, -1, -1);
      if UseButtonsBitmapCache then
      begin
        BitmapInfo.Size := Point(HalfRect.Right - HalfRect.Left, HalfRect.Bottom - HalfRect.Top);
        BitmapInfo.Pressed := DownButton = 2;
        BitmapInfo.DownDirect := True;
        Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
        StretchBlt(Canvas.Handle, HalfRect.Left, HalfRect.Top, HalfRect.Right - HalfRect.Left,
          HalfRect.Bottom - HalfRect.Top, Bitmap.Canvas.Handle, 0, 0,
          Bitmap.Width, Bitmap.Height, cmSrcCopy);
      end else
        DrawOneButton(Canvas, Style, HalfRect, Enabled, Flat, Active, DownButton = 2, True);
      if IsClipRgn
        then InflateRect(ARect, -1, -1);
      if ((ARect.Bottom - ARect.Top) mod 2 = 1) or (IsClipRgn) then
      begin
        HalfRect := ARect;
        HalfRect.Top := (HalfRect.Bottom + HalfRect.Top) div 2;
        HalfRect.Bottom := HalfRect.Top;
        if (ARect.Bottom - ARect.Top) mod 2 = 1 then Inc(HalfRect.Bottom);
        if IsClipRgn then InflateRect(HalfRect, 0, 1);
        Brush := CreateSolidBrush(ColorToRGB(ParentColor));
        FillRect(Canvas.Handle, HalfRect, Brush);
        DeleteObject(Brush);
      end;
    end else if UseButtonsBitmapCache then
    begin
      BitmapInfo.Size := Point(ARect.Right - ARect.Left, ARect.Bottom - ARect.Top);
      BitmapInfo.Pressed := DownButton <> 0;
      Bitmap := ButtonsBitmapCache.GetButtonBitmap(BitmapInfo);
      StretchBlt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left,
        ARect.Bottom - ARect.Top, Bitmap.Canvas.Handle, 0, 0,
        Bitmap.Width, Bitmap.Height, cmSrcCopy);
    end else
      DrawOneButton(Canvas, Style, ARect, Enabled, Flat, Active, DownButton <> 0, True);

    if IsClipRgn then
    begin
      InflateRect(ARect, 1, 1);
      if not UseButtonsBitmapCache then
      begin
        if r = 0
          then SelectClipRgn(Canvas.Handle, 0)
          else SelectClipRgn(Canvas.Handle, SaveRgn);
        DeleteObject(SaveRgn);
      end;
      Brush := CreateSolidBrush(ColorToRGB(ParentColor));
      FrameRect(Canvas.Handle, ARect, Brush);
      DeleteObject(Brush);
    end;
  end;
end;

function GetDefaultFlatButtonWidth: Integer;
var
  DC: HDC;
  SysMetrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  ReleaseDC(0, DC);
  Result := Round(SysMetrics.tmHeight / 3 * 2);
  if ThemesEnabled then
  begin
    if Result mod 2 = 1 then Inc(Result);
  end else
  begin
    if Result mod 2 = 0 then Inc(Result);
  end;
  if Result > GetSystemMetrics(SM_CXVSCROLL)
    then Result := GetSystemMetrics(SM_CXVSCROLL);
end;

function DefaultEditButtonHeight(EditButtonWidth: Integer; Flat: Boolean): Integer;
begin
  if Flat
    then Result := Round(EditButtonWidth * 3 / 2)
    else Result := EditButtonWidth;
end;

//{$DEBUGINFO OFF}
function VarEquals(const V1, V2: Variant): Boolean;
var
  i: Integer;
begin
  Result := not (VarIsArray(V1) xor VarIsArray(V2));
  if not Result then Exit;
  Result := False;
  try
    if VarIsArray(V1) and VarIsArray(V2) and
      (VarArrayDimCount(V1) = VarArrayDimCount(V2)) and
      (VarArrayLowBound(V1, 1) = VarArrayLowBound(V2, 1)) and
      (VarArrayHighBound(V1, 1) = VarArrayHighBound(V2, 1))
      then
      for i := VarArrayLowBound(V1, 1) to VarArrayHighBound(V1, 1) do
      begin
        Result := V1[i] = V2[i];
        if not Result then Exit;
      end
    else
      begin
        Result := not (VarIsEmpty(V1) xor VarIsEmpty(V2));
        if not Result
          then Exit
          else Result := (V1 = V2);
      end;
  except
  end;
end;
//{$DEBUGINFO ON}


{$IFNDEF EH_LIB_6}

function VarCompareValue(const A, B: Variant): TVariantRelationship;
const
  CTruth: array [Boolean] of TVariantRelationship = (vrNotEqual, vrEqual);
var
  LA, LB: TVarData;
begin
  LA := TVarData(A);
  LB := TVarData(B);
  if LA.VType = varEmpty then
    Result := CTruth[LB.VType = varEmpty]
  else if LA.VType = varNull then
    Result := CTruth[LB.VType = varNull]
  else if LB.VType in [varEmpty, varNull] then
    Result := vrNotEqual
  else if A = B then
    Result := vrEqual
  else if A < B then
    Result := vrLessThan
  else
    Result := vrGreaterThan;
end;

{$ENDIF}

function DBVarCompareOneValue(const A, B: Variant): TVariantRelationship;
begin
  if VarIsNull(A) and VarIsNull(B) then
    Result := vrEqual
  else if VarIsNull(A) then
    Result := vrLessThan
  else if VarIsNull(B) then
    Result := vrGreaterThan
  else Result := VarCompareValue(A, B);
end;

function DBVarCompareValue(const A, B: Variant): TVariantRelationship;
var
  i: Integer;
  IsComparable: Boolean;
begin
  Result := vrNotEqual;
  IsComparable := not (VarIsArray(A) xor VarIsArray(B));
  if not IsComparable then Exit;
  if VarIsArray(A) and VarIsArray(B) and
    (VarArrayDimCount(A) = VarArrayDimCount(B)) and
    (VarArrayLowBound(A, 1) = VarArrayLowBound(B, 1)) and
    (VarArrayHighBound(A, 1) = VarArrayHighBound(B, 1))
    then
    for i := VarArrayLowBound(A, 1) to VarArrayHighBound(A, 1) do
    begin
      Result := DBVarCompareOneValue(A[i], B[i]);
      if Result <> vrEqual then Exit;
    end
  else
    Result := DBVarCompareOneValue(A, B);
end;

function GetRGBColor(Value: TColor): DWORD;
begin
  Result := ColorToRGB(Value);
  case Result of
    clNone: Result := CLR_NONE;
    clDefault: Result := CLR_DEFAULT;
  end;
end;

procedure DrawImage(DC: HDC; ARect: TRect; Images: TCustomImageList;
  ImageIndex: Integer; Selected: Boolean);
const
  ImageTypes: array[TImageType] of Longint = (0, ILD_MASK);
  ImageSelTypes: array[Boolean] of Longint = (0, ILD_SELECTED);
var CheckedRect, AUnionRect: TRect;
  OldRectRgn, RectRgn: HRGN;
  r, x, y: Integer;
  procedure DrawIm;
  var ABlendColor: TColor;
  begin
    with Images do
      if HandleAllocated then
      begin
        if Selected then ABlendColor := clHighlight
        else ABlendColor := BlendColor;
        ImageList_DrawEx(Handle, ImageIndex, DC, x, y, 0, 0,
          GetRGBColor(BkColor), GetRGBColor(ABlendColor),
          ImageTypes[ImageType] or ImageSelTypes[Selected]);
      end;
  end;
begin
  with Images do
  begin
    x := (ARect.Right + ARect.Left - Images.Width) div 2;
    y := (ARect.Bottom + ARect.Top - Images.Height) div 2;
    CheckedRect := Rect(X, Y, X + Images.Width, Y + Images.Height);
    UnionRect(AUnionRect, CheckedRect, ARect);
    if EqualRect(AUnionRect, ARect) then // ARect containt image
      DrawIm
    else
    begin // Need clip
      OldRectRgn := CreateRectRgn(0, 0, 0, 0);
      r := GetClipRgn(DC, OldRectRgn);
      RectRgn := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      SelectClipRgn(DC, RectRgn);
      DeleteObject(RectRgn);

      DrawIm;

      if r = 0
        then SelectClipRgn(DC, 0)
        else SelectClipRgn(DC, OldRectRgn);
      DeleteObject(OldRectRgn);
    end;
  end;
end;

function AlignDropDownWindowRect(MasterAbsRect: TRect; DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
var
  P: TPoint;
  Y: Integer;
  WorkArea: TRect;
  MonInfo: TMonitorInfo;
begin
  P := MasterAbsRect.TopLeft;
  Y := P.Y + (MasterAbsRect.Bottom - MasterAbsRect.Top);

  MonInfo.cbSize := SizeOf(MonInfo);
{$IFDEF CIL}
  GetMonitorInfo(MonitorFromRect(MasterAbsRect, MONITOR_DEFAULTTONEAREST), MonInfo);
{$ELSE}
  GetMonitorInfo(MonitorFromRect(@MasterAbsRect, MONITOR_DEFAULTTONEAREST), @MonInfo);
{$ENDIF}
  WorkArea := MonInfo.rcWork;
//  SystemParametersInfo(SPI_GETWORKAREA, 0, Pointer(@WorkArea), 0);

  if ((Y + DropDownWin.Height > WorkArea.Bottom) and (P.Y - DropDownWin.Height >= WorkArea.Top)) or
    ((P.Y - DropDownWin.Height < WorkArea.Top) and (WorkArea.Bottom - Y < P.Y - WorkArea.Top))
    then
  begin
    if P.Y - DropDownWin.Height < WorkArea.Top then
      DropDownWin.Height := P.Y - WorkArea.Top;
    Y := P.Y - DropDownWin.Height;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToTop), 0);
  end else
  begin
    if Y + DropDownWin.Height > WorkArea.Bottom then
      DropDownWin.Height := WorkArea.Bottom - Y;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToBottom), 0);
  end;

  case Align of
    daRight: Dec(P.X, DropDownWin.Width - (MasterAbsRect.Right - MasterAbsRect.Left));
    daCenter: Dec(P.X, (DropDownWin.Width - (MasterAbsRect.Right - MasterAbsRect.Left)) div 2);
  end;

  if (DropDownWin.Width > WorkArea.Right - WorkArea.Left) then
    DropDownWin.Width := WorkArea.Right - WorkArea.Left;
  if (P.X + DropDownWin.Width > WorkArea.Right) then
  begin
    P.X := WorkArea.Right - DropDownWin.Width;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToLeft), 0);
  end
  else if P.X < WorkArea.Left then
  begin
    P.X := WorkArea.Left;
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToRight), 0);
  end else if Align = daRight then
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToLeft), 0)
  else
    DropDownWin.Perform(cm_SetSizeGripChangePosition, Ord(sgcpToRight), 0);

  Result := Point(P.X, Y);
end;

function AlignDropDownWindow(MasterWin, DropDownWin: TWinControl; Align: TDropDownAlign): TPoint;
var
  MasterAbsRect: TRect;
begin
  MasterAbsRect.TopLeft := MasterWin.Parent.ClientToScreen(Point(MasterWin.Left, MasterWin.Top));
  MasterAbsRect.Bottom := MasterAbsRect.Top + MasterWin.Height;
  MasterAbsRect.Right := MasterAbsRect.Left + MasterWin.Width;
  Result := AlignDropDownWindowRect(MasterAbsRect, DropDownWin, Align);
end;

type
  TIntArray = array[0..16384] of Integer;
  PIntArray = ^TIntArray;

procedure DrawDotLine(Canvas: TCanvas; FromPoint: TPoint; ALength: Integer;
  Along: Boolean; BackDot: Boolean);
var
  Points: array of TPoint;
  StrokeList: array of DWORD;
  DotWidth, DotCount, I: Integer;
begin
//  Canvas.Pen.Style
  if Along then
  begin
    if ((FromPoint.X mod 2) <> (FromPoint.Y mod 2)) xor BackDot then
    begin
      Inc(FromPoint.X);
      Dec(ALength);
    end;
  end else
  begin
    if ((FromPoint.X mod 2) <> (FromPoint.Y mod 2)) xor BackDot then
    begin
      Inc(FromPoint.Y);
      Dec(ALength);
    end;
  end;

  DotWidth := Canvas.Pen.Width;
  DotCount := ALength div (2 * DotWidth);
  if DotCount < 0 then Exit;
  if ALength mod 2 <> 0 then
    Inc(DotCount);
  SetLength(Points, DotCount * 2); // two points per stroke
  SetLength(StrokeList, DotCount);
  for I := 0 to DotCount - 1 do
    StrokeList[I] := 2;
  if Along then
    for I := 0 to DotCount - 1 do
    begin
      Points[I * 2] := Point(FromPoint.X, FromPoint.Y);
      Points[I * 2 + 1] := Point(FromPoint.X + 1, FromPoint.Y);
      Inc(FromPoint.X, (2 * DotWidth));
    end
  else
    for I := 0 to DotCount - 1 do
    begin
      Points[I * 2] := Point(FromPoint.X, FromPoint.Y);
      Points[I * 2 + 1] := Point(FromPoint.X, FromPoint.Y + 1);
      Inc(FromPoint.Y, (2 * DotWidth));
    end;

{$IFDEF CIL}
  PolyPolyLine(Canvas.Handle, Points, StrokeList, DotCount);
{$ELSE}
  PolyPolyLine(Canvas.Handle, PIntArray(Points)^, PIntArray(StrokeList)^, DotCount);
{$ENDIF}
end;

procedure DrawTreeElement(Canvas: TCanvas; ARect: TRect;
  TreeElement: TTreeElementEh; BackDot: Boolean; ScaleX, ScaleY: Double;
  RightToLeft: Boolean);
var
  ABoxRect: TRect;
//  ABoxRectWidth: Integer;
  ACenter: TPoint;
  X1, X2, X4, Y1, Y2, Y4: Integer;
{$IFDEF EH_LIB_7}
  Details: TThemedElementDetails;
  TreeviewPlus: TThemedTreeview;
{$ENDIF}
//    ttGlyphClosed, ttGlyphOpened,

begin
  ACenter.X := (ARect.Right + ARect.Left) div 2;
  ACenter.Y := (ARect.Bottom + ARect.Top) div 2;
  X1 := Trunc(ScaleX);
  X2 := Trunc(ScaleX*2);
  X4 := Trunc(ScaleX*4);
  Y1 := Trunc(ScaleY);
  Y2 := Trunc(ScaleY*2);
  Y4 := Trunc(ScaleY*4);

  with Canvas do
  begin
    ABoxRect := Rect(ACenter.X-X4, ACenter.Y-Y4, ACenter.X+X4+1, ACenter.Y+Y4+1);
//    ABoxRectWidth := ABoxRect.Right - ABoxRect.Left;
    if TreeElement in [tehMinusUpDown .. tehPlus] then
    begin
      Brush.Color := clWindow;
      Pen.Color := clBtnShadow;
      Pen.Style := psSolid;
      if RightToLeft
        then Rectangle(ABoxRect.Left-1, ABoxRect.Top, ABoxRect.Right-1, ABoxRect.Bottom)
        else Rectangle(ABoxRect.Left, ABoxRect.Top, ABoxRect.Right, ABoxRect.Bottom);
      Pen.Color := clWindowText;
{$IFDEF EH_LIB_7}
      if ThemeServices.ThemesEnabled then
      begin
        if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus]
          then TreeviewPlus := ttGlyphClosed
          else TreeviewPlus := ttGlyphOpened;
        Details := ThemeServices.GetElementDetails(TreeviewPlus);
        ThemeServices.DrawElement(Canvas.Handle, Details, ABoxRect);
      end else
{$ENDIF}
      begin
        MoveTo(ABoxRect.Left + X2, ACenter.Y);
        LineTo(ABoxRect.Right - X2, ACenter.Y);

        if TreeElement in [tehPlusUpDown, tehPlusUp, tehPlusDown, tehPlus] then
        begin
          MoveTo(ACenter.X, ABoxRect.Top + Y2);
          LineTo(ACenter.X, ABoxRect.Bottom - Y2);
        end;
      end;

      Pen.Color := clBtnShadow;
      if not (TreeElement in [tehMinus, tehPlus]) then
        DrawDotLine(Canvas, Point(ABoxRect.Right + X1, ACenter.Y),
         (ARect.Right - ABoxRect.Right), True, False);

      if TreeElement in [tehMinusUpDown, tehMinusUp, tehPlusUpDown, tehPlusUp] then
        DrawDotLine(Canvas, Point(ACenter.X, ARect.Top), (ABoxRect.Top - ARect.Top), False, BackDot);

      if TreeElement in [tehMinusUpDown, tehMinusDown, tehPlusUpDown, tehPlusDown] then
        DrawDotLine(Canvas, Point(ACenter.X, ABoxRect.Bottom + Y1),
          (ARect.Bottom - ABoxRect.Bottom), False, BackDot);

    end else
    begin
      Pen.Style := psSolid;
      Pen.Color := clBtnShadow;
      if TreeElement in [tehCrossUpDown, tehVLine] then
        DrawDotLine(Canvas, Point(ACenter.X, ARect.Top),
          (ARect.Bottom - ARect.Top), False, BackDot);
      if TreeElement in [tehCrossUpDown, tehCrossUp, tehCrossDown] then
        DrawDotLine(Canvas, Point(ACenter.X, ACenter.Y), (ARect.Right - ACenter.X), True, False);
      if TreeElement in [tehCrossDown] then
        DrawDotLine(Canvas, Point(ACenter.X, ACenter.Y), (ARect.Bottom - ACenter.Y), False, BackDot);
      if TreeElement in [tehCrossUp] then
        DrawDotLine(Canvas, Point(ACenter.X, ARect.Top), (ACenter.Y - ARect.Top), False, BackDot);
    end;
  end;
end;

{ TButtonsBitmapCache }

function TButtonsBitmapCache.GetButtonBitmap(ButtonBitmapInfo: TButtonBitmapInfoEh): TBitmap;
var
  i: Integer;
  BitmapInfoBitmap: TButtonBitmapInfoBitmapEh;
begin
  if ButtonBitmapInfo.Size.X < 0 then ButtonBitmapInfo.Size.X := 0;
  if ButtonBitmapInfo.Size.Y < 0 then ButtonBitmapInfo.Size.Y := 0;
  for i := 0 to Count - 1 do
    if CompareButtonBitmapInfo(ButtonBitmapInfo, Items[i].BitmapInfo) then
    begin
      Result := Items[i].Bitmap;
      Exit;
    end;
  BitmapInfoBitmap := TButtonBitmapInfoBitmapEh.Create;
  Add(BitmapInfoBitmap);
  BitmapInfoBitmap.BitmapInfo := ButtonBitmapInfo;
  BitmapInfoBitmap.Bitmap := TBitmap.Create;
  BitmapInfoBitmap.Bitmap.Width := ButtonBitmapInfo.Size.X;
  BitmapInfoBitmap.Bitmap.Height := ButtonBitmapInfo.Size.Y;

  case ButtonBitmapInfo.BitmapType of
    bcsCheckboxEh:
      DrawCheck(BitmapInfoBitmap.Bitmap.Canvas.Handle,
        Rect(0, 0, ButtonBitmapInfo.Size.X, ButtonBitmapInfo.Size.Y),
        ButtonBitmapInfo.CheckState,
        ButtonBitmapInfo.Enabled,
        ButtonBitmapInfo.Flat,
        ButtonBitmapInfo.Pressed,
        ButtonBitmapInfo.Active
        );
    bcsEllipsisEh, bcsUpDownEh, bcsDropDownEh, bcsPlusEh, bcsMinusEh,
    bcsAltDropDownEh, bcsAltUpDownEh:
      DrawOneButton(BitmapInfoBitmap.Bitmap.Canvas, ButtonBitmapInfo.BitmapType,
        Rect(0, 0, ButtonBitmapInfo.Size.X, ButtonBitmapInfo.Size.Y),
        ButtonBitmapInfo.Enabled, ButtonBitmapInfo.Flat,
        ButtonBitmapInfo.Active, ButtonBitmapInfo.Pressed,
        ButtonBitmapInfo.DownDirect);
  end;
  Result := BitmapInfoBitmap.Bitmap;
end;

function TButtonsBitmapCache.Get(Index: Integer): TButtonBitmapInfoBitmapEh;
begin
  Result := TButtonBitmapInfoBitmapEh(inherited Items[Index]);
end;

{procedure TButtonsBitmapCache.Put(Index: Integer; const Value: PButtonBitmapInfoBitmapEh);
begin
  inherited Items[Index] := Value;
end;}

procedure TButtonsBitmapCache.Clear;
var i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Bitmap.Free;
    Items[i].Free;
    //Dispose(Items[i]);
  end;
  inherited Clear;
end;

constructor TButtonsBitmapCache.Create;
begin
  inherited Create;
  OwnsObjects := False;
end;

{ TEditButtonControlEh }

procedure TEditButtonControlEh.EditButtonDown(TopButton: Boolean; var AutoRepeat: Boolean);
var Handled: Boolean;
begin
  if Assigned(FOnDown) then
    FOnDown(Self, TopButton, AutoRepeat, Handled);
end;

procedure TEditButtonControlEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var AutoRepeat: Boolean;
//    OldState: TButtonState;
begin
  if Style in [ebsUpDownEh, ebsAltUpDownEh]
    then AutoRepeat := True
    else AutoRepeat := False;
//  OldState := FState;
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) then
  begin
    UpdateDownButtonNum(X, Y);
    if FButtonNum > 0 then
    begin
      EditButtonDown(FButtonNum = 1, AutoRepeat);
      if AutoRepeat then ResetTimer(InitRepeatPause);
    end;
  end;
end;

procedure TEditButtonControlEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  if MouseCapture and (FStyle in [ebsUpDownEh, ebsAltUpDownEh]) and (FState = bsDown) then
  begin
    if ((FButtonNum = 2) and (Y < (Height div 2))) or
      ((FButtonNum = 1) and (Y > (Height - Height div 2))) then
    begin
      FState := bsUp;
      Invalidate;
    end;
  end;
end;

procedure TEditButtonControlEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (FStyle in [ebsUpDownEh, ebsAltUpDownEh]) and (FState <> bsDown) then
    FNoDoClick := True;
  try
    inherited MouseUp(Button, Shift, X, Y);
//    UpdateTracking;
  finally
    FNoDoClick := False;
  end;
  UpdateDownButtonNum(X, Y);
  if (FTimer <> nil) and FTimer.Enabled then
    FTimer.Enabled := False;
end;

procedure TEditButtonControlEh.UpdateDownButtonNum(X, Y: Integer);
var OldButtonNum: Integer;
begin
  OldButtonNum := FButtonNum;
  if FState in [bsDown, bsExclusive] then
    if FStyle in [ebsUpDownEh, ebsAltUpDownEh] then
    begin
      if Y < (Height div 2) then
        FButtonNum := 1
      else if Y > (Height - Height div 2) then
        FButtonNum := 2
      else
        FButtonNum := 0;
    end
    else FButtonNum := 1
  else
    FButtonNum := 0;
  if FButtonNum <> OldButtonNum then
    Invalidate;
end;

procedure TEditButtonControlEh.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TButtonState; BiDiFlags: LongInt);
var
  TextSize: TPoint;
  TextRect: TRect;
begin
  TextRect := TextBounds;
  DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextRect,
    DT_CALCRECT or BiDiFlags);
  TextSize := Point(TextRect.Right - TextRect.Left, TextRect.Bottom - TextRect.Top);
  TextBounds.Top := (TextBounds.Top + TextBounds.Bottom - TextSize.Y + 1) div 2;
  TextBounds.Bottom := TextBounds.Top + TextSize.Y;
  with Canvas do
  begin
    Brush.Style := bsClear;
//    Font.Color := Self.Font.Color;
    Font := Self.Font;
    if State = bsDisabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := clBtnHighlight;
      DrawTextEh(Handle, Caption, Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      DrawTextEh(Handle, Caption, Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
    end else
      DrawTextEh(Handle, Caption, Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
  end;
end;

type
  TSpeedButtonCrack = class(TGraphicControl)
  protected
    FGroupIndex: Integer;
    FGlyph: TObject;
    FDown: Boolean;
    FDragging: Boolean;
    FAllowAllUp: Boolean;
    FLayout: TButtonLayout;
    FSpacing: Integer;
    FTransparent: Boolean;
    FMargin: Integer;
    FFlat: Boolean;
    FMouseInControl: Boolean;
  end;

procedure TEditButtonControlEh.Paint;
const
  StyleFlags: array[TEditButtonStyleEh] of TDrawButtonControlStyleEh =
  (bcsDropDownEh, bcsEllipsisEh, bcsUpDownEh, bcsUpDownEh, bcsPlusEh, bcsMinusEh,
   bcsAltDropDownEh, bcsAltUpDownEh);
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var Rgn, SaveRgn: HRgn;
  r: Integer;
  BRect: TRect;
  IsClipRgn: Boolean;
  AButtonNum: Integer;
  AAcitve: Boolean;
{$IFDEF EH_LIB_7}
  Details: TThemedElementDetails;
  Button: TThemedButton;
{$ENDIF}

//  ThemeRect: TRect;
begin
  AButtonNum := FButtonNum;
  if ThemesEnabled
    then AAcitve := MouseInControl
    else AAcitve := FActive;
{$IFDEF EH_LIB_7}
  IsClipRgn := False;
  SaveRgn := 0;
  r := 0;
{$ENDIF}
  if not (FState in [bsDown, bsExclusive]) then
    AButtonNum := 0;
  //else if AButtonNum = 0 then
  //  AButtonNum := 1;
  if not (Style = ebsGlyphEh) then
    PaintButtonControlEh(Canvas, Rect(0, 0, Width, Height),
{$IFDEF CIL}
      Color,
{$ELSE}
      TWinControlCracker(Parent).Color,
{$ENDIF}
      StyleFlags[Style], AButtonNum,
      Flat, AAcitve, Enabled, cbUnchecked)
  else
  begin
{$IFDEF EH_LIB_7}
    if not ThemeServices.ThemesEnabled then
{$ENDIF}
    begin
      IsClipRgn := Flat {and not FActive};
      BRect := BoundsRect;
      r := 0;
      SaveRgn := 0;
      if IsClipRgn then
      begin
        SaveRgn := CreateRectRgn(0, 0, 0, 0);
        r := GetClipRgn(Canvas.Handle, SaveRgn);
        with BRect do
          Rgn := CreateRectRgn(Left + 1, Top + 1, Right - 1, Bottom - 1);
        SelectClipRgn(Canvas.Handle, Rgn);
        DeleteObject(Rgn);
      end;
    end;

{  // May be better to use Scrollbar Thumb Button for custom edit buttons
   // but also need to use Scrollbar Down Button for DropDown edit button
}
{$IFDEF EH_LIB_7}
    if ThemeServices.ThemesEnabled and Flat and not AAcitve and Enabled and
      not Down and Glyph.Empty then
    begin
      PerformEraseBackground(Self, Canvas.Handle);
      Button := tbGroupBoxNormal;
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, ClientRect);
      DrawButtonText(Canvas, Caption, ClientRect, FState, DrawTextBiDiModeFlags(0));
    end else
{$ENDIF}
    begin
{$IFDEF CIL}
// CIL not supported
{$ELSE}
      if not Glyph.Empty and ThemesEnabled and Flat then
        TSpeedButtonCrack(Self).FMouseInControl := True;
{$ENDIF}
      inherited Paint;
    end;

{$IFDEF EH_LIB_7}
    if not ThemeServices.ThemesEnabled then
{$ENDIF}
    begin
      if IsClipRgn then
      begin
        if r = 0 then
          SelectClipRgn(Canvas.Handle, 0)
        else
          SelectClipRgn(Canvas.Handle, SaveRgn);
        DeleteObject(SaveRgn);
        OffsetRect(BRect, -Left, -Top);
        if FActive then
          DrawEdge(Canvas.Handle, BRect, DownStyles[FState in [bsDown, bsExclusive]], BF_RECT)
        else
        begin
{$IFDEF CIL}
          Canvas.Brush.Color := Color;
{$ELSE}
          Canvas.Brush.Color := TWinControlCracker(Parent).Color;
{$ENDIF}
          Canvas.FrameRect(BRect);
        end;
      end;
    end;

  end;
end;

procedure TEditButtonControlEh.SetState(NewState: TButtonState; IsActive: Boolean; ButtonNum: Integer);
begin
  if (FState <> NewState) or (IsActive <> FActive) or (ButtonNum <> FButtonNum) then
  begin
    FActive := IsActive;
    FState := NewState;
    FButtonNum := ButtonNum;
    //Invalidate;
    Repaint;
  end;
end;

procedure TEditButtonControlEh.SetStyle(const Value: TEditButtonStyleEh);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

procedure TEditButtonControlEh.SetWidthNoNotify(AWidth: Integer);
begin
  inherited Width := AWidth;
end;

procedure TEditButtonControlEh.SetActive(const Value: Boolean);
begin
  if Active <> Value then
  begin
    FActive := Value;
    Invalidate;
  end;
end;

procedure TEditButtonControlEh.Click;
begin
  if not FNoDoClick then
  begin
    inherited Click;
  end;
end;

function TEditButtonControlEh.GetTimer: TTimer;
begin
  if FTimer = nil then
  begin
    FTimer := TTimer.Create(Self);
    FTimer.Enabled := False;
    FTimer.OnTimer := TimerEvent;
  end;
  Result := FTimer;
end;

procedure TEditButtonControlEh.ResetTimer(Interval: Cardinal);
begin
  if Timer.Enabled = False then
  begin
    Timer.Interval := Interval;
    Timer.Enabled := True;
  end
  else if Interval <> Timer.Interval then
  begin
    Timer.Enabled := False;
    Timer.Interval := Interval;
    Timer.Enabled := True;
  end;
end;

procedure TEditButtonControlEh.TimerEvent(Sender: TObject);
var AutoRepeat: Boolean;
begin
  if Style in [ebsUpDownEh, ebsAltUpDownEh]
    then AutoRepeat := True
    else AutoRepeat := False;
  if not (FState = bsDown) then Exit;
  if Timer.Interval = Cardinal(InitRepeatPause) then
    ResetTimer(RepeatPause);
  if FState = bsDown then
    EditButtonDown(FButtonNum = 1, AutoRepeat);
  if not AutoRepeat then Timer.Enabled := False;
end;

procedure TEditButtonControlEh.SetAlwaysDown(const Value: Boolean);
begin
  if FAlwaysDown <> Value then
  begin
    FAlwaysDown := Value;
    if Value then
    begin
      GroupIndex := 1;
      Down := True;
      AllowAllUp := False;
      FButtonNum := 1;
    end else
    begin
      AllowAllUp := True;
      Down := False;
      GroupIndex := 0;
      FButtonNum := 0;
    end;
  end;
end;

{ TEditButtonEh }

constructor TEditButtonEh.Create(EditControl: TWinControl {; EditButtonControl: TEditButtonControlEh});
begin
  inherited Create(nil);
  FEditControl := EditControl;
  FEnabled := True;
  FGlyph := TBitmap.Create;
  FGlyph.Transparent := True;
  FShortCut := scNone; //Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
  FNumGlyphs := 1;
end;

constructor TEditButtonEh.Create(Collection: TCollection);
begin
  if Assigned(Collection) then Collection.BeginUpdate;
  try
    inherited Create(Collection);
    FEditControl := nil;
    FEnabled := True;
    FGlyph := TBitmap.Create;
    FGlyph.Transparent := True;
    FShortCut := scNone; //Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
    FNumGlyphs := 1;
  finally
    if Assigned(Collection) then Collection.EndUpdate;
  end;
end;

destructor TEditButtonEh.Destroy;
begin
{$IFDEF EH_LIB_6}
  FreeAndNil(FActionLink);
{$ENDIF}  
  FreeAndNil(FGlyph);
  inherited Destroy;
end;

procedure TEditButtonEh.Assign(Source: TPersistent);
begin
  if Source is TEditButtonEh then
  begin
{$IFDEF EH_LIB_6}
    Action :=  TEditButtonEh(Source).Action;
{$ENDIF}    
    DropdownMenu := TEditButtonEh(Source).DropdownMenu;
    Enabled :=  TEditButtonEh(Source).Enabled;
    Glyph := TEditButtonEh(Source).Glyph;
    Hint := TEditButtonEh(Source).Hint;
    NumGlyphs := TEditButtonEh(Source).NumGlyphs;
    ShortCut := TEditButtonEh(Source).ShortCut;
    Style := TEditButtonEh(Source).Style;
    Visible := TEditButtonEh(Source).Visible;
    Width := TEditButtonEh(Source).Width;
    OnClick := TEditButtonEh(Source).OnClick;
    OnDown := TEditButtonEh(Source).OnDown;
  end else
    inherited Assign(Source);
end;

function TEditButtonEh.GetGlyph: TBitmap;
begin
  Result := FGlyph;
end;

procedure TEditButtonEh.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
  Changed;
end;

procedure TEditButtonEh.SetNumGlyphs(Value: Integer);
begin
  if Value <= 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetStyle(const Value: TEditButtonStyleEh);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

function TEditButtonEh.CreateEditButtonControl: TEditButtonControlEh;
begin
  Result := TEditButtonControlEh.Create(FEditControl);
  with Result do
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    Width := 10;
    Height := 17;
    Visible := True;
    Transparent := False;
    Parent := FEditControl;
  end;
end;

procedure TEditButtonEh.Changed;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self)
  else if Assigned(Collection) then
    Changed(False)
end;

procedure TEditButtonEh.SetHint(const Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TEditButtonEh.Click(Sender: TObject; var Handled: Boolean);
begin
  if Assigned(OnClick) then
    OnClick(Sender, Handled)
  else if (ActionLink <> nil) then
  begin
{$IFDEF EH_LIB_6}
    if (FEditControl <> nil) then
      ActionLink.Execute(FEditControl)
    else if Collection.Owner is TComponent then
      ActionLink.Execute(Collection.Owner as TComponent)
    else
      ActionLink.Execute(nil);
{$ELSE}
    ActionLink.Execute;
{$ENDIF}
    Handled := True;
  end;
end;

procedure TEditButtonEh.SetAction(const Value: TBasicAction);
begin
  if Value = nil then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end
  else
  begin
    if FActionLink = nil then
      FActionLink := GetActionLinkClass.Create(Self);
    FActionLink.Action := Value;
    FActionLink.OnChange := DoActionChange;
    ActionChange(Value, csLoading in Value.ComponentState);
//    Value.FreeNotification(Self); ????
  end;
end;

function TEditButtonEh.GetAction: TBasicAction;
begin
  if FActionLink <> nil then
    Result := FActionLink.Action else
    Result := nil
end;

function TEditButtonEh.GetActionLinkClass: TEditButtonActionLinkEhClass;
begin
  Result := TEditButtonActionLinkEh;
end;

procedure TEditButtonEh.DoActionChange(Sender: TObject);
begin
  if Sender = Action then ActionChange(Sender, False);
end;

procedure TEditButtonEh.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.Hint = '') then
        Self.Hint := Hint;
      if not CheckDefaults or (Self.ShortCut = scNone) then
        Self.ShortCut := ShortCut;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
    end;
end;

procedure TEditButtonEh.InitiateAction;
begin
  if FActionLink <> nil then FActionLink.Update;
end;

function TEditButtonEh.IsEnabledStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsEnabledLinked;
end;

function TEditButtonEh.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsHintLinked;
end;

function TEditButtonEh.IsShortCutStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsShortCutLinked;
end;

function TEditButtonEh.IsVisibleStored: Boolean;
begin
  Result := (ActionLink = nil) or not FActionLink.IsVisibleLinked;
end;

{ TEditButtonsEh }

function TEditButtonsEh.Add: TEditButtonEh;
begin
  Result := TEditButtonEh(inherited Add);
end;

constructor TEditButtonsEh.Create(Owner: TPersistent; EditButtonClass: TEditButtonEhClass);
begin
  inherited Create(EditButtonClass);
  FOwner := Owner;
end;

function TEditButtonsEh.GetEditButton(Index: Integer): TEditButtonEh;
begin
  Result := TEditButtonEh(inherited Items[Index]);
end;

function TEditButtonsEh.GetOwner: TPersistent;
begin
//  inherited GetOwner;
  Result := FOwner;
end;

procedure TEditButtonsEh.SetEditButton(Index: Integer; Value: TEditButtonEh);
begin
  inherited Items[Index] := Value;
end;

procedure TEditButtonsEh.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
  if Assigned(FOnChanged) then FOnChanged(Item);
end;

{ TDropDownEditButtonEh }

constructor TDropDownEditButtonEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
end;

constructor TDropDownEditButtonEh.Create(EditControl: TWinControl);
begin
  inherited Create(EditControl);
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
end;

{ TVisibleEditButtonEh }

constructor TVisibleEditButtonEh.Create(EditControl: TWinControl);
begin
  inherited Create(EditControl);
  FVisible := True;
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
end;

constructor TVisibleEditButtonEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FVisible := True;
  FShortCut := Menus.ShortCut(VK_DOWN, [ssAlt]); //32808
end;

{ TSpecRowEh }

constructor TSpecRowEh.Create(Owner: TPersistent);
begin
  inherited Create;
  FOwner := Owner;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FCellsStrings := TStringList.Create;
  FValue := Null;
  FShowIfNotInKeyList := True;
  FShortCut := Menus.ShortCut(VK_DELETE, [ssAlt]); //32814
end;

destructor TSpecRowEh.Destroy;
begin
  FreeAndNil(FCellsStrings);
  FreeAndNil(FFont);
  inherited Destroy;
end;

function TSpecRowEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TSpecRowEh.Changed;
begin
  if (FUpdateCount = 0) and Assigned(FOnChanged) then
    OnChanged(Self);
end;

procedure SetCellsStrings(Strings: TStrings; const Value: String);
const
  Delimiter = ';';
  QuoteChar = '"';
{$IFDEF CIL}
// {$IF Defined(CLX) or Defined(EH_LIB_12) }
var
  P, P1, L: Integer;
  S: string;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    P := 1;
    L := Length(Value);
    while (P <= L) and (Value[P] in [#1..' ']) do
      Inc(P);
    while P <= L do
    begin
      if Value[P] = QuoteChar then
        S := DequotedStr(Value, QuoteChar, P)
      else
      begin
        P1 := P;
        while (P <= L) and (Value[P] > ' ') and (Value[P] <> Delimiter) do
          Inc(P);
        S := Copy(Value, P1, P - P1);
      end;
      Strings.Add(S);
      while (P <= L) and (Value[P] in [#1..' ']) do
        Inc(P);
      if (P <= L) and (Value[P] = Delimiter) then
      begin
        P1 := P;
        Inc(P1);
        if P1 > L then
          Strings.Add('');
        repeat
          Inc(P);
        until (P > L) or (not (Value[P] in [#1..' ']));
      end;
    end;
  finally
    Strings.EndUpdate;
  end;
end;

{$ELSE}
var
  P, P1: PChar;
  S: string;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    P := PChar(Value);
//    while P^ in [#1..' '] do P := CharNext(P);
    while CharInSetEh(P^, [#1..' ']) do P := CharNext(P);
    while P^ <> #0 do
    begin
      if P^ = QuoteChar then
        S := AnsiExtractQuotedStr(P, QuoteChar)
      else
      begin
        P1 := P;
        while (P^ >= ' ') and (P^ <> Delimiter) do P := CharNext(P);
        SetString(S, P1, P - P1);
      end;
      Strings.Add(S);
      while CharInSetEh(P^, [#1..#31]) do P := CharNext(P);
      if P^ = Delimiter then
        repeat
          P := CharNext(P);
        until not CharInSetEh(P^, [#1..#31]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;
{$ENDIF}

procedure TSpecRowEh.SetCellsText(const Value: String);
begin
  if FCellsText <> Value then
  begin
    FCellsText := Value;
    SetCellsStrings(FCellsStrings, Value);
    Changed;
  end;
end;

procedure TSpecRowEh.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    FColorAssigned := True;
    Changed;
  end;
end;

procedure TSpecRowEh.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TSpecRowEh.SetValue(const Value: Variant);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.FontChanged(Sender: TObject);
begin
  Changed;
  FFontAssigned := True;
end;

procedure TSpecRowEh.SetShowIfNotInKeyList(const Value: Boolean);
begin
  if FShowIfNotInKeyList <> Value then
  begin
    FShowIfNotInKeyList := Value;
    Changed;
  end;
end;

procedure TSpecRowEh.Assign(Source: TPersistent);
begin
  if Source is TSpecRowEh then
  begin
    BeginUpdate;
    try
      CellsText := TSpecRowEh(Source).CellsText;
      Color := TSpecRowEh(Source).Color;
      if TSpecRowEh(Source).FFontAssigned then
        Font := TSpecRowEh(Source).Font;
      ShortCut := TSpecRowEh(Source).ShortCut;
      ShowIfNotInKeyList := TSpecRowEh(Source).ShowIfNotInKeyList;
      Value := TSpecRowEh(Source).Value;
      Visible := TSpecRowEh(Source).Visible;
    finally
      EndUpdate;
    end;
  end else
    inherited Assign(Source);
end;

function TSpecRowEh.GetFont: TFont;
var
  Save: TNotifyEvent;
begin
  if not FFontAssigned and (FFont.Handle <> DefaultFont.Handle) then
  begin
    Save := FFont.OnChange;
    FFont.OnChange := nil;
    FFont.Assign(DefaultFont);
    FFont.OnChange := Save;
  end;
  Result := FFont;
end;

function TSpecRowEh.GetColor: TColor;
begin
  if not FColorAssigned
    then Result := DefaultColor
    else Result := FColor;
end;

function TSpecRowEh.DefaultFont: TFont;
begin
  if Assigned(FOwner) and (FOwner is TControl)
{$IFDEF CIL}
    then Result := IControl(FOwner).GetFont
{$ELSE}
    then Result := TControlCracker(FOwner).Font
{$ENDIF}
    else Result := FFont;
end;

function TSpecRowEh.DefaultColor: TColor;
begin
  if Assigned(FOwner) and (FOwner is TCustomControl)
{$IFDEF CIL}
    then Result := TCustomControl(FOwner).Color
{$ELSE}
    then Result := TControlCracker(FOwner).Color
{$ENDIF}
    else Result := FColor;
end;

function TSpecRowEh.GetCellText(Index: Integer): String;
begin
  if (Index < 0) or (Index >= FCellsStrings.Count)
    then Result := ''
    else Result := FCellsStrings[Index];
end;

function TSpecRowEh.IsValueStored: Boolean;
begin
  Result := not VarEquals(FValue, Null);
end;

function TSpecRowEh.IsFontStored: Boolean;
begin
  Result := FFontAssigned;
end;

function TSpecRowEh.IsColorStored: Boolean;
begin
  Result := FColorAssigned;
end;

function TSpecRowEh.LocateKey(KeyValue: Variant): Boolean;
begin
  Result := Visible and VarEquals(Value, KeyValue);
end;

procedure TSpecRowEh.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TSpecRowEh.EndUpdate;
begin
  Dec(FUpdateCount);
  Changed;
end;

procedure GetFieldsProperty(List: TList; DataSet: TDataSet;
  Control: TComponent; const FieldNames: String);
var
  Pos: Integer;
  Field: TField;
  FieldName: String;
begin
  Pos := 1;
  while Pos <= Length(FieldNames) do
  begin
    FieldName := ExtractFieldName(FieldNames, Pos);
    Field := DataSet.FindField(FieldName);
    if Field = nil then
      DatabaseErrorFmt(SFieldNotFound, [FieldName], Control);
    if Assigned(List) then List.Add(Field);
  end;
end;

function GetFieldsProperty(DataSet: TDataSet; Control: TComponent;
  const FieldNames: String): TFieldsArrEh;
var
  FieldList: TObjectList;
  i: Integer;
begin
  FieldList := TObjectList.Create(False);
  try
    GetFieldsProperty(FieldList, DataSet, Control, FieldNames);
    SetLength(Result, FieldList.Count);
    for i := 0 to FieldList.Count - 1 do
      Result[i] := TField(FieldList[i]);
  finally
    FieldList.Free;
  end;
end;

procedure DataSetSetFieldValues(DataSet: TDataSet; Fields: String; Value: Variant);
var
  FieldList: TObjectList;
  i: Integer;
begin
  if VarEquals(Value, Null) then
  begin
    FieldList := TObjectList.Create(False);
    try
      Dataset.GetFieldList(FieldList, Fields);
      for i := 0 to FieldList.Count - 1 do
        TField(FieldList[i]).Clear;
    finally
      FieldList.Free;
    end;
  end else
    DataSet.FieldValues[Fields] := Value;
end;

{ TSizeGripEh }

constructor TSizeGripEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; 
  Width := GetSystemMetrics(SM_CXVSCROLL);
  Height := GetSystemMetrics(SM_CYVSCROLL);
  Color := clBtnFace;
  Cursor := crSizeNWSE;
  ControlStyle := ControlStyle + [csCaptureMouse];
  FTriangleWindow := True;
  FPosition := sgpBottomRight;
end;

procedure TSizeGripEh.CreateWnd;
begin
  inherited CreateWnd;
  UpdateWindowRegion;
    //ShowWindow(Handle,SW_SHOW);
end;

procedure TSizeGripEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FInitScreenMousePos := ClientToScreen(Point(X, Y));
  FParentRect.Right := Parent.Width;
  FParentRect.Bottom := Parent.Height;
  FParentRect.Left := Parent.ClientWidth;
  FParentRect.Top := Parent.ClientHeight;
end;

procedure TSizeGripEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewMousePos, ParentWidthHeight: TPoint;
  OldPos, NewClientAmount, OutDelta: Integer;
  WorkArea: TRect;
begin
  inherited MouseMove(Shift, X, Y);

  if (ssLeft in Shift) and MouseCapture and not FInternalMove then
  begin
    NewMousePos := ClientToScreen(Point(X, Y));
    ParentWidthHeight.x := Parent.ClientWidth;
    ParentWidthHeight.y := Parent.ClientHeight;

    if (FOldMouseMovePos.x = NewMousePos.x) and
      (FOldMouseMovePos.y = NewMousePos.y) then
      Exit;

    SystemParametersInfoEh(SPI_GETWORKAREA, 0, WorkArea, 0);

    if Position in [sgpBottomRight, sgpTopRight] then
    begin
      NewClientAmount := FParentRect.Left + NewMousePos.x - FInitScreenMousePos.x;
      OutDelta := Parent.Width + NewClientAmount - Parent.ClientWidth;
      OutDelta := Parent.ClientToScreen(Point(OutDelta, 0)).x - WorkArea.Right;
      if OutDelta <= 0
        then Parent.ClientWidth := NewClientAmount
        else Parent.ClientWidth := NewClientAmount - OutDelta
    end else
    begin
      OldPos := Parent.Width;

      NewClientAmount := FParentRect.Right + FInitScreenMousePos.x - NewMousePos.x;
      OutDelta := NewClientAmount - Parent.Width;
      OutDelta := Parent.ClientToScreen(Point(0, 0)).x - WorkArea.Left - OutDelta;
      if OutDelta >= 0
        then Parent.Width := NewClientAmount
        else Parent.Width := NewClientAmount + OutDelta;
//      Parent.Width := FParentRect.Right + FInitScreenMousePos.x - NewMousePos.x;
      Parent.Left := Parent.Left + OldPos - Parent.Width;
    end;

    if Position in [sgpBottomRight, sgpBottomLeft] then
    begin
      NewClientAmount := FParentRect.Top + NewMousePos.y - FInitScreenMousePos.y;
      OutDelta := Parent.Height + NewClientAmount - Parent.ClientHeight;
      OutDelta := Parent.ClientToScreen(Point(0, OutDelta)).y - WorkArea.Bottom;
      if OutDelta <= 0
        then Parent.ClientHeight := NewClientAmount
        else Parent.ClientHeight := NewClientAmount - OutDelta;
    end else
    begin
      OldPos := Parent.Height;
      NewClientAmount := FParentRect.Bottom + FInitScreenMousePos.y - NewMousePos.y;
      OutDelta := NewClientAmount - Parent.Height;
      OutDelta := Parent.ClientToScreen(Point(0, 0)).y - WorkArea.Top - OutDelta;
      if OutDelta >= 0
        then Parent.Height := NewClientAmount
        else Parent.Height := NewClientAmount + OutDelta;
//      Parent.{Client}Height := FParentRect.Bottom + FInitScreenMousePos.y - NewMousePos.y;
      Parent.Top := Parent.Top + OldPos - Parent.Height;
    end;

    FOldMouseMovePos := NewMousePos;
    if (ParentWidthHeight.x <> Parent.ClientWidth) or
      (ParentWidthHeight.y <> Parent.ClientHeight) then
      ParentResized;
    UpdatePosition;
  end;
end;

procedure TSizeGripEh.Paint;
var
  i, xi, yi: Integer;
//  x1, x2, y1, y2: Integer;
  XArray: array of Integer;
  YArray: array of Integer;
  xIdx, yIdx: Integer;
begin
  i := 1;
  SetLength(XArray, 2);
  SetLength(YArray, 2);
  if Position = sgpBottomRight then
  begin
    xi := 1; yi := 1;
    xIdx := 0; yIdx := 1;
    XArray[0] := 0; YArray[0] := Width;
    XArray[1] := Width; YArray[1] := 0;
  end else if Position = sgpBottomLeft then
  begin
    xi := -1; yi := 1;
    xIdx := 1; yIdx := 0;
    XArray[0] := 0; YArray[0] := 1;
    XArray[1] := Width - 1; YArray[1] := Width;
  end else if Position = sgpTopLeft then
  begin
    xi := -1; yi := -1;
    xIdx := 0; yIdx := 1;
    XArray[0] := Width - 1; YArray[0] := -1;
    XArray[1] := -1; YArray[1] := Width - 1;
  end else //  Position = sgpTopRight
  begin
    xi := 1; yi := -1;
    xIdx := 1; yIdx := 0;
    XArray[0] := Width; YArray[0] := Width - 1;
    XArray[1] := 0; YArray[1] := -1;
  end;

  with Canvas do
    while i < Width do
    begin
      Pen.Color := clBtnHighlight;
      PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
      Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[YIdx], yi);

      Pen.Color := clBtnShadow;
      PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
      Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);
      PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
      Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);

      Pen.Color := clBtnFace;
      PolyLine([Point(XArray[0], YArray[0]), Point(XArray[1], YArray[1])]);
      Inc(i); Inc(XArray[xIdx], xi); Inc(YArray[yIdx], yi);
    end;
end;

procedure TSizeGripEh.ParentResized;
begin
  if Assigned(FParentResized) then FParentResized(Self);
end;

procedure TSizeGripEh.SetPosition(const Value: TSizeGripPostion);
begin
  if FPosition = Value then Exit;
  FPosition := Value;
  RecreateWnd;
  HandleNeeded;
end;

procedure TSizeGripEh.SetTriangleWindow(const Value: Boolean);
begin
  if FTriangleWindow = Value then Exit;
  FTriangleWindow := Value;
  UpdateWindowRegion;
{  if HandleAllocated then
  begin
    RecreateWnd;
    HandleNeeded;
  end;}
end;

procedure TSizeGripEh.UpdatePosition;
begin
  FInternalMove := True;
  case Position of
    sgpBottomRight: MoveWindow(Handle, Parent.ClientWidth - Width, Parent.ClientHeight - Height, Width, Height, True);
    sgpBottomLeft: MoveWindow(Handle, 0, Parent.ClientHeight - Height, Width, Height, True);
    sgpTopLeft: MoveWindow(Handle, 0, 0, Width, Height, True);
    sgpTopRight: MoveWindow(Handle, Parent.ClientWidth - Width, 0, Width, Height, True);
  end;
  FInternalMove := False;
end;

procedure TSizeGripEh.WMMove(var Message: TWMMove);
begin
  if not FInternalMove then UpdatePosition;
  inherited;
end;

procedure TSizeGripEh.ChangePosition(NewPosition: TSizeGripChangePosition);
begin
  if NewPosition = sgcpToLeft then
  begin
    if Position = sgpTopRight then Position := sgpTopLeft
    else if Position = sgpBottomRight then Position := sgpBottomLeft;
  end else if NewPosition = sgcpToRight then
  begin
    if Position = sgpTopLeft then Position := sgpTopRight
    else if Position = sgpBottomLeft then Position := sgpBottomRight
  end else if NewPosition = sgcpToTop then
  begin
    if Position = sgpBottomRight then Position := sgpTopRight
    else if Position = sgpBottomLeft then Position := sgpTopLeft
  end else if NewPosition = sgcpToBottom then
  begin
    if Position = sgpTopRight then Position := sgpBottomRight
    else if Position = sgpTopLeft then Position := sgpBottomLeft
  end
end;

function TSizeGripEh.GetVisible: Boolean;
begin
  Result := IsWindowVisible(Handle);
end;

procedure TSizeGripEh.SetVisible(const Value: Boolean);
begin
  if Value then
    ShowWindow(Handle, SW_SHOW)
  else
    ShowWindow(Handle, SW_HIDE);
end;

procedure TSizeGripEh.UpdateWindowRegion;
type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;
const
  PositionArr: array[TSizeGripPostion] of TCursor = (crSizeNWSE, crSizeNESW, crSizeNWSE, crSizeNESW);
var
  Points: array[0..2] of TPoint;
  Region: HRgn;
begin
  if not HandleAllocated then Exit;
  if TriangleWindow then
  begin
    if Position = sgpBottomRight then
    begin
      Points[0] := Point(0, Height);
      Points[1] := Point(Width, Height);
      Points[2] := Point(Width, 0);
    end else if Position = sgpBottomLeft then
    begin
      Points[0] := Point(Width, Height);
      Points[1] := Point(0, Height);
      Points[2] := Point(0, 0);
    end else if Position = sgpTopLeft then
    begin
      Points[0] := Point(Width - 1, 0);
      Points[1] := Point(0, 0);
      Points[2] := Point(0, Height - 1);
    end else if Position = sgpTopRight then
    begin
      Points[0] := Point(Width, Height - 1);
      Points[1] := Point(Width, 0);
      Points[2] := Point(1, 0);
    end;
    Region := WindowsCreatePolygonRgn(Points, 3, WINDING);
    SetWindowRgn(Handle, Region, True);
    UpdatePosition;
  end else
  begin
    SetWindowRgn(Handle, 0, True);
    UpdatePosition;
  end;
  Cursor := PositionArr[Position];
end;

{ TPopupMonthCalendarEh }

constructor TPopupMonthCalendarEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; //Really not Replicatable, only for CtrlGrid
  //FOwner := AOwner;
  AutoSize := True;
  Ctl3D := True;
  ParentCtl3D := False;
end;

procedure TPopupMonthCalendarEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_POPUP;
    if not Ctl3D then Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW {or WS_EX_TOPMOST};
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TPopupMonthCalendarEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  ComboEdit: IComboEditEh;
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_RETURN, VK_ESCAPE] then
  begin
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(Key = VK_RETURN);
    Key := 0;
  end;
end;

procedure TPopupMonthCalendarEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ComboEdit: IComboEditEh;
const
    MCM_GETCURRENTVIEW  = MCM_FIRST + 22;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if not PtInRect(Rect(0, 0, Width, Height), Point(X, Y)) then
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(False);
  FDownViewType := SendMessage(Handle, MCM_GETCURRENTVIEW, 0, 0);
end;

procedure TPopupMonthCalendarEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  MCHInfo: TMCHitTestInfo;
  ComboEdit: IComboEditEh;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if not Supports(Owner, IComboEditEh, ComboEdit) then Exit;
  if not PtInRect(Rect(0, 0, Width, Height), Point(X, Y)) then Exit;
  MCHInfo.cbSize := SizeOf(TMCHitTestInfo);
  MCHInfo.pt.x := X;
  MCHInfo.pt.y := Y;
  MonthCal_HitTest(Handle, MCHInfo);
  if ((MCHInfo.uHit and MCHT_CALENDARDATE) > 0) and (MCHInfo.uHit <> MCHT_CALENDARDAY) and
    (MCHInfo.uHit <> MCHT_TITLEBTNNEXT) and (MCHInfo.uHit <> MCHT_TITLEBTNPREV) then
  begin
    if FDownViewType = 0 then
      ComboEdit.CloseUp(True);
  end else if (MCHInfo.uHit and MCHT_NOWHERE > 0) then
    ComboEdit.CloseUp(False)
  else if not ((X >= 0) and (Y >= 0) and (X < Width) and (Y < Height)) then
    ComboEdit.CloseUp(False);
end;

procedure TPopupMonthCalendarEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
var
  ComboEdit: IComboEditEh;
begin
  if not Supports(Owner, IComboEditEh, ComboEdit) then Exit;
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) then
  begin
    ComboEdit.CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TPopupMonthCalendarEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
end;

procedure TPopupMonthCalendarEh.WMKillFocus(var Message: TWMKillFocus);
//var //ComboEdit: IComboEditEh;
//  a: array[0..255] of Char;
begin
  inherited;
//  GetWindowText(Message.FocusedWnd, a, 255);
  if (GetParent(Message.FocusedWnd) <> Handle) then
    PostCloseUp(False);
//    if Supports(Owner,IComboEditEh,ComboEdit) then
//      ComboEdit.CloseUp(False);
end;

procedure TPopupMonthCalendarEh.PostCloseUp(Accept: Boolean);
begin
  PostMessage(Handle, CM_CLOSEUPEH, Integer(Accept), 0);
end;

procedure TPopupMonthCalendarEh.CMCloseUpEh(var Message: TMessage);
var
  ComboEdit: IComboEditEh;
begin
  if Supports(Owner, IComboEditEh, ComboEdit) then
    ComboEdit.CloseUp(False);
end;

function TPopupMonthCalendarEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    Date := Date + 1;
    Result := True;
  end;
end;

function TPopupMonthCalendarEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    Date := Date - 1;
    Result := True;
  end;
end;

procedure TPopupMonthCalendarEh.WMNCCalcSize(var Message: TWMNCCalcSize);
{$IFDEF CIL}
var
  r: TNCCalcSizeParams;
begin
  inherited;
  r := Message.CalcSize_Params;
  InflateRect(r.rgrc0, -FBorderWidth, -FBorderWidth);
  Message.CalcSize_Params := r;
end;
{$ELSE}
begin
  inherited;
  with Message.CalcSize_Params^ do
    InflateRect(rgrc[0], -FBorderWidth, -FBorderWidth);
end;
{$ENDIF}

procedure TPopupMonthCalendarEh.UpdateBorderWidth;
begin
  if Ctl3D
    then FBorderWidth := 2
    else FBorderWidth := 0;
end;

procedure TPopupMonthCalendarEh.DrawBorder;
var
  DC: HDC;
  R: TRect;
begin
  if Ctl3D = True then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
      InflateRect(R, -1, -1);
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TPopupMonthCalendarEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;

procedure TPopupMonthCalendarEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWnd;
end;

procedure TPopupMonthCalendarEh.CreateWnd;
var
  R: TRect;
begin
  inherited CreateWnd;
  MonthCal_GetMinReqRect(Handle, R);
  Width := R.Right - R.Left + FBorderWidth * 2;
  Height := R.Bottom - R.Top + FBorderWidth * 2;
end;

function TPopupMonthCalendarEh.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
  if Result then
  begin
    Inc(NewWidth, FBorderWidth * 2);
    Inc(NewHeight, FBorderWidth * 2);
  end;
end;

function TPopupMonthCalendarEh.MsgSetDateTime(Value: TSystemTime): Boolean;
begin
  inherited MsgSetDateTime(Value);
  Result := True;
end;

{ TMRUListEh }

constructor TMRUListEh.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FItems := TStringList.Create;
  FLimit := 100;
  FRows := 7;
  FAutoAdd :=  True;
  FCancelIfKeyInQueue := True;
end;

destructor TMRUListEh.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TMRUListEh.DropDown;
begin
  if Assigned(OnSetDropDown) then
    OnSetDropDown(Self);
end;

procedure TMRUListEh.CloseUp(Accept: Boolean);
begin
  if Assigned(OnSetCloseUp) then
    OnSetCloseUp(Self, Accept);
end;

procedure TMRUListEh.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if Assigned(FOnActiveChanged) then
      OnActiveChanged(Self);
  end;
end;

procedure TMRUListEh.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TMRUListEh.SetLimit(const Value: Integer);
begin
  if FLimit <> Value then
  begin
    FLimit := Value;
    UpdateLimit;
  end;
end;

procedure TMRUListEh.UpdateLimit;
begin
  while Items.Count > FLimit do
    Items.Delete(0);
end;

procedure TMRUListEh.SetRows(const Value: Integer);
begin
  FRows := Value;
end;

procedure TMRUListEh.Assign(Source: TPersistent);
begin
  if Source is TMRUListEh then
  begin
    Active := TMRUListEh(Source).Active;
    Items := TMRUListEh(Source).Items;
    Limit := TMRUListEh(Source).Limit;
    Rows := TMRUListEh(Source).Rows;
    CaseSensitive := TMRUListEh(Source).CaseSensitive;
  end else
    inherited Assign(Source);
end;

procedure TMRUListEh.Add(s: String);
var
  i: Integer;
begin
  if Trim(s) = '' then Exit;
  for i := 0 to Items.Count-1 do
    if (CaseSensitive and (s = Items[i])) or
       (not CaseSensitive and (AnsiCompareText(s, Items[i]) = 0)) then
    begin
      Items.Move(i, Items.Count-1);
      Exit;
    end;
  Items.Add(s);
  UpdateLimit;
end;

function TMRUListEh.FilterItemsTo(FilteredItems: TStrings; MaskText: String): Boolean;
var
  i: Integer;
  Accept: Boolean;
  CharMsg: TMsg;
begin
  Result := True;
  FilteredItems.BeginUpdate;
  try
    FilteredItems.Clear;
    for i := 0 to Items.Count-1 do
    begin
      Accept := False;
      if CaseSensitive
        then Accept := (AnsiCompareStr(Copy(Items[i], 1, Length(MaskText)), MaskText) = 0)
        else Accept := (AnsiCompareText(Copy(Items[i], 1, Length(MaskText)), MaskText) = 0);
      if Assigned(OnFilterItem) then
        OnFilterItem(Self, Accept);
      if Accept then FilteredItems.Add(Items[i]);
      if (i mod 100 = 0) and CancelIfKeyInQueue then
        if PeekMessage(CharMsg, 0, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
        begin
          Result := False;
          Exit;
        end;
    end;
  finally
    FilteredItems.EndUpdate;
  end;
end;

{ TPopupListboxEh }

constructor TPopupListboxEh.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  ControlStyle := ControlStyle + [csReplicatable]; //Really not Replicatable, only for CtrlGrid
  Style := lbOwnerDrawFixed;
  FSizeGrip := TSizeGripEh.Create(Self);
  TabStop := False;
  with FSizeGrip do
  begin
    Parent := Self;
    TriangleWindow := True;
  end;
  FMousePos := Point(-1,-1);
{$IFDEF EH_LIB_6}
  OnData := SelfOnGetData;
{$ENDIF}
end;

procedure TPopupListboxEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN;
//    Style := Style or WS_POPUP;
    if not Ctl3D then
      Style := Style or WS_BORDER;
    ExStyle := (ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST) and not WS_EX_CLIENTEDGE;
    WindowClass.Style := CS_SAVEBITS;
//    Params.WndParent := GetDesktopWindow;
  end;
end;

procedure TPopupListboxEh.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

procedure TPopupListboxEh.DrawItem(Index: Integer; ARect: TRect; State: TOwnerDrawState);
var
  X: Integer;
  ImRect: TRect;
  ImageIndex: Integer;
begin
  if ImageList = nil then
    inherited DrawItem(Index, ARect, State)
  else
  begin
    if UseRightToLeftAlignment
      then ImRect := Rect(ARect.Right, ARect.Top, ARect.Right - ImageList.Width - 4, ARect.Bottom)
      else ImRect := Rect(0, ARect.Top, ImageList.Width + 4, ARect.Bottom);
    ImageIndex := Index;
    if Assigned(OnGetImageIndex) then
      OnGetImageIndex(Owner, Index, ImageIndex);
    DrawImage(Canvas.Handle, ImRect, ImageList, ImageIndex, odSelected in State);
    if UseRightToLeftAlignment
      then Dec(ARect.Right, ImageList.Width + 4)
      else Inc(ARect.Left, ImageList.Width + 4);
//    Canvas.FillRect(ARect);
    if UseRightToLeftAlignment
      then X := ARect.Right - Canvas.TextWidth(Items[Index]) - 2
      else X := ImageList.Width + 5;
    if Index < Items.Count then
      WindowsExtTextOut(Canvas.Handle, X, ARect.Top, ETO_OPAQUE or ETO_CLIPPED,
        ARect, Items[Index], Length(Items[Index]));
//      DrawText(Canvas.Handle, PChar(Items[Index]), Length(Items[Index]), ARect,
//        DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
  end;
end;

function TPopupListboxEh.CheckNewSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  if NewWidth < GetSystemMetrics(SM_CXVSCROLL) then
    NewWidth := GetSystemMetrics(SM_CXVSCROLL);
  if NewHeight < GetSystemMetrics(SM_CYVSCROLL) then
    NewHeight := GetSystemMetrics(SM_CYVSCROLL);
end;

function TPopupListboxEh.GetBorderSize: Integer;
var
  Params: TCreateParams;
  R: TRect;
begin
  CreateParams(Params);
  SetRect(R, 0, 0, 0, 0);
  AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
  Result := R.Bottom - R.Top + FBorderWidth*2;
end;

function TPopupListboxEh.GetTextHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight;
end;

procedure TPopupListboxEh.KeyPress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27: FSearchText := '';
    #32..High(Char):
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 2000 then FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        SendTextMessage(Handle, LB_SelectString, WORD(-1), FSearchText);
        Key := #0;
      end;
  end;
  inherited Keypress(Key);
end;

procedure TPopupListboxEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if ((FMousePos.X <> X) or (FMousePos.Y <> Y)) and ([ssLeft, ssRight, ssMiddle] * Shift = []) then
  begin
    Index := ItemAtPos(Point(X, Y), True);
    if Index >= 0 then ItemIndex := Index;
  end;
  FMousePos := Point(X, Y);
end;

procedure TPopupListboxEh.CMSetSizeGripChangePosition(var Message: TMessage);
begin
  FSizeGrip.ChangePosition(TSizeGripChangePosition(Message.WParam));
end;

procedure TPopupListboxEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWnd;
end;

procedure TPopupListboxEh.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  if ImageList = nil then
    inherited
  else
{$IFDEF CIL}
    with Message.DrawItemStruct do
    begin
  { DONE : LongRec(itemState).Lo }
      State := TOwnerDrawState(LoWord(itemState));
{$ELSE}
    with Message.DrawItemStruct^ do
    begin
{$IFDEF EH_LIB_5}
      State := TOwnerDrawState(LongRec(itemState).Lo);
{$ELSE}
      State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
{$ENDIF}
{$ENDIF}
      Canvas.Handle := hDC;
      Canvas.Font := Font;
      Canvas.Brush := Brush;
      if (Integer(itemID) >= 0) and (odSelected in State) then
      begin
        Canvas.Brush.Color := clHighlight;
        Canvas.Font.Color := clHighlightText
      end;
      if Integer(itemID) >= 0
        then DrawItem(itemID, rcItem, State)
        else Canvas.FillRect(rcItem);
{$IFDEF CIL}
  { TODO : To do rcItem.Right is not left side assigned}
{$ELSE}
      if UseRightToLeftAlignment
        then Dec(rcItem.Right, ImageList.Width + 4)
        else Inc(rcItem.Left, ImageList.Width + 4);
{$ENDIF}
      if odFocused in State
        then DrawFocusRect(hDC, rcItem);
      Canvas.Handle := 0;
    end;
end;

procedure TPopupListboxEh.SetImageList(const Value: TCustomImageList);
begin
  FImageList := Value;
end;

procedure TPopupListboxEh.SetRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  Height := Value * ItemHeight + GetBorderSize;
end;

procedure TPopupListboxEh.WMSize(var Message: TWMSize);
begin
  inherited;
  FSizeGrip.UpdatePosition;
  FSizeGripResized := True;
end;

procedure TPopupListboxEh.WMNCCalcSize(var Message: TWMNCCalcSize);
{$IFDEF CIL}
var
  r: TNCCalcSizeParams;
begin
  inherited;
  r := Message.CalcSize_Params;
  InflateRect(r.rgrc0, -FBorderWidth, -FBorderWidth);
  Message.CalcSize_Params := r;
end;
{$ELSE}
begin
  inherited;
  with Message.CalcSize_Params^ do
    InflateRect(rgrc[0], -FBorderWidth, -FBorderWidth);
end;
{$ENDIF}

procedure TPopupListboxEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;

procedure TPopupListboxEh.DrawBorder;
var
  DC: HDC;
  R: TRect;
begin
  if Ctl3D = True then
  begin
    DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
      InflateRect(R, -1, -1);
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TPopupListboxEh.WMWindowPosChanging(var Message: TWMWindowPosChanging);
{$IFDEF CIL}
var
  r: TWindowPos;
begin
  r := Message.WindowPos;
  if ComponentState * [csReading, csDestroying] = [] then
    with r do
      if (flags and SWP_NOSIZE = 0) and not CheckNewSize(cx, cy) then
        flags := flags or SWP_NOSIZE;
  Message.WindowPos := r;
  inherited;
end;
{$ELSE}
begin
  if ComponentState * [csReading, csDestroying] = [] then
    with Message.WindowPos^ do
      if (flags and SWP_NOSIZE = 0) and not CheckNewSize(cx, cy) then
        flags := flags or SWP_NOSIZE;
  inherited;
end;
{$ENDIF}

procedure TPopupListboxEh.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  BorderSize, TextHeight, Rows: Integer;
begin
  BorderSize := GetBorderSize;
  TextHeight := ItemHeight;
  if TextHeight = 0 then TextHeight := GetTextHeight;
  Rows := (AHeight - BorderSize) div TextHeight;
  if Rows < 1 then Rows := 1;
  FRowCount := Rows;
  inherited SetBounds(ALeft, ATop, AWidth, Rows * TextHeight + BorderSize);
end;

function TPopupListboxEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    TopIndex := TopIndex + 1;
    Result := True;
  end;
end;

function TPopupListboxEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    TopIndex := TopIndex - 1;
    Result := True;
  end;
end;

procedure TPopupListboxEh.UpdateBorderWidth;
begin
  if Ctl3D
    then FBorderWidth := 2
    else FBorderWidth := 0;
end;

function TPopupListboxEh.CanFocus: Boolean;
begin
  Result := False;
end;

function TPopupListboxEh.GetExtItems: TStrings;
begin
  Result := FExtItems;
end;

procedure TPopupListboxEh.SetExtItems(Value: TStrings);
begin
  if FExtItems <> Value then
  begin
    FExtItems := Value;
{$IFDEF EH_LIB_6}
    if FExtItems <> nil
      then Style := lbVirtualOwnerDraw
      else Style := lbOwnerDrawFixed;
{$ENDIF}
  end;
end;

procedure TPopupListboxEh.SelfOnGetData(Control: TWinControl; Index: Integer; var Data: string);
begin
  if FExtItems <> nil then
    Data := FExtItems[Index];
end;

type
  TScrollBarCracker = class(TScrollBar) end;

{ TMRUListboxEh }

constructor TMRUListboxEh.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FScrollBar := TScrollBar.Create(Self);
{$IFDEF CIL}
  with FScrollBar do
{$ELSE}
  with TScrollBarCracker(FScrollBar) do
{$ENDIF}
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    Kind := sbVertical;
    Parent := Self;
    Width := GetSystemMetrics(SM_CXVSCROLL);
    WindowProc := ScrollBarWindowProc;
    TabStop := False;
  end;
end;

procedure TMRUListboxEh.CMSetSizeGripChangePosition(var Message: TMessage);
begin
  inherited;
  UpdateScrollBar;
end;

procedure TMRUListboxEh.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not (WS_HSCROLL or WS_VSCROLL);
end;

procedure TMRUListboxEh.ScrollBarScrolled(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
end;

procedure TMRUListboxEh.ScrollBarWindowProc(var Message: TMessage);
begin
  if Message.Msg = CN_VSCROLL then
  begin
    Perform(WM_VSCROLL, Message.WParam, 0);
//    UpdateScrollBar;
  end
  else if (Message.Msg = WM_MOVE) and not FScrollBarLockMove then
  begin
    UpdateScrollBarPos;
    UpdateScrollBar;
    Message.Result := 0;
    Exit;
  end;
{$IFDEF CIL}
  IControl(FScrollBar).WndProc(Message);
{$ELSE}
  TWinControlCracker(FScrollBar).WndProc(Message);
{$ENDIF}
end;

procedure TMRUListboxEh.UpdateScrollBar;
var
  Max, VisibleRowCount: Integer;
begin
  if not HandleAllocated then Exit;
  FScrollBar.Ctl3D := False;
//  FScrollBar.SetBounds(FSizeGrip.Left, FSizeGrip.Top, FSizeGrip.Width, FSizeGrip.Height);
  FScrollBarLockMove := True;
  try
    if SizeGrip.Position = sgpBottomRight then
      FScrollBar.SetBounds(ClientWidth-FScrollBar.Width, 0, FScrollBar.Width, ClientHeight-FSizeGrip.Height)
    else if SizeGrip.Position = sgpTopRight then
      FScrollBar.SetBounds(ClientWidth-FScrollBar.Width, FSizeGrip.Height, FScrollBar.Width, ClientHeight-FSizeGrip.Height)
    else
      FScrollBar.SetBounds(ClientWidth-FScrollBar.Width, 0, FScrollBar.Width, ClientHeight);
  finally
    FScrollBarLockMove := False;
  end;
  FScrollBar.PageSize := 0;
  VisibleRowCount := ClientHeight div ItemHeight;
  Max := Items.Count;
  if (Max > 0) and (VisibleRowCount < Max) then
  begin
    FScrollBar.SetParams(TopIndex, 0, Items.Count-1);
    FScrollBar.PageSize := VisibleRowCount;
    FScrollBar.Visible := True;
    if SizeGrip.Position in [sgpBottomRight, sgpTopRight]
      then SizeGrip.TriangleWindow := False
      else SizeGrip.TriangleWindow := True;
  end else
  begin
    FScrollBar.Visible := False;
    SizeGrip.TriangleWindow := True;
  end;
end;

procedure TMRUListboxEh.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateScrollBar;
end;

procedure TMRUListboxEh.UpdateScrollBarPos;
begin
  FScrollBarLockMove := True;
  try
    if SizeGrip.Position = sgpBottomRight then
      MoveWindow(FScrollBar.Handle, ClientWidth-FScrollBar.Width, 0, FScrollBar.Width, ClientHeight-FSizeGrip.Height, True)
    else if SizeGrip.Position = sgpTopRight then
      MoveWindow(FScrollBar.Handle, ClientWidth-FScrollBar.Width, FSizeGrip.Height, FScrollBar.Width, ClientHeight-FSizeGrip.Height, True)
    else
      MoveWindow(FScrollBar.Handle, ClientWidth-FScrollBar.Width, 0, FScrollBar.Width, ClientHeight, True);
  finally
    FScrollBarLockMove := False;
  end;
end;

procedure TMRUListboxEh.CMMouseWheel(var Message: TCMMouseWheel);
begin
  inherited;
  UpdateScrollBarPos;
  UpdateScrollBar;
end;

procedure TMRUListboxEh.CMChanged(var Message: TCMChanged);
begin
  inherited;
  UpdateScrollBarPos;
  UpdateScrollBar;
end;

{$IFNDEF EH_LIB_5} // Delphi 4 doesn't have TObjectList but Delphi 8 required

{ TObjectList }

function TObjectList.Add(AObject: TObject): Integer;
begin
  Result := inherited Add(AObject);
end;

constructor TObjectList.Create;
begin
  inherited Create;
  FOwnsObjects := True;
end;

constructor TObjectList.Create(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

function TObjectList.FindInstanceOf(AClass: TClass; AExact: Boolean;
  AStartAt: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := AStartAt to Count - 1 do
    if (AExact and
        (Items[I].ClassType = AClass)) or
       (not AExact and
        Items[I].InheritsFrom(AClass)) then
    begin
      Result := I;
      break;
    end;
end;

function TObjectList.GetItem(Index: Integer): TObject;
begin
  Result := inherited Items[Index];
end;

function TObjectList.IndexOf(AObject: TObject): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

procedure TObjectList.Insert(Index: Integer; AObject: TObject);
begin
  inherited Insert(Index, AObject);
end;

function TObjectList.Remove(AObject: TObject): Integer;
begin
  Result := inherited Remove(AObject);
end;

procedure TObjectList.SetItem(Index: Integer; AObject: TObject);
begin
  inherited Items[Index] := AObject;
end;

{$ENDIF}

{ TDataLinkEh }

{$IFDEF CIL}
procedure TDataLinkEh.DataEvent(Event: TDataEvent; Info: TObject);
{$ELSE}
procedure TDataLinkEh.DataEvent(Event: TDataEvent; Info: Integer);
{$ENDIF}
begin
  inherited DataEvent(Event, Info);
  if Assigned(OnDataEvent) then
    OnDataEvent(Event, Info);
end;

{ TDatasetFieldValueListEh }

constructor TDatasetFieldValueListEh.Create;
begin
  inherited Create;
  FValues := TStringList.Create;
  FValues.Sorted := True;
  FValues.Duplicates := dupIgnore;
  FDataSource := TDataSource.Create(nil);
  FDataLink := TDataLinkEh.Create;
  FDataLink.OnDataEvent := DataSetEvent;
end;

destructor TDatasetFieldValueListEh.Destroy;
begin
  FreeAndNil(FValues);
  FDataSource.DataSet := nil;
  FreeAndNil(FDataSource);
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

function TDatasetFieldValueListEh.GetValues: TStrings;
begin
  if FDataObsoleted then
    RefreshValues;
  Result := FValues;
end;

procedure TDatasetFieldValueListEh.SetFieldName(const Value: String);
begin
  if FFieldName <> Value then
  begin
    FDataObsoleted := True;
    FFieldName := Value;
  end;
end;

procedure TDatasetFieldValueListEh.SetDataSet(const Value: TDataSet);
begin
  DataSource := nil;
  FDataLink.DataSource := FDataSource;
  if FDataLink.DataSet <> Value then
  begin
    FDataObsoleted := True;
    FDataSource.DataSet := Value;
  end;
end;

function TDatasetFieldValueListEh.GetDataSet: TDataSet;
begin
  Result := FDataSource.DataSet;
end;

procedure TDatasetFieldValueListEh.SetDataSource(const Value: TDataSource);
begin
  if FDataLink.DataSource <> Value then
  begin
    FDataObsoleted := True;
    FDataLink.DataSource := Value;
  end;
end;

function TDatasetFieldValueListEh.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDatasetFieldValueListEh.RefreshValues;
var
  Field: TField;
begin
  FValues.Clear;
  if not FDataLink.Active or (FDataLink.DataSet.FindField(FieldName) = nil) then
    Exit;
  Field := FDataLink.DataSet.FindField(FieldName);
  FDataLink.DataSet.DisableControls;
  try
    FDataLink.DataSet.First;
    while not FDataLink.DataSet.Eof do
    begin
      FValues.Add(Field.AsString);
      FDataLink.DataSet.Next;
    end;
  finally
    FDataLink.DataSet.EnableControls;
  end;
  FDataObsoleted := False;
end;

{$IFDEF CIL}
procedure TDatasetFieldValueListEh.DataSetEvent(Event: TDataEvent; Info: TObject);
{$ELSE}
procedure TDatasetFieldValueListEh.DataSetEvent(Event: TDataEvent; Info: Integer);
{$ENDIF}
begin
  if Event in [deDataSetChange, dePropertyChange, deFieldListChange] then
    FDataObsoleted := True;
end;

{$IFNDEF EH_LIB_6}

{ TStringListEh }

function StringListCompareStrings(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := TStringListEh(List).CompareStrings(List[Index1], List[Index2]);
end;

procedure TStringListEh.Sort;
begin
  CustomSort(StringListCompareStrings);
end;

procedure TStringListEh.SetCaseSensitive(const Value: Boolean);
begin
  if Value <> FCaseSensitive then
  begin
    FCaseSensitive := Value;
    if Sorted then Sort;
  end;
end;

function TStringListEh.CompareStrings(const S1, S2: string): Integer;
begin
  if CaseSensitive then
    Result := AnsiCompareStr(S1, S2)
  else
    Result := AnsiCompareText(S1, S2);
end;

{$IFNDEF EH_LIB_5}

procedure TStringListEh.QuickSort(L, R: Integer; SCompare: TStringListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        Exchange(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure TStringListEh.CustomSort(Compare: TStringListSortCompare);
begin
  if not Sorted and (Count > 1) then
  begin
    Changing;
    QuickSort(0, Count - 1, Compare);
    Changed;
  end;
end;

{$ENDIF}

{$ENDIF}

{ TBMListEh }

constructor TBMListEh.Create;
begin
  inherited Create;
{$IFDEF EH_LIB_12}
  SetLength(FList, 0);
{$ELSE}
  FList := TStringList.Create;
  FList.OnChange := DataChanged;
{$ENDIF}
end;

destructor TBMListEh.Destroy;
begin
  Clear;
  UpdateState;
{$IFDEF EH_LIB_12}
{$ELSE}
  FreeAndNil(FList);
{$ENDIF}
  inherited Destroy;
end;

procedure TBMListEh.Delete;
var
  I: Integer;
begin
  with Dataset do
  begin
    DisableControls;
    try
{$IFDEF EH_LIB_12}
      for I := Length(FList) - 1 downto 0 do
{$ELSE}
      for I := FList.Count - 1 downto 0 do
{$ENDIF}
      begin
        Bookmark := FList[I];
        Delete;
        DeleteItem(I);
      end;
    finally
      EnableControls;
    end;
  end;
  UpdateState;
end;

function TBMListEh.IndexOf(const Item: TUniBookmarkEh): Integer;
begin
  if not Find(Item, Result) then
    Result := -1;
end;

function TBMListEh.GetCount: Integer;
begin
{$IFDEF EH_LIB_12}
  Result := Length(FList);
{$ELSE}
  Result := FList.Count;
{$ENDIF}
end;

function TBMListEh.GetCurrentRowSelected: Boolean;
var
  Index: Integer;
begin
  Result := Find(CurrentRow, Index);
end;

function TBMListEh.GetItem(Index: Integer): TUniBookmarkEh;
begin
  Result := FList[Index];
end;

procedure TBMListEh.SetItem(Index: Integer; Item: TUniBookmarkEh);
begin
  FList[Index] := Item;
end;

function TBMListEh.Refresh: Boolean;
var
  I: Integer;
begin
  Result := False;
  with Dataset do
  try
    CheckBrowseMode;
    for I := GetCount - 1 downto 0 do
      if not DatasetBookmarkValid(Dataset, FList[I]) then
      begin
        Result := True;
        DeleteItem(I);
      end;
  finally
    UpdateState;
    UpdateCursorPos;
    if Result then Invalidate;
  end;
end;

procedure TBMListEh.SelectAll;
var
  bm: TUniBookmarkEh;
begin
  if not FLinkActive then Exit;
  with Dataset do
  begin
    DisableControls;
    try
      bm := Bookmark;
      First;
      while EOF = False do
      begin
        SetCurrentRowSelected(True);
        Next;
      end;
      Bookmark := bm;
    finally
      EnableControls;
    end;
  end;
end;

procedure TBMListEh.DataChanged(Sender: TObject);
begin
{$IFDEF EH_LIB_12}
  FCache := nil;
{$ELSE}
  FCache := '';
{$ENDIF}
  FCacheIndex := -1;
end;

procedure TBMListEh.SetCurrentRowSelected(Value: Boolean);
var
  Index: Integer;
  Current: TUniBookmarkEh;
begin
  Current := CurrentRow;
  if Find(Current, Index) = Value
    then Exit;
  if Value
    then InsertItem(Index, Current)
    else DeleteItem(Index);
//  ListChanged();
end;

function TBMListEh.CurrentRow: TUniBookmarkEh;
begin
  if not FLinkActive then RaiseBMListError(sDataSetClosed);
  Result := Dataset.Bookmark;
end;

function TBMListEh.Compare(const Item1, Item2: TUniBookmarkEh): Integer;
begin
  with Dataset do
    Result := DataSetCompareBookmarks(Dataset, Item1, Item2);
end;

procedure TBMListEh.Clear;
begin
{$IFDEF EH_LIB_12}
  if Length(FList) = 0 then Exit;
  SetLength(FList, 0);
{$ELSE}
  if FList.Count = 0 then Exit;
  FList.Clear;
{$ENDIF}
  UpdateState;
  Invalidate;
end;

procedure TBMListEh.CustomSort(DataSet: TDataSet; Compare: TBMListSortCompare);
begin
  if (Count > 1) then
    QuickSort(DataSet, 0, Count - 1, Compare);
end;

procedure TBMListEh.QuickSort(DataSet: TDataSet; L, R: Integer; SCompare: TBMListSortCompare);
var
  I, J, P: Integer;
  T: TUniBookmarkEh;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, DataSet, I, P) < 0 do Inc(I);
      while SCompare(Self, DataSet, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        if I <> J then
        begin
          T := FList[I];
          FList[I] := FList[J];
          FList[J] := T;
//          ExchangeItems(I, J);
        end;
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(DataSet, L, J, SCompare);
    L := I;
  until I >= R;
end;

function TBMListEh.Find(const Item: TUniBookmarkEh; var Index: Integer): Boolean;
var
  L, H, I, C: Integer;
begin
  if (Item = FCache) and (FCacheIndex >= 0) then
  begin
    Index := FCacheIndex;
    Result := FCacheFind;
    Exit;
  end;
  Result := False;
  L := 0;
  H := GetCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := Compare(FList[I], Item);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        L := I;
      end;
    end;
  end;
  Index := L;
  FCache := Item;
  FCacheIndex := Index;
  FCacheFind := Result;
end;

procedure TBMListEh.RaiseBMListError(const S: string);
begin
  raise Exception.Create(S);
end;

procedure TBMListEh.LinkActive(Value: Boolean);
begin
  Clear;
  UpdateState;
  FLinkActive := Value;
end;

procedure TBMListEh.UpdateState;
begin
end;

procedure TBMListEh.Invalidate;
begin
end;

function TBMListEh.GetDataSet: TDataSet;
begin
  Result := nil;
end;

procedure TBMListEh.DeleteItem(Index: Integer);
{$IFDEF EH_LIB_12}
var
  Temp: Pointer;
begin
  if (Index < 0) or (Index >= Count) then
    raise EListError.Create(SListIndexError);
  Temp := FList[Index];
  // The Move below will overwrite this slot, so we need to finalize it first
  FList[Index] := nil;
  if Index < Count-1 then
  begin
    System.Move(FList[Index + 1], FList[Index],
      (Count - Index - 1) * SizeOf(Pointer));
    // Make sure we don't finalize the item that was in the last position.
    PPointer(@FList[Count-1])^ := nil;
  end;
  SetLength(FList, Count-1);
  DataChanged(Temp);
end;
{$ELSE}
begin
  FList.Delete(Index);
end;
{$ENDIF}

procedure TBMListEh.InsertItem(Index: Integer; Item: TUniBookmarkEh);
{$IFDEF EH_LIB_12}
begin
  if (Index < 0) or (Index > Count) then
    raise EListError.Create(SListIndexError);
  SetLength(FList, Count + 1);
  if Index < Count - 1 then
  begin
    Move(FList[Index], FList[Index + 1],
      (Count - Index - 1) * SizeOf(Pointer));
    // The slot we opened up with the Move above has a dangling pointer we don't want finalized
    PPointer(@FList[Index])^ := nil;
  end;
  FList[Index] := Item;
  DataChanged(TObject(Item));
end;
{$ELSE}
begin
  FList.Insert(Index, Item)
end;
{$ENDIF}

procedure TBMListEh.AppendItem(Item: TUniBookmarkEh);
{$IFDEF EH_LIB_12}
begin
  InsertItem(GetCount, Item);
end;
{$ELSE}
begin
  FList.Add(Item)
end;
{$ENDIF}

{ TEditButtonActionLinkEh }
procedure TEditButtonActionLinkEh.AssignClient(AClient: TObject);
begin
  FClient := AClient as TEditButtonEh;
end;

function TEditButtonActionLinkEh.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TEditButtonActionLinkEh.IsHintLinked: Boolean;
begin
  Result := inherited IsHintLinked and
    (FClient.Hint = (Action as TCustomAction).Hint);
end;

function TEditButtonActionLinkEh.IsShortCutLinked: Boolean;
begin
  Result := inherited IsShortCutLinked and
    (FClient.ShortCut = (Action as TCustomAction).ShortCut);
end;

function TEditButtonActionLinkEh.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

procedure TEditButtonActionLinkEh.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TEditButtonActionLinkEh.SetHint(const Value: string);
begin
  if IsHintLinked then FClient.Hint := Value;
end;

procedure TEditButtonActionLinkEh.SetShortCut(Value: TShortCut);
begin
  if IsShortCutLinked then FClient.ShortCut := Value;
end;

procedure TEditButtonActionLinkEh.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

function KillMouseUp(Control: TControl; Area: TRect): Boolean;
var
  p: TPoint;
  Msg: TMsg;
  WinControl: TWinControl;
begin
  Result := False;
  if Control is TWinControl
    then WinControl := TWinControl(Control)
    else WinControl := Control.Parent;
  if PeekMessage(Msg, WinControl.Handle, WM_LBUTTONDOWN, WM_LBUTTONDBLCLK, PM_NOREMOVE) then
  begin
    if (Msg.message = WM_LBUTTONDOWN) or (Msg.message = WM_LBUTTONDBLCLK) then
    begin
      P := SmallPointToPoint(LongintToSmallPoint(Msg.lParam));
      if (WinControl = Control) or
         (WinControl.ControlAtPos(P, True) = Control) then
      begin
        P := Control.ScreenToClient(WinControl.ClientToScreen(P));
        if PtInRect(Control.ClientRect, P) then
        begin
          PeekMessage(Msg, WinControl.Handle, Msg.message, Msg.message, PM_REMOVE);
          Result := True;
        end;
      end;
    end;
  end;
end;

function KillMouseUp(Control: TControl): Boolean;
var
  p: TPoint;
  Msg: TMsg;
  WinControl: TWinControl;
begin
  Result := False;
  if Control is TWinControl
    then WinControl := TWinControl(Control)
    else WinControl := Control.Parent;
  if PeekMessage(Msg, WinControl.Handle, WM_LBUTTONDOWN, WM_LBUTTONDBLCLK, PM_NOREMOVE) then
  begin
    if (Msg.message = WM_LBUTTONDOWN) or (Msg.message = WM_LBUTTONDBLCLK) then
    begin
      P := SmallPointToPoint(LongintToSmallPoint(Msg.lParam));
      if WinControl.ControlAtPos(P, True) = Control then
      begin
        PeekMessage(Msg, WinControl.Handle, Msg.message, Msg.message, PM_REMOVE);
        Result := True;
      end;
    end;
  end;
end;

procedure FillGradientEh(Canvas: TCanvas; ARect: TRect; FromColor, ToColor: TColor);
var
  h,i: Integer;
  rgb1, rgb2: Integer;
  a1,a2,a3, b1,b2,b3: Integer;
  r, g, b: Double;
begin

  rgb1 := ColorToRGB(FromColor);
  a1 := rgb1 and $FF;
  a2 := (rgb1 shr 8) and $FF;
  a3 := (rgb1 shr 16) and $FF;

  rgb2 := ColorToRGB(ToColor);
  b1 := rgb2 and $FF;
  b2 := (rgb2 shr 8) and $FF;
  b3 := (rgb2 shr 16) and $FF;

  h := ARect.Bottom - ARect.Top - 1;
  if h=0 then Exit;

  for i := 0 to h do
  begin
    r := a1-(a1-b1) / h*i;
    g := a2-(a2-b2) / h*i;
    b := a3-(a3-b3) / h*i;
    Canvas.Pen.Color := TColor((Max(Min(Round(b), 255),0) shl 16)
                            or (Max(Min(Round(g), 255),0) shl 8)
                            or Max(Min(Round(r), 255),0));

    if ARect.Right - ARect.Left <= 1
    then
      Canvas.Polyline([Point(ARect.Left, ARect.Top+i),
                       Point(ARect.Right,ARect.Top+i)])
    else
      Canvas.Rectangle(ARect.Left, ARect.Top+i, ARect.Right, ARect.Top+i+1);
//    Canvas.FillRect(Rect(ARect.Left, ARect.Top+i, ARect.Right, ARect.Top+i+1));
  end;
end;

procedure FillGradientEh(Canvas: TCanvas; TopLeft: TPoint;
  Points: array of TPoint; FromColor, ToColor: TColor);
var
  h,i,h1: Integer;
  rgb1, rgb2: Integer;
  a1,a2,a3, b1,b2,b3: Integer;
  r, g, b: Double;
begin

  rgb1 := ColorToRGB(FromColor);
  a1 := rgb1 and $FF;
  a2 := (rgb1 shr 8) and $FF;
  a3 := (rgb1 shr 16) and $FF;

  rgb2 := ColorToRGB(ToColor);
  b1 := rgb2 and $FF;
  b2 := (rgb2 shr 8) and $FF;
  b3 := (rgb2 shr 16) and $FF;

  h := Length(Points) div 2 - 1;

  for i := 0 to h do
  begin
    h1 := h;
    if h1 = 0 then h1 := 1;
    r := a1-(a1-b1) / h1 * i;
    g := a2-(a2-b2) / h1 * i;
    b := a3-(a3-b3) / h1 * i;
    Canvas.Pen.Color := TColor((Max(Min(Round(b), 255),0) shl 16)
                            or (Max(Min(Round(g), 255),0) shl 8)
                            or Max(Min(Round(r), 255),0));

    Canvas.Polyline(
      [Point(TopLeft.X + Points[i*2].X, TopLeft.Y + Points[i*2].Y),
       Point(TopLeft.X+Points[i*2+1].X, TopLeft.Y + Points[i*2+1].Y)]);
//    Canvas.Rectangle(TopLeft.X + Points[i*2].X, TopLeft.Y + Points[i*2].Y,
//      TopLeft.X+Points[i*2+1].X, TopLeft.Y + Points[i*2+1].Y + 1);
//    Canvas.Rectangle(Rect.Left, Rect.Top+i, Rect.Right, Rect.Top+i+1);
  end;
end;

function ApproachToColorEh(FromColor, ToColor: TColor; Percent: Integer): TColor;
var
  r, g, b: Double;
  rgb: Longint;
  r_c, g_c, b_c: Double;
  rgb_c: Longint;
begin
  rgb := ColorToRGB(FromColor);
  r := rgb and $FF;
  g := (rgb shr 8) and $FF;
  b := (rgb shr 16) and $FF;

  rgb_c := ColorToRGB(ToColor);
  r_c := rgb_c and $FF;
  g_c := (rgb_c shr 8) and $FF;
  b_c := (rgb_c shr 16) and $FF;

  r := r + (r_c - r) * Percent / 100;
  g := g + (g_c - g) * Percent / 100;
  b := b + (b_c - b) * Percent / 100;

  Result := TColor((Max(Min(Round(b), 255),0) shl 16)
                or (Max(Min(Round(g), 255),0) shl 8)
                or Max(Min(Round(r), 255),0));
end;

function ThemesEnabled: Boolean;
begin
{$IFDEF EH_LIB_7}
  Result := ThemeServices.ThemesEnabled;
{$ELSE}
  Result := False;
{$ENDIF}
end;

(*
type
  TGradientFill = function(DC: HDC; Vertex: PTriVertex; NumVertex: ULONG; Mesh: Pointer; NumMesh, Mode: ULONG): BOOL; stdcall;
const
  sGradientFill = 'GradientFill';
var
  MsImgHandle: HMODULE;
  MsImgInitialized: Boolean;
  GradientFillFunc: TGradientFill;

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);
const
  cGradientDirections: array[TGradientDirection] of Cardinal =
    (GRADIENT_FILL_RECT_H, GRADIENT_FILL_RECT_V);
var
  StartColor, EndColor: Cardinal;
  Vertexes: array[0..1] of TTriVertex;
  GradientRect: TGradientRect;
begin
  // The GradientFill API is not supported on NT4 do we'll try to dynamically load
  // the DLL and call the API.
  if not MsImgInitialized then
  begin
    MsImgHandle := LoadLibrary(msimg32);
    if MsImgHandle <> 0 then
      GradientFillFunc := GetProcAddress(MsImgHandle, PAnsiChar(AnsiString(sGradientFill)));
    MsImgInitialized := True;
  end;

  // If we didn't find the GradientFill API simply exit leaving the canvas unmodified
  if not Assigned(GradientFillFunc) then
  begin
    FillGradientEh(ACanvas, ARect, AStartColor, AEndColor);
    exit;
  end;

  StartColor := ColorToRGB(AStartColor);
  EndColor := ColorToRGB(AEndColor);

  Vertexes[0].x := ARect.Left;
  Vertexes[0].y := ARect.Top;
  Vertexes[0].Red := GetRValue(StartColor) shl 8;
  Vertexes[0].Blue := GetBValue(StartColor) shl 8;
  Vertexes[0].Green := GetGValue(StartColor) shl 8;
  Vertexes[0].Alpha := 0;

  Vertexes[1].x := ARect.Right;
  Vertexes[1].y := ARect.Bottom;
  Vertexes[1].Red := GetRValue(EndColor) shl 8;
  Vertexes[1].Blue := GetBValue(EndColor) shl 8;
  Vertexes[1].Green := GetGValue(EndColor) shl 8;
  Vertexes[1].Alpha := 0;

  GradientRect.UpperLeft := 0;
  GradientRect.LowerRight := 1;

  GradientFillFunc(ACanvas.Handle, @Vertexes[0], 2, @GradientRect, 1,
    cGradientDirections[Direction]);
end;
*)

initialization
  FlatButtonWidth := GetDefaultFlatButtonWidth;
  ButtonsBitmapCache := TButtonsBitmapCache.Create;
  GetCheckSize;
finalization
  FreeAndNil(ButtonsBitmapCache);
end.
