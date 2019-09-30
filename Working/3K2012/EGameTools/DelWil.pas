unit DelWil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinData, BusinessSkinForm, bsSkinCtrls, StdCtrls, Mask,
  bsSkinBoxCtrls, ComCtrls;

type
  TFormDel = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinGroupBox1: TbsSkinGroupBox;
    Label3: TbsSkinStdLabel;
    Label2: TbsSkinStdLabel;
    editBegin: TbsSkinEdit;
    EditEnd: TbsSkinEdit;
    bsSkinGroupBox2: TbsSkinGroupBox;
    RabtnDel: TbsSkinCheckRadioBox;
    RabtnNull: TbsSkinCheckRadioBox;
    ProgressBar1: TProgressBar;
    btninput: TbsSkinButton;
    BtnOut: TbsSkinButton;
    procedure BtnOutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    FunCtion Del(BeginIndex,EndIndex:Integer):Boolean;
    FunCtion Del1(BeginIndex,EndIndex:Integer):Boolean;
    procedure btninputClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDel: TFormDel;

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

Function TFormdel.Del1(BeginIndex,EndIndex:Integer):Boolean;
var
  i:Integer;
  B:TBitMap;
Begin
  b:=TbitMap.Create;
  Try
     b.PixelFormat:=pf8bit;
     B.Width:=1;
     B.Height:=1;
     B.Canvas.Pixels[0,0]:=0;
     ProgressBar1.Max:=EndIndex-BeginIndex+1;
     ProgressBar1.Position:=0;
     ProgressBar1.Visible:=True;
     for i:=BeginIndex to Endindex do begin
        Wil.ReplaceBitMap(i,b);
        ProgressBar1.StepIt;
        Application.ProcessMessages;
     end;
     Wil.Finalize;
     Wil.Initialize;
     ProgressBar1.Visible:=false;
  except

  end;
  b.Free;
  Result:=True;
end;

Function  TFormdel.Del(BeginIndex,EndIndex:Integer):Boolean;
var
  i:Integer;
  Temp1,temp:TMemoryStream;
  idxFile:String;
  FImageCount:integer;
  index:Array of Integer;
  Size:Integer;
Begin
  Result:=True;
  Try
    FImageCount:=Wil.ImageCount;
    FImageCount:=FImageCount-EndIndex+BeginIndex-1;
    idxfile := ExtractFilePath(WIl.FileName) + ExtractFileNameOnly(WIl.FileName) + '.WIX';
    SetLength(Index,FImageCount-EndIndex-BeginIndex+1);
    Size:=Wil.indexList[EndIndex+1]-Wil.indexList[BeginIndex];
    Temp1:=TMemoryStream.Create;
    Temp1.SetSize(Wil.Stream.Size-Size);
    Temp1.Seek(0,0);
    Wil.Stream.Seek(0,0);
    Temp1.CopyFrom(Wil.Stream,Wil.indexList[BeginIndex]);
    Wil.Stream.Seek(Wil.indexList[EndIndex+1],0);
    Temp1.CopyFrom(wil.Stream,Wil.Stream.Size-Wil.Stream.Position);
    for I:=0 to BeginIndex-1 do Index[i]:=Wil.indexList[i];
    if BeginIndex=0 then begin
      Index[0]:=1080+wil.OffSet;
      Inc(BeginINdex);
    end;
    for i:=BeginIndex to FImageCount-1 do
      Index[i]:=Index[i-1]+Wil.indexList[EndIndex+i-BeginIndex+2]-Wil.indexList[EndIndex+i-BeginIndex+1];
    Size:=48+Wil.OffSet;
    Wil.Finalize;
    Temp1.Seek(44,0);
    Temp1.Write(FImageCount,4);
    Temp1.Seek(0,0);
    Temp1.SaveToFile(Wil.FileName);
    Temp1.Clear;
    Temp:=TmemoryStream.Create;
    Temp.LoadFromFile(IdxFile);
    Temp1.SetSize(Size+FimageCount*4);
    Temp1.Seek(0,0);
    Temp.Seek(0,0);
    Temp1.CopyFrom(Temp,Size);
    Temp1.Write(Index[0],FimageCount*4);
    Temp1.Seek(44,0);
    Temp1.Write(FImageCount,4);
    Temp1.Seek(0,0);
    Temp1.SaveToFile(idxfile);
    Temp1.Free;
    Wil.Finalize;
    Wil.Initialize;
    Temp.Free;
    FrmMain.DrawGrid1.RowCount:=(Wil.ImageCount div 6)+1;
  except
    Result:=False;
  end;
end;

procedure TFormDel.BtnOutClick(Sender: TObject);
begin
  close;
end;

procedure TFormDel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormDel.FormDestroy(Sender: TObject);
begin
  FormDel:= nil;
end;

procedure TFormDel.btninputClick(Sender: TObject);
var
  BeginIndex,EndIndex,code:Integer;
  s:Boolean;
begin
  ProgressBar1.Position:=0;
  val(EditBegin.Text,BeginIndex,code);
  if (code > 0) or (BeginIndex > Wil.ImageCount-1) or (BeginIndex < 0) then Begin
    FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号',mtInformation,[mbOK],0);
    EditBegin.SetFocus;
    exit;
  End;
  val(EditEnd.Text,EndIndex,code);
  if (code > 0)or (EndIndex > Wil.ImageCount-1) or (EndIndex < 0) or (EndIndex < BeginIndex) then Begin
    FrmMain.bsSkinMessage1.MessageDlg('请输入正确的编号',mtInformation,[mbOK],0);
    EditEnd.SetFocus;
    exit;
  End;
  if RabtnDel.Checked then
     s:=Del(BeginIndex,EndIndex)
  else s:=Del1(BeginIndex,EndIndex);
  if s then
    FrmMain.bsSkinMessage1.MessageDlg('删除成功',mtInformation,[mbOK],0)
  else FrmMain.bsSkinMessage1.MessageDlg('删除失败',mtInformation,[mbOK],0);
  FrmMain.DrawGrid1.Repaint;
  Formdel.Close;
end;

end.
