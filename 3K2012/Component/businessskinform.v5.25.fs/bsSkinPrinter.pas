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

unit bsSkinPrinter;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms,
     BusinessSkinForm, bsSkinData, bsSkinCtrls, bsSkinBoxCtrls, Dialogs,
     StdCtrls, ExtCtrls, bsEffects;

type

  TbsPrintRange = (bsprAllPages, bsprSelection, bsprPageNums);
  TbsPrintDialogOption = (bspoPrintToFile, bspoPageNums, bspoSelection,
    bspoDisablePrintToFile);
  TbsPrintDialogOptions = set of TbsPrintDialogOption;

  TbsSkinPrintDialog = class(TComponent)
  private
    PrinterCombobox: TbsSkinComboBox;
    L1, L2, L3, L4: TbsSkinStdLabel;
    NumCopiesEdit: TbsSkinSpinEdit;
    CollateCheckBox: TbsSkinCheckRadioBox;
    StopCheck: Boolean;
    CollateImage: TImage;
    RBAll, RBPages, RBSelection: TbsSkinCheckRadioBox;
    FromPageEdit, ToPageEdit: TbsSkinSpinEdit;
    PrintToFileCheckBox: TbsSkinCheckRadioBox;
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
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    FTitle: String;
    //
    FFromPage: Integer;
    FToPage: Integer;
    FCollate: Boolean;
    FOptions: TbsPrintDialogOptions;
    FPrintToFile: Boolean;
    FPrintRange: TbsPrintRange;
    FMinPage: Integer;
    FMaxPage: Integer;
    FCopies: Integer;
    procedure SetNumCopies(Value: Integer);
    //
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultSelectFont(Value: TFont);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure PrinterComboBoxChange(Sender: TObject);
    procedure PropertiesButtonClick(Sender: TObject);
    procedure NumCopiesEditChange(Sender: TObject);
    procedure CollateCheckBoxClick(Sender: TObject);
    procedure FromPageEditChange(Sender: TObject);
    procedure ToPageEditChange(Sender: TObject);
  public
    function Execute: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Title: string read GetTitle write SetTitle;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String read FLabelSkinDataName write FLabelSkinDataName;
    property ComboboxSkinDataName: String read FSelectSkinDataName write FSelectSkinDataName;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultComboBoxFont: TFont read FDefaultSelectFont write SetDefaultSelectFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
    //
    property Collate: Boolean read FCollate write FCollate default False;
    property Copies: Integer read FCopies write SetNumCopies default 0;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property MinPage: Integer read FMinPage write FMinPage default 0;
    property MaxPage: Integer read FMaxPage write FMaxPage default 0;
    property Options: TbsPrintDialogOptions read FOptions write FOptions default [];
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile default False;
    property PrintRange: TbsPrintRange read FPrintRange write FPrintRange default bsprAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
    //
  end;

  TbsPaperInfo = class
  private
    FDMPaper: Integer;
    FName: string;
    FSize: TPoint;
    function GetSize(Index: Integer): Integer;
    procedure SetSize(Index: Integer; Value: Integer);
  public
    procedure Assign(Source: TbsPaperInfo);
    function IsEqual(Source: TbsPaperInfo): Boolean;

    property DMPaper: Integer read FDMPaper;
    property Height: Integer index 1 read GetSize write SetSize;
    property Name: string read FName;
    property Size: TPoint read FSize;
    property Width: Integer index 0 read GetSize write SetSize;
  end;

  TbsSkinPrinterSetupDialog = class(TComponent)
  private
    StopCheck: Boolean;
    PrinterCombobox: TbsSkinComboBox;
    L1, L2, L3, L4: TbsSkinStdLabel;
    RBPortrait, RBLandScape: TbsSkinCheckRadioBox;
    OrientationImage: TImage;
    SizeComboBox, SourceComboBox: TbsSkinComboBox;
    Bins, Papers: TStrings;
    procedure RBPortraitClick(Sender: TObject);
    procedure RBLandScapeClick(Sender: TObject);
    procedure SizeComboBoxChange(Sender: TObject);
    procedure SourceComboBoxChange(Sender: TObject);
    procedure ClearPapersAndBins;
    procedure LoadPapersAndBins;
    procedure LoadCurrentPaperAndBin;
    procedure SaveCurrentPaperAndBin;
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
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    FTitle: String;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultSelectFont(Value: TFont);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure PrinterComboBoxChange(Sender: TObject);
    procedure PropertiesButtonClick(Sender: TObject);
  public
    function Execute: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Title: string read GetTitle write SetTitle;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String read FLabelSkinDataName write FLabelSkinDataName;
    property ComboboxSkinDataName: String read FSelectSkinDataName write FSelectSkinDataName;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultComboBoxFont: TFont read FDefaultSelectFont write SetDefaultSelectFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSkinSmallPrintDialog = class(TComponent)
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
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    FTitle: String;
    PrinterCombobox: TbsSkinComboBox;
    L1, L2, L3, L4: TbsSkinStdLabel;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultSelectFont(Value: TFont);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure PropertiesButtonClick(Sender: TObject);
    procedure PrinterComboBoxChange(Sender: TObject);
  public
    function Execute: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Title: string read GetTitle write SetTitle;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String read FLabelSkinDataName write FLabelSkinDataName;
    property ComboboxSkinDataName: String read FSelectSkinDataName write FSelectSkinDataName;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultComboBoxFont: TFont read FDefaultSelectFont write SetDefaultSelectFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSkinPagePreview = class;
  TbsPageMeasureUnits = (bspmMillimeters, bspmInches);
  TbsPageSetupDialogOption = (bspsoDisableMargins,
    bspsoDisableOrientation, bspsoDisablePaper, bspsoDisablePrinter);
  TbsPageSetupDialogOptions = set of TbsPageSetupDialogOption;  

  TbsSkinPageSetupDialog = class(TComponent)
  private
    StopCheck: Boolean;
    RBPortrait, RBLandScape: TbsSkinCheckRadioBox;
    SizeComboBox, SourceComboBox: TbsSkinComboBox;
    LeftMEdit, TopMEdit, RightMEdit, BottomMEdit: TbsSkinSpinEdit;
    PagePreview: TbsSkinPagePreview;
    Bins, Papers: TStrings;
    //
    FUnits: TbsPageMeasureUnits;
    FOptions: TbsPageSetupDialogOptions;
    //
    FMinMarginLeft: Integer;
    FMinMarginTop: Integer;
    FMinMarginRight: Integer;
    FMinMarginBottom: Integer;

    FMaxMarginLeft: Integer;
    FMaxMarginTop: Integer;
    FMaxMarginRight: Integer;
    FMaxMarginBottom: Integer;

    FMarginLeft: Integer;
    FMarginTop: Integer;
    FMarginRight: Integer;
    FMarginBottom: Integer;
    FPageWidth, FPageHeight: Integer;
    //
    procedure RBPortraitClick(Sender: TObject);
    procedure RBLandScapeClick(Sender: TObject);
    procedure SizeComboBoxChange(Sender: TObject);
    procedure SourceComboBoxChange(Sender: TObject);

    procedure LeftMEditChange(Sender: TObject);
    procedure TopMEditChange(Sender: TObject);
    procedure RightMEditChange(Sender: TObject);
    procedure BottomMEditChange(Sender: TObject);

    procedure ClearPapersAndBins;
    procedure LoadPapersAndBins;
    procedure LoadCurrentPaperAndBin;
    procedure SaveCurrentPaperAndBin;
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
    FAlphaBlend: Boolean;
    FAlphaBlendValue: Byte;
    FAlphaBlendAnimation: Boolean;
    FUseSkinFont: Boolean;
    FTitle: String;
    procedure SetDefaultLabelFont(Value: TFont);
    procedure SetDefaultButtonFont(Value: TFont);
    procedure SetDefaultSelectFont(Value: TFont);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
    procedure PrinterButtonClick(Sender: TObject);
  public
    function Execute: Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    //
    property Options: TbsPageSetupDialogOptions read FOptions write FOptions
      default [];
    property Units: TbsPageMeasureUnits
      read FUnits write FUnits default bspmMillimeters;
    //
    property MinMarginLeft: Integer read FMinMarginLeft write FMinMarginLeft;
    property MinMarginTop: Integer read FMinMarginTop write FMinMarginTop;
    property MinMarginRight: Integer read FMinMarginRight write FMinMarginRight;
    property MinMarginBottom: Integer read FMinMarginBottom write FMinMarginBottom;

    property MaxMarginLeft: Integer read FMaxMarginLeft write FMaxMarginLeft;
    property MaxMarginTop: Integer read FMaxMarginTop write FMaxMarginTop;
    property MaxMarginRight: Integer read FMaxMarginRight write FMaxMarginRight;
    property MaxMarginBottom: Integer read FMaxMarginBottom write FMaxMarginBottom;

    property MarginLeft: Integer read FMarginLeft write FMarginLeft;
    property MarginTop: Integer read FMarginTop write FMarginTop;
    property MarginRight: Integer read FMarginRight write FMarginRight;
    property MarginBottom: Integer read FMarginBottom write FMarginBottom;
    property PageWidth: Integer read FPageWidth write FPageWidth;
    property PageHeight: Integer read FPageHeight write FPageHeight;
    //
    property Title: string read GetTitle write SetTitle;
    property AlphaBlend: Boolean read FAlphaBlend write FAlphaBlend;
    property AlphaBlendValue: Byte read FAlphaBlendValue write FAlphaBlendValue;
    property AlphaBlendAnimation: Boolean
      read FAlphaBlendAnimation write FAlphaBlendAnimation;
    property SkinData: TbsSkinData read FSD write FSD;
    property CtrlSkinData: TbsSkinData read FCtrlFSD write FCtrlFSD;
    property ButtonSkinDataName: String read FButtonSkinDataName write FButtonSkinDataName;
    property LabelSkinDataName: String read FLabelSkinDataName write FLabelSkinDataName;
    property ComboboxSkinDataName: String read FSelectSkinDataName write FSelectSkinDataName;
    property DefaultLabelFont: TFont read FDefaultLabelFont write SetDefaultLabelFont;
    property DefaultButtonFont: TFont read FDefaultButtonFont write SetDefaultButtonFont;
    property DefaultComboBoxFont: TFont read FDefaultSelectFont write SetDefaultSelectFont;
    property UseSkinFont: Boolean read FUseSkinFont write FUseSkinFont;
  end;

  TbsSkinPagePreview = class(TbsSkinPanel)
  protected
    procedure CreateControlDefaultImage(B: TBitMap); override;
    procedure CreateControlSkinImage(B: TBitMap); override;
  public
    PageWidth, PageHeight,
    LeftMargin, TopMargin, RightMargin, BottomMargin: Integer;
    constructor Create(AOwner: TComponent); override;
    procedure DrawPaper(R: TRect; Cnvs: TCanvas); 
  end;

implementation

{$R bsSkinPrinter}

Uses bsUtils, bsConst, Printers, WinSpool, bsMessages;

function GetStatusString(Status: DWORD): string;
begin
  case Status of
    0:
      Result := BS_PRNSTATUS_Ready;
    PRINTER_STATUS_PAUSED:
      Result := BS_PRNSTATUS_Paused;
    PRINTER_STATUS_PENDING_DELETION:
      Result := BS_PRNSTATUS_PendingDeletion;
    PRINTER_STATUS_BUSY:
      Result := BS_PRNSTATUS_Busy;
    PRINTER_STATUS_DOOR_OPEN:
      Result := BS_PRNSTATUS_DoorOpen;
    PRINTER_STATUS_ERROR:
      Result := BS_PRNSTATUS_Error;
    PRINTER_STATUS_INITIALIZING:
      Result := BS_PRNSTATUS_Initializing;
    PRINTER_STATUS_IO_ACTIVE:
      Result := BS_PRNSTATUS_IOActive;
    PRINTER_STATUS_MANUAL_FEED:
      Result := BS_PRNSTATUS_ManualFeed;
    PRINTER_STATUS_NO_TONER:
      Result := BS_PRNSTATUS_NoToner;
    PRINTER_STATUS_NOT_AVAILABLE:
      Result := BS_PRNSTATUS_NotAvailable;
    PRINTER_STATUS_OFFLINE:
      Result := BS_PRNSTATUS_OFFLine;
    PRINTER_STATUS_OUT_OF_MEMORY:
      Result := BS_PRNSTATUS_OutOfMemory;
    PRINTER_STATUS_OUTPUT_BIN_FULL:
      Result := BS_PRNSTATUS_OutBinFull;
    PRINTER_STATUS_PAGE_PUNT:
      Result := BS_PRNSTATUS_PagePunt;
    PRINTER_STATUS_PAPER_JAM:
      Result := BS_PRNSTATUS_PaperJam;
    PRINTER_STATUS_PAPER_OUT:
      Result := BS_PRNSTATUS_PaperOut;
    PRINTER_STATUS_PAPER_PROBLEM:
      Result := BS_PRNSTATUS_PaperProblem;
    PRINTER_STATUS_PRINTING:
      Result := BS_PRNSTATUS_Printing;
    PRINTER_STATUS_PROCESSING:
      Result := BS_PRNSTATUS_Processing;
    PRINTER_STATUS_TONER_LOW:
      Result := BS_PRNSTATUS_TonerLow;
    PRINTER_STATUS_USER_INTERVENTION:
      Result := BS_PRNSTATUS_UserIntervention;
    PRINTER_STATUS_WAITING:
      Result := BS_PRNSTATUS_Waiting;
    PRINTER_STATUS_WARMING_UP:
      Result := BS_PRNSTATUS_WarningUp;
  else
    Result := '';
  end;
end;

procedure CallDocumentPropertiesDialog(H: HWND);
var
  PPrinterDevMode: PDevMode;
  DevModeHandle: THandle;
  hPrinter: THandle;
  PrinterName, Driver, Port: array[0..79] of Char;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if not OpenPrinter(PrinterName, hPrinter, nil)
  then
    raise EPrinter.Create(SysErrorMessage(GetLastError ));
  PPrinterDevMode := GlobalLock(DevModeHandle);
  DocumentProperties(H, hPrinter, PrinterName, PPrinterDevMode^, PPrinterDevMode^, DM_OUT_BUFFER or DM_IN_BUFFER or DM_IN_PROMPT);
  GlobalUnlock(DevModeHandle);
  ClosePrinter(hPrinter);
end;

procedure SetCollate(Value: Boolean);
var
  PPrinterDevMode: PDevMode;
  DevModeHandle: THandle;
  hPrinter: THandle;
  PrinterName, Driver, Port: array[0..79] of Char;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if not OpenPrinter(PrinterName, hPrinter, nil)
  then
    raise EPrinter.Create(SysErrorMessage(GetLastError ));
  PPrinterDevMode := GlobalLock(DevModeHandle);
  if Value
  then PPrinterDevMode^.dmCollate := 1
  else PPrinterDevMode^.dmCollate := 0;
  DocumentProperties(0, hPrinter, PrinterName, PPrinterDevMode^, PPrinterDevMode^, DM_OUT_BUFFER or DM_IN_BUFFER);
  GlobalUnlock(DevModeHandle);
  ClosePrinter(hPrinter);
end;

function GetCollate: Boolean;
var
  PPrinterDevMode: PDevMode;
  DevModeHandle: THandle;
  hPrinter: THandle;
  PrinterName, Driver, Port: array[0..79] of Char;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if not OpenPrinter(PrinterName, hPrinter, nil)
  then
    raise EPrinter.Create(SysErrorMessage(GetLastError ));
  PPrinterDevMode := GlobalLock(DevModeHandle);
  DocumentProperties(0, hPrinter, PrinterName, PPrinterDevMode^, PPrinterDevMode^, DM_OUT_BUFFER or DM_IN_BUFFER);
  Result := PPrinterDevMode^.dmCollate > 0;
  GlobalUnlock(DevModeHandle);
  ClosePrinter(hPrinter);
end;

procedure RestoreDocumentProperties;
var
  PPrinterDevMode: PDevMode;
  DevModeHandle: THandle;
  hPrinter: THandle;
  PrinterName, Driver, Port: array[0..79] of Char;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if not OpenPrinter(PrinterName, hPrinter, nil)
  then
    raise EPrinter.Create(SysErrorMessage(GetLastError ));
  PPrinterDevMode := GlobalLock(DevModeHandle);
  DocumentProperties(0, hPrinter, PrinterName, PPrinterDevMode^, PPrinterDevMode^, DM_OUT_BUFFER);
  GlobalUnlock(DevModeHandle);
  ClosePrinter(hPrinter);
end;

procedure GetPrinterInfo(var AStatus, AType, APort, AComment: String);
var
  Flags, ACount, NumInfo: DWORD;
  Buffer, PInfo: PChar;
  PrinterName, Driver, Port: array[0..79] of Char;
  DevModeHandle: THandle;
  I: Integer;
  S1, S2: String;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);

  Flags := PRINTER_ENUM_CONNECTIONS or PRINTER_ENUM_LOCAL;
  ACount := 0;
  EnumPrinters(Flags, nil, 2, nil, 0, ACount, NumInfo);
  if ACount = 0 then Exit;
  GetMem(Buffer, ACount);
  if not EnumPrinters(Flags, nil, 2, PByte(Buffer), ACount, ACount, NumInfo)
  then
    begin
      FreeMem(Buffer, ACount);
      Exit;
    end;

  PInfo := Buffer;

  S1 := PrinterName;
  for i := 0 to NumInfo - 1 do
  begin
    S2 := PPrinterInfo2(PInfo)^.pPrinterName;
    if S1 = S2
    then
      Break
    else
      Inc(PInfo, Sizeof(TPrinterInfo2));
  end;

  AStatus := GetStatusString(PPrinterInfo2(PInfo)^.Status);
  AType := PPrinterInfo2(PInfo)^.pDriverName;
  APort := PPrinterInfo2(PInfo)^.pPortName;
  AComment := PPrinterInfo2(PInfo)^.pComment;

  FreeMem(Buffer, ACount);
end;


constructor TbsSkinPrintDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTitle := 'Print';

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FButtonSkinDataName := 'button';
  FLabelSkinDataName  := 'stdlabel';
  FSelectSkinDataName := 'combobox';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultSelectFont := TFont.Create;

  StopCheck := False;

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

destructor TbsSkinPrintDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultSelectFont.Free;
  inherited;
end;

procedure TbsSkinPrintDialog.FromPageEditChange(Sender: TObject);
begin
  RBPages.Checked := True;
end;

procedure TbsSkinPrintDialog.ToPageEditChange(Sender: TObject);
begin
  RBPages.Checked := True;
end;

procedure TbsSkinPrintDialog.PropertiesButtonClick(Sender: TObject);
begin
  CallDocumentPropertiesDialog(Form.Handle);
  StopCheck := True;
  NumCopiesEdit.Value :=  Printer.Copies;
  CollateCheckBox.Checked := GetCollate;
  StopCheck := False;
end;

procedure TbsSkinPrintDialog.PrinterComboBoxChange(Sender: TObject);
var
  S1, S2, S3, S4: String;
begin
  Printer.PrinterIndex := PrinterComboBox.ItemIndex;
  GetPrinterInfo(S1, S2, S3, S4);
  L1.Caption := S1;
  L2.Caption := S2;
  L3.Caption := S3;
  L4.Caption := S4;
  StopCheck := True;
  NumCopiesEdit.Value := Printer.Copies;
  CollateCheckBox.Checked := GetCollate;
  StopCheck := False;
end;

procedure TbsSkinPrintDialog.CollateCheckBoxClick(Sender: TObject);
begin
  if not StopCheck then SetCollate(CollateCheckBox.Checked);
  if CollateCheckBox.Checked
  then
    CollateImage.Picture.Bitmap.LoadFromResourceName(HInstance, 'BS_COLLATE')
  else
    CollateImage.Picture.Bitmap.LoadFromResourceName(HInstance, 'BS_NOCOLLATE');
end;

procedure TbsSkinPrintDialog.NumCopiesEditChange(Sender: TObject);
begin
  Printer.Copies := Round(NumCopiesEdit.Value);
  CollateCheckBox.Enabled := NumCopiesEdit.Value > 1;
end;

procedure TbsSkinPrintDialog.SetNumCopies(Value: Integer);
begin
  FCopies := Value;
  Printer.Copies := Value;
end;

function TbsSkinPrintDialog.Execute;
var
  BSF: TbsBusinessSkinForm;
  OldPrinterIndex: Integer;
  PrinterGroupBox: TbsSkinGroupBox;
  PrintRangeGroupBox: TbsSkinGroupBox;
  CopiesGroupBox: TbsSkinGroupBox;
  R: TRect;
  S1, S2, S3, S4: String;
  fromL, toL: TbsSkinStdLabel;
  SkinMessage: TbsSkinMessage;
  S: String;
begin
  if (Printer = nil) or (Printer.Printers.Count = 0)
  then
    begin
      SkinMessage := TbsSkinMessage.Create(Self);
      SkinMessage.SkinData := Self.SkinData;
      SkinMessage.CtrlSkinData := Self.CtrlSkinData;
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        S:= SkinData.ResourceStrData.GetResStr('PRNDLG_WARNING')
      else
        S := BS_PRNDLG_WARNING;
      SkinMessage.MessageDlg(S, mtError, [mbOk], 0);
      SkinMessage.Free;
      Exit;
    end;
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Position := poScreenCenter;
  Form.Caption := FTitle;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  Form.ClientWidth :=  470;
  Form.ClientHeight := 340;

  PrinterGroupBox := TbsSkinGroupBox.Create(Self);

  with PrinterGroupBox do
  begin
    Parent := Form;
    Left := 10;
    Top := 10;
    Width := Form.ClientWidth - 20;
    Height := 150;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PRINTER')
    else
      Caption := BS_PRNDLG_PRINTER;
  end;

  R := PrinterGroupBox.GetSkinClientRect;

  PrintToFileCheckBox := TbsSkinCheckRadioBox.Create(Self);
  with PrintToFileCheckBox do
  begin
    Parent := PrinterGroupBox;
    Checked := Self.PrintToFile;
    Left := R.Right - 100;
    Top := R.Bottom - 35;
    Width := 80;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PRINTTOFILE')
    else
      Caption := BS_PRNDLG_PRINTTOFILE;
    Enabled := not (bspoDisablePrintToFile in Options);
    Visible := bspoPrintToFile in Options;
    OnClick := CollateCheckBoxClick;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 10;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_NAME')
    else
      Caption := BS_PRNDLG_NAME;
  end;

  PrinterCombobox := TbsSkinCombobox.Create(Form);
  with PrinterCombobox do
  begin
    Parent := PrinterGroupBox;
    DefaultFont := DefaultComboboxFont;
    UseSkinFont := Self.UseSkinFont;
    Items.Assign(Printer.Printers);
    ItemIndex := Printer.PrinterIndex;
    SkinDataName := FSelectSkinDataName;
    SkinData := CtrlSkinData;
    OnChange := PrinterComboBoxChange;
    Top := R.Top + 7;
    Left := R.Left + 80;
    Width := RectWidth(R) - 180;
   end;

  with TbsSkinButton.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := PrinterCombobox.Left + PrinterCombobox.Width + 10;
    Top := R.Top + 5;
    Width := 80;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PROPERTIES')
    else
      Caption := BS_PRNDLG_PROPERTIES;
    OnClick := PropertiesButtonClick;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 40;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_STATUS')
    else
      Caption := BS_PRNDLG_STATUS;
  end;

  L1 := TbsSkinStdLabel.Create(Self);
  with L1 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 40;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 60;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_TYPE')
    else
      Caption := BS_PRNDLG_TYPE;
  end;

  L2 := TbsSkinStdLabel.Create(Self);
  with L2 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 60;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;


  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 80;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_WHERE')
    else
      Caption := BS_PRNDLG_WHERE;
  end;


  L3 := TbsSkinStdLabel.Create(Self);
  with L3 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 80;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 100;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_COMMENT')
    else
      Caption := BS_PRNDLG_COMMENT;
  end;

  L4 := TbsSkinStdLabel.Create(Self);
  with L4 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 100;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  GetPrinterInfo(S1, S2, S3, S4);
  L1.Caption := S1;
  L2.Caption := S2;
  L3.Caption := S3;
  L4.Caption := S4;

  PrintRangeGroupBox := TbsSkinGroupBox.Create(Self);

  with PrintRangeGroupBox do
  begin
    Parent := Form;
    Left := 10;
    Top := PrinterGroupBox.Top + PrinterGroupBox.Height + 10;
    Width := (Form.ClientWidth - 20) div 2 + 30;
    Height := 120;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PRINTRANGE')
    else
      Caption := BS_PRNDLG_PRINTRANGE;
  end;

  CopiesGroupBox := TbsSkinGroupBox.Create(Self);

  with CopiesGroupBox do
  begin
    Parent := Form;
    Left := PrintRangeGroupBox.Left + PrintRangeGroupBox.Width + 10;
    Top := PrinterGroupBox.Top + PrinterGroupBox.Height + 10;
    Width := (Form.ClientWidth - 20) div 2 - 40;
    Height := 120;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_COPIES')
    else
      Caption := BS_PRNDLG_COPIES;
  end;

  R := CopiesGroupBox.GetSkinClientRect;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := CopiesGroupBox;
    Left := R.Left + 5;
    Top := R.Top + 10;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_NUMCOPIES')
    else
      Caption := BS_PRNDLG_NUMCOPIES;
  end;

  NumCopiesEdit := TbsSkinSpinEdit.Create(Self);
  with  NumCopiesEdit do
  begin
    Parent := CopiesGroupBox;
    MinValue := 1;
    MaxValue := 1000;
    if Self.Copies > 0
    then
      Printer.Copies := Self.Copies;
    Value := Printer.Copies;
    Increment := 1;
    Left := R.Right - 65;
    Top := R.Top + 5;
    Width := 60;
    SkinData := CtrlSkinData;
    OnChange := NumCopiesEditChange;
  end;

  CollateCheckBox := TbsSkinCheckRadioBox.Create(Self);
  with CollateCheckBox do
  begin
    Parent := CopiesGroupBox;
    Checked := GetCollate;
    Left := R.Right - 70;
    Top := R.Top + 50;
    Width := 60;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_COLLATE')
    else
      Caption := BS_PRNDLG_COLLATE;
    Enabled := Printer.Copies > 1;
    OnClick := CollateCheckBoxClick;
  end;

  CollateImage := TImage.Create(Self);
  with CollateImage do
  begin
    Left := R.Left + 5;
    Top := R.Bottom - 45;
    Parent := CopiesGroupBox;
    AutoSize := True;
    Transparent := True;
    if CollateCheckBox.Checked
    then
      Picture.Bitmap.LoadFromResourceName(HInstance, 'BS_COLLATE')
    else
      Picture.Bitmap.LoadFromResourceName(HInstance, 'BS_NOCOLLATE');
  end;

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
    SetBounds(Form.ClientWidth - 160,
              CopiesGroupBox.Top + CopiesGroupBox.Height + 10,
              70, 25);
    DefaultHeight := 25;
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
    SetBounds(Form.ClientWidth - 80,
              CopiesGroupBox.Top + CopiesGroupBox.Height + 10,
              70, 25);
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 10;
  end;

  R := PrintRangeGroupBox.GetSkinClientRect;

  RBAll := TbsSkinCheckRadioBox.Create(Self);
  with RBAll do
  begin
    GroupIndex := 1;
    Parent := PrintRangeGroupBox;
    Checked := Self.PrintRange = bsprAllPages;
    Left := R.Left + 10;
    Top := R.Top + 5;
    Width := 70;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_ALL')
    else
      Caption := BS_PRNDLG_ALL;
  end;

  RBPages := TbsSkinCheckRadioBox.Create(Self);
  with RBPages do
  begin
    GroupIndex := 1;
    Parent := PrintRangeGroupBox;
    Checked := Self.PrintRange = bsprPageNums;
    Left := R.Left + 10;
    Top := R.Top + 35;
    Width := 70;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PAGES')
    else
      Caption := BS_PRNDLG_PAGES;
    Enabled := bspoPageNums in Options;
  end;

  RBSelection := TbsSkinCheckRadioBox.Create(Self);
  with RBSelection do
  begin
    GroupIndex := 1;
    Parent := PrintRangeGroupBox;
    Checked := Self.PrintRange = bsprSelection;
    Left := R.Left + 10;
    Top := R.Top + 65;
    Width := 70;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_SELECTION')
    else
      Caption := BS_PRNDLG_SELECTION;
    Enabled := bspoSelection in Options;
  end;

  fromL := TbsSkinStdLabel.Create(Self);

  with fromL do
  begin
    Parent := PrintRangeGroupBox;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_FROM')
    else
      Caption := BS_PRNDLG_FROM;
    Left := RBPages.Left + RBPages.Width + 10;
    Top := RBPages.Top + RBPages.Height div 2 - Height div 2 - 1;
    Enabled := bspoPageNums in Options;
  end;

  FromPageEdit := TbsSkinSpinEdit.Create(Self);
  with  FromPageEdit do
  begin
    Parent := PrintRangeGroupBox;
    MinValue := MinPage;
    MaxValue := MaxPage;
    Value := FromPage;
    Increment := 1;
    Left := fromL.Left + fromL.Width + 5;
    Top := RBPages.Top + RBPages.Height div 2 - Height div 2 - 1;
    Width := 50;
    SkinData := CtrlSkinData;
    Enabled := bspoPageNums in Options;
    OnChange := FromPageEditChange;
  end;

  ToL := TbsSkinStdLabel.Create(Self);

  with ToL do
  begin
    Parent := PrintRangeGroupBox;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_TO')
    else
      Caption := BS_PRNDLG_TO;
    Left := FromPageEdit.Left +FromPageEdit.Width + 5;
    Top := RBPages.Top + RBPages.Height div 2 - Height div 2 - 1;
    Enabled := bspoPageNums in Options;
  end;

  ToPageEdit := TbsSkinSpinEdit.Create(Self);
  with  ToPageEdit do
  begin
    Parent := PrintRangeGroupBox;
    MinValue := MinPage;
    MaxValue := MaxPage;
    Value := ToPage;
    Increment := 1;
    Left := ToL.Left + ToL.Width + 5;
    Top := RBPages.Top + RBPages.Height div 2 - Height div 2 - 1;
    Width := 50;
    SkinData := CtrlSkinData;
    Enabled := bspoPageNums in Options;
    OnChange := ToPageEditChange;
  end;

  OldPrinterIndex := Printer.PrinterIndex;

  try
    if Form.ShowModal = mrOk
    then
      begin
        Result := True;
        FCollate := CollateCheckBox.Checked;
        FromPage := Round(FromPageEdit.Value);
        ToPage := Round(ToPageEdit.Value);
        Copies := Round(NumCopiesEdit.Value);
        if RBAll.Checked then PrintRange := bsprAllPages else
        if RBPages.Checked then PrintRange := bsprPageNums else
          PrintRange := bsprSelection;
        PrintToFile := PrintToFileCheckBox.Checked;   
      end
    else
      begin
        RestoreDocumentProperties;
        if Printer.PrinterIndex <> OldPrinterIndex
        then
          Printer.PrinterIndex := OldPrinterIndex;
        Result := False;
      end;
  finally
    Form.Free;
  end;

end;

procedure TbsSkinPrintDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

procedure TbsSkinPrintDialog.SetDefaultButtonFont(Value: TFont);
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinPrintDialog.SetDefaultLabelFont(Value: TFont);
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinPrintDialog.SetDefaultSelectFont(Value: TFont);
begin
  FDefaultSelectFont.Assign(Value);
end;

function TbsSkinPrintDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSkinPrintDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;


{ TbsPaperInfo }

function TbsPaperInfo.IsEqual(Source: TbsPaperInfo): Boolean;
begin
  Result := (DMPaper = Source.DMPaper) and (FName = Source.Name) and
    EqPoints(Size, Source.Size);
end;

procedure TbsPaperInfo.Assign(Source: TbsPaperInfo);
begin
  FDMPaper := Source.FDMPaper;
  FName := Source.FName;
  FSize := Source.FSize;
end;

function TbsPaperInfo.GetSize(Index: Integer): Integer;
begin
  if Index = 0
  then
    Result := FSize.X
  else
    Result := FSize.Y;
end;

procedure TbsPaperInfo.SetSize(Index: Integer; Value: Integer);
begin
  if DMPaper < DMPAPER_USER then Exit;
  if Index = 0
  then
    FSize.X := Value
  else
    FSize.Y := Value;
end;

procedure GetPapers(APapers: TStrings);
const
  bsPaperNameLength = 64;
  bsPaperValueLength = SizeOf(Word);
  bsPaperSizeLength = SizeOf(TPoint);
type
  TbsPaperSize = TPoint;
  TbsPaperSizes = array[0..0] of TbsPaperSize;
  PbsPaperSizes = ^TbsPaperSizes;
  TbsPaperValue = Word;
  TbsPaperValues = array[0..0] of TbsPaperValue;
  PbsPaperValues = ^TbsPaperValues;
  TbsPaperName = array[0..bsPaperNameLength - 1] of char;
  TbsPaperNames = array[0..0] of TbsPaperName;
  PbsPaperNames = ^TbsPaperNames;
var
  APaperNames: PbsPaperNames;
  APaperValues: PbsPaperValues;
  APaperSizes: PbsPaperSizes;
  ACount: Integer;
  I: Integer;
  AName: string;
  AValue: Integer;
  ASize: TPoint;
  APaper: TbsPaperInfo;
  ACapability: UINT;
  ASaveFirstDMPaper: TPoint;
  PrinterName, Driver, Port: array[0..79] of Char;
  DevModeHandle: THandle;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if APapers <> nil then
  try
    APapers.Clear;
    ACapability := DC_PAPERNAMES;
    ACount := WinSpool.DeviceCapabilities(PrinterName, Port, ACapability, nil, nil);
    if ACount > 0 then
      begin
        APaperNames := AllocMem(bsPaperNameLength * ACount);
        try
          if WinSpool.DeviceCapabilities(PrinterName, Port, ACapability, PChar(APaperNames), nil) <> -1 then
          begin
            ACapability := DC_PAPERS;
            APaperValues := AllocMem(bsPaperValueLength * ACount);
            try
              if WinSpool.DeviceCapabilities(PrinterName, Port, ACapability, PChar(APaperValues), nil) <> -1 then
              begin
                ACapability := DC_PAPERSIZE;
                APaperSizes := AllocMem(bsPaperSizeLength * ACount);
                try
                  if WinSpool.DeviceCapabilities(PrinterName, Port, ACapability, PChar(APaperSizes), nil) <> -1 then
                  begin
                    for I := 0 to ACount - 1 do
                    begin
                      AName := APaperNames^[I];
                      AValue := APaperValues^[I];
                      ASize := APaperSizes^[I];
                      APaper := TbsPaperInfo.Create;
                      with APaper do
                      begin
                        FSize := ASize;
                        FDMPaper := AValue;
                        FName := AName;
                      end;
                      APapers.AddObject(APaper.Name, APaper);
                      if AValue = DMPAPER_FIRST then ASaveFirstDMPaper := ASize;
                    end;
                  end;
                finally
                  FreeMem(APaperSizes, bsPaperSizeLength * ACount);
                end;
              end;
            finally
              FreeMem(APaperValues, bsPaperValueLength * ACount);
            end;
          end;
        finally
          FreeMem(APaperNames, bsPaperNameLength * ACount);
        end;
    end;
  except
    raise;
  end;
end;

procedure GetBins(Bins: TStrings);
const
  bsBinLength = SizeOf(Word);
  bsBinNameLength = 24;
type
  TbsBin = Word;
  TbsBins = array[0..0] of TbsBin;
  PbsBins = ^TbsBins;
  TbsBinName = array[0..bsBinNameLength - 1] of char;
  TbsBinNames = array[0..0] of TbsBinName;
  PbsBinNames = ^TbsBinNames;
var
  ABins: PbsBins;
  ABinNames: PbsBinNames;
  ACount: Integer;
  I: Integer;
  AName: string;
  AValue: TbsBin;
  ACapability: UINT;
  PrinterName, Driver, Port: array[0..79] of Char;
  DevModeHandle: THandle;
begin
  if Bins <> nil then
  try
    Bins.Clear;
    if Printer.Printers.Count > 0 then
    begin
      Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
      ACapability := DC_BINS;
      ACount := WinSpool.DeviceCapabilities(PrinterName, Port, ACapability, nil, nil);
      if ACount > 0 then
      begin
        ABins := AllocMem(bsBinLength * ACount);
        try
          if WinSpool.DeviceCapabilities(PrinterName, Port, ACapability, PChar(ABins), nil) <> -1 then
          begin
            ABinNames := AllocMem(bsBinNameLength * ACount);
            try
              ACapability := DC_BINNAMES;
              if WinSpool.DeviceCapabilities(PrinterName, Port, ACapability, PChar(ABinNames), nil) <> -1 then
              begin
                for I := 0 to ACount - 1 do
                begin
                  AName := ABinNames^[I];
                  AValue := ABins^[I];
                  Bins.AddObject(AName, TObject(AValue));
                end;
              end;
            finally
              FreeMem(ABinNames, bsBinNameLength * ACount);
            end;
          end;
        finally
          FreeMem(ABins, bsBinLength * ACount);
        end;
      end;
    end;
  except
    raise;
  end;
end;


constructor TbsSkinPrinterSetupDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTitle := 'Print setup';

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FButtonSkinDataName := 'button';
  FLabelSkinDataName  := 'stdlabel';
  FSelectSkinDataName := 'combobox';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultSelectFont := TFont.Create;

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

  Bins := TStringList.Create;

  Papers := TStringList.Create;

  StopCheck := False;
end;

destructor TbsSkinPrinterSetupDialog.Destroy;
begin
  ClearPapersAndBins;
  Papers.Free;
  Bins.Free;
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultSelectFont.Free;
  inherited;
end;

procedure TbsSkinPrinterSetupDialog.ClearPapersAndBins;
var
  I: Integer;
begin
  if Papers.Count = 0 then Exit;
  for I := 0 to Papers.Count - 1 do
    TbsPaperInfo(Papers.Objects[I]).Free;
  Papers.Clear;
  Bins.Clear;  
end;

procedure TbsSkinPrinterSetupDialog.SaveCurrentPaperAndBin;
var
  PPrinterDevMode: PDevMode;
  DevModeHandle: THandle;
  hPrinter: THandle;
  PrinterName, Driver, Port: array[0..79] of Char;
  I: Integer;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if not OpenPrinter(PrinterName, hPrinter, nil)
  then
    raise EPrinter.Create(SysErrorMessage(GetLastError ));
  PPrinterDevMode := GlobalLock(DevModeHandle);
  //
  I := SizeComboBox.ItemIndex;
  if I <> -1
  then
   PPrinterDevMode^.dmPaperSize := TbsPaperInfo(Papers.Objects[I]).DMPaper;
  I := SourceComboBox.ItemIndex;
  if I <> -1
  then
    PPrinterDevMode^.dmDefaultSource := Integer(Bins.Objects[I]);
  //
  DocumentProperties(0, hPrinter, PrinterName, PPrinterDevMode^, PPrinterDevMode^, DM_OUT_BUFFER or DM_IN_BUFFER);
  GlobalUnlock(DevModeHandle);
  ClosePrinter(hPrinter);
end;

procedure TbsSkinPrinterSetupDialog.LoadCurrentPaperAndBin;
var
  PPrinterDevMode: PDevMode;
  DevModeHandle: THandle;
  hPrinter: THandle;
  PrinterName, Driver, Port: array[0..79] of Char;
  dm_Size: Integer;
  dm_Source: Integer;
  I, J: Integer;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if not OpenPrinter(PrinterName, hPrinter, nil)
  then
    raise EPrinter.Create(SysErrorMessage(GetLastError ));
  PPrinterDevMode := GlobalLock(DevModeHandle);
  DocumentProperties(0, hPrinter, PrinterName, PPrinterDevMode^, PPrinterDevMode^, DM_OUT_BUFFER or DM_IN_BUFFER);
  dm_Size := PPrinterDevMode^.dmPaperSize;
  dm_Source := PPrinterDevMode^.dmDefaultSource;
  GlobalUnlock(DevModeHandle);
  ClosePrinter(hPrinter);
  //
  J := 0;
  for I := 0 to SizeComboBox.Items.Count - 1 do
  begin
    if TbsPaperInfo(Papers.Objects[I]).DMPaper = dm_Size
    then
      begin
        J := I;
        Break;
      end;
  end;
  SizeComboBox.ItemIndex := J;
  //
  J := 0;
  for I := 0 to SourceComboBox.Items.Count - 1 do
  begin
    if Integer(Bins.Objects[I]) = dm_Source
    then
      begin
        J := I;
        Break;
      end;
  end;
  SourceComboBox.ItemIndex := J;
  //

  //
end;

procedure TbsSkinPrinterSetupDialog.LoadPapersAndBins;
begin
  ClearPapersAndBins;
  GetPapers(Papers);
  GetBins(Bins);

  StopCheck := True;

  SizeComboBox.Items.Assign(Papers);
  SourceComboBox.Items.Assign(Bins);
  LoadCurrentPaperAndBin;



  StopCheck := False;
end;

procedure TbsSkinPrinterSetupDialog.PropertiesButtonClick(Sender: TObject);
begin
  CallDocumentPropertiesDialog(Form.Handle);
  StopCheck := True;
  if Printer.Orientation = poPortrait
  then
    RBPortrait.Checked := True
  else
    RBLandscape.Checked := True;
  LoadCurrentPaperAndBin;
  StopCheck := False;
end;

procedure TbsSkinPrinterSetupDialog.PrinterComboBoxChange(Sender: TObject);
var
  S1, S2, S3, S4: String;
begin
  Printer.PrinterIndex := PrinterComboBox.ItemIndex;
  GetPrinterInfo(S1, S2, S3, S4);
  L1.Caption := S1;
  L2.Caption := S2;
  L3.Caption := S3;
  L4.Caption := S4;
  LoadPapersAndBins;
end;

procedure TbsSkinPrinterSetupDialog.RBPortraitClick(Sender: TObject);
begin
  Printer.Orientation := poPortrait;
  OrientationImage.Picture.Bitmap.LoadFromResourceName(HInstance, 'BS_PORTRAIT')
end;

procedure TbsSkinPrinterSetupDialog.RBLandScapeClick(Sender: TObject);
begin
  Printer.Orientation := poLandscape;
  OrientationImage.Picture.Bitmap.LoadFromResourceName(HInstance, 'BS_LANDSCAPE');
end;

procedure TbsSkinPrinterSetupDialog.SizeComboBoxChange(Sender: TObject);
begin
  if StopCheck then Exit;
  SaveCurrentPaperAndBin;
end;

procedure TbsSkinPrinterSetupDialog.SourceComboBoxChange(Sender: TObject);
begin
  if StopCheck then Exit;
  SaveCurrentPaperAndBin;
end;

function TbsSkinPrinterSetupDialog.Execute;
var
  BSF: TbsBusinessSkinForm;
  OldPrinterIndex: Integer;
  PrinterGroupBox: TbsSkinGroupBox;
  PaperGroupBox: TbsSkinGroupBox;
  OrientationGroupBox: TbsSkinGroupBox;
  R: TRect;
  S1, S2, S3, S4: String;
  SkinMessage: TbsSkinMessage;
  S: String;
begin
  if (Printer = nil) or (Printer.Printers.Count = 0)
  then
    begin
      SkinMessage := TbsSkinMessage.Create(Self);
      SkinMessage.SkinData := Self.SkinData;
      SkinMessage.CtrlSkinData := Self.CtrlSkinData;
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        S:= SkinData.ResourceStrData.GetResStr('PRNDLG_WARNING')
      else
        S := BS_PRNDLG_WARNING;
      SkinMessage.MessageDlg(S, mtError, [mbOk], 0);
      SkinMessage.Free;
      Exit;
    end;

  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Position := poScreenCenter;
  Form.Caption := FTitle;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  Form.ClientWidth :=  460;
  Form.ClientHeight := 340;

  PrinterGroupBox := TbsSkinGroupBox.Create(Self);

  with PrinterGroupBox do
  begin
    Parent := Form;
    Left := 10;
    Top := 10;
    Width := Form.ClientWidth - 20;
    Height := 150;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PRINTER')
    else
      Caption := BS_PRNDLG_PRINTER;
  end;

  R := PrinterGroupBox.GetSkinClientRect;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 10;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_NAME')
    else
      Caption := BS_PRNDLG_NAME;
  end;

  PrinterCombobox := TbsSkinCombobox.Create(Form);
  with PrinterCombobox do
  begin
    Parent := PrinterGroupBox;
    DefaultFont := DefaultComboboxFont;
    UseSkinFont := Self.UseSkinFont;
    Items.Assign(Printer.Printers);
    ItemIndex := Printer.PrinterIndex;
    SkinDataName := FSelectSkinDataName;
    SkinData := CtrlSkinData;
    OnChange := PrinterComboBoxChange;
    Top := R.Top + 7;
    Left := R.Left + 80;
    Width := RectWidth(R) - 180;
   end;

  with TbsSkinButton.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := PrinterCombobox.Left + PrinterCombobox.Width + 10;
    Top := R.Top + 5;
    Width := 80;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PROPERTIES')
    else
      Caption := BS_PRNDLG_PROPERTIES;
    OnClick := PropertiesButtonClick;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 40;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_STATUS')
    else
      Caption := BS_PRNDLG_STATUS;
  end;

  L1 := TbsSkinStdLabel.Create(Self);
  with L1 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 40;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 60;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_TYPE')
    else
      Caption := BS_PRNDLG_TYPE;
  end;

  L2 := TbsSkinStdLabel.Create(Self);
  with L2 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 60;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;


  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 80;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_WHERE')
    else
      Caption := BS_PRNDLG_WHERE;
  end;


  L3 := TbsSkinStdLabel.Create(Self);
  with L3 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 80;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 100;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_COMMENT')
    else
      Caption := BS_PRNDLG_COMMENT;
  end;

  L4 := TbsSkinStdLabel.Create(Self);
  with L4 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 100;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  GetPrinterInfo(S1, S2, S3, S4);
  L1.Caption := S1;
  L2.Caption := S2;
  L3.Caption := S3;
  L4.Caption := S4;

  PaperGroupBox := TbsSkinGroupBox.Create(Self);

  with PaperGroupBox do
  begin
    Parent := Form;
    Left := 10;
    Top := PrinterGroupBox.Top + PrinterGroupBox.Height + 10;
    Width := (Form.ClientWidth - 20) div 2 + 30;
    Height := 120;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PAPER')
    else
      Caption := BS_PRNDLG_PAPER;
  end;

  OrientationGroupBox := TbsSkinGroupBox.Create(Self);

  with OrientationGroupBox do
  begin
    Parent := Form;
    Left := PaperGroupBox.Left + PaperGroupBox.Width + 10;
    Top := PrinterGroupBox.Top + PrinterGroupBox.Height + 10;
    Width := (Form.ClientWidth - 20) div 2 - 40;
    Height := 120;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_ORIENTATION')
    else
      Caption := BS_PRNDLG_ORIENTATION;
  end;

  R := OrientationGroupBox.GetSkinClientRect;

  RBPortrait := TbsSkinCheckRadioBox.Create(Self);
  with RBPortrait do
  begin
    GroupIndex := 1;
    Parent := OrientationGroupBox;
    Checked := Printer.Orientation = poPortrait;
    Left := R.Right - 100;
    Top := R.Top + 15;
    Width := 90;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PORTRAIT')
    else
      Caption := BS_PRNDLG_PORTRAIT;
    OnClick := RBPortraitClick;
  end;

  RBLandScape := TbsSkinCheckRadioBox.Create(Self);
  with RBLandScape do
  begin
    GroupIndex := 1;
    Parent := OrientationGroupBox;
    Checked := Printer.Orientation = poLandScape;
    Left := R.Right - 100;
    Top := R.Bottom - 45;
    Width := 90;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_LANDSCAPE')
    else
      Caption := BS_PRNDLG_LANDSCAPE;
    OnClick := RBLandScapeClick;
  end;

  OrientationImage := TImage.Create(Self);
  with OrientationImage do
  begin
    Top := R.Top + 30;
    Left := R.Left + 25;
    Parent := OrientationGroupBox;
    AutoSize := True;
    Transparent := True;
    if Printer.Orientation = poPortrait
    then
      Picture.Bitmap.LoadFromResourceName(HInstance, 'BS_PORTRAIT')
    else
      Picture.Bitmap.LoadFromResourceName(HInstance, 'BS_LANDSCAPE');
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PaperGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 20;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_SIZE')
    else
      Caption := BS_PRNDLG_SIZE;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PaperGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 65;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_SOURCE')
    else
      Caption := BS_PRNDLG_SOURCE;
  end;

  SizeComboBox := TbsSkinCombobox.Create(Form);
  with SizeComboBox do
  begin
    Parent := PaperGroupBox;
    DefaultFont := DefaultComboboxFont;
    UseSkinFont := Self.UseSkinFont;
    SkinDataName := FSelectSkinDataName;
    SkinData := CtrlSkinData;
    Top := R.Top + 17;
    Left := R.Left + 65;
    Width := 170;
    OnChange := SizeComboBoxChange;
   end;

  SourceComboBox := TbsSkinCombobox.Create(Form);
  with SourceComboBox do
  begin
    Parent := PaperGroupBox;
    DefaultFont := DefaultComboboxFont;
    UseSkinFont := Self.UseSkinFont;
    SkinDataName := FSelectSkinDataName;
    SkinData := CtrlSkinData;
    Top := R.Top + 60;
    Left := R.Left + 65;
    Width := 170;
    OnChange := SourceComboBoxChange;
   end;

  //
  LoadPapersAndBins;
  //

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
    SetBounds(Form.ClientWidth - 160,
              OrientationGroupBox.Top + OrientationGroupBox.Height + 10,
              70, 25);
    DefaultHeight := 25;
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
    SetBounds(Form.ClientWidth - 80,
              OrientationGroupBox.Top + OrientationGroupBox.Height + 10,
              70, 25);
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 10;
  end;
 
  OldPrinterIndex := Printer.PrinterIndex;

  try
    if Form.ShowModal = mrOk
    then
      begin
        Result := True;
      end
    else
      begin
        RestoreDocumentProperties;
        if Printer.PrinterIndex <> OldPrinterIndex
        then
          Printer.PrinterIndex := OldPrinterIndex;
        Result := False;
      end;
  finally
    Form.Free;
  end;

end;

procedure TbsSkinPrinterSetupDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

procedure TbsSkinPrinterSetupDialog.SetDefaultButtonFont(Value: TFont);
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinPrinterSetupDialog.SetDefaultLabelFont(Value: TFont);
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinPrinterSetupDialog.SetDefaultSelectFont(Value: TFont);
begin
  FDefaultSelectFont.Assign(Value);
end;

function TbsSkinPrinterSetupDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSkinPrinterSetupDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

// TbsSkinSmallPrintDialog

constructor TbsSkinSmallPrintDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTitle := 'Print setup';

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FButtonSkinDataName := 'button';
  FLabelSkinDataName  := 'stdlabel';
  FSelectSkinDataName := 'combobox';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultSelectFont := TFont.Create;

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

destructor TbsSkinSmallPrintDialog.Destroy;
begin
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultSelectFont.Free;
  inherited;
end;

procedure TbsSkinSmallPrintDialog.PropertiesButtonClick(Sender: TObject);
begin
  CallDocumentPropertiesDialog(Form.Handle);
end;

procedure TbsSkinSmallPrintDialog.PrinterComboBoxChange(Sender: TObject);
var
  S1, S2, S3, S4: String;
begin
  Printer.PrinterIndex := PrinterComboBox.ItemIndex;
  GetPrinterInfo(S1, S2, S3, S4);
  L1.Caption := S1;
  L2.Caption := S2;
  L3.Caption := S3;
  L4.Caption := S4;
end;

function TbsSkinSmallPrintDialog.Execute;
var
  BSF: TbsBusinessSkinForm;
  OldPrinterIndex: Integer;
  PrinterGroupBox: TbsSkinGroupBox;
  R: TRect;
  S1, S2, S3, S4: String;
  SkinMessage: TbsSkinMessage;
  S: String;
begin
  if (Printer = nil) or (Printer.Printers.Count = 0)
  then
    begin
      SkinMessage := TbsSkinMessage.Create(Self);
      SkinMessage.SkinData := Self.SkinData;
      SkinMessage.CtrlSkinData := Self.CtrlSkinData;
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        S:= SkinData.ResourceStrData.GetResStr('PRNDLG_WARNING')
      else
        S := BS_PRNDLG_WARNING;
      SkinMessage.MessageDlg(S, mtError, [mbOk], 0);
      SkinMessage.Free;
      Exit;
    end;

  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Position := poScreenCenter;
  Form.Caption := FTitle;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  Form.ClientWidth :=  460;
  Form.ClientHeight := 170;

  PrinterGroupBox := TbsSkinGroupBox.Create(Self);

  with PrinterGroupBox do
  begin
    Parent := Form;
    Left := 10;
    Top := 10;
    Width := Form.ClientWidth - 20;
    Height := 150;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PRINTER')
    else
      Caption := BS_PRNDLG_PRINTER;
  end;

  R := PrinterGroupBox.GetSkinClientRect;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 10;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_NAME')
    else
      Caption := BS_PRNDLG_NAME;
  end;

  PrinterCombobox := TbsSkinCombobox.Create(Form);
  with PrinterCombobox do
  begin
    Parent := PrinterGroupBox;
    DefaultFont := DefaultComboboxFont;
    UseSkinFont := Self.UseSkinFont;
    Items.Assign(Printer.Printers);
    ItemIndex := Printer.PrinterIndex;
    SkinDataName := FSelectSkinDataName;
    SkinData := CtrlSkinData;
    OnChange := PrinterComboBoxChange;
    Top := R.Top + 7;
    Left := R.Left + 80;
    Width := RectWidth(R) - 180;
   end;

  with TbsSkinButton.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := PrinterCombobox.Left + PrinterCombobox.Width + 10;
    Top := R.Top + 5;
    Width := 80;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PROPERTIES')
    else
      Caption := BS_PRNDLG_PROPERTIES;
    OnClick := PropertiesButtonClick;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 40;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_STATUS')
    else
      Caption := BS_PRNDLG_STATUS;
  end;

  L1 := TbsSkinStdLabel.Create(Self);
  with L1 do          
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 40;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 60;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_TYPE')
    else
      Caption := BS_PRNDLG_TYPE;
  end;

  L2 := TbsSkinStdLabel.Create(Self);
  with L2 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 60;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;


  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 80;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_WHERE')
    else
      Caption := BS_PRNDLG_WHERE;
  end;


  L3 := TbsSkinStdLabel.Create(Self);
  with L3 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 80;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 100;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_COMMENT')
    else
      Caption := BS_PRNDLG_COMMENT;
  end;

  L4 := TbsSkinStdLabel.Create(Self);
  with L4 do
  begin
    Parent := PrinterGroupBox;
    Left := R.Left + 80;
    Top := R.Top + 100;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    Caption := '';
  end;

  GetPrinterInfo(S1, S2, S3, S4);
  L1.Caption := S1;
  L2.Caption := S2;
  L3.Caption := S3;
  L4.Caption := S4;

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
    SetBounds(Form.ClientWidth - 160,
              PrinterGroupBox.Top + PrinterGroupBox.Height + 10,
              70, 25);
    DefaultHeight := 25;
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
    SetBounds(Form.ClientWidth - 80,
              PrinterGroupBox.Top + PrinterGroupBox.Height + 10,
              70, 25);
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 10;
  end;
 
  OldPrinterIndex := Printer.PrinterIndex;

  try
    if Form.ShowModal = mrOk
    then
      begin
        Result := True;
      end
    else
      begin
        RestoreDocumentProperties;
        if Printer.PrinterIndex <> OldPrinterIndex
        then
          Printer.PrinterIndex := OldPrinterIndex;
        Result := False;
      end;
  finally
    Form.Free;
  end;

end;

procedure TbsSkinSmallPrintDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

procedure TbsSkinSmallPrintDialog.SetDefaultButtonFont(Value: TFont);
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinSmallPrintDialog.SetDefaultLabelFont(Value: TFont);
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinSmallPrintDialog.SetDefaultSelectFont(Value: TFont);
begin
  FDefaultSelectFont.Assign(Value);
end;

function TbsSkinSmallPrintDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSkinSmallPrintDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

// TbsSkinPageSetupDialog

function InchToMM(Inches: Double): Double;
begin
  Result := Inches * 25.4;
end;

function MMtoInch(MM: Double): Double;
begin
  Result := MM / 25.4;
end;

function MMtoInch2(MM: Double): Double;
begin
  Result := MM / 10;
  Result := Round(MMToInch(Result) * 1000) div 10;
end;

procedure GetPaperSizeInMM(var X, Y: Integer; PageWidth, PageHeight: Integer);
begin
  X := PageWidth * 10;
  Y := PageHeight * 10;
end;

procedure GetPaperSizeInInches(var X, Y: Integer; PageWidth, PageHeight: Integer);
begin
  GetPaperSizeInMM(X, Y, PageWidth, PageHeight);
  X := X div 10;
  Y := Y div 10;
  X := Round(MMToInch(X) * 1000) div 10;
  Y := Round(MMToInch(Y) * 1000) div 10;
end;

constructor TbsSkinPageSetupDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FTitle := 'Page setup';

  FAlphaBlend := False;
  FAlphaBlendAnimation := False;
  FAlphaBlendValue := 200;

  FButtonSkinDataName := 'button';
  FLabelSkinDataName  := 'stdlabel';
  FSelectSkinDataName := 'combobox';

  FDefaultLabelFont := TFont.Create;
  FDefaultButtonFont := TFont.Create;
  FDefaultSelectFont := TFont.Create;

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

  Bins := TStringList.Create;

  Papers := TStringList.Create;

  StopCheck := False;

  FMinMarginLeft := 0;
  FMinMarginTop := 0;
  FMinMarginRight := 0;
  FMinMarginBottom := 0;

  FMaxMarginLeft := 0;
  FMaxMarginTop := 0;
  FMaxMarginRight := 0;
  FMaxMarginBottom := 0;

  FMarginLeft := 0;
  FMarginTop := 0;
  FMarginRight := 0;
  FMarginBottom := 0;
  FPageWidth := 0;
  FPageHeight := 0;
  FOptions := [];
end;

destructor TbsSkinPageSetupDialog.Destroy;
begin
  ClearPapersAndBins;
  Papers.Free;
  Bins.Free;
  FDefaultLabelFont.Free;
  FDefaultButtonFont.Free;
  FDefaultSelectFont.Free;
  inherited;
end;

procedure TbsSkinPageSetupDialog.LeftMEditChange(Sender: TObject);
begin
  if FUnits = bspmMillimeters
  then
    PagePreview.LeftMargin := Round(LeftMEdit.Value * 100)
  else
    PagePreview.LeftMargin := Round(InchToMM(LeftMEdit.Value) * 100);
  PagePreview.RePaint;
end;

procedure TbsSkinPageSetupDialog.TopMEditChange(Sender: TObject);
begin
  if FUnits = bspmMillimeters
  then
    PagePreview.TopMargin := Round(TopMEdit.Value * 100)
  else
    PagePreview.TopMargin := Round(InchToMM(TopMEdit.Value) * 100);
  PagePreview.RePaint;
end;

procedure TbsSkinPageSetupDialog.RightMEditChange(Sender: TObject);
begin
  if FUnits = bspmMillimeters
  then
    PagePreview.RightMargin :=  Round(RightMEdit.Value * 100)
  else
    PagePreview.RightMargin :=  Round(InchToMM(RightMEdit.Value) * 100);
  PagePreview.RePaint;
end;

procedure TbsSkinPageSetupDialog.BottomMEditChange(Sender: TObject);
begin
  if FUnits = bspmMillimeters
  then
    PagePreview.BottomMargin :=  Round(BottomMEdit.Value * 100)
  else
    PagePreview.BottomMargin :=  Round(InchToMM(BottomMEdit.Value) * 100);
  PagePreview.RePaint;
end;

procedure TbsSkinPageSetupDialog.ClearPapersAndBins;
var
  I: Integer;
begin
  if Papers.Count = 0 then Exit;
  for I := 0 to Papers.Count - 1 do
    TbsPaperInfo(Papers.Objects[I]).Free;
  Papers.Clear;
  Bins.Clear;
end;

procedure TbsSkinPageSetupDialog.SaveCurrentPaperAndBin;
var
  PPrinterDevMode: PDevMode;
  DevModeHandle: THandle;
  hPrinter: THandle;
  PrinterName, Driver, Port: array[0..79] of Char;
  I: Integer;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if not OpenPrinter(PrinterName, hPrinter, nil)
  then
    raise EPrinter.Create(SysErrorMessage(GetLastError ));
  PPrinterDevMode := GlobalLock(DevModeHandle);
  //
  I := SizeComboBox.ItemIndex;
  if I <> -1
  then
   PPrinterDevMode^.dmPaperSize := TbsPaperInfo(Papers.Objects[I]).DMPaper;
  I := SourceComboBox.ItemIndex;
  if I <> -1
  then
    PPrinterDevMode^.dmDefaultSource := Integer(Bins.Objects[I]);
  //
  DocumentProperties(0, hPrinter, PrinterName, PPrinterDevMode^, PPrinterDevMode^, DM_OUT_BUFFER or DM_IN_BUFFER);
  GlobalUnlock(DevModeHandle);
  ClosePrinter(hPrinter);
end;

procedure TbsSkinPageSetupDialog.LoadCurrentPaperAndBin;
var
  PPrinterDevMode: PDevMode;
  DevModeHandle: THandle;
  hPrinter: THandle;
  PrinterName, Driver, Port: array[0..79] of Char;
  dm_Size: Integer;
  dm_Source: Integer;
  I, J: Integer;
begin
  Printer.GetPrinter(PrinterName, Driver, Port, DevModeHandle);
  if not OpenPrinter(PrinterName, hPrinter, nil)
  then
    raise EPrinter.Create(SysErrorMessage(GetLastError ));
  PPrinterDevMode := GlobalLock(DevModeHandle);
  DocumentProperties(0, hPrinter, PrinterName, PPrinterDevMode^, PPrinterDevMode^, DM_OUT_BUFFER or DM_IN_BUFFER);
  dm_Size := PPrinterDevMode^.dmPaperSize;
  dm_Source := PPrinterDevMode^.dmDefaultSource;
  GlobalUnlock(DevModeHandle);
  ClosePrinter(hPrinter);
  //
  J := 0;
  for I := 0 to SizeComboBox.Items.Count - 1 do
  begin
    if TbsPaperInfo(Papers.Objects[I]).DMPaper = dm_Size
    then
      begin
        J := I;
        Break;
      end;
  end;
  SizeComboBox.ItemIndex := J;
  //
  J := 0;
  for I := 0 to SourceComboBox.Items.Count - 1 do
  begin
    if Integer(Bins.Objects[I]) = dm_Source
    then
      begin
        J := I;
        Break;
      end;
  end;
  SourceComboBox.ItemIndex := J;
  //
  I := SizeComboBox.ItemIndex;
  if I <> -1
  then
    begin
      GetPaperSizeInMM(PagePreview.PageWidth, PagePreview.PageHeight,
                       TbsPaperInfo(Papers.Objects[I]).Size.X,
                       TbsPaperInfo(Papers.Objects[I]).Size.Y);

      if FUnits = bspmMillimeters
      then
        begin
          PagePreview.LeftMargin := Round(LeftMEdit.Value * 100);
          PagePreview.TopMargin := Round(TopMEdit.Value * 100);
          PagePreview.RightMargin := Round(RightMEdit.Value * 100);
          PagePreview.BottomMargin := Round(BottomMEdit.Value * 100);
        end
      else
        begin
          PagePreview.LeftMargin := Round(InchToMM(LeftMEdit.Value) * 100);
          PagePreview.TopMargin := Round(InchToMM(TopMEdit.Value) * 100);
          PagePreview.RightMargin := Round(InchToMM(RightMEdit.Value) * 100);
          PagePreview.BottomMargin := Round(InchToMM(BottomMEdit.Value) * 100);
        end;

      PagePreview.Repaint;
    end;
  //
end;

procedure TbsSkinPageSetupDialog.LoadPapersAndBins;
begin
  ClearPapersAndBins;
  GetPapers(Papers);
  GetBins(Bins);

  StopCheck := True;

  SizeComboBox.Items.Assign(Papers);
  SourceComboBox.Items.Assign(Bins);
  LoadCurrentPaperAndBin;

  StopCheck := False;
end;

procedure TbsSkinPageSetupDialog.RBPortraitClick(Sender: TObject);
begin
  Printer.Orientation := poPortrait;
  PagePreview.RePaint;
end;

procedure TbsSkinPageSetupDialog.RBLandScapeClick(Sender: TObject);
begin
  Printer.Orientation := poLandscape;
  PagePreview.RePaint;
end;

procedure TbsSkinPageSetupDialog.SizeComboBoxChange(Sender: TObject);
var
  I: Integer;
begin
  if StopCheck then Exit;
  SaveCurrentPaperAndBin;
  I := SizeComboBox.ItemIndex;
  if I <> -1
  then
    begin
      GetPaperSizeInMM(PagePreview.PageWidth, PagePreview.PageHeight,
                       TbsPaperInfo(Papers.Objects[I]).Size.X,
                       TbsPaperInfo(Papers.Objects[I]).Size.Y);
      PagePreview.Repaint;
    end;
end;

procedure TbsSkinPageSetupDialog.SourceComboBoxChange(Sender: TObject);
begin
  if StopCheck then Exit;
  SaveCurrentPaperAndBin;
end;

procedure TbsSkinPageSetupDialog.PrinterButtonClick(Sender: TObject);
var
  PD: TbsSkinSmallPrintDialog;
  S1: String;
  PI: Integer;
begin
  PD := TbsSkinSmallPrintDialog.Create(Self);
  PD.SkinData := Self.SkinData;
  PD.CtrlSkinData := Self.CtrlSkinData;
  if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
  then
    S1 := SkinData.ResourceStrData.GetResStr('PRNDLG_PRINTER')
  else
    S1 := BS_PRNDLG_PRINTER;
  PD.Title := S1;
  PI := Printer.PrinterIndex;
  if PD.Execute and (PI <> Printer.PrinterIndex)
  then
    LoadPapersAndBins;
  PD.Free;
end;

function TbsSkinPageSetupDialog.Execute;
var
  BSF: TbsBusinessSkinForm;
  OldPrinterIndex: Integer;
  PrinterGroupBox: TbsSkinGroupBox;
  PaperGroupBox: TbsSkinGroupBox;
  OrientationGroupBox: TbsSkinGroupBox;
  MarginsGroupBox: TbsSkinGroupBox;
  R: TRect;
  S1, S2, S3, S4: String;
  SkinMessage: TbsSkinMessage;
begin
  if (Printer = nil) or (Printer.Printers.Count = 0)
  then
    begin
      SkinMessage := TbsSkinMessage.Create(Self);
      SkinMessage.SkinData := Self.SkinData;
      SkinMessage.CtrlSkinData := Self.CtrlSkinData;
      if (SkinData <> nil) and (SkinData.ResourceStrData <> nil)
      then
        S1 := SkinData.ResourceStrData.GetResStr('PRNDLG_WARNING')
      else
        S1 := BS_PRNDLG_WARNING;
      SkinMessage.MessageDlg(S1, mtError, [mbOk], 0);
      SkinMessage.Free;
      Exit;
    end;
  Form := TForm.Create(Application);
  Form.BorderStyle := bsDialog;
  Form.Position := poScreenCenter;
  Form.Caption := FTitle;
  BSF := TbsBusinessSkinForm.Create(Form);
  BSF.BorderIcons := [];
  BSF.SkinData := SkinData;
  BSF.MenusSkinData := CtrlSkinData;
  BSF.AlphaBlend := AlphaBlend;
  BSF.AlphaBlendAnimation := AlphaBlendAnimation;
  BSF.AlphaBlendValue := AlphaBlendValue;

  Form.ClientWidth :=  390;
  Form.ClientHeight := 360;

  PagePreview := TbsSkinPagePreview.Create(Self);
  with PagePreview do
  begin
    Parent := Form;
    Left := 10;
    Top :=  10;
    Width := Form.ClientWidth - 20;
    Height := 130;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PAPER')
    else
      Caption := BS_PRNDLG_PAPER;
  end;


  PaperGroupBox := TbsSkinGroupBox.Create(Self);
  PaperGroupBox.Enabled := not (bspsoDisablePaper in Options);

  with PaperGroupBox do
  begin
    Parent := Form;
    Left := 10;
    Top :=  150;
    Width := Form.ClientWidth - 20;
    Height := 100;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PAPER')
    else
      Caption := BS_PRNDLG_PAPER;
  end;

  OrientationGroupBox := TbsSkinGroupBox.Create(Self);
  OrientationGroupBox.Enabled := not (bspsoDisableOrientation in Options);

  with OrientationGroupBox do
  begin
    Parent := Form;
    Left := 10;
    Top := PaperGroupBox.Top + PaperGroupBox.Height + 10;
    Width := (Form.ClientWidth - 20) div 2 - 70;
    Height := 100;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_ORIENTATION')
    else
      Caption := BS_PRNDLG_ORIENTATION;
  end;

  R := OrientationGroupBox.GetSkinClientRect;

  RBPortrait := TbsSkinCheckRadioBox.Create(Self);
  with RBPortrait do
  begin
    GroupIndex := 1;
    Parent := OrientationGroupBox;
    Checked := Printer.Orientation = poPortrait;
    Left := 10;
    Top := R.Top + 10;
    Width := 90;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PORTRAIT')
    else
      Caption := BS_PRNDLG_PORTRAIT;
    OnClick := RBPortraitClick;
  end;

  RBLandScape := TbsSkinCheckRadioBox.Create(Self);
  with RBLandScape do
  begin
    GroupIndex := 1;
    Parent := OrientationGroupBox;
    Checked := Printer.Orientation = poLandScape;
    Left := 10;
    Top := R.Bottom - 35;
    Width := 90;
    Radio := True;
    SkinDataName := 'radiobox';
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_LANDSCAPE')
    else
      Caption := BS_PRNDLG_LANDSCAPE;
    OnClick := RBLandScapeClick;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PaperGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 10;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_SIZE')
    else
      Caption := BS_PRNDLG_SIZE;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := PaperGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 47;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_SOURCE')
    else
      Caption := BS_PRNDLG_SOURCE;
  end;

  SizeComboBox := TbsSkinCombobox.Create(Form);
  with SizeComboBox do
  begin
    Parent := PaperGroupBox;
    DefaultFont := DefaultComboboxFont;
    UseSkinFont := Self.UseSkinFont;
    SkinDataName := FSelectSkinDataName;
    SkinData := CtrlSkinData;
    Top := R.Top + 7;
    Left := R.Left + 65;
    Width := PaperGroupBox.Width - 80;
    OnChange := SizeComboBoxChange;
   end;

  SourceComboBox := TbsSkinCombobox.Create(Form);
  with SourceComboBox do
  begin
    Parent := PaperGroupBox;
    DefaultFont := DefaultComboboxFont;
    UseSkinFont := Self.UseSkinFont;
    SkinDataName := FSelectSkinDataName;
    SkinData := CtrlSkinData;
    Top := R.Top + 45;
    Left := R.Left + 65;
    Width := PaperGroupBox.Width - 80;
    OnChange := SourceComboBoxChange;
   end;

  MarginsGroupBox := TbsSkinGroupBox.Create(Self);
  MarginsGroupBox.Enabled := not (bspsoDisableMargins in Options);

  with MarginsGroupBox do
  begin
    Parent := Form;
    Left := OrientationGroupBox.Left + OrientationGroupBox.Width + 10;
    Top := PaperGroupBox.Top + PaperGroupBox.Height + 10;
    Width := (Form.ClientWidth - 20) div 2 + 60;
    Height := 100;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      begin
        if FUnits = bspmMillimeters
        then
          Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_MARGINS')
        else
          Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_MARGINS_INCHES');
      end
    else
      begin
        if FUnits = bspmMillimeters
        then
          Caption := BS_PRNDLG_MARGINS
        else
          Caption := BS_PRNDLG_MARGINS_INCHES;
      end;  
  end;


  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := MarginsGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 10;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_LEFT')
    else
      Caption := BS_PRNDLG_LEFT;
  end;

  LeftMEdit := TbsSkinSpinEdit.Create(Self);
  with  LeftMEdit do
  begin
    Parent := MarginsGroupBox;
    ValueType := vtFloat;
    Increment := 1;
    Left := R.Left + 50;
    Top := R.Top + 8;
    Width := 60;
    SkinData := CtrlSkinData;
    if FUnits = bspmMillimeters
    then
      begin
        MinValue := FMinMarginLeft / 100;
        MaxValue := FMaxMarginLeft / 100;
        Value := FMarginLeft / 100;
      end
    else
      begin
        MinValue := FMinMarginLeft / 1000;
        MaxValue := FMaxMarginLeft / 1000;
        Value := FMarginLeft / 1000;
      end;  
    OnChange := LeftMEditChange;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := MarginsGroupBox;
    Left := LeftMEdit.Left + LeftMEdit.Width + 15;
    Top := R.Top + 10;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_RIGHT')
    else
      Caption := BS_PRNDLG_RIGHT;
  end;

  RightMEdit := TbsSkinSpinEdit.Create(Self);
  with  RightMEdit do
  begin
    Parent := MarginsGroupBox;
    ValueType := vtFloat;
    Increment := 1;
    Left := LeftMEdit.Left + LeftMEdit.Width + 55;
    Top := R.Top + 8;
    Width := 60;
    SkinData := CtrlSkinData;
    if FUnits = bspmMillimeters
    then
      begin
        MinValue := FMinMarginRight / 100;
        MaxValue := FMaxMarginRight / 100;
        Value := FMarginRight / 100;
      end  
    else
      begin
        MinValue := FMinMarginRight / 1000;
        MaxValue := FMaxMarginRight / 1000;
        Value := FMarginRight / 1000;
      end;  
    OnChange := RightMEditChange;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := MarginsGroupBox;
    Left := R.Left + 10;
    Top := R.Top + 45;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_TOP')
    else
      Caption := BS_PRNDLG_TOP;
  end;

  TopMEdit := TbsSkinSpinEdit.Create(Self);
  with  TopMEdit do
  begin
    Parent := MarginsGroupBox;
    ValueType := vtFloat;
    Increment := 1;
    Left := R.Left + 50;
    Top := R.Top + 43;
    Width := 60;
    SkinData := CtrlSkinData;
    if FUnits = bspmMillimeters
    then
      begin
        MinValue := FMinMarginTop / 100;
        MaxValue := FMaxMarginTop / 100;
        Value := FMarginTop / 100;
      end
    else
      begin
        MinValue := FMinMarginTop / 1000;
        MaxValue := FMaxMarginTop / 1000;
        Value := FMarginTop / 1000;
      end;
    OnChange := TopMEditChange;
  end;

  with TbsSkinStdLabel.Create(Self) do
  begin
    Parent := MarginsGroupBox;
    Left := LeftMEdit.Left + LeftMEdit.Width + 15;
    Top := R.Top + 45;
    WordWrap := False;
    DefaultFont := DefaultLabelFont;
    UseSkinFont := Self.UseSkinFont;
    SkinData := CtrlSkinData;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_BOTTOM')
    else
      Caption := BS_PRNDLG_BOTTOM;
  end;

  BottomMEdit := TbsSkinSpinEdit.Create(Self);
  with  BottomMEdit do
  begin
    Parent := MarginsGroupBox;
    ValueType := vtFloat;
    Increment := 1;
    Left := LeftMEdit.Left + LeftMEdit.Width + 55;
    Top := R.Top + 43;
    Width := 60;
    SkinData := CtrlSkinData;
    if FUnits = bspmMillimeters
    then
      begin
        MinValue := FMinMarginBottom / 100;
        MaxValue := FMaxMarginBottom / 100;
        Value := FMarginBottom / 100;
      end
    else
      begin
        MinValue := FMinMarginBottom / 1000;
        MaxValue := FMaxMarginBottom / 1000;
        Value := FMarginBottom / 1000;
      end;
    OnChange := BottomMEditChange;
  end;

  //
  LoadPapersAndBins;
  //

  with TbsSkinButton.Create(Form) do
  begin
    Enabled := not (bspsoDisablePrinter in Options);
    Parent := Form;
    DefaultFont := DefaultButtonFont;
    UseSkinFont := Self.UseSkinFont;
    if (CtrlSkinData <> nil) and (CtrlSkinData.ResourceStrData <> nil)
    then
      Caption := CtrlSkinData.ResourceStrData.GetResStr('PRNDLG_PRINTER') + '...'
    else
      Caption := BS_PRNDLG_PRINTER + '...';
    SetBounds(10,
              OrientationGroupBox.Top + OrientationGroupBox.Height + 10,
              115, 25);
    DefaultHeight := 25;
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
    OnClick := PrinterButtonClick;
  end;

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
    SetBounds(Form.ClientWidth - 160,
              OrientationGroupBox.Top + OrientationGroupBox.Height + 10,
              70, 25);
    DefaultHeight := 25;
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
    SetBounds(Form.ClientWidth - 80,
              OrientationGroupBox.Top + OrientationGroupBox.Height + 10,
              70, 25);
    SkinDataName := FButtonSkinDataName;
    SkinData := CtrlSkinData;
    Form.ClientHeight := Top + Height + 10;
  end;

  OldPrinterIndex := Printer.PrinterIndex;

  try
    if Form.ShowModal = mrOk
    then
      begin                             
        Result := True;
        if FUnits =  bspmMillimeters
        then
          begin
            FMarginLeft := PagePreview.LeftMargin;
            FMarginTop := PagePreview.TopMargin;
            FMarginRight := PagePreview.RightMargin;
            FMarginBottom := PagePreview.BottomMargin;
            FPageWidth := PagePreview.PageWidth;
            FPageHeight := PagePreview.PageHeight;
          end
        else
          begin
            FMarginLeft := Round(MMToInch2(PagePreview.LeftMargin));
            FMarginTop := Round(MMToInch2(PagePreview.TopMargin));
            FMarginRight := Round(MMToInch2(PagePreview.RightMargin));
            FMarginBottom := Round(MMToInch2(PagePreview.BottomMargin));
            FPageWidth := Round(MMToInch2(PagePreview.PageWidth));
            FPageHeight := Round(MMToInch2(PagePreview.PageHeight));
          end;
      end
    else
      begin
        RestoreDocumentProperties;
        if Printer.PrinterIndex <> OldPrinterIndex
        then
          Printer.PrinterIndex := OldPrinterIndex;
        Result := False;
      end;
  finally
    Form.Free;
  end;

end;

procedure TbsSkinPageSetupDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSD) then FSD := nil;
  if (Operation = opRemove) and (AComponent = FCtrlFSD) then FCtrlFSD := nil;
end;

procedure TbsSkinPageSetupDialog.SetDefaultButtonFont(Value: TFont);
begin
  FDefaultButtonFont.Assign(Value);
end;

procedure TbsSkinPageSetupDialog.SetDefaultLabelFont(Value: TFont);
begin
  FDefaultLabelFont.Assign(Value);
end;

procedure TbsSkinPageSetupDialog.SetDefaultSelectFont(Value: TFont);
begin
  FDefaultSelectFont.Assign(Value);
end;

function TbsSkinPageSetupDialog.GetTitle: string;
begin
  Result := FTitle;
end;

procedure TbsSkinPageSetupDialog.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

constructor TbsSkinPagePreview.Create(AOwner: TComponent);
begin
  inherited;
  FForceBackground := False;
  PageWidth := 0;
  Pageheight := 0;
  LeftMargin := 0;
  TopMargin := 0;
  RightMargin := 0;
  BottomMargin := 0;
end;

procedure TbsSkinPagePreview.DrawPaper(R: TRect; Cnvs: TCanvas);
var
  TempPageWidth,  TempPageHeight, 
  TempLeftMargin, TempTopMargin,
  TempRightMargin, TempBottomMargin: Integer;
  PR, TR: TRect;
  kf: Double;
begin
  if (PageWidth = 0) or (Pageheight = 0) then Exit;
  if Printer.Orientation = poPortrait
  then
    begin
      kf := RectHeight(R) / PageHeight;
      TempPageWidth  := Round(PageWidth * kf);
      TempPageheight  := Round(PageHeight * kf);
      TempLeftMargin := Round(LeftMargin * kf);
      TempTopMargin := Round(TopMargin * kf);
      TempRightMargin := Round(RightMargin * kf);
      TempBottomMargin := Round(BottomMargin * kf);
      PR := Rect(R.Left + RectWidth(R) div 2 - TempPageWidth div 2, R.Top,
                 R.Left + RectWidth(R) div 2 - TempPageWidth div 2 + TempPageWidth,
                 R.Top + TempPageHeight);
    end
  else
    begin
      kf := RectHeight(R) / PageHeight;
      TempPageWidth := Round(PageHeight * kf);
      TempPageHeight  := Round(PageWidth * kf);
      TempLeftMargin := Round(LeftMargin * kf);
      TempTopMargin := Round(TopMargin * kf);
      TempRightMargin := Round(RightMargin * kf);
      TempBottomMargin := Round(BottomMargin * kf);
      PR := Rect(R.Left + RectWidth(R) div 2 - TempPageWidth div 2,
                 R.Top + RectHeight(R) div 2 - TempPageHeight div 2,
                 R.Left + RectWidth(R) div 2 - TempPageWidth div 2 + TempPageWidth,
                 R.Top + RectHeight(R) div 2 - TempPageHeight div 2 + TempPageHeight);
    end;

  with Cnvs do
  begin
    Pen.Color := clBlack;
    Brush.Color := clWhite;
    Brush.Style := bsSolid;
    Rectangle(PR.Left, PR.Top, PR.Right, PR.Bottom);
    TR := PR;
    Inc(TR.Left, TempLeftMargin + 1);
    Inc(TR.Top, TempTopMargin + 1);
    Dec(TR.Right, TempRightMargin + 1);
    Dec(TR.Bottom, TempBottomMargin + 1);
    Pen.Color := clGray;
    Pen.Style := psDot;
    Brush.Color := $00F5F5F5;
    Brush.Style := bsBDiagonal;

    if TR.Left < PR.Left then TR.Left := PR.Left;
    if TR.Left > PR.Right then TR.Left := PR.Right;
    if TR.Right < PR.Left then TR.Right := PR.Left;
    if TR.Right > PR.Right then TR.Right := PR.Right;
    if TR.Top < PR.Top then TR.Top := PR.Top;
    if TR.Top > PR.Bottom then TR.Top := PR.Bottom;
    if TR.Bottom < PR.Top then TR.Bottom := PR.Top;
    if TR.Bottom > PR.Bottom then TR.Bottom := PR.Bottom;

    Rectangle(TR.Left, TR.Top, TR.Right, TR.Bottom);
  end;
  
end;

procedure TbsSkinPagePreview.CreateControlDefaultImage(B: TBitMap);
var
  R: TRect;
begin
  inherited;
  R := GetSkinClientRect;
  InflateRect(R, -5, -5);
  DrawPaper(R, B.Canvas);
end;

procedure TbsSkinPagePreview.CreateControlSkinImage(B: TBitMap);
var
  R: TRect;
begin
  inherited;
  R := GetSkinClientRect;
  InflateRect(R, -5, -5);
  DrawPaper(R, B.Canvas);
end;

end.



