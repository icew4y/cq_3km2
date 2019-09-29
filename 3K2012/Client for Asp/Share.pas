unit Share;

interface
uses Grobal2;
//var
//  g_sVersion        :String = '版本号：2009.06.12';

const
  g_sVerIdent          = '11.15';
  RUNLOGINCODE       = 0; //进入游戏状态码,默认为0 测试为 9
  CLIENTTYPE         = 0; //普通的为0 ,99 为管理客户端
    //0为测试版 1为免费版 2商业版
  GVersion = 2;      //1和2必须外面运行登陆器  否则客户端关闭
  {
  上
  面
  是
  控
  制
  是
  否
  为
  发
  布
  版
  本
  的
  }

  DEBUG         = 0;



   WINLEFT = 60;
   WINTOP  = 60;

   MAPDIR             = '\Map\'; //地图文件所在目录
   CONFIGFILE         = 'Config\%s.ini';
   SDOCONFIGFILE      = 'Config\Ly%s_%s\%s.ini';
   ITEMFILTER = 'Config\Ly%s_%s\ItemFilter.dat';
   MAINIMAGEFILE      = 'Data\Prguse.wil';
   MAINIMAGEFILE2     = 'Data\Prguse2.wil';
   MAINIMAGEFILE3     = 'Data\Prguse3.wil';

   CHRSELIMAGEFILE    = 'Data\ChrSel.wil';
   MINMAPIMAGEFILE    = 'Data\mmap.wil';
   TITLESIMAGEFILE    = 'Data\Tiles.wil';
   TITLESIMAGEFILE1   = 'Data\Tiles%d.wil';
   SMLTITLESIMAGEFILE = 'Data\SmTiles.wil';
   SMLTITLESIMAGEFILE1 = 'Data\SmTiles%d.wil';
   HUMWINGIMAGESFILE  = 'Data\HumEffect.wil';
   HUMWINGIMAGESFILE2  = 'Data\HumEffect2.wil';
   HUMWINGIMAGESFILE3  = 'Data\HumEffect3.wil';

   CBOHUMWINGIMAGESFILE  = 'Data\cboHumEffect.wis';
   CBOHUMWINGIMAGESFILE2  = 'Data\cboHumEffect2.wil';
   CBOHUMWINGIMAGESFILE3  = 'Data\cboHumEffect3.wil';

   MAGICONIMAGESFILE  = 'Data\MagIcon.wil';
   MAGICONIMAGESFILE2  = 'Data\MagIcon2.wil';
   HUMIMGIMAGESFILE   = 'Data\Hum.wil';
   CBOHUMIMGIMAGESFILE= 'Data\cbohum.wis';
   CBOHUMIMGIMAGESFILE3= 'Data\cbohum3.wis';
   HUM2IMGIMAGESFILE  = 'Data\Hum2.wil'; //20080501
   HUM3IMGIMAGESFILE  = 'Data\Hum3.wil';
   HUM4IMGIMAGESFILE  = 'Data\Hum4.wil';
   HAIRIMGIMAGESFILE  = 'Data\Hair2.wil';
   CBOHAIRIMAGESFILE  = 'Data\cbohair.wis';
   WEAPONIMAGESFILE   = 'Data\Weapon.wil';
   CBOWEAPONIMAGESFILE = 'Data\cboweapon.wis';
   CBOWEAPONIMAGESFILE3 = 'Data\cboweapon3.wil';
   
   WEAPON2IMAGESFILE  = 'Data\Weapon2.wil';
   WEAPON3IMAGESFILE  = 'Data\Weapon3.wil'; 

   NPCIMAGESFILE      = 'Data\Npc.wil';
   NPC2IMAGESFILE     = 'Data\Npc2.wil';
   MAGICIMAGESFILE    = 'Data\Magic.wil';
   MAGIC2IMAGESFILE   = 'Data\Magic2.wil';
   MAGIC3IMAGESFILE   = 'Data\Magic3.wil';
   MAGIC4IMAGESFILE   = 'Data\Magic4.wil'; //2007.10.28
   MAGIC5IMAGESFILE   = 'Data\Magic5.wil'; //2007.11.29
   MAGIC6IMAGESFILE   = 'Data\Magic6.wil'; //2007.11.29

   MAGIC7IMAGESFILE   = 'Data\Magic7.wil';
   MAGIC7IMAGESFILE16 = 'Data\Magic7-16.wil';
   MAGIC8IMAGESFILE   = 'Data\Magic8.wil';
   MAGIC8IMAGESFILE16 = 'Data\Magic8-16.wil';

   MAGIC9IMAGESFILE    = 'Data\Magic9.wil';
   MAGIC10IMAGESFILE   = 'Data\Magic10.wil';

   CBOEFFECTIMAGESFILE= 'Data\cboEffect.wis';
   qingqingFILE       = 'Data\Qk_Prguse.wil';
   TasUiFILE          = 'Data\TasUi.wil'; //优先考虑GM定义的皮肤文件 By TasNat at: 2012-04-15 13:46:46
   chantkkFILE        = 'Data\Qk_Prguse16.wil'; // liuzhigang add

   UI1IMAGESFILE      = 'Data\Ui1.wil';
   UI3IMAGESFILE      = 'Data\Ui3.wil';
   STATEEFFECTFILE    = 'Data\StateEffect.wil';
   NEWOPUIFIle        = 'Data\NewopUI.wil';

   BAGITEMIMAGESFILE   = 'Data\Items.wil';
   BAGITEMIMAGESFILE2   = 'Data\Items2.wil';
   STATEITEMIMAGESFILE = 'Data\StateItem.wil';
   STATEITEMIMAGESFILE2 = 'Data\StateItem2.wil';

   DNITEMIMAGESFILE    = 'Data\DnItems.wil';
   DNITEMIMAGESFILE2    = 'Data\DnItems2.wil';

   OBJECTIMAGEFILE     = 'Data\Objects.wil';
   OBJECTIMAGEFILE1    = 'Data\Objects%d.wil';
   MONIMAGEFILE        = 'Data\Mon%d.wil';
   DRAGONIMAGEFILE     = 'Data\Dragon.wil';
   EFFECTIMAGEFILE     = 'Data\Effect.wil';
   DRAGONIMGESFILE     = 'Data\Dragon.wil';
   WEAPONEFFECTFILE    = 'Data\WeaponEffect.wil';
   MONKULOUIMAGEFILE   = 'Data\Mon-kulou.wil';

  MAXBAGITEMCL = 52;
  ENEMYCOLOR = 69;
  
  BuildData = '版：2012.12.18';
  {$IF M2Version = 0}
  g_sVersion = '合击' + BuildData;
  {$ELSEIF M2Version = 2}
  g_sVersion = '1.76' + BuildData;
  {$ELSE}
  g_sVersion = '连击' + BuildData;
  {$IFEND}

implementation


end.
