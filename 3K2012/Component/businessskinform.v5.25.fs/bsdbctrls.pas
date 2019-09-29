{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 5.25                                                }
{                                                                   }
{       Copyright (c) 2000-2006 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsdbctrls;

{$R-,H+,X+}
{$WARNINGS OFF}
{$HINTS OFF}

interface

uses Windows, SysUtils, Messages, Classes, Controls, Forms,
     Graphics, Menus, StdCtrls, ExtCtrls, Mask, Buttons, ComCtrls, Db,
     DBCtrls, bsSkinBoxCtrls, bsSkinCtrls, bsSkinData, bsUtils, bsMessages,
     bsCalc {$IFNDEF VER130}, Variants {$ENDIF};

type
  TbsSkinDBText = class(TbsSkinStdLabel)
  private
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetFieldText: string;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function GetLabelText: string; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetAutoSize(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize default False;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Transparent;
    property ShowHint;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

 { TbsSkinDbPasswordEdit }
  TbsSkinDBPasswordEdit = class(TbsSkinPasswordEdit)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    procedure EditingChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMGotFocus); message CM_EXIT;
    function GetPaintText: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    published
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  { TbsSkinDbEdit }

  TbsSkinDBEdit = class(TbsSkinEdit)
  private
    FDataLink: TFieldDataLink;
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    FFocused: Boolean;
    procedure ActiveChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetTextMargins: TPoint;
    procedure ResetMaxLength;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBURLEdit = class(TbsSkinURLEdit)
  private
    FDataLink: TFieldDataLink;
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    FFocused: Boolean;
    procedure ActiveChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetTextMargins: TPoint;
    procedure ResetMaxLength;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    function EditCanModify: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBSpinEdit = class(TbsSkinSpinEdit)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FCanvas: TControlCanvas;
    FAlignment: TAlignment;
    FFocused: Boolean;
    procedure EditingChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure EditEnter(Sender: TObject); override;
    procedure EditExit(Sender: TObject); override;
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBDateEdit = class(TbsSkinDateEdit)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FAllowNullData: boolean;
    procedure EditingChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMGotFocus); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    published
    property AllowNullData: Boolean read FAllowNullData write FAllowNullData;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBTimeEdit = class(TbsSkinTimeEdit)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    procedure EditingChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMGotFocus); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    published
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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


  TbsSkinDBCalcEdit = class(TbsSkinCalcEdit)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    procedure EditingChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMGotFocus); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBCurrencyEdit = class(TbsSkinCurrencyEdit)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    procedure EditingChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMGotFocus); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBCalcCurrencyEdit = class(TbsSkinCalcCurrencyEdit)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    procedure EditingChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMGotFocus); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBGauge = class(TbsSkinGauge)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    function GetPaintValue: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TbsSkinDBSlider = class(TbsSkinSlider)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMGotFocus); message CM_EXIT;
    function GetSliderValue: Longint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;  

  TbsSkinDBNumericEdit = class(TbsSkinNumericEdit)
  private
    FInDataChange: Boolean;
    FInChange: Boolean;
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    procedure EditingChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Reset; override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMGotFocus); message CM_EXIT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBMemo = class(TbsSkinMemo)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    FPaintControl: TPaintControl;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetAutoDisplay(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
     procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure LoadMemo; virtual;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBMemo2 = class(TbsSkinMemo2)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    FPaintControl: TPaintControl;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetAutoDisplay(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMUndo(var Message: TMessage); message WM_UNDO;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure LoadMemo; virtual;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBCheckRadioBox = class(TbsSkinCheckRadioBox)
  private
    FDataLink: TFieldDataLink;
    FValueCheck: string;
    FValueUncheck: string;
    FInChange, FInDataChange: Boolean;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetFieldState: TCheckBoxState;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValueCheck(const Value: string);
    procedure SetValueUncheck(const Value: string);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
    procedure SetCheckState; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Checked;
    property Field: TField read GetField;
  published
    property Action;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property ValueChecked: string read FValueCheck write SetValueCheck;
    property ValueUnchecked: string read FValueUncheck write SetValueUncheck;
    property Visible;
    property OnClick;
    property OnContextPopup;
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

  TbsSkinDBListBox = class(TbsSkinListBox)
  private
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetItems(Value: TStrings);
  protected
    procedure CheckButtonClick(Sender: TObject);
    procedure ListBoxExit; override;
    procedure ListBoxWProc(var Message: TMessage;
                           var Handled: Boolean); override;
    procedure ListBoxClick; override;
    procedure ListBoxKeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ListBoxKeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D default True;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property Items write SetItems;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
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

  { TbsSkinDBComboBox }

  TbsSkinDBComboBox = class(TbsSkinComboBox)
  private
    FInDataChange: Boolean;
    FInDateSelfChange: Boolean;
    FDataLink: TFieldDataLink;
    procedure DataChange(Sender: TObject);
    function GetComboText: string;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetComboText(const Value: string);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetItems(Value: TStrings);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure EditWindowProcHook(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property Text;
  published
    property Style; {Must be published before Items}
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property Items write SetItems;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TbsSkinDBMRUComboBox = class(TbsSkinDBComboBox)
  public
    procedure AddMRUItem(Value: String);
  end;

  TbsSkinDBRadioGroup = class(TbsSkinCustomRadioGroup)
  private
    FInClick: Boolean;
    FDataLink: TFieldDataLink;
    FValue: string;
    FValues: TStrings;
    FInSetValue: Boolean;
    FOnChange: TNotifyEvent;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetButtonValue(Index: Integer): string;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValue(const Value: string);
    procedure SetItems(Value: TStrings);
    procedure SetValues(Value: TStrings);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    procedure Change; dynamic;
    procedure Click; override;
    procedure KeyPress(var Key: Char); override;
    function CanModify: Boolean; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    property DataLink: TFieldDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property ItemIndex;
    property Value: string read FValue write SetValue;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Items write SetItems;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Values: TStrings read FValues write SetValues;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDock;
    property OnStartDrag;
  end;

  { TbsDBLookupControl }

  TbsDBLookupControl = class;

  TbsDataSourceLink = class(TDataLink)
  private
    FDBLookupControl: TbsDBLookupControl;
  protected
    procedure FocusControl(Field: TFieldRef); override;
    procedure ActiveChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create;
  end;

  TbsListSourceLink = class(TDataLink)
  private
    FDBLookupControl: TbsDBLookupControl;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure LayoutChanged; override;
  public
    constructor Create;
  end;

  TbsDBLookupControl = class(TbsSkinCustomControl)
  private
    FLookupSource: TDataSource;
    FDataLink: TbsDataSourceLink;
    FListLink: TbsListSourceLink;
    FDataFieldName: string;
    FKeyFieldName: string;
    FListFieldName: string;
    FListFieldIndex: Integer;
    FMasterField: TField;
    FDataField: TField;
    FKeyField: TField;
    FListField: TField;
    FListFields: TList;
    FKeyValue: Variant;
    FSearchText: string;
    FLookupMode: Boolean;
    FListActive: Boolean;
    FHasFocus: Boolean;
    FNullValueKey: TShortCut;
    procedure CheckNotCircular;
    procedure CheckNotLookup;
    procedure DataLinkRecordChanged(Field: TField);
    function GetDataSource: TDataSource;
    function GetKeyFieldName: string;
    function GetListSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataFieldName(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetKeyFieldName(const Value: string);
    procedure SetKeyValue(const Value: Variant);
    procedure SetListFieldName(const Value: string);
    procedure SetListSource(Value: TDataSource);
    procedure SetLookupMode(Value: Boolean);
    procedure SetReadOnly(Value: Boolean);
    procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;    
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    function CanModify: Boolean; virtual;
    procedure KeyValueChanged; virtual;
    procedure ListLinkDataChanged; virtual;
    function LocateKey: Boolean; virtual;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure ProcessSearchKey(Key: Char); virtual;
    procedure SelectKeyValue(const Value: Variant); virtual;
    procedure UpdateDataFields; virtual;
    procedure UpdateListFields; virtual;
    property DataField: string read FDataFieldName write SetDataFieldName;
    property DataLink: TbsDataSourceLink read FDataLink;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property HasFocus: Boolean read FHasFocus;
    property KeyField: string read GetKeyFieldName write SetKeyFieldName;
    property KeyValue: Variant read FKeyValue write SetKeyValue;
    property ListActive: Boolean read FListActive;
    property ListField: string read FListFieldName write SetListFieldName;
    property ListFieldIndex: Integer read FListFieldIndex write FListFieldIndex default 0;
    property ListFields: TList read FListFields;
    property ListLink: TbsListSourceLink read FListLink;
    property ListSource: TDataSource read GetListSource write SetListSource;
    property NullValueKey: TShortCut read FNullValueKey write FNullValueKey default 0;
    property ParentColor default False;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property SearchText: string read FSearchText write FSearchText;
    property TabStop default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read FDataField;
  end;

{ TbsSkinDBLookupListBox }

  TbsSkinDBLookupListBox = class(TbsDBLookupControl)
  private
    FStopThumbScroll: Boolean;
    FDefaultItemHeight: Integer;
    FUseSkinItemHeight: Boolean;
    FRecordIndex: Integer;
    FRecordCount: Integer;
    FRowCount: Integer;
    FBorderStyle: TBorderStyle;
    FPopup: Boolean;
    FKeySelected: Boolean;
    FTracking: Boolean;
    FTimerActive: Boolean;
    FLockPosition: Boolean;
    FMousePos: Integer;
    FSelectedItem: string;

    procedure ShowScrollBar;
    procedure HideScrollBar;
    procedure AlignScrollBar;

    procedure SetDefaultItemHeight(Value: Integer);
    function GetKeyIndex: Integer;
    procedure SelectCurrent;
    procedure SelectItemAt(X, Y: Integer);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetRowCount(Value: Integer);
    procedure StopTimer;
    procedure StopTracking;
    procedure TimerScroll;
    procedure UpdateScrollBar;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMTimer(var Message: TMessage); message WM_TIMER;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure OnScrollBarChange(Sender: TObject);
    procedure OnScrollBarUpButtonClick(Sender: TObject);
    procedure OnScrollBarDownButtonClick(Sender: TObject);
  protected
    procedure FramePaint(C: TCanvas);
    procedure WMNCCALCSIZE(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPAINT(var Message: TMessage); message WM_NCPAINT;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyValueChanged; override;
    procedure ListLinkDataChanged; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

    procedure UpdateListFields; override;

    procedure GetSkinData; override;
    function GetItemHeight: Integer;
    function GetBorderHeight: Integer;
    function GetItemWidth: Integer;
  public
    FScrollBar: TbsSkinScrollBar;
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    SItemRect, ActiveItemRect, FocusItemRect: TRect;
    ItemLeftOffset, ItemRightOffset: Integer;
    ItemTextRect: TRect;
    FontColor, ActiveFontColor, FocusFontColor: TColor;
    ScrollBarName: String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property KeyValue;
    property SelectedItem: string read FSelectedItem;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure ChangeSkinData; override;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property KeyField;
    property ListField;
    property ListFieldIndex;
    property ListSource;
    property NullValueKey;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RowCount: Integer read FRowCount write SetRowCount;
    property DefaultItemHeight: Integer read FDefaultItemHeight
                                        write SetDefaultItemHeight;
    property UseSkinItemHeight: Boolean
      read FUseSkinItemHeight write FUseSkinItemHeight;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  { TDBLookupComboBox }

  TbsPopupDataList = class(TbsSkinDBLookupListBox)
  private
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDropDownAlign = (daLeft, daRight, daCenter);

  TbsSkinDBLookupComboBox = class(TbsDBLookupControl)
  private
    FDefaultColor: TColor;
    FMouseIn: Boolean;
    FButtonRect, FItemRect: TRect;
    FDataList: TbsPopupDataList;
    FButtonWidth: Integer;
    FText: string;
    FDropDownRows: Integer;
    FDropDownWidth: Integer;
    FDropDownAlign: TDropDownAlign;
    FListVisible: Boolean;
    FPressed: Boolean;
    FTracking: Boolean;
    FAlignment: TAlignment;
    FLookupMode: Boolean;
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;

    FOnChange: TNotifyEvent;

    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StopTracking;
    procedure TrackButton(X, Y: Integer);
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure WMCancelMode(var Message: TMessage); message WM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;

    function GetListBoxDefaultItemHeight: Integer;
    procedure SetListBoxDefaultItemHeight(Value: Integer);
    function GetListBoxUseSkinFont: Boolean;
    procedure SetListBoxUseSkinFont(Value: Boolean);
    function GetListBoxUseSkinItemHeight: Boolean;
    procedure SetListBoxUseSkinItemHeight(Value: Boolean);

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetDefaultColor(Value: TColor);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyValueChanged; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure UpdateListFields; override;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;

    procedure GetSkinData; override;
  public
    FontName: String;
    FontStyle: TFontStyles;
    FontHeight: Integer;
    SItemRect, ActiveItemRect, FocusItemRect: TRect;
    ItemLeftOffset, ItemRightOffset: Integer;
    ItemTextRect: TRect;
    FontColor, FocusFontColor, ActiveFontColor: TColor;
    ButtonRect,
    ActiveButtonRect,
    DownButtonRect: TRect;
    ListBoxName: String;
    ActiveSkinRect: TRect;
    StretchEffect, ItemStretchEffect, FocusItemStretchEffect: Boolean;
    UnEnabledButtonRect: TRect;
    constructor Create(AOwner: TComponent); override;
    procedure CloseUp(Accept: Boolean); virtual;
    procedure DropDown; virtual;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property KeyValue;
    property ListVisible: Boolean read FListVisible;
    property Text: string read FText;
  published
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownAlign: TDropDownAlign read FDropDownAlign write FDropDownAlign default daLeft;
    property DropDownRows: Integer read FDropDownRows write FDropDownRows default 7;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property DefaultColor: TColor read FDefaultColor write SetDefaultColor;

    property ListBoxDefaultItemHeight: Integer
      read GetListBoxDefaultItemHeight write SetListBoxDefaultItemHeight;

    property ListBoxUseSkinFont: Boolean
      read GetListBoxUseSkinFont write SetListBoxUseSkinFont;

    property ListBoxUseSkinItemHeight: Boolean
      read GetListBoxUseSkinItemHeight write SetListBoxUseSkinItemHeight;

    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property KeyField;
    property ListField;
    property ListFieldIndex;
    property ListSource;
    property NullValueKey;
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
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
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

const
  InitRepeatPause = 400;  { pause before repeat timer (ms) }
  RepeatPause     = 100;  { pause before hint window displays (ms)}
  SpaceSize       =  5;   { size of space between special buttons }

type
  TbsNavButton = class;
  TbsNavDataLink = class;

  TbsNavGlyph = (ngEnabled, ngDisabled);
  TbsNavigateBtn = (nbFirst, nbPrior, nbNext, nbLast,
                  nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh);
  TbsButtonSet = set of TbsNavigateBtn;
  TbsNavButtonStyle = set of (nsAllowTimer, nsFocusRect);

  ENavClick = procedure (Sender: TObject; Button: TbsNavigateBtn) of object;

{ TbsSkinDBNavigator }

  TbsSkinDBNavigator = class (TbsSkinPanel)
  private
    FShowButtonCaption, FShowButtonGraphic: Boolean;
    FSkinMessage: TbsSkinMessage;
    FBtnSkinDataName: String;
    FDataLink: TbsNavDataLink;
    FVisibleButtons: TbsButtonSet;
    FHints: TStrings;
    FDefHints: TStrings;
    ButtonWidth: Integer;
    MinBtnSize: TPoint;
    FOnNavClick: ENavClick;
    FBeforeAction: ENavClick;
    FConfirmDelete: Boolean;
    FAdditionalGlyphs: Boolean;
    procedure SetShowButtonCaption(Value: Boolean);
    procedure SetShowButtonGraphic(Value: Boolean);
    procedure SetAdditionalGlyphs(Value: Boolean);
    procedure SetBtnSkinDataName(Value: String);
    procedure ClickHandler(Sender: TObject);
    function GetDataSource: TDataSource;
    function GetHints: TStrings;
    procedure HintsChanged(Sender: TObject);
    procedure InitButtons;
    procedure InitHints;
    procedure SetDataSource(Value: TDataSource);
    procedure SetHints(Value: TStrings);
    procedure SetSize(var W: Integer; var H: Integer);
    procedure SetVisible(Value: TbsButtonSet);
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
  protected
    Buttons: array[TbsNavigateBtn] of TbsNavButton;
    procedure DataChanged;
    procedure EditingChanged;
    procedure ActiveChanged;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure CalcMinSize(var W, H: Integer);
    procedure SetSkinData(Value: TbsSkinData); override;
  public
    procedure Paint; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure BtnClick(Index: TbsNavigateBtn); virtual;
    procedure ChangeSkinData; override;
  published
    property ShowButtonCaption: Boolean read FShowButtonCaption write SetShowButtonCaption default False;
    property ShowButtonGraphic: Boolean read FShowButtonGraphic write SetShowButtonGraphic default True;
    property AdditionalGlyphs: Boolean
      read FAdditionalGlyphs write SetAdditionalGlyphs;
    property SkinMessage: TbsSkinMessage read FSkinMessage write FSkinMessage;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property VisibleButtons: TbsButtonSet read FVisibleButtons write SetVisible
      default [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete,
        nbEdit, nbPost, nbCancel, nbRefresh];
    property BtnSkinDataName: String read FBtnSkinDataName write SetBtnSkinDataName;
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Hints: TStrings read GetHints write SetHints;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property BeforeAction: ENavClick read FBeforeAction write FBeforeAction;
    property OnClick: ENavClick read FOnNavClick write FOnNavClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TbsNavButton }

  TbsNavButton = class(TbsSkinButton)
  private
    FNavIndex: TbsNavigateBtn;
    FNavStyle: TbsNavButtonStyle;
    FRepeatTimer: TTimer;
    procedure TimerExpired(Sender: TObject);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    procedure GetSkinData; override;
    destructor Destroy; override;
    property NavStyle: TbsNavButtonStyle read FNavStyle write FNavStyle;
    property Index : TbsNavigateBtn read FNavIndex write FNavIndex;
  end;

{ TbsNavDataLink }

  TbsNavDataLink = class(TDataLink)
  private
    FNavigator: TbsSkinDBNavigator;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create(ANav: TbsSkinDBNavigator);
    destructor Destroy; override;
  end;

  { TbsSkinDBImage }

  TbsSkinDBImage = class(TbsSkinPanel)
  private
    FDataLink: TFieldDataLink;
    FPicture: TPicture;
    FBorderStyle: TbsSkinBorderStyle;
    FAutoDisplay: Boolean;
    FStretch: Boolean;
    FCenter: Boolean;
    FPictureLoaded: Boolean;
    FQuickDraw: Boolean;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure PictureChanged(Sender: TObject);
    procedure SetAutoDisplay(Value: Boolean);
    procedure SetCenter(Value: Boolean);
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetPicture(Value: TPicture);
    procedure SetReadOnly(Value: Boolean);
    procedure SetStretch(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMCopy(var Message: TMessage); message WM_COPY;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSize(var Message: TMessage); message WM_SIZE;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    function GetPalette: HPALETTE; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure PaintImage(Cnvs: TCanvas);
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure LoadPicture;
    procedure PasteFromClipboard;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Field: TField read GetField;
    property Picture: TPicture read FPicture write SetPicture;
  published
    property Align;
    property Anchors;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property Center: Boolean read FCenter write SetCenter default True;
    property Color;
    property Constraints;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property QuickDraw: Boolean read FQuickDraw write FQuickDraw default True;
    property ShowHint;
    property Stretch: Boolean read FStretch write SetStretch default False;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TbsSkinDBRichEdit = class(TbsSkinRichEdit)
  private
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    FDataSave: string;
    procedure BeginEditing;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetAutoDisplay(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure LoadMemo; virtual;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoDisplay: Boolean read FAutoDisplay write SetAutoDisplay default True;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WantReturns;
    property WantTabs;
    property WordWrap;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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
    property OnResizeRequest;
    property OnSelectionChange;
    property OnProtectChange;
    property OnSaveClipboard;
    property OnStartDock;
    property OnStartDrag;
  end;


  { TDBCtrlGrid }

  TbsSkinDBCtrlGrid = class;

  TbsDBCtrlGridLink = class(TDataLink)
  private
    FDBCtrlGrid: TbsSkinDBCtrlGrid;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
  public
    constructor Create(DBCtrlGrid: TbsSkinDBCtrlGrid);
  end;

  TbsDBCtrlPanel = class(TbsSkinPanel)
  private
    FDBCtrlGrid: TbsSkinDBCtrlGrid;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure PaintWindow(DC: HDC); override;
  public
    constructor CreateLinked(DBCtrlGrid: TbsSkinDBCtrlGrid);
  end;

  TbsDBCtrlGridOrientation = (bsgoVertical, bsgoHorizontal);
  TbsDBCtrlGridBorder = (bsgbNone, bsgbRaised);
  TbsDBCtrlGridKey = (bsgkNull, bsgkEditMode, bsgkPriorTab, bsgkNextTab, bsgkLeft,
    bsgkRight, bsgkUp, bsgkDown, bsgkScrollUp, bsgkScrollDown, bsgkPageUp, bsgkPageDown,
    bsgkHome, bsgkEnd, bsgkInsert, bsgkAppend, bsgkDelete, bsgkCancel);

  TbsPaintPanelEvent = procedure(DBCtrlGrid: TbsSkinDBCtrlGrid;
    Index: Integer; Cnvs: TCanvas; ClRect: TRect) of object;

  TbsSkinDBCtrlGrid = class(TbsSkinWinControl)
  private
    FScrollBar: TbsSkinScrollBar;
    FDataLink: TbsDBCtrlGridLink;
    FPanel: TbsDBCtrlPanel;
    FCanvas: TCanvas;
    FColCount: Integer;
    FRowCount: Integer;
    FPanelWidth: Integer;
    FPanelHeight: Integer;
    FPanelIndex: Integer;
    FPanelCount: Integer;
    FBitmapCount: Integer;
    FPanelBitmap: HBitmap;
    FSaveBitmap: HBitmap;
    FPanelDC: HDC;
    FOrientation: TbsDBCtrlGridOrientation;
    FAllowInsert: Boolean;
    FAllowDelete: Boolean;
    FShowFocus: Boolean;
    FFocused: Boolean;
    FClicking: Boolean;
    FSelColorChanged: Boolean;
    FScrollBarKind: Integer;
    FSelectedColor: TColor;
    FOnPaintPanel: TbsPaintPanelEvent;
    procedure AdjustScrollBar;
    function AcquireFocus: Boolean;
    function GetFillColor: TColor;
    procedure AdjustSize; reintroduce;
    procedure CreatePanelBitmap;
    procedure DataSetChanged(Reset: Boolean);
    procedure DestroyPanelBitmap;
    procedure DrawPanel(DC: HDC; Index: Integer);
    function FindNext(StartControl: TWinControl; GoForward: Boolean;
     var WrapFlag: Integer): TWinControl;
    function GetDataSource: TDataSource;
    function GetEditMode: Boolean;
    function GetPanelBounds(Index: Integer): TRect;
    function PointInPanel(const P: TSmallPoint): Boolean;
    procedure Reset;
    procedure Scroll(Inc: Integer; ScrollLock: Boolean);
    procedure ScrollMessage(Message: TWMScroll);
    procedure SelectNext(GoForward: Boolean);
    procedure SetColCount(Value: Integer);
    procedure SetDataSource(Value: TDataSource);
    procedure SetEditMode(Value: Boolean);
    procedure SetOrientation(Value: TbsDBCtrlGridOrientation);
    procedure SetPanelHeight(Value: Integer);
    procedure SetPanelIndex(Value: Integer);
    procedure SetPanelWidth(Value: Integer);
    procedure SetRowCount(Value: Integer);
    procedure SetSelectedColor(Value: TColor);
    procedure UpdateDataLinks(Control: TControl; Inserting: Boolean);
    procedure UpdateScrollBar;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSize(var Message: TMessage); message WM_SIZE;
    procedure CMChildKey(var Message: TCMChildKey); message CM_CHILDKEY;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure SBChange(Sender: TObject);
    procedure SBLastChange(Sender: TObject);
    procedure SBUpClick(Sender: TObject);
    procedure SBDownClick(Sender: TObject);
    procedure SBPageUp(Sender: TObject);
    procedure SBPageDown(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function GetChildParent: TComponent; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure PaintPanel(Index: Integer; Cnvs: TCanvas; ClRect: TRect); virtual;
    procedure PaintWindow(DC: HDC); override;
    procedure ReadState(Reader: TReader); override;
    property Panel: TbsDBCtrlPanel read FPanel;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoKey(Key: TbsDBCtrlGridKey);
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    procedure GetTabOrderList(List: TList); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    property Canvas: TCanvas read FCanvas;
    property EditMode: Boolean read GetEditMode write SetEditMode;
    property PanelCount: Integer read FPanelCount;
    property PanelIndex: Integer read FPanelIndex write SetPanelIndex;
    procedure ChangeSkindata; override;
  published
    property Align;
    property AllowDelete: Boolean read FAllowDelete write FAllowDelete default True;
    property AllowInsert: Boolean read FAllowInsert write FAllowInsert default True;
    property Anchors;
    property ColCount: Integer read FColCount write SetColCount default 1;
    property Color;
    property Constraints;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property SkinData;
    property Orientation: TbsDBCtrlGridOrientation read FOrientation write SetOrientation default bsgoVertical;
    property PanelHeight: Integer read FPanelHeight write SetPanelHeight default 72;
    property PanelWidth: Integer read FPanelWidth write SetPanelWidth default 200;
    property ParentColor;                                                                      
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property TabOrder;
    property TabStop default True;
    property RowCount: Integer read FRowCount write SetRowCount default 3;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor
      stored FSelColorChanged default clWindow;
    property ShowFocus: Boolean read FShowFocus write FShowFocus default True;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaintPanel: TbsPaintPanelEvent read FOnPaintPanel write FOnPaintPanel;
    property OnStartDrag;
  end;

implementation

uses Clipbrd, Dialogs, Math, bsConst;

{$R BSDBCTRLS}

{ TbsSkinDBText }

constructor TbsSkinDBText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  AutoSize := False;
  ShowAccelChar := False;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
end;

destructor TbsSkinDBText.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBText.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBText.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBText.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBText.SetAutoSize(Value: Boolean);
begin
  if AutoSize <> Value then
  begin
//    if Value and FDataLink.DataSourceFixed then DatabaseError(SDataSourceFixed);
    inherited SetAutoSize(Value);
  end;
end;

function TbsSkinDBText.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBText.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBText.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBText.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBText.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TbsSkinDBText.GetFieldText: string;
begin
  if FDataLink.Field <> nil then
    Result := FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

procedure TbsSkinDBText.DataChange(Sender: TObject);
begin
  Caption := GetFieldText;
end;

function TbsSkinDBText.GetLabelText: string;
begin
  if csPaintCopy in ControlState then
    Result := GetFieldText else
    Result := Caption;
end;

procedure TbsSkinDBText.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBText.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBText.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TbsSkinDbEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

constructor TbsSkinDbEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TbsSkinDbEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TbsSkinDbEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDbEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDbEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDbEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TbsSkinDbEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

function TbsSkinDbEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TbsSkinDbEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TbsSkinDbEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TbsSkinDbEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TbsSkinDbEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDbEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDbEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDbEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

function TbsSkinDbEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDbEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDbEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDbEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

procedure TbsSkinDbEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAlignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if FFocused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      if FDataLink.Editing and FDataLink.CanModify then
      Modified := True;
    end;
  end else
  begin
    FAlignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
end;

procedure TbsSkinDbEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDbEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TbsSkinDbEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDbEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDbEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDbEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);

  inherited;

  if FDataLink.CanModify
  then
    inherited ReadOnly := False;

  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDbEdit.CMExit(var Message: TCMExit);
begin
  try
    if FDataLink.Editing then FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TbsSkinDbEdit.WMPaint(var Message: TWMPaint);
const
  AlignStyle : array[Boolean, TAlignment] of DWORD =
   ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  AAlignment: TAlignment;
  ExStyle: DWORD;
begin
  AAlignment := FAlignment;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  if ((AAlignment = taLeftJustify) or FFocused) and
    not (csPaintCopy in ControlState) then
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
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      Brush.Style := bsClear;
      if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
      begin
        S := FDataLink.Field.DisplayText;
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end else
        S := EditText;
      if PasswordChar <> #0 then FillChar(S[1], Length(S), PasswordChar);
      Margins := GetTextMargins;
      case AAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := ClientWidth - TextWidth(S) - Margins.X - 1;
      else
        Left := (ClientWidth - TextWidth(S)) div 2;
      end;
      if SysLocale.MiddleEast then UpdateTextFlags;
      TextRect(R, Left, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure TbsSkinDbEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDbEdit.GetTextMargins: TPoint;
begin
  Result.X := 0;
  Result.Y := 0;
end;

function TbsSkinDbEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDbEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

constructor TbsSkinDBMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FPaintControl := TPaintControl.Create(Self, 'EDIT');
end;

destructor TbsSkinDBMemo.Destroy;
begin
  FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBMemo.WMPaint(var Message: TWMPaint);
var
  S: string;
begin
  if not (csPaintCopy in ControlState) then inherited else
  begin
    if FDataLink.Field <> nil then
      if FDataLink.Field.IsBlob then
      begin
        if FAutoDisplay then
          S := AdjustLineBreaks(FDataLink.Field.AsString) else
          S := Format('(%s)', [FDataLink.Field.DisplayLabel]);
      end else
        S := FDataLink.Field.DisplayText;
    SendMessage(FPaintControl.Handle, WM_SETTEXT, 0, Integer(PChar(S)));
    SendMessage(FPaintControl.Handle, WM_ERASEBKGND, Message.DC, 0);
    SendMessage(FPaintControl.Handle, WM_PAINT, Message.DC, 0);
  end;
end;

procedure TbsSkinDBMemo.Loaded;
begin
  inherited Loaded;
//  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBMemo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBMemo.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
      FDataLink.Edit;
  end;
end;

procedure TbsSkinDBMemo.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key := #0;
  end;
end;

procedure TbsSkinDBMemo.Change;
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

function TbsSkinDBMemo.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBMemo.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBMemo.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBMemo.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBMemo.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBMemo.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBMemo.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBMemo.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
  begin
    try
      Lines.Text := FDataLink.Field.AsString;
      FMemoLoaded := True;
    except
      { Memo too large }
      on E:EInvalidOperation do
        Lines.Text := Format('(%s)', [E.Message]);
    end;
    EditingChange(Self);
  end;
end;

procedure TbsSkinDBMemo.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
    begin
      if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
      begin
        FMemoLoaded := False;
        LoadMemo;
      end else
      begin
        Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
        FMemoLoaded := False;
      end;
    end else
    begin
      if FFocused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
        Text := FDataLink.Field.DisplayText;
      FMemoLoaded := True;
    end
  else
  begin
    if csDesigning in ComponentState then Text := Name else Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TbsSkinDBMemo.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

procedure TbsSkinDBMemo.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsString := Text;
end;

procedure TbsSkinDBMemo.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

procedure TbsSkinDBMemo.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TbsSkinDBMemo.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if FDataLink.CanModify then
    inherited ReadOnly := False;

  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBMemo.CMExit(var Message: TCMExit);
begin
  try
    if FDataLink.Editing then FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TbsSkinDBMemo.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TbsSkinDBMemo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TbsSkinDBMemo.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBMemo.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBMemo.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBMemo.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBMemo.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBMemo.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TbsSkinDBCheckRadioBox }

constructor TbsSkinDBCheckRadioBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FInChange := False;
  FInDataChange := False;
  FValueCheck := 'True';
  FValueUncheck := 'False';
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TbsSkinDBCheckRadioBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBCheckRadioBox.SetCheckState;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      inherited;
      if FDataLink.Edit then FDataLink.Modified;
    end;
  FInChange := False;
end;

procedure TbsSkinDBCheckRadioBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBCheckRadioBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

function TbsSkinDBCheckRadioBox.GetFieldState: TCheckBoxState;
var
  Text: string;
begin
  if FDatalink.Field <> nil then
    if FDataLink.Field.IsNull then
      Result := cbGrayed
    else if FDataLink.Field.DataType = ftBoolean then
      if FDataLink.Field.AsBoolean then
        Result := cbChecked
      else
        Result := cbUnchecked
    else
    begin
      Result := cbGrayed;
      Text := FDataLink.Field.Text;
      if ValueMatch(FValueCheck, Text) then Result := cbChecked else
        if ValueMatch(FValueUncheck, Text) then Result := cbUnchecked;
    end
  else
    Result := cbUnchecked;
end;

procedure TbsSkinDBCheckRadioBox.DataChange(Sender: TObject);
var
  State: TCheckBoxState;
begin
  FInDataChange := True;
  if not FInChange
  then
    begin
      State := GetFieldState;
      FChecked := State = cbChecked;
      RePaint;
    end;  
  FInDataChange := False;
end;

procedure TbsSkinDBCheckRadioBox.UpdateData(Sender: TObject);
var
  Pos: Integer;
  S: string;
begin
  if FDataLink.Field.DataType = ftBoolean then
     FDataLink.Field.AsBoolean := Checked
  else
    begin
      if Checked then S := FValueCheck else S := FValueUncheck;
      Pos := 1;
      FDataLink.Field.Text := ExtractFieldName(S, Pos);
    end;
end;

function TbsSkinDBCheckRadioBox.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      Result := True;
      Break;
    end;
end;

function TbsSkinDBCheckRadioBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBCheckRadioBox.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBCheckRadioBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBCheckRadioBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBCheckRadioBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBCheckRadioBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBCheckRadioBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBCheckRadioBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      FDataLink.Edit;
    #27:
      FDataLink.Reset;
  end;
end;

procedure TbsSkinDBCheckRadioBox.SetValueCheck(const Value: string);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

procedure TbsSkinDBCheckRadioBox.SetValueUncheck(const Value: string);
begin
  FValueUncheck := Value;
  DataChange(Self);
end;

procedure TbsSkinDBCheckRadioBox.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TbsSkinDBCheckRadioBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TbsSkinDBCheckRadioBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBCheckRadioBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBCheckRadioBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TbsSkinDBListBox }

constructor TbsSkinDBListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  OnCheckButtonClick := CheckButtonClick;
end;

destructor TbsSkinDBListBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBListBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBListBox.CheckButtonClick;
begin
  if ReadOnly or not FDataLink.CanModify or not ListBox.Focused then Exit;
  if FDataLink.Edit
  then
    FDataLink.Modified;
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
end;

procedure TbsSkinDBListBox.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil
  then
    ItemIndex := Items.IndexOf(FDataLink.Field.Text)
  else
    ItemIndex := -1;
end;

procedure TbsSkinDBListBox.UpdateData(Sender: TObject);
begin
  if ItemIndex >= 0 then
    FDataLink.Field.Text := Items[ItemIndex] else
    FDataLink.Field.Text := '';
end;


procedure TbsSkinDBListBox.ListBoxClick;
begin
  inherited;
  if FDataLink.Edit
  then
    FDataLink.Modified;
end;

function TbsSkinDBListBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBListBox.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBListBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBListBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBListBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBListBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBListBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBListBox.ListBoxKeyDown;
begin
  inherited;
  if Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN] then
    if not FDataLink.Edit then Key := 0;
end;

procedure TbsSkinDBListBox.ListBoxKeyPress;
begin
  inherited;
  case Key of
    #32..#255:
      if not FDataLink.Edit then Key := #0;
    #27:
      FDataLink.Reset;
  end;
end;

type
  TbsListBoxX = class(TbsListBox);

procedure TbsSkinDBListBox.ListBoxWProc(var Message: TMessage;
                                          var Handled: Boolean);
begin
  inherited;
  case Message.Msg of
    WM_LButtonDown:
    if not (csDesigning in ComponentState)
    then
      with TWMLButtonDown(Message) do
      begin
        if not FDataLink.Edit
        then
          begin
            ListBox.SetFocus;
            TbsListBoxX(ListBox).MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
            Handled := False;
          end;
      end;
  end;
end;

procedure TbsSkinDBListBox.ListBoxExit;
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TbsSkinDBListBox.SetItems(Value: TStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

function TbsSkinDBListBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBListBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TbsSkinDBComboBox }

constructor TbsSkinDBComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FInDataChange := True;
  FInDateSelfChange := False;
end;

destructor TbsSkinDBComboBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBComboBox.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBComboBox.CreateWnd;
begin
  inherited CreateWnd;
end;

procedure TbsSkinDBComboBox.DataChange(Sender: TObject);
begin
  FInDataChange := True;
  if not FInDateSelfChange
  then
    begin
      if FDataLink.Field <> nil
      then
         SetComboText(FDataLink.Field.Text)
      else
        if csDesigning in ComponentState
        then
          SetComboText(Name)
        else
         SetComboText('');
    end;     
  FInDataChange := False;
end;

procedure TbsSkinDBComboBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := GetComboText;
end;

procedure TbsSkinDBComboBox.SetComboText(const Value: string);
var
  I: Integer;
  Redraw: Boolean;
begin
  if Value <> GetComboText then
  begin
    if Style = bscbFixedStyle then
    begin
      Redraw := HandleAllocated;
      try
        if Value = '' then I := -1 else I := Items.IndexOf(Value);
        ItemIndex := I;
      finally
        if Redraw then Invalidate;
      end;
      if I >= 0 then Exit;
    end;
    if Style = bscbEditStyle then Text := Value;
  end;
end;

function TbsSkinDBComboBox.GetComboText: string;
var
  I: Integer;
begin
  if Style = bscbEditStyle then Result := Text else
  begin
    I := ItemIndex;
    if I < 0 then Result := '' else Result := Items[I];
  end;
end;

procedure TbsSkinDBComboBox.Change;
begin
  inherited;
  if not FInDataChange and not ReadOnly and FDataLink.CanModify
  then
    begin
      FInDateSelfChange := True;
      FDataLink.Edit;
      FDataLink.Modified;
      FInDateSelfChange := False;
    end;
end;

function TbsSkinDBComboBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBComboBox.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBComboBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBComboBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBComboBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBComboBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBComboBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBComboBox.EditWindowProcHook;
begin
  inherited;
  case Message.Msg of
    WM_SETFOCUS:
      begin
        if ReadOnly or not FDataLink.CanModify
        then FEdit.ReadOnly := True;
      end;
    WM_KILLFOCUS:
      begin
        try
          begin
            if FDataLink.Editing then FDataLink.UpdateRecord;
          end;
        except
          raise;
        end;
      end;
  end;
end;

procedure TbsSkinDBComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_BACK, VK_DELETE, VK_UP, VK_DOWN, 32..255] then
  begin
    if not FDataLink.Edit and (Key in [VK_UP, VK_DOWN]) then
      Key := 0;
  end;
end;

procedure TbsSkinDBComboBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
      end;
  end;
end;

procedure TbsSkinDBComboBox.CMEnter(var Message: TCMEnter);
begin
  inherited;
end;

procedure TbsSkinDBComboBox.CMExit(var Message: TCMExit);
begin
  try
    if ReadOnly or not FDataLink.CanModify
    then
      DataChange(Self)
    else
      if FDataLink.Editing then  FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TbsSkinDBComboBox.SetItems(Value: TStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

function TbsSkinDBComboBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBComboBox.CMGetDatalink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBComboBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBComboBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;


{ TbsSkinDBNavigator }
var
  BtnTypeName: array[TbsNavigateBtn] of PChar = ('FIRST', 'PRIOR', 'NEXT',
    'LAST', 'INSERT', 'DELETE', 'EDIT', 'POST', 'CANCEL', 'REFRESH');

  BtnHints: array[TbsNavigateBtn] of String = (BS_DBNAV_FIRST, BS_DBNAV_PRIOR,
    BS_DBNAV_NEXT, BS_DBNAV_LAST, BS_DBNAV_INSERT, BS_DBNAV_DELETE,
    BS_DBNAV_EDIT, BS_DBNAV_POST, BS_DBNAV_CANCEL, BS_DBNAV_REFRESH);
 
constructor TbsSkinDBNavigator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csOpaque];
  FShowButtonGraphic := True;
  FShowButtonCaption:= False;
  FSkinMessage := nil;
  FAdditionalGlyphs := False;
  FDataLink := TbsNavDataLink.Create(Self);
  FVisibleButtons := [nbFirst, nbPrior, nbNext, nbLast, nbInsert,
    nbDelete, nbEdit, nbPost, nbCancel, nbRefresh];
  FHints := TStringList.Create;
  TStringList(FHints).OnChange := HintsChanged;
  InitButtons;
  InitHints;
  Width := 241;
  Height := 25;
  ButtonWidth := 0;
  FConfirmDelete := True;
  BorderStyle := bvNone;
  FBtnSkinDataName := 'button';
end;

procedure TbsSkinDBNavigator.SetShowButtonCaption;
var
  I: TbsNavigateBtn;
begin
  FShowButtonCaption := Value;
  if FShowButtonCaption
  then
    begin
       for I := Low(Buttons) to High(Buttons) do
       begin
         if Buttons[I] <> nil
         then
           case Ord(i) of
             0: Buttons[I].Caption := BS_DBNAV_FIRST;
             1: Buttons[I].Caption := BS_DBNAV_PRIOR;
             2: Buttons[I].Caption := BS_DBNAV_NEXT;
             3: Buttons[I].Caption := BS_DBNAV_LAST;
             4: Buttons[I].Caption := BS_DBNAV_INSERT;
             5: Buttons[I].Caption := BS_DBNAV_DELETE;
             6: Buttons[I].Caption := BS_DBNAV_EDIT;
             7: Buttons[I].Caption := BS_DBNAV_POST;
             8: Buttons[I].Caption := BS_DBNAV_CANCEL;
             9: Buttons[I].Caption := BS_DBNAV_REFRESH;
           end;
       end;
    end
  else
    begin
      for I := Low(Buttons) to High(Buttons) do
      begin
        if Buttons[I] <> nil
        then
          case Ord(i) of
            0: Buttons[I].Caption := '';
            1: Buttons[I].Caption := '';
            2: Buttons[I].Caption := '';
            3: Buttons[I].Caption := '';
            4: Buttons[I].Caption := '';
            5: Buttons[I].Caption := '';
            6: Buttons[I].Caption := '';
            7: Buttons[I].Caption := '';
            8: Buttons[I].Caption := '';
            9: Buttons[I].Caption := '';
          end;
      end;
   end;
end;

procedure TbsSkinDBNavigator.SetShowButtonGraphic;
var
  I: TbsNavigateBtn;
  ResName: string;
begin
  FShowButtonGraphic := Value;
  if FShowButtonGraphic
  then
    begin
      if FAdditionalGlyphs
      then
         begin
           for I := Low(Buttons) to High(Buttons) do
           begin
             FmtStr(ResName, 'bsdbn_%s', [BtnTypeName[I]]);
             if FAdditionalGlyphs
             then
               ResName := ResName + '1';
             Buttons[I].Glyph.LoadFromResourceName(HInstance, ResName);
             Buttons[I].NumGlyphs := 2;
           end;
         end
      else
        begin
          for I := Low(Buttons) to High(Buttons) do
          begin
            FmtStr(ResName, 'bsdbn_%s', [BtnTypeName[I]]);
            if FAdditionalGlyphs then
            ResName := ResName + '1';
            Buttons[I].Glyph.LoadFromResourceName(HInstance, ResName);
            Buttons[I].NumGlyphs := 2;
            Buttons[I].RePaint;
          end;
       end
    end
  else
    for I := Low(Buttons) to High(Buttons) do
    begin
      Buttons[I].Glyph := nil;
      Buttons[I].RePaint;
    end;
end;


procedure  TbsSkinDBNavigator.SetAdditionalGlyphs;
var
  I: TbsNavigateBtn;
  ResName: String;
begin
  if (Value <> FAdditionalGlyphs) and FShowButtonGraphic
  then
    begin
      FAdditionalGlyphs := Value;
      for I := Low(Buttons) to High(Buttons) do
      begin
        FmtStr(ResName, 'bsdbn_%s', [BtnTypeName[I]]);
        if FAdditionalGlyphs then ResName := ResName + '1';
        Buttons[I].Glyph.LoadFromResourceName(HInstance, ResName);
        Buttons[I].RePaint;
      end;
    end;  
end;

destructor TbsSkinDBNavigator.Destroy;
begin
  FDefHints.Free;
  FDataLink.Free;
  FHints.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBNavigator.ChangeSkinData;
var
  i: Integer;
begin
  inherited;
  if (FIndex <> -1) and (GetResizeMode = 1) and (FBtnSkinDataName <> '')
  then
    begin
      i := SkinData.GetControlIndex(FBtnSkinDataName);
      if i <> -1
      then
        with TbsDataSkinButtonControl(FSD.CtrlList.Items[i]) do
        begin
          if (LBPoint.X = 0) and (LBPoint.Y = 0)
          then
            Height := SkinRect.Bottom - SkinRect.Top; 
        end;
    end;
end;

procedure TbsSkinDBNavigator.SetSkinData;
var
  I: TbsNavigateBtn;
begin
  inherited;
  for I := Low(Buttons) to High(Buttons) do
  with Buttons[I] do
  begin
    SkinData := Self.SkinData;
  end;
  InitHints;
end;

procedure TbsSkinDBNavigator.SetBtnSkinDataName;
var
  I: TbsNavigateBtn;
begin
  FBtnSkinDataName := Value;
  for I := Low(Buttons) to High(Buttons) do
  with Buttons[I] do
  begin
    SkinDataName := FBtnSkinDataName;
  end;
end;

procedure TbsSkinDBNavigator.Paint;
begin
  if VisibleButtons = []
  then
    inherited;
end;

procedure TbsSkinDBNavigator.InitButtons;
var
  I: TbsNavigateBtn;
  Btn: TbsNavButton;
  X: Integer;
  ResName: string;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  for I := Low(Buttons) to High(Buttons) do
  begin
    Btn := TbsNavButton.Create (Self);
    Btn.CanFocused := True;
    Btn.Index := I;
    Btn.Visible := I in FVisibleButtons;
    Btn.Enabled := True;
    Btn.SetBounds (X, 0, MinBtnSize.X, MinBtnSize.Y);
    if FShowButtonGraphic
    then
      begin
        FmtStr(ResName, 'bsdbn_%s', [BtnTypeName[I]]);
        if FAdditionalGlyphs then ResName := ResName + '1';
        Btn.Glyph.LoadFromResourceName(HInstance, ResName);
        Btn.NumGlyphs := 2;
      end;
    Btn.Enabled := False;
    Btn.Enabled := True;
    Btn.OnClick := ClickHandler;
    Btn.Parent := Self;
    Buttons[I] := Btn;
    X := X + MinBtnSize.X;
  end;
  Buttons[nbPrior].NavStyle := Buttons[nbPrior].NavStyle + [nsAllowTimer];
  Buttons[nbNext].NavStyle  := Buttons[nbNext].NavStyle + [nsAllowTimer];
end;

procedure TbsSkinDBNavigator.InitHints;
var
  I: Integer;
  J: TbsNavigateBtn;
begin
  if not Assigned(FDefHints) then
  begin
    FDefHints := TStringList.Create;
    for J := Low(Buttons) to High(Buttons) do
      FDefHints.Add(BtnHints[J]);
  end;
  for J := Low(Buttons) to High(Buttons) do
    Buttons[J].Hint := FDefHints[Ord(J)];
  J := Low(Buttons);
  for I := 0 to (FHints.Count - 1) do
  begin
    if FHints.Strings[I] <> '' then Buttons[J].Hint := FHints.Strings[I];
    if J = High(Buttons) then Exit;
    Inc(J);
  end;
end;

procedure TbsSkinDBNavigator.HintsChanged(Sender: TObject);
begin
  InitHints;
end;

procedure TbsSkinDBNavigator.SetHints(Value: TStrings);
begin
  if Value.Text = FDefHints.Text then
    FHints.Clear else
    FHints.Assign(Value);
end;

function TbsSkinDBNavigator.GetHints: TStrings;
begin
  if (csDesigning in ComponentState) and not (csWriting in ComponentState) and
     not (csReading in ComponentState) and (FHints.Count = 0) then
    Result := FDefHints else
    Result := FHints;
end;

procedure TbsSkinDBNavigator.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TbsSkinDBNavigator.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
  if (Operation = opRemove) and (FSkinMessage <> nil) and
    (AComponent = FSkinMessage) then FSkinMessage := nil;
end;

procedure TbsSkinDBNavigator.SetVisible(Value: TbsButtonSet);
var
  I: TbsNavigateBtn;
  W, H: Integer;
begin
  W := Width;
  H := Height;
  FVisibleButtons := Value;
  for I := Low(Buttons) to High(Buttons) do
    Buttons[I].Visible := I in FVisibleButtons;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  Invalidate;
end;

procedure TbsSkinDBNavigator.CalcMinSize(var W, H: Integer);
var
  Count: Integer;
  I: TbsNavigateBtn;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[nbFirst] = nil then Exit;

  Count := 0;
  for I := Low(Buttons) to High(Buttons) do
    if Buttons[I].Visible then
      Inc(Count);
  if Count = 0 then Inc(Count);

  W := Max(W, Count * MinBtnSize.X);
  H := Max(H, MinBtnSize.Y);

  if Align = alNone then W := (W div Count) * Count;
end;

procedure TbsSkinDBNavigator.SetSize(var W: Integer; var H: Integer);
var
  Count: Integer;
  I: TbsNavigateBtn;
  Space, Temp, Remain: Integer;
  X: Integer;
begin
  if (csLoading in ComponentState) then Exit;
  if Buttons[nbFirst] = nil then Exit;

  CalcMinSize(W, H);

  Count := 0;
  for I := Low(Buttons) to High(Buttons) do
    if Buttons[I].Visible then
      Inc(Count);
  if Count = 0 then Inc(Count);

  ButtonWidth := W div Count;
  Temp := Count * ButtonWidth;
  if Align = alNone then W := Temp;

  X := 0;
  Remain := W - Temp;
  Temp := Count div 2;
  for I := Low(Buttons) to High(Buttons) do
  begin
    if Buttons[I].Visible then
    begin
      Space := 0;
      if Remain <> 0 then
      begin
        Dec(Temp, Remain);
        if Temp < 0 then
        begin
          Inc(Temp, Count);
          Space := 1;
        end;
      end;
      Buttons[I].SetBounds(X, 0, ButtonWidth + Space, Height);
      Inc(X, ButtonWidth + Space);
    end
    else
      Buttons[I].SetBounds (Width + 1, 0, ButtonWidth, Height);
  end;
end;

procedure TbsSkinDBNavigator.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  if not HandleAllocated then SetSize(W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TbsSkinDBNavigator.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  W := Width;
  H := Height;
  SetSize(W, H);
end;

procedure TbsSkinDBNavigator.WMWindowPosChanging(var Message: TWMWindowPosChanging);
begin
  inherited;
  if (SWP_NOSIZE and Message.WindowPos.Flags) = 0 then
    CalcMinSize(Message.WindowPos.cx, Message.WindowPos.cy);
end;

procedure TbsSkinDBNavigator.ClickHandler(Sender: TObject);
begin
  BtnClick (TbsNavButton (Sender).Index);
end;

procedure TbsSkinDBNavigator.BtnClick(Index: TbsNavigateBtn);
var
  Msg: String;
begin
  if (DataSource <> nil) and (DataSource.State <> dsInactive) then
  begin
    if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then
      FBeforeAction(Self, Index);
    with DataSource.DataSet do
    begin
      case Index of
        nbPrior: Prior;
        nbNext: Next;
        nbFirst: First;
        nbLast: Last;
        nbInsert: Insert;
        nbEdit: Edit;
        nbCancel: Cancel;
        nbPost: Post;
        nbRefresh: Refresh;
        nbDelete:
          if (FSkinMessage <> nil)
          then
            begin
              if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
              then
                Msg := SkinData.ResourceStrData.GetResStr('DB_DELETE_QUESTION')
              else
                Msg := BS_DB_DELETE_QUESTION;
              if not FConfirmDelete or
                (FSkinMessage.MessageDlg(Msg, mtConfirmation,
                   [mbOK, mbCancel], 0) <> idCancel) then Delete;
            end
          else
            begin
              if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
              then
                Msg := SkinData.ResourceStrData.GetResStr('DB_DELETE_QUESTION')
              else
                Msg := BS_DB_DELETE_QUESTION;
              if not FConfirmDelete or
                (MessageDlg(Msg, mtConfirmation,
                 mbOKCancel, 0) <> idCancel) then Delete;
            end;
      end;
    end;
  end;
  if not (csDesigning in ComponentState) and Assigned(FOnNavClick) then
    FOnNavClick(Self, Index);
end;

procedure TbsSkinDBNavigator.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;

procedure TbsSkinDBNavigator.DataChanged;
var
  UpEnable, DnEnable: Boolean;
begin
  UpEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.BOF;
  DnEnable := Enabled and FDataLink.Active and not FDataLink.DataSet.EOF;
  Buttons[nbFirst].Enabled := UpEnable;
  Buttons[nbPrior].Enabled := UpEnable;
  Buttons[nbNext].Enabled := DnEnable;
  Buttons[nbLast].Enabled := DnEnable;
  Buttons[nbDelete].Enabled := Enabled and FDataLink.Active and
    FDataLink.DataSet.CanModify and
    not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF);
end;

procedure TbsSkinDBNavigator.EditingChanged;
var
  CanModify: Boolean;
begin
  CanModify := Enabled and FDataLink.Active and FDataLink.DataSet.CanModify;
  Buttons[nbInsert].Enabled := CanModify;
  Buttons[nbEdit].Enabled := CanModify and not FDataLink.Editing;
  Buttons[nbPost].Enabled := CanModify and FDataLink.Editing;
  Buttons[nbCancel].Enabled := CanModify and FDataLink.Editing;
  Buttons[nbRefresh].Enabled := CanModify;
end;

procedure TbsSkinDBNavigator.ActiveChanged;
var
  I: TbsNavigateBtn;
begin
  if not (Enabled and FDataLink.Active) then
    for I := Low(Buttons) to High(Buttons) do
      Buttons[I].Enabled := False
  else
  begin
    DataChanged;
    EditingChanged;
  end;
end;

procedure TbsSkinDBNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    ActiveChanged;
end;

procedure TbsSkinDBNavigator.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if not (csLoading in ComponentState) then
    ActiveChanged;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBNavigator.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBNavigator.Loaded;
var
  W, H: Integer;
  i: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  InitHints;
  ActiveChanged;
  GetSkinData;
  if (SkinData <> nil) and (FIndex <> -1) and (GetResizeMode = 1) and (FBtnSkinDataName <> '')
  then
    begin
      i := SkinData.GetControlIndex(FBtnSkinDataName);
      if i <> -1
      then
        with TbsDataSkinButtonControl(FSD.CtrlList.Items[i]) do
        begin
          if (LBPoint.X = 0) and (LBPoint.Y = 0)
          then
            Height := SkinRect.Bottom - SkinRect.Top;
        end;
    end;
end;

{TbsNavButton}

destructor TbsNavButton.Destroy;
begin
  if FRepeatTimer <> nil then
    FRepeatTimer.Free;
  inherited Destroy;
end;

procedure TbsNavButton.GetSkinData;
begin
  inherited;
  MaskPicture := nil;
end;

procedure TbsNavButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  if nsAllowTimer in FNavStyle then
  begin
    if FRepeatTimer = nil then
      FRepeatTimer := TTimer.Create(Self);

    FRepeatTimer.OnTimer := TimerExpired;
    FRepeatTimer.Interval := InitRepeatPause;
    FRepeatTimer.Enabled  := True;
  end;
end;

procedure TbsNavButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer <> nil then
    FRepeatTimer.Enabled  := False;
end;

procedure TbsNavButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FMouseIn and FDown) and MouseCapture then
  begin
    try
      ButtonClick;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

{ TbsNavDataLink }

constructor TbsNavDataLink.Create(ANav: TbsSkinDBNavigator);
begin
  inherited Create;
  FNavigator := ANav;
  VisualControl := True;
end;

destructor TbsNavDataLink.Destroy;
begin
  FNavigator := nil;
  inherited Destroy;
end;

procedure TbsNavDataLink.EditingChanged;
begin
  if FNavigator <> nil then FNavigator.EditingChanged;
end;

procedure TbsNavDataLink.DataSetChanged;
begin
  if FNavigator <> nil then FNavigator.DataChanged;
end;

procedure TbsNavDataLink.ActiveChanged;
begin
  if FNavigator <> nil then FNavigator.ActiveChanged;
end;

constructor TbsSkinDBImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 105;
  Height := 105;
  TabStop := True;
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  FAutoDisplay := True;
  FCenter := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FQuickDraw := True;
  FForceBackground := False;
end;

destructor TbsSkinDBImage.Destroy;
begin
  FPicture.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TbsSkinDBImage.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBImage.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBImage.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBImage.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBImage.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBImage.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBImage.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TbsSkinDBImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic is TBitmap then
    Result := TBitmap(FPicture.Graphic).Palette;
end;

procedure TbsSkinDBImage.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadPicture;
  end;
end;

procedure TbsSkinDBImage.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    Invalidate;
  end;
end;

procedure TbsSkinDBImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TbsSkinDBImage.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    Invalidate;
  end;
end;

procedure TbsSkinDBImage.CreateControlDefaultImage(B: TBitMap);
begin
  inherited;
  if not RollUpState then PaintImage(B.Canvas);
end;

procedure TbsSkinDBImage.CreateControlSkinImage(B: TBitMap);
begin
  inherited;
  if not RollUpState then PaintImage(B.Canvas);
end;

procedure TbsSkinDBImage.PaintImage;

procedure DrawFocus(Cnvs: TCanvas; R: TRect);
begin
  with Cnvs do
  begin
    Pen.Color := clWindowFrame;
    Pen.Mode := pmNot;
    Brush.Style := bsClear;
    Rectangle(R.Left, R.Top, R.Right, R.Bottom);
  end;
end;


var
  Size: TSize;
  DrawRect, R: TRect;
  S: string;
  DrawPict: TPicture;
  Form: TCustomForm;
  Pal: HPalette;
begin
  DrawRect := Rect(0, 0, Width, Height);
  AdjustClientRect(DrawRect);
  with Cnvs do
  begin
    Brush.Style := bsClear;
    if FPictureLoaded or (csPaintCopy in ControlState) then
    begin
      DrawPict := TPicture.Create;
      Pal := 0;
      try
        if (csPaintCopy in ControlState) and
          Assigned(FDataLink.Field) and FDataLink.Field.IsBlob
        then
          begin
            DrawPict.Assign(FDataLink.Field);
            if DrawPict.Graphic is TBitmap then
              DrawPict.Bitmap.IgnorePalette := QuickDraw;
          end
        else
          DrawPict.Assign(Picture);
      if Stretch
      then
        begin
         if (DrawPict.Graphic <> nil) and not DrawPict.Graphic.Empty
         then
            StretchDraw(DrawRect, DrawPict.Graphic);
        end
      else
        begin
          Windows.SetRect(R, DrawRect.Left, DrawRect.Top,
                     DrawRect.Left + DrawPict.Width,
                     DrawRect.Top + DrawPict.Height);
          if Center
          then
            OffsetRect(R, ((DrawRect.Right - DrawRect.Left) - DrawPict.Width) div 2,
            ((DrawRect.Bottom - DrawRect.Top) - DrawPict.Height) div 2);
          StretchDraw(R, DrawPict.Graphic);
        end;
      finally
        if Pal <> 0 then SelectPalette(Handle, Pal, True);
        DrawPict.Free;
      end;
    end;
    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.ActiveControl = Self) and
      not (csDesigning in ComponentState) and
      not (csPaintCopy in ControlState)
    then
      DrawFocus(Cnvs, DrawRect);
  end;
end;

procedure TbsSkinDBImage.PictureChanged(Sender: TObject);
begin
  if FPictureLoaded then FDataLink.Modified;
  FPictureLoaded := True;
  Invalidate;
end;

procedure TbsSkinDBImage.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBImage.LoadPicture;
begin
  if not FPictureLoaded and (not Assigned(FDataLink.Field) or
    FDataLink.Field.IsBlob) then
    Picture.Assign(FDataLink.Field);
end;

procedure TbsSkinDBImage.DataChange(Sender: TObject);
begin
  Picture.Graphic := nil;
  FPictureLoaded := False;
  if FAutoDisplay then LoadPicture;
end;

procedure TbsSkinDBImage.UpdateData(Sender: TObject);
begin
  if Picture.Graphic is TBitmap then
     FDataLink.Field.Assign(Picture.Graphic) else
     FDataLink.Field.Clear;
end;

procedure TbsSkinDBImage.CopyToClipboard;
begin
  if Picture.Graphic <> nil then Clipboard.Assign(Picture);
end;

procedure TbsSkinDBImage.CutToClipboard;
begin
  if Picture.Graphic <> nil then
    if FDataLink.Edit then
    begin
      CopyToClipboard;
      Picture.Graphic := nil;
    end;
end;

procedure TbsSkinDBImage.PasteFromClipboard;
begin
  if Clipboard.HasFormat(CF_BITMAP) and FDataLink.Edit then
    Picture.Bitmap.Assign(Clipboard);
end;

procedure TbsSkinDBImage.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TbsSkinDBImage.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  case Key of
    VK_INSERT:
      if ssShift in Shift then PasteFromClipBoard else
        if ssCtrl in Shift then CopyToClipBoard;
    VK_DELETE:
      if ssShift in Shift then CutToClipBoard;
  end;
end;

procedure TbsSkinDBImage.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    ^X: CutToClipBoard;
    ^C: CopyToClipBoard;
    ^V: PasteFromClipBoard;
    #13: LoadPicture;
    #27: FDataLink.Reset;
  end;
end;

procedure TbsSkinDBImage.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TbsSkinDBImage.CMEnter(var Message: TCMEnter);
begin
  Invalidate; { Draw the focus marker }
  inherited;
end;

procedure TbsSkinDBImage.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  Invalidate; { Erase the focus marker }
  inherited;
end;

procedure TbsSkinDBImage.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if not FPictureLoaded then Invalidate;
end;

procedure TbsSkinDBImage.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if TabStop and CanFocus then SetFocus;
  inherited;
end;

procedure TbsSkinDBImage.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  LoadPicture;
  inherited;
end;

procedure TbsSkinDBImage.WMCut(var Message: TMessage);
begin
  CutToClipboard;
end;

procedure TbsSkinDBImage.WMCopy(var Message: TMessage);
begin
  CopyToClipboard;
end;

procedure TbsSkinDBImage.WMPaste(var Message: TMessage);
begin
  PasteFromClipboard;
end;

procedure TbsSkinDBImage.WMSize(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

function TbsSkinDBImage.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBImage.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TbsSkinDBRadioGroup }

constructor TbsSkinDBRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FValues := TStringList.Create;
  FInClick := False;
end;

destructor TbsSkinDBRadioGroup .Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FValues.Free;
  inherited Destroy;
end;

procedure TbsSkinDBRadioGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBRadioGroup .UseRightToLeftAlignment: Boolean;
begin
  Result := inherited UseRightToLeftAlignment;
end;

procedure TbsSkinDBRadioGroup.DataChange(Sender: TObject);
begin
  if not FInClick then
  if FDataLink.Field <> nil then
    Value := FDataLink.Field.Text else
    Value := '';
end;

procedure TbsSkinDBRadioGroup.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil then FDataLink.Field.Text := Value;
end;

function TbsSkinDBRadioGroup.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBRadioGroup.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBRadioGroup.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBRadioGroup.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBRadioGroup.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBRadioGroup.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBRadioGroup.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TbsSkinDBRadioGroup.GetButtonValue(Index: Integer): string;
begin
  if (Index < FValues.Count) and (FValues[Index] <> '') then
    Result := FValues[Index]
  else if Index < Items.Count then
    Result := Items[Index]
  else
    Result := '';
end;

procedure TbsSkinDBRadioGroup.SetValue(const Value: string);
var
  I, Index: Integer;
begin
  if FValue <> Value then
  begin
    FInSetValue := True;
    try
      Index := -1;
      for I := 0 to Items.Count - 1 do
        if Value = GetButtonValue(I) then
        begin
          Index := I;
          Break;
        end;
      ItemIndex := Index;
    finally
      FInSetValue := False;
    end;
    FValue := Value;
    Change;
  end;
end;

procedure TbsSkinDBRadioGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    if ItemIndex >= 0 then
      TRadioButton(Controls[ItemIndex]).SetFocus else
      TRadioButton(Controls[0]).SetFocus;
    raise;
  end;
  inherited;
end;

procedure TbsSkinDBRadioGroup.Click;
begin
  if not FInSetValue then
  begin
    inherited Click;
    FInClick := True;
    if ItemIndex >= 0
    then Value := GetButtonValue(ItemIndex);
    if not ReadOnly  and not FDataLink.Editing then FDataLink.Edit;
    if FDataLink.Editing
    then FDataLink.Modified;
    FInClick := False;
  end;
end;

procedure TbsSkinDBRadioGroup.SetItems(Value: TStrings);
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TbsSkinDBRadioGroup.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
  DataChange(Self);
end;

procedure TbsSkinDBRadioGroup.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TbsSkinDBRadioGroup.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
end;

function TbsSkinDBRadioGroup.CanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

function TbsSkinDBRadioGroup.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and
    DataLink.ExecuteAction(Action);
end;

function TbsSkinDBRadioGroup.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;

constructor TbsSkinDBSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBSpinEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TbsSkinDBSpinEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBSpinEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBSpinEdit.Reset;
begin
  FDataLink.Reset;
  FEdit.SelectAll;
end;

procedure TbsSkinDBSpinEdit.Change;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit; 
      FDataLink.Modified;
      inherited Change;
    end;
  FInChange := False;
end;

function TbsSkinDBSpinEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBSpinEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBSpinEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBSpinEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBSpinEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBSpinEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBSpinEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBSpinEdit.DataChange(Sender: TObject);
begin
  FInDataChange := True; 
  if not FInChange then
  if FDataLink.Field <> nil
  then
    begin
      if (FDataLink.Field.Text <> '') and IsNumText(FDataLink.Field.Text)
      then
        Text := FDataLink.Field.Text
      else
        Value := MinValue;
    end
  else
    Value := MinValue;
  FInDataChange := False;
end;

procedure TbsSkinDBSpinEdit.EditingChange(Sender: TObject);
begin
  FEdit.ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBSpinEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := FEdit.Text;
end;

procedure TbsSkinDBSpinEdit.EditEnter;
begin
  FEdit.ReadOnly := not FDataLink.CanModify;
  inherited;
end;

procedure TbsSkinDBSpinEdit.EditExit;
begin
  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
  inherited;
end;

procedure TbsSkinDBSpinEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBSpinEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBSpinEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TbsDataSourceLink }

constructor TbsDataSourceLink.Create;
begin
  inherited Create;
  VisualControl := True;
end;

procedure TbsDataSourceLink.ActiveChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateDataFields;
end;

procedure TbsDataSourceLink.FocusControl(Field: TFieldRef);
begin
  if (Field^ <> nil) and (Field^ = FDBLookupControl.Field) and
    (FDBLookupControl <> nil) and FDBLookupControl.CanFocus then
  begin
    Field^ := nil;
    FDBLookupControl.SetFocus;
  end;
end;

procedure TbsDataSourceLink.LayoutChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateDataFields;
end;

procedure TbsDataSourceLink.RecordChanged(Field: TField);
begin
  if FDBLookupControl <> nil then FDBLookupControl.DataLinkRecordChanged(Field);
end;

{ TbsListSourceLink }

constructor TbsListSourceLink.Create;
begin
  inherited Create;
  VisualControl := True;
end;

procedure TbsListSourceLink.ActiveChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateListFields;
end;

procedure TbsListSourceLink.DataSetChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.ListLinkDataChanged;
end;

procedure TbsListSourceLink.LayoutChanged;
begin
  if FDBLookupControl <> nil then FDBLookupControl.UpdateListFields;
end;

{ TbsDBLookupControl }

function VarEquals(const V1, V2: Variant): Boolean;
begin
  Result := False;
  try
    Result := V1 = V2;
  except
  end;
end;

var
  SearchTickCount: Integer = 0;



constructor TbsDBLookupControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentColor := False;
  TabStop := True;
  FLookupSource := TDataSource.Create(Self);
  FDataLink := TbsDataSourceLink.Create;
  FDataLink.FDBLookupControl := Self;
  FListLink := TbsListSourceLink.Create;
  FListLink.FDBLookupControl := Self;
  FListFields := TList.Create;
  FKeyValue := Null;
end;

destructor TbsDBLookupControl.Destroy;
begin
  inherited Destroy;
  FListFields.Free;
  FListFields := nil;
  if FListLink <> nil then
    FListLink.FDBLookupControl := nil;
  FListLink.Free;
  FListLink := nil;
  if FDataLink <> nil then
    FDataLink.FDBLookupControl := nil;
  FDataLink.Free;
  FDataLink := nil;
end;

function TbsDBLookupControl.CanModify: Boolean;
begin
  Result := FListActive and not ReadOnly and ((FDataLink.DataSource = nil) or
    (FMasterField <> nil) and FMasterField.CanModify);
end;

procedure TbsDBLookupControl.CheckNotCircular;
begin
  if FListLink.Active and FListLink.DataSet.IsLinkedTo(DataSource) then
    DatabaseError('Circular datalinks are not allowed');
end;

procedure TbsDBLookupControl.CheckNotLookup;
begin
  if FLookupMode then DatabaseError('SPropDefByLookup');
  if FDataLink.DataSourceFixed then DatabaseError('SDataSourceFixed');
end;

procedure TbsDBLookupControl.UpdateDataFields;
begin
  FDataField := nil;
  FMasterField := nil;
  if FDataLink.Active and (FDataFieldName <> '') then
  begin
    CheckNotCircular;
    FDataField := GetFieldProperty(FDataLink.DataSet, Self, FDataFieldName);
    if FDataField.FieldKind = fkLookup then
      FMasterField := GetFieldProperty(FDataLink.DataSet, Self, FDataField.KeyFields)
    else
      FMasterField := FDataField;
  end;
  SetLookupMode((FDataField <> nil) and (FDataField.FieldKind = fkLookup));
  DataLinkRecordChanged(nil);
end;

procedure TbsDBLookupControl.DataLinkRecordChanged(Field: TField);
begin
  if (Field = nil) or (Field = FMasterField) then
    if FMasterField <> nil then
      SetKeyValue(FMasterField.Value) else
      SetKeyValue(Null);
end;

function TbsDBLookupControl.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TbsDBLookupControl.GetKeyFieldName: string;
begin
  if FLookupMode then Result := '' else Result := FKeyFieldName;
end;

function TbsDBLookupControl.GetListSource: TDataSource;
begin
  if FLookupMode then Result := nil else Result := FListLink.DataSource;
end;

function TbsDBLookupControl.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsDBLookupControl.KeyValueChanged;
begin
end;

procedure TbsDBLookupControl.UpdateListFields;
var
  DataSet: TDataSet;
  ResultField: TField;
begin
  FListActive := False;
  FKeyField := nil;
  FListField := nil;
  FListFields.Clear;
  if FListLink.Active and (FKeyFieldName <> '') then
  begin
    CheckNotCircular;
    DataSet := FListLink.DataSet;
    FKeyField := GetFieldProperty(DataSet, Self, FKeyFieldName);
    try
      DataSet.GetFieldList(FListFields, FListFieldName);
    except
      DatabaseErrorFmt('Field ''%s'' not found', [Self.Name, FListFieldName]);
    end;
    if FLookupMode then
    begin
      ResultField := GetFieldProperty(DataSet, Self, FDataField.LookupResultField);
      if FListFields.IndexOf(ResultField) < 0 then
        FListFields.Insert(0, ResultField);
      FListField := ResultField;
    end else
    begin
      if FListFields.Count = 0 then FListFields.Add(FKeyField);
      if (FListFieldIndex >= 0) and (FListFieldIndex < FListFields.Count) then
        FListField := FListFields[FListFieldIndex] else
        FListField := FListFields[0];
    end;
    FListActive := True;
  end;
end;

procedure TbsDBLookupControl.ListLinkDataChanged;
begin
end;

function TbsDBLookupControl.LocateKey: Boolean;
var
  KeySave: Variant;
begin
  Result := False;
  try
    KeySave := FKeyValue;
    if not VarIsNull(FKeyValue) and FListLink.DataSet.Active and
      FListLink.DataSet.Locate(FKeyFieldName, FKeyValue, []) then
    begin
      Result := True;
      FKeyValue := KeySave;
    end;
  except
  end;
end;

procedure TbsDBLookupControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if (FDataLink <> nil) and (AComponent = DataSource) then DataSource := nil;
    if (FListLink <> nil) and (AComponent = ListSource) then ListSource := nil;
  end;
end;

procedure TbsDBLookupControl.ProcessSearchKey(Key: Char);
var
  TickCount: Integer;
  S: string;
  CharMsg: TMsg;
begin
  if (FListField <> nil) and (FListField.FieldKind in [fkData, fkInternalCalc]) and
    (FListField.DataType in [ftString, ftWideString]) then
    case Key of
      #8, #27: SearchText := '';
      #32..#255:
        if CanModify then
        begin
          TickCount := GetTickCount;
          if TickCount - SearchTickCount > 2000 then SearchText := '';
          SearchTickCount := TickCount;
          if SysLocale.FarEast and (Key in LeadBytes) then
            if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
            begin
              if CharMsg.Message = WM_Quit then
              begin
                PostQuitMessage(CharMsg.wparam);
                Exit;
              end;
              SearchText := SearchText + Key;
              Key := Char(CharMsg.wParam);
            end;
          if Length(SearchText) < 32 then
          begin
            S := SearchText + Key;
            try
              if FListLink.DataSet.Locate(FListField.FieldName, S,
                [loCaseInsensitive, loPartialKey]) then
              begin
                SelectKeyValue(FKeyField.Value);
                SearchText := S;
              end;
            except
              { If you attempt to search for a string larger than what the field
                can hold, and exception will be raised.  Just trap it and
                reset the SearchText back to the old value. }
              SearchText := S;
            end;
          end;
        end;
    end;
end;

procedure TbsDBLookupControl.SelectKeyValue(const Value: Variant);
begin
  if FMasterField <> nil then
  begin
    if FDataLink.Edit then
      FMasterField.Value := Value;
  end else
    SetKeyValue(Value);
  Repaint;
  Click;
end;

procedure TbsDBLookupControl.SetDataFieldName(const Value: string);
begin
  if FDataFieldName <> Value then
  begin
    FDataFieldName := Value;
    UpdateDataFields;
  end;
end;

procedure TbsDBLookupControl.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TbsDBLookupControl.SetKeyFieldName(const Value: string);
begin
  CheckNotLookup;
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    UpdateListFields;
  end;
end;

procedure TbsDBLookupControl.SetKeyValue(const Value: Variant);
begin
  if not VarEquals(FKeyValue, Value) then
  begin
    FKeyValue := Value;
    KeyValueChanged;
  end;
end;

procedure TbsDBLookupControl.SetListFieldName(const Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    UpdateListFields;
  end;
end;

procedure TbsDBLookupControl.SetListSource(Value: TDataSource);
begin
  CheckNotLookup;
  FListLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TbsDBLookupControl.SetLookupMode(Value: Boolean);
begin
  if FLookupMode <> Value then
    if Value then
    begin
      FMasterField := GetFieldProperty(FDataField.DataSet, Self, FDataField.KeyFields);
      FLookupSource.DataSet := FDataField.LookupDataSet;
      FKeyFieldName := FDataField.LookupKeyFields;
      FLookupMode := True;
      FListLink.DataSource := FLookupSource;
    end else
    begin
      FListLink.DataSource := nil;
      FLookupMode := False;
      FKeyFieldName := '';
      FLookupSource.DataSet := nil;
      FMasterField := FDataField;
    end;
end;

procedure TbsDBLookupControl.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TbsDBLookupControl.WMGetDlgCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TbsDBLookupControl.WMKillFocus(var Message: TMessage);
begin
  FHasFocus := False;
  inherited;
  Invalidate;
end;

procedure TbsDBLookupControl.WMSetFocus(var Message: TMessage);
begin
  SearchText := '';
  FHasFocus := True;
  inherited;
  Invalidate;
end;

procedure TbsDBLookupControl.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TbsDBLookupControl.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsDBLookupControl.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsDBLookupControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TbsDBLookupControl.WMKeyDown(var Message: TWMKeyDown);
begin
  if (FNullValueKey <> 0) and CanModify and (FNullValueKey = ShortCut(Message.CharCode,
     KeyDataToShiftState(Message.KeyData))) then
  begin
    FDataLink.Edit;
    if Assigned(Field) then Field.Clear;
    FKeyValue := null;
    KeyValueChanged;
    Message.CharCode := 0;
  end;
  inherited;
end;

{ TbsSkinDBLookupListBox }

constructor TbsSkinDBLookupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDoubleClicks];
  FSkinDataName := 'listbox';
  FDefaultItemHeight := 20;
  FUseSkinItemHeight := True;
  FScrollBar := nil;
  FStopThumbScroll := False;
  Width := 100;
  FRowCount := 7;
end;

destructor TbsSkinDBLookupListBox.Destroy;
begin
  inherited;
end;

procedure TbsSkinDBLookupListBox.ShowScrollBar;
begin
  if FScrollBar = nil
  then
    begin
      FScrollBar := TbsSkinScrollBar.Create(Self);
      FScrollBar.Kind := sbVertical;
      FScrollBar.Kind := sbVertical;
      if FIndex <> -1
      then
        FScrollBar.SkinDataName := ScrollBarName;
      FScrollBar.SkinData := SkinData;
      FScrollBar.Parent := Self;
      FScrollBar.DefaultWidth := 19;
      FScrollBar.OnChange := OnScrollBarChange;
      FScrollBar.OnUpButtonClick := OnScrollBarUpButtonClick;
      FScrollBar.OnDownButtonClick := OnScrollBarDownButtonClick;
      AlignScrollBar;
      RePaint;
    end;
end;

procedure TbsSkinDBLookupListBox.HideScrollBar;
begin
  if FScrollBar <> nil
  then
    begin
      FScrollBar.Visible := False;
      FScrollBar.Free;
      FScrollBar := nil;
      RePaint;
    end;
end;

type
  TXScrollBar = class(TBsSkinScrollBar);

procedure TbsSkinDBLookupListBox.OnScrollBarUpButtonClick;
begin
  FStopThumbScroll := True;
  SendMessage(Handle, WM_VSCROLL,
    MakeWParam(SB_LINEDOWN, FScrollBar.Position), 0);
end;

procedure TbsSkinDBLookupListBox.OnScrollBarDownButtonClick(Sender: TObject);
begin
  FStopThumbScroll := True;
  SendMessage(Handle, WM_VSCROLL,
    MakeWParam(SB_LINEUP, FScrollBar.Position), 0);
end;

procedure TbsSkinDBLookupListBox.OnScrollBarChange;
begin
  if not FStopThumbScroll then
  SendMessage(Handle, WM_VSCROLL,
              MakeWParam(SB_THUMBPOSITION, FScrollBar.Position), 0);
  FStopThumbScroll := False;            
end;


procedure TbsSkinDBLookupListBox.AlignScrollBar;
begin
  if FScrollBar <> nil
  then
    FScrollBar.SetBounds(ClientWidth - FScrollBar.Width, 0,
                         FScrollBar.Width, ClientHeight);
end;

procedure TbsSkinDBLookupListBox.ChangeSkinData;
begin
  inherited;
  if FScrollBar <> nil
  then
    begin
      if FIndex <> -1
      then
        begin
          FScrollBar.SkinDataName := ScrollBarName;
          FScrollBar.SkinData := SkinData;
        end
      else
        begin
          FScrollBar.SkinDataName := '';
          FScrollBar.ChangeSkinData;
        end;
    end;
  SetBounds(Left, Top, Width, Height);
  SendMessage(Handle, WM_NCPAINT, 0, 0);  
end;

function TbsSkinDBLookupListBox.GetItemHeight;
begin
  if (FIndex = -1) or not FUseSkinItemHeight
  then
    Result := FDefaultItemHeight
  else
    Result := RectHeight(SItemRect);
end;

function TbsSkinDBLookupListBox.GetItemWidth;
begin
  Result := ClientWidth;
  if FScrollBar <> nil
  then
    Result := Result - FScrollBar.Width;
end;

function TbsSkinDBLookupListBox.GetBorderHeight;
begin
  if FIndex = -1
  then
    Result := 4
  else
    Result := RectHeight(SkinRect) - RectHeight(ClRect);
end;

procedure TbsSkinDBLookupListBox.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinListBox
    then
      with TbsDataSkinListBox(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.FontName := FontName;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.SItemRect := SItemRect;
        Self.ActiveItemRect := ActiveItemRect;
        if isNullRect(ActiveItemRect)
        then
          Self.ActiveItemRect := SItemRect;
        Self.FocusItemRect := FocusItemRect;
        if isNullRect(FocusItemRect)
        then
          Self.FocusItemRect := SItemRect;
        Self.ItemLeftOffset := ItemLeftOffset;
        Self.ItemRightOffset := ItemRightOffset;
        Self.ItemTextRect := ItemTextRect;
        Self.FontColor := FontColor;
        Self.ActiveFontColor := ActiveFontColor;
        Self.FocusFontColor := FocusFontColor;
        //
        Self.ScrollBarName := VScrollBarName;
      end;
end;

procedure TbsSkinDBLookupListBox.WMNCCALCSIZE;
begin
  GetSkinData;
  if FIndex = -1
  then
    with Message.CalcSize_Params^.rgrc[0] do
    begin
      Inc(Left, 2);
      Inc(Top, 2);
      Dec(Right, 2);
      Dec(Bottom, 2);
    end
  else
    with Message.CalcSize_Params^.rgrc[0] do
    begin
      Inc(Left, ClRect.Left);
      Inc(Top, ClRect.Top);
      Dec(Right, RectWidth(SkinRect) - ClRect.Right);
      Dec(Bottom, RectHeight(SkinRect) - ClRect.Bottom);
    end;
end;

procedure TbsSkinDBLookupListBox.FramePaint(C: TCanvas);
var
  R: TRect;
  LeftB, TopB, RightB, BottomB: TBitMap;
  OffX, OffY: Integer;
begin
  GetSkinData;
  if FIndex = -1
  then
    with C do
    begin
      Brush.Style := bsClear;
      Pen.Color := clBtnFace;
      Rectangle(1, 1, Width-1, Height-1);
      R := Rect(0, 0, Width, Height);
      Frame3D(C, R, clBtnShadow, clBtnShadow, 1);
      Exit;
    end;

  LeftB := TBitMap.Create;
  TopB := TBitMap.Create;
  RightB := TBitMap.Create;
  BottomB := TBitMap.Create;

  OffX := Width - RectWidth(SkinRect);
  OffY := Height - RectHeight(SkinRect);

  CreateSkinBorderImages(LTPt, RTPt, LBPt, RBPt, CLRect,
     NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
     LeftB, TopB, RightB, BottomB, Picture, SkinRect, Width, Height,
     False, False, False, False);

  C.Draw(0, 0, TopB);
  C.Draw(0, TopB.Height, LeftB);
  C.Draw(Width - RightB.Width, TopB.Height, RightB);
  C.Draw(0, Height - BottomB.Height, BottomB);

  TopB.Free;
  LeftB.Free;
  RightB.Free;
  BottomB.Free;
end;

procedure TbsSkinDBLookupListBox.WMNCPAINT;
var
  DC: HDC;
  C: TCanvas;
begin
  DC := GetWindowDC(Handle);
  C := TControlCanvas.Create;
  C.Handle := DC;
  try
    FramePaint(C);
  finally
    C.Free;
    ReleaseDC(Handle, DC);
  end;
end;

procedure TbsSkinDBLookupListBox.SetDefaultItemHeight;
begin
  if Value > 0
  then
    begin
      FDefaultItemHeight := Value;
      if (FIndex = -1) or not FUseSkinItemHeight
      then
        SetBounds(Left, Top, Width, Height);
    end;  
end;

procedure TbsSkinDBLookupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TbsSkinDBLookupListBox.CreateWnd;
begin
  inherited CreateWnd;
  UpdateScrollBar;
end;

function TbsSkinDBLookupListBox.GetKeyIndex: Integer;
var
  FieldValue: Variant;
begin
  if not VarIsNull(FKeyValue) then
    for Result := 0 to FRecordCount - 1 do
    begin
      ListLink.ActiveRecord := Result;
      FieldValue := FKeyField.Value;
      ListLink.ActiveRecord := FRecordIndex;
      if VarEquals(FieldValue, FKeyValue) then Exit;
    end;
  Result := -1;
end;

procedure TbsSkinDBLookupListBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  Delta, KeyIndex: Integer;
begin
  inherited KeyDown(Key, Shift);
  if CanModify then
  begin
    Delta := 0;
    case Key of
      VK_UP, VK_LEFT: Delta := -1;
      VK_DOWN, VK_RIGHT: Delta := 1;
      VK_PRIOR: Delta := 1 - FRowCount;
      VK_NEXT: Delta := FRowCount - 1;
      VK_HOME: Delta := -Maxint;
      VK_END: Delta := Maxint;
    end;
    if Delta <> 0 then
    begin
      SearchText := '';
      if Delta = -Maxint then ListLink.DataSet.First else
        if Delta = Maxint then ListLink.DataSet.Last else
        begin
          KeyIndex := GetKeyIndex;
          if KeyIndex >= 0 then
            ListLink.DataSet.MoveBy(KeyIndex - FRecordIndex)
          else
          begin
            KeyValueChanged;
            Delta := 0;
          end;
          ListLink.DataSet.MoveBy(Delta);
        end;
      SelectCurrent;
    end;
  end;
end;

procedure TbsSkinDBLookupListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  ProcessSearchKey(Key);
end;

procedure TbsSkinDBLookupListBox.KeyValueChanged;
begin
  if ListActive and not FLockPosition then
    if not LocateKey then ListLink.DataSet.First;
  if FListField <> nil then
    FSelectedItem := FListField.DisplayText else
    FSelectedItem := '';
end;

procedure TbsSkinDBLookupListBox.UpdateListFields;
begin
  try
    inherited;
  finally
    if ListActive then KeyValueChanged else ListLinkDataChanged;
  end;
end;

procedure TbsSkinDBLookupListBox.ListLinkDataChanged;
begin
  if ListActive then
  begin
    FRecordIndex := ListLink.ActiveRecord;
    FRecordCount := ListLink.RecordCount;
    FKeySelected := not VarIsNull(FKeyValue) or
      not ListLink.DataSet.BOF;
  end else
  begin
    FRecordIndex := 0;
    FRecordCount := 0;
    FKeySelected := False;
  end;
  if HandleAllocated then
  begin
    UpdateScrollBar;
    Invalidate;
  end;
end;

procedure TbsSkinDBLookupListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    SearchText := '';
    if not FPopup then
    begin
      SetFocus;
      if not HasFocus then Exit;
    end;
    if CanModify then
      if ssDouble in Shift then
      begin
        if FRecordIndex = Y div GetItemHeight then DblClick;
      end else
      begin
        MouseCapture := True;
        FTracking := True;
        SelectItemAt(X, Y);
      end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TbsSkinDBLookupListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FTracking then
  begin
    SelectItemAt(X, Y);
    FMousePos := Y;
    TimerScroll;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TbsSkinDBLookupListBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if FTracking then
  begin
    StopTracking;
    SelectItemAt(X, Y);
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TbsSkinDBLookupListBox.CreateControlDefaultImage(B: TBitMap);

procedure DrawDefaultItem(R: TRect; ASelected, AFocused: Boolean;
                          S: String);
begin
  if ASelected
  then
    with B.Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clHighLight;
      FillRect(R);
      Brush.Style := bsClear;
      Font.Color := clHighLightText;
    end
  else
    B.Canvas.Font.Color := DefaultFont.Color;
  //
  InflateRect(R, -2, -2);
  BSDrawText2(B.Canvas, S, R);
  InflateRect(R, 2, 2);
  //
  if AFocused
  then
    B.Canvas.DrawFocusRect(R);
end;

var
  I, J, LastFieldIndex: Integer;
  R: TRect;
  Selected: Boolean;
  Field: TField;
  S: String;
  W, TextWidth: Integer;
begin
  inherited;

  B.Width := GetItemWidth;

  with B.Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := clWindow;
    FillRect(ClientRect);
    Font := FDefaultFont;
    Brush.Style := bsClear;
  end;

  TextWidth := B.Canvas.TextWidth('0');

  R.Left := 0;
  R.Right := B.Width;
  LastFieldIndex := ListFields.Count - 1;
  for I := 0 to FRowCount - 1 do
  begin
    Selected := not FKeySelected and (I = 0);
    R.Top := I * GetItemHeight;
    R.Bottom := R.Top + GetItemHeight;
    if I < FRecordCount then
    begin
      ListLink.ActiveRecord := I;
      if not VarIsNull(FKeyValue) and
        VarEquals(FKeyField.Value, FKeyValue)
      then
        Selected := True;
      if LastFieldIndex = 0
      then
        begin
          Field := ListFields[0];
          DrawDefaultItem(R, Selected, Selected and (HasFocus or FPopup), Field.DisplayText);
        end
      else
        begin
          R.Left := 0;
          R.Right := 0;
          for J := 0 to LastFieldIndex do
          begin
            Field := ListFields[J];
            W := Field.DisplayWidth * TextWidth + 4;
            R.Right := R.Left + W;
            if R.Right > B.Width then R.Right := B.Width;
            if (J = LastFieldIndex) and (R.Right < B.Width)
            then R.Right := B.Width; 
            if RectWidth(R) > 0
            then
              DrawDefaultItem(R, Selected, Selected and (HasFocus or FPopup), Field.DisplayText);
            R.Left := R.Right;
          end;
        end;
    end;
  end;
  if FRecordCount <> 0 then ListLink.ActiveRecord := FRecordIndex;
end;

procedure TbsSkinDBLookupListBox.CreateControlSkinImage(B: TBitMap);

procedure DrawSkinItem(R: TRect; ASelected, AFocused: Boolean;
                       S: String);

var
  Buffer: TBitMap;
  TR: TRect;
begin
  if AFocused or ASelected
  then
    begin
      Buffer := TBitMap.Create;
      with Buffer.Canvas do
      begin
        if UseSkinFont
        then
          begin
            Font.Name := FontName;
            Font.Height := FontHeight;
            Font.Style := FontStyle;
          end
        else
          Font.Assign(DefaultFont);

       if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
       then
         Font.Charset := SkinData.ResourceStrData.CharSet
       else
         Font.CharSet := DefaultFont.CharSet;
          
        if AFocused
        then Font.Color := FocusFontColor
        else Font.Color := ActiveFontColor;
        Brush.Style := bsClear;
      end;
      if AFocused
      then
        CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
        FocusItemRect, RectWidth(R), RectHeight(R), StretchEffect)
      else
        CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
        ActiveItemRect, RectWidth(R), RectHeight(R), StretchEffect);
      TR := ItemTextRect;
      Inc(TR.Right, Buffer.Width - RectWidth(SItemRect));
      BSDrawText2(Buffer.Canvas, S, TR);
      B.Canvas.Draw(R.Left, R.Top, Buffer);
      Buffer.Free;
    end
  else
    begin
      B.Canvas.Brush.Style := bsClear;
      InflateRect(R, -2, -2);
      BSDrawText2(B.Canvas, S, R);
    end;
end;

procedure DrawStretchSkinItem(R: TRect; ASelected, AFocused: Boolean;
                       S: String);

var
  Buffer, Buffer2: TBitMap;
  TR: TRect;
  OX, OY: Integer;
begin
  if AFocused or ASelected
  then
    begin
      Buffer := TBitMap.Create;
      if AFocused
      then
        CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
        FocusItemRect, RectWidth(R), RectHeight(SItemRect), StretchEffect)
      else
        CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
        ActiveItemRect, RectWidth(R), RectHeight(SItemRect), StretchEffect);
      TR := ItemTextRect;
      OX :=  RectWidth(R) - RectWidth(SItemRect);
      OY :=  RectHeight(R) - RectHeight(SItemRect);
      Inc(TR.Right, OX);
      Inc(TR.Bottom, OY);

      Buffer2 := TBitMap.Create;
      Buffer2.Width := RectWidth(R);
      Buffer2.Height := RectHeight(R);
      Buffer2.Canvas.StretchDraw(Rect(0, 0, Buffer2.Width, Buffer2.Height), Buffer);
      Buffer.Free;
      with Buffer2.Canvas do
      begin
       if UseSkinFont
        then
          begin
            Font.Name := FontName;
            Font.Height := FontHeight;
            Font.Style := FontStyle;
          end
        else
          Font.Assign(DefaultFont);

       if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
       then
         Font.Charset := SkinData.ResourceStrData.CharSet
       else
         Font.CharSet := DefaultFont.CharSet;

        if AFocused
        then Font.Color := FocusFontColor
        else Font.Color := ActiveFontColor;
        Brush.Style := bsClear;
      end;
      BSDrawText2(Buffer2.Canvas, S, TR);
      B.Canvas.Draw(R.Left, R.Top, Buffer2);
      Buffer2.Free;
    end
  else
    begin
      InflateRect(R, -2, -2);
      B.Canvas.Brush.Style := bsClear;
      BSDrawText2(B.Canvas, S, R);
    end;
end;

procedure PaintBG;
var
  w, h, rw, rh, XCnt, YCnt, X, Y, XO, YO: Integer;
begin
  w := RectWidth(ClRect);
  h := RectHeight(ClRect);
  rw := B.Width;
  rh := B.Height;
  with B.Canvas do
  begin
    XCnt := rw div w;
    YCnt := rh div h;
    for X := 0 to XCnt do
    for Y := 0 to YCnt do
    begin
      if X * w + w > rw then XO := X * W + W - rw else XO := 0;
      if Y * h + h > rh then YO := Y * h + h - rh else YO := 0;
        CopyRect(Rect(X * w, Y * h,X * w + w - XO, Y * h + h - YO),
                 Picture.Canvas,
                 Rect(SkinRect.Left + ClRect.Left,
                 SkinRect.Top + ClRect.Top,
                 SkinRect.Left + ClRect.Right - XO,
                 SkinRect.Top + ClRect.Bottom - YO));
    end;
  end;
end;

var
  I, J, LastFieldIndex: Integer;
  R: TRect;
  Selected: Boolean;
  Field: TField;
  W, TextWidth: Integer;
begin

  B.Width := GetItemWidth;

  if FUseSkinFont
  then
    begin
      with B.Canvas do
      begin
        Font.Name := FontName;
        Font.Height := FontHeight;
        Font.Style := FontStyle;
        Font.Color := FontColor;
        Brush.Style := bsClear;
      end;
    end
  else
    B.Canvas.Font.Assign(FDefaultFont);

  B.Canvas.Font.Color := FontColor;
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    B.Canvas.Font.Charset := SkinData.ResourceStrData.CharSet
  else
    B.Canvas.Font.CharSet := DefaultFont.CharSet;

  TextWidth := B.Canvas.TextWidth('0');

  if not IsNullRect(ClRect) and (ClientWidth > 0) and (ClientHeight > 0)
  then
    PaintBG;
  R.Left := 0;
  R.Right := B.Width;
  LastFieldIndex := ListFields.Count - 1;
  for I := 0 to FRowCount - 1 do
  begin
    Selected := not FKeySelected and (I = 0);
    R.Top := I * GetItemHeight;
    R.Bottom := R.Top + GetItemHeight;
    if I < FRecordCount then
    begin
      ListLink.ActiveRecord := I;
      if not VarIsNull(FKeyValue) and
        VarEquals(FKeyField.Value, FKeyValue)
      then
        Selected := True;
      //
      if LastFieldIndex = 0
      then
        begin
          Field := ListFields[0];
          if FUseSkinItemHeight
          then
            DrawSkinItem(R, Selected, Selected and (HasFocus or FPopup), Field.DisplayText)
          else
            DrawStretchSkinItem(R, Selected, Selected and (HasFocus or FPopup), Field.DisplayText);
        end
      else
        begin
          R.Left := 0;
          R.Right := 0;
          for J := 0 to LastFieldIndex do
          begin
            Field := ListFields[J];
            W := Field.DisplayWidth * TextWidth + RectWidth(SItemRect) -
                 RectWidth(ItemTextRect);
            R.Right := R.Left + W;
            if R.Right > B.Width then R.Right := B.Width;
            if (J = LastFieldIndex) and (R.Right < B.Width)
            then R.Right := B.Width;
            if RectWidth(R) > 0
            then
              if FUseSkinItemHeight
              then
                DrawSkinItem(R, Selected, Selected and (HasFocus or FPopup), Field.DisplayText)
              else
                DrawStretchSkinItem(R, Selected, Selected and (HasFocus or FPopup), Field.DisplayText);
            R.Left := R.Right;
          end;
        end;
    end;
  end;
  if FRecordCount <> 0 then ListLink.ActiveRecord := FRecordIndex;
end;

procedure TbsSkinDBLookupListBox.SelectCurrent;
begin
  FLockPosition := True;
  try
    SelectKeyValue(FKeyField.Value);
  finally
    FLockPosition := False;
  end;
end;

procedure TbsSkinDBLookupListBox.SelectItemAt(X, Y: Integer);
var
  Delta: Integer;
begin
  if Y < 0 then Y := 0;
  if Y > ClientHeight then Y := ClientHeight;
  Delta := Y div GetItemHeight - FRecordIndex;
  ListLink.DataSet.MoveBy(Delta);
  SelectCurrent;
end;

procedure TbsSkinDBLookupListBox.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
    RowCount := RowCount;
  end;
end;

procedure TbsSkinDBLookupListBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  TextHeight, BorderHeight: Integer;
begin
  BorderHeight := GetBorderHeight;
  TextHeight := GetItemHeight;
  if Align = alNone
  then
    inherited SetBounds(ALeft, ATop, AWidth, FRowCount * TextHeight + BorderHeight)
  else
    begin
      FRowCount := (AHeight - BorderHeight) div TextHeight;
      inherited;
    end;
  if ListLink.BufferCount <> FRowCount then
  begin
    ListLink.BufferCount := FRowCount;
    ListLinkDataChanged;
  end;
  if HandleAllocated
  then
  SendMessage(Handle, WM_NCPAINT, 0, 0);
  AlignScrollBar;
end;

function TbsSkinDBLookupListBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBLookupListBox.SetRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 100 then Value := 100;
  FRowCount := Value;
  Height := Value * GetItemHeight;
end;

procedure TbsSkinDBLookupListBox.StopTimer;
begin
  if FTimerActive then
  begin
    KillTimer(Handle, 1);
    FTimerActive := False;
  end;
end;

procedure TbsSkinDBLookupListBox.StopTracking;
begin
  if FTracking then
  begin
    StopTimer;
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TbsSkinDBLookupListBox.TimerScroll;
var
  Delta, Distance, Interval: Integer;
begin
  Delta := 0;
  Distance := 0;
  if FMousePos < 0 then
  begin
    Delta := -1;
    Distance := -FMousePos;
  end;
  if FMousePos >= ClientHeight then
  begin
    Delta := 1;
    Distance := FMousePos - ClientHeight + 1;
  end;
  if Delta = 0 then StopTimer else
  begin
    if ListLink.DataSet.MoveBy(Delta) <> 0 then SelectCurrent;
    Interval := 200 - Distance * 15;
    if Interval < 0 then Interval := 0;
    SetTimer(Handle, 1, Interval, nil);
    FTimerActive := True;
  end;
end;

procedure TbsSkinDBLookupListBox.UpdateScrollBar;
var
  Pos, Max: Integer;
  ScrollInfo: TScrollInfo;
begin
  Pos := 0;
  Max := 0;

  if (FRowCount <> FRecordCount) or (KeyField = '') or
     (ListLink.DataSet = nil)
  then HideScrollBar
  else ShowScrollBar;

  if (FScrollBar <> nil)
  then
    begin
      if FRecordCount = FRowCount then
      begin
        Max := 4;
        if not ListLink.DataSet.BOF then
        if not ListLink.DataSet.EOF then Pos := 2 else Pos := 4;
      end;
      FScrollBar.SetRange(0, Max, Pos, 0);
    end;
end;

procedure TbsSkinDBLookupListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Height := Height;
end;

procedure TbsSkinDBLookupListBox.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TbsSkinDBLookupListBox.WMTimer(var Message: TMessage);
begin
  TimerScroll;
end;

procedure TbsSkinDBLookupListBox.WMVScroll(var Message: TWMVScroll);
begin
  SearchText := '';
  if ListLink.DataSet = nil then
    Exit;
  with Message, ListLink.DataSet do
    case ScrollCode of
      SB_LINEUP: MoveBy(-FRecordIndex - 1);
      SB_LINEDOWN: MoveBy(FRecordCount - FRecordIndex);
      SB_PAGEUP: MoveBy(-FRecordIndex - FRecordCount + 1);
      SB_PAGEDOWN: MoveBy(FRecordCount - FRecordIndex + FRecordCount - 2);
      SB_THUMBPOSITION:
        begin
          case Pos of
            0: First;
            1: MoveBy(-FRecordIndex - FRecordCount + 1);
            2: Exit;
            3: MoveBy(FRecordCount - FRecordIndex + FRecordCount - 2);
            4: Last;
          end;
        end;
      SB_BOTTOM: Last;
      SB_TOP: First;
    end;
end;

function TbsSkinDBLookupListBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBLookupListBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TbsPopupDataList }

constructor TbsPopupDataList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  FPopup := True;
end;

procedure TbsPopupDataList.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TbsPopupDataList.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

{ TbsSkinDBLookupComboBox }

constructor TbsSkinDBLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDefaultColor := clWindow;
  Width := 145;
  Height := 20;
  FDataList := TbsPopupDataList.Create(Self);
  FDataList.Visible := False;
  FDataList.TabStop := False;
  FDataList.Parent := Self;
  FDataList.OnMouseUp := ListMouseUp;
  FButtonWidth := 17;
  FDropDownRows := 7;
  FDefaultHeight := 20;
  FSkinDataName := 'combobox';
  FMouseIn := False;
end;

procedure TbsSkinDBLookupComboBox.SetDefaultColor(Value: TColor);
begin
  FDefaultColor := Value;
  if FIndex = -1 then Invalidate;
end;

procedure TbsSkinDBLookupComboBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseIn := True;
  if (FIndex <> -1) and not IsNullRect(ActiveSkinRect) then Invalidate;
end;

procedure TbsSkinDBLookupComboBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseIn := False;
  if (FIndex <> -1) and not IsNullRect(ActiveSkinRect) then Invalidate;
end;


function TbsSkinDBLookupComboBox.GetListBoxDefaultItemHeight: Integer;
begin
  Result := FDataList.DefaultItemHeight;
end;

procedure TbsSkinDBLookupComboBox.SetListBoxDefaultItemHeight(Value: Integer);
begin
  FDataList.DefaultItemHeight := Value;
end;

function TbsSkinDBLookupComboBox.GetListBoxUseSkinFont: Boolean;
begin
  Result := FDataList.UseSkinFont;
end;

procedure TbsSkinDBLookupComboBox.SetListBoxUseSkinFont(Value: Boolean);
begin
  FDataList.UseSkinFont := Value;
end;

function TbsSkinDBLookupComboBox.GetListBoxUseSkinItemHeight: Boolean;
begin
  Result := FDataList.UseSkinItemHeight;
end;

procedure TbsSkinDBLookupComboBox.SetListBoxUseSkinItemHeight(Value: Boolean);
begin
  FDataList.UseSkinItemHeight := Value;
end;

procedure TbsSkinDBLookupComboBox.GetSkinData;
begin
  inherited;
  if FIndex <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[FIndex]) is TbsDataSkinComboBox
    then
      with TbsDataSkinComboBox(FSD.CtrlList.Items[FIndex]) do
      begin
        Self.ActiveSkinRect := ActiveSkinRect;
        Self.SItemRect := SItemRect;
        Self.ActiveItemRect := ActiveItemRect;
        Self.FocusItemRect := FocusItemRect;
        if isNullRect(FocusItemRect)
        then
          Self.FocusItemRect := SItemRect;
        Self.ItemLeftOffset := ItemLeftOffset;
        Self.ItemRightOffset := ItemRightOffset;
        Self.ItemTextRect := ItemTextRect;

        Self.FontName := FontName;
        Self.FontStyle := FontStyle;
        Self.FontHeight := FontHeight;
        Self.FontColor := FontColor;
        Self.FocusFontColor := FocusFontColor;
        Self.ActiveFontColor := ActiveFontColor;

        Self.ButtonRect := ButtonRect;
        Self.ActiveButtonRect := ActiveButtonRect;
        Self.DownButtonRect := DownButtonRect;

        Self.StretchEffect := StretchEffect;
        Self.ItemStretchEffect := ItemStretchEffect;
        Self.FocusItemStretchEffect := FocusItemStretchEffect;
        Self.UnEnabledButtonRect := UnEnabledButtonRect;

        Self.ListBoxName := ListBoxName;
      end;
end;

procedure TbsSkinDBLookupComboBox.CloseUp(Accept: Boolean);
var
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    SetFocus;
    ListValue := FDataList.KeyValue;
    SetWindowPos(FDataList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    FDataList.Visible := False;
    FDataList.ListSource := nil;
    Invalidate;
    SearchText := '';
    if Accept and CanModify then SelectKeyValue(ListValue);
    if Assigned(FOnCloseUp) then FOnCloseUp(Self);
  end;
end;

procedure TbsSkinDBLookupComboBox.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) and FListVisible then
  begin
    CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

procedure TbsSkinDBLookupComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TbsSkinDBLookupComboBox.DropDown;
var
  P: TPoint;
  I, Y: Integer;
  S: string;
  ADropDownAlign: TDropDownAlign;
begin
  if not FListVisible and ListActive then
  begin
    if Assigned(FOnDropDown) then FOnDropDown(Self);
    if FDropDownWidth > 0 then
      FDataList.Width := FDropDownWidth else
      FDataList.Width := Width;
    FDataList.ReadOnly := not CanModify;
    if (ListLink.DataSet.RecordCount > 0) and
       (FDropDownRows > ListLink.DataSet.RecordCount) then
      FDataList.RowCount := ListLink.DataSet.RecordCount else
      FDataList.RowCount := FDropDownRows;
    FDataList.KeyField := FKeyFieldName;
    for I := 0 to ListFields.Count - 1 do
      S := S + TField(ListFields[I]).FieldName + ';';
    FDataList.ListField := S;
    FDataList.ListFieldIndex := ListFields.IndexOf(FListField);
    FDataList.ListSource := ListLink.DataSource;
    FDataList.KeyValue := KeyValue;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FDataList.Height > Screen.Height then Y := P.Y - FDataList.Height;
    ADropDownAlign := FDropDownAlign;
    { This alignment is for the ListField, not the control }
    if DBUseRightToLeftAlignment(Self, FListField) then
    begin
      if ADropDownAlign = daLeft then
        ADropDownAlign := daRight
      else if ADropDownAlign = daRight then
        ADropDownAlign := daLeft;
    end;
    case ADropDownAlign of
      daRight: Dec(P.X, FDataList.Width - Width);
      daCenter: Dec(P.X, (FDataList.Width - Width) div 2);
    end;
    FDataList.DefaultFont := DefaultFont;
    if FIndex = -1
    then
      begin
        FDataList.SkinDataName := ''
      end
    else
      FDataList.SkinDataName := ListBoxName;
    FDataList.SkinData := SkinData;
    SetWindowPos(FDataList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    FDataList.Visible := True;
    Repaint;
  end;
end;

procedure TbsSkinDBLookupComboBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  Delta: Integer;
begin
  inherited KeyDown(Key, Shift);
  if ListActive and ((Key = VK_UP) or (Key = VK_DOWN)) then
    if ssAlt in Shift then
    begin
      if FListVisible then CloseUp(True) else DropDown;
      Key := 0;
    end else
      if not FListVisible then
      begin
        if not LocateKey then
          ListLink.DataSet.First
        else
        begin
          if Key = VK_UP then Delta := -1 else Delta := 1;
          ListLink.DataSet.MoveBy(Delta);
        end;
        SelectKeyValue(FKeyField.Value);
        Key := 0;
      end;
  if (Key <> 0) and FListVisible then FDataList.KeyDown(Key, Shift);
end;

procedure TbsSkinDBLookupComboBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FListVisible then
    if Key in [#13, #27] then
      CloseUp(Key = #13)
    else
      FDataList.KeyPress(Key)
  else
    ProcessSearchKey(Key);
end;

procedure TbsSkinDBLookupComboBox.KeyValueChanged;
begin
  if FLookupMode then
  begin
    FText := FDataField.DisplayText;
    FAlignment := FDataField.Alignment;
  end else
  if ListActive and LocateKey then
  begin
    FText := FListField.DisplayText;
    FAlignment := FListField.Alignment;
  end else
  begin
    FText := '';
    FAlignment := taLeftJustify;
  end;
  Invalidate;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TbsSkinDBLookupComboBox.UpdateListFields;
begin
  inherited;
  KeyValueChanged;
end;

procedure TbsSkinDBLookupComboBox.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FDataList.ClientRect, Point(X, Y)));
end;

procedure TbsSkinDBLookupComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    SetFocus;
    if not HasFocus then Exit;
    if FListVisible then CloseUp(False) else
      if ListActive then
      begin
        MouseCapture := True;
        FTracking := True;
        TrackButton(X, Y);
        DropDown;
      end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TbsSkinDBLookupComboBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if FListVisible then
    begin
      ListPos := FDataList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FDataList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FDataList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TbsSkinDBLookupComboBox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  StopTracking;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TbsSkinDBLookupComboBox.CreateControlSkinImage;

function GetDisabledFontColor: TColor;
var
  i: Integer;
begin
  i := -1;
  if FIndex <> -1 then i := SkinData.GetControlIndex('edit');
  if i = -1
  then
    Result := clGrayText
  else
    Result := TbsDataSkinEditControl(SkinData.CtrlList[i]).DisabledFontColor;
end;


var
  OX: Integer;
  Text: string;
  Selected: Boolean;
  R, R1: TRect;
  TX, TY: Integer;
  Buffer: TBitMap;
begin
  if not IsNullRect(ActiveSkinRect) and (FMouseIn or Focused)
  then
    CreateHSkinImage(LTPt.X, RectWidth(ActiveSkinRect) - RTPt.X,
          B, Picture, ActiveSkinRect, Width, RectHeight(ActiveSkinRect), False)
  else
    inherited;
  with B.Canvas do
  begin
    Brush.Style := bsClear;
    if FUseSkinFont
    then
      begin
        Font.Name := FontName;
        Font.Style := FontStyle;
        Font.Height := FontHeight;
      end
    else
      Font.Assign(FDefaultFont);
    if FMouseIn and not IsNullRect(ActiveSkinRect)
    then
      Font.Color := ActiveFontColor
    else
      Font.Color := FontColor;

    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.CharSet
    else
      Font.CharSet := DefaultFont.CharSet;
  end;

  // calc rects
  OX := Width - RectWidth(SkinRect);
  FButtonRect := ButtonRect;
  if ButtonRect.Left >= RectWidth(SkinRect) - RTPt.X
  then
    OffsetRect(FButtonRect, OX, 0);
  FItemRect := ClRect;
  Inc(FItemRect.Right, OX);
  // draw button
  R1 := NullRect;
  if not Enabled and not IsNullRect(UnEnabledButtonRect)
  then
    R1 := UnEnabledButtonRect
  else
  if FPressed and not IsNullRect(DownButtonRect)
  then R1 := DownButtonRect
  else if FMouseIn then R1 := ActiveButtonRect;
  if not IsNullRect(R1)
  then
    B.Canvas.CopyRect(FButtonRect, Picture.Canvas, R1);
  // draw item
  if (csPaintCopy in ControlState) and (FDataField <> nil) and
    (FDataField.Lookup)
  then
    Text := FDataField.DisplayText
  else
    begin
      if (csDesigning in ComponentState) and (FDataField = nil) then
      Text := Name else
      Text := FText;
    end;
  Selected := HasFocus and not FListVisible and
    not (csPaintCopy in ControlState);
  if Selected and not IsNullRect(FocusItemRect)
  then
    begin
      Buffer := TBitMap.Create;
      if not IsNullRect(FocusItemRect)
      then
        CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
          FocusItemRect, RectWidth(FItemRect), RectHeight(FocusItemRect), FocusItemStretchEffect);
      B.Canvas.Draw(FItemRect.Left, FItemRect.Top, Buffer);
      Buffer.Free;
      R := ItemTextRect;
      Inc(R.Right, RectWidth(FItemRect) - RectWidth(FocusItemRect));
      OffsetRect(R, FItemRect.Left, FItemRect.Top);
      B.Canvas.Font.Color := FocusFontColor;
    end
  else
    if FMouseIn and not IsNullRect(ActiveSkinRect) and not IsNullrect(ActiveItemRect)
    then
      begin
        Buffer := TBitMap.Create;
        CreateHSkinImage(ItemLeftOffset, ItemRightOffset, Buffer, Picture,
           ActiveItemRect, RectWidth(FItemRect), RectHeight(ActiveItemRect), ItemStretchEffect);
        B.Canvas.Draw(FItemRect.Left, FItemRect.Top, Buffer);
        Buffer.Free;
        R := FItemRect;
      end
    else
      R := FItemRect;
  TX := R.Left + 2;
  TY := R.Top + RectHeight(R) div 2 - B.Canvas.TextHeight(Text) div 2;
  if not Enabled then B.Canvas.Font.Color := GetDisabledFontColor;
  B.Canvas.TextRect(R, TX, TY, Text);
end;

procedure TbsSkinDBLookupComboBox.CreateControlDefaultImage;
var
  W, X, Flags: Integer;
  Text: string;
  Selected: Boolean;
  R: TRect;
  TX, TY: Integer;
begin
  with B.Canvas do
  begin
    Brush.Color := clBtnFace;
    Brush.Style := bsSolid;
    R := ClientRect;
    FillRect(R);
    Font := DefaultFont;
  end;
  // frame
  Frame3D(B.Canvas, R, clbtnShadow, clbtnShadow, 1);
  // button
  R := Rect(Width - 2 - FButtonWidth, 2, Width - 2, Height - 2);
  if FPressed
  then
    begin
      Frame3D(B.Canvas, R, BS_XP_BTNFRAMECOLOR, BS_XP_BTNFRAMECOLOR,  1);
      B.Canvas.Brush.Color := BS_XP_BTNDOWNCOLOR;
      B.Canvas.FillRect(R);
    end
  else
    Frame3D(B.Canvas, R, clbtnShadow, clbtnShadow, 1);
  if Enabled
  then
    DrawArrowImage(B.Canvas, R, clBtnText, 4)
  else
    DrawArrowImage(B.Canvas, R, clBtnShadow, 4);
  // item
  if (csPaintCopy in ControlState) and (FDataField <> nil) and
    (FDataField.Lookup)
  then
    Text := FDataField.DisplayText
  else
    begin
      if (csDesigning in ComponentState) and (FDataField = nil) then
      Text := Name else
      Text := FText;
    end;

  Selected := HasFocus and not FListVisible and
    not (csPaintCopy in ControlState);

  if Enabled then
    B.Canvas.Font.Color := Font.Color
  else
    B.Canvas.Font.Color := clGrayText;
  if Selected
  then
    begin
     B.Canvas.Font.Color := clHighlightText;
     B.Canvas.Brush.Color := clHighlight;
    end
  else
    B.Canvas.Brush.Color := FDefaultColor;
  TX := 4;
  TY := Height div 2 - B.Canvas.TextHeight(Text) div 2;
  R := Rect(2, 2, Width - 2 - FButtonWidth, Height - 2);
  B.Canvas.TextRect(R, TX, TY, Text);
  if Selected then B.Canvas.DrawFocusRect(R);
end;

procedure TbsSkinDBLookupComboBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
end;

function TbsSkinDBLookupComboBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBLookupComboBox.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TbsSkinDBLookupComboBox.TrackButton(X, Y: Integer);
var
  NewState: Boolean;
  BR: TRect;
begin
  if FIndex = -1
  then
    NewState := PtInRect(Rect(ClientWidth - FButtonWidth - 2, 2, ClientWidth - 2,
                         ClientHeight - 2), Point(X, Y))
  else
    begin
      BR := FButtonRect;
      Inc(BR.Right);
      Inc(BR.Bottom);
      NewState := PtInRect(BR, Point(X, Y));
    end;
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    Repaint;
  end;
end;

procedure TbsSkinDBLookupComboBox.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FDataList) and
     (Message.Sender <> FDataList.FScrollBar)
  then
    CloseUp(False);
end;

procedure TbsSkinDBLookupComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
end;

procedure TbsSkinDBLookupComboBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TbsSkinDBLookupComboBox.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TbsSkinDBLookupComboBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  CloseUp(False);
end;

function TbsSkinDBLookupComboBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBLookupComboBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ TbsSkinDBRichEdit }

constructor TbsSkinDBRichEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TbsSkinDBRichEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBRichEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBRichEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBRichEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBRichEdit.BeginEditing;
begin
  if not FDataLink.Editing then
  try
    if FDataLink.Field.IsBlob then
      FDataSave := FDataLink.Field.AsString;
    FDataLink.Edit;
  finally
    FDataSave := '';
  end;
end;

procedure TbsSkinDBRichEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or (Key = VK_BACK) or
      ((Key = VK_INSERT) and (ssShift in Shift)) or
      (((Key = Ord('V')) or (Key = Ord('X'))) and (ssCtrl in Shift)) then
      BeginEditing;
  end;
end;

procedure TbsSkinDBRichEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        BeginEditing;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key := #0;
  end;
end;

procedure TbsSkinDBRichEdit.Change;
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

function TbsSkinDBRichEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBRichEdit.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBRichEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBRichEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBRichEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBRichEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBRichEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBRichEdit.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
  begin
    try
      Lines.Assign(FDataLink.Field);
      FMemoLoaded := True;
    except
      { Rich Edit Load failure }
      on E:EOutOfResources do
        Lines.Text := Format('(%s)', [E.Message]);
    end;
    EditingChange(Self);
  end;
end;

procedure TbsSkinDBRichEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
    begin
      if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
      begin
        { Check if the data has changed since we read it the first time }
        if (FDataSave <> '') and (FDataSave = FDataLink.Field.AsString) then Exit;
        FMemoLoaded := False;
        LoadMemo;
      end else
      begin
        Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
        FMemoLoaded := False;
      end;
    end else
    begin
      if FFocused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
        Text := FDataLink.Field.DisplayText;
      FMemoLoaded := True;
    end
  else
  begin
    if csDesigning in ComponentState then Text := Name else Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TbsSkinDBRichEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

procedure TbsSkinDBRichEdit.UpdateData(Sender: TObject);
begin
  if FDataLink.Field.IsBlob then
    FDataLink.Field.Assign(Lines) else
    FDataLink.Field.AsString := Text;
end;

procedure TbsSkinDBRichEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

procedure TbsSkinDBRichEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;

  if FDataLink.CanModify then
    inherited ReadOnly := False;

  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBRichEdit.CMExit(var Message: TCMExit);
begin
  try
    if FDataLink.Editing then FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TbsSkinDBRichEdit.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TbsSkinDBRichEdit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TbsSkinDBRichEdit.WMCut(var Message: TMessage);
begin
  BeginEditing;
  inherited;
end;

procedure TbsSkinDBRichEdit.WMPaste(var Message: TMessage);
begin
  BeginEditing;
  inherited;
end;

procedure TbsSkinDBRichEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;


function TbsSkinDBRichEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBRichEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

constructor TbsSkinDBCalcEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBCalcEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBCalcEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBCalcEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBCalcEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TbsSkinDBCalcEdit.Change;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit; 
      FDataLink.Modified;
      inherited Change;
    end;
  FInChange := False;
end;

function TbsSkinDBCalcEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBCalcEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBCalcEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBCalcEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBCalcEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBCalcEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBCalcEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBCalcEdit.DataChange(Sender: TObject);
begin
  FInDataChange := True; 
  if not FInChange then
  if FDataLink.Field <> nil
  then
    begin
      if (FDataLink.Field.Text <> '') and IsNumText(FDataLink.Field.Text)
      then
        Text := FDataLink.Field.Text
      else
        Value := MinValue;
    end
  else
    Value := MinValue;
  FInDataChange := False;
end;

procedure TbsSkinDBCalcEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBCalcEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

procedure TbsSkinDBCalcEdit.CMEnter;
begin
  inherited;
  inherited ReadOnly := not FDataLink.CanModify;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBCalcEdit.CMExit;
begin
  inherited;
  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
end;

procedure TbsSkinDBCalcEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBCalcEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBCalcEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

constructor TbsSkinDBMemo2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FAutoDisplay := True;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FPaintControl := TPaintControl.Create(Self, 'EDIT');
end;

destructor TbsSkinDBMemo2.Destroy;
begin
  FPaintControl.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBMemo2.WMPaint(var Message: TWMPaint);
var
  S: string;
begin
  if not (csPaintCopy in ControlState) then inherited else
  begin
    if FDataLink.Field <> nil then
      if FDataLink.Field.IsBlob then
      begin
        if FAutoDisplay then
          S := AdjustLineBreaks(FDataLink.Field.AsString) else
          S := Format('(%s)', [FDataLink.Field.DisplayLabel]);
      end else
        S := FDataLink.Field.DisplayText;
    SendMessage(FPaintControl.Handle, WM_SETTEXT, 0, Integer(PChar(S)));
    SendMessage(FPaintControl.Handle, WM_ERASEBKGND, Message.DC, 0);
    SendMessage(FPaintControl.Handle, WM_PAINT, Message.DC, 0);
  end;
end;

procedure TbsSkinDBMemo2.Loaded;
begin
  inherited Loaded;
//  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBMemo2.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBMemo2.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBMemo2.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if FMemoLoaded then
  begin
    if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
      FDataLink.Edit;
  end;
end;

procedure TbsSkinDBMemo2.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if FMemoLoaded then
  begin
    if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
      not FDataLink.Field.IsValidChar(Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^I, ^J, ^M, ^V, ^X, #32..#255:
        FDataLink.Edit;
      #27:
        FDataLink.Reset;
    end;
  end else
  begin
    if Key = #13 then LoadMemo;
    Key := #0;
  end;
end;

procedure TbsSkinDBMemo2.Change;
begin
  if FMemoLoaded then FDataLink.Modified;
  FMemoLoaded := True;
  inherited Change;
end;

function TbsSkinDBMemo2.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBMemo2.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBMemo2.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBMemo2.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBMemo2.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBMemo2.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBMemo2.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBMemo2.LoadMemo;
begin
  if not FMemoLoaded and Assigned(FDataLink.Field) and FDataLink.Field.IsBlob then
  begin
    try
      Lines.Text := FDataLink.Field.AsString;
      FMemoLoaded := True;
    except
      { Memo too large }
      on E:EInvalidOperation do
        Lines.Text := Format('(%s)', [E.Message]);
    end;
    EditingChange(Self);
  end;
end;

procedure TbsSkinDBMemo2.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    if FDataLink.Field.IsBlob then
    begin
      if FAutoDisplay or (FDataLink.Editing and FMemoLoaded) then
      begin
        FMemoLoaded := False;
        LoadMemo;
      end else
      begin
        Text := Format('(%s)', [FDataLink.Field.DisplayLabel]);
        FMemoLoaded := False;
      end;
    end else
    begin
      if FFocused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
        Text := FDataLink.Field.DisplayText;
      FMemoLoaded := True;
    end
  else
  begin
    if csDesigning in ComponentState then Text := Name else Text := '';
    FMemoLoaded := False;
  end;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE or RDW_FRAME);
end;

procedure TbsSkinDBMemo2.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not (FDataLink.Editing and FMemoLoaded);
end;

procedure TbsSkinDBMemo2.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsString := Text;
end;

procedure TbsSkinDBMemo2.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if not Assigned(FDataLink.Field) or not FDataLink.Field.IsBlob then
      FDataLink.Reset;
  end;
end;

procedure TbsSkinDBMemo2.WndProc(var Message: TMessage);
begin
  inherited;
end;

procedure TbsSkinDBMemo2.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if FDataLink.CanModify then
    inherited ReadOnly := False;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBMemo2.CMExit(var Message: TCMExit);
begin
  try
    if FDataLink.Editing then FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  inherited;
end;

procedure TbsSkinDBMemo2.SetAutoDisplay(Value: Boolean);
begin
  if FAutoDisplay <> Value then
  begin
    FAutoDisplay := Value;
    if Value then LoadMemo;
  end;
end;

procedure TbsSkinDBMemo2.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not FMemoLoaded then LoadMemo else inherited;
end;

procedure TbsSkinDBMemo2.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBMemo2.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBMemo2.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBMemo2.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBMemo2.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBMemo2.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

constructor TbsSkinDBDateEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
  FAllowNullData := False;
end;

destructor TbsSkinDBDateEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBDateEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBDateEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBDateEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TbsSkinDBDateEdit.Change;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify and not (csDesigning in ComponentState)
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit;
      FDataLink.Modified;
      inherited Change;
    end;
  FInChange := False;
end;

function TbsSkinDBDateEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBDateEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBDateEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBDateEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBDateEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBDateEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBDateEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBDateEdit.DataChange(Sender: TObject);
begin
  FInDataChange := True;
  if not FInChange then
  if FDataLink.Field <> nil
  then
    begin
      if (FDataLink.Field.Text <> '') and
      IsValidText(FDataLink.Field.Text)
      then
        Date := StrToDate(FDataLink.Field.Text)
      else
        begin
          if ToDayDefault then Date := Now;
          Text := '';
        end;
    end;
  FInDataChange := False;
end;

procedure TbsSkinDBDateEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBDateEdit.UpdateData(Sender: TObject);
begin
  if not (csDesigning in ComponentState)
  then
    FDataLink.Field.Text := Text;
end;

procedure TbsSkinDBDateEdit.CMEnter;
begin
  inherited;
  if FDataLink.CanModify then
    inherited ReadOnly := False;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBDateEdit.CMExit;
begin
  inherited;
  if (FDataLink <> nil) and (FDataLink.Editing) and
     not Self.IsDateInput and FAllowNullData
  then
    FDataLink.Field.Value := Null;

  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
end;

procedure TbsSkinDBDateEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBDateEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBDateEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

constructor TbsSkinDBTimeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBTimeEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBTimeEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBTimeEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBTimeEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TbsSkinDBTimeEdit.Change;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit;
      FDataLink.Modified;
      inherited Change;
    end;
  FInChange := False;
end;

function TbsSkinDBTimeEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBTimeEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBTimeEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBTimeEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBTimeEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBTimeEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBTimeEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBTimeEdit.DataChange(Sender: TObject);
begin
  FInDataChange := True;
  if not FInChange then
  if FDataLink.Field <> nil
  then
    Text := FDataLink.Field.Text;
  FInDataChange := False;
end;

procedure TbsSkinDBTimeEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBTimeEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

procedure TbsSkinDBTimeEdit.CMEnter;
begin
  inherited;
  if FDataLink.CanModify then
    inherited ReadOnly := False;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBTimeEdit.CMExit;
begin
  inherited;
  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
end;

procedure TbsSkinDBTimeEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBTimeEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBTimeEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

constructor TbsSkinDBPasswordEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBPasswordEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TbsSkinDBPasswordEdit.GetPaintText;
begin
  if csPaintCopy in ControlState
  then
    begin
      if FDataLink.Field <> nil
      then
        Result := FDataLink.Field.AsString
      else
        inherited GetPaintText;
    end
  else
    inherited GetPaintText;
end;

procedure TbsSkinDBPasswordEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBPasswordEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBPasswordEdit.Change;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit;
      FDataLink.Modified;
      inherited Change;
    end;
  FInChange := False;
end;

function TbsSkinDBPasswordEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBPasswordEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBPasswordEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBPasswordEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBPasswordEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBPasswordEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBPasswordEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBPasswordEdit.DataChange(Sender: TObject);
begin
  FInDataChange := True;
  if not FInChange then
  if FDataLink.Field <> nil
  then
    Text := FDataLink.Field.Text;
  FInDataChange := False;
end;

procedure TbsSkinDBPasswordEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBPasswordEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

procedure TbsSkinDBPasswordEdit.CMEnter;
begin
  inherited;
  if FDataLink.CanModify then
    inherited ReadOnly := False;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBPasswordEdit.CMExit;
begin
  inherited;
  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
end;

procedure TbsSkinDBPasswordEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBPasswordEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBPasswordEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

//////

constructor TbsSkinDBNumericEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBNumericEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBNumericEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBNumericEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBNumericEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TbsSkinDBNumericEdit.Change;
begin
  inherited;  
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit; 
      FDataLink.Modified;
    end;
  FInChange := False;
end;

function TbsSkinDBNumericEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBNumericEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBNumericEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBNumericEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBNumericEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBNumericEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBNumericEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBNumericEdit.DataChange(Sender: TObject);
begin
  FInDataChange := True; 
  if not FInChange then
  if FDataLink.Field <> nil
  then
    begin
      if (FDataLink.Field.Text <> '') and IsNumText(FDataLink.Field.Text)
      then
        Text := FDataLink.Field.Text
      else
        Value := MinValue;
    end
  else
    Value := MinValue;
  FInDataChange := False;
end;

procedure TbsSkinDBNumericEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBNumericEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

procedure TbsSkinDBNumericEdit.CMEnter;
begin
  inherited;
  inherited ReadOnly := not FDataLink.CanModify;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBNumericEdit.CMExit;
begin
  inherited;
  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
end;

procedure TbsSkinDBNumericEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBNumericEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBNumericEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

// TbsSkinDBGauge

function IsNumText(AText: String): Boolean;

function GetMinus: Boolean;
var
  i: Integer;
  S: String;
begin
  S := AText;
  i := Pos('-', S);
  if i > 1
  then
    Result := False
  else
    begin
      Delete(S, i, 1);
      Result := Pos('-', S) = 0;
    end;
end;

function GetP: Boolean;
var
  i: Integer;
  S: String;
begin
  S := AText;
  i := Pos(DecimalSeparator, S);
  if i = 1
  then
    Result := False
  else
    begin
      Delete(S, i, 1);
      Result := Pos(DecimalSeparator, S) = 0;
    end;
end;

const
  EditChars = '01234567890-';
var
  i: Integer;
  S: String;
begin
  S := EditChars;
  Result := True;
  S := S + DecimalSeparator;
  if (AText = '') or (AText = '-')
  then
    begin
      Result := False;
      Exit;
    end;

  for i := 1 to Length(AText) do
  begin
    if Pos(AText[i], S) = 0
    then
      begin
        Result := False;
        Break;
      end;
  end;

  Result := Result and GetMinus and GetP;

end;


constructor TbsSkinDBGauge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBGauge.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TbsSkinDBGauge.GetPaintValue: Integer;
begin
  if csPaintCopy in ControlState
  then
    begin
      if FDataLink.Field <> nil
      then
        Result := FDataLink.Field.AsInteger
      else
        Result := inherited GetPaintValue;
    end
  else
    Result := inherited GetPaintValue;
end;

procedure TbsSkinDBGauge.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBGauge.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBGauge.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBGauge.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBGauge.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBGauge.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBGauge.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBGauge.DataChange(Sender: TObject);
var
  D: Double;
begin
  if FDataLink.Field <> nil
  then
    begin
      if (FDataLink.Field.Text <> '') and IsNumText(FDataLink.Field.Text)
      then
        begin
          if Pos(DecimalSeparator, FDataLink.Field.Text) <> 0
          then
            begin
              D := StrToFloat(FDataLink.Field.Text);
              Value := Trunc(D);
            end  
          else
            Value := StrToInt(FDataLink.Field.Text)
        end
      else
        Value := MinValue;
    end
  else
    Value := MinValue;
end;

procedure TbsSkinDBGauge.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBGauge.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBGauge.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

//  TbsSkinDBSlider

constructor TbsSkinDBSlider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBSlider.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TbsSkinDBSlider.GetSliderValue;
begin
  if csPaintCopy in ControlState
  then
    begin
      if FDataLink.Field <> nil
      then
        Result := FDataLink.Field.AsVariant
      else
        Result := inherited GetSliderValue;
    end
  else
    Result := inherited GetSliderValue;
end;

procedure TbsSkinDBSlider.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBSlider.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBSlider.Change;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit; 
      FDataLink.Modified;
      inherited Change;
    end;
  FInChange := False;
end;

function TbsSkinDBSlider.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBSlider.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBSlider.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBSlider.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBSlider.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBSlider.DataChange(Sender: TObject);
var
  D: Double;
begin
  FInDataChange := True; 
  if not FInChange then
  if FDataLink.Field <> nil
  then
    begin
      if (FDataLink.Field.Text <> '') and IsNumText(FDataLink.Field.Text)
      then
        begin
          if Pos(DecimalSeparator, FDataLink.Field.Text) <> 0
          then
            begin
              D := StrToFloat(FDataLink.Field.Text);
              Value := Trunc(D);
            end
          else
            Value := StrToInt(FDataLink.Field.Text)
        end
      else
        Value := MinValue;
    end
  else
    Value := MinValue;
  FInDataChange := False;
end;

procedure TbsSkinDBSlider.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := IntToStr(Value);
end;

procedure TbsSkinDBSlider.CMEnter;
begin
  inherited;
end;

procedure TbsSkinDBSlider.CMExit;
begin
  inherited;
  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
end;

procedure TbsSkinDBSlider.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBSlider.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBSlider.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TbsSkinDBMRUComboBox.AddMRUItem(Value: String);
var
  I: Integer;
begin
  if Value = '' then Exit;
  I := Items.IndexOf(Value);
  if I <> -1
  then
    Items.Move(I, 0)
  else
    Items.Insert(0, Value);
end;

// TbsSkinDBCtrlDrid ===========================================================

{ TDBCtrlGridLink }

constructor TbsDBCtrlGridLink.Create(DBCtrlGrid: TbsSkinDBCtrlGrid);
begin
  inherited Create;
  FDBCtrlGrid := DBCtrlGrid;
  VisualControl := True;
  RPR;
end;

procedure TbsDBCtrlGridLink.ActiveChanged;
begin
  FDBCtrlGrid.DataSetChanged(False);
end;

procedure TbsDBCtrlGridLink.DataSetChanged;
begin
  FDBCtrlGrid.DataSetChanged(False);
end;

{ TDBCtrlPanel }

constructor TbsDBCtrlPanel.CreateLinked(DBCtrlGrid: TbsSkinDBCtrlGrid);
begin
  inherited Create(DBCtrlGrid);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csDoubleClicks, csOpaque, csReplicatable];
  FDBCtrlGrid := DBCtrlGrid;
  Parent := DBCtrlGrid;
  FForceBackground := False;
end;

procedure TbsDBCtrlPanel.CreateControlDefaultImage(B: TBitMap);
var
  R: TRect;
begin
  inherited;
  if FDBCtrlGrid.FDataLink.Active
  then
    begin
      R := GetSkinClientRect;
      FDBCtrlGrid.PaintPanel(FDBCtrlGrid.FDataLink.ActiveRecord, B.Canvas, R);
    end;
end;

procedure TbsDBCtrlPanel.CreateControlSkinImage(B: TBitMap);
var
  R: TRect;
begin
  inherited;
  if FDBCtrlGrid.FDataLink.Active
  then
    begin
      R := GetSkinClientRect;
      FDBCtrlGrid.PaintPanel(FDBCtrlGrid.FDataLink.ActiveRecord, B.Canvas, R);
    end;
end;


procedure TbsDBCtrlPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TbsDBCtrlPanel.PaintWindow(DC: HDC);
var
  Selected: Boolean;
  R: TRect;
begin
  inherited;
  with FDBCtrlGrid do
  begin
    if FDataLink.Active then
    begin
      Selected := (FDataLink.ActiveRecord = FPanelIndex);
      R := GetSkinClientRect;
      FCanvas.Handle := DC;
      try
        if FShowFocus and FFocused and Selected
        then
          FCanvas.DrawFocusRect(R);
      finally
         FCanvas.Handle := 0;
      end;
    end;
  end;
end;

procedure TbsDBCtrlPanel.CMControlListChange(var Message: TCMControlListChange);
begin
  FDBCtrlGrid.UpdateDataLinks(Message.Control, Message.Inserting);
end;

procedure TbsDBCtrlPanel.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
  PS: TPaintStruct;
begin
  if Message.DC = 0 then
  begin
    FDBCtrlGrid.CreatePanelBitmap;
    try
      Message.DC := FDBCtrlGrid.FPanelDC;
      PaintHandler(Message);
      Message.DC := 0;
      DC := BeginPaint(Handle, PS);
      BitBlt(DC, 0, 0, Width, Height, FDBCtrlGrid.FPanelDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      FDBCtrlGrid.DestroyPanelBitmap;
    end;
  end else
    PaintHandler(Message);
end;

procedure TbsDBCtrlPanel.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if csDesigning in ComponentState then
    Message.Result := HTCLIENT else
    Message.Result := HTTRANSPARENT;
end;

procedure TbsDBCtrlPanel.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

{ TDBCtrlGrid }

constructor TbsSkinDBCtrlGrid.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csOpaque, csDoubleClicks];
  TabStop := True;
  FDataLink := TbsDBCtrlGridLink.Create(Self);
  FCanvas := TCanvas.Create;
  FPanel := TbsDBCtrlPanel.CreateLinked(Self);
  FColCount := 1;
  FRowCount := 3;
  FPanelWidth := 200;
  FPanelHeight := 72;
  FAllowInsert := True;
  FAllowDelete := True;
  FShowFocus := True;
  FSelectedColor := Color;
  FScrollBar := TbsSkinScrollBar.Create(Self);
  FScrollBar.Visible := False;
  FScrollBar.Parent := Self;
  //
  FScrollBar.OnLastChange := SBLastChange;
  FScrollBar.OnUpButtonClick := SBUpClick;
  FScrollBar.OnDownButtonClick := SBDownClick;
  FScrollBar.OnPageUp := SBPageUp;
  FScrollBar.OnPageDown := SBPageDown;
  //
  AdjustSize;
end;

procedure TbsSkinDBCtrlGrid.SBChange(Sender: TObject);
begin
end;

procedure TbsSkinDBCtrlGrid.SBLastChange(Sender: TObject);
var
  Message: TWMScroll;
begin
  Message.Pos := FScrollBar.Position;
  Message.ScrollCode := SB_THUMBPOSITION;
  ScrollMessage(Message);
end;

procedure TbsSkinDBCtrlGrid.SBUpClick(Sender: TObject);
var
  Message: TWMScroll;
begin
  Message.Pos := FScrollBar.Position;
  Message.ScrollCode := SB_LINEDOWN;
  ScrollMessage(Message);
end;

procedure TbsSkinDBCtrlGrid.SBDownClick(Sender: TObject);
var
  Message: TWMScroll;
begin
  Message.Pos := FScrollBar.Position;
  Message.ScrollCode := SB_LINEUP;
  ScrollMessage(Message);
end;

procedure TbsSkinDBCtrlGrid.SBPageUp(Sender: TObject);
var
  Message: TWMScroll;
begin
  Message.Pos := FScrollBar.Position;
  Message.ScrollCode := SB_PAGEUP;
  ScrollMessage(Message);
end;

procedure TbsSkinDBCtrlGrid.SBPageDown(Sender: TObject);
var
  Message: TWMScroll;
begin
  Message.Pos := FScrollBar.Position;
  Message.ScrollCode := SB_PAGEDOWN;
  ScrollMessage(Message);
end;

procedure TbsSkinDBCtrlGrid.ChangeSkindata;
begin
  inherited;
  FScrollBar.SkinData := Skindata;
  AdjustSize;
end;

procedure TbsSkinDBCtrlGrid.AdjustScrollBar;
begin
  with FScrollBar do
  begin
    if (FOrientation = bsgoVertical) and (Kind <> sbVertical)
    then
      begin
        Kind := sbVertical;
        SkinDataName := 'vscrollbar';
      end
    else
    if (FOrientation = bsgoHorizontal) and (Kind <> sbHorizontal)
    then
      begin
        Kind := sbHorizontal;
        SkinDataName := 'hscrollbar';
      end;
    if (FOrientation = bsgoVertical)
    then
      begin
        DefaultHeight := 0;
        DefaultWidth := 19;
      end
    else
      begin
        DefaultHeight := 19;
        DefaultWidth := 0;
      end;
  end;
  if (FOrientation = bsgoVertical)
  then
    begin
      FScrollBar.SetBounds(Width - FScrollBar.Width, 0,
         FScrollBar.Width, Height);
    end
  else
    begin
      FScrollBar.SetBounds(0, Height - FScrollBar.Height,
         Width, FScrollBar.Height);
    end;
  if not FScrollBar.Visible then FScrollBar.Visible := True;
end;


destructor TbsSkinDBCtrlGrid.Destroy;
begin
  FScrollBar.Free;
  FCanvas.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TbsSkinDBCtrlGrid.AcquireFocus: Boolean;
begin
  Result := True;
  if not (Focused or EditMode) then
  begin
    SetFocus;
    Result := Focused;
  end;
end;

procedure TbsSkinDBCtrlGrid.AdjustSize;
var
  W, H: Integer;
begin
  W := FPanelWidth * FColCount;
  H := FPanelHeight * FRowCount;
  AdjustScrollBar;
  if FOrientation = bsgoVertical then
    Inc(W, FScrollBar.Width) else
    Inc(H, FScrollBar.Height);
  SetBounds(Left, Top, W, H);
  Reset;
end;

procedure TbsSkinDBCtrlGrid.CreatePanelBitmap;
var
  DC: HDC;
begin
  if FBitmapCount = 0 then
  begin
    DC := GetDC(0);
    FPanelBitmap := CreateCompatibleBitmap(DC, FPanel.Width, FPanel.Height);
    ReleaseDC(0, DC);
    FPanelDC := CreateCompatibleDC(0);
    FSaveBitmap := SelectObject(FPanelDC, FPanelBitmap);
  end;
  Inc(FBitmapCount);
end;

procedure TbsSkinDBCtrlGrid.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TbsSkinDBCtrlGrid.CreateWnd;
begin
  inherited CreateWnd;
  UpdateScrollBar;
end;

procedure TbsSkinDBCtrlGrid.DataSetChanged(Reset: Boolean);
var
  NewPanelIndex, NewPanelCount: Integer;
  FocusedControl: TWinControl;
  R: TRect;
begin
  if csDesigning in ComponentState then
  begin
    NewPanelIndex := 0;
    NewPanelCount := 1;
  end else
    if FDataLink.Active then
    begin
      NewPanelIndex := FDataLink.ActiveRecord;
      NewPanelCount := FDataLink.RecordCount;
      if NewPanelCount = 0 then NewPanelCount := 1;
    end else
    begin
      NewPanelIndex := 0;
      NewPanelCount := 0;
    end;
  FocusedControl := nil;
  R := GetPanelBounds(NewPanelIndex);
  if Reset or not HandleAllocated then FPanel.BoundsRect := R else
  begin
    FocusedControl := FindControl(GetFocus);
    if (FocusedControl <> FPanel) and FPanel.ContainsControl(FocusedControl) then
      FPanel.SetFocus else
      FocusedControl := nil;
    if NewPanelIndex <> FPanelIndex then
    begin
      SetWindowPos(FPanel.Handle, 0, R.Left, R.Top, R.Right - R.Left,
        R.Bottom - R.Top, SWP_NOZORDER or SWP_NOREDRAW);
      RedrawWindow(FPanel.Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
    end;
  end;
  FPanelIndex := NewPanelIndex;
  FPanelCount := NewPanelCount;
  FPanel.Visible := FPanelCount > 0;
  FPanel.Invalidate;
  if not Reset then
  begin
    Invalidate;
    Update;
  end;
  UpdateScrollBar;
  if (FocusedControl <> nil) and not FClicking and FocusedControl.CanFocus then
    FocusedControl.SetFocus;
end;

procedure TbsSkinDBCtrlGrid.DestroyPanelBitmap;
begin
  Dec(FBitmapCount);
  if FBitmapCount = 0 then
  begin
    SelectObject(FPanelDC, FSaveBitmap);
    DeleteDC(FPanelDC);
    DeleteObject(FPanelBitmap);
  end;
end;

procedure TbsSkinDBCtrlGrid.DoKey(Key: TbsDBCtrlGridKey);
var
  HInc, VInc: Integer;
begin
  if FDataLink.Active then
  begin
    if FOrientation = bsgoVertical then
    begin
      HInc := 1;
      VInc := FColCount;
    end else
    begin
      HInc := FRowCount;
      VInc := 1;
    end;
    with FDataLink.DataSet do
      case Key of
        bsgkEditMode: EditMode := not EditMode;
        bsgkPriorTab: SelectNext(False);
        bsgkNextTab: SelectNext(True);
        bsgkLeft: Scroll(-HInc, False);
        bsgkRight: Scroll(HInc, False);
        bsgkUp: Scroll(-VInc, False);
        bsgkDown: Scroll(VInc, False);
        bsgkScrollUp: Scroll(-VInc, True);
        bsgkScrollDown: Scroll(VInc, True);
        bsgkPageUp: Scroll(-FDataLink.BufferCount, True);
        bsgkPageDown: Scroll(FDataLink.BufferCount, True);
        bsgkHome: First;
        bsgkEnd: Last;
        bsgkInsert:
          if FAllowInsert and CanModify then
          begin
            Insert;
            EditMode := True;
          end;
        bsgkAppend:
          if FAllowInsert and CanModify then
          begin
            Append;
            EditMode := True;
          end;
        bsgkDelete:
          if FAllowDelete and CanModify then
          begin
            Delete;
            EditMode := False;
          end;
        bsgkCancel:
          begin
            Cancel;
            EditMode := False;
          end;
      end;
  end;
end;

type
  TXParentControl = class(TWinControl);

procedure TbsSkinDBCtrlGrid.DrawPanel(DC: HDC; Index: Integer);
var
  SaveActive: Integer;
  R: TRect;

procedure PaintControls;
var
  i, V: Integer;
  C: TCanvas;
  S: String;
  B: Boolean;
  SaveIndex: Integer;
begin
  C := TControlCanvas.Create;
  C.Handle := FPanelDC;
  for i := 0 to FPanel.ControlCount - 1 do
  begin
    if (FPanel.Controls[i] is TbsSkinDBEdit) and
       (TbsSkinDBEdit(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        S := TbsSkinDBEdit(FPanel.Controls[i]).FDataLink.Field.DisplayText;
        TbsSkinCustomEdit(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
      end
    else
    if (FPanel.Controls[i] is TbsSkinDBCalcEdit) and
       (TbsSkinDBCalcEdit(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        S := TbsSkinDBCalcEdit(FPanel.Controls[i]).FDataLink.Field.DisplayText;
        TbsSkinCustomEdit(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
      end
    else
    if (FPanel.Controls[i] is TbsSkinDBNumericEdit) and
       (TbsSkinDBNumericEdit(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        S := TbsSkinDBNumericEdit(FPanel.Controls[i]).FDataLink.Field.DisplayText;
        TbsSkinDBNumericEdit(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
      end
    else
    if (FPanel.Controls[i] is TbsSkinDBDateEdit) and
       (TbsSkinDBDateEdit(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        S := TbsSkinDBDateEdit(FPanel.Controls[i]).FDataLink.Field.DisplayText;
        TbsSkinDBDateEdit(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
      end
    else
    if (FPanel.Controls[i] is TbsSkinDBTimeEdit) and
       (TbsSkinDBTimeEdit(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        S := TbsSkinDBTimeEdit(FPanel.Controls[i]).FDataLink.Field.DisplayText;
        TbsSkinDBTimeEdit(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
      end
    else
    if (FPanel.Controls[i] is TbsSkinDbText) and
       (TbsSkinDbText(FPanel.Controls[i]).FDataLink.Field <> nil)
      then
        begin
          S := TbsSkinDbText(FPanel.Controls[i]).FDataLink.Field.DisplayText;
          TbsSkinDbText(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
        end
    else
    if (FPanel.Controls[i] is TbsSkinDBSpinEdit) and
       (TbsSkinDBSpinEdit(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        S := TbsSkinDBSpinEdit(FPanel.Controls[i]).FDataLink.Field.DisplayText;
        TbsSkinSpinEdit(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
      end
    else
    if (FPanel.Controls[i] is TbsSkinDBComboBox) and
       (TbsSkinDBComboBox(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        S :=  TbsSkinDBComboBox(FPanel.Controls[i]).FDataLink.Field.DisplayText;
         TbsSkinDBComboBox(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
      end
    else
    if (FPanel.Controls[i] is TbsSkinDBMRUComboBox) and
       (TbsSkinDBMRUComboBox(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        S :=  TbsSkinDBMRUComboBox(FPanel.Controls[i]).FDataLink.Field.DisplayText;
        TbsSkinDBComboBox(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, S);
      end
    else
    if (FPanel.Controls[i] is TbsSkinDBCheckRadioBox) and
       (TbsSkinDBCheckRadioBox(FPanel.Controls[i]).FDataLink.Field <> nil)
    then
      begin
        B := TbsSkinDBCheckRadioBox(FPanel.Controls[i]).FDataLink.Field.AsBoolean;
        TbsSkinDBCheckRadioBox(FPanel.Controls[i]).PaintSkinTo(C, FPanel.Controls[i].Left, FPanel.Controls[i].Top, B);
      end
    else
      begin
        if FPanel.Controls[i] is TWinControl
        then
          begin
            TWinControl(FPanel.Controls[i]).PaintTo(FPanelDC, FPanel.Controls[i].Left, FPanel.Controls[i].Top);
          end
        else
        if FPanel.Controls[i] is TGraphicControl
        then
          begin
            SaveIndex := SaveDC(FPanelDC);
            SetViewportOrgEx(FPanelDC, FPanel.Controls[i].Left, FPanel.Controls[i].Top, nil);
            IntersectClipRect(FPanelDC, 0, 0, FPanel.Controls[i].Width, FPanel.Controls[i].Height);
            FPanel.Controls[i].Perform(WM_PAINT, FPanelDC, 0);
            RestoreDC(FPanelDC, SaveIndex);
          end;
      end;
   end;
  C.Free;
end;

var
  C: TCanvas;
  Selected: Boolean;
  R1: TRect;
begin
  R := GetPanelBounds(Index);
  if Index < FPanelCount then
  begin
    SaveActive := FDataLink.ActiveRecord;
    FDataLink.ActiveRecord := Index;
    //
    C := TControlCanvas.CReate;
    C.Handle := FPanelDC;
    FPanel.PaintSkinTo(C, 0, 0);
    //
    PaintControls;
    FDataLink.ActiveRecord := SaveActive;
    C.Free;
  end
  else
    begin
       C := TControlCanvas.CReate;
       C.Handle := FPanelDC;
       FPanel.PaintSkinTo(C, 0, 0);
       C.Free;
     end;
  BitBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
    FPanelDC, 0, 0, SRCCOPY);
end;

function TbsSkinDBCtrlGrid.GetFillColor: TColor;
var
  PanelData: TbsDataSkinPanelControl;
  X, Y: Integer;
begin
  Result := Color;
  if (FSD = nil) or (FSD.Empty) then  Exit;
  PanelData := TbsDataSkinPanelControl(FSD.CtrlList[FSD.GetControlIndex('panel')]);
  if PanelData <> nil
  then
      with PanelData do
      begin
        X := SkinRect.Left + ClRect.Left + 1;
        Y := SkinRect.Top + ClRect.Top + 1;
        Result := TBitMap(FSD.FActivePictures[PictureIndex]).Canvas.Pixels[X, Y];
      end;
end;


function TbsSkinDBCtrlGrid.GetChildParent: TComponent;
begin
  Result := FPanel;
end;

procedure TbsSkinDBCtrlGrid.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  FPanel.GetChildren(Proc, Root);
end;

function TbsSkinDBCtrlGrid.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TbsSkinDBCtrlGrid.GetEditMode: Boolean;
begin
  Result := not Focused and ContainsControl(FindControl(GetFocus));
end;

function TbsSkinDBCtrlGrid.GetPanelBounds(Index: Integer): TRect;
var
  Col, Row: Integer;
begin
  if FOrientation = bsgoVertical then
  begin
    Col := Index mod FColCount;
    Row := Index div FColCount;
  end else
  begin
    Col := Index div FRowCount;
    Row := Index mod FRowCount;
  end;
  Result.Left := FPanelWidth * Col;
  Result.Top := FPanelHeight * Row;
  Result.Right := Result.Left + FPanelWidth;
  Result.Bottom := Result.Top + FPanelHeight;
end;

procedure TbsSkinDBCtrlGrid.GetTabOrderList(List: TList);
begin
end;

procedure TbsSkinDBCtrlGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  GridKey: TbsDBCtrlGridKey;
begin
  inherited KeyDown(Key, Shift);
  GridKey := bsgkNull;
  case Key of
    VK_LEFT: GridKey := bsgkLeft;
    VK_RIGHT: GridKey := bsgkRight;
    VK_UP: GridKey := bsgkUp;
    VK_DOWN: GridKey := bsgkDown;
    VK_PRIOR: GridKey := bsgkPageUp;
    VK_NEXT: GridKey := bsgkPageDown;
    VK_HOME: GridKey := bsgkHome;
    VK_END: GridKey := bsgkEnd;
    VK_RETURN, VK_F2: GridKey := bsgkEditMode;
    VK_INSERT:
      if GetKeyState(VK_CONTROL) >= 0 then
        GridKey := bsgkInsert else
        GridKey := bsgkAppend;
    VK_DELETE: if GetKeyState(VK_CONTROL) < 0 then GridKey := bsgkDelete;
    VK_ESCAPE: GridKey := bsgkCancel;
  end;
  DoKey(GridKey);
end;

procedure TbsSkinDBCtrlGrid.PaintWindow(DC: HDC);
var
  I: Integer;
  Brush: HBrush;
  C: TColor;
begin
  if csDesigning in ComponentState then
  begin
    FPanel.Update;
    Brush := CreateHatchBrush(HS_BDIAGONAL, ColorToRGB(clBtnShadow));
    SetBkColor(DC, ColorToRGB(Color));
    FillRect(DC, ClientRect, Brush);
    DeleteObject(Brush);
  end else
  begin
    FPanel.SkinData := Self.SkinData;
    CreatePanelBitmap;
    try
      for I := 0 to FColCount * FRowCount - 1 do
        if (FPanelCount <> 0) and (I = FPanelIndex) then
          FPanel.Update else
          DrawPanel(DC, I);
    finally
      DestroyPanelBitmap;
    end;
  end;

  if HandleAllocated then
  begin
    if (Height <> FPanel.Height * FRowCount) then
    begin
      Brush := CreateSolidBrush(ColorToRGB(Color));
      FillRect(DC, Rect(0, FPanel.Height * FRowCount, Width, Height), Brush);
      DeleteObject(Brush);
    end;
    if (Width <> FPanel.Width * FColCount) then
    begin
      C := GetFillColor;
      Brush := CreateSolidBrush(ColorToRGB(C));
      FillRect(DC, Rect(FPanelWidth * FColCount, 0, Width, Height), Brush);
      DeleteObject(Brush);
    end;
  end;
end;

procedure TbsSkinDBCtrlGrid.PaintPanel;
begin
  if Assigned(FOnPaintPanel) then FOnPaintPanel(Self, Index, Cnvs, ClRect);
end;

function TbsSkinDBCtrlGrid.PointInPanel(const P: TSmallPoint): Boolean;
begin
  Result := (FPanelCount > 0) and PtInRect(GetPanelBounds(FPanelIndex),
    SmallPointToPoint(P));
end;

procedure TbsSkinDBCtrlGrid.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  FPanel.FixupTabList;
end;

procedure TbsSkinDBCtrlGrid.Reset;
begin
  if csDesigning in ComponentState then
    FDataLink.BufferCount := 1 else
    FDataLink.BufferCount := FColCount * FRowCount;
  DataSetChanged(True);
end;

procedure TbsSkinDBCtrlGrid.Scroll(Inc: Integer; ScrollLock: Boolean);
var
  NewIndex, ScrollInc, Adjust: Integer;
begin
  if FDataLink.Active and (Inc <> 0) then
    with FDataLink.DataSet do
      if State = dsInsert then
      begin
        UpdateRecord;
        if Modified then Post else
          if (Inc < 0) or not EOF then Cancel;
      end else
      begin
        CheckBrowseMode;
        DisableControls;
        try
          if ScrollLock then
            if Inc > 0 then
              MoveBy(Inc - MoveBy(Inc + FDataLink.BufferCount - FPanelIndex - 1))
            else
              MoveBy(Inc - MoveBy(Inc - FPanelIndex))
          else
          begin
            NewIndex := FPanelIndex + Inc;
            if (NewIndex >= 0) and (NewIndex < FDataLink.BufferCount) then
              MoveBy(Inc)
            else
              if MoveBy(Inc) = Inc then
              begin
                if FOrientation = bsgoVertical then
                  ScrollInc := FColCount else
                  ScrollInc := FRowCount;
                if Inc > 0 then
                  Adjust := ScrollInc - 1 - NewIndex mod ScrollInc
                else
                  Adjust := 1 - ScrollInc - (NewIndex + 1) mod ScrollInc;
                MoveBy(-MoveBy(Adjust));
              end;
          end;
          if (Inc = 1) and EOF and FAllowInsert and CanModify then Append;
        finally
          EnableControls;
        end;
      end;
end;

procedure TbsSkinDBCtrlGrid.ScrollMessage;
var
  Key: TbsDBCtrlGridKey;
begin
  if AcquireFocus then
  begin
    Key := bsgkNull;
    case Message.ScrollCode of
      SB_LINEUP: Key := bsgkScrollUp;
      SB_LINEDOWN: Key := bsgkScrollDown;
      SB_PAGEUP: Key := bsgkPageUp;
      SB_PAGEDOWN: Key := bsgkPageDown;
      SB_TOP: Key := bsgkHome;
      SB_BOTTOM: Key := bsgkEnd;
      SB_THUMBPOSITION:
        if FDataLink.Active and FDataLink.DataSet.IsSequenced then
        begin
          if FScrollBar.Position <= 1 then Key := bsgkHome
          else if FScrollBar.Position >= FDataLink.DataSet.RecordCount then Key := bsgkEnd
          else
          begin
            FDataLink.DataSet.RecNo := FScrollBar.Position;
            Exit;
          end;
        end else
        begin
          case Message.Pos of
            0: Key := bsgkHome;
            1: Key := bsgkPageUp;
            3: Key := bsgkPageDown;
            4: Key := bsgkEnd;
          end;
        end;
    end;
    DoKey(Key);
  end;
end;

function TbsSkinDBCtrlGrid.FindNext(StartControl: TWinControl; GoForward: Boolean;
  var WrapFlag: Integer): TWinControl;
var
  I, StartIndex: Integer;
  List: TList;
begin
  List := TList.Create;
  try
    StartIndex := 0;
    I := 0;
    Result := StartControl;
    FPanel.GetTabOrderList(List);
    if List.Count > 0 then
    begin
      StartIndex := List.IndexOf(StartControl);
      if StartIndex = -1 then
        if GoForward then
          StartIndex := List.Count - 1 else
          StartIndex := 0;
      I := StartIndex;
      repeat
        if GoForward then
        begin
          Inc(I);
          if I = List.Count then I := 0;
        end else
        begin
          if I = 0 then I := List.Count;
          Dec(I);
        end;
        Result := List[I];
      until (Result.CanFocus and Result.TabStop) or (I = StartIndex);
    end;
    WrapFlag := 0;
    if GoForward then
    begin
      if I <= StartIndex then WrapFlag := 1;
    end else
    begin
      if I >= StartIndex then WrapFlag := -1;
    end;
  finally
    List.Free;
  end;
end;

procedure TbsSkinDBCtrlGrid.SelectNext(GoForward: Boolean);
var
  WrapFlag: Integer;
  ParentForm: TCustomForm;
  ActiveControl, Control: TWinControl;
begin
  ParentForm := GetParentForm(Self);
  if ParentForm <> nil then
  begin
    ActiveControl := ParentForm.ActiveControl;
    if ContainsControl(ActiveControl) then
    begin
      Control := FindNext(ActiveControl, GoForward, WrapFlag);
      if not (FDataLink.DataSet.State in dsEditModes) then
        FPanel.SetFocus;
      try
        if WrapFlag <> 0 then Scroll(WrapFlag, False);
      except
        ActiveControl.SetFocus;
        raise;
      end;
      if not Control.CanFocus then
        Control := FindNext(Control, GoForward, WrapFlag);
      Control.SetFocus;
    end;
  end;
end;

procedure TbsSkinDBCtrlGrid.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  ScrollWidth, ScrollHeight, NewPanelWidth, NewPanelHeight: Integer;
begin
  ScrollWidth := 0;
  ScrollHeight := 0;
  if FOrientation = bsgoVertical then
    ScrollWidth := FScrollBar.Width else
    ScrollHeight := FScrollBar.Height;
  NewPanelWidth := (AWidth - ScrollWidth) div FColCount;
  NewPanelHeight := (AHeight - ScrollHeight) div FRowCount;
  if NewPanelWidth < 1 then NewPanelWidth := 1;
  if NewPanelHeight < 1 then NewPanelHeight := 1;
  if (FPanelWidth <> NewPanelWidth) or (FPanelHeight <> NewPanelHeight) then
  begin
    FPanelWidth := NewPanelWidth;
    FPanelHeight := NewPanelHeight;
    Reset;
  end;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  AdjustScrollBar;
end;

procedure TbsSkinDBCtrlGrid.SetColCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 100 then Value := 100;
  if FColCount <> Value then
  begin
    FColCount := Value;
    AdjustSize;
  end;
end;

procedure TbsSkinDBCtrlGrid.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  UpdateDataLinks(FPanel, True);
end;

procedure TbsSkinDBCtrlGrid.SetEditMode(Value: Boolean);
var
  Control: TWinControl;
begin
  if GetEditMode <> Value then
    if Value then
    begin
      Control := FPanel.FindNextControl(nil, True, True, False);
      if Control <> nil then Control.SetFocus;
    end else
      SetFocus;
end;

procedure TbsSkinDBCtrlGrid.SetOrientation(Value: TbsDBCtrlGridOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    RecreateWnd;
    AdjustSize;
  end;
end;

procedure TbsSkinDBCtrlGrid.SetPanelHeight(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 65535 then Value := 65535;
  if FPanelHeight <> Value then
  begin
    FPanelHeight := Value;
    AdjustSize;
  end;
end;

procedure TbsSkinDBCtrlGrid.SetPanelIndex(Value: Integer);
begin
  if FDataLink.Active and (Value < PanelCount) then
    FDataLink.DataSet.MoveBy(Value - FPanelIndex);
end;

procedure TbsSkinDBCtrlGrid.SetPanelWidth(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 65535 then Value := 65535;
  if FPanelWidth <> Value then
  begin
    FPanelWidth := Value;
    AdjustSize;
  end;
end;

procedure TbsSkinDBCtrlGrid.SetRowCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 100 then Value := 100;
  if FRowCount <> Value then
  begin
    FRowCount := Value;
    AdjustSize;
  end;
end;

procedure TbsSkinDBCtrlGrid.SetSelectedColor(Value: TColor);
begin
  if Value <> FSelectedColor then
  begin
    FSelectedColor := Value;
    FSelColorChanged := Value <> Color;
    Invalidate;
    FPanel.Invalidate;
  end;
end;

procedure TbsSkinDBCtrlGrid.UpdateDataLinks(Control: TControl; Inserting: Boolean);
var
  I: Integer;
  DataLink: TDataLink;
begin
  DataLink := TDataLink(Control.Perform(CM_GETDATALINK, 0, 0));
  if DataLink <> nil then
  begin
    DataLink.DataSourceFixed := False;
    if Inserting then
    begin
      DataLink.DataSource := DataSource;
      DataLink.DataSourceFixed := True;
    end;
  end;
  if Control is TWinControl then
    with TWinControl(Control) do
      for I := 0 to ControlCount - 1 do
        UpdateDataLinks(Controls[I], Inserting);
end;

procedure TbsSkinDBCtrlGrid.UpdateScrollBar;
var
  SIOld, SINew: TScrollInfo;
begin
  if FDatalink.Active and HandleAllocated then
    with FDatalink.DataSet do
    begin
      SIOld.nMin := FScrollBar.Min;
      SIOld.nMax := FScrollBar.Max;
      SIOld.nPage := FScrollBar.PageSize;
      SIOld.nPos := FScrollBar.Position;
      SINew.nPos := SIOld.nPos;
      if IsSequenced then
      begin
        SINew.nMin := 1;
        SINew.nPage := Self.RowCount * Self.ColCount;
        SINew.nMax := DWORD(RecordCount) + SINew.nPage - 1;
        if State in [dsInactive, dsBrowse, dsEdit]
        then
          SINew.nPos := RecNo
        else
          if Eof then SINew.nPos := SINew.nMax;
      end
      else
      begin
        SINew.nMin := 0;
        SINew.nPage := 0;
        SINew.nMax := 4;
        if BOF then SINew.nPos := 0
        else if EOF then SINew.nPos := 4
        else SINew.nPos := 2;
      end;
      if (SINew.nMin <> SIOld.nMin) or (SINew.nMax <> SIOld.nMax) or
        (SINew.nPage <> SIOld.nPage) or (SINew.nPos <> SIOld.nPos) then
      FScrollBar.SetRange(SiNew.nMin, SINew.nMax, SINew.nPos, SINew.nPage);
    end;
end;

procedure TbsSkinDBCtrlGrid.WMLButtonDown(var Message: TWMLButtonDown);
var
  I: Integer;
  P: TPoint;
  Window: HWnd;
begin
  if FDataLink.Active then
  begin
    P := SmallPointToPoint(Message.Pos);
    for I := 0 to FPanelCount - 1 do
      if (I <> FPanelIndex) and PtInRect(GetPanelBounds(I), P) then
      begin
        FClicking := True;
        try
          SetPanelIndex(I);
        finally
          FClicking := False;
        end;
        P := ClientToScreen(P);
        Window := WindowFromPoint(P);
        if IsChild(FPanel.Handle, Window) then
        begin
          Windows.ScreenToClient(Window, P);
          Message.Pos := PointToSmallPoint(P);
          with TMessage(Message) do SendMessage(Window, Msg, WParam, LParam);
          Exit;
        end;
        Break;
      end;
  end;
  if AcquireFocus then
  begin
    if PointInPanel(Message.Pos) then
    begin
      EditMode := False;
      Click;
    end;
    inherited;
  end;
end;

procedure TbsSkinDBCtrlGrid.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if PointInPanel(Message.Pos) then DblClick;
  inherited;
end;

procedure TbsSkinDBCtrlGrid.WMHScroll(var Message: TWMHScroll);
begin
  ScrollMessage(Message);
end;

procedure TbsSkinDBCtrlGrid.WMVScroll(var Message: TWMVScroll);
begin
  ScrollMessage(Message);
end;

procedure TbsSkinDBCtrlGrid.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TbsSkinDBCtrlGrid.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TbsSkinDBCtrlGrid.WMSetFocus(var Message: TWMSetFocus);
begin
  FFocused := True;
  FPanel.Repaint;
end;

procedure TbsSkinDBCtrlGrid.WMKillFocus(var Message: TWMKillFocus);
begin
  FFocused := False;
  FPanel.Repaint;
end;

procedure TbsSkinDBCtrlGrid.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TbsSkinDBCtrlGrid.WMSize(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

function GetShiftState: TShiftState;
begin
  Result := [];
  if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
  if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
end;

procedure TbsSkinDBCtrlGrid.CMChildKey(var Message: TCMChildKey);
var
  ShiftState: TShiftState;
  GridKey: TbsDBCtrlGridKey;
begin
  with Message do
    if Sender <> Self then
    begin
      ShiftState := GetShiftState;
      if Assigned(OnKeyDown) then OnKeyDown(Sender, CharCode, ShiftState);
      GridKey := bsgkNull;
      case CharCode of
        VK_TAB:
          if not (ssCtrl in ShiftState) and
            (Sender.Perform(WM_GETDLGCODE, 0, 0) and DLGC_WANTTAB = 0) then
            if ssShift in ShiftState then
              GridKey := bsgkPriorTab else
              GridKey := bsgkNextTab;
        VK_RETURN:
          if (Sender.Perform(WM_GETDLGCODE, 0, 0) and DLGC_WANTALLKEYS = 0) then
            GridKey := bsgkEditMode;
        VK_F2: GridKey := bsgkEditMode;
        VK_ESCAPE: GridKey := bsgkCancel;
      end;
      if GridKey <> bsgkNull then
      begin
        DoKey(GridKey);
        Result := 1;
        Exit;
      end;
    end;
  inherited;
end;

procedure TbsSkinDBCtrlGrid.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if not FSelColorChanged then
    FSelectedColor := Color;
end;

{ Defer action processing to datalink }

function TbsSkinDBCtrlGrid.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBCtrlGrid.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TbsSkinDBURLEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

constructor TbsSkinDBURLEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TbsSkinDBURLEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FCanvas.Free;
  inherited Destroy;
end;

procedure TbsSkinDBURLEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBURLEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

function TbsSkinDBURLEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TbsSkinDBURLEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
end;

procedure TbsSkinDBURLEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
end;

function TbsSkinDBURLEdit.EditCanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

procedure TbsSkinDBURLEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TbsSkinDBURLEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) and not IsMasked then Invalidate;
    FDataLink.Reset;
  end;
end;

procedure TbsSkinDBURLEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

function TbsSkinDBURLEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBURLEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBURLEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBURLEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
end;

function TbsSkinDBURLEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBURLEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBURLEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBURLEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
end;

procedure TbsSkinDBURLEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FAlignment <> FDataLink.Field.Alignment then
    begin
      EditText := '';  {forces update}
      FAlignment := FDataLink.Field.Alignment;
    end;
    EditMask := FDataLink.Field.EditMask;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if FFocused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else
    begin
      EditText := FDataLink.Field.DisplayText;
      if FDataLink.Editing and FDataLink.CanModify then
      Modified := True;
    end;
  end else
  begin
    FAlignment := taLeftJustify;
    EditMask := '';
    if csDesigning in ComponentState then
      EditText := Name else
      EditText := '';
  end;
end;

procedure TbsSkinDBURLEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBURLEdit.UpdateData(Sender: TObject);
begin
  ValidateEdit;
  FDataLink.Field.Text := Text;
end;

procedure TbsSkinDBURLEdit.WMUndo(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBURLEdit.WMPaste(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBURLEdit.WMCut(var Message: TMessage);
begin
  FDataLink.Edit;
  inherited;
end;

procedure TbsSkinDBURLEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
  if FDataLink.CanModify then
    inherited ReadOnly := False;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBURLEdit.CMExit(var Message: TCMExit);
begin
  try
    if FDataLink.Editing then FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  SetFocused(False);
  CheckCursor;
  DoExit;
end;

procedure TbsSkinDBURLEdit.WMPaint(var Message: TWMPaint);
const
  AlignStyle : array[Boolean, TAlignment] of DWORD =
   ((WS_EX_LEFT, WS_EX_RIGHT, WS_EX_LEFT),
    (WS_EX_RIGHT, WS_EX_LEFT, WS_EX_LEFT));
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  AAlignment: TAlignment;
  ExStyle: DWORD;
begin
  AAlignment := FAlignment;
  if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
  if ((AAlignment = taLeftJustify) or FFocused) and
    not (csPaintCopy in ControlState) then
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
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      Brush.Style := bsClear;
      if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) then
      begin
        S := FDataLink.Field.DisplayText;
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end else
        S := EditText;
      if PasswordChar <> #0 then FillChar(S[1], Length(S), PasswordChar);
      Margins := GetTextMargins;
      case AAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := ClientWidth - TextWidth(S) - Margins.X - 1;
      else
        Left := (ClientWidth - TextWidth(S)) div 2;
      end;
      if SysLocale.MiddleEast then UpdateTextFlags;
      TextRect(R, Left, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure TbsSkinDBURLEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBURLEdit.GetTextMargins: TPoint;
begin
  Result.X := 0;
  Result.Y := 0;
end;

function TbsSkinDBURLEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBURLEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

constructor TbsSkinDBCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBCurrencyEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBCurrencyEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBCurrencyEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBCurrencyEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TbsSkinDBCurrencyEdit.Change;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit; 
      FDataLink.Modified;
      inherited Change;
    end;
  FInChange := False;
end;

function TbsSkinDBCurrencyEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBCurrencyEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBCurrencyEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBCurrencyEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBCurrencyEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBCurrencyEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBCurrencyEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBCurrencyEdit.DataChange(Sender: TObject);
begin
  FInDataChange := True; 
  if not FInChange then
  if FDataLink.Field <> nil
  then
    begin
      if (FDataLink.Field.Text <> '') and IsNumText(FDataLink.Field.Text)
      then
        Text := FDataLink.Field.Text
      else
        Value := MinValue;
    end
  else
    Value := MinValue;
  FInDataChange := False;
end;

procedure TbsSkinDBCurrencyEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBCurrencyEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

procedure TbsSkinDBCurrencyEdit.CMEnter;
begin
  inherited;
  inherited ReadOnly := not FDataLink.CanModify;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBCurrencyEdit.CMExit;
begin
  inherited;
  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
end;

procedure TbsSkinDBCurrencyEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBCurrencyEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBCurrencyEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

constructor TbsSkinDBCalcCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FInChange := False;
  FInDataChange := False;
end;

destructor TbsSkinDBCalcCurrencyEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TbsSkinDBCalcCurrencyEdit.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TbsSkinDBCalcCurrencyEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TbsSkinDBCalcCurrencyEdit.Reset;
begin
  FDataLink.Reset;
  SelectAll;
end;

procedure TbsSkinDBCalcCurrencyEdit.Change;
begin
  FInChange := True;
  if not FInDataChange and (FDataLink <> nil) and
     not ReadOnly and FDataLink.CanModify
  then
    begin
      if not FDataLink.Editing then FDataLink.Edit; 
      FDataLink.Modified;
      inherited Change;
    end;
  FInChange := False;
end;

function TbsSkinDBCalcCurrencyEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TbsSkinDBCalcCurrencyEdit.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TbsSkinDBCalcCurrencyEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TbsSkinDBCalcCurrencyEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

function TbsSkinDBCalcCurrencyEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TbsSkinDBCalcCurrencyEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TbsSkinDBCalcCurrencyEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TbsSkinDBCalcCurrencyEdit.DataChange(Sender: TObject);
begin
  FInDataChange := True; 
  if not FInChange then
  if FDataLink.Field <> nil
  then
    begin
      if (FDataLink.Field.Text <> '') and IsNumText(FDataLink.Field.Text)
      then
        Text := FDataLink.Field.Text
      else
        Value := MinValue;
    end
  else
    Value := MinValue;
  FInDataChange := False;
end;

procedure TbsSkinDBCalcCurrencyEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TbsSkinDBCalcCurrencyEdit.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

procedure TbsSkinDBCalcCurrencyEdit.CMEnter;
begin
  inherited;
  inherited ReadOnly := not FDataLink.CanModify;
  if (FDataLink.DataSource <> nil) and not FDataLink.DataSource.AutoEdit and not FDataLink.Editing
  then
    inherited ReadOnly := True;
end;

procedure TbsSkinDBCalcCurrencyEdit.CMExit;
begin
  inherited;
  if (FDataLink <> nil) and (FDataLink.Editing)
  then
    FDataLink.UpdateRecord;
end;

procedure TbsSkinDBCalcCurrencyEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

function TbsSkinDBCalcCurrencyEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TbsSkinDBCalcCurrencyEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;


end.
