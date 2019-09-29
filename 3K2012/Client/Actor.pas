unit Actor;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms,
  Grobal2, DxDraws, CliUtil, magiceff, Wil, SDK, ClFunc, Share;

const
   HUMANFRAME = 600; //hum.wil,,,一种Race所占的图片数
   HUMANFRAME2 = 1200; //HUMANFRAME * 2
   NEWHUMANFRAME = 2000; //cbohum.wis ,一种Race所占的图片数
   NEWHUMANFRAME2 = 4000; //NEWHUMANFRAME * 2
   MAXSAY = 5;
   RUN_MINHEALTH = 10;//低于这个血量只能走动
   DEFSPELLFRAME = 10; //魔法最大浈
   CBODEFSPELLFRAME = 13;//连击魔法最大浈
   MAGBUBBLEBASE = 3890;    //魔法盾效果图位置
   MAGBUBBLESTRUCKBASE = 3900; //被攻击时魔法盾效果图位置
   MAXWPEFFECTFRAME = 5;
   WPEFFECTBASE = 3750;
   
type
//动作定义
  TActionInfo = packed record
    start   :Word;//0x14              // 开始帧
    frame   :Word;//0x16              // 帧数
    skip    :Word;//0x18              // 跳过的帧数
    ftime   :Word;//0x1A              // 每帧的延迟时间（毫秒）
    usetick :Word;//0x1C              // 荤侩平, 捞悼 悼累俊父 荤侩凳
  end;
  pTActionInfo = ^TActionInfo;

//玩家的动作定义
  THumanAction = packed record
    ActStand:      TActionInfo;   //1
    ActWalk:       TActionInfo;   //8
    ActRun:        TActionInfo;   //8
    ActRushLeft:   TActionInfo;
    ActRushRight:  TActionInfo;
    ActWarMode:    TActionInfo;   //1
    ActHit:        TActionInfo;   //6
    ActHeavyHit:   TActionInfo;   //6
    ActBigHit:     TActionInfo;   //6
    ActFireHitReady: TActionInfo; //6
    ActSpell:      TActionInfo;   //6
    ActSitdown:    TActionInfo;   //1
    ActStruck:     TActionInfo;   //3
    ActDie:        TActionInfo;   //4
    ActCboSpell1:  TActionInfo; //双龙破
    ActCboSpell2:  TActionInfo; //惊雷爆  
    ActCboSpell3:  TActionInfo; //冰天雪地
    ActCboSpell4:  TActionInfo; //三焰咒
    ActCboSpell5:  TActionInfo; //八卦掌
    ActCboSpell6:  TActionInfo; //凤舞祭
    ActCboSpell7:  TActionInfo; //虎啸诀
    ActCboSpell8:  TActionInfo; //万剑归宗
    ActCboSpell9:  TActionInfo; //追心刺
    ActCboSpell10: TActionInfo; //横扫千军
    ActCboSpell11: TActionInfo; //三绝杀
    ActCboSpell12: TActionInfo;//断岳斩
    ActCboSpell13: TActionInfo;//倚天辟地
    ActCboSpell14: TActionInfo;//血魄一击(法)
  end;
  pTHumanAction = ^THumanAction;
  TMonsterAction = packed record
    ActStand:      TActionInfo;   //1
    ActWalk:       TActionInfo;   //8
    ActAttack:     TActionInfo;   //6 0x14 - 0x1C
    ActCritical:   TActionInfo;   //6 0x20 -
    ActStruck:     TActionInfo;   //3
    ActDie:        TActionInfo;   //4
    ActDeath:      TActionInfo;
  end;
  pTMonsterAction = ^TMonsterAction;
  {$IF M2Version <> 2}
  TMoveHMShow = packed record
    sMoveHpstr    :string;
    nMoveHpEnd     :Integer;
    boMoveHpShow   :Boolean;
    dwMoveHpTick   :LongWord;
  end;
  pTMoveHMShow= ^TMoveHMShow;
  {$IFEND}
const
   //人类动作定义
   //每个人物每个级别每个性别共600幅图
   //设级别=L，性别=S，则开始帧=L*600+600*S

   //Start:该动作在这组外观下的开始帧
   //frame:该动作需要的帧数
   //skip:跳过的帧数
   HA: THumanAction = (//开始帧       有效帧     跳过帧    每帧延迟
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 90;   usetick: 2);
        ActRun:    (start: 128;    frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActRushLeft: (start: 128;    frame: 3;  skip: 5;  ftime: 120;  usetick: 3);
        ActRushRight:(start: 131;    frame: 3;  skip: 5;  ftime: 120;  usetick: 3);
        ActWarMode:(start: 192;    frame: 1;  skip: 0;  ftime: 200;  usetick: 0);
        //ActHit:    (start: 200;    frame: 5;  skip: 3;  ftime: 140;  usetick: 0);
        ActHit:    (start: 200;    frame: 6;  skip: 2;  ftime: 85;   usetick: 0);
        ActHeavyHit:(start: 264;   frame: 6;  skip: 2;  ftime: 90;   usetick: 0);
        ActBigHit: (start: 328;    frame: 8;  skip: 0;  ftime: 70;   usetick: 0);
        ActFireHitReady: (start: 192; frame: 6;  skip: 4;  ftime: 70;   usetick: 0);
        ActSpell:  (start: 392;    frame: 6;  skip: 2;  ftime: {46}60;   usetick: 0);
        ActSitdown:(start: 456;    frame: 2;  skip: 0;  ftime: 300;  usetick: 0);
        ActStruck: (start: 472;    frame: 3;  skip: 5;  ftime: 70;  usetick: 0);
        ActDie:    (start: 536;    frame: 4;  skip: 4;  ftime: 120;  usetick: 0);
        ActCboSpell1:(start: 1040; frame: 13;  skip: 7;  ftime: 60;   usetick: 0);//双龙破
        ActCboSpell2:(start: 1360; frame: 9;  skip: 1;  ftime: 85;   usetick: 0); //惊雷爆
        ActCboSpell3:(start: 800; frame: 8;  skip: 2;  ftime: 80;   usetick: 0); //冰天雪地
        ActCboSpell4:(start: 1600; frame: 12;  skip: 8;  ftime: 85;   usetick: 0); //三焰咒
        ActCboSpell5:(start: 1440; frame: 12;  skip: 8;  ftime: 60;   usetick: 0); //八卦掌
        ActCboSpell6:(start: 640; frame: 6;  skip: 4;  ftime: 80;   usetick: 0); //凤舞祭
        ActCboSpell7:(start: 1200; frame: 6;  skip: 4;  ftime: 80;   usetick: 0); //虎啸诀
        ActCboSpell8:(start: 1760; frame: 14;  skip: 6;  ftime: 65;   usetick: 0); //万剑归宗
        ActCboSpell9:(start: 80; frame: 8;  skip: 2;  ftime: 85;   usetick: 0); //追心刺
        ActCboSpell10:(start: 560; frame: 10;  skip: 0;  ftime: 85;   usetick: 0); //横扫千军
        ActCboSpell11:(start: 160; frame: 15;  skip: 5;  ftime: 60;   usetick: 0);//三绝杀
        ActCboSpell12:(start: 320; frame: 5;  skip: 5;  ftime: 60;   usetick: 0);//断岳斩
        ActCboSpell13:(start: 401; frame: 12;  skip: 8;  ftime: 80;   usetick: 0);//倚天辟地
        ActCboSpell14:(start: 720; frame: 6;  skip: 4;  ftime: 80;   usetick: 0);//血魄一击(法)
      );
  MA9: TMonsterAction = (//4C03D4
    ActStand:(Start:0;  frame:1;  skip:7;  ftime:200;  usetick:0);
    ActWalk:(Start:64;  frame:6;  skip:2;  ftime:120;  usetick:3);
    ActAttack:(Start:64;  frame:6;  skip:2;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:64;  frame:6;  skip:2;  ftime:100;  usetick:0);
    ActDie:(Start:0;  frame:1;  skip:7;  ftime:140;  usetick:0);
    ActDeath:(Start:0;  frame:1;  skip:7;  ftime:0;  usetick:0);
    );
   MA10: TMonsterAction = (  //(8Frame) 带刀卫士
           //每个动作8帧    //从这里可以推测出怪物有几种？//这里是280的
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 4;  skip: 4;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA11: TMonsterAction = (  //荤娇(10Frame楼府)  //每个动作10帧 //280,(360的),440,430,,
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 120;  usetick: 3);
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA12: TMonsterAction = (  //版厚捍, 锭府绰 加档 狐福促.//每个动作8帧，每个动作8个方向，共7种动作 (280),360,440,430,,
        ActStand:  (start: 0;      frame: 4;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 64;     frame: 6;  skip: 2;  ftime: 120;  usetick: 3);
        ActAttack: (start: 128;    frame: 6;  skip: 2;  ftime: 150;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 192;    frame: 2;  skip: 0;  ftime: 150;  usetick: 0);
        ActDie:    (start: 208;    frame: 4;  skip: 4;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 272;    frame: 1;  skip: 0;  ftime: 0;    usetick: 0);
      );
   MA13: TMonsterAction = (  //   mon2.wil中的食人花
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        //打开mon2.wil可以看到食人花,actstand是食人花站立状态
        ActWalk:   (start: 10;     frame: 8;  skip: 2;  ftime: 160;  usetick: 0); 
        //actwalk实际上是食人花站出来或消隐的效果注意到花尾的泥土实际一些objects.wil里面也有泥土tiles
         //石墓尸王钻出来时的地图效果，，食人花的效果跟暗龙相似，不知道暗龙的动作类型是不是也属于ma13
        ActAttack: (start: 30;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        //actattack从30开始是从各个方位攻击的效果
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        //actcritical这个动作略去
        ActStruck: (start: 110;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        //受伤110开始，，
        ActDie:    (start: 130;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        //130开始死亡效果
        ActDeath:  (start: 20;     frame: 9;  skip: 0;  ftime: 150;  usetick: 0);
        //20开始是食人花消隐的效果也是它死亡效果所以在这重用，，只有9帧最后一帧略去
      );
   MA14: TMonsterAction = (  //秦榜 坷付 mon3里面的骷髅战士,,分析方法同ma13
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 100;  usetick: 0); //归榜牢版快(家券)
      );
   MA15: TMonsterAction = (  //沃玛战土??新问题：源程序中对怪物的分类逻辑是不是就是mon*.wil的分类逻辑
        //又注意到沃玛战士的五器没有,它带的可是海魂，，难道它也跟hum.wil一样要跟weapon.wil挂钩才能钩成完整的形象?
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        //die跟death有什么区别啊???一个是死亡开始，，一个是在地面上的残骸??但是按这样说下面的逻辑不对啊!!
        ActDeath:  (start: 1;      frame: 1;  skip: 0;  ftime: 100;  usetick: 0);
      );
   MA16: TMonsterAction = (  //啊胶筋绰 备单扁  mon5里面的电僵尸？？代表可移动的魔法攻击动作的怪物一类??
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 4;  skip: 6;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 1;  skip: 0;  ftime: 160;  usetick: 0);
      );
   MA17: TMonsterAction = (  //官迭波府绰 各  mon6中的和尚僵王（和石墓尸王共用一形象）
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 60;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA19: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
   MA20: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActDeath:  (start: 340;    frame: 10; skip: 0;  ftime: 170;  usetick: 0);
      );
   MA21: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActAttack: (start: 10;     frame: 6;  skip: 4;  ftime: 120;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 20;     frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 30;     frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0); 
      );
   MA22: TMonsterAction = (
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); 
        ActAttack: (start: 240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 6;  skip: 4;  ftime: 170;  usetick: 0);
      );
   MA23: TMonsterAction = (
        ActStand:  (start: 20;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 100;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 180;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0); //
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 260;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 280;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
        ActDeath:  (start: 0;      frame: 20; skip: 0;  ftime: 100;  usetick: 0);
      );
   MA24: TMonsterAction = (  // (攻击) mon14中的蝎蛇??通过以下的分析好像又不是?
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start:240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 420;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
  MA25: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:70;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:20;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:50;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:60;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:80;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );

   MA26: TMonsterAction = (  
        ActStand:  (start: 0;      frame: 1;  skip: 7;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 160;  usetick: 0);
        ActAttack: (start: 56;     frame: 6;  skip: 2;  ftime: 500;  usetick: 0);
        ActCritical:(start: 64;    frame: 6;  skip: 2;  ftime: 500;  usetick: 0);
        ActStruck: (start: 0;      frame: 4;  skip: 4;  ftime: 100;  usetick: 0);
        ActDie:    (start: 24;     frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 150;  usetick: 0);
      );
   MA27: TMonsterAction = (
        ActStand:  (start: 0;     frame: 1;  skip: 7;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 0;     frame: 0;  skip: 0;  ftime: 160;  usetick: 0);
        ActAttack: (start: 0;     frame: 0;  skip: 0;  ftime: 250;  usetick: 0);
        ActCritical:(start: 0;    frame: 0;  skip: 0;  ftime: 250;  usetick: 0);
        ActStruck: (start: 0;     frame: 0;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 0;     frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;     frame: 0;  skip: 0;  ftime: 150;  usetick: 0);
      );
   MA28: TMonsterAction = (
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
        ActAttack: (start:  0;     frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start:  0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0);
      );
   MA29: TMonsterAction = (
        ActStand:  (start: 80;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
        ActAttack: (start: 240;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0);
        ActStruck: (start: 320;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 340;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start:  0;     frame: 10; skip: 0;  ftime: 100;  usetick: 0);
      );
  MA30: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:20;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:30;  frame:20;  skip:0;  ftime:150;  usetick:0);
    ActDeath:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );
  MA31: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:0;  frame:2;  skip:8;  ftime:100;  usetick:0);
    ActDie:(Start:20;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:0;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );
  MA32: TMonsterAction = (
    ActStand:(Start:0;  frame:1;  skip:9;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:0;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:0;  frame:2;  skip:8;  ftime:100;  usetick:0);
    ActDie:(Start:80;  frame:10;  skip:0;  ftime:80;  usetick:0);
    ActDeath:(Start:80;  frame:10;  skip:0;  ftime:200;  usetick:3);
    );
  MA33: TMonsterAction = (
             //开始帧    有效帧    跳过帧   每帧延迟
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    //actstand是站立状态
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    //actattack从30开始是从各个方位攻击的效果
    ActCritical:(Start:340;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:260;  frame:10;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:260;  frame:10;  skip:0;  ftime:200;  usetick:0);
    );
  MA34: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActCritical:(Start:320;  frame:6;  skip:4;  ftime:120;  usetick:0);
    ActStruck:(Start:400;  frame:2;  skip:0;  ftime:100;  usetick:0);
    ActDie:(Start:420;  frame:20;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:420;  frame:20;  skip:0;  ftime:200;  usetick:0);
    );
  MA35: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:10;  skip:0;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA36: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:20;  skip:0;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA37: TMonsterAction = (
    ActStand:(Start:30;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:30;  frame:4;  skip:6;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA38: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:80;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA39: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:300;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:10;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:20;  frame:2;  skip:0;  ftime:150;  usetick:0);
    ActDie:(Start:30;  frame:10;  skip:0;  ftime:80;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA40: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:250;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:210;  usetick:3);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:110;  usetick:0);
    ActCritical:(Start:580;  frame:20;  skip:0;  ftime:135;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:120;  usetick:0);
    ActDie:(Start:260;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActDeath:(Start:260;  frame:20;  skip:0;  ftime:130;  usetick:0);
    );
  MA41: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA42: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:10;  frame:8;  skip:2;  ftime:160;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:30;  frame:10;  skip:0;  ftime:120;  usetick:0);
    ActDeath:(Start:30;  frame:10;  skip:0;  ftime:150;  usetick:0);
    );
  MA43: TMonsterAction = (
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActAttack:(Start:160;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActCritical:(Start:160;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:150;  usetick:0);
    ActDie:(Start:260;  frame:10;  skip:0;  ftime:120;  usetick:0);
    ActDeath:(Start:340;  frame:10;  skip:0;  ftime:100;  usetick:0);
    );
  MA44: TMonsterAction = (
    ActStand:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActWalk:(Start:10;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActAttack:(Start:20;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActCritical:(Start:40;  frame:10;  skip:0;  ftime:150;  usetick:0);
    ActStruck:(Start:40;  frame:2;  skip:8;  ftime:150;  usetick:0);
    ActDie:(Start:{30}0;  frame:6;  skip:4;  ftime:150;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA45: TMonsterAction = (
    ActStand:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActWalk:(Start:0;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActAttack:(Start:10;  frame:10;  skip:0;  ftime:300;  usetick:0);
    ActCritical:(Start:10;  frame:10;  skip:0;  ftime:100;  usetick:0);
    ActStruck:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    ActDie:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    ActDeath:(Start:0;  frame:1;  skip:9;  ftime:300;  usetick:0);
    );
  MA46: TMonsterAction = (
    ActStand:(Start:0;  frame:20;  skip:0;  ftime:100;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA47: TMonsterAction = (//火灵
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:80;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:160;  frame:4;  skip:6;  ftime:160;  usetick:0);
    ActCritical:(Start:160;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActStruck:(Start:240;  frame:2;  skip:0;  ftime:100;  usetick:0);//受攻击
    ActDie:(Start:260;  frame:6;  skip:4;  ftime:130;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA48: TMonsterAction = (  //朱火弹
        ActStand:  (start: 0;      frame: 1;  skip: 0;  ftime: 0;  usetick: 0);
        ActWalk:   (start: 1;      frame: 6;  skip: 0;  ftime: 160;  usetick: 3);
        ActAttack: (start: 11;    frame: 10;  skip: 0;  ftime: 160;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 28;    frame: 6;  skip: 0;  ftime: 160;  usetick: 0);  //变大变小
        ActDie:    (start: 40;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;    frame: 0; skip: 0;  ftime: 0;  usetick: 0);
      );
  MA49: TMonsterAction = (
    ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
    ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
    ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
    ActCritical:(start: 340;   frame: 6;  skip: 4;  ftime: 160;  usetick: 0);
    ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
    ActDie:    (start: 260;    frame: 10;  skip: 0;  ftime: 160;  usetick: 0);
    ActDeath:  (start: 420;   frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
    );
  MA50: TMonsterAction = ( //雪域
    ActStand:  (start: 0;      frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActWalk:   (start: 0;     frame: 10;  skip: 0;  ftime: 60;  usetick: 3);
    ActAttack: (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActCritical:(start: 0;   frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActStruck: (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActDie:    (start: 0;    frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    ActDeath:  (start: 0;   frame: 10;  skip: 0;  ftime: 60;  usetick: 0);
    );
  MA51: TMonsterAction = ( //雪域
    ActStand:  (start: 0;      frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActWalk:   (start: 0;     frame: 1;  skip: 0;  ftime: 60;  usetick: 3);
    ActAttack: (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActCritical:(start: 0;   frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActStruck: (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActDie:    (start: 0;    frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    ActDeath:  (start: 0;   frame: 1;  skip: 0;  ftime: 60;  usetick: 0);
    );
  MA70: TMonsterAction = (//卧龙笔记NPC
    ActStand:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActAttack:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActCritical:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActStruck:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActDie:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    ActDeath:(Start:0;  frame:4;  skip:0;  ftime:200;  usetick:0);
    );
  MA71: TMonsterAction = (//酒馆3个人物NPC 20080308
    ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActAttack:(Start:10;  frame:19;  skip:0;  ftime:200;  usetick:0);
    ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActStruck:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
    );
  MA72: TMonsterAction = (//圣诞树NPC
    ActStand:(Start:0;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActWalk:(Start:0;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActAttack:(Start:0;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActCritical:(Start:0;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActStruck:(Start:0;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActDie:(Start:0;  frame:20;  skip:0;  ftime:130;  usetick:0);
    ActDeath:(Start:0;  frame:20;  skip:0;  ftime:130;  usetick:0);
    );
  MA93: TMonsterAction = ( //雷炎蛛王 200808012
      ActStand:  (start: 0;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
      ActWalk:   (start: 80;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
      ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
      ActCritical:(start: 340;     frame: 10;  skip: 0;  ftime: 160;    usetick: 0);
      ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
      ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
      ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
    );
  MA94: TMonsterAction = ( //雪域寒冰魔、雪域灭天魔、雪域五毒魔
      ActStand:  (start: 0;     frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
      ActWalk:   (start: 80;    frame: 6;  skip: 4;  ftime: 160;  usetick: 3);
      ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
      ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
      ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
      ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 160;  usetick: 0);
      ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
    );
  MA95: TMonsterAction = ( //火龙守护兽
      ActStand:  (start: 3;     frame: 1;  skip: 0;  ftime: 0;  usetick: 0);
      ActWalk:   (start: 0;    frame: 0; skip: 0;  ftime: 0;  usetick: 3);
      ActAttack: (start: 8;    frame: 10;  skip: 2;  ftime: 160;  usetick: 0);
      ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
      ActStruck: (start: 0;    frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
      ActDie:    (start: 0;    frame: 0; skip: 0;  ftime: 0;  usetick: 0);
      ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
    );
  MA100: TMonsterAction = (//月灵
    ActStand:(Start:360;  frame:4;  skip:6;  ftime:200;  usetick:0);
    ActWalk:(Start:440;  frame:6;  skip:4;  ftime:200;  usetick:3);
    ActAttack:(Start:520;  frame:4;  skip:6;  ftime:160;  usetick:0);

    ActCritical:(Start:520;  frame:6;  skip:4;  ftime:160;  usetick:0);
    ActStruck:(Start:600;  frame:2;  skip:0;  ftime:100;  usetick:0);//受攻击
    ActDie:(Start:620;  frame:6;  skip:4;  ftime:130;  usetick:0);
    ActDeath:(Start:340;  frame:10;  skip:0;  ftime:100;  usetick:0);
    );
  MA101: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 340;    frame: 8;  skip: 2;  ftime: 140;  usetick: 0); //
      );
  MA102: TMonsterAction = (  //雪域侍卫
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 340;     frame: 6;  skip: 4;  ftime: 100;    usetick: 0);  //特殊效果
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 9;  skip: 1;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;    frame: 0; skip: 0;  ftime: 0;  usetick: 0); //归榜牢版快(家券)
      );
  MA103: TMonsterAction = (  //雪域魔王
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 340;    frame: 8; skip: 2;  ftime: 100;  usetick: 0); //归榜牢版快(家券)
      );
  MA104: TMonsterAction = (  //雪域卫士
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 340;     frame: 6;  skip: 4;  ftime: 100;    usetick: 0);  //特殊效果
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 820;    frame: 10; skip: 0;  ftime: 100;  usetick: 0); //归榜牢版快(家券)
      );
  MA105: TMonsterAction = (  //雪域天将
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 420;     frame: 7;  skip: 3;  ftime: 100;    usetick: 0);  //特殊效果
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;    frame: 0; skip: 0;  ftime: 0;  usetick: 0); //归榜牢版快(家券)
      );
  MA106: TMonsterAction = (  //狐月之眼
        ActStand:  (start: 0;      frame: 1;  skip: 0;  ftime: 0;  usetick: 0);
        ActWalk:   (start: 1;      frame: 6;  skip: 0;  ftime: 160;  usetick: 3);
        ActAttack: (start: 20;    frame: 10;  skip: 0;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 30;    frame: 4;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 40;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;    frame: 0; skip: 0;  ftime: 0;  usetick: 0);
      );
  MA107: TMonsterAction = (  //九尾魂石
        ActStand:  (start: 70;      frame: 4;  skip: 0;  ftime: 0;  usetick: 0);
        ActWalk:   (start: 0;      frame: 0;  skip: 0;  ftime: 0;  usetick: 3);
        ActAttack: (start: 0;    frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 0;    frame: 0;  skip: 0;  ftime: 0;  usetick: 0);
        ActDie:    (start: 40;    frame: 10; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;    frame: 0; skip: 0;  ftime: 0;  usetick: 0);
      );
  MA108: TMonsterAction = (  //狐月天珠
        ActStand:  (start: 0;      frame: 1;  skip: 0;  ftime: 0;  usetick: 0);
        ActWalk:   (start: 1;      frame: 6;  skip: 0;  ftime: 160;  usetick: 3);
        ActAttack: (start: 20;    frame: 10;  skip: 0;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 30;    frame: 4;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 400;    frame: 18; skip: 0;  ftime: 120;  usetick: 0);
        ActDeath:  (start: 0;    frame: 0; skip: 0;  ftime: 0;  usetick: 0);
      );
  MA109: TMonsterAction = (  //兔财神
        ActStand:(Start:0;  frame:4;  skip:6;  ftime:200;  usetick:0);
        ActWalk:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
        ActAttack:(Start:30;  frame:23;  skip:0;  ftime:150;  usetick:0);
        ActCritical:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
        ActStruck:(Start:0;  frame:1;  skip:9;  ftime:0;  usetick:0);
        ActDie:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
        ActDeath:(Start:0;  frame:0;  skip:0;  ftime:0;  usetick:0);
        );
  MA110: TMonsterAction = (  //老虎
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 340;   frame: 6;  skip: 4;  ftime: 100;  usetick: 0); //特殊攻击
        ActStruck: (start: 240;    frame: 2;  skip: 0;  ftime: 100;  usetick: 0); //受攻击
        ActDie:    (start: 260;    frame: 10; skip: 0;  ftime: 140;  usetick: 0); //死亡
        ActDeath:  (start: 0;      frame: 0;  skip: 0;  ftime: 0;    usetick: 0); //
        );
  //叛军系列By TasNat at: 2012-10-18 11:05:39
  MA120: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 400;   frame: 10;  skip: 0;  ftime: 100;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 8;  ftime: 100;  usetick: 0);
        ActDie:    (start: 320;    frame: 10; skip: 0;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 329;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
  MA121: TMonsterAction = (
        ActStand:  (start: 0;      frame: 4;  skip: 6;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 6;  skip: 4;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 2;  skip: 8;  ftime: 100;  usetick: 0);
        ActDie:    (start: 320;    frame: 7; skip: 3;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 326;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );

  MA122: TMonsterAction = ( //熊猫
        ActStand:  (start: 0;      frame: 6;  skip: 4;  ftime: 200;  usetick: 0);
        ActWalk:   (start: 80;     frame: 6;  skip: 4;  ftime: 160;  usetick: 3); //
        ActAttack: (start: 160;    frame: 10;  skip: 0;  ftime: 100;  usetick: 0);
        ActCritical:(start: 0;     frame: 0;  skip: 0;  ftime: 0;    usetick: 0);
        ActStruck: (start: 240;    frame: 10;  skip: 0;  ftime: 100;  usetick: 0);
        ActDie:    (start: 320;    frame: 7; skip: 3;  ftime: 140;  usetick: 0);
        ActDeath:  (start: 326;    frame: 1;  skip: 0;  ftime: 140;  usetick: 0); //
      );
{------------------------------------------------------------------------------}
// 武器绘制顺序 (是否先于身体绘制: 0是/1否)
// WEAPONORDERS: array [Sex, FrameIndex] of Byte
{------------------------------------------------------------------------------}
   WORDER: Array[0..1, 0..599] of byte = (  //1: 女,  0: 男
                                            //第一维是性别，第二维是动作图片索引
      (       //男
      //站
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //走
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //跑
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war葛靛
      0,1,1,1,0,0,0,0,
      //击
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //击 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //击3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //付过
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //澵扁
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //嘎扁
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //静矾咙
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      ),

      (
      //沥瘤
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,1,1,1,1,
      0,0,0,0,1,1,1,1,    0,0,0,0,1,1,1,1,
      //叭扁
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,0,0,0,0,0,    0,0,0,0,0,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //顿扁
      0,0,0,0,0,0,0,0,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,1,1,1,1,1,1,    0,0,1,1,1,0,0,1,
      0,0,0,0,0,0,0,1,    0,0,0,0,0,0,0,1,
      //war葛靛
      1,1,1,1,0,0,0,0,
      //傍拜
      1,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,    1,1,1,0,0,0,0,0,
      1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,0,0,0,0,0,
      0,0,0,0,0,0,0,0,    1,1,1,1,0,0,1,1,
      //傍拜 2
      0,1,1,0,0,0,1,1,    0,1,1,0,0,0,1,1,    1,1,1,0,0,0,0,0,
      1,1,1,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,0,1,1,1,0,0,    0,1,1,1,1,0,1,1,
      //傍拜3
      1,1,0,1,0,0,0,0,    1,1,0,0,0,0,0,0,    1,1,1,1,1,0,0,0,
      1,1,0,0,1,0,0,0,    1,1,1,0,0,0,0,1,    0,1,1,0,0,0,0,0,
      0,0,0,0,1,1,1,0,    1,1,1,1,1,0,0,0,
      //付过
      0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,    0,0,0,0,0,0,1,1,
      1,0,0,0,0,1,1,1,    1,1,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,
      0,0,1,1,0,0,1,1,    0,0,0,1,0,0,1,1,
      //澵扁
      0,0,1,0,1,1,1,1,    1,1,0,0,0,1,0,0,
      //嘎扁
      0,0,0,1,1,1,1,1,    1,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      //静矾咙
      0,0,1,1,1,1,1,1,    0,1,1,1,1,1,1,1,    1,1,1,1,1,1,1,1,
      1,1,1,1,1,1,1,1,    0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1,
      0,0,0,1,1,1,1,1,    0,0,0,1,1,1,1,1
      )
   );


type

   TActor = class
     m_nRecogId                :Integer;    //角色标识 0x4
     m_nCurrX                  :Integer;    //当前所在地图座标X 0x08
     m_nCurrY                  :Integer;    //当前所在地图座标Y 0x0A
     m_btDir                   :Byte;       //当前站立方向 0x0C
     m_btSex                   :Byte;       //性别 0x0D
     m_btRace                  :Byte;       //0x0E
     m_btHair                  :Byte;       //头发类型 0x0F
     m_btDress                 :Byte;       //衣服类型 0x10
     m_btWeapon                :Byte;       //武器类型
     m_boMagicShield           :Boolean;    //护身戒指By TasNat at:2012-12-12 10:25:01
     //m_btHorse                 :Byte;       //马类型   20080721 注释骑马
     m_btEffect                :Byte;       //天使类型
     m_btJob                   :Byte;       //职业 0:武士  1:法师  2:道士
     m_wAppearance             :Word;       //0x14 DIV 10=种族（外貌）， Mod 10=外貌图片在图片库中的位置（第几种）
     m_nLoyal                  :Integer;    //英雄忠诚度
     m_nFeature                :TFeatures;    //0x18
     m_nFeatureEx              :Integer;    //0x18
     m_nState                  :Integer;    //0x1C
     m_boDeath                 :Boolean;    //0x20
     m_boSkeleton              :Boolean;    //0x21
     m_boDelActor              :Boolean;    //0x22
     m_boDelActionAfterFinished :Boolean;   //0x23
     m_sDescUserName           :String;     //人物名称，后缀
     m_sUserName               :String;     //名字
     m_nNameColor              :Integer;    //名字颜色
     m_btMiniMapHeroColor      :byte;       //英雄小地图名字颜色

     m_nGold                   :Integer;    //金币数量0x58
     m_nGameGold               :Integer;    //游戏币数量
     m_nGamePoint              :Integer;    //游戏点数量
     m_nGameDiaMond            :Integer;    //金刚石数量  2008.02.11
     m_nGameGird               :Integer;    //灵符数量  2008.02.11
     //m_nGameGlory              :Integer; //荣誉数量 20080511

     m_nHitSpeed               :ShortInt;   //攻击速度 0: 扁夯, (-)蠢覆 (+)狐抚
     m_boVisible               :Boolean;    //0x5D
     m_boHoldPlace             :Boolean;    //0x5E

     m_SayingArr               :array[0..MAXSAY-1] of String;  //最近说的话
     m_SayWidthsArr            :array[0..MAXSAY-1] of Integer; //每句话的宽度
     m_dwSayTime               :LongWord;
     m_nSayX                   :Integer;
     m_nSayY                   :Integer;
     m_nSayLineCount           :Integer;

     m_nShiftX                 :Integer;    //0x98
     m_nShiftY                 :Integer;    //0x9C

     //m_nLightX                 :Integer;  //月灵图片坐标 光 2007.12.12
     m_nPx                     :Integer;  //0xA0
     m_nHpx                    :Integer;  //0xA4
     m_nWpx                    :Integer;  //0xA8
     m_nEpx                    :Integer;
     m_nSpx                    :Integer;  //0xAC

     //m_nLightY                 :Integer;  //月灵图片坐标 光 2007.12.12
     m_nPy                     :Integer;
     m_nHpy                    :Integer;
     m_nWpy                    :Integer;
     m_nEpy                    :Integer;
     m_nSpy                    :Integer;  //0xB0 0xB4 0xB8 0xBC

     m_nRx                     :Integer;
     m_nRy                     :Integer;//0xC0 0xC4
     m_nDownDrawLevel          :Integer;    //0xC8
     m_nTargetX                :Integer;
     m_nTargetY                :Integer; //0xCC 0xD0
     m_nTargetRecog            :Integer;      //0xD4
     m_nHiterCode              :Integer;        //0xD8
     m_nMagicNum               :Integer;         //0xDC
     m_nCurrentEvent           :Integer; //辑滚狼 捞亥飘 酒捞叼
     m_boDigFragment           :Boolean; //挖矿效果
     //m_boThrow                 :Boolean;  20080803注释
     m_Abil                    :TAbility;   //基本属性
     m_nBodyOffset             :Integer;     //0x0E8   //0x0D0 // 身体图片索引的主偏移
     m_nHairOffset             :Integer;     //0x0EC           // 头发图片索引的主偏移
     m_nCboHairOffset          :Integer;     //0x0EC           // WIS头发图片索引的主偏移
     m_nHumWinOffset           :Integer;   //0x0F0
     m_nCboHumWinOffset        :Integer;   //0x0F0        // WIS翅膀图片索引的主偏移
     m_nWeaponOffset           :Integer;   //0x0F4             // 武器图片索引的主偏移
     m_nWeaponEffOffset        :Integer;
     m_nCboWeaponEffOffset     :Integer;
     m_boUseMagic              :Boolean;    //0x0F8   //0xE0
     m_boHitEffect             :Boolean;   //0x0F9    //0xE1
     m_boUseEffect             :Boolean;   //0x0FA    //0xE2
     m_nHitEffectNumber        :Integer;              //0xE4
     m_dwWaitMagicRequest      :LongWord;
     m_nWaitForRecogId         :Integer;  //磊脚捞 荤扼瘤搁 WaitFor狼 actor甫 visible 矫挪促.
     m_nWaitForFeature         :TFeatures;
     m_nWaitForStatus          :Integer;
     m_nCurEffFrame            :Integer;       //0x110
     m_nSpellFrame             :Integer;        //0x114
     m_CurMagic                :TUseMagicInfo;    //0x118  //m_CurMagic.EffectNumber 0x110

     m_nGenAniCount            :Integer;                   //0x124
     m_boOpenHealth            :Boolean;        //0x140
     m_noInstanceOpenHealth    :Boolean;//0x141
     m_dwOpenHealthStart       :LongWord;
     m_dwOpenHealthTime        :LongWord;//Integer;jacky
      //SRc: TRect;  //Screen Rect 拳搁狼 角力谅钎(付快胶 扁霖)
     m_BodySurface             :TDirectDrawSurface;    //0x14C   //0x134
    // m_LightSurface             :TDirectDrawSurface;    //0x14C   //0x134
     m_boGrouped               :Boolean;    // 是否组队
     m_nCurrentAction          :Integer;    //0x154         //0x13C
     m_boReverseFrame          :Boolean;    //0x158
     m_boWarMode               :Boolean;    //0x159
     m_boCboMode               :Boolean;    //WIS格式 20090625
     m_dwWarModeTime           :LongWord;   //0x15C
     m_nChrLight               :Integer;    //0x160
     m_nMagLight               :Integer;    //0x164
     m_nRushDir                :Integer;  //0, 1
     //m_nXxI                    :Integer; //0x16C   20080521 注释没用到变量
     m_boLockEndFrame          :Boolean;
     m_dwLastStruckTime        :LongWord;
     m_dwSendQueryUserNameTime :LongWord;
     m_dwDeleteTime            :LongWord;

     m_nMagicStruckSound       :Integer;  //0x180 被魔法攻击弯腰发出的声音
     m_boRunSound              :Boolean;  //0x184 跑步发出的声音
     m_nFootStepSound          :Integer;  //CM_WALK, CM_RUN //0x188  走步声
     m_nStruckSound            :Integer;  //SM_STRUCK         //0x18C  弯腰声音
     m_nStruckWeaponSound      :Integer;                //0x190  被指定武器攻击弯腰声音

     m_nAppearSound            :Integer;  //殿厘家府 0    //0x194
     m_nNormalSound            :Integer;  //老馆家府 1    //0x198
     m_nAttackSound            :Integer;  //         2    //0x19C
     m_nWeaponSound            :Integer; //          3    //0x1A0
     m_nScreamSound            :Integer;  //         4    //0x1A4
     m_nDieSound               :Integer;     //磷阑锭   5 SM_DEATHNOW //0x1A8
     m_nDie2Sound              :Integer;                    //0x1AC

     m_nMagicStartSound        :Integer;     //0x1B0
     m_nMagicFireSound         :Integer;      //0x1B4
     m_nMagicExplosionSound    :Integer; //0x1B8
     m_Action                  :pTMonsterAction;
{******************************************************************************}
     //人自身显示动画 begin   2008.01.13
     m_nMyShowStartFrame        :Integer; //自身动画开始帧
     m_nMyShowExplosionFrame    :Integer; //自身动画往后播放的帧数
     m_nMyShowNextFrameTime     :LongWord; //自身动画时间间隔
     m_nMyShowTime              :LongWord; //当前时间
     m_nMyShowFrame             :Integer; //当前帧
     g_boIsMyShow               :Boolean; //是否显示动画{接到消息为True}
     g_MagicBase                :TWMImages; //图库
     m_boNoChangeIsMyShow       :Boolean; //是否发出的动画坐标不随着人物动作而变化  20080306
     m_nNoChangeX, m_nNoChangeY :Integer; //不改变动画的坐标X，Y  20080306
{******************************************************************************}
    m_Skill69NH: Integer;//当前内力值 20110226
    m_Skill69MaxNH: Integer;//最大内力值 20110226
    m_SayColor: Integer; //人物头顶说话 特殊颜色字
    m_dwKill79Time: LongWord;
    m_boIsShop: Boolean; //摆摊
    m_sShopMsg: string[28];
    {$IF M2Version <> 2}
    m_nMoveHpList: TList;
    {$IFEND}
    m_nMoveTimeStep: Word; //移动减速间隔
   private
     function GetMessage(ChrMsg:pTChrMsg):Boolean;
     function GetKill79Message(ChrMsg:pTChrMsg):Boolean;
     function GetEffectWil(idx: Byte): TWMImages;
   protected
     m_nStartFrame             :Integer;      //0x1BC        //0x1A8  // 当前动作的开始帧索引
     m_nEndFrame               :Integer;        //0x1C0      //0x1AC  // 当前动作的结束帧索引
     m_nCurrentFrame           :Integer;    //0x1C4          //0x1B0
     m_nEffectStart            :Integer;     //0x1C8         //0x1B4
     m_nEffectFrame            :Integer;     //0x1CC         //0x1B8
     m_nEffectEnd              :Integer;       //0x1D0       //0x1BC
     m_dwEffectStartTime       :LongWord;//0x1D4             //0x1C0
     m_dwEffectFrameTime       :LongWord;//0x1D8             //0x1C4
     m_dwFrameTime             :LongWord;      //0x1DC       //0x1C8
     m_dwStartTime             :LongWord;      //0x1E0       //0x1CC
     m_nMaxTick                :Integer;         //0x1E4
     m_nCurTick                :Integer;         //0x1E8
     m_nMoveStep               :Integer;        //0x1EC
     m_boMsgMuch               :Boolean;            //0x1F0
     m_dwStruckFrameTime       :LongWord;   //0x1F4
     m_nCurrentDefFrame        :Integer;    //0x1F8          //0x1E4
     m_dwDefFrameTime          :LongWord;      //0x1FC       //0x1E8
     m_nDefFrameCount          :Integer;      //0x200        //0x1EC
     //m_nSkipTick               :Integer;           //20080816注释掉起步负重
     m_dwSmoothMoveTime        :LongWord;    //0x208
     m_dwGenAnicountTime       :LongWord;   //0x20C
     m_dwLoadSurfaceTime       :LongWord;   //0x210  //0x200

     m_nOldx                   :Integer;
     m_nOldy                   :Integer;
     m_nOldDir                 :Integer; //0x214 0x218 0x21C
     m_nActBeforeX             :Integer;
     m_nActBeforeY             :Integer;  //0x220 0x224
     m_nWpord                  :Integer;                   //0x228

      procedure CalcActorFrame; dynamic;
      procedure DefaultMotion; dynamic;
      function  GetDefaultFrame (wmode: Boolean): integer; dynamic;
      procedure DrawEffSurface (dsurface, source: TDirectDrawSurface; ddx, ddy: integer; blend: Boolean; ceff: TColorEffect);
      procedure DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
   public
      m_MsgList: TGList;       //list of PTChrMsg 0x22C  //0x21C
      m_Kill79MsgList: TGList;  //追心刺改变坐标消息列表
      RealActionMsg: TChrMsg; //FrmMain    0x230
      constructor Create; dynamic;
      destructor Destroy; override;
      function FindMsg(wIdent: Word): Boolean;
      procedure  SendMsg (wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer; NewFeature: TFeatures);
      procedure  Kill79SendMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
      procedure  UpdateMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer; NewFeature: TFeatures);
      procedure  CleanUserMsgs;
      procedure  ProcMsg;
      procedure  ProcHurryMsg;
      function   IsIdle: Boolean;
      function   ActionFinished: Boolean;
      function   CanWalk: Integer;
      function   CanRun: Integer;
      procedure  Shift (dir, step, cur, max: integer);
      procedure  ReadyAction (msg: TChrMsg);
      function   CharWidth: Integer;
      function   CharHeight: Integer;
      function   CheckSelect (dx, dy: integer): Boolean;
      procedure  CleanCharMapSetting (x, y: integer);
      procedure  Say (str: string);
      procedure  SetSound; dynamic;
      procedure  Run; dynamic;
      procedure  RunSound; dynamic;
      procedure  RunActSound (frame: integer); dynamic;
      procedure  RunFrameAction (frame: integer); dynamic;  //橇贰烙付促 刀漂窍霸 秦具且老
      procedure  ActionEnded; dynamic;
      function   Move (step: integer): Boolean;
      procedure  MoveFail;
      function   CanCancelAction: Boolean;
      procedure  CancelAction;
      procedure  FeatureChanged; dynamic;
      function   Light: integer; dynamic;
      procedure  LoadSurface; dynamic;
      function   GetDrawEffectValue: TColorEffect;
      procedure  DrawMyShow(dsurface: TDirectDrawSurface;dx,dy:integer); //通用人自身动画显示 20080113
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); dynamic;
      procedure  DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); dynamic;
      procedure  DrawStall (dsurface: TDirectDrawSurface; dx, dy: integer); dynamic;   //画摊位
   end;

   TNpcActor = class (TActor)
   private
     m_nEffX      :Integer; //0x240
     m_nEffY      :Integer; //0x244
     m_bo248      :Boolean; //0x248
     m_dwUseEffectTick    :LongWord; //0x24C
     m_EffSurface       :TDirectDrawSurface; //画NPC 魔法动画效果

     m_boUseEffect1: Boolean;
     m_nEffX1      :Integer; //0x240
     m_nEffY1      :Integer; //0x244
     m_EffSurface1       :TDirectDrawSurface; //画NPC 魔法动画效果

     //酒馆2卷老板娘走动  20080621
     m_boNpcWalkEffect  :Boolean;  //是否走动中怪动画效果
     m_boNpcWalkEffectSurface :TDirectDrawSurface;
     m_nNpcWalkEffectPx :Integer;
     m_nNpcWalkEffectPy :Integer;
   public
     g_boNpcWalk  :Boolean; //NPC走动 20080621
     constructor Create; override;
     destructor Destroy; override;
     procedure  Run; override;
     procedure  CalcActorFrame; override;
     function   GetDefaultFrame (wmode: Boolean): integer; override;
     procedure  LoadSurface; override;
     procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
     procedure  DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;

   THumActor = class (TActor)//Size: 0x27C Address: 0x00475BB8
   private
     m_HairSurface         :TDirectDrawSurface; //0x250  //0x240  //头发外观 2007.10.21
     m_WeaponSurface       :TDirectDrawSurface; //0x254  //0x244  //武器外观 2007.10.21
     m_WeaponEffSurface    :TDirectDrawSurface;  ///武器发光
     m_HumWinSurface       :TDirectDrawSurface; //0x258  //0x248  //人物外观 2007.10.21
     m_boWeaponEffect      :Boolean;            //0x25C  //0x24C
     m_nCurWeaponEffect    :Integer;            //0x260  //0x250
     m_nCurBubbleStruck    :Integer;            //0x264  //0x254
     m_nCurProtEctionStruck :Integer;
     m_dwProtEctionStruckTime :Longword;

     m_dwWeaponpEffectTime :LongWord;           //0x268
     //m_boHideWeapon        :Boolean;            20080803注释
     m_nFrame              :Integer;
     m_dwFrameTick         :LongWord;
     m_dwFrameTime         :LongWord;
     m_Hit4Meff            :TMagicEff; //断岳效果
     m_boHit4              :Boolean;
     m_boHit41             :Boolean;
     m_HumEffSurface: TDirectDrawSurface;
     m_HumPx: Integer;
     m_HumPy: Integer;

     m_nEffFrame              :Integer;
     m_dwEffFrameTick         :LongWord;
     m_dwEffFrameTime         :LongWord;
   protected
      procedure CalcActorFrame; override;
      procedure DefaultMotion; override;
      function  GetDefaultFrame (wmode: Boolean): integer; override;
   public
      {$IF M2Version <> 2}
      m_wTitleIcon: Word;
      m_sTitleName: string;
      {$IFEND}
      //m_boMagbubble4  :Boolean; //是否是4级魔法盾状态
      constructor Create; override;
      destructor Destroy; override;
      procedure  Run; override;
      procedure  RunFrameAction (frame: integer); override;
      function   Light: integer; override;
      procedure  LoadSurface; override;
      procedure  DoWeaponBreakEffect;
      procedure  DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean); override;
      procedure  DrawStall (dsurface: TDirectDrawSurface; dx, dy: integer); override;
   end;

   function GetRaceByPM (race: integer;Appr:word): PTMonsterAction;
   function GetOffset (appr: integer): integer;
   function GetNpcOffset(nAppr:Integer):Integer;
implementation

uses
   ClMain, SoundUtil, clEvent, MShare;
constructor TActor.Create;
begin
  inherited Create;
  FillChar(m_Abil,Sizeof(TAbility), 0);
  FillChar(m_Action,SizeOf(m_Action),0);
  {$IF M2Version <> 2}
  m_nMoveHpList       := TList.Create;
  {$IFEND}
  m_MsgList           := TGList.Create;
  m_Kill79MsgList     := TGList.Create;
  m_nRecogId          := 0;
  m_BodySurface       := nil;
  m_nGold             := 0;
  m_boVisible         := TRUE;
  m_boHoldPlace       := TRUE;
  m_nCurrentAction    := 0;
  m_boReverseFrame    := FALSE;
  m_nShiftX           := 0;
  m_nShiftY           := 0;
  m_nDownDrawLevel    := 0;
  m_nCurrentFrame     := -1;
  m_nEffectFrame      := -1;

  RealActionMsg.Ident := 0;
  m_sUserName         := '';
  m_nNameColor        := clWhite;
  m_dwSendQueryUserNameTime  := 0; //GetTickCount;
  m_boWarMode                := FALSE;
  m_boCboMode                := False;
  m_dwWarModeTime            := 0;    //War mode
  m_boDeath                  := FALSE;
  m_boSkeleton               := FALSE;
  m_boDelActor               := FALSE;
  m_boDelActionAfterFinished := FALSE;

  m_nChrLight                := 0;
  m_nMagLight                := 0;
  m_boLockEndFrame           := FALSE;
  m_dwSmoothMoveTime         := 0; //GetTickCount;
  m_dwGenAnicountTime        := 0;
  m_dwDefFrameTime           := 0;
  m_dwLoadSurfaceTime        := GetTickCount;
  m_boGrouped                := FALSE;
  m_boOpenHealth             := FALSE;
  m_noInstanceOpenHealth     := FALSE;
  m_CurMagic.ServerMagicCode := 0;

  m_nSpellFrame              := DEFSPELLFRAME;

  m_nNormalSound             := -1;
  m_nFootStepSound           := -1; //绝澜  //林牢傍牢版快, CM_WALK, CM_RUN
  m_nAttackSound             := -1;
  m_nWeaponSound             := -1;
  m_nStruckSound             := s_struck_body_longstick;  //嘎阑锭 唱绰 家府    SM_STRUCK
  m_nStruckWeaponSound       := -1;
  m_nScreamSound             := -1;
  m_nDieSound                := -1;    //绝澜    //磷阑锭 唱绰 家府    SM_DEATHNOW
  m_nDie2Sound               := -1;

  m_nWeaponEffOffset        := 0;
  m_nCboWeaponEffOffset     := 0;

  m_Skill69NH:=0;//当前内力值 20080930
  m_Skill69MaxNH:=0;//最大内力值 20080930
  m_SayColor := 0; //人物头顶特殊颜色字
  m_boIsShop := False;
  m_nMoveTimeStep := 0;
end;


function GetRaceByPM (race: integer; Appr:word): pTMonsterAction;
begin
   Result := nil;
  case Race of
    9{01}: Result:=@MA9; //未知
    10{02}: Result:=@MA10; //未知
    11{03}: Result:=@MA11; //鸡和鹿
    12{04}: Result:=@MA12; //大刀卫士
    13{05}: Result:=@MA13; //食人花
    14{06}: Result:=@MA14; //骷髅系列怪
    15{07}: Result:=@MA15; //掷斧骷髅
    16{08}: Result:=@MA16; //洞蛆
    17{06}: Result:=@MA14; //多钩猫
    18{06}: Result:=@MA14; //稻草人
    19{0A}: Result:=@MA19; //半兽人、蛤蟆、毒蜘蛛之类的
    20{0A}: Result:=@MA19; //火焰沃玛
    21{0A}: Result:=@MA19; //沃玛教主
    22{07}: Result:=@MA15; //暗黑战士、暴牙蜘蛛
    23{06}: Result:=@MA14; //变异骷髅
    24{04}: Result:=@MA12; //带刀护卫
    30{09}: Result:=@MA17; //未知
    31{09}: Result:=@MA17; //蜜蜂
    32{0F}: Result:=@MA24; //蝎子
    33{10}: Result:=@MA25; //触龙神
    34{11}: Result:=@MA30; //赤月恶魔、宝箱、千年树妖
    35{12}: Result:=@MA31; //未知
    36{13}: Result:=@MA32; //475E48
    37{0A}: Result:=@MA19; //475DDC
    40{0A}: Result:=@MA19; //475DDC
    41{0B}: Result:=@MA20; //475DE8
    42{0B}: Result:=@MA20; //475DE8
    43{0C}: Result:=@MA21; //475DF4
    45{0A}: Result:=@MA19; //475DDC
    47{0D}: Result:=@MA22; //祖玛雕像
    48{0E}: Result:=@MA23; //475E0C
    49{0E}: Result:=@MA23; //祖玛教主
    50{27}: begin//NPC
      case Appr of
        23{01}: Result:=@MA36; //475F77
        24{02}: Result:=@MA37; //475F80
        25{02}: Result:=@MA37; //475F80
        26{00}: Result:=@MA35; //475F9B
        27{02}: Result:=@MA37; //475F80
        28{00}: Result:=@MA35; //475F9B
        29{00}: Result:=@MA35; //475F9B
        30{00}: Result:=@MA35; //475F9B
        31{00}: Result:=@MA35; //475F9B
        32{02}: Result:=@MA37; //475F80
        33{00}: Result:=@MA35; //475F9B
        34{00}: Result:=@MA35; //475F9B
        35{03}: Result:=@MA41; //475F89
        36{03}: Result:=@MA41; //475F89
        37{03}: Result:=@MA41; //475F89
        38{03}: Result:=@MA41; //475F89
        39{03}: Result:=@MA41; //475F89
        40{03}: Result:=@MA41; //475F89
        41{03}: Result:=@MA41; //475F89
        42{04}: Result:=@MA46; //475F92
        43{04}: Result:=@MA46; //475F92
        44{04}: Result:=@MA46; //475F92
        45{04}: Result:=@MA46; //475F92
        46{04}: Result:=@MA46; //475F92
        47{04}: Result:=@MA46; //475F92
        48{03}: Result:=@MA41; //4777B3
        49{03}: Result:=@MA41; //4777B3
        50{03}: Result:=@MA41; //4777B3
        51{00}: Result:=@MA35; //4777C5
        52{03}: Result:=@MA41; //4777B3
        53{03}: Result:=@MA35; //酒神弟子 20081024
        54..58: Result:=@MA50; //雪域
        59,64{03}: Result:=@MA51; //雪域 练气炉
        60,62: Result:=@MA70; //灯笼, 神秘宝藏  20080301
        63{03}: Result:=@MA41; //圣诞老人
        61{03}: Result:=@MA72; //圣诞树NPC
        65..66: Result:=@MA70;  //火龙宝箱  20080301
        70..75: Result:=@MA70;  //卧龙NPC
        90..93: Result:=@MA70; //卧龙里的空宝箱NPC,93为9周年宝箱
        82..84: Result:=@MA71; //酒馆3个人物NPC 20080308
        99..101: Result:=@MA37; //NPC2
        103: Result := @MA51; //世界杯
        107..112: Result := @MA51; //沙城新NPC
        113..118: Result := @MA51;
        else Result:=@MA35;
      end;
    end;

    52{0A}: Result:=@MA19; //475DDC
    53{0A}: Result:=@MA19; //475DDC
    54{14}: Result:=@MA28; //475E54
    55{15}: Result:=@MA29; //475E60
    60{16}: Result:=@MA33; //475E6C
    61{16}: Result:=@MA33; //475E6C
    62{16}: Result:=@MA33; //475E6C
    63{17}: Result:=@MA34; //475E78
    64{18}: Result:=@MA19; //475E84
    65{18}: Result:=@MA19; //475E84
    66{18}: Result:=@MA19; //475E84
    67{18}: Result:=@MA19; //475E84
    68{18}: Result:=@MA19; //475E84
    69{18}: Result:=@MA19; //475E84
    70{19}: Result:=@MA33; //475E90
    71{19}: Result:=@MA33; //475E90
    72{19}: Result:=@MA33; //475E90
    73{1A}: Result:=@MA19; //475E9C
    74{1B}: Result:=@MA19; //475EA8
    75{1C}: Result:=@MA39; //475EB4
    76{1D}: Result:=@MA38; //475EC0
    77{1E}: Result:=@MA39; //475ECC
    78{1F}: Result:=@MA40; //475ED8
    79{20}: Result:=@MA19; //475EE4
    80{21}: Result:=@MA42; //475EF0
    81{22}: Result:=@MA43; //475EFC
    83{23}: Result:=@MA44; //火龙教主  20080305
    84{24}: Result:=@MA45; //475F14
    85{24}: Result:=@MA45; //475F14
    86{24}: Result:=@MA45; //475F14
    87{24}: Result:=@MA45; //475F14
    88{24}: Result:=@MA45; //475F14
    89{24}: Result:=@MA45; //475F14
    90{11}: Result:=@MA30; //475E30
    98{25}: Result:=@MA27; //475F20
    99{26}: Result:=@MA26; //475F29
    91{27}: Result:=@MA49;
    92: Result := @MA19;   //金杖蜘蛛
    93: Result := @MA93;  //雷炎蛛王
    94: Result := @MA94;  //雪域寒冰魔、雪域灭天魔、雪域五毒魔
    95: Result := @MA95;  //火龙守护兽
    96: Result := @MA19;
    97: Result := @MA19;
    100{28}: Result:=@MA100;//月灵
    101: Result := @MA101;  //富贵兽
    102: Result:=@MA102; //雪域侍卫
    103: Result:=@MA14; //雪域力士
    104: Result:=@MA104; //雪域卫士
    105: Result:=@MA102; //雪域战将
    106: Result:=@MA105;  //雪域天将
    107: Result:=@MA103;  //雪域魔王
    108: Result:=@MA14;
    109: Result:=@MA14;
    110: Result:=@MA14;
    111: Result:=@MA106; //
    112: Result:=@MA107;
    113: Result:=@MA108;
    114: Result:=@MA47;
    115: Result:=@MA48;
    116: Result:=@MA14;
    117: Result:=@MA44;
    118: Result:=@MA19;
    119: Result:=@MA110; //老虎
    120,123: Result:=@MA120;
    121: Result:=@MA121;
    122: Result:=@MA122;
  end

end;

//根据种族和外貌确定在图片库中的开始位置
function GetOffset (appr: integer): integer;
var
  nrace, npos: integer;
begin
  Result := 0;
  if (appr > 9999) then Exit;
  
  if appr > 999 then begin
    nrace := appr div 100;         //图片库
    npos := appr mod 100;          //图片库中的形象序号
  end else begin
    nrace := appr div 10;         //图片库
    npos := appr mod 10;          //图片库中的形象序号
  end;
  case nrace of
    0:    Result := npos * 280;
    1:    Result := npos * 230;
    2,3,7..12:Result := npos * 360;
    4: begin
      Result := npos * 360;        //
      if npos = 1 then Result := 600;
    end;
    5: Result := npos * 430;   //
    6: Result := npos * 440;   //
//      13:   Result := npos * 360;
    13: begin
      case npos of
        0: Result:= 0;
        1: Result:= 360;
        2: Result:= 440;
        3: Result:= 550;
        else Result:= npos * 360;
      end;
    end;
    14: Result := npos * 360;
    15: Result := npos * 360;
    16: Result := npos * 360;
    17: case npos of
          2: Result := 920;
          else Result := npos * 350;
        end;
    18: case npos of  //20080508修改    魔龙系列怪
        { 0: Result := 0;   //己巩
          1: Result := 520;
          2: Result := 950;   }
          0: Result := 0;
          1: Result := 520;
          2: Result := 950;
          3: Result := 1574;
          4: Result := 1934;
          5: Result := 2294;
          6: Result := 2654;
          7: Result := 3014;
        end;
      19:   case npos of
               0: Result := 0;   //己巩
               1: Result := 370;
               2: Result := 810;
               3: Result := 1250;
               4: Result := 1630;
               5: Result := 2010;
               6: Result := 2390;
            end;
      20:   case npos of
               0: Result := 0;   //己巩
               1: Result := 360;
               2: Result := 720;
               3: Result := 1080;
               4: Result := 1440;
               5: Result := 1800;
               6: Result := 2350;
               7: Result := 3060;
            end;
      21:   case npos of
               0: Result := 0;   //己巩
               1: Result := 460;
               2: Result := 820;
               3: Result := 1180;
               4: Result := 1540;
               5: Result := 1900;
//               6: Result := 2260;
               6: Result := 2440;
               7: Result := 2570;
               8: Result := 2700;
            end;
      22:   case npos of
               0: Result := 0;
               1: Result := 430;
               2: Result := 1290;
               3: Result := 1810;
            end;
      23:   case npos of    //20080328 24.wil 扩展
               0: Result := 0;
               1: Result := 340;
               2: Result := 680;
               3: Result := 1180;
               4: Result := 1770;
               5: Result := 2610;
               6: Result := 2950;
               7: Result := 3290;
               8: Result := 3750;
               9: Result := 4100;
              10: Result := 4460;
              11: Result := 4810;
            end;
      24:   case npos of    //20081213 25.wil扩展
               0: Result := 0;
               1: Result := 510;
               2: Result := 1090; 
            end;
      25:   case npos of   //20081213 26.wil扩展
               0: Result := 0;
               1: Result := 510;
               2: Result := 1020;
               3: Result := 1370;
               4: Result := 1720;
               5: Result := 2070;
               6: Result := 2740;
               7: Result := 3780;
               8: Result := 3820;
               9: Result := 4170;
            end;
      26:   case npos of  //20081213 27.wil扩展
               0: Result := 0;
               1: Result := 340;
               2: Result := 680;
               3: Result := 1190;
               4: Result := 1930;
               5: Result := 2100;
               6: Result := 2440;
               7: Result := 2540;
               8: Result := 3570;
            end;
      27:   case npos of  //20091217 28.wil扩展
               0: Result := 0;
               1: Result := 350;
               2: Result := 1560;
               3: Result := 1910;
            end;
      28: case npos of
          	0: Result := 0;
            1: Result := 600;
          end;
      29:   Result := npos * 360; //30.wil扩展
      32: case npos of //33.wil
            0: Result := 0;
            1: Result := 440;
            2: Result := 820;
            3: Result := 1360;
            4: Result := 2590;
            5: Result := 2680;
            6: Result := 2790;
            7: Result := 2900;
            8: Result := 3500;
            9: Result := 3930;
           10: Result := 4370;
           11: Result := 4440;
          end;
      33: case npos of //34.wil
      			0: Result := 20;
            1: Result := 720;
            2: Result := 1160;
            else Result := npos * 360;
		      end;
      34: case npos of //35.wil
            0: Result := 0; //老虎
            1: Result := 680; //龙
          end;
      35: case npos of //36.wil By TasNat at: 2012-10-18 10:00:27
            0: Result := 0;
            1: Result := 810;
            2: Result := 1780;
            3: Result := 1800;
            4: Result := 2610;
            5: Result := 3420;
            6: Result := 4390;
            7: Result := 5200;
            8: Result := 6170;
            9: Result := 6980;
          end;

      36: case npos of //36.wil By TasNat at: 2012-10-18 10:18:19
            0: Result := 7790;
            1: Result := 8760; 
            2: Result := 9570; 
            3: Result := 10380;
            4: Result := 11030;
            5: Result := 12000;
            6: Result := 13800;
            7: Result := 14770;
            8: Result := 15580;
            9: Result := 16390;
          end;

      37: case npos of //36.wil By TasNat at: 2012-10-18 10:18:19
            0: Result := 17360;
            1: Result := 18330;
            2: Result := 19300;
            3: Result := 20270;
            4: Result := 21240; 
            5: Result := 22050; 
            6: Result := 22860;
            7: Result := 23990; 
            8: Result := 24800;
            9: Result := 25930; 
          end;
      38: case npos of //37.wil By TasNat at: 2012-10-18 10:18:19
            0: Result := 0;
            1: Result := 400;
            2: Result := 960; 
            3: Result := 1440;
            4: Result := 1840;
            5: Result := 2240;
            6: Result := 2840;
          end;

      80:   case npos of
               0: Result := 0;   //己巩
               1: Result := 80;
               2: Result := 300;
               3: Result := 301;
               4: Result := 302;
               5: Result := 320;
               6: Result := 321;
               7: Result := 322;
               8: Result := 321;
            end;
      90:   case npos of
               0: Result := 80;   //己巩
               1: Result := 168;
               2: Result := 184;
               3: Result := 200;
               4: Result := 1770;
               5: Result := 1790;
               6: Result := 1780;
              10..12: Result := (npos-10)*360; //强化骷髅
              13..15: Result := 1910; //28WIL里的强化圣兽
            end
      else Result := npos * 360;
   end;
end;

// liuzhigang 加 NPC 这个地方加，处理偏移量
function GetNpcOffset(nAppr:Integer):Integer;
var
  Idx: Integer;
begin
  Result:=0;
  case nAppr of
    //npc.wil
    24,25: Result:=(nAppr - 24) * 60 + 1470;
    0..22: Result:=nAppr * 60;
    23: Result:=1380;
    27,32: Result:=(nAppr - 26) * 60 + 1620 - 30;
    26,28,29,30,31,33..41: Result:=(nAppr - 26) * 60 + 1620;
    42,43: Result:=2580;
    44..47: Result:=2640;
    48..50: Result:=(nAppr - 48) * 60 + 2700;
    51: Result:=2880;
    52: Result:=2960;
    53: Result:=4180;
    //雪域NPC
    54: Result:=4490;
    55: Result:=4500;
    56: Result:=4510;
    57: Result:=4520;
    58: Result:=4530;
    59: Result:=4540;
    60: Result:=4240; //灯笼NPC
    61: Result:=4770; //圣诞树
    62: Result:=3180; //神秘宝藏 NPC 20080301
    63: Result:=4810; //圣诞老人
    64: Result:=4560; //练气炉
    //卧龙
    70: Result:=3780;
    71: Result:=3790;
    72: Result:=3800;
    73: Result:=3810;
    74: Result:=3820;
    75: Result:=3830;
    90: Result:=3750; //卧龙里的空宝箱NPC  20080301
    91: Result:=3760; //卧龙里的空宝箱NPC  20080301
    92: Result:=3770; //卧龙里的空宝箱NPC  20080301
    93: Result:=3600; //9周年宝箱
    65: Result:=3360; //火龙宝箱 NPC 20080301 方位1
    66: Result:=3380; //火龙宝箱 NPC 20080301 方位2
    67: Result:=4060; //玛法酒神
    68: Result:=4120; //千年暖玉鉴定师
    80: Result:=3840; //酒馆的店小二 20080308
    81: Result:=3900; //酒馆老板娘  20080308
    82: Result:=3960; //酒馆影月 20080308
    83: Result:=3980; //酒馆辰星 20080308
    84: Result:=4000; //酒馆翔天 20080308
    //npc2.wil
    95..98,102,104,105: Result:= (nAppr-95) * 70;
    99..101: Result := (nAppr - 99) * 70 + 250;
    103: Result := 560;
    106: Result := 740;
    107..112: Result := (nAppr - 99) * 10 + 730;
    113..115: Result := (nAppr - 99) * 30 + 450;
    116..118: Result := (nAppr - 99) * 10 + 800;
  end;
end;

destructor TActor.Destroy;
var
  I: Integer;
begin
  if m_MsgList.Count > 0 then //20080629
  for I := 0 to m_MsgList.Count - 1 do begin
    if pTChrMsg(m_MsgList.Items[I]) <> nil then Dispose(pTChrMsg(m_MsgList.Items[I]));
  end;
  m_MsgList.Clear;
  FreeAndNil(m_MsgList);
  if m_Kill79MsgList.Count > 0 then
  for I:=0 to m_Kill79MsgList.Count - 1 do begin
    if pTChrMsg(m_Kill79MsgList[I]) <> nil then Dispose(pTChrMsg(m_Kill79MsgList[I]));
  end;
  m_Kill79MsgList.Clear;
  FreeAndNil(m_Kill79MsgList);
  {$IF M2Version <> 2}
  for I:=0 to m_nMoveHpList.Count-1 do begin
    Dispose(pTMoveHMShow(m_nMoveHpList.Items[I]));
  end;
  FreeAndNil(m_nMoveHpList);
  {$IFEND}
  inherited Destroy;
end;


//角色接收到的消息
procedure  TActor.SendMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer; NewFeature: TFeatures);
var
  Msg:pTChrMsg;
begin
  m_MsgList.Lock;
  try
    New(Msg);
    Msg.ident   := wIdent;
    Msg.x       := nX;
    Msg.y       := nY;
    Msg.dir     := ndir;
    Msg.feature := nFeature;
    Msg.state   := nState;
    Msg.saying  := sStr;
    Msg.Sound   := nSound;
    Msg.NewFeature := NewFeature;
    m_MsgList.Add(Msg);
  finally
    m_MsgList.UnLock;
  end;
end;

//追心刺改变坐标的消息列表
procedure  TActor.Kill79SendMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
var
  Msg:pTChrMsg;
begin
  m_Kill79MsgList.Lock;
  try
    New(Msg);
    Msg.ident   := wIdent;
    Msg.x       := nX;
    Msg.y       := nY;
    Msg.dir     := ndir;
    Msg.feature := nFeature;
    Msg.state   := nState;
    Msg.saying  := sStr;
    Msg.Sound   := nSound;
    m_Kill79MsgList.Add(Msg);
  finally
    m_Kill79MsgList.UnLock;
  end;
end;
//用新消息更新（若已经存在）消息列表
procedure TActor.UpdateMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer; NewFeature: TFeatures);
var
  I: integer;
  Msg:pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I:= 0;
    while TRUE do begin
      //从当前消息列表中寻找,若找到,则删除,同时清除当前玩家控制的角色的走、跑等消息，因为这些消息已经处理了。
      if I >= m_MsgList.Count then break;
      Msg:=m_MsgList.Items[I]; //原代码
      if ((Self = g_MySelf) and (Msg.Ident >= 3000) and (Msg.Ident <= 3099)) or (Msg.Ident = wIdent) then begin
        Dispose(Msg);       //删除已经存在的相同消息
        m_MsgList.Delete(I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
  SendMsg (wIdent,nX,nY,nDir,nFeature,nState,sStr,nSound, NewFeature);   //添加消息
end;

//清除消息号在[3000,3099]之间的消息
procedure TActor.CleanUserMsgs;
var
  I:Integer;
  Msg:pTChrMsg;
begin
  m_MsgList.Lock;
  try
    I:= 0;
    while TRUE do begin
      if I >= m_MsgList.Count then break;
      Msg:=m_MsgList.Items[I];
      {if (Msg.Ident >= 3000) and //基本运动消息：走、跑等
         (Msg.Ident <= 3099) then begin }
       if (Msg.Ident > 2999) and //基本运动消息：走、跑等
         (Msg.Ident < 3100) then begin
        Dispose(Msg); 
        m_MsgList.Delete (I);
        Continue;
      end;
      Inc(I);
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

//角色动作动画
procedure TActor.CalcActorFrame;
begin
  m_boUseMagic    := FALSE;
  m_nCurrentFrame := -1;
  //根据appr计算本角色在图片库中的开始图片索引
  m_nBodyOffset   := GetOffset (m_wAppearance);
  //动作对应的图片序列定义
  m_Action := GetRaceByPM(m_btRace,m_wAppearance);
  if m_Action = nil then exit;
   case m_nCurrentAction of
      SM_TURN://转身=站立动作的开始帧 + 方向 X 站立动作的图片数
         begin
            m_nStartFrame := m_Action.ActStand.start + m_btDir * (m_Action.ActStand.frame + m_Action.ActStand.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActStand.frame - 1;
            m_dwFrameTime := m_Action.ActStand.ftime;
            m_dwStartTime := GetTickCount;
            m_nDefFrameCount := m_Action.ActStand.frame;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_WALK{走}, SM_RUSH, SM_RUSHKUNG, SM_BACKSTEP:  //走动=走动动作的开始帧 + 方向 X 每方向走动动作的图片数
         begin
            m_nStartFrame := m_Action.ActWalk.start + m_btDir * (m_Action.ActWalk.frame + m_Action.ActWalk.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActWalk.frame - 1;
            m_dwFrameTime := m_Action.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := m_Action.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            if m_nCurrentAction = SM_BACKSTEP then    //后退
               Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
            else
               Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
         end;
      {SM_BACKSTEP:
         begin
            startframe := pm.ActWalk.start + (pm.ActWalk.frame - 1) + Dir * (pm.ActWalk.frame + pm.ActWalk.skip);
            m_nEndFrame := startframe - (pm.ActWalk.frame - 1);
            m_dwFrameTime := pm.ActWalk.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := pm.ActWalk.UseTick;
            m_nCurTick := 0;
            m_nMoveStep := 1;
            Shift (GetBack(Dir), m_nMoveStep, 0, m_nEndFrame-startframe+1);
         end;}
      SM_HIT{普通攻击}:
         begin
            m_nStartFrame := m_Action.ActAttack.start + m_btDir * (m_Action.ActAttack.frame + m_Action.ActAttack.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActAttack.frame - 1;
            m_dwFrameTime := m_Action.ActAttack.ftime;
            m_dwStartTime := GetTickCount;
            //WarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_STRUCK:{受攻击}
         begin
            m_nStartFrame := m_Action.ActStruck.start + m_btDir * (m_Action.ActStruck.frame + m_Action.ActStruck.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActStruck.frame - 1;
            m_dwFrameTime := m_dwStruckFrameTime; //pm.ActStruck.ftime;
            m_dwStartTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_DEATH:   //被打死
         begin
            m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
            m_nStartFrame := m_nEndFrame; //
            m_dwFrameTime := m_Action.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_NOWDEATH: //死了
         begin
            m_nStartFrame := m_Action.ActDie.start + m_btDir * (m_Action.ActDie.frame + m_Action.ActDie.skip);
            m_nEndFrame := m_nStartFrame + m_Action.ActDie.frame - 1;
            m_dwFrameTime := m_Action.ActDie.ftime;
            m_dwStartTime := GetTickCount;
         end;
      SM_SKELETON:  //彻底死了（不再动作）
         begin
            m_nStartFrame := m_Action.ActDeath.start + m_btDir;
            m_nEndFrame := m_nStartFrame + m_Action.ActDeath.frame - 1;
            m_dwFrameTime := m_Action.ActDeath.ftime;
            m_dwStartTime := GetTickCount;
         end;
   end;
end;

procedure TActor.ReadyAction (msg: TChrMsg);
var
   n: integer;
   UseMagic: PTUseMagicInfo;
begin
   m_nActBeforeX := m_nCurrX;        //动作之前的位置（当服务器不认可时可以回去)
   m_nActBeforeY := m_nCurrY;

   if msg.Ident = SM_ALIVE then begin      //复活
      m_boDeath := FALSE;
      m_boSkeleton := FALSE;
   end;
   if not m_boDeath then begin
      case msg.Ident of
         SM_TURN, SM_WALK, SM_NPCWALK, SM_BACKSTEP, SM_RUSH, SM_RUSHKUNG, SM_RUN, {SM_HORSERUN,20080803注释骑马消息} SM_DIGUP, SM_ALIVE:
            begin
               m_nFeature := msg.NewFeature;
               m_nState := msg.state;
               //是否可以查看角色生命值
               if m_nState and STATE_OPENHEATH <> 0 then m_boOpenHealth := TRUE
               else m_boOpenHealth := FALSE;
            end;
      end;
      if msg.ident = SM_LIGHTING then n := 0;
      if (g_MySelf = self) then begin
         if (msg.Ident = CM_WALK) then
            if not PlayScene.CanWalk (msg.x, msg.y) then exit;  //不可行走
         if (msg.Ident = CM_RUN) then
            if not PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then exit; //不能跑
         {if (msg.Ident = CM_HORSERUN) then  20080803注释骑马消息
            if not PlayScene.CanRun (g_MySelf.m_nCurrX, g_MySelf.m_nCurrY, msg.x, msg.y) then
               exit;   }
         //msg
         case msg.Ident of
            CM_TURN,
            CM_WALK,
            CM_SITDOWN,
            CM_RUN,
            CM_HIT,
            CM_HEAVYHIT,
            CM_BIGHIT,
            CM_WIDEHIT:
               begin
                  RealActionMsg := msg; //保存当前动作
                  msg.Ident := msg.Ident - 3000;  //SM_?? 栏肺 函券 窃
               end;
            CM_POWERHIT: begin
              RealActionMsg := msg; //保存当前动作
              case msg.feature of
                1..3: msg.Ident := SM_POWERHITEX1;
                4..6: msg.Ident := SM_POWERHITEX2;
                7..9: msg.Ident := SM_POWERHITEX3;
                else msg.Ident := msg.Ident - 3000; 
              end;
            end;
            CM_HIT_107: begin
              RealActionMsg := msg;
              msg.Ident := SM_HIT_107;
            end;
            {CM_HORSERUN: begin  20080803注释骑马消息
              RealActionMsg:=msg;
              msg.Ident:=SM_HORSERUN;
            end; }
            {CM_THROW: begin
              if m_nFeature <> 0 then begin
                m_nTargetX := TActor(msg.feature).m_nCurrX;  //x 带瘤绰 格钎
                m_nTargetY := TActor(msg.feature).m_nCurrY;    //y
                m_nTargetRecog := TActor(msg.feature).m_nRecogId;
              end;
              RealActionMsg := msg;
              msg.Ident := SM_THROW;
            end;    }
            {$IF M2Version <> 2}
            CM_LONGHITFORFENGHAO: begin //粉色刺杀技能
              RealActionMsg := msg;
              msg.Ident := SM_LONGHITFORFENGHAO;
            end;
            CM_FIREHITFORFENGHAO: begin //粉色烈火技能
              RealActionMsg := msg;
              msg.Ident := SM_FIREHITFORFENGHAO;
            end;
            CM_DAILYFORFENGHAO: begin //粉色逐日剑法
              RealActionMsg := msg;
              msg.Ident := SM_DAILYFORFENGHAO;
            end;
            {$IFEND}
            CM_FIREHIT: begin  //烈火
              RealActionMsg := msg;
              case msg.feature of
                1..3: msg.Ident := SM_FIREHITEX1;
                4..6: msg.Ident := SM_FIREHITEX2;
                7..9: msg.Ident := SM_FIREHITEX3;
                else msg.Ident := SM_FIREHIT;
              end;
            end;
            {CM_69HIT: begin  //倚天辟地
              RealActionMsg := msg;
              msg.Ident := SM_69HIT;
            end; }
            CM_BATTERHIT1: begin //追心刺
              RealActionMsg := msg;
              msg.Ident := SM_BATTERHIT1;
            end;
            CM_LONGHIT: begin //刺杀
              RealActionMsg := msg; //保存当前动作
              case msg.feature of
                1..3: msg.Ident := SM_LONGHITEX1;
                4..6: msg.Ident := SM_LONGHITEX2;
                7..9: msg.Ident := SM_LONGHITEX3;
                else msg.Ident := msg.Ident - 3000; 
              end;
            end;
            CM_LONGHIT4: begin //4级刺杀
              RealActionMsg := msg;
              case msg.feature of
                1..3: msg.Ident := SM_LONGHITEX1;
                4..6: msg.Ident := SM_LONGHITEX2;
                7..9: msg.Ident := SM_LONGHITEX3;
                else msg.Ident := SM_LONGHIT4; 
              end;
            end;
            CM_WIDEHIT4: begin   //圆月弯刀
              RealActionMsg := msg;
              case msg.feature of
                1..3: msg.Ident := SM_WIDEHIT4EX1;
                4..6: msg.Ident := SM_WIDEHIT4EX2;
                7..9: msg.Ident := SM_WIDEHIT4EX3;
                else msg.Ident := SM_WIDEHIT4;
              end;
            end;
            CM_BATTERHIT2: begin //三绝杀
              RealActionMsg := msg;
              msg.Ident := SM_BATTERHIT2;
            end;
            CM_BATTERHIT3: begin //横扫千军
              RealActionMsg := msg;
              msg.Ident := SM_BATTERHIT3;
            end;
            CM_BATTERHIT4: begin //断岳斩
              RealActionMsg := msg;
              msg.Ident := SM_BATTERHIT4;
            end;
            CM_4FIREHIT: begin  //4级烈火
              RealActionMsg := msg;
              case msg.feature of
                1..3: msg.Ident := SM_FIREHITEX1;
                4..6: msg.Ident := SM_FIREHITEX2;
                7..9: msg.Ident := SM_FIREHITEX3;
                else msg.Ident := SM_4FIREHIT;
              end;
            end;
            CM_DAILY: begin //逐日剑法 20080511
              RealActionMsg := msg;
              case msg.feature of
                1..3: msg.Ident := SM_DAILYEX1;
                4..6: msg.Ident := SM_DAILYEX2;
                7..9: msg.Ident := SM_DAILYEX3;
                else msg.Ident := SM_DAILY;
              end;
            end;
            CM_BLOODSOUL: begin //血魄一击(战)
              RealActionMsg := msg;
              msg.Ident := SM_BLOODSOUL;
            end;
            CM_CRSHIT: begin
              RealActionMsg := msg;
              msg.Ident := SM_CRSHIT;
            end;
            CM_TWINHIT: begin
              RealActionMsg := msg;
              msg.Ident := SM_TWINHIT;
            end;
            CM_QTWINHIT: begin   //开天斩轻击 2008.02.12
              RealActionMsg := msg;
              msg.Ident := SM_QTWINHIT;
            end;
            CM_CIDHIT: begin {龙影剑法}
              RealActionMsg := msg;
              msg.Ident := SM_CIDHIT;
            end;
            CM_3037: begin
              RealActionMsg := msg;
              msg.Ident := SM_41;
            end;
            CM_SELFSHOPITEMS: begin   //摆摊
              frmMain.SendShopMsg(msg.Ident, msg.saying);
              Exit;
            end;
            CM_SPELL: begin
                  RealActionMsg := msg;
                  UseMagic := PTUseMagicInfo (msg.feature);   //根据msg.feature获得pmag指针
                  RealActionMsg.Dir := UseMagic.MagicSerial;
                  msg.Ident := msg.Ident - 3000;  //SM_?? 栏肺 函券 窃
            end;
         end;
         m_nOldx := m_nCurrX;
         m_nOldy := m_nCurrY;     
         m_nOldDir := m_btDir;
      end;
      case msg.Ident of
         SM_STRUCK:
            begin
               //Abil.HP := msg.x; {HP}
               //Abil.MaxHP := msg.y; {maxHP}
               //msg.dir {damage}
               m_nMagicStruckSound := msg.x; 
               n := Round (200 - m_Abil.Level * 5);
               if n > 80 then m_dwStruckFrameTime := n
               else m_dwStruckFrameTime := 80;
               //m_dwLastStruckTime := GetTickCount;  20080521 注释没用到变量
            end;
         SM_SPELL:
            begin
               m_btDir := msg.dir;
               //msg.x  :targetx
               //msg.y  :targety
               UseMagic := PTUseMagicInfo (msg.feature);
               if UseMagic <> nil then begin
                  m_CurMagic := UseMagic^;
                  m_CurMagic.ServerMagicCode := -1; //FIRE 措扁
                  //CurMagic.MagicSerial := 0;
                  m_CurMagic.TargX := msg.x;
                  m_CurMagic.TargY := msg.y;
                  Dispose (UseMagic);
               end;
            end;
         SM_RUSHKUNG: begin  //20080409  防止英雄用野蛮消失
               m_nFeature := msg.NewFeature;
               m_nState := msg.state;
               //是否可以查看角色生命值
               if m_nState and STATE_OPENHEATH <> 0 then m_boOpenHealth := TRUE
               else m_boOpenHealth := FALSE;
         end;
         SM_FLYAXE: begin
           if m_btRace <> 116 then begin
             m_nCurrX := msg.x;
             m_nCurrY := msg.y;
           end;
           m_btDir := msg.dir;
         end;
         else begin  //此句是用技能失败 人物跑到消息坐标去  20080409
               m_nCurrX := msg.x;
               m_nCurrY := msg.y;
               m_btDir := msg.dir;
            end;
      end;

      m_nCurrentAction := msg.Ident;
      CalcActorFrame;
      //DScreen.AddSysMsg (IntToStr(msg.Ident) + ' ' + IntToStr(XX) + ' ' + IntToStr(YY) + ' : ' + IntToStr(msg.x) + ' ' + IntToStr(msg.y));
   end else begin
      if msg.Ident = SM_SKELETON then begin
         m_nCurrentAction := msg.Ident;
         CalcActorFrame;
         m_boSkeleton := TRUE;
      end;
   end;
   if (msg.Ident = SM_DEATH) or (msg.Ident = SM_NOWDEATH) then begin
      m_boDeath := TRUE;
      //m_dwDeathTime := GetTickCount;
      PlayScene.ActorDied (self);
   end;
   RunSound;
end;

function TActor.GetKill79Message(ChrMsg:pTChrMsg): Boolean;
var
  Msg:pTChrMsg;
begin
  Result:=False;
  m_Kill79MsgList.Lock;
  try
    if m_Kill79MsgList.Count > 0 then begin
      Msg:=pTChrMsg(m_Kill79MsgList.Items[0]);
      if GetTickCount - m_dwKill79Time > 100 then begin
        ChrMsg.Ident:=Msg.Ident;
        ChrMsg.X:=Msg.X;
        ChrMsg.Y:=Msg.Y;
        ChrMsg.Dir:=Msg.Dir;
        ChrMsg.State:=Msg.State;
        ChrMsg.feature:=Msg.feature;
        ChrMsg.saying:=Msg.saying;
        ChrMsg.Sound:=Msg.Sound;
        Dispose(Msg);
        m_Kill79MsgList.Delete(0);
        m_dwKill79Time := GetTickCount;
        Result:=True;
      end;
    end;
  finally
    m_Kill79MsgList.UnLock;
  end;
end;

function TActor.GetMessage(ChrMsg:pTChrMsg): Boolean;
var
  Msg:pTChrMsg;
begin
  Result:=False;
  m_MsgList.Lock;
  try
    if m_MsgList.Count > 0 then begin
      Msg:=pTChrMsg(m_MsgList.Items[0]);
      ChrMsg.Ident:=Msg.Ident;
      ChrMsg.X:=Msg.X;
      ChrMsg.Y:=Msg.Y;
      ChrMsg.Dir:=Msg.Dir;
      ChrMsg.State:=Msg.State;
      ChrMsg.feature:=Msg.feature;
      ChrMsg.saying:=Msg.saying;
      ChrMsg.Sound:=Msg.Sound;
      ChrMsg.NewFeature := Msg.NewFeature;
      Dispose(Msg);
      m_MsgList.Delete(0);
      Result:=True;
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

procedure TActor.ProcMsg;
var
  Msg:TChrMsg;
  Meff:TMagicEff;
  ErrCode: Integer;
begin
  ErrCode := 0;
  try
    ErrCode := 1;
    while GetKill79Message(@Msg) do begin
      case Msg.ident of
        SM_RUSH79: begin
          m_nCurrX := msg.x;
          m_nCurrY := msg.y;
          m_nRx := m_nCurrX;
          m_nRy := m_nCurrY;
          m_btDir := msg.dir;
        end;
      end;
    end;
    ErrCode := 2;
    while (m_nCurrentAction = 0) and GetMessage(@Msg) do begin
      case Msg.ident of
         SM_STRUCK: begin
           m_nHiterCode := msg.Sound;
           ReadyAction (msg);
         end;
         SM_DEATH,  //27
         SM_NOWDEATH,
         SM_SKELETON,
         SM_ALIVE,
         SM_ACTION_MIN..SM_ACTION_MAX,  //26
         SM_ACTION2_MIN..SM_ACTION2_MAX,//35   2293    293
         SM_NPCWALK,
         CM_SELFSHOPITEMS, //摆摊
         {$IF M2Version <> 2}
         CM_LONGHITFORFENGHAO,
         CM_FIREHITFORFENGHAO,
         CM_DAILYFORFENGHAO,
         {$IFEND}
         3000..3099: ReadyAction (msg);

         SM_SPACEMOVE_HIDE: begin  //修改传送地图不显示动画 20080521
           meff := TScrollHideEffect.Create (250, 10, m_nCurrX, m_nCurrY, self);
           PlayScene.m_EffectList.Add (meff);
           PlaySound (s_spacemove_out);
          {if g_TargetCret <> nil then
            PlayScene.DeleteActor (g_TargetCret.m_nRecogId);  }
         end;
         SM_SPACEMOVE_HIDE2: begin
           meff := TScrollHideEffect.Create (1590, 10, m_nCurrX, m_nCurrY, self);
           PlayScene.m_EffectList.Add (meff);
           PlaySound (s_spacemove_out);
         end;
         SM_SPACEMOVE_SHOW: begin  //修改传送地图不显示动画 20080521
           meff := TCharEffect.Create (260, 10, self);
           PlayScene.m_EffectList.Add (meff);
           msg.ident := SM_TURN;
           ReadyAction (msg);
           PlaySound (s_spacemove_in);
         end;
         SM_SPACEMOVE_SHOW2: begin
           meff := TCharEffect.Create (1600, 10, self);
           PlayScene.m_EffectList.Add (meff);
           msg.ident := SM_TURN;
           ReadyAction (msg);
           PlaySound (s_spacemove_in);
         end;
         SM_SPACEMOVE_SHOW3: begin
           msg.ident := SM_TURN;
           ReadyAction (msg);
         end;
         SM_CRSHIT,SM_TWINHIT,SM_QTWINHIT,SM_CIDHIT, SM_4FIREHIT,
         SM_FAIRYATTACKRATE,SM_BLOODSOUL{血魄一击(战)},SM_DAILY{逐日剑法},
         SM_LEITINGHIT{雷霆一击战士效果 20080611},SM_BATTERHIT1,
         SM_BATTERHIT2,SM_BATTERHIT3,SM_BATTERHIT4,
         {$IF M2Version <> 2}SM_LONGHITFORFENGHAO,SM_FIREHITFORFENGHAO,SM_DAILYFORFENGHAO,{$IFEND}
         SM_LONGHIT4, SM_WIDEHIT4, SM_DAILYEX1..SM_DAILYEX3, SM_FIREHITEX1..SM_FIREHITEX3,
         SM_WIDEHIT4EX1..SM_WIDEHIT4EX3, SM_LONGHITEX1..SM_LONGHITEX3: ReadyAction (msg); //解决英雄放开天龙影 看不到问题
         else
            begin
              // ReadyAction (msg); //解决人物改变地图黑屏问题 20080410
            end;
      end;
    end;                            
  except
    DebugOutStr(format('TActor.ProcMsg Code: %d',[ErrCode]));
  end;
end;

procedure TActor.ProcHurryMsg; //紧急消息处理：使用魔法、魔法失败
var
   n: integer;
   msg: TChrMsg;
   fin: Boolean;
begin
   n := 0;
   while TRUE do begin    
      if m_MsgList.Count <= n then break;
      msg := PTChrMsg (m_MsgList[n])^;   //取出消息
      fin := FALSE;
      case msg.Ident of
         SM_MAGICFIRE: begin
            if m_CurMagic.ServerMagicCode <> 0 then begin
               m_CurMagic.ServerMagicCode := 111;
               m_CurMagic.Target := msg.x;
               if msg.y in [0..MAXMAGICTYPE-1] then
               m_CurMagic.EffectType := TMagicType(msg.y); //EffectType
               m_CurMagic.EffectNumber := msg.dir; //Effect
               m_CurMagic.TargX := msg.feature;
               m_CurMagic.TargY := msg.state;
               m_CurMagic.EffectLevelEx := msg.sound; //重数
               m_CurMagic.Recusion := TRUE;
               fin := TRUE;
               //这里可以显示使用魔法的名称，但是客户端不知道魔法的名称，
               //应该在本地保留一个魔法名称列表，根据ServerMaigicCode获得名称
            end;
         end;
         SM_MAGICFIRE_FAIL: begin
            if m_CurMagic.ServerMagicCode <> 0 then begin
               m_CurMagic.ServerMagicCode := 0;
               fin := TRUE;
            end;
         end;
      end;
      if fin then begin
         Dispose (PTChrMsg (m_MsgList[n]));
         m_MsgList.Delete (n);
      end else
         Inc (n);
   end;
end;

//当前是否没有可执行的动作
function  TActor.IsIdle: Boolean;
begin
   if (m_nCurrentAction = 0) and (m_MsgList.Count = 0) then
      Result := TRUE
   else Result := FALSE;
end;
//当前动作是否已经完成
function  TActor.ActionFinished: Boolean;
begin
   if (m_nCurrentAction = 0) or (m_nCurrentFrame >= m_nEndFrame) then
      Result := TRUE
   else Result := FALSE;
end;
//可否行走
function  TActor.CanWalk: Integer;
begin
   if {(GetTickCount - LastStruckTime < 1300) or}(GetTickCount - g_dwLatestSpellTick < g_dwMagicPKDelayTime) then
      Result := -1   
   else
   if GetTickCount - g_dwLastMoveTick < m_nMoveTimeStep then
     Result := -2
   else
      Result := 1;
end;
//可否跑
function  TActor.CanRun: Integer;
begin
   Result := 1;
   //检查人物的HP值是否低于指定值，低于指定值将不允许跑
   if m_Abil.HP < RUN_MINHEALTH then begin
      Result := -1;
   end else
   if GetTickCount - g_dwLastMoveTick < m_nMoveTimeStep then
     Result := -2;
   
   //检查人物是否被攻击，如果被攻击将不允许跑，取消检测将可以跑步逃跑
//   if (GetTickCount - LastStruckTime < 3*1000) or (GetTickCount - LatestSpellTime < MagicPKDelayTime) then
//      Result := -2;

end;


//dir : 方向
//step : 步长  (走是1，跑是2）
//cur : 当前帧(全部帧中的第几帧）
//max : 全部帧
procedure TActor.Shift (dir, step, cur, max: integer);
var
   unx, uny, ss, v: integer;
begin
   unx := UNITX * step;
   uny := UNITY * step;
   if cur > max then cur := max;
   m_nRx := m_nCurrX;
   m_nRy := m_nCurrY;
//   ss := Round((max-cur-1) / max) * step;
   case dir of
      DR_UP: begin
        ss := Round((max-cur) / max) * step;
        m_nShiftX := 0;
        m_nRy := m_nCurrY + ss;
        if ss = step then m_nShiftY := -Round(uny / max * cur)
        else m_nShiftY := Round(uny / max * (max-cur));
      end;
      DR_UPRIGHT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur+v) / max) * step;
            m_nRx := m_nCurrX - ss;
            m_nRy := m_nCurrY + ss;
            if ss = step then begin
               m_nShiftX:=  Round(unx / max * cur);
               m_nShiftY:= -Round(uny / max * cur);
            end else begin
               m_nShiftX:= -Round(unx / max * (max-cur));
               m_nShiftY:=  Round(uny / max * (max-cur));
            end;
         end;
      DR_RIGHT:
         begin
            ss := Round((max-cur) / max) * step;
            m_nRx := m_nCurrX - ss;
            if ss = step then m_nShiftX := Round(unx / max * cur)
            else m_nShiftX := -Round(unx / max * (max-cur));
            m_nShiftY := 0;
         end;
      DR_DOWNRIGHT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nRx := m_nCurrX - ss;
            m_nRy := m_nCurrY - ss;
            if ss = step then begin
               m_nShiftX:= Round(unx / max * cur);
               m_nShiftY:= Round(uny / max * cur);
            end else begin
               m_nShiftX:= -Round(unx / max * (max-cur));
               m_nShiftY:= -Round(uny / max * (max-cur));
            end;
         end;
      DR_DOWN:
         begin
            if max >= 6 then v := 1
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nShiftX := 0;
            m_nRy := m_nCurrY - ss;
            if ss = step then m_nShiftY := Round(uny / max * cur)
            else m_nShiftY := -Round(uny / max * (max-cur));
         end;
      DR_DOWNLEFT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur-v) / max) * step;
            m_nRx := m_nCurrX + ss;
            m_nRy := m_nCurrY - ss;
            if ss = step then begin
               m_nShiftX := -Round(unx / max * cur);
               m_nShiftY :=  Round(uny / max * cur);
            end else begin
               m_nShiftX :=  Round(unx / max * (max-cur));
               m_nShiftY := -Round(uny / max * (max-cur));
            end;
         end;
      DR_LEFT:
         begin
            ss := Round((max-cur) / max) * step;
            m_nRx := m_nCurrX + ss;
            if ss = step then m_nShiftX := -Round(unx / max * cur)
            else m_nShiftX := Round(unx / max * (max-cur));
            m_nShiftY := 0;
         end;
      DR_UPLEFT:
         begin
            if max >= 6 then v := 2
            else v := 0;
            ss := Round((max-cur+v) / max) * step;
            m_nRx := m_nCurrX + ss;
            m_nRy := m_nCurrY + ss;
            if ss = step then begin
               m_nShiftX := -Round(unx / max * cur);
               m_nShiftY := -Round(uny / max * cur);
            end else begin
               m_nShiftX := Round(unx / max * (max-cur));
               m_nShiftY := Round(uny / max * (max-cur));
            end;
         end;
   end;
end;

function TActor.GetEffectWil(idx: Byte): TWMImages;
begin
  case idx of
    0: Result := g_WHumWingImages;
    1: Result := g_WHumWing2Images;
    2: Result := g_WWeaponEffectImages;
    3: Result := g_WHumWing3Images;
    4: Result := g_WHumWing4Images;
    5: Result := g_WWeaponEffectImages4;
    else Result := nil;
  end;
end;

//人物外貌特征改变
procedure  TActor.FeatureChanged;
begin
   case m_btRace of
      0,1,150: begin //人物,英雄,人型 20080629
         m_btHair   := m_nFeature.btHair; //HAIRfeature (m_nFeature);// 得到M2发来对应的发型 , 女=7 男=6 主体,英雄 女=3 男=4
         m_btDress  := m_nFeature.nDress; //DRESSfeature (m_nFeature);
         m_btWeapon := m_nFeature.nWeapon; //WEAPONfeature (m_nFeature);
         //m_btHorse  := Horsefeature(m_nFeatureEx); 20080721 注释骑马
         m_btEffect := Effectfeature(m_nFeatureEx);
         m_nBodyOffset := HUMANFRAME * m_btDress; //男0, 女1
        // haircount := g_WHairImgImages.ImageCount div {HUMANFRAME}1200 div 2; //每性别发型数=3600 /600 /2 =3
         m_boMagicShield := m_nFeature.btStatus = 1;
        case m_btHair of
          255: begin
            m_nHairOffset := HUMANFRAME * (m_btSex + 6);  //普通斗笠
            m_nCboHairOffset := NEWHUMANFRAME * (m_btSex + 6);  //普通斗笠
          end;
          254: begin
            m_nHairOffset := HUMANFRAME * (m_btSex + 8); //金色斗笠
            m_nCboHairOffset := NEWHUMANFRAME * (m_btSex + 8);  //金色斗笠
          end;
          253: begin
            m_nHairOffset := HUMANFRAME * (m_btSex + 12); //必杀斗笠
            m_nCboHairOffset := NEWHUMANFRAME * (m_btSex + 12);  //必杀斗笠
          end;
          252: begin
            m_nHairOffset := HUMANFRAME * ({m_btSex +} 10); //金牛斗笠   女的斗笠坐标有问题
            m_nCboHairOffset := NEWHUMANFRAME * (m_btSex + 10);  //金牛斗笠
          end;
          251: begin //主宰斗笠
            m_nHairOffset := HUMANFRAME * (m_btSex + 14); //金牛斗笠   女的斗笠坐标有问题
            m_nCboHairOffset := NEWHUMANFRAME * (m_btSex + 14);  //金牛斗笠
          end;
          250: begin //传奇斗笠
            m_nHairOffset := HUMANFRAME * (m_btSex + 16);
            m_nCboHairOffset := NEWHUMANFRAME * (m_btSex + 16);
          end;
          249: begin //皓月斗笠
            m_nHairOffset := HUMANFRAME * (m_btSex + 18);
            m_nCboHairOffset := NEWHUMANFRAME * (m_btSex + 18);
          end
          else begin
            if m_btSex = 1 then begin //女
              if m_btHair = 1 then begin
                m_nCboHairOffset := 2000;
                m_nHairOffset := 600;
              end else begin
                 if m_btHair > 1{haircount-1} then m_btHair := 1{haircount-1};
                 m_btHair := m_btHair * 2;
                 if m_btHair > 1 then begin
                   m_nCboHairOffset := NEWHUMANFRAME * (m_btHair + m_btSex);
                   m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex);
                 end else begin
                   m_nCboHairOffset := -1;
                   m_nHairOffset := -1;
                 end;
              end;
            end else begin                 //男
              if m_btHair = 0 then begin
                m_nCboHairOffset := -1;
                m_nHairOffset := -1;
              end else begin
                 if m_btHair > 1{haircount-1} then m_btHair := 1{haircount-1};
                 m_btHair := m_btHair * 2;
                 if m_btHair > 1 then begin
                    m_nCboHairOffset := NEWHUMANFRAME * (m_btHair + m_btSex);
                    m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex);
                 end else begin
                   m_nHairOffset := -1;
                   m_nCboHairOffset := -1;
                 end;
              end;
            end;
          end;
        end;
        
        m_nWeaponOffset := HUMANFRAME * m_btWeapon;
        if m_nFeature.nWeaponLook <> High(m_nFeature.nWeaponLook) then begin
          if (m_nFeature.nWeaponLook > 2399) and (m_nFeature.nWeaponLookWil = 1) then begin
            m_nWeaponEffOffset := m_nFeature.nWeaponLook + m_btSex * HUMANFRAME;
            m_nCboWeaponEffOffset := (m_nWeaponEffOffset div HUMANFRAME2) * NEWHUMANFRAME2 - 16000 + m_btSex * NEWHUMANFRAME;
          end else begin
            m_nWeaponEffOffset := m_nFeature.nWeaponLook + m_btSex * HUMANFRAME;
            if m_nFeature.nWeaponLookWil <> 2 then
              m_nCboWeaponEffOffset := (m_nWeaponEffOffset div HUMANFRAME2) * NEWHUMANFRAME2 + 40000 + m_btSex * NEWHUMANFRAME;
          end;
        end;
        if m_btEffect = 50 then
          m_nHumWinOffset:=352
        else if m_nFeature.nDressLook <> High(m_nFeature.nDressLook) then begin
          if (m_nFeature.nDressLook > 4799) and (m_nFeature.nDressLookWil = 1) then begin
            m_nHumWinOffset := m_nFeature.nDressLook;
            m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME - 8) * NEWHUMANFRAME;
          end else begin
            m_nHumWinOffset := m_nFeature.nDressLook;
            case m_nFeature.nDressLookWil of
              0,3: m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME) * NEWHUMANFRAME;
              1,2: m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME) * NEWHUMANFRAME + 40000;
            end;
            {if m_nFeature.nDressLookWil = 0 then
              m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME) * NEWHUMANFRAME
            else m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME) * NEWHUMANFRAME + 40000; }
          end;
        end;
      end;    
      50: ;  //npc
      else begin
         m_wAppearance := m_nFeature.nDress; //APPRfeature (m_nFeature);
         m_nBodyOffset := GetOffset (m_wAppearance);
      end;
   end;
end;

function   TActor.Light: integer;
begin
   Result := m_nChrLight;
end;

//装载当前动作对应的图片
procedure  TActor.LoadSurface;
var
   mimg: TWMImages;
   nErrCode: Byte;
begin
  nErrCode := 0;
  try
    nErrCode := 1;
     mimg := GetMonImg (m_wAppearance);
     nErrCode := 2;
     if mimg <> nil then begin
        if (not m_boReverseFrame) then begin
          nErrCode := 3;
           m_BodySurface := mimg.GetCachedImage (GetOffset (m_wAppearance) + m_nCurrentFrame, m_nPx, m_nPy);
        end else begin
          nErrCode := 4;
           m_BodySurface := mimg.GetCachedImage (
                              GetOffset (m_wAppearance) + m_nEndFrame - (m_nCurrentFrame-m_nStartFrame),
                              m_nPx, m_nPy);

        end;
     end;
  except
    DebugOutStr(ForMat('TActor.LoadSurface Code: %d',[nErrCode]));
  end;
end;
//取角色的宽度
function  TActor.CharWidth: Integer;
begin
   if m_BodySurface <> nil then
      Result := m_BodySurface.Width
   else Result := 48;
end;
//取角色的高度
function  TActor.CharHeight: Integer;
begin
   if m_BodySurface <> nil then
      Result := m_BodySurface.Height
   else Result := 70;
end;
//判断某一点是否是角色的身体
function  TActor.CheckSelect (dx, dy: integer): Boolean;
var
  c:Integer;
begin
  Result := FALSE;
  if m_BodySurface <> nil then begin
    c := m_BodySurface.Pixels[dx, dy];
    if (c <> 0) and
       ((m_BodySurface.Pixels[dx-1, dy] <> 0) and
       (m_BodySurface.Pixels[dx+1, dy] <> 0) and
       (m_BodySurface.Pixels[dx, dy-1] <> 0) and
       (m_BodySurface.Pixels[dx, dy+1] <> 0)) then
     Result := TRUE;
  end;
end;

procedure TActor.DrawEffSurface (dsurface, source: TDirectDrawSurface; ddx, ddy: integer; blend: Boolean; ceff: TColorEffect);
var
  ErrorCode: Integer;
begin
  try
    //隐身
     ErrorCode := 0;
     if m_nState and $00800000 <> 0 then blend := TRUE;  //混合显示
     ErrorCode := 1;
     {if source.Height >= 350 then begin  //20080608 修正火龙教主引起的程序崩溃
       drawex(dsurface, ddx, ddy, source, 0, 0, source.Width, source.Height, 0);
       Exit; ////thedeath
     end;}
     ErrorCode := 2;
     if source <> nil then begin
       if not Blend then begin
          if ceff = ceNone then begin    //色彩无效果，以透明效果直接显示
                ErrorCode := 3;
                dsurface.Draw (ddx, ddy, source.ClientRect, source, TRUE);
                ErrorCode := 4;
          end else begin
                //生成颜色混合效果，再画出
                ErrorCode := 5;
                g_ImgMixSurface.SetSize(source.Width, source.Height);
                g_ImgMixSurface.Draw (0, 0, source.ClientRect, source, FALSE);
                ErrorCode := 6;
                DrawEffect (0, 0, g_ImgMixSurface, source, ceff);
                ErrorCode := 7;
                dsurface.Draw (ddx, ddy, source.ClientRect, g_ImgMixSurface, TRUE);
                ErrorCode := 8;
          end;
       end else begin
          if ceff = ceNone then begin
                ErrorCode := 9;
                //DrawBlend (dsurface, ddx, ddy, source, 0,120);
                dsurface.FastDrawAlpha(Bounds(ddx, ddy, Source.Width, Source.Height), Source.ClientRect, Source);
          end else begin
                ErrorCode := 10;
                g_ImgMixSurface.SetSize(source.Width, source.Height);
                g_ImgMixSurface.Fill(0);
                ErrorCode := 11;
                g_ImgMixSurface.Draw (0, 0, source.ClientRect, source, FALSE);
                ErrorCode := 12;
                DrawEffect (0, 0, g_ImgMixSurface, source, ceff);
                ErrorCode := 13;
                //DrawBlend (dsurface, ddx, ddy, g_ImgMixSurface, 0, 120);
                dsurface.FastDrawAlpha(Bounds(ddx, ddy, g_ImgMixSurface.Width, g_ImgMixSurface.Height), g_ImgMixSurface.ClientRect, g_ImgMixSurface);
                ErrorCode := 14;
          end;
       end;
     end;
  except
     on e: Exception do begin
       DebugOutStr('TActor.DrawEffSurface'+IntToStr(ErrorCode)+'    '+e.Message);
     end;
  end;
end;
//画武器闪烁光
procedure TActor.DrawWeaponGlimmer (dsurface: TDirectDrawSurface; ddx, ddy: integer);
//var
//   idx, ax, ay: integer;
//   d: TDirectDrawSurface;
begin
   //荤侩救窃..(堪拳搬) 弊贰侨 坷幅...
   (*if BoNextTimeFireHit and WarMode and GlimmingMode then begin
      if GetTickCount - GlimmerTime > 200 then begin
         GlimmerTime := GetTickCount;
         Inc (CurGlimmer);
         if CurGlimmer >= MaxGlimmer then CurGlimmer := 0;
      end;
      idx := GetEffectBase (5-1{堪拳搬馆娄烙}, 1) + Dir*10 + CurGlimmer;
      d := FrmMain.WMagic.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface, ddx + ax, ddy + ay, d, 1);
                          //dx + ax + ShiftX,
                          //dy + ay + ShiftY,
                          //d, 1);
   end;*)
end;
//根据当前状态state获得颜色效果（比如中毒状态等，人物显示的颜色就可能不同）
function TActor.GetDrawEffectValue: TColorEffect;
var
   ceff: TColorEffect;
begin
   ceff := ceNone;

   //高亮
   if (g_FocusCret = self) or (g_MagicTarget = self) then begin
     if m_wAppearance <> 242 then   //富贵兽
      ceff := ceBright;
   end;
   if m_nState and $1000000 <> 0 then begin //冰冻效果
     ceff := ceWhite;
   end;
   //中了绿毒
   if m_nState and $80000000 <> 0 then begin
      ceff := ceGreen;
   end;
   if m_nState and $40000000 <> 0 then begin
      ceff := ceRed;
   end;
   if (m_nState and $20000000 <> 0) or (m_nState and $00010000 <> 0) then begin
      ceff := ceBlue;
   end;
   { //此状态用在 雷炎蛛王 小网状态上了  20080812
   if m_nState and $10000000 <> 0 then begin
      ceff := ceYellow;
   end;}
   //付厚幅
   if m_nState and $08000000 <> 0 then begin
      ceff := ceFuchsia;
   end;
   if m_nState and $04000000 <> 0 then begin //麻痹
      ceff := ceGrayScale;
   end;
   if m_nState and $00080000 <> 0 then begin //唯我独尊
      ceff := ceGrayScale;
   end;
   Result := ceff;
end;
(*******************************************************************************
  作用 : 显示人自身动画  [通用类]      日期：2008.01.13
  过程 : DrawMyShow(dsurface: TDirectDrawSurface;dx,dy:integer);
  参数 : dsurface为画布；DX为X坐标； DY为Y坐标；
*******************************************************************************)
procedure TActor.DrawMyShow(dsurface: TDirectDrawSurface;dx,dy:integer);
var
  d:TDirectDrawSurface;
  img,ax,ay: integer;
  FlyX, FlyY: Integer;
begin
  if g_boIsMyShow then begin
    if GetTickCount - m_nMyShowTime >  m_nMyShowNextFrameTime{140} then begin
      m_nMyShowTime := GetTickCount;
      Inc(m_nMyShowFrame);
    end;
    //if g_boIsMyShow then begin
    if m_nMyShowFrame > m_nMyShowExplosionFrame then g_boIsMyShow := FALSE;
      img:= m_nMyShowStartFrame + m_nMyShowFrame;
      d := g_MagicBase.GetCachedImage(img,ax,ay);
      if not m_boNoChangeIsMyShow then begin//是否跟着人物动作变化而变化     20080306
        if d <> nil then
          DrawBlend (dsurface,dx+ ax + m_nShiftX,
                                 dy + ay + m_nShiftY,
                                 d, 120)
      end else begin
          PlayScene.ScreenXYfromMCXY (m_nNoChangeX, m_nNoChangeY, FlyX, FlyY);
          if d <> nil then
              DrawBlend (dsurface,FlyX+ ax  - UNITX div 2,
                                 FlyY + ay - UNITY div 2,
                                 d, 120);
      end;
  end;
    //end;
end;

{//飘血显示
procedure TActor.DrawAddBlood(dsurface: TDirectDrawSurface;dx, dy: Integer);
var
   BooldNum,jj,BooldIndex: Integer;
   d: TDirectDrawSurface;
   p,w:integer;
 function GetIndex(var Index:Integer):Integer;
 var
    s:String;
 begin
    s:=Inttostr(Index);
    Result:=StrToInt(S[1])+5;
    Delete(s,1,1);
    if s<>'' then
     Index:=Strtoint(s)
    else
     Index:=-1;
 end;
begin
  if g_boShowMoveRedHp then begin
    if IsAddBlood then begin
      if GetTickCount - AddBloodTime >  1000 then IsAddBlood := False;
      if GetTickCount - AddBloodStartTime > 40 then begin
        Inc(AddBloodFram);
        AddBloodStartTime := GetTickCount;
      end;
    end;
      //加减血显示

      if IsAddBlood then begin
         BooldNum := abs(AddBloodNum);//BooldNum等于人少的血
         jj:=1;
         if Self=g_Myself then w := 12 else w := 8;
         if AddBloodnum > 0 then
           d := g_qingqingImages.Images[16]
         else
           d := g_qingqingImages.Images[15];

           if d <> nil then
            dsurface.Draw(m_nSayX - d.Width div 2+AddBloodFram*(2), dy + m_nhpy + m_nShiftY - 10-AddBloodFram*(2), d.ClientRect, d, True);
         while BooldNum >= 0 do begin
           BooldIndex := GetIndex(BooldNum);//取出图片
           d := g_qingqingImages.Images[BooldIndex];
           if d <> nil then
            dsurface.Draw(m_nSayX - d.Width div 2 + AddBloodFram * (2) + jj * w, dy + m_nhpy + m_nShiftY - 10 - AddBloodFram * (2), d.ClientRect, d, True);
           Inc(jj);
         end;
      end;
  end;
end;  }
//显示角色
procedure TActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
   ErrorCode: Integer;
begin
  try
    ErrorCode := 0;
    d:=nil;
    //if not (m_btDir in [0..7]) then Exit;
    if m_btDir > 7 then Exit;
    ErrorCode := 1;
    if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
       m_dwLoadSurfaceTime := GetTickCount;
       LoadSurface; //由于图片每60秒会释放一次（60秒内未使用的话），所以每60秒要检查一下是否已经被释放了.
    end;
    ErrorCode := 2;
    ceff := GetDrawEffectValue;
    ErrorCode := 3;
    if m_BodySurface <> nil then begin
       DrawEffSurface (dsurface,
                      m_BodySurface,
                      dx + m_nPx + m_nShiftX,
                      dy + m_nPy + m_nShiftY,
                      blend,
                      ceff);
    end;
    ErrorCode := 5;
    DrawMyShow(dsurface,dx,dy); //显示自身动画
    ErrorCode := 6;
    if not m_boDeath then begin  //死亡不显示
      if m_nState and $02000000 <> 0 then begin //万剑归宗击中状态
          idx := 4010 + (m_nGenAniCount mod 8);
          d := g_WCboEffectImages.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
      end;
      if m_nState and $00004000 <> 0 then begin //定身状态
          idx := 1080 + (m_nGenAniCount mod 8);
          d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
      end;
    end;
    if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then begin
       if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
          GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx, m_btDir, m_CurMagic.EffectLevelEx);
          idx := idx + m_nCurEffFrame;
          if wimg <> nil then
             d := wimg.GetCachedImage (idx, ax, ay);
          if d <> nil then
             DrawBlend (dsurface,
                             dx + ax + m_nShiftX,
                             dy + ay + m_nShiftY,
                             d, 120);
       end;
    end;
    ErrorCode := 7;
   except
    DebugOutStr('TActor.DrawChr:'+IntToStr(ErrorCode));
   end;
end; 

procedure  TActor.DrawEff (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
end;

procedure  TActor.DrawStall (dsurface: TDirectDrawSurface; dx, dy: integer);
begin
end;

//缺省帧
function  TActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf: integer;
   pm: PTMonsterAction;
begin
   Result:=0;
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   if m_boDeath then begin            //死亡
      if m_boSkeleton then            //地上尸体骷髅
         Result := pm.ActDeath.start
      else Result := pm.ActDie.start + m_btDir * (pm.ActDie.frame + pm.ActDie.skip) + (pm.ActDie.frame - 1);
   end else begin
      m_nDefFrameCount := pm.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
        else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
        else cf := m_nCurrentDefFrame;
      Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
   end;
end;
//默认运动
procedure TActor.DefaultMotion;   //缺省动作
begin
   m_boReverseFrame := FALSE;
   m_boCboMode := False;
   if m_boWarMode then begin
      if (GetTickCount - m_dwWarModeTime > 4000) then //and not BoNextTimeFireHit then
         m_boWarMode := FALSE;
   end;
   m_nCurrentFrame := GetDefaultFrame (m_boWarMode);
   Shift (m_btDir, 0, 1, 1);
end;

//人物动作声音(脚步声、武器攻击声)
procedure TActor.SetSound;
var
   cx, cy, bidx, wunit, attackweapon: integer;
   hiter: TActor;
begin
   if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150){人类,英雄,人型20080629} then begin              //人类玩家
      if (self = g_MySelf) and             //基本动作
         ((m_nCurrentAction=SM_WALK) or
          (m_nCurrentAction=SM_BACKSTEP) or
          (m_nCurrentAction=SM_RUN) or
          //(m_nCurrentAction=SM_HORSERUN) or  20080803注释骑马消息
          (m_nCurrentAction=SM_RUSH) or
          (m_nCurrentAction=SM_RUSHKUNG)
         )
      then begin
         cx := g_MySelf.m_nCurrX - Map.m_nBlockLeft;
         cy := g_MySelf.m_nCurrY - Map.m_nBlockTop;
         cx := cx div 2 * 2;
         cy := cy div 2 * 2;
         bidx := Map.m_MArr[cx, cy].wBkImg and $7FFF;
         wunit := Map.m_MArr[cx, cy].btArea;
         bidx := wunit * 10000 + bidx - 1;
         case bidx of
            330..349, 450..454, 550..554, 750..754,
            950..954, 1250..1254, 1400..1424, 1455..1474,
            1500..1524, 1550..1574:
               m_nFootStepSound := s_walk_lawn_l;  //草地上行走
               
            250..254, 1005..1009, 1050..1054, 1060..1064, 1450..1454,
            1650..1654:
               m_nFootStepSound := s_walk_rough_l; //粗糙的地面

            605..609, 650..654, 660..664, 2000..2049,
            3025..3049, 2400..2424, 4625..4649, 4675..4678:
               m_nFootStepSound := s_walk_stone_l;  //石头地面上行走

            1825..1924, 2150..2174, 3075..3099, 3325..3349,
            3375..3399:
               m_nFootStepSound := s_walk_cave_l;  //洞穴里行走

           3230, 3231, 3246, 3277:
               m_nFootStepSound := s_walk_wood_l;  //木头地面行走

           //带傈..
           3780..3799:
               m_nFootStepSound := s_walk_wood_l;

           3825..4434:
               if (bidx-3825) mod 25 = 0 then m_nFootStepSound := s_walk_wood_l
               else m_nFootStepSound := s_walk_ground_l;

             2075..2099, 2125..2149:
               m_nFootStepSound := s_walk_room_l;   //房间里

            1800..1824:
               m_nFootStepSound := s_walk_water_l;  //水中

            else
               m_nFootStepSound := s_walk_ground_l;
         end;
         //泵傈郴何
         if (bidx >= 825) and (bidx <= 1349) then begin
            if ((bidx-825) div 25) mod 2 = 0 then
               m_nFootStepSound := s_walk_stone_l;
         end;
         //悼奔郴何
         if (bidx >= 1375) and (bidx <= 1799) then begin
            if ((bidx-1375) div 25) mod 2 = 0 then
               m_nFootStepSound := s_walk_cave_l;
         end;
         case bidx of
            1385, 1386, 1391, 1392:
               m_nFootStepSound := s_walk_wood_l;
         end;

         bidx := Map.m_MArr[cx, cy].wMidImg and $7FFF;   //检查地图属性
         bidx := bidx - 1;
         case bidx of
            0..115:
               m_nFootStepSound := s_walk_ground_l;
            120..124:
               m_nFootStepSound := s_walk_lawn_l;
         end;

         bidx := Map.m_MArr[cx, cy].wFrImg and $7FFF;
         bidx := bidx - 1;
         case bidx of
            221..289, 583..658, 1183..1206, 7163..7295,
            7404..7414:
               m_nFootStepSound := s_walk_stone_l;
            3125..3267, {3319..3345, 3376..3433,} 3757..3948,
            6030..6999:
               m_nFootStepSound := s_walk_wood_l;
            3316..3589:
               m_nFootStepSound := s_walk_room_l;
         end;
         if (m_nCurrentAction = SM_RUN){ or (m_nCurrentAction = SM_HORSERUN)20080803注释骑马消息 }then
            m_nFootStepSound := m_nFootStepSound + 2;
      end;

      if m_btSex = 0 then begin //男
         m_nScreamSound := s_man_struck;
         m_nDieSound := s_man_die;
      end else begin //女
         m_nScreamSound := s_wom_struck;
         m_nDieSound := s_wom_die;
      end;

      case m_nCurrentAction of      //攻击动作
         SM_THROW, SM_HIT, SM_HIT+1, SM_HIT+2, SM_POWERHIT, SM_HIT_107,
         {$IF M2Version <> 2}SM_LONGHITFORFENGHAO,SM_FIREHITFORFENGHAO,SM_DAILYFORFENGHAO,{$IFEND}
         SM_LONGHIT, SM_LONGHIT4, SM_WIDEHIT, CM_WIDEHIT4, SM_FIREHIT{烈火},
         SM_BLOODSOUL{血魄一击(战)}, SM_DAILY{逐日剑法}, SM_4FIREHIT{4级烈火},
         SM_CRSHIT, SM_TWINHIT{开天斩重击}, SM_QTWINHIT{开天斩轻击}, SM_CIDHIT{龙影剑法},
         SM_LEITINGHIT{雷霆一击战士效果 20080611}, SM_BATTERHIT1,SM_BATTERHIT2,SM_BATTERHIT3,SM_BATTERHIT4,
         SM_DAILYEX1..SM_DAILYEX3, SM_FIREHITEX1..SM_FIREHITEX3,
         SM_WIDEHIT4EX1..SM_WIDEHIT4EX3, SM_POWERHITEX1..SM_POWERHITEX3,
         SM_LONGHITEX1..SM_LONGHITEX3:
            begin
               case (m_btWeapon div 2) of
                  6, 20:  m_nWeaponSound := s_hit_short;
                  1:  m_nWeaponSound := s_hit_wooden;
                  2, 13, 9, 5, 14, 22:  m_nWeaponSound := s_hit_sword;
                  4, 17, 10, 15, 16, 23:  m_nWeaponSound := s_hit_do;
                  3, 7, 11:  m_nWeaponSound := s_hit_axe;
                  24:  m_nWeaponSound := s_hit_club;
                  8, 12, 18, 21:  m_nWeaponSound := s_hit_long;
                  else m_nWeaponSound := s_hit_fist;
               end;
            end;
         SM_STRUCK: //受攻击
            begin
               if m_nMagicStruckSound >= 1 then begin
                  //strucksound := s_struck_magic;
               end else begin
                  hiter := PlayScene.FindActor (m_nHiterCode);
                  //attackweapon := 0;
                  if hiter <> nil then begin
                     attackweapon := hiter.m_btWeapon div 2;
                     if (hiter.m_btRace = 0) or (hiter.m_btRace = 1) or (hiter.m_btRace = 150) then //人类,英雄,人型20080629
                        case (m_btDress div 2) of
                           3:
                              case attackweapon of
                                 6:  m_nStruckSound := s_struck_armor_sword;
                                 1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_armor_sword;
                                 3,7,11: m_nStruckSound := s_struck_armor_axe;
                                 8,12,18: m_nStruckSound := s_struck_armor_longstick;
                                 else m_nStruckSound := s_struck_armor_fist;
                              end;
                           else
                              case attackweapon of
                                 6: m_nStruckSound := s_struck_body_sword;
                                 1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_body_sword;
                                 3,7,11: m_nStruckSound := s_struck_body_axe;
                                 8,12,18: m_nStruckSound := s_struck_body_longstick;
                                 else m_nStruckSound := s_struck_body_fist;
                              end;
                        end;
                  end;
               end;
            end;
      end;


      if m_boUseMagic and (m_CurMagic.MagicSerial > 0) then begin
        case m_CurMagic.MagicSerial of  //MagicSerial为魔法ID 20080302
          41: m_nMagicStartSound := 10430;//狮子吼  20080314
          44: begin //寒冰掌
            m_nMagicStartSound := 10000 + (m_CurMagic.MagicSerial-5) * 10;
            m_nMagicFireSound := 10000 + (m_CurMagic.MagicSerial-5) + 1;
            m_nMagicExplosionSound := 10000 + (m_CurMagic.MagicSerial-5) * 10 + 2;
          end;
          45: begin //灭天火
            m_nMagicStartSound := 10000 + (m_CurMagic.MagicSerial-10) * 10;
            m_nMagicExplosionSound := 10000 + (m_CurMagic.MagicSerial-10) + 2;
          end;
          48: begin
            m_nMagicStartSound := 10370;  //气功波 20080321
            m_nMagicExplosionSound := 0;
          end;
          50: begin
            m_nMagicStartSound := 10360;//无极真气  20080314
            m_nMagicExplosionSound := 0;
          end;
          59,94: begin //噬血术,4级噬血术 20080511
            m_nMagicStartSound := 10480;
            m_nMagicExplosionSound := 10482;
          end;
          62: begin//雷霆一击 20080405
              m_nMagicStartSound := 10520;
              m_nMagicExplosionSound := 10522;
          end;
          63: begin  //噬魂沼泽 20080405
              m_nMagicStartSound := 10530;
              m_nMagicExplosionSound := 10532;
          end;
          64: begin  //末日审判 20080405
              m_nMagicStartSound := 10540;
              m_nMagicExplosionSound := 10542;
          end;
          65: begin  //火龙气焰 20080405
              m_nMagicStartSound := 10550;
              m_nMagicExplosionSound := 10552;
          end;
          66: begin //4级魔法盾
            m_nMagicStartSound := 10310;
            m_nMagicFireSound := 10311;
            m_nMagicExplosionSound := 10312;
          end;
          71: begin //召唤圣兽
            m_nMagicStartSound := 10300;
            m_nMagicFireSound := 10301;
            m_nMagicExplosionSound := 10302;
          end;
          72: begin //召唤月灵
            m_nMagicStartSound := 10410;
            m_nMagicFireSound := 0;
            m_nMagicExplosionSound := 0;
          end;
          91: begin //4级雷电术
            m_nMagicStartSound := 10110;
            m_nMagicFireSound := 10111;
            m_nMagicExplosionSound := 10112;
          end;
          93: begin //4级施毒术
            m_nMagicStartSound := 10060;
            m_nMagicFireSound := 10061;
            m_nMagicExplosionSound := 10062;
          end;
          97: begin  //血魄一击(法)
            m_nMagicStartSound := 10550;
            m_nMagicFireSound := 0;
            m_nMagicExplosionSound := 8207;
          end;
          98: begin  //血魄一击(道)
            m_nMagicStartSound := 10540;
            m_nMagicFireSound := 0;
            m_nMagicExplosionSound := 8206;
          end;
          113: begin //天雷乱舞
            m_nMagicStartSound := 10110;
            m_nMagicFireSound := 10111;
            m_nMagicExplosionSound := 10112;
          end;
        else begin
           m_nMagicStartSound := 10000 + m_CurMagic.MagicSerial * 10;
           m_nMagicFireSound := 10000 + m_CurMagic.MagicSerial * 10 + 1;
           m_nMagicExplosionSound := 10000 + m_CurMagic.MagicSerial * 10 + 2;
          end;
        end;
      end;

   end else begin
      if m_nCurrentAction = SM_STRUCK then begin //受攻击
         if m_nMagicStruckSound >= 1 then begin
            //strucksound := s_struck_magic;
         end else begin
            hiter := PlayScene.FindActor (m_nHiterCode);
            if hiter <> nil then begin
               attackweapon := hiter.m_btWeapon div 2;
               case attackweapon of
                  6: m_nStruckSound := s_struck_body_sword;
                  1,2,4,5,9,10,13,14,15,16,17: m_nStruckSound := s_struck_body_sword;
                  3,11: m_nStruckSound := s_struck_body_axe;
                  8,12,18: m_nStruckSound := s_struck_body_longstick;
                  101: m_nStruckSound := 492; //富贵兽
                  else m_nStruckSound := s_struck_body_fist;
               end;
            end;
         end;
      end;

      if m_btRace <> 50 then begin
        case m_wAppearance of
          242: begin //富贵兽
            m_nAppearSound := 0;
            m_nNormalSound := 0;
            m_nAttackSound := 211;
            m_nWeaponSound := 0;
            m_nScreamSound := 215;
            m_nDieSound := 200 + (m_wAppearance) * 10 + 5;
            m_nDie2Sound := 200 + (m_wAppearance) * 10 + 6;
          end;
          250: begin //雪域战将
            m_nAttackSound := -1;
            m_nWeaponSound := 10512;
          end;
          251: begin //雪域侍卫
            m_nAttackSound := -1;
          end;
          255: begin //雪域天将
            m_nAttackSound := -1;
            m_nWeaponSound := 10192;
          end;
          256: begin //雪域魔王
            m_nAttackSound := -1;
          end;
          263: begin //雪域卫士
            m_nAttackSound := -1;
            m_nWeaponSound := 2833;
            m_nScreamSound := 2834;
            m_nDieSound := 2835;
            m_nDie2Sound := 2836;
          end;
          272,273: begin //圣兽
            m_nAppearSound := 1910;
            m_nNormalSound := 1911;
            m_nAttackSound := 1912;
            m_nWeaponSound := 1913;
            m_nScreamSound := 1914;
            m_nDieSound := 1915;
            m_nDie2Sound := 1916;
          end;
          else begin
            m_nAppearSound := 200 + (m_wAppearance) * 10;
            m_nNormalSound := 200 + (m_wAppearance) * 10 + 1;
            m_nAttackSound := 200 + (m_wAppearance) * 10 + 2;
            m_nWeaponSound := 200 + (m_wAppearance) * 10 + 3;
            m_nScreamSound := 200 + (m_wAppearance) * 10 + 4;
            if m_btRace = 108 then
              m_nDieSound := 1925 //月灵死亡声音  20080302
            else m_nDieSound := 200 + (m_wAppearance) * 10 + 5;
            m_nDie2Sound := 200 + (m_wAppearance) * 10 + 6;
          end;
        end;
      end;
   end;


   if m_nCurrentAction = SM_STRUCK then begin  //受攻击
      hiter := PlayScene.FindActor (m_nHiterCode);
      //attackweapon := 0;
      if hiter <> nil then begin
         attackweapon := hiter.m_btWeapon div 2;
         if hiter.m_btRace in [0,1,150] then //人类,英雄,人型20080629
            case (attackweapon div 2) of
               6, 20:  m_nStruckWeaponSound := s_struck_short;
               1:  m_nStruckWeaponSound := s_struck_wooden;
               2, 13, 9, 5, 14, 22:  m_nStruckWeaponSound := s_struck_sword;
               4, 17, 10, 15, 16, 23:  m_nStruckWeaponSound := s_struck_do;
               3, 7, 11:  m_nStruckWeaponSound := s_struck_axe;
               24:  m_nStruckWeaponSound := s_struck_club;
               8, 12, 18, 21:  m_nStruckWeaponSound := s_struck_wooden; //long;
               //else struckweaponsound := s_struck_fist;
            end;
            if m_btRace = 101 then m_nStruckSound := 492;  //富贵兽
      end;
   end;

end;

//播放动作声效
procedure  TActor.RunSound;
begin
   m_boRunSound := TRUE;
   SetSound;
   case m_nCurrentAction of
      SM_STRUCK:  //被攻击
         begin
            if (m_nStruckWeaponSound >= 0) then PlaySound (m_nStruckWeaponSound); //攻击的武器的声效
            if (m_nStruckSound >= 0) then PlaySound (m_nStruckSound);             //被攻击的声效
            case m_wAppearance of
              250: MyPlaySound (sbz_injured_ground);//雪域战将
              251: MyPlaySound (cqsbz_injured_ground); //雪域侍卫
              255: MyplaySound (xsls_injured_ground); //雪域天将
              256: MyPlaySound (bq_injured_ground);  //雪域魔王
              263: MyPlaySound (xsws_injured_ground); //雪域卫士
              else if (m_nScreamSound >= 0) then PlaySound (m_nScreamSound);              //尖叫
            end;
         end;
      SM_NOWDEATH:
         begin
            case m_wAppearance of
              250: MyPlaySound (byjm_injured_ground); //雪域战将
              255: MyPlaySound (xsls_death_ground); //雪域天将
              256: MyPlaySound (bq_death_ground); //雪域魔王
              263: MyPlaySound (xsws_death_ground); //雪域卫士
              else if (m_nDieSound >= 0) then PlaySound (m_nDieSound);
            end;
         end;
      SM_THROW, SM_HIT, SM_FLYAXE, SM_LIGHTING, SM_DIGDOWN, SM_HIT_107:
         begin
           case m_wAppearance of
             250: begin //雪域战将
               if m_nCurrentAction = SM_HIT then MyPlaySound(sbz_tsgj_ground)
               else if m_nWeaponSound >= 0 then PlaySound(m_nWeaponSound);
             end;
             251: MyPlaySound(cqsbz_tsgj_ground); //雪域侍卫
             255: begin  //雪域天将
               if m_nCurrentAction = SM_HIT then MyPlaySound(cqsbz_tsgj_ground)
               else if m_nWeaponSound >= 0 then PlaySound(m_nWeaponSound);
             end;
             256: MyPlaySound(x60182_ground); //雪域魔王
             263: MyPlaySound(xsws_tsgj_ground); //雪域卫士
           else if m_nAttackSound >= 0 then PlaySound (m_nAttackSound);
           end;
         end;
      SM_ALIVE, SM_DIGUP{殿厘,巩凯覆}:
         begin
           case m_wAppearance of
             263: MyPlaySound (xsws_pbec_ground); //雪域卫士
           else PlaySound (m_nAppearSound);
           end;
         end;
      SM_SPELL:
         begin
            case m_CurMagic.MagicSerial of
              58, 70, 92, 108: MyPlaySound ('wav\M58-0.wav'); //漫天火雨声音 20080511
              60: PHHitSound(1); //破魂合击声音
              61: PHHitSound(2); //劈星斩声音
              75: MyPlaySound (heroshield_ground); //护体神盾声音
              77: MyPlaySound ('wav\cboFs1_start.wav'); //双龙破
              78: MyPlaySound ('wav\cboDs1_start.wav'); //虎啸诀
              80: MyPlaySound ('wav\cboFs2_start.wav'); //凤舞祭
              81: MyPlaySound ('wav\cboDs2_start.wav'); //八卦掌
              83: MyPlaySound ('wav\cboFs3_start.wav'); //惊雷爆
              84: MyPlaySound ('wav\cboDs3_start.wav'); //三焰咒
              86: MyPlaySound ('wav\cboFs4_start.wav'); //冰天雪地
              87: MyPlaySound ('wav\cboDs4_start.wav'); //万剑归宗
              else PlaySound (m_nMagicStartSound);
            end;
         end;
   end;
end;

procedure  TActor.RunActSound (frame: integer);
begin
   if m_boRunSound then begin     //需要播放声效
      if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then begin  //人类,英雄,人型20080629
         case m_nCurrentAction of
            SM_THROW, SM_HIT, SM_HIT_107, SM_HIT+1, SM_HIT+2:    //扔、击
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  m_boRunSound := FALSE; //声效已经播放
               end;
            SM_POWERHIT, SM_POWERHITEX1..SM_POWERHITEX3:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  //播放人物的声音
                  if m_btSex = 0 then PlaySound (s_yedo_man)
                  else PlaySound (s_yedo_woman);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_LONGHIT, {$IF M2Version <> 2}SM_LONGHITFORFENGHAO,{$IFEND}SM_LONGHIT4,
            SM_LONGHITEX1..SM_LONGHITEX3:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_longhit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_WIDEHIT, SM_WIDEHIT4, SM_WIDEHIT4EX1..SM_WIDEHIT4EX3:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_widehit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            {$IF M2Version <> 2}SM_FIREHITFORFENGHAO, {$IFEND}SM_FIREHIT{烈火}, SM_4FIREHIT{4级烈火}, SM_FIREHITEX1..SM_FIREHITEX3:
               if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit);
                  m_boRunSound := FALSE; //茄锅父 家府晨
               end;
            SM_CRSHIT:
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (s_firehit); //Damian
                  m_boRunSound := FALSE; //茄锅父 家府晨
              end;
            SM_TWINHIT: //开天斩 重击
              if frame = 2 then begin
                PlaySound (m_nWeaponSound);
                MyPlaySound (longswordhit_ground);
                m_boRunSound := FALSE;
              end;
            SM_QTWINHIT: //开天斩 轻击
              if frame = 2 then begin
                PlaySound (m_nWeaponSound);
                MyPlaySound (longswordhit_ground);
                m_boRunSound := FALSE;
              end;
            {$IF M2Version <> 2}SM_DAILYFORFENGHAO,{$IFEND}SM_DAILY,
            SM_DAILYEX1..SM_DAILYEX3: //逐日剑法 20080511
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  if m_btSex = 0 then MyPlaySound ('wav\M56-0.wav')
                  else MyPlaySound ('wav\M56-3.wav'); //女
                  m_boRunSound := FALSE;
              end;
            SM_BLOODSOUL: //血魄一击(战)  临时声音，没听到盛大是什么声音
              if frame = 2 then begin
                PlaySound (m_nWeaponSound);
                MyPlaySound('wav\8220-2.wav');
                m_boRunSound := False;
              end;
            SM_CIDHIT://龙影剑法
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  PlaySound (142); //20080403
                  m_boRunSound := False;
              end;
           SM_BATTERHIT1://追心刺
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  MyPlaySound(cboZs2_start);
                  m_boRunSound := False;
              end;
           SM_BATTERHIT2://三绝杀
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  if m_btSex = 0 then MyPlaySound (cboZs1_start_m)
                  else MyPlaySound (cboZs1_start_w); //女
                  m_boRunSound := False;
              end;
           SM_BATTERHIT3://横扫千军
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  MyPlaySound(cboZs4_start);
                  m_boRunSound := False;
              end;
           SM_BATTERHIT4://断岳斩
              if frame = 2 then begin
                  //PlaySound (m_nWeaponSound);
                  {if m_btSex = 0 then MyPlaySound (cboZs3_start_m)
                  else MyPlaySound (cboZs3_start_w); //女  }
                  MyPlaySound (cboZs7_start);
                  m_boRunSound := False;
              end;
           {SM_69HIT:   //倚天霹雳
              if frame = 2 then begin
                  PlaySound (m_nWeaponSound);
                  if m_btSex = 0 then MyPlaySound (cboZs3_start_m)
                  else MyPlaySound (cboZs3_start_w); //女  
                  m_boRunSound := False;
              end; }
         end;
      end else begin
         {if m_btRace = 50 then begin  //20080803修改
         end else begin}
          if m_btRace <> 50 then begin
            if (m_nCurrentAction = SM_WALK) or (m_nCurrentAction = SM_TURN) then begin
               if (frame = 1) and (Random(8) = 1) then begin
                  PlaySound (m_nNormalSound);
                  m_boRunSound := FALSE;
               end;
            end;
            if (m_nCurrentAction = SM_HIT) or (m_nCurrentAction = SM_HIT_107) then begin
               if (frame = 3) and (m_nAttackSound >= 0) then begin
                  PlaySound (m_nWeaponSound);
                  m_boRunSound := FALSE;
               end;
            end;
            { //20080803修改
            case m_wAppearance of
               80: begin
                  if m_nCurrentAction = SM_NOWDEATH then begin
                     if (frame = 2) then begin
                        PlaySound (m_nDie2Sound);
                        m_boRunSound := FALSE;
                     end;
                  end;
               end;
            end; }
            if m_wAppearance = 80 then begin
               if (m_nCurrentAction = SM_NOWDEATH) and (frame = 2) then begin
                 PlaySound (m_nDie2Sound);
                 m_boRunSound := FALSE;
               end;
            end;
         end;
      end;
   end;
end;

procedure  TActor.RunFrameAction (frame: integer);
begin
end;

procedure  TActor.ActionEnded;
begin
end;

procedure TActor.Run;
   function MagicTimeOut: Boolean;
   begin
      if self = g_MySelf then begin
         Result := GetTickCount - m_dwWaitMagicRequest > 3000;
      end else
         Result := GetTickCount - m_dwWaitMagicRequest > 2000;
      if Result then m_CurMagic.ServerMagicCode := 0;
   end;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   bofly: Boolean;
   nCode: Byte;
begin
  nCode:= 0;
  try
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //林贱狼阜 殿... 局聪皋捞记 瓤苞
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
   end;
   nCode:= 1;
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      //(m_nCurrentAction = SM_HORSERUN) or 20080803注释骑马消息
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then Exit;
   nCode:= 2;
   m_boMsgMuch := FALSE;
   if self <> g_MySelf then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;
   nCode:= 3;
   //声音效果
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   nCode:= 4;
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);

   nCode:= 5;
   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin  //动作不为空
      nCode:= 6;
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;
      nCode:= 7;
      if (self <> g_MySelf) and (m_boUseMagic) then begin
         m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
      end else begin
         if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
         else m_dwFrameTimetime := m_dwFrameTime;
      end;
      nCode:= 8;
      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
           nCode:= 9;
            if m_boUseMagic then begin
               if (m_nCurEffFrame = m_nSpellFrame-2) or (MagicTimeOut) then begin
                  if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin
                     Inc (m_nCurrentFrame);
                     Inc(m_nCurEffFrame);
                     m_dwStartTime := GetTickCount;
                  end;
               end else begin
                  if m_nCurrentFrame < m_nEndFrame - 1 then Inc (m_nCurrentFrame);
                  Inc (m_nCurEffFrame);
                  m_dwStartTime := GetTickCount;
               end;
            end else begin
               Inc (m_nCurrentFrame);
               m_dwStartTime := GetTickCount;
            end;
         end else begin
           nCode:= 10;
            if m_boDelActionAfterFinished then begin
               m_boDelActor := TRUE;
            end;
            nCode:= 11;
            if self = g_MySelf then begin  
               if FrmMain.ServerAcceptNextAction then begin
                  nCode:= 12;
                  ActionEnded;
                  m_nCurrentAction := 0;
                  m_boUseMagic := FALSE;
               end;
            end else begin
               nCode:= 13;
               ActionEnded;
               m_nCurrentAction := 0;
               m_boUseMagic := FALSE;
            end;
         end;
         nCode:= 14;
         if m_boUseMagic then begin
            if m_nCurEffFrame = m_nSpellFrame-1 then begin
               nCode:= 15;
               if m_CurMagic.ServerMagicCode > 0 then begin
                  with m_CurMagic do
                     PlayScene.NewMagic (self,
                                      ServerMagicCode,
                                      EffectNumber, //Effect
                                      m_nCurrX,
                                      m_nCurrY,
                                      TargX,
                                      TargY,
                                      Target,
                                      EffectType, //EffectType
                                      Recusion,
                                      AniTime,
                                      EffectLevelEx,
                                      bofly);
                  nCode:= 16;
                  if bofly then
                    case m_CurMagic.EffectNumber of
                      42: MyPlaySound ('wav\splitshadow.wav'); //分身术
                      else PlaySound (m_nMagicFireSound);
                    end
                  else begin
                    case m_CurMagic.EffectNumber of
                      51, 130: MyPlaySound ('wav\M58-3.wav'); //漫天火雨声音 20080511
                      55: begin
                        PlaySound (m_nWeaponSound);
                        if m_btSex = 0 then MyPlaySound (cboZs3_start_m)
                        else MyPlaySound (cboZs3_start_w); //女
                        m_boRunSound := False;
                      end;
                      else PlaySound (m_nMagicExplosionSound);
                    end;
                  end;
               end;
               //LatestSpellTime := GetTickCount;
               m_CurMagic.ServerMagicCode := 0;
            end;
         end;
      end;
      nCode:= 17;
      if (m_wAppearance = 0) or (m_wAppearance = 1) or (m_wAppearance = 43) then m_nCurrentDefFrame := -10
      else m_nCurrentDefFrame := 0;
      m_dwDefFrameTime := GetTickCount;
   end else begin    //动作为空
      nCode:= 18;
      if (m_btRace = 50) and (m_wAppearance in [54..58]) then begin   //雪域NPC 20081229
         if GetTickCount - m_dwDefFrameTime > m_dwFrameTime then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then m_nCurrentDefFrame := 0;
         end;
         nCode:= 19;
         DefaultMotion;
      end else begin
        nCode:= 20;
        if GetTickCount - m_dwSmoothMoveTime > 200 then begin
           if GetTickCount - m_dwDefFrameTime > 500 then begin
              m_dwDefFrameTime := GetTickCount;
              Inc (m_nCurrentDefFrame);
              if m_nCurrentDefFrame >= m_nDefFrameCount then m_nCurrentDefFrame := 0;
           end;
           nCode:= 21;
           DefaultMotion;
        end;
      end;
   end;
   nCode:= 22;
   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      nCode:= 23;
      LoadSurface;
   end;
  except
    DebugOutStr(Format('TActor.Run m_btRace:%d Code:%d',[m_btRace, nCode]));
  end;
end;

//根据当前动作和状态计算下一个动作对应的帧
function  TActor.Move (step: integer): Boolean;
var
   prv, curstep, maxstep: integer;
   Fastmove, normmove: Boolean;
   ErrCode: Integer;
begin
  ErrCode := 0;
  try
    Result := FALSE;
    fastmove := FALSE;
    normmove := FALSE;
    if (m_nCurrentAction = SM_BACKSTEP) then //or (CurrentAction = SM_RUSH) or (CurrentAction = SM_RUSHKUNG) then
      Fastmove := TRUE;
    if (m_nCurrentAction = SM_RUSH) {or (m_nCurrentAction = SM_RUSH79)} or (m_nCurrentAction = SM_RUSHKUNG) then
      normmove := TRUE;
    ErrCode := 1;
    if (self = g_MySelf) and (not fastmove) and (not normmove) then begin
      //g_boMoveSlow := FALSE;  20080816注释掉起步负重
      //g_boAttackSlow := FALSE; //20080816 注释 腕力不足
      //20080816注释掉起步负重
      //g_nMoveSlowLevel := 0;
      {//超重跑步
      if m_Abil.Weight > m_Abil.MaxWeight then begin
         g_nMoveSlowLevel := m_Abil.Weight div m_Abil.MaxWeight;
         g_boMoveSlow := TRUE;
      end;
      if m_Abil.WearWeight > m_Abil.MaxWearWeight then begin
         g_nMoveSlowLevel := g_nMoveSlowLevel + m_Abil.WearWeight div m_Abil.MaxWearWeight;
         g_boMoveSlow := TRUE;
      end;
      if m_Abil.HandWeight > m_Abil.MaxHandWeight then begin
         g_boAttackSlow := TRUE
      end;
      //免负重
      if g_boMoveSlow and (m_nSkipTick < g_nMoveSlowLevel) and (not g_boMoveSlow1) then begin

         Inc (m_nSkipTick);
         exit;
      end else begin }
         //m_nSkipTick := 0;
      //end;
      //走动的声音
      if (m_nCurrentAction = SM_WALK) or
         (m_nCurrentAction = SM_BACKSTEP) or
         (m_nCurrentAction = SM_RUN) or
         //(m_nCurrentAction = SM_HORSERUN) or  20080803注释骑马消息
         (m_nCurrentAction = SM_RUSH) or
         (m_nCurrentAction = SM_RUSHKUNG)
      then begin
         ErrCode := 2;
         case (m_nCurrentFrame - m_nStartFrame) of
            1: PlaySound (m_nFootStepSound);
            4: PlaySound (m_nFootStepSound + 1);
         end;
      end;
    end;

    Result := FALSE;
    m_boMsgMuch := FALSE;
    ErrCode := 3;
    if (self <> g_MySelf) and (m_MsgList <> nil) then begin
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
    end;
    prv := m_nCurrentFrame;
    //移动
    if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_RUN) or
      //(m_nCurrentAction = SM_HORSERUN) or 20080803注释骑马消息
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
    then begin
     //调整当前帧
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then begin
         m_nCurrentFrame := m_nStartFrame - 1;
      end;
      if m_nCurrentFrame < m_nEndFrame then begin
         Inc (m_nCurrentFrame);

         if m_boMsgMuch and not normmove then //加快步伐
            if m_nCurrentFrame < m_nEndFrame then
               Inc (m_nCurrentFrame);

         curstep := m_nCurrentFrame-m_nStartFrame + 1;
         maxstep := m_nEndFrame-m_nStartFrame + 1;
         Shift (m_btDir, m_nMoveStep, curstep, maxstep);  //变速
      end;
      if m_nCurrentFrame >= m_nEndFrame then begin
         if self = g_MySelf then begin
            if FrmMain.ServerAcceptNextAction then begin
               m_nCurrentAction := 0;      //当前动作：无
               m_boLockEndFrame := TRUE;
               m_dwSmoothMoveTime := GetTickCount;
            end;
         end else begin
            m_nCurrentAction := 0; //悼累 肯丰
            m_boLockEndFrame := TRUE;
            m_dwSmoothMoveTime := GetTickCount;
         end;
         Result := TRUE;
      end;
      ErrCode := 4;
      if m_nCurrentAction = SM_RUSH then begin
         if self = g_MySelf then begin
            g_dwDizzyDelayStart := GetTickCount;
            g_dwDizzyDelayTime := 300; //掉饭捞
         end;
      end;
      if m_nCurrentAction = SM_RUSHKUNG then begin  //野蛮冲撞失败
         if m_nCurrentFrame >= m_nEndFrame - 3 then begin
            m_nCurrX := m_nActBeforeX;
            m_nCurrY := m_nActBeforeY;
            m_nRx := m_nCurrX;
            m_nRy := m_nCurrY;
            m_nCurrentAction := 0;
            m_boLockEndFrame := TRUE;
            //m_dwSmoothMoveTime := GetTickCount;
         end;
      end;
      Result := TRUE;
    end;
    if (m_nCurrentAction = SM_BACKSTEP) then begin  //后退
      if (m_nCurrentFrame > m_nEndFrame) or (m_nCurrentFrame < m_nStartFrame) then begin
         m_nCurrentFrame := m_nEndFrame + 1;
      end;
      if m_nCurrentFrame > m_nStartFrame then begin
         Dec (m_nCurrentFrame);
         if m_boMsgMuch or fastmove then
            if m_nCurrentFrame > m_nStartFrame then Dec (m_nCurrentFrame);

         //何靛反霸 捞悼窍霸 窍妨绊
         curstep := m_nEndFrame - m_nCurrentFrame + 1;
         maxstep := m_nEndFrame - m_nStartFrame + 1;
         Shift (GetBack(m_btDir), m_nMoveStep, curstep, maxstep);
      end;
      if m_nCurrentFrame <= m_nStartFrame then begin
         if self = g_MySelf then begin
            //if FrmMain.ServerAcceptNextAction then begin
               m_nCurrentAction := 0;     //消息为空
               m_boLockEndFrame := TRUE;   //锁定当前操作
               m_dwSmoothMoveTime := GetTickCount;

               //第肺 剐赴 促澜 茄悼救 给 框流牢促.
               g_dwDizzyDelayStart := GetTickCount;
               g_dwDizzyDelayTime := 1000; //1檬 掉饭捞
            //end;
         end else begin
            m_nCurrentAction := 0; //悼累 肯丰
            m_boLockEndFrame := TRUE;
            m_dwSmoothMoveTime := GetTickCount;
         end;
         Result := TRUE;
      end;
      Result := TRUE;
    end;
    ErrCode := 5;
    //若当前动作和上一个动作帧不同，则装载当前动作画面
    if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      ErrCode := 6;
      LoadSurface;
    end;
  except
    DebugOutStr('TActor.Move Code:'+IntToStr(ErrCode));
  end;
end;

//移动失败（服务器不接受移动命令）时，退回到上次的位置
procedure TActor.MoveFail;
begin
   m_nCurrentAction := 0; //悼累 肯丰
   m_boLockEndFrame := TRUE;
   g_MySelf.m_nCurrX := m_nOldx;
   g_MySelf.m_nCurrY := m_nOldy;
   g_MySelf.m_btDir := m_nOldDir;
   CleanUserMsgs;
end;

function  TActor.CanCancelAction: Boolean;
begin
   Result := FALSE;
   if (m_nCurrentAction = SM_HIT) or (m_nCurrentAction = SM_HIT_107) then
      if not m_boUseEffect then
         Result := TRUE;
end;

procedure TActor.CancelAction;
begin
   m_nCurrentAction := 0; //悼累 肯丰
   m_boLockEndFrame := TRUE;
end;

procedure TActor.CleanCharMapSetting (x, y: integer);
begin
   g_MySelf.m_nCurrX := x;
   g_MySelf.m_nCurrY := y;
   g_MySelf.m_nRx := x;
   g_MySelf.m_nRy := y;
   m_nOldx := x;
   m_nOldy := y;
   m_nCurrentAction := 0;
   m_nCurrentFrame := -1;
   CleanUserMsgs;
end;

//实现分行显示说话内容到Saying
procedure TActor.Say (str: string);
var
   i, len, aline, n: integer;
   temp: string;
   loop: Boolean;
const
   MAXWIDTH = 150;
begin
   m_dwSayTime := GetTickCount;
   m_nSayLineCount := 0;

   n := 0;
   loop := TRUE;
   while loop do begin
      temp := '';
      i := 1;
      len := Length (str);
      while TRUE do begin
         if i > len then begin
            loop := FALSE;
            break;
         end;
         if byte (str[i]) >= 128 then begin
            temp := temp + str[i];
            Inc (i);
            if i <= len then temp := temp + str[i]
            else begin
               loop := FALSE;
               break;
            end;
         end else
            temp := temp + str[i];

         aline := FrmMain.Canvas.TextWidth (temp);
         if aline > MAXWIDTH then begin
            m_SayingArr[n] := temp;
            m_SayWidthsArr[n] := aline;
            Inc (m_nSayLineCount);
            Inc (n);
            if n >= MAXSAY then begin
               loop := FALSE;
               break;
            end;
            str := Copy (str, i+1, Len-i);
            temp := '';
            break;
         end;
         Inc (i);
      end;
      if temp <> '' then begin
         if n < MAXWIDTH then begin
            m_SayingArr[n] := temp;
            m_SayWidthsArr[n] := FrmMain.Canvas.TextWidth (temp);
            Inc (m_nSayLineCount);
         end;
      end;
   end;
end;


{============================== NPCActor =============================}
procedure TNpcActor.CalcActorFrame;
var
  Pm:pTMonsterAction;
begin
  m_boUseMagic    :=False;
  m_nCurrentFrame :=-1;
  m_nBodyOffset   :=GetNpcOffset(m_wAppearance);
                //npc为50
  Pm:=GetRaceByPM(m_btRace,m_wAppearance);
  if pm = nil then exit;
  m_btDir := m_btDir mod 3;
  case m_nCurrentAction of
    SM_TURN: begin //转向
      if g_boNpcWalk then Exit;
      if m_wAppearance in [54..62,70..75,90..93,64..66,82..84,103,105,107..112,113..118] then begin //卧龙笔记NPC
        m_nStartFrame := pm.ActStand.start;// + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
        m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
        m_dwFrameTime := pm.ActStand.ftime;
        m_dwStartTime := GetTickCount;
        m_nDefFrameCount := pm.ActStand.frame;
        Shift (m_btDir, 0, 0, 1);
        if m_wAppearance in [54..59,62,82..84, 103,107..112,116] then
          m_boUseEffect:=False
        else m_boUseEffect:=True;
        if m_boUseEffect then begin
          case m_wAppearance of
            61: begin //圣诞树
              m_nEffectStart:=pm.ActStand.start + 20;
              m_nEffectFrame:=m_nEffectStart;
              m_nEffectEnd:=m_nEffectStart + 19;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=130;
            end;
            64: begin //练气炉
              m_nEffectStart:=pm.ActStand.start + 10;
              m_nEffectFrame:=m_nEffectStart;
              m_nEffectEnd:=m_nEffectStart + 11;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=130;
            end;
            65..66: begin
              m_nEffectStart:=pm.ActStand.start + 180;
              m_nEffectFrame:=m_nEffectStart;
              m_nEffectEnd:=m_nEffectStart + 3;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=600;
            end;
            105: begin //
              m_nEffectStart:=610;
              m_nEffectFrame:=m_nEffectStart;
              m_nEffectEnd:=m_nEffectStart + 15;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=300;
              m_boUseEffect1 := True;
            end;
            113..115: begin
              m_nEffectStart:=pm.ActStand.start + 10;
              m_nEffectFrame:=m_nEffectStart;
              m_nEffectEnd:=m_nEffectStart + 14;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=130;
            end;
            117..118: begin
              m_nEffectStart:=pm.ActStand.start + 20;
              m_nEffectFrame:=m_nEffectStart;
              m_nEffectEnd:=m_nEffectStart + 8;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=130;
            end;
            else begin
              m_nEffectStart:=pm.ActStand.start + 4;
              m_nEffectFrame:=m_nEffectStart;
              m_nEffectEnd:=m_nEffectStart + 3;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=600;
            end;
          end;
        end;
      end else begin
          m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
          m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
          m_dwFrameTime := pm.ActStand.ftime;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActStand.frame;
          Shift (m_btDir, 0, 0, 1);
          if ((m_wAppearance = 33) or (m_wAppearance = 34))and not m_boUseEffect then begin
            m_boUseEffect:=True;
            m_nEffectStart := 30;
            m_nEffectFrame:=m_nEffectStart;
            m_nEffectEnd:=m_nEffectStart + 9;
            m_dwEffectStartTime:=GetTickCount();
            m_dwEffectFrameTime:=300;
          end else begin
            if m_wAppearance in [42..47] then begin
              m_nStartFrame:=20;
              m_nEndFrame:=10;
              m_boUseEffect:=True;
              m_nEffectStart:=0;
              m_nEffectFrame:=0;
              m_nEffectEnd:=19;
              m_dwEffectStartTime:=GetTickCount();
              m_dwEffectFrameTime:=100;
            end else begin
              if m_wAppearance = 51 then begin
                m_boUseEffect:=True;
                m_nEffectStart:=60;
                m_nEffectFrame:=m_nEffectStart;
                m_nEffectEnd:=m_nEffectStart + 7;
                m_dwEffectStartTime:=GetTickCount();
                m_dwEffectFrameTime:=500;
              end;
            end;
          end;
        end;
    end;
    SM_HIT: begin  //攻击
      if g_boNpcWalk then Exit;
      case m_wAppearance of
        33,34,52,54..62,70..75,90..93,64..66,103,105,107..112,113..118: begin //70 卧龙笔记NPC
          if m_wAppearance in [54..62,70..75,90..93,64..66, 103,107..112,113..118] then m_nStartFrame := pm.ActStand.start else
          m_nStartFrame := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip);
          m_nEndFrame := m_nStartFrame + pm.ActStand.frame - 1;
          m_dwStartTime := GetTickCount;
          m_nDefFrameCount := pm.ActStand.frame;
        end;
        else begin
          if m_wAppearance = 106 then //兔财神
            m_nStartFrame := pm.ActAttack.start + (pm.ActAttack.frame + pm.ActAttack.skip)
          else
            m_nStartFrame := pm.ActAttack.start + m_btDir * (pm.ActAttack.frame + pm.ActAttack.skip);
          m_nEndFrame := m_nStartFrame + pm.ActAttack.frame - 1;
          m_dwFrameTime := pm.ActAttack.ftime;
          m_dwStartTime := GetTickCount;
          if m_wAppearance = 51 then begin
            m_boUseEffect:=True;
            m_nEffectStart:=60;
            m_nEffectFrame:=m_nEffectStart;
            m_nEffectEnd:=m_nEffectStart + 7;
            m_dwEffectStartTime:=GetTickCount();
            m_dwEffectFrameTime:=500;
          end else
            if m_wAppearance in [82..84] then begin
              m_nStartFrame := pm.ActAttack.start;
              m_nEndFrame := m_nStartFrame + pm.ActStand.frame;
            end;
        end;
      end;
    end;
    SM_DIGUP: begin
      if m_wAppearance = 52 then begin
        m_bo248:=True;
        m_dwUseEffectTick:=GetTickCount + 23000;
        Randomize;
        PlaySound(Random(7) + 146);
        m_boUseEffect:=True;
        m_nEffectStart:=60;
        m_nEffectFrame:=m_nEffectStart;
        m_nEffectEnd:=m_nEffectStart + 11;
        m_dwEffectStartTime:=GetTickCount();
        m_dwEffectFrameTime:=100;
      end;
    end;
    SM_NPCWALK: begin //NPC走动
      if m_wAppearance = 81 then begin
        m_nStartFrame := 4250;
        m_nEndFrame := m_nStartFrame + 79;
        m_nCurrentFrame := -1;
        m_dwFrameTime := 80;
        m_dwStartTime := GetTickCount;
        g_boNpcWalk := True;
      end;
    end;
  end;
end;

constructor TNpcActor.Create; //0x0047C42C
begin
  inherited;
  m_EffSurface:=nil;
  m_boHitEffect:=False;
  m_EffSurface1:=nil;
  m_boUseEffect1:=False;
  m_bo248:=False;
  m_boNpcWalkEffect := False; //20080621
  m_boNpcWalkEffectSurface := nil; //20080621
  g_boNpcWalk := False;
end;

destructor TNpcActor.Destroy;
begin
  inherited Destroy;
end;
// 画NPC 人物自身图
procedure TNpcActor.DrawChr(dsurface: TDirectDrawSurface; dx, dy: integer;
  blend, boFlag: Boolean);
var
  ceff: TColorEffect;
begin
  try
    m_btDir := m_btDir mod 3;
    if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface;
    end;
    ceff := GetDrawEffectValue;

    if m_BodySurface <> nil then begin
      if m_wAppearance in [54..58] then begin //雪域NPC
        DrawBlend (dsurface,
               dx + m_nPx + m_nShiftX,
               dy + m_nPy + m_nShiftY,
               m_BodySurface,
               120);
      end else
      if m_wAppearance = 51 then begin  //酒馆老板娘
        DrawEffSurface (dsurface,
                        m_BodySurface,
                        dx + m_nPx + m_nShiftX,
                        dy + m_nPy + m_nShiftY,
                        True,
                        ceff);
      end else begin
        DrawEffSurface (dsurface,      //此处为画
                        m_BodySurface,
                        dx + m_nPx + m_nShiftX,
                        dy + m_nPy + m_nShiftY,
                        blend,
                        ceff);
      end;
    end;
    if m_boNpcWalkEffect then begin   //画酒馆2卷 老板娘效果(走出门帘的光)
      if m_boNpcWalkEffectSurface <> nil then begin
        DrawBlend (dsurface,
               dx + m_nNpcWalkEffectPx + m_nShiftX,
               dy + m_nNpcWalkEffectPy + m_nShiftY,
               m_boNpcWalkEffectSurface,
               120);
      end;
    end;
  except
    DebugOutStr('TNpcActor.DrawChr');
  end;
end;


procedure TNpcActor.DrawEff(dsurface: TDirectDrawSurface; dx, dy: integer);
begin
  try
    if m_boUseEffect1 and (m_EffSurface1 <> nil) then begin
      DrawBlend (dsurface,
                 dx + m_nEffX1 + m_nShiftX,
                 dy + m_nEffY1 + m_nShiftY,
                 m_EffSurface1,
                 120);
    end;
    if m_boUseEffect and (m_EffSurface <> nil) then begin
      DrawBlend (dsurface,
                 dx + m_nEffX + m_nShiftX,
                 dy + m_nEffY + m_nShiftY,
                 m_EffSurface,
                 120);
    end;
  except
    DebugOutStr('TNpcActor.DrawEff');
  end;
end;

function  TNpcActor.GetDefaultFrame (wmode: Boolean): integer;
var
   cf: integer;
   pm: PTMonsterAction;
begin
   Result:=0;//Jacky
   pm := GetRaceByPM (m_btRace,m_wAppearance);
   if pm = nil then exit;
   m_btDir := m_btDir mod 3;  //NPC只有3个方向（如商人）

   if m_nCurrentDefFrame < 0 then cf := 0
   else if m_nCurrentDefFrame >= pm.ActStand.frame then cf := 0
   else cf := m_nCurrentDefFrame;
   if m_wAppearance in [54..62,70..75,90..93,64..66,82..84, 103,107..112,113..118] then  //卧龙笔记NPC
    Result := pm.ActStand.start + cf
   else
   Result := pm.ActStand.start + m_btDir * (pm.ActStand.frame + pm.ActStand.skip) + cf;
end;

procedure TNpcActor.LoadSurface;
begin
  if (m_wAppearance = 81) and g_boNpcWalk then begin  //老板娘
   m_BodySurface:=g_WNpcImgImages.GetCachedImage(m_nCurrentFrame, m_nPx, m_nPy); //取图
   if m_boNpcWalkEffect then  //取门帘光的图 20080621
     m_boNpcWalkEffectSurface:=g_WNpcImgImages.GetCachedImage(m_nCurrentFrame+79, m_nNpcWalkEffectPx, m_nNpcWalkEffectPy); //取图
  end else begin
    m_BodySurface := frmMain.GetWNpcImg(m_wAppearance, m_nBodyOffset + m_nCurrentFrame, m_nPx, m_nPy);
   // m_BodySurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nCurrentFrame, m_nPx, m_nPy);
  end;

  if m_wAppearance in [42..47] then m_BodySurface:=nil;
  if m_boUseEffect then begin
    if m_wAppearance in [33..34] then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 42 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 71;
      m_nEffY:=m_nEffY + 5;
    end else if m_wAppearance = 43 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 71;
      m_nEffY:=m_nEffY + 37;
    end else if m_wAppearance = 44 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 7;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 45 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 6;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 46 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 7;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 47 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
      m_nEffX:=m_nEffX + 8;
      m_nEffY:=m_nEffY + 12;
    end else if m_wAppearance = 51 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 52 then begin
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance in [70..75,90..93, 60, 61, 64..66] then begin //卧龙笔记NPC
      m_EffSurface:=g_WNpcImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance = 105 then begin
      m_EffSurface:=g_WStateEffectImages.GetCachedImage(m_nEffectFrame, m_nEffX, m_nEffY);
    end else if m_wAppearance in [113..118] then begin
      m_EffSurface:=g_WNpc2ImgImages.GetCachedImage(m_nBodyOffset + m_nEffectFrame, m_nEffX, m_nEffY);
    end;
  end;
  if m_boUseEffect1 then begin
    if m_wAppearance = 105 then begin
      m_EffSurface1:=g_WNpc2ImgImages.GetCachedImage(m_nBodyOffset+m_nCurrentFrame+4, m_nEffX1, m_nEffY1);
    end;
  end;
end;


procedure TNpcActor.Run;
var
  nEffectFrame:Integer;
  dwEffectFrameTime:LongWord;
begin
  try
    inherited Run;
    if (m_wAppearance = 81) and g_boNpcWalk then begin
      if not m_boNpcWalkEffect then begin
        if m_nCurrentFrame = 4297 then m_boNpcWalkEffect := True;
      end;
    
      if m_nCurrentFrame >= m_nEndFrame then begin
        g_boNpcWalk := False;
        m_boNpcWalkEffect := False;
        SendMsg (SM_TURN, m_nCurrX, m_nCurrY, m_btDir, 0, m_nState, '', 0, m_nFeature); //转向
      end;
    end;

    nEffectFrame:=m_nEffectFrame;
    if m_boUseEffect then begin    //NPC是否使用了魔法类
      if m_boUseMagic then begin
        dwEffectFrameTime:=Round(m_dwEffectFrameTime / 3);
      end else dwEffectFrameTime:=m_dwEffectFrameTime;

      if GetTickCount - m_dwEffectStartTime > dwEffectFrameTime then begin
        m_dwEffectStartTime:=GetTickCount();
        if m_nEffectFrame < m_nEffectEnd then begin
          Inc(m_nEffectFrame);
        end else begin
          if m_bo248 then begin
            if GetTickCount > m_dwUseEffectTick then begin
              m_boUseEffect:=False;
              m_bo248:=False;
              m_dwUseEffectTick:=GetTickCount();
            end;
            m_nEffectFrame:=m_nEffectStart;
          end else m_nEffectFrame:=m_nEffectStart;
          m_dwEffectStartTime:=GetTickCount();
        end;
      end;
    end;
    if nEffectFrame <> m_nEffectFrame then begin     //魔法桢
      m_dwLoadSurfaceTime:=GetTickCount();
      LoadSurface();
    end;
  except
    DebugOutStr('TNpcActor.Run');
  end;
end;


{============================== HUMActor =============================}
constructor THumActor.Create;
begin
   inherited Create;
   m_HairSurface := nil;
   m_WeaponSurface := nil;
   m_WeaponEffSurface := nil;
   m_HumWinSurface:=nil;
   m_boWeaponEffect := FALSE;
   //m_boMagbubble4      := False; //20080811
   m_dwFrameTime:=150;
   m_dwFrameTick:=GetTickCount();
   m_nFrame:=0;
   m_dwEffFrameTime:=150;
   m_dwEffFrameTick:=GetTickCount();
   m_nEffFrame:=0;
   m_nHumWinOffset:=0;
   m_nCboHumWinOffset:=0;
   m_Hit4Meff := nil;
   m_nFeature.nDressLook := High(m_nFeature.nDressLook);
   m_nFeature.nWeaponLook := High(m_nFeature.nWeaponLook);
  {$IF M2Version <> 2}
  m_wTitleIcon := 0;
  m_sTitleName := '';
  {$IFEND}
end;

destructor THumActor.Destroy;
begin
  inherited Destroy;
end;

procedure THumActor.CalcActorFrame;
{var
  haircount: integer; }
var
  Meff:TMagicEff;
begin
  m_boUseMagic := FALSE;
  m_boHitEffect := FALSE;
  m_nCurrentFrame := -1;
  m_boCboMode := False;
   //human
  m_btHair   := m_nFeature.btHair; //HAIRfeature (m_nFeature);         //发型
  m_btDress  := m_nFeature.nDress; //DRESSfeature (m_nFeature);        //武器//服装
  m_btWeapon := m_nFeature.nWeapon; //WEAPONfeature (m_nFeature);
 // m_btHorse  :=Horsefeature(m_nFeatureEx);  20080721 注释骑马
  m_btEffect :=Effectfeature(m_nFeatureEx);
  m_nBodyOffset := HUMANFRAME * (m_btDress); //m_btSex; //男0, 女1

  //haircount := g_WHairImgImages.ImageCount div {HUMANFRAME}1200 div 2;  //所有头发数=3600/600/2=3,即每个性别的发型数
  //PlayScene.MemoLog.Lines.Add('sdf '+inttostr(g_WHairImgImages.ImageCount div {HUMANFRAME}1200 div 2));

  case m_btHair of
    255: m_nHairOffset := HUMANFRAME * (m_btSex + 6);  //普通斗笠
    254: m_nHairOffset := HUMANFRAME * (m_btSex + 8); //金色斗笠
    253: m_nHairOffset := HUMANFRAME * (m_btSex + 12); //必杀斗笠
    252: m_nHairOffset := HUMANFRAME * ({m_btSex +} 10); //金牛斗笠   女的斗笠坐标有问题
    251: m_nHairOffset := HUMANFRAME * (m_btSex + 14); //金牛斗笠   女的斗笠坐标有问题
    250: m_nHairOffset := HUMANFRAME * (m_btSex + 16); //传奇斗笠
    249: m_nHairOffset := HUMANFRAME * (m_btSex + 18); //皓月斗笠
    else begin
      if m_btSex = 1 then begin //女
        if m_btHair = 1 then begin
          m_nCboHairOffset := 2000;
          m_nHairOffset := 600
        end else begin
           if m_btHair > 1{haircount-1} then m_btHair := 1{haircount-1};
           m_btHair := m_btHair * 2;
           if m_btHair > 1 then begin
              m_nCboHairOffset := NEWHUMANFRAME * (m_btHair + m_btSex);
              m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex);
           end else begin
             m_nCboHairOffset := -1;
             m_nHairOffset := -1;
           end;
        end;
      end else begin                 //男
        if m_btHair = 0 then begin
          m_nHairOffset := -1;
          m_nCboHairOffset := -1;
        end else begin
           if m_btHair > 1{haircount-1} then m_btHair := 1{haircount-1};
           m_btHair := m_btHair * 2;
           if m_btHair > 1 then begin
              m_nCboHairOffset := NEWHUMANFRAME * (m_btHair + m_btSex);
              m_nHairOffset := HUMANFRAME * (m_btHair + m_btSex);
           end else begin
             m_nCboHairOffset := -1;
             m_nHairOffset := -1;
           end;
        end;
      end;
    end;
  end;
  m_nWeaponOffset := HUMANFRAME * m_btWeapon; //(weapon*2 + m_btSex);    //武器图片开始帧（不分性别？）
  if m_nFeature.nWeaponLook <> High(m_nFeature.nWeaponLook) then begin
    if (m_nFeature.nWeaponLook > 2399) and (m_nFeature.nWeaponLookWil = 1) then begin
      m_nWeaponEffOffset := m_nFeature.nWeaponLook + m_btSex * HUMANFRAME;
      m_nCboWeaponEffOffset := (m_nWeaponEffOffset div HUMANFRAME2) * NEWHUMANFRAME2 - 16000 + m_btSex * NEWHUMANFRAME;
    end else begin
      m_nWeaponEffOffset := m_nFeature.nWeaponLook + m_btSex * HUMANFRAME;
      if m_nFeature.nWeaponLookWil <> 2 then
        m_nCboWeaponEffOffset := (m_nWeaponEffOffset div HUMANFRAME2) * NEWHUMANFRAME2 + 40000 + m_btSex * NEWHUMANFRAME;
    end;
  end;
  if m_btEffect = 50 then
    m_nHumWinOffset:=352
  else if m_nFeature.nDressLook <> High(m_nFeature.nDressLook) then begin
    if (m_nFeature.nDressLook > 4799) and (m_nFeature.nDressLookWil = 1) then begin
      m_nHumWinOffset := m_nFeature.nDressLook;
      m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME - 8) * NEWHUMANFRAME;
    end else begin
      m_nHumWinOffset := m_nFeature.nDressLook;
      case m_nFeature.nDressLookWil of
        0,3: m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME) * NEWHUMANFRAME;
        1,2: m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME) * NEWHUMANFRAME + 40000;
      end;
      {if m_nFeature.nDressLookWil = 0 then
        m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME) * NEWHUMANFRAME
      else m_nCboHumWinOffset := (m_nHumWinOffset div HUMANFRAME) * NEWHUMANFRAME + 40000;   }
    end;
  end;

  case m_nCurrentAction of
    SM_TURN: begin//转
      m_nStartFrame := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip);
      m_nEndFrame := m_nStartFrame + HA.ActStand.frame - 1;
      m_dwFrameTime := HA.ActStand.ftime;
      m_dwStartTime := GetTickCount;
      m_nDefFrameCount := HA.ActStand.frame;
      Shift (m_btDir, 0, 0, m_nEndFrame-m_nStartFrame+1);
    end;
    SM_WALK, //走
    SM_BACKSTEP: begin//后退
      m_nStartFrame := HA.ActWalk.start + m_btDir * (HA.ActWalk.frame + HA.ActWalk.skip);
      m_nEndFrame := m_nStartFrame + HA.ActWalk.frame - 1;
      m_dwFrameTime := HA.ActWalk.ftime;
      m_dwStartTime := GetTickCount;
      m_nMaxTick := HA.ActWalk.UseTick;
      m_nCurTick := 0;
      //WarMode := FALSE;
      m_nMoveStep := 1;
      if m_nCurrentAction = SM_BACKSTEP then
         Shift (GetBack(m_btDir), m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1)
      else Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
    end;
    SM_RUSH: begin//野蛮冲撞
      if m_nRushDir = 0 then begin
        m_nRushDir := 1;
        m_nStartFrame := HA.ActRushLeft.start + m_btDir * (HA.ActRushLeft.frame + HA.ActRushLeft.skip);
        m_nEndFrame := m_nStartFrame + HA.ActRushLeft.frame - 1;
        m_dwFrameTime := HA.ActRushLeft.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRushLeft.UseTick;
        m_nCurTick := 0;
        m_nMoveStep := 1;
        Shift (m_btDir, 1, 0, m_nEndFrame-m_nStartFrame+1);
      end else begin
        m_nRushDir := 0;
        m_nStartFrame := HA.ActRushRight.start + m_btDir * (HA.ActRushRight.frame + HA.ActRushRight.skip);
        m_nEndFrame := m_nStartFrame + HA.ActRushRight.frame - 1;
        m_dwFrameTime := HA.ActRushRight.ftime;
        m_dwStartTime := GetTickCount;
        m_nMaxTick := HA.ActRushRight.UseTick;
        m_nCurTick := 0;
        m_nMoveStep := 1;
        Shift (m_btDir, 1, 0, m_nEndFrame-m_nStartFrame+1);
      end;
    end;
    SM_RUSHKUNG: begin//野蛮冲撞失败
      m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
      m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
      m_dwFrameTime := HA.ActRun.ftime;
      m_dwStartTime := GetTickCount;
      m_nMaxTick := HA.ActRun.UseTick;
      m_nCurTick := 0;
      m_nMoveStep := 1;
      Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
    end;
    SM_SITDOWN: begin
      m_nStartFrame := HA.ActSitdown.start + m_btDir * (HA.ActSitdown.frame + HA.ActSitdown.skip);
      m_nEndFrame := m_nStartFrame + HA.ActSitdown.frame - 1;
      m_dwFrameTime := HA.ActSitdown.ftime;
      m_dwStartTime := GetTickCount;
    end;
    SM_RUN: begin
      m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
      m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
      m_dwFrameTime := HA.ActRun.ftime;
      m_dwStartTime := GetTickCount;
      m_nMaxTick := HA.ActRun.UseTick;
      m_nCurTick := 0;
      //WarMode := FALSE;
      if m_nCurrentAction = SM_RUN then m_nMoveStep := 2
      else m_nMoveStep := 1;

      //m_nMoveStep := 2;
      Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
    end;
      { 20080803注释骑马消息
      SM_HORSERUN: begin
            m_nStartFrame := HA.ActRun.start + m_btDir * (HA.ActRun.frame + HA.ActRun.skip);
            m_nEndFrame := m_nStartFrame + HA.ActRun.frame - 1;
            m_dwFrameTime := HA.ActRun.ftime;
            m_dwStartTime := GetTickCount;
            m_nMaxTick := HA.ActRun.UseTick;
            m_nCurTick := 0;
            //WarMode := FALSE;
            if m_nCurrentAction = SM_HORSERUN then m_nMoveStep := 3
            else m_nMoveStep := 1;

            //m_nMoveStep := 2;
            Shift (m_btDir, m_nMoveStep, 0, m_nEndFrame-m_nStartFrame+1);
      end;    }
      {SM_THROW:  //20080803注释
         begin
            m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
            m_dwFrameTime := HA.ActHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            m_boThrow := TRUE;
            Shift (m_btDir, 0, 0, 1);
         end; }
      SM_HIT, SM_POWERHIT, {$IF M2Version <> 2}SM_LONGHITFORFENGHAO,SM_FIREHITFORFENGHAO,{$IFEND}
      SM_LONGHIT, SM_LONGHIT4, SM_WIDEHIT, SM_WIDEHIT4, SM_BATTERHIT1,SM_BATTERHIT2,SM_BATTERHIT3,SM_BATTERHIT4,
      SM_FIREHIT{烈火}, SM_4FIREHIT{4级烈火}, SM_CRSHIT, SM_TWINHIT{开天斩重击}, SM_QTWINHIT{开天斩轻击},
      SM_CIDHIT{龙影剑法},SM_LEITINGHIT,SM_BLOODSOUL{血魄一击(战)},SM_WIDEHIT4EX1..SM_WIDEHIT4EX3,
      SM_FIREHITEX1..SM_FIREHITEX3, SM_POWERHITEX1..SM_POWERHITEX3,SM_LONGHITEX1..SM_LONGHITEX3,
      SM_HIT_107:
         begin
           if m_nCurrentAction <>  SM_BATTERHIT4 then begin
             m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
             m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
             m_dwFrameTime := HA.ActHit.ftime;
             m_dwStartTime := GetTickCount;
             m_boWarMode := TRUE;
             m_dwWarModeTime := GetTickCount;
           end;

            if (m_nCurrentAction = SM_POWERHIT) then begin //攻杀
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 1;
            end;
            if (m_nCurrentAction = SM_LONGHIT) then begin  //刺杀
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 2;
            end;
            {$IF M2Version <> 2}
            if (m_nCurrentAction = SM_LONGHITFORFENGHAO) then begin //粉色刺杀
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 20;
            end;
            if (m_nCurrentAction = SM_FIREHITFORFENGHAO) then begin //粉色烈火
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 21;
            end;
            {$IFEND}
            if (m_nCurrentAction = SM_LONGHIT4) then begin  //4级刺杀
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 17;
            end;
            if (m_nCurrentAction = SM_WIDEHIT) then begin  //半月
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 3;
            end;
            if (m_nCurrentAction = SM_WIDEHIT4) then begin  //圆月弯刀
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 18;
            end;
            if (m_nCurrentAction = SM_FIREHIT) then begin  //烈火
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 4;
            end;
            if (m_nCurrentAction = SM_4FIREHIT) then begin  //4级烈火
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 9;
            end;
            if (m_nCurrentAction = SM_CRSHIT) then begin   //抱月
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 6;
            end;
            if (m_nCurrentAction = SM_TWINHIT) then begin  //开天斩重击
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 7;
               meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic5Images,m_btDir*10+550,10,85,True);
               PlayScene.m_EffectList.Add(meff);
            end;
            if (m_nCurrentAction = SM_QTWINHIT) then begin  //开天斩轻击 2008.02.12
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 10;
               meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic5Images,m_btDir*10+710,10,85,True);
               PlayScene.m_EffectList.Add(meff);
            end;
            if (m_nCurrentAction = SM_CIDHIT) then begin  //龙影剑法
               m_boHitEffect := TRUE;
               m_nMagLight := 2;
               m_nHitEffectNumber := 8;
            end;
            if (m_nCurrentAction = SM_FIREHITEX1) then begin 
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 25;
            end;
            if (m_nCurrentAction = SM_FIREHITEX2) then begin
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 26;
            end;
            if (m_nCurrentAction = SM_FIREHITEX3) then begin 
              m_boHitEffect := TRUE;
              m_nMagLight := 2;
              m_nHitEffectNumber := -1;
              meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic8Images16,m_btDir*10+1840,8,85,True);
              PlayScene.m_EffectList.Add(meff);
            end;
            if (m_nCurrentAction = SM_WIDEHIT4EX1) then begin 
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 27;
            end;
            if (m_nCurrentAction = SM_WIDEHIT4EX2) then begin
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 28;
            end;
            if (m_nCurrentAction = SM_WIDEHIT4EX3) then begin 
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 29;
            end;
            if (m_nCurrentAction = SM_POWERHITEX1) then begin
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 30;
            end;
            if (m_nCurrentAction = SM_POWERHITEX2) then begin
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 31;
            end;
            if (m_nCurrentAction = SM_POWERHITEX3) then begin
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 32;
            end;
            if (m_nCurrentAction = SM_LONGHITEX1) then begin
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 33;
            end;
            if (m_nCurrentAction = SM_LONGHITEX2) then begin
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 34;
            end;
            if (m_nCurrentAction = SM_LONGHITEX3) then begin
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 35;
            end;
            if (m_nCurrentAction = SM_HIT_107) then begin//纵横剑术
              m_boHitEffect := TRUE;
              m_nMagLight := 2;
              m_nHitEffectNumber := -1;
              meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic10Images,m_btDir*20+420,15,85,True);
              PlayScene.m_EffectList.Add(meff);
            end;
            if (m_nCurrentAction = SM_LEITINGHIT{雷霆一击战士效果 20080611}) then begin
               m_boHitEffect := True;
               m_nMagLight := 2;
               m_nHitEffectNumber := 12;
            end;
            //追心刺
            if (m_nCurrentAction =  SM_BATTERHIT1)  then begin
              m_nStartFrame := HA.ActCboSpell9.start + m_btDir * (HA.ActCboSpell9.frame + HA.ActCboSpell9.skip);
              m_nEndFrame := m_nStartFrame + HA.ActCboSpell9.frame - 1;
              m_dwFrameTime := HA.ActCboSpell9.ftime;
              m_dwStartTime := GetTickCount;
              m_boWarMode := TRUE;
              m_dwWarModeTime := GetTickCount;
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 13;
              m_boCboMode := True;
            end;
            //三绝杀
            if (m_nCurrentAction =  SM_BATTERHIT2) then begin
              m_nStartFrame := HA.ActCboSpell11.start + m_btDir * (HA.ActCboSpell11.frame + HA.ActCboSpell11.skip);
              m_nEndFrame := m_nStartFrame + HA.ActCboSpell11.frame - 1;
              m_dwFrameTime := HA.ActCboSpell11.ftime;
              m_dwStartTime := GetTickCount;
              m_boWarMode := TRUE;
              m_dwWarModeTime := GetTickCount;
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 15;
              m_boCboMode := True;
            end;
            //横扫千军
            if (m_nCurrentAction =  SM_BATTERHIT3) then begin
              m_nStartFrame := HA.ActCboSpell10.start + m_btDir * (HA.ActCboSpell10.frame + HA.ActCboSpell10.skip);
              m_nEndFrame := m_nStartFrame + HA.ActCboSpell10.frame - 1;
              m_dwFrameTime := HA.ActCboSpell10.ftime;
              m_dwStartTime := GetTickCount;
              m_boWarMode := TRUE;
              m_dwWarModeTime := GetTickCount;
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 14;
              m_boCboMode := True;
            end;
            //断岳斩
            if (m_nCurrentAction =  SM_BATTERHIT4) then begin   //自身效果。
              m_nStartFrame :=  HA.ActWarMode.start + m_btDir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
              m_nEndFrame := m_nStartFrame + HA.ActWarMode.frame - 1;
              m_dwFrameTime := 1000;
              m_dwStartTime := GetTickCount;
              m_boWarMode := TRUE;
              m_dwWarModeTime := GetTickCount;
              m_Hit4Meff := TObjectEffects.Create(Self,g_WCboEffectImages,1920+m_btDir*10,5,90,TRUE{Blend模式});
              m_Hit4Meff.ImgLib := g_WCboEffectImages;
              m_Hit4Meff.MagOwner:=self;
              PlayScene.m_EffectList.Add(m_Hit4Meff);
              m_boHit4 := True;
            end;
            //血破一击(战)
            if (m_nCurrentAction = SM_BLOODSOUL) then begin
              m_nStartFrame := HA.ActCboSpell12.start + m_btDir * (HA.ActCboSpell12.frame + HA.ActCboSpell12.skip);
              m_nEndFrame := m_nStartFrame + HA.ActCboSpell12.frame - 1;
              m_dwFrameTime := HA.ActCboSpell12.ftime+35;
              m_dwStartTime := GetTickCount;
              m_boHitEffect := True;
              m_nMagLight := 2;
              m_nHitEffectNumber := 19;
              m_boCboMode := True;
            end;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_HEAVYHIT:
         begin
            m_nStartFrame := HA.ActHeavyHit.start + m_btDir * (HA.ActHeavyHit.frame + HA.ActHeavyHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActHeavyHit.frame - 1;
            m_dwFrameTime := HA.ActHeavyHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
         end;
      SM_BIGHIT, SM_DAILY{逐日剑法}{$IF M2Version <> 2},SM_DAILYFORFENGHAO{$IFEND},
      SM_DAILYEX1..SM_DAILYEX3:
         begin
            m_nStartFrame := HA.ActBigHit.start + m_btDir * (HA.ActBigHit.frame + HA.ActBigHit.skip);
            m_nEndFrame := m_nStartFrame + HA.ActBigHit.frame - 1;
            m_dwFrameTime := HA.ActBigHit.ftime;
            m_dwStartTime := GetTickCount;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;
            Shift (m_btDir, 0, 0, 1);
            case m_nCurrentAction of
              SM_DAILY: begin
                m_boHitEffect := True;
                m_nMagLight := 2;
                m_nHitEffectNumber := 11;
              end;
              {$IF M2Version <> 2}
              SM_DAILYFORFENGHAO: begin
                m_boHitEffect := True;
                m_nMagLight := 2;
                m_nHitEffectNumber := 22;
              end;
              {$IFEND}
              SM_DAILYEX1: begin
                m_boHitEffect := True;
                m_nMagLight := 2;
                m_nHitEffectNumber := 23;
              end;
              SM_DAILYEX2: begin
                m_boHitEffect := True;
                m_nMagLight := 2;
                m_nHitEffectNumber := 24;
              end;
              SM_DAILYEX3: begin
                m_boHitEffect := TRUE;
                m_nMagLight := 2;
                m_nHitEffectNumber := -1;
                meff :=TNormalDrawEffect.Create(m_nCurrX,m_nCurrY,g_WMagic9Images,m_btDir*10+180,8,85,True);
                PlayScene.m_EffectList.Add(meff);
              end;
            end;
         end;
      SM_SPELL: //接收使用魔法消息
         begin
              m_nStartFrame := HA.ActSpell.start + m_btDir * (HA.ActSpell.frame + HA.ActSpell.skip);
              m_nEndFrame := m_nStartFrame + HA.ActSpell.frame - 1;
              m_dwFrameTime := HA.ActSpell.ftime;
              m_dwStartTime := GetTickCount;
              m_nCurEffFrame := 0;
              m_boUseMagic := TRUE;
              
              m_nMagLight := 2;
              m_nSpellFrame := 8;
            if m_CurMagic.EffectLevelEx in [1..9] then begin
              case m_CurMagic.EffectNumber of
                10, 11, 12, 100, 118, 119: begin//火符,幽灵盾,神圣战甲术,4级火符,粉色神圣战甲术, 粉色幽灵盾
                  case m_CurMagic.EffectLevelEx of
                    1..3: m_nSpellFrame := 7;
                    4..6: m_nSpellFrame := 9;
                    7..9: m_nSpellFrame := 10;
                  end;
                end;
                15: m_nSpellFrame := 10; //召唤骷髅
                76: begin //召唤圣兽
                  case m_CurMagic.EffectLevelEx of
                    1..3: m_nSpellFrame := 12;
                    4..6: m_nSpellFrame := 15;
                    7..9: m_nSpellFrame := 17;
                  end;
                end;
              end;
            end else
            case m_CurMagic.EffectNumber of
               60: begin
                  m_nStartFrame := HA.ActHit.start + m_btDir * (HA.ActHit.frame + HA.ActHit.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActHit.frame - 1;
                  m_dwFrameTime := HA.ActHit.ftime;
                  m_nMagLight := 2;
                  m_nSpellFrame := 2;
                  //m_nSpellFrame := 15;//15
               end;
               22: begin //地狱雷光
                 m_nMagLight := 4;  //汾汲拳
                 m_nSpellFrame := 10; //汾汲拳绰 10 橇贰烙栏肺 函版
               end;
               26: begin //心灵启示
                 m_nMagLight := 2;
                 m_nSpellFrame := 20;
                 m_dwFrameTime := m_dwFrameTime div 2;
               end;
               129: m_nSpellFrame := 10;
               {43: begin //狮子吼
                 m_nMagLight := 2;
                 m_nSpellFrame := 20;
               end;  }
               52: begin  //四级魔法盾
                  m_nSpellFrame := 9;
               end;
               80: m_nSpellFrame := 10; //4级流星火雨
               91: begin  //护体神盾
                 m_nSpellFrame := 10;
               end;
               66: begin //酒气护体
                 m_nSpellFrame := 16;
               end;
               77,78: m_nSpellFrame := 10; //4级施毒术
               132: m_nSpellFrame := 18; //死亡之眼
               103: begin //双龙破 20090624
                  m_nStartFrame := HA.ActCboSpell1.start + m_btDir * (HA.ActCboSpell1.frame + HA.ActCboSpell1.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell1.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell1.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := TRUE;
                  m_nSpellFrame := CBODEFSPELLFRAME;
               end;
               104: begin //虎啸诀 20090624
                  m_nStartFrame := HA.ActCboSpell7.start + m_btDir * (HA.ActCboSpell7.frame + HA.ActCboSpell7.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell7.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell7.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := TRUE;
                  m_nSpellFrame := 6;
               end;
               106: begin //凤舞祭 20090624
                  m_nStartFrame := HA.ActCboSpell6.start + m_btDir * (HA.ActCboSpell6.frame + HA.ActCboSpell6.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell6.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell6.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := TRUE;
                  m_nSpellFrame := 6;
               end;
               107: begin //八卦掌 20090624
                  m_nStartFrame := HA.ActCboSpell5.start + m_btDir * (HA.ActCboSpell5.frame + HA.ActCboSpell5.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell5.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell5.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := TRUE;
                  m_nSpellFrame := 12;
               end;
               109: begin //惊雷爆 20090624
                  m_nStartFrame := HA.ActCboSpell2.start + m_btDir * (HA.ActCboSpell2.frame + HA.ActCboSpell2.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell2.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell2.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := TRUE;
                  m_nSpellFrame := DEFSPELLFRAME;
               end;
               110: begin //三焰咒
                  m_nStartFrame := HA.ActCboSpell4.start + m_btDir * (HA.ActCboSpell4.frame + HA.ActCboSpell4.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell4.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell4.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := TRUE;
                  m_nSpellFrame := 12;
               end;
               112: begin //冰天雪地 20090624
                  m_nStartFrame := HA.ActCboSpell3.start + m_btDir * (HA.ActCboSpell3.frame + HA.ActCboSpell3.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell3.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell3.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := True;
                  m_nSpellFrame := 8;
               end;
               113: begin //万剑归宗 20090624
                  m_nStartFrame := HA.ActCboSpell8.start + m_btDir * (HA.ActCboSpell8.frame + HA.ActCboSpell8.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell8.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell8.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := TRUE;
                  m_nSpellFrame := 14;
               end;
               55: begin //倚天辟地
                  m_nStartFrame :=  HA.ActCboSpell13.start + m_btDir * (HA.ActCboSpell13.frame + HA.ActCboSpell13.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell13.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell13.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := True;
                  m_nSpellFrame := 12;
               end;
               82: begin //血魄一击(法)
                  m_nStartFrame :=  HA.ActCboSpell14.start + m_btDir * (HA.ActCboSpell14.frame + HA.ActCboSpell14.skip);
                  m_nEndFrame := m_nStartFrame + HA.ActCboSpell14.frame - 1;
                  m_dwFrameTime := HA.ActCboSpell14.ftime;
                  m_dwStartTime := GetTickCount;
                  m_nCurEffFrame := 0;
                  m_boCboMode := True;
                  m_boUseMagic := True;
                  m_nSpellFrame := 9;
               end;
            end;
            if (m_btRace = 1) or (m_btRace = 150) then  //英雄，人型
              m_dwWaitMagicRequest := GetTickCount - 1500 //防止,由于网络延时或消息累积,英雄人形连接放魔法时,出现举手卡现像 减少举手放下的时间间隔20080720
            else begin
              if m_CurMagic.EffectNumber in [103,106,109,112] then
                 m_dwWaitMagicRequest := GetTickCount - 1500
              else
              m_dwWaitMagicRequest := GetTickCount;
            end;
            m_boWarMode := TRUE;
            m_dwWarModeTime := GetTickCount;

            Shift (m_btDir, 0, 0, 1);
         end;
      (*SM_READYFIREHIT:
         begin
            startframe := HA.ActFireHitReady.start + Dir * (HA.ActFireHitReady.frame + HA.ActFireHitReady.skip);
            m_nEndFrame := startframe + HA.ActFireHitReady.frame - 1;
            m_dwFrameTime := HA.ActFireHitReady.ftime;
            m_dwStartTime := GetTickCount;

            BoHitEffect := TRUE;
            HitEffectNumber := 4;
            MagLight := 2;

            CurGlimmer := 0;
            MaxGlimmer := 6;

            WarMode := TRUE;
            WarModeTime := GetTickCount;
            Shift (Dir, 0, 0, 1);
         end; *)
      SM_STRUCK: begin
        m_nStartFrame := HA.ActStruck.start + m_btDir * (HA.ActStruck.frame + HA.ActStruck.skip);
        m_nEndFrame := m_nStartFrame + HA.ActStruck.frame - 1;
        m_dwFrameTime := m_dwStruckFrameTime; //HA.ActStruck.ftime;
        m_dwStartTime := GetTickCount;
        Shift (m_btDir, 0, 0, 1);

        m_dwGenAnicountTime := GetTickCount;
        m_nCurBubbleStruck := 0;
        m_nCurProtEctionStruck := 0;
        m_dwProtEctionStruckTime := GetTickCount;
      end;
      SM_NOWDEATH: begin
        m_nStartFrame := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip);
        m_nEndFrame := m_nStartFrame + HA.ActDie.frame - 1;
        m_dwFrameTime := HA.ActDie.ftime;
        m_dwStartTime := GetTickCount;
      end;
  end;
end;

procedure THumActor.DefaultMotion;
var
  wm: TWMImages;
begin
  inherited DefaultMotion;
  if (m_btEffect = 50) then begin
    if (m_nCurrentFrame <= 536) then begin
      if (GetTickCount - m_dwFrameTick) > 100 then begin
        if m_nFrame < 19 then Inc(m_nFrame)
        else begin
          {if not m_bo2D0 then m_bo2D0:=True
          else m_bo2D0:=False;  }
          m_nFrame:=0;
        end;
        m_dwFrameTick:=GetTickCount();
      end;
      if (not m_boDeath){20080406} then
      m_HumWinSurface:={FrmMain.WEffectImg}g_WEffectImages.GetCachedImage (m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
    end;
  end else if m_nFeature.nDressLook <> High(m_nFeature.nDressLook) then begin
    wm := GetEffectWil(m_nFeature.nDressLookWil);
    if wm <> nil then begin
      if m_nCurrentFrame < 64 then begin
        if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
          if m_nFrame < 7 then Inc(m_nFrame)
          else m_nFrame:=0;
          m_dwFrameTick:=GetTickCount();
        end;
        m_HumWinSurface := wm.GetCachedImage (m_nHumWinOffset+ (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
      end else begin
        m_HumWinSurface := wm.GetCachedImage (m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
      end;
    end;
  end;
end;

function  THumActor.GetDefaultFrame (wmode: Boolean): integer;   //动态函数
var
   cf: integer;
begin
   //GlimmingMode := FALSE;
   //dr := Dress div 2;            //HUMANFRAME * (dr)
   if m_boDeath then      //死亡
      Result := HA.ActDie.start + m_btDir * (HA.ActDie.frame + HA.ActDie.skip) + (HA.ActDie.frame - 1)
   else
   if wmode then begin      //战斗状态
      //GlimmingMode := TRUE;
      Result := HA.ActWarMode.start + m_btDir * (HA.ActWarMode.frame + HA.ActWarMode.skip);
   end else begin           //站立状态
      m_nDefFrameCount := HA.ActStand.frame;
      if m_nCurrentDefFrame < 0 then cf := 0
      else if m_nCurrentDefFrame >= HA.ActStand.frame then cf := 0 //HA.ActStand.frame-1
      else cf := m_nCurrentDefFrame;
      Result := HA.ActStand.start + m_btDir * (HA.ActStand.frame + HA.ActStand.skip) + cf;
   end;
end;

procedure  THumActor.RunFrameAction (frame: integer);
var
   meff: TMapEffect;
   event: TClEvent;
//   mfly: TFlyingAxe;
begin
   //m_boHideWeapon := FALSE; 20080803注释
   case m_nCurrentAction of
     SM_HEAVYHIT:
        if (frame = 5) and (m_boDigFragment) then begin
           m_boDigFragment := FALSE;
           meff := TMapEffect.Create (8 * m_btDir, 3, m_nCurrX, m_nCurrY);
           meff.ImgLib := {FrmMain.WEffectImg}g_WEffectImages;
           meff.NextFrameTime := 80;
           PlaySound (s_strike_stone);
           //PlaySound (s_drop_stonepiece);
           PlayScene.m_EffectList.Add (meff);
           event := EventMan.GetEvent (m_nCurrX, m_nCurrY, ET_PILESTONES);
           if event <> nil then
              event.m_nEventParam := event.m_nEventParam + 1;
        end;
     SM_BATTERHIT4: begin //断岳斩
       if (frame = 3) and (m_boHit41) then begin
         m_boHit41 := False;
         frmMain.DrawEffectHum(m_nRecogId,18,0,0,0);
         MyPlaySound (cboZs3_start);
         m_boRunSound := False;
         {$IF M2Version <> 2}
         PlayScene.OpenScreenShake;
         {$IFEND}
       end;
     end;
     SM_QTWINHIT, SM_TWINHIT: begin
       if frame = 5 then begin
         {$IF M2Version <> 2}
         PlayScene.OpenScreenShake;
         {$IFEND}
       end;
     end;
     (*SM_69HIT: //倚天辟地
        if (frame = 9) {and ()} then begin
          frmMain.DrawEffectHum(m_nRecogId,20,m_nCurrX,m_nCurrY);
        end;*)
   end;
   (*if m_nCurrentAction = SM_BATTERHIT4 then begin
      if (frame = 3) and (m_boHit41) then begin
        m_boHit41 := False;
        frmMain.DrawEffectHum(m_nRecogId,18,0,0);
      end;
   end; *)
   (*//20080803注释
   if m_nCurrentAction = SM_THROW then begin
      if (frame = 3) and (m_boThrow) then begin
         m_boThrow := FALSE;
         //扔斧头效果
         mfly := TFlyingAxe (PlayScene.NewFlyObject (self,
                          m_nCurrX,
                          m_nCurrY,
                          m_nTargetX,
                          m_nTargetY,
                          m_nTargetRecog,
                          mtFlyAxe));
         if mfly <> nil then begin
            TFlyingAxe(mfly).ReadyFrame := 40;
            mfly.ImgLib := {FrmMain.WMon3Img20080720注释}g_WMonImagesArr[2];
            mfly.FlyImageBase := FLYOMAAXEBASE;
         end;

      end;
      if frame >= 3 then
         m_boHideWeapon := TRUE;
   end;   *)
end;

procedure  THumActor.DoWeaponBreakEffect;
begin
   m_boWeaponEffect := TRUE;
   m_nCurWeaponEffect := 0;
end;

procedure  THumActor.Run;
  //判断魔法是否已经完成（人类：3秒，其他：2秒）
   function MagicTimeOut: Boolean;
   begin
      if self = g_MySelf then begin
        if m_CurMagic.EffectNumber = 60 then   //破魂斩  缩短人物砍下去的动作 20080227
         Result := GetTickCount - m_dwWaitMagicRequest > 500
        else Result := GetTickCount - m_dwWaitMagicRequest > 3000;
      end else
      if m_CurMagic.EffectNumber = 60 then begin
       Result := GetTickCount - m_dwWaitMagicRequest > 500  //破魂斩  缩短人物砍下去的动作 20080227
      end else if m_CurMagic.EffectNumber in [103,107,109,110,113] then Result := GetTickCount - m_dwWaitMagicRequest > 3000  else Result := GetTickCount - m_dwWaitMagicRequest > 2000;
      if Result then m_CurMagic.ServerMagicCode := 0;
   end;
var
   prv: integer;
   m_dwFrameTimetime: longword;
   bofly: Boolean;
   nCode: Byte;
   Meff: TMagicEff;
begin
  nCode:= 0;
  try
   if GetTickCount - m_dwGenAnicountTime > 120 then begin //林贱狼阜 殿... 局聪皋捞记 瓤苞
      m_dwGenAnicountTime := GetTickCount;
      Inc (m_nGenAniCount);
      if m_nGenAniCount > 100000 then m_nGenAniCount := 0;
      Inc (m_nCurBubbleStruck);
   end;
   if m_btEffect = 42 then begin //花瓣
     if (not m_boDeath) then begin
       if (m_nCurrentFrame <= 536) then begin
         if (GetTickCount - m_dwEffFrameTick) > 1000 then begin
           if m_nEffFrame < 6 then Inc(m_nEffFrame)
           else begin
             Meff := TObjectEffects.Create(Self,g_WStateEffectImages,610,15,260,TRUE{Blend模式});
             Meff.ImgLib := g_WStateEffectImages;
             Meff.MagOwner:=Self;
             PlayScene.m_EffectList.Add(Meff);
             m_nEffFrame:=0;
           end;
           m_dwEffFrameTick:=GetTickCount();
         end;
       end;
     end;
   end;
   nCode:= 1;
   if m_nCurrentAction = SM_BATTERHIT4 then begin
     if m_Hit4Meff <> nil then begin
       nCode:= 2;
       if (m_Hit4Meff.curframe = 4) and (m_boHit4) then begin
          nCode:= 3;
          m_boHit4 := False;
          m_boHit41 := True;
          m_dwFrameTime := HA.ActCboSpell12.ftime;
          m_dwStartTime := GetTickCount;
          m_nStartFrame := HA.ActCboSpell12.start + m_btDir * (HA.ActCboSpell12.frame + HA.ActCboSpell12.skip);
          m_nEndFrame := m_nStartFrame + HA.ActCboSpell12.frame - 1;
          m_boWarMode := TRUE;
          m_dwWarModeTime := GetTickCount;
          m_boCboMode := True;
          m_boHitEffect := True;
          m_nMagLight := 2;
          m_nHitEffectNumber := 16;
          nCode:= 4;
          Shift (m_btDir, 0, 0, 1);
       end;
     end;
   end;
   nCode:= 5;
   if m_boWeaponEffect then begin  //武器效果，每120秒变化一帧，共5帧
      if GetTickCount - m_dwWeaponpEffectTime > 120 then begin
         m_dwWeaponpEffectTime := GetTickCount;
         Inc (m_nCurWeaponEffect);
         if m_nCurWeaponEffect >= MAXWPEFFECTFRAME then m_boWeaponEffect := FALSE;
      end;
   end;
   nCode:= 6;
   if (m_nCurrentAction = SM_WALK) or
      (m_nCurrentAction = SM_NPCWALK) or
      (m_nCurrentAction = SM_BACKSTEP) or
      (m_nCurrentAction = SM_RUN) or
      //(m_nCurrentAction = SM_HORSERUN) or 20080803注释骑马消息
      (m_nCurrentAction = SM_RUSH) or
      (m_nCurrentAction = SM_RUSHKUNG)
   then Exit;
   m_boMsgMuch := FALSE;
   nCode:= 7;
   if (self <> g_MySelf) and (m_MsgList <> nil) then begin
     nCode := 26;
      if m_MsgList.Count >= 2 then m_boMsgMuch := TRUE;
   end;
   nCode:= 8;
   //动作声效
   RunActSound (m_nCurrentFrame - m_nStartFrame);
   nCode:= 9;
   RunFrameAction (m_nCurrentFrame - m_nStartFrame);
   nCode:= 10;
   prv := m_nCurrentFrame;
   if m_nCurrentAction <> 0 then begin
      if (m_nCurrentFrame < m_nStartFrame) or (m_nCurrentFrame > m_nEndFrame) then
         m_nCurrentFrame := m_nStartFrame;
      if (self <> g_MySelf) and (m_boUseMagic) then begin
         m_dwFrameTimetime := Round(m_dwFrameTime / 1.8);
      end else begin
         if m_boMsgMuch then m_dwFrameTimetime := Round(m_dwFrameTime * 2 / 3)
         else m_dwFrameTimetime := m_dwFrameTime;
      end;
      nCode:= 11;
      if GetTickCount - m_dwStartTime > m_dwFrameTimetime then begin
         if m_nCurrentFrame < m_nEndFrame then begin
            if m_boUseMagic then begin
               if (m_nCurEffFrame = m_nSpellFrame-2) or (MagicTimeOut) then begin //魔法执行完
                  if (m_CurMagic.ServerMagicCode >= 0) or (MagicTimeOut) then begin //辑滚肺 何磐 罐篮 搬苞. 酒流 救吭栏搁 扁促覆
                     Inc (m_nCurrentFrame);
                     Inc (m_nCurEffFrame);
                     m_dwStartTime := GetTickCount;
                  end;
               end else begin
                  if m_nCurrentFrame < m_nEndFrame - 1 then Inc (m_nCurrentFrame);
                  Inc (m_nCurEffFrame);
                  m_dwStartTime := GetTickCount;
               end;
            end else begin   //攻击怪 这有反映
               Inc (m_nCurrentFrame);
               m_dwStartTime := GetTickCount;
            end;
         end else begin
            if Self = g_MySelf then begin
               if FrmMain.ServerAcceptNextAction then begin //锁定人物本身 服务器返回结果 则释放
                  m_nCurrentAction := 0;   //动作清空
                  m_boUseMagic := FALSE;   //魔法为假
               end;
            end else begin     //不是人物
               m_nCurrentAction := 0;  //动作为空
               m_boUseMagic := FALSE;
            end;
            m_boHitEffect := FALSE;
         end;
         nCode:= 12;
         if m_boHitEffect and ((m_nHitEffectNumber = 7) or (m_nHitEffectNumber = 8) or (m_nHitEffectNumber = 10) or (m_nHitEffectNumber = 12){ or (m_nHitEffectNumber = 16)}) then begin//魔法攻击效果  20080202
             if m_nCurrentFrame = m_nEndFrame - 1 then begin
                case m_nHitEffectNumber of
                    8: FrmMain.ShowMyShow(Self,1); //龙影剑法  后9个动画效果 20080202
                      //MyShow.Create(m_nCurrX,m_nCurrY,1,80,9,m_btDir,g_WMagic2Images);
                    //7: FrmMain.ShowMyShow(Self,2); //开天斩重击碎冰效果
                   //10: FrmMain.ShowMyShow(Self,3); //开天斩轻击碎冰效果
                   12: FrmMain.ShowMyShow(Self,6);//雷霆一击战士效果
                end;
             end;
         end;
         nCode:= 13;
         if m_boUseMagic then begin
           if m_CurMagic.EffectNumber <> 110 then begin
              if m_nCurEffFrame = m_nSpellFrame - 1 then begin //魔法过程 先放自身魔法 的-1图
                 //付过 惯荤
                 if m_CurMagic.ServerMagicCode > 0 then begin
                   nCode:= 14;
                    with m_CurMagic do
                       PlayScene.NewMagic (self, ServerMagicCode, EffectNumber,
                                        m_nCurrX, m_nCurrY, TargX, TargY, Target,
                                        EffectType, Recusion, AniTime, EffectLevelEx, bofly);
                    nCode:= 15;
                    if bofly then
                      case m_CurMagic.MagicSerial of
                        46: MyPlaySound ('wav\splitshadow.wav'); //分身术
                        77: MyPlaySound ('wav\cboFs1_target.wav'); //双龙破
                        78: MyPlaySound ('wav\cboDs1_target.wav'); //虎啸诀
                        80: MyPlaySound ('wav\cboFs2_target.wav'); //凤舞祭
                        81: MyPlaySound ('wav\cboDs2_target.wav'); //八卦掌
                        83: MyPlaySound ('wav\cboFs3_target.wav'); //惊雷爆
                        84: MyPlaySound ('wav\cboDs3_target.wav'); //三焰咒
                        87: MyPlaySound ('wav\cboDs4_target.wav'); //万剑归宗
                        else PlaySound (m_nMagicFireSound);
                      end
                    else begin
                      nCode:= 16;
                      case m_CurMagic.MagicSerial of
                        58, 70, 92, 108: MyPlaySound ('wav\M58-3.wav'); //漫天火雨声音 20080511
                        84: MyPlaySound ('wav\cboDs3_target.wav'); //三焰咒
                        69: begin
                          PlaySound (m_nWeaponSound);
                          if m_btSex = 0 then MyPlaySound (cboZs3_start_m)
                          else MyPlaySound (cboZs3_start_w); //女
                          m_boRunSound := False;
                        end;
                        else PlaySound (m_nMagicExplosionSound);
                      end;
                    end;
                 end;
                 nCode:= 17;
                 if self = g_MySelf then g_dwLatestSpellTick := GetTickCount;
                 m_CurMagic.ServerMagicCode := 0;
              end;
           end else begin //三焰咒
              nCode:= 18;
              if (m_nCurEffFrame = m_nSpellFrame-2) or (m_nCurEffFrame = m_nSpellFrame-4) or (m_nCurEffFrame = m_nSpellFrame-6)  then begin //魔法过程 先放自身魔法 的-1图
                 //付过 惯荤
                 if m_CurMagic.ServerMagicCode > 0 then begin
                   nCode:= 19;
                    with m_CurMagic do
                       PlayScene.NewMagic (self,
                                        ServerMagicCode,
                                        EffectNumber,
                                        m_nCurrX,
                                        m_nCurrY,
                                        TargX,
                                        TargY,
                                        Target,
                                        EffectType,
                                        Recusion,
                                        AniTime,
                                        EffectLevelEx,
                                        bofly);
                 nCode:= 20;
                 if self = g_MySelf then g_dwLatestSpellTick := GetTickCount;
                 if m_nCurEffFrame = m_nSpellFrame-2 then m_CurMagic.ServerMagicCode := 0;
                end;
              end;
           end;
         end;

      end;
      nCode:= 21;
      if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then m_nCurrentDefFrame := 0 //人类,英雄,人型20080629
      else m_nCurrentDefFrame := -10;
      m_dwDefFrameTime := GetTickCount;
   end else begin
     nCode:= 22;
      if GetTickCount - m_dwSmoothMoveTime > 200 then begin
         if GetTickCount - m_dwDefFrameTime > 500 then begin
            m_dwDefFrameTime := GetTickCount;
            Inc (m_nCurrentDefFrame);
            if m_nCurrentDefFrame >= m_nDefFrameCount then begin
              m_nCurrentDefFrame := 0;
            end;
         end;
         nCode:= 23;
         DefaultMotion;
      end;
   end;
   nCode:= 24;
   if prv <> m_nCurrentFrame then begin
      m_dwLoadSurfaceTime := GetTickCount;
      nCode:= 25;
      LoadSurface;
   end;
  except
    DebugOutStr('THumActor.Run Code:'+inttostr(nCode));
  end;
end;

function   THumActor.Light: integer;
var
   l: integer;
begin
   l := m_nChrLight;
   if l < m_nMagLight then begin
      if m_boUseMagic or m_boHitEffect then
         l := m_nMagLight;
   end;
   Result := l;
end;

procedure  THumActor.LoadSurface;

  procedure GetNJXY(index: integer; var x, y: Integer);
  begin
    case index of
      0: begin X:=28; Y:=-29 end;        1: begin X:=29; Y:=-31 end;
      2: begin X:=29; Y:=-33 end;        3: begin X:=29; Y:=-31 end;
      8: begin X:=29; Y:=-18 end;        9: begin X:=30; Y:=-19 end;
      10: begin X:=31; Y:=-19 end;      11: begin X:=31; Y:=-19 end;
      16: begin X:=19; Y:=-13 end;      17: begin X:=20; Y:=-12 end;
      18: begin X:=21; Y:=-13 end;      19: begin X:=21; Y:=-12 end;
      24: begin X:=9; Y:=-11 end;       25: begin X:=10; Y:=-10 end;
      26: begin X:=11; Y:=-10 end;      27: begin X:=11; Y:=-10 end;
      32: begin X:=-6; Y:=-16 end;      33: begin X:=-4; Y:=-16 end;
      34: begin X:=-4; Y:=-16 end;      35: begin X:=-5; Y:=-16 end;
      40: begin X:=-30; Y:=-26 end;     41: begin X:=-30; Y:=-25 end;
      42: begin X:=-31; Y:=-25 end;     43: begin X:=-30; Y:=-25 end;
      48: begin X:=-25; Y:=-30 end;     49: begin X:=-27; Y:=-30 end;
      50: begin X:=-28; Y:=-30 end;     51: begin X:=-27; Y:=-30 end;
      56: begin X:=1; Y:=-32 end;       57: begin X:=-1; Y:=-34 end;
      58: begin X:=-1; Y:=-36 end;      59: begin X:=-1; Y:=-34 end;
      64: begin X:=29; Y:=-31 end;      65: begin X:=29; Y:=-44 end;
      66: begin X:=27; Y:=-56 end;      67: begin X:=25; Y:=-64 end;
      68: begin X:=27; Y:=-48 end;      69: begin X:=30; Y:=-35 end;
      72: begin X:=27; Y:=-16 end;      73: begin X:=30; Y:=-27 end;
      74: begin X:=34; Y:=-40 end;      75: begin X:=37; Y:=-49 end;
      76: begin X:=33; Y:=-32 end;      77: begin X:=29; Y:=-18 end;
      80: begin X:=15; Y:=-12 end;      81: begin X:=20; Y:=-14 end;
      82: begin X:=27; Y:=-17 end;      83: begin X:=32; Y:=-20 end;
      84: begin X:=26; Y:=-16 end;      85: begin X:=19; Y:=-12 end;
      88: begin X:=6; Y:=-13 end;       89: begin X:=9; Y:=-13 end;
      90: begin X:=15; Y:=-12 end;      91: begin X:=20; Y:=-11 end;
      92: begin X:=15; Y:=-11 end;      93: begin X:=8; Y:=-11 end;
      96: begin X:=-14; Y:=-20 end;     97: begin X:=-10; Y:=-18 end;
      98: begin X:=-2; Y:=-15 end;      99: begin X:=2; Y:=-12 end;
      100: begin X:=-3; Y:=-14 end;    101: begin X:=-13; Y:=-17 end;
      104: begin X:=-34; Y:=-29 end;   105: begin X:=-38; Y:=-28 end;
      106: begin X:=-38; Y:=-25 end;   107: begin X:=-38; Y:=-23 end;
      108: begin X:=-36; Y:=-24 end;   109: begin X:=-35; Y:=-27 end;
      112: begin X:=-21; Y:=-32 end;   113: begin X:=-31; Y:=-34 end;
      114: begin X:=-41; Y:=-34 end;   115: begin X:=-45; Y:=-35 end;
      116: begin X:=-37; Y:=-31 end;   117: begin X:=-26; Y:=-31 end;
      120: begin X:=10; Y:=-38 end;    122: begin X:=-13; Y:=-54 end;
      123: begin X:=-19; Y:=-60 end;   124: begin X:=-9; Y:=-48 end;
      125: begin X:=5; Y:=-40 end;     128: begin X:=34; Y:=-52 end;
      129: begin X:=28; Y:=-73 end;    130: begin X:=13; Y:=-99 end;
      131: begin X:=10; Y:=-92 end;    132: begin X:=20; Y:=-91 end;
      133: begin X:=27; Y:=-67 end;    136: begin X:=32; Y:=-29 end;
      137: begin X:=36; Y:=-57 end;    138: begin X:=39; Y:=-91 end;
      139: begin X:=31; Y:=-91 end;    140: begin X:=40; Y:=-80 end;
      141: begin X:=33; Y:=-50 end;    144: begin X:=17; Y:=-15 end;
      145: begin X:=27; Y:=-29 end;    146: begin X:=38; Y:=-69 end;
      147: begin X:=35; Y:=-82 end;    148: begin X:=38; Y:=-53 end;
      149: begin X:=26; Y:=-23 end;    152: begin X:=4; Y:=-15 end;
      153: begin X:=14; Y:=-17 end;    154: begin X:=26; Y:=-44 end;
      155: begin X:=27; Y:=-68 end;    156: begin X:=26; Y:=-27 end;
      157: begin X:=14; Y:=-17 end;    160: begin X:=-19; Y:=-23 end;
      161: begin X:=-1; Y:=-20 end;    162: begin X:=7; Y:=-34 end;
      163: begin X:=11; Y:=-60 end;    164: begin X:=6; Y:=-20 end;
      165: begin X:=-3; Y:=-20 end;    168: begin X:=-41; Y:=-34 end;
      169: begin X:=-36; Y:=-31 end;   170: begin X:=-20; Y:=-45 end;
      171: begin X:=-3; Y:=-62 end;    172: begin X:=-29; Y:=-33 end;
      173: begin X:=-36; Y:=-31 end;   176: begin X:=-27; Y:=-46 end;
      177: begin X:=-40; Y:=-48 end;   178: begin X:=-33; Y:=-66 end;
      179: begin X:=-9; Y:=-74 end;    180: begin X:=-40; Y:=-58 end;
      181: begin X:=-38; Y:=-44 end;   184: begin X:=9; Y:=-59 end;
      185: begin X:=-14; Y:=-70 end;   186: begin X:=-21; Y:=-90 end;
      187: begin X:=-6; Y:=-86 end;    188: begin X:=-22; Y:=-85 end;
      189: begin X:=-10; Y:=-66 end;   192: begin X:=46; Y:=-49 end;
      193: begin X:=40; Y:=-26 end;    194: begin X:=2; Y:=-22 end;
      195: begin X:=-36; Y:=-40 end;   196: begin X:=-44; Y:=-71 end;
      197: begin X:=-17; Y:=-97 end;   198: begin X:=16; Y:=-100 end;
      199: begin X:=38; Y:=-80 end;    200: begin X:=46; Y:=-71 end;
      201: begin X:=-38; Y:=-13 end;   202: begin X:=8; Y:=-46 end;
      203: begin X:=42; Y:=-85 end;    204: begin X:=-13; Y:=-38 end;
      205: begin X:=22; Y:=-44 end;    208: begin X:=39; Y:=-47 end;
      209: begin X:=-69; Y:=-39 end;   210: begin X:=-27; Y:=-46 end;
      211: begin X:=58; Y:=-57 end;    212: begin X:=38; Y:=-35 end;
      213: begin X:=43; Y:=-29 end;    216: begin X:=17; Y:=-33 end;
      217: begin X:=-53; Y:=-80 end;   218: begin X:=-40; Y:=-59 end;
      219: begin X:=32; Y:=-40 end;    220: begin X:=53; Y:=-15 end;
      221: begin X:=41; Y:=-7 end;     224: begin X:=-15; Y:=-39 end;
      225: begin X:=-5; Y:=-102 end;   226: begin X:=-18; Y:=-81 end;
      227: begin X:=-11; Y:=-41 end;   228: begin X:=50; Y:=6 end;
      229: begin X:=27; Y:=4 end;      232: begin X:=-38; Y:=-63 end;
      233: begin X:=29; Y:=-92 end;    234: begin X:=5; Y:=-89 end;
      235: begin X:=-39; Y:=-64 end;   236: begin X:=24; Y:=17 end;
      237: begin X:=4; Y:=4 end;       240: begin X:=-28; Y:=-91 end;
      241: begin X:=56; Y:=-60 end;    242: begin X:=16; Y:=-78 end;
      243: begin X:=-35; Y:=-95 end;   244: begin X:=-16; Y:=12 end;
      245: begin X:=-38; Y:=-9 end;    248: begin X:=9; Y:=-103 end;
      249: begin X:=60; Y:=-34 end;    250: begin X:=30; Y:=-63 end;
      251: begin X:=-14; Y:=-113 end;  252: begin X:=-53; Y:=-3 end;
      253: begin X:=-49; Y:=-22 end;   256: begin X:=36; Y:=-95 end;
      257: begin X:=27; Y:=-15 end;    258: begin X:=32; Y:=-53 end;
      259: begin X:=13; Y:=-109 end;   260: begin X:=-53; Y:=-23 end;
      261: begin X:=-26; Y:=-38 end;   264: begin X:=43; Y:=-41 end;
      265: begin X:=-16; Y:=-19 end;   266: begin X:=31; Y:=-73 end;
      267: begin X:=3; Y:=-42 end;     268: begin X:=1; Y:=-47 end;
      269: begin X:=31; Y:=-68 end;    272: begin X:=38; Y:=-27 end;
      273: begin X:=-47; Y:=-30 end;   274: begin X:=42; Y:=-54 end;
      275: begin X:=33; Y:=-34 end;    276: begin X:=28; Y:=-39 end;
      277: begin X:=45; Y:=-39 end;    280: begin X:=-9; Y:=-19 end;
      281: begin X:=-44; Y:=-46 end;   282: begin X:=10; Y:=-50 end;
      283: begin X:=51; Y:=-18 end;    284: begin X:=43; Y:=-26 end;
      285: begin X:=38; Y:=-23 end;    288: begin X:=-47; Y:=-29 end;
      289: begin X:=-4; Y:=-64 end;    290: begin X:=-16; Y:=-59 end;
      291: begin X:=50; Y:=3 end;      292: begin X:=45; Y:=-9 end;
      293: begin X:=1; Y:=-14 end;     296: begin X:=-49; Y:=-64 end;
      297: begin X:=25; Y:=-60 end;    298: begin X:=-25; Y:=-79 end;
      299: begin X:=19; Y:=13 end;     300: begin X:=21; Y:=1 end;
      301: begin X:=-43; Y:=-23 end;   304: begin X:=-13; Y:=-91 end;
      305: begin X:=39; Y:=-43 end;    306: begin X:=-11; Y:=-100 end;
      307: begin X:=-36; Y:=10 end;    309: begin X:=-51; Y:=-57 end;
      312: begin X:=15; Y:=-90 end;    313: begin X:=42; Y:=-27 end;
      314: begin X:=-2; Y:=-104 end;   315: begin X:=-58; Y:=-3 end;
      316: begin X:=-52; Y:=-10 end;   317: begin X:=-18; Y:=-84 end;
      320: begin X:=36; Y:=-66 end;    321: begin X:=26; Y:=-18 end;
      322: begin X:=13; Y:=-93 end;    323: begin X:=-41; Y:=-28 end;
      324: begin X:=-38; Y:=-33 end;   325: begin X:=10; Y:=-89 end;
      328: begin X:=45; Y:=-53 end;    329: begin X:=-28; Y:=-19 end;
      330: begin X:=-51; Y:=-56 end;   331: begin X:=-30; Y:=-44 end;
      332: begin X:=44; Y:=-36 end;    333: begin X:=25; Y:=-72 end;
      334: begin X:=-58; Y:=-44 end;   335: begin X:=21; Y:=-75 end;
      336: begin X:=28; Y:=-32 end;    337: begin X:=-56; Y:=-49 end;
      338: begin X:=-43; Y:=-86 end;   339: begin X:=-51; Y:=-65 end;
      340: begin X:=15; Y:=-24 end;    341: begin X:=55; Y:=-41 end;
      342: begin X:=-29; Y:=-78 end;   343: begin X:=46; Y:=-47 end;
      344: begin X:=-2; Y:=-27 end;    345: begin X:=-44; Y:=-85 end;
      346: begin X:=-5; Y:=-106 end;   347: begin X:=-35; Y:=-97 end;
      348: begin X:=-33; Y:=-23 end;   349: begin X:=57; Y:=-10 end;
      350: begin X:=18; Y:=-91 end;    351: begin X:=50; Y:=-22 end;
      352: begin X:=-34; Y:=-47 end;   353: begin X:=-3; Y:=-103 end;
      354: begin X:=17; Y:=-102 end;   355: begin X:=1; Y:=-111 end;
      356: begin X:=-51; Y:=-53 end;   357: begin X:=36; Y:=8 end;
      358: begin X:=41; Y:=-73 end;    359: begin X:=35; Y:=-5 end;
      360: begin X:=-40; Y:=-77 end;   361: begin X:=25; Y:=-95 end;
      362: begin X:=34; Y:=-79 end;    363: begin X:=21; Y:=-101 end;
      364: begin X:=-33; Y:=-86 end;   365: begin X:=-20; Y:=10 end;
      366: begin X:=47; Y:=-38 end;    367: begin X:=-17; Y:=-2 end;
      368: begin X:=-12; Y:=-100 end;  369: begin X:=47; Y:=-65 end;
      370: begin X:=40; Y:=-66 end;    371: begin X:=38; Y:=-75 end;
      372: begin X:=-2; Y:=-99 end;    373: begin X:=-68; Y:=-6 end;
      374: begin X:=34; Y:=-14 end;    375: begin X:=-60; Y:=-15 end;
      376: begin X:=32; Y:=-101 end;   377: begin X:=54; Y:=-35 end;
      378: begin X:=34; Y:=-53 end;    379: begin X:=44; Y:=-58 end;
      380: begin X:=26; Y:=-84 end;    381: begin X:=-64; Y:=-42 end;
      382: begin X:=10; Y:=-7 end;     383: begin X:=-55; Y:=-48 end;
      384: begin X:=49; Y:=-82 end;    385: begin X:=28; Y:=-19 end;
      386: begin X:=-16; Y:=-50 end;   387: begin X:=20; Y:=-45 end;
      388: begin X:=44; Y:=-55 end;    389: begin X:=-18; Y:=-73 end;
      390: begin X:=-39; Y:=-16 end;   391: begin X:=-14; Y:=-76 end;
      392: begin X:=32; Y:=-87 end;    393: begin X:=3; Y:=-98 end;
      394: begin X:=-9; Y:=-79 end;    395: begin X:=-1; Y:=-61 end;
      396: begin X:=19; Y:=-95 end;    397: begin X:=26; Y:=-83 end;
      400: begin X:=43; Y:=-63 end;    401: begin X:=25; Y:=-99 end;
      402: begin X:=-5; Y:=-95 end;    403: begin X:=-20; Y:=-75 end;
      404: begin X:=18; Y:=-95 end;    405: begin X:=49; Y:=-60 end;
      408: begin X:=35; Y:=-36 end;    409: begin X:=30; Y:=-87 end;
      410: begin X:=9; Y:=-103 end;    411: begin X:=-21; Y:=-95 end;
      412: begin X:=12; Y:=-95 end;    413: begin X:=51; Y:=-26 end;
      416: begin X:=18; Y:=-21 end;    417: begin X:=29; Y:=-69 end;
      418: begin X:=24; Y:=-98 end;    419: begin X:=1; Y:=-107 end;
      420: begin X:=9; Y:=-94 end;     421: begin X:=34; Y:=-10 end;
      424: begin X:=-21; Y:=-31 end;   425: begin X:=18; Y:=-59 end;
      426: begin X:=19; Y:=-87 end;    427: begin X:=10; Y:=-108 end;
      428: begin X:=1; Y:=-99 end;     429: begin X:=-5; Y:=-9 end;
      432: begin X:=-43; Y:=-58 end;   433: begin X:=2; Y:=-59 end;
      434: begin X:=12; Y:=-73 end;    435: begin X:=15; Y:=-94 end;
      437: begin X:=-56; Y:=-24 end;   440: begin X:=-27; Y:=-84 end;
      441: begin X:=-13; Y:=-72 end;   442: begin X:=8; Y:=-66 end;
      443: begin X:=23; Y:=-74 end;    444: begin X:=11; Y:=-101 end;
      445: begin X:=-63; Y:=-48 end;   448: begin X:=9; Y:=-98 end;
      449: begin X:=-14; Y:=-88 end;   451: begin X:=23; Y:=-63 end;
      452: begin X:=20; Y:=-98 end;    453: begin X:=-25; Y:=-79 end;
      456: begin X:=26; Y:=-25 end;    457: begin X:=17; Y:=-32 end;
      458: begin X:=35; Y:=-16 end;    459: begin X:=43; Y:=-22 end;
      460: begin X:=30; Y:=-5 end;     461: begin X:=46; Y:=-1 end;
      462: begin X:=19; Y:=2 end;      463: begin X:=34; Y:=15 end;
      464: begin X:=-1; Y:=-1 end;     465: begin X:=8; Y:=18 end;
      466: begin X:=-34; Y:=-11 end;   467: begin X:=-38; Y:=8 end;
      468: begin X:=-36; Y:=-20 end;   469: begin X:=-55; Y:=-8 end;
      470: begin X:=-11; Y:=-26 end;   471: begin X:=-33; Y:=-24 end;
      472: begin X:=43; Y:=-14 end;    473: begin X:=42; Y:=-30 end;
      474: begin X:=41; Y:=-44 end;    481: begin X:=33; Y:=-8 end;
      482: begin X:=39; Y:=-15 end;    489: begin X:=12; Y:=-4 end;
      490: begin X:=20; Y:=-7 end;     496: begin X:=-44; Y:=-15 end;
      497: begin X:=-24; Y:=-10 end;   498: begin X:=-9; Y:=-9 end;
      504: begin X:=-58; Y:=-34 end;   505: begin X:=-54; Y:=-25 end;
      506: begin X:=-50; Y:=-22 end;   512: begin X:=-27; Y:=-65 end;
      513: begin X:=-43; Y:=-51 end;   514: begin X:=-53; Y:=-44 end;
      520: begin X:=30; Y:=-70 end;    521: begin X:=6; Y:=-68 end;
      522: begin X:=-12; Y:=-68 end;   528: begin X:=47; Y:=-49 end;
      529: begin X:=38; Y:=-60 end;    530: begin X:=31; Y:=-68 end;
      536: begin X:=9; Y:=-80 end;     537: begin X:=-14; Y:=-51 end;
      538: begin X:=-17; Y:=27 end;    539: begin X:=10; Y:=47 end;
      544: begin X:=48; Y:=-73 end;    545: begin X:=-20; Y:=-66 end;
      546: begin X:=-45; Y:=16 end;    547: begin X:=-47; Y:=47 end;
      552: begin X:=39; Y:=-46 end;    553: begin X:=-8; Y:=-83 end;
      554: begin X:=-42; Y:=-16 end;   555: begin X:=-70; Y:=16 end;
      560: begin X:=17; Y:=-16 end;    561: begin X:=17; Y:=-87 end;
      562: begin X:=-24; Y:=-37 end;   563: begin X:=-44; Y:=-21 end;
      568: begin X:=-8; Y:=-18 end;    569: begin X:=16; Y:=-77 end;
      570: begin X:=5; Y:=-38 end;     571: begin X:=-10; Y:=-36 end;
      576: begin X:=-26; Y:=-33 end;   577: begin X:=12; Y:=-59 end;
      578: begin X:=40; Y:=-33 end;    579: begin X:=36; Y:=-27 end;
      584: begin X:=-42; Y:=-48 end;   585: begin X:=13; Y:=-46 end;
      586: begin X:=62; Y:=-12 end;    587: begin X:=72; Y:=-6 end;
      592: begin X:=-30; Y:=-66 end;   593: begin X:=8; Y:=-49 end;
      594: begin X:=34; Y:=12 end;     595: begin X:=70; Y:=24 end;
      600: begin X:=29; Y:=-36 end;    601: begin X:=30; Y:=-38 end;
      602: begin X:=30; Y:=-39 end;    603: begin X:=30; Y:=-38 end;
      608: begin X:=27; Y:=-20 end;    609: begin X:=29; Y:=-23 end;
      610: begin X:=29; Y:=-23 end;    611: begin X:=28; Y:=-22 end;
      616: begin X:=18; Y:=-13 end;    617: begin X:=19; Y:=-13 end;
      618: begin X:=20; Y:=-13 end;    619: begin X:=19; Y:=-13 end;
      624: begin X:=7; Y:=-14 end;     625: begin X:=9; Y:=-13 end;
      626: begin X:=9; Y:=-13 end;     627: begin X:=9; Y:=-13 end;
      632: begin X:=-4; Y:=-18 end;    633: begin X:=-3; Y:=-17 end;
      634: begin X:=-3; Y:=-17 end;    635: begin X:=-4; Y:=-17 end;
      640: begin X:=-29; Y:=-26 end;   641: begin X:=-29; Y:=-25 end;
      642: begin X:=-29; Y:=-25 end;   643: begin X:=-28; Y:=-24 end;
      648: begin X:=-27; Y:=-30 end;   649: begin X:=-27; Y:=-31 end;
      650: begin X:=-27; Y:=-31 end;   651: begin X:=-28; Y:=-30 end;
      656: begin X:=2; Y:=-37 end;     657: begin X:=1; Y:=-39 end;
      664: begin X:=26; Y:=-29 end;    665: begin X:=27; Y:=-37 end;
      666: begin X:=27; Y:=-48 end;    667: begin X:=27; Y:=-65 end;
      668: begin X:=27; Y:=-53 end;    669: begin X:=27; Y:=-42 end;
      672: begin X:=20; Y:=-14 end;    673: begin X:=23; Y:=-18 end;
      674: begin X:=27; Y:=-30 end;    675: begin X:=32; Y:=-46 end;
      676: begin X:=28; Y:=-35 end;    677: begin X:=25; Y:=-21 end;
      680: begin X:=11; Y:=-13 end;    681: begin X:=15; Y:=-14 end;
      682: begin X:=21; Y:=-16 end;    683: begin X:=26; Y:=-19 end;
      684: begin X:=22; Y:=-17 end;    685: begin X:=17; Y:=-14 end;
      688: begin X:=5; Y:=-16 end;     689: begin X:=7; Y:=-15 end;
      690: begin X:=12; Y:=-15 end;    691: begin X:=17; Y:=-14 end;
      692: begin X:=13; Y:=-15 end;    693: begin X:=8; Y:=-14 end;
      696: begin X:=-14; Y:=-22 end;   697: begin X:=-13; Y:=-20 end;
      698: begin X:=-7; Y:=-18 end;    699: begin X:=-3; Y:=-15 end;
      700: begin X:=-4; Y:=-17 end;    701: begin X:=-13; Y:=-19 end;
      704: begin X:=-29; Y:=-27 end;   705: begin X:=-31; Y:=-27 end;
      706: begin X:=-34; Y:=-25 end;   707: begin X:=-35; Y:=-24 end;
      708: begin X:=-33; Y:=-25 end;   709: begin X:=-34; Y:=-26 end;
      712: begin X:=-16; Y:=-29 end;   713: begin X:=-21; Y:=-32 end;
      714: begin X:=-31; Y:=-35 end;   715: begin X:=-37; Y:=-43 end;
      716: begin X:=-32; Y:=-37 end;   717: begin X:=-24; Y:=-36 end;
      720: begin X:=17; Y:=-35 end;    721: begin X:=12; Y:=-42 end;
      722: begin X:=1; Y:=-50 end;     723: begin X:=-7; Y:=-64 end;
      725: begin X:=11; Y:=-46 end;    728: begin X:=33; Y:=-55 end;
      729: begin X:=30; Y:=-75 end;    730: begin X:=19; Y:=-92 end;
      731: begin X:=16; Y:=-81 end;    732: begin X:=23; Y:=-87 end;
      733: begin X:=29; Y:=-69 end;    736: begin X:=27; Y:=-31 end;
      737: begin X:=32; Y:=-56 end;    738: begin X:=36; Y:=-85 end;
      739: begin X:=27; Y:=-80 end;    740: begin X:=37; Y:=-77 end;
      741: begin X:=31; Y:=-53 end;    744: begin X:=13; Y:=-16 end;
      745: begin X:=23; Y:=-30 end;    746: begin X:=36; Y:=-66 end;
      747: begin X:=30; Y:=-74 end;    748: begin X:=35; Y:=-54 end;
      749: begin X:=22; Y:=-27 end;    752: begin X:=1; Y:=-19 end;
      753: begin X:=10; Y:=-20 end;    754: begin X:=23; Y:=-48 end;
      755: begin X:=23; Y:=-68 end;    756: begin X:=22; Y:=-32 end;
      757: begin X:=12; Y:=-20 end;    760: begin X:=-18; Y:=-26 end;
      761: begin X:=-2; Y:=-22 end;    762: begin X:=7; Y:=-40 end;
      763: begin X:=10; Y:=-61 end;    764: begin X:=7; Y:=-23 end;
      765: begin X:=-1; Y:=-22 end;    768: begin X:=-36; Y:=-35 end;
      769: begin X:=-32; Y:=-33 end;   770: begin X:=-14; Y:=-50 end;
      771: begin X:=-1; Y:=-65 end;    772: begin X:=-21; Y:=-38 end;
      773: begin X:=-31; Y:=-32 end;   776: begin X:=-22; Y:=-52 end;
      777: begin X:=-32; Y:=-54 end;   778: begin X:=-23; Y:=-70 end;
      779: begin X:=-3; Y:=-73 end;    780: begin X:=-30; Y:=-62 end;
      781: begin X:=-32; Y:=-49 end;   784: begin X:=16; Y:=-61 end;
      785: begin X:=-3; Y:=-72 end;    786: begin X:=-8; Y:=-86 end;
      787: begin X:=5; Y:=-80 end;     788: begin X:=-11; Y:=-82 end;
      789: begin X:=-4; Y:=-67 end;    792: begin X:=43; Y:=-53 end;
      793: begin X:=33; Y:=-25 end;    794: begin X:=13; Y:=-12 end;
      795: begin X:=-24; Y:=-24 end;   796: begin X:=-42; Y:=-50 end;
      797: begin X:=-25; Y:=-77 end;   798: begin X:=15; Y:=-88 end;
      799: begin X:=39; Y:=-79 end;    800: begin X:=39; Y:=-72 end;
      801: begin X:=-17; Y:=-17 end;   802: begin X:=10; Y:=-42 end;
      803: begin X:=35; Y:=-70 end;    804: begin X:=-23; Y:=-42 end;
      805: begin X:=25; Y:=-57 end;    808: begin X:=35; Y:=-54 end;
      809: begin X:=-51; Y:=-29 end;   810: begin X:=-23; Y:=-43 end;
      811: begin X:=52; Y:=-52 end;    812: begin X:=31; Y:=-44 end;
      813: begin X:=46; Y:=-35 end;    816: begin X:=19; Y:=-42 end;
      817: begin X:=-44; Y:=-48 end;   818: begin X:=-33; Y:=-50 end;
      819: begin X:=26; Y:=-32 end;    820: begin X:=53; Y:=-20 end;
      821: begin X:=50; Y:=-10 end;    824: begin X:=-5; Y:=-46 end;
      825: begin X:=-4; Y:=-66 end;    826: begin X:=-13; Y:=-61 end;
      827: begin X:=-10; Y:=-37 end;   828: begin X:=56; Y:=2 end;
      829: begin X:=35; Y:=5 end;      832: begin X:=-21; Y:=-63 end;
      833: begin X:=23; Y:=-67 end;    834: begin X:=11; Y:=-66 end;
      835: begin X:=-28; Y:=-57 end;   836: begin X:=35; Y:=18 end;
      837: begin X:=-2; Y:=8 end;      840: begin X:=-16; Y:=-82 end;
      841: begin X:=46; Y:=-56 end;    842: begin X:=22; Y:=-62 end;
      843: begin X:=-24; Y:=-80 end;   844: begin X:=-8; Y:=18 end;
      845: begin X:=-51; Y:=-5 end;    848: begin X:=9; Y:=-92 end;
      849: begin X:=51; Y:=-37 end;    850: begin X:=29; Y:=-55 end;
      851: begin X:=-18; Y:=-92 end;   852: begin X:=-55; Y:=4 end;
      853: begin X:=-58; Y:=-24 end;   856: begin X:=31; Y:=-86 end;
      857: begin X:=35; Y:=-21 end;    858: begin X:=29; Y:=-47 end;
      859: begin X:=6; Y:=-85 end;     860: begin X:=-60; Y:=-18 end;
      861: begin X:=-22; Y:=-52 end;   864: begin X:=38; Y:=-42 end;
      865: begin X:=18; Y:=-19 end;    866: begin X:=24; Y:=-66 end;
      867: begin X:=-7; Y:=-45 end;    868: begin X:=-2; Y:=-47 end;
      869: begin X:=26; Y:=-63 end;    872: begin X:=30; Y:=-28 end;
      873: begin X:=-21; Y:=-23 end;   874: begin X:=36; Y:=-55 end;
      875: begin X:=21; Y:=-42 end;    876: begin X:=20; Y:=-42 end;
      877: begin X:=40; Y:=-38 end;    880: begin X:=-10; Y:=-22 end;
      881: begin X:=-41; Y:=-32 end;   882: begin X:=10; Y:=-45 end;
      883: begin X:=45; Y:=-25 end;    884: begin X:=38; Y:=-28 end;
      885: begin X:=39; Y:=-23 end;    888: begin X:=-34; Y:=-41 end;
      889: begin X:=-27; Y:=-44 end;   890: begin X:=-12; Y:=-53 end;
      891: begin X:=52; Y:=-7 end;     892: begin X:=44; Y:=-13 end;
      893: begin X:=5; Y:=-15 end;     896: begin X:=-30; Y:=-70 end;
      897: begin X:=12; Y:=-52 end;    898: begin X:=-17; Y:=-70 end;
      899: begin X:=35; Y:=9 end;      900: begin X:=30; Y:=-2 end;
      901: begin X:=-35; Y:=-17 end;   904: begin X:=-4; Y:=-87 end;
      905: begin X:=28; Y:=-46 end;    906: begin X:=-7; Y:=-88 end;
      907: begin X:=-20; Y:=13 end;    908: begin X:=-19; Y:=1 end;
      909: begin X:=-45; Y:=-47 end;   912: begin X:=11; Y:=-83 end;
      913: begin X:=36; Y:=-35 end;    914: begin X:=-5; Y:=-91 end;
      915: begin X:=-54; Y:=3 end;     916: begin X:=-47; Y:=-6 end;
      917: begin X:=-19; Y:=-74 end;   920: begin X:=30; Y:=-60 end;
      921: begin X:=34; Y:=-23 end;    922: begin X:=8; Y:=-81 end;
      923: begin X:=-48; Y:=-23 end;   924: begin X:=-38; Y:=-29 end;
      925: begin X:=7; Y:=-80 end;     928: begin X:=42; Y:=-69 end;
      929: begin X:=2; Y:=-17 end;     930: begin X:=-33; Y:=-54 end;
      931: begin X:=-6; Y:=-44 end;    932: begin X:=39; Y:=-48 end;
      933: begin X:=2; Y:=-76 end;     934: begin X:=-57; Y:=-27 end;
      935: begin X:=3; Y:=-78 end;     936: begin X:=38; Y:=-48 end;
      937: begin X:=-40; Y:=-23 end;   938: begin X:=-47; Y:=-64 end;
      939: begin X:=-39; Y:=-50 end;   940: begin X:=37; Y:=-33 end;
      941: begin X:=38; Y:=-60 end;    942: begin X:=-41; Y:=-63 end;
      943: begin X:=33; Y:=-62 end;    944: begin X:=20; Y:=-34 end;
      945: begin X:=-51; Y:=-55 end;   946: begin X:=-24; Y:=-88 end;
      947: begin X:=-41; Y:=-74 end;   948: begin X:=-5; Y:=-23 end;
      949: begin X:=60; Y:=-24 end;    950: begin X:=7; Y:=-83 end;
      951: begin X:=52; Y:=-33 end;    952: begin X:=-8; Y:=-40 end;
      953: begin X:=-21; Y:=-83 end;   954: begin X:=11; Y:=-97 end;
      955: begin X:=-8; Y:=-95 end;    956: begin X:=-36; Y:=-33 end;
      957: begin X:=55; Y:=-1 end;     958: begin X:=38; Y:=-74 end;
      959: begin X:=50; Y:=-13 end;    960: begin X:=-27; Y:=-59 end;
      961: begin X:=10; Y:=-91 end;    962: begin X:=27; Y:=-84 end;
      963: begin X:=13; Y:=-97 end;    964: begin X:=-36; Y:=-61 end;
      965: begin X:=17; Y:=14 end;     966: begin X:=48; Y:=-40 end;
      968: begin X:=-20; Y:=-82 end;   969: begin X:=33; Y:=-72 end;
      970: begin X:=36; Y:=-69 end;    971: begin X:=28; Y:=-76 end;
      972: begin X:=-11; Y:=-82 end;   973: begin X:=-44; Y:=11 end;
      974: begin X:=40; Y:=-13 end;    975: begin X:=-38; Y:=-2 end;
      976: begin X:=8; Y:=-93 end;     977: begin X:=47; Y:=-43 end;
      978: begin X:=35; Y:=-56 end;    979: begin X:=36; Y:=-63 end;
      980: begin X:=4; Y:=-82 end;     981: begin X:=-72; Y:=-16 end;
      982: begin X:=18; Y:=-4 end;     983: begin X:=-62; Y:=-25 end;
      984: begin X:=33; Y:=-86 end;    985: begin X:=43; Y:=-26 end;
      986: begin X:=12; Y:=-50 end;    987: begin X:=32; Y:=-51 end;
      988: begin X:=25; Y:=-62 end;    989: begin X:=-48; Y:=-58 end;
      990: begin X:=-28; Y:=-8 end;    991: begin X:=-39; Y:=-62 end;
      992: begin X:=-9; Y:=-83 end;    993: begin X:=-13; Y:=-82 end;
      994: begin X:=-17; Y:=-64 end;   995: begin X:=-23; Y:=-58 end;
      996: begin X:=-12; Y:=-55 end;   997: begin X:=34; Y:=-87 end;
      1000: begin X:=28; Y:=-84 end;  1001: begin X:=26; Y:=-86 end;
      1002: begin X:=-11; Y:=-81 end; 1003: begin X:=-31; Y:=-61 end;
      1004: begin X:=-31; Y:=-69 end; 1005: begin X:=35; Y:=-77 end;
      1008: begin X:=36; Y:=-69 end;  1009: begin X:=36; Y:=-71 end;
      1010: begin X:=11; Y:=-90 end;  1011: begin X:=-12; Y:=-77 end;
      1012: begin X:=-21; Y:=-92 end; 1013: begin X:=24; Y:=-69 end;
      1016: begin X:=32; Y:=-41 end;  1017: begin X:=33; Y:=-45 end;
      1018: begin X:=28; Y:=-85 end;  1019: begin X:=19; Y:=-81 end;
      1020: begin X:=6; Y:=-106 end;  1021: begin X:=8; Y:=-69 end;
      1024: begin X:=20; Y:=-20 end;  1025: begin X:=22; Y:=-23 end;
      1026: begin X:=20; Y:=-69 end;  1027: begin X:=20; Y:=-69 end;
      1028: begin X:=13; Y:=-99 end;  1029: begin X:=-7; Y:=-76 end;
      1032: begin X:=1; Y:=-20 end;   1033: begin X:=6; Y:=-18 end;
      1034: begin X:=10; Y:=-52 end;  1035: begin X:=19; Y:=-55 end;
      1036: begin X:=22; Y:=-78 end;  1037: begin X:=-10; Y:=-87 end;
      1040: begin X:=-32; Y:=-35 end; 1041: begin X:=-29; Y:=-33 end;
      1042: begin X:=3; Y:=-44 end;   1043: begin X:=18; Y:=-51 end;
      1044: begin X:=27; Y:=-64 end;  1045: begin X:=2; Y:=-94 end;
      1048: begin X:=-36; Y:=-61 end; 1049: begin X:=-38; Y:=-59 end;
      1050: begin X:=-2; Y:=-49 end;  1051: begin X:=9; Y:=-54 end;
      1052: begin X:=24; Y:=-55 end;  1053: begin X:=22; Y:=-92 end;
      1056: begin X:=23; Y:=-35 end;  1057: begin X:=6; Y:=-44 end;
      1058: begin X:=28; Y:=-25 end;  1059: begin X:=40; Y:=-36 end;
      1060: begin X:=22; Y:=-7 end;   1061: begin X:=44; Y:=-7 end;
      1062: begin X:=13; Y:=-5 end;   1063: begin X:=31; Y:=10 end;
      1064: begin X:=5; Y:=-6 end;    1065: begin X:=10; Y:=16 end;
      1066: begin X:=-24; Y:=-13 end; 1067: begin X:=-24; Y:=7 end;
      1068: begin X:=-34; Y:=-20 end; 1069: begin X:=-52; Y:=-8 end;
      1070: begin X:=-13; Y:=-30 end; 1071: begin X:=-39; Y:=-26 end;
      1072: begin X:=39; Y:=-25 end;  1073: begin X:=39; Y:=-41 end;
      1074: begin X:=39; Y:=-54 end;  1080: begin X:=26; Y:=-4 end;
      1081: begin X:=33; Y:=-12 end;  1082: begin X:=39; Y:=-21 end;
      1088: begin X:=7; Y:=-2 end;    1089: begin X:=18; Y:=-6 end;
      1090: begin X:=24; Y:=-8 end;   1096: begin X:=-32; Y:=-14 end;
      1097: begin X:=-13; Y:=-10 end; 1098: begin X:=2; Y:=-9 end;
      1104: begin X:=-50; Y:=-31 end; 1105: begin X:=-47; Y:=-22 end;
      1106: begin X:=-40; Y:=-19 end; 1112: begin X:=-28; Y:=-60 end;
      1113: begin X:=-42; Y:=-47 end; 1114: begin X:=-51; Y:=-40 end;
      1120: begin X:=21; Y:=-68 end;  1121: begin X:=-2; Y:=-67 end;
      1122: begin X:=-19; Y:=-67 end; 1128: begin X:=42; Y:=-54 end;
      1129: begin X:=33; Y:=-63 end;  1130: begin X:=27; Y:=-70 end;
      1136: begin X:=30; Y:=-27 end;  1137: begin X:=28; Y:=-20 end;
      1138: begin X:=16; Y:=-59 end;  1139: begin X:=-26; Y:=-62 end;
      1144: begin X:=33; Y:=-17 end;  1145: begin X:=39; Y:=-9 end;
      1146: begin X:=54; Y:=-45 end;  1147: begin X:=53; Y:=-64 end;
      1152: begin X:=20; Y:=-10 end;  1153: begin X:=28; Y:=1 end;
      1154: begin X:=59; Y:=-7 end;   1155: begin X:=85; Y:=-27 end;
      1160: begin X:=5; Y:=-12 end;   1161: begin X:=11; Y:=3 end;
      1162: begin X:=41; Y:=15 end;   1163: begin X:=68; Y:=26 end;
      1168: begin X:=-4; Y:=-17 end;  1169: begin X:=-3; Y:=-2 end;
      1170: begin X:=7; Y:=21 end;    1171: begin X:=21; Y:=50 end;
      1176: begin X:=-19; Y:=-27 end; 1177: begin X:=-21; Y:=-13 end;
      1178: begin X:=-41; Y:=9 end;   1179: begin X:=-30; Y:=40 end;
      1184: begin X:=-22; Y:=-34 end; 1185: begin X:=-26; Y:=-24 end;
      1186: begin X:=-69; Y:=-14 end; 1187: begin X:=-77; Y:=8 end;
      1192: begin X:=-1; Y:=-33 end;  1193: begin X:=-6; Y:=-26 end;
      1194: begin X:=-44; Y:=-42 end; 1195: begin X:=-80; Y:=-27 end;
    end;
  end;

var
  wm: TWMImages;
begin
   m_BodySurface := FrmMain.GetWHumImg(m_btDress,m_btSex ,m_nCurrentFrame, m_nPx, m_nPy, m_CurMagic, m_boCboMode);
   if m_BodySurface = nil then begin
     m_BodySurface := FrmMain.GetWHumImg(0,m_btSex ,m_nCurrentFrame, m_nPx, m_nPy, m_CurMagic, m_boCboMode);
   end;

   if (m_nHairOffset >= 0) then begin
     if not m_boCboMode then m_HairSurface := g_WHairImgImages.GetCachedImage (m_nHairOffset + m_nCurrentFrame, m_nHpx, m_nHpy)
     else begin
       m_HairSurface := g_WCboHairImgImages.GetCachedImage (m_nCboHairOffset + m_nCurrentFrame, m_nHpx, m_nHpy);
     end;
   end else m_HairSurface := nil;
   if (m_btEffect = 50) then begin
     if (m_nCurrentFrame <= 536) then begin
       if (GetTickCount - m_dwFrameTick) > 100 then begin
         if m_nFrame < 19 then Inc(m_nFrame)
         else m_nFrame:=0;
         m_dwFrameTick:=GetTickCount();
       end;
       m_HumWinSurface := g_WEffectImages.GetCachedImage (m_nHumWinOffset + m_nFrame, m_nSpx, m_nSpy);
     end;
   end else if m_nFeature.nDressLook <> High(m_nFeature.nDressLook) then begin
     wm := GetEffectWil(m_nFeature.nDressLookWil);
     if wm <> nil then begin
       if m_nCurrentFrame < 64 then begin
         if (GetTickCount - m_dwFrameTick) > m_dwFrameTime then begin
           if m_nFrame < 7 then Inc(m_nFrame)   //8个动作
           else m_nFrame:=0;
           m_dwFrameTick:=GetTickCount();
         end;
         m_HumWinSurface := wm.GetCachedImage (m_nHumWinOffset + (m_btDir * 8) + m_nFrame, m_nSpx, m_nSpy);
       end else begin
         if not m_boCboMode then begin
           m_HumWinSurface := wm.GetCachedImage (m_nHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
         end else begin
           if wm = g_WHumWing4Images then
             m_HumWinSurface:=g_WCboHumWingImages4.GetCachedImage (m_nCboHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy)
           else
           if wm = g_WHumWing3Images then
             m_HumWinSurface:=g_WCboHumWingImages3.GetCachedImage (m_nCboHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy)
           else if (wm = g_WHumWing2Images) and (m_nFeature.nDressLook > 4799) then
             m_HumWinSurface:=g_WCboHumWingImages2.GetCachedImage (m_nCboHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy)
           else m_HumWinSurface:=g_WCboHumWingImages.GetCachedImage (m_nCboHumWinOffset + m_nCurrentFrame, m_nSpx, m_nSpy);
         end;
       end;
     end;
   end;
   m_WeaponSurface:=FrmMain.GetWWeaponImg(m_btWeapon,m_btSex,m_nCurrentFrame, m_nWpx, m_nWpy, m_boCboMode);
   if m_nFeature.nWeaponLook <> High(m_nFeature.nWeaponLook) then begin
     wm := GetEffectWil(m_nFeature.nWeaponLookWil);
     if wm <> nil then begin
       if not m_boCboMode then begin
         m_WeaponEffSurface := wm.GetCachedImage(m_nWeaponEffOffset + m_nCurrentFrame, m_nEpx, m_nEpy);
         if (m_nFeature.nWeaponLook = 0) and (wm = g_WHumWing2Images) then
           GetNJXY(m_nWeaponEffOffset + m_nCurrentFrame, m_nEpx, m_nEpy);
       end else begin
         if (wm = g_WHumWing2Images) and (m_nFeature.nWeaponLook > 2399) then
           m_WeaponEffSurface := g_WCboHumWingImages2.GetCachedImage(m_nCboWeaponEffOffset + m_nCurrentFrame, m_nEpx, m_nEpy)
         else if wm = g_WWeaponEffectImages4 then
           m_WeaponEffSurface := g_WCboWeaponEffectImages4.GetCachedImage(m_nCboWeaponEffOffset + m_nCurrentFrame, m_nEpx, m_nEpy)
         else if m_nFeature.nWeaponLookWil <> 2 then
           m_WeaponEffSurface := g_WCboHumWingImages.GetCachedImage(m_nCboWeaponEffOffset + m_nCurrentFrame, m_nEpx, m_nEpy)
         else m_WeaponEffSurface := nil;
       end;
     end;
   end;
   if m_WeaponSurface = nil then
     m_WeaponSurface:=FrmMain.GetWWeaponImg(0,m_btSex,m_nCurrentFrame, m_nWpx, m_nWpy, m_boCboMode);
end;
{
7 0 1
6   2
5 4 3
}
procedure  THumActor.DrawStall (dsurface: TDirectDrawSurface; dx, dy: integer);
var
  d: TDirectDrawSurface;
begin
  if m_boIsShop and not m_boDeath then begin
    if m_btDir > 7 then Exit; //当前站立方向 不属于0..7
    d := nil;
    case m_btDir of
      7: begin
        d := g_qingqingImages.Images[16];
        if d <> nil then begin
          dsurface.Draw(dx +  m_nShiftX - 52, dy  + m_nShiftY - 32, d.ClientRect, d);
        end;
      end;
      1: begin
        d := g_qingqingImages.Images[18];
        if d <> nil then begin
          dsurface.Draw(dx + m_nShiftX - 22, dy + m_nShiftY - 25, d.ClientRect, d);
        end;
      end;
      5: begin
        d := g_qingqingImages.Images[17];
        if d <> nil then begin
          dsurface.Draw(dx +  m_nShiftX - 45, dy + m_nShiftY - 10, d.ClientRect, d);
        end;
      end;
      3: begin
        d := g_qingqingImages.Images[15];
        if d <> nil then begin
          dsurface.Draw(dx + m_nShiftX - 24, dy + m_nShiftY - 10, d.ClientRect, d);
        end;
      end;
    end;
  end;
end;
{-----------------------------------------------------------------}
//绘制人物
{-----------------------------------------------------------------}
procedure  THumActor.DrawChr (dsurface: TDirectDrawSurface; dx, dy: integer; blend: Boolean;boFlag:Boolean);
var
   idx, ax, ay: integer;
   d: TDirectDrawSurface;
   ceff: TColorEffect;
   wimg: TWMImages;
   ErrorCode: Integer;
begin
  try
    d := nil;//Jacky
    if m_btDir > 7 then Exit; //当前站立方向 不属于0..7
    if GetTickCount - m_dwLoadSurfaceTime > 60 * 1000 then begin  //60秒释放一次未使用的图片，所以每隔60秒要重新装载一次
      m_dwLoadSurfaceTime := GetTickCount;
      LoadSurface; //重新装载图片到bodysurface
    end;

    ceff := GetDrawEffectValue;//人物显示颜色
    ErrorCode := 3;
    if (m_btRace = 0) or (m_btRace = 1) or (m_btRace = 150) then begin //人类,英雄,人型20080629
      if (m_nCurrentFrame >= 0) and (m_nCurrentFrame <= 599) then m_nWpord := WORDER[m_btSex, m_nCurrentFrame];
      {$IF M2Version <> 2}
      if not g_boHideHumanWing then begin
      {$IFEND}
        //if (m_btEffect <> 0) then begin
        if (m_nFeature.nDressLook <> High(m_nFeature.nDressLook)) or (m_btEffect = 50) then begin
          if ((m_btDir = 3) or (m_btDir = 4) or (m_btDir = 5)) and (m_HumWinSurface <> nil) then begin
            if (g_MySelf = Self) then begin
                   DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 120);
            end else begin;//0x0047CF4D
                if ((g_FocusCret <> nil) or (g_MagicTarget <> nil)) and blend and not boFlag then begin
                   DrawBlend (dsurface,
                              dx + m_nSpx + m_nShiftX,
                              dy + m_nSpy + m_nShiftY,
                              m_HumWinSurface,
                              120);
                end else begin;//0x0047CFD4
                  if boFlag then begin
                     DrawBlend (dsurface,
                                dx + m_nSpx + m_nShiftX,
                                dy + m_nSpy + m_nShiftY,
                                m_HumWinSurface,
                                120);
                  end;//0x0047D03F
                end;
            end;
          end;
        end;//0x0047D03F
      {$IF M2Version <> 2}
      end;
      {$IFEND}
      ErrorCode := 4;
      //先画武器
      if (m_nWpord = 0) and (not blend) and (m_btWeapon >= 2) and (m_WeaponSurface <> nil) {and (not m_boHideWeapon)20080803注释} then begin
         DrawEffSurface (dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);  //漠篮 祸捞 救函窃
          if (m_nFeature.nWeaponLook <> High(m_nFeature.nWeaponLook)) and (m_WeaponEffSurface <> nil){$IF M2Version <> 2} and (not g_boHideWeaponEffect){$IFEND} then
            DrawBlend(dsurface,dx + m_nEpx + m_nShiftX, dy + m_nEpy + m_nShiftY, m_WeaponEffSurface, 120);
      end;
      //画人物
      ErrorCode := 5;
      if m_BodySurface <> nil then begin
         DrawEffSurface (dsurface, m_BodySurface, dx + m_nPx + m_nShiftX, dy + m_nPy + m_nShiftY, blend, ceff);
      end;
      //画头发
      if m_HairSurface <> nil then
         DrawEffSurface (dsurface, m_HairSurface, dx + m_nHpx + m_nShiftX, dy + m_nHpy + m_nShiftY, blend, ceff);
      ErrorCode := 6;
      //后画武器
      if (m_nWpord = 1) and {(not blend) and} (m_btWeapon >= 2) and (m_WeaponSurface <> nil) {and (not m_boHideWeapon)20080803注释} then begin
         DrawEffSurface (dsurface, m_WeaponSurface, dx + m_nWpx + m_nShiftX, dy + m_nWpy + m_nShiftY, blend, ceNone);
          if (m_nFeature.nWeaponLook <> High(m_nFeature.nWeaponLook)) and (m_WeaponEffSurface <> nil) {$IF M2Version <> 2}and not g_boHideWeaponEffect{$IFEND} then
             DrawBlend(dsurface,dx + m_nEpx + m_nShiftX, dy + m_nEpy + m_nShiftY, m_WeaponEffSurface, 120);
      end;
      
      ErrorCode := 7;      
      {$IF M2Version <> 2}
      if not g_boHideHumanWing then begin
      {$IFEND}
        if (m_btEffect = 50) then begin
          if not m_boDeath then begin //20080424 修正凤天死亡不显示光环
            if (m_HumWinSurface <> nil) then
              DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 120);
          end;
        end else
        //if m_btEffect <> 0 then begin
        if m_nFeature.nDressLook <> High(m_nFeature.nDressLook) then begin
          if ((m_btDir = 0) or (m_btDir = 7) or (m_btDir = 1) or (m_btDir = 6)  or (m_btDir = 2)) and (m_HumWinSurface <> nil) then begin
            if g_MySelf = Self then begin
                 DrawBlend (dsurface, dx + m_nSpx + m_nShiftX, dy + m_nSpy + m_nShiftY, m_HumWinSurface, 120);
            end else begin;//0x0047D30D
              if ((g_FocusCret <> nil) or (g_MagicTarget <> nil)) and not boFlag then begin
                   DrawBlend (dsurface,
                              dx + m_nSpx + m_nShiftX,
                              dy + m_nSpy + m_nShiftY,
                              m_HumWinSurface,
                              120);
              end else begin;//0x0047D3A0
                if boFlag then begin
                   DrawBlend (dsurface,
                              dx + m_nSpx + m_nShiftX,
                              dy + m_nSpy + m_nShiftY,
                              m_HumWinSurface,
                              120);
                end;//0x0047D41D
              end;
            end;
          end;
        end;//0x0047D41D
      {$IF M2Version <> 2}
      end;
      {$IFEND}

      ErrorCode := 9;
      if not m_boDeath then begin  //死亡不显示
        if m_nState and $02000000 <> 0 then begin //万剑归宗击中状态
            idx := 4010 + (m_nGenAniCount mod 8);
            d := g_WCboEffectImages.GetCachedImage(idx, ax, ay);
            if d <> nil then
              DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
        end;
        //显示魔法盾时效果
        if m_nState and $00100000{STATE_BUBBLEDEFENCEUP} <> 0 then begin  //林贱狼阜
           if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
              idx := MAGBUBBLESTRUCKBASE + m_nCurBubbleStruck
           else
              idx := MAGBUBBLEBASE + (m_nGenAniCount mod 3);
           d := g_WMagicImages.GetCachedImage (idx, ax, ay);
           if d <> nil then
              DrawBlend (dsurface,
                               dx + ax + m_nShiftX,
                               dy + ay + m_nShiftY,
                               d, 130);

        end;
        {$IF M2Version <> 2}
        if m_nState and $00040000 <> 0 then begin  //粉色魔法盾
           if (m_nCurrentAction = SM_STRUCK) and (m_nCurBubbleStruck < 3) then
              idx := 1845 + m_nCurBubbleStruck
           else
              idx := 1835 + (m_nGenAniCount mod 3);
           d := g_WMagic5Images.GetCachedImage (idx, ax, ay);
           if d <> nil then
              DrawBlend (dsurface,
                               dx + ax + m_nShiftX,
                               dy + ay + m_nShiftY,
                               d, 130);
        end;
        if m_nState and $00020000 <> 0 then begin//心法状态
          idx := 160 + (m_nGenAniCount mod 26);
          d := g_WMagic10Images.GetCachedImage (idx, ax, ay);
          if d <> nil then
            DrawBlend (dsurface, dx + ax + m_nShiftX,
                       dy + ay + m_nShiftY, d, 130);
        end;
        {$IFEND}
        ErrorCode := 8;
        if m_nState and $10000000 <> 0 then begin //小网状态
            idx := 3740 + (m_nGenAniCount mod 10);;
            d := g_WMonImagesArr[23].GetCachedImage(idx, ax, ay);
            if d <> nil then
              DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
        end;
        if m_nState and $00004000 <> 0 then begin //定身状态
            idx := 1080 + (m_nGenAniCount mod 8);
            d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
            if d <> nil then
              DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
        end;
        if m_nState and $00008000 <> 0 then begin//天雷乱舞状态
            idx := 964 + (m_nGenAniCount mod 4);;
            d := g_WMagic10Images.GetCachedImage(idx, ax, ay);
            if d <> nil then
              DrawBlend (dsurface, dx + ax + m_nShiftX, dy + ay + m_nShiftY, d, 150);
        end;
      end;

    end;
    ErrorCode := 10;
    DrawMyShow(dsurface,dx,dy); //显示自身动画   20080229
    ErrorCode := 11;
    //显示魔法效果
    if m_boUseMagic and (m_CurMagic.EffectNumber > 0) then begin
      if m_nCurEffFrame in [0..m_nSpellFrame-1] then begin
         ErrorCode := 15;
         GetEffectBase (m_CurMagic.EffectNumber-1, 0, wimg, idx, m_btDir, m_CurMagic.EffectLevelEx);//取得魔法效果所在图库
         idx := idx + m_nCurEffFrame;//IDx对应WIL文件 里的图片位置，即用技能时显示的动画
         ErrorCode := 16;
         if wimg <> nil then begin
            d := wimg.GetCachedImage (idx, ax, ay);
            ErrorCode := 17;
            {$IF M2Version <> 2}
            if m_CurMagic.EffectLevelEx = 0 then
              case m_CurMagic.EffectNumber of //技能坐标错位
                115: begin //粉色噬血术
                  if g_WMagic2Images <> nil then
                    g_WMagic2Images.GetCachedImage(idx-25, ax, ay);
                end;
                116: begin //粉色四级噬血术
                  if g_WMagic2Images <> nil then
                    g_WMagic2Images.GetCachedImage(idx+15, ax, ay);
                end;
                117: begin //粉色无极真气
                  if g_WMagic2Images <> nil then
                    g_WMagic2Images.GetCachedImage(idx-1015, ax, ay);
                end;
              end;
            {$IFEND}
           if d <> nil then begin
              ErrorCode := 18;
              DrawBlend (dsurface,
                               dx + ax + m_nShiftX,
                               dy + ay + m_nShiftY,
                               d, 160);
           end;
         end;
      end;
    end;
    ErrorCode := 12;
    {----------------------------------------------------------------------------}
    //显示攻击效果              2007.10.31 updata
    //m_boHitEffect 是否是攻击类型
    //m_nHitEffectNumber  使用攻击的数组 取出图的号
    //m_btDir  方向
    //m_nCurrentFrame 当前的桢数   m_nStartFrame开始的桢数
    {----------------------------------------------------------------------------}
    if m_boHitEffect and (m_nHitEffectNumber > 0) then begin
      GetEffectBase (m_nHitEffectNumber - 1, 1, wimg, idx, m_btDir, 0);
      {$IF M2Version <> 2}
      if m_nHitEffectNumber <> 21 then begin
      {$IFEND}
      if m_nHitEffectNumber in [8,15] then idx := idx{开始的号} + m_btDir{方向}*20 + (m_nCurrentFrame-m_nStartFrame){龙影剑法}
      else idx := idx{开始的号} + m_btDir{方向}*10 + (m_nCurrentFrame-m_nStartFrame);
       if wimg <> nil then
         d := wimg.GetCachedImage (idx, ax, ay);
      {$IF M2Version <> 2}
      end;
      case m_nHitEffectNumber of //技能坐标错位
        20: begin //粉色刺杀剑术
          ax := ax + 20;
          ay := ay - 10;
        end;
        21: begin //粉色烈火剑法
           idx := idx + m_btDir*7 + (m_nCurrentFrame-m_nStartFrame);
           if wimg <> nil then
             d := wimg.GetCachedImage (idx, ax, ay);
          ax := ax + 24;
          ay := ay - 27;
        end;
        22: begin //粉色逐日剑法
          ax := ax + 25;
          ay := ay - 8
        end;
      end;
      {$IFEND}
      if d <> nil then
         DrawBlend (dsurface,
                          dx + ax + m_nShiftX,
                          dy + ay + m_nShiftY,
                          d, 200);
    end;
    ErrorCode := 13;
    //显示武器效果
    if m_boWeaponEffect then begin
      idx := WPEFFECTBASE + m_btDir * 10 + m_nCurWeaponEffect;
      d := g_WMagicImages.GetCachedImage (idx, ax, ay);
      if d <> nil then
         DrawBlend (dsurface,
                     dx + ax + m_nShiftX,
                     dy + ay + m_nShiftY,
                     d, 200);
    end;
    ErrorCode := 14;
  except
    DebugOutStr('THumActor.DrawChr'+IntToStr(ErrorCode));
  end;
end;

function TActor.FindMsg(wIdent: Word): Boolean;
var
  I: Integer;
  Msg: pTChrMsg;
begin
  Result := FALSE;
  m_MsgList.Lock;
  try
    for I := 0 to m_MsgList.Count - 1 do begin
      Msg := m_MsgList.Items[I];
      if (Msg.ident = wIdent) then begin
        Result := True;
        Break;
      end;
    end;
  finally
    m_MsgList.UnLock;
  end;
end;

end.