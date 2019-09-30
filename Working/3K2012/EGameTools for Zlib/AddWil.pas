unit AddWil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinData, BusinessSkinForm, bsSkinCtrls, StdCtrls, Mask,
  bsSkinBoxCtrls, ComCtrls, FileCtrl, DIB, bsSkinShellCtrls;

type
  TFrmAddWil = class(TForm)
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsSkinGroupBox2: TbsSkinGroupBox;
    RabtnAll: TbsSkinCheckRadioBox;
    RabtnPic: TbsSkinCheckRadioBox;
    Rabtnxy: TbsSkinCheckRadioBox;
    bsSkinStdLabel6: TbsSkinStdLabel;
    EditPicPath: TbsSkinEdit;
    bsSkinButton1: TbsSkinButton;
    bsSkinGroupBox1: TbsSkinGroupBox;
    Label3: TbsSkinStdLabel;
    Label2: TbsSkinStdLabel;
    editBegin: TbsSkinEdit;
    EditEnd: TbsSkinEdit;
    bsSkinGroupBox3: TbsSkinGroupBox;
    RabtnAdd: TbsSkinCheckRadioBox;
    RabtnInsert: TbsSkinCheckRadioBox;
    RabtnReplace: TbsSkinCheckRadioBox;
    GroupBoxxy: TbsSkinGroupBox;
    RabtnFile: TbsSkinCheckRadioBox;
    suiRadioButton2: TbsSkinCheckRadioBox;
    editxy: TbsSkinEdit;
    ProgressBar1: TProgressBar;
    btninput: TbsSkinButton;
    BtnOut: TbsSkinButton;
    bsSkinSelectDirectoryDialog1: TbsSkinSelectDirectoryDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure bsSkinButton1Click(Sender: TObject);
    function AddAll:Boolean;
    function AddPic:Boolean;
    function AddXy:Boolean;
    Function Add(FileList:Tstrings;Path:String;XyMode:Byte):Boolean;
    Function InSert(FileList:Tstrings;XyMode:Byte;BeginIndex:Integer):Boolean;
    Function Replace(FileList:Tstrings;XyMode:Byte;BeginIndex,EndIndex:Integer):Boolean;
    procedure BtnOutClick(Sender: TObject);
    procedure RabtnInsertClick(Sender: TObject);
    procedure RabtnPicClick(Sender: TObject);
    procedure btninputClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddWil: TFrmAddWil;
  PicPath,FileName:String;
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

function TFrmAddWil.AddAll:boolean;
var
  BeginIndex,EndIndex,code,mode:Integer;
  FileList:TFileListBox;
  path:String;
begin
  Result:=False;
  if EditPicPath.Text='' then begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入图片所在路径!',mtInformation,[mbOK],0);
     Exit;
  end;
  Application.ProcessMessages;
  Path:=EditPicPath.Text;
  if Path[length(Path)]<>'\' then Path:=Path+'\';
  FileList:=TFileListBox.Create(self);
  FileList.Parent:= FrmAddWil;
  FileList.Directory:=EditPicPath.Text;
  FileList.Mask:='*.bmp';
  FileList.Visible:=False;
  if RabtnFile.Checked then
     Mode:=0
  else Mode:=1;
  if RaBtnAdd.Checked then Add(FileList.Items,EditPicPath.Text,Mode)
  else
    if RaBtnInsert.Checked then begin
      val(EditBegin.Text,BeginIndex,code);
      if (code>0) or (BeginIndex>Wil.ImageCount-1) or (BeginIndex<0) then Begin
        FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号!',mtInformation,[mbOK],0);
        EditBegin.SetFocus;
        exit;
      End;
      val(EditEnd.Text,EndIndex,code);
      if (code>0)or (EndIndex>Wil.ImageCount-1) or (EndIndex<0) or (EndIndex<BeginIndex) then Begin
        FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号!',mtInformation,[mbOK],0);
        EditEnd.SetFocus;
        exit;
      End;
      Insert(FileList.Items,Mode,BeginIndex);
    end else
      if RaBtnReplace.Checked then Begin
        val(EditBegin.Text,BeginIndex,code);
        if (code>0) or (BeginINdex>Wil.ImageCount-1) or (BeginIndex<0) then Begin
          FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号!',mtInformation,[mbOK],0);
          EditBegin.SetFocus;
          exit;
        End;
        val(EditEnd.Text,EndIndex,code);
        if (code>0)or (EndIndex>Wil.ImageCount-1) or (EndIndex<0) or (EndIndex<BeginIndex) then Begin
          FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号!',mtInformation,[mbOK],0);
          EditEnd.SetFocus;
          exit;
        End;
        if (EndIndex-BeginIndex+1)>FileList.Items.Count then Begin
          FrmMain.bsSkinMessage1.MessageDlg('图片数目不够！',mtInformation,[mbOK],0);
          EditEnd.SetFocus;
          exit;
        End;
        Replace(FileList.Items,Mode,BeginIndex,EndIndex);
      End;
  Result:=True;
end;

function TFrmAddWil.AddPic:boolean;
var
 BeginIndex,EndIndex,code,i:Integer;
 BitMap:TBitmap;
 Path:String;
 FileList:TFileListBox;
Begin
  Result:=True;
  if EditPicPath.Text='' then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入图片所在路径!',mtInformation,[mbOK],0);
     Exit;
  End;
  Path:=EditPicPath.Text;
  if Path[length(Path)]<>'\' then Path:=Path+'\';
  FileList:=TFileListBox.Create(self);
  FileList.Parent:=FrmAddWil;
  FileList.Directory:=EditPicPath.Text;
  FileList.Mask:='*.bmp';
  FileList.Visible:=False;
  val(EditBegin.Text,BeginIndex,code);
  if (code>0) or (BeginIndex>Wil.ImageCount-1) or (BeginIndex<0) then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号',mtInformation,[mbOK],0);
     EditBegin.SetFocus;
     exit;
   End;
   val(EditEnd.Text,EndIndex,code);
   if (code>0)or (EndIndex>Wil.ImageCount-1) or (EndIndex<0) or (EndIndex<BeginIndex) then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号',mtInformation,[mbOK],0);
     EditEnd.SetFocus;
     exit;
   End;
    BitMap:=TBitmap.Create;
   ProgressBar1.Max:=EndIndex-BeginIndex+1;
   ProgressBar1.Position:=0;
   ProgressBar1.Visible:=True;
   if (EndIndex-BeginINdex+1)>FileList.Items.Count then Begin
     FrmMain.bsSkinMessage1.MessageDlg('图片数目不够！',mtInformation,[mbOK],0);
     EditEnd.SetFocus;
     exit;
   End;
   for i:=BeginIndex to EndIndex do Begin
     try
      BitMap.LoadFromFile(Path+format('%.6d.bmp',[i]));
     except
       BitMap.Width:=1;
       BitMap.Height:=1;
       BitMap.Canvas.Pixels[0,0]:=0;
     End;
     ProgressBar1.StepIt;
     Wil.ReplaceBitMap(i,Bitmap);
   End;
   ProgressBar1.Visible:=False;
   Result:=True;
end;

function TFrmAddWil.AddXy:boolean;
var
 BeginIndex,EndIndex,code,i,count:Integer;
 Path:String;
   xy,t:string;
  x,y:smallint;
  xyList:TStringList;
Begin
  Result:=false;
  if (EditPicPath.Text='') and RabtnFile.Checked then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入图片所在路径!',mtInformation,[mbOK],0);
     Exit;
  End;
  if EditPicPath.Text<>'' then Begin
    Path:=EditPicPath.Text;
    if Path[length(Path)]<>'\' then Path:=Path+'\';
  end;
  xyList:=TStringList.Create;
  val(EditBegin.Text,BeginIndex,code);
  if (code>0) or (BeginIndex>Wil.ImageCount-1) or (BeginIndex<0) then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入正确的格式',mtInformation,[mbOK],0);
     EditBegin.SetFocus;
     exit;
   End;
   val(EditEnd.Text,EndIndex,code);
   if (code>0)or (EndIndex>Wil.ImageCount-1) or (EndIndex<0) or (EndIndex<BeginIndex) then Begin
     FrmMain.bsSkinMessage1.MessageDlg('请输入正确的格式',mtInformation,[mbOK],0);
     EditEnd.SetFocus;
     exit;
   End;
   ProgressBar1.Max:=EndIndex-BeginIndex+1;
   ProgressBar1.Position:=0;
   ProgressBar1.Visible:=True;

   for i:=BeginIndex to EndIndex do Begin
        x:=0;
        y:=0;
        if RabtnFile.Checked then Begin
          t:=path+format('%.6d.txt',[i]);
          if FileExists(t) then Begin
           xyList.LoadFromFile(t);
           xy:=XyList.Strings[0];
           val(xy,x,count);
           xy:=XyList.Strings[1];
           val(xy,y,count);
          end;
        end else Begin
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
        End;

     ProgressBar1.StepIt;
     wil.Changex(i,x);
     wil.Changey(i,y);
   End;
   ProgressBar1.Visible:=False;
   if xyList <> nil then xyList.Free;
   Result:=True;
end;

//批量添加图片
FunCtion TFrmAddWil.Add(FileList:Tstrings;Path:String;XyMode:Byte):Boolean;
var
  i:Integer;
  tmpDib,Dib:TDib;
  Temp:TFileStream;
  idxFile:String;
  v:smallint;
  offset,count,FImageCount:integer;
  xy,t:string;
  x,y:smallint;
  DBits:PByte;
  xyList:TStringList;
Begin
  Result:=True;
  Try
     FImageCount:=Wil.ImageCount;
     FImageCount:=FImageCount+FileList.Count;
     TmpDib:=TDib.Create;
     Dib:=TDib.Create;
     Dib.BitCount:=8;
     Dib.ColorTable:=Wil.MainPalette;
     Dib.UpdatePalette;
     ProgressBar1.Max:=FileList.Count;
     ProgressBar1.Position:=0;
     ProgressBar1.Visible:=True;
     idxfile := ExtractFilePath(WIl.FileName) + ExtractFileNameOnly(WIl.FileName) + '.WIX';
     xyList:=TStringList.Create;
     Temp:= TFileStream.Create (idxfile, fmOpenReadWrite or fmShareDenyNone);
     Temp.Seek(0,2);
     Wil.Stream.Seek(0,2);
     For I:=0 to FileList.Count-1 do Begin
        Application.ProcessMessages;
        ProgressBar1.Position:=i;
        tmpDib.Clear;
        try
          tmpDib.LoadFromFile(FileList.Strings[i]);
        except
          TmpDIb.Width:=1;
          TmpDIb.Height:=1;
        end;
        if TmpDib.Width<1 then TmpDIb.Width:=1;
        if TmpDib.Height<1 then TmpDIb.Height:=1;
        Dib.Width:=(((TmpDIb.Width*8)+31) shr 5) * 4;
        Dib.Height:=TmpDib.Height;
        dib.Canvas.Brush.Color:=clblack;
        Dib.Canvas.FillRect(Rect(0,0,dib.Width,dib.Height));
        Dib.Canvas.Draw(0,0,TmpDib);
        //写入图片的宽度
        offset:=Wil.Stream.Size;
        v:=Dib.Width;
        Wil.Stream.Write(v,2);
        //写入图片的高度
        v:=Dib.Height;
        Wil.Stream.Write(v,2);
        //写入图片的坐标
        x:=0;
        y:=0;
        if XyMode=0 then Begin
          t:=FileList.Strings[i];
          t:=ExtractFilepath(t)+'Placements\'+ExtractFileName(FileList.Strings[i]);
          t:=ChangeFileExt(t,'.txt');
          if FileExists(t) then Begin
           xyList.LoadFromFile(t);
           xy:=XyList.Strings[0];
           val(xy,x,count);
           xy:=XyList.Strings[1];
           val(xy,y,count);
          end;
        end else Begin
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
        End;
        Wil.Stream.Write(x,2);
        Wil.Stream.Write(y,2);
        if WIl.OffSet>0 then Begin
          Wil.Stream.Write(x,2);
          Wil.Stream.Write(y,2);
        End;
        DBits:=DIb.PBits;
        Wil.Stream.Write(DBits^,dib.Size);//lsDib.Height*lsDib.Width);

        Temp.Write(Offset,4);
     End;
     Wil.Stream.Seek(44,0);
     Wil.Stream.Write(FImageCount,4);
     Temp.Seek(44,0);
     Temp.Write(FImageCount,4);
     Temp.Free;
     xyList.Free;
     Wil.Finalize;
     Wil.Initialize;
     FrmMain.DrawGrid1.RowCount:=(Wil.ImageCount div 6)+1;
  Except
    Temp.Free;
    xyList.Free;
    Result:=False;
  End;
End;

FunCtion TFrmAddWil.InSert(FileList:Tstrings;XyMode:Byte;BeginIndex:Integer):Boolean;
var
  i,endindex:Integer;
  tmpDib,Dib:TDib;
  Temp:TFileStream;
  Temp1:TMemoryStream;
  idxFile:String;
  v:smallint;
  offset,{pos1,}count,FImageCount:integer;
  xy,t:string;
  x,y:smallint;
  DBits:PByte;
  xyList:TStringList;
  index:Array of Integer;
Begin
  Result:=True;
  Try
     EndIndex:=BeginIndex+FileList.Count-1;
     FImageCount:=Wil.ImageCount;
     FImageCount:=FImageCount+EndIndex-BeginIndex+1;
     TmpDib:=TDib.Create;
     Dib:=TDib.Create;
     Dib.BitCount:=8;
     Dib.ColorTable:=Wil.MainPalette;
     Dib.UpdatePalette;
     ProgressBar1.Max:=EndIndex-BeginIndex+1;
     ProgressBar1.Position:=0;
     ProgressBar1.Visible:=True;
     idxfile := ExtractFilePath(WIl.FileName) + ExtractFileNameOnly(WIl.FileName) + '.WIX';
     xyList:=TStringList.Create;
     Temp:= TFileStream.Create (idxfile, fmOpenReadWrite or fmShareDenyNone);
     Temp.Seek(0,2);
     SetLength(Index,FImageCount);
     //保留原索引位置
     for i:=0 to Beginindex-1  do Index[i]:=Wil.IndexList[i];
     for i:=Endindex+1 to Wil.ImageCount-1 do Index[i]:=Wil.IndexList[i];
      //保留原文件内容
     Temp1:=TMemoryStream.Create;
     Temp1.SetSize(Wil.Stream.Size-Wil.IndexList[BeginIndex]);
     Temp1.Seek(0,0);
     WIl.Stream.Seek(Wil.IndexList[BeginIndex],0);
     Application.ProcessMessages;
     Temp1.CopyFrom(WIl.Stream,Wil.Stream.Size-Wil.Stream.Position);
     Application.ProcessMessages;
     WIl.Stream.Seek(Wil.IndexList[BeginIndex],0);
     For I:=BeginIndex to EndIndex do Begin
        Application.ProcessMessages;
        ProgressBar1.StepIt;
        tmpDib.Clear;
        //OffSet:=Wil.IndexList[i];
        Try
         try
          tmpDib.LoadFromFile(FileList.Strings[i-BeginIndex]);
         except
           TmpDIb.Width:=1;
          TmpDIb.Height:=1;
         end;
         if TmpDib.Width<1 then TmpDIb.Width:=1;
         if TmpDib.Height<1 then TmpDIb.Height:=1;

          Dib.Width:=(((TmpDIb.Width*8)+31) shr 5) * 4;
          Dib.Height:=TmpDib.Height;
        dib.Canvas.Brush.Color:=clblack;
        Dib.Canvas.FillRect(Rect(0,0,dib.Width,dib.Height));
        Dib.Canvas.Draw(0,0,TmpDib);
        except  //图片不存在则加空图片
          Dib.Width:=1;
          Dib.Height:=1;
        End;

        //写入图片的宽度
        Index[i]:=Wil.Stream.Position;
        v:=Dib.Width;
        Wil.Stream.Write(v,2);
        //写入图片的高度
        v:=Dib.Height;
        Wil.Stream.Write(v,2);
        //写入图片的坐标
        x:=0;
        y:=0;
        if XyMode=0 then Begin
           t:=FileList.Strings[i-beginindex];
           t:=ExtractFilepath(t)+'Placements\'+ExtractFileName(FileList.Strings[i-BeginIndex]);
           t:=ChangeFileExt(t,'.txt');
           if FileExists(t) then Begin
             xyList.LoadFromFile(t);
             xy:=XyList.Strings[0];
             val(xy,x,count);
             xy:=XyList.Strings[1];
             val(xy,y,count);
           end;
        end else Begin
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
        End;
        Wil.Stream.Write(x,2);
        Wil.Stream.Write(y,2);
        if WIl.OffSet>0 then Begin
          Wil.Stream.Write(x,2);
          Wil.Stream.Write(y,2);
        End;
        DBits:=DIb.PBits;
        Wil.Stream.Write(DBits^,dib.Size);//lsDib.Height*lsDib.Width);
     End;
     Temp1.Seek(0,0);
     offset:=Wil.Stream.Position;
     Wil.Stream.CopyFrom(Temp1,Temp1.Size);
     Wil.Stream.Seek(44,0);
     Wil.Stream.Write(FImageCount,4);
     Temp.Seek(44,0);
     Temp.Write(FImageCount,4);
     //pos1:=index[Endindex+1];
     index[EndIndex+1]:=Offset;
     for i:=Endindex+2 to Wil.ImageCount+EndIndex-BeginIndex do
       Index[i]:=Wil.IndexList[i-EndIndex+BeginIndex-1]-Wil.IndexList[i-EndIndex+BeginIndex-2]+Index[i-1];
     Temp.Seek(48+Wil.OffSet,0);
     Temp.Write(Index[0],FImageCount*4);
     Temp.Free;
     Temp1.Free;
     xyList.Free;
     Wil.Finalize;
     Wil.Initialize;
     tmpDib.Free;
     FrmMain.DrawGrid1.RowCount:=(Wil.ImageCount div 6)+1;
  Except
    Temp.Free;
    xyList.Free;
    Result:=False;
  End;
End;

FunCtion  TFrmAddWil.Replace(FileList:Tstrings;XyMode:Byte;BeginIndex,EndIndex:Integer):Boolean;
var
  i:Integer;
  tmpDib,Dib:TDib;
  Temp:TFileStream;
  Temp1:TMemoryStream;
  idxFile:String;
  v:smallint;
  offset,{pos1,}count,FImageCount:integer;
  xy,t:string;
  x,y:smallint;
  DBits:PByte;
  xyList:TStringList;
  index:Array of Integer;
Begin
  Result:=True;
  Try
     FImageCount:=Wil.ImageCount;
     TmpDib:=TDib.Create;
     Dib:=TDib.Create;
     Dib.BitCount:=8;
     Dib.ColorTable:=Wil.MainPalette;
     Dib.UpdatePalette;
     ProgressBar1.Max:=EndIndex-BeginIndex+1;
     ProgressBar1.Position:=0;
     ProgressBar1.Visible:=True;
     idxfile := ExtractFilePath(WIl.FileName) + ExtractFileNameOnly(WIl.FileName) + '.WIX';
     xyList:=TStringList.Create;
     Temp:= TFileStream.Create (idxfile, fmOpenReadWrite or fmShareDenyNone);
     Temp.Seek(0,2);
     SetLength(Index,FImageCount);
     //保留原索引位置
     for i:=0 to Beginindex-1  do Index[i]:=Wil.IndexList[i];
     for i:=Endindex+1 to Wil.ImageCount-1 do Index[i]:=Wil.IndexList[i];
      //保留原文件内容
     Temp1:=TMemoryStream.Create;
     Application.ProcessMessages;
     Temp1.SetSize(Wil.Stream.Size-Wil.IndexList[EndIndex+1]);
     Temp1.Seek(0,0);
     WIl.Stream.Seek(Wil.IndexList[EndIndex+1],0);
     Temp1.CopyFrom(WIl.Stream,Wil.Stream.Size-Wil.Stream.Position);
     Application.ProcessMessages;
     WIl.Stream.Seek(Wil.IndexList[BeginIndex],0);
     For I:=BeginIndex to EndIndex do Begin
        Application.ProcessMessages;
        ProgressBar1.StepIt;
        tmpDib.Clear;
        //OffSet:=Wil.IndexList[i];
        Try
          tmpDib.LoadFromFile(FileList.Strings[i-beginindex]);
          if TmpDib.Width<1 then TmpDIb.Width:=1;
          if TmpDib.Height<1 then TmpDIb.Height:=1;

          Dib.Width:=(((TmpDIb.Width*8)+31) shr 5) * 4;
          Dib.Height:=TmpDib.Height;
        dib.Canvas.Brush.Color:=clblack;
        Dib.Canvas.FillRect(Rect(0,0,dib.Width,dib.Height));
        Dib.Canvas.Draw(0,0,TmpDib);

        except  //图片不存在则加空图片
          Dib.Width:=1;
          Dib.Height:=1;
        End;
        //写入图片的宽度
        Index[i]:=Wil.Stream.Position;
        v:=Dib.Width;
        Wil.Stream.Write(v,2);
        //写入图片的高度
        v:=Dib.Height;
        Wil.Stream.Write(v,2);
        //写入图片的坐标
        x:=0;
        y:=0;
        if XyMode=0 then Begin
           t:=FileList.Strings[i-beginindex];
           t:=ExtractFilepath(t)+'Placements\'+ExtractFileName(FileList.Strings[i-BeginIndex]);
           t:=ChangeFileExt(t,'.txt');
           if FileExists(t) then Begin
             xyList.LoadFromFile(t);
             xy:=XyList.Strings[0];
             val(xy,x,count);
             xy:=XyList.Strings[1];
             val(xy,y,count);
           end;
        end else Begin
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
        End;
        Wil.Stream.Write(x,2);
        Wil.Stream.Write(y,2);
        if WIl.OffSet>0 then Begin
          Wil.Stream.Write(x,2);
          Wil.Stream.Write(y,2);
        End;
        DBits:=DIb.PBits;
        Wil.Stream.Write(DBits^,dib.Size);//lsDib.Height*lsDib.Width);
     End;
     Temp1.Seek(0,0);
     offset:=Wil.Stream.Position;
     Wil.Stream.CopyFrom(Temp1,Temp1.Size);
     //pos1:=index[Endindex+1];
     index[EndIndex+1]:=Offset;
     for i:=Endindex+2 to Wil.ImageCount-1 do Index[i]:=Wil.IndexList[i]-Wil.IndexList[i-1]+Index[i-1];
     Temp.Seek(48+Wil.OffSet,0);
     Temp.Write(Index[0],Wil.ImageCount*4);
     Temp.Free;
     Temp1.Free;
     xyList.Free;
     tmpDib.Free;
     Wil.Finalize;
     Wil.Initialize;
     FrmMain.DrawGrid1.RowCount:=(Wil.ImageCount div 6)+1;
  Except
    Temp.Free;
    xyList.Free;
    Result:=False;
  End;
End;

procedure TFrmAddWil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmAddWil.FormDestroy(Sender: TObject);
begin
  FrmAddWil:= nil;
end;

procedure TFrmAddWil.bsSkinButton1Click(Sender: TObject);
begin
 if bsSkinSelectDirectoryDialog1.Execute then  EditPicpath.Text:= bsSkinSelectDirectoryDialog1.Directory;
end;

procedure TFrmAddWil.BtnOutClick(Sender: TObject);
begin
  close;
end;

procedure TFrmAddWil.RabtnInsertClick(Sender: TObject);
begin
  bsSkinGroupBox1.Enabled:= Not RaBtnAdd.Checked;
  EditEnd.Enabled:= RabtnReplace.Checked;
end;

procedure TFrmAddWil.RabtnPicClick(Sender: TObject);
begin
 if Rabtnall.Checked then Begin
   Rabtnadd.Enabled:=True;
   Rabtninsert.Enabled:=True;
   RabtnReplace.Enabled:=true;
   EditPicPath.Enabled:=True;
   bsSkinButton1.Enabled:=True;
   GroupBoxxy.Enabled:=True;
   bsSkinStdLabel6.Caption:='图片所在文件夹：';
 End else Begin
   bsSkinGroupBox1.Enabled:=True;
   Label3.Enabled:=True;
   Label2.Enabled:=True;
   editBegin.Enabled:=True;
   EditEnd.Enabled:=True;
   RabtnReplace.Checked:=True;
   Rabtnadd.Enabled:=False;
   Rabtninsert.Enabled:=False;
   RabtnReplace.Enabled:=true;

   if Rabtnxy.Checked then Begin
     GroupBoxxy.Enabled:=True;
     RabtnFile.Enabled:=True;
     suiRadioButton2.Enabled:=True;
     editxy.Enabled:=True;
     Label3.Enabled:=False;
     Label2.Enabled:=False;
     editBegin.Enabled:=False;
     EditEnd.Enabled:=False;
     bsSkinStdLabel6.Caption:='坐标所在文件夹：';
   End else Begin
     bsSkinStdLabel6.Caption:='图片所在文件夹：';
     GroupBoxxy.Enabled:=False;
     RabtnFile.Enabled:=False;
     suiRadioButton2.Enabled:=False;
     editxy.Enabled:=False;
     Label3.Enabled:=True;
     Label2.Enabled:=True;
     editBegin.Enabled:=True;
     EditEnd.Enabled:=True;
   End;

 End;
end;

procedure TFrmAddWil.btninputClick(Sender: TObject);
var
  s:Boolean;
begin
   if Rabtnall.Checked then
        s:=addall
   else
     if Rabtnpic.Checked then
        s:=addpic
     else s:=addxy;
  if s then
    FrmMain.bsSkinMessage1.MessageDlg('批量导入成功！',mtInformation,[mbOK],0)
  else
    FrmMain.bsSkinMessage1.MessageDlg('批量导入失败！',mtInformation,[mbOK],0);
    
  FrmAddWil.ProgressBar1.Visible:=False;
  FrmAddWil.ProgressBar1.Position:=0;
  FrmAddWil.EditPicPath.Text:='';
  FrmMain.DrawGrid1.Repaint;
  FrmAddWil.Close;
end;

end.
