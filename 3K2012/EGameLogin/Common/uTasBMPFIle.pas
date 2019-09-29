unit uTasBMPFIle;

interface
uses
  Windows, Forms, SysUtils, Classes, ZLib, WinInet;

const
  OldBaiduHost = 'http://hiphotos.baidu.com/3kdatabytasnat/pic/item/';
  NewBaiduHost = 'http://hiphotos.baidu.com/m2boss/pic/item/';
    //---------------------------------------------------
  sQk_Prguse16_Wil_MD5 = 'df0e7cd27660220e85fed20aab783d79';
  sQk_Prguse16_Wil_Addrs: array[1..1] of string = (
    '3aabdf99a9773912408e2ec0f8198618377ae221'
    );

  sQk_Prguse16_Wix_MD5 = 'd2ebe8af7ae0468546dffeebde770e6d';
  sQk_Prguse16_Wix_Addrs: array[1..1] of string = (
    '04546fdac3fdfc0325e34819d43f8794a5c22631'
    );

  //---------------------------------------------------
  sQk_Prguse_Wil_MD5 = '955c32331487092acb1586b7ab300ccf';
  sQk_Prguse_Wil_Addrs: array[1..1] of string = (
    'ff522e9fa61ea8d360b9dfa5970a304e241f5831'
    );

  sQk_Prguse_Wix_MD5 = '910b90ea06b3e305bb01c87d1aceb63d';
  sQk_Prguse_Wix_Addrs: array[1..1] of string = (
    'e9b739ded1c8a7866cb1e1af6709c93d71cf5031'
    );
  ///====================
  sPrguse3_Wil_MD5 = '9fc3d62f9629e2f6257ab088fd28b158';
  sPrguse3_Wil_Addrs: array[1..9] of string = (
    'c77fef759e2f0708d4c40abee924b899ab01f2fb',
    '5d3cc27102087bf4e9a85b4cf2d3572c10dfcf07',
    '4e5dd3dfad6eddc4ea24944539dbb6fd50663384',
    'd56319c2a786c917e0c17287c93d70cf39c75785',
    'fc97793f33fa828b351ebe5dfd1f4134960a5a86',
    '11a611f3d72a6059162cc2a42834349b023bba87',
    'ef6ab13b0a55b319504d8ed043a98226cefc1716',
    '8bba815e0923dd5434c4abcdd109b3de9d824817',
    'df9430d6d100baa16a1364054710b912c9fc2e80'
    );
  //=========
  sPrguse3_Wix_MD5 = '96550f8222a406b9994210e76b8ae2c0';
  sPrguse3_Wix_Addrs: array[1..1] of string = (
    '83670bf7fc039245668ac2b18794a4c27c1e2580'
    );

  //只更新P3
  sPrguse_Wzl_MD5 = '8220cff759268604b6e48024e7857056';
  sPrguse_Wzl_Addrs: array[1..11] of string = (
    '600782c9a3cc7cd99a75ea7b3901213fb90e9171',
    '4ca2b5ccbc3eb1357f9f6919a61ea8d3fc1f4471',
    '7fb147d0b74543a91e43246e1e178a82b8011471',
    'e2db27c0b31c870110dc6c44277f9e2f0608ff6c',
    '952a1ea3d0a20cf43ecb207d76094b36adaf9972',
    '276c1b5143a98226529af5858a82b9014b90eb73',
    '6f64d0cd8d1001e9207dcaadb80e7bec55e79708',
    'be23eb04b912c8fca4b2286ffc039245d7882108',
    'f5ba1f0fb051f8192f64dde8dab44aed2f73e709',
    'c452fd29269759eeec0abe69b2fb43166c22df7c',
    '18828420349b033ba8c9227815ce36d3d439bd09'
    );

  sPrguse_Wzx_MD5 = 'c2171a6b504cf22fde5a70fbcd6a4f19';
  sPrguse_Wzx_Addrs: array[1..1] of string = (
    '0628c92c0cd791239fa04ad6ad345982b3b78009'
    );

  sPrguse2_Wzl_MD5 = '840e46b0fd1efb650b30faa1de2d78c2';
  sPrguse2_Wzl_Addrs: array[1..7] of string = (
    '7f763096d158ccbf2bfc6b9819d8bc3eb0354109',
    '875357f9ab64034feb8d1ca4afc379310b551d09',
    '9d958a8359ee3d6d8793596943166d224e4ade7d',
    '600782c9a3cc7cd99a79ea7b3901213fb90e917d',
    '59627ddca786c91726578c9bc93d70cf3ac7577d',
    'e2db27c0b31c870110f56c44277f9e2f0608ff0b',
    '99531eef43166d229934cb36462309f79152d20b'
    );

  sPrguse2_Wzx_MD5 = '78d27a38e62b0507abed2c272f56a286';
  sPrguse2_Wzx_Addrs: array[1..1] of string = (
    '9d958a8359ee3d6d8792596943166d224e4ade7e'
    );
  {//老的 
  sPrguse3_Wil_MD5 = '06d1ff8611ba82ddb05144c129da8cb7';
  sPrguse3_Wil_Addrs: array[1..8] of string = (
    'e15d4cea9925bc31d9c4aa395edf8db1ca137037',
    'cea0d7e00ad162d9e247c9bd11dfa9ec8b13cd27',
    '65a9e01c6e061d9501de9c997bf40ad163d9ca30',
    '7cd6669465380cd7c586094ca144ad3458828130',
    '6ab604c7fd1f413408afaedf251f95cad0c85e30',
    '67ccaf5b78f0f7364d66e7a00a55b319eac41330',
    '41b8adfd3901213fd09be57d54e736d12e2e9520',
    'f76f3329f8dcd10014345380728b4710b8122f20'
    );

  sPrguse3_Wix_MD5 = 'f306d8594469a248a92e9b31037e9c05';
  sPrguse3_Wix_Addrs: array[1..1] of string = (
    '29754b0590ef76c6d149508a9d16fdfaae516731'
    );


  sPrguse_Wzl_MD5 = '8220cff759268604b6e48024e7857056';
  sPrguse_Wzl_Addrs: array[1..11] of string = (
    '600782c9a3cc7cd99a75ea7b3901213fb90e9171',
    '4ca2b5ccbc3eb1357f9f6919a61ea8d3fc1f4471',
    '7fb147d0b74543a91e43246e1e178a82b8011471',
    'e2db27c0b31c870110dc6c44277f9e2f0608ff6c',
    '952a1ea3d0a20cf43ecb207d76094b36adaf9972',
    '276c1b5143a98226529af5858a82b9014b90eb73',
    '6f64d0cd8d1001e9207dcaadb80e7bec55e79708',
    'be23eb04b912c8fca4b2286ffc039245d7882108',
    'f5ba1f0fb051f8192f64dde8dab44aed2f73e709',
    'c452fd29269759eeec0abe69b2fb43166c22df7c',
    '18828420349b033ba8c9227815ce36d3d439bd09'
    );

  sPrguse_Wzx_MD5 = 'c2171a6b504cf22fde5a70fbcd6a4f19';
  sPrguse_Wzx_Addrs: array[1..1] of string = (
    '0628c92c0cd791239fa04ad6ad345982b3b78009'
    );

  sPrguse2_Wzl_MD5 = '840e46b0fd1efb650b30faa1de2d78c2';
  sPrguse2_Wzl_Addrs: array[1..7] of string = (
    '7f763096d158ccbf2bfc6b9819d8bc3eb0354109',
    '875357f9ab64034feb8d1ca4afc379310b551d09',
    '9d958a8359ee3d6d8793596943166d224e4ade7d',
    '600782c9a3cc7cd99a79ea7b3901213fb90e917d',
    '59627ddca786c91726578c9bc93d70cf3ac7577d',
    'e2db27c0b31c870110f56c44277f9e2f0608ff0b',
    '99531eef43166d229934cb36462309f79152d20b'
    );

  sPrguse2_Wzx_MD5 = '78d27a38e62b0507abed2c272f56a286';
  sPrguse2_Wzx_Addrs: array[1..1] of string = (
    '9d958a8359ee3d6d8792596943166d224e4ade7e'
    );}
  //---------------------------------------------------
  {sPrguse3_Wil_MD5   = 'AMD5';
  sPrguse3_Wil_Addrs : array [1..4] of string = (
                'http://localhost/Prguse3/1.bmp',
                'http://localhost/Prguse3/2.bmp',
                'http://localhost/Prguse3/3.bmp',
                'http://localhost/Prguse3/4.bmp'
  );

  sPrguse3_Wix_MD5   = 'AMD5';
  sPrguse3_Wix_Addrs : array [1..4] of string = (
                'http://localhost/Prguse3/1.bmp',
                'http://localhost/Prguse3/2.bmp',
                'http://localhost/Prguse3/3.bmp',
                'http://localhost/Prguse3/4.bmp'
  );
    }
var
  boDownPrguseing: Boolean;
  boOKDown: Byte = 0; //0未选择1下2不下 用户选择下载
  //检测本地文件MD5不同则从百度下载 By TasNat at: 2012-04-04 19:52:07
procedure CheckAndDownNeedFile;
implementation

uses
  fmMain, MD5, GameLoginShare;

//跳转到BMP格式的数据段 数据段首4字节为实际大小 By TasNat at: 2012-04-04 11:16:34

function GotoBitmapBits(var Buf: PChar): DWord;
var
  FileHeader: PBitmapFileHeader;
  FileInfoHeader: PBitmapInfoHeader;
begin
  FileHeader := PBitmapFileHeader(Buf);
  if (FileHeader.bfType = $4D42) and (FileHeader.bfReserved1 = ord('T') or (Ord('a') shl 8)) and
    (FileHeader.bfReserved2 = ord('s') or (Ord('.') shl 8)) then begin
    FileInfoHeader := PBitmapInfoHeader(Buf + SizeOf(TBitmapFileHeader));
    Inc(Buf, FileHeader.bfOffBits);
    Result := PDWord(Buf)^;
    Inc(Buf, SizeOf(DWord));
  end else begin
    Buf := nil;
    Result := 0;
  end;
end;

procedure DeCompressStream(InStream: TMemoryStream; dwOldSize: DWord);
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
    MS.Free; //20110714
  end;
end;

//从百度下载文件如果文件MD5不同 By TasNat at: 2012-04-04 20:38:12

function TasGetFileByBaidu(sNeedMd5, sDesFileName: string; sDownAddrs: array of string; BaiduHost : string = OldBaiduHost): Boolean;
var
  sLocalMD5: string;
  sServerMD5: string;
  sDownMD5: string;
  I: Integer;
  InStream: TMemoryStream;
  OutStream: TMemoryStream;
  Buf: PChar;
  dwCompressSize: DWord; //压缩后大小或原始大小
  dwCurDataSize: DWord;
  dwFullSize: DWord; //原始文件大小
  boCompress: Boolean; //是否ZLib 压缩
  function GetOnlineStatus: Boolean;
  var
    ConTypes: Integer;
  begin
    ConTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
    if not InternetGetConnectedState(@ConTypes, 0) then
       Result := False
    else
       Result := True;
  end;
begin
  sLocalMD5 := RivestFile(sDesFileName);
  try
    Result := (CompareText(sLocalMD5, sNeedMd5) = 0) and GetOnlineStatus;
    if not Result then begin
      {if boOKDown = 0 then begin
       if MessageBox(0,
      PChar(SetDate('腑蕾奥川鼓了绸哏荪哐坊湃羹刿範哐坊')//发现客户端文件需要修复，是否自动修复？
      + #13#10 +
      SetDate('酱哐坊捌擞撼偻裂抚谗卿芰栏待芰栏累疟酱隍棘')),//不修复可能导致无法进入游戏或游戏显示不正常。
      PChar(SetDate('刿範哐坊')),//自动修复
      MB_YESNO +
      MB_ICONQUESTION)
      = IDYES then boOKDown := 1 else boOKDown := 2;
      end;
      if boOKDown <> 1 then Exit; }
      InStream := TMemoryStream.Create;
      //第一个文件特殊处理
      FrmMain2.IdHTTP1.Get(BaiduHost + sDownAddrs[Low(sDownAddrs)] + '.jpg', InStream);
      Buf := InStream.Memory;
      dwCompressSize := GotoBitmapBits(Buf);
      if (dwCompressSize > 0) and (Buf <> nil) then begin
        OutStream := TMemoryStream.Create;
        sServerMD5 := 'TasNatUpDataWriteAt201204042009.';
        Move(Buf^, sServerMD5[1], Length(sServerMD5));
        Inc(Buf, Length(sServerMD5));
        boCompress := PBoolean(Buf)^;
        Inc(Buf, 1);
        if boCompress then begin
          dwFullSize := pDWord(Buf)^;
          Inc(Buf, SizeOf(DWord));
        end;
        dwCurDataSize := PDWord(Buf)^;
        Inc(Buf, SizeOf(dwCurDataSize));
        //OutStream : TMemoryStream;
        OutStream.Write(Buf^, dwCurDataSize);
        try
          for I := Low(sDownAddrs) + 1 to High(sDownAddrs) do begin
            InStream.Clear;
            FrmMain2.IdHTTP1.Get(BaiduHost + sDownAddrs[I] + '.jpg', InStream);
            if InStream.Size > 0 then begin
              Buf := InStream.Memory;
              dwCurDataSize := GotoBitmapBits(Buf);
              if (dwCurDataSize > 0) and (Buf <> nil) then
                OutStream.Write(Buf^, dwCurDataSize)
              else raise Exception.Create('下载文件段格式不符.');
            end;
          end;
          if OutStream.Size = dwCompressSize then begin
            sDownMD5 := RivestBuf(OutStream.Memory, OutStream.Size);
            if CompareText(sDownMD5, sServerMD5) = 0 then begin
              if boCompress then
                DeCompressStream(OutStream, dwFullSize);
              OutStream.SaveToFile(sDesFileName);
              Result := True;
            end else raise Exception.Create('下载文件MD5不符.');
          end else raise Exception.Create('下载文件大小不符.');

        finally
          OutStream.Free;
        end;
      end else raise Exception.Create('下载文件头格式不符.');
      InStream.Free;
    end;
  except
    //这可以处理下失败的消息。
    Result := False;
  end;
end;


procedure CheckAndDownNeedFile;
begin
  if not boDownPrguseing then begin
    boDownPrguseing := True;
    FrmMain2.RzLabelStatus.Caption := '正在修复已损坏的客户端文件...';
    FrmMain2.TreeView1.Enabled := False;
    FrmMain2.ComboBox1.Enabled := False;
    try
      FrmMain2.ButtonActiveF; //按键激活   20080311
      FrmMain2.RzProgressBarAll.TotalParts := 10;
      FrmMain2.RzProgressBarAll.PartsComplete := 0;
      if TasGetFileByBaidu(sPrguse_Wzl_MD5, g_sMirPath + 'Data\Prguse.wzl', sPrguse_Wzl_Addrs, NewBaiduHost) and
        TasGetFileByBaidu(sPrguse_Wzx_MD5, g_sMirPath + 'Data\Prguse.wzx', sPrguse_Wzx_Addrs, NewBaiduHost)
        then
        DeleteFile(PChar(g_sMirPath + 'Data\Prguse.wil'));
      FrmMain2.RzProgressBarAll.PartsComplete := FrmMain2.RzProgressBarAll.PartsComplete + 2;

      if TasGetFileByBaidu(sPrguse2_Wzl_MD5, g_sMirPath + 'Data\Prguse2.wzl', sPrguse2_Wzl_Addrs, NewBaiduHost) and
        TasGetFileByBaidu(sPrguse2_Wzx_MD5, g_sMirPath + 'Data\Prguse2.wzx', sPrguse2_Wzx_Addrs, NewBaiduHost)
        then
        DeleteFile(PChar(g_sMirPath + 'Data\Prguse2.wil'));
      FrmMain2.RzProgressBarAll.PartsComplete := FrmMain2.RzProgressBarAll.PartsComplete + 2;

      if TasGetFileByBaidu(sPrguse3_Wil_MD5, g_sMirPath + 'Data\Prguse3.wzl', sPrguse3_Wil_Addrs, NewBaiduHost) and
        TasGetFileByBaidu(sPrguse3_Wix_MD5, g_sMirPath + 'Data\Prguse3.wzx', sPrguse3_Wix_Addrs, NewBaiduHost)
        then
        FrmMain2.RzProgressBarAll.PartsComplete := FrmMain2.RzProgressBarAll.PartsComplete + 2;

    //-------------------------
      TasGetFileByBaidu(sQk_Prguse16_Wil_MD5, g_sMirPath + 'Data\Qk_Prguse16.wil', sQk_Prguse16_Wil_Addrs);
      FrmMain2.RzProgressBarAll.PartsComplete := FrmMain2.RzProgressBarAll.PartsComplete + 1;
      TasGetFileByBaidu(sQk_Prguse16_Wix_MD5, g_sMirPath + 'Data\Qk_Prguse16.wix', sQk_Prguse16_Wix_Addrs);
      FrmMain2.RzProgressBarAll.PartsComplete := FrmMain2.RzProgressBarAll.PartsComplete + 1;
    //-------------------------
      TasGetFileByBaidu(sQk_Prguse_Wil_MD5, g_sMirPath + 'Data\Qk_Prguse.wil', sQk_Prguse_Wil_Addrs);
      FrmMain2.RzProgressBarAll.PartsComplete := FrmMain2.RzProgressBarAll.PartsComplete + 1;
      TasGetFileByBaidu(sQk_Prguse_Wix_MD5, g_sMirPath + 'Data\Qk_Prguse.wix', sQk_Prguse_Wix_Addrs);
      FrmMain2.RzProgressBarAll.PartsComplete := FrmMain2.RzProgressBarAll.PartsComplete + 1;

    //-------------------------
    {TasGetFileByBaidu(sPrguse3_Wil_MD5, g_sMirPath + 'Data\Prguse3.wil', sPrguse3_Wil_Addrs);
    FrmMain.RzProgressBarAll.PartsComplete := FrmMain.RzProgressBarAll.PartsComplete + 1;
    TasGetFileByBaidu(sPrguse3_Wix_MD5, g_sMirPath + 'Data\Prguse3.wix', sPrguse3_Wix_Addrs);
    FrmMain.RzProgressBarAll.PartsComplete := FrmMain.RzProgressBarAll.PartsComplete + 1; }
    finally
      FrmMain2.TreeView1.Enabled := True;
      FrmMain2.ComboBox1.Enabled := True;
      FrmMain2.RzLabelStatus.Caption := {'请选择服务器...'} SetDate('蠕蕻埝格窿渗!!!');
      boDownPrguseing := False;
    end;
  end;
end;


end.

