unit MapUnit;
//地图单元
{ MAP文件结构
    文件头：52字节
    第一行第一列定义
    第二行第一列定义
    第三行第一列定义
    。
    。
    。
    第Width行第一列定义
    第一行第二列定义
    。
    。
    。
    上面是个高人写的。。。 By TasNat at: 2012-03-13 09:38:09
}
interface

uses
   Windows, Classes, SysUtils, Grobal2, HUtil32, Share;
type
// -------------------------------------------------------------------------------
// Map
// -------------------------------------------------------------------------------
  //.MAP文件头  52字节
  TMapHeader = packed record
    wWidth      :Word;                 //宽度       2
    wHeight     :Word;                 //高度       2
    sTitle      :array[0..15] of Char; //标题      16
    UpdateDate  :TDateTime;          //更新日期     8
    Logo        :Byte;//标识(新的格式为02)          1
    Reserved    :array[0..22] of Char;  //保留      23
  end;
  //地图文件一个元素的定义(旧12字节)
  TMapInfo = packed record
    wBkImg       :Word;  //2
    wMidImg      :Word;  //2
    wFrImg       :Word;  //2
    btDoorIndex  :Byte;  //1  $80 (巩娄), 巩狼 侥喊 牢郸胶
    btDoorOffset :Byte;  //1  摧腮 巩狼 弊覆狼 惑措 困摹, $80 (凯覆/摧塞(扁夯))
    btAniFrame   :Byte;  //1    //$80(Draw Alpha) +  橇贰烙 荐
    btAniTick    :Byte;  //1
    btArea       :Byte;  //1      //瘤开 沥焊
    btLight      :Byte;  //1     //0..1..4 堡盔 瓤苞
  end;
  //新地图文件一个元素的定义(14字节) 20110428
  TNewMapInfo = packed record
    wBkImg       :Word;  //2
    wMidImg      :Word;  //2
    wFrImg       :Word;  //2
    btDoorIndex  :Byte;  //1    $80 (巩娄), 巩狼 侥喊 牢郸胶
    btDoorOffset :Byte;  //1  摧腮 巩狼 弊覆狼 惑措 困摹, $80 (凯覆/摧塞(扁夯))
    btAniFrame   :Byte;  //1    //$80(Draw Alpha) +  橇贰烙 荐
    btAniTick    :Byte;  //1
    btArea       :Byte;  //1      //瘤开 沥焊
    btLight      :Byte;  //1     //0..1..4 堡盔 瓤苞
    btNew        :Byte;  //新增加
    btNew1       :Byte;
  end;
  //pTMapInfo = ^TMapInfo;
  //TMapInfoArr = array[0..MaxListSize] of TMapInfo;
  //pTMapInfoArr = ^TMapInfoArr;

  TMapInfoArray = array of array of TMapInfo;
  
  TMap = class
  private
    //function  LoadMapInfo(sMapFile:String; var nWidth, nHeight: Integer): Boolean;//20110428 注释
    procedure LoadMapArr(nCurrX, nCurrY: integer);
    procedure SaveMapArr(nCurrX,nCurrY:Integer);
  public
    m_sMapBase      :string;
    m_MArr          :array[0..120, 0..120] of {TMapInfo}TNewMapInfo;
    m_MapBuf: TMapInfoArray;
    m_Header: TMapHeader;
    m_boChange      :Boolean;
    m_ClientRect    :TRect;
    m_OldClientRect :TRect;
    m_nBlockLeft    :Integer;
    m_nBlockTop     :Integer; //鸥老 谅钎肺 哭率, 怖措扁 谅钎
    m_nOldLeft      :Integer;
    m_nOldTop       :Integer;
    m_sOldMap       :String;
    m_nCurUnitX     :Integer;
    m_nCurUnitY     :Integer;
    m_sCurrentMap   :String;
    m_nSegXCount    :Integer;
    m_nSegYCount    :Integer;
    //m_nMapWidth,M_nMapHeight: Word; //20080617 自动寻路用的

    m_nCurWidth: Integer;
    m_nCurHeight: Integer;

    constructor Create;
    destructor Destroy;override;//Jacky
    procedure LoadMapPathArr(nCurrX, nCurrY: Integer);
    function UpdateMapSquare (cx, cy: integer) : Boolean;
    function UpdateMapPos (mx, my: integer):Boolean;    //mx,my象素坐标
    procedure ReadyReload;
    procedure LoadMap(sMapName:String;nMx,nMy:Integer);
    procedure MarkCanWalk (mx, my: integer; bowalk: Boolean);
    function  CanMove (mx, my: integer): Boolean;
    function NewCanMove(mx, my: Integer): Boolean;
    function  CanFly  (mx, my: integer): Boolean;
    function  GetDoor (mx, my: integer): Integer;
    function  IsDoorOpen (mx, my: integer): Boolean;
    function  OpenDoor (mx, my: integer): Boolean;
    function  CloseDoor (mx, my: integer): Boolean;
    function GetBitCountIs16():Boolean;
  end;

implementation

uses
   ClMain, MShare;


constructor TMap.Create;
begin
   inherited Create;
   //GetMem (MInfoArr, sizeof(TMapInfo) * LOGICALMAPUNIT * 3 * LOGICALMAPUNIT * 3);
   m_ClientRect  := Rect (0,0,0,0);
   m_boChange    :=False;
   m_sMapBase    := g_ParamDir+MAPDIR;    //地图文件所在目录
   m_sCurrentMap := '';          //当前地图文件名（不含.MAP）
   m_nSegXCount  := 0;
   m_nSegYCount  := 0;
   m_nCurUnitX   := -1;          //当前单元位置X、Y
   m_nCurUnitY   := -1;
   m_nBlockLeft  := -1;          //当前块X,Y左上角
   m_nBlockTop   := -1;
   m_sOldMap     := '';          //前一个地图文件名（在换地图的时候用）
end;

destructor TMap.Destroy;
begin
   FillChar(m_MArr, SizeOf(m_MArr), #0);
   inherited Destroy;
end;

//加载地图段数据
//以当前座标为准
procedure TMap.LoadMapArr(nCurrX,nCurrY: integer);
var
  I         :Integer;
  nAline    :Integer;
  nLx       :Integer;
  nRx       :Integer;
  nTy       :Integer;
  nBy       :Integer;
  sFileName :String;
  nHandle   :Integer;
  TempMaar: Array of TMapInfo;
  Count, J: Integer;
begin
  try
    FillChar(m_MArr, SizeOf(m_MArr), #0);
    sFileName:=m_sMapBase + m_sCurrentMap + '.map';
    if FileExists(sFileName) then begin
      nHandle:=FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
      if nHandle > 0 then begin
        FileRead (nHandle, m_Header, SizeOf(m_Header));
        nLx := (nCurrX - 1) * LOGICALMAPUNIT;
        nRx := (nCurrX + 2) * LOGICALMAPUNIT;    //rx
        nTy := (nCurrY - 1) * LOGICALMAPUNIT;
        nBy := (nCurrY + 2) * LOGICALMAPUNIT;

        if nLx < 0 then nLx := 0;
        if nTy < 0 then nTy := 0;
        if nBy >= m_Header.wHeight then nBy := m_Header.wHeight;
        if (m_Header.Logo = 2) then begin//使用新模式(把数据读到临时数组中，再赋值给结构变量)
          nAline := SizeOf(TNewMapInfo) * m_Header.wHeight;
          for I:=nLx to nRx - 1 do begin
            if (I >= 0) and (I < m_Header.wWidth) then begin
              FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TNewMapInfo) * nTy), 0);
              FileRead(nHandle, m_MArr[I - nLx, 0], SizeOf(TNewMapInfo) * (nBy - nTy));
            end;
          end;
        end else begin
          SetLength(TempMaar, m_Header.wHeight);
          nAline := SizeOf(TMapInfo) * m_Header.wHeight;     //一个列的大小（字节数）
          Count:= nBy - nTy;
          for I:=nLx to nRx - 1 do begin      //i最多有 3*LOGICALMAPUNIT 值,这就是要更新的地图的行数
            if (I >= 0) and (I < m_Header.wWidth) then begin
             //当前行列为X,Y，则应从X*每行字节数+Y*每项字节数开始读第一行数据
              FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TMapInfo) * nTy), 0);
              FileRead(nHandle, TempMaar[0], SizeOf(TMapInfo) * (nBy - nTy));
              for j:=0 to Count-1 do begin
                m_MArr[I-nLx,j].wBkImg:= TempMaar[j].wBkImg;
                m_MArr[I-nLx,j].wMidImg:= TempMaar[j].wMidImg;
                m_MArr[I-nLx,j].wFrImg:= TempMaar[j].wFrImg;
                m_MArr[I-nLx,j].btDoorIndex:= TempMaar[j].btDoorIndex;
                m_MArr[I-nLx,j].btDoorOffset:= TempMaar[j].btDoorOffset;
                m_MArr[I-nLx,j].btAniFrame:= TempMaar[j].btAniFrame;
                m_MArr[I-nLx,j].btAniTick:= TempMaar[j].btAniTick;
                m_MArr[I-nLx,j].btArea:= TempMaar[j].btArea;
                m_MArr[I-nLx,j].btLight:= TempMaar[j].btLight;
                m_MArr[I-nLx,j].btNew:= 0;
                m_MArr[I-nLx,j].btNew1:= 0;
              end;
            end;
          end;
          SetLength(TempMaar, 0);
        end;
        FileClose(nHandle);

      end;
    end;
  except
    DebugOutStr('TMap.LoadMapArr');
  end;
end;

procedure TMap.SaveMapArr(nCurrX,nCurrY:Integer);
var
  I         :Integer;
  nAline    :Integer;
  nLx       :Integer;
  nRx       :Integer;
  nTy       :Integer;
  nBy       :Integer; 
  sFileName :String;
  nHandle   :Integer;
  Header    :TMapHeader;

  TempMaar: Array of TNewMapInfo;
  Count, J: Integer;
begin
  try
    FillChar(m_MArr, SizeOf(m_MArr), #0);
    sFileName:=m_sMapBase + m_sCurrentMap + '.map';
    if FileExists(sFileName) then begin
      nHandle:=FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
      if nHandle > 0 then begin
        FileRead (nHandle, Header, SizeOf(TMapHeader));
        nLx := (nCurrX - 1) * LOGICALMAPUNIT;
        nRx := (nCurrX + 2) * LOGICALMAPUNIT;    //rx
        nTy := (nCurrY - 1) * LOGICALMAPUNIT;
        nBy := (nCurrY + 2) * LOGICALMAPUNIT;

        if nLx < 0 then nLx := 0;
        if nTy < 0 then nTy := 0;
        if nBy >= Header.wHeight then nBy := Header.wHeight;
        if (Header.Logo = 2) then begin//使用新模式(把数据读到临时数组中，再赋值给结构变量)
          SetLength(TempMaar, Header.wHeight);
          nAline := SizeOf(TNewMapInfo) * Header.wHeight;
          Count:= nBy - nTy;
          for I:=nLx to nRx - 1 do begin
            if (I >= 0) and (I < Header.wWidth) then begin
              FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TNewMapInfo) * nTy), 0);
              FileRead(nHandle, TempMaar[0], SizeOf(TNewMapInfo) * (nBy - nTy));
              for j:=0 to Count-1 do begin
                m_MArr[I-nLx,j].wBkImg:= TempMaar[j].wBkImg;
                m_MArr[I-nLx,j].wMidImg:= TempMaar[j].wMidImg;
                m_MArr[I-nLx,j].wFrImg:= TempMaar[j].wFrImg;
                m_MArr[I-nLx,j].btDoorIndex:= TempMaar[j].btDoorIndex;
                m_MArr[I-nLx,j].btDoorOffset:= TempMaar[j].btDoorOffset;
                m_MArr[I-nLx,j].btAniFrame:= TempMaar[j].btAniFrame;
                m_MArr[I-nLx,j].btAniTick:= TempMaar[j].btAniTick;
                m_MArr[I-nLx,j].btArea:= TempMaar[j].btArea;
                m_MArr[I-nLx,j].btLight:= TempMaar[j].btLight;
              end;
            end;
          end;
        end else begin
          nAline := SizeOf(TMapInfo) * Header.wHeight;
          if nRx > 0 then begin//20080629
            for I:=nLx to nRx - 1 do begin
              if (I >= 0) and (I < Header.wWidth) then begin
                FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TMapInfo) * nTy), 0);
                FileRead(nHandle, m_MArr[I - nLx, 0], SizeOf(TMapInfo) * (nBy - nTy));
              end;
            end;
          end;
        end;
        FileClose(nHandle);
      end;
    end;
  except
    DebugOutStr('TMap.SaveMapArr');
  end;
end;

procedure TMap.ReadyReload;
begin
   m_nCurUnitX := -1;
   m_nCurUnitY := -1;
end;

//cx, cy: 位置, 以LOGICALMAPUNIT为单位
function TMap.UpdateMapSquare (cx, cy: integer) : Boolean;
begin
  Result := True;
  try
    Result := (cx <> m_nCurUnitX) or (cy <> m_nCurUnitY);
    if Result then begin
      LoadMapArr(cx, cy);
      m_nCurUnitX := cx;
      m_nCurUnitY := cy;
    end;
  except
    DebugOutStr('TMap.UpdateMapSquare');
  end;
end;

//林某腐捞 捞悼矫 后锅捞 龋免..
function TMap.UpdateMapPos (mx, my: integer):Boolean;    //mx,my象素坐标.-象素你妹啊
var
   cx, cy: integer;       //地图的逻辑坐标
   procedure Unmark (xx, yy: integer);     //xx,yy是象素点坐标 -SB
   var
      ax, ay: integer;
   begin
      if (cx = xx div LOGICALMAPUNIT) and (cy = yy div LOGICALMAPUNIT) then begin
         ax := xx - m_nBlockLeft;
         ay := yy - m_nBlockTop;
         m_MArr[ax,ay].wFrImg := m_MArr[ax,ay].wFrImg and $7FFF;
         m_MArr[ax,ay].wBkImg := m_MArr[ax,ay].wBkImg and $7FFF;
      end;
   end;
begin
  try
   cx := mx div LOGICALMAPUNIT;       //折算成逻辑坐标
   cy := my div LOGICALMAPUNIT;
   m_nBlockLeft := _MAX (0, (cx - 1) * LOGICALMAPUNIT);  //象素坐标
   m_nBlockTop  := _MAX (0, (cy - 1) * LOGICALMAPUNIT);

   Result := UpdateMapSquare (cx, cy);
   Result := (m_nOldLeft <> m_nBlockLeft) or (m_nOldTop <> m_nBlockTop) or (m_sOldMap <> m_sCurrentMap);
   if Result then begin
      //3锅甘 己寒磊府 滚弊 焊沥 (2001-7-3)
      if (m_sCurrentMap = '3') then begin
         Unmark (624, 278);
         Unmark (627, 278);
         Unmark (634, 271);
         Unmark (564, 287);
         Unmark (564, 286);
         Unmark (661, 277);
         Unmark (578, 296);
      end;
     
   end;
   m_nOldLeft := m_nBlockLeft;
     m_nOldTop := m_nBlockTop;
  except
    DebugOutStr('TMap.UpdateMapPos');
  end;
end;

//甘函版矫 贸澜 茄锅 龋免..
procedure TMap.LoadMap(sMapName:String;nMx,nMy:Integer);
begin
   m_nCurUnitX   := -1;
   m_nCurUnitY   := -1;
   m_sCurrentMap := sMapName;
   UpdateMapPos(nMx, nMy);
   m_sOldMap := m_sCurrentMap;
end;
//置前景是否可以行走
procedure TMap.MarkCanWalk (mx, my: integer; bowalk: Boolean);
var
   cx, cy: integer;
begin
  try
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then exit;
   if bowalk then //该坐标可以行走，则MArr[cx,cy]的值最高位为0
      Map.m_MArr[cx, cy].wFrImg := Map.m_MArr[cx, cy].wFrImg and $7FFF
   else //不可以行走的，最高位为1
      Map.m_MArr[cx, cy].wFrImg := Map.m_MArr[cx, cy].wFrImg or $8000;
  except
    DebugOutStr('TMap.MarkCanWalk');
  end;
end;
//若前景和背景都可以走，则返回真
function  TMap.CanMove (mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
  try
   Result:=False;  //jacky
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then exit;
   //前景和背景都可以走（最高位为0）
   Result := ((Map.m_MArr[cx, cy].wBkImg and $8000) + (Map.m_MArr[cx, cy].wFrImg and $8000)) = 0;
   if Result then begin //巩八荤
      if (Map.m_MArr[cx, cy].btDoorIndex and $80 > 0)
        //修复新沙巴克空气墙 By TasNat at: 2012-07-30 11:35:09
        and ((m_sCurrentMap <> '3') or (m_Header.Logo <> 2) or(((mx <> 619) and (my <> 267)) and ((mx <> 619) and (my <> 268)))) then begin  //巩娄捞 乐澜
         if (Map.m_MArr[cx, cy].btDoorOffset and  $80) = 0 then
            Result := FALSE; //巩捞 救 凯啡澜.
      end;
   end;
  except
    DebugOutStr('TMap.CanMove');
  end;
end;
//若前景可以走，则返回真。
function  TMap.CanFly(mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
  try
   Result:=False;  //jacky
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then exit;
   Result := (Map.m_MArr[cx, cy].wFrImg and $8000) = 0;
   if Result then begin //巩八荤
      if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin  //巩娄捞 乐澜
         if (Map.m_MArr[cx, cy].btDoorOffset and  $80) = 0 then
            Result := FALSE;
      end;
   end;
  except
    DebugOutStr('TMap.CanFly');
  end;
end;
//获得指定坐标的门的索引号
function TMap.GetBitCountIs16: Boolean;
begin
  Result := m_sCurrentMap = 'hjsbk';
end;

function  TMap.GetDoor (mx, my: integer): Integer;
var
   cx, cy: integer;
begin
  try
   Result := 0;
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin   //是门
      Result := Map.m_MArr[cx, cy].btDoorIndex and $7F;       //门的索引在低7位
   end;
  except
    DebugOutStr('TMap.GetDoor');
  end;
end;
//判断门是否打开
function  TMap.IsDoorOpen (mx, my: integer): Boolean;
var
   cx, cy: integer;
begin
  try
   Result := FALSE;
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin   //是门
      Result := (Map.m_MArr[cx, cy].btDoorOffset and $80 <> 0);
   end;
  except
    DebugOutStr('TMap.IsDoorOpen');
  end;
end;
//打开门
function  TMap.OpenDoor (mx, my: integer): Boolean;
var
   i, j, cx, cy, idx: integer;
begin
  try
   Result := FALSE;
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then Exit;
   if Map.m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
      idx := Map.m_MArr[cx, cy].btDoorIndex and $7F;
      for i:=cx - 10 to cx + 10 do
         for j:=cy - 10 to cy + 10 do begin
            if (i > 0) and (j > 0) then
               if (Map.m_MArr[i, j].btDoorIndex and $7F) = idx then
                  Map.m_MArr[i, j].btDoorOffset := Map.m_MArr[i, j].btDoorOffset or $80;
         end;
   end;
  except
    DebugOutStr('TMap.OpenDoor');
  end;
end;

function  TMap.CloseDoor (mx, my: integer): Boolean;
var
   i, j, cx, cy, idx: integer;
begin
  try
   Result := FALSE;
   cx := mx - m_nBlockLeft;
   cy := my - m_nBlockTop;
   if (cx < 0) or (cy < 0) then Exit;
   if m_MArr[cx, cy].btDoorIndex and $80 > 0 then begin
      idx := m_MArr[cx, cy].btDoorIndex and $7F;
      for i:=cx-8 to cx+10 do
         for j:=cy-8 to cy+10 do begin
            if ((m_MArr[i, j].btDoorIndex and $7F) = idx) then
               m_MArr[i, j].btDoorOffset := m_MArr[i, j].btDoorOffset and $7F;
         end;
   end;
  except
    DebugOutStr('TMap.CloseDoor');
  end;
end;



procedure TMap.LoadMapPathArr(nCurrX, nCurrY: Integer);
var
  I: Integer;
  k: Integer;
  nAline: Integer;
  nLx: Integer;
  nRx: Integer;
  nTy: Integer;
  nBy: Integer;
  sFileName: string;
  nHandle: Integer;
  Header: TMapHeader;

  TempMaar: Array of TNewMapInfo;
  Count, J: Integer;
begin
  SetLength(m_MapBuf, 0, 0);
  m_MapBuf := nil;
  sFileName := m_sMapBase + m_sCurrentMap + '.map';
  if FileExists(sFileName) then begin
    nHandle := FileOpen(sFileName, fmOpenRead or fmShareDenyNone);
    if nHandle > 0 then begin
      FileRead(nHandle, Header, SizeOf(TMapHeader));
      LegendMap.Width := Header.wWidth;
      LegendMap.Height := Header.wHeight;
      LegendMap.PathMapArray := nil;
      LegendMap.GetClientRect(nCurrX, nCurrY);

      m_nCurWidth := LegendMap.ClientRect.Right - LegendMap.ClientRect.Left;
      m_nCurHeight := LegendMap.ClientRect.Bottom - LegendMap.ClientRect.Top;

      nLx := LegendMap.ClientRect.Left;
      nRx := LegendMap.ClientRect.Right; //rx
      nTy := LegendMap.ClientRect.Top;
      nBy := LegendMap.ClientRect.Bottom;
      SetLength(m_MapBuf, m_nCurWidth, m_nCurHeight);
      if (Header.Logo = 2) then begin//使用新模式(把数据读到临时数组中，再赋值给结构变量)
        SetLength(TempMaar, Header.wHeight);
        nAline := SizeOf(TNewMapInfo) * Header.wHeight;
        Count:= nBy - nTy;
        for I:=nLx to nRx - 1 do begin
          if (I >= 0) and (I < Header.wWidth) then begin
            FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TNewMapInfo) * nTy), 0);
            FileRead(nHandle, TempMaar[0], SizeOf(TNewMapInfo) * (nBy - nTy));
            for j:=0 to Count-1 do begin
              m_MapBuf[I-nLx,j].wBkImg:= TempMaar[j].wBkImg;
              m_MapBuf[I-nLx,j].wMidImg:= TempMaar[j].wMidImg;
              m_MapBuf[I-nLx,j].wFrImg:= TempMaar[j].wFrImg;
              m_MapBuf[I-nLx,j].btDoorIndex:= TempMaar[j].btDoorIndex;
              m_MapBuf[I-nLx,j].btDoorOffset:= TempMaar[j].btDoorOffset;
              m_MapBuf[I-nLx,j].btAniFrame:= TempMaar[j].btAniFrame;
              m_MapBuf[I-nLx,j].btAniTick:= TempMaar[j].btAniTick;
              m_MapBuf[I-nLx,j].btArea:= TempMaar[j].btArea;
              m_MapBuf[I-nLx,j].btLight:= TempMaar[j].btLight;
            end;
          end;
        end;
      end else begin
        nAline := SizeOf(TMapInfo) * Header.wHeight;
        for I := nLx to nRx - 1 do begin
          if (I >= 0) and (I < Header.wWidth) then begin
            FileSeek(nHandle, SizeOf(TMapHeader) + (nAline * I) + (SizeOf(TMapInfo) * nTy), 0);
            FileRead(nHandle, m_MapBuf[I - nLx, 0], SizeOf(TMapInfo) * (nBy - nTy));
          end;
        end;
      end;
      FileClose(nHandle);
    end;
  end;
end;

function TMap.NewCanMove(mx, my: Integer): Boolean;
var
  cx, cy: Integer;
begin
  Result := FALSE; //jacky
  cx := LegendMap.LoaclX(mx);
  cy := LegendMap.LoaclY(my);
  if (cx < 0) or (cy < 0) then Exit;
  Result := ((m_MapBuf[cx, cy].wBkImg and $8000) + (m_MapBuf[cx, cy].wFrImg and $8000)) = 0;
  if Result then begin
    if m_MapBuf[cx, cy].btDoorIndex and $80 > 0 then begin
      if (m_MapBuf[cx, cy].btDoorOffset and $80) = 0 then
        Result := FALSE;
    end;
  end;
end;

end.
