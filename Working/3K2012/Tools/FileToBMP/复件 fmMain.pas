unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Clipbrd, ShellAPI, StdCtrls, Spin, ZLib, MD5;

type
  TFrmMain = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Memo1: TMemo;
    SpinEdit1: TSpinEdit;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure WMDropFiles(var Msg : TWMDropFiles); message WM_DROPFILES;
  end;

var
  FrmMain: TFrmMain;
implementation

{$R *.dfm}

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(Handle, True);
end;

//返回最大能写入的大小 By TasNat at: 2012-04-04 11:18:07
function FillBitmapHeader(var Buf : PChar; BufSize: DWord) : DWord;
var
  FileHeader: PBitmapFileHeader;
  InfoHeader: PBitmapInfoHeader;
  AWidth, AHeight : Integer;
  dwDibSize : DWord;
  Buffer: Pointer;
begin
  BufSize := (BufSize div 4);
  AHeight := Round(Sqrt(BufSize));
  AWidth := AHeight;
  dwDibSize := AWidth * AHeight * 4;
  //如果不够就加一行
  if dwDibSize < BufSize then
    Inc(AHeight);

  FileHeader := PBitmapFileHeader(Buf);
  FileHeader.bfType := $4D42;
  FileHeader.bfSize := SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader) + AWidth * AHeight * 4;
  FileHeader.bfOffBits := FileHeader.bfSize - AWidth * AHeight * 4;
  FileHeader.bfReserved1 := 0;
  FileHeader.bfReserved2 := 0;
  Inc(Buf, SizeOf(TBitmapFileHeader));
  // 位图信息头
  InfoHeader := PBitmapInfoHeader(Buf);
  InfoHeader.biSize := SizeOf(TBitmapInfoHeader);
  InfoHeader.biWidth := AWidth;
  InfoHeader.biHeight := -AHeight;
  InfoHeader.biPlanes := 1;
  InfoHeader.biBitCount := 32;
  InfoHeader.biCompression := BI_RGB; //BI_RGB;
  InfoHeader.biSizeImage := AWidth * AHeight * 4;
  InfoHeader.biXPelsPerMeter := 0;
  InfoHeader.biYPelsPerMeter := 0;
  InfoHeader.biClrUsed := 0;
  InfoHeader.biClrImportant := 0;
  Inc(Buf, SizeOf(InfoHeader^));
  Result := InfoHeader.biSizeImage;
end;

//跳转到BMP格式的数据段 数据段首4字节为实际大小 By TasNat at: 2012-04-04 11:16:34
function GotoBitmapBits(var Buf : PChar) : DWord;
var
  FileHeader: PBitmapFileHeader;
  FileInfoHeader : PBitmapInfoHeader;
begin
  FileHeader := PBitmapFileHeader(Buf);
  if FileHeader.bfType = $4D42 then begin
    FileInfoHeader := PBitmapInfoHeader(Buf + SizeOf(TBitmapFileHeader));
    Result := FileInfoHeader.biSizeImage;
    Inc(Buf, FileHeader.bfOffBits);
  end else Result := 0;
end;

procedure EnCompressStream(InStream: TMemoryStream);
var
  SM: TCompressionStream;
  DM: TMemoryStream;
begin
  if InStream.Size <= 0 then exit;
  InStream.Position := 0;
  DM := TMemoryStream.Create;
  SM := TCompressionStream.Create(clMax, DM);//其中的clMax表示压缩级别,可以更改,值是下列参数之一:clNone, clFastest, clDefault, clMax
  try
    InStream.SaveToStream(SM); //SourceStream中保存着原始的流
    SM.Free; //将原始流进行压缩，DestStream中保存着压缩后的流
    InStream.Clear;
    InStream.CopyFrom(DM, 0); //写入经过压缩的流
    InStream.Position := 0;
  finally
    DM.Free;
  end;
end;

procedure DeCompressStream(InStream: TMemoryStream; dwOldSize : DWord);
var
  MS: TDecompressionStream;
  Buffer: PChar;
begin
  if InStream.Size <= 0 then exit;
  InStream.Position := 0; //复位流指针
  //从被压缩的文件流中读出原始的尺寸
  GetMem(Buffer, dwOldSize); //根据尺寸大小为将要读入的原始流分配内存块
  MS := TDecompressionStream.Create(InStream);
  try
    MS.ReadBuffer(Buffer^, dwOldSize);
    //将被压缩的流解压缩，然后存入 Buffer内存块中
    InStream.Clear;
    InStream.WriteBuffer(Buffer^, dwOldSize); //将原始流保存至 MS流中
    InStream.Position := 0; //复位流指针
  finally
    FreeMem(Buffer);
    MS.Free;//20110714
  end;
end;

procedure BuildBMP(pSrc : PChar; dwSrcSize : DWord; dwBlockSize : DWord; sFileName : string; boCompress : Boolean; Log : TStrings);
var
  dwFileCount : DWord;
  dwOldSize   : DWord;
  pSrc2 : PChar;
  dwSrcSize2 : DWord;
  BlockMem  : PChar;
  sMD5 : string;
  procedure SaveOutBMPFile(pOutBuf : PChar; dwSize : DWord);
  var
    sOutFileName : string;
  begin
    repeat
      sOutFileName := sFileName + '.' + IntToStr(dwFileCount) + '.bmp';
      Inc(dwFileCount);
    until not FileExists(sOutFileName);
    with TFileStream.Create(sOutFileName, fmCreate) do begin
      Write(pOutBuf^, dwSize);
      Free;
    end;
  end;
begin
  dwFileCount := 1;
  if boCompress then begin
    Log.Add('压缩...');
    dwOldSize := dwSrcSize;
    CompressBuf(pSrc, dwSrcSize, Pointer(pSrc), Integer(dwSrcSize));
    Log.Strings[Log.Count -1] := '压缩完成...';
  end;
  GetMem(BlockMem, dwBlockSize);
  if BlockMem <> nil then begin
    sMD5 := Md5.RivestBuf(pSrc, dwSrcSize);
    inFile.Position := 0;
    repeat
      FileHeader := PBitmapFileHeader(BufMem);
      Buf := BufMem;
      dwDibSize := FillBitmapHeader(Buf, dwBufSize);
      if dwFileCount = 1 then begin
        //第一个文件写入原始大小
        PDWord(Buf)^ := inFile.Size;
        Inc(Buf, SizeOf(DWord));
        Dec(dwDibSize, 4);//修改实际可以写入大小
        //写入MD5
        Move(sMD5[1], Buf^, Length(sMD5));
        Inc(Buf, Length(sMD5));
        Dec(dwDibSize, Length(sMD5));//修改可以写入的大小

        PBoolean(Buf)^ := boCompress;
        Inc(Buf, 1);
        Dec(dwDibSize);//修改可以写入的大小
        if boCompress then begin
          pDWord(Buf)^ := dwOldSize;
          Inc(Buf, SizeOf(DWord));
          Dec(dwDibSize, SizeOf(DWord));//修改可以写入的大小
        end;

      end;

      Dec(dwDibSize, 4);//修改实际可以写入大小

      //从文件读入数据到BMP的Dibs
      dwSrcSize := inFile.Read(Buf[4], dwDibSize);
      //BMP的Dibs开始点为文件数据大小
      PDWord(Buf)^ := dwSrcSize;
      if dwSrcSize <= 0 then Break;
      //写入BMP 数据到文件
      SaveOutBMPFile(PChar(FileHeader), FileHeader.bfSize);
    until inFile.Position >= inFile.Size;
    //FreeMem(BufMem);
    Log.Add('完成!');
    Log.Add('文件数量 : ' + IntToStr(dwFileCount));
    Log.Add('--------处理完成--------');
    Log.Add('--------请关闭程序--------');
    FreeMem(BufMem);
  end else Log.Add('分配内存失败!!!');
end;

procedure TFrmMain.WMDropFiles(var Msg : TWMDropFiles);
var
  I : Integer;
  NameBuf : array [0..255] of Char;
  sFileName : string;
  sMD5 : string;
  sOutFileName : string;
  sInFileName : string;
  sDir : string;
  sLine : string;
  nFileSize : Integer;
  inFile, OutFile : TMemoryStream;
  BufMem,Buf : PChar;
  dwBufSize : DWord;
  dwDibSize : DWord;
  dwSrcSize : DWord;
  FileHeader: PBitmapFileHeader;
  dwFileCount : DWord;
  boCompress : Boolean;
  dwOldSize : DWord;//压缩用

begin
  Memo1.Clear;
  I := DragQueryFile(Msg.Drop, MAXDWORD, NameBuf, 255);
  for I := 0 to I - 1 do begin
    DragQueryFile(Msg.Drop, I, NameBuf, 255);
    sFileName := NameBuf;
    case
      Application.MessageBox(PChar('你确定开始处理' + sFileName +'?'),
      '开始处理',
      MB_YESNOCANCEL +
      MB_ICONQUESTION)
      of
      IDYES:
      begin
        dwFileCount := 1;
        Memo1.Lines.Add('开始处理:' + sFileName);
        boCompress := CheckBox2.Checked;
        inFile := TMemoryStream.Create;
        try
          inFile.LoadFromFile(sFileName);
        except
          Memo1.Lines.Add('打开文件失败!!!');
          Exit;
        end;
        BuildBMP(inFile.Memory, inFile.Size, SpinEdit1.Value * 1024, sFileName, Memo1.Lines, boCompress);
        inFile.Free;
      end;
      IDNO:begin
        //if SelectDirectory('选择BMP目录', '', sDir, [sdNewUI], Self) then
        begin
         { OpenDialog1.Title := '选择第一个文件.';
          if OpenDialog1.Execute(Handle) then    ''
          }begin
            //sFileName := OpenDialog1.FileName;
            inFile := TMemoryStream.Create;
            try
              inFile.LoadFromFile(sFileName);
            except
              Memo1.Lines.Add('打开文件失败!!!');
              Exit;
            end;
            Buf := inFile.Memory;
            GotoBitmapBits(Buf);
            outFile := TMemoryStream.Create;
            outFile.SetSize(PDWord(Buf)^);
            outFile.Seek(0, soBeginning);
            Inc(Buf, 4);

            sMD5 := '06d1ff8611ba82ddb05144c129da8cb7';
            Move(Buf^, sMD5[1], Length(sMD5));
            Inc(Buf, Length(sMD5));
            boCompress := PBoolean(Buf)^;
            Inc(Buf, 1);
            if boCompress then begin
                dwOldSize := pDWord(Buf)^;
                Inc(Buf, SizeOf(DWord));
              end;


            dwBufSize := PDWord(Buf)^;
            Inc(Buf, SizeOf(dwBufSize));
            outFile.Write(Buf^, dwBufSize);
            inFile.Clear;
            dwFileCount := 2;
            sFileName := ChangeFileExt(sFileName, '');
            sFileName := ChangeFileExt(sFileName, '');
            sOutFileName := sFileName;
            while outFile.Position < outFile.Size do begin
              sInFileName := sOutFileName + '.' + IntToStr(dwFileCount) + '.bmp';
              if FileExists(sInFileName) then begin
                inFile.LoadFromFile(sInFileName);
                Buf := inFile.Memory;
                GotoBitmapBits(Buf);
                dwBufSize := PDWord(Buf)^;
                Inc(Buf, SizeOf(dwBufSize));

                outFile.Write(Buf^, dwBufSize);
                Inc(dwFileCount);
              end else Memo1.Lines.Add(sInFileName + ':打开文件失败!!!');
            end;
            sOutFileName := sOutFileName + '.2';
            outFile.SaveToFile(sOutFileName);
            outFile.Position := 0;
            Memo1.Lines.Add('输出:' + sOutFileName);
            if CompareText(sMD5, Md5.RivestFile(sOutFileName)) = 0 then begin
              Memo1.Lines.Add('完成!!!');
              if boCompress then begin
                DeCompressStream(outFile, dwOldSize);
                outFile.SaveToFile(sOutFileName);
              end;
            end
            else
              Memo1.Lines.Add('文件MD5效验失败!!!');
          end;
        end;
      end;
    end;
  end;
end;

end.
