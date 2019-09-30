{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{         TCalculatorEh, TPopupCalculatorEh             }
{                     (Build 5.0.00)                    }
{                                                       }
{      Copyright (c) 2002-2008 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit CalculatorEh;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  StdCtrls, ExtCtrls, Buttons, Math, ClipBrd, ToolCtrlsEh;

const
  DefCalcPrecision = 15;

type
  TCalcStateEh = (csFirstEh, csValidEh, csErrorEh);

{ TCalculatorEh }

  TCalculatorEh = class(TCustomControl)
    Panel1: TPanel;
    SpeedButton1: TSpeedButtonEh;
    SpeedButton2: TSpeedButtonEh;
    SpeedButton3: TSpeedButtonEh;
    SpeedButton4: TSpeedButtonEh;
    SpeedButton5: TSpeedButtonEh;
    SpeedButton6: TSpeedButtonEh;
    SpeedButton7: TSpeedButtonEh;
    SpeedButton8: TSpeedButtonEh;
    SpeedButton9: TSpeedButtonEh;
    SpeedButton10: TSpeedButtonEh;
    SpeedButton11: TSpeedButtonEh;
    SpeedButton12: TSpeedButtonEh;
    SpeedButton13: TSpeedButtonEh;
    SpeedButton14: TSpeedButtonEh;
    SpeedButton15: TSpeedButtonEh;
    SpeedButton16: TSpeedButtonEh;
    SpeedButton18: TSpeedButtonEh;
    SpeedButton19: TSpeedButtonEh;
    SpeedButton20: TSpeedButtonEh;
    SpeedButton22: TSpeedButtonEh;
    SpeedButton23: TSpeedButtonEh;
    SpeedButton24: TSpeedButtonEh;
    spEqual: TSpeedButtonEh;
    TextBox: TLabel;
    procedure SpeedButtonClick(Sender: TObject);
  private
    FBorderStyle: TBorderStyle;
    FClientHeight: Integer;
    FClientWidth: Integer;
    FOperand: Extended;
    FOperator: Char;
    FPixelsPerInch: Integer;
    FStatus: TCalcStateEh;
    FTextHeight: Integer;
    function GetDisplayText: String;
    function GetDisplayValue: Extended;
    function GetPixelsPerInch: Integer;
    procedure CheckFirst;
    procedure Clear;
    procedure Error;
    procedure ReadTextHeight(Reader: TReader);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetClientHeight(Value: Integer);
    procedure SetClientWidth(Value: Integer);
    procedure SetDisplayText(const Value: String);
    procedure SetDisplayValue(const Value: Extended);
    procedure SetOldCreateOrder(const Value: Boolean);
    procedure SetPixelsPerInch(const Value: Integer);
    procedure UpdateEqualButton;
  protected
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function GetBorderSize: Integer; virtual;
    function GetTextHeight: Integer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoCopy;
    procedure Paste;
    procedure ProcessKey(Key: Char); virtual;
    property DisplayText: String read GetDisplayText write SetDisplayText;
    property DisplayValue: Extended read GetDisplayValue write SetDisplayValue;
  published
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;
    property ClientHeight write SetClientHeight;
    property ClientWidth write SetClientWidth;
    property Color;
    property Font;
    property OldCreateOrder: Boolean write SetOldCreateOrder;
    property PixelsPerInch: Integer read GetPixelsPerInch write SetPixelsPerInch stored False;
  end;

{ IPopupCalculatorEh }

  IPopupCalculatorEh = interface
    ['{697F81AD-0E0F-4A4A-A016-A713620660DE}']
    function GetEnterCanClose: Boolean;
    function GetFlat: Boolean;
    function GetValue: Variant;
    procedure SetFlat(const Value: Boolean);
    procedure SetValue(const Value: Variant);
    property Value: Variant read GetValue write SetValue;
    property Flat: Boolean read GetFlat write SetFlat;
    property EnterCanClose: Boolean read GetEnterCanClose;
  end;

{ TPopupCalculatorEh }

  TPopupCalculatorEh = class(TCalculatorEh, IPopupCalculatorEh{$IFNDEF CIL}, IUnknown {$ENDIF})
  private
    FBorderWidth: Integer;
    FFlat: Boolean;
    procedure CMCloseUpEh(var Message: TMessage); message CM_CLOSEUPEH;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
  protected
    {IPopupCalculatorEh}
    function GetEnterCanClose: Boolean;
    function GetFlat: Boolean;
    function GetValue: Variant;
    procedure SetFlat(const Value: Boolean);
    procedure SetValue(const Value: Variant);
  protected
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawBorder; virtual;
    procedure UpdateBorderWidth;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    function CanFocus: Boolean; {$IFDEF EH_LIB_5} override; {$ENDIF}
    procedure ProcessKey(Key: Char); override;
    property Flat: Boolean read GetFlat write SetFlat default True;
    property Ctl3D;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterClass(TSpeedButtonEh);
end;

{$R *.DFM}

const
  SError = 'Error';

  TagToCharArray: array[0..23] of Char =
    (#0,
     '7','8','9','/','S','C',
     '4','5','6','*','%','A',
     '1','2','3','-','R',#8,
     '0','I','.','+','='    );

{ TPopupCalculator }

constructor TCalculatorEh.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(AOwner);
  FPixelsPerInch := Screen.PixelsPerInch;
  InitInheritedComponent(Self, TCustomControl);
  for i := 0 to ComponentCount-1 do
    if Components[i] is TSpeedButtonEh then
    begin
      TSpeedButtonEh(Components[i]).Style := ebsGlyphEh;
      TSpeedButtonEh(Components[i]).Active := True;
    end;
  AutoSize := True;
end;

procedure TCalculatorEh.SetClientHeight(Value: Integer);
begin
  if csReadingState in ControlState then
  begin
    FClientHeight := Value;
    ScalingFlags := ScalingFlags + [sfHeight];
  end else
    inherited ClientHeight := Value;
end;

procedure TCalculatorEh.SetClientWidth(Value: Integer);
begin
  if csReadingState in ControlState then
  begin
    FClientWidth := Value;
    ScalingFlags := ScalingFlags + [sfWidth];
  end else
    inherited ClientWidth := Value;
end;

function TCalculatorEh.GetPixelsPerInch: Integer;
begin
  Result := FPixelsPerInch;
  if Result = 0 then Result := Screen.PixelsPerInch;
end;

procedure TCalculatorEh.SetPixelsPerInch(const Value: Integer);
begin
  if (Value <> GetPixelsPerInch) and ((Value = 0) or (Value >= 36))
    and (not (csLoading in ComponentState) or (FPixelsPerInch <> 0)) then
    FPixelsPerInch := Value;
end;

procedure TCalculatorEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('PixelsPerInch', nil, nil, not IsControl);
  Filer.DefineProperty('TextHeight', ReadTextHeight, nil, not IsControl);
end;

procedure TCalculatorEh.ReadTextHeight(Reader: TReader);
begin
  FTextHeight := Reader.ReadInteger;
end;

procedure TCalculatorEh.ReadState(Reader: TReader);
var
  NewTextHeight: Integer;
  Scaled: Boolean;
begin
  DisableAlign;
  try
    FClientWidth := 0;
    FClientHeight := 0;
    FTextHeight := 0;
    Scaled := False;
    inherited ReadState(Reader);
    if (FPixelsPerInch <> 0) and (FTextHeight > 0) then
    begin
      if (sfFont in ScalingFlags) and (FPixelsPerInch <> Screen.PixelsPerInch) then
        Font.Height := MulDiv(Font.Height, Screen.PixelsPerInch, FPixelsPerInch);
      FPixelsPerInch := Screen.PixelsPerInch;
      NewTextHeight := GetTextHeight;
      if FTextHeight <> NewTextHeight then
      begin
        Scaled := True;
//        ScaleScrollBars(NewTextHeight, FTextHeight);
        ScaleControls(NewTextHeight, FTextHeight);
        if sfWidth in ScalingFlags then
          FClientWidth := MulDiv(FClientWidth, NewTextHeight, FTextHeight);
        if sfHeight in ScalingFlags then
          FClientHeight := MulDiv(FClientHeight, NewTextHeight, FTextHeight);
      end;
    end;
  //  if FClientWidth > 0 then inherited ClientWidth := FClientWidth;
//    if FClientHeight > 0 then inherited ClientHeight := FClientHeight;
    ScalingFlags := [];
    if not Scaled then
    begin
      { Forces all ScalingFlags to [] }
//      ScaleScrollBars(1, 1);
      ScaleControls(1, 1);
    end;
    Perform(CM_PARENTBIDIMODECHANGED, 0, 0);
  finally
    EnableAlign;
  end;
end;

function TCalculatorEh.GetTextHeight: Integer;
var
  RestoreCanvas: Boolean;
begin
  RestoreCanvas := not HandleAllocated;
  if RestoreCanvas then
    Canvas.Handle := GetDC(0);
  try
    Canvas.Font := Self.Font;
    Result := Canvas.TextHeight('0');
  finally
    if RestoreCanvas then
    begin
      ReleaseDC(0, Canvas.Handle);
      Canvas.Handle := 0;
    end;
  end;
end;

procedure TCalculatorEh.ProcessKey(Key: Char);
var
  R: Extended;
begin
  Key := UpCase(Key);
  if (FStatus = csErrorEh) and (Key <> 'C') then
    Key := #0;
  if (Key = DecimalSeparator) or CharInSetEh(Key, [ '.', ',']) then
  begin
    CheckFirst;
    if Pos(DecimalSeparator, DisplayText) = 0 then
      DisplayText := DisplayText + DecimalSeparator;
    Exit;
  end;
  case Key of
    'R': // 1/x
      if FStatus in [csValidEh, csFirstEh] then
      begin
        FStatus := csFirstEh;
        if DisplayValue = 0
          then Error
          else DisplayValue := 1.0 / DisplayValue;
      end;
    'S': // Sqrt
      if FStatus in [csValidEh, csFirstEh] then
      begin
        FStatus := csFirstEh;
        if DisplayValue < 0
          then Error
          else DisplayValue := Sqrt(DisplayValue);
      end;
    '0'..'9':
      begin
        CheckFirst;
        if DisplayText = '0' then
          DisplayText := '';
        if Pos('E', DisplayText) = 0 then
        begin
          if Length(DisplayText) < Max(2, DefCalcPrecision) + Ord(Boolean(Pos('-', DisplayText))) then
            DisplayText := DisplayText + Key;
        end;
      end;
    #8: // <-|
      begin
        CheckFirst;
        if (Length(DisplayText) = 1) or ((Length(DisplayText) = 2) and (DisplayText[1] = '-')) then
          DisplayText := '0'
        else
          DisplayText := Copy(DisplayText, 1, Length(DisplayText) - 1);
      end;
    'I': // +/-
      DisplayValue := - DisplayValue;
     #13, '%', '*', '+', '-', '/', '=':
      begin
        if FStatus = csValidEh then
        begin
          FStatus := csFirstEh;
          R := DisplayValue;
          if Key = '%' then
            case FOperator of
              '+', '-': R := FOperand * R / 100.0;
              '*', '/': R := R / 100.0;
            end;
          case FOperator of
            '+': DisplayValue := FOperand + R;
            '-': DisplayValue := FOperand - R;
            '*': DisplayValue := FOperand * R;
            '/': if R = 0
                    then Error
                    else DisplayValue := FOperand / R;
          end;
        end;
        FOperator := Key;
        FOperand := DisplayValue;
      end;
    #27, 'C': Clear;
    ^C: DoCopy;
    ^V: Paste;
  end;
  UpdateEqualButton;
end;

procedure TCalculatorEh.CheckFirst;
begin
  if FStatus = csFirstEh then
  begin
    FStatus := csValidEh;
    DisplayText := '0';
  end;
end;

procedure TCalculatorEh.Clear;
begin
  FStatus := csFirstEh;
  DisplayValue := 0.0;
  FOperator := '=';
  FOperand := 0.0;
  UpdateEqualButton;
end;

procedure TCalculatorEh.DoCopy;
begin
  Clipboard.AsText := DisplayText;
end;

procedure TCalculatorEh.Error;
begin
  FStatus := csErrorEh;
  DisplayText := SError;
end;

function TCalculatorEh.GetDisplayValue: Extended;
begin
  if FStatus = csErrorEh
    then Result := 0.0
    else Result := StrToFloat(Trim(DisplayText));
end;

procedure TCalculatorEh.Paste;
begin
  if Clipboard.HasFormat(CF_TEXT) then
//      SetDisplay(StrToFloat(Trim(ReplaceStr(Clipboard.AsText, CurrencyString, ''))));
    DisplayValue := StrToFloat(Trim(Clipboard.AsText));
end;

function TCalculatorEh.GetDisplayText: String;
begin
  Result := TextBox.Caption;
end;

procedure TCalculatorEh.SetDisplayText(const Value: String);
begin
  TextBox.Caption := Value;
end;

procedure TCalculatorEh.SetDisplayValue(const Value: Extended);
begin
  DisplayText := FloatToStrF(Value, ffGeneral, Max(2, DefCalcPrecision), 0);
end;

procedure TCalculatorEh.SpeedButtonClick(Sender: TObject);
begin
  ProcessKey(TagToCharArray[Integer(TSpeedButton(Sender).Tag)]);
end;

procedure TCalculatorEh.UpdateEqualButton;
begin
  if (FOperand <> 0.0) and (FStatus = csValidEh) and CharInSetEh(FOperator, ['+', '-', '*', '/'])
    then spEqual.Caption := '='
    else spEqual.Caption := 'Ok';
end;

procedure TCalculatorEh.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCalculatorEh.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

function TCalculatorEh.GetBorderSize: Integer;
var
  Params: TCreateParams;
  R: TRect;
begin
  CreateParams(Params);
  SetRect(R, 0, 0, 0, 0);
  AdjustWindowRectEx(R, Params.Style, False, Params.ExStyle);
  Result := R.Bottom - R.Top;
end;

procedure TCalculatorEh.SetOldCreateOrder(const Value: Boolean);
begin
  // Nothing to do
end;

procedure TCalculatorEh.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  ProcessKey(Key);
end;

procedure TCalculatorEh.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key = VK_DELETE then
    ProcessKey('C');
end;

function TCalculatorEh.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := True;
  NewWidth := FClientWidth + GetBorderSize;
  NewHeight := FClientHeight + GetBorderSize;
end;

{ TPopupCalculatorEh }

constructor TPopupCalculatorEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable]; //Really not Replicatable, only for CtrlGrid
  //FOwner := AOwner;
//  AutoSize := True;
  Ctl3D := True;
  ParentCtl3D := False;
  TabStop := False;
  FFlat := True;
{$IFDEF EH_LIB_7}
  Panel1.ParentBackground := False;
{$ENDIF}
end;

{CM messages processing}

procedure TPopupCalculatorEh.CMCloseUpEh(var Message: TMessage);
var
  ComboEdit: IComboEditEh;
begin
  if Supports(Owner, IComboEditEh, ComboEdit) then
    ComboEdit.CloseUp(False);
end;

procedure TPopupCalculatorEh.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  UpdateBorderWidth;
  RecreateWnd;
end;

procedure TPopupCalculatorEh.CMWantSpecialKey( var Message: TCMWantSpecialKey);
var
  ComboEdit: IComboEditEh;
begin
  if not Supports(Owner, IComboEditEh, ComboEdit) then
    Exit;
  if (Message.CharCode in [VK_RETURN, VK_ESCAPE]) then
  begin
    ComboEdit.CloseUp(Message.CharCode = VK_RETURN);
    Message.Result := 1;
  end else
    inherited;
end;

{WM messages processing}

procedure TPopupCalculatorEh.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTARROWS or DLGC_WANTCHARS or DLGC_WANTTAB;
end;

procedure TPopupCalculatorEh.WMNCCalcSize(var Message: TWMNCCalcSize);
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

procedure TPopupCalculatorEh.WMNCPaint(var Message: TWMNCPaint);
begin
  inherited;
  DrawBorder;
end;

procedure TPopupCalculatorEh.WMMouseActivate(var Message: TWMMouseActivate);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TPopupCalculatorEh.CreateParams(var Params: TCreateParams);
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

procedure TPopupCalculatorEh.DrawBorder;
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
      FrameRect(DC, R, GetSysColorBrush(COLOR_3DDKSHADOW));
      //DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
      InflateRect(R, -1, -1);
      DrawEdge(DC, R, BDR_RAISEDINNER, BF_RECT);
    finally
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TPopupCalculatorEh.UpdateBorderWidth;
begin
  if Ctl3D
    then FBorderWidth := 2
    else FBorderWidth := 0;
end;

function TPopupCalculatorEh.CanFocus: Boolean;
begin
  Result := False;
end;

function TPopupCalculatorEh.GetValue: Variant;
begin
  if FStatus = csErrorEh then
  begin
{$IFDEF CIL}
    Result := VarFromException(EDivByZero.Create);
{$ELSE}
    TVarData(Result).VType := varError;
    TVarData(Result).VInteger := -1;
{$ENDIF}
  end else
    Result := DisplayValue;
end;

procedure TPopupCalculatorEh.SetValue(const Value: Variant);
begin
  Clear;
  DisplayValue := Value;
end;

procedure TPopupCalculatorEh.ProcessKey(Key: Char);
var
  ComboEdit: IComboEditEh;
begin
  if CharInSetEh(Key, ['=', #13]) and (spEqual.Caption = 'Ok') then
  begin
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(True)
  end else
    inherited ProcessKey(Key);
end;

procedure TPopupCalculatorEh.KeyDown(var Key: Word; Shift: TShiftState);
var
  ComboEdit: IComboEditEh;
begin
  inherited KeyDown(Key, Shift);
  if Key = VK_ESCAPE then
  begin
    if Supports(Owner, IComboEditEh, ComboEdit) then
      ComboEdit.CloseUp(False);
    Key := 0;
  end;
end;

function TPopupCalculatorEh.GetFlat: Boolean;
begin
  Result := FFlat;
end;

procedure TPopupCalculatorEh.SetFlat(const Value: Boolean);
var
  i: Integer;
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    for i := 0 to ComponentCount-1 do
      if Components[i] is TSpeedButtonEh then
        TSpeedButtonEh(Components[i]).Flat := False;
  end;
end;

function TPopupCalculatorEh.GetEnterCanClose: Boolean;
begin
  Result := (spEqual.Caption = 'Ok');
end;

function TPopupCalculatorEh.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := inherited CanAutoSize(NewWidth, NewHeight);
  if Result then
  begin
    Inc(NewWidth, FBorderWidth*2);
    Inc(NewHeight, FBorderWidth*2);
  end;
end;

function TCalculatorEh.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelDown(Shift, MousePos);
  if not Result then
  begin
    if FStatus <> csErrorEh then
      DisplayValue := DisplayValue - 1;
    Result := True;
  end;
end;

function TCalculatorEh.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  Result := inherited DoMouseWheelUp(Shift, MousePos);
  if not Result then
  begin
    if FStatus <> csErrorEh then
      DisplayValue := DisplayValue + 1;
    Result := True;
  end;
end;

end.
