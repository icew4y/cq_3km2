unit UiWil;

interface
uses Classes, wmUtil, SysUtils, DIB,DXDraws, Graphics;
type
  TDxImageArr   = array[0..MaxListSize div 4] of TDxImage;
  PTDxImageArr  = ^TDxImageArr;

  TUIWMImages = class
  private
    FImageCount: Integer;
    FDDraw: TDirectDraw;
    procedure LoadAllData;
    procedure LoadImage(Path: string; Index:Integer);
    procedure LoadImage16(Path: string; Index:Integer);
    function  FGetImageSurface (index: integer): TDirectDrawSurface;
  protected
    m_dwMemChecktTick: LongWord;   //0x44
  public
    m_ImgArr    :pTDxImageArr;
    constructor Create (); dynamic;
    destructor Destroy; override;
    procedure Initialize;
    procedure Finalize;
    property DDraw: TDirectDraw read FDDraw write FDDraw;
    property Images[index: Integer]: TDirectDrawSurface read FGetImageSurface;
  end;

implementation
uses ClMain, MShare;

{ TUIWMImages }

constructor TUIWMImages.Create();
begin
  inherited;
  FDDraw := nil;
  m_ImgArr := nil;
  FImageCount := 61;
end;

destructor TUIWMImages.Destroy;
begin
  inherited Destroy;
end;

function TUIWMImages.FGetImageSurface(index: integer): TDirectDrawSurface;
begin
  Result := nil;
  if (index >= 0) and (index < FImageCount) then
   Result := m_ImgArr[index].Surface;
end;

procedure TUIWMImages.Finalize;
var
  I: Integer;
begin
  if FImageCount > 0 then begin
    if m_ImgArr <> nil then begin //20090503
      for i:=0 to FImageCount-1 do begin
        if m_ImgArr[i].Surface <> nil then begin
           m_ImgArr[i].Surface.Free;
           m_ImgArr[i].Surface := nil;
        end;
      end;
      FreeMem(m_ImgArr);
    end;
  end;
end;


procedure TUIWMImages.Initialize;
begin
  if (FDDraw = nil) or (FImageCount = 0)then Exit;
  m_ImgArr:=AllocMem(SizeOf(TDxImage) * FImageCount);
  LoadAllData;
end;

procedure TUIWMImages.LoadAllData;
begin
  LoadImage(g_ParamDir+UiImageDir+'HeroStatusWindow.uib',0);
  LoadImage(g_ParamDir+UiImageDir+'BookBkgnd.uib',1);
  LoadImage(g_ParamDir+UiImageDir+'BookCloseDown.uib',2);
  LoadImage(g_ParamDir+UiImageDir+'BookCloseNormal.uib',3);
  LoadImage(g_ParamDir+UiImageDir+'BookNextPageDown.uib',4);
  LoadImage(g_ParamDir+UiImageDir+'BookNextPageNormal.uib',5);
  LoadImage(g_ParamDir+UiImageDir+'BookPrevPageDown.uib',6);
  LoadImage(g_ParamDir+UiImageDir+'BookPrevPageNormal.uib',7);
  LoadImage(g_ParamDir+BookImageDir+'1\'+'1.uib',8);
  LoadImage(g_ParamDir+BookImageDir+'1\'+'2.uib',9);
  LoadImage(g_ParamDir+BookImageDir+'1\'+'3.uib',10);
  LoadImage(g_ParamDir+BookImageDir+'1\'+'4.uib',11);
  LoadImage(g_ParamDir+BookImageDir+'1\'+'5.uib',12);
  LoadImage(g_ParamDir+BookImageDir+'1\'+'CommandDown.uib',13);
  LoadImage(g_ParamDir+BookImageDir+'1\'+'CommandNormal.uib',14);
  LoadImage(g_ParamDir+BookImageDir+'2\'+'1.uib',15);
  LoadImage(g_ParamDir+BookImageDir+'3\'+'1.uib',16);
  LoadImage(g_ParamDir+BookImageDir+'4\'+'1.uib',17);
  LoadImage(g_ParamDir+BookImageDir+'5\'+'1.uib',18);
  LoadImage(g_ParamDir+BookImageDir+'6\'+'1.uib',19);
  LoadImage(g_ParamDir+MinimapImageDir+'301.mmap',20);
  LoadImage(g_ParamDir+UiImageDir+'vigourbar1.uib',21);
  LoadImage(g_ParamDir+UiImageDir+'vigourbar2.uib',22);
  LoadImage(g_ParamDir+UiImageDir+'BuyLingfuDown.uib',23);
  LoadImage(g_ParamDir+UiImageDir+'BuyLingfuNormal.uib',24);
  LoadImage(g_ParamDir+MinimapImageDir+'302.mmap',25);
  LoadImage(g_ParamDir+MinimapImageDir+'303.mmap',26);
  LoadImage(g_ParamDir+MinimapImageDir+'304.mmap',27);
  LoadImage(g_ParamDir+MinimapImageDir+'306.mmap',28);
  LoadImage(g_ParamDir+UiImageDir+'StateWindowHuman.uib',29);
  LoadImage(g_ParamDir+UiImageDir+'StateWindowHero.uib',30);
  LoadImage(g_ParamDir+UiImageDir+'GloryButton.uib',31);
  LoadImage(g_ParamDir+MinimapImageDir+'307.mmap',32);
  LoadImage(g_ParamDir+MinimapImageDir+'308.mmap',33);
  LoadImage(g_ParamDir+MinimapImageDir+'309.mmap',34);
  LoadImage(g_ParamDir+MinimapImageDir+'310.mmap',35);
  LoadImage(g_ParamDir+MinimapImageDir+'311.mmap',36);
  LoadImage(g_ParamDir+MinimapImageDir+'312.mmap',37);
  LoadImage(g_ParamDir+MinimapImageDir+'313.mmap',38);
  LoadImage(g_ParamDir+MinimapImageDir+'314.mmap',39);
  LoadImage(g_ParamDir+MinimapImageDir+'315.mmap',40);
  LoadImage(g_ParamDir+MinimapImageDir+'316.mmap',41);
  LoadImage(g_ParamDir+MinimapImageDir+'317.mmap',42);
  LoadImage(g_ParamDir+MinimapImageDir+'318.mmap',43);
  LoadImage(g_ParamDir+MinimapImageDir+'319.mmap',44);
  LoadImage(g_ParamDir+MinimapImageDir+'320.mmap',45);
  LoadImage(g_ParamDir+MinimapImageDir+'321.mmap',46);
  LoadImage(g_ParamDir+MinimapImageDir+'322.mmap',47);
  LoadImage(g_ParamDir+MinimapImageDir+'323.mmap',48);
  LoadImage(g_ParamDir+MinimapImageDir+'324.mmap',49);
  LoadImage(g_ParamDir+MinimapImageDir+'325.mmap',50);
  LoadImage(g_ParamDir+MinimapImageDir+'326.mmap',51);
  LoadImage(g_ParamDir+MinimapImageDir+'327.mmap',52);
  LoadImage(g_ParamDir+MinimapImageDir+'328.mmap',53);
  LoadImage(g_ParamDir+MinimapImageDir+'329.mmap',54);
  LoadImage(g_ParamDir+MinimapImageDir+'330.mmap',55);
  LoadImage(g_ParamDir+MinimapImageDir+'402.mmap',56);
  LoadImage(g_ParamDir+MinimapImageDir+'3021.mmap',57);
  LoadImage16(g_ParamDir+MinimapImageDir+'3022.mmap',58);
  LoadImage(g_ParamDir+MinimapImageDir+'3023.mmap',59);
  LoadImage(g_ParamDir+MinimapImageDir+'331.mmap',60);
end;

procedure TUIWMImages.LoadImage(Path: string; Index:Integer);
var
   dximg: TDxImage;
   dib: TDIB;
begin
if (index >= 0) and (index < FImageCount) then
  if FileExists(Path) then begin
    dib := TDIB.Create;
    try
      dib.Clear;
      dib.BitCount := 8;
      dib.ColorTable := frmMain.DxDraw.ColorTable;
      dib.UpdatePalette;
      dib.LoadFromFile(PChar(Path));
      dximg.surface := TDirectDrawSurface.Create (FDDraw);
      dximg.surface.SystemMemory := True;
      dximg.surface.SetSize (dib.Width, dib.Height);
      dximg.Surface.Canvas.Draw(0,0,dib);
      dximg.surface.Canvas.Release;
      m_ImgArr[Index] := dximg;
      //FreeAndNil(dximg.surface); //20080719Ìí¼Ó
    finally
      FreeAndNil(dib);
    end;
  end;
end;

procedure TUIWMImages.LoadImage16(Path: string; Index: Integer);
var
   dximg: TDxImage;
   dib: TDIB;
begin
if (index >= 0) and (index < FImageCount) then
  if FileExists(Path) then begin
    dib := TDIB.Create;
    try
      {dib.Clear;
      try
        with dib.PixelFormat do begin
          RBitMask:=$FF0000;
          GBitMask:=$00FF00;
          BBitMask:=$0000FF;
        end;
        dib.BitCount := 16;
      except
      end;
      dib.ColorTable := g_WMainImages.MainPalette;
      dib.UpdatePalette;  }
      dib.LoadFromFile(PChar(Path));
      dximg.surface := TDirectDrawSurface.Create (FDDraw);
      dximg.surface.SystemMemory := True;
      dximg.surface.SetSize (dib.Width, dib.Height);
      dximg.Surface.Canvas.Draw(0,0,dib);
      dximg.surface.Canvas.Release;
      m_ImgArr[Index] := dximg;
      //FreeAndNil(dximg.surface); //20080719Ìí¼Ó
    finally
      FreeAndNil(dib);
    end;
  end;
end;

end.
