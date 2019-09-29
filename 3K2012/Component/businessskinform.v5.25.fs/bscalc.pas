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

unit bscalc;

interface

uses Windows, SysUtils, 
     Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Menus,
     ExtCtrls, Buttons, bsSkinCtrls, Clipbrd, BusinessSkinForm, bsSkinData,
     bsSkinBoxCtrls;

const
  DefCalcPrecision = 15;

type
  TbsCalcState = (csFirst, csValid, csError);
  TbsCalculatorForm = class;

{ TbsSkinCalculator }

  TbsSkinCalculator = class(TComponent)
  private
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    FSD: TbsSkinData;
    FCtrlFSD: TbsSkinData;
    FButtonSkinDataName: String;
    FDisplayLabelSkinDataName: String;
    FDefaultFont: TFont;
    FValue: Double;
    FTitle: String;
    FMemory: Double;
    FPrecision: Byte;
    FBeepOnError: Boolean;
    FHelpContext: THelpContext;
    FCalc: TbsCalculatorForm;
    FOnChange: TNotifyEvent;
    FOnCalcKey: TKeyPressEvent;
    FOnDisplayChange: TNotifyEvent;
    function GetDisplay: Double;
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure SetDefaultFont(Value: TFont);
    function TitleStored: Boolean;
  protected
    procedure Change; dynamic;
    procedure CalcKey(var Key: Char); dynamic;
    procedure DisplayChange; dynamic;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
    property CalcDisplay: Double read GetDisplay;
    property Memory: Double read FMemory;
  published
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String
      read FButtonSkinDataName write FButtonSkinDataName;
    property DisplayLabelSkinDataName: String
      read FDisplayLabelSkinDataName write FDisplayLabelSkinDataName;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;  
    property BeepOnError: Boolean read FBeepOnError write FBeepOnError default True;
    property HelpContext: THelpContext read FHelpContext write FHelpContext default 0;
    property Precision: Byte read FPrecision write FPrecision default DefCalcPrecision;
    property Title: string read GetTitle write SetTitle stored TitleStored;
    property Value: Double read FValue write FValue;
    property OnCalcKey: TKeyPressEvent read FOnCalcKey write FOnCalcKey;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDisplayChange: TNotifyEvent read FOnDisplayChange write FOnDisplayChange;
  end;

{ TbsCalculatorForm }

  TbsCalculatorForm = class(TForm)
  private
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  protected
    procedure OkClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure CalcKey(Sender: TObject; var Key: Char);
    procedure DisplayChange(Sender: TObject);
  public
    BSF: TbsBusinessSkinForm;
    FCalcPanel: TbsSkinPanel;
    FDisplayLabel: TbsSkinLabel;
    constructor Create(AOwner: TComponent); override;
  end;

  TbsSkinCalcEdit = class;

  TbsPopupCalculatorForm = class(TbsSkinPanel)
  protected
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure OkClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
  public
    CalcEdit: TbsSkinCalcEdit;
    FCalcPanel: TbsSkinPanel;
    FDisplayLabel: TbsSkinLabel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Show(X, Y: Integer);
    procedure Hide;
  end;

  TbsSkinCalcEdit = class(TbsSkinCustomEdit)
  private
    FMemory: Double;
    FPrecision: Byte;
    FCalc: TbsPopupCalculatorForm;
    StopCheck, FromEdit: Boolean;
    FDecimal: Byte;
    FMinValue, FMaxValue, FIncrement: Double;
    FValueType: TbsValueType;
    FValue: Double;
    FCalcButtonSkinDataName: String;
    FCalcDisplayLabelSkinDataName: String;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    procedure SetValue(AValue: Double);
    procedure SetMinValue(AValue: Double);
    procedure SetMaxValue(AValue: Double);
    procedure SetValueType(NewType: TbsValueType);
    procedure SetDecimal(NewValue: Byte);
    procedure ButtonClick(Sender: TObject);
    procedure DropDown;
    procedure CloseUp;
  protected
    function CheckValue(NewValue: Double): Double;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    function IsValidChar(Key: Char): Boolean;
    procedure Change; override;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    property Text;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsNumText(AText: String): Boolean;
    property Memory: Double read FMemory;
  published
    property Alignment;
    property UseSkinFont;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property CalcButtonSkinDataName: String
      read FCalcButtonSkinDataName
      write FCalcButtonSkinDataName;
    property CalcDisplayLabelSkinDataName: String
      read FCalcDisplayLabelSkinDataName
      write FCalcDisplayLabelSkinDataName;
    property Precision: Byte read FPrecision write FPrecision default DefCalcPrecision;
    property ValueType: TbsValueType read FValueType write SetValueType;
    property Decimal: Byte read FDecimal write SetDecimal default 2;
     property Align;
    property MinValue: Double read FMinValue write SetMinValue;
    property MaxValue: Double read FMaxValue write SetMaxValue;
    property Value: Double read FValue write SetValue;
    property Increment: Double read FIncrement write FIncrement;
        property DefaultFont;
    property DefaultWidth;
    property DefaultHeight;
    property ButtonMode;
    property SkinData;
    property SkinDataName;
    property OnMouseEnter;
    property OnMouseLeave;
    property ReadOnly;
    property Font;
    property Anchors;
    property AutoSelect;
    property BiDiMode;
    property CharCase;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnButtonClick;
    property OnChange;
    property OnClick;
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

  TbsSkinCalcCurrencyEdit = class;

  TbsCurrencyPopupCalculatorForm = class(TbsSkinPanel)
  protected
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure OkClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
  public
    CalcEdit: TbsSkinCalcCurrencyEdit;
    FCalcPanel: TbsSkinPanel;
    FDisplayLabel: TbsSkinLabel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Show(X, Y: Integer);
    procedure Hide;
  end;

  TbsSkinCalcCurrencyEdit = class(TbsSkinCurrencyEdit)
  private
    FMemory: Double;
    FPrecision: Byte;
    FCalc: TbsCurrencyPopupCalculatorForm;
    FCalcButtonSkinDataName: String;
    FCalcDisplayLabelSkinDataName: String;
    FAlphaBlend: Boolean;
    FAlphaBlendAnimation: Boolean;
    FAlphaBlendValue: Byte;
    procedure ButtonClick(Sender: TObject);
    procedure DropDown;
    procedure CloseUp;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Memory: Double read FMemory;
  published
    property Precision: Byte read FPrecision write FPrecision default DefCalcPrecision;
    property Alignment;
    property UseSkinFont;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property CalcButtonSkinDataName: String
      read FCalcButtonSkinDataName
      write FCalcButtonSkinDataName;
    property CalcDisplayLabelSkinDataName: String
      read FCalcDisplayLabelSkinDataName
      write FCalcDisplayLabelSkinDataName;
    property DefaultWidth;
    property DefaultHeight;
    property ButtonMode;
    property SkinData;
    property SkinDataName;
    property OnMouseEnter;
    property OnMouseLeave;
    property ReadOnly;
    property Font;
    property Anchors;
    property AutoSelect;
    property BiDiMode;
    property CharCase;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnButtonClick;
    property OnChange;
    property OnClick;
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

function CreateCalculatorForm(AOwner: TComponent; AHelpContext: THelpContext): TbsCalculatorForm;

implementation

 {$R bscalc}

uses bsUtils, bsConst;

const
  WS_EX_LAYERED = $80000;
  CS_DROPSHADOW_ = $20000;
  BtnOffset = 5;
  
type
  TCalcBtnKind =
   (cbNone, cbNum0, cbNum1, cbNum2, cbNum3, cbNum4, cbNum5, cbNum6,
    cbNum7, cbNum8, cbNum9, cbSgn, cbDcm, cbDiv, cbMul, cbSub,
    cbAdd, cbSqr, cbPcnt, cbRev, cbEql, cbBck, cbClr, cbMP,
    cbMS, cbMR, cbMC, cbOk, cbCancel);

function CreateCalculatorForm(AOwner: TComponent; AHelpContext: THelpContext): TbsCalculatorForm;
begin
  Result := TbsCalculatorForm.Create(AOwner);
  with Result do
  try
    HelpContext := AHelpContext;
    if HelpContext <> 0 then BorderIcons := BorderIcons + [biHelp];
    if Screen.PixelsPerInch <> 96 then begin { scale to screen res }
      ScaleBy(Screen.PixelsPerInch, 96);
      Left := (Screen.Width div 2) - (Width div 2);
      Top := (Screen.Height div 2) - (Height div 2);
    end;
  except
    Free;
    raise;
  end;
end;

{ TCalcButton }

type
  TCalcButton = class(TbsSkinSpeedButton)
  private
    FKind: TCalcBtnKind;
  protected
  public
    constructor CreateKind(AOwner: TComponent; AKind: TCalcBtnKind);
    property Kind: TCalcBtnKind read FKind;
  end;

constructor TCalcButton.CreateKind(AOwner: TComponent; AKind: TCalcBtnKind);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FKind := AKind;
  if FKind in [cbNum0..cbClr] then Tag := Ord(Kind) - 1
  else Tag := -1;
end;

const
  BtnPos: array[TCalcBtnKind] of TPoint =
  ((X: -1; Y: -1), (X: 38; Y: 120), (X: 38; Y: 92), (X: 71; Y: 92),
    (X: 104; Y: 92), (X: 38; Y: 64), (X: 71; Y: 64), (X: 104; Y: 64),
    (X: 38; Y: 36), (X: 71; Y: 36), (X: 104; Y: 36), (X: 71; Y: 120),
    (X: 104; Y: 120), (X: 137; Y: 36), (X: 137; Y: 64), (X: 137; Y: 92),
    (X: 137; Y: 120), (X: 170; Y: 36), (X: 170; Y: 64), (X: 170; Y: 92),
    (X: 170; Y: 120), (X: 104; Y: 6), (X: 154; Y: 6), (X: 5; Y: 120),
    (X: 5; Y: 92), (X: 5; Y: 64), (X: 5; Y: 36),
    (X: 38; Y: 6), (X: 71; Y: 6));

   ResultKeys = [#13, '=', '%'];

function CreateCalcBtn(AParent: TWinControl; AKind: TCalcBtnKind;
  AOnClick: TNotifyEvent): TCalcButton;
const
  BtnCaptions: array[cbSgn..cbMC] of PChar =
   ('+/-', ',', '/', '*', '-', '+', 'sqrt', '%', '1/x', '=', '<', 'C',
    'MP', 'MS', 'MR', 'MC');
begin
  Result := TCalcButton.CreateKind(AParent, AKind);
  with Result do
  try
    if Kind in [cbNum0..cbNum9] then Caption := IntToStr(Tag)
    else if Kind = cbDcm then Caption := DecimalSeparator
    else if Kind in [cbSgn..cbMC] then Caption := StrPas(BtnCaptions[Kind]);
    Left := BtnPos[Kind].X + BtnOffset;
    Top := BtnPos[Kind].Y;
    Width := 30;
    Height := 22;
    OnClick := AOnClick;
    Parent := AParent;
  except
    Free;
    raise;
  end;
end;

{ TCalculatorPanel }

type
  TCalculatorPanel = class(TbsSkinPanel)
  private
    FText: string;
    FStatus: TbsCalcState;
    FOperator: Char;
    FOperand: Double;
    FMemory: Double;
    FPrecision: Byte;
    FBeepOnError: Boolean;
    FMemoryLabel: TbsSkinStdLabel;
    FOnError: TNotifyEvent;
    FOnOk: TNotifyEvent;
    FOnCancel: TNotifyEvent;
    FOnResult: TNotifyEvent;
    FOnTextChange: TNotifyEvent;
    FOnCalcKey: TKeyPressEvent;
    FOnDisplayChange: TNotifyEvent;
    FControl: TControl;
    procedure SetText(const Value: string);
    procedure CheckFirst;
    procedure CalcKey(Key: Char);
    procedure Clear;
    procedure Error;
    procedure SetDisplay(R: Double);
    function GetDisplay: Double;
    procedure UpdateMemoryLabel;
    function FindButton(Key: Char): TbsSkinSpeedButton;
    procedure BtnClick(Sender: TObject);
  protected
    procedure TextChanged; virtual;
  public
    constructor CreateLayout(AOwner: TComponent);
    procedure CalcKeyPress(Sender: TObject; var Key: Char);
    procedure Copy;
    procedure Paste;
    property DisplayValue: Double read GetDisplay write SetDisplay;
    property Text: string read FText;
    property OnOkClick: TNotifyEvent read FOnOk write FOnOk;
    property OnCancelClick: TNotifyEvent read FOnCancel write FOnCancel;
    property OnResultClick: TNotifyEvent read FOnResult write FOnResult;
    property OnError: TNotifyEvent read FOnError write FOnError;
    property OnTextChange: TNotifyEvent read FOnTextChange write FOnTextChange;
    property OnCalcKey: TKeyPressEvent read FOnCalcKey write FOnCalcKey;
    property OnDisplayChange: TNotifyEvent read FOnDisplayChange write FOnDisplayChange;
  end;

constructor TCalculatorPanel.CreateLayout(AOwner: TComponent);
var
  I: TCalcBtnKind;
const
    BtnCaptions: array[cbSgn..cbCancel] of PChar =
    ('+/-', ',', '/', '*', '-', '+', 'sqrt', '%', '1/x', '=', '', '',
    'MP', 'MS', 'MR', 'MC', '', '');
begin
  inherited Create(AOwner);
  Height := 150;
  Width := 210 + BtnOffset;
  try
    for I := cbNum0 to cbCancel do begin
      if BtnPos[I].X > 0 then
        with CreateCalcBtn(Self, I, BtnClick) do
        begin
          NumGlyphs := 1;
          case I of
            cbClr: Glyph.LoadFromResourceName(HInstance, 'BS_CALC_CLEAR');
            cbBck: Glyph.LoadFromResourceName(HInstance, 'BS_CALC_BACKSPACE');
            cbOK: Glyph.LoadFromResourceName(HInstance, 'BS_CALC_OK');
            cbCancel: Glyph.LoadFromResourceName(HInstance, 'BS_CALC_CANCEL');
          end;
          if (Kind in [cbBck, cbClr]) then Width := 46;
          if (Kind in [cbSgn..cbCancel]) then Caption := BtnCaptions[Kind];
        end;
    end;
    FMemoryLabel := TbsSkinStdLabel.Create(Self);
    with FMemoryLabel do begin
      SetBounds(6, 7, 34, 20);
      Parent := Self;
      Alignment := taCenter;
    end;
  finally
  end;
  FText := '0';
  FMemory := 0.0;
  FPrecision := DefCalcPrecision;
  FBeepOnError := True;
end;

procedure TCalculatorPanel.SetText(const Value: string);
begin
  if FText <> Value then begin
    FText := Value;
    TextChanged;
  end;
end;

procedure TCalculatorPanel.TextChanged;
begin
  if Assigned(FControl) then TLabel(FControl).Caption := FText;
  if Assigned(FOnTextChange) then FOnTextChange(Self);
end;

procedure TCalculatorPanel.Error;
begin
  FStatus := csError;
  SetText(BS_ERROR);
  if FBeepOnError then MessageBeep(0);
  if Assigned(FOnError) then FOnError(Self);
end;

procedure TCalculatorPanel.SetDisplay(R: Double);
var
  S: string;
begin
  S := FloatToStrF(R, ffGeneral, Max(2, FPrecision), 0);
  if FText <> S then begin
    SetText(S);
    if Assigned(FOnDisplayChange) then FOnDisplayChange(Self);
  end;
end;

function TCalculatorPanel.GetDisplay: Double;
begin
  if FStatus = csError then Result := 0.0
  else Result := StrToFloat(Trim(FText));
end;

procedure TCalculatorPanel.CheckFirst;
begin
  if FStatus = csFirst then begin
    FStatus := csValid;
    SetText('0');
  end;
end;

procedure TCalculatorPanel.UpdateMemoryLabel;
begin
  if FMemoryLabel <> nil then
    if FMemory <> 0.0 then FMemoryLabel.Caption := 'M'
    else FMemoryLabel.Caption := '';
end;

procedure TCalculatorPanel.CalcKey(Key: Char);
var
  R: Double;
begin
  Key := UpCase(Key);
  if (FStatus = csError) and (Key <> 'C') then Key := #0;
  if Assigned(FOnCalcKey) then FOnCalcKey(Self, Key);
  if Key in [DecimalSeparator, '.', ','] then begin
    CheckFirst;
    if Pos(DecimalSeparator, FText) = 0 then
      SetText(FText + DecimalSeparator);
    Exit;
  end;
  case Key of
    'R':
      if FStatus in [csValid, csFirst] then begin
        FStatus := csFirst;
        if GetDisplay = 0 then Error else SetDisplay(1.0 / GetDisplay);
      end;
    'Q':
      if FStatus in [csValid, csFirst] then begin
        FStatus := csFirst;
        if GetDisplay < 0 then Error else SetDisplay(Sqrt(GetDisplay));
      end;
    '0'..'9':
      begin
        CheckFirst;
        if FText = '0' then SetText('');
        if Pos('E', FText) = 0 then begin
          if Length(FText) < Max(2, FPrecision) + Ord(Boolean(Pos('-', FText))) then
            SetText(FText + Key)
          else if FBeepOnError then MessageBeep(0);
        end;
      end;
    #8:
      begin
        CheckFirst;
        if (Length(FText) = 1) or ((Length(FText) = 2) and (FText[1] = '-')) then
          SetText('0')
        else
          SetText(System.Copy(FText, 1, Length(FText) - 1));
      end;
    '_': SetDisplay(-GetDisplay);
    '+', '-', '*', '/', '=', '%', #13:
      begin
        if FStatus = csValid then begin
          FStatus := csFirst;
          R := GetDisplay;
          if Key = '%' then
            case FOperator of
              '+', '-': R := FOperand * R / 100.0;
              '*', '/': R := R / 100.0;
            end;
          case FOperator of
            '+': SetDisplay(FOperand + R);
            '-': SetDisplay(FOperand - R);
            '*': SetDisplay(FOperand * R);
            '/': if R = 0 then Error else SetDisplay(FOperand / R);
          end;
        end;
        FOperator := Key;
        FOperand := GetDisplay;
        if Key in ResultKeys then
          if Assigned(FOnResult) then FOnResult(Self);
      end;
    #27, 'C': Clear;
    ^C: Copy;
    ^V: Paste;
  end;
end;

procedure TCalculatorPanel.Clear;
begin
  FStatus := csFirst;
  SetDisplay(0.0);
  FOperator := '=';
end;

procedure TCalculatorPanel.CalcKeyPress(Sender: TObject; var Key: Char);
var
  Btn: TbsSkinSpeedButton;
begin
  Btn := FindButton(Key);
  if Btn <> nil then Btn.ButtonClick
  else CalcKey(Key);
end;

function TCalculatorPanel.FindButton(Key: Char): TbsSkinSpeedButton;
const
  ButtonChars = '0123456789_./*-+Q%R='#8'C';
var
  I: Integer;
  BtnTag: Longint;
begin
  if Key in [DecimalSeparator, '.', ','] then Key := '.'
  else if Key = #13 then Key := '='
  else if Key = #27 then Key := 'C';
  BtnTag := Pos(UpCase(Key), ButtonChars) - 1;
  if BtnTag >= 0 then
    for I := 0 to ControlCount - 1 do begin
      if Controls[I] is TbsSkinSpeedButton then begin
        Result := TbsSkinSpeedButton(Controls[I]);
        if Result.Tag = BtnTag then Exit;
      end;
    end;
  Result := nil;
end;

procedure TCalculatorPanel.BtnClick(Sender: TObject);
begin
  case TCalcButton(Sender).Kind of
    cbNum0..cbNum9: CalcKey(Char(TComponent(Sender).Tag + Ord('0')));
    cbSgn: CalcKey('_');
    cbDcm: CalcKey(DecimalSeparator);
    cbDiv: CalcKey('/');
    cbMul: CalcKey('*');
    cbSub: CalcKey('-');
    cbAdd: CalcKey('+');
    cbSqr: CalcKey('Q');
    cbPcnt: CalcKey('%');
    cbRev: CalcKey('R');
    cbEql: CalcKey('=');
    cbBck: CalcKey(#8);
    cbClr: CalcKey('C');
    cbMP:
      if FStatus in [csValid, csFirst] then begin
        FStatus := csFirst;
        FMemory := FMemory + GetDisplay;
        UpdateMemoryLabel;
      end;
    cbMS:
      if FStatus in [csValid, csFirst] then begin
        FStatus := csFirst;
        FMemory := GetDisplay;
        UpdateMemoryLabel;
      end;
    cbMR:
      if FStatus in [csValid, csFirst] then begin
        FStatus := csFirst;
        CheckFirst;
        SetDisplay(FMemory);
      end;
    cbMC:
      begin
        FMemory := 0.0;
        UpdateMemoryLabel;
      end;
    cbOk:
      begin
        if FStatus <> csError then begin
          CalcKey('=');
          DisplayValue := DisplayValue; { to raise exception on error }
          if Assigned(FOnOk) then FOnOk(Self);
        end
        else if FBeepOnError then MessageBeep(0);
      end;
    cbCancel: if Assigned(FOnCancel) then FOnCancel(Self);
  end;
end;

procedure TCalculatorPanel.Copy;
begin
  Clipboard.AsText := FText;
end;

procedure TCalculatorPanel.Paste;
begin
  if Clipboard.HasFormat(CF_TEXT) then
    try
      SetDisplay(StrToFloat(Trim(ReplaceStr(Clipboard.AsText,
        CurrencyString, ''))));
    except
      SetText('0');
    end;
end;

{ TbsCalculator }

constructor TbsSkinCalculator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FTitle := BS_CALC_CAP;
  FPrecision := DefCalcPrecision;
  FBeepOnError := True;
  FButtonSkinDataName := 'toolbutton';
  FDisplayLabelSkinDataName := 'label';
  FDefaultFont := TFont.Create;
  with FDefaultFont do
  begin
    Name := 'ËÎÌו';
    Charset := GB2312_CHARSET;
    Style := [];
    Height := -12;
  end;
end;

destructor TbsSkinCalculator.Destroy;
begin
  FOnChange := nil;
  FOnDisplayChange := nil;
  FDefaultFont.Free;
  inherited Destroy;
end;

procedure TbsSkinCalculator.SetDefaultFont;
begin
  FDefaultFont.Assign(Value);
end;


procedure TbsSkinCalculator.Notification;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

function TbsSkinCalculator.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSkinCalculator.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

function TbsSkinCalculator.TitleStored: Boolean;
begin
  Result := Title <> BS_CALC_CAP;
end;

function TbsSkinCalculator.GetDisplay: Double;
begin
  if Assigned(FCalc) then
    Result := TCalculatorPanel(FCalc.FCalcPanel).GetDisplay
  else Result := FValue;
end;

procedure TbsSkinCalculator.CalcKey(var Key: Char);
begin
  if Assigned(FOnCalcKey) then FOnCalcKey(Self, Key);
end;

procedure TbsSkinCalculator.DisplayChange;
begin
  if Assigned(FOnDisplayChange) then FOnDisplayChange(Self);
end;

procedure TbsSkinCalculator.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TbsSkinCalculator.Execute: Boolean;
var
  i: Integer;
  FW, FH: Integer;
begin
  FCalc := CreateCalculatorForm(Self, HelpContext);
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    FCalc.Caption := SkinData.ResourceStrData.GetResStr('CALC_CAP');
  with FCalc do
  try
    FCalcPanel.SkinData := Self.CtrlSkinData;
    FDisplayLabel.DefaultFont := FDefaultFont;
    FDisplayLabel.SkinDataName := FDisplayLabelSkinDataName;
    FDisplayLabel.SkinData := Self.CtrlSkinData;
    for i := 0 to FCalcPanel.ControlCount - 1 do
    if FCalcPanel.Controls[i] is TbsSkinSpeedButton then
    with TbsSkinSpeedButton(FCalcPanel.Controls[i]) do
    begin
      DefaultFont := Self.DefaultFont;
      DefaultHeight := 25;
      SkinDataName := FButtonSkinDataName;
      SkinData := CtrlSkinData;
    end
    else
    if FCalcPanel.Controls[i] is TbsSkinStdLabel then
    with TbsSkinStdLabel(FCalcPanel.Controls[i]) do
    begin
      DefaultFont := Self.DefaultFont;
      SkinData := CtrlSkinData;
    end;
    Caption := Self.Title;
    TCalculatorPanel(FCalcPanel).FMemory := Self.FMemory;
    TCalculatorPanel(FCalcPanel).UpdateMemoryLabel;
    TCalculatorPanel(FCalcPanel).FPrecision := Max(2, Self.Precision);
    TCalculatorPanel(FCalcPanel).FBeepOnError := Self.BeepOnError;
    if Self.FValue <> 0 then begin
      TCalculatorPanel(FCalcPanel).DisplayValue := Self.FValue;
      TCalculatorPanel(FCalcPanel).FStatus := csFirst;
      TCalculatorPanel(FCalcPanel).FOperator := '=';
    end;

    BSF.BorderIcons := [];
    BSF.SkinData := Self.SkinData;
    BSF.MenusSkinData := Self.CtrlSkinData;
    BSF.AlphaBlend := AlphaBlend;
    BSF.AlphaBlendAnimation := AlphaBlendAnimation;
    BSF.AlphaBlendValue := AlphaBlendValue;

    FW := 205 + BtnOffset * 2;
    FH := FCalcPanel.Height + FDisplayLabel.Height + BtnOffset;

    if (SkinData <> nil) and not SkinData.Empty
    then
      begin
        if FW < BSF.GetMinWidth then FW := BSF.GetMinWidth;
        if FH < BSF.GetMinHeight then FH := BSF.GetMinHeight;  
      end;

    ClientWidth := FW;
    ClientHeight := FH;

    Result := (ShowModal = mrOk);

    if Result then begin
      Self.FMemory := TCalculatorPanel(FCalcPanel).FMemory;
      if (TCalculatorPanel(FCalcPanel).DisplayValue <> Self.FValue) then begin
        Self.FValue := TCalculatorPanel(FCalcPanel).DisplayValue;
        Change;
      end;
    end;
  finally
    Free;
    FCalc := nil;
  end;
end;

{ TbsCalculatorForm }

constructor TbsCalculatorForm.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  BorderStyle := bsDialog;
  Caption := BS_CALC_CAP;
  KeyPreview := True;
  PixelsPerInch := 96;
  Position := poScreenCenter;
  OnKeyPress := FormKeyPress;
  { DisplayPanel }
  FDisplayLabel := TbsSkinLabel.Create(Self);
  with FDisplayLabel do begin
    Align := alTop;
    Parent := Self;
    AutoSize := False;
    Alignment := taRightJustify;
    Caption := '0';
    BorderStyle := bvFrame;
    DefaultHeight := 20;
  end;
  { CalcPanel }
  FCalcPanel := TCalculatorPanel.CreateLayout(Self);
  with TCalculatorPanel(FCalcPanel) do begin
    Align := alTop;
    Parent := Self;
    OnOkClick := Self.OkClick;
    OnCancelClick := Self.CancelClick;
    OnCalcKey := Self.CalcKey;
    OnDisplayChange := Self.DisplayChange;
    FControl := FDisplayLabel;
    BorderStyle := bvNone;
  end;
  BSF := TbsBusinessSkinForm.Create(Self);
end;

procedure TbsCalculatorForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  TCalculatorPanel(FCalcPanel).CalcKeyPress(Sender, Key);
end;

procedure TbsCalculatorForm.OkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TbsCalculatorForm.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TbsCalculatorForm.CalcKey(Sender: TObject; var Key: Char);
begin
  if (Owner <> nil) and (Owner is TbsSkinCalculator) then
    TbsSkinCalculator(Owner).CalcKey(Key);
end;

procedure TbsCalculatorForm.DisplayChange(Sender: TObject);
begin
  if (Owner <> nil) and (Owner is TbsSkinCalculator) then
    TbsSkinCalculator(Owner).DisplayChange;
end;

constructor TbsSkinCalcEdit.Create(AOwner: TComponent);
begin
  inherited;
  ButtonMode := True;
  FValue := 0;
  FIncrement := 1;
  FDecimal := 2;
  StopCheck := True;
  Text := '0';
  StopCheck := False;
  FromEdit := False;
  Width := 120;
  Height := 20;
  FSkinDataName := 'buttonedit';
  OnButtonClick := ButtonClick;
  FCalc := TbsPopupCalculatorForm.Create(Self);
  FCalc.Visible := False;
  FCalc.CalcEdit := Self;
  FCalc.Parent := Self;
  FMemory := 0.0;
  FPrecision := DefCalcPrecision;
  FCalcButtonSkinDataName := 'toolbutton';
  FCalcDisplayLabelSkinDataName := 'label';
  FAlphaBlend := False;
  FAlphaBlendValue := 0;
end;

destructor TbsSkinCalcEdit.Destroy;
begin
  FCalc.Free;
  inherited;
end;

procedure TbsSkinCalcEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> FCalc) and
     not FCalc.ContainsControl(Message.Sender)
  then
    CloseUp;
end;

procedure TbsSkinCalcEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and FCalc.Visible then CloseUp;
  inherited;
end;

procedure TbsSkinCalcEdit.CloseUp;
begin
  if FCalc.Visible then FCalc.Hide;
  if CheckW2KWXP and FAlphaBlend
  then
    SetWindowLong(FCalc.Handle, GWL_EXSTYLE,
                  GetWindowLong(Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
end;

procedure TbsSkinCalcEdit.DropDown;
var
  i, Y: Integer;
  P: TPoint;
  TickCount: DWORD;
begin
 with FCalc do
  begin
    SkinData := Self.SkinData;
    FCalcPanel.SkinData := Self.SkinData;
    FDisplayLabel.DefaultFont := FDefaultFont;
    FDisplayLabel.SkinDataName := FCalcDisplayLabelSkinDataName;
    FDisplayLabel.SkinData := Self.SkinData;
    for i := 0 to FCalcPanel.ControlCount - 1 do
    if FCalcPanel.Controls[i] is TbsSkinSpeedButton then
    with TbsSkinSpeedButton(FCalcPanel.Controls[i]) do
    begin
      DefaultFont := Self.DefaultFont;
      DefaultHeight := 25;
      SkinDataName := FCalcButtonSkinDataName;
      SkinData := Self.SkinData;
    end
    else
    if FCalcPanel.Controls[i] is TbsSkinStdLabel then
    with TbsSkinStdLabel(FCalcPanel.Controls[i]) do
    begin
      DefaultFont := Self.DefaultFont;
      SkinData := Self.SkinData;
    end;
    TCalculatorPanel(FCalcPanel).FMemory := Self.FMemory;
    TCalculatorPanel(FCalcPanel).UpdateMemoryLabel;
    TCalculatorPanel(FCalcPanel).FPrecision := Max(2, Self.Precision);
    TCalculatorPanel(FCalcPanel).FBeepOnError := False;
    if Self.FValue <> 0 then begin
      TCalculatorPanel(FCalcPanel).DisplayValue := Self.FValue;
      TCalculatorPanel(FCalcPanel).FStatus := csFirst;
      TCalculatorPanel(FCalcPanel).FOperator := '=';
    end;
    Width := 210 + BtnOffset * 2;
    //
    if FIndex = -1
    then
      Height := FCalcPanel.Height + FDisplayLabel.Height + 2
    else
      Height := FCalcPanel.Height + FDisplayLabel.Height +
      (RectHeight(SkinRect) - RectHeight(ClRect));
    //
    Height := Height + BtnOffset;
    P := Self.Parent.ClientToScreen(Point(Self.Left, Self.Top));
    Y := P.Y + Self.Height;
    if Y + FCalc.Height > Screen.Height then Y := P.Y - FCalc.Height;
    if P.X + FCalc.Width > Screen.Width
    then P.X := Screen.Width - FCalc.Width;
    if P.X < 0 then P.X := 0;
    FCalc.Left := P.X;
    FCalc.Top := Y;
    //
    if CheckW2KWXP and FAlphaBlend
    then
      begin
        SetWindowLong(FCalc.Handle, GWL_EXSTYLE,
                      GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
        SetAlphaBlendTransparent(FCalc.Handle, 0)
      end;
    FCalc.Show(P.X, Y);
    //
    if FAlphaBlend and not FAlphaBlendAnimation and CheckW2KWXP
    then
      begin
        Application.ProcessMessages;
        SetAlphaBlendTransparent(FCalc.Handle, FAlphaBlendValue)
      end
    else
    if CheckW2KWXP and FAlphaBlend and FAlphaBlendAnimation
    then
      begin
        Application.ProcessMessages;
        I := 0;
        TickCount := 0;
        repeat
          if (GetTickCount - TickCount > 5)
          then
             begin
               TickCount := GetTickCount;
               Inc(i, 10);
               if i > FAlphaBlendValue then i := FAlphaBlendValue;
               SetAlphaBlendTransparent(FCalc.Handle, i);
             end;
        until i >= FAlphaBlendValue;
      end;
  end;
end;

procedure TbsSkinCalcEdit.ButtonClick(Sender: TObject);
begin
  if FCalc.Visible then CloseUp else DropDown;
end;

procedure TbsSkinCalcEdit.SetValueType(NewType: TbsValueType);
begin
  if FValueType <> NewType
  then
    begin
      FValueType := NewType;
      if FValueType = vtInteger
      then
        begin
          FIncrement := Round(FIncrement);
          if FIncrement = 0 then FIncrement := 1;
        end;
  end;
end;

procedure TbsSkinCalcEdit.SetDecimal(NewValue: Byte);
begin
  if FDecimal <> NewValue then begin
    FDecimal := NewValue;
  end;
end;

function TbsSkinCalcEdit.CheckValue;
begin
  Result := NewValue;
  if (FMaxValue <> FMinValue)
  then
    begin
      if NewValue < FMinValue then
      Result := FMinValue
      else if NewValue > FMaxValue then
      Result := FMaxValue;
    end;
end;

procedure TbsSkinCalcEdit.SetMinValue;
begin
  FMinValue := AValue;
end;

procedure TbsSkinCalcEdit.SetMaxValue;
begin
  FMaxValue := AValue;
end;

function TbsSkinCalcEdit.IsNumText;

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
  if ValueType = vtFloat
  then
    S := S + DecimalSeparator;
  if (Text = '') or (Text = '-')
  then
    begin
      Result := False;
      Exit;
    end;

  for i := 1 to Length(Text) do
  begin
    if Pos(Text[i], S) = 0
    then
      begin
        Result := False;
        Break;
      end;
  end;

  Result := Result and GetMinus;

  if ValueType = vtFloat
  then
    Result := Result and GetP;

end;

procedure TbsSkinCalcEdit.Change;
var
  NewValue, TmpValue: Double;
begin
  if FromEdit then Exit;
  if not StopCheck and IsNumText(Text)
  then
    begin
      if ValueType = vtFloat
      then TmpValue := StrToFloat(Text)
      else TmpValue := StrToInt(Text);
      NewValue := CheckValue(TmpValue);
      if NewValue <> FValue
      then
        begin
          FValue := NewValue;
        end;
      if NewValue <> TmpValue
      then
        begin
          FromEdit := True;
          if ValueType = vtFloat
          then Text := FloatToStrF(NewValue, ffFixed, 15, FDecimal)
          else Text := IntToStr(Round(FValue));
          FromEdit := False;
        end;
    end;
  inherited;  
end;

procedure TbsSkinCalcEdit.CMTextChanged;
begin
  inherited;
end;

procedure TbsSkinCalcEdit.SetValue;
begin
  FValue := CheckValue(AValue);
  StopCheck := True;
  if ValueType = vtFloat
  then
    Text := FloatToStrF(CheckValue(AValue), ffFixed, 15, FDecimal)
  else
    Text := IntToStr(Round(CheckValue(AValue)));
  StopCheck := False;
end;

procedure TbsSkinCalcEdit.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then
  if FCalc.Visible
  then
    CloseUp
  else
    inherited KeyPress(Key);
end;

function TbsSkinCalcEdit.IsValidChar(Key: Char): Boolean;
begin
  if ValueType = vtInteger
  then
    Result := (Key in ['-', '0'..'9']) or
     ((Key < #32) and (Key <> Chr(VK_RETURN)))
  else
  Result := (Key in [DecimalSeparator, '-', '0'..'9']) or
    ((Key < #32) and (Key <> Chr(VK_RETURN)));
  if ReadOnly and Result and ((Key >= #32) or
     (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE)))
  then
    Result := False;

  if (Key = DecimalSeparator) and (Pos(DecimalSeparator, Text) <> 0)
  then
    Result := False
  else
  if (Key = '-') and (Pos('-', Text) <> 0)
  then
    Result := False;
end;

procedure TbsSkinCalcEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  CloseUp;
end;

constructor TbsPopupCalculatorForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderStyle := bvFrame;
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  CalcEdit := nil;
  { DisplayPanel }
  FDisplayLabel := TbsSkinLabel.Create(Self);
  with FDisplayLabel do begin
    Align := alTop;
    Parent := Self;
    AutoSize := False;
    Alignment := taRightJustify;
    Caption := '0';
    BorderStyle := bvNone;
    DefaultHeight := 20;
    Visible := True;
  end;
  { CalcPanel }
  FCalcPanel := TCalculatorPanel.CreateLayout(Self);
  with TCalculatorPanel(FCalcPanel) do begin
    Align := alTop;
    Parent := Self;
    FControl := FDisplayLabel;
    BorderStyle := bvNone;
    OnOkClick := OkClick;
    OnCancelClick := CancelClick;
    Visible := True;
  end;
end;

destructor TbsPopupCalculatorForm.Destroy;
begin
  FDisplayLabel.Free;
  FCalcPanel.Free;
  inherited;
end;


procedure TbsPopupCalculatorForm.Show(X, Y: Integer);
begin
  SetWindowPos(Handle, HWND_TOP, X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  Visible := True;
end;

procedure TbsPopupCalculatorForm.Hide;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
end;

procedure TbsPopupCalculatorForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
    if CheckWXP then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW_;
  end;
end;

procedure TbsPopupCalculatorForm.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TbsPopupCalculatorForm.OkClick(Sender: TObject);
begin
  if CalcEdit <> nil
  then
    begin
      CalcEdit.Value := TCalculatorPanel(FCalcPanel).DisplayValue;
      CalcEdit.CloseUp;
    end;
end;

procedure TbsPopupCalculatorForm.CancelClick(Sender: TObject);
begin
  if CalcEdit <> nil then CalcEdit.CloseUp;
end;

// Currency calcdit

constructor TbsSkinCalcCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited;
  ButtonMode := True;
  FSkinDataName := 'buttonedit';
  OnButtonClick := ButtonClick;
  FCalc := TbsCurrencyPopupCalculatorForm.Create(Self);
  FCalc.Visible := False;
  FCalc.CalcEdit := Self;
  FCalc.Parent := Self;
  FMemory := 0.0;
  FPrecision := DefCalcPrecision;
  FCalcButtonSkinDataName := 'toolbutton';
  FCalcDisplayLabelSkinDataName := 'label';
  FAlphaBlend := False;
  FAlphaBlendValue := 0;
end;

destructor TbsSkinCalcCurrencyEdit.Destroy;
begin
  FCalc.Free;
  inherited;
end;

procedure TbsSkinCalcCurrencyEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and FCalc.Visible then CloseUp;
  inherited;
end;

procedure TbsSkinCalcCurrencyEdit.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> FCalc) and
     not FCalc.ContainsControl(Message.Sender)
  then
    CloseUp;
end;

procedure TbsSkinCalcCurrencyEdit.CloseUp;
begin
  if FCalc.Visible then FCalc.Hide;
  if CheckW2KWXP and FAlphaBlend
  then
    SetWindowLong(FCalc.Handle, GWL_EXSTYLE,
                  GetWindowLong(Handle, GWL_EXSTYLE) and not WS_EX_LAYERED);
end;

procedure TbsSkinCalcCurrencyEdit.DropDown;
var
  i, Y: Integer;
  P: TPoint;
begin
 with FCalc do
  begin
    SkinData := Self.SkinData;
    FCalcPanel.SkinData := Self.SkinData;
    FDisplayLabel.DefaultFont := FDefaultFont;
    FDisplayLabel.SkinDataName := FCalcDisplayLabelSkinDataName;
    FDisplayLabel.SkinData := Self.SkinData;
    for i := 0 to FCalcPanel.ControlCount - 1 do
    if FCalcPanel.Controls[i] is TbsSkinSpeedButton then
    with TbsSkinSpeedButton(FCalcPanel.Controls[i]) do
    begin
      DefaultFont := Self.DefaultFont;
      DefaultHeight := 25;
      SkinDataName := FCalcButtonSkinDataName;
      SkinData := Self.SkinData;
    end
    else
    if FCalcPanel.Controls[i] is TbsSkinStdLabel then
    with TbsSkinStdLabel(FCalcPanel.Controls[i]) do
    begin
      DefaultFont := Self.DefaultFont;
      SkinData := Self.SkinData;
    end;
    TCalculatorPanel(FCalcPanel).FMemory := Self.FMemory;
    TCalculatorPanel(FCalcPanel).UpdateMemoryLabel;
    TCalculatorPanel(FCalcPanel).FPrecision := Max(2, Self.Precision);
    TCalculatorPanel(FCalcPanel).FBeepOnError := False;
    if Self.Value <> 0 then begin
      TCalculatorPanel(FCalcPanel).DisplayValue := Self.Value;
      TCalculatorPanel(FCalcPanel).FStatus := csFirst;
      TCalculatorPanel(FCalcPanel).FOperator := '=';
    end;
    Width := 210 + BtnOffset * 2;
    //
    if FIndex = -1
    then
      Height := FCalcPanel.Height + FDisplayLabel.Height + 2
    else
      Height := FCalcPanel.Height + FDisplayLabel.Height +
      (RectHeight(SkinRect) - RectHeight(ClRect));
    //
    Height := Height + BtnOffset;
    P := Self.Parent.ClientToScreen(Point(Self.Left, Self.Top));
    Y := P.Y + Self.Height;
    if Y + FCalc.Height > Screen.Height then Y := P.Y - FCalc.Height;
    if P.X + FCalc.Width > Screen.Width
    then P.X := Screen.Width - FCalc.Width;
    if P.X < 0 then P.X := 0;
    FCalc.Left := P.X;
    FCalc.Top := Y;
    //
    if CheckW2KWXP and FAlphaBlend
    then
      begin
        SetWindowLong(FCalc.Handle, GWL_EXSTYLE,
                      GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
        SetAlphaBlendTransparent(FCalc.Handle, 0)
      end;
    FCalc.Show(P.X, Y);
    //
    if FAlphaBlend and not FAlphaBlendAnimation and CheckW2KWXP
    then
      begin
        Application.ProcessMessages;
        SetAlphaBlendTransparent(FCalc.Handle, FAlphaBlendValue)
      end
    else
    if CheckW2KWXP and FAlphaBlend and FAlphaBlendAnimation
    then
      begin
        Application.ProcessMessages;
        I := 0;
        repeat
          Inc(i, 2);
          if i > FAlphaBlendValue then i := FAlphaBlendValue;
          SetAlphaBlendTransparent(FCalc.Handle, i);
        until i >= FAlphaBlendValue;
      end;
  end;
end;

procedure TbsSkinCalcCurrencyEdit.ButtonClick(Sender: TObject);
begin
  if FCalc.Visible then CloseUp else DropDown;
end;

procedure TbsSkinCalcCurrencyEdit.KeyPress(var Key: Char);
begin
  if FCalc.Visible
  then
    CloseUp;
  inherited KeyPress(Key);
end;

procedure TbsSkinCalcCurrencyEdit.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  CloseUp;
end;

constructor TbsCurrencyPopupCalculatorForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BorderStyle := bvFrame;
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable];
  CalcEdit := nil;
  { DisplayPanel }
  FDisplayLabel := TbsSkinLabel.Create(Self);
  with FDisplayLabel do begin
    Align := alTop;
    Parent := Self;
    AutoSize := False;
    Alignment := taRightJustify;
    Caption := '0';
    BorderStyle := bvNone;
    DefaultHeight := 20;
    Visible := True;
  end;
  { CalcPanel }
  FCalcPanel := TCalculatorPanel.CreateLayout(Self);
  with TCalculatorPanel(FCalcPanel) do begin
    Align := alTop;
    Parent := Self;
    FControl := FDisplayLabel;
    BorderStyle := bvNone;
    OnOkClick := OkClick;
    OnCancelClick := CancelClick;
    Visible := True;
  end;
end;

destructor TbsCurrencyPopupCalculatorForm.Destroy;
begin
  FDisplayLabel.Free;
  FCalcPanel.Free;
  inherited;
end;


procedure TbsCurrencyPopupCalculatorForm.Show(X, Y: Integer);
begin
  SetWindowPos(Handle, HWND_TOP, X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
  Visible := True;
end;

procedure TbsCurrencyPopupCalculatorForm.Hide;
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  Visible := False;
end;

procedure TbsCurrencyPopupCalculatorForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP;
    ExStyle := WS_EX_TOOLWINDOW;
    AddBiDiModeExStyle(ExStyle);
    WindowClass.Style := CS_SAVEBITS;
    if CheckWXP then
      WindowClass.Style := WindowClass.style or CS_DROPSHADOW_;
  end;
end;

procedure TbsCurrencyPopupCalculatorForm.WMMouseActivate(var Message: TMessage);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TbsCurrencyPopupCalculatorForm.OkClick(Sender: TObject);
begin
  if CalcEdit <> nil
  then
    begin
      CalcEdit.Value := TCalculatorPanel(FCalcPanel).DisplayValue;
      CalcEdit.CloseUp;
    end;
end;

procedure TbsCurrencyPopupCalculatorForm.CancelClick(Sender: TObject);
begin
  if CalcEdit <> nil then CalcEdit.CloseUp;
end;


end.
