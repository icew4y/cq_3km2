unit DrawScrn;//DrawScrn,其实更准确地说是DrawScrn-txt,,,,整个场景的实际绘图工作已经在introscrn.pas和playscrn.pas中完成了
//场景管理器
interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, uAspDListView, uAspDChatMemo,
  AbstractCanvas, AbstractTextures, AsphyreTextureFonts, IntroScn, Actor, 
  HUtil32,Grobal2,Vectors2,AsphyreTypes;


const
   //VIEWCHATLINE = 9;//9行文本输入框
   AREASTATEICONBASE = 150;//area state icon base Prguse.wil中150战斗151安全
   HEALTHBAR_BLACK = 0;//Prguse3.wil中
   HEALTHBAR_RED = 1; //Prguse3.wil中


type
//走马灯
  PBoardStyle=^TBoardStyle;
  TBoardStyle=Record
     FColor:Integer;
     BColor:Integer;
     Time :Integer;
     Createtime:Integer;
  end;
//底部消息
  PBottomSysStyle=^TBottomSysStyle;
  TBottomSysStyle=Record
     FColor:Integer;
     Createtime:LongWord;
  end;
//右下消息
  PRightBottomSysStyle=^TRightBottomSysStyle;
  TRightBottomSysStyle=Record
     FColor: Integer;
     BColor: Integer;
     Createtime:LongWord;
     ShowTime: LongWord;
  end;
//聊天栏顶部消息
  TTopChat=record
    FColor :Integer;
    BColor :Integer;
    Time   :LongWord;
  end;
  pTopChat=^TTopChat;

  TMoveTopStrShow = packed record
    sMoveStr    :string;
    btMoveNil   :Byte;
    nMoveStrEnd     :Integer;
    btMoveAlpha     :Byte;
    boMoveStrShow   :Boolean;
    btFColor: Byte; //前景色
    btBColor: Byte; //背景色
    dwMoveStrTick   :LongWord;
  end;
  pTMoveTopStrShow= ^TMoveTopStrShow;

//走马灯

  TMoveMsg = record
    Text: string;
    FColor, BColor: Byte;
    Count: Integer;
    X, Y: Integer;
  end;
  pTMoveMsg = ^TMoveMsg;

  TDrawScreenMoveMsg = class
    m_MsgList: TList;
    m_nCurrMoveMsg: pTMoveMsg;
    m_dwMoveTick: LongWord;
  private
    FTextWidth, FLeft, FOffSetX, FLen, FX, FY: Integer;
    DestRect: TRect;
    SrcRect: TRect;
    function GetTop: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(sMsg: string; FColor, BColor: Byte; nX, nY, nCount: Integer);
    procedure Draw(MSurface: TAsphyreCanvas);
    property Top: Integer read GetTop;
    procedure Initialize;
    procedure Finalize;
  end;

   TDrawScreen = class
   private
      m_dwFrameTime       :LongWord;
      //m_dwFrameCount      :LongWord;
      //m_dwDrawFrameCount  :LongWord;
      m_SysMsgList        :TStringList;
      m_SysMsgListBottom  :TStringList; //下面提示
      m_SysMsgListRightBottom: TStringList; //右下提示
      m_MoveMsgList: TList;

       //滚动消息
      m_SysBoard:TStringList;
      m_SysBoardIndex: Integer;
      m_SysBoardxPos :Integer;
      m_SysBoardTime: LongWord;
      function GetShowItemName(DropItem: pTDropItem): Pointer; overload;
   public
      CurrentScene: TScene;       //当前场景
      ChatStrs: TStringList;      //聊天内容
      TopChatStrs: TStringList;   //顶部聊天内容
      ChatBks: TList;             //对应的背景色
      ChatBoardTop: integer;

      HintList: TStringList;      //提示信息列表
      HintX, HintY, HintWidth, HintHeight: integer;
      HintUp: Boolean;
      HintDec: Boolean;
      HintColor: TColor;

      TzHintList: TStringList;      //套装提示信息列表
      SpecialHintList: TStringList;  //特殊提示信息列表

      HintTzItemWidth, HintTzItemHeight: integer;
      TzItemHintList: TStringList;      //套装物品信息列表
      //聊天栏上面的倒记时变量
      m_boCountDown: Boolean;  //是否显示
      m_SCountDown :string; //显示内容
      m_CountDownForeGroundColor :Integer;
      m_dwCountDownTimeTick :longWord;
      m_dwCountDownTimer :longWord;
      m_dwCountDownTimeTick1 :longWord;
      //副将英雄复仇模式
      m_boHeroCountDown: Boolean; //英雄复仇模式是否显示
      m_SHeroCountDown :string; //显示内容
      m_HeroCountDownForeGroundColor :Integer;
      m_dwHeroCountDownTimeTick :longWord;
      m_dwHeroCountDownTimer :longWord;
      m_dwHeroCountDownTimeTick1 :longWord;

      m_MoveTopStrList: TList;

      constructor Create;
      destructor Destroy; override;
      procedure KeyPress (var Key: Char);
      procedure KeyDown (var Key: Word; Shift: TShiftState);
      procedure MouseMove (Shift: TShiftState; X, Y: Integer);
      procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      procedure Initialize;
      procedure Finalize;
      procedure ChangeScene (scenetype: TSceneType);
      procedure DrawScreen (MSurface: TAsphyreCanvas);
      procedure DrawScreenTop (MSurface: TAsphyreCanvas);
      procedure Draw3km2Help (MSurface: TAsphyreCanvas);
      procedure AddSysMsg (msg: string);
      procedure AddBottomSysMsg (msg: string; btType:Byte);
      procedure AddRightBottomMsg(fcolor, bcolor: Integer; dWTime:LongWord; msg: string);  //右下消息
      procedure AddSysBoard(msg: string;FColor,BColor,Time:Integer);
      procedure AddChatTopString (str: string; fcolor, bcolor: Integer); //添加聊天栏顶部信息
      procedure DelChatTopString();//清除超时顶部聊天信息
      procedure AddChatBoardString (str: string; fcolor, bcolor: integer);
      procedure ClearChatBoard;
      procedure AddMoveMsg(sMsg: string; FColor, BColor: Byte; nX, nY, nCount: Integer);
      procedure DrawScreenBoard(MSurface: TAsphyreCanvas);//走马灯
      procedure AddCenterLetter(ForeGroundColor,BackGroundColor,Timer:Integer; CenterLetter:string);
      procedure DrawScreenCenterLetter(MSurface: TAsphyreCanvas);//屏幕中间显示文字消息
      procedure DrawScreenTopLetter(MSurface: TAsphyreCanvas); //屏幕顶部渐变显示文字效果
      procedure AddTopLetter(ForeGroundColor,BackGroundColor:Byte; CenterLetter:string);
      procedure AddCountDown(ForeGroundColor:Integer;Timer:LongWord;CountDown:string);//添加在屏幕中间显示文字消息
      procedure AddHeroCountDown(ForeGroundColor:Integer;Timer:LongWord;CountDown:string);//添加在屏幕中间显示英雄复仇文字消息
      procedure DrawScreenCountDown(MSurface: TAsphyreCanvas);//显示聊天栏上面的倒记时
      //**显示提示信息**
      procedure DrawHint (MSurface: TAsphyreCanvas);
      procedure ShowHint (x, y: integer; str: string; color: TColor; drawup: Boolean);
      procedure ClearHint;
      //**显示套装信息**
      procedure DrawTzHint (MSurface: TAsphyreCanvas);
      procedure ShowTzHint (x, y: integer; str: string; drawup, HintDec: Boolean; nWidth: Byte{新加宽度});
      //**特殊提示信息**
      procedure DrawSpecialHint (MSurface: TAsphyreCanvas);
      procedure ShowSpecialHint (x, y: integer; str: string; drawup: Boolean);


      //显示套装属性框
      procedure DrawTzItemHint(MSurface: TAsphyreCanvas; var X,Y, W, H : Integer);
      procedure ShowTzItemHint(str: string);

      procedure DrawMove(MSurface: TAsphyreCanvas);
   end;


implementation
uses
   ClMain, MShare, Share, FState, uMyDxUnit;

var
  g_dHPImages: TAsphyreLockableTexture;
  g_dMyHPImages: TAsphyreLockableTexture;
  g_dMPImages: TAsphyreLockableTexture;
  g_dNewMPImages : TAsphyreLockableTexture; // 新的护身戒指显示的蓝色血条
  g_dKill69Images: TAsphyreLockableTexture;
constructor TDrawScreen.Create;
begin
   CurrentScene := nil;
   m_dwFrameTime := GetTickCount;
  // m_dwFrameCount := 0;
   m_SysMsgList := TStringList.Create;
   m_SysMsgListBottom := TStringList.Create;
   m_SysMsgListRightBottom := TStringList.Create;
   m_SysBoard:=TStringList.Create;//初始化走马灯列表
   ChatStrs := TStringList.Create;
   TopChatStrs := TStringList.Create;
   ChatBks := TList.Create;
   //走马灯
   m_SysBoardIndex:=0;
   m_SysBoardxPos:=800;
   //走马灯
   ChatBoardTop := 0;
   m_MoveMsgList := TList.Create;
   HintList := TStringList.Create;

   TzHintList := TStringList.Create;
   SpecialHintList := TStringList.Create;
   TzItemHintList := TStringList.Create;
   m_MoveTopStrList := TList.Create;
   m_boCountDown := False;  //是否显示
   m_boHeroCountDown := False;
end;

destructor TDrawScreen.Destroy;
var
  I: Integer;
begin
  m_SysMsgList.Free;
  m_SysMsgListBottom.Free;
  m_SysMsgListRightBottom.Free;
  m_SysBoard.Free;//走马灯列表
  ChatStrs.Free;
  TopChatStrs.Free;
  ChatBks.Free;
  HintList.Free;
  TzHintList.Free;
  TzItemHintList.Free;
  SpecialHintList.Free;
  for I := 0 to m_MoveMsgList.Count - 1 do begin
    TDrawScreenMoveMsg(m_MoveMsgList.Items[I]).Free;
  end;
  m_MoveMsgList.Free;
  for I:=0 to m_MoveTopStrList.Count-1 do begin
    Dispose(pTMoveTopStrShow(m_MoveTopStrList.Items[I]));
  end;
  FreeAndNil(m_MoveTopStrList);
  inherited Destroy;
end;

procedure TDrawScreen.Initialize;
begin
  {g_dHPImages := NewMyTexture(MyTexture_HP);
  g_dMyHPImages := NewMyTexture(MyTexture_MyHP);
  g_dMPImages := NewMyTexture(MyTexture_MP);
  g_dNewMPImages := NewMyTexture(MyTexture_NewMP);
  g_dKill69Images := NewMyTexture(MyTexture_Kill69);  }
end;

procedure TDrawScreen.Finalize;
begin
  if g_dHPImages <> nil then
    FreeAndNil(g_dHPImages);
  if g_dMyHPImages <> nil then
    FreeAndNil(g_dMyHPImages);
  if g_dMPImages <> nil then
    FreeAndNil(g_dMPImages);
  if g_dNewMPImages <> nil then
    FreeAndNil(g_dNewMPImages);
  if g_dKill69Images <> nil then
    FreeAndNil(g_dKill69Images);
end;

procedure TDrawScreen.KeyPress (var Key: Char);
begin
   if CurrentScene <> nil then
      CurrentScene.KeyPress (Key);
end;

procedure TDrawScreen.KeyDown (var Key: Word; Shift: TShiftState);
begin
   if CurrentScene <> nil then
      CurrentScene.KeyDown (Key, Shift);
end;

procedure TDrawScreen.MouseMove (Shift: TShiftState; X, Y: Integer);
begin
   if CurrentScene <> nil then
      CurrentScene.MouseMove (Shift, X, Y);
end;

procedure TDrawScreen.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if CurrentScene <> nil then
      CurrentScene.MouseDown (Button, Shift, X, Y);
end;

procedure TDrawScreen.ChangeScene (scenetype: TSceneType);
begin
   if CurrentScene <> nil then
      CurrentScene.CloseScene;
   case scenetype of
      stIntro:  CurrentScene := IntroScene;
      stLogin:  CurrentScene := LoginScene;
      stSelectCountry:  ;
      stSelectChr: CurrentScene := SelectChrScene;
      stNewChr:     ;
      stLoading:    ;
      stLoginNotice: begin
        CurrentScene := LoginNoticeScene;
        LoginNoticeScene.dwOpenTick := GetTickCount;
      end;
      stPlayGame: CurrentScene := PlayScene;
   end;
   if CurrentScene <> nil then
      CurrentScene.OpenScene;
end;
//添加系统信息
procedure TDrawScreen.AddSysMsg (msg: string);
begin
   if m_SysMsgList.Count >= 10 then m_SysMsgList.Delete (0);
   m_SysMsgList.AddObject (msg, TObject(GetTickCount));
end;
//添加下面系统信息
//参数btType  0：前景为红色  1：前景为黄色
procedure TDrawScreen.AddBottomSysMsg (msg: string; btType:Byte);
var
  BottomSysStyle:PBottomSysStyle;
begin
  if m_SysMsgListBottom.Count >= 10 then m_SysMsgListBottom.Delete (0);
  New(BottomSysStyle);
  BottomSysStyle^.Createtime := GetTickCount;
  if btType = 0 then BottomSysStyle^.FColor := clRed
  else if btType = 1 then BottomSysStyle^.FColor := clYellow;
  m_SysMsgListBottom.AddObject(msg, TObject(BottomSysStyle));
end;

//添加信息到走马灯列表    2007.11.11
procedure TDrawScreen.AddSysBoard(msg: string;FColor,BColor,Time:Integer);
var
  Boardstyle:PBoardStyle;
begin
  if m_SysBoard.Count >= 10 then begin
    Boardstyle:=PBoardStyle(m_SysBoard.Objects[0]);
    DisPose(Boardstyle);
    m_SysBoard.Delete(0);
  end;
  New(Boardstyle);
  Boardstyle^.FColor:=FColor;
  Boardstyle^.BColor:=Bcolor;
  Boardstyle^.Time:=Time;
  Boardstyle^.Createtime:=0;
  m_SysBoard.AddObject(msg, TObject(Boardstyle));
end;
//清除超时顶部聊天信息
procedure TDrawScreen.DelChatTopString();
var
  I: Integer;
  ViewItem: pTViewItem;
begin
  for I := FrmDlg.DChatMemo.TopLines.Count - 1 downto 0 do begin 
    ViewItem := TAspDChatMemoLines(FrmDlg.DChatMemo.TopLines).Items[I];
    if GetTickCount > ViewItem.TimeTick then begin
      FrmDlg.DChatMemo.DeleteTop(I);
    end;
  end;
end;

//添加聊天栏顶部信息
procedure TDrawScreen.AddChatTopString (str: string; fcolor, bcolor: Integer);
begin
  FrmDlg.DChatMemo.AddTop(str, fcolor, bcolor, 45);
end;

//添加信息聊天板
procedure TDrawScreen.AddChatBoardString (str: string; fcolor, bcolor: integer);
begin
  FrmDlg.DChatMemo.Add(str, fcolor, bcolor);
end;

//鼠标放在某个物品上显示的信息    2007.10.21
procedure TDrawScreen.ShowHint (x, y: integer; str: string; color: TColor; drawup: Boolean);
var
   data: string;
   w: integer;
begin
   ClearHint;
   HintX := x;
   HintY := y;
   HintWidth := 0;
   HintHeight := 0;
   HintUp := drawup;
   HintColor := color;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, ['\']);
      w := AspTextureFont.TextWidth (data) + 4{咯归} * 2;
      if w > HintWidth then HintWidth := w;
      if data <> '' then HintList.Add (data)
   end;
   HintHeight := (AspTextureFont.TextHeight('A') + 1) * HintList.Count + 3{咯归} * 2;
   if HintUp then
      HintY := HintY - HintHeight;
end;
//清除鼠标放在某个物品上显示的信息    2007.10.21
procedure TDrawScreen.ClearHint;
begin
  if HintList.Count > 0 then HintList.Clear;
  if TzHintList.Count > 0 then TzHintList.Clear;
  if SpecialHintList.Count > 0 then SpecialHintList.Clear;
  TzItemHintList.Clear;
end;

procedure TDrawScreen.ClearChatBoard;
var
  DrawScreenMoveMsg: TDrawScreenMoveMsg;
  I: Integer;
begin
  for I := 0 to m_MoveMsgList.Count - 1 do begin
    DrawScreenMoveMsg := TDrawScreenMoveMsg(m_MoveMsgList.Items[I]);
    DrawScreenMoveMsg.Free;
  end;
  m_MoveMsgList.Clear;
   m_SysMsgList.Clear;
   m_SysMsgListBottom.Clear;
   m_SysMsgListRightBottom.Clear;
   ChatStrs.Clear;
   TopChatStrs.Clear;
   ChatBks.Clear;
   ChatBoardTop := 0;
end;


procedure TDrawScreen.DrawScreen (MSurface: TAsphyreCanvas);

  procedure NameTextOut (actor: TActor; surface: TAsphyreCanvas; x, y, fcolor, bcolor: integer; namestr: string);
  var
    i, row: integer;
    nstr: string;
    nfcolor: Integer;
  begin
    row := 0;
    for i:=0 to 10 do begin
      if namestr = '' then break;
      namestr := GetValidStr3 (namestr, nstr, ['\']);
      if Pos('(可探索)',nstr) > 0 then nfcolor := $005AC663 else nfcolor := fcolor;
      AspTextureFont.BoldTextOut (x - AspTextureFont.TextWidth(nstr) div 2,
                  y + row * 12, nstr, nfcolor, bcolor);
      Inc (row);
    end;
  end;

var
  I, K: integer;
  actor: TActor;
  uname: string;
  d: TAsphyreLockableTexture;
  rc: TRect;
  infoMsg :String;
  DropItem: PTDropItem;
  ShowItem: pTShowItem1;
  mx,my:integer;
  ItemColor: TColor;
  {$IF M2Version <> 2}
  II: Integer;
  MoveShow: pTMoveHMShow;
  TitleWidth: Word;
  {$IFEND}
  MoveHP:pTMoveHP;
begin
  //MSurface.Fill(0);
  if CurrentScene <> nil then CurrentScene.PlayScene (MSurface);
  if g_MySelf = nil then Exit;


  if CurrentScene = PlayScene then begin
    with MSurface do begin
      with PlayScene do begin
        if g_DropedItemList.Count > 0 then begin
          for k:=0 to g_DropedItemList.Count-1 do begin
            DropItem := PTDropItem (g_DropedItemList[k]);
            if DropItem <> nil then begin
              if (abs(g_MySelf.m_nCurrX - DropItem.X) >= 9) or (abs(g_MySelf.m_nCurrY - DropItem.Y) >= 7) then Continue;
              ShowItem := GetShowItemName(DropItem);
              if (ShowItem <> nil) and (ShowItem.boHintMsg or ShowItem.boShowName or g_boShowAllItem) then begin
                if ShowItem.boHintMsg then
                  ItemColor := clRed
                else ItemColor := clSkyBlue;
                ScreenXYfromMCXY(DropItem.X, DropItem.Y, mx, my);
                AspTextureFont.BoldTextOut(mx - 15, my - 19, DropItem.Name, ItemColor, clBlack);
              end else if g_boShowAllItem or (ShowItem = nil) then begin
                ScreenXYfromMCXY(DropItem.X, DropItem.Y, mx, my);
                AspTextureFont.BoldTextOut(mx - 15, my - 19, DropItem.Name, clSkyBlue, clBlack);
              end;
            end;
          end;
        end;

        if m_ActorList.Count > 0 then begin//20080629
          for k:=0 to m_ActorList.Count-1 do begin  //画出每一个人物的状态
            actor := m_ActorList[k];
            {$IF M2Version <> 2}
            //显示移动HP
            II:=0;
            with actor do begin
              while TRUE do begin
                if II >=m_nMoveHpList.Count then break;
                MoveShow:=m_nMoveHpList.Items[II];
                if MoveShow.boMoveHpShow then begin
                  FontManager.SetFont(g_sCurFontName, 11);
                  AspTextureFont.BoldTextOut(m_nSayX + MoveShow.nMoveHpEnd, m_nSayY - MoveShow.nMoveHpEnd-30, clRed, clBlack, MoveShow.sMoveHpstr);
                  FontManager.SetFont(g_sCurFontName, 9);
                  if (GetTickCount-MoveShow.dwMoveHpTick) > 30 then begin
                    MoveShow.dwMoveHpTick:=GetTickCount;
                    Inc(MoveShow.nMoveHpEnd);
                  end;
                  if MoveShow.nMoveHpEnd > 20 then begin
                    MoveShow.boMoveHpShow:=False;
                    m_nMoveHpList.Delete(II);
                    Dispose(MoveShow);
                  end else Inc(II);
                end;
              end;
            end;
            {$IFEND}

            //显示人物血量(数字显示)
            if (actor.m_Abil.MaxHP > 1) and not actor.m_boDeath then
            begin
              if actor = g_HeroSelf then begin   //在次修正英雄资料消失 2008.01.27
                if (abs(g_MySelf.m_nCurrX - g_HeroSelf.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - g_HeroSelf.m_nCurrY) <= 7) then
                begin
                  //if (THumActor(actor).m_HumProps[0]>0) and (actor.m_Abil.MP>0) then
                  //  InfoMsg:=Format('%d/%d',[actor.m_Abil.MP,actor.m_Abil.MaxMP]) else
                  InfoMsg:=Format('%d/%d',[actor.m_Abil.HP,actor.m_Abil.MaxHP]);
                  AspTextureFont.BoldTextOut (actor.m_nSayX - AspTextureFont.TextWidth(infoMsg) div 2 ,actor.m_nSayY - 22, infoMsg, clWhite, clBlack);
                end;
              end else
              begin
                //、、if (actor is THumActor) then
                //begin
                {  InfoMsg:=Format('%d/%d',[actor.m_Abil.MP,actor.m_Abil.MaxMP]);
                  AspTextureFont.BoldTextOut (actor.m_nSayX - AspTextureFont.TextWidth(infoMsg) div 2 ,actor.m_nSayY - 22, infoMsg, clWhite, clBlack);
                end else if (actor.m_btRace <> 50) and (actor.m_btRace <> 101{富贵兽}{) and (abs(g_MySelf.m_nCurrX - Actor.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - Actor.m_nCurrY) <= 7) then begin  //NPC不数字显血 20080410 }
                  InfoMsg:=Format('%d/%d',[actor.m_Abil.HP,actor.m_Abil.MaxHP]);
                  AspTextureFont.BoldTextOut (actor.m_nSayX - AspTextureFont.TextWidth(infoMsg) div 2 ,actor.m_nSayY - 22, infoMsg, clWhite, clBlack);
                //end;
              end;
            end;

            //显示血条  
            if not actor.m_boDeath and ((abs(g_MySelf.m_nCurrX - Actor.m_nCurrX) <= 8) and (abs(g_MySelf.m_nCurrY - Actor.m_nCurrY) <= 7)) then  begin
                if (actor = g_HeroSelf) and (g_sMyHeroType = '副') then begin  //副将英雄标志
                  d := g_WMainImages.Images[1711];
                  if d <> nil then
                  MSurface.Draw (actor.m_nSayX-7, actor.m_nSayY+12, d.ClientRect, d, TRUE);
                end; 
                if (actor.m_btRace = 50) and   //某些NPC 不显示血条 20080323
                      ((actor.m_wAppearance in [33..40,48..50,54..58,60..62,65..66,70..75,82..84,90..92,107..113]) or (TNpcActor(actor).g_boNpcWalk) ) then Continue;
                if actor.m_btRace = 95 then Continue; //火龙守护兽
                if not(actor is THumActor) and not(actor is TNpcActor) and (actor.m_btHair = 158) then Continue; //宠物
                if actor.m_noInstanceOpenHealth then
                   if GetTickCount - actor.m_dwOpenHealthStart > actor.m_dwOpenHealthTime then
                      actor.m_noInstanceOpenHealth := FALSE;
                d := g_WMain3Images.Images[HEALTHBAR_BLACK];
                if d <> nil then begin
                   MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, d.ClientRect, d, TRUE);
                   //内功黄条背景
                   if actor.m_Skill69MaxNH > 0 then begin
                      MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 7, d.ClientRect, d, TRUE);
                   end;
                end;

                // 画人物的血条
                if actor.m_btRace in [12,24,50] then //大刀，带刀，NPC
                begin
                   if g_dMPImages = nil then
                   g_dMPImages := NewMyTexture(MyTexture_MP);
                   d := g_dMPImages;  // 蓝色血条
                   if d <> nil then begin // 这个地方时画血条 remark by liuzhigang
                         rc := d.ClientRect;
                         if actor.m_Abil.MaxHP > 0 then
                            rc.Right := Round((rc.Right-rc.Left) / actor.m_Abil.MaxHP * actor.m_Abil.HP);
                         MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, rc, d, TRUE);
                   end;
                end else begin
                if g_dHPImages = nil then
                   g_dHPImages := NewMyTexture(MyTexture_HP);
                  d := g_dHPImages;
                  if Actor.m_boMagicShield then
                  begin
                    if (d <> nil) then begin // 这个地方时画血条 remark by liuzhigang   
                         rc := d.ClientRect;
                         if (actor.m_Abil.MaxHP > 0) and (actor.m_Abil.MP<actor.m_Abil.MaxMP) then
                            rc.Right := Round((rc.Right-rc.Left) / actor.m_Abil.MaxHP * actor.m_Abil.HP);
                         MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, rc, d, TRUE);
                    end;
                    if g_dNewMPImages = nil then
                   g_dNewMPImages := NewMyTexture(MyTexture_NewMP);
                    d := g_dNewMPImages;
                    if d <> nil then begin // 这个地方时画血条 remark by liuzhigang
                         rc := d.ClientRect;
                         if (actor.m_Abil.MaxMP > 0)  and (actor.m_Abil.MP<actor.m_Abil.MaxMP)then
                            rc.Right := Round((rc.Right-rc.Left) / actor.m_Abil.MaxMP * actor.m_Abil.MP);
                         MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, rc, d, TRUE);
                    end;
                  end else
                  begin
                    if FrmDlg.DCheckMyHp.Checked then begin
                      if g_dMyHPImages = nil then
                       g_dMyHPImages := NewMyTexture(MyTexture_MyHP);
                      if (actor = g_MySelf) or (actor = g_HeroSelf) then 
                        d := g_dMyHPImages;
                    end;
                    if d <> nil then begin // 这个地方时画血条 remark by liuzhigang
                         rc := d.ClientRect;
                         if actor.m_Abil.MaxHP > 0 then
                            rc.Right := Round((rc.Right-rc.Left) / actor.m_Abil.MaxHP * actor.m_Abil.HP);
                         MSurface.Draw (actor.m_nSayX - d.Width div 2, actor.m_nSayY - 10, rc, d, TRUE);
                    end;
                  end;
                end;


                //内功黄条
                if actor.m_Skill69MaxNH > 0 then begin
                  if g_dKill69Images = nil then
                       g_dKill69Images := NewMyTexture(MyTexture_Kill69);
                  d := g_dKill69Images;//g_qingqingImages.Images[9];
                  if d <> nil then begin
                    rc := d.ClientRect;
                    rc.Right := Round((rc.Right-rc.Left) / actor.m_Skill69MaxNH * actor.m_Skill69NH);
                      MSurface.Draw(actor.m_nSayX - d.Width div 2, actor.m_nSayY - 7, rc, d, False);
                  end;  
                end;

                // 人物和怪物飘血
                if ClientConf.boShowMoveHP then
                begin
                  I:=0;
                  FontManager.SetFont(g_sCurFontName, 11);
                  while I<=actor.m_MoveHpList.Count-1 do
                  begin
                    MoveHP:=actor.m_MoveHpList[I];
                    AspTextureFont.BoldTextOutAlpha(actor.m_nSayX+MoveHP^.CurCount*4 ,
                                                    actor.m_nSayY -18-MoveHP^.CurCount*8,
                                                    TColor($0000FF) ,clBlack,
                                                    IntToStr(-MoveHP^.CurHp),MoveHP^.CurAlpha ); // fsBold ,[fsBold]
                    Inc(I);
                    if GetTickCount-MoveHP^.PrevTime>=160 then
                    begin
                      MoveHP^.PrevTime:=GetTickCount;
                      Inc(MoveHP^.CurCount);
                      if MoveHP^.CurCount>=4 then
                        MoveHP^.CurAlpha:=255-(MoveHP^.CurCount-4)*40;
                      if MoveHP^.CurCount>9 then
                      begin
                        Dec(I);
                        actor.m_MoveHpList.Delete(I);
                        Dispose(MoveHP);
                      end;
                    end;
                  end;
                  FontManager.SetFont(g_sCurFontName, 9);
                end;
            end;
          end;
        end;
      end;

     //自动显示名称    2007.12.18
      if g_boShowName then begin
        with PlayScene do begin
          for k := 0 to m_ActorList.Count - 1 do begin
            Actor := m_ActorList[k];
            if (Actor <> nil)  and (not Actor.m_boDeath) and
              (Actor.m_nSayX <> 0) and (Actor.m_nSayY <> 0)  and ((actor.m_btRace = 0) or (actor.m_btRace = 1) or (actor.m_btRace = 150) or (actor.m_btRace = 50) or (not(actor is THumActor) and not(actor is TNpcActor) and (actor.m_btHair = 158)){人类,英雄,人型,宠物}) then begin
              if (Actor <> g_FocusCret) then begin
                if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) >= 9) or (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) >= 7) then Continue;
                if (actor.m_btRace = 50) and   //某些NPC 不显示血条 20080323
                      ((actor.m_wAppearance in [33..40,48..50,60..62,65..66,70..75,82..84,90..92]) or (TNpcActor(actor).g_boNpcWalk) ) then Continue;
                if (actor = g_MySelf) and g_boSelectMyself then Continue;
                if not(actor is THumActor) and not(actor is TNpcActor) and (actor.m_btHair = 158) then
                	uname := Actor.m_sDescUserName + '\' + Actor.m_sUserName
                else uname := Actor.m_sUserName;
                  if not frmMain.InTargetListOfName(uname) then begin
                    NameTextOut(Actor, MSurface,
                      Actor.m_nSayX, // - Canvas.TextWidth(uname) div 2,
                      Actor.m_nSayY + 30,
                      Actor.m_nNameColor, ClBlack,
                      uname);
                  end else begin
                    NameTextOut(Actor, MSurface,
                      Actor.m_nSayX, // - Canvas.TextWidth(uname) div 2,
                      Actor.m_nSayY + 30,
                      GetRGB(223), ClBlack,
                      uname);
                  end;
              end;
            end;
          end;
        end;
      end; //with
      //自动显示名称  结束
      
      with PlayScene do begin  //摆摊
        if m_ActorList.Count > 0 then begin//20080629
          for k:=0 to m_ActorList.Count-1 do begin
            actor := m_ActorList[k];
            if (actor <> nil) and (actor.m_btRace = 0) and actor.m_boIsShop and (not Actor.m_boDeath) and
              (Actor.m_nSayX <> 0) and (Actor.m_nSayY <> 0) then begin //摆摊
              if (abs(g_MySelf.m_nCurrX - actor.m_nCurrX) >= 9) or (abs(g_MySelf.m_nCurrY - actor.m_nCurrY) >= 8) then Continue;
              if (actor.m_Abil.MaxHP > 1) then begin //数字显血
                AspTextureFont.BoldTextOut(actor.m_nSayX - AspTextureFont.TextWidth(actor.m_sShopMsg) div 2, actor.m_nSayY - 34, actor.m_sShopMsg, $004AA6EF, clBlack);
              end else begin
                AspTextureFont.BoldTextOut(actor.m_nSayX - AspTextureFont.TextWidth(actor.m_sShopMsg) div 2, actor.m_nSayY - 24, actor.m_sShopMsg, $004AA6EF, clBlack);
              end;
            end;

            //显示封号
            {$IF M2Version <> 2}
            if not g_boHideTitle and (actor.m_btRace = 0) or (actor.m_btRace = 150) then begin //是人物
              with THumActor(actor) do begin
                if (m_sTitleName <> '') and (m_wTitleIcon > 0) then begin
                  case m_wTitleIcon of
                    743, 744, 1265, 1275: begin
                      d := g_WUI1Images.Images[m_wTitleIcon];
                      if d<>nil then begin
                        MSurface.Draw (m_nSayX - d.Width div 2, m_nSayY - d.Height div 2 - 28, d.ClientRect, d, TRUE);
                      end;
                    end;
                    else begin
                      d := g_WUI1Images.Images[m_wTitleIcon];
                      if d<>nil then begin
                        TitleWidth := (AspTextureFont.TextWidth(m_sTitleName) - d.Width) div 2;
                        MSurface.Draw (m_nSayX - d.Width -TitleWidth, m_nSayY - d.Height div 2 - 28, d.ClientRect, d, TRUE);
                        AspTextureFont.BoldTextOut (m_nSayX - TitleWidth,m_nSayY - 34, m_sTitleName, clYellow, clBlack);
                      end;
                    end;
                  end;
                end;
              end;
            end;
            {$IFEND}
          end;
        end;
      end;
      
       //画当前选择的物品/人物的名字
       if ((g_FocusCret <> nil) and PlayScene.IsValidActor (g_FocusCret)) then begin
          if (g_FocusCret.m_btRace = 50) then begin
            if not TNpcActor(g_FocusCret).g_boNpcWalk then begin
              uname := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_sUserName;
              NameTextOut (g_FocusCret, MSurface,
                        g_FocusCret.m_nSayX,
                        g_FocusCret.m_nSayY + 30,
                        g_FocusCret.m_nNameColor, clBlack,
                        uname);
            end;
          end else begin
              uname := g_FocusCret.m_sDescUserName + '\' + g_FocusCret.m_sUserName;
              if not frmMain.InTargetListOfName(g_FocusCret.m_sUserName) then begin
                NameTextOut (g_FocusCret, MSurface,
                        g_FocusCret.m_nSayX,
                        g_FocusCret.m_nSayY + 30,
                        g_FocusCret.m_nNameColor, clBlack,
                        uname);
              end else begin
                NameTextOut (g_FocusCret, MSurface,
                        g_FocusCret.m_nSayX,
                        g_FocusCret.m_nSayY + 30,
                        GetRGB(223), clBlack,
                        uname);
              end;
          end;
       end;

       //玩家名称
       if g_boSelectMyself then begin
          uname := g_MySelf.m_sDescUserName + '\' + g_MySelf.m_sUserName;
          NameTextOut (g_MySelf, MSurface,
                  g_MySelf.m_nSayX, // - Canvas.TextWidth(uname) div 2,
                  g_MySelf.m_nSayY + 30,
                  g_MySelf.m_nNameColor, clBlack,
                  uname);
       end;

       //显示角色说话文字
       with PlayScene do begin
          if m_ActorList.Count > 0 then begin//20080629
            for k:=0 to m_ActorList.Count-1 do begin
              actor := m_ActorList[k];
              if (actor.m_SayingArr[0] <> '') and (GetTickCount - actor.m_dwSayTime < 4 * 1000) then begin
                 if actor.m_nSayLineCount > 0 then begin//20080629
                   for i:=0 to actor.m_nSayLineCount - 1 do //显示每个玩家说的话
                      if actor.m_boDeath then begin              //死了的话就灰/黑色显示
                         AspTextureFont.BoldTextOut (actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                   actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - 20,
                                   actor.m_SayingArr[i],
                                   clGray, clBlack);
                      end else begin                         //正常的玩家用黑/白色显示
                         if actor.m_boIsShop and (actor.m_Abil.MaxHP > 1) then begin
                           AspTextureFont.BoldTextOut (actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                   actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - 30,
                                   actor.m_SayingArr[i],
                                   actor.m_SayColor, clBlack);
                         end else begin
                           AspTextureFont.BoldTextOut (actor.m_nSayX - (actor.m_SayWidthsArr[i] div 2),
                                   actor.m_nSayY - (actor.m_nSayLineCount*16) + i*14 - 20,
                                   actor.m_SayingArr[i],
                                   actor.m_SayColor, clBlack);
                         end;
                      end;
                 end;
              end else actor.m_SayingArr[0] := '';  //说的话显示4秒
            end;
          end;
       end;


       //System Message
       if (g_nAreaStateValue and $04) <> 0 then begin
          AspTextureFont.BoldTextOut (0, 0, '攻城区域', clWhite, clBlack);
       end;


       //显示地图状态，16种：0000000000000000 从右到左，为1表示：战斗、安全、上面的那种状态 (当前只有这几种状态)
       {k := 0;
       for i:=0 to 15 do begin
          if g_nAreaStateValue and ($01 shr i) <> 0 then begin
             d := g_WMainImages.Images[AREASTATEICONBASE + i];
             if d <> nil then begin
                k := k + d.Width;
                MSurface.Draw (SCREENWIDTH-k, 0, d.ClientRect, d, TRUE);
             end;
          end;
       end; }
       k := 0;
       if g_nAreaStateValue <> 0 then begin
           d := g_WMainImages.Images[AREASTATEICONBASE + g_nAreaStateValue - 1];
           if d <> nil then begin
              k := k + d.Width;
              MSurface.Draw (g_D3DConfig.wScreenWidth-k, 0, d.ClientRect, d, TRUE);
           end;
       end;

      DrawScreenCenterLetter(MSurface); //在屏幕中间显示
      DrawScreenCountDown(MSurface); //在聊天栏上面显示倒记时消息
      DrawScreenTopLetter(MSurface); //在屏幕顶部显示渐变文字
      DrawScreenBoard(MSurface);//滚动公告显示
      DrawMove(MSurface);
    end;
  end;
end;
//显示左上角信息文字
procedure TDrawScreen.DrawScreenTop (MSurface: TAsphyreCanvas);
var
   i, sx, sy: integer;
begin
   if g_MySelf = nil then Exit;

   if CurrentScene = PlayScene then begin
      with MSurface do begin
         (*{$if Version = 1}
         SetBkMode (Canvas.Handle, TRANSPARENT);
         {$IFEND}*)
         if m_SysMsgList.Count > 0 then begin
            sx := 30;
            sy := 40;
            for i:=0 to m_SysMsgList.Count-1 do begin
               AspTextureFont.BoldTextOut (sx, sy, m_SysMsgList[i], clGreen, clBlack);
               inc (sy, 16);
            end;
            //3秒减少一个系统消息
            if GetTickCount - longword(m_SysMsgList.Objects[0]) >= 3000 then
               m_SysMsgList.Delete (0);
         end;
         //Canvas.Release;
         (*{$if Version = 1}
         SetBkMode (Canvas.Handle, TRANSPARENT);
         {$IFEND}*)
         if m_SysMsgListBottom.Count > 0 then begin
            sx := 15;
            sy := 386;
            for i:=0 to m_SysMsgListBottom.Count-1 do begin
               AspTextureFont.BoldTextOut (sx, sy, m_SysMsgListBottom[i], PBottomSysStyle(m_SysMsgListBottom.Objects[0]).FColor, clBlack);
               Dec (sy, 16);
            end;
            //3秒减少一个系统消息
            if GetTickCount - PBottomSysStyle(m_SysMsgListBottom.Objects[0]).Createtime >= 3000 then
               m_SysMsgListBottom.Delete (0);
         end;
         //右下消息
         if m_SysMsgListRightBottom.Count > 0 then begin
           sx := 780;
           sy := 320;
           for I:=0 to m_SysMsgListRightBottom.Count - 1 do begin
             AspTextureFont.BoldTextOut(sx-AspTextureFont.TextWidth(m_SysMsgListRightBottom[i]), sy, m_SysMsgListRightBottom[i], PRightBottomSysStyle(m_SysMsgListRightBottom.Objects[0]).FColor, PRightBottomSysStyle(m_SysMsgListRightBottom.Objects[0]).BColor);
             Dec(sy, 16);
           end;
           if GetTickCount - PRightBottomSysStyle(m_SysMsgListRightBottom.Objects[0]).CreateTime >= PRightBottomSysStyle(m_SysMsgListRightBottom.Objects[0]).ShowTime * 1000 then
             m_SysMsgListRightBottom.Delete(0);
         end;
         //Canvas.Release;
      end;
   end;
end;

function _Copy(str:String;Index,COunt:Integer):String;
var
  s:WideString;
Begin
  s:=WideString(str);
  Result:=Copy(s,index,count);
End;
(*******************************************************************************
  作用 :  添加在屏幕中间显示文字消息
  过程 :  AddCenterLetter(ForeGroundColor,BackGroundColor,Timer:Integer; CenterLetter:string; boTop: Boolean);
  参数 :  ForeGroundColor前景色;BackGroundColor背景色;CenterLetter显示文字;boTop是否是顶部居中
*******************************************************************************)
procedure TDrawScreen.AddCenterLetter(ForeGroundColor,BackGroundColor,Timer:Integer; CenterLetter:string);
begin
  m_boCenTerLetter := True;
  m_SCenterLetter := CenterLetter;
  m_CenterLetterForeGroundColor := ForeGroundColor;
  m_CenterLetterBackGroundColor := BackGroundColor;
  m_dwCenterLetterTimeTick := GetTickCount;
  m_nCenterLetterTimer := Timer;
end;
(*******************************************************************************
  作用 :  在屏幕中间显示文字消息
  过程 :  DrawScreenCenterLetter(MSurface: TAsphyreCanvas)
  参数 :  MSurface 为画板
*******************************************************************************)
procedure TDrawScreen.DrawScreenCenterLetter(MSurface: TAsphyreCanvas);
var
    nTextWidth, nTextHeight: Integer;
begin
  if m_boCenTerLetter then begin
    if CurrentScene = PlayScene then begin//如果为游戏画面页
      FontManager.SetFont(g_sCurFontName, 18);
      AspTextureFont.BoldTextOut(g_D3DConfig.wScreenWidth Div 2 - AspTextureFont.TextWidth(m_SCenterLetter) div 2,
                                 g_D3DConfig.wScreenHeight Div 2 - 100 - AspTextureFont.TextHeight(m_SCenterLetter) div 2,
                                 GetRGB(m_CenterLetterForeGroundColor), GetRGB(m_CenterLetterBackGroundColor), m_SCenterLetter, [fsBold]);
      FontManager.SetFont(g_sCurFontName, 9);
    end;
  end;
  if GetTickCount - m_dwCenterLetterTimeTick > m_nCenterLetterTimer*1000 then begin
    m_dwCenterLetterTimeTick := GetTickCount;
    m_boCenTerLetter := False;
  end;
end;

//跑马灯 滚动信息
procedure TDrawScreen.DrawScreenBoard(MSurface: TAsphyreCanvas);
var
  sx,xpos: Integer;
  Boardstyle:PBoardStyle;
  Str:String;
  Len:Integer;
begin
  if (g_MySelf = nil) or (m_SysBoard.Count = 0) then Exit;
  if CurrentScene = PlayScene then begin//如果为游戏画面页
    with MSurface do begin
      SetBkMode(frmMain.Canvas.handle, TRANSPARENT);
      if m_SysBoard.Count > 0 then begin //如果走马灯的列表不为0
        xpos:=1;
        if m_SysBoardIndex>=m_SysBoard.Count then begin
           m_SysBoardIndex:=0;
          m_SysBoard.Clear;
        end;
        if m_SysBoard.Count > 0 then begin //20080802
          if PBoardStyle(m_SysBoard.Objects[m_SysBoardIndex]) <> nil then begin
            Boardstyle:=PBoardStyle(m_SysBoard.Objects[m_SysBoardIndex]);
            Len:=(804-m_SysBoardXPos) div frmMain.Canvas.TextWidth('a')+1;   //长度
            if m_SysBoardXPos<=-600 then begin
              Xpos:=(-600-m_sysBoardXpos) div frmMain.Canvas.TextWidth('a')+1;
              Len:=Len-Xpos-1;
            end;
            Str:=m_SysBoard[m_SysBoardIndex];
            Str:=_Copy(Str,Xpos,len);
            if (Str='') or (Xpos > Length(m_SysBoard[m_SysBoardIndex])) then begin
              m_SysBoardXPos:=800;
              Inc(m_SysBoardIndex);
            end;
            sx := Max(-600,m_SysBoardXPos+1);
            AspTextureFont.BoldTextOut(sx,15,str,GetRGB(Boardstyle.FColor),GetRGB(Boardstyle.BColor));
          if GetTickCount-m_SysBoardTime>100 then begin
             Dec(m_SysBoardXPos,2);
             m_SysBoardTime:=GetTickCount;
          end;
          // Canvas.Release;
        end;
      end;
    end;
    end;
  end;
end;

//显示提示信息
procedure TDrawScreen.DrawHint (MSurface: TAsphyreCanvas);
var
   d: TAsphyreLockableTexture;
   i, hx, hy: integer;
begin
  //显示提示框
   hx:=0;
   hy:=0;//Jacky
   if HintList.Count > 0 then begin
     d := g_WMainImages.Images[394];
     if d <> nil then begin
       if HintWidth > d.Width then HintWidth := d.Width;
       if HintHeight > d.Height then HintHeight := d.Height;
       if HintX + HintWidth > g_D3DConfig.wScreenWidth then hx := g_D3DConfig.wScreenWidth - HintWidth
       else hx := HintX;
       if HintY < 0 then hy := 0
       else hy := HintY;
       if hx < 0 then hx := 0;
       MSurface.DrawAlpha(hx, hy, Rect(0, 0, HintWidth, HintHeight), d, 128);
     end;
   end;
   //在提示框中显示提示信息
   with MSurface do begin
      if HintList.Count > 0 then begin
         for i:=0 to HintList.Count-1 do begin
            AspTextureFont.TextOut(hx+5, hy+4+(AspTextureFont.TextHeight('A')+1)*i, HintList[i], HintColor);
         end;
      end;
   end;
end;

procedure TDrawScreen.DrawMove(MSurface: TAsphyreCanvas);
var
  I: Integer;
begin
  if g_MySelf = nil then Exit;
  if CurrentScene = PlayScene then begin
    for I := 0 to m_MoveMsgList.Count - 1 do begin
      TDrawScreenMoveMsg(m_MoveMsgList.Items[I]).Draw(MSurface);
    end;
  end;
end;

(*******************************************************************************
  作用 :  在聊天栏上面显示倒记时文字消息
  过程 :  DrawScreenCountDown(MSurface: TAsphyreCanvas)
  参数 :  MSurface 为画板
*******************************************************************************)
procedure TDrawScreen.DrawScreenCountDown(MSurface: TAsphyreCanvas);
var
  line1,Str: string;
begin
  if CurrentScene = PlayScene then begin//如果为游戏画面页
    if m_boCountDown then begin
      if m_dwCountDownTimer >= 60 then begin
        line1 := Inttostr(m_dwCountDownTimer div 60)+'分'+IntToStr(m_dwCountDownTimer mod 60)+'秒';
      end else begin
        line1 := IntToStr(m_dwCountDownTimer mod 60)+'秒';
      end;
      Str := Format(m_SCountDown,[line1]);
      AspTextureFont.BoldTextOut (g_D3DConfig.wScreenWidth Div 2 - AspTextureFont.TextWidth(Str) div 2,
                             g_D3DConfig.wScreenHeight - 210 - AspTextureFont.TextHeight(Str) div 2, Str,
                             GetRGB(m_CountDownForeGroundColor), clBlack);
    end;
    if m_boHeroCountDown then begin
      if m_dwHeroCountDownTimer >= 60 then begin
        line1 := Inttostr(m_dwHeroCountDownTimer div 60)+'分'+IntToStr(m_dwHeroCountDownTimer mod 60)+'秒';
      end else begin
        line1 := IntToStr(m_dwHeroCountDownTimer mod 60)+'秒';
      end;
      Str := Format(m_SHeroCountDown,[line1]);
      if not m_boCountDown then begin //倒记时没显示
        AspTextureFont.BoldTextOut (g_D3DConfig.wScreenWidth Div 2 - AspTextureFont.TextWidth(Str) div 2,
                               g_D3DConfig.wScreenHeight - 210 - AspTextureFont.TextHeight(Str) div 2, Str,
                               GetRGB(m_HeroCountDownForeGroundColor), clBlack);
      end else begin
        AspTextureFont.BoldTextOut (g_D3DConfig.wScreenWidth Div 2 - AspTextureFont.TextWidth(Str) div 2,
                               g_D3DConfig.wScreenHeight - 210 - AspTextureFont.TextHeight(Str) div 2 - 14, Str,
                               GetRGB(m_HeroCountDownForeGroundColor), clBlack);
      end;
    end;
  end;
end;
//添加在屏幕中间显示文字消息
procedure TDrawScreen.AddCountDown(ForeGroundColor: Integer;
  Timer: LongWord; CountDown: string);
begin
  m_boCountDown := True;
  m_SCountDown := CountDown;
  m_CountDownForeGroundColor := ForeGroundColor;
  m_dwCountDownTimeTick := GetTickCount;
  m_dwCountDownTimeTick1 := GetTickCount;
  m_dwCountDownTimer := Timer;
  frmMain.CountDownTimer.Enabled := True;
end;
//添加在屏幕中间显示英雄复仇文字消息
procedure TDrawScreen.AddHeroCountDown(ForeGroundColor: Integer;
  Timer: LongWord; CountDown: string);
begin
  m_boHeroCountDown := True;
  m_SHeroCountDown := CountDown;
  m_HeroCountDownForeGroundColor := ForeGroundColor;
  m_dwHeroCountDownTimeTick := GetTickCount;
  m_dwHeroCountDownTimeTick1 := GetTickCount;
  m_dwHeroCountDownTimer := Timer;
  frmMain.CountDownTimer.Enabled := True;
end;

procedure TDrawScreen.AddMoveMsg(sMsg: string; FColor, BColor: Byte; nX, nY,
  nCount: Integer);
var
  I: Integer;
  DrawScreenMoveMsg: TDrawScreenMoveMsg;
begin
  for I := 0 to m_MoveMsgList.Count - 1 do begin
    DrawScreenMoveMsg := TDrawScreenMoveMsg(m_MoveMsgList.Items[I]);
    if DrawScreenMoveMsg.Top = nY then begin
      DrawScreenMoveMsg.Add(sMsg, FColor, BColor, nX, nY, nCount);
      Exit;
    end;
  end;
  DrawScreenMoveMsg := TDrawScreenMoveMsg.Create;
  DrawScreenMoveMsg.Add(sMsg, FColor, BColor, nX, nY, nCount);
  m_MoveMsgList.Add(DrawScreenMoveMsg);
end;

procedure TDrawScreen.AddRightBottomMsg(fcolor, bcolor: Integer; dWTime:LongWord; msg: string);  //右下消息
var
  RightBottomSysStyle: PRightBottomSysStyle;
begin
  if m_SysMsgListRightBottom.Count >= 10 then m_SysMsgListRightBottom.Delete (0);
  New(RightBottomSysStyle);
  RightBottomSysStyle^.Createtime := GetTickCount;
  RightBottomSysStyle^.ShowTime := dWTime;
  RightBottomSysStyle^.FColor := fcolor;
  RightBottomSysStyle^.BColor := bcolor;
  m_SysMsgListRightBottom.AddObject(msg, TObject(RightBottomSysStyle));
end;

procedure TDrawScreen.DrawTzHint(MSurface: TAsphyreCanvas);
var
   d: TAsphyreLockableTexture;
   i, j, hx, hy: integer;
   sParam,fdata: string;
   sCmd: Char;
begin
  //显示提示框
   hx:=0;
   hy:=0;//Jacky
   if TzHintList.Count > 0 then begin
     d := g_WMainImages.Images[403];
     if d <> nil then begin
       if HintWidth > d.Width then HintWidth := d.Width;
       if HintHeight > d.Height then HintHeight := d.Height;
       if HintDec then begin
         if HintX + HintWidth > g_D3DConfig.wScreenWidth then hx := g_D3DConfig.wScreenWidth - HintWidth
         else hx := HintX;
       end else hx := HintX;
       if HintY < 0 then hy := 0
       else hy := HintY;
       if hx < 0 then hx := 0;
       MSurface.DrawAlpha(hx, hy, Bounds(0,0,HintWidth, HintHeight), d, 128);
     end;
   end;
   //在提示框中显示提示信息
   with MSurface do begin
      if TzHintList.Count > 0 then begin
         for i:=0 to TzHintList.Count-1 do begin
            if (TzHintList[i][1] = '*') and (TzHintList[i][2] in ['1'..'5']) then begin
              for j:=1 to StrToInt(TzHintList[i][2]) do begin
                d := g_WUI1Images.Images[1345];
                if d <> nil then begin
                  MSurface.Draw(hx + 4 + (j-1) * (d.Width+3), hy+5+(AspTextureFont.TextHeight('A')+1)*i, d.ClientRect, d, True);
                end;
              end;
            end else if (pos('~', TzHintList[i]) > 0) then begin
              fdata := TzHintList[i];
              sParam := GetValidStr3 (fdata, fdata, ['~']);
              if (sParam <> '') and (fdata <> '')then begin
                sParam := Uppercase(sParam);
                sCmd := sParam[1];
                case sCmd of
                  'A': begin
                    FontManager.SetFont(g_sCurFontName, 12);
                    AspTextureFont.BoldTextOut (hx+4, hy+2+(AspTextureFont.TextHeight('A'))*i, $000075EA, clBlack, fdata);
                    FontManager.SetFont(g_sCurFontName, 9);
                  end;
                  'L': begin //绿色
                    AspTextureFont.BoldTextOut (hx+4, hy+2+(AspTextureFont.TextHeight('A'))*i, clLime, clBlack, fdata);
                  end;
                  'C': begin
                    FontManager.SetFont(g_sCurFontName, 10);
                    AspTextureFont.BoldTextOut (hx+4, hy+3+(AspTextureFont.TextHeight('A')+1)*i, clYellow, clBlack, fdata);
                    FontManager.SetFont(g_sCurFontName, 9);
                  end;
                  'D': begin
                    AspTextureFont.BoldTextOut (hx+4, hy+2+(AspTextureFont.TextHeight('A')+1)*i, clYellow, clBlack, fdata);
                  end;
                  'R': AspTextureFont.TextOut(hx+4, hy+3+(AspTextureFont.TextHeight('A')+1)*i, clRed, fdata);
                  'H': AspTextureFont.TextOut(hx+4, hy+3+(AspTextureFont.TextHeight('A')+1)*i, clLime, fdata);
                  'Y': AspTextureFont.TextOut(hx+4, hy+3+(AspTextureFont.TextHeight('A')+1)*i, clYellow, fdata);
                  'W': AspTextureFont.BoldTextOut (hx+4, hy+2+(AspTextureFont.TextHeight('A')+1)*i, clWhite, clBlack, fdata);
                end;
                if sParam = 'R' then
                if sParam = 'Y' then
               // if sParam = 'W' then clFunc.TextOut(MSurface, hx+4, hy+3+(FrmMain.Canvas.TextHeight('A')+1)*i, clYellow, fdata);
              end;
            end else AspTextureFont.TextOut(hx+4, hy+3+(AspTextureFont.TextHeight('A')+1)*i, clWhite, TzHintList[i]);
         end;
      end;  
   end;    
end;

procedure TDrawScreen.ShowTzHint (x, y: integer; str: string; drawup, HintDec: Boolean;{是否删减超出屏幕宽度} nWidth: Byte{新加宽度});
var
   data: string;
   w: integer;
begin
   ClearHint;
   HintX := x;
   HintY := y;
   HintWidth := 0;
   HintHeight := 0;
   HintUp := drawup;
   //HintDec := HintDec;
   while TRUE do begin
      if str = '' then break;
      str := GetValidStr3 (str, data, ['\']);
      if data <> '' then begin
        if data[1] <> '~' then begin
          if (data[1] = '*') and (data[2] in ['1'..'5']) then begin
            w := (14)*StrToInt(data[2]) + 8;
          end else w := AspTextureFont.TextWidth (data) + 8;
          if w > HintWidth then HintWidth := w+nWidth;
          TzHintList.Add (data);
        end;
      end;
   end;
   FontManager.SetFont(g_sCurFontName, 9);
   HintHeight := (AspTextureFont.TextHeight('A') + 1) * TzHintList.Count + 6;
   if HintUp then
      HintY := HintY - HintHeight;
end;

procedure TDrawScreen.DrawSpecialHint(MSurface: TAsphyreCanvas);
var
  d: TAsphyreLockableTexture;
  i, j, hx, hy, hW, hH: integer;
  data, fdata, cmdstr, cmdparam, cmdColor, cmdFontStyle, cmdFontSize: string;
  sStr, sStr1, sStr2:string;
  FColor: TColor;
  sx: integer;
  strList: TStringList;
  fontsize,oldfontsize: Byte;

  procedure DrawEdgeLine;
  var Color1,Color2:Cardinal;
  begin
    Color1:=$FF696969;
    Color2:=$FFE9A492;
    //MSurface.FrameRect(Bounds(hx, hy, hW, hH),Color4());
    MSurface.Line(Point2(hx, hy),Point2(hx+hW, hy),Color1); //上
    MSurface.Line(Point2(hx, hy+1),Point2(hx+hW, hy+1),Color2);
    MSurface.Line(Point2(hx+hW-1, hy),Point2(hx+hW-1, hy+hH),Color2); // 右
    MSurface.Line(Point2(hx+hW-2, hy),Point2(hx+hW-2, hy+hH),Color1);
    MSurface.Line(Point2(hx, hy+hH-1),Point2(hx+hW, hy+hH-1),Color2); // 下
    MSurface.Line(Point2(hx, hy+hH),Point2(hx+hW, hy+hH),Color1);
    MSurface.Line(Point2(hx, hy),Point2(hx, hy+hH),Color1); // 左
    MSurface.Line(Point2(hx+1, hy),Point2(hx+1, hy+hH),Color2);
  end;

  procedure DrawMiddleLine(tX,tY:Integer; Dir:Integer);
  var Color1,Color2:Cardinal;
      K:Integer;
  begin
    Color1:=$FF696969;
    Color2:=$FF807164;
    K:=10;
    if Dir=1 then // 横线
    begin
      MSurface.Line(Point2(tX+K, tY),Point2(tX-K+hW, tY),Color1); // 右
      MSurface.Line(Point2(tX+K, tY+1),Point2(tX-K+hW, tY+1),Color2);
    end else  // 竖线
    begin
      MSurface.Line(Point2(tX, tY+K),Point2(tX, tY+hH-K),Color1); // 右
      MSurface.Line(Point2(tX+1, tY+K),Point2(tX+1, tY+hH-K),Color2);
    end;
  end;
  
begin
  //显示提示框
  if SpecialHintList.Count > 0 then begin

    hx:=0;
    hy:=0;//Jacky
    hW:=0;
    hH:=0;
    d := g_WMainImages.Images[403];
    if d <> nil then begin
      if HintWidth > d.Width then hW := d.Width-2 else hW := HintWidth-2;
      if HintHeight > d.Height then hH := d.Height else hH := HintHeight;
      if HintX + hW > g_D3DConfig.wScreenWidth then hx := g_D3DConfig.wScreenWidth - hW else hx := HintX;
      if HintY < 0 then hy := 0 else hy := HintY;
      if hx < 0 then hx := 0;
      DrawTzItemHint(MSurface, hx, hy, hW, hH);
      MSurface.DrawAlpha(hx, hy, Bounds(0, 0, hW, hH), d, 128);
      //DrawEdgeLine;
    end;
    //在提示框中显示提示信息
    for i:=0 to SpecialHintList.Count-1 do begin
      data := SpecialHintList[i];
      if data <> '' then begin
        if (data[1] = '*') and (data[2] in ['1'..'5']) then begin
          for j:=1 to StrToInt(data[2]) do begin
            d := g_WUI1Images.Images[1345];
            if d <> nil then begin
              MSurface.Draw(hx + 4 + (j-1) * (d.Width+3), hy+5+({FrmMain.Canvas.TextHeight('A')}12+1)*i, d.ClientRect, d, True);
            end;
          end;          
        end else begin
          strList := TStringList.Create;
          try
            strList.Add('Yellow');
            strList.Add('Lime');
            strList.Add('Red'); 
            cmdstr := '';
            fdata := '';
            sx := 0;
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
              if data[1] <> '<' then begin
                data := '<' + GetValidStr3 (data, fdata, ['<']); //取<前的部分   data是取到后面的部分
              end;
              FColor := clWhite;
              fontsize := 9;
              cmdColor := '';
              cmdFontStyle := '';
              cmdFontSize := '';
              data := ArrestStringEx (data, '<', '>', cmdstr);//得到"<"和">" 号之间的字   赋予给 cmdstr
              if (cmdstr <> '') and (cmdstr[1] <> '/') then begin  //20100829
                cmdparam := GetValidStrFinal(cmdstr, cmdstr, ['/']);    // cmdstr为显示的文字 得到显示的字
                sStr:= cmdparam+' ';  //字符串格式为 XXX XXX XXX    后面自动补齐空格
                if (sStr <> '') and (Pos('fontstyle',sStr) > 0) then begin
                  cmdparam := Copy(sStr, Pos('fontstyle',sStr)+10, Length(sStr));
                  cmdparam := Copy(cmdparam, 1, Pos(' ',cmdparam)-1);
                  cmdFontStyle := Trim(cmdparam);   //得到字体风格
                  sStr1:= Copy(sStr, 1,Pos('fontstyle',sStr)-1);//前
                  sStr2:= Copy(sStr, Pos(cmdparam,sStr)+length(cmdparam)-1, Length(sStr));//后
                  sStr:= sStr1+sStr2;
                end;
                if (sStr <> '') and (Pos('c',sStr) > 0) then begin
                  cmdparam := Copy(sStr, Pos('c',sStr)+2, Length(sStr));
                  cmdparam := Copy(cmdparam, 1, Pos(' ',cmdparam)-1);
                  cmdColor := Trim(cmdparam);   //得到字体颜色
                  sStr1:= Copy(sStr, 1,Pos('c',sStr)-1);//前
                  sStr2:= Copy(sStr, Pos(cmdparam,sStr)+length(cmdparam)-1, Length(sStr));//后
                  sStr:= sStr1+sStr2;
                end;
                if (sStr <> '') and (Pos('fontsize',sStr) > 0) then begin
                  cmdparam := Copy(sStr, Pos('fontsize',sStr)+9, Length(sStr));
                  cmdparam := Copy(cmdparam, 1, Pos(' ',cmdparam)-1);
                  cmdFontSize := Trim(cmdparam);         //得到字体大小
                  sStr1:= Copy(sStr, 1,Pos('fontsize',sStr)-1);//前
                  sStr2:= Copy(sStr, Pos(cmdparam,sStr)+length(cmdparam)-1, Length(sStr));//后
                  sStr:= sStr1+sStr2;
                end;
                if cmdColor <> '' then begin
                  case strList.IndexOf(cmdColor) of
                    0: FColor := clYellow;
                    1: FColor := clLime;
                    2: Fcolor := clRed;
                    else begin
                      try
                        FColor := StringToColor(cmdColor);
                      except
                        FColor := clWhite;
                      end;
                    end;
                  end;
                end;
                if cmdFontSize <> '' then begin
                  fontsize := Str_ToInt(cmdFontSize, 9);
                end;
                if fdata <> '' then begin
                  AspTextureFont.TextOut (hx+5+sx, hy+4+({FrmMain.Canvas.TextHeight('A')}12+1)*i, clWhite, fdata);
                  sx := sx + AspTextureFont.TextWidth(fdata);
                end;
                oldfontsize := FontManager.FontSize;//frmMain.Canvas.Font.Size;
                FontManager.SetFont(g_sCurFontName, fontsize);
                if cmdstr <> ''  then begin
                  if cmdFontStyle = 'bold' then begin
                    AspTextureFont.BoldTextOut (hx+5+sx, hy+4+({FrmMain.Canvas.TextHeight('A')}12+1)*i, FColor, clBlack, cmdstr);
                  end else begin
                    AspTextureFont.TextOut (hx+5+sx, hy+4+({FrmMain.Canvas.TextHeight('A')}12+1)*i, FColor, cmdstr);
                  end;
                  sx := sx + AspTextureFont.TextWidth(cmdstr);
                  FontManager.SetFont(g_sCurFontName, oldfontsize);
                end;
              end;
            end;
            if data <> '' then AspTextureFont.TextOut (hx+5+sx, hy+4+({FrmMain.Canvas.TextHeight('A')}12+1)*i, clWhite, data);
          finally
            strList.Free;
          end;
        end;
      end;
    end;
  end;  
end;

procedure TDrawScreen.ShowSpecialHint(x, y: integer; str: string;
  drawup: Boolean);
  {$REGION '获取DrawHint一行文字的宽度'}
  function GetHintSize(sText: string): Integer;
  var
    data, cmdstr, fdata: string;
  begin
    data := sText;
    Result := 0;
    while (data <> '') and (pos('<', data) > 0) and (pos('>', data) > 0) do begin
      if data[1] <> '<' then begin
        data := '<' + GetValidStr3 (data, fdata, ['<']); //取<前的部分   data是取到后面的部分
      end;
      data := ArrestStringEx (data, '<', '>', cmdstr);//得到"<"和">" 号之间的字   赋予给 cmdstr
      if (cmdstr = '') or (cmdstr[1] = '/') then Continue;
      GetValidStrFinal(cmdstr, cmdstr, ['/']);    // cmdstr为显示的文字 得到显示的字
      Result := Result + AspTextureFont.TextWidth(fdata+cmdstr);
    end;
    if data <> '' then Result := Result + AspTextureFont.TextWidth(data);
  end;
  {$ENDREGION}
var
  data: string;
  w: integer;
begin
  ClearHint;
  HintX := x;
  HintY := y;
  HintWidth := 0;
  HintHeight := 0;
  HintUp := drawup;
  //HintColor := color;
  while TRUE do begin
    if str = '' then break;
    str := GetValidStr3 (str, data, ['\']);
    if data = '' then Continue;
    if (data[1] = '*') and (data[2] in ['1'..'5']) then begin
      w := (11+3)*StrToInt(data[2]) + 8;
      SpecialHintList.Add (Copy(data, 1, 2));
      Delete(data, 1, 2);//修复军鼓不显示HPMP
      w := GetHintSize (data) + 8;
    end else w := GetHintSize (data) + 8;
    if w > HintWidth then HintWidth := w;
    if (data <> '') and (GetHintSize (data) > 0) then SpecialHintList.Add (data)
  end;
  HintHeight := (AspTextureFont.TextHeight('A') + 1) * SpecialHintList.Count + 6;
  if HintUp then HintY := HintY - HintHeight;
end;

procedure TDrawScreen.DrawTzItemHint(MSurface: TAsphyreCanvas; var X,Y, W, H : Integer);
var
  d: TAsphyreLockableTexture;
  i, j, hx, hy, hW, hH: integer;
  data, fdata, cmdstr, cmdparam, cmdColor, cmdFontStyle, cmdFontSize: string;
  sStr, sStr1, sStr2:string;
  FColor: TColor;
  sx: integer;
  strList: TStringList;
  fontsize,oldfontsize: Byte;

  procedure DrawEdgeLine;
  var Color1,Color2:Cardinal;
  begin
    Color1:=$FF696969;
    Color2:=$FFE9A492;
    //MSurface.FrameRect(Bounds(hx, hy, hW, hH),Color4());
    MSurface.Line(Point2(hx, hy),Point2(hx+hW, hy),Color1); //上
    MSurface.Line(Point2(hx, hy+1),Point2(hx+hW, hy+1),Color2);
    MSurface.Line(Point2(hx+hW-1, hy),Point2(hx+hW-1, hy+hH),Color2); // 右
    MSurface.Line(Point2(hx+hW-2, hy),Point2(hx+hW-2, hy+hH),Color1);
    MSurface.Line(Point2(hx, hy+hH-1),Point2(hx+hW, hy+hH-1),Color2); // 下
    MSurface.Line(Point2(hx, hy+hH),Point2(hx+hW, hy+hH),Color1);
    MSurface.Line(Point2(hx, hy),Point2(hx, hy+hH),Color1); // 左
    MSurface.Line(Point2(hx+1, hy),Point2(hx+1, hy+hH),Color2);
  end;

  procedure DrawMiddleLine(tX,tY:Integer; Dir:Integer);
  var Color1,Color2:Cardinal;
      K:Integer;
  begin
    Color1:=$FF696969;
    Color2:=$FF807164;
    K:=10;
    if Dir=1 then // 横线
    begin
      MSurface.Line(Point2(tX+K, tY),Point2(tX-K+hW, tY),Color1); // 右
      MSurface.Line(Point2(tX+K, tY+1),Point2(tX-K+hW, tY+1),Color2);
    end else  // 竖线
    begin
      MSurface.Line(Point2(tX, tY+K),Point2(tX, tY+hH-K),Color1); // 右
      MSurface.Line(Point2(tX+1, tY+K),Point2(tX+1, tY+hH-K),Color2);
    end;
  end;
  
begin
  //显示提示框
  if TzItemHintList.Count > 0 then begin
    hx:=0;
    hy:=0;//Jacky
    hW:=0;
    hH:=0;
    d := g_WMainImages.Images[403];
    if d <> nil then begin
      if HintTzItemWidth > d.Width then hW := d.Width-2 else hW := HintTzItemWidth-2;
      if HintTzItemHeight > d.Height then hH := d.Height else hH := HintTzItemHeight;
      hx := X - HintTzItemWidth;
      if hx < 0 then Inc(X, -hx);
      hx := X - HintTzItemWidth;

      if hx + hW > g_D3DConfig.wScreenWidth then
        hx := g_D3DConfig.wScreenWidth - hW;

      if HintY < 0 then hy := 0 else hy := HintY;
      MSurface.DrawAlpha(hx, hy, Bounds(0, 0, hW, hH), d, 128);
      //DrawEdgeLine;
    end;
    //在提示框中显示提示信息
    for i:=0 to TzItemHintList.Count-1 do begin
      data := TzItemHintList[i];
      if data <> '' then begin
        if (data[1] = '*') and (data[2] in ['1'..'5']) then begin
          for j:=1 to StrToInt(data[2]) do begin
            d := g_WUI1Images.Images[1345];
            if d <> nil then begin
              MSurface.Draw(hx + 4 + (j-1) * (d.Width+3), hy+5+({FrmMain.Canvas.TextHeight('A')}12+1)*i, d.ClientRect, d, True);
            end;
          end;          
        end else begin
          strList := TStringList.Create;
          try
            strList.Add('Yellow');
            strList.Add('Lime');
            strList.Add('Red'); 
            cmdstr := '';
            fdata := '';
            sx := 0;
            while (pos('<', data) > 0) and (pos('>', data) > 0) and (data <> '') do begin
              if data[1] <> '<' then begin
                data := '<' + GetValidStr3 (data, fdata, ['<']); //取<前的部分   data是取到后面的部分
              end;
              FColor := clWhite;
              fontsize := 9;
              cmdColor := '';
              cmdFontStyle := '';
              cmdFontSize := '';
              data := ArrestStringEx (data, '<', '>', cmdstr);//得到"<"和">" 号之间的字   赋予给 cmdstr
              if (cmdstr <> '') and (cmdstr[1] <> '/') then begin  //20100829
                cmdparam := GetValidStrFinal(cmdstr, cmdstr, ['/']);    // cmdstr为显示的文字 得到显示的字
                sStr:= cmdparam+' ';  //字符串格式为 XXX XXX XXX    后面自动补齐空格
                if (sStr <> '') and (Pos('fontstyle',sStr) > 0) then begin
                  cmdparam := Copy(sStr, Pos('fontstyle',sStr)+10, Length(sStr));
                  cmdparam := Copy(cmdparam, 1, Pos(' ',cmdparam)-1);
                  cmdFontStyle := Trim(cmdparam);   //得到字体风格
                  sStr1:= Copy(sStr, 1,Pos('fontstyle',sStr)-1);//前
                  sStr2:= Copy(sStr, Pos(cmdparam,sStr)+length(cmdparam)-1, Length(sStr));//后
                  sStr:= sStr1+sStr2;
                end;
                if (sStr <> '') and (Pos('c',sStr) > 0) then begin
                  cmdparam := Copy(sStr, Pos('c',sStr)+2, Length(sStr));
                  cmdparam := Copy(cmdparam, 1, Pos(' ',cmdparam)-1);
                  cmdColor := Trim(cmdparam);   //得到字体颜色
                  sStr1:= Copy(sStr, 1,Pos('c',sStr)-1);//前
                  sStr2:= Copy(sStr, Pos(cmdparam,sStr)+length(cmdparam)-1, Length(sStr));//后
                  sStr:= sStr1+sStr2;
                end;
                if (sStr <> '') and (Pos('fontsize',sStr) > 0) then begin
                  cmdparam := Copy(sStr, Pos('fontsize',sStr)+9, Length(sStr));
                  cmdparam := Copy(cmdparam, 1, Pos(' ',cmdparam)-1);
                  cmdFontSize := Trim(cmdparam);         //得到字体大小
                  sStr1:= Copy(sStr, 1,Pos('fontsize',sStr)-1);//前
                  sStr2:= Copy(sStr, Pos(cmdparam,sStr)+length(cmdparam)-1, Length(sStr));//后
                  sStr:= sStr1+sStr2;
                end;
                if cmdColor <> '' then begin
                  case strList.IndexOf(cmdColor) of
                    0: FColor := clYellow;
                    1: FColor := clLime;
                    2: Fcolor := clRed;
                    else begin
                      try
                        FColor := StringToColor(cmdColor);
                      except
                        FColor := clWhite;
                      end;
                    end;
                  end;
                end;
                if cmdFontSize <> '' then begin
                  fontsize := Str_ToInt(cmdFontSize, 9);
                end;
                if fdata <> '' then begin
                  AspTextureFont.TextOut (hx+5+sx, hy+4+({FrmMain.Canvas.TextHeight('A')}12+1)*i, clWhite, fdata);
                  sx := sx + AspTextureFont.TextWidth(fdata);
                end;
                oldfontsize := FontManager.FontSize;//frmMain.Canvas.Font.Size;
                FontManager.SetFont(g_sCurFontName, fontsize);
                if cmdstr <> ''  then begin
                  if cmdFontStyle = 'bold' then begin
                    AspTextureFont.BoldTextOut (hx+5+sx, hy+4+({FrmMain.Canvas.TextHeight('A')}12+1)*i, FColor, clBlack, cmdstr);
                  end else begin
                    AspTextureFont.TextOut (hx+5+sx, hy+4+({FrmMain.Canvas.TextHeight('A')}12+1)*i, FColor, cmdstr);
                  end;
                  sx := sx + AspTextureFont.TextWidth(cmdstr);
                  FontManager.SetFont(g_sCurFontName, oldfontsize);
                end;
              end;
            end;
            if data <> '' then AspTextureFont.TextOut (hx+5+sx, hy+4+({FrmMain.Canvas.TextHeight('A')}12+1)*i, clWhite, data);
          finally
            strList.Free;
          end;
        end;
      end;
    end;
  end;  
end;

procedure TDrawScreen.ShowTzItemHint(str: string);
  {$REGION '获取DrawHint一行文字的宽度'}
  function GetHintSize(sText: string): Integer;
  var
    data, cmdstr, fdata: string;
  begin
    data := sText;
    Result := 0;
    while (data <> '') and (pos('<', data) > 0) and (pos('>', data) > 0) do begin
      if data[1] <> '<' then begin
        data := '<' + GetValidStr3 (data, fdata, ['<']); //取<前的部分   data是取到后面的部分
      end;
      data := ArrestStringEx (data, '<', '>', cmdstr);//得到"<"和">" 号之间的字   赋予给 cmdstr
      if (cmdstr = '') or (cmdstr[1] = '/') then Continue;
      GetValidStrFinal(cmdstr, cmdstr, ['/']);    // cmdstr为显示的文字 得到显示的字
      Result := Result + AspTextureFont.TextWidth(fdata+cmdstr);
    end;
    if data <> '' then Result := Result + AspTextureFont.TextWidth(data);
  end;
  {$ENDREGION}
var
  data: string;
  w: integer;
begin
  HintTzItemWidth := 0;
  HintTzItemHeight := 0;
  //HintColor := color;
  while TRUE do begin
    if str = '' then break;
    str := GetValidStr3 (str, data, ['\']);
    if data = '' then Continue;
    if (data[1] = '*') and (data[2] in ['1'..'5']) then begin
      w := (11+3)*StrToInt(data[2]) + 8;
      TzItemHintList.Add (Copy(data, 1, 2));
      Delete(data, 1, 2);//修复军鼓不显示HPMP
      w := GetHintSize (data) + 8;
    end else w := GetHintSize (data) + 8;
    if w > HintTzItemWidth then HintTzItemWidth := w;
    if (data <> '') and (GetHintSize (data) > 0) then TzItemHintList.Add (data)
  end;
  HintTzItemHeight := (AspTextureFont.TextHeight('A') + 1) * TzItemHintList.Count + 6;
  if HintUp then HintY := HintY - HintTzItemHeight;
end;

procedure TDrawScreen.Draw3km2Help(MSurface: TAsphyreCanvas);
{var
  d: TAsphyreCanvas;    }
begin
 { if g_MySelf = nil then Exit;
  if CurrentScene = PlayScene then begin
    with MSurface do begin
      d := g_WUI1Images.Images[500];
      if d <> nil then
      MSurface.FastDrawAlpha(Bounds(0, 0, d.Width, d.Height), d.ClientRect, d, True);
      d := g_WUI1Images.Images[502];
      if d <> nil then
        MSurface.Draw (0, 0, d.ClientRect, d, TRUE);
    end;
  end;  }
end;

function TDrawScreen.GetShowItemName(DropItem: pTDropItem): Pointer;
var
  ShowItem: pTShowItem1;
begin
  Result := nil;
  ShowItem := g_ShowItemList.Find(DropItem.Name);
  if (ShowItem <> nil){ and ShowItem.boShowName }then begin
    Result := ShowItem;
  end;
end;

procedure TDrawScreen.DrawScreenTopLetter(MSurface: TAsphyreCanvas);
var
  MoveShow: pTMoveTopStrShow;
  I: Integer;
begin
  I := 0;
  while TRUE do begin
    if I >=m_MoveTopStrList.Count then break;
    if I > 0 then break;
    MoveShow:=m_MoveTopStrList.Items[I];
    if MoveShow.boMoveStrShow then begin
      FontManager.SetFont(g_sCurFontName, 17);
      AspTextureFont.BoldTextOutAlpha(200, 66 - MoveShow.nMoveStrEnd*3, GetRGB(MoveShow.btFColor), GetRGB(MoveShow.btBColor), MoveShow.sMovestr, MoveShow.btMoveAlpha * 25, [fsBold]);
      FontManager.SetFont(g_sCurFontName, 9);
      if MoveShow.nMoveStrEnd = 10 then begin
        if (GetTickCount-MoveShow.dwMoveStrTick) > 1000 then begin
          MoveShow.dwMoveStrTick:=GetTickCount;
          Inc(MoveShow.btMoveNil);
          if MoveShow.btMoveNil = 2 then begin
            Inc(I);
            Continue;//继续
          end;
          Inc(MoveShow.nMoveStrEnd);
        end;
      end else begin
        if (GetTickCount-MoveShow.dwMoveStrTick) > 120 then begin
          MoveShow.dwMoveStrTick:=GetTickCount;
          Inc(MoveShow.nMoveStrEnd);
          if MoveShow.nMoveStrEnd > 10 then begin
            Dec(MoveShow.btMoveAlpha);
          end else Inc(MoveShow.btMoveAlpha);
        end;
      end;
      if MoveShow.nMoveStrEnd > 21 then begin
        MoveShow.boMoveStrShow:=False;
        m_MoveTopStrList.Delete(I);
        Dispose(MoveShow);
      end else Inc(I);
    end;
  end;
end;

procedure TDrawScreen.AddTopLetter(ForeGroundColor,BackGroundColor:Byte; CenterLetter:string);
var
  MoveShow: pTMoveTopStrShow;
Begin
  try
    New(MoveShow);
    MoveShow.sMovestr := CenterLetter;
    MoveShow.boMoveStrShow := True;
    MoveShow.btFColor := ForeGroundColor;
    MoveShow.btBColor := BackGroundColor;
    MoveShow.nMoveStrEnd := 0;
    MoveShow.btMoveAlpha := 0;
    MoveShow.btMoveNil := 0;
    m_MoveTopStrList.Add(MoveShow);
  except
    DebugOutStr('[Exception] TDrawScreen.AddTopLetter'); //程序自动增加
  end;
end;

{ TDrawScreenMoveMsg }

procedure TDrawScreenMoveMsg.Add(sMsg: string; FColor, BColor: Byte; nX, nY,
  nCount: Integer);
var
  FontSize: Integer;
  MoveMsg: pTMoveMsg;
  Index: Integer;
begin
  New(MoveMsg);
  MoveMsg.Count := nCount;
  MoveMsg.X := nX;
  MoveMsg.Y := nY;

  MoveMsg.Text := sMsg;

  MoveMsg.FColor := FColor;
  MoveMsg.BColor := BColor;
  DestRect.Top := nY;

  m_MsgList.Insert(0, MoveMsg);
end;

constructor TDrawScreenMoveMsg.Create;
begin
  m_MsgList := TList.Create;
  m_nCurrMoveMsg := nil;
end;

destructor TDrawScreenMoveMsg.Destroy;
var
  I: Integer;
  MoveMsg: pTMoveMsg;
begin
  for I := 0 to m_MsgList.Count - 1 do begin
    MoveMsg := m_MsgList.Items[I];
    Dispose(MoveMsg);
  end;
  m_MsgList.Free;

  if (m_nCurrMoveMsg <> nil) then
    Dispose(m_nCurrMoveMsg);
  inherited;
end;

procedure TDrawScreenMoveMsg.Draw(MSurface: TAsphyreCanvas);
var
  FontSize: Integer;
  nX, nWidth: Integer;
begin
  if (m_nCurrMoveMsg <> nil) and (m_nCurrMoveMsg.Count <= 0) then begin
    //m_MsgList.Remove(m_nCurrMoveMsg);
    try
      Dispose(m_nCurrMoveMsg);
    except
      m_nCurrMoveMsg := nil;
    end;
    m_nCurrMoveMsg := nil;
  end;

  FontManager.SetFont(g_sCurFontName, 20);

  if (m_nCurrMoveMsg = nil) and (m_MsgList.Count > 0) then begin
    m_nCurrMoveMsg := m_MsgList.Items[0];
    m_MsgList.Delete(0);
    FTextWidth := AspTextureFont.TextWidth(m_nCurrMoveMsg.Text);
    DestRect.Left := 80;
    DestRect.Top := m_nCurrMoveMsg.Y;
    DestRect.Right := DestRect.Left + FTextWidth;
    DestRect.Bottom := DestRect.Top + AspTextureFont.TextHeight(m_nCurrMoveMsg.Text);
    FOffSetX := g_D3DConfig.wScreenWidth - 80;
    SrcRect := Bounds(0, 0, DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top);
  end;

  if (m_nCurrMoveMsg <> nil) then begin
    nWidth := g_D3DConfig.wScreenWidth - DestRect.Left - 80;
    if FrmDlg.DWMiniMap.Visible and (DestRect.Top <= FrmDlg.DWMiniMap.GHeight) then
      nWidth := g_D3DConfig.wScreenWidth - DestRect.Left - _MAX(80, FrmDlg.DWMiniMap.GWidth + 5);

    DestRect.Right := DestRect.Left + nWidth;
    if FOffSetX > DestRect.Right then FOffSetX := DestRect.Right;

    if GetTickCount - m_dwMoveTick > 4 then begin
      m_dwMoveTick := GetTickCount;
      Dec(FOffSetX);
      if FOffSetX >= DestRect.Left then
        FLeft := 0
      else
        FLeft := abs(FOffSetX - DestRect.Left) div 4;

      SrcRect := Bounds(FLeft, 0, DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top);

      if FLeft * 4 >= FTextWidth then begin
        Dec(m_nCurrMoveMsg.Count);
        DestRect.Left := 80;
        DestRect.Top := m_nCurrMoveMsg.Y;
        DestRect.Right := DestRect.Left + (g_D3DConfig.wScreenWidth - DestRect.Left - 80);
        DestRect.Bottom := DestRect.Top + AspTextureFont.TextHeight(m_nCurrMoveMsg.Text);
        FOffSetX := g_D3DConfig.wScreenWidth - 80;
        SrcRect := Bounds(0, 0, DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top);
      end;
    end;
    MSurface.FillRectAlpha(DestRect, GetRGB(m_nCurrMoveMsg.BColor), 150);
    AspTextureFont.TextRect(DestRect, SrcRect, FOffSetX, DestRect.Top, m_nCurrMoveMsg.Text, GetRGB(m_nCurrMoveMsg.FColor), [fsBold]);
  end;


  (*AspTextureFonts.SetFont(g_sCurFontName, 12);
  if (m_nCurrMoveMsg = nil) and (m_MsgList.Count > 0) then begin
    m_nCurrMoveMsg := m_MsgList[0];
    FLen := 0;
    FLeft := 0;
    FOffSetX := 0;
  end;

  if (m_nCurrMoveMsg <> nil) then begin
    FX := 80;

    nWidth := g_D3DConfig.wScreenWidth - FX - 80;
    if FrmDlg.DWMiniMap.Visible and (FY <= FrmDlg.DWMiniMap.GHeight) then
      nWidth := g_D3DConfig.wScreenWidth - FX - _MAX(80, FrmDlg.DWMiniMap.GWidth + 5);
    if FOffSetX < nWidth then begin
      if FLeft > 0 then begin
        Inc(FOffSetX, FLeft);
        FLeft := 0;
      end;
    end else begin
      if FOffSetX > nWidth then begin
        Inc(FLeft, FOffSetX - nWidth);
        FOffSetX := nWidth;
      end;
    end;


    GameCanvas.FillRectAlpha(Bounds(FX, FY, nWidth, AspTextureFont.TextHeight(m_nCurrMoveMsg.Text)), GetRGB(m_nCurrMoveMsg.BColor), 150);

    AspTextureFont.TextRect(Bounds(FLeft, 0, FLen - FLeft, AspTextureFont.TextHeight(m_nCurrMoveMsg.Text)), FX + nWidth - FOffSetX, FY, m_nCurrMoveMsg.Text, GetRGB(m_nCurrMoveMsg.FColor), [fsBold]);

    if GetTickCount - m_dwMoveTick > 4 then begin
      m_dwMoveTick := GetTickCount;

      if FOffSetX < nWidth then begin
        if FLeft > 0 then begin
          Inc(FOffSetX, FLeft + 1);
          FLeft := 0;
        end else Inc(FOffSetX);
      end else begin
        if FOffSetX > nWidth then begin
          Inc(FLeft, FOffSetX - nWidth + 1);
          FOffSetX := nWidth;
        end else Inc(FLeft);
      end;

      if FLen < AspTextureFont.TextWidth(m_nCurrMoveMsg.Text) then Inc(FLen);

      if FOffSetX + FLeft >= FLen + nWidth then begin
        Dec(m_nCurrMoveMsg.Count);
        FLen := 0;
        FLeft := 0;
        FOffSetX := 0;

      end;
    end;
  end;   *)
  FontManager.SetFont(g_sCurFontName, 9);
end;

procedure TDrawScreenMoveMsg.Finalize;
begin

end;

function TDrawScreenMoveMsg.GetTop: Integer;
begin
  Result := DestRect.Top;
end;

procedure TDrawScreenMoveMsg.Initialize;
begin

end;

end.
