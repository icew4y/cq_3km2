unit DivisionManage;
//师门管理
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, Division;

type
  TFrmDivisionManage = class(TForm)
    GroupBox1: TGroupBox;
    ListViewGuild: TListView;
    GroupBox2: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label9: TLabel;
    EditGuildName: TEdit;
    EditAurae: TSpinEdit;
    Button1: TButton;
    SpinEditGuildMemberCount: TSpinEdit;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    EditGuildMemberCount: TSpinEdit;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    SpinEditBuildDivisionLevel: TSpinEdit;
    Label5: TLabel;
    SpinEditApplyDivisionLevel: TSpinEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewGuildDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EditAuraeChange(Sender: TObject);
    procedure EditGuildMemberCountChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpinEditBuildDivisionLevelChange(Sender: TObject);
    procedure SpinEditApplyDivisionLevelChange(Sender: TObject);
  private
    procedure RefDivisionList;
    procedure RefDivisionInfo;
    procedure ModValue();
    procedure uModValue();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  FrmDivisionManage: TFrmDivisionManage;
  CurDivision: TDivision;

implementation

uses M2Share, Grobal2;
var
  boRefing: Boolean;
{$R *.dfm}

procedure TFrmDivisionManage.Button1Click(Sender: TObject);
begin
  Try
    if CurDivision = nil then begin
      uModValue();
      Exit;
    end;
    if EditGuildName.Text <> '' then begin
      if CompareText(CurDivision.sDivisionName, EditGuildName.Text) = 0 then begin
        CurDivision.nPopularity := EditAurae.Value;//人气度
        CurDivision.m_nDivisionMemberCount:= SpinEditGuildMemberCount.Value;//成员数量
        CurDivision.sHeartName:= Edit1.Text;
        CurDivision.SaveDivisionInfoFile;
      end;
    end;
    uModValue();
  Except
    MainOutMessage(Format('{%s} TFrmDivisionManage.Button1Click',[g_sExceptionVer]));
  end;
end;

procedure TFrmDivisionManage.Button2Click(Sender: TObject);
begin
  {$IF M2Version <> 2}
  Config.WriteInteger('Setup', 'DivisionMemberCount', g_Config.nDivisionMemberCount);//新建师门成员上限
  Config.WriteInteger('Setup', 'BuildDivisionLevel', g_Config.nBuildDivisionLevel);
  Config.WriteInteger('Setup', 'ApplyDivisionLevel', g_Config.nApplyDivisionLevel);
  uModValue();
  {$IFEND}
end;

procedure TFrmDivisionManage.EditAuraeChange(Sender: TObject);
begin
  ModValue();
end;

procedure TFrmDivisionManage.EditGuildMemberCountChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  g_Config.nDivisionMemberCount := EditGuildMemberCount.Value;
  ModValue();
  {$IFEND}
end;

procedure TFrmDivisionManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmDivisionManage.FormDestroy(Sender: TObject);
begin
  FrmDivisionManage:= nil;
end;

procedure TFrmDivisionManage.ListViewGuildDblClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewGuild.Selected;
  if ListItem = nil then Exit;
  CurDivision := TDivision(ListItem.SubItems.Objects[0]);
  RefDivisionInfo();
end;

procedure TFrmDivisionManage.ModValue();
begin
  Button1.Enabled := True;
  Button2.Enabled := True;
end;

procedure TFrmDivisionManage.uModValue();
begin
  Button1.Enabled := False;
  Button2.Enabled := False;
end;

procedure TFrmDivisionManage.RefDivisionList;
var
  I: Integer;
  Division: TDivision;
  ListItem: TListItem;
begin
{$IF M2Version <> 2}
  if g_DivisionManager.DivisionList.Count > 0 then begin
    for I := 0 to g_DivisionManager.DivisionList.Count - 1 do begin
      Division := TDivision(g_DivisionManager.DivisionList.Items[I]);
      ListItem := ListViewGuild.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(Division.sDivisionName, Division);
      ListItem.SubItems.Add(Division.sDivisionName);
    end;
  end;
{$IFEND}
end;

procedure TFrmDivisionManage.SpinEditApplyDivisionLevelChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  g_Config.nApplyDivisionLevel := SpinEditApplyDivisionLevel.Value;
  ModValue();
  {$IFEND}
end;

procedure TFrmDivisionManage.SpinEditBuildDivisionLevelChange(Sender: TObject);
begin
  {$IF M2Version <> 2}
  g_Config.nBuildDivisionLevel := SpinEditBuildDivisionLevel.Value;
  ModValue();
  {$IFEND}
end;

procedure TFrmDivisionManage.Open;
begin
  {$IF M2Version <> 2}
  EditGuildMemberCount.Value := g_Config.nDivisionMemberCount;
  SpinEditBuildDivisionLevel.Value := g_Config.nBuildDivisionLevel;
  SpinEditApplyDivisionLevel.Value := g_Config.nApplyDivisionLevel;
  RefDivisionList();
  uModValue();
  {$IFEND}
  ShowModal;
end;

procedure TFrmDivisionManage.RefDivisionInfo;
begin
  if CurDivision = nil then Exit;
  boRefing := True;
  EditGuildName.Text := CurDivision.sDivisionName;
  EditAurae.Value := CurDivision.nPopularity;//人气度
  SpinEditGuildMemberCount.Value := CurDivision.m_nDivisionMemberCount;//成员数量
  Edit1.Text:= CurDivision.sHeartName;
  boRefing := False;
  uModValue();
end;
end.
