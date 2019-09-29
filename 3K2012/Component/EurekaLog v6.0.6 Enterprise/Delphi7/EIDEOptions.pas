{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          Messages form - EMessages             }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EIDEOptions;

{$I Exceptions.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExceptionLog, ComCtrls, ExtCtrls;

type
  TIDEOptionsForm = class(TForm)
    OK: TBitBtn;
    Cancel: TBitBtn;
    SendOptionsPanel: TPanel;
    Shape9: TShape;
    Panel14: TPanel;
    Image9: TImage;
    IDEIntegration: TCheckBox;
    CheckUpdates: TCheckBox;
    UpdatesStepLabel: TLabel;
    UpdatesStepEdit: TEdit;
    UpdatesStepUpDown: TUpDown;
    UpdatesStep2Label: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure CheckUpdatesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  IDEOptionsForm: TIDEOptionsForm;

implementation

{$R *.DFM}

uses EConsts, ECore, EDesign, EOption;

procedure TIDEOptionsForm.CheckUpdatesClick(Sender: TObject);
var
  State: Boolean;
begin
  State := CheckUpdates.Checked;
  UpdatesStepLabel.Enabled := State;
  UpdatesStepEdit.Enabled := State;
  UpdatesStepUpDown.Enabled := State;
  UpdatesStep2Label.Enabled := State;
end;

procedure TIDEOptionsForm.FormCreate(Sender: TObject);
begin
  IDEIntegration.Checked := ECore.ReadBool(EurekaIni, 'IDE', 'Enabled', True);
  CheckUpdates.Checked := ECore.ReadBool(EurekaIni, 'IDE', 'CanCheckUpdates', True);
  UpdatesStepUpDown.Position := ECore.ReadInteger(EurekaIni, 'IDE', 'UpdatesCheckPeriod', 7);
  CheckUpdatesClick(nil);
  AdjustFontLanguage(Self);
end;

procedure TIDEOptionsForm.OKClick(Sender: TObject);
begin
  ECore.WriteBool(EurekaIni, 'IDE', 'Enabled', IDEIntegration.Checked);
  ECore.WriteBool(EurekaIni, 'IDE', 'CanCheckUpdates', CheckUpdates.Checked);
  ECore.WriteInteger(EurekaIni, 'IDE', 'UpdatesCheckPeriod', UpdatesStepUpDown.Position);
end;

end.

