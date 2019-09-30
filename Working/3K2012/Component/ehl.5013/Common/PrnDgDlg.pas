{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{             TfPrnDBGridEhSetupDialog form             }
{                                                       }
{   Copyright (c) 1998-2004 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrnDgDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Printers, ExtCtrls;

type
  TfPrnDBGridEhSetupDialog = class(TForm)
    gbPrintFields: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    seUpMargin: TEdit;
    seLowMargin: TEdit;
    seLeftMargin: TEdit;
    seRightMargin: TEdit;
    cbFitWidthToPage: TCheckBox;
    ePrintFont: TEdit;
    cbAutoStretch: TCheckBox;
    bPrinterSetupDialog: TButton;
    bPrintFont: TButton;
    bOk: TButton;
    bCancel: TButton;
    FontDialog1: TFontDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    cbColored: TCheckBox;
    rgFitingType: TRadioGroup;
    cbOptimalColWidths: TCheckBox;
    procedure bPrintFontClick(Sender: TObject);
    procedure bPrinterSetupDialogClick(Sender: TObject);
    procedure seMarginExit(Sender: TObject);
    procedure fPrnDBGridEHSetupDialogShow(Sender: TObject);
    procedure cbFitWidthToPageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPrnDBGridEhSetupDialog: TfPrnDBGridEhSetupDialog;

implementation

{$R *.DFM}

procedure TfPrnDBGridEhSetupDialog.bPrintFontClick(Sender: TObject);
begin
  FontDialog1.Font.Name := ePrintFont.Text;
  if (FontDialog1.Execute = True) then ePrintFont.Text := FontDialog1.Font.Name;
end;

procedure TfPrnDBGridEhSetupDialog.bPrinterSetupDialogClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TfPrnDBGridEhSetupDialog.seMarginExit(Sender: TObject);
begin
  StrToFloat(TEdit(Sender).Text);
end;

procedure TfPrnDBGridEhSetupDialog.fPrnDBGridEHSetupDialogShow(
  Sender: TObject);
begin
  bPrinterSetupDialog.Enabled := Printer.Printers.Count > 0;
end;

procedure TfPrnDBGridEhSetupDialog.cbFitWidthToPageClick(Sender: TObject);
begin
  rgFitingType.Enabled := cbFitWidthToPage.Checked;
end;

end.
