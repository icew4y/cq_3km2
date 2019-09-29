{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{             About Unit - EAbout                }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EAbout;

{$I Exceptions.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms,
  Buttons, ExtCtrls, StdCtrls, Controls;

{$IFDEF EUREKALOG_DEMO}
const
  Interval = 2; //        Demo intervals before activate the OK button.

  FistDiscountDay = 1; // Indicates after how many days the Coupon-Code appears.
  DiscountHours = 48; //  The discount period (in hours).
{$ENDIF}

type
  TAboutForm = class(TForm)
    Image1: TImage;
    Timer: TTimer;
    OKBtn: TBitBtn;
    WhatBtn: TBitBtn;
    CouponPanel: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    HoursLabel: TLabel;
    Edit1: TEdit;
    Panel2: TPanel;
    EurekaLogLabel: TLabel;
    CopyrightLabel: TLabel;
    AuthorLabel: TLabel;
    BigLabel: TLabel;
    ExpireTime: TLabel;
    Site: TLabel;
    Email: TLabel;
    Shape1: TShape;
    procedure SiteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EmailClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WhatBtnClick(Sender: TObject);
    procedure BigLabelClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ActivateDelay: Boolean;

implementation

{$R *.dfm}

uses ShellAPI, EConsts, EDesign, ECore;

{$IFDEF EUREKALOG_DEMO}
var
  InternalCount: Integer;
{$ENDIF}

procedure TAboutForm.SiteClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://www.eurekalog.com',
    nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TAboutForm.FormCreate(Sender: TObject);
{$IFDEF EUREKALOG_DEMO}
var
  IniFile: string;
  StartDate, PromotionDate: TDateTime;
  Day: Double;
  Hours, SName: string;
  IsPromotion, PromotionFinished: Boolean;
{$ENDIF}

begin
  Caption := EAboutCaption;
  EurekaLogLabel.Caption := GetEurekaLogLabel;
  OKBtn.Caption := EOK;
  WhatBtn.Caption := EWhatIs;
  CopyrightLabel.Caption := ECopyrightCaption;
  AuthorLabel.Caption := EAuthorCaption;
  Site.AutoSize := True;
  Site.Left := (Site.Parent.Width - Site.Width) div 2;
  Email.AutoSize := True;
  Email.Left := (Email.Parent.Width - Email.Width) div 2;
{$IFDEF EUREKALOG_DEMO}
  SName := 'Main_' + EurekaLogVersion;
  CouponPanel.Visible := False;
  IniFile := (PackagePath + 'ELDemo.ini');
  StartDate := StrToFloat(ECore.ReadString(IniFile, SName, 'Start', '0'));
  if (StartDate = 0) then
  begin
    StartDate := Now;
    ECore.WriteString(IniFile, SName, 'Start', FloatToStr(StartDate));
  end;
  Day := (Now - StartDate);
  IsPromotion := ECore.ReadBool(IniFile, SName, 'Is Promotion', False);
  PromotionFinished := ECore.ReadBool(IniFile, SName, 'Promotion Finished', False);
  if (Day >= FistDiscountDay) and (not IsPromotion) and (not PromotionFinished) then
  begin
    IsPromotion := True;
    ECore.WriteBool(IniFile, SName, 'Is Promotion', IsPromotion);
    PromotionDate := Now;
    ECore.WriteString(IniFile, SName, 'Promotion Date', FloatToStr(PromotionDate));
  end;
  if (IsPromotion) then
  begin
    PromotionDate := StrToFloat(ECore.ReadString(IniFile, SName, 'Promotion Date', '0'));
    Day := (Now - PromotionDate);
    if ((Day * 24) <= DiscountHours) then
    begin
      Hours := IntToStr(Round(DiscountHours - 24 * Day));
      HoursLabel.Caption := 'but only for the next ' + Hours;
      if (Hours = '1') then HoursLabel.Caption := HoursLabel.Caption + ' hour.'
      else HoursLabel.Caption := HoursLabel.Caption + ' hours.';
      CouponPanel.Visible := False; //True;
    end
    else
    begin
      IsPromotion := False;
      ECore.WriteBool(IniFile, SName, 'Is Promotion', IsPromotion);
      PromotionFinished := True;
      ECore.WriteBool(IniFile, SName, 'Promotion Finished', PromotionFinished);
    end;
  end;
  OrderBtn.Caption := EOrder;
  OrderBtn.Default := True;
  OrderBtn.Visible := True;
  OKBtn.Default := False;
  OKBtn.Enabled := not ActivateDelay;
  Timer.Enabled := ActivateDelay;
  BigLabel.Caption := EurekaNotRegisteredVersion;
  BigLabel.Font.Color := clRed;
  ExpireTime.Caption := EExpireTime;
  ExpireTime.Visible := True;
  InternalCount := 0;
{$ELSE}
  BigLabel.Caption := EurekaGoToUpdatesPage;
  BigLabel.Font.Color := clBlue;
  BigLabel.Font.Style := BigLabel.Font.Style + [fsUnderline];
  BigLabel.Font.Size := 12;
  BigLabel.Cursor := crHandPoint;
  BigLabel.AutoSize := True;
  BigLabel.Left := (Site.Parent.Width - Site.Width) div 2;
  BigLabel.Top := BigLabel.Top + 8;
  OKBtn.Default := True;
 // OrderBtn.Visible := False;
  WhatBtn.Left := 8;
  Timer.Enabled := False;
  ExpireTime.Visible := False;
{$ENDIF}
  AdjustFontLanguage(Self);
end;

procedure TAboutForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
end;

procedure TAboutForm.EmailClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'mailto:support@eurekalog.com',
    nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TAboutForm.TimerTimer(Sender: TObject);
begin
{$IFDEF EUREKALOG_DEMO}
  Inc(InternalCount);
  if InternalCount >= Interval then OKBtn.Enabled := True;
  SetForegroundWindow(Handle);
{$ENDIF}
end;

procedure TAboutForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
{$IFDEF EUREKALOG_DEMO}
  CanClose := (InternalCount >= Interval) or (not ActivateDelay);
{$ELSE}
  CanClose := True;
{$ENDIF}
end;

procedure TAboutForm.WhatBtnClick(Sender: TObject);
begin
  ShowHelp('welcome');
end;

procedure TAboutForm.BigLabelClick(Sender: TObject);
begin
{$IFNDEF EUREKALOG_DEMO}
  ShellExecute(0, 'open', 'http://www.eurekalog.com/updates.php',
    nil, nil, SW_SHOWMAXIMIZED);
{$ENDIF}
end;

procedure TAboutForm.Label5Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://www.eurekalog.com/buy.php',
    nil, nil, SW_SHOWMAXIMIZED);
end;

end.

