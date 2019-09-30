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

unit bsCalendar;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms,
     Buttons, bsSkinCtrls, bsSkinData, ExtCtrls;

type
  TbsDaysOfWeek = (Sun, Mon, Tue, Wed, Thu, Fri, Sat);

  TbsSkinMonthCalendar = class(TbsSkinPanel)
  protected
    FTodayDefault: Boolean;
    BevelTop, CellW, CellH: Integer;
    FBtns: array[0..3] of TbsSkinSpeedButton;
    FDate: TDate;
    FFirstDayOfWeek: TbsDaysOfWeek;
    CalFontColor: TColor;
    CalActiveFontColor: TColor;
    FOnNumberClick: TNotifyEvent;
    FBoldDays: Boolean;
    procedure Loaded; override;
    procedure SetTodayDefault(Value: Boolean);
    procedure OffsetMonth(AOffset: Integer);
    procedure OffsetYear(AOffset: Integer);
    procedure SetFirstDayOfWeek(Value: TbsDaysOfWeek);
    procedure UpdateCalendar;
    procedure ArangeControls;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure SetSkinData(Value: TbsSkinData); override;
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
    procedure SetDate(Value: TDate);
    procedure DrawCalendar(Cnvs: TCanvas);
    function DaysThisMonth: Integer;
    function GetMonthOffset: Integer;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    function DayNumFromPoint(X, Y: Integer): Word;
    procedure NextMButtonClick(Sender: TObject);
    procedure PriorMButtonClick(Sender: TObject);
    procedure NextYButtonClick(Sender: TObject);
    procedure PriorYButtonClick(Sender: TObject);
    procedure SetCaptionMode(Value: Boolean); override;
    procedure SetDefaultCaptionHeight(Value: Integer); override;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure SetBoldDays(Value: Boolean);
    procedure DrawFrame(R: TRect; C: TCanvas);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ChangeSkinData; override;
  published
    property Date: TDate read FDate write SetDate;
    property TodayDefault: Boolean read FTodayDefault write SetTodayDefault;
    property FirstDayOfWeek: TbsDaysOfWeek read FFirstDayOfWeek write SetFirstDayOfWeek;
    property OnNumberClick: TNotifyEvent
      read FOnNumberClick write FOnNumberClick;
    property BoldDays: Boolean read FBoldDays write SetBoldDays;   
  end;


implementation
  Uses bsUtils;

{$R *.res}

const
  BSize = 23;
  RepeatInt = 250;

constructor TbsSkinMonthCalendar.Create;
begin
  inherited;
  FForcebackground := False;
  BorderStyle := bvFrame;

  FBtns[0] := TbsSkinSpeedButton.Create(Self);
  with FBtns[0] do
  begin
    RepeatMode := True;
    RepeatInterval := RepeatInt;
    SkinDataName := 'resizebutton';
    Width := BSize;
    Height := BSize;
    NumGlyphs := 1;
    Glyph.Handle := LoadBitmap(hInstance, 'BS_PRIORMONTH');
    OnClick := PriorMButtonClick;
    Parent := Self;
  end;

  FBtns[1] := TbsSkinSpeedButton.Create(Self);
  with FBtns[1] do
  begin
    RepeatMode := True;
    RepeatInterval := RepeatInt;
    SkinDataName := 'resizebutton';
    Width := BSize;
    Height := BSize;
    NumGlyphs := 1;
    Glyph.Handle := LoadBitmap(hInstance, 'BS_NEXTMONTH');
    OnClick := NextMButtonClick;
    Parent := Self;
  end;

  FBtns[2] := TbsSkinSpeedButton.Create(Self);
  with FBtns[2] do
  begin
    RepeatMode := True;
    RepeatInterval := RepeatInt - 150;
    SkinDataName := 'resizebutton';
    Width := BSize;
    Height := BSize;
    NumGlyphs := 1;
    Glyph.Handle := LoadBitmap(hInstance, 'BS_PRIORYEAR');
    OnClick := PriorYButtonClick;
    Parent := Self;
  end;

  FBtns[3] := TbsSkinSpeedButton.Create(Self);
  with FBtns[3] do
  begin
    RepeatMode := True;
    RepeatInterval := RepeatInt - 150;
    SkinDataName := 'resizebutton';
    Width := BSize;
    Height := BSize;
    NumGlyphs := 1;
    Glyph.Handle := LoadBitmap(hInstance, 'BS_NEXTYEAR');
    OnClick := NextYButtonClick;
    Parent := Self;
  end;

  Width := 200;
  Height := 150;

  Date := Now;
  FTodayDefault := False;
  FBoldDays := False;
end;

procedure TbsSkinMonthCalendar.SetBoldDays(Value: Boolean);
begin
  FBoldDays := Value;
  RePaint;
end;

procedure TbsSkinMonthCalendar.SetTodayDefault;
begin
  FTodayDefault := Value;
  if FTodayDefault then Date := Now;
end;

procedure TbsSkinMonthCalendar.WMEraseBkgnd;
begin
  if not FromWMPaint
  then
    begin
      PaintWindow(Msg.DC);
    end;  
end;

procedure TbsSkinMonthCalendar.SetCaptionMode;
begin
  inherited;
  ArangeControls;
  UpdateCalendar;
end;

procedure TbsSkinMonthCalendar.SetDefaultCaptionHeight;
begin
  inherited;
  ArangeControls;
  UpdateCalendar;
end;

procedure TbsSkinMonthCalendar.ChangeSkinData;
var
  I: Integer;
begin
  I := -1;
  if (FSD <> nil) and not FSD.Empty
  then
    I := FSD.GetControlIndex('stdlabel');
  if I <> -1
  then
    if TbsDataSkinControl(FSD.CtrlList.Items[I]) is TbsDataSkinStdLabelControl
    then
      with TbsDataSkinStdLabelControl(FSD.CtrlList.Items[I]) do
      begin
        CalFontColor := FontColor;
        CalActiveFontColor := ActiveFontColor;
      end
    else
      begin
        CalFontColor := Font.Color;
        CalActiveFontColor := Font.Color;
      end;
  inherited;
  ArangeControls;
end;

procedure TbsSkinMonthCalendar.NextMButtonClick(Sender: TObject);
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  if AMonth = 12 then OffsetYear(1);
  OffsetMonth(1);
  Click;
end;

procedure TbsSkinMonthCalendar.PriorMButtonClick(Sender: TObject);
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  if AMonth = 1 then OffsetYear(-1);
  OffsetMonth(-1);
  Click;
end;

procedure TbsSkinMonthCalendar.NextYButtonClick(Sender: TObject);
begin
  OffsetYear(1);
  Click;
end;

procedure TbsSkinMonthCalendar.PriorYButtonClick(Sender: TObject);
begin
  OffsetYear(-1);
  Click;
end;


procedure TbsSkinMonthCalendar.OffsetMonth(AOffset: Integer);
var
  AYear, AMonth, ADay: Word;
  TempDate: TDate;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  AMonth := AMonth + AOffset;
  if AMonth > 12 then AMonth := 1 else
  if AMonth <= 0 then AMonth := 12;
  if ADay > DaysPerMonth(AYear, AMonth)
  then ADay := DaysPerMonth(AYear, AMonth);
  TempDate := EncodeDate(AYear, AMonth, ADay);
  Date := TempDate;
end;

procedure TbsSkinMonthCalendar.OffsetYear(AOffset: Integer);
var
  AYear, AMonth, ADay: Word;
  TempDate: TDate;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  AYear := AYear + AOffset;
  if AYear <= 1760 then Exit else
    if AYear > 9999 then Exit;
  if ADay > DaysPerMonth(AYear, AMonth)
  then ADay := DaysPerMonth(AYear, AMonth);
  TempDate := EncodeDate(AYear, AMonth, ADay);
  Date := TempDate;
end;

procedure TbsSkinMonthCalendar.SetFirstDayOfWeek(Value: TbsDaysOfWeek);
begin
  FFirstDayOfWeek := Value;
  UpdateCalendar;
end;

procedure TbsSkinMonthCalendar.SetSkinData;
var
  i: Integer;
begin
  inherited;
  for i := 0 to 3 do
   if FBtns[i] <> nil then FBtns[i].SkinData := Value;
end;

procedure TbsSkinMonthCalendar.ArangeControls;
var
  R: TRect;
begin
  R := Rect(0, 0, Width, Height);
  AdjustClientRect(R);
  if FBtns[0] = nil then Exit;
  with FBtns[2] do SetBounds(R.Left + 1, R.Top + 1, Width, Height);
  with FBtns[0] do SetBounds(FBtns[2].Left + BSize + 1, R.Top + 1, Width, Height);
  with FBtns[3] do SetBounds(R.Right - BSize - 1, R.Top + 1, Width, Height);
  with FBtns[1] do SetBounds(FBtns[3].Left - BSize - 1 , R.Top + 1, Width, Height);
end;

procedure TbsSkinMonthCalendar.WMSIZE;
begin
  inherited;
  ArangeControls;
end;

procedure TbsSkinMonthCalendar.CreateControlDefaultImage(B: TBitMap);
begin
  inherited;
  DrawCalendar(B.Canvas);
end;

procedure TbsSkinMonthCalendar.CreateControlSkinImage(B: TBitMap);
begin
  inherited;
  DrawCalendar(B.Canvas);
end;

procedure TbsSkinMonthCalendar.SetDate(Value: TDate);
begin
  FDate := Value;
  UpdateCalendar;
  RePaint;
end;

procedure TbsSkinMonthCalendar.UpdateCalendar;
begin
  RePaint;
end;

function TbsSkinMonthCalendar.GetMonthOffset: Integer;
var
  AYear, AMonth, ADay: Word;
  FirstDate: TDate;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  FirstDate := EncodeDate(AYear, AMonth, 1);
  Result := 2 - ((DayOfWeek(FirstDate) - Ord(FirstDayOfWeek) + 7) mod 7);
  if Result = 2 then Result := -5;
end;

procedure TbsSkinMonthCalendar.DrawFrame;
var
  ButtonData: TbsDataSkinButtonControl;
  Buffer: TBitMap;
  CIndex: Integer;
  XO, YO: Integer;
  FSkinPicture: TBitMap;
  NewLTPoint, NewRTPoint, NewLBPoint, NewRBPoint: TPoint;
  NewCLRect: TRect;
  SknR: TRect;
begin
 ButtonData := nil;
  if FIndex <> -1
  then
    begin
      CIndex := SkinData.GetControlIndex('resizebutton');
      if CIndex <> -1
      then
        ButtonData := TbsDataSkinButtonControl(SkinData.CtrlList[CIndex]);
    end;
  if ButtonData <> nil
  then
    with ButtonData do
    begin
      Buffer := TBitMap.Create;
      Buffer.Width := RectWidth(R);
      Buffer.Height := RectHeight(R);
      XO := RectWidth(R) - RectWidth(SkinRect);
      YO := RectHeight(R) - RectHeight(SkinRect);
      NewLTPoint := LTPoint;
      NewRTPoint := Point(RTPoint.X + XO, RTPoint.Y);
      NewLBPoint := Point(LBPoint.X, LBPoint.Y + YO);
      NewRBPoint := Point(RBPoint.X + XO, RBPoint.Y + YO);
      NewClRect := Rect(CLRect.Left, ClRect.Top,
        CLRect.Right + XO, ClRect.Bottom + YO);
      FSkinPicture := TBitMap(SkinData.FActivePictures.Items[ButtonData.PictureIndex]);
      SknR := DownSkinRect;
      if IsNullRect(SknR) then SknR := SkinRect;
      CreateSkinImage(LTPoint, RTPoint, LBPoint, RBPoint, CLRect,
          NewLtPoint, NewRTPoint, NewLBPoint, NewRBPoint, NewCLRect,
          Buffer, FSkinPicture, SknR, Buffer.Width, Buffer.Height, True,
          LeftStretch, TopStretch, RightStretch, BottomStretch,
          StretchEffect);
      C.Draw(R.Left, R.Top, Buffer);
      Buffer.Free;
      C.Font.Color := DownFontColor;
    end
  else
    begin
      if FIndex <> -1
      then
        C.Pen.Color := CalActiveFontColor
      else
        C.Pen.Color := Font.Color;
      C.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    end;
end;

procedure TbsSkinMonthCalendar.DrawCalendar(Cnvs: TCanvas);
var
  R: TRect;
  I, J: Integer;
  FMonthOffset, X, Y, X2, Y2: Integer;
  S: String;
  ADay, DayNum: Integer;
begin
  R := Rect(0, 0, Width, Height);
  AdjustClientRect(R);
  with Cnvs do
  begin
    Font := Self.DefaultFont;
    if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
    then
      Font.Charset := SkinData.ResourceStrData.Charset;
    Brush.Style := bsClear;
    // draw caption
    S := FormatDateTime('MMMM, YYYY', FDate);
    Y := R.Top + 2;
    X := Width div 2 - TextWidth(S) div 2;
    if FIndex <> -1
    then
      Font.Color := CalActiveFontColor;
    Font.Style := [fsBold];
    TextOut(X, Y, S);
    CellW := (RectWidth(R) - 2) div 7;
    // draw week days
    X := R.Left + 1;
    Y := R.Top + BSize + 10;
    for I := 0 to 6 do
    begin
      S := ShortDayNames[(Ord(FirstDayOfWeek) + I) mod 7 + 1];
      //
      if Length(S) > 4 then S := Copy(S, 1, 4);
      //
      X2 := X + CellW div 2 - TextWidth(S) div 2;
      TextOut(X2, Y, S);
      X := X + CellW;
    end;
    // draw bevel
    BevelTop := Y + TextHeight('Wq') + 1;
    Pen.Color := Font.Color;
    MoveTo(R.Left + 1, BevelTop);
    LineTo(R.Right - 1, BevelTop);
    if FBoldDays then Font.Style := [fsBold] else Font.Style := [];
    // draw month numbers
    CellH := (R.Bottom - BevelTop - 4) div 6;
    if FIndex <> -1
    then
      Font.Color := CalFontColor;
    FMonthOffset := GetMonthOffset;
    ADay := ExtractDay(FDate);
    Y := BevelTop + 3;
    for J := 0 to 6 do
    begin
      X := R.Left + 1;
      for I := 0 to 6 do
      begin
        DayNum := FMonthOffset + I + (J - 1) * 7;
        if (DayNum < 1) or (DayNum > DaysThisMonth) then S := ''
        else S := IntToStr(DayNum);
        X2 := X + CellW div 2 - TextWidth(S) div 2;
        Y2 := Y - CellH div 2 - TextHeight(S) div 2;
        if DayNum = ADay
        then
          DrawFrame(Rect(X, Y - CellH, X + CellW, Y), Cnvs);
        if S <> '' then TextOut(X2, Y2, S);
        if FIndex <> -1
        then
          Font.Color := CalFontColor;
        X := X + CellW;
      end;
      Y := Y + CellH;
    end;
  end;
end;

function TbsSkinMonthCalendar.DaysThisMonth: Integer;
begin
  Result := DaysPerMonth(ExtractYear(FDate), ExtractMonth(FDate));
end;

function TbsSkinMonthCalendar.DayNumFromPoint;
var
  R, R1: TRect;
  FMonthOffset, X1, Y1, I, J: Integer;
begin
  Result := 0;
  R := Rect(0, 0, Width, Height);
  AdjustClientRect(R);
  if not PtInRect(R, Point(X, Y)) then Exit;
  FMonthOffset := GetMonthOffset;
  Y1 := BevelTop + 3;
  for J := 0 to 6 do
  begin
    X1 := R.Left + 1;
    for I := 0 to 6 do
    begin
      R1 := Rect(X1, Y1 - CellH, X1 + CellW, Y1);
      if PtInRect(R1, Point(X, Y))
      then
        begin
          Result := FMonthOffset + I + (J - 1) * 7;
          if (Result < 1) or (Result > DaysThisMonth) then Result := 0;
          Break;
        end;
      X1 := X1 + CellW;
    end;
    Y1 := Y1 + CellH;
  end;
end;

procedure TbsSkinMonthCalendar.MouseUp;
var
  DayNum, AYear, AMonth, ADay: Word;
  TempDate: TDate;
begin
  inherited;
  if Button <> mbLeft then Exit;
  DayNum := DayNumFromPoint(X, Y);
  if DayNum <> 0
  then
    begin
      DecodeDate(FDate, AYear, AMonth, ADay);
      ADay := DayNum;
      TempDate := EncodeDate(AYear, AMonth, ADay);
      Date := TempDate;
      if Assigned(FOnNumberClick) then FOnNumberClick(Self);
    end;
end;


procedure TbsSkinMonthCalendar.Loaded;
begin
  inherited;
  if FTodayDefault then Date := Now;
end;


end.
