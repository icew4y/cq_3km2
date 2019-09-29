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

unit bsDialogs;

{$WARNINGS OFF}
{$HINTS OFF}

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms,
     BusinessSkinForm, bsSkinData, bsSkinCtrls, bsSkinBoxCtrls, Dialogs,
     StdCtrls, ExtCtrls, bsSkinShellCtrls;

type
  TbsPDShowType = (stStayOnTop, stModal);

  TbsSkinProgressDialog = class(TComponent)
  protected
    FShowType: TbsPDShowType;
    FOnCancel: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FExecute: Boolean;
    Gauge: TbsSkinGauge;
    Form: TForm;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FButtonSkinDataName: String;
    FGaugeSkinDataName: String;
    FLabelSkinDataName: String;
    FDefaultLabelFont: TFont;
    FDefaultGaugeFont: TFont;
    FDefaultButtonFont: TFont;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    FMinValue, FMaxValue, FValue: Integer;
    FCaption: String;
    FLabelCaption: String;
    FShowPercent: Boolean;
    FShowCancelButton, FShowCloseButton: Boolean;

    procedure SetValue(AValue: Integer);
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultGaugeFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure CancelBtnClick(Sender: TObject);
    procedure OnFormClose(Sender: TObject; var Action: TCloseAction);
    procedure OnFormShow(Sender: TObject);
  public
    function Execute: Boolean;
    procedure Close;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ShowCancelButton: Boolean
      read FShowCancelButton write FShowCancelButton;
    property ShowCloseButton: Boolean
      read FShowCloseButton write FShowCloseButton;
    property ShowType: TbsPDShowType read FShowType write FShowType;
    property Caption: String read FCaption write FCaption;
    property LabelCaption: String read FLabelCaption write FLabelCaption;
    property ShowPercent: Boolean read FShowPercent write FShowPercent;
    property MinValue: Integer read FMinValue write FMinValue;
    property MaxValue: Integer read FMaxValue write FMaxValue;
    property Value: Integer read FValue write SetValue;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String
      read FLabelSkinDataName write FLabelSkinDataName;
    property GaugeSkinDataName: String
     read FGaugeSkinDataName write FGaugeSkinDataName;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultGaugeFont: TFont read FDefaultGaugeFont write SetDefaultGaugeFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
  end;

  TbsSkinInputDialog = class(TComponent)
  protected
    Form: TForm;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FButtonSkinDataName: String;
    FEditSkinDataName: String;
    FLabelSkinDataName: String;
    FDefaultLabelFont: TFont;
    FDefaultEditFont: TFont;
    FDefaultButtonFont: TFont;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultEditFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    function InputBox(const ACaption, APrompt, ADefault: string): string;
    function InputQuery(const ACaption, APrompt: string; var Value: string): Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String
      read FLabelSkinDataName write FLabelSkinDataName;
    property EditSkinDataName: String
     read FEditSkinDataName write FEditSkinDataName;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultEditFont: TFont read FDefaultEditFont write SetDefaultEditFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSkinPasswordDialog = class(TComponent)
  protected
    FLoginMode: Boolean;
    FCaption: String;
    FLogin: String;
    FLoginCaption: String;
    FPasswordCaption: String;
    FPassword: String;
    FPasswordKind: TbsPasswordKind;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FButtonSkinDataName: String;
    FEditSkinDataName: String;
    FLabelSkinDataName: String;
    FDefaultLabelFont: TFont;
    FDefaultEditFont: TFont;
    FDefaultButtonFont: TFont;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    FUseSkinFont: Boolean;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultEditFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
  published
    property LoginMode: Boolean read FLoginMode write FLoginMode;
    property Login: String read FLogin write FLogin;
    property LoginCaption: String read FLoginCaption write FLoginCaption;
    property Password: String read FPassword write FPassword;
    property PasswordKind: TbsPasswordKind read FPasswordKind write FPasswordKind;
    property Caption: String read FCaption write FCaption;
    property PasswordCaption: String read FPasswordCaption write FPasswordCaption;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String
      read FLabelSkinDataName write FLabelSkinDataName;
    property EditSkinDataName: String
     read FEditSkinDataName write FEditSkinDataName;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultEditFont: TFont read FDefaultEditFont write SetDefaultEditFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsFontDlgForm = class(TForm)
  public
    BSF: TbsBusinessSkinForm;
    ScriptComboBox: TbsSkinComboBox;
    FontNameBox: TbsSkinFontComboBox;
    FontColorBox: TbsSkinColorComboBox;
    FontSizeEdit: TbsSkinSpinEdit;
    FontHeightEdit: TbsSkinSpinEdit;
    FontExamplePanel: TbsSkinPanel;
    FontExampleLabel: TLabel;
    OkButton, CancelButton: TbsSkinButton;
    ScriptLabel, FontNameLabel, FontColorLabel, FontSizeLabel,
    FontHeightLabel, FontStyleLabel, FontExLabel: TbsSkinStdLabel;
    BoldButton, ItalicButton,
    UnderLineButton, StrikeOutButton: TbsSkinSpeedButton;

    constructor CreateEx(AOwner: TComponent; ACtrlSkinData: TbsSkinData);

    procedure FontSizeChange(Sender: TObject);
    procedure FontHeightChange(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure FontScriptChange(Sender: TObject);
    procedure FontColorChange(Sender: TObject);
    procedure BoldButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure StrikeOutButtonClick(Sender: TObject);
    procedure UnderLineButtonClick(Sender: TObject); 
  end;

  TbsSkinFontDialog = class(TComponent)
  private
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FDefaultFont: TFont;
    FTitle: String;
    FDlgFrm: TbsFontDlgForm;
    FOnChange: TNotifyEvent;
    FFont: TFont;
    FShowSizeEdit, FShowHeightEdit: Boolean;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure SetFont(Value: TFont);
    procedure SetDefaultFont(Value: TFont);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure Change;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
  published
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property Font: TFont read FFont write SetFont;
    property Title: string read GetTitle write SetTitle;
    property ShowSizeEdit: Boolean read FShowSizeEdit write FShowSizeEdit;
    property ShowHeightEdit: Boolean read FShowHeightEdit write FShowHeightEdit;
    property OnChange: TnotifyEvent read FOnChange write FOnChange;
  end;

  TbsSkinTextDialog = class(TComponent)
  protected
    Memo: TbsSkinMemo2;
    FShowToolBar: Boolean;
    FCaption: String;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FButtonSkinDataName: String;
    FMemoSkinDataName: String;
    FDefaultMemoFont: TFont;
    FDefaultButtonFont: TFont;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    FUseSkinFont: Boolean;
    FClientWidth: Integer;
    FClientHeight: Integer;
    FLines: TStrings;
    FSkinOpenDialog: TbsSkinOpenDialog;
    FSkinSaveDialog: TbsSkinSaveDialog;
    procedure SetLines(Value: TStrings);
    procedure SetClientWidth(Value: Integer);
    procedure SetClientHeight(Value: Integer);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultMemoFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    //
    procedure NewButtonClick(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    //
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
  published
    property SkinOpenDialog: TbsSkinOpenDialog
      read FSkinOpenDialog write FSkinOpenDialog;
    property SkinSaveDialog: TbsSkinSaveDialog
      read FSkinSaveDialog write FSkinSaveDialog;
    property ShowToolBar: Boolean read FShowToolBar write FShowToolBar;
    property Lines: TStrings read FLines write SetLines;
    property ClientWidth: Integer read FClientWidth write SetClientWidth;
    property ClientHeight: Integer read FClientHeight write SetClientHeight;
    property Caption: String read FCaption write FCaption;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write FButtonSkinDataName;
    property MemoSkinDataName: String
     read FMemoSkinDataName write FMemoSkinDataName;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultMemoFont: TFont read FDefaultMemoFont write SetDefaultMemoFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSkinConfirmDialog = class(TComponent)
  protected
    FCaption: String;
    FPassword1: String;
    FPassword1Caption: String;
    FPassword2: String;
    FPassword2Caption: String;
    FPasswordKind: TbsPasswordKind;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FButtonSkinDataName: String;
    FEditSkinDataName: String;
    FLabelSkinDataName: String;
    FDefaultLabelFont: TFont;
    FDefaultEditFont: TFont;
    FDefaultButtonFont: TFont;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    FUseSkinFont: Boolean;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultEditFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
  published
    property Password1: String read FPassword1 write FPassword1;
    property Password1Caption: String read FPassword1Caption write FPassword1Caption;
    property Password2: String read FPassword2 write FPassword2;
    property Password2Caption: String read FPassword2Caption write FPassword2Caption;
    property PasswordKind: TbsPasswordKind read FPasswordKind write FPasswordKind;
    property Caption: String read FCaption write FCaption;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String
      read FLabelSkinDataName write FLabelSkinDataName;
    property EditSkinDataName: String
     read FEditSkinDataName write FEditSkinDataName;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultEditFont: TFont read FDefaultEditFont write SetDefaultEditFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSelectSkinDlgForm = class(TForm)
  public
    BSF: TbsBusinessSkinForm;
    OpenButton, CancelButton: TbsSkinButton;
    PreviewForm: TForm;
    PreviewBSF: TbsBusinessSkinForm;
    PreviewSkinData: TbsSkinData;
    PreviewButton: TbsSkinButton;
    SkinsListBox: TbsSkinListBox;
    SkinList: TList;
    constructor CreateEx(AOwner: TComponent;  AForm: TForm;  ADefaultSkin: TbsCompressedStoredSkin;
                         ACtrlSkinData: TbsSkinData);
    destructor Destroy; override;
    function GetSelectedSkin: TbsCompressedStoredSkin;
    property SelectedSkin: TbsCompressedStoredSkin read GetSelectedSkin;
    procedure SLBOnChange(Sender: TObject);
    procedure SLBOnDblClick(Sender: TObject);
  end;

  TbsSelectSkinDialog = class(TComponent)
  private
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FDefaultFont: TFont;
    FTitle: String;
    FDlgFrm: TbsSelectSkinDlgForm;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FSelectedSkin: TbsCompressedStoredSkin;
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure SetDefaultFont(Value: TFont);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(DefaultCompressedSkin: TbsCompressedStoredSkin): Boolean;
    property SelectedSkin: TbsCompressedStoredSkin read FSelectedSkin;
  published
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property Title: string read GetTitle write SetTitle;
  end;

  TbsSkinSelectValueDialog = class(TComponent)
  private
    procedure SetSelectValues(const Value: TStrings);
  protected
    Form: TForm;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FButtonSkinDataName: String;
    FSelectSkinDataName: String;
    FLabelSkinDataName: String;
    FDefaultLabelFont: TFont;
    FDefaultSelectFont: TFont;
    FDefaultButtonFont: TFont;
    FDefaultValueIndex: Integer;
    FSelectValues: TStrings;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultSelectFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    function Execute(const ACaption, APrompt: string; var ValueIndex: Integer): Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String read FLabelSkinDataName write FLabelSkinDataName;
    property ComboboxSkinDataName: String read FSelectSkinDataName write FSelectSkinDataName;
    property SelectValues: TStrings read FSelectValues Write SetSelectValues;
    property DefaultValue: Integer read FDefaultValueIndex Write FDefaultValueIndex;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultComboBoxFont: TFont read FDefaultSelectFont write SetDefaultSelectFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSelectSkinsFromFoldersDlgForm = class(TForm)
  public
    FSkinsFolder: String;
    FIniFileName: String;
    BSF: TbsBusinessSkinForm;
    OpenButton, CancelButton: TbsSkinButton;
    PreviewForm: TForm;
    PreviewBSF: TbsBusinessSkinForm;
    PreviewSkinData: TbsSkinData;
    PreviewButton: TbsSkinButton;
    SkinsListBox: TbsSkinListBox;
    constructor CreateEx(AOwner: TComponent; ASkinsFolder, ADefaultSkinFolder, AIniFileName: String;
                         ACtrlSkinData: TbsSkinData);
    destructor Destroy; override;
    procedure SLBOnChange(Sender: TObject);
    procedure SLBOnDblClick(Sender: TObject);
  end;

  TbsSelectSkinsFromFoldersDialog = class(TComponent)
  private
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FDefaultFont: TFont;
    FTitle: String;
    FDlgFrm: TbsSelectSkinsFromFoldersDlgForm;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FFileName: String;
    FFolderName: String;
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure SetDefaultFont(Value: TFont);
  protected
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(ASkinsFolder, ADefaultSkinFolder, AIniFileName: String): Boolean;
    property FileName: String read FFileName;
    property FolderName: String read FFolderName;
  published
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property Title: string read GetTitle write SetTitle;
  end;

  TbsFindOption = (bsfrDown, bsfrFindNext, bsfrHideMatchCase, bsfrHideWholeWord,
    bsfrHideUpDown, bsfrMatchCase, bsfrDisableMatchCase, bsfrDisableUpDown,
    bsfrDisableWholeWord, bsfrReplace, bsfrReplaceAll, bsfrWholeWord);
  TbsFindOptions = set of TbsFindOption;

  TbsSkinFindDialog = class(TComponent)
  private
    FTitle: String;
    FOptions: TbsFindOptions;
    FPosition: TPoint;
    FOnFind: TNotifyEvent;
    FFindText: String;
    function GetFindText: string;
    function GetLeft: Integer;
    function GetPosition: TPoint;
    function GetTop: Integer;
    procedure SetFindText(const Value: string);
    procedure SetLeft(Value: Integer);
    procedure SetPosition(const Value: TPoint);
    procedure SetTop(Value: Integer);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure MatchCaseCheckBoxClick(Sender: TObject);
    procedure MatchWWOnlyCheckBoxClick(Sender: TObject);
    procedure DirecionUpClick(Sender: TObject);
    procedure DirecionDownClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure OnFormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditChange(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    //
    Form: TForm;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FEdit: TbsSkinEdit;
    FDefaultLabelFont: TFont;
    FDefaultButtonFont: TFont;
    FDefaultEditFont: TFont;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    MatchWWOnlyCheckBox, MatchCaseCheckBox: TbsSkinCheckRadioBox;
    FindButton: TbsSkinButton;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultEditFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    //
    procedure Find; dynamic;
    //
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    property Left: Integer read GetLeft write SetLeft;
    property Position: TPoint read GetPosition write SetPosition;
    property Top: Integer read GetTop write SetTop;
  published
    property FindText: string read GetFindText write SetFindText;
    property Options: TbsFindOptions read FOptions write FOptions default [bsfrDown];
    //
    property Title: string read GetTitle write SetTitle;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultEditFont: TFont read FDefaultEditFont write SetDefaultEditFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    //
    property OnFind: TNotifyEvent read FOnFind write FOnFind;
  end;

  TbsSkinReplaceDialog = class(TComponent)
  private
    FTitle: String;
    FOptions: TbsFindOptions;
    FPosition: TPoint;
    FOnFind: TNotifyEvent;
    FOnReplace: TNotifyEvent;
    FFindText: String;
    FReplaceText: String;
    function GetFindText: string;
    function GetReplaceText: string;
    function GetLeft: Integer;
    function GetPosition: TPoint;
    function GetTop: Integer;
    procedure SetFindText(const Value: string);
    procedure SetReplaceText(const Value: string);
    procedure SetLeft(Value: Integer);
    procedure SetPosition(const Value: TPoint);
    procedure SetTop(Value: Integer);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure MatchCaseCheckBoxClick(Sender: TObject);
    procedure MatchWWOnlyCheckBoxClick(Sender: TObject);
    procedure DirecionUpClick(Sender: TObject);
    procedure DirecionDownClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure ReplaceButtonClick(Sender: TObject);
    procedure ReplaceAllButtonClick(Sender: TObject);
    procedure OnFormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditChange(Sender: TObject);
    procedure ReplaceEditChange(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReplaceEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    //
    Form: TForm;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FEdit: TbsSkinEdit;
    FReplaceEdit: TbsSkinEdit;
    FDefaultLabelFont: TFont;
    FDefaultButtonFont: TFont;
    FDefaultEditFont: TFont;
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    MatchWWOnlyCheckBox, MatchCaseCheckBox: TbsSkinCheckRadioBox;
    CloseButton, FindButton, ReplaceButton, ReplaceAllButton: TbsSkinButton;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultEditFont(Value: TFont);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    //
    procedure Find; dynamic;
    procedure Replace; dynamic;
    //
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    property Left: Integer read GetLeft write SetLeft;
    property Position: TPoint read GetPosition write SetPosition;
    property Top: Integer read GetTop write SetTop;
  published
    property FindText: string read GetFindText write SetFindText;
    property ReplaceText: string read GetReplaceText write SetReplaceText;
    property Options: TbsFindOptions read FOptions write FOptions default [bsfrDown];
    //
    property Title: string read GetTitle write SetTitle;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultEditFont: TFont read FDefaultEditFont write SetDefaultEditFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    //
    property OnFind: TNotifyEvent read FOnFind write FOnFind;
    property OnReplace: TNotifyEvent read FOnReplace write FOnReplace;
  end;


implementation

{$R *.res}

Uses bsUtils, bsConst;

// script

const
  ScriptNames: array[0..18] of String =
   ('ANSI_CHARSET', 'DEFAULT_CHARSET', 'SYMBOL_CHARSET', 'SHIFTJIS_CHARSET',
    'HANGEUL_CHARSET', 'GB2312_CHARSET', 'CHINESEBIG5_CHARSET',
    'OEM_CHARSET', 'JOHAB_CHARSET', 'HEBREW_CHARSET', 'ARABIC_CHARSET',
    'GREEK_CHARSET', 'TURKISH_CHARSET', 'VIETNAMESE_CHARSET',
    'THAI_CHARSET', 'EASTEUROPE_CHARSET', 'RUSSIAN_CHARSET',
    'MAC_CHARSET', 'BALTIC_CHARSET');

  ScriptCodes: array[0..18] of TFontCharSet =
   (0, 1, 2, $80, 129, 134, 136, 255, 130, 177, 178, 161, 162, 163,
    222, 238, 204, 77, 186);


function GetIndexFromCharSet(CharSet: TFontCharSet): Integer;
var
  I: Integer;
begin
  Result := 1;
  for I := 0 to 18 do
    if CharSet =  ScriptCodes[I]
    then
      begin
        Result := I;
        Break;
      end;
end;

function GetCharSetFormIndex(Index: Integer): TFontCharSet;
begin
  if Index <> -1
  then
    Result := ScriptCodes[Index]
  else
    Result := 1;  
end;

//

constructor TbsSkinInputDialog.Create;
begin
  inherited Create(AOwner);

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FButtonSkinDataName := 'button';
  FLabelSkinDataName := 'stdlabel';
  FEditSkinDataName := 'edit';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultEditFont := TFont.Create;

  FUseSkinFont := False;

  with FDefaultLabelFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultButtonFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultEditFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSkinInputDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultEditFont.Free;
  inherited;
end;

procedure TbsSkinInputDialog.SetDefaultLabelFont;
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinInputDialog.SetDefaultEditFont;
begin
  FDefaultEditFont.Assign(Value);
end;

procedure TbsSkinInputDialog.SetDefaultButtonFont;
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinInputDialog.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;


function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

function TbsSkinInputDialog.InputQuery(const ACaption, APrompt: string; var Value: string): Boolean;
var

  BSF: TbsBusinessSkinForm;
  Prompt: TbsSkinStdLabel;
  Edit: TbsSkinEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Caption := ACaption;
  Form.Position := poScreenCenter;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  try

  with Form do
  begin
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);
    ClientWidth := MulDiv(180, DialogUnits.X, 4);
  end;

  Prompt := TbsSkinStdLabel.Create(Form);
  with Prompt do
  begin
    Parent := Form;
    Left := MulDiv(8, DialogUnits.X, 4);
    Top := MulDiv(8, DialogUnits.Y, 8);
    Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinDataName := FLabelSkinDataName;
    SkinData := CtrlSkinData;
    Caption := APrompt;
  end;

  Edit := TbsSkinEdit.Create(Form);
  with Edit do
  begin
    Parent := Form;
    DefaultFont := DefaultEditFont;
    UseSkinFont := Self.UseSkinFont;
    Left := Prompt.Left;
    Top := Prompt.Top + Prompt.Height + 5;
    DefaultWidth := MulDiv(164, DialogUnits.X, 4);
    MaxLength := 255;
    Text := Value;
    SelectAll;
    SkinDataName := FEditSkinDataName;
    SkinData := CtrlSkinData;
  end;

  ButtonTop := Edit.Top + Edit.Height + 15;
  ButtonWidth := MulDiv(50, DialogUnits.X, 4);
  ButtonHeight := MulDiv(14, DialogUnits.Y, 8);

  with TbsSkinButton.Create(Form) do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_OK')
    else
      Caption := BS_MSG_BTN_OK;
    ModalResult := mrOk;
    Default := True;
    SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
              ButtonHeight);
    DefaultHeight := ButtonHeight;
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
  end;

  with TbsSkinButton.Create(Form) do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_CANCEL')
    else
      Caption := BS_MSG_BTN_CANCEL;
    ModalResult := mrCancel;
    Cancel := True;
    SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
              ButtonWidth, ButtonHeight);
    DefaultHeight := ButtonHeight;
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 13;
  end;

  if Form.ShowModal = mrOk
  then
    begin
      Value := Edit.Text;
      Result := True;
    end
  else
    Result := False;

  finally
    Form.Free;
  end;
end;

function TbsSkinInputDialog.InputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := ADefault;
  InputQuery(ACaption, APrompt, Result);
end;

constructor TbsSkinPasswordDialog.Create;
begin
  inherited Create(AOwner);

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  LoginMode := False;

  FCaption := 'Password';

  FPasswordCaption := 'Password:';
  FPassword := '';

  FLoginCaption := 'Login name:';
  FLogin := '';

  FButtonSkinDataName := 'button';
  FLabelSkinDataName := 'stdlabel';
  FEditSkinDataName := 'edit';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultEditFont := TFont.Create;

  FUseSkinFont := False;

  with FDefaultLabelFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultButtonFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultEditFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSkinPasswordDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultEditFont.Free;
  inherited;
end;

procedure TbsSkinPasswordDialog.SetDefaultLabelFont;
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinPasswordDialog.SetDefaultEditFont;
begin
  FDefaultEditFont.Assign(Value);
end;

procedure TbsSkinPasswordDialog.SetDefaultButtonFont;
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinPasswordDialog.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

function TbsSkinPasswordDialog.Execute: Boolean;
var
  Form: TForm;
  BSF: TbsBusinessSkinForm;
  Image: TImage;
  LoginLabel, PasswordLabel: TbsSkinStdLabel;
  LoginEdit:  TbsSkinEdit;
  PasswordEdit: TbsSkinPasswordEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  LeftOffset: Integer;
begin
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Caption := FCaption;
  Form.Position := poScreenCenter;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  try

  with Form do
  begin
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);

    Image := TImage.Create(Form);

    with Image do
    begin
      Parent := Form;
      Top := MulDiv(8, DialogUnits.Y, 8);
      Left := MulDiv(8, DialogUnits.X, 4);
      AutoSize := True;
      Transparent := True;
      Picture.Bitmap.Handle := LoadBitMap(HInstance, 'BS_KEY');
    end;

    LeftOffset := Image.Width + Image.Left;

    ClientWidth := LeftOffset + MulDiv(180, DialogUnits.X, 4);
  end;

  if FLoginMode
  then
    begin
      LoginLabel := TbsSkinStdLabel.Create(Form);
      with LoginLabel do
      begin
        Parent := Form;
        Left := LeftOffset + MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        DefaultFont := DefaultLabelFont;
        UseSkinFont := Self.UseSkinFont;
        SkinDataName := FLabelSkinDataName;
        SkinData := CtrlSkinData;
        Caption := FLoginCaption;
      end;

      LoginEdit := TbsSkinMaskEdit.Create(Form);
      with LoginEdit do
      begin
         Parent := Form;
         DefaultFont := DefaultEditFont;
         UseSkinFont := Self.UseSkinFont;
         Left := LoginLabel.Left;
         Top := LoginLabel.Top + LoginLabel.Height + 5;
         DefaultWidth := MulDiv(164, DialogUnits.X, 4);
         MaxLength := 255;
         Text := FLogin;
         SelectAll;
         SkinDataName := FEditSkinDataName;
         SkinData := CtrlSkinData;
       end;
    end;

  PasswordLabel := TbsSkinStdLabel.Create(Form);
  with PasswordLabel do
  begin
    Parent := Form;
    Left := LeftOffset + MulDiv(8, DialogUnits.X, 4);
    if FLoginMode and (LoginEdit <> nil)
    then
      Top := LoginEdit.Top + LoginEdit.Height + 5
    else
      Top := MulDiv(8, DialogUnits.Y, 8);
    Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinDataName := FLabelSkinDataName;
    SkinData := CtrlSkinData;
    Caption := FPasswordCaption;
  end;

  PasswordEdit := TbsSkinPasswordEdit.Create(Form);
  with PasswordEdit do
  begin
    Parent := Form;
    PasswordKind := Self.PasswordKind;
    DefaultFont := DefaultEditFont;
    UseSkinFont := Self.UseSkinFont;
    Left := PasswordLabel.Left;
    Top := PasswordLabel.Top + PasswordLabel.Height + 5;
    DefaultWidth := MulDiv(164, DialogUnits.X, 4);
    MaxLength := 255;
    Text := FPassword;
    SelectAll;
    SkinDataName := FEditSkinDataName;
    SkinData := CtrlSkinData;
  end;

  ButtonTop := PasswordEdit.Top + PasswordEdit.Height + 15;
  ButtonWidth := MulDiv(50, DialogUnits.X, 4);
  ButtonHeight := MulDiv(14, DialogUnits.Y, 8);

  with TbsSkinButton.Create(Form) do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_OK')
    else
      Caption := BS_MSG_BTN_OK;
    ModalResult := mrOk;
    Default := True;
    SetBounds(LeftOffset + MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
              ButtonHeight);
    DefaultHeight := ButtonHeight;
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
  end;

  with TbsSkinButton.Create(Form) do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_CANCEL')
    else
      Caption := BS_MSG_BTN_CANCEL;
    ModalResult := mrCancel;
    Cancel := True;
    SetBounds(LeftOffset + MulDiv(92, DialogUnits.X, 4), PasswordEdit.Top + PasswordEdit.Height + 15,
              ButtonWidth, ButtonHeight);
    DefaultHeight := ButtonHeight;
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 13;
    Image.Top := Form.ClientHeight div 2 - Image.Height div 2; 
  end;

  if Form.ShowModal = mrOk
  then
    begin
      if FLoginMode then FLogin := LoginEdit.Text;
      FPassword := PasswordEdit.Text;
      Result := True;
    end
  else
    Result := False;

  finally
    Form.Free;
  end;
end;


constructor TbsSkinProgressDialog.Create;
begin
  inherited Create(AOwner);

  FShowType := stStayOnTop;
  FShowCancelButton := True;
  FShowCloseButton := True;

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  Form := nil;
  Gauge := nil;
  FExecute := False;

  FMinValue := 0;
  FMaxValue := 100;
  FValue := 0;

  FCaption := 'Process';
  FLabelCaption := 'Name of process:';
  FShowPercent := True;

  FButtonSkinDataName := 'button';
  FLabelSkinDataName := 'stdlabel';
  FGaugeSkinDataName := 'gauge';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultGaugeFont := TFont.Create;

  FUseSkinFont := False;

  with FDefaultLabelFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultButtonFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultGaugeFont do
  begin
    Name := '宋体';
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSkinProgressDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultGaugeFont.Free;
  inherited;
end;

procedure TbsSkinProgressDialog.SetValue(AValue: Integer);
begin
  FValue := AValue;
  if FExecute
  then
    begin
      Gauge.Value := FValue;
      if Gauge.Value = Gauge.MaxValue
      then
        if FShowType = stModal
        then
          Form.ModalResult := mrOk
        else
          Form.Close;  
    end;  
end;

procedure TbsSkinProgressDialog.Close;
begin
  Form.Close;
end;

procedure TbsSkinProgressDialog.SetDefaultLabelFont;
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinProgressDialog.SetDefaultGaugeFont;
begin
  FDefaultGaugeFont.Assign(Value);
end;

procedure TbsSkinProgressDialog.SetDefaultButtonFont;
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinProgressDialog.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

procedure TbsSkinProgressDialog.OnFormShow(Sender: TObject);
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

procedure TbsSkinProgressDialog.CancelBtnClick(Sender: TObject);
begin
  Form.Close;
  if Assigned(FOnCancel) then FOnCancel(Self);
end;

procedure TbsSkinProgressDialog.OnFormClose;
begin
  FExecute := False;
  Gauge := nil;
  Form := nil;
  if Value <> MaxValue
  then
    if Assigned(FOnCancel) then FOnCancel(Self);
  Action := caFree;
end;

function TbsSkinProgressDialog.Execute;
var
  BSF: TbsBusinessSkinForm;
  Prompt: TbsSkinStdLabel;
  DialogUnits: TPoint;
  ButtonWidth, ButtonHeight: Integer;
begin
  if FExecute then Exit;
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  if FShowType = stStayOnTop
  then
     begin
       Form.FormStyle := fsStayOnTop;
       Form.OnClose := OnFormClose;
     end;
  Form.Caption := FCaption;
  Form.Position := poScreenCenter;
  Form.OnShow := OnFormShow;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  if not FShowCloseButton then BSF.HideCaptionButtons := True;
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  try

  with Form do
  begin
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);
    ClientWidth := MulDiv(180, DialogUnits.X, 4);
  end;

  Prompt := TbsSkinStdLabel.Create(Form);
  with Prompt do
  begin
    Parent := Form;
    Left := MulDiv(8, DialogUnits.X, 4);
    Top := MulDiv(8, DialogUnits.Y, 8);
    Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinDataName := FLabelSkinDataName;
    SkinData := CtrlSkinData;
    Caption := FLabelCaption;
  end;

  Gauge := TbsSkinGauge.Create(Form);
  with Gauge do
  begin
    Parent := Form;
    MinValue := FMinValue;
    MaxValue := FMaxValue;
    ShowPercent := FShowPercent;
    Value := FValue;
    DefaultFont := DefaultGaugeFont;
    UseSkinFont := Self.UseSkinFont;
    Left := Prompt.Left;
    Top := Prompt.Top + Prompt.Height + 5;
    DefaultWidth := MulDiv(164, DialogUnits.X, 4);
    SkinDataName := FGaugeSkinDataName;
    SkinData := CtrlSkinData;
  end;

  ButtonWidth := MulDiv(50, DialogUnits.X, 4);
  ButtonHeight := MulDiv(14, DialogUnits.Y, 8);

  if FShowCancelButton
  then
    begin
      with TbsSkinButton.Create(Form) do
      begin
        Parent := Form;
        DefaultFont := DefaultButtonFont;
        UseSkinFont := Self.UseSkinFont;
        if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
        then
         Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_CANCEL')
        else
         Caption := BS_MSG_BTN_CANCEL;
        if FShowType = stStayOnTop then OnClick := CancelBtnClick;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(Gauge.Left + Gauge.Width - ButtonWidth, Gauge.Top + Gauge.Height + 15,
                  ButtonWidth, ButtonHeight);
        DefaultHeight := ButtonHeight;
        SkinDataName := FButtonSkinDataName;
        SkinData := CtrlSkinData;
        Form.ClientHeight := Top + Height + 13;
      end;
    end
  else
    Form.ClientHeight := Gauge.Top + Gauge.Height + 15;

  FExecute := True;

  if FShowType = stModal
  then
    begin
      if Form.ShowModal = mrOk then Result := True else Result := False;
      FExecute := False;
    end
  else
    begin
      Form.Show;
    end;

  finally
    if FShowType = stModal
    then
      begin
        Form.Free;
        Gauge := nil;
        Form := nil;
      end;  
  end;
end;

constructor TbsFontDlgForm.CreateEx;
var
  I: Integer;
  ResStrData: TbsResourceStrData;
begin
  inherited CreateNew(AOwner);
  if (ACtrlSkinData <> nil) and (ACtrlSkinData.ResourceStrData <> nil)
  then
    ResStrData := ACtrlSkinData.ResourceStrData
  else
    ResStrData := nil;
  KeyPreview := True;
  BorderStyle := bsDialog;
  Position := poScreenCenter;
  BSF := TbsBusinessSkinForm.Create(Self);

  FontColorLabel := TbsSkinStdLabel.Create(Self);
  with FontColorLabel do
  begin
    Left := 5;
    Top := 50;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('FONTDLG_COLOR')
    else
      Caption := BS_FONTDLG_COLOR;
    AutoSize := True;
    Parent := Self;
  end;

  FontColorBox := TbsSkinColorComboBox.Create(Self);
  with FontColorBox do
  begin
    Left := 5;
    Top := 65;
    Width := 90;
    DefaultHeight := 21;
    Parent := Self;
    ShowNames := False;
    ExStyle := [bscbCustomColor, bscbPrettyNames, bscbStandardColors];;
    OnChange := FontColorChange;
  end;

  FontNameLabel := TbsSkinStdLabel.Create(Self);
  with FontNameLabel do
  begin
    Left := 5;
    Top := 5;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('FONTDLG_NAME')
    else
      Caption := BS_FONTDLG_NAME;
    AutoSize := True;
    Parent := Self;
  end;

  FontNameBox := TbsSkinFontComboBox.Create(Self);
  with FontNameBox do
  begin
    Left := 5;
    Top := 20;
    Width := 200;
    DefaultHeight := 21;
    Parent := Self;
    PopulateList;
    TabOrder := 0;
    TabStop := True;
    OnChange := FontNameChange;
  end;

  FontSizeLabel := TbsSkinStdLabel.Create(Self);
  with FontSizeLabel do
  begin
    Left := 5;
    Top := 95;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('FONTDLG_SIZE')
    else
      Caption := BS_FONTDLG_SIZE;
    AutoSize := True;
    Parent := Self;
  end;

  FontSizeEdit := TbsSkinSpinEdit.Create(Self);
  with  FontSizeEdit do
  begin
    MinValue := -128;
    MaxValue := 128;
    Increment := 2;
    Left := 5;
    Top := 110;
    Parent := Self;
    Width := 90;
    OnChange := FontSizeChange;
  end;

  FontHeightLabel := TbsSkinStdLabel.Create(Self);
  with FontHeightLabel do
  begin
    Left := 110;
    Top := 95;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('FONTDLG_HEIGHT')
    else
      Caption := BS_FONTDLG_Height;
    AutoSize := True;
    Parent := Self;
  end;

  FontHeightEdit := TbsSkinSpinEdit.Create(Self);
  with FontHeightEdit do
  begin
    MinValue := -500;
    MaxValue := 500;
    Left := 110;
    Top := 110;
    Width := 95;
    Parent := Self;
    OnChange := FontHeightChange;
  end;

  ScriptLabel := TbsSkinStdLabel.Create(Self);
  with ScriptLabel do
  begin
    Left := 5;
    Top := 140;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('FONTDLG_SCRIPT')
    else
      Caption := BS_FONTDLG_SCRIPT;
    AutoSize := True;
    Parent := Self;
  end;

  ScriptComboBox := TbsSkinComboBox.Create(Self);
  with ScriptComboBox do
  begin
    Left := 5;
    Top := 155;
    Width := 200;
    DefaultHeight := 21;
    Parent := Self;
    TabOrder := 4;
    TabStop := True;
    for I := 0 to 18 do
      Items.Add(ScriptNames[I]);
    OnChange := FontScriptChange;
  end;

  FontExLabel := TbsSkinStdLabel.Create(Self);
  with FontExLabel do
  begin
    Left := 210;
    Top := 50;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('FONTDLG_EXAMPLE')
    else
      Caption := BS_FONTDLG_EXAMPLE;
    AutoSize := True;
    Parent := Self;
  end;

  FontExamplePanel := TbsSkinPanel.Create(Self);
  with FontExamplePanel do
  begin
    Parent := Self;
    BorderStyle := bvFrame;
    Left := 210;
    Top := 65;
    Width := 185;
    Height := 67;
  end;

  FontExampleLabel := TLabel.Create(Self);
  with FontExampleLabel do
  begin
    Parent := FontExamplePanel;
    Transparent := True;
    Align := alClient;
    Caption := 'AaBbYyZz';
  end;

  OkButton := TbsSkinButton.Create(Self);
  with OkButton do
  begin
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_BTN_OK')
    else
      Caption := BS_MSG_BTN_OK;
    CanFocused := True;
    Left := 225;
    Top := 190;
    Width := 75;
    DefaultHeight := 25;
    Parent := Self;
    ModalResult := mrOk;
  end;

  CancelButton := TbsSkinButton.Create(Self);
  with CancelButton do
  begin
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_BTN_CANCEL')
    else
      Caption := BS_MSG_BTN_CANCEL;
    CanFocused := True;
    Left := 315;
    Top := 190;
    Width := 75;
    DefaultHeight := 25;
    Parent := Self;
    ModalResult := mrCancel;
    Cancel := True;
  end;

  FontStyleLabel := TbsSkinStdLabel.Create(Self);
  with FontStyleLabel do
  begin
    Left := 210;
    Top := 5;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('FONTDLG_STYLE')
    else
      Caption := BS_FONTDLG_STYLE;
    AutoSize := True;
    Parent := Self;
  end;

  BoldButton := TbsSkinSpeedButton.Create(Self);
  with BoldButton do
  begin
    Parent := Self;
    AllowAllUp := True;
    DefaultWidth := 25;
    DefaultHeight := 25;
    SkinDataName := 'toolbutton';
    GroupIndex := 1;
    NumGlyphs := 1;
    Left := 245;
    Top := 20;
    Glyph.LoadFromResourceName(HInstance, 'BS_BOLD');
    OnClick := BoldButtonClick;
  end;

  ItalicButton := TbsSkinSpeedButton.Create(Self);
  with ItalicButton do
  begin
    Parent := Self;
    AllowAllUp := True;
    DefaultWidth := 25;
    DefaultHeight := 25;
    SkinDataName := 'toolbutton';
    GroupIndex := 1;
    NumGlyphs := 1;
    Left := 275;
    Top := 20;
    Glyph.LoadFromResourceName(HInstance, 'BS_ITALIC');
    OnClick := ItalicButtonClick;
  end;

  UnderLineButton := TbsSkinSpeedButton.Create(Self);
  with UnderLineButton do
  begin
    Parent := Self;
    AllowAllUp := True;
    DefaultWidth := 25;
    DefaultHeight := 25;
    SkinDataName := 'toolbutton';
    GroupIndex := 1;
    NumGlyphs := 1;
    Left := 305;
    Top := 20;
    Glyph.LoadFromResourceName(HInstance, 'BS_UNDERLINE');
    OnClick := UnderLineButtonClick;
  end;

  StrikeOutButton := TbsSkinSpeedButton.Create(Self);
  with StrikeOutButton do
  begin
    Parent := Self;
    AllowAllUp := True;
    DefaultWidth := 25;
    DefaultHeight := 25;
    SkinDataName := 'toolbutton';
    GroupIndex := 1;
    NumGlyphs := 1;
    Left := 335;
    Top := 20;
    Glyph.LoadFromResourceName(HInstance, 'BS_STRIKEOUT');
    OnClick := StrikeOutButtonClick;
  end;

end;

procedure TbsFontDlgForm.FontSizeChange(Sender: TObject);
begin
  FontExampleLabel.Font.Size := Trunc(FontSizeEdit.Value);
  FontHeightEdit.SimpleSetValue(FontExampleLabel.Font.Height);
end;

procedure TbsFontDlgForm.FontHeightChange(Sender: TObject);
begin
  FontExampleLabel.Font.Height := Trunc(FontHeightEdit.Value);
  FontSizeEdit.SimpleSetValue(FontExampleLabel.Font.Size);
end;

procedure TbsFontDlgForm.FontNameChange(Sender: TObject);
begin
  FontExampleLabel.Font.Name := FontNameBox.FontName;
end;

procedure TbsFontDlgForm.FontScriptChange(Sender: TObject);
begin
  FontExampleLabel.Font.Charset := GetCharSetFormIndex(ScriptComboBox.ItemIndex);
end;


procedure TbsFontDlgForm.FontColorChange(Sender: TObject);
begin
  FontExampleLabel.Font.Color := FontColorBox.Selected;
end;

procedure TbsFontDlgForm.BoldButtonClick(Sender: TObject);
begin
  if BoldButton.Down
  then
    FontExampleLabel.Font.Style := FontExampleLabel.Font.Style + [fsBold]
  else
    FontExampleLabel.Font.Style := FontExampleLabel.Font.Style - [fsBold];
end;

procedure TbsFontDlgForm.ItalicButtonClick(Sender: TObject);
begin
  if ItalicButton.Down
  then
    FontExampleLabel.Font.Style := FontExampleLabel.Font.Style + [fsItalic]
  else
    FontExampleLabel.Font.Style := FontExampleLabel.Font.Style - [fsItalic];
end;

procedure TbsFontDlgForm.StrikeOutButtonClick(Sender: TObject);
begin
  if StrikeOutButton.Down
  then
    FontExampleLabel.Font.Style := FontExampleLabel.Font.Style + [fsStrikeOut]
  else
    FontExampleLabel.Font.Style := FontExampleLabel.Font.Style - [fsStrikeOut];
end;

procedure TbsFontDlgForm.UnderLineButtonClick(Sender: TObject);
begin
  if UnderLineButton.Down
  then
    FontExampleLabel.Font.Style := FontExampleLabel.Font.Style + [fsUnderLine]
  else
    FontExampleLabel.Font.Style := FontExampleLabel.Font.Style - [fsUnderLine];
end;

constructor TbsSkinFontDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;
  FTitle := 'Font';
  FDefaultFont := TFont.Create;
  FFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
  FShowSizeEdit := True;
  FShowHeightEdit := False;
end;

destructor TbsSkinFontDialog.Destroy;
begin
  FDefaultFont.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure TbsSkinFontDialog.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSkinFontDialog.SetFont;
begin
  FFont.Assign(Value);
end;

procedure TbsSkinFontDialog.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

function TbsSkinFontDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSkinFontDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

procedure TbsSkinFontDialog.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TbsSkinFontDialog.Execute: Boolean;
var
  FW, FH: Integer;
begin
  FDlgFrm := TbsFontDlgForm.CreateEx(Application, CtrlSkinData);
  with FDlgFrm do
  try
    Caption := Self.Title;
    BSF.BorderIcons := [];
    BSF.SkinData := FSD;
    BSF.MenusSkinData := CtrlSkinData;
    BSF.AlphaBlend := AlphaBlend;
    BSF.AlphaBlendAnimation := AlphaBlendAnimation;
    BSF.AlphaBlendValue := AlphaBlendValue;
    //
    ScriptComboBox.SkinData := FCtrlFSD;
    FontNameBox.SkinData := FCtrlFSD;
    FontColorBox.SkinData := FCtrlFSD;
    FontSizeEdit.SkinData := FCtrlFSD;
    FontHeightEdit.SkinData := FCtrlFSD;
    FontExamplePanel.SkinData := FCtrlFSD;
    OkButton.SkinData := FCtrlFSD;
    CancelButton.SkinData := FCtrlFSD;
    BoldButton.SkinData := FCtrlFSD;
    ItalicButton.SkinData := FCtrlFSD;
    UnderLineButton.SkinData := FCtrlFSD;
    StrikeOutButton.SkinData := FCtrlFSD;
    //
    FontHeightLabel.SkinData := FCtrlFSD;
    FontSizeLabel.SkinData := FCtrlFSD;
    FontStyleLabel.SkinData := FCtrlFSD;
    FontNameLabel.SkinData := FCtrlFSD;
    FontColorLabel.SkinData := FCtrlFSD;
    FontExLabel.SkinData := FCtrlFSD;
    ScriptLabel.SkinData := FCtrlFSD;
    //
    ScriptComboBox.ItemIndex := GetIndexFromCharSet(Self.Font.CharSet);
    //
    FontExampleLabel.Font.Assign(Self.Font);
    FontNameBox.FontName := FontExampleLabel.Font.Name;
    FontColorBox.Selected := FontExampleLabel.Font.Color;
    FontSizeEdit.SimpleSetValue(FontExampleLabel.Font.Size);
    FontHeightEdit.SimpleSetValue(FontExampleLabel.Font.Height);
    FontSizeEdit.Visible := FShowSizeEdit;
    FontHeightEdit.Visible := FShowHeightEdit;
    FontHeightLabel.Visible := FShowHeightEdit;
    FontSizeLabel.Visible := FShowSizeEdit;
    //
    if fsBold in FontExampleLabel.Font.Style
    then
      BoldButton.Down := True;
    if fsItalic in FontExampleLabel.Font.Style
    then
      ItalicButton.Down := True;
    if fsStrikeOut in FontExampleLabel.Font.Style
    then
      StrikeOutButton.Down := True;
    if fsUnderLine in FontExampleLabel.Font.Style
    then
      UnderLineButton.Down := True;
    //
    FW := 400;
    FH := 230;
    if (SkinData <> nil) and not SkinData.Empty
    then
      begin
        if FW < BSF.GetMinWidth then FW := BSF.GetMinWidth;
        if FH < BSF.GetMinHeight then FH := BSF.GetMinHeight;
      end;
    ClientWidth := FW;
    ClientHeight := FH;
    //
    Result := (ShowModal = mrOk);
    if Result
    then
      begin
        Self.Font.Assign(FontExampleLabel.Font);
        Change;
      end;
  finally
    Free;
    FDlgFrm := nil;
  end;
end;

constructor TbsSkinTextDialog.Create;
begin
  inherited Create(AOwner);
  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  Memo := nil;

  FSkinOpenDialog := nil;
  FSkinSaveDialog := nil;

  FClientWidth := 350;
  FClientHeight := 200;

  FLines := TStringList.Create;

  FCaption := 'Input text';

  FButtonSkinDataName := 'button';
  FMemoSkinDataName := 'memo';

  FDefaultButtonFont := TFont.Create;
  FDefaultMemoFont := TFont.Create;

  FUseSkinFont := False;

  ShowToolBar := True;

  with FDefaultButtonFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultMemoFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSkinTextDialog.Destroy;
begin
  FDefaultMemoFont.Free;
  FDefaultButtonFont.Free;
  FLines.Free;
  inherited;
end;

procedure TbsSkinTextDialog.NewButtonClick(Sender: TObject);
begin
  Memo.Clear;
end;

procedure TbsSkinTextDialog.OpenButtonClick(Sender: TObject);
var
  OD: TOpenDialog;
begin
  if FSkinOpenDialog <> nil
  then
    begin
      if FSkinOpenDialog.Execute
      then Memo.Lines.LoadFromFile(FSkinOpenDialog.FileName);
    end
  else
    begin
      OD := TOpenDialog.Create(Self);
      OD.Filter := '*.txt|*.txt|*.*|*.*';
      if OD.Execute then Memo.Lines.LoadFromFile(OD.FileName);
      OD.Free;
    end;
end;

procedure TbsSkinTextDialog.SaveButtonClick(Sender: TObject);
var
  SD: TSaveDialog;
begin
  if FSkinSaveDialog <> nil
  then
    begin
      if FSkinSaveDialog.Execute
      then Memo.Lines.LoadFromFile(FSkinSaveDialog.FileName);
    end
  else
    begin
      SD := TSaveDialog.Create(Self);
      SD.Filter := '*.txt|*.txt|*.*|*.*';
      if SD.Execute then Memo.Lines.SaveToFile(SD.FileName);
      SD.Free;
    end;  
end;
procedure TbsSkinTextDialog.CopyButtonClick(Sender: TObject);
begin
  Memo.CopyToClipboard;
end;

procedure TbsSkinTextDialog.CutButtonClick(Sender: TObject);
begin
  Memo.CutToClipboard;
end;

procedure TbsSkinTextDialog.PasteButtonClick(Sender: TObject);
begin
  Memo.PasteFromClipboard;
end;

procedure TbsSkinTextDialog.DeleteButtonClick(Sender: TObject);
begin
  Memo.ClearSelection;
end;

procedure TbsSkinTextDialog.SetLines(Value: TStrings);
begin
  FLines.Assign(Value);
end;

procedure TbsSkinTextDialog.SetClientWidth(Value: Integer);
begin
  if Value > 0 then FClientWidth := Value;
end;

procedure TbsSkinTextDialog.SetClientHeight(Value: Integer);
begin
  if Value > 0 then FClientHeight := Value;
end;

procedure TbsSkinTextDialog.SetDefaultMemoFont;
begin
  FDefaultMemoFont.Assign(Value);
end;

procedure TbsSkinTextDialog.SetDefaultButtonFont;
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinTextDialog.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
  if (Operation = opRemove) and (AComponent = FSkinOpenDialog) then FSkinOpenDialog := nil;
  if (Operation = opRemove) and (AComponent = FSkinSaveDialog) then FSkinSaveDialog := nil;
end;

function TbsSkinTextDialog.Execute: Boolean;
var
  Form: TForm;
  BSF: TbsBusinessSkinForm;
  ButtonWidth, ButtonHeight: Integer;
  Panel: TbsSkinPanel;
  HMemoScrollBar, VMemoScrollBar: TbsSkinScrollBar;
  ToolPanel: TbsSkinPanel;
begin
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Caption := FCaption;
  Form.Position := poScreenCenter;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;
  //

  try

  with Form do
  begin
    ClientWidth := FClientWidth;
    ClientHeight := FClientHeight;
    ButtonWidth := 80;
    ButtonHeight := 25;

    with TbsSkinButton.Create(Form) do
    begin
      Parent := Form;
      DefaultFont := DefaultButtonFont;
      UseSkinFont := Self.UseSkinFont;
      if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
      then
        Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_OK')
      else
        Caption := BS_MSG_BTN_OK;
      DefaultHeight := ButtonHeight;
      ModalResult := mrOk;
      Default := True;
      SkinDataName := FButtonSkinDataName;
      SkinData := CtrlSkinData;
      SetBounds(FClientWidth - ButtonWidth * 2 - 20, FClientHeight - Height - 10,
                ButtonWidth, Height);
    end;

    with TbsSkinButton.Create(Form) do
    begin
      Parent := Form;
      DefaultFont := DefaultButtonFont;
      UseSkinFont := Self.UseSkinFont;
      if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
      then
        Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_CANCEL')
      else
        Caption := BS_MSG_BTN_CANCEL;
      DefaultHeight := ButtonHeight;
      ModalResult := mrCancel;
      Cancel := True;
      SkinDataName := FButtonSkinDataName;
      SkinData := CtrlSkinData;
      SetBounds(FClientWidth - ButtonWidth - 10, FClientHeight - Height - 10,
                ButtonWidth, Height);
      ButtonHeight := Height;          
    end;

    Panel := TbsSkinPanel.Create(Form);
    with Panel do
    begin
      Parent := Form;
      Align := alTop;
      SkinData := CtrlSkinData;
    end;

    if FShowToolBar
    then
      begin
        ToolPanel := TbsSkinPanel.Create(Form);
        with ToolPanel do
        begin
          Parent := Form;
          Align := alTop;
          DefaultHeight := 25;
          SkinDataName := 'toolpanel';
          SkinData := CtrlSkinData;
        end;

        with TbsSkinSpeedButton.Create(Form) do
        begin
          Parent := ToolPanel;
          DefaultWidth := 27;
          SkinDataName := 'toolbutton';
          Align := alLeft;
          OnClick := NewButtonClick;
          NumGlyphs := 1;
          Glyph.LoadFromResourceName(HInstance, 'BS_NEW');
          SkinData := CtrlSkinData;
        end;

        with TbsSkinSpeedButton.Create(Form) do
        begin
          Parent := ToolPanel;
          DefaultWidth := 27;
          SkinDataName := 'toolbutton';
          Align := alLeft;
          OnClick := OpenButtonClick;
          NumGlyphs := 1;
          Glyph.LoadFromResourceName(HInstance, 'BS_OPEN');
          SkinData := CtrlSkinData;
        end;

        with TbsSkinSpeedButton.Create(Form) do
        begin
          Parent := ToolPanel;
          DefaultWidth := 27;
          SkinDataName := 'toolbutton';
          Align := alLeft;
          OnClick := SaveButtonClick;
          NumGlyphs := 1;
          Glyph.LoadFromResourceName(HInstance, 'BS_SAVE');
          SkinData := CtrlSkinData;
        end;

        with TbsSkinBevel.Create(Form) do
        begin
          Parent := ToolPanel;
          Width := 24;
          Align := alLeft;
          DividerMode := True;
          Shape := bsLeftLine;
          SkinData := CtrlSkinData;
        end;

        with TbsSkinSpeedButton.Create(Form) do
        begin
          Parent := ToolPanel;
          DefaultWidth := 27;
          SkinDataName := 'toolbutton';
          Align := alLeft;
          OnClick := CopyButtonClick;
          NumGlyphs := 1;
          Glyph.LoadFromResourceName(HInstance, 'BS_COPY');
          SkinData := CtrlSkinData;
        end;

        with TbsSkinSpeedButton.Create(Form) do
        begin
          Parent := ToolPanel;
          DefaultWidth := 27;
          SkinDataName := 'toolbutton';
          Align := alLeft;
          OnClick := CutButtonClick;
          NumGlyphs := 1;
          Glyph.LoadFromResourceName(HInstance, 'BS_CUT');
          SkinData := CtrlSkinData;
        end;

        with TbsSkinSpeedButton.Create(Form) do
        begin
          Parent := ToolPanel;
          DefaultWidth := 27;
          SkinDataName := 'toolbutton';
          Align := alLeft;
          OnClick := PasteButtonClick;
          NumGlyphs := 1;
          Glyph.LoadFromResourceName(HInstance, 'BS_PASTE');
          SkinData := CtrlSkinData;
        end;

        with TbsSkinSpeedButton.Create(Form) do
        begin
          Parent := ToolPanel;
          DefaultWidth := 27;
          SkinDataName := 'toolbutton';
          Align := alLeft;
          OnClick := DeleteButtonClick;
          NumGlyphs := 1;
          Glyph.LoadFromResourceName(HInstance, 'BS_DELETE');
          SkinData := CtrlSkinData;
        end;

      end;

    with Panel do
    begin
      if FShowToolBar
      then
        Height := FClientHeight -  ButtonHeight - 20 - ToolPanel.Height
      else
        Height := FClientHeight -  ButtonHeight - 20;
    end;

    VMemoScrollBar := TbsSkinScrollBar.Create(Form);
    with VMemoScrollBar do
    begin
      Kind := sbVertical;
      Parent := Panel;
      Align := alRight;
      DefaultWidth := 19;
      Enabled := False;
      SkinDataName := 'vscrollbar';
      SkinData := CtrlSkinData;
    end;

    HMemoScrollBar := TbsSkinScrollBar.Create(Form);
    with HMemoScrollBar do
    begin
      Parent := Panel;
      Align := alBottom;
      DefaultHeight := 19;
      Enabled := False;
      BothMarkerWidth := 19;
      Both := True;
      SkinDataName := 'bothhscrollbar';
      SkinData := CtrlSkinData;
    end;

    Memo := TbsSkinMemo2.Create(Form);
    with Memo do
    begin
      Parent := Panel;
      Lines.Assign(Self.Lines);
      Align := alClient;
      HScrollBar := HMemoScrollBar;
      VScrollBar := VMemoScrollBar;
      SkinData := CtrlSkinData;
    end;

  end;

  if Form.ShowModal = mrOk
  then
    begin
      Self.Lines.Assign(Memo.Lines);
      Result := True;
    end
  else
    Result := False;

  finally
    Form.Free;
  end;
end;

// ===================== TbsSkinConfirmDialog ==================== //

constructor TbsSkinConfirmDialog.Create;
begin
  inherited Create(AOwner);

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FCaption := 'Confirm password';

  FPassword1Caption := 'Enter password:';
  FPassword1 := '';

  FPassword2Caption := 'Confirm password: ';
  FPassword2:= '';

  FButtonSkinDataName := 'button';
  FLabelSkinDataName := 'stdlabel';
  FEditSkinDataName := 'edit';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultEditFont := TFont.Create;

  FUseSkinFont := False;

  with FDefaultLabelFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultButtonFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultEditFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSkinConfirmDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultEditFont.Free;
  inherited;
end;

procedure TbsSkinConfirmDialog.SetDefaultLabelFont;
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinConfirmDialog.SetDefaultEditFont;
begin
  FDefaultEditFont.Assign(Value);
end;

procedure TbsSkinConfirmDialog.SetDefaultButtonFont;
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinConfirmDialog.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

function TbsSkinConfirmDialog.Execute: Boolean;
var
  Form: TForm;
  BSF: TbsBusinessSkinForm;
  Image: TImage;
  Password1Label, Password2Label: TbsSkinStdLabel;
  Password1Edit, Password2Edit: TbsSkinPasswordEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  LeftOffset: Integer;
begin
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Caption := FCaption;
  Form.Position := poScreenCenter;

  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  try

  with Form do
  begin
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);

    Image := TImage.Create(Form);

    with Image do
    begin
      Parent := Form;
      Top := MulDiv(8, DialogUnits.Y, 8);
      Left := MulDiv(8, DialogUnits.X, 4);
      AutoSize := True;
      Transparent := True;
      Picture.Bitmap.Handle := LoadBitMap(HInstance, 'BS_KEY');
    end;

    LeftOffset := Image.Width + Image.Left;

    ClientWidth := LeftOffset + MulDiv(180, DialogUnits.X, 4);
  end;


  Password1Label := TbsSkinStdLabel.Create(Form);
  with Password1Label do
  begin
     Parent := Form;
     Left := LeftOffset + MulDiv(8, DialogUnits.X, 4);
     Top := MulDiv(8, DialogUnits.Y, 8);
     Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
     DefaultFont := DefaultLabelFont;
     UseSkinFont := Self.UseSkinFont;
     SkinDataName := FLabelSkinDataName;
     SkinData := CtrlSkinData;
     Caption := FPassword1Caption;
   end;

   Password1Edit := TbsSkinPasswordEdit.Create(Form);
   with Password1Edit do
   begin
     Parent := Form;
     PasswordKind := Self.PasswordKind;
     DefaultFont := DefaultEditFont;
     UseSkinFont := Self.UseSkinFont;
     Left := Password1Label.Left;
     Top := Password1Label.Top + Password1Label.Height + 5;
     DefaultWidth := MulDiv(164, DialogUnits.X, 4);
     MaxLength := 255;
     Text := FPassword1;
     SelectAll;
     SkinDataName := FEditSkinDataName;
     SkinData := CtrlSkinData;
    end;

  Password2Label := TbsSkinStdLabel.Create(Form);
  with Password2Label do
  begin
    Parent := Form;
    Left := LeftOffset + MulDiv(8, DialogUnits.X, 4);
    Top := Password1Edit.Top + Password1Edit.Height + 5;
    Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinDataName := FLabelSkinDataName;
    SkinData := CtrlSkinData;
    Caption := FPassword2Caption;
  end;

  Password2Edit := TbsSkinPasswordEdit.Create(Form);
  with Password2Edit do
  begin
    Parent := Form;
    PasswordKind := Self.PasswordKind;
    DefaultFont := DefaultEditFont;
    UseSkinFont := Self.UseSkinFont;
    Left := Password2Label.Left;
    Top := Password2Label.Top + Password2Label.Height + 5;
    DefaultWidth := MulDiv(164, DialogUnits.X, 4);
    MaxLength := 255;
    Text := FPassword2;
    SelectAll;
    SkinDataName := FEditSkinDataName;
    SkinData := CtrlSkinData;
  end;

  ButtonTop := Password2Edit.Top + Password2Edit.Height + 15;
  ButtonWidth := MulDiv(50, DialogUnits.X, 4);
  ButtonHeight := MulDiv(14, DialogUnits.Y, 8);

  with TbsSkinButton.Create(Form) do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_OK')
    else
      Caption := BS_MSG_BTN_OK;
    ModalResult := mrOk;
    Default := True;
    SetBounds(LeftOffset + MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
              ButtonHeight);
    DefaultHeight := ButtonHeight;
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
  end;

  with TbsSkinButton.Create(Form) do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
     if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_CANCEL')
    else
      Caption := BS_MSG_BTN_CANCEL;
    ModalResult := mrCancel;
    Cancel := True;
    SetBounds(LeftOffset + MulDiv(92, DialogUnits.X, 4), Password2Edit.Top + Password2Edit.Height + 15,
              ButtonWidth, ButtonHeight);
    DefaultHeight := ButtonHeight;
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 13;
    Image.Top := Form.ClientHeight div 2 - Image.Height div 2;
  end;

  if Form.ShowModal = mrOk
  then
    begin
      FPassword1 := Password1Edit.Text;
      FPassword2 := Password2Edit.Text;
      Result := True;
    end
  else
    Result := False;

  finally
    Form.Free;
  end;
end;


// TbsSelectSkinDialog

constructor TbsSelectSkinDlgForm.CreateEx;
var
  I, Idx: Integer;
  S: String;
  ResStrData: TbsResourceStrData;
begin
  inherited CreateNew(AOwner);
  Position := poScreenCenter;

  if (ACtrlSkinData <> nil) and (ACtrlSkinData.ResourceStrData <> nil)
  then
    ResStrData := ACtrlSkinData.ResourceStrData
  else
    ResStrData := nil;

  BorderStyle := bsSingle;
  SkinList := TList.Create;

  BSF := TbsBusinessSkinForm.Create(Self);

  PreviewForm := TForm.Create(Self);
  with PreviewForm do
  begin
    Parent := Self;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_PREVIEWSKIN')
    else
      Caption := BS_MSG_PREVIEWSKIN;
    Enabled := False;
    Width :=  220;
    Height := 170;
    Visible := False;
  end;

  PreviewSkinData := TbsSkinData.Create(Self);
  if ResStrData <> nil
  then
    PreviewSkinData.ResourceStrData := ResStrData;

  PreviewButton := TbsSkinButton.Create(Self);
  with PreviewButton do
  begin
    Parent := PreviewForm;
    Width := 100;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_PREVIEWBUTTON')
    else
      Caption := BS_MSG_PREVIEWBUTTON;
    Left := 20;
    Top := 20;
    SkinData := PreviewSkinData;
  end;

  PreviewBSF := TbsBusinessSkinForm.Create(PreviewForm);
  with PreviewBSF do
  begin
    SkinData := PreviewSkinData;
    PreviewMode := True;
  end;

  OpenButton := TbsSkinButton.Create(Self);
  with OpenButton do
  begin
    Default := True;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_BTN_OK')
    else
      Caption := BS_MSG_BTN_OK;
    CanFocused := True;
    Left := 260;
    Top := 200;
    Width := 70;
    DefaultHeight := 25;
    Parent := Self;
    ModalResult := mrOK;
  end;

  CancelButton := TbsSkinButton.Create(Self);
  with CancelButton do
  begin
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_BTN_CANCEL')
    else
      Caption := BS_MSG_BTN_CANCEL;
    CanFocused := True;
    Left := 340;
    Top := 200;
    Width := 70;
    DefaultHeight := 25;
    Parent := Self;
    ModalResult := mrCancel;
    Cancel := True;
  end;

  SkinsListBox := TbsSkinListBox.Create(Self);
  with SkinsListBox do
  begin
    Parent := Self;
    SetBounds(10, 10, 170, 170);
    OnListboxClick := SLBOnChange;
    OnListboxDblClick := SLBOnDblClick;
  end;

  // load skins
  Idx := 0;
  for I := 0 to AForm.ComponentCount - 1 do
  if AForm.Components[I] is TbsCompressedStoredSkin
  then
    begin
      SkinList.Add(TbsCompressedStoredSkin(AForm.Components[I]));
      with TbsCompressedStoredSkin(AForm.Components[I]) do
      begin
        if Description <> '' then S := Description else S := Name;
        SkinsListBox.Items.Add(S);
      end;
      if TbsCompressedStoredSkin(AForm.Components[I]) = ADefaultSkin
      then
        Idx := SkinsListBox.Items.Count - 1;
    end;
  SkinsListBox.ItemIndex := Idx;
  PreviewSkinData.CompressedStoredSkin := SkinList[SkinsListBox.ItemIndex];
  //
  with PreviewForm do
  begin
    Left := 190;
    Top := 10;
    Visible := True;
   end;
  //
  ActiveControl := SkinsListBox.ListBox;
end;

destructor TbsSelectSkinDlgForm.Destroy;
begin
  SkinList.Clear;
  SkinList.Free;
  inherited;
end;

procedure TbsSelectSkinDlgForm.SLBOnDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TbsSelectSkinDlgForm.SLBOnChange(Sender: TObject);
begin
  PreviewSkinData.CompressedStoredSkin := SkinList[SkinsListBox.ItemIndex];
end;

function TbsSelectSkinDlgForm.GetSelectedSkin;
begin
  Result := PreviewSkinData.CompressedStoredSkin;
end;

constructor TbsSelectSkinDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;
  FTitle := 'Select skin';
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSelectSkinDialog.Destroy;
begin
  FDefaultFont.Free;
  inherited Destroy;
end;

procedure TbsSelectSkinDialog.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSelectSkinDialog.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

function TbsSelectSkinDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSelectSkinDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

function TbsSelectSkinDialog.Execute;
var
  FW, FH, CIndex: Integer;
  Path: String;
begin
  FDlgFrm := TbsSelectSkinDlgForm.CreateEx(Application, TForm(Owner), DefaultCompressedSkin, CtrlSkinData);
  with FDlgFrm do
  try
    Caption := Self.Title;
    BSF.BorderIcons := [];
    BSF.SkinData := FSD;
    BSF.MenusSkinData := CtrlSkinData;
    BSF.AlphaBlend := AlphaBlend;
    BSF.AlphaBlendAnimation := AlphaBlendAnimation;
    BSF.AlphaBlendValue := AlphaBlendValue;
    //
    OpenButton.DefaultFont := DefaultFont;
    CancelButton.DefaultFont := DefaultFont;
    SkinsListBox.DefaultFont := DefaultFont;
    //
    OpenButton.SkinData := CtrlSkinData;
    CancelButton.SkinData := CtrlSkinData;
    SkinsListBox.SkinData := CtrlSkinData;

    FW := 420;
    FH := 240;

    if (SkinData <> nil) and not SkinData.Empty
    then
      begin
        if FW < BSF.GetMinWidth then FW := BSF.GetMinWidth;
        if FH < BSF.GetMinHeight then FH := BSF.GetMinHeight;
      end;

    ClientWidth := FW;
    ClientHeight := FH;

    FSelectedSkin := nil;

    if FDlgFrm.ShowModal = mrOk
    then
      begin
        Result := True;
        FSelectedSkin := FDlgFrm.SelectedSkin;
      end
    else
      Result := False;

  finally
    Free;
    FDlgFrm := nil;
  end;
end;

constructor TbsSkinSelectValueDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FButtonSkinDataName := 'button';
  FLabelSkinDataName  := 'stdlabel';
  FSelectSkinDataName := 'combobox';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultSelectFont := TFont.Create;

  FSelectValues := TStringList.Create;
  FDefaultValueIndex := -1;
  FUseSkinFont := False;

  with FDefaultLabelFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultButtonFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultSelectFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSkinSelectValueDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultSelectFont.Free;
  FSelectValues.Free;
  inherited;
end;

function TbsSkinSelectValueDialog.Execute(const ACaption, APrompt: string; var ValueIndex: Integer): Boolean;
var
  BSF: TbsBusinessSkinForm;
  Prompt: TbsSkinStdLabel;
  Combobox: TbsSkinComboBox;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Caption := ACaption;
  Form.Position := poScreenCenter;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  try
    with Form Do
    begin
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
    end;

    Prompt := TbsSkinStdLabel.Create(Form);
    with Prompt do
    begin
      Parent := Form;
      Left := MulDiv(8, DialogUnits.X, 4);
      Top := MulDiv(8, DialogUnits.Y, 8);
      Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
      WordWrap := False;
      DefaultFont := DefaultLabelFont;
      UseSkinFont := Self.UseSkinFont;
      SkinDataName := FLabelSkinDataName;
      SkinData := CtrlSkinData;
      Caption := APrompt;
    end;

    Combobox := TbsSkinCombobox.Create(Form);
    with Combobox do
    begin
      Parent := Form;
      DefaultFont := DefaultComboboxFont;
      UseSkinFont := Self.UseSkinFont;
      Left := Prompt.Left;
      Top := Prompt.Top + Prompt.Height + 5;
      DefaultWidth := MulDiv(164, DialogUnits.X, 4);
      Items.Assign(Self.SelectValues);
      Combobox.ItemIndex := FDefaultValueIndex;
      SkinDataName := FSelectSkinDataName;
      SkinData := CtrlSkinData;
    end;

    ButtonTop := Combobox.Top + Combobox.Height + 15;
    ButtonWidth := MulDiv(50, DialogUnits.X, 4);
    ButtonHeight := MulDiv(14, DialogUnits.Y, 8);

    with TbsSkinButton.Create(Form) do
    begin
      Parent := Form;
      DefaultFont:= DefaultButtonFont;
      UseSkinFont := Self.UseSkinFont;
      if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
      then
        Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_OK')
      else
        Caption := BS_MSG_BTN_OK;
      ModalResult := mrOk;
      Default := True;
      SetBounds(MulDiv(38, DialogUnits.X, 4),
        ButtonTop, ButtonWidth, ButtonHeight);
      DefaultHeight := ButtonHeight;
      SkinDataName := FButtonSkinDataName;
      SkinData := CtrlSkinData;
    end;

    with TbsSkinButton.Create(Form) do
    begin
      Parent := Form;
      DefaultFont := DefaultButtonFont;
      UseSkinFont := Self.UseSkinFont;
      if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
      then
        Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_CANCEL')
      else
        Caption := BS_MSG_BTN_CANCEL;
      ModalResult := mrCancel;
      Cancel := True;
      SetBounds(MulDiv(92, DialogUnits.X, 4), Combobox.Top + Combobox.Height + 15,
                ButtonWidth, ButtonHeight);
      DefaultHeight := ButtonHeight;
      SkinDataName := FButtonSkinDataName;
      SkinData := CtrlSkinData;
      Form.ClientHeight := Top + Height + 13;
    end;

    if Form.ShowModal = mrOk
    then
      begin
        ValueIndex := Combobox.ItemIndex;
        Result := True;
      end
    else
      Result := False;
  finally
    Form.Free;
  end;
end;

procedure TbsSkinSelectValueDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

procedure TbsSkinSelectValueDialog.SetDefaultButtonFont(Value: TFont);
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinSelectValueDialog.SetDefaultLabelFont(Value: TFont);
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinSelectValueDialog.SetDefaultSelectFont(Value: TFont);
begin
  FDefaultSelectFont.Assign(Value);
end;

procedure TbsSkinSelectValueDialog.SetSelectValues(const Value: TStrings);
begin
  FSelectValues.Assign(Value);
end;


// TbsSelectSkinsFromFolderDialog

constructor TbsSelectSkinsFromFoldersDlgForm.CreateEx;
var
  Idx: Integer;
  BSR: TSearchRec;
  ResStrData: TbsResourceStrData;
begin
  inherited CreateNew(AOwner);
  Position := poScreenCenter;

  BorderStyle := bsSingle;

  BSF := TbsBusinessSkinForm.Create(Self);

  if (ACtrlSkinData <> nil) and (ACtrlSkinData.ResourceStrData <> nil)
  then
    ResStrData := ACtrlSkinData.ResourceStrData
  else
    ResStrData := nil;

  PreviewForm := TForm.Create(Self);
  with PreviewForm do
  begin
    Parent := Self;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_PREVIEWSKIN')
    else
      Caption := BS_MSG_PREVIEWSKIN;
    Enabled := False;
    Width :=  220;
    Height := 170;
    Visible := False;
  end;

  PreviewSkinData := TbsSkinData.Create(Self);
  if ResStrData <> nil
  then
    PreviewSkinData.ResourceStrData := ResStrData;

  PreviewButton := TbsSkinButton.Create(Self);
  with PreviewButton do
  begin
    Parent := PreviewForm;
    Width := 100;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_PREVIEWBUTTON')
    else
      Caption := BS_MSG_PREVIEWBUTTON;
    Left := 20;
    Top := 20;
    SkinData := PreviewSkinData;
  end;

  PreviewBSF := TbsBusinessSkinForm.Create(PreviewForm);
  with PreviewBSF do
  begin
    SkinData := PreviewSkinData;
    PreviewMode := True;
  end;

  OpenButton := TbsSkinButton.Create(Self);
  with OpenButton do
  begin
    Default := True;
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_BTN_OK')
    else
      Caption := BS_MSG_BTN_OK;
    CanFocused := True;
    Left := 260;
    Top := 200;
    Width := 70;
    DefaultHeight := 25;
    Parent := Self;
    ModalResult := mrOK;
  end;

  CancelButton := TbsSkinButton.Create(Self);
  with CancelButton do
  begin
    if ResStrData <> nil
    then
      Caption := ResStrData.GetResStr('MSG_BTN_CANCEL')
    else
      Caption := BS_MSG_BTN_CANCEL;
    CanFocused := True;
    Left := 340;
    Top := 200;
    Width := 70;
    DefaultHeight := 25;
    Parent := Self;
    ModalResult := mrCancel;
    Cancel := True;
  end;

  SkinsListBox := TbsSkinListBox.Create(Self);
  with SkinsListBox do
  begin
    Parent := Self;
    SetBounds(10, 10, 170, 170);
    OnListboxClick := SLBOnChange;
    OnListboxDblClick := SLBOnDblClick;
  end;

  FIniFileName := AIniFileName;

  // load skins
  FSkinsFolder := ASkinsFolder;
  if FSkinsFolder = '' then FSkinsFolder := ExtractFilePath(ParamStr(0));
  Idx := -1;
  SkinsListBox.Clear;
  if FindFirst(FSkinsFolder + '*.*', faAnyFile, BSR) = 0 then begin
    while True do begin
      if (BSR.Attr and faDirectory <> 0) and (BSR.Name <> '.') and (BSR.Name <> '..') then begin
        SkinsListBox.Items.Add(BSR.Name);
      end;
      if BSR.Name = ADefaultSkinFolder then Idx := SkinsListBox.Items.Count - 1;
      if FindNext(BSR) <> 0 then Break;
    end;
    FindClose(BSR);
  end;
  if Idx = -1
  then SkinsListBox.ItemIndex := 0
  else SkinsListBox.ItemIndex := Idx;
  SLBOnChange(Self);
  //
  with PreviewForm do
  begin
    Left := 190;
    Top := 10;
    Visible := True;
   end;
  //
  ActiveControl := SkinsListBox.ListBox;
end;

destructor TbsSelectSkinsFromFoldersDlgForm.Destroy;
begin
  inherited;
end;

procedure TbsSelectSkinsFromFoldersDlgForm.SLBOnDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TbsSelectSkinsFromFoldersDlgForm.SLBOnChange(Sender: TObject);
var
  BFN: String;
begin
  if (SkinsListBox.Items.Count > 0) and (SkinsListBox.ItemIndex <> -1)
  then
    begin
      BFN := FSkinsFolder + SkinsListBox.Items[SkinsListBox.ItemIndex] + '\' + FIniFileName;
      PreviewSkinData.LoadFromFile(BFN);
    end;  
end;

constructor TbsSelectSkinsFromFoldersDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFileName := '';
  FFolderName := '';
  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;
  FTitle := 'Select skin';
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSelectSkinsFromFoldersDialog.Destroy;
begin
  FDefaultFont.Free;
  inherited Destroy;
end;

procedure TbsSelectSkinsFromFoldersDialog.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;

procedure TbsSelectSkinsFromFoldersDialog.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

function TbsSelectSkinsFromFoldersDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSelectSkinsFromFoldersDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

function TbsSelectSkinsFromFoldersDialog.Execute;
var
  FW, FH: Integer;
begin
  FDlgFrm := TbsSelectSkinsFromFoldersDlgForm.CreateEx(Application, ASkinsFolder, ADefaultSkinFolder, AIniFileName, CtrlSkinData);
  with FDlgFrm do
  try
    Caption := Self.Title;
    BSF.BorderIcons := [];
    BSF.SkinData := FSD;
    BSF.MenusSkinData := CtrlSkinData;
    BSF.AlphaBlend := AlphaBlend;
    BSF.AlphaBlendAnimation := AlphaBlendAnimation;
    BSF.AlphaBlendValue := AlphaBlendValue;
    //
    OpenButton.DefaultFont := DefaultFont;
    CancelButton.DefaultFont := DefaultFont;
    SkinsListBox.DefaultFont := DefaultFont;
    //
    OpenButton.SkinData := CtrlSkinData;
    CancelButton.SkinData := CtrlSkinData;
    SkinsListBox.SkinData := CtrlSkinData;

    FW := 420;
    FH := 240;

    if (SkinData <> nil) and not SkinData.Empty
    then
      begin
        if FW < BSF.GetMinWidth then FW := BSF.GetMinWidth;
        if FH < BSF.GetMinHeight then FH := BSF.GetMinHeight;
      end;

    ClientWidth := FW;
    ClientHeight := FH;

    if (FDlgFrm.ShowModal = mrOk) and (SkinsListBox.Items.Count > 0) and
       (SkinsListBox.ItemIndex <> -1)
    then
      begin
        FFolderName := SkinsListBox.Items[SkinsListBox.ItemIndex];
        FFileName := FSkinsFolder +
          SkinsListBox.Items[SkinsListBox.ItemIndex] + '\' + AIniFileName;
        Result := True;
      end
    else
      Result := False;

  finally
    Free;
    FDlgFrm := nil;
  end;
end;

// TbsSkinFindDialog

constructor TbsSkinFindDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [bsfrDown];
  FPosition.X := -1;
  FPosition.Y := -1;
  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultEditFont := TFont.Create;

  FUseSkinFont := False;

  with FDefaultLabelFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultButtonFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

 with FDefaultEditFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  FTitle := 'Find';

  Form := nil;
end;

destructor TbsSkinFindDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultEditFont.Free;
  inherited Destroy;
end;

procedure TbsSkinFindDialog.OnFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form := nil;
  Action := caFree;
end;

procedure TbsSkinFindDialog.CloseButtonClick(Sender: TObject);
begin
  Form.Close;
end;

procedure TbsSkinFindDialog.FindButtonClick(Sender: TObject);
begin
  Find;
end;

function TbsSkinFindDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSkinFindDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

procedure TbsSkinFindDialog.DirecionUpClick(Sender: TObject);
begin
  Options := Options - [bsfrDown];
end;

procedure TbsSkinFindDialog.DirecionDownClick(Sender: TObject);
begin
  Options := Options + [bsfrDown];
end;

procedure TbsSkinFindDialog.MatchCaseCheckBoxClick(Sender: TObject);
begin
  if MatchCaseCheckBox.Checked
  then
    Options := Options + [bsfrMatchCase]
  else
    Options := Options - [bsfrMatchCase];
end;

procedure TbsSkinFindDialog.MatchWWOnlyCheckBoxClick(Sender: TObject);
begin
  if MatchWWOnlyCheckBox.Checked
  then
    Options := Options + [bsfrWholeWord]
  else
    Options := Options - [bsfrWholeWord];
end;

procedure TbsSkinFindDialog.EditChange;
begin
  FFindText := FEdit.Text;
  FindButton.Enabled := FFindText <> '';
end;

procedure TbsSkinFindDialog.EditKeyDown;
begin
  if Key = 13 then Find;
end;

function TbsSkinFindDialog.Execute: Boolean;
var
  BSF: TbsBusinessSkinForm;
  DialogUnits: TPoint;
  DirectionGroupBox: TbsSkinGroupBox;
begin

  if Form <> nil then Exit;

  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.FormStyle := fsStayOnTop;
  Form.OnClose := OnFormClose;
  Form.Caption := FTitle;
  if (Self.FPosition.X > -1) and (Self.FPosition.Y > -1)
  then
    begin
      Form.Left := FPosition.X;
      Form.Top := FPosition.Y;
    end
  else
    Form.Position := poScreenCenter;
    
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  with Form Do
  begin
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);
    ClientWidth := 380;
  end;

  with TbsSkinStdLabel.Create(Form) do
  begin
    Parent := Form;
    Left := 10;
    Top := 17;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_WHAT')
    else
      Caption := BS_FIND_WHAT;
  end;

  FEdit := TbsSkinEdit.Create(Form);
  with FEdit do
  begin
    Parent := Form;
    SkinData := CtrlSkinData;
    DefaultFont := DefaultlabelFont;
    UseSkinFont := Self.UseSkinFont;
    Left := 80;
    Top := 15;
    Width := Form.ClientWidth - 180;
    DefaultHeight := 21;
    MaxLength := 255;
    Text := FFindText;
    OnKeyDown := EditKeydown;
    OnChange := EditChange;
  end;

  MatchWWOnlyCheckBox := TbsSkinCheckRadioBox.Create(Self);
  with MatchWWOnlyCheckBox do
  begin
    Parent := Form;
    Left := 5;
    Top := 50;
    Width := 160;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_MATCH_WHOLE_WORD_ONLY')
    else
      Caption := BS_FIND_MATCH_WHOLE_WORD_ONLY;
    Visible := not (bsfrHideWholeWord in Options);
    Checked := bsfrWholeWord in Options;
    OnClick := MatchWWOnlyCheckBoxClick;
  end;

  MatchCaseCheckBox := TbsSkinCheckRadioBox.Create(Self);
  with MatchCaseCheckBox do
  begin
    Parent := Form;
    Left := 5;
    Top := 80;
    Width := 160;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_MATCH_CASE')
    else
      Caption := BS_FIND_MATCH_CASE;
    Visible := not (bsfrHideMatchCase in Options);
    Checked := bsfrMatchCase in Options;
    OnClick := MatchCaseCheckBoxClick;
  end;

  DirectionGroupBox := TbsSkinGroupBox.Create(Self);

  with DirectionGroupBox do
  begin
    Parent := Form;
    Left := 160;
    Top := 50;
    Width := 120;
    Height := 55;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_DIRECTION')
    else
      Caption := BS_FIND_DIRECTION;
    Visible := not (bsfrHideUpDown in Options);
    Enabled := not (bsfrDisableUpDown in Options);
  end;

  with TbsSkinCheckRadioBox.Create(Self) do
  begin
    GroupIndex := 1;
    Parent := DirectionGroupBox;
    Left := 5;
    Top := DirectionGroupBox.GetSkinClientRect.Top + 2;
    Width := RectWidth(DirectionGroupBox.GetSkinClientRect) div 2 - 5;
    Height := RectHeight(DirectionGroupBox.GetSkinClientRect) - 2;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_DIRECTIONUP')
    else
      Caption := BS_FIND_DIRECTIONUP;
    Checked := not (bsfrDown in Options);
    OnClick := DirecionUpClick;
  end;

  with TbsSkinCheckRadioBox.Create(Self) do
  begin
    GroupIndex := 1;
    Parent := DirectionGroupBox;
    Left := DirectionGroupBox.Width div 2 - 10 + 5;
    Top := DirectionGroupBox.GetSkinClientRect.Top + 2;
    Width := RectWidth(DirectionGroupBox.GetSkinClientRect) div 2;
    Height := RectHeight(DirectionGroupBox.GetSkinClientRect) - 2;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_DIRECTIONDOWN')
    else
      Caption := BS_FIND_DIRECTIONDOWN;
    Checked := bsfrDown in Options;
    OnClick := DirecionDownClick;  
  end;

  FindButton := TbsSkinButton.Create(Form);
  with FindButton do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_NEXT')
    else
      Caption := BS_FIND_NEXT;
    SetBounds(Form.ClientWidth - 90, 15, 80, 25);
    DefaultHeight := 21;
    SkinData := CtrlSkinData;
    OnClick := FindButtonClick;
    Enabled := FFindText <> '';
  end;

  with TbsSkinButton.Create(Form) do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_CLOSE')
    else
      Caption := BS_MSG_BTN_CLOSE;
    Cancel := True;
    SetBounds(Form.ClientWidth - 90, 50, 80, 25);
    DefaultHeight := 21;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 45;
    OnClick := CloseButtonClick;
  end;

  Form.Show;

  Result := True;
end;

procedure TbsSkinFindDialog.Find;
begin
  if Assigned(FOnFind) then FOnFind(Self);
end;

function TbsSkinFindDialog.GetFindText: string;
begin
  Result := FFindText;
end;

function TbsSkinFindDialog.GetLeft: Integer;
begin
  Result := Position.X;
end;

function TbsSkinFindDialog.GetPosition: TPoint;
var
  Rect: TRect;
begin
  Result := FPosition;
  if Form <> nil then
  begin
    Result.X := Form.Left;
    Result.Y := Form.Top;
  end;
end;

function TbsSkinFindDialog.GetTop: Integer;
begin
  Result := Position.Y;
end;

procedure TbsSkinFindDialog.SetFindText(const Value: string);
begin
  FFindText := Value;
end;

procedure TbsSkinFindDialog.SetLeft(Value: Integer);
begin
  SetPosition(Point(Value, Top));
end;

procedure TbsSkinFindDialog.SetPosition(const Value: TPoint);
begin
  if (FPosition.X <> Value.X) or (FPosition.Y <> Value.Y) then
  begin
    FPosition := Value;
    if Form <> nil
    then
      begin
        Form.Left := FPosition.X;
        Form.Top := FPosition.Y;
      end;
  end;
end;

procedure TbsSkinFindDialog.SetTop(Value: Integer);
begin
  SetPosition(Point(Left, Value));
end;

procedure TbsSkinFindDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

procedure TbsSkinFindDialog.SetDefaultButtonFont(Value: TFont);
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinFindDialog.SetDefaultEditFont(Value: TFont);
begin
  FDefaultEditFont.Assign(Value);
end;

procedure TbsSkinFindDialog.SetDefaultLabelFont(Value: TFont);
begin
  FDefaultLabelFont.Assign(Value);
end;

// TbsSkinReplaceDialog

constructor TbsSkinReplaceDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOptions := [bsfrDown];
  FPosition.X := -1;
  FPosition.Y := -1;
  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultEditFont := TFont.Create;

  FUseSkinFont := False;

  with FDefaultLabelFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  with FDefaultButtonFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

 with FDefaultEditFont do
  begin
    Name := '宋体';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;

  FTitle := 'Replace';

  FFindText := '';
  FReplaceText := '';

  Form := nil;
end;

destructor TbsSkinReplaceDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultEditFont.Free;
  inherited Destroy;
end;

procedure TbsSkinReplaceDialog.OnFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form := nil;
  Action := caFree;
end;

procedure TbsSkinReplaceDialog.CloseButtonClick(Sender: TObject);
begin
  Form.Close;
end;

procedure TbsSkinReplaceDialog.FindButtonClick(Sender: TObject);
begin
  Find;
end;

function TbsSkinReplaceDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSkinReplaceDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

procedure TbsSkinReplaceDialog.DirecionUpClick(Sender: TObject);
begin
  Options := Options - [bsfrDown];
end;

procedure TbsSkinReplaceDialog.DirecionDownClick(Sender: TObject);
begin
  Options := Options + [bsfrDown];
end;

procedure TbsSkinReplaceDialog.MatchCaseCheckBoxClick(Sender: TObject);
begin
  if MatchCaseCheckBox.Checked
  then
    Options := Options + [bsfrMatchCase]
  else
    Options := Options - [bsfrMatchCase];
end;

procedure TbsSkinReplaceDialog.MatchWWOnlyCheckBoxClick(Sender: TObject);
begin
  if MatchWWOnlyCheckBox.Checked
  then
    Options := Options + [bsfrWholeWord]
  else
    Options := Options - [bsfrWholeWord];
end;

procedure TbsSkinReplaceDialog.EditChange;
begin
  FFindText := FEdit.Text;
  FindButton.Enabled := FFindText <> '';
  ReplaceButton.Enabled := FFindText <> '';
  ReplaceAllButton.Enabled := FFindText <> '';
end;

procedure TbsSkinReplaceDialog.EditKeyDown;
begin
  if Key = 13 then Find;
end;

procedure TbsSkinReplaceDialog.ReplaceEditKeyDown;
begin
  if Key = 13 then Find;
end;

procedure TbsSkinReplaceDialog.ReplaceEditChange;
begin
  FReplaceText := FReplaceEdit.Text;
end;

procedure TbsSkinReplaceDialog.ReplaceButtonClick(Sender: TObject);
begin
  Options := Options + [bsfrReplace] - [bsfrReplaceAll];
  Replace;
end;

procedure TbsSkinReplaceDialog.ReplaceAllButtonClick(Sender: TObject);
begin
  Options := Options - [bsfrReplace] + [bsfrReplaceAll];
  Replace;
end;

function TbsSkinReplaceDialog.Execute: Boolean;
var
  BSF: TbsBusinessSkinForm;
  DialogUnits: TPoint;
  DirectionGroupBox: TbsSkinGroupBox;
begin

  if Form <> nil then Exit;

  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.FormStyle := fsStayOnTop;
  Form.OnClose := OnFormClose;
  Form.Caption := FTitle;
  if (Self.FPosition.X > -1) and (Self.FPosition.Y > -1)
  then
    begin
      Form.Left := FPosition.X;
      Form.Top := FPosition.Y;
    end
  else
    Form.Position := poScreenCenter;
    
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  with Form Do
  begin
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);
    ClientWidth := 380;
  end;

  with TbsSkinStdLabel.Create(Form) do
  begin
    Parent := Form;
    Left := 10;
    Top := 17;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_WHAT')
    else
      Caption := BS_FIND_WHAT;
  end;

  FEdit := TbsSkinEdit.Create(Form);
  with FEdit do
  begin
    Parent := Form;
    SkinData := CtrlSkinData;
    DefaultFont := DefaultlabelFont;
    UseSkinFont := Self.UseSkinFont;
    Left := 80;
    Top := 15;
    Width := Form.ClientWidth - 180;
    DefaultHeight := 21;
    MaxLength := 255;
    Text := FFindText;
    OnKeyDown := EditKeydown;
    OnChange := EditChange;
  end;

  with TbsSkinStdLabel.Create(Form) do
  begin
    Parent := Form;
    Left := 10;
    Top := 53;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_REPLACE_WITH')
    else
      Caption := BS_FIND_REPLACE_WITH;
  end;

  FReplaceEdit := TbsSkinEdit.Create(Form);
  with FReplaceEdit do
  begin
    Parent := Form;
    SkinData := CtrlSkinData;
    DefaultFont := DefaultlabelFont;
    UseSkinFont := Self.UseSkinFont;
    Left := 80;
    Top := 50;
    Width := Form.ClientWidth - 180;
    DefaultHeight := 21;
    MaxLength := 255;
    Text := FReplaceText;
    OnKeyDown := ReplaceEditKeydown;
    OnChange := ReplaceEditChange;
  end;

  MatchWWOnlyCheckBox := TbsSkinCheckRadioBox.Create(Self);
  with MatchWWOnlyCheckBox do
  begin
    Parent := Form;
    Left := 5;
    Top := 90;
    Width := 160;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_MATCH_WHOLE_WORD_ONLY')
    else
      Caption := BS_FIND_MATCH_WHOLE_WORD_ONLY;
    Visible := not (bsfrHideWholeWord in Options);
    Checked := bsfrWholeWord in Options;
    OnClick := MatchWWOnlyCheckBoxClick;
  end;

  MatchCaseCheckBox := TbsSkinCheckRadioBox.Create(Self);
  with MatchCaseCheckBox do
  begin
    Parent := Form;
    Left := 5;
    Top := 120;
    Width := 160;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_MATCH_CASE')
    else
      Caption := BS_FIND_MATCH_CASE;
    Visible := not (bsfrHideMatchCase in Options);
    Checked := bsfrMatchCase in Options;
    OnClick := MatchCaseCheckBoxClick;
  end;

  DirectionGroupBox := TbsSkinGroupBox.Create(Self);

  with DirectionGroupBox do
  begin
    Parent := Form;
    Left := 160;
    Top := 90;
    Width := 120;
    Height := 55;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_DIRECTION')
    else
      Caption := BS_FIND_DIRECTION;
    Visible := not (bsfrHideUpDown in Options);
    Enabled := not (bsfrDisableUpDown in Options);
  end;

  with TbsSkinCheckRadioBox.Create(Self) do
  begin
    GroupIndex := 1;
    Parent := DirectionGroupBox;
    Left := 5;
    Top := DirectionGroupBox.GetSkinClientRect.Top + 2;
    Width := RectWidth(DirectionGroupBox.GetSkinClientRect) div 2 - 5;
    Height := RectHeight(DirectionGroupBox.GetSkinClientRect) - 2;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_DIRECTIONUP')
    else
      Caption := BS_FIND_DIRECTIONUP;
    Checked := not (bsfrDown in Options);
    OnClick := DirecionUpClick;
  end;

  with TbsSkinCheckRadioBox.Create(Self) do
  begin
    GroupIndex := 1;
    Parent := DirectionGroupBox;
    Left := DirectionGroupBox.Width div 2 - 10 + 5;
    Top := DirectionGroupBox.GetSkinClientRect.Top + 2;
    Width := RectWidth(DirectionGroupBox.GetSkinClientRect) div 2;
    Height := RectHeight(DirectionGroupBox.GetSkinClientRect) - 2;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_DIRECTIONDOWN')
    else
      Caption := BS_FIND_DIRECTIONDOWN;
    Checked := bsfrDown in Options;
    OnClick := DirecionDownClick;  
  end;

  FindButton := TbsSkinButton.Create(Form);
  with FindButton do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_NEXT')
    else
      Caption := BS_FIND_NEXT;
    SetBounds(Form.ClientWidth - 90, 15, 80, 25);
    DefaultHeight := 21;
    SkinData := CtrlSkinData;
    OnClick := FindButtonClick;
    Enabled := FFindText <> '';
  end;

  ReplaceButton := TbsSkinButton.Create(Form);
  with ReplaceButton do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_REPLACE')
    else
      Caption := BS_FIND_REPLACE;
    SetBounds(Form.ClientWidth - 90, 50, 80, 25);
    DefaultHeight := 21;
    SkinData := CtrlSkinData;
    OnClick := ReplaceButtonClick;
    Enabled := FFindText <> '';
  end;

  ReplaceAllButton := TbsSkinButton.Create(Form);
  with ReplaceAllButton do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('FIND_REPLACE_ALL')
    else
      Caption := BS_FIND_REPLACE_ALL;
    SetBounds(Form.ClientWidth - 90, 85, 80, 25);
    DefaultHeight := 21;
    SkinData := CtrlSkinData;
    OnClick := ReplaceAllButtonClick;
    Enabled := FFindText <> '';
  end;

  CloseButton := TbsSkinButton.Create(Form);
  with CloseButton do
  begin
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('MSG_BTN_CLOSE')
    else
      Caption := BS_MSG_BTN_CLOSE;
    Cancel := True;
    SetBounds(Form.ClientWidth - 90, 120, 80, 25);
    DefaultHeight := 21;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 20;
    OnClick := CloseButtonClick;
  end;

  Form.Show;

  Result := True;
end;

procedure TbsSkinReplaceDialog.Find;
begin
  if Assigned(FOnFind) then FOnFind(Self);
end;

procedure TbsSkinReplaceDialog.Replace;
begin
  if Assigned(FOnReplace) then FOnReplace(Self);
end;

function TbsSkinReplaceDialog.GetFindText: string;
begin
  Result := FFindText;
end;

function TbsSkinReplaceDialog.GetReplaceText: string;
begin
  Result := FReplaceText;
end;

function TbsSkinReplaceDialog.GetLeft: Integer;
begin
  Result := Position.X;
end;

function TbsSkinReplaceDialog.GetPosition: TPoint;
var
  Rect: TRect;
begin
  Result := FPosition;
  if Form <> nil then
  begin
    Result.X := Form.Left;
    Result.Y := Form.Top;
  end;
end;

function TbsSkinReplaceDialog.GetTop: Integer;
begin
  Result := Position.Y;
end;

procedure TbsSkinReplaceDialog.SetFindText(const Value: string);
begin
  FFindText := Value;
end;

procedure TbsSkinReplaceDialog.SetReplaceText(const Value: string);
begin
  FReplaceText := Value;
end;

procedure TbsSkinReplaceDialog.SetLeft(Value: Integer);
begin
  SetPosition(Point(Value, Top));
end;

procedure TbsSkinReplaceDialog.SetPosition(const Value: TPoint);
begin
  if (FPosition.X <> Value.X) or (FPosition.Y <> Value.Y) then
  begin
    FPosition := Value;
    if Form <> nil
    then
      begin
        Form.Left := FPosition.X;
        Form.Top := FPosition.Y;
      end;
  end;
end;

procedure TbsSkinReplaceDialog.SetTop(Value: Integer);
begin
  SetPosition(Point(Left, Value));
end;

procedure TbsSkinReplaceDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

procedure TbsSkinReplaceDialog.SetDefaultButtonFont(Value: TFont);
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinReplaceDialog.SetDefaultEditFont(Value: TFont);
begin
  FDefaultEditFont.Assign(Value);
end;

procedure TbsSkinReplaceDialog.SetDefaultLabelFont(Value: TFont);
begin
  FDefaultLabelFont.Assign(Value);
end;

end.
