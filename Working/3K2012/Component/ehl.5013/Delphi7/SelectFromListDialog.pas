{*******************************************************}
{                                                       }
{                     EhLib v5.0                        }
{                                                       }
{             TfSelectFromListDialog form               }
{                                                       }
{     Copyright (c) 2004-2005 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit SelectFromListDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TfSelectFromListDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    ListBox1: TListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSelectFromListDialog: TfSelectFromListDialog;

function SelectFromList(Items: TStrings): Integer;

implementation

{$R *.dfm}

function SelectFromList(Items: TStrings): Integer;
var
  f: TfSelectFromListDialog;
begin
  Result := -1;
  f := TfSelectFromListDialog.Create(nil);
  f.ListBox1.Items := Items;
  if f.ShowModal = mrOk then
  begin
    Result := f.ListBox1.ItemIndex;
  end;
  f.Free;
end;

end.
