unit GuildManage;
//行会管理
interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Guild, Spin;

type
  TfrmGuildManage = class(TForm)
    GroupBox1: TGroupBox;
    ListViewGuild: TListView;
    GroupBox2: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EditGuildName: TEdit;
    EditBuildPoint: TSpinEdit;
    EditAurae: TSpinEdit;
    EditStability: TSpinEdit;
    EditFlourishing: TSpinEdit;
    Label4: TLabel;
    EditChiefItemCount: TSpinEdit;
    Label5: TLabel;
    EditGuildFountain: TSpinEdit;
    Button1: TButton;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    EditGuildMemberCount: TSpinEdit;
    Button2: TButton;
    Label9: TLabel;
    SpinEditGuildMemberCount: TSpinEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ListViewGuildClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EditBuildPointClick(Sender: TObject);
    procedure EditGuildMemberCountChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EditBuildPointChange(Sender: TObject);
  private
    procedure RefGuildList;
    procedure RefGuildInfo;
    procedure ModValue();
    procedure uModValue();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmGuildManage: TfrmGuildManage;
  CurGuild: TGUild;

implementation

uses M2Share;
var
  boRefing: Boolean;
{$R *.dfm}
procedure TfrmGuildManage.ModValue();
begin
  Button1.Enabled := True;
  Button2.Enabled := True;
end;

procedure TfrmGuildManage.uModValue();
begin
  Button1.Enabled := False;
  Button2.Enabled := False;
end;

procedure TfrmGuildManage.RefGuildList;
var
  I: Integer;
  Guild: TGUild;
  ListItem: TListItem;
begin
  if g_GuildManager.GuildList.Count > 0 then begin
    for I := 0 to g_GuildManager.GuildList.Count - 1 do begin
      Guild := TGUild(g_GuildManager.GuildList.Items[I]);
      ListItem := ListViewGuild.Items.Add;
      ListItem.Caption := IntToStr(I);
      ListItem.SubItems.AddObject(Guild.sGuildName, Guild);
      ListItem.SubItems.Add(Guild.sGuildName);
    end;
  end;
end;

procedure TfrmGuildManage.Open;
begin
  EditGuildMemberCount.Value := g_Config.nGuildMemberCount;
  RefGuildList();
  uModValue();
  ShowModal;
end;

procedure TfrmGuildManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmGuildManage.FormDestroy(Sender: TObject);
begin
  frmGuildManage:= nil;
end;

procedure TfrmGuildManage.RefGuildInfo;
begin
  if CurGuild = nil then Exit;
  boRefing := True;
  EditGuildName.Text := CurGuild.sGuildName;
  EditBuildPoint.Value := CurGuild.nBuildPoint;//建筑度
  EditAurae.Value := CurGuild.nAurae; //人气度
  EditStability.Value := CurGuild.nStability; //安定度
  EditFlourishing.Value := CurGuild.nFlourishing;//繁荣度
  EditChiefItemCount.Value := CurGuild.nChiefItemCount;//行会领取装备数量
  EditGuildFountain.Value := CurGuild.m_nGuildFountain;//行会泉水仓库
  SpinEditGuildMemberCount.Value := CurGuild.m_nGuildMemberCount;//行会成员数量
  boRefing := False;
  uModValue();
end;

procedure TfrmGuildManage.ListViewGuildClick(Sender: TObject);
var
  ListItem: TListItem;
begin
  ListItem := ListViewGuild.Selected;
  if ListItem = nil then Exit;
  CurGuild := TGUild(ListItem.SubItems.Objects[0]);
  RefGuildInfo();
end;

procedure TfrmGuildManage.Button1Click(Sender: TObject);
begin
  Try
    if CurGuild = nil then begin
      uModValue();
      Exit;
    end;
    if EditGuildName.Text <> '' then begin
      if CompareText(CurGuild.sGuildName, EditGuildName.Text) = 0 then begin
        CurGuild.nBuildPoint := EditBuildPoint.Value;//建筑度
        CurGuild.nAurae := EditAurae.Value; //人气度
        CurGuild.nStability := EditStability.Value; //安定度
        CurGuild.nFlourishing := EditFlourishing.Value;//繁荣度
        CurGuild.nChiefItemCount := EditChiefItemCount.Value;//行会领取装备数量
        CurGuild.m_nGuildFountain := EditGuildFountain.Value;//行会泉水仓库
        CurGuild.m_nGuildMemberCount := SpinEditGuildMemberCount.Value;//行会成员数量
        CurGuild.SaveGuildInfoFile;
      end;
    end;
    uModValue();
  Except
    MainOutMessage(Format('{%s} TfrmGuildManage.Button1Click',[g_sExceptionVer]));
  end;
end;

procedure TfrmGuildManage.EditBuildPointClick(Sender: TObject);
begin
  Button1.Enabled:= True;
end;

procedure TfrmGuildManage.EditGuildMemberCountChange(Sender: TObject);
begin
  g_Config.nGuildMemberCount := EditGuildMemberCount.Value;
  ModValue();
end;

procedure TfrmGuildManage.Button2Click(Sender: TObject);
begin
  Config.WriteInteger('Setup', 'GuildMemberCount', g_Config.nGuildMemberCount);//新建行会成员上限
  uModValue();                 
end;

procedure TfrmGuildManage.EditBuildPointChange(Sender: TObject);
begin
  ModValue();
end;

end.
