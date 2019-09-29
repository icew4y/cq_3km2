unit M2regFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TM2regFileFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Label1: TLabel;
    EdtGameListURL: TEdit;
    EdtBakGameListURL: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdtPatchListURL: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button2: TButton;
    Edit4: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Button3: TButton;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
    procedure UpdataM2RegIP();//修改IP地址
    procedure UpdataM2RegHARD();//修改硬件信息
    { Public declarations }
  end;

var
  M2regFileFrm: TM2regFileFrm;

implementation

uses Main, Share, HUtil32;

{$R *.dfm}
procedure TM2regFileFrm.Open;
begin
  TabSheet1.TabVisible:= False;
  TabSheet2.TabVisible:= False;
  EdtGameListURL.Text:= g_MySelf.sGameListUrl;
  EdtBakGameListURL.Text:= g_MySelf.sBakGameListUrl;
  EdtPatchListURL.Text:= g_MySelf.sPatchListUrl;

  Edit1.Text:= Trim(g_MySelf.sGameListUrl);
  Edit2.Text:= Trim(g_MySelf.sBakGameListUrl);
  Edit3.text:= Trim(g_MySelf.sPatchListUrl);

  Edit4.Text:= Trim(g_MySelf.sGameListUrl);
  Edit5.Text:= Trim(g_MySelf.sBakGameListUrl);
  Edit6.text:= Trim(g_MySelf.sPatchListUrl);
  Label15.Caption := IntToStr(g_MySelf.nUpDataNum);
  Label16.Caption := IntToStr(g_MySelf.nUpDataNum);
  {case g_MySelf.nUpType of
    0:begin
      TabSheet1.TabVisible:= True;
      TabSheet2.TabVisible:= True;
    end;
    1: begin//只可修改IP信息
      TabSheet1.TabVisible:= True;
      TabSheet2.TabVisible:= False;
    end;
    2: begin//只可修改硬件信息
      TabSheet1.TabVisible:= False;
      TabSheet2.TabVisible:= True;
    end;
  end; }
  if g_MySelf.nUpType <> 3 then TabSheet2.TabVisible := True//20110712 包月用户不显示修改面板
  else begin
    Label13.Visible := False;
    Label15.Visible := False;
  end;

  ShowModal;
end;

procedure TM2regFileFrm.Button1Click(Sender: TObject);
begin
  MakeType := 2;//生成注册文件
  FrmMain.SendCheckMakeKeyAndDayMakeNum(g_MySelf.sAccount);
  Button1.Enabled := False;
end;

procedure TM2regFileFrm.Button2Click(Sender: TObject);
begin
{  if IsIPAddr(Trim(Edit2.Text)) then begin
    Button2.Enabled := False;
    MakeType := 3;//修改IP地址
    Edit2.Enabled := False;
    Edit6.Enabled := False;
    Button3.Enabled := False;
    FrmMain.SendCheckMakeUpdataDataNum(g_MySelf.sAccount);//检查用户的修改次数
  end else Application.MessageBox('IP信息输入有误！', '提示', MB_OK + MB_ICONINFORMATION);}
end;

procedure TM2regFileFrm.Button3Click(Sender: TObject);
begin
  Button3.Enabled := False;
  MakeType := 4;//修改硬件信息
  Button2.Enabled := False;
  Edit2.Enabled := False;
  Edit6.Enabled := False;
  FrmMain.SendCheckMakeUpdataDataNum(g_MySelf.sAccount);//检查用户的修改次数
end;

//修改IP地址
procedure TM2regFileFrm.UpdataM2RegIP();
begin
  FrmMain.SendUpdataM2RegIP(Trim(Edit2.Text)+'/'+g_MySelf.sAccount+'/'+Trim(Edit3.Text));
end;

//修改硬件信息
procedure TM2regFileFrm.UpdataM2RegHARD();
begin
  FrmMain.SendUpdataM2RegHARD(Trim(Edit6.Text)+'/'+g_MySelf.sAccount+'/'+Trim(Edit5.Text));
end;
end.
