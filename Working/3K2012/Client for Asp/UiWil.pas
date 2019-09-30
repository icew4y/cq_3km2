unit UiWil;

interface
uses Windows, Classes, AspwmUtil, SysUtils, AsphyreFactory,
    AbstractTextures, AsphyreTypes, AsphyreBmp, Graphics;

type
  TDxImageArr   = array[0..MaxListSize div 4] of TDxImage;
  PTDxImageArr  = ^TDxImageArr;

  TUIWMImages = class
    m_FileList: TStringList;
  private
    FInitialized: Boolean;
    m_ImgArr    :pTDxImageArr;
    function  FGetImageSurface (index: integer): TAsphyreLockableTexture;
    procedure FreeOldMemorys(Index: Integer);
    procedure LoadDxImage(const AFileName: string; DXImage: pTDXImage);
    function GetImageCount : Integer;
  protected
    m_dwMemChecktTick: LongWord;   //0x44
  public

    constructor Create (); dynamic;
    destructor Destroy; override;
    procedure  AddBitmap(Bitmap: TBitmap);

    procedure Initialize;
    procedure Finalize;
    property Images[index: Integer]: TAsphyreLockableTexture read FGetImageSurface;
    property Initialized: Boolean read FInitialized write FInitialized;
    property ImageCount:Integer read GetImageCount;
  end;

implementation
uses ClMain, MShare;

{ TUIWMImages }

constructor TUIWMImages.Create();
begin
  inherited;
  m_ImgArr := nil;
  FInitialized := False;
  m_FileList := TStringList.Create;
end;

destructor TUIWMImages.Destroy;
begin
  m_FileList.Free;
  inherited Destroy;
end;

procedure TUIWMImages.FreeOldMemorys(Index: Integer);
var
  I: Integer;
  dwTimeTick: longword;
begin
  dwTimeTick := GetTickCount;
  if m_ImgArr <> nil then begin
    for I := m_FileList.Count - 1 downto 0 do begin
      if (Index <> I) then begin
        if (m_ImgArr[I].Surface <> nil) and (GetTickCount - m_ImgArr[I].dwLatestTime > 60 * 1000 * 2) then begin
          try
            m_ImgArr[I].Surface.Free;
          except
            m_ImgArr[I].Surface := nil;
          end;
          m_ImgArr[I].Surface := nil;
        end;
      end;
    end;
  end;
end;

function TUIWMImages.GetImageCount : Integer;
begin
  Result := 0;
  if (m_FileList <> nil) then
    Result := m_FileList.Count;
end;

function TUIWMImages.FGetImageSurface(index: integer): TAsphyreLockableTexture;
begin
  Result := nil;
  if (Index >= 0) and (Index < ImageCount) and (Initialized) then begin
    if GetTickCount - m_dwMemChecktTick > 10000 then begin
      m_dwMemChecktTick := GetTickCount;
      FreeOldMemorys(Index);
    end;
    if (m_ImgArr[Index].Surface = nil) or (not m_ImgArr[Index].Surface.Active) then begin
      LoadDxImage(m_FileList.Strings[Index], @m_ImgArr[Index]);
      //PX := m_ImgArr[Index].nPx;
      //PY := m_ImgArr[Index].nPy;
      Result := m_ImgArr[Index].Surface;
    end else begin
      m_ImgArr[Index].dwLatestTime := GetTickCount;
      //PX := m_ImgArr[Index].nPx;
      //PY := m_ImgArr[Index].nPy;
      Result := m_ImgArr[Index].Surface;
    end;
  end;

  Result := nil;
  if (index >= 0) and (index < ImageCount) then
   Result := m_ImgArr[index].Surface;
end;

procedure TUIWMImages.Finalize;
var
  I: Integer;
begin
  if not FInitialized then Exit;
  FInitialized := False;
  if ImageCount > 0 then begin
    if m_ImgArr <> nil then begin //20090503
      for i:=0 to ImageCount-1 do begin
        if m_ImgArr[i].Surface <> nil then begin
           m_ImgArr[i].Surface.Free;
           m_ImgArr[i].Surface := nil;
        end;
      end;
      FreeMem(m_ImgArr);
      m_ImgArr := nil;
    end;
    m_FileList.Clear;
  end;
end;

procedure TUIWMImages.Initialize;
begin
  if FInitialized then Exit;
  m_FileList.Clear;
  m_FileList.Add(g_ParamDir+UiImageDir+'HeroStatusWindow.uib'); //0
  m_FileList.Add(g_ParamDir+UiImageDir+'BookBkgnd.uib'); //1
  m_FileList.Add(g_ParamDir+UiImageDir+'BookCloseDown.uib'); //2
  m_FileList.Add(g_ParamDir+UiImageDir+'BookCloseNormal.uib');  //3
  m_FileList.Add(g_ParamDir+UiImageDir+'BookNextPageDown.uib'); //4
  m_FileList.Add(g_ParamDir+UiImageDir+'BookNextPageNormal.uib');  //5
  m_FileList.Add(g_ParamDir+UiImageDir+'BookPrevPageDown.uib'); //6
  m_FileList.Add(g_ParamDir+UiImageDir+'BookPrevPageNormal.uib');  //7
  m_FileList.Add(g_ParamDir+BookImageDir+'1\'+'1.uib'); //8
  m_FileList.Add(g_ParamDir+BookImageDir+'1\'+'2.uib'); //9
  m_FileList.Add(g_ParamDir+BookImageDir+'1\'+'3.uib'); //10
  m_FileList.Add(g_ParamDir+BookImageDir+'1\'+'4.uib'); //11
  m_FileList.Add(g_ParamDir+BookImageDir+'1\'+'5.uib'); //12
  m_FileList.Add(g_ParamDir+BookImageDir+'1\'+'CommandDown.uib'); //13
  m_FileList.Add(g_ParamDir+BookImageDir+'1\'+'CommandNormal.uib'); //14
  m_FileList.Add(g_ParamDir+BookImageDir+'2\'+'1.uib'); //15
  m_FileList.Add(g_ParamDir+BookImageDir+'3\'+'1.uib'); //16
  m_FileList.Add(g_ParamDir+BookImageDir+'4\'+'1.uib'); //17
  m_FileList.Add(g_ParamDir+BookImageDir+'5\'+'1.uib'); //18
  m_FileList.Add(g_ParamDir+BookImageDir+'6\'+'1.uib'); //19
  m_FileList.Add(g_ParamDir+MinimapImageDir+'301.mmap'); //20
  m_FileList.Add(g_ParamDir+UiImageDir+'vigourbar1.uib'); //21
  m_FileList.Add(g_ParamDir+UiImageDir+'vigourbar2.uib'); //22
  m_FileList.Add(g_ParamDir+UiImageDir+'BuyLingfuDown.uib'); //23
  m_FileList.Add(g_ParamDir+UiImageDir+'BuyLingfuNormal.uib'); //24
  m_FileList.Add(g_ParamDir+MinimapImageDir+'302.mmap'); //25
  m_FileList.Add(g_ParamDir+MinimapImageDir+'303.mmap'); //26
  m_FileList.Add(g_ParamDir+MinimapImageDir+'304.mmap'); //27
  m_FileList.Add(g_ParamDir+MinimapImageDir+'306.mmap'); //28
  m_FileList.Add(g_ParamDir+UiImageDir+'StateWindowHuman.uib'); //29
  m_FileList.Add(g_ParamDir+UiImageDir+'StateWindowHero.uib'); //30
  m_FileList.Add(g_ParamDir+UiImageDir+'GloryButton.uib'); //31
  m_FileList.Add(g_ParamDir+MinimapImageDir+'307.mmap'); //32
  m_FileList.Add(g_ParamDir+MinimapImageDir+'308.mmap'); //33
  m_FileList.Add(g_ParamDir+MinimapImageDir+'309.mmap'); //34
  m_FileList.Add(g_ParamDir+MinimapImageDir+'310.mmap'); //35
  m_FileList.Add(g_ParamDir+MinimapImageDir+'311.mmap'); //36
  m_FileList.Add(g_ParamDir+MinimapImageDir+'312.mmap'); //37
  m_FileList.Add(g_ParamDir+MinimapImageDir+'313.mmap'); //38
  m_FileList.Add(g_ParamDir+MinimapImageDir+'314.mmap'); //39
  m_FileList.Add(g_ParamDir+MinimapImageDir+'315.mmap'); //40
  m_FileList.Add(g_ParamDir+MinimapImageDir+'316.mmap'); //41
  m_FileList.Add(g_ParamDir+MinimapImageDir+'317.mmap'); //42
  m_FileList.Add(g_ParamDir+MinimapImageDir+'318.mmap'); //43
  m_FileList.Add(g_ParamDir+MinimapImageDir+'319.mmap'); //44
  m_FileList.Add(g_ParamDir+MinimapImageDir+'320.mmap'); //45
  m_FileList.Add(g_ParamDir+MinimapImageDir+'321.mmap'); //46
  m_FileList.Add(g_ParamDir+MinimapImageDir+'322.mmap'); //47
  m_FileList.Add(g_ParamDir+MinimapImageDir+'323.mmap'); //48
  m_FileList.Add(g_ParamDir+MinimapImageDir+'324.mmap'); //49
  m_FileList.Add(g_ParamDir+MinimapImageDir+'325.mmap'); //50
  m_FileList.Add(g_ParamDir+MinimapImageDir+'326.mmap'); //51
  m_FileList.Add(g_ParamDir+MinimapImageDir+'327.mmap'); //52
  m_FileList.Add(g_ParamDir+MinimapImageDir+'328.mmap'); //53
  m_FileList.Add(g_ParamDir+MinimapImageDir+'329.mmap'); //54
  m_FileList.Add(g_ParamDir+MinimapImageDir+'330.mmap'); //55
  m_FileList.Add(g_ParamDir+MinimapImageDir+'402.mmap'); //56
  m_FileList.Add(g_ParamDir+MinimapImageDir+'3021.mmap'); //57
  m_FileList.Add(g_ParamDir+MinimapImageDir+'3022.mmap');  //16Î»ÑÕÉ« 58
  m_FileList.Add(g_ParamDir+MinimapImageDir+'3023.mmap'); //59
  m_FileList.Add(g_ParamDir+MinimapImageDir+'331.mmap'); //60
  m_FileList.Add(g_ParamDir+UiImageDir+'3KM2.uib'); //61

  if (ImageCount = 0) or FInitialized then Exit;
  if m_ImgArr <> nil then
    FreeAndNil(m_ImgArr);
  m_ImgArr:=AllocMem(SizeOf(TDxImage) * ImageCount);
  AddBitmap(frmMain.ImageLogo.Picture.Bitmap);
  FInitialized := True;
end;

procedure TUIWMImages.LoadDxImage(const AFileName: string; DXImage: pTDXImage);
var
  Image: TBitmapEx;
        Bits: Pointer;
      Pitch: Integer;
      Index: Integer;
      WritePx: Pointer;
      X, Y: Integer;
      Pix: Cardinal;
      RGBQuad: TRGBQuad;
      ScrP: PCardinal;
begin
  if FileExists(AFileName) then begin
   Image := TBitmapEx.Create();
   Image.LoadFromFile(AFileName);
   Image.PixelFormat := pf32bit;
   DXImage.Surface := Factory.CreateLockableTexture;
   DXImage.Surface.MipMapping := False;
   DXImage.Surface.SetSize(Image.Width, Image.Height, False);
    if not DXImage.Surface.Initialize then begin
          Image.Free();
          DXImage.Surface.Free;
          DXImage.Surface := nil;
          Exit;
        end;

        DXImage.Surface.Lock(Bits, Pitch);
        if (Bits = nil) or (Pitch < 1) then
        begin
          Image.Free();
          DXImage.Surface.Free;
          DXImage.Surface := nil;
          Exit;
        end;

        WritePx := Bits;

        for Y := 0 to Image.Height - 1 do begin
          ScrP := Image.ScanLine[Y];
          for X := 0 to Image.Width - 1 do begin
            Pix := PCardinal(Integer(ScrP) + X * 4)^;
            if Pix > 0 then
              Pix := Pix or $FF000000;
            PCardinal(Integer(WritePx) + Y * Pitch + X * 4)^ := Pix;
          end;
        end;

        DXImage.Surface.Unlock();
        Image.Free();
    DXImage.nPx := 0;
    DXImage.nPy := 0;
    //DXImage.Surface.LoadFromFile(AFileName);
  end;
end;

procedure TUIWMImages.AddBitmap(Bitmap: TBitmap);
var DXImage:pTDXImage;
    Image: TBitmapEx;
    Bits: Pointer;
    Pitch: Integer;
    Index: Integer;
    WritePx: Pointer;
    X, Y: Integer;
    Pix: Cardinal;
    RGBQuad: TRGBQuad;
    ScrP: PCardinal;
begin
  m_FileList.Add('');
  DXImage:=@m_ImgArr[ImageCount-1];
  DXImage.Surface := Factory.CreateLockableTexture;
  DXImage.nPx := 0;
  DXImage.nPy := 0;

  Image:=TBitmapEx.Create;
  Image.Assign(Bitmap);

  with DXImage.Surface do
  begin
    if Active then DestroyTexture;
    Image.PixelFormat := pf32bit;

    MipMapping := True;
    SetSize(Image.Width, Image.Height, False);
    if not Initialize then
    begin
      Image.Free();
      Exit;
    end;
    Lock(Bits, Pitch);
    if (Bits = nil) or (Pitch < 1) then
    begin
      Image.Free();
      Exit;
    end;

    WritePx := Bits;
    for Y := 0 to Image.Height - 1 do begin
      ScrP := Image.ScanLine[Y];
      for X := 0 to Image.Width - 1 do begin
        Pix := PCardinal(Integer(ScrP) + X * 4)^;
        if Pix > 0 then
          Pix := Pix or $FF000000;
        PCardinal(Integer(WritePx) + Y * Pitch + X * 4)^ := Pix;
      end;
    end;

    Unlock();
    Image.Free();
    if MipMapping then UpdateMipmaps();
  end;
end;



end.
