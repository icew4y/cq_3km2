{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{         Variables form - EVariables            }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EVariables;

{$I Exceptions.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExceptionLog, ComCtrls, ExtCtrls;

type
  TVariableForm = class(TForm)
    OK: TBitBtn;
    CopyBtn: TBitBtn;
    ProxyOptionsPanel: TPanel;
    Shape5: TShape;
    Panel6: TPanel;
    Image6: TImage;
    Label1: TLabel;
    VariablesList: TListView;
    procedure FormCreate(Sender: TObject);
    procedure VariablesListClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VariableForm: TVariableForm;

implementation

{$R *.DFM}

uses EConsts, EDesign, Clipbrd;

procedure TVariableForm.CopyBtnClick(Sender: TObject);
var
  Item: TListItem;
begin
  Item := VariablesList.Selected;
  if (item = nil) then Exit;

  Clipboard.AsText := ('%' + Item.Caption + '%');
end;

procedure TVariableForm.FormCreate(Sender: TObject);
var
  i, Idx: Integer;
  s1, s2: string;
begin
  AdjustFontLanguage(Self);
  VariablesList.Items.Clear;
  for i := low(EVariablesOptions) to high(EVariablesOptions) do
  begin
    Idx := Pos('|', EVariablesOptions[i]);
    s1 := Trim(Copy(EVariablesOptions[i], 1, Idx - 1));
    s2 := Trim(Copy(EVariablesOptions[i], Idx + 1, MaxInt));
    with VariablesList.Items.Add do
    begin
      Caption := s1;
      SubItems.Add(s2);
    end;
  end;
end;

procedure TVariableForm.VariablesListClick(Sender: TObject);
begin
  CopyBtn.Enabled := (VariablesList.Selected <> nil);
end;

end.

