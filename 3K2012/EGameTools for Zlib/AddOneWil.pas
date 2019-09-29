unit AddOneWil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinData, BusinessSkinForm, ExtCtrls, bsSkinCtrls, StdCtrls,
  Mask, bsSkinBoxCtrls, bsSkinShellCtrls, DIB;

type
  TFrmAddOneWil = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinStdLabel6: TbsSkinStdLabel;
    EditPic: TbsSkinEdit;
    bsSkinButton1: TbsSkinButton;
    bsSkinGroupBox2: TbsSkinGroupBox;
    Rabtnadd: TbsSkinCheckRadioBox;
    RabtnInsert: TbsSkinCheckRadioBox;
    Image1: TImage;
    bsSkinGroupBox1: TbsSkinGroupBox;
    Label3: TbsSkinStdLabel;
    Label2: TbsSkinStdLabel;
    editx: TbsSkinEdit;
    EDITy: TbsSkinEdit;
    btninput: TbsSkinButton;
    BtnOut: TbsSkinButton;
    OpenPictureDialog1: TbsSkinOpenPictureDialog;
    procedure bsSkinButton1Click(Sender: TObject);
    procedure btninputClick(Sender: TObject);
    Function InSert(bitmap:Tbitmap;X,y:Smallint;oneIndex:Integer):Boolean;
    procedure BtnOutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAddOneWil: TFrmAddOneWil;

implementation

uses main;

{$R *.dfm}
function ExtractFileNameOnly(const fname: string): string;
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

FunCtion TFrmAddOneWil.InSert(bitmap:Tbitmap;X,y:Smallint;oneIndex:Integer):Boolean;
var
  i:Integer;
  Dib:TDib;
  Temp:TFileStream;
  Temp1:TMemoryStream;
  idxFile:String;
  v:smallint;
  offset{,pos1},FImageCount:integer;
  DBits:PByte;
  //xyList:TStringList;
  index:Array of Integer;
  Beginindex,endindex:integer;
Begin
  Result:=True;
  Try
     FImageCount:=Wil.ImageCount;
     FImageCount:=FImageCount+1;
     Dib:=TDib.Create;
     Dib.BitCount:=8;
     Dib.ColorTable:=Wil.MainPalette;
     Dib.UpdatePalette;

     idxfile := ExtractFilePath(WIl.FileName) + ExtractFileNameOnly(WIl.FileName) + '.WIX';
     //xyList:=TStringList.Create;
     Temp:= TFileStream.Create (idxfile, fmOpenReadWrite or fmShareDenyNone);
     Temp.Seek(0,2);
     SetLength(Index,FImageCount);
     //保留原索引位置
     Beginindex:=oneindex;
     EndIndex:=oneindex;
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
     for I:=BeginIndex to EndIndex do begin
        Application.ProcessMessages;
        //OffSet:=Wil.IndexList[i];
         try
          Dib.Width:=bitmap.Width;
          Dib.Height:=bitmap.Height;
          if Dib.Width<1 then Dib.Width:=1;
          if Dib.Height<1 then Dib.Height:=1;
          Dib.Canvas.Draw(0,0,bitmap);
         except  //图片不存在则加空图片
          Dib.Width:=1;
          Dib.Height:=1;
         end;
        //写入图片的宽度
        Index[i]:=Wil.Stream.Position;
        v:=Dib.Width;
        Wil.Stream.Write(v,2);
        //写入图片的高度
        v:=Dib.Height;
        Wil.Stream.Write(v,2);
        //写入图片的坐标
        Wil.Stream.Write(x,2);
        Wil.Stream.Write(y,2);
        if WIl.OffSet>0 then begin
          Wil.Stream.Write(x,2);
          Wil.Stream.Write(y,2);
        end;
        DBits:=DIb.PBits;
        Wil.Stream.Write(DBits^,dib.Size);//lsDib.Height*lsDib.Width);
     end;
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
     dib.Free;
  except
    Result:=False;
  end;
End;

procedure TFrmAddOneWil.bsSkinButton1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then EditPic.Text:=OpenPictureDialog1.FileName;
  Application.ProcessMessages;
end;

procedure TFrmAddOneWil.btninputClick(Sender: TObject);
var
  path,xy:String;
  b:TBItMap;
  x,y:smallint;
  //xyList:TStringList;
  count:integer;
begin
  if EditPic.Text='' then begin
     FrmMain.bsSkinMessage1.MessageDlg('请选择要添加图片文件!',mtInformation,[mbOK],0);
     Exit;
  end;
  path:=ExtractFilePath(Editpic.Text);
  Image1.Picture.LoadFromFile(EditPic.Text);
  b:=Image1.Picture.Bitmap;
  if Path[Length(Path)]<>'\' then path:=path+'\';
  //xyList:=TStringList.Create;
  //x:=0;
  //y:=0;
  xy:=Editx.Text;
  val(xy,x,count);
  xy:=Edity.Text;
  val(xy,y,count);
  if Rabtnadd.Checked then
    Wil.AddBitmap(b,x,y)
  else Insert(b,x,y,Main.BmpIndex);
  wil.Finalize;
  wil.Initialize;
  FrmMain.bsSkinMessage1.MessageDlg('加入图片成功！',mtInformation,[mbOK],0);
  FrmAddOneWil.Close;
end;

procedure TFrmAddOneWil.BtnOutClick(Sender: TObject);
begin
  close;
end;

procedure TFrmAddOneWil.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmAddOneWil.FormDestroy(Sender: TObject);
begin
  FrmAddOneWil:= nil;
end;

end.
