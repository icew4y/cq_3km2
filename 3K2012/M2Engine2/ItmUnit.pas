unit ItmUnit;

interface
uses
  Windows, Classes, SysUtils, SDK, Grobal2;
type
  TItemUnit = class
  private
    function GetRandomRange(nCount, nRate: Integer): Integer;
  public
    m_ItemNameList: TGList;
    constructor Create();
    destructor Destroy; override;
    procedure GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem);
    procedure RandomUpgradeWeapon(UserItem: pTUserItem);
    procedure RandomUpgradeDress(UserItem: pTUserItem);
    procedure RandomUpgrade19(UserItem: pTUserItem);
    procedure RandomUpgrade202124(UserItem: pTUserItem);
    procedure RandomUpgrade26(UserItem: pTUserItem);
    procedure RandomUpgrade22(UserItem: pTUserItem);
    procedure RandomUpgrade23(UserItem: pTUserItem);
    procedure RandomUpgradeHelMet(UserItem: pTUserItem);
    procedure RandomUpgradeBoots(UserItem: pTUserItem);
    procedure UnknowHelmet(UserItem: pTUserItem);
    procedure UnknowRing(UserItem: pTUserItem);
    procedure UnknowNecklace(UserItem: pTUserItem);
    function LoadCustomItemName(): Boolean;
    function SaveCustomItemName(): Boolean;
    function AddCustomItemName(nMakeIndex, nItemIndex: Integer; sItemName: string): Boolean;
    function DelCustomItemName(nMakeIndex, nItemIndex: Integer): Boolean;
    function GetCustomItemName(nMakeIndex, nItemIndex: Integer): string;
    procedure Lock();
    procedure UnLock();
    {$IF M2Version <> 2}
    function RandomSpiritMediaCount(UserItem: pTUserItem): Boolean;//附加宝物灵媒属性
    function RandomKamPoMysteryCount(UserItem: pTUserItem; nType: Byte): Boolean;//附加神秘属性

    function TraineeItemKamPoWeapon(UserItem: pTUserItem; nCount: Byte): Boolean;//鉴定见习物品

    function RandomKamPoWeapon(UserItem: pTUserItem; nCount: Byte; boUnValue : Boolean = True; boClear : Boolean = True; boSpiritMedia : Boolean = True): Boolean;//鉴定武器 20100823
    function RandomKamPoDre(UserItem: pTUserItem; nCount: Byte; boUnValue : Boolean = True; boClear : Boolean = True; boSpiritMedia : Boolean = True): Boolean;//鉴定衣服 20100824
    function RandomKamPoNecklace(UserItem: pTUserItem; nCount: Byte; boUnValue : Boolean = True; boClear : Boolean = True; boSpiritMedia : Boolean = True): Boolean;//鉴定项链 20100824
    function RandomKamPoBracelet(UserItem: pTUserItem; nCount: Byte; boUnValue : Boolean = True; boClear : Boolean = True; boSpiritMedia : Boolean = True): Boolean;//鉴定手镯 20100824
    function RandomKamPoRing(UserItem: pTUserItem; nCount: Byte; boUnValue : Boolean = True; boClear : Boolean = True; boSpiritMedia : Boolean = True): Boolean;//鉴定戒指 20100824
    function RandomKamPoHelme(UserItem: pTUserItem; nCount: Byte; boUnValue : Boolean = True; boClear : Boolean = True; boSpiritMedia : Boolean = True): Boolean;//鉴定头盔、斗笠 20100824
    function RandomKamPoShoes(UserItem: pTUserItem; nCount: Byte; boUnValue : Boolean = True; boClear : Boolean = True; boSpiritMedia : Boolean = True): Boolean;//鉴定鞋子、腰带 20100824
    function RandomKamPoMedal(UserItem: pTUserItem; nCount: Byte; boUnValue : Boolean = True; boClear : Boolean = True; boSpiritMedia : Boolean = True): Boolean;//鉴定勋章 20100824

    function TraineeItemScrollChangeWeapon(UserItem: pTUserItem; nCount: Byte): Boolean;//鉴定见习物品神秘属性
    function RandomScrollChangeWeapon(UserItem: pTUserItem; nCount: Byte): Boolean;//解读武器神秘属性 20100826
    function RandomScrollChangeDre(UserItem: pTUserItem; nCount: Byte): Boolean;//解读衣服神秘属性 20100827
    function RandomScrollChangeNecklace(UserItem: pTUserItem; nCount: Byte): Boolean;//解读项链神秘属性 20100827
    function RandomScrollChangeBracelet(UserItem: pTUserItem; nCount: Byte): Boolean;//解读手镯神秘属性 20100827
    function RandomScrollChangeRing(UserItem: pTUserItem; nCount: Byte): Boolean;//解读戒指神秘属性 20100827
    function RandomScrollChangeHelme(UserItem: pTUserItem; nCount: Byte): Boolean;//解读头盔、斗笠神秘属性 20100827
    function RandomScrollChangeShoes(UserItem: pTUserItem; nCount: Byte): Boolean;//解读鞋子、腰带神秘属性 20100827
    function RandomScrollChangeMedal(UserItem: pTUserItem; nCount: Byte): Boolean;//解读勋章神秘属性 20100827
    {$IFEND}
  end;
implementation

uses HUtil32, M2Share;


{ TItemUnit }


constructor TItemUnit.Create;
begin
  m_ItemNameList := TGList.Create;
end;

destructor TItemUnit.Destroy;
var
  I: Integer;
begin
  if m_ItemNameList.Count > 0 then begin//20080630
    for I := 0 to m_ItemNameList.Count - 1 do begin
      if pTItemName(m_ItemNameList.Items[I]) <> nil then
         Dispose(pTItemName(m_ItemNameList.Items[I]));
    end;
  end;
  m_ItemNameList.Free;
  inherited;
end;

function TItemUnit.GetRandomRange(nCount, nRate: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  if nCount <= 0 then nCount:= 1;
  for I := 0 to nCount - 1 do
    if Random(nRate) = 0 then Inc(Result);
end;

procedure TItemUnit.RandomUpgradeWeapon(UserItem: pTUserItem); //随机升级武器
var
  nC, n10, n14: Integer;
begin
  nC := GetRandomRange(g_Config.nWeaponDCAddValueMaxLimit, g_Config.nWeaponDCAddValueRate);
  if Random(g_Config.nWeaponDCAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nWeaponDCAddValueMaxLimit then UserItem.btValue[0]:= g_Config.nWeaponDCAddValueMaxLimit;//20080724 限制上限
  end;

  nC := GetRandomRange(12, 15);
  if Random(15) = 0 then begin
    n14 := (nC + 1) div 3;
    if n14 > 0 then begin
      if Random(3) <> 0 then begin
        UserItem.btValue[6] := n14;
      end else begin
        UserItem.btValue[6] := n14 + 10;
      end;
    end;
  end;

  nC := GetRandomRange(g_Config.nWeaponMCAddValueMaxLimit, g_Config.nWeaponMCAddValueRate);
  if Random(g_Config.nWeaponMCAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nWeaponMCAddValueMaxLimit then UserItem.btValue[1]:= g_Config.nWeaponMCAddValueMaxLimit;//20080724 限制上限
  end;
  nC := GetRandomRange(g_Config.nWeaponSCAddValueMaxLimit, g_Config.nWeaponSCAddValueRate);
  if Random(g_Config.nWeaponSCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nWeaponSCAddValueMaxLimit then UserItem.btValue[2]:= g_Config.nWeaponSCAddValueMaxLimit;//20080724 限制上限
  end;

  nC := GetRandomRange(12, 15);
  if Random(15) = 0 then begin
    UserItem.btValue[5] := nC div 2 + 1;
  end;
  nC := GetRandomRange(12, 12);
  if Random(3) < 2 then begin
    n10 := (nC + 1) * 2000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
  nC := GetRandomRange(12, 15);
  if Random(10) = 0 then begin
    UserItem.btValue[7] := nC div 2 + 1;
  end;
end;

procedure TItemUnit.RandomUpgradeDress(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nDressACAddValueMaxLimit, g_Config.nDressACAddValueRate);
  if Random(g_Config.nDressACAddRate) = 0 then begin
     UserItem.btValue[0] := nC + 1;
     if UserItem.btValue[0] > g_Config.nDressACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nDressACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nDressMACAddValueMaxLimit, g_Config.nDressMACAddValueRate);
  if Random(g_Config.nDressMACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nDressMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nDressMACAddValueMaxLimit;//20080724 限制上线
  end;

  nC := GetRandomRange(g_Config.nDressDCAddValueMaxLimit, g_Config.nDressDCAddValueRate);
  if Random(g_Config.nDressDCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nDressDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nDressDCAddValueMaxLimit;//20080724 限制上线
  end;

  nC := GetRandomRange(g_Config.nDressMCAddValueMaxLimit, g_Config.nDressMCAddValueRate);
  if Random(g_Config.nDressMCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nDressMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nDressMCAddValueMaxLimit;//20080724 限制上线
  end;

  nC := GetRandomRange(g_Config.nDressSCAddValueMaxLimit, g_Config.nDressSCAddValueRate);
  if Random(g_Config.nDressSCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nDressSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nDressSCAddValueMaxLimit;//20080724 限制上线
  end;

  nC := GetRandomRange(6, 10);
  if Random(8) < 6 then begin
    n10 := (nC + 1) * 2000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade202124(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nNeckLace202124ACAddValueMaxLimit, g_Config.nNeckLace202124ACAddValueRate);
  if Random(g_Config.nNeckLace202124ACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nNeckLace202124ACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nNeckLace202124ACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace202124MACAddValueMaxLimit, g_Config.nNeckLace202124MACAddValueRate);
  if Random(g_Config.nNeckLace202124MACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nNeckLace202124MACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nNeckLace202124MACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace202124DCAddValueMaxLimit, g_Config.nNeckLace202124DCAddValueRate);
  if Random(g_Config.nNeckLace202124DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nNeckLace202124DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nNeckLace202124DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace202124MCAddValueMaxLimit, g_Config.nNeckLace202124MCAddValueRate);
  if Random(g_Config.nNeckLace202124MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nNeckLace202124MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nNeckLace202124MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace202124SCAddValueMaxLimit, g_Config.nNeckLace202124SCAddValueRate);
  if Random(g_Config.nNeckLace202124SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nNeckLace202124SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nNeckLace202124SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(20) < 15 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade26(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nArmRing26ACAddValueMaxLimit, g_Config.nArmRing26ACAddValueRate);
  if Random(g_Config.nArmRing26ACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nArmRing26ACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nArmRing26ACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nArmRing26MACAddValueMaxLimit, g_Config.nArmRing26MACAddValueRate);
  if Random(g_Config.nArmRing26MACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nArmRing26MACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nArmRing26MACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nArmRing26DCAddValueMaxLimit, g_Config.nArmRing26DCAddValueRate);
  if Random(g_Config.nArmRing26DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nArmRing26DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nArmRing26DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nArmRing26MCAddValueMaxLimit, g_Config.nArmRing26MCAddValueRate);
  if Random(g_Config.nArmRing26MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nArmRing26MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nArmRing26MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nArmRing26SCAddValueMaxLimit, g_Config.nArmRing26SCAddValueRate);
  if Random(g_Config.nArmRing26SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nArmRing26SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nArmRing26SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(20) < 15 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;
//随机升级-分类19物品(幸运类项链)
procedure TItemUnit.RandomUpgrade19(UserItem: pTUserItem); //00494D60
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nNeckLace19ACAddValueMaxLimit, g_Config.nNeckLace19ACAddValueRate);
  if Random(g_Config.nNeckLace19ACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nNeckLace19ACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nNeckLace19ACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace19MACAddValueMaxLimit, g_Config.nNeckLace19MACAddValueRate);
  if Random(g_Config.nNeckLace19MACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nNeckLace19MACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nNeckLace19MACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace19DCAddValueMaxLimit, g_Config.nNeckLace19DCAddValueRate);
  if Random(g_Config.nNeckLace19DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nNeckLace19DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nNeckLace19DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace19MCAddValueMaxLimit, g_Config.nNeckLace19MCAddValueRate);
  if Random(g_Config.nNeckLace19MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nNeckLace19MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nNeckLace19MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nNeckLace19SCAddValueMaxLimit, g_Config.nNeckLace19SCAddValueRate);
  if Random(g_Config.nNeckLace19SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nNeckLace19SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nNeckLace19SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 10);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade22(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nRing22DCAddValueMaxLimit, g_Config.nRing22DCAddValueRate);
  if Random(g_Config.nRing22DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nRing22DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nRing22DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing22MCAddValueMaxLimit, g_Config.nRing22MCAddValueRate);
  if Random(g_Config.nRing22MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nRing22MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nRing22MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing22SCAddValueMaxLimit, g_Config.nRing22SCAddValueRate);
  if Random(g_Config.nRing22SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nRing22SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nRing22SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.RandomUpgrade23(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nRing23ACAddValueMaxLimit, g_Config.nRing23ACAddValueRate);
  if Random(g_Config.nRing23ACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nRing23ACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nRing23ACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing23MACAddValueMaxLimit, g_Config.nRing23MACAddValueRate);
  if Random(g_Config.nRing23MACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nRing23MACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nRing23MACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing23DCAddValueMaxLimit, g_Config.nRing23DCAddValueRate);
  if Random(g_Config.nRing23DCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nRing23DCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nRing23DCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing23MCAddValueMaxLimit, g_Config.nRing23MCAddValueRate);
  if Random(g_Config.nRing23MCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nRing23MCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nRing23MCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nRing23SCAddValueMaxLimit, g_Config.nRing23SCAddValueRate);
  if Random(g_Config.nRing23SCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nRing23SCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nRing23SCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

//头盔,斗笠 极品属性
procedure TItemUnit.RandomUpgradeHelMet(UserItem: pTUserItem); //00495110
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nHelMetACAddValueMaxLimit, g_Config.nHelMetACAddValueRate);
  if Random(g_Config.nHelMetACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;
    if UserItem.btValue[0] > g_Config.nHelMetACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nHelMetACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nHelMetMACAddValueMaxLimit, g_Config.nHelMetMACAddValueRate);
  if Random(g_Config.nHelMetMACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;
    if UserItem.btValue[1] > g_Config.nHelMetMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nHelMetMACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nHelMetDCAddValueMaxLimit, g_Config.nHelMetDCAddValueRate);
  if Random(g_Config.nHelMetDCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;
    if UserItem.btValue[2] > g_Config.nHelMetDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nHelMetDCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nHelMetMCAddValueMaxLimit, g_Config.nHelMetMCAddValueRate);
  if Random(g_Config.nHelMetMCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;
    if UserItem.btValue[3] > g_Config.nHelMetMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nHelMetMCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nHelMetSCAddValueMaxLimit, g_Config.nHelMetSCAddValueRate);
  if Random(g_Config.nHelMetSCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;
    if UserItem.btValue[4] > g_Config.nHelMetSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nHelMetSCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;
//20080503  鞋子腰带极品
procedure TItemUnit.RandomUpgradeBoots(UserItem: pTUserItem);
var
  nC, n10: Integer;
begin
  nC := GetRandomRange(g_Config.nBootsACAddValueMaxLimit, g_Config.nBootsACAddValueRate);
  if Random(g_Config.nBootsACAddRate) = 0 then begin
    UserItem.btValue[0] := nC + 1;//防御
    if UserItem.btValue[0] > g_Config.nBootsACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nBootsACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nBootsMACAddValueMaxLimit, g_Config.nBootsMACAddValueRate);
  if Random(g_Config.nBootsMACAddRate) = 0 then begin
    UserItem.btValue[1] := nC + 1;//魔御
    if UserItem.btValue[1] > g_Config.nBootsMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nBootsMACAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nBootsDCAddValueMaxLimit , g_Config.nBootsDCAddValueRate );
  if Random(g_Config.nBootsDCAddRate) = 0 then begin
    UserItem.btValue[2] := nC + 1;//攻击力
    if UserItem.btValue[2] > g_Config.nBootsDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nBootsDCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nBootsMCAddValueMaxLimit, g_Config.nBootsMCAddValueRate);
  if Random(g_Config.nBootsMCAddRate) = 0 then begin
    UserItem.btValue[3] := nC + 1;//魔法
    if UserItem.btValue[3] > g_Config.nBootsMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nBootsMCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(g_Config.nBootsSCAddValueMaxLimit, g_Config.nBootsSCAddValueRate);
  if Random(g_Config.nBootsSCAddRate) = 0 then begin
    UserItem.btValue[4] := nC + 1;//道术
    if UserItem.btValue[4] > g_Config.nBootsSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nBootsSCAddValueMaxLimit;//20080724 限制上线
  end;
  nC := GetRandomRange(6, 12);
  if Random(4) < 3 then begin
    n10 := (nC + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + n10);
    UserItem.Dura := _MIN(65000, UserItem.Dura + n10);
  end;
end;

procedure TItemUnit.UnknowHelmet(UserItem: pTUserItem); //神秘头盔
var
  nC, nRandPoint, n14: Integer;
begin
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetACAddValueMaxLimit, g_Config.nUnknowHelMetACAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[0] := nRandPoint;
    if UserItem.btValue[0] > g_Config.nUnknowHelMetACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nUnknowHelMetACAddValueMaxLimit;//20080724 限制上线
  end;
  n14 := nRandPoint;
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetMACAddValueMaxLimit, g_Config.nUnknowHelMetMACAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[1] := nRandPoint;
    if UserItem.btValue[1] > g_Config.nUnknowHelMetMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nUnknowHelMetMACAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetDCAddValueMaxLimit, g_Config.nUnknowHelMetDCAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[2] := nRandPoint;
    if UserItem.btValue[2] > g_Config.nUnknowHelMetDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nUnknowHelMetDCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetMCAddValueMaxLimit, g_Config.nUnknowHelMetMCAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[3] := nRandPoint;
    if UserItem.btValue[3] > g_Config.nUnknowHelMetMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nUnknowHelMetMCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(g_Config.nUnknowHelMetSCAddValueMaxLimit, g_Config.nUnknowHelMetSCAddRate);
  if nRandPoint > 0 then begin
    UserItem.btValue[4] := nRandPoint;
    if UserItem.btValue[4] > g_Config.nUnknowHelMetSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nUnknowHelMetSCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, nRandPoint);
  nRandPoint := GetRandomRange(6, 30);
  if nRandPoint > 0 then begin
    nC := (nRandPoint + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 3 then begin
    if UserItem.btValue[0] >= 5 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[0] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[2] >= 2 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 4 + 35;
      Exit;
    end;
    if UserItem.btValue[3] >= 2 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 18;
      Exit;
    end;
    if UserItem.btValue[4] >= 2 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 18;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;

procedure TItemUnit.UnknowRing(UserItem: pTUserItem); //神秘戒指
var
  nC, n10, n14: Integer;
begin
  n10 := GetRandomRange(g_Config.nUnknowRingACAddValueMaxLimit, g_Config.nUnknowRingACAddRate);
  if n10 > 0 then begin
    UserItem.btValue[0] := n10;
    if UserItem.btValue[0] > g_Config.nUnknowRingACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nUnknowRingACAddValueMaxLimit;//20080724 限制上线
  end;
  n14 := n10;
  n10 := GetRandomRange(g_Config.nUnknowRingMACAddValueMaxLimit, g_Config.nUnknowRingMACAddRate);
  if n10 > 0 then begin
    UserItem.btValue[1] := n10;
    if UserItem.btValue[1] > g_Config.nUnknowRingMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nUnknowRingMACAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);

  n10 := GetRandomRange(g_Config.nUnknowRingDCAddValueMaxLimit, g_Config.nUnknowRingDCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[2] := n10;
    if UserItem.btValue[2] > g_Config.nUnknowRingDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nUnknowRingDCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowRingMCAddValueMaxLimit, g_Config.nUnknowRingMCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[3] := n10;
    if UserItem.btValue[3] > g_Config.nUnknowRingMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nUnknowRingMCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowRingSCAddValueMaxLimit, g_Config.nUnknowRingSCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[4] := n10;
    if UserItem.btValue[4] > g_Config.nUnknowRingSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nUnknowRingSCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(6, 30);
  if n10 > 0 then begin
    nC := (n10 + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 3 then begin
    if UserItem.btValue[2] >= 3 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[3] >= 3 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 18;
      Exit;
    end;
    if UserItem.btValue[4] >= 3 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 18;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;

procedure TItemUnit.UnknowNecklace(UserItem: pTUserItem); //神秘腰带
var
  nC, n10, n14: Integer;
begin
  n10 := GetRandomRange(g_Config.nUnknowNecklaceACAddValueMaxLimit, g_Config.nUnknowNecklaceACAddRate);
  if n10 > 0 then begin
    UserItem.btValue[0] := n10;
    if UserItem.btValue[0] > g_Config.nUnknowNecklaceACAddValueMaxLimit then UserItem.btValue[0] := g_Config.nUnknowNecklaceACAddValueMaxLimit;//20080724 限制上线
  end;
  n14 := n10;
  n10 := GetRandomRange(g_Config.nUnknowNecklaceMACAddValueMaxLimit, g_Config.nUnknowNecklaceMACAddRate);
  if n10 > 0 then begin
    UserItem.btValue[1] := n10;
    if UserItem.btValue[1] > g_Config.nUnknowNecklaceMACAddValueMaxLimit then UserItem.btValue[1] := g_Config.nUnknowNecklaceMACAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowNecklaceDCAddValueMaxLimit, g_Config.nUnknowNecklaceDCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[2] := n10;
    if UserItem.btValue[2] > g_Config.nUnknowNecklaceDCAddValueMaxLimit then UserItem.btValue[2] := g_Config.nUnknowNecklaceDCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowNecklaceMCAddValueMaxLimit, g_Config.nUnknowNecklaceMCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[3] := n10;
    if UserItem.btValue[3] > g_Config.nUnknowNecklaceMCAddValueMaxLimit then UserItem.btValue[3] := g_Config.nUnknowNecklaceMCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(g_Config.nUnknowNecklaceSCAddValueMaxLimit, g_Config.nUnknowNecklaceSCAddRate);
  if n10 > 0 then begin
    UserItem.btValue[4] := n10;
    if UserItem.btValue[4] > g_Config.nUnknowNecklaceSCAddValueMaxLimit then UserItem.btValue[4] := g_Config.nUnknowNecklaceSCAddValueMaxLimit;//20080724 限制上线
  end;
  Inc(n14, n10);
  n10 := GetRandomRange(6, 30);
  if n10 > 0 then begin
    nC := (n10 + 1) * 1000;
    UserItem.DuraMax := _MIN(65000, UserItem.DuraMax + nC);
    UserItem.Dura := _MIN(65000, UserItem.Dura + nC);
  end;
  if Random(30) = 0 then UserItem.btValue[7] := 1;
  UserItem.btValue[8] := 1;
  if n14 >= 2 then begin
    if UserItem.btValue[0] >= 3 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[0] * 3 + 25;
      Exit;
    end;
    if UserItem.btValue[2] >= 2 then begin
      UserItem.btValue[5] := 1;
      UserItem.btValue[6] := UserItem.btValue[2] * 3 + 30;
      Exit;
    end;
    if UserItem.btValue[3] >= 2 then begin
      UserItem.btValue[5] := 2;
      UserItem.btValue[6] := UserItem.btValue[3] * 2 + 20;
      Exit;
    end;
    if UserItem.btValue[4] >= 2 then begin
      UserItem.btValue[5] := 3;
      UserItem.btValue[6] := UserItem.btValue[4] * 2 + 20;
      Exit;
    end;
    UserItem.btValue[6] := n14 * 2 + 18;
  end;
end;

//取物品的附属属性
procedure TItemUnit.GetItemAddValue(UserItem: pTUserItem; var StdItem: TStdItem); 
begin
  case StdItem.StdMode of
    5, 6: begin 
        StdItem.DC := MakeLong(LoWord(StdItem.DC), HiWord(StdItem.DC) + UserItem.btValue[0]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC), HiWord(StdItem.MC) + UserItem.btValue[1]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC), HiWord(StdItem.SC) + UserItem.btValue[2]);
        StdItem.AC := MakeLong(LoWord(StdItem.AC) + UserItem.btValue[3], HiWord(StdItem.AC) + UserItem.btValue[5]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC) + UserItem.btValue[4], HiWord(StdItem.MAC) + UserItem.btValue[6]);
        if Byte(UserItem.btValue[7] - 1) < 10 then begin //神圣
          StdItem.Source := UserItem.btValue[7];
        end;
        if UserItem.btValue[10] <> 0 then
          StdItem.Reserved := StdItem.Reserved or 1;
      end;
    10, 11: begin
        StdItem.AC := MakeLong(LoWord(StdItem.AC), HiWord(StdItem.AC) + UserItem.btValue[0]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC), HiWord(StdItem.MAC) + UserItem.btValue[1]);
        StdItem.DC := MakeLong(LoWord(StdItem.DC), HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC), HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC), HiWord(StdItem.SC) + UserItem.btValue[4]);
      end;
    55: begin
        //StdItem.AC := StdItem.Source; // 体力值
        //StdItem.MAC := StdItem.Reserved;   // 魔法值
        StdItem.DC := MakeLong(LoWord(StdItem.DC), HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC), HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC), HiWord(StdItem.SC) + UserItem.btValue[4]);
      end;
    15, 16, 19, 20, 21, 22, 23, 24, 26, 27, 28, 29, 51, 52, 53, 54, 62, 63, 64, 30: begin//加入勋章分类 20080616 20100513 20100628 增加29分类(敏捷幸运型项链)
        StdItem.AC := MakeLong(LoWord(StdItem.AC), HiWord(StdItem.AC) + UserItem.btValue[0]);
        StdItem.MAC := MakeLong(LoWord(StdItem.MAC), HiWord(StdItem.MAC) + UserItem.btValue[1]);
        StdItem.DC := MakeLong(LoWord(StdItem.DC), HiWord(StdItem.DC) + UserItem.btValue[2]);
        StdItem.MC := MakeLong(LoWord(StdItem.MC), HiWord(StdItem.MC) + UserItem.btValue[3]);
        StdItem.SC := MakeLong(LoWord(StdItem.SC), HiWord(StdItem.SC) + UserItem.btValue[4]);
        if UserItem.btValue[5] > 0 then begin
          StdItem.Need := UserItem.btValue[5];
        end;
        if UserItem.btValue[6] > 0 then begin
          StdItem.NeedLevel := UserItem.btValue[6];
        end;
      end;
  end;
  if (UserItem.btValue[20] > 0) or (StdItem.Source > 0) then begin //吸伤属性 20080324
    Case StdItem.StdMode of
      15,16,19..24,26,27,28,29,30,52,54,55,62,64:begin//头盔,项链,戒指,手镯,鞋子,腰带,勋章 20100513 20100628 增加29分类(敏捷幸运型项链)
         if (StdItem.Shape = 188) or (StdItem.Shape = 203) then begin
           StdItem.Source:= StdItem.Source + UserItem.btValue[20];
           if StdItem.Source > 100 then StdItem.Source:= 100;
           StdItem.Reserved:= _MIN(5, StdItem.Reserved + UserItem.btValue[9]);//吸伤装备等级
         end;
       end;
    end;
  end;
end;
//取自定义物品名称
function TItemUnit.GetCustomItemName(nMakeIndex, nItemIndex: Integer): string;
var
  I: Integer;
  ItemName: pTItemName;
begin
  Result := '';
  m_ItemNameList.Lock;
  try
    if m_ItemNameList.Count > 0 then begin//20091113 增加
      for I := 0 to m_ItemNameList.Count - 1 do begin
        ItemName := m_ItemNameList.Items[I];
        if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
          Result := ItemName.sItemName;
          Break;
        end;
      end;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
end;


function TItemUnit.AddCustomItemName(nMakeIndex, nItemIndex: Integer;
  sItemName: string): Boolean;
var
  I: Integer;
  ItemName: pTItemName;
begin
  Result := False;
  m_ItemNameList.Lock;
  try
    if m_ItemNameList.Count > 0 then begin//20091113 增加
      for I := 0 to m_ItemNameList.Count - 1 do begin
        ItemName := m_ItemNameList.Items[I];
        if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
          Exit;
        end;
      end;
    end;
    New(ItemName);
    ItemName.nMakeIndex := nMakeIndex;
    ItemName.nItemIndex := nItemIndex;
    ItemName.sItemName := sItemName;
    m_ItemNameList.Add(ItemName);
    Result := True;
  finally
    m_ItemNameList.UnLock;
  end;
end;

function TItemUnit.DelCustomItemName(nMakeIndex, nItemIndex: Integer): Boolean;
var
  I: Integer;
  ItemName: pTItemName;
begin
  Result := False;
  m_ItemNameList.Lock;
  try
    for I := m_ItemNameList.Count - 1 downto 0 do begin//20080917
      if m_ItemNameList.Count <= 0 then Break;//20080917
      ItemName := m_ItemNameList.Items[I];
      if (ItemName.nMakeIndex = nMakeIndex) and (ItemName.nItemIndex = nItemIndex) then begin
        Dispose(ItemName);
        m_ItemNameList.Delete(I);
        Result := True;
        Exit;
      end;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
end;

function TItemUnit.LoadCustomItemName: Boolean;
var
  I: Integer;
  LoadList: TStringList;
  sFileName: string;
  sLineText: string;
  sMakeIndex: string;
  sItemIndex: string;
  nMakeIndex: Integer;
  nItemIndex: Integer;
  sItemName: string;
  ItemName: pTItemName;
begin
  Result := False;
  sFileName := g_Config.sEnvirDir + 'ItemNameList.txt';
  LoadList := TStringList.Create;
  if FileExists(sFileName) then begin
    m_ItemNameList.Lock;
    try
      if m_ItemNameList.Count > 0 then m_ItemNameList.Clear;//20080831 修改
      LoadList.LoadFromFile(sFileName);
      if LoadList.Count > 0 then begin//20091113 增加
        for I := 0 to LoadList.Count - 1 do begin
          sLineText := Trim(LoadList.Strings[I]);
          sLineText := GetValidStr3(sLineText, sMakeIndex, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sItemIndex, [' ', #9]);
          sLineText := GetValidStr3(sLineText, sItemName, [' ', #9]);
          nMakeIndex := Str_ToInt(sMakeIndex, -1);
          nItemIndex := Str_ToInt(sItemIndex, -1);
          if (nMakeIndex >= 0) and (nItemIndex >= 0) then begin
            New(ItemName);
            ItemName.nMakeIndex := nMakeIndex;
            ItemName.nItemIndex := nItemIndex;
            ItemName.sItemName := sItemName;
            m_ItemNameList.Add(ItemName);
          end;
        end;//for
      end;
      Result := True;
    finally
      m_ItemNameList.UnLock;
    end;
  end else begin
    LoadList.SaveToFile(sFileName);
  end;
  LoadList.Free;
end;

function TItemUnit.SaveCustomItemName: Boolean;
var
  I: Integer;
  SaveList: TStringList;
  sFileName: string;
  ItemName: pTItemName;
begin
  sFileName := g_Config.sEnvirDir + 'ItemNameList.txt';
  SaveList := TStringList.Create;
  m_ItemNameList.Lock;
  try
    if m_ItemNameList.Count > 0 then begin//20080630
      for I := 0 to m_ItemNameList.Count - 1 do begin
        ItemName := m_ItemNameList.Items[I];
        SaveList.Add(IntToStr(ItemName.nMakeIndex) + #9 + IntToStr(ItemName.nItemIndex) + #9 + ItemName.sItemName);
      end;
    end;
  finally
    m_ItemNameList.UnLock;
  end;
  SaveList.SaveToFile(sFileName);
  SaveList.Free;
  Result := True;
end;

procedure TItemUnit.Lock;
begin
  m_ItemNameList.Lock;
end;

procedure TItemUnit.UnLock;
begin
  m_ItemNameList.UnLock;
end;
//------------------------------------------------------------------------------
{$IF M2Version <> 2}
//附加宝物灵媒属性
function TItemUnit.RandomSpiritMediaCount(UserItem: pTUserItem): Boolean;
begin
  Result := False;
  if (Random(g_Config.nSpiritMediaAddRate) = 0) and
     (not (UserItem.btAppraisalValue[2] in [231..250])) and
     (not (UserItem.btAppraisalValue[3] in [231..250])) and
     (not (UserItem.btAppraisalValue[4] in [231..250])) and
     (not (UserItem.btAppraisalValue[5] in [231..250])) and
     (not (UserItem.btUnKnowValue[6] in [231..250])) and
     (not (UserItem.btUnKnowValue[7] in [231..250])) and
     (not (UserItem.btUnKnowValue[8] in [231..250])) and
     (not (UserItem.btUnKnowValue[9] in [231..250])) then begin//所有属性不存在宝物灵媒
      Result := True;
  end;
end;
//附加神秘属性
function TItemUnit.RandomKamPoMysteryCount(UserItem: pTUserItem; nType: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if (UserItem.btUnKnowValueCount = 0) then begin
    nC := GetRandomRange(g_Config.nMysteryAddValueMaxLimit, g_Config.nMysteryAddValueRate);//点数
    if nType = 1 then begin//不判断机率
      if nC > 0 then begin
        if nC > 4 then nC:= 4;
        UserItem.btUnKnowValueCount := nC;
        case nC of
          1: UserItem.btUnKnowValue[6] := 255;
          2: begin
            UserItem.btUnKnowValue[6] := 255;
            UserItem.btUnKnowValue[7] := 255;
          end;
          3: begin
            UserItem.btUnKnowValue[6] := 255;
            UserItem.btUnKnowValue[7] := 255;
            UserItem.btUnKnowValue[8] := 255;
          end;
          4: begin
            UserItem.btUnKnowValue[6] := 255;
            UserItem.btUnKnowValue[7] := 255;
            UserItem.btUnKnowValue[8] := 255;
            UserItem.btUnKnowValue[9] := 255;
          end;
        end;
        Result := True;
      end;
    end else begin
      if (Random(g_Config.nMysteryAddRate) = 0) then begin//神秘属性
        if nC > 0 then begin
          if nC > 4 then nC:= 4;
          UserItem.btUnKnowValueCount := nC;
          case nC of
            1: UserItem.btUnKnowValue[6] := 255;
            2: begin
              UserItem.btUnKnowValue[6] := 255;
              UserItem.btUnKnowValue[7] := 255;
            end;
            3: begin
              UserItem.btUnKnowValue[6] := 255;
              UserItem.btUnKnowValue[7] := 255;
              UserItem.btUnKnowValue[8] := 255;
            end;
            4: begin
              UserItem.btUnKnowValue[6] := 255;
              UserItem.btUnKnowValue[7] := 255;
              UserItem.btUnKnowValue[8] := 255;
              UserItem.btUnKnowValue[9] := 255;
            end;
          end;
          Result := True;
        end;
      end;
    end;
  end;
end;
//鉴定见习物品
function TItemUnit.TraineeItemKamPoWeapon(UserItem: pTUserItem; nCount: Byte): Boolean;
begin
  Result := False;
  if nCount > 3 then Exit;
  case nCount of
    1: begin//一鉴增加攻属性
      UserItem.btAppraisalValue[2] := 11;
      Result := True;
    end;
    2: begin//二鉴增加合击威力
      UserItem.btAppraisalValue[3] := 200;
      Result := True;
    end;
    3: begin//三鉴定增加神秘属性
      UserItem.btUnKnowValueCount := 1;
      UserItem.btUnKnowValue[6] := 255;
      Result := True;
    end;
  end;
end;

//鉴定武器 20100823
function TItemUnit.RandomKamPoWeapon;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 3 then Exit;
  if (not boClear) and (UserItem.btAppraisalValue[nCount + 2] <> 0) then begin Result := True;Exit;end;//防止重复上属性
  if boUnValue and RandomKamPoMysteryCount(UserItem, 0) then begin//神秘属性
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nArmsDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nArmsDCAddValueMaxLimit, g_Config.nArmsDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nArmsFBAddValueMaxLimit, g_Config.nArmsFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsZQAddRate) = 0 then begin//准确 141..150
        nC := GetRandomRange(g_Config.nArmsZQAddValueMaxLimit, g_Config.nArmsZQAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 140;
          if UserItem.btAppraisalValue[nCount + 2] > 150 then UserItem.btAppraisalValue[nCount + 2] := 150;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[12]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nArmsJMAddValueMaxLimit, g_Config.nArmsJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nArmsMBAddValueMaxLimit, g_Config.nArmsMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nArmsNSAddValueMaxLimit, g_Config.nArmsNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 110;
          if UserItem.btAppraisalValue[nCount + 2] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nArmsBJAddValueMaxLimit, g_Config.nArmsBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nArmsHJAddValueMaxLimit, g_Config.nArmsHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nArmsQSAddValueMaxLimit, g_Config.nArmsQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nArmsMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nArmsMCAddValueMaxLimit, g_Config.nArmsMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nArmsSCAddValueMaxLimit, g_Config.nArmsSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nArmsMainAddValueMaxLimit, g_Config.nArmsMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nArmsMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nArmsMCAddValueMaxLimit, g_Config.nArmsMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nArmsFBAddValueMaxLimit, g_Config.nArmsFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsZQAddRate) = 0 then begin//准确 141..150
        nC := GetRandomRange(g_Config.nArmsZQAddValueMaxLimit, g_Config.nArmsZQAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 140;
          if UserItem.btAppraisalValue[nCount + 2] > 150 then UserItem.btAppraisalValue[nCount + 2] := 150;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nArmsJMAddValueMaxLimit, g_Config.nArmsJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[12]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nArmsMBAddValueMaxLimit, g_Config.nArmsMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nArmsNSAddValueMaxLimit, g_Config.nArmsNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 110;
          if UserItem.btAppraisalValue[nCount + 2] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nArmsBJAddValueMaxLimit, g_Config.nArmsBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nArmsHJAddValueMaxLimit, g_Config.nArmsHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nArmsQSAddValueMaxLimit, g_Config.nArmsQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nArmsDCAddValueMaxLimit, g_Config.nArmsDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nArmsSCAddValueMaxLimit, g_Config.nArmsSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nArmsMainAddValueMaxLimit, g_Config.nArmsMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nArmsSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nArmsSCAddValueMaxLimit, g_Config.nArmsSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nArmsFBAddValueMaxLimit, g_Config.nArmsFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsZQAddRate) = 0 then begin//准确 141..150
        nC := GetRandomRange(g_Config.nArmsZQAddValueMaxLimit, g_Config.nArmsZQAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 140;
          if UserItem.btAppraisalValue[nCount + 2] > 150 then UserItem.btAppraisalValue[nCount + 2] := 150;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nArmsJMAddValueMaxLimit, g_Config.nArmsJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nArmsMBAddValueMaxLimit, g_Config.nArmsMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nArmsNSAddValueMaxLimit, g_Config.nArmsNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 110;
          if UserItem.btAppraisalValue[nCount + 2] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[12]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nArmsBJAddValueMaxLimit, g_Config.nArmsBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nArmsHJAddValueMaxLimit, g_Config.nArmsHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nArmsQSAddValueMaxLimit, g_Config.nArmsQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nArmsDCAddValueMaxLimit, g_Config.nArmsDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nArmsMCAddValueMaxLimit, g_Config.nArmsMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nArmsMainAddValueMaxLimit, g_Config.nArmsMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nArmsMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nArmsMainAddValueMaxLimit, g_Config.nArmsMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nArmsFBAddValueMaxLimit, g_Config.nArmsFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsZQAddRate) = 0 then begin//准确 141..150
        nC := GetRandomRange(g_Config.nArmsZQAddValueMaxLimit, g_Config.nArmsZQAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 140;
          if UserItem.btAppraisalValue[nCount + 2] > 150 then UserItem.btAppraisalValue[nCount + 2] := 150;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nArmsJMAddValueMaxLimit, g_Config.nArmsJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nArmsMBAddValueMaxLimit, g_Config.nArmsMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nArmsNSAddValueMaxLimit, g_Config.nArmsNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 110;
          if UserItem.btAppraisalValue[nCount + 2] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nArmsBJAddValueMaxLimit, g_Config.nArmsBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒  231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[12]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nArmsHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nArmsHJAddValueMaxLimit, g_Config.nArmsHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nArmsQSAddValueMaxLimit, g_Config.nArmsQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nArmsDCAddValueMaxLimit, g_Config.nArmsDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nArmsMCAddValueMaxLimit, g_Config.nArmsMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nArmsSCAddValueMaxLimit, g_Config.nArmsSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//鉴定衣服 20100824
function TItemUnit.RandomKamPoDre;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 3 then Exit;
  if (not boClear) and (UserItem.btAppraisalValue[nCount + 2] <> 0) then begin Result := True;Exit;end;//防止重复上属性
  if boUnValue and RandomKamPoMysteryCount(UserItem, 0) then begin//神秘属性
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nDreDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nDreDCAddValueMaxLimit, g_Config.nDreDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nDreNLAddValueMaxLimit, g_Config.nDreNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nDreWFAddValueMaxLimit, g_Config.nDreWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 50;
          if UserItem.btAppraisalValue[nCount + 2] > 60 then UserItem.btAppraisalValue[nCount + 2] := 60;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nDreJMAddValueMaxLimit, g_Config.nDreJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nDreMBAddValueMaxLimit, g_Config.nDreMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nDreXXAddValueMaxLimit, g_Config.nDreXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nDreBJAddValueMaxLimit, g_Config.nDreBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nDreHJAddValueMaxLimit, g_Config.nDreHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nDreQSAddValueMaxLimit, g_Config.nDreQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nDreMCAddValueMaxLimit, g_Config.nDreMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nDreSCAddValueMaxLimit, g_Config.nDreSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nDreMainAddValueMaxLimit, g_Config.nDreMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nDreMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nDreMCAddValueMaxLimit, g_Config.nDreMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nDreNLAddValueMaxLimit, g_Config.nDreNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nDreWFAddValueMaxLimit, g_Config.nDreWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 50;
          if UserItem.btAppraisalValue[nCount + 2] > 60 then UserItem.btAppraisalValue[nCount + 2] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nDreJMAddValueMaxLimit, g_Config.nDreJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nDreMBAddValueMaxLimit, g_Config.nDreMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒  231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nDreXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nDreXXAddValueMaxLimit, g_Config.nDreXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nDreBJAddValueMaxLimit, g_Config.nDreBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nDreHJAddValueMaxLimit, g_Config.nDreHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nDreQSAddValueMaxLimit, g_Config.nDreQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nDreDCAddValueMaxLimit, g_Config.nDreDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nDreSCAddValueMaxLimit, g_Config.nDreSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nDreMainAddValueMaxLimit, g_Config.nDreMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nDreSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nDreSCAddValueMaxLimit, g_Config.nDreSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nDreNLAddValueMaxLimit, g_Config.nDreNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nDreWFAddValueMaxLimit, g_Config.nDreWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 50;
          if UserItem.btAppraisalValue[nCount + 2] > 60 then UserItem.btAppraisalValue[nCount + 2] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nDreJMAddValueMaxLimit, g_Config.nDreJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nDreMBAddValueMaxLimit, g_Config.nDreMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nDreXXAddValueMaxLimit, g_Config.nDreXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒  231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nDreBJAddValueMaxLimit, g_Config.nDreBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nDreHJAddValueMaxLimit, g_Config.nDreHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nDreQSAddValueMaxLimit, g_Config.nDreQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nDreDCAddValueMaxLimit, g_Config.nDreDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nDreMCAddValueMaxLimit, g_Config.nDreMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nDreMainAddValueMaxLimit, g_Config.nDreMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nDreMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nDreMainAddValueMaxLimit, g_Config.nDreMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nDreNLAddValueMaxLimit, g_Config.nDreNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nDreWFAddValueMaxLimit, g_Config.nDreWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 50;
          if UserItem.btAppraisalValue[nCount + 2] > 60 then UserItem.btAppraisalValue[nCount + 2] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nDreJMAddValueMaxLimit, g_Config.nDreJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nDreMBAddValueMaxLimit, g_Config.nDreMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nDreXXAddValueMaxLimit, g_Config.nDreXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nDreBJAddValueMaxLimit, g_Config.nDreBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nDreHJAddValueMaxLimit, g_Config.nDreHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒  231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nDreQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nDreQSAddValueMaxLimit, g_Config.nDreQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nDreDCAddValueMaxLimit, g_Config.nDreDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nDreMCAddValueMaxLimit, g_Config.nDreMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nDreSCAddValueMaxLimit, g_Config.nDreSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//鉴定项链 20100824
function TItemUnit.RandomKamPoNecklace;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 3 then Exit;
  if (not boClear) and (UserItem.btAppraisalValue[nCount + 2] <> 0) then begin Result := True;Exit;end;//防止重复上属性
  if boUnValue and RandomKamPoMysteryCount(UserItem, 0) then begin//神秘属性
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nNecklaceDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nNecklaceDCAddValueMaxLimit, g_Config.nNecklaceDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nNecklaceNLAddValueMaxLimit, g_Config.nNecklaceNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nNecklaceMFAddValueMaxLimit, g_Config.nNecklaceMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 40;
          if UserItem.btAppraisalValue[nCount + 2] > 50 then UserItem.btAppraisalValue[nCount + 2] := 50;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nNecklaceXXAddValueMaxLimit, g_Config.nNecklaceXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nNecklaceHJAddValueMaxLimit, g_Config.nNecklaceHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nNecklaceQSAddValueMaxLimit, g_Config.nNecklaceQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nNecklaceSCAddValueMaxLimit, g_Config.nNecklaceSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nNecklaceMainAddValueMaxLimit, g_Config.nNecklaceMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nNecklaceNLAddValueMaxLimit, g_Config.nNecklaceNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nNecklaceMFAddValueMaxLimit, g_Config.nNecklaceMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 40;
          if UserItem.btAppraisalValue[nCount + 2] > 50 then UserItem.btAppraisalValue[nCount + 2] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nNecklaceXXAddValueMaxLimit, g_Config.nNecklaceXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒  231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nNecklaceHJAddValueMaxLimit, g_Config.nNecklaceHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nNecklaceDCAddValueMaxLimit, g_Config.nNecklaceDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nNecklaceSCAddValueMaxLimit, g_Config.nNecklaceSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nNecklaceMainAddValueMaxLimit, g_Config.nNecklaceMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nNecklaceSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nNecklaceSCAddValueMaxLimit, g_Config.nNecklaceSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nNecklaceNLAddValueMaxLimit, g_Config.nNecklaceNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nNecklaceMFAddValueMaxLimit, g_Config.nNecklaceMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 40;
          if UserItem.btAppraisalValue[nCount + 2] > 50 then UserItem.btAppraisalValue[nCount + 2] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nNecklaceXXAddValueMaxLimit, g_Config.nNecklaceXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nNecklaceHJAddValueMaxLimit, g_Config.nNecklaceHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nNecklaceDCAddValueMaxLimit, g_Config.nNecklaceDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nNecklaceMainAddValueMaxLimit, g_Config.nNecklaceMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nNecklaceMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nNecklaceMainAddValueMaxLimit, g_Config.nNecklaceMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nNecklaceNLAddValueMaxLimit, g_Config.nNecklaceNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nNecklaceMFAddValueMaxLimit, g_Config.nNecklaceMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 40;
          if UserItem.btAppraisalValue[nCount + 2] > 50 then UserItem.btAppraisalValue[nCount + 2] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nNecklaceXXAddValueMaxLimit, g_Config.nNecklaceXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nNecklaceHJAddValueMaxLimit, g_Config.nNecklaceHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nNecklaceQSAddValueMaxLimit, g_Config.nNecklaceQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nNecklaceDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nNecklaceDCAddValueMaxLimit, g_Config.nNecklaceDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nNecklaceSCAddValueMaxLimit, g_Config.nNecklaceSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//鉴定手镯 20100824
function TItemUnit.RandomKamPoBracelet;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 3 then Exit;
  if (not boClear) and (UserItem.btAppraisalValue[nCount + 2] <> 0) then begin Result := True;Exit;end;//防止重复上属性
  if boUnValue and RandomKamPoMysteryCount(UserItem, 0) then begin//神秘属性
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nBraceletDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nBraceletDCAddValueMaxLimit, g_Config.nBraceletDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nBraceletNLAddValueMaxLimit, g_Config.nBraceletNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nBraceletMFAddValueMaxLimit, g_Config.nBraceletMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 40;
          if UserItem.btAppraisalValue[nCount + 2] > 50 then UserItem.btAppraisalValue[nCount + 2] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nBraceletXXAddValueMaxLimit, g_Config.nBraceletXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nBraceletHJAddValueMaxLimit, g_Config.nBraceletHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nBraceletQSAddValueMaxLimit, g_Config.nBraceletQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nBraceletSCAddValueMaxLimit, g_Config.nBraceletSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nBraceletMainAddValueMaxLimit, g_Config.nBraceletMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nBraceletNLAddValueMaxLimit, g_Config.nBraceletNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nBraceletMFAddValueMaxLimit, g_Config.nBraceletMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 40;
          if UserItem.btAppraisalValue[nCount + 2] > 50 then UserItem.btAppraisalValue[nCount + 2] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nBraceletXXAddValueMaxLimit, g_Config.nBraceletXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nBraceletHJAddValueMaxLimit, g_Config.nBraceletHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nBraceletDCAddValueMaxLimit, g_Config.nBraceletDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nBraceletSCAddValueMaxLimit, g_Config.nBraceletSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nBraceletMainAddValueMaxLimit, g_Config.nBraceletMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nBraceletSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nBraceletSCAddValueMaxLimit, g_Config.nBraceletSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nBraceletNLAddValueMaxLimit, g_Config.nBraceletNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nBraceletMFAddValueMaxLimit, g_Config.nBraceletMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 40;
          if UserItem.btAppraisalValue[nCount + 2] > 50 then UserItem.btAppraisalValue[nCount + 2] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nBraceletXXAddValueMaxLimit, g_Config.nBraceletXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nBraceletHJAddValueMaxLimit, g_Config.nBraceletHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nBraceletDCAddValueMaxLimit, g_Config.nBraceletDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nBraceletMainAddValueMaxLimit, g_Config.nBraceletMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nBraceletMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nBraceletMainAddValueMaxLimit, g_Config.nBraceletMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nBraceletNLAddValueMaxLimit, g_Config.nBraceletNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nBraceletMFAddValueMaxLimit, g_Config.nBraceletMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 40;
          if UserItem.btAppraisalValue[nCount + 2] > 50 then UserItem.btAppraisalValue[nCount + 2] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nBraceletXXAddValueMaxLimit, g_Config.nBraceletXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nBraceletHJAddValueMaxLimit, g_Config.nBraceletHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nBraceletQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nBraceletQSAddValueMaxLimit, g_Config.nBraceletQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nBraceletDCAddValueMaxLimit, g_Config.nBraceletDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nBraceletSCAddValueMaxLimit, g_Config.nBraceletSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//鉴定戒指 20100824
function TItemUnit.RandomKamPoRing;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 3 then Exit;
  if (not boClear) and (UserItem.btAppraisalValue[nCount + 2] <> 0) then begin Result := True;Exit;end;//防止重复上属性
  if boUnValue and RandomKamPoMysteryCount(UserItem, 0) then begin//神秘属性
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 50;
          if UserItem.btAppraisalValue[nCount + 2] > 60 then UserItem.btAppraisalValue[nCount + 2] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 50;
          if UserItem.btAppraisalValue[nCount + 2] > 60 then UserItem.btAppraisalValue[nCount + 2] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 50;
          if UserItem.btAppraisalValue[nCount + 2] > 60 then UserItem.btAppraisalValue[nCount + 2] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 50;
          if UserItem.btAppraisalValue[nCount + 2] > 60 then UserItem.btAppraisalValue[nCount + 2] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//鉴定头盔、斗笠 20100824
function TItemUnit.RandomKamPoHelme;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 3 then Exit;
  if (not boClear) and (UserItem.btAppraisalValue[nCount + 2] <> 0) then begin Result := True;Exit;end;//防止重复上属性
  if boUnValue and RandomKamPoMysteryCount(UserItem, 0) then begin//神秘属性
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nHelmeDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nHelmeDCAddValueMaxLimit, g_Config.nHelmeDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nHelmeXXAddValueMaxLimit, g_Config.nHelmeXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nHelmeHJAddValueMaxLimit, g_Config.nHelmeHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nHelmeQSAddValueMaxLimit, g_Config.nHelmeQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nHelmeMCAddValueMaxLimit, g_Config.nHelmeMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nHelmeSCAddValueMaxLimit, g_Config.nHelmeSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nHelmeMainAddValueMaxLimit, g_Config.nHelmeMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nHelmeMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nHelmeMCAddValueMaxLimit, g_Config.nHelmeMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nHelmeXXAddValueMaxLimit, g_Config.nHelmeXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nHelmeHJAddValueMaxLimit, g_Config.nHelmeHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nHelmeQSAddValueMaxLimit, g_Config.nHelmeQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nHelmeDCAddValueMaxLimit, g_Config.nHelmeDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nHelmeSCAddValueMaxLimit, g_Config.nHelmeSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nHelmeMainAddValueMaxLimit, g_Config.nHelmeMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nHelmeSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nHelmeSCAddValueMaxLimit, g_Config.nHelmeSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nHelmeXXAddValueMaxLimit, g_Config.nHelmeXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nHelmeHJAddValueMaxLimit, g_Config.nHelmeHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nHelmeQSAddValueMaxLimit, g_Config.nHelmeQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nHelmeDCAddValueMaxLimit, g_Config.nHelmeDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nHelmeMCAddValueMaxLimit, g_Config.nHelmeMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nHelmeMainAddValueMaxLimit, g_Config.nHelmeMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nHelmeMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nHelmeMainAddValueMaxLimit, g_Config.nHelmeMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nHelmeXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nHelmeXXAddValueMaxLimit, g_Config.nHelmeXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 100;
          if UserItem.btAppraisalValue[nCount + 2] > 110 then UserItem.btAppraisalValue[nCount + 2] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nHelmeHJAddValueMaxLimit, g_Config.nHelmeHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nHelmeQSAddValueMaxLimit, g_Config.nHelmeQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nHelmeDCAddValueMaxLimit, g_Config.nHelmeDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nHelmeMCAddValueMaxLimit, g_Config.nHelmeMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nHelmeSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nHelmeSCAddValueMaxLimit, g_Config.nHelmeSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//鉴定鞋子、腰带 20100824
function TItemUnit.RandomKamPoShoes;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 3 then Exit;
  if (not boClear) and (UserItem.btAppraisalValue[nCount + 2] <> 0) then begin Result := True;Exit;end;//防止重复上属性
  if boUnValue and RandomKamPoMysteryCount(UserItem, 0) then begin//神秘属性
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nShoesDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nShoesDCAddValueMaxLimit, g_Config.nShoesDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nShoesJMAddValueMaxLimit, g_Config.nShoesJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nShoesHJAddValueMaxLimit, g_Config.nShoesHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nShoesQSAddValueMaxLimit, g_Config.nShoesQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nShoesMCAddValueMaxLimit, g_Config.nShoesMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nShoesSCAddValueMaxLimit, g_Config.nShoesSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nShoesMainAddValueMaxLimit, g_Config.nShoesMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nShoesMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nShoesMCAddValueMaxLimit, g_Config.nShoesMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nShoesJMAddValueMaxLimit, g_Config.nShoesJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nShoesHJAddValueMaxLimit, g_Config.nShoesHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nShoesQSAddValueMaxLimit, g_Config.nShoesQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nShoesDCAddValueMaxLimit, g_Config.nShoesDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nShoesSCAddValueMaxLimit, g_Config.nShoesSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nShoesMainAddValueMaxLimit, g_Config.nShoesMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nShoesSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nShoesSCAddValueMaxLimit, g_Config.nShoesSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nShoesJMAddValueMaxLimit, g_Config.nShoesJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nShoesHJAddValueMaxLimit, g_Config.nShoesHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nShoesQSAddValueMaxLimit, g_Config.nShoesQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nShoesDCAddValueMaxLimit, g_Config.nShoesDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nShoesMCAddValueMaxLimit, g_Config.nShoesMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nShoesMainAddValueMaxLimit, g_Config.nShoesMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nShoesMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nShoesMainAddValueMaxLimit, g_Config.nShoesMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nShoesJMAddValueMaxLimit, g_Config.nShoesJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nShoesHJAddValueMaxLimit, g_Config.nShoesHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nShoesQSAddValueMaxLimit, g_Config.nShoesQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nShoesDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nShoesDCAddValueMaxLimit, g_Config.nShoesDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nShoesMCAddValueMaxLimit, g_Config.nShoesMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nShoesSCAddValueMaxLimit, g_Config.nShoesSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//鉴定勋章 20100824
function TItemUnit.RandomKamPoMedal;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 3 then Exit;
  if (not boClear) and (UserItem.btAppraisalValue[nCount + 2] <> 0) then begin Result := True;Exit;end;//防止重复上属性
  if boUnValue and RandomKamPoMysteryCount(UserItem, 0) then begin//神秘属性
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nMedalDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nMedalDCAddValueMaxLimit, g_Config.nMedalDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nMedalFBAddValueMaxLimit, g_Config.nMedalFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nMedalNLAddValueMaxLimit, g_Config.nMedalNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nMedalJMAddValueMaxLimit, g_Config.nMedalJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nMedalMBAddValueMaxLimit, g_Config.nMedalMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nMedalNSAddValueMaxLimit, g_Config.nMedalNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 110;
          if UserItem.btAppraisalValue[nCount + 2] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nMedalBJAddValueMaxLimit, g_Config.nMedalBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nMedalHJAddValueMaxLimit, g_Config.nMedalHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nMedalQSAddValueMaxLimit, g_Config.nMedalQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nMedalMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nMedalMCAddValueMaxLimit, g_Config.nMedalMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nMedalSCAddValueMaxLimit, g_Config.nMedalSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nMedalMainAddValueMaxLimit, g_Config.nMedalMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nMedalMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nMedalMCAddValueMaxLimit, g_Config.nMedalMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nMedalFBAddValueMaxLimit, g_Config.nMedalFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nMedalNLAddValueMaxLimit, g_Config.nMedalNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nMedalJMAddValueMaxLimit, g_Config.nMedalJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nMedalMBAddValueMaxLimit, g_Config.nMedalMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nMedalNSAddValueMaxLimit, g_Config.nMedalNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 110;
          if UserItem.btAppraisalValue[nCount + 2] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nMedalBJAddValueMaxLimit, g_Config.nMedalBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nMedalHJAddValueMaxLimit, g_Config.nMedalHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nMedalQSAddValueMaxLimit, g_Config.nMedalQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nMedalDCAddValueMaxLimit, g_Config.nMedalDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nMedalSCAddValueMaxLimit, g_Config.nMedalSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nMedalMainAddValueMaxLimit, g_Config.nMedalMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nMedalSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nMedalSCAddValueMaxLimit, g_Config.nMedalSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nMedalFBAddValueMaxLimit, g_Config.nMedalFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nMedalNLAddValueMaxLimit, g_Config.nMedalNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nMedalJMAddValueMaxLimit, g_Config.nMedalJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nMedalMBAddValueMaxLimit, g_Config.nMedalMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nMedalNSAddValueMaxLimit, g_Config.nMedalNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 110;
          if UserItem.btAppraisalValue[nCount + 2] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nMedalBJAddValueMaxLimit, g_Config.nMedalBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nMedalHJAddValueMaxLimit, g_Config.nMedalHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nMedalQSAddValueMaxLimit, g_Config.nMedalQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nMedalDCAddValueMaxLimit, g_Config.nMedalDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nMedalMCAddValueMaxLimit, g_Config.nMedalMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nMedalMainAddValueMaxLimit, g_Config.nMedalMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nMedalMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nMedalMainAddValueMaxLimit, g_Config.nMedalMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 60;
          if UserItem.btAppraisalValue[nCount + 2] > 70 then UserItem.btAppraisalValue[nCount + 2] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nMedalFBAddValueMaxLimit, g_Config.nMedalFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 130;
          if UserItem.btAppraisalValue[nCount + 2] > 140 then UserItem.btAppraisalValue[nCount + 2] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nMedalNLAddValueMaxLimit, g_Config.nMedalNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 70;
          if UserItem.btAppraisalValue[nCount + 2] > 80 then UserItem.btAppraisalValue[nCount + 2] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nMedalJMAddValueMaxLimit, g_Config.nMedalJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 80;
          if UserItem.btAppraisalValue[nCount + 2] > 90 then UserItem.btAppraisalValue[nCount + 2] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nMedalMBAddValueMaxLimit, g_Config.nMedalMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 160;
          if UserItem.btAppraisalValue[nCount + 2] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if boSpiritMedia and RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 230;
          if UserItem.btAppraisalValue[nCount + 2] > 250 then UserItem.btAppraisalValue[nCount + 2] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nMedalNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nMedalNSAddValueMaxLimit, g_Config.nMedalNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 110;
          if UserItem.btAppraisalValue[nCount + 2] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nMedalBJAddValueMaxLimit, g_Config.nMedalBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 120;
          if UserItem.btAppraisalValue[nCount + 2] > 130 then UserItem.btAppraisalValue[nCount + 2] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nMedalHJAddValueMaxLimit, g_Config.nMedalHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 180;
          if UserItem.btAppraisalValue[nCount + 2] > 230 then UserItem.btAppraisalValue[nCount + 2] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nMedalQSAddValueMaxLimit, g_Config.nMedalQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 90;
          if UserItem.btAppraisalValue[nCount + 2] > 100 then UserItem.btAppraisalValue[nCount + 2] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nMedalDCAddValueMaxLimit, g_Config.nMedalDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 10;
          if UserItem.btAppraisalValue[nCount + 2] > 20 then UserItem.btAppraisalValue[nCount + 2] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nMedalMCAddValueMaxLimit, g_Config.nMedalMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 20;
          if UserItem.btAppraisalValue[nCount + 2] > 30 then UserItem.btAppraisalValue[nCount + 2] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nMedalSCAddValueMaxLimit, g_Config.nMedalSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btAppraisalValue[nCount + 2] := nC + 30;
          if UserItem.btAppraisalValue[nCount + 2] > 40 then UserItem.btAppraisalValue[nCount + 2] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;

//-----------------------------------------------------------------------------
//鉴定见习物品神秘属性
function TItemUnit.TraineeItemScrollChangeWeapon(UserItem: pTUserItem; nCount: Byte): Boolean;
begin
  Result := False;
  if nCount = 1 then begin
    UserItem.btUnKnowValue[6] := 121;
    Result := True;
  end;
end;

//解读武器神秘属性 20100826
function TItemUnit.RandomScrollChangeWeapon(UserItem: pTUserItem; nCount: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 4 then Exit;
  if UserItem.btUnKnowValue[nCount + 5] <> 255 then Exit;//防止重复上属性
  if (Random(g_Config.nRebirthRate) = 0) and (g_Config.nRebirthRate <> 65535) and (UserItem.btUnKnowValue[6] <> 1) and
     (UserItem.btUnKnowValue[7] <> 1) and (UserItem.btUnKnowValue[8] <> 1) and
     (UserItem.btUnKnowValue[9] <> 1) then begin//重生技能
    UserItem.btUnKnowValue[nCount + 5] := 1;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nMagicShieldRate) = 0) and (g_Config.nMagicShieldRate <> 65535) and (UserItem.btUnKnowValue[6] <> 2) and
     (UserItem.btUnKnowValue[7] <> 2) and (UserItem.btUnKnowValue[8] <> 2) and
     (UserItem.btUnKnowValue[9] <> 2) then begin//八卦护身技能
    UserItem.btUnKnowValue[nCount + 5] := 2;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysisRate) = 0) and (g_Config.nParalysisRate <> 65535) and (UserItem.btUnKnowValue[6] <> 3) and
     (UserItem.btUnKnowValue[7] <> 3) and (UserItem.btUnKnowValue[8] <> 3) and
     (UserItem.btUnKnowValue[9] <> 3) then begin//麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 3;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis2Rate) = 0) and (g_Config.nParalysis2Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 4) and
     (UserItem.btUnKnowValue[7] <> 4) and (UserItem.btUnKnowValue[8] <> 4) and
     (UserItem.btUnKnowValue[9] <> 4) then begin//魔道麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 4;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis1Rate) = 0) and (g_Config.nParalysis1Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 5) and
     (UserItem.btUnKnowValue[7] <> 5) and (UserItem.btUnKnowValue[8] <> 5) and
     (UserItem.btUnKnowValue[9] <> 5) then begin//战意麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 5;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nProbeNecklaceRate) = 0) and (g_Config.nProbeNecklaceRate <> 65535) and (UserItem.btUnKnowValue[6] <> 6) and
     (UserItem.btUnKnowValue[7] <> 6) and (UserItem.btUnKnowValue[8] <> 6) and
     (UserItem.btUnKnowValue[9] <> 6) then begin//探测技能
    UserItem.btUnKnowValue[nCount + 5] := 6;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nTeleportRate) = 0) and (g_Config.nTeleportRate <> 65535) and (UserItem.btUnKnowValue[6] <> 7) and
     (UserItem.btUnKnowValue[7] <> 7) and (UserItem.btUnKnowValue[8] <> 7) and
     (UserItem.btUnKnowValue[9] <> 7) then begin//传送技能
    UserItem.btUnKnowValue[nCount + 5] := 7;
    Result := True;
    Exit;
  end;
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nArmsDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nArmsDCAddValueMaxLimit, g_Config.nArmsDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[12]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nArmsFBAddValueMaxLimit, g_Config.nArmsFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsZQAddRate) = 0 then begin//准确 141..150
        nC := GetRandomRange(g_Config.nArmsZQAddValueMaxLimit, g_Config.nArmsZQAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 140;
          if UserItem.btUnKnowValue[nCount + 5] > 150 then UserItem.btUnKnowValue[nCount + 5] := 150;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nArmsJMAddValueMaxLimit, g_Config.nArmsJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nArmsMBAddValueMaxLimit, g_Config.nArmsMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btAppraisalValue[nCount + 2] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nArmsNSAddValueMaxLimit, g_Config.nArmsNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 110;
          if UserItem.btUnKnowValue[nCount + 5] > 120 then UserItem.btAppraisalValue[nCount + 2] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nArmsBJAddValueMaxLimit, g_Config.nArmsBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nArmsHJAddValueMaxLimit, g_Config.nArmsHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nArmsQSAddValueMaxLimit, g_Config.nArmsQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nArmsMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nArmsMCAddValueMaxLimit, g_Config.nArmsMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nArmsSCAddValueMaxLimit, g_Config.nArmsSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nArmsMainAddValueMaxLimit, g_Config.nArmsMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nArmsMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nArmsMCAddValueMaxLimit, g_Config.nArmsMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nArmsFBAddValueMaxLimit, g_Config.nArmsFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[12]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsZQAddRate) = 0 then begin//准确 141..150
        nC := GetRandomRange(g_Config.nArmsZQAddValueMaxLimit, g_Config.nArmsZQAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 140;
          if UserItem.btUnKnowValue[nCount + 5] > 150 then UserItem.btUnKnowValue[nCount + 5] := 150;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nArmsJMAddValueMaxLimit, g_Config.nArmsJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nArmsMBAddValueMaxLimit, g_Config.nArmsMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nArmsNSAddValueMaxLimit, g_Config.nArmsNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 110;
          if UserItem.btUnKnowValue[nCount + 5] > 120 then UserItem.btUnKnowValue[nCount + 5] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nArmsBJAddValueMaxLimit, g_Config.nArmsBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nArmsHJAddValueMaxLimit, g_Config.nArmsHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nArmsQSAddValueMaxLimit, g_Config.nArmsQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nArmsDCAddValueMaxLimit, g_Config.nArmsDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nArmsSCAddValueMaxLimit, g_Config.nArmsSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nArmsMainAddValueMaxLimit, g_Config.nArmsMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nArmsSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nArmsSCAddValueMaxLimit, g_Config.nArmsSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nArmsFBAddValueMaxLimit, g_Config.nArmsFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsZQAddRate) = 0 then begin//准确 141..150
        nC := GetRandomRange(g_Config.nArmsZQAddValueMaxLimit, g_Config.nArmsZQAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 140;
          if UserItem.btUnKnowValue[nCount + 5] > 150 then UserItem.btUnKnowValue[nCount + 5] := 150;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nArmsJMAddValueMaxLimit, g_Config.nArmsJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[12]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nArmsMBAddValueMaxLimit, g_Config.nArmsMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nArmsNSAddValueMaxLimit, g_Config.nArmsNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 110;
          if UserItem.btUnKnowValue[nCount + 5] > 120 then UserItem.btUnKnowValue[nCount + 5] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nArmsBJAddValueMaxLimit, g_Config.nArmsBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nArmsHJAddValueMaxLimit, g_Config.nArmsHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nArmsQSAddValueMaxLimit, g_Config.nArmsQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nArmsDCAddValueMaxLimit, g_Config.nArmsDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nArmsMCAddValueMaxLimit, g_Config.nArmsMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nArmsMainAddValueMaxLimit, g_Config.nArmsMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nArmsMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nArmsMainAddValueMaxLimit, g_Config.nArmsMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nArmsFBAddValueMaxLimit, g_Config.nArmsFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsZQAddRate) = 0 then begin//准确 141..150
        nC := GetRandomRange(g_Config.nArmsZQAddValueMaxLimit, g_Config.nArmsZQAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 140;
          if UserItem.btUnKnowValue[nCount + 5] > 150 then UserItem.btUnKnowValue[nCount + 5] := 150;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nArmsJMAddValueMaxLimit, g_Config.nArmsJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nArmsMBAddValueMaxLimit, g_Config.nArmsMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nArmsNSAddValueMaxLimit, g_Config.nArmsNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 110;
          if UserItem.btUnKnowValue[nCount + 5] > 120 then UserItem.btUnKnowValue[nCount + 5] := 120;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[12]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nArmsBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nArmsBJAddValueMaxLimit, g_Config.nArmsBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nArmsHJAddValueMaxLimit, g_Config.nArmsHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nArmsQSAddValueMaxLimit, g_Config.nArmsQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nArmsDCAddValueMaxLimit, g_Config.nArmsDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nArmsMCAddValueMaxLimit, g_Config.nArmsMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nArmsSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nArmsSCAddValueMaxLimit, g_Config.nArmsSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//解读衣服神秘属性 20100827
function TItemUnit.RandomScrollChangeDre(UserItem: pTUserItem; nCount: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 4 then Exit;
  if UserItem.btUnKnowValue[nCount + 5] <> 255 then Exit;//防止重复上属性
  if (Random(g_Config.nRebirthRate) = 0) and (g_Config.nRebirthRate <> 65535) and (UserItem.btUnKnowValue[6] <> 1) and
     (UserItem.btUnKnowValue[7] <> 1) and (UserItem.btUnKnowValue[8] <> 1) and
     (UserItem.btUnKnowValue[9] <> 1) then begin//重生技能
    UserItem.btUnKnowValue[nCount + 5] := 1;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nMagicShieldRate) = 0) and (g_Config.nMagicShieldRate <> 65535) and (UserItem.btUnKnowValue[6] <> 2) and
     (UserItem.btUnKnowValue[7] <> 2) and (UserItem.btUnKnowValue[8] <> 2) and
     (UserItem.btUnKnowValue[9] <> 2) then begin//八卦护身技能
    UserItem.btUnKnowValue[nCount + 5] := 2;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysisRate) = 0) and (g_Config.nParalysisRate <> 65535) and (UserItem.btUnKnowValue[6] <> 3) and
     (UserItem.btUnKnowValue[7] <> 3) and (UserItem.btUnKnowValue[8] <> 3) and
     (UserItem.btUnKnowValue[9] <> 3) then begin//麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 3;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis2Rate) = 0) and (g_Config.nParalysis2Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 4) and
     (UserItem.btUnKnowValue[7] <> 4) and (UserItem.btUnKnowValue[8] <> 4) and
     (UserItem.btUnKnowValue[9] <> 4) then begin//魔道麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 4;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis1Rate) = 0) and (g_Config.nParalysis1Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 5) and
     (UserItem.btUnKnowValue[7] <> 5) and (UserItem.btUnKnowValue[8] <> 5) and
     (UserItem.btUnKnowValue[9] <> 5) then begin//战意麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 5;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nProbeNecklaceRate) = 0) and (g_Config.nProbeNecklaceRate <> 65535) and (UserItem.btUnKnowValue[6] <> 6) and
     (UserItem.btUnKnowValue[7] <> 6) and (UserItem.btUnKnowValue[8] <> 6) and
     (UserItem.btUnKnowValue[9] <> 6) then begin//探测技能
    UserItem.btUnKnowValue[nCount + 5] := 6;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nTeleportRate) = 0) and (g_Config.nTeleportRate <> 65535) and (UserItem.btUnKnowValue[6] <> 7) and
     (UserItem.btUnKnowValue[7] <> 7) and (UserItem.btUnKnowValue[8] <> 7) and
     (UserItem.btUnKnowValue[9] <> 7) then begin//传送技能
    UserItem.btUnKnowValue[nCount + 5] := 7;
    Result := True;
    Exit;
  end;  
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nDreDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nDreDCAddValueMaxLimit, g_Config.nDreDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nDreNLAddValueMaxLimit, g_Config.nDreNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nDreWFAddValueMaxLimit, g_Config.nDreWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nDreJMAddValueMaxLimit, g_Config.nDreJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nDreMBAddValueMaxLimit, g_Config.nDreMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nDreXXAddValueMaxLimit, g_Config.nDreXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nDreBJAddValueMaxLimit, g_Config.nDreBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nDreHJAddValueMaxLimit, g_Config.nDreHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nDreQSAddValueMaxLimit, g_Config.nDreQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nDreMCAddValueMaxLimit, g_Config.nDreMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nDreSCAddValueMaxLimit, g_Config.nDreSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nDreMainAddValueMaxLimit, g_Config.nDreMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nDreMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nDreMCAddValueMaxLimit, g_Config.nDreMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nDreNLAddValueMaxLimit, g_Config.nDreNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nDreWFAddValueMaxLimit, g_Config.nDreWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nDreJMAddValueMaxLimit, g_Config.nDreJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nDreMBAddValueMaxLimit, g_Config.nDreMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nDreXXAddValueMaxLimit, g_Config.nDreXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nDreBJAddValueMaxLimit, g_Config.nDreBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nDreHJAddValueMaxLimit, g_Config.nDreHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nDreQSAddValueMaxLimit, g_Config.nDreQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nDreDCAddValueMaxLimit, g_Config.nDreDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nDreSCAddValueMaxLimit, g_Config.nDreSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nDreMainAddValueMaxLimit, g_Config.nDreMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nDreSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nDreSCAddValueMaxLimit, g_Config.nDreSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nDreNLAddValueMaxLimit, g_Config.nDreNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nDreWFAddValueMaxLimit, g_Config.nDreWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nDreJMAddValueMaxLimit, g_Config.nDreJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nDreMBAddValueMaxLimit, g_Config.nDreMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nDreXXAddValueMaxLimit, g_Config.nDreXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nDreBJAddValueMaxLimit, g_Config.nDreBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nDreHJAddValueMaxLimit, g_Config.nDreHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nDreQSAddValueMaxLimit, g_Config.nDreQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nDreDCAddValueMaxLimit, g_Config.nDreDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nDreMCAddValueMaxLimit, g_Config.nDreMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nDreMainAddValueMaxLimit, g_Config.nDreMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nDreMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nDreMainAddValueMaxLimit, g_Config.nDreMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nDreNLAddValueMaxLimit, g_Config.nDreNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nDreWFAddValueMaxLimit, g_Config.nDreWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nDreJMAddValueMaxLimit, g_Config.nDreJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nDreMBAddValueMaxLimit, g_Config.nDreMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nDreXXAddValueMaxLimit, g_Config.nDreXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nDreBJAddValueMaxLimit, g_Config.nDreBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nDreHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nDreHJAddValueMaxLimit, g_Config.nDreHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nDreQSAddValueMaxLimit, g_Config.nDreQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nDreDCAddValueMaxLimit, g_Config.nDreDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nDreMCAddValueMaxLimit, g_Config.nDreMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nDreSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nDreSCAddValueMaxLimit, g_Config.nDreSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//解读项链神秘属性 20100827
function TItemUnit.RandomScrollChangeNecklace(UserItem: pTUserItem; nCount: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 4 then Exit;
  if UserItem.btUnKnowValue[nCount + 5] <> 255 then Exit;//防止重复上属性
  if (Random(g_Config.nRebirthRate) = 0) and (g_Config.nRebirthRate <> 65535) and (UserItem.btUnKnowValue[6] <> 1) and
     (UserItem.btUnKnowValue[7] <> 1) and (UserItem.btUnKnowValue[8] <> 1) and
     (UserItem.btUnKnowValue[9] <> 1) then begin//重生技能
    UserItem.btUnKnowValue[nCount + 5] := 1;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nMagicShieldRate) = 0) and (g_Config.nMagicShieldRate <> 65535) and (UserItem.btUnKnowValue[6] <> 2) and
     (UserItem.btUnKnowValue[7] <> 2) and (UserItem.btUnKnowValue[8] <> 2) and
     (UserItem.btUnKnowValue[9] <> 2) then begin//八卦护身技能
    UserItem.btUnKnowValue[nCount + 5] := 2;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysisRate) = 0) and (g_Config.nParalysisRate <> 65535) and (UserItem.btUnKnowValue[6] <> 3) and
     (UserItem.btUnKnowValue[7] <> 3) and (UserItem.btUnKnowValue[8] <> 3) and
     (UserItem.btUnKnowValue[9] <> 3) then begin//麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 3;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis2Rate) = 0) and (g_Config.nParalysis2Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 4) and
     (UserItem.btUnKnowValue[7] <> 4) and (UserItem.btUnKnowValue[8] <> 4) and
     (UserItem.btUnKnowValue[9] <> 4) then begin//魔道麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 4;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis1Rate) = 0) and (g_Config.nParalysis1Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 5) and
     (UserItem.btUnKnowValue[7] <> 5) and (UserItem.btUnKnowValue[8] <> 5) and
     (UserItem.btUnKnowValue[9] <> 5) then begin//战意麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 5;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nProbeNecklaceRate) = 0) and (g_Config.nProbeNecklaceRate <> 65535) and (UserItem.btUnKnowValue[6] <> 6) and
     (UserItem.btUnKnowValue[7] <> 6) and (UserItem.btUnKnowValue[8] <> 6) and
     (UserItem.btUnKnowValue[9] <> 6) then begin//探测技能
    UserItem.btUnKnowValue[nCount + 5] := 6;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nTeleportRate) = 0) and (g_Config.nTeleportRate <> 65535) and (UserItem.btUnKnowValue[6] <> 7) and
     (UserItem.btUnKnowValue[7] <> 7) and (UserItem.btUnKnowValue[8] <> 7) and
     (UserItem.btUnKnowValue[9] <> 7) then begin//传送技能
    UserItem.btUnKnowValue[nCount + 5] := 7;
    Result := True;
    Exit;
  end;  
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nNecklaceDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nNecklaceDCAddValueMaxLimit, g_Config.nNecklaceDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nNecklaceNLAddValueMaxLimit, g_Config.nNecklaceNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nNecklaceMFAddValueMaxLimit, g_Config.nNecklaceMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 40;
          if UserItem.btUnKnowValue[nCount + 5] > 50 then UserItem.btUnKnowValue[nCount + 5] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nNecklaceXXAddValueMaxLimit, g_Config.nNecklaceXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nNecklaceHJAddValueMaxLimit, g_Config.nNecklaceHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nNecklaceQSAddValueMaxLimit, g_Config.nNecklaceQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nNecklaceSCAddValueMaxLimit, g_Config.nNecklaceSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nNecklaceMainAddValueMaxLimit, g_Config.nNecklaceMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nNecklaceNLAddValueMaxLimit, g_Config.nNecklaceNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nNecklaceMFAddValueMaxLimit, g_Config.nNecklaceMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 40;
          if UserItem.btUnKnowValue[nCount + 5] > 50 then UserItem.btUnKnowValue[nCount + 5] := 50;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nNecklaceXXAddValueMaxLimit, g_Config.nNecklaceXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nNecklaceHJAddValueMaxLimit, g_Config.nNecklaceHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nNecklaceDCAddValueMaxLimit, g_Config.nNecklaceDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nNecklaceSCAddValueMaxLimit, g_Config.nNecklaceSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nNecklaceMainAddValueMaxLimit, g_Config.nNecklaceMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nNecklaceSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nNecklaceSCAddValueMaxLimit, g_Config.nNecklaceSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nNecklaceNLAddValueMaxLimit, g_Config.nNecklaceNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nNecklaceMFAddValueMaxLimit, g_Config.nNecklaceMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 40;
          if UserItem.btUnKnowValue[nCount + 5] > 50 then UserItem.btUnKnowValue[nCount + 5] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nNecklaceXXAddValueMaxLimit, g_Config.nNecklaceXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nNecklaceHJAddValueMaxLimit, g_Config.nNecklaceHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nNecklaceDCAddValueMaxLimit, g_Config.nNecklaceDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nNecklaceMainAddValueMaxLimit, g_Config.nNecklaceMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nNecklaceMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nNecklaceMainAddValueMaxLimit, g_Config.nNecklaceMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nNecklaceNLAddValueMaxLimit, g_Config.nNecklaceNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nNecklaceMFAddValueMaxLimit, g_Config.nNecklaceMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 40;
          if UserItem.btUnKnowValue[nCount + 5] > 50 then UserItem.btUnKnowValue[nCount + 5] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nNecklaceXXAddValueMaxLimit, g_Config.nNecklaceXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nNecklaceHJAddValueMaxLimit, g_Config.nNecklaceHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nNecklaceQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nNecklaceQSAddValueMaxLimit, g_Config.nNecklaceQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nNecklaceDCAddValueMaxLimit, g_Config.nNecklaceDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nNecklaceMCAddValueMaxLimit, g_Config.nNecklaceMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nNecklaceSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nNecklaceSCAddValueMaxLimit, g_Config.nNecklaceSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//解读手镯神秘属性 20100827
function TItemUnit.RandomScrollChangeBracelet(UserItem: pTUserItem; nCount: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 4 then Exit;
  if UserItem.btUnKnowValue[nCount + 5] <> 255 then Exit;//防止重复上属性
  if (Random(g_Config.nRebirthRate) = 0) and (g_Config.nRebirthRate <> 65535) and (UserItem.btUnKnowValue[6] <> 1) and
     (UserItem.btUnKnowValue[7] <> 1) and (UserItem.btUnKnowValue[8] <> 1) and
     (UserItem.btUnKnowValue[9] <> 1) then begin//重生技能
    UserItem.btUnKnowValue[nCount + 5] := 1;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nMagicShieldRate) = 0) and (g_Config.nMagicShieldRate <> 65535) and (UserItem.btUnKnowValue[6] <> 2) and
     (UserItem.btUnKnowValue[7] <> 2) and (UserItem.btUnKnowValue[8] <> 2) and
     (UserItem.btUnKnowValue[9] <> 2) then begin//八卦护身技能
    UserItem.btUnKnowValue[nCount + 5] := 2;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysisRate) = 0) and (g_Config.nParalysisRate <> 65535) and (UserItem.btUnKnowValue[6] <> 3) and
     (UserItem.btUnKnowValue[7] <> 3) and (UserItem.btUnKnowValue[8] <> 3) and
     (UserItem.btUnKnowValue[9] <> 3) then begin//麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 3;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis2Rate) = 0) and (g_Config.nParalysis2Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 4) and
     (UserItem.btUnKnowValue[7] <> 4) and (UserItem.btUnKnowValue[8] <> 4) and
     (UserItem.btUnKnowValue[9] <> 4) then begin//魔道麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 4;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis1Rate) = 0) and (g_Config.nParalysis1Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 5) and
     (UserItem.btUnKnowValue[7] <> 5) and (UserItem.btUnKnowValue[8] <> 5) and
     (UserItem.btUnKnowValue[9] <> 5) then begin//战意麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 5;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nProbeNecklaceRate) = 0) and (g_Config.nProbeNecklaceRate <> 65535) and (UserItem.btUnKnowValue[6] <> 6) and
     (UserItem.btUnKnowValue[7] <> 6) and (UserItem.btUnKnowValue[8] <> 6) and
     (UserItem.btUnKnowValue[9] <> 6) then begin//探测技能
    UserItem.btUnKnowValue[nCount + 5] := 6;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nTeleportRate) = 0) and (g_Config.nTeleportRate <> 65535) and (UserItem.btUnKnowValue[6] <> 7) and
     (UserItem.btUnKnowValue[7] <> 7) and (UserItem.btUnKnowValue[8] <> 7) and
     (UserItem.btUnKnowValue[9] <> 7) then begin//传送技能
    UserItem.btUnKnowValue[nCount + 5] := 7;
    Result := True;
    Exit;
  end;  
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nBraceletDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nBraceletDCAddValueMaxLimit, g_Config.nBraceletDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nBraceletNLAddValueMaxLimit, g_Config.nBraceletNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nBraceletMFAddValueMaxLimit, g_Config.nBraceletMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 40;
          if UserItem.btUnKnowValue[nCount + 5] > 50 then UserItem.btUnKnowValue[nCount + 5] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nBraceletXXAddValueMaxLimit, g_Config.nBraceletXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nBraceletHJAddValueMaxLimit, g_Config.nBraceletHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nBraceletQSAddValueMaxLimit, g_Config.nBraceletQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nBraceletSCAddValueMaxLimit, g_Config.nBraceletSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nBraceletMainAddValueMaxLimit, g_Config.nBraceletMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nBraceletNLAddValueMaxLimit, g_Config.nBraceletNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nBraceletMFAddValueMaxLimit, g_Config.nBraceletMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 40;
          if UserItem.btUnKnowValue[nCount + 5] > 50 then UserItem.btUnKnowValue[nCount + 5] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nBraceletXXAddValueMaxLimit, g_Config.nBraceletXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nBraceletHJAddValueMaxLimit, g_Config.nBraceletHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nBraceletDCAddValueMaxLimit, g_Config.nBraceletDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nBraceletSCAddValueMaxLimit, g_Config.nBraceletSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nBraceletMainAddValueMaxLimit, g_Config.nBraceletMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nBraceletSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nBraceletSCAddValueMaxLimit, g_Config.nBraceletSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nBraceletNLAddValueMaxLimit, g_Config.nBraceletNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nBraceletMFAddValueMaxLimit, g_Config.nBraceletMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 40;
          if UserItem.btUnKnowValue[nCount + 5] > 50 then UserItem.btUnKnowValue[nCount + 5] := 50;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nBraceletXXAddValueMaxLimit, g_Config.nBraceletXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nBraceletHJAddValueMaxLimit, g_Config.nBraceletHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nBraceletDCAddValueMaxLimit, g_Config.nBraceletDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nBraceletMainAddValueMaxLimit, g_Config.nBraceletMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nBraceletMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nBraceletMainAddValueMaxLimit, g_Config.nBraceletMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nBraceletNLAddValueMaxLimit, g_Config.nBraceletNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMFAddRate) = 0 then begin//魔防上限 41..50
        nC := GetRandomRange(g_Config.nBraceletMFAddValueMaxLimit, g_Config.nBraceletMFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 40;
          if UserItem.btUnKnowValue[nCount + 5] > 50 then UserItem.btUnKnowValue[nCount + 5] := 50;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nBraceletXXAddValueMaxLimit, g_Config.nBraceletXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nBraceletHJAddValueMaxLimit, g_Config.nBraceletHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nBraceletQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nBraceletQSAddValueMaxLimit, g_Config.nBraceletQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nBraceletDCAddValueMaxLimit, g_Config.nBraceletDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nBraceletMCAddValueMaxLimit, g_Config.nBraceletMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nBraceletSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nBraceletSCAddValueMaxLimit, g_Config.nBraceletSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//解读戒指秘属性 20100827
function TItemUnit.RandomScrollChangeRing(UserItem: pTUserItem; nCount: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 4 then Exit;
  if UserItem.btUnKnowValue[nCount + 5] <> 255 then Exit;//防止重复上属性
  if (Random(g_Config.nRebirthRate) = 0) and (g_Config.nRebirthRate <> 65535) and (UserItem.btUnKnowValue[6] <> 1) and
     (UserItem.btUnKnowValue[7] <> 1) and (UserItem.btUnKnowValue[8] <> 1) and
     (UserItem.btUnKnowValue[9] <> 1) then begin//重生技能
    UserItem.btUnKnowValue[nCount + 5] := 1;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nMagicShieldRate) = 0) and (g_Config.nMagicShieldRate <> 65535) and (UserItem.btUnKnowValue[6] <> 2) and
     (UserItem.btUnKnowValue[7] <> 2) and (UserItem.btUnKnowValue[8] <> 2) and
     (UserItem.btUnKnowValue[9] <> 2) then begin//八卦护身技能
    UserItem.btUnKnowValue[nCount + 5] := 2;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysisRate) = 0) and (g_Config.nParalysisRate <> 65535) and (UserItem.btUnKnowValue[6] <> 3) and
     (UserItem.btUnKnowValue[7] <> 3) and (UserItem.btUnKnowValue[8] <> 3) and
     (UserItem.btUnKnowValue[9] <> 3) then begin//麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 3;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis2Rate) = 0) and (g_Config.nParalysis2Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 4) and
     (UserItem.btUnKnowValue[7] <> 4) and (UserItem.btUnKnowValue[8] <> 4) and
     (UserItem.btUnKnowValue[9] <> 4) then begin//魔道麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 4;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis1Rate) = 0) and (g_Config.nParalysis1Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 5) and
     (UserItem.btUnKnowValue[7] <> 5) and (UserItem.btUnKnowValue[8] <> 5) and
     (UserItem.btUnKnowValue[9] <> 5) then begin//战意麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 5;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nProbeNecklaceRate) = 0) and (g_Config.nProbeNecklaceRate <> 65535) and (UserItem.btUnKnowValue[6] <> 6) and
     (UserItem.btUnKnowValue[7] <> 6) and (UserItem.btUnKnowValue[8] <> 6) and
     (UserItem.btUnKnowValue[9] <> 6) then begin//探测技能
    UserItem.btUnKnowValue[nCount + 5] := 6;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nTeleportRate) = 0) and (g_Config.nTeleportRate <> 65535) and (UserItem.btUnKnowValue[6] <> 7) and
     (UserItem.btUnKnowValue[7] <> 7) and (UserItem.btUnKnowValue[8] <> 7) and
     (UserItem.btUnKnowValue[9] <> 7) then begin//传送技能
    UserItem.btUnKnowValue[nCount + 5] := 7;
    Result := True;
    Exit;
  end;  
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//解读头盔、斗笠神秘属性 20100827
function TItemUnit.RandomScrollChangeHelme(UserItem: pTUserItem; nCount: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 4 then Exit;
  if UserItem.btUnKnowValue[nCount + 5] <> 255 then Exit;//防止重复上属性
  if (Random(g_Config.nRebirthRate) = 0) and (g_Config.nRebirthRate <> 65535) and (UserItem.btUnKnowValue[6] <> 1) and
     (UserItem.btUnKnowValue[7] <> 1) and (UserItem.btUnKnowValue[8] <> 1) and
     (UserItem.btUnKnowValue[9] <> 1) then begin//重生技能
    UserItem.btUnKnowValue[nCount + 5] := 1;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nMagicShieldRate) = 0) and (g_Config.nMagicShieldRate <> 65535) and (UserItem.btUnKnowValue[6] <> 2) and
     (UserItem.btUnKnowValue[7] <> 2) and (UserItem.btUnKnowValue[8] <> 2) and
     (UserItem.btUnKnowValue[9] <> 2) then begin//八卦护身技能
    UserItem.btUnKnowValue[nCount + 5] := 2;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysisRate) = 0) and (g_Config.nParalysisRate <> 65535) and (UserItem.btUnKnowValue[6] <> 3) and
     (UserItem.btUnKnowValue[7] <> 3) and (UserItem.btUnKnowValue[8] <> 3) and
     (UserItem.btUnKnowValue[9] <> 3) then begin//麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 3;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis2Rate) = 0) and (g_Config.nParalysis2Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 4) and
     (UserItem.btUnKnowValue[7] <> 4) and (UserItem.btUnKnowValue[8] <> 4) and
     (UserItem.btUnKnowValue[9] <> 4) then begin//魔道麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 4;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis1Rate) = 0) and (g_Config.nParalysis1Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 5) and
     (UserItem.btUnKnowValue[7] <> 5) and (UserItem.btUnKnowValue[8] <> 5) and
     (UserItem.btUnKnowValue[9] <> 5) then begin//战意麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 5;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nProbeNecklaceRate) = 0) and (g_Config.nProbeNecklaceRate <> 65535) and (UserItem.btUnKnowValue[6] <> 6) and
     (UserItem.btUnKnowValue[7] <> 6) and (UserItem.btUnKnowValue[8] <> 6) and
     (UserItem.btUnKnowValue[9] <> 6) then begin//探测技能
    UserItem.btUnKnowValue[nCount + 5] := 6;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nTeleportRate) = 0) and (g_Config.nTeleportRate <> 65535) and (UserItem.btUnKnowValue[6] <> 7) and
     (UserItem.btUnKnowValue[7] <> 7) and (UserItem.btUnKnowValue[8] <> 7) and
     (UserItem.btUnKnowValue[9] <> 7) then begin//传送技能
    UserItem.btUnKnowValue[nCount + 5] := 7;
    Result := True;
    Exit;
  end;  
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nRingMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nRingMainAddValueMaxLimit, g_Config.nRingMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nRingNLAddValueMaxLimit, g_Config.nRingNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingWFAddRate) = 0 then begin//物防上限 51..60
        nC := GetRandomRange(g_Config.nRingWFAddValueMaxLimit, g_Config.nRingWFAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 50;
          if UserItem.btUnKnowValue[nCount + 5] > 60 then UserItem.btUnKnowValue[nCount + 5] := 60;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nRingJMAddValueMaxLimit, g_Config.nRingJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nRingMBAddValueMaxLimit, g_Config.nRingMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingXXAddRate) = 0 then begin//吸血上限 101..110
        nC := GetRandomRange(g_Config.nRingXXAddValueMaxLimit, g_Config.nRingXXAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 100;
          if UserItem.btUnKnowValue[nCount + 5] > 110 then UserItem.btUnKnowValue[nCount + 5] := 110;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nRingFBAddValueMaxLimit, g_Config.nRingFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nRingHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nRingHJAddValueMaxLimit, g_Config.nRingHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nRingQSAddValueMaxLimit, g_Config.nRingQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nRingDCAddValueMaxLimit, g_Config.nRingDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nRingMCAddValueMaxLimit, g_Config.nRingMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nRingSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nRingSCAddValueMaxLimit, g_Config.nRingSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//解读鞋子、腰带神秘属性 20100827
function TItemUnit.RandomScrollChangeShoes(UserItem: pTUserItem; nCount: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 4 then Exit;
  if UserItem.btUnKnowValue[nCount + 5] <> 255 then Exit;//防止重复上属性
  if (Random(g_Config.nRebirthRate) = 0) and (g_Config.nRebirthRate <> 65535) and (UserItem.btUnKnowValue[6] <> 1) and
     (UserItem.btUnKnowValue[7] <> 1) and (UserItem.btUnKnowValue[8] <> 1) and
     (UserItem.btUnKnowValue[9] <> 1) then begin//重生技能
    UserItem.btUnKnowValue[nCount + 5] := 1;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nMagicShieldRate) = 0) and (g_Config.nMagicShieldRate <> 65535) and (UserItem.btUnKnowValue[6] <> 2) and
     (UserItem.btUnKnowValue[7] <> 2) and (UserItem.btUnKnowValue[8] <> 2) and
     (UserItem.btUnKnowValue[9] <> 2) then begin//八卦护身技能
    UserItem.btUnKnowValue[nCount + 5] := 2;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysisRate) = 0) and (g_Config.nParalysisRate <> 65535) and (UserItem.btUnKnowValue[6] <> 3) and
     (UserItem.btUnKnowValue[7] <> 3) and (UserItem.btUnKnowValue[8] <> 3) and
     (UserItem.btUnKnowValue[9] <> 3) then begin//麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 3;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis2Rate) = 0) and (g_Config.nParalysis2Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 4) and
     (UserItem.btUnKnowValue[7] <> 4) and (UserItem.btUnKnowValue[8] <> 4) and
     (UserItem.btUnKnowValue[9] <> 4) then begin//魔道麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 4;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis1Rate) = 0) and (g_Config.nParalysis1Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 5) and
     (UserItem.btUnKnowValue[7] <> 5) and (UserItem.btUnKnowValue[8] <> 5) and
     (UserItem.btUnKnowValue[9] <> 5) then begin//战意麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 5;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nProbeNecklaceRate) = 0) and (g_Config.nProbeNecklaceRate <> 65535) and (UserItem.btUnKnowValue[6] <> 6) and
     (UserItem.btUnKnowValue[7] <> 6) and (UserItem.btUnKnowValue[8] <> 6) and
     (UserItem.btUnKnowValue[9] <> 6) then begin//探测技能
    UserItem.btUnKnowValue[nCount + 5] := 6;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nTeleportRate) = 0) and (g_Config.nTeleportRate <> 65535) and (UserItem.btUnKnowValue[6] <> 7) and
     (UserItem.btUnKnowValue[7] <> 7) and (UserItem.btUnKnowValue[8] <> 7) and
     (UserItem.btUnKnowValue[9] <> 7) then begin//传送技能
    UserItem.btUnKnowValue[nCount + 5] := 7;
    Result := True;
    Exit;
  end;  
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nShoesDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nShoesDCAddValueMaxLimit, g_Config.nShoesDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nShoesJMAddValueMaxLimit, g_Config.nShoesJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nShoesHJAddValueMaxLimit, g_Config.nShoesHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nShoesQSAddValueMaxLimit, g_Config.nShoesQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nShoesMCAddValueMaxLimit, g_Config.nShoesMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nShoesSCAddValueMaxLimit, g_Config.nShoesSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nShoesMainAddValueMaxLimit, g_Config.nShoesMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nShoesMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nShoesMCAddValueMaxLimit, g_Config.nShoesMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nShoesJMAddValueMaxLimit, g_Config.nShoesJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nShoesHJAddValueMaxLimit, g_Config.nShoesHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nShoesQSAddValueMaxLimit, g_Config.nShoesQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nShoesDCAddValueMaxLimit, g_Config.nShoesDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nShoesSCAddValueMaxLimit, g_Config.nShoesSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nShoesMainAddValueMaxLimit, g_Config.nShoesMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nShoesSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nShoesSCAddValueMaxLimit, g_Config.nShoesSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nShoesJMAddValueMaxLimit, g_Config.nShoesJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nShoesHJAddValueMaxLimit, g_Config.nShoesHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nShoesQSAddValueMaxLimit, g_Config.nShoesQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nShoesDCAddValueMaxLimit, g_Config.nShoesDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nShoesMCAddValueMaxLimit, g_Config.nShoesMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nShoesMainAddValueMaxLimit, g_Config.nShoesMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nShoesMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nShoesMainAddValueMaxLimit, g_Config.nShoesMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nShoesJMAddValueMaxLimit, g_Config.nShoesJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nShoesHJAddValueMaxLimit, g_Config.nShoesHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nShoesQSAddValueMaxLimit, g_Config.nShoesQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nShoesDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nShoesDCAddValueMaxLimit, g_Config.nShoesDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nShoesMCAddValueMaxLimit, g_Config.nShoesMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nShoesSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nShoesSCAddValueMaxLimit, g_Config.nShoesSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
//解读勋章神秘属性 20100827
function TItemUnit.RandomScrollChangeMedal(UserItem: pTUserItem; nCount: Byte): Boolean;
var
  nC: Integer;
begin
  Result := False;
  if nCount > 4 then Exit;
  if UserItem.btUnKnowValue[nCount + 5] <> 255 then Exit;//防止重复上属性
  if (Random(g_Config.nRebirthRate) = 0) and (g_Config.nRebirthRate <> 65535) and (UserItem.btUnKnowValue[6] <> 1) and
     (UserItem.btUnKnowValue[7] <> 1) and (UserItem.btUnKnowValue[8] <> 1) and
     (UserItem.btUnKnowValue[9] <> 1) then begin//重生技能
    UserItem.btUnKnowValue[nCount + 5] := 1;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nMagicShieldRate) = 0) and (g_Config.nMagicShieldRate <> 65535) and (UserItem.btUnKnowValue[6] <> 2) and
     (UserItem.btUnKnowValue[7] <> 2) and (UserItem.btUnKnowValue[8] <> 2) and
     (UserItem.btUnKnowValue[9] <> 2) then begin//八卦护身技能
    UserItem.btUnKnowValue[nCount + 5] := 2;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysisRate) = 0) and (g_Config.nParalysisRate <> 65535) and (UserItem.btUnKnowValue[6] <> 3) and
     (UserItem.btUnKnowValue[7] <> 3) and (UserItem.btUnKnowValue[8] <> 3) and
     (UserItem.btUnKnowValue[9] <> 3) then begin//麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 3;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis2Rate) = 0) and (g_Config.nParalysis2Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 4) and
     (UserItem.btUnKnowValue[7] <> 4) and (UserItem.btUnKnowValue[8] <> 4) and
     (UserItem.btUnKnowValue[9] <> 4) then begin//魔道麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 4;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nParalysis1Rate) = 0) and (g_Config.nParalysis1Rate <> 65535) and (UserItem.btUnKnowValue[6] <> 5) and
     (UserItem.btUnKnowValue[7] <> 5) and (UserItem.btUnKnowValue[8] <> 5) and
     (UserItem.btUnKnowValue[9] <> 5) then begin//战意麻痹技能
    UserItem.btUnKnowValue[nCount + 5] := 5;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nProbeNecklaceRate) = 0) and (g_Config.nProbeNecklaceRate <> 65535) and (UserItem.btUnKnowValue[6] <> 6) and
     (UserItem.btUnKnowValue[7] <> 6) and (UserItem.btUnKnowValue[8] <> 6) and
     (UserItem.btUnKnowValue[9] <> 6) then begin//探测技能
    UserItem.btUnKnowValue[nCount + 5] := 6;
    Result := True;
    Exit;
  end;
  if (Random(g_Config.nTeleportRate) = 0) and (g_Config.nTeleportRate <> 65535) and (UserItem.btUnKnowValue[6] <> 7) and
     (UserItem.btUnKnowValue[7] <> 7) and (UserItem.btUnKnowValue[8] <> 7) and
     (UserItem.btUnKnowValue[9] <> 7) then begin//传送技能
    UserItem.btUnKnowValue[nCount + 5] := 7;
    Result := True;
    Exit;
  end;  
  case Random(4) of
    0: begin//方案一
      if Random(g_Config.nMedalDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nMedalDCAddValueMaxLimit, g_Config.nMedalDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nMedalFBAddValueMaxLimit, g_Config.nMedalFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nMedalNLAddValueMaxLimit, g_Config.nMedalNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nMedalJMAddValueMaxLimit, g_Config.nMedalJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nMedalMBAddValueMaxLimit, g_Config.nMedalMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nMedalNSAddValueMaxLimit, g_Config.nMedalNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 110;
          if UserItem.btUnKnowValue[nCount + 5] > 120 then UserItem.btUnKnowValue[nCount + 5] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nMedalBJAddValueMaxLimit, g_Config.nMedalBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nMedalHJAddValueMaxLimit, g_Config.nMedalHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nMedalQSAddValueMaxLimit, g_Config.nMedalQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nMedalMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nMedalMCAddValueMaxLimit, g_Config.nMedalMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nMedalSCAddValueMaxLimit, g_Config.nMedalSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nMedalMainAddValueMaxLimit, g_Config.nMedalMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//0
    1: begin//方案二
      if Random(g_Config.nMedalMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nMedalMCAddValueMaxLimit, g_Config.nMedalMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nMedalFBAddValueMaxLimit, g_Config.nMedalFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nMedalNLAddValueMaxLimit, g_Config.nMedalNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nMedalJMAddValueMaxLimit, g_Config.nMedalJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nMedalMBAddValueMaxLimit, g_Config.nMedalMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nMedalNSAddValueMaxLimit, g_Config.nMedalNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 110;
          if UserItem.btUnKnowValue[nCount + 5] > 120 then UserItem.btUnKnowValue[nCount + 5] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nMedalBJAddValueMaxLimit, g_Config.nMedalBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nMedalHJAddValueMaxLimit, g_Config.nMedalHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nMedalQSAddValueMaxLimit, g_Config.nMedalQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nMedalDCAddValueMaxLimit, g_Config.nMedalDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nMedalSCAddValueMaxLimit, g_Config.nMedalSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nMedalMainAddValueMaxLimit, g_Config.nMedalMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//1
    2: begin//方案三
      if Random(g_Config.nMedalSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nMedalSCAddValueMaxLimit, g_Config.nMedalSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nMedalFBAddValueMaxLimit, g_Config.nMedalFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nMedalNLAddValueMaxLimit, g_Config.nMedalNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nMedalJMAddValueMaxLimit, g_Config.nMedalJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nMedalMBAddValueMaxLimit, g_Config.nMedalMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nMedalNSAddValueMaxLimit, g_Config.nMedalNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 110;
          if UserItem.btUnKnowValue[nCount + 5] > 120 then UserItem.btUnKnowValue[nCount + 5] := 120;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nMedalBJAddValueMaxLimit, g_Config.nMedalBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nMedalHJAddValueMaxLimit, g_Config.nMedalHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nMedalQSAddValueMaxLimit, g_Config.nMedalQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nMedalDCAddValueMaxLimit, g_Config.nMedalDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nMedalMCAddValueMaxLimit, g_Config.nMedalMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nMedalMainAddValueMaxLimit, g_Config.nMedalMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
    end;//2
    3: begin//方案四
      if Random(g_Config.nMedalMainAddRate) = 0 then begin//主属性 61..70
        nC := GetRandomRange(g_Config.nMedalMainAddValueMaxLimit, g_Config.nMedalMainAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 60;
          if UserItem.btUnKnowValue[nCount + 5] > 70 then UserItem.btUnKnowValue[nCount + 5] := 70;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalFBAddRate) = 0 then begin//防爆 131..140
        nC := GetRandomRange(g_Config.nMedalFBAddValueMaxLimit, g_Config.nMedalFBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 130;
          if UserItem.btUnKnowValue[nCount + 5] > 140 then UserItem.btUnKnowValue[nCount + 5] := 140;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNLAddRate) = 0 then begin//内力恢复 71..80
        nC := GetRandomRange(g_Config.nMedalNLAddValueMaxLimit, g_Config.nMedalNLAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 70;
          if UserItem.btUnKnowValue[nCount + 5] > 80 then UserItem.btUnKnowValue[nCount + 5] := 80;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalJMAddRate) = 0 then begin//聚魔等级 81..90
        nC := GetRandomRange(g_Config.nMedalJMAddValueMaxLimit, g_Config.nMedalJMAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 80;
          if UserItem.btUnKnowValue[nCount + 5] > 90 then UserItem.btUnKnowValue[nCount + 5] := 90;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMBAddRate) = 0 then begin//麻痹抗性 161..180
        nC := GetRandomRange(g_Config.nMedalMBAddValueMaxLimit, g_Config.nMedalMBAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 160;
          if UserItem.btUnKnowValue[nCount + 5] > 180 then UserItem.btUnKnowValue[nCount + 5] := 180;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalNSAddRate) = 0 then begin//内伤等级 111..120
        nC := GetRandomRange(g_Config.nMedalNSAddValueMaxLimit, g_Config.nMedalNSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 110;
          if UserItem.btUnKnowValue[nCount + 5] > 120 then UserItem.btUnKnowValue[nCount + 5] := 120;
          Result := True;
          Exit;
        end;
      end;
      if RandomSpiritMediaCount(UserItem) then begin//宝物灵媒 231..250
        nC := GetRandomRange(20, g_Config.nSpiritMediaAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 230;
          if UserItem.btUnKnowValue[nCount + 5] > 250 then UserItem.btUnKnowValue[nCount + 5] := 250;
          UserItem.btValue[11]:= g_Config.nMaxAuraValue;//当前灵气值
          Result := True;
          Exit;
        end;
      end;      
      if Random(g_Config.nMedalBJAddRate) = 0 then begin//暴击等级 121..130
        nC := GetRandomRange(g_Config.nMedalBJAddValueMaxLimit, g_Config.nMedalBJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 120;
          if UserItem.btUnKnowValue[nCount + 5] > 130 then UserItem.btUnKnowValue[nCount + 5] := 130;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalHJAddRate) = 0 then begin//合击威力 181..230
        nC := GetRandomRange(g_Config.nMedalHJAddValueMaxLimit, g_Config.nMedalHJAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 180;
          if UserItem.btUnKnowValue[nCount + 5] > 230 then UserItem.btUnKnowValue[nCount + 5] := 230;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalQSAddRate) = 0 then begin//强身等级 91..100
        nC := GetRandomRange(g_Config.nMedalQSAddValueMaxLimit, g_Config.nMedalQSAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 90;
          if UserItem.btUnKnowValue[nCount + 5] > 100 then UserItem.btUnKnowValue[nCount + 5] := 100;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalDCAddRate) = 0 then begin//攻击上限 11..20
        nC := GetRandomRange(g_Config.nMedalDCAddValueMaxLimit, g_Config.nMedalDCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 10;
          if UserItem.btUnKnowValue[nCount + 5] > 20 then UserItem.btUnKnowValue[nCount + 5] := 20;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalMCAddRate) = 0 then begin//魔法上限 21..30
        nC := GetRandomRange(g_Config.nMedalMCAddValueMaxLimit, g_Config.nMedalMCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 20;
          if UserItem.btUnKnowValue[nCount + 5] > 30 then UserItem.btUnKnowValue[nCount + 5] := 30;
          Result := True;
          Exit;
        end;
      end;
      if Random(g_Config.nMedalSCAddRate) = 0 then begin//道术上限 31..40
        nC := GetRandomRange(g_Config.nMedalSCAddValueMaxLimit, g_Config.nMedalSCAddValueRate);//点数
        if nC > 0 then begin
          UserItem.btUnKnowValue[nCount + 5] := nC + 30;
          if UserItem.btUnKnowValue[nCount + 5] > 40 then UserItem.btUnKnowValue[nCount + 5] := 40;
          Result := True;
          Exit;
        end;
      end;
    end;//3
  end;//Case
end;
{$IFEND}
end.
