unit ClFunc;
//辅助函数库
interface

uses
  Windows, SysUtils, Classes,
  Grobal2, HUtil32, Share, AspWil;

var
   DropItems: TList;  //lsit of TClientItem

   
function  fmStr (str: string; len: integer): string;
function  GetGoldStr (gold: integer): string;
procedure SaveBags (flname: string; pbuf: Pbyte);
procedure Loadbags (flname: string; pbuf: Pbyte);
procedure ClearBag;
function  AddItemBag (cu: TClientItem): Boolean;
function AddItemBagLock(cu: TClientItem): Boolean;
function DelItemBagLock(cu: TClientItem): Boolean;
function  AddHeroItemBag (cu: TClientItem): Boolean;//英雄包 $016 2007.10.23
procedure ArrangeHeroItemBag;//英雄包 $017 2007.10.23
function  HeroUpdateItemBag (cu: TClientItem): Boolean;    //更新英雄包裹
function  DelHeroItemBag (iname: string; iindex: integer): Boolean; //删除英雄物品函数
function  UpdateItemBag (cu: TClientItem): Boolean;
function  DelItemBag (iname: string; iindex: integer): Boolean;
procedure ArrangeItemBag;
procedure AddDropItem (ci: TClientItem);
function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
procedure DelDropItem (iname: string; MakeIndex: integer);
procedure AddShopItem (ci: TShopItem);
procedure DelShopItem (ci: TShopItem);
procedure DelUserShopItem (nItemidx:Integer;sItemName:string);
procedure DelShopItemEx(nItemidx:Integer);
function GetShopItemRoom(): Boolean;
procedure AddDealItem (ci: TClientItem);
procedure DelDealItem (ci: TClientItem);
procedure AddSellOffItem (ci: TClientItem); //添加到寄售出售框中 20080316
procedure MoveSellOffItemToBag; //寄售相关 20080316
procedure AddChallengeItem (ci: TClientItem);
procedure DelChallengeItem (ci: TClientItem);
procedure MoveChallengeItemToBag;
procedure AddChallengeRemoteItem (ci: TClientItem);
procedure DelChallengeRemoteItem (ci: TClientItem);
procedure MoveDealItemToBag;
procedure AddDealRemoteItem (ci: TClientItem);
procedure DelDealRemoteItem (ci: TClientItem);
function  GetDistance (sx, sy, dx, dy: integer): integer;
procedure GetNextPosXY (dir: byte; var x, y:Integer);
function GetNextPosCanXY (var dir: byte; x, y: Integer):Boolean;
procedure GetNextRunXY (dir: byte; var x, y:Integer);
procedure GetNextHorseRunXY (dir: byte; var x, y:Integer);
function  GetNextDirection (sx, sy, dx, dy: Integer): byte;
function  GetBack (dir: integer): integer;
procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
function  PrivDir (ndir: integer): integer;
function  NextDir (ndir: integer): integer;
function  GetTakeOnPosition (smode: integer): integer;
function  IsKeyPressed (key: byte): Boolean;
procedure AddChangeFace (recogid: integer);
procedure DelChangeFace (recogid: integer);
function  IsChangingFace (recogid: integer): Boolean;
function  GetTipsStr():string;
function  GetMagicIcon (Effect, Level: Byte; Id: Word; LevelEx: Byte; var Icon: Integer): TAspWMImages;
function GetHeroJobStr(btJob: Byte): string;

{$IF M2Version = 1}
function GetBatterMagicIcon(Effect: Byte): Integer;
{$IFEND}

{$IF M2Version <> 2}
function GetAAppendItemValue(Value : Byte): string;
function GetAppendItemValue(cu: TClientItem): string;
function GetSecretItemValue(cu: TClientItem): string;
function CheckItemSpiritMedia(cu: TClientItem): Boolean;
function GetHeroSkillMemoAddHp(level: Integer):Integer;
function FindHeroItemArrItemName(btType: Byte; flag: Boolean): Integer; overload;
function FindHeroItemArrItemName(sItemName: string): Integer; overload;
function FindHeroItemArrBindItemName(btType: Byte; flag: Boolean): Integer; overload;
function FindHeroItemArrBindItemName(sItemName: string): Integer; overload;
function HeroBagItemCount: Integer;
{$IFEND}
function boISAngerMagic(MagicID: Word): Boolean; //是否为怒之技能

function FindItemArrItemName(btType: Byte; flag: Boolean): Integer; overload;
function FindItemArrItemName(sItemName: string): Integer; overload;
function FindItemArrBindItemName(btType: Byte; flag: Boolean): Integer; overload;
function FindItemArrBindItemName(sItemName: string): Integer; overload;
function BagItemCount: Integer;

function GetMagicEffLevelEx(MagicID: Word): Byte; // Copy on 2011.11.18
function GetXinFaMagicByID(Id: Byte): Boolean;    // Copy
function GetItemEffectWil(idx: Byte): TAspWMImages;  // Copy



implementation

uses clMain, MShare;

function GetItemEffectWil(idx: Byte): TAspWMImages;
begin
  case idx of
    0: Result := g_WMainImages;
    1: Result := g_WMain2Images;
    2: Result := g_WMain3Images;
    3: Result := g_WUI1Images;
    4: Result := g_WEffectImages;
    5: Result := g_WStateEffectImages;
    6: Result := g_WHumWingImages;
    7: Result := g_WHumWing2Images;
    8: Result := g_WStateItemImages;
    9: Result := g_WStateItem2Images;
    else Result := nil;
  end;
end;

function GetXinFaMagicByID(Id: Byte): Boolean;
{$IF M2Version <> 2}
var
  i: integer;
  pm: PTClientMagic;
{$IFEND}
begin
{$IF M2Version <> 2}
  Result := False;
  if g_XinFaMagic.Count > 0 then //20080629
  for i:=0 to g_XinFaMagic.Count-1 do begin
    pm := PTClientMagic (g_XinFaMagic[i]);
    if pm.Def.wMagicId = Id then begin
       Result := True;
       break;
    end;
  end;
{$IFEND}
end;

function GetMagicEffLevelEx(MagicID: Word): Byte;
var
  I: Integer;
  pcm: PTClientMagic;
begin
  Result := 0;
  for I:=0 to g_MagicList.Count - 1 do begin
    pcm := PTClientMagic(g_MagicList[I]);
    if pcm <> nil then begin
      if pcm.Def.wMagicId = MagicID then begin
        Result := pcm.btLevelEx;
        Break;
      end;
    end;
  end;
end;

function BagItemCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I:=0 to MAXBAGITEMCL-1 do begin
    if g_ItemArr[I].Item.s.Name <> '' then Inc(Result);
  end;
end;
//btType 1 hp 2 mp 3特殊药品   flag: True为特效 False 非特效
function FindItemArrItemName(btType: Byte; flag: Boolean): Integer;
var
  I: integer;
begin
  try
    Result := -1;
    for I := MAXBAGITEMCL - 1 downto 0 do begin
      if (g_ItemArr[I].Item.S.Name <> '') and
         ((g_ItemArr[I].Item.S.StdMode = 0) or
         ((g_ItemArr[I].Item.S.StdMode = 17) and (g_ItemArr[I].Item.S.Shape = 237))) and
         (flag and (Pos('特效',g_ItemArr[I].Item.S.Name) > 0) or
         (not flag and (Pos('特效',g_ItemArr[I].Item.S.Name) = 0))) then begin
        case btType of
          1: begin
            if g_ItemArr[I].Item.S.AC > 0 then begin
              case g_ItemArr[I].Item.S.StdMode of
                0: begin
                  if g_ItemArr[I].Item.S.Shape = 0 then begin
                    Result := I;
                    break;
                  end;
                end;
                17: begin
                  if g_ItemArr[I].Item.S.AniCount = 0 then begin
                    Result := I;
                    break;
                  end;
                end;
              end;
            end;
          end;
          2: begin
            if g_ItemArr[I].Item.S.MAC > 0 then begin
              case g_ItemArr[I].Item.S.StdMode of
                0: begin
                  if g_ItemArr[I].Item.S.Shape = 0 then begin
                    Result := I;
                    break;
                  end;
                end;
                17: begin
                  if g_ItemArr[I].Item.S.AniCount = 0 then begin
                    Result := I;
                    break;
                  end;
                end;
              end;
            end;
          end;
          3: begin
            if g_ItemArr[I].Item.S.AC > 0 then begin
              case g_ItemArr[I].Item.S.StdMode of
                0: begin
                  if g_ItemArr[I].Item.S.Shape = 1 then begin
                    Result := I;
                    break;
                  end;
                end;
                17: begin
                  if g_ItemArr[I].Item.S.AniCount = 1 then begin
                    Result := I;
                    break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    DebugOutStr('[Exception] FindItemArrItemName1'); 
  end;
end;

function FindItemArrItemName(sItemName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I:=0 to MAXBAGITEMCL-1 do begin
    if g_ItemArr[I].Item.s.Name <> '' then begin
      if g_ItemArr[I].Item.s.Name = sItemName then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

//btType 1 hp 2 mp 3特殊药品   flag: True为特效 False 非特效
function FindItemArrBindItemName(btType: Byte; flag: Boolean): Integer;
var
  I: Integer;
begin
  try
    Result := -1;
    for I := MAXBAGITEMCL - 1 downto 0 do begin
      if (g_ItemArr[I].Item.S.Name <> '') and
        (g_ItemArr[I].Item.S.StdMode = 31) and
        ((flag and (Pos('特效',g_ItemArr[I].Item.S.Name) > 0)) or
        (not flag and (Pos('特效',g_ItemArr[I].Item.S.Name) = 0))) and
        (g_ItemArr[I].Item.S.AniCount = btType) then
      begin
        Result := I;
        break;
      end;
    end;
  except
    DebugOutStr('[Exception] FindItemArrBindItemName1');
  end;
end;
function FindItemArrBindItemName(sItemName: string): Integer;
  function FindBindList(s: string): Integer;
  var
    I: Integer;
    pcm: pTUnbindInfo;
  begin
    Result := -1;
    if g_UnBindList.Count > 0 then begin
      for I:=0 to g_UnBindList.Count -1 do begin
        pcm := pTUnbindInfo (g_UnBindList[i]);
        if s = pcm.sItemName then begin
          Result := pcm.nUnbindCode;   //找到解包文件的Shape值
          Break;
        end;
      end;
    end;
  end;
var
  I: Integer;
  nIndex: Integer;
begin
  Result := -1;
  nIndex := FindBindList(sItemName);
  if nIndex >= 0 then begin
    for I := MAXBAGITEMCL - 1 downto 0 do begin
      if (g_ItemArr[I].Item.S.Name <> '') and
        (g_ItemArr[I].Item.S.StdMode = 31) and
        (g_ItemArr[I].Item.S.Shape = nIndex) then
      begin
        Result := I;
        break;
      end;
    end;
  end;
end;
{$IF M2Version <> 2}
function HeroBagItemCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I:=0 to g_HeroBagCount-1 do begin
    if g_HeroItemArr[I].s.Name <> '' then Inc(Result);
  end;
end;
//btType 1 hp 2 mp 3特殊药品   flag: True为特效 False 非特效
function FindHeroItemArrItemName(btType: Byte; flag: Boolean): Integer;
var
  I: integer;
begin
  try
    Result := -1;
    for I := g_HeroBagCount - 1 downto 0 do begin
      if (g_HeroItemArr[I].S.Name <> '') and
         ((g_HeroItemArr[I].S.StdMode = 0) or
         ((g_HeroItemArr[I].S.StdMode = 17) and (g_HeroItemArr[I].S.Shape = 237))) and
         (flag and (Pos('特效',g_HeroItemArr[I].S.Name) > 0) or
         (not flag and (Pos('特效',g_HeroItemArr[I].S.Name) = 0))) then begin
        case btType of
          1: begin
            if g_HeroItemArr[I].S.AC > 0 then begin
              case g_HeroItemArr[I].S.StdMode of
                0: begin
                  if g_HeroItemArr[I].S.Shape = 0 then begin
                    Result := I;
                    break;
                  end;
                end;
                17: begin
                  if g_HeroItemArr[I].S.AniCount = 0 then begin
                    Result := I;
                    break;
                  end;
                end;
              end;
            end;
          end;
          2: begin
            if g_HeroItemArr[I].S.MAC > 0 then begin
              case g_HeroItemArr[I].S.StdMode of
                0: begin
                  if g_HeroItemArr[I].S.Shape = 0 then begin
                    Result := I;
                    break;
                  end;
                end;
                17: begin
                  if g_HeroItemArr[I].S.AniCount = 0 then begin
                    Result := I;
                    break;
                  end;
                end;
              end;
            end;
          end;
          3: begin
            if g_HeroItemArr[I].S.AC > 0 then begin
              case g_HeroItemArr[I].S.StdMode of
                0: begin
                  if g_HeroItemArr[I].S.Shape = 1 then begin
                    Result := I;
                    break;
                  end;
                end;
                17: begin
                  if g_HeroItemArr[I].S.AniCount = 1 then begin
                    Result := I;
                    break;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  except
    DebugOutStr('[Exception] FindHeroItemArrItemName1'); 
  end;
end;

function FindHeroItemArrItemName(sItemName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I:=0 to g_HeroBagCount-1 do begin
    if g_HeroItemArr[I].s.Name <> '' then begin
      if g_HeroItemArr[I].s.Name = sItemName then begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function FindHeroItemArrBindItemName(btType: Byte; flag: Boolean): Integer;
var
  I: Integer;
begin
  try
    Result := -1;
    for I := g_HeroBagCount - 1 downto 0 do begin
      if (g_HeroItemArr[I].S.Name <> '') and
        (g_HeroItemArr[I].S.StdMode = 31) and
        ((flag and (Pos('特效',g_HeroItemArr[I].S.Name) > 0)) or
        (not flag and (Pos('特效',g_HeroItemArr[I].S.Name) = 0))) and
        (g_HeroItemArr[I].S.AniCount = btType) then
      begin
        Result := I;
        break;
      end;
    end;
  except
    DebugOutStr('[Exception] FindHeroItemArrBindItemName1');
  end;
end;

function FindHeroItemArrBindItemName(sItemName: string): Integer;
  function FindBindList(s: string): Integer;
  var
    I: Integer;
    pcm: pTUnbindInfo;
  begin
    Result := -1;
    if g_UnBindList.Count > 0 then begin
      for I:=0 to g_UnBindList.Count -1 do begin
        pcm := pTUnbindInfo (g_UnBindList[i]);
        if s = pcm.sItemName then begin
          Result := pcm.nUnbindCode;   //找到解包文件的Shape值
          Break;
        end;
      end;
    end;
  end;
var
  I: Integer;
  nIndex: Integer;
begin
  Result := -1;
  nIndex := FindBindList(sItemName);
  if nIndex >= 0 then begin
    for I := g_HeroBagCount - 1 downto 0 do begin
      if (g_HeroItemArr[I].S.Name <> '') and
        (g_HeroItemArr[I].S.StdMode = 31) and
        (g_HeroItemArr[I].S.Shape = nIndex) then
      begin
        Result := I;
        break;
      end;
    end;
  end;
end;

function GetHeroSkillMemoAddHp(level: Integer):Integer;
begin
  if g_HeroSelf <> nil then begin
    case g_HeroSelf.m_btJob of//按职业增加HP上限
      0: Result := Round(142 +(((level-1)/2)*level+1) -((level/2)*(level+1)+1));//战
      1: begin
        if level < 10 then
          Result := Round(41 +(((level-1)/2)*level+1)-((level/2)*(level+1)+1))//法
        else Result := 23;
      end;
      2: Result := Round(109 +(((level-1)/2)*level+1) -((level/2)*(level+1)+1));//道
    end;
  end;
end;
//检查物品是否为灵媒物品
function CheckItemSpiritMedia(cu: TClientItem): Boolean;
begin
  Result := (cu.btAppraisalValue[2] in [231..250]) or (cu.btAppraisalValue[3] in [231..250]) or
            (cu.btAppraisalValue[4] in [231..250]) or (cu.btAppraisalValue[5] in [231..250]) or
            (cu.btUnKnowValue[6] in [231..250]) or (cu.btUnKnowValue[7] in [231..250]) or
            (cu.btUnKnowValue[8] in [231..250]) or (cu.btUnKnowValue[9] in [231..250]);
end;

function GetAAppendItemValue(Value : Byte): string;
begin
  Result := '';
  case Value of
    11..20:   Result := Format(' 攻击上限 +%d',[Value-10]);
    21..30:   Result := Format(' 魔法上限 +%d',[Value-20]);
    31..40:   Result := Format(' 道术上限 +%d',[Value-30]);
    41..50:   Result := Format(' 魔防上限 +%d',[Value-40]);
    51..60:   Result := Format(' 物防上限 +%d',[Value-50]);
    61..70:   Result := Format(' 主属性   +%d',[Value-60]);
    71..80:   Result := Format(' 内力恢复 +%d',[Value-70]);
    81..90:   Result := Format(' 聚魔等级 +%d',[Value-80]);
    91..100:  Result := Format(' 强身等级 +%d',[Value-90]);
    101..110: Result := Format(' 吸血上限 +%d',[Value-100]);
    111..120: Result := Format(' 内伤等级 +%d',[Value-110]);
    121..130: Result := Format(' 暴击等级 +%d',[Value-120]);
    131..140: Result := Format(' 防爆     +%d',[Value-130]);
    141..150: Result := Format(' 准确     +%d',[Value-140]);
    151..160: Result := Format(' 敏捷     +%d',[Value-150]);
    161..180: Result := Format(' 麻痹抗性 +%d',[Value-160]);
    181..230: Result := Format(' 合击威力 +%d',[Value-180]);
  end;
end;

function GetAppendItemValue(cu: TClientItem): string;
var
  LingMeiLines: string;
  I,  nCount: Integer;
begin
  Result := '';
  LingMeiLines := '';
  if cu.btAppraisalValue[2] > 0 then begin
    case cu.btAppraisalValue[2] of
      231..250: begin
        if cu.Aura > 0 then begin
          LingMeiLines := Format('\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (cu.btAppraisalValue[2]-230){值}) , cu.Aura, cu.MaxAura]);
        end else begin
          LingMeiLines := Format('\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (cu.btAppraisalValue[2]-230){值}) , 0, cu.MaxAura]);
        end;
      end
      else Result := GetAAppendItemValue(cu.btAppraisalValue[2]);
    end;
  end;
  for I := 3 to 5 do begin
    nCount := cu.btAppraisalValue[I];
    if nCount > 0 then begin
      case nCount of
        11..20:   Result := Format('%s\ 攻击上限 +%d',[Result, nCount-10]);
        21..30:   Result := Format('%s\ 魔法上限 +%d',[Result, nCount-20]);
        31..40:   Result := Format('%s\ 道术上限 +%d',[Result, nCount-30]);
        41..50:   Result := Format('%s\ 魔防上限 +%d',[Result, nCount-40]);
        51..60:   Result := Format('%s\ 物防上限 +%d',[Result, nCount-50]);
        61..70:   Result := Format('%s\ 主属性   +%d',[Result, nCount-60]);
        71..80:   Result := Format('%s\ 内力恢复 +%d',[Result, nCount-70]);
        81..90:   Result := Format('%s\ 聚魔等级 +%d',[Result, nCount-80]);
        91..100:  Result := Format('%s\ 强身等级 +%d',[Result, nCount-90]);
        101..110: Result := Format('%s\ 吸血上限 +%d',[Result, nCount-100]);
        111..120: Result := Format('%s\ 内伤等级 +%d',[Result, nCount-110]);
        121..130: Result := Format('%s\ 暴击等级 +%d',[Result, nCount-120]);
        131..140: Result := Format('%s\ 防爆     +%d',[Result, nCount-130]);
        141..150: Result := Format('%s\ 准确     +%d',[Result, nCount-140]);
        151..160: Result := Format('%s\ 敏捷     +%d',[Result, nCount-150]);
        161..180: Result := Format('%s\ 麻痹抗性 +%d',[Result, nCount-160]);
        181..230: Result := Format('%s\ 合击威力 +%d',[Result, nCount-180]);
        231..250: begin
          if cu.Aura > 0 then begin
            LingMeiLines := Format('\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (nCount-230){值}) , cu.Aura, cu.MaxAura]);
          end else begin
            LingMeiLines := Format('\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (nCount-230){值}) , 0, cu.MaxAura]);
          end;
        end;
      end;
    end;
  end;

(*

  if cu.btUnKnowValue[3] > 0 then begin
    case cu.btUnKnowValue[3] of
      11..20:   Result := Format('%s\ 攻击上限 +%d',[Result, cu.btUnKnowValue[3]-10]);
      21..30:   Result := Format('%s\ 魔法上限 +%d',[Result, cu.btUnKnowValue[3]-20]);
      31..40:   Result := Format('%s\ 道术上限 +%d',[Result, cu.btUnKnowValue[3]-30]);
      41..50:   Result := Format('%s\ 魔防上限 +%d',[Result, cu.btUnKnowValue[3]-40]);
      51..60:   Result := Format('%s\ 物防上限 +%d',[Result, cu.btUnKnowValue[3]-50]);
      61..70:   Result := Format('%s\ 主属性   +%d',[Result, cu.btUnKnowValue[3]-60]);
      71..80:   Result := Format('%s\ 内力恢复 +%d',[Result, cu.btUnKnowValue[3]-70]);
      81..90:   Result := Format('%s\ 聚魔等级 +%d',[Result, cu.btUnKnowValue[3]-80]);
      91..100:  Result := Format('%s\ 强身等级 +%d',[Result, cu.btUnKnowValue[3]-90]);
      101..110: Result := Format('%s\ 吸血上限 +%d',[Result, cu.btUnKnowValue[3]-100]);
      111..120: Result := Format('%s\ 内伤等级 +%d',[Result, cu.btUnKnowValue[3]-110]);
      121..130: Result := Format('%s\ 暴击等级 +%d',[Result, cu.btUnKnowValue[3]-120]);
      131..140: Result := Format('%s\ 防爆     +%d',[Result, cu.btUnKnowValue[3]-130]);
      141..150: Result := Format('%s\ 准确     +%d',[Result, cu.btUnKnowValue[3]-140]);
      151..160: Result := Format('%s\ 敏捷     +%d',[Result, cu.btUnKnowValue[3]-150]);
      161..180: Result := Format('%s\ 麻痹抗性 +%d',[Result, cu.btUnKnowValue[3]-160]);
      181..230: Result := Format('%s\ 合击威力 +%d',[Result, cu.btUnKnowValue[3]-180]);
      231..250: begin
        if cu.Aura > 0 then begin
          LingMeiLines := Format('\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (cu.btUnKnowValue[3]-230){值}) , cu.Aura, cu.MaxAura]);
        end else begin
          LingMeiLines := Format('\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (cu.btUnKnowValue[3]-230){值}) , 0, cu.MaxAura]);
        end;
      end;
    end;
  end;
  if cu.btUnKnowValue[4] > 0 then begin
    case cu.btUnKnowValue[4] of
      11..20:   Result := Format('%s\ 攻击上限 +%d',[Result, cu.btUnKnowValue[4]-10]);
      21..30:   Result := Format('%s\ 魔法上限 +%d',[Result, cu.btUnKnowValue[4]-20]);
      31..40:   Result := Format('%s\ 道术上限 +%d',[Result, cu.btUnKnowValue[4]-30]);
      41..50:   Result := Format('%s\ 魔防上限 +%d',[Result, cu.btUnKnowValue[4]-40]);
      51..60:   Result := Format('%s\ 物防上限 +%d',[Result, cu.btUnKnowValue[4]-50]);
      61..70:   Result := Format('%s\ 主属性   +%d',[Result, cu.btUnKnowValue[4]-60]);
      71..80:   Result := Format('%s\ 内力恢复 +%d',[Result, cu.btUnKnowValue[4]-70]);
      81..90:   Result := Format('%s\ 聚魔等级 +%d',[Result, cu.btUnKnowValue[4]-80]);
      91..100:  Result := Format('%s\ 强身等级 +%d',[Result, cu.btUnKnowValue[4]-90]);
      101..110: Result := Format('%s\ 吸血上限 +%d',[Result, cu.btUnKnowValue[4]-100]);
      111..120: Result := Format('%s\ 内伤等级 +%d',[Result, cu.btUnKnowValue[4]-110]);
      121..130: Result := Format('%s\ 暴击等级 +%d',[Result, cu.btUnKnowValue[4]-120]);
      131..140: Result := Format('%s\ 防爆     +%d',[Result, cu.btUnKnowValue[4]-130]);
      141..150: Result := Format('%s\ 准确     +%d',[Result, cu.btUnKnowValue[4]-140]);
      151..160: Result := Format('%s\ 敏捷     +%d',[Result, cu.btUnKnowValue[4]-150]);
      161..180: Result := Format('%s\ 麻痹抗性 +%d',[Result, cu.btUnKnowValue[4]-160]);
      181..230: Result := Format('%s\ 合击威力 +%d',[Result, cu.btUnKnowValue[4]-180]);
      231..250: begin
        if cu.Aura > 0 then begin
          LingMeiLines := Format('\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (cu.btUnKnowValue[4]-230){值}) , cu.Aura, cu.MaxAura]);
        end else begin
          LingMeiLines := Format('\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (cu.btUnKnowValue[4]-230){值}) , 0, cu.MaxAura]);
        end;
      end;
    end;
  end;
  if cu.btUnKnowValue[5] > 0 then begin
    case cu.btUnKnowValue[5] of
      11..20:   Result := Format('%s\ 攻击上限 +%d',[Result, cu.btUnKnowValue[5]-10]);
      21..30:   Result := Format('%s\ 魔法上限 +%d',[Result, cu.btUnKnowValue[5]-20]);
      31..40:   Result := Format('%s\ 道术上限 +%d',[Result, cu.btUnKnowValue[5]-30]);
      41..50:   Result := Format('%s\ 魔防上限 +%d',[Result, cu.btUnKnowValue[5]-40]);
      51..60:   Result := Format('%s\ 物防上限 +%d',[Result, cu.btUnKnowValue[5]-50]);
      61..70:   Result := Format('%s\ 主属性   +%d',[Result, cu.btUnKnowValue[5]-60]);
      71..80:   Result := Format('%s\ 内力恢复 +%d',[Result, cu.btUnKnowValue[5]-70]);
      81..90:   Result := Format('%s\ 聚魔等级 +%d',[Result, cu.btUnKnowValue[5]-80]);
      91..100:  Result := Format('%s\ 强身等级 +%d',[Result, cu.btUnKnowValue[5]-90]);
      101..110: Result := Format('%s\ 吸血上限 +%d',[Result, cu.btUnKnowValue[5]-100]);
      111..120: Result := Format('%s\ 内伤等级 +%d',[Result, cu.btUnKnowValue[5]-110]);
      121..130: Result := Format('%s\ 暴击等级 +%d',[Result, cu.btUnKnowValue[5]-120]);
      131..140: Result := Format('%s\ 防爆     +%d',[Result, cu.btUnKnowValue[5]-130]);
      141..150: Result := Format('%s\ 准确     +%d',[Result, cu.btUnKnowValue[5]-140]);
      151..160: Result := Format('%s\ 敏捷     +%d',[Result, cu.btUnKnowValue[5]-150]);
      161..180: Result := Format('%s\ 麻痹抗性 +%d',[Result, cu.btUnKnowValue[5]-160]);
      181..230: Result := Format('%s\ 合击威力 +%d',[Result, cu.btUnKnowValue[5]-180]);
      231..250: begin
        if cu.Aura > 0 then begin
          LingMeiLines := Format('\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (cu.btUnKnowValue[5]-230){值}) , cu.Aura, cu.MaxAura]);
        end else begin
          LingMeiLines := Format('\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (cu.btUnKnowValue[5]-230){值}) , 0, cu.MaxAura]);
        end;
      end;
    end;
  end;
*)
  if (Result <> '') or (LingMeiLines <> '') then begin
      Result := ' \<附加基础属性/c=Yellow>\'+Result + LingMeiLines;
  end;
end;

function GetSecretItemValue(cu: TClientItem): string;
var
  btNum: Byte;
begin
  Result := '';
  if (cu.btUnKnowValueCount > 0) and (cu.btUnKnowValueCount < 5) then begin
    btNum := 0;
    if cu.btUnKnowValue[6] > 0 then begin
      case cu.btUnKnowValue[6] of
        1..10: begin
          case cu.btUnKnowValue[6] of
            1: Result := ' <重生技能/c=Lime>\';
            2: Result := ' <八卦护身神技/c=Lime>\';
            3: Result := ' <麻痹神技/c=Lime>\';
            4: Result := ' <魔道麻痹技能/c=Lime>\';
            5: Result := ' <战意麻痹技能/c=Lime>\';
            6: Result := ' <探测技能/c=Lime>\';
            7: Result := ' <传送技能/c=Lime>\';
          end;
        end;
        11..20:   Result := Format(' 攻击上限 +%d',[cu.btUnKnowValue[6]-10]);
        21..30:   Result := Format(' 魔法上限 +%d',[cu.btUnKnowValue[6]-20]);
        31..40:   Result := Format(' 道术上限 +%d',[cu.btUnKnowValue[6]-30]);
        41..50:   Result := Format(' 魔防上限 +%d',[cu.btUnKnowValue[6]-40]);
        51..60:   Result := Format(' 物防上限 +%d',[cu.btUnKnowValue[6]-50]);
        61..70:   Result := Format(' 主属性   +%d',[cu.btUnKnowValue[6]-60]);
        71..80:   Result := Format(' 内力恢复 +%d',[cu.btUnKnowValue[6]-70]);
        81..90:   Result := Format(' 聚魔等级 +%d',[cu.btUnKnowValue[6]-80]);
        91..100:  Result := Format(' 强身等级 +%d',[cu.btUnKnowValue[6]-90]);
        101..110: Result := Format(' 吸血上限 +%d',[cu.btUnKnowValue[6]-100]);
        111..120: Result := Format(' 内伤等级 +%d',[cu.btUnKnowValue[6]-110]);
        121..130: Result := Format(' 暴击等级 +%d',[cu.btUnKnowValue[6]-120]);
        131..140: Result := Format(' 防爆     +%d',[cu.btUnKnowValue[6]-130]);
        141..150: Result := Format(' 准确     +%d',[cu.btUnKnowValue[6]-140]);
        151..160: Result := Format(' 敏捷     +%d',[cu.btUnKnowValue[6]-150]);
        161..180: Result := Format(' 麻痹抗性 +%d',[cu.btUnKnowValue[6]-160]);
        181..230: Result := Format(' 合击威力 +%d',[cu.btUnKnowValue[6]-180]);
        231..250: begin
          if cu.Aura > 0 then begin
            Result := Format('\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (cu.btUnKnowValue[6]-230){值}) , cu.Aura, cu.MaxAura]);
          end else begin
            Result := Format('\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (cu.btUnKnowValue[6]-230){值}) , 0, cu.MaxAura]);
          end;
        end;
        255: Result := '<神秘属性(待解读)/c=Red>\';      
      end;
    end;
    if cu.btUnKnowValue[7] > 0 then begin
      case cu.btUnKnowValue[7] of
        1..10: begin
          case cu.btUnKnowValue[7] of
            1: Result := Format('%s\ <重生技能/c=Lime>\', [Result]);
            2: Result := Format('%s\ <八卦护身神技/c=Lime>\', [Result]);
            3: Result := Format('%s\ <麻痹神技/c=Lime>\', [Result]);
            4: Result := Format('%s\ <魔道麻痹技能/c=Lime>\', [Result]);
            5: Result := Format('%s\ <战意麻痹技能/c=Lime>\', [Result]);
            6: Result := Format('%s\ <探测技能/c=Lime>\', [Result]);
            7: Result := Format('%s\ <传送技能/c=Lime>\', [Result]);
          end;
        end;
        11..20:   Result := Format('%s\ 攻击上限 +%d',[Result, cu.btUnKnowValue[7]-10]);
        21..30:   Result := Format('%s\ 魔法上限 +%d',[Result, cu.btUnKnowValue[7]-20]);
        31..40:   Result := Format('%s\ 道术上限 +%d',[Result, cu.btUnKnowValue[7]-30]);
        41..50:   Result := Format('%s\ 魔防上限 +%d',[Result, cu.btUnKnowValue[7]-40]);
        51..60:   Result := Format('%s\ 物防上限 +%d',[Result, cu.btUnKnowValue[7]-50]);
        61..70:   Result := Format('%s\ 主属性   +%d',[Result, cu.btUnKnowValue[7]-60]);
        71..80:   Result := Format('%s\ 内力恢复 +%d',[Result, cu.btUnKnowValue[7]-70]);
        81..90:   Result := Format('%s\ 聚魔等级 +%d',[Result, cu.btUnKnowValue[7]-80]);
        91..100:  Result := Format('%s\ 强身等级 +%d',[Result, cu.btUnKnowValue[7]-90]);
        101..110: Result := Format('%s\ 吸血上限 +%d',[Result, cu.btUnKnowValue[7]-100]);
        111..120: Result := Format('%s\ 内伤等级 +%d',[Result, cu.btUnKnowValue[7]-110]);
        121..130: Result := Format('%s\ 暴击等级 +%d',[Result, cu.btUnKnowValue[7]-120]);
        131..140: Result := Format('%s\ 防爆     +%d',[Result, cu.btUnKnowValue[7]-130]);
        141..150: Result := Format('%s\ 准确     +%d',[Result, cu.btUnKnowValue[7]-140]);
        151..160: Result := Format('%s\ 敏捷     +%d',[Result, cu.btUnKnowValue[7]-150]);
        161..180: Result := Format('%s\ 麻痹抗性 +%d',[Result, cu.btUnKnowValue[7]-160]);
        181..230: Result := Format('%s\ 合击威力 +%d',[Result, cu.btUnKnowValue[7]-180]);
        231..250: begin
          if cu.Aura > 0 then begin
            Result := Format('%s\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Result, Round(11.4 * (cu.btUnKnowValue[7]-230){值}) , cu.Aura, cu.MaxAura]);
          end else begin
            Result := Format('%s\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Result, Round(11.4 * (cu.btUnKnowValue[7]-230){值}) , 0, cu.MaxAura]);
          end;
        end;
        255: Result := Result + '\' + '<神秘属性(待解读)/c=Red>\';
      end;
    end;
    if cu.btUnKnowValue[8] > 0 then begin
      case cu.btUnKnowValue[8] of
        1..10: begin
          case cu.btUnKnowValue[8] of
            1: Result := Format('%s\ <重生技能/c=Lime>\', [Result]);
            2: Result := Format('%s\ <八卦护身神技/c=Lime>\', [Result]);
            3: Result := Format('%s\ <麻痹神技/c=Lime>\', [Result]);
            4: Result := Format('%s\ <魔道麻痹技能/c=Lime>\', [Result]);
            5: Result := Format('%s\ <战意麻痹技能/c=Lime>\', [Result]);
            6: Result := Format('%s\ <探测技能/c=Lime>\', [Result]);
            7: Result := Format('%s\ <传送技能/c=Lime>\', [Result]);
          end;
        end;
        11..20:   Result := Format('%s\ 攻击上限 +%d',[Result, cu.btUnKnowValue[8]-10]);
        21..30:   Result := Format('%s\ 魔法上限 +%d',[Result, cu.btUnKnowValue[8]-20]);
        31..40:   Result := Format('%s\ 道术上限 +%d',[Result, cu.btUnKnowValue[8]-30]);
        41..50:   Result := Format('%s\ 魔防上限 +%d',[Result, cu.btUnKnowValue[8]-40]);
        51..60:   Result := Format('%s\ 物防上限 +%d',[Result, cu.btUnKnowValue[8]-50]);
        61..70:   Result := Format('%s\ 主属性   +%d',[Result, cu.btUnKnowValue[8]-60]);
        71..80:   Result := Format('%s\ 内力恢复 +%d',[Result, cu.btUnKnowValue[8]-70]);
        81..90:   Result := Format('%s\ 聚魔等级 +%d',[Result, cu.btUnKnowValue[8]-80]);
        91..100:  Result := Format('%s\ 强身等级 +%d',[Result, cu.btUnKnowValue[8]-90]);
        101..110: Result := Format('%s\ 吸血上限 +%d',[Result, cu.btUnKnowValue[8]-100]);
        111..120: Result := Format('%s\ 内伤等级 +%d',[Result, cu.btUnKnowValue[8]-110]);
        121..130: Result := Format('%s\ 暴击等级 +%d',[Result, cu.btUnKnowValue[8]-120]);
        131..140: Result := Format('%s\ 防爆     +%d',[Result, cu.btUnKnowValue[8]-130]);
        141..150: Result := Format('%s\ 准确     +%d',[Result, cu.btUnKnowValue[8]-140]);
        151..160: Result := Format('%s\ 敏捷     +%d',[Result, cu.btUnKnowValue[8]-150]);
        161..180: Result := Format('%s\ 麻痹抗性 +%d',[Result, cu.btUnKnowValue[8]-160]);
        181..230: Result := Format('%s\ 合击威力 +%d',[Result, cu.btUnKnowValue[8]-180]);
        231..250: begin
          if cu.Aura > 0 then begin
            Result := Format('%s\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Result, Round(11.4 * (cu.btUnKnowValue[8]-230){值}) , cu.Aura, cu.MaxAura]);
          end else begin
            Result := Format('%s\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Result, Round(11.4 * (cu.btUnKnowValue[8]-230){值}) , 0, cu.MaxAura]);
          end;
        end;
        255: Result := Result + '\' + '<神秘属性(待解读)/c=Red>\';
      end;
    end;
    if cu.btUnKnowValue[9] > 0 then begin
      case cu.btUnKnowValue[9] of
        1..10: begin
          case cu.btUnKnowValue[9] of
            1: Result := Format('%s\ <重生技能/c=Lime>\', [Result]);
            2: Result := Format('%s\ <八卦护身神技/c=Lime>\', [Result]);
            3: Result := Format('%s\ <麻痹神技/c=Lime>\', [Result]);
            4: Result := Format('%s\ <魔道麻痹技能/c=Lime>\', [Result]);
            5: Result := Format('%s\ <战意麻痹技能/c=Lime>\', [Result]);
            6: Result := Format('%s\ <探测技能/c=Lime>\', [Result]);
            7: Result := Format('%s\ <传送技能/c=Lime>\', [Result]);
          end;
        end;
        11..20:   Result := Format('%s\ 攻击上限 +%d',[Result, cu.btUnKnowValue[9]-10]);
        21..30:   Result := Format('%s\ 魔法上限 +%d',[Result, cu.btUnKnowValue[9]-20]);
        31..40:   Result := Format('%s\ 道术上限 +%d',[Result, cu.btUnKnowValue[9]-30]);
        41..50:   Result := Format('%s\ 魔防上限 +%d',[Result, cu.btUnKnowValue[9]-40]);
        51..60:   Result := Format('%s\ 物防上限 +%d',[Result, cu.btUnKnowValue[9]-50]);
        61..70:   Result := Format('%s\ 主属性   +%d',[Result, cu.btUnKnowValue[9]-60]);
        71..80:   Result := Format('%s\ 内力恢复 +%d',[Result, cu.btUnKnowValue[9]-70]);
        81..90:   Result := Format('%s\ 聚魔等级 +%d',[Result, cu.btUnKnowValue[9]-80]);
        91..100:  Result := Format('%s\ 强身等级 +%d',[Result, cu.btUnKnowValue[9]-90]);
        101..110: Result := Format('%s\ 吸血上限 +%d',[Result, cu.btUnKnowValue[9]-100]);
        111..120: Result := Format('%s\ 内伤等级 +%d',[Result, cu.btUnKnowValue[9]-110]);
        121..130: Result := Format('%s\ 暴击等级 +%d',[Result, cu.btUnKnowValue[9]-120]);
        131..140: Result := Format('%s\ 防爆     +%d',[Result, cu.btUnKnowValue[9]-130]);
        141..150: Result := Format('%s\ 准确     +%d',[Result, cu.btUnKnowValue[9]-140]);
        151..160: Result := Format('%s\ 敏捷     +%d',[Result, cu.btUnKnowValue[9]-150]);
        161..180: Result := Format('%s\ 麻痹抗性 +%d',[Result, cu.btUnKnowValue[9]-160]);
        181..230: Result := Format('%s\ 合击威力 +%d',[Result, cu.btUnKnowValue[9]-180]);
        231..250: begin
          if cu.Aura > 0 then begin
            Result := Format('%s\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Result, Round(11.4 * (cu.btUnKnowValue[9]-230){值}) , cu.Aura, cu.MaxAura]);
          end else begin
            Result := Format('%s\ \<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Result, Round(11.4 * (cu.btUnKnowValue[9]-230){值}) , 0, cu.MaxAura]);
          end;
        end; 
        255: Result := Result + '\' + '<神秘属性(待解读)/c=Red>\';
      end;
    end;
    if Result <> '' then begin
      if (cu.btUnKnowValue[6] > 0) and (cu.btUnKnowValue[6] < 255) then Inc(btNum);
      if (cu.btUnKnowValue[7] > 0) and (cu.btUnKnowValue[7] < 255) then Inc(btNum);
      if (cu.btUnKnowValue[8] > 0) and (cu.btUnKnowValue[8] < 255) then Inc(btNum);
      if (cu.btUnKnowValue[9] > 0) and (cu.btUnKnowValue[9] < 255) then Inc(btNum);
      Result := Format(' \<附加神秘属性(%d/%d)/c=Yellow>\', [btNum, cu.btUnKnowValueCount]) + Result;
    end;
  end;
end;
{$IFEND}

//是否为怒之技能
function boISAngerMagic(MagicID: Word): Boolean;
begin
  Result := MagicID in [200,202,204,206,208,210,212,214,216,218,220,222,224,226,228,230,232,234,236,239,241];
end;

function GetMagicIcon (Effect, Level: Byte; Id: Word; LevelEx: Byte; var Icon: Integer): TAspWMImages;
begin
  Result := nil;
  if LevelEx in [1..9] then begin //强化
    case Effect of
      56: begin//圆月弯刀
        Icon := 420;
      end;
      13, 54: begin//刺杀
        Icon := 430;
      end;
      5: begin//攻杀
        Icon := 440;
      end;
      24: begin //烈火剑法
        Icon := 460;
      end;
      53: begin //逐日剑法
        Icon := 470;
      end;
      10, 100: begin//火符,4级火符
        Icon := 490;
      end;
      12: begin//神圣战甲术
        Icon := 510;
      end;
      4, 77: begin //施毒术,4级施毒术
        Icon := 520;
      end;
      48, 74: begin//噬血术,4级噬血术
        Icon := 530;
      end;
      11: begin//幽灵盾
        Icon := 540;
      end;
      15: begin//召唤骷髅
        Icon := 550;
      end;
      76: begin//召唤圣兽
        Icon := 560;
      end;
      21: begin//爆裂火焰
        Icon := 580;
      end;
      31: begin //冰咆哮
        Icon := 590;
      end;
      20: begin //火墙
        Icon := 600;
      end;
      8: begin //疾光电影
        Icon := 610;
      end;
      9, 75: begin//雷电术,4级雷电
        Icon := 630;
      end;
      51, 80: begin//流星火雨,4级流星火雨
        Icon := 640;
      end;
      34, 101: begin//灭天火,4级灭天火
        Icon := 650;
      end;
    end;
    Icon := Icon + _MIN(3, (LevelEx-1) div 2) * 2;
    Result := g_WMagIconImages;
  end else begin
    case Effect of
      0: begin
        if Id = 88 then icon := 146    //4级基本剑术
        else icon := Effect * 2;
      end;
      10, 100: begin
        if Level = 4 then icon := 140  //4级火符
        else icon := Effect * 2;
      end;
      //17: icon := 444; //4级刺杀剑术
      //23: icon := 420; //圆月弯刀
      24: begin
        if Level = 4 then icon := 142  //4级烈火图标
        else icon := Effect * 2;
      end;
      34,101,123,122: begin
        if Level = 4 then icon := 144  //4级灭天火图标
        else icon := Effect * 2;
      end;
      54: icon := 444; //4级刺杀剑术
      56: icon := 420; //圆月弯刀
      74: icon := 148; //噬血术
      75: icon := 456; //4级雷电术
      76: icon := 160; //召唤圣兽
      77: icon := 474; //施毒术
      80: icon := 160; //流星火雨
      81: Icon := 170; //血魄一击(战)
      82: Icon := 172; //血魄一击(法)
      83: Icon := 174; //血魄一击(道)
      91: icon := 0;//护体神盾魔法拦的图标  20080229
      92: Icon := 761; //强身术
      95: ICon := 767; //神秘解读
      96: Icon := 170; //神龙附体
      97: Icon := 172; //唯我独尊
      98: Icon := 530; //召唤巨魔
      102:icon := 952;//三绝杀
      103:icon := 944;//双龙破
      104:icon := 934;//虎啸诀
      105:icon := 950;//追心刺
      106:icon := 942;//凤舞祭
      107:icon := 936;//八卦掌
      108:icon := 956;//断岳斩
      109:icon := 946;//惊雷爆
      110:icon := 932;//三焰咒
      111:icon := 954;//横扫千军
      112:icon := 940;//冰天雪地
      113:icon := 930;//万剑归宗
      114:Icon := 960;//斗转星移
      {$IF M2Version <> 2}
      129:Icon := 580;//龙卫心法、传承心法
      130: Icon := 590; //冰霜雪雨
      131: Icon := 594;// 纵横剑术
      132: Icon := 592;// 裂神符
      133: Icon := 586;//死亡之眼
      134: Icon := 582;//冰霜群雨
      135: Icon := 610; //怒噬回天
      136: Icon := 612;//天雷乱舞
      137: Icon := 584;//十步一杀
      {$IFEND}
    else icon := Effect * 2;
    end;
    case Effect of
      54,56,75,77,80..83,96..98, 129..137: Result := g_WMagIcon2Images; //4级刺杀剑术
      92,95: Result := g_WUI1Images;
      102..114: Result := g_WMainImages;
    else Result := g_WMagIconImages;
    end;
  end;
end;

{begin
  Result := nil;
  case Effect of
    0: begin
      if Id = 88 then icon := 146    //4级基本剑术
      else icon := Effect * 2;
    end;
    10, 100: begin
      if Level = 4 then icon := 140  //4级火符
      else icon := Effect * 2;
    end;
    //17: icon := 444; //4级刺杀剑术
    //23: icon := 420; //圆月弯刀
    24: begin
      if Level = 4 then icon := 142  //4级烈火图标
      else icon := Effect * 2;
    end;
    34,101,123,122: begin
      if Level = 4 then icon := 144  //4级灭天火图标
      else icon := Effect * 2;
    end;
    54: icon := 444; //4级刺杀剑术
    56: icon := 420; //圆月弯刀
    74: icon := 148; //噬血术
    75: icon := 456; //4级雷电术
    76: icon := 160; //召唤圣兽
    77: icon := 474; //施毒术
    80: icon := 160; //流星火雨
    81: Icon := 170; //血魄一击(战)
    82: Icon := 172; //血魄一击(法)
    83: Icon := 174; //血魄一击(道)
    91: icon := 0;//护体神盾魔法拦的图标  20080229
    92: Icon := 761; //强身术
    95: ICon := 767; //神秘解读
    96: Icon := 170; //神龙附体
    97: Icon := 172; //唯我独尊
    98: Icon := 530; //召唤巨魔
    102:icon := 952;//三绝杀
    103:icon := 944;//双龙破
    104:icon := 934;//虎啸诀
    105:icon := 950;//追心刺
    106:icon := 942;//凤舞祭
    107:icon := 936;//八卦掌
    108:icon := 956;//断岳斩
    109:icon := 946;//惊雷爆
    110:icon := 932;//三焰咒
    111:icon := 954;//横扫千军
    112:icon := 940;//冰天雪地
    113:icon := 930;//万剑归宗
    114:Icon := 960;//斗转星移
  else icon := Effect * 2;
  end;
  case Effect of
    54,56,75,77,80..83,96..98: Result := g_WMagIcon2Images; //4级刺杀剑术
    92,95: Result := g_WUI1Images;
    102..114: Result := g_WMainImages;
  else Result := g_WMagIconImages;
  end;
end;}

{$IF M2Version = 1}
function GetBatterMagicIcon(Effect: Byte): Integer;
begin
  case Effect of
    102: Result := 952;//三绝杀
    103: Result := 944;//双龙破
    104: Result := 934;//虎啸诀
    105: Result := 950;//追心刺
    106: Result := 942;//凤舞祭
    107: Result := 936;//八卦掌
    108: Result := 956;//断岳斩
    109: Result := 946;//惊雷爆
    110: Result := 932;//三焰咒
    111: Result := 954;//横扫千军
    112: Result := 940;//冰天雪地
    113: Result := 930;//万剑归宗
    else Result := -1;
  end;
end;
{$IFEND}

//格式化字符串为指定长度（后面添空格）
function fmStr (str: string; len: integer): string;
var i: integer;
begin
try
   Result := str + ' ';
   for i:=1 to len - Length(str)-1 do
      Result := Result + ' ';
except
	Result := str + ' ';
end;
end;
//整数转换为千位带逗号的字符串，例如1234567转换为“1,234,567”
//这里用于显示金钱数量
function  GetGoldStr (gold: integer): string;
var
   i, n: integer;
   str: string;
begin
   str := IntToStr (gold);
   n := 0;
   Result := '';
   for i:=Length(str) downto 1 do begin
      if n = 3 then begin
         Result := str[i] + ',' + Result;
         n := 1;
      end else begin
         Result := str[i] + Result;
         Inc(n);
      end;
   end;
end;
//保存装备物品到文件
procedure SaveBags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then
      fhandle := FileOpen (flname, fmOpenWrite or fmShareDenyNone)
   else fhandle := FileCreate (flname);
   if fhandle > 0 then begin
      FileWrite (fhandle, pbuf^, sizeof(TItemArr) * MAXBAGITEMCL);
      FileClose (fhandle);
   end;
end;
//装载装备物品
procedure Loadbags (flname: string; pbuf: Pbyte);
var
   fhandle: integer;
begin
   if FileExists (flname) then begin
      fhandle := FileOpen (flname, fmOpenRead or fmShareDenyNone);
      if fhandle > 0 then begin
         FileRead (fhandle, pbuf^, sizeof(TItemArr) * MAXBAGITEMCL);
         FileClose (fhandle);
      end;
   end;
end;
//清除物品
procedure ClearBag;
var
   i: integer;
begin
   for i:=0 to MAXBAGITEMCL-1 do
      g_ItemArr[I].Item.S.Name := '';
end;
//增加包裹物品状态为锁定
function AddItemBagLock(cu: TClientItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I:=0 to MAXBAGITEMCL-1 do begin
    if (g_ItemArr[I].Item.MakeIndex = cu.MakeIndex) and (g_ItemArr[I].Item.S.Name = cu.S.Name) then begin
       g_ItemArr[i].boLockItem := True;
       Result := True;
       Break;
    end;
  end;
end;
//删除包裹物品状态为锁定
function DelItemBagLock(cu: TClientItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I:=0 to MAXBAGITEMCL-1 do begin
    if (g_ItemArr[I].Item.MakeIndex = cu.MakeIndex) and (g_ItemArr[I].Item.S.Name = cu.S.Name) then begin
       g_ItemArr[i].boLockItem := False;
       Result := True;
       Break;
    end;
  end;
end;
//添加物品
function  AddItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   //检查要添加的物品是否已经存在
   for i:=0 to MAXBAGITEMCL-1 do begin
      if (g_ItemArr[I].Item.MakeIndex = cu.MakeIndex) and (g_ItemArr[I].Item.S.Name = cu.S.Name) then begin
         exit;
      end;
   end;

   if cu.S.Name = '' then exit;
   if (cu.S.StdMode <= 3) or ((cu.S.StdMode = 60) and (cu.S.Shape <> 0)) or ((cu.S.StdMode = 17) and (cu.S.Shape = 237)) then begin //可以使用的物品,首先放在快捷物品栏
      if (cu.S.StdMode = 2) and (cu.S.Need = 1) then  //不允许放入的物品 20080331
      
      else begin
        for i:=0 to 5 do
           if g_ItemArr[I].Item.S.Name = '' then begin     //找一个空档放下
              g_ItemArr[I].Item := cu;
              Result := TRUE;
              Exit;
           end;
      end;
   end;
   for i:=6 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[I].Item.S.Name = '' then begin
         g_ItemArr[I].Item := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
end;

function  AddHeroItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=0 to g_HeroBagCount-1 do begin
      if (g_HeroItemArr[I].MakeIndex = cu.MakeIndex) and (g_HeroItemArr[I].S.Name = cu.S.Name) then begin
         Exit;  
      end;
   end;

   if cu.S.Name = '' then exit;
   for i:=0 to MAXHEROBAGITEM{英雄包裹最大容量在G单元里}-1 do begin
      if g_HeroItemArr[I].S.Name = '' then begin
         g_HeroItemArr[I] := cu;
         Result := TRUE;
         break;
      end;
   end;
   ArrangeHeroItembag;
end;
//用当前的物品属性替代已经存在的该物品属性
function  HeroUpdateItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_HeroItemArr[i].S.Name = cu.S.Name) and (g_HeroItemArr[i].MakeIndex = cu.MakeIndex) then begin
         g_HeroItemArr[i] := cu;  //诀单捞飘
         Result := TRUE;
         break;
      end;
   end;
end;
//删除指定的物品
function  DelHeroItemBag (iname: string; iindex: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_HeroItemArr[I].S.Name = iname) and (g_HeroItemArr[I].MakeIndex = iindex) then begin
         FillChar (g_HeroItemArr[I], sizeof(TClientItem), #0);
         Result := TRUE;
         break;
      end;
   end;
   ArrangeHeroItembag;
end;
//用当前的物品属性替代已经存在的该物品属性
function  UpdateItemBag (cu: TClientItem): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_ItemArr[i].Item.S.Name = cu.S.Name) and (g_ItemArr[i].Item.MakeIndex = cu.MakeIndex) then begin
         g_ItemArr[i].Item := cu;  //诀单捞飘
         Result := TRUE;
         break;
      end;
   end;
end;
//删除指定的物品
function  DelItemBag (iname: string; iindex: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   for i:=MAXBAGITEMCL-1 downto 0 do begin
      if (g_ItemArr[I].Item.S.Name = iname) and (g_ItemArr[I].Item.MakeIndex = iindex) then begin
         FillChar (g_ItemArr[i], sizeof(TItemArr), #0);
         Result := TRUE;
         break;
      end;
   end;
   ArrangeItembag;
end;
//整理物品包
procedure ArrangeItemBag;
var
   i, k: integer;
begin
   //整理背包物品
   for i:=0 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[I].Item.S.Name <> '' then begin
         for k:=i+1 to MAXBAGITEMCL-1 do begin   //清除相同的物品
            if (g_ItemArr[I].Item.S.Name = g_ItemArr[k].Item.S.Name) and (g_ItemArr[I].Item.MakeIndex = g_ItemArr[k].Item.MakeIndex) then begin
               FillChar (g_ItemArr[k], sizeof(TItemArr), #0);
            end;
         end;
         {for k:=0 to 9 do begin
            if (ItemArr[i].S.Name = DealItems[k].S.Name) and (ItemArr[i].MakeIndex = DealItems[k].MakeIndex) then begin
               FillChar (ItemArr[i], sizeof(TClientItem), #0);
               //FillChar (DealItems[k], sizeof(TClientItem), #0);
            end;
         end; }
         //若有移动的物品
         if (g_ItemArr[I].Item.S.Name = g_MovingItem.Item.S.Name) and (g_ItemArr[I].Item.MakeIndex = g_MovingItem.Item.MakeIndex) then begin
            g_MovingItem.Index := 0;
            g_MovingItem.Item.S.Name := '';
         end;
      end;
   end;

   //6样快捷物品栏物品
   for i:=46 to MAXBAGITEMCL-1 do begin
      if g_ItemArr[I].Item.S.Name <> '' then begin
         for k:=6 to 45 do begin
            if g_ItemArr[k].Item.S.Name = '' then begin
               g_ItemArr[k].Item := g_ItemArr[I].Item;
               g_ItemArr[I].Item.S.Name := '';
               break;
            end;
         end;
      end;
   end; 
end;


//整理英雄包 $017 2007.10.23
procedure ArrangeHeroItemBag;
var
   i, k: integer;
begin
   //整理背包物品
   for i:=0 to MAXBAGITEMCL-1 do begin
      if g_HeroItemArr[I].S.Name <> '' then begin
         for k:=i+1 to MAXBAGITEMCL-1 do begin
            if (g_HeroItemArr[I].S.Name = g_HeroItemArr[k].S.Name) and (g_HeroItemArr[I].MakeIndex = g_HeroItemArr[k].MakeIndex) then begin
               FillChar (g_HeroItemArr[k], sizeof(TClientItem), #0);
            end;
         end;
         //若有移动的物品
         if (g_HeroItemArr[I].S.Name = g_MovingHeroItem.Item.S.Name) and (g_HeroItemArr[I].MakeIndex = g_MovingHeroItem.Item.MakeIndex) then begin
            g_MovingHeroItem.Index := 0;
            g_MovingHeroItem.Item.S.Name := '';
         end;
      end;
   end;

   {//6样快捷物品栏物品
   for i:=46 to MAXBAGITEMCL-1 do begin
      if g_HeroItemArr[I].S.Name <> '' then begin
         for k:=6 to 45 do begin
            if g_HeroItemArr[k].S.Name = '' then begin
               g_HeroItemArr[k] := g_HeroItemArr[I];
               g_HeroItemArr[I].S.Name := '';
               break;
            end;
         end;
      end;
   end;  }
end;
{----------------------------------------------------------}
//添加跌落物品
procedure AddDropItem (ci: TClientItem);
var
   pc: PTClientItem;
begin
   new (pc);
   pc^ := ci;
   DropItems.Add (pc);
end;
//获取跌落物品
function  GetDropItem (iname: string; MakeIndex: integer): PTClientItem;
var
   i: integer;
begin
   Result := nil;
   if DropItems.Count > 0 then //20080629
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Result := PTClientItem(DropItems[i]);
         break;
      end;
   end;
end;
//删除跌落物品
procedure DelDropItem (iname: string; MakeIndex: integer);
var
   I: integer;
begin
   if DropItems.Count > 0 then //20080629
   for i:=0 to DropItems.Count-1 do begin
      if (PTClientItem(DropItems[i]).S.Name = iname) and (PTClientItem(DropItems[i]).MakeIndex = MakeIndex) then begin
         Dispose (PTClientItem(DropItems[i]));
         DropItems.Delete (i);
         break;
      end;
   end;
end;
{----------------------------------------------------------}
procedure AddShopItem (ci: TShopItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if g_ShopItems[i].Item.S.Name = '' then begin
         g_ShopItems[i] := ci;
         break;
      end;
   end;
end;
procedure DelShopItem (ci: TShopItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if (g_ShopItems[i].Item.S.Name = ci.Item.S.Name) and (g_ShopItems[i].Item.MakeIndex = ci.Item.MakeIndex) then begin
         FillChar (g_ShopItems[i], sizeof(TShopItem), #0);
         break;
      end;
   end;
end;

procedure DelUserShopItem (nItemidx:Integer;sItemName:string);
var
  I:integer;
begin
  try
    for I:=Low(g_UserShopItem) to High(g_UserShopItem) do begin
      if (g_UserShopItem[I].Item.MakeIndex=nItemidx) then begin
        g_UserShopItem[I].Item.S.Name:='';
        break;
      end;
    end;
  except
    DebugOutStr('[Exception] UnClFunc.DelUserShopItem');
  end;
end;

procedure DelShopItemEx(nItemidx:Integer);
var
  I:integer;
  sItemName: string;
begin
  try
    sItemName := '';
    for I:=Low(g_ShopItems) to High(g_ShopItems) do begin
      if (g_ShopItems[I].Item.MakeIndex=nItemidx) then begin
        sItemName := g_ShopItems[I].Item.S.Name;
        g_ShopItems[I].Item.S.Name:='';
        break;
      end;
    end;
    if sItemName <> '' then DelItemBag(sItemName, nItemidx);
  except
    DebugOutStr('[Exception] UnClFunc.DelShopItemEx');
  end;
end;

function GetShopItemRoom(): Boolean;
var
  I: Integer;
begin
  Result := False;
  for i:=0 to 9 do begin
    if g_ShopItems[i].Item.S.Name = '' then begin
       Result := True;
       break;
    end;
  end;
end;
{----------------------------------------------------------}

procedure AddDealItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if g_DealItems[i].S.Name = '' then begin
         g_DealItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelDealItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if (g_DealItems[i].S.Name = ci.S.Name) and (g_DealItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_DealItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;
{******************************************************************************}
//挑战 20080705
procedure AddChallengeItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if g_ChallengeItems[i].S.Name = '' then begin
         g_ChallengeItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelChallengeItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if (g_ChallengeItems[i].S.Name = ci.S.Name) and (g_ChallengeItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_ChallengeItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

procedure MoveChallengeItemToBag;
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if g_ChallengeItems[i].S.Name <> '' then
         AddItemBag (g_ChallengeItems[i]);
   end;
   FillChar (g_ChallengeItems, sizeof(TClientItem)*4, #0);
end;

procedure AddChallengeRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if g_ChallengeRemoteItems[i].S.Name = '' then begin
         g_ChallengeRemoteItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelChallengeRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 3 do begin
      if (g_ChallengeRemoteItems[i].S.Name = ci.S.Name) and (g_ChallengeRemoteItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_ChallengeRemoteItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

{******************************************************************************}
//元宝寄售系统 20080316
procedure AddSellOffItem (ci: TClientItem); //添加到寄售出售框中
var
   i: integer;
begin
   for i:=0 to 9-1 do begin
      if g_SellOffItems[i].S.Name = '' then begin
         g_SellOffItems[i] := ci;
         break;
      end;
   end;
end;

procedure MoveSellOffItemToBag;   //寄售相关 20080316
var
   i: integer;
begin
   for i:=0 to 9-1 do begin
      if g_SellOffItems[i].S.Name <> '' then
         AddItemBag (g_SellOffItems[i]);
   end;
   FillChar (g_SellOffItems, sizeof(TClientItem)*9, #0);
end;
{******************************************************************************}
procedure MoveDealItemToBag;
var
   i: integer;
begin
   for i:=0 to 10-1 do begin
      if g_DealItems[i].S.Name <> '' then
         AddItemBag (g_DealItems[i]);
   end;
   FillChar (g_DealItems, sizeof(TClientItem)*10, #0);
end;

procedure AddDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 20-1 do begin
      if g_DealRemoteItems[i].S.Name = '' then begin
         g_DealRemoteItems[i] := ci;
         break;
      end;
   end;
end;

procedure DelDealRemoteItem (ci: TClientItem);
var
   i: integer;
begin
   for i:=0 to 20-1 do begin
      if (g_DealRemoteItems[i].S.Name = ci.S.Name) and (g_DealRemoteItems[i].MakeIndex = ci.MakeIndex) then begin
         FillChar (g_DealRemoteItems[i], sizeof(TClientItem), #0);
         break;
      end;
   end;
end;

{----------------------------------------------------------}
//计算两点间的距离（X或Y方向）
function  GetDistance (sx, sy, dx, dy: integer): integer;
begin
   Result := _MAX(abs(sx-dx), abs(sy-dy));
end;
//根据方向和当前位置确定下一个位置坐标(位移量=1）
procedure GetNextPosXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-1; end;
      DR_UPRIGHT:   begin x := x+1; y := y-1; end;
      DR_RIGHT:  begin x := x+1; y := y; end;
      DR_DOWNRIGHT:  begin x := x+1; y := y+1; end;
      DR_DOWN:   begin x := x;   y := y+1; end;
      DR_DOWNLEFT:   begin x := x-1; y := y+1; end;
      DR_LEFT:   begin x := x-1; y := y; end;
      DR_UPLEFT:  begin x := x-1; y := y-1; end;
   end;
end;
//找方向和当前位置确定可走下一个位置坐标(位移量=1)
function GetNextPosCanXY (var dir: byte; x, y: Integer):Boolean;
var
  mx,my: Integer;
begin
  Result := False;
  dir := 0;//GetNextDirection(x, y, TargetX, TargetY);
  while True do begin
    if dir > DR_UPLEFT then break;   //DIR 到最后一个方向 还走不了 那么退出
    case dir of
      DR_UP: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_UP, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_UP;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_UPRIGHT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_UPRIGHT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_UPRIGHT;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_RIGHT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_RIGHT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_RIGHT;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_DOWNRIGHT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_DOWNRIGHT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_DOWNRIGHT;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_DOWN: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_DOWN, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_DOWN;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_DOWNLEFT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_DOWNLEFT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_DOWNLEFT;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_LEFT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_LEFT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_LEFT;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end;
      DR_UPLEFT: begin
         mx := x;
         my := y;
         GetNextPosXY (DR_UPLEFT, mx, my);
         if PlayScene.CanWalk(mx, my) then begin
            //x:=mx;
            //y:=my;
            Dir:=DR_UPLEFT;
            Result := True;
            break;
         end else begin
            inc(dir);
            Continue;
         end;
      end; else Break;
    end;
  end;
end;
//根据方向和当前位置确定下一个位置坐标(位移量=2）
procedure GetNextRunXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-2; end;
      DR_UPRIGHT:   begin x := x+2; y := y-2; end;
      DR_RIGHT:  begin x := x+2; y := y; end;
      DR_DOWNRIGHT:  begin x := x+2; y := y+2; end;
      DR_DOWN:   begin x := x;   y := y+2; end;
      DR_DOWNLEFT:   begin x := x-2; y := y+2; end;
      DR_LEFT:   begin x := x-2; y := y; end;
      DR_UPLEFT:  begin x := x-2; y := y-2; end;
   end;
end;

procedure GetNextHorseRunXY (dir: byte; var x, y:Integer);
begin
   case dir of
      DR_UP:     begin x := x;   y := y-3; end;
      DR_UPRIGHT:   begin x := x+3; y := y-3; end;
      DR_RIGHT:  begin x := x+3; y := y; end;
      DR_DOWNRIGHT:  begin x := x+3; y := y+3; end;
      DR_DOWN:   begin x := x;   y := y+3; end;
      DR_DOWNLEFT:   begin x := x-3; y := y+3; end;
      DR_LEFT:   begin x := x-3; y := y; end;
      DR_UPLEFT:  begin x := x-3; y := y-3; end;
   end;
end;

//根据两点计算移动的方向
function GetNextDirection (sx, sy, dx, dy: Integer): byte;
var
   flagx, flagy: integer;
begin
   Result := DR_DOWN;
   if sx < dx then flagx := 1
   else if sx = dx then flagx := 0
   else flagx := -1;
   if abs(sy-dy) > 2
    then if (sx >= dx-1) and (sx <= dx+1) then flagx := 0;

   if sy < dy then flagy := 1
   else if sy = dy then flagy := 0
   else flagy := -1;
   if abs(sx-dx) > 2 then if (sy > dy-1) and (sy <= dy+1) then flagy := 0;

   if (flagx = 0)  and (flagy = -1) then Result := DR_UP;
   if (flagx = 1)  and (flagy = -1) then Result := DR_UPRIGHT;
   if (flagx = 1)  and (flagy = 0)  then Result := DR_RIGHT;
   if (flagx = 1)  and (flagy = 1)  then Result := DR_DOWNRIGHT;
   if (flagx = 0)  and (flagy = 1)  then Result := DR_DOWN;
   if (flagx = -1) and (flagy = 1)  then Result := DR_DOWNLEFT;
   if (flagx = -1) and (flagy = 0)  then Result := DR_LEFT;
   if (flagx = -1) and (flagy = -1) then Result := DR_UPLEFT;
end;

//根据当前方向获得转身后的方向
function  GetBack (dir: integer): integer;
begin
   Result := DR_UP;
   case dir of
      DR_UP:     Result := DR_DOWN;
      DR_DOWN:   Result := DR_UP;
      DR_LEFT:   Result := DR_RIGHT;
      DR_RIGHT:  Result := DR_LEFT;
      DR_UPLEFT:     Result := DR_DOWNRIGHT;
      DR_UPRIGHT:    Result := DR_DOWNLEFT;
      DR_DOWNLEFT:   Result := DR_UPRIGHT;
      DR_DOWNRIGHT:  Result := DR_UPLEFT;
   end;
end;
//根据当前坐标和方向获得后退的坐标
procedure GetBackPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
   newx := sx;
   newy := sy;
   case dir of
      DR_UP:      newy := newy+1;
      DR_DOWN:    newy := newy-1;
      DR_LEFT:    newx := newx+1;
      DR_RIGHT:   newx := newx-1;
      DR_UPLEFT:
         begin
            newx := newx + 1;
            newy := newy + 1;
         end;
      DR_UPRIGHT:
         begin
            newx := newx - 1;
            newy := newy + 1;
         end;
      DR_DOWNLEFT:
         begin
            newx := newx + 1;
            newy := newy - 1;
         end;
      DR_DOWNRIGHT:
         begin
            newx := newx - 1;
            newy := newy - 1;
         end;
   end;
end;
//根据当前位置和方向获得前进一步的坐标
procedure GetFrontPosition (sx, sy, dir: integer; var newx, newy: integer);
begin
   newx := sx;
   newy := sy;
   case dir of
      DR_UP:      newy := newy-1;
      DR_DOWN:    newy := newy+1;
      DR_LEFT:    newx := newx-1;
      DR_RIGHT:   newx := newx+1;
      DR_UPLEFT:
         begin
            newx := newx - 1;
            newy := newy - 1;
         end;
      DR_UPRIGHT:
         begin
            newx := newx + 1;
            newy := newy - 1;
         end;
      DR_DOWNLEFT:
         begin
            newx := newx - 1;
            newy := newy + 1;
         end;
      DR_DOWNRIGHT:
         begin
            newx := newx + 1;
            newy := newy + 1;
         end;
   end;
end;
//根据两点位置获得飞行方向（8个方向）
function  GetFlyDirection (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
   fx := ttx - sx;
   fy := tty - sy;
   {sx := 0;
   sy := 0;  }
   Result := DR_DOWN;
   if fx=0 then begin         //两点的X坐标相等
      if fy < 0 then Result := DR_UP
      else Result := DR_DOWN;
      exit;
   end;
   if fy=0 then begin         //两点的Y坐标相等
      if fx < 0 then Result := DR_LEFT
      else Result := DR_RIGHT;
      exit;
   end;
   if (fx > 0) and (fy < 0) then begin
      if -fy > fx*2.5 then Result := DR_UP
      else if -fy < fx/3 then Result := DR_RIGHT
      else Result := DR_UPRIGHT;
   end;
   if (fx > 0) and (fy > 0) then begin
      if fy < fx/3 then Result := DR_RIGHT
      else if fy > fx*2.5 then Result := DR_DOWN
      else Result := DR_DOWNRIGHT;
   end;
   if (fx < 0) and (fy > 0) then begin
      if fy  < -fx/3 then Result := DR_LEFT
      else if fy > -fx*2.5 then Result := DR_DOWN
      else Result := DR_DOWNLEFT;
   end;
   if (fx < 0) and (fy < 0) then begin
      if -fy > -fx*2.5 then Result := DR_UP
      else if -fy < -fx/3 then Result := DR_LEFT
      else Result := DR_UPLEFT;
   end;
end;
//根据两点位置获得飞行方向(16个方向)
function  GetFlyDirection16 (sx, sy, ttx, tty: integer): Integer;
var
   fx, fy: Real;
begin
   fx := ttx - sx;
   fy := tty - sy;
   {sx := 0;
   sy := 0; }
   Result := 0;
   if fx=0 then begin
      if fy < 0 then Result := 0
      else Result := 8;
      exit;
   end;
   if fy=0 then begin
      if fx < 0 then Result := 12
      else Result := 4;
      exit;
   end;
   if (fx > 0) and (fy < 0) then begin
      Result := 4;
      if -fy > fx/4 then Result := 3;
      if -fy > fx/1.9 then Result := 2;
      if -fy > fx*1.4 then Result := 1;
      if -fy > fx*4 then Result := 0;
   end;
   if (fx > 0) and (fy > 0) then begin
      Result := 4;
      if fy > fx/4 then Result := 5;
      if fy > fx/1.9 then Result := 6;
      if fy > fx*1.4 then Result := 7;
      if fy > fx*4 then Result := 8;
   end;
   if (fx < 0) and (fy > 0) then begin
      Result := 12;
      if fy > -fx/4 then Result := 11;
      if fy > -fx/1.9 then Result := 10;
      if fy > -fx*1.4 then Result := 9;
      if fy > -fx*4 then Result := 8;
   end;
   if (fx < 0) and (fy < 0) then begin
      Result := 12;
      if -fy > -fx/4 then Result := 13;
      if -fy > -fx/1.9 then Result := 14;
      if -fy > -fx*1.4 then Result := 15;
      if -fy > -fx*4 then Result := 0;
   end;
end;
//按逆时针转动一个方向后的方向
function  PrivDir (ndir: integer): integer;
begin
   if ndir - 1 < 0 then Result := 7
   else Result := ndir-1;
end;
//按顺时针转动一个方向后的方向
function  NextDir (ndir: integer): integer;
begin
   if ndir + 1 > 7 then Result := 0
   else Result := ndir+1;
end;

function  GetTakeOnPosition (smode: integer): integer;
begin
   //4,47,15,20,22,26
   Result := -1;
   case smode of //StdMode
      5, 6     :Result := U_WEAPON;//武器
      10, 11   :Result := U_DRESS;
      15    :Result := U_HELMET;
      16    :Result := U_ZHULI;  //斗笠
      19,20,21,28,29 :Result := U_NECKLACE;//20100628 增加29分类
      22,23,27 :Result := U_RINGR;
      24,26    :Result := U_ARMRINGR;
      30{,29} :Result := U_RIGHTHAND;//20100628 注释29
      {$IF M2Version <> 2}
      25,2{祝福罐,魔令包}    :Result := U_BUJUK; //符
      {$ELSE}
      25: Result := U_ARMRINGL;
      {$IFEND}
      52,62    :Result := U_BOOTS; //鞋
      55{,62}  :Result := U_DRUM; //  remark军鼓问题
      53,63,7{气血石}    :Result := U_CHARM; //宝石
      54,64    :Result := U_BELT;  //腰带
      4, 47, 42,3{祝福油},41{魔族指令书}:Result := X_RepairFir; //修补火龙之心
   end;
end;

//判断某个键是否按下
function  IsKeyPressed (key: byte): Boolean;
var
   keyvalue: TKeyBoardState;
begin
   Result := FALSE;
   FillChar(keyvalue, sizeof(TKeyboardState), #0);
   if GetKeyboardState (keyvalue) then
      if (keyvalue[key] and $80) <> 0 then
         Result := TRUE;
end;

procedure AddChangeFace (recogid: integer);
begin
   g_ChangeFaceReadyList.Add (pointer(recogid));
end;

procedure DelChangeFace (recogid: integer);
var
   i: integer;
begin
   if g_ChangeFaceReadyList.Count > 0 then //20080629
   for i:=0 to g_ChangeFaceReadyList.Count-1 do begin
      if integer(g_ChangeFaceReadyList[i]) = recogid then begin
         g_ChangeFaceReadyList.Delete (i);
         break;
      end;
   end;
end;

function  IsChangingFace (recogid: integer): Boolean;
var
   i: integer;
begin
   Result := FALSE;
   if g_ChangeFaceReadyList.Count > 0 then //20080629 
   for i:=0 to g_ChangeFaceReadyList.Count-1 do begin
      if integer(g_ChangeFaceReadyList[i]) = recogid then begin
         Result := TRUE;
         break;
      end;
   end;
end;

function GetTipsStr():string;
begin
  Result := '';
  if (g_TipsList <> nil) and //修正不能退出游戏的BUG
  (g_TipsList.Count > 0) then begin
    Randomize(); //随机种子
    Result := g_TipsList.Strings[Random(g_TipsList.Count)];
  end;
end;

function GetHeroJobStr(btJob: Byte): string;
begin
  case btJob of
    0: Result := '战';
    1: Result := '法';
    2: Result := '道';
  end;
end;

Initialization
  DropItems := TList.Create;
Finalization
  DropItems.Free;
end.
