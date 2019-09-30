{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{     TDBEditEh, TDBDateTimeEditEh, TDBComboBoxEh,      }
{      TDBNumberEditEh, TDBCheckBoxEh components        }
{                     (Build 5.0.01)                    }
{                                                       }
{     Copyright (c) 2001-2009 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBCtrlsEh;

interface

uses Windows, SysUtils, Messages, Classes, Controls, Forms, Graphics, Menus,
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF EH_LIB_6} Variants, StrUtils, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, Db, DBCtrls, Imglist,
  ToolCtrlsEh, ActnList, Consts, Math;

const
  CM_EDITIMAGECHANGEDEH = WM_USER + 101;
//  CM_IGNOREEDITDOWN = WM_USER + 102;

type

{ IInplaceEditHolderEh }

  IInplaceEditHolderEh = interface
    ['{4BE708F1-4EA2-4AC7-BA64-89D7D2B83E09}']
    function InplaceEditCanModify(Control: TWinControl): Boolean;
    procedure GetMouseDownInfo(var Pos: TPoint; var Time: LongInt);
    procedure InplaceEditWndProc(Control: TWinControl; var Message: TMessage);
    procedure InplaceEditKeyDown(Control: TWinControl; var Key: Word; Shift: TShiftState);
    procedure InplaceEditKeyPress(Control: TWinControl; var Key: Char);
    procedure InplaceEditKeyUp(Control: TWinControl; var Key: Word; Shift: TShiftState);
  end;

  IInplaceEditEh = interface
    ['{81F0C558-B001-4477-BAA6-2DC373FCDF88}']
    function GetFont: TFont;
    procedure SetInplaceEditHolder(AInplaceEditHolder: TWinControl);

    procedure SetBorderStyle(ABorderStyle: TBorderStyle);
    procedure SetFont(AFont: TFont);
    procedure SetColor(AColor: TColor);
    procedure SetOnKeyPress(AKeyPressEvent: TKeyPressEvent);
    procedure SetOnExit(AKeyPressEvent: TNotifyEvent);
  end;

{ TEditImageEh }

  TEditImageEh = class(TPersistent)
  private
    FEditControl: TWinControl;
    FImageIndex: Integer;
    FImages: TCustomImageList;
    FUseImageHeight: Boolean;
    FVisible: Boolean;
    FWidth: Integer;
    procedure SetImageIndex(const Value: Integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetUseImageHeight(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
  public
    constructor Create(EditControl: TWinControl);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property Images: TCustomImageList read FImages write SetImages;
    property UseImageHeight: Boolean read FUseImageHeight write SetUseImageHeight default True;
    property Visible: Boolean read FVisible write SetVisible default False;
    property Width: Integer read FWidth write SetWidth default 0;
  end;

{ TFieldDataLinkEh }

  TFieldDataLinkEh = class(TDataLink)
  private
    FFields: TFieldsArrEh;
    FFieldName: string;
    FControl: TComponent;
    //FEditing: Boolean;
    //FModified: Boolean;
    FOnDataChange: TNotifyEvent;
    FOnEditingChange: TNotifyEvent;
    FOnUpdateData: TNotifyEvent;
    FOnActiveChange: TNotifyEvent;
    FMultiFields: Boolean;
    FDataIndepended: Boolean;
    FEditing: Boolean;
    FModified: Boolean;

    function GetActive: Boolean;
    function GetCanModify: Boolean;
    function GetDataSetActive: Boolean;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetFieldsCount: Integer;
    function GetFieldsField(Index: Integer): TField;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetEditing(Value: Boolean);
    procedure SetField(Value: TObjectList);
    procedure SetFieldName(const Value: string);
    procedure SetMultiFields(const Value: Boolean);
    procedure UpdateRightToLeft;
  protected
    function FieldFound(Value: TField): Boolean;
    procedure ActiveChanged; override;
{$IFDEF CIL}
    procedure DataEvent(Event: TDataEvent; Info: TObject); virtual;
{$ELSE}
    procedure DataEvent(Event: TDataEvent; Info: Integer); override;
{$ENDIF}
    procedure EditingChanged; override;
{$IFDEF CIL}
    procedure FocusControl(const Field: TField); override;
{$ELSE}
    procedure FocusControl(Field: TFieldRef); override;
{$ENDIF}
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
    procedure UpdateDataIndepended;
    procedure UpdateField; virtual;
  public
    DataIndependentValue: Variant; { TODO : Rewrite as property Value }

    constructor Create;
    function Edit: Boolean;
    function IsDataIndepended: Boolean; virtual;
    procedure Modified;
    procedure SetModified(Value: Boolean);
    procedure SetText(Text: String);
    procedure SetValue(Value: Variant);
    procedure Reset;

    property Active: Boolean read GetActive;
    property CanModify: Boolean read GetCanModify;
    property Control: TComponent read FControl write FControl;
    property DataIndepended: Boolean read FDataIndepended;
    property DataSetActive: Boolean read GetDataSetActive;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Editing: Boolean read FEditing;
    property Field: TField read GetField;
    property FieldName: string read FFieldName write SetFieldName;
    property Fields[Index: Integer]: TField read GetFieldsField;
    property FieldsCount: Integer read GetFieldsCount;
    property MultiFields: Boolean read FMultiFields write SetMultiFields;
    property OnActiveChange: TNotifyEvent read FOnActiveChange write FOnActiveChange;
    property OnDataChange: TNotifyEvent read FOnDataChange write FOnDataChange;
    property OnEditingChange: TNotifyEvent read FOnEditingChange write FOnEditingChange;
    property OnUpdateData: TNotifyEvent read FOnUpdateData write FOnUpdateData;
  end;

{ TCustomDBEditEh }

  TGetImageIndexEventEh = procedure(Sender: TObject; var ImageIndex: Integer) of object;
  TOnCheckDrawRequiredStateEventEh = procedure(Sender: TObject; var DrawState: Boolean) of object;

  TDBEditEhValue = (evAlignmentEh, evEditMaskEh);
  TDBEditEhValues = set of TDBEditEhValue;

  TCustomDBEditEh = class(TCustomMaskEdit, IInplaceEditEh, IComboEditEh {$IFNDEF CIL}, IUnknown {$ENDIF})
  private
    FAlwaysShowBorder: Boolean;
    FAssignedValues: TDBEditEhValues;
    FCanvas: TControlCanvas;
    FCompleteKeyPress: String;
    FEditButton: TEditButtonEh;
    FEditButtons: TEditButtonsEh;
    FEditImage: TEditImageEh;
    FFlat: Boolean;
    FHighlightRequired: Boolean;
    FMRUList: TMRUListEh;
    FMRUListControl: TWinControl;
    FOnButtonClick: TButtonClickEventEh;
    FOnButtonDown: TButtonDownEventEh;
    FOnCheckDrawRequiredState: TOnCheckDrawRequiredStateEventEh;
    FOnGetImageIndex: TGetImageIndexEventEh;
    FOnUpdateData: TUpdateDataEventEh;
    FReadOnly: Boolean;
    FShowHint: Boolean;
    FTooltips: Boolean;
    FWantReturns: Boolean;
    FWantTabs: Boolean;
    FWordWrap: Boolean;
    function CheckHintTextRect(var TextWidth, TextHeight: Integer): Boolean;
    function GetAlignment: TAlignment;
{$IFNDEF EH_LIB_6}
    function GetAutoSize: Boolean;
{$ENDIF}
    function GetCanvas: TCanvas;
    function GetEditMask: String;
    function GetField: TField;
    function GetImages: TCustomImageList;
    function GetMRUListControl: TWinControl;
    function GetPasswordChar: Char;
    function GetReadOnly: Boolean;
    function GetShowHint: Boolean;
    function GetText: String;
    function GetTextMargins: TPoint;
    function GetValue: Variant;
    function GetVisible: Boolean;
    function ImageRect: TRect;
    function IsAlignmentStored: Boolean;
    function IsEditMaskStored: Boolean;
    function IsTextStored: Boolean;
    function IsValueStored: Boolean;
    procedure ActiveChange(Sender: TObject);
    procedure CheckCursor;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMEditImageChangedEh(var Message: TMessage); message CM_EDITIMAGECHANGEDEH;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
{$IFNDEF CIL}
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
{$ENDIF}
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMParentShowHintChanged(var Message: TMessage); message CM_PARENTSHOWHINTCHANGED;
    procedure CMRecreateWnd(var Message: TMessage); message CM_RECREATEWND;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure DataChange(Sender: TObject);
    procedure DrawBorder(DC: HDC; ActiveBorder: Boolean);
    procedure DrawEditImage(DC: HDC);
    procedure EditButtonChanged(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure InternalMove(const Loc: TRect; Redraw: Boolean);
    procedure InternalUpdateData(Sender: TObject);
    procedure ReadEditMask(Reader: TReader);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetAlwaysShowBorder(const Value: Boolean);
    procedure SetEditButton(const Value: TEditButtonEh);
    procedure SetEditButtons(const Value: TEditButtonsEh);
    procedure SetEditImage(const Value: TEditImageEh);
    procedure SetEditMask(const Value: String);
    procedure SetEditRect;
    procedure SetFlat(const Value: Boolean);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetMRUList(const Value: TMRUListEh);
    procedure SetOnGetImageIndex(const Value: TGetImageIndexEventEh);
    procedure SetPasswordChar(const Value: Char);
    procedure SetReadOnly(Value: Boolean);
    procedure SetShowHint(const Value: Boolean);
    procedure SetText(const Value: String); {$IFDEF CIL} reintroduce; {$ENDIF}
    procedure SetTooltips(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    procedure SetVisible(const Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
    procedure UpdateDrawBorder;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMCut(var Message: TWMCut); message WM_CUT;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMUndo(var Message: TWMUndo); message WM_UNDO;
    procedure WriteEditMask(Writer: TWriter);
  protected
    FAlignment: TAlignment;
    FBorderActive: Boolean;
    FButtonHeight: Integer;
    FButtonWidth: Integer;
    FDataLink: TFieldDataLinkEh;
    FDataPosting: Boolean;
    FDownButton: Integer;
    FDroppedDown: Boolean;
    FEditButtonControlList: TEditButtonControlList;
    FFocused: Boolean;
    FImageWidth: Integer;
    FInplaceEditHolder: TWinControl;
    FInplaceMode: Boolean;
    FIntfInplaceEditHolder: IInplaceEditHolderEh;
    FMouseAboveControl: Boolean;
    FNoClickCloseUp: Boolean;
    FPressed: Boolean;
    FPressedRect: TRect;
    FUserTextChanged: Boolean;
    function ButtonEnabled: Boolean; virtual;
    function ButtonRect: TRect;
    function CreateDataLink: TFieldDataLinkEh; virtual;
    function CreateEditButton: TEditButtonEh; virtual;
    function CreateEditButtonControl: TEditButtonControlEh; virtual;
    function CreateEditButtons: TEditButtonsEh; virtual;
    function CreateEditImage: TEditImageEh; virtual;
    function CreateMRUListControl: TWinControl; virtual;
    function DataIndepended: Boolean; virtual;
    function DefaultAlignment: TAlignment; virtual;
    function DefaultEditMask: String; virtual;
    function DefaultImageIndex: Integer; virtual;
    function EditCanModify: Boolean; override;
    function EditRect: TRect;
    function GetDataField: string; virtual;
    function GetDataSource: TDataSource; virtual;
    function GetDisplayTextForPaintCopy: String; virtual;
    function GetEditButtonByShortCut(ShortCut: TShortCut): TEditButtonEh;
    function GetFont: TFont;
    function GetVariantValue: Variant; virtual;
    function IsValidChar(InputChar: Char): Boolean; virtual;
    function PostDataEvent: Boolean;
    procedure ActiveChanged; virtual;
    procedure AdjustHeight; virtual;
    procedure ButtonDown(IsDownButton: Boolean); virtual;
    procedure CalcEditRect(var ARect: TRect); virtual;
    procedure Change; override;
    procedure CheckInplaceEditHolderKeyDown(var Key: Word; Shift: TShiftState);
    procedure CheckInplaceEditHolderKeyPress(var Key: Char);
    procedure CheckInplaceEditHolderKeyUp(var Key: Word; Shift: TShiftState);
    procedure CloseUp(Accept: Boolean); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DataChanged; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DropDown; virtual;
    procedure EditButtonClick(Sender: TObject); virtual;
    procedure EditButtonDown(Sender: TObject; TopButton: Boolean; var AutoRepeat: Boolean; var Handled: Boolean); virtual;
    procedure EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); virtual;
    procedure EditButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure EditingChanged; virtual;
    procedure FilterMRUItem(AText: String; var Accept: Boolean); virtual;
    procedure InternalSetText(AText: String); virtual;
    procedure InternalSetValue(AValue: Variant); virtual;
    procedure InternalUpdatePostData; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure MRUListCloseUp(Sender: TObject; Accept: Boolean);
    procedure MRUListControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MRUListControlResized(Sender: TObject); virtual;
    procedure MRUListDropDown(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PaintWindow(DC: HDC); override;
    procedure PaintRequiredState(ACanvas: TCanvas); virtual;
    procedure ResetMaxLength; virtual;
    procedure SetAutoSize(Value: Boolean); {$IFDEF EH_LIB_6} override; {$ELSE} virtual; {$ENDIF}
    procedure SetBorderStyle(ABorderStyle: TBorderStyle);
    procedure SetColor(AColor: TColor);
    procedure SetControlEditMask(Value: string);
    procedure SetControlReadOnly(Value: Boolean);
    procedure SetDataField(const Value: string); virtual;
    procedure SetDataSource(Value: TDataSource); virtual;
    procedure SetFocused(Value: Boolean); virtual;
    procedure SetFont(AFont: TFont);
    procedure SetInplaceEditHolder(AInplaceEditHolder: TWinControl);
    procedure SetOnExit(AKeyPressEvent: TNotifyEvent);
    procedure SetOnKeyPress(AKeyPressEvent: TKeyPressEvent);
    procedure SetVariantValue(const VariantValue: Variant); virtual;
    procedure UpdateControlReadOnly; virtual;
    procedure UpdateEditButtonControlList;
    procedure UpdateEditButtonControlsState;
    procedure UpdateHeight; virtual;
    procedure UpdateHintProcessing; virtual;
    procedure UpdateImageIndex; virtual;
    procedure UserChange; virtual;
    procedure WndProc(var Message: TMessage); override;
    property AssignedValues: TDBEditEhValues read FAssignedValues;
{$IFNDEF EH_LIB_6}
    property AutoSize: Boolean read GetAutoSize write SetAutoSize default True;
{$ENDIF}
    property Canvas: TCanvas read GetCanvas;
    property EditButton: TEditButtonEh read FEditButton write SetEditButton;
    property EditButtons: TEditButtonsEh read FEditButtons write SetEditButtons;
    property EditImage: TEditImageEh read FEditImage write SetEditImage;
    property HighlightRequired: Boolean read FHighlightRequired write FHighlightRequired default False;
    property Images: TCustomImageList read GetImages write SetImages;
    property MRUList: TMRUListEh read FMRUList write SetMRUList;
    property MRUListControl: TWinControl read GetMRUListControl;
    property PasswordChar: Char read GetPasswordChar write SetPasswordChar default #0;
    property WantReturns: Boolean read FWantReturns write FWantReturns default False;
    property WantTabs: Boolean read FWantTabs write FWantTabs default False;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property OnButtonClick: TButtonClickEventEh read FOnButtonClick write FOnButtonClick;
    property OnButtonDown: TButtonDownEventEh read FOnButtonDown write FOnButtonDown;
    property OnCheckDrawRequiredState: TOnCheckDrawRequiredStateEventEh read FOnCheckDrawRequiredState write FOnCheckDrawRequiredState;
    property OnGetImageIndex: TGetImageIndexEventEh read FOnGetImageIndex write SetOnGetImageIndex;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function GetCompleteKeyPress: String;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    procedure Clear; override;
    procedure DefaultHandler(var Message); override;
    procedure Deselect;
    procedure Hide;
    procedure Move(const Loc: TRect);
    procedure Reset; override;
    procedure SetFocus; override;
    procedure Undo;
    procedure UpdateData; virtual;
    procedure UpdateLoc(const Loc: TRect);
    property Alignment: TAlignment read GetAlignment write SetAlignment stored IsAlignmentStored;
    property AlwaysShowBorder: Boolean read FAlwaysShowBorder write SetAlwaysShowBorder default False;
    property DataField: String read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DisplayTextForPaintCopy: String read GetDisplayTextForPaintCopy;
    property EditMask: String read GetEditMask write SetEditMask stored False;
    property Field: TField read GetField;
    property Flat: Boolean read FFlat write SetFlat default False;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint: Boolean read GetShowHint write SetShowHint default False;
    property Text: String read GetText write SetText stored IsTextStored;
    property Tooltips: Boolean read FTooltips write SetTooltips default False;
    property Value: Variant read GetValue write SetValue stored IsValueStored;
    property Visible: Boolean read GetVisible write SetVisible;
    property OnUpdateData: TUpdateDataEventEh read FOnUpdateData write FOnUpdateData;
  end;

  TDBEditEh = class(TCustomDBEditEh)
  published
    property Alignment;
    property AlwaysShowBorder;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property EditButtons;
    property Enabled;
    property EditMask;
    property Font;
    property Flat;
    property HighlightRequired;
    property Images;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property MRUList;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Tooltips;
    property Visible;
    property WantTabs;
    property WantReturns;
    property WordWrap;
    property OnChange;
    property OnCheckDrawRequiredState;
    property OnClick;
{$IFDEF EH_LIB_5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnUpdateData;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TCustomDBDateTimeEditEh }

  TDateTimeKindEh = (dtkDateEh, dtkTimeEh, dtkDateTimeEh, dtkCustomEh);

  TElementMaskPosEh = record
    Pos, Length: Integer;
    Present: Boolean;
  end;

  TDateTimeElementsMaskPosEh = record
    Year: TElementMaskPosEh;
    Month: TElementMaskPosEh;
    Day: TElementMaskPosEh;
    Hour: TElementMaskPosEh;
    Min: TElementMaskPosEh;
    Sec: TElementMaskPosEh;
  end;

  TCustomDBDateTimeEditEh = class(TCustomDBEditEh)
  private
    FCalendarVisible: Boolean;
    FDropDownCalendar: TWinControl;
    FEditValidating: Boolean;
    FInternalTextSetting: Boolean;
    FKind: TDateTimeKindEh;
    FValue: Variant;
    FOnCloseUp: TCloseUpEventEh;
    FOnDropDown: TNotifyEvent;
    FEditFormat: String;
    FDateTimeFormat: String;
    function GetDropDownCalendar: TWinControl;
    function IsEditFormatStored: Boolean;
    function IsKindStored: Boolean;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure ReadEditFormat(Reader: TReader);
    procedure SetEditFormat(const Value: String);
    procedure SetKind(const Value: TDateTimeKindEh);
    procedure UpdateValueFromText;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WriteEditFormat(Writer: TWriter);
  protected
    FDateTimeMaskPos: TDateTimeElementsMaskPosEh;
    FFourDigitYear: Boolean;
    function CreateEditButton: TEditButtonEh; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetDisplayTextForPaintCopy: String; override;
    function GetVariantValue: Variant; override;
    procedure ButtonDown(IsDownButton: Boolean); override;
    procedure Change; override;
    procedure DataChanged; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); override;
    procedure FilterMRUItem(AText: String; var Accept: Boolean); override;
    procedure IncrementItemAtCurPos(IsIncrease: Boolean);
    procedure InternalSetControlText(AText: String);
    procedure InternalSetText(AText: String); override;
    procedure InternalSetValue(AValue: Variant); override;
    procedure InternalUpdatePostData; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure UpdateFourDigitYear; virtual;
    procedure WndProc(var Message: TMessage); override;
    property DropDownCalendar: TWinControl read GetDropDownCalendar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function DateTimeFormat: String;
    procedure CloseUp(Accept: Boolean); override;
    procedure DropDown; override;
    procedure UpdateMask; virtual;
    procedure ValidateEdit; override;
    property CalendarVisible: Boolean read FCalendarVisible;
    property EditFormat: String read FEditFormat write SetEditFormat stored False; //IsEditFormatStored;
    property Kind: TDateTimeKindEh read FKind write SetKind stored IsKindStored;
    property OnCloseUp: TCloseUpEventEh read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
  end;

{ TDBDateTimeEditEh }

  TDBDateTimeEditEh = class(TCustomDBDateTimeEditEh)
  published
    property Alignment;
    property AlwaysShowBorder;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EditButton;
    property EditButtons;
    property EditFormat;
    property Font;
    property Flat;
    property HighlightRequired;
    property Images;
    property ImeMode;
    property ImeName;
    property Kind;
    property MRUList;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Tooltips;
    property Value;
    property Visible;
    property OnButtonClick;
    property OnButtonDown;
    property OnChange;
    property OnCheckDrawRequiredState;
    property OnClick;
    property OnCloseUp;
{$IFDEF EH_LIB_5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnUpdateData;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TDropDownBoxEh }

  TDropDownBoxEh = class(TPersistent)
  private
    FAlign: TDropDownAlign;
    FAutoDrop: Boolean;
    FRows: Integer;
    FSizable: Boolean;
    FWidth: Integer;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Align: TDropDownAlign read FAlign write FAlign default daLeft;
    property AutoDrop: Boolean read FAutoDrop write FAutoDrop default False;
    property Rows: Integer read FRows write FRows default 7;
    property Sizable: Boolean read FSizable write FSizable default False;
    property Width: Integer read FWidth write FWidth default 0;
  end;

{ TCustomDBComboBoxEh }

  TCustomDBComboBoxEh = class(TCustomDBEditEh)
  private
    FDropDownBox: TDropDownBoxEh;
    FItemIndex: Integer;
    FItems: TStrings;
    FKeyItems: TStrings;
    FListVisible: Boolean;
    FOnNotInList: TNotInListEventEh;
    FPopupListbox: TWinControl;
    FOnCloseUp: TCloseUpEventEh;
    FOnClosingUp: TAcceptEventEh;
    FOnDropDown: TNotifyEvent;
    FOnGetItemImageIndex: TListGetImageIndexEventEh;
    FOnGetItemsList: TNotifyEvent;
    FPopupListboxClass: TWinControlClass;
    function GetImages: TCustomImageList;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure ItemsChanged(Sender: TObject);
    procedure KeyItemsChanged(Sender: TObject);
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetDropDownBox(const Value: TDropDownBoxEh);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetItemIndex(const Value: Integer);
    procedure SetItems(const Value: TStrings);
    procedure SetKeyItems(const Value: TStrings);
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
  protected
    FItemsCount: Integer;
    FKeyBased: Boolean;
    FVarValue: Variant;
    FDefaultItemIndex: Integer;
    function ConvertDataText(const Value: String): String;
    function CreateDropDownBox: TDropDownBoxEh; virtual;
    function CreateEditButton: TEditButtonEh; override;
    function DefaultAlignment: TAlignment; override;
    function DefaultImageIndex: Integer; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetDisplayTextForPaintCopy: String; override;
    function GetPopupListbox: TWinControl;
    function GetVariantValue: Variant; override;
    function IsValidChar(InputChar: Char): Boolean; override;
    function LocateStr(Str: String; PartialKey: Boolean): Boolean; virtual;
    function ProcessSearchStr(Str: String): Boolean; virtual;
    function TextListIndepended: Boolean;
    function TraceMouseMoveForPopupListbox(Sender: TObject; Shift: TShiftState; X, Y: Integer): Boolean;
    procedure ButtonDown(IsDownButton: Boolean); override;
    procedure Change; override;
    procedure Click; override;
    procedure DataChanged; override;
    procedure EditButtonClick(Sender: TObject); override;
    procedure EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer); override;
    procedure GetItemsList; virtual;
    procedure InternalSetItemIndex(const Value: Integer); virtual;
    procedure InternalSetText(AText: String); override;
    procedure InternalSetValue(AValue: Variant); override;
    procedure InternalUpdatePostData; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure ResetMaxLength; override;
    procedure PopupListboxGetImageIndex(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer);
    procedure SetVariantValue(const VariantValue: Variant); override;
    procedure UpdateControlReadOnly; override;
    procedure UpdateItemIndex;
    procedure UpdateImageIndex; override;
    procedure UpdateItems;
    procedure WndProc(var Message: TMessage); override;
    property PopupListbox: TWinControl read GetPopupListbox;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; {$IFDEF EH_LIB_5} override; {$ELSE} reintroduce; {$ENDIF}
    procedure CloseUp(Accept: Boolean); override;
    procedure DefaultHandler(var Message); override;
    procedure DropDown; override;
    procedure SelectNextValue(IsPrior: Boolean);
    procedure UpdateData; override;
    property DropDownBox: TDropDownBoxEh read FDropDownBox write SetDropDownBox;
    property HighlightRequired;
    property Images: TCustomImageList read GetImages write SetImages;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Items: TStrings read FItems write SetItems;
    property KeyItems: TStrings read FKeyItems write SetKeyItems;
    property PopupListboxClass: TWinControlClass read FPopupListboxClass write FPopupListboxClass;
    property ListVisible: Boolean read FListVisible;
    property OnCloseUp: TCloseUpEventEh read FOnCloseUp write FOnCloseUp;
    property OnClosingUp: TAcceptEventEh read FOnClosingUp write FOnClosingUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnGetItemsList: TNotifyEvent read FOnGetItemsList write FOnGetItemsList;
    property OnNotInList: TNotInListEventEh read FOnNotInList write FOnNotInList;
    property OnGetItemImageIndex: TListGetImageIndexEventEh read FOnGetItemImageIndex write FOnGetItemImageIndex;
  end;

{ TDBComboBoxEh }

  TDBComboBoxEh = class(TCustomDBComboBoxEh)
  published
    property Alignment;
    property AlwaysShowBorder;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownBox;
    property Enabled;
    property EditButton;
    property EditButtons;
    property EditMask;
    property Font;
    property Flat;
    property HighlightRequired;
    property Images;
    property ImeMode;
    property ImeName;
    property Items;
    property KeyItems;
    property MaxLength;
    property MRUList;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Tooltips;
    property Visible;
    property WordWrap;
    property OnButtonClick;
    property OnButtonDown;
    property OnChange;
    property OnCheckDrawRequiredState;
    property OnClick;
    property OnCloseUp;
{$IFDEF EH_LIB_5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetItemImageIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnNotInList;
    property OnUpdateData;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TCustomDBNumberEdit }

  TDBNumberValue = (evDisplayFormatEh, evCurrencyEh, evMaxValueEh, evMinValueEh);
  TDBNumberValues = set of TDBNumberValue;

  TCustomDBNumberEditEh = class(TCustomDBEditEh)
  private
    FAssignedValues: TDBNumberValues;
    FCalculatorVisible: Boolean;
    FCurrency: Boolean;
    FDecimalPlaces: Cardinal;
    FDisplayFormat: String;
    FDropDownCalculator: TWinControl;
    FEditFormat: String;
    FIncrement: Extended;
    FInternalTextSetting: Boolean;
    FMinValue, FMaxValue: Extended;
    FOnCloseUp: TCloseUpEventEh;
    FOnDropDown: TNotifyEvent;
    FValue: Variant;
//    FFormatting: Boolean;
    function CheckValue(NewValue: Extended): Extended;
    function DisplayFormatToEditFormat(const AFormat: string): string;
    function GetCurrency: Boolean;
    function GetDisplayFormat: string;
    function GetMaxValue: Extended;
    function GetMinValue: Extended;
    function IsCurrencyStored: Boolean;
    function IsDisplayFormatStored: Boolean;
    function IsIncrementStored: Boolean;
    function IsMaxValueStored: Boolean;
    function IsMinValueStored: Boolean;
    function TextToValText(const AValue: string): string;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMMouseWheel(var Message: TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure SetCurrency(const Value: Boolean);
    procedure SetDecimalPlaces(Value: Cardinal);
    procedure SetDisplayFormat(const Value: string);
    procedure SetMaxValue(AValue: Extended);
    procedure SetMinValue(AValue: Extended);
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
  protected
    function CreateEditButton: TEditButtonEh; override;
    function DefaultAlignment: TAlignment; override;
    function DefaultCurrency: Boolean;
    function DefaultDisplayFormat: String;
    function DefaultMaxValue: Extended;
    function DefaultMinValue: Extended;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function FormatDisplayText(Value: Extended): string;
    function GetDisplayText: string; virtual;
    function GetDropDownCalculator: TWinControl; virtual;
    function GetVariantValue: Variant; override;
    function IsValidChar(Key: Char): Boolean; override;
    procedure ButtonDown(IsDownButton: Boolean); override;
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DataChanged; override;
    procedure InternalSetControlText(AText: String);
    procedure InternalSetText(AText: String); override;
    procedure InternalSetValue(AValue: Variant); override;
    procedure InternalUpdatePostData; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure ReformatEditText(NewText: String); dynamic;
    procedure UpdateValueFromText;
    procedure WndProc(var Message: TMessage); override;
    property AssignedValues: TDBNumberValues read FAssignedValues;
    property currency: Boolean read GetCurrency write SetCurrency stored IsCurrencyStored;
    property DecimalPlaces: Cardinal read FDecimalPlaces write SetDecimalPlaces default 2;
    property DisplayFormat: String read GetDisplayFormat write SetDisplayFormat stored IsDisplayFormatStored;
    property DropDownCalculator: TWinControl read GetDropDownCalculator;
    property Increment: Extended read FIncrement write FIncrement stored IsIncrementStored;
    property MaxLength default 0;
    property MaxValue: Extended read GetMaxValue write SetMaxValue stored IsMaxValueStored;
    property MinValue: Extended read GetMinValue write SetMinValue stored IsMinValueStored;
//    property Formatting: Boolean read FFormatting;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CloseUp(Accept: Boolean); override;
    procedure DropDown; override;
    property CalculatorVisible: Boolean read FCalculatorVisible;
//    procedure Clear; override;
    property HighlightRequired;
    procedure IncrementValue(IsIncrease: Boolean);
    property DisplayText: string read GetDisplayText;
    property OnCloseUp: TCloseUpEventEh read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
  end;

{ TNumberEdit }

  TDBNumberEditEh = class(TCustomDBNumberEditEh)
  published
    property Alignment;
    property AlwaysShowBorder;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property currency;
    property DataField;
    property DataSource;
    property DecimalPlaces;
    property DisplayFormat;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EditButton;
    property EditButtons;
    property Font;
    property Flat;
    property HighlightRequired;
    property Images;
    property ImeMode;
    property ImeName;
    property Increment;
    //property MaxLength;
    property MaxValue;
    property MinValue;
    property MRUList;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Tooltips;
    property Value;
    property Visible;
    property OnButtonClick;
    property OnButtonDown;
    property OnChange;
    property OnCheckDrawRequiredState;
    property OnClick;
{$IFDEF EH_LIB_5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnUpdateData;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TCustomDBCheckBoxEh }

  TCustomDBCheckBoxEh = class(TButtonControl)
  private
    FAlignment: TLeftRight;
    FAllowGrayed: Boolean;
    FAlwaysShowBorder: Boolean;
    FClicksDisabled: Boolean;
    FDataLink: TFieldDataLinkEh;
    FFlat: Boolean;
    FModified: Boolean;
    FMouseAboveControl: Boolean;
    FOnUpdateData: TUpdateDataEventEh;
    FState: TCheckBoxState;
    FValueCheck: string;
    FValueUncheck: string;

    FCanvas: TCanvas;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetFieldState: TCheckBoxState;
    function GetModified: Boolean;
    function GetReadOnly: Boolean;
//    function IsCheckedStored: Boolean;
    function IsStateStored: Boolean;
    function ValueMatch(const ValueList, Value: string): Boolean;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
{$IFNDEF CIL}
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
{$ENDIF}
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure DataChange(Sender: TObject);
    procedure InternalUpdateData(Sender: TObject);
    procedure SetAlignment(const Value: TLeftRight);
    procedure SetAlwaysShowBorder(const Value: Boolean);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFlat(const Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure SetState(const Value: TCheckBoxState);
    procedure SetValueCheck(const Value: string);
    procedure SetValueUncheck(const Value: string);
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    FDataPosting: Boolean;
    FToggleKeyDown: Boolean;

    procedure Paint; virtual;
    procedure PaintWindow(DC: HDC); override;
    property Canvas: TCanvas read FCanvas;

    function DataIndepended: Boolean; virtual;
//    function GetActionLinkClass: TControlActionLinkClass; override;
    function GetChecked: Boolean; override;//virtual;
    function PostDataEvent: Boolean;
//    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure Click; override;
    procedure CreateWnd; override;
    procedure DrawCaptionRect(ARect: TRect; AFocused, AMouseAboveControl, ADown: Boolean); virtual;
    procedure DrawCheckBoxRect(ARect: TRect; AState: TCheckBoxState; AFocused, AMouseAboveControl, ADown: Boolean); virtual;
    procedure DrawState(AState: TCheckBoxState; AFocused, AMouseAboveControl, ADown: Boolean); virtual;
    procedure InternalSetState(Value: TCheckBoxState); virtual;
    procedure InternalUpdatePostData; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
//    procedure Paint; override;
    procedure SetChecked(Value: Boolean); override;//virtual;
    procedure Toggle; virtual;
    procedure WndProc(var Message: TMessage); override;
    property ClicksDisabled: Boolean read FClicksDisabled write FClicksDisabled;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function GetControlsAlignment: TAlignment; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    procedure UpdateData; virtual;
    property Alignment: TLeftRight read FAlignment write SetAlignment default taRightJustify;
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property AlwaysShowBorder: Boolean read FAlwaysShowBorder write SetAlwaysShowBorder default False;
    property Checked;//: Boolean read GetChecked write SetChecked stored IsCheckedStored default False;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Field: TField read GetField;
    property Flat: Boolean read FFlat write SetFlat default False;
    property Modified: Boolean read GetModified;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property State: TCheckBoxState read FState write SetState stored IsStateStored;
    property ValueChecked: String read FValueCheck write SetValueCheck;
    property ValueUnchecked: String read FValueUncheck write SetValueUncheck;
    property TabStop default True;
  end;

{ TDBCheckBoxEh }

  TDBCheckBoxEh = class(TCustomDBCheckBoxEh)
  published
    property Action;
    property Alignment;
    property AllowGrayed;
    property AlwaysShowBorder;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Flat;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property ValueChecked;
    property ValueUnchecked;
    property Visible;
    property OnClick;
{$IFDEF EH_LIB_5}
    property OnContextPopup;
{$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

var
  OldStyleFlatBorder: Boolean = False;

implementation

uses Commctrl, Clipbrd, DbConsts,
{$IFDEF EH_LIB_6} Types, MaskUtils, DateUtils,  {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
  Dialogs, CalculatorEh;

type
  TWinControlCracker = class(TWinControl) end;

{$IFNDEF EH_LIB_6}

function DupeString(const AText: string; ACount: Integer): string;
var
  P: PChar;
  C: Integer;
begin
  C := Length(AText);
  SetLength(Result, C * ACount);
  P := Pointer(Result);
  if P = nil then Exit;
  while ACount > 0 do
  begin
    Move(Pointer(AText)^, P^, C);
    Inc(P, C);
    Dec(ACount);
  end;
end;

{$ENDIF}

function VarToStr(const V: Variant): string;
begin
  Result := '';
  if VarIsArray(V) then Exit;
  try
    Result := {$IFDEF EH_LIB_6}Variants.{$ELSE}System.{$ENDIF}VarToStr(V);
  except
  end;
end;
//const
//  InitRepeatPause:Integer = 500;  { pause before first repeat timer (ms) }
//  RepeatPause:Integer     = 100;  { pause before next repeat timers (ms) }

{ TEditImageEh }

constructor TEditImageEh.Create(EditControl: TWinControl);
begin
  inherited Create;
  FEditControl := EditControl;
  FUseImageHeight := True;
  FImageIndex := -1;
end;

destructor TEditImageEh.Destroy;
begin
  inherited Destroy;
end;

procedure TEditImageEh.Assign(Source: TPersistent);
begin
  if Source is TEditImageEh then
  begin
    Images := TEditImageEh(Source).Images;
    ImageIndex := TEditImageEh(Source).ImageIndex;
    Visible := TEditImageEh(Source).Visible;
    Width := TEditImageEh(Source).Width;
  end else
    inherited Assign(Source);
end;

procedure TEditImageEh.SetImageIndex(const Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if FEditControl <> nil then FEditControl.Invalidate;
  end;
end;

procedure TEditImageEh.SetImages(const Value: TCustomImageList);
begin
  if FImages <> Value then
  begin
    FImages := Value;
    if FEditControl <> nil then
    begin
      FEditControl.Perform(CM_EDITIMAGECHANGEDEH, ObjectToIntPtr(Self), 0);
      if Value <> nil then Value.FreeNotification(FEditControl);
    end;
  end;
end;

procedure TEditImageEh.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if FEditControl <> nil then FEditControl.Perform(CM_EDITIMAGECHANGEDEH, ObjectToIntPtr(Self), 0);
  end;
end;

procedure TEditImageEh.SetWidth(const Value: Integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    if FEditControl <> nil then FEditControl.Perform(CM_EDITIMAGECHANGEDEH, ObjectToIntPtr(Self), 0);
  end;
end;

procedure TEditImageEh.SetUseImageHeight(const Value: Boolean);
begin
  if FUseImageHeight <> Value then
  begin
    FUseImageHeight := Value;
    if FEditControl <> nil then FEditControl.Perform(CM_EDITIMAGECHANGEDEH, ObjectToIntPtr(Self), 0);
  end;
end;

{ TFieldDataLinkEh }

constructor TFieldDataLinkEh.Create;
begin
  inherited Create;
  VisualControl := True;
  FDataIndepended := True;
  DataIndependentValue := Null;
end;

function TFieldDataLinkEh.Edit: Boolean;
begin
  if DataIndepended then
  begin
    if not Editing and not ReadOnly then
    begin
      FEditing := True;
      FModified := False;
      if Assigned(OnEditingChange) then OnEditingChange(Self);
    end;
  end else if CanModify then
    inherited Edit;
  Result := FEditing;
end;

function TFieldDataLinkEh.GetActive: Boolean;
begin
  if DataIndepended then Result := True
  else Result := inherited Active and (Field <> nil);
end;

function TFieldDataLinkEh.GetDataSetActive: Boolean;
begin
  Result := (DataSource <> nil) and (DataSource.DataSet <> nil) and DataSource.DataSet.Active;
end;

function TFieldDataLinkEh.GetCanModify: Boolean;
begin
//  Result := inherited CanModify or DataIndepended;
  Result := ((Field <> nil) and Field.CanModify) or DataIndepended;
end;

function TFieldDataLinkEh.GetDataSource: TDataSource;
begin
  Result := inherited DataSource;
end;

procedure TFieldDataLinkEh.Modified;
begin
  FModified := True;
end;

procedure TFieldDataLinkEh.RecordChanged(Field: TField);
begin
  if (Field = nil) or FieldFound(Field) then
  begin
    if Assigned(FOnDataChange) then FOnDataChange(Self);
    FModified := False;
  end;
end;

procedure TFieldDataLinkEh.SetDataSource(const Value: TDataSource);
begin
  if Value <> inherited DataSource then
  begin
    inherited DataSource := Value;
    UpdateDataIndepended;
  end;
end;

procedure TFieldDataLinkEh.SetFieldName(const Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    UpdateField;
    UpdateDataIndepended;
  end;
end;

procedure TFieldDataLinkEh.SetText(Text: String);
begin
  if DataIndepended then
  begin
    DataIndependentValue := Text;
    RecordChanged(nil);
  end else if (Field is TMemoField) then {if Field <> nil then}
    Field.AsString := Text
{$IFDEF EH_LIB_10}
  else if (Field is TWideMemoField) then 
   Field.AsString := Text
{$ENDIF}
  else
    Field.Text := Text;
end;

procedure TFieldDataLinkEh.SetValue(Value: Variant);
var i: Integer;
begin
  if DataIndepended then
  begin
    DataIndependentValue := Value;
    RecordChanged(nil);
  end else {if Field <> nil then}  if FieldsCount > 1 then
  begin
    if VarEquals(Value, Null)
      then for i := 0 to FieldsCount - 1 do Fields[i].AsVariant := Null
      else for i := 0 to FieldsCount - 1 do Fields[i].AsVariant := Value[i]
  end else if Field <> nil then
    Field.AsVariant := Value;
end;

procedure TFieldDataLinkEh.UpdateData;
begin
  if DataIndepended then
  begin
    if FModified then
      if Assigned(OnUpdateData) then OnUpdateData(Self);
    FEditing := False;
    FModified := False;
  end else if FModified then
  begin
    if (Field <> nil) and Assigned(FOnUpdateData) then FOnUpdateData(Self);
    FModified := False;
  end;
end;

procedure TFieldDataLinkEh.UpdateDataIndepended;
var
  OldDataIndepended: Boolean;
begin
  if FDataIndepended <> IsDataIndepended then
  begin
    OldDataIndepended := FDataIndepended;
    FDataIndepended := IsDataIndepended;
    DataIndependentValue := Null;
    //if {FDataIndepended and} Assigned(OnRecordChange) then OnActiveChange(Self);
    LayoutChanged;
    if not OldDataIndepended and FDataIndepended then
      RecordChanged(nil);
  end;
end;

function TFieldDataLinkEh.IsDataIndepended: Boolean;
begin
  Result := (DataSource = nil) and (FieldName = '');
end;

procedure TFieldDataLinkEh.ActiveChanged;
begin
  UpdateField;
  if Assigned(FOnActiveChange) then FOnActiveChange(Self);
end;

procedure TFieldDataLinkEh.EditingChanged;
begin
  SetEditing(inherited Editing and CanModify);
end;

function TFieldDataLinkEh.FieldFound(Value: TField): Boolean;
var i: Integer;
begin
  Result := False;
  for i := 0 to Length(FFields) - 1 do
    if FFields[i] = Value then
    begin
      Result := True;
      Exit;
    end;
end;

{$IFDEF CIL}
procedure TFieldDataLinkEh.FocusControl(const Field: TField);
begin
  if (Field <> nil) and FieldFound(Field) and (FControl is TWinControl) then
    if TWinControl(FControl).CanFocus then
    begin
      TWinControl(FControl).SetFocus;
    end;
end;
{$ELSE}
procedure TFieldDataLinkEh.FocusControl(Field: TFieldRef);
begin
  if (Field^ <> nil) and FieldFound(Field^) and (FControl is TWinControl) then
    if TWinControl(FControl).CanFocus then
    begin
      Field^ := nil;
      TWinControl(FControl).SetFocus;
    end;
end;
{$ENDIF}

function TFieldDataLinkEh.GetField: TField;
begin
  if Length(FFields) = 0
    then Result := nil
    else Result := FFields[0];
end;

function TFieldDataLinkEh.GetFieldsCount: Integer;
begin
  Result := Length(FFields);
end;

function TFieldDataLinkEh.GetFieldsField(Index: Integer): TField;
begin
  if Length(FFields) = 0
    then Result := nil
    else Result := FFields[Index];
end;

procedure TFieldDataLinkEh.LayoutChanged;
begin
  UpdateField;
end;

procedure TFieldDataLinkEh.Reset;
begin
  RecordChanged(nil);
end;

procedure TFieldDataLinkEh.SetMultiFields(const Value: Boolean);
begin
  if FMultiFields <> Value then
  begin
    FMultiFields := Value;
    UpdateField;
  end;
end;

procedure TFieldDataLinkEh.UpdateField;
var
  FieldList: TObjectList;
begin
  FieldList := TObjectList.Create(False);
  try
  if inherited Active and (FFieldName <> '') then
  begin
    if MultiFields then
      if Assigned(FControl)
        then GetFieldsProperty(FieldList, DataSource.DataSet, FControl, FFieldName)
        else DataSet.GetFieldList(FieldList, FFieldName)
    else
      if Assigned(FControl)
        then FieldList.Add(GetFieldProperty(DataSource.DataSet, FControl, FFieldName))
        else FieldList.Add(DataSource.DataSet.FieldByName(FFieldName));
  end;
  SetField(FieldList);
  finally
    FreeAndNil(FieldList);
  end;
end;

procedure TFieldDataLinkEh.UpdateRightToLeft;
var
  IsRightAligned: Boolean;
  AUseRightToLeftAlignment: Boolean;
begin
  if Assigned(FControl) and (FControl is TWinControl) then
    with FControl as TWinControl do
      if IsRightToLeft then
      begin
        IsRightAligned :=
          (GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_RIGHT) = WS_EX_RIGHT;
        AUseRightToLeftAlignment :=
          DBUseRightToLeftAlignment(TControl(FControl), Field);
        if (IsRightAligned and (not AUseRightToLeftAlignment)) or
          ((not IsRightAligned) and AUseRightToLeftAlignment) then
          Perform(CM_RECREATEWND, 0, 0);
      end;
end;

procedure TFieldDataLinkEh.SetEditing(Value: Boolean);
begin
  if FEditing <> Value then
  begin
    FEditing := Value;
    FModified := False;
    if Assigned(FOnEditingChange) then FOnEditingChange(Self);
  end;
end;

procedure TFieldDataLinkEh.SetField(Value: TObjectList);
  function CompareFieldsAndList(Value: TObjectList): Boolean;
  begin
    Result := True;
  end;
var i: Integer;
begin
  if CompareFieldsAndList(Value) then
  begin
    SetLength(FFields, Value.Count);
    for i := 0 to Value.Count - 1 do
      FFields[i] := TField(Value[i]);
    EditingChanged;
    RecordChanged(nil);
    UpdateRightToLeft;
  end;
end;

procedure TFieldDataLinkEh.SetModified(Value: Boolean);
begin
  FModified := Value;
end;

{$IFDEF CIL}
procedure TFieldDataLinkEh.DataEvent(Event: TDataEvent; Info: TObject);
{$ELSE}
procedure TFieldDataLinkEh.DataEvent(Event: TDataEvent; Info: Integer);
{$ENDIF}
begin
  inherited DataEvent(Event, Info);
{$IFDEF EH_LIB_7}
  if Event = deDisabledStateChange then
  begin
    if Boolean(Info)
      then UpdateField
      else SetLength(FFields, 0);
  end;
{$ENDIF}
end;

{ TCustomDBEditEh }

constructor TCustomDBEditEh.Create(AOwner: TComponent);
{$ifdef eval}
  {$INCLUDE eval}
{$else}
begin
{$endif}

  //ComponentState := ComponentState + [csDesigning];
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csCaptureMouse];
  FDataLink := CreateDataLink;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := InternalUpdateData;
  FDataLink.OnActiveChange := ActiveChange;

  FEditButton := CreateEditButton;
  FEditButton.OnChanged := EditButtonChanged;
  FEditButtons := CreateEditButtons;
  FEditButtons.OnChanged := EditButtonChanged;
  FEditImage := CreateEditImage;

  FMRUList := TMRUListEh.Create(Self);
  FMRUList.OnSetDropDown := MRUListDropDown;
  FMRUList.OnSetCloseUp := MRUListCloseUp;

  UpdateControlReadOnly;
  UpdateImageIndex;
end;

destructor TCustomDBEditEh.Destroy;
begin
  FreeAndNil(FEditImage);
//  FEditImage := nil;
  FreeAndNil(FEditButton);
  FreeAndNil(FEditButtons);
  FreeAndNil(FDataLink);
//  FDataLink := nil;
  FreeAndNil(FCanvas);
  FreeAndNil(FMRUList);
  inherited Destroy;
end;

procedure TCustomDBEditEh.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) then
    if Assigned(DataSource) and Assigned(DataSource.DataSet) then
    begin
      F := DataSource.DataSet.FindField(DataField);
      if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength)
        then MaxLength := 0;
    end //else
//      MaxLength := 0;
end;

procedure TCustomDBEditEh.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  if NewStyleControls then
  begin
    if Ctl3D then I := 8 else I := 6;
    if Flat then Dec(I, 2);
    I := GetSystemMetrics(SM_CYBORDER) * I;
  end else
  begin
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight then I := Metrics.tmHeight;
    I := I div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;
  if (EditImage.Images <> nil) and EditImage.UseImageHeight and
     (EditImage.Images.Height > Metrics.tmHeight)
    then Height := EditImage.Images.Height + I
    else Height := Metrics.tmHeight + I;
end;

function TCustomDBEditEh.ButtonRect: TRect;
begin
  if NewStyleControls and not Ctl3D and (BorderStyle = bsSingle)
    then Result := Rect(ClientWidth - FButtonWidth - 1, 1, ClientWidth - 1, ClientHeight - 1)
    else Result := Rect(ClientWidth - FButtonWidth, 0, ClientWidth, ClientHeight);
  if inherited UseRightToLeftAlignment then
    OffsetRect(Result, FButtonWidth - ClientWidth, 0);
end;

function TCustomDBEditEh.ButtonEnabled: Boolean;
begin
  Result := Enabled and Assigned(FDataLink) and FDataLink.Active;
end;

procedure TCustomDBEditEh.DefaultHandler(var Message);
var
  Msg: TMessage;
begin
  VarToMessage(Message, Msg);
  case Msg.Msg of
    WM_LBUTTONDBLCLK, WM_LBUTTONDOWN, WM_LBUTTONUP,
      WM_MBUTTONDBLCLK, WM_MBUTTONDOWN, WM_MBUTTONUP,
      WM_RBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONUP:
{$IFDEF CIL}
      with TWMMouse.Create(Msg) do
{$ELSE}
      with TWMMouse(Message) do
{$ENDIF}
        if (PtInRect(ButtonRect, Point(XPos, YPos)) or PtInRect(ImageRect, Point(XPos, YPos))) and
          not MouseCapture then
          Exit;
    WM_CHAR:
{$IFDEF CIL}
      with TWMKey.Create(Msg) do
{$ELSE}
      with TWMKey(Message) do
{$ENDIF}
      begin
        if (not WantReturns and (CharCode = VK_RETURN)) or
          (not WantTabs and (CharCode = VK_TAB)) or
          (Char(CharCode) = #10)
          then
//            Exit;
            CharCode := 0; // Sometimes beek signal hear
            KeyData := 0;
      end;
  end;
  inherited DefaultHandler(Message);

  if FUserTextChanged then
  begin
    FUserTextChanged := False;
    UserChange;
  end;
end;

procedure TCustomDBEditEh.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
  UpdateDrawBorder;
end;

procedure TCustomDBEditEh.Notification(AComponent: TComponent; Operation: TOperation);
var i: Integer;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    if (FDataLink <> nil) and (AComponent = DataSource)
    then
      DataSource := nil
    else if (EditImage <> nil) and (EditImage.Images <> nil) and (AComponent = EditImage.Images)
    then
      EditImage.Images := nil
    else if (AComponent is TPopupMenu) then
    begin
      if AComponent = EditButton.DropdownMenu then
        EditButton.DropdownMenu := nil;
      for i := 0 to EditButtons.Count - 1 do
        if EditButtons[i].DropdownMenu = AComponent then
          EditButtons[i].DropdownMenu := nil;
    end;
end;

function TCustomDBEditEh.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TCustomDBEditEh.KeyDown(var Key: Word; Shift: TShiftState);
var AutoRepeat: Boolean;
  eb: TEditButtonEh;
begin
  CheckInplaceEditHolderKeyDown(Key, Shift);
  if Key = 0 then Exit;
  inherited KeyDown(Key, Shift);
  if Key = 0 then Exit;
  eb := GetEditButtonByShortCut(ShortCut(Key, Shift));
  if (eb <> nil) then
    if (eb = FEditButton) and ButtonEnabled then
    begin
      FEditButtonControlList[0].EditButtonControl.EditButtonDown(False, AutoRepeat);
      FEditButtonControlList[0].EditButtonControl.Click; //DropDown;
      Key := 0;
    end else
    begin
      FEditButtonControlList[eb.Index + 1].EditButtonControl.EditButtonDown(False, AutoRepeat);
      FEditButtonControlList[eb.Index + 1].EditButtonControl.Click; //DropDown;
      Key := 0;
    end;
  if (Key = Word('A')) and (Shift = [ssCtrl]) then
    SelectAll;
  if ((Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift))) and not ReadOnly
    then FDataLink.Edit;
  if (WantReturns and (Key = VK_RETURN)) and not ReadOnly then
    FDataLink.Edit;
  if (WantTabs and (Key = VK_TAB)) and not ReadOnly then
    FDataLink.Edit;
end;

procedure TCustomDBEditEh.KeyUp(var Key: Word; Shift: TShiftState);
begin
  CheckInplaceEditHolderKeyUp(Key, Shift);
  if Key = 0 then Exit;
  inherited KeyUp(Key, Shift);
end;

procedure TCustomDBEditEh.KeyPress(var Key: Char);
begin
  CheckInplaceEditHolderKeyPress(Key);
  if Key = #0 then Exit;
  inherited KeyPress(Key);
  if not DataIndepended then
    if (Key >= #32) and (FDataLink.Field <> nil) and not IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
  case Key of
    ^H, ^V, ^X, #32..High(Char):
      if not ReadOnly then FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
  if (Integer(Key) = VK_BACK) and MRUList.Active and Showing and not FDroppedDown and (Text = '') then
    MRUList.DropDown;
end;

procedure TCustomDBEditEh.WMChar(var Message: TWMChar);
var
  CharMsg: TMsg;
  DBC: Boolean;
begin
  FCompleteKeyPress := Char(Message.CharCode);
  try
    DBC := False;
    if (CharInSetEh(Char(Message.CharCode), LeadBytes)) then
      if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_NOREMOVE) then
        if CharMsg.Message <> WM_Quit then
        begin
          FCompleteKeyPress := FCompleteKeyPress + Char(CharMsg.wParam);
          DBC := True;
        end;

    inherited;

    if DBC and (Char(Message.CharCode) = #0) then
      PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
  finally
    FCompleteKeyPress := '';
  end;
end;

function TCustomDBEditEh.GetCompleteKeyPress: String;
begin
  Result := FCompleteKeyPress;
end;

function TCustomDBEditEh.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

function TCustomDBEditEh.EditRect: TRect;
begin
  if NewStyleControls and not Ctl3D and (BorderStyle = bsSingle) then
    Result := Rect(1 + FImageWidth, 1, ClientWidth - FButtonWidth - 2, ClientHeight - 1)
  else
    Result := Rect(FImageWidth, 0, ClientWidth - FButtonWidth - 1, ClientHeight);
  if inherited UseRightToLeftAlignment then
    OffsetRect(Result, FButtonWidth - FImageWidth, 0);
end;

procedure TCustomDBEditEh.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TCustomDBEditEh.SetFlat(const Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TCustomDBEditEh.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

function TCustomDBEditEh.CreateEditButton: TEditButtonEh;
begin
  Result := TEditButtonEh.Create(Self);
end;

function TCustomDBEditEh.CreateEditButtons: TEditButtonsEh;
begin
  Result := TEditButtonsEh.Create(Self, TVisibleEditButtonEh);
end;

function TCustomDBEditEh.CreateEditButtonControl: TEditButtonControlEh;
begin
  Result := TEditButtonControlEh.Create(Self);
  with Result do
  begin
    ControlStyle := ControlStyle + [csReplicatable];
    Width := 10;
    Height := 17;
    Visible := True;
    Transparent := False;
    Parent := Self;
  end;
end;

function TCustomDBEditEh.CreateEditImage: TEditImageEh;
begin
  Result := TEditImageEh.Create(Self);
end;

function TCustomDBEditEh.CreateDataLink: TFieldDataLinkEh;
begin
  Result := TFieldDataLinkEh.Create;
end;

procedure TCustomDBEditEh.Change;
begin
  FDataLink.Modified;
  Modified := True;
  inherited Change;
  UpdateImageIndex();
end;

procedure TCustomDBEditEh.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, Boolean, TAlignment] of DWORD =
  (((ES_LEFT, ES_LEFT, ES_LEFT), (ES_RIGHT, ES_RIGHT, ES_RIGHT)),
    ((ES_LEFT, ES_RIGHT, ES_CENTER), (ES_RIGHT, ES_LEFT, ES_CENTER)));
  WordWraps: array[Boolean] of DWORD = (0, ES_AUTOHSCROLL);
  PasswordChars: array[Boolean] of DWORD = (ES_MULTILINE, 0);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not WordWraps[FWordWrap] or
    PasswordChars[PasswordChar <> #0] or
    Alignments[FWordWrap, UseRightToLeftAlignment, Alignment];
end;

procedure TCustomDBEditEh.CreateWnd;
begin
  inherited CreateWnd;
  UpdateHeight;
  UpdateDrawBorder;

  UpdateEditButtonControlList;
  UpdateEditButtonControlsState;

  if not EditImage.Visible or (EditImage.Images = nil) then
    FImageWidth := 0
  else if (EditImage.Width > 0) and (EditImage.Images <> nil) then
    FImageWidth := EditImage.Width + 4 //  two pixel indent from left and right
  else if EditImage.Images <> nil then
    FImageWidth := EditImage.Images.Width + 4;
  UpdateImageIndex;  
  SetEditRect;
end;

function TCustomDBEditEh.DataIndepended: Boolean;
begin
  Result := FDataLink.DataIndepended;
end;

function TCustomDBEditEh.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TCustomDBEditEh.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState))
    then FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  DataChange(nil);
  Invalidate;
end;

procedure TCustomDBEditEh.CalcEditRect(var ARect: TRect);
begin
  if inherited UseRightToLeftAlignment
    then SetRect(ARect, FButtonWidth, 0, ClientWidth, ClientHeight)
    else SetRect(ARect, 0, 0, ClientWidth - FButtonWidth, ClientHeight);
  if EditImage.Visible and (EditImage.Images <> nil) then
    if inherited UseRightToLeftAlignment
      then Dec(ARect.Right, FImageWidth)
      else Inc(ARect.Left, FImageWidth);
end;

procedure TCustomDBEditEh.SetEditRect;
var
  Loc: TRect;
//  AClientHeight:Integer;
begin
  SetRect(Loc, 0, 0, ClientWidth, ClientHeight);
  CalcEditRect(Loc);
  SendStructMessage(Handle, EM_SETRECTNP, 0, Loc);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
//  SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, MakeLong(Loc.Left, ClientWidth-Loc.Right));
//  if Loc.Left > 0 then
//    ExcludeClipRect(Handle, 0, 0, Loc.Left, ClientHeight);
end;

function TCustomDBEditEh.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TCustomDBEditEh.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
  UpdateEditButtonControlsState;
  Invalidate;
end;

function TCustomDBEditEh.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

procedure TCustomDBEditEh.SetEditButton(const Value: TEditButtonEh);
begin
  FEditButton.Assign(Value);
end;

procedure TCustomDBEditEh.SetEditImage(const Value: TEditImageEh);
begin
  FEditImage.Assign(Value);
end;

procedure TCustomDBEditEh.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    EditingChanged;
  end;
end;

procedure TCustomDBEditEh.UpdateControlReadOnly;
var
  IsReadOnly: Boolean;
begin
  if ReadOnly then
    IsReadOnly := True
  else
  begin
    IsReadOnly := not FDataLink.Editing{CanModify};
    if IsReadOnly and Assigned(OnUpdateData) and
      (FDataLink.DataSet <> nil) and (FDataLink.DataSet.State = dsEdit)
    then
      IsReadOnly := False;
  end;
//  IsReadOnly := not FDataLink.CanModify or ReadOnly;
  if not IsReadOnly and FInplaceMode then
    IsReadOnly := not FIntfInplaceEditHolder.InplaceEditCanModify(Self);
  SetControlReadOnly(IsReadOnly);
end;

function TCustomDBEditEh.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TCustomDBEditEh.ActiveChange(Sender: TObject);
begin
  ActiveChanged;
end;

procedure TCustomDBEditEh.DataChange(Sender: TObject);
begin
  DataChanged;
  UpdateEditButtonControlsState;
end;

procedure TCustomDBEditEh.DrawBorder(DC: HDC; ActiveBorder: Boolean);
var
  R: TRect;
  BtnFaceBrush: HBRUSH;
  NeedReleaseDC: Boolean;
begin
  if not (NewStyleControls and Ctl3D and (BorderStyle = bsSingle))
    or not HandleAllocated then Exit;

  NeedReleaseDC := False;
  if DC = 0 then
  begin
    DC := GetWindowDC(Handle);
    NeedReleaseDC := True;
  end;
  BtnFaceBrush := GetSysColorBrush(COLOR_BTNFACE);

  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);

  if ActiveBorder
    then DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT)
    else FrameRect(DC, R, BtnFaceBrush);

  OffsetRect(R, -R.Left, -R.Top);
  InflateRect(R, -1, -1);
  FrameRect(DC, R, BtnFaceBrush);

  if NeedReleaseDC then
    ReleaseDC(Handle, DC);
end;

procedure TCustomDBEditEh.DrawEditImage(DC: HDC);
var ImRect: TRect;
begin
  if Assigned(EditImage) then
    with EditImage do
    begin
      if not Visible or (Images = nil) or (ImageIndex < 0) then Exit;
      ImRect := ImageRect;
      InflateRect(ImRect, -2, -1);
      DrawImage(DC, ImRect, Images, ImageIndex, False);
    end;
end;

procedure TCustomDBEditEh.EditingChange(Sender: TObject);
begin
  EditingChanged;
end;

function TCustomDBEditEh.PostDataEvent: Boolean;
begin
  Result := False;
  FDataPosting := True;
  try
    if Assigned(FOnUpdateData) then FOnUpdateData(Self, Result);
  finally
    FDataPosting := False;
  end;
end;

procedure TCustomDBEditEh.ReadEditMask(Reader: TReader);
begin
  EditMask := Reader.ReadString;
end;

procedure TCustomDBEditEh.WriteEditMask(Writer: TWriter);
begin
  Writer.WriteString(EditMask);
end;

procedure TCustomDBEditEh.InternalUpdateData(Sender: TObject);
begin
  UpdateData;
end;

procedure TCustomDBEditEh.UpdateDrawBorder;
var NewBorderActive: Boolean;
begin
  if (csLoading in ComponentState) then Exit;
  NewBorderActive := (csDesigning in ComponentState) or (Focused {GetFocus = Handle})
    or FMouseAboveControl or AlwaysShowBorder;
  if NewBorderActive <> FBorderActive then
  begin
    FBorderActive := NewBorderActive;
    if NewStyleControls and Ctl3D and (BorderStyle = bsSingle) and Flat and
      OldStyleFlatBorder
    then
      DrawBorder(0, FBorderActive);
    UpdateEditButtonControlsState;
  end;
end;

procedure TCustomDBEditEh.WMUndo(var Message: TWMUndo);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TCustomDBEditEh.WMPaste(var Message: TWMPaste);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TCustomDBEditEh.WMCut(var Message: TWMCut);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TCustomDBEditEh.WMGetDlgCode(var Message: TWMGetDlgCode);
var HolderMessage: Longint;
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_HASSETSEL;
  if FWantTabs then
    Message.Result := Message.Result or DLGC_WANTTAB;
  if FWantReturns then
    Message.Result := Message.Result or DLGC_WANTALLKEYS;
  if FInplaceMode then
  begin
    HolderMessage := FInplaceEditHolder.Perform(WM_GETDLGCODE,0,0);
    if HolderMessage and DLGC_WANTTAB > 0 then
      Message.Result := Message.Result or DLGC_WANTTAB;
  end
end;

procedure TCustomDBEditEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) and MRUList.DroppedDown and
     (TPopupListboxEh(MRUListControl).ItemIndex >= 0) then
  begin
    Message.Result := 1;
    Exit;
  end;
  inherited;
  if (Message.CharCode = VK_ESCAPE) and Modified then
    Message.Result := 1;
  if (Message.CharCode = VK_RETURN) and FInplaceMode then
    Message.Result := 1;
end;

procedure TCustomDBEditEh.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  ClearButtonsBitmapCache;
end;

procedure TCustomDBEditEh.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  if SysLocale.FarEast and FDataLink.CanModify then
    SetControlReadOnly(FReadOnly);
end;

procedure TCustomDBEditEh.CMExit(var Message: TCMExit);
begin
  if IsMasked and not (csDesigning in ComponentState) then
  begin
    ValidateEdit;
    CheckCursor;
  end;
  DoExit;
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
//  DoExit;
end;

procedure TCustomDBEditEh.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if (csFixedHeight in ControlStyle) and not ((csDesigning in
    ComponentState) and (csLoading in ComponentState)) then AdjustHeight;
  SetEditRect;
end;

procedure TCustomDBEditEh.CMColorChanged(var Message: TMessage);
begin
  inherited;
  UpdateEditButtonControlsState;
end;

procedure TCustomDBEditEh.CMMouseEnter(var Message: TMessage);
begin
  //if Message.LParam = 0 then
  //begin
  FMouseAboveControl := True;
  UpdateDrawBorder;
  //end;
end;

procedure TCustomDBEditEh.CMMouseLeave(var Message: TMessage);
begin
//  if Message.LParam = 0 then
//  begin
  FMouseAboveControl := False;
  UpdateDrawBorder;
//  end;
end;

function TCustomDBEditEh.CheckHintTextRect(var TextWidth, TextHeight: Integer): Boolean;
var
  NewRect, r: TRect;
  uFormat: Integer;
//  DC: HDC;
begin
  CalcEditRect(r);
  Result := False;
  uFormat := DT_CALCRECT or DT_LEFT or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly;
  if WordWrap then uFormat := uFormat or DT_WORDBREAK;

  NewRect := Rect(0, 0, r.Right - r.Left, 0);
  if NewRect.Right <= 0 then NewRect.Right := 1;
//  DC := GetDC(Handle);
  Canvas.Font := Font;
  DrawTextEh(Canvas.Handle, Text, Length(Text), NewRect, uFormat);
//  ReleaseDC(Handle, DC);
  TextWidth := NewRect.Right - NewRect.Left;
  TextHeight := NewRect.Bottom - NewRect.Top;
  if (NewRect.Right - NewRect.Left > r.Right - r.Left - 2) or
    (NewRect.Bottom - NewRect.Top > r.Bottom - r.Top) then
    Result := True;
end;

procedure TCustomDBEditEh.CMParentShowHintChanged(var Message: TMessage);
begin
  inherited;
  if ParentShowHint then
    FShowHint := Parent.ShowHint;
  UpdateHintProcessing;
end;

{ TToolTipsWindow }

{$IFDEF CIL}
type
  TToolTipsWindow = class(THintWindow)
  public
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: TObject): TRect; override;
  end;

function TToolTipsWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: TObject): TRect;
begin
  Canvas.Font.Assign(TFont(AData));
  Result := inherited CalcHintRect(MaxWidth, AHint, AData);
end;

{$ELSE}

type
  TToolTipsWindow = class(THintWindow)
  public
    function CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect; override;
  end;

function TToolTipsWindow.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  Canvas.Font.Assign(TFont(AData));
  Result := inherited CalcHintRect(MaxWidth, AHint, AData);
end;

{$ENDIF}

procedure TCustomDBEditEh.CMHintShow(var Message: TCMHintShow);
var
  TextWidth, TextHeight: Integer;
{$IFDEF CIL}
  AHintInfo: THintInfo;
{$ENDIF}
begin
  if Tooltips then
  begin
{$IFDEF CIL}
    if Message.OriginalMessage.LParam = 0 then Exit;
    AHintInfo := Message.HintInfo;
{$ENDIF}
    if CheckHintTextRect(TextWidth, TextHeight) then
    begin
{$IFDEF CIL}
      AHintInfo.HintStr := Text;
      AHintInfo.HintPos := ClientToScreen(Point(0, Height));
      AHintInfo.HintWindowClass := TToolTipsWindow;
      AHintInfo.HintData := Font;
      Message.HintInfo := AHintInfo;
{$ELSE}
      Message.HintInfo^.HintStr := Text;
      Message.HintInfo^.HintPos := ClientToScreen(Point(0, Height));
      Message.HintInfo^.HintWindowClass := TToolTipsWindow;
      Message.HintInfo^.HintData := Font;
{$ENDIF}
    end else if not ShowHint then
      Message.Result := 1
  end else if not ShowHint then
    Message.Result := 1;
end;

procedure TCustomDBEditEh.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
end;

procedure TCustomDBEditEh.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TCustomDBEditEh.WMNCPaint(var Message: TWMNCPaint);
begin
  if NewStyleControls and Ctl3D and (BorderStyle = bsSingle) and Flat and
    OldStyleFlatBorder
  then
  begin
    DrawBorder(0, FBorderActive);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TCustomDBEditEh.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if PtInRect(ButtonRect, Point(P.X, P.Y)) or PtInRect(ImageRect, Point(P.X, P.Y))
    then Windows.SetCursor(LoadCursor(0, idc_Arrow))
    else inherited;
end;

procedure TCustomDBEditEh.CheckCursor;
var
  SelStart, SelStop: Integer;
begin
  if not HandleAllocated then Exit;
  if (IsMasked) then
  begin
    GetSel(SelStart, SelStop);
    if SelStart = SelStop then
      if SelStart - 2 < 0
        then SetCursor(0)
        else SetCursor(SelStart - 2);
  end;
end;

{ // Fixing up bug with mouseclick cursor pos in masked mode
procedure TCustomDBEditEh.EMGetSel(var Message: TMessage);
begin
  inherited;
  if FFixingCurPos and (PInteger(Message.WParam)^ = PInteger(Message.LParam)^) then
  begin
    PInteger(Message.WParam)^ := PInteger(Message.WParam)^ - 3;
    if PInteger(Message.WParam)^ < 0 then PInteger(Message.WParam)^ := 0;
    PInteger(Message.LParam)^ := PInteger(Message.LParam)^ - 3;
    if PInteger(Message.LParam)^ < 0 then PInteger(Message.LParam)^ := 0;
  end;
end;
}

procedure TCustomDBEditEh.PaintWindow(DC: HDC);
const
  AlignStyle: array[Boolean, TAlignment] of DWORD =
  ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
//  DC: HDC;
  PS: TPaintStruct;
  S: string;
  AAlignment: TAlignment;
  ExStyle: DWORD;
  PaintControlName: Boolean;
//  TextPainted:Boolean;
begin
  DrawEditImage(DC);
  AAlignment := Alignment;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  PaintControlName := (csDesigning in ComponentState) and not (FDataLink.Active);
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
//  TextPainted := False;
  if ((AAlignment = taLeftJustify) or FFocused or FWordWrap) and
    not (csPaintCopy in ControlState) and not PaintControlName then
  begin
    if SysLocale.MiddleEast and HandleAllocated and (IsRightToLeft) then
    begin { This keeps the right aligned text, right aligned }
      ExStyle := DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) and (not WS_EX_RIGHT) and
        (not WS_EX_RTLREADING) and (not WS_EX_LEFTSCROLLBAR);
      if UseRightToLeftReading then ExStyle := ExStyle or WS_EX_RTLREADING;
      if UseRightToLeftScrollbar then ExStyle := ExStyle or WS_EX_LEFTSCROLLBAR;
      ExStyle := ExStyle or
        AlignStyle[UseRightToLeftAlignment, AAlignment];
      if DWORD(GetWindowLong(Handle, GWL_EXSTYLE)) <> ExStyle then
        SetWindowLong(Handle, GWL_EXSTYLE, ExStyle);
    end;

    if DC = 0 then DC := BeginPaint(Handle, PS);
    FCanvas.Handle := DC;
    try
      PaintRequiredState(FCanvas);
    finally
      FCanvas.Handle := 0;
      if DC = 0 then EndPaint(Handle, PS);
    end;
    
    inherited PaintWindow(DC);

    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
//  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
//    with EditImage do
//      if Visible and (ImageList <> nil) and (ImageIndex >= 0) then
//        DrawEditImage(FCanvas);
//    if TextPainted then Exit;

    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      R := EditRect;
      Brush.Color := Color;
      if not Enabled then
        Font.Color := clGrayText;
      S := GetDisplayTextForPaintCopy;
      {if PaintControlName then
        S := Name
      else if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
      begin
        S := FDataLink.Field.DisplayText;
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end else
        S := EditText;}

{ DONE : FillChar }
      if PasswordChar <> #0 then
{$IFDEF CIL}
        S := StringOfChar(PasswordChar, Length(S));
{$ELSE}
        FillChar(S[1], Length(S), PasswordChar);
{$ENDIF}
      Margins := GetTextMargins;
      case AAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := EditRect.Right {ClientWidth} - TextWidth(S) - Margins.X;
      else
        Left := (EditRect.Right {ClientWidth} - TextWidth(S)) div 2;
      end;
      if SysLocale.MiddleEast then UpdateTextFlags;
      TextRect(R, Left, Margins.Y, S);
    end;
    PaintRequiredState(FCanvas);
  finally
    FCanvas.Handle := 0;
    if DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure TCustomDBEditEh.PaintRequiredState(ACanvas: TCanvas);
var
  r: TRect;
  DrawState: Boolean;
begin
  if DataIndepended then
    DrawState := HighlightRequired and FDataLink.Active and
     ( VarIsNull(Value) or (Text = '') )
  else
    DrawState := HighlightRequired and FDataLink.Active and
      (FDataLink.DataSet.State in [dsInsert, dsEdit] ) and (Field <> nil) and
      Field.Required and Field.IsNull;
  if Assigned(FOnCheckDrawRequiredState) then
    FOnCheckDrawRequiredState(Self, DrawState);
  if DrawState then
  begin
    ACanvas.Pen.Color := clRed;
    ACanvas.Pen.Style := psDot;
    CalcEditRect(r);
    ACanvas.MoveTo(r.Left+2, ClientHeight-1);
    ACanvas.LineTo(r.Right-3, ClientHeight-1);
  end;
end;

{$IFNDEF CIL}
procedure TCustomDBEditEh.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := ObjectToIntPtr(FDataLink);
end;
{$ENDIF}

function TCustomDBEditEh.GetVariantValue: Variant;
begin
  if DataIndepended then
    Result := Variant({Edit} Text)
  else
    Result := Variant(Text);
end;

function TCustomDBEditEh.IsValidChar(InputChar: Char): Boolean;
begin
  if (FDataLink.Field <> nil) then
    Result := FDataLink.Field.IsValidChar(InputChar)
  else
    Result := True;
end;

procedure TCustomDBEditEh.CMDialogKey(var Message: TCMDialogKey);
begin
  inherited;
end;

procedure TCustomDBEditEh.CMEditImageChangedEh(var Message: TMessage);
begin
  RecreateWnd;
end;

procedure TCustomDBEditEh.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  UpdateEditButtonControlsState;
end;

function TCustomDBEditEh.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
  begin
    if BorderStyle = bsNone then I := 0 else
      if Ctl3D then I := 1 else I := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
    Result.Y := I;
  end else
  begin
    if BorderStyle = bsNone then I := 0 else
    begin
      DC := GetDC(0);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(0, DC);
      I := SysMetrics.tmHeight;
      if I > Metrics.tmHeight then I := Metrics.tmHeight;
      I := I div 4;
    end;
    Result.X := I;
    Result.Y := I;
  end;
end;

function TCustomDBEditEh.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TCustomDBEditEh.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TCustomDBEditEh.UpdateHeight;
begin
  if AutoSize and (BorderStyle = bsSingle) then
  begin
    ControlStyle := ControlStyle + [csFixedHeight];
    AdjustHeight;
  end else
    ControlStyle := ControlStyle - [csFixedHeight];
end;

function TCustomDBEditEh.GetText: String;
begin
  Result := inherited Text;
end;

procedure TCustomDBEditEh.SetText(const Value: String);
begin
  if (csDesigning in ComponentState) and not DataIndepended then Exit;
  if not DataIndepended then DataSource.DataSet.Edit;
  InternalSetText(Value);
  if FDataPosting then Exit;
  try
    UpdateData;
  except
    FDataLink.Reset;
    raise;
  end;
end;

function TCustomDBEditEh.GetValue: Variant;
begin
  Result := GetVariantValue;
end;

procedure TCustomDBEditEh.SetValue(const Value: Variant);
begin
  SetVariantValue(Value);
end;

procedure TCustomDBEditEh.SetVariantValue(const VariantValue: Variant);
begin
  if (csDesigning in ComponentState) and not DataIndepended then Exit;
  if not DataIndepended then DataSource.DataSet.Edit;
  InternalSetValue(VariantValue);
  if FDataPosting then Exit;
  try
    UpdateData;
  except
    FDataLink.Reset;
    raise;
  end;
end;

procedure TCustomDBEditEh.SetControlEditMask(Value: string);
begin
  inherited EditMask := Value;
end;

procedure TCustomDBEditEh.SetControlReadOnly(Value: Boolean);
begin
  inherited ReadOnly := Value;
end;

function TCustomDBEditEh.ImageRect: TRect;
begin
  Result := Rect(0, 0, FImageWidth, ClientHeight);
  if inherited UseRightToLeftAlignment then
    OffsetRect(Result, ClientWidth - FImageWidth, 0);
end;

procedure TCustomDBEditEh.InternalUpdatePostData;
begin
  if DataIndepended
    then FDataLink.SetText(EditText)
    else FDataLink.SetText(Text);
end;

procedure TCustomDBEditEh.UpdateData;
begin
  if FFocused then ValidateEdit;
  if not PostDataEvent then
    InternalUpdatePostData;
  Modified := False;  
  if MRUList.AutoAdd and MRUList.Active and Showing then
    MRUList.Add(Text);
end;

procedure TCustomDBEditEh.WndProc(var Message: TMessage);
var
  ShiftState: TShiftState;
  MousePos: TPoint;
  ClickTime: LongInt;
begin
  if FInplaceMode then
    FIntfInplaceEditHolder.InplaceEditWndProc(Self, Message);
  if Message.Result <> 0 then Exit;
  if FInplaceMode then
    case Message.Msg of
      WM_SETFOCUS:
        begin
          if (GetParentForm(Self) = nil) or GetParentForm(Self).SetFocusedControl(FInplaceEditHolder) then
            Dispatch(Message);
          Exit;
        end;
      WM_LBUTTONDOWN:
        begin
          FIntfInplaceEditHolder.GetMouseDownInfo(MousePos, ClickTime);
          if IsDoubleClickMessage(MousePos,
//               ClientToScreen(SmallPointToPoint(MessageToTWMMouse(Message).Pos)), GetMessageTime - ClickTime)
{$IFDEF CIL}
               ClientToScreen(SmallPointToPoint(TWMMouse.Create(Message).Pos)), GetMessageTime - ClickTime)
{$ELSE}
               ClientToScreen(SmallPointToPoint(TWMMouse(Message).Pos)), GetMessageTime - ClickTime)
{$ENDIF}
          then
            Message.Msg := WM_LBUTTONDBLCLK;
        end;
    end;

  if (MRUList <> nil) and MRUList.DroppedDown then
  begin
    case Message.Msg of
      wm_KeyDown, wm_SysKeyDown, wm_Char:
{$IFDEF CIL}
        with TWMKey.Create(Message) do
{$ELSE}
        with TWMKey(Message) do
{$ENDIF}
        begin
          ShiftState := KeyDataToShiftState(KeyData);
          if ((CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT]) and not (ssAlt in ShiftState))
            or ((CharCode in [VK_HOME, VK_END]) and (ssCtrl in KeyDataToShiftState(KeyData)))
          then
          begin
            SendMessage(MRUListControl.Handle, Msg, Message.WParam, Message.LParam);
            Exit;
          end;
          if CharCode in [VK_RETURN, VK_ESCAPE] then
          begin
            MRUList.CloseUp(CharCode = VK_RETURN);
            Exit;
          end;
        end;
    end;
  end;

  inherited WndProc(Message);


  end;

procedure TCustomDBEditEh.ActiveChanged;
begin
  ResetMaxLength;
  UpdateEditButtonControlsState;
end;

procedure TCustomDBEditEh.DataChanged;
begin
  if FDataLink.Field <> nil then
  begin
    (*if (FAlignment <> FDataLink.Field.Alignment) and not PersistentProps['Alignment'] then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
      Invalidate;
    end;*)
    if FAlignment <> FDataLink.Field.Alignment then Invalidate;
    if not (evEditMaskEh in FAssignedValues) then
      SetControlEditMask(FDataLink.Field.EditMask);
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if FFocused and FDataLink.CanModify then
      if (FDataLink.Field is TMemoField) {$IFDEF EH_LIB_10}or (Field is TWideMemoField){$ENDIF} then
        InternalSetText(FDataLink.Field.AsString)
      else InternalSetText(FDataLink.Field.Text)
    else
    begin
      if (FDataLink.Field is TMemoField) {$IFDEF EH_LIB_10}or (Field is TWideMemoField){$ENDIF} then
        EditText := FDataLink.Field.AsString
      else EditText := FDataLink.Field.DisplayText;
      {if FDataLink.Editing and FDataLink.FModified then
        Modified := True;}
    end;
  end
  else if DataIndepended then
  begin
    if not (evEditMaskEh in FAssignedValues) then
      SetControlEditMask('');
    EditText := VarToStr(FDataLink.DataIndependentValue);
    //InternalSetText(VarToStr(FDataLink.DataIndependentValue));
  end else
  begin
    if not (evEditMaskEh in FAssignedValues) then
      SetControlEditMask('');
    EditText := '';
  end;
  UpdateControlReadOnly;
  Modified := False;
end;

procedure TCustomDBEditEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('EditMask', ReadEditMask, WriteEditMask, IsEditMaskStored);
end;

procedure TCustomDBEditEh.EditingChanged;
begin
  UpdateControlReadOnly;
end;

procedure TCustomDBEditEh.InternalSetText(AText: String);
begin
  inherited Text := AText;
end;

procedure TCustomDBEditEh.InternalSetValue(AValue: Variant);
begin
  InternalSetText(VarToStr(AValue));
end;

procedure TCustomDBEditEh.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateEditButtonControlList;
  SetEditRect;
end;

function TCustomDBEditEh.GetAlignment: TAlignment;
begin
  if evAlignmentEh in FAssignedValues then Result := FAlignment
  else Result := DefaultAlignment;
end;

procedure TCustomDBEditEh.SetAlignment(const Value: TAlignment);
begin
  if (evAlignmentEh in FAssignedValues) and (Value = FAlignment) then Exit;
  FAlignment := Value;
  Include(FAssignedValues, evAlignmentEh);
  if not (csLoading in ComponentState) then
    RecreateWnd;
{  if WordWrap
    then RecreateWnd
    else Invalidate;}
end;

function TCustomDBEditEh.IsAlignmentStored: Boolean;
begin
  Result := (evAlignmentEh in FAssignedValues);
end;

function TCustomDBEditEh.DefaultAlignment: TAlignment;
begin
  if Assigned(Field)
    then Result := Field.Alignment
    else Result := taLeftJustify;
end;

function TCustomDBEditEh.GetEditMask: String;
begin
  Result := inherited EditMask;
end;

procedure TCustomDBEditEh.SetEditMask(const Value: String);
var OldText: String;
begin
  OldText := '';
  if (evEditMaskEh in FAssignedValues) and (Value = inherited EditMask) then Exit;
  if (csLoading in ComponentState) and (Text <> '') and DataIndepended then
    OldText := Text;
  inherited EditMask := Value;
  Include(FAssignedValues, evEditMaskEh);
  if (csLoading in ComponentState) and (OldText <> '') and DataIndepended then
    InternalSetText(OldText);
  if {not (csLoading in ComponentState) and }  DataIndepended then
    InternalUpdatePostData
  else
    DataChange(nil);
end;

function TCustomDBEditEh.IsEditMaskStored: Boolean;
begin
  Result := (evEditMaskEh in FAssignedValues);
end;

function TCustomDBEditEh.DefaultEditMask: String;
begin
  if Assigned(Field)
    then Result := Field.EditMask
    else Result := '';
end;

function TCustomDBEditEh.IsTextStored: Boolean;
begin
  Result := (Text <> '') and DataIndepended;
end;

function TCustomDBEditEh.IsValueStored: Boolean;
begin
  Result := (Value <> Null) and DataIndepended;
end;

{$IFNDEF EH_LIB_6}
function TCustomDBEditEh.GetAutoSize: Boolean;
begin
  Result := inherited AutoSize;
end;
{$ENDIF}

procedure TCustomDBEditEh.SetAutoSize(Value: Boolean);
begin
  if AutoSize <> Value then
  begin
{$IFDEF EH_LIB_6}
    inherited SetAutoSize(Value);
{$ELSE}
    inherited AutoSize := Value;
{$ENDIF}
    UpdateHeight;
  end;
end;

procedure TCustomDBEditEh.SetAlwaysShowBorder(const Value: Boolean);
begin
  if FAlwaysShowBorder <> Value then
  begin
    FAlwaysShowBorder := Value;
    UpdateDrawBorder;
  end;
end;

procedure TCustomDBEditEh.SetWordWrap(const Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    RecreateWnd;
  end;
end;

procedure TCustomDBEditEh.ButtonDown(IsDownButton: Boolean);
begin
  if (EditButton.Style <> ebsUpDownEh) and (EditButton.Style <> ebsAltUpDownEh) then
  begin
    if not FDroppedDown then
    begin
      DropDown;
      FNoClickCloseUp := True;
    end;
  end;
end;

procedure TCustomDBEditEh.DropDown;
begin
  FEditButtonControlList[0].EditButtonControl.AlwaysDown := True;
  if MRUList.DroppedDown then
    MRUList.CloseUp(False);   
end;

procedure TCustomDBEditEh.CloseUp(Accept: Boolean);
begin
  with FEditButtonControlList[0].EditButtonControl do
    AlwaysDown := False;
end;

procedure TCustomDBEditEh.EditButtonClick(Sender: TObject);
var Handled: Boolean;
  i: Integer;
begin
  Handled := False;
  if (Sender = FEditButtonControlList[0].EditButtonControl) then
  begin
    EditButton.Click(Sender, Handled);
    if not Handled and Assigned(FOnButtonClick) then
      FOnButtonClick(Sender, Handled);
  end else if (Sender is TEditButtonControlEh) then
    for i := 1 to Length(FEditButtonControlList) - 1 do
      if (Sender = FEditButtonControlList[i].EditButtonControl) then
        EditButtons[i - 1].Click(Sender, Handled);
  if not Handled and FDroppedDown and not FNoClickCloseUp and
    (Sender = FEditButtonControlList[0].EditButtonControl)
    then CloseUp(False);
  FNoClickCloseUp := False;
end;

procedure TCustomDBEditEh.EditButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var DoClick: Boolean;
begin
  DoClick := (X >= 0) and (X < TControl(Sender).ClientWidth) and
    (Y >= 0) and (Y <= TControl(Sender).ClientHeight);
  if not DoClick then
    FNoClickCloseUp := False;
end;

procedure TCustomDBEditEh.EditButtonDown(Sender: TObject; TopButton: Boolean;
  var AutoRepeat: Boolean; var Handled: Boolean);
var
  i: Integer;
  p: TPoint;
//  Msg: TMsg;
begin
  SetFocus;
  Handled := False;
{  if PeekMessage(Msg, Handle, CM_IGNOREEDITDOWN, CM_IGNOREEDITDOWN, PM_NOREMOVE) then
//    if Msg.wParam = Integer(Sender) then
    if Msg.wParam = Integer(TEditButtonControlEh(Sender).Tag) then
    begin
      PeekMessage(Msg, Handle, CM_IGNOREEDITDOWN, CM_IGNOREEDITDOWN, PM_REMOVE);
      Exit;
    end;}
  if (Sender = FEditButtonControlList[0].EditButtonControl) then
  begin
    if Assigned(FOnButtonDown) then
      FOnButtonDown(Sender, TopButton, AutoRepeat, Handled);
    if not Handled then
      if Assigned(EditButton.DropdownMenu) then
      begin
        P := TControl(Sender).ClientToScreen(Point(0, TControl(Sender).Height));
        if EditButton.DropdownMenu.Alignment = paRight then
          Inc(P.X, TControl(Sender).Width);
        EditButton.DropdownMenu.Popup(p.X, p.y);
//        PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(Sender), 0);
        KillMouseUp(TControl(Sender));
//        PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(TEditButtonControlEh(Sender).Tag), 0);
        TControl(Sender).Perform(WM_LBUTTONUP, 0, 0);
      end else if EditButton.Action = nil then
        ButtonDown(not TopButton);
  end
  else if (Sender is TEditButtonControlEh) then
    for i := 1 to Length(FEditButtonControlList) - 1 do
      if (Sender = FEditButtonControlList[i].EditButtonControl) then
      begin
        if Assigned(EditButtons[i - 1].OnDown) then
          EditButtons[i - 1].OnDown(Sender, TopButton, AutoRepeat, Handled);
        if not Handled then
          if Assigned(EditButtons[i - 1].DropdownMenu) then
          begin
            P := TControl(Sender).ClientToScreen(Point(0, TControl(Sender).Height));
            if EditButtons[i - 1].DropdownMenu.Alignment = paRight then
              Inc(P.X, TControl(Sender).Width);
            EditButtons[i - 1].DropdownMenu.Popup(p.X, p.y);
//            PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(Sender), 0);
            KillMouseUp(TControl(Sender));
//            PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(TEditButtonControlEh(Sender).Tag), 0);
            TControl(Sender).Perform(WM_LBUTTONUP, 0, 0);
          end;
      end;
end;

procedure TCustomDBEditEh.EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TCustomDBEditEh.CMCancelMode(var Message: TCMCancelMode);

  function CheckDataListChilds: Boolean;
  var i: Integer;
  begin
    Result := False;
    if FMRUListControl <> nil then
      for i := 0 to MRUListControl.ControlCount - 1 do
        if MRUListControl.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;

var
  i: Integer;
begin
  inherited;
  for i := 0 to ControlCount - 1 do
    if GetCaptureControl = Controls[i] then
    begin
      Controls[i].Perform(WM_CANCELMODE, 0, 0);
      Break;
    end;
  if (Message.Sender <> Self) and not ContainsControl(Message.Sender) and
    (Message.Sender <> FMRUListControl) and not CheckDataListChilds
  then
    MRUList.CloseUp(False);
end;

procedure TCustomDBEditEh.SetEditButtons(const Value: TEditButtonsEh);
begin
  FEditButtons.Assign(Value);
end;

procedure TCustomDBEditEh.UpdateEditButtonControlList;
var NewEditButtonControlsCount, OldEditButtonControlsCount: Integer;
  i, Indent, MinButtonHeight, AButtonHeight, MaxButtonHeight: Integer;

  procedure ResetEditButtonControl(ControlRec: TEditButtonControlLineRec;
    Button: TEditButtonEh; Intex: Integer);
  begin
    ControlRec.EditButtonControl.Visible := Button.Visible;
    ControlRec.EditButtonControl.Enabled := Button.Enabled;
    ControlRec.EditButtonControl.Style := Button.Style;
    ControlRec.EditButtonControl.Glyph := Button.Glyph;
    ControlRec.EditButtonControl.NumGlyphs := Button.NumGlyphs;
    ControlRec.EditButtonControl.Hint := Button.Hint;
    ControlRec.EditButtonControl.Flat := Flat;
    if not Button.Visible then
      ControlRec.EditButtonControl.Width := 0
    else if Button.Width > 0 then
      ControlRec.EditButtonControl.Width := Button.Width
    else if Flat then
      ControlRec.EditButtonControl.Width := FlatButtonWidth
    else
      ControlRec.EditButtonControl.Width := GetSystemMetrics(SM_CXVSCROLL);

    if Button.Visible then
    begin
      if MaxButtonHeight > Round(ControlRec.EditButtonControl.Width * 3 / 2)
        then AButtonHeight := DefaultEditButtonHeight(ControlRec.EditButtonControl.Width, Flat)
        else AButtonHeight := MaxButtonHeight;

      if AButtonHeight < MinButtonHeight then
        MinButtonHeight := AButtonHeight;
    end;

    ControlRec.ButtonLine.Visible := Flat and Button.Visible and not ThemesEnabled;
    if Flat and Button.Visible and not ThemesEnabled
      then ControlRec.ButtonLine.Width := 1
      else ControlRec.ButtonLine.Width := 0;

    ControlRec.EditButtonControl.OnDown := EditButtonDown;
    ControlRec.EditButtonControl.OnClick := EditButtonClick;
    ControlRec.EditButtonControl.OnMouseMove := EditButtonMouseMove;
    ControlRec.EditButtonControl.OnMouseUp := EditButtonMouseUp;
    ControlRec.EditButtonControl.Tag := Intex;

  end;

begin
  NewEditButtonControlsCount := EditButtons.Count + 1;
  MinButtonHeight := MAXINT;
  MaxButtonHeight := ButtonRect.Bottom - ButtonRect.Top;
  if NewEditButtonControlsCount < Length(FEditButtonControlList) then
  begin
    for i := NewEditButtonControlsCount to Length(FEditButtonControlList) - 1 do
    begin
      FEditButtonControlList[i].EditButtonControl.Free;
      FEditButtonControlList[i].ButtonLine.Free;
    end;
    SetLength(FEditButtonControlList, NewEditButtonControlsCount);
  end else
  begin
    OldEditButtonControlsCount := Length(FEditButtonControlList);
    SetLength(FEditButtonControlList, NewEditButtonControlsCount);
    for i := OldEditButtonControlsCount to NewEditButtonControlsCount - 1 do
    begin
      FEditButtonControlList[i].EditButtonControl := CreateEditButtonControl;
      FEditButtonControlList[i].EditButtonControl.Parent := Self;
      FEditButtonControlList[i].ButtonLine := TShape.Create(Self);
      FEditButtonControlList[i].ButtonLine.Parent := Self;
    end;
  end;

  ResetEditButtonControl(FEditButtonControlList[0], EditButton, 0);
  for i := 1 to EditButtons.Count do
    ResetEditButtonControl(FEditButtonControlList[i], EditButtons[i - 1], i);


  if inherited UseRightToLeftAlignment
    then Indent := 0
    else Indent := ClientWidth;

  for i := EditButtons.Count downto 0 do
    with FEditButtonControlList[i] do
    begin
      if inherited UseRightToLeftAlignment then
      begin
        EditButtonControl.SetBounds(Indent, ButtonRect.Top,
          EditButtonControl.Width, MinButtonHeight);
        Inc(Indent, EditButtonControl.Width);
        ButtonLine.SetBounds(Indent, ButtonRect.Top, ButtonLine.Width, MinButtonHeight);
        Inc(Indent, ButtonLine.Width);
      end else
      begin
        EditButtonControl.SetBounds(Indent - EditButtonControl.Width, ButtonRect.Top,
          EditButtonControl.Width, MinButtonHeight);
        Dec(Indent, EditButtonControl.Width);
        ButtonLine.SetBounds(Indent - ButtonLine.Width, ButtonRect.Top, ButtonLine.Width, MinButtonHeight);
        Dec(Indent, ButtonLine.Width);
      end
    end;

  if inherited UseRightToLeftAlignment
    then FButtonWidth := Indent
    else FButtonWidth := ClientWidth - Indent;
  FButtonHeight := MinButtonHeight;
end;

procedure TCustomDBEditEh.UpdateEditButtonControlsState;
var i: Integer;
begin
  if Length(FEditButtonControlList) = 0 then Exit;
  if not Enabled 
    then FEditButtonControlList[0].EditButtonControl.Enabled := ButtonEnabled
    else FEditButtonControlList[0].EditButtonControl.Enabled:= EditButton.Enabled;
  FEditButtonControlList[0].EditButtonControl.Active := FBorderActive;
  if FBorderActive
    then FEditButtonControlList[0].ButtonLine.Pen.Color := clBtnFace
    else FEditButtonControlList[0].ButtonLine.Pen.Color := Color;

  for i := 1 to Length(FEditButtonControlList) - 1 {EditButtons.Count} do
    with FEditButtonControlList[i] do
    begin
    if not Enabled 
      then FEditButtonControlList[i].EditButtonControl.Enabled := ButtonEnabled
      else FEditButtonControlList[i].EditButtonControl.Enabled:= EditButtons[i-1].Enabled;
      EditButtonControl.Active := FBorderActive;
      if FBorderActive
        then ButtonLine.Pen.Color := clBtnFace
        else ButtonLine.Pen.Color := Color;
    end;
end;

procedure TCustomDBEditEh.EditButtonChanged(Sender: TObject);
begin
  if not HandleAllocated then Exit;
  UpdateEditButtonControlList;
  UpdateEditButtonControlsState;
  SetEditRect;
  Invalidate;
end;

procedure TCustomDBEditEh.CMRecreateWnd(var Message: TMessage);
var
  WasFocused: Boolean;
begin
  WasFocused := Focused;
  inherited;
  if WasFocused then
    UpdateDrawBorder;
end;

function TCustomDBEditEh.GetEditButtonByShortCut(ShortCut: TShortCut): TEditButtonEh;
var i: Integer;
begin
  Result := nil;
  if (ShortCut = FEditButton.ShortCut) then
    Result := FEditButton
  else
    for i := 0 to EditButtons.Count - 1 do
      if (ShortCut = EditButtons[i].ShortCut) then
      begin
        Result := EditButtons[i];
        Exit;
      end;
end;

function TCustomDBEditEh.GetPasswordChar: Char;
begin
  Result := inherited PasswordChar;
end;

procedure TCustomDBEditEh.SetPasswordChar(const Value: Char);
begin
  if inherited PasswordChar <> Value then
  begin
    inherited PasswordChar := Value;
    RecreateWnd;
  end;
end;

procedure TCustomDBEditEh.SetInplaceEditHolder(AInplaceEditHolder: TWinControl);
begin
  if AInplaceEditHolder = FInplaceEditHolder then Exit;
  FInplaceEditHolder := AInplaceEditHolder;
  if FInplaceEditHolder = nil then
    FIntfInplaceEditHolder := nil
  else if not Supports(FInplaceEditHolder, IInplaceEditHolderEh, FIntfInplaceEditHolder) then
    raise Exception.Create('InplaceEditHolder have to support IInplaceEditHolderEh interface');
  FInplaceMode := (FInplaceEditHolder <> nil);
end;

procedure TCustomDBEditEh.CheckInplaceEditHolderKeyDown(var Key: Word; Shift: TShiftState);
begin
  if FInplaceMode then
    FIntfInplaceEditHolder.InplaceEditKeyDown(Self, Key, Shift);
end;

procedure TCustomDBEditEh.CheckInplaceEditHolderKeyPress(var Key: Char);
begin
  if FInplaceMode then
    FIntfInplaceEditHolder.InplaceEditKeyPress(Self, Key);
end;

procedure TCustomDBEditEh.CheckInplaceEditHolderKeyUp(var Key: Word; Shift: TShiftState);
begin
  if FInplaceMode then
    FIntfInplaceEditHolder.InplaceEditKeyUp(Self, Key, Shift);
end;

procedure TCustomDBEditEh.InternalMove(const Loc: TRect; Redraw: Boolean);
{$IFDEF CIL}
var
  Msg: TCMCancelMode;
{$ENDIF}
begin
  if IsRectEmpty(Loc) then Hide
  else
  begin
    CreateHandle;
    Redraw := Redraw or not IsWindowVisible(Handle);
    Invalidate;
{$IFDEF CIL}
    Msg := TCMCancelMode.Create;
    Msg.Sender := FInplaceEditHolder;
    Perform(CM_CANCELMODE, 0, Msg.OriginalMessage.LParam);
    // { DONE : Do cancel mode } Perform(CM_CANCELMODE, 0, ObjectToIntPtr(FInplaceEditHolder));
{$ELSE}
    Perform(CM_CANCELMODE, 0, ObjectToIntPtr(FInplaceEditHolder));
{$ENDIF}
    with Loc do
      SetWindowPos(Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_SHOWWINDOW {or SWP_NOREDRAW});
    //BoundsChanged; ??
    if Redraw then Invalidate;
    if FInplaceEditHolder.Focused then
      Windows.SetFocus(Handle);
  end;
end;

procedure TCustomDBEditEh.CMShowingChanged(var Message: TMessage);
begin
  if not FInplaceMode then { Ignore showing using the Visible property when InplaceMode}
    inherited;
end;

procedure TCustomDBEditEh.Hide;
begin
  if not FInplaceMode then
    Visible := False
  else if HandleAllocated and IsWindowVisible(Handle) then
  begin
    Invalidate;
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER {or SWP_NOREDRAW});
    if Focused then
      Windows.SetFocus(FInplaceEditHolder.Handle);
  end;
end;

procedure TCustomDBEditEh.Move(const Loc: TRect);
begin
  if FInplaceMode
    then InternalMove(Loc, True)
    else BoundsRect := Loc;
end;

procedure TCustomDBEditEh.SetFocus;
begin
  if not FInplaceMode then
    inherited SetFocus
  else if IsWindowVisible(Handle) then
    Windows.SetFocus(Handle);
end;

procedure TCustomDBEditEh.UpdateLoc(const Loc: TRect);
begin
  if FInplaceMode
    then InternalMove(Loc, False)
    else BoundsRect := Loc;
end;

function TCustomDBEditEh.GetVisible: Boolean;
begin
  if FInplaceMode
    then Result := IsWindowVisible(Handle)
    else Result := inherited Visible;
end;

procedure TCustomDBEditEh.SetVisible(const Value: Boolean);
begin
  if FInplaceMode and not Value
    then Hide
    else inherited Visible := Value;
end;

procedure TCustomDBEditEh.WMKillFocus(var Message: TWMKillFocus);
var i: Integer;
begin
  if csDestroying in ComponentState then
    inherited
  else
  begin
    if MRUList.DroppedDown and not (Message.FocusedWnd = MRUListControl.Handle) then
      MRUList.CloseUp(False);
    inherited;
    UpdateDrawBorder;
    Invalidate;
    for i := 0 to ControlCount - 1 do
      if GetCaptureControl = Controls[i] then
      begin
        Controls[i].Perform(WM_CANCELMODE, 0, 0);
        Break;
      end;
  end;
end;

procedure TCustomDBEditEh.WMLButtonDown(var Message: TWMLButtonDown);
//var
//  Form: TCustomForm;
begin
  inherited;
  if MouseCapture then
  begin
    if GetFocus <> Handle then
      MouseCapture := False;
{    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.ActiveControl <> Self) then
      MouseCapture := False;}
  end;
end;

procedure TCustomDBEditEh.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  UpdateDrawBorder;
  Invalidate;
end;

function TCustomDBEditEh.GetDisplayTextForPaintCopy: String;
begin
  if (csDesigning in ComponentState) and not (FDataLink.Active) then
    Result := Name
  else if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
  begin
    Result := FDataLink.Field.DisplayText;
    case CharCase of
      ecUpperCase: Result := NlsUpperCase(Result);
      ecLowerCase: Result := NlsLowerCase(Result);
    end;
  end else
    Result := EditText;
end;

procedure TCustomDBEditEh.SetMRUList(const Value: TMRUListEh);
begin
  FMRUList.Assign(Value);
end;

function TCustomDBEditEh.GetMRUListControl: TWinControl;
begin
  if not Assigned(FMRUListControl) then
    FMRUListControl := CreateMRUListControl;
  Result := FMRUListControl;
end;

function TCustomDBEditEh.CreateMRUListControl: TWinControl;
begin
  Result := TMRUListboxEh.Create(Self);
  Result.Visible := False;
  TMRUListboxEh(Result).Ctl3D := False;
  TMRUListboxEh(Result).ParentCtl3D := False;
  TMRUListboxEh(Result).Sorted := True;
  Result.Parent := Self; // Already set parent in TPopupListboxEh.CreateWnd
  ShowWindow(Result.Handle, SW_HIDE); //For Delphi 5 design time
  TMRUListboxEh(Result).OnMouseUp := MRUListControlMouseUp;
end;

procedure TCustomDBEditEh.MRUListControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    MRUList.CloseUp(PtInRect(MRUListControl.ClientRect, Point(X, Y)));
end;

procedure TCustomDBEditEh.MRUListCloseUp(Sender: TObject; Accept: Boolean);
begin
  if MRUList.DroppedDown then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(MRUListControl.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    MRUListControl.Visible := False;
{    if TPopupListboxEh(MRUListControl).SizeGripResized then
    begin
      MRUList.Rows := TPopupListboxEh(MRUListControl).RowCount;
      MRUList.Width := TPopupListboxEh(MRUListControl).Width;
    end;}
    if (GetFocus = MRUListControl.Handle) then
      SetFocus;
    MRUList.DroppedDown := False;
    if Accept and not ReadOnly and FDataLink.Edit then
    begin
      with TPopupListboxEh(MRUListControl) do
       if ItemIndex >= 0 then
         //Self.Text := Items[ItemIndex];
         InternalSetText(Items[ItemIndex]);
      if FFocused then SelectAll;
      //////Modified := True;
    end;
  end;
end;

procedure TCustomDBEditEh.MRUListControlResized(Sender: TObject);
begin
  if MRUList.DroppedDown then
  begin
    MRUList.Rows := TPopupListboxEh(MRUListControl).RowCount;
    MRUList.Width := TPopupListboxEh(MRUListControl).Width;
  end;
end;

procedure TCustomDBEditEh.MRUListDropDown(Sender: TObject);
{
  procedure FilterMRUItems(ss: TStrings; ds: TStrings);
  var
    i: Integer;
    Accept: Boolean;
  begin
    ds.BeginUpdate;
    try
      ds.Clear;
      for i := 0 to ss.Count-1 do
      begin
        Accept := False;
        FilterMRUItem(ss[i], Accept);
        if Accept then ds.Add(ss[i]);
      end;
    finally
      ds.EndUpdate;
    end;
  end;
}
var
  P: TPoint;
  OldSizeGripResized: Boolean;
  EditRect: TRect;
begin
  with TPopupListboxEh(MRUListControl) do
  begin
    OldSizeGripResized := TPopupListboxEh(MRUListControl).SizeGripResized;
//    FilterMRUItems(MRUList.Items, Items);
    if not MRUList.FilterItemsTo(Items, Text) then
      MRUList.CloseUp(False);
    if Items.Count < MRUList.Rows
      then RowCount := Items.Count
      else RowCount := MRUList.Rows;
    if MRUList.DroppedDown then
    begin
      SendStructMessage(Self.Handle, EM_GETRECT, 0, EditRect);
      EditRect.TopLeft := Self.ClientToScreen(EditRect.TopLeft);
      EditRect.BottomRight := Self.ClientToScreen(EditRect.BottomRight);
      P := AlignDropDownWindowRect(EditRect, MRUListControl, daLeft);
      SetWindowPos(MRUListControl.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      TPopupListboxEh(MRUListControl).SizeGripResized := OldSizeGripResized;
    end;
    if (Items.Count <= 0) and MRUList.DroppedDown then
      MRUList.CloseUp(False)
    else if not MRUList.DroppedDown and (Items.Count > 0) then
    begin
      Color := Self.Color;
      Font := Self.Font;
      ItemHeight := GetTextHeight;
      ItemIndex := -1;
      //if (Width < Self.Width) then Width := Self.Width;
      if Items.Count < RowCount then RowCount := Items.Count;
      SendStructMessage(Self.Handle, EM_GETRECT, 0, EditRect);
      EditRect.TopLeft := Self.ClientToScreen(EditRect.TopLeft);
      EditRect.BottomRight := Self.ClientToScreen(EditRect.BottomRight);
      Width := EditRect.Right-EditRect.Left;
      P := AlignDropDownWindowRect(EditRect, MRUListControl, daLeft);
      SetWindowPos(MRUListControl.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
        SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      MRUListControl.Visible := True; //commment for Tab key
      TPopupListboxEh(MRUListControl).SizeGrip.Visible := True;
      TMRUListboxEh(MRUListControl).UpdateScrollBar;
      MRUList.DroppedDown := True;
      TPopupListboxEh(MRUListControl).SizeGripResized := False;
      TPopupListboxEh(MRUListControl).SizeGrip.OnParentResized := MRUListControlResized;
    end;
  end;
end;

procedure TCustomDBEditEh.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if (Message.NotifyCode = EN_CHANGE) then
    FUserTextChanged := True;
end;

procedure TCustomDBEditEh.UserChange;
var
  BlankText: String;
begin
  if IsMasked
    then BlankText := FormatMaskText(EditMask, '')
    else BlankText := '';
  if MRUList.DroppedDown and (Text = BlankText)then
    MRUList.CloseUp(False)
  else if MRUList.Active and Showing and
    not FDroppedDown and (Text <> BlankText) and FFocused
  then
    MRUList.DropDown;
end;

procedure TCustomDBEditEh.CMMouseWheel(var Message: TCMMouseWheel);
begin
  if MRUList.DroppedDown then
{$IFDEF CIL}
    with Message.OriginalMessage do
{$ELSE}
    with TMessage(Message) do
{$ENDIF}
      if SendMessage(MRUListControl.Handle, CM_MOUSEWHEEL, WParam, LParam) <> 0 then
      begin
        Result := 1;
        Exit;
      end;
  inherited;
end;

procedure TCustomDBEditEh.FilterMRUItem(AText: String; var Accept: Boolean);
begin
  if MRUList.CaseSensitive
    then Accept := (NlsCompareStr(Copy(AText, 1, Length(Text)), Text) = 0)
    else Accept := (NlsCompareText(Copy(AText, 1, Length(Text)), Text) = 0);
  if Assigned(MRUList.OnFilterItem) then
    MRUList.OnFilterItem(Self, Accept);
end;

procedure TCustomDBEditEh.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
end;

function TCustomDBEditEh.GetImages: TCustomImageList;
begin
  Result := EditImage.Images;
end;

procedure TCustomDBEditEh.SetImages(const Value: TCustomImageList);
begin
  EditImage.Images := Value;
  EditImage.Visible := True;
end;

function TCustomDBEditEh.DefaultImageIndex: Integer;
begin
  Result := -1;
end;

procedure TCustomDBEditEh.UpdateImageIndex;
var
  ImageIndex: Longint;
begin
  if EditImage.Visible and (EditImage.Images <> nil) then
  begin
    ImageIndex := DefaultImageIndex;
    if VarType(Value) in [varDouble, varSmallint, varInteger, varSingle, varCurrency] then
      ImageIndex := Integer(Round(Value));
    if Assigned(OnGetImageIndex) then
      OnGetImageIndex(Self, ImageIndex);
    EditImage.ImageIndex := ImageIndex;
  end;
end;

procedure TCustomDBEditEh.SetBorderStyle(ABorderStyle: TBorderStyle);
begin
  BorderStyle := ABorderStyle;
end;

procedure TCustomDBEditEh.SetColor(AColor: TColor);
begin
  Color := AColor;
end;

procedure TCustomDBEditEh.SetFont(AFont: TFont);
begin
  Font := AFont;
end;

procedure TCustomDBEditEh.SetOnExit(AKeyPressEvent: TNotifyEvent);
begin
  OnExit := AKeyPressEvent;
end;

procedure TCustomDBEditEh.SetOnKeyPress(AKeyPressEvent: TKeyPressEvent);
begin
  OnKeyPress := AKeyPressEvent;
end;

function TCustomDBEditEh.GetFont: TFont;
begin
  Result := Font;
end;

procedure TCustomDBEditEh.SetOnGetImageIndex(const Value: TGetImageIndexEventEh);
begin
  FOnGetImageIndex := Value;
  UpdateImageIndex;
end;

procedure TCustomDBEditEh.SetTooltips(const Value: Boolean);
begin
  if FTooltips <> Value then
  begin
    FTooltips := Value;
    UpdateHintProcessing;
  end;
end;

procedure TCustomDBEditEh.UpdateHintProcessing;
begin
  inherited ShowHint := FTooltips or FShowHint;
end;

function TCustomDBEditEh.GetCanvas: TCanvas;
begin
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  Result := FCanvas;
end;

function TCustomDBEditEh.GetShowHint: Boolean;
begin
  Result := FShowHint;
end;

procedure TCustomDBEditEh.SetShowHint(const Value: Boolean);
begin
  if FShowHint <> Value then
  begin
    FShowHint := Value;
    UpdateHintProcessing;
  end;
end;

procedure TCustomDBEditEh.Undo;
begin
  if not DataIndepended then DataSource.DataSet.Edit;
  inherited Undo;
  if FDataPosting or FFocused then Exit;
  try
    UpdateData;
  except
    FDataLink.Reset;
    raise;
  end;
end;

procedure TCustomDBEditEh.Clear;
begin
  Text := '';
end;

{ TCustomDBDateTimeEditEh }

type TDateOrder = (doMDY, doDMY, doYMD);

  TDateTimeStampEh = packed record
    Year : Integer;
    Month : Integer;
    Day : Integer;
    Hour : Integer;
    Minute : Integer;
    Second : Integer;
  end;

const
  CenturyOffset: Byte = 60;
  DefaultDateOrder = doDMY;

function CurrentYear: Word;
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := SystemTime.wYear;
end;

function ExpandYear(Year: Integer): Integer;
var
  N: Longint;
begin
  Result := Year;
  if Result < 100 then
  begin
    N := CurrentYear - CenturyOffset;
    Inc(Result, N div 100 * 100);
    if (CenturyOffset > 0) and (Result < N) then
      Inc(Result, 100);
  end;
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result); { leap-year Feb is special }
end;

function CorrectDate(var Year, Month, Day: Integer): Boolean;
var
  CurYear, CurMonth, CurDay: Word;
begin
  Result := False;
  DecodeDate(Date, CurYear, CurMonth, CurDay);
  if Day <= 0 then Day := CurDay;
  if Month <= 0 then Month := CurMonth;
  if Year <= 0 then Year := CurYear;
  if Month > 12 then Month := 12;
  if Year > 9999 then Year := 9999;
  if Year >= 0 then Year := ExpandYear(Year);
  if DaysPerMonth(Year, Month) < Day then
    Day := DaysPerMonth(Year, Month);
  if (Day <> CurDay) or (Month <> CurMonth) or (Year <> CurYear) then
    Result := True;
end;

function CorrectTime(var Hor, Min, Sec: Integer): Boolean;
begin
  Result := False;
  if (Hor < 0) or (Min < 0) or (Sec < 0) or
    (Hor > 23) or (Min > 59) or (Sec > 59) then
  begin
    Result := True;
    if (Hor < 0) then Hor := 0;
    if Min < 0 then Min := 0;
    if Sec < 0 then Sec := 0;
    if Hor > 23 then Hor := 23;
    if Min > 59 then Min := 59;
    if Sec > 59 then Sec := 59;
  end;
end;

function GetDateOrder(const DateFormat: string): TDateOrder;
var
  I: Integer;
begin
  Result := DefaultDateOrder;
  I := 1;
  while I <= Length(DateFormat) do
  begin
    case Chr(Ord(DateFormat[I]) and $DF) of
{$IFDEF RX_D3}
      'E': Result := doYMD;
{$ENDIF}
      'Y': Result := doYMD;
      'M': Result := doMDY;
      'D': Result := doDMY;
    else
      Inc(I);
      Continue;
    end;
    Exit;
  end;
  Result := DefaultDateOrder; { default }
end;

function DefDateFormat(FourDigitYear: Boolean): string;
begin
  if FourDigitYear then
  begin
    case GetDateOrder(ShortDateFormat) of
      doMDY: Result := 'MM/DD/YYYY';
      doDMY: Result := 'DD/MM/YYYY';
      doYMD: Result := 'YYYY/MM/DD';
    end;
  end else
  begin
    case GetDateOrder(ShortDateFormat) of
      doMDY: Result := 'MM/DD/YY';
      doDMY: Result := 'DD/MM/YY';
      doYMD: Result := 'YY/MM/DD';
    end;
  end;
end;

function DefTimeFormat: string;
begin
  Result := 'HH:NN:SS';
end;

{function DefDateMask(BlanksChar: Char; FourDigitYear: Boolean): string;
begin
  if FourDigitYear then
  begin
    case GetDateOrder(ShortDateFormat) of
      doMDY, doDMY: Result := '!99/99/9999;1;';
      doYMD: Result := '!9999/99/99;1;';
    end;
  end else
  begin
    case GetDateOrder(ShortDateFormat) of
      doMDY, doDMY: Result := '!99/99/99;1;';
      doYMD: Result := '!99/99/99;1;';
    end;
  end;
  if Result <> '' then Result := Result + BlanksChar;
end;


function DefTimeMask(BlanksChar: Char): string;
begin
  Result := '!99:99:99;1;' + BlanksChar;
end;
}

function DoEncodeDate(Year, Month, Day: Integer; var Date: TDateTime): Boolean;
var
  I: Integer;
  Lp: Boolean;
begin
  Result := False;
  if not ((Year >= 1) and (Year <= 9999)) then Exit;
  Lp := IsLeapYear(Year);
  if {(Year >= 1) and (Year <= 9999) and}(Month >= 1) and (Month <= 12) and
    (Day >= 1) and (Day <= MonthDays[Lp, Month]) then
  begin
    for I := 1 to Month - 1 do Inc(Day, MonthDays[Lp, I]);
    I := Year - 1;
    Date := I * 365 + I div 4 - I div 100 + I div 400 + Day - DateDelta;
    Result := True;
  end;
end;

function DoEncodeTime(Hour, Min, Sec, MSec: Word; var Time: TDateTime): Boolean;
begin
  Result := False;
  if (Hour < 24) and (Min < 60) and (Sec < 60) and (MSec < 1000) then
  begin
    Time := (Hour * 3600000 + Min * 60000 + Sec * 1000 + MSec) / MSecsPerDay;
    Result := True;
  end;
end;

procedure GetFormatElementAtPos(Text: String; var Pos, Len: Integer; FourDigitYear: Boolean);
var FormatChar: Char;
  DateFormat: String;
  i, fp, l: Integer;
begin
  DateFormat := DefDateFormat(FourDigitYear);
  if Pos > Length(DateFormat) then Pos := Length(DateFormat);
  FormatChar := DateFormat[Pos];
  if (FormatChar = DateSeparator) or (FormatChar = TimeSeparator) then
  begin
    Inc(Pos);
    if Pos > Length(DateFormat) then Exit;
    FormatChar := DateFormat[Pos];
  end;
  if not CharInSetEh(NlsUpperCase(FormatChar)[1], ['D', 'M', 'Y', 'H', 'N', 'S']) then Exit;
  fp := 0;
  for i := 1 to Length(DateFormat) do
    if DateFormat[i] = FormatChar then
    begin
      fp := i;
      Break;
    end;
  l := Length(DateFormat) - fp + 1;
  for i := fp to Length(DateFormat) do
    if DateFormat[i] <> FormatChar then
    begin
      l := i - fp;
      Break;
    end;
  Pos := fp; Len := l;
end;

function IncrementStrDateAtPos(const Text, DateTimeMask: String; IsIncrease: Boolean; var Pos, Len: Integer): String;
var FormatChar: Char;
  DFormat: String;
  i, fp, l, n: Integer;
begin
  Result := Text;
  if Pos > Length(DateTimeMask) then Pos := Length(DateTimeMask);
  FormatChar := DateTimeMask[Pos];
  if (FormatChar = DateSeparator) or ( FormatChar = TimeSeparator) then
  begin
    Inc(Pos);
    if Pos > Length(DateTimeMask) then Exit;
    FormatChar := DateTimeMask[Pos];
  end;
  if not CharInSetEh(NlsUpperCase(FormatChar)[1], ['D', 'M', 'Y', 'H', 'N', 'S']) then Exit;
  fp := 0;
  for i := 1 to Length(DateTimeMask) do
    if DateTimeMask[i] = FormatChar then
    begin
      fp := i;
      Break;
    end;
  l := Length(DateTimeMask) - fp + 1;
  DFormat := '';
  for i := fp to Length(DateTimeMask) do
    if DateTimeMask[i] <> FormatChar then
    begin
      l := i - fp;
      Break;
    end else
      DFormat := DFormat + '0';
  n := StrToIntDef(Copy(Text, fp, l), 0);
  case NlsUpperCase(FormatChar)[1] of
    'D': if IsIncrease then if n >= 31 then n := 1 else Inc(n)
         else if n <= 1 then n := 31 else Dec(n);
    'M': if IsIncrease then if n >= 12 then n := 1 else Inc(n)
         else if n <= 1 then n := 12 else Dec(n);
    'Y': if IsIncrease then if n >= 9999 then n := 1 else Inc(n)
         else if n <= 1 then n := 9999 else Dec(n);
    'H': if IsIncrease then if n >= 23 then n := 0 else Inc(n)
         else if n <= 0 then n := 23 else Dec(n);
    'N', 'S': if IsIncrease then if n >= 59 then n := 0 else Inc(n)
              else if n <= 0 then n := 59 else Dec(n);
  end;
  DFormat := FormatFloat(DFormat, n);
  Pos := fp; Len := l;
  Result := Copy(Text, 1, fp - 1) + DFormat + Copy(Text, fp + l, 255);
end;

procedure ClearElementsMask(var ElementMask: TElementMaskPosEh);
begin
  ElementMask.Pos := -1;
  ElementMask.Length := -1;
  ElementMask.Present := False;
end;

procedure ClearDateTimeElementsMask(var DateTimeMaskPos: TDateTimeElementsMaskPosEh);
begin
  ClearElementsMask(DateTimeMaskPos.Year);
  ClearElementsMask(DateTimeMaskPos.Month);
  ClearElementsMask(DateTimeMaskPos.Day);
  ClearElementsMask(DateTimeMaskPos.Hour);
  ClearElementsMask(DateTimeMaskPos.Min);
  ClearElementsMask(DateTimeMaskPos.Sec);
end;

function EditFormatToEditMask(EditFormatStr: String; var DateTimeMaskPos: TDateTimeElementsMaskPosEh): String;
var
  i, EmPos: Integer;
  CurElement, C: Char;
  CurElementLength: Integer;
  EscChar: Boolean;
  ADateTimeMaskPos: TDateTimeElementsMaskPosEh;

  procedure AddToMask(var ElementMask: TElementMaskPosEh);
  begin
    if ((CurElement = 'Y') and not (CurElementLength in [4,2])) or
       ((CurElement <> 'Y') and (CurElementLength <> 2))  then
      raise Exception.Create('Invalid datetime format element length: "' + CurElement +'"');
    if ElementMask.Present then
      raise Exception.Create('Duplicating datetime format element: "' + CurElement +'"');
    ElementMask.Pos := EmPos - CurElementLength;
    ElementMask.Length := CurElementLength;
    ElementMask.Present := True;
    Result := Result + DupeString('9', CurElementLength);
  end;

  procedure PromoteDateTimeChar(DateTimeChar: Char);
  begin
    if CurElement = DateTimeChar then
      Inc(CurElementLength)
    else
    begin
      if CurElement <> #0 then
      begin
        case CurElement of
          'Y': AddToMask(ADateTimeMaskPos.Year);
          'M': AddToMask(ADateTimeMaskPos.Month);
          'D': AddToMask(ADateTimeMaskPos.Day);
          'H': AddToMask(ADateTimeMaskPos.Hour);
          'N': AddToMask(ADateTimeMaskPos.Min);
          'S': AddToMask(ADateTimeMaskPos.Sec);
        end;
      end;
      CurElementLength := 1;
    end;
    if ((CurElement = 'Y') and (CurElementLength > 4)) or
       ((CurElement <> 'Y') and (CurElementLength > 2))
    then
      raise Exception.Create('Element in EditFormat: "' + EditFormatStr + '" is too long. Pos: ' + IntToStr(i));
    CurElement := DateTimeChar;
    EscChar := False;
  end;

begin
  Result := '';
  ClearDateTimeElementsMask(ADateTimeMaskPos);
  CurElement := #0;
  CurElementLength := 0;
  EmPos := 1;
  EscChar := False;
  for i := 1 to Length(EditFormatStr) do
  begin
    C := NlsUpperCase(EditFormatStr[i])[1];
    if CharInSetEh(C, ['D', 'M', 'Y', 'H', 'N', 'S']) and not EscChar then
      PromoteDateTimeChar(C)
    else
    begin
      if CurElement <> #0 then
        PromoteDateTimeChar(#0);
      if (NlsUpperCase(EditFormatStr[i])[1] = '\') and not EscChar then
      begin
        Dec(EmPos);
        EscChar := True;
      end
      else if CharInSetEh(C, ['!','>','<','L','l','A','a','C','c','0','9','#',';']) and
        ( (i = 1) or ((NlsUpperCase(EditFormatStr[i])[1] <> '\')) )
      then
      begin
        Result := Result + '\' + EditFormatStr[i];
        EscChar := False;
      end else
      begin
        Result := Result + EditFormatStr[i];
        EscChar := False;
      end;
      CurElement := #0;
    end;
    Inc(EmPos);
  end;
  if CurElement <> #0 then
    PromoteDateTimeChar(#0);
  Result := '!' + Result + ';1; ';
  DateTimeMaskPos := ADateTimeMaskPos;
end;

function StrToWordCheck(Str: String): Integer;
var
  i, p: Integer;
  s: String;
begin

  Result := -1;
  p := Length(Str) + 1;
  for i := 1 to Length(Str) do
    if Str[i] <> ' ' then
    begin
      p := i;
      Break;
    end;

  if p = Length(Str) + 1 then
    Exit;

  for i := p to Length(Str) do
    if not CharInSetEh(Str[i], ['0','1','2','3','4','5','6','7','8','9',' ']) then
      Exit
    else if Str[i] <> ' ' then
      s := s + Str[i];

  try
    Result := StrToInt(s);
  except
    Result := -1;
  end;
end;

procedure ReplaceTime(var DateTime: TDateTime; const NewTime: TDateTime);
begin
  DateTime := Trunc(DateTime);
  if DateTime >= 0 then
    DateTime := DateTime + Abs(Frac(NewTime))
  else
    DateTime := DateTime - Abs(Frac(NewTime));
end;

{$IFNDEF EH_LIB_6}

procedure DecodeDateTime(const AValue: TDateTime; out AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word);
begin
  DecodeDate(AValue, AYear, AMonth, ADay);
  DecodeTime(AValue, AHour, AMinute, ASecond, AMilliSecond);
end;

function TryEncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word; out AValue: TDateTime): Boolean;
var
  LTime: TDateTime;
begin
  Result := DoEncodeDate(AYear, AMonth, ADay, AValue);
  if Result then
  begin
    Result := DoEncodeTime(AHour, AMinute, ASecond, AMilliSecond, LTime);
    if Result then
      AValue := AValue + LTime;
  end;
end;

function EncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word): TDateTime;
begin
  if not TryEncodeDateTime(AYear, AMonth, ADay,
                           AHour, AMinute, ASecond, AMilliSecond, Result) then
    raise EConvertError.Create(SDateEncodeError);
end;

function TryStrToDateTime(const S: string; out Value: TDateTime): Boolean;
begin
  Result := True;
  try
    Value := StrToDateTime(S);
  except
    Result := False;
  end;
end;

{$ENDIF}

function DateTimeToDateTimeStamp(ADateTime: TDateTime): TDateTimeStampEh;
var
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  DecodeDateTime(ADateTime, Year, Month, Day, Hour, Min, Sec, MSec);
  Result.Year := Year;
  Result.Month := Month;
  Result.Day := Day;
  Result.Hour := Hour;
  Result.Minute := Min;
  Result.Second := Sec;
end;

function VarToDateTimeStamp(DateTimeVal: Variant): TDateTimeStampEh;
begin
  if VarIsNull(DateTimeVal)then
  begin
    Result.Year := -1;
    Result.Month := -1;
    Result.Day := -1;
    Result.Hour := -1;
    Result.Minute := -1;
    Result.Second := -1;
  end else
    Result := DateTimeToDateTimeStamp(DateTimeVal);
end;

function DateTimeStrToDate(DateTimeStr: String;
  var DateTimeMaskPos: TDateTimeElementsMaskPosEh; var DateTimeStamp: TDateTimeStampEh): Boolean;
begin
  Result := True;
  with DateTimeMaskPos do
  begin
    if Year.Present
      then DateTimeStamp.Year := StrToWordCheck(Copy(DateTimeStr, Year.Pos, Year.Length))
      else DateTimeStamp.Year := -1;
    if Month.Present
      then DateTimeStamp.Month := StrToWordCheck(Copy(DateTimeStr, Month.Pos, Month.Length))
      else DateTimeStamp.Month := -1;
    if Day.Present
      then DateTimeStamp.Day := StrToWordCheck(Copy(DateTimeStr, Day.Pos, Day.Length))
      else DateTimeStamp.Day := -1;
    if Hour.Present
      then DateTimeStamp.Hour := StrToWordCheck(Copy(DateTimeStr, Hour.Pos, Hour.Length))
      else DateTimeStamp.Hour := -1;
    if Min.Present
      then DateTimeStamp.Minute := StrToWordCheck(Copy(DateTimeStr, Min.Pos, Min.Length))
      else DateTimeStamp.Minute := -1;
    if Sec.Present
      then DateTimeStamp.Second := StrToWordCheck(Copy(DateTimeStr, Sec.Pos, Sec.Length))
      else DateTimeStamp.Second := -1;

    if DateTimeStamp.Year > -1 then
      DateTimeStamp.Year := ExpandYear(DateTimeStamp.Year);
      
    if Year.Present and (DateTimeStamp.Year = -1) then
      Result := False;
    if Month.Present and (DateTimeStamp.Month = -1) then
      Result := False;
    if Day.Present and (DateTimeStamp.Day = -1) then
      Result := False;
    if Hour.Present and (DateTimeStamp.Hour = -1) then
      Result := False;
    if Min.Present and (DateTimeStamp.Minute = -1) then
      Result := False;
    if Sec.Present and (DateTimeStamp.Second = -1) then
      Result := False;
  end;
end;

function DoEncodeDateTime(Year, Month, Day, Hour, Min, Sec: Integer; var Date: TDateTime): Boolean; overload;
var
  ADate, ATime: TDateTime;
  MSec: Word;
begin
  MSec := 0;
  Result := False;
  if (Year < 0) and (Month < 0) and (Day < 0) then
    ADate := 0
  else if (Year <= 0) or (Month <= 0) or (Day <= 0)  then
    Exit
  else if not DoEncodeDate(Year, Month, Day, ADate) then
    Exit;

  if (Hour < 0 ) or (Min < 0) or (Sec < 0) then
    Exit
  else if DoEncodeTime(Hour, Min, Sec, MSec, ATime) then
  begin
    Date := ADate + ATime;
    Result := True;
  end;
end;

function DoEncodeDateTime(DateTimeStamp: TDateTimeStampEh; var Date: TDateTime): Boolean; overload;
begin
  with DateTimeStamp do
    Result := DoEncodeDateTime(Year, Month, Day, Hour, Minute, Second, Date);
end;

function EncodeDateTimeEh(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word): TDateTime;
begin
  if (AYear = 0) and (AMonth = 0) and (ADay = 0) then
    Result := EncodeTime(AHour, AMinute, ASecond, AMilliSecond)
  else
    Result := EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
end;

function DateTimeStampToVarValue(DateTimeStamp: TDateTimeStampEh;
  var DateTimeMaskPos: TDateTimeElementsMaskPosEh; var DateTimeVal: Variant;
  AutoCorrect, RaiseError: Boolean): Boolean;
var
  Y,M,D,H,N,S,MS: Word;
  ADateTime: TDateTime;
begin
  {DecodeDate(0, Y, M, D);  //}Y := 1900; M := 1; D := 1;
  H := 0; N := 0; S := 0; MS := 0;
  with DateTimeStamp do
  begin
    if (Year = -1) and (Month = -1) and (Day = -1) and
       (Hour = -1) and (Minute = -1) and (Second = -1)
    then
    begin
      Result := True;
      DateTimeVal := Null;
      Exit;
    end
  end;

  if AutoCorrect then
  begin
    with DateTimeStamp do
    begin
      CorrectDate(Year, Month, Day);
      CorrectTime(Hour, Minute, Second);
    end;
  end else
  begin
    with DateTimeMaskPos do
    begin
      if not Year.Present and (DateTimeStamp.Year <= 0) then
        DateTimeStamp.Year := 1;
      if not Month.Present and (DateTimeStamp.Month <= 0) then
        DateTimeStamp.Month := 1;
      if not Day.Present and (DateTimeStamp.Day <= 0) then
        DateTimeStamp.Day := 1;
      if not Hour.Present and (DateTimeStamp.Hour < 0) then
        DateTimeStamp.Hour := 0;
      if not Min.Present and (DateTimeStamp.Minute < 0) then
        DateTimeStamp.Minute := 0;
      if not Sec.Present and (DateTimeStamp.Second < 0) then
        DateTimeStamp.Second := 0;
    end;
  end;

  if DoEncodeDateTime(DateTimeStamp, ADateTime) then
  begin
    if not VarIsNull(DateTimeVal) then
      DecodeDateTime(DateTimeVal, Y, M, D, H, N, S, MS);
    with DateTimeMaskPos do
    begin
      if Year.Present and (DateTimeStamp.Year > 0) then
        Y := DateTimeStamp.Year;
      if Month.Present and (DateTimeStamp.Month > 0) then
        M := DateTimeStamp.Month;
      if Day.Present and (DateTimeStamp.Day > 0) then
        D := DateTimeStamp.Day;
      if Hour.Present and (DateTimeStamp.Hour >= 0) then
        H := DateTimeStamp.Hour;
      if Min.Present and (DateTimeStamp.Minute >= 0) then
        N := DateTimeStamp.Minute;
      if Sec.Present and (DateTimeStamp.Second >= 0) then
        S := DateTimeStamp.Second;
      DateTimeVal := EncodeDateTimeEh(Y, M, D, H, N, S, MS);
      Result := True;
    end;
  end else
  begin
    Result := False;
    DateTimeVal := Null;
  end;
end;

function DateTimeEditFormatToDisplayFormat(EditFormat: String): String;
var
  i: Integer;
  EscChar, InQuote: Boolean;
  C: Char;
begin
  Result := '';
  EscChar := False;
  InQuote := False;
  for i := 1 to Length(EditFormat) do
  begin
    C := NlsUpperCase(EditFormat[i])[1];
    if CharInSetEh(C, ['D', 'M', 'Y', 'H', 'N', 'S', '/', ':']) and not EscChar then
    begin
      if InQuote then
      begin
        Result := Result + '''';
        InQuote := False;
      end;
      Result := Result + C;
      EscChar := False;
    end else if (C = '\') and not EscChar then
      EscChar := True
    else
    begin
      if not InQuote then
      begin
        Result := Result + '''';
        InQuote := True;
      end;
      if C = '''' then
        Result := Result + ''''''
      else
        Result := Result + EditFormat[i];
      EscChar := False;
    end;
  end;
  if InQuote then
    Result := Result + '''';
end;

function RemoveNonFormatDateTimeText(EditFormat: String): String;
var
  i: Integer;
  EscChar: Boolean;
  C: Char;
begin
  Result := '';
  EscChar := False;
  for i := 1 to Length(EditFormat) do
  begin
    C := NlsUpperCase(EditFormat[i])[1];
    if CharInSetEh(C, ['D', 'M', 'Y', 'H', 'N', 'S', '/', ':']) and not EscChar then
    begin
      Result := Result + C;
      EscChar := False;
    end else if (C = '\') and not EscChar then
      EscChar := True
    else
    begin
      Result := Result + ' ';
      EscChar := False;
    end;
  end;
end;

constructor TCustomDBDateTimeEditEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  UpdateFourDigitYear;
  UpdateMask;
end;

destructor TCustomDBDateTimeEditEh.Destroy;
begin
  FreeAndNil(FDropDownCalendar);
  inherited Destroy;
end;

procedure TCustomDBDateTimeEditEh.ButtonDown(IsDownButton: Boolean);
begin
  if (EditButton.Style in [ebsUpDownEh, ebsAltUpDownEh]) then
  begin
    if IsMasked and not ReadOnly and FDataLink.Edit then
      IncrementItemAtCurPos(not IsDownButton)
  end else
    inherited ButtonDown(IsDownButton);
end;

procedure TCustomDBDateTimeEditEh.Change;
begin
  if not FInternalTextSetting then
    UpdateValueFromText;
  inherited Change;
end;

procedure TCustomDBDateTimeEditEh.DropDown;
var P: TPoint;
  AAlignment: TDropDownAlign;
begin
  inherited DropDown;
  if not FCalendarVisible then
  begin
    if Assigned(FOnDropDown) then FOnDropDown(Self);
    if Value = Null
      then TPopupMonthCalendarEh(DropDownCalendar).Date := TDate(Date)
      else TPopupMonthCalendarEh(DropDownCalendar).Date := TDate(Value);
    //P := ClientToScreen(Point(0,Height));
    if inherited UseRightToLeftAlignment
      then AAlignment := daRight
      else AAlignment := daLeft;
    P := AlignDropDownWindow(Self, DropDownCalendar, AAlignment);
    SetWindowPos(DropDownCalendar.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    DropDownCalendar.Visible := True;
    FCalendarVisible := True;
    FDroppedDown := True;
  end; // else
//    CloseUp(False);
end;

procedure TCustomDBDateTimeEditEh.CloseUp(Accept: Boolean);
var
  DateTimeStamp: TDateTimeStampEh;
  ADate: TDateTime;
  AValue: Variant;
begin
  if FCalendarVisible then
  begin
    FCalendarVisible := False;
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if (GetFocus = DropDownCalendar.Handle) or
      (GetParent(GetFocus) = DropDownCalendar.Handle) then
      SetFocus;
    SetWindowPos(DropDownCalendar.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FCalendarVisible := False;
    DropDownCalendar.Visible := False;
    FDroppedDown := False;
    inherited CloseUp(Accept);
//    PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(FEditButtonControlList[0].EditButtonControl), 0);
    PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(FEditButtonControlList[0].EditButtonControl.Tag), 0);
    if Accept and not ReadOnly and FDataLink.Edit {and (Kind = dtkDateEh)} then
    begin
      AValue := FValue;
      ADate := TDateTime(TPopupMonthCalendarEh(DropDownCalendar).Date);
      if not VarIsNull(AValue) then
        ReplaceTime(ADate, AValue);
      DateTimeStamp := DateTimeToDateTimeStamp(ADate);
      DateTimeStampToVarValue(DateTimeStamp, FDateTimeMaskPos, AValue, True, False);
      InternalSetValue(AValue);
      if FFocused then SelectAll;
      /////Modified := True;
    end;
    if Assigned(FOnCloseUp) then FOnCloseUp(Self, Accept);
  end;
end;

procedure TCustomDBDateTimeEditEh.ValidateEdit;
var S: String;
  V: Variant;
  DateTimeStamp: TDateTimeStampEh;
begin
  if FEditValidating then Exit;
  FEditValidating := True;
  try
    inherited ValidateEdit;
    if not IsMasked then Exit;
    S := Text;
    V := FValue;
    DateTimeStrToDate(S, FDateTimeMaskPos, DateTimeStamp);
    DateTimeStampToVarValue(DateTimeStamp, FDateTimeMaskPos, V, True, False);
    FValue := V;
    if V = Null
      then InternalSetControlText('')
      else InternalSetControlText(FormatDateTime(DateTimeFormat, V));
  finally
    FEditValidating := False;
  end;
end;

function TCustomDBDateTimeEditEh.GetVariantValue: Variant;
begin
  Result := FValue;
end;

function TCustomDBDateTimeEditEh.GetDropDownCalendar: TWinControl;
begin
  if FDropDownCalendar = nil then
  begin
    FDropDownCalendar := TPopupMonthCalendarEh.Create(Self);
    FDropDownCalendar.Visible := False;
    FDropDownCalendar.Parent := Self;
    ShowWindow(FDropDownCalendar.Handle, SW_HIDE); //For Delphi 5 design time
  end;
  Result := FDropDownCalendar;
end;

procedure TCustomDBDateTimeEditEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if IsMasked then
    if (Key in [VK_DOWN, VK_UP]) and (Shift = []) and not ReadOnly then
    begin
      if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);
      if Key = 0 then Exit;
      CheckInplaceEditHolderKeyDown(Key, Shift);
      if Key = 0 then Exit;
      if FDataLink.Edit then IncrementItemAtCurPos(Key = VK_UP);
      /////Modified := True;
    end else if (Key in [VK_LEFT, VK_RIGHT]) and (Shift = []) and (SelLength > 1) then
    begin
      if Assigned(OnKeyDown) then OnKeyDown(Self, Key, Shift);
      if Key = 0 then Exit;
      CheckInplaceEditHolderKeyDown(Key, Shift);
      if Key = 0 then Exit;
      if Key = VK_LEFT then SetCursor(SelStart)
      else SetCursor(SelStart + SelLength - 1);
    end;
  inherited KeyDown(Key, Shift);
end;

procedure TCustomDBDateTimeEditEh.KeyPress(var Key: Char);
var SStart, SLen, NewPos: Integer;
begin
  if FCalendarVisible and CharInSetEh(Key, [#13, #27]) then
  begin
    CloseUp(Key = #13);
    Key := #0;
  end;
  inherited KeyPress(Key);
  if IsMasked and ((Key = DateSeparator) or (Key = TimeSeparator)) then
  begin
    SStart := SelStart + 1;
    NewPos := Pos(Key, Copy(Text, SStart, 255));
    if NewPos = 0 then NewPos := 1
    else Inc(NewPos, SStart + 1);
    GetFormatElementAtPos(Text, NewPos, SLen, FFourDigitYear);
    SetSel(NewPos - 1, NewPos + SLen - 1);
    Key := #0;
  end;
end;

procedure TCustomDBDateTimeEditEh.UpdateFourDigitYear;
var AFourDigitYear: Boolean;
begin
  AFourDigitYear := (Pos('YYYY', NlsUpperCase(ShortDateFormat)) > 0) or
    (Pos('YYY', NlsUpperCase(ShortDateFormat)) > 0);
  if AFourDigitYear <> FFourDigitYear then
  begin
    FFourDigitYear := AFourDigitYear;
    UpdateMask;
  end;
end;

procedure TCustomDBDateTimeEditEh.CMCancelMode(var Message: TCMCancelMode);
  function CheckActiveListChilds: Boolean;
  var i: Integer;
  begin
    Result := False;
    if FDropDownCalendar <> nil then
      for i := 0 to DropDownCalendar.ControlCount - 1 do
        if DropDownCalendar.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;
begin
  inherited;
  if (Message.Sender <> Self) and (Message.Sender <> FDropDownCalendar) and
    not ContainsControl(Message.Sender) and not CheckActiveListChilds then
    CloseUp(False);
end;

procedure TCustomDBDateTimeEditEh.CMEnter(var Message: TCMEnter);
begin
  UpdateFourDigitYear;
  inherited;
end;

procedure TCustomDBDateTimeEditEh.WMKillFocus(var Message: TWMKillFocus);
begin
  if FCalendarVisible and not
    ((Message.FocusedWnd = DropDownCalendar.Handle) or
    (GetParent(Message.FocusedWnd) = DropDownCalendar.Handle)
    ) then
    CloseUp(False);
  inherited;
end;

procedure TCustomDBDateTimeEditEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
//  if FCalendarVisible then Message.Result := Message.Result or DLGC_WANTALLKEYS;
end;

procedure TCustomDBDateTimeEditEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) and FCalendarVisible then
  begin
    //CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TCustomDBDateTimeEditEh.WndProc(var Message: TMessage);
begin
  if FCalendarVisible then
  begin
    case Message.Msg of
      wm_KeyDown, wm_SysKeyDown, wm_Char:
{$IFDEF CIL}
        with TWMKey.Create(Message) do
{$ELSE}
        with TWMKey(Message) do
{$ENDIF}
        begin
          if (CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT {, VK_RETURN, VK_ESCAPE}]) or
            ((CharCode in [VK_HOME, VK_END]) and (ssCtrl in KeyDataToShiftState(KeyData))) or
            ((CharCode in [VK_LEFT, VK_RIGHT])) then
          begin
            SendMessage(DropDownCalendar.Handle, Msg, Message.WParam, Message.LParam);
            Exit;
          end;
        end;
    end;
  end;
  inherited WndProc(Message);
end;

procedure TCustomDBDateTimeEditEh.DataChanged;
begin
  if FDataLink.Field <> nil then
  begin
    (*if (FAlignment <> FDataLink.Field.Alignment) and not PersistentProps['Alignment'] then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
      Invalidate;
    end;*)
    if FAlignment <> FDataLink.Field.Alignment then Invalidate;
    InternalSetValue(FDataLink.Field.Value);
    {if FDataLink.Editing and FDataLink.FModified then
      Modified := True;}
  end
  else if DataIndepended then
  begin
    //FAlignment := taLeftJustify;
    //if csDesigning in ComponentState then
    // EditText := Name else
    InternalSetValue(FDataLink.DataIndependentValue);
  end else
  begin
    //FAlignment := taLeftJustify;
    //if csDesigning in ComponentState then
    //  EditText := Name else
    InternalSetValue(Null);
  end;
  Modified := False;
end;

procedure TCustomDBDateTimeEditEh.InternalSetControlText(AText: String);
begin
  if FInternalTextSetting then Exit;
  FInternalTextSetting := True;
  try
    inherited InternalSetText(AText);
  finally
    FInternalTextSetting := False;
  end;
end;

procedure TCustomDBDateTimeEditEh.InternalSetText(AText: String);
var
  DateTimeStamp: TDateTimeStampEh;
  AValue: Variant;
begin
  AValue := FValue;
  if IsMasked then
  begin
    DateTimeStrToDate(AText, FDateTimeMaskPos, DateTimeStamp);
    if not DateTimeStampToVarValue(DateTimeStamp, FDateTimeMaskPos, AValue, False, True) then
      raise Exception.Create('Invalid datetime: "' + AText +'"');
  end else
    AValue := StrToDateTime(AText);
  FValue := AValue;
  InternalSetControlText(AText);
end;

procedure TCustomDBDateTimeEditEh.InternalSetValue(AValue: Variant);
begin
  //if VarEquals(FValue,AValue) then Exit;

  if AValue = Null then
  begin
    InternalSetControlText('');
    FValue := Null;
  end else
  begin
    FValue := VarAsType(AValue, varDate);
    if IsMasked
      then InternalSetControlText(FormatDateTime(DateTimeFormat, FValue))
      else InternalSetControlText(DateTimeToStr(FValue));
  end;
end;

procedure TCustomDBDateTimeEditEh.IncrementItemAtCurPos(IsIncrease: Boolean);
var
  SStart, SLen: Integer;
  CleanFormat: String;
begin
  SStart := SelStart + 1;
  SLen := SelLength;
  CleanFormat := RemoveNonFormatDateTimeText(EditFormat);
  InternalSetControlText(IncrementStrDateAtPos(Text, CleanFormat, IsIncrease, SStart, SLen));
//  UpdateValueFromText;
  Change;
  SetCursor(SStart - 1);
  SelLength := SLen;
end;

procedure TCustomDBDateTimeEditEh.UpdateValueFromText;
var
  s: String;
  DateTimeStamp: TDateTimeStampEh;
  DateTimeVal: TDateTime;
begin
  s := Text;
  try
    if IsMasked then
    begin
      DateTimeStrToDate(S, FDateTimeMaskPos, DateTimeStamp);
      DateTimeStampToVarValue(DateTimeStamp, FDateTimeMaskPos, FValue, False, False);
    end else if TryStrToDateTime(S, DateTimeVal) then
      FValue := DateTimeVal
    else
      FValue := Null
  except
    on EConvertError do FValue := Null;
  end;
  UpdateImageIndex;
end;

procedure TCustomDBDateTimeEditEh.UpdateMask;
begin
  if Kind = dtkDateEh then
    FEditFormat := DefDateFormat(FFourDigitYear)
  else if Kind = dtkTimeEh then
    FEditFormat := DefTimeFormat
  else if Kind = dtkDateTimeEh then
    FEditFormat := DefDateFormat(FFourDigitYear) + ' ' + DefTimeFormat;

  if FEditFormat <> '' then
  begin
    FDateTimeFormat := DateTimeEditFormatToDisplayFormat(FEditFormat);
    SetControlEditMask(EditFormatToEditMask(EditFormat, FDateTimeMaskPos));
  end else
  begin
    FDateTimeFormat := '';
    SetControlEditMask('');
  end;
end;

function TCustomDBDateTimeEditEh.DateTimeFormat: String;
begin
  Result := FDateTimeFormat;
end;

procedure TCustomDBDateTimeEditEh.InternalUpdatePostData;
var
  v, fv: Variant;
  DateTimeStamp: TDateTimeStampEh;
begin
  v := GetVariantValue;
  if (FDataLink.Field <> nil)
    then fv := FDataLink.Field.Value
    else fv := FDataLink.DataIndependentValue;

  if IsMasked then
  begin
    DateTimeStamp := VarToDateTimeStamp(v);
    DateTimeStampToVarValue(DateTimeStamp, FDateTimeMaskPos, fv, True, False);
  end else
    fv := StrToDateTime(Text);

{  if (FDataLink.Field <> nil) and (v <> Null) then
    if Kind = dtkDateEh
      then FDataLink.SetValue(v + Frac(FDataLink.Field.AsDateTime))
      else FDataLink.SetValue(v + Integer(Trunc(FDataLink.Field.AsDateTime)))
  else}
    FDataLink.SetValue(fv);
end;

function TCustomDBDateTimeEditEh.CreateEditButton: TEditButtonEh;
begin
  Result := TVisibleEditButtonEh.Create(Self);
end;

procedure TCustomDBDateTimeEditEh.EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FCalendarVisible and (GetCaptureControl = Sender) and
    (Sender = FEditButtonControlList[0].EditButtonControl) then
  begin
    ListPos := DropDownCalendar.ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y)));
    if PtInRect(DropDownCalendar.ClientRect, ListPos) then
    begin
      TControl(Sender).Perform(WM_CANCELMODE, 0, 0);
      MousePos := PointToSmallPoint(ListPos);
      MousePos.y := 0; //To avoid activation of the year control
      SendMessage(DropDownCalendar.Handle, WM_LBUTTONDOWN, 0, SmallPointToInteger(MousePos));
    end;
  end;
end;

function TCustomDBDateTimeEditEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result and (Shift = []) and not ReadOnly and IsMasked and FDataLink.Edit then
  begin
    IncrementItemAtCurPos(False);
    Result := True;
  end;
end;

function TCustomDBDateTimeEditEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result and (Shift = []) and not ReadOnly and IsMasked and FDataLink.Edit then
  begin
    IncrementItemAtCurPos(True);
    Result := True;
  end;
end;

procedure TCustomDBDateTimeEditEh.CMMouseWheel(var Message: TCMMouseWheel);
begin
  if FCalendarVisible then
{$IFDEF CIL}
    with Message.OriginalMessage do
{$ELSE}
    with TMessage(Message) do
{$ENDIF}
      if FDropDownCalendar.Perform(CM_MOUSEWHEEL, WParam, LParam) <> 0 then
      begin
        Exit;
        Result := 1;
      end;
  inherited;
end;

function TCustomDBDateTimeEditEh.GetDisplayTextForPaintCopy: String;
begin
  if (csDesigning in ComponentState) and not (FDataLink.Active) then
    Result := Name
  else if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
  begin
    if not FDataLink.Field.IsNull then
      if IsMasked
        then Result := FormatDateTime(DateTimeFormat, FDataLink.Field.AsDateTime)
        else Result := DateTimeToStr(FDataLink.Field.AsDateTime)
    else
      Result := '';
  end else
    Result := EditText;
end;

procedure TCustomDBDateTimeEditEh.FilterMRUItem(AText: String; var Accept: Boolean);
var
  Bot: String;
  i, p: Integer;
begin
  p := Length(Text);
  for i := Length(Text) downto 1 do
    if (Text[i] = ' ') or (Text[i] = DateSeparator)
      then Dec(p)
      else Break;
  Bot := Copy(Text, 1, p);
  Accept := (NlsCompareText(Copy(AText, 1, Length(Bot)), Bot) = 0);
end;

function TCustomDBDateTimeEditEh.IsEditFormatStored: Boolean;
begin
  Result := (Kind = dtkCustomEh);
end;

function TCustomDBDateTimeEditEh.IsKindStored: Boolean;
begin
  Result := (Kind <> dtkCustomEh);
end;

procedure TCustomDBDateTimeEditEh.SetEditFormat(const Value: String);
begin
  FKind := dtkCustomEh;
  if Value <> FEditFormat then
  begin
    FEditFormat := Value;
    UpdateMask;
    DataChange(nil);
  end;
end;

procedure TCustomDBDateTimeEditEh.SetKind(const Value: TDateTimeKindEh);
begin
  if Value <> FKind then
  begin
    FKind := Value;
    UpdateMask;
    DataChange(nil);
  end;
end;

procedure TCustomDBDateTimeEditEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('EditFormat', ReadEditFormat, WriteEditFormat, IsEditFormatStored);
end;

procedure TCustomDBDateTimeEditEh.ReadEditFormat(Reader: TReader);
begin
  EditFormat := Reader.ReadString;
end;

procedure TCustomDBDateTimeEditEh.WriteEditFormat(Writer: TWriter);
begin
  Writer.WriteString(EditFormat);
end;

{ TDropDownBoxEh }

procedure TDropDownBoxEh.Assign(Source: TPersistent);
begin
  if Source is TDropDownBoxEh then
  begin
    Align := TDropDownBoxEh(Source).Align;
    Rows := TDropDownBoxEh(Source).Rows;
    Width := TDropDownBoxEh(Source).Width;
    Sizable := TDropDownBoxEh(Source).Sizable;
  end else
    inherited Assign(Source);
end;

{ TCustomDBComboBoxEh }

constructor TCustomDBComboBoxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TStringList.Create;
  TStringList(FItems).OnChange := ItemsChanged;
  FKeyItems := TStringListEh.Create;
  TStringListEh(FKeyItems).CaseSensitive := True;
  TStringList(FKeyItems).OnChange := KeyItemsChanged;
  FVarValue := Null;
  FDropDownBox := CreateDropDownBox;
  FDropDownBox.Rows := 7;
end;

destructor TCustomDBComboBoxEh.Destroy;
begin
  FreeAndNil(FDropDownBox);
  FreeAndNil(FKeyItems);
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TCustomDBComboBoxEh.ButtonDown(IsDownButton: Boolean);
begin
  if (EditButton.Style in [ebsUpDownEh, ebsAltUpDownEh]) then
  begin
    if EditCanModify then
      SelectNextValue(not IsDownButton)
  end else
    inherited ButtonDown(IsDownButton);
end;

function TCustomDBComboBoxEh.CreateEditButton: TEditButtonEh;
begin
  Result := TVisibleEditButtonEh.Create(Self);
end;

function TCustomDBComboBoxEh.ConvertDataText(const Value: String): String;
var Index: Integer;
begin
  if TextListIndepended then
    Result := Value
  else
  begin
    if FKeyBased
      then Index := KeyItems.IndexOf(Value)
      else Index := Items.IndexOf(Value);
    if (Index >= 0) and (Index < Items.Count)
      then Result := Items.Strings[Index]
      else Result := '';
  end;
end;

function TCustomDBComboBoxEh.CreateDropDownBox: TDropDownBoxEh;
begin
  Result := TDropDownBoxEh.Create;
  Result.Rows := 7;
end;

function TCustomDBComboBoxEh.DefaultAlignment: TAlignment;
begin
  if FKeyBased
    then Result := taLeftJustify
    else Result := inherited DefaultAlignment;
end;

function TCustomDBComboBoxEh.GetVariantValue: Variant;
begin
  if FKeyBased
    then Result := FVarValue
    else Result := inherited GetVariantValue;
end;

function TCustomDBComboBoxEh.IsValidChar(InputChar: Char): Boolean;
begin
  if FKeyBased
    then Result := True
    else Result := inherited IsValidChar(InputChar);
end;

function TCustomDBComboBoxEh.LocateStr(Str: String; PartialKey: Boolean): Boolean;
  function LocateItem: Integer;
  var i: Integer;
    s: string;
  begin
    Result := -1;
    for i := 0 to FItemsCount - 1 do
    begin
      s := Items[i];
      if PartialKey then Delete(s, Length(Str) + 1, MaxInt);
      if NlsCompareText(s, Str) = 0 then
      begin
        Result := i;
        Break;
      end;
    end;
  end;
var Index: Integer;
  OldIndex: Integer;
begin
  Result := False;
  OldIndex := ItemIndex;
  if not EditCanModify then Exit;
  try
    Index := LocateItem;
    if Index >= 0 then
    begin
      InternalSetItemIndex(Index);
      SelStart := Length(Text);
      SelLength := Length(Str) - SelStart;
    end
    else if not FKeyBased then
      InternalSetItemIndex(-1);
    if OldIndex <> Index then Result := True;
  except
    { If you attempt to search for a string larger than what the field
      can hold, and exception will be raised.  Just trap it and
      reset the SearchText back to the old value. }
    InternalSetItemIndex(OldIndex);
  end;
end;

function TCustomDBComboBoxEh.TextListIndepended: Boolean;
begin
  Result := not (FKeyBased {or (Style in [csDropDownList..csOwnerDrawVariable])});
end;

procedure TCustomDBComboBoxEh.DataChanged;
begin
  if FDataLink.Field <> nil then
  begin
    (*if (FAlignment <> FDataLink.Field.Alignment) and not PersistentProps['Alignment'] then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
    end;
    if not FKeyBased then
      EditMask := FDataLink.Field.EditMask;*)
    if FAlignment <> FDataLink.Field.Alignment then Invalidate;
    if not (evEditMaskEh in FAssignedValues) then
      SetControlEditMask(FDataLink.Field.EditMask);
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) and not FKeyBased
        then
        MaxLength := FDataLink.Field.Size
    end;
    if (FFocused and FDataLink.CanModify) or FKeyBased then
      InternalSetValue(FDataLink.Field.Text)
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      {if FDataLink.Editing and FDataLink.FModified then
        Modified := True;}
    end;
  end
  else if DataIndepended then
  begin
    //FAlignment := taLeftJustify;
    //EditMask := '';
    if not (evEditMaskEh in FAssignedValues) then
      SetControlEditMask('');
    if FKeyBased
      then InternalSetValue(FDataLink.DataIndependentValue)
      else EditText := VarToStr(FDataLink.DataIndependentValue);
  end else
  begin
    //FAlignment := taLeftJustify;
    //EditMask := '';
    //if csDesigning in ComponentState then
    //  EditText := Name else
    if not (evEditMaskEh in FAssignedValues) then
      SetControlEditMask('');
    EditText := '';
  end;
  Modified := False;
end;

procedure TCustomDBComboBoxEh.DropDown;
  function GetItemsMaxWidth: Integer;
  var
    i, w: Integer;
  begin
    Result := 0;
    if FCanvas = nil then
    begin
      FCanvas := TControlCanvas.Create;
      FCanvas.Control := Self;
    end;
    FCanvas.Handle := GetDC(0);
    FCanvas.Font := Font;
    for i := 0 to FItemsCount - 1 do
    begin
      w := FCanvas.TextWidth(Items[i]);
      if w > Result then Result := w;
    end;
    ReleaseDC(0, FCanvas.Handle);
    FCanvas.Handle := 0;
    Inc(Result, 5);
    if Images <> nil then Inc(Result, Images.Width + 4);
  end;
var
  P: TPoint;
  ADropDownAlign: TDropDownAlign;
begin
  if not FListVisible then
  begin
    inherited DropDown;
    if Assigned(FOnDropDown) then FOnDropDown(Self);
    with TPopupListboxEh(PopupListbox) do
    begin
      GetItemsList;
      Color := Self.Color;
      Font := Self.Font;
      ImageList := Self.Images;
      ItemHeight := GetTextHeight;
      if (Images <> nil) and (EditImage.UseImageHeight) and (ItemHeight < Images.Height + 1) then
        ItemHeight := Images.Height;
{$IFDEF EH_LIB_6}
      ExtItems := Self.Items;
      Count := ExtItems.Count;
{$ELSE}
      Items := Self.Items;
{$ENDIF}
      ItemIndex := Self.ItemIndex;
      RowCount := DropDownBox.Rows;
      if (FDropDownBox.Width = -1) then ClientWidth := GetItemsMaxWidth
      else if FDropDownBox.Width > 0 then Width := FDropDownBox.Width
      else Width := Self.Width;
      if (Width < Self.Width) then Width := Self.Width;
      if Items.Count < RowCount then RowCount := Items.Count;
    end;
//    P := ClientToScreen(Point(0,Height));
    ADropDownAlign := FDropDownBox.Align;
    if inherited UseRightToLeftAlignment then
      if ADropDownAlign = daLeft then
        ADropDownAlign := daRight
      else if ADropDownAlign = daRight then
        ADropDownAlign := daLeft;
    P := AlignDropDownWindow(Self, PopupListbox, ADropDownAlign);
    SetWindowPos(PopupListbox.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    PopupListbox.Visible := True; //commment for Tab key
    TPopupListboxEh(PopupListbox).SizeGrip.Visible := FDropDownBox.Sizable;
    FListVisible := True;
    TPopupListboxEh(PopupListbox).SizeGripResized := False;
    FDroppedDown := True;
  end; // else
//    CloseUp(False);
end;

procedure TCustomDBComboBoxEh.CloseUp(Accept: Boolean);
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(PopupListbox.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    PopupListbox.Visible := False;
    if TPopupListboxEh(PopupListbox).SizeGripResized then
    begin
      DropDownBox.Rows := TPopupListboxEh(PopupListbox).RowCount;
      DropDownBox.Width := TPopupListboxEh(PopupListbox).Width;
    end;
    if (GetFocus = PopupListbox.Handle) then
      SetFocus;
    FListVisible := False;
    inherited CloseUp(Accept);
    FDroppedDown := False;
    if Assigned(FOnClosingUp) then
      FOnClosingUp(Self, Accept);
    if Accept and not ReadOnly and FDataLink.Edit then
    begin
      InternalSetItemIndex(TPopupListboxEh(PopupListbox).ItemIndex);
      if FFocused then SelectAll;
      //////Modified := True;
    end;
    if Assigned(FOnCloseUp) then
      FOnCloseUp(Self, Accept);
  end;
end;

procedure TCustomDBComboBoxEh.UpdateControlReadOnly;
begin
  SetControlReadOnly(not FDataLink.Editing or ReadOnly or FKeyBased);
end;

function TCustomDBComboBoxEh.GetPopupListbox: TWinControl;
begin
  if FPopupListbox = nil then
  begin
    if FPopupListboxClass <> nil
      then FPopupListbox := FPopupListboxClass.Create(Self)
      else FPopupListbox := TPopupListboxEh.Create(Self);
    FPopupListbox.Visible := False;
    TPopupListboxEh(FPopupListbox).Ctl3D := True;
    FPopupListbox.Parent := Self; // Already set parent in TPopupListboxEh.CreateWnd
    ShowWindow(FPopupListbox.Handle, SW_HIDE); //For Delphi 5 design time
    TPopupListboxEh(FPopupListbox).OnMouseUp := ListMouseUp;
    TPopupListboxEh(FPopupListbox).OnGetImageIndex := PopupListboxGetImageIndex;
  end;
  Result := FPopupListbox;
end;

procedure TCustomDBComboBoxEh.PopupListboxGetImageIndex(Sender: TObject; ItemIndex: Integer; var ImageIndex: Integer);
begin
  if Assigned(OnGetItemImageIndex) then
    OnGetItemImageIndex(Self, ItemIndex, ImageIndex);
end;

procedure TCustomDBComboBoxEh.ListMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FPopupListbox.ClientRect, Point(X, Y)));
end;

procedure TCustomDBComboBoxEh.InternalSetItemIndex(const Value: Integer);
begin
  if FItemIndex <> Value then
  begin
    GetItemsList;
    if (Value >= 0) and (Value < FItemsCount) then
    begin
      FItemIndex := Value;
      if FKeyBased then
        FVarValue := KeyItems.Strings[FItemIndex];
    end else
    begin
      FItemIndex := -1;
      FVarValue := Null;
    end;
    UpdateImageIndex;
    if FListVisible then TPopupListboxEh(PopupListbox).ItemIndex := FItemIndex;
    if FItemIndex >= 0 then
      //inherited InternalSetText(Items.Strings[FItemIndex])
      EditText := Items.Strings[FItemIndex]
    else inherited InternalSetText('');
  end;
end;

procedure TCustomDBComboBoxEh.InternalSetText(AText: String);
var Index: Integer;
begin
  if FKeyBased then
  begin
    Index := Items.IndexOf(AText);
    if (Index >= 0) and (Index < FItemsCount) then
    begin
      FItemIndex := Index;
      UpdateImageIndex;
      if FListVisible then TPopupListboxEh(PopupListbox).ItemIndex := FItemIndex;
      FVarValue := KeyItems.Strings[Index];
      inherited InternalSetText(AText);
    end
  end else
  begin
    inherited InternalSetText(AText);
    UpdateItemIndex;
  end;
end;

procedure TCustomDBComboBoxEh.InternalSetValue(AValue: Variant);
begin
  if FKeyBased then
  begin
    FVarValue := AValue;
    if FVarValue = Null then
    begin
      inherited InternalSetText('');
      FItemIndex := -1;
    end else
    begin
      FItemIndex := KeyItems.IndexOf(VarToStr(AValue));
      if (FItemIndex >= 0) and (FItemIndex < FItemsCount)
        then inherited InternalSetText(Items.Strings[FItemIndex])
        else inherited InternalSetText('');
    end;
    UpdateImageIndex;
    if FListVisible then TPopupListboxEh(PopupListbox).ItemIndex := FItemIndex;
  end else
  begin
    inherited InternalSetValue(AValue);
    UpdateItemIndex;
  end;
end;

procedure TCustomDBComboBoxEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if ((Key = VK_UP) or (Key = VK_DOWN)) and (not WordWrap or (SelLength = Length(Text))) then
    {if ssAlt in Shift then
    begin
      if FListVisible then CloseUp(True) else DropDown;
      Key := 0;
    end else}
    if not ReadOnly and EditCanModify and not FListVisible then
    begin
      SelectNextValue(Key = VK_UP);
      Key := 0;
    end;
  if (Key = VK_DELETE) and FKeyBased and
    ((Assigned(Field) and not Field.Required) or DataIndepended) and
    not ReadOnly and EditCanModify then
    InternalSetValue(Null);
end;

procedure TCustomDBComboBoxEh.KeyPress(var Key: Char);
begin
  if FListVisible and CharInSetEh(Key, [#13, #27]) then
  begin
    CloseUp(Key = #13);
    Key := #0;
  end;
  inherited KeyPress(Key);
  case Key of
    #8: //VK_BACK
      if FKeyBased and not ReadOnly then
      begin
        ProcessSearchStr(Key);
        Key := #0;
      end;
    {#13: //VK_RETURN
    begin
      Key := #0;
      FDataLink.UpdateRecord;
      SelectAll;
    end;}
    #32..High(Char):
      begin
        if DropDownBox.AutoDrop and not FListVisible then DropDown;
        if FKeyBased and not ReadOnly then
        begin
          ProcessSearchStr(GetCompleteKeyPress);
          Key := #0;
        end;
      end;
  end;
end;

procedure TCustomDBComboBoxEh.EditButtonClick(Sender: TObject);
begin
  inherited EditButtonClick(Sender);
end;

procedure TCustomDBComboBoxEh.EditButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if Sender = FEditButtonControlList[0].EditButtonControl then
    TraceMouseMoveForPopupListbox(Sender, Shift, X, Y);
end;

procedure TCustomDBComboBoxEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and FKeyBased and not PtInRect(ButtonRect, Point(X, Y)) and
    ButtonEnabled and not FDroppedDown and not (ssDouble in Shift) then
  begin
    if not FFocused then SetFocus;
    FNoClickCloseUp := True;
    DropDown;
  end;
end;

procedure TCustomDBComboBoxEh.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if TraceMouseMoveForPopupListbox(Self, Shift, X, Y) then
    Exit;
  inherited MouseMove(Shift, X, Y);
end;

procedure TCustomDBComboBoxEh.Click;
begin
  inherited Click;
  if FKeyBased and ButtonEnabled and FDroppedDown and not FNoClickCloseUp then
    CloseUp(False);
  FNoClickCloseUp := False;
end;

function TCustomDBComboBoxEh.TraceMouseMoveForPopupListbox(Sender: TObject;
  Shift: TShiftState; X, Y: Integer): Boolean;
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  Result := False;
  if FListVisible and (GetCaptureControl = Sender) then
  begin
    ListPos := PopupListbox.ScreenToClient(TControl(Sender).ClientToScreen(Point(X, Y)));
    if PtInRect(PopupListbox.ClientRect, ListPos) then
    begin
      TControl(Sender).Perform(WM_CANCELMODE, 0, 0);
      MousePos := PointToSmallPoint(ListPos);
      SendMessage(PopupListbox.Handle, WM_LBUTTONDOWN, 0, SmallPointToInteger(MousePos));
      Result := True;
    end;
  end;
end;

function TCustomDBComboBoxEh.ProcessSearchStr(Str: String): Boolean;
var
  S, SearchText: string;
  OldSelLenght: Integer;
begin
  Result := False;
  if DataIndepended or (FDataLink.Field <> nil) then
    if EditCanModify then
    begin
      if (Length(Str) = 1) and (Str[1] = #8) then
      begin
        if Length(Text) = SelLength then
        begin
          SelStart := MAXINT;
          SelLength := -1;
        end else
        begin
          OldSelLenght := Abs(SelLength);
          SelStart := MAXINT;
          SelLength := -OldSelLenght - 1;
        end
      end else
      begin
        SearchText := Copy(Text, 1, SelStart);
        S := SearchText + Str;
        GetItemsList;
        Result := LocateStr(S, True);
      end;
    end;
end;

procedure TCustomDBComboBoxEh.ResetMaxLength;
begin
  if (MaxLength > 0) then
    if FKeyBased then MaxLength := 0
    else inherited ResetMaxLength;
end;

procedure TCustomDBComboBoxEh.SetVariantValue(const VariantValue: Variant);
//var Index:Integer;
begin
{  if FKeyBased then
  begin
    Index := KeyItems.IndexOf(VarToStr(VariantValue));
    if (Index >= 0) and (Index < KeyItems.Count) then
      inherited SetVariantValue(Items.Strings[Index])
    else if VariantValue = Null then
      SetItemIndex(-1);
  end else}
  inherited SetVariantValue(VariantValue);
end;

procedure TCustomDBComboBoxEh.SetItemIndex(const Value: Integer);
begin
  if (csDesigning in ComponentState) and not DataIndepended then Exit;
  if not DataIndepended then DataSource.DataSet.Edit;
  InternalSetItemIndex(Value);
  try
    UpdateData;
  except
    FDataLink.Reset;
    raise;
  end;
end;

procedure TCustomDBComboBoxEh.SetItems(const Value: TStrings);
begin
  FItems.Assign(Value);
end;

procedure TCustomDBComboBoxEh.SetKeyItems(const Value: TStrings);
begin
  FKeyItems.Assign(Value);
end;

procedure TCustomDBComboBoxEh.ItemsChanged(Sender: TObject);
begin
  UpdateItems;
  UpdateItemIndex;
  ResetMaxLength;
  //DataChange(nil);
end;

procedure TCustomDBComboBoxEh.KeyItemsChanged(Sender: TObject);
begin
  UpdateItems;
  UpdateItemIndex;
  ResetMaxLength;
  DataChange(nil);
end;

function Min(A, B: Integer): Integer;
begin
  if A > B then Result := B
  else Result := A;
end;

procedure TCustomDBComboBoxEh.UpdateItems;
begin
  FItemsCount := Items.Count;
  FKeyBased := False;
  if KeyItems.Count > 0 then
  begin
    FKeyBased := True;
    FItemsCount := Min(FItemsCount, KeyItems.Count);
    EditText := '';
  end;
  UpdateControlReadOnly;
end;

procedure TCustomDBComboBoxEh.UpdateItemIndex;
begin
  FItemIndex := Items.IndexOf(EditText);
  if FListVisible then TPopupListboxEh(PopupListbox).ItemIndex := FItemIndex;
  UpdateImageIndex;
end;

function TCustomDBComboBoxEh.DefaultImageIndex: Integer;
begin
  Result := FDefaultItemIndex;
end;

procedure TCustomDBComboBoxEh.UpdateImageIndex;
begin
  FDefaultItemIndex := ItemIndex;
  if Assigned(OnGetItemImageIndex) then
    OnGetItemImageIndex(Self, ItemIndex, FDefaultItemIndex);
  inherited UpdateImageIndex;
end;

procedure TCustomDBComboBoxEh.WndProc(var Message: TMessage);
var
  ShiftState: TShiftState;
begin
  if FListVisible then
  begin
    case Message.Msg of
      wm_KeyDown, wm_SysKeyDown, wm_Char:
{$IFDEF CIL}
        with TWMKey.Create(Message) do
{$ELSE}
        with TWMKey(Message) do
{$ENDIF}
        begin
          ShiftState := KeyDataToShiftState(KeyData);
          if GetEditButtonByShortCut(ShortCut(CharCode, ShiftState)) = nil then
            if (CharCode in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT])
              or ((CharCode in [VK_HOME, VK_END]) and (ssCtrl in KeyDataToShiftState(KeyData)))
            {or ((CharCode in [VK_LEFT, VK_RIGHT]) )}then
            begin
              SendMessage(PopupListbox.Handle, Msg, Message.WParam, Message.LParam);
              Exit;
            end;
        end;
    end;
  end;
  inherited WndProc(Message);
end;

{procedure TCustomDBComboBoxEh.SetComboBoxStyle(const Value: TComboBoxStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    DataChange(nil);
  end;
end;}

procedure TCustomDBComboBoxEh.CMCancelMode(var Message: TCMCancelMode);
  function CheckDataListChilds: Boolean;
  var i: Integer;
  begin
    Result := False;
    if PopupListbox <> nil then
      for i := 0 to PopupListbox.ControlCount - 1 do
        if PopupListbox.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;
begin
  inherited;
  if (Message.Sender <> Self) and not ContainsControl(Message.Sender) and
    (Message.Sender <> PopupListbox) and not CheckDataListChilds
  then
    CloseUp(False);
end;

procedure TCustomDBComboBoxEh.DefaultHandler(var Message);
var
  WinTMessage: TMessage;
begin
  WinTMessage := UnwrapMessageEh(Message);
{$IFDEF CIL}
  with TWMMouse.Create(WinTMessage) do
{$ELSE}
  with TWMMouse(Message) do
{$ENDIF}
    case Msg of
      WM_LBUTTONDBLCLK, WM_LBUTTONDOWN, WM_LBUTTONUP,
        WM_MBUTTONDBLCLK, WM_MBUTTONDOWN, WM_MBUTTONUP,
        WM_RBUTTONDBLCLK, WM_RBUTTONDOWN, WM_RBUTTONUP:
        if FKeyBased then
        begin
          if Msg = WM_RBUTTONUP then
            Perform(WM_CONTEXTMENU, Handle,
              SmallPointToInteger(PointToSmallPoint(ClientToScreen(Point(XPos, YPos)))) );
          Exit;
        end;
    end;
  inherited DefaultHandler(Message);
end;


procedure TCustomDBComboBoxEh.SelectNextValue(IsPrior: Boolean);
var OldItemIndex: Integer;
begin
  OldItemIndex := ItemIndex;
  if not EditCanModify then Exit;
  if IsPrior then
  begin
    if ItemIndex > 0 then
      InternalSetItemIndex(ItemIndex - 1)
    else if ItemIndex <> 0 then
      InternalSetItemIndex(FItemsCount - 1)
  end else if ItemIndex < FItemsCount - 1 then
    InternalSetItemIndex(ItemIndex + 1);
  if OldItemIndex <> ItemIndex then
  begin
    ///////Modified := True;
    SelectAll;
  end;
end;

procedure TCustomDBComboBoxEh.WMChar(var Message: TWMChar);
var OldSelStart: Integer;
begin
  inherited;
  if Message.CharCode = 0 then Exit;
  if not FKeyBased and not (Message.CharCode = VK_DELETE) and
    not (ssCtrl in KeyDataToShiftState(Message.KeyData)) then
    if not ((SelStart = Length(Text)) and (SelLength = 0)) or (Message.CharCode = VK_BACK) then
    begin
      OldSelStart := SelStart;
      GetItemsList;
      if LocateStr(Text, False) then
      begin
        SelStart := Length(Text);
        SelLength := OldSelStart - SelStart;
      end;
    end else
      ProcessSearchStr('');
end;

procedure TCustomDBComboBoxEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
//  if FListVisible then Message.Result := Message.Result or DLGC_WANTALLKEYS;
end;

procedure TCustomDBComboBoxEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) and FListVisible then
  begin
    //CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TCustomDBComboBoxEh.WMKillFocus(var Message: TWMKillFocus);
begin
  if FListVisible and not (Message.FocusedWnd = PopupListbox.Handle) then
    CloseUp(False);
  inherited;
end;

procedure TCustomDBComboBoxEh.WMPaste(var Message: TMessage);
begin
  if not FKeyBased then
    inherited
  else if Clipboard.HasFormat(CF_TEXT) then
    ///////Modified := ProcessSearchStr(Clipboard.AsText) or Modified;
    ProcessSearchStr(Clipboard.AsText);
end;

procedure TCustomDBComboBoxEh.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if FKeyBased then Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else inherited;
end;

procedure TCustomDBComboBoxEh.Change;
begin
  inherited Change;
  //???if not FKeyBased then
  UpdateItemIndex;
end;

procedure TCustomDBComboBoxEh.InternalUpdatePostData;
begin
  if DataIndepended and not FKeyBased
    then FDataLink.SetText(EditText)
    else FDataLink.SetText(VarToStr(Value));
end;

procedure TCustomDBComboBoxEh.UpdateData;
var RecheckInList: Boolean;
begin
  if Assigned(FOnNotInList) {and Focused} then
  begin
    RecheckInList := False;
    if ItemIndex = -1 then
    begin
      FOnNotInList(Self, EditText, RecheckInList);
      {if RecheckInList and (ItemIndex <> -1) then
        SetKeyValue(FKeyField.Value)}
    end;
  end;
  inherited UpdateData;
end;

function TCustomDBComboBoxEh.GetImages: TCustomImageList;
begin
  Result := EditImage.Images;
end;

procedure TCustomDBComboBoxEh.SetImages(const Value: TCustomImageList);
begin
  EditImage.Images := Value;
  EditImage.Visible := True;
  //if EditImage.Images <> nil then EditImage.Visible := True
  //else EditImage.Visible := False;
end;

procedure TCustomDBComboBoxEh.SetDropDownBox(const Value: TDropDownBoxEh);
begin
  FDropDownBox.Assign(Value);
end;

procedure TCustomDBComboBoxEh.CMMouseWheel(var Message: TCMMouseWheel);
begin
  if FListVisible then
{$IFDEF CIL}
    with Message.OriginalMessage do
{$ELSE}
    with TMessage(Message) do
{$ENDIF}
      if FPopupListbox.Perform(CM_MOUSEWHEEL, WParam, LParam) <> 0 then
      begin
        Exit;
        Result := 1;
      end;
  inherited;
end;

function TCustomDBComboBoxEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result and (Shift = []) and not ReadOnly and FDataLink.Edit then
  begin
    SelectNextValue(False);
    Result := True;
  end;
end;

function TCustomDBComboBoxEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result and (Shift = []) and not ReadOnly and FDataLink.Edit then
  begin
    SelectNextValue(True);
    Result := True;
  end;
end;

procedure TCustomDBComboBoxEh.Clear;
begin
  if FKeyBased
    then Value := Null
    else inherited Clear;
end;

function TCustomDBComboBoxEh.GetDisplayTextForPaintCopy: String;
var
  Index: Integer;
begin
  if (csDesigning in ComponentState) and not (FDataLink.Active) then
    Result := Name
  else if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
  begin
    if FKeyBased then
    begin
      Index := KeyItems.IndexOf(FDataLink.Field.Text);
      if (Index >= 0) and (Index < FItemsCount) then
        Result := Items.Strings[Index];
    end else
      Result := FDataLink.Field.DisplayText;
    case CharCase of
      ecUpperCase: Result := NlsUpperCase(Result);
      ecLowerCase: Result := NlsLowerCase(Result);
    end;
  end else
    Result := EditText;
end;

procedure TCustomDBComboBoxEh.GetItemsList;
begin
  if Items.Count = 0 then
    if Assigned(OnGetItemsList) then
      OnGetItemsList(Self);
end;

{ TCustomDBNumberEditEh }

function IsValidFloat(const Value: string; var RetValue: Extended): Boolean;
var
  I: Integer;
  Buffer: array[0..63] of Char;
{$IFDEF CIL}
  DValue: Double;
{$ENDIF}
begin
  Result := False;
  for I := 1 to Length(Value) do
    if not ((Value[I] = DecimalSeparator) or CharInSetEh(Value[I], [ '-', '+', '0'..'9', 'e', 'E'])) then
      Exit;
  if (Value = '+') or (Value = '-') then
  begin
    RetValue := 0;
    Result := True;
  end else
{$IFDEF CIL}
  begin
    DValue := RetValue;
    Result := TryStrToFloat(Value, DValue);
    RetValue := DValue;
  end;
{$ELSE}
    Result := TextToFloat(StrPLCopy(Buffer, Value,
      SizeOf(Buffer) - 1), RetValue, fvExtended);
{$ENDIF}
end;

function FormatFloatStr(const S: string; Thousands: Boolean): string;
var
  I, MaxSym, MinSym, Group: Integer;
  IsSign: Boolean;
begin
  Result := '';
  MaxSym := Length(S);
  IsSign := (MaxSym > 0) and CharInSetEh(S[1], ['-', '+']);
  if IsSign then MinSym := 2
  else MinSym := 1;
  I := Pos(DecimalSeparator, S);
  if I > 0 then MaxSym := I - 1;
  I := Pos('E', NlsUpperCase(S));
  if I > 0 then MaxSym := Min(I - 1, MaxSym);
  Result := Copy(S, MaxSym + 1, MaxInt);
  Group := 0;
  for I := MaxSym downto MinSym do
  begin
    Result := S[I] + Result;
    Inc(Group);
    if (Group = 3) and Thousands and (I > MinSym) then
    begin
      Group := 0;
      Result := ThousandSeparator + Result;
    end;
  end;
  if IsSign then Result := S[1] + Result;
end;

function CurrencyEditFormat: String;
var i: Integer;
begin
  Result := ',#.';
  for i := 1 to CurrencyDecimals do
    Result := Result + '0';
end;

constructor TCustomDBNumberEditEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //ComponentState := ComponentState + [csDesigning];
  ControlStyle := ControlStyle - [csSetCaption];
  MaxLength := 0;
  FDecimalPlaces := 2;
  FIncrement := 1.0;
  { forces update }
  DataChange(nil);
end;

destructor TCustomDBNumberEditEh.Destroy;
begin
  inherited Destroy;
end;

function TCustomDBNumberEditEh.IsValidChar(Key: Char): Boolean;
var
  S: string;
  SelStart, SelStop, DecPos: Integer;
  RetValue: Extended;
begin
  Result := False;
  S := EditText;
  GetSel(SelStart, SelStop);
  {System.}Delete(S, SelStart + 1, SelStop - SelStart);
  {System.}Insert(Key, S, SelStart + 1);
  S := TextToValText(S);
  DecPos := Pos(DecimalSeparator, S);
  if (DecPos > 0) then
  begin
    SelStart := Pos('E', UpperCase(S));
    if (SelStart > DecPos) then DecPos := SelStart - DecPos
    else DecPos := Length(S) - DecPos;
    if DecPos > Integer(FDecimalPlaces) then Exit;
  end;
  if S  = '' then
    Result := True
  else
  begin
    Result := IsValidFloat(S, RetValue);
    if Result and (FMinValue >= 0) and (FMaxValue > 0) and (RetValue < 0) then
      Result := False;
  end;    
end;

procedure TCustomDBNumberEditEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if not ReadOnly and ((Key = VK_UP) or (Key = VK_DOWN)) then
  begin
    IncrementValue(Key = VK_UP);
    Key := 0;
  end;
end;

procedure TCustomDBNumberEditEh.KeyPress(var Key: Char);
begin
  if FCalculatorVisible and CharInSetEh(Key, [#13, #27]) then
  begin
    CloseUp(Key = #13);
    Key := #0;
  end;
  if (Key = #8) and (SelStart > 0) and (Text[SelStart] = ThousandSeparator) then
  begin
    SelStart := SelStart - 1;
    Key := #0;
  end;
  inherited KeyPress(Key);
  if CharInSetEh(Key, ['.', ',']) then Key := Copy(DecimalSeparator, 1, 1)[1];
  if (Key >= #32) and not IsValidChar(Key) then
  begin
    Key := #0;
  end
  else if Key = #27 then
  begin
    Reset;
    Key := #0;
  end;
end;

procedure TCustomDBNumberEditEh.SetDecimalPlaces(Value: Cardinal);
begin
  if FDecimalPlaces <> Value then
  begin
    FDecimalPlaces := Value;
    DataChange(nil);
    Invalidate;
  end;
end;

function TCustomDBNumberEditEh.FormatDisplayText(Value: Extended): string;
begin
  if DisplayFormat <> '' then
    Result := FormatFloat(DisplayFormat, Value)
  else if Currency then
    Result := CurrToStrF(Value, ffCurrency, CurrencyDecimals)
  else
    Result := FloatToStr(Value);
end;

function TCustomDBNumberEditEh.GetDisplayText: string;
begin
  if FValue = Null then Result := ''
  else Result := FormatDisplayText(FValue);
end;

function TCustomDBNumberEditEh.GetVariantValue: Variant;
begin
  //if Modified then UpdateValueFromText;
  Result := FValue;
end;

{procedure TCustomDBNumberEditEh.Clear;
begin
  Text := '';
end;}

procedure TCustomDBNumberEditEh.DataChanged;
begin
  if (DisplayFormat = '') and Currency then FEditFormat := CurrencyEditFormat
  else FEditFormat := DisplayFormatToEditFormat(DisplayFormat);
  if FDataLink.Field <> nil then
  begin
    if not (evAlignmentEh in inherited AssignedValues) and
      (FAlignment <> FDataLink.Field.Alignment) then
    begin
      FAlignment := FDataLink.Field.Alignment;
      RecreateWnd;
    end;
    InternalSetValue(FDataLink.Field.Value);
  end
  else if DataIndepended then
    InternalSetValue(FDataLink.DataIndependentValue)
  else
  begin
    //inherited InternalSetText('');
    //FValue := Null;
    InternalSetValue(Null);
  end;
  UpdateControlReadOnly;
  Modified := False;
end;

function TCustomDBNumberEditEh.CheckValue(NewValue: Extended): Extended;

  function Degree10(ADegree: Integer): Double;
  var
    i: Integer;
  begin
    Result := 10;
    for i := 1 to ADegree-1 do
      Result := Result*10;
  end;

begin
  Result := NewValue;
  if (FMaxValue <> FMinValue) then
  begin
    if (FMaxValue > FMinValue) then
    begin
      if NewValue < FMinValue then Result := FMinValue
      else if NewValue > FMaxValue then Result := FMaxValue;
    end else
    begin
      if FMaxValue = 0 then
      begin
        if NewValue < FMinValue then Result := FMinValue;
      end else if FMinValue = 0 then
      begin
        if NewValue > FMaxValue then Result := FMaxValue;
      end;
    end;
  end;
  if DecimalPlaces <= 37 then
    if DecimalPlaces > 0
      then Result := Round(Result * Degree10(DecimalPlaces)) / Degree10(DecimalPlaces)
      else Result := Round(Result);
end;

function TCustomDBNumberEditEh.DisplayFormatToEditFormat(const AFormat: string): string;
var i: Integer;
  C, Quote, E: Char;
  EPlus: String;
  ENullCount: Integer;
begin
  Result := '';
  Quote := #0;
  E := #0;
  EPlus := '';
  ENullCount := 0;
  for i := 1 to Length(AFormat) do
  begin
    C := AFormat[i];
    if CharInSetEh(C, ['''', '"']) then
    begin
      if C = Quote then Quote := #0 else Quote := C;
    end else if Quote <> #0 then
      Continue
    else if CharInSetEh(C, ['0', '#', '.', ',']) then
      if (C = '0') and (EPlus = 'E+') then
      begin
        if ENullCount >= 4 then Exit else Inc(ENullCount);
      end else
        Result := Result + C
    else if CharInSetEh(C, ['e', 'E']) then
    begin
      E := 'E';
      EPlus := '';
      Continue;
    end else if (C = '+') and (E = 'E') then
    begin
      E := #0;
      EPlus := 'E+';
      Continue;
    end else if C = ';' then Exit;
    E := #0;
    EPlus := '';
  end;
end;

procedure TCustomDBNumberEditEh.InternalSetControlText(AText: String);
begin
  if FInternalTextSetting then Exit;
  FInternalTextSetting := True;
  try
    inherited InternalSetText(AText);
  finally
    FInternalTextSetting := False;
  end;
end;

procedure TCustomDBNumberEditEh.InternalSetText(AText: String);
begin
  if AText = ''
    then InternalSetValue(Null)
    else InternalSetValue(StrToFloat(TextToValText(AText)));
end;

procedure TCustomDBNumberEditEh.InternalSetValue(AValue: Variant);
begin
  if AValue = Null then
  begin
    InternalSetControlText('');
    FValue := Null;
  end else
  begin
    FValue := VarAsType(AValue, varDouble);
    FDataLink.Modified;
    if FFocused and FDataLink.CanModify then
      ReformatEditText(FormatFloat(FEditFormat, FValue))
      //inherited InternalSetText(FormatFloat(FEditFormat, FValue))
    else
      InternalSetControlText(DisplayText);
  end;
end;

procedure TCustomDBNumberEditEh.UpdateValueFromText;
var
  s: String;
begin
//  if FFocused then ValidateEdit;
  s := TextToValText(EditText);
  if s = '' then
  begin
    FValue := Null;
    InternalSetControlText('');
  end else
  begin
    if (s = '+') or (s = '-')
      then FValue := CheckValue(0) 
      else FValue := CheckValue(StrToFloat(s));
      //if FFocused and FDataLink.CanModify then
      //  ReformatEditText(FormatFloat(FEditFormat, v));
  end;
end;

procedure TCustomDBNumberEditEh.InternalUpdatePostData;
begin
  FDataLink.SetValue(Value);
end;

procedure TCustomDBNumberEditEh.SetMinValue(AValue: Extended);
begin
  if (evMinValueEh in FAssignedValues) and (AValue = FMinValue) then Exit;
  FMinValue := AValue;
  if not (csLoading in ComponentState) and DataIndepended then UpdateData;
  Include(FAssignedValues, evMinValueEh);
end;

procedure TCustomDBNumberEditEh.SetMaxValue(AValue: Extended);
begin
  if (evMaxValueEh in FAssignedValues) and (AValue = FMaxValue)
    then Exit;
  FMaxValue := AValue;
  if not (csLoading in ComponentState) and DataIndepended
    then UpdateData;
  Include(FAssignedValues, evMaxValueEh);
end;

function DelBSpace(const S: string): string;
var
  I, L: Integer;
begin
  L := Length(S);
  I := 1;
  while (I <= L) and (S[I] <= ' ') do Inc(I);
  Result := Copy(S, I, MaxInt);
end;

function DelESpace(const S: string): string;
var
  I: Integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] <= ' ') do Dec(I);
  Result := Copy(S, 1, I);
end;

function DelRSpace(const S: string): string;
begin
  Result := DelBSpace(DelESpace(S));
end;

{function DelChars(const S: string; Chr: Char): string;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do
    if Result[I] = Chr then Delete(Result, I, 1);
end;
}

function ReplaceStr(const S, Srch, Replace: string): string;
var
  I: Integer;
  Source: string;
begin
  Source := S;
  Result := '';
  repeat
    I := Pos(Srch, Source);
    if I > 0 then
    begin
      Result := Result + Copy(Source, 1, I - 1) + Replace;
      Source := Copy(Source, I + Length(Srch), MaxInt);
    end
    else Result := Result + Source;
  until I <= 0;
end;

function TCustomDBNumberEditEh.TextToValText(const AValue: string): string;
begin
  Result := DelRSpace(AValue);
  if DecimalSeparator <> ThousandSeparator then
//    Result := DelChars(Result, ThousandSeparator);
    Result := StringReplace(Result, ThousandSeparator, '', [rfReplaceAll]);
  if (DecimalSeparator <> '.') and (ThousandSeparator <> '.') then
    Result := ReplaceStr(Result, '.', DecimalSeparator);
  if (DecimalSeparator <> ',') and (ThousandSeparator <> ',') then
    Result := ReplaceStr(Result, ',', DecimalSeparator);
  {if Result = '' then Result := '0'
  else if Result = '-' then Result := '';}
end;

procedure TCustomDBNumberEditEh.ReformatEditText(NewText: String);
var
  S: string;
  IsEmpty: Boolean;
  OldLen, SelStart, SelStop: Integer;
begin
  //FFormatting := True;
  try
    S := NewText;
    OldLen := Length(S);
    IsEmpty := (OldLen = 0) or (S = '-');
    if HandleAllocated then GetSel(SelStart, SelStop);
    if not IsEmpty then S := TextToValText(S);
    S := FormatFloatStr(S, Pos(',', FEditFormat) > 0);
    if S <> Text then
    begin
      InternalSetControlText(S);
      if HandleAllocated and (GetFocus = Handle) and not (csDesigning in ComponentState) then
      begin
        Inc(SelStart, Length(S) - OldLen);
        SetCursor(SelStart);
      end;
    end;
  finally
    //FFormatting := False;
  end;
end;

procedure TCustomDBNumberEditEh.Change;
///////var OldModified:Boolean;
begin
  if not FInternalTextSetting then
  begin
    ReformatEditText(inherited Text);
    UpdateValueFromText;
  end;
  inherited Change;
{  if not FFormatting then
  begin
    if FFocused then
    begin
      ////////OldModified := Modified;
      ReformatEditText(inherited Text);
      ////////Modified := OldModified;
    end;
    inherited Change;
  end;}
end;

procedure TCustomDBNumberEditEh.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TAlignment] of DWORD =
  ((ES_LEFT, ES_RIGHT, ES_CENTER), (ES_RIGHT, ES_LEFT, ES_CENTER));
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alignments[UseRightToLeftAlignment, Alignment];
end;

procedure TCustomDBNumberEditEh.WMPaste(var Message: TMessage);
var
  S: string;
begin
  S := EditText;
  try
    inherited;
    UpdateValueFromText;
  except
    EditText := S;
    SelectAll;
    if CanFocus then SetFocus;
  end;
end;

function TCustomDBNumberEditEh.IsIncrementStored: Boolean;
begin
  Result := FIncrement <> 1.0;
end;

procedure TCustomDBNumberEditEh.IncrementValue(IsIncrease: Boolean);
var Sign, ev: Extended;
begin
  if IsIncrease then Sign := 1 else Sign := -1;
  if Increment = 0 then Exit;
  if EditCanModify then
  begin
    if Value = Null
      then ev := Increment
      else ev := Value + Increment * Sign;
    InternalSetValue(CheckValue(ev));
    if FFocused then SelectAll;
  end;
end;

procedure TCustomDBNumberEditEh.ButtonDown(IsDownButton: Boolean);
begin
  if EditButton.Style in [ebsUpDownEh, ebsAltUpDownEh] then
  begin
    if not ReadOnly then IncrementValue(not IsDownButton)
  end else
    inherited ButtonDown(IsDownButton);
end;

function TCustomDBNumberEditEh.GetDisplayFormat: string;
begin
  if evDisplayFormatEh in FAssignedValues then Result := FDisplayFormat
  else Result := DefaultDisplayFormat;
end;

procedure TCustomDBNumberEditEh.SetDisplayFormat(const Value: string);
begin
  if (evDisplayFormatEh in FAssignedValues) and (Value = FDisplayFormat) then Exit;
  FDisplayFormat := Value;
  Include(FAssignedValues, evDisplayFormatEh);
  Invalidate;
  DataChange(nil);
end;

function TCustomDBNumberEditEh.IsDisplayFormatStored: Boolean;
begin
  Result := (evDisplayFormatEh in FAssignedValues);
end;

function TCustomDBNumberEditEh.DefaultDisplayFormat: String;
begin
  if Assigned(Field) then
{$IFDEF EH_LIB_6}
    if Field is TSQLTimeStampField then Result := TSQLTimeStampField(Field).DisplayFormat
    else
{$ENDIF}
{$IFDEF EH_LIB_5}
      if Field is TAggregateField then Result := TAggregateField(Field).DisplayFormat
      else
{$ENDIF}
        if Field is TDateTimeField then Result := TDateTimeField(Field).DisplayFormat
        else if Field is TNumericField then Result := TNumericField(Field).DisplayFormat
        else Result := ''
      else Result := '';
end;

function TCustomDBNumberEditEh.GetCurrency: Boolean;
begin
  if evCurrencyEh in FAssignedValues then Result := FCurrency
  else Result := DefaultCurrency;
end;

function TCustomDBNumberEditEh.IsCurrencyStored: Boolean;
begin
  Result := (evCurrencyEh in FAssignedValues);
end;

procedure TCustomDBNumberEditEh.SetCurrency(const Value: Boolean);
begin
  if (evCurrencyEh in FAssignedValues) and (Value = FCurrency) then Exit;
  FCurrency := Value;
  Include(FAssignedValues, evCurrencyEh);
  Invalidate;
  DataChange(nil);
end;

function TCustomDBNumberEditEh.DefaultCurrency: Boolean;
begin
  if Assigned(Field) then
{$IFDEF EH_LIB_6}
    if Field is TFMTBCDField
      then Result := TFMTBCDField(Field).Currency
    else
{$ENDIF}
{$IFDEF EH_LIB_5}
      if Field is TAggregateField then Result := TAggregateField(Field).Currency
      else
{$ENDIF}
        if Field is TBCDField
          then Result := TBCDField(Field).Currency
        else if Field is TFloatField
          then Result := TFloatField(Field).Currency
          else Result := False
      else Result := False;
end;

function TCustomDBNumberEditEh.IsMaxValueStored: Boolean;
begin
  Result := (evMaxValueEh in FAssignedValues);
end;

function TCustomDBNumberEditEh.IsMinValueStored: Boolean;
begin
  Result := (evMinValueEh in FAssignedValues);
end;

function TCustomDBNumberEditEh.GetMaxValue: Extended;
begin
  if evMaxValueEh in FAssignedValues
    then Result := FMaxValue
    else Result := DefaultMaxValue;
end;

function TCustomDBNumberEditEh.GetMinValue: Extended;
begin
  if evMinValueEh in FAssignedValues
    then Result := FMinValue
    else Result := DefaultMinValue;
end;

function TCustomDBNumberEditEh.DefaultMaxValue: Extended;
begin
  if Assigned(Field) then
    if Field is TIntegerField then Result := TIntegerField(Field).MaxValue
    else if Field is TBCDField then Result := TBCDField(Field).MaxValue
    else if Field is TFloatField then Result := TFloatField(Field).MaxValue
{$IFDEF EH_LIB_6}
    //else if Field is TFMTBCDField then Result := TFMTBCDField(Field).MaxValue
{$ENDIF}
    else Result := 0
  else Result := 0;
end;

function TCustomDBNumberEditEh.DefaultMinValue: Extended;
begin
  if Assigned(Field) then
    if Field is TIntegerField then Result := TIntegerField(Field).MinValue
    else if Field is TBCDField then Result := TBCDField(Field).MinValue
    else if Field is TFloatField then Result := TFloatField(Field).MinValue
{$IFDEF EH_LIB_6}
    //else if Field is TFMTBCDField then Result := TFMTBCDField(Field).MinValue
{$ENDIF}
    else Result := 0
  else Result := 0;
end;

function TCustomDBNumberEditEh.DefaultAlignment: TAlignment;
begin
  if Assigned(Field) then Result := inherited DefaultAlignment
  else Result := taRightJustify;
end;

function TCustomDBNumberEditEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result and (Shift = []) and not ReadOnly and FDataLink.Edit then
  begin
    IncrementValue(False);
    Result := True;
  end;
end;

function TCustomDBNumberEditEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result and (Shift = []) and not ReadOnly and FDataLink.Edit then
  begin
    IncrementValue(True);
    Result := True;
  end;
end;

function TCustomDBNumberEditEh.GetDropDownCalculator: TWinControl;
begin
  if FDropDownCalculator = nil then
  begin
    FDropDownCalculator := TPopupCalculatorEh.Create(Self);
    FDropDownCalculator.Visible := False;
    FDropDownCalculator.Parent := Self;
    if HandleAllocated then
      FDropDownCalculator.HandleNeeded;
//    TPopupCalculatorEh(FDropDownCalculator). := False;
  end;
  Result := FDropDownCalculator;
end;

procedure TCustomDBNumberEditEh.CloseUp(Accept: Boolean);
var
  PopupCalculatorIntf: IPopupCalculatorEh;
begin
  if FCalculatorVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetWindowPos(DropDownCalculator.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FCalculatorVisible := False;
    DropDownCalculator.Visible := False;
    ShowCaret(Handle);
    FDroppedDown := False;
    inherited CloseUp(Accept);
//    PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(FEditButtonControlList[0].EditButtonControl), 0);
    PostMessage(Handle, CM_IGNOREEDITDOWN, Integer(FEditButtonControlList[0].EditButtonControl.Tag), 0);
    if Accept and not ReadOnly and FDataLink.Edit then
    begin
      if Supports(DropDownCalculator, IPopupCalculatorEh, PopupCalculatorIntf) then
        if VarType(PopupCalculatorIntf.Value) in
             [varDouble, varSmallint, varInteger, varSingle, varCurrency]
        then
          InternalSetValue(PopupCalculatorIntf.Value);
      if FFocused then SelectAll;
      /////Modified := True;
    end;
    if Assigned(FOnCloseUp) then FOnCloseUp(Self, Accept);
  end;
end;

procedure TCustomDBNumberEditEh.DropDown;
var
  P: TPoint;
  AAlignment: TDropDownAlign;
  PopupCalculatorIntf: IPopupCalculatorEh;
begin
  inherited DropDown;
  if not FCalculatorVisible then
  begin
    if Assigned(FOnDropDown) then FOnDropDown(Self);
    if Supports(DropDownCalculator, IPopupCalculatorEh, PopupCalculatorIntf) then
    begin
      if VarIsNull(Value)
        then PopupCalculatorIntf.Value := 0
        else PopupCalculatorIntf.Value := Value;
      PopupCalculatorIntf.Flat := Flat;
    end;
    if inherited UseRightToLeftAlignment
      then AAlignment := daRight
      else AAlignment := daLeft;
    P := AlignDropDownWindow(Self, DropDownCalculator, AAlignment);
    SetWindowPos(DropDownCalculator.Handle, HWND_TOP {MOST}, P.X, P.Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    DropDownCalculator.Visible := True;
    FCalculatorVisible := True;
    FDroppedDown := True;
    HideCaret(Handle);
    SelLength := 0;
  end; // else
end;

procedure TCustomDBNumberEditEh.CMCancelMode(var Message: TCMCancelMode);
  function CheckActiveListChilds: Boolean;
  var i: Integer;
  begin
    Result := False;
    if DropDownCalculator <> nil then
      for i := 0 to DropDownCalculator.ControlCount - 1 do
        if DropDownCalculator.Controls[I] = Message.Sender then
        begin
          Result := True;
          Exit;
        end;
  end;
begin
  inherited;
  if (Message.Sender = Self) or
    ((Message.Sender <> DropDownCalculator) and
      not ContainsControl(Message.Sender) and not CheckActiveListChilds)
  then
    CloseUp(False);
end;

procedure TCustomDBNumberEditEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) and FCalculatorVisible then
  begin
    //CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TCustomDBNumberEditEh.WMKillFocus(var Message: TWMKillFocus);
begin
  if FCalculatorVisible and not (Message.FocusedWnd = DropDownCalculator.Handle) then
    CloseUp(False);
  inherited;
end;

procedure TCustomDBNumberEditEh.WndProc(var Message: TMessage);
begin
  if FCalculatorVisible then
  begin
    case Message.Msg of
      wm_KeyDown, wm_SysKeyDown, wm_Char:
{$IFDEF CIL}
        with TWMKey.Create(Message) do
{$ELSE}
        with TWMKey(Message) do
{$ENDIF}
        begin
          if (CharCode in [8, 13]) or ((CharCode >= 32) and (CharCode < 127)) then
          begin
            SendMessage(DropDownCalculator.Handle, Msg, Message.WParam, Message.LParam);
            Exit;
          end;
        end;
    end;
  end;
  inherited WndProc(Message);
end;

procedure TCustomDBNumberEditEh.CMMouseWheel(var Message: TCMMouseWheel);
begin
  if FCalculatorVisible then
{$IFDEF CIL}
    with Message.OriginalMessage do
{$ELSE}
    with TMessage(Message) do
{$ENDIF}
      if FDropDownCalculator.Perform(CM_MOUSEWHEEL, WParam, LParam) <> 0 then
      begin
        Exit;
        Result := 1;
      end;
  inherited;
end;

function TCustomDBNumberEditEh.CreateEditButton: TEditButtonEh;
begin
  Result := TDropDownEditButtonEh.Create(Self);
end;

{ TCustomDBCheckBoxEh }

constructor TCustomDBCheckBoxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;

  if SysLocale.FarEast and (Win32Platform = VER_PLATFORM_WIN32_NT) then
    ImeMode := imDisable;
  Width := 97;
  Height := 17;
  TabStop := True;
  ControlStyle := ControlStyle + [csReplicatable] - [csDoubleClicks];
  FAlignment := taRightJustify;

  FValueCheck := STextTrue;
  FValueUncheck := STextFalse;
  FDataLink := TFieldDataLinkEh.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := InternalUpdateData;

  FState := cbUnchecked;

{ TODO : Check it }
  FDataLink.DataIndependentValue := False;
end;

destructor TCustomDBCheckBoxEh.Destroy;
begin
  FreeAndNil(FDataLink);
//  FDataLink := nil;
  FreeAndNil(FCanvas);
  inherited Destroy;
end;

procedure TCustomDBCheckBoxEh.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

{$IFNDEF CIL}
procedure TCustomDBCheckBoxEh.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := ObjectToIntPtr(FDataLink);
end;
{$ENDIF}

procedure TCustomDBCheckBoxEh.DataChange(Sender: TObject);
begin
  InternalSetState(GetFieldState);
  FModified := False;
{  if FToggleKeyDown then
  begin
    FToggleKeyDown := False;
    Invalidate;
  end;}
end;

function TCustomDBCheckBoxEh.DataIndepended: Boolean;
begin
  Result := FDataLink.DataIndepended;
end;

function TCustomDBCheckBoxEh.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TCustomDBCheckBoxEh.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

function TCustomDBCheckBoxEh.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TCustomDBCheckBoxEh.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TCustomDBCheckBoxEh.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TCustomDBCheckBoxEh.GetFieldState: TCheckBoxState;
var
  Text: string;
begin
  if FDatalink.DataIndepended then
  begin
    Result := cbGrayed;
    if VarEquals(FDatalink.DataIndependentValue, True) then
      Result := cbChecked
    else if VarEquals(FDatalink.DataIndependentValue, False) then
      Result := cbUnchecked;
  end else if FDatalink.Field <> nil then
    if (FDataLink.Field.DataType = ftBoolean) and
            (FValueCheck = STextTrue) and
            (FValueUncheck = STextFalse) then
    begin
      if FDataLink.Field.IsNull then
        Result := cbGrayed
      else if FDataLink.Field.AsBoolean then
        Result := cbChecked
      else
        Result := cbUnchecked
    end else
    begin
      Result := cbGrayed;
      Text := FDataLink.Field.Text;
      if ValueMatch(FValueCheck, Text) then Result := cbChecked else
        if ValueMatch(FValueUncheck, Text) then Result := cbUnchecked;
    end
  else
    Result := cbUnchecked;
end;

function TCustomDBCheckBoxEh.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TCustomDBCheckBoxEh.InternalSetState(Value: TCheckBoxState);
begin
  if FState <> Value then
  begin
    FState := Value;
    if HandleAllocated then
      SendMessage(Handle, BM_SETCHECK, Integer(FState), 0);
    if not ClicksDisabled then
      inherited Click;
    Invalidate;
    FModified := True;
  end;
end;

procedure TCustomDBCheckBoxEh.InternalUpdateData(Sender: TObject);
begin
  UpdateData;
end;

procedure TCustomDBCheckBoxEh.InternalUpdatePostData;
var
  Pos: Integer;
  S: string;
begin
  if FDataLink.DataIndepended then
  begin
    if State = cbGrayed then
      FDataLink.SetValue(Null)
    else if Checked then
      FDataLink.SetValue(True)
    else
      FDataLink.SetValue(False);
  end else
    if State = cbGrayed then
      FDataLink.Field.Clear
    else
      if FDataLink.Field.DataType = ftBoolean then
        FDataLink.Field.AsBoolean := Checked
      else
      begin
        if Checked then S := FValueCheck else S := FValueUncheck;
        Pos := 1;
        FDataLink.Field.Text := ExtractFieldName(S, Pos);
      end;
end;

procedure TCustomDBCheckBoxEh.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      FDataLink.Edit;
    #27:
      FDataLink.Reset;
  end;
end;

procedure TCustomDBCheckBoxEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Char(Key) = ' ') and not FToggleKeyDown then
  begin
    FToggleKeyDown := True;
    Invalidate;
  end;
end;

procedure TCustomDBCheckBoxEh.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if (Char(Key) = ' ') and FToggleKeyDown then
  begin
    FToggleKeyDown := False;
    Toggle;
  end;
end;

procedure TCustomDBCheckBoxEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TCustomDBCheckBoxEh.Paint;
begin
  if csPaintCopy in ControlState
    then DrawState(GetFieldState, False, False, False)
    else DrawState(State, Focused, FMouseAboveControl,
           (FMouseAboveControl and (csClicked in ControlState)) or FToggleKeyDown);
end;

procedure TCustomDBCheckBoxEh.DrawState(AState: TCheckBoxState; AFocused, AMouseAboveControl, ADown: Boolean);
var
  CheckRect, TextRect: TRect;
begin
  if (not UseRightToLeftAlignment and (Alignment = taLeftJustify)) or
     ( UseRightToLeftAlignment and (Alignment = taRightJustify)) then
  begin
    Canvas.Brush.Color := Color;
    CheckRect := AdjustCheckBoxRect(Rect(0,0,Width,Height), taRightJustify, tlCenter);
    TextRect := Rect(0, 0, CheckRect.Left - 5, Height);

    DrawCaptionRect(TextRect, AFocused, AMouseAboveControl, ADown);
    DrawCheckBoxRect(CheckRect, AState, AFocused, AMouseAboveControl, ADown);
  end else
  begin
    Canvas.Brush.Color := Color;
    CheckRect := AdjustCheckBoxRect(Rect(0,0,Width,Height), taLeftJustify, tlCenter);
    TextRect := Rect(CheckRect.Right + 5, 0, Width, Height);

    DrawCaptionRect(TextRect, AFocused, AMouseAboveControl, ADown);
    DrawCheckBoxRect(CheckRect, AState, AFocused, AMouseAboveControl, ADown);
  end;
end;

procedure TCustomDBCheckBoxEh.DrawCheckBoxRect(ARect: TRect; AState: TCheckBoxState; AFocused, AMouseAboveControl, ADown: Boolean);
var
  Active: Boolean;
begin
  Active := AMouseAboveControl or AFocused or AlwaysShowBorder;
  PaintButtonControlEh(Canvas, ARect, Color, bcsCheckboxEh,  Ord(ADown),
    Flat, Active, Enabled or (csDesigning in ComponentState), AState);
end;

procedure TCustomDBCheckBoxEh.DrawCaptionRect(ARect: TRect; AFocused, AMouseAboveControl, ADown: Boolean);
var
  TextSize: TSize;
  VTextMarg, HTextMarg: Integer;
  TextRect: TRect;
  Flags: Integer;
  C: TColor;
  BS: TBrushStyle;
begin
  Canvas.Font := Font;
  Canvas.Brush.Color := Color;
  BS := Canvas.Brush.Style;
  Canvas.Brush.Style := bsClear;
  Flags := DT_CALCRECT + DT_SINGLELINE;
  TextRect := Rect(0,0,0,0);
  DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextRect, Flags);
  TextSize.cx := (TextRect.Right - TextRect.Left);
  TextSize.cy := (TextRect.Bottom - TextRect.Top);
  VTextMarg := Height div 2 - TextSize.cy div 2;
  HTextMarg := ARect.Left;
  TextRect := Rect(HTextMarg, VTextMarg, HTextMarg + TextSize.cx, VTextMarg + TextSize.cy);

  Flags := DT_SINGLELINE;
  if Enabled or (csDesigning in ComponentState) then
    DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextRect, Flags)
  else
  begin
    C := Canvas.Font.Color;
    Canvas.Font.Color := clHighlightText;
    OffsetRect(TextRect, 1, 1);
    DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextRect, Flags);
    OffsetRect(TextRect, -1, -1);
    Canvas.Font.Color := clGrayText;
    DrawTextEh(Canvas.Handle, Caption, Length(Caption), TextRect, Flags);
    Canvas.Font.Color := C;
  end;

  Canvas.Brush.Style := BS;
  InflateRect(TextRect, 1, 1);

  Inc(TextRect.Bottom);
  if TextRect.Left < 0 then TextRect.Left := 0;
  if TextRect.Top < 0 then TextRect.Top := 0;
  if TextRect.Right > Width then TextRect.Right := Width;
  if TextRect.Bottom > Height then TextRect.Bottom := Height;
  if AFocused then
    Windows.DrawFocusRect(Canvas.Handle, TextRect);
end;

{
procedure TCustomDBCheckBoxEh.DrawCaptionRect(ARect: TRect; AFocused, AMouseAboveControl, ADown: Boolean);
var
  TextSize: TSize;
  VTextMarg, HTextMarg: Integer;
  TextRect: TRect;
  tm: TTextMetric;
begin
  Canvas.Font := Font;
  TextSize := Canvas.TextExtent(Caption);
  GetTextMetrics(Canvas.Handle, tm);
  Inc(TextSize.cx, tm.tmOverhang);
  VTextMarg := Height div 2 - TextSize.cy div 2;
  HTextMarg := ARect.Left;
  TextRect := Rect(HTextMarg, VTextMarg, HTextMarg + TextSize.cx, VTextMarg + TextSize.cy);
  Canvas.TextRect(TextRect, HTextMarg, VTextMarg, Caption);
  InflateRect(TextRect, 1, 1);
  Inc(TextRect.Bottom);
  if TextRect.Left < 0 then TextRect.Left := 0;
  if TextRect.Top < 0 then TextRect.Top := 0;
  if TextRect.Right > Width then TextRect.Right := Width;
  if TextRect.Bottom > Height then TextRect.Bottom := Height;
  if AFocused then
    Windows.DrawFocusRect(Canvas.Handle, TextRect);
end;
}

function TCustomDBCheckBoxEh.PostDataEvent: Boolean;
begin
  Result := False;
  FDataPosting := True;
  try
    if Assigned(FOnUpdateData) then FOnUpdateData(Self, Result);
  finally
    FDataPosting := False;
  end;
end;

procedure TCustomDBCheckBoxEh.SetAlignment(const Value: TLeftRight);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TCustomDBCheckBoxEh.SetChecked(Value: Boolean);
begin
  if Value then State := cbChecked else State := cbUnchecked;
end;

procedure TCustomDBCheckBoxEh.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TCustomDBCheckBoxEh.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TCustomDBCheckBoxEh.SetFlat(const Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    RecreateWnd;
  end;
end;

procedure TCustomDBCheckBoxEh.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TCustomDBCheckBoxEh.SetState(const Value: TCheckBoxState);
begin
  if (csDesigning in ComponentState) and not FDataLink.DataIndepended then Exit;
  if not DataIndepended then DataSource.DataSet.Edit;
  InternalSetState(Value);
  if FDataPosting then Exit;
  try
    UpdateData;
  except
    FDataLink.Reset;
    raise;
  end;
end;

procedure TCustomDBCheckBoxEh.SetValueCheck(const Value: string);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

procedure TCustomDBCheckBoxEh.SetValueUncheck(const Value: string);
begin
  FValueUncheck := Value;
  DataChange(Self);
end;

procedure TCustomDBCheckBoxEh.Toggle;
begin
  if FDataLink.Edit then
  begin
    case State of
      cbUnchecked:
        if AllowGrayed
          then InternalSetState(cbGrayed)
          else InternalSetState(cbChecked);
      cbChecked: InternalSetState(cbUnchecked);
      cbGrayed: InternalSetState(cbChecked);
    end;
    FDataLink.Modified;
    Invalidate;
  end;
end;

procedure TCustomDBCheckBoxEh.UpdateData;
begin
  if not PostDataEvent then
    InternalUpdatePostData;
end;

function TCustomDBCheckBoxEh.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

function TCustomDBCheckBoxEh.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while (Pos <= Length(ValueList)) do
    if NlsCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      Result := True;
      Break;
    end;
  if not Result and ((Pos = Length(ValueList) + 1) and (ValueList[Pos-1] = ';')) then
    Result := (Value = '');
end;

procedure TCustomDBCheckBoxEh.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not (csDesigning in ComponentState) and not Focused then
      begin
        FClicksDisabled := True;
        Windows.SetFocus(Handle);
        FClicksDisabled := False;
        if not Focused then Exit;
      end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;

  inherited WndProc(Message);
end;

function TCustomDBCheckBoxEh.GetChecked: Boolean;
begin
  Result := State = cbChecked;
end;

type
  TButtonActionLinkCrack = class(TButtonActionLink);

procedure TCustomDBCheckBoxEh.Click;
begin
  Toggle;
  inherited Changed;
//  inherited Click;
end;

procedure TCustomDBCheckBoxEh.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, BM_SETCHECK, Integer(FState), 0);
end;

function TCustomDBCheckBoxEh.GetControlsAlignment: TAlignment;
begin
  if not UseRightToLeftAlignment then
    Result := taRightJustify
  else
    if FAlignment = taRightJustify then
      Result := taLeftJustify
    else
      Result := taRightJustify;
end;

{
procedure TCustomDBCheckBoxEh.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := Checked;
    end;
end;

function TCustomDBCheckBoxEh.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TButtonActionLink;
end;

function TCustomDBCheckBoxEh.IsCheckedStored: Boolean;
begin
  Result := ( DataIndepended and ((ActionLink = nil) or not TButtonActionLinkCrack(ActionLink).IsCheckedLinked) );
end;
}

procedure TCustomDBCheckBoxEh.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.CMCtl3DChanged(var Message: TMessage);
begin
  RecreateWnd;
end;

procedure TCustomDBCheckBoxEh.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      SetFocus;
      if Focused then Toggle;
      Result := 1;
    end else
      inherited;
end;

procedure TCustomDBCheckBoxEh.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.CNCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode = BN_CLICKED then Toggle;
end;

procedure TCustomDBCheckBoxEh.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseAboveControl := True;
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseAboveControl := False;
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.WMCancelMode(var Message: TWMCancelMode);
var
  ButtonDownInControlState: Boolean;
begin
  ButtonDownInControlState := csLButtonDown in ControlState;
  inherited;
  if csCaptureMouse in ControlStyle then
  begin
    MouseCapture := False;
    if ButtonDownInControlState then
      Perform(WM_LBUTTONUP, 0, Integer($FFFFFFFF));
  end;
end;

function TCustomDBCheckBoxEh.IsStateStored: Boolean;
begin
  Result := (DataIndepended and (State <> cbUnchecked));
end;

procedure TCustomDBCheckBoxEh.SetAlwaysShowBorder(const Value: Boolean);
begin
  if FAlwaysShowBorder <> Value then
  begin
    FAlwaysShowBorder := Value;
    Invalidate;
  end;
end;

procedure TCustomDBCheckBoxEh.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TCustomDBCheckBoxEh.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  if (Message.CharCode = VK_ESCAPE) and Modified then
    Message.Result := 1;
end;

function TCustomDBCheckBoxEh.GetModified: Boolean;
begin
  Result := FModified;
end;

procedure TCustomDBCheckBoxEh.PaintWindow(DC: HDC);
begin
  FCanvas.Lock;
  try
    FCanvas.Handle := DC;
    try
      TControlCanvas(FCanvas).UpdateTextFlags;
      Paint;
    finally
      FCanvas.Handle := 0;
    end;
  finally
    FCanvas.Unlock;
  end;
end;

procedure TCustomDBCheckBoxEh.WMPaint(var Message: TWMPaint);
begin
  ControlState := ControlState + [csCustomPaint];
  inherited;
  ControlState := ControlState - [csCustomPaint];
end;

procedure TCustomDBCheckBoxEh.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
{$IFDEF EH_LIB_7}
  if ThemeServices.ThemesEnabled
    then Message.Result := Perform(CN_CTLCOLORSTATIC, Integer(Message.DC),0)
    else inherited;
{$ELSE}
     inherited;
{$ENDIF}
end;

initialization
  FlatButtonWidth := GetDefaultFlatButtonWidth;
end.
