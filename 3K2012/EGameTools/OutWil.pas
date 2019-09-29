unit OutWil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinData, BusinessSkinForm, bsSkinCtrls,
  StdCtrls, Mask, bsSkinBoxCtrls, ComCtrls, bsSkinShellCtrls;

type
  TFrmOutWil = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinData1: TbsSkinData;
    bsSkinStdLabel6: TbsSkinStdLabel;
    EditPicPath: TbsSkinEdit;
    bsSkinButton1: TbsSkinButton;
    bsSkinGroupBox1: TbsSkinGroupBox;
    Label3: TbsSkinStdLabel;
    Label2: TbsSkinStdLabel;
    editBegin: TbsSkinEdit;
    EditEnd: TbsSkinEdit;
    ProgressBar1: TProgressBar;
    btninput: TbsSkinButton;
    BtnOut: TbsSkinButton;
    bsSkinSelectDirectoryDialog1: TbsSkinSelectDirectoryDialog;
    procedure bsSkinButton1Click(Sender: TObject);
    procedure btninputClick(Sender: TObject);
    procedure BtnOutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOutWil: TFrmOutWil;
  PicPath,FileName:String;
implementation

uses main;

{$R *.dfm}

procedure TFrmOutWil.bsSkinButton1Click(Sender: TObject);
begin
  if bsSkinSelectDirectoryDialog1.Execute then  EditPicpath.Text:= bsSkinSelectDirectoryDialog1.Directory;
end;

procedure TFrmOutWil.btninputClick(Sender: TObject);
var
  BeginIndex,EndIndex,code,i:Integer;
  str:string;
  s:TStringlist;
begin
  Application.ProcessMessages;
  if Wil.Stream=nil then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请先打开wil文件！',mtInformation,[mbOK],0);
     exit;
  End;
  val(EditBegin.Text,BeginIndex,code);
  if code > 0 then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号',mtInformation,[mbOK],0);
     EditBegin.SetFocus;
     exit;
  End;
  val(EditEnd.Text,EndIndex,code);
  if code>0 then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号',mtInformation,[mbOK],0);
     EditEnd.SetFocus;
     exit;
  End;
  Application.ProcessMessages;
  if BeginIndex<0 then BeginIndex:=0;
  if EndIndex>=WIl.ImageCount then EndIndex:=Wil.ImageCount-1;
  Str:=EditPicPath.Text;
  if str='' then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入导出的位置！',mtInformation,[mbOK],0);
     exit;
  End;
  if str[length(str)]<>'\' then str:=str+'\';
  s:=TStringList.Create;
  if not DirectoryExists(str+'Placements\') then mkdir(str+'Placements\');
  ProgressBar1.Visible:=True;
  ProgressBar1.Max:=EndIndex-BeginIndex+1;
  ProgressBar1.Position:=0;
  for i:=BeginIndex to EndIndex do Begin
    ProgressBar1.StepIt;
    Application.ProcessMessages;
    Wil.Bitmaps[i].SaveToFile(str+format('%.6d.bmp',[i]));
    s.Clear;
    s.Add(inttostr(Wil.px));
    s.Add(inttostr(Wil.py));
    s.SaveToFile(str+'Placements\'+format('%.6d.txt',[i]));
  End;
  s.Free;
  ProgressBar1.Visible:=False;
  FrmMain.bsSkinMessage1.MessageDlg('批量导出图片成功！',mtInformation,[mbOK],0);
  close;
end;

procedure TFrmOutWil.BtnOutClick(Sender: TObject);
begin
  close;
end;

procedure TFrmOutWil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmOutWil.FormDestroy(Sender: TObject);
begin
  FrmOutWil := nil;
end;

end.
