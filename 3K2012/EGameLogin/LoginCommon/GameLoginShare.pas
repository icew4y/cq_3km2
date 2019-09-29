unit GameLoginShare;

interface
uses Classes, Common, Graphics, EncdDecd, Controls, RzBmpBtn, RzCommon;
resourcestring
  sSkinHeaderDesc = '3k登陆器皮肤文件';
const
  Testing = 0;
  JPEG_FLAG1 = $CBDA; //14848
  JPEG_FLAG2 = $0951; //10656
  JPEG_FLAG3 = $4DB2; //15104
  JPEG_FLAG4 = $5D70; //15360
  JPEG_FLAG5 = $A61C; //15552

type
  T3KControlVisible = record
    TreeView: Boolean;
    ComboBox1: Boolean;
    //Btn
    MinimizeBtn: Boolean;
    CloseBtn: Boolean;
    StartButton: Boolean;
    ButtonHomePage: Boolean;
    RzBmpButton1: Boolean;
    RzBmpButton2: Boolean;
    ButtonNewAccount: Boolean;
    ButtonChgPassword: Boolean;
    ButtonGetBackPassword: Boolean;
    ImageButtonClose: Boolean;
    //BtnEnd
    RzCheckBox1: Boolean;
    RzCheckBoxFullScreen: Boolean;
    RzLabelStatus: Boolean;
    RzComboBox1: Boolean;
    WebBrowser1: Boolean;
    RzProgressBar1: Boolean;
    RzProgressBar2: Boolean;
    ProgressBarCurDownload: Boolean;
    ProgressBarAll: Boolean;
  end;

  TSkinFileHeader = packed record
    sDesc: string[$10]; //16
    boServerList: Boolean; //是否为TreeView
    boProgressBarDown: Boolean;
    boProgressBarAll: Boolean;
    boFrmTransparent: Boolean; //窗体是否透明
    ControlVisible: T3KControlVisible; //控件是否可见
    dCreateDate: TDateTime;  
  end;
  pTSkinFileHeader = ^TSkinFileHeader;

  T3KBase = record
    Left: Integer;
    Top: Integer;
    Width: Integer;
    Height: Integer;
    //Visible: Boolean;
  end;

  T3KFont = record
    Charset: TFontCharset;
    Color: TColor;
    Height: Integer;
    NameLen: Integer;
    Pitch: TFontPitch;
    Size: Integer;
    Style: TFontStyles;
  end;

  T3KBitMaps = record
    UpLen: Integer;
    DownLen: Integer;
    HotLen: Integer;
    DisabledLen: Integer;
  end;
//--控件
  T3KBImage = record
    ImageLen: Integer;
  end;
  T3KTreeView = record
    Base: T3KBase;
    Font: T3KFont;
    Color: TColor;
  end;
  T3KButton = record
    Base: T3KBase;
    BitMaps: T3KBitMaps;
  end;
  T3KCheckBox = record
    Base: T3KBase;
    Font: T3KFont;
    FrameColor: TColor;
    HotTrackColor: TColor;
  end;
  T3KLabel = record
    Base: T3KBase;
    Font: T3KFont;
    Color1: TColor;  //连接成功颜色
    Color2: TColor;  //连接失败颜色
  end;
  T3KCombobox = record
    Base: T3KBase;
    Font: T3KFont;
    bColor: TColor; //背景颜色
  end;
  T3KRzCombobox = record
    Base: T3KBase;
    Font: T3KFont;
    bColor: TColor;
    FrameColor: TColor;
  end;
  T3KWebBrowser = record
    Base: T3KBase;
  end;
  T3KImageProgressBar = record
    Base: T3KBase;
    BarImageLen: Integer;
    BfBarImageLen: Integer;
  end;
  T3KRzProgressBar = record
    Base: T3KBase;
    BarStyle: TBarStyle;
    BackColor: TColor;
    FlatColor: TColor;
    BarColor: TColor;
  end;
function MakeBitmapIntoString(const sInfo:TGraphic):string;
function MakeStringIntoBitmap(const sBitmapString:String): TStringStream;
function WriteGuiBase(Sender: TObject): T3KBase;
procedure ReadGuiBase(ABase: T3KBase; Sender: TObject);
function WriteGuiFont(AFont: TFont): T3KFont;
procedure ReadGuiFont(AFont: T3KFont; BFont: TFont);
procedure WriteGuiBitMaps(FileStream: TFileStream; Btn: TRzButtonBitmaps; bfBtn: T3KButton);
procedure ReadGuiBitMaps(FileStream: TMemoryStream; ABitMaps: T3KBitMaps; BitMaps: TRzButtonBitmaps);

const
  FilterItemNameList ={'FilterItemNameList.dat'}'Ifc{j}F{jbAnbjCf|{!kn{'; //20100625 修改
  TzHintList = {'TzHintList.txt'}'[uGfa{Cf|{!{w{'; //20100625 修改
  BakFileName = '56Dlq.Bak'; //自身更新前备份的文件名
  //UpDateFile = 'QkUpdate.lis';
  //0为测试  1为正式
  GVersion = 1;
  g_SdoVer = 2013;

//字符串加解密函数 20071225
Function SetDate(Text: String): String;
  
var
  {$if GVersion = 1}
  g_boGameMon: Boolean;
  g_GameListURL        : string;
  g_GameMonListURL     : string;
  g_PatchListURL       : string;
  {$ifend}
  LnkName, GameESystemURL,BakGameListURL, GameMonListURL,{$if GVersion = 1}g_sGameListURL,{$ifend} ClientFileName:String;
  m_SelServerInfo : pTServerInfo = nil;
  code: byte = 1;
  g_sMirPath: string = '';//传奇游戏目录
  g_sExeName: string;
  g_boUseFD : Boolean;
  g_sGatePass: string; 
  g_boIsUpdateSelf: Boolean = False; //是否更新自身
  g_boGatePassWord: Boolean = False; //是否通过封包码的验证
  g_sGatePassWord: string = '';
  MyRecInfo: TRecInfo;
  g_sClassName: string;
  m_sLocalGameListName: string;
  g_sCaptionName: string;
  g_ConnectLabelColor: TColor = clLime;
  g_NormalLabelColor: TColor = $0040BBF1;
  g_DisconnectLabelColor: TColor = clRed;
  g_FileHeader: TSkinFileHeader;
  g_Except : TStringList;
implementation


//字符串加解密函数 20071225
Function SetDate(Text: String): String;
Var
  I     :Word;
  C     :Word;
Begin
  Result := '';
  For I := 1 To Length(Text) Do Begin
    C := Ord(Text[I]);
    Result := Result + Chr((C Xor 15));
  End;
End;

function MakeBitmapIntoString(const sInfo:TGraphic):string;
var
  ass:TStringStream;
begin
  ass:=TStringStream.Create('');
  try
    sInfo.SaveToStream(ass);
    Result:=EncodeString(ass.DataString);
  finally
    ass.Free;
  end;
end;

function MakeStringIntoBitmap(const sBitmapString:String): TStringStream;
begin
  Result:=TStringStream.Create(DecodeString(sBitmapString));
end;

function WriteGuiBase(Sender: TObject): T3KBase;
begin
  Result.Left := TWinControl(Sender).Left;
  Result.Top := TWinControl(Sender).Top;
  Result.Width := TWinControl(Sender).Width;
  Result.Height := TWinControl(Sender).Height;
//  Result.Visible := TWinControl(Sender).ShowHint;
end;

procedure ReadGuiBase(ABase: T3KBase; Sender: TObject);
begin
  TWinControl(Sender).Left := ABase.Left;
  TWinControl(Sender).Top := ABase.Top;
  TWinControl(Sender).Width := ABase.Width;
  TWinControl(Sender).Height := ABase.Height;
//  TWinControl(Sender).ShowHint := ABase.Visible;
end;

function WriteGuiFont(AFont: TFont): T3KFont;
begin
  Result.Charset := AFont.Charset;
  Result.Color := AFont.Color;
  Result.Height := AFont.Height;
  Result.NameLen := Length(AFont.Name);
  Result.Pitch := AFont.Pitch;
  Result.Size := AFont.Size;
  Result.Style := AFont.Style;
end;

procedure ReadGuiFont(AFont: T3KFont; BFont: TFont);
begin
  BFont.Charset := AFont.Charset;
  BFont.Color := AFont.Color;
  BFont.Height := AFont.Height;
  BFont.Pitch := AFont.Pitch;
  BFont.Size := AFont.Size;
  BFont.Style := AFont.Style;
end;

procedure WriteGuiBitMaps(FileStream: TFileStream; Btn: TRzButtonBitmaps; bfBtn: T3KButton);
var
  sUp, sDown, sHot, sDisabled: string; //Btn
begin
  if Btn.Up <> nil then begin
    sUp := MakeBitmapIntoString(Btn.Up);
    bfBtn.BitMaps.UpLen := Length(sUp);
  end;
  if Btn.Down <> nil then begin
    sDown := MakeBitmapIntoString(Btn.Down);
    bfBtn.BitMaps.DownLen := Length(sDown);
  end;
  if Btn.Hot <> nil then begin
    sHot := MakeBitmapIntoString(Btn.Hot);
    bfBtn.BitMaps.HotLen := Length(sHot);
  end;
  if Btn.Disabled <> nil then begin
    sDisabled := MakeBitmapIntoString(Btn.Disabled);
    bfBtn.BitMaps.DisabledLen := Length(sDisabled);
  end;
  FileStream.Write(bfBtn, SizeOf(T3KButton));
  if bfBtn.BitMaps.UpLen > 0 then begin
    FileStream.Write(sUp[1], bfBtn.BitMaps.UpLen);
  end;
  if bfBtn.BitMaps.DownLen > 0 then begin
    FileStream.Write(sDown[1], bfBtn.BitMaps.DownLen);
  end;
  if bfBtn.BitMaps.HotLen > 0 then begin
    FileStream.Write(sHot[1], bfBtn.BitMaps.HotLen);
  end;
  if bfBtn.BitMaps.DisabledLen > 0 then begin
    FileStream.Write(sDisabled[1], bfBtn.BitMaps.DisabledLen);
  end;
end;

procedure ReadGuiBitMaps(FileStream: TMemoryStream; ABitMaps: T3KBitMaps; BitMaps: TRzButtonBitmaps);
var
  sText: string;
begin
  if ABitMaps.UpLen > 0 then begin
    SetLength(sText, ABitMaps.UpLen);
    FileStream.Read(sText[1], ABitMaps.UpLen);
    Bitmaps.Up.LoadFromStream(MakeStringIntoBitmap(sText));
    MakeStringIntoBitmap(sText).Free;
    SetLength(sText, 0);
  end;
  if ABitMaps.DownLen > 0 then begin
    SetLength(sText, ABitMaps.DownLen);
    FileStream.Read(sText[1], ABitMaps.DownLen);
    Bitmaps.Down.LoadFromStream(MakeStringIntoBitmap(sText));
    MakeStringIntoBitmap(sText).Free;
    SetLength(sText, 0);
  end;
  if ABitMaps.HotLen > 0 then begin
    SetLength(sText, ABitMaps.HotLen);
    FileStream.Read(sText[1], ABitMaps.HotLen);
    Bitmaps.Hot.LoadFromStream(MakeStringIntoBitmap(sText));
    MakeStringIntoBitmap(sText).Free;
    SetLength(sText, 0);
  end;
  if ABitMaps.DisabledLen > 0 then begin
    SetLength(sText,ABitMaps.DisabledLen);
    FileStream.Read(sText[1], ABitMaps.DisabledLen);
    Bitmaps.Disabled.LoadFromStream(MakeStringIntoBitmap(sText));
    MakeStringIntoBitmap(sText).Free;
    SetLength(sText, 0);
  end;
end;

end.

