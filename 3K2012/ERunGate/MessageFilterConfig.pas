unit MessageFilterConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmMessageFilterConfig = class(TForm)
    GroupBox1: TGroupBox;
    ListBoxFilterText: TListBox;
    ButtonAdd: TButton;
    ButtonDel: TButton;
    ButtonMod: TButton;
    ButtonOK: TButton;
    GroupBox2: TGroupBox;
    StartMsgFilterCheck: TCheckBox;
    rbMsgFilterType0: TRadioButton;
    rbMsgFilterType1: TRadioButton;
    rbMsgFilterType2: TRadioButton;
    rbMsgFilterType3: TRadioButton;
    Label1: TLabel;
    MsgFilterWarningMsgEdt: TEdit;
    procedure ListBoxFilterTextClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonModClick(Sender: TObject);
    procedure ListBoxFilterTextDblClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure StartMsgFilterCheckClick(Sender: TObject);
    procedure rbMsgFilterType0Click(Sender: TObject);
    procedure rbMsgFilterType1Click(Sender: TObject);
    procedure rbMsgFilterType2Click(Sender: TObject);
    procedure rbMsgFilterType3Click(Sender: TObject);
    procedure MsgFilterWarningMsgEdtChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMessageFilterConfig: TfrmMessageFilterConfig;

implementation

uses GateShare;

{$R *.dfm}

procedure TfrmMessageFilterConfig.ListBoxFilterTextClick(Sender: TObject);
begin
  if (ListBoxFilterText.ItemIndex >=0) and
     (ListBoxFilterText.ItemIndex < ListBoxFilterText.Items.Count) then begin
    ButtonDel.Enabled:=True;
    ButtonMod.Enabled:=True;
  end;
end;

procedure TfrmMessageFilterConfig.ButtonOKClick(Sender: TObject);
var
  i:Integer;
begin
  try
    CS_FilterMsg.Enter;
    AbuseList.Clear;
    for I := 0 to ListBoxFilterText.Items.Count - 1 do begin
      AbuseList.Add(ListBoxFilterText.Items.Strings[i]);
    end;
  finally
    CS_FilterMsg.Leave;
  end;
  AbuseList.SaveToFile('.\WordFilter.txt');
  if Conf <> nil then begin
    Conf.WriteBool(SpeedCheckClass, 'StartMsgFilterCheck', boStartMsgFilterCheck);//是否开启文字过滤
    Conf.WriteInteger(SpeedCheckClass,'MsgFilterType', nMsgFilterType);//文字处理的类型
    Conf.WriteString(SpeedCheckClass, 'MsgFilterWarningMsg', sMsgFilterWarningMsg);
  end;
  Close;
end;

procedure TfrmMessageFilterConfig.ButtonModClick(Sender: TObject);
var
  sInputText:String;
begin
  if (ListBoxFilterText.ItemIndex >=0) and (ListBoxFilterText.ItemIndex < ListBoxFilterText.Items.Count) then begin
    sInputText:=ListBoxFilterText.Items[ListBoxFilterText.ItemIndex];
    if not InputQuery('增加过滤文字', '请输入新的文字:     ', sInputText) then exit;
  end;
  if sInputText = '' then begin
     Application.MessageBox('请输入正确的文本！！！','错误信息', MB_OK + MB_ICONERROR );
     exit;
  end;
  ListBoxFilterText.Items[ListBoxFilterText.ItemIndex]:=sInputText;
end;

procedure TfrmMessageFilterConfig.ListBoxFilterTextDblClick(
  Sender: TObject);
begin
  ButtonModClick(Sender);
end;

procedure TfrmMessageFilterConfig.ButtonAddClick(Sender: TObject);
var
  sInputText:String;
begin
  if not InputQuery('增加过滤文字', '请输入新的文字:      ', sInputText) then exit;

  if sInputText = '' then begin
     Application.MessageBox('请输入正确的文本！！！','错误信息', MB_OK + MB_ICONERROR );
     exit;
  end;
  ListBoxFilterText.Items.Add(sInputText);
end;

procedure TfrmMessageFilterConfig.ButtonDelClick(Sender: TObject);
var
  nSelectIndex:Integer;
begin
  nSelectIndex:= ListBoxFilterText.ItemIndex;
  if ( nSelectIndex >= 0) and (nSelectIndex < ListBoxFilterText.Items.Count) then begin
    ListBoxFilterText.Items.Delete(nSelectIndex);
  end;
  if nSelectIndex >= ListBoxFilterText.Items.Count then
    ListBoxFilterText.ItemIndex:=nSelectIndex -1
  else  ListBoxFilterText.ItemIndex:=nSelectIndex;
  if ListBoxFilterText.ItemIndex < 0 then begin
    ButtonDel.Enabled:=False;
    ButtonMod.Enabled:=False;
  end;
end;

procedure TfrmMessageFilterConfig.StartMsgFilterCheckClick(
  Sender: TObject);
begin
  boStartMsgFilterCheck := StartMsgFilterCheck.Checked;
  if boStartMsgFilterCheck then begin
    rbMsgFilterType0.Enabled:= True;
    rbMsgFilterType1.Enabled:= True;
    rbMsgFilterType2.Enabled:= True;
    rbMsgFilterType3.Enabled:= True;
  end else begin
    rbMsgFilterType0.Enabled:= False;
    rbMsgFilterType1.Enabled:= False;
    rbMsgFilterType2.Enabled:= False;
    rbMsgFilterType3.Enabled:= False
  end;
  ButtonOK.Enabled := True;
end;

procedure TfrmMessageFilterConfig.rbMsgFilterType0Click(Sender: TObject);
begin
  nMsgFilterType:= 0;
  ButtonOK.Enabled := True;
end;

procedure TfrmMessageFilterConfig.rbMsgFilterType1Click(Sender: TObject);
begin
  nMsgFilterType:= 1;
  ButtonOK.Enabled := True;
end;

procedure TfrmMessageFilterConfig.rbMsgFilterType2Click(Sender: TObject);
begin
  nMsgFilterType:= 2;
  ButtonOK.Enabled := True;
end;

procedure TfrmMessageFilterConfig.rbMsgFilterType3Click(Sender: TObject);
begin
  nMsgFilterType:= 3;
  ButtonOK.Enabled := True;
end;

procedure TfrmMessageFilterConfig.MsgFilterWarningMsgEdtChange(
  Sender: TObject);
begin
  sMsgFilterWarningMsg:= MsgFilterWarningMsgEdt.Text;
  ButtonOK.Enabled := True;
end;

end.
