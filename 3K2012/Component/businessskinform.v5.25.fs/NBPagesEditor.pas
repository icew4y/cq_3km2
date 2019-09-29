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

unit NBPagesEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  bsSkinCtrls, StdCtrls;

type
  TNBPagesForm = class(TForm)
    PageListBox: TListBox;
    CaptionEdit: TEdit;
    AddButton: TButton;
    DeleteButton: TButton;
    MoveUpButton: TButton;
    MoveDownButton: TButton;
    IIndexBox: TComboBox;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure PageListBoxClick(Sender: TObject);
    procedure CaptionEditChange(Sender: TObject);
    procedure MoveUpButtonClick(Sender: TObject);
    procedure MoveDownButtonClick(Sender: TObject);
    procedure IIndexBoxChange(Sender: TObject);
  private
    NB: TbsSkinNoteBook;
  public
    { Public declarations }
  end;

var
  NBPagesForm: TNBPagesForm;

  procedure Execute(ANoteBook: TbsSkinNoteBook);

implementation

{$R *.DFM}

procedure Execute(ANoteBook: TbsSkinNoteBook);
begin
  NBPagesForm := TNBPagesForm.Create(Application);
  NBPagesForm.NB := ANoteBook;
  NBPagesForm.ShowModal;
  NBPagesForm.Free;
end;

procedure TNBPagesForm.FormShow(Sender: TObject);
var
  I, J: Integer;
begin
  if NB.Pages.Count <> 0
  then
    begin
      for I := 0 to NB.Pages.Count - 1 do
      PageListBox.Items.Add(NB.Pages[I]);
      PageListBox.ItemIndex := 0;
      CaptionEdit.Text := PageListBox.Items[PageListBox.ItemIndex];
    end;

  IIndexBox.Clear;

  if NB.Images <> nil
  then
    for I := -1 to NB.Images.Count - 1 do
    begin
      IIndexBox.Items.Add(IntToStr(I));
      J := TbsSkinPage(NB.FPageList.Items[PageListBox.ItemIndex]).ImageIndex;
      IIndexBox.ItemIndex := J + 1;
    end;
end;

procedure TNBPagesForm.AddButtonClick(Sender: TObject);
begin
  NB.Pages.Add('Page' + IntToStr(NB.Pages.Count));
  PageListBox.Items.Add(NB.Pages[NB.Pages.Count - 1]);
  PageListBox.ItemIndex := NB.Pages.Count - 1;
end;

procedure TNBPagesForm.DeleteButtonClick(Sender: TObject);
begin
  NB.Pages.Delete(PageListBox.ItemIndex);
  PageListBox.Items.Delete(PageListBox.ItemIndex);
end;

procedure TNBPagesForm.PageListBoxClick(Sender: TObject);
begin
  if PageListBox.ItemIndex <> -1
  then
    begin
      CaptionEdit.Text := PageListBox.Items[PageListBox.ItemIndex];
      NB.PageIndex := PageListBox.ItemIndex;
      IIndexBox.ItemIndex := TbsSkinPage(NB.FPageList.Items[PageListBox.ItemIndex]).ImageIndex + 1;
    end;
end;

procedure TNBPagesForm.CaptionEditChange(Sender: TObject);
begin
  with PageListBox do
  if ItemIndex <> -1
  then
    begin
      NB.Pages[ItemIndex] := CaptionEdit.Text;
      Items[ItemIndex] := NB.Pages[ItemIndex];
    end;
end;

procedure TNBPagesForm.MoveUpButtonClick(Sender: TObject);
var
  I: Integer;
begin
  with PageListBox do
  if (ItemIndex <> -1) and (ItemIndex > 0)
  then
    begin
      I := ItemIndex;
      NB.Pages.Move(ItemIndex, ItemIndex - 1);
      Items.Move(ItemIndex, ItemIndex - 1);
      ItemIndex := I - 1;
      CaptionEdit.Text := PageListBox.Items[PageListBox.ItemIndex];
      NB.PageIndex := ItemIndex;
    end;
end;

procedure TNBPagesForm.MoveDownButtonClick(Sender: TObject);
var
  I: Integer;
begin
  with PageListBox do
  if (ItemIndex <> -1) and (ItemIndex < NB.Pages.Count - 1)
  then
    begin
      I := ItemIndex;
      NB.Pages.Move(ItemIndex, ItemIndex + 1);
      Items.Move(ItemIndex, ItemIndex + 1);
      ItemIndex := I + 1;
      CaptionEdit.Text := PageListBox.Items[PageListBox.ItemIndex];
      NB.PageIndex := ItemIndex;
    end;
end;

procedure TNBPagesForm.IIndexBoxChange(Sender: TObject);
var
  Form: TCustomForm;
begin
  if PageListBox.ItemIndex = -1 then Exit;
  TbsSkinPage(NB.FPageList.Items[PageListBox.ItemIndex]).ImageIndex := IIndexBox.ItemIndex - 1;
  NB.UpDateButton(PageListBox.ItemIndex, PageListBox.Items[PageListBox.ItemIndex]);
  if csDesigning in NB.ComponentState then
  begin
    Form := GetParentForm(NB);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
end;

end.
