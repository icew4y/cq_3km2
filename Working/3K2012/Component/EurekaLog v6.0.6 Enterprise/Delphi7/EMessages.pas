{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          Messages form - EMessages             }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EMessages;

{$I Exceptions.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExceptionLog, ExtCtrls;

type
  TMessageForm = class(TForm)
    OK: TBitBtn;
    Cancel: TBitBtn;
    ExceptionsFiltersPanel: TPanel;
    Shape14: TShape;
    Panel17: TPanel;
    Image10: TImage;
    Label1: TLabel;
    ExceptionMessageLabel: TLabel;
    DialogTypeLabel: TLabel;
    Label4: TLabel;
    ActionTypeLabel: TLabel;
    ExceptionTypeLabel: TLabel;
    MessageHelpLabel: TLabel;
    ExceptionMessageText: TMemo;
    ExceptionClassEdit: TComboBox;
    DialogTypeCmb: TComboBox;
    HandlerTypeCmb: TComboBox;
    ActionTypeCmb: TComboBox;
    ExceptionTypeCmb: TComboBox;
    procedure ExceptionTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HandlerTypeCmbChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MessageForm: TMessageForm;

implementation

{$R *.DFM}

uses EConsts, ECore, EDesign, EOption;

procedure TMessageForm.ExceptionTypeChange(Sender: TObject);
begin
  OK.Enabled := (ExceptionClassEdit.Text <> '');
end;

procedure TMessageForm.FormCreate(Sender: TObject);
var
  Tn: TFilterExceptionType;
  Dn: TFilterDialogType;
  Hn: TFilterHandlerType;
  An: TFilterActionType;
begin
  OK.Caption := EOK;
  Cancel.Caption := ECancel;

  ExceptionTypeCmb.Clear;
  for Tn := low(TypeValues) to high(TypeValues) do
    ExceptionTypeCmb.Items.Add(TypeValues[Tn]);
  ExceptionTypeCmb.ItemIndex := 2;

  DialogTypeCmb.Clear;
  for Dn := low(DialogValues) to high(DialogValues) do
    DialogTypeCmb.Items.Add(DialogValues[Dn]);
  DialogTypeCmb.ItemIndex := 3;

  HandlerTypeCmb.Clear;
  for Hn := low(HandleValues) to high(HandleValues) do
    HandlerTypeCmb.Items.Add(HandleValues[Hn]);
  HandlerTypeCmb.ItemIndex := 2;

  ActionTypeCmb.Clear;
  for An := low(ActionValues) to high(ActionValues) do
    ActionTypeCmb.Items.Add(ActionValues[An]);
  ActionTypeCmb.ItemIndex := 0;

  AdjustFontLanguage(Self);
end;

procedure TMessageForm.FormShow(Sender: TObject);
begin
  OK.Enabled := (ExceptionClassEdit.Text <> '');
  HandlerTypeCmbChange(nil);  
end;

procedure TMessageForm.HandlerTypeCmbChange(Sender: TObject);
var
  State: Boolean;
begin
  State := (HandlerTypeCmb.Text = 'EurekaLog');
  ExceptionMessageLabel.Enabled := State;
  MessageHelpLabel.Enabled := State;
  ExceptionMessageText.Enabled := State;
  ExceptionTypeLabel.Enabled := State;  
  ExceptionTypeCmb.Enabled := State;
  DialogTypeLabel.Enabled := State;
  DialogTypeCmb.Enabled := State;
  ActionTypeLabel.Enabled := State;
  ActionTypeCmb.Enabled := State;
end;

end.

