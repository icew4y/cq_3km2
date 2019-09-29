unit NewWil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinShellCtrls, bsSkinData, BusinessSkinForm, bsSkinCtrls,
  StdCtrls, Mask, bsSkinBoxCtrls, ComCtrls, mywil, FileCtrl;

type
  TFrmNewWil = class(TForm)
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    SaveDialog1: TbsSkinSaveDialog;
    bsSkinStdLabel6: TbsSkinStdLabel;
    EditPicPath: TbsSkinEdit;
    bsSkinButton1: TbsSkinButton;
    EditFileName: TbsSkinEdit;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinButton2: TbsSkinButton;
    bsSkinGroupBox2: TbsSkinGroupBox;
    suiRadioButton1: TbsSkinCheckRadioBox;
    suiRadioButton2: TbsSkinCheckRadioBox;
    editxy: TbsSkinEdit;
    bsSkinGroupBox1: TbsSkinGroupBox;
    RbBoardSys: TbsSkinCheckRadioBox;
    RbBoardBmp: TbsSkinCheckRadioBox;
    ProgressBar1: TProgressBar;
    btninput: TbsSkinButton;
    BtnOut: TbsSkinButton;
    bsSkinSelectDirectoryDialog1: TbsSkinSelectDirectoryDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    procedure bsSkinButton2Click(Sender: TObject);
    procedure BtnOutClick(Sender: TObject);
    procedure btninputClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNewWil: TFrmNewWil;

implementation

uses Main;

{$R *.dfm}
function ExtractFileNameOnly (const fname: string): string;
var
  extpos: integer;
  ext, fn: string;
begin
  ext := ExtractFileExt (fname);
  fn := ExtractFileName (fname);
  if ext <> '' then begin
    extpos := pos (ext, fn);
    Result := Copy (fn, 1, extpos-1);
  end else Result := fn;
end;

procedure TFrmNewWil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmNewWil.FormDeactivate(Sender: TObject);
begin
  FrmNewWil := nil;
end;

procedure TFrmNewWil.bsSkinButton1Click(Sender: TObject);
begin
  if bsSkinSelectDirectoryDialog1.Execute then  EditPicpath.Text:= bsSkinSelectDirectoryDialog1.Directory;
end;

procedure TFrmNewWil.bsSkinButton2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then EditFileName.Text:=SaveDialog1.FileName;
end;

procedure TFrmNewWil.BtnOutClick(Sender: TObject);
begin
  close;
end;

procedure TFrmNewWil.btninputClick(Sender: TObject);
var
  i:Integer;

  Temp:TFileStream;
  idxFile,path:String;
  count:integer;
  xy,t:string;
  x,y:smallint;
  xyList:TStringList;
  NewWil:TWIl;
  FileList:TFileListBox;
  Bmp:TBitMap;
  Board:Array[0..1023] of byte;
begin
  Try
     if EditPicPath.Text='' then begin
       FrmMain.bsSkinMessage1.MessageDlg('请输入图片所在路径!',mtInformation,[mbOK],0);
       Exit;
     end;
     if EditFileName.Text='' then begin
       FrmMain.bsSkinMessage1.MessageDlg('请输入新建数据文件名!',mtInformation,[mbOK],0);
       Exit;
     end;
     Application.ProcessMessages;
     Path:=EditPicPath.Text;
     if Path[length(Path)]<>'\' then Path:=Path+'\';
     FileList:=TFileListBox.Create(self);
     FileList.Parent:= FrmNewWil;
     FileList.Directory:=EditPicPath.Text;
     FileList.Mask:='*.bmp';
     FileList.Visible:=False;
     if FileExists(EditFileName.Text) then DeleteFile(EditFileName.Text);
     FrmMain.Extractrec('exefile','wil',EditFileName.Text);
     idxfile := ExtractFilePath(EditFileName.Text) + ExtractFileNameOnly(EditFileName.Text) + '.WIX';
     if FileExists(idxfile) then DeleteFile(idxfile);
     FrmMain.Extractrec('exefile','wix',idxfile);
     if RbBoardBmp.Checked then begin
       Temp:=TFileStream.Create(FileList.Items[0],fmOpenReadWrite);
       Temp.Seek(54,0);
       Temp.Read(Board,1024);
       Temp.Free;
       Temp:=TFileStream.Create(EditFileName.Text,fmOpenReadWrite);
       Temp.Seek(56,0);
       Temp.Write(Board,1024);
       Temp.Free;
     end;

     NewWil:=TWIl.Create(self);
     NewWIl.FileName:=EditFileName.Text;
     NewWIl.Initialize;
     Bmp:=TBitMap.Create;
     ProgressBar1.Max:=FileList.items.count;
     ProgressBar1.Position:=0;
     ProgressBar1.Visible:=True;
     xyList:=TStringList.Create;
     try
       Wil.Stream.Seek(0,2);
       for I:=0 to FileList.Items.Count-1 do begin
          Application.ProcessMessages;
          ProgressBar1.Position:=i;
          x:=0;
          y:=0;
          Bmp.LoadFromFile(FileList.Items[i]);

          if suiRadioButton1.Checked then begin
            t:=FileList.Items[i];
            t:=ExtractFilepath(t)+'Placements\'+ExtractFileName(FileList.Items[i]);
            t:=ChangeFileExt(t,'.txt');
            if FileExists(t) then begin
             xyList.LoadFromFile(t);
             xy:=XyList.Strings[0];
             val(xy,x,count);
             xy:=XyList.Strings[1];
             val(xy,y,count);
            end;
          end else begin
            try
              xy:=Editxy.Text;
              Xy:=Copy(xy,1,Pos(',',xy)-1);
              val(xy,x,count);
              xy:=Editxy.Text;
              Xy:=Copy(xy,Pos(',',xy)+1,Length(xy)-Pos(',',xy));
              val(xy,y,count);
            except
              x:=0;
              y:=0;
            end;
          end;
          NewWil.AddBitmap(Bmp,x,y);
       end;
     finally
       xyList.Free;
     end;
  except

  end;
  ProgressBar1.Visible:=False;
  Bmp.Free;
  FrmMain.bsSkinMessage1.MessageDlg('建立新文件成功!',mtInformation,[mbOK],0);
  CLose;
end;

end.
