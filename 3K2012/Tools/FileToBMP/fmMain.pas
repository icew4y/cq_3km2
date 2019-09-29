unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Clipbrd, ShellAPI, StdCtrls, Spin, ZLib, MD5, jpeg;

type
  TFrmMain = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Memo1: TMemo;
    SpinEdit1: TSpinEdit;
    OpenDialog1: TOpenDialog;
    CheckBox3: TCheckBox;
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
begin
  AHeight := Round(Sqrt((BufSize div 4)));
  AWidth := AHeight;
  dwDibSize := AWidth * AHeight * 4;
  //如果不够就加一行
  if dwDibSize < BufSize then
    Inc(AHeight);

  FileHeader := PBitmapFileHeader(Buf);
  Inc(Buf, SizeOf(TBitmapFileHeader));
  // 位图信息头
  InfoHeader := PBitmapInfoHeader(Buf);
  InfoHeader.biSizeImage := AWidth * AHeight * 4;


  FileHeader.bfType := $4D42;
  FileHeader.bfOffBits := SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader);
  FileHeader.bfSize := FileHeader.bfOffBits + InfoHeader.biSizeImage;

  FileHeader.bfReserved1 := ord('T') or (Ord('a') shl 8);
  FileHeader.bfReserved2 := ord('s') or (Ord('.') shl 8);

  InfoHeader.biSize := SizeOf(TBitmapInfoHeader);
  InfoHeader.biWidth := AWidth;
  InfoHeader.biHeight := -AHeight;
  InfoHeader.biPlanes := 1;
  InfoHeader.biBitCount := 32;
  InfoHeader.biCompression := BI_RGB; //BI_RGB;

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
  if (FileHeader.bfType = $4D42) and (FileHeader.bfReserved1 = ord('T') or (Ord('a') shl 8)) and
     (FileHeader.bfReserved2 = ord('s') or (Ord('.') shl 8)) then begin
    FileInfoHeader := PBitmapInfoHeader(Buf + SizeOf(TBitmapFileHeader));
    Result := FileInfoHeader.biSizeImage;
    Inc(Buf, FileHeader.bfOffBits);
  end else begin
    Result := 0;
    Buf := nil;
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

function Min(A, B : DWord) : DWord;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

procedure BuildBMP(pSrc : PChar; dwSrcSize : DWord; dwBlockSize : DWord; sFileName : string; boCompress : Boolean; Log : TStrings);
var
  dwFileCount : DWord;
  dwOldSize   : DWord;
  pSrc2 : PChar;
  BlockMem  : PChar;
  BlockMemProc : PChar;
  sMD5 : string;
  FileHeader: PBitmapFileHeader;
  dwDibSize : DWord;
  procedure SaveOutBMPFile(pOutBuf : PChar; dwSize : DWord);
  var
    sOutFileName : string;
    M : TMemoryStream;
    bmp : TBitmap;
    jpg : TJPEGImage;
  begin
    Inc(dwFileCount);
    if not FrmMain.CheckBox3.Checked then
      sOutFileName := sFileName + '.' + IntToStr(dwFileCount) + '.bmp'
    else
      sOutFileName := sFileName + '.' + IntToStr(dwFileCount) + '.jpg';
    M := TMemoryStream.Create;
    M.Write(pOutBuf^, dwSize);
    M.Position := 0;
    if FrmMain.CheckBox3.Checked then begin
      jpg := TJPEGImage.Create;
      bmp := TBitmap.Create;
      bmp.LoadFromStream(M);
      jpg.ProgressiveEncoding := False;
      jpg.CompressionQuality := 100;
      jpg.Assign(bmp);
      jpg.CompressionQuality := 100;
      bmp.Free;
      //jpg.LoadFromStream(M);
      jpg.SaveToFile(sOutFileName);
      jpg.Free;
    end else M.SaveToFile(sOutFileName);
    M.Free;
    {with TFileStream.Create(sOutFileName, fmCreate) do begin
      Write(pOutBuf^, dwSize);
      Free;
    end;}
  end;
begin
  dwFileCount := 0;
  if boCompress then begin
    Log.Add('压缩...');
    dwOldSize := dwSrcSize;
    CompressBuf(pSrc, dwSrcSize, Pointer(pSrc), Integer(dwSrcSize));
    Log.Strings[Log.Count -1] := '压缩完成...';
  end;
  GetMem(BlockMem, dwBlockSize);
  if BlockMem <> nil then begin
    sMD5 := Md5.RivestBuf(pSrc, dwSrcSize);
    pSrc2 := pSrc;
    repeat
      FileHeader := PBitmapFileHeader(BlockMem);
      BlockMemProc := BlockMem;
      if dwFileCount = 0 then begin
        dwBlockSize := Min(dwSrcSize + 4, dwBlockSize);
        Inc(dwBlockSize, SizeOf(DWord));
        Inc(dwBlockSize, Length(sMD5));
        Inc(dwBlockSize);
        if boCompress then        
          Inc(dwBlockSize, SizeOf(DWord));
      end else
        dwBlockSize := Min(dwSrcSize + 4, dwBlockSize);
      dwDibSize := FillBitmapHeader(BlockMemProc, dwBlockSize);
      Dec(dwDibSize, 4);//修改实际可以写入大小
      if dwFileCount = 0 then begin
        //第一个文件写入原始大小
        PDWord(BlockMemProc)^ := dwSrcSize;
        Inc(BlockMemProc, SizeOf(DWord));
        Dec(dwDibSize, 4);//修改实际可以写入大小
        //写入MD5
        Move(sMD5[1], BlockMemProc^, Length(sMD5));
        Inc(BlockMemProc, Length(sMD5));
        Dec(dwDibSize, Length(sMD5));//修改可以写入的大小

        PBoolean(BlockMemProc)^ := boCompress;
        Inc(BlockMemProc, 1);
        Dec(dwDibSize);//修改可以写入的大小
        if boCompress then begin
          pDWord(BlockMemProc)^ := dwOldSize;
          Inc(BlockMemProc, SizeOf(DWord));
          Dec(dwDibSize, SizeOf(DWord));//修改可以写入的大小
        end;
      end;


      dwDibSize := Min(dwDibSize, dwSrcSize);
      Dec(dwSrcSize, dwDibSize);
      if dwDibSize <= 0 then Break;
      //BMP的Dibs开始点为文件数据大小
      PDWord(BlockMemProc)^ := dwDibSize;
      Inc(BlockMemProc, SizeOf(DWord));

      //从文件读入数据到BMP的Dibs
      Move(pSrc2^, BlockMemProc^, dwDibSize);
      Inc(pSrc2, dwDibSize);

      //写入BMP 数据到文件
      SaveOutBMPFile(PChar(FileHeader), FileHeader.bfSize);
    until dwSrcSize <= 0;
    //FreeMem(BufMem);
    Log.Add('完成!');
    Log.Add('文件数量 : ' + IntToStr(dwFileCount));
    Log.Add('--------处理完成--------');
    //Log.Add(sMD5);
    //FreeMem(pSrc);
    FreeMem(BlockMem);
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
  inFile, OutFile : TMemoryStream;
  Buf : PChar;
  dwBufSize : DWord;
  dwFileCount : DWord;
  boCompress : Boolean;
  dwOldSize : DWord;//压缩用
  bmp : TBitmap;
  jpg : TJPEGImage;
begin
  Memo1.Clear;
  {GetClassName(Msg.Drop, @NameBuf, SizeOf(NameBuf));
  ShowMessage(NameBuf); }
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
        Memo1.Lines.Add('开始处理:' + sFileName);
        boCompress := CheckBox2.Checked;
        inFile := TMemoryStream.Create;
        try
          inFile.LoadFromFile(sFileName);
        except
          Memo1.Lines.Add('打开文件失败!!!');
          Exit;
        end;
        BuildBMP(inFile.Memory, inFile.Size, SpinEdit1.Value * 1024, sFileName, boCompress, Memo1.Lines);
        //inFile.Free;
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
            if (PLongword(Buf)^ = $E0FFD8FF) or (PInt64(Buf)^ = $2020506A0C000000) then begin
              inFile.Position := 0;
              jpg := TJPEGImage.Create;
              jpg.LoadFromStream(inFile);
              bmp := TBitmap.Create;
              bmp.Width := jpg.Width;
              bmp.Height := jpg.Height;
              bmp.PixelFormat := pf32bit;
              bmp.Canvas.Draw(0,0,jpg);
              //bmp.Assign(jpg);
              inFile.Clear;
              bmp.SaveToStream(inFile);
              //bmp.SaveToFile('D:\Working\3K2012\1.bmp');
              bmp.Free;
              Buf := inFile.Memory;
              with PBitmapFileHeader(Buf)^ do begin
                bfReserved1 := ord('T') or (Ord('a') shl 8);
                bfReserved2 := ord('s') or (Ord('.') shl 8);
              end;
              Exit;//直接退出 jpg 是有损的....
            end;
            GotoBitmapBits(Buf);
            if Buf <> nil then begin
              outFile := TMemoryStream.Create;
              dwBufSize := PDWord(Buf)^;
              outFile.SetSize(dwBufSize);
              outFile.Seek(0, soBeginning);
              Inc(Buf, 4);

              sMD5 := 'TasNatUpDataWriteAt201204042009.';
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
                  if (Buf <> nil) then begin
                    dwBufSize := PDWord(Buf)^;
                    Inc(Buf, SizeOf(dwBufSize));
                    outFile.Write(Buf^, dwBufSize);
                  end else Memo1.Lines.Add(sInFileName + ':文件格式效验失败!!!');
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
            end else Memo1.Lines.Add('文件格式效验失败!!!');
          end;
        end;
      end;
    end;
  end;
end;

end.
