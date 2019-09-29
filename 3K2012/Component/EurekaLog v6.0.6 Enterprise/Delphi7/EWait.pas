{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          Waiting form Unit - EWait             }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EWait;

{$I Exceptions.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TWaitForm = class(TForm)
    Panel: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WaitForm: TWaitForm;

implementation

uses EConsts;

{$R *.dfm}

procedure TWaitForm.FormCreate(Sender: TObject);
begin
  Label1.Caption := EWaitingCaption;
  Label2.Caption := Label1.Caption;
end;

end.
