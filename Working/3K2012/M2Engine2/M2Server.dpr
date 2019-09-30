program M2Server;

uses
  //FastMM4,开了假死By TasNat at: 2012-11-03 13:07:29
  Forms,
  Windows,
  svMain in 'svMain.pas' {FrmMain},
  LocalDB in 'LocalDB.pas' {FrmDB},
  IdSrvClient in 'IdSrvClient.pas' {FrmIDSoc},
  FSrvValue in 'FSrvValue.pas' {FrmServerValue},
  UsrEngn in 'UsrEngn.pas',
  ObjNpc in 'ObjNpc.pas',
  ObjMon2 in 'ObjMon2.pas',
  ObjMon in 'ObjMon.pas',
  ObjGuard in 'ObjGuard.pas',
  ObjBase in 'ObjBase.pas',
  ObjAxeMon in 'ObjAxeMon.pas',
  Magic in 'Magic.pas',
  M2Share in 'M2Share.pas',
  ItmUnit in 'ItmUnit.pas',
  FrnEngn in 'FrnEngn.pas',
  Event in 'Event.pas',
  Envir in 'Envir.pas',
  Castle in 'Castle.pas',
  RunDB in 'RunDB.pas',
  RunSock in 'RunSock.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Mudutil in '..\Common\Mudutil.pas',
  PlugIn in 'PlugIn.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  GameConfig in 'GameConfig.pas' {frmGameConfig},
  FunctionConfig in 'FunctionConfig.pas' {frmFunctionConfig},
  ObjRobot in 'ObjRobot.pas',
  ViewSession in 'ViewSession.pas' {frmViewSession},
  ViewOnlineHuman in 'ViewOnlineHuman.pas' {frmViewOnlineHuman},
  ViewLevel in 'ViewLevel.pas' {frmViewLevel},
  ViewList in 'ViewList.pas' {frmViewList},
  OnlineMsg in 'OnlineMsg.pas' {frmOnlineMsg},
  HumanInfo in 'HumanInfo.pas' {frmHumanInfo},
  ViewKernelInfo in 'ViewKernelInfo.pas' {frmViewKernelInfo},
  ConfigMerchant in 'ConfigMerchant.pas' {frmConfigMerchant},
  ItemSet in 'ItemSet.pas' {frmItemSet},
  ConfigMonGen in 'ConfigMonGen.pas' {frmConfigMonGen},
  PlugInManage in 'PlugInManage.pas' {ftmPlugInManage},
  GameCommand in 'GameCommand.pas' {frmGameCmd},
  MonsterConfig in 'MonsterConfig.pas' {frmMonsterConfig},
  ActionSpeedConfig in 'ActionSpeedConfig.pas' {frmActionSpeed},
  EDcode in '..\Common\EDcode.pas',
  CastleManage in 'CastleManage.pas' {frmCastleManage},
  Common in '..\Common\Common.pas',
  AttackSabukWallConfig in 'AttackSabukWallConfig.pas' {FrmAttackSabukWall},
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  ObjPlayMon in 'ObjPlayMon.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  Guild in 'Guild.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  DESTR in '..\Common\DESTR.pas',
  ObjPlayRobot in 'ObjPlayRobot.pas',
  ObjHero in 'ObjHero.pas',
  SDK in '..\Common\SDK.pas',
  HeroConfig in 'HeroConfig.pas' {frmHeroConfig},
  PlugOfEngine in 'PlugOfEngine.pas',
  DESCrypt in 'DESCrypt.pas',
  ViewList2 in 'ViewList2.pas' {frmViewList2},
  GuildManage in 'GuildManage.pas' {frmGuildManage},
  EngineRegister in 'EngineRegister.pas' {FrmRegister},
  PathFind in 'PathFind.pas',
  ObjAIPlayObject in 'ObjAIPlayObject.pas',
  MapPoint in 'MapPoint.pas',
  Division in 'Division.pas',
  DivisionManage in 'DivisionManage.pas' {FrmDivisionManage};

//------------------------------------------------------------------------------
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                {PlugOfEngine}//引擎输出函数
exports
  MainOutMessageAPI Name 'MainOutMessageAPI',
  TBaseObject_WAbility Name 'TBaseObject_WAbility',
  TBaseObject_boDeath Name 'TBaseObject_boDeath',
  TBaseObject_SendRefMsg Name 'TBaseObject_SendRefMsg',
  TBaseObject_IsProperTarget Name 'TBaseObject_IsProperTarget',
  TBaseObject_GetAttackPower Name 'TBaseObject_GetAttackPower',
  TBaseObject_MagMakeDefenceArea Name 'TBaseObject_MagMakeDefenceArea',
  TBaseObject_MagBubbleDefenceUp Name 'TBaseObject_MagBubbleDefenceUp',
  TPlayObject_IsEnoughBag Name 'TPlayObject_IsEnoughBag',
  TPlayObject_SendSocket Name 'TPlayObject_SendSocket',
  TPlayObject_SendAddItem Name 'TPlayObject_SendAddItem',
  TPlayObject_SendDelItem Name 'TPlayObject_SendDelItem',
  THeroObject_SendDelItem Name 'THeroObject_SendDelItem',
  TPlayObject_GetPlayObjectTick Name 'TPlayObject_GetPlayObjectTick',
  TPlayObject_SetPlayObjectTick Name 'TPlayObject_SetPlayObjectTick',
  TPlayObject_PlayUseItems Name 'TPlayObject_PlayUseItems',
  TUserEngine_GetPlayObject Name 'TUserEngine_GetPlayObject',
  TUserEngine_GetPlayObjectCount Name 'TUserEngine_GetPlayObjectCount',
  TUserEngine_GetStdItemByName Name 'TUserEngine_GetStdItemByName',
  TUserEngine_GetStdItemByIndex Name 'TUserEngine_GetStdItemByIndex',
  TUserEngine_CopyToUserItemFromName Name 'TUserEngine_CopyToUserItemFromName',
  TUserEngine_GetStdItemList Name 'TUserEngine_GetStdItemList',
  TUserEngine_GetMagicList Name 'TUserEngine_GetMagicList',
  TUserEngine_AddMagic Name 'TUserEngine_AddMagic',
  TPlugOfEngine_GetUserVersion Name 'TPlugOfEngine_GetUserVersion',
  TPlugOfEngine_GetProductVersion Name 'TPlugOfEngine_GetProductVersion',
  TPlugOfEngine_HealthSpellChanged Name 'TPlugOfEngine_HealthSpellChanged', //20080416
  TPlugOfEngine_GetUserName Name 'TPlugOfEngine_GetUserName',//20081203
  TPlugOfEngine_GetUserMode Name 'TPlugOfEngine_GetUserMode',
  TPlugOfEngine_GetUserNameInit Name 'TPlugOfEngine_GetUserNameInit',
  TPlugOfEngine_HealthSpellChanged1 Name 'TPlugOfEngine_HealthSpellChanged1';
//------------------------------------------------------------------------------
{$R *.res}

procedure Start();
begin

  //System.ReportMemoryLeaksOnShutdown := True;
  g_Config.nServerFile_CRCA := CalcFileCRC(Application.ExeName);
  Application.Initialize;
  Application.HintPause := 100;
  Application.HintShortPause := 100;
  Application.HintHidePause := 5000;
  Application.CreateForm(TFrmMain, FrmMain);
  {$IF UserMode1 = 2}
{$ELSE}
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
{$IFEND}
  //Application.CreateForm(TFrmMsgClient, FrmMsgClient);//20101022 注释
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
  Application.Run;
end;

{$IF UserMode1 = 2}
begin
  Start();
{$ELSE}
asm
  jz @@Start
  jnz @@Start
  db 0E8h
@@Start:
  lea eax,Start
  call eax
  jz @@end
  jnz @@end
  db 0F4h
  db 0FFh
@@end:
{$IFEND}
end.

