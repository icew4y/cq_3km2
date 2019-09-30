unit SetDisableList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TSetDisableListFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox24: TGroupBox;
    sDisableNameList: TListBox;
    GroupBox25: TGroupBox;
    Label22: TLabel;
    DisableName_Edt: TEdit;
    DisableName_Add: TButton;
    DisableNameListDelete: TButton;
    GroupBox1: TGroupBox;
    sDisableStrList: TListBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DisableStrList_Edit: TEdit;
    DisableStrList_Add: TButton;
    DisableStrListDelete: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure DisableNameList();
    procedure DisableStrList();
    procedure FormShow(Sender: TObject);
    procedure DisableName_AddClick(Sender: TObject);
    procedure DisableNameListDeleteClick(Sender: TObject);
    procedure DisableName_EdtChange(Sender: TObject);
    procedure sDisableNameListClick(Sender: TObject);
    procedure DisableStrList_AddClick(Sender: TObject);
    procedure DisableStrListDeleteClick(Sender: TObject);
    procedure DisableStrList_EditChange(Sender: TObject);
    procedure sDisableStrListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetDisableListFrm: TSetDisableListFrm;

implementation
uses DBShare; 
{$R *.dfm}

procedure TSetDisableListFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TSetDisableListFrm.FormDestroy(Sender: TObject);
begin
  SetDisableListFrm:= nil;
end;

procedure TSetDisableListFrm.DisableNameList();
var
  I: Integer;
begin
  sDisableNameList.Clear;
  DisableName_Edt.Text := '';
  if g_FiltrateUserName.Count > 0 then begin//20090101
    for I := 0 to g_FiltrateUserName.Count - 1 do begin
      sDisableNameList.Items.Add(g_FiltrateUserName.Strings[I]);
    end;
  end;
end;

procedure TSetDisableListFrm.DisableStrList();
var
  I: Integer;
begin
  sDisableStrList.Clear;
  DisableStrList_Edit.Text := '';
  if g_FiltrateSortName.Count > 0 then begin//20090101
    for I := 0 to g_FiltrateSortName.Count - 1 do begin
      sDisableStrList.Items.Add(g_FiltrateSortName.Strings[I]);
    end;
  end;
end;

procedure TSetDisableListFrm.FormShow(Sender: TObject);
begin
 DisableNameList();
 DisableStrList();
end;

procedure TSetDisableListFrm.DisableName_AddClick(
  Sender: TObject);
var
  I: Integer;
  sFileName: string;
begin
    for I := 0 to sDisableNameList.Items.Count - 1 do begin
      if sDisableNameList.Items.Strings[I] = Trim(DisableName_Edt.text) then begin
        Application.MessageBox('此角色名称已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    sDisableNameList.Items.Add(Trim(DisableName_Edt.text));

//保存增加的信息到文件里
  sFileName := 'FiltrateUserName.txt';

  g_FiltrateUserName.Clear;
  for I := 0 to sDisableNameList.Items.Count - 1 do
    g_FiltrateUserName.Add(Trim(sDisableNameList.Items.Strings[I]));

  try
    g_FiltrateUserName.SaveToFile(sFileName);
  except
    if boViewHackMsg then MainOutMessage('[异常] TSetDisableListFrm.DisableName_AddClick');
  end;
DisableName_Add.Enabled:=False;
DisableName_Edt.text:='';
end;

procedure TSetDisableListFrm.DisableNameListDeleteClick(
  Sender: TObject);
var
  I: Integer;
  sFileName: string;
begin
  if sDisableNameList.ItemIndex >= 0 then
    sDisableNameList.Items.Delete(sDisableNameList.ItemIndex);

//保存删除的信息到文件里
  sFileName := 'FiltrateUserName.txt';
  g_FiltrateUserName.Clear;
  for I := 0 to sDisableNameList.Items.Count - 1 do
    g_FiltrateUserName.Add(Trim(sDisableNameList.Items.Strings[I]));

  try
    g_FiltrateUserName.SaveToFile(sFileName);
  except
    if boViewHackMsg then MainOutMessage('[异常] TSetDisableListFrm.DisableNameListDeleteClick');
  end;

end;

procedure TSetDisableListFrm.DisableName_EdtChange(Sender: TObject);
begin
  DisableName_Add.Enabled:= True;
end;

procedure TSetDisableListFrm.sDisableNameListClick(Sender: TObject);
begin
  if sDisableNameList.ItemIndex >= 0 then
    DisableNameListDelete.Enabled := True;
end;

procedure TSetDisableListFrm.DisableStrList_AddClick(Sender: TObject);
var
  I: Integer;
  sFileName: string;
begin
    for I := 0 to sDisableStrList.Items.Count - 1 do begin
      if sDisableStrList.Items.Strings[I] = Trim(DisableStrList_Edit.text) then begin
        Application.MessageBox('此字符已在列表中！！！', '错误信息', MB_OK + MB_ICONERROR);
        Exit;
      end;
    end;
    sDisableStrList.Items.Add(Trim(DisableStrList_Edit.text));

//保存增加的信息到文件里
  sFileName := 'FiltrateSortName.txt';

  g_FiltrateSortName.Clear;
  for I := 0 to sDisableStrList.Items.Count - 1 do
    g_FiltrateSortName.Add(Trim(sDisableStrList.Items.Strings[I]));

  try
    g_FiltrateSortName.SaveToFile(sFileName);
  except
    if boViewHackMsg then MainOutMessage('[异常] TSetDisableListFrm.DisableStrList_AddClick');
  end;
DisableStrList_Add.Enabled:=False;
DisableStrList_Edit.text:='';
end;

procedure TSetDisableListFrm.DisableStrListDeleteClick(Sender: TObject);
var
  I: Integer;
  sFileName: string;
begin
  if sDisableStrList.ItemIndex >= 0 then
    sDisableStrList.Items.Delete(sDisableStrList.ItemIndex);

//保存删除的信息到文件里
  sFileName := 'FiltrateSortName.txt';
  g_FiltrateSortName.Clear;
  for I := 0 to sDisableStrList.Items.Count - 1 do
    g_FiltrateSortName.Add(Trim(sDisableStrList.Items.Strings[I]));

  try
    g_FiltrateSortName.SaveToFile(sFileName);
  except
    if boViewHackMsg then MainOutMessage('[异常] TSetDisableListFrm.DisableStrListDeleteClick');
  end;
end;

procedure TSetDisableListFrm.DisableStrList_EditChange(Sender: TObject);
begin
  DisableStrList_Add.Enabled:= True;
end;

procedure TSetDisableListFrm.sDisableStrListClick(Sender: TObject);
begin
  if sDisableStrList.ItemIndex >= 0 then
    DisableStrListDelete.Enabled := True;
end;

end.
