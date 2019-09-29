unit U_FrmChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TFrmChange = class(TForm)
    grp1: TGroupBox;
    lv1: TListView;
    grp2: TGroupBox;
    lv2: TListView;
    grp3: TGroupBox;
    lv3: TListView;
    GroupBox1: TGroupBox;
    Lv4: TListView;
    procedure lv1Data(Sender: TObject; Item: TListItem);
    procedure FormActivate(Sender: TObject);
    procedure lv2Data(Sender: TObject; Item: TListItem);
    procedure lv3Data(Sender: TObject; Item: TListItem);
    procedure Lv4Data(Sender: TObject; Item: TListItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmChange: TFrmChange;

implementation
 uses U_FrmMain,Mudutil;
{$R *.dfm}

procedure TFrmChange.FormActivate(Sender: TObject);
begin
  lv1.Items.BeginUpdate;
  lv1.Items.Count:=FrmMain.AccountChangeList.Count;
  lv1.Items.EndUpdate;
  lv2.Items.BeginUpdate;
  lv2.Items.Count:=FrmMain.HumChangeList.Count;
  lv2.Items.EndUpdate;
  lv3.Items.BeginUpdate;
  lv3.Items.Count:=FrmMain.GuildChangeList.Count;
  lv3.Items.EndUpdate;
  lv4.Items.BeginUpdate;
  lv4.Items.Count:=FrmMain.DivisionChangeList.Count;
  lv4.Items.EndUpdate;
end;

procedure TFrmChange.lv1Data(Sender: TObject; Item: TListItem);
begin
  Item.Caption:=IntToStr(Item.Index);
  Item.SubItems.Add(FrmMain.AccountChangeList[Item.Index]);
  Item.SubItems.Add(pTQuickName(FrmMain.AccountChangeList.Objects[Item.Index])^.sNewName);
end;

procedure TFrmChange.lv2Data(Sender: TObject; Item: TListItem);
begin
  Item.Caption:=IntToStr(Item.Index);
  Item.SubItems.Add(FrmMain.HumChangeList[Item.Index]);
  Item.SubItems.Add(pTQuickName(FrmMain.HumChangeList.Objects[Item.Index])^.sNewName);
end;

procedure TFrmChange.lv3Data(Sender: TObject; Item: TListItem);
begin
  Item.Caption:=IntToStr(Item.Index);
  Item.SubItems.Add(FrmMain.GuildChangeList[Item.Index]);
  Item.SubItems.Add(pTQuickName(FrmMain.GuildChangeList.Objects[Item.Index])^.sNewName);
end;

procedure TFrmChange.Lv4Data(Sender: TObject; Item: TListItem);
begin
  Item.Caption:=IntToStr(Item.Index);
  Item.SubItems.Add(FrmMain.DivisionChangeList[Item.Index]);
  Item.SubItems.Add(pTQuickName(FrmMain.DivisionChangeList.Objects[Item.Index])^.sNewName);
end;

end.
