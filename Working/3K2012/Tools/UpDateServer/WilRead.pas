unit WilRead;

interface

uses
  Windows, Classes, Graphics, SysUtils,  Dialogs, fsShare;

const
   UseDIBSurface : Boolean = FALSE;
   BoWilNoCache : Boolean = FALSE;
   MaxListSize=160000;

   //zlib
   ZlibTitle = 'www.shandagames.com';



type
//-----------------------Zlib----------------------
   TWMZlibIndexHeader = record
      Title: array[0..43] of Char;
      IndexCount: integer;      // 索引总数
      //VerFlag:integer;
   end;
   PTWMZlibIndexHeader = ^TWMZlibIndexHeader;

   TWMZlibIndexInfo = record
      Position: integer;
      Size: integer;
   end;
   PTWMZlibIndexInfo = ^TWMZlibIndexInfo;

  TWMZlibImageHeader = record
      Title: array[0..43] of Char;        //'WEMADE Entertainment inc.'
      ImageCount: integer;//图片数量
   end;
   PTWMZlibImageHeader = ^TWMZlibImageHeader;

   TWMZlibImageInfo = record
      wColor: Word; //颜色  8位$103  16位$105
      wUnknown: Word;//未知  估计位图的格式，盛大为D3D准备
      Width: smallint;
      Height: smallint;
      px: smallint;
      py: smallint;
      DecodeSize: Integer; //读流大小
   end;
   PTWMZlibImageInfo = ^TWMZlibImageInfo;
//-------------------------------------------------
  TWMImageHeader = record
      Title: string[40];        //'WEMADE Entertainment inc.'
      ImageCount: integer;//图片数量
      ColorCount: integer;//颜色数量
      PaletteSize: integer;
   end;
   PTWMImageHeader = ^TWMImageHeader;
      TWMImageInfo = record
      Width: smallint;
      Height: smallint;
      px: smallint;
      py: smallint;
      bits: PByte;
   end;
   PTWMImageInfo = ^TWMImageInfo;

   TWMIndexHeader =record//wix索引文件头
      Title: string[40];        //'WEMADE Entertainment inc.'
      IndexCount: integer;
   end;
   PTWMIndexHeader = ^TWMIndexHeader;

   TWMIndexInfo = record
      Position: integer;
      Size: integer;
   end;
   PTWMIndexInfo = ^TWMIndexInfo;
   TLibType = (ltLoadBmp, ltLoadMemory, ltLoadMunual, ltUseCache);

   TBmpImage = record
      bmp: TBitmap;
      LatestTime: integer;
   end;
   PTBmpImage = ^TBmpImage;


   TNewWilHeader=Packed Record
     Comp       :Smallint;
     Title      :Array[0..19] of Char;
     Ver        :Smallint;
     ImageCount :Integer;
   End;
   TNewWilImageInfo=Packed Record
     Width      :Smallint;
     Height     :Smallint;
     Px         :Smallint;
     Py         :SmallInt;
     Shadow     :Byte;
     Shadowx    :Smallint;
     Shadowy    :Smallint;
     Length     :Integer;
   End;
   TNewWixHeader=Packed Record//新的wix文件头
     Title      :Array[0..19] of char;
     ImageCount :Integer;
   End;


   TWilRead = class
   private
      FFileName: string;
      FDatas : array of pTImageData;
      FDataReadTicks: array of DWord;
      idxfile: string;
      FImageCount: integer;
      FLibType: TLibType;

      Fwidth,FHeight:Integer;
      FOffSet:Integer;
      FType:Integer;//文件类型  3为Zlib文件
      FColorCount:Integer; //颜色数量

      FBitFormat:TPixelFormat;
      FBytesPerPixels:byte;
      procedure LoadIndex (idxfile: string);

      procedure LoadBmpImage (position: integer; var D : pTImageData);
      procedure LoadNewBmpImage (position: integer; var D : pTImageData);
   protected
   public
      IndexList: Array of Integer;  
      Stream: TFileStream;
      boIsZlibFormat: Boolean; //Zlib
      NewHeaderofIndex: TNewWixHeader;
      headerofIndex: TWMIndexHeader;
      ZlibHeaderofIndex: TWMZlibIndexHeader; //Zlib
      procedure FreeOldMem;
      constructor Create;
      destructor Destroy; override;
      procedure Initialize;
      procedure Finalize;
      procedure GetData(nIndex : Integer; var D : pTImageData);
   published
      property FileName: string read FFileName write FFileName;
      property ImageCount: integer read FImageCount;
   end;


implementation
uses Zlib;

function  ExtractFileNameOnly (const fname: string): string;
var
   extpos: integer;
   ext, fn: string;
begin
   ext := ExtractFileExt (fname);
   fn := ExtractFileName (fname);
   if ext <> '' then begin
      extpos := pos (ext, fn);
      Result := Copy (fn, 1, extpos-1);
   end else
      Result := fn;
end;


constructor TWilRead.Create;
begin
   inherited Create;
   boIsZlibFormat := False;
   FFileName := '';
   FLibType := ltLoadBmp;
   FImageCount := 0;

   FColorCount := 0;

   Stream := nil;
end;

destructor TWilRead.Destroy;
begin
  // IndexList.Free;
   if Stream <> nil then Stream.Free;
   inherited Destroy;
end;

procedure TWilRead.Initialize;
var
   header: TWMImageHeader;
   ZlibHeader: TWMZlibImageHeader;  //Zlib
   NewHeader:TNewWilHeader;
   s:Pchar;
   str:String;
begin
   begin
      if FFileName = '' then
      begin
         raise Exception.Create ('FileName not assigned..');
         exit;
      end;
      if FileExists (FFileName) then
      begin
         if Stream = nil then
            Stream := TFileStream.Create (FFileName, fmOpenReadWrite or fmShareDenyNone);
         Stream.Read (ZlibHeader, SizeOf(TWMZlibImageHeader));
         str:=ZlibHeader.Title;
         //ZlibHeader.Title := StringReplace(ZlibHeader.Title,'#0','',[rfReplaceAll]);
         if str=ZlibTitle then begin//Zlib
           if Stream<>nil then begin
             FType:=3;
             idxfile := ExtractFilePath(FFileName) + ExtractFileNameOnly(FFileName) + '.WZX';
             FImageCount := ZlibHeader.ImageCount;
             LoadIndex (idxfile);//读取索引
             boIsZlibFormat := True;
           end;
         end else begin
           Stream.Position := 0; //Zlib
           Stream.Read (header, sizeof(TWMImageHeader));
           FColorCount := header.ColorCount;
           if header.ColorCount=256 then begin
             FBitFormat:=pf8Bit; FBytesPerPixels:=1;
           end else if header.ColorCount=65536 then begin
             FBitFormat:=pf16bit; FBytesPerPixels:=2;
           end else begin
             FBitFormat:=pf32Bit; FBytesPerPixels:=4;
           end;
           if Header.Title='ILIB v1.0-WEMADE Entertainment inc.' then
               FType:=0
           else
            if Header.Title='WEMADE Entertainment inc.' then
               FType:=1
            else Begin
              Stream.Seek(0,0);
              Stream.Read(NewHeader,Sizeof(NewHeader));
            //  s:=NewHeader.
              s:=@NewHeader.Title;
              Str:=String(s);
              if Str='ILIB v1.0-WEMADE' then
                 FType:=2
              else Begin
                 stream.Free;
                 stream:=nil;
                 exit;
              End;
            End;
           if Ftype<2 then FImageCount := header.ImageCount;
           if Stream<>nil then Begin
             idxfile := ExtractFilePath(FFileName) + ExtractFileNameOnly(FFileName) + '.WIX';
             LoadIndex (idxfile);//读取索引
           end else MessageDlg (FFileName + ' 不是wil文件.', mtWarning, [mbOk], 0);
         end;
      end else begin
         MessageDlg (FFileName + ' 不存在.', mtWarning, [mbOk], 0);
      end;
   end;
end;

procedure TWilRead.Finalize;
begin
  if Stream <> nil then FreeAndNil(Stream);
  SetLength(IndexList,0); //清理动态数组内存
  boIsZlibFormat := False;
  FOffset:=0;
  FType:=0;
end;

procedure TWilRead.FreeOldMem;
var
  I : Integer;
  M : Pointer;
begin
  for I := 0 to ImageCount - 1 do
    if GetTickCount - FDataReadTicks[I] > 1000 * 60 then begin
      M := FDatas[I];
      FDatas[I] := nil;
      if M <> nil then          
      FreeMem(M);         
    end;        
end;

procedure TWilRead.GetData(nIndex : Integer; var D : pTImageData);
var
  position : Integer;
begin
  D := nil;
  if (nIndex >= 0) and (nIndex < ImageCount) then begin
    FreeOldMem;
    D := FDatas[nIndex];
    if D = nil then begin
      position := (IndexList[nIndex]);
      case Ftype of
        0..1, 3: LoadBmpImage (position, D);
        else LoadNewBmpImage (position, D);
      end;
    end;
    FDataReadTicks[nIndex] := GetTickCount;
    FDatas[nIndex] := D;
  end;
end;

procedure TWilRead.LoadIndex (idxfile: string);
var
   fhandle: integer;
   count:Integer;
  // pvalue: PInteger;
begin
 //  indexlist.Clear;
   if FileExists (idxfile) then begin
      fhandle := FileOpen (idxfile, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
        case FType of
         0:
          Begin
            FoffSet:=0;
            FileRead (fhandle, headerofIndex, sizeof(TWMIndexHeader));
            SetLength(IndexList,headerofIndex.IndexCount+1);
            FileRead (fhandle, IndexList[0], 4*headerofIndex.IndexCount);
          End;
         1:
          Begin
            FoffSet:=4;
            FileRead (fhandle, headerofIndex, sizeof(TWMIndexHeader));
            SetLength(IndexList,headerofIndex.IndexCount+1);
            FileSeek(fHandle,52,0);
            FileRead (fhandle, IndexList[0], 4*headerofIndex.IndexCount);
            if IndexList[0]<>1084 then Begin
              FileSeek(fHandle,48,0);
              FileRead (fhandle, IndexList[0], 4*headerofIndex.IndexCount);
              Ftype:=0;
              FoffSet:=0;
            End;
          End;
         2:
          Begin
             count:=0;
             Foffset:=0;
             FileSeek(fHandle,0,0);
             FileRead(Fhandle,NewHeaderofIndex,Sizeof(NewHeaderofIndex));
             SetLength(INdexList,NewHeaderofIndex.ImageCount);
             FileRead(fHandle,IndexList[0],NewHeaderofIndex.ImageCount*4);
             FimageCount:=NewHeaderofIndex.ImageCount;

             while (IndexList[0]<0) do Begin
               Inc(count);
               Inc(Foffset);
               Dec(FimageCOunt);
               FileSeek(fHandle,Sizeof(NewHeaderofIndex)+4*count,0);

               FileRead(fHandle,IndexList[0],FimageCOunt*4);
             End;
          end;
          3: begin //Zlib文件
            FoffSet:=12;
            FileRead (fhandle, ZlibHeaderofIndex, sizeof(TWMZlibIndexHeader));
            SetLength(IndexList,ZlibHeaderofIndex.IndexCount);
            FileRead (fhandle, IndexList[0], 4*ZlibHeaderofIndex.IndexCount);
          end;
        end;
         FileClose (fhandle);
      end;
   end;
end;

// *** DirectDrawSurface Functions
procedure TWilRead.LoadNewBmpImage (position: integer; var D : pTImageData);
var
   imginfo: TNewWilImageInfo;
   buf:Array of word;
  //DBits: PByte;
  dbits:array of word;
  // newdib:TDib;
   nYCnt,nWidthEnd,nWidthStart,nCntCopyWord,x{,nXOffset,nYOffset}:Integer;
   {nStartX,nStartY,}nCurrWidth,nLastWidth,nCheck:integer;
  tmpFile:TMemoryStream;
begin
   if Position<=0 then
   Begin
     Exit;
   End;
   Stream.Seek (position, 0);
   Stream.Read (imginfo, sizeof(TNewWilImageInfo));
   SetLength(Dbits,Imginfo.Width*Imginfo.Height*2);
   SetLength(Buf,ImgINfo.Length*2);
   Stream.Read (Buf[0], Imginfo.Length*2);
   if (ImgINfo.Width>1000) or (ImgInfo.Height>1000) then
        Exit;
   		//nXOffset	:= 0;
			//nYOffset	:= 0;

				//nStartX		:= 0;
				//nStartY		:= 0;

			 nWidthStart	:= 0;
			 nWidthEnd	:= 0;
			 nCurrWidth  := 0;
			 //nCntCopyWord := 0;
			 //nYCnt :=0;
			 //nLastWidth := 0;
       for nycnt:=0 to ImgInfo.Height do
       Begin
          nWidthEnd:=Buf[nwidthstart]+nWidthEnd;
          Inc(nWidthStart);
//          for x:=nWidthStart to nwidthend-1 do
          x:=nWidthStart;
          while x<nwidthend do
          Begin
             if Buf[x]=$c0 then
             Begin
              // inc(x);
               x:=x+1;
               nCntCopyWord:=Buf[x];
               x:=x+1;
               nCurrWidth:=nCurrWidth+nCntCopyWord;
             End
             else
               if (Buf[x]=$c1) then
               Begin
                 Inc(x);
                 nCntCopyWord:=Buf[x];
                 Inc(x);

                 nLastWidth:=nCurrWidth;
                 nCurrWidth:=nCurrWidth+nCntCopyWord;
                 if (ImgInfo.Width<nLastWidth) then
                     x:=x+nCntCopyWord
                 else
                 Begin
                   if (nLastWidth<=ImgInfo.Width) and (ImgInfo.Width<nCurrWidth) then
                   Begin
                     CopyMemory(@Dbits[(Imginfo.height-nycnt)*ImgInfo.width+nlastwidth],@buf[x],(imginfo.Width-nlastwidth)*2);
                     x:=x+ncntcopyword;
                   End
                   else
                   Begin
                     CopyMemory(@Dbits[(Imginfo.height-nycnt)*ImgInfo.width+nlastwidth],@buf[x],nCntCopyWord*2);
                     x:=x+ncntcopyword;
                   End;

                 End;

               End
               else
               Begin
                  if(Buf[x]=$c2) or (Buf[x]=$c3) then
                  Begin
                    Inc(x);
                    nCntCopyWord:=Buf[x];
                    Inc(x);
                    nLastWidth:=nCurrWidth;
                    nCurrWidth:=nCurrWidth+nCntCopyWord;
                    if (imginfo.Width<nLastWidth) then
                        x:=x+ncntcopyword
                    else
                    Begin
                        if (nlastwidth<imginfo.Width) and (imginfo.Width<nCurrWidth) then
                        Begin
                          for nCheck:=0 to (imginfo.Width-nlastwidth-1) do
                             Dbits[((imginfo.Height-nycnt)*(imginfo.Width))+(nlastwidth+ncheck)]:= Buf[x+ncheck];
                           x:=x+nCntCopyWord;
                        End
                        else
                        Begin
                          for nCheck:=0 to (nCntCopyWord-1) do
                             Dbits[((imginfo.Height-nycnt)*(imginfo.Width))+(nlastwidth+ncheck)]:= Buf[x+ncheck];
                           x:=x+nCntCopyWord;
                        End

                    End;
                  End;

               End;

          end;

          Inc(nWidthEnd);
          nWidthStart:=nWidthEnd;
          nCurrWidth:=0;

       End;
       //d:=0;

//   CreateDIBitmap(GetDC(0),lpbih,CBM_INIT,@Dbits,@lpbi,d );
    { FillBitMapHeader(BHeader);
     Bheader.Width:=Imginfo.Width;
     BHeader.Height:=Imginfo.Height;
     BHeader.Size:=Imginfo.Width*Imginfo.Height*2;
     Bheader.bfSize:=66+Imginfo.Width*Imginfo.Height*2;
     tmpFile:=TMemoryStream.Create;
     TmpFile.SetSize(Imginfo.Width*Imginfo.Height*2+56);
     TmpFile.Seek(0,0);
     TmpFile.Write(BHeader,66);
     TmpFile.Write(DBits[0],Imginfo.Width*Imginfo.Height*2);
     TmpFile.Seek(0,0);
    TmpFile.Free;    }
end;

procedure TWilRead.LoadBmpImage (position: integer; var D : pTImageData);
var
  imginfo: TWMImageInfo;
  ZlibImgInfo: TWMZlibImageInfo;
  cs: TDecompressionStream;
  OldSize: Integer;
  ms, fs: TMemoryStream; //Zlib 此流如果写在游戏中，建议当成类的子成员，类创建则创建，效率会好点
   //DDSD: TDDSurfaceDesc2;  // 用于 Surface.Lock
begin
  Stream.Seek (position, 0);
  if position > 0 then begin //防止读头
    if boIsZlibFormat then begin
      Stream.Read (ZlibImgInfo, sizeof(TWMZlibImageInfo));
      if (ZlibImgInfo.Width > 2000) or (ZlibImgInfo.Height > 2000) then Exit;
      if (ZlibImgInfo.Width > 0) and (ZlibImgInfo.Height > 0) then begin
        if ZlibImgInfo.wColor = $103 then begin
          FColorCount := 256;
          FBitFormat:=pf8Bit;
          FBytesPerPixels:=1;
        end else if ZlibImgInfo.wColor = $105 then begin
          FColorCount := 65536;
          FBitFormat:=pf16Bit;
          FBytesPerPixels:=2;
        end else begin
          Exit;
        end;
        GetMem(D, SizeOf(TImageData) + ZlibImgInfo.DecodeSize);
        D.Width := ZlibImgInfo.Width;
        D.Height := ZlibImgInfo.Height;
        D.btBitCount := FBytesPerPixels * 8;
        D.btDecode := 1;
        D.px := ZlibImgInfo.px;
        D.py := ZlibImgInfo.py;
        D.nLen := ZlibImgInfo.DecodeSize;
        Stream.Read(D.Data, D.nLen);
      end;
    end else begin
      Stream.Read (imginfo, sizeof(TWMImageInfo)-4+FOffset);
      if (ImgINfo.Width>2000) or (ImgInfo.Height>2000) then Exit;

      GetMem(D, SizeOf(TImageData) + ZlibImgInfo.DecodeSize);
      D.Width := imginfo.Width;
      D.Height := imginfo.Height;
      D.btBitCount := FBytesPerPixels * 8;
      D.btDecode := 0;  
      D.px := imginfo.px;
      D.py := imginfo.py;
      D.nLen := imginfo.Width * imginfo.Height * FBytesPerPixels;
      Stream.Read(D.Data, D.nLen);
    end;
  end;
end;   

end.
