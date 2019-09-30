unit Share;

interface
uses Grobal2;

const

  RUNLOGINCODE       = 0; //进入游戏状态码,默认为0 测试为 9
  CLIENTTYPE         = 0; //普通的为0 ,99 为管理客户端
    //0为测试版 1为免费版 2商业版
  GVersion = 2;      //1和2必须外面运行登陆器  否则客户端关闭

  DEBUG         = 0;
  SWH800        = 0;
  SWH1024       = 1;
  SWH           = SWH800;

{$IF SWH = SWH800}
   SCREENWIDTH = 800;
   SCREENHEIGHT = 600;
{$ELSEIF SWH = SWH1024}
   SCREENWIDTH = 1024;
   SCREENHEIGHT = 768;
{$IFEND}

   MAPSURFACEWIDTH = SCREENWIDTH;
   MAPSURFACEHEIGHT = SCREENHEIGHT- 155;

   WINLEFT = 60;
   WINTOP  = 60;
   WINRIGHT = SCREENWIDTH-60;
   BOTTOMEDGE = SCREENHEIGHT-30;  // Bottom WINBOTTOM

   MAPDIR             = '\Map\'; //地图文件所在目录
   CONFIGFILE         = 'Config\%s.ini';
   SDOCONFIGFILE      = 'Config\Ly%s_%s\%s.ini';
   ITEMFILTER = 'Config\Ly%s_%s\ItemFilter.dat';
   MAINIMAGEFILE      = 'Data\Prguse.wil';
   MAINIMAGEFILE1     = 'Data\Prguse.wis';

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
   HUMWINGIMAGESFILE4  = 'Data\HumEffect4.wil';

   CBOHUMWINGIMAGESFILE  = 'Data\cboHumEffect.wis';
   CBOHUMWINGIMAGESFILE2  = 'Data\cboHumEffect2.wil';
   CBOHUMWINGIMAGESFILE3  = 'Data\cboHumEffect3.wil';
   CBOHUMWINGIMAGESFILE4  = 'Data\cboHumEffect4.wil';//By TasNat at: 2012-10-14 17:20:00

   MAGICONIMAGESFILE  = 'Data\MagIcon.wil';
   MAGICONIMAGESFILE2  = 'Data\MagIcon2.wil';


   CBOHUMIMGIMAGESFILE= 'Data\cbohum.wis';
   CBOHUMIMGIMAGESFILE3= 'Data\cbohum3.wis';
   CBOHUMIMGIMAGESFILE4= 'Data\cbohum4.wis';

   HUMIMGIMAGESFILE   = 'Data\Hum.wil';
   HUM2IMGIMAGESFILE  = 'Data\Hum2.wil'; //20080501
   HUM3IMGIMAGESFILE  = 'Data\Hum3.wil';
   HUM4IMGIMAGESFILE  = 'Data\Hum4.wil';


   HAIRIMGIMAGESFILE  = 'Data\Hair2.wil';
   CBOHAIRIMAGESFILE  = 'Data\cbohair.wis';
   WEAPONIMAGESFILE   = 'Data\Weapon.wil';
   CBOWEAPONIMAGESFILE = 'Data\cboweapon.wis';
   CBOWEAPONIMAGESFILE3 = 'Data\cboweapon3.wil';
   CBOWEAPONIMAGESFILE4 = 'Data\cboweapon4.wil';

   WEAPON2IMAGESFILE  = 'Data\Weapon2.wil'; //20080501
   WEAPON2IMAGESFILE1 = 'Data\Weapon2.wis';
   WEAPON3IMAGESFILE  = 'Data\Weapon3.wil';

   WEAPON4IMAGESFILE  = 'Data\Weapon4.wil';

   NPCIMAGESFILE      = 'Data\Npc.wil';
   NPC2IMAGESFILE     = 'Data\Npc2.wil';
   MAGICIMAGESFILE    = 'Data\Magic.wil';
   MAGIC2IMAGESFILE   = 'Data\Magic2.wil';
   MAGIC3IMAGESFILE   = 'Data\Magic3.wil';
   MAGIC4IMAGESFILE   = 'Data\Magic4.wil';
   MAGIC5IMAGESFILE   = 'Data\Magic5.wil';
   MAGIC6IMAGESFILE   = 'Data\Magic6.wil';
   MAGIC7IMAGESFILE   = 'Data\Magic7.wil';
   MAGIC7IMAGESFILE16 = 'Data\Magic7-16.wil';
   MAGIC8IMAGESFILE   = 'Data\Magic8.wil';
   MAGIC8IMAGESFILE16 = 'Data\Magic8-16.wil';
   MAGIC9IMAGESFILE    = 'Data\Magic9.wil';
   MAGIC10IMAGESFILE   = 'Data\Magic10.wil';
   CBOEFFECTIMAGESFILE= 'Data\cboEffect.wis';
   qingqingFILE       = 'Data\Qk_Prguse.wil';

   chantkkFILE        = 'Data\Qk_Prguse16.wil';

   UI1IMAGESFILE      = 'Data\Ui1.wil';
   UI3IMAGESFILE      = 'Data\Ui3.wil';
   STATEEFFECTFILE    = 'Data\StateEffect.wil';


   BAGITEMIMAGESFILE   = 'Data\Items.wil';
   BAGITEMIMAGESFILE1  = 'Data\Items.wis';
   BAGITEMIMAGESFILE2   = 'Data\Items2.wil';
   STATEITEMIMAGESFILE = 'Data\StateItem.wil';

   STATEITEMIMAGESFILE1 = 'Data\StateItem.wis';
   STATEITEMIMAGESFILE2 = 'Data\StateItem2.wil';


   DNITEMIMAGESFILE    = 'Data\DnItems.wil';
   DNITEMIMAGESFILE1   = 'Data\DnItems.wis';
   DNITEMIMAGESFILE2    = 'Data\DnItems2.wil';

   OBJECTIMAGEFILE     = 'Data\Objects.wil';
   OBJECTIMAGEFILE1    = 'Data\Objects%d.wil';
   MONIMAGEFILE        = 'Data\Mon%d.wil';
   MONKULOUIMAGEFILE   = 'Data\Mon-kulou.wil';
   DRAGONIMAGEFILE     = 'Data\Dragon.wil';
   EFFECTIMAGEFILE     = 'Data\Effect.wil';
   DRAGONIMGESFILE     = 'Data\Dragon.wil';
   WEAPONEFFECTFILE    = 'Data\WeaponEffect.wil';
   WEAPONEFFECTFILE4    = 'Data\WeaponEffect4.wil';
   CBOWEAPONEFFECTIMAGESFILE4    = 'Data\CboWeaponEffect4.wil';

   {
   MAXX = 40;
   MAXY = 40;
   }
  MAXX = SCREENWIDTH div 20;
  MAXY = SCREENWIDTH div 20;

  DEFAULTCURSOR = 0; //系统默认光标
  IMAGECURSOR   = 1; //图形光标

  USECURSOR     = DEFAULTCURSOR; //使用什么类型的光标

  MAXBAGITEMCL = 52;
  ENEMYCOLOR = 69;

const
  BuildData = '版本号：2012.12.18';
  {$IF M2Version = 0}
  g_sVersion = '合击' + BuildData;
  {$ELSEIF M2Version = 2}
  g_sVersion = '1.76' + BuildData;
  {$ELSE}
  g_sVersion = '连击' + BuildData;
  {$IFEND}
implementation

end.
